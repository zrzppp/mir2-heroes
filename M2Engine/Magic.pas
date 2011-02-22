unit Magic;

interface
uses
  Windows, Classes, Grobal2, ObjBase, ObjActor, ObjHero, SysUtils;
type
  TMagicManager = class
  private

  public
    constructor Create();
    destructor Destroy; override;
    function GetAttackPowerPoint(BaseObject: TActorObject; UserMagic: pTUserMagic): Integer;
    function MagMakePrivateTransparent(BaseObject: TActorObject; nHTime: Integer): Boolean;
    function IsWarrSkill(wMagIdx: Integer): Boolean;
    function DoSpell(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;

    function MagBigHealing(PlayObject: TActorObject; nPower, nX, nY: Integer): Boolean;
    function MagPushArround(PlayObject: TActorObject; nPushLevel: Integer): Integer;
    function MagTurnUndead(BaseObject, TargeTActorObject: TActorObject; nTargetX, nTargetY: Integer; nLevel: Integer): Boolean;
    function MagMakeHolyCurtain(BaseObject: TActorObject; nDamage, nHTime, nX, nY: Integer): Integer;

    function MagMakeGroupTransparent(BaseObject: TActorObject; nX, nY: Integer; nHTime: Integer): Boolean;
    function MagTamming(BaseObject, TargeTActorObject: TActorObject; nTargetX, nTargetY: Integer; nMagicLevel: Integer): Boolean;
    function MagSaceMove(BaseObject: TActorObject; nLevel: Integer): Boolean;
    function MagMakeFireCross(PlayObject: TActorObject; nDamage, nHTime, nX, nY: Integer): Integer;
    function MagBigExplosion(BaseObject: TActorObject; nPower, nX, nY: Integer; nRage: Integer; btType: Byte): Boolean;
    function MagElecBlizzard(BaseObject: TActorObject; nPower: Integer): Boolean;
    function MabMabe(BaseObject, TargeTActorObject: TActorObject; nPower, nLevel, nTargetX, nTargetY: Integer): Boolean;
    function MagMakeSlave(PlayObject: TActorObject; UserMagic: pTUserMagic): Boolean;
    function MagMakeSelf(BaseObject, TargeTActorObject: TActorObject; UserMagic: pTUserMagic): TActorObject;
    function MagMakeSinSuSlave(PlayObject: TActorObject; UserMagic: pTUserMagic): Boolean;
    function MagWindTebo(PlayObject: TActorObject; UserMagic: pTUserMagic): Boolean;
    function MagGroupLightening(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject; var boSpellFire: Boolean): Boolean;
    function MagFlameField(BaseObject: TActorObject; nPower: integer): Boolean;

    function MagLighteningForbidVoodoo(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject; var boSpellFire: Boolean): Boolean;

    function MagGroupAmyounsul(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
    function MagGroupDeDing(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
    function MagGroupMb(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
    function MagHbFireBall(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
    function MagReturn(BaseObject, TargeTActorObject: TActorObject; nTargetX, nTargetY, nMagicLevel: Integer): Boolean; stdcall;
    function MagMakeSlave_(PlayObject: TActorObject; UserMagic: pTUserMagic; sMonName: string; nCount, nHumLevel, nMonLevel: Integer): Boolean;
    function MagLightening(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject; var boSpellFire: Boolean): Boolean;
    function MagMakeSuperFireCross(PlayObject: TActorObject; nDamage, nHTime, nX, nY: Integer; nCount: Integer): Integer;

    function MagMakeFireball(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
    function MagTreatment(PlayObject: TActorObject; UserMagic: pTUserMagic; var nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
    function MagMakeHellFire(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
    function MagMakeQuickLighting(PlayObject: TActorObject; UserMagic: pTUserMagic; var nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
    function MagMakeLighting(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
    function MagMakeFireCharm(PlayObject: TActorObject { 修改 TActorObject}; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
    function MagMakeUnTreatment(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
    function MagMakeReAlive(BaseObject: TActorObject; UserMagic: pTUserMagic; TargeTActorObject: TActorObject): Boolean;
    function MagMakeArrestObject(PlayObject: TActorObject; UserMagic: pTUserMagic; TargeTActorObject: TActorObject): Boolean;
    function MagChangePosition(PlayObject: TActorObject; nTargetX, nTargetY: Integer): Boolean;
    function MagChangePosition2(PlayObject: TActorObject; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
    function MagMakeFireDay(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;

    function MagGroupFengPo(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
    function MagTamming2(BaseObject, TargeTActorObject: TActorObject; nTargetX, nTargetY, nMagicLevel: Integer): Boolean;

    function MagMakeSkill_61(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
    function MagMakeSkill_62(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
    function MagMakeSkill_63(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
    function MagMakeSkill_64(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
    function MagMakeSkill_65(BaseObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer): Boolean;

    function MagMoonLowFireball(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
    function MagMoonHighFireball(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
    function MagMakeMoonObj(BaseObject: TActorObject; UserMagic: pTUserMagic): TActorObject;

    function MagMakeGroupFireCharm(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
    function MagMakeGroupFireball(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;

    function MagMakeSpaceLock(BaseObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer): Boolean;
    function MagMeteorShower(BaseObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer): Boolean;
    function MagMakeCurseArea(BaseObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer): Boolean;
//噬血术
    function MagAbsorbBlood(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
    function MagHeroGroup(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;

    function MagMakeSkill_104(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
    function MagMakeSkill_105(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
    function MagMakeSkill_106(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
    function MagMakeSkill_107(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
    function MagMakeSkill_108(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
    function MagMakeSkill_109(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
    function MagMakeSkill_110(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
    function MagMakeSkill_111(PlayObject: TActorObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
  end;
function MPow(UserMagic: pTUserMagic): Integer;
function GetPower(nPower: Integer; UserMagic: pTUserMagic): Integer;
function GetPower13(nInt: Integer; UserMagic: pTUserMagic): Integer;
function GetRPow(wInt: Integer): Word;
function CheckAmulet(PlayObject: TActorObject { 修改 TActorObject}; nCount: Integer; nType: Integer; var Idx: Integer): Boolean;
procedure UseAmulet(PlayObject: TActorObject { 修改 TActorObject}; nCount: Integer; nType: Integer; var Idx: Integer);
implementation

uses HUtil32, M2Share, Event, Envir, Castle, PlugIn;

function MPow(UserMagic: pTUserMagic): Integer;
begin
  Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
end;

function GetPower(nPower: Integer; UserMagic: pTUserMagic): Integer;
begin
  Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
end;

function GetPower13(nInt: Integer; UserMagic: pTUserMagic): Integer;
var
  d10: Double;
  d18: Double;
begin
  d10 := nInt / 3.0;
  d18 := nInt - d10;
  Result := Round(d18 / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower)));
end;

function GetRPow(wInt: Integer): Word;
begin
  if HiWord(wInt) > LoWord(wInt) then begin
    Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
  end else Result := LoWord(wInt);
end;

function CheckBagAmulet(PlayObject: TActorObject; nCount: Integer; nType: Integer; var Idx: Integer): Boolean;
var
  boUseBagItem: Boolean;
  AmuletStdItem: pTStdItem;
  UserItem: pTUserItem;
  nUseItemType: Integer;
begin
  Result := False;
  boUseBagItem := False;
  nUseItemType := 0;
  Idx := -1;
  case nType of
    1: nUseItemType := 5;
    2: nUseItemType := TAIObject(PlayObject).m_nSelItemType;
    3: nUseItemType := 3;
  end;
  if nUseItemType <= 0 then Exit;

  if (PlayObject.m_btRaceServer = RC_HEROOBJECT) then begin
    boUseBagItem := g_Config.boHeroUseBagItem and (not THeroObject(PlayObject).CheckUserItemType(nUseItemType, nCount));
  end else
    if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or PlayObject.m_boAI then begin
    if PlayObject.m_Master <> nil then begin
      boUseBagItem := g_Config.boMonUseBagItem and (not TAIObject(PlayObject).CheckUserItemType(nUseItemType, nCount));
    end else begin
      boUseBagItem := not TAIObject(PlayObject).CheckUserItemType(nUseItemType, nCount);
    end;
  end;

  if boUseBagItem then begin
    Idx := TAIObject(PlayObject).GetUserItemList(nUseItemType, nCount);
    if (Idx >= 0) and (Idx < PlayObject.m_ItemList.Count) then begin
      UserItem := PlayObject.m_ItemList.Items[Idx];
      if (UserItem.wIndex > 0) then begin
        AmuletStdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if (AmuletStdItem <> nil) and (AmuletStdItem.StdMode = 25) then begin
          case nType of
            1: begin
                if (AmuletStdItem.Shape = 5) and (Round(UserItem.Dura / 100) >= nCount) then begin
                  Inc(Idx, 13);
                  Result := True;
                  Exit;
                end;
              end;
            2: begin
                if (AmuletStdItem.Shape <= 2) and (Round(UserItem.Dura / 100) >= nCount) then begin
                  Inc(Idx, 13);
                  Result := True;
                  Exit;
                end;
              end;
            3: begin
                if (AmuletStdItem.Shape = 3) and (Round(UserItem.Dura / 100) >= nCount) then begin
                  Inc(Idx, 13);
                  Result := True;
                  Exit;
                end;
              end;
          end;
        end;
      end;
    end;
  end;
end;

//nType 为指定类型 1 为护身符 2 为毒药  3诅咒符

function CheckAmulet(PlayObject: TActorObject; nCount: Integer; nType: Integer; var Idx: Integer): Boolean;
var
  AmuletStdItem: pTStdItem;
begin
  Result := False;
  Idx := -1;

  if CheckBagAmulet(PlayObject, nCount, nType, Idx) and (Idx >= 0) then begin //直接使用包裹中物品
    Result := True;
    Exit;
  end;

  if PlayObject.m_UseItems[U_ARMRINGL].wIndex > 0 then begin
    AmuletStdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_ARMRINGL].wIndex);
    if (AmuletStdItem <> nil) and (AmuletStdItem.StdMode = 25) then begin
      case nType of
        1: begin //符咒
            if (AmuletStdItem.Shape = 5) and (Round(PlayObject.m_UseItems[U_ARMRINGL].Dura / 100) >= nCount) then begin
              Idx := U_ARMRINGL;
              Result := True;
              Exit;
            end;
          end;
        2: begin //毒
            if (AmuletStdItem.Shape <= 2) and (Round(PlayObject.m_UseItems[U_ARMRINGL].Dura / 100) >= nCount) then begin
              Idx := U_ARMRINGL;
              Result := True;
              Exit;
            end;
          end;
        3: begin //诅咒符
            if (AmuletStdItem.Shape = 3) and (Round(PlayObject.m_UseItems[U_ARMRINGL].Dura / 100) >= nCount) then begin
              Idx := U_ARMRINGL;
              Result := True;
              Exit;
            end;
          end;
      end;
    end;
  end;

  if PlayObject.m_UseItems[U_BUJUK].wIndex > 0 then begin
    AmuletStdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_BUJUK].wIndex);
    if (AmuletStdItem <> nil) and (AmuletStdItem.StdMode = 25) then begin
      case nType of //
        1: begin
            if (AmuletStdItem.Shape = 5) and (Round(PlayObject.m_UseItems[U_BUJUK].Dura / 100) >= nCount) then begin
              Idx := U_BUJUK;
              Result := True;
              Exit;
            end;
          end;
        2: begin
            if (AmuletStdItem.Shape <= 2) and (Round(PlayObject.m_UseItems[U_BUJUK].Dura / 100) >= nCount) then begin
              Idx := U_BUJUK;
              Result := True;
              Exit;
            end;
          end;
        3: begin
            if (AmuletStdItem.Shape = 3) and (Round(PlayObject.m_UseItems[U_BUJUK].Dura / 100) >= nCount) then begin
              Idx := U_BUJUK;
              Result := True;
              Exit;
            end;
          end;
      end;
    end;
  end;
end;

//nType 为指定类型 1 为护身符 2 为毒药  3诅咒符

procedure UseAmulet(PlayObject: TActorObject; nCount: Integer; nType: Integer; var Idx: Integer);
var
  UserItem: pTUserItem;
begin
  if Idx >= 13 then begin //直接使用包裹中物品
    Dec(Idx, 13);
    if (Idx >= 0) and (Idx < PlayObject.m_ItemList.Count) then begin
      UserItem := PlayObject.m_ItemList.Items[Idx];
      if UserItem.Dura > nCount * 100 then begin
        Dec(UserItem.Dura, nCount * 100);
        if PlayObject.m_btRaceServer = RC_HEROOBJECT then
          THeroObject(PlayObject).SendUpdateItem(UserItem)
        else
          if PlayObject.m_btRaceServer = RC_PLAYOBJECT then
          TPlayObject(PlayObject).SendUpdateItem(UserItem);
      end else begin
        if PlayObject.m_btRaceServer = RC_HEROOBJECT then
          THeroObject(PlayObject).SendDelItems(UserItem)
        else
          if PlayObject.m_btRaceServer = RC_PLAYOBJECT then
          TPlayObject(PlayObject).SendDelItems(UserItem);
        PlayObject.m_ItemList.Delete(Idx);
        Dispose(UserItem);
      end;
    end;
  end else begin
    if PlayObject.m_UseItems[Idx].Dura > nCount * 100 then begin
      Dec(PlayObject.m_UseItems[Idx].Dura, nCount * 100);
      PlayObject.SendMsg(PlayObject, RM_DURACHANGE, Idx, PlayObject.m_UseItems[Idx].Dura, PlayObject.m_UseItems[Idx].DuraMax, 0, '');
    end else begin
      PlayObject.m_UseItems[Idx].Dura := 0;
      if PlayObject.m_btRaceServer = RC_HEROOBJECT then
        THeroObject(PlayObject).SendDelItems(@PlayObject.m_UseItems[Idx]);
      if PlayObject.m_btRaceServer = RC_PLAYOBJECT then
        TPlayObject(PlayObject).SendDelItems(@PlayObject.m_UseItems[Idx]);

      PlayObject.m_UseItems[Idx].wIndex := 0;
    end;
  end;
end;

function TMagicManager.GetAttackPowerPoint(BaseObject: TActorObject; UserMagic: pTUserMagic): Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  with BaseObject do begin
    case m_btJob of
      0: Result := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.DC), Integer(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)) + 1);
      1: Result := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
      2: Result := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.SC), Integer(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);
    end;
  end;
end;

function TMagicManager.MagPushArround(PlayObject: TActorObject; nPushLevel: Integer): Integer;
var
  I, nDir, levelgap, push, nAtomPower: Integer;
  ActorObject: TActorObject;
  BaseObject: TBaseObject;
begin
  Result := 0;
  for I := 0 to PlayObject.m_VisibleActors.Count - 1 do begin
    ActorObject := TActorObject(pTVisibleBaseObject(PlayObject.m_VisibleActors.Items[I]).BaseObject);
    if (abs(PlayObject.m_nCurrX - ActorObject.m_nCurrX) <= 1) and (abs(PlayObject.m_nCurrY - ActorObject.m_nCurrY) <= 1) then begin
      if (not ActorObject.m_boDeath) and (ActorObject <> PlayObject) then begin
        if (PlayObject.m_Abil.Level > ActorObject.m_Abil.Level) and (not ActorObject.m_boStickMode) then begin

          levelgap := PlayObject.m_Abil.Level - ActorObject.m_Abil.Level;
          levelgap := PlayObject._GetAtomPower(ActorObject, AT_WIND, levelgap);

          if (Random(20) < 6 + nPushLevel * 3 + levelgap) then begin
            if PlayObject.IsProperTarget(ActorObject) then begin
              push := 1 + _MAX(0, nPushLevel - 1) + Random(2);
              nDir := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, ActorObject.m_nCurrX, ActorObject.m_nCurrY);
              ActorObject.CharPushed(nDir, push);
              Inc(Result);
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TMagicManager.MagBigHealing(PlayObject: TActorObject; nPower, nX, nY: Integer): Boolean;
var
  I: Integer;
  nPowerValue: Integer;
  BaseObjectList: TList;
  BaseObject: TActorObject;
begin
  Result := False;
  nPowerValue := nPower;
  BaseObjectList := TList.Create;
  PlayObject.GetMapActorObjects(PlayObject.m_PEnvir, nX, nY, 1, BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TActorObject(BaseObjectList[I]);
    if PlayObject.IsProperFriend(BaseObject) then begin
      if BaseObject.m_WAbil.HP < BaseObject.m_WAbil.MaxHP then begin

        nPowerValue := PlayObject._GetAtomPower(BaseObject, AT_HOLY, nPower);

        if nPowerValue > 0 then
          BaseObject.SendDelayMsg(PlayObject, RM_MAGHEALING, 0, nPowerValue, 0, 0, '', 800);
        Result := True;
      end;
      if PlayObject.m_boAbilSeeHealGauge then begin
        PlayObject.SendMsg(BaseObject, RM_10414, 0, 0, 0, 0, ''); //?? RM_INSTANCEHEALGUAGE
      end;
    end;
  end;
  BaseObjectList.Free;
end;

constructor TMagicManager.Create;
begin

end;

destructor TMagicManager.Destroy;
begin

  inherited;
end;

function TMagicManager.MagMakeSkill_104(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
var
  I, nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTActorObject) then begin
    if PlayObject.IsProperTarget(TargeTActorObject) then begin
      with PlayObject do begin
        nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
      end;

      nPower := Round(nPower * (g_Config.SerieMagicPowerRate[UserMagic.wMagIdx - 100] / 100));

      if UserMagic.btLevel in [1..3] then begin
        for I := 0 to g_Config.SerieMagicBlasthitRate[UserMagic.wMagIdx - 100, UserMagic.btLevel] do begin
          if Random(100 - g_Config.SerieMagicBlasthitRate[UserMagic.wMagIdx - 100, UserMagic.btLevel]) = 0 then begin
            nPower := Round(nPower * (g_Config.SerieMagicBlasthitPowerRate[UserMagic.wMagIdx - 100] / 100));
            PlayObject.SendSerieMagicBlasthitMsg(UserMagic);
            break;
          end;
        end;
      end;

      TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(TargeTActorObject.m_nCurrX, TargeTActorObject.m_nCurrY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 600);
      Result := True;
    end;
  end;
end;

function TMagicManager.MagMakeSkill_105(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
var
  I, nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTActorObject) then begin
    if PlayObject.IsProperTarget(TargeTActorObject) then begin
      with PlayObject do begin
        nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
      end;
      nPower := Round(nPower * (g_Config.SerieMagicPowerRate[UserMagic.wMagIdx - 100] / 100));

      if UserMagic.btLevel in [1..3] then begin
        for I := 0 to g_Config.SerieMagicBlasthitRate[UserMagic.wMagIdx - 100, UserMagic.btLevel] do begin
          if Random(100 - g_Config.SerieMagicBlasthitRate[UserMagic.wMagIdx - 100, UserMagic.btLevel]) = 0 then begin
            nPower := Round(nPower * (g_Config.SerieMagicBlasthitPowerRate[UserMagic.wMagIdx - 100] / 100));
            PlayObject.SendSerieMagicBlasthitMsg(UserMagic);
            break;
          end;
        end;
      end;

      TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(TargeTActorObject.m_nCurrX, TargeTActorObject.m_nCurrY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 600);
      Result := True;
    end;
  end;
end;

function TMagicManager.MagMakeSkill_106(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
var
  I, nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTActorObject) then begin
    if PlayObject.IsProperTarget(TargeTActorObject) then begin
      with PlayObject do begin
        nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
      end;
      nPower := Round(nPower * (g_Config.SerieMagicPowerRate[UserMagic.wMagIdx - 100] / 100));

      if UserMagic.btLevel in [1..3] then begin
        for I := 0 to g_Config.SerieMagicBlasthitRate[UserMagic.wMagIdx - 100, UserMagic.btLevel] do begin
          if Random(100 - g_Config.SerieMagicBlasthitRate[UserMagic.wMagIdx - 100, UserMagic.btLevel]) = 0 then begin
            nPower := Round(nPower * (g_Config.SerieMagicBlasthitPowerRate[UserMagic.wMagIdx - 100] / 100));
            PlayObject.SendSerieMagicBlasthitMsg(UserMagic);
            break;
          end;
        end;
      end;

      TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(TargeTActorObject.m_nCurrX, TargeTActorObject.m_nCurrY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 600);
      Result := True;
    end;
  end;
end;

function TMagicManager.MagMakeSkill_107(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  ActorObject: TActorObject;
  nPower: Integer;
  nPowerValue: Integer;
  boBlasthit: Boolean;
begin
  Result := False;
  nPower := 0;

  BaseObjectList := TList.Create;
  PlayObject.GetMapActorObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, g_Config.SerieMagicAttackRange[UserMagic.wMagIdx - 100], BaseObjectList);

  boBlasthit := False;
  if UserMagic.btLevel in [1..3] then begin
    for I := 0 to g_Config.SerieMagicBlasthitRate[UserMagic.wMagIdx - 100, UserMagic.btLevel] do begin
      if Random(100 - g_Config.SerieMagicBlasthitRate[UserMagic.wMagIdx - 100, UserMagic.btLevel]) = 0 then begin
        boBlasthit := True;
        break;
      end;
    end;
  end;

  for I := 0 to BaseObjectList.Count - 1 do begin
    ActorObject := TActorObject(BaseObjectList.Items[I]);
    if ActorObject.m_boDeath or (ActorObject.m_boGhost) or (PlayObject = ActorObject) then Continue;
    if PlayObject.IsProperTarget(ActorObject) then begin
      if (Random(10) >= ActorObject.m_nAntiMagic) then begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
          Integer(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
        if ActorObject.m_btLifeAttrib = LA_UNDEAD then
          nPower := Round(nPower * 1.5);

        nPower := PlayObject._GetAtomPower(TargeTActorObject, AT_ICE, nPower);

        nPower := Round(nPower * (g_Config.SerieMagicPowerRate[UserMagic.wMagIdx - 100] / 100));
        //nPower := nPower + PlayObject.GetAddPowerPoint(5, nPower);
        nPowerValue := nPower;
        if boBlasthit then
          nPower := Round(nPowerValue * (g_Config.SerieMagicBlasthitPowerRate[UserMagic.wMagIdx - 100] / 100));

        ActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御

        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(ActorObject.m_nCurrX, ActorObject.m_nCurrY), MakeLong(2, Integer(ActorObject.m_boNotDefendoof)), Integer(ActorObject), '', 800);
        if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
        else if ActorObject.m_btRaceServer >= RC_ANIMAL then Result := True;
      end;
    end;
  end;

  if boBlasthit then
    PlayObject.SendSerieMagicBlasthitMsg(UserMagic);

  BaseObjectList.Free;
end;

function TMagicManager.MagMakeSkill_108(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
var
  I, nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTActorObject) then begin
    if PlayObject.IsProperTarget(TargeTActorObject) then begin
      with PlayObject do
        nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.SC), Integer(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);

      nPower := Round(nPower * (g_Config.SerieMagicPowerRate[UserMagic.wMagIdx - 100] / 100));

      if UserMagic.btLevel in [1..3] then begin
        for I := 0 to g_Config.SerieMagicBlasthitRate[UserMagic.wMagIdx - 100, UserMagic.btLevel] do begin
          if Random(100 - g_Config.SerieMagicBlasthitRate[UserMagic.wMagIdx - 100, UserMagic.btLevel]) = 0 then begin
            nPower := Round(nPower * (g_Config.SerieMagicBlasthitPowerRate[UserMagic.wMagIdx - 100] / 100));
            PlayObject.SendSerieMagicBlasthitMsg(UserMagic);
            break;
          end;
        end;
      end;

      TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(TargeTActorObject.m_nCurrX, TargeTActorObject.m_nCurrY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 600);
      Result := True;
    end;
  end;
end;

function TMagicManager.MagMakeSkill_109(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
var
  I, nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTActorObject) then begin
    if PlayObject.IsProperTarget(TargeTActorObject) then begin
      with PlayObject do
        nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.SC), Integer(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);

      nPower := Round(nPower * (g_Config.SerieMagicPowerRate[UserMagic.wMagIdx - 100] / 100));

      if UserMagic.btLevel in [1..3] then begin
        for I := 0 to g_Config.SerieMagicBlasthitRate[UserMagic.wMagIdx - 100, UserMagic.btLevel] do begin
          if Random(100 - g_Config.SerieMagicBlasthitRate[UserMagic.wMagIdx - 100, UserMagic.btLevel]) = 0 then begin
            nPower := Round(nPower * (g_Config.SerieMagicBlasthitPowerRate[UserMagic.wMagIdx - 100] / 100));
            PlayObject.SendSerieMagicBlasthitMsg(UserMagic);
            break;
          end;
        end;
      end;

      TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(TargeTActorObject.m_nCurrX, TargeTActorObject.m_nCurrY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 600);
      Result := True;
    end;
  end;
end;

function TMagicManager.MagMakeSkill_110(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
var
  I, nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTActorObject) then begin
    if PlayObject.IsProperTarget(TargeTActorObject) then begin
      with PlayObject do
        nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.SC), Integer(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);

      nPower := Round(nPower * (g_Config.SerieMagicPowerRate[UserMagic.wMagIdx - 100] / 100));

      if UserMagic.btLevel in [1..3] then begin
        for I := 0 to g_Config.SerieMagicBlasthitRate[UserMagic.wMagIdx - 100, UserMagic.btLevel] do begin
          if Random(100 - g_Config.SerieMagicBlasthitRate[UserMagic.wMagIdx - 100, UserMagic.btLevel]) = 0 then begin
            nPower := Round(nPower * (g_Config.SerieMagicBlasthitPowerRate[UserMagic.wMagIdx - 100] / 100));
            PlayObject.SendSerieMagicBlasthitMsg(UserMagic);
            break;
          end;
        end;
      end;

      TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(TargeTActorObject.m_nCurrX, TargeTActorObject.m_nCurrY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 600);
      Result := True;
    end;
  end;
end;

function TMagicManager.MagMakeSkill_111(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  ActorObject: TActorObject;
  nPower: Integer;
  nPowerValue: Integer;
  boBlasthit: Boolean;
begin
  Result := False;
  nPower := 0;

  BaseObjectList := TList.Create;
  PlayObject.GetMapActorObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, g_Config.SerieMagicAttackRange[UserMagic.wMagIdx - 100], BaseObjectList);

  boBlasthit := False;
  if UserMagic.btLevel in [1..3] then begin
    for I := 0 to g_Config.SerieMagicBlasthitRate[UserMagic.wMagIdx - 100, UserMagic.btLevel] do begin
      if Random(100 - g_Config.SerieMagicBlasthitRate[UserMagic.wMagIdx - 100, UserMagic.btLevel]) = 0 then begin
        boBlasthit := True;
        break;
      end;
    end;
  end;

  for I := 0 to BaseObjectList.Count - 1 do begin
    ActorObject := TActorObject(BaseObjectList.Items[I]);
    if ActorObject.m_boDeath or (ActorObject.m_boGhost) or (PlayObject = ActorObject) then Continue;
    if PlayObject.IsProperTarget(ActorObject) then begin

      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.SC),
        Integer(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);

      nPower := Round(nPower * (g_Config.SerieMagicPowerRate[UserMagic.wMagIdx - 100] / 100));
      nPowerValue := nPower;
      if boBlasthit then
        nPower := Round(nPowerValue * (g_Config.SerieMagicBlasthitPowerRate[UserMagic.wMagIdx - 100] / 100));

      ActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御

      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(ActorObject.m_nCurrX, ActorObject.m_nCurrY), MakeLong(2, Integer(ActorObject.m_boNotDefendoof)), Integer(ActorObject), '', 800);
      if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
      else if ActorObject.m_btRaceServer >= RC_ANIMAL then Result := True;
    end;
  end;

  if boBlasthit then
    PlayObject.SendSerieMagicBlasthitMsg(UserMagic);
  BaseObjectList.Free;
end;
    //英雄合体

function TMagicManager.MagHeroGroup(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTActorObject: TActorObject): Boolean;
begin

end;

//月灵魔法  重击

function TMagicManager.MagMoonHighFireball(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTActorObject: TActorObject): Boolean;
var
  nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTActorObject) then begin
    if PlayObject.IsProperTarget(TargeTActorObject) then begin
      //if (TargeTActorObject.m_nAntiMagic <= Random(10)) and (abs(TargeTActorObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTActorObject.m_nCurrY - nTargetY) <= 1) then begin
      with PlayObject do begin
        nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
      end;
      if PlayObject.m_Master <> nil then begin
        with PlayObject.Master do begin
          case m_btJob of
            0: nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.DC), Integer(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)) + 1);
            1: nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
            2: nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.SC), Integer(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);
          end;
        end;
      end;
      nPower := Round(nPower / 2 + nPower);
      nPower := Round(nPower * (g_Config.nMoonHighPowerRate / 100));


      nPower := PlayObject._GetAtomPower(TargeTActorObject, AT_HOLY, nPower);
      TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御

      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(TargeTActorObject.m_nCurrX, TargeTActorObject.m_nCurrY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 600);
      if (TargeTActorObject.m_btRaceServer >= RC_ANIMAL) then Result := True;
    end else TargeTActorObject := nil;
    //end else TargeTActorObject := nil;
  end else TargeTActorObject := nil;
end;

//流星火雨

function TMagicManager.MagMakeCurseArea(BaseObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer): Boolean;//004C6F04
var
  III: Integer;
  I,II: Integer;
  nStartX,nStartY,nEndX,nEndY:Integer;
  BaseObjectList: TList;
  TargeTActorObject: TActorObject;
  nSec: Integer;
  nPowerValue: Integer;
begin
  Result := False;

  BaseObjectList := TList.Create;
  BaseObject.GetMapActorObjects(BaseObject.m_PEnvir, nTargetX, nTargetY, g_Config.nElecBlizzardRange + 2, BaseObjectList);

  for I := 0 to BaseObjectList.Count - 1 do begin
    TargeTActorObject := TActorObject(BaseObjectList.Items[I]);
            if TargeTActorObject.m_boDeath or (TargeTActorObject.m_boGhost) or (BaseObject = TargeTActorObject) then Continue;
              if BaseObject.IsProperTarget(TargeTActorObject) then begin
                if (Random(10) >= TargeTActorObject.m_nAntiMagic) then begin
                nSec := BaseObject.GetAttackPower(LoWord(BaseObject.m_WAbil.SC),
                  Integer(LoWord(BaseObject.m_WAbil.SC)));
                  TargeTActorObject.MakePosion(POISON_DONTMOVE, nSec ,0);
                //TPlayObject(PlayObject).AttPowerDown(UserMagic);
               if (BaseObject.m_btRaceServer = RC_PLAYMOSTER) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
               else if TargeTActorObject.m_btRaceServer >= RC_ANIMAL then Result := True;

              end;
              end;
            end;
  BaseObjectList.Free;
end;

function TMagicManager.MagMeteorShower(BaseObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTActorObject: TActorObject;
  nPower: Integer;
  nPowerValue: Integer;
begin
  Result := False;
  nPower := 0;
 { with BaseObject do
    nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(m_WAbil.MC),
      Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);

  }
  BaseObjectList := TList.Create;
  BaseObject.GetMapActorObjects(BaseObject.m_PEnvir, nTargetX, nTargetY, g_Config.nElecBlizzardRange + 2, BaseObjectList);

  for I := 0 to BaseObjectList.Count - 1 do begin
    TargeTActorObject := TActorObject(BaseObjectList.Items[I]);
    if TargeTActorObject.m_boDeath or (TargeTActorObject.m_boGhost) or (BaseObject = TargeTActorObject) then Continue;
    if BaseObject.IsProperTarget(TargeTActorObject) then begin
      if (Random(10) >= TargeTActorObject.m_nAntiMagic) then begin
        nPower := BaseObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(BaseObject.m_WAbil.MC),
          Integer(HiWord(BaseObject.m_WAbil.MC) - LoWord(BaseObject.m_WAbil.MC)) + 1);
        if TargeTActorObject.m_btLifeAttrib = LA_UNDEAD then
          nPower := Round(nPower * 1.5);

        nPowerValue := BaseObject._GetAtomPower(TargeTActorObject, AT_FIRE, nPower);
        nPower := nPowerValue;
        nPower := nPower + BaseObject.GetAddPowerPoint(5, nPower);
        TargeTActorObject.m_boNotDefendoof := BaseObject.GetNotDefendoof; //忽视目标防御

        nPower := Round(nPower * (g_Config.nSkill75PowerRate / 100));
        BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower, MakeLong(TargeTActorObject.m_nCurrX, TargeTActorObject.m_nCurrY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 800);
        BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower div 2, MakeLong(TargeTActorObject.m_nCurrX, TargeTActorObject.m_nCurrY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 1600);
        if (BaseObject.m_btRaceServer = RC_PLAYMOSTER) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
        else if TargeTActorObject.m_btRaceServer >= RC_ANIMAL then Result := True;
      end;
      {if (TargeTActorObject.m_nCurrX <> nTargetX) or (TargeTActorObject.m_nCurrY <> nTargetY) then
        BaseObject.SendRefMsg(RM_10205, 0, TargeTActorObject.m_nCurrX, TargeTActorObject.m_nCurrY, 12, '');}
    end;
  end;

  BaseObjectList.Free;
end;

//噬血术

function TMagicManager.MagAbsorbBlood(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTActorObject: TActorObject): Boolean;
var
  nPower, nPowerValue: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.IsProperTarget(TargeTActorObject) then begin
    if Random(10) >= TargeTActorObject.m_nAntiMagic then begin
      if (abs(TargeTActorObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTActorObject.m_nCurrY - nTargetY) <= 1) then begin
        {nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC),
          Integer(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
        }
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC) * 2,
          Integer(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) * 2 + 1);

        nPowerValue := PlayObject._GetAtomPower(TargeTActorObject, AT_DARK, nPower);
        nPower := nPowerValue;
        TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御

        nPower := Round(nPower * (g_Config.nSkill76PowerRate / 100));
        if PlayObject.m_WAbil.HP < PlayObject.m_WAbil.MaxHP then begin //吸血
          //PlayObject.SendDelayMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, '', 1200);
          Inc(PlayObject.m_nIncHealth, nPower);
        end;
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 1200);
        if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
        else if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) and (TargeTActorObject.m_btRaceServer >= RC_ANIMAL) then Result := True;
      end;
    end;
  end;
end;

//月灵魔法  普通

function TMagicManager.MagMoonLowFireball(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTActorObject: TActorObject): Boolean;
var
  nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTActorObject) then begin
    if PlayObject.IsProperTarget(TargeTActorObject) then begin
      //if (TargeTActorObject.m_nAntiMagic <= Random(10)) and (abs(TargeTActorObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTActorObject.m_nCurrY - nTargetY) <= 1) then begin
      with PlayObject do begin
        nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
      end;
      if PlayObject.m_Master <> nil then begin
        with PlayObject.Master do begin
          case m_btJob of
            0: nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.DC), Integer(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)) + 1);
            1: nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
            2: nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.SC), Integer(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);
          end;
        end;
      end;
      nPower := Round(nPower * (g_Config.nMoonLowPowerRate / 100));
      //nPower := Round(nPower / 3 * 2);

      nPower := PlayObject._GetAtomPower(TargeTActorObject, AT_HOLY, nPower);
      TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御

      if nPower > 0 then
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(TargeTActorObject.m_nCurrX, TargeTActorObject.m_nCurrY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 600);
      if (TargeTActorObject.m_btRaceServer >= RC_ANIMAL) then Result := True;
    end else TargeTActorObject := nil;
    //end else TargeTActorObject := nil;
  end else TargeTActorObject := nil;
end;

{Fireball Skill}
function TMagicManager.MagMakeFireball(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTActorObject: TActorObject): Boolean;
var
  nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTActorObject) then begin
    if PlayObject.IsProperTarget(TargeTActorObject) then begin
      if (TargeTActorObject.m_nAntiMagic <= Random(10)) and (abs(TargeTActorObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTActorObject.m_nCurrY - nTargetY) <= 1) then begin
        with PlayObject do begin
          nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC),
            Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
        end;

        nPower := PlayObject._GetAtomPower(TargeTActorObject, AT_FIRE, nPower);
        TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; // Ignore Target Defense

        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 600);
        {if (TargeTActorObject.m_btRaceServer >= RC_ANIMAL) then Result := True;}
        Result := True;
      end else
        TargeTActorObject := nil;
    end else
      TargeTActorObject := nil;
  end else
    TargeTActorObject := nil;
