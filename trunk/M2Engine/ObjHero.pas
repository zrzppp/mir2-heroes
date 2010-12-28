{------------------------------------------------------------------------------}
{ 单元名称: ObjHero.pas                                                        }
{                                                                              }
{ 单元作者: Mars                                                               }
{ 创建日期: 2007-02-12 20:30:00                                                }
{                                                                              }
{ 功能介绍:                                                                    }
{   实现英雄功能单元                                                           }
{                                                                              }
{ 使用说明:                                                                    }
{                                                                              }
{                                                                              }
{ 更新历史:                                                                    }
{                                                                              }
{ 尚存问题:                                                                    }
{                                                                              }
{                                                                              }
{------------------------------------------------------------------------------}
unit ObjHero;

interface
uses
  Windows, SysUtils, StrUtils, Classes, Grobal2, ObjBase, ObjActor, ItemEvent, IniFiles, Castle, SDK, GroupItems;
type
  TCopyObject = class(TAIObject) //分身
    m_NotCanPickItemList: TList;
  private
    function IsEnoughBag(): Boolean;
    function IsPickUpItem(StdItem: pTStdItem): Boolean;
    function StartPickUpItem(nPickUpTime: Integer): Boolean; //virtual;
  protected
    function FollowMaster: Boolean; override;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure SearchTarget(); override;
    procedure Initialize(); override;
    procedure Copy(Master: TActorObject);
    procedure DropUseItems(BaseObject: TActorObject); override;
    function AbilityUp(UserMagic: pTUserMagic): Boolean;
  end;

  TMoonObject = class(TAIObject) //月灵
  private
    procedure HighAttack();
    procedure LowAttack();
  protected
    function WizardAttackTarget(wMagIdx: Word): Boolean; override;
    function IsUseAttackMagic(): Boolean; override;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure SearchTarget(); override;
    procedure Run; override;
  end;

  THeroObject = class(TAIObject)
    m_sUserID: string[ACCOUNTLEN]; //登录帐号名
    {m_dwTurnIntervalTime: LongWord;
    m_dwMagicHitIntervalTime: LongWord;
    m_dwHitIntervalTime: LongWord;
    m_dwRunIntervalTime: LongWord;
    m_dwWalkIntervalTime: LongWord;

    m_dwActionIntervalTime: LongWord;
    m_dwRunLongHitIntervalTime: LongWord;
    m_dwWalkHitIntervalTime: LongWord;
    m_dwRunHitIntervalTime: LongWord;
    m_dwRunMagicIntervalTime: LongWord;  }

    m_nItemBagCount: Integer;

    //m_boCanDrop: Boolean;
    //m_boCanUseItem: Boolean; //是否允许使用物品
    //m_boCanWalk: Boolean;
    //m_boCanRun: Boolean;
    //m_boCanHit: Boolean;

    //m_boCanSendMsg: Boolean;
    m_btReLevel: Byte;
    m_btCreditPoint: Integer;
    m_nMemberType: Integer;
    m_nMemberLevel: Integer;

    m_nKillMonExpMultiple: Integer;
    m_nKillMonExpRate: Integer; //杀怪经验倍数(此数除以 100 为真正倍数)

    m_dwKillMonExpRateTime: LongWord;
    m_dwPowerRateTime: LongWord;
    m_dwRateTick: LongWord;

    m_nAngryValue: Integer;
    m_dwAddFirDragonTick: LongWord;

    m_dwStartUseSpellTick: LongWord;
    m_boNewHuman: Boolean;
    m_NotCanPickItemList: TList;
    m_dwStartPickItemTick: LongWord;
    m_boHeroLogOut: Boolean;
    m_boHeroLogOnOK: Boolean;
    m_dwHeroLogOnTick: LongWord;
    m_nHeroLogOnCount: Integer;

    //m_SameTarget: TActorObject;
    m_boUseGroupSpell: Boolean;
    m_btLastDir: Byte;

    m_boRcdSaved: Boolean;
    m_nSessionID: Integer;
    m_dwSaveRcdTick: LongWord;
    m_dLogonTime: TDateTime; //登录时间
    m_dwLogonTick: LongWord;
    m_sMasterName: string[ACTORNAMELEN];

    m_btOStatus: Byte; //状态

    m_dwQueryItemBagTick: LongWord;
  private

    function EatUseItems(nShape: Integer): Boolean;
    function UseItem(nItemType, nIndex: Integer): Boolean; override;
    function CheckActionStatus(wIdent: Word; var dwDelayTime: LongWord): Boolean;
    procedure RepairAllItem();
    function GetGroupMagicId: Integer;
    function StartPickUpItem(nPickUpTime: Integer): Boolean;

    function IsSend: Boolean;
    procedure GetAutoWalkXY(var nTargetX, nTargetY: Integer);
    procedure ClientChangeMagicKey(nMagicIdx: Integer);

    procedure ClientQueryBagItems();

    procedure ClientRepairFirDragon(btType: Byte; nItemIdx: Integer; sItemName: string);
  protected
    //function AllowUseMagic(wMagIdx: Word): Boolean; override;
    function FollowMaster: Boolean; override;
    function SelectMagic(): Integer; override; //选择魔法
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure ClientUseItems(nItemIdx: Integer; sItemName: string); //英雄吃药
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure Run; override;
    procedure Initialize; override;
    procedure Die; override;
    procedure SearchTarget(); override;
    procedure DelTargetCreat(); override;
    procedure SendSocket(DefMsg: pTDefaultMessage; sMsg: string); virtual;
    procedure SendDefMessage(wIdent: Word; nRecog: Integer; nParam, nTag, nSeries: Word; sMsg: string);
    procedure SysMsg(sMsg: string; MsgColor: TMsgColor; MsgType: TMsgType); overload; override;
    procedure SysMsg(sMsg: string; btFColor, btBColor: Byte; MsgType: TMsgType); overload; override;
    procedure SendChangeItems(nWhere: Integer; UserItem: pTUserItem);
    procedure SendUseitems();
    procedure SendUseMagic();
    procedure SendDelMagic(UserMagic: pTUserMagic);
    procedure SendAddMagic(UserMagic: pTUserMagic);
    procedure SendAddItem(UserItem: pTUserItem);
    procedure SendDelItemList(ItemList: TStringList);
    procedure SendDelItems(UserItem: pTUserItem);
    procedure SendUpdateItem(UserItem: pTUserItem);

    procedure SetTargetCreat(BaseObject: TActorObject); override;
    procedure SetPKFlag(BaseObject: TActorObject); override;
    procedure SetLastHiter(BaseObject: TActorObject); override;

    procedure ClientTakeOnItems(btWhere: Byte; nItemIdx: Integer; sItemName: string);
    procedure ClientTakeOffItems(btWhere: Byte; nItemIdx: Integer; sItemName: string);
    procedure ClientTakeOnItemsEx(btWhere: Byte; nItemIdx: Integer; sItemName: string);
    procedure ClientTakeOffItemsEx(btWhere: Byte; nItemIdx: Integer; sItemName: string);

    function CheckTakeOnItems(nWhere: Integer; var StdItem: TStdItem): Boolean;
    function IsEnoughBag(): Boolean;

    procedure RecalcLevelAbilitys(); override;
    procedure RecalcAbilitys; override;
    procedure ItemDamageRevivalRing();
    procedure DoDamageWeapon(nWeaponDamage: Integer);
    procedure StruckDamage(nDamage: Integer);

    procedure LogOn();
    procedure LogOut(); //英雄退出
    procedure RestHero();
    procedure RefBagItemCount;

    procedure RefMyStatus();
    function AddItemToBag(UserItem: pTUserItem): Boolean; override;
    procedure WeightChanged;
    function ReadBook(StdItem: pTStdItem): Boolean;
    function EatItems(StdItem: pTStdItem): Boolean;


    procedure MakeWeaponUnlock;
    function WeaptonMakeLuck: Boolean;
    function RepairWeapon: Boolean;
    function SuperRepairWeapon: Boolean;
    procedure HasLevelUp(nLevel: Integer); override;
    procedure IncExp(dwExp: LongWord); override;
    procedure GetExp(dwExp: LongWord); override;
    procedure WinExp(dwExp: LongWord); override;
    procedure GainExp(dwExp: LongWord); override;
    function AbilityUp(UserMagic: pTUserMagic): Boolean;
    function ClientDropItem(sItemName: string; nItemIdx: Integer): Boolean;
    function FindGroupMagic: pTUserMagic;
    function WearFirDragon: Boolean;

    procedure MakeSaveRcd(var HumanRcd: THumDataInfo);

    procedure ScatterBagItems(ItemOfCreat: TActorObject); override;
    procedure DropUseItems(BaseObject: TActorObject); override;
    function QuestCheckItem(sItemName: string; var nCount, nParam: Integer; var nDura: Integer): pTUserItem;
    procedure MakeGhost; override;

    procedure HeroGroup(btLevel: Byte; nTime: Integer);
    procedure UnHeroGroup;
  end;

implementation
uses UsrEngn, M2Share, Event, Envir, Magic, HUtil32, PlugIn, Common, EncryptUnit;

 { TMoonObject }

constructor TMoonObject.Create();
begin
  inherited;
  m_btRaceServer := RC_MOONOBJECT;
  m_nCopyHumanLevel := 1;
  m_btNameColor := 255;
  m_btJob := 1;
end;

destructor TMoonObject.Destroy;
begin
  inherited;
end;

function TMoonObject.IsUseAttackMagic(): Boolean;
begin
  Result := True;
end;

procedure TMoonObject.HighAttack();
var
  nPower: Integer;
  WAbil: pTAbility;
begin
  m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
  SendRefMsg(RM_LIGHTING, 200, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
  WAbil := @m_WAbil;
  nPower := (Random(Integer(HiWord(WAbil.MC) - LoWord(WAbil.MC)) + 1) + LoWord(WAbil.MC));
  nPower := nPower + Round(nPower * 2 / 3);
  nPower := Round(nPower * (g_Config.nMoonHighPowerRate / 100));
  SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 2, Integer(m_TargetCret), '', 600);
end;

procedure TMoonObject.LowAttack();
var
  nPower: Integer;
  WAbil: pTAbility;
begin
  m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
  SendRefMsg(RM_LIGHTING, 199, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
  WAbil := @m_WAbil;
  nPower := (Random(Integer(HiWord(WAbil.MC) - LoWord(WAbil.MC)) + 1) + LoWord(WAbil.MC));
  nPower := Round(nPower * (g_Config.nMoonLowPowerRate / 100));
  SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 2, Integer(m_TargetCret), '', 600);
end;

function TMoonObject.WizardAttackTarget(wMagIdx: Word): Boolean;
begin
  Result := False;
  if (m_TargetCret <> nil) then begin
    if m_TargetCret.m_WAbil.HP < m_TargetCret.m_WAbil.MaxHP div 5 then begin
      HighAttack();
    end else begin
      LowAttack();
    end;
    Result := True;
  end;
end;

procedure TMoonObject.SearchTarget();
begin
  if ((m_TargetCret = nil) or (GetTickCount - m_dwSearchTargetTick > 500)) then begin
    m_dwSearchTargetTick := GetTickCount();
    if (m_Master <> nil) then begin
      if (not m_Master.m_boSlaveRelax) and (not InSafeZone) then begin
        inherited;
      end;
    end else begin
      inherited;
    end;
  end;
end;

procedure TMoonObject.Run;
begin
  if not m_boGhost and
    not m_boDeath and
    not m_boFixedHideMode and
    not m_boStoneMode and
    (m_wStatusTimeArr[POISON_STONE] = 0) then begin

    if (m_TargetCret <> nil) and (m_TargetCret.m_boDeath or m_TargetCret.m_boGhost) then
      DelTargetCreat;

    if m_TargetCret = nil then begin
      m_nTargetX := -1;
      m_nTargetY := -1;
    end;

    SearchTarget();

    if (m_Master <> nil) and (m_Master.m_boSlaveRelax) then
      DelTargetCreat();

    if (m_TargetCret <> nil) then
      if ((m_TargetCret.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT]) or
        ((m_TargetCret.m_btRaceServer = RC_PLAYMOSTER) and (m_TargetCret.m_Master <> nil) and (Master.m_btRaceServer = RC_PLAYOBJECT))) and m_TargetCret.InSafeZone then
        DelTargetCreat;

    if (m_TargetCret <> nil) then begin
      if (Integer(GetTickCount - m_dwHitTick) > 1000) then begin
        m_dwHitTick := GetTickCount();
        if ActThink(SKILL_FIREBALL) then begin
          //m_boAttack := True;
          //inherited;
          //Exit;
        end;

        if (m_TargetCret <> nil) and StartAttack(SKILL_FIREBALL) then begin

        end;
      end;
    end;
  end;
  inherited;
end;

{ TCopyObject }

constructor TCopyObject.Create;
begin
  inherited;
  m_btRaceServer := RC_PLAYMOSTER;
  m_nCopyHumanLevel := 2;
  m_btNameColor := 255;
  bo2BF := True;
  m_NotCanPickItemList := TList.Create;
end;

destructor TCopyObject.Destroy;
begin
  m_NotCanPickItemList.Free;
  inherited;
end;

procedure TCopyObject.SearchTarget();
begin
  if ((m_TargetCret = nil) or (GetTickCount - m_dwSearchTargetTick > 500)) then begin
    m_dwSearchTargetTick := GetTickCount();
    if (m_Master <> nil) and (Master.m_btRaceServer = RC_PLAYOBJECT) then begin
      if (not m_Master.m_boSlaveRelax) and (not InSafeZone) then begin
        inherited;
      end;
    end else begin
      inherited;
    end;
  end;
end;

function TCopyObject.Operate(ProcessMsg: pTProcessMessage): Boolean;
  function MINXY(AObject, BObject: TActorObject): TActorObject;
  var
    nA, nB: Integer;
  begin
    nA := abs(m_nCurrX - AObject.m_nCurrX) + abs(m_nCurrY - AObject.m_nCurrY);
    nB := abs(m_nCurrX - BObject.m_nCurrX) + abs(m_nCurrY - BObject.m_nCurrY);
    if nA > nB then Result := BObject else Result := AObject;
  end;
var
  nDamage: Integer;
  nTargetX: Integer;
  nTargetY: Integer;
  nPower: Integer;
  nRage: Integer;
  TargeTActorObject: TActorObject;
begin
  case ProcessMsg.wIdent of
    RM_DELAYMAGIC: begin
        nPower := ProcessMsg.wParam;
        nTargetX := LoWord(ProcessMsg.nParam1);
        nTargetY := HiWord(ProcessMsg.nParam1);
        nRage := LoWord(ProcessMsg.nParam2);
        TargeTActorObject := TActorObject(ProcessMsg.nParam3);

        //m_MagicObj := TargeTActorObject;
        if (TargeTActorObject <> nil) then TargeTActorObject.m_boNotDefendoof := Boolean(HiWord(ProcessMsg.nParam2));
        if (TargeTActorObject <> nil) and
          (TargeTActorObject.GetMagStruckDamage(Self, nPower) > 0) then begin

          //SetTargetCreat(TargeTActorObject);

          if (TargeTActorObject.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER]) or ((TargeTActorObject.m_Master <> nil) and (TargeTActorObject.Master.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER])) then begin
            if (m_TargetCret <> nil) and ((m_TargetCret.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER]) or ((m_TargetCret.m_Master <> nil) and (m_TargetCret.Master.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER]))) then begin
              if ((MINXY(m_TargetCret, TargeTActorObject) = TargeTActorObject) or (Random(6) = 0)) and (GetTickCount() - m_dwTargetFocusTick > 1000 * 3) then SetTargetCreat(TargeTActorObject);
            end else begin
              SetTargetCreat(TargeTActorObject);
            end;
          end else begin
            if (m_TargetCret = nil) and IsProperTarget(TargeTActorObject) then SetTargetCreat(TargeTActorObject)
            else begin
              if ((m_TargetCret <> nil) and (MINXY(m_TargetCret, TargeTActorObject) = TargeTActorObject)) or (Random(6) = 0) then begin
                if (m_btJob > 0) or ((m_TargetCret <> nil) and (GetTickCount() - m_dwTargetFocusTick > 1000 * 3)) then
                  if IsProperTarget(TargeTActorObject) then SetTargetCreat(TargeTActorObject);
              end;
            end;
          end;

          if TargeTActorObject.m_btRaceServer >= RC_ANIMAL then
            nPower := Round(nPower / 1.2);
          if (abs(nTargetX - TargeTActorObject.m_nCurrX) <= nRage) and (abs(nTargetY - TargeTActorObject.m_nCurrY) <= nRage) then begin

            nPower := nPower + GetAddPowerPoint(5, nPower);

            TargeTActorObject.SendMsg(Self, RM_MAGSTRUCK, 0, nPower, 0, HiWord(ProcessMsg.nParam2), '');
          end;
        end;
      end;
    RM_SENDDELITEMLIST: begin
        TStringList(ProcessMsg.nParam1).Free;
        Result := True;
      end;
  else Result := inherited Operate(ProcessMsg);
  end;
end;

procedure TCopyObject.Run;
var
  I, nX, nY, nSelectMagic: Integer;
  StdItem: pTStdItem;
  boRecalcAbilitys: Boolean;
begin
  //if (m_Master <> nil) then MainOutMessage('TCopyObject.Run');
  if (not m_boGhost) and
    (not m_boDeath) and
    (not m_boFixedHideMode) and
    (not m_boStoneMode) and
    (m_wStatusTimeArr[POISON_STONE] = 0) then begin

    if m_boFireHitSkill and ((GetTickCount - m_dwLatestFireHitTick) > 20 * 1000) then begin
      m_boFireHitSkill := False;
      //SysMsg(sSpiritsGone, c_Red, t_Hint);
    end;
    if m_boCIDHitSkill and ((GetTickCount - m_dwLatestCIDHitTick) > 20 * 1000) then begin
      m_boCIDHitSkill := False;
      //SysMsg(sCIDSpiritsGone, c_Red, t_Hint);
    end;
    if m_boKTZHitSkill and ((GetTickCount - m_dwLatestKTZHitTick) > 20 * 1000) then begin
      m_boKTZHitSkill := False;
      //SysMsg(sKTZSpiritsGone, c_Red, t_Hint);
    end;
    if m_boZRJFHitSkill and ((GetTickCount - m_dwLatestZRJFHitTick) > 20 * 1000) then begin
      m_boZRJFHitSkill := False;
    end;

  //检查身上的装备有没不符合
    boRecalcAbilitys := False;
    for I := Low(THumanUseItems) to High(THumanUseItems) do begin
      if m_UseItems[I].wIndex > 0 then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);
        if StdItem <> nil then begin
          if (m_UseItems[I].AddValue[0] = 1) and (GetDayCount(m_UseItems[I].MaxDate, Now) <= 0) then begin //删除到期装备
            m_UseItems[I].wIndex := 0;
            boRecalcAbilitys := True;
          end;
        end else begin
          m_UseItems[I].wIndex := 0;
          boRecalcAbilitys := True;
        end;
      end;
    end;

    if boRecalcAbilitys then
      RecalcAbilitys();

    if m_Master <> nil then
      StartEatItems;

    if (m_TargetCret <> nil) and (m_TargetCret.m_boDeath or m_TargetCret.m_boGhost) then
      DelTargetCreat;


    if (m_Master <> nil) and (Master.m_btRaceServer = RC_PLAYOBJECT) and (m_TargetCret <> nil) then
      if ((m_TargetCret.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT]) or
        ((m_TargetCret.m_btRaceServer = RC_PLAYMOSTER) and (m_TargetCret.m_Master <> nil) and (Master.m_btRaceServer = RC_PLAYOBJECT))) and m_TargetCret.InSafeZone then
        DelTargetCreat;

    SearchTarget();

    if m_PEnvir.m_boDuel and (m_Master <> nil) and (Master.m_btRaceServer = RC_PLAYOBJECT) and (not TPlayObject(Master).m_boStartDuel) then
      DelTargetCreat; //非比赛人员禁止攻击  m_PEnvir.m_boDueling

    if (m_Master <> nil) and (m_Master.m_boSlaveRelax) then
      DelTargetCreat();

    if (m_TargetCret <> nil) then
      nSelectMagic := SelectMagic;

    if (m_TargetCret <> nil) then begin
      case m_btJob of
        0: begin
            if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > g_Config.dwWarrorAttackTime) then begin
              m_dwHitTick := GetTickCount();
              if ActThink(nSelectMagic) then begin

                //inherited;
                //Exit;
              end;

              if (m_TargetCret <> nil) and StartAttack(nSelectMagic) then begin
                if (nSelectMagic > 0) and (nSelectMagic <= High(m_SkillUseTick)) then begin
                  m_SkillUseTick[nSelectMagic] := GetTickCount;
                end;
              end;
            end;
          end;
        1: begin
            if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > g_Config.dwWizardAttackTime) then begin
              m_dwHitTick := GetTickCount();
              if ActThink(nSelectMagic) then begin

                //inherited;
                //Exit;
              end;

              if (m_TargetCret <> nil) and StartAttack(nSelectMagic) then begin
                if (nSelectMagic >= 0) and (nSelectMagic <= High(m_SkillUseTick)) then begin
                  m_SkillUseTick[nSelectMagic] := GetTickCount;
                end;
              end;
            end;
          end;
        2: begin
            if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > g_Config.dwTaoistAttackTime) then begin
              m_dwHitTick := GetTickCount();
              if ActThink(nSelectMagic) then begin

                //inherited;
                //Exit;
              end;

              if (m_TargetCret <> nil) and StartAttack(nSelectMagic) then begin
                if (nSelectMagic >= 0) and (nSelectMagic <= High(m_SkillUseTick)) then begin
                  m_SkillUseTick[nSelectMagic] := GetTickCount;
                end;
              end;
            end;
          end;
      end;
    end;
  end;
  inherited;
end;

function TCopyObject.IsEnoughBag(): Boolean;
begin
  Result := not (m_ItemList.Count >= g_Config.nCopyHumanBagCount);
end;

function TCopyObject.IsPickUpItem(StdItem: pTStdItem): Boolean;
begin
  Result := True;
  if StdItem.StdMode = 0 then begin
    if (StdItem.Shape in [0, 1, 2]) then Result := True;
  end else
    if StdItem.StdMode = 31 then begin
    if GetBindItemType(StdItem.Shape) >= 0 then Result := True;
  end else begin
    Result := False;
  end;
end;

function TCopyObject.FollowMaster: Boolean;
//var
  //I: Integer;
begin
  //m_Master.SysMsg('FollowMaster0:'+m_sCharName, c_Red, t_Hint);
  {if m_boMission and (m_Master = nil) then begin
    m_nTargetX := m_nMissionX;
    m_nTargetY := m_nMissionY;
    Result := GotoNextOne(m_nTargetX, m_nTargetY, True);
    Exit;
  end else begin  }
  //m_Master.SysMsg('FollowMaster1:' + m_sCharName, c_Red, t_Hint);
  if StartPickUpItem(500) then begin //捡物
    //m_Master.SysMsg('FollowMaster2:' + m_sCharName, c_Red, t_Hint);
      //Result := inherited FollowMaster;
    Result := True;
    Exit;
  end;
  //end;
  //m_Master.SysMsg('FollowMaster3:' + m_sCharName, c_Red, t_Hint);
  Result := inherited FollowMaster;
  {if Result then begin
    for I := 0 to Length(m_UseItems) - 1 do begin
      MainOutMessage('I:' + IntToStr(m_UseItems[I].MakeIndex));
    end;
  end;}
end;

