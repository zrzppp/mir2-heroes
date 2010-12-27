unit PlayUserCmd;

interface
uses
  Windows, Classes, SysUtils, EngineInterface;
procedure InitPlayUserCmd();
procedure UnInitPlayUserCmd();
procedure LoadUserCmdList();
function PlayUserCommand(AObject: TObject; pszCmd, pszParam1, pszParam2, pszParam3, pszParam4, pszParam5, pszParam6, pszParam7: PChar): Boolean; stdcall;
function ProcessUserCmd(AObject: TObject; pszCmd, pszParam1, pszParam2, pszParam3, pszParam4, pszParam5, pszParam6, pszParam7: PChar): Boolean;
var
  OldUserCmd: TObjectUserCmd;
implementation

uses PlugShare, HUtil32, PlayUser;

procedure InitPlayUserCmd();
begin
  OldUserCmd:=g_PlugEngine.PlugOfEngine.GetPlayObjectUserCmd();
  g_PlugEngine.PlugOfEngine.HookPlayObjectUserCmd(PlayUserCommand);
  g_UserCmdList := Classes.TStringList.Create();
  LoadUserCmdList();
end;

procedure UnInitPlayUserCmd();
begin
  g_PlugEngine.PlugOfEngine.HookPlayObjectUserCmd(OldUserCmd);
  g_UserCmdList.Free;
end;

procedure LoadUserCmdList();
var
  I: Integer;
  sFileName: string;
  LoadList: Classes.TStringList;
  sLineText: string;
  sUserCmd: string;
  sCmdNo: string;
  nCmdNo: Integer;
begin
  sFileName := '.\UserCmd.txt';
  if not FileExists(sFileName) then begin
    LoadList := Classes.TStringList.Create();
    LoadList.Add(';引擎插件配置文件');
    LoadList.Add(';命令名称'#9'对应编号');
    LoadList.SaveToFile(sFileName);
    LoadList.Free;
    Exit;
  end;
  g_UserCmdList.Clear;
  LoadList := Classes.TStringList.Create();
  LoadList.LoadFromFile(sFileName);
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then begin
      sLineText := GetValidStr3(sLineText, sUserCmd, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCmdNo, [' ', #9]);
      nCmdNo := Str_ToInt(sCmdNo, -1);
      if (sUserCmd <> '') and (nCmdNo >= 0) then begin
        g_UserCmdList.AddObject(sUserCmd, TObject(nCmdNo));
      end;
    end;
  end;
  LoadList.Free;
end;
//处理游戏命令
//此函数在主程序内置游戏命令处理前调用
//返回值，True/False
//True  则主程序不再往下匹配其它命令退出函数
//False 则说明游戏命令未处理，主程序继续匹配其它命令

function PlayUserCommand(AObject: TObject; pszCmd, pszParam1, pszParam2, pszParam3, pszParam4, pszParam5, pszParam6, pszParam7: PChar): Boolean; stdcall;
begin
  Result := ProcessUserCmd(AObject, pszCmd, pszParam1, pszParam2, pszParam3, pszParam4, pszParam5, pszParam6, pszParam7);
  if not Result and Assigned(OldUserCmd) then begin
    //调用下一个游戏命令处理插件
    Result := OldUserCmd(AObject, pszCmd, pszParam1, pszParam2, pszParam3, pszParam4, pszParam5, pszParam6, pszParam7);
  end;
end;

function ProcessUserCmd(AObject: TObject; pszCmd, pszParam1, pszParam2, pszParam3, pszParam4, pszParam5, pszParam6, pszParam7: PChar): Boolean;
var
  I: Integer;
  sLable: string;
  FunctionNPC: TNormNpc;
begin
  Result := False;
  if (g_UserCmdList = nil) or (g_UserCmdList.Count <= 0) then Exit;
  for I := 0 to g_UserCmdList.Count - 1 do begin
    if CompareText(pszCmd, g_UserCmdList.Strings[I]) = 0 then begin
      //FunctionNPC := TNormNpc_GetFunctionNpc();
      //if FunctionNPC = nil then break;
      sLable := '@UserCmd' + IntToStr(Integer(g_UserCmdList.Objects[I]));
      g_CharObject.BaseObject := AObject;
      g_CharObject.SetUserInPutString(pszParam1);
      g_CharObject.SetUserInPutInteger(Str_ToInt(pszParam1, 0));
      g_CharObject.BaseObject := g_UserManage.m_FunctionNPC;
      g_CharObject.GotoLable(AObject, sLable);
      Result := TRUE;
      break;
    end;
  end;
end;

end.

