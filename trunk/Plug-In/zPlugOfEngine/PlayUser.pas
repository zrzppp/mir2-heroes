unit PlayUser;

interface
uses
  Windows, Classes, SysUtils, StrUtils, ExtCtrls, EngineInterface;
const
  MAXBAGITEM = 46;
  RM_MENU_OK = 10309;

procedure InitPlayUser();
procedure UnInitPlayUser();
procedure LoadCheckItemList();
procedure UnLoadCheckItemList();

procedure InitMsgFilter();
procedure UnInitMsgFilter();
procedure LoadMsgFilterList();
procedure UnLoadMsgFilterList();

procedure InitSuperRock();
procedure UnInitSuperRock();

procedure SuperRock(BaseObject: TObject); stdcall;

function IsFilterMsg(var sMsg: string; var boGotoLabel: Boolean): Boolean;
function FilterMsg(PlayObject: TObject; pszSrcMsg, pszDestMsg: PChar; var boGotoLabel: Boolean): Boolean; stdcall;

function CheckCanDropItem(PlayObject: TPlayObject; pszItemName: PChar; boHintMsg: Boolean): Boolean; stdcall;
function CheckCanDealItem(PlayObject: TPlayObject; pszItemName: PChar; boHintMsg: Boolean): Boolean; stdcall;
function CheckCanStorageItem(PlayObject: TPlayObject; pszItemName: PChar; boHintMsg: Boolean): Boolean; stdcall;
function CheckCanRepairItem(PlayObject: TPlayObject; pszItemName: PChar; boHintMsg: Boolean): Boolean; stdcall;

function CheckCanUpgradeItem(PlayObject: TPlayObject; pszItemName: PChar; boHintMsg: Boolean): Boolean; stdcall;
function CheckCanSellItem(PlayObject: TPlayObject; pszItemName: PChar; boHintMsg: Boolean): Boolean; stdcall;
function CheckCanNotScatterItem(PlayObject: TPlayObject; pszItemName: PChar; boHintMsg: Boolean): Boolean; stdcall;
function CheckCanDieScatterItem(PlayObject: TPlayObject; pszItemName: PChar; boHintMsg: Boolean): Boolean; stdcall;

procedure CheckCanOffLineTakeItem(BaseObject: TBaseObject); stdcall;
var
  OldCheckCanDropItem: TObjectActionItem;
  OldCheckCanDealItem: TObjectActionItem;
  OldCheckCanStorageItem: TObjectActionItem;
  OldCheckCanRepairItem: TObjectActionItem;
  OldCheckCanUpgradeItem: TObjectActionItem;
  OldCheckCanSellItem: TObjectActionItem;
  OldCheckCanNotScatterItem: TObjectActionItem;
  OldCheckCanDieScatterItem: TObjectActionItem;
  OldCheckCanOffLineTakeItem: TObjectAction;
implementation

uses HUtil32, PlugShare;