end;

{群体火球}

function TMagicManager.MagMakeGroupFireball(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTActorObject: TActorObject): Boolean;
var
  I: Integer;
  nPower: Integer;
  BaseObjectList: TList;
  BaseObject: TActorObject;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  with PlayObject do begin
    nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC),
      Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
  end;
  BaseObjectList := TList.Create;
  PlayObject.GetMapActorObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TActorObject(BaseObjectList.Items[I]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin

      if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, BaseObject) then begin
        if Random(10) >= BaseObject.m_nAntiMagic then begin

          nPower := PlayObject._GetAtomPower(BaseObject, AT_FIRE, nPower);
          BaseObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御

          PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), MakeLong(2, Integer(BaseObject.m_boNotDefendoof)), Integer(BaseObject), '', 600);
         { if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
          else if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) and (BaseObject.m_btRaceServer >= RC_ANIMAL) then Result := True;    }
          if (BaseObject.m_btRaceServer >= RC_ANIMAL) then Result := True;
          if Result and (BaseObject <> TargeTActorObject) then begin
            PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
              MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
              MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY),
              Integer(BaseObject),
              '');
          end;

        end;
      end;
    end;
  end;
  BaseObjectList.Free;
end;



{Healing Skill}
function TMagicManager.MagTreatment(PlayObject: TActorObject;
  UserMagic: pTUserMagic; var nTargetX, nTargetY: Integer;
  var TargeTActorObject: TActorObject): Boolean;