function TCopyObject.StartPickUpItem(nPickUpTime: Integer): Boolean;
  function PickUpItem(nX, nY: Integer; SelItemObject: TItemObject): Boolean;
  var
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    ItemObject: TItemObject;
    nDeleteCode: Integer;
    PlayObject: TPlayObject;
    HeroObject: THeroObject;
  begin
    Result := False;
    ItemObject := m_PEnvir.GetItem(nX, nY, SelItemObject);
    if ItemObject = nil then Exit;
    //捡钱
    if CompareText(ItemObject.m_sName, sSTRING_GOLDNAME) = 0 then begin
      if (m_Master <> nil) and (not m_Master.m_boDeath) and (Master.m_btRaceServer = RC_PLAYOBJECT) then begin
        if m_PEnvir.DeleteFromMap(nX, nY, ItemObject) = 1 then begin
          if TPlayObject(Master).IncGold(ItemObject.m_nCount) then begin
            ItemObject.MakeGhost;
            TPlayObject(Master).GoldChanged;
            SendRefMsg(RM_ITEMHIDE, 0, Integer(ItemObject), nX, nY, '');
            Result := True;
            if g_boGameLogGold then
              AddGameDataLog('4' + #9 +
                m_sMapName + #9 +
                IntToStr(nX) + #9 +
                IntToStr(nY) + #9 +
                m_sCharName + #9 +
                sSTRING_GOLDNAME + #9 +
                IntToStr(ItemObject.m_nCount) + #9 +
                '1' + #9 +
                '0');
          end else if m_PEnvir.AddToMap(nX, nY, ItemObject) <> ItemObject then ItemObject.MakeGhost;
        end;
      end;
      Exit;
    end;

    //捡物品
    StdItem := UserEngine.GetStdItem(ItemObject.m_UserItem.wIndex);
    if StdItem <> nil then begin
      //人型怪
      if IsPickUpItem(StdItem) and IsEnoughBag then begin
        if m_PEnvir.DeleteFromMap(nX, nY, ItemObject) = 1 then begin
          New(UserItem);
          UserItem^ := ItemObject.m_UserItem;
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if (StdItem <> nil) and IsAddWeightAvailable(UserEngine.GetStdItemWeight(UserItem.wIndex)) and AddItemToBag(UserItem) then begin
            ItemObject.MakeGhost;
            SendRefMsg(RM_ITEMHIDE, 0, Integer(ItemObject), nX, nY, '');
            m_WAbil.Weight := RecalcBagWeight();
            Result := True;
          end else begin
            if m_PEnvir.AddToMap(nX, nY, ItemObject) <> ItemObject then ItemObject.MakeGhost;
            Dispose(UserItem);
          end;
        end;
        Exit;
      end;

      //宝宝捡物
      PlayObject := nil;
      HeroObject := nil;
      if (m_Master <> nil) and (not m_Master.m_boDeath) then begin
        if Master.m_btRaceServer = RC_PLAYOBJECT then PlayObject := TPlayObject(Master);
        if m_Master.m_btRaceServer = RC_HEROOBJECT then HeroObject := THeroObject(m_Master);
      end;
      if (PlayObject <> nil) and PlayObject.IsEnoughBag then begin
        if m_PEnvir.DeleteFromMap(nX, nY, ItemObject) = 1 then begin
          New(UserItem);
          UserItem^ := ItemObject.m_UserItem;
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if (StdItem <> nil) and PlayObject.IsAddWeightAvailable(UserEngine.GetStdItemWeight(UserItem.wIndex)) and PlayObject.AddItemToBag(UserItem) then begin
            ItemObject.MakeGhost;
            SendRefMsg(RM_ITEMHIDE, 0, Integer(ItemObject), nX, nY, '');
            PlayObject.SendAddItem(UserItem);
            PlayObject.m_WAbil.Weight := PlayObject.RecalcBagWeight();
            if not IsCheapStuff(StdItem.StdMode) then
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('4' + #9 +
                  m_sMapName + #9 +
                  IntToStr(nX) + #9 +
                  IntToStr(nY) + #9 +
                  '(分身或人形宝宝)' + m_sCharName + #9 +
                    //UserEngine.GetStdItemName(pu.wIndex) + #9 +
                  StdItem.Name + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  '1' + #9 +
                  '0');
            Result := True;
          end else begin
            if m_PEnvir.AddToMap(nX, nY, ItemObject) <> ItemObject then ItemObject.MakeGhost;
            Dispose(UserItem);
          end;
        end;
        Exit;
      end;

      if (HeroObject <> nil) and HeroObject.IsEnoughBag then begin
        if m_PEnvir.DeleteFromMap(nX, nY, ItemObject) = 1 then begin
          New(UserItem);
          UserItem^ := ItemObject.m_UserItem;
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if (StdItem <> nil) and HeroObject.IsAddWeightAvailable(UserEngine.GetStdItemWeight(UserItem.wIndex)) and HeroObject.AddItemToBag(UserItem) then begin
            ItemObject.MakeGhost;
            SendRefMsg(RM_ITEMHIDE, 0, Integer(ItemObject), nX, nY, '');
            HeroObject.SendAddItem(UserItem);
            HeroObject.m_WAbil.Weight := HeroObject.RecalcBagWeight();
            if not IsCheapStuff(StdItem.StdMode) then
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('4' + #9 +
                  m_sMapName + #9 +
                  IntToStr(nX) + #9 +
                  IntToStr(nY) + #9 +
                  '(分身或人形宝宝)' + m_sCharName + #9 +
                    //UserEngine.GetStdItemName(pu.wIndex) + #9 +
                  StdItem.Name + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  '1' + #9 +
                  '0');
            Result := True;
          end else begin
            Dispose(UserItem);
            if m_PEnvir.AddToMap(nX, nY, ItemObject) <> ItemObject then ItemObject.MakeGhost;
          end;
        end;
        Exit;
      end;
    end;
  end;

  function IsOfGroup(ActorObject: TActorObject): Boolean;
  var
    I: Integer;
    GroupMember: TActorObject;
  begin
    {Result := False;
    if m_Master.m_GroupOwner = nil then Exit;
    for I := 0 to m_Master.m_GroupOwner.m_GroupMembers.Count - 1 do begin
      GroupMember := TActorObject(m_Master.m_GroupOwner.m_GroupMembers.Objects[I]);
      if GroupMember = ActorObject then begin
        Result := True;
        Break;
      end;
    end;}
  end;
  function CanPickUp(ItemObject: TItemObject): Boolean;
  var
    I: Integer;
    nItemBind: Integer;
  begin
    Result := True;
    for I := 0 to m_NotCanPickItemList.Count - 1 do begin
      if m_NotCanPickItemList.Items[I] = ItemObject then begin
        Result := False;
        Exit;
      end;
    end;
    if g_Config.boBindItemNoPickUp then begin
      nItemBind := CheckItemBindUse(@ItemObject.m_UserItem, False);
      if (nItemBind > 0) and (nItemBind <> 2) then begin
        Result := False;
      end;
    end;
  end;

  function IsSlave(OfActorObject: TActorObject): Boolean;
  var
    I: Integer;
    ActorObject: TActorObject;
  begin
    Result := False;
    for I := 0 to m_SlaveList.Count - 1 do begin
      ActorObject := TActorObject(m_SlaveList.Items[I]);
      if ActorObject = OfActorObject then begin
        Result := True;
        Exit;
      end;
      if Result then Exit;
      Result := IsSlave(ActorObject);
      if Result then Exit;
    end;
  end;

  {function IsSlave(OfActorObject: TActorObject): Boolean;
  var
    I, II, III: Integer;
    ActorObject01, ActorObject02, ActorObject03: TActorObject;
    boFind: Boolean;
  begin
    Result := False;
    boFind := False;
    for I := 0 to m_SlaveList.Count - 1 do begin
      ActorObject01 := TActorObject(m_SlaveList.Items[I]);
      if ActorObject01 = OfActorObject then begin
        Result := True;
        boFind := True;
        Break;
      end;
      if boFind then Break;
      for II := 0 to ActorObject01.m_SlaveList.Count - 1 do begin
        ActorObject02 := TActorObject(ActorObject01.m_SlaveList.Items[II]);
        if ActorObject02 = OfActorObject then begin
          Result := True;
          boFind := True;
          Break;
        end;
        if boFind then Break;
        for III := 0 to ActorObject02.m_SlaveList.Count - 1 do begin
          ActorObject03 := TActorObject(ActorObject02.m_SlaveList.Items[III]);
          if ActorObject03 = OfActorObject then begin
            Result := True;
            boFind := True;
            Break;
          end;
          if boFind then Break;
        end;
      end;
    end;
  end;
  }

  function FindPickItem(): TItemObject;
  var
    ItemList: TList;
    ItemObject: TItemObject;
    ItemObjectA: TItemObject;
    BaseObject: TBaseObject;
    I, nX, nY: Integer;
    nStartX: Integer;
    nEndX: Integer;
    nStartY: Integer;
    nEndY: Integer;
    n01, n02: Integer;
    nError: Integer;
    MapCellInfo: pTMapCellinfo;
    VisibleMapItem: pTVisibleMapItem;
  begin
    Result := nil;
    ItemObjectA := nil;
    n01 := 9999;

    nError := -4;
    for I := 0 to m_VisibleItems.Count - 1 do begin
      VisibleMapItem := m_VisibleItems.Items[I];
      nError := 1;
      ItemObject := TItemObject(VisibleMapItem.BaseObject);
      nError := 2;
      if ItemObject <> nil then begin
        nError := 3;
        if (ItemObject.m_DropActorObject <> m_Master) and (CanPickUp(ItemObject)) then begin
          nError := 4;
          //sItemName := ItemObject.m_sName;
          //nError := 44;
          if IsAllowPickUpItem(ItemObject.m_sName) and IsAddWeightAvailable(UserEngine.GetStdItemWeight(ItemObject.m_UserItem.wIndex)) then begin
            nError := 5;
            if ((ItemObject.m_OfActorObject = nil) or (ItemObject.m_OfActorObject = m_Master) or (ItemObject.m_OfActorObject = Master) or (ItemObject.m_OfActorObject = Self) or IsSlave(TActorObject(ItemObject.m_OfActorObject))) then begin
              nError := 6;
              if (abs(VisibleMapItem.nX - m_nCurrX) <= 6) and (abs(VisibleMapItem.nY - m_nCurrY) <= 6) then begin
                nError := 7;
                if (ItemObject <> m_SelItemObject) then begin
                  nError := 8;
                  n02 := abs(VisibleMapItem.nX - m_nCurrX) + abs(VisibleMapItem.nY - m_nCurrY);
                  nError := 9;
                  if n02 < n01 then begin
                    n01 := n02;
                    ItemObjectA := ItemObject;
                  end;
                  nError := 10;
                end;
              end;
            end;
          end;

        end;
      end;
    end;

    {ItemList := TList.Create;
    if g_ItemManager.FindItem(m_PEnvir, m_nCurrX, m_nCurrY, m_nViewRange, ItemList) > 0 then begin

      for I := 0 to ItemList.Count - 1 do begin
        ItemObject := TItemObject(ItemList.Items[I]);
        ItemObject := TItemObject(BaseObject);

        if (ItemObject.m_DropActorObject <> m_Master) and (ItemObject.m_DropActorObject <> Master) and CanPickUp(ItemObject) then begin
          if IsAllowPickUpItem(ItemObject.m_sName) and IsAddWeightAvailable(UserEngine.GetStdItemWeight(ItemObject.m_UserItem.wIndex)) then begin
            if ((ItemObject.m_OfActorObject = nil) or (ItemObject.m_OfActorObject = m_Master) or (ItemObject.m_OfActorObject = Master) or (ItemObject.m_OfActorObject = Self) or IsSlave(TActorObject(ItemObject.m_OfActorObject))) then begin
              if (abs(ItemObject.m_nMapX - m_nCurrX) <= 6) and (abs(ItemObject.m_nMapY - m_nCurrY) <= 6) then begin
                if (ItemObject <> m_SelItemObject) then begin
                  n02 := abs(ItemObject.m_nMapX - m_nCurrX) + abs(ItemObject.m_nMapY - m_nCurrY);
                  if n02 < n01 then begin
                    n01 := n02;
                    ItemObjectA := ItemObject;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
    ItemList.Free; }
    (*
    nStartX := m_nCurrX - m_nViewRange;
    nEndX := m_nCurrX + m_nViewRange;
    nStartY := m_nCurrY - m_nViewRange;
    nEndY := m_nCurrY + m_nViewRange;

    for nX := nStartX to nEndX do begin
      for nY := nStartY to nEndY do begin
        if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) and (MapCellInfo.chFlag = 0) then begin
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
            if BaseObject <> nil then begin
              if BaseObject.m_ObjType = t_Item then begin
                ItemObject := TItemObject(BaseObject);

                if (ItemObject.m_DropActorObject <> m_Master) and (ItemObject.m_DropActorObject <> Master) and CanPickUp(ItemObject) then begin
                  if IsAllowPickUpItem(ItemObject.m_sName) and IsAddWeightAvailable(UserEngine.GetStdItemWeight(ItemObject.m_UserItem.wIndex)) then begin
                    if ((ItemObject.m_OfActorObject = nil) or (ItemObject.m_OfActorObject = m_Master) or (ItemObject.m_OfActorObject = Master) or (ItemObject.m_OfActorObject = Self) or IsSlave(TActorObject(ItemObject.m_OfActorObject))) {or IsOfGroup(TActorObject(MapItem.OfActorObject))} then begin
                      if (abs(ItemObject.m_nMapX - m_nCurrX) <= 6) and (abs(ItemObject.m_nMapY - m_nCurrY) <= 6) then begin
                        if (ItemObject <> m_SelItemObject) then begin
                          n02 := abs(ItemObject.m_nMapX - m_nCurrX) + abs(ItemObject.m_nMapY - m_nCurrY);
                          if n02 < n01 then begin
                            n01 := n02;
                            ItemObjectA := ItemObject;
                          end;
                        end;
                      end;
                    end;
                  end;

              end;
              end;
            end;
          end;
        end;
      end;
    end;    *)
    if ItemObjectA <> nil then Result := ItemObject;
  end;

var
  ItemObject: TItemObject;
resourcestring
  sExceptionMsg = '[Exception] TCopyObject::PickUpItem 1-%d %s %s %d %d %d';
begin
  Result := False;
  if m_Master = nil then Exit;
  if m_Master <> nil then begin
    if Master.m_boDeath then Exit;
    if Master.m_btRaceServer <> RC_PLAYOBJECT then Exit;
    if Master.m_boSlaveRelax then Exit;
    if GetTickCount - TPlayObject(Master).m_dwPickUpTick < 1000 * 3 then Exit;
    if m_Master.InSafeZone or InSafeZone then Exit;
  end;
  if (not IsEnoughBag) or m_boDeath or m_boGhost {or (not m_boCanPickUpItem)} then Exit;

  if m_SelItemObject <> nil then begin
    if g_ItemManager.FindItem(m_PEnvir, m_nCurrX, m_nCurrY, m_SelItemObject) = m_SelItemObject then begin
      if PickUpItem(m_nCurrX, m_nCurrY, m_SelItemObject) then begin
        m_SelItemObject := nil;
        Result := True;
        Exit;
      end else begin
        m_NotCanPickItemList.Add(m_SelItemObject);
        m_SelItemObject := nil;
      end;
    end else m_SelItemObject := nil;
  end;

  ItemObject := FindPickItem();
  if ItemObject <> nil then begin
    m_SelItemObject := ItemObject;
    if (m_nCurrX <> ItemObject.m_nMapX) or (m_nCurrY <> ItemObject.m_nMapY) then begin
      if not GotoNextOne(ItemObject.m_nMapX, ItemObject.m_nMapY, True) then begin
        m_NotCanPickItemList.Add(m_SelItemObject);
        m_SelItemObject := nil;
      end;
    end;
    Result := True;
  end;
end;

procedure TCopyObject.Copy(Master: TActorObject);
var
  I: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  UserMagic, Magic: pTUserMagic;
begin
  m_btDirection := Master.m_btDirection;
  m_Abil := Master.m_Abil;
  m_Abil.HP := m_Abil.MaxHP;
  m_Abil.MP := m_Abil.MaxMP;
  m_WAbil := m_Abil;
  m_btJob := Master.m_btJob;
  m_btGender := Master.m_btGender;
  m_btHair := Master.m_btHair;
  m_btRaceImg := Master.m_btRaceImg;

  m_UseItems := Master.m_UseItems;
  for I := 0 to Master.m_MagicList.Count - 1 do begin //添加魔法
    UserMagic := Master.m_MagicList.Items[I];
    New(Magic);
    Magic^ := UserMagic^;
    Magic.btKey := VK_F1;
    m_MagicList.Add(Magic);
  end;
  RecalcLevelAbilitys;
  RecalcAbilitys;
  //RefNameColor;
end;

procedure TCopyObject.Initialize();
var
  TempList: TStringList;
  sCopyHumBagItems: string;
  UserItem: pTUserItem;
  I: Integer;
  sFileName: string;
  ItemIni: TIniFile;
  sMagic: string;
  sMagicName: string;
  Magic: pTMagic;
  MagicInfo: pTMagic;
  UserMagic: pTUserMagic;
  StdItem: pTStdItem;
  StdItemNameArray: array[0..12] of string[16];
begin
  if m_btRaceServer = RC_PLAYMOSTER then begin
    if m_nCopyHumanLevel > 0 then begin
      case m_btJob of
        0: sCopyHumBagItems := Trim(g_Config.sCopyHumBagItems1);
        1: sCopyHumBagItems := Trim(g_Config.sCopyHumBagItems2);
        2: sCopyHumBagItems := Trim(g_Config.sCopyHumBagItems3);
      end;
      if sCopyHumBagItems <> '' then begin
        TempList := TStringList.Create;
        ExtractStrings(['|', '\', '/', ','], [], PChar(sCopyHumBagItems), TempList);
        for I := 0 to TempList.Count - 1 do begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(TempList.Strings[I], UserItem) then begin
            m_ItemList.Add(UserItem);
          //m_WAbil.Weight := RecalcBagWeight();
          end else Dispose(UserItem);
        end;
        TempList.Free;
      end;
    end else begin
      sFileName := g_Config.sEnvirDir + 'MonUseItems\' + m_sCharName + '.txt';
      if FileExists(sFileName) then begin
        ItemIni := TIniFile.Create(sFileName);
        if ItemIni <> nil then begin
          m_btJob := ItemIni.ReadInteger('BaseInfo', 'Job', 0);
          m_btGender := ItemIni.ReadInteger('BaseInfo', 'Gender', 0);
          m_btHair := ItemIni.ReadInteger('BaseInfo', 'Hair', 0);
          m_boSuperItem := ItemIni.ReadBool('BaseInfo', 'SuperItem', False);
          sMagic := ItemIni.ReadString('BaseInfo', 'Magic', '');

          if sMagic <> '' then begin
            TempList := TStringList.Create;
            ExtractStrings(['|', '\', '/', ','], [], PChar(sMagic), TempList);
            for I := 0 to TempList.Count - 1 do begin
              sMagicName := Trim(TempList.Strings[I]);
              if FindMagic(sMagicName) = nil then begin
                Magic := UserEngine.FindMagic(sMagicName);
                if Magic <> nil then begin
                  if (Magic.btJob = 99) or (Magic.btJob = m_btJob) then begin
                    New(UserMagic);
                    UserMagic.MagicInfo := Magic;
                    UserMagic.wMagIdx := Magic.wMagicId;
                    UserMagic.btLevel := 3;
                    UserMagic.btKey := VK_F1;
                    UserMagic.nTranPoint := Magic.MaxTrain[3];
                    m_MagicList.Add(UserMagic);
                  end;
                end;
              end;
            end;
            TempList.Free;
          end;
          FillChar(StdItemNameArray, SizeOf(StdItemNameArray), #0);
          StdItemNameArray[U_DRESS] := ItemIni.ReadString('UseItems', 'DRESSNAME', ''); // '衣服';
          StdItemNameArray[U_WEAPON] := ItemIni.ReadString('UseItems', 'WEAPONNAME', ''); // '武器';
          StdItemNameArray[U_RIGHTHAND] := ItemIni.ReadString('UseItems', 'RIGHTHANDNAME', ''); // '照明物';
          StdItemNameArray[U_NECKLACE] := ItemIni.ReadString('UseItems', 'NECKLACENAME', ''); // '项链';
          StdItemNameArray[U_HELMET] := ItemIni.ReadString('UseItems', 'HELMETNAME', ''); // '头盔';
          StdItemNameArray[U_ARMRINGL] := ItemIni.ReadString('UseItems', 'ARMRINGLNAME', ''); // '左手镯';
          StdItemNameArray[U_ARMRINGR] := ItemIni.ReadString('UseItems', 'ARMRINGRNAME', ''); // '右手镯';
          StdItemNameArray[U_RINGL] := ItemIni.ReadString('UseItems', 'RINGLNAME', ''); // '左戒指';
          StdItemNameArray[U_RINGR] := ItemIni.ReadString('UseItems', 'RINGRNAME', ''); // '右戒指';
          StdItemNameArray[U_BUJUK] := ItemIni.ReadString('UseItems', 'BUJUKNAME', ''); // '物品';
          StdItemNameArray[U_BELT] := ItemIni.ReadString('UseItems', 'BELTNAME', ''); // '腰带';
          StdItemNameArray[U_BOOTS] := ItemIni.ReadString('UseItems', 'BOOTSNAME', ''); // '鞋子';
          StdItemNameArray[U_CHARM] := ItemIni.ReadString('UseItems', 'CHARMNAME', ''); // '宝石';
          m_nDieDropUseItemRate := ItemIni.ReadInteger('UseItems', 'DieDropUseItemRate', 100);
          m_boButchItemEx := ItemIni.ReadBool('UseItems', 'ButchItem', False);
          m_boButchItem := m_boButchItemEx;
          m_boNoDropItem := ItemIni.ReadBool('UseItems', 'NoDropItem', False);
          m_boNoDropUseItem := m_boNoDropItem;
          //MainOutMessage(m_sCharName + ' BaseObject.m_boButchItem1 ' + BooleanToStr(m_boButchItem));
          for I := U_DRESS to U_CHARM do begin
            if StdItemNameArray[I] <> '' then begin
              StdItem := UserEngine.GetStdItem(StdItemNameArray[I]);
              if StdItem <> nil then begin
              //if CheckTakeOnItems(i, StdItem^) then begin
                New(UserItem);
                if UserEngine.CopyToUserItemFromName(StdItemNameArray[I], UserItem) then begin


                  if m_boSuperItem or (Random(g_Config.nScriptRandomAddValue {10}) = 0) then //几率控制
                    UserEngine.RandomUpgradeItem(UserItem); //生成极品装备

                  UserEngine._RandomItemLimitDay(UserItem, g_Config.nScriptRandomNotLimit);

                  if m_boSuperItem or (Random(g_Config.nScriptRandomNewAddValue) = 0) then
                    UserEngine._RandomUpgradeItem(UserItem);

                  if m_boSuperItem or (Random(g_Config.nScriptRandomAddPoint) = 0) then
                    UserEngine.RandomItemAddPoint(UserItem);


                  UserEngine._RandomItemLimitDay(UserItem, g_Config.nMonRandomNotLimit);


                  if StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26] then begin
                    if (StdItem.Shape = 130) or (StdItem.Shape = 131) or (StdItem.Shape = 132) then begin
                      UserEngine.GetUnknowItemValue(UserItem);

                      UserEngine._GetUnknowItemValue(UserItem);

                    end;
                  end;
                end;
                m_UseItems[I] := UserItem^;
                Dispose(UserItem);
              //end;
              end;
            end;
          end;
          ItemIni.Free;
        end;
      end;
    end;
    RecalcAbilitys;
    //RefNameColor;
  end;
  inherited;
end;

procedure TCopyObject.DropUseItems(BaseObject: TActorObject);
var
  I, nRate: Integer;
  StdItem: pTStdItem;
  DropItemList: TStringList;
  boDropall: Boolean;
  sCheckItemName: string;

  PlayObject: TPlayObject;
  ActorObject, ActorObject18: TActorObject;
  nC, n10: Integer;
resourcestring
  sExceptionMsg = '[Exception] TCopyObject::DropUseItems';
begin
  PlayObject := nil;

  if m_boNoDropUseItem or (not m_boDropUseItem) or (m_Master <> nil) then Exit;

  if (BaseObject <> nil) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then
    PlayObject := TPlayObject(BaseObject)
  else begin
    ActorObject18 := nil;
    n10 := 9999;
    for I := 0 to m_VisibleActors.Count - 1 do begin
      ActorObject := TActorObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if (ActorObject.m_btRaceServer = RC_PLAYOBJECT) then begin
        if (not ActorObject.m_boHideMode or m_boCoolEye) then begin
          nC := abs(m_nCurrX - ActorObject.m_nCurrX) + abs(m_nCurrY - ActorObject.m_nCurrY);
          if nC < n10 then begin
            n10 := nC;
            ActorObject18 := ActorObject;
          end;
        end;
      end;
    end;
    if ActorObject18 <> nil then
      PlayObject := TPlayObject(ActorObject18);
  end;

  DropItemList := nil;
  try
    //if m_Master <> nil then Exit; //如果是分身不掉装备
    for I := Low(THumanUseItems) to High(THumanUseItems) do begin
      StdItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);
      if StdItem <> nil then begin
        if (StdItem.Reserved and 8 <> 0) then begin
          if StdItem.NeedIdentify = 1 then
            AddGameDataLog('16' + #9 +
              m_sMapName + #9 +
              IntToStr(m_nCurrX) + #9 +
              IntToStr(m_nCurrY) + #9 +
              m_sCharName + #9 +
              //UserEngine.GetStdItemName(m_UseItems[I].wIndex) + #9 +
              StdItem.Name + #9 +
              IntToStr(m_UseItems[I].MakeIndex) + #9 +
              BoolToIntStr(m_btRaceServer = RC_PLAYMOSTER) + #9 +
              '0');
          m_UseItems[I].wIndex := 0;
        end;
      end;
    end;

    //if not m_boDropUseItem then Exit;

    nRate := m_nDieDropUseItemRate;

    for I := Low(THumanUseItems) to High(THumanUseItems) do begin
      if m_UseItems[I].wIndex <= 0 then Continue;
      StdItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);
      if StdItem = nil then Continue;
      if InDisableTakeOffList(m_UseItems[I].wIndex) then Continue; //检查是否在禁止取下列表,如果在列表中则不掉此物品

      if (m_UseItems[I].AddValue[0] = 1) and (GetDayCount(m_UseItems[I].MaxDate, Now) <= 0) then begin //删除到期装备
        m_UseItems[I].wIndex := 0;
        Continue;
      end;

      boDropall := False;
      if Assigned(PlugInEngine.CheckCanDieScatterItem) then begin //死亡必爆
        sCheckItemName := StdItem.Name;
        if PlugInEngine.CheckCanDieScatterItem(Self, PChar(sCheckItemName), False) then begin
          boDropall := True;
        end;
      end;

      if Assigned(PlugInEngine.CheckNotCanScatterItem) then begin //禁止爆出
        sCheckItemName := StdItem.Name;
        if PlugInEngine.CheckNotCanScatterItem(Self, PChar(sCheckItemName), False) then begin
          Continue;
        end;
      end;

      if (not boDropall) and (Random(nRate) <> 0) then Continue;

      if DropItemDown(@m_UseItems[I], 2, True, BaseObject, Self) then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);
        if StdItem <> nil then begin
          if (PlayObject <> nil) and (g_FunctionNPC <> nil) then begin
            PlayObject.m_sScatterItemName := StdItem.Name;
            PlayObject.m_sScatterItemOwnerName := m_sCharName;
            PlayObject.m_sScatterItemMapName := m_sMapName;
            PlayObject.m_sScatterItemMapDesc := m_PEnvir.sMapDesc;
            PlayObject.m_nScatterItemX := m_nScatterItemX;
            PlayObject.m_nScatterItemY := m_nScatterItemY;
            if IsAllowScatterItem(PlayObject.m_sScatterItemName) then begin
              try
                g_FunctionNPC.GotoLable(PlayObject, '@DropUseItems', False);
              except
                MainOutMessage(sExceptionMsg + ' FunctionNPC::GotoLable');
              end;
            end;
          end;

          if (StdItem.Reserved and 10 = 0) then begin
            m_UseItems[I].wIndex := 0;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

function TCopyObject.AbilityUp(UserMagic: pTUserMagic): Boolean;
var
  nSpellPoint, n14: Integer;
begin
  Result := False;
  nSpellPoint := GetSpellPoint(UserMagic);
  if nSpellPoint > 0 then begin
    if m_WAbil.MP < nSpellPoint then Exit;
    n14 := (Random(10 + UserMagic.btLevel) + UserMagic.btLevel) * _MIN(UserMagic.btLevel, 1);
    m_dwStatusArrTimeOutTick[2 {0x228}] := GetTickCount + n14 * 1000;
    m_wStatusArrValue[2 {0x218}] := MakeLong(LoWord(m_WAbil.SC), HiWord(m_WAbil.SC) - 2 - (m_Abil.Level div 7)) * 2;
    //SysMsg('道术增加' + IntToStr(m_wStatusArrValue[2 {0x218}]) + '点 ' + IntToStr(n14) + '秒', c_Green, t_Hint);
    RecalcAbilitys();
    //SendMsg(Self, RM_ABILITY, 0, 0, 0, 0, '');
    //SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');
    Result := True;
  end;
end;

{ THeroObject }

constructor THeroObject.Create;
begin
  inherited;
  m_btRaceServer := RC_HEROOBJECT;
  bo2BF := True;
  m_sUserID := '';
  m_nViewRange := 8;
  m_nRunTime := 250;
  m_dwSearchTick := GetTickCount();
  m_nCopyHumanLevel := 3;
  m_btNameColor := g_Config.btHeroNameColor;
  m_boFixedHideMode := True;
  {m_dwHitIntervalTime := g_Config.dwHitIntervalTime; //攻击间隔
  m_dwMagicHitIntervalTime := g_Config.dwMagicHitIntervalTime; //魔法间隔
  m_dwRunIntervalTime := g_Config.dwRunIntervalTime; //走路间隔
  m_dwWalkIntervalTime := g_Config.dwWalkIntervalTime; //走路间隔
  m_dwTurnIntervalTime := g_Config.dwTurnIntervalTime; //换方向间隔
  m_dwActionIntervalTime := g_Config.dwActionIntervalTime; //组合操作间隔
  m_dwRunLongHitIntervalTime := g_Config.dwRunLongHitIntervalTime; //组合操作间隔
  m_dwRunHitIntervalTime := g_Config.dwRunHitIntervalTime; //组合操作间隔
  m_dwWalkHitIntervalTime := g_Config.dwWalkHitIntervalTime; //组合操作间隔
  m_dwRunMagicIntervalTime := g_Config.dwRunMagicIntervalTime; //跑位魔法间隔
          }
  m_dwHitTick := GetTickCount - LongWord(Random(3000));
  m_dwWalkTick := GetTickCount - LongWord(Random(3000));

  m_SelItemObject := nil;

  m_nItemBagCount := 10;
  m_btStatus := 0; //状态

  m_boTarget := False; //是否锁定目标

  //m_boCanDrop := True; //是否允许扔物品
  //m_boCanUseItem := True; //是否允许使用物品
  //m_boCanWalk := True;
  //m_boCanRun := True;
  //m_boCanHit := True;
  //m_boCanSpell := True;
  //m_boCanSendMsg := True;

  m_btReLevel := 0;
  m_btCreditPoint := 0;
  m_nMemberType := 0;
  m_nMemberLevel := 0;
  m_nKillMonExpMultiple := 1;
  m_nKillMonExpRate := 100;

  m_nAngryValue := 0;
  m_dwAddFirDragonTick := GetTickCount();

  m_boNewHuman := False;
  m_NotCanPickItemList := TList.Create;

  m_nKillMonExpMultiple := 1;
  m_nKillMonExpRate := 100;
  m_dwRateTick := GetTickCount();
  m_nPowerRate := 100;
  m_boHeroLogOut := False;
  //m_SameTarget := nil;
  m_boUseGroupSpell := False;
  m_boAutoAttack := False;

  m_sMasterName := '';
  m_boHeroLogOnOK := False;
  m_dwHeroLogOnTick := GetTickCount();
  m_nHeroLogOnCount := 0;
  m_btHeroGroup := 0;
  m_dwQueryItemBagTick := GetTickCount() - 3000;
  m_dwSaveRcdTick := GetTickCount();
end;

destructor THeroObject.Destroy;
begin
  m_NotCanPickItemList.Free;
  inherited;
end;

function THeroObject.Operate(ProcessMsg: pTProcessMessage): Boolean;
  function MINXY(AObject, BObject: TActorObject): TActorObject;
  var
    nA, nB: Integer;
  begin
    nA := abs(m_nCurrX - AObject.m_nCurrX) + abs(m_nCurrY - AObject.m_nCurrY);
    nB := abs(m_nCurrX - BObject.m_nCurrX) + abs(m_nCurrY - BObject.m_nCurrY);
    if nA > nB then Result := BObject else Result := AObject;
  end;
var
  Health: THealth;
  CharDesc: TCharDesc;
  nObjCount: Integer;
  s1C: string;
  MessageBodyWL: TMessageBodyWL;
  MessageBodyW: TMessageBodyW;
  ShortMessage: TShortMessage;
  dwDelayTime: LongWord;
  nMsgCount: Integer;

  nDamage: Integer;
  nTargetX: Integer;
  nTargetY: Integer;
  nPower: Integer;
  nRage: Integer;
  TargeTActorObject, AttackBaseObject: TActorObject;
resourcestring
  sExceptionMsg = '[Exception] THeroObject::Operate ';
begin
  Result := True;
  if ProcessMsg = nil then begin
    Result := False;
    Exit;
  end;
  //try
  case ProcessMsg.wIdent of
    RM_DELAYMAGIC: begin
        nPower := ProcessMsg.wParam;
        nTargetX := LoWord(ProcessMsg.nParam1);
        nTargetY := HiWord(ProcessMsg.nParam1);
        nRage := LoWord(ProcessMsg.nParam2);

        TargeTActorObject := TActorObject(ProcessMsg.nParam3);
        //m_MagicObj := TargeTActorObject;
        if (TargeTActorObject <> nil) then TargeTActorObject.m_boNotDefendoof := Boolean(HiWord(ProcessMsg.nParam2));
        if (TargeTActorObject <> nil) and
          (TargeTActorObject.GetMagStruckDamage(Self, nPower) > 0) then begin

          //SetTargetCreat(TargeTActorObject);

          if (TargeTActorObject.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER]) or ((TargeTActorObject.m_Master <> nil) and (TargeTActorObject.Master.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER])) then begin
            if (m_TargetCret <> nil) and ((m_TargetCret.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER]) or ((m_TargetCret.m_Master <> nil) and (m_TargetCret.Master.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER]))) then begin
              if ((MINXY(m_TargetCret, TargeTActorObject) = TargeTActorObject) or (Random(6) = 0)) and (GetTickCount() - m_dwTargetFocusTick > 1000 * 3) then SetTargetCreat(TargeTActorObject);
            end else begin
              SetTargetCreat(TargeTActorObject);
            end;
          end else begin
            if (m_TargetCret = nil) and IsProperTarget(TargeTActorObject) then SetTargetCreat(TargeTActorObject)
            else begin
              if ((m_TargetCret <> nil) and (MINXY(m_TargetCret, TargeTActorObject) = TargeTActorObject)) or (Random(6) = 0) then begin
                if (m_btJob > 0) or ((m_TargetCret <> nil) and (GetTickCount() - m_dwTargetFocusTick > 1000 * 3)) then
                  if IsProperTarget(TargeTActorObject) then SetTargetCreat(TargeTActorObject);
              end;
            end;
          end;

          if TargeTActorObject.m_btRaceServer >= RC_ANIMAL then
            nPower := Round(nPower / 1.2);
          if (abs(nTargetX - TargeTActorObject.m_nCurrX) <= nRage) and (abs(nTargetY - TargeTActorObject.m_nCurrY) <= nRage) then begin

            nPower := nPower + GetAddPowerPoint(5, nPower);

            TargeTActorObject.SendMsg(Self, RM_MAGSTRUCK, 0, nPower, 0, HiWord(ProcessMsg.nParam2), '');
          end;
        end;
      end;

    RM_HEROLOGON_OK: begin
        SendDefMessage(SM_HEROLOGON_OK, Integer(ProcessMsg.BaseObject), 0, 0, 0, '');
      end;

    RM_MAKEGHOST: begin
        SendDefMessage(SM_HEROLOGOUT_OK, Integer(ProcessMsg.BaseObject), 0, 0, 0, '');
        MakeGhost;
        //MainOutMessage('RM_MAKEGHOST');
      end;

    RM_HEROGROUP: begin
        m_boAutoAttack := False;
        SendRefMsg(RM_DISAPPEAR, 0, 0, 0, 0, '');
        m_dwHeroGroupTime := ProcessMsg.nParam3 * 1000;
        m_dwHeroGroupTick := GetTickCount;
        m_btHeroGroup := ProcessMsg.nParam2;
        m_boFixedHideMode := True;
        if (m_Master <> nil) then begin
          TPlayObject(m_Master).RecalcAbilitys;
          TPlayObject(m_Master).SendMsg(m_Master, RM_ABILITY, 0, 0, 0, 0, '');
        end;
      end;

    RM_UNHEROGROUP: begin
        if m_btHeroGroup > 0 then begin
          m_btHeroGroup := 0;
          m_boFixedHideMode := False;
          SendRefMsg(RM_TURN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
          if (m_Master <> nil) then begin
            TPlayObject(m_Master).RecalcAbilitys;
            TPlayObject(m_Master).SendMsg(m_Master, RM_ABILITY, 0, 0, 0, 0, '');
          end;
        end;
      end;

    CM_HEROLOGON_OK: begin
        m_boHeroLogOnOK := True;
      end;

    CM_REPAIRFIRDRAGON: begin
        ClientRepairFirDragon(ProcessMsg.nParam2, ProcessMsg.nParam1, ProcessMsg.sMsg);
      end;

    CM_HEROTAKEONITEM: begin //1003
        ClientTakeOnItems(ProcessMsg.nParam2, ProcessMsg.nParam1, ProcessMsg.sMsg);
      end;

    CM_HEROTAKEOFFITEM: begin //1004
        ClientTakeOffItems(ProcessMsg.nParam2, ProcessMsg.nParam1, ProcessMsg.sMsg);
      end;

    CM_HEROEAT: begin //1006
        ClientUseItems(ProcessMsg.nParam1, ProcessMsg.sMsg);
      end;

    CM_HERODROPITEM: begin //1000
        if ClientDropItem(ProcessMsg.sMsg, ProcessMsg.nParam1) then
          SendDefMessage(SM_HERODROPITEM_SUCCESS, ProcessMsg.nParam1, 0, 0, 0, ProcessMsg.sMsg)
        else SendDefMessage(SM_HERODROPITEM_FAIL, ProcessMsg.nParam1, 0, 0, 0, ProcessMsg.sMsg);
      end;

    CM_HEROMAGICKEYCHANGE: begin
        ClientChangeMagicKey(ProcessMsg.nParam1);
      end;

    RM_SENDDELITEMLIST: begin //10148  004D9D48  //SM_DELITEMS
        SendDelItemList(TStringList(ProcessMsg.nParam1));
        TStringList(ProcessMsg.nParam1).Free;
      end;

    RM_STRUCK: begin
        if (m_Master <> nil) and (not m_Master.m_boGhost) and (not m_boHeroLogOut) and (not m_boGhost) then begin
          if (ProcessMsg.BaseObject = Self) and (TActorObject(ProcessMsg.nParam3 {AttackBaseObject}) <> nil) then begin
            SetLastHiter(TActorObject(ProcessMsg.nParam3 {AttackBaseObject}));
            Struck(TActorObject(ProcessMsg.nParam3 {AttackBaseObject})); {0FFEC}
            BreakHolySeizeMode();
            if (m_Master <> nil) and
              (TActorObject(ProcessMsg.nParam3) <> m_Master) and
              (TActorObject(ProcessMsg.nParam3).m_btRaceServer = RC_PLAYOBJECT) then begin

              m_Master.SetPKFlag(TActorObject(ProcessMsg.nParam3));
            end;
            if g_Config.boMonSayMsg then MonsterSayMsg(TActorObject(ProcessMsg.nParam3), s_UnderFire);
          end;
        end;
      end;

     { RM_USERNAME: begin
          m_DefMsg := MakeDefaultMsg(SM_USERNAME,
            Integer(ProcessMsg.BaseObject),
            GetCharColor(TBaseObject(ProcessMsg.BaseObject)), 0, 0);
          SendSocket(@m_DefMsg, EncodeString(ProcessMsg.sMsg));
        end;
        }
    RM_WINEXP: begin
        m_DefMsg := MakeDefaultMsg(SM_HEROWINEXP, m_Abil.Exp, LoWord(ProcessMsg.nParam1), HiWord(ProcessMsg.nParam1), 0);
        SendSocket(@m_DefMsg, '');
      end;

    RM_LEVELUP: begin
        //m_DefMsg := MakeDefaultMsg(SM_HEROLEVELUP, m_Abil.Exp, m_Abil.Level, 0, 0);
        m_DefMsg := MakeDefaultMsg(SM_HEROLEVELUP, m_Abil.Exp, LoWord(m_Abil.Level), HiWord(m_Abil.Level), 0);
        SendSocket(@m_DefMsg, '');
        m_DefMsg := MakeDefaultMsg(SM_HEROABILITY, 0, MakeWord(m_btJob, Self.m_btGender), 0, 0);

        SendSocket(@m_DefMsg, EncodeBuffer(@m_WAbil, SizeOf(TAbility)));
        SendDefMessage(SM_HEROSUBABILITY,
          MakeLong(MakeWord(m_nAntiMagic, 0), 0),
          MakeWord(m_btHitPoint, m_btSpeedPoint),
          MakeWord(m_btAntiPoison, m_nPoisonRecover),
          MakeWord(m_nHealthRecover, m_nSpellRecover),
          '');
      end;
     { RM_CHANGENAMECOLOR: begin
          SendDefMessage(SM_CHANGENAMECOLOR,
            Integer(ProcessMsg.BaseObject),
            GetCharColor(TBaseObject(ProcessMsg.BaseObject)),
            0,
            0,
            '');
        end;    }
    RM_ABILITY: begin
        m_DefMsg := MakeDefaultMsg(SM_HEROABILITY,
          Integer(ProcessMsg.BaseObject),
          MakeWord(m_btJob, Self.m_btGender),
          0,
          0);
        SendSocket(@m_DefMsg, EncodeBuffer(@m_WAbil, SizeOf(TAbility)));
      end;

    RM_HEALTHSPELLCHANGED: begin
        Health.HP := TActorObject(ProcessMsg.BaseObject).m_WAbil.HP;
        Health.MP := TActorObject(ProcessMsg.BaseObject).m_WAbil.MP;
        Health.MaxHP := TActorObject(ProcessMsg.BaseObject).m_WAbil.MaxHP;
        m_DefMsg := MakeDefaultMsg(SM_HEALTHSPELLCHANGED, Integer(ProcessMsg.BaseObject), 0, 0, 0);
        SendSocket(@m_DefMsg, EncodeBuffer(@Health, SizeOf(THealth)));
      end;

    RM_SENDUSEITEMS: SendUseitems();

    RM_QUERYBAGITEMS, CM_QUERYHEROBAGITEMS: begin
        if GetTickCount() - m_dwQueryItemBagTick > 3000 then begin
          m_dwQueryItemBagTick := GetTickCount();
          ClientQueryBagItems();
          RefBagItemCount;
        end else begin
          SysMsg('包裹刷新失败，请稍后在试...', 255, 253, t_Hint);
        end;
      end;

    RM_SENDMYMAGIC: SendUseMagic;

    RM_WEIGHTCHANGED: begin
        SendDefMessage(SM_HEROWEIGHTCHANGED,
          m_WAbil.Weight,
          m_WAbil.WearWeight,
          m_WAbil.HandWeight,
          0,
          '');
      end;

    {  RM_FEATURECHANGED: begin
          SendDefMessage(SM_FEATURECHANGED,
            Integer(ProcessMsg.BaseObject),
            LoWord(ProcessMsg.nParam1),
            HiWord(ProcessMsg.nParam1),
            ProcessMsg.wParam,
            '');
        end; }

    RM_MAGIC_LVEXP: begin
        SendDefMessage(SM_HEROMAGIC_LVEXP,
          ProcessMsg.nParam1,
          ProcessMsg.nParam2,
          LoWord(ProcessMsg.nParam3),
          HiWord(ProcessMsg.nParam3),
          '');
      end;

    RM_DURACHANGE: begin
        SendDefMessage(SM_HERODURACHANGE,
          ProcessMsg.nParam1,
          ProcessMsg.wParam,
          LoWord(ProcessMsg.nParam2),
          HiWord(ProcessMsg.nParam2),
          '');
      end;

    RM_SUBABILITY: begin
        SendDefMessage(SM_HEROSUBABILITY,
          MakeLong(MakeWord(m_nAntiMagic, 0), 0),
          MakeWord(m_btHitPoint, m_btSpeedPoint),
          MakeWord(m_btAntiPoison, m_nPoisonRecover),
          MakeWord(m_nHealthRecover, m_nSpellRecover),
          '');

      end;
    RM_HEROANGERVALUE: begin
        SendDefMessage(SM_HEROANGERVALUE,
          Integer(ProcessMsg.BaseObject),
          ProcessMsg.wParam,
          ProcessMsg.nParam2,
          0,
          '');
      end;

    RM_HEROTAKEONITEM: begin
        SendDefMessage(SM_HEROTAKEONITEM, ProcessMsg.nParam1, ProcessMsg.wParam, 0, 0, ProcessMsg.sMsg);
      end;

    RM_HEROTAKEOFFITEM: begin
        SendDefMessage(SM_HEROTAKEOFFITEM, ProcessMsg.nParam1, ProcessMsg.wParam, 0, 0, ProcessMsg.sMsg);
      end;

  else begin
      Result := inherited Operate(ProcessMsg);
    end;
  end;
 { except
    MainOutMessage('ProcessMsg.wIdent:' + IntToStr(ProcessMsg.wIdent));
  end;}
end;

function THeroObject.IsSend: Boolean;
begin
  Result := (not m_boAI) and (m_Master <> nil) and (not m_Master.m_boNotOnlineAddExp) and (not m_Master.m_boAI);
  {Result := False;
  if (m_Master = nil) or m_boAI then Exit;
  if (m_Master <> nil) and (m_Master.m_boNotOnlineAddExp or m_Master.m_boAI) then Exit;
  Result := True;  }
end;

procedure THeroObject.SetTargetCreat(BaseObject: TActorObject);
begin
  if (not m_boTarget) and (m_btStatus = 0) then begin
    m_TargetCret := BaseObject;
    m_dwTargetFocusTick := GetTickCount();
  end;
end;

procedure THeroObject.SetPKFlag(BaseObject: TActorObject);
begin
  inherited SetPKFlag(BaseObject);
end;

procedure THeroObject.SetLastHiter(BaseObject: TActorObject);
begin
  if m_boTarget then begin
    if BaseObject = m_TargetCret then begin
      inherited SetLastHiter(BaseObject);
    end else begin
      m_LastHiterTick := GetTickCount();
      m_ExpHitterTick := GetTickCount();
    end;
  end else begin
    inherited SetLastHiter(BaseObject);
  end;
end;

procedure THeroObject.SendSocket(DefMsg: pTDefaultMessage; sMsg: string);
begin
  if IsSend then
    TPlayObject(m_Master).SendSocket(DefMsg, sMsg);
end;

procedure THeroObject.SendDefMessage(wIdent: Word; nRecog: Integer; nParam, nTag, nSeries: Word; sMsg: string);
begin
  if IsSend then
    TPlayObject(m_Master).SendDefMessage(wIdent, nRecog, nParam, nTag, nSeries, sMsg);
end;

procedure THeroObject.SysMsg(sMsg: string; MsgColor: TMsgColor; MsgType: TMsgType);
begin
  if IsSend then m_Master.SysMsg('(英雄) ' + sMsg, MsgColor, MsgType);
end;

procedure THeroObject.SysMsg(sMsg: string; btFColor, btBColor: Byte; MsgType: TMsgType);
begin
  if IsSend then m_Master.SysMsg('(英雄) ' + sMsg, btFColor, btBColor, MsgType);
end;

procedure THeroObject.RefBagItemCount;
var
  I: Integer;
  nOldBagCount: Integer;
begin
  nOldBagCount := m_nItemBagCount;
  for I := High(g_Config.HeroBagItemCounts) downto Low(g_Config.HeroBagItemCounts) do begin
    if m_Abil.Level >= g_Config.HeroBagItemCounts[I] then begin
      case I of
        0: m_nItemBagCount := 10;
        1: m_nItemBagCount := 20;
        2: m_nItemBagCount := 30;
        3: m_nItemBagCount := 35;
        4: m_nItemBagCount := 40;
      end;
      Break;
    end;
  end;
  if nOldBagCount <> m_nItemBagCount then begin
    SendDefMessage(SM_HEROBAGCOUNT, Integer(Self), m_nItemBagCount, 0, 0, '');
  end;
end;

function THeroObject.FindGroupMagic: pTUserMagic;
begin
  Result := FindMagic(GetGroupMagicId);
end;

function THeroObject.GetGroupMagicId: Integer;
begin
  Result := 0;
  if m_Master = nil then Exit;
  case m_Master.m_btJob of
    0: begin
        case m_btJob of
          0: Result := 60;
          1: Result := 62;
          2: Result := 61;
        end;
      end;
    1: begin
        case m_btJob of
          0: Result := 62;
          1: Result := 65;
          2: Result := 64;
        end;
      end;
    2: begin
        case m_btJob of
          0: Result := 61;
          1: Result := 64;
          2: Result := 63;
        end;
      end;
  end;
end;

procedure THeroObject.ClientTakeOnItemsEx(btWhere: Byte; nItemIdx: Integer; sItemName: string);
var
  I, n14, n18: Integer;
  UserItem, TakeOffItem: pTUserItem;
  StdItem, StdItem20: pTStdItem;
  StdItem58: TStdItem;
  sUserItemName: string;
begin
  StdItem := nil;
  UserItem := nil;
  n14 := -1;

  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem := m_ItemList.Items[I];
    if (UserItem <> nil) and (UserItem.MakeIndex = nItemIdx) then begin
      //取自定义物品名称
      sUserItemName := '';
      if UserItem.btValue[13] = 1 then
        sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
      if sUserItemName = '' then
        sUserItemName := UserEngine.GetStdItemName(UserItem.wIndex);

      if TPlayObject(m_Master).CheckItemBindUse(UserItem, False) = 2 then begin //绑定物品
        sUserItemName := '(绑)' + sUserItemName;
      end;

      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem <> nil then begin
        if CompareText(sUserItemName, sItemName) = 0 then begin
          n14 := I;
          Break;
        end;
      end;
    end;
    UserItem := nil;
  end;
  n18 := 0;
  if (StdItem <> nil) and (UserItem <> nil) then begin
    if CheckUserItems(btWhere, StdItem) then begin
      StdItem58 := StdItem^;
      ItemUnit.GetItemAddValue(UserItem, StdItem58);
      if CheckTakeOnItems(btWhere, StdItem58) { and TPlayObject(m_Master).CheckItemBindUse(UserItem)} then begin
        TakeOffItem := nil;
        if btWhere in [0..12] then begin

          if m_UseItems[btWhere].wIndex > 0 then begin
            StdItem20 := UserEngine.GetStdItem(m_UseItems[btWhere].wIndex);
            if (StdItem20 <> nil) and
              (StdItem20.StdMode in [15, 19, 20, 21, 22, 23, 24, 26]) then begin
              if (not m_boUserUnLockDurg) and (m_UseItems[btWhere].btValue[7] <> 0) then begin
                SysMsg(g_sCanotTakeOffItem {'无法取下物品！！！'}, c_Red, t_Hint);
                n18 := -4;
                Exit;
              end;
            end;
            if not m_boUserUnLockDurg and ((StdItem20.Reserved and 2) <> 0) then begin
              SysMsg(g_sCanotTakeOffItem {'无法取下物品！！！'}, c_Red, t_Hint);
              n18 := -4;
              Exit;
            end; //004DAE78
            if (StdItem20.Reserved and 4) <> 0 then begin
              SysMsg(g_sCanotTakeOffItem {'无法取下物品！！！'}, c_Red, t_Hint);
              n18 := -4;
              Exit;
            end;
            if InDisableTakeOffList(m_UseItems[btWhere].wIndex) then begin
              SysMsg(g_sCanotTakeOffItem {'无法取下物品！！！'}, c_Red, t_Hint);
              Exit;
            end;
            New(TakeOffItem);
            TakeOffItem^ := m_UseItems[btWhere];
          end; //004DAEC7 if m_UseItems[btWhere].wIndex > 0 then begin

          //GroupItem := m_GroupItem;
          GetGroupItemList;
          if (StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26]) and
            (UserItem.btValue[8] <> 0) then
            UserItem.btValue[8] := 0;

          m_UseItems[btWhere] := UserItem^;
          DelBagItem(n14);
          if TakeOffItem <> nil then begin
            AddItemToBag(TakeOffItem);
            SendAddItem(TakeOffItem);
          end;

          RecalcAbilitys();
          SendMsg(Self, RM_ABILITY, 0, 0, 0, 0, '');
          SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');
          SendDefMessage(SM_HEROTAKEONITEM, nItemIdx, btWhere, 0, 0, sItemName);
          //SendDefMessage(SM_HEROTAKEON_OK, GetFeatureToLong, GetFeatureEx, 0, 0, '');
          FeatureChanged();
          //if (GroupItem <> m_GroupItem) and (m_GroupItem <> nil) and (m_GroupItem.FLD_HINTMSG <> '') then begin
          //  SysMsg(m_GroupItem.FLD_HINTMSG, c_Red, t_Hint);
          //end;
          SendGroupItemMsg();
          n18 := 1;
        end;
      end else n18 := -1;
    end else n18 := -1;
  end;
