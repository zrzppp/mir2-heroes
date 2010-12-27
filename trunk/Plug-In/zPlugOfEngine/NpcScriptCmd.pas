unit NpcScriptCmd;

interface
uses
  Windows, SysUtils, Classes, EngineInterface, PlugShare;
const
  szString = '@@InPutString';
  szInteger = '@@InPutInteger';

  nSC_CHECKONLINEPLAYCOUNT = 10000;
  sSC_CHECKONLINEPLAYCOUNT = 'CHECKONLINEPLAYCOUNT';

  nSC_CHECKPLAYDIELVL = 10001; //杀人后检测
  sSC_CHECKPLAYDIELVL = 'CHECKPLAYDIELVL';
  nSC_CHECKPLAYDIEJOB = 10002;
  sSC_CHECKPLAYDIEJOB = 'CHECKPLAYDIEJOB';
  nSC_CHECKPLAYDIESEX = 10003;
  sSC_CHECKPLAYDIESEX = 'CHECKPLAYDIESEX';

  nSC_CHECKKILLPLAYLVL = 10004; //死亡后检测
  sSC_CHECKKILLPLAYLVL = 'CHECKKILLPLAYLVL';
  nSC_CHECKKILLPLAYJOB = 10005;
  sSC_CHECKKILLPLAYJOB = 'CHECKKILLPLAYJOB';
  nSC_CHECKKILLPLAYSEX = 10006;
  sSC_CHECKKILLPLAYSEX = 'CHECKKILLPLAYSEX';

  nSC_CHECKMAPGUILDCOUNT = 10007;
  sSC_CHECKMAPGUILDCOUNT = 'CHECKMAPGUILDCOUNT';

procedure InitNpcScriptCmd();
procedure UnInitNpcScriptCmd();
function ScriptActionCmd(pszCmd: PChar): Integer; stdcall;
function ScriptConditionCmd(pszCmd: PChar): Integer; stdcall;
procedure CheckUserSelect(Merchant: TMerchant; AObject: TPlayObject; pszLabel, pszData: PChar); stdcall;


procedure ScriptAction(Npc: TObject; PlayObject: TObject; nCmdCode: Integer;
  pszParam1: PChar; nParam1: Integer; pszParam2: PChar; nParam2: Integer;
  pszParam3: PChar; nParam3: Integer; pszParam4: PChar; nParam4: Integer;
  pszParam5: PChar; nParam5: Integer; pszParam6: PChar; nParam6: Integer;
  pszParam7: PChar; nParam7: Integer; pszParam8: PChar; nParam8: Integer;
  pszParam9: PChar; nParam9: Integer; pszParam10: PChar; nParam10: Integer); stdcall;

function ScriptCondition(Npc: TObject; PlayObject: TObject; nCmdCode: Integer;
  pszParam1: PChar; nParam1: Integer; pszParam2: PChar; nParam2: Integer;
  pszParam3: PChar; nParam3: Integer; pszParam4: PChar; nParam4: Integer;
  pszParam5: PChar; nParam5: Integer; pszParam6: PChar; nParam6: Integer;
  pszParam7: PChar; nParam7: Integer; pszParam8: PChar; nParam8: Integer;
  pszParam9: PChar; nParam9: Integer; pszParam10: PChar; nParam10: Integer): Boolean; stdcall;

function ConditionOfCheckOnlinePlayCount(Npc: TObject; pszParam1: PChar; nCount: Integer): Boolean;
function ConditionOfCheckPlaylvl(AObject: TObject; pszParam1: PChar; nParam1: Integer): Boolean;
function ConditionOfCheckPlaySex(AObject: TObject; pszParam1: PChar): Boolean;
function ConditionOfCheckPlayJob(AObject: TObject; pszParam1: PChar): Boolean;
function ConditionOfCheckPlayMapGuildCount(AObject: TObject; pszParam1: PChar; nParam2: Integer): Boolean;
var
  OldScriptActionCmd: TScriptCmd;
  OldScriptConditionCmd: TScriptCmd;
  OldScriptAction: TScriptAction;
  OldScriptCondition: TScriptCondition;
  OldUserSelelt: TObjectActionUserSelect;
implementation
uses HUtil32, PlayUser;

