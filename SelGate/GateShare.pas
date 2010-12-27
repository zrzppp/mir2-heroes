unit GateShare;

interface
uses
  Windows, Messages, Classes, SysUtils, Common, Grobal2, HUtil32, EncryptUnit;
type
  {===================================TGList===================================}

  TGList = class(TList)
  private
    CriticalSection: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
  end;

  {=================================TGStringList================================}
  TGStringList = class(TStringList)
  private
    CriticalSection: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
  end;

var
  g_dwGameCenterHandle: THandle;
function GetUserDataType(Msg: string): Integer;
procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
implementation
function GetUserDataType(Msg: string): Integer;
var
  sDefMsg: string;
  sData: string;
  DefMsg: TDefaultMessage;
  sReceiveMsg: string;
  sMsg: string;
begin
  Result := -1;
  sReceiveMsg := Msg;
  if (Pos('!', sReceiveMsg) > 0) and (Length(sReceiveMsg) >= 2) then begin
    sReceiveMsg := ArrestStringEx(sReceiveMsg, '#', '!', sMsg);
    if sMsg <> '' then begin
      if Length(sMsg) >= DEFBLOCKSIZE + 1 then begin
        sMsg := Copy(sMsg, 2, Length(sMsg) - 1);
        sDefMsg := Copy(sMsg, 1, DEFBLOCKSIZE);
        sData := Copy(sMsg, DEFBLOCKSIZE + 1, Length(sMsg) - DEFBLOCKSIZE);
        DefMsg := DecodeMessage(sDefMsg);
        Result := DefMsg.ident;
      end;
    end;
  end;
end;
{ TGList }
constructor TGList.Create;
begin
  inherited;
  InitializeCriticalSection(CriticalSection);
end;

destructor TGList.Destroy;
begin
  DeleteCriticalSection(CriticalSection);
  inherited;
end;

procedure TGList.Lock;
begin
  EnterCriticalSection(CriticalSection);
end;

procedure TGList.UnLock;
begin
  LeaveCriticalSection(CriticalSection);
end;

{ TGStringList }

constructor TGStringList.Create;
begin
  inherited;
  InitializeCriticalSection(CriticalSection);
end;

destructor TGStringList.Destroy;
begin
  DeleteCriticalSection(CriticalSection);
  inherited;
end;

procedure TGStringList.Lock;
begin
  EnterCriticalSection(CriticalSection);
end;

procedure TGStringList.UnLock;
begin
  LeaveCriticalSection(CriticalSection);
end;

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
var
  SendData: TCopyDataStruct;
  nParam: Integer;
begin
  nParam := MakeLong(Word(tSelGate), wIdent);
  SendData.cbData := Length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle, WM_COPYDATA, nParam, Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

initialization
  begin

  end;
finalization
  begin

  end;
end.