end;

procedure THeroObject.ClientTakeOffItemsEx(btWhere: Byte; nItemIdx: Integer; sItemName: string);
var
  n10: Integer;
  StdItem: pTStdItem;
  UserItem: pTUserItem;
  sUserItemName: string;
begin
  n10 := 0;
  if (btWhere < 13) then begin
    if m_UseItems[btWhere].wIndex > 0 then begin
      if m_UseItems[btWhere].MakeIndex = nItemIdx then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[btWhere].wIndex);
        if (StdItem <> nil) and
          (StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26]) then begin
          if (not m_boUserUnLockDurg) and (m_UseItems[btWhere].btValue[7] <> 0) then begin
            SysMsg(g_sCanotTakeOffItem {'无法取下物品！！！'}, c_Red, t_Hint);
            n10 := -4;
            Exit;
          end;
        end;
        if not m_boUserUnLockDurg and ((StdItem.Reserved and 2) <> 0) then begin
          SysMsg(g_sCanotTakeOffItem {'无法取下物品！！！'}, c_Red, t_Hint);
          n10 := -4;
          Exit;
        end;
        if (StdItem.Reserved and 4) <> 0 then begin
          SysMsg(g_sCanotTakeOffItem {'无法取下物品！！！'}, c_Red, t_Hint);
          n10 := -4;
          Exit;
        end;
        if InDisableTakeOffList(m_UseItems[btWhere].wIndex) then begin
          SysMsg(g_sCanotTakeOffItem {'无法取下物品！！！'}, c_Red, t_Hint);
          Exit;
        end;
        //取自定义物品名称
        sUserItemName := '';
        if m_UseItems[btWhere].btValue[13] = 1 then
          sUserItemName := ItemUnit.GetCustomItemName(m_UseItems[btWhere].MakeIndex, m_UseItems[btWhere].wIndex);
        if sUserItemName = '' then
          sUserItemName := UserEngine.GetStdItemName(m_UseItems[btWhere].wIndex);

        if TPlayObject(m_Master).CheckItemBindUse(@(m_UseItems[btWhere]), False) = 2 then begin //绑定物品
          sUserItemName := '(绑)' + sUserItemName;
        end;

        if CompareText(sUserItemName, sItemName) = 0 then begin
          New(UserItem);
          UserItem^ := m_UseItems[btWhere];
          if AddItemToBag(UserItem) then begin
            m_UseItems[btWhere].wIndex := 0;

            SendAddItem(UserItem);
            RecalcAbilitys();
            SendMsg(Self, RM_ABILITY, 0, 0, 0, 0, '');
            SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');
            SendDefMessage(SM_HEROTAKEOFFITEM, nItemIdx, btWhere, 0, 0, sItemName);
            //SendDefMessage(SM_HEROTAKEOFF_OK, GetFeatureToLong, GetFeatureEx, 0, 0, '');
            FeatureChanged();
          end else begin
            Dispose(UserItem);
            n10 := -3;
          end;
        end;
      end;
    end else n10 := -2;
  end else n10 := -1;
end;

procedure THeroObject.ClientTakeOnItems(btWhere: Byte; nItemIdx: Integer; sItemName: string);
var
  I, n14, n18: Integer;
  UserItem, TakeOffItem: pTUserItem;
  StdItem, StdItem20: pTStdItem;
  StdItem58: TStdItem;
  sUserItemName: string;
label FailExit;
begin
  StdItem := nil;
  UserItem := nil;
  n14 := -1;

  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem := m_ItemList.Items[I];
    if (UserItem <> nil) and (UserItem.MakeIndex = nItemIdx) then begin
      //取自定义物品名称
      sUserItemName := '';
      if UserItem.btValue[13] = 1 then
        sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
      if sUserItemName = '' then
        sUserItemName := UserEngine.GetStdItemName(UserItem.wIndex);

      if TPlayObject(m_Master).CheckItemBindUse(UserItem, False) = 2 then begin //绑定物品
        sUserItemName := '(绑)' + sUserItemName;
      end;

      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem <> nil then begin
        if CompareText(sUserItemName, sItemName) = 0 then begin
          n14 := I;
          Break;
        end;
      end;
    end;
    StdItem := nil;
    UserItem := nil;
  end;

  n18 := 0;
  if (StdItem <> nil) and (UserItem <> nil) then begin
    if CheckUserItems(btWhere, StdItem) then begin
      StdItem58 := StdItem^;
      ItemUnit.GetItemAddValue(UserItem, StdItem58);
      if CheckTakeOnItems(btWhere, StdItem58) { and TPlayObject(m_Master).CheckItemBindUse(UserItem)} then begin
        TakeOffItem := nil;
        if btWhere in [0..12] then begin

          if m_UseItems[btWhere].wIndex > 0 then begin
            StdItem20 := UserEngine.GetStdItem(m_UseItems[btWhere].wIndex);
            if (StdItem20 <> nil) and
              (StdItem20.StdMode in [15, 19, 20, 21, 22, 23, 24, 26]) then begin
              if (not m_boUserUnLockDurg) and (m_UseItems[btWhere].btValue[7] <> 0) then begin
                SysMsg(g_sCanotTakeOffItem {'无法取下物品！！！'}, c_Red, t_Hint);
                n18 := -4;
                goto FailExit;
              end;
            end;
            if not m_boUserUnLockDurg and ((StdItem20.Reserved and 2) <> 0) then begin
              SysMsg(g_sCanotTakeOffItem {'无法取下物品！！！'}, c_Red, t_Hint);
              n18 := -4;
              goto FailExit;
            end; //004DAE78
            if (StdItem20.Reserved and 4) <> 0 then begin
              SysMsg(g_sCanotTakeOffItem {'无法取下物品！！！'}, c_Red, t_Hint);
              n18 := -4;
              goto FailExit;
            end;
            if InDisableTakeOffList(m_UseItems[btWhere].wIndex) then begin
              SysMsg(g_sCanotTakeOffItem {'无法取下物品！！！'}, c_Red, t_Hint);
              goto FailExit;
            end;
            New(TakeOffItem);
            TakeOffItem^ := m_UseItems[btWhere];
          end; //004DAEC7 if m_UseItems[btWhere].wIndex > 0 then begin

          GetGroupItemList;
          if (StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26]) and
            (UserItem.btValue[8] <> 0) then
            UserItem.btValue[8] := 0;

          m_UseItems[btWhere] := UserItem^;
          DelBagItem(n14);
          if TakeOffItem <> nil then begin
            AddItemToBag(TakeOffItem);
            SendAddItem(TakeOffItem);
          end;
          RecalcAbilitys();
          SendMsg(Self, RM_ABILITY, 0, 0, 0, 0, '');
          SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');
          SendDefMessage(SM_HEROTAKEON_OK, GetFeatureToLong, GetFeatureEx, 0, 0, '');
          FeatureChanged();

          SendGroupItemMsg();

          n18 := 1;
        end;
      end else n18 := -1;
    end else n18 := -1;
  end;
  FailExit:
  if n18 <= 0 then
    SendDefMessage(SM_HEROTAKEON_FAIL, n18, 0, 0, 0, '');
end;

procedure THeroObject.ClientTakeOffItems(btWhere: Byte; nItemIdx: Integer; sItemName: string);
var
  n10: Integer;
  StdItem: pTStdItem;
  UserItem: pTUserItem;
  sUserItemName: string;
label FailExit;
begin
  n10 := 0;
  if (btWhere < 13) then begin
    if m_UseItems[btWhere].wIndex > 0 then begin
      if m_UseItems[btWhere].MakeIndex = nItemIdx then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[btWhere].wIndex);
        if (StdItem <> nil) and
          (StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26]) then begin
          if (not m_boUserUnLockDurg) and (m_UseItems[btWhere].btValue[7] <> 0) then begin
            SysMsg(g_sCanotTakeOffItem {'无法取下物品！！！'}, c_Red, t_Hint);
            n10 := -4;
            goto FailExit;
          end;
        end;
        if not m_boUserUnLockDurg and ((StdItem.Reserved and 2) <> 0) then begin
          SysMsg(g_sCanotTakeOffItem {'无法取下物品！！！'}, c_Red, t_Hint);
          n10 := -4;
          goto FailExit;
        end;
        if (StdItem.Reserved and 4) <> 0 then begin
          SysMsg(g_sCanotTakeOffItem {'无法取下物品！！！'}, c_Red, t_Hint);
          n10 := -4;
          goto FailExit;
        end;
        if InDisableTakeOffList(m_UseItems[btWhere].wIndex) then begin
          SysMsg(g_sCanotTakeOffItem {'无法取下物品！！！'}, c_Red, t_Hint);
          goto FailExit;
        end;
        //取自定义物品名称
        sUserItemName := '';
        if m_UseItems[btWhere].btValue[13] = 1 then
          sUserItemName := ItemUnit.GetCustomItemName(m_UseItems[btWhere].MakeIndex, m_UseItems[btWhere].wIndex);
        if sUserItemName = '' then
          sUserItemName := UserEngine.GetStdItemName(m_UseItems[btWhere].wIndex);

        if TPlayObject(m_Master).CheckItemBindUse(@(m_UseItems[btWhere]), False) = 2 then begin //绑定物品
          sUserItemName := '(绑)' + sUserItemName;
        end;

        if CompareText(sUserItemName, sItemName) = 0 then begin
          New(UserItem);
          UserItem^ := m_UseItems[btWhere];
          if AddItemToBag(UserItem) then begin
            m_UseItems[btWhere].wIndex := 0;

            SendAddItem(UserItem);
            RecalcAbilitys();
            SendMsg(Self, RM_ABILITY, 0, 0, 0, 0, '');
            SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');
            SendDefMessage(SM_HEROTAKEOFF_OK, GetFeatureToLong, GetFeatureEx, 0, 0, '');
            FeatureChanged();
          end else begin
            Dispose(UserItem);
            n10 := -3;
          end;
        end;
      end;
    end else n10 := -2;
  end else n10 := -1;
  FailExit:
  if n10 <= 0 then
    SendDefMessage(SM_HEROTAKEOFF_FAIL, n10, 0, 0, 0, '');
end;

procedure THeroObject.ClientQueryBagItems();
var
  I, nCount: Integer;
  Item: pTStdItem;
  sSENDMSG: string;
  ClientItem: TClientItem;
  StdItem: TStdItem;
  UserItem: pTUserItem;
  sUserItemName: string;
  ItemBagList: TStringList;
begin
  sSENDMSG := '';
  //if m_ItemList.Count <= 20 then begin
  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem := m_ItemList.Items[I];
    Item := UserEngine.GetStdItem(UserItem.wIndex);
    if Item <> nil then begin
      StdItem := Item^;
      ItemUnit.GetItemAddValue(UserItem, StdItem);
      Move(StdItem, ClientItem.s, SizeOf(TStdItem));
      //取自定义物品名称
      sUserItemName := '';
      if UserItem.btValue[13] = 1 then
        sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
      if sUserItemName <> '' then
        ClientItem.s.Name := sUserItemName;

      if m_Master <> nil then
        if TPlayObject(m_Master).CheckItemBindUse(UserItem, False) = 2 then begin //绑定物品
          ClientItem.s.Name := '(绑)' + ClientItem.s.Name;
        end;

      ClientItem.Dura := UserItem.Dura;
      ClientItem.DuraMax := UserItem.DuraMax;
      ClientItem.MakeIndex := UserItem.MakeIndex;

      ClientItem.s.AddValue := UserItem.AddValue;
      ClientItem.s.AddPoint := UserItem.AddPoint;
      ClientItem.s.MaxDate := UserItem.MaxDate;
      //ClientItem.s.sDescr := UserEngine.GetStdItemDescr(ClientItem.s, UserItem);

      if StdItem.StdMode = 50 then begin
        ClientItem.s.Name := ClientItem.s.Name + ' #' + IntToStr(UserItem.Dura);
      end;
      sSENDMSG := sSENDMSG + EncodeBuffer(@ClientItem, SizeOf(TClientItem)) + '/';
    end;
  end;

  if sSENDMSG <> '' then begin
    m_DefMsg := MakeDefaultMsg(SM_HEROBAGITEMS, Integer(Self), 0, 0, m_ItemList.Count);
    SendSocket(@m_DefMsg, sSENDMSG);
  end;