procedure InitNpcScriptCmd();
begin
  OldScriptActionCmd := g_PlugEngine.PlugOfEngine.GetQuestActionScriptCmd();
  OldScriptConditionCmd := g_PlugEngine.PlugOfEngine.GetQuestConditionScriptCmd();
  OldScriptAction := g_PlugEngine.PlugOfEngine.GetActionScriptProcess();
  OldScriptCondition := g_PlugEngine.PlugOfEngine.GetConditionScriptProcess();
  OldUserSelelt := g_PlugEngine.PlugOfEngine.GetPlayObjectUserSelect();

  g_PlugEngine.PlugOfEngine.HookQuestActionScriptCmd(ScriptActionCmd);
  g_PlugEngine.PlugOfEngine.HookQuestConditionScriptCmd(ScriptConditionCmd);
  g_PlugEngine.PlugOfEngine.HookActionScriptProcess(ScriptAction);
  g_PlugEngine.PlugOfEngine.HookConditionScriptProcess(ScriptCondition);
  g_PlugEngine.PlugOfEngine.HookPlayObjectUserSelect(CheckUserSelect);
end;

procedure UnInitNpcScriptCmd();
begin
  g_PlugEngine.PlugOfEngine.HookQuestActionScriptCmd(OldScriptActionCmd);
  g_PlugEngine.PlugOfEngine.HookQuestConditionScriptCmd(OldScriptConditionCmd);
  g_PlugEngine.PlugOfEngine.HookActionScriptProcess(OldScriptAction);
  g_PlugEngine.PlugOfEngine.HookConditionScriptProcess(OldScriptCondition);
  g_PlugEngine.PlugOfEngine.HookPlayObjectUserSelect(OldUserSelelt);
end;

function ConditionOfCheckPlayMapGuildCount(AObject: TObject; pszParam1: PChar; nParam2: Integer): Boolean;
var
  I: Integer;
  szParam1: string;
  cMethod: Char;
  BaseObjectList: Classes.TList;
  BaseObject: TObject;
  GuildList: Classes.TList;
  procedure AddGuild(Guild: TGuild);
  var
    I: Integer;
  begin
    for I := 0 to GuildList.Count - 1 do begin
      if TGuild(GuildList.Items[I]) = Guild then begin
        Exit;
      end;
    end;
    GuildList.Add(Guild);
  end;
begin
  Result := False;
  g_CharObject.BaseObject := AObject;
  if g_CharObject.m_PEnvir <> nil then begin
    BaseObjectList := g_UserManage.EngineOut.List_Create;
    if g_CharObject.GetRangeActorObject(g_CharObject.m_PEnvir, 200, 200, 1000, True, BaseObjectList) > 0 then begin
      GuildList := Classes.TList.Create;
      for I := 0 to g_UserManage.EngineOut.List_Count(BaseObjectList) - 1 do begin
        BaseObject := TActorObject(g_UserManage.EngineOut.List_Get(BaseObjectList, I));
        if g_CharObject.m_btRaceServer = RC_PLAYOBJECT then begin
          if g_CharObject.m_MyGuild <> nil then begin
            AddGuild(g_CharObject.m_MyGuild);
          end;
        end;
      end;
      szParam1 := StrPas(pszParam1);
      if szParam1 <> '' then begin
        cMethod := szParam1[1];
        case cMethod of
          '=': if GuildList.Count = nParam2 then Result := True;
          '>': if GuildList.Count > nParam2 then Result := True;
          '<': if GuildList.Count < nParam2 then Result := True;
        else if GuildList.Count >= nParam2 then Result := True;
        end;
      end;
      GuildList.Free;
    end;
    g_UserManage.EngineOut.List_Free(BaseObjectList);
  end;
end;

function ConditionOfCheckPlaylvl(AObject: TObject; pszParam1: PChar; nParam1: Integer): Boolean;
var
  KillPlayObject: TActorObject;
  m_Abil: TAbility;
  btType: Byte;
  cMethod: Char;
begin
  Result := False;
  g_CharObject.BaseObject := AObject;
  if g_CharObject.m_LastHiter <> nil then begin
    KillPlayObject := g_CharObject.m_LastHiter^;
    g_CharObject.BaseObject := KillPlayObject;
    if g_CharObject.m_btRaceServer = RC_PLAYOBJECT then begin
      m_Abil := g_CharObject.m_WAbil^;
      cMethod := StrPas(pszParam1)[1];
      case cMethod of
        '=': if m_Abil.Level = nParam1 then Result := True;
        '>': if m_Abil.Level > nParam1 then Result := True;
        '<': if m_Abil.Level < nParam1 then Result := True;
      else if m_Abil.Level >= nParam1 then Result := True;
      end;
    end;
  end;
