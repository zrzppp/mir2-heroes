unit SDK;

interface
uses
  Windows, SysUtils, Classes, EngineInterface;
type
  TMsgProc = procedure(Msg: PChar; nMsgLen: Integer; nMode: Integer); stdcall;

procedure DeCryptScript(Src: PChar; Dest: PChar; nSrc: Integer); stdcall;
function Init(PlugEngine: pTPlugEngine): PChar; stdcall;
procedure UnInit(); stdcall;
procedure Config; stdcall;

implementation
uses PlugMain, Share;

procedure DeCryptScript(Src: PChar; Dest: PChar; nSrc: Integer);
var
  sEncode: string;
  sDecode: string;
begin
  try
    SetLength(sEncode, nSrc);
    Move(Src^, sEncode[1], nSrc);
    sDecode := DeCodeText(sEncode);
    if sDecode <> '' then
      Move(sDecode[1], Dest^, Length(sDecode));
  except
    Dest := nil;
  end;
end;

function Init(PlugEngine: pTPlugEngine): PChar;
begin
  g_PlugEngine := PlugEngine^;
  Result := InitPlug();
end;

procedure UnInit();
begin
  UnInitPlug();
end;

procedure Config;
begin
  //MainOutMessage('Config1:' + g_PlugConfig.sPassWord, 0);
  if g_PlugConfig.sPassWord <> '' then begin
    //MainOutMessage('Config2:' + g_PlugConfig.sPassWord, 0);
    TF00005;
  end else begin
    //MainOutMessage('Config3:' + g_PlugConfig.sPassWord, 0);
    TF00004;
  end;
end;

end.