end;

function THeroObject.AddItemToBag(UserItem: pTUserItem): Boolean;
begin
  Result := False;
  if m_ItemList.Count < m_nItemBagCount then begin
    m_ItemList.Add(UserItem);
    WeightChanged();
    Result := True;
  end;
end;

procedure THeroObject.SendUseMagic();
var
  I: Integer;
  sSENDMSG: string;
  UserMagic: pTUserMagic;
  ClientMagic: TClientMagic;
begin
  sSENDMSG := '';
  for I := 0 to m_MagicList.Count - 1 do begin
    UserMagic := m_MagicList.Items[I];
    if UserMagic <> nil then begin
      ClientMagic.Key := Chr(UserMagic.btKey);
      ClientMagic.Level := UserMagic.btLevel;
      ClientMagic.CurTrain := UserMagic.nTranPoint;
      ClientMagic.Def := UserMagic.MagicInfo^;
      sSENDMSG := sSENDMSG + EncodeBuffer(@ClientMagic, SizeOf(TClientMagic)) + '/';
    end;
  end;
  if sSENDMSG <> '' then begin
    m_DefMsg := MakeDefaultMsg(SM_SENDMYHEROMAGIC, 0, 0, 0, m_MagicList.Count);
    SendSocket(@m_DefMsg, sSENDMSG);
  end;
end;

procedure THeroObject.SendUseitems();
var
  I: Integer;
  Item: pTStdItem;
  sSENDMSG: string;
  ClientItem: TClientItem;
  StdItem: TStdItem;
  sUserItemName: string;
begin
  sSENDMSG := '';
  for I := Low(THumanUseItems) to High(THumanUseItems) do begin
    if m_UseItems[I].wIndex > 0 then begin
      //sItemNewName:=GetItemName(m_UseItems[i].MakeIndex);
      Item := UserEngine.GetStdItem(m_UseItems[I].wIndex);
      if Item <> nil then begin
        StdItem := Item^;
        ItemUnit.GetItemAddValue(@m_UseItems[I], StdItem);
        Move(StdItem, ClientItem.s, SizeOf(TStdItem));
        //取自定义物品名称
        sUserItemName := '';
        if m_UseItems[I].btValue[13] = 1 then
          sUserItemName := ItemUnit.GetCustomItemName(m_UseItems[I].MakeIndex, m_UseItems[I].wIndex);
        if sUserItemName <> '' then
          ClientItem.s.Name := sUserItemName;

        if m_Master <> nil then
          if TPlayObject(m_Master).CheckItemBindUse(@m_UseItems[I], False) = 2 then begin //绑定物品
            ClientItem.s.Name := '(绑)' + ClientItem.s.Name;
          end;

        ClientItem.Dura := m_UseItems[I].Dura;
        ClientItem.DuraMax := m_UseItems[I].DuraMax;
        ClientItem.MakeIndex := m_UseItems[I].MakeIndex;

        ClientItem.s.AddValue := m_UseItems[I].AddValue;
        ClientItem.s.AddPoint := m_UseItems[I].AddPoint;
        ClientItem.s.MaxDate := m_UseItems[I].MaxDate;
        //ClientItem.s.sDescr := UserEngine.GetStdItemDescr(ClientItem.s, @m_UseItems[I]);

        sSENDMSG := sSENDMSG + IntToStr(I) + '/' + EncodeBuffer(@ClientItem, SizeOf(TClientItem)) + '/';
      end;
    end;
  end;
  if sSENDMSG <> '' then begin
    m_DefMsg := MakeDefaultMsg(SM_SENDHEROUSEITEMS, 0, 0, 0, 0);
    SendSocket(@m_DefMsg, sSENDMSG);
  end;
end;

procedure THeroObject.SendChangeItems(nWhere: Integer; UserItem: pTUserItem);
var
  sUserItemName: string;
  sSendText: string;
begin
  sSendText := '';
  if UserItem.btValue[13] = 1 then
    sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
  if sUserItemName = '' then
    sUserItemName := UserEngine.GetStdItemName(UserItem.wIndex);

  if m_Master <> nil then
    if TPlayObject(m_Master).CheckItemBindUse(UserItem, False) = 2 then begin //绑定物品
      sUserItemName := '(绑)' + sUserItemName;
    end;

  sSendText := IntToStr(nWhere) + '/' + sUserItemName + '/' + IntToStr(UserItem.MakeIndex);
  if sSendText <> '' then begin
    SendDefMessage(SM_HEROCHANGEITEM, Integer(m_Master), 0, 0, 0, sSendText);
  end;
end;

procedure THeroObject.SendDelItemList(ItemList: TStringList);
var
  I: Integer;
  s10: string;
begin
  s10 := '';
  for I := 0 to ItemList.Count - 1 do begin
    s10 := s10 + ItemList.Strings[I] + '/' + IntToStr(Integer(ItemList.Objects[I])) + '/';
  end;
  m_DefMsg := MakeDefaultMsg(SM_HERODELITEMS, 0, 0, 0, ItemList.Count);
  SendSocket(@m_DefMsg, EncodeString(s10));
end;

procedure THeroObject.SendDelItems(UserItem: pTUserItem);
var
  StdItem: pTStdItem;
  StdItem80: TStdItem;
  ClientItem: TClientItem;
  sUserItemName: string;
begin
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if StdItem <> nil then begin
    StdItem80 := StdItem^;
    ItemUnit.GetItemAddValue(@UserItem, StdItem80);
    Move(StdItem80, ClientItem.s, SizeOf(TStdItem));
    //取自定义物品名称
    sUserItemName := '';
    if UserItem.btValue[13] = 1 then
      sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
    if sUserItemName <> '' then
      ClientItem.s.Name := sUserItemName;

    if m_Master <> nil then
      if TPlayObject(m_Master).CheckItemBindUse(UserItem, False) = 2 then begin //绑定物品
        ClientItem.s.Name := '(绑)' + ClientItem.s.Name;
      end;

    ClientItem.MakeIndex := UserItem.MakeIndex;
    ClientItem.Dura := UserItem.Dura;
    ClientItem.DuraMax := UserItem.DuraMax;

    ClientItem.s.AddValue := UserItem.AddValue;
    ClientItem.s.AddPoint := UserItem.AddPoint;
    ClientItem.s.MaxDate := UserItem.MaxDate;
    //ClientItem.s.sDescr := UserEngine.GetStdItemDescr(ClientItem.s, UserItem);

    if StdItem.StdMode = 50 then begin
      ClientItem.s.Name := ClientItem.s.Name + ' #' + IntToStr(UserItem.Dura);
    end;
    m_DefMsg := MakeDefaultMsg(SM_HERODELITEM, Integer(m_Master), 0, 0, 1);
    SendSocket(@m_DefMsg, EncodeBuffer(@ClientItem, SizeOf(TClientItem)));
  end;
end;

procedure THeroObject.SendAddItem(UserItem: pTUserItem);
var
  pStdItem: pTStdItem;
  StdItem: TStdItem;
  ClientItem: TClientItem;
  sUserItemName: string;
begin
  pStdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if pStdItem = nil then Exit;
  StdItem := pStdItem^;
  ItemUnit.GetItemAddValue(UserItem, StdItem);
  Move(StdItem, ClientItem.s, SizeOf(TStdItem));
  //取自定义物品名称
  sUserItemName := '';
  if UserItem.btValue[13] = 1 then
    sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
  if sUserItemName <> '' then
    ClientItem.s.Name := sUserItemName;

  if m_Master <> nil then
    if TPlayObject(m_Master).CheckItemBindUse(UserItem, False) = 2 then begin //绑定物品
      ClientItem.s.Name := '(绑)' + ClientItem.s.Name;
    end;

  ClientItem.MakeIndex := UserItem.MakeIndex;
  ClientItem.Dura := UserItem.Dura;
  ClientItem.DuraMax := UserItem.DuraMax;

  ClientItem.s.AddValue := UserItem.AddValue;
  ClientItem.s.AddPoint := UserItem.AddPoint;
  ClientItem.s.MaxDate := UserItem.MaxDate;
  //ClientItem.s.sDescr := UserEngine.GetStdItemDescr(ClientItem.s, UserItem);

  if StdItem.StdMode = 50 then begin
    ClientItem.s.Name := ClientItem.s.Name + ' #' + IntToStr(UserItem.Dura);
  end;
  if StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26] then begin
    if UserItem.btValue[8] = 0 then ClientItem.s.Shape := 0
    else ClientItem.s.Shape := 130;
  end;
  m_DefMsg := MakeDefaultMsg(SM_HEROADDITEM, Integer(m_Master), 0, 0, 1);
  SendSocket(@m_DefMsg, EncodeBuffer(@ClientItem, SizeOf(TClientItem)));
end;

procedure THeroObject.SendUpdateItem(UserItem: pTUserItem);
var
  StdItem: pTStdItem;
  StdItem80: TStdItem;
  ClientItem: TClientItem;
  OClientItem: TOClientItem;
  sUserItemName: string;
begin
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if StdItem <> nil then begin
    StdItem80 := StdItem^;
    ItemUnit.GetItemAddValue(UserItem, StdItem80);
    ClientItem.s := StdItem80;
    //取自定义物品名称
    sUserItemName := '';
    if UserItem.btValue[13] = 1 then
      sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
    if sUserItemName <> '' then
      ClientItem.s.Name := sUserItemName;

    if m_Master <> nil then
      if TPlayObject(m_Master).CheckItemBindUse(UserItem, False) = 2 then begin //绑定物品
        ClientItem.s.Name := '(绑)' + ClientItem.s.Name;
      end;

    ClientItem.MakeIndex := UserItem.MakeIndex;
    ClientItem.Dura := UserItem.Dura;
    ClientItem.DuraMax := UserItem.DuraMax;

    ClientItem.s.AddValue := UserItem.AddValue;
    ClientItem.s.AddPoint := UserItem.AddPoint;
    ClientItem.s.MaxDate := UserItem.MaxDate;
    //ClientItem.s.sDescr := UserEngine.GetStdItemDescr(ClientItem.s, UserItem);

    if StdItem.StdMode = 50 then begin
      ClientItem.s.Name := ClientItem.s.Name + ' #' + IntToStr(UserItem.Dura);
    end;
    m_DefMsg := MakeDefaultMsg(SM_HEROUPDATEITEM, Integer(Self), 0, 0, 1);
    SendSocket(@m_DefMsg, EncodeBuffer(@ClientItem, SizeOf(TClientItem)));
  end;
end;

procedure THeroObject.ItemDamageRevivalRing();
var
  I: Integer;
  pSItem: pTStdItem;
  nDura, tDura: Integer;
  HeroObject: THeroObject;
begin
  for I := Low(THumanUseItems) to High(THumanUseItems) do begin
    if m_UseItems[I].wIndex > 0 then begin
      pSItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);
      if pSItem <> nil then begin
//        if (i = U_RINGR) or (i = U_RINGL) then begin
        if (pSItem.Shape in [114, 160, 161, 162]) or (((I = U_WEAPON) or (I = U_RIGHTHAND)) and (pSItem.AniCount in [114, 160, 161, 162])) then begin
          nDura := m_UseItems[I].Dura;
          tDura := Round(nDura / 1000 {1.03});
          Dec(nDura, 1000);
          if nDura <= 0 then begin
            nDura := 0;
            m_UseItems[I].Dura := nDura;
            {if m_btRaceServer = RC_HEROOBJECT then begin
              HeroObject := THeroObject(Self);
              HeroObject.SendDelItems(@m_UseItems[I]);
            end; //004C0310  }
            SendDelItems(@m_UseItems[I]);
            m_UseItems[I].wIndex := 0;
            RecalcAbilitys();
          end else begin //004C0331
            m_UseItems[I].Dura := nDura;
          end;
          if tDura <> Round(nDura / 1000 {1.03}) then begin
            SendMsg(Self, RM_DURACHANGE, I, nDura, m_UseItems[I].DuraMax, 0, '');
          end;
            //break;
        end; //004C0397
//        end;//004C0397
      end; //004C0397 if pSItem <> nil then begin
    end; //if UseItems[i].wIndex > 0 then begin
  end; // for i:=Low(UseItems) to High(UseItems) do begin
end;

procedure THeroObject.DoDamageWeapon(nWeaponDamage: Integer);
var
  nDura, nDuraPoint: Integer;
  HeroObject: THeroObject;
  StdItem: pTStdItem;
begin
  if m_UseItems[U_WEAPON].wIndex <= 0 then Exit;
  nDura := m_UseItems[U_WEAPON].Dura;
  nDuraPoint := Round(nDura / 1.03);
  Dec(nDura, nWeaponDamage);
  if nDura <= 0 then begin
    nDura := 0;
    m_UseItems[U_WEAPON].Dura := nDura;
    {
    HeroObject := THeroObject(Self);
    HeroObject.SendDelItems(@m_UseItems[U_WEAPON]);
    }
    SendDelItems(@m_UseItems[U_WEAPON]);
    StdItem := UserEngine.GetStdItem(m_UseItems[U_WEAPON].wIndex);
    if StdItem.NeedIdentify = 1 then
      AddGameDataLog('3' + #9 +
        m_sMapName + #9 +
        IntToStr(m_nCurrX) + #9 +
        IntToStr(m_nCurrY) + #9 +
        m_sCharName + #9 +
                        //UserEngine.GetStdItemName(m_UseItems[U_WEAPON].wIndex) + #9 +
        StdItem.Name + #9 +
        IntToStr(m_UseItems[U_WEAPON].MakeIndex) + #9 +
        BoolToIntStr(m_btRaceServer = RC_PLAYOBJECT) + #9 +
        '0');

    m_UseItems[U_WEAPON].wIndex := 0;
    //SendMsg(Self, RM_DURACHANGE, U_WEAPON, nDura, m_UseItems[U_WEAPON].DuraMax, 0, '');
  end else begin
    m_UseItems[U_WEAPON].Dura := nDura;
  end;
  if (nDura / 1.03) <> nDuraPoint then begin
    SendMsg(Self, RM_DURACHANGE, U_WEAPON, m_UseItems[U_WEAPON].Dura, m_UseItems[U_WEAPON].DuraMax, 0, '');
  end;
end;

procedure THeroObject.StruckDamage(nDamage: Integer);
var
  I: Integer;
  nDam: Integer;
  nDura, nOldDura: Integer;
  HeroObject: THeroObject;
  StdItem: pTStdItem;
  bo19: Boolean;
begin
  if nDamage <= 0 then Exit;
  nDam := Random(10) + 5;
  if m_wStatusTimeArr[POISON_DAMAGEARMOR {1 0x62}] > 0 then begin
    nDam := Round(nDam * (g_Config.nPosionDamagarmor / 10) {1.2});
    nDamage := Round(nDamage * (g_Config.nPosionDamagarmor / 10) {1.2});
  end;
  bo19 := False;
  if m_UseItems[U_DRESS].wIndex > 0 then begin
    nDura := m_UseItems[U_DRESS].Dura;
    nOldDura := Round(nDura / 1000);
    Dec(nDura, nDam);
    if nDura <= 0 then begin
        //HeroObject := THeroObject(Self);
        //HeroObject.SendDelItems(@m_UseItems[U_DRESS]);
      SendDelItems(@m_UseItems[U_DRESS]);
      StdItem := UserEngine.GetStdItem(m_UseItems[U_DRESS].wIndex);
      if StdItem.NeedIdentify = 1 then
        AddGameDataLog('3' + #9 +
          m_sMapName + #9 +
          IntToStr(m_nCurrX) + #9 +
          IntToStr(m_nCurrY) + #9 +
          m_sCharName + #9 +
                        //UserEngine.GetStdItemName(m_UseItems[U_DRESS].wIndex) + #9 +
          StdItem.Name + #9 +
          IntToStr(m_UseItems[U_DRESS].MakeIndex) + #9 +
          BoolToIntStr(m_btRaceServer = RC_PLAYOBJECT) + #9 +
          '0');
      m_UseItems[U_DRESS].wIndex := 0;
      FeatureChanged();

      //m_UseItems[U_DRESS].wIndex := 0;
      m_UseItems[U_DRESS].Dura := 0;
      bo19 := True;
    end else begin
      m_UseItems[U_DRESS].Dura := nDura;
    end;
    if nOldDura <> Round(nDura / 1000) then begin
      SendMsg(Self, RM_DURACHANGE, U_DRESS, nDura, m_UseItems[U_DRESS].DuraMax, 0, '');
    end;
  end;
  for I := Low(THumanUseItems) to High(THumanUseItems) do begin
    if (m_UseItems[I].wIndex > 0) and (Random(8) = 0) then begin
      nDura := m_UseItems[I].Dura;
      nOldDura := Round(nDura / 1000);
      Dec(nDura, nDam);
      if nDura <= 0 then begin

          //HeroObject := THeroObject(Self);
          //HeroObject.SendDelItems(@m_UseItems[I]);
        SendDelItems(@m_UseItems[I]);
        StdItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);
            //004BE2B8
        if StdItem.NeedIdentify = 1 then
          AddGameDataLog('3' + #9 +
            m_sMapName + #9 +
            IntToStr(m_nCurrX) + #9 +
            IntToStr(m_nCurrY) + #9 +
            m_sCharName + #9 +
                        //UserEngine.GetStdItemName(m_UseItems[i].wIndex) + #9 +
            StdItem.Name + #9 +
            IntToStr(m_UseItems[I].MakeIndex) + #9 +
            BoolToIntStr(m_btRaceServer = RC_PLAYOBJECT) + #9 +
            '0');
        m_UseItems[I].wIndex := 0;
        FeatureChanged();

        //m_UseItems[I].wIndex := 0;
        m_UseItems[I].Dura := 0;
        if I = U_HELMET then RefShowName;
        bo19 := True;
      end else begin
        m_UseItems[I].Dura := nDura;
      end;
      if nOldDura <> Round(nDura / 1000) then begin
        SendMsg(Self, RM_DURACHANGE, I, nDura, m_UseItems[I].DuraMax, 0, '');
      end;
    end;
  end;
  if bo19 then RecalcAbilitys();

  DamageHealth(nDamage);
end;

function THeroObject.ClientDropItem(sItemName: string;
  nItemIdx: Integer): Boolean;
var
  I: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  sUserItemName: string;
  sCheckItemName: string;
begin
  Result := False;

  if m_Master <> nil then begin
    TPlayObject(m_Master).ClearCopyItems();
  end;

  if g_Config.boInSafeDisableDrop and InSafeZone then begin
    SendMsg(g_ManageNPC, RM_MENU_OK, 0, Integer(Self), 0, 0, g_sCanotDropInSafeZoneMsg);
    Exit;
  end;

  {if not m_boCanDrop then begin
    SendMsg(g_ManageNPC, RM_MENU_OK, 0, Integer(Self), 0, 0, g_sCanotDropItemMsg);
    Exit;
  end;}

  if Pos(' ', sItemName) > 0 then begin //折分物品名称(信件物品的名称后面加了使用次数)
    GetValidStr3(sItemName, sItemName, [' ']);
  end;

  for I := m_ItemList.Count - 1 downto 0 do begin
    if m_ItemList.Count <= 0 then Break;
    UserItem := m_ItemList.Items[I];
    if (UserItem <> nil) and (UserItem.MakeIndex = nItemIdx) then begin

      if (UserItem.AddValue[0] = 1) and (GetDayCount(UserItem.MaxDate, Now) <= 0) then begin //删除到期装备
        m_ItemList.Delete(I);
        Dispose(UserItem);
        Result := True;
        Break;
      end;

      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem = nil then Continue;
        //sItem:=UserEngine.GetStdItemName(UserItem.wIndex);
        //取自定义物品名称
      sUserItemName := '';
      if UserItem.btValue[13] = 1 then
        sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
      if sUserItemName = '' then
        sUserItemName := UserEngine.GetStdItemName(UserItem.wIndex);

      if TPlayObject(m_Master).CheckItemBindUse(UserItem, False) = 2 then begin //绑定物品
        sUserItemName := '(绑)' + sUserItemName;
      end;

      if CompareText(sUserItemName, sItemName) = 0 then begin

        if g_Config.boBindItemNoDrop and (m_Master <> nil) and (TPlayObject(m_Master).CheckItemBindUse(UserItem, True) = 2) then Break; //绑定物品禁止扔

        if Assigned(PlugInEngine.CheckCanDropItem) then begin
          sCheckItemName := StdItem.Name;
          if not PlugInEngine.CheckCanDropItem(Self, PChar(sCheckItemName), True) then Break;
        end;
        if g_Config.boControlDropItem and (StdItem.Price < g_Config.nCanDropPrice) then begin
          m_ItemList.Delete(I);
          Dispose(UserItem);
          Result := True;
          Break;
        end;
        if DropItemDown(UserItem, 1, False, nil, m_Master) then begin
          m_ItemList.Delete(I);
          Dispose(UserItem);
          Result := True;
          Break;
        end;
      end;
    end;
  end;
  if Result then WeightChanged();
end;

procedure THeroObject.RepairAllItem();
var
  nWhere: Integer;
  sCheckItemName: string;
  StdItem: pTStdItem;
begin
  for nWhere := Low(THumanUseItems) to High(THumanUseItems) do begin
    if m_UseItems[nWhere].wIndex > 0 then begin
      StdItem := UserEngine.GetStdItem(m_UseItems[nWhere].wIndex);
      if StdItem <> nil then begin
        if (m_UseItems[nWhere].DuraMax > m_UseItems[nWhere].Dura) and (StdItem.StdMode <> 43) then begin
          if Assigned(PlugInEngine.CheckCanRepairItem) then begin
            sCheckItemName := StdItem.Name;
            if not PlugInEngine.CheckCanRepairItem(m_Master, PChar(sCheckItemName), False) then Continue;
          end;
          m_UseItems[nWhere].Dura := m_UseItems[nWhere].DuraMax;
          SendMsg(Self, RM_DURACHANGE, nWhere, m_UseItems[nWhere].Dura, m_UseItems[nWhere].DuraMax, 0, '');
        end;
      end;
    end;
  end;
end;

procedure THeroObject.ClientUseItems(nItemIdx: Integer; sItemName: string); //英雄吃药
  function GetUnbindItemName(nShape: Integer): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to g_UnbindList.Count - 1 do begin
      if Integer(g_UnbindList.Objects[I]) = nShape then begin
        Result := g_UnbindList.Strings[I];
        Break;
      end;
    end;
  end;
  function GetUnBindItems(sItemName: string; nCount: Integer): Boolean;
  var
    I: Integer;
    UserItem: pTUserItem;
  begin
    Result := False;
    for I := 0 to nCount - 1 do begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
        m_ItemList.Add(UserItem);
        SendAddItem(UserItem);
        Result := True;
      end else begin
        Dispose(UserItem);
        Break;
      end;
    end;
  end;
  function FoundUserItem(Item: pTUserItem): Boolean;
  var
    I: Integer;
    UserItem: pTUserItem;
  begin
    Result := False;
    for I := 0 to m_ItemList.Count - 1 do begin
      UserItem := m_ItemList.Items[I];
      if UserItem = Item then begin
        Result := True;
        Break;
      end;
    end;
  end;
var
  I: Integer;
  boEatOK: Boolean;
  boSendUpDate: Boolean;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  UserItem34: TUserItem;
  sMapName: string;
  nCurrX, nCurrY: Integer;
begin
  boEatOK := False;
  boSendUpDate := False;
  StdItem := nil;
  //if m_boCanUseItem then begin
  if (not m_boDeath) and (not m_boGhost) and (m_WAbil.HP > 0) and ((GetTickCount - m_dwCanUseItemTick > g_Config.nUseItemSpeed) or (g_Config.nUseItemSpeed <= 0)) then begin //2008-05-16增加物品使用间隔
    for I := m_ItemList.Count - 1 downto 0 do begin
      if m_ItemList.Count <= 0 then Break;
      UserItem := m_ItemList.Items[I];
      if (UserItem <> nil) and (UserItem.MakeIndex = nItemIdx) then begin
        UserItem34 := UserItem^;
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if StdItem <> nil then begin
          if not m_PEnvir.AllowStdItems(UserItem.wIndex) then begin
            SysMsg(Format(g_sCanotMapUseItemMsg, [StdItem.Name]), c_Red, t_Hint);
            Break;
          end;
          case StdItem.StdMode of
            0, 1, 3: begin //药
                if EatItems(StdItem) then begin
                  m_ItemList.Delete(I);
                  Dispose(UserItem);
                  UserItem := nil;
                  boEatOK := True;
                end;
                Break;
              end;
            2: begin //修复神水
                case StdItem.Shape of
                  1: begin
                      if UserItem.Dura > 0 then begin
                        if UserItem.Dura >= 100 then begin
                          Dec(UserItem.Dura, 100);
                        end else begin
                          UserItem.Dura := 0;
                        end;
                        RepairAllItem();
                        boEatOK := True;
                      end;
                      if UserItem.Dura > 0 then begin
                        boSendUpDate := True;
                        boEatOK := False;
                      end;
                    end;
                end;
              end;
            4: begin //书
                if ReadBook(StdItem) then begin
                  m_ItemList.Delete(I);
                  Dispose(UserItem);
                  UserItem := nil;
                  boEatOK := True;
                  if (m_MagicErgumSkill <> nil) and (not m_boUseThrusting) then begin
                    ThrustingOnOff(True);
                      //SendSocket(nil, '+LNG');
                  end;
                  if (m_MagicBanwolSkill <> nil) and (not m_boUseHalfMoon) then begin
                    HalfMoonOnOff(True);
                      //SendSocket(nil, '+WID');
                  end;
                end;
              end;
            31: begin //解包物品
                if StdItem.AniCount = 0 then begin
                  if (m_ItemList.Count + 6 - 1) <= m_nItemBagCount then begin
                    m_ItemList.Delete(I);
                    Dispose(UserItem);
                    UserItem := nil;
                    GetUnBindItems(GetUnbindItemName(StdItem.Shape), 6);
                    boEatOK := True;
                  end;
                end;
              end;
          end;
          Break;
        end;
      end;
    end;
  end;
  {end else begin
    m_Master.SendMsg(g_ManageNPC, RM_MENU_OK, 0, Integer(m_Master), 0, 0, g_sCanotUseItemMsg);
  end;}
  if boEatOK then begin
    WeightChanged();
    SendDefMessage(SM_HEROEAT_OK, 0, 0, 0, 0, '');
    if StdItem.NeedIdentify = 1 then
      AddGameDataLog('11' + #9 +
        m_sMapName + #9 +
        IntToStr(m_nCurrX) + #9 +
        IntToStr(m_nCurrY) + #9 +
        m_sCharName + #9 +
        //UserEngine.GetStdItemName(UserItem34.wIndex) + #9 +
        StdItem.Name + #9 +
        IntToStr(UserItem34.MakeIndex) + #9 +
        '1' + #9 +
        '0');
  end else begin
    SendDefMessage(SM_HEROEAT_FAIL, 0, 0, 0, 0, '');
  end;
  if (UserItem <> nil) and boSendUpDate then begin
    SendUpdateItem(UserItem);
  end;
end;

procedure THeroObject.WeightChanged;
begin
  if m_Master = nil then Exit;
  m_WAbil.Weight := RecalcBagWeight();
  SendUpdateMsg(m_Master, RM_WEIGHTCHANGED, 0, 0, 0, 0, '');
end;

procedure THeroObject.RefMyStatus();
begin
  RecalcAbilitys();
  m_Master.SendMsg(m_Master, RM_MYSTATUS, 0, 1, 0, 0, '');
end;

function THeroObject.EatItems(StdItem: pTStdItem): Boolean;
var
  bo06: Boolean;
  nOldStatus: Integer;
