unit SDK;

interface
uses
  Windows, SysUtils, Classes, EngineInterface;
type
  TMsgProc = procedure(Msg: PChar; nMsgLen: Integer; nMode: Integer); stdcall;

procedure MainOutMessage(Msg: string; nMode: Integer);
procedure GetIPLocal(sIPaddr: PChar; sLocal: PChar; nLocalLen: Integer); stdcall;
function Init(PlugEngine: pTPlugEngine): PChar; stdcall;
procedure UnInit(); stdcall;
procedure Config; stdcall;
var
  g_PlugEngine: TPlugEngine;
implementation
uses PlugMain, QueryIP, Share;

procedure MainOutMessage(Msg: string; nMode: Integer);
begin
  if Assigned(g_PlugEngine.MsgProc) then begin
    g_PlugEngine.MsgProc(PChar(Msg), Length(Msg), nMode);
  end;
end;

procedure GetIPLocal(sIPaddr: PChar; sLocal: PChar; nLocalLen: Integer);
var
  sIpLocal, sIPaddress: string;
begin
  try
    SetLength(sIPaddress, 15);
    Move(sIPaddr^, sIPaddress[1], 15);
    //sIPaddress := StrPas(sIPaddr);
    sIpLocal := SearchIPLocal(sIPaddress);
    //if
    Move(sIpLocal[1], sLocal^, Length(sIpLocal));
  except
  end;
end;

function Init(PlugEngine: pTPlugEngine): PChar;
begin
  g_PlugEngine := PlugEngine^;
  g_PlugEngine.PlugOfEngine.HookIPLocal(GetIPLocal);
  InitPlug(g_PlugEngine.AppHandle);
  Result := PChar(sPlugName);
end;

procedure UnInit();
begin
  MainOutMessage(sUnLoadPlug, 0);
end;

procedure Config;
begin
  FrmQueryIP := TFrmQueryIP.Create(nil);
  FrmQueryIP.ShowModal;
  FrmQueryIP.Free;
end;

end.