var
  nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if TargeTActorObject = nil then begin
    TargeTActorObject := PlayObject;
    nTargetX := PlayObject.m_nCurrX;
    nTargetY := PlayObject.m_nCurrY;
  end;
  if PlayObject.IsProperFriend(TargeTActorObject) then begin
    nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC) * 2,
      Integer(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) * 2 + 1) + PlayObject.m_WAbil.Level;
    if TargeTActorObject.m_WAbil.HP < TargeTActorObject.m_WAbil.MaxHP then begin

      nPower := PlayObject._GetAtomPower(TargeTActorObject, AT_HOLY, nPower);

      TargeTActorObject.SendDelayMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, '', 800);
    end;
    Result := True;
    PlayObject.SendMsg(TargeTActorObject, RM_10414, 0, 0, 0, 0, '');
  end;
end;

{地域火}

function TMagicManager.MagMakeHellFire(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTActorObject: TActorObject): Boolean;
var
  nPower: Integer;
  n1C: Integer;
  n14, n18: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  n1C := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, nTargetX, nTargetY);
  if PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 1, n14, n18) then begin
    PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 5, nTargetX, nTargetY);
    nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
      Integer(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);

    if PlayObject.MagPassThroughMagic(n14, n18, nTargetX, nTargetY, n1C, nPower, False, AT_FIRE) > 0 then
      Result := True;
  end;
end;

{疾光电影}

function TMagicManager.MagMakeQuickLighting(PlayObject: TActorObject;
  UserMagic: pTUserMagic; var nTargetX, nTargetY: Integer;
  TargeTActorObject: TActorObject): Boolean;
var
  nPower: Integer;
  n1C: Integer;
  n14, n18: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  n1C := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, nTargetX, nTargetY);
  if PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 1, n14, n18) then begin
    PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 8, nTargetX, nTargetY);
    nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
      Integer(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
    if PlayObject.MagPassThroughMagic(n14, n18, nTargetX, nTargetY, n1C, nPower, True, AT_LIGHT) > 0 then
      Result := True;
  end;
end;

{雷电术}

function TMagicManager.MagMakeLighting(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTActorObject: TActorObject): Boolean;
var
  nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.IsProperTarget(TargeTActorObject) then begin
    if (Random(10) >= TargeTActorObject.m_nAntiMagic) then begin
      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
        Integer(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      if TargeTActorObject.m_btLifeAttrib = LA_UNDEAD then
        nPower := Round(nPower * 1.5);

      nPower := PlayObject._GetAtomPower(TargeTActorObject, AT_LIGHT, nPower);
      TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御

      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 600);
    {  if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
      else if TargeTActorObject.m_btRaceServer >= RC_ANIMAL then Result := True;}
      Result := True;
    end else TargeTActorObject := nil
  end else TargeTActorObject := nil;
end;

{灵魂火符}

function TMagicManager.MagMakeFireCharm(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTActorObject: TActorObject): Boolean;
var
  nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTActorObject) then begin
    if PlayObject.IsProperTarget(TargeTActorObject) then begin
      if Random(10) >= TargeTActorObject.m_nAntiMagic then begin
        if (abs(TargeTActorObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTActorObject.m_nCurrY - nTargetY) <= 1) then begin
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC),
            Integer(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);

          nPower := PlayObject._GetAtomPower(TargeTActorObject, AT_DARK, nPower);
          TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御

          PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 1200);
          Result := True;
         { if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
          else if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) and (TargeTActorObject.m_btRaceServer >= RC_ANIMAL) then Result := True; }
        end else TargeTActorObject := nil;
      end else TargeTActorObject := nil;
    end else TargeTActorObject := nil;
  end else TargeTActorObject := nil;
end;


{群体灵魂火符}

function TMagicManager.MagMakeGroupFireCharm(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTActorObject: TActorObject): Boolean;
var
  I: Integer;
  nPower, nPowerValue: Integer;
  BaseObjectList: TList;
  BaseObject: TActorObject;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  nPowerValue := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC),
    Integer(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);

  nPowerValue := Round(nPowerValue * (g_Config.nGroupFireCharmPowerRate / 100));
  nPower := nPowerValue;
  BaseObjectList := TList.Create;
  PlayObject.GetMapActorObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TActorObject(BaseObjectList.Items[I]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin
      if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, BaseObject) then begin
        if Random(10) >= BaseObject.m_nAntiMagic then begin


          nPower := PlayObject._GetAtomPower(BaseObject, AT_DARK, nPowerValue);
          BaseObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御

          PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), MakeLong(2, Integer(BaseObject.m_boNotDefendoof)), Integer(BaseObject), '', 800);
        {  if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
          else if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) and (BaseObject.m_btRaceServer >= RC_ANIMAL) then Result := True;
            }
          Result := True;
          if (BaseObject <> TargeTActorObject) then begin
           //PlayObject.SendRefMsg(Envir, nX, nY, RM_10205, 0, nX, nY, 15, '');
            PlayObject.SendRefMsg(RM_10206, 15, Integer(BaseObject), BaseObject.m_nCurrX, BaseObject.m_nCurrY, '');
            //PlayObject.SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 15, '');
           { PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
              MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
              MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY),
              Integer(BaseObject),
              '');    }
          end;
        end;
      end;
    end;
  end;
  BaseObjectList.Free;
end;


{灭天火}

function TMagicManager.MagMakeFireDay(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTActorObject: TActorObject): Boolean;
var
  nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.IsProperTarget(TargeTActorObject) then begin
    if (Random(10) >= TargeTActorObject.m_nAntiMagic) then begin
      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
        Integer(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      if TargeTActorObject.m_btLifeAttrib = LA_UNDEAD then
        nPower := Round(nPower * 1.5);

      nPower := PlayObject._GetAtomPower(TargeTActorObject, AT_FIRE, nPower);
      TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御

      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 600);
      if g_Config.boPlayObjectReduceMP then TargeTActorObject.DamageSpell(nPower);
      //if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
    //else if TargeTActorObject.m_btRaceServer >= RC_ANIMAL then Result := True;
    end else TargeTActorObject := nil;
    Result := True;
  end else TargeTActorObject := nil;
end;

{解毒术}

function TMagicManager.MagMakeUnTreatment(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTActorObject: TActorObject): Boolean;
begin
  Result := False;
  if TargeTActorObject = nil then begin
    TargeTActorObject := PlayObject;
    nTargetX := PlayObject.m_nCurrX;
    nTargetY := PlayObject.m_nCurrY;
  end;
  if PlayObject.IsProperFriend {0FFF3}(TargeTActorObject) then begin
    if Random(7) - (UserMagic.btLevel + 1) < 0 then begin
      if TargeTActorObject.m_wStatusTimeArr[POISON_DECHEALTH] <> 0 then begin
        TargeTActorObject.m_wStatusTimeArr[POISON_DECHEALTH] := 1;
        Result := True;
      end;
      if TargeTActorObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] <> 0 then begin
        TargeTActorObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] := 1;
        Result := True;
      end;
      if TargeTActorObject.m_wStatusTimeArr[POISON_STONE] <> 0 then begin
        TargeTActorObject.m_wStatusTimeArr[POISON_STONE] := 1;
        Result := True;
      end;
    end;
  end;
end;

{复活术}

function TMagicManager.MagMakeReAlive(BaseObject: TActorObject; UserMagic: pTUserMagic; TargeTActorObject: TActorObject): Boolean;
var
  PlayObject: TPlayObject;
begin
  Result := False;
  if BaseObject.IsProperTargetSKILL_57(TargeTActorObject) then begin
    if (Random(5 + UserMagic.btLevel) + UserMagic.btLevel) >= 5 then begin
      PlayObject := TPlayObject(TargeTActorObject);
      PlayObject.ReAlive;
      PlayObject.m_WAbil.HP := PlayObject.m_WAbil.MaxHP;
      PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
      Result := True;
    end;
  end;
end;

{擒龙手}

function TMagicManager.MagMakeArrestObject(PlayObject: TActorObject; UserMagic: pTUserMagic; TargeTActorObject: TActorObject): Boolean;
var
  nX, nY: Integer;
begin
  Result := False;
  if PlayObject.IsProperTargetSKILL_55(PlayObject.m_WAbil.Level, TargeTActorObject) then begin
    if (Random(10 + UserMagic.btLevel) + UserMagic.btLevel) >= 5 then begin
      PlayObject.GetFrontPosition(nX, nY);
      TargeTActorObject.SpaceMove(TargeTActorObject.m_PEnvir.sMapName, nX, nY, 0);
      TargeTActorObject.SendRefMsg(RM_MONMOVE, 0, nX, nY, 0, '');
      Result := True;
    end;
  end;
end;

{移行换位}

function TMagicManager.MagChangePosition2(PlayObject: TActorObject; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
var
  I, nX, nY, olddir, oldx, oldy, nBackDir, nDir: Integer;
  n01: Integer;
begin
  Result := False;
  n01 := 0;
  if (not PlayObject.m_boOnHorse) and (PlayObject.m_NewStatus = sNone) then begin
   // if PlayObject.IsProperTargetSKILL_56(TargeTActorObject, nTargetX, nTargetY) then begin
      //nDir := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, nTargetX, nTargetY);
    PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
      //PlayObject.SendRefMsg(RM_CHANGETURN, 0, 0, 0, 0, '');
    PlayObject.SpaceMove(PlayObject.m_PEnvir.sMapName, nTargetX, nTargetY, 0);
    Result := True;
    //end;
  end;
end;

{移行换位}

function TMagicManager.MagChangePosition(PlayObject: TActorObject; nTargetX, nTargetY: Integer): Boolean;
var
  I, nX, nY, olddir, oldx, oldy, nBackDir, nDir: Integer;
  n01: Integer;
begin
  Result := False;
  n01 := 0;
  if (not PlayObject.m_boOnHorse) and (PlayObject.m_NewStatus = sNone) and (GetTickCount - TPlayObject(PlayObject).m_dwMagicMovePositionTick > g_Config.nMagicMovePositionTime * 1000) then begin
    TPlayObject(PlayObject).m_dwMagicMovePositionTick := GetTickCount;
    if (Random(g_Config.nMagicMovePositionRate) = 0) and PlayObject.m_PEnvir.CanWalk(nTargetX, nTargetY, True) and PlayObject.m_PEnvir.CanWalkOfEvent(PlayObject, nTargetX, nTargetY) and (PlayObject.m_PEnvir.GetXYObjCount(nTargetX, nTargetY) = 0) then begin
      PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
      PlayObject.SpaceMove2(nTargetX, nTargetY, 0);
      Result := True;
    end;
  end;
end;

//劈星斩

function TMagicManager.MagMakeSkill_61(PlayObject: TActorObject; UserMagic: pTUserMagic;
  nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
var
  nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.m_Master = nil then Exit;
  nPower := 0;
  if PlayObject.IsProperTarget(TargeTActorObject) then begin
    with PlayObject do begin
      case m_btJob of
        2: nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.SC), Integer(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);
        0: nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.DC), Integer(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)) + 1);
      end;
    end;
    with PlayObject.m_Master do begin
      case m_btJob of
        2: nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.SC), Integer(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);
        0: nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.DC), Integer(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)) + 1);
      end;
    end;

    nPower := PlayObject._GetAtomPower(TargeTActorObject, nPower);
    TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御

    nPower := Round(nPower * (g_Config.nSkill61Rate / 100));
    PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 600);
    Result := True;
  end;
end;

//雷霆一击

function TMagicManager.MagMakeSkill_62(PlayObject: TActorObject; UserMagic: pTUserMagic;
  nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
var
  nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.m_Master = nil then Exit;
  nPower := 0;
  if PlayObject.IsProperTarget(TargeTActorObject) then begin
   // if (TargeTActorObject.m_nAntiMagic <= Random(10)) and (abs(TargeTActorObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTActorObject.m_nCurrY - nTargetY) <= 1) then begin

    with PlayObject do begin
      case m_btJob of
        1: nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
        0: nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.DC), Integer(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)) + 1);
      end;
    end;

    with PlayObject.m_Master do begin
      case m_btJob of
        1: nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
        0: nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.DC), Integer(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)) + 1);
      end;
    end;

    nPower := PlayObject._GetAtomPower(TargeTActorObject, nPower);
    TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御

    nPower := Round(nPower * (g_Config.nSkill62Rate / 100));

        //TargeTActorObject.MagDownHealth(0, (Random(10) + UserMagic.btLevel) * 2 + 1, nPower div 10 + 1);
    PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 600);

    //end;
    Result := True;
  end;
end;

//噬魂沼泽

function TMagicManager.MagMakeSkill_63(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTActorObject: TActorObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TActorObject;
  nPower: Integer;
  StdItem: pTStdItem;
  nAmuletIdx: Integer;
  nPowerValue: Integer;
  boNotDefendoof: Boolean;
begin
  Result := False;
  if PlayObject.m_Master = nil then Exit;
  nPower := 0;

  with PlayObject do
    nPower := GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(m_WAbil.SC),
      Integer(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);

  with PlayObject.m_Master do
    nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(m_WAbil.SC),
      Integer(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);


  nPower := PlayObject._GetAtomPower(TargeTActorObject, AT_DARK, nPower);

  nPowerValue := Round(nPower * (g_Config.nSkill63Rate / 100));

  BaseObjectList := TList.Create;
  PlayObject.GetMapActorObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TActorObject(BaseObjectList.Items[I]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin

      BaseObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御
      nPowerValue := nPowerValue + PlayObject.GetAddPowerPoint(5, nPowerValue);

      //if Random(BaseObject.m_btAntiPoison + 7) <= 6 then begin
      BaseObject.SendMsg(PlayObject, RM_MAGSTRUCK, 0, nPowerValue, Integer(BaseObject.m_boNotDefendoof), 0, '');
      nPower := (GetPower13(40, UserMagic) + GetRPow(PlayObject.m_WAbil.SC) * 2);
      nPower := Round(nPower * (g_Config.nHeroAttackRate / 100));
      BaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DECHEALTH {中毒类型 - 绿毒}, nPowerValue, Integer(PlayObject), Round(UserMagic.btLevel / 3 * (nPowerValue / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
      BaseObject.SetLastHiter(PlayObject);
      PlayObject.SetTargetCreat(BaseObject);
      Result := True;
      //end;
    end;
  end;
  BaseObjectList.Free;
end;

//末日审判

function TMagicManager.MagMakeSkill_64(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTActorObject: TActorObject): Boolean;
var
  nPower: Integer;
  nTime: Integer;
  nPowerValue: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.m_Master = nil then Exit;
  nPower := 0;
  if PlayObject.IsProperTarget(TargeTActorObject) then begin
    //if (TargeTActorObject.m_nAntiMagic <= Random(10)) and (abs(TargeTActorObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTActorObject.m_nCurrY - nTargetY) <= 1) then begin
    with PlayObject do begin
      case m_btJob of
        1: nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
        2: nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.SC), Integer(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);
      end;
    end;

    with PlayObject.m_Master do begin
      case m_btJob of
        1: nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
        2: nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.SC), Integer(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);
      end;
    end;
    nPowerValue := nPower;

    nPowerValue := PlayObject._GetAtomPower(TargeTActorObject, nPower);
    TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御

    nPowerValue := Round(nPowerValue * (g_Config.nSkill64Rate / 100));

    nTime := (5 * UserMagic.btLevel + 1) * 2;
        //nTime := Round(nTime * (g_Config.nHeroAttackRate / 100));
    TargeTActorObject.MagDownHealth(0, (Random(10) + UserMagic.btLevel) * 2 + 1, nPowerValue div 10 + 1);
    TargeTActorObject.MagDownHealth(1, (Random(10) + UserMagic.btLevel) * 2 + 1, nPowerValue div 10 + 1);
    PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPowerValue, MakeLong(nTargetX, nTargetY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 600);

    {if not TargeTActorObject.m_boUnParalysis and (Random(TargeTActorObject.m_btAntiPoison) = 0) then begin     //麻痹
      TargeTActorObject.MakePosion(POISON_STONE, nTime, 0);
      TargeTActorObject.m_boFastParalysis := True;
    end;}
    //end else TargeTActorObject := nil;
    Result := True;
  end;
end;

//火龙气焰

function TMagicManager.MagMakeSkill_65(BaseObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTActorObject: TActorObject;
  nPower: Integer;
  nPowerValue: Integer;
begin
  Result := False;
  if BaseObject.m_Master = nil then Exit;
  nPower := 0;

  with BaseObject do
    nPower := GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(m_WAbil.MC),
      Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);

  with BaseObject.m_Master do
    nPower := nPower + GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(m_WAbil.MC),
      Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);


  nPowerValue := BaseObject._GetAtomPower(TargeTActorObject, AT_FIRE, nPower);
  nPowerValue := nPowerValue + BaseObject.GetAddPowerPoint(5, nPowerValue);


  nPowerValue := Round(nPower * (g_Config.nSkill65Rate / 100));

  BaseObjectList := TList.Create;
  BaseObject.GetMapActorObjects(BaseObject.m_PEnvir, nTargetX, nTargetY, g_Config.nElecBlizzardRange {2}, BaseObjectList);

  for I := 0 to BaseObjectList.Count - 1 do begin
    TargeTActorObject := TActorObject(BaseObjectList.Items[I]);
    if BaseObject.IsProperTarget(TargeTActorObject) then begin

      TargeTActorObject.m_boNotDefendoof := BaseObject.GetNotDefendoof; //忽视目标防御

      TargeTActorObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nPowerValue, Integer(TargeTActorObject.m_boNotDefendoof), 0, '');
      Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