begin
  Result := False;
  if m_PEnvir.m_boNODRUG then begin
    SysMsg(sCanotUseDrugOnThisMap, c_Red, t_Hint);
    Exit;
  end;
  case StdItem.StdMode of
    0: begin
        case StdItem.Shape of
          1: begin
              IncHealthSpell(StdItem.AC, StdItem.MAC);
              Result := True;
            end;
          2: begin
              m_boUserUnLockDurg := True;
              Result := True;
            end;
        else begin
            if (StdItem.AC > 0) then begin
              Inc(m_nIncHealth, StdItem.AC);
            end;
            if (StdItem.MAC > 0) then begin
              Inc(m_nIncSpell, StdItem.MAC);
            end;
            Result := True;
          end;
        end;
      end;
    1: Result := False;
    {1: begin
        nOldStatus := GetMyStatus();
        Inc(m_nHungerStatus, StdItem.DuraMax div 10);
        m_nHungerStatus := _MIN(5000, m_nHungerStatus);
        if nOldStatus <> GetMyStatus() then
          RefMyStatus();
        Result := True;
      end;}
    3: begin
        if StdItem.Shape = 12 then begin
          bo06 := False;
          if LoWord(StdItem.DC) > 0 then begin
            m_wStatusArrValue[0 {0x218}] := LoWord(StdItem.DC);
            m_dwStatusArrTimeOutTick[0 {0x220}] := GetTickCount + HiWord(StdItem.MAC) * 1000;
            SysMsg('攻击力增加' + IntToStr(HiWord(StdItem.MAC)) + '秒', c_Green, t_Hint);
            bo06 := True;
          end;
          if LoWord(StdItem.MC) > 0 then begin
            m_wStatusArrValue[1 {0x219}] := LoWord(StdItem.MC);
            m_dwStatusArrTimeOutTick[1 {0x224}] := GetTickCount + HiWord(StdItem.MAC) * 1000;
            SysMsg('魔法力增加' + IntToStr(HiWord(StdItem.MAC)) + '秒', c_Green, t_Hint);
            bo06 := True;
          end;
          if LoByte(StdItem.SC) > 0 then begin
            m_wStatusArrValue[2 {0x21A}] := LoWord(StdItem.SC);
            m_dwStatusArrTimeOutTick[2 {0x228}] := GetTickCount + HiWord(StdItem.MAC) * 1000;
            SysMsg('道术增加' + IntToStr(HiWord(StdItem.MAC)) + '秒', c_Green, t_Hint);
            bo06 := True;
          end;
          if HiWord(StdItem.AC) > 0 then begin
            m_wStatusArrValue[3 {0x21B}] := HiWord(StdItem.AC);
            m_dwStatusArrTimeOutTick[3 {0x22C}] := GetTickCount + HiWord(StdItem.MAC) * 1000;
            SysMsg('攻击速度增加' + IntToStr(HiWord(StdItem.MAC)) + '秒', c_Green, t_Hint);
            bo06 := True;
          end;
          if LoWord(StdItem.AC) > 0 then begin
            m_wStatusArrValue[4 {0x21C}] := LoWord(StdItem.AC);
            m_dwStatusArrTimeOutTick[4 {0x230}] := GetTickCount + HiWord(StdItem.MAC) * 1000;
            SysMsg('生命值增加' + IntToStr(HiWord(StdItem.MAC)) + '秒', c_Green, t_Hint);
            bo06 := True;
          end;
          if LoWord(StdItem.MAC) > 0 then begin
            m_wStatusArrValue[5 {0x21D}] := LoWord(StdItem.MAC);
            m_dwStatusArrTimeOutTick[5 {0x234}] := GetTickCount + HiWord(StdItem.MAC) * 1000;
            SysMsg('魔法值增加' + IntToStr(HiWord(StdItem.MAC)) + '秒', c_Green, t_Hint);
            bo06 := True;
          end;
          if bo06 then begin
            RecalcAbilitys();
            SendMsg(Self, RM_ABILITY, 0, 0, 0, 0, '');
            SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');
            Result := True;
          end;
        end else begin
          Result := EatUseItems(StdItem.Shape);
        end;
      end;
  end;
end;

function THeroObject.ReadBook(StdItem: pTStdItem): Boolean;
var
  Magic: pTMagic;
  UserMagic: pTUserMagic;
begin
  Result := False;
  Magic := UserEngine.FindHeroMagic(StdItem.Name);
  if Magic <> nil then begin
    if not IsTrainingSkill(Magic.wMagicId) then begin
      if Magic.wMagicId in [60..65] then begin
        if Magic.wMagicId <> GetGroupMagicId then Exit;
      end;
      if (Magic.btJob = 99) or (Magic.btJob = m_btJob) then begin
        if m_Abil.Level >= Magic.TrainLevel[0] then begin
          New(UserMagic);
          UserMagic.MagicInfo := Magic;
          UserMagic.wMagIdx := Magic.wMagicId;
          UserMagic.btKey := VK_F1;
          UserMagic.btLevel := 0;
          UserMagic.nTranPoint := 0;
          m_MagicList.Add(UserMagic);
          RecalcAbilitys();
          SendAddMagic(UserMagic);
          Result := True;
        end;
      end;
    end;
  end;
end;

procedure THeroObject.SendAddMagic(UserMagic: pTUserMagic);
var
  ClientMagic: TClientMagic;
begin
  ClientMagic.Key := Char(UserMagic.btKey);
  ClientMagic.Level := UserMagic.btLevel;
  ClientMagic.CurTrain := UserMagic.nTranPoint;
  ClientMagic.Def := UserMagic.MagicInfo^;
  m_DefMsg := MakeDefaultMsg(SM_HEROADDMAGIC, 0, 0, 0, 1);
  SendSocket(@m_DefMsg, EncodeBuffer(@ClientMagic, SizeOf(TClientMagic)));
end;

procedure THeroObject.SendDelMagic(UserMagic: pTUserMagic);
begin
  m_DefMsg := MakeDefaultMsg(SM_HERODELMAGIC, UserMagic.wMagIdx, 0, 0, 1);
  SendSocket(@m_DefMsg, '');
end;

function THeroObject.IsEnoughBag(): Boolean;
begin
  Result := False;
  if m_ItemList.Count < m_nItemBagCount then
    Result := True;
end;

procedure THeroObject.MakeWeaponUnlock;
begin
  if m_UseItems[U_WEAPON].wIndex <= 0 then Exit;
  if m_UseItems[U_WEAPON].btValue[3] > 0 then begin
    Dec(m_UseItems[U_WEAPON].btValue[3]);
    SysMsg(g_sTheWeaponIsCursed, c_Red, t_Hint);
  end else begin
    if m_UseItems[U_WEAPON].btValue[4] < 10 then begin
      Inc(m_UseItems[U_WEAPON].btValue[4]);
      SysMsg(g_sTheWeaponIsCursed, c_Red, t_Hint);
    end;
  end;
  RecalcAbilitys();
  SendMsg(Self, RM_ABILITY, 0, 0, 0, 0, '');
  SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');
end;

//使用祝福油

function THeroObject.WeaptonMakeLuck: Boolean;
var
  StdItem: pTStdItem;
  nRand: Integer;
  boMakeLuck: Boolean;
begin
  Result := False;
  if m_UseItems[U_WEAPON].wIndex <= 0 then Exit;
  nRand := 0;
  StdItem := UserEngine.GetStdItem(m_UseItems[U_WEAPON].wIndex);
  if StdItem <> nil then begin
    nRand := abs((HiWord(StdItem.DC) - LoWord(StdItem.DC))) div 5;
  end;
  if Random(g_Config.nWeaponMakeUnLuckRate {20}) = 1 then begin
    MakeWeaponUnlock();
  end else begin
    boMakeLuck := False;
    if m_UseItems[U_WEAPON].btValue[4] > 0 then begin
      Dec(m_UseItems[U_WEAPON].btValue[4]);
      SysMsg(g_sWeaptonMakeLuck {'武器被加幸运了...'}, c_Green, t_Hint);
      boMakeLuck := True;
    end else if m_UseItems[U_WEAPON].btValue[3] < g_Config.nWeaponMakeLuckPoint1 {1} then begin
      Inc(m_UseItems[U_WEAPON].btValue[3]);
      SysMsg(g_sWeaptonMakeLuck {'武器被加幸运了...'}, c_Green, t_Hint);
      boMakeLuck := True;
    end else if (m_UseItems[U_WEAPON].btValue[3] < g_Config.nWeaponMakeLuckPoint2 {3}) and (Random(nRand + g_Config.nWeaponMakeLuckPoint2Rate {6}) = 1) then begin
      Inc(m_UseItems[U_WEAPON].btValue[3]);
      SysMsg(g_sWeaptonMakeLuck {'武器被加幸运了...'}, c_Green, t_Hint);
      boMakeLuck := True;
    end else if (m_UseItems[U_WEAPON].btValue[3] < g_Config.nWeaponMakeLuckPoint3 {7}) and (Random(nRand * g_Config.nWeaponMakeLuckPoint3Rate {10 + 30}) = 1) then begin
      Inc(m_UseItems[U_WEAPON].btValue[3]);
      SysMsg(g_sWeaptonMakeLuck {'武器被加幸运了...'}, c_Green, t_Hint);
      boMakeLuck := True;
    end;

    RecalcAbilitys();
    SendMsg(Self, RM_ABILITY, 0, 0, 0, 0, '');
    SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');

    if not boMakeLuck then SysMsg(g_sWeaptonNotMakeLuck {'无效'}, c_Green, t_Hint);
  end;
  Result := True;
end;

function THeroObject.RepairWeapon: Boolean;
var
  nDura: Integer;
  UserItem: pTUserItem;
begin
  Result := False;
  UserItem := @m_UseItems[U_WEAPON];
  if (UserItem.wIndex <= 0) or (UserItem.DuraMax <= UserItem.Dura) then Exit;
  Dec(UserItem.DuraMax, (UserItem.DuraMax - UserItem.Dura) div g_Config.nRepairItemDecDura {30});
  nDura := _MIN(5000, UserItem.DuraMax - UserItem.Dura);
  if nDura > 0 then begin
    Inc(UserItem.Dura, nDura);
    SendMsg(m_Master, RM_DURACHANGE, 1, UserItem.Dura, UserItem.DuraMax, 0, '');
    SysMsg(g_sWeaponRepairSuccess {'武器修复成功...'}, c_Green, t_Hint);
    Result := True;
  end;
end;

function THeroObject.SuperRepairWeapon: Boolean;
begin
  Result := False;
  if m_UseItems[U_WEAPON].wIndex <= 0 then Exit;
  m_UseItems[U_WEAPON].Dura := m_UseItems[U_WEAPON].DuraMax;
  SendMsg(m_Master, RM_DURACHANGE, 1, m_UseItems[U_WEAPON].Dura, m_UseItems[U_WEAPON].DuraMax, 0, '');
  SysMsg(g_sWeaponRepairSuccess {'武器修复成功...'}, c_Green, t_Hint);
  Result := True;
end;

function THeroObject.AbilityUp(UserMagic: pTUserMagic): Boolean;
var
  nSpellPoint, n14: Integer;
begin
  Result := False;
  nSpellPoint := GetSpellPoint(UserMagic);
  if nSpellPoint > 0 then begin
    if m_WAbil.MP < nSpellPoint then Exit;
    n14 := (Random(10 + UserMagic.btLevel) + UserMagic.btLevel) * _MIN(UserMagic.btLevel, 1);
    m_dwStatusArrTimeOutTick[2 {0x228}] := GetTickCount + n14 * 1000;
    m_wStatusArrValue[2 {0x218}] := MakeLong(LoWord(m_WAbil.SC), HiWord(m_WAbil.SC) - 2 - (m_Abil.Level div 7)) * 2;
    SysMsg('道术增加' + IntToStr(m_wStatusArrValue[2 {0x218}]) + '点 ' + IntToStr(n14) + '秒', c_Green, t_Hint);
    RecalcAbilitys();
    SendMsg(Self, RM_ABILITY, 0, 0, 0, 0, '');
    SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');
    Result := True;
  end;
end;

procedure THeroObject.HasLevelUp(nLevel: Integer);
begin
  m_Abil.MaxExp := GetLevelExp(m_Abil.Level);
  RecalcLevelAbilitys();
  RecalcAbilitys();
  SendMsg(Self, RM_LEVELUP, 0, m_Abil.Exp, 0, 0, '');
  RefBagItemCount;
  if (g_FunctionNPC <> nil) and (m_Master <> nil) then begin
    TPlayObject(m_Master).m_nScriptGotoCount := 0;
    g_FunctionNPC.GotoLable(TPlayObject(m_Master), '@HeroLevelUp', False);
  end;
end;

procedure THeroObject.GainExp(dwExp: LongWord);
begin
  WinExp(dwExp);
end;

procedure THeroObject.WinExp(dwExp: LongWord);
begin
  if m_Abil.Level > g_Config.nLimitExpLevel then begin
    dwExp := g_Config.nLimitExpValue;
    GetExp(dwExp);
  end else
    if dwExp > 0 then begin
    dwExp := g_Config.dwKillMonExpMultiple * dwExp; //系统指定杀怪经验倍数
    dwExp := LongWord(m_nKillMonExpMultiple) * dwExp; //人物指定的杀怪经验倍数
    dwExp := Round((m_nKillMonExpRate / 100) * dwExp); //人物指定的杀怪经验倍数
    if m_PEnvir.m_boEXPRATE then
      dwExp := Round((m_PEnvir.m_nEXPRATE / 100) * dwExp); //地图上指定杀怪经验倍数
    if m_boExpItem then begin //物品经验倍数
      dwExp := Round(m_rExpItem * dwExp);
    end;
    if m_boExpGroupItem then begin //套装经验倍数
      dwExp := Round(m_rExpGroupItem * dwExp);
    end;
    GetExp(dwExp);
  end;
end;

procedure THeroObject.IncExp(dwExp: LongWord);
var
  dwAddExp: LongWord;
  lwExp: LongWord;
label RefExp;
begin
  lwExp := dwExp;

  RefExp:
  dwAddExp := m_Abil.MaxExp - m_Abil.Exp;
  if (lwExp >= dwAddExp) and (m_Abil.MaxExp > m_Abil.Exp) then begin
    if m_Abil.Level < g_Config.nMaxLevel then begin
      Inc(m_Abil.Level);
      lwExp := lwExp - dwAddExp;
      m_Abil.Exp := 0;

      //SendMsg(Self, RM_WINEXP, 0, dwAddExp, 0, 0, '');

      HasLevelUp(m_Abil.Level - 1);

      if not m_boAI then
        AddGameDataLog('12' + #9 +
          m_sMapName + #9 +
          IntToStr(m_Abil.Level) + #9 +
          IntToStr(m_Abil.Exp) + #9 +
          m_sCharName + #9 +
          '0' + #9 +
          '0' + #9 +
          '1' + #9 +
          '0');

      IncHealthSpell(2000, 2000);

      try
        if g_FunctionNPC <> nil then begin
          TPlayObject(m_Master).m_nScriptGotoCount := 0;
          g_FunctionNPC.GotoLable(TPlayObject(m_Master), '@HeroGetExp', False);
        end;
      except
        MainOutMessage('[Exception] THeroObject::IncExp GotoLable HeroGetExp');
      end;
      if lwExp > 0 then begin
        goto RefExp;
        Exit;
      end;
      //if dwExp > 0 then IncExp(dwExp);
    //end else begin
      //m_Abil.Exp := 0;
    end;
  end else begin
    if m_Abil.MaxExp > m_Abil.Exp then begin
      Inc(m_Abil.Exp, lwExp);

      //SendMsg(Self, RM_WINEXP, 0, dwExp, 0, 0, '');
      //AddBodyLuck(dwExp * 0.002);

      try
        if g_FunctionNPC <> nil then begin
          TPlayObject(m_Master).m_nScriptGotoCount := 0;
          g_FunctionNPC.GotoLable(TPlayObject(m_Master), '@HeroGetExp', False);
        end;
      except
        MainOutMessage('[Exception] THeroObject::GetExp GotoLable HeroGetExp');
      end;

    end else begin
      Inc(m_Abil.Level);
      Dec(m_Abil.Exp, m_Abil.MaxExp);

      HasLevelUp(m_Abil.Level - 1);

      if not m_boAI then
        AddGameDataLog('12' + #9 +
          m_sMapName + #9 +
          IntToStr(m_Abil.Level) + #9 +
          IntToStr(m_Abil.Exp) + #9 +
          m_sCharName + #9 +
          '0' + #9 +
          '0' + #9 +
          '1' + #9 +
          '0');

      IncHealthSpell(2000, 2000);
      goto RefExp;
      Exit;
      //IncExp(dwExp);
    end;
  end;
  SendMsg(Self, RM_WINEXP, 0, dwExp, 0, 0, '');
end;
{var
  nExp: Int64;
  dwAddExp: LongWord;
begin
  //inherited IncExp(dwExp);
  nExp := dwExp;
  while nExp > 0 do begin //2008-08-23增加递归调用

    if m_Abil.Level >= g_Config.nMaxLevel then begin
      nExp := 0;
      m_Abil.Exp := 0;
      break;
    end;

    if m_Abil.Exp + dwExp > High(LongWord) then begin
      dwAddExp := High(LongWord) - m_Abil.Exp;
      Inc(m_Abil.Exp, dwAddExp);
      Dec(nExp, dwAddExp);
    end else begin
      dwAddExp := dwExp;
      Inc(m_Abil.Exp, dwAddExp);
      Dec(nExp, dwAddExp);
    end;

    SendMsg(m_Master, RM_WINEXP, 0, dwAddExp, 0, 0, '');

    while m_Abil.Exp >= m_Abil.MaxExp do begin //2008-08-23增加循环调用
      Dec(m_Abil.Exp, m_Abil.MaxExp);

      if m_Abil.Level < g_Config.nMaxLevel then begin
        Inc(m_Abil.Level);
      end else begin
        m_Abil.Exp := 0;
        break;
      end;

      HasLevelUp(m_Abil.Level - 1);
      AddGameDataLog('12' + #9 +
        m_sMapName + #9 +
        IntToStr(m_Abil.Level) + #9 +
        IntToStr(m_Abil.Exp) + #9 +
        m_sCharName + #9 +
        '0' + #9 +
        '0' + #9 +
        '1' + #9 +
        '0');
      IncHealthSpell(2000, 2000);
    end;
  end;
end;  }

{procedure TPlayObject.GetExp(dwExp: LongWord);
var
  nExp: Int64;
  dwAddExp: LongWord;
begin
  nExp := dwExp;
  while nExp > 0 do begin
    if m_Abil.Level >= g_Config.nMaxLevel then begin
      nExp := 0;
      m_Abil.Exp := 0;
      break;
    end;

    if m_Abil.Exp + dwExp > High(LongWord) then begin
      dwAddExp := High(LongWord) - m_Abil.Exp;
      Inc(m_Abil.Exp, dwAddExp);
      Dec(nExp, dwAddExp);
      //IncBeadExp(dwAddExp);
    end else begin
      dwAddExp := dwExp;
      Inc(m_Abil.Exp, dwAddExp);
      Dec(nExp, dwAddExp);
      //IncBeadExp(dwAddExp);
    end;

  //AddBodyLuck(dwExp * 0.002);
    if not TPlayObject(m_Master).m_boNotOnlineAddExp then //只发送给非离线挂机人物
      SendMsg(m_Master, RM_WINEXP, 0, dwAddExp, 0, 0, '');

    while m_Abil.Exp >= m_Abil.MaxExp do begin //2008-08-23增加循环调用
      Dec(m_Abil.Exp, m_Abil.MaxExp);

      if m_Abil.Level < g_Config.nMaxLevel then begin
        Inc(m_Abil.Level);
      end else begin
        m_Abil.Exp := 0;
        break;
      end;

      HasLevelUp(m_Abil.Level - 1);
      AddBodyLuck(100);
      AddGameDataLog('12' + #9 +
        m_sMapName + #9 +
        IntToStr(m_Abil.Level) + #9 +
        IntToStr(m_Abil.Exp) + #9 +
        m_sCharName + #9 +
        '0' + #9 +
        '0' + #9 +
        '1' + #9 +
        '0');
      IncHealthSpell(2000, 2000);
    end;
  end;
end; }

procedure THeroObject.GetExp(dwExp: LongWord);
var
  dwAddExp: LongWord;
  lwExp: LongWord;
label RefExp;
begin
  lwExp := dwExp;

  RefExp:
  dwAddExp := m_Abil.MaxExp - m_Abil.Exp;
  if (lwExp >= dwAddExp) and (m_Abil.MaxExp > m_Abil.Exp) then begin
    if m_Abil.Level < g_Config.nMaxLevel then begin
      Inc(m_Abil.Level);
      lwExp := lwExp - dwAddExp;
      m_Abil.Exp := 0;

      AddBodyLuck(dwAddExp * 0.002);

      //SendMsg(Self, RM_WINEXP, 0, dwAddExp, 0, 0, '');

      HasLevelUp(m_Abil.Level - 1);

      if not m_boAI then
        AddGameDataLog('12' + #9 +
          m_sMapName + #9 +
          IntToStr(m_Abil.Level) + #9 +
          IntToStr(m_Abil.Exp) + #9 +
          m_sCharName + #9 +
          '0' + #9 +
          '0' + #9 +
          '1' + #9 +
          '0');

      IncHealthSpell(2000, 2000);

      try
        if g_FunctionNPC <> nil then begin
          TPlayObject(m_Master).m_nScriptGotoCount := 0;
          g_FunctionNPC.GotoLable(TPlayObject(m_Master), '@HeroGetExp', False);
        end;
      except
        MainOutMessage('[Exception] THeroObject::GetExp GotoLable HeroGetExp');
      end;

      if lwExp > 0 then begin
        goto RefExp;
        Exit;
      end;

      //if dwExp > 0 then GetExp(dwExp);
    //end else begin
      //m_Abil.Exp := 0;
    end;
  end else begin
    if m_Abil.MaxExp > m_Abil.Exp then begin
      Inc(m_Abil.Exp, lwExp);

      //SendMsg(Self, RM_WINEXP, 0, dwExp, 0, 0, '');
      AddBodyLuck(lwExp * 0.002);

      try
        if g_FunctionNPC <> nil then begin
          TPlayObject(m_Master).m_nScriptGotoCount := 0;
          g_FunctionNPC.GotoLable(TPlayObject(m_Master), '@HeroGetExp', False);
        end;
      except
        MainOutMessage('[Exception] THeroObject::GetExp GotoLable HeroGetExp');
      end;

    end else begin
      Inc(m_Abil.Level);
      Dec(m_Abil.Exp, m_Abil.MaxExp);

      HasLevelUp(m_Abil.Level - 1);

      if not m_boAI then
        AddGameDataLog('12' + #9 +
          m_sMapName + #9 +
          IntToStr(m_Abil.Level) + #9 +
          IntToStr(m_Abil.Exp) + #9 +
          m_sCharName + #9 +
          '0' + #9 +
          '0' + #9 +
          '1' + #9 +
          '0');

      IncHealthSpell(2000, 2000);
      goto RefExp;
      Exit;
      //GetExp(dwExp);
    end;
  end;
  SendMsg(Self, RM_WINEXP, 0, dwExp, 0, 0, '');
   {

  end else begin
    Inc(m_Abil.Exp, dwExp);
    //IncBeadExp(dwExp);

    SendMsg(Self, RM_WINEXP, 0, dwExp, 0, 0, '');
    AddBodyLuck(dwExp * 0.002);
    try
      if g_FunctionNPC <> nil then begin
        TPlayObject(m_Master).m_nScriptGotoCount := 0;
        g_FunctionNPC.GotoLable(TPlayObject(m_Master), '@HeroGetExp', False);
      end;
    except
      MainOutMessage('[Exception] THeroObject::GetExp GotoLable HeroGetExp');
    end;
  end;  }

 { nExp := dwExp;
  while nExp > 0 do begin

    if m_Abil.Level >= g_Config.nMaxLevel then begin
      nExp := 0;
      m_Abil.Exp := 0;
      break;
    end;

    if m_Abil.Exp + dwExp > High(LongWord) then begin
      dwAddExp := High(LongWord) - m_Abil.Exp;
      Inc(m_Abil.Exp, dwAddExp);
      Dec(nExp, dwAddExp);
      if g_FunctionNPC <> nil then begin
        TPlayObject(m_Master).m_nScriptGotoCount := 0;
        g_FunctionNPC.GotoLable(TPlayObject(m_Master), '@HeroGetExp', False);
      end;
    end else begin
      dwAddExp := dwExp;
      Inc(m_Abil.Exp, dwAddExp);
      Dec(nExp, dwAddExp);
      if g_FunctionNPC <> nil then begin
        TPlayObject(m_Master).m_nScriptGotoCount := 0;
        g_FunctionNPC.GotoLable(TPlayObject(m_Master), '@HeroGetExp', False);
      end;
    end;
  //AddBodyLuck(dwExp * 0.002);

    SendMsg(m_Master, RM_WINEXP, 0, dwAddExp, 0, 0, '');

    while m_Abil.Exp >= m_Abil.MaxExp do begin //2008-08-23增加循环调用
      Dec(m_Abil.Exp, m_Abil.MaxExp);

      if m_Abil.Level < g_Config.nMaxLevel then begin
        Inc(m_Abil.Level);
      end else begin
        m_Abil.Exp := 0;
        break;
      end;

      HasLevelUp(m_Abil.Level - 1);
      AddBodyLuck(100);
      AddGameDataLog('12' + #9 +
        m_sMapName + #9 +
        IntToStr(m_Abil.Level) + #9 +
        IntToStr(m_Abil.Exp) + #9 +
        m_sCharName + #9 +
        '0' + #9 +
        '0' + #9 +
        '1' + #9 +
        '0');
      IncHealthSpell(2000, 2000);
    end;}
   {
    while m_Abil.Exp >= m_Abil.MaxExp do begin //2008-08-23增加循环调用
      Dec(m_Abil.Exp, m_Abil.MaxExp);

      if m_Abil.Level < g_Config.nMaxLevel then begin
        Inc(m_Abil.Level);
      end else begin
        m_Abil.Exp := 0;
        break;
      end;

      HasLevelUp(m_Abil.Level - 1);
    //AddBodyLuck(100);
      AddGameDataLog('12' + #9 +
        m_sMapName + #9 +
        IntToStr(m_Abil.Level) + #9 +
        IntToStr(m_Abil.Exp) + #9 +
        m_sCharName + #9 +
        '0' + #9 +
        '0' + #9 +
        '1' + #9 +
        '0');
      IncHealthSpell(2000, 2000);
    end; }
end;

function THeroObject.CheckActionStatus(wIdent: Word; var dwDelayTime: LongWord): Boolean;
begin
  Result := True;
end;

//function THeroObject.AllowUseMagic(wMagIdx: Word): Boolean;
{begin
  Result := False;
  if inherited AllowUseMagic(wMagIdx) then begin
    Result := True;
  end;
end; }

function THeroObject.FollowMaster: Boolean;
var
  I, II, III, nX, nY, nX1, nY1, nCurrX, nCurrY: Integer;
  btDir: Byte;
  boNeed: Boolean;
begin
  Result := False;
  boNeed := False;
  if ((m_btStatus <> 2) or (m_btHeroGroup > 0)) and m_boProtectStatus and
    ((abs(m_nCurrX - m_nProtectTargetX) > 20 {g_Config.nGuardRange}) or (abs(m_nCurrY - m_nProtectTargetY) > 20 {g_Config.nGuardRange})) then begin

    boNeed := True;
  end;

  if ((m_btStatus <> 2) or (m_btHeroGroup > 0)) and (not m_boProtectStatus) and
    ((m_PEnvir <> m_Master.m_PEnvir) or
    (abs(m_nCurrX - m_Master.m_nCurrX) >= 20) or (abs(m_nCurrY - m_Master.m_nCurrY) >= 20)) then begin
    boNeed := True;
  end;

  if boNeed then begin
    if m_boProtectStatus then begin
      nX := m_nProtectTargetX;
      nY := m_nProtectTargetY;
    end else begin
      m_Master.GetBackPosition(nX, nY);
      if not m_Master.m_PEnvir.CanWalk(nX, nY, True) then begin
        for I := 0 to 7 do begin
          if m_Master.m_PEnvir.GetNextPosition(m_Master.m_nCurrX, m_Master.m_nCurrY, I, 1, nX, nY) then begin
            if m_Master.m_PEnvir.CanWalk(nX, nY, True) then begin
              break;
            end;
          end;
        end;
      end;
    end;

    DelTargetCreat;

    m_nTargetX := nX;
    m_nTargetY := nY;

    if not m_boProtectStatus then begin
      SpaceMove(m_Master.m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1);
    end else begin
      SpaceMove(m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1);
    end;
    m_nTargetX := -1;
    m_nTargetY := -1;
    Result := True;
    Exit;
  end;

  if m_boProtectStatus then begin
    nCurrX := m_nProtectTargetX;
    nCurrY := m_nProtectTargetY;
  end else begin
    m_Master.GetBackPosition(nCurrX, nCurrY);
    //nCurrX := m_Master.m_nCurrX;
    //nCurrY := m_Master.m_nCurrY;
  end;

  if (m_TargetCret = nil) and (m_btStatus <> 2) and (m_btHeroGroup <= 0) then begin
    //if (abs(m_nCurrX - nCurrX) >= 1) or (abs(m_nCurrY - nCurrY) >= 1) then begin
    if StartPickUpItem(500) then begin //捡物
      //Result := inherited FollowMaster;
      Result := True;
      Exit;
    end;
    if not m_boProtectStatus then begin
      //MainOutMessage('THeroObject.FollowMaster');
      if not m_Master.InSafeZone then begin
        for I := 1 to 2 do begin //判断主人是否在英雄对面
          if m_Master.m_PEnvir.GetNextPosition(m_Master.m_nCurrX, m_Master.m_nCurrY, m_Master.m_btDirection, I, nX, nY) then begin
            if (m_nCurrX = nX) and (m_nCurrY = nY) then begin

              if m_Master.GetBackPosition(m_Master.m_btDirection, nX, nY) and
                GotoNext(nX, nY, True) then begin
                m_nTargetX := -1;
                m_nTargetY := -1;
                Result := True;
                Exit;
              end;

            //btDir := GetBackDir(m_Master.m_btDirection);
              for III := 1 to 2 do begin
                for II := 0 to 7 do begin
                  if II <> m_Master.m_btDirection then begin
                    if m_Master.m_PEnvir.GetNextPosition(m_Master.m_nCurrX, m_Master.m_nCurrY, II, III, nX, nY) and
                  //if m_Master.GetBackPosition(II, nX1, nY1) and
                    GotoNext(nX, nY, True) then begin
                      m_nTargetX := -1;
                      m_nTargetY := -1;
                      Result := True;
                      Exit;
                    end;
                  end;
                end;
              end;

              Break;
            end;
          end;
        end;

        if (abs(m_nCurrX - nCurrX) > 1) or (abs(m_nCurrY - nCurrY) > 1) then begin
          if GotoNextOne(nCurrX, nCurrY, True) then Exit;
          for III := 1 to 2 do begin
            for II := 0 to 7 do begin
              if II <> m_Master.m_btDirection then begin
                if m_Master.m_PEnvir.GetNextPosition(m_Master.m_nCurrX, m_Master.m_nCurrY, II, III, nX, nY) and
                  //if m_Master.GetBackPosition(II, nX1, nY1) and
                GotoNextOne(nX, nY, True) then begin
                  Result := True;
                  Exit;
                end;
              end;
            end;
          end;
        end;
      end else begin //判断主人是否在安全区
        //MainOutMessage('m_Master.InSafeZone');
        for I := 1 to 2 do begin //判断主人是否在英雄对面
          if m_Master.m_PEnvir.GetNextPosition(m_Master.m_nCurrX, m_Master.m_nCurrY, m_Master.m_btDirection, I, nX, nY) then begin
            if (m_nCurrX = nX) and (m_nCurrY = nY) then begin

              if m_Master.GetBackPosition(m_Master.m_btDirection, nX, nY) and m_Master.InSafeZone(m_Master.m_PEnvir, nX, nY) and
                GotoNext(nX, nY, True) then begin
                //MainOutMessage('m_Master.InSafeZone1');
                m_nTargetX := -1;
                m_nTargetY := -1;
                Result := True;
                Exit;
              end;

            //btDir := GetBackDir(m_Master.m_btDirection);
              for III := 1 to 2 do begin
                for II := 0 to 7 do begin
                  if II <> m_Master.m_btDirection then begin
                    if m_Master.m_PEnvir.GetNextPosition(m_Master.m_nCurrX, m_Master.m_nCurrY, II, III, nX, nY) and
                      m_Master.InSafeZone(m_Master.m_PEnvir, nX, nY) and
                  //if m_Master.GetBackPosition(II, nX1, nY1) and
                    GotoNext(nX, nY, True) then begin
                      m_nTargetX := -1;
                      m_nTargetY := -1;
                      Result := True;
                      Exit;
                    end;
                  end;
                end;
              end;

              Break;
            end;
          end;
        end;

        if (abs(m_nCurrX - nCurrX) > 1) or (abs(m_nCurrY - nCurrY) > 1) or (not InSafeZone) then begin
          if m_Master.InSafeZone(m_Master.m_PEnvir, nCurrX, nCurrY) and GotoNextOne(nCurrX, nCurrY, True) then Exit;
          for III := 1 to 2 do begin
            for II := 0 to 7 do begin
              if II <> m_Master.m_btDirection then begin
                if m_Master.m_PEnvir.GetNextPosition(m_Master.m_nCurrX, m_Master.m_nCurrY, II, III, nX, nY) and
                  m_Master.InSafeZone(m_Master.m_PEnvir, nX, nY) and
                  //if m_Master.GetBackPosition(II, nX1, nY1) and
                GotoNextOne(nX, nY, True) then begin
                  Result := True;
                  Exit;
                end;
              end;
            end;
          end;
        end;
      end;
    end else begin
      if GotoNextOne(nCurrX, nCurrY, True) then Exit;
      for III := 1 to 2 do begin
        for II := 0 to 7 do begin
          if m_Master.m_PEnvir.GetNextPosition(nCurrX, nCurrY, II, III, nX, nY) and
                  //if m_Master.GetBackPosition(II, nX1, nY1) and
          GotoNextOne(nX, nY, True) then begin
            Result := True;
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

