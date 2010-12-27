unit Share;

interface
uses
  Windows, SysUtils, Classes, EngineInterface;
type
  TPlugConfig = record
    sPlugName: string[50]; // '飞尔世界脚本扩展插件';
    sLoadPlugSucced: string[50]; // '加载飞尔世界脚本扩展插件成功...';
    sLoadPlugFail: string[50]; // '加载飞尔世界脚本扩展插件失败...';
    sUnLoadPlug: string[50]; // '卸载飞尔世界扩展扩展插件成功...';
    sLabelMsg: string[255];
    sPassWord: string[100];
  end;
  pTPlugConfig = ^TPlugConfig;
var
  g_PlugEngine: TPlugEngine;
procedure MainOutMessage(Msg: string; nMode: Integer);
implementation

procedure MainOutMessage(Msg: string; nMode: Integer);
begin
  if Assigned(g_PlugEngine.MsgProc) then begin
    g_PlugEngine.MsgProc(PChar(Msg), Length(Msg), nMode);
  end;
end;

end.