//空间锁定

function TMagicManager.MagMakeSpaceLock(BaseObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer): Boolean;
  function GetPower13(nInt: Integer): Integer;
  var
    d10: Double;
    d18: Double;
  begin
    d10 := nInt / 3.0;
    d18 := nInt - d10;
    Result := Round(d18 / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower)));
  end;
  function GetRPow(wInt: Integer): Word;
  begin
    if HiWord(wInt) > LoWord(wInt) then begin
      Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
    end else Result := LoWord(wInt);
  end;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
var
  I, II, III: Integer;
  BaseObjectList: TList;
  TargeTActorObject: TActorObject;
  ActorObject: TActorObject;
  Event: TEvent;
  nDelayTime: Integer;
  nRange: Integer;
  nX, nY: Integer;
  SpaceLockEvent: TSpaceLockEvent;
  nMinX, nMaxX, nMinY, nMaxY: Integer;
  boFind: Boolean;
  Castle: TUserCastle;
begin
  Result := False;
  if BaseObject.m_boSpaceLock or BaseObject.InSafeZone() then Exit;
  if GetTickCount - BaseObject.m_dwSpaceSkillDelayTick >= g_Config.nSpaceSkillDelayTime * 1000 then begin
    BaseObject.m_dwSpaceSkillDelayTick := GetTickCount;

    if g_Config.boNoAllowWarRangeUseSpaceSkill then begin
      Castle := g_CastleManager.InCastleWarArea(BaseObject);
      if (Castle <> nil) and Castle.m_boUnderWar then begin
        BaseObject.SysMsg('Cannot use during War.', c_Red, t_Hint);
        Exit;
      end;
    end;

    boFind := False;
    {nDelayTime := 0;
    case BaseObject.m_btJob of
      0: nDelayTime := GetPower13(40) + GetRPow(BaseObject.m_WAbil.DC) * 3;
      1: nDelayTime := GetPower13(40) + GetRPow(BaseObject.m_WAbil.SC) * 3;
      2: nDelayTime := GetPower13(40) + GetRPow(BaseObject.m_WAbil.MC) * 3;
    end;}
    nDelayTime := g_Config.nSpaceSkillKeepTime;
    case UserMagic.btLevel of
      0, 1: nRange := 3;
      2: nRange := 4;
      3: nRange := 6;
    end;
 { nRange := _MIN((UserMagic.btLevel + 1) * _MAX(UserMagic.btLevel, 1), 6);
  nRange := _MAX(nRange, 3); }

  {
  MainoutMessage('nRange:'+IntToStr(nRange));
  MainoutMessage('nDelayTime:'+IntToStr(nDelayTime)); }

    BaseObjectList := TList.Create;
    BaseObject.GetMapActorObjects(BaseObject.m_PEnvir, nTargetX, nTargetY, nRange - 1, BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do begin
      TargeTActorObject := TActorObject(BaseObjectList.Items[I]);
      if TargeTActorObject.m_boSpaceLock or TargeTActorObject.InSafeZone() then begin
        boFind := True;
        Break;
      end;
    end;
    BaseObjectList.Free;

    if not boFind then begin
      BaseObjectList := TList.Create;
      BaseObject.GetMapEvents(BaseObject.m_PEnvir, nTargetX, nTargetY, nRange, BaseObjectList);
      for I := 0 to BaseObjectList.Count - 1 do begin
        Event := TEvent(BaseObjectList.Items[I]);
        if Event.m_nServerEventType = ET_MAGICLOCK then begin
          boFind := True;
          Break;
        end;
      end;
      BaseObjectList.Free;
    end;

    if not boFind then begin
      for I := nTargetX - nRange - 1 to nTargetX + nRange - 1 do begin
        for II := nTargetY - nRange - 1 to nTargetY + nRange - 1 do begin
          if BaseObject.InSafeZone(BaseObject.m_PEnvir, I, II) then begin
            BaseObject.SysMsg('Cannot use in Safe Zone.', c_Red, t_Hint);
            Exit;
          end;
          if g_Config.boNoAllowWarRangeUseSpaceSkill then begin
            Castle := g_CastleManager.InCastleWarArea(BaseObject.m_PEnvir, I, II); //攻城区域不允许使用
            if (Castle <> nil) and Castle.m_boUnderWar then begin
              BaseObject.SysMsg('Cannot use during War.', c_Red, t_Hint);
              Exit;
            end;
          end;
        end;
      end;
    end;

    if boFind then begin
      for I := nTargetX - nRange - 1 to nTargetX + nRange - 1 do begin
        for II := nTargetY - nRange - 1 to nTargetY + nRange - 1 do begin
          boFind := False;

          if BaseObject.InSafeZone(BaseObject.m_PEnvir, I, II) then begin
            BaseObject.SysMsg('Cannot use in Safe Zone.', c_Red, t_Hint);
            Exit;
          end;

          if g_Config.boNoAllowWarRangeUseSpaceSkill then begin
            Castle := g_CastleManager.InCastleWarArea(BaseObject.m_PEnvir, I, II);
            if (Castle <> nil) and Castle.m_boUnderWar then begin
              BaseObject.SysMsg('Cannot use during War.', c_Red, t_Hint);
              Exit;
            end;
          end;

          BaseObjectList := TList.Create;
          BaseObject.GetMapActorObjects(BaseObject.m_PEnvir, I, II, nRange - 1, BaseObjectList);
          for III := 0 to BaseObjectList.Count - 1 do begin
            TargeTActorObject := TActorObject(BaseObjectList.Items[III]);
            if TargeTActorObject.m_boSpaceLock or TargeTActorObject.InSafeZone() then begin
              boFind := True;
              Break;
            end;
          end;
          BaseObjectList.Free;

          if not boFind then begin
            BaseObjectList := TList.Create;
            BaseObject.GetMapEvents(BaseObject.m_PEnvir, I, II, nRange, BaseObjectList);
            for III := 0 to BaseObjectList.Count - 1 do begin
              Event := TEvent(BaseObjectList.Items[III]);
              if Event.m_nServerEventType = ET_MAGICLOCK then begin
                boFind := True;
                Break;
              end;
            end;
            BaseObjectList.Free;
          end;

          if not boFind then begin
            nTargetX := I;
            nTargetY := II;
            Break;
          end;
        end;
        if not boFind then Break;
      end;
    end;

    if not boFind then begin
      BaseObjectList := TList.Create;
      BaseObject.GetMapActorObjects(BaseObject.m_PEnvir, nTargetX, nTargetY, nRange - 1, BaseObjectList);
      for I := 0 to BaseObjectList.Count - 1 do begin
        TargeTActorObject := TActorObject(BaseObjectList.Items[I]);
        if (TargeTActorObject <> BaseObject) then begin
          TargeTActorObject.m_SpaceOwner := BaseObject;
          TargeTActorObject.m_boSpaceLock := True;
          TargeTActorObject.m_SpaceRect := Rect(nTargetX - nRange, nTargetY - nRange, nTargetX + nRange, nTargetY + nRange);
            //TargeTActorObject.SetSlaveLockSpace(TargeTActorObject.m_SpaceRect, BaseObject);
          BaseObject.AddLock(TargeTActorObject);
        end;
      end;
      BaseObjectList.Free;

      BaseObject.m_SpaceOwner := BaseObject;
      BaseObject.m_boSpaceLock := True;
      BaseObject.m_SpaceRect := Rect(nTargetX - nRange, nTargetY - nRange, nTargetX + nRange, nTargetY + nRange);

      nMinX := nTargetX - nRange;
      nMaxX := nTargetX + nRange;
      nMinY := nTargetY - nRange;
      nMaxY := nTargetY + nRange;

      for nX := nMinX to nMaxX do begin
        for nY := nMinY to nMaxY do begin
          if ((nX < nMaxX) and (nY = nMinY)) or
            ((nY < nMaxY) and (nX = nMinX)) or
            (nX = nMaxX) or (nY = nMaxY) then begin
            SpaceLockEvent := TSpaceLockEvent.Create(BaseObject, nX, nY, ET_HOLYCURTAIN, nDelayTime * 1000);
            g_EventManager.AddEvent(SpaceLockEvent);
          end;
        end;
      end;
      Result := True;
    end;
  end;
end;

function TMagicManager.IsWarrSkill(wMagIdx: Integer): Boolean; //是否是战士技能
begin
  Result := False;
  if wMagIdx in [SKILL_FENCING, SKILL_SPIRITSWORD, SKILL_SLAYING, SKILL_THRUSTING, SKILL_BANWOL {25}, SKILL_FIRESWORD {26}, SKILL_MOOTEBO {27}, SKILL_CROSSHALFMOON, SKILL_TWINDRAKEBLADE, SKILL_43 {43}, SKILL_58, SKILL_77 {77}, SKILL_60, SKILL_100, SKILL_101, SKILL_102, SKILL_103] then
    Result := True;
end;

function TMagicManager.DoSpell(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTActorObject: TActorObject): Boolean;
var
  boTrain: Boolean;
  boSpellFail: Boolean;
  boSpellFire: Boolean;
  n14: Integer;
  n18: Integer;
  n1C: Integer;
  nPower: Integer;
  StdItem: pTStdItem;
  nAmuletIdx: Integer;
  nX: Integer;
  nY: Integer;
  nPowerRate: Integer;
  nDelayTime: Integer;
  nDelayTimeRate: Integer;
  BaseObject: TActorObject;
  nMaxLevel: Integer;
  boSmall: Boolean;
  function MPow(UserMagic: pTUserMagic): Integer; //004921C8
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer; //00493314
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
  function GetPower13(nInt: Integer): Integer; //0049338C
  var
    d10: Double;
    d18: Double;
  begin
    d10 := nInt / 3.0;
    d18 := nInt - d10;
    Result := Round(d18 / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower)));
  end;
  function GetRPow(wInt: Integer): Word;
  begin
    if HiWord(wInt) > LoWord(wInt) then begin
      Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
    end else Result := LoWord(wInt);
  end;
  procedure sub_4934B4(PlayObject: TActorObject);
  begin
    {if PlayObject.m_UseItems[U_ARMRINGL].Dura < 100 then begin
      PlayObject.m_UseItems[U_ARMRINGL].Dura := 0;
      if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin
        TPlayObject(PlayObject).SendDelItems(@PlayObject.m_UseItems[U_ARMRINGL]);
      end else
        if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
        THeroObject(PlayObject).SendDelItems(@PlayObject.m_UseItems[U_ARMRINGL]);
      end;
      PlayObject.m_UseItems[U_ARMRINGL].wIndex := 0;
    end;}
  end;

