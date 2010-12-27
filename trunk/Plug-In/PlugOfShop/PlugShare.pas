unit PlugShare;

interface
uses
  Windows, Classes, EngineInterface;
type
  TClientShopItem = record
    btItemType: Byte;
    nBeginIdx: Integer;
    nEndIdx: Integer;
    StdItem: TStdItem; //SIZE 62
    sMemo1: string[20];
    sMemo2: string[150];
  end;
  pTClientShopItem = ^TClientShopItem;

  TShopItem = record
    btItemType: Byte;
    nBeginIdx: Integer;
    nEndIdx: Integer;
    StdItem: TStdItem; //SIZE 62
    sMemo1: string[20];
    sMemo2: string[150];
    boRandomUpgrade: Boolean;
    nAddValueRate: Integer;
    boLimitDay: Boolean;
    nMaxLimitDay: Integer;
  end;
  pTShopItem = ^TShopItem;

  TSendShopItem = record
    btItemType: Byte;
    nBeginIdx: Integer;
    nEndIdx: Integer;
    nPrice: Integer;
    sMemo: string[20];
  end;
  pTSendShopItem = ^TSendShopItem;
var
  g_PlugEngine: TPlugEngine;
  g_ManageNPC: TNormNpc;
  g_FunctionNPC: TNormNpc;
  g_UserManage: TUserManage;
  g_CharObject: TCharObject;
  PlugClass: string = 'Config';
  g_ShopItemList: array[0..5] of Classes.TList;

procedure MainOutMessage(Msg: string; nMode: Integer);
procedure ChgString(var sSrc: string; Src, Dest: Char);
function EncodeBuffer(pszSource: PChar; nSrcLen: Integer): string;
procedure DecodeBuffer(pszSource: PChar; pszDest: PChar; bufsize: Integer);
function EncodeString(pszSource: string): string;
function DeCodeString(pszSource: string): string;
implementation

function EncodeBuffer(pszSource: PChar; nSrcLen: Integer): string;
var
  pszDest: array[0..BUFFERSIZE - 1] of Char;
begin
  FillChar(pszDest, SizeOf(pszDest), #0);
  g_PlugEngine.EngineOut.TEDcode_EncodeBuffer(pszSource, nSrcLen, @pszDest);
  Result := string(pszDest);
end;

procedure DecodeBuffer(pszSource: PChar; pszDest: PChar; bufsize: Integer);
begin
  g_PlugEngine.EngineOut.TEDcode_DecodeBuffer(pszSource, pszDest, bufsize);
end;

function EncodeString(pszSource: string): string;
var
  pszDest: array[0..BUFFERSIZE - 1] of Char;
begin
  FillChar(pszDest, SizeOf(pszDest), #0);
  g_PlugEngine.EngineOut.TEDcode_EncodeString(PChar(pszSource), @pszDest);
  Result := string(pszDest);
end;

function DeCodeString(pszSource: string): string;
var
  pszDest: array[0..BUFFERSIZE - 1] of Char;
begin
  FillChar(pszDest, SizeOf(pszDest), #0);
  g_PlugEngine.EngineOut.TEDcode_DeCodeString(PChar(pszSource), @pszDest);
  Result := string(pszDest);
end;

procedure MainOutMessage(Msg: string; nMode: Integer);
begin
  if Assigned(g_PlugEngine.MsgProc) then begin
    g_PlugEngine.MsgProc(PChar(Msg), Length(Msg), nMode);
  end;
end;

procedure ChgString(var sSrc: string; Src, Dest: Char);
var
  I: Integer;
begin
  for I := 1 to Length(sSrc) do begin
    if sSrc[I] = Src then begin
      sSrc[I] := Dest;
    end;
  end;
end;

end.