function THeroObject.SelectMagic(): Integer; //选择魔法
var
  nSelectMagic: Integer;
begin
  Result := 0;
  if m_boUseGroupSpell then begin
    nSelectMagic := GetGroupMagicId;
    if nSelectMagic > 0 then begin
      if AllowUseMagic(nSelectMagic) then begin
        Result := nSelectMagic;
        Exit;
      end;
    end;
    m_boUseGroupSpell := False;
  end;
  Result := inherited SelectMagic;
end;

function THeroObject.StartPickUpItem(nPickUpTime: Integer): Boolean;
  function PickUpItem(nX, nY: Integer; SelItemObject: TItemObject): Boolean;
  var
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    ItemObject: TItemObject;
    nDeleteCode: Integer;
  begin
    Result := False;
    ItemObject := m_PEnvir.GetItem(nX, nY, SelItemObject);
    if ItemObject = nil then Exit;
    //捡钱
    if (m_Master <> nil) and (not m_Master.m_boDeath) and (not m_Master.m_boGhost) and (m_Master.m_btRaceServer = RC_PLAYOBJECT) then begin
      if CompareText(ItemObject.m_sName, sSTRING_GOLDNAME) = 0 then begin
        if m_PEnvir.DeleteFromMap(nX, nY, ItemObject) = 1 then begin
          if TPlayObject(m_Master).IncGold(ItemObject.m_nCount) then begin
            ItemObject.MakeGhost;
            SendRefMsg(RM_ITEMHIDE, 0, Integer(ItemObject), nX, nY, '');
            TPlayObject(m_Master).GoldChanged;
            if g_boGameLogGold then
              AddGameDataLog('4' + #9 +
                m_sMapName + #9 +
                IntToStr(nX) + #9 +
                IntToStr(nY) + #9 +
                m_sCharName + #9 +
                sSTRING_GOLDNAME + #9 +
                IntToStr(ItemObject.m_nCount) + #9 +
                '1' + #9 +
                '0');
            Result := True;
          end else if m_PEnvir.AddToMap(nX, nY, ItemObject) <> ItemObject then ItemObject.MakeGhost;
        end;
        Exit;
      end;
    //捡物品

      if IsEnoughBag then begin
        if m_PEnvir.DeleteFromMap(nX, nY, ItemObject) = 1 then begin
          New(UserItem);
          UserItem^ := ItemObject.m_UserItem;
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if (StdItem <> nil) and IsAddWeightAvailable(UserEngine.GetStdItemWeight(UserItem.wIndex)) and AddItemToBag(UserItem) then begin
            ItemObject.MakeGhost;
            SendRefMsg(RM_ITEMHIDE, 0, Integer(ItemObject), nX, nY, '');
            SendAddItem(UserItem);
            m_WAbil.Weight := RecalcBagWeight();
            if not IsCheapStuff(StdItem.StdMode) then
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('4' + #9 +
                  m_sMapName + #9 +
                  IntToStr(nX) + #9 +
                  IntToStr(nY) + #9 +
                  m_sCharName + #9 +
                    //UserEngine.GetStdItemName(pu.wIndex) + #9 +
                  StdItem.Name + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  '1' + #9 +
                  '0');
            Result := True;
          end else begin
            if m_PEnvir.AddToMap(nX, nY, ItemObject) <> ItemObject then ItemObject.MakeGhost;
            Dispose(UserItem);
          end;
        end;
      end;
    end;
  end;

  function IsOfGroup(ActorObject: TActorObject): Boolean;
  var
    I: Integer;
    GroupMember: TActorObject;
  begin
    {Result := False;
    if m_Master.m_GroupOwner = nil then Exit;
    for I := 0 to m_Master.m_GroupOwner.m_GroupMembers.Count - 1 do begin
      GroupMember := TActorObject(m_Master.m_GroupOwner.m_GroupMembers.Objects[I]);
      if GroupMember = ActorObject then begin
        Result := True;
        Break;
      end;
    end;}
  end;

  function CanPickUp(ItemObject: TItemObject): Boolean;
  var
    I: Integer;
    nItemBind: Integer;
  begin
    Result := True;
    for I := 0 to m_NotCanPickItemList.Count - 1 do begin
      if m_NotCanPickItemList.Items[I] = ItemObject then begin
        Result := False;
        Exit;
      end;
    end;
    if g_Config.boBindItemNoPickUp then begin
      nItemBind := CheckItemBindUse(@ItemObject.m_UserItem, False);
      if (nItemBind > 0) and (nItemBind <> 2) then begin
        Result := False;
      end;
    end;
  end;

  function IsSlave(OfActorObject: TActorObject): Boolean;
  var
    I: Integer;
    ActorObject: TActorObject;
  begin
    Result := False;
    if OfActorObject = nil then begin
      Result := True;
      Exit;
    end;
    for I := 0 to m_SlaveList.Count - 1 do begin
      ActorObject := TActorObject(m_SlaveList.Items[I]);
      if ActorObject = OfActorObject then begin
        Result := True;
        Exit;
      end;
      if Result then Exit;
      Result := IsSlave(ActorObject);
      if Result then Exit;
    end;
  end;

  function FindPickItem(): TItemObject;
  var
    ItemList: TList;
    ItemObject: TItemObject;
    ItemObjectA: TItemObject;
    BaseObject: TBaseObject;
    I, nX, nY: Integer;

    n01, n02, nError: Integer;

    MapCellInfo: pTMapCellinfo;
    VisibleMapItem: pTVisibleMapItem;
    sItemName: string;
  begin
    //try
    nError := 0;
    Result := nil;
    nError := -1;
    if m_PEnvir = nil then Exit;
    nError := -2;
    ItemObjectA := nil;
    nError := -3;
    n01 := 9999;

    nError := -4;
    for I := 0 to m_VisibleItems.Count - 1 do begin
      VisibleMapItem := m_VisibleItems.Items[I];
      nError := 1;
      ItemObject := TItemObject(VisibleMapItem.BaseObject);
      nError := 2;
      if ItemObject <> nil then begin
        nError := 3;
        if (ItemObject.m_DropActorObject <> m_Master) and (CanPickUp(ItemObject)) then begin
          nError := 4;
          //sItemName := ItemObject.m_sName;
          //nError := 44;
          if IsAllowPickUpItem(ItemObject.m_sName) and IsAddWeightAvailable(UserEngine.GetStdItemWeight(ItemObject.m_UserItem.wIndex)) then begin
            nError := 5;
            if ((ItemObject.m_OfActorObject = nil) or (ItemObject.m_OfActorObject = m_Master) or (ItemObject.m_OfActorObject = Self) or IsSlave(TActorObject(ItemObject.m_OfActorObject))) then begin
              nError := 6;
              if (abs(VisibleMapItem.nX - m_nCurrX) <= 6) and (abs(VisibleMapItem.nY - m_nCurrY) <= 6) then begin
                nError := 7;
                if (ItemObject <> m_SelItemObject) then begin
                  nError := 8;
                  n02 := abs(VisibleMapItem.nX - m_nCurrX) + abs(VisibleMapItem.nY - m_nCurrY);
                  nError := 9;
                  if n02 < n01 then begin
                    n01 := n02;
                    ItemObjectA := ItemObject;
                  end;
                  nError := 10;
                end;
              end;
            end;
          end;

        end;
      end;
    end;

    Result := ItemObjectA;
    {except
      on E: Exception do begin
        MainOutMessage('FindPickItem:' + IntToStr(nError));
        MainOutMessage(E.Message);
      end;

    end;}
  end;

var
  ItemObject: TItemObject;
  nError: Integer;
resourcestring
  sExceptionMsg = '[Exception] THeroObject::PickUpItem %d';
begin
  try
    Result := False;
    nError := 0;
  //if GetTickCount() - m_dwPickUpItemTick < nPickUpTime then Exit;   m_btStatus
  //m_dwPickUpItemTick := GetTickCount();
    if (m_Master = nil) or (m_btStatus = 2) or m_boDeath or m_boGhost or (not IsEnoughBag) {or (not m_boCanPickUpItem)} or (m_btHeroGroup > 0) then Exit;
    if (m_Master <> nil) and (m_Master.m_boDeath or m_Master.m_boGhost) then Exit;
    if m_Master.InSafeZone or InSafeZone then Exit;

    if GetTickCount - TPlayObject(m_Master).m_dwPickUpTick < 1000 * 3 then Exit;

    nError := 1;
    if m_SelItemObject <> nil then begin
      if g_ItemManager.FindItem(m_PEnvir, m_nCurrX, m_nCurrY, m_SelItemObject) = m_SelItemObject then begin
        if PickUpItem(m_nCurrX, m_nCurrY, m_SelItemObject) then begin
          m_SelItemObject := nil;
          Result := True;
          Exit;
        end else begin
          m_NotCanPickItemList.Add(m_SelItemObject);
          m_SelItemObject := nil;
        end;
      end else m_SelItemObject := nil;
    end;

    nError := 4;
    ItemObject := FindPickItem();
    nError := 5;
    if ItemObject <> nil then begin
      m_SelItemObject := ItemObject;
      if (m_nCurrX <> ItemObject.m_nMapX) or (m_nCurrY <> ItemObject.m_nMapY) then begin
        nError := 6;
        if not GotoNextOne(ItemObject.m_nMapX, ItemObject.m_nMapY, True) then begin
          m_NotCanPickItemList.Add(m_SelItemObject);
          m_SelItemObject := nil;
        end;
        nError := 7;
      end;
      Result := True;
    end;
  except
    MainOutMessage(Format(sExceptionMsg, [nError]));
  end;
end;

function THeroObject.EatUseItems(nShape: Integer): Boolean;
begin
  Result := False;
  case nShape of
    4: begin
        if WeaptonMakeLuck() then Result := True;
      end;
    9: begin
        if RepairWeapon() then Result := True;
      end;
    10: begin
        if SuperRepairWeapon() then Result := True;
      end;
  end;
end;

function THeroObject.UseItem(nItemType, nIndex: Integer): Boolean; //自动换毒符
var
  UserItem: pTUserItem;
  AddUserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  if m_boAI then begin
    Result := inherited UseItem(nItemType, nIndex);
  end else begin
    Result := False;
    if (nIndex >= 0) and (nIndex < m_ItemList.Count) then begin
      UserItem := m_ItemList.Items[nIndex];
      if m_UseItems[U_ARMRINGL {U_BUJUK}].wIndex > 0 then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[U_ARMRINGL {U_BUJUK}].wIndex);
        if StdItem <> nil then begin
          if CheckItemType(nItemType, StdItem) then begin
            Result := True;
          end else begin
            m_ItemList.Delete(nIndex);
            New(AddUserItem);
            AddUserItem^ := m_UseItems[U_ARMRINGL {U_BUJUK}];
            if AddItemToBag(AddUserItem) then begin
              m_UseItems[U_ARMRINGL {U_BUJUK}] := UserItem^;
              SendChangeItems(U_ARMRINGL, UserItem);
              Dispose(UserItem);
              Result := True;
            end else begin
              Dispose(AddUserItem);
              m_ItemList.Add(UserItem);
            end;
          end;
        end else begin
          m_ItemList.Delete(nIndex);
          m_UseItems[U_ARMRINGL {U_BUJUK}] := UserItem^;
          SendChangeItems(U_ARMRINGL, UserItem);
          Dispose(UserItem);
          Result := True;
        end;
      end else begin
        m_ItemList.Delete(nIndex);
        m_UseItems[U_ARMRINGL {U_BUJUK}] := UserItem^;
        SendChangeItems(U_ARMRINGL, UserItem);
        Dispose(UserItem);
        Result := True;
      end;
    end;
  end;
end;

function THeroObject.WearFirDragon: Boolean;
var
  StdItem: pTStdItem;
begin
  Result := False;
  if m_UseItems[U_BUJUK].wIndex > 0 then begin
    StdItem := UserEngine.GetStdItem(m_UseItems[U_BUJUK].wIndex);
    if (StdItem <> nil) and (StdItem.StdMode = 25) and (StdItem.Shape = 9) then begin
      Result := True;
    end;
  end;
end;

procedure THeroObject.ClientRepairFirDragon(btType: Byte; nItemIdx: Integer; sItemName: string);
var
  I, n14: Integer;
  UserItem: pTUserItem;
  StdItem, StdItem20: pTStdItem;
  sUserItemName: string;
  boRepairOK: Boolean;
  ItemList: TList;
  OldDura: Word;
begin
  boRepairOK := False;
  ItemList := nil;
  StdItem := nil;
  UserItem := nil;
  n14 := -1;
  if (m_Master <> nil) and WearFirDragon and not m_boDeath then begin
    if m_UseItems[U_BUJUK].Dura < m_UseItems[U_BUJUK].DuraMax then begin
      OldDura := m_UseItems[U_BUJUK].Dura;
      case btType of
        2: ItemList := m_Master.m_ItemList;
        4: ItemList := m_ItemList;
      end;
      if ItemList <> nil then begin
        for I := 0 to ItemList.Count - 1 do begin
          UserItem := ItemList.Items[I];
          if (UserItem <> nil) and (UserItem.MakeIndex = nItemIdx) then begin
            //取自定义物品名称
            sUserItemName := '';
            if UserItem.btValue[13] = 1 then
              sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
            if sUserItemName = '' then
              sUserItemName := UserEngine.GetStdItemName(UserItem.wIndex);

            if TPlayObject(m_Master).CheckItemBindUse(UserItem, False) = 2 then begin //绑定物品
              sUserItemName := '(绑)' + sUserItemName;
            end;

            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if StdItem <> nil then begin
              if CompareText(sUserItemName, sItemName) = 0 then begin
                n14 := I;
                Break;
              end;
            end;
          end;
          UserItem := nil;
        end;

        if (StdItem <> nil) and (UserItem <> nil) and (StdItem.StdMode = 42) then begin
          Inc(m_UseItems[U_BUJUK].Dura, UserItem.DuraMax);
          boRepairOK := True;
          case btType of
            2: m_Master.DelBagItem(n14);
            4: DelBagItem(n14);
          end;
        end;
      end;
    end;
  end;

  if boRepairOK then begin
    if OldDura <> m_UseItems[U_BUJUK].Dura then
      SendMsg(Self, RM_DURACHANGE, U_BUJUK, m_UseItems[U_BUJUK].Dura, m_UseItems[U_BUJUK].DuraMax, 0, '');
    SendDefMessage(SM_REPAIRFIRDRAGON_OK, btType, 0, 0, 0, '');
  end else begin
    SendDefMessage(SM_REPAIRFIRDRAGON_FAIL, btType, 0, 0, 0, '');
  end;
end;

procedure THeroObject.SearchTarget();
  function MINXY(AObject, BObject: TActorObject): TActorObject;
  var
    nA, nB: Integer;
  begin
    nA := abs(m_nCurrX - AObject.m_nCurrX) + abs(m_nCurrY - AObject.m_nCurrY);
    nB := abs(m_nCurrX - BObject.m_nCurrX) + abs(m_nCurrY - BObject.m_nCurrY);
    if nA > nB then Result := BObject else Result := AObject;
  end;
//var
  //TargeTActorObject: TActorObject;
begin
  if ((m_TargetCret = nil) or (GetTickCount - m_dwSearchTargetTick > 500)) and
    (m_btStatus = 0) and
    (not m_boTarget) and
    (not InSafeZone) and
    (m_btHeroGroup = 0) then begin
    m_dwSearchTargetTick := GetTickCount();
    //TargeTActorObject := m_TargetCret;
    inherited;
    {if (TargeTActorObject <> nil) and (TargeTActorObject <> m_TargetCret) then begin
      if (TargeTActorObject.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER]) or ((TargeTActorObject.m_Master <> nil) and (TargeTActorObject.Master.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER])) then begin
        if (m_TargetCret <> nil) and ((m_TargetCret.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER]) or ((m_TargetCret.m_Master <> nil) and (m_TargetCret.Master.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER]))) then begin
          if ((MINXY(m_TargetCret, TargeTActorObject) = TargeTActorObject) or (Random(6) = 0)) and (GetTickCount() - m_dwTargetFocusTick > 1000 * 3) then SetTargetCreat(TargeTActorObject);
        end else begin
          SetTargetCreat(TargeTActorObject);
        end;

      end else begin
        if (m_TargetCret = nil) and IsProperTarget(TargeTActorObject) then SetTargetCreat(TargeTActorObject)
        else begin
          if ((m_TargetCret <> nil) and (MINXY(m_TargetCret, TargeTActorObject) = TargeTActorObject)) or (Random(6) = 0) then begin
            if (m_btJob > 0) or ((m_TargetCret <> nil) and (GetTickCount() - m_dwTargetFocusTick > 1000 * 3)) then
              if IsProperTarget(TargeTActorObject) then SetTargetCreat(TargeTActorObject);
          end;
        end;
      end;
    end;}
  end;
end;

procedure THeroObject.DelTargetCreat();
begin
  inherited;
  m_boUseGroupSpell := False;
end;

procedure THeroObject.Run;
var
  I, II, nSelectMagic, nRecog, nX, nY: Integer;
  boUseGroupSpell: Boolean;
  boRecalcAbilitys: Boolean;
  StdItem: pTStdItem;
  UserItem: pTUserItem;
begin
  if not m_boHeroLogOut and
    not m_boGhost and
    not m_boDeath and
    ((not m_boFixedHideMode) or (m_btHeroGroup > 0)) and
    not m_boStoneMode and
    (m_Master <> nil) and
    (m_wStatusTimeArr[POISON_STONE] = 0) then begin

    if (not m_boHeroLogOnOK) and (m_nHeroLogOnCount < 3) then begin
      if GetTickCount - m_dwHeroLogOnTick > 1000 * 5 then begin
        m_dwHeroLogOnTick := GetTickCount();
        //Self.m_PEnvir = m_Master.m_PEnvir
        //nRecog := GetFeatureToLong();
        //SendDefMessage(SM_FEATURECHANGED, Integer(Self), LoWord(nRecog), HiWord(nRecog), GetFeatureEx, '');
        SendMsg(Self, RM_ABILITY, 0, 0, 0, 0, '');
        SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');

        SendMsg(Self, RM_QUERYBAGITEMS, 0, 0, 0, 0, '');
        SendMsg(Self, RM_SENDUSEITEMS, 0, 0, 0, 0, '');
        SendMsg(Self, RM_SENDMYMAGIC, 0, 0, 0, 0, '');
        SendMsg(Self, RM_HEROLOGON_OK, 0, 0, 0, 0, '');

        {SendDelayMsg(Self, RM_QUERYBAGITEMS, 0, 0, 0, 0, '', 500);
        SendDelayMsg(Self, RM_SENDUSEITEMS, 0, 0, 0, 0, '', 1000);
        SendDelayMsg(Self, RM_SENDMYMAGIC, 0, 0, 0, 0, '', 1500);
        SendDelayMsg(Self, RM_HEROLOGON_OK, 0, 0, 0, 0, '', 2000);}
        Inc(m_nHeroLogOnCount);
        //MainOutMessage('not m_boHeroLogOnOK');
      end;
    end;

    if m_boFireHitSkill and ((GetTickCount - m_dwLatestFireHitTick) > 20 * 1000) then begin
      m_boFireHitSkill := False;
      SysMsg(sSpiritsGone, c_Red, t_Hint);
    end;

    if m_boCIDHitSkill and ((GetTickCount - m_dwLatestCIDHitTick) > 20 * 1000) then begin
      m_boCIDHitSkill := False;
      if not g_Config.boNoHintMagicClose then
        SysMsg(sCIDSpiritsGone, c_Red, t_Hint);
    end;
    if m_boKTZHitSkill and ((GetTickCount - m_dwLatestKTZHitTick) > 20 * 1000) then begin
      m_boKTZHitSkill := False;
      if not g_Config.boNoHintMagicClose then
        SysMsg(sKTZSpiritsGone, c_Red, t_Hint);
    end;
    if m_boZRJFHitSkill and ((GetTickCount - m_dwLatestZRJFHitTick) > 20 * 1000) then begin
      m_boZRJFHitSkill := False;
      if not g_Config.boNoHintMagicClose then
        SysMsg(sZRJFSpiritsFail, c_Red, t_Hint);
    end;

    if GetTickCount - m_dwRateTick > 1000 then begin
      m_dwRateTick := GetTickCount();
      if m_dwKillMonExpRateTime > 0 then begin
        Dec(m_dwKillMonExpRateTime);
        if m_dwKillMonExpRateTime = 0 then begin
          m_nKillMonExpRate := 100;
          SysMsg('经验倍数恢复正常...', c_Red, t_Hint);
        end;
      end;
      if m_dwPowerRateTime > 0 then begin
        Dec(m_dwPowerRateTime);
        if m_dwPowerRateTime = 0 then begin
          m_nPowerRate := 100;
          SysMsg('攻击力倍数恢复正常...', c_Red, t_Hint);
        end;
      end;
    end;

  //检查身上的装备有没不符合
    try
      boRecalcAbilitys := False;
      for I := Low(THumanUseItems) to High(THumanUseItems) do begin
        if m_UseItems[I].wIndex > 0 then begin
          StdItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);
          if StdItem <> nil then begin
            if (m_UseItems[I].AddValue[0] = 1) and (GetDayCount(m_UseItems[I].MaxDate, Now) <= 0) then begin //删除到期装备
              SendDelItems(@m_UseItems[I]);
              m_UseItems[I].wIndex := 0;
              boRecalcAbilitys := True;
            end;
          end else begin
            m_UseItems[I].wIndex := 0;
            boRecalcAbilitys := True;
          end;
        end;
      end;
      if boRecalcAbilitys then RecalcAbilitys();

    //删除包裹中到期装备
      for I := m_ItemList.Count - 1 downto 0 do begin
        UserItem := pTUserItem(m_ItemList.Items[I]);
        if (UserItem.wIndex > 0) and (UserItem.AddValue[0] = 1) and (GetDayCount(UserItem.MaxDate, Now) <= 0) then begin //删除到期装备
          m_ItemList.Delete(I);
          SendDelItems(UserItem);
          Dispose(UserItem);
        end;
      end;
    except
      //MainOutMessage(Format(sExceptionMsg, [2]));
    end;

    //if m_boHeroLogOnOK and (not m_boAI) then
      //StartEatItems; //吃药

    if m_btHeroGroup > 0 then begin //解除合体
      if GetTickCount - m_dwHeroGroupTick > m_dwHeroGroupTime then begin
        UnHeroGroup;
      end;
    end;

    if (not m_boUseGroupSpell) and m_boHeroLogOnOK and (m_btHeroGroup = 0) then begin
      if m_nAngryValue < g_Config.nMaxAngryValue then begin
        if GetTickCount() - m_dwAddFirDragonTick > 1000 {g_Config.nAddFirDragonTime} then begin
          m_dwAddFirDragonTick := GetTickCount();
          if WearFirDragon and (m_UseItems[U_BUJUK].Dura > 0) then begin
            if m_UseItems[U_BUJUK].Dura >= g_Config.nDecAngryValue then begin
              Dec(m_UseItems[U_BUJUK].Dura, g_Config.nDecAngryValue);
            end else begin
              m_UseItems[U_BUJUK].Dura := 0;
            end;
            Inc(m_nAngryValue, g_Config.nAddAngryValue);
            SendMsg(Self, RM_DURACHANGE, U_BUJUK, m_UseItems[U_BUJUK].Dura, m_UseItems[U_BUJUK].DuraMax, 0, '');
            SendMsg(Self, RM_HEROANGERVALUE, m_nAngryValue, 0, g_Config.nMaxAngryValue, 0, '');
            //SendMsg(Self, RM_DURACHANGE, U_BUJUK, m_UseItems[U_BUJUK].Dura, m_UseItems[U_BUJUK].DuraMax, 0, '');
            //SendMsg(Self, RM_FIRDRAGONPOINT, g_Config.nMaxFirDragonPoint, m_nFirDragonPoint, 0, 0, '');

            //MainOutMessage('Inc(m_nAngryValue, g_Config.nAddAngryValue);');
          end;
        end;
      end;
    end;

    if (m_TargetCret <> nil) and
      (m_TargetCret.m_boDeath or m_TargetCret.m_boGhost) then
      DelTargetCreat;

    if (m_TargetCret <> nil) then
      if ((m_TargetCret.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT]) or
        ((m_TargetCret.m_btRaceServer = RC_PLAYMOSTER) and (m_TargetCret.m_Master <> nil) and (Master.m_btRaceServer = RC_PLAYOBJECT))) and m_TargetCret.InSafeZone then
        DelTargetCreat;


    SearchTarget();

    if (m_btStatus = 2) or (m_btHeroGroup > 0) then
      DelTargetCreat();

    if m_boTarget and (m_TargetCret = nil) then
      DelTargetCreat();

    if m_boTarget and (m_TargetCret <> nil) and (m_TargetCret.m_PEnvir = m_PEnvir) and (m_btStatus = 0) and (m_btHeroGroup = 0) then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 6) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 6) then begin
        for I := 3 downto 1 do begin
          for II := 0 to 7 do begin
            if m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, II, I, nX, nY) and m_PEnvir.CanWalkEx(nX, nY, False) and m_PEnvir.CanWalkOfEvent(Self, nX, nY) then begin
              SpaceMove(m_PEnvir.sMapName, nX, nY, 1);
              m_nTargetX := -1;
              m_nTargetY := -1;
              inherited;
              Exit;
            end;
          end
        end;
        SpaceMove(m_PEnvir.sMapName, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 1);
        m_nTargetX := -1;
        m_nTargetY := -1;
        inherited;
        Exit;
      end;
    end;


    if (m_TargetCret <> nil) then
      nSelectMagic := SelectMagic;

    if (m_Master <> nil) and
      m_PEnvir.m_boDuel and
      (not TPlayObject(Master).m_boStartDuel) then
      DelTargetCreat; //非比赛人员禁止攻击  m_PEnvir.m_boDueling

    boUseGroupSpell := False;
    if (m_TargetCret <> nil) then begin
      if m_boUseGroupSpell then begin //合击
        {case nSelectMagic of
          60: begin
              if (abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 6) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 6)
                and (abs(m_Master.m_nCurrX - m_nCurrX) <= 6) and (abs(m_Master.m_nCurrY - m_nCurrY) <= 6)
                and (abs(m_Master.m_nCurrX - m_TargetCret.m_nCurrX) <= 6) and (abs(m_Master.m_nCurrY - m_TargetCret.m_nCurrY) <= 6) then begin
                boUseGroupSpell := True;
              end else m_boUseGroupSpell := False;
            end;
        else begin
            if (abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 12) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 12)
              and (abs(m_Master.m_nCurrX - m_nCurrX) <= 12) and (abs(m_Master.m_nCurrY - m_nCurrY) <= 12)
              and (abs(m_Master.m_nCurrX - m_TargetCret.m_nCurrX) <= 12) and (abs(m_Master.m_nCurrY - m_TargetCret.m_nCurrY) <= 12) then begin
              boUseGroupSpell := True;
            end else m_boUseGroupSpell := False;
          end;
        end;}

        if (abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 12) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 12)
          and (abs(m_Master.m_nCurrX - m_nCurrX) <= 12) and (abs(m_Master.m_nCurrY - m_nCurrY) <= 12)
          and (abs(m_Master.m_nCurrX - m_TargetCret.m_nCurrX) <= 12) and (abs(m_Master.m_nCurrY - m_TargetCret.m_nCurrY) <= 12) then begin
          boUseGroupSpell := True;
        end else m_boUseGroupSpell := False;

        if not m_boUseGroupSpell then begin
          nSelectMagic := SelectMagic;
        end;
      end;
    end;

    if (m_TargetCret <> nil) then begin
      if boUseGroupSpell then begin //合击
        if ActThink(nSelectMagic) then begin
          inherited;
          Exit;
        end;
        if (m_TargetCret <> nil) and StartAttack(nSelectMagic) then begin
          m_dwHitTick := GetTickCount();
          Dec(m_nAngryValue, g_Config.nMaxAngryValue);
          SendMsg(Self, RM_HEROANGERVALUE, m_nAngryValue, 0, g_Config.nMaxAngryValue, 0, '');
          if (nSelectMagic > 0) and (nSelectMagic <= High(m_SkillUseTick)) then begin
            m_SkillUseTick[nSelectMagic] := GetTickCount;
          end;
        end;
        m_boUseGroupSpell := False;
      end else begin
        case m_btJob of
          0: begin
              if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > g_Config.dwHeroWarrorAttackTime) then begin
                m_dwHitTick := GetTickCount();

                if ActThink(nSelectMagic) then begin
                  //inherited;
                  //Exit;
                end;

                if (m_TargetCret <> nil) and StartAttack(nSelectMagic) then begin
                  if (nSelectMagic > 0) and (nSelectMagic <= High(m_SkillUseTick)) then begin
                    m_SkillUseTick[nSelectMagic] := GetTickCount;
                  end;
                end;
              end;
            end;
          1: begin
              if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > g_Config.dwHeroWizardAttackTime) then begin
                m_dwHitTick := GetTickCount();
                if ActThink(nSelectMagic) then begin
                  //inherited;
                  //Exit;
                end;

                if (m_TargetCret <> nil) and StartAttack(nSelectMagic) then begin
                  if (nSelectMagic >= 0) and (nSelectMagic <= High(m_SkillUseTick)) then begin
                    m_SkillUseTick[nSelectMagic] := GetTickCount;
                  end;
                end;
              end;
            end;
          2: begin
              if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > g_Config.dwHeroTaoistAttackTime) then begin
                m_dwHitTick := GetTickCount();
                if ActThink(nSelectMagic) then begin
                  //inherited;
                  //Exit;
                end;

                if (m_TargetCret <> nil) and StartAttack(nSelectMagic) then begin
                  if (nSelectMagic >= 0) and (nSelectMagic <= High(m_SkillUseTick)) then begin
                    m_SkillUseTick[nSelectMagic] := GetTickCount;
                  end;
                end;
              end;
            end;
        end;
      end;
    end;
  end else begin
    if (not m_boGhost) and m_boDeath then begin
      if GetTickCount - m_dwDeathTick > 1000 * 30 then begin
        LogOut;
        LogOut;
      end;
    end;
  end;
  inherited;