begin
  Result := False;
  if PlayObject.m_boTDBeffect then exit; //tdb
  if IsWarrSkill(UserMagic.wMagIdx) then Exit;
  if PlayObject.m_boOnHorse or (PlayObject.m_NewStatus <> sNone) then Exit;
  if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) and ((abs(PlayObject.m_nCurrX - nTargetX) > g_Config.nMagicAttackRage) or (abs(PlayObject.m_nCurrY - nTargetY) > g_Config.nMagicAttackRage)) then begin
    Exit;
  end;
  if (PlayObject.m_btRaceServer = RC_HEROOBJECT) and (UserMagic.wMagIdx in [13, 45]) and (UserMagic.btLevel >= 4) then begin
    case UserMagic.wMagIdx of
      13: PlayObject.SendRefMsg(RM_SPELL, 67, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
      45: PlayObject.SendRefMsg(RM_SPELL, 66, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
    end;
  end else begin
    PlayObject.SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
  end;

  if (TargeTActorObject <> nil) and (TargeTActorObject.m_boDeath) and (UserMagic.MagicInfo.wMagicId <> SKILL_76) and (UserMagic.MagicInfo.wMagicId <> SKILL_54) then TargeTActorObject := nil;

  if UserMagic.wMagIdx in [SKILL_61..SKILL_65] then begin
    if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
      if PlayObject.m_Master <> nil then begin
        PlayObject.m_Master.m_btDirection := GetNextDirection(PlayObject.m_Master.m_nCurrX, PlayObject.m_Master.m_nCurrY, nTargetX, nTargetY);
        case UserMagic.wMagIdx of
          SKILL_61: begin
              if PlayObject.m_Master.m_btJob = 0 then begin
                PlayObject.m_Master.AttackDir(TargeTActorObject, 14, PlayObject.m_Master.m_btDirection);
              end;
            end;
          SKILL_62: begin
              if PlayObject.m_Master.m_btJob = 0 then begin
                PlayObject.m_Master.AttackDir(TargeTActorObject, 15, PlayObject.m_Master.m_btDirection);
              end;
            end;
          SKILL_63..SKILL_65: begin
              PlayObject.m_Master.SendMsg(PlayObject.m_Master, RM_SPELL3, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
              PlayObject.m_Master.SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
            end;
        end;
      end;
    end else begin
      with PlayObject do begin
        //MainOutMessage('TMagicManager.DoSpell3:'+IntToStr(UserMagic.wMagIdx));
        PlayObject.SendMsg(PlayObject, RM_SPELL3, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
      end;
    end;
  end;

  boTrain := False;
  boSpellFail := False;
  boSpellFire := True;
  nPower := 0;
  if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin
    if (not TPlayObject(PlayObject).m_boHeroVersion) and (TPlayObject(PlayObject).m_dwClientTick = 0) and (UserMagic.MagicInfo.wMagicId > 40) then Exit;
  end;

  case UserMagic.MagicInfo.wMagicId of
    SKILL_FIREBALL, // Fireball - ID: 1
      SKILL_GREATFIREBALL: begin // Great Fireball - ID: 5
        if MagMakeFireball(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          TargeTActorObject) then boTrain := True;
      end;
    SKILL_HEALLING: begin // Healing - ID: 2
        if MagTreatment(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          TargeTActorObject) then boTrain := True;
      end;
    SKILL_POISONING: begin // Poisoning - ID: 6
        if MagLightening(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject, boSpellFail) then
          boTrain := True;
      end;
    SKILL_REPULSION: begin // Repulsion - ID: 8
        if MagPushArround(PlayObject, UserMagic.btLevel) > 0 then boTrain := True;
      end;
    SKILL_HELLFIRE: begin // HellFire - ID: 9
        if MagMakeHellFire(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          TargeTActorObject) then boTrain := True;
      end;
    SKILL_LIGHTNING: begin // Lightning - ID: 10
        if MagMakeQuickLighting(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          TargeTActorObject) then boTrain := True;
      end;
    SKILL_THUNDERBOLT: begin // ThunderBolt - ID: 11
        if MagMakeLighting(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          TargeTActorObject) then boTrain := True;
      end;
      SKILL_SOULFIREBALL, // SoulFireBall - ID: 13
      SKILL_SOULSHIELD,   // SoulShield - ID: 14
      SKILL_DEJIWONHO {15},
      SKILL_HOLYSHIELD {16},
      SKILL_SKELLETON {17},
      SKILL_CLOAK {18},
      SKILL_BIGCLOAK {19},
      SKILL_57: begin //004940BC
        boSpellFail := True;
        if CheckAmulet(PlayObject, 1, 1, nAmuletIdx) then begin
          UseAmulet(PlayObject, 1, 1, nAmuletIdx);
          case UserMagic.MagicInfo.wMagicId of //
            SKILL_SOULFIREBALL: begin
                if MagMakeFireCharm(PlayObject,
                  UserMagic,
                  nTargetX,
                  nTargetY,
                  TargeTActorObject) then boTrain := True;
              end;
            SKILL_SOULSHIELD: begin
                nPower := PlayObject.GetAttackPower(GetPower13(60) + LoWord(PlayObject.m_WAbil.SC) * 10, Integer(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
                if PlayObject.MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower, 1, True) > 0 then
                  boTrain := True;
              end;
            SKILL_DEJIWONHO {15}: begin //神圣战甲术 004942E5
                nPower := PlayObject.GetAttackPower(GetPower13(60) + LoWord(PlayObject.m_WAbil.SC) * 10, Integer(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
                if PlayObject.MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower, 0, True) > 0 then
                  boTrain := True;
              end;
            SKILL_HOLYSHIELD {16}: begin //捆魔咒
                nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC),
                  Integer(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
                nDelayTime := GetPower13(40) + GetRPow(PlayObject.m_WAbil.SC) * 3;

                if MagMakeHolyCurtain(PlayObject, nPower,
                  nDelayTime,
                  nTargetX,
                  nTargetY) > 0 then
                  boTrain := True;

                {if MagMakeHolyCurtain(PlayObject, GetPower13(40) + GetRPow(PlayObject.m_WAbil.SC) * 3, nTargetX, nTargetY) > 0 then
                  boTrain := True;}
              end;
            SKILL_SKELLETON {17}: begin //召唤骷髅 004943A2
                if MagMakeSlave(PlayObject, UserMagic) then begin
                  boTrain := True;
                end;
              end;
            SKILL_CLOAK {18}: begin //隐身术
                if MagMakePrivateTransparent(PlayObject, GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC) * 3) then
                  boTrain := True;
              end;
            SKILL_BIGCLOAK {19}: begin //集体隐身术
                if MagMakeGroupTransparent(PlayObject, nTargetX, nTargetY, GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC) * 3) then
                  boTrain := True;
              end;
            SKILL_57: begin //复活术
                if MagMakeReAlive(PlayObject, UserMagic, TargeTActorObject) then boTrain := True;
              end;
          end;
          boSpellFail := False;
         // sub_4934B4(PlayObject);
        end;
      end;
    SKILL_52 {52}: begin //诅咒术
        boSpellFail := True;
        if CheckAmulet(PlayObject, 1, 3, nAmuletIdx) then begin
          UseAmulet(PlayObject, 1, 3, nAmuletIdx);
          nPower := PlayObject.GetAttackPower(GetPower13(20) + LoWord(PlayObject.m_WAbil.SC) * 2, Integer(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
          if PlayObject.MagMakeAbilityArea(nTargetX, nTargetY, 3, nPower) > 0 then
            boTrain := True;
          boSpellFail := False;
          sub_4934B4(PlayObject);
        end;
      end;
    SKILL_TAMMING {20}: begin //诱惑之光
        if PlayObject.IsProperTarget(TargeTActorObject) then begin
          if MagTamming(PlayObject, TargeTActorObject, nTargetX, nTargetY, UserMagic.btLevel) then
            boTrain := True;
        end;
      end;
    SKILL_SPACEMOVE {21}: begin //瞬息移动
        PlayObject.SendRefMsg(RM_MAGICFIRE, 0, MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect), MakeLong(nTargetX, nTargetY), Integer(TargeTActorObject), '');
        boSpellFire := False;
        if MagSaceMove(PlayObject, UserMagic.btLevel) then
          boTrain := True;
      end;
    SKILL_EARTHFIRE {22}: begin //火墙
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          Integer(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
        nDelayTime := GetPower(10) + (Word(GetRPow(PlayObject.m_WAbil.MC)) shr 1);

        //2006-11-12 火墙威力和时间的倍数
        nPowerRate := Round(nPower * (g_Config.nFirePowerRate / 100));
        nDelayTimeRate := Round(nDelayTime * (g_Config.nFireDelayTimeRate / 100));
        if MagMakeFireCross(PlayObject, nPowerRate,
          nDelayTimeRate,
          nTargetX,
          nTargetY) > 0 then
          boTrain := True;
      end;
    SKILL_FIREBOOM {23}: begin //FireBang
        if MagBigExplosion(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC), Integer(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
          nTargetX,
          nTargetY,
          g_Config.nFireBoomRage {1}, AT_FIRE) then
          boTrain := True;
      end;
    SKILL_LIGHTFLOWER {24}: begin //地狱雷光
        if MagElecBlizzard(PlayObject, PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC), Integer(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1)) then
          boTrain := True;
      end;
    SKILL_SHOWHP {28}: begin
        if (TargeTActorObject <> nil) and not TargeTActorObject.m_boShowHP then begin
          if Random(6) <= (UserMagic.btLevel + 3) then begin
            TargeTActorObject.m_dwShowHPTick := GetTickCount();
            TargeTActorObject.m_dwShowHPInterval := GetPower13(GetRPow(PlayObject.m_WAbil.SC) * 2 + 30) * 1000;
            TargeTActorObject.SendDelayMsg(TargeTActorObject, RM_DOOPENHEALTH, 0, 0, 0, 0, '', 1500);
            //TargeTActorObject.SendMsg(TargeTActorObject, RM_DOOPENHEALTH, 0, 0, 0, 0, '');
            boTrain := True;
          end;
        end;
      end;
    SKILL_BIGHEALLING {29}: begin //群体治疗术
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC) * 2,
          Integer(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) * 2 + 1);
        if MagBigHealing(PlayObject, nPower + PlayObject.m_WAbil.Level, nTargetX, nTargetY) then boTrain := True;
      end;
    SKILL_SINSU {30}: begin
        //MainOutMessage('g_Config.boAllowRecallDogz '+BooleanToStr(g_Config.boAllowRecallDogz));
        if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin
          if g_Config.boAllowRecallAll or g_Config.boAllowRecallDogz or (TPlayObject(PlayObject).GetMagicInfo(59) = nil) then begin
            boSpellFail := True;
            //MainOutMessage('MagMakeSinSuSlave(PlayObject, UserMagic)1');
            if CheckAmulet(PlayObject, 5, 1, nAmuletIdx) then begin
              UseAmulet(PlayObject, 5, 1, nAmuletIdx);
              //MainOutMessage('MagMakeSinSuSlave(PlayObject, UserMagic)2');
              if MagMakeSinSuSlave(PlayObject, UserMagic) then begin
                boTrain := True;
                //MainOutMessage('MagMakeSinSuSlave(PlayObject, UserMagic)3');
              end;
              boSpellFail := False;
            end;
          end;
        end else begin
          if g_Config.boAllowRecallAll or g_Config.boAllowRecallDogz or (TAIObject(PlayObject).FindMagic(59) = nil) then begin
            boSpellFail := True;
            if CheckAmulet(PlayObject, 5, 1, nAmuletIdx) then begin
              UseAmulet(PlayObject, 5, 1, nAmuletIdx);
              if MagMakeSinSuSlave(PlayObject, UserMagic) then begin
                boTrain := True;
              end;
              boSpellFail := False;
            end;
          end;
        end;
      end;
    SKILL_SHIELD {31}: begin //魔法盾
        if PlayObject.MagBubbleDefenceUp(UserMagic.btLevel, GetPower(GetRPow(PlayObject.m_WAbil.MC) + 15)) then
          boTrain := True;
      end;
    SKILL_KILLUNDEAD {32}: begin //圣言术
        if (TargeTActorObject <> nil) and (TargeTActorObject.m_btRaceServer <> RC_HEROOBJECT) and PlayObject.IsProperTarget(TargeTActorObject) then begin
          if MagTurnUndead(PlayObject, TargeTActorObject, nTargetX, nTargetY, UserMagic.btLevel) then
            boTrain := True;
        end;
      end;
    SKILL_SNOWWIND {33}: begin // Ice Storm
        if MagBigExplosion(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC), Integer(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
          nTargetX,
          nTargetY,
          g_Config.nSnowWindRange, AT_ICE) then
          boTrain := True;
      end;

    SKILL_FLAMEDISRUPTOR: begin // Flame Disruptor
        if MagMakeFireDay(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then boTrain := True;
      end;

    SKILL_ULTIMATEENHANCER: begin // Ultimate Enhancer
        if (GetTickCount - PlayObject.m_dwSkillUltimateEnhancerDelayTimeTick >= g_Config.nSkill50DelayTime * 1000) and (PlayObject.m_dwStatusArrTimeOutTick[0] <= 0) then begin
          PlayObject.m_dwSkillUltimateEnhancerDelayTimeTick := GetTickCount;
          if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin
            if TPlayObject(PlayObject).AbilityUp(UserMagic) then
              boTrain := True;
          end else
            if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
            if THeroObject(PlayObject).AbilityUp(UserMagic) then
              boTrain := True;
          end else
            if PlayObject.m_btRaceServer = RC_PLAYMOSTER then begin
            if TCopyObject(PlayObject).AbilityUp(UserMagic) then
              boTrain := True;
          end;
        end;
      end;

    SKILL_ENERGYREPULSOR: begin // Energy Repulsor
        if MagPushArround(PlayObject, UserMagic.btLevel) > 0 then boTrain := True;
      end;

    SKILL_FROSTCRUNCH: begin // Frost Crunch
        if MagHbFireBall(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then boTrain := True;
      end;

    SKILL_PURIFICATION: begin // Purification
        if MagMakeUnTreatment(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          TargeTActorObject) then boTrain := True;
      end;

    SKILL_SUMMONHOLYDEVA: begin
       //MainOutMessage('g_Config.boAllowRecallMoon '+BooleanToStr(g_Config.boAllowRecallMoon));
        if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin
          if g_Config.boAllowRecallAll or g_Config.boAllowRecallMoon or (TPlayObject(PlayObject).GetMagicInfo(30) = nil) then begin
            if (MagMakeMoonObj(PlayObject, UserMagic) <> nil) then boTrain := True;
          end;
        end else begin
          if g_Config.boAllowRecallAll or g_Config.boAllowRecallMoon or (TAIObject(PlayObject).FindMagic(30) = nil) then begin
            if (MagMakeMoonObj(PlayObject, UserMagic) <> nil) then boTrain := True;
          end;
        end;
      end;

    SKILL_WINDTEBO {35}: if MagWindTebo(PlayObject, UserMagic) then boTrain := True;

    //冰焰
    SKILL_MABE {36}: begin
        with PlayObject do begin
          nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC),
            Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
        end;
        if MabMabe(PlayObject, TargeTActorObject, nPower, UserMagic.btLevel, nTargetX, nTargetY) then
          boTrain := True;
      end;
    SKILL_GROUPLIGHTENING {37 群体雷电术}: begin
        if MagGroupLightening(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject, boSpellFire) then
        //if MagLighteningForbidVoodoo(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject, boSpellFire) then
          boTrain := True;
      end;
    SKILL_GROUPAMYOUNSUL {38 群体施毒术}: begin
        if MagGroupAmyounsul(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then
          boTrain := True;
      end;
    SKILL_GROUPDEDING {39 地钉}: begin
        if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin
          if GetTickCount - TPlayObject(PlayObject).m_dwDedingUseTick > g_Config.nDedingUseTime * 1000 then begin
            TPlayObject(PlayObject).m_dwDedingUseTick := GetTickCount;
            if MagGroupDeDing(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then
              boTrain := True;
          end;
        end else begin
          if (TargeTActorObject <> nil) and MagGroupDeDing(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then
            boTrain := True;
        end;
      end;
    SKILL_LIONROAR: begin // Lion Roar
        if MagGroupMb(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then
          boTrain := True;
      end;
    {SKILL_TWINDRAKEBLADE: begin //狂风斩
        if MagHbFireBall(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then boTrain := True;
      end;}
    SKILL_43: begin //破空剑
        if MagHbFireBall(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then boTrain := True;
      end;
    //法师


    SKILL_46: begin //分身术
        BaseObject := MagMakeSelf(PlayObject, TargeTActorObject, UserMagic);
        if BaseObject <> nil then begin
          boTrain := True;
          nX := BaseObject.m_nCurrX;
          nY := BaseObject.m_nCurrY;
        end;
      end;

    SKILL_47: begin //FlameField
        if MagFlameField(PlayObject,PlayObject.GetAttackPower (GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),SmallInt(HiWord(PlayObject.m_WAbil.MC)-LoWord(PlayObject.m_WAbil.MC))+ 1)) then
      end;
    //道士

    SKILL_49: begin //净化术
        boTrain := True;
      end;

    SKILL_51: begin //飓风破
        if MagGroupFengPo(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then boTrain := True;
      end;

    SKILL_53: begin //血咒
        if Random(10) <= UserMagic.btLevel then begin
                if MagMakeCurseArea(PlayObject,
                  UserMagic,
                  nTargetX,
                  nTargetY) then boTrain := True;
        end;
      end;
    SKILL_54: begin //骷髅咒
        if PlayObject.IsProperTargetSKILL_54(TargeTActorObject) then begin
          if MagTamming2(PlayObject, TargeTActorObject, nTargetX, nTargetY, UserMagic.btLevel) then
            boTrain := True;
        end;
      end;
    SKILL_55: begin //擒龙手
        if MagMakeArrestObject(PlayObject, UserMagic, TargeTActorObject) then boTrain := True;
      end;
    SKILL_56: begin //移行换位
        if MagChangePosition(PlayObject, nTargetX, nTargetY) then boTrain := True;
      end;



    SKILL_61: begin //劈星斩
        if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
          if MagMakeSkill_61(PlayObject,
            UserMagic,
            nTargetX,
            nTargetY,
            TargeTActorObject) then boTrain := True;
        end else boTrain := True;
      end;
    SKILL_62: begin //雷霆一击
        if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
          if MagMakeSkill_62(PlayObject,
            UserMagic,
            nTargetX,
            nTargetY,
            TargeTActorObject) then boTrain := True;
        end else boTrain := True;
      end;
    SKILL_63: begin //噬魂沼泽
        if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
          if MagMakeSkill_63(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then
            boTrain := True;
        end else boTrain := True;
      end;
    SKILL_64: begin //末日审判
        if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
          if MagMakeSkill_64(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then
            boTrain := True;
        end else boTrain := True;
      end;
    SKILL_65: begin //火龙气焰
        if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
          if MagMakeSkill_65(PlayObject, UserMagic, nTargetX, nTargetY) then
            boTrain := True;
        end else boTrain := True;
      end;

    SKILL_70, SKILL_71: begin
        if MagMakeGroupFireball(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          TargeTActorObject) then boTrain := True;
      end;
    SKILL_72: begin //群体灵魂火符
        boSpellFail := True;
        if CheckAmulet(PlayObject, 5, 1, nAmuletIdx) then begin
          UseAmulet(PlayObject, 5, 1, nAmuletIdx);

          if MagMakeGroupFireCharm(PlayObject,
            UserMagic,
            nTargetX,
            nTargetY,
            TargeTActorObject) then boTrain := True;

          boSpellFail := False;
          //sub_4934B4(PlayObject);
        //if MagGroupFengPo(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then boTrain := True;
        end;
      end;
    SKILL_73: begin

      end;
    SKILL_74: begin
        if MagMakeSpaceLock(PlayObject, UserMagic, nTargetX, nTargetY) then boTrain := True;
      end;

    SKILL_75: begin //流星火雨
        if MagMeteorShower(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY) then boTrain := True;
      end;
    SKILL_76: begin //噬血术
        boSpellFail := True;
        if CheckAmulet(PlayObject, 5, 1, nAmuletIdx) then begin
          UseAmulet(PlayObject, 5, 1, nAmuletIdx);
          if MagAbsorbBlood(PlayObject,
            UserMagic,
            nTargetX,
            nTargetY,
            TargeTActorObject) then boTrain := True;
          boSpellFail := False;
          //sub_4934B4(PlayObject);
        end;
      end;
    SKILL_198: begin //漫天火雨
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          Integer(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
        nDelayTime := GetPower(10) + (Word(GetRPow(PlayObject.m_WAbil.MC)) shr 1);

       { //2006-11-12 火墙威力和时间的倍数
        nPowerRate := Round(nPower * (g_Config.nFirePowerRate / 100));
        nDelayTimeRate := Round(nDelayTime * (g_Config.nFireDelayTimeRate / 100)); }
        if MagMakeSuperFireCross(PlayObject, nPower,
          nDelayTime,
          nTargetX,
          nTargetY, 8) > 0 then
          boTrain := True;
      end;
  {  SKILL_199: begin
        if MagMoonLowFireball(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          TargeTActorObject) then boTrain := True;
      end;
    SKILL_200: begin
        if MagMoonHighFireball(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          TargeTActorObject) then boTrain := True;
      end; }
    SKILL_103: begin
        if MagHeroGroup(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          TargeTActorObject) then boTrain := True;
      end;

    SKILL_104: begin
        if MagMakeSkill_104(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then
          boTrain := True;
      end;
    SKILL_105: begin
        if MagMakeSkill_105(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then
          boTrain := True;
      end;
    SKILL_106: begin
        if MagMakeSkill_106(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then
          boTrain := True;
      end;
    SKILL_107: begin
        if MagMakeSkill_107(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then
          boTrain := True;
      end;
    SKILL_108: begin
        if MagMakeSkill_108(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then
          boTrain := True;
      end;
    SKILL_109: begin
        if MagMakeSkill_109(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then
          boTrain := True;
      end;
    SKILL_110: begin
        if MagMakeSkill_110(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then
          boTrain := True;
      end;
    SKILL_111: begin
        if MagMakeSkill_111(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject) then
          boTrain := True;
      end;
  {  SKILL_104..SKILL_106, SKILL_109, SKILL_111: begin
        if MagMakeFireball(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          TargeTActorObject) then boTrain := True;
      end;

    SKILL_107, SKILL_108, SKILL_110: begin
        if MagBigExplosion(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC), Integer(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
          nTargetX,
          nTargetY,
          g_Config.nSnowWindRange, AT_ICE) then
          boTrain := True;
      end;    }

  else begin
      if Assigned(PlugInEngine.SetHookDoSpell) then begin
        boTrain := PlugInEngine.SetHookDoSpell(Self, TPlayObject(PlayObject), UserMagic, nTargetX, nTargetY, TargeTActorObject, boSpellFail, boSpellFire);
      end;
    end;
  end;
  if boSpellFail then Exit;
  if boSpellFire then begin
    if UserMagic.MagicInfo.wMagicId = SKILL_46 then begin
      PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
        MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
        MakeLong(nX, nY),
        Integer(BaseObject),
        '');
    end else begin
      if (PlayObject.m_btRaceServer = RC_HEROOBJECT) and (UserMagic.wMagIdx in [13, 45]) and (UserMagic.btLevel >= 4) then begin
        case UserMagic.wMagIdx of
          13: PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
              MakeWord(UserMagic.MagicInfo.btEffectType, 67),
              MakeLong(nTargetX, nTargetY),
              Integer(TargeTActorObject),
              '');
          45: PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
              MakeWord(UserMagic.MagicInfo.btEffectType, 66),
              MakeLong(nTargetX, nTargetY),
              Integer(TargeTActorObject),
              '');
        end;
      end else begin
        PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
          MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
          MakeLong(nTargetX, nTargetY),
          Integer(TargeTActorObject),
          '');
        //MainOutMessage('btEffectType:'+IntToStr(UserMagic.MagicInfo.btEffectType)+' btEffecte:'+IntToStr(UserMagic.MagicInfo.btEffect));
        if UserMagic.wMagIdx in [SKILL_61..SKILL_65] then begin //合击
          if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
            if PlayObject.m_Master <> nil then begin
              case UserMagic.wMagIdx of
                SKILL_62..SKILL_65: begin
                    PlayObject.m_Master.SendRefMsg(RM_MAGICFIRE, 0,
                      MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
                      MakeLong(nTargetX, nTargetY),
                      Integer(TargeTActorObject),
                      '');
                  end;
              end;
            end;
          end;
        end;

      end;
    end;
  end;

  if ((PlayObject.m_btRaceServer = RC_HEROOBJECT) and (UserMagic.wMagIdx in [160,161])) then //or (UserMagic.wMagIdx = 31) then
    nMaxLevel := 4 else nMaxLevel := 3;

  if boTrain and (UserMagic.wMagIdx in [SKILL_61..SKILL_65]) and (PlayObject.m_btRaceServer <> RC_HEROOBJECT) then begin
    boTrain := False;
  end;

  if (UserMagic.btLevel < nMaxLevel) and (boTrain) then begin //4级魔法
    boSmall := False;
    if ((PlayObject.m_btRaceServer = RC_HEROOBJECT) and (UserMagic.wMagIdx in [160,161])) then begin //or (UserMagic.wMagIdx = 31) then begin
      if UserMagic.btLevel >= 3 then begin
        boSmall := UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel - 1] <= PlayObject.m_Abil.Level;
      end else begin
        boSmall := UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel] <= PlayObject.m_Abil.Level;
      end;
    end else begin
      boSmall := UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel] <= PlayObject.m_Abil.Level;
    end;


    if boSmall then begin
      PlayObject.TrainSkill(UserMagic, Random(3) + 1);
      if not PlayObject.CheckMagicLevelup(UserMagic) then begin
        if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin
          PlayObject.SendDelayMsg(PlayObject, RM_MAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 1000);
        end else
          if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
          THeroObject(PlayObject).SendDelayMsg(PlayObject, RM_MAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 1000);
        end else begin
          //PlayObject.SendDelayMsg(PlayObject, RM_MAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 1000);
        end;
      end;
    end;
  end;
  Result := True;
end;

function TMagicManager.MagMakePrivateTransparent(BaseObject: TActorObject; nHTime: Integer): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTActorObject: TActorObject;
begin
  Result := False;
  if BaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] > 0 then Exit;
  BaseObjectList := TList.Create;
  BaseObject.GetMapActorObjects(BaseObject.m_PEnvir, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 9, BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    TargeTActorObject := TActorObject(BaseObjectList.Items[I]);
    if (TargeTActorObject.m_btRaceServer >= RC_ANIMAL) and (TargeTActorObject.m_TargetCret = BaseObject) then begin
      if (abs(TargeTActorObject.m_nCurrX - BaseObject.m_nCurrX) > 1) or
        (abs(TargeTActorObject.m_nCurrY - BaseObject.m_nCurrY) > 1) or
        (Random(2) = 0) then begin
        TargeTActorObject.m_TargetCret := nil;
      end;
    end;
  end;
  BaseObjectList.Free;
  BaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] := nHTime;
  BaseObject.m_nCharStatus := BaseObject.GetCharStatus();
  BaseObject.StatusChanged();
  BaseObject.m_boHideMode := True;
  BaseObject.m_boTransparent := True;
  Result := True;
end;

function TMagicManager.MagReturn(BaseObject, TargeTActorObject: TActorObject;
  nTargetX, nTargetY, nMagicLevel: Integer): Boolean;
begin
  Result := False;
  TargeTActorObject.ReAlive;
  TargeTActorObject.m_WAbil.HP := TargeTActorObject.m_WAbil.MaxHP;
  TargeTActorObject.SendMsg(TargeTActorObject, RM_ABILITY, 0, 0, 0, 0, '');
  Result := True;
end;

function TMagicManager.MagTamming2(BaseObject, TargeTActorObject: TActorObject;
  nTargetX, nTargetY, nMagicLevel: Integer): Boolean;
var
  n14: Integer;
begin
  Result := False;
  if (TargeTActorObject.m_btRaceServer <> RC_PLAYOBJECT) and ((Random(4 - nMagicLevel) = 0)) then begin
    TargeTActorObject.m_TargetCret := nil;
    if Random(2) = 0 then begin
      if TargeTActorObject.m_Abil.Level <= BaseObject.m_Abil.Level + 2 then begin
        if Random(3) = 0 then begin
          if Random((BaseObject.m_Abil.Level + 20) + (nMagicLevel * 5)) > (TargeTActorObject.m_Abil.Level + g_Config.nMagTammingTargetLevel {10}) then begin
            if not (TargeTActorObject.bo2C1) and
              (TargeTActorObject.m_btLifeAttrib = 0) and
              (TargeTActorObject.m_Abil.Level < g_Config.nMagTammingLevel {50}) and
              (BaseObject.m_SlaveList.Count < g_Config.nMagTammingCount {(nMagicLevel + 2)}) then begin
              TargeTActorObject.m_Master := BaseObject;
              TargeTActorObject.m_dwMasterRoyaltyTick := LongWord((Random(BaseObject.m_Abil.Level * 2) + (nMagicLevel shl 2) * 5 + 20) * 60 * 1000) + GetTickCount;
              TargeTActorObject.m_btSlaveMakeLevel := nMagicLevel;
              if TargeTActorObject.m_dwMasterTick = 0 then TargeTActorObject.m_dwMasterTick := GetTickCount();
              TargeTActorObject.BreakHolySeizeMode();
              if LongWord(1500 - nMagicLevel * 200) < LongWord(TargeTActorObject.m_nWalkSpeed) then begin
                TargeTActorObject.m_nWalkSpeed := 1500 - nMagicLevel * 200;
              end;
              if LongWord(2000 - nMagicLevel * 200) < LongWord(TargeTActorObject.m_nNextHitTime) then begin
                TargeTActorObject.m_nNextHitTime := 2000 - nMagicLevel * 200;
              end;
              TargeTActorObject.ReAlive;
              TargeTActorObject.m_WAbil.HP := TargeTActorObject.m_WAbil.MaxHP;
              TargeTActorObject.SendMsg(TargeTActorObject, RM_ABILITY, 0, 0, 0, 0, '');
              TargeTActorObject.RefShowName();
              BaseObject.m_SlaveList.Add(TargeTActorObject);
            end;
          end;
        end else begin
          if not (TargeTActorObject.m_btLifeAttrib = LA_UNDEAD) and (Random(20) = 0) then
            TargeTActorObject.OpenCrazyMode(Random(20) + 10);
        end;
      end else begin
        if not (TargeTActorObject.m_btLifeAttrib = LA_UNDEAD) then
          TargeTActorObject.OpenCrazyMode(Random(20) + 10); //变红
      end;
    end;
  end;
  Result := True;
end;

function TMagicManager.MagTamming(BaseObject, TargeTActorObject: TActorObject;
  nTargetX, nTargetY, nMagicLevel: Integer): Boolean;
var
  n14: Integer;
begin
  Result := False;
  if (TargeTActorObject.m_btRaceServer <> RC_PLAYOBJECT) and (TargeTActorObject.m_btRaceServer <> RC_HEROOBJECT) and ((Random(4 - nMagicLevel) = 0)) then begin
    TargeTActorObject.m_TargetCret := nil;
    if TargeTActorObject.m_Master = BaseObject then begin
      TargeTActorObject.OpenHolySeizeMode((nMagicLevel * 5 + 10) * 1000);
      Result := True;
    end else begin
      if Random(2) = 0 then begin
        if TargeTActorObject.m_Abil.Level <= BaseObject.m_Abil.Level + 2 then begin
          if Random(3) = 0 then begin
            if Random((BaseObject.m_Abil.Level + 20) + (nMagicLevel * 5)) > (TargeTActorObject.m_Abil.Level + g_Config.nMagTammingTargetLevel {10}) then begin
              if not (TargeTActorObject.bo2C1) and
                (TargeTActorObject.m_btLifeAttrib = 0) and
                (TargeTActorObject.m_Abil.Level < g_Config.nMagTammingLevel {50}) and
                (BaseObject.m_SlaveList.Count < g_Config.nMagTammingCount {(nMagicLevel + 2)}) then begin
                if g_Config.nMagTammingHPRate <= 0 then g_Config.nMagTammingHPRate := 100;
                n14 := TargeTActorObject.m_WAbil.MaxHP div g_Config.nMagTammingHPRate {100};
                if n14 <= 2 then n14 := 2
                else Inc(n14, n14);
                if (TargeTActorObject.m_Master <> BaseObject) and (Random(n14) = 0) then begin
                  TargeTActorObject.BreakCrazyMode();
                  if TargeTActorObject.m_Master <> nil then begin
                    TargeTActorObject.m_WAbil.HP := TargeTActorObject.m_WAbil.HP div 10;
                  end;
                  TargeTActorObject.m_Master := BaseObject;
                  TargeTActorObject.m_dwMasterRoyaltyTick := LongWord((Random(BaseObject.m_Abil.Level * 2) + (nMagicLevel shl 2) * 5 + 20) * 60 * 1000) + GetTickCount;
                  TargeTActorObject.m_btSlaveMakeLevel := nMagicLevel;
                  if TargeTActorObject.m_dwMasterTick = 0 then TargeTActorObject.m_dwMasterTick := GetTickCount();
                  TargeTActorObject.BreakHolySeizeMode();
                  if LongWord(1500 - nMagicLevel * 200) < LongWord(TargeTActorObject.m_nWalkSpeed) then begin
                    TargeTActorObject.m_nWalkSpeed := 1500 - nMagicLevel * 200;
                  end;
                  if LongWord(2000 - nMagicLevel * 200) < LongWord(TargeTActorObject.m_nNextHitTime) then begin
                    TargeTActorObject.m_nNextHitTime := 2000 - nMagicLevel * 200;
                  end;
                  TargeTActorObject.RefShowName();
                  BaseObject.m_SlaveList.Add(TargeTActorObject);
                end else begin //004925F2
                  if Random(14) = 0 then TargeTActorObject.m_WAbil.HP := 0;
                end;
              end else begin //00492615
                if (TargeTActorObject.m_btLifeAttrib = LA_UNDEAD) and (Random(20) = 0) then
                  TargeTActorObject.m_WAbil.HP := 0;
              end;
            end else begin //00492641
              if not (TargeTActorObject.m_btLifeAttrib = LA_UNDEAD) and (Random(20) = 0) then
                TargeTActorObject.OpenCrazyMode(Random(20) + 10);
            end;
          end else begin //00492674
            if not (TargeTActorObject.m_btLifeAttrib = LA_UNDEAD) then
              TargeTActorObject.OpenCrazyMode(Random(20) + 10); //变红
          end;
        end; //004926B0
      end else begin //00492699
        TargeTActorObject.OpenHolySeizeMode((nMagicLevel * 5 + 10) * 1000);
      end;
      Result := True;
    end;
  end else begin
    if Random(2) = 0 then Result := True;
  end;
end;

function TMagicManager.MagTurnUndead(BaseObject, TargeTActorObject: TActorObject;
  nTargetX, nTargetY, nLevel: Integer): Boolean; //004926D4
var
  n14: Integer;
begin
  Result := False;
  if TargeTActorObject.m_boSuperMan or not (TargeTActorObject.m_btLifeAttrib = LA_UNDEAD) then Exit;

  if TargeTActorObject.m_btRaceServer in [60, RC_HEROOBJECT, RC_PLAYMOSTER] then begin
    TAnimalObject(TargeTActorObject).Struck {FFEC}(BaseObject);
    if TargeTActorObject.m_TargetCret = nil then begin
      TAnimalObject(TargeTActorObject).m_boRunAwayMode := True;
      TAnimalObject(TargeTActorObject).m_dwRunAwayStart := GetTickCount();
      TAnimalObject(TargeTActorObject).m_dwRunAwayTime := 10 * 1000;
    end;
  end else begin
    TAnimalObject(TargeTActorObject).Struck {FFEC}(BaseObject);
    if TargeTActorObject.m_TargetCret = nil then begin
      TAnimalObject(TargeTActorObject).m_boRunAwayMode := True;
      TAnimalObject(TargeTActorObject).m_dwRunAwayStart := GetTickCount();
      TAnimalObject(TargeTActorObject).m_dwRunAwayTime := 10 * 1000;
    end;
  end;
  BaseObject.SetTargetCreat(TargeTActorObject);
  if (Random(2) + (BaseObject.m_Abil.Level - 1)) > TargeTActorObject.m_Abil.Level then begin
    if TargeTActorObject.m_Abil.Level < g_Config.nMagTurnUndeadLevel then begin
      n14 := BaseObject.m_Abil.Level - TargeTActorObject.m_Abil.Level;
      if Random(100) < ((nLevel shl 3) - nLevel + 15 + n14) then begin
        TargeTActorObject.SetLastHiter(BaseObject);
        TargeTActorObject.m_WAbil.HP := 0;
        Result := True;
      end
    end;
  end;
end;

function TMagicManager.MagWindTebo(PlayObject: TActorObject;
  UserMagic: pTUserMagic): Boolean;
var
  PoseBaseObject: TActorObject;
begin
  Result := False;
  PoseBaseObject := PlayObject.GetPoseCreate;
  if (PoseBaseObject <> nil) and
    (PoseBaseObject <> PlayObject) and
    (not PoseBaseObject.m_boDeath) and
    (not PoseBaseObject.m_boGhost) and
    (PlayObject.IsProperTarget(PoseBaseObject)) and
    (not PoseBaseObject.m_boStickMode) then begin
    if (abs(PlayObject.m_nCurrX - PoseBaseObject.m_nCurrX) <= 1) and
      (abs(PlayObject.m_nCurrY - PoseBaseObject.m_nCurrY) <= 1) and
      (PlayObject.m_Abil.Level > PoseBaseObject.m_Abil.Level) then begin
      if Random(20) < UserMagic.btLevel * 6 + 46 + (PlayObject.m_Abil.Level - PoseBaseObject.m_Abil.Level) then begin
        PoseBaseObject.CharPushed(GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, PoseBaseObject.m_nCurrX, PoseBaseObject.m_nCurrY), _MAX(0, UserMagic.btLevel - 1) + 1);
        Result := True;
      end;
    end;
  end;
end;

function TMagicManager.MagSaceMove(BaseObject: TActorObject;
  nLevel: Integer): Boolean;
var
  Envir: TEnvirnoment;
  PlayObject: TPlayObject;
begin
  Result := False;
  if Random(11) < nLevel * 2 + 4 then begin
    BaseObject.SendRefMsg(RM_SPACEMOVE_FIRE2, 0, 0, 0, 0, '');
    if BaseObject is TPlayObject then begin
      Envir := BaseObject.m_PEnvir;
      BaseObject.MapRandomMove(BaseObject.m_sHomeMap, 1);
      if (Envir <> BaseObject.m_PEnvir) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
        PlayObject := TPlayObject(BaseObject);
        PlayObject.m_boTimeRecall := False;
      end;
    end;
    Result := True;
  end;
end;

function TMagicManager.MagGroupFengPo(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTActorObject: TActorObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TActorObject;
  nPower: Integer;
  NotDefendoof: Boolean;
begin
  Result := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapActorObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TActorObject(BaseObjectList.Items[I]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin
      nPower := PlayObject.GetAttackPower(LoWord(PlayObject.m_WAbil.SC), Integer((HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC))));
      {if (Random(BaseObject.m_btSpeedPoint) >= PlayObject.m_btHitPoint) then begin    //敏捷 > 准确度 攻击无效
        nPower := 0;
      end;  }
      if nPower > 0 then begin

        BaseObject.m_boNotDefendoof := PlayObject.GetNotDefendoof;
        nPower := nPower + PlayObject.GetAddPowerPoint(5, nPower);

        nPower := BaseObject.GetHitStruckDamage(PlayObject, nPower);
      end;
      BaseObject.StartNewShield();
      if nPower > 0 then begin
        BaseObject.StruckDamage(nPower);

        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), MakeLong(1, Integer(BaseObject.m_boNotDefendoof)), Integer(BaseObject), '', 200);
      end;
      //if BaseObject.m_btRaceServer >= RC_ANIMAL then
      Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagGroupAmyounsul(PlayObject: TActorObject { 修改 TActorObject};
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTActorObject: TActorObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TActorObject;
  nPower: Integer;
  StdItem: pTStdItem;
  nAmuletIdx: Integer;
  nIndex: Integer;
  UserItem: pTUserItem;
begin
  Result := False;
  StdItem := nil;
  BaseObjectList := TList.Create;
  PlayObject.GetMapActorObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TActorObject(BaseObjectList.Items[I]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin
      if CheckAmulet(PlayObject, 2, 2, nAmuletIdx) then begin
        if nAmuletIdx < 13 then begin
          StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nAmuletIdx].wIndex);
        end else begin //直接使用包裹中的物品
          if (PlayObject.m_btRaceServer = RC_HEROOBJECT) or (PlayObject.m_btRaceServer = RC_PLAYMOSTER) then begin
            nIndex := TAIObject(PlayObject).GetUserItemList(TAIObject(PlayObject).m_nSelItemType, 2);
            if (nIndex >= 0) and (nIndex < PlayObject.m_ItemList.Count) then begin
              UserItem := PlayObject.m_ItemList.Items[nIndex];
              StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            end;
          end;
        end;
        if StdItem <> nil then begin
          UseAmulet(PlayObject, 2, 2, nAmuletIdx);
          if Random(BaseObject.m_btAntiPoison + 7) <= 6 then begin
            case StdItem.Shape of
              1: begin
                  nPower := GetPower13(40, UserMagic) + GetRPow(PlayObject.m_WAbil.SC) * 2;

                  nPower := PlayObject._GetAtomPower(BaseObject, AT_DARK, nPower);
                  nPower := nPower + BaseObject.GetAddPowerPoint(5, nPower);
                  nPower := BaseObject.GetAddPowerPoint(False, nPower);

                  BaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DECHEALTH {中毒类型 - 绿毒}, nPower, Integer(PlayObject), Round(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                end;
              2: begin
                  nPower := GetPower13(30, UserMagic) + GetRPow(PlayObject.m_WAbil.SC) * 2;

                  nPower := PlayObject._GetAtomPower(BaseObject, AT_DARK, nPower);
                  nPower := nPower + BaseObject.GetAddPowerPoint(5, nPower);
                  nPower := BaseObject.GetAddPowerPoint(False, nPower);

                  BaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DAMAGEARMOR {中毒类型 - 红毒}, nPower, Integer(PlayObject), Round(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                end;
            end;
            //if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer >= RC_ANIMAL) then

            BaseObject.SetLastHiter(PlayObject);
            PlayObject.SetTargetCreat(BaseObject);
          end;
        end;
        Result := True;
      end;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagGroupDeDing(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTActorObject: TActorObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TActorObject;
  nPower: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapActorObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TActorObject(BaseObjectList.Items[I]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
    if ((BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT)) and not g_Config.boDedingAllowPK then Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin
      nPower := PlayObject.GetAttackPower(LoWord(PlayObject.m_WAbil.DC), Integer((HiWord(PlayObject.m_WAbil.DC) - LoWord(PlayObject.m_WAbil.DC))));

      if (Random(BaseObject.m_btSpeedPoint) >= PlayObject.m_btHitPoint) then begin //敏捷 > 准确度 攻击无效
        nPower := 0;
      end;

      nPower := PlayObject._GetAtomPower(BaseObject, AT_DARK, nPower);
      BaseObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御
      nPower := nPower + PlayObject.GetAddPowerPoint(5, nPower);

      if nPower > 0 then begin
        nPower := BaseObject.GetHitStruckDamage(PlayObject, nPower);
      end;

      nPower := Round(nPower * (g_Config.nDidingPowerRate / 100));

      BaseObject.StruckDamage(nPower);
      BaseObject.StartNewShield();
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), MakeLong(1, Integer(BaseObject.m_boNotDefendoof)), Integer(BaseObject), '', 200);
     // if BaseObject.m_btRaceServer >= RC_ANIMAL then
      Result := True;
    end;
    PlayObject.SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 1, '');
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagGroupLightening(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTActorObject: TActorObject; var boSpellFire: Boolean): Boolean; //群体雷电术
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TActorObject;
  nPower: Integer;
  boNotDefendoof: Boolean;
begin
  Result := False;
  boSpellFire := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapActorObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
    MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
    MakeLong(nTargetX, nTargetY),
    Integer(TargeTActorObject),
    '');
  for I := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TActorObject(BaseObjectList.Items[I]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin
      if (Random(10) >= BaseObject.m_nAntiMagic) then begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
          Integer(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
        if BaseObject.m_btLifeAttrib = LA_UNDEAD then
          nPower := Round(nPower * 1.5);

        nPower := PlayObject._GetAtomPower(BaseObject, AT_LIGHT, nPower);
        BaseObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御

        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), MakeLong(2, Integer(BaseObject.m_boNotDefendoof)), Integer(BaseObject), '', 600);
       { if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
        else if BaseObject.m_btRaceServer >= RC_ANIMAL then Result := True;  }
      end;
      Result := True;
      if (BaseObject.m_nCurrX <> nTargetX) or (BaseObject.m_nCurrY <> nTargetY) then
        PlayObject.SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 4 {type}, '');
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagFlameField(BaseObject: TActorObject; nPower: integer): Boolean;
var
  I                :Integer;
  BaseObjectList   :TList;
  TargeTActorObject: TActorObject;
  nPowerPoint: Integer;
begin
  Result         := False;
  BaseObjectList := TList.Create;
  BaseObject.GetMapActorObjects(BaseObject.m_PEnvir,BaseObject.m_nCurrX,BaseObject.m_nCurrY,2,BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    TargeTActorObject :=TActorObject(BaseObjectList.Items[i]);
    if BaseObject.IsProperTarget(TargeTActorObject) then begin
      //BaseObject.SetTargetCreat(TargeTBaseObject);
       nPowerPoint := nPower;
       nPowerPoint := BaseObject._GetAtomPower(TargeTActorObject, AT_FIRE, nPower);
      TargeTActorObject.m_boNotDefendoof := BaseObject.GetNotDefendoof; //Get element person is weak too?
      nPowerPoint := nPowerPoint + BaseObject.GetAddPowerPoint(5, nPowerPoint);

      TargeTActorObject.SendMsg(BaseObject,RM_MAGSTRUCK,0,nPowerPoint,Integer(TargeTActorObject.m_boNotDefendoof),0,'');
      Result:=True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagLighteningForbidVoodoo(PlayObject: TActorObject; //雷系禁咒
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTActorObject: TActorObject; var boSpellFire: Boolean): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TActorObject;
  nPower: Integer;
begin
  Result := False;
  boSpellFire := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapActorObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, 12, BaseObjectList);
  PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
    MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
    MakeLong(nTargetX, nTargetY),
    Integer(TargeTActorObject),
    '');
  for I := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TActorObject(BaseObjectList.Items[I]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin
      if (Random(10) >= BaseObject.m_nAntiMagic) then begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
          Integer(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
        if BaseObject.m_btLifeAttrib = LA_UNDEAD then
          nPower := Round(nPower * 1.5);

        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 2, Integer(BaseObject), '', 600);
       { if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
        else if BaseObject.m_btRaceServer >= RC_ANIMAL then Result := True; }
      end;
      Result := True;
      if (BaseObject.m_nCurrX <> nTargetX) or (BaseObject.m_nCurrY <> nTargetY) then
        PlayObject.SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 4 {type}, '');
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagLightening(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTActorObject: TActorObject; var boSpellFire: Boolean): Boolean;
var
  boSpellFail: Boolean;
  nPower: Integer;
  StdItem: pTStdItem;
  nAmuletIdx: Integer;
  nIndex: Integer;
  UserItem: pTUserItem;
  function GetPower13(nInt: Integer): Integer; //0049338C
  var
    d10: Double;
    d18: Double;
  begin
    d10 := nInt / 3.0;
    d18 := nInt - d10;
    Result := Round(d18 / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower)));
  end;
  function GetRPow(wInt: Integer): Word;
  begin
    if HiWord(wInt) > LoWord(wInt) then begin
      Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
    end else Result := LoWord(wInt);
  end;
begin //施毒术
  Result := False;
  boSpellFail := True;
  StdItem := nil;
  if PlayObject.IsProperTarget(TargeTActorObject) then begin
    if CheckAmulet(PlayObject, 1, 2, nAmuletIdx) then begin
      if nAmuletIdx < 13 then begin
        StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nAmuletIdx].wIndex);
      end else begin //直接使用包裹中的物品
        if (PlayObject.m_btRaceServer = RC_HEROOBJECT) or (PlayObject.m_btRaceServer = RC_PLAYMOSTER) then begin
          nIndex := TAIObject(PlayObject).GetUserItemList(TAIObject(PlayObject).m_nSelItemType, 2);
          if (nIndex >= 0) and (nIndex < PlayObject.m_ItemList.Count) then begin
            UserItem := PlayObject.m_ItemList.Items[nIndex];
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          end;
        end;
      end;
      if StdItem <> nil then begin
        UseAmulet(PlayObject, 1, 2, nAmuletIdx);
        if Random(TargeTActorObject.m_btAntiPoison + 7) <= 6 then begin
          case StdItem.Shape of
            1: begin
                nPower := GetPower13(40) + GetRPow(PlayObject.m_WAbil.SC) * 2;

                nPower := PlayObject._GetAtomPower(TargeTActorObject, AT_DARK, nPower);
                TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御
                nPower := nPower + PlayObject.GetAddPowerPoint(5, nPower);
                nPower := TargeTActorObject.GetAddPowerPoint(False, nPower);

                TargeTActorObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DECHEALTH {中毒类型 - 绿毒}, nPower, Integer(PlayObject), Round(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
              end;
            2: begin
                nPower := GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC) * 2;

                nPower := PlayObject._GetAtomPower(TargeTActorObject, AT_DARK, nPower);
                TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御
                nPower := nPower + PlayObject.GetAddPowerPoint(5, nPower);
                nPower := TargeTActorObject.GetAddPowerPoint(False, nPower);

                TargeTActorObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DAMAGEARMOR {中毒类型 - 红毒}, nPower, Integer(PlayObject), Round(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
              end;
          end;
          {if (TargeTActorObject.m_btRaceServer = RC_PLAYOBJECT) or (TargeTActorObject.m_btRaceServer >= RC_ANIMAL) then
            Result := True;}
        end;
        TargeTActorObject.SetLastHiter(PlayObject);
        PlayObject.SetTargetCreat(TargeTActorObject);
        boSpellFail := False;
        Result := True;
      end;

    end;
  end;
end;

function TMagicManager.MagHbFireBall(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTActorObject: TActorObject): Boolean;
var
  nPower: Integer;
  nDir: Integer;
  levelgap: Integer;
  push: Integer;
begin
  Result := False;
  if not PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTActorObject) then begin
    TargeTActorObject := nil;
    Exit;
  end;
  if not PlayObject.IsProperTarget(TargeTActorObject) then begin
    TargeTActorObject := nil;
    Exit;
  end;
  if (TargeTActorObject.m_nAntiMagic > Random(10)) or (abs(TargeTActorObject.m_nCurrX - nTargetX) > 1) or (abs(TargeTActorObject.m_nCurrY - nTargetY) > 1) then begin
    TargeTActorObject := nil;
    Exit;
  end;
  with PlayObject do begin
    nPower := GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(m_WAbil.MC),
      Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
  end;

  TargeTActorObject.m_boNotDefendoof := PlayObject.GetNotDefendoof; //忽视目标防御

  PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTActorObject), '', 600);
  if (TargeTActorObject.m_btRaceServer >= RC_ANIMAL) then Result := True;

  if (PlayObject.m_Abil.Level > TargeTActorObject.m_Abil.Level) and (not TargeTActorObject.m_boStickMode) then begin
    levelgap := PlayObject.m_Abil.Level - TargeTActorObject.m_Abil.Level;
    if (Random(20) < 6 + UserMagic.btLevel * 3 + levelgap) then begin
      push := Random(UserMagic.btLevel) - 1;
      if push > 0 then begin
        nDir := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTActorObject.m_nCurrX, TargeTActorObject.m_nCurrY);
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYPUSHED, nDir, MakeLong(nTargetX, nTargetY), push, Integer(TargeTActorObject), '', 600);
      end;
    end;
  end;