end;

function ConditionOfCheckPlaySex(AObject: TObject; pszParam1: PChar): Boolean;
var
  KillPlayObject: TObject;
  m_Abil: TAbility;
  btType: Byte;
  btSex: Byte;
  sParam1: string;
const
  MAN = 'MAN';
  WOMAN = 'WOMAN';
begin
  Result := False;
  g_CharObject.BaseObject := AObject;
  if g_CharObject.m_LastHiter <> nil then begin
    KillPlayObject := g_CharObject.m_LastHiter^;
    g_CharObject.BaseObject := KillPlayObject;
    if g_CharObject.m_btRaceServer = RC_PLAYOBJECT then begin
      sParam1 := StrPas(pszParam1);
      btSex := g_CharObject.m_btGender;
      case btSex of
        0: if CompareText(sParam1, MAN) = 0 then Result := True;
        1: if CompareText(sParam1, WOMAN) = 0 then Result := True;
      else Result := False;
      end;
    end;
  end;
end;

function ConditionOfCheckPlayJob(AObject: TObject; pszParam1: PChar): Boolean;
var
  KillPlayObject: TObject;
  m_Abil: TAbility;
  btType: Byte;
  btJob: Byte;
  sParam1: string;
const
  WARRIOR = 'WARRIOR';
  WIZARD = 'WIZARD';
  TAOIST = 'TAOIST';
begin
  Result := False;
  g_CharObject.BaseObject := AObject;
  if g_CharObject.m_LastHiter <> nil then begin
    KillPlayObject := g_CharObject.m_LastHiter^;
    g_CharObject.BaseObject := KillPlayObject;
    if g_CharObject.m_btRaceServer = RC_PLAYOBJECT then begin
      sParam1 := StrPas(pszParam1);
      btJob := g_CharObject.m_btJob;
      case btJob of
        0: if CompareText(sParam1, WARRIOR) = 0 then Result := True;
        1: if CompareText(sParam1, WIZARD) = 0 then Result := True;
        2: if CompareText(sParam1, TAOIST) = 0 then Result := True;
      else Result := False;
      end;
    end;
  end;
end;

procedure CheckUserSelect(Merchant: TMerchant; AObject: TPlayObject; pszLabel, pszData: PChar);
var
  sLabel, sData: string;
  nData: Integer;
  nLength: Integer;
  boGotoLabel: Boolean;
begin
  try
    g_CharObject.BaseObject := AObject;
    sLabel := StrPas(pszLabel);
    nLength := CompareText(sLabel, szString);
    if nLength > 0 then begin
      sLabel := Copy(sLabel, length(szString) + 1, nLength);
      sData := StrPas(pszData);
      if not IsFilterMsg(sData, boGotoLabel) then begin
        g_CharObject.SetUserInPutString(pszData);
        g_CharObject.BaseObject := Merchant;
        g_CharObject.GotoLable(AObject, '@InPutString' + sLabel);
      end else begin
        g_CharObject.BaseObject := Merchant;
        g_CharObject.GotoLable(AObject, '@MsgFilter');
      end;
      Exit;
    end else
      nLength := CompareText(sLabel, szInteger);
    if nLength > 0 then begin
      sLabel := Copy(sLabel, length(szInteger) + 1, nLength);
      sData := StrPas(pszData);
      nData := Str_ToInt(sData, -1);
      g_CharObject.SetUserInPutInteger(nData);
      g_CharObject.BaseObject := Merchant;
      g_CharObject.GotoLable(AObject, '@InPutInteger' + sLabel);
      Exit;
    end else begin
      if Assigned(OldUserSelelt) then begin
        OldUserSelelt(Merchant, AObject, pszLabel, pszData);
      end;
    end;
  except
    if Assigned(OldUserSelelt) then begin
      OldUserSelelt(Merchant, AObject, pszLabel, pszData);
    end;
  end;
end;

function ScriptActionCmd(pszCmd: PChar): Integer; stdcall;
begin
  {if StrIComp(pszCmd, sSC_CHECKONLINEPLAYCOUNT) = 0 then begin
    Result := nGIVEUSERITEM;
  end else
    if StrIComp(pszCmd, szTAKEUSERITEM) = 0 then begin
    Result := nTAKEUSERITEM;
  end else begin
    Result := -1;
  end; }
  if (Result < 0) and Assigned(OldScriptActionCmd) then begin
    Result := OldScriptActionCmd(pszCmd);
  end;