const
  TextChars = [#32..#255];

procedure InitPlayUser();
begin
  LoadCheckItemList();
  OldCheckCanDropItem := g_PlugEngine.PlugOfEngine.GetCheckCanDropItem();
  OldCheckCanDealItem := g_PlugEngine.PlugOfEngine.GetCheckCanDealItem();
  OldCheckCanStorageItem := g_PlugEngine.PlugOfEngine.GetCheckCanStorageItem();
  OldCheckCanRepairItem := g_PlugEngine.PlugOfEngine.GetCheckCanRepairItem();
  OldCheckCanUpgradeItem := g_PlugEngine.PlugOfEngine.GetCheckCanUpgradeItem();
  OldCheckCanSellItem := g_PlugEngine.PlugOfEngine.GetCheckCanSellItem();
  OldCheckCanNotScatterItem := g_PlugEngine.PlugOfEngine.GetCheckNotCanScatterItem();
  OldCheckCanDieScatterItem := g_PlugEngine.PlugOfEngine.GetCheckCanDieScatterItem();
  OldCheckCanOffLineTakeItem := g_PlugEngine.PlugOfEngine.GetObjectOffLine();

  g_PlugEngine.PlugOfEngine.HookCheckCanDropItem(CheckCanDropItem);
  g_PlugEngine.PlugOfEngine.HookCheckCanDealItem(CheckCanDealItem);
  g_PlugEngine.PlugOfEngine.HookCheckCanStorageItem(CheckCanStorageItem);
  g_PlugEngine.PlugOfEngine.HookCheckCanRepairItem(CheckCanRepairItem);
  g_PlugEngine.PlugOfEngine.HookCheckCanUpgradeItem(CheckCanUpgradeItem);
  g_PlugEngine.PlugOfEngine.HookCheckCanSellItem(CheckCanSellItem);
  g_PlugEngine.PlugOfEngine.HookCheckNotCanScatterItem(CheckCanNotScatterItem);
  g_PlugEngine.PlugOfEngine.HookCheckCanDieScatterItem(CheckCanDieScatterItem);
  g_PlugEngine.PlugOfEngine.HookObjectOffLine(CheckCanOffLineTakeItem);
end;

procedure UnInitPlayUser();
begin
  g_PlugEngine.PlugOfEngine.HookCheckCanDropItem(OldCheckCanDropItem);
  g_PlugEngine.PlugOfEngine.HookCheckCanDealItem(OldCheckCanDealItem);
  g_PlugEngine.PlugOfEngine.HookCheckCanStorageItem(OldCheckCanStorageItem);
  g_PlugEngine.PlugOfEngine.HookCheckCanRepairItem(OldCheckCanRepairItem);
  g_PlugEngine.PlugOfEngine.HookCheckCanUpgradeItem(OldCheckCanUpgradeItem);
  g_PlugEngine.PlugOfEngine.HookCheckCanSellItem(OldCheckCanSellItem);
  g_PlugEngine.PlugOfEngine.HookCheckNotCanScatterItem(OldCheckCanNotScatterItem);
  g_PlugEngine.PlugOfEngine.HookCheckCanDieScatterItem(OldCheckCanDieScatterItem);
  g_PlugEngine.PlugOfEngine.HookObjectOffLine(OldCheckCanOffLineTakeItem);
  UnLoadCheckItemList();
end;

procedure InitSuperRock();
begin
  g_PlugEngine.PlugOfEngine.HookPlayObjectRun(SuperRock);
end;

procedure UnInitSuperRock();
begin
  g_PlugEngine.PlugOfEngine.HookPlayObjectRun(nil);
end;

function GetRockType(UseItems: THumanUseItems): Integer;
var
  StdItem: pTStdItem;
begin
  Result := -1;
  if (UseItems[U_CHARM].wIndex > 0) and (UseItems[U_CHARM].Dura > 0) then begin
    StdItem := g_UserManage.GetStdItem(UseItems[U_CHARM].wIndex);
    if (StdItem <> nil) and (StdItem.StdMode = 7) then begin
      Result := StdItem.Shape;
    end;
  end;
end;

procedure SuperRock(BaseObject: TObject);
var
  btRaceServer: Byte;
  m_UseItems: THumanUseItems;
  m_WAbil: TAbility;
  MasterObject: TActorObject;
  nCount: Integer;
  BaseObjectTick: LongWord;
  procedure ProcessHPRock();
  begin
    if m_WAbil.HP <= ((m_WAbil.MaxHP * nStartHPRock) div 100) then begin
      if GetTickCount - g_CharObject.m_ObjectRunTick[0] > nHPRockSpell * 1000 then begin
        g_CharObject.m_ObjectRunTick[0] := GetTickCount;
        if m_UseItems[U_CHARM].Dura > 0 then begin
          if btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT] then begin
            if (boStartHPRockMsg) and (sStartHPRockMsg <> '') then g_CharObject.SysMsg(sStartHPRockMsg, c_Red, t_Hint);
          end;
          nCount := 0;
          while True do begin
            if nCount >= 10 then Break;
            if m_WAbil.HP >= m_WAbil.MaxHP then Break;
            if m_UseItems[U_CHARM].Dura = 0 then Break;
            if m_WAbil.HP + nRockAddHP > m_WAbil.MaxHP then begin
              m_WAbil.HP := m_WAbil.MaxHP;
            end else begin
              Inc(m_WAbil.HP, nRockAddHP);
            end;
            Dec(m_UseItems[U_CHARM].Dura);
            Inc(nCount);
          end;
          g_CharObject.m_UseItems[U_CHARM].Dura := m_UseItems[U_CHARM].Dura;
          g_CharObject.m_WAbil.HP := m_WAbil.HP;

          g_CharObject.SendMsg(BaseObject, RM_HEALTHSPELLCHANGED, 0, 0, 0, 0, '');
          if g_CharObject.m_UseItems[U_CHARM].Dura > 0 then begin
            if btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT] then begin
              g_CharObject.SendMsg(BaseObject, RM_DURACHANGE, U_CHARM, m_UseItems[U_CHARM].Dura, m_UseItems[U_CHARM].DuraMax, 0, '');
            end;
          end else begin
            if btRaceServer = RC_PLAYOBJECT then begin
              g_CharObject.SendDelItem(@m_UseItems[U_CHARM]);
            end else
              if btRaceServer = RC_HEROOBJECT then begin
              g_CharObject.SendHeroDelItem(@m_UseItems[U_CHARM]);
            end;
          end;
        end else begin
          if btRaceServer = RC_PLAYOBJECT then begin
            g_CharObject.SendDelItem(@m_UseItems[U_CHARM]);
          end else
            if btRaceServer = RC_HEROOBJECT then begin
            g_CharObject.SendHeroDelItem(@m_UseItems[U_CHARM]);
          end;
        end;
      end;
    end;
  end;

  procedure ProcessMPRock();
  begin
    if (m_WAbil.MP <= ((m_WAbil.MaxMP * nStartMPRock) div 100)) then begin
      if GetTickCount - g_CharObject.m_ObjectRunTick[0] > nMPRockSpell * 1000 then begin
        g_CharObject.m_ObjectRunTick[0] := GetTickCount;
        if m_UseItems[U_CHARM].Dura > 0 then begin

          if btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT] then begin
            if (boStartMPRockMsg) and (sStartMPRockMsg <> '') then g_CharObject.SysMsg(sStartMPRockMsg, c_Red, t_Hint);
          end;

          nCount := 0;
          while True do begin
            if nCount >= 10 then Break;
            if m_WAbil.MP >= m_WAbil.MaxMP then Break;
            if m_UseItems[U_CHARM].Dura = 0 then Break;
            if m_WAbil.MP + nRockAddMP > m_WAbil.MaxMP then begin
              m_WAbil.MP := m_WAbil.MaxMP;
            end else begin
              Inc(m_WAbil.MP, nRockAddMP);
            end;
            Dec(m_UseItems[U_CHARM].Dura);
            Inc(nCount);
          end;

          g_CharObject.m_UseItems[U_CHARM].Dura := m_UseItems[U_CHARM].Dura;
          g_CharObject.m_WAbil.MP := m_WAbil.MP;

          g_CharObject.SendMsg(BaseObject, RM_HEALTHSPELLCHANGED, 0, 0, 0, 0, '');
          if g_CharObject.m_UseItems[U_CHARM].Dura > 0 then begin
            if btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT] then begin
              g_CharObject.SendMsg(BaseObject, RM_DURACHANGE, U_CHARM, m_UseItems[U_CHARM].Dura, m_UseItems[U_CHARM].DuraMax, 0, '');
            end;
          end else begin
            if btRaceServer = RC_PLAYOBJECT then begin
              g_CharObject.SendDelItem(@m_UseItems[U_CHARM]);
            end else
              if btRaceServer = RC_HEROOBJECT then begin
              g_CharObject.SendHeroDelItem(@m_UseItems[U_CHARM]);
            end;
          end;
        end else begin
          if btRaceServer = RC_PLAYOBJECT then begin
            g_CharObject.SendDelItem(@m_UseItems[U_CHARM]);
          end else
            if btRaceServer = RC_HEROOBJECT then begin
            g_CharObject.SendHeroDelItem(@m_UseItems[U_CHARM]);
          end;
        end;
      end;
    end;
  end;

  procedure ProcessHPMPRock();
  begin
    if (m_WAbil.MP <= ((m_WAbil.MaxMP * nStartMPRock) div 100)) or (m_WAbil.HP <= ((m_WAbil.MaxHP * nStartHPRock) div 100)) then begin
      if GetTickCount - g_CharObject.m_ObjectRunTick[0] > nHPMPRockSpell * 1000 then begin
        g_CharObject.m_ObjectRunTick[0] := GetTickCount;
        if m_UseItems[U_CHARM].Dura > 0 then begin

          if btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT] then begin
            if (boStartHPMPRockMsg) and (sStartHPMPRockMsg <> '') then
              g_CharObject.SysMsg(sStartHPMPRockMsg, c_Red, t_Hint);
          end;

          nCount := 0;
          while True do begin
            if nCount >= 3 then Break;
            if (m_WAbil.HP >= m_WAbil.MaxHP) and (m_WAbil.MP >= m_WAbil.MaxMP) then Break;
            if m_UseItems[U_CHARM].Dura = 0 then Break;
            if (m_WAbil.HP < m_WAbil.MaxHP) then begin
              if m_WAbil.HP + nRockAddHPMP > m_WAbil.MaxHP then begin
                m_WAbil.HP := m_WAbil.MaxHP;
              end else begin
                Inc(m_WAbil.HP, nRockAddHPMP);
              end;
            end;

            if m_WAbil.MP < m_WAbil.MaxMP then begin
              if m_WAbil.MP + nRockAddHPMP > m_WAbil.MaxMP then begin
                m_WAbil.MP := m_WAbil.MaxMP;
              end else begin
                Inc(m_WAbil.MP, nRockAddHPMP);
              end;
              Dec(m_UseItems[U_CHARM].Dura);
            end;
            Inc(nCount);
          end;

          //g_CharObject.m_WAbil^ := m_WAbil;
          g_CharObject.m_UseItems[U_CHARM].Dura := m_UseItems[U_CHARM].Dura;
          g_CharObject.m_WAbil.HP := m_WAbil.HP;
          g_CharObject.m_WAbil.MP := m_WAbil.MP;

         { if btRaceServer = RC_PLAYOBJECT then begin
            MainOutMessage(g_CharObject.m_sCharName + ' m_UseItems[U_CHARM].Dura:' + IntToStr(m_UseItems[U_CHARM].Dura), 0);
            MainOutMessage(g_CharObject.m_sCharName + ' g_CharObject.m_UseItems[U_CHARM].Dura:' + IntToStr(g_CharObject.m_UseItems[U_CHARM].Dura), 0);
            MainOutMessage(g_CharObject.m_sCharName + ' m_WAbil.HP:' + IntToStr(m_WAbil.HP), 0);
            MainOutMessage(g_CharObject.m_sCharName + ' g_CharObject.m_WAbil.HP:' + IntToStr(g_CharObject.m_WAbil.HP), 0);
          end;  }

          g_CharObject.SendMsg(BaseObject, RM_HEALTHSPELLCHANGED, 0, 0, 0, 0, '');
          if g_CharObject.m_UseItems[U_CHARM].Dura > 0 then begin
            if btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT] then begin
              g_CharObject.SendMsg(BaseObject, RM_DURACHANGE, U_CHARM, m_UseItems[U_CHARM].Dura, m_UseItems[U_CHARM].DuraMax, 0, '');
            end;
          end else begin
            if btRaceServer = RC_PLAYOBJECT then begin
              g_CharObject.SendDelItem(@m_UseItems[U_CHARM]);
            end else
              if btRaceServer = RC_HEROOBJECT then begin
              g_CharObject.SendHeroDelItem(@m_UseItems[U_CHARM]);
            end;
          end;
        end else begin
          if btRaceServer = RC_PLAYOBJECT then begin
            g_CharObject.SendDelItem(@m_UseItems[U_CHARM]);
          end else
            if btRaceServer = RC_HEROOBJECT then begin
            g_CharObject.SendHeroDelItem(@m_UseItems[U_CHARM]);
          end;
        end;
      end;
    end;
  end;