end;

//产生任意形状的火

function TMagicManager.MagMakeSuperFireCross(PlayObject: TActorObject; nDamage,
  nHTime, nX, nY: Integer; nCount: Integer): Integer;
  function MagMakeSuperFireCrossOfDir(btDir: Integer): Integer;
  var
    FireBurnEvent: TFireBurnEvent;
    I, II, x, y: Integer;
    nTime: Integer;
    X1, X2, Y1, Y2: string;
  begin
    Result := 0;
    nTime := 1;
    case btDir of
      DR_UP: begin
          for y := PlayObject.m_nCurrY downto PlayObject.m_nCurrY - 10 do begin
            if g_EventManager.GetEvent(PlayObject.m_PEnvir, PlayObject.m_nCurrX, y, ET_FIRE) = nil then begin
              FireBurnEvent := TFireBurnEvent.Create(PlayObject, PlayObject.m_nCurrX, y, ET_FIRE, nHTime * nTime, nDamage);
              g_EventManager.AddEvent(FireBurnEvent);
              Inc(nTime);
            end;
          end;
        end;
      DR_UPRIGHT: begin
          for I := 0 to 6 do begin
            x := PlayObject.m_nCurrX + I;
            y := PlayObject.m_nCurrY - I;
            if g_EventManager.GetEvent(PlayObject.m_PEnvir, x, y, ET_FIRE) = nil then begin
              FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, y, ET_FIRE, nHTime * nTime * 2, nDamage);
              g_EventManager.AddEvent(FireBurnEvent);
              Inc(nTime);
            end;
          end;
        end;
      DR_RIGHT: begin
          for x := PlayObject.m_nCurrX to PlayObject.m_nCurrX + 10 do begin
            if g_EventManager.GetEvent(PlayObject.m_PEnvir, x, PlayObject.m_nCurrY, ET_FIRE) = nil then begin
              FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, PlayObject.m_nCurrY, ET_FIRE, nHTime * nTime, nDamage);
              g_EventManager.AddEvent(FireBurnEvent);
              Inc(nTime);
            end;
          end;
        end;
      DR_DOWNRIGHT: begin
          for I := 0 to 6 do begin
            x := PlayObject.m_nCurrX + I;
            y := PlayObject.m_nCurrY + I;
            if g_EventManager.GetEvent(PlayObject.m_PEnvir, x, y, ET_FIRE) = nil then begin
              FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, y, ET_FIRE, nHTime * nTime * 2, nDamage);
              g_EventManager.AddEvent(FireBurnEvent);
              Inc(nTime);
            end;
          end;
        end;
      DR_DOWN: begin
          for y := PlayObject.m_nCurrY to PlayObject.m_nCurrY + 10 do begin
            if g_EventManager.GetEvent(PlayObject.m_PEnvir, PlayObject.m_nCurrX, y, ET_FIRE) = nil then begin
              FireBurnEvent := TFireBurnEvent.Create(PlayObject, PlayObject.m_nCurrX, y, ET_FIRE, nHTime * nTime, nDamage);
              g_EventManager.AddEvent(FireBurnEvent);
              Inc(nTime);
            end;
          end;
        end;
      DR_DOWNLEFT: begin
          for I := 0 to 6 do begin
            x := PlayObject.m_nCurrX - I;
            y := PlayObject.m_nCurrY + I;
            if g_EventManager.GetEvent(PlayObject.m_PEnvir, x, y, ET_FIRE) = nil then begin
              FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, y, ET_FIRE, nHTime * nTime * 2, nDamage);
              g_EventManager.AddEvent(FireBurnEvent);
              Inc(nTime);
            end;
          end;
        end;
      DR_LEFT: begin
          for x := PlayObject.m_nCurrX downto PlayObject.m_nCurrX - 10 do begin
            if g_EventManager.GetEvent(PlayObject.m_PEnvir, x, PlayObject.m_nCurrY, ET_FIRE) = nil then begin
              FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, PlayObject.m_nCurrY, ET_FIRE, nHTime * nTime, nDamage);
              g_EventManager.AddEvent(FireBurnEvent);
              Inc(nTime);
            end;
          end;
        end;
      DR_UPLEFT: begin
          for I := 0 to 6 do begin
            x := PlayObject.m_nCurrX - I;
            y := PlayObject.m_nCurrY - I;
            if g_EventManager.GetEvent(PlayObject.m_PEnvir, x, y, ET_FIRE) = nil then begin
              FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, y, ET_FIRE, nHTime * nTime * 2, nDamage);
              g_EventManager.AddEvent(FireBurnEvent);
              Inc(nTime);
            end;
          end;
        end;
    end;
    Result := 1;
  end;