end;

procedure THeroObject.GetAutoWalkXY(var nTargetX, nTargetY: Integer);
  function GetRandXY(var nX: Integer; var nY: Integer): Boolean;
  var
    n14, n18, n1C: Integer;
  begin
    Result := False;
    {Result := False;
    if m_PEnvir.m_nWidth < 80 then n18 := 3
    else n18 := 10;
    if m_PEnvir.m_nHeight < 150 then begin
      if m_PEnvir.m_nHeight < 50 then n1C := 2
      else n1C := 15;
    end else n1C := 50;
    n14 := 0;
    while (True) do begin
      if m_PEnvir.CanWalk(nX, nY, True) then begin
        Result := True;
        Break;
      end;
      if nX < (m_PEnvir.m_nWidth - n1C - 1) then Inc(nX, n18)
      else begin
        nX := Random(m_PEnvir.m_nWidth);
        if nY < (m_PEnvir.m_nHeight - n1C - 1) then Inc(nY, n18)
        else nY := Random(m_PEnvir.m_nHeight);
      end;
      Inc(n14);
      if n14 >= 201 then Break;
    end;}
    if m_PEnvir.CanWalk(nX, nY, True) and m_PEnvir.CanWalkOfEvent(Self, nX, nY) then begin
      Result := (nX <> m_nCurrX) or (nY <> m_nCurrY);
    end;
  end;
  function GetNextDir(btDir: Byte): Byte;
  begin
    //if btDir = DR_UP then Result := DR_UPLEFT else Result := btDir - 1;
    case btDir of
      DR_UP: Result := DR_UPRIGHT;
      DR_UPRIGHT: Result := DR_RIGHT;
      DR_RIGHT: Result := DR_DOWNRIGHT;
      DR_DOWNRIGHT: Result := DR_DOWN;
      DR_DOWN: Result := DR_DOWNLEFT;
      DR_DOWNLEFT: Result := DR_LEFT;
      DR_LEFT: Result := DR_UPLEFT;
      DR_UPLEFT: Result := DR_UP;
    end;
  end;
var
  nStep: Integer;
  boFind: Boolean;
  btDir: Byte;
  nCount: Integer;
begin
  boFind := False;
  nTargetX := m_nCurrX;
  nTargetY := m_nCurrY;
  {if m_nCurrX >= m_PEnvir.m_nWidth then nTargetX := m_nCurrX - 2;
  if m_nCurrX <= 0 then nTargetX := m_nCurrX + 2;
  if m_nCurrY >= m_PEnvir.m_nHeight then nTargetY := m_nCurrY - 2;
  if m_nCurrY <= 0 then nTargetY := m_nCurrY + 2;
  if (nTargetX <> m_nCurrX) or (nTargetY <> m_nCurrY) then begin
    boFind := GetRandXY(m_PEnvir, nTargetX, nTargetY);
  end else begin
    for nStep := 2 downto 1 do begin
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, nStep, nTargetX, nTargetY) then begin
        if GetRandXY(m_PEnvir, nTargetX, nTargetY) then begin
          boFind := True;
          Break;
        end;
      end;
    end;
  end;}
  for nStep := 2 downto 1 do begin
    if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, nStep, nTargetX, nTargetY) then begin
      if GetRandXY(nTargetX, nTargetY) then begin
        boFind := True;
        //m_btLastDir := m_btDirection;
        Break;
      end;
    end;
  end;
 { if not boFind then begin
    if m_btLastDir <> m_btDirection then begin
      for nStep := 2 downto 1 do begin
        if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, nStep, nTargetX, nTargetY) then begin
          if GetRandXY(nTargetX, nTargetY) then begin
            boFind := True;
            m_btLastDir := m_btDirection;
            Break;
          end;
        end;
      end;
    end;
  end; }
  if not boFind then begin
    nCount := 0;
    btDir := m_btDirection;
    while True do begin
      Inc(nCount);
      btDir := GetNextDir(btDir);
      for nStep := 2 downto 1 do begin
        if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, btDir, nStep, nTargetX, nTargetY) then begin
          if GetRandXY(nTargetX, nTargetY) then begin
            boFind := True;
            Break;
          end;
        end;
      end;
      if boFind or (nCount >= 8) then Break;
    end;
  end;
end;

procedure THeroObject.RestHero();
begin
  if (m_btHeroGroup <= 0) then begin
    if m_btStatus >= 2 then m_btStatus := 0
    else Inc(m_btStatus);
  end else m_btStatus := 2;

  m_boSlaveRelax := m_btStatus = 2;

  case m_btStatus of
    0: begin
        SysMsg('状态：攻击', c_Green, t_Hint);
      end;
    1: begin
        SysMsg('状态：跟随', c_Green, t_Hint);
      end;
    2: begin
        SysMsg('状态：休息', c_Green, t_Hint);
      end;
  end;
end;

procedure THeroObject.RecalcLevelAbilitys();
var
  nLevel, n: Integer;
begin
  nLevel := m_Abil.Level;
  case m_btJob of
    2: begin

        //m_Abil.MaxHP:=_MIN(High(Word),14 + ROUND((nLevel / 6 + 2.5) * nLevel));
        m_Abil.MaxHP := MinLong(g_Config.nMaxLevel, 14 + Round(((nLevel / g_Config.nHeroLevelValueOfTaosHP + g_Config.nHeroLevelValueOfTaosHPRate) * nLevel)));

        //m_Abil.MaxMP:=_MIN(High(Word),13 + ROUND((nLevel / 8)* 2.2 * nLevel));
        m_Abil.MaxMP := MinLong(g_Config.nMaxLevel, 13 + Round(((nLevel / g_Config.nHeroLevelValueOfTaosMP) * 2.2 * nLevel)));

        m_Abil.MaxWeight := 50 + Round((nLevel / 4) * nLevel);
        m_Abil.MaxWearWeight := 15 + Round((nLevel / 50) * nLevel);
        m_Abil.MaxHandWeight := 12 + Round((nLevel / 42) * nLevel);

        n := nLevel div 7;
        m_Abil.DC := MakeLong(_MAX(n - 1, 0), _MAX(1, n));
        m_Abil.MC := 0;
        m_Abil.SC := MakeLong(_MAX(n - 1, 0), _MAX(1, n));
        m_Abil.AC := 0;

        n := Round(nLevel / 6);
        m_Abil.MAC := MakeLong(n div 2, n + 1);
      end;
    1: begin

        //m_Abil.MaxHP:=_MIN(High(Word),14 + ROUND((nLevel / 15 + 1.8) * nLevel));
        m_Abil.MaxHP := MinLong(g_Config.nMaxLevel, 14 + Round(((nLevel / g_Config.nHeroLevelValueOfWizardHP + g_Config.nHeroLevelValueOfWizardHPRate) * nLevel)));

        m_Abil.MaxMP := MinLong(g_Config.nMaxLevel, 13 + Round((nLevel / 5 + 2) * 2.2 * nLevel));

        m_Abil.MaxWeight := 50 + Round((nLevel / 5) * nLevel);
        m_Abil.MaxWearWeight := 15 + Round((nLevel / 100) * nLevel);
        m_Abil.MaxHandWeight := 12 + Round((nLevel / 90) * nLevel);

        n := nLevel div 7;
        m_Abil.DC := MakeLong(_MAX(n - 1, 0), _MAX(1, n));
        m_Abil.MC := MakeLong(_MAX(n - 1, 0), _MAX(1, n));
        m_Abil.SC := 0;
        m_Abil.AC := 0;
        m_Abil.MAC := 0;
      end;
    0: begin

        //m_Abil.MaxHP:=_MIN(High(Word),14 + ROUND((nLevel / 4.0 + 4.5 + nLevel / 20) * nLevel));
        m_Abil.MaxHP := MinLong(g_Config.nMaxLevel, 14 + Round(((nLevel / g_Config.nHeroLevelValueOfWarrHP + g_Config.nHeroLevelValueOfWarrHPRate + nLevel / 20) * nLevel)));
        m_Abil.MaxMP := MinLong(g_Config.nMaxLevel, 11 + Round(nLevel * 3.5));

        m_Abil.MaxWeight := 50 + Round((nLevel / 3) * nLevel);
        m_Abil.MaxWearWeight := 15 + Round((nLevel / 20) * nLevel);
        m_Abil.MaxHandWeight := 12 + Round((nLevel / 13) * nLevel);

        m_Abil.DC := MakeLong(_MAX((nLevel div 5) - 1, 1), _MAX(1, (nLevel div 5)));
        m_Abil.SC := 0;
        m_Abil.MC := 0;
        m_Abil.AC := MakeLong(0, (nLevel div 7));
        m_Abil.MAC := 0;
      end;
  end;
  if m_Abil.HP > m_Abil.MaxHP then m_Abil.HP := m_Abil.MaxHP;
  if m_Abil.MP > m_Abil.MaxMP then m_Abil.MP := m_Abil.MaxMP;
end;

procedure THeroObject.RecalcAbilitys;
begin
  inherited;
  SendUpdateMsg(Self, RM_CHARSTATUSCHANGED, m_nHitSpeed, m_nCharStatus, 0, 0, '');
end;

function THeroObject.CheckTakeOnItems(nWhere: Integer; var StdItem: TStdItem): Boolean;
  function GetUserItemWeitht(nWhere: Integer): Integer;
  var
    I: Integer;
    n14: Integer;
    StdItem: pTStdItem;
  begin
    n14 := 0;
    for I := Low(THumanUseItems) to High(THumanUseItems) do begin
      if (nWhere = -1) or (not (I = nWhere) and not (I = 1) and not (I = 2)) then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);
        if StdItem <> nil then Inc(n14, StdItem.Weight);
      end;
    end;
    Result := n14;
  end;
var
  Castle: TUserCastle;
begin
  Result := False;
  if (StdItem.StdMode = 10) and (m_btGender <> 0) then begin
    SysMsg(sWearNotOfWoMan, c_Red, t_Hint);
    Exit;
  end;
  if (StdItem.StdMode = 11) and (m_btGender <> 1) then begin
    SysMsg(sWearNotOfMan, c_Red, t_Hint);
    Exit;
  end;
  if (nWhere = 1) or (nWhere = 2) then begin
    if StdItem.Weight > m_WAbil.MaxHandWeight then begin
      SysMsg(sHandWeightNot, c_Red, t_Hint);
      Exit;
    end;
  end else begin
    if (StdItem.Weight + GetUserItemWeitht(nWhere)) > m_WAbil.MaxWearWeight then begin
      SysMsg(sWearWeightNot, c_Red, t_Hint);
      Exit;
    end;
  end;
  Castle := g_CastleManager.IsCastleMember(Self);
  case StdItem.Need of //
    0: begin
        if m_Abil.Level >= StdItem.NeedLevel then begin
          Result := True;
        end else begin
          SysMsg(g_sLevelNot, c_Red, t_Hint);
        end;
      end;
    1: begin
        if HiWord(m_WAbil.DC) >= StdItem.NeedLevel then begin
          Result := True;
        end else begin
          SysMsg(g_sDCNot, c_Red, t_Hint);
        end;
      end;
    10: begin
        if (m_btJob = LoWord(StdItem.NeedLevel)) and (m_Abil.Level >= HiWord(StdItem.NeedLevel)) then begin
          Result := True;
        end else begin
          SysMsg(g_sJobOrLevelNot, c_Red, t_Hint);
        end;
      end;
    11: begin
        if (m_btJob = LoWord(StdItem.NeedLevel)) and (HiWord(m_WAbil.DC) >= HiWord(StdItem.NeedLevel)) then begin
          Result := True;
        end else begin
          SysMsg(g_sJobOrDCNot, c_Red, t_Hint);
        end;
      end;
    12: begin
        if (m_btJob = LoWord(StdItem.NeedLevel)) and (HiWord(m_WAbil.MC) >= HiWord(StdItem.NeedLevel)) then begin
          Result := True;
        end else begin
          SysMsg(g_sJobOrMCNot, c_Red, t_Hint);
        end;
      end;
    13: begin
        if (m_btJob = LoWord(StdItem.NeedLevel)) and (HiWord(m_WAbil.SC) >= HiWord(StdItem.NeedLevel)) then begin
          Result := True;
        end else begin
          SysMsg(g_sJobOrSCNot, c_Red, t_Hint);
        end;
      end;
    2: begin
        if HiWord(m_WAbil.MC) >= StdItem.NeedLevel then begin
          Result := True;
        end else begin
          SysMsg(g_sMCNot, c_Red, t_Hint);
        end;
      end;
    3: begin
        if HiWord(m_WAbil.SC) >= StdItem.NeedLevel then begin
          Result := True;
        end else begin
          SysMsg(g_sSCNot, c_Red, t_Hint);
        end;
      end;
    4: begin
        if m_btReLevel >= StdItem.NeedLevel then begin
          Result := True;
        end else begin
          SysMsg(g_sReNewLevelNot, c_Red, t_Hint);
        end;
      end;
    40: begin
        if m_btReLevel >= LoWord(StdItem.NeedLevel) then begin
          if m_Abil.Level >= HiWord(StdItem.NeedLevel) then begin
            Result := True;
          end else begin
            SysMsg(g_sLevelNot, c_Red, t_Hint);
          end;
        end else begin
          SysMsg(g_sReNewLevelNot, c_Red, t_Hint);
        end;
      end;
    41: begin
        if m_btReLevel >= LoWord(StdItem.NeedLevel) then begin
          if HiWord(m_WAbil.DC) >= HiWord(StdItem.NeedLevel) then begin
            Result := True;
          end else begin
            SysMsg(g_sDCNot, c_Red, t_Hint);
          end;
        end else begin
          SysMsg(g_sReNewLevelNot, c_Red, t_Hint);
        end;
      end;
    42: begin
        if m_btReLevel >= LoWord(StdItem.NeedLevel) then begin
          if HiWord(m_WAbil.MC) >= HiWord(StdItem.NeedLevel) then begin
            Result := True;
          end else begin
            SysMsg(g_sMCNot, c_Red, t_Hint);
          end;
        end else begin
          SysMsg(g_sReNewLevelNot, c_Red, t_Hint);
        end;
      end;
    43: begin
        if m_btReLevel >= LoWord(StdItem.NeedLevel) then begin
          if HiWord(m_WAbil.SC) >= HiWord(StdItem.NeedLevel) then begin
            Result := True;
          end else begin
            SysMsg(g_sSCNot, c_Red, t_Hint);
          end;
        end else begin
          SysMsg(g_sReNewLevelNot, c_Red, t_Hint);
        end;
      end;
    44: begin
        if m_btReLevel >= LoWord(StdItem.NeedLevel) then begin
          if m_btCreditPoint >= HiWord(StdItem.NeedLevel) then begin
            Result := True;
          end else begin
            SysMsg(g_sCreditPointNot, c_Red, t_Hint);
          end;
        end else begin
          SysMsg(g_sReNewLevelNot, c_Red, t_Hint);
        end;
      end;
    5: begin
        if m_btCreditPoint >= StdItem.NeedLevel then begin
          Result := True;
        end else begin
          SysMsg(g_sCreditPointNot, c_Red, t_Hint);
        end;
      end;
    6: begin
        if (m_MyGuild <> nil) then begin
          Result := True;
        end else begin
          SysMsg(g_sGuildNot, c_Red, t_Hint);
        end;
      end;
    60: begin
        if (m_MyGuild <> nil) and (m_nGuildRankNo = 1) then begin
          Result := True;
        end else begin
          SysMsg(g_sGuildMasterNot, c_Red, t_Hint);
        end;
      end;
    7: begin
        //      if (m_MyGuild <> nil) and (UserCastle.m_MasterGuild = m_MyGuild) then begin
        if (m_MyGuild <> nil) and (Castle <> nil) then begin
          Result := True;
        end else begin
          SysMsg(g_sSabukHumanNot, c_Red, t_Hint);
        end;
      end;
    70: begin
        //      if (m_MyGuild <> nil) and (UserCastle.m_MasterGuild = m_MyGuild) and (m_nGuildRankNo = 1) then begin
        if (m_MyGuild <> nil) and (Castle <> nil) and (m_nGuildRankNo = 1) then begin
          if m_Abil.Level >= StdItem.NeedLevel then begin
            Result := True;
          end else begin
            SysMsg(g_sLevelNot, c_Red, t_Hint);
          end;
        end else begin
          SysMsg(g_sSabukMasterManNot, c_Red, t_Hint);
        end;
      end;
    8: begin
        if m_nMemberType <> 0 then begin
          Result := True;
        end else begin
          SysMsg(g_sMemberNot, c_Red, t_Hint);
        end;
      end;
    81: begin
        if (m_nMemberType = LoWord(StdItem.NeedLevel)) and (m_nMemberLevel >= HiWord(StdItem.NeedLevel)) then begin
          Result := True;
        end else begin
          SysMsg(g_sMemberTypeNot, c_Red, t_Hint);
        end;
      end;
    82: begin
        if (m_nMemberType >= LoWord(StdItem.NeedLevel)) and (m_nMemberLevel >= HiWord(StdItem.NeedLevel)) then begin
          Result := True;
        end else begin
          SysMsg(g_sMemberTypeNot, c_Red, t_Hint);
        end;
      end;
  end;
  //if not Result then SysMsg(g_sCanottWearIt,c_Red,t_Hint);
end;

procedure THeroObject.MakeSaveRcd(var HumanRcd: THumDataInfo);
var
  I: Integer;
  HumData: pTHumData;
  HumItems: pTHumItems;
  HumAddItems: pTHumAddItems;
  BagItems: pTBagItems;
  HumMagics: pTHumMagics;
  UserMagic: pTUserMagic;
  StorageItems: pTStorageItems;
begin
  HumanRcd.Header.sName := m_sCharName;
  HumanRcd.Header.boIsHero := True;
  HumanRcd.Header.boDeleted := False;
  HumData := @HumanRcd.Data;
  HumData.sChrName := m_sCharName;
  HumData.sCurMap := m_sMapName;
  HumData.wCurX := m_nCurrX;
  HumData.wCurY := m_nCurrY;
  HumData.btDir := m_btDirection;
  HumData.btHair := m_btHair;
  HumData.btSex := m_btGender;
  HumData.btJob := m_btJob;
  HumData.nGold := 0;

  HumData.Abil.Level := m_Abil.Level;
  HumData.Abil.HP := m_Abil.HP;
  HumData.Abil.MP := m_Abil.MP;
  HumData.Abil.MaxHP := m_Abil.MaxHP;
  HumData.Abil.MaxMP := m_Abil.MaxMP;
  HumData.Abil.Exp := m_Abil.Exp;
  HumData.Abil.MaxExp := m_Abil.MaxExp;
  HumData.Abil.Weight := m_Abil.Weight;
  HumData.Abil.MaxWeight := m_Abil.MaxWeight;
  HumData.Abil.WearWeight := m_Abil.WearWeight;
  HumData.Abil.MaxWearWeight := m_Abil.MaxWearWeight;
  HumData.Abil.HandWeight := m_Abil.HandWeight;
  HumData.Abil.MaxHandWeight := m_Abil.MaxHandWeight;

  HumData.Abil.HP := m_WAbil.HP;
  HumData.Abil.MP := m_WAbil.MP;

  HumData.wStatusTimeArr := m_wStatusTimeArr;
  HumData.sHomeMap := m_sHomeMap;
  HumData.wHomeX := m_nHomeX;
  HumData.wHomeY := m_nHomeY;
  HumData.nPKPOINT := m_nPkPoint;
  //HumData.BonusAbil := m_BonusAbil; // 08/09
  //HumData.nBonusPoint := m_nBonusPoint; // 08/09
  //HumData.sStoragePwd := m_sStoragePwd;
  HumData.btCreditPoint := m_btCreditPoint;
  HumData.btReLevel := m_btReLevel;

  HumData.sMasterName := m_sMasterName;
  //HumData.boMaster := m_boMaster;
  HumData.sDearName := '';
  HumData.sHeroChrName := '';
  //HumData.nGameGold := m_nGameGold;
  //HumData.nGamePoint := m_nGamePoint;

  //if m_boAllowGroup then HumData.btAllowGroup := 1
  //else HumData.btAllowGroup := 0;
  //HumData.btF9 := btB2;
  HumData.btAttatckMode := m_btAttatckMode;
  HumData.btIncHealth := m_nIncHealth;
  HumData.btIncSpell := m_nIncSpell;
  HumData.btIncHealing := m_nIncHealing;
  HumData.btFightZoneDieCount := m_nFightZoneDieCount;
  HumData.sAccount := m_sUserID;
  //HumData.btEE := nC4;
  //HumData.boLockLogon := m_boLockLogon;
  //HumData.wContribution := m_wContribution;
  //HumData.btEF := btC8;
  //HumData.nHungerStatus := m_nHungerStatus;
  //HumData.boAllowGuildReCall := m_boAllowGuildReCall;
  //HumData.wGroupRcallTime := m_wGroupRcallTime;
  HumData.dBodyLuck := m_dBodyLuck;
  //HumData.boAllowGroupReCall := m_boAllowGroupReCall;

  HumData.btLastOutStatus := m_btLastOutStatus; //2006-01-12增加 退出状态 1为死亡退出
  //HumData.wMasterCount := m_wMasterCount; //出师徒弟数
  HumData.QuestFlag := m_QuestFlag;
  HumData.boHasHero := False;
  HumData.boIsHero := True;
  HumData.btStatus := m_btStatus;

  HumData.nGrudge := m_nGrudge;

  HumData.wStatusDelayTime := m_nStatusDelayTime;

  HumData.NewStatus := m_NewStatus; //1失明 2混乱 状态

  HumItems := @HumanRcd.Data.HumItems;
  HumItems[U_DRESS] := m_UseItems[U_DRESS];
  HumItems[U_WEAPON] := m_UseItems[U_WEAPON];
  HumItems[U_RIGHTHAND] := m_UseItems[U_RIGHTHAND];

  HumItems[U_HELMET] := m_UseItems[U_NECKLACE];
  HumItems[U_NECKLACE] := m_UseItems[U_HELMET];

  HumItems[U_ARMRINGL] := m_UseItems[U_ARMRINGL];
  HumItems[U_ARMRINGR] := m_UseItems[U_ARMRINGR];
  HumItems[U_RINGL] := m_UseItems[U_RINGL];
  HumItems[U_RINGR] := m_UseItems[U_RINGR];

  HumAddItems := @HumanRcd.Data.HumAddItems;
  HumAddItems[U_BUJUK] := m_UseItems[U_BUJUK];
  HumAddItems[U_BELT] := m_UseItems[U_BELT];
  HumAddItems[U_BOOTS] := m_UseItems[U_BOOTS];
  HumAddItems[U_CHARM] := m_UseItems[U_CHARM];

  BagItems := @HumanRcd.Data.BagItems;
  for I := 0 to m_ItemList.Count - 1 do begin
    if I >= MAXHEROBAGITEM then Break;
    BagItems[I] := pTUserItem(m_ItemList.Items[I])^;
  end;
  HumMagics := @HumanRcd.Data.HumMagics;
  for I := 0 to m_MagicList.Count - 1 do begin
    if I >= MAXMAGIC then Break;
    UserMagic := m_MagicList.Items[I];
    HumMagics[I].wMagIdx := UserMagic.wMagIdx;
    HumMagics[I].btLevel := UserMagic.btLevel;
    HumMagics[I].btKey := UserMagic.btKey;
    HumMagics[I].nTranPoint := UserMagic.nTranPoint;
    //MainOutMessage('THeroObject.MakeSaveRcd:'+UserMagic.MagicInfo.sMagicName+':'+IntToStr(UserMagic.btLevel));
  end;

  {StorageItems := @HumanRcd.Data.StorageItems;
  for I := 0 to m_StorageItemList.Count - 1 do begin
    if I >= MAXBAGITEM then Break;
    StorageItems[I] := pTUserItem(m_StorageItemList.Items[I])^;
  end;}
end;

function THeroObject.QuestCheckItem(sItemName: string; var nCount,
  nParam: Integer; var nDura: Integer): pTUserItem;
var
  I: Integer;
  UserItem: pTUserItem;
  s1C: string;
begin
  Result := nil;
  nParam := 0;
  nDura := 0;
  nCount := 0;
  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem := m_ItemList.Items[I];
    s1C := UserEngine.GetStdItemName(UserItem.wIndex);
    if CompareText(s1C, sItemName) = 0 then begin
      if UserItem.Dura > nDura then begin
        nDura := UserItem.Dura;
        Result := UserItem;
      end;
      Inc(nParam, UserItem.Dura);
      if Result = nil then
        Result := UserItem;
      Inc(nCount);
    end;
  end;
end;

procedure THeroObject.DropUseItems(BaseObject: TActorObject);
var
  I, nRate: Integer;
  StdItem: pTStdItem;
  DropItemList: TStringList;
  boDropall: Boolean;
  sCheckItemName: string;
  PlayObject: TPlayObject;
  ActorObject, ActorObject18: TActorObject;
  nC, n10: Integer;

resourcestring
  sExceptionMsg = '[Exception] THeroObject::DropUseItems';