begin
  //气血石 魔血石 气魔石
  g_CharObject.BaseObject := BaseObject;
  if (not g_CharObject.m_boDeath) and (not g_CharObject.m_boGhost) then begin
    btRaceServer := g_CharObject.m_btRaceServer;
    if btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER] then begin
      m_UseItems := g_CharObject.m_UseItems^;
      m_WAbil := g_CharObject.m_WAbil^;
      if m_WAbil.HP > 0 then begin
        case GetRockType(m_UseItems) of
          1: ProcessHPRock(); //加血
          2: ProcessMPRock(); //加魔
          3: ProcessHPMPRock(); //加魔血
        end;
      end;
    end;
  end;
end;

procedure LoadCheckItemList();
var
  I: Integer;
  sFileName: string;
  LoadList: Classes.TStringList;
  sLineText: string;
  sItemName: string;
  sCanDrop: string;
  sCanDeal: string;
  sCanStorage: string;
  sCanRepair: string;

  sCanUpgrade: string;
  sCanSell: string;
  sCanNotScatter: string;
  sCanDieScatter: string;
  sCanOffLineTake: string;

  CheckItem: pTCheckItem;
begin
  sFileName := '.\CheckItemList.txt';

  if g_CheckItemList <> nil then begin
    UnLoadCheckItemList();
  end;
  g_CheckItemList := Classes.TList.Create;
  if not FileExists(sFileName) then begin
    LoadList := Classes.TStringList.Create();
    LoadList.Add(';引擎插件禁止物品配置文件');
    LoadList.Add(';物品名称'#9'扔'#9'交易'#9'存'#9'修'#9'升级'#9'出售'#9'禁止爆出'#9'死亡必爆'#9'死亡消失');
    LoadList.SaveToFile(sFileName);
    LoadList.Free;
    Exit;
  end;
  LoadList := Classes.TStringList.Create();
  LoadList.LoadFromFile(sFileName);
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then begin
      sLineText := GetValidStr3(sLineText, sItemName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanDrop, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanDeal, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanStorage, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanRepair, [' ', #9]);

      sLineText := GetValidStr3(sLineText, sCanUpgrade, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanSell, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanNotScatter, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanDieScatter, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanOffLineTake, [' ', #9]);
      if (sItemName <> '') then begin
        New(CheckItem);
        CheckItem.szItemName := sItemName;
        CheckItem.boCanDrop := sCanDrop = '1';
        CheckItem.boCanDeal := sCanDeal = '1';
        CheckItem.boCanStorage := sCanStorage = '1';
        CheckItem.boCanRepair := sCanRepair = '1';

        CheckItem.boCanUpgrade := sCanUpgrade = '1';
        CheckItem.boCanSell := sCanSell = '1';
        CheckItem.boCanNotScatter := sCanNotScatter = '1';
        CheckItem.boCanDieScatter := sCanDieScatter = '1';
        CheckItem.boCanOffLineTake := sCanOffLineTake = '1';
        g_CheckItemList.Add(CheckItem);
      end;
    end;
  end;
  LoadList.Free;
end;

procedure UnLoadCheckItemList();
var
  I: Integer;
  CheckItem: pTCheckItem;
begin
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := g_CheckItemList.Items[I];
    if CheckItem <> nil then
      Dispose(CheckItem);
  end;
  g_CheckItemList.Free;
  g_CheckItemList := nil;
end;

function CheckCanDropItem(PlayObject: TPlayObject; pszItemName: PChar; boHintMsg: Boolean): Boolean; stdcall;
resourcestring
  sMsg = '此物品禁止扔在地上！！！';
var
  I: Integer;
  CheckItem: pTCheckItem;
begin
  Result := True;
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := g_CheckItemList.Items[I];
    if (CheckItem.boCanDrop) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
      if boHintMsg then begin
        g_CharObject.BaseObject := PlayObject;
        g_CharObject.SendMsg(g_UserManage.m_ManageNPC, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, sMsg);
      end;
      Result := False;
      Break;
    end;
  end;
end;

function CheckCanDealItem(PlayObject: TPlayObject; pszItemName: PChar; boHintMsg: Boolean): Boolean; stdcall;
resourcestring
  sMsg = '此物品禁止交易！！！';
var
  I: Integer;
  CheckItem: pTCheckItem;
begin
  Result := True;
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := g_CheckItemList.Items[I];
    if (CheckItem.boCanDeal) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
      if boHintMsg then begin
        g_CharObject.BaseObject := PlayObject;
        g_CharObject.SendMsg(g_UserManage.m_ManageNPC, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, sMsg);
      end;
      Result := False;
      Break;
    end;
  end;
end;

function CheckCanStorageItem(PlayObject: TPlayObject; pszItemName: PChar; boHintMsg: Boolean): Boolean; stdcall;
resourcestring
  sMsg = '此物品禁止存仓库！！！';
var
  I: Integer;
  CheckItem: pTCheckItem;
begin
  Result := True;
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := g_CheckItemList.Items[I];
    if (CheckItem.boCanStorage) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
      if boHintMsg then begin
        g_CharObject.BaseObject := PlayObject;
        g_CharObject.SendMsg(g_UserManage.m_ManageNPC, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, sMsg);
      end;
      Result := False;
      Break;
    end;
  end;
end;

function CheckCanRepairItem(PlayObject: TPlayObject; pszItemName: PChar; boHintMsg: Boolean): Boolean; stdcall;
resourcestring
  sMsg = '此物品禁止修理！！！';
var
  I: Integer;
  CheckItem: pTCheckItem;
begin
  Result := True;
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := g_CheckItemList.Items[I];
    if (CheckItem.boCanRepair) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
      if boHintMsg then begin
        g_CharObject.BaseObject := PlayObject;
        g_CharObject.SendMsg(g_UserManage.m_ManageNPC, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, sMsg);
      end;
      Result := False;
      Break;
    end;
  end;
end;
//==============================================================================

function CheckCanUpgradeItem(PlayObject: TPlayObject; pszItemName: PChar; boHintMsg: Boolean): Boolean;
resourcestring
  sMsg = '此物品禁止升级！！！';
var
  I: Integer;
  CheckItem: pTCheckItem;
begin
  Result := False;
  if g_CheckItemList = nil then Exit;
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := g_CheckItemList.Items[I];
    if (CheckItem.boCanUpgrade) and (CompareText(CheckItem.szItemName, StrPas(pszItemName)) = 0) then begin
      if boHintMsg then begin
        g_CharObject.BaseObject := PlayObject;
        g_CharObject.SendMsg(g_UserManage.m_ManageNPC, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, sMsg);
      end;
      Result := True;
      Break;
    end;
  end;
end;

function CheckCanSellItem(PlayObject: TPlayObject; pszItemName: PChar; boHintMsg: Boolean): Boolean;
resourcestring
  sMsg = '此物品禁止出售！！！';
var
  I: Integer;
  CheckItem: pTCheckItem;
begin
  Result := False;
  if g_CheckItemList = nil then Exit;
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := g_CheckItemList.Items[I];
    if (CheckItem.boCanSell) and (CompareText(CheckItem.szItemName, StrPas(pszItemName)) = 0) then begin
      if boHintMsg then begin
        g_CharObject.BaseObject := PlayObject;
        g_CharObject.SendMsg(g_UserManage.m_ManageNPC, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, sMsg);
      end;
      Result := True;
      Break;
    end;
  end;
end;

function CheckCanNotScatterItem(PlayObject: TPlayObject; pszItemName: PChar; boHintMsg: Boolean): Boolean;
//resourcestring
 // sMsg = '此物品禁止爆出！！！';
var
  I: Integer;
  CheckItem: pTCheckItem;
  NormNpc: TNormNpc;
begin
  Result := False;
  if g_CheckItemList = nil then Exit;
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := g_CheckItemList.Items[I];
    if (CheckItem.boCanNotScatter) and (CompareText(CheckItem.szItemName, StrPas(pszItemName)) = 0) then begin
    {  if boHintMsg then begin
        NormNpc := TNormNpc_GetManageNpc();
        TActorObject_SendMsg(PlayObject, NormNpc, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, PChar(sMsg));
      end;  }
      Result := True;
      Break;
    end;
  end;
end;

function CheckCanDieScatterItem(PlayObject: TPlayObject; pszItemName: PChar; boHintMsg: Boolean): Boolean;
{resourcestring
  sMsg = '此物品禁止爆出！！！';  }
var
  I: Integer;
  CheckItem: pTCheckItem;
  NormNpc: TNormNpc;
begin
  Result := False;
  if g_CheckItemList = nil then Exit;
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := g_CheckItemList.Items[I];
    if (CheckItem.boCanDieScatter) and (CompareText(CheckItem.szItemName, StrPas(pszItemName)) = 0) then begin
     { if boHintMsg then begin
        NormNpc := TNormNpc_GetManageNpc();
        TActorObject_SendMsg(PlayObject, NormNpc, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, PChar(sMsg));
      end; }
      Result := True;
      Break;
    end;
  end;
end;

procedure CheckCanOffLineTakeItem(BaseObject: TBaseObject); //小退消失物品
var
  I, II: Integer;
  CheckItem: pTCheckItem;
  ItemList: Classes.TList;
  UseItems: pTHumanUseItems;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  nError: Integer;
begin
  if g_CheckItemList = nil then Exit;
  g_CharObject.BaseObject := BaseObject;

  //ItemList := Classes.TList(g_CharObject.m_ItemList);
  //ItemList := Classes.TList.Create;
  try
    nError := 0;
    {for I := 0 to g_UserManage.EngineOut.List_Count(g_CharObject.m_ItemList) - 1 do begin
      ItemList.Add(g_UserManage.EngineOut.List_Get(g_CharObject.m_ItemList, I));
    end; }
    nError := 1;
    ItemList := g_UserManage.EngineOut.TActorObject_ItemList(BaseObject);
    nError := 2;
    for I := 0 to g_CheckItemList.Count - 1 do begin
      nError := 3;
      CheckItem := g_CheckItemList.Items[I];
      nError := 4;
      if CheckItem.boCanOffLineTake then begin
      //if ItemList <> nil then begin
        nError := 5;
        for II := g_UserManage.EngineOut.List_Count(ItemList) - 1 downto 0 do begin //检测包裹
          nError := 6;
          UserItem := g_UserManage.EngineOut.List_Get(ItemList, II);
          nError := 7;
          StdItem := g_UserManage.GetStdItem(UserItem.wIndex);
          nError := 8;
          if StdItem = nil then Continue;
          if CompareText(StdItem.Name, CheckItem.szItemName) = 0 then begin
            nError := 9;
            g_CharObject.DeleteBagItem(UserItem);
            nError := 10;
          end;
        end;
      //end;
        nError := 11;
        UseItems := g_CharObject.m_UseItems; //检测身上
        for II := 0 to 12 do begin
          if UseItems[II].wIndex > 0 then begin
            nError := 12;
            StdItem := g_UserManage.GetStdItem(UseItems[II].wIndex);
            nError := 13;
            if StdItem = nil then Continue;
            //if StdItem.Name = CheckItem.szItemName then begin
            nError := 14;
            if CompareText(StdItem.Name, CheckItem.szItemName) = 0 then begin
              UseItems[II].wIndex := 0;
            end;
            nError := 15;
          end;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] zPlugOfEngine OffLineTakeItem:' + IntToStr(nError));
  end;
  {finally
    ItemList.Free;
  end; }
end;

function TrimAll(Text: string): string;
var
  I: Integer;
begin
  Text := Trim(Text);
  for I := Length(Text) downto 1 do
    if (not (Text[I] in TextChars)) then
      Delete(Text, I, 1);
  Result := Text;
end;

{function TrimAll(Src: string): string;
  function GetHideStr(Src: string): Integer;
  var
    I, II: Integer;
  begin
    Result := 0;
    for I := 1 to Length(Src) do begin
      if (Src[I] <> #10) and (Src[I] <> #32) then begin
        for II := 0 to 32 do begin
          if Src[I] = Chr(II) then begin
            Result := I;
            Exit;
          end;
        end;
      end;
    end;
  end;
var
  I, nLen: Integer;
  sSrc: string;
begin
  sSrc := Trim(Src);
  while True do begin
    if sSrc = '' then Break;
    nLen := GetHideStr(sSrc);
    if nLen > 0 then begin
      Delete(sSrc, nLen, 1);
    end else Break;
  end;
  Result := sSrc;
end; }

function IsFilterMsg(var sMsg: string; var boGotoLabel: Boolean): Boolean;
var
  I: Integer;
  nLen: Integer;
  sReplaceText: string;
  sFilterText: string;
  FilterMsg: pTFilterMsg;
  sSrc: string;
begin
  Result := False;
  boGotoLabel := False;
  if g_MsgFilterList = nil then begin
    //Result := TRUE;
    Exit;
  end;
  sSrc := TrimAll(sMsg);
  Result := CompareText(sSrc, sMsg) <> 0;
  sMsg := sSrc;
  for I := 0 to g_MsgFilterList.Count - 1 do begin
    FilterMsg := g_MsgFilterList.Items[I];
    if FilterMsg <> nil then begin
      if (FilterMsg.sFilterMsg <> '') and ((CompareText(sMsg, FilterMsg.sFilterMsg) = 0) or AnsiContainsText(sMsg, FilterMsg.sFilterMsg)) then begin
        { for nLen := 1 to Length(MsgFilter.sFilterMsg) do begin
           sReplaceText := sReplaceText + sReplaceWord;
         end;}
        if FilterMsg.sNewMsg = '' then begin
          sMsg := '';
        end else begin
          sMsg := AnsiReplaceText(sMsg, FilterMsg.sFilterMsg, FilterMsg.sNewMsg);
        end;
        boGotoLabel := FilterMsg.boGotoLabel;
        Result := True;
        Break;
      end;
    end;
  end;
end;

function FilterMsg(PlayObject: TObject; pszSrcMsg, pszDestMsg: PChar; var boGotoLabel: Boolean): Boolean;
var
  sSrcMsg: string;
  nDestLen: Integer;
begin
  Result := False;
  try
    sSrcMsg := StrPas(pszSrcMsg);
    if IsFilterMsg(sSrcMsg, boGotoLabel) then begin
      Result := True;
      if (sSrcMsg <> '') then begin
        nDestLen := Length(sSrcMsg);
        if nDestLen > 255 then begin
          nDestLen := 255;
          sSrcMsg := Copy(sSrcMsg, 1, nDestLen);
        end;
        Move(sSrcMsg[1], pszDestMsg^, nDestLen + 1);
      end else begin
        //FillChar(pszDestMsg^, 255, #0);
      end;
    end;
  except
    Result := False;
  end;
end;

procedure LoadMsgFilterList();
var
  I: Integer;
  sFileName: string;
  LoadList: Classes.TStringList;
  sLineText: string;
  sFilterMsg: string;
  sNewMsg: string;
  sGotoLabel: string;
  FilterMsg: pTFilterMsg;
  boGotoLabel: Boolean;
begin
  sFileName := '.\MsgFilterList.txt';
  if g_MsgFilterList <> nil then begin
    UnLoadMsgFilterList();
  end;
  g_MsgFilterList := Classes.TList.Create;
  if not FileExists(sFileName) then begin
    LoadList := Classes.TStringList.Create;
    LoadList.Add(';引擎插件消息过滤配置文件');
    LoadList.Add(';过滤消息'#9'替换消息'#9'脚本触发');
    LoadList.SaveToFile(sFileName);
    LoadList.Free;
    Exit;
  end;
  LoadList := Classes.TStringList.Create();
  LoadList.LoadFromFile(sFileName);
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then begin
      sLineText := GetValidStr3(sLineText, sGotoLabel, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sFilterMsg, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sNewMsg, [' ', #9]);
      if (sFilterMsg <> '') then begin
        New(FilterMsg);
        FilterMsg^.sFilterMsg := sFilterMsg;
        FilterMsg^.sNewMsg := sNewMsg;
        FilterMsg^.boGotoLabel := sGotoLabel = '1';
        g_MsgFilterList.Add(FilterMsg);
      end;
    end;
  end;
  LoadList.Free;
end;

procedure UnLoadMsgFilterList();
var
  I: Integer;
begin
  for I := 0 to g_MsgFilterList.Count - 1 do begin
    Dispose(g_MsgFilterList.Items[I]);
  end;
  g_MsgFilterList.Free;
  g_MsgFilterList := nil;
end;

procedure InitMsgFilter();
begin
  LoadMsgFilterList();
  g_PlugEngine.PlugOfEngine.HookPlayObjectFilterMsg(FilterMsg);
end;

procedure UnInitMsgFilter();
begin
  g_PlugEngine.PlugOfEngine.HookPlayObjectFilterMsg(nil);
  UnLoadMsgFilterList();
end;

end.