end;

function ScriptConditionCmd(pszCmd: PChar): Integer; stdcall;
begin
  if StrIComp(pszCmd, sSC_CHECKONLINEPLAYCOUNT) = 0 then begin
    Result := nSC_CHECKONLINEPLAYCOUNT;
  end else
    if StrIComp(pszCmd, sSC_CHECKMAPGUILDCOUNT) = 0 then begin
    Result := nSC_CHECKMAPGUILDCOUNT;
  end else begin
    Result := -1;
  end;
  if (Result < 0) and Assigned(OldScriptConditionCmd) then begin
    //调用下一个插件处理函数
    Result := OldScriptConditionCmd(pszCmd);
  end;
end;

procedure ActionOfGiveUserItem(Npc: TObject; PlayObject: TObject; pszItemName: PChar; nCount: Integer);
begin

end;

procedure ActionOfTakeUserItem(Npc: TObject; PlayObject: TObject; pszItemName: PChar; nCount: Integer);
begin

end;

function ConditionOfCheckOnlinePlayCount(Npc: TObject; pszParam1: PChar; nCount: Integer): Boolean;
var
  cMethod: Char;
  szParam1: string;
begin
  Result := False;
  szParam1 := StrPas(pszParam1);
  cMethod := szParam1[1];
  case cMethod of
    '=': if g_UserManage.m_PlayObjectCount = nCount then Result := True;
    '>': if g_UserManage.m_PlayObjectCount > nCount then Result := True;
    '<': if g_UserManage.m_PlayObjectCount < nCount then Result := True;
  else if g_UserManage.m_PlayObjectCount >= nCount then Result := True;
  end;
end;

procedure ScriptAction(Npc: TObject; PlayObject: TObject; nCmdCode: Integer;
  pszParam1: PChar; nParam1: Integer; pszParam2: PChar; nParam2: Integer;
  pszParam3: PChar; nParam3: Integer; pszParam4: PChar; nParam4: Integer;
  pszParam5: PChar; nParam5: Integer; pszParam6: PChar; nParam6: Integer;
  pszParam7: PChar; nParam7: Integer; pszParam8: PChar; nParam8: Integer;
  pszParam9: PChar; nParam9: Integer; pszParam10: PChar; nParam10: Integer); stdcall;
begin
  {case nCmdCode of
    nGIVEUSERITEM: ActionOfGiveUserItem(Npc, PlayObject, pszParam1, nParam2);
    nTAKEUSERITEM: ActionOfTakeUserItem(Npc, PlayObject, pszParam1, nParam2);
  end; }
end;

function ScriptCondition(Npc: TObject; PlayObject: TObject; nCmdCode: Integer;
  pszParam1: PChar; nParam1: Integer; pszParam2: PChar; nParam2: Integer;
  pszParam3: PChar; nParam3: Integer; pszParam4: PChar; nParam4: Integer;
  pszParam5: PChar; nParam5: Integer; pszParam6: PChar; nParam6: Integer;
  pszParam7: PChar; nParam7: Integer; pszParam8: PChar; nParam8: Integer;
  pszParam9: PChar; nParam9: Integer; pszParam10: PChar; nParam10: Integer): Boolean; stdcall;
begin
  Result := True;
  try
    case nCmdCode of
      nSC_CHECKONLINEPLAYCOUNT: if not ConditionOfCheckOnlinePlayCount(Npc, pszParam1, nParam2) then Result := False;
      nSC_CHECKPLAYDIELVL,
        nSC_CHECKKILLPLAYLVL: if not ConditionOfCheckPlaylvl(PlayObject, pszParam1, nParam1) then Result := False;
      nSC_CHECKPLAYDIEJOB,
        nSC_CHECKKILLPLAYJOB: if not ConditionOfCheckPlayJob(PlayObject, pszParam1) then Result := False;
      nSC_CHECKPLAYDIESEX,
        nSC_CHECKKILLPLAYSEX: if not ConditionOfCheckPlaySex(PlayObject, pszParam1) then Result := False;

      nSC_CHECKMAPGUILDCOUNT: if not ConditionOfCheckPlayMapGuildCount(PlayObject, pszParam1, nParam2) then Result := False;
    end;
  except
    Result := False;
  end;
end;

end.

