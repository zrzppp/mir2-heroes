unit ProcBinder;
{
  [Warning!]:
    The code length of the Original procedure
  		must be greater than 6 !!

  [2007-7-1]
  	v 1.0.0.0 - The first version.
    [*] TProcList
    [*] TProcBinder
}

interface

type
  TProcItem	= record
    Original, NewProc	: Pointer;
    Backup	: Int64;
  end;
  PProcItem	= ^TProcItem;

  TProcList	= class
  private
    FItems	: array of TProcItem;
    FCount, FCapacity	: Integer;
    function GetItemByAddr(Addr: Pointer): PProcItem;
    function GetItems(Index: Integer): PProcItem;
  protected
    procedure IncCount;
    procedure Backup(var Item: TProcItem); virtual;
    procedure Resume(var Item: TProcItem); virtual;
    procedure Del(Index: Integer); virtual;
  public
    destructor Destroy; override;
    procedure Clear; virtual;

    function Add(Addr: Pointer): Integer; virtual;
    function Delete(Index: Integer): Boolean; overload;
    function Delete(Addr: Pointer): Boolean; overload;

    function AddrToIndex(Addr: Pointer): Integer;
    property Items[Index: Integer]:PProcItem read GetItems;
    property ItemByAddr[Addr: Pointer]:PProcItem read GetItemByAddr; default;
  end;

  TProcBinder	= class
  protected
    FList	: TProcList;
    procedure BindItem(PItem: PProcItem); virtual;
    function GetItem(Original: Pointer): PProcItem;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Bind(Original, NewProc: Pointer);
    function Unbind(Original: Pointer): Boolean;
    function IsBinded(Addr: Pointer): Boolean;
  end;

var
  Binder	: TProcBinder;

implementation

{$IFNDEF LINUX}
uses
  Windows;
{$ENDIF}

procedure WriteProcCode(Proc: Pointer; Buffer: Pointer; Size: Integer);
{$IFDEF LINUX}
{$ELSE}
var
  t	: Cardinal;
{$ENDIF}
begin
{$IFDEF LINUX}
  // I don't know the way in Linux !-.-
  //Move(Buffer^, Proc^, Size);
{$ELSE}
  WriteProcessMemory(GetCurrentProcess, Proc, Buffer, Size, t);
{$ENDIF}
end;

{ TProcList }

function TProcList.Add(Addr: Pointer): Integer;
begin
  Result	:= -1;
  if AddrToIndex(Addr)>=0 then
  	Exit;
  Result	:= FCount;
  IncCount;
  FItems[Result].Original	:= Addr;
  // Backup the Original!
  Backup(FItems[Result]);
end;

function TProcList.AddrToIndex(Addr: Pointer): Integer;
begin
  Result	:= FCount-1;
  while Result>=0 do
  begin
    if FItems[Result].Original=Addr then
    	Exit;
    Dec(Result);
  end;  
end;

procedure TProcList.Backup(var Item: TProcItem);
begin
  with Item do
  begin
    // to backup the Original code (only 8 bytes)
    Backup	:= PInt64(Original)^;
  end;
end;

procedure TProcList.Clear;
var
  i	: Integer;
begin
  for i:=FCount-1 downto 0 do
  	Resume(FItems[i]);
  FCount	:= 0;
  FCapacity	:= 0;
  SetLength(FItems, 0);
end;

procedure TProcList.Del(Index: Integer);
var
  i	: Integer;
begin
  Resume(FItems[Index]);
  Dec(FCount);
  for i:=Index to FCount-1 do
  	FItems[i]	:= FItems[i+1];
end;

function TProcList.Delete(Addr: Pointer): Boolean;
begin
  Result	:= Delete(AddrToIndex(Addr));
end;

function TProcList.Delete(Index: Integer): Boolean;
begin
  Result	:= (Index>=0)and(Index<FCount);
  if Result then
  	Del(Index);
end;

destructor TProcList.Destroy;
begin
  Clear;
  inherited;
end;

function TProcList.GetItemByAddr(Addr: Pointer): PProcItem;
begin
  Result	:= GetItems(AddrToIndex(Addr));
end;

function TProcList.GetItems(Index: Integer): PProcItem;
begin
  Result	:= nil;
  if (Index<0)or(Index>=FCount)then
  	Exit;
  Result	:= @FItems[Index];
end;

procedure TProcList.IncCount;
	function A8(n: Integer): Integer;
  begin
    Dec(n);
    Inc(n, 8);
    Result	:= n and not 7;
  end;  
begin
  Inc(FCount);
  if FCount>=FCapacity then
  begin
    FCapacity	:= A8(FCount+1);
    SetLength(FItems, FCapacity);
  end;
end;

procedure TProcList.Resume(var Item: TProcItem);
begin
  with Item do
  begin
    // Resume the code of the Original what was backuped
    WriteProcCode(Original, @Backup, SizeOf(Backup));
  end;
end;

{ TProcBinder }

procedure TProcBinder.Bind(Original, NewProc: Pointer);
var
  Item	: PProcItem;
begin
  Item	:= GetItem(Original);
  Item.NewProc	:= NewProc;
end;

procedure TProcBinder.BindItem(PItem: PProcItem);
const
  JmpAddr	= $25FF; // x86: jmp []
var
  Buffer	: array[0..5]of Char;
begin
  with PItem^ do
  begin
  	PWord(@Buffer[0])^	:= JmpAddr;
    PInteger(@Buffer[2])^	:= Integer(@NewProc);
    {
    	Now the assemble code of Buffer is like below:
      	jmp [NewProc] // ( Binary code: FF25 [NewProc] )
      So we just change the NewProc to bind.
    }
    WriteProcCode(Original, @Buffer[0], 6);
  end;
end;

constructor TProcBinder.Create;
begin
  FList	:= TProcList.Create;
end;

destructor TProcBinder.Destroy;
begin
  FList.Free;
  inherited;
end;

function TProcBinder.GetItem(Original: Pointer): PProcItem;
begin
  Result	:= FList[Original];
  if Assigned(Result)then
  	Exit;
  with FList do
  Result	:= Items[Add(Original)];
  BindItem(Result);
end;

function TProcBinder.IsBinded(Addr: Pointer): Boolean;
begin
  Result	:= Assigned(FList[Addr]);
end;

function TProcBinder.Unbind(Original: Pointer): Boolean;
begin
  Result	:= FList.Delete(Original);
end;

initialization
  Binder	:= TProcBinder.Create;

finalization
  Binder.Free;

end.
