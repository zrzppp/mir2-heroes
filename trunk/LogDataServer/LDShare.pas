unit LDShare;

interface
uses
  Windows, Messages, SysUtils;
type
  TCmd = record
    Cmd: Integer;
    Check: Boolean;
    Text: string;
  end;

  TLogData = record
    nIndx: Integer;
    nServerNumber: Integer;
    nServerIndex: Integer;
    nAct: Integer;
    sMapName: string;
    nX: Integer;
    nY: Integer;
    sObjectName: string;
    sItemName: string;
    nCount: Integer;
    boPalyObject: Boolean;
    sActObjectName: string;
    sDate: string;
  end;
  pTLogData = ^TLogData;

var
  sBaseDir: string = '.\BaseDir';
  sServerName: string = '传奇';
  sCaption: string = '引擎日志服务器';

  nServerPort: Integer = 10000;
  g_dwGameCenterHandle: THandle;
const
  tLogServer = 2;
procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
function IntToString(nInt: Integer): string;
implementation

uses Grobal2, HUtil32;

function IntToString(nInt: Integer): string;
begin
  if nInt < 10 then Result := '0' + IntToStr(nInt)
  else Result := IntToStr(nInt);
end;

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
var
  SendData: TCopyDataStruct;
  nParam: Integer;
begin
  nParam := MakeLong(Word(tLogServer), wIdent);
  SendData.cbData := Length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle, WM_COPYDATA, nParam, Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

end.