begin
  DropItemList := nil;

  if m_boNoDropUseItem or (not m_boDropUseItem) then Exit;

  PlayObject := nil;
  if (BaseObject <> nil) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then
    PlayObject := TPlayObject(BaseObject)
  else begin
    ActorObject18 := nil;
    n10 := 9999;
    for I := 0 to m_VisibleActors.Count - 1 do begin
      ActorObject := TActorObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if (ActorObject.m_btRaceServer = RC_PLAYOBJECT) then begin
        if (not ActorObject.m_boHideMode or m_boCoolEye) then begin
          nC := abs(m_nCurrX - ActorObject.m_nCurrX) + abs(m_nCurrY - ActorObject.m_nCurrY);
          if nC < n10 then begin
            n10 := nC;
            ActorObject18 := ActorObject;
          end;
        end;
      end;
    end;
    if ActorObject18 <> nil then
      PlayObject := TPlayObject(ActorObject18)
    else
      PlayObject := TPlayObject(m_Master);
  end;

  //MainOutMessage('THeroObject.DropUseItems1');
  try
    //if m_boNoDropUseItem then Exit;
    //MainOutMessage('THeroObject.DropUseItems2');
    if m_Master <> nil then begin
      TPlayObject(m_Master).ClearCopyItems();
    end;

    for I := Low(THumanUseItems) to High(THumanUseItems) do begin
      StdItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);
      if StdItem <> nil then begin
        if (StdItem.Reserved and 8 <> 0) then begin
          //MainOutMessage('THeroObject.DropUseItems3:'+StdItem.Name);
          if DropItemList = nil then DropItemList := TStringList.Create;
          DropItemList.AddObject(StdItem.Name, TObject(m_UseItems[I].MakeIndex));
          if StdItem.NeedIdentify = 1 then
            AddGameDataLog('16' + #9 +
              m_sMapName + #9 +
              IntToStr(m_nCurrX) + #9 +
              IntToStr(m_nCurrY) + #9 +
              m_sCharName + #9 +
              //UserEngine.GetStdItemName(m_UseItems[I].wIndex) + #9 +
              StdItem.Name + #9 +
              IntToStr(m_UseItems[I].MakeIndex) + #9 +
              BoolToIntStr(m_btRaceServer = RC_HEROOBJECT) + #9 +
              '0');
          m_UseItems[I].wIndex := 0;
        end;
      end;
    end;

    //if not m_boDropUseItem then Exit;

    if PKLevel > 2 then nRate := g_Config.nHeroDieRedDropUseItemRate {15}
    else nRate := g_Config.nHeroDieDropUseItemRate {30};

    for I := Low(THumanUseItems) to High(THumanUseItems) do begin
      if m_UseItems[I].wIndex <= 0 then Continue;
      StdItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);
      if StdItem = nil then Continue;
      if InDisableTakeOffList(m_UseItems[I].wIndex) then Continue; //检查是否在禁止取下列表,如果在列表中则不掉此物品

      if (m_UseItems[I].AddValue[0] = 1) and (GetDayCount(m_UseItems[I].MaxDate, Now) <= 0) then begin //删除到期装备
        m_UseItems[I].wIndex := 0;
        Continue;
      end;

      if g_Config.boBindItemNoScatter and (m_Master <> nil) and (TPlayObject(m_Master).CheckItemBindUse(@m_UseItems[I], False) = 2) then Continue; //绑定物品禁止爆

      boDropall := False;
      if Assigned(PlugInEngine.CheckCanDieScatterItem) then begin //死亡必爆
        sCheckItemName := StdItem.Name;
        if PlugInEngine.CheckCanDieScatterItem(Self, PChar(sCheckItemName), False) then begin
          boDropall := True;
        end;
      end;

      if Assigned(PlugInEngine.CheckNotCanScatterItem) then begin //禁止爆出
        sCheckItemName := StdItem.Name;
        if PlugInEngine.CheckNotCanScatterItem(Self, PChar(sCheckItemName), False) then begin
          Continue;
        end;
      end;

      if (Random(nRate) <> 0) and (not boDropall) then Continue;

      if DropItemDown(@m_UseItems[I], 2, True, BaseObject, Self) then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);
        if StdItem <> nil then begin

          if (PlayObject <> nil) and (g_FunctionNPC <> nil) then begin
            PlayObject.m_sScatterItemName := StdItem.Name;
            PlayObject.m_sScatterItemOwnerName := m_sCharName;
            PlayObject.m_sScatterItemMapName := m_sMapName;
            PlayObject.m_sScatterItemMapDesc := m_PEnvir.sMapDesc;
            PlayObject.m_nScatterItemX := m_nScatterItemX;
            PlayObject.m_nScatterItemY := m_nScatterItemY;
            if IsAllowScatterItem(PlayObject.m_sScatterItemName) then begin
              try
                g_FunctionNPC.GotoLable(PlayObject, '@DropUseItems', False);
              except
                MainOutMessage(sExceptionMsg + ' FunctionNPC::GotoLable');
              end;
            end;
          end;

          if (StdItem.Reserved and 10 = 0) then begin
            if DropItemList = nil then DropItemList := TStringList.Create;
            DropItemList.AddObject(UserEngine.GetStdItemName(m_UseItems[I].wIndex), TObject(m_UseItems[I].MakeIndex));
            m_UseItems[I].wIndex := 0;
          end;
        end;
      end;
    end;
    if DropItemList <> nil then
      SendMsg(Self, RM_SENDDELITEMLIST, 0, Integer(DropItemList), 0, 0, '');
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure THeroObject.ScatterBagItems(ItemOfCreat: TActorObject);
var
  I, II, DropWide: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  boCanNotDrop: Boolean;
  MonDrop: pTMonDrop;
  pu: pTUserItem;
  DelList: TStringList;
  boDropall: Boolean;

  sCheckItemName: string;
  PlayObject: TPlayObject;
  ActorObject, ActorObject18: TActorObject;
  nC, n10: Integer;
resourcestring
  sExceptionMsg = '[Exception] THeroObject::ScatterBagItems';
begin
//英雄爆包裹
  DelList := nil;
  if m_boAngryRing or m_boNoDropItem or not m_boDropUseItem then Exit; //不死戒指
  //if not m_boDropUseItem then Exit;

  PlayObject := nil;
  if (ItemOfCreat <> nil) and (ItemOfCreat.m_btRaceServer = RC_PLAYOBJECT) then
    PlayObject := TPlayObject(ItemOfCreat)
  else begin
    ActorObject18 := nil;
    n10 := 9999;
    for I := 0 to m_VisibleActors.Count - 1 do begin
      ActorObject := TActorObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if (ActorObject.m_btRaceServer = RC_PLAYOBJECT) then begin
        if (not ActorObject.m_boHideMode or m_boCoolEye) then begin
          nC := abs(m_nCurrX - ActorObject.m_nCurrX) + abs(m_nCurrY - ActorObject.m_nCurrY);
          if nC < n10 then begin
            n10 := nC;
            ActorObject18 := ActorObject;
          end;
        end;
      end;
    end;
    if ActorObject18 <> nil then
      PlayObject := TPlayObject(ActorObject18)
    else
      PlayObject := TPlayObject(m_Master);
  end;

  boDropall := False;
  DropWide := 2;
  if g_Config.boHeroDieRedScatterBagAll and (PKLevel >= 2) then begin
    boDropall := True;
  end;
    //非红名掉1/3 //红名全掉
  try
    for I := m_ItemList.Count - 1 downto 0 do begin
      if m_ItemList.Count <= 0 then Break;

      UserItem := pTUserItem(m_ItemList[I]);

      if (UserItem.AddValue[0] = 1) and (GetDayCount(UserItem.MaxDate, Now) <= 0) then begin //删除到期装备
        m_ItemList.Delete(I);
        Dispose(UserItem);
        Continue;
      end;

      sCheckItemName := UserEngine.GetStdItemName(UserItem.wIndex);

      if g_Config.boBindItemNoScatter and (m_Master <> nil) and (TPlayObject(m_Master).CheckItemBindUse(UserItem, False) = 2) then Continue; //绑定物品禁止爆

      if Assigned(PlugInEngine.CheckCanDieScatterItem) then begin //死亡必爆
        if PlugInEngine.CheckCanDieScatterItem(Self, PChar(sCheckItemName), False) then begin
          boDropall := True;
        end;
      end;

      if Assigned(PlugInEngine.CheckNotCanScatterItem) then begin //禁止爆出
        if PlugInEngine.CheckNotCanScatterItem(Self, PChar(sCheckItemName), False) then begin
          Continue;
        end;
      end;

      if boDropall or (Random(g_Config.nHeroDieScatterBagRate {3}) = 0) then begin

        if DropItemDown(UserItem, DropWide, True, ItemOfCreat, Self) then begin
              //pu := pTUserItem(m_ItemList[I]);
          if m_btRaceServer = RC_HEROOBJECT then begin
            if DelList = nil then DelList := TStringList.Create;
            DelList.AddObject(UserEngine.GetStdItemName(UserItem.wIndex), TObject(UserItem.MakeIndex));
          end;
          if (PlayObject <> nil) and (g_FunctionNPC <> nil) then begin
            PlayObject.m_sScatterItemName := UserEngine.GetStdItemName(UserItem.wIndex);
            PlayObject.m_sScatterItemOwnerName := m_sCharName;
            PlayObject.m_sScatterItemMapName := m_sMapName;
            PlayObject.m_sScatterItemMapDesc := m_PEnvir.sMapDesc;
            PlayObject.m_nScatterItemX := m_nScatterItemX;
            PlayObject.m_nScatterItemY := m_nScatterItemY;
            if IsAllowScatterItem(PlayObject.m_sScatterItemName) then begin
              try
                g_FunctionNPC.GotoLable(PlayObject, '@ScatterBagItems', False);
              except
                MainOutMessage(sExceptionMsg + ' FunctionNPC::GotoLable');
              end;
            end;
          end;
          m_ItemList.Delete(I);
          Dispose(UserItem);
        end;
      end;
    end;
    if DelList <> nil then begin
      SendMsg(Self, RM_SENDDELITEMLIST, 0, Integer(DelList), 0, 0, '');
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure THeroObject.LogOut(); //英雄退出
resourcestring
  sExceptionMsg = '[Exception] THeroObject::LogOut';
begin
  //MainOutMessage('THeroObject::LogOut');
  UnHeroGroup;
  if m_boHeroLogOut then Exit;
  m_boHeroLogOut := True;

  if (g_ManageNPC <> nil) and (m_Master <> nil) then begin
    TPlayObject(m_Master).m_nScriptGotoCount := 0;
    try
      g_ManageNPC.GotoLable(TPlayObject(m_Master), '@HeroLogOut', False);
    except
      MainOutMessage(sExceptionMsg + ' FunctionNPC::GotoLable @HeroLogOut');
    end;
  end;
  SendRefMsg(RM_HEROLOGOUT, 0, Integer(Self), m_nCurrX, m_nCurrY, '');
  {m_DefMsg := MakeDefaultMsg(SM_HEROLOGOUT, Integer(Self), m_nCurrX, m_nCurrY, 0);
  SendSocket(@m_DefMsg, ''); }
  SendMsg(Self, RM_MAKEGHOST, 0, 0, 0, 0, '');
  //MainOutMessage('THeroObject.LogOut:'+m_sCharName);
end;

procedure THeroObject.LogOn();
var
  I, nRecog, nError: Integer;
  II: Integer;
  UserItem: pTUserItem;
  UserItem1: pTUserItem;
  MessageBodyWL: TMessageBodyWL;
  StdItem: pTStdItem;
  s14: string;
  sItem: string;
  sIPaddr: string;
resourcestring
  sExceptionMsg = '[Exception] THeroObject::LogOn:%d';
begin
  //MainOutMessage('THeroObject::LogOn');
  try
    nError := 0;
    m_boHeroLogOnOK := m_boAI;
    m_dwHeroLogOnTick := GetTickCount();
    m_dLogonTime := Now();
    m_dwLogonTick := GetTickCount();
    m_nHeroLogOnCount := 0;
    nError := 1;
    //给新人增加新人物品
    if m_boNewHuman then begin
      New(UserItem);
      nError := 2;
      if UserEngine.CopyToUserItemFromName(g_Config.sHeroBasicDrug, UserItem) then begin
        m_ItemList.Add(UserItem);
      end else Dispose(UserItem);
      nError := 3;
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sHeroWoodenSword, UserItem) then begin
        m_ItemList.Add(UserItem);
      end else Dispose(UserItem);
      nError := 4;
      New(UserItem);
      if m_btGender = 0 then
        sItem := g_Config.sHeroClothsMan
      else
        sItem := g_Config.sHeroClothsWoman;
      if UserEngine.CopyToUserItemFromName(sItem, UserItem) then begin
        m_ItemList.Add(UserItem);
      end else Dispose(UserItem);
    end;
    nError := 5;
    //检查背包中的物品是否合法
    for I := m_ItemList.Count - 1 downto 0 do begin
      if m_ItemList.Count <= 0 then Break;
      UserItem := m_ItemList.Items[I];
      nError := 6;
      if UserEngine.GetStdItemName(UserItem.wIndex) = '' then begin
        Dispose(pTUserItem(m_ItemList.Items[I]));
        m_ItemList.Delete(I);
      end;
      nError := 7;
    end;
    nError := 8;
    //检查人物身上的物品是否符合使用规则
    if g_Config.boCheckUserItemPlace then begin
      for I := Low(THumanUseItems) to High(THumanUseItems) do begin
        if m_UseItems[I].wIndex > 0 then begin
          nError := 9;
          StdItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);
          if StdItem <> nil then begin
            if not CheckUserItems(I, StdItem) then begin
              New(UserItem);
              UserItem^ := m_UseItems[I];
              if not AddItemToBag(UserItem) then begin
                m_ItemList.Insert(0, UserItem);
              end;
              m_UseItems[I].wIndex := 0;
            end;
          end else m_UseItems[I].wIndex := 0;
        end;
      end;
    end;
    nError := 10;
    for I := Low(m_dwStatusArrTick) to High(m_dwStatusArrTick) do begin
      if m_wStatusTimeArr[I] > 0 then
        m_dwStatusArrTick[I] := GetTickCount();
    end;
    nError := 11;
    RecalcLevelAbilitys();
    nError := 12;
    RecalcAbilitys();
    nError := 13;
    {
    m_DefMsg := MakeDefaultMsg(SM_HEROLOGON, Integer(Self), m_nCurrX, m_nCurrY, MakeWord(m_btDirection, m_btGender));
    MessageBodyWL.lParam1 := GetFeatureToLong();
    MessageBodyWL.lParam2 := m_nCharStatus;
    MessageBodyWL.lTag1 := GetFeatureEx;
    MessageBodyWL.lTag2 := 0;
    SendSocket(@m_DefMsg, EncodeBuffer(@MessageBodyWL, SizeOf(TMessageBodyWL)));
    }
    m_boFixedHideMode := False;
    nError := 14;
    SendRefMsg(RM_HEROLOGON, MakeWord(m_btDirection, m_btGender), Integer(Self), m_nCurrX, m_nCurrY, '');
    nError := 15;
    nRecog := GetFeatureToLong();
    nError := 16;
    SendDefMessage(SM_FEATURECHANGED, Integer(Self), LoWord(nRecog), HiWord(nRecog), GetFeatureEx, '');
    nError := 17;
    m_Abil.MaxExp := GetLevelExp(m_Abil.Level);
    nError := 18;
    SendMsg(Self, RM_ABILITY, 0, 0, 0, 0, '');
    nError := 19;
    SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');
    nError := 20;
    SendMsg(Self, RM_QUERYBAGITEMS, 0, 0, 0, 0, '');
    nError := 21;
    SendMsg(Self, RM_SENDUSEITEMS, 0, 0, 0, 0, '');
    nError := 22;
    SendMsg(Self, RM_SENDMYMAGIC, 0, 0, 0, 0, '');
    nError := 23;
    SendMsg(Self, RM_HEROLOGON_OK, 0, 0, 0, 0, '');
    nError := 24;
    {SendDelayMsg(Self, RM_QUERYBAGITEMS, 0, 0, 0, 0, '', 500);
    SendDelayMsg(Self, RM_SENDUSEITEMS, 0, 0, 0, 0, '', 1000);
    SendDelayMsg(Self, RM_SENDMYMAGIC, 0, 0, 0, 0, '', 1500);
    SendDelayMsg(Self, RM_HEROLOGON_OK, 0, 0, 0, 0, '', 2000);}

    //RefShowName();

    if m_btStatus > 2 then m_btStatus := 0;
    m_boSlaveRelax := m_btStatus = 2;
    nError := 25;
    case m_btStatus of
      0: begin
          SysMsg('状态：攻击', c_Green, t_Hint);
        end;
      1: begin
          SysMsg('状态：跟随', c_Green, t_Hint);
        end;
      2: begin
          SysMsg('状态：休息', c_Green, t_Hint);
        end;
    end;
    //MainOutMessage(m_sCharName + ' THeroObject::m_WAbil.Level0:' + IntToStr(m_WAbil.Level));
    nError := 25;
    if (g_ManageNPC <> nil) and (m_Master <> nil) then begin
      nError := 26;
      TPlayObject(m_Master).m_nScriptGotoCount := 0;
      nError := 27;
      g_ManageNPC.GotoLable(TPlayObject(m_Master), '@HeroLogin', False);
      nError := 28;
    end;
    //MainOutMessage(m_sCharName + ' THeroObject::m_WAbil.Level1:' + IntToStr(m_WAbil.Level));

    (*SysMsg('状态更改：Ctrl+E', c_Red, t_Hint);
    SysMsg('指定攻击目标：Ctrl+W', c_Red, t_Hint);
    SysMsg(Format('守护位置：Ctrl+Q (英雄人物达到%d级后方可使用)', [33 {g_Config.nNeedGuardLevel}]), c_Red, t_Hint);
    SysMsg('使用合击技：Ctrl+S (学会合击技方可使用)', c_Red, t_Hint);  *)
    nError := 29;
    SysMsg(g_sHeroLoginMsg, c_Green, t_Hint);
    nError := 30;
  except
    on E: Exception do begin
      MainOutMessage(Format(sExceptionMsg, [nError]));
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure THeroObject.Initialize;
var
  I: Integer;

  sFileName: string;
  ItemIni: TIniFile;

  TempList: TStringList;
  sCopyHumBagItems: string;
  UserItem: pTUserItem;

  sLineText: string;
  sMagicName: string;
  sItemName: string;
  Magic: pTMagic;
  MagicInfo: pTMagic;
  UserMagic: pTUserMagic;
  StdItem: pTStdItem;
begin
  if (m_Master <> nil) and (m_Master is TAIPlayObject) and m_boAI then begin
    sFileName := TAIPlayObject(m_Master).GetRandomConfigFileName;
    if (sFileName = '') or (not FileExists(sFileName)) then begin
      if (TAIPlayObject(m_Master).m_sHeroConfigFileName <> '') and FileExists(TAIPlayObject(m_Master).m_sHeroConfigFileName) then begin
        sFileName := TAIPlayObject(m_Master).m_sHeroConfigFileName;
      end;
    end;

    if (sFileName <> '') and FileExists(sFileName) then begin
      for I := 0 to m_MagicList.Count - 1 do begin
        Dispose(pTUserMagic(m_MagicList.Items[I]));
      end;
      m_MagicList.Clear;

      for I := 0 to m_ItemList.Count - 1 do begin
        Dispose(pTUserItem(m_ItemList.Items[I]));
      end;
      m_ItemList.Clear;

      for I := U_DRESS to U_CHARM do begin
        m_UseItems[I].wIndex := 0;
      end;

      ItemIni := TIniFile.Create(sFileName);
      if ItemIni <> nil then begin
        m_btJob := ItemIni.ReadInteger('BaseInfo', 'Job', 0);
        m_btGender := ItemIni.ReadInteger('BaseInfo', 'Gender', 0);
        m_btHair := ItemIni.ReadInteger('BaseInfo', 'Hair', 0);
        m_Abil.Level := ItemIni.ReadInteger('BaseInfo', 'Level', 1);

      //MainOutMessage(m_sCharName + ' Hero m_WAbil.Level:' + IntToStr(m_WAbil.Level));

        RefBagItemCount;

        sLineText := ItemIni.ReadString('BaseInfo', 'Magic', '');

        if sLineText <> '' then begin
          TempList := TStringList.Create;
          ExtractStrings(['|', '\', '/', ','], [], PChar(sLineText), TempList);
          for I := 0 to TempList.Count - 1 do begin
            sMagicName := Trim(TempList.Strings[I]);
            if FindMagic(sMagicName) = nil then begin
              Magic := UserEngine.FindMagic(sMagicName);
              if Magic <> nil then begin
                if (Magic.btJob = 99) or (Magic.btJob = m_btJob) then begin
                  New(UserMagic);
                  UserMagic.MagicInfo := Magic;
                  UserMagic.wMagIdx := Magic.wMagicId;
                  UserMagic.btLevel := 3;
                  UserMagic.btKey := VK_F1;
                  UserMagic.nTranPoint := Magic.MaxTrain[3];
                  m_MagicList.Add(UserMagic);
                end;
              end;
            end;
          end;
          TempList.Free;
        end;

        sLineText := ItemIni.ReadString('BaseInfo', 'BagItem', '');
        if sLineText <> '' then begin
          TempList := TStringList.Create;
          ExtractStrings(['|', '\', '/', ','], [], PChar(sLineText), TempList);
          for I := 0 to TempList.Count - 1 do begin
            sItemName := Trim(TempList.Strings[I]);

            StdItem := UserEngine.GetStdItem(sItemName);
            if StdItem <> nil then begin
              New(UserItem);
              if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin

                if Random(g_Config.nMonRandomNewAddValue {10}) = 0 then
                  UserEngine._RandomUpgradeItem(UserItem);

                if Random(g_Config.nMonRandomAddPoint) = 0 then //新增5属性
                  UserEngine.RandomItemAddPoint(UserItem);

                UserEngine._RandomItemLimitDay(UserItem, g_Config.nMonRandomNotLimit);

                if Random(g_Config.nMonRandomAddValue {10}) = 0 then
                  UserEngine.RandomUpgradeItem(UserItem);

                if StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26] then begin
                  if (StdItem.Shape = 130) or (StdItem.Shape = 131) or (StdItem.Shape = 132) then begin
                    UserEngine.GetUnknowItemValue(UserItem);

                    UserEngine._GetUnknowItemValue(UserItem);
                  end;
                end;

                if not AddItemToBag(UserItem) then begin
                  Dispose(UserItem);
                  break;
                end;
                m_BagItemNames.Add(StdItem.Name);
              end else Dispose(UserItem);
            end;

          end;
          TempList.Free;
        end;

        m_UseItemNames[U_DRESS] := ItemIni.ReadString('UseItems', 'DRESSNAME', ''); // '衣服';
        m_UseItemNames[U_WEAPON] := ItemIni.ReadString('UseItems', 'WEAPONNAME', ''); // '武器';
        m_UseItemNames[U_RIGHTHAND] := ItemIni.ReadString('UseItems', 'RIGHTHANDNAME', ''); // '照明物';
        m_UseItemNames[U_NECKLACE] := ItemIni.ReadString('UseItems', 'NECKLACENAME', ''); // '项链';
        m_UseItemNames[U_HELMET] := ItemIni.ReadString('UseItems', 'HELMETNAME', ''); // '头盔';
        m_UseItemNames[U_ARMRINGL] := ItemIni.ReadString('UseItems', 'ARMRINGLNAME', ''); // '左手镯';
        m_UseItemNames[U_ARMRINGR] := ItemIni.ReadString('UseItems', 'ARMRINGRNAME', ''); // '右手镯';
        m_UseItemNames[U_RINGL] := ItemIni.ReadString('UseItems', 'RINGLNAME', ''); // '左戒指';
        m_UseItemNames[U_RINGR] := ItemIni.ReadString('UseItems', 'RINGRNAME', ''); // '右戒指';
        m_UseItemNames[U_BUJUK] := ItemIni.ReadString('UseItems', 'BUJUKNAME', ''); // '物品';
        m_UseItemNames[U_BELT] := ItemIni.ReadString('UseItems', 'BELTNAME', ''); // '腰带';
        m_UseItemNames[U_BOOTS] := ItemIni.ReadString('UseItems', 'BOOTSNAME', ''); // '鞋子';
        m_UseItemNames[U_CHARM] := ItemIni.ReadString('UseItems', 'CHARMNAME', ''); // '宝石';

        m_nDieDropUseItemRate := ItemIni.ReadInteger('UseItems', 'DieDropUseItemRate', 100);
        m_boButchItemEx := ItemIni.ReadBool('UseItems', 'ButchItem', False);
        m_boButchItem := m_boButchItemEx;
        m_boNoDropItem := ItemIni.ReadBool('UseItems', 'NoDropItem', False);
        m_boNoDropUseItem := ItemIni.ReadBool('UseItems', 'NoDropUseItem', False);

        for I := U_DRESS to U_CHARM do begin
          if m_UseItemNames[I] <> '' then begin
            StdItem := UserEngine.GetStdItem(m_UseItemNames[I]);
            if StdItem <> nil then begin
              New(UserItem);
              if UserEngine.CopyToUserItemFromName(m_UseItemNames[I], UserItem) then begin

                if Random(g_Config.nMonRandomNewAddValue {10}) = 0 then
                  UserEngine._RandomUpgradeItem(UserItem);

                if Random(g_Config.nMonRandomAddPoint) = 0 then //新增5属性
                  UserEngine.RandomItemAddPoint(UserItem);

                UserEngine._RandomItemLimitDay(UserItem, g_Config.nMonRandomNotLimit);

                if Random(g_Config.nMonRandomAddValue {10}) = 0 then
                  UserEngine.RandomUpgradeItem(UserItem);

                if StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26] then begin
                  if (StdItem.Shape = 130) or (StdItem.Shape = 131) or (StdItem.Shape = 132) then begin
                    UserEngine.GetUnknowItemValue(UserItem);

                    UserEngine._GetUnknowItemValue(UserItem);
                  end;
                end;
              end;
              m_UseItems[I] := UserItem^;
              Dispose(UserItem);
              //end;
            end;
          end;
        end;

        ItemIni.Free;

        m_WAbil.HP := m_WAbil.MaxHP;
        m_WAbil.MP := m_WAbil.MaxMP;

        AbilCopyToWAbil();
        //HasLevelUp(0);
      end;
    end;
  end;

  inherited;
end;

procedure THeroObject.Die; //英雄死亡
var
  AttackBaseObject, AttackMasterBaseObject: TActorObject;
  nCode: Integer;
  I: Integer;
resourcestring
  sExceptionMsg = '[Exception] THeroObject::Die Name:%s ErrorCode:%d';
begin
  m_boDeath := True;
  m_dwDeathTick := GetTickCount();
  m_nIncSpell := 0;
  m_nIncHealth := 0;
  m_nIncHealing := 0;
  GetDropUseItem;
  try
    if Assigned(PlugInEngine.ObjectDie) then begin
      if PlugInEngine.ObjectDie(Self) then Exit;
    end;

    nCode := 0;

    SendRefMsg(RM_DEATH, m_btDirection, m_nCurrX, m_nCurrY, 1, '');
    nCode := 2;
    //执行杀怪触发
    //if (m_LastHiter <> nil) and (m_LastHiter.m_btRaceServer = RC_PLAYOBJECT) then TPlayObject(m_LastHiter).KillMonsterFunc;
    if (not m_PEnvir.m_boFightZone) and
      (not m_PEnvir.m_boFight3Zone) {and
      (not m_boAnimal)}then begin
      AttackBaseObject := m_ExpHitter;
      if m_ExpHitter <> nil then m_ExpHitter.m_KillTargetCret := Self;
      if (m_ExpHitter <> nil) and (m_ExpHitter.m_Master <> nil) then begin
        AttackBaseObject := m_ExpHitter.m_Master;
        AttackMasterBaseObject := m_ExpHitter.Master;
        if AttackMasterBaseObject <> nil then
          AttackMasterBaseObject.m_KillTargetCret := Self;
      end;
      nCode := 3;
      if not m_boNoItem then begin {修改日期2004/07/21，增加此行，允许设置 m_boNoItem 后人物死亡不掉物品}
        AttackBaseObject := m_ExpHitter;
        if (m_ExpHitter <> nil) and (m_ExpHitter.m_Master <> nil) then begin
          AttackBaseObject := m_ExpHitter.m_Master;
        end;
        if AttackBaseObject <> nil then begin
          if (g_Config.boHeroKillByHumanDropUseItem and (AttackBaseObject.m_btRaceServer = RC_PLAYOBJECT)) or (g_Config.boHeroKillByMonstDropUseItem and (AttackBaseObject.m_btRaceServer >= RC_ANIMAL)) then
            DropUseItems(nil);
        end;
        if g_Config.boHeroDieScatterBag then ScatterBagItems(nil);
      end;
    end;
    nCode := 4;
  except
    on E: Exception do begin
      MainOutMessage(Format(sExceptionMsg, [m_sCharName, nCode]));
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure THeroObject.MakeGhost;
var
  I: Integer;
begin
  for I := 0 to m_SlaveList.Count - 1 do begin
    TActorObject(m_SlaveList.Items[I]).MakeGhost;
  end;
  m_SlaveList.Clear;

  if (m_Master <> nil) then begin
    TPlayObject(m_Master).m_MyHero := nil;
    TPlayObject(m_Master).m_dwRecallHeroTick := GetTickCount;
  end;
  m_Master := nil;
  inherited;
end;

procedure THeroObject.ClientChangeMagicKey(nMagicIdx: Integer);
var
  I: Integer;
  UserMagic: pTUserMagic;
begin
  for I := 0 to m_MagicList.Count - 1 do begin
    UserMagic := m_MagicList.Items[I];
    if UserMagic.MagicInfo.wMagicId = nMagicIdx then begin
      if UserMagic.btKey = 0 then
        UserMagic.btKey := VK_F1
      else
        UserMagic.btKey := 0;
      Break;
    end;
  end;
end;

procedure THeroObject.HeroGroup(btLevel: Byte; nTime: Integer);
var
  Magic: pTMagic;
  UserMagic: TUserMagic;
begin
  if m_boHeroLogOnOK and (not m_boDeath) and (not m_boGhost) and (btLevel > 0) and (m_btHeroGroup <= 0) then begin
    if (abs(m_Master.m_nCurrX - m_nCurrX) <= 8) and (abs(m_Master.m_nCurrY - m_nCurrY) <= 8) then begin
      m_btOStatus := m_btStatus;
      while m_btStatus <> 2 do RestHero();
      SendRefMsg(RM_SPELL, 50, m_Master.m_nCurrX, m_Master.m_nCurrY, 46, '');

      SendRefMsg(RM_MAGICFIRE, 0,
        MakeWord(2, 50),
        MakeLong(m_Master.m_nCurrX, m_Master.m_nCurrY),
        Integer(m_Master),
        '');

      SendDelayMsg(Self, RM_HEROGROUP, 0, 0, btLevel, nTime, '', 1000);

     { Magic := UserEngine.FindHeroMagic(46);
      if Magic <> nil then begin
        UserMagic.MagicInfo := Magic;
        UserMagic.wMagIdx := 46;
        UserMagic.btLevel := 3;
        ClientSpellXY(@UserMagic, m_Master.m_nCurrX, m_Master.m_nCurrY, m_Master);
      end;}
    end;
  end;
end;

procedure THeroObject.UnHeroGroup;
begin
  if m_btHeroGroup > 0 then begin
    m_btStatus := m_btOStatus;
    m_btHeroGroup := 0;
    m_boFixedHideMode := False;
    SendRefMsg(RM_TURN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    if m_Master <> nil then begin
      TPlayObject(m_Master).RecalcAbilitys;
      TPlayObject(m_Master).SendMsg(m_Master, RM_ABILITY, 0, 0, 0, 0, '');
    end;
  end;
end;

end.