var
  I: Integer;
begin
  Result := 0;
  case nCount of
    1: begin
        Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
      end;
    3: begin
        case PlayObject.m_btDirection of
          DR_UP: begin
              Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              Result := MagMakeSuperFireCrossOfDir(DR_UPRIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_UPLEFT);
            end;
          DR_UPRIGHT: begin
              Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              Result := MagMakeSuperFireCrossOfDir(DR_UP);
              Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
            end;
          DR_RIGHT: begin
              Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              Result := MagMakeSuperFireCrossOfDir(DR_UPRIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNRIGHT);
            end;
          DR_DOWNRIGHT: begin
              Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWN);
            end;
          DR_DOWN: begin
              Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNLEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNRIGHT);
            end;
          DR_DOWNLEFT: begin
              Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWN);
              Result := MagMakeSuperFireCrossOfDir(DR_LEFT);
            end;
          DR_LEFT: begin
              Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNLEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_UPLEFT);
            end;
          DR_UPLEFT: begin
              Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              Result := MagMakeSuperFireCrossOfDir(DR_LEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_UP);
            end;
        end;
      end;
    4: begin
        Result := MagMakeSuperFireCrossOfDir(DR_UP);
        Result := MagMakeSuperFireCrossOfDir(DR_LEFT);
        Result := MagMakeSuperFireCrossOfDir(DR_DOWN);
        Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
      end;
    5: begin
        case PlayObject.m_btDirection of
          DR_UP, DR_UPLEFT, DR_UPRIGHT: begin
              Result := MagMakeSuperFireCrossOfDir(DR_UP);
              Result := MagMakeSuperFireCrossOfDir(DR_UPRIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_UPLEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_LEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
            end;
          DR_LEFT: begin
              Result := MagMakeSuperFireCrossOfDir(DR_UP);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWN);
              Result := MagMakeSuperFireCrossOfDir(DR_UPLEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_LEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNLEFT);
            end;
          DR_RIGHT: begin
              Result := MagMakeSuperFireCrossOfDir(DR_UP);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWN);
              Result := MagMakeSuperFireCrossOfDir(DR_UPRIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNRIGHT);
            end;
          DR_DOWN, DR_DOWNLEFT, DR_DOWNRIGHT: begin
              Result := MagMakeSuperFireCrossOfDir(DR_DOWN);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNRIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNLEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_LEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
            end;
        end;
      end;
    8: begin
        for I := DR_UP to DR_UPLEFT do Result := MagMakeSuperFireCrossOfDir(I);
      end;
  end;
end;

//火墙

function TMagicManager.MagMakeFireCross(PlayObject: TActorObject; nDamage,
  nHTime, nX, nY: Integer): Integer;
var
  FireBurnEvent: TFireBurnEvent;
resourcestring
  sDisableInSafeZoneFireCross = '安全区不允许使用...';
begin
  Result := 0;
  if g_Config.boDisableInSafeZoneFireCross and PlayObject.InSafeZone(PlayObject.m_PEnvir, nX, nY) then begin
    PlayObject.SysMsg(sDisableInSafeZoneFireCross, c_Red, t_Notice);
    Exit;
  end;
  if PlayObject.m_PEnvir.GetEvent(nX, nY - 1) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY - 1, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492CFC   x
  if PlayObject.m_PEnvir.GetEvent(nX - 1, nY) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX - 1, nY, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492D4D
  if PlayObject.m_PEnvir.GetEvent(nX, nY) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492D9C
  if PlayObject.m_PEnvir.GetEvent(nX + 1, nY) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX + 1, nY, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492DED
  if PlayObject.m_PEnvir.GetEvent(nX, nY + 1) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY + 1, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492E3E
  Result := 1;
end;

function TMagicManager.MagBigExplosion(BaseObject: TActorObject; nPower, nX,
  nY: Integer; nRage: Integer; btType: Byte): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTActorObject: TActorObject;
  nPowerValue: Integer;
begin
  Result := False;
  nPowerValue := nPower;
  BaseObjectList := TList.Create;
  BaseObject.GetMapActorObjects(BaseObject.m_PEnvir, nX, nY, nRage, BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    TargeTActorObject := TActorObject(BaseObjectList.Items[I]);
    if BaseObject.IsProperTarget(TargeTActorObject) then begin
      BaseObject.SetTargetCreat(TargeTActorObject);

      nPowerValue := BaseObject._GetAtomPower(TargeTActorObject, btType, nPower);
      TargeTActorObject.m_boNotDefendoof := BaseObject.GetNotDefendoof; //忽视目标防御
      nPowerValue := nPowerValue + BaseObject.GetAddPowerPoint(5, nPowerValue);

      TargeTActorObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nPowerValue, Integer(TargeTActorObject.m_boNotDefendoof), 0, '');
      Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagElecBlizzard(BaseObject: TActorObject;
  nPower: Integer): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTActorObject: TActorObject;
  nPowerPoint: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  BaseObject.GetMapActorObjects(BaseObject.m_PEnvir, BaseObject.m_nCurrX, BaseObject.m_nCurrY, g_Config.nElecBlizzardRange {2}, BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    TargeTActorObject := TActorObject(BaseObjectList.Items[I]);
    if BaseObject.IsProperTarget(TargeTActorObject) then begin
      if not (TargeTActorObject.m_btLifeAttrib = LA_UNDEAD) then begin
        nPowerPoint := nPower div 10;
      end else nPowerPoint := nPower;

      nPowerPoint := BaseObject._GetAtomPower(TargeTActorObject, AT_LIGHT, nPower);
      TargeTActorObject.m_boNotDefendoof := BaseObject.GetNotDefendoof; //忽视目标防御
      nPowerPoint := nPowerPoint + BaseObject.GetAddPowerPoint(5, nPowerPoint);

      //BaseObject.SetTargetCreat(TargeTActorObject);
      TargeTActorObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nPowerPoint, Integer(TargeTActorObject.m_boNotDefendoof), 0, '');
      Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagMakeHolyCurtain(BaseObject: TActorObject; nDamage, nHTime, nX, nY: Integer): Integer;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTActorObject: TActorObject;
  MagicEvent: pTMagicEvent;
  //HolyCurtainEvent: THolyCurtainEvent;
  FireBurnEvent: TFireBurnEvent;
  nPowerValue: Integer;
  Event: TEvent;
