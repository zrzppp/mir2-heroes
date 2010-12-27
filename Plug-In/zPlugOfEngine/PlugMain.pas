unit PlugMain;

interface
uses
  Windows, SysUtils, EngineInterface, ExtCtrls, Classes;
procedure InitPlug();
procedure UnInitPlug();
function StartPlug(): Boolean;
procedure ShortStringToPChar(S: PTShortString; pszDest: PChar);
implementation

uses PlayUserCmd, NpcScriptCmd, PlugShare, PlayUser, FunctionConfig;

procedure ShortStringToPChar(S: PTShortString; pszDest: PChar);
begin
  Move(S.Strings, pszDest^, S.btLen);
  pszDest[S.btLen] := #0;
end;

procedure InitPlug();
begin
  InitPlayUserCmd();
  InitNpcScriptCmd();
  InitPlayUser();
  InitUserConfig();
  InitSuperRock();
  InitMsgFilter();
end;

procedure UnInitPlug();
begin
  UnInitPlayUserCmd();
  UnInitNpcScriptCmd();
  UnInitPlayUser();
  UnInitSuperRock();
  UnInitMsgFilter();
end;

function StartPlug(): Boolean;
begin
  Result := TRUE;
end;

end.

