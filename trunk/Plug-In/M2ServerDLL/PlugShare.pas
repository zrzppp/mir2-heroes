unit PlugShare;

interface
uses
  Windows, SysUtils, Classes, EngineInterface;
{const
  OptionSize = 2488; }
var
  PlugBuffer: PChar;
  g_PlugEngine: TPlugEngine;
  g_UserManage: TUserManage;
  g_CharObject: TCharObject;
  g_sDomainNameFileName:string;
procedure MainOutMessage(Msg: string; nMode: Integer);
implementation

procedure MainOutMessage(Msg: string; nMode: Integer);
begin
  if Assigned(g_PlugEngine.MsgProc) then begin
    g_PlugEngine.MsgProc(PChar(Msg), Length(Msg), nMode);
  end;
end;

end.