begin
  Result := 0;
  Event := g_EventManager.GetEvent(BaseObject.m_PEnvir, nX - 1, nY - 2, ET_HOLYCURTAIN);
  if (Event <> nil) and (Event.m_OwnActorObject = BaseObject) and (not Event.m_boClosed) then Exit;

  Event := g_EventManager.GetEvent(BaseObject.m_PEnvir, nX + 1, nY - 2, ET_HOLYCURTAIN);
  if (Event <> nil) and (Event.m_OwnActorObject = BaseObject) and (not Event.m_boClosed) then Exit;

  Event := g_EventManager.GetEvent(BaseObject.m_PEnvir, nX - 2, nY - 1, ET_HOLYCURTAIN);
  if (Event <> nil) and (Event.m_OwnActorObject = BaseObject) and (not Event.m_boClosed) then Exit;

  Event := g_EventManager.GetEvent(BaseObject.m_PEnvir, nX + 2, nY - 1, ET_HOLYCURTAIN);
  if (Event <> nil) and (Event.m_OwnActorObject = BaseObject) and (not Event.m_boClosed) then Exit;


  Event := g_EventManager.GetEvent(BaseObject.m_PEnvir, nX - 2, nY + 1, ET_HOLYCURTAIN);
  if (Event <> nil) and (Event.m_OwnActorObject = BaseObject) and (not Event.m_boClosed) then Exit;

  Event := g_EventManager.GetEvent(BaseObject.m_PEnvir, nX + 2, nY + 1, ET_HOLYCURTAIN);
  if (Event <> nil) and (Event.m_OwnActorObject = BaseObject) and (not Event.m_boClosed) then Exit;

  Event := g_EventManager.GetEvent(BaseObject.m_PEnvir, nX - 1, nY + 2, ET_HOLYCURTAIN);
  if (Event <> nil) and (Event.m_OwnActorObject = BaseObject) and (not Event.m_boClosed) then Exit;

  Event := g_EventManager.GetEvent(BaseObject.m_PEnvir, nX + 1, nY + 2, ET_HOLYCURTAIN);
  if (Event <> nil) and (Event.m_OwnActorObject = BaseObject) and (not Event.m_boClosed) then Exit;


  if BaseObject.m_PEnvir.CanWalk(nX, nY, True) then begin
    BaseObjectList := TList.Create;
    MagicEvent := nil;
    BaseObject.GetMapActorObjects(BaseObject.m_PEnvir, nX, nY, 1, BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do begin
      TargeTActorObject := TActorObject(BaseObjectList.Items[I]);
      if {(TargeTActorObject.m_btRaceServer >= RC_ANIMAL) and}
        ((Random(4) + (BaseObject.m_Abil.Level - 1)) > TargeTActorObject.m_Abil.Level) and
        {(TargeTActorObject.m_Abil.Level < 50) and}
      (TargeTActorObject.m_Master = nil) then begin
        nPowerValue := nHTime;

        nPowerValue := BaseObject._GetAtomPower(TargeTActorObject, AT_HOLY, nHTime);

        if TargeTActorObject.m_btRaceServer >= RC_ANIMAL then
          TargeTActorObject.OpenHolySeizeMode(nPowerValue * 1000);
        if MagicEvent = nil then begin
          New(MagicEvent);
          FillChar(MagicEvent^, SizeOf(TMagicEvent), #0);
          MagicEvent.BaseObjectList := TList.Create;
          MagicEvent.dwStartTick := GetTickCount();
          MagicEvent.dwTime := nPowerValue * 1000;
        end;
        MagicEvent.BaseObjectList.Add(TargeTActorObject);
        Inc(Result);
      end else begin
        Result := 0;
      end;
    end;
    BaseObjectList.Free;
    if (Result > 0) and (MagicEvent <> nil) then begin
      FireBurnEvent := TFireBurnEvent.Create(BaseObject, nX - 1, nY - 2, ET_HOLYCURTAIN, nHTime * 1000, nDamage);
      FireBurnEvent.m_boAllowClose := False;
      g_EventManager.AddEvent(FireBurnEvent);
      MagicEvent.Events[0] := FireBurnEvent;

      FireBurnEvent := TFireBurnEvent.Create(BaseObject, nX + 1, nY - 2, ET_HOLYCURTAIN, nHTime * 1000, nDamage);
      FireBurnEvent.m_boAllowClose := False;
      g_EventManager.AddEvent(FireBurnEvent);
      MagicEvent.Events[1] := FireBurnEvent;

      FireBurnEvent := TFireBurnEvent.Create(BaseObject, nX - 2, nY - 1, ET_HOLYCURTAIN, nHTime * 1000, nDamage);
      FireBurnEvent.m_boAllowClose := False;
      g_EventManager.AddEvent(FireBurnEvent);
      MagicEvent.Events[2] := FireBurnEvent;

      FireBurnEvent := TFireBurnEvent.Create(BaseObject, nX + 2, nY - 1, ET_HOLYCURTAIN, nHTime * 1000, nDamage);
      FireBurnEvent.m_boAllowClose := False;
      g_EventManager.AddEvent(FireBurnEvent);
      MagicEvent.Events[3] := FireBurnEvent;

      FireBurnEvent := TFireBurnEvent.Create(BaseObject, nX - 2, nY + 1, ET_HOLYCURTAIN, nHTime * 1000, nDamage);
      FireBurnEvent.m_boAllowClose := False;
      g_EventManager.AddEvent(FireBurnEvent);
      MagicEvent.Events[4] := FireBurnEvent;

      FireBurnEvent := TFireBurnEvent.Create(BaseObject, nX + 2, nY + 1, ET_HOLYCURTAIN, nHTime * 1000, nDamage);
      FireBurnEvent.m_boAllowClose := False;
      g_EventManager.AddEvent(FireBurnEvent);
      MagicEvent.Events[5] := FireBurnEvent;

      FireBurnEvent := TFireBurnEvent.Create(BaseObject, nX - 1, nY + 2, ET_HOLYCURTAIN, nHTime * 1000, nDamage);
      FireBurnEvent.m_boAllowClose := False;
      g_EventManager.AddEvent(FireBurnEvent);
      MagicEvent.Events[6] := FireBurnEvent;

      FireBurnEvent := TFireBurnEvent.Create(BaseObject, nX + 1, nY + 2, ET_HOLYCURTAIN, nHTime * 1000, nDamage);
      FireBurnEvent.m_boAllowClose := False;
      g_EventManager.AddEvent(FireBurnEvent);
      MagicEvent.Events[7] := FireBurnEvent;
      UserEngine.m_MagicEventList.Add(MagicEvent);
    end else begin
      if MagicEvent <> nil then begin
        MagicEvent.BaseObjectList.Free;
        Dispose(MagicEvent);
      end;
    end;
  end;
  //MainOutMessage('TMagicManager.MagMakeHolyCurtain '+IntToStr(Result)+' nHTime '+IntToStr(nHTime * 1000)+' nDamage '+IntToStr(nDamage));
end;

function TMagicManager.MagMakeGroupTransparent(BaseObject: TActorObject; nX, nY,
  nHTime: Integer): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTActorObject: TActorObject;
  nHTimeValue: Integer;
begin
  Result := False;
  nHTimeValue := nHTime;
  BaseObjectList := TList.Create;
  BaseObject.GetMapActorObjects(BaseObject.m_PEnvir, nX, nY, 1, BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    TargeTActorObject := TActorObject(BaseObjectList.Items[I]);
    if BaseObject.IsProperFriend(TargeTActorObject) then begin
      if TargeTActorObject.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] = 0 then begin

        nHTimeValue := BaseObject._GetAtomPower(TargeTActorObject, AT_HOLY, nHTime);

        TargeTActorObject.SendDelayMsg(TargeTActorObject, RM_TRANSPARENT, 0, nHTimeValue, 0, 0, '', 800);
        //TargeTActorObject.SendMsg(TargeTActorObject, RM_TRANSPARENT, 0, nHTime, 0, 0, '');
        Result := True;
      end;
    end
  end;
  BaseObjectList.Free;
end;
//=====================================================================================
//名称：
//功能：
//参数：
//     BaseObject       魔法发起人
//     TargeTActorObject 受攻击角色
//     nPower           魔法力大小
//     nLevel           技能修炼等级
//     nTargetX         目标座标X
//     nTargetY         目标座标Y
//返回值：
//=====================================================================================

function TMagicManager.MabMabe(BaseObject, TargeTActorObject: TActorObject; nPower, nLevel,
  nTargetX, nTargetY: Integer): Boolean;
var
  nLv: Integer;
  nPowerValue: Integer;
begin
  Result := False;
  if BaseObject.MagCanHitTarget(BaseObject.m_nCurrX, BaseObject.m_nCurrY, TargeTActorObject) then begin
    if BaseObject.IsProperTarget(TargeTActorObject) and (BaseObject <> TargeTActorObject) then begin
      if (TargeTActorObject.m_nAntiMagic <= Random(10)) and (abs(TargeTActorObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTActorObject.m_nCurrY - nTargetY) <= 1) then begin
        nPowerValue := nPower;

        nPowerValue := BaseObject._GetAtomPower(TargeTActorObject, AT_ICE, nPower) +
          BaseObject._GetAtomPower(TargeTActorObject, AT_FIRE, nPower) - nPower * 2;

        BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPowerValue div 3, MakeLong(nTargetX, nTargetY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 600);
        if (Random(2) + (BaseObject.m_Abil.Level - 1)) > TargeTActorObject.m_Abil.Level then begin
          nLv := BaseObject.m_Abil.Level - TargeTActorObject.m_Abil.Level;
          if (Random(g_Config.nMabMabeHitRandRate {100}) < _MAX(g_Config.nMabMabeHitMinLvLimit, (nLevel * 8) - nLevel + 15 + nLv)) {or (Random(abs(nLv))} then begin
            // if (Random(100) < ((nLevel shl 3) - nLevel + 15 + nLv)) {or (Random(abs(nLv))} then begin
            if (Random(g_Config.nMabMabeHitSucessRate {21}) < nLevel * 2 + 4) then begin
              if TargeTActorObject.m_btRaceServer = RC_PLAYOBJECT then begin
                BaseObject.SetPKFlag(BaseObject);
                BaseObject.SetTargetCreat(TargeTActorObject);
              end;
              TargeTActorObject.SetLastHiter(BaseObject);
              nPower := TargeTActorObject.GetMagStruckDamage(BaseObject, nPower);

              nPowerValue := nPower;

              nPowerValue := BaseObject._GetAtomPower(TargeTActorObject, AT_ICE, nPower) +
                BaseObject._GetAtomPower(TargeTActorObject, AT_FIRE, nPower) - nPower * 2;

              BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPowerValue, MakeLong(nTargetX, nTargetY), MakeLong(2, Integer(TargeTActorObject.m_boNotDefendoof)), Integer(TargeTActorObject), '', 600);
              if g_Config.nMabMabeHitMabeTimeRate <= 0 then g_Config.nMabMabeHitMabeTimeRate := 20;
              if not TargeTActorObject.m_boUnParalysis then
                TargeTActorObject.SendDelayMsg(BaseObject, RM_POISON, POISON_STONE {中毒类型 - 麻痹}, nPowerValue div g_Config.nMabMabeHitMabeTimeRate {20} + Random(nLevel), Integer(BaseObject), nLevel, '', 650);
              //TargeTActorObject.SendDelayMsg(BaseObject, RM_POISON, POISON_STONE {中毒类型 - 麻痹}, nPower div g_Config.nMabMabeHitMabeTimeRate {20} + Random(nLevel), Integer(BaseObject), nLevel, '', 10);
              Result := True;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TMagicManager.MagMakeSinSuSlave(PlayObject: TActorObject;
  UserMagic: pTUserMagic): Boolean;
var
  I: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
begin
  Result := False;
  if not PlayObject.sub_4DD704 then begin
    sMonName := g_Config.sDogz;
    nMakeLevel := UserMagic.btLevel;
    nExpLevel := UserMagic.btLevel;
    nCount := g_Config.nDogzCount;
    dwRoyaltySec := 10 * 24 * 60 * 60;
    for I := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do begin
      if g_Config.DogzArray[I].nHumLevel = 0 then Break;
      if PlayObject.m_Abil.Level >= g_Config.DogzArray[I].nHumLevel then begin
        sMonName := g_Config.DogzArray[I].sMonName;
        nExpLevel := g_Config.DogzArray[I].nLevel;
        nCount := g_Config.DogzArray[I].nCount;
      end;
    end;
    if PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, nCount, dwRoyaltySec) <> nil then
      Result := True;
  end;
  //          if PlayObject.MakeSlave(g_Config.sDogz,UserMagic.btLevel,1,10 * 24 * 60 * 60) <> nil then
  //            boTrain:=True;
end;

function TMagicManager.MagMakeMoonObj(BaseObject: TActorObject; UserMagic: pTUserMagic): TActorObject;
var
  I: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
begin
  Result := nil;
  if not BaseObject.sub_4DD704 then begin
    sMonName := g_Config.sMoon;
    nMakeLevel := UserMagic.btLevel;
    nExpLevel := UserMagic.btLevel;
    nCount := g_Config.nMoonCount;
    dwRoyaltySec := 10 * 24 * 60 * 60;
    Result := BaseObject.MakeMoonObj(sMonName, nMakeLevel, nExpLevel, nCount, dwRoyaltySec);
  end;
end;

function TMagicManager.MagMakeSlave(PlayObject: TActorObject; UserMagic: pTUserMagic): Boolean;
var
  I: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
begin
  Result := False;
  if not PlayObject.sub_4DD704 then begin
    sMonName := g_Config.sBoneFamm;
    nMakeLevel := UserMagic.btLevel;
    nExpLevel := UserMagic.btLevel;
    nCount := g_Config.nBoneFammCount;
    dwRoyaltySec := 10 * 24 * 60 * 60;
    for I := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do begin
      if g_Config.BoneFammArray[I].nHumLevel = 0 then Break;
      if PlayObject.m_Abil.Level >= g_Config.BoneFammArray[I].nHumLevel then begin
        sMonName := g_Config.BoneFammArray[I].sMonName;
        nExpLevel := g_Config.BoneFammArray[I].nLevel;
        nCount := g_Config.BoneFammArray[I].nCount;
      end;
    end;
    if PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, nCount, dwRoyaltySec) <> nil then
      Result := True;
  end;
end;

function TMagicManager.MagMakeSlave_(PlayObject: TActorObject; UserMagic: pTUserMagic; sMonName: string; nCount, nHumLevel, nMonLevel: Integer): Boolean;
var
  nMakeLevel, nExpLevel: Integer;
  dwRoyaltySec: LongWord;
begin
  Result := False;
  if not PlayObject.sub_4DD704 then begin
    nMakeLevel := UserMagic.btLevel;
    nExpLevel := UserMagic.btLevel;
    nCount := g_Config.nBoneFammCount;
    dwRoyaltySec := 10 * 24 * 60 * 60;
    if PlayObject.m_Abil.Level >= nHumLevel then begin
      nExpLevel := nMonLevel;
    end;
  end;
  if PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, nCount, dwRoyaltySec) <> nil then
    Result := True;
end;

function TMagicManager.MagMakeSelf(BaseObject, TargeTActorObject: TActorObject; UserMagic: pTUserMagic): TActorObject;
var
  sMonName: string;
  //nMakeLevel, nExpLevel: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
  boAllowReCallMob: Boolean;
  BaseObject01: TActorObject;
begin
  Result := nil;
  boAllowReCallMob := False;
  BaseObject01 := nil;
  if not BaseObject.sub_4DD704 then begin
    if g_Config.boAddMasterName then begin
      sMonName := BaseObject.m_sCharName + g_Config.sCopyHumName;
    end else begin
      sMonName := g_Config.sCopyHumName;
    end;
    //MainOutMessage('TMagicManager.MagMakeSelf ' + sMonName);
    nCount := g_Config.nAllowCopyHumanCount;
    dwRoyaltySec := 10 * 24 * 60 * 60;
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      if g_Config.boAllowReCallMobOtherHum then begin
        if (TargeTActorObject <> nil) and (not TargeTActorObject.m_boDeath) then begin
          if TargeTActorObject.m_btRaceServer = RC_PLAYOBJECT then begin
            BaseObject01 := TargeTActorObject;
            boAllowReCallMob := True;
          end;
        end else begin
          BaseObject01 := BaseObject;
          boAllowReCallMob := True;
        end;
        if g_Config.boNeedLevelHighTarget and (TargeTActorObject <> nil) and (BaseObject.m_Abil.Level < TargeTActorObject.m_Abil.Level) then boAllowReCallMob := False;
      end else begin
        BaseObject01 := BaseObject;
        boAllowReCallMob := True;
      end;
    end else begin
      BaseObject01 := BaseObject;
      boAllowReCallMob := True;
    end;
    if boAllowReCallMob then begin
      Result := BaseObject.MakeSelf(BaseObject01, sMonName, nCount, dwRoyaltySec);
      //if Result <> nil then MainOutMessage('Result <> nil') else MainOutMessage('Result = nil');
    end;
  end;
end;

{for i:=0 to g_BindItemTypeList.Count-1 do begin

  MainOutMessage(pTBindItem(g_BindItemTypeList.Items[i]).sUnbindItemName);
end;}


function TMagicManager.MagGroupMb(PlayObject: TActorObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTActorObject: TActorObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TActorObject;
  nPower: Integer;
  StdItem: pTStdItem;
  nTime: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  nTime := 5 * UserMagic.btLevel + 1;
  PlayObject.GetMapActorObjects(PlayObject.m_PEnvir, PlayObject.m_nCurrX, PlayObject.m_nCurrY, UserMagic.btLevel + 2, BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TActorObject(BaseObjectList.Items[I]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) and (not g_Config.boGroupMbAttackPlayObject) then Continue;
    if (BaseObject.m_btRaceServer <> RC_PLAYOBJECT) and (BaseObject.m_Master <> nil) and (not g_Config.boGroupMbAttackSlave) then Continue;
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then Continue; //2007-09-22增加不麻痹英雄
    if PlayObject.IsProperTarget(BaseObject) then begin
      if not BaseObject.m_boUnParalysis and (Random(BaseObject.m_btAntiPoison) = 0) then begin
        if (BaseObject.m_Abil.Level < PlayObject.m_Abil.Level) or (Random(PlayObject.m_Abil.Level - BaseObject.m_Abil.Level) = 0) then begin
          BaseObject.MakePosion(POISON_STONE, nTime, 0);
          BaseObject.m_boFastParalysis := True;
        end;
      end;
    end;
    if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
    else if BaseObject.m_btRaceServer >= RC_ANIMAL then Result := True;
  end;
  BaseObjectList.Free;
end;

end.

