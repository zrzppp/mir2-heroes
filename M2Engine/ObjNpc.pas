unit ObjNpc;

interface
uses
  Windows, Classes, SysUtils, StrUtils, ObjBase, ObjActor, Grobal2, SDK, IniFiles, StorageEngn, SellEngn, MapPoint;
const
  CMD_RACE_0 = 0; //self
  CMD_RACE_1 = 1; //hero
  CMD_RACE_2 = 2; //Master
  CMD_RACE_3 = 3; //mon
  CMD_RACE_4 = 4; //obj
  CMD_RACE_5 = 5;
  CMD_RACE_6 = 6;
  CMD_RACE_7 = 7;
  CMD_RACE_8 = 8;
  CMD_RACE_9 = 9;
type
  TNormNpc = class;
  TUpgradeInfo = record
    sUserName: string[14];
    UserItem: TUserItem;
    btDc: Byte;
    btSc: Byte;
    btMc: Byte;
    btDura: Byte;
    n2C: Integer;
    dtTime: TDateTime;
    dwGetBackTick: LongWord;
    n3C: Integer;
  end;
  pTUpgradeInfo = ^TUpgradeInfo;
  TItemPrice = record
    wIndex: Word;
    nPrice: Integer;
  end;
  pTItemPrice = ^TItemPrice;
  TGoods = record
    sItemName: string[14];
    nCount: Integer;
    dwRefillTime: LongWord;
    dwRefillTick: LongWord;
  end;
  pTGoods = ^TGoods;

  TSellItemPrice = record
    wIndex: Word;
    nPrice: Integer;
  end;
  pTSellItemPrice = ^TSellItemPrice;

  TScriptObject = class
  private
    ScriptList: array of string;
    ScriptCmd: array of Integer;
  public
    procedure Clear;
    function Cmd(sCmd: string): string;
    function GetActorObject(NPC: TNormNpc; PlayObject: TPlayObject): TActorObject;
  end;

  TQuestActionInfo = record
    nCMDCode: Integer;
    sParam1: string;
    nParam1: Integer;
    sParam2: string;
    nParam2: Integer;
    sParam3: string;
    nParam3: Integer;
    sParam4: string;
    nParam4: Integer;
    sParam5: string;
    nParam5: Integer;
    sParam6: string;
    nParam6: Integer;
    sParam7: string;
    nParam7: Integer;
    sParam8: string;
    nParam8: Integer;
    sParam9: string;
    nParam9: Integer;
    sParam10: string;
    nParam10: Integer;
    Script: TScriptObject;
    //boEncrypt: Boolean;
    //sEncryptText: string;
    {private
      ScriptList: array of string;
    ScriptCmd: array of Integer;
    public
  procedure Clear;
function Cmd(sCmd: string): string;
function GetActorObject(NPC: TNormNpc; PlayObject: TPlayObject): TActorObject;  }
  end;
  pTQuestActionInfo = ^TQuestActionInfo;

  TQuestConditionInfo = record
    nCMDCode: Integer;
    sParam1: string;
    nParam1: Integer;
    sParam2: string;
    nParam2: Integer;
    sParam3: string;
    nParam3: Integer;
    sParam4: string;
    nParam4: Integer;
    sParam5: string;
    nParam5: Integer;
    sParam6: string;
    nParam6: Integer;
    sParam7: string;
    nParam7: Integer;
    sParam8: string;
    nParam8: Integer;
    sParam9: string;
    nParam9: Integer;
    sParam10: string;
    nParam10: Integer;
    Script: TScriptObject;
    //boEncrypt: Boolean;
    //sEncryptText: string;
   { private
      ScriptList: array of string;
    ScriptCmd: array of Integer;
    public
  procedure Clear;
function Cmd(sCmd: string): string;
function GetActorObject(NPC: TNormNpc; PlayObject: TPlayObject): TActorObject;   }
  end;
  pTQuestConditionInfo = ^TQuestConditionInfo;

  TSayingProcedure = record
    ConditionList: TList;
    ActionList: TList;
    sSayMsg: string;
    ElseActionList: TList;
    sElseSayMsg: string;
  end;
  pTSayingProcedure = ^TSayingProcedure;

  TSayingRecord = record
    sLabel: string;
    ProcedureList: TList;
    boExtJmp: Boolean; //是否允许外部跳转
  end;
  pTSayingRecord = ^TSayingRecord;

  TTimeLabel = record
    nType: Integer;
    nIndex: Integer;
    sLabel: string;
    dwTick: LongWord;
    dwTime: LongWord;
    boChangeMapDelete: Boolean;
    boDelete: Boolean;
    Npc: TNormNpc;
    Envir: TObject;
  end;
  pTTimeLabel = ^TTimeLabel;

  TNormNpc = class(TAnimalObject)
    m_NpcType: TNpcType;
    m_nFlag: ShortInt; //0x550 //用于标识此NPC是否有效，用于重新加载NPC列表(-1 为无效)
    m_ScriptList: TList; //0x554
    m_sFilePath: string; //0x558 脚本文件所在目录
    m_boIsHide: Boolean; //0x55C 此NPC是否是隐藏的，不显示在地图中
    m_boIsQuest: Boolean; //0x55D NPC类型为地图任务型的，加载脚本时的脚本文件名为 角色名-地图号.txt
    m_sPath: string; //0x560
    m_boNpcAutoChangeColor: Boolean;
    m_dwNpcAutoChangeColorTick: LongWord;
    m_dwNpcAutoChangeColorTime: LongWord;
    m_nNpcAutoChangeIdx: Integer;

    m_nNpcMagicIdx: Integer;

    m_nVarIdx: Integer;
    m_UnAllowLableList: TStringList;
  private
    procedure ScriptActionError(BaseObject: TActorObject; sErrMsg: string; QuestActionInfo: pTQuestActionInfo; sCmd: string);
    procedure ScriptConditionError(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo; sCmd: string);
    procedure ExeAction(BaseObject: TActorObject; sParam1, sParam2, sParam3: string; nParam1, nParam2, nParam3: Integer);
    procedure ActionOfChangeLevel(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUnMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUnMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGiveItem(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGetMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGetMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearSkill(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelNoJobSkill(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelSkill(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddSkill(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSkillLevel(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangePkPoint(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeExp(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeCreditPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeJob(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRecallGroupMembers(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearNameList(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMapTing(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMission(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMobPlace(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo; nX, nY, nCount, nRange: Integer);
    procedure ActionOfSetMemberType(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetMemberLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGameGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGamePoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAutoAddGameGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo; nPoint, nTime: Integer);
    procedure ActionOfAutoSubGameGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo; nPoint, nTime: Integer);
    procedure ActionOfChangeHairStyle(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfLineMsg(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeNameColor(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearPassword(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfReNewLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeGender(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKillSlave(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKillMonExpRate(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfPowerRate(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeMode(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangePerMission(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKill(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKick(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKickAll(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfBonusPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRestReNewLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearNeedItems(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearMakeItems(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUpgradeItems(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUpgradeItemsEx(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMonGenEx(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearMapMon(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetMapMode(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfPkZone(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRestBonusPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfTakeCastleGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfHumanHP(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfHumanMP(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildBuildPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildAuraePoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildstabilityPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildFlourishPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfOpenMagicBox(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetRankLevelName(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGmExecute(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildChiefItemCount(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddNameDateList(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelNameDateList(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMobFireBurn(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMessageBox(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetScriptFlag(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAutoGetExp(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRecallmob(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfActVarList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfLoadVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSaveVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfCalcVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfNotLineAddPiont(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKickNotLineAddPiont(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfCommendGameGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfStartTakeGold(PlayObject: TPlayObject);
    procedure ActionOfAnsiReplaceText(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfEncodeText(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDecodeText(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUseBonusPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRepairItem(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfTakeOnItem(ActorObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfTakeOffItem(ActorObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfCreateHero(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDeleteHero(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGiveExItem(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildMemberMaxLimit(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfOpenUserMarket(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddGuildNameDateList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelGuildNameDateList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGoHome(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddBlockIP(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMovData(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSendColorMsg(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddRandomMapGate(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelRandomMapGate(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGetRandomMapGate(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfOpenBook(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfOpenBox(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfHeroGroup(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUnHeroGroup(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfChangeItems(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearRemember(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSendMoveMsg(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSendCenterMsg(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfSetItemsLight(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetItemsLightEx(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeItemNewAddValue(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfOpenHomePage(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfSnow(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRandomUpgradeItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfChangeUseItemStarsLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeBagItemStarsLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfBindBagItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfReadRandomStr(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeRangeMonPos(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfReadVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfWriteVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfPkZoneEx(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfLock(BaseObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUnLock(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearDuelMap(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGetDuelItems(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAppDuel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfSpell(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddMapMagicEvent(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRandomAddMapMagicEvent(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDropItemMap(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfAutoGotoXY(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeNewStatus(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelayGoto(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSendDelayMsg(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetScTimer(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKillScTimer(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfSetMasked(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfPlaySound(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfShowEffect(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeItemValue(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfVibration(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfOpenBigDialogBox(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfCloseBigDialogBox(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfTagMapMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfTagMapInfo(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfAIStart(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAIStop(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAILogOn(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAILogOnEx(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfChangeIpAddress(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeAttatckMode(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfTakeItemList(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfShowRankLevelName(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfLoadRobotConfig(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);

    function ConditionOfCheckGroupCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseDir(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseLevel(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseGender(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseMarry(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckLevelEx(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSlaveCount(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckBonusPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckAccountIPList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckNameIPList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMarry(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMarryCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfHaveMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfPoseHaveMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseIsMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHaveGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsGuildMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsCastleaGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsCastleMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMemberType(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMemBerLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGameGold(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGamePoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckNameListPostion(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGuildList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckReNewLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSlaveLevel(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSlaveName(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCreditPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckOfGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPayMent(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckUseItem(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckBagSize(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckListCount(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckDC(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMC(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSC(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHP(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMP(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckItemType(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckExp(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCastleGold(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPasswordErrorCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfIsLockPassword(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfIsLockStorage(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGuildBuildPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGuildAuraePoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckStabilityPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckFlourishPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckContribution(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckRangeMonCount(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckItemAddValue(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckInMapRange(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsAttackGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsDefenseGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCastleDoorStatus(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsAttackAllyGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsDefenseAllyGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCastleChageDay(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCastleWarDay(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckOnlineLongMin(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckChiefItemCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckNameDateList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMapHumanCount(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMapMonCount(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckVar(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckServerName(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMapName(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSafeZone(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSkill(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfAnsiContainsText(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCompareText(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMonMapCount(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckStationTime(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHasHero(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGuildMeberMaxLimit(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGuildNameDateList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckRangeGroupCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfActMission(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckOnLinePlayCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCheckPKPoint(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;


    function ConditionOfCheckItemLimit(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckItemLimitCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMemoryItem(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfUpgradeItems(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfPutItem(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckItemBind(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfItemNewAddValue(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCheckItemNewAddValueCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHeroGroup(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPutItemType(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCheckUseItemStarsLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckBagItemStarsLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfIsUnderWar(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfInCastleWarArea(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;


    function ConditionOfCheckItemBindUse(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckRangeMapMagicEventCount(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfGetDuelMap(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMapDuelMap(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHumDuelMap(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckInCurrRect(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCheckGuildMember(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfIndexOf(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMasked(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCheckSlaveRange(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCheckBagItemInList(BaseObject: TActorObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function GetShowName: string; override;
    procedure AddLable(sLabel: string);
    procedure DeleteLable(sLabel: string);
    function AllowLable(sLabel: string): Boolean;
    procedure Initialize(); override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure Run; override;
    procedure Click(PlayObject: TPlayObject; sLabel: string = ''); virtual;
    procedure UserSelect(PlayObject: TPlayObject; sData: string); virtual;
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string); virtual;
    function GetLineVariableText(PlayObject: TPlayObject; sMsg: string): string;
    procedure GotoLable(AObject: TPlayObject; sLabel: string; boExtJmp: Boolean);
    function sub_49ADB8(sMsg, sStr, sText: string): string;
    procedure LoadNpcScript();
    procedure ClearScript(); virtual;
    procedure SendMsgToUser(PlayObject: TPlayObject; sMsg: string);
    procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); virtual;


    function GetDynamicVarList(PlayObject: TPlayObject; sType: string; var sName: string): TList;

    function GetValNameValue(PlayObject: TPlayObject; sVar: string; var sValue: string; var nValue: Integer): TVarType;
    function SetValNameValue(PlayObject: TPlayObject; sVar: string; sValue: string; nValue: Integer): Boolean;

    function GetDynamicValue(PlayObject: TPlayObject; sVar: string; var sValue: string; var nValue: Integer): TVarType;
    function SetDynamicValue(PlayObject: TPlayObject; sVar: string; sValue: string; nValue: Integer): Boolean;


    function GetVarValue(PlayObject: TPlayObject; sData: string; var sVar, sValue: string; var nValue: Integer): TVarInfo; overload;
    function GetVarValue(PlayObject: TPlayObject; sData: string; var sValue: string): TVarInfo; overload;
    function GetVarValue(PlayObject: TPlayObject; sData: string; var nValue: Integer): TVarInfo; overload;
  end;
  TMerchant = class(TNormNpc)
    m_sScript: string;
    n56C: Integer;
    m_nPriceRate: Integer; //物品价格倍率 默认为 100%
    bo574: Boolean;
    m_boCastle: Boolean;
    dwRefillGoodsTick: LongWord;
    dwClearExpreUpgradeTick: LongWord;
    m_ItemTypeList: TList; //NPC买卖物品类型列表，脚本中前面的 +1 +30 之类的
    m_RefillGoodsList: TList;
    m_GoodsList: TList;
    m_ItemPriceList: TList;

    m_UpgradeWeaponList: TList;
    m_boCanMove: Boolean;
    m_dwMoveTime: LongWord;
    m_dwMoveTick: LongWord;
    m_boBuy: Boolean;
    m_boSell: Boolean;
    m_boMakeDrug: Boolean;
    m_boPrices: Boolean;
    m_boStorage: Boolean;
    m_boGetback: Boolean;
    m_boBigStorage: Boolean;
    m_boBigGetBack: Boolean;

    m_boUserLevelOrder: Boolean;
    m_boWarrorLevelOrder: Boolean;
    m_boWizardLevelOrder: Boolean;
    m_boTaoistLevelOrder: Boolean;
    m_boMasterCountOrder: Boolean;

    m_boGetNextPage: Boolean;
    m_boGetPreviousPage: Boolean;
    m_boCqFirHero: Boolean;
    m_boUpgradeItem: Boolean;
    m_boAppDuel: Boolean;

    m_boUpgradenow: Boolean;
    m_boGetBackupgnow: Boolean;
    m_boRepair: Boolean;
    m_boS_repair: Boolean;
    m_boSendmsg: Boolean;
    m_boGetMarry: Boolean;
    m_boGetMaster: Boolean;
    m_boUseItemName: Boolean;

    m_boGetSellGold: Boolean;
    m_boSellOff: Boolean;
    m_boBuyOff: Boolean;
    m_boofflinemsg: Boolean;
    m_boDealGold: Boolean;
  private
    procedure ClearExpreUpgradeListData();
    function GetRefillList(nIndex: Integer): TList;
    procedure AddItemPrice(nIndex, nPrice: Integer);
    function GetSellItemPrice(nPrice: Integer): Integer;
    function AddItemToGoodsList(UserItem: pTUserItem): Boolean;
    procedure GetBackupgWeapon(User: TPlayObject);
    procedure UpgradeWapon(User: TPlayObject);
    procedure ChangeUseItemName(PlayObject: TPlayObject; sLabel, sItemName: string);
    procedure SaveUpgradingList;
    procedure GetMarry(PlayObject: TPlayObject; sDearName: string);
    procedure GetMaster(PlayObject: TPlayObject; sMasterName: string);
  public
    constructor Create(); override;
    destructor Destroy; override;
    function GetItemPrice(nIndex: Integer): Integer;
    function GetUserPrice(PlayObject: TPlayObject; nPrice: Integer): Integer;
    function CheckItemType(nStdMode: Integer): Boolean;
    procedure CheckItemPrice(nIndex: Integer);
    function GetUserItemPrice(UserItem: pTUserItem): Integer;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure Run; override;
    procedure UserSelect(PlayObject: TPlayObject; sData: string); override;
    procedure LoadNPCData();
    procedure SaveNPCData();
    procedure LoadUpgradeList();
    procedure RefillGoods();
    procedure LoadNpcScript();
    procedure Click(PlayObject: TPlayObject; sLabel: string = ''); override;
    procedure ClearScript(); override;
    procedure ClearData();
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string); override; //FFE9
    procedure ClientBuyItem(PlayObject: TPlayObject; sItemName: string; nInt: Integer);
    procedure ClientGetDetailGoodsList(PlayObject: TPlayObject; sItemName: string; nInt: Integer);
    procedure ClientQuerySellPrice(PlayObject: TPlayObject; UserItem: pTUserItem);
    function ClientSellItem(PlayObject: TPlayObject; UserItem: pTUserItem): Boolean;
    procedure ClientMakeDrugItem(PlayObject: TPlayObject; sItemName: string);
    procedure ClientQueryRepairCost(PlayObject: TPlayObject; UserItem: pTUserItem);
    function ClientRepairItem(PlayObject: TPlayObject; UserItem: pTUserItem): Boolean;
    procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); override;

    procedure ClientGetDetailSellGoodsList(PlayObject: TPlayObject; sItemName: string; nInt: Integer); //004A26F0
    function ClientSellOffItem(PlayObject: TPlayObject; UserItem: pTUserItem; nSellGold: Integer): Boolean; //004A1CD8
    procedure ClientBuySellOffItem(PlayObject: TPlayObject; sItemName: string; nInt: Integer); //004A2334
  end;
  TGuildOfficial = class(TNormNpc)
  private
    function ReQuestBuildGuild(PlayObject: TPlayObject;
      sGuildName: string): Integer;
    function ReQuestGuildWar(PlayObject: TPlayObject;
      sGuildName: string): Integer;
    procedure DoNate(PlayObject: TPlayObject);
    procedure ReQuestCastleWar(PlayObject: TPlayObject; sIndex: string);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string); override; //FFE9
    procedure Run; override; //FFFB
    procedure Click(PlayObject: TPlayObject; sLabel: string = ''); override; //FFEB
    procedure UserSelect(PlayObject: TPlayObject; sData: string); override; //FFEA
    procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); override;
  end;
  TTrainer = class(TNormNpc) //0x574
    n564: Integer;
    m_dw568: LongWord;
    n56C: Integer;
    n570: Integer;
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure Run; override;
  end;
  //  TCastleManager = class(TMerchant)
  TCastleOfficial = class(TMerchant)
  private
    procedure HireArcher(sIndex: string; PlayObject: TPlayObject);
    procedure HireGuard(sIndex: string; PlayObject: TPlayObject);
    procedure RepairDoor(PlayObject: TPlayObject);
    procedure RepairWallNow(nWallIndex: Integer; PlayObject: TPlayObject);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Click(PlayObject: TPlayObject; sLabel: string = ''); override;
    procedure UserSelect(PlayObject: TPlayObject; sData: string); override;
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string); override;
    procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); override;
  end;
implementation

uses Castle, M2Share, HUtil32, LocalDB, Envir, Guild, EncryptUnit, ObjMon2,
  Event, PlugIn, ObjHero, ObjRobot, UsrEngn, Common;

//===============================TQuestConditionInfo============================

procedure TScriptObject.Clear;
begin
  SetLength(ScriptCmd, 0);
  SetLength(ScriptList, 0);
end;

function TScriptObject.GetActorObject(NPC: TNormNpc; PlayObject: TPlayObject): TActorObject;
var
  I: Integer;
  sCharName: string;
  OnlineUser: TPlayObject;
  ActorObject: TActorObject;
  sVar1, sValue1: string;
  nValue1: Integer;
  VarInfo1: TVarInfo;
begin
  if Length(ScriptCmd) <= 1 then begin
    Result := PlayObject;
  end else begin
    ActorObject := PlayObject;
    for I := 0 to Length(ScriptCmd) - 1 do begin
      case ScriptCmd[I] of
        CMD_RACE_0: begin //self
            ActorObject := PlayObject;
          end;
        CMD_RACE_1: begin //hero
            if (ActorObject <> nil) and (ActorObject.m_btRaceServer = RC_PLAYOBJECT) then begin
              ActorObject := TPlayObject(ActorObject).m_MyHero;
            end else begin
              ActorObject := nil;
              Break;
            end;
          end;
        CMD_RACE_2: begin //Master
            if (ActorObject <> nil) then begin
              ActorObject := ActorObject.m_Master;
            end else begin
              ActorObject := nil;
              Break;
            end;
          end;
        CMD_RACE_3: begin //mon
            if (ActorObject <> nil) then begin
              ActorObject := ActorObject.m_KillTargetCret;
            end else begin
              ActorObject := nil;
              Break;
            end;
          end;
        CMD_RACE_4: begin //obj
            if (ActorObject <> nil) then begin
              if (ActorObject.m_btRaceServer = RC_PLAYOBJECT) then begin
                VarInfo1 := NPC.GetVarValue(TPlayObject(ActorObject), ScriptList[I], sVar1, sValue1, nValue1);
                sCharName := sValue1;
              end else sCharName := ScriptList[I];
              //if not NPC.GetValValue(ActorObject, ScriptList[I], sCharName) then sCharName := ScriptList[I];
              ActorObject := UserEngine.GetPlayObject(sCharName);
            end else begin
              ActorObject := nil;
              Break;
            end;
          end;
      else break;
      end;
    end;
    Result := ActorObject;
  end;
end;

function TScriptObject.Cmd(sCmd: string): string;
var
  TempList: TStringList;
  sCheckType: string;
  I: Integer;
begin
  SetLength(ScriptCmd, 0);
  SetLength(ScriptList, 0);
  Result := sCmd;
  if Pos('.', sCmd) > 0 then begin
    TempList := TStringList.Create;
    ExtractStrings(['.'], [], PChar(sCmd), TempList);
    Result := UpperCase(Trim(TempList.Strings[TempList.Count - 1]));
    TempList.Delete(TempList.Count - 1);
    TempList.Strings[0] := UpperCase(Trim(TempList.Strings[0]));
    if TempList.Strings[0] <> 'SELF' then TempList.Insert(0, 'SELF');
    SetLength(ScriptCmd, TempList.Count);
    SetLength(ScriptList, TempList.Count);
    for I := 0 to TempList.Count - 1 do begin
      if UpperCase(Trim(TempList.Strings[I])) = 'SELF' then begin
        ScriptCmd[I] := CMD_RACE_0;
      end else
        if UpperCase(Trim(TempList.Strings[I])) = 'HERO' then begin
        ScriptCmd[I] := CMD_RACE_1;
      end else
        if UpperCase(Trim(TempList.Strings[I])) = 'MASTER' then begin
        ScriptCmd[I] := CMD_RACE_2;
      end else
        if UpperCase(Trim(TempList.Strings[I])) = 'MON' then begin
        ScriptCmd[I] := CMD_RACE_3;
      end else begin
        ScriptCmd[I] := CMD_RACE_4;
      end;
      ScriptList[I] := UpperCase(Trim(TempList.Strings[I]));
    end;
    TempList.Free;
  end else begin
    SetLength(ScriptCmd, 1);
    ScriptCmd[0] := CMD_RACE_0;
  end;
end;


procedure TCastleOfficial.Click(PlayObject: TPlayObject; sLabel: string);
begin
  if m_Castle = nil then begin
    PlayObject.SysMsg('NPC not part of a Castle!', c_Red, t_Hint);
    Exit;
  end;
  if TUserCastle(m_Castle).IsMasterGuild(TGUild(PlayObject.m_MyGuild)) or (PlayObject.m_btPermission >= 3) then
    inherited;
end;

procedure TCastleOfficial.GetVariableText(PlayObject: TPlayObject;
  var sMsg: string; sVariable: string);
var
  I: Integer;
  sText: string;
  CastleDoor: TCastleDoor;
  List: TStringList;
begin
  inherited;
  if m_Castle = nil then begin
    sMsg := '????';
    Exit;
  end;
  if sVariable = '$CASTLEGOLD' then begin
    sText := IntToStr(TUserCastle(m_Castle).m_nTotalGold);
    sMsg := sub_49ADB8(sMsg, '<$CASTLEGOLD>', sText);
  end else
    if sVariable = '$TODAYINCOME' then begin
    sText := IntToStr(TUserCastle(m_Castle).m_nTodayIncome);
    sMsg := sub_49ADB8(sMsg, '<$TODAYINCOME>', sText);
  end else
    if sVariable = '$CASTLEDOORSTATE' then begin
    CastleDoor := TCastleDoor(TUserCastle(m_Castle).m_MainDoor.ActorObject);
    if CastleDoor.m_boDeath then sText := '损坏'
    else if CastleDoor.m_boOpened then sText := '开启'
    else sText := '关闭';
    sMsg := sub_49ADB8(sMsg, '<$CASTLEDOORSTATE>', sText);
  end else
    if sVariable = '$REPAIRDOORGOLD' then begin
    sText := IntToStr(g_Config.nRepairDoorPrice);
    sMsg := sub_49ADB8(sMsg, '<$REPAIRDOORGOLD>', sText);
  end else
    if sVariable = '$REPAIRWALLGOLD' then begin
    sText := IntToStr(g_Config.nRepairWallPrice);
    sMsg := sub_49ADB8(sMsg, '<$REPAIRWALLGOLD>', sText);
  end else
    if sVariable = '$GUARDFEE' then begin
    sText := IntToStr(g_Config.nHireGuardPrice);
    sMsg := sub_49ADB8(sMsg, '<$GUARDFEE>', sText);
  end else
    if sVariable = '$ARCHERFEE' then begin
    sText := IntToStr(g_Config.nHireArcherPrice);
    sMsg := sub_49ADB8(sMsg, '<$ARCHERFEE>', sText);
  end else
    if sVariable = '$GUARDRULE' then begin
    sText := '无效';
    sMsg := sub_49ADB8(sMsg, '<$GUARDRULE>', sText);
  end;
end;

procedure TCastleOfficial.UserSelect(PlayObject: TPlayObject; sData: string);
var
  s18, s20, sMsg, sLabel: string;
  boCanJmp: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TCastleManager::UserSelect... ';
begin
  inherited;
  try
    //    PlayObject.m_nScriptGotoCount:=0;
    if m_Castle = nil then begin
      PlayObject.SysMsg('NPC not part of a Castle!', c_Red, t_Hint);
      Exit;
    end;
    if (sData <> '') and (sData[1] = '@') then begin
      sMsg := GetValidStr3(sData, sLabel, [#13]);
      s18 := '';
      PlayObject.m_sScriptLable := sData;
      if TUserCastle(m_Castle).IsMasterGuild(TGUild(PlayObject.m_MyGuild)) and (PlayObject.IsGuildMaster) then begin
        boCanJmp := PlayObject.LableIsCanJmp(sLabel);
        if CompareText(sLabel, sSL_SENDMSG) = 0 then begin
          if sMsg = '' then Exit;
        end;
        GotoLable(PlayObject, sLabel, not boCanJmp);
        //GotoLable(PlayObject,sLabel,not PlayObject.LableIsCanJmp(sLabel));
        if not boCanJmp then Exit;
        if CompareText(sLabel, sSL_SENDMSG) = 0 then begin
          SendCustemMsg(PlayObject, sMsg);
          PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
        end else
          if CompareText(sLabel, sCASTLENAME) = 0 then begin
          sMsg := Trim(sMsg);
          if sMsg <> '' then begin
            TUserCastle(m_Castle).m_sName := sMsg;
            TUserCastle(m_Castle).Save;
            TUserCastle(m_Castle).m_MasterGuild.RefMemberName;
            s18 := '城堡名称更改成功...';
          end else begin
            s18 := '城堡名称更改失败！！！';
          end;
          PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
        end else
          if CompareText(sLabel, sWITHDRAWAL) = 0 then begin
          case TUserCastle(m_Castle).WithDrawalGolds(PlayObject, Str_ToInt(sMsg, 0)) of
            -4: s18 := '输入的金币数不正确！！！';
            -3: s18 := '您无法携带更多的东西了。';
            -2: s18 := '该城内没有这么多金币.';
            -1: s18 := '只有行会 ' + TUserCastle(m_Castle).m_sOwnGuild + ' 的掌门人才能使用！！！';
            1: GotoLable(PlayObject, sMAIN, False);
          end;
          PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
        end else
          if CompareText(sLabel, sRECEIPTS) = 0 then begin
          case TUserCastle(m_Castle).ReceiptGolds(PlayObject, Str_ToInt(sMsg, 0)) of
            -4: s18 := '输入的金币数不正确！！！';
            -3: s18 := '你已经达到在城内存放货物的限制了。';
            -2: s18 := '你没有那么多金币.';
            -1: s18 := '只有行会 ' + TUserCastle(m_Castle).m_sOwnGuild + ' 的掌门人才能使用！！！';
            1: GotoLable(PlayObject, sMAIN, False);
          end;
          PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
        end else
          if CompareText(sLabel, sOPENMAINDOOR) = 0 then begin
          TUserCastle(m_Castle).MainDoorControl(False);
        end else
          if CompareText(sLabel, sCLOSEMAINDOOR) = 0 then begin
          TUserCastle(m_Castle).MainDoorControl(True);
        end else
          if CompareText(sLabel, sREPAIRDOORNOW) = 0 then begin
          RepairDoor(PlayObject);
          GotoLable(PlayObject, sMAIN, False);
        end else
          if CompareText(sLabel, sREPAIRWALLNOW1) = 0 then begin
          RepairWallNow(1, PlayObject);
          GotoLable(PlayObject, sMAIN, False);
        end else
          if CompareText(sLabel, sREPAIRWALLNOW2) = 0 then begin
          RepairWallNow(2, PlayObject);
          GotoLable(PlayObject, sMAIN, False);
        end else
          if CompareText(sLabel, sREPAIRWALLNOW3) = 0 then begin
          RepairWallNow(3, PlayObject);
          GotoLable(PlayObject, sMAIN, False);
        end else
          if CompareLStr(sLabel, sHIREGUARDNOW, Length(sHIREGUARDNOW)) then begin
          s20 := Copy(sLabel, Length(sHIREGUARDNOW) + 1, Length(sLabel));
          HireGuard(s20, PlayObject);
          PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, '');
          //GotoLable(PlayObject,sHIREGUARDOK,False);
        end else
          if CompareLStr(sLabel, sHIREARCHERNOW, Length(sHIREARCHERNOW)) then begin
          s20 := Copy(sLabel, Length(sHIREARCHERNOW) + 1, Length(sLabel));
          HireArcher(s20, PlayObject);
          PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, '');
        end else
          if CompareText(sLabel, sEXIT) = 0 then begin
          PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self), 0, 0, '');
        end else
          if CompareText(sLabel, sBACK) = 0 then begin
          if PlayObject.m_sScriptGoBackLable = '' then PlayObject.m_sScriptGoBackLable := sMAIN;
          GotoLable(PlayObject, PlayObject.m_sScriptGoBackLable, False);
        end;
      end else begin
        s18 := '你没有权利使用';
        PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
  //  inherited;
end;

procedure TCastleOfficial.HireGuard(sIndex: string; PlayObject: TPlayObject);
var
  n10: Integer;
  ObjUnit: pTObjUnit;
begin
  if m_Castle = nil then begin
    PlayObject.SysMsg('NPC is not part of a Castle', c_Red, t_Hint);
    Exit;
  end;
  if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nHireGuardPrice then begin
    n10 := Str_ToInt(sIndex, 0) - 1;
    if n10 <= MAXCALSTEGUARD then begin
      if TUserCastle(m_Castle).m_Guard[n10].ActorObject = nil then begin
        if not TUserCastle(m_Castle).m_boUnderWar then begin
          ObjUnit := @TUserCastle(m_Castle).m_Guard[n10];
          ObjUnit.ActorObject := UserEngine.RegenMonsterByName(nil, TUserCastle(m_Castle).m_sMapName,
            ObjUnit.nX,
            ObjUnit.nY,
            ObjUnit.sName);
          if ObjUnit.ActorObject <> nil then begin
            Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nHireGuardPrice);
            ObjUnit.ActorObject.m_Castle := TUserCastle(m_Castle);
            TGuardUnit(ObjUnit.ActorObject).m_nX550 := ObjUnit.nX;
            TGuardUnit(ObjUnit.ActorObject).m_nY554 := ObjUnit.nY;
            TGuardUnit(ObjUnit.ActorObject).m_nDirection := 3;
            PlayObject.SysMsg('Guard hired.', c_Green, t_Hint);
          end;
        end else begin
          PlayObject.SysMsg('Unable to hire!', c_Red, t_Hint);
        end;
      end
    end else begin
      PlayObject.SysMsg('Command error', c_Red, t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('Insufficient funds', c_Red, t_Hint);
  end;
  {
  if UserCastle.m_nTotalGold >= g_Config.nHireGuardPrice then begin
    n10:=Str_ToInt(sIndex,0) - 1;
    if n10 <= MAXCALSTEGUARD then begin
      if UserCastle.m_Guard[n10].BaseObject = nil then begin
        if not UserCastle.m_boUnderWar then begin
          ObjUnit:=@UserCastle.m_Guard[n10];
          ObjUnit.BaseObject:=UserEngine.RegenMonsterByName(UserCastle.m_sMapName,
                                                          ObjUnit.nX,
                                                          ObjUnit.nY,
                                                          ObjUnit.sName);
          if ObjUnit.BaseObject <> nil then begin
            Dec(UserCastle.m_nTotalGold,g_Config.nHireGuardPrice);
            ObjUnit.BaseObject.m_Castle:=UserCastle;
            TGuardUnit(ObjUnit.BaseObject).m_nX550:=ObjUnit.nX;
            TGuardUnit(ObjUnit.BaseObject).m_nY554:=ObjUnit.nY;
            TGuardUnit(ObjUnit.BaseObject).m_n558:=3;
            PlayObject.SysMsg('雇佣成功.',c_Green,t_Hint);
          end;

        end else begin
          PlayObject.SysMsg('现在无法雇佣！！！',c_Red,t_Hint);
        end;
      end
    end else begin
      PlayObject.SysMsg('指令错误！！！',c_Red,t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('城内资金不足！！！',c_Red,t_Hint);
  end;
  }
end;

procedure TCastleOfficial.HireArcher(sIndex: string; PlayObject: TPlayObject);
var
  n10: Integer;
  ObjUnit: pTObjUnit;
begin
  if m_Castle = nil then begin
    PlayObject.SysMsg('NPC not part of a Castle!', c_Red, t_Hint);
    Exit;
  end;
  if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nHireArcherPrice then begin
    n10 := Str_ToInt(sIndex, 0) - 1;
    if n10 <= MAXCASTLEARCHER then begin
      if TUserCastle(m_Castle).m_Archer[n10].ActorObject = nil then begin
        if not TUserCastle(m_Castle).m_boUnderWar then begin
          ObjUnit := @TUserCastle(m_Castle).m_Archer[n10];
          ObjUnit.ActorObject := UserEngine.RegenMonsterByName(nil, TUserCastle(m_Castle).m_sMapName,
            ObjUnit.nX,
            ObjUnit.nY,
            ObjUnit.sName);
          if ObjUnit.ActorObject <> nil then begin
            Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nHireArcherPrice);
            ObjUnit.ActorObject.m_Castle := TUserCastle(m_Castle);
            TGuardUnit(ObjUnit.ActorObject).m_nX550 := ObjUnit.nX;
            TGuardUnit(ObjUnit.ActorObject).m_nY554 := ObjUnit.nY;
            TGuardUnit(ObjUnit.ActorObject).m_nDirection := 3;
            PlayObject.SysMsg('Archer hired.', c_Green, t_Hint);
          end;
        end else begin
          PlayObject.SysMsg('Unable to hire.', c_Red, t_Hint);
        end;
      end else begin
        PlayObject.SysMsg('Unable to hire.', c_Red, t_Hint);
      end;
    end else begin
      PlayObject.SysMsg('Command error.', c_Red, t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('Insufficient funds', c_Red, t_Hint);
  end;
  {
  if UserCastle.m_nTotalGold >= g_Config.nHireArcherPrice then begin
    n10:=Str_ToInt(sIndex,0) - 1;
    if n10 <= MAXCASTLEARCHER then begin
      if UserCastle.m_Archer[n10].BaseObject = nil then begin
        if not UserCastle.m_boUnderWar then begin
          ObjUnit:=@UserCastle.m_Archer[n10];
          ObjUnit.BaseObject:=UserEngine.RegenMonsterByName(UserCastle.m_sMapName,
                                                          ObjUnit.nX,
                                                          ObjUnit.nY,
                                                          ObjUnit.sName);
          if ObjUnit.BaseObject <> nil then begin
            Dec(UserCastle.m_nTotalGold,g_Config.nHireArcherPrice);
            ObjUnit.BaseObject.m_Castle:=UserCastle;
            TGuardUnit(ObjUnit.BaseObject).m_nX550:=ObjUnit.nX;
            TGuardUnit(ObjUnit.BaseObject).m_nY554:=ObjUnit.nY;
            TGuardUnit(ObjUnit.BaseObject).m_n558:=3;
            PlayObject.SysMsg('雇佣成功.',c_Green,t_Hint);
          end;

        end else begin
          PlayObject.SysMsg('现在无法雇佣！！！',c_Red,t_Hint);
        end;
      end else begin
        PlayObject.SysMsg('早已雇佣！！！',c_Red,t_Hint);
      end;
    end else begin
      PlayObject.SysMsg('指令错误！！！',c_Red,t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('城内资金不足！！！',c_Red,t_Hint);
  end;
  }
end;
{ TMerchant }

procedure TMerchant.AddItemPrice(nIndex: Integer; nPrice: Integer);
var
  ItemPrice: pTItemPrice;
begin
  New(ItemPrice);
  ItemPrice.wIndex := nIndex;
  ItemPrice.nPrice := nPrice;
  m_ItemPriceList.Add(ItemPrice);
  FrmDB.SaveGoodPriceRecord(Self, m_sScript + '-' + m_sMapName);
end;

procedure TMerchant.CheckItemPrice(nIndex: Integer);
var
  I: Integer;
  ItemPrice: pTItemPrice;
  n10: Integer;
  StdItem: pTStdItem;
begin
  for I := 0 to m_ItemPriceList.Count - 1 do begin
    ItemPrice := m_ItemPriceList.Items[I];
    if ItemPrice.wIndex = nIndex then begin
      n10 := ItemPrice.nPrice;
      if Round(n10 * 1.1) > n10 then begin
        n10 := Round(n10 * 1.1);
      end else Inc(n10);
      Exit;
    end;
  end;
  StdItem := UserEngine.GetStdItem(nIndex);
  if StdItem <> nil then begin
    AddItemPrice(nIndex, Round(StdItem.Price * 1.1));
  end;
end;

function TMerchant.GetRefillList(nIndex: Integer): TList;
var
  I: Integer;
  List: TList;
begin
  Result := nil;
  if nIndex <= 0 then Exit;
  for I := 0 to m_GoodsList.Count - 1 do begin
    List := TList(m_GoodsList.Items[I]);
    if List = nil then Continue;
    if List.Count > 0 then begin
      if pTUserItem(List.Items[0]).wIndex = nIndex then begin
        Result := List;
        Break;
      end;
    end;
  end;
end;

procedure TMerchant.RefillGoods;
  procedure RefillItems(var List: TList; sItemName: string; nInt: Integer);
  var
    I: Integer;
    UserItem: pTUserItem;
  begin
    if List = nil then begin
      List := TList.Create;
      m_GoodsList.Add(List);
    end;
    for I := 0 to nInt - 1 do begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
        List.Insert(0, UserItem);
      end else Dispose(UserItem);
    end;
  end;
  procedure DelReFillItem(var List: TList; nInt: Integer);
  var
    I: Integer;
  begin
    for I := List.Count - 1 downto 0 do begin
      if nInt <= 0 then Break;
      if pTUserItem(List.Items[I]) <> nil then begin
        Dispose(pTUserItem(List.Items[I]));
      end;
      List.Delete(I);
      Dec(nInt);
    end;
  end;
var
  I, II: Integer;
  Goods: pTGoods;
  nIndex, nRefillCount: Integer;
  RefillList, RefillList20: TList;
  bo21: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TMerchant::RefillGoods %s/%d:%d [%s] Code:%d';
begin
  try
    for I := 0 to m_RefillGoodsList.Count - 1 do begin
      Goods := m_RefillGoodsList.Items[I];
      if Goods = nil then Continue;
      if (GetTickCount - Goods.dwRefillTick) > Goods.dwRefillTime * 60 * 1000 then begin
        Goods.dwRefillTick := GetTickCount();
        nIndex := UserEngine.GetStdItemIdx(Goods.sItemName);
        if nIndex >= 0 then begin
          RefillList := GetRefillList(nIndex);
          nRefillCount := 0;
          if RefillList <> nil then nRefillCount := RefillList.Count;
          if Goods.nCount > nRefillCount then begin
            CheckItemPrice(nIndex);
            RefillItems(RefillList, Goods.sItemName, Goods.nCount - nRefillCount);
            FrmDB.SaveGoodRecord(Self, m_sScript + '-' + m_sMapName);
            FrmDB.SaveGoodPriceRecord(Self, m_sScript + '-' + m_sMapName);
          end;
          if Goods.nCount < nRefillCount then begin
            DelReFillItem(RefillList, nRefillCount - Goods.nCount);
            FrmDB.SaveGoodRecord(Self, m_sScript + '-' + m_sMapName);
            FrmDB.SaveGoodPriceRecord(Self, m_sScript + '-' + m_sMapName);
          end;
        end;
      end;
    end;
    for I := 0 to m_GoodsList.Count - 1 do begin
      RefillList20 := TList(m_GoodsList.Items[I]);
      if RefillList20 = nil then Continue;
      if RefillList20.Count > 1000 then begin
        bo21 := False;
        for II := 0 to m_RefillGoodsList.Count - 1 do begin
          Goods := m_RefillGoodsList.Items[II];
          if Goods = nil then Continue;
          nIndex := UserEngine.GetStdItemIdx(Goods.sItemName);
          if (pTItemPrice(RefillList20.Items[0]) <> nil) and (pTItemPrice(RefillList20.Items[0]).wIndex = nIndex) then begin
            bo21 := True;
            Break;
          end;
        end;
        if not bo21 then begin
          DelReFillItem(RefillList20, RefillList20.Count - 1000);
        end else begin
          DelReFillItem(RefillList20, RefillList20.Count - 5000);
        end;
      end;
    end;
  except
    on E: Exception do
      MainOutMessage(Format(sExceptionMsg, [m_sCharName, m_nCurrX, m_nCurrY, E.Message, nCHECK]));
  end;
end;

function TMerchant.CheckItemType(nStdMode: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to m_ItemTypeList.Count - 1 do begin
    if Integer(m_ItemTypeList.Items[I]) = nStdMode then begin
      Result := True;
      Break;
    end;
  end;
end;

function TMerchant.GetItemPrice(nIndex: Integer): Integer;
var
  I: Integer;
  ItemPrice: pTItemPrice;
  StdItem: pTStdItem;
begin
  Result := -1;
  for I := 0 to m_ItemPriceList.Count - 1 do begin
    ItemPrice := m_ItemPriceList.Items[I];
    if ItemPrice.wIndex = nIndex then begin
      Result := ItemPrice.nPrice;
      Break;
    end;
  end; // for
  if Result < 0 then begin
    StdItem := UserEngine.GetStdItem(nIndex);
    if StdItem <> nil then begin
      if CheckItemType(StdItem.StdMode) then
        Result := StdItem.Price;
    end;
  end;
end;

procedure TMerchant.SaveUpgradingList();
begin
  try
    //FrmDB.SaveUpgradeWeaponRecord(m_sCharName,m_UpgradeWeaponList);
    FrmDB.SaveUpgradeWeaponRecord(m_sScript + '-' + m_sMapName, m_UpgradeWeaponList);
  except
    MainOutMessage('Failure in saving upgradinglist - ' + m_sCharName);
  end;
end;

procedure TMerchant.UpgradeWapon(User: TPlayObject);
  procedure sub_4A0218(ItemList: TList; var btDc: Byte; var btSc: Byte; var btMc: Byte; var btDura: Byte);
  var
    I, II: Integer;
    DuraList: TList;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    StdItem80: TStdItem;
    DelItemList: TStringList;
    nDc, nSc, nMc, nDcMin, nDcMax, nScMin, nScMax, nMcMin, nMcMax, nDura, nItemCount: Integer;
  begin
    nDcMin := 0;
    nDcMax := 0;
    nScMin := 0;
    nScMax := 0;
    nMcMin := 0;
    nMcMax := 0;
    nDura := 0;
    nItemCount := 0;
    DelItemList := nil;
    DuraList := TList.Create;
    for I := ItemList.Count - 1 downto 0 do begin
      UserItem := ItemList.Items[I];
      if UserEngine.GetStdItemName(UserItem.wIndex) = g_Config.sBlackStone then begin
        DuraList.Add(Pointer(Round(UserItem.Dura / 1.0E3)));
        if DelItemList = nil then DelItemList := TStringList.Create;
        DelItemList.AddObject(g_Config.sBlackStone, TObject(UserItem.MakeIndex));
        ItemList.Delete(I);
        Dispose(UserItem);
      end else begin
        if IsUseItem(UserItem.wIndex) then begin
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem <> nil then begin
            StdItem80 := StdItem^;
            ItemUnit.GetItemAddValue(UserItem, StdItem80);
            nDc := 0;
            nSc := 0;
            nMc := 0;
            case StdItem80.StdMode of
              19, 20, 21: begin //004A0421
                  nDc := HiWord(StdItem80.DC) + LoWord(StdItem80.DC);
                  nSc := HiWord(StdItem80.SC) + LoWord(StdItem80.SC);
                  nMc := HiWord(StdItem80.MC) + LoWord(StdItem80.MC);
                end;
              22, 23: begin //004A046E
                  nDc := HiWord(StdItem80.DC) + LoWord(StdItem80.DC);
                  nSc := HiWord(StdItem80.SC) + LoWord(StdItem80.SC);
                  nMc := HiWord(StdItem80.MC) + LoWord(StdItem80.MC);
                end;
              24, 26: begin
                  nDc := HiWord(StdItem80.DC) + LoWord(StdItem80.DC) + 1;
                  nSc := HiWord(StdItem80.SC) + LoWord(StdItem80.SC) + 1;
                  nMc := HiWord(StdItem80.MC) + LoWord(StdItem80.MC) + 1;
                end;
            end;
            if nDcMin < nDc then begin
              nDcMax := nDcMin;
              nDcMin := nDc;
            end else begin
              if nDcMax < nDc then nDcMax := nDc;
            end;
            if nScMin < nSc then begin
              nScMax := nScMin;
              nScMin := nSc;
            end else begin
              if nScMax < nSc then nScMax := nSc;
            end;
            if nMcMin < nMc then begin
              nMcMax := nMcMin;
              nMcMin := nMc;
            end else begin
              if nMcMax < nMc then nMcMax := nMc;
            end;
            if DelItemList = nil then DelItemList := TStringList.Create;
            DelItemList.AddObject(StdItem.Name, TObject(UserItem.MakeIndex));
            //004A06DB
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('26' + #9 +
                User.m_sMapName + #9 +
                IntToStr(User.m_nCurrX) + #9 +
                IntToStr(User.m_nCurrY) + #9 +
                User.m_sCharName + #9 +
                //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                StdItem.Name + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                '0');
            Dispose(UserItem);
            ItemList.Delete(I);
          end;
        end;
      end;
    end; // for
    for I := 0 to DuraList.Count - 1 do begin
      if DuraList.Count <= 0 then Break;
      for II := DuraList.Count - 1 downto I + 1 do begin
        if Integer(DuraList.Items[II]) > Integer(DuraList.Items[II - 1]) then
          DuraList.Exchange(II, II - 1);
      end; // for
    end; // for
    for I := 0 to DuraList.Count - 1 do begin
      nDura := nDura + Integer(DuraList.Items[I]);
      Inc(nItemCount);
      if nItemCount >= 5 then Break;
    end;
    btDura := Round(_MIN(5, nItemCount) + _MIN(5, nItemCount) * ((nDura / nItemCount) / 5.0));
    btDc := nDcMin div 5 + nDcMax div 3;
    btSc := nScMin div 5 + nScMax div 3;
    btMc := nMcMin div 5 + nMcMax div 3;
    if DelItemList <> nil then
      User.SendMsg(Self, RM_SENDDELITEMLIST, 0, Integer(DelItemList), 0, 0, '');
    if DuraList <> nil then DuraList.Free;
  end;
var
  I: Integer;
  bo0D: Boolean;
  UpgradeInfo: pTUpgradeInfo;
  StdItem: pTStdItem;
  sCheckItemName: string;
begin
  bo0D := False;
  for I := 0 to m_UpgradeWeaponList.Count - 1 do begin
    UpgradeInfo := m_UpgradeWeaponList.Items[I];
    if UpgradeInfo.sUserName = User.m_sCharName then begin
      GotoLable(User, sUPGRADEING, False);
      Exit;
    end;
  end;

  if Assigned(PlugInEngine.CheckCanUpgradeItem) then begin //禁止升级
    sCheckItemName := UserEngine.GetStdItemName(User.m_UseItems[U_WEAPON].wIndex);
    if PlugInEngine.CheckCanUpgradeItem(User, PChar(sCheckItemName), True) then begin
      Exit;
    end;
  end;

  if (User.m_UseItems[U_WEAPON].wIndex <> 0) and (User.m_nGold >= g_Config.nUpgradeWeaponPrice) and
    (User.CheckItems(g_Config.sBlackStone) <> nil) then begin
    User.DecGold(g_Config.nUpgradeWeaponPrice);
    //    if m_boCastle or g_Config.boGetAllNpcTax then UserCastle.IncRateGold(g_Config.nUpgradeWeaponPrice);
    if m_boCastle or g_Config.boGetAllNpcTax then begin
      if m_Castle <> nil then begin
        TUserCastle(m_Castle).IncRateGold(g_Config.nUpgradeWeaponPrice);
      end else
        if g_Config.boGetAllNpcTax then begin
        g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
      end;
    end;
    User.GoldChanged();
    New(UpgradeInfo);
    UpgradeInfo.sUserName := User.m_sCharName;
    UpgradeInfo.UserItem := User.m_UseItems[U_WEAPON];
    StdItem := UserEngine.GetStdItem(User.m_UseItems[U_WEAPON].wIndex);

    if StdItem.NeedIdentify = 1 then
      AddGameDataLog('25' + #9 +
        User.m_sMapName + #9 +
        IntToStr(User.m_nCurrX) + #9 +
        IntToStr(User.m_nCurrY) + #9 +
        User.m_sCharName + #9 +
        //UserEngine.GetStdItemName(User.m_UseItems[U_WEAPON].wIndex) + #9 +
        StdItem.Name + #9 +
        IntToStr(User.m_UseItems[U_WEAPON].MakeIndex) + #9 +
        '1' + #9 +
        '0');
    User.SendDelItems(@User.m_UseItems[U_WEAPON]);
    User.m_UseItems[U_WEAPON].wIndex := 0;
    User.RecalcAbilitys();
    User.FeatureChanged();
    User.SendMsg(User, RM_ABILITY, 0, 0, 0, 0, '');
    sub_4A0218(User.m_ItemList, UpgradeInfo.btDc, UpgradeInfo.btSc, UpgradeInfo.btMc, UpgradeInfo.btDura);
    UpgradeInfo.dtTime := Now();
    UpgradeInfo.dwGetBackTick := GetTickCount();
    m_UpgradeWeaponList.Add(UpgradeInfo);
    SaveUpgradingList();
    bo0D := True;
  end;
  if bo0D then GotoLable(User, sUPGRADEOK, False)
  else GotoLable(User, sUPGRADEFAIL, False);
end;

procedure TMerchant.GetBackupgWeapon(User: TPlayObject);
var
  I: Integer;
  UpgradeInfo: pTUpgradeInfo;
  n10, n14, n18, n1C, n90: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  n18 := 0;
  UpgradeInfo := nil;
  if not User.IsEnoughBag then begin
    //    User.SysMsg('你的背包已经满了，无法再携带任何物品了！！！',0);
    GotoLable(User, sGETBACKUPGFULL, False);
    Exit;
  end;
  for I := m_UpgradeWeaponList.Count - 1 downto 0 do begin //for i := 0 to m_UpgradeWeaponList.Count - 1 do begin
    if m_UpgradeWeaponList.Count <= 0 then Break;
    if pTUpgradeInfo(m_UpgradeWeaponList.Items[I]).sUserName = User.m_sCharName then begin
      n18 := 1;
      if ((GetTickCount - pTUpgradeInfo(m_UpgradeWeaponList.Items[I]).dwGetBackTick) > g_Config.dwUPgradeWeaponGetBackTime) or (User.m_btPermission >= 4) then begin
        UpgradeInfo := m_UpgradeWeaponList.Items[I];
        m_UpgradeWeaponList.Delete(I);
        SaveUpgradingList();
        n18 := 2;
        Break;
      end;
    end;
  end;
  if UpgradeInfo <> nil then begin
    case UpgradeInfo.btDura of //
      0..8: begin //004A0DE5
          //       n14:=_MAX(3000,UpgradeInfo.UserItem.DuraMax shr 1);
          if UpgradeInfo.UserItem.DuraMax > 3000 then begin
            Dec(UpgradeInfo.UserItem.DuraMax, 3000);
          end else begin
            UpgradeInfo.UserItem.DuraMax := UpgradeInfo.UserItem.DuraMax shr 1;
          end;
          if UpgradeInfo.UserItem.Dura > UpgradeInfo.UserItem.DuraMax then
            UpgradeInfo.UserItem.Dura := UpgradeInfo.UserItem.DuraMax;
        end;
      9..15: begin //004A0E41
          if Random(UpgradeInfo.btDura) < 6 then begin
            if UpgradeInfo.UserItem.DuraMax > 1000 then
              Dec(UpgradeInfo.UserItem.DuraMax, 1000);
            if UpgradeInfo.UserItem.Dura > UpgradeInfo.UserItem.DuraMax then
              UpgradeInfo.UserItem.Dura := UpgradeInfo.UserItem.DuraMax;
          end;
        end;
      18..255: begin
          case Random(UpgradeInfo.btDura - 18) of
            1..4: Inc(UpgradeInfo.UserItem.DuraMax, 1000);
            5..7: Inc(UpgradeInfo.UserItem.DuraMax, 2000);
            8..255: Inc(UpgradeInfo.UserItem.DuraMax, 4000)
          end;
        end;
    end; // case
    if (UpgradeInfo.btDc = UpgradeInfo.btMc) and (UpgradeInfo.btMc = UpgradeInfo.btSc) then begin
      n1C := Random(3);
    end else begin
      n1C := -1;
    end;
    if ((UpgradeInfo.btDc >= UpgradeInfo.btMc) and (UpgradeInfo.btDc >= UpgradeInfo.btSc)) or
      (n1C = 0) then begin
      n90 := _MIN(11, UpgradeInfo.btDc);
      n10 := _MIN(85, n90 shl 3 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] - UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);
      //      n10:=_MIN(85,n90 * 8 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] - UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);

      if Random(g_Config.nUpgradeWeaponDCRate) < n10 then begin //if Random(100) < n10 then begin
        UpgradeInfo.UserItem.btValue[10] := 10;

        if (n10 > 63) and (Random(g_Config.nUpgradeWeaponDCTwoPointRate) = 0) then //if (n10 > 63) and (Random(30) = 0) then
          UpgradeInfo.UserItem.btValue[10] := 11;

        if (n10 > 79) and (Random(g_Config.nUpgradeWeaponDCThreePointRate) = 0) then //if (n10 > 79) and (Random(200) = 0) then
          UpgradeInfo.UserItem.btValue[10] := 12;
      end else UpgradeInfo.UserItem.btValue[10] := 1; //004A0F89
    end;
    if ((UpgradeInfo.btMc >= UpgradeInfo.btDc) and (UpgradeInfo.btMc >= UpgradeInfo.btSc)) or
      (n1C = 1) then begin
      n90 := _MIN(11, UpgradeInfo.btMc);
      n10 := _MIN(85, n90 shl 3 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] - UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);

      if Random(g_Config.nUpgradeWeaponMCRate) < n10 then begin //if Random(100) < n10 then begin
        UpgradeInfo.UserItem.btValue[10] := 20;

        if (n10 > 63) and (Random(g_Config.nUpgradeWeaponMCTwoPointRate) = 0) then //if (n10 > 63) and (Random(30) = 0) then
          UpgradeInfo.UserItem.btValue[10] := 21;

        if (n10 > 79) and (Random(g_Config.nUpgradeWeaponMCThreePointRate) = 0) then //if (n10 > 79) and (Random(200) = 0) then
          UpgradeInfo.UserItem.btValue[10] := 22;
      end else UpgradeInfo.UserItem.btValue[10] := 1;
    end;
    if ((UpgradeInfo.btSc >= UpgradeInfo.btMc) and (UpgradeInfo.btSc >= UpgradeInfo.btDc)) or
      (n1C = 2) then begin
      n90 := _MIN(11, UpgradeInfo.btMc);
      n10 := _MIN(85, n90 shl 3 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] - UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);

      if Random(g_Config.nUpgradeWeaponSCRate) < n10 then begin //if Random(100) < n10 then begin
        UpgradeInfo.UserItem.btValue[10] := 30;

        if (n10 > 63) and (Random(g_Config.nUpgradeWeaponSCTwoPointRate) = 0) then //if (n10 > 63) and (Random(30) = 0) then
          UpgradeInfo.UserItem.btValue[10] := 31;

        if (n10 > 79) and (Random(g_Config.nUpgradeWeaponSCThreePointRate) = 0) then //if (n10 > 79) and (Random(200) = 0) then
          UpgradeInfo.UserItem.btValue[10] := 32;
      end else UpgradeInfo.UserItem.btValue[10] := 1;
    end;
    New(UserItem);
    UserItem^ := UpgradeInfo.UserItem;
    Dispose(UpgradeInfo);
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    //004A120E
    if StdItem.NeedIdentify = 1 then
      AddGameDataLog('24' + #9 +
        User.m_sMapName + #9 +
        IntToStr(User.m_nCurrX) + #9 +
        IntToStr(User.m_nCurrY) + #9 +
        User.m_sCharName + #9 +
        //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
        StdItem.Name + #9 +
        IntToStr(UserItem.MakeIndex) + #9 +
        '1' + #9 +
        '0');
    if User.AddItemToBag(UserItem) then begin
      User.SendAddItem(UserItem);
    end else begin
      User.DropItemDown(UserItem, 3, False, User, nil);
      Dispose(UserItem);
    end;
  end;
  case n18 of //
    0: GotoLable(User, sGETBACKUPGFAIL, False);
    1: GotoLable(User, sGETBACKUPGING, False);
    2: GotoLable(User, sGETBACKUPGOK, False);
  end; // case
end;

function TMerchant.GetUserPrice(PlayObject: TPlayObject; nPrice: Integer): Integer; //0049F6E0
var
  n14: Integer;
begin
  {
  if m_boCastle then begin
    if UserCastle.IsMasterGuild(TGuild(PlayObject.m_MyGuild)) then begin
      n14:=_MAX(60,ROUND(m_nPriceRate * 8.0000000000000000001e-1));//80%
      Result:=ROUND(nPrice / 1.0e2 * n14); //100
    end else begin
      Result:=ROUND(nPrice / 1.0e2 * m_nPriceRate);
    end;
  end else begin
    Result:=ROUND(nPrice / 1.0e2 * m_nPriceRate);
  end;
  }
  if m_boCastle then begin
    //    if UserCastle.IsMasterGuild(TGuild(PlayObject.m_MyGuild)) then begin
    if (m_Castle <> nil) and TUserCastle(m_Castle).IsMasterGuild(TGUild(PlayObject.m_MyGuild)) then begin
      n14 := _MAX(60, Round(m_nPriceRate * (g_Config.nCastleMemberPriceRate / 100))); //80%
      Result := Round(nPrice / 100 * n14); //100
    end else begin
      Result := Round(nPrice / 100 * m_nPriceRate);
    end;
  end else begin
    Result := Round(nPrice / 100 * m_nPriceRate);
  end;
end;

procedure TMerchant.UserSelect(PlayObject: TPlayObject; sData: string);
  procedure SuperRepairItem(User: TPlayObject);
  begin
    User.SendMsg(Self, RM_SENDUSERSREPAIR, 0, Integer(Self), 0, 0, '');
  end;
  procedure BuyItem(User: TPlayObject; nInt: Integer);
  var
    I, n10, nStock, nPrice: Integer;
    nSubMenu: ShortInt;
    sSENDMSG, sName: string;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    List14: TList;
    sUserItemName: string;
  begin
    sSENDMSG := '';
    n10 := 0;
    for I := 0 to m_GoodsList.Count - 1 do begin
      List14 := TList(m_GoodsList.Items[I]);
      if List14 = nil then Continue;
      UserItem := List14.Items[0];
      if UserItem = nil then Continue;
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem <> nil then begin
        //取自定义物品名称
        sName := '';
        if UserItem.btValue[13] = 1 then
          sName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);

        if sName = '' then
          sName := StdItem.Name;

        if User.CheckItemBindUse(UserItem, False) = 2 then begin
          sName := '(绑)' + sName;
        end;

        nPrice := GetUserPrice(User, GetItemPrice(UserItem.wIndex));
        nStock := List14.Count;
        if (StdItem.StdMode <= 4) or
          (StdItem.StdMode = 42) or
          (StdItem.StdMode = 31) then nSubMenu := 0
        else nSubMenu := 1;
        sSENDMSG := sSENDMSG + sName + '/' + IntToStr(nSubMenu) + '/' + IntToStr(nPrice) + '/' + IntToStr(nStock) + '/';
        Inc(n10);
      end;
    end; // for
    User.SendMsg(Self, RM_SENDGOODSLIST, 0, Integer(Self), n10, 0, sSENDMSG);
  end;

  procedure BuySellItem(User: TPlayObject); //拍卖物品列表
  var
    I, n18, nStock, nSubMenu, nSellGold: Integer;
    List20: TStringList;
    s1C, sName: string;
    SellOffInfo: pTSellOffInfo;
    StdItem: pTStdItem;
    SellList: TSellList;
  begin
    s1C := '';
    n18 := 0;
    List20 := TStringList.Create;
    g_SellList.GetSellList(List20);
    for I := 0 to List20.Count - 1 do begin
      sName := List20.Strings[I];
      SellOffInfo := pTSellOffInfo(List20.Objects[I]);
      StdItem := UserEngine.GetStdItem(SellOffInfo.UserItem.wIndex);
      if StdItem <> nil then begin
        nStock := List20.Count;
        {
        if (StdItem.StdMode <= 4) or
          (StdItem.StdMode = 42) or
          (StdItem.StdMode = 31) then nSubMenu := 0
        else nSubMenu := 1;
        }
        nSubMenu := 1;
        //if (g_SellList.GetSellListByCharName(StdItem.Name, SellList) >= 0) and (SellList <> nil) then nSubMenu := 1;

        if CompareText(SellOffInfo.sCharName, User.m_sCharName) = 0 then nSellGold := -SellOffInfo.nSellGold else nSellGold := SellOffInfo.nSellGold;
        s1C := s1C + sName + '/' + IntToStr(nSubMenu) + '/' + IntToStr(nSellGold) + '/' + IntToStr(nStock) + '/';
        Inc(n18);
      end;
    end;
    User.SendMsg(Self, RM_SENDSELLOFFGOODSLIST, 0, Integer(Self), n18, 0, s1C);
    List20.Free;
  end;

  procedure GetSellGold(User: TPlayObject);
  var
    I: Integer;
    nSellGold: Integer;
    nRate: Integer;
    nSellGoldCount: Integer;
    nRateCount: Integer;
    s1C: string;
    SellOffInfo: pTSellOffInfo;
    n18: Integer;
    nIndex: Integer;
    List20: TSellList;
    bo01: Boolean;
  begin
    g_GoldList.Lock;
    try
      nSellGoldCount := 0;
      nRateCount := 0;
      s1C := '';
      nIndex := g_GoldList.GetGoldListByCharName(User.m_sCharName, List20);
      if nIndex >= 0 then begin
        for I := List20.Count - 1 downto 0 do begin
          SellOffInfo := pTSellOffInfo(List20.Objects[I]);
          if g_GoldList.UpDate(SellOffInfo, False) then begin
            if g_Config.nUserSellOffTax > 0 then begin
              nRate := SellOffInfo.nSellGold * g_Config.nUserSellOffTax div 100;
              nSellGold := SellOffInfo.nSellGold - nRate;
            end else begin
              nSellGold := SellOffInfo.nSellGold;
              nRate := 0;
            end;
            if nSellGold < 0 then nSellGold := 0;

            s1C := '物品:' + UserEngine.GetStdItemName(SellOffInfo.UserItem.wIndex) + ' 金额:' + IntToStr(nSellGold) + ' 税:' + IntToStr(nRate) + g_Config.sGameGoldName + ' 拍卖日期:' + DateTimeToStr(SellOffInfo.dSellDateTime);
            User.SysMsg(s1C, c_Green, t_Hint);
            Inc(User.m_nGameGold, nSellGold);
            Inc(nSellGoldCount, nSellGold);
            User.GameGoldChanged;
            Inc(nRateCount, nRate);
            Inc(n18);
            Dispose(SellOffInfo);
            List20.Delete(I);

            if g_boGameLogGameGold then begin
              AddGameDataLog(Format(g_sGameLogMsg1, [LOG_GAMEGOLD,
                User.m_sMapName,
                  User.m_nCurrX,
                  User.m_nCurrY,
                  User.m_sCharName,
                  g_Config.sGameGoldName,
                  nSellGold,
                  '+',
                  m_sCharName]));
            end;
          end;
        end;
        if List20.Count <= 0 then begin
          List20.Free;
          g_GoldList.Delete(nIndex);
        end;
        if n18 > 0 then begin
          s1C := '总金额:' + IntToStr(nSellGoldCount) + ' 税:' + IntToStr(nRateCount) + g_Config.sGameGoldName;
          User.SysMsg(s1C, c_Green, t_Hint);
        end;
      end;
    finally
      g_GoldList.UnLock();
    end;
  end;

  procedure RemoteMsg(User: TPlayObject; sLabel, sMsg: string); //接受歌曲
  var
    s01, s02, s03: string;
    sSENDMSG: string;
    TargetObject: TPlayObject;
  begin
    sMsg := Trim(sMsg);
    if sMsg <> '' then begin
      TargetObject := UserEngine.GetPlayObject(sMsg);
      if TargetObject <> nil then begin
        if TargetObject.m_boRemoteMsg then begin
          sLabel := Copy(sLabel, 2, Length(sLabel) - 1);
          sSENDMSG := '你的好友 ' + User.GetUnknowCharName + ' 给你发送音乐\ \<播放歌曲/' + sLabel + '>\';
          SendMsgToUser(TargetObject, sSENDMSG);
        end else begin
          User.SysMsg(sMsg + '你的好友 ' + TargetObject.GetUnknowCharName + ' 拒绝接受歌曲！！！', c_Red, t_Hint);
        end;
      end else begin
        User.SysMsg(sMsg + g_sUserNotOnLine {'  没有在线！！！'}, c_Red, t_Hint);
      end;
    end;
  end;

  procedure AutoGetExp(User: TPlayObject; sMsg: string);
  begin
    User.m_sAutoSendMsg := sMsg;
    //User.SysMsg('挂机成功！！！', c_Red, t_Hint);
  end;

  procedure DealGold(User: TPlayObject; sMsg: string);
  var
    PoseHuman: TPlayObject;
    nGameGold: Integer;
  begin
    nGameGold := Str_ToInt(sMsg, -1);
    if User.m_nDealGoldPose <> 1 then begin
      GotoLable(User, '@dealgoldPlayError', False);
      Exit;
    end;
    if nGameGold <= 0 then begin
      GotoLable(User, '@dealgoldInputFail', False);
    end else begin
      if User.m_nGameGold >= nGameGold then begin
        PoseHuman := TPlayObject(User.GetPoseCreate());
        if (PoseHuman <> nil) and (TPlayObject(PoseHuman.GetPoseCreate) = User) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) {and (PoseHuman.m_nDealGoldPose <> 1)} then begin
          User.m_nDealGoldPose := 2;
          //PoseHuman.m_nDealGoldPose := 2;
          Inc(PoseHuman.m_nGameGold, nGameGold);
          Dec(User.m_nGameGold, nGameGold);
          PoseHuman.GameGoldChanged;
          User.GameGoldChanged;
          SendMsgToUser(User, '转帐成功：' + #10 + '转出' + g_Config.sGameGoldName + '：' + IntToStr(nGameGold) + #9 + '当前' + g_Config.sGameGoldName + '：' + IntToStr(User.m_nGameGold));
          SendMsgToUser(PoseHuman, '转帐成功：' + #10 + '增加' + g_Config.sGameGoldName + '：' + IntToStr(nGameGold) + #9 + '当前' + g_Config.sGameGoldName + '：' + IntToStr(PoseHuman.m_nGameGold));
          if g_boGameLogGameGold then begin
            AddGameDataLog(Format(g_sGameLogMsg1, [LOG_GAMEGOLD,
              User.m_sMapName,
                User.m_nCurrX,
                User.m_nCurrY,
                User.m_sCharName,
                g_Config.sGameGoldName,
                nGameGold,
                '-',
                m_sCharName]));

            AddGameDataLog(Format(g_sGameLogMsg1, [LOG_GAMEGOLD,
              PoseHuman.m_sMapName,
                PoseHuman.m_nCurrX,
                PoseHuman.m_nCurrY,
                PoseHuman.m_sCharName,
                g_Config.sGameGoldName,
                nGameGold,
                '+',
                m_sCharName]));
          end;
        end else begin
          GotoLable(User, '@dealgoldpost', False);
        end;
      end else begin
        GotoLable(User, '@dealgoldFail', False);
      end;
    end;
  end;

  procedure SellItem(User: TPlayObject);
  begin
    User.SendMsg(Self, RM_SENDUSERSELL, 0, Integer(Self), 0, 0, '');
  end;
  procedure SellSellItem(User: TPlayObject);
  begin
    User.SendMsg(Self, RM_SENDUSERSELLOFFITEM, 0, Integer(Self), 0, 0, '');
  end;

  procedure RepairItem(User: TPlayObject);
  begin
    User.SendMsg(Self, RM_SENDUSERREPAIR, 0, Integer(Self), 0, 0, '');
  end;
  procedure MakeDurg(User: TPlayObject);
  var
    I: Integer;
    List14: TList;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    sSENDMSG: string;
    nSubMenu: Integer;
    nPrice: Integer;
    nStock: Integer;
  begin
    sSENDMSG := '';
    for I := 0 to m_GoodsList.Count - 1 do begin
      List14 := TList(m_GoodsList.Items[I]);
      if List14.Count <= 0 then Continue; //0807 增加，防止在制药物品列表为空时出错
      UserItem := List14.Items[0];
      if UserItem = nil then Continue;
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem <> nil then begin
        sSENDMSG := sSENDMSG + StdItem.Name + '/' + IntToStr(0) + '/' + IntToStr(g_Config.nMakeDurgPrice) + '/' + IntToStr(1) + '/';
      end;
    end;
    if sSENDMSG <> '' then
      User.SendMsg(Self, RM_USERMAKEDRUGITEMLIST, 0, Integer(Self), 0, 0, sSENDMSG);
  end;
  procedure ItemPrices(User: TPlayObject); //
  begin

  end;
  procedure Storage(User: TPlayObject);
  begin
    User.SendMsg(Self, RM_USERSTORAGEITEM, 0, Integer(Self), 0, 0, '');
  end;
  procedure GetBack(User: TPlayObject);
  begin
    User.SendMsg(Self, RM_USERGETBACKITEM, 0, Integer(Self), 0, 0, '');
  end;
  procedure BigStorage(User: TPlayObject);
  begin
    User.SendMsg(Self, RM_USERSTORAGEITEM, 0, Integer(Self), 0, 0, '');
  end;
  procedure BigGetBack(User: TPlayObject);
  begin
    User.m_nBigStoragePage := 0;
    User.SendMsg(Self, RM_USERBIGGETBACKITEM, User.m_nBigStoragePage, Integer(Self), 0, 0, '');
  end;
  procedure GetPreviousPage(User: TPlayObject);
  begin
    if User.m_nBigStoragePage > 0 then
      Dec(User.m_nBigStoragePage)
    else User.m_nBigStoragePage := 0;
    User.SendMsg(Self, RM_USERBIGGETBACKITEM, User.m_nBigStoragePage, Integer(Self), 0, 0, '');
  end;
  procedure GetNextPage(User: TPlayObject);
    function GetPageCount(nListCount: Integer): Integer;
    begin
      Result := 0;
      if nListCount >= 46 then begin
        Result := nListCount div 46;
        if (nListCount mod 46) > 0 then Inc(Result);
      end;
    end;
  var
    nMaxPageCount: Integer;
    StorageList: TStorageList;
  begin
    nMaxPageCount := 0;
    StorageList := nil;
    if (g_Storage.GetStorageList(User.m_sCharName, StorageList) >= 0) and (StorageList <> nil) then begin
      nMaxPageCount := GetPageCount(StorageList.Count);
    end;
    if User.m_nBigStoragePage < nMaxPageCount then begin
      Inc(User.m_nBigStoragePage);
    end;
    User.SendMsg(Self, RM_USERBIGGETBACKITEM, User.m_nBigStoragePage, Integer(Self), 0, 0, '');
  end;

  procedure UserLevelOrder(User: TPlayObject);
  begin
    User.m_nSelPlayOrderType := 0;
    User.m_nPlayOrderPage := 0;
    User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
  end;

  procedure WarrorLevelOrder(User: TPlayObject);
  begin
    User.m_nSelPlayOrderType := 1;
    User.m_nPlayOrderPage := 0;
    User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
  end;

  procedure WizardLevelOrder(User: TPlayObject);
  begin
    User.m_nSelPlayOrderType := 2;
    User.m_nPlayOrderPage := 0;
    User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
  end;

  procedure TaoistLevelOrder(User: TPlayObject);
  begin
    User.m_nSelPlayOrderType := 3;
    User.m_nPlayOrderPage := 0;
    User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
  end;

  procedure MasterCountOrder(User: TPlayObject);
  begin
    User.m_nSelPlayOrderType := 4;
    User.m_nPlayOrderPage := 0;
    User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
  end;

  procedure LevelOrderHomePage(User: TPlayObject);
  begin
    User.m_nPlayOrderPage := 0;
    User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
  end;

  procedure LevelOrderPreviousPage(User: TPlayObject);
  begin
    if User.m_nPlayOrderPage > 0 then
      Dec(User.m_nPlayOrderPage)
    else
      User.m_nPlayOrderPage := 0;
    User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
  end;

  procedure LevelOrderNextPage(User: TPlayObject);
  var
    PlayObjectList: TStringList;
  begin
   { PlayObjectList := GetPlayObjectOrderList(User.m_nSelPlayOrderType);
    if PlayObjectList <> nil then begin
      if GetPageCount(PlayObjectList.Count) > User.m_nPlayOrderPage then begin
        Inc(User.m_nPlayOrderPage);
      end;
      User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
    end;}
  end;

  procedure LevelOrderLastPage(User: TPlayObject);
  var
    PlayObjectList: TStringList;
  begin
   { PlayObjectList := GetPlayObjectOrderList(User.m_nSelPlayOrderType);
    if PlayObjectList <> nil then begin
      User.m_nPlayOrderPage := GetPageCount(PlayObjectList.Count);
      User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
    end;  }
  end;

  procedure MyLevelOrder(User: TPlayObject);
  begin
    User.m_boGetMyLevelOrder := True;
    User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
  end;

  procedure MakeHeroName(User: TPlayObject; sLabel, sMsg: string);
  var
    sSrcMsg: string;
    DestMsg: array[0..256] of Char;
    boGotoLabel: Boolean;
    sGotoLabel: string;
    sNewMsg: string;
  begin
    //MainOutMessage(sLabel +' sMsg:'+sMsg);
    if (User.m_sHeroCharName <> '') then begin
      GotoLable(User, '@HaveHero', False);
    end else begin
      if (User.m_sTempHeroName <> '') or User.m_boWaitHeroDate then begin
        GotoLable(User, '@CreateingHero', False);
        Exit;
      end;
      if (Length(sMsg) > 0) and (Length(sMsg) < 15) then begin
        if Assigned(PlugInEngine.PlayObjectFilterMsg) then begin
          sSrcMsg := sMsg;
          if PlugInEngine.PlayObjectFilterMsg(User, PChar(sSrcMsg), @DestMsg, boGotoLabel) then begin
            User.m_sHeroCharName := '';
            User.m_sTempHeroName := '';
            GotoLable(User, '@HeroNameFilter', False);
            Exit;
          end;
        end;

        User.m_sTempHeroName := sMsg;
        sGotoLabel := Copy(sLabel, 2, Length(sLabel) - 1);
        GotoLable(User, sGotoLabel, False);
      end else begin
        User.m_sHeroCharName := '';
        User.m_sTempHeroName := '';
        GotoLable(User, '@HeroNameFilter', False);
      end;
    end;
  end;

  {
  procedure MakeHeroName(User: TPlayObject; sLabel, sMsg: string);
  var
    sGotoLabel: string;
    sSrcMsg: string;
    DestMsg: array[0..256] of Char;
    boGotoLabel: Boolean;
  begin
    if User.m_boWaitHeroDate then Exit;
    if User.m_boHasHero and (User.m_sHeroCharName <> '') then begin
      GotoLable(User, '@HaveHero', False);
    end else begin
      if (Length(sMsg) > 0) and (Length(sMsg) < 15) then begin
        if Assigned(PlugInEngine.PlayObjectFilterMsg) then begin
          sSrcMsg := sMsg;
          if PlugInEngine.PlayObjectFilterMsg(User, PChar(sSrcMsg), @DestMsg, boGotoLabel) then begin
            User.m_sHeroCharName := '';
            GotoLable(User, '@HeroNameFilter', False);
            Exit;
          end;
        end;
        User.m_sHeroCharName := sMsg;
        sGotoLabel := Copy(sLabel, 2, Length(sLabel) - 1);
        GotoLable(User, sGotoLabel, False);
      end else begin
        User.m_sHeroCharName := '';
        GotoLable(User, '@HeroNameFilter', False);
      end;
    end;
  end;
  }
  procedure UpgradeItem(User: TPlayObject);
  begin
    User.SendMsg(Self, RM_SENDCHANGEITEM, 0, Integer(Self), 0, 0, '');
  end;

  procedure AppDuel(User: TPlayObject; sLabel, sMsg: string);
  {var
    sGotoLabel: string;}
  begin
    {if sMsg = '' then Exit;
    sGotoLabel := Copy(sLabel, 2, Length(sLabel) - 1);
    GotoLable(User, sGotoLabel, False);}
  end;
var
  sLabel, s18, s19, sMsg: string;
  boCanJmp: Boolean;
  nChangeUseItemNameLen: Integer;
  sChangeUseItemName: string;
  nCheckCode: Integer;
resourcestring
  sExceptionMsg = '[Exception] TMerchant::UserSelect... Data: %s Code:%d';
begin
  inherited;
  nCheckCode := 0;
  if not (ClassNameIs(TMerchant.ClassName)) then Exit; //如果类名不是 TMerchant 则不执行以下处理函数
  try
    if not m_boCastle or not ((m_Castle <> nil) and TUserCastle(m_Castle).m_boUnderWar) and (PlayObject <> nil) then begin
      if {not PlayObject.m_boDeath and}(sData <> '') and (sData[1] = '@') then begin //修改死亡后可以点击NPC
        nCheckCode := 1;
        sMsg := GetValidStr3(sData, sLabel, [#13]);

        if not AllowLable(sLabel) then Exit; //2009-04-08增加

        s18 := '';
        nCheckCode := 2;
        PlayObject.m_sScriptLable := sData;
        if CompareText(sLabel, sGotoVillage) = 0 then begin
          boCanJmp := True;
        end else begin
          boCanJmp := PlayObject.LableIsCanJmp(sLabel);
        end;
        if CompareText(sLabel, sSL_SENDMSG) = 0 then begin
          if sMsg = '' then Exit;
        end;
        if CompareLStr(sLabel, sUSEITEMNAME, Length(sUSEITEMNAME)) then begin //检测装备
          if sMsg <> '' then begin
            if g_Config.boChangeUseItemNameByPlayName then begin
              sChangeUseItemName := PlayObject.m_sCharName + '的' + sMsg;
            end else begin
              sChangeUseItemName := g_Config.sChangeUseItemName + sMsg;
            end;

            nChangeUseItemNameLen := 30;

            if Length(sChangeUseItemName) > nChangeUseItemNameLen then begin
              SendMsgToUser(PlayObject, '[失败] 名称太长！！！');
              Exit;
            end;
          end;
        end;
        nCheckCode := 3;
        GotoLable(PlayObject, sLabel, not boCanJmp);
        nCheckCode := 4;
        if not boCanJmp then Exit;
        nCheckCode := 5;
        s18 := Copy(sLabel, 1, Length(sRMST));
        if CompareText(sLabel, sSL_SENDMSG) = 0 then begin
          if m_boSendmsg then SendCustemMsg(PlayObject, sMsg);
        end else
          if CompareText(sLabel, sSUPERREPAIR) = 0 then begin
          if m_boS_repair then SuperRepairItem(PlayObject);
        end else
          if CompareText(sLabel, sBUY) = 0 then begin
          if m_boBuy then BuyItem(PlayObject, 0);
        end else
          if CompareText(s18, sRMST) = 0 then begin //接受歌曲
          if m_boofflinemsg then RemoteMsg(PlayObject, sLabel, sMsg);
        end else
          if CompareText(sLabel, sofflinemsg) = 0 then begin //离线挂机
          if m_boofflinemsg then AutoGetExp(PlayObject, sMsg);
        end else
          if CompareText(sLabel, sGETSELLGOLD) = 0 then begin
          if m_boGetSellGold then GetSellGold(PlayObject);
        end else
          if CompareText(sLabel, sBUYOFF) = 0 then begin
          if m_boBuyOff then BuySellItem(PlayObject);
        end else
          if CompareText(sLabel, sSELLOFF) = 0 then begin
          if m_boBuyOff then SellSellItem(PlayObject);
        end else
          if CompareText(sLabel, sdealgold) = 0 then begin
          if m_boDealGold then DealGold(PlayObject, sMsg);
        end else
          if CompareText(sLabel, sSELL) = 0 then begin
          if m_boSell then SellItem(PlayObject);
        end else
          if CompareText(sLabel, sREPAIR) = 0 then begin
          if m_boRepair then RepairItem(PlayObject);
        end else
          if CompareText(sLabel, sMAKEDURG) = 0 then begin
          if m_boMakeDrug then MakeDurg(PlayObject);
        end else
          if CompareText(sLabel, sPRICES) = 0 then begin
          if m_boPrices then ItemPrices(PlayObject);
        end else
          if CompareText(sLabel, sSTORAGE) = 0 then begin
          if m_boStorage then Storage(PlayObject);
        end else
          if CompareText(sLabel, sGETBACK) = 0 then begin
          if m_boGetback then GetBack(PlayObject);
        end else
          if CompareText(sLabel, sBIGSTORAGE) = 0 then begin
          if m_boBigStorage then BigStorage(PlayObject);
        end else
          if CompareText(sLabel, sBIGGETBACK) = 0 then begin
          if m_boBigGetBack then BigGetBack(PlayObject);
        end else
          if CompareText(sLabel, sGETPREVIOUSPAGE) = 0 then begin
          if m_boBigGetBack then GetPreviousPage(PlayObject);
        end else
          if CompareText(sLabel, sGETNEXTPAGE) = 0 then begin
          if m_boBigGetBack then GetNextPage(PlayObject);
        end else
          if CompareText(sLabel, sUserLevelOrder) = 0 then begin
          if m_boUserLevelOrder then UserLevelOrder(PlayObject);
        end else
          if CompareText(sLabel, sWarrorLevelOrder) = 0 then begin
          if m_boWarrorLevelOrder then WarrorLevelOrder(PlayObject);
        end else
          if CompareText(sLabel, sWizardLevelOrder) = 0 then begin
          if m_boWizardLevelOrder then WizardLevelOrder(PlayObject);
        end else
          if CompareText(sLabel, sTaoistLevelOrder) = 0 then begin
          if m_boTaoistLevelOrder then TaoistLevelOrder(PlayObject);
        end else
          if CompareText(sLabel, sMasterCountOrder) = 0 then begin
          if m_boMasterCountOrder then MasterCountOrder(PlayObject);
        end else
          if CompareText(sLabel, sLevelOrderHomePage) = 0 then begin
          LevelOrderHomePage(PlayObject);
        end else
          if CompareText(sLabel, sLevelOrderPreviousPage) = 0 then begin
          LevelOrderPreviousPage(PlayObject);
        end else
          if CompareText(sLabel, sLevelOrderNextPage) = 0 then begin
          LevelOrderNextPage(PlayObject);
        end else
          if CompareText(sLabel, sLevelOrderLastPage) = 0 then begin
          LevelOrderLastPage(PlayObject);
        end else
          if CompareText(sLabel, sMyLevelOrder) = 0 then begin
          MyLevelOrder(PlayObject);
        end else

          if CompareText(sLabel, sCqFirHero) = 0 then begin
          if m_boCqFirHero then MakeHeroName(PlayObject, sLabel, sMsg);
        end else
          if CompareText(sLabel, sUPGRADEITEMS) = 0 then begin
          if m_boUpgradeItem then UpgradeItem(PlayObject);
        end else

          if CompareText(sLabel, sAppDuel) = 0 then begin //挑战
          if m_boAppDuel then AppDuel(PlayObject, sLabel, sMsg);
        end else
          if CompareText(sLabel, sUPGRADENOW) = 0 then begin
          if m_boUpgradenow then UpgradeWapon(PlayObject);
        end else
          if CompareText(sLabel, sGETBACKUPGNOW) = 0 then begin
          if m_boGetBackupgnow then GetBackupgWeapon(PlayObject);
        end else
          if CompareText(sLabel, sGETMARRY) = 0 then begin
          if m_boGetMarry then GetBackupgWeapon(PlayObject);
        end else
          if CompareText(sLabel, sGETMASTER) = 0 then begin
          if m_boGetMaster then GetBackupgWeapon(PlayObject);
        end else
          if CompareLStr(sLabel, sUSEITEMNAME, Length(sUSEITEMNAME)) then begin
          if m_boUseItemName then ChangeUseItemName(PlayObject, sLabel, sMsg);
        end else
          if CompareText(sLabel, sEXIT) = 0 then begin
          PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self), 0, 0, '');
        end else
          if CompareText(sLabel, sBACK) = 0 then begin
          if PlayObject.m_sScriptGoBackLable = '' then PlayObject.m_sScriptGoBackLable := sMAIN;
          GotoLable(PlayObject, PlayObject.m_sScriptGoBackLable, False);
        end else begin
          if Assigned(PlugInEngine.PlayObjectUserSelect) then begin
            PlugInEngine.PlayObjectUserSelect(Self, PlayObject, PChar(sLabel), PChar(sMsg));
          end;
        end;
      end;
    end;
  except
    MainOutMessage(Format(sExceptionMsg, [sData, nCheckCode]));
  end;
end;

procedure TMerchant.Run();
var
  nCheckCode: Integer;
resourcestring
  sExceptionMsg1 = '[Exception] TMerchant::Run... Code = %d';
  sExceptionMsg2 = '[Exception] TMerchant::Run -> Move Code = %d';
begin
  nCheckCode := 0;
  try
    if (GetTickCount - dwRefillGoodsTick) > 30000 then begin
      //if (GetTickCount - dwTick578) > 3000 then begin
      dwRefillGoodsTick := GetTickCount();
      RefillGoods();
    end;

    nCheckCode := 1;
    if (GetTickCount - dwClearExpreUpgradeTick) > 10 * 60 * 1000 then begin
      dwClearExpreUpgradeTick := GetTickCount();
      ClearExpreUpgradeListData();
    end;
    nCheckCode := 2;
    if m_wAppr in [53..70] then begin

    end else begin
      if m_wAppr in [73..76] then begin
        if Random(20) = 0 then begin
          SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
        end else begin
          if Random(5) = 0 then
            TurnTo(0);
        end;
      end else begin
        if Random(50) = 0 then begin
          TurnTo(Random(8));
        end else begin
          if Random(50) = 0 then
            SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
        end;
      end;
    end;

    nCheckCode := 3;
    //    if m_boCastle and (UserCastle.m_boUnderWar)then begin
    if m_boCastle and (m_Castle <> nil) and TUserCastle(m_Castle).m_boUnderWar then begin
      if not m_boFixedHideMode then begin
        SendRefMsg(RM_DISAPPEAR, 0, 0, 0, 0, '');
        m_boFixedHideMode := True;
      end;
    end else begin
      if m_boFixedHideMode then begin
        m_boFixedHideMode := False;
        SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
      end;
    end;
    nCheckCode := 4;
  except
    on E: Exception do begin
      MainOutMessage(Format(sExceptionMsg1, [nCheckCode]));
      MainOutMessage(E.Message);
    end;
  end;
  try
    if m_boCanMove and (GetTickCount - m_dwMoveTick > m_dwMoveTime * 1000) then begin
      m_dwMoveTick := GetTickCount();
      SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
      MapRandomMove(m_sMapName, 0);
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format(sExceptionMsg2, [nCheckCode]));
      MainOutMessage(E.Message);
    end;
  end;
  inherited;
end;

function TMerchant.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);
end;

procedure TMerchant.LoadNPCData;
var
  sFile: string;
begin
  sFile := m_sScript + '-' + m_sMapName;
  FrmDB.LoadGoodRecord(Self, sFile);
  FrmDB.LoadGoodPriceRecord(Self, sFile);
  LoadUpgradeList();
end;

procedure TMerchant.SaveNPCData;
var
  sFile: string;
begin
  sFile := m_sScript + '-' + m_sMapName;
  FrmDB.SaveGoodRecord(Self, sFile);
  FrmDB.SaveGoodPriceRecord(Self, sFile);
end;

constructor TMerchant.Create;
begin
  inherited;
  m_btRaceImg := RCC_MERCHANT;
  m_wAppr := 0;
  m_nPriceRate := 100;
  m_boCastle := False;
  m_ItemTypeList := TList.Create;
  m_RefillGoodsList := TList.Create;
  m_GoodsList := TList.Create;
  m_ItemPriceList := TList.Create;
  m_UpgradeWeaponList := TList.Create;

  dwRefillGoodsTick := GetTickCount();
  dwClearExpreUpgradeTick := GetTickCount();
  m_boBuy := False;
  m_boSell := False;
  m_boMakeDrug := False;
  m_boPrices := False;
  m_boStorage := False;
  m_boGetback := False;
  m_boBigStorage := False;
  m_boBigGetBack := False;
  m_boGetNextPage := False;
  m_boGetPreviousPage := False;
  m_boCqFirHero := False;
  m_boUpgradeItem := False;
  m_boAppDuel := False;
  m_boUserLevelOrder := False;
  m_boWarrorLevelOrder := False;
  m_boWizardLevelOrder := False;
  m_boTaoistLevelOrder := False;
  m_boMasterCountOrder := False;

  m_boUpgradenow := False;
  m_boGetBackupgnow := False;
  m_boRepair := False;
  m_boS_repair := False;
  m_boGetMarry := False;
  m_boGetMaster := False;
  m_boUseItemName := False;

  m_boGetSellGold := False;
  m_boSellOff := False;
  m_boBuyOff := False;
  m_boofflinemsg := False;
  m_boDealGold := False;
  m_dwMoveTick := GetTickCount();
end;

destructor TMerchant.Destroy;
var
  I: Integer;
  II: Integer;
  List: TList;
begin
  m_ItemTypeList.Free;
  for I := 0 to m_RefillGoodsList.Count - 1 do begin
    Dispose(pTGoods(m_RefillGoodsList.Items[I]));
  end;
  m_RefillGoodsList.Free;
  for I := 0 to m_GoodsList.Count - 1 do begin
    List := TList(m_GoodsList.Items[I]);
    for II := 0 to List.Count - 1 do begin
      Dispose(pTUserItem(List.Items[II]));
    end;
    List.Free;
  end;
  m_GoodsList.Free;

  for I := 0 to m_ItemPriceList.Count - 1 do begin
    Dispose(pTItemPrice(m_ItemPriceList.Items[I]));
  end;
  m_ItemPriceList.Free;
  for I := 0 to m_UpgradeWeaponList.Count - 1 do begin
    Dispose(pTUpgradeInfo(m_UpgradeWeaponList.Items[I]));
  end;
  m_UpgradeWeaponList.Free;

  inherited;
end;

procedure TMerchant.ClearExpreUpgradeListData;
var
  I: Integer;
  UpgradeInfo: pTUpgradeInfo;
begin
  for I := m_UpgradeWeaponList.Count - 1 downto 0 do begin
    UpgradeInfo := m_UpgradeWeaponList.Items[I];
    if Integer(Round(Now - UpgradeInfo.dtTime)) >= g_Config.nClearExpireUpgradeWeaponDays then begin
      m_UpgradeWeaponList.Delete(I);
      Dispose(UpgradeInfo);
    end;
  end;
end;

procedure TMerchant.LoadNpcScript;
var
  SC: string;
begin
  m_ItemTypeList.Clear;
  m_sPath := sMarket_Def;
  SC := m_sScript + '-' + m_sMapName;
  FrmDB.LoadScriptFile(Self, sMarket_Def, SC, True);
  //  call    sub_49ABE0
end;

procedure TMerchant.Click(PlayObject: TPlayObject; sLabel: string); //0049FF24
begin
  //  GotoLable(PlayObject,'@main');
  inherited;
end;

procedure TMerchant.GetVariableText(PlayObject: TPlayObject;
  var sMsg: string; sVariable: string); //0049FD04
var
  sText, s14: string;
  n18: Integer;
begin
  inherited;
  if sVariable = '$PRICERATE' then begin
    sText := IntToStr(m_nPriceRate);
    sMsg := sub_49ADB8(sMsg, '<$PRICERATE>', sText);
  end;
  if sVariable = '$UPGRADEWEAPONFEE' then begin
    sText := IntToStr(g_Config.nUpgradeWeaponPrice);
    sMsg := sub_49ADB8(sMsg, '<$UPGRADEWEAPONFEE>', sText);
  end;
  if sVariable = '$USERWEAPON' then begin
    if PlayObject.m_UseItems[U_WEAPON].wIndex <> 0 then begin
      sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_WEAPON].wIndex);
    end else begin
      sText := '无';
    end;
    sMsg := sub_49ADB8(sMsg, '<$USERWEAPON>', sText);
  end;
end;

function TMerchant.GetUserItemPrice(UserItem: pTUserItem): Integer;
var
  n10: Integer;
  StdItem: pTStdItem;
  n20: real;
  nC: Integer;
  n14: Integer;
begin
  n10 := GetItemPrice(UserItem.wIndex);
  if n10 > 0 then begin
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) and
      (StdItem.StdMode > 4) and
      (StdItem.DuraMax > 0) and
      (UserItem.DuraMax > 0) then begin
      if StdItem.StdMode = 40 then begin //肉
        if UserItem.Dura <= UserItem.DuraMax then begin
          n20 := (n10 / 2.0 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
          n10 := _MAX(2, Round(n10 - n20));
        end else begin
          n10 := n10 + Round(n10 / UserItem.DuraMax * 2.0 * (UserItem.DuraMax - UserItem.Dura));
        end;
      end;
      if (StdItem.StdMode = 43) then begin
        if UserItem.DuraMax < 10000 then UserItem.DuraMax := 10000;
        if UserItem.Dura <= UserItem.DuraMax then begin
          n20 := (n10 / 2.0 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
          n10 := _MAX(2, Round(n10 - n20));
        end else begin
          n10 := n10 + Round(n10 / UserItem.DuraMax * 1.3 * (UserItem.DuraMax - UserItem.Dura));
        end;
      end;
      if StdItem.StdMode > 4 then begin
        n14 := 0;
        nC := 0;
        while (True) do begin
          if (StdItem.StdMode = 5) or (StdItem.StdMode = 6) then begin
            if (nC <> 4) or (nC <> 9) then begin
              if nC = 6 then begin
                if UserItem.btValue[nC] > 10 then begin
                  n14 := n14 + (UserItem.btValue[nC] - 10) * 2;
                end;
              end else begin
                n14 := n14 + UserItem.btValue[nC];
              end;
            end;
          end else begin
            Inc(n14, UserItem.btValue[nC]);
          end;
          Inc(nC);
          if nC >= 8 then Break;
        end;
        if n14 > 0 then begin
          n10 := n10 div 5 * n14;
        end;
        n10 := Round(n10 / StdItem.DuraMax * UserItem.DuraMax);
        n20 := (n10 / 2.0 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
        n10 := _MAX(2, Round(n10 - n20));
      end;
    end;
  end;
  Result := n10;
end;

procedure TMerchant.ClientBuyItem(PlayObject: TPlayObject; sItemName: string;
  nInt: Integer);
var
  I, II: Integer;
  bo29: Boolean;
  List20: TList;
  ItemPrice: pTItemPrice;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  n1C, nPrice: Integer;
  sUserItemName: string;
begin
  bo29 := False;
  n1C := 1;
  I := 0;
  while True do begin //for i := 0 to m_GoodsList.Count - 1 do begin
    if I >= m_GoodsList.Count then Break;
    if m_GoodsList.Count <= 0 then Break;
    if bo29 or (bo574) then Break;
    List20 := TList(m_GoodsList.Items[I]);
    if List20 = nil then begin
      m_GoodsList.Delete(I);
      Continue;
    end;
    if List20.Count <= 0 then begin
      m_GoodsList.Delete(I);
      List20.Free;
      Continue;
    end;
    UserItem := List20.Items[0];
    //取自定义物品名称
    sUserItemName := '';
    if UserItem.btValue[13] = 1 then
      sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
    if sUserItemName = '' then
      sUserItemName := UserEngine.GetStdItemName(UserItem.wIndex);

    if PlayObject.CheckItemBindUse(UserItem, False) = 2 then begin
      sUserItemName := '(绑)' + sUserItemName;
    end;

    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem <> nil then begin
      if PlayObject.IsAddWeightAvailable(StdItem.Weight) then begin
        if sUserItemName = sItemName then begin
          II := 0;
          while True do begin //for ii := 0 to List20.Count - 1 do begin
            if II >= List20.Count then Break;
            if List20.Count <= 0 then Break;
            UserItem := List20.Items[II];
            if (StdItem.StdMode <= 4) or
              (StdItem.StdMode = 42) or
              (StdItem.StdMode = 31) or
              (UserItem.MakeIndex = nInt) then begin

              nPrice := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
              if (PlayObject.m_nGold >= nPrice) and (nPrice > 0) then begin
                if PlayObject.AddItemToBag(UserItem) then begin
                  Dec(PlayObject.m_nGold, nPrice);
                  if m_boCastle or g_Config.boGetAllNpcTax then begin
                    if m_Castle <> nil then begin
                      TUserCastle(m_Castle).IncRateGold(nPrice);
                    end else
                      if g_Config.boGetAllNpcTax then begin
                      g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
                    end;
                  end;
                  {
                  if m_boCastle or g_Config.boGetAllNpcTax then
                    UserCastle.IncRateGold(nPrice);
                  }
                  PlayObject.SendAddItem(UserItem);
                  //004A25DC
                  if StdItem.NeedIdentify = 1 then
                    AddGameDataLog('9' + #9 +
                      PlayObject.m_sMapName + #9 +
                      IntToStr(PlayObject.m_nCurrX) + #9 +
                      IntToStr(PlayObject.m_nCurrY) + #9 +
                      PlayObject.m_sCharName + #9 +
                      //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                      StdItem.Name + #9 +
                      IntToStr(UserItem.MakeIndex) + #9 +
                      '1' + #9 +
                      m_sCharName);

                  List20.Delete(II);
                  if List20.Count <= 0 then begin
                    List20.Free;
                    m_GoodsList.Delete(I);
                  end;
                  n1C := 0;
                end else n1C := 2;
              end else n1C := 3;
              bo29 := True;
              Break;
            end;
            Inc(II);
          end;
        end;
      end else n1C := 2; //004A2639
    end;
    Inc(I);
  end; // for
  if n1C = 0 then begin
    PlayObject.SendMsg(Self, RM_BUYITEM_SUCCESS, 0, PlayObject.m_nGold, nInt, 0, '');
  end else begin
    PlayObject.SendMsg(Self, RM_BUYITEM_FAIL, 0, n1C, 0, 0, '');
  end;
end;

procedure TMerchant.ClientGetDetailGoodsList(PlayObject: TPlayObject; sItemName: string;
  nInt: Integer);
var
  I, II, n18: Integer;
  List20: TList;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  ClientItem: TClientItem;
  OClientItem: TOClientItem;
  s1C: string;
begin
  if Assigned(PlugInEngine.MerchantClientGetDetailGoodsList) then begin
    PlugInEngine.MerchantClientGetDetailGoodsList(Self, PlayObject, PChar(sItemName), nInt);
  end else begin
    if not PlayObject.m_boHeroVersion then begin
      n18 := 0;
      for I := 0 to m_GoodsList.Count - 1 do begin
        List20 := TList(m_GoodsList.Items[I]);
        if List20 = nil then Continue;
        if List20.Count <= 0 then Continue;
        UserItem := List20.Items[0];
        if UserItem = nil then Continue;
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if (StdItem <> nil) and (CompareText(StdItem.Name, sItemName) = 0) then begin
          if (List20.Count - 1) < nInt then begin
            nInt := _MAX(0, List20.Count - 10);
          end;
          for II := List20.Count - 1 downto 0 do begin
            if List20.Count <= 0 then Break;
            UserItem := List20.Items[II];
            if UserItem <> nil then begin
              CopyStdItemToOStdItem(StdItem, @OClientItem.s);
              OClientItem.Dura := UserItem.Dura;
              OClientItem.DuraMax := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
              OClientItem.MakeIndex := UserItem.MakeIndex;
              s1C := s1C + EncodeBuffer(@OClientItem, SizeOf(TOClientItem)) + '/';
              Inc(n18);
              if n18 >= 10 then Break;
            end;
          end;
          Break;
        end;
      end;
      PlayObject.SendMsg(Self, RM_SENDDETAILGOODSLIST, 0, Integer(Self), n18, nInt, s1C);
    end else begin
      n18 := 0;
      for I := 0 to m_GoodsList.Count - 1 do begin
        List20 := TList(m_GoodsList.Items[I]);
        if List20 = nil then Continue;
        if List20.Count <= 0 then Continue;
        UserItem := List20.Items[0];
        if UserItem = nil then Continue;
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if (StdItem <> nil) and (StdItem.Name = sItemName) then begin
          if (List20.Count - 1) < nInt then begin
            nInt := _MAX(0, List20.Count - 10);
          end;
          for II := List20.Count - 1 downto 0 do begin
            if List20.Count <= 0 then Break;
            UserItem := List20.Items[II];
            if UserItem <> nil then begin
              ClientItem.s := StdItem^;
              ClientItem.Dura := UserItem.Dura;
              ClientItem.DuraMax := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
              ClientItem.MakeIndex := UserItem.MakeIndex;
              //ItemUnit.GetItemAddValue(UserItem, ClientItem.s);

              ClientItem.s.AddValue := UserItem.AddValue;
              ClientItem.s.AddPoint := UserItem.AddPoint;
              ClientItem.s.MaxDate := UserItem.MaxDate;
              //ClientItem.s.sDescr := UserEngine.GetStdItemDescr(ClientItem.s, UserItem);

              s1C := s1C + EncodeBuffer(@ClientItem, SizeOf(TClientItem)) + '/';
              Inc(n18);
              if n18 >= 10 then Break;
            end;
          end;
          Break;
        end;
      end;
      PlayObject.SendMsg(Self, RM_SENDDETAILGOODSLIST, 0, Integer(Self), n18, nInt, s1C);
    end;
  end;
end;

procedure TMerchant.ClientQuerySellPrice(PlayObject: TPlayObject;
  UserItem: pTUserItem);
var
  nC: Integer;
begin
  nC := GetSellItemPrice(GetUserItemPrice(UserItem));
  if (nC >= 0) then begin
    PlayObject.SendMsg(Self, RM_SENDBUYPRICE, 0, nC, 0, 0, '');
  end else begin
    PlayObject.SendMsg(Self, RM_SENDBUYPRICE, 0, 0, 0, 0, '');
  end;
end;

function TMerchant.GetSellItemPrice(nPrice: Integer): Integer;
begin
  Result := Round(nPrice / 2.0);
end;

function TMerchant.ClientSellItem(PlayObject: TPlayObject;
  UserItem: pTUserItem): Boolean;
  function sub_4A1C84(UserItem: pTUserItem): Boolean;
  var
    StdItem: pTStdItem;
  begin
    Result := True;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) and ((StdItem.StdMode = 25) or (StdItem.StdMode = 30)) then begin
      if UserItem.Dura < 4000 then Result := False;
    end;
  end;
var
  nPrice: Integer;
  StdItem: pTStdItem;
  sCheckItemName: string;
begin
  Result := False;
  if Assigned(PlugInEngine.CheckCanSellItem) then begin //禁止出售
    sCheckItemName := UserEngine.GetStdItemName(UserItem.wIndex);
    if PlugInEngine.CheckCanSellItem(PlayObject, PChar(sCheckItemName), True) then begin
      PlayObject.SendMsg(Self, RM_USERSELLITEM_FAIL, 0, 0, 0, 0, '');
      Exit;
    end;
  end;

  nPrice := GetSellItemPrice(GetUserItemPrice(UserItem));
  if (nPrice > 0) and (not bo574) and
    sub_4A1C84(UserItem) then begin
    if PlayObject.IncGold(nPrice) then begin
      {
      if m_boCastle or g_Config.boGetAllNpcTax then
        UserCastle.IncRateGold(nPrice);
      }
      if m_boCastle or g_Config.boGetAllNpcTax then begin
        if m_Castle <> nil then begin
          TUserCastle(m_Castle).IncRateGold(nPrice);
        end else
          if g_Config.boGetAllNpcTax then begin
          g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
        end;
      end;
      PlayObject.SendMsg(Self, RM_USERSELLITEM_OK, 0, PlayObject.m_nGold, 0, 0, '');
      AddItemToGoodsList(UserItem);
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem.NeedIdentify = 1 then
        AddGameDataLog('10' + #9 +
          PlayObject.m_sMapName + #9 +
          IntToStr(PlayObject.m_nCurrX) + #9 +
          IntToStr(PlayObject.m_nCurrY) + #9 +
          PlayObject.m_sCharName + #9 +
          //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
          StdItem.Name + #9 +
          IntToStr(UserItem.MakeIndex) + #9 +
          '1' + #9 +
          m_sCharName);
      Result := True;
    end else begin
      PlayObject.SendMsg(Self, RM_USERSELLITEM_FAIL, 0, 0, 0, 0, '');
    end;
  end else begin
    PlayObject.SendMsg(Self, RM_USERSELLITEM_FAIL, 0, 0, 0, 0, '');
  end;
end;

function TMerchant.AddItemToGoodsList(UserItem: pTUserItem): Boolean;
var
  n10: Integer;
  ItemList: TList;
begin
  Result := False;
  if UserItem.Dura <= 0 then Exit;
  ItemList := GetRefillList(UserItem.wIndex);
  if ItemList = nil then begin
    ItemList := TList.Create;
    m_GoodsList.Add(ItemList);
  end;
  ItemList.Insert(0, UserItem);
  Result := True;
end;
////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////拍卖/////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//拍卖物品名称 持久是否大于0  价格如果是自己的为负  数量

procedure TMerchant.ClientGetDetailSellGoodsList(PlayObject: TPlayObject; sItemName: string;
  nInt: Integer);
var
  I, II, n18: Integer;
  nIndex: Integer;
  List20: TSellList;
  StdItem: pTStdItem;
  StdItem20: TStdItem;
  ClientItem: TClientItem;
  OClientItem: TOClientItem;
  s1C: string;
  SellOffInfo: pTSellOffInfo;
  nPrice: Integer;
  //nIndex: Integer;
begin
  n18 := 0;
  s1C := '';
  if not PlayObject.m_boHeroVersion then begin
    if (g_SellList.GetSellListByItemName(sItemName, List20) >= 0) and (List20 <> nil) and (List20.Count > 0) then begin
      SellOffInfo := pTSellOffInfo(List20.Objects[0]);
      StdItem := UserEngine.GetStdItem(SellOffInfo.UserItem.wIndex);
      if StdItem <> nil then begin
        StdItem20 := StdItem^;
        nIndex := nInt;
        //if nIndex <= 0 then nIndex := 1;
        if (List20.Count - 1) < nIndex then begin
          nIndex := _MAX(0, List20.Count - 11);
        end;
        //MainOutMessage('Count:' + IntToStr(List20.Count) + ' nInt:' + IntToStr(nInt));
        nIndex := _MAX(0, nIndex);
        for II := nIndex to List20.Count - 1 do begin
          //if List20.Count <= 0 then Break;
          SellOffInfo := pTSellOffInfo(List20.Objects[II]);

          ItemUnit.GetItemAddValue(@SellOffInfo.UserItem, StdItem20);
          CopyStdItemToOStdItem(@StdItem20, @OClientItem.s);

          if CompareText(PlayObject.m_sCharName, SellOffInfo.sCharName) = 0 then begin
            OClientItem.s.Price := -SellOffInfo.nSellGold;
          end else begin
            OClientItem.s.Price := SellOffInfo.nSellGold;
          end;
          OClientItem.Dura := SellOffInfo.UserItem.Dura;
          OClientItem.DuraMax := SellOffInfo.UserItem.DuraMax;
          OClientItem.MakeIndex := SellOffInfo.UserItem.MakeIndex;
          s1C := s1C + EncodeBuffer(@OClientItem, SizeOf(TOClientItem)) + '/';
          Inc(n18);
          if n18 >= 10 then Break;
        end;
        nInt := nIndex;
      end;
    end;
  end else begin
    if (g_SellList.GetSellListByItemName(sItemName, List20) >= 0) and (List20 <> nil) and (List20.Count > 0) then begin
      SellOffInfo := pTSellOffInfo(List20.Objects[0]);
      StdItem := UserEngine.GetStdItem(SellOffInfo.UserItem.wIndex);
      if StdItem <> nil then begin
        if (List20.Count - 1) < nInt then begin
          nInt := _MAX(0, List20.Count - 10);
        end;
        for II := List20.Count - 1 downto 0 do begin
          SellOffInfo := pTSellOffInfo(List20.Objects[II]);
          ClientItem.s := StdItem^;
          if CompareText(PlayObject.m_sCharName, SellOffInfo.sCharName) = 0 then begin
            ClientItem.s.Price := -SellOffInfo.nSellGold;
          end else begin
            ClientItem.s.Price := SellOffInfo.nSellGold;
          end;
          ClientItem.Dura := SellOffInfo.UserItem.Dura;
          ClientItem.DuraMax := SellOffInfo.UserItem.DuraMax;
          ClientItem.MakeIndex := SellOffInfo.UserItem.MakeIndex;
          ItemUnit.GetItemAddValue(@SellOffInfo.UserItem, ClientItem.s);

          ClientItem.s.AddValue := SellOffInfo.UserItem.AddValue;
          ClientItem.s.AddPoint := SellOffInfo.UserItem.AddPoint;
          ClientItem.s.MaxDate := SellOffInfo.UserItem.MaxDate;
          //ClientItem.s.sDescr := UserEngine.GetStdItemDescr(ClientItem.s, @SellOffInfo.UseItems);

          s1C := s1C + EncodeBuffer(@ClientItem, SizeOf(TClientItem)) + '/';
          Inc(n18);
          if n18 >= 10 then Break;
        end;
      end;
    end;
  end;
  PlayObject.SendMsg(Self, RM_SENDSELLOFFITEMLIST, 0, Integer(Self), n18, nInt, s1C);
end;

procedure TMerchant.ClientBuySellOffItem(PlayObject: TPlayObject; sItemName: string;
  nInt: Integer);
var
  bo29: Boolean;
  List20: TSellList;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  n1C, nPrice: Integer;
  sUserItemName: string;
  SellOffInfo: pTSellOffInfo;
  AddSellOffInfo: pTSellOffInfo;
  OnlinePlayObject: TPlayObject;
begin
  //n1C = 1 物品已经拍卖了  n1C = 2 无法携带更多的物品 n1C = 3 没有足够的元宝购买物品
  bo29 := False;
  n1C := 1;
  SellOffInfo := nil;
  if (bo29) or (bo574) then Exit;

  if (g_SellList.GetItem(nInt, sItemName, SellOffInfo) >= 0) and (SellOffInfo <> nil) then begin
    StdItem := UserEngine.GetStdItem(SellOffInfo.UserItem.wIndex);
    if StdItem <> nil then begin
      if PlayObject.IsAddWeightAvailable(StdItem.Weight) then begin
        if CompareText(PlayObject.m_sCharName, SellOffInfo.sCharName) = 0 then begin
          if PlayObject.IsEnoughBag then begin
            New(UserItem);
            UserItem^ := SellOffInfo.UserItem;
            if g_SellList.Delete(SellOffInfo, True) then begin
              PlayObject.m_ItemList.Add(UserItem);
              PlayObject.SendAddItem(UserItem);
              bo29 := True;
              n1C := 0;
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('33' + #9 +
                  PlayObject.m_sMapName + #9 +
                  IntToStr(PlayObject.m_nCurrX) + #9 +
                  IntToStr(PlayObject.m_nCurrY) + #9 +
                  PlayObject.m_sCharName + #9 +
              //UserEngine.GetStdItemName(m_UseItems[I].wIndex) + #9 +
                  StdItem.Name + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  BoolToIntStr(m_btRaceServer = RC_PLAYOBJECT) + #9 +
                  m_sCharName);
            end else begin
              Dispose(UserItem);
              n1C := 2;
            end;
          end else n1C := 2;
        end else
          if (PlayObject.m_nGameGold >= SellOffInfo.nSellGold) and (SellOffInfo.nSellGold > 0) then begin
          if PlayObject.IsEnoughBag then begin
            New(AddSellOffInfo);
            AddSellOffInfo^ := SellOffInfo^;
            if g_SellList.Delete(SellOffInfo, True) then begin
              if g_GoldList.Add(AddSellOffInfo) then begin
                New(UserItem);
                UserItem^ := AddSellOffInfo.UserItem;
                PlayObject.m_ItemList.Add(UserItem);
                PlayObject.SendAddItem(UserItem);
                Dec(PlayObject.m_nGameGold, AddSellOffInfo.nSellGold);
                PlayObject.GameGoldChanged;
                OnlinePlayObject := UserEngine.GetPlayObject(AddSellOffInfo.sCharName);
                if OnlinePlayObject <> nil then begin
                  OnlinePlayObject.SysMsg(PlayObject.m_sCharName + ' purchased your ' + sItemName, c_Red, t_Hint);
                end;

                if g_boGameLogGameGold then begin
                  AddGameDataLog(Format(g_sGameLogMsg1, [LOG_GAMEGOLD,
                    PlayObject.m_sMapName,
                      PlayObject.m_nCurrX,
                      PlayObject.m_nCurrY,
                      PlayObject.m_sCharName,
                      g_Config.sGameGoldName,
                      AddSellOffInfo.nSellGold,
                      '+',
                      m_sCharName]));
                end;

                if StdItem.NeedIdentify = 1 then
                  AddGameDataLog('33' + #9 +
                    PlayObject.m_sMapName + #9 +
                    IntToStr(PlayObject.m_nCurrX) + #9 +
                    IntToStr(PlayObject.m_nCurrY) + #9 +
                    PlayObject.m_sCharName + #9 +
              //UserEngine.GetStdItemName(m_UseItems[I].wIndex) + #9 +
                    StdItem.Name + #9 +
                    IntToStr(UserItem.MakeIndex) + #9 +
                    BoolToIntStr(m_btRaceServer = RC_PLAYOBJECT) + #9 +
                    m_sCharName);

                n1C := 0;
              end else g_SellList.Add(AddSellOffInfo);
            end else Dispose(AddSellOffInfo);
          end else n1C := 2;
        end else n1C := 3;
        bo29 := True;
      end else n1C := 2;
    end;
  end;
  if n1C = 0 then begin
    PlayObject.SendMsg(Self, RM_SENDBUYSELLOFFITEM_OK, 0, PlayObject.m_nGameGold, nInt, 0, '');
  end else begin
    PlayObject.SendMsg(Self, RM_SENDBUYSELLOFFITEM_FAIL, 0, n1C, 0, 0, '');
  end;
end;

function TMerchant.ClientSellOffItem(PlayObject: TPlayObject;
  UserItem: pTUserItem; nSellGold: Integer): Boolean;
  function sub_4A1C84(UserItem: pTUserItem): Boolean;
  var
    StdItem: pTStdItem;
  begin
    Result := True;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) and ((StdItem.StdMode = 25) or (StdItem.StdMode = 30)) then begin
      if UserItem.Dura < 4000 then Result := False;
    end;
  end;
var
  nPrice: Integer;
  StdItem: pTStdItem;
  SellList: TSellList;
begin
  Result := False;
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if StdItem <> nil then begin
    if not CanSellOffItem(StdItem.Name) then begin
      PlayObject.SendMsg(Self, RM_SENDUSERSELLOFFITEM_FAIL, 0, -4, 0, 0, ''); //不允许拍卖
      Exit;
    end;
    if (g_SellList.GetSellListByCharName(PlayObject.m_sCharName, SellList) >= 0) and (SellList.Count >= g_Config.nUserSellOffCount) then begin //超过限制数量
      PlayObject.SendMsg(Self, RM_SENDUSERSELLOFFITEM_FAIL, 0, -3, 0, 0, ''); //超过限制数量
      Exit;
    end;

    if g_Config.boBindItemNoSellOff and (PlayObject.CheckItemBindUse(UserItem, False) = 2) then begin //绑定物品禁止拍卖
      PlayObject.SendMsg(Self, RM_SENDUSERSELLOFFITEM_FAIL, 0, -4, 0, 0, '');
      Exit;
    end;

    if (not bo574) and sub_4A1C84(UserItem) then begin
      if g_SellList.Add(PlayObject.m_sCharName, UserItem, nSellGold) then begin
        PlayObject.SendMsg(Self, RM_SENDUSERSELLOFFITEM_OK, 0, 0, 0, 0, '');
        Result := True;
      end else begin
        //MainOutMessage('g_SellList.Add');
        PlayObject.SendMsg(Self, RM_SENDUSERSELLOFFITEM_FAIL, 0, -1, 0, 0, '');
      end;
    end else begin
      PlayObject.SendMsg(Self, RM_SENDUSERSELLOFFITEM_FAIL, 0, -2, 0, 0, '');
    end;
  end;
end;
////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////拍卖/////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

procedure TMerchant.ClientMakeDrugItem(PlayObject: TPlayObject;
  sItemName: string);
  function sub_4A28FC(PlayObject: TPlayObject; sItemName: string): Boolean;
  var
    I, II, n1C: Integer;
    List10: TStringList;
    s20: string;
    List28: TStringList;
    UserItem: pTUserItem;
  begin
    Result := False;
    List10 := GetMakeItemInfo(sItemName);
    if List10 = nil then Exit;
    Result := True;
    for I := 0 to List10.Count - 1 do begin
      s20 := List10.Strings[I];
      n1C := Integer(List10.Objects[I]);
      for II := 0 to PlayObject.m_ItemList.Count - 1 do begin
        if UserEngine.GetStdItemName(pTUserItem(PlayObject.m_ItemList.Items[II]).wIndex) = s20 then
          Dec(n1C);
      end;
      if n1C > 0 then begin
        Result := False;
        Break;
      end;
    end; // for
    if Result then begin
      List28 := nil;
      for I := 0 to List10.Count - 1 do begin
        s20 := List10.Strings[I];
        n1C := Integer(List10.Objects[I]);
        for II := PlayObject.m_ItemList.Count - 1 downto 0 do begin
          if n1C <= 0 then Break;
          if PlayObject.m_ItemList.Count <= 0 then Break;
          UserItem := PlayObject.m_ItemList.Items[II];
          if UserEngine.GetStdItemName(UserItem.wIndex) = s20 then begin
            if List28 = nil then List28 := TStringList.Create;
            List28.AddObject(s20, TObject(UserItem.MakeIndex));
            PlayObject.m_ItemList.Delete(II);
            Dispose(UserItem);
            Dec(n1C);
          end;
        end;
      end;
      if List28 <> nil then begin
        PlayObject.SendMsg(Self, RM_SENDDELITEMLIST, 0, Integer(List28), 0, 0, '');
      end;
    end;
  end;
var
  I: Integer;
  List1C: TList;
  MakeItem, UserItem: pTUserItem;
  StdItem: pTStdItem;
  n14: Integer;
begin
  n14 := 1;
  for I := 0 to m_GoodsList.Count - 1 do begin
    List1C := TList(m_GoodsList.Items[I]);
    if List1C = nil then Continue;
    if List1C.Count <= 0 then Continue;
    MakeItem := List1C.Items[0];
    if MakeItem = nil then Continue;
    StdItem := UserEngine.GetStdItem(MakeItem.wIndex);
    if (StdItem <> nil) and (StdItem.Name = sItemName) then begin
      if PlayObject.m_nGold >= g_Config.nMakeDurgPrice then begin
        if sub_4A28FC(PlayObject, sItemName) then begin
          New(UserItem);
          UserEngine.CopyToUserItemFromName(sItemName, UserItem);
          if PlayObject.AddItemToBag(UserItem) then begin
            Dec(PlayObject.m_nGold, g_Config.nMakeDurgPrice);
            PlayObject.SendAddItem(UserItem);
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('2' + #9 +
                PlayObject.m_sMapName + #9 +
                IntToStr(PlayObject.m_nCurrX) + #9 +
                IntToStr(PlayObject.m_nCurrY) + #9 +
                PlayObject.m_sCharName + #9 +
                //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                StdItem.Name + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                m_sCharName);
            n14 := 0;
            Break;
          end else begin
            Dispose(UserItem);
            n14 := 2;
          end;
        end else n14 := 4;
      end else n14 := 3;
    end;
  end; // for
  if n14 = 0 then begin
    PlayObject.SendMsg(Self, RM_MAKEDRUG_SUCCESS, 0, PlayObject.m_nGold, 0, 0, '');
  end else begin
    PlayObject.SendMsg(Self, RM_MAKEDRUG_FAIL, 0, n14, 0, 0, '');
  end;
end;

procedure TMerchant.ClientQueryRepairCost(PlayObject: TPlayObject;
  UserItem: pTUserItem);
var
  nPrice, nRepairPrice: Integer;
begin
  nPrice := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
  if (nPrice > 0) and (UserItem.DuraMax > UserItem.Dura) then begin
    if UserItem.DuraMax > 0 then begin
      nRepairPrice := Round(nPrice div 3 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
    end else begin
      nRepairPrice := nPrice;
    end;
    if (PlayObject.m_sScriptLable = sSUPERREPAIR) then begin
      if m_boS_repair then nRepairPrice := nRepairPrice * g_Config.nSuperRepairPriceRate {3}
      else nRepairPrice := -1;
    end else begin
      if not m_boRepair then nRepairPrice := -1;
    end;
    PlayObject.SendMsg(Self, RM_SENDREPAIRCOST, 0, nRepairPrice, 0, 0, '');
  end else begin
    PlayObject.SendMsg(Self, RM_SENDREPAIRCOST, 0, -1, 0, 0, '');
  end;
end;

function TMerchant.ClientRepairItem(PlayObject: TPlayObject;
  UserItem: pTUserItem): Boolean;
var
  nPrice, nRepairPrice: Integer;
  StdItem: pTStdItem;
  boCanRepair: Boolean;
begin
  Result := False;
  boCanRepair := True;
  if (PlayObject.m_sScriptLable = sSUPERREPAIR) and not m_boS_repair then begin
    boCanRepair := False;
  end;
  if (PlayObject.m_sScriptLable <> sSUPERREPAIR) and not m_boRepair then begin
    boCanRepair := False;
  end;
  if PlayObject.m_sScriptLable = '@fail_s_repair' then begin
    SendMsgToUser(PlayObject, 'Sorry, I cant special repair this item\ \ \<Main/@main>');
    PlayObject.SendMsg(Self, RM_USERREPAIRITEM_FAIL, 0, 0, 0, 0, '');
    Exit;
  end;
  nPrice := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
  if PlayObject.m_sScriptLable = sSUPERREPAIR then begin
    nPrice := nPrice * g_Config.nSuperRepairPriceRate {3};
  end;
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if StdItem <> nil then begin
    if boCanRepair and (nPrice > 0) and (UserItem.DuraMax > UserItem.Dura) and (StdItem.StdMode <> 43) then begin
      if UserItem.DuraMax > 0 then begin
        nRepairPrice := Round(nPrice div 3 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
      end else begin
        nRepairPrice := nPrice;
      end;
      if PlayObject.DecGold(nRepairPrice) then begin
        //        if m_boCastle or g_Config.boGetAllNpcTax then UserCastle.IncRateGold(nRepairPrice);
        if m_boCastle or g_Config.boGetAllNpcTax then begin
          if m_Castle <> nil then begin
            TUserCastle(m_Castle).IncRateGold(nRepairPrice);
          end else
            if g_Config.boGetAllNpcTax then begin
            g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
          end;
        end;
        if PlayObject.m_sScriptLable = sSUPERREPAIR then begin
          UserItem.Dura := UserItem.DuraMax;
          PlayObject.SendMsg(Self, RM_USERREPAIRITEM_OK, 0, PlayObject.m_nGold, UserItem.Dura, UserItem.DuraMax, '');
          GotoLable(PlayObject, sSUPERREPAIROK, False);
        end else begin
          Dec(UserItem.DuraMax, (UserItem.DuraMax - UserItem.Dura) div g_Config.nRepairItemDecDura {30});
          UserItem.Dura := UserItem.DuraMax;
          PlayObject.SendMsg(Self, RM_USERREPAIRITEM_OK, 0, PlayObject.m_nGold, UserItem.Dura, UserItem.DuraMax, '');
          GotoLable(PlayObject, sREPAIROK, False);
        end;
        Result := True;
      end else PlayObject.SendMsg(Self, RM_USERREPAIRITEM_FAIL, 0, 0, 0, 0, '');
    end else PlayObject.SendMsg(Self, RM_USERREPAIRITEM_FAIL, 0, 0, 0, 0, '');
  end;
end;

procedure TMerchant.ClearScript;
begin
  m_boBuy := False;
  m_boSell := False;
  m_boMakeDrug := False;
  m_boPrices := False;
  m_boStorage := False;
  m_boGetback := False;
  m_boBigStorage := False;
  m_boBigGetBack := False;
  m_boGetNextPage := False;
  m_boGetPreviousPage := False;
  m_boCqFirHero := False;
  m_boUpgradeItem := False;
  m_boAppDuel := False;
  m_boUserLevelOrder := False;
  m_boWarrorLevelOrder := False;
  m_boWizardLevelOrder := False;
  m_boTaoistLevelOrder := False;
  m_boMasterCountOrder := False;

  m_boUpgradenow := False;
  m_boGetBackupgnow := False;
  m_boRepair := False;
  m_boS_repair := False;
  m_boGetMarry := False;
  m_boGetMaster := False;
  m_boUseItemName := False;

  m_boGetSellGold := False;
  m_boSellOff := False;
  m_boBuyOff := False;
  m_boofflinemsg := False;
  m_boDealGold := False;
  inherited;
end;

procedure TMerchant.LoadUpgradeList;
var
  I: Integer;
begin
  for I := 0 to m_UpgradeWeaponList.Count - 1 do begin
    Dispose(pTUpgradeInfo(m_UpgradeWeaponList.Items[I]));
  end; // for
  m_UpgradeWeaponList.Clear;
  try
    //FrmDB.LoadUpgradeWeaponRecord(m_sCharName,m_UpgradeWeaponList);
    FrmDB.LoadUpgradeWeaponRecord(m_sScript + '-' + m_sMapName, m_UpgradeWeaponList);
  except
    MainOutMessage('Failure in loading upgradinglist - ' + m_sCharName);
  end;
end;

procedure TMerchant.GetMarry(PlayObject: TPlayObject; sDearName: string);
var
  MarryHuman: TPlayObject;
begin
  MarryHuman := UserEngine.GetPlayObject(sDearName);
  if (MarryHuman <> nil) and
    (MarryHuman.m_PEnvir = PlayObject.m_PEnvir) and
    (abs(PlayObject.m_nCurrX - MarryHuman.m_nCurrX) < 5) and
    (abs(PlayObject.m_nCurrY - MarryHuman.m_nCurrY) < 5) then begin
    SendMsgToUser(MarryHuman, PlayObject.m_sCharName + ' 向你求婚，你是否愿意嫁给他为妻？');
  end else begin
    Self.SendMsgToUser(PlayObject, sDearName + ' 没有在你身边，你的请求无效！！！');
  end;
end;

procedure TMerchant.GetMaster(PlayObject: TPlayObject; sMasterName: string);
begin

end;

procedure TMerchant.SendCustemMsg(PlayObject: TPlayObject; sMsg: string);
begin
  inherited;

end;
//清除临时文件，包括交易库存，价格表

procedure TMerchant.ClearData;
var
  I, II: Integer;
  UserItem: pTUserItem;
  ItemList: TList;
  ItemPrice: pTItemPrice;
resourcestring
  sExceptionMsg = '[Exception] TMerchant::ClearData';
begin
  try
    for I := 0 to m_GoodsList.Count - 1 do begin
      ItemList := TList(m_GoodsList.Items[I]);
      for II := 0 to ItemList.Count - 1 do begin
        UserItem := ItemList.Items[II];
        Dispose(UserItem);
      end;
      ItemList.Free;
    end;
    m_GoodsList.Clear;
    for I := 0 to m_ItemPriceList.Count - 1 do begin
      ItemPrice := m_ItemPriceList.Items[I];
      Dispose(ItemPrice);
    end;
    m_ItemPriceList.Clear;
    SaveNPCData();
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TMerchant.ChangeUseItemName(PlayObject: TPlayObject;
  sLabel, sItemName: string);
var
  sWhere: string;
  btWhere: Byte;
  UserItem: pTUserItem;
  nLabelLen: Integer;
  sMsg: string;
  sItemNewName: string;
  StdItem: pTStdItem;
  sChangeUseItemName: string;
begin
  if not PlayObject.m_boChangeItemNameFlag then begin
    Exit;
  end;
  PlayObject.m_boChangeItemNameFlag := False;
  sWhere := Copy(sLabel, Length(sUSEITEMNAME) + 1, Length(sLabel) - Length(sUSEITEMNAME));
  btWhere := Str_ToInt(sWhere, -1);
  if btWhere in [Low(THumanUseItems)..High(THumanUseItems)] then begin
    UserItem := @PlayObject.m_UseItems[btWhere];
    if UserItem.wIndex = 0 then begin
      sMsg := Format(g_sYourUseItemIsNul, [GetUseItemName(btWhere)]);
      PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, sMsg);
      Exit;
    end;
    if UserItem.btValue[13] = 1 then begin
      ItemUnit.DelCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
    end;
    if sItemName <> '' then begin
      if g_Config.boChangeUseItemNameByPlayName then begin
        sChangeUseItemName := PlayObject.m_sCharName + '的' + sItemName;
      end else begin
        sChangeUseItemName := g_Config.sChangeUseItemName + sItemName;
      end;
      ItemUnit.AddCustomItemName(UserItem.MakeIndex, UserItem.wIndex, sChangeUseItemName);
      UserItem.btValue[13] := 1;
    end else begin
      ItemUnit.DelCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
      UserItem.btValue[13] := 0;
    end;
    ItemUnit.SaveCustomItemName();
    PlayObject.SendMsg(PlayObject, RM_SENDUSEITEMS, 0, 0, 0, 0, '');
    PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, '');
  end;
end;

{ TTrainer }

constructor TTrainer.Create;
begin
  inherited;
  m_dw568 := GetTickCount();
  n56C := 0;
  n570 := 0;
end;

destructor TTrainer.Destroy;
begin

  inherited;
end;

function TTrainer.Operate(ProcessMsg: pTProcessMessage): Boolean; //004A38C4
begin
  Result := False;
  if (ProcessMsg.wIdent = RM_STRUCK) or (ProcessMsg.wIdent = RM_MAGSTRUCK) then begin
    //  if (ProcessMsg.wIdent = RM_10101) or (ProcessMsg.wIdent = RM_MAGSTRUCK) then begin

    if (ProcessMsg.BaseObject = Self) { and (ProcessMsg.nParam3 <> 0)} then begin
      Inc(n56C, ProcessMsg.wParam);
      m_dw568 := GetTickCount();
      Inc(n570);
      ProcessSayMsg('Destructive power is  ' + IntToStr(ProcessMsg.wParam) + ', Average  is ' + IntToStr(n56C div n570));
    end;
  end;
  if ProcessMsg.wIdent = RM_MAGSTRUCK then
    Result := inherited Operate(ProcessMsg);
end;

procedure TTrainer.Run;
begin
  m_WAbil.HP := m_WAbil.MaxHP;
  if n570 > 0 then begin
    if (GetTickCount - m_dw568) > 3 * 1000 then begin
      ProcessSayMsg('Total destructive power is  ' + IntToStr(n56C) + ', Average destructive power is ' + IntToStr(n56C div n570));
      n570 := 0;
      n56C := 0;
    end;
  end;
  inherited;
end;
{ TNormNpc }

procedure TNormNpc.ActionOfAddNameDateList(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  LoadList: TStringList;
  boFound: Boolean;
  sListFileName, sLineText, sHumName, sDate: string;
begin
  sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
  LoadList := TStringList.Create;
  if FileExists(sListFileName) then begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
      LoadList.Free;
      Exit;
    end;
  end;
  boFound := False;
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := Trim(LoadList.Strings[I]);
    sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
    sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
    if CompareText(sHumName, BaseObject.m_sCharName) = 0 then begin
      LoadList.Strings[I] := BaseObject.m_sCharName + #9 + DateToStr(Date);
      boFound := True;
      Break;
    end;
  end;
  if not boFound then
    LoadList.Add(BaseObject.m_sCharName + #9 + DateToStr(Date));
  try
    LoadList.SaveToFile(sListFileName);
  except
    MainOutMessage('saving fail.... => ' + sListFileName);
  end;
  LoadList.Free;
end;

procedure TNormNpc.ActionOfDelNameDateList(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  LoadList: TStringList;
  sLineText, sListFileName, sHumName, sDate: string;
  boFound: Boolean;
begin
  sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
  LoadList := TStringList.Create;
  if FileExists(sListFileName) then begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
      LoadList.Free;
      Exit;
    end;
  end;
  boFound := False;
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := Trim(LoadList.Strings[I]);
    sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
    sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
    if CompareText(sHumName, BaseObject.m_sCharName) = 0 then begin
      LoadList.Delete(I);
      boFound := True;
      Break;
    end;
  end;
  if boFound then begin
    try
      LoadList.SaveToFile(sListFileName);
    except
      MainOutMessage('saving fail.... => ' + sListFileName);
    end;
  end;
  LoadList.Free;
end;

procedure TNormNpc.ActionOfAddGuildNameDateList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  LoadList: TStringList;
  boFound: Boolean;
  sListFileName, sLineText, sHumName, sDate: string;
begin
  if PlayObject.m_MyGuild <> nil then begin
    sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
    LoadList := TStringList.Create;
    if FileExists(sListFileName) then begin
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
    end;
    boFound := False;
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
      if CompareText(sHumName, TGUild(PlayObject.m_MyGuild).sGuildName) = 0 then begin
        LoadList.Strings[I] := TGUild(PlayObject.m_MyGuild).sGuildName + #9 + DateToStr(Date);
        boFound := True;
        Break;
      end;
    end;
    if not boFound then
      LoadList.Add(TGUild(PlayObject.m_MyGuild).sGuildName + #9 + DateToStr(Date));
    try
      LoadList.SaveToFile(sListFileName);
    except
      MainOutMessage('saving fail.... => ' + sListFileName);
    end;
    LoadList.Free;
  end;
end;

procedure TNormNpc.ActionOfDelGuildNameDateList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  LoadList: TStringList;
  sLineText, sListFileName, sHumName, sDate: string;
  boFound: Boolean;
begin
  if PlayObject.m_MyGuild <> nil then begin
    sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
    LoadList := TStringList.Create;
    if FileExists(sListFileName) then begin
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
        LoadList.Free;
        Exit;
      end;
    end;
    boFound := False;
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
      if CompareText(sHumName, TGUild(PlayObject.m_MyGuild).sGuildName) = 0 then begin
        LoadList.Delete(I);
        boFound := True;
        Break;
      end;
    end;
    if boFound then begin
      try
        LoadList.SaveToFile(sListFileName);
      except
        MainOutMessage('saving fail.... => ' + sListFileName);
      end;
    end;
    LoadList.Free;
  end;
end;

procedure TNormNpc.ActionOfGoHome(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nX, nY: Integer;
begin
  PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
  if PlayObject.PKLevel < 2 then begin
    PlayObject.GetRandomHomePoint(nX, nY);
    PlayObject.BaseObjectMove(PlayObject.m_sHomeMap, IntToStr(nX), IntToStr(nY));
    //PlayObject.BaseObjectMove(PlayObject.m_sHomeMap, IntToStr(PlayObject.m_nHomeX), IntToStr(PlayObject.m_nHomeY));
  end else begin
    PlayObject.BaseObjectMove(g_Config.sRedHomeMap, IntToStr(g_Config.nRedHomeX), IntToStr(g_Config.nRedHomeY));
  end;
end;

procedure TNormNpc.ActionOfAddBlockIP(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  UserEngine.AddIPToGateBlockList(PlayObject.m_sIPaddr);
end;

procedure TNormNpc.ActionOfMovData(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nPos: Integer;

  VarInfo: TVarInfo;
  sVar1, sVar2: string;
  nValue1: Integer;
  nValue2: Integer;

  sValue1: string;
  sValue2: string;

  sVarName1: string;
  sVarName2: string;

  UserObject1: TPlayObject;
  UserObject2: TPlayObject;
begin
  if (QuestActionInfo.sParam1 = '') or (QuestActionInfo.sParam2 = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOVDATA);
    Exit;
  end;

  UserObject1 := nil;
  UserObject2 := nil;

  sValue1 := '';
  sValue2 := '';

  sVarName1 := '';
  sVarName2 := '';

  nPos := Pos('.', QuestActionInfo.sParam2);
  if nPos > 0 then begin
    sValue1 := Copy(QuestActionInfo.sParam2, 1, nPos - 1);
    sValue2 := Copy(QuestActionInfo.sParam2, nPos + 1, Length(QuestActionInfo.sParam2) - nPos);
    VarInfo := GetVarValue(PlayObject, sValue1, sVar1, sValue1, nValue1);
    if sValue1 = PlayObject.m_sCharName then begin
      UserObject2 := PlayObject;
    end else begin
      UserObject2 := UserEngine.GetPlayObject(sValue1);
    end;
    sVarName2 := sValue2;
  end else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOVDATA);
    Exit;
  end;

  nPos := Pos('.', QuestActionInfo.sParam1);
  if nPos > 0 then begin
    sValue1 := Copy(QuestActionInfo.sParam1, 1, nPos - 1);
    sValue2 := Copy(QuestActionInfo.sParam1, nPos + 1, Length(QuestActionInfo.sParam1) - nPos);
    VarInfo := GetVarValue(PlayObject, sValue1, sVar1, sValue1, nValue1);
    if sValue1 = PlayObject.m_sCharName then begin
      UserObject1 := PlayObject;
    end else begin
      UserObject1 := UserEngine.GetPlayObject(sValue1);
    end;
    sVarName1 := sValue2;
  end else begin
    UserObject1 := PlayObject;
    sValue1 := QuestActionInfo.sParam1;
    sVarName1 := QuestActionInfo.sParam1;
  end;

  if (UserObject1 <> nil) and (UserObject2 <> nil) and (sVarName1 <> '') and (sVarName2 <> '') then begin
    VarInfo := GetVarValue(UserObject2, sVarName2, sVar2, sValue2, nValue2);
    VarInfo := GetVarValue(UserObject1, sVarName1, sVar1, sValue1, nValue1);
    case VarInfo.VarAttr of
      aNone, aConst: begin
          ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOVDATA);
          Exit;
        end;
      aFixStr: begin
          SetValNameValue(UserObject1, sVar1, sValue2, nValue2);
        end;
      aDynamic: begin
          SetDynamicValue(UserObject1, sVar1, sValue2, nValue2);
        end;
    end;
  end else ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOVDATA);
end;

procedure TNormNpc.ActionOfAddSkill(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I, nMaxLevel: Integer;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
  nLevel: Integer;
  boIsHero: Boolean;
  nMagicCount: Integer;
begin
  if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    Magic := UserEngine.FindMagic(QuestActionInfo.sParam1);
  end else
    if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
    Magic := UserEngine.FindHeroMagic(QuestActionInfo.sParam1);
  end else begin
    Magic := UserEngine.FindMagic(QuestActionInfo.sParam1);
  end;

  {if Magic = nil then begin

    MainOutMessage('TNormNpc::ActionOfAddSkill:'+QuestActionInfo.sParam1+' RaceServer:'+IntToStr(BaseObject.m_btRaceServer));
  end;}

  if Magic <> nil then begin

    if (BaseObject.m_btRaceServer = RC_HEROOBJECT) and (Magic.wMagicId in [13, 26, 45]) then
      nMaxLevel := 4 else nMaxLevel := 3;

    nLevel := _MIN(nMaxLevel, Str_ToInt(QuestActionInfo.sParam2, 0));

    if not BaseObject.IsTrainingSkill(Magic.wMagicId) then begin
      New(UserMagic);
      UserMagic.MagicInfo := Magic;
      UserMagic.wMagIdx := Magic.wMagicId;

      if BaseObject.m_boAI then
        UserMagic.btKey := VK_F1
      else
        UserMagic.btKey := 0;

      UserMagic.btLevel := nLevel;
      UserMagic.nTranPoint := 0;
      BaseObject.m_MagicList.Add(UserMagic);
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
        TPlayObject(BaseObject).SendAddMagic(UserMagic);
      end else
        if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
        UserMagic.btKey := VK_F1;
        THeroObject(BaseObject).SendAddMagic(UserMagic);
      end;

      BaseObject.RecalcAbilitys();
      if g_Config.boShowScriptActionMsg then begin
        if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
          BaseObject.SysMsg(Magic.sMagicName + '练习成功。', c_Green, t_Hint);
        end;
      end;
    end;
  end else begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_ADDSKILL);
  end;
end;

procedure TNormNpc.ActionOfAutoAddGameGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo; nPoint, nTime: Integer);
var
  sMsg: string;
begin
  if CompareText(QuestActionInfo.sParam1, 'START') = 0 then begin
    if (nPoint > 0) and (nTime > 0) then begin
      PlayObject.m_nIncGameGold := nPoint;
      PlayObject.m_dwIncGameGoldTime := LongWord(nTime * 1000);
      PlayObject.m_dwIncGameGoldTick := GetTickCount();
      PlayObject.m_boIncGameGold := True;
      Exit;
    end;
  end;
  if CompareText(QuestActionInfo.sParam1, 'STOP') = 0 then begin
    PlayObject.m_boIncGameGold := False;
    Exit;
  end;
  ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AUTOADDGAMEGOLD);
end;

//SETAUTOGETEXP 时间 点数 是否安全区 地图号

procedure TNormNpc.ActionOfAutoGetExp(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nTime, nPoint: Integer;
  boIsSafeZone: Boolean;
  sMAP: string;
  Envir: TEnvirnoment;
begin
  Envir := nil;
  nTime := Str_ToInt(QuestActionInfo.sParam1, -1);
  nPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  boIsSafeZone := QuestActionInfo.sParam3[1] = '1';
  sMAP := QuestActionInfo.sParam4;
  if sMAP <> '' then begin
    Envir := g_MapManager.FindMap(sMAP);
  end;
  if (nTime <= 0) or (nPoint <= 0) or ((sMAP <> '') and (Envir = nil)) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETAUTOGETEXP);
    Exit;
  end;
  PlayObject.m_boAutoGetExpInSafeZone := boIsSafeZone;
  PlayObject.m_AutoGetExpEnvir := Envir;
  PlayObject.m_nAutoGetExpTime := nTime * 1000;
  PlayObject.m_nAutoGetExpPoint := nPoint;
end;

procedure TNormNpc.ActionOfAutoSubGameGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo; nPoint, nTime: Integer);
var
  sMsg: string;
begin
  if CompareText(QuestActionInfo.sParam1, 'START') = 0 then begin
    if (nPoint > 0) and (nTime > 0) then begin
      PlayObject.m_nDecGameGold := nPoint;
      PlayObject.m_dwDecGameGoldTime := LongWord(nTime * 1000);
      PlayObject.m_dwDecGameGoldTick := 0;
      PlayObject.m_boDecGameGold := True;
      Exit;
    end;
  end;
  if CompareText(QuestActionInfo.sParam1, 'STOP') = 0 then begin
    PlayObject.m_boDecGameGold := False;
    Exit;
  end;
  ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AUTOSUBGAMEGOLD);
end;

procedure TNormNpc.ActionOfChangeCreditPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  boChgOK: Boolean;
  nCreditPoint: Integer;
  nLv: Integer;
  nOldLevel: Integer;
  cMethod: Char;
  dwInt: LongWord;
begin
  boChgOK := False;
  nCreditPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (nCreditPoint < 0) then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam2, nCreditPoint);
    if (nCreditPoint < 0) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CREDITPOINT);
      Exit;
    end;
  end;

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        if nCreditPoint >= 0 then begin
          if nCreditPoint > High(Integer) then begin
            PlayObject.m_btCreditPoint := High(Integer);
          end else begin
            PlayObject.m_btCreditPoint := nCreditPoint;
          end;
        end;
      end;
    '-': begin
        if PlayObject.m_btCreditPoint > Integer(nCreditPoint) then begin
          Dec(PlayObject.m_btCreditPoint, Integer(nCreditPoint));
        end else begin
          PlayObject.m_btCreditPoint := 0;
        end;
      end;
    '+': begin
        if PlayObject.m_btCreditPoint + Integer(nCreditPoint) > High(Integer) then begin
          PlayObject.m_btCreditPoint := High(Integer);
        end else begin
          Inc(PlayObject.m_btCreditPoint, Integer(nCreditPoint));
        end;
      end;
  else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CREDITPOINT);
      Exit;
    end;
  end;
end;

procedure TNormNpc.ActionOfChangeExp(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  boChgOK: Boolean;
  nExp: Integer;
  nLv: Integer;
  nOldLevel: Integer;
  cMethod: Char;
  dwInt: LongWord;
  dwExp: LongWord;
begin
  boChgOK := False;
  nExp := Str_ToInt(QuestActionInfo.sParam2, -1);
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam2, nExp);
  end else
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
    GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam2, nExp);
  end;

  if nExp < 0 then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_CHANGEEXP);
    Exit;
  end;

  dwExp := LongWord(nExp);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        if dwExp >= 0 then begin
          if (dwExp > BaseObject.m_Abil.Exp) then begin
            BaseObject.GetExp(dwExp - BaseObject.m_Abil.Exp);
          end else begin
            BaseObject.m_Abil.Exp := dwExp;
            BaseObject.HasLevelUp(BaseObject.m_Abil.Level - 1);
          end;
        end;
      end;
    '-': begin
        if BaseObject.m_Abil.Exp > dwExp then begin
          Dec(BaseObject.m_Abil.Exp, dwExp);
        end else begin
          BaseObject.m_Abil.Exp := 0;
        end;
      end;
    '+': begin
        BaseObject.GetExp(dwExp);
        {if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
          TPlayObject(BaseObject).IncBeadExp(LongWord(nExp));
        end;}
        {if BaseObject.m_Abil.Exp >= LongWord(nExp) then begin
          if (BaseObject.m_Abil.Exp - LongWord(nExp)) > (High(LongWord) - BaseObject.m_Abil.Exp) then begin
            dwInt := High(LongWord) - BaseObject.m_Abil.Exp;
          end else begin
            dwInt := LongWord(nExp);
          end;
        end else begin
          if (LongWord(nExp) - BaseObject.m_Abil.Exp) > (High(LongWord) - LongWord(nExp)) then begin
            dwInt := High(LongWord) - LongWord(nExp);
          end else begin
            dwInt := LongWord(nExp);
          end;
        end;
        Inc(BaseObject.m_Abil.Exp, dwInt);
        if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
          BaseObject.SendMsg(BaseObject, RM_WINEXP, 0, dwInt, 0, 0, '');
        end; }
      end;
  end;
end;

procedure TNormNpc.ActionOfChangeHairStyle(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nHair: Integer;
begin
  nHair := Str_ToInt(QuestActionInfo.sParam1, -1);
  if nHair < 0 then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam1, nHair);
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam1, nHair);
    end;
  end;
  if (QuestActionInfo.sParam1 <> '') and (nHair >= 0) then begin
    case BaseObject.m_btGender of
      0: begin
          if not nHair in [0, 2] then nHair := 2;
        end;
      1: begin
          if not nHair in [1, 3] then begin
            case Random(2) of
              0: nHair := 1;
              1: nHair := 3;
            else nHair := 0;
            end;
          end;
        end;
    end;
    BaseObject.m_btHair := nHair;
    BaseObject.FeatureChanged;
  end else begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_HAIRSTYLE);
  end;
end;

procedure TNormNpc.ActionOfChangeJob(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nParam, nJob: Integer;
begin
  nJob := -1;
  if CompareLStr(QuestActionInfo.sParam1, sWARRIOR, 3) then nJob := 0;
  if CompareLStr(QuestActionInfo.sParam1, sWIZARD, 3) then nJob := 1;
  if CompareLStr(QuestActionInfo.sParam1, sTAOS, 3) then nJob := 2;

  if nJob < 0 then begin
    nParam := Str_ToInt(QuestActionInfo.sParam1, -1);
    if nParam < 0 then begin
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
        GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam1, nParam);
      end else
        if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
        GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam1, nParam);
      end;
    end;
    nJob := nParam;
  end;

  if nJob < 0 then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_CHANGEJOB);
    Exit;
  end;

  if not (nJob in [0..2]) then nJob := 2;

  if BaseObject.m_btJob <> nJob then begin

    BaseObject.m_btJob := nJob;
    {
    PlayObject.RecalcLevelAbilitys();
    PlayObject.RecalcAbilitys();
    }
    BaseObject.HasLevelUp(0);
  end;
end;

procedure TNormNpc.ActionOfChangeLevel(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  boChgOK: Boolean;
  nLevel: Integer;
  nLv: Integer;
  nOldLevel: Integer;
  cMethod: Char;
  nMaxLevel: Integer;

begin
  boChgOK := False;
  nOldLevel := BaseObject.m_Abil.Level;
  nLevel := Str_ToInt(QuestActionInfo.sParam2, -1);

  if nLevel < 0 then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam2, nLevel);
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam2, nLevel);
    end;
  end;

  if nLevel < 0 then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_CHANGELEVEL);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];

  nMaxLevel := g_Config.nMaxLevel;

  case cMethod of
    '=': begin
        if (nLevel > 0) and (nLevel <= nMaxLevel) then begin
          BaseObject.m_Abil.Level := nLevel;
          BaseObject.m_Abil.MaxExp := BaseObject.GetLevelExp(BaseObject.m_Abil.Level);
          boChgOK := True;
        end;
      end;
    '-': begin
        nLv := _MAX(0, BaseObject.m_Abil.Level - nLevel);
        nLv := MinLong(nMaxLevel, nLv);
        BaseObject.m_Abil.Level := nLv;
        BaseObject.m_Abil.MaxExp := BaseObject.GetLevelExp(BaseObject.m_Abil.Level);
        boChgOK := True;
      end;
    '+': begin
        nLv := MaxLong(0, BaseObject.m_Abil.Level + nLevel);
        nLv := MinLong(nMaxLevel, nLv);
        BaseObject.m_Abil.Level := nLv;
        BaseObject.m_Abil.MaxExp := BaseObject.GetLevelExp(BaseObject.m_Abil.Level);
        boChgOK := True;
      end;
  end;
  if boChgOK then begin
    if BaseObject.m_Abil.Exp > BaseObject.m_Abil.MaxExp then
      BaseObject.m_Abil.Exp := BaseObject.m_Abil.MaxExp;
    BaseObject.HasLevelUp(nOldLevel);
  end;
end;

procedure TNormNpc.ActionOfChangePkPoint(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nPKPOINT: Integer;
  nPoint: Integer;
  nOldPKLevel: Integer;
  cMethod: Char;
begin
  nOldPKLevel := BaseObject.PKLevel;
  nPKPOINT := Str_ToInt(QuestActionInfo.sParam2, -1);
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam2, nPKPOINT);
  end;
  if nPKPOINT < 0 then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_CHANGEPKPOINT);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        if (nPKPOINT >= 0) then begin
          BaseObject.m_nPkPoint := nPKPOINT;
        end;
      end;
    '-': begin
        nPoint := _MAX(0, BaseObject.m_nPkPoint - nPKPOINT);
        BaseObject.m_nPkPoint := nPoint;
      end;
    '+': begin
        nPoint := _MAX(0, BaseObject.m_nPkPoint + nPKPOINT);
        BaseObject.m_nPkPoint := nPoint;
      end;
  end;
  if nOldPKLevel <> BaseObject.PKLevel then
    BaseObject.RefNameColor;
end;

procedure TNormNpc.ActionOfClearMapMon(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  mon: TActorObject;
  Envir: TEnvirnoment;
  MonGen: pTMonGenInfo;
  I, II: Integer;
  MonList: TList;
begin
  Envir := g_MapManager.FindMap(QuestActionInfo.sParam1);
  if Envir <> nil then begin
    MonList := TList.Create;
    UserEngine.GetMapMonster(Envir, MonList);
    for I := 0 to MonList.Count - 1 do begin
      mon := TActorObject(MonList.Items[I]);
      if mon.m_Master <> nil then Continue;
      if GetNoClearMonList(mon.m_sCharName) then Continue;
      mon.m_boNoItem := True;
      mon.MakeGhost;
    end;
    MonList.Free;
  end;
end;

procedure TNormNpc.ActionOfClearNameList(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  LoadList: TStringList;
  sListFileName: string;
begin
  sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
  LoadList := TStringList.Create;
  {
  if FileExists(sListFileName) then begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
  end;
  }
  LoadList.Clear;
  try
    LoadList.SaveToFile(sListFileName);
  except
    MainOutMessage('saving fail.... => ' + sListFileName);
  end;
  LoadList.Free;
end;

procedure TNormNpc.ActionOfClearSkill(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  UserMagic: pTUserMagic;
begin
  for I := BaseObject.m_MagicList.Count - 1 downto 0 do begin
    UserMagic := BaseObject.m_MagicList.Items[I];
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      TPlayObject(BaseObject).SendDelMagic(UserMagic);
    end else begin
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
        THeroObject(BaseObject).SendDelMagic(UserMagic);
      end;
    end;
    BaseObject.m_MagicList.Delete(I);
    Dispose(UserMagic);
  end;
  BaseObject.RecalcAbilitys();
end;

procedure TNormNpc.ActionOfDelNoJobSkill(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  UserMagic: pTUserMagic;
begin
  for I := BaseObject.m_MagicList.Count - 1 downto 0 do begin
    if BaseObject.m_MagicList.Count <= 0 then Break;
    UserMagic := BaseObject.m_MagicList.Items[I];
    if (UserMagic.MagicInfo.btJob <> 99) and (UserMagic.MagicInfo.btJob <> BaseObject.m_btJob) then begin
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
        TPlayObject(BaseObject).SendDelMagic(UserMagic);
      end else begin
        if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
          THeroObject(BaseObject).SendDelMagic(UserMagic);
        end;
      end;
      Dispose(UserMagic);
      BaseObject.m_MagicList.Delete(I);
    end;
  end;
end;

procedure TNormNpc.ActionOfDelSkill(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sMagicName: string;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
begin
  sMagicName := QuestActionInfo.sParam1;

  if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    Magic := UserEngine.FindMagic(sMagicName);
  end else
    if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
    Magic := UserEngine.FindHeroMagic(sMagicName);
  end else begin
    Magic := UserEngine.FindMagic(sMagicName);
  end;

  if Magic = nil then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_DELSKILL);
    Exit;
  end;

  for I := BaseObject.m_MagicList.Count - 1 downto 0 do begin
    if BaseObject.m_MagicList.Count <= 0 then Break;
    UserMagic := BaseObject.m_MagicList.Items[I];
    if UserMagic.MagicInfo = Magic then begin
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
        TPlayObject(BaseObject).SendDelMagic(UserMagic);
      end else begin
        if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
          THeroObject(BaseObject).SendDelMagic(UserMagic);
        end;
      end;
      BaseObject.m_MagicList.Delete(I);
      Dispose(UserMagic);
      BaseObject.RecalcAbilitys();
      Break;
    end;
  end;
end;

procedure TNormNpc.ActionOfGameGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGameGold: Integer;
  nOldGameGold: Integer;
  cMethod: Char;
begin
  nOldGameGold := PlayObject.m_nGameGold;
  nGameGold := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (nGameGold < 0) then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam2, nGameGold);
    if (nGameGold < 0) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GAMEGOLD);
      Exit;
    end;
  end;

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        if (nGameGold >= 0) then begin
          PlayObject.m_nGameGold := nGameGold;
        end;
      end;
    '-': begin
        nGameGold := _MAX(0, PlayObject.m_nGameGold - nGameGold);
        PlayObject.m_nGameGold := nGameGold;
      end;
    '+': begin
        nGameGold := _MAX(0, PlayObject.m_nGameGold + nGameGold);
        PlayObject.m_nGameGold := nGameGold;
      end;
  end;
  //'%d'#9'%s'#9'%d'#9'%d'#9'%s'#9'%s'#9'%d'#9'%s'#9'%s'
  if g_boGameLogGameGold then begin
    AddGameDataLog(Format(g_sGameLogMsg1, [LOG_GAMEGOLD,
      PlayObject.m_sMapName,
        PlayObject.m_nCurrX,
        PlayObject.m_nCurrY,
        PlayObject.m_sCharName,
        g_Config.sGameGoldName,
        nGameGold,
        cMethod,
        m_sCharName]));
  end;
  if nOldGameGold <> PlayObject.m_nGameGold then
    PlayObject.GameGoldChanged;
end;

procedure TNormNpc.ActionOfGamePoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGamePoint: Integer;
  nOldGamePoint: Integer;
  cMethod: Char;
begin
  nOldGamePoint := PlayObject.m_nGamePoint;
  nGamePoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (nGamePoint < 0) then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam2, nGamePoint);
    if (nGamePoint < 0) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GAMEPOINT);
      Exit;
    end;
  end;

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        if (nGamePoint >= 0) then begin
          PlayObject.m_nGamePoint := nGamePoint;
        end;
      end;
    '-': begin
        nGamePoint := _MAX(0, PlayObject.m_nGamePoint - nGamePoint);
        PlayObject.m_nGamePoint := nGamePoint;
      end;
    '+': begin
        nGamePoint := _MAX(0, PlayObject.m_nGamePoint + nGamePoint);
        PlayObject.m_nGamePoint := nGamePoint;
      end;
  end;
  //'%d'#9'%s'#9'%d'#9'%d'#9'%s'#9'%s'#9'%d'#9'%s'#9'%s'
  if g_boGameLogGamePoint then begin
    AddGameDataLog(Format(g_sGameLogMsg1, [LOG_GAMEPOINT,
      PlayObject.m_sMapName,
        PlayObject.m_nCurrX,
        PlayObject.m_nCurrY,
        PlayObject.m_sCharName,
        g_Config.sGamePointName,
        nGamePoint,
        cMethod,
        m_sCharName]));
  end;
  if nOldGamePoint <> PlayObject.m_nGamePoint then
    PlayObject.GameGoldChanged;
end;

procedure TNormNpc.ActionOfGetMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseBaseObject: TActorObject;
begin
  PoseBaseObject := PlayObject.GetPoseCreate();
  if (PoseBaseObject <> nil) and (PoseBaseObject.m_btRaceServer = RC_PLAYOBJECT) and (PoseBaseObject.m_btGender <> PlayObject.m_btGender) then begin
    PlayObject.m_sDearName := PoseBaseObject.m_sCharName;
    PlayObject.RefShowName;
    PoseBaseObject.RefShowName;
  end else begin
    GotoLable(PlayObject, '@MarryError', False);
  end;
end;

procedure TNormNpc.ActionOfGetMaster(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseBaseObject: TActorObject;
begin
  PoseBaseObject := PlayObject.GetPoseCreate();
  if (PoseBaseObject <> nil) and (PoseBaseObject.m_btRaceServer = RC_PLAYOBJECT) and (PoseBaseObject.m_btGender <> PlayObject.m_btGender) then begin
    PlayObject.m_sMasterName := PoseBaseObject.m_sCharName;
    PlayObject.RefShowName;
    PoseBaseObject.RefShowName;
  end else begin
    GotoLable(PlayObject, '@MasterError', False);
  end;
end;

procedure TNormNpc.ActionOfLineMsg(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMsg: string;
  sParam2: string;
begin
  sParam2 := QuestActionInfo.sParam2;
  GetVarValue(PlayObject, QuestActionInfo.sParam2, sParam2);

  sMsg := GetLineVariableText(PlayObject, sParam2);
  sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.GetUnknowCharName);
  sMsg := AnsiReplaceText(sMsg, '%x', IntToStr(PlayObject.m_nCurrX));
  sMsg := AnsiReplaceText(sMsg, '%y', IntToStr(PlayObject.m_nCurrY));
  if PlayObject.m_PEnvir <> nil then
    sMsg := AnsiReplaceText(sMsg, '%m', PlayObject.m_PEnvir.sMapDesc)
  else sMsg := AnsiReplaceText(sMsg, '%m', '????');
  sMsg := AnsiReplaceText(sMsg, '%d', m_sCharName);
  case QuestActionInfo.nParam1 of
    0: UserEngine.SendBroadCastMsg(sMsg, t_System);
    1: UserEngine.SendBroadCastMsg('(*) ' + sMsg, t_System);
    2: UserEngine.SendBroadCastMsg('[' + m_sCharName + ']' + sMsg, t_System);
    3: UserEngine.SendBroadCastMsg('[' + PlayObject.GetUnknowCharName + ']' + sMsg, t_System);
    4: ProcessSayMsg(sMsg);
    5: PlayObject.SysMsg(sMsg, c_Red, t_Say);
    6: PlayObject.SysMsg(sMsg, c_Green, t_Say);
    7: PlayObject.SysMsg(sMsg, c_Blue, t_Say);
    8: if PlayObject.m_MyGuild <> nil then TGUild(PlayObject.m_MyGuild).SendGuildMsg(sMsg);
  else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSENDMSG);
    end;
  end;
end;

procedure TNormNpc.ActionOfSendColorMsg(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMsg: string;
  sParam4: string;
  nFColor, nBColor: Integer;
begin
  nFColor := Str_ToInt(QuestActionInfo.sParam2, -1);
  nBColor := Str_ToInt(QuestActionInfo.sParam3, -1);
  if (nFColor < 0) or (nFColor > 255) or (nBColor < 0) or (nBColor > 255) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SENDCOLORMSG);
    Exit;
  end;

  sParam4 := QuestActionInfo.sParam4;

  GetVarValue(PlayObject, QuestActionInfo.sParam4, sParam4);

  sMsg := GetLineVariableText(PlayObject, sParam4);
  sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.GetUnknowCharName);
  sMsg := AnsiReplaceText(sMsg, '%x', IntToStr(PlayObject.m_nCurrX));
  sMsg := AnsiReplaceText(sMsg, '%y', IntToStr(PlayObject.m_nCurrY));
  if PlayObject.m_PEnvir <> nil then
    sMsg := AnsiReplaceText(sMsg, '%m', PlayObject.m_PEnvir.sMapDesc)
  else sMsg := AnsiReplaceText(sMsg, '%m', '????');
  sMsg := AnsiReplaceText(sMsg, '%d', m_sCharName);
  case QuestActionInfo.nParam1 of
    0: UserEngine.SendBroadCastMsg(sMsg, nFColor, nBColor, t_System);
    1: PlayObject.SysMsg(sMsg, nFColor, nBColor, t_Say);
  end;
end;

procedure TNormNpc.ActionOfAddRandomMapGate(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nX, nY: Integer;
  sName, sSMapNO: string;
  nSMapX, nSMapY: Integer;
  sDMapNO: string;
  nDMapX, nDMapY: Integer;
begin
  if (QuestActionInfo.sParam1 = '') or (QuestActionInfo.sParam2 = '') or (QuestActionInfo.sParam3 = '')
    or (QuestActionInfo.sParam4 = '') or (QuestActionInfo.sParam5 = '') or (QuestActionInfo.sParam6 = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDRANDOMMAPGATE);
    Exit;
  end;
  sName := QuestActionInfo.sParam1;
  if QuestActionInfo.sParam3 = '->' then begin
    nDMapX := Str_ToInt(QuestActionInfo.sParam5, -1);
    nDMapY := Str_ToInt(QuestActionInfo.sParam6, -1);
    if (nDMapX < 0) or (nDMapY < 0) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDRANDOMMAPGATE);
      Exit;
    end;
    sSMapNO := QuestActionInfo.sParam2;
    sDMapNO := QuestActionInfo.sParam4;
    g_MapManager.AddMapRoute(sName, sSMapNO, -1, -1, sDMapNO, nDMapX, nDMapY);
  end else
    if QuestActionInfo.sParam5 = '->' then begin
    nSMapX := Str_ToInt(QuestActionInfo.sParam3, -1);
    nSMapY := Str_ToInt(QuestActionInfo.sParam4, -1);
    if (nSMapX < 0) or (nSMapY < 0) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDRANDOMMAPGATE);
      Exit;
    end;
    sSMapNO := QuestActionInfo.sParam2;
    sDMapNO := QuestActionInfo.sParam6;
    g_MapManager.AddMapRoute(sName, sSMapNO, nSMapX, nSMapY, sDMapNO, -1, -1);
  end else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDRANDOMMAPGATE);
  end;
end;

procedure TNormNpc.ActionOfDelRandomMapGate(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  if (QuestActionInfo.sParam1 = '') or (QuestActionInfo.sParam2 = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DELRANDOMMAPGATE);
    Exit;
  end;
  g_MapManager.DelMapRoute(QuestActionInfo.sParam1, QuestActionInfo.sParam2);
end;

procedure TNormNpc.ActionOfGetRandomMapGate(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nSMapX, nSMapY, nDMapX, nDMapY: Integer;

  sVar, sValue: string;
  nValue: Integer;
  VarInfo: TVarInfo;
begin
  if (QuestActionInfo.sParam1 = '') or (QuestActionInfo.sParam2 = '') or (QuestActionInfo.sParam3 = '')
    or (QuestActionInfo.sParam4 = '') or (QuestActionInfo.sParam5 = '') or (QuestActionInfo.sParam6 = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GETRANDOMMAPGATE);
    Exit;
  end;
  g_MapManager.GetMapGateXY(QuestActionInfo.sParam1, QuestActionInfo.sParam2, nSMapX, nSMapY, nDMapX, nDMapY);

  VarInfo := GetVarValue(PlayObject, QuestActionInfo.sParam3, sVar, sValue, nValue);
  case VarInfo.VarAttr of
    aNone, aConst: begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GETRANDOMMAPGATE);
        Exit;
      end;
    aFixStr: SetValNameValue(PlayObject, sVar, sValue, nValue);
    aDynamic: SetDynamicValue(PlayObject, sVar, sValue, nValue);
  end;

  VarInfo := GetVarValue(PlayObject, QuestActionInfo.sParam4, sVar, sValue, nValue);
  case VarInfo.VarAttr of
    aNone, aConst: begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GETRANDOMMAPGATE);
        Exit;
      end;
    aFixStr: SetValNameValue(PlayObject, sVar, sValue, nValue);
    aDynamic: SetDynamicValue(PlayObject, sVar, sValue, nValue);
  end;

  VarInfo := GetVarValue(PlayObject, QuestActionInfo.sParam5, sVar, sValue, nValue);
  case VarInfo.VarAttr of
    aNone, aConst: begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GETRANDOMMAPGATE);
        Exit;
      end;
    aFixStr: SetValNameValue(PlayObject, sVar, sValue, nValue);
    aDynamic: SetDynamicValue(PlayObject, sVar, sValue, nValue);
  end;

  VarInfo := GetVarValue(PlayObject, QuestActionInfo.sParam6, sVar, sValue, nValue);
  case VarInfo.VarAttr of
    aNone, aConst: begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GETRANDOMMAPGATE);
        Exit;
      end;
    aFixStr: SetValNameValue(PlayObject, sVar, sValue, nValue);
    aDynamic: SetDynamicValue(PlayObject, sVar, sValue, nValue);
  end;
end;

procedure TNormNpc.ActionOfOpenBook(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nBookType: Integer;
begin
  nBookType := Str_ToInt(QuestActionInfo.sParam1, -1);
  if (nBookType < 0) or (nBookType > 5) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_OPENBOOK);
    Exit;
  end;
  PlayObject.SendMsg(Self, RM_OPENBOOK, 0, Integer(Self), nBookType, 0, '');
end;

procedure TNormNpc.ActionOfOpenBox(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sItemName: string;
begin
  sItemName := QuestActionInfo.sParam1;
  if (sItemName = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_OPENBOX);
    Exit;
  end;
  PlayObject.SendMsg(PlayObject, RM_OPENITEMBOX, 0, 0, 0, 0, sItemName);
end;

procedure TNormNpc.ActionOfChangeUseItemStarsLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  cMethod: Char;
  nWhere, nValue: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  sCheckItemName: string;
begin
  if (QuestActionInfo.sParam2 <> '') then
    cMethod := QuestActionInfo.sParam2[1];
  nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
  nValue := Str_ToInt(QuestActionInfo.sParam3, -1);


  if nWhere < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam1, nWhere); //增加变量支持
  if nValue < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam3, nValue); //增加变量支持

  if (not nValue in [0..12]) or (nWhere < 0) or (nWhere > High(THumanUseItems)) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEUSEITEMSTARSLEVEL);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (UserItem.wIndex <= 0) or (StdItem = nil) then begin
    PlayObject.SysMsg('You are not wearing an eligible Items.', c_Red, t_Hint);
    Exit;
  end;

  if Assigned(PlugInEngine.CheckCanUpgradeItem) then begin //禁止升级
    sCheckItemName := StdItem.Name;
    if PlugInEngine.CheckCanUpgradeItem(PlayObject, PChar(sCheckItemName), True) then begin
      Exit;
    end;
  end;
  case cMethod of
    '+': UserItem.AddValue[13] := _MIN(UserItem.AddValue[13] + nValue, High(Byte));
    '-': if UserItem.AddValue[13] - nValue < 0 then UserItem.AddValue[13] := 0
      else UserItem.AddValue[13] := UserItem.AddValue[13] - nValue;
    '=': UserItem.AddValue[13] := _MIN(nValue, High(Byte));
  end;
  PlayObject.SendUpdateItem(UserItem);
end;

procedure TNormNpc.ActionOfChangeBagItemStarsLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  cMethod: Char;
  UserItem: pTUserItem;
  nValue: Integer;
  sCheckItemName: string;
  StdItem: pTStdItem;
  //Anicount, Ac, Ac2, Mac, Mac2, Dc, Dc2, Mc, Mc2, Sc, SC2: Integer;
begin
  UserItem := nil;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;
  if UserItem <> nil then begin
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) then begin
      //if PlayObject.m_btPermission < 10 then begin
      if Assigned(PlugInEngine.CheckCanUpgradeItem) then begin //禁止升级
        sCheckItemName := StdItem.Name;
        if PlugInEngine.CheckCanUpgradeItem(PlayObject, PChar(sCheckItemName), True) then begin

          PlayObject.SendChangeItemFail;
          Exit;
        end;
      end;
      //end;

      if QuestActionInfo.sParam1 <> '' then begin
        cMethod := QuestActionInfo.sParam1[1];
      end;
      nValue := Str_ToInt(QuestActionInfo.sParam2, -1);

      if nValue < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam2, nValue); //增加变量支持
      if (not (nValue in [0..13])) then begin

        PlayObject.SendChangeItemFail;
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEBAGITEMSTARSLEVEL);
        Exit;
      end;

      case cMethod of
        '+': UserItem.AddValue[13] := _MIN(UserItem.AddValue[13] + nValue, High(Byte));
        '-': if UserItem.AddValue[13] - nValue < 0 then UserItem.AddValue[13] := 0
          else UserItem.AddValue[13] := UserItem.AddValue[13] - nValue;
        '=': UserItem.AddValue[13] := _MIN(nValue, High(Byte));
      end;

      PlayObject.SendUpdateChangeItem(UserItem);
    end else begin

      PlayObject.SendChangeItemFail;
    end;
  end else begin

    PlayObject.SendChangeItemFail;
  end;
end;

procedure TNormNpc.ActionOfBindBagItem(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  UserItem: pTUserItem;
  nValue: Integer;
  sCheckItemName: string;
  StdItem: pTStdItem;
  StdItem58: TStdItem;
  nItem, nBind: Integer;
  ItemBind: pTItemBind;
  nItemIdx, nMakeIdex: Integer;
  nWhere: Integer;
  boFind: Boolean;
  sBindName: string;
  sItem: string;
  sType: string;
  nCheckTakeOn: Integer;
begin
  UserItem := nil;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;
  if UserItem <> nil then begin
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem <> nil then begin
      nCheckTakeOn := Str_ToInt(QuestActionInfo.sParam2, 0);
      nItem := GetItemType(StdItem);
      if (nCheckTakeOn = 0) or CheckUserItems(nItem, StdItem) then begin
        StdItem58 := StdItem^;
        nBind := Str_ToInt(QuestActionInfo.sParam1, -1);
        ItemUnit.GetItemAddValue(UserItem, StdItem58);
        if (nCheckTakeOn = 0) or PlayObject.CheckTakeOnItems(nItem, StdItem58) then begin
          sItem := '';
          sItem := GetUseItemName(nItem);
          if sItem = '' then sItem := StdItem58.Name;
          nItemIdx := UserItem.wIndex;
          nMakeIdex := UserItem.MakeIndex;
          case nBind of
            0: begin
                sType := '账号';
                boFind := False;
                sBindName := PlayObject.m_sUserID;
                g_ItemBindAccount.Lock;
                try
                  for I := 0 to g_ItemBindAccount.Count - 1 do begin
                    ItemBind := g_ItemBindAccount.Items[I];
                    if (ItemBind.nItemIdx = nItemIdx) and (ItemBind.nMakeIdex = nMakeIdex) then begin
                      SysMsg(Format(g_sGameCommandBindUseItemAlreadBindMsg, [PlayObject.m_sCharName, sItem]), c_Red, t_Hint);
                      boFind := True;
                      Break;
                    end;
                  end;
                  if not boFind then begin
                    New(ItemBind);
                    ItemBind.nItemIdx := nItemIdx;
                    ItemBind.nMakeIdex := nMakeIdex;
                    ItemBind.sBindName := sBindName;
                    g_ItemBindAccount.Insert(0, ItemBind);
                  end;
                finally
                  g_ItemBindAccount.UnLock;
                end;
                if boFind then begin

                  PlayObject.SendChangeItemFail;
                  Exit;
                end;
                SaveItemBindAccount();
                SysMsg(Format('%s[%s]IDX:[%d] Serial Number:[%d] Dura:[%d-%d]，%s has been bound.',
                  [GetUseItemName(nItem),
                  UserEngine.GetStdItemName(UserItem.wIndex),
                    UserItem.wIndex,
                    UserItem.MakeIndex,
                    UserItem.Dura,
                    UserItem.DuraMax,
                    sBindName]),
                    c_Blue, t_Hint);
                PlayObject.SysMsg(Format('Item %s[%s]is already bound to %s[%s] you.',
                  [GetUseItemName(nItem),
                  UserEngine.GetStdItemName(UserItem.wIndex),
                    sType,
                    sBindName
                    ]), c_Blue, t_Hint);
                PlayObject.SendUpdateChangeItem(UserItem);
                Exit;
                //PlayObject.SendMsg(PlayObject, RM_SENDUSEITEMS, 0, 0, 0, 0, '');
              end;
            1: begin
                sType := '人物';
                sBindName := PlayObject.m_sCharName;
                boFind := False;
                g_ItemBindCharName.Lock;
                try
                  for I := 0 to g_ItemBindCharName.Count - 1 do begin
                    ItemBind := g_ItemBindCharName.Items[I];
                    if (ItemBind.nItemIdx = nItemIdx) and (ItemBind.nMakeIdex = nMakeIdex) then begin
                      SysMsg(Format(g_sGameCommandBindUseItemAlreadBindMsg, [PlayObject.m_sCharName, sItem]), c_Red, t_Hint);
                      boFind := True;
                      Break;
                    end;
                  end;
                  if not boFind then begin
                    New(ItemBind);
                    ItemBind.nItemIdx := nItemIdx;
                    ItemBind.nMakeIdex := nMakeIdex;
                    ItemBind.sBindName := sBindName;
                    g_ItemBindCharName.Insert(0, ItemBind);
                  end;
                finally
                  g_ItemBindCharName.UnLock;
                end;
                if boFind then begin

                  PlayObject.SendChangeItemFail;
                  Exit;
                end;
                SaveItemBindCharName();
                SysMsg(Format('%s[%s]IDX[%d]系列号[%d]持久[%d-%d]，绑定到%s成功。',
                  [GetUseItemName(nItem),
                  UserEngine.GetStdItemName(UserItem.wIndex),
                    UserItem.wIndex,
                    UserItem.MakeIndex,
                    UserItem.Dura,
                    UserItem.DuraMax,
                    sBindName]),
                    c_Blue, t_Hint);
                PlayObject.SysMsg(Format('Item %s[%s]is already bound to %s[%s] you.',
                  [GetUseItemName(nItem),
                  UserEngine.GetStdItemName(UserItem.wIndex),
                    sType,
                    sBindName
                    ]), c_Blue, t_Hint);
                PlayObject.SendUpdateChangeItem(UserItem);
                Exit;
                //PlayObject.SendMsg(PlayObject, RM_SENDUSEITEMS, 0, 0, 0, 0, '');
              end;
            2: begin
                sType := 'IP';
                boFind := False;
                sBindName := PlayObject.m_sIPaddr;
                g_ItemBindIPaddr.Lock;
                try
                  for I := 0 to g_ItemBindIPaddr.Count - 1 do begin
                    ItemBind := g_ItemBindIPaddr.Items[I];
                    if (ItemBind.nItemIdx = nItemIdx) and (ItemBind.nMakeIdex = nMakeIdex) then begin
                      SysMsg(Format(g_sGameCommandBindUseItemAlreadBindMsg, [PlayObject.m_sCharName, sItem]), c_Red, t_Hint);
                      boFind := True;
                      Break;
                    end;
                  end;
                  if not boFind then begin
                    New(ItemBind);
                    ItemBind.nItemIdx := nItemIdx;
                    ItemBind.nMakeIdex := nMakeIdex;
                    ItemBind.sBindName := sBindName;
                    g_ItemBindIPaddr.Insert(0, ItemBind);
                  end;
                finally
                  g_ItemBindIPaddr.UnLock;
                end;
                if boFind then begin

                  PlayObject.SendChangeItemFail;
                  Exit;
                end;
                SaveItemBindIPaddr();
                SysMsg(Format('%s[%s]IDX[%d]系列号[%d]持久[%d-%d]，绑定到%s成功。',
                  [GetUseItemName(nItem),
                  UserEngine.GetStdItemName(UserItem.wIndex),
                    UserItem.wIndex,
                    UserItem.MakeIndex,
                    UserItem.Dura,
                    UserItem.DuraMax,
                    sBindName]),
                    c_Blue, t_Hint);
                PlayObject.SysMsg(Format('Item %s[%s]is already bound to %s[%s] you.',
                  [GetUseItemName(nItem),
                  UserEngine.GetStdItemName(UserItem.wIndex),
                    sType,
                    sBindName
                    ]), c_Blue, t_Hint);
                PlayObject.SendUpdateChangeItem(UserItem);
                Exit;
                //PlayObject.SendMsg(PlayObject, RM_SENDUSEITEMS, 0, 0, 0, 0, '');
              end;
          end;
        end;
      end;
    end;
  end;

  PlayObject.SendChangeItemFail;
end;

procedure TNormNpc.ActionOfHeroGroup(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nLevel, nTime: Integer;
begin
  nLevel := Str_ToInt(QuestActionInfo.sParam1, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nLevel < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam1, nLevel);
  if nTime < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam2, nTime);
  if (nLevel < 0) or (nTime < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HEROGROUP);
    Exit;
  end;
  if PlayObject.m_MyHero <> nil then begin
    THeroObject(PlayObject.m_MyHero).HeroGroup(nLevel, nTime);
  end;
end;

procedure TNormNpc.ActionOfUnHeroGroup(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  if PlayObject.m_MyHero <> nil then begin
    THeroObject(PlayObject.m_MyHero).UnHeroGroup();
  end;
end;

procedure TNormNpc.ActionOfChangeItems(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nPoint: Integer;
  nOldPoint: Integer;
  cMethod: Char;
  nVarType: Integer;
  nVarType1: Integer;
  UserItem: pTUserItem;
begin
  UserItem := nil;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;

  nVarType := Str_ToInt(QuestActionInfo.sParam1, -1);
  nVarType1 := Str_ToInt(QuestActionInfo.sParam2, -1);
  nPoint := Str_ToInt(QuestActionInfo.sParam4, -1);

  if not nVarType in [0..3] then
    GetVarValue(PlayObject, QuestActionInfo.sParam1, nVarType);

  if not nVarType1 in [0..6] then
    GetVarValue(PlayObject, QuestActionInfo.sParam2, nVarType1);

  if (nPoint < 0) then
    GetVarValue(PlayObject, QuestActionInfo.sParam4, nPoint);

  if (nPoint < 0) or (not nVarType in [0..3]) or (not nVarType1 in [0..6]) then begin

    PlayObject.SendChangeItemFail;
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEITEMS);
    Exit;
  end;
  if UserItem <> nil then begin
    cMethod := QuestActionInfo.sParam3[1];
    case cMethod of
      '=': begin
          if nVarType = 0 then begin
            if (nVarType1 > 0) then begin
              UserItem.MaxDate := (Date + nPoint) + Time;
            end else begin
              UserItem.AddValue[0] := 0;
            end;
            if GetDayCount(UserItem.MaxDate, Now) <= 0 then UserItem.MaxDate := Now;
          end else begin
            if UserEngine._AllowUpgradeItem(UserItem) then begin
              if UserItem.AddValue[nVarType] <> nVarType1 then begin
                UserItem.AddValue[nVarType] := nVarType1;
                UserItem.AddValue[nVarType + 3] := 0;
              end;
              UserItem.AddValue[nVarType + 3] := _MIN(255, nPoint);
            end else begin

              PlayObject.SendChangeItemFail;
              Exit;
            end;
            //MainOutMessage('nVarType:'+IntToStr(nVarType)+' nVarType1:'+IntToStr(nVarType1)+' nPoint:'+IntToStr(nPoint));
            //MainOutMessage('UserItem.AddValue[nVarType]:'+IntToStr(UserItem.AddValue[nVarType])+' UserItem.AddValue[nVarType + 3]:'+IntToStr(UserItem.AddValue[nVarType + 3]));
          end;
        end;
      '-': begin
          if nVarType = 0 then begin
            if (nVarType1 > 0) then begin
              if (UserItem.AddValue[0] = 1) then begin
                nPoint := GetDayCount(UserItem.MaxDate, Now) - nPoint;
                UserItem.MaxDate := (Date + nPoint) + Time;
              end;
            end else UserItem.AddValue[0] := 0;
            if GetDayCount(UserItem.MaxDate, Now) <= 0 then UserItem.MaxDate := Now;
          end else begin
            if UserEngine._AllowUpgradeItem(UserItem) then begin
              if UserItem.AddValue[nVarType] <> nVarType1 then begin
                UserItem.AddValue[nVarType] := nVarType1;
                UserItem.AddValue[nVarType + 3] := 0;
              end;
              UserItem.AddValue[nVarType + 3] := _MIN(0, UserItem.AddValue[nVarType + 3] - nPoint);
            end else begin

              PlayObject.SendChangeItemFail;
              Exit;
            end;
          end;
        end;
      '+': begin
          if nVarType = 0 then begin
            if (nVarType1 > 0) then begin
              if (UserItem.AddValue[0] = 1) then begin
                nPoint := GetDayCount(UserItem.MaxDate, Now) + nPoint;
                UserItem.MaxDate := (Date + nPoint) + Time;
              end;
            end else UserItem.AddValue[0] := 0;
            if GetDayCount(UserItem.MaxDate, Now) <= 0 then UserItem.MaxDate := Now;
          end else begin
            if UserEngine._AllowUpgradeItem(UserItem) then begin
              if UserItem.AddValue[nVarType] <> nVarType1 then begin
                UserItem.AddValue[nVarType] := nVarType1;
                UserItem.AddValue[nVarType + 3] := 0;
              end;
              UserItem.AddValue[nVarType + 3] := _MIN(255, UserItem.AddValue[nVarType + 3] + nPoint);
            end else begin

              PlayObject.SendChangeItemFail;
              Exit;
            end;
          end;
        end;
    end;
    PlayObject.SendUpdateChangeItem(UserItem);
    {PlayObject.m_DefMsg := MakeDefaultMsg(SM_SENDCHANGEITEM, 0, 0, 0, 1);
    PlayObject.SendSocket(@m_DefMsg, EncodeBuffer(@ClientItem, SizeOf(TClientItem))); }
    //PlayObject.SendMsg(Self, RM_SENDCHANGEITEM_OK, 0, 0, 0, 0, '');
  end;
end;

procedure TNormNpc.ActionOfClearRemember(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
  function IsRememberItem(UserItem: pTUserItem): Boolean;
  var
    StdItem: pTStdItem;
  begin
    Result := False;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem = nil then Exit;
    Result := (StdItem.StdMode = 31) and (StdItem.AniCount <> 0) and (StdItem.Shape = 1);
  end;
var
  UserItem: pTUserItem;
  boUpdate: Boolean;
  nIndex: Integer;
  btValue: Byte;
  ItemEvent: pTItemEvent;
begin
  UserItem := nil;
  boUpdate := False;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) or (not IsRememberItem(UserItem)) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;

  if UserItem <> nil then begin
    {g_RememberItemList.Lock;
    try}
    nIndex := g_RememberItemList.GetIndex(IntToStr(UserItem.MakeIndex));
    if nIndex >= 0 then begin
      ItemEvent := pTItemEvent(g_RememberItemList.Objects[nIndex]);
      g_RememberItemList.Delete(nIndex);
      btValue := UserItem.AddValue[0];
      FillChar(UserItem.AddValue, SizeOf(TValue), #0);
      UserItem.AddValue[0] := btValue;
      SaveRememberItemList();
      boUpdate := True;
      Dispose(ItemEvent);
    end;
    {finally
      g_RememberItemList.UnLock;
    end;}
    if boUpdate then PlayObject.SendUpdateChangeItem(UserItem) else

      PlayObject.SendChangeItemFail;
  end;
end;

procedure TNormNpc.ActionOfSendMoveMsg(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMsg: string;
  sParam5: string;
  nFColor, nBColor, nCount: Integer;
begin
  nFColor := Str_ToInt(QuestActionInfo.sParam2, -1);
  nBColor := Str_ToInt(QuestActionInfo.sParam3, -1);
  nCount := Str_ToInt(QuestActionInfo.sParam4, -1);
  if (nFColor < 0) or (nFColor > 255) or (nBColor < 0) or (nBColor > 255) or (nCount < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SENDMOVEMSG);
    Exit;
  end;

  sParam5 := QuestActionInfo.sParam5;
  GetVarValue(PlayObject, QuestActionInfo.sParam5, sParam5);

  sMsg := GetLineVariableText(PlayObject, sParam5);
  sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.GetUnknowCharName);
  sMsg := AnsiReplaceText(sMsg, '%x', IntToStr(PlayObject.m_nCurrX));
  sMsg := AnsiReplaceText(sMsg, '%y', IntToStr(PlayObject.m_nCurrY));
  if PlayObject.m_PEnvir <> nil then
    sMsg := AnsiReplaceText(sMsg, '%m', PlayObject.m_PEnvir.sMapDesc)
  else sMsg := AnsiReplaceText(sMsg, '%m', '????');
  sMsg := AnsiReplaceText(sMsg, '%d', m_sCharName);
  case QuestActionInfo.nParam1 of
    0: UserEngine.SendMoveMsg(sMsg, nFColor, nBColor, nCount);
    1: PlayObject.MoveMsg(sMsg, nFColor, nBColor, 0, 330, nCount);
  end;
end;

procedure TNormNpc.ActionOfSendCenterMsg(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMsg: string;
  sParam5: string;
  nFColor, nBColor, nTime: Integer;

  sVar, sValue: string;
  nValue: Integer;
  VarInfo: TVarInfo;
begin
  nFColor := Str_ToInt(QuestActionInfo.sParam2, -1);
  nBColor := Str_ToInt(QuestActionInfo.sParam3, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam4, -1);
  if (nFColor < 0) or (nFColor > 255) or (nBColor < 0) or (nBColor > 255) or (nTime < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SENDCENTERMSG);
    Exit;
  end;

  sParam5 := QuestActionInfo.sParam5;
  VarInfo := GetVarValue(PlayObject, QuestActionInfo.sParam5, sVar, sParam5, nValue);

  sMsg := GetLineVariableText(PlayObject, sParam5);
  sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.GetUnknowCharName);
  sMsg := AnsiReplaceText(sMsg, '%x', IntToStr(PlayObject.m_nCurrX));
  sMsg := AnsiReplaceText(sMsg, '%y', IntToStr(PlayObject.m_nCurrY));
  if PlayObject.m_PEnvir <> nil then
    sMsg := AnsiReplaceText(sMsg, '%m', PlayObject.m_PEnvir.sMapDesc)
  else sMsg := AnsiReplaceText(sMsg, '%m', '????');
  sMsg := AnsiReplaceText(sMsg, '%d', m_sCharName);
  case QuestActionInfo.nParam1 of
    0: UserEngine.SendCenterMsg(sMsg, nFColor, nBColor, nTime);
    1: PlayObject.CenterMsg(sMsg, nFColor, nBColor, nTime);
  end;
end;

procedure TNormNpc.ActionOfVibration(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nCount: Integer;
begin
  nCount := Str_ToInt(QuestActionInfo.sParam1, -1);
  if (nCount < 0) and (QuestActionInfo.sParam1 <> '') then
    GetVarValue(PlayObject, QuestActionInfo.sParam1, nCount);
  if nCount <= 0 then nCount := 1;
  if not PlayObject.m_boDeath then
    PlayObject.SendMsg(PlayObject, RM_VIBRATION, nCount, 0, 0, 0, '');
end;

procedure TNormNpc.ActionOfOpenBigDialogBox(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nImageIndex: Integer;
begin
  nImageIndex := Str_ToInt(QuestActionInfo.sParam1, -1);
  if (nImageIndex < 0) and (QuestActionInfo.sParam1 <> '') then
    GetVarValue(PlayObject, QuestActionInfo.sParam1, nImageIndex);
  PlayObject.SendDefMessage(SM_OPENBIGDIALOGBOX, nImageIndex, 0, 0, 0, '');
  //PlayObject.SendMsg(PlayObject, RM_OPENBIGDIALOGBOX, nImageIndex, 0, 0, 0, '');
end;

procedure TNormNpc.ActionOfCloseBigDialogBox(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.SendDefMessage(SM_CLOSEBIGDIALOGBOX, 0, 0, 0, 0, '');
  //PlayObject.SendMsg(PlayObject, RM_CLOSEBIGDIALOGBOX, 0, 0, 0, 0, '');
end;

procedure TNormNpc.ActionOfTagMapMove(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);

var
  I, II, nIndex, nNumBer, nMakeIndex, nCurrX, nCurrY: Integer;
  ItemEvent: pTItemEvent;
  RememberItem: pTRememberItem;
  UserItem: pTUserItem;
  UserItem34: TUserItem;
  boDelete: Boolean;

  sMapName, sItemName: string;
  nError: Integer;
resourcestring
  sExceptionMsg = '[Exception] TNormNpc::ActionOfTagMapMove TAGMAPMOVE Code:%d';
begin
  try
    nError := 0;
    sMapName := '';
    nCurrX := -1;
    nCurrY := -1;

    if (PlayObject.m_nRememberItemIndex >= 0) and (PlayObject.m_sRememberItemName <> '') then begin
      nError := 1;
      sItemName := PlayObject.m_sRememberItemName;
      nMakeIndex := PlayObject.m_nRememberItemIndex;
      nNumBer := Str_ToInt(QuestActionInfo.sParam1, -1);
      UserItem34.wIndex := 0;
      nError := 2;
      if nNumBer in [1..6] then begin
        nError := 3;
        nIndex := g_RememberItemList.GetIndex(IntToStr(nMakeIndex));
        if nIndex >= 0 then begin
          nError := 4;
          ItemEvent := pTItemEvent(g_RememberItemList.Objects[nIndex]);
          nError := 5;
          RememberItem := @ItemEvent.RememberItem[nNumBer - 1];
          boDelete := False;
          nError := 6;
          for I := PlayObject.m_ItemList.Count - 1 downto 0 do begin
            UserItem := PlayObject.m_ItemList.Items[I];
            UserItem34 := UserItem^;
            nError := 7;
            if UserItem.MakeIndex = ItemEvent.nMakeIndex then begin
              nError := 8;
              PlayObject.m_nRememberItemIndex := -1;
              PlayObject.m_sRememberItemName := '';
              if UserItem.Dura > 0 then begin
                if UserItem.Dura >= 1000 then begin
                  Dec(UserItem.Dura, 1000);
                end else begin
                  UserItem.Dura := 0;
                end;
                nError := 9;
                if RememberItem.sMapName <> '' then begin
                  sMapName := RememberItem.sMapName;
                  nCurrX := RememberItem.nCurrX;
                  nCurrY := RememberItem.nCurrY;
                  //PlayObject.SpaceMove(RememberItem.sMapName, RememberItem.nCurrX, RememberItem.nCurrY, 0);
                end;
                nError := 10;
              end;
              UserItem34 := UserItem^;
              nError := 11;
              if UserItem.Dura <= 0 then begin
                boDelete := True;
                nError := 12;
                PlayObject.m_ItemList.Delete(I);
                nError := 13;
                Dispose(UserItem);
                nError := 14;
                g_RememberItemList.Delete(nIndex);
                nError := 15;
                g_RememberItemList.SortString(0, g_RememberItemList.Count - 1);
                nError := 16;
                Dispose(ItemEvent);
                nError := 17;
                SaveRememberItemList();
                nError := 18;
              end;
              break;
            end;
          end;

          nError := 19;
          if boDelete then PlayObject.SendDelItems(@UserItem34)
          else PlayObject.SendUpdateItem(@UserItem34);
          nError := 20;
          if (sMapName <> '') and (nCurrX >= 0) and (nCurrY >= 0) then begin
            PlayObject.SpaceMove(sMapName, nCurrX, nCurrY, 0);
          end;
          nError := 21;

        end;
      end;

    end; // else
  except
    MainOutMessage(Format(sExceptionMsg, [nError]));
  end;
    //ScriptActionError(PlayObject, '', QuestActionInfo, sSC_TAGMAPMOVE);
end;

procedure TNormNpc.ActionOfTagMapInfo(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I, II, nIndex, nNumBer, nMakeIndex: Integer;
  ItemEvent: pTItemEvent;
  RememberItem: pTRememberItem;
  sItemName: string;

  UserItem: pTUserItem;
  boDelete: Boolean;
begin
  if (PlayObject.m_nRememberItemIndex >= 0) and (PlayObject.m_sRememberItemName <> '') then begin
    nNumBer := Str_ToInt(QuestActionInfo.sParam1, -1);
    if nNumBer in [1..6] then begin
     { g_RememberItemList.Lock;
      try }
      boDelete := True;
      for I := 0 to PlayObject.m_ItemList.Count - 1 do begin
        UserItem := PlayObject.m_ItemList.Items[I];
        if UserItem.MakeIndex = PlayObject.m_nRememberItemIndex then begin
          boDelete := False;
          break;
        end;
      end;

      nIndex := g_RememberItemList.GetIndex(IntToStr(PlayObject.m_nRememberItemIndex));
      if not boDelete then begin
        if nIndex >= 0 then begin
          ItemEvent := pTItemEvent(g_RememberItemList.Objects[nIndex]);
          RememberItem := @ItemEvent.RememberItem[nNumBer - 1];
          RememberItem.sMapName := PlayObject.m_sMapName;
          RememberItem.nCurrX := PlayObject.m_nCurrX;
          RememberItem.nCurrY := PlayObject.m_nCurrY;
        end else begin
          New(ItemEvent);
          ItemEvent.sItemName := PlayObject.m_sRememberItemName;
          ItemEvent.nMakeIndex := PlayObject.m_nRememberItemIndex;
          FillChar(ItemEvent.RememberItem, SizeOf(TRememberItem) * 6, #0);
          RememberItem := @ItemEvent.RememberItem[nNumBer - 1];
          RememberItem.sMapName := PlayObject.m_sMapName;
          RememberItem.nCurrX := PlayObject.m_nCurrX;
          RememberItem.nCurrY := PlayObject.m_nCurrY;
          g_RememberItemList.AddRecord(IntToStr(ItemEvent.nMakeIndex), Integer(ItemEvent));
        end;
      end else begin
        PlayObject.m_nRememberItemIndex := -1;
        PlayObject.m_sRememberItemName := '';
        if nIndex >= 0 then begin
          ItemEvent := pTItemEvent(g_RememberItemList.Objects[nIndex]);
          g_RememberItemList.Delete(nIndex);
          g_RememberItemList.SortString(0, g_RememberItemList.Count - 1);
          Dispose(ItemEvent);
        end;
      end;
      SaveRememberItemList();
      {finally
        g_RememberItemList.UnLock;
      end; }
    end;
  end;
end;

procedure TNormNpc.ActionOfAIStart(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nT: Integer;
begin
  if PlayObject is TAIPlayObject then begin
    nT := Str_ToInt(QuestActionInfo.sParam1, 0);
    TAIPlayObject(PlayObject).Start(TPathType(nT));
  end;
end;

procedure TNormNpc.ActionOfAIStop(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  if PlayObject is TAIPlayObject then begin
    TAIPlayObject(PlayObject).Stop;
  end;
end;

procedure TNormNpc.ActionOfTakeItemList(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I, II: Integer;
  LoadList: TStringList;
  UserItem: pTUserItem;
  StdItem: pTStdItem;

  sItemName: string;
  sListFileName: string;
  nItemCount: Integer;
begin
  sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;

  nItemCount := Str_ToInt(QuestActionInfo.sParam2, -1);

  if (nItemCount < 0) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam2, nItemCount); //增加变量支持
  end;

  if (nItemCount < 0) then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_TAKEITEMLIST);
    Exit;
  end;

  LoadList := TStringList.Create;
  if FileExists(sListFileName) then begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
  end;

  //MainOutMessage('LoadList.Text:' + LoadList.Text);
  //MainOutMessage('nItemCount:' + IntToStr(nItemCount));

  for I := 0 to LoadList.Count - 1 do begin
    sItemName := Trim(LoadList.Strings[I]);
    if (sItemName = '') or (sItemName[1] = ';') then Continue;
    if nItemCount <= 0 then Break;

    for II := BaseObject.m_ItemList.Count - 1 downto 0 do begin
      if nItemCount <= 0 then Break;
      UserItem := BaseObject.m_ItemList.Items[II];
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if (StdItem <> nil) and (CompareText(StdItem.Name, sItemName) = 0) then begin

        if StdItem.NeedIdentify = 1 then
          AddGameDataLog('10' + #9 +
            BaseObject.m_sMapName + #9 +
            IntToStr(BaseObject.m_nCurrX) + #9 +
            IntToStr(BaseObject.m_nCurrY) + #9 +
            BaseObject.m_sCharName + #9 +
            sItemName + #9 +
            IntToStr(UserItem.MakeIndex) + #9 +
            '1' + #9 +
            m_sCharName);

        if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
          TPlayObject(BaseObject).SendDelItems(UserItem);
        end else begin
          if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
            THeroObject(BaseObject).SendDelItems(UserItem);
          end;
        end;

        BaseObject.m_ItemList.Delete(II);
        Dispose(UserItem);
        Dec(nItemCount);
        //MainOutMessage('SendDelItems:' + IntToStr(nItemCount));
      end;
    end;
  end;

  LoadList.Free;
end;

procedure TNormNpc.ActionOfAILogOn(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I, nC, nCount, nX, nY: Integer;
  sCharName, sMapName: string;
  sConfigFileName: string;
  sHeroConfigFileName: string;
  Envir: TEnvirnoment;
  AI: TAILogon;
begin
  sMapName := QuestActionInfo.sParam1;
  Envir := g_MapManager.FindMap(sMapName);
  if Envir = nil then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam1, sMapName);
    Envir := g_MapManager.FindMap(sMapName);
    if Envir = nil then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AILOGON);
      Exit;
    end;
  end;

  nX := Str_ToInt(QuestActionInfo.sParam2, -1);
  nY := Str_ToInt(QuestActionInfo.sParam3, -1);
  nCount := Str_ToInt(QuestActionInfo.sParam4, -1);

  if nX < 0 then
    GetVarValue(PlayObject, QuestActionInfo.sParam2, nX);

  if nY < 0 then
    GetVarValue(PlayObject, QuestActionInfo.sParam3, nY);

  if nCount < 0 then
    GetVarValue(PlayObject, QuestActionInfo.sParam4, nCount);

  if (nX < 0) or (nY < 0) or (nCount < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AILOGON);
    Exit;
  end;

  //MainOutMessage('QuestActionInfo.sParam5:'+QuestActionInfo.sParam5);
  //MainOutMessage('QuestActionInfo.sParam6:'+QuestActionInfo.sParam6);

  sConfigFileName := QuestActionInfo.sParam5;
  GetVarValue(PlayObject, QuestActionInfo.sParam5, sConfigFileName);
  //sConfigFileName := GetLineVariableText(PlayObject, sConfigFileName);

  sHeroConfigFileName := QuestActionInfo.sParam6;
  GetVarValue(PlayObject, QuestActionInfo.sParam6, sHeroConfigFileName);
  //sHeroConfigFileName := GetLineVariableText(PlayObject, sHeroConfigFileName);

  //MainOutMessage('sConfigFileName:'+sConfigFileName);
  //MainOutMessage('sHeroConfigFileName:'+sHeroConfigFileName);

  AI.sMapName := sMapName;
  AI.sConfigFileName := g_Config.sEnvirDir + m_sPath + sConfigFileName;
  AI.sHeroConfigFileName := g_Config.sEnvirDir + m_sPath + sHeroConfigFileName;
  AI.sConfigListFileName := '';
  AI.sFilePath := '';
  AI.nX := nX;
  AI.nY := nY;
  //MainOutMessage('AI.sConfigFileName:'+AI.sConfigFileName);
  //MainOutMessage('AI.sHeroConfigFileName:'+AI.sHeroConfigFileName);
  nC := 0;
  g_AICharNameList.Lock;
  try
    for I := 0 to g_AICharNameList.Count - 1 do begin
      sCharName := g_AICharNameList.Strings[I];
      if (UserEngine.GetPlayObject(sCharName) = nil) and (not UserEngine.FindAILogon(sCharName)) then begin
        AI.sCharName := sCharName;
        UserEngine.AddAILogon(@AI);
        nC := nC + 1;
      end;
      if nC >= nCount then break;
    end;
  finally
    g_AICharNameList.UnLock;
  end;
end;

procedure TNormNpc.ActionOfAILogOnEx(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I, nC, nCount, nX, nY: Integer;
  sCharName, sMapName: string;
  sConfigListFileName: string;
  //sHeroConfigFileName: string;
  Envir: TEnvirnoment;
  AI: TAILogon;
begin
  sMapName := QuestActionInfo.sParam1;
  Envir := g_MapManager.FindMap(sMapName);
  if Envir = nil then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam1, sMapName);
    Envir := g_MapManager.FindMap(sMapName);
    if Envir = nil then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AILOGON);
      Exit;
    end;
  end;

  nX := Str_ToInt(QuestActionInfo.sParam2, -1);
  nY := Str_ToInt(QuestActionInfo.sParam3, -1);
  nCount := Str_ToInt(QuestActionInfo.sParam4, -1);

  if nX < 0 then
    GetVarValue(PlayObject, QuestActionInfo.sParam2, nX);

  if nY < 0 then
    GetVarValue(PlayObject, QuestActionInfo.sParam3, nY);

  if nCount < 0 then
    GetVarValue(PlayObject, QuestActionInfo.sParam4, nCount);

  if (nX < 0) or (nY < 0) or (nCount < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AILOGON);
    Exit;
  end;

  sConfigListFileName := QuestActionInfo.sParam5;
  GetVarValue(PlayObject, QuestActionInfo.sParam5, sConfigListFileName);
  //sConfigFileName := GetLineVariableText(PlayObject, sConfigFileName);

  AI.sMapName := sMapName;
  AI.sConfigFileName := ''; //g_Config.sEnvirDir + m_sPath + sConfigFileName;
  AI.sHeroConfigFileName := ''; // g_Config.sEnvirDir + m_sPath + sHeroConfigFileName;
  AI.sFilePath := g_Config.sEnvirDir + m_sPath;
  AI.sConfigListFileName := g_Config.sEnvirDir + m_sPath + sConfigListFileName;
  AI.nX := nX;
  AI.nY := nY;
  //MainOutMessage('AI.sConfigFileName:'+AI.sConfigFileName);
  //MainOutMessage('AI.sHeroConfigFileName:'+AI.sHeroConfigFileName);
  nC := 0;
  g_AICharNameList.Lock;
  try
    for I := 0 to g_AICharNameList.Count - 1 do begin
      sCharName := g_AICharNameList.Strings[I];
      if (UserEngine.GetPlayObject(sCharName) = nil) and (not UserEngine.FindAILogon(sCharName)) then begin
        AI.sCharName := sCharName;
        UserEngine.AddAILogon(@AI);
        nC := nC + 1;
      end;
      if nC >= nCount then break;
    end;
  finally
    g_AICharNameList.UnLock;
  end;
end;

procedure TNormNpc.ActionOfShowRankLevelName(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  boShowRankLevelName: Boolean;
begin
  boShowRankLevelName := PlayObject.m_boShowRankLevelName;
  PlayObject.m_boShowRankLevelName := QuestActionInfo.sParam1 = '1';
  if PlayObject.m_boShowRankLevelName <> boShowRankLevelName then
    PlayObject.RefShowName;
end;

procedure TNormNpc.ActionOfLoadRobotConfig(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
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

  PlayObject: TAIPlayObject;
  HeroObject: THeroObject;
  UseItemNames: pTUseItemNames;
begin
  if BaseObject.m_boAI then begin
    PlayObject := nil;
    HeroObject := nil;
    UseItemNames := nil;
    sFileName := QuestActionInfo.sParam1;

    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      PlayObject := TAIPlayObject(BaseObject);
      UseItemNames := @PlayObject.m_UseItemNames;
      GetVarValue(PlayObject, QuestActionInfo.sParam1, sFileName);
      sFileName := GetLineVariableText(PlayObject, sFileName);
    end else begin
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
        HeroObject := THeroObject(BaseObject);
        UseItemNames := @HeroObject.m_UseItemNames;
        GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam1, sFileName);
        sFileName := GetLineVariableText(TPlayObject(BaseObject.m_Master), sFileName);
      end;
    end;

    //sFileName := GetLineVariableText(PlayObject, sFileName);
    //GetVarValue(PlayObject, QuestActionInfo.sParam1, sFileName);
    sFileName := g_Config.sEnvirDir + m_sPath + sFileName;
    if FileExists(sFileName) then begin

      ItemIni := TIniFile.Create(sFileName);
      if ItemIni <> nil then begin
        BaseObject.m_btJob := ItemIni.ReadInteger('BaseInfo', 'Job', 0);
        BaseObject.m_btGender := ItemIni.ReadInteger('BaseInfo', 'Gender', 0);
        BaseObject.m_btHair := ItemIni.ReadInteger('BaseInfo', 'Hair', 0);
        BaseObject.m_WAbil.Level := ItemIni.ReadInteger('BaseInfo', 'Level', 1);
        sLineText := ItemIni.ReadString('BaseInfo', 'Magic', '');
        if sLineText <> '' then begin
          TempList := TStringList.Create;
          ExtractStrings(['|', '\', '/', ','], [], PChar(sLineText), TempList);
          for I := 0 to TempList.Count - 1 do begin
            sMagicName := Trim(TempList.Strings[I]);
            if TAIObject(BaseObject).FindMagic(sMagicName) = nil then begin
              Magic := UserEngine.FindMagic(sMagicName);
              if Magic <> nil then begin
                if (Magic.btJob = 99) or (Magic.btJob = BaseObject.m_btJob) then begin
                  New(UserMagic);
                  UserMagic.MagicInfo := Magic;
                  UserMagic.wMagIdx := Magic.wMagicId;
                  UserMagic.btLevel := 3;
                  UserMagic.btKey := VK_F1;
                  UserMagic.nTranPoint := Magic.MaxTrain[3];
                  BaseObject.m_MagicList.Add(UserMagic);
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

                if not BaseObject.AddItemToBag(UserItem) then begin
                  Dispose(UserItem);
                  break;
                end;
              end else Dispose(UserItem);
            end;

          end;
          TempList.Free;
        end;
        if UseItemNames <> nil then begin

          UseItemNames[U_DRESS] := ItemIni.ReadString('UseItems', 'DRESSNAME', ''); // '衣服';
          UseItemNames[U_WEAPON] := ItemIni.ReadString('UseItems', 'WEAPONNAME', ''); // '武器';
          UseItemNames[U_RIGHTHAND] := ItemIni.ReadString('UseItems', 'RIGHTHANDNAME', ''); // '照明物';
          UseItemNames[U_NECKLACE] := ItemIni.ReadString('UseItems', 'NECKLACENAME', ''); // '项链';
          UseItemNames[U_HELMET] := ItemIni.ReadString('UseItems', 'HELMETNAME', ''); // '头盔';
          UseItemNames[U_ARMRINGL] := ItemIni.ReadString('UseItems', 'ARMRINGLNAME', ''); // '左手镯';
          UseItemNames[U_ARMRINGR] := ItemIni.ReadString('UseItems', 'ARMRINGRNAME', ''); // '右手镯';
          UseItemNames[U_RINGL] := ItemIni.ReadString('UseItems', 'RINGLNAME', ''); // '左戒指';
          UseItemNames[U_RINGR] := ItemIni.ReadString('UseItems', 'RINGRNAME', ''); // '右戒指';
          UseItemNames[U_BUJUK] := ItemIni.ReadString('UseItems', 'BUJUKNAME', ''); // '物品';
          UseItemNames[U_BELT] := ItemIni.ReadString('UseItems', 'BELTNAME', ''); // '腰带';
          UseItemNames[U_BOOTS] := ItemIni.ReadString('UseItems', 'BOOTSNAME', ''); // '鞋子';
          UseItemNames[U_CHARM] := ItemIni.ReadString('UseItems', 'CHARMNAME', ''); // '宝石';

          TAIObject(BaseObject).m_nDieDropUseItemRate := ItemIni.ReadInteger('UseItems', 'DieDropUseItemRate', 100);
          BaseObject.m_boButchItemEx := ItemIni.ReadBool('UseItems', 'ButchItem', False);
          BaseObject.m_boButchItem := m_boButchItemEx;
          BaseObject.m_boNoDropItem := ItemIni.ReadBool('UseItems', 'NoDropItem', False);
          BaseObject.m_boNoDropUseItem := ItemIni.ReadBool('UseItems', 'NoDropUseItem', False);

          for I := U_DRESS to U_CHARM do begin
            if UseItemNames[I] <> '' then begin
              StdItem := UserEngine.GetStdItem(UseItemNames[I]);
              if StdItem <> nil then begin
                New(UserItem);
                if UserEngine.CopyToUserItemFromName(UseItemNames[I], UserItem) then begin

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
                BaseObject.m_UseItems[I] := UserItem^;
                Dispose(UserItem);
              //end;
              end;
            end;
          end;
        end;
        ItemIni.Free;

        BaseObject.m_WAbil.HP := BaseObject.m_WAbil.MaxHP;
        BaseObject.m_WAbil.MP := BaseObject.m_WAbil.MaxMP;

        BaseObject.HasLevelUp(0);
      end;
    end else begin
      ScriptActionError(BaseObject, '', QuestActionInfo, sSC_LOADROBOTCONFIG);
    end;
  end;
end;

procedure TNormNpc.ActionOfClearDuelMap(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  Envir: TEnvirnoment;
  sMapName: string;
  AObject: TPlayObject;

  SpaceLockEvent: TSpaceLockEvent;
  ActorObject: TActorObject;
  BaseObjectList: TList;
begin
  sMapName := QuestActionInfo.sParam1;
  Envir := g_MapManager.FindMap(sMapName);
  if Envir = nil then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam1, sMapName);
    Envir := g_MapManager.FindMap(sMapName);
    if Envir = nil then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CLEARDUELMAP);
      Exit;
    end;
  end;

  if (Envir <> nil) and Envir.m_boDuel {and Envir.m_boDueling } then begin
    Envir.m_boClearDuel := True;
    Envir.m_dwDuelTick := GetTickCount - 1000 * 60 * 6;
    AObject := TPlayObject(Envir.m_PlayObject);
    if AObject.m_boSpaceLock then begin //解除锁定   删除挑战地图的锁定魔法
      BaseObjectList := TList.Create;
      if g_EventManager.GetLockEvent(Envir, BaseObjectList) > 0 then begin
        for I := 0 to BaseObjectList.Count - 1 do begin
          SpaceLockEvent := TSpaceLockEvent(BaseObjectList.Items[I]);
          SpaceLockEvent.m_boClosed := True;
          SpaceLockEvent.Close;
        end;
      end;
      BaseObjectList.Free;
    end;

    BaseObjectList := TList.Create; //清除挑战地图的人物
    Envir.GetRangeActorObject(Envir.m_nWidth div 2, Envir.m_nHeight div 2, _MAX(Envir.m_nWidth div 2, Envir.m_nHeight div 2), True, BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do begin
      ActorObject := TActorObject(BaseObjectList.Items[I]);
      if (ActorObject.m_btRaceServer = RC_PLAYOBJECT) {and (not PlayObject.m_boStartDuel)} then begin
        AObject := TPlayObject(ActorObject);
        AObject.m_boStartDuel := False;
        AObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
        if AObject.PKLevel < 2 then begin
          AObject.MoveToHome;
              //PlayObject.BaseObjectMove(PlayObject.m_sHomeMap, IntToStr(PlayObject.m_nHomeX), IntToStr(PlayObject.m_nHomeY));
        end else begin
          AObject.BaseObjectMove(g_Config.sRedHomeMap, IntToStr(g_Config.nRedHomeX), IntToStr(g_Config.nRedHomeY));
        end;
      end;
    end;
    BaseObjectList.Free;
  end;
end;

procedure TNormNpc.ActionOfMapTing(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
begin

end;

procedure TNormNpc.ActionOfMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  sSayMsg: string;
begin
  if PlayObject.m_sDearName <> '' then Exit;
  PoseHuman := TPlayObject(PlayObject.GetPoseCreate());
  if PoseHuman = nil then begin
    GotoLable(PlayObject, '@MarryCheckDir', False);
    Exit;
  end;
  if QuestActionInfo.sParam1 = '' then begin
    if PoseHuman.m_btRaceServer <> RC_PLAYOBJECT then begin
      GotoLable(PlayObject, '@HumanTypeErr', False);
      Exit;
    end;
    if PoseHuman.GetPoseCreate = PlayObject then begin
      if PlayObject.m_btGender <> PoseHuman.m_btGender then begin
        GotoLable(PlayObject, '@StartMarry', False);
        GotoLable(PoseHuman, '@StartMarry', False);
        if (PlayObject.m_btGender = 0) and (PoseHuman.m_btGender = 1) then begin
          sSayMsg := AnsiReplaceText(g_sStartMarryManMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          sSayMsg := AnsiReplaceText(g_sStartMarryManAskQuestionMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
        end else if (PlayObject.m_btGender = 1) and (PoseHuman.m_btGender = 0) then begin
          sSayMsg := AnsiReplaceText(g_sStartMarryWoManMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          sSayMsg := AnsiReplaceText(g_sStartMarryWoManAskQuestionMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
        end;
        PlayObject.m_boStartMarry := True;
        PoseHuman.m_boStartMarry := True;
      end else begin
        GotoLable(PoseHuman, '@MarrySexErr', False);
        GotoLable(PlayObject, '@MarrySexErr', False);
      end;
    end else begin
      GotoLable(PlayObject, '@MarryDirErr', False);
      GotoLable(PoseHuman, '@MarryCheckDir', False);
    end;
    Exit;
  end;
  if CompareText(QuestActionInfo.sParam1, 'REQUESTMARRY' {sREQUESTMARRY}) = 0 then begin
    if PlayObject.m_boStartMarry and PoseHuman.m_boStartMarry then begin
      if (PlayObject.m_btGender = 0) and (PoseHuman.m_btGender = 1) then begin
        sSayMsg := AnsiReplaceText(g_sMarryManAnswerQuestionMsg, '%n', m_sCharName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
        UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
        sSayMsg := AnsiReplaceText(g_sMarryManAskQuestionMsg, '%n', m_sCharName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
        UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
        GotoLable(PlayObject, '@WateMarry', False);
        GotoLable(PoseHuman, '@RevMarry', False);
      end;
    end;
    Exit;
  end;
  if CompareText(QuestActionInfo.sParam1, 'RESPONSEMARRY' {sRESPONSEMARRY}) = 0 then begin
    if (PlayObject.m_btGender = 1) and (PoseHuman.m_btGender = 0) then begin
      if CompareText(QuestActionInfo.sParam2, 'OK') = 0 then begin
        if PlayObject.m_boStartMarry and PoseHuman.m_boStartMarry then begin
          sSayMsg := AnsiReplaceText(g_sMarryWoManAnswerQuestionMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          sSayMsg := AnsiReplaceText(g_sMarryWoManGetMarryMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          GotoLable(PlayObject, '@EndMarry', False);
          GotoLable(PoseHuman, '@EndMarry', False);
          PlayObject.m_boStartMarry := False;
          PoseHuman.m_boStartMarry := False;
          PlayObject.m_sDearName := PoseHuman.m_sCharName;
          PlayObject.m_DearHuman := PoseHuman;
          PoseHuman.m_sDearName := PlayObject.m_sCharName;
          PoseHuman.m_DearHuman := PlayObject;
          PlayObject.RefShowName;
          PoseHuman.RefShowName;
        end;
      end else begin
        if PlayObject.m_boStartMarry and PoseHuman.m_boStartMarry then begin
          GotoLable(PlayObject, '@EndMarryFail', False);
          GotoLable(PoseHuman, '@EndMarryFail', False);
          PlayObject.m_boStartMarry := False;
          PoseHuman.m_boStartMarry := False;
          sSayMsg := AnsiReplaceText(g_sMarryWoManDenyMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          sSayMsg := AnsiReplaceText(g_sMarryWoManCancelMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
        end;
      end;
    end;
    Exit;
  end;
end;

procedure TNormNpc.ActionOfMaster(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  sSayMsg: string;
begin
  if PlayObject.m_sMasterName <> '' then Exit;
  PoseHuman := TPlayObject(PlayObject.GetPoseCreate());
  if PoseHuman = nil then begin
    GotoLable(PlayObject, '@MasterCheckDir', False);
    Exit;
  end;
  if QuestActionInfo.sParam1 = '' then begin
    if PoseHuman.m_btRaceServer <> RC_PLAYOBJECT then begin
      GotoLable(PlayObject, '@HumanTypeErr', False);
      Exit;
    end;
    if PoseHuman.GetPoseCreate = PlayObject then begin
      GotoLable(PlayObject, '@StartGetMaster', False);
      GotoLable(PoseHuman, '@StartMaster', False);
      PlayObject.m_boStartMaster := True;
      PoseHuman.m_boStartMaster := True;
    end else begin
      GotoLable(PlayObject, '@MasterDirErr', False);
      GotoLable(PoseHuman, '@MasterCheckDir', False);
    end;
    Exit;
  end;
  if CompareText(QuestActionInfo.sParam1, 'REQUESTMASTER') = 0 then begin
    if PlayObject.m_boStartMaster and PoseHuman.m_boStartMaster then begin
      PlayObject.m_PoseBaseObject := PoseHuman;
      PoseHuman.m_PoseBaseObject := PlayObject;
      GotoLable(PlayObject, '@WateMaster', False);
      GotoLable(PoseHuman, '@RevMaster', False);
    end;
    Exit;
  end;
  if CompareText(QuestActionInfo.sParam1, 'RESPONSEMASTER') = 0 then begin
    if CompareText(QuestActionInfo.sParam2, 'OK') = 0 then begin
      if (PlayObject.m_PoseBaseObject = PoseHuman) and (PoseHuman.m_PoseBaseObject = PlayObject) then begin
        if PlayObject.m_boStartMaster and PoseHuman.m_boStartMaster then begin
          GotoLable(PlayObject, '@EndMaster', False);
          GotoLable(PoseHuman, '@EndMaster', False);
          PlayObject.m_boStartMaster := False;
          PoseHuman.m_boStartMaster := False;
          if PlayObject.m_sMasterName = '' then begin
            PlayObject.m_sMasterName := PoseHuman.m_sCharName;
            PlayObject.m_boMaster := True;
          end;
          PlayObject.m_MasterList.Add(PoseHuman);
          PoseHuman.m_sMasterName := PlayObject.m_sCharName;
          PoseHuman.m_boMaster := False;
          PlayObject.RefShowName;
          PoseHuman.RefShowName;
        end;
      end;
    end else begin
      if PlayObject.m_boStartMaster and PoseHuman.m_boStartMaster then begin
        GotoLable(PlayObject, '@EndMasterFail', False);
        GotoLable(PoseHuman, '@EndMasterFail', False);
        PlayObject.m_boStartMaster := False;
        PoseHuman.m_boStartMaster := False;
      end;
    end;
    Exit;
  end;
end;

procedure TNormNpc.ActionOfMessageBox(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sParam1: string;
begin
  sParam1 := GetLineVariableText(PlayObject, QuestActionInfo.sParam1);
  GetVarValue(PlayObject, sParam1, sParam1);
  PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, sParam1);
end;

procedure TNormNpc.ActionOfMission(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.nParam2 > 0) and (QuestActionInfo.nParam3 > 0) then begin
    g_sMissionMap := QuestActionInfo.sParam1;
    g_nMissionX := QuestActionInfo.nParam2;
    g_nMissionY := QuestActionInfo.nParam3;
  end else begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_MISSION);
  end;
end;

//MOBFIREBURN MAP X Y TYPE TIME POINT

procedure TNormNpc.ActionOfMobFireBurn(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMAP: string;
  nX, nY, nType, nTime, nPoint: Integer;
  FireBurnEvent: TFireBurnEvent;
  Envir: TEnvirnoment;
  OldEnvir: TEnvirnoment;
begin
  sMAP := QuestActionInfo.sParam1;
  nX := Str_ToInt(QuestActionInfo.sParam2, -1);
  nY := Str_ToInt(QuestActionInfo.sParam3, -1);
  nType := Str_ToInt(QuestActionInfo.sParam4, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam5, -1);
  nPoint := Str_ToInt(QuestActionInfo.sParam6, -1);
  if (sMAP = '') or (nX < 0) or (nY < 0) or (nType < 0) or (nTime < 0) or (nPoint < 0) then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_MOBFIREBURN);
    Exit;
  end;
  Envir := g_MapManager.FindMap(sMAP);
  if Envir <> nil then begin
    OldEnvir := BaseObject.m_PEnvir;
    BaseObject.m_PEnvir := Envir;
    FireBurnEvent := TFireBurnEvent.Create(BaseObject, nX, nY, nType, nTime * 1000, nPoint);
    g_EventManager.AddEvent(FireBurnEvent);
    BaseObject.m_PEnvir := OldEnvir;
    Exit;
  end;
  ScriptActionError(BaseObject, '', QuestActionInfo, sSC_MOBFIREBURN);
end;

procedure TNormNpc.ActionOfMobPlace(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo; nX, nY, nCount, nRange: Integer);
var
  I: Integer;
  nRandX, nRandY: Integer;
  mon: TActorObject;
begin
  for I := 0 to nCount - 1 do begin
    nRandX := Random(nRange * 2 + 1) + (nX - nRange);
    nRandY := Random(nRange * 2 + 1) + (nY - nRange);
    mon := UserEngine.RegenMonsterByName(nil, g_sMissionMap, nRandX, nRandY, QuestActionInfo.sParam1);
    if mon <> nil then begin
      mon.m_boMission := True;
      mon.m_nMissionX := g_nMissionX;
      mon.m_nMissionY := g_nMissionY;
    end else begin
      ScriptActionError(BaseObject, '', QuestActionInfo, sSC_MOBPLACE);
      Break;
    end;
  end;
end;

procedure TNormNpc.ActionOfRecallGroupMembers(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin

end;

procedure TNormNpc.ActionOfSetRankLevelName(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sRankLevelName: string;
begin
  sRankLevelName := QuestActionInfo.sParam1;
  if sRankLevelName = '' then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETRANKLEVELNAME);
    Exit;
  end;
  sRankLevelName := GetLineVariableText(PlayObject, sRankLevelName);

  GetVarValue(PlayObject, sRankLevelName, sRankLevelName);

  if sRankLevelName = '' then begin
    sRankLevelName := g_sRankLevelName;
  end else
    if Pos('%s', sRankLevelName) <= 0 then begin
    sRankLevelName := '%s\' + sRankLevelName;
  end;
  PlayObject.m_sRankLevelName := sRankLevelName;
  PlayObject.RefShowName;
end;

procedure TNormNpc.ActionOfSetScriptFlag(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  boFlag: Boolean;
  nWhere: Integer;
begin
  nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
  boFlag := Str_ToInt(QuestActionInfo.sParam2, -1) = 1;
  case nWhere of
    0: begin
        PlayObject.m_boSendMsgFlag := boFlag;
      end;
    1: begin
        PlayObject.m_boChangeItemNameFlag := boFlag;
      end;
  else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETSCRIPTFLAG);
    end;
  end;
end;

procedure TNormNpc.ActionOfSkillLevel(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
  nLevel, nMaxLevel: Integer;
  cMethod: Char;
begin
  nMaxLevel := 3;
  nLevel := Str_ToInt(QuestActionInfo.sParam3, 0);
  if nLevel < 0 then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_SKILLLEVEL);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam2[1];

  if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    Magic := UserEngine.FindMagic(QuestActionInfo.sParam1);
  end else
    if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
    Magic := UserEngine.FindHeroMagic(QuestActionInfo.sParam1);
  end else begin
    Magic := UserEngine.FindMagic(QuestActionInfo.sParam1);
  end;

  if Magic <> nil then begin
    for I := 0 to BaseObject.m_MagicList.Count - 1 do begin
      UserMagic := BaseObject.m_MagicList.Items[I];
      if (BaseObject.m_btRaceServer = RC_HEROOBJECT) and (UserMagic.wMagIdx in [13, 26, 45]) then
        nMaxLevel := 4 else nMaxLevel := 3;
      if UserMagic.MagicInfo = Magic then begin
        case cMethod of
          '=': begin
              if nLevel >= 0 then begin
                nLevel := _MAX(nMaxLevel, nLevel);
                UserMagic.btLevel := nLevel;
              end;
            end;
          '-': begin
              if UserMagic.btLevel >= nLevel then begin
                Dec(UserMagic.btLevel, nLevel);
              end else begin
                UserMagic.btLevel := 0;
              end;
            end;
          '+': begin
              if UserMagic.btLevel + nLevel <= nMaxLevel then begin
                Inc(UserMagic.btLevel, nLevel);
              end else begin
                UserMagic.btLevel := nMaxLevel;
              end;
            end;
        end;
        if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
          BaseObject.SendDelayMsg(BaseObject, RM_MAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 100);
        end;
        Break;
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfTakeCastleGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGold: Integer;

  sVar, sValue: string;
  nValue: Integer;
  VarInfo: TVarInfo;
begin
  nGold := Str_ToInt(QuestActionInfo.sParam1, -1);
  if nGold < 0 then
    VarInfo := GetVarValue(PlayObject, QuestActionInfo.sParam1, sVar, sValue, nGold);
  if (nGold < 0) or (m_Castle = nil) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_TAKECASTLEGOLD);
    Exit;
  end;
  if nGold <= TUserCastle(m_Castle).m_nTotalGold then begin
    Dec(TUserCastle(m_Castle).m_nTotalGold, nGold);
  end else begin
    TUserCastle(m_Castle).m_nTotalGold := 0;
  end;
end;

procedure TNormNpc.ActionOfNotLineAddPiont(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo); //离线挂机
var
  dwAutoGetExpTime: LongWord;
  nAutoGetExpPoint: Integer;
begin
  if (not PlayObject.m_boNotOnlineAddExp) and (not PlayObject.m_boAI) then begin
    dwAutoGetExpTime := Str_ToInt(QuestActionInfo.sParam1, 0);
    nAutoGetExpPoint := Str_ToInt(QuestActionInfo.sParam2, 0);
    PlayObject.m_dwNotOnlineAddExpTime := dwAutoGetExpTime * 60 * 1000;
    PlayObject.m_nNotOnlineAddExpPoint := LongWord(nAutoGetExpPoint);
    PlayObject.m_boNotOnlineAddExp := True;
    PlayObject.m_boStartAutoAddExpPoint := True;
    PlayObject.m_dwAutoAddExpPointTimeTick := GetTickCount;
    PlayObject.m_dwAutoAddExpPointTick := GetTickCount; //GetTickCount;
    PlayObject.m_boKickAutoAddExpUser := False;

    if PlayObject.m_GroupOwner = PlayObject then PlayObject.CancelGroup; //解散小组

    PlayObject.m_boAllowDeal := False; //禁止交易
    PlayObject.m_boAllowGuild := False; //禁止加入行会
    PlayObject.m_boAllowGroup := False; //禁止组队
    PlayObject.m_boCanMasterRecall := False; //禁止师徒传送
    PlayObject.m_boCanDearRecall := False; //禁止夫妻传送
    PlayObject.m_boAllowGuildReCall := False; //禁止行会合一
    PlayObject.m_boAllowGroupReCall := False; //禁止天地合一
    if PlayObject.m_boDealing then begin //交易中退出挂机
      PlayObject.DealCancel;
    end;

    if PlayObject.m_boDueling then begin
      PlayObject.DuelCancelA();
    end;

    PlayObject.ClearViewRange;
  end;
end;

procedure TNormNpc.ActionOfKickNotLineAddPiont(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  if PlayObject.m_boNotOnlineAddExp then begin
    PlayObject.m_boPlayOffLine := False;
    PlayObject.m_boReconnection := False;
    PlayObject.m_boSoftClose := True;
  end;
end;

procedure TNormNpc.ActionOfUnMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  LoadList: TStringList;
  sUnMarryFileName: string;
begin
  if PlayObject.m_sDearName = '' then begin
    GotoLable(PlayObject, '@ExeMarryFail', False);
    Exit;
  end;
  PoseHuman := TPlayObject(PlayObject.GetPoseCreate);
  if PoseHuman = nil then begin
    GotoLable(PlayObject, '@UnMarryCheckDir', False);
  end;
  if PoseHuman <> nil then begin
    if QuestActionInfo.sParam1 = '' then begin
      if PoseHuman.m_btRaceServer <> RC_PLAYOBJECT then begin
        GotoLable(PlayObject, '@UnMarryTypeErr', False);
        Exit;
      end;
      if PoseHuman.GetPoseCreate = PlayObject then begin
        if (PlayObject.m_sDearName = PoseHuman.m_sCharName) {and (PosHum.AddInfo.sDearName = Hum.sName)} then begin
          GotoLable(PlayObject, '@StartUnMarry', False);
          GotoLable(PoseHuman, '@StartUnMarry', False);
          Exit;
        end;
      end;
    end;
  end;
  if (CompareText(QuestActionInfo.sParam1, 'REQUESTUNMARRY' {sREQUESTUNMARRY}) = 0) then begin
    if (QuestActionInfo.sParam2 = '') then begin
      if PoseHuman <> nil then begin
        PlayObject.m_boStartUnMarry := True;
        if PlayObject.m_boStartUnMarry and PoseHuman.m_boStartUnMarry then begin
          UserEngine.SendBroadCastMsg('[' + m_sCharName + ']: ' + '我宣布' {sUnMarryMsg8} + PoseHuman.m_sCharName + ' ' + '与' {sMarryMsg0} + PlayObject.m_sCharName + ' ' + ' ' + '正式脱离夫妻关系。' {sUnMarryMsg9}, t_Say);
          PlayObject.m_sDearName := '';
          PoseHuman.m_sDearName := '';
          Inc(PlayObject.m_btMarryCount);
          Inc(PoseHuman.m_btMarryCount);
          PlayObject.m_boStartUnMarry := False;
          PoseHuman.m_boStartUnMarry := False;
          PlayObject.RefShowName;
          PoseHuman.RefShowName;
          GotoLable(PlayObject, '@UnMarryEnd', False);
          GotoLable(PoseHuman, '@UnMarryEnd', False);
        end else begin
          GotoLable(PlayObject, '@WateUnMarry', False);
          //          GotoLable(PoseHuman,'@RevUnMarry',False);
        end;
      end;
      Exit;
    end else begin
      //强行离婚
      if (CompareText(QuestActionInfo.sParam2, 'FORCE') = 0) then begin
        UserEngine.SendBroadCastMsg('[' + m_sCharName + ']: ' + '我宣布' {sUnMarryMsg8} + PlayObject.m_sCharName + ' ' + '与' {sMarryMsg0} + PlayObject.m_sDearName + ' ' + ' ' + '已经正式脱离夫妻关系！！！' {sUnMarryMsg9}, t_Say);
        PoseHuman := UserEngine.GetPlayObject(PlayObject.m_sDearName);
        if PoseHuman <> nil then begin
          PoseHuman.m_sDearName := '';
          Inc(PoseHuman.m_btMarryCount);
          PoseHuman.RefShowName;
        end else begin
          sUnMarryFileName := g_Config.sEnvirDir + 'UnMarry.txt';
          LoadList := TStringList.Create;
          if FileExists(sUnMarryFileName) then begin
            LoadList.LoadFromFile(sUnMarryFileName);
          end;
          LoadList.Add(PlayObject.m_sDearName);
          LoadList.SaveToFile(sUnMarryFileName);
          LoadList.Free;
        end;
        PlayObject.m_sDearName := '';
        Inc(PlayObject.m_btMarryCount);
        GotoLable(PlayObject, '@UnMarryEnd', False);
        PlayObject.RefShowName;
      end;
      Exit;
    end;
  end;
end;

procedure TNormNpc.ActionOfCommendGameGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin

end;

procedure TNormNpc.ActionOfStartTakeGold(PlayObject: TPlayObject);
var
  PoseHuman: TPlayObject;
begin
  {if PlayObject.m_nDealGoldPose = 1 then begin
    GotoLable(User, '@dealgoldPlayError', False);
    Exit;
  end;  }
  PoseHuman := TPlayObject(PlayObject.GetPoseCreate());
  if (PoseHuman <> nil) and (PoseHuman.GetPoseCreate = PlayObject) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) { and (PoseHuman.m_nDealGoldPose <> 1) } then begin
    PlayObject.m_nDealGoldPose := 1;
    //PoseHuman.m_nDealGoldPose := 1;
    GotoLable(PlayObject, '@startdealgold', False);
  end else begin
    GotoLable(PlayObject, '@dealgoldpost', False);
  end;
end;

procedure TNormNpc.ActionOfGuildMemberMaxLimit(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGamePoint: Integer;
  nOldGamePoint: Integer;
  cMethod: Char;
  //Guild: TGUild;
  nMemberMaxLimit: Integer;

begin
  if PlayObject.m_MyGuild <> nil then begin
    //Guild := TGUild(PlayObject.m_MyGuild);
    nMemberMaxLimit := Str_ToInt(QuestActionInfo.sParam2, -1);
    if (nMemberMaxLimit < 0) then begin
      GetVarValue(PlayObject, QuestActionInfo.sParam2, nMemberMaxLimit);
      if (nMemberMaxLimit < 0) then begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GUILDMEMBERMAXLIMIT);
        Exit;
      end;
    end;
    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=': begin
          if nMemberMaxLimit >= 0 then begin
            TGUild(PlayObject.m_MyGuild).m_nMemberMaxLimit := nMemberMaxLimit;
          end;
        end;
      '-': begin
          nMemberMaxLimit := _MAX(0, TGUild(PlayObject.m_MyGuild).m_nMemberMaxLimit - nMemberMaxLimit);
          TGUild(PlayObject.m_MyGuild).m_nMemberMaxLimit := nMemberMaxLimit;
        end;
      '+': begin
          nMemberMaxLimit := _MAX(0, TGUild(PlayObject.m_MyGuild).m_nMemberMaxLimit + nMemberMaxLimit);
          TGUild(PlayObject.m_MyGuild).m_nMemberMaxLimit := nMemberMaxLimit;
        end;
    end;
  end;
end;

procedure TNormNpc.ActionOfOpenUserMarket(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nType: Integer;
begin
  nType := Str_ToInt(QuestActionInfo.sParam1, -1);
  if (nType < 0) or (nType > 8) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_OPENUSERMARKET);
    Exit;
  end;
  PlayObject.SendMsg(PlayObject, CM_SENDSELLOFFGOODSLIST, 0, nType, 0, 0, '');
end;

procedure TNormNpc.ClearScript;
var
  III, IIII: Integer;
  I, II: Integer;
  Script: pTScript;
  SayingRecord: pTSayingRecord;
  SayingProcedure: pTSayingProcedure;
  QuestConditionInfo: pTQuestConditionInfo;
  QuestActionInfo: pTQuestActionInfo;
begin
  for I := 0 to m_ScriptList.Count - 1 do begin
    Script := m_ScriptList.Items[I];
    for II := 0 to Script.RecordList.Count - 1 do begin
      SayingRecord := Script.RecordList.Items[II];
      for III := 0 to SayingRecord.ProcedureList.Count - 1 do begin
        SayingProcedure := SayingRecord.ProcedureList.Items[III];
        for IIII := 0 to SayingProcedure.ConditionList.Count - 1 do begin
          QuestConditionInfo := pTQuestConditionInfo(SayingProcedure.ConditionList.Items[IIII]);
          QuestConditionInfo.Script.Free;
          Dispose(QuestConditionInfo);
        end;
        for IIII := 0 to SayingProcedure.ActionList.Count - 1 do begin
          QuestActionInfo := pTQuestActionInfo(SayingProcedure.ActionList.Items[IIII]);
          QuestActionInfo.Script.Free;
          Dispose(QuestActionInfo);
        end;
        for IIII := 0 to SayingProcedure.ElseActionList.Count - 1 do begin
          QuestActionInfo := pTQuestActionInfo(SayingProcedure.ElseActionList.Items[IIII]);
          QuestActionInfo.Script.Free;
          Dispose(QuestActionInfo);
        end;
        SayingProcedure.ConditionList.Free;
        SayingProcedure.ActionList.Free;
        SayingProcedure.ElseActionList.Free;
        Dispose(SayingProcedure);
      end; // for
      SayingRecord.ProcedureList.Free;
      Dispose(SayingRecord);
    end; // for
    Script.RecordList.Free;
    Dispose(Script);
  end; // for
  m_ScriptList.Clear;
end;

procedure TNormNpc.Click(PlayObject: TPlayObject; sLabel: string);
begin
  PlayObject.m_nScriptGotoCount := 0;
  PlayObject.m_sScriptGoBackLable := '';
  PlayObject.m_sScriptCurrLable := '';
  if sLabel = '' then begin
    GotoLable(PlayObject, '@main', False);
  end else begin
    GotoLable(PlayObject, sLabel, False);
  end;
end;

function TNormNpc.ConditionOfCheckAccountIPList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sCharName: string;
  sCharAccount: string;
  sCharIPaddr: string;
  sLine: string;
  sName: string;
  sIPaddr: string;
begin
  Result := False;
  LoadList := TStringList.Create;
  try
    sCharName := PlayObject.m_sCharName;
    sCharAccount := PlayObject.m_sUserID;
    sCharIPaddr := PlayObject.m_sIPaddr;
    if FileExists(g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1) then begin
      LoadList.LoadFromFile(g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1);
      for I := 0 to LoadList.Count - 1 do begin
        sLine := LoadList.Strings[I];
        if sLine[1] = ';' then Continue;
        sIPaddr := GetValidStr3(sLine, sName, [' ', '/', #9]);
        sIPaddr := Trim(sIPaddr);
        if (sName = sCharAccount) and (sIPaddr = sCharIPaddr) then begin
          Result := True;
          Break;
        end;
      end;
    end else begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKACCOUNTIPLIST);
    end;
  finally
    LoadList.Free
  end;
end;

function TNormNpc.ConditionOfCheckBagSize(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nSize: Integer;
begin
  Result := False;
  nSize := Str_ToInt(QuestConditionInfo.sParam1, -1);
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    if nSize < 0 then
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam1, nSize);
  end else
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
    if nSize < 0 then
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam1, nSize);
  end;
  if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
    if (nSize <= 0) or (nSize > MAXBAGITEM) then begin
      ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKBAGSIZE);
      Exit;
    end;
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      if BaseObject.m_ItemList.Count + nSize <= MAXBAGITEM then
        Result := True;
    end else
      if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
      if BaseObject.m_ItemList.Count + nSize <= THeroObject(BaseObject).m_nItemBagCount then
        Result := True;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckBonusPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nTotlePoint, nCount: Integer;
  cMethod: Char;

  sVar, sValue: string;
  nValue: Integer;
begin
  Result := False;
  nTotlePoint := PlayObject.m_BonusAbil.DC +
    PlayObject.m_BonusAbil.MC +
    PlayObject.m_BonusAbil.SC +
    PlayObject.m_BonusAbil.AC +
    PlayObject.m_BonusAbil.MAC +
    PlayObject.m_BonusAbil.HP +
    PlayObject.m_BonusAbil.MP +
    PlayObject.m_BonusAbil.Hit +
    PlayObject.m_BonusAbil.Speed +
    PlayObject.m_BonusAbil.X2;
  nTotlePoint := nTotlePoint + PlayObject.m_nBonusPoint;
  cMethod := QuestConditionInfo.sParam1[1];

  nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nCount);

  case cMethod of
    '=': if nTotlePoint = nCount then Result := True;
    '>': if nTotlePoint > nCount then Result := True;
    '<': if nTotlePoint < nCount then Result := True;
  else if nTotlePoint >= nCount then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckHP(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMIN, nMax: Integer;

  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=': begin
          if BaseObject.m_WAbil.MaxHP = nMax then begin
            Result := True;
          end;
        end;
      '>': begin
          if BaseObject.m_WAbil.MaxHP > nMax then begin
            Result := True;
          end;
        end;
      '<': begin
          if BaseObject.m_WAbil.MaxHP < nMax then begin
            Result := True;
          end;
        end;
    else begin
        if BaseObject.m_WAbil.MaxHP >= nMax then begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  Result := False;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam3[1];
  nMIN := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);

  if (nMIN < 0) then begin
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nMIN);
    end else
      if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam2, nMIN);
    end;
  end;

  if (nMax < 0) then begin
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam4, nMax);
    end else
      if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam4, nMax);
    end;
  end;

  if (nMIN < 0) or (nMax < 0) then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKHP);
    Exit;
  end;

  case cMethodMin of
    '=': begin
        if (m_WAbil.HP = nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '>': begin
        if (BaseObject.m_WAbil.HP > nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '<': begin
        if (BaseObject.m_WAbil.HP < nMIN) then begin
          Result := CheckHigh;
        end;
      end;
  else begin
      if (BaseObject.m_WAbil.HP >= nMIN) then begin
        Result := CheckHigh;
      end;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckMP(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMIN, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=': begin
          if BaseObject.m_WAbil.MaxMP = nMax then begin
            Result := True;
          end;
        end;
      '>': begin
          if BaseObject.m_WAbil.MaxMP > nMax then begin
            Result := True;
          end;
        end;
      '<': begin
          if BaseObject.m_WAbil.MaxMP < nMax then begin
            Result := True;
          end;
        end;
    else begin
        if BaseObject.m_WAbil.MaxMP >= nMax then begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  Result := False;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam3[1];
  nMIN := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);

  if (nMIN < 0) then begin
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nMIN);
    end else
      if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam2, nMIN);
    end;
  end;

  if (nMax < 0) then begin
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam4, nMax);
    end else
      if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam4, nMax);
    end;
  end;

  if (nMIN < 0) or (nMax < 0) then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKMP);
    Exit;
  end;
  case cMethodMin of
    '=': begin
        if (m_WAbil.MP = nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '>': begin
        if (BaseObject.m_WAbil.MP > nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '<': begin
        if (BaseObject.m_WAbil.MP < nMIN) then begin
          Result := CheckHigh;
        end;
      end;
  else begin
      if (BaseObject.m_WAbil.MP >= nMIN) then begin
        Result := CheckHigh;
      end;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckDC(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMIN, nMax: Integer;

  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=': begin
          if HiWord(BaseObject.m_WAbil.DC) = nMax then begin
            Result := True;
          end;
        end;
      '>': begin
          if HiWord(BaseObject.m_WAbil.DC) > nMax then begin
            Result := True;
          end;
        end;
      '<': begin
          if HiWord(BaseObject.m_WAbil.DC) < nMax then begin
            Result := True;
          end;
        end;
    else begin
        if HiWord(BaseObject.m_WAbil.DC) >= nMax then begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  Result := False;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam3[1];
  nMIN := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);

  if (nMIN < 0) then begin
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nMIN);
    end else
      if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam2, nMIN);
    end;
  end;

  if (nMax < 0) then begin
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam4, nMax);
    end else
      if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam4, nMax);
    end;
  end;
  if (nMIN < 0) or (nMax < 0) then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKDC);
    Exit;
  end;
  case cMethodMin of
    '=': begin
        if (LoWord(BaseObject.m_WAbil.DC) = nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '>': begin
        if (LoWord(BaseObject.m_WAbil.DC) > nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '<': begin
        if (LoWord(BaseObject.m_WAbil.DC) < nMIN) then begin
          Result := CheckHigh;
        end;
      end;
  else begin
      if (LoWord(BaseObject.m_WAbil.DC) >= nMIN) then begin
        Result := CheckHigh;
      end;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckMC(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMIN, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=': begin
          if HiWord(BaseObject.m_WAbil.MC) = nMax then begin
            Result := True;
          end;
        end;
      '>': begin
          if HiWord(BaseObject.m_WAbil.MC) > nMax then begin
            Result := True;
          end;
        end;
      '<': begin
          if HiWord(BaseObject.m_WAbil.MC) < nMax then begin
            Result := True;
          end;
        end;
    else begin
        if HiWord(BaseObject.m_WAbil.MC) >= nMax then begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  Result := False;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam3[1];
  nMIN := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);

  if (nMIN < 0) then begin
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nMIN);
    end else
      if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam2, nMIN);
    end;
  end;

  if (nMax < 0) then begin
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam4, nMax);
    end else
      if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam4, nMax);
    end;
  end;

  if (nMIN < 0) or (nMax < 0) then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKMC);
    Exit;
  end;

  case cMethodMin of
    '=': begin
        if (LoWord(BaseObject.m_WAbil.MC) = nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '>': begin
        if (LoWord(BaseObject.m_WAbil.MC) > nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '<': begin
        if (LoWord(BaseObject.m_WAbil.MC) < nMIN) then begin
          Result := CheckHigh;
        end;
      end;
  else begin
      if (LoWord(BaseObject.m_WAbil.MC) >= nMIN) then begin
        Result := CheckHigh;
      end;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckSC(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMIN, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=': begin
          if HiWord(BaseObject.m_WAbil.SC) = nMax then begin
            Result := True;
          end;
        end;
      '>': begin
          if HiWord(BaseObject.m_WAbil.SC) > nMax then begin
            Result := True;
          end;
        end;
      '<': begin
          if HiWord(BaseObject.m_WAbil.SC) < nMax then begin
            Result := True;
          end;
        end;
    else begin
        if HiWord(BaseObject.m_WAbil.SC) >= nMax then begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  Result := False;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam3[1];
  nMIN := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);

  if (nMIN < 0) then begin
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nMIN);
    end else
      if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam2, nMIN);
    end;
  end;

  if (nMax < 0) then begin
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam4, nMax);
    end else
      if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam4, nMax);
    end;
  end;

  if (nMIN < 0) or (nMax < 0) then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKSC);
    Exit;
  end;

  case cMethodMin of
    '=': begin
        if (LoWord(BaseObject.m_WAbil.SC) = nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '>': begin
        if (LoWord(BaseObject.m_WAbil.SC) > nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '<': begin
        if (LoWord(BaseObject.m_WAbil.SC) < nMIN) then begin
          Result := CheckHigh;
        end;
      end;
  else begin
      if (LoWord(BaseObject.m_WAbil.SC) >= nMIN) then begin
        Result := CheckHigh;
      end;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckExp(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  dwExp: LongWord;
  nExp: Integer;
begin
  Result := False;
  dwExp := LongWord(Str_ToInt(QuestConditionInfo.sParam2, -1));
  if (dwExp < 0) then begin
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, Integer(dwExp));
    end else
      if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam2, Integer(dwExp));
    end;
  end;

  if dwExp < 0 then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKEXP);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if BaseObject.m_Abil.Exp = dwExp then Result := True;
    '>': if BaseObject.m_Abil.Exp > dwExp then Result := True;
    '<': if BaseObject.m_Abil.Exp < dwExp then Result := True;
  else if BaseObject.m_Abil.Exp >= dwExp then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckFlourishPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGUild;
begin
  Result := False;
  nPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nPoint < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nPoint);
    if nPoint < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKFLOURISHPOINT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if Guild.nFlourishing = nPoint then Result := True;
    '>': if Guild.nFlourishing > nPoint then Result := True;
    '<': if Guild.nFlourishing < nPoint then Result := True;
  else if Guild.nFlourishing >= nPoint then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckChiefItemCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nCount: Integer;
  Guild: TGUild;
begin
  Result := False;
  nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKFLOURISHPOINT);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then begin
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if Guild.nChiefItemCount = nCount then Result := True;
    '>': if Guild.nChiefItemCount > nCount then Result := True;
    '<': if Guild.nChiefItemCount < nCount then Result := True;
  else if Guild.nChiefItemCount >= nCount then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckGuildAuraePoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGUild;
begin
  Result := False;
  nPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nPoint < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nPoint);
    if nPoint < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKAURAEPOINT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if Guild.nAurae = nPoint then Result := True;
    '>': if Guild.nAurae > nPoint then Result := True;
    '<': if Guild.nAurae < nPoint then Result := True;
  else if Guild.nAurae >= nPoint then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckGuildBuildPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGUild;
begin
  Result := False;
  nPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nPoint < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nPoint);
    if nPoint < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKBUILDPOINT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if Guild.nBuildPoint = nPoint then Result := True;
    '>': if Guild.nBuildPoint > nPoint then Result := True;
    '<': if Guild.nBuildPoint < nPoint then Result := True;
  else if Guild.nBuildPoint >= nPoint then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckStabilityPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGUild;
begin
  Result := False;
  nPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nPoint < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nPoint);
    if nPoint < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSTABILITYPOINT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if Guild.nStability = nPoint then Result := True;
    '>': if Guild.nStability > nPoint then Result := True;
    '<': if Guild.nStability < nPoint then Result := True;
  else if Guild.nStability >= nPoint then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckGameGold(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nGameGold: Integer;
begin
  Result := False;
  nGameGold := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nGameGold < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nGameGold);
    if nGameGold < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGAMEGOLD);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nGameGold = nGameGold then Result := True;
    '>': if PlayObject.m_nGameGold > nGameGold then Result := True;
    '<': if PlayObject.m_nGameGold < nGameGold then Result := True;
  else if PlayObject.m_nGameGold >= nGameGold then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckGamePoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nGamePoint: Integer;
begin
  Result := False;
  nGamePoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nGamePoint < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nGamePoint);
    if nGamePoint < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGAMEPOINT);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nGamePoint = nGamePoint then Result := True;
    '>': if PlayObject.m_nGamePoint > nGamePoint then Result := True;
    '<': if PlayObject.m_nGamePoint < nGamePoint then Result := True;
  else if PlayObject.m_nGamePoint >= nGamePoint then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckGroupCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nCount: Integer;
begin
  Result := False;
  if PlayObject.m_GroupOwner = nil then Exit;

  nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nCount);
    if nCount < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGROUPCOUNT);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_GroupOwner.m_GroupMembers.Count = nCount then Result := True;
    '>': if PlayObject.m_GroupOwner.m_GroupMembers.Count > nCount then Result := True;
    '<': if PlayObject.m_GroupOwner.m_GroupMembers.Count < nCount then Result := True;
  else if PlayObject.m_GroupOwner.m_GroupMembers.Count >= nCount then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckHaveGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  //  Result:=PlayObject.m_MyGuild = nil;
  Result := PlayObject.m_MyGuild <> nil; // 01-16 更正检查结果反了
end;

function TNormNpc.ConditionOfCheckInMapRange(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sMapName: string;
  nX, nY, nRange: Integer;
begin
  Result := False;
  sMapName := QuestConditionInfo.sParam1;
  nX := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nY := Str_ToInt(QuestConditionInfo.sParam3, -1);
  nRange := Str_ToInt(QuestConditionInfo.sParam4, -1);
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    if nX < 0 then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nX);
    end;
    if nY < 0 then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam3, nY);
    end;
    if nRange < 0 then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam4, nRange);
    end;
  end else
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
    if nX < 0 then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam2, nX);
    end;
    if nY < 0 then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam3, nY);
    end;
    if nRange < 0 then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam4, nRange);
    end;
  end;
  if (sMapName = '') or (nX < 0) or (nY < 0) or (nRange < 0) then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKINMAPRANGE);
    Exit;
  end;
  if CompareText(BaseObject.m_sMapName, sMapName) <> 0 then Exit;
  if (abs(BaseObject.m_nCurrX - nX) <= nRange) and (abs(BaseObject.m_nCurrY - nY) <= nRange) then
    Result := True;
end;

function TNormNpc.ConditionOfCheckIsAttackGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if m_Castle = nil then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISATTACKGUILD);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then Exit;
  Result := TUserCastle(m_Castle).IsAttackGuild(TGUild(PlayObject.m_MyGuild));
end;

function TNormNpc.ConditionOfCheckCastleChageDay(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nDay: Integer;
  cMethod: Char;
  nChangeDay: Integer;
begin
  Result := False;
  nDay := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nDay < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nDay);
  end;
  if (nDay < 0) or (m_Castle = nil) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CASTLECHANGEDAY);
    Exit;
  end;
  nChangeDay := GetDayCount(Now, TUserCastle(m_Castle).m_ChangeDate);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if nChangeDay = nDay then Result := True;
    '>': if nChangeDay > nDay then Result := True;
    '<': if nChangeDay < nDay then Result := True;
  else if nChangeDay >= nDay then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckCastleWarDay(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nDay: Integer;
  cMethod: Char;
  nWarDay: Integer;
begin
  Result := False;
  nDay := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nDay < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nDay);
  end;
  if (nDay < 0) or (m_Castle = nil) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CASTLEWARDAY);
    Exit;
  end;
  nWarDay := GetDayCount(Now, TUserCastle(m_Castle).m_WarDate);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if nWarDay = nDay then Result := True;
    '>': if nWarDay > nDay then Result := True;
    '<': if nWarDay < nDay then Result := True;
  else if nWarDay >= nDay then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckCastleDoorStatus(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nDay: Integer;
  cMethod: Char;
  nDoorStatus: Integer;
  CastleDoor: TCastleDoor;
begin
  Result := False;
  nDay := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nDay < 0 then
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nDay);

  nDoorStatus := -1;
  if CompareText(QuestConditionInfo.sParam1, '损坏') = 0 then nDoorStatus := 0;
  if CompareText(QuestConditionInfo.sParam1, '开启') = 0 then nDoorStatus := 1;
  if CompareText(QuestConditionInfo.sParam1, '关闭') = 0 then nDoorStatus := 2;

  if (nDay < 0) or (m_Castle = nil) or (nDoorStatus < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCASTLEDOOR);
    Exit;
  end;
  CastleDoor := TCastleDoor(TUserCastle(m_Castle).m_MainDoor.ActorObject);

  case nDoorStatus of
    0: if CastleDoor.m_boDeath then Result := True;
    1: if CastleDoor.m_boOpened then Result := True;
    2: if not CastleDoor.m_boOpened then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckIsAttackAllyGuild(
  PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if m_Castle = nil then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISATTACKALLYGUILD);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then Exit;
  Result := TUserCastle(m_Castle).IsAttackAllyGuild(TGUild(PlayObject.m_MyGuild));
end;

function TNormNpc.ConditionOfCheckIsDefenseAllyGuild(
  PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if m_Castle = nil then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISDEFENSEALLYGUILD);
    Exit;
  end;

  if PlayObject.m_MyGuild = nil then Exit;
  Result := TUserCastle(m_Castle).IsDefenseAllyGuild(TGUild(PlayObject.m_MyGuild));
end;

function TNormNpc.ConditionOfCheckIsDefenseGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if m_Castle = nil then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISDEFENSEGUILD);
    Exit;
  end;

  if PlayObject.m_MyGuild = nil then Exit;
  Result := TUserCastle(m_Castle).IsDefenseGuild(TGUild(PlayObject.m_MyGuild));
end;

function TNormNpc.ConditionOfCheckIsCastleaGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  //  if (PlayObject.m_MyGuild <> nil) and (UserCastle.m_MasterGuild = PlayObject.m_MyGuild) then
  if g_CastleManager.IsCastleMember(PlayObject) <> nil then
    Result := True;
end;

function TNormNpc.ConditionOfCheckIsCastleMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  //if PlayObject.IsGuildMaster and (UserCastle.m_MasterGuild = PlayObject.m_MyGuild) then
  if PlayObject.IsGuildMaster and (g_CastleManager.IsCastleMember(PlayObject) <> nil) then
    Result := True;
end;

function TNormNpc.ConditionOfCheckIsGuildMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := PlayObject.IsGuildMaster;
end;

function TNormNpc.ConditionOfCheckIsMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if (PlayObject.m_sMasterName <> '') and (PlayObject.m_boMaster) then
    Result := True;
end;

function TNormNpc.ConditionOfCheckListCount(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin

end;

function TNormNpc.ConditionOfCheckItemAddValue(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  nWhere: Integer;
  nAddAllValue, nAddValue: Integer;
  UserItem: pTUserItem;
  cMethod: Char;
  nValType: Integer;
begin
  Result := False;
  nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);
  nValType := Str_ToInt(QuestConditionInfo.sParam2, -1);
  cMethod := QuestConditionInfo.sParam3[1];
  nAddValue := Str_ToInt(QuestConditionInfo.sParam4, -1);
  if (nValType < 0) or (nValType > 14) or (nWhere < 0) or (nWhere > High(THumanUseItems)) or (nAddValue < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMADDVALUE);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  if UserItem.wIndex = 0 then Exit;
  //nAddAllValue := 0;
  {for i := Low(UserItem.btValue) to High(UserItem.btValue) do begin
    Inc(nAddAllValue, UserItem.btValue[i]);
  end;}
  if nValType = 14 then nAddAllValue := UserItem.DuraMax
  else nAddAllValue := UserItem.btValue[nValType];
  case cMethod of
    '=': if nAddAllValue = nAddValue then Result := True;
    '>': if nAddAllValue > nAddValue then Result := True;
    '<': if nAddAllValue < nAddValue then Result := True;
  else if nAddAllValue >= nAddValue then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckItemType(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nWhere: Integer;
  nType: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  Result := False;
  nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);
  nType := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    if nWhere < 0 then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam1, nWhere);
    end;
    if nType < 0 then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nType);
    end;
  end else
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
    if nWhere < 0 then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam1, nWhere);
    end;
    if nType < 0 then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam2, nType);
    end;
  end;

  if not (nWhere in [Low(THumanUseItems)..High(THumanUseItems)]) then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKITEMTYPE);
    Exit;
  end;
  UserItem := @BaseObject.m_UseItems[nWhere];
  if UserItem.wIndex = 0 then Exit;
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (StdItem <> nil) and (StdItem.StdMode = nType) then begin
    Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckLevelEx(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  cMethod: Char;
begin
  Result := False;
  nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nLevel < 0 then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nLevel);
      if nLevel < 0 then begin
        ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKLEVELEX);
        Exit;
      end;
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam2, nLevel);
      if nLevel < 0 then begin
        ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKLEVELEX);
        Exit;
      end;
    end;
  end;

  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if BaseObject.m_Abil.Level = nLevel then Result := True;
    '>': if BaseObject.m_Abil.Level > nLevel then Result := True;
    '<': if BaseObject.m_Abil.Level < nLevel then Result := True;
  else if BaseObject.m_Abil.Level >= nLevel then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckNameListPostion(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sCharName: string;
  nNamePostion, nPostion: Integer;
  sLine: string;
  cMethod: Char;

  sVar, sValue: string;
  nValue: Integer;
  VarInfo: TVarInfo;
begin
  Result := False;
  nNamePostion := -1;
  LoadList := TStringList.Create;
  try
    sCharName := BaseObject.m_sCharName;
    if FileExists(g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1) then begin
      LoadList.LoadFromFile(g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1);
      for I := 0 to LoadList.Count - 1 do begin
        sLine := Trim(LoadList.Strings[I]);
        if (sLine = '') or (sLine[1] = ';') then Continue;
        if CompareText(sLine, sCharName) = 0 then begin
          nNamePostion := I + 1;
          Break;
        end;
      end;
    end else begin
      ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKNAMELISTPOSITION);
    end;
  finally
    LoadList.Free
  end;

  cMethod := QuestConditionInfo.sParam2[1];
  nPostion := Str_ToInt(QuestConditionInfo.sParam3, -1);

  if (QuestConditionInfo.sParam4 <> '') and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    VarInfo := GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam4, sVar, sValue, nValue);
    case VarInfo.VarAttr of
      aNone, aConst: begin
          ScriptConditionError(TPlayObject(BaseObject), QuestConditionInfo, sSC_CHECKNAMELISTPOSITION);
          Exit;
        end;
      aFixStr: SetValNameValue(TPlayObject(BaseObject), sVar, sValue, nNamePostion);
      aDynamic: SetDynamicValue(TPlayObject(BaseObject), sVar, sValue, nNamePostion);
    end;
  end;

  if nPostion < 0 then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKNAMELISTPOSITION);
    Exit;
  end;

  case cMethod of
    '=': if nNamePostion = nPostion then Result := True;
    '>': if nNamePostion > nPostion then Result := True;
    '<': if nNamePostion < nPostion then Result := True;
  else if nNamePostion >= nPostion then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckBagItemInList(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I, II, nItemCount: Integer;
  LoadList: TStringList;
  sLineText, sListFileName, sItemName, sItemCount: string;
  UserItem: pTUserItem;

  sVar, sValue: string;
  nValue: Integer;
  VarInfo: TVarInfo;
begin
  Result := False;

  sListFileName := g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1;
  nItemCount := Str_ToInt(QuestConditionInfo.sParam2, -1);

  LoadList := TStringList.Create;
  if FileExists(sListFileName) then begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
   { for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      if (sLineText = '') or (sLineText[1] = ';') then Continue;
      sItemCount := GetValidStr3(sLineText, sItemName, [' ', '/', #9]);
      nItemCount := Str_ToInt(sItemCount, 1);
      ItemList.AddObject(sItemName, TObject(nItemCount));
    end;  }
    {for I := LoadList.Count - 1 downto 0 do begin
      sItemName := Trim(LoadList.Strings[I]);
      if (sItemName = '') or (sItemName[1] = ';') then LoadList.Delete(I);
    end;

    while LoadList.Count > 0 do begin
      sItemName := LoadList.Strings[0];
      ItemList.AddObject(sItemName, TObject(1));
      LoadList.Delete(0);
      for I := LoadList.Count - 1 downto 0 do begin
        if CompareText(LoadList.Strings[I], sItemName) = 0 then begin
          ItemList.Objects[ItemList.Count - 1] := TObject(Integer(ItemList.Objects[ItemList.Count - 1]) + 1);
          LoadList.Delete(I);
        end;
      end;
    end;
    }
  end else begin
    MainOutMessage('file not found => ' + sListFileName);
  end;

  if (nItemCount < 0) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then
    GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nItemCount);

  if nItemCount < 0 then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKBAGITEMINLIST);
    Exit;
  end;

  for I := 0 to LoadList.Count - 1 do begin
    sLineText := Trim(LoadList.Strings[I]);
    if (sLineText = '') or (sLineText[1] = ';') then Continue;

    sItemName := LoadList.Strings[I];

    if nItemCount <= 0 then break;

    for II := 0 to BaseObject.m_ItemList.Count - 1 do begin
      UserItem := BaseObject.m_ItemList.Items[II];
      if CompareText(UserEngine.GetStdItemName(UserItem.wIndex), sItemName) = 0 then begin
        Dec(nItemCount);
        if nItemCount <= 0 then break;
      end;
    end;
  end;

  if nItemCount > 0 then begin
    if (QuestConditionInfo.sParam3 <> '') and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      VarInfo := GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam3, sVar, sValue, nValue);
      case VarInfo.VarAttr of
        aNone, aConst: ScriptConditionError(TPlayObject(BaseObject), QuestConditionInfo, sSC_CHECKBAGITEMINLIST);
        aFixStr: SetValNameValue(TPlayObject(BaseObject), sVar, sValue, nItemCount);
        aDynamic: SetDynamicValue(TPlayObject(BaseObject), sVar, sValue, nItemCount);
      end;
    end;
    Result := False;
  end else Result := True;

  LoadList.Free;
end;

function TNormNpc.ConditionOfCheckMarry(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if PlayObject.m_sDearName <> '' then Result := True;
end;

function TNormNpc.ConditionOfCheckMarryCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount: Integer;
  cMethod: Char;
begin
  Result := False;
  nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nCount);
    if nCount < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMARRYCOUNT);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_btMarryCount = nCount then Result := True;
    '>': if PlayObject.m_btMarryCount > nCount then Result := True;
    '<': if PlayObject.m_btMarryCount < nCount then Result := True;
  else if PlayObject.m_btMarryCount >= nCount then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if (PlayObject.m_sMasterName <> '') and (not PlayObject.m_boMaster) then
    Result := True;
end;

function TNormNpc.ConditionOfCheckMemBerLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  cMethod: Char;
begin
  Result := False;
  nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nLevel < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nLevel);
    if nLevel < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMEMBERLEVEL);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nMemberLevel = nLevel then Result := True;
    '>': if PlayObject.m_nMemberLevel > nLevel then Result := True;
    '<': if PlayObject.m_nMemberLevel < nLevel then Result := True;
  else if PlayObject.m_nMemberLevel >= nLevel then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckMemberType(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nType: Integer;
  cMethod: Char;
begin
  Result := False;
  nType := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nType < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nType);
    if nType < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMEMBERTYPE);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nMemberType = nType then Result := True;
    '>': if PlayObject.m_nMemberType > nType then Result := True;
    '<': if PlayObject.m_nMemberType < nType then Result := True;
  else if PlayObject.m_nMemberType >= nType then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckNameIPList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sCharName: string;
  sCharAccount: string;
  sCharIPaddr: string;
  sLine: string;
  sName: string;
  sIPaddr: string;
begin
  Result := False;
  LoadList := TStringList.Create;
  try
    sCharName := PlayObject.m_sCharName;
    sCharAccount := PlayObject.m_sUserID;
    sCharIPaddr := PlayObject.m_sIPaddr;
    if FileExists(g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1) then begin
      LoadList.LoadFromFile(g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1);
      for I := 0 to LoadList.Count - 1 do begin
        sLine := LoadList.Strings[I];
        if sLine[1] = ';' then Continue;
        sIPaddr := GetValidStr3(sLine, sName, [' ', '/', #9]);
        sIPaddr := Trim(sIPaddr);
        if (sName = sCharName) and (sIPaddr = sCharIPaddr) then begin
          Result := True;
          Break;
        end;
      end;
    end else begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKNAMEIPLIST);
    end;
  finally
    LoadList.Free
  end;
end;

function TNormNpc.ConditionOfCheckPoseDir(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TActorObject;
begin
  Result := False;
  PoseHuman := BaseObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.GetPoseCreate = BaseObject) {and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT)} then begin
    case QuestConditionInfo.nParam1 of
      1: if PoseHuman.m_btGender = BaseObject.m_btGender then Result := True; //要求相同性别
      2: if PoseHuman.m_btGender <> BaseObject.m_btGender then Result := True; //要求不同性别
    else Result := True; //无参数时不判别性别
    end;
  end;
end;

function TNormNpc.ConditionOfCheckPoseGender(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TActorObject;
  btSex: Byte;
begin
  Result := False;
  btSex := 0;
  if CompareText(QuestConditionInfo.sParam1, 'MAN') = 0 then begin
    btSex := 0;
  end else
    if CompareText(QuestConditionInfo.sParam1, '男') = 0 then begin
    btSex := 0;
  end else
    if CompareText(QuestConditionInfo.sParam1, 'WOMAN') = 0 then begin
    btSex := 1;
  end else
    if CompareText(QuestConditionInfo.sParam1, '女') = 0 then begin
    btSex := 1;
  end;
  PoseHuman := BaseObject.GetPoseCreate();
  if (PoseHuman <> nil) { and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT)} then begin
    if PoseHuman.m_btGender = btSex then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckPoseIsMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TActorObject;
begin
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    if (TPlayObject(PoseHuman).m_sMasterName <> '') and (TPlayObject(PoseHuman).m_boMaster) then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckPoseLevel(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  PoseHuman: TActorObject;
  cMethod: Char;
begin
  Result := False;
  nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nLevel < 0 then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nLevel);
      if nLevel < 0 then begin
        ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKPOSELEVEL);
        Exit;
      end;
    end else begin
      ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKPOSELEVEL);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  PoseHuman := BaseObject.GetPoseCreate();
  if (PoseHuman <> nil) { and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT)} then begin
    case cMethod of
      '=': if PoseHuman.m_Abil.Level = nLevel then Result := True;
      '>': if PoseHuman.m_Abil.Level > nLevel then Result := True;
      '<': if PoseHuman.m_Abil.Level < nLevel then Result := True;
    else if PoseHuman.m_Abil.Level >= nLevel then Result := True;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckPoseMarry(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TActorObject;
begin
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    if TPlayObject(PoseHuman).m_sDearName <> '' then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckPoseMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TActorObject;
begin
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    if (TPlayObject(PoseHuman).m_sMasterName <> '') and not (TPlayObject(PoseHuman).m_boMaster) then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckServerName(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sServerName: string;
begin
  Result := False;
  if QuestConditionInfo.sParam1 = g_Config.sServerName then Result := True;
end;

function TNormNpc.ConditionOfCheckSlaveCount(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount: Integer;
  cMethod: Char;
begin
  Result := False;
  nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nCount);
      if nCount < 0 then begin
        ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKSLAVECOUNT);
        Exit;
      end;
    end else begin
      ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKSLAVECOUNT);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if BaseObject.m_SlaveList.Count = nCount then Result := True;
    '>': if BaseObject.m_SlaveList.Count > nCount then Result := True;
    '<': if BaseObject.m_SlaveList.Count < nCount then Result := True;
  else if BaseObject.m_SlaveList.Count >= nCount then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckSafeZone(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := BaseObject.InSafeZone;
end;

function TNormNpc.ConditionOfCheckMapName(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sCharName: string;
  sMapName: string;
begin
  Result := False;
  sCharName := BaseObject.m_sCharName;
  sMapName := QuestConditionInfo.sParam1;
  if g_MapManager.FindMap(sMapName) = nil then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam1, sMapName)
    else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam1, sMapName);
  end;
  if sMapName = BaseObject.m_sMapName then Result := True;
end;

function TNormNpc.ConditionOfCheckSkill(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nSkillLevel: Integer;
  cMethod: Char;
  UserMagic: pTUserMagic;
begin
  Result := False;
  nSkillLevel := Str_ToInt(QuestConditionInfo.sParam3, -1);
  if nSkillLevel < 0 then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam3, nSkillLevel);
      if nSkillLevel < 0 then begin
        ScriptConditionError(BaseObject, QuestConditionInfo, sCHECKSKILL);
        Exit;
      end;
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam3, nSkillLevel);
      if nSkillLevel < 0 then begin
        ScriptConditionError(BaseObject, QuestConditionInfo, sCHECKSKILL);
        Exit;
      end;
    end;
  end;
  if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
    UserMagic := nil;
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      UserMagic := TPlayObject(BaseObject).GetMagicInfo(QuestConditionInfo.sParam1);
    end else begin
      UserMagic := THeroObject(BaseObject).FindMagic(QuestConditionInfo.sParam1);
    end;
    if UserMagic = nil then Exit;
    cMethod := QuestConditionInfo.sParam2[1];
    case cMethod of
      '=': if UserMagic.btLevel = nSkillLevel then Result := True;
      '>': if UserMagic.btLevel > nSkillLevel then Result := True;
      '<': if UserMagic.btLevel < nSkillLevel then Result := True;
    else if UserMagic.btLevel >= nSkillLevel then Result := True;
    end;
  end;
end;

function TNormNpc.ConditionOfAnsiContainsText(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sValue1: string;
  sValue2: string;
begin
  Result := False;

  sValue1 := QuestConditionInfo.sParam1;
  sValue2 := QuestConditionInfo.sParam2;

  sValue1 := GetLineVariableText(PlayObject, QuestConditionInfo.sParam1);
  sValue2 := GetLineVariableText(PlayObject, QuestConditionInfo.sParam2);

  GetVarValue(PlayObject, sValue1, sValue1);
  GetVarValue(PlayObject, sValue2, sValue2);

  Result := AnsiContainsText(sValue1, sValue2);
end;

function TNormNpc.ConditionOfCompareText(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sValue1: string;
  sValue2: string;
begin
  Result := False;
  sValue1 := QuestConditionInfo.sParam1;
  sValue2 := QuestConditionInfo.sParam2;
  sValue1 := GetLineVariableText(PlayObject, QuestConditionInfo.sParam1);
  sValue2 := GetLineVariableText(PlayObject, QuestConditionInfo.sParam2);
  GetVarValue(PlayObject, sValue1, sValue1);
  GetVarValue(PlayObject, sValue2, sValue2);
  Result := CompareText(sValue1, sValue2) = 0;
end;

function TNormNpc.ConditionOfCheckStationTime(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount: Integer;
  cMethod: Char;
begin
  Result := False;
  nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nCount);
      if nCount < 0 then begin
        ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKSTATIONTIME);
        Exit;
      end;
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam2, nCount);
      if nCount < 0 then begin
        ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKSTATIONTIME);
        Exit;
      end;
    end;
  end;
  nCount := nCount * 60 * 1000;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if GetTickCount - BaseObject.m_dwStationTick = nCount then Result := True;
    '>': if GetTickCount - BaseObject.m_dwStationTick > nCount then Result := True;
    '<': if GetTickCount - BaseObject.m_dwStationTick < nCount then Result := True;
  else if GetTickCount - BaseObject.m_dwStationTick >= nCount then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckHasHero(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := PlayObject.m_sHeroCharName <> '';
end;

function TNormNpc.ConditionOfCheckGuildMeberMaxLimit(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nGuildMeberMaxLimit: Integer;
  Guild: TGUild;
begin
  Result := False;
  if PlayObject.m_MyGuild <> nil then begin
    Guild := TGUild(PlayObject.m_MyGuild);
    nGuildMeberMaxLimit := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nGuildMeberMaxLimit < 0 then begin
      GetVarValue(PlayObject, QuestConditionInfo.sParam2, nGuildMeberMaxLimit);
      if nGuildMeberMaxLimit < 0 then begin
        ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGUILDMEMBERMAXLIMIT);
        Exit;
      end;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if Guild.m_nMemberMaxLimit = nGuildMeberMaxLimit then Result := True;
      '>': if Guild.m_nMemberMaxLimit > nGuildMeberMaxLimit then Result := True;
      '<': if Guild.m_nMemberMaxLimit < nGuildMeberMaxLimit then Result := True;
    else if Guild.m_nMemberMaxLimit >= nGuildMeberMaxLimit then Result := True;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckPKPoint(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPKPOINT: Integer;
begin
  Result := False;
  nPKPOINT := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nPKPOINT < 0 then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nPKPOINT);
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam2, nPKPOINT);
    end;
  end;
  if nPKPOINT < 0 then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKPKPOINTEX);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if BaseObject.PKLevel = nPKPOINT then Result := True;
    '>': if BaseObject.PKLevel > nPKPOINT then Result := True;
    '<': if BaseObject.PKLevel < nPKPOINT then Result := True;
  else if BaseObject.PKLevel >= nPKPOINT then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckRangeMapMagicEventCount(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nRange: Integer;
  nCount: Integer;
  nX, nY: Integer;
  Envir: TEnvirnoment;
  List: TList;
  sMapName: string;

  sVar, sValue: string;
  nValue: Integer;
  VarInfo: TVarInfo;
begin
  Result := False;
  sMapName := QuestConditionInfo.sParam1;
  nX := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nY := Str_ToInt(QuestConditionInfo.sParam3, -1);
  nRange := Str_ToInt(QuestConditionInfo.sParam4, -1);
  nCount := Str_ToInt(QuestConditionInfo.sParam6, -1);

  Envir := g_MapManager.FindMap(sMapName);

  if (Envir = nil) or (nCount < 0) or (nX < 0) or (nY < 0) or (nRange < 0) then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKRANGEMAPMAGICEVENTCOUNT);
    Exit;
  end;

  cMethod := QuestConditionInfo.sParam5[1];
  List := TList.Create;
  Envir.GetRangeEvents(nX, nY, nRange, ET_MAPMAGIC, List);
  case cMethod of
    '=': if List.Count = nCount then Result := True;
    '>': if List.Count > nCount then Result := True;
    '<': if List.Count < nCount then Result := True;
  else if List.Count >= nCount then Result := True;
  end;

  if (QuestConditionInfo.sParam7 <> '') and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    VarInfo := GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam7, sVar, sValue, nValue);
    case VarInfo.VarAttr of
      aNone,
        aConst: ScriptConditionError(TPlayObject(BaseObject), QuestConditionInfo, sSC_CHECKRANGEMAPMAGICEVENTCOUNT);
      aFixStr: SetValNameValue(TPlayObject(BaseObject), sVar, sValue, List.Count);
      aDynamic: SetDynamicValue(TPlayObject(BaseObject), sVar, sValue, List.Count);
    end;
  end;

  List.Free;
end;

function TNormNpc.ConditionOfIsUnderWar(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  UserCastle: TUserCastle;
  sCastleName: string;
begin
  Result := False;
  sCastleName := QuestConditionInfo.sParam1;
  {if (sCastleName='') and  (BaseObject.m_MyGuild<>nil) then begin
   UserCastle:= g_CastleManager.FindCastle(BaseObject.m_MyGuild);
    sCastleName :=
  end;}
  if sCastleName <> '' then begin
    g_CastleManager.Lock;
    try
      for I := 0 to g_CastleManager.m_CastleList.Count - 1 do begin
        UserCastle := TUserCastle(g_CastleManager.m_CastleList.Items[I]);
        if CompareText(UserCastle.m_sName, sCastleName) = 0 then begin
          Result := UserCastle.m_boUnderWar;
          break;
        end;
      //ListItem := ListViewCastle.Items.Add;
      //ListItem.Caption := IntToStr(I);
     //ListItem.SubItems.AddObject(UserCastle.m_sConfigDir, UserCastle);
     // ListItem.SubItems.Add(UserCastle.m_sName)
      end;
    finally
      g_CastleManager.UnLock;
    end;
  end;
end;

function TNormNpc.ConditionOfInCastleWarArea(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  Castle: TUserCastle;
begin
  //Result := False;
  g_CastleManager.Lock;
  try
    Castle := g_CastleManager.InCastleWarArea(BaseObject.m_PEnvir, BaseObject.m_nCurrX, BaseObject.m_nCurrY);
    Result := (Castle <> nil); // and Castle.m_boUnderWar;
  finally
    g_CastleManager.UnLock;
  end;
end;

function TNormNpc.ConditionOfGetDuelMap(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  Envir: TEnvirnoment;

  sVar, sValue: string;
  nValue: Integer;
  VarInfo: TVarInfo;
begin
  Result := False;
  if PlayObject.m_boStartDuel and (PlayObject.m_DuelTargetCret <> nil) then begin
    if (PlayObject.m_PEnvir = PlayObject.m_DuelTargetCret.m_PEnvir) then begin
      if PlayObject.m_PEnvir.m_boDuel and PlayObject.m_PEnvir.m_boDueling then begin
        VarInfo := GetVarValue(PlayObject, QuestConditionInfo.sParam1, sVar, sValue, nValue);
        case VarInfo.VarAttr of
          aNone, aConst: begin
              ScriptConditionError(PlayObject, QuestConditionInfo, sSC_GETDUELMAP);
              Exit;
            end;
          aFixStr: SetValNameValue(PlayObject, sVar, PlayObject.m_PEnvir.MapName, nValue);
          aDynamic: SetDynamicValue(PlayObject, sVar, PlayObject.m_PEnvir.MapName, nValue);
        end;
      end else begin
        Envir := g_MapManager.GetDuelMap;
        if Envir <> nil then begin
          VarInfo := GetVarValue(PlayObject, QuestConditionInfo.sParam1, sVar, sValue, nValue);
          case VarInfo.VarAttr of
            aNone, aConst: begin
                ScriptConditionError(PlayObject, QuestConditionInfo, sSC_GETDUELMAP);
                Exit;
              end;
            aFixStr: Envir.m_boDueling := SetValNameValue(PlayObject, sVar, Envir.MapName, nValue);
            aDynamic: Envir.m_boDueling := SetDynamicValue(PlayObject, sVar, Envir.MapName, nValue);
          end;
        end;
      end;
    end else begin
      if PlayObject.m_DuelTargetCret.m_PEnvir.m_boDuel and PlayObject.m_DuelTargetCret.m_PEnvir.m_boDueling then begin
        VarInfo := GetVarValue(PlayObject, QuestConditionInfo.sParam1, sVar, sValue, nValue);
        case VarInfo.VarAttr of
          aNone, aConst: begin
              ScriptConditionError(PlayObject, QuestConditionInfo, sSC_GETDUELMAP);
              Exit;
            end;
          aFixStr: SetValNameValue(PlayObject, sVar, PlayObject.m_DuelTargetCret.m_PEnvir.MapName, nValue);
          aDynamic: SetDynamicValue(PlayObject, sVar, PlayObject.m_DuelTargetCret.m_PEnvir.MapName, nValue);
        end;
      end else
        if PlayObject.m_PEnvir.m_boDuel and PlayObject.m_PEnvir.m_boDueling then begin
        VarInfo := GetVarValue(PlayObject, QuestConditionInfo.sParam1, sVar, sValue, nValue);
        case VarInfo.VarAttr of
          aNone, aConst: begin
              ScriptConditionError(PlayObject, QuestConditionInfo, sSC_GETDUELMAP);
              Exit;
            end;
          aFixStr: SetValNameValue(PlayObject, sVar, PlayObject.m_PEnvir.MapName, nValue);
          aDynamic: SetDynamicValue(PlayObject, sVar, PlayObject.m_PEnvir.MapName, nValue);
        end;
      end else begin
        Envir := g_MapManager.GetDuelMap;
        if Envir <> nil then begin
          VarInfo := GetVarValue(PlayObject, QuestConditionInfo.sParam1, sVar, sValue, nValue);
          case VarInfo.VarAttr of
            aNone, aConst: begin
                ScriptConditionError(PlayObject, QuestConditionInfo, sSC_GETDUELMAP);
                Exit;
              end;
            aFixStr: Envir.m_boDueling := SetValNameValue(PlayObject, sVar, Envir.MapName, nValue);
            aDynamic: Envir.m_boDueling := SetDynamicValue(PlayObject, sVar, Envir.MapName, nValue);
          end;
        end;
      end;
    end;
  end;
  Result := True;
end;

function TNormNpc.ConditionOfCheckMapDuelMap(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  Envir: TEnvirnoment;
  sMapName: string;
begin
  Result := False;
  sMapName := QuestConditionInfo.sParam1;
  Envir := g_MapManager.FindMap(sMapName);
  if Envir = nil then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam1, sMapName);
    Envir := g_MapManager.FindMap(sMapName);
    if Envir = nil then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMAPDUELING);
      Exit;
    end;
  end;
  if Envir <> nil then
    Result := Envir.m_boDuel and Envir.m_boDueling;
end;

function TNormNpc.ConditionOfCheckInCurrRect(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLeft, nTop, nRight, nBottom: Integer;
  nX, nY, nRange: Integer;
  CurrRect: TRect;
begin
  Result := False;
  nX := Str_ToInt(QuestConditionInfo.sParam1, -1);
  nY := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nRange := Str_ToInt(QuestConditionInfo.sParam3, -1);

  if nX < 0 then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam1, nX);
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam1, nX);
    end;
  end;
  if nX < 0 then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKINCURRRECT);
    Exit;
  end;

  if nY < 0 then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nY);
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam2, nY);
    end;
  end;
  if nY < 0 then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKINCURRRECT);
    Exit;
  end;

  if nRange < 0 then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam3, nRange);
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam3, nRange);
    end;
  end;
  if nRange < 0 then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKINCURRRECT);
    Exit;
  end;

  nLeft := _MAX(nX - nRange, 0);
  nRight := _MIN(nX + nRange, BaseObject.m_PEnvir.m_nWidth);
  nTop := _MAX(nY - nRange, 0);
  nBottom := _MIN(nY + nRange, BaseObject.m_PEnvir.m_nHeight);

  CurrRect := Rect(nLeft, nTop, nRight, nBottom);
  Result := (BaseObject.m_nCurrX >= CurrRect.Left) and (BaseObject.m_nCurrY >= CurrRect.Top) and (BaseObject.m_nCurrX <= CurrRect.Right) and (BaseObject.m_nCurrY <= CurrRect.Bottom);
end;

function TNormNpc.ConditionOfCheckGuildMember(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sCharName: string;
  Guild: TGUild;
begin
  Result := False;
  if PlayObject.m_MyGuild <> nil then begin
    sCharName := QuestConditionInfo.sParam1;
    sCharName := GetLineVariableText(PlayObject, sCharName);
    GetVarValue(PlayObject, sCharName, sCharName);

    GUild := TGUild(PlayObject.m_MyGuild);
    Result := GUild.IsMember(sCharName);
  end;
end;

function TNormNpc.ConditionOfCheckHumDuelMap(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := PlayObject.m_boStartDuel;
end;

function TNormNpc.ConditionOfIndexOf(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  LoadList: TStringList;
  nPostion: Integer;
  sLine: string;
  cMethod: Char;

  sVar, sValue: string;
  nValue: Integer;
  VarInfo: TVarInfo;
begin
  Result := False;
  nPostion := -1;
  GetVarValue(PlayObject, QuestConditionInfo.sParam2, sValue);

  LoadList := TStringList.Create;
  try
    if FileExists(g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1) then begin
      LoadList.LoadFromFile(g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1);
      nPostion := LoadList.IndexOf(sValue);
      Result := nPostion >= 0;
    end else begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_INDEXOF);
    end;
  finally
    LoadList.Free
  end;

  if (QuestConditionInfo.sParam3 <> '') then begin
    VarInfo := GetVarValue(PlayObject, QuestConditionInfo.sParam3, sVar, sValue, nValue);
    case VarInfo.VarAttr of
      aNone, aConst: ScriptConditionError(PlayObject, QuestConditionInfo, sSC_INDEXOF);
      aFixStr: SetValNameValue(PlayObject, sVar, sValue, nPostion);
      aDynamic: SetDynamicValue(PlayObject, sVar, sValue, nPostion);
    end;
  end else ScriptConditionError(PlayObject, QuestConditionInfo, sSC_INDEXOF);
end;

function TNormNpc.ConditionOfCheckMasked(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := BaseObject.m_boIsUnknowActor;
end;

function TNormNpc.GetVarValue(PlayObject: TPlayObject; sData: string; var nValue: Integer): TVarInfo;
var
  sVar, sValue: string;
begin
  Result := GetVarValue(PlayObject, sData, sVar, sValue, nValue);
end;

function TNormNpc.GetVarValue(PlayObject: TPlayObject; sData: string; var sValue: string): TVarInfo;
var
  sVar: string;
  nValue: Integer;
begin
  Result := GetVarValue(PlayObject, sData, sVar, sValue, nValue);
end;

function TNormNpc.GetVarValue(PlayObject: TPlayObject; sData: string; var sVar, sValue: string; var nValue: Integer): TVarInfo;
var
  n10: Integer;
  sName, sVarName: string;
begin
  sVar := sData;
  sValue := sData;
  //nValue := 0;

  Result.VarType := vNone;
  Result.VarAttr := aNone;

  if sData = '' then Exit;
  sVarName := sData;
  sName := sData;

  if (sData[1] = '<') and (sData[Length(sData)] = '>') then begin //<$STR(S0)>
    sData := ArrestStringEx(sData, '<', '>', sName);
  end;

  if CompareLStr(sName, '$STR(', Length('$STR(')) then begin //$STR(S0)
    sVar := '<' + sName + '>';
    //sData := ArrestStringEx(sName, '(', ')', sVarName);
    Result.VarType := GetValNameValue(PlayObject, sVar, sValue, nValue);
    Result.VarAttr := aFixStr;
  end else
    if CompareLStr(sName, '$HUMAN(', Length('$HUMAN(')) then begin
    sVar := '<' + sName + '>';
    //sData := ArrestStringEx(sName, '(', ')', sVarName);
    Result.VarType := GetDynamicValue(PlayObject, sVar, sValue, nValue);
    Result.VarAttr := aDynamic;
  end else
    if CompareLStr(sName, '$GUILD(', Length('$GUILD(')) then begin
    sVar := '<' + sName + '>';
    //sData := ArrestStringEx(sName, '(', ')', sVarName);
    Result.VarType := GetDynamicValue(PlayObject, sVar, sValue, nValue);
    Result.VarAttr := aDynamic;
  end else
    if CompareLStr(sName, '$GLOBAL(', Length('$GLOBAL(')) then begin
    sVar := '<' + sName + '>';
    //sData := ArrestStringEx(sName, '(', ')', sVarName);
    Result.VarType := GetDynamicValue(PlayObject, sVar, sValue, nValue);
    Result.VarAttr := aDynamic;
  end else
    if sName[1] = '$' then begin
    sName := Copy(sName, 2, Length(sName) - 1);
    n10 := GetValNameNo(sName);
    if n10 >= 0 then begin
      sVar := '<$STR(' + sName + ')>';
      Result.VarType := GetValNameValue(PlayObject, sVar, sValue, nValue);
      Result.VarAttr := aFixStr;
    end else begin
      sVar := '<$' + sName + '>';
      sValue := GetLineVariableText(PlayObject, sVar);
      if CompareText(sValue, sVar) = 0 then begin
        sValue := sVarName;
        nValue := Str_ToInt(sVarName, 0);
      end else begin
        Result.VarType := vString;
        nValue := Str_ToInt(sValue, 0);
        if IsNumber(sValue) then begin
          Result.VarType := vInteger;
        end;
      end;
      Result.VarAttr := aConst;
    end;
  end else begin
    n10 := GetValNameNo(sName);
    if n10 >= 0 then begin
      sVar := '<$STR(' + sName + ')>';
      Result.VarType := GetValNameValue(PlayObject, sVar, sValue, nValue);
      Result.VarAttr := aFixStr;
    end else begin
      Result.VarType := vString;
      nValue := Str_ToInt(sValue, 0);
      if IsNumber(sValue) then begin
        Result.VarType := vInteger;
      end;
      Result.VarAttr := aConst;
    end;
  end;
end;
 { end else begin
    Result.VarType := GetValNameValue(PlayObject, sName, sValue, nValue);
    if Result.VarType <> vNone then begin
      sVar := '<$STR(' + sName + ')>';
      Result.VarAttr := aFixStr;
    end else begin
      Result.VarType := vString;
      nValue := Str_ToInt(sValue, 0);
      if IsNumber(sValue) then begin
        Result.VarType := vInteger;
      end;
      Result.VarAttr := aConst;
    end;
  end;
end; }

function TNormNpc.GetDynamicValue(PlayObject: TPlayObject; sVar: string;
  var sValue: string; var nValue: Integer): TVarType;
var
  I: Integer;
  DynamicVar: pTDynamicVar;
  DynamicVarList: TList;
  sVarName, sVarType, sData, sName: string;
begin
  Result := vNone;
  //sValue := '';
  //nValue := 0;
  sVarName := '';
  sVarType := '';
  sName := '';
  sData := sVar;
  if (sData[1] = '<') and (sData[Length(sData)] = '>') then begin
    sData := ArrestStringEx(sData, '<', '>', sName);
  end;
  if CompareLStr(sName, '$HUMAN(', Length('$HUMAN(')) then begin
    sData := ArrestStringEx(sName, '(', ')', sVarName);
    sVarType := 'HUMAN';
  end else
    if CompareLStr(sName, '$GUILD(', Length('$GUILD(')) then begin
    sData := ArrestStringEx(sName, '(', ')', sVarName);
    sVarType := 'GUILD';
  end else
    if CompareLStr(sName, '$GLOBAL(', Length('$GLOBAL(')) then begin
    sData := ArrestStringEx(sName, '(', ')', sVarName);
    sVarType := 'GLOBAL';
  end;
  if (sVarName = '') or (sVarType = '') then Exit;

  DynamicVarList := GetDynamicVarList(PlayObject, sVarType, sName);
  if DynamicVarList = nil then begin
    Exit;
  end;
  for I := 0 to DynamicVarList.Count - 1 do begin
    DynamicVar := DynamicVarList.Items[I];
    if CompareText(DynamicVar.sName, sVarName) = 0 then begin
      case DynamicVar.VarType of
        vInteger: begin
            nValue := DynamicVar.nInternet;
            sValue := IntToStr(nValue);
            Result := vInteger;
          end;
        vString: begin
            sValue := DynamicVar.sString;
            nValue := Str_ToInt(sValue, 0);
            Result := vString;
          end;
      end;

      Break;
    end;
  end;
end;

function TNormNpc.SetDynamicValue(PlayObject: TPlayObject; sVar: string;
  sValue: string; nValue: Integer): Boolean;
var
  I: Integer;
  DynamicVar: pTDynamicVar;
  DynamicVarList: TList;
  sVarName, sVarType, sData, sName: string;
begin
  Result := False;
  sVarName := '';
  sVarType := '';
  sName := '';
  sData := sVar;
  if (sData[1] = '<') and (sData[Length(sData)] = '>') then begin
    sData := ArrestStringEx(sData, '<', '>', sName);
  end;
  if CompareLStr(sName, '$HUMAN(', Length('$HUMAN(')) then begin
    sData := ArrestStringEx(sName, '(', ')', sVarName);
    sVarType := 'HUMAN';
  end else
    if CompareLStr(sName, '$GUILD(', Length('$GUILD(')) then begin
    sData := ArrestStringEx(sName, '(', ')', sVarName);
    sVarType := 'GUILD';
  end else
    if CompareLStr(sName, '$GLOBAL(', Length('$GLOBAL(')) then begin
    sData := ArrestStringEx(sName, '(', ')', sVarName);
    sVarType := 'GLOBAL';
  end;
  if (sVarName = '') or (sVarType = '') then Exit;

  DynamicVarList := GetDynamicVarList(PlayObject, sVarType, sName);
  if DynamicVarList = nil then begin
    Exit;
  end;
  for I := 0 to DynamicVarList.Count - 1 do begin
    DynamicVar := DynamicVarList.Items[I];
    if CompareText(DynamicVar.sName, sVarName) = 0 then begin
      case DynamicVar.VarType of
        vInteger: begin
            DynamicVar.nInternet := nValue;
          end;
        vString: begin
            DynamicVar.sString := sValue;
          end;
      end;
      Result := True;
      Break;
    end;
  end;
end;

function TNormNpc.SetValNameValue(PlayObject: TPlayObject; sVar: string;
  sValue: string; nValue: Integer): Boolean;
var
  n01: Integer;
  sData, sName: string;
begin
  Result := False;
  if sVar = '' then Exit;

  sData := sVar;
  if (sData[1] = '<') and (sData[Length(sData)] = '>') then begin //<$STR(S0)>
    sData := ArrestStringEx(sData, '<', '>', sName);
  end;

  if CompareLStr(sName, '$STR(', Length('$STR(')) then begin //$STR(S0)
    sData := ArrestStringEx(sName, '(', ')', sName);
  end;

  if (sName[1] = '$') then begin //$S0
    sName := Copy(sName, 2, Length(sName) - 1);
  end;

  n01 := GetValNameNo(sName);
  if n01 >= 0 then begin
    case n01 of
      0..499: begin
          g_Config.GlobalVal[n01] := nValue; //G
          Result := True;
        end;
      1000..1099: begin
          g_Config.GlobaDyMval[n01 - 1000] := nValue; //I
          Result := True;
        end;
      1100..1109: begin
          PlayObject.m_nVal[n01 - 1100] := nValue; //P
          Result := True;
        end;
      1110..1119: begin
          PlayObject.m_DyVal[n01 - 1110] := nValue; //D
          Result := True;
        end;
      1200..1299: begin
          PlayObject.m_nMval[n01 - 1200] := nValue; //M
          Result := True;
        end;
      1300..1399: begin
          PlayObject.m_nInteger[n01 - 1300] := nValue; //N
          Result := True;
        end;
      2000..2499: begin
          g_Config.GlobalAVal[n01 - 2000] := sValue; //A
          Result := True;
        end;
      1400..1499: begin
          PlayObject.m_sString[n01 - 1400] := sValue; //S
          Result := True;
        end;
    end;
  end else
    if (sName <> '') and (UpCase(sName[1]) = 'S') then begin
    n01 := PlayObject.m_StringList.GetIndex(UpperCase(sName));
    if n01 >= 0 then begin
      PlayObject.m_StringList.Strings[n01] := sValue;
      Result := True;
    end else begin
      PlayObject.m_StringList.AddRecord(UpperCase(sName), sValue);
      Result := True;
    end;
  end else
    if (sName <> '') and (UpCase(sName[1]) = 'N') then begin
    n01 := PlayObject.m_IntegerList.GetIndex(UpperCase(sName));
    if n01 >= 0 then begin
      PlayObject.m_IntegerList.Objects[n01] := TObject(nValue);
      Result := True;
    end else begin
      PlayObject.m_IntegerList.AddRecord(UpperCase(sName), nValue);
      Result := True;
    end;
  end;
end;

function TNormNpc.GetValNameValue(PlayObject: TPlayObject; sVar: string;
  var sValue: string; var nValue: Integer): TVarType;
var
  n01: Integer;
  sData, sName: string;
begin
  Result := vNone;
  //sValue := '';
  //nValue := 0;

  if sVar = '' then Exit;
  sData := sVar;
  if (sData[1] = '<') and (sData[Length(sData)] = '>') then begin //<$STR(S0)>
    sData := ArrestStringEx(sData, '<', '>', sName);
  end;

  if CompareLStr(sName, '$STR(', Length('$STR(')) then begin //$STR(S0)
    sData := ArrestStringEx(sName, '(', ')', sName);
  end;

  if (sName[1] = '$') then begin //$S0
    sName := Copy(sName, 2, Length(sName) - 1);
  end;

  n01 := GetValNameNo(sName);
  if n01 >= 0 then begin
    case n01 of
      0..499: begin
          nValue := g_Config.GlobalVal[n01]; //G
          sValue := IntToStr(nValue);
          Result := vInteger;
        end;
      1000..1099: begin
          nValue := g_Config.GlobaDyMval[n01 - 1000]; //I
          sValue := IntToStr(nValue);
          Result := vInteger;
        end;
      1100..1109: begin
          nValue := PlayObject.m_nVal[n01 - 1100]; //P
          sValue := IntToStr(nValue);
          Result := vInteger;
        end;
      1110..1119: begin
          nValue := PlayObject.m_DyVal[n01 - 1110]; //D
          sValue := IntToStr(nValue);
          Result := vInteger;
        end;
      1200..1299: begin
          nValue := PlayObject.m_nMval[n01 - 1200]; //M
          sValue := IntToStr(nValue);
          Result := vInteger;
        end;
      1300..1399: begin
          nValue := PlayObject.m_nInteger[n01 - 1300]; //N
          sValue := IntToStr(nValue);
          Result := vInteger;
        end;
      2000..2499: begin
          sValue := g_Config.GlobalAVal[n01 - 2000]; //A
          nValue := Str_ToInt(sValue, 0);
          Result := vString;
        end;
      1400..1499: begin
          sValue := PlayObject.m_sString[n01 - 1400]; //S
          nValue := Str_ToInt(sValue, 0);
          Result := vString;
        end;
    end;
  end else
    if (sName <> '') and (UpCase(sName[1]) = 'S') then begin
    n01 := PlayObject.m_StringList.GetIndex(UpperCase(sName));
    if n01 >= 0 then begin
      sValue := PlayObject.m_StringList.Strings[n01];
    end else begin
     // PlayObject.m_StringList.AddRecord(sName, '');
      sValue := '';
    end;
    Result := vString;
  end else
    if (sName <> '') and (UpCase(sName[1]) = 'N') then begin
    n01 := PlayObject.m_IntegerList.GetIndex(UpperCase(sName));
    if n01 >= 0 then begin
      nValue := Integer(PlayObject.m_IntegerList.Objects[n01]);
    end else begin
      nValue := 0;
      //PlayObject.m_IntegerList.AddRecord(sName, nValue);
    end;
    Result := vInteger;
  end;
end;

procedure TNormNpc.ActionOfAnsiReplaceText(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sVar1, sVar2, sVar3: string;
  nValue1, nValue2, nValue3: Integer;
  sValue1, sValue2, sValue3: string;
  VarInfo1, VarInfo2, VarInfo3: TVarInfo;
begin
  sValue1 := QuestActionInfo.sParam1;
  sValue2 := QuestActionInfo.sParam2;
  sValue3 := QuestActionInfo.sParam3;
  if (sValue1 = '') or (sValue2 = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ANSIREPLACETEXT);
    Exit;
  end;

  sValue2 := GetLineVariableText(PlayObject, sValue2);
  sValue3 := GetLineVariableText(PlayObject, sValue3);

  VarInfo1 := GetVarValue(PlayObject, sValue1, sVar1, sValue1, nValue1);
  VarInfo2 := GetVarValue(PlayObject, sValue2, sVar2, sValue2, nValue2);
  VarInfo3 := GetVarValue(PlayObject, sValue3, sVar3, sValue3, nValue3);

  if AnsiContainsText(sValue1, sValue2) then begin
    case VarInfo1.VarAttr of
      aNone, aConst: ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ANSIREPLACETEXT);
      aFixStr: SetValNameValue(PlayObject, sVar1, AnsiReplaceText(sValue1, sValue2, sValue3), nValue1);
      aDynamic: SetDynamicValue(PlayObject, sVar1, AnsiReplaceText(sValue1, sValue2, sValue3), nValue1);
    end;
  end;
end;

procedure TNormNpc.ActionOfEncodeText(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sNewValue: string;
  sVar1, sVar2, sVar3, sVar4, sVar5, sVar6, sVar7, sVar8, sVar9, sVar10: string;
  nValue1, nValue2, nValue3, nValue4, nValue5, nValue6, nValue7, nValue8, nValue9, nValue10: Integer;
  sValue1, sValue2, sValue3, sValue4, sValue5, sValue6, sValue7, sValue8, sValue9, sValue10: string;
  VarInfo1, VarInfo2, VarInfo3, VarInfo4, VarInfo5, VarInfo6, VarInfo7, VarInfo8, VarInfo9, VarInfo10: TVarInfo;
begin
  sValue1 := QuestActionInfo.sParam1;

  sValue2 := GetLineVariableText(PlayObject, QuestActionInfo.sParam2);
  sValue3 := GetLineVariableText(PlayObject, QuestActionInfo.sParam3);
  sValue4 := GetLineVariableText(PlayObject, QuestActionInfo.sParam4);
  sValue5 := GetLineVariableText(PlayObject, QuestActionInfo.sParam5);
  sValue6 := GetLineVariableText(PlayObject, QuestActionInfo.sParam6);
  sValue7 := GetLineVariableText(PlayObject, QuestActionInfo.sParam7);
  sValue8 := GetLineVariableText(PlayObject, QuestActionInfo.sParam8);
  sValue9 := GetLineVariableText(PlayObject, QuestActionInfo.sParam9);
  sValue10 := GetLineVariableText(PlayObject, QuestActionInfo.sParam10);

  VarInfo1 := GetVarValue(PlayObject, sValue1, sVar1, sValue1, nValue1);
  VarInfo2 := GetVarValue(PlayObject, sValue2, sVar2, sValue2, nValue2);
  VarInfo3 := GetVarValue(PlayObject, sValue3, sVar3, sValue3, nValue3);
  VarInfo4 := GetVarValue(PlayObject, sValue4, sVar4, sValue4, nValue4);
  VarInfo5 := GetVarValue(PlayObject, sValue5, sVar5, sValue5, nValue5);
  VarInfo6 := GetVarValue(PlayObject, sValue6, sVar6, sValue6, nValue6);
  VarInfo7 := GetVarValue(PlayObject, sValue7, sVar7, sValue7, nValue7);
  VarInfo8 := GetVarValue(PlayObject, sValue8, sVar8, sValue8, nValue8);
  VarInfo9 := GetVarValue(PlayObject, sValue9, sVar9, sValue9, nValue9);
  VarInfo10 := GetVarValue(PlayObject, sValue10, sVar10, sValue10, nValue10);

  sNewValue := sValue2 + sValue3 + sValue4 + sValue5 + sValue6 + sValue7 + sValue8 + sValue9 + sValue10;

  case VarInfo1.VarAttr of
    aNone, aConst: ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ENCODETEXT);
    aFixStr: SetValNameValue(PlayObject, sVar1, sNewValue, nValue1);
    aDynamic: SetDynamicValue(PlayObject, sVar1, sNewValue, nValue1);
  end;
end;

procedure TNormNpc.ActionOfDecodeText(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin

end;

procedure TNormNpc.ActionOfTakeOnItem(ActorObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  nItemIdx: Integer;
  StdItem: pTStdItem;
  sItemName, sUserItemName: string;
  nWhere: Integer;
  UserItem: pTUserItem;
begin
  sItemName := QuestActionInfo.sParam1;
  nWhere := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (sItemName = '') or (not (nWhere in [Low(THumanUseItems)..High(THumanUseItems)])) then begin
    ScriptActionError(ActorObject, '', QuestActionInfo, sSC_TAKEONITEM);
    Exit;
  end;
  for I := 0 to ActorObject.m_ItemList.Count - 1 do begin
    UserItem := ActorObject.m_ItemList.Items[I];
    if UserItem.wIndex > 0 then begin
      sUserItemName := '';
      if UserItem.btValue[13] = 1 then
        sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
      if sUserItemName = '' then
        sUserItemName := UserEngine.GetStdItemName(UserItem.wIndex);

      if ActorObject.m_btRaceServer = RC_PLAYOBJECT then begin

        if TPlayObject(ActorObject).CheckItemBindUse(UserItem, False) = 2 then begin
          sUserItemName := '(绑)' + sUserItemName;
        end;
      end else
        if ActorObject.m_btRaceServer = RC_HEROOBJECT then begin
        if TPlayObject(ActorObject.m_Master).CheckItemBindUse(UserItem, False) = 2 then begin
          sUserItemName := '(绑)' + sUserItemName;
        end;
      end;

      if CompareText(sUserItemName, sItemName) = 0 then begin
        nItemIdx := UserItem.MakeIndex;
        if ActorObject.m_btRaceServer = RC_PLAYOBJECT then begin
          if ActorObject.m_boAI then begin
            TPlayObject(ActorObject).ClientTakeOnItems(nWhere, nItemIdx, sItemName);
          end else begin
            TPlayObject(ActorObject).ClientTakeOnItemsEx(nWhere, nItemIdx, sItemName);
          end;
        end else
          if ActorObject.m_btRaceServer = RC_HEROOBJECT then begin
          if ActorObject.m_boAI then begin
            THeroObject(ActorObject).ClientTakeOnItems(nWhere, nItemIdx, sItemName);
          end else begin
            THeroObject(ActorObject).ClientTakeOnItemsEx(nWhere, nItemIdx, sItemName);
          end;
        end;
        break;
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfTakeOffItem(ActorObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
var
  nItemIdx: Integer;
  StdItem: pTStdItem;
  sItemName, sUserItemName: string;
  nWhere: Integer;
begin
  sItemName := QuestActionInfo.sParam1;
  nWhere := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (sItemName = '') or (not (nWhere in [Low(THumanUseItems)..High(THumanUseItems)])) then begin
    ScriptActionError(ActorObject, '', QuestActionInfo, sSC_TAKEOFFITEM);
    Exit;
  end;
  if ActorObject.m_UseItems[nWhere].wIndex > 0 then begin
    sUserItemName := '';
    if ActorObject.m_UseItems[nWhere].btValue[13] = 1 then
      sUserItemName := ItemUnit.GetCustomItemName(ActorObject.m_UseItems[nWhere].MakeIndex, ActorObject.m_UseItems[nWhere].wIndex);
    if sUserItemName = '' then
      sUserItemName := UserEngine.GetStdItemName(ActorObject.m_UseItems[nWhere].wIndex);

    if ActorObject.m_btRaceServer = RC_PLAYOBJECT then begin

      if TPlayObject(ActorObject).CheckItemBindUse(@(ActorObject.m_UseItems[nWhere]), False) = 2 then begin
        sUserItemName := '(绑)' + sUserItemName;
      end;
    end else
      if ActorObject.m_btRaceServer = RC_HEROOBJECT then begin
      if TPlayObject(ActorObject.m_Master).CheckItemBindUse(@(ActorObject.m_UseItems[nWhere]), False) = 2 then begin
        sUserItemName := '(绑)' + sUserItemName;
      end;
    end;

    if CompareText(sUserItemName, sItemName) = 0 then begin
      nItemIdx := ActorObject.m_UseItems[nWhere].MakeIndex;
      if ActorObject.m_btRaceServer = RC_PLAYOBJECT then begin
        if ActorObject.m_boAI then begin
          TPlayObject(ActorObject).ClientTakeOffItems(nWhere, nItemIdx, sItemName);
        end else begin
          TPlayObject(ActorObject).ClientTakeOffItemsEx(nWhere, nItemIdx, sItemName);
        end;
      end else
        if ActorObject.m_btRaceServer = RC_HEROOBJECT then begin
        if ActorObject.m_boAI then begin
          THeroObject(ActorObject).ClientTakeOffItems(nWhere, nItemIdx, sItemName);
        end else begin
          THeroObject(ActorObject).ClientTakeOffItemsEx(nWhere, nItemIdx, sItemName);
        end;
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfCreateHero(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nJob: Integer;
  nSex: Integer;
  nHair: Integer;
  sMsg, sHair, sJob, sSex, sLevel: string;
begin
  nJob := Str_ToInt(QuestActionInfo.sParam1, -1);
  nSex := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (not (nJob in [0..2])) or (not (nSex in [0..1])) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CREATEHERO);
    Exit;
  end;

  if PlayObject.m_boWaitHeroDate then begin
    GotoLable(PlayObject, '@CreateingHero', False);
    Exit;
  end;

  if (PlayObject.m_sHeroCharName = '') then begin
    if (PlayObject.m_sTempHeroName <> '') then begin
      case nSex of
        0: nHair := 2;
        1: begin
            case Random(1) of
              0: nHair := 1;
              1: nHair := 3;
            end;
          end;
      end;
      sHair := IntToStr(nHair);
      sJob := IntToStr(nJob);
      sSex := IntToStr(nSex);
      sMsg := '/' + sHair + '/' + sJob + '/' + sSex;
      FrontEngine.AddToLoadHeroRcdList(PlayObject, Self, l_Create, sMsg);
    end else begin
      GotoLable(PlayObject, '@SetHeroName', False);
    end;
  end else begin
    GotoLable(PlayObject, '@HaveHero', False);
  end;
end;

procedure TNormNpc.ActionOfDeleteHero(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  if PlayObject.m_boWaitHeroDate then begin
    //GotoLable(PlayObject, '@CreateingHero', False);
    Exit;
  end;

  if (PlayObject.m_sHeroCharName <> '') then begin
    if (PlayObject.m_MyHero <> nil) then begin
      GotoLable(PlayObject, '@LogOutHeroFirst', False);
    end else begin
      FrontEngine.AddToLoadHeroRcdList(PlayObject, Self, l_Delete);
    end;
  end else begin
    GotoLable(PlayObject, '@NotHaveHero', False);
  end;
end;

procedure TNormNpc.ActionOfRepairItem(BaseObject: TActorObject; QuestActionInfo: pTQuestActionInfo);
var
  nWhere: Integer;
  StdItem: pTStdItem;
  sCheckItemName: string;
begin
  if Str_ToInt(QuestActionInfo.sParam1, -1) >= 0 then begin
    nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
    if (nWhere in [Low(THumanUseItems)..High(THumanUseItems)]) then begin
      if BaseObject.m_UseItems[nWhere].wIndex > 0 then begin
        StdItem := UserEngine.GetStdItem(BaseObject.m_UseItems[nWhere].wIndex);
        if StdItem <> nil then begin
          if (BaseObject.m_UseItems[nWhere].DuraMax > BaseObject.m_UseItems[nWhere].Dura) and (StdItem.StdMode <> 43) then begin
            if Assigned(PlugInEngine.CheckCanRepairItem) then begin
              sCheckItemName := StdItem.Name;
              if not PlugInEngine.CheckCanRepairItem(BaseObject, PChar(sCheckItemName), False) then Exit;
            end;
            BaseObject.m_UseItems[nWhere].Dura := BaseObject.m_UseItems[nWhere].DuraMax;
            BaseObject.SendMsg(BaseObject, RM_DURACHANGE, nWhere, BaseObject.m_UseItems[nWhere].Dura, BaseObject.m_UseItems[nWhere].DuraMax, 0, '');
          end;
        end;
      end;
    end else begin
      ScriptActionError(BaseObject, '', QuestActionInfo, sSC_REPAIRITEM);
    end;
  end else
    if Str_ToInt(QuestActionInfo.sParam1, -1) < 0 then begin
    for nWhere := Low(THumanUseItems) to High(THumanUseItems) do begin
      if BaseObject.m_UseItems[nWhere].wIndex > 0 then begin
        StdItem := UserEngine.GetStdItem(BaseObject.m_UseItems[nWhere].wIndex);
        if StdItem <> nil then begin
          if (BaseObject.m_UseItems[nWhere].DuraMax > BaseObject.m_UseItems[nWhere].Dura) and (StdItem.StdMode <> 43) then begin
            if Assigned(PlugInEngine.CheckCanRepairItem) then begin
              sCheckItemName := StdItem.Name;
              if not PlugInEngine.CheckCanRepairItem(BaseObject, PChar(sCheckItemName), False) then Continue;
            end;
            BaseObject.m_UseItems[nWhere].Dura := BaseObject.m_UseItems[nWhere].DuraMax;
            BaseObject.SendMsg(BaseObject, RM_DURACHANGE, nWhere, BaseObject.m_UseItems[nWhere].Dura, BaseObject.m_UseItems[nWhere].DuraMax, 0, '');
          end;
        end;
      end;
    end;
  end else begin
    //ScriptActionError(PlayObject, '', QuestActionInfo, sSC_REPAIRITEM);
  end;
end;

constructor TNormNpc.Create;
begin
  inherited;
  m_boSuperMan := True;
  m_btRaceServer := RC_NPC;
  m_nLight := 2;
  m_btAntiPoison := 99;
  m_ScriptList := TList.Create;
  m_boStickMode := True;
  m_sFilePath := '';
  m_boIsHide := False;
  m_boIsQuest := True;
  m_boNpcAutoChangeColor := False;
  m_dwNpcAutoChangeColorTick := GetTickCount;
  m_dwNpcAutoChangeColorTime := 0;
  m_nNpcAutoChangeIdx := 0;
  m_nNpcMagicIdx := 0;
  m_nVarIdx := -1;
  m_UnAllowLableList := TStringList.Create;
end;

destructor TNormNpc.Destroy;
begin
  ClearScript();
  m_ScriptList.Free;
  m_UnAllowLableList.Free;
  inherited;
end;

procedure TNormNpc.ExeAction(BaseObject: TActorObject; sParam1, sParam2,
  sParam3: string; nParam1, nParam2, nParam3: Integer);
var
  nInt1, nInt2, nInt3: Integer;
  dwInt: LongWord;
  nMaxLevel: Integer;
  //BaseObject: TActorObject;
begin
  //================================================
  //更改人物当前经验值
  //EXEACTION CHANGEEXP 0 经验数  设置为指定经验值
  //EXEACTION CHANGEEXP 1 经验数  增加指定经验
  //EXEACTION CHANGEEXP 2 经验数  减少指定经验
  //================================================
  if CompareText(sParam1, 'CHANGEEXP') = 0 then begin
    nInt1 := Str_ToInt(sParam2, -1);
    case nInt1 of //
      0: begin
          if nParam3 >= 0 then begin
           { BaseObject.m_Abil.Exp := LongWord(nParam3);
            BaseObject.HasLevelUp(BaseObject.m_Abil.Level - 1);
            }
            dwInt := LongWord(nParam3);
            if (dwInt > BaseObject.m_Abil.Exp) then begin
              BaseObject.GetExp(dwInt - BaseObject.m_Abil.Exp);
            end else begin
              BaseObject.m_Abil.Exp := dwInt;
              BaseObject.HasLevelUp(BaseObject.m_Abil.Level - 1);
            end;
          end;
        end;
      1: begin
          BaseObject.GetExp(LongWord(nParam3));
          {if BaseObject.m_Abil.Exp >= LongWord(nParam3) then begin
            if (BaseObject.m_Abil.Exp - LongWord(nParam3)) > (High(LongWord) - BaseObject.m_Abil.Exp) then begin
              dwInt := High(LongWord) - BaseObject.m_Abil.Exp;
            end else begin
              dwInt := LongWord(nParam3);
            end;
          end else begin
            if (LongWord(nParam3) - BaseObject.m_Abil.Exp) > (High(LongWord) - LongWord(nParam3)) then begin
              dwInt := High(LongWord) - LongWord(nParam3);
            end else begin
              dwInt := LongWord(nParam3);
            end;
          end;
          Inc(BaseObject.m_Abil.Exp, dwInt);
          BaseObject.HasLevelUp(BaseObject.m_Abil.Level - 1); }
        end;
      2: begin
          if BaseObject.m_Abil.Exp > LongWord(nParam3) then begin
            Dec(BaseObject.m_Abil.Exp, LongWord(nParam3));
          end else begin
            BaseObject.m_Abil.Exp := 0;
          end;
          BaseObject.HasLevelUp(BaseObject.m_Abil.Level - 1);
        end;
    end;
    BaseObject.SysMsg('Your current Experience points are: ' + IntToStr(BaseObject.m_Abil.Exp) + '/' + IntToStr(BaseObject.m_Abil.MaxExp), c_Green, t_Hint);
    Exit;
  end;

  nMaxLevel := g_Config.nMaxLevel;

  //================================================
  //更改人物当前等级
  //EXEACTION CHANGELEVEL 0 等级数  设置为指定等级
  //EXEACTION CHANGELEVEL 1 等级数  增加指定等级
  //EXEACTION CHANGELEVEL 2 等级数  减少指定等级
  //================================================
  if CompareText(sParam1, 'CHANGELEVEL') = 0 then begin
    nInt1 := Str_ToInt(sParam2, -1);
    case nInt1 of //
      0: begin
          if nParam3 >= 0 then begin
            BaseObject.m_Abil.Level := LongWord(nParam3);
            BaseObject.HasLevelUp(BaseObject.m_Abil.Level - 1);
          end;
        end;
      1: begin
          if BaseObject.m_Abil.Level >= LongWord(nParam3) then begin
            if (BaseObject.m_Abil.Level - LongWord(nParam3)) > (nMaxLevel - BaseObject.m_Abil.Level) then begin
              dwInt := nMaxLevel - BaseObject.m_Abil.Level;
            end else begin
              dwInt := LongWord(nParam3);
            end;
          end else begin
            if (LongWord(nParam3) - BaseObject.m_Abil.Level) > (nMaxLevel - LongWord(nParam3)) then begin
              dwInt := High(LongWord) - LongWord(nParam3);
            end else begin
              dwInt := LongWord(nParam3);
            end;
          end;
          Inc(BaseObject.m_Abil.Level, dwInt);
          BaseObject.HasLevelUp(BaseObject.m_Abil.Level - 1);
        end;
      2: begin
          if BaseObject.m_Abil.Level > LongWord(nParam3) then begin
            Dec(BaseObject.m_Abil.Level, LongWord(nParam3));
          end else begin
            BaseObject.m_Abil.Level := 0;
          end;
          BaseObject.HasLevelUp(BaseObject.m_Abil.Level - 1);
        end;
    end;
    BaseObject.SysMsg('Your current level is: ' + IntToStr(BaseObject.m_Abil.Level), c_Green, t_Hint);
    Exit;
  end;

  //================================================
  //杀死人物
  //EXEACTION KILL 0 人物死亡,不显示凶手信息
  //EXEACTION KILL 1 人物死亡不掉物品,不显示凶手信息
  //EXEACTION KILL 2 人物死亡,显示凶手信息为NPC
  //EXEACTION KILL 3 人物死亡不掉物品,显示凶手信息为NPC
  //================================================
  if CompareText(sParam1, 'KILL') = 0 then begin
    nInt1 := Str_ToInt(sParam2, -1);
    case nInt1 of //
      1: begin
          BaseObject.m_boNoItem := True;
          BaseObject.Die;
        end;
      2: begin
          BaseObject.SetLastHiter(Self);
          BaseObject.Die;
        end;
      3: begin
          BaseObject.m_boNoItem := True;
          BaseObject.SetLastHiter(Self);
          BaseObject.Die;
        end;
    else begin
        BaseObject.Die;
      end;
    end;
    Exit;
  end;

  //================================================
  //踢人物下线
  //EXEACTION KICK
  //================================================
  if CompareText(sParam1, 'KICK') = 0 then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      TPlayObject(BaseObject).m_boKickFlag := True;
    end;
    Exit;
  end;
  //==============================================================================
end;

function TNormNpc.GetLineVariableText(PlayObject: TPlayObject;
  sMsg: string): string;
var
  nC: Integer;
  s10: string;
begin
  nC := 0;
  while (True) do begin
    if Pos('>', sMsg) <= 0 then Break; //if TagCount(sMsg, '>') < 1 then Break;
    ArrestStringEx(sMsg, '<', '>', s10);
    GetVariableText(PlayObject, sMsg, s10);
    Inc(nC);
    if nC >= 101 then Break;
  end;
  Result := sMsg;
end;

procedure TNormNpc.GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string);
var
  sText, s14: string;
  I, II: Integer;
  n18, n20: Integer;
  wHour: Word;
  wMinute: Word;
  wSecond: Word;
  nSecond: Integer;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;

  nSellGold: Integer;
  nRate: Integer;
  s1C: string;
  SellOffInfo: pTSellOffInfo;
  Merchant: TMerchant;
  List20: TSellList;
  PoseHuman: TPlayObject;

  RememberItem: pTRememberItem;
  Envir: TEnvirnoment;
begin
  if CompareLStr(sVariable, '$TAGMAPNAME', Length('$TAGMAPNAME')) then begin
    s1C := sVariable[Length(sVariable)]; //Copy(sVariable, Length(sVariable) - 1, 1);
    n18 := Str_ToInt(s1C, -1);
    //MainOutMessage(s1C);
    RememberItem := GetRememberItem(PlayObject.m_nRememberItemIndex, n18);
    if RememberItem <> nil then begin
      if RememberItem.sMapName <> '' then begin
        Envir := g_MapManager.FindMap(RememberItem.sMapName);
        if Envir <> nil then
          sText := Envir.sMapDesc
        else
          sText := '???';
      end else sText := '未记忆';
    end else sText := '未记忆';
    sMsg := sub_49ADB8(sMsg, '<$TAGMAPNAME' + IntToStr(n18) + '>', sText);
    Exit;
  end;

  if CompareLStr(sVariable, '$TAGX', Length('$TAGX')) then begin
    s1C := sVariable[Length(sVariable)]; //s1C := Copy(sVariable, Length(sVariable) - 1, 1);
    n18 := Str_ToInt(s1C, -1);

    RememberItem := GetRememberItem(PlayObject.m_nRememberItemIndex, n18);
    if RememberItem <> nil then begin
      if RememberItem.sMapName <> '' then begin
        sText := IntToStr(RememberItem.nCurrX);
      end else sText := '未记忆';
    end else sText := '未记忆';
    sMsg := sub_49ADB8(sMsg, '<$TAGX' + IntToStr(n18) + '>', sText);
    Exit;
  end;

  if CompareLStr(sVariable, '$TAGY', Length('$TAGY')) then begin
    s1C := sVariable[Length(sVariable)]; //s1C := Copy(sVariable, Length(sVariable) - 1, 1);
    n18 := Str_ToInt(s1C, -1);
    RememberItem := GetRememberItem(PlayObject.m_nRememberItemIndex, n18);
    if RememberItem <> nil then begin
      if RememberItem.sMapName <> '' then begin
        sText := IntToStr(RememberItem.nCurrX);
      end else sText := '未记忆';
    end else sText := '未记忆';
    sMsg := sub_49ADB8(sMsg, '<$TAGY' + IntToStr(n18) + '>', sText);
    Exit;
  end;


  if sVariable = '$TARGETNAME' then begin
    if PlayObject.m_TargetCret <> nil then begin
      sText := PlayObject.m_TargetCret.m_sCharName;
    end else sText := '';
    sMsg := sub_49ADB8(sMsg, '<$TARGETNAME>', sText);
    Exit;
  end;

  if sVariable = '$SCATTERITEMNAME' then begin //暴物品名称
    sText := PlayObject.m_sScatterItemName;
    sMsg := sub_49ADB8(sMsg, '<$SCATTERITEMNAME>', sText);
    Exit;
  end;
  if sVariable = '$SCATTERITEMOWNERNAME' then begin //暴物品拥有者名称
    sText := PlayObject.m_sScatterItemOwnerName;
    sMsg := sub_49ADB8(sMsg, '<$SCATTERITEMOWNERNAME>', sText);
    Exit;
  end;
  if sVariable = '$SCATTERITEMMAPNAME' then begin //暴物品所在地图文件名称
    sText := PlayObject.m_sScatterItemMapName;
    sMsg := sub_49ADB8(sMsg, '<$SCATTERITEMMAPNAME>', sText);
    Exit;
  end;
  if sVariable = '$SCATTERITEMMAPDESC' then begin //暴物品所在地图名称
    sText := PlayObject.m_sScatterItemMapDesc;
    sMsg := sub_49ADB8(sMsg, '<$SCATTERITEMMAPDESC>', sText);
    Exit;
  end;
  if sVariable = '$SCATTERITEMX' then begin //暴物品所在地图X坐标
    sText := IntToStr(PlayObject.m_nScatterItemX);
    sMsg := sub_49ADB8(sMsg, '<$SCATTERITEMX>', sText);
    Exit;
  end;
  if sVariable = '$SCATTERITEMY' then begin //暴物品所在地图X坐标
    sText := IntToStr(PlayObject.m_nScatterItemY);
    sMsg := sub_49ADB8(sMsg, '<$SCATTERITEMY>', sText);
    Exit;
  end;
  //显示人物排行
  {if sVariable = '$LEVELORDER' then begin
    s1C := '';
    for I := 0 to PlayObject.m_PlayOrderList.Count - 1 do begin
      s1C := s1C + PlayObject.m_PlayOrderList.Strings[I];
    end;
    sMsg := sub_49ADB8(sMsg, '<$LEVELORDER>', s1C);
    Exit;
  end; }

  //显示拍卖款
  if sVariable = '$SELLOUTGOLD' then begin
    s1C := '';
    n18 := 0;
    if (g_GoldList.GetGoldListByCharName(PlayObject.m_sCharName, List20) >= 0) then begin
      for I := 0 to List20.Count - 1 do begin
        SellOffInfo := pTSellOffInfo(List20.Objects[I]);
        if g_Config.nUserSellOffTax > 0 then begin
          nRate := SellOffInfo.nSellGold * g_Config.nUserSellOffTax div 100;
          nSellGold := SellOffInfo.nSellGold - nRate;
        end else begin
          nSellGold := SellOffInfo.nSellGold;
          nRate := 0;
        end;
        s1C := s1C + '<物品:' + UserEngine.GetStdItemName(SellOffInfo.UserItem.wIndex) + ' 金额:' + IntToStr(nSellGold) + ' 税:' + IntToStr(nRate) + g_Config.sGameGoldName + ' 拍卖日期:' + DateTimeToStr(SellOffInfo.dSellDateTime) + '>\';
        Inc(n18);
        if n18 >= 7 then Break;
      end;
      if s1C = '' then s1C := g_sSellOffGoldInfo;
    end else begin
      s1C := g_sSellOffGoldInfo;
    end;
    sMsg := sub_49ADB8(sMsg, '<$SELLOUTGOLD>', s1C);
    Exit;
  end;
  //显示拍卖物品
  if sVariable = '$SELLOFFITEM' then begin
    s1C := '';
    n18 := 0;
    if g_SellList.GetSellListByCharName(PlayObject.m_sCharName, List20) >= 0 then begin
      for I := 0 to List20.Count - 1 do begin
        SellOffInfo := pTSellOffInfo(List20.Objects[I]);
        s1C := s1C + '<物品:' + List20.Strings[I] + ' 金额:' + IntToStr(SellOffInfo.nSellGold) + g_Config.sGameGoldName + ' 拍卖日期:' + DateTimeToStr(SellOffInfo.dSellDateTime) + '>\';
        Inc(n18);
        if n18 >= 7 then Break;
      //n20:=n18 div 7;
      {if n20 >= 1 then begin
        n18:=0;
        s1C := s1C + '<下一页/@SELLOFFITEM'+IntToStr(n20)+'>\[@SELLOFFITEM'+IntToStr(n20)+']';
      end;}
      end;
      if s1C = '' then s1C := g_sSellOffItemInfo;
    end else begin
      s1C := g_sSellOffItemInfo;
    end;
    sMsg := sub_49ADB8(sMsg, '<$SELLOFFITEM>', s1C);
    Exit;
  end;
  if sVariable = '$DEALGOLDPLAY' then begin
    PoseHuman := TPlayObject(PlayObject.GetPoseCreate());
    if (PoseHuman <> nil) and (TPlayObject(PoseHuman.GetPoseCreate) = PlayObject) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
      sMsg := sub_49ADB8(sMsg, '<$DEALGOLDPLAY>', PoseHuman.m_sCharName);
    end else begin
      sMsg := sub_49ADB8(sMsg, '<$DEALGOLDPLAY>', '????');
    end;
    Exit;
  end;
  //全局信息
  if sVariable = '$SERVERNAME' then begin
    sMsg := sub_49ADB8(sMsg, '<$SERVERNAME>', g_Config.sServerName);
    Exit;
  end;
  if sVariable = '$SERVERIP' then begin
    sMsg := sub_49ADB8(sMsg, '<$SERVERIP>', g_Config.sServerIPaddr);
    Exit;
  end;
  if sVariable = '$WEBSITE' then begin
    sMsg := sub_49ADB8(sMsg, '<$WEBSITE>', g_Config.sWebSite);
    Exit;
  end;
  if sVariable = '$BBSSITE' then begin
    sMsg := sub_49ADB8(sMsg, '<$BBSSITE>', g_Config.sBbsSite);
    Exit;
  end;
  if sVariable = '$CLIENTDOWNLOAD' then begin
    sMsg := sub_49ADB8(sMsg, '<$CLIENTDOWNLOAD>', g_Config.sClientDownload);
    Exit;
  end;
  if sVariable = '$QQ' then begin
    sMsg := sub_49ADB8(sMsg, '<$QQ>', g_Config.sQQ);
    Exit;
  end;
  if sVariable = '$PHONE' then begin
    sMsg := sub_49ADB8(sMsg, '<$PHONE>', g_Config.sPhone);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT0' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT0>', g_Config.sBankAccount0);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT1' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT1>', g_Config.sBankAccount1);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT2' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT2>', g_Config.sBankAccount2);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT3' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT3>', g_Config.sBankAccount3);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT4' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT4>', g_Config.sBankAccount4);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT5' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT5>', g_Config.sBankAccount5);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT6' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT6>', g_Config.sBankAccount6);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT7' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT7>', g_Config.sBankAccount7);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT8' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT8>', g_Config.sBankAccount8);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT9' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT9>', g_Config.sBankAccount9);
    Exit;
  end;
  if sVariable = '$GAMEGOLDNAME' then begin
    sMsg := sub_49ADB8(sMsg, '<$GAMEGOLDNAME>', g_Config.sGameGoldName);
    Exit;
  end;
  if sVariable = '$GAMEPOINTNAME' then begin
    sMsg := sub_49ADB8(sMsg, '<$GAMEPOINTNAME>', g_Config.sGamePointName);
    Exit;
  end;
  if sVariable = '$USERCOUNT' then begin
    sText := IntToStr(UserEngine.PlayObjectCount);
    sMsg := sub_49ADB8(sMsg, '<$USERCOUNT>', sText);
    Exit;
  end;
  if sVariable = '$MACRUNTIME' then begin
    sText := CurrToStr(GetTickCount / (24 * 60 * 60 * 1000));
    sMsg := sub_49ADB8(sMsg, '<$MACRUNTIME>', sText);
    Exit;
  end;
  if sVariable = '$SERVERRUNTIME' then begin
    nSecond := (GetTickCount() - g_dwStartTick) div 1000;
    wHour := nSecond div 3600;
    wMinute := (nSecond div 60) mod 60;
    wSecond := nSecond mod 60;
    sText := Format('%d:%d:%d', [wHour, wMinute, wSecond]);
    sMsg := sub_49ADB8(sMsg, '<$SERVERRUNTIME>', sText);
    Exit;
  end;
  if sVariable = '$DATETIME' then begin
    //    sText:=DateTimeToStr(Now);
    sText := FormatDateTime('dddddd,dddd,hh:mm:nn', Now);
    sMsg := sub_49ADB8(sMsg, '<$DATETIME>', sText);
    Exit;
  end;

  if sVariable = '$HIGHLEVELINFO' then begin
    if UserEngine.GetPlayObject(TPlayObject(g_HighLevelHuman)) <> nil then begin
    //if TPlayObject(g_HighLevelHuman) <> nil then begin
      sText := TPlayObject(g_HighLevelHuman).GetMyInfo;
    end else sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHLEVELINFO>', sText);
    Exit;
  end;
  if sVariable = '$HIGHPKINFO' then begin
    if UserEngine.GetPlayObject(TPlayObject(g_HighPKPointHuman)) <> nil then begin
    //if TPlayObject(g_HighPKPointHuman) <> nil then begin
      sText := TPlayObject(g_HighPKPointHuman).GetMyInfo;
    end else sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHPKINFO>', sText);
    Exit;
  end;
  if sVariable = '$HIGHDCINFO' then begin
    if UserEngine.GetPlayObject(TPlayObject(g_HighDCHuman)) <> nil then begin
    //if TPlayObject(g_HighDCHuman) <> nil then begin
      sText := TPlayObject(g_HighDCHuman).GetMyInfo;
    end else sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHDCINFO>', sText);
    Exit;
  end;
  if sVariable = '$HIGHMCINFO' then begin
    if UserEngine.GetPlayObject(TPlayObject(g_HighMCHuman)) <> nil then begin
    //if TPlayObject(g_HighMCHuman) <> nil then begin
      sText := TPlayObject(g_HighMCHuman).GetMyInfo;
    end else sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHMCINFO>', sText);
    Exit;
  end;
  if sVariable = '$HIGHSCINFO' then begin
    if UserEngine.GetPlayObject(TPlayObject(g_HighSCHuman)) <> nil then begin
    //if TPlayObject(g_HighSCHuman) <> nil then begin
      sText := TPlayObject(g_HighSCHuman).GetMyInfo;
    end else sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHSCINFO>', sText);
    Exit;
  end;
  if sVariable = '$HIGHONLINEINFO' then begin
    if UserEngine.GetPlayObject(TPlayObject(g_HighOnlineHuman)) <> nil then begin
    //if TPlayObject(g_HighOnlineHuman) <> nil then begin
      sText := TPlayObject(g_HighOnlineHuman).GetMyInfo;
    end else sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHONLINEINFO>', sText);
    Exit;
  end;

  //个人信息
  if sVariable = '$BUTCHITEMNAME' then begin
    if PlayObject.m_sButchItem = '' then begin
      sMsg := '????';
    end else begin
      sMsg := sub_49ADB8(sMsg, '<$BUTCHITEMNAME>', PlayObject.m_sButchItem);
    end;
    Exit;
  end;

  if sVariable = '$BOXNAME' then begin
    if PlayObject.m_SuperItemBox = nil then begin
      sMsg := '????';
    end else begin
      sMsg := sub_49ADB8(sMsg, '<$BOXNAME>', PlayObject.m_SuperItemBox.sOpenBoxName);
    end;
    Exit;
  end;
  if sVariable = '$BOXITEMNAME' then begin
    if PlayObject.m_SuperItemBox = nil then begin
      sMsg := '????';
    end else begin
      sMsg := sub_49ADB8(sMsg, '<$BOXITEMNAME>', PlayObject.m_SuperItemBox.sItemName);
    end;
    Exit;
  end;
  if sVariable = '$USERNAME' then begin
    sMsg := sub_49ADB8(sMsg, '<$USERNAME>', PlayObject.m_sCharName);
    Exit;
  end;
  if sVariable = '$MAPNAME' then begin
    sMsg := sub_49ADB8(sMsg, '<$MAPNAME>', PlayObject.m_PEnvir.sMapDesc);
    Exit;
  end;
  if sVariable = '$MAPFILENAME' then begin
    sMsg := sub_49ADB8(sMsg, '<$MAPFILENAME>', PlayObject.m_PEnvir.MapName);
    Exit;
  end;
  if sVariable = '$GUILDNAME' then begin
    if PlayObject.m_MyGuild <> nil then begin
      sMsg := sub_49ADB8(sMsg, '<$GUILDNAME>', TGUild(PlayObject.m_MyGuild).sGuildName);
    end else begin
      sMsg := '无';
    end;
    Exit;
  end;
  if sVariable = '$RANKNAME' then begin
    sMsg := sub_49ADB8(sMsg, '<$RANKNAME>', PlayObject.m_sGuildRankName);
    Exit;
  end;

  if sVariable = '$CURRX' then begin
    sText := IntToStr(PlayObject.m_nCurrX);
    sMsg := sub_49ADB8(sMsg, '<$CURRX>', sText);
    Exit;
  end;

  if sVariable = '$CURRY' then begin
    sText := IntToStr(PlayObject.m_nCurrY);
    sMsg := sub_49ADB8(sMsg, '<$CURRY>', sText);
    Exit;
  end;

  if sVariable = '$LEVEL' then begin
    sText := IntToStr(PlayObject.m_Abil.Level);
    sMsg := sub_49ADB8(sMsg, '<$LEVEL>', sText);
    Exit;
  end;

  if sVariable = '$HP' then begin
    sText := IntToStr(PlayObject.m_WAbil.HP);
    sMsg := sub_49ADB8(sMsg, '<$HP>', sText);
    Exit;
  end;
  if sVariable = '$MAXHP' then begin
    sText := IntToStr(PlayObject.m_WAbil.MaxHP);
    sMsg := sub_49ADB8(sMsg, '<$MAXHP>', sText);
    Exit;
  end;

  if sVariable = '$MP' then begin
    sText := IntToStr(PlayObject.m_WAbil.MP);
    sMsg := sub_49ADB8(sMsg, '<$MP>', sText);
    Exit;
  end;
  if sVariable = '$MAXMP' then begin
    sText := IntToStr(PlayObject.m_WAbil.MaxMP);
    sMsg := sub_49ADB8(sMsg, '<$MAXMP>', sText);
    Exit;
  end;

  if sVariable = '$AC' then begin
    sText := IntToStr(LoWord(PlayObject.m_WAbil.AC));
    sMsg := sub_49ADB8(sMsg, '<$AC>', sText);
    Exit;
  end;
  if sVariable = '$MAXAC' then begin
    sText := IntToStr(HiWord(PlayObject.m_WAbil.AC));
    sMsg := sub_49ADB8(sMsg, '<$MAXAC>', sText);
    Exit;
  end;
  if sVariable = '$MAC' then begin
    sText := IntToStr(LoWord(PlayObject.m_WAbil.MAC));
    sMsg := sub_49ADB8(sMsg, '<$MAC>', sText);
    Exit;
  end;
  if sVariable = '$MAXMAC' then begin
    sText := IntToStr(HiWord(PlayObject.m_WAbil.MAC));
    sMsg := sub_49ADB8(sMsg, '<$MAXMAC>', sText);
    Exit;
  end;

  if sVariable = '$DC' then begin
    sText := IntToStr(LoWord(PlayObject.m_WAbil.DC));
    sMsg := sub_49ADB8(sMsg, '<$DC>', sText);
    Exit;
  end;
  if sVariable = '$MAXDC' then begin
    sText := IntToStr(HiWord(PlayObject.m_WAbil.DC));
    sMsg := sub_49ADB8(sMsg, '<$MAXDC>', sText);
    Exit;
  end;

  if sVariable = '$MC' then begin
    sText := IntToStr(LoWord(PlayObject.m_WAbil.MC));
    sMsg := sub_49ADB8(sMsg, '<$MC>', sText);
    Exit;
  end;
  if sVariable = '$MAXMC' then begin
    sText := IntToStr(HiWord(PlayObject.m_WAbil.MC));
    sMsg := sub_49ADB8(sMsg, '<$MAXMC>', sText);
    Exit;
  end;

  if sVariable = '$SC' then begin
    sText := IntToStr(LoWord(PlayObject.m_WAbil.SC));
    sMsg := sub_49ADB8(sMsg, '<$SC>', sText);
    Exit;
  end;
  if sVariable = '$MAXSC' then begin
    sText := IntToStr(HiWord(PlayObject.m_WAbil.SC));
    sMsg := sub_49ADB8(sMsg, '<$MAXSC>', sText);
    Exit;
  end;

  if sVariable = '$EXP' then begin
    sText := IntToStr(PlayObject.m_Abil.Exp);
    sMsg := sub_49ADB8(sMsg, '<$EXP>', sText);
    Exit;
  end;
  if sVariable = '$MAXEXP' then begin
    sText := IntToStr(PlayObject.m_Abil.MaxExp);
    sMsg := sub_49ADB8(sMsg, '<$MAXEXP>', sText);
    Exit;
  end;

  if sVariable = '$PKPOINT' then begin
    sText := IntToStr(PlayObject.m_nPkPoint);
    sMsg := sub_49ADB8(sMsg, '<$PKPOINT>', sText);
    Exit;
  end;
  if sVariable = '$CREDITPOINT' then begin
    sText := IntToStr(PlayObject.m_btCreditPoint);
    sMsg := sub_49ADB8(sMsg, '<$CREDITPOINT>', sText);
    Exit;
  end;

  if sVariable = '$HW' then begin
    sText := IntToStr(PlayObject.m_WAbil.HandWeight);
    sMsg := sub_49ADB8(sMsg, '<$HW>', sText);
    Exit;
  end;
  if sVariable = '$MAXHW' then begin
    sText := IntToStr(PlayObject.m_WAbil.MaxHandWeight);
    sMsg := sub_49ADB8(sMsg, '<$MAXHW>', sText);
    Exit;
  end;

  if sVariable = '$BW' then begin
    sText := IntToStr(PlayObject.m_WAbil.Weight);
    sMsg := sub_49ADB8(sMsg, '<$BW>', sText);
    Exit;
  end;
  if sVariable = '$MAXBW' then begin
    sText := IntToStr(PlayObject.m_WAbil.MaxWeight);
    sMsg := sub_49ADB8(sMsg, '<$MAXBW>', sText);
    Exit;
  end;

  if sVariable = '$WW' then begin
    sText := IntToStr(PlayObject.m_WAbil.WearWeight);
    sMsg := sub_49ADB8(sMsg, '<$WW>', sText);
    Exit;
  end;
  if sVariable = '$MAXWW' then begin
    sText := IntToStr(PlayObject.m_WAbil.MaxWearWeight);
    sMsg := sub_49ADB8(sMsg, '<$MAXWW>', sText);
    Exit;
  end;

  if sVariable = '$GOLDCOUNT' then begin
    sText := IntToStr(PlayObject.m_nGold) + '/' + IntToStr(PlayObject.m_nGoldMax);
    sMsg := sub_49ADB8(sMsg, '<$GOLDCOUNT>', sText);
    Exit;
  end;
  if sVariable = '$GAMEGOLD' then begin
    sText := IntToStr(PlayObject.m_nGameGold);
    sMsg := sub_49ADB8(sMsg, '<$GAMEGOLD>', sText);
    Exit;
  end;
  if sVariable = '$GAMEPOINT' then begin
    sText := IntToStr(PlayObject.m_nGamePoint);
    sMsg := sub_49ADB8(sMsg, '<$GAMEPOINT>', sText);
    Exit;
  end;
  if sVariable = '$HUNGER' then begin
    sText := IntToStr(PlayObject.GetMyStatus);
    sMsg := sub_49ADB8(sMsg, '<$HUNGER>', sText);
    Exit;
  end;
  if sVariable = '$LOGINTIME' then begin
    sText := DateTimeToStr(PlayObject.m_dLogonTime);
    sMsg := sub_49ADB8(sMsg, '<$LOGINTIME>', sText);
    Exit;
  end;
  if sVariable = '$LOGINLONG' then begin
    sText := IntToStr((GetTickCount - PlayObject.m_dwLogonTick) div 60000) + '分钟';
    sMsg := sub_49ADB8(sMsg, '<$LOGINLONG>', sText);
    Exit;
  end;
  if sVariable = '$DRESS' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_DRESS].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$DRESS>', sText);
    Exit;
  end else
    if sVariable = '$WEAPON' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_WEAPON].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$WEAPON>', sText);
    Exit;
  end else
    if sVariable = '$RIGHTHAND' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RIGHTHAND].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$RIGHTHAND>', sText);
    Exit;
  end else
    if sVariable = '$HELMET' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_HELMET].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$HELMET>', sText);
    Exit;
  end else
    if sVariable = '$NECKLACE' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_NECKLACE].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$NECKLACE>', sText);
    Exit;
  end else
    if sVariable = '$RING_R' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGR].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$RING_R>', sText);
    Exit;
  end else
    if sVariable = '$RING_L' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGL].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$RING_L>', sText);
    Exit;
  end else
    if sVariable = '$ARMRING_R' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGR].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$ARMRING_R>', sText);
    Exit;
  end else
    if sVariable = '$ARMRING_L' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGL].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$ARMRING_L>', sText);
    Exit;
  end else
    if sVariable = '$BUJUK' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BUJUK].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$BUJUK>', sText);
    Exit;
  end else
    if sVariable = '$BELT' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BELT].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$BELT>', sText);
    Exit;
  end else
    if sVariable = '$BOOTS' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BOOTS].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$BOOTS>', sText);
    Exit;
  end else
    if sVariable = '$CHARM' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_CHARM].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$CHARM>', sText);
    Exit;
  end else
    if sVariable = '$IPADDR' then begin
    sText := PlayObject.m_sIPaddr;
    sMsg := sub_49ADB8(sMsg, '<$IPADDR>', sText);
    Exit;
  end else
    if sVariable = '$IPLOCAL' then begin
    sText := PlayObject.m_sIPLocal; // GetIPLocal(PlayObject.m_sIPaddr);
    sMsg := sub_49ADB8(sMsg, '<$IPLOCAL>', sText);
    Exit;
  end else
    if sVariable = '$GUILDBUILDPOINT' then begin
    if PlayObject.m_MyGuild = nil then begin
      sText := '无';
    end else begin
      sText := IntToStr(TGUild(PlayObject.m_MyGuild).nBuildPoint);
    end;
    sMsg := sub_49ADB8(sMsg, '<$GUILDBUILDPOINT>', sText);
    Exit;
  end else
    if sVariable = '$GUILDAURAEPOINT' then begin
    if PlayObject.m_MyGuild = nil then begin
      sText := '无';
    end else begin
      sText := IntToStr(TGUild(PlayObject.m_MyGuild).nAurae);
    end;
    sMsg := sub_49ADB8(sMsg, '<$GUILDAURAEPOINT>', sText);
    Exit;
  end else
    if sVariable = '$GUILDSTABILITYPOINT' then begin
    if PlayObject.m_MyGuild = nil then begin
      sText := '无';
    end else begin
      sText := IntToStr(TGUild(PlayObject.m_MyGuild).nStability);
    end;
    sMsg := sub_49ADB8(sMsg, '<$GUILDSTABILITYPOINT>', sText);
    Exit;
  end;
  if sVariable = '$GUILDFLOURISHPOINT' then begin
    if PlayObject.m_MyGuild = nil then begin
      sText := '无';
    end else begin
      sText := IntToStr(TGUild(PlayObject.m_MyGuild).nFlourishing);
    end;
    sMsg := sub_49ADB8(sMsg, '<$GUILDFLOURISHPOINT>', sText);
    Exit;
  end else
    if sVariable = '$GUILDMEMBERMAXLIMIT' then begin
    if PlayObject.m_MyGuild = nil then begin
      sText := '???';
    end else begin
      sText := IntToStr(TGUild(PlayObject.m_MyGuild).m_nMemberMaxLimit);
    end;
    sMsg := sub_49ADB8(sMsg, '<$GUILDMEMBERMAXLIMIT>', sText);
    Exit;
  end else
    if sVariable = '$MONEXP' then begin
    sText := IntToStr(PlayObject.m_nGetMonExp);
    sMsg := sub_49ADB8(sMsg, '<$MONEXP>', sText);
    Exit;
  end;

  //其它信息
  if sVariable = '$REQUESTCASTLEWARITEM' then begin
    sText := g_Config.sZumaPiece;
    sMsg := sub_49ADB8(sMsg, '<$REQUESTCASTLEWARITEM>', sText);
    Exit;
  end;
  if sVariable = '$REQUESTCASTLEWARDAY' then begin
    sText := g_Config.sZumaPiece;
    sMsg := sub_49ADB8(sMsg, '<$REQUESTCASTLEWARDAY>', sText);
    Exit;
  end;
  if sVariable = '$REQUESTBUILDGUILDITEM' then begin
    sText := g_Config.sWomaHorn;
    sMsg := sub_49ADB8(sMsg, '<$REQUESTBUILDGUILDITEM>', sText);
    Exit;
  end;
  if sVariable = '$OWNERGUILD' then begin
    if m_Castle <> nil then begin
      sText := TUserCastle(m_Castle).m_sOwnGuild;
      if sText = '' then sText := '游戏管理';
    end else begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$OWNERGUILD>', sText);
    Exit;
  end; //0049AF32

  if sVariable = '$CASTLENAME' then begin
    if m_Castle <> nil then begin
      sText := TUserCastle(m_Castle).m_sName;
    end else begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$CASTLENAME>', sText);
    Exit;
  end;
  if sVariable = '$LORD' then begin
    if m_Castle <> nil then begin
      if TUserCastle(m_Castle).m_MasterGuild <> nil then begin
        sText := TUserCastle(m_Castle).m_MasterGuild.GetChiefName();
      end else sText := '管理员';
    end else begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$LORD>', sText);
    Exit;
  end; //0049AF32

  if sVariable = '$GUILDWARFEE' then begin
    sMsg := sub_49ADB8(sMsg, '<$GUILDWARFEE>', IntToStr(g_Config.nGuildWarPrice));
    Exit;
  end;
  if sVariable = '$BUILDGUILDFEE' then begin
    sMsg := sub_49ADB8(sMsg, '<$BUILDGUILDFEE>', IntToStr(g_Config.nBuildGuildPrice));
    Exit;
  end;

  if sVariable = '$CASTLEWARDATE' then begin
    if m_Castle = nil then begin
      m_Castle := g_CastleManager.GetCastle(0);
    end;
    if m_Castle <> nil then begin
      if not TUserCastle(m_Castle).m_boUnderWar then begin
        sText := TUserCastle(m_Castle).GetWarDate();
        if sText <> '' then begin
          sMsg := sub_49ADB8(sMsg, '<$CASTLEWARDATE>', sText);
        end else sMsg:='Well I guess there may be no wall conquest war in the mean time .\ \<back/@main>';
      end else sMsg:='Now is on wall conquest war.\ \<back/@main>';
    end else begin
      sText := '????';
    end;
    Exit;
  end;

  if sVariable = '$LISTOFWAR' then begin
    if m_Castle <> nil then begin
      sText := TUserCastle(m_Castle).GetAttackWarList();
    end else begin
      sText := '????';
    end;
    if sText <> '' then begin
      sMsg := sub_49ADB8(sMsg, '<$LISTOFWAR>', sText);
    end else sMsg:='We have no schedule...\ \<back/@main>';
    Exit;
  end;

  if sVariable = '$CASTLECHANGEDATE' then begin
    if m_Castle <> nil then begin
      sText := DateTimeToStr(TUserCastle(m_Castle).m_ChangeDate);
    end else begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$CASTLECHANGEDATE>', sText);
    Exit;
  end;

  if sVariable = '$CASTLEWARLASTDATE' then begin
    if m_Castle <> nil then begin
      sText := DateTimeToStr(TUserCastle(m_Castle).m_WarDate);
    end else begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$CASTLEWARLASTDATE>', sText);
    Exit;
  end;
  if sVariable = '$CASTLEGETDAYS' then begin
    if m_Castle <> nil then begin
      sText := IntToStr(GetDayCount(Now, TUserCastle(m_Castle).m_ChangeDate));
    end else begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$CASTLEGETDAYS>', sText);
    Exit;
  end;

  if sVariable = '$CMD_DATE' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_DATE>', g_GameCommand.Data.sCmd);
    Exit;
  end;
  if sVariable = '$CMD_ALLOWMSG' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_ALLOWMSG>', g_GameCommand.ALLOWMSG.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_LETSHOUT' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_LETSHOUT>', g_GameCommand.LETSHOUT.sCmd);
    Exit;
  end;
  if sVariable = '$CMD_LETTRADE' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_LETTRADE>', g_GameCommand.LETTRADE.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_LETGUILD' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_LETGUILD>', g_GameCommand.LETGUILD.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_ENDGUILD' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_ENDGUILD>', g_GameCommand.ENDGUILD.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_BANGUILDCHAT' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_BANGUILDCHAT>', g_GameCommand.BANGUILDCHAT.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_AUTHALLY' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_AUTHALLY>', g_GameCommand.AUTHALLY.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_AUTH' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_AUTH>', g_GameCommand.AUTH.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_AUTHCANCEL' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_AUTHCANCEL>', g_GameCommand.AUTHCANCEL.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_USERMOVE' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_USERMOVE>', g_GameCommand.USERMOVE.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_SEARCHING' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_SEARCHING>', g_GameCommand.SEARCHING.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_ALLOWGROUPCALL' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_ALLOWGROUPCALL>', g_GameCommand.ALLOWGROUPCALL.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_GROUPRECALLL' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_GROUPRECALLL>', g_GameCommand.GROUPRECALLL.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_ATTACKMODE' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_ATTACKMODE>', g_GameCommand.ATTACKMODE.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_REST' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_REST>', g_GameCommand.REST.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_STORAGESETPASSWORD' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_STORAGESETPASSWORD>', g_GameCommand.SETPASSWORD.sCmd);
    Exit;
  end;
  if sVariable = '$CMD_STORAGECHGPASSWORD' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_STORAGECHGPASSWORD>', g_GameCommand.CHGPASSWORD.sCmd);
    Exit;
  end;
  if sVariable = '$CMD_STORAGELOCK' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_STORAGELOCK>', g_GameCommand.Lock.sCmd);
    Exit;
  end;
  if sVariable = '$CMD_STORAGEUNLOCK' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_STORAGEUNLOCK>', g_GameCommand.UNLOCKSTORAGE.sCmd);
    Exit;
  end;
  if sVariable = '$CMD_UNLOCK' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_UNLOCK>', g_GameCommand.UnLock.sCmd);
    Exit;
  end;
  if CompareLStr(sVariable, '$HUMAN(', Length('$HUMAN(')) then begin
    ArrestStringEx(sVariable, '(', ')', s14);
    boFoundVar := False;
    for I := 0 to PlayObject.m_DynamicVarList.Count - 1 do begin
      DynamicVar := PlayObject.m_DynamicVarList.Items[I];
      if CompareText(DynamicVar.sName, s14) = 0 then begin
        case DynamicVar.VarType of
          vInteger: begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(DynamicVar.nInternet));
              boFoundVar := True;
            end;
          vString: begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', DynamicVar.sString);
              boFoundVar := True;
            end;
        end;
        Break;
      end;
    end;
    if not boFoundVar then sMsg := '??';

    Exit;
  end;
  if CompareLStr(sVariable, '$GUILD(', Length('$GUILD(')) then begin
    if PlayObject.m_MyGuild = nil then Exit;
    ArrestStringEx(sVariable, '(', ')', s14);
    boFoundVar := False;
    for I := 0 to TGUild(PlayObject.m_MyGuild).m_DynamicVarList.Count - 1 do begin
      DynamicVar := TGUild(PlayObject.m_MyGuild).m_DynamicVarList.Items[I];
      if CompareText(DynamicVar.sName, s14) = 0 then begin
        case DynamicVar.VarType of
          vInteger: begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(DynamicVar.nInternet));
              boFoundVar := True;
            end;
          vString: begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', DynamicVar.sString);
              boFoundVar := True;
            end;
        end;
        Break;
      end;
    end;
    if not boFoundVar then sMsg := '??';
    Exit;
  end;
  if CompareLStr(sVariable, '$GLOBAL(', Length('$GLOBAL(')) then begin
    ArrestStringEx(sVariable, '(', ')', s14);
    boFoundVar := False;
    for I := 0 to g_DynamicVarList.Count - 1 do begin
      DynamicVar := g_DynamicVarList.Items[I];
      if CompareText(DynamicVar.sName, s14) = 0 then begin
        case DynamicVar.VarType of
          vInteger: begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(DynamicVar.nInternet));
              boFoundVar := True;
            end;
          vString: begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', DynamicVar.sString);
              boFoundVar := True;
            end;
        end;
        Break;
      end;
    end;
    if not boFoundVar then sMsg := '??';
    Exit;
  end;
  if CompareLStr(sVariable, '$STR(', Length('$STR(')) then begin
    ArrestStringEx(sVariable, '(', ')', s14);
    n18 := GetValNameNo(s14);
    if n18 >= 0 then begin
      case n18 of
        0..499: begin
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(g_Config.GlobalVal[n18]));
          end;
        1100..1109: begin
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.m_nVal[n18 - 1100]));
          end;
        1110..1119: begin
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.m_DyVal[n18 - 1110]));
          end;
        1200..1299: begin
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.m_nMval[n18 - 1200]));
          end;
        1000..1099: begin
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(g_Config.GlobaDyMval[n18 - 1000]));
          end;
        1300..1399: begin
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.m_nInteger[n18 - 1300]));
          end;
        1400..1499: begin
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', PlayObject.m_sString[n18 - 1400]);
          end;
        2000..2499: begin
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.GlobalAVal[n18 - 2000]);
          end;
      end;
    end else //LowerCase
      if (s14 <> '') and (UpCase(s14[1]) = 'S') then begin
      n18 := PlayObject.m_StringList.GetIndex(UpperCase(s14));
      if n18 >= 0 then begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', PlayObject.m_StringList.Strings[n18]);
      end else begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', '');
      end;
    end else
      if (s14 <> '') and (UpCase(s14[1]) = 'N') then begin
      n18 := PlayObject.m_IntegerList.GetIndex(UpperCase(s14));
      if n18 >= 0 then begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(Integer(PlayObject.m_IntegerList.Objects[n18])));
      end else begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', '-1');
      end;
    end;
  end;
end;

procedure TNormNpc.GotoLable(AObject: TPlayObject; sLabel: string; boExtJmp: Boolean);
var
  I, II, III, J: Integer;
  List1C: TStringList;
  bo11: Boolean;
  n18: Integer;
  n20: Integer;
  sSENDMSG: string;
  Script: pTScript;
  Script3C: pTScript;
  SayingRecord: pTSayingRecord;
  SayingProcedure: pTSayingProcedure;
  UserItem: pTUserItem;
  PlayObject: TPlayObject;
  BaseObject: TActorObject;
  SC: string;
  MonGen: pTMonGenInfo;
  function IsPlayObject: Boolean;
  begin
    Result := (BaseObject <> nil) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) and (BaseObject = PlayObject);
  end;
  function IsHeroObject: Boolean;
  begin
    Result := (BaseObject <> nil) and (BaseObject.m_btRaceServer = RC_HEROOBJECT);
  end;

  function CheckQuestStatus(ScriptInfo: pTScript): Boolean;
  var
    I: Integer;
  begin
    Result := True;
    if not ScriptInfo.boQuest then Exit;
    I := 0;
    while (True) do begin
      if (ScriptInfo.QuestInfo[I].nRandRage > 0) and (Random(ScriptInfo.QuestInfo[I].nRandRage) <> 0) then begin
        Result := False;
        Break;
      end;
      if PlayObject.GetQuestFalgStatus(ScriptInfo.QuestInfo[I].wFlag) <> ScriptInfo.QuestInfo[I].btValue then begin
        Result := False;
        Break;
      end;
      Inc(I);
      if I >= 10 then Break;
    end; // while
  end;
  function CheckItemW(sItemType: string; nParam: Integer): pTUserItem;
  var
    nCount: Integer;
    sName: string;
  begin
    Result := nil;
    if CompareLStr(sItemType, '[NECKLACE]', 4) then begin
      if BaseObject.m_UseItems[U_NECKLACE].wIndex > 0 then begin
        Result := @BaseObject.m_UseItems[U_NECKLACE];
      end;
      Exit;
    end;
    if CompareLStr(sItemType, '[RING]', 4) then begin
      if BaseObject.m_UseItems[U_RINGL].wIndex > 0 then begin
        Result := @PlayObject.m_UseItems[U_RINGL];
      end;
      if BaseObject.m_UseItems[U_RINGR].wIndex > 0 then begin
        Result := @BaseObject.m_UseItems[U_RINGR];
      end;
      Exit;
    end;
    if CompareLStr(sItemType, '[ARMRING]', 4) then begin
      if BaseObject.m_UseItems[U_ARMRINGL].wIndex > 0 then begin
        Result := @BaseObject.m_UseItems[U_ARMRINGL];
      end;
      if PlayObject.m_UseItems[U_ARMRINGR].wIndex > 0 then begin
        Result := @BaseObject.m_UseItems[U_ARMRINGR];
      end;
      Exit;
    end;
    if CompareLStr(sItemType, '[WEAPON]', 4) then begin
      if BaseObject.m_UseItems[U_WEAPON].wIndex > 0 then begin
        Result := @BaseObject.m_UseItems[U_WEAPON];
      end;
      Exit;
    end;
    if CompareLStr(sItemType, '[HELMET]', 4) then begin
      if BaseObject.m_UseItems[U_HELMET].wIndex > 0 then begin
        Result := @BaseObject.m_UseItems[U_HELMET];
      end;
      Exit;
    end;
    if nParam < 3 then begin
      Result := BaseObject.sub_4C4CD4(sItemType, nCount);
      if nCount < nParam then
        Result := nil;
    end else begin
      if (nParam in [U_DRESS..U_CHARM]) and (BaseObject.m_UseItems[nParam].wIndex > 0) then begin
        sName := UserEngine.GetStdItemName(BaseObject.m_UseItems[nParam].wIndex);
        if CompareText(sName, sItemType) = 0 then begin
          Result := @BaseObject.m_UseItems[nParam];
        end else Result := nil;
      end else Result := nil;
    end;
  end;
  function CheckAnsiContainsTextList(sTest, sListFileName: string): Boolean;
  var
    I: Integer;
    LoadList: TStringList;
  begin
    Result := False;
    sListFileName := g_Config.sEnvirDir + sListFileName;
    if FileExists(sListFileName) then begin
      LoadList := TStringList.Create;
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
      for I := 0 to LoadList.Count - 1 do begin
        if AnsiContainsText(sTest, Trim(LoadList.Strings[I])) then begin
          Result := True;
          Break;
        end;
      end;
      LoadList.Free;
    end else begin
      MainOutMessage('file not found => ' + sListFileName);
    end;
  end;

  function CheckStringList(sHumName, sListFileName: string): Boolean;
  var
    I: Integer;
    LoadList: TStringList;
  begin
    Result := False;
    sListFileName := g_Config.sEnvirDir + sListFileName;
    if FileExists(sListFileName) then begin
      LoadList := TStringList.Create;
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
      for I := 0 to LoadList.Count - 1 do begin
        if CompareText(Trim(LoadList.Strings[I]), sHumName) = 0 then begin
          Result := True;
          Break;
        end;
      end;
      LoadList.Free;
    end else begin
      MainOutMessage('file not found => ' + sListFileName);
    end;
  end;

  function QuestCheckCondition(ConditionList: TList): Boolean;
  var
    I, II: Integer;
    QuestConditionInfo: pTQuestConditionInfo;
    n10, n14, n18, n1C, nMaxDura, nDura: Integer;
    Hour, Min, Sec, MSec: Word;
    Envir: TEnvirnoment;
    StdItem: pTStdItem;
    s01: string;
    MonList: TList;

    sVar1, sValue1: string;
    nValue1: Integer;
    VarInfo1: TVarInfo;

    sVar2, sValue2: string;
    nValue2: Integer;
    VarInfo2: TVarInfo;
  begin
    Result := True;
    for I := 0 to ConditionList.Count - 1 do begin
      QuestConditionInfo := ConditionList.Items[I];
      BaseObject := QuestConditionInfo.Script.GetActorObject(Self, AObject); //转换运行对象
      if BaseObject = nil then begin
        Result := False;
        Break;
      end else begin
        if BaseObject.m_btRaceServer = RC_PLAYOBJECT then
          PlayObject := TPlayObject(BaseObject) else PlayObject := nil;
      end;

      case QuestConditionInfo.nCMDCode of
        nCHECK: begin
            n14 := Str_ToInt(QuestConditionInfo.sParam1, 0);
            n18 := Str_ToInt(QuestConditionInfo.sParam2, 0);
            n10 := BaseObject.GetQuestFalgStatus(n14);
            if n10 = 0 then begin
              if n18 <> 0 then Result := False;
            end else begin
              if n18 = 0 then Result := False;
            end;
          end;
        nRANDOM: begin
            if Random(QuestConditionInfo.nParam1) <> 0 then Result := False;
          end;
        nGENDER: begin
            if CompareText(QuestConditionInfo.sParam1, sMAN) = 0 then begin
              if BaseObject.m_btGender <> 0 then Result := False;
            end else begin
              if BaseObject.m_btGender <> 1 then Result := False;
            end;
          end;
        nDAYTIME: begin
            if CompareText(QuestConditionInfo.sParam1, sSUNRAISE) = 0 then begin
              if g_nGameTime <> 0 then Result := False;
            end;
            if CompareText(QuestConditionInfo.sParam1, sDAY) = 0 then begin
              if g_nGameTime <> 1 then Result := False;
            end;
            if CompareText(QuestConditionInfo.sParam1, sSUNSET) = 0 then begin
              if g_nGameTime <> 2 then Result := False;
            end;
            if CompareText(QuestConditionInfo.sParam1, sNIGHT) = 0 then begin
              if g_nGameTime <> 3 then Result := False;
            end;
          end;
        nCHECKLEVEL: if BaseObject.m_Abil.Level < QuestConditionInfo.nParam1 then Result := False;
        nCHECKJOB: begin
            if CompareLStr(QuestConditionInfo.sParam1, sWARRIOR, 3) then begin
              if BaseObject.m_btJob <> 0 then Result := False;
            end;
            if CompareLStr(QuestConditionInfo.sParam1, sWIZARD, 3) then begin
              if BaseObject.m_btJob <> 1 then Result := False;
            end;
            if CompareLStr(QuestConditionInfo.sParam1, sTAOS, 3) then begin
              if BaseObject.m_btJob <> 2 then Result := False;
            end;
          end;
        nCHECKBBCOUNT: if BaseObject.m_SlaveList.Count < QuestConditionInfo.nParam1 then Result := False;
        nCHECKCREDITPOINT: ;
        nCHECKITEM: begin
            if IsPlayObject then begin
              s01 := QuestConditionInfo.sParam1;

              GetVarValue(PlayObject, QuestConditionInfo.sParam1, s01);

              UserItem := PlayObject.QuestCheckItem(s01, n1C, nMaxDura, nDura);
              if n1C < QuestConditionInfo.nParam2 then
                Result := False;
            end else
              if IsHeroObject then begin
              s01 := QuestConditionInfo.sParam1;
              GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam1, s01);
              UserItem := THeroObject(BaseObject).QuestCheckItem(s01, n1C, nMaxDura, nDura);
              if n1C < QuestConditionInfo.nParam2 then
                Result := False;
            end;
          end;
        nCHECKITEMW: begin
            s01 := QuestConditionInfo.sParam1;
            if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
              GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam1, s01);
            end else
              if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
              GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam1, s01);
            end;

            UserItem := CheckItemW(s01, QuestConditionInfo.nParam2);
            if UserItem = nil then
              Result := False;
          end;
        nCHECKGOLD: begin
            if IsPlayObject then begin
              n14 := Str_ToInt(QuestConditionInfo.sParam1, -1);
              if n14 < 0 then
                VarInfo1 := GetVarValue(PlayObject, QuestConditionInfo.sParam1, n14);
              if PlayObject.m_nGold < n14 then Result := False;
            end;
          end;
        nISTAKEITEM: if SC <> QuestConditionInfo.sParam1 then Result := False;
        nCHECKDURA: begin
            if IsPlayObject then begin
              UserItem := PlayObject.QuestCheckItem(QuestConditionInfo.sParam1, n1C, nMaxDura, nDura);
              if Round(nDura / 1000) < QuestConditionInfo.nParam2 then
                Result := False;
            end else Result := False;
          end;
        nCHECKDURAEVA: begin
            if IsPlayObject then begin
              UserItem := PlayObject.QuestCheckItem(QuestConditionInfo.sParam1, n1C, nMaxDura, nDura);
              if n1C > 0 then begin
                if Round(nMaxDura / n1C / 1000) < QuestConditionInfo.nParam2 then
                  Result := False;
              end else Result := False;
            end;
          end;
        nDAYOFWEEK: begin
            if CompareLStr(QuestConditionInfo.sParam1, sSUN, Length(sSUN)) then begin
              if DayOfWeek(Now) <> 1 then Result := False;
            end;
            if CompareLStr(QuestConditionInfo.sParam1, sMON, Length(sMON)) then begin
              if DayOfWeek(Now) <> 2 then Result := False;
            end;
            if CompareLStr(QuestConditionInfo.sParam1, sTUE, Length(sTUE)) then begin
              if DayOfWeek(Now) <> 3 then Result := False;
            end;
            if CompareLStr(QuestConditionInfo.sParam1, sWED, Length(sWED)) then begin
              if DayOfWeek(Now) <> 4 then Result := False;
            end;
            if CompareLStr(QuestConditionInfo.sParam1, sTHU, Length(sTHU)) then begin
              if DayOfWeek(Now) <> 5 then Result := False;
            end;
            if CompareLStr(QuestConditionInfo.sParam1, sFRI, Length(sFRI)) then begin
              if DayOfWeek(Now) <> 6 then Result := False;
            end;
            if CompareLStr(QuestConditionInfo.sParam1, sSAT, Length(sSAT)) then begin
              if DayOfWeek(Now) <> 7 then Result := False;
            end;
          end;
        nHOUR: begin
            if (QuestConditionInfo.nParam1 <> 0) and (QuestConditionInfo.nParam2 = 0) then
              QuestConditionInfo.nParam2 := QuestConditionInfo.nParam1;
            DecodeTime(Time, Hour, Min, Sec, MSec);
            if (Hour < QuestConditionInfo.nParam1) or (Hour > QuestConditionInfo.nParam2) then
              Result := False;
          end;
        nMIN: begin
            if (QuestConditionInfo.nParam1 <> 0) and (QuestConditionInfo.nParam2 = 0) then
              QuestConditionInfo.nParam2 := QuestConditionInfo.nParam1;
            DecodeTime(Time, Hour, Min, Sec, MSec);
            if (Min < QuestConditionInfo.nParam1) or (Min > QuestConditionInfo.nParam2) then
              Result := False;
          end;

        nCHECKPKPOINT: begin
            n14 := Str_ToInt(QuestConditionInfo.sParam1, -1);
            if IsPlayObject then begin
              if n14 < 0 then
                VarInfo1 := GetVarValue(PlayObject, QuestConditionInfo.sParam1, n14);
            end;
            if BaseObject.PKLevel < n14 then Result := False;
          end;

        nCHECKLUCKYPOINT: if BaseObject.m_nBodyLuckLevel < QuestConditionInfo.nParam1 then Result := False;
        nCHECKMONMAP: if not ConditionOfCheckMonMapCount(BaseObject, QuestConditionInfo) then Result := False;
        nCHECKMONAREA: ;
        nCHECKHUM: begin
            n14 := Str_ToInt(QuestConditionInfo.sParam2, -1);
            if IsPlayObject then begin
              if n14 < 0 then
                GetVarValue(PlayObject, QuestConditionInfo.sParam2, n14);
              s01 := QuestConditionInfo.sParam1;
              if g_MapManager.FindMap(s01) = nil then
                GetVarValue(PlayObject, QuestConditionInfo.sParam1, s01);
            end;
            if UserEngine.GetMapHuman(s01) < n14 then Result := False;
          end;

        nCHECKBAGGAGE: begin
            if IsPlayObject then begin
              if PlayObject.IsEnoughBag then begin
                if QuestConditionInfo.sParam1 <> '' then begin
                  Result := False;

                  s01 := QuestConditionInfo.sParam1;
                  GetVarValue(PlayObject, QuestConditionInfo.sParam1, s01);

                  StdItem := UserEngine.GetStdItem(s01);
                  if StdItem <> nil then begin
                    if PlayObject.IsAddWeightAvailable(StdItem.Weight) then
                      Result := True;
                  end;
                end;
              end else Result := False;
            end else
              if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
              if THeroObject(BaseObject).IsEnoughBag then begin
                if QuestConditionInfo.sParam1 <> '' then begin
                  Result := False;
                  s01 := QuestConditionInfo.sParam1;
                  VarInfo1 := GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam1, s01);
                  StdItem := UserEngine.GetStdItem(s01);
                  if StdItem <> nil then begin
                    if THeroObject(BaseObject).IsAddWeightAvailable(StdItem.Weight) then
                      Result := True;
                  end;
                end;
              end else Result := False;
            end else Result := False;
          end;
        nCHECKNAMELIST: if not CheckStringList(BaseObject.m_sCharName, m_sPath + QuestConditionInfo.sParam1) then Result := False;
        nCHECKACCOUNTLIST: if (not IsPlayObject) or (not CheckStringList(PlayObject.m_sUserID, m_sPath + QuestConditionInfo.sParam1)) then Result := False;
        nCHECKIPLIST: if (not IsPlayObject) or (not CheckStringList(PlayObject.m_sIPaddr, m_sPath + QuestConditionInfo.sParam1)) then Result := False;

        nEQUAL: begin
            if IsPlayObject then begin
              VarInfo1 := GetVarValue(PlayObject, QuestConditionInfo.sParam1, sVar1, sValue1, nValue1);
              VarInfo2 := GetVarValue(PlayObject, QuestConditionInfo.sParam2, sVar2, sValue2, nValue2);
              case VarInfo1.VarType of
                vNone: ;
                vInteger: begin
                    if nValue1 <> nValue2 then Result := False;
                  end;
                vString: begin
                    if sValue1 <> sValue2 then Result := False;
                  end;
              end;
            end else Result := False;
          end;
        nLARGE: begin
            if IsPlayObject then begin
              GetVarValue(PlayObject, QuestConditionInfo.sParam1, nValue1);
              GetVarValue(PlayObject, QuestConditionInfo.sParam2, nValue2);
              if nValue1 <= nValue2 then Result := False;
            end else Result := False;
          end;
        nSMALL: begin
            if IsPlayObject then begin
              GetVarValue(PlayObject, QuestConditionInfo.sParam1, nValue1);
              GetVarValue(PlayObject, QuestConditionInfo.sParam2, nValue2);
              if nValue1 >= nValue2 then Result := False;
            end else Result := False;
          end;
        nSC_ISSYSOP: if not (BaseObject.m_btPermission >= 4) then Result := False;
        nSC_ISADMIN: if not (BaseObject.m_btPermission >= 6) then Result := False;
        nSC_CHECKGROUPCOUNT: if (not IsPlayObject) or (not ConditionOfCheckGroupCount(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKPOSEDIR: if not ConditionOfCheckPoseDir(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKPOSELEVEL: if not ConditionOfCheckPoseLevel(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKPOSEGENDER: if not ConditionOfCheckPoseGender(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKLEVELEX: if not ConditionOfCheckLevelEx(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKBONUSPOINT: if (not IsPlayObject) or (not ConditionOfCheckBonusPoint(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKMARRY: if (not IsPlayObject) or (not ConditionOfCheckMarry(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKPOSEMARRY: if (not IsPlayObject) or (not ConditionOfCheckPoseMarry(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKMARRYCOUNT: if (not IsPlayObject) or (not ConditionOfCheckMarryCount(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKMASTER: if (not IsPlayObject) or (not ConditionOfCheckMaster(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_HAVEMASTER: if (not IsPlayObject) or (not ConditionOfHaveMaster(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKPOSEMASTER: if (not IsPlayObject) or (not ConditionOfCheckPoseMaster(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_POSEHAVEMASTER: if (not IsPlayObject) or (not ConditionOfPoseHaveMaster(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKISMASTER: if (not IsPlayObject) or (not ConditionOfCheckIsMaster(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_HASGUILD: if (not IsPlayObject) or (not ConditionOfCheckHaveGuild(PlayObject, QuestConditionInfo)) then Result := False;

        nSC_ISGUILDMASTER: if (not IsPlayObject) or (not ConditionOfCheckIsGuildMaster(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKCASTLEMASTER: if (not IsPlayObject) or (not ConditionOfCheckIsCastleMaster(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_ISCASTLEGUILD: if (not IsPlayObject) or (not ConditionOfCheckIsCastleaGuild(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_ISATTACKGUILD: if (not IsPlayObject) or (not ConditionOfCheckIsAttackGuild(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_ISDEFENSEGUILD: if (not IsPlayObject) or (not ConditionOfCheckIsDefenseGuild(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKCASTLEDOOR: if (not IsPlayObject) or (not ConditionOfCheckCastleDoorStatus(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_ISATTACKALLYGUILD: if (not IsPlayObject) or (not ConditionOfCheckIsAttackAllyGuild(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_ISDEFENSEALLYGUILD: if (not IsPlayObject) or (not ConditionOfCheckIsDefenseAllyGuild(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKPOSEISMASTER: if (not IsPlayObject) or (not ConditionOfCheckPoseIsMaster(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKNAMEIPLIST: if (not IsPlayObject) or (not ConditionOfCheckNameIPList(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKACCOUNTIPLIST: if (not IsPlayObject) or (not ConditionOfCheckAccountIPList(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKSLAVECOUNT: if not ConditionOfCheckSlaveCount(BaseObject, QuestConditionInfo) then Result := False;
        nSC_ISNEWHUMAN: if (not IsPlayObject) or (not PlayObject.m_boNewHuman) then Result := False;
        nSC_CHECKMEMBERTYPE: if (not IsPlayObject) or (not ConditionOfCheckMemberType(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKMEMBERLEVEL: if (not IsPlayObject) or (not ConditionOfCheckMemBerLevel(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKGAMEGOLD: if (not IsPlayObject) or (not ConditionOfCheckGameGold(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKGAMEPOINT: if (not IsPlayObject) or (not ConditionOfCheckGamePoint(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKNAMELISTPOSITION: if not ConditionOfCheckNameListPostion(BaseObject, QuestConditionInfo) then Result := False;
        //nSC_CHECKGUILDLIST:     if not ConditionOfCheckGuildList(PlayObject,QuestConditionInfo) then Result:=False;
        nSC_CHECKGUILDLIST: begin
            if IsPlayObject and (PlayObject.m_MyGuild <> nil) then begin
              if not CheckStringList(TGUild(PlayObject.m_MyGuild).sGuildName, m_sPath + QuestConditionInfo.sParam1) then Result := False;
            end else Result := False;
          end;
        nSC_CHECKRENEWLEVEL: if (not IsPlayObject) or (not ConditionOfCheckReNewLevel(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKSLAVELEVEL: if not ConditionOfCheckSlaveLevel(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKSLAVENAME: if not ConditionOfCheckSlaveName(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKCREDITPOINT: if (not IsPlayObject) or (not ConditionOfCheckCreditPoint(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKOFGUILD: if (not IsPlayObject) or (not ConditionOfCheckOfGuild(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKPAYMENT: if (not IsPlayObject) or (not ConditionOfCheckPayMent(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKUSEITEM: if not ConditionOfCheckUseItem(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKBAGSIZE: if not ConditionOfCheckBagSize(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKLISTCOUNT: if not ConditionOfCheckListCount(PlayObject, QuestConditionInfo) then Result := False;
        nSC_CHECKDC: if not ConditionOfCheckDC(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKMC: if not ConditionOfCheckMC(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKSC: if not ConditionOfCheckSC(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKHP: if not ConditionOfCheckHP(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKMP: if not ConditionOfCheckMP(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKITEMTYPE: if not ConditionOfCheckItemType(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKEXP: if not ConditionOfCheckExp(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKCASTLEGOLD: if (not IsPlayObject) or (not ConditionOfCheckCastleGold(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_PASSWORDERRORCOUNT: if (not IsPlayObject) or (not ConditionOfCheckPasswordErrorCount(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_ISLOCKPASSWORD: if (not IsPlayObject) or (not ConditionOfIsLockPassword(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_ISLOCKSTORAGE: if (not IsPlayObject) or (not ConditionOfIsLockStorage(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKBUILDPOINT: if (not IsPlayObject) or (not ConditionOfCheckGuildBuildPoint(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKAURAEPOINT: if (not IsPlayObject) or (not ConditionOfCheckGuildAuraePoint(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKSTABILITYPOINT: if (not IsPlayObject) or (not ConditionOfCheckStabilityPoint(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKFLOURISHPOINT: if (not IsPlayObject) or (not ConditionOfCheckFlourishPoint(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKCONTRIBUTION: if (not IsPlayObject) or (not ConditionOfCheckContribution(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKRANGEMONCOUNT: if not ConditionOfCheckRangeMonCount(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKITEMADDVALUE: if (not IsPlayObject) or (not ConditionOfCheckItemAddValue(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKINMAPRANGE: if not ConditionOfCheckInMapRange(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CASTLECHANGEDAY: if (not IsPlayObject) or (not ConditionOfCheckCastleChageDay(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CASTLEWARDAY: if (not IsPlayObject) or (not ConditionOfCheckCastleWarDay(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_ONLINELONGMIN: if (not IsPlayObject) or (not ConditionOfCheckOnlineLongMin(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKGUILDCHIEFITEMCOUNT: if (not IsPlayObject) or (not ConditionOfCheckChiefItemCount(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKNAMEDATELIST, nSC_CHECKUSERDATE: if (not IsPlayObject) or (not ConditionOfCheckNameDateList(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKMAPHUMANCOUNT: if not ConditionOfCheckMapHumanCount(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKMAPMONCOUNT: if not ConditionOfCheckMapMonCount(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKVAR: if (not IsPlayObject) or (not ConditionOfCheckVar(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKSERVERNAME: if (not IsPlayObject) or (not ConditionOfCheckServerName(PlayObject, QuestConditionInfo)) then Result := False;
        nCHECKMAPNAME: if not ConditionOfCheckMapName(BaseObject, QuestConditionInfo) then Result := False;
        nINSAFEZONE: if not ConditionOfCheckSafeZone(BaseObject, QuestConditionInfo) then Result := False;
        nCHECKSKILL: if not ConditionOfCheckSkill(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKCONTAINSTEXT: if (not IsPlayObject) or (not ConditionOfAnsiContainsText(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_COMPARETEXT: if (not IsPlayObject) or (not ConditionOfCompareText(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKTEXTLIST: begin
            if IsPlayObject then begin
              s01 := GetLineVariableText(PlayObject, QuestConditionInfo.sParam1);
              VarInfo1 := GetVarValue(PlayObject, s01, s01);
              if not CheckStringList(s01, m_sPath + QuestConditionInfo.sParam2) then Result := False;
            end else Result := False;
          end;
        nSC_ISGROUPMASTER: begin
            if IsPlayObject and (PlayObject.m_GroupOwner <> nil) then begin
              if PlayObject.m_GroupOwner <> PlayObject then
                Result := False;
            end else Result := False;
          end;
        nSC_CHECKCONTAINSTEXTLIST: begin
            if IsPlayObject then begin
              s01 := GetLineVariableText(PlayObject, QuestConditionInfo.sParam1);
              VarInfo1 := GetVarValue(PlayObject, s01, s01);
              if not CheckAnsiContainsTextList(s01, m_sPath + QuestConditionInfo.sParam2) then Result := False;
            end else Result := False;
          end;
        nSC_CHECKONLINE: Result := True;
        nSC_ISDUPMODE: begin
            if BaseObject.m_PEnvir <> nil then begin
              if BaseObject.m_PEnvir.GetXYObjCount(BaseObject.m_nCurrX, BaseObject.m_nCurrY) <= 1 then Result := False;
            end else Result := False;
          end;
        nSC_ISOFFLINEMODE: begin //检测是否是离线挂机人物
            if (not IsPlayObject) or (not PlayObject.m_boNotOnlineAddExp) then Result := False;
          end;
        nSC_CHECKSTATIONTIME: if not ConditionOfCheckStationTime(BaseObject, QuestConditionInfo) then Result := False; //检测人物站立时间
        nSC_CHECKSIGNMAP: if BaseObject.m_btLastOutStatus <> 1 then Result := False; //检测最后退出状态
        //=================================英雄相关=====================================
        nSC_HAVEHERO: if (not IsPlayObject) or (not ConditionOfCheckHasHero(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_ACTMISSION: if (not IsPlayObject) or (not ConditionOfActMission(PlayObject, QuestConditionInfo)) then Result := False;

        nSC_CHECKGUILDMEMBERMAXLIMIT: if (not IsPlayObject) or (not ConditionOfCheckGuildMeberMaxLimit(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKGUILDNAMEDATELIST: if (not IsPlayObject) or (not ConditionOfCheckGuildNameDateList(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKRANGEROUPCOUNT: if (not IsPlayObject) or (not ConditionOfCheckRangeGroupCount(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKONLINEPLAYCOUNT: if (not IsPlayObject) or (not ConditionOfCheckOnLinePlayCount(PlayObject, QuestConditionInfo)) then Result := False;

        nSC_CHECKITEMLIMIT: if (not IsPlayObject) or (not ConditionOfCheckItemLimit(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKITEMLIMITCOUNT: if (not IsPlayObject) or (not ConditionOfCheckItemLimitCount(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKMEMORYITEM: if (not IsPlayObject) or (not ConditionOfCheckMemoryItem(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKUPGRADEITEMS: if (not IsPlayObject) or (not ConditionOfUpgradeItems(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKIPUTTEM: if (not IsPlayObject) or (not ConditionOfPutItem(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKITEMBIND: if (not IsPlayObject) or (not ConditionOfCheckItemBind(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKITEMNEWADDVALUE: if (not IsPlayObject) or (not ConditionOfItemNewAddValue(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKITEMNEWADDVALUECOUNT: if (not IsPlayObject) or (not ConditionOfCheckItemNewAddValueCount(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKHEROGROUP: if (not IsPlayObject) or (not ConditionOfCheckHeroGroup(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKPUTITEMTYPE: if (not IsPlayObject) or (not ConditionOfCheckPutItemType(PlayObject, QuestConditionInfo)) then Result := False;

        nSC_CHECKUSEITEMSTARSLEVEL: if (not IsPlayObject) or (not ConditionOfCheckUseItemStarsLevel(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKBAGITEMSTARSLEVEL: if (not IsPlayObject) or (not ConditionOfCheckBagItemStarsLevel(PlayObject, QuestConditionInfo)) then Result := False;

        nSC_CHECKDEATH: if not BaseObject.m_boDeath then Result := False;
        nSC_INCASTLEWARAREA: if not ConditionOfInCastleWarArea(BaseObject, QuestConditionInfo) then Result := False;
        nSC_ISUNDERWAR: if not ConditionOfIsUnderWar(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKPKPOINTEX: if not ConditionOfCheckPKPoint(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKUSEITEMBIND: if (not IsPlayObject) or (not ConditionOfCheckItemBindUse(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_ISSPACELOCK: if not m_boSpaceLock then Result := False;
        nSC_CHECKRANGEMAPMAGICEVENTCOUNT: if not ConditionOfCheckRangeMapMagicEventCount(BaseObject, QuestConditionInfo) then Result := False;
        nSC_GETDUELMAP: if (not IsPlayObject) or (not ConditionOfGetDuelMap(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKMAPDUELING: if (not IsPlayObject) or (not ConditionOfCheckMapDuelMap(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKHUMDUELING: if (not IsPlayObject) or (not ConditionOfCheckHumDuelMap(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKCANUSEITEM: if (not IsPlayObject) or (not PlayObject.m_boCanUseItem) then Result := False;
        nSC_CHECKINCURRRECT: if not ConditionOfCheckInCurrRect(BaseObject, QuestConditionInfo) then Result := False;
        nSC_CHECKGUILDMEMBER: if (not IsPlayObject) or (not ConditionOfCheckGuildMember(PlayObject, QuestConditionInfo)) then Result := False;

        nSC_INDEXOF: if (not IsPlayObject) or (not ConditionOfIndexOf(PlayObject, QuestConditionInfo)) then Result := False;
        nSC_CHECKMASKED: if not ConditionOfCheckMasked(BaseObject, QuestConditionInfo) then Result := False;

        nSC_CHECKSLAVERANGE: if (not ConditionOfCheckSlaveRange(BaseObject, QuestConditionInfo)) then Result := False;
        nSC_ISAI: if not BaseObject.m_boAI then Result := False;
        nSC_CHECKBAGITEMINLIST: if not ConditionOfCheckBagItemInList(BaseObject, QuestConditionInfo) then Result := False;
      else begin
          if Assigned(PlugInEngine.ConditionScriptProcess) then begin
            try
              if (not IsPlayObject) or (not PlugInEngine.ConditionScriptProcess(Self,
                BaseObject,
                QuestConditionInfo.nCMDCode,
                PChar(QuestConditionInfo.sParam1),
                QuestConditionInfo.nParam1,
                PChar(QuestConditionInfo.sParam2),
                QuestConditionInfo.nParam2,
                PChar(QuestConditionInfo.sParam3),
                QuestConditionInfo.nParam3,
                PChar(QuestConditionInfo.sParam4),
                QuestConditionInfo.nParam4,
                PChar(QuestConditionInfo.sParam5),
                QuestConditionInfo.nParam5,
                PChar(QuestConditionInfo.sParam6),
                QuestConditionInfo.nParam6,
                PChar(QuestConditionInfo.sParam7),
                QuestConditionInfo.nParam7,
                PChar(QuestConditionInfo.sParam8),
                QuestConditionInfo.nParam8,
                PChar(QuestConditionInfo.sParam9),
                QuestConditionInfo.nParam9,
                PChar(QuestConditionInfo.sParam10),
                QuestConditionInfo.nParam10)) then Result := False;
            except
              Result := False;
            end;
          end;
        end;
      end;
      if not Result then Break;
    end;
  end;

  function JmpToLable(sLabel: string): Boolean;
  var
    sValue: string;
  begin
    Result := False;
    Inc(PlayObject.m_nScriptGotoCount);
    if PlayObject.m_nScriptGotoCount > g_Config.nScriptGotoCountLimit {10} then Exit;

    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), sLabel, sValue);
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), sLabel, sValue);
    end;
    GotoLable(PlayObject, sValue, False);
    Result := True;
  end;

  procedure GoToQuest(nQuest: Integer);
  var
    I: Integer;
    Script: pTScript;
  begin
    for I := 0 to m_ScriptList.Count - 1 do begin
      Script := m_ScriptList.Items[I];
      if Script.nQuest = nQuest then begin
        PlayObject.m_Script := Script;
        PlayObject.m_NPC := Self;
        GotoLable(PlayObject, sMAIN, False);
        Break;
      end;
    end;
  end;

  procedure AddList(sHumName, sListFileName: string);
  var
    I: Integer;
    LoadList: TStringList;
    s10: string;
    bo15: Boolean;
  begin
    sListFileName := g_Config.sEnvirDir + sListFileName;
    LoadList := TStringList.Create;
    if FileExists(sListFileName) then begin
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
    end;
    bo15 := False;
    for I := 0 to LoadList.Count - 1 do begin
      s10 := Trim(LoadList.Strings[I]);
      if CompareText(sHumName, s10) = 0 then begin
        bo15 := True;
        Break;
      end;
    end;
    if not bo15 then begin
      LoadList.Add(sHumName);
      try
        LoadList.SaveToFile(sListFileName);
      except
        MainOutMessage('saving fail.... => ' + sListFileName);
      end;
    end;
    LoadList.Free;
  end;

  procedure DelList(sHumName, sListFileName: string);
  var
    I: Integer;
    LoadList: TStringList;
    s10: string;
    bo15: Boolean;
  begin
    sListFileName := g_Config.sEnvirDir + sListFileName;
    LoadList := TStringList.Create;
    if FileExists(sListFileName) then begin
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
    end;
    bo15 := False;
    for I := 0 to LoadList.Count - 1 do begin
      if LoadList.Count <= 0 then Break;
      s10 := Trim(LoadList.Strings[I]);
      if CompareText(sHumName, s10) = 0 then begin
        LoadList.Delete(I);
        bo15 := True;
        Break;
      end;
    end;
    if bo15 then begin
      try
        LoadList.SaveToFile(sListFileName);
      except
        MainOutMessage('saving fail.... => ' + sListFileName);
      end;
    end;
    LoadList.Free;
  end;

  procedure TakeItem(sItemName: string; nItemCount: Integer; sVarNo: string);
  var
    I: Integer;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    nCount: Integer;
    sName: string;
  begin
    nCount := nItemCount;

    sName := sItemName;

    if IsPlayObject then begin
      GetVarValue(PlayObject, sItemName, sName); //增加变量支持
      if nCount < 0 then
        GetVarValue(PlayObject, sVarNo, nCount); //增加变量支持
    end;

    if CompareText(sName, sSTRING_GOLDNAME) = 0 then begin
      if IsPlayObject then begin
        //GetVarValue(PlayObject, sItemName, sName); //增加变量支持
        //GetVarValue(PlayObject, sVarNo, nCount); //增加变量支持
        if nCount <= 0 then Exit;
        PlayObject.DecGold(nCount);
        PlayObject.GoldChanged();
        if g_boGameLogGold then
          AddGameDataLog('10' + #9 +
            PlayObject.m_sMapName + #9 +
            IntToStr(PlayObject.m_nCurrX) + #9 +
            IntToStr(PlayObject.m_nCurrY) + #9 +
            PlayObject.m_sCharName + #9 +
            sSTRING_GOLDNAME + #9 +
            IntToStr(nCount) + #9 +
            '1' + #9 +
            m_sCharName);

      end;
      Exit;
    end;

    for I := BaseObject.m_ItemList.Count - 1 downto 0 do begin
      if nCount <= 0 then Break;
      UserItem := BaseObject.m_ItemList.Items[I];
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if (StdItem <> nil) and (CompareText(StdItem.Name, sName) = 0) then begin

        if StdItem.NeedIdentify = 1 then
          AddGameDataLog('10' + #9 +
            PlayObject.m_sMapName + #9 +
            IntToStr(PlayObject.m_nCurrX) + #9 +
            IntToStr(PlayObject.m_nCurrY) + #9 +
            PlayObject.m_sCharName + #9 +
            sName + #9 +
            IntToStr(UserItem.MakeIndex) + #9 +
            '1' + #9 +
            m_sCharName);

        if IsPlayObject then begin
          PlayObject.SendDelItems(UserItem);
        end else begin
          if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
            THeroObject(BaseObject).SendDelItems(UserItem);
          end;
        end;
        //SC := UserEngine.GetStdItemName(UserItem.wIndex);

        BaseObject.m_ItemList.Delete(I);
        Dispose(UserItem);
        Dec(nCount);
      end;
    end;
  end;

  procedure TakeWItem(sItemName: string; nItemCount: Integer);
  var
    I: Integer;
    sName: string;
  begin
    if CompareLStr(sItemName, '[NECKLACE]', 4) then begin
      if BaseObject.m_UseItems[U_NECKLACE].wIndex > 0 then begin
        if IsPlayObject then begin
          PlayObject.SendDelItems(@BaseObject.m_UseItems[U_NECKLACE]);
        end else begin
          if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
            THeroObject(BaseObject).SendDelItems(@BaseObject.m_UseItems[U_NECKLACE]);
          end;
        end;
        SC := UserEngine.GetStdItemName(BaseObject.m_UseItems[U_NECKLACE].wIndex);
        BaseObject.m_UseItems[U_NECKLACE].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[RING]', 4) then begin
      if BaseObject.m_UseItems[U_RINGL].wIndex > 0 then begin
        if IsPlayObject then begin
          PlayObject.SendDelItems(@BaseObject.m_UseItems[U_RINGL]);
        end else begin
          if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
            THeroObject(BaseObject).SendDelItems(@BaseObject.m_UseItems[U_RINGL]);
          end;
        end;
        SC := UserEngine.GetStdItemName(BaseObject.m_UseItems[U_RINGL].wIndex);
        BaseObject.m_UseItems[U_RINGL].wIndex := 0;
        Exit;
      end;
      if BaseObject.m_UseItems[U_RINGR].wIndex > 0 then begin
        if IsPlayObject then begin
          PlayObject.SendDelItems(@BaseObject.m_UseItems[U_RINGR]);
        end else begin
          if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
            THeroObject(BaseObject).SendDelItems(@BaseObject.m_UseItems[U_RINGR]);
          end;
        end;
        SC := UserEngine.GetStdItemName(BaseObject.m_UseItems[U_RINGR].wIndex);
        BaseObject.m_UseItems[U_RINGR].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[ARMRING]', 4) then begin
      if BaseObject.m_UseItems[U_ARMRINGL].wIndex > 0 then begin
        if IsPlayObject then begin
          PlayObject.SendDelItems(@BaseObject.m_UseItems[U_ARMRINGL]);
        end else begin
          if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
            THeroObject(BaseObject).SendDelItems(@BaseObject.m_UseItems[U_ARMRINGL]);
          end;
        end;
        SC := UserEngine.GetStdItemName(BaseObject.m_UseItems[U_ARMRINGL].wIndex);
        BaseObject.m_UseItems[U_ARMRINGL].wIndex := 0;
        Exit;
      end;
      if BaseObject.m_UseItems[U_ARMRINGR].wIndex > 0 then begin
        if IsPlayObject then begin
          PlayObject.SendDelItems(@BaseObject.m_UseItems[U_ARMRINGL]);
        end else begin
          if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
            THeroObject(BaseObject).SendDelItems(@BaseObject.m_UseItems[U_ARMRINGL]);
          end;
        end;
        SC := UserEngine.GetStdItemName(BaseObject.m_UseItems[U_ARMRINGR].wIndex);
        BaseObject.m_UseItems[U_ARMRINGR].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[WEAPON]', 4) then begin
      if BaseObject.m_UseItems[U_WEAPON].wIndex > 0 then begin
        if IsPlayObject then begin
          PlayObject.SendDelItems(@BaseObject.m_UseItems[U_WEAPON]);
        end else begin
          if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
            THeroObject(BaseObject).SendDelItems(@BaseObject.m_UseItems[U_WEAPON]);
          end;
        end;
        SC := UserEngine.GetStdItemName(BaseObject.m_UseItems[U_WEAPON].wIndex);
        BaseObject.m_UseItems[U_WEAPON].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[HELMET]', 4) then begin
      if BaseObject.m_UseItems[U_HELMET].wIndex > 0 then begin
        if IsPlayObject then begin
          PlayObject.SendDelItems(@BaseObject.m_UseItems[U_HELMET]);
        end else begin
          if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
            THeroObject(BaseObject).SendDelItems(@BaseObject.m_UseItems[U_HELMET]);
          end;
        end;
        SC := UserEngine.GetStdItemName(BaseObject.m_UseItems[U_HELMET].wIndex);
        BaseObject.m_UseItems[U_HELMET].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[DRESS]', 4) then begin
      if BaseObject.m_UseItems[U_DRESS].wIndex > 0 then begin
        if IsPlayObject then begin
          PlayObject.SendDelItems(@BaseObject.m_UseItems[U_DRESS]);
        end else begin
          if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
            THeroObject(BaseObject).SendDelItems(@BaseObject.m_UseItems[U_DRESS]);
          end;
        end;
        SC := UserEngine.GetStdItemName(BaseObject.m_UseItems[U_DRESS].wIndex);
        BaseObject.m_UseItems[U_DRESS].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[U_BUJUK]', 4) then begin
      if BaseObject.m_UseItems[U_BUJUK].wIndex > 0 then begin
        if IsPlayObject then begin
          PlayObject.SendDelItems(@BaseObject.m_UseItems[U_BUJUK]);
        end else begin
          if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
            THeroObject(BaseObject).SendDelItems(@BaseObject.m_UseItems[U_BUJUK]);
          end;
        end;
        SC := UserEngine.GetStdItemName(BaseObject.m_UseItems[U_BUJUK].wIndex);
        BaseObject.m_UseItems[U_BUJUK].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[U_BELT]', 4) then begin
      if BaseObject.m_UseItems[U_BELT].wIndex > 0 then begin
        if IsPlayObject then begin
          PlayObject.SendDelItems(@BaseObject.m_UseItems[U_BELT]);
        end else begin
          if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
            THeroObject(BaseObject).SendDelItems(@BaseObject.m_UseItems[U_BELT]);
          end;
        end;
        SC := UserEngine.GetStdItemName(BaseObject.m_UseItems[U_BELT].wIndex);
        BaseObject.m_UseItems[U_BELT].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[U_BOOTS]', 4) then begin
      if BaseObject.m_UseItems[U_BOOTS].wIndex > 0 then begin
        if IsPlayObject then begin
          PlayObject.SendDelItems(@BaseObject.m_UseItems[U_BOOTS]);
        end else begin
          if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
            THeroObject(BaseObject).SendDelItems(@BaseObject.m_UseItems[U_BOOTS]);
          end;
        end;
        SC := UserEngine.GetStdItemName(BaseObject.m_UseItems[U_BOOTS].wIndex);
        BaseObject.m_UseItems[U_BOOTS].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[U_CHARM]', 4) then begin
      if BaseObject.m_UseItems[U_CHARM].wIndex > 0 then begin
        if IsPlayObject then begin
          PlayObject.SendDelItems(@BaseObject.m_UseItems[U_CHARM]);
        end else begin
          if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
            THeroObject(BaseObject).SendDelItems(@BaseObject.m_UseItems[U_CHARM]);
          end;
        end;
        SC := UserEngine.GetStdItemName(BaseObject.m_UseItems[U_CHARM].wIndex);
        BaseObject.m_UseItems[U_CHARM].wIndex := 0;
        Exit;
      end;
    end;
    for I := Low(THumanUseItems) to High(THumanUseItems) do begin
      if nItemCount <= 0 then Exit;
      if BaseObject.m_UseItems[I].wIndex > 0 then begin
        sName := UserEngine.GetStdItemName(BaseObject.m_UseItems[I].wIndex);
        if CompareText(sName, sItemName) = 0 then begin
          if IsPlayObject then begin
            PlayObject.SendDelItems(@BaseObject.m_UseItems[I]);
          end else begin
            if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
              THeroObject(BaseObject).SendDelItems(@BaseObject.m_UseItems[I]);
            end;
          end;
          BaseObject.m_UseItems[I].wIndex := 0;
          Dec(nItemCount);
        end;
      end;
    end;
  end;

  procedure MovData(QuestActionInfo: pTQuestActionInfo);
  var
    VarInfo1: TVarInfo;
    VarInfo2: TVarInfo;

    sVar1, sValue1: string;
    nValue1: Integer;

    sVar2, sValue2: string;
    nValue2: Integer;
    AObject: TPlayObject;
  begin
    if QuestActionInfo.sParam1 = '' then begin
      ScriptActionError(BaseObject, '', QuestActionInfo, sMOV);
      Exit;
    end;
    AObject := nil;
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      AObject := TPlayObject(BaseObject.m_Master);
    end else
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      AObject := TPlayObject(BaseObject);
    end;
    if AObject = nil then Exit;
    VarInfo1 := GetVarValue(AObject, QuestActionInfo.sParam1, sVar1, sValue1, nValue1);
    VarInfo2 := GetVarValue(AObject, QuestActionInfo.sParam2, sVar2, sValue2, nValue2);
    case VarInfo1.VarAttr of
      aNone, aConst: begin
          ScriptActionError(AObject, '', QuestActionInfo, sMOV);
        end;
      aFixStr: begin
          SetValNameValue(AObject, sVar1, sValue2, nValue2);
        end;
      aDynamic: begin
          SetDynamicValue(AObject, sVar1, sValue2, nValue2);
        end;
    end;
  end;

  procedure IncData(QuestActionInfo: pTQuestActionInfo);
  var
    VarInfo1: TVarInfo;
    VarInfo2: TVarInfo;

    sVar1, sValue1: string;
    nValue1: Integer;

    sVar2, sValue2: string;
    nValue2: Integer;
    AObject: TPlayObject;
  begin
    if QuestActionInfo.sParam1 = '' then begin
      ScriptActionError(BaseObject, '', QuestActionInfo, sINC);
      Exit;
    end;
    AObject := nil;
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      AObject := TPlayObject(BaseObject.m_Master);
    end else
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      AObject := TPlayObject(BaseObject);
    end;
    if AObject = nil then Exit;

    VarInfo1 := GetVarValue(AObject, QuestActionInfo.sParam1, sVar1, sValue1, nValue1);
    VarInfo2 := GetVarValue(AObject, QuestActionInfo.sParam2, sVar2, sValue2, nValue2);
    //MainOutMessage(Format('(1) sValue1:%s sValue2:%s nValue1:%d nValue2:%d',[sValue1,sValue2,nValue1,nValue2]));
    case VarInfo1.VarAttr of
      aNone, aConst: begin
          ScriptActionError(AObject, '', QuestActionInfo, sINC);
        end;
      aFixStr: begin
          SetValNameValue(AObject, sVar1, sValue1 + sValue2, nValue1 + nValue2);
          //MainOutMessage(Format('(2) sValue1:%s sValue2:%s',[sValue1,sValue2]));
        end;
      aDynamic: begin
          SetDynamicValue(AObject, sVar1, sValue2 + sValue2, nValue1 + nValue2);
        end;
    end;
  end;

  procedure DecData(QuestActionInfo: pTQuestActionInfo);
  var
    VarInfo1: TVarInfo;
    VarInfo2: TVarInfo;

    sVar1, sValue1: string;
    nValue1: Integer;

    sVar2, sValue2: string;
    nValue2: Integer;

    AObject: TPlayObject;
  begin
    if QuestActionInfo.sParam1 = '' then begin
      ScriptActionError(BaseObject, '', QuestActionInfo, sDEC);
      Exit;
    end;
    AObject := nil;
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      AObject := TPlayObject(BaseObject.m_Master);
    end else
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      AObject := TPlayObject(BaseObject);
    end;
    if AObject = nil then Exit;
    VarInfo1 := GetVarValue(AObject, QuestActionInfo.sParam1, sVar1, sValue1, nValue1);
    VarInfo2 := GetVarValue(AObject, QuestActionInfo.sParam2, sVar2, sValue2, nValue2);

    //MainOutMessage('nValue1:'+IntToStr(nValue1));
    //MainOutMessage('nValue2:'+IntToStr(nValue2));
    case VarInfo1.VarAttr of
      aNone, aConst: begin
          ScriptActionError(AObject, '', QuestActionInfo, sDEC);
        end;
      aFixStr: begin
          SetValNameValue(AObject, sVar1, sValue1, nValue1 - nValue2);
        end;
      aDynamic: begin
          SetDynamicValue(AObject, sVar1, sValue2, nValue1 - nValue2);
        end;
    end;
  end;

  procedure DivData(QuestActionInfo: pTQuestActionInfo);
  var
    VarInfo1: TVarInfo;
    VarInfo2: TVarInfo;

    sVar1, sValue1: string;
    nValue1: Integer;

    sVar2, sValue2: string;
    nValue2: Integer;

    AObject: TPlayObject;
  begin
    if QuestActionInfo.sParam1 = '' then begin
      ScriptActionError(BaseObject, '', QuestActionInfo, sSC_DIV);
      Exit;
    end;
    AObject := nil;
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      AObject := TPlayObject(BaseObject.m_Master);
    end else
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      AObject := TPlayObject(BaseObject);
    end;
    if AObject = nil then Exit;
    VarInfo1 := GetVarValue(AObject, QuestActionInfo.sParam1, sVar1, sValue1, nValue1);
    VarInfo2 := GetVarValue(AObject, QuestActionInfo.sParam2, sVar2, sValue2, nValue2);

    case VarInfo1.VarAttr of
      aNone, aConst: begin
          ScriptActionError(AObject, '', QuestActionInfo, sSC_DIV);
        end;
      aFixStr: begin
          if nValue2 <> 0 then
            SetValNameValue(AObject, sVar1, sValue1, nValue1 div nValue2);
        end;
      aDynamic: begin
          if nValue2 <> 0 then
            SetDynamicValue(AObject, sVar1, sValue2, nValue1 div nValue2);
        end;
    end;
  end;

  procedure MulData(QuestActionInfo: pTQuestActionInfo);
  var
    VarInfo1: TVarInfo;
    VarInfo2: TVarInfo;

    sVar1, sValue1: string;
    nValue1: Integer;

    sVar2, sValue2: string;
    nValue2: Integer;

    AObject: TPlayObject;
  begin
    if QuestActionInfo.sParam1 = '' then begin
      ScriptActionError(BaseObject, '', QuestActionInfo, sSC_MUL);
      Exit;
    end;
    AObject := nil;
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      AObject := TPlayObject(BaseObject.m_Master);
    end else
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      AObject := TPlayObject(BaseObject);
    end;
    if AObject = nil then Exit;
    VarInfo1 := GetVarValue(AObject, QuestActionInfo.sParam1, sVar1, sValue1, nValue1);
    VarInfo2 := GetVarValue(AObject, QuestActionInfo.sParam2, sVar2, sValue2, nValue2);

    case VarInfo1.VarAttr of
      aNone, aConst: begin
          ScriptActionError(AObject, '', QuestActionInfo, sSC_MUL);
          Exit;
        end;
      aFixStr: begin
          SetValNameValue(AObject, sVar1, sValue1, nValue1 * nValue2);
        end;
      aDynamic: begin
          SetDynamicValue(AObject, sVar1, sValue2, nValue1 * nValue2);
        end;
    end;
  end;

  function QuestActionProcess(ActionList: TList): Boolean;
  var
    I, II, III: Integer;
    QuestActionInfo: pTQuestActionInfo;
    n14, n18, n1C, n28, n2C: Integer;
    n20X, n24Y, n34, n38, n3C, n40: Integer;
    s4C, s50: string;
    s34, s44, s48: string;
    Envir: TEnvirnoment;
    List58: TList;
    User: TPlayObject;
    DynamicVar: pTDynamicVar;
    DynamicVarList: TList;
    sName: string;
    OnlinePlayObject: TPlayObject;
    GuildRank: pTGuildRank;
    UserObject: TPlayObject;

    sVar1, sValue1: string;
    nValue1: Integer;
    VarInfo1: TVarInfo;

    sVar2, sValue2: string;
    nValue2: Integer;
    VarInfo2: TVarInfo;
  begin
    Result := True;
    n18 := 0;
    n34 := 0;
    n38 := 0;
    n3C := 0;
    n40 := 0;
    for I := 0 to ActionList.Count - 1 do begin
      QuestActionInfo := ActionList.Items[I];
      BaseObject := QuestActionInfo.Script.GetActorObject(Self, AObject); //转换运行对象
      if BaseObject = nil then begin
        Result := False;
        Break;
      end else begin
        if BaseObject.m_btRaceServer = RC_PLAYOBJECT then
          PlayObject := TPlayObject(BaseObject) else PlayObject := nil;
      end;

      case QuestActionInfo.nCMDCode of
        nSET: begin
            n28 := Str_ToInt(QuestActionInfo.sParam1, 0);
            n2C := Str_ToInt(QuestActionInfo.sParam2, 0);
            BaseObject.SetQuestFlagStatus(n28, n2C);
          end;
        nTAKE: begin
            TakeItem(QuestActionInfo.sParam1, QuestActionInfo.nParam2, QuestActionInfo.sParam2);
          end;
        //nGIVE: GiveItem(QuestActionInfo.sParam1,QuestActionInfo.nParam2);
        nSC_GIVE: ActionOfGiveItem(BaseObject, QuestActionInfo);
        nSC_GIVEEX: ActionOfGiveExItem(BaseObject, QuestActionInfo);
        nTAKEW: begin
            s4C := QuestActionInfo.sParam1;
            n14 := QuestActionInfo.nParam2;
            if IsPlayObject then begin
              s4C := QuestActionInfo.sParam1;
              GetVarValue(PlayObject, QuestActionInfo.sParam1, s4C);
              n14 := QuestActionInfo.nParam2;
              GetVarValue(PlayObject, QuestActionInfo.sParam2, n14);
            end;
            TakeWItem(s4C, n14);
          end;
        nCLOSE: if IsPlayObject then PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self), 0, 0, '');
        nRESET: begin
            if IsPlayObject then begin
              for II := 0 to QuestActionInfo.nParam2 - 1 do begin
                PlayObject.SetQuestFlagStatus(QuestActionInfo.nParam1 + II, 0);
              end;
            end;
          end;
        nBREAK: Result := False;
        nTIMERECALL: begin
            if IsPlayObject then begin
              PlayObject.m_boTimeRecall := True;
              PlayObject.m_sMoveMap := PlayObject.m_sMapName;
              PlayObject.m_nMoveX := PlayObject.m_nCurrX;
              PlayObject.m_nMoveY := PlayObject.m_nCurrY;
              PlayObject.m_dwTimeRecallTick := GetTickCount + LongWord(QuestActionInfo.nParam1 * 60 * 1000);
            end;
          end;
        nSC_PARAM1: begin
            n34 := QuestActionInfo.nParam1;
            s44 := QuestActionInfo.sParam1;
            if IsPlayObject then begin
              GetVarValue(PlayObject, QuestActionInfo.sParam1, s44);
              GetVarValue(PlayObject, QuestActionInfo.sParam1, n34);
            end;
          end;
        nSC_PARAM2: begin
            n38 := QuestActionInfo.nParam1;
            s48 := QuestActionInfo.sParam1;
            if IsPlayObject then begin
              GetVarValue(PlayObject, QuestActionInfo.sParam1, s48);
              GetVarValue(PlayObject, QuestActionInfo.sParam1, n38);
            end;
          end;
        nSC_PARAM3: begin
            n3C := QuestActionInfo.nParam1;
            s4C := QuestActionInfo.sParam1;
            if IsPlayObject then begin
              GetVarValue(PlayObject, QuestActionInfo.sParam1, s4C);
              GetVarValue(PlayObject, QuestActionInfo.sParam1, n3C);
            end;
          end;
        nSC_PARAM4: begin
            n40 := QuestActionInfo.nParam1;
            s50 := QuestActionInfo.sParam1;
            if IsPlayObject then begin
              GetVarValue(PlayObject, QuestActionInfo.sParam1, s50);
              GetVarValue(PlayObject, QuestActionInfo.sParam1, n40);
            end;
          end;
        nSC_EXEACTION: begin
            n40 := QuestActionInfo.nParam1;
            s50 := QuestActionInfo.sParam1;
            ExeAction(BaseObject, QuestActionInfo.sParam1, QuestActionInfo.sParam2, QuestActionInfo.sParam3, QuestActionInfo.nParam1, QuestActionInfo.nParam2, QuestActionInfo.nParam3);
          end;
        nMAPMOVE: begin
            s4C := QuestActionInfo.sParam1;
            n14 := QuestActionInfo.nParam2;
            n40 := QuestActionInfo.nParam3;
            n18 := Str_ToInt(QuestActionInfo.sParam4, 0);
            if IsPlayObject then begin
              s4C := QuestActionInfo.sParam1;
              n14 := Str_ToInt(QuestActionInfo.sParam2, -1);
              n40 := Str_ToInt(QuestActionInfo.sParam3, -1);

              if g_MapManager.FindMap(s4C) = nil then
                GetVarValue(PlayObject, QuestActionInfo.sParam1, s4C);
              if n14 < 0 then
                GetVarValue(PlayObject, QuestActionInfo.sParam2, n14);
              if n40 < 0 then
                GetVarValue(PlayObject, QuestActionInfo.sParam3, n40);
            end;
            BaseObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
            if n18 > 0 then begin
              n14 := n14 + (Random(n18 * 2) - n18);
              n40 := n40 + (Random(n18 * 2) - n18);
            end;

            {if s4C = '0' then begin
              MainOutMessage('MAPMOVE '+QuestActionInfo.sParam1 + ' ' + QuestActionInfo.sParam2 + ' ' + QuestActionInfo.sParam3 + ' ' + QuestActionInfo.sParam4);
            end;}

            BaseObject.SpaceMove(s4C, n14, n40, 0);
            bo11 := True;
          end;
        nMAP: begin
            s4C := QuestActionInfo.sParam1;
            if g_MapManager.FindMap(s4C) = nil then begin
              if IsPlayObject then begin
                s4C := QuestActionInfo.sParam1;
                GetVarValue(PlayObject, QuestActionInfo.sParam1, s4C);
              end;
            end;
            {if s4C = '0' then begin
              MainOutMessage('MAP '+QuestActionInfo.sParam1 + ' ' + QuestActionInfo.sParam2 + ' ' + QuestActionInfo.sParam3 + ' ' + QuestActionInfo.sParam4);
            end;}
            BaseObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
            BaseObject.MapRandomMove(s4C, 0);
            bo11 := True;
          end;
        nTAKECHECKITEM: begin
            if IsPlayObject then begin
              if UserItem <> nil then begin
                PlayObject.QuestTakeCheckItem(UserItem);
              end else begin
                ScriptActionError(PlayObject, '', QuestActionInfo, sTAKECHECKITEM);
              end;
            end;
          end;
        nMONGEN: begin
            if s44 = 'SELF' then s44 := BaseObject.m_PEnvir.sMapName
            else
              if IsPlayObject then begin
              if g_MapManager.FindMap(s44) = nil then begin
                s44 := GetLineVariableText(PlayObject, s44);
                //GetVarValue(PlayObject, QuestActionInfo.sParam1, s44);
                GetVarValue(PlayObject, s44, s44);
              end;
            end;

            n40 := Str_ToInt(QuestActionInfo.sParam2, -1);
            n34 := Str_ToInt(QuestActionInfo.sParam3, -1);
            s50 := QuestActionInfo.sParam1;

            if IsPlayObject then begin
              GetVarValue(PlayObject, s50, s50);
              if n40 < 0 then
                GetVarValue(PlayObject, QuestActionInfo.sParam2, n40);
              if n34 < 0 then
                GetVarValue(PlayObject, QuestActionInfo.sParam3, n34);
            end;

            for II := 0 to n40 - 1 do begin
              n20X := Random(n34 * 2 + 1) + (n38 - n34);
              n24Y := Random(n34 * 2 + 1) + (n3C - n34);
              UserEngine.RegenMonsterByName(nil, s44, n20X, n24Y, s50);
            end;
          end;
        nMONCLEAR: begin
            List58 := TList.Create;
            UserEngine.GetMapMonster(g_MapManager.FindMap(QuestActionInfo.sParam1), List58);
            for II := 0 to List58.Count - 1 do begin
              TActorObject(List58.Items[II]).m_boNoItem := True;
              TActorObject(List58.Items[II]).m_WAbil.HP := 0;
            end;
            List58.Free;
          end;
        nMOV: {if IsPlayObject then } MovData(QuestActionInfo);
        nINC: {if IsPlayObject then } IncData(QuestActionInfo);
        nDEC: {if IsPlayObject then } DecData(QuestActionInfo);
        nSC_DIV: {if IsPlayObject then } DivData(QuestActionInfo);
        nSC_MUL: {if IsPlayObject then } MulData(QuestActionInfo);

        //nSUM: SumData(QuestActionInfo);
        nBREAKTIMERECALL: if IsPlayObject then PlayObject.m_boTimeRecall := False;

        nCHANGEMODE: begin
            if IsPlayObject then begin
              case QuestActionInfo.nParam1 of
                1: PlayObject.CmdChangeAdminMode('', 10, '', Str_ToInt(QuestActionInfo.sParam2, 0) = 1);
                2: PlayObject.CmdChangeSuperManMode('', 10, '', Str_ToInt(QuestActionInfo.sParam2, 0) = 1);
                3: PlayObject.CmdChangeObMode('', 10, '', Str_ToInt(QuestActionInfo.sParam2, 0) = 1);
              else begin
                  ScriptActionError(PlayObject, '', QuestActionInfo, sCHANGEMODE);
                end;
              end;
            end;
          end;
        nPKPOINT: begin
            n14 := Str_ToInt(QuestActionInfo.sParam1, 0);
            if IsPlayObject then begin

              GetVarValue(PlayObject, QuestActionInfo.sParam1, n14);
            end;
            if n14 = 0 then begin
              BaseObject.m_nPkPoint := 0;
            end else begin
              if n14 < 0 then begin
                if (BaseObject.m_nPkPoint + n14) >= 0 then begin
                  Inc(BaseObject.m_nPkPoint, n14);
                end else BaseObject.m_nPkPoint := 0;
              end else begin
                if (BaseObject.m_nPkPoint + n14) > 10000 then begin
                  BaseObject.m_nPkPoint := 10000;
                end else begin
                  Inc(BaseObject.m_nPkPoint, n14);
                end;
              end;
            end;
            BaseObject.RefNameColor();
          end;
        nCHANGEXP: begin

          end;
        nSC_RECALLMOB: ActionOfRecallmob(BaseObject, QuestActionInfo);
        {
        nSC_RECALLMOB: begin
          if QuestActionInfo.nParam3 <= 1 then begin
            PlayObject.MakeSlave(QuestActionInfo.sParam1,3,Str_ToInt(QuestActionInfo.sParam2,0),100,10 * 24 * 60 * 60);
          end else begin
            PlayObject.MakeSlave(QuestActionInfo.sParam1,3,Str_ToInt(QuestActionInfo.sParam2,0),100,QuestActionInfo.nParam3 * 60)
          end;
        end;
        }
        nKICK: begin
            if IsPlayObject then begin
              PlayObject.m_boReconnection := True;
              PlayObject.m_boSoftClose := True;
              PlayObject.m_boPlayOffLine := False;
              PlayObject.m_boNotOnlineAddExp := False;
            end;
          end;
        nMOVR: begin
            Randomize;
            //if IsPlayObject then begin
            if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
              VarInfo1 := GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam1, sVar1, sValue1, nValue1);
              VarInfo2 := GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam2, sVar2, sValue2, nValue2);
              case VarInfo1.VarAttr of
                aNone, aConst: begin
                    ScriptActionError(TPlayObject(BaseObject), '', QuestActionInfo, sMOVR);
                    //Exit;
                  end;
                aFixStr: SetValNameValue(TPlayObject(BaseObject), sVar1, sValue1, Random(nValue2));
                aDynamic: SetDynamicValue(TPlayObject(BaseObject), sVar1, sValue1, Random(nValue2));
              end;
            end else
              if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
              VarInfo1 := GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam1, sVar1, sValue1, nValue1);
              VarInfo2 := GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam2, sVar2, sValue2, nValue2);
              case VarInfo1.VarAttr of
                aNone, aConst: begin
                    ScriptActionError(TPlayObject(BaseObject.m_Master), '', QuestActionInfo, sMOVR);
                    //Exit;
                  end;
                aFixStr: SetValNameValue(TPlayObject(BaseObject.m_Master), sVar1, sValue1, Random(nValue2));
                aDynamic: SetDynamicValue(TPlayObject(BaseObject.m_Master), sVar1, sValue1, Random(nValue2));
              end;
            end;
          end;

        nEXCHANGEMAP: begin
            s4C := QuestActionInfo.sParam1;
            Envir := g_MapManager.FindMap(s4C);
            if Envir = nil then begin
              if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin

                GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam1, s4C);
              end else
                if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam1, s4C);
              end;
            end;

            if Envir = nil then
              Envir := g_MapManager.FindMap(s4C);
            if Envir <> nil then begin
              List58 := TList.Create;
              UserEngine.GetMapRageHuman(Envir, 0, 0, 1000, List58);
              if List58.Count > 0 then begin
                User := TPlayObject(List58.Items[0]);
                User.MapRandomMove(Self.m_sMapName, 0);
              end;
              List58.Free;
              BaseObject.MapRandomMove(s4C, 0);
            end else begin
              ScriptActionError(BaseObject, '', QuestActionInfo, sEXCHANGEMAP);
            end;
          end;
        nRECALLMAP: begin
            s4C := QuestActionInfo.sParam1;
            Envir := g_MapManager.FindMap(s4C);
            if Envir = nil then begin
              if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam1, s4C);
              end else
                if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam1, s4C);
              end;
            end;
            if Envir = nil then
              Envir := g_MapManager.FindMap(s4C);
            if Envir <> nil then begin
              List58 := TList.Create;
              UserEngine.GetMapRageHuman(Envir, 0, 0, 1000, List58);
              for II := 0 to List58.Count - 1 do begin
                User := TPlayObject(List58.Items[II]);
                User.MapRandomMove(Self.m_sMapName, 0);
                if II > 20 then Break;
              end;
              List58.Free;
            end else begin
              ScriptActionError(BaseObject, '', QuestActionInfo, sRECALLMAP);
            end;
          end;
        nADDBATCH: if IsPlayObject then List1C.AddObject(QuestActionInfo.sParam1, TObject(n18));
        nBATCHDELAY: n18 := QuestActionInfo.nParam1 * 1000;
        nBATCHMOVE: begin
            if IsPlayObject then begin
              for II := 0 to List1C.Count - 1 do begin
                PlayObject.SendDelayMsg(Self, RM_10155, 0, 0, 0, 0, List1C.Strings[II], Integer(List1C.Objects[II]) + n20);
                Inc(n20, Integer(List1C.Objects[II]));
              end;
            end;
          end;

        nPLAYDICE: begin
            if IsPlayObject then begin
              PlayObject.m_sPlayDiceLabel := QuestActionInfo.sParam2;
              PlayObject.SendMsg(Self,
                RM_PLAYDICE,
                QuestActionInfo.nParam1,
                MakeLong(MakeWord(PlayObject.m_DyVal[0], PlayObject.m_DyVal[1]), MakeWord(PlayObject.m_DyVal[2], PlayObject.m_DyVal[3])),
                MakeLong(MakeWord(PlayObject.m_DyVal[4], PlayObject.m_DyVal[5]), MakeWord(PlayObject.m_DyVal[6], PlayObject.m_DyVal[7])),
                MakeLong(MakeWord(PlayObject.m_DyVal[8], PlayObject.m_DyVal[9]), 0),
                QuestActionInfo.sParam2);
              bo11 := True;
            end;
          end;

        nADDNAMELIST: AddList(BaseObject.m_sCharName, m_sPath + QuestActionInfo.sParam1);
        nDELNAMELIST: DelList(BaseObject.m_sCharName, m_sPath + QuestActionInfo.sParam1);
        nADDGUILDLIST: if IsPlayObject and (PlayObject.m_MyGuild <> nil) then AddList(TGUild(PlayObject.m_MyGuild).sGuildName, m_sPath + QuestActionInfo.sParam1);
        nDELGUILDLIST: if IsPlayObject and (PlayObject.m_MyGuild <> nil) then DelList(TGUild(PlayObject.m_MyGuild).sGuildName, m_sPath + QuestActionInfo.sParam1);
        nSC_LINEMSG, nSENDMSG: if IsPlayObject then ActionOfLineMsg(PlayObject, QuestActionInfo);

        nADDACCOUNTLIST: if IsPlayObject then AddList(PlayObject.m_sUserID, m_sPath + QuestActionInfo.sParam1);
        nDELACCOUNTLIST: if IsPlayObject then DelList(PlayObject.m_sUserID, m_sPath + QuestActionInfo.sParam1);
        nADDIPLIST: if IsPlayObject then AddList(PlayObject.m_sIPaddr, m_sPath + QuestActionInfo.sParam1);
        nDELIPLIST: if IsPlayObject then DelList(PlayObject.m_sIPaddr, m_sPath + QuestActionInfo.sParam1);
        nGOQUEST: GoToQuest(QuestActionInfo.nParam1);
        nENDQUEST: PlayObject.m_Script := nil;
        nGOTO: begin
            s4C := QuestActionInfo.sParam1;
            if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
              GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam1, s4C);
            end;
            if not JmpToLable(s4C) then begin
              //ScriptActionError(PlayObject,'',QuestActionInfo,sGOTO);
              MainOutMessage('[Script Loop] NPC:' + m_sCharName +
                ' Location:' + m_sMapName + '(' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) + ')' +
                ' Command:' + sGOTO + ' ' + QuestActionInfo.sParam1);
              Result := False;
              Exit;
            end;
          end;

        nSC_HAIRCOLOR: ;
        nSC_WEARCOLOR: ;
        nSC_HAIRSTYLE: ActionOfChangeHairStyle(BaseObject, QuestActionInfo);
        nSC_MONRECALL: ;
        nSC_HORSECALL: ;
        nSC_HAIRRNDCOL: ;
        nSC_KILLHORSE: ;
        nSC_RANDSETDAILYQUEST: ;

        nSC_RECALLGROUPMEMBERS: if IsPlayObject then ActionOfRecallGroupMembers(PlayObject, QuestActionInfo);
        nSC_CLEARNAMELIST: ActionOfClearNameList(BaseObject, QuestActionInfo);
        nSC_MAPTING: ActionOfMapTing(BaseObject, QuestActionInfo);
        nSC_CHANGELEVEL: ActionOfChangeLevel(BaseObject, QuestActionInfo);
        nSC_MARRY: if IsPlayObject then ActionOfMarry(PlayObject, QuestActionInfo);
        nSC_MASTER: if IsPlayObject then ActionOfMaster(PlayObject, QuestActionInfo);
        nSC_UNMASTER: if IsPlayObject then ActionOfUnMaster(PlayObject, QuestActionInfo);
        nSC_UNMARRY: if IsPlayObject then ActionOfUnMarry(PlayObject, QuestActionInfo);
        nSC_GETMARRY: if IsPlayObject then ActionOfGetMarry(PlayObject, QuestActionInfo);
        nSC_GETMASTER: if IsPlayObject then ActionOfGetMaster(PlayObject, QuestActionInfo);
        nSC_CLEARSKILL: ActionOfClearSkill(BaseObject, QuestActionInfo);
        nSC_DELNOJOBSKILL: ActionOfDelNoJobSkill(BaseObject, QuestActionInfo);
        nSC_DELSKILL: ActionOfDelSkill(BaseObject, QuestActionInfo);
        nSC_ADDSKILL: ActionOfAddSkill(BaseObject, QuestActionInfo);
        nSC_SKILLLEVEL: ActionOfSkillLevel(BaseObject, QuestActionInfo);
        nSC_CHANGEPKPOINT: ActionOfChangePkPoint(BaseObject, QuestActionInfo);
        nSC_CHANGEEXP: ActionOfChangeExp(BaseObject, QuestActionInfo);
        nSC_CHANGEJOB: ActionOfChangeJob(BaseObject, QuestActionInfo);
        nSC_MISSION: ActionOfMission(BaseObject, QuestActionInfo);
        nSC_MOBPLACE: ActionOfMobPlace(PlayObject, QuestActionInfo, n34, n38, n3C, n40);
        nSC_SETMEMBERTYPE: if IsPlayObject then ActionOfSetMemberType(PlayObject, QuestActionInfo);
        nSC_SETMEMBERLEVEL: if IsPlayObject then ActionOfSetMemberLevel(PlayObject, QuestActionInfo);
        //        nSC_SETMEMBERTYPE:   PlayObject.m_nMemberType:=Str_ToInt(QuestActionInfo.sParam1,0);
        //        nSC_SETMEMBERLEVEL:  PlayObject.m_nMemberType:=Str_ToInt(QuestActionInfo.sParam1,0);
        nSC_GAMEGOLD: if IsPlayObject then ActionOfGameGold(PlayObject, QuestActionInfo);
        nSC_GAMEPOINT: if IsPlayObject then ActionOfGamePoint(PlayObject, QuestActionInfo);
        nSC_AUTOADDGAMEGOLD: if IsPlayObject then ActionOfAutoAddGameGold(PlayObject, QuestActionInfo, n34, n38);
        nSC_AUTOSUBGAMEGOLD: if IsPlayObject then ActionOfAutoSubGameGold(PlayObject, QuestActionInfo, n34, n38);
        nSC_CHANGENAMECOLOR: ActionOfChangeNameColor(BaseObject, QuestActionInfo);
        nSC_CLEARPASSWORD: if IsPlayObject then ActionOfClearPassword(PlayObject, QuestActionInfo);
        nSC_RENEWLEVEL: if IsPlayObject then ActionOfReNewLevel(PlayObject, QuestActionInfo);
        nSC_KILLSLAVE: ActionOfKillSlave(BaseObject, QuestActionInfo);
        nSC_CHANGEGENDER: ActionOfChangeGender(BaseObject, QuestActionInfo);
        nSC_KILLMONEXPRATE: ActionOfKillMonExpRate(BaseObject, QuestActionInfo);
        nSC_POWERRATE: ActionOfPowerRate(BaseObject, QuestActionInfo);
        nSC_CHANGEMODE: ActionOfChangeMode(BaseObject, QuestActionInfo);
        nSC_CHANGEPERMISSION: ActionOfChangePerMission(BaseObject, QuestActionInfo);
        nSC_KILL: ActionOfKill(BaseObject, QuestActionInfo);
        nSC_KICK: if IsPlayObject then ActionOfKick(PlayObject, QuestActionInfo);
        nSC_KICKALL: ActionOfKickAll(BaseObject, QuestActionInfo);
        nSC_BONUSPOINT: if IsPlayObject then ActionOfBonusPoint(PlayObject, QuestActionInfo);
        nSC_RESTRENEWLEVEL: if IsPlayObject then ActionOfRestReNewLevel(PlayObject, QuestActionInfo);
        nSC_DELMARRY: if IsPlayObject then ActionOfDelMarry(PlayObject, QuestActionInfo);
        nSC_DELMASTER: if IsPlayObject then ActionOfDelMaster(PlayObject, QuestActionInfo);
        nSC_CREDITPOINT: if IsPlayObject then ActionOfChangeCreditPoint(PlayObject, QuestActionInfo);
        nSC_CLEARNEEDITEMS: ActionOfClearNeedItems(BaseObject, QuestActionInfo);
        nSC_CLEARMAEKITEMS: ActionOfClearMakeItems(BaseObject, QuestActionInfo);
        nSC_SETSENDMSGFLAG: if IsPlayObject then PlayObject.m_boSendMsgFlag := True;
        nSC_UPGRADEITEMS: if IsPlayObject then ActionOfUpgradeItems(PlayObject, QuestActionInfo);
        nSC_UPGRADEITEMSEX: if IsPlayObject then ActionOfUpgradeItemsEx(PlayObject, QuestActionInfo);
        nSC_MONGENEX: ActionOfMonGenEx(BaseObject, QuestActionInfo);
        nSC_CLEARMAPMON: ActionOfClearMapMon(BaseObject, QuestActionInfo);
        nSC_SETMAPMODE: ActionOfSetMapMode(BaseObject, QuestActionInfo);
        nSC_PKZONE: ActionOfPkZone(BaseObject, QuestActionInfo);
        nSC_RESTBONUSPOINT: if IsPlayObject then ActionOfRestBonusPoint(PlayObject, QuestActionInfo);
        nSC_TAKECASTLEGOLD: if IsPlayObject then ActionOfTakeCastleGold(PlayObject, QuestActionInfo);
        nSC_HUMANHP: ActionOfHumanHP(BaseObject, QuestActionInfo);
        nSC_HUMANMP: ActionOfHumanMP(BaseObject, QuestActionInfo);
        nSC_BUILDPOINT: if IsPlayObject then ActionOfGuildBuildPoint(PlayObject, QuestActionInfo);
        nSC_AURAEPOINT: if IsPlayObject then ActionOfGuildAuraePoint(PlayObject, QuestActionInfo);
        nSC_STABILITYPOINT: if IsPlayObject then ActionOfGuildstabilityPoint(PlayObject, QuestActionInfo);
        nSC_FLOURISHPOINT: if IsPlayObject then ActionOfGuildFlourishPoint(PlayObject, QuestActionInfo);
        nSC_OPENMAGICBOX: if IsPlayObject then ActionOfOpenMagicBox(PlayObject, QuestActionInfo);
        nSC_SETRANKLEVELNAME: if IsPlayObject then ActionOfSetRankLevelName(PlayObject, QuestActionInfo);
        nSC_GMEXECUTE: if IsPlayObject then ActionOfGmExecute(PlayObject, QuestActionInfo);
        nSC_GUILDCHIEFITEMCOUNT: if IsPlayObject then ActionOfGuildChiefItemCount(PlayObject, QuestActionInfo);
        nSC_ADDNAMEDATELIST, nSC_ADDUSERDATE: ActionOfAddNameDateList(BaseObject, QuestActionInfo);
        nSC_DELNAMEDATELIST, nSC_DELUSERDATE: ActionOfDelNameDateList(BaseObject, QuestActionInfo);
        nSC_MOBFIREBURN: ActionOfMobFireBurn(BaseObject, QuestActionInfo);
        nSC_MESSAGEBOX: if IsPlayObject then ActionOfMessageBox(PlayObject, QuestActionInfo);
        nSC_SETSCRIPTFLAG: if IsPlayObject then ActionOfSetScriptFlag(PlayObject, QuestActionInfo);
        nSC_SETAUTOGETEXP: if IsPlayObject then ActionOfAutoGetExp(PlayObject, QuestActionInfo);
        nSC_VAR: if IsPlayObject then ActionOfVar(PlayObject, QuestActionInfo);
        nSC_LOADVAR: if IsPlayObject then ActionOfLoadVar(PlayObject, QuestActionInfo);
        nSC_SAVEVAR: if IsPlayObject then ActionOfSaveVar(PlayObject, QuestActionInfo);
        nSC_CALCVAR: if IsPlayObject then ActionOfCalcVar(PlayObject, QuestActionInfo);
        nSC_ACTVARLIST: if IsPlayObject then ActionOfActVarList(PlayObject, QuestActionInfo);

        nOFFLINEPLAY: if IsPlayObject then ActionOfNotLineAddPiont(PlayObject, QuestActionInfo);
        nKICKOFFLINE: if IsPlayObject then ActionOfKickNotLineAddPiont(PlayObject, QuestActionInfo);
        nSTARTTAKEGOLD: if IsPlayObject then ActionOfStartTakeGold(PlayObject);
        nSC_DELAYGOTO: if IsPlayObject then ActionOfDelayGoto(PlayObject, QuestActionInfo);
        nCLEARDELAYGOTO: if IsPlayObject then PlayObject.ClearTimeLabel(Str_ToInt(QuestActionInfo.sParam1, 0));

        nSC_SETSCTIMER: if IsPlayObject then ActionOfSetScTimer(PlayObject, QuestActionInfo);
        nSC_KILLSCTIMER: if IsPlayObject then ActionOfKillScTimer(PlayObject, QuestActionInfo);
        nSC_PLAYSOUND: if IsPlayObject then ActionOfPlaySound(PlayObject, QuestActionInfo);
        nSC_SHOWEFFECT: if IsPlayObject then ActionOfShowEffect(PlayObject, QuestActionInfo);
        nSC_CHANGEITEMVALUE: if IsPlayObject then ActionOfChangeItemValue(PlayObject, QuestActionInfo);

        nCHANGERECOMMENDGAMEGOLD: if IsPlayObject then ActionOfCommendGameGold(PlayObject, QuestActionInfo);
        nSC_ANSIREPLACETEXT: if IsPlayObject then ActionOfAnsiReplaceText(PlayObject, QuestActionInfo);
        nSC_ENCODETEXT: if IsPlayObject then ActionOfEncodeText(PlayObject, QuestActionInfo);
        nSC_DECODETEXT: if IsPlayObject then ActionOfDecodeText(PlayObject, QuestActionInfo);
        nSC_ADDTEXTLIST: begin
            if IsPlayObject then begin
              s4C := GetLineVariableText(PlayObject, QuestActionInfo.sParam1);
              GetVarValue(PlayObject, s4C, s4C);
            end;
            AddList(s4C, m_sPath + QuestActionInfo.sParam2);
          end;
        nSC_DELTEXTLIST: begin
            if IsPlayObject then begin
              s4C := GetLineVariableText(PlayObject, QuestActionInfo.sParam1);
              GetVarValue(PlayObject, s4C, s4C);
            end;
            DelList(s4C, m_sPath + QuestActionInfo.sParam2);
          end;
        nSC_GROUPMOVE: begin
            if IsPlayObject then begin
              s4C := QuestActionInfo.sParam1;
              if g_MapManager.FindMap(s4C) = nil then
                GetVarValue(PlayObject, QuestActionInfo.sParam1, s4C);

              if (PlayObject.m_GroupOwner <> nil) and (PlayObject = PlayObject.m_GroupOwner) then begin
                for II := 0 to PlayObject.m_GroupOwner.m_GroupMembers.Count - 1 do begin
                  if (not TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]).m_boDeath) and
                    (not TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]).m_boGhost) { and (TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]).m_boAllowGroupReCall) } then begin
                    TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]).MapRandomMove(s4C, 0);
                  end;
                end;
                PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
                PlayObject.MapRandomMove(s4C, 0);
                bo11 := True;
              end;
            end;
          end;
        nSC_GROUPMAPMOVE: begin
            if IsPlayObject then begin
              s4C := QuestActionInfo.sParam1;
              n14 := Str_ToInt(QuestActionInfo.sParam2, -1);
              n40 := Str_ToInt(QuestActionInfo.sParam3, -1);

              if g_MapManager.FindMap(s4C) = nil then
                GetVarValue(PlayObject, QuestActionInfo.sParam1, s4C);
              if n14 < 0 then
                GetVarValue(PlayObject, QuestActionInfo.sParam2, n14);
              if n40 < 0 then
                GetVarValue(PlayObject, QuestActionInfo.sParam3, n40);

              if (PlayObject.m_GroupOwner <> nil) and (PlayObject = PlayObject.m_GroupOwner) then begin
                for II := 0 to PlayObject.m_GroupOwner.m_GroupMembers.Count - 1 do begin
                  if (not TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]).m_boDeath) and
                    (not TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]).m_boGhost) { and (TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]).m_boAllowGroupReCall) } then begin
                    TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]).SpaceMove(s4C, n14, n40, 0);
                  end;
                end;
                PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
                PlayObject.SpaceMove(s4C, n14, n40, 0);
                bo11 := True;
              end;
            end;
          end;
        nSC_RECALLHUMAN: begin
            if IsPlayObject then begin
              s4C := QuestActionInfo.sParam1;
              GetVarValue(PlayObject, QuestActionInfo.sParam1, s4C);
              if s4C <> '' then begin
                PlayObject.RecallHuman(s4C);
              end;
            end;
          end;
        nSC_REGOTO: begin
            if IsPlayObject then begin
              s4C := QuestActionInfo.sParam1;
              GetVarValue(PlayObject, QuestActionInfo.sParam1, s4C);
              if s4C <> '' then begin
                OnlinePlayObject := UserEngine.GetPlayObject(s4C);
                if PlayObject <> nil then begin
                  PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
                  PlayObject.SpaceMove(OnlinePlayObject.m_PEnvir.sMapName, OnlinePlayObject.m_nCurrX, OnlinePlayObject.m_nCurrY, 0);
                  bo11 := True;
                end;
              end;
            end;
          end;
        nSC_GUILDMOVE: begin
            if IsPlayObject then begin
              if PlayObject.m_MyGuild = nil then Exit;
              s4C := QuestActionInfo.sParam1;
              if g_MapManager.FindMap(s4C) = nil then
                GetVarValue(PlayObject, QuestActionInfo.sParam1, s4C);

              PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
              PlayObject.MapRandomMove(s4C, 0);
              for II := 0 to TGUild(PlayObject.m_MyGuild).m_RankList.Count - 1 do begin
                GuildRank := TGUild(PlayObject.m_MyGuild).m_RankList.Items[II];
                if GuildRank = nil then Continue;
                for III := 0 to GuildRank.MemberList.Count - 1 do begin
                  USerObject := TPlayObject(GuildRank.MemberList.Objects[III]);
                  if USerObject = nil then Continue;
                  if (not USerObject.m_boDeath) and (not USerObject.m_boGhost) and (USerObject.m_boAllowGuildReCall) then
                    USerObject.MapRandomMove(s4C, 0);
                end;
              end;
              bo11 := True;
            end;
          end;
        nSC_GUILDMAPMOVE: begin
            if IsPlayObject then begin
              if PlayObject.m_MyGuild = nil then Exit;
              s4C := QuestActionInfo.sParam1;
              n14 := Str_ToInt(QuestActionInfo.sParam2, -1);
              n40 := Str_ToInt(QuestActionInfo.sParam3, -1);

              if g_MapManager.FindMap(s4C) = nil then
                GetVarValue(PlayObject, QuestActionInfo.sParam1, s4C);
              if n14 < 0 then
                GetVarValue(PlayObject, QuestActionInfo.sParam2, n14);
              if n40 < 0 then
                GetVarValue(PlayObject, QuestActionInfo.sParam3, n40);

              PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
              PlayObject.SpaceMove(s4C, n14, n40, 0);
              for II := 0 to TGUild(PlayObject.m_MyGuild).m_RankList.Count - 1 do begin
                GuildRank := TGUild(PlayObject.m_MyGuild).m_RankList.Items[II];
                if GuildRank = nil then Continue;
                for III := 0 to GuildRank.MemberList.Count - 1 do begin
                  USerObject := TPlayObject(GuildRank.MemberList.Objects[III]);
                  if USerObject = nil then Continue;
                  if (not USerObject.m_boDeath) and (not USerObject.m_boGhost) and (USerObject.m_boAllowGuildReCall) then
                    USerObject.SpaceMove(s4C, n14, n40, 0);
                end;
              end;
              bo11 := True;
            end;
          end;
        nSC_RANDOMMOVE: begin
            if IsPlayObject then begin
              PlayObject.RandomMove();
              bo11 := True;
            end;
          end;
        nSC_USEBONUSPOINT: if IsPlayObject then ActionOfUseBonusPoint(PlayObject, QuestActionInfo);
        nSC_REPAIRITEM: ActionOfRepairItem(BaseObject, QuestActionInfo);
        nSC_TAKEONITEM: ActionOfTakeOnItem(BaseObject, QuestActionInfo);
        nSC_TAKEOFFITEM: ActionOfTakeOffItem(BaseObject, QuestActionInfo);

        //=================================英雄相关=====================================
        nSC_CREATEHERO: if IsPlayObject then ActionOfCreateHero(PlayObject, QuestActionInfo);
        nSC_DELETEHERO: if IsPlayObject then ActionOfDeleteHero(PlayObject, QuestActionInfo);
        nSC_TIMEOPEN: if IsPlayObject then PlayObject.m_boRunPlayRobotManage := True;
        nSC_TIMECLOSE: if IsPlayObject then PlayObject.m_boRunPlayRobotManage := False;
        nSC_GUILDMEMBERMAXLIMIT: if IsPlayObject then ActionOfGuildMemberMaxLimit(PlayObject, QuestActionInfo);
        nSC_OPENUSERMARKET: if IsPlayObject then ActionOfOpenUserMarket(PlayObject, QuestActionInfo);
        nSC_ADDGUILDNAMEDATELIST: if IsPlayObject then ActionOfAddGuildNameDateList(PlayObject, QuestActionInfo);
        nSC_DELGUILDNAMEDATELIST: if IsPlayObject then ActionOfDelGuildNameDateList(PlayObject, QuestActionInfo);
        nSC_GOHOME: if IsPlayObject then ActionOfGoHome(PlayObject, QuestActionInfo);
        nSC_ADDBLOCKIPLIST: if IsPlayObject then ActionOfAddBlockIP(PlayObject, QuestActionInfo);
        nSC_MOVDATA: if IsPlayObject then ActionOfMovData(PlayObject, QuestActionInfo);
        nSC_SENDCOLORMSG: if IsPlayObject then ActionOfSendColorMsg(PlayObject, QuestActionInfo);
        nSC_ADDRANDOMMAPGATE: if IsPlayObject then ActionOfAddRandomMapGate(PlayObject, QuestActionInfo);
        nSC_DELRANDOMMAPGATE: if IsPlayObject then ActionOfDelRandomMapGate(PlayObject, QuestActionInfo);
        nSC_GETRANDOMMAPGATE: if IsPlayObject then ActionOfGetRandomMapGate(PlayObject, QuestActionInfo);
        nSC_OPENBOOK: if IsPlayObject then ActionOfOpenBook(PlayObject, QuestActionInfo);
        nSC_OPENBOX: if IsPlayObject then ActionOfOpenBox(PlayObject, QuestActionInfo);

        nSC_CHANGEITEMS: if IsPlayObject then ActionOfChangeItems(PlayObject, QuestActionInfo);
        nSC_CLEARREMEMBER: if IsPlayObject then ActionOfClearRemember(PlayObject, QuestActionInfo);
        nSC_SENDMOVEMSG: if IsPlayObject then ActionOfSendMoveMsg(PlayObject, QuestActionInfo);
        nSC_SENDCENTERMSG: if IsPlayObject then ActionOfSendCenterMsg(PlayObject, QuestActionInfo);
        nSC_RECALLHERO: if IsPlayObject then PlayObject.ClientHeroLogOn();
        nSC_HEROLOGOUT: if IsPlayObject and (PlayObject.m_MyHero <> nil) then THeroObject(PlayObject.m_MyHero).LogOut();
        nSC_SETITEMSLIGHT: if IsPlayObject then ActionOfSetItemsLight(PlayObject, QuestActionInfo);
        nSC_SETITEMSLIGHTEX: if IsPlayObject then ActionOfSetItemsLightEx(PlayObject, QuestActionInfo);
        nSC_CHANGEITEMNEWADDVALUE: if IsPlayObject then ActionOfChangeItemNewAddValue(PlayObject, QuestActionInfo);
        nSC_OPENHOMEPAGE: if IsPlayObject then ActionOfOpenHomePage(PlayObject, QuestActionInfo);
        nSC_SNOW: if IsPlayObject then ActionOfSnow(PlayObject, QuestActionInfo);
        nSC_RANDOMUPGRADEITEM: if IsPlayObject then ActionOfRandomUpgradeItem(PlayObject, QuestActionInfo);

        nSC_READRANDOMSTR: if IsPlayObject then ActionOfReadRandomStr(PlayObject, QuestActionInfo);
        nSC_CHANGERANGEMONPOS: if IsPlayObject then ActionOfChangeRangeMonPos(PlayObject, QuestActionInfo);
        nSC_READ: if IsPlayObject then ActionOfReadVar(PlayObject, QuestActionInfo);
        nSC_WRITE: if IsPlayObject then ActionOfWriteVar(PlayObject, QuestActionInfo);
        nSC_PKZONEX: if IsPlayObject then ActionOfPkZoneEx(PlayObject, QuestActionInfo);
        nSC_SPELL: if IsPlayObject then ActionOfSpell(PlayObject, QuestActionInfo);
        nSC_ADDMAPMAGICEVENT: if IsPlayObject then ActionOfAddMapMagicEvent(PlayObject, QuestActionInfo);
        nSC_RANDOMADDMAPMAGICEVENT: if IsPlayObject then ActionOfRandomAddMapMagicEvent(PlayObject, QuestActionInfo);
        nSC_DROPITEMMAP: if IsPlayObject then ActionOfDropItemMap(PlayObject, QuestActionInfo);
        nSC_LOCK: if IsPlayObject then ActionOfLock(PlayObject, QuestActionInfo);
        nSC_UNLOCK: if IsPlayObject then ActionOfUnLock(PlayObject, QuestActionInfo);
        nSC_CLEARDUELMAP: if IsPlayObject then ActionOfClearDuelMap(PlayObject, QuestActionInfo);
        nSC_GETDUELITEMS: if IsPlayObject then ActionOfGetDuelItems(PlayObject, QuestActionInfo);
        nSC_APPDUEL: if IsPlayObject then ActionOfAppDuel(PlayObject, QuestActionInfo);
        nSC_CANUSEITEM: if IsPlayObject then PlayObject.m_boCanUseItem := QuestActionInfo.sParam1 = '1';
        nSC_AUTOGOTOXY: if IsPlayObject then ActionOfAutoGotoXY(PlayObject, QuestActionInfo);
        nSC_CHANGENEWSTATUS: ActionOfChangeNewStatus(BaseObject, QuestActionInfo);
        nSC_SENDDELAYMSG: if IsPlayObject then ActionOfSendDelayMsg(PlayObject, QuestActionInfo);
        nSC_SETMASKED: ActionOfSetMasked(BaseObject, QuestActionInfo);
        nSC_CHANGEUSEITEMSTARSLEVEL: if IsPlayObject then ActionOfChangeUseItemStarsLevel(PlayObject, QuestActionInfo);
        nSC_CHANGEBAGITEMSTARSLEVEL: if IsPlayObject then ActionOfChangeBagItemStarsLevel(PlayObject, QuestActionInfo);
        nSC_BINDBAGITEM: if IsPlayObject then ActionOfBindBagItem(PlayObject, QuestActionInfo);
        nSC_HEROGROUP: if IsPlayObject then ActionOfHeroGroup(PlayObject, QuestActionInfo);
        nSC_UNHEROGROUP: if IsPlayObject then ActionOfUnHeroGroup(PlayObject, QuestActionInfo);
        nSC_VIBRATION: if IsPlayObject then ActionOfVibration(PlayObject, QuestActionInfo);
        nSC_OPENBIGDIALOGBOX: if IsPlayObject then ActionOfOpenBigDialogBox(PlayObject, QuestActionInfo);
        nSC_CLOSEBIGDIALOGBOX: if IsPlayObject then ActionOfCloseBigDialogBox(PlayObject, QuestActionInfo);
        nSC_TAGMAPMOVE: if IsPlayObject then ActionOfTagMapMove(PlayObject, QuestActionInfo);
        nSC_TAGMAPINFO: if IsPlayObject then ActionOfTagMapInfo(PlayObject, QuestActionInfo);
        nSC_AISTART: if IsPlayObject then ActionOfAIStart(PlayObject, QuestActionInfo);
        nSC_AISTOP: if IsPlayObject then ActionOfAIStop(PlayObject, QuestActionInfo);
        nSC_CHANGEIPADDRESS: if IsPlayObject then ActionOfChangeIpAddress(PlayObject, QuestActionInfo);
        nSC_CHANGEATTATCKMODE: if IsPlayObject then ActionOfChangeAttatckMode(PlayObject, QuestActionInfo);
        nSC_AILOGON: if IsPlayObject then ActionOfAILogOn(PlayObject, QuestActionInfo);
        nSC_AILOGONEX: if IsPlayObject then ActionOfAILogOnEx(PlayObject, QuestActionInfo);
        nSC_TAKEITEMLIST: ActionOfTakeItemList(BaseObject, QuestActionInfo);
        nSC_SHOWRANKLEVLNAME: if IsPlayObject then ActionOfShowRankLevelName(PlayObject, QuestActionInfo);
        nSC_LOADROBOTCONFIG: ActionOfLoadRobotConfig(BaseObject, QuestActionInfo);
      else begin
          if IsPlayObject and Assigned(PlugInEngine.ActionScriptProcess) then begin
            PlugInEngine.ActionScriptProcess(Self,
              BaseObject,
              QuestActionInfo.nCMDCode,
              PChar(QuestActionInfo.sParam1),
              QuestActionInfo.nParam1,
              PChar(QuestActionInfo.sParam2),
              QuestActionInfo.nParam2,
              PChar(QuestActionInfo.sParam3),
              QuestActionInfo.nParam3,
              PChar(QuestActionInfo.sParam4),
              QuestActionInfo.nParam4,
              PChar(QuestActionInfo.sParam5),
              QuestActionInfo.nParam5,
              PChar(QuestActionInfo.sParam6),
              QuestActionInfo.nParam6,
              PChar(QuestActionInfo.sParam7),
              QuestActionInfo.nParam7,
              PChar(QuestActionInfo.sParam8),
              QuestActionInfo.nParam8,
              PChar(QuestActionInfo.sParam9),
              QuestActionInfo.nParam9,
              PChar(QuestActionInfo.sParam10),
              QuestActionInfo.nParam10);
          end;
        end;
      end;
    end;
  end;

  procedure SendMerChantSayMsg(sMsg: string; boFlag: Boolean);
  var
    s10, s14: string;
    nC: Integer;
  begin
    if IsPlayObject and (not PlayObject.m_boNotOnlineAddExp) and (not PlayObject.m_boAI) then begin
      s14 := sMsg;
      nC := 0;
      while (True) do begin
        if Pos('>', s14) <= 0 then Break; //if TagCount(s14, '>') < 1 then Break;
        //MainOutMessage('s14:'+s14);
        s14 := ArrestStringEx2(s14, '<', '>', s10);
        //MainOutMessage('s10:'+s10);
        GetVariableText(PlayObject, sMsg, s10);
        Inc(nC);
        if nC >= 101 then Break;
      end;
      //MainOutMessage('nC:'+INTTOSTR(nC));
      PlayObject.GetScriptLabel(sMsg);
      if boFlag then begin
        PlayObject.SendFirstMsg(Self, RM_MERCHANTSAY, 0, 0, 0, 0, m_sCharName + '/' + sMsg);
      end else begin
        PlayObject.SendMsg(Self, RM_MERCHANTSAY, 0, 0, 0, 0, m_sCharName + '/' + sMsg);
      end;
    end;
  end;
begin
  BaseObject := AObject;
  PlayObject := AObject;
  Script := nil;
  List1C := TStringList.Create;
  n18 := 1000;
  n20 := 0;
  if PlayObject.m_NPC <> Self then begin
    PlayObject.m_NPC := nil;
    PlayObject.m_Script := nil;
    FillChar(PlayObject.m_nVal, SizeOf(PlayObject.m_nVal), #0);
  end;
  if CompareText(sLabel, '@main') = 0 then begin
    for I := 0 to m_ScriptList.Count - 1 do begin
      Script3C := m_ScriptList.Items[I];
      //if Script3C = nil then Continue;
      for II := 0 to Script3C.RecordList.Count - 1 do begin
        SayingRecord := Script3C.RecordList.Items[II];
        //if SayingRecord = nil then Continue;
        if CompareText(sLabel, SayingRecord.sLabel) = 0 then begin
          Script := Script3C;
          PlayObject.m_Script := Script;
          PlayObject.m_NPC := Self;
          Break;
        end;
        if Script <> nil then Break;
      end;
    end;
  end;
  if (Script = nil) then begin
    if (PlayObject.m_Script <> nil) then begin
      for I := m_ScriptList.Count - 1 downto 0 do begin
        if m_ScriptList.Count <= 0 then Break;
        if (m_ScriptList.Items[I] <> nil) and (m_ScriptList.Items[I] = PlayObject.m_Script) then begin
          Script := m_ScriptList.Items[I];
        end;
      end;
    end;
    if (Script = nil) then begin
      for I := m_ScriptList.Count - 1 downto 0 do begin
        if m_ScriptList.Count <= 0 then Break;
        if (pTScript(m_ScriptList.Items[I]) <> nil) and CheckQuestStatus(pTScript(m_ScriptList.Items[I])) then begin
          Script := m_ScriptList.Items[I];
          PlayObject.m_Script := Script;
          PlayObject.m_NPC := Self;
        end;
      end;
    end;
  end;

  //跳转到指定示签，执行
  if (Script <> nil) then begin
    for II := 0 to Script.RecordList.Count - 1 do begin
      SayingRecord := Script.RecordList.Items[II];
      //if SayingRecord = nil then Continue;
      if CompareText(sLabel, SayingRecord.sLabel) = 0 then begin
        //MainOutMessage('sLabel '+sLabel+' boExtJmp '+BooleanToStr(boExtJmp)+' SayingRecord.boExtJmp '+BooleanToStr(SayingRecord.boExtJmp));
        if boExtJmp and not SayingRecord.boExtJmp then Break;
        sSENDMSG := '';
        for III := 0 to SayingRecord.ProcedureList.Count - 1 do begin
          SayingProcedure := SayingRecord.ProcedureList.Items[III];
          //if SayingProcedure = nil then Continue;
          bo11 := False;
          if QuestCheckCondition(SayingProcedure.ConditionList) then begin
            sSENDMSG := sSENDMSG + SayingProcedure.sSayMsg;
            if not QuestActionProcess(SayingProcedure.ActionList) then Break;
            if bo11 then SendMerChantSayMsg(sSENDMSG, True);
          end else begin
            sSENDMSG := sSENDMSG + SayingProcedure.sElseSayMsg;
            if not QuestActionProcess(SayingProcedure.ElseActionList) then Break;
            if bo11 then SendMerChantSayMsg(sSENDMSG, True);
          end;
        end;
        if sSENDMSG <> '' then SendMerChantSayMsg(sSENDMSG, False);
        Break;
      end;
    end;
  end;
  List1C.Free;
end;

function TNormNpc.AllowLable(sLabel: string): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to m_UnAllowLableList.Count - 1 do begin
    if CompareLStr(sLabel, m_UnAllowLableList.Strings[I], Length(m_UnAllowLableList.Strings[I])) then begin
      Result := False;
      Exit;
    end;
  end;
end;

procedure TNormNpc.AddLable(sLabel: string);
var
  I: Integer;
begin
  for I := 0 to m_UnAllowLableList.Count - 1 do begin
    if CompareLStr(sLabel, m_UnAllowLableList.Strings[I], Length(m_UnAllowLableList.Strings[I])) then begin
      Exit;
    end;
  end;
  m_UnAllowLableList.Add(sLabel);
end;

procedure TNormNpc.DeleteLable(sLabel: string);
var
  I: Integer;
begin
  for I := 0 to m_UnAllowLableList.Count - 1 do begin
    if CompareLStr(sLabel, m_UnAllowLableList.Strings[I], Length(m_UnAllowLableList.Strings[I])) then begin
      m_UnAllowLableList.Delete(I);
      Break;
    end;
  end;
end;

procedure TNormNpc.LoadNpcScript;
var
  s08: string;
begin
  if m_boIsQuest then begin
    m_sPath := sNpc_def;
    s08 := m_sCharName + '-' + m_sMapName;
    FrmDB.LoadNpcScript(Self, m_sFilePath, s08);
  end else begin
    m_sPath := m_sFilePath;
    FrmDB.LoadNpcScript(Self, m_sFilePath, m_sCharName);
  end;
end;

function TNormNpc.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);
end;

function TNormNpc.GetShowName: string;
var
  sShowName: string;
begin
  if (m_nVarIdx >= 0) and (m_nVarIdx <= 499) then begin
    Result := g_Config.GlobalAVal[m_nVarIdx];
  end else begin
    sShowName := m_sCharName;
    Result := FilterShowName(sShowName);
    if (m_Master <> nil) and not m_Master.m_boObMode then begin
      Result := Result + '(' + m_Master.m_sCharName + ')';
    end;
  end;
end;

procedure TNormNpc.Run;
var
  nInteger: Integer;
begin
  if m_Master <> nil then m_Master := nil; //不允许召唤为宝宝
  //NPC变色
  if (m_boNpcAutoChangeColor) and (m_dwNpcAutoChangeColorTime > 0) and (GetTickCount - m_dwNpcAutoChangeColorTick > m_dwNpcAutoChangeColorTime) then begin
    m_dwNpcAutoChangeColorTick := GetTickCount();
    case m_nNpcAutoChangeIdx of
      0: nInteger := STATE_TRANSPARENT;
      1: nInteger := POISON_STONE;
      2: nInteger := POISON_DONTMOVE;
      3: nInteger := POISON_68;
      4: nInteger := POISON_DECHEALTH;
      5: nInteger := POISON_LOCKSPELL;
      6: nInteger := POISON_DAMAGEARMOR;
    else begin
        m_nNpcAutoChangeIdx := 0;
        nInteger := STATE_TRANSPARENT;
      end;
    end;
    Inc(m_nNpcAutoChangeIdx);
    m_nCharStatus := (m_nCharStatusEx and $FFFFF) or (($80000000 shr nInteger) or 0);
    StatusChanged();
  end;
  if m_boFixColor and (m_nFixStatus <> m_nCharStatus) then begin
    case m_nFixColorIdx of
      0: nInteger := STATE_TRANSPARENT;
      1: nInteger := POISON_STONE;
      2: nInteger := POISON_DONTMOVE;
      3: nInteger := POISON_68;
      4: nInteger := POISON_DECHEALTH;
      5: nInteger := POISON_LOCKSPELL;
      6: nInteger := POISON_DAMAGEARMOR;
    else begin
        m_nFixColorIdx := 0;
        nInteger := STATE_TRANSPARENT;
      end;
    end;
    m_nCharStatus := (m_nCharStatusEx and $FFFFF) or (($80000000 shr nInteger) or 0);
    m_nFixStatus := m_nCharStatus;
    StatusChanged();
  end;
  inherited;
end;

procedure TNormNpc.ScriptActionError(BaseObject: TActorObject; sErrMsg: string;
  QuestActionInfo: pTQuestActionInfo; sCmd: string);
var
  sMsg: string;
resourcestring
  sOutMessage = '[脚本错误] %s 脚本命令:%s NPC名称:%s 地图:%s(%d:%d) 参数1:%s 参数2:%s 参数3:%s 参数4:%s 参数5:%s 参数6:%s';
begin
  sMsg := Format(sOutMessage, [sErrMsg,
    sCmd,
      m_sCharName,
      m_sMapName,
      m_nCurrX,
      m_nCurrY,
      QuestActionInfo.sParam1,
      QuestActionInfo.sParam2,
      QuestActionInfo.sParam3,
      QuestActionInfo.sParam4,
      QuestActionInfo.sParam5,
      QuestActionInfo.sParam6]);
  {
  sMsg:='脚本命令:' + sCmd +
        ' NPC名称:' + m_sCharName +
        ' 地图:' + m_sMapName +
        ' 座标:' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) +
        ' 参数1:' + QuestActionInfo.sParam1 +
        ' 参数2:' + QuestActionInfo.sParam2 +
        ' 参数3:' + QuestActionInfo.sParam3 +
        ' 参数4:' + QuestActionInfo.sParam4 +
        ' 参数5:' + QuestActionInfo.sParam5 +
        ' 参数6:' + QuestActionInfo.sParam6;
  }
  MainOutMessage(sMsg);
end;

procedure TNormNpc.ScriptConditionError(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo; sCmd: string);
var
  sMsg: string;
begin
  sMsg:='Cmd:' + sCmd +
        ' NPC:' + m_sCharName +
        ' Map:' + m_sMapName +
        ' (' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) +
        ') Param1:' + QuestConditionInfo.sParam1 +
        ' Param2:' + QuestConditionInfo.sParam2 +
        ' Param3:' + QuestConditionInfo.sParam3 +
        ' Param4:' + QuestConditionInfo.sParam4 +
        ' Param5:' + QuestConditionInfo.sParam5;
  MainOutMessage('[Npc Condition Error] ' + sMsg);
end;

procedure TNormNpc.SendMsgToUser(PlayObject: TPlayObject; sMsg: string);
begin
  PlayObject.SendMsg(Self, RM_MERCHANTSAY, 0, 0, 0, 0, m_sCharName + '/' + sMsg);
end;

function TNormNpc.sub_49ADB8(sMsg, sStr, sText: string): string;
var
  n10: Integer;
  s14, s18: string;
begin
  n10 := Pos(sStr, sMsg);
  if n10 > 0 then begin
    s14 := Copy(sMsg, 1, n10 - 1);
    s18 := Copy(sMsg, Length(sStr) + n10, Length(sMsg));
    Result := s14 + sText + s18;
  end else Result := sMsg;
end;

procedure TNormNpc.UserSelect(PlayObject: TPlayObject; sData: string);
var
  sMsg, sLabel: string;
begin
  PlayObject.m_nScriptGotoCount := 0;
  //==============================================
  //处理脚本命令 @back 返回上级标签内容
  if (sData <> '') and (sData[1] = '@') then begin
    sMsg := GetValidStr3(sData, sLabel, [#13]);
    if (PlayObject.m_sScriptCurrLable <> sLabel) then begin
      if (sLabel <> sBACK) then begin
        PlayObject.m_sScriptGoBackLable := PlayObject.m_sScriptCurrLable;
        PlayObject.m_sScriptCurrLable := sLabel;
      end else begin
        if PlayObject.m_sScriptCurrLable <> '' then begin
          PlayObject.m_sScriptCurrLable := '';
        end else begin
          PlayObject.m_sScriptGoBackLable := '';
        end;
      end;
    end;
  end;
  //==============================================
end;

procedure TNormNpc.ActionOfChangeNameColor(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nColor: Integer;
begin
  nColor := QuestActionInfo.nParam1;
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam1, nColor); //增加变量支持
  end else
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
    GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam1, nColor); //增加变量支持
  end;
  if (nColor < 0) or (nColor > 255) then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_CHANGENAMECOLOR);
    Exit;
  end;
  BaseObject.m_btNameColor := nColor;
  BaseObject.RefNameColor();
end;

procedure TNormNpc.ActionOfClearPassword(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_sStoragePwd := '';
  PlayObject.m_boPasswordLocked := False;
end;
//RECALLMOB 怪物名称 等级 叛变时间 变色(0,1) 固定颜色(1 - 7)
//变色为0 时固定颜色才起作用

procedure TNormNpc.ActionOfRecallmob(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  boAutoChangeColor: Boolean;
  mon: TActorObject;
  I: Integer;
  UserItem: pTUserItem;
  nX, nY: Integer;
begin
  if QuestActionInfo.sParam6 <> '' then begin
    nX := Str_ToInt(QuestActionInfo.sParam5, -1);
    nY := Str_ToInt(QuestActionInfo.sParam6, -1);
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      if nX < 0 then
        GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam5, nX); //增加变量支持
      if nY < 0 then
        GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam6, nY); //增加变量支持
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      if nX < 0 then
        GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam5, nX); //增加变量支持
      if nY < 0 then
        GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam6, nY); //增加变量支持
    end;
  end;

  if QuestActionInfo.sParam6 = '' then begin
    if QuestActionInfo.nParam3 <= 1 then begin
      mon := BaseObject.MakeSlave(QuestActionInfo.sParam1, 3, Str_ToInt(QuestActionInfo.sParam2, 0), 100, 10 * 24 * 60 * 60);
    end else begin
      mon := BaseObject.MakeSlave(QuestActionInfo.sParam1, 3, Str_ToInt(QuestActionInfo.sParam2, 0), 100, QuestActionInfo.nParam3 * 60);
    end;
  end else begin
    if (nX >= 0) and (nY >= 0) then begin
      if QuestActionInfo.nParam3 <= 1 then begin
        mon := BaseObject.MakeXYSlave(QuestActionInfo.sParam1, 3, Str_ToInt(QuestActionInfo.sParam2, 0), 100, 10 * 24 * 60 * 60, nX, nY);
      end else begin
        mon := BaseObject.MakeXYSlave(QuestActionInfo.sParam1, 3, Str_ToInt(QuestActionInfo.sParam2, 0), 100, QuestActionInfo.nParam3 * 60, nX, nY);
      end;
    end else begin
      if QuestActionInfo.nParam3 <= 1 then begin
        mon := BaseObject.MakeSlave(QuestActionInfo.sParam1, 3, Str_ToInt(QuestActionInfo.sParam2, 0), 100, 10 * 24 * 60 * 60);
      end else begin
        mon := BaseObject.MakeSlave(QuestActionInfo.sParam1, 3, Str_ToInt(QuestActionInfo.sParam2, 0), 100, QuestActionInfo.nParam3 * 60);
      end;
    end;
  end;

  if mon <> nil then begin
    if QuestActionInfo.sParam6 = '' then begin
      if (QuestActionInfo.sParam4 <> '') and (QuestActionInfo.sParam4[1] = '1') then begin
        mon.m_boAutoChangeColor := True;
      end else
        if QuestActionInfo.nParam5 > 0 then begin
        mon.m_boFixColor := True;
        mon.m_nFixColorIdx := QuestActionInfo.nParam5 - 1;
      end;
    end else begin
      mon.m_boAutoChangeColor := False;
      mon.m_boFixColor := False;
    end;

    if mon.m_btRaceServer = RC_PLAYMOSTER then begin //如果是人形怪，可以吃药和捡物品
      mon.m_nCopyHumanLevel := 1;
      for I := 0 to mon.m_ItemList.Count - 1 do begin //清除包裹
        Dispose(pTUserItem(mon.m_ItemList.Items[I]));
      end;
      mon.m_ItemList.Clear;
      mon.Initialize; //重新加载怪物设置
    end;
  end;
end;

procedure TNormNpc.ActionOfReNewLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nReLevel, nLevel: Integer;
  nBounsuPoint: Integer;
begin
  nReLevel := Str_ToInt(QuestActionInfo.sParam1, -1);
  nLevel := Str_ToInt(QuestActionInfo.sParam2, -1);
  nBounsuPoint := Str_ToInt(QuestActionInfo.sParam3, -1);
  if nReLevel < 0 then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam1, nReLevel); //增加变量支持
  end;
  if nLevel < 0 then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam2, nLevel); //增加变量支持
  end;
  if nBounsuPoint < 0 then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam3, nBounsuPoint); //增加变量支持
  end;
  if (nReLevel < 0) or (nLevel < 0) or (nBounsuPoint < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_RENEWLEVEL);
    Exit;
  end;
  if (PlayObject.m_btReLevel + nReLevel) <= 255 then begin
    Inc(PlayObject.m_btReLevel, nReLevel);
    if nLevel > 0 then PlayObject.m_Abil.Level := nLevel;
    if g_Config.boReNewLevelClearExp then PlayObject.m_Abil.Exp := 0;
    Inc(PlayObject.m_nBonusPoint, nBounsuPoint);
    PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
    PlayObject.HasLevelUp(0);
    PlayObject.RefShowName();
  end;
end;

procedure TNormNpc.ActionOfChangeGender(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGENDER: Integer;
begin
  nGENDER := Str_ToInt(QuestActionInfo.sParam1, -1);
  if not (nGENDER in [0, 1]) then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam1, nGENDER);
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam1, nGENDER);
    end;
  end;
  if not (nGENDER in [0..1]) then nGENDER := 1;
  {if not (nGENDER in [0, 1]) then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_CHANGEGENDER);
    Exit;
  end;}
  if BaseObject.m_btGender <> nGENDER then begin
    BaseObject.m_btGender := nGENDER;
    BaseObject.FeatureChanged;
  end;
end;

procedure TNormNpc.ActionOfChangeIpAddress(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sIPaddr: string;
begin
  sIPaddr := QuestActionInfo.sParam1;
  if not IsIpAddr(sIPaddr) then
    GetVarValue(PlayObject, QuestActionInfo.sParam1, sIPaddr);
  if IsIpAddr(sIPaddr) then begin
    PlayObject.m_sIPaddr := sIPaddr;
    PlayObject.m_sIPLocal := GetIPLocal(PlayObject.m_sIPaddr);
  end;
end;

procedure TNormNpc.ActionOfChangeAttatckMode(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  //sIPaddr: string;
  nAttatckMode: Integer;
begin
  nAttatckMode := Str_ToInt(QuestActionInfo.sParam1, -1);
  if nAttatckMode in [HAM_ALL..HAM_PKATTACK] then begin
    PlayObject.m_btAttatckMode := HAM_PKATTACK;
  end;
 { sIPaddr := QuestActionInfo.sParam1;
  if not IsIpAddr(sIPaddr) then
    GetVarValue(PlayObject, QuestActionInfo.sParam1, sIPaddr);
  if IsIpAddr(sIPaddr) then begin
    PlayObject.m_sIPaddr := sIPaddr;
    PlayObject.m_sIPLocal := GetIPLocal(PlayObject.m_sIPaddr);
  end; }
end;

procedure TNormNpc.ActionOfKillSlave(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sCharName: string;
  Slave: TActorObject;
  boFind: Boolean;
begin
  if QuestActionInfo.sParam1 = '' then begin
    for I := 0 to BaseObject.m_SlaveList.Count - 1 do begin
      Slave := TActorObject(BaseObject.m_SlaveList.Items[I]);
      //Slave.m_WAbil.HP := 0;
      Slave.m_boNoItem := True;
      Slave.MakeGhost;
    end;
  end else begin
    sCharName := QuestActionInfo.sParam1;
    boFind := False;
    for I := 0 to BaseObject.m_SlaveList.Count - 1 do begin
      Slave := TActorObject(BaseObject.m_SlaveList.Items[I]);
      if CompareText(sCharName, Slave.m_sCharName) = 0 then begin
        //Slave.m_WAbil.HP := 0;
        Slave.m_boNoItem := True;
        Slave.MakeGhost;
        boFind := True;
      end;
    end;

    if not boFind then begin
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
        GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam1, sCharName);
      end else
        if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
        GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam1, sCharName);
      end;
      for I := 0 to BaseObject.m_SlaveList.Count - 1 do begin
        Slave := TActorObject(BaseObject.m_SlaveList.Items[I]);
        if CompareText(sCharName, Slave.m_sCharName) = 0 then begin
          //Slave.m_WAbil.HP := 0;
          Slave.m_boNoItem := True;
          Slave.MakeGhost;
        end;
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfKillMonExpRate(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate: Integer;
  nTime: Integer;
  PlayObject: TPlayObject;
  HeroObject: THeroObject;
begin
  nRate := Str_ToInt(QuestActionInfo.sParam1, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (nRate < 0) or (nTime < 0) then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_KILLMONEXPRATE);
    Exit;
  end;
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    PlayObject := TPlayObject(BaseObject);
    PlayObject.m_nKillMonExpRate := nRate;
  //PlayObject.m_dwKillMonExpRateTime:=_MIN(High(Word),nTime);
    PlayObject.m_dwKillMonExpRateTime := LongWord(nTime);
    if g_Config.boShowScriptActionMsg then begin
      PlayObject.SysMsg(Format(g_sChangeKillMonExpRateMsg, [PlayObject.m_nKillMonExpRate / 100, PlayObject.m_dwKillMonExpRateTime]), c_Green, t_Hint);
    end;
  end else begin
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      HeroObject := THeroObject(BaseObject);
      HeroObject.m_nKillMonExpRate := nRate;
  //PlayObject.m_dwKillMonExpRateTime:=_MIN(High(Word),nTime);
      HeroObject.m_dwKillMonExpRateTime := LongWord(nTime);
      if g_Config.boShowScriptActionMsg then begin
        HeroObject.SysMsg(Format(g_sChangeKillMonExpRateMsg, [HeroObject.m_nKillMonExpRate / 100, HeroObject.m_dwKillMonExpRateTime]), c_Green, t_Hint);
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfMonGenEx(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sMapName, sMonName: string;
  nMapX, nMapY, nRange, nCount: Integer;
  nRandX, nRandY: Integer;
  Envir: TEnvirnoment;
begin
  sMapName := QuestActionInfo.sParam1;
  nMapX := Str_ToInt(QuestActionInfo.sParam2, -1);
  nMapY := Str_ToInt(QuestActionInfo.sParam3, -1);
  sMonName := QuestActionInfo.sParam4;
  nRange := Str_ToInt(QuestActionInfo.sParam5, -1);
  nCount := Str_ToInt(QuestActionInfo.sParam6, -1);
  Envir := g_MapManager.FindMap(sMapName);
  if Envir = nil then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam1, sMapName);
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam1, sMapName);
    end;
    Envir := g_MapManager.FindMap(sMapName);
  end;

  if (nMapX <= 0) then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam2, nMapX);
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam2, nMapX);
    end;
  end;

  if (nMapY <= 0) then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam3, nMapY);
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam3, nMapY);
    end;
  end;

  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam4, sMonName);
  end else
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
    GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam4, sMonName);
  end;

  if (nRange < 0) then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam5, nRange);
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam5, nRange);
    end;
  end;

  if (nCount < 0) then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam6, nCount);
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam6, nCount);
    end;
  end;

 { if (Envir = nil) then MainOutMessage('Envir = nil');
  if (nMapX <= 0) then MainOutMessage('nMapX <= 0');
  if (nMapY <= 0) then MainOutMessage('nMapY <= 0');
  if (sMonName = '') then MainOutMessage('sMonName = ''');
  if (nRange < 0) then MainOutMessage('nRange < 0');
  if (nCount <= 0) then MainOutMessage('nCount <= 0');  }

  if (Envir = nil) or (nMapX <= 0) or (nMapY <= 0) or (sMonName = '') or (nRange < 0) or (nCount <= 0) then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_MONGENEX);
    Exit;
  end;

  for I := 0 to nCount - 1 do begin
    nRandX := Random(nRange * 2 + 1) + (nMapX - nRange);
    nRandY := Random(nRange * 2 + 1) + (nMapY - nRange);
    if UserEngine.RegenMonsterByName(nil, sMapName, nRandX, nRandY, sMonName) = nil then begin
      //ScriptActionError(PlayObject,'',QuestActionInfo,sSC_MONGENEX);
      Break;
    end;
  end;
end;

procedure TNormNpc.ActionOfOpenMagicBox(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Monster: TActorObject;
  sMonName: string;
  nX, nY: Integer;
begin
  sMonName := QuestActionInfo.sParam1;
  if sMonName = '' then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_OPENMAGICBOX);
    Exit;
  end;
  PlayObject.GetFrontPosition(nX, nY);
  Monster := UserEngine.RegenMonsterByName(nil, PlayObject.m_PEnvir.sMapName, nX, nY, sMonName);
  if Monster = nil then begin
    Exit;
  end;
  Monster.Die;
end;

procedure TNormNpc.ActionOfPkZone(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nX, nY: Integer;
  FireBurnEvent: TFireBurnEvent;
  nMinX, nMaxX, nMinY, nMaxY: Integer;
  nRange, nType, nTime, nPoint: Integer;
begin
  nRange := Str_ToInt(QuestActionInfo.sParam1, -1);
  nType := Str_ToInt(QuestActionInfo.sParam2, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam3, -1);
  nPoint := Str_ToInt(QuestActionInfo.sParam4, -1);
  if (nRange < 0) or (nType < 0) or (nTime < 0) or (nPoint < 0) then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_PKZONE);
    Exit;
  end;
  {
  nMinX:=PlayObject.m_nCurrX - nRange;
  nMaxX:=PlayObject.m_nCurrX + nRange;
  nMinY:=PlayObject.m_nCurrY - nRange;
  nMaxY:=PlayObject.m_nCurrY + nRange;
  }
  nMinX := m_nCurrX - nRange;
  nMaxX := m_nCurrX + nRange;
  nMinY := m_nCurrY - nRange;
  nMaxY := m_nCurrY + nRange;
  for nX := nMinX to nMaxX do begin
    for nY := nMinY to nMaxY do begin
      if ((nX < nMaxX) and (nY = nMinY)) or
        ((nY < nMaxY) and (nX = nMinX)) or
        (nX = nMaxX) or (nY = nMaxY) then begin
        FireBurnEvent := TFireBurnEvent.Create(BaseObject, nX, nY, nType, nTime * 1000, nPoint);
        g_EventManager.AddEvent(FireBurnEvent);
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfPkZoneEx(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  nX, nY: Integer;
  SpaceLockEvent: TSpaceLockEvent;
  nMinX, nMaxX, nMinY, nMaxY: Integer;
  nRange, nType, nTime, nPoint: Integer;
  BaseObjectList: TList;
  boFind: Boolean;
  Event: TEvent;
  ActorObject: TActorObject;
begin
  if m_boSpaceLock then begin
    BaseObject.SysMsg('PK Zone has been locked', c_Red, t_Notice);
    Exit;
  end;

  nRange := Str_ToInt(QuestActionInfo.sParam1, -1);
  nType := Str_ToInt(QuestActionInfo.sParam2, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam3, -1);
  //nPoint := Str_ToInt(QuestActionInfo.sParam4, -1);
  if (nRange < 0) or (nType < 0) or (nTime < 0) {or (nPoint < 0) } then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_PKZONEX);
    Exit;
  end;
  {
  nMinX:=PlayObject.m_nCurrX - nRange;
  nMaxX:=PlayObject.m_nCurrX + nRange;
  nMinY:=PlayObject.m_nCurrY - nRange;
  nMaxY:=PlayObject.m_nCurrY + nRange;
  }

  nMinX := m_nCurrX - nRange;
  nMaxX := m_nCurrX + nRange;
  nMinY := m_nCurrY - nRange;
  nMaxY := m_nCurrY + nRange;

  boFind := False;
  BaseObjectList := TList.Create;
  GetMapEvents(m_PEnvir, m_nCurrX, m_nCurrY, nRange, BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    Event := TEvent(BaseObjectList.Items[I]);
    if Event.m_nServerEventType = ET_MAGICLOCK then begin
      boFind := True;
      Break;
    end;
  end;
  BaseObjectList.Free;

  if boFind then begin
    BaseObject.SysMsg('PK Zone already created in this Area', c_Red, t_Notice);
  end else begin
    BaseObjectList := TList.Create;
    GetMapActorObjects(m_PEnvir, m_nCurrX, m_nCurrY, nRange - 1, BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do begin
      ActorObject := TActorObject(BaseObjectList.Items[I]);
      if (ActorObject <> Self) { and (ActorObject.m_Master = nil)} then begin
        ActorObject.m_SpaceOwner := Self;
        ActorObject.m_boSpaceLock := True;
        ActorObject.m_SpaceRect := Rect(m_nCurrX - nRange, m_nCurrY - nRange, m_nCurrX + nRange, m_nCurrY + nRange);
          //ActorObject.SetSlaveLockSpace(ActorObject.m_SpaceRect, Self);
        AddLock(ActorObject);
      end;
    end;
    BaseObjectList.Free;

    m_SpaceOwner := Self;
    m_boSpaceLock := True;
    m_SpaceRect := Rect(m_nCurrX - nRange, m_nCurrY - nRange, m_nCurrX + nRange, m_nCurrY + nRange);

    for nX := nMinX to nMaxX do begin
      for nY := nMinY to nMaxY do begin
        if ((nX < nMaxX) and (nY = nMinY)) or
          ((nY < nMaxY) and (nX = nMinX)) or
          (nX = nMaxX) or (nY = nMaxY) then begin
          SpaceLockEvent := TSpaceLockEvent.Create(Self, nX, nY, nType, nTime * 1000);
          g_EventManager.AddEvent(SpaceLockEvent);
        end;
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfUnLock(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  Envir: TEnvirnoment;
  SpaceLockEvent: TSpaceLockEvent;
  AObject: TPlayObject;
  sMapName: string;
  EventList: TList;
begin
  sMapName := QuestActionInfo.sParam1;

  Envir := g_MapManager.FindMap(sMapName);
  if Envir = nil then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam1, sMapName);
    Envir := g_MapManager.FindMap(sMapName);
  end;

  if Envir = nil then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_LOCK);
    Exit;
  end;

  AObject := TPlayObject(Envir.m_PlayObject);
  if AObject.m_boSpaceLock then begin
    EventList := TList.Create;
    if g_EventManager.GetLockEvent(Envir, EventList) > 0 then begin
      for I := 0 to EventList.Count - 1 do begin
        SpaceLockEvent := TSpaceLockEvent(EventList.Items[I]);
        SpaceLockEvent.m_boClosed := True;
        SpaceLockEvent.Close;
      end;
    end;
    EventList.Free;
  end;
end;

procedure TNormNpc.ActionOfGetDuelItems(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  ItemList: TList;
  nGold: Integer;
  UserItem: pTUserItem;
begin
  ItemList := TList.Create;
  if g_DuelEngine.GetItems(PlayObject.m_sCharName, ItemList, nGold) then begin
    if nGold > 0 then begin
      PlayObject.IncGameGold(nGold);
      PlayObject.GameGoldChanged();
    end;
    for I := 0 to ItemList.Count - 1 do begin
      UserItem := ItemList.Items[I];
      if PlayObject.IsEnoughBag then begin
        PlayObject.m_ItemList.Add(UserItem);
        PlayObject.SendAddItem(UserItem);
      end else begin
        PlayObject.DropItemDown(UserItem, 3, False, PlayObject, nil);
        Dispose(UserItem);
      end;
    end;
  end;
  ItemList.Free;
end;

procedure TNormNpc.ActionOfAppDuel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sCharName: string;
  User: TPlayObject;
begin
  sCharName := QuestActionInfo.sParam1;
  GetVarValue(PlayObject, QuestActionInfo.sParam1, sCharName);

  User := UserEngine.GetPlayObject(sCharName);

  if User <> nil then begin
    PlayObject.ClientDuelTry(User);
  end;
end;

procedure TNormNpc.ActionOfAutoGotoXY(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nX, nY: Integer;
  sValue: string;
begin
  nX := Str_ToInt(QuestActionInfo.sParam1, -1);
  if nX < 0 then begin
    //GetVarValue(PlayObject, QuestActionInfo.sParam1, sValue, nX);
    //if nX < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AUTOGOTOXY);
    Exit;
    //end;
  end;
  nY := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nY < 0 then begin
    //GetVarValue(PlayObject, QuestActionInfo.sParam2, sValue, nY);
    //if nY < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AUTOGOTOXY);
    Exit;
    //end;
  end;
  PlayObject.SendDefMessage(SM_AUTOGOTOXY, Integer(PlayObject), nX, nY, 0, '');
end;

procedure TNormNpc.ActionOfChangeNewStatus(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nStatus: Integer;
  NewStatus: TNewStatus;
begin
  nStatus := Str_ToInt(QuestActionInfo.sParam1, -1);
  if not (nStatus in [0..2]) then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_CHANGENEWSTATUS);
    Exit;
  end;
  //UserEngine.GetPlayObject()
  NewStatus := TNewStatus(nStatus);
  BaseObject.m_LastSetStatus := BaseObject;
  BaseObject.SetNewStatus(NewStatus);
end;

procedure TNormNpc.ActionOfDelayGoto(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sLabel: string;
  nTime: Integer;
  TimeLabel: pTTimeLabel;
begin
  if PlayObject.m_TimeLabelList.Count < 30 then begin
    sLabel := QuestActionInfo.sParam2;
    nTime := Str_ToInt(QuestActionInfo.sParam1, -1);
    if (nTime > 0) and (sLabel <> '') then begin
      New(TimeLabel);
      TimeLabel.boDelete := False;
      TimeLabel.nType := 0;
      TimeLabel.sLabel := sLabel;
      TimeLabel.dwTime := GetTickCount + nTime;
      TimeLabel.boChangeMapDelete := not ((QuestActionInfo.sParam3 = '') or (QuestActionInfo.sParam3 = '0'));
      TimeLabel.Npc := Self;
      TimeLabel.Envir := PlayObject.m_PEnvir;
      AddLable(sLabel);
      PlayObject.m_TimeLabelList.Add(TimeLabel);
    end else ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DELAYGOTO);
  end;
end;

procedure TNormNpc.ActionOfSetScTimer(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  nIndex: Integer;
  nTime: Integer;
  TimeLabel: pTTimeLabel;
begin
  nIndex := Str_ToInt(QuestActionInfo.sParam1, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (nIndex in [0..19]) and (nTime >= 0) then begin
    for I := 0 to PlayObject.m_TimeLabelList.Count - 1 do begin
      TimeLabel := PlayObject.m_TimeLabelList.Items[I];
      if (TimeLabel.nType = 2) and (not TimeLabel.boDelete) and (TimeLabel.nIndex = nIndex) then begin
        TimeLabel.dwTime := nTime * 1000;
        TimeLabel.dwTick := GetTickCount;
        Exit;
      end;
    end;
    New(TimeLabel);
    TimeLabel.boDelete := False;
    TimeLabel.nType := 2;
    TimeLabel.nIndex := nIndex;
    TimeLabel.sLabel := '@OnTimer' + IntToStr(nIndex);
    TimeLabel.dwTime := nTime * 1000;
    TimeLabel.dwTick := GetTickCount;

    TimeLabel.boChangeMapDelete := False;
    TimeLabel.Npc := g_ManageNPC;
    TimeLabel.Envir := PlayObject.m_PEnvir;
    PlayObject.m_TimeLabelList.Add(TimeLabel);
  end else ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETSCTIMER);
end;

procedure TNormNpc.ActionOfKillScTimer(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  nIndex: Integer;
  TimeLabel: pTTimeLabel;
begin
  nIndex := Str_ToInt(QuestActionInfo.sParam1, -1);
  if (nIndex in [0..19]) then begin
    for I := 0 to PlayObject.m_TimeLabelList.Count - 1 do begin
      TimeLabel := PlayObject.m_TimeLabelList.Items[I];
      if (TimeLabel.nType = 2) and (not TimeLabel.boDelete) and (TimeLabel.nIndex = nIndex) then begin
        TimeLabel.boDelete := True;
        break;
      end;
    end;
  end else ScriptActionError(PlayObject, '', QuestActionInfo, sSC_KILLSCTIMER);
end;

procedure TNormNpc.ActionOfPlaySound(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sFileName: string;
begin
  sFileName := QuestActionInfo.sParam1;
  GetVarValue(PlayObject, sFileName, sFileName);
  PlayObject.SendMsg(PlayObject, RM_PLAYSOUND, 0, 0, 0, 0, sFileName);
end;

procedure TNormNpc.ActionOfShowEffect(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMapName: string;
  nX, nY: Integer;
  nEffect: Integer;
  nTime: Integer;
  Envir: TEnvirnoment;
  FlowerEvent: TFlowerEvent;
begin
  sMapName := QuestActionInfo.sParam1;
  nX := Str_ToInt(QuestActionInfo.sParam2, -1);
  nY := Str_ToInt(QuestActionInfo.sParam3, -1);
  nEffect := Str_ToInt(QuestActionInfo.sParam4, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam5, -1);
  if nX < 0 then
    GetVarValue(PlayObject, QuestActionInfo.sParam2, nX);

  if nY < 0 then
    GetVarValue(PlayObject, QuestActionInfo.sParam3, nY);

  if nEffect < 0 then
    GetVarValue(PlayObject, QuestActionInfo.sParam4, nEffect);

  if nTime < 0 then
    GetVarValue(PlayObject, QuestActionInfo.sParam5, nTime);

  Envir := g_MapManager.FindMap(sMapName);
  if Envir = nil then begin
    GetVarValue(PlayObject, sMapName, sMapName);
    Envir := g_MapManager.FindMap(sMapName);
  end;

  if (nX < 0) or (nY < 0) or (nEffect < 0) or (nTime < 0) or (Envir = nil) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SHOWEFFECT);
    Exit;
  end;

  case nEffect of
    1: FlowerEvent := TFlowerEvent.Create(Envir, nX, nY, ET_FIREFLOWER_1, 1000 * nTime);
    2: FlowerEvent := TFlowerEvent.Create(Envir, nX, nY, ET_FIREFLOWER_2, 1000 * nTime);
    3: FlowerEvent := TFlowerEvent.Create(Envir, nX, nY, ET_FIREFLOWER_3, 1000 * nTime);
    4: FlowerEvent := TFlowerEvent.Create(Envir, nX, nY, ET_FIREFLOWER_4, 1000 * nTime);
    5: FlowerEvent := TFlowerEvent.Create(Envir, nX, nY, ET_FIREFLOWER_5, 1000 * nTime);
    6: FlowerEvent := TFlowerEvent.Create(Envir, nX, nY, ET_FIREFLOWER_6, 1000 * nTime);
    7: FlowerEvent := TFlowerEvent.Create(Envir, nX, nY, ET_FIREFLOWER_7, 1000 * nTime);
    8: FlowerEvent := TFlowerEvent.Create(Envir, nX, nY, ET_FIREFLOWER_8, 1000 * nTime);
    9: FlowerEvent := TFlowerEvent.Create(Envir, nX, nY, ET_SPACEDOOR_1, 1000 * nTime);
    10: FlowerEvent := TFlowerEvent.Create(Envir, nX, nY, ET_SPACEDOOR_2, 1000 * nTime);
    11: FlowerEvent := TFlowerEvent.Create(Envir, nX, nY, ET_SPACEDOOR_3, 1000 * nTime);
    12: FlowerEvent := TFlowerEvent.Create(Envir, nX, nY, ET_SPACEDOOR_4, 1000 * nTime);
    13: FlowerEvent := TFlowerEvent.Create(Envir, nX, nY, ET_SPACEDOOR_5, 1000 * nTime);
  else FlowerEvent := TFlowerEvent.Create(Envir, nX, nY, ET_FIREFLOWER_1, 1000 * nTime);
  end;
  g_EventManager.AddEvent(FlowerEvent);
end;

procedure TNormNpc.ActionOfChangeItemValue(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  cMethod: Char;
  nValue, nOValue, nWhere: Integer;
  UserItem: pTUserItem;
  //StdItem: pTStdItem;
  //StdItem02: TStdItem;
  //boHigh: Boolean;
begin
  UserItem := nil;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;
  if UserItem <> nil then begin
    nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
    if QuestActionInfo.sParam2 <> '' then begin
      cMethod := QuestActionInfo.sParam2[1];
    end;
    nValue := Str_ToInt(QuestActionInfo.sParam3, -1);
    //StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if nWhere < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam1, nWhere); //增加变量支持
    if nValue < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam3, nValue); //增加变量支持

    if not ((nWhere in [0..9]) and (nValue in [0..255])) {or (StdItem = nil)} then begin
      PlayObject.SendChangeItemFail;
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEITEMVALUE);
      Exit;
    end;
    case cMethod of
      '+': begin
          ItemUnit.UpgradeItemsX_(UserItem, nWhere, nValue, 0);
        end;
      '-': begin
          ItemUnit.UpgradeItemsX_(UserItem, nWhere, nValue, 1);
        end;
      '=': begin
          ItemUnit.UpgradeItemsX_(UserItem, nWhere, nValue, 2);
        end;
    end;
    PlayObject.SendUpdateChangeItem(UserItem);
  end else begin
    PlayObject.SendChangeItemFail;
  end;
end;

procedure TNormNpc.ActionOfSendDelayMsg(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMsg: string;
  sParam1: string;
  sLabel: string;
  nTime: Integer;
  nColor: Integer;
  nDelete: Integer;
  TimeLabel: pTTimeLabel;
begin
  if PlayObject.m_TimeLabelList.Count < 30 then begin
    nTime := Str_ToInt(QuestActionInfo.sParam2, -1);
    nColor := Str_ToInt(QuestActionInfo.sParam3, 0);

    nDelete := Str_ToInt(QuestActionInfo.sParam4, 0);

    sLabel := QuestActionInfo.sParam5;
    sParam1 := QuestActionInfo.sParam1;
    if (sParam1 <> '') and (nTime > 0) and (sLabel <> '') then begin
      sMsg := GetLineVariableText(PlayObject, sParam1);
      GetVarValue(PlayObject, sMsg, sMsg);
  //sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.m_sCharName);
      sMsg := AnsiReplaceText(sMsg, '%x', IntToStr(PlayObject.m_nCurrX));
      sMsg := AnsiReplaceText(sMsg, '%y', IntToStr(PlayObject.m_nCurrY));
      if PlayObject.m_PEnvir <> nil then
        sMsg := AnsiReplaceText(sMsg, '%m', PlayObject.m_PEnvir.sMapDesc)
      else sMsg := AnsiReplaceText(sMsg, '%m', '????');
      sMsg := AnsiReplaceText(sMsg, '%d', m_sCharName);

      New(TimeLabel);
      TimeLabel.boDelete := False;
      TimeLabel.nType := 1;
      TimeLabel.sLabel := sLabel;
      TimeLabel.dwTime := GetTickCount + nTime * 1000;
      TimeLabel.boChangeMapDelete := nDelete <> 0;
      TimeLabel.Npc := Self;
      TimeLabel.Envir := PlayObject.m_PEnvir;
      AddLable(sLabel);
      PlayObject.m_TimeLabelList.Add(TimeLabel);
      PlayObject.SendMsg(PlayObject, RM_DELAYMESSAGE, nTime, Integer(TimeLabel), nColor, 0, sMsg);
    //PlayObject.m_TimeMsgLabel.AddObject(sLabel, TObject(GetTickCount + nTime * 1000));
    //MainOutMessage(sMsg + ' sLabel:' + sLabel);
    end else ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SENDDELAYMSG);
  end;
end;

procedure TNormNpc.ActionOfSetMasked(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  boMaskedActor: Boolean;
begin
  boMaskedActor := BaseObject.m_boMaskedActor;
  BaseObject.m_boMaskedActor := QuestActionInfo.sParam1 = '1';
  if boMaskedActor <> BaseObject.m_boMaskedActor then begin
    BaseObject.RecalcAbilitys;
    BaseObject.RefShowName;
  end;
end;

procedure TNormNpc.ActionOfLock(BaseObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  X, Y, nX, nY: Integer;
  SpaceLockEvent: TSpaceLockEvent;
  nMinX, nMaxX, nMinY, nMaxY: Integer;
  nRange, nType, nTime, nPoint: Integer;
  BaseObjectList: TList;
  boFind: Boolean;
  Event: TEvent;
  Envir: TEnvirnoment;
  ActorObject: TActorObject;
  PlayObject: TPlayObject;
  sMapName: string;
begin
 { if m_boSpaceLock then begin
    BaseObject.SysMsg('空间已经被锁定！', c_Red, t_Notice);
    Exit;
  end; }
  sMapName := QuestActionInfo.sParam1;

  Envir := g_MapManager.FindMap(sMapName);
  if Envir = nil then begin
    GetVarValue(BaseObject, QuestActionInfo.sParam1, sMapName);
    Envir := g_MapManager.FindMap(sMapName);
  end;

  if Envir = nil then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_LOCK);
    Exit;
  end;

  PlayObject := TPlayObject(Envir.m_PlayObject);

  if PlayObject.m_boSpaceLock then begin
    Exit;
  end;

  nX := Str_ToInt(QuestActionInfo.sParam2, -1);
  nY := Str_ToInt(QuestActionInfo.sParam3, -1);

  nRange := Str_ToInt(QuestActionInfo.sParam4, -1);
  nType := Str_ToInt(QuestActionInfo.sParam5, -1);
  //nTime := Str_ToInt(QuestActionInfo.sParam6, -1);

  if (nX < 0) then GetVarValue(BaseObject, QuestActionInfo.sParam2, nX);
  if (nY < 0) then GetVarValue(BaseObject, QuestActionInfo.sParam3, nY);
  if (nRange < 0) then GetVarValue(BaseObject, QuestActionInfo.sParam4, nRange);
  if (nType < 0) then GetVarValue(BaseObject, QuestActionInfo.sParam5, nType);

  if (nX < 0) or (nY < 0) or (nRange < 0) or (nType < 0) then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_LOCK);
    Exit;
  end;

  {
  nMinX:=PlayObject.m_nCurrX - nRange;
  nMaxX:=PlayObject.m_nCurrX + nRange;
  nMinY:=PlayObject.m_nCurrY - nRange;
  nMaxY:=PlayObject.m_nCurrY + nRange;
  }

  nMinX := _MAX(nX - nRange, 0);
  nMaxX := _MIN(nX + nRange, Envir.m_nWidth);
  nMinY := _MAX(nY - nRange, 0);
  nMaxY := _MIN(nY + nRange, Envir.m_nHeight);

  boFind := False;
  BaseObjectList := TList.Create;
  GetMapEvents(Envir, nX, nY, nRange, BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    Event := TEvent(BaseObjectList.Items[I]);
    if Event.m_nServerEventType = ET_MAGICLOCK then begin
      boFind := True;
      Break;
    end;
  end;
  BaseObjectList.Free;

  if boFind then begin
    //BaseObject.SysMsg('当前范围内已经有空间已经被锁定！', c_Red, t_Notice);
  end else begin
    BaseObjectList := TList.Create;
    GetMapActorObjects(Envir, nX, nY, nRange - 1, BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do begin
      ActorObject := TActorObject(BaseObjectList.Items[I]);
      if (ActorObject <> Self) { and (ActorObject.m_Master = nil)} then begin
        ActorObject.m_SpaceOwner := Self;
        ActorObject.m_boSpaceLock := True;
        ActorObject.m_SpaceRect := Rect(nX - nRange, nY - nRange, nX + nRange, nY + nRange);
        PlayObject.AddLock(ActorObject);
      end;
    end;
    BaseObjectList.Free;

    PlayObject.m_SpaceOwner := Self;
    PlayObject.m_boSpaceLock := True;
    PlayObject.m_SpaceRect := Rect(nX - nRange, nY - nRange, nX + nRange, nY + nRange);

    for X := nMinX to nMaxX do begin
      for Y := nMinY to nMaxY do begin
        if ((X < nMaxX) and (Y = nMinY)) or
          ((Y < nMaxY) and (X = nMinX)) or
          (X = nMaxX) or (Y = nMaxY) then begin
          SpaceLockEvent := TSpaceLockEvent.Create(PlayObject, X, Y, nType, 10 * 1000);
          SpaceLockEvent.m_boAllowClose := False;
          g_EventManager.AddEvent(SpaceLockEvent);
        end;
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfPowerRate(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate: Integer;
  nTime: Integer;
  PlayObject: TPlayObject;
  HeroObject: THeroObject;
begin
  nRate := Str_ToInt(QuestActionInfo.sParam1, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (nRate < 0) or (nTime < 0) then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_POWERRATE);
    Exit;
  end;
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    PlayObject := TPlayObject(BaseObject);
    PlayObject.m_nPowerRate := nRate;
  //PlayObject.m_dwPowerRateTime:=_MIN(High(Word),nTime);
    PlayObject.m_dwPowerRateTime := LongWord(nTime);
    if g_Config.boShowScriptActionMsg then begin
      PlayObject.SysMsg(Format(g_sChangePowerRateMsg, [PlayObject.m_nPowerRate / 100, PlayObject.m_dwPowerRateTime]), c_Green, t_Hint);
    end;
  end else begin
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      HeroObject := THeroObject(BaseObject);
      HeroObject.m_nPowerRate := nRate;
  //PlayObject.m_dwPowerRateTime:=_MIN(High(Word),nTime);
      HeroObject.m_dwPowerRateTime := LongWord(nTime);
      if g_Config.boShowScriptActionMsg then begin
        HeroObject.SysMsg(Format(g_sChangePowerRateMsg, [HeroObject.m_nPowerRate / 100, HeroObject.m_dwPowerRateTime]), c_Green, t_Hint);
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfChangeMode(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nMode: Integer;
  boOpen: Boolean;
begin
  nMode := QuestActionInfo.nParam1;
  boOpen := Str_ToInt(QuestActionInfo.sParam2, -1) = 1;
  if nMode in [1..3] then begin
    case nMode of //
      1: begin
          BaseObject.m_boAdminMode := boOpen;
          if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
            if BaseObject.m_boAdminMode then BaseObject.SysMsg(sGameMasterMode, c_Green, t_Hint)
            else BaseObject.SysMsg(sReleaseGameMasterMode, c_Green, t_Hint);
          end;
        end;
      2: begin
          BaseObject.m_boSuperMan := boOpen;
          if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
            if BaseObject.m_boSuperMan then
              BaseObject.SysMsg(sSupermanMode, c_Green, t_Hint)
            else BaseObject.SysMsg(sReleaseSupermanMode, c_Green, t_Hint);
          end;
        end;
      3: begin
          BaseObject.m_boObMode := boOpen;
          if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
            if BaseObject.m_boObMode then BaseObject.SysMsg(sObserverMode, c_Green, t_Hint)
            else BaseObject.SysMsg(g_sReleaseObserverMode, c_Green, t_Hint);
          end;
        end;
    end;
  end else begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_CHANGEMODE);
  end;
end;

procedure TNormNpc.ActionOfChangePerMission(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nPermission: Integer;
begin
  nPermission := Str_ToInt(QuestActionInfo.sParam1, -1);
  if nPermission in [0..10] then begin
    BaseObject.m_btPermission := nPermission;
  end else begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_CHANGEPERMISSION);
    Exit;
  end;
  if g_Config.boShowScriptActionMsg then begin
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
      BaseObject.SysMsg(Format(g_sChangePermissionMsg, [BaseObject.m_btPermission]), c_Green, t_Hint);
    end;
  end;
end;

procedure TNormNpc.ActionOfGiveItem(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
  function IsEnoughBag: Boolean;
  begin
    Result := False;
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      Result := TPlayObject(BaseObject).IsEnoughBag;
    end else begin
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
        Result := THeroObject(BaseObject).IsEnoughBag;
      end;
    end;
  end;
  procedure SendAddItem(UserItem: pTUserItem);
  begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      TPlayObject(BaseObject).SendAddItem(UserItem);
    end else begin
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
        THeroObject(BaseObject).SendAddItem(UserItem);
      end;
    end;
  end;
var
  I: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  sItemName: string;
  nItemCount: Integer;
begin
  sItemName := QuestActionInfo.sParam1;
  nItemCount := QuestActionInfo.nParam2;
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    sItemName := QuestActionInfo.sParam1;
    nItemCount := QuestActionInfo.nParam2;
    GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam1, sItemName);
    GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam2, nItemCount);
  end else
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    sItemName := QuestActionInfo.sParam1;
    nItemCount := QuestActionInfo.nParam2;
    GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam1, sItemName);
    GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam2, nItemCount);
  end;

  if (sItemName = '') or (nItemCount <= 0) then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_GIVE);
    Exit;
  end;

  if nItemCount <= 0 then Exit;

  if CompareText(sItemName, sSTRING_GOLDNAME) = 0 then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      TPlayObject(BaseObject).IncGold(nItemCount);
      TPlayObject(BaseObject).GoldChanged();
      if g_boGameLogGold then
        AddGameDataLog('9' + #9 +
          BaseObject.m_sMapName + #9 +
          IntToStr(BaseObject.m_nCurrX) + #9 +
          IntToStr(BaseObject.m_nCurrY) + #9 +
          BaseObject.m_sCharName + #9 +
          sSTRING_GOLDNAME + #9 +
          IntToStr(nItemCount) + #9 +
          '1' + #9 +
          m_sCharName);
    end;
    Exit;
  end;

  if (BaseObject.m_btRaceServer = RC_HEROOBJECT) and (CompareText(sItemName, sSTRING_GOLDNAME) = 0) then Exit;
  if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
    if UserEngine.GetStdItemIdx(sItemName) > 0 then begin
    //    if nItemCount > 50 then nItemCount:=50;//11.22 限制数量大小
      if not (nItemCount in [1..50]) then nItemCount := 1; //12.28 改上一条
      for I := 0 to nItemCount - 1 do begin //nItemCount 为0时出死循环
        if IsEnoughBag then begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin

            UserEngine._RandomItemLimitDay(UserItem, g_Config.nScriptRandomNotLimit);

            BaseObject.m_ItemList.Add((UserItem));
            SendAddItem(UserItem);
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);

            //ScriptActionError(BaseObject, '', QuestActionInfo, sSC_GIVE);

            if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) and (QuestActionInfo.sParam3 = '1') then begin
              TPlayObject(BaseObject).m_sUpgradeItemName := sItemName;
              TPlayObject(BaseObject).m_nUpgradeItemIndex := UserItem.MakeIndex;
              TPlayObject(BaseObject).m_nItemIndex := BaseObject.m_ItemList.Count - 1;
              TPlayObject(BaseObject).m_boUpgradeNPC := False;
            end;

            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('9' + #9 +
                BaseObject.m_sMapName + #9 +
                IntToStr(BaseObject.m_nCurrX) + #9 +
                IntToStr(BaseObject.m_nCurrY) + #9 +
                BaseObject.m_sCharName + #9 +
                sItemName + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                m_sCharName);
          end else Dispose(UserItem);
        end else begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin

            UserEngine._RandomItemLimitDay(UserItem, g_Config.nScriptRandomNotLimit);

            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if StdItem <> nil then begin
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('9' + #9 +
                  BaseObject.m_sMapName + #9 +
                  IntToStr(BaseObject.m_nCurrX) + #9 +
                  IntToStr(BaseObject.m_nCurrY) + #9 +
                  BaseObject.m_sCharName + #9 +
                  sItemName + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  '1' + #9 +
                  m_sCharName);
              BaseObject.DropItemDown(UserItem, 3, False, BaseObject, nil);
            end;
          end;
          Dispose(UserItem);
        end;
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfGiveExItem(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
  function IsEnoughBag: Boolean;
  begin
    Result := False;
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      Result := TPlayObject(BaseObject).IsEnoughBag;
    end else begin
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
        Result := THeroObject(BaseObject).IsEnoughBag;
      end;
    end;
  end;
  procedure SendAddItem(UserItem: pTUserItem);
  begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      TPlayObject(BaseObject).SendAddItem(UserItem);
    end else begin
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
        THeroObject(BaseObject).SendAddItem(UserItem);
      end;
    end;
  end;
var
  I: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  sItemName: string;
  nItemCount: Integer;
begin
  sItemName := QuestActionInfo.sParam1;
  nItemCount := QuestActionInfo.nParam2;
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    sItemName := QuestActionInfo.sParam1;
    nItemCount := QuestActionInfo.nParam2;
    GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam1, sItemName);
    GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam2, nItemCount);
  end else
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    sItemName := QuestActionInfo.sParam1;
    nItemCount := QuestActionInfo.nParam2;
    GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam1, sItemName);
    GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam2, nItemCount);
  end;

  if (sItemName = '') or (nItemCount <= 0) then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_GIVEEX);
    Exit;
  end;
  if nItemCount <= 0 then Exit;
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    if CompareText(sItemName, sSTRING_GOLDNAME) = 0 then begin
      TPlayObject(BaseObject).IncGold(nItemCount);
      TPlayObject(BaseObject).GoldChanged();
      if g_boGameLogGold then
        AddGameDataLog('9' + #9 +
          BaseObject.m_sMapName + #9 +
          IntToStr(BaseObject.m_nCurrX) + #9 +
          IntToStr(BaseObject.m_nCurrY) + #9 +
          BaseObject.m_sCharName + #9 +
          sSTRING_GOLDNAME + #9 +
          IntToStr(nItemCount) + #9 +
          '1' + #9 +
          m_sCharName);
      Exit;
    end;
  end;

  if (BaseObject.m_btRaceServer = RC_HEROOBJECT) and (CompareText(sItemName, sSTRING_GOLDNAME) = 0) then Exit;
  if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
    if UserEngine.GetStdItemIdx(sItemName) > 0 then begin
    //    if nItemCount > 50 then nItemCount:=50;//11.22 限制数量大小
      if not (nItemCount in [1..50]) then nItemCount := 1; //12.28 改上一条
      for I := 0 to nItemCount - 1 do begin //nItemCount 为0时出死循环
        if IsEnoughBag then begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin

            if Random(g_Config.nScriptRandomAddValue {10}) = 0 then //几率控制
              UserEngine.RandomUpgradeItem(UserItem); //生成极品装备

            UserEngine._RandomItemLimitDay(UserItem, g_Config.nScriptRandomNotLimit);
            if Random(g_Config.nScriptRandomNewAddValue {10}) = 0 then
              UserEngine._RandomUpgradeItem(UserItem);

            if Random(g_Config.nScriptRandomAddPoint) = 0 then
              UserEngine.RandomItemAddPoint(UserItem);

            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if StdItem <> nil then begin
              if StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26] then begin
                if StdItem.Shape in [130, 131, 132] then begin
                  UserEngine.GetUnknowItemValue(UserItem);

                  UserEngine._GetUnknowItemValue(UserItem);

                end;
              end;
            end;

            BaseObject.m_ItemList.Add(UserItem);
            SendAddItem(UserItem);
            if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) and (QuestActionInfo.sParam3 = '1') then begin
              TPlayObject(BaseObject).m_sUpgradeItemName := sItemName;
              TPlayObject(BaseObject).m_nUpgradeItemIndex := UserItem.MakeIndex;
              TPlayObject(BaseObject).m_nItemIndex := BaseObject.m_ItemList.Count - 1;
              TPlayObject(BaseObject).m_boUpgradeNPC := False;
            end;
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('9' + #9 +
                BaseObject.m_sMapName + #9 +
                IntToStr(BaseObject.m_nCurrX) + #9 +
                IntToStr(BaseObject.m_nCurrY) + #9 +
                BaseObject.m_sCharName + #9 +
                sItemName + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                m_sCharName);
          end else Dispose(UserItem);
        end else begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
            if Random(g_Config.nScriptRandomAddValue {10}) = 0 then //几率控制
              UserEngine.RandomUpgradeItem(UserItem); //生成极品装备

            UserEngine._RandomItemLimitDay(UserItem, g_Config.nScriptRandomNotLimit);
            if Random(g_Config.nScriptRandomNewAddValue) = 0 then
              UserEngine._RandomUpgradeItem(UserItem);

            if Random(g_Config.nScriptRandomAddPoint) = 0 then
              UserEngine.RandomItemAddPoint(UserItem);

            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if StdItem <> nil then begin
              if StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26] then begin
                if StdItem.Shape in [130, 131, 132] then begin
                  UserEngine.GetUnknowItemValue(UserItem);

                  UserEngine._GetUnknowItemValue(UserItem);

                end;
              end;

              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('9' + #9 +
                  BaseObject.m_sMapName + #9 +
                  IntToStr(BaseObject.m_nCurrX) + #9 +
                  IntToStr(BaseObject.m_nCurrY) + #9 +
                  BaseObject.m_sCharName + #9 +
                  sItemName + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  '1' + #9 +
                  m_sCharName);
              BaseObject.DropItemDown(UserItem, 3, False, BaseObject, nil);
            end;
          end;
          Dispose(UserItem);
        end;
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfGmExecute(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sData: string;
  btOldPermission: Byte;
  sParam1, sParam2, sParam3, sParam4, sParam5, sParam6: string;
  nParam2, nParam3, nParam4, nParam5, nParam6: Integer;
begin
  sParam1 := QuestActionInfo.sParam1;
  sParam2 := QuestActionInfo.sParam2;
  sParam3 := QuestActionInfo.sParam3;
  sParam4 := QuestActionInfo.sParam4;
  sParam5 := QuestActionInfo.sParam5;
  sParam6 := QuestActionInfo.sParam6;

  if GetVarValue(PlayObject, sParam2, sParam2).VarType = vInteger then GetVarValue(PlayObject, sParam2, nParam2);
  if GetVarValue(PlayObject, sParam3, sParam3).VarType = vInteger then GetVarValue(PlayObject, sParam3, nParam3);
  if GetVarValue(PlayObject, sParam4, sParam4).VarType = vInteger then GetVarValue(PlayObject, sParam4, nParam4);
  if GetVarValue(PlayObject, sParam5, sParam5).VarType = vInteger then GetVarValue(PlayObject, sParam5, nParam5);
  if GetVarValue(PlayObject, sParam6, sParam6).VarType = vInteger then GetVarValue(PlayObject, sParam6, nParam6);

  if CompareText(sParam2, 'Self') = 0 then sParam2 := PlayObject.m_sCharName;
  sData := Format('@%s %s %s %s %s %s', [sParam1,
    sParam2,
      sParam3,
      sParam4,
      sParam5,
      sParam6]);
  btOldPermission := PlayObject.m_btPermission;
  try
    PlayObject.m_btPermission := 10;
    PlayObject.ProcessUserLineMsg(sData);
    //MainOutMessage('TNormNpc.ActionOfGmExecute '+sData);
  finally
    PlayObject.m_btPermission := btOldPermission;
  end;
end;

procedure TNormNpc.ActionOfGuildAuraePoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nAuraePoint: Integer;
  cMethod: Char;
  Guild: TGUild;
begin
  nAuraePoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nAuraePoint < 0 then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam2, nAuraePoint);
    if nAuraePoint < 0 then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AURAEPOINT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    PlayObject.SysMsg(g_sScriptGuildAuraePointNoGuild, c_Red, t_Hint);
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        Guild.nAurae := nAuraePoint;
      end;
    '-': begin
        if Guild.nAurae >= nAuraePoint then begin
          Guild.nAurae := Guild.nAurae - nAuraePoint;
        end else begin
          Guild.nAurae := 0;
        end;
      end;
    '+': begin
        if (High(Integer) - Guild.nAurae) >= nAuraePoint then begin
          Guild.nAurae := Guild.nAurae + nAuraePoint;
        end else begin
          Guild.nAurae := High(Integer);
        end;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sScriptGuildAuraePointMsg, [Guild.nAurae]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfGuildBuildPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nBuildPoint: Integer;
  cMethod: Char;
  Guild: TGUild;
begin
  nBuildPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nBuildPoint < 0 then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam2, nBuildPoint);
    if nBuildPoint < 0 then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_BUILDPOINT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    PlayObject.SysMsg(g_sScriptGuildBuildPointNoGuild, c_Red, t_Hint);
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        Guild.nBuildPoint := nBuildPoint;
      end;
    '-': begin
        if Guild.nBuildPoint >= nBuildPoint then begin
          Guild.nBuildPoint := Guild.nBuildPoint - nBuildPoint;
        end else begin
          Guild.nBuildPoint := 0;
        end;
      end;
    '+': begin
        if (High(Integer) - Guild.nBuildPoint) >= nBuildPoint then begin
          Guild.nBuildPoint := Guild.nBuildPoint + nBuildPoint;
        end else begin
          Guild.nBuildPoint := High(Integer);
        end;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sScriptGuildBuildPointMsg, [Guild.nBuildPoint]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfGuildChiefItemCount(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nItemCount: Integer;
  cMethod: Char;
  Guild: TGUild;
begin
  nItemCount := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nItemCount < 0 then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam2, nItemCount);
    if nItemCount < 0 then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GUILDCHIEFITEMCOUNT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    PlayObject.SysMsg(g_sScriptGuildFlourishPointNoGuild, c_Red, t_Hint);
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        Guild.nChiefItemCount := nItemCount;
      end;
    '-': begin
        if Guild.nChiefItemCount >= nItemCount then begin
          Guild.nChiefItemCount := Guild.nChiefItemCount - nItemCount;
        end else begin
          Guild.nChiefItemCount := 0;
        end;
      end;
    '+': begin
        if (High(Integer) - Guild.nChiefItemCount) >= nItemCount then begin
          Guild.nChiefItemCount := Guild.nChiefItemCount + nItemCount;
        end else begin
          Guild.nChiefItemCount := High(Integer);
        end;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sScriptChiefItemCountMsg, [Guild.nChiefItemCount]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfGuildFlourishPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nFlourishPoint: Integer;
  cMethod: Char;
  Guild: TGUild;
begin
  nFlourishPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nFlourishPoint < 0 then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam2, nFlourishPoint);
    if nFlourishPoint < 0 then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_FLOURISHPOINT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    PlayObject.SysMsg(g_sScriptGuildFlourishPointNoGuild, c_Red, t_Hint);
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        Guild.nFlourishing := nFlourishPoint;
      end;
    '-': begin
        if Guild.nFlourishing >= nFlourishPoint then begin
          Guild.nFlourishing := Guild.nFlourishing - nFlourishPoint;
        end else begin
          Guild.nFlourishing := 0;
        end;
      end;
    '+': begin
        if (High(Integer) - Guild.nFlourishing) >= nFlourishPoint then begin
          Guild.nFlourishing := Guild.nFlourishing + nFlourishPoint;
        end else begin
          Guild.nFlourishing := High(Integer);
        end;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sScriptGuildFlourishPointMsg, [Guild.nFlourishing]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfGuildstabilityPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);

var
  nStabilityPoint: Integer;
  cMethod: Char;
  Guild: TGUild;
begin
  nStabilityPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nStabilityPoint < 0 then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam2, nStabilityPoint);
    if nStabilityPoint < 0 then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_STABILITYPOINT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    PlayObject.SysMsg(g_sScriptGuildStabilityPointNoGuild, c_Red, t_Hint);
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        Guild.nStability := nStabilityPoint;
      end;
    '-': begin
        if Guild.nStability >= nStabilityPoint then begin
          Guild.nStability := Guild.nStability - nStabilityPoint;
        end else begin
          Guild.nStability := 0;
        end;
      end;
    '+': begin
        if (High(Integer) - Guild.nStability) >= nStabilityPoint then begin
          Guild.nStability := Guild.nStability + nStabilityPoint;
        end else begin
          Guild.nStability := High(Integer);
        end;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sScriptGuildStabilityPointMsg, [Guild.nStability]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfHumanHP(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nHP: Integer;
  cMethod: Char;
begin
  nHP := Str_ToInt(QuestActionInfo.sParam2, -1);
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam2, nHP); //增加变量支持
  end else
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
    GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam2, nHP); //增加变量支持
  end;
  if nHP < 0 then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_HUMANHP);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        BaseObject.m_WAbil.HP := nHP;
      end;
    '-': begin
        if BaseObject.m_WAbil.HP >= nHP then begin
          Dec(BaseObject.m_WAbil.HP, nHP);
        end else begin
          BaseObject.m_WAbil.HP := 0;
        end;
      end;
    '+': begin
        Inc(BaseObject.m_WAbil.HP, nHP);
        if BaseObject.m_WAbil.HP > BaseObject.m_WAbil.MaxHP then BaseObject.m_WAbil.HP := BaseObject.m_WAbil.MaxHP;
      end;
  end;
  if (not BaseObject.m_boAI) and (BaseObject.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT]) then
    BaseObject.HealthSpellChanged();
  {if g_Config.boShowScriptActionMsg then begin
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
      BaseObject.SysMsg(Format(g_sScriptChangeHumanHPMsg, [BaseObject.m_WAbil.MaxHP]), c_Green, t_Hint);
    end;
  end;}
end;

procedure TNormNpc.ActionOfHumanMP(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nMP: Integer;
  cMethod: Char;
begin
  nMP := Str_ToInt(QuestActionInfo.sParam2, -1);
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam2, nMP); //增加变量支持
  end else
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
    GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam2, nMP); //增加变量支持
  end;
  if nMP < 0 then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_HUMANMP);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        BaseObject.m_WAbil.MP := nMP;
      end;
    '-': begin
        if BaseObject.m_WAbil.MP >= nMP then begin
          Dec(BaseObject.m_WAbil.MP, nMP);
        end else begin
          BaseObject.m_WAbil.MP := 0;
        end;
      end;
    '+': begin
        Inc(BaseObject.m_WAbil.MP, nMP);
        if BaseObject.m_WAbil.MP > BaseObject.m_WAbil.MaxMP then BaseObject.m_WAbil.MP := BaseObject.m_WAbil.MaxMP;
      end;
  end;
  {if g_Config.boShowScriptActionMsg then begin
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
      BaseObject.SysMsg(Format(g_sScriptChangeHumanMPMsg, [BaseObject.m_WAbil.MaxMP]), c_Green, t_Hint);
    end;
  end;}
end;

procedure TNormNpc.ActionOfUseBonusPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
  procedure IncValue(var wValue: Word; nIncValue: Integer);
  begin
    if wValue + nIncValue > High(Word) then wValue := High(Word)
    else wValue := wValue + nIncValue;
  end;
  procedure DecValue(var wValue: Word; nDecValue: Integer);
  begin
    if wValue < nDecValue then wValue := 0
    else wValue := wValue - nDecValue;
  end;
  procedure SetValue(var wValue: Word; nSetValue: Integer);
  begin
    if nSetValue > High(Word) then wValue := High(Word)
    else if nSetValue < 0 then wValue := 0
    else wValue := nSetValue;
  end;
var
  nPosition, nCount, nTime: Integer;
  cMethod: Char;
  dwTimeOutTick: LongWord;
begin
  nPosition := Str_ToInt(QuestActionInfo.sParam1, -1);
  cMethod := QuestActionInfo.sParam2[1];
  nCount := Str_ToInt(QuestActionInfo.sParam3, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam4, -1);
  if (nPosition < 1) or (nPosition > 7) or (nCount < 0) or (nTime < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_USEBONUSPOINT);
    Exit;
  end;
  case cMethod of
    '+': begin
        IncValue(PlayObject.m_wNewStatusArrValue[nPosition - 1], nCount);
        dwTimeOutTick := PlayObject.m_dwNewStatusArrTimeOutTick[nPosition - 1];
        dwTimeOutTick := _MAX(dwTimeOutTick - GetTickCount, 0);
        PlayObject.m_dwNewStatusArrTimeOutTick[nPosition - 1] := GetTickCount + nTime * 1000 + dwTimeOutTick;
        //Inc(PlayObject.m_dwNewStatusArrTimeOutTick[nPosition - 1], GetTickCount + nTime * 1000);
      end;
    '-': begin
        IncValue(PlayObject.m_wNewStatusArrValue[nPosition - 1 + 7], nCount);
        dwTimeOutTick := PlayObject.m_dwNewStatusArrTimeOutTick[nPosition - 1 + 7];
        dwTimeOutTick := _MAX(dwTimeOutTick - GetTickCount, 0);
        PlayObject.m_dwNewStatusArrTimeOutTick[nPosition - 1 + 7] := GetTickCount + nTime * 1000 + dwTimeOutTick;
        //Inc(PlayObject.m_dwNewStatusArrTimeOutTick[nPosition - 1 + 7], GetTickCount + nTime * 1000);
      end;
  end;
  PlayObject.RecalcAbilitys;
  PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
end;

procedure TNormNpc.ActionOfKick(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_boKickFlag := True;
end;

procedure TNormNpc.ActionOfKickAll(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[I]);
      PlayObject.m_boNotOnlineAddExp := False;
      PlayObject.m_boPlayOffLine := False;
      PlayObject.m_boEmergencyClose := True;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

procedure TNormNpc.ActionOfKill(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nMode: Integer;
begin
  nMode := Str_ToInt(QuestActionInfo.sParam1, -1);
  if nMode in [0..3] then begin
    case nMode of //
      1: begin
          BaseObject.m_boNoItem := True;
          BaseObject.Die;
        end;
      2: begin
          BaseObject.SetLastHiter(Self);
          BaseObject.Die;
        end;
      3: begin
          BaseObject.m_boNoItem := True;
          BaseObject.SetLastHiter(Self);
          BaseObject.Die;
        end;
    else begin
        BaseObject.Die;
      end;
    end;
  end else begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_KILL);
  end;
end;

procedure TNormNpc.ActionOfBonusPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nBonusPoint: Integer;
  nPoint: Integer;
  nOldPKLevel: Integer;
  cMethod: Char;
begin
  nBonusPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nBonusPoint < 0 then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam2, nBonusPoint); //增加变量支持
  end;
  if (nBonusPoint < 0) or (nBonusPoint > 10000) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_BONUSPOINT);
    Exit;
  end;

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        FillChar(PlayObject.m_BonusAbil, SizeOf(TNakedAbility), #0);
        //PlayObject.HasLevelUp(0);
        PlayObject.m_nBonusPoint := nBonusPoint;
        PlayObject.RecalcLevelAbilitys();
        PlayObject.RecalcAbilitys();
        PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
      end;
    '-': begin
        if PlayObject.m_nBonusPoint >= nBonusPoint then begin
          Dec(PlayObject.m_nBonusPoint, nBonusPoint);
        end else begin
          PlayObject.m_nBonusPoint := 0;
        end;
        PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
      end;
    '+': begin
        Inc(PlayObject.m_nBonusPoint, nBonusPoint);
        PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
      end;
  end;
end;

procedure TNormNpc.ActionOfDelMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_sDearName := '';
  PlayObject.RefShowName;
end;

procedure TNormNpc.ActionOfDelMaster(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_sMasterName := '';
  PlayObject.RefShowName;
end;

procedure TNormNpc.ActionOfRestBonusPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nTotleUsePoint: Integer;
begin
  nTotleUsePoint := PlayObject.m_BonusAbil.DC +
    PlayObject.m_BonusAbil.MC +
    PlayObject.m_BonusAbil.SC +
    PlayObject.m_BonusAbil.AC +
    PlayObject.m_BonusAbil.MAC +
    PlayObject.m_BonusAbil.HP +
    PlayObject.m_BonusAbil.MP +
    PlayObject.m_BonusAbil.Hit +
    PlayObject.m_BonusAbil.Speed +
    PlayObject.m_BonusAbil.X2;
  FillChar(PlayObject.m_BonusAbil, SizeOf(TNakedAbility), #0);
  Inc(PlayObject.m_nBonusPoint, nTotleUsePoint);
  PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
  PlayObject.RecalcLevelAbilitys;
  PlayObject.RecalcAbilitys;
  PlayObject.SysMsg('Ability Points have been reset', c_Red, t_Hint);
end;

procedure TNormNpc.ActionOfRestReNewLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_btReLevel := 0;
  PlayObject.HasLevelUp(0);
end;

procedure TNormNpc.ActionOfSetMapMode(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Envir: TEnvirnoment;
  sMapName: string;
  sMapMode, sParam1, sParam2 {,sParam3,sParam4}: string;
begin
  sMapName := QuestActionInfo.sParam1;
  sMapMode := QuestActionInfo.sParam2;
  sParam1 := QuestActionInfo.sParam3;
  sParam2 := QuestActionInfo.sParam4;
  //  sParam3:=QuestActionInfo.sParam5;
  //  sParam4:=QuestActionInfo.sParam6;

  Envir := g_MapManager.FindMap(sMapName);
  if (Envir = nil) or (sMapMode = '') then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_SETMAPMODE);
    Exit;
  end;
  if CompareText(sMapMode, 'SAFE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boSAFE := True;
    end else begin
      Envir.m_boSAFE := False;
    end;
  end else
    if CompareText(sMapMode, 'DARK') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boDARK := True;
    end else begin
      Envir.m_boDARK := False;
    end;
  end else
    if CompareText(sMapMode, 'DARK') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boDARK := True;
    end else begin
      Envir.m_boDARK := False;
    end;
  end else
    if CompareText(sMapMode, 'FIGHT') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boFightZone := True;
    end else begin
      Envir.m_boFightZone := False;
    end;
  end else
    if CompareText(sMapMode, 'FIGHT3') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boFight3Zone := True;
    end else begin
      Envir.m_boFight3Zone := False;
    end;
  end else
    if CompareText(sMapMode, 'DAY') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boDAY := True;
    end else begin
      Envir.m_boDAY := False;
    end;
  end else
    if CompareText(sMapMode, 'QUIZ') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boQUIZ := True;
    end else begin
      Envir.m_boQUIZ := False;
    end;
  end else
    if CompareText(sMapMode, 'NORECONNECT') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNORECONNECT := True;
      Envir.sNoReconnectMap := sParam1;
    end else begin
      Envir.m_boNORECONNECT := False;
    end;
  end else
    if CompareText(sMapMode, 'MUSIC') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boMUSIC := True;
      Envir.m_nMUSICID := Str_ToInt(sParam1, -1);
    end else begin
      Envir.m_boMUSIC := False;
    end;
  end else
    if CompareText(sMapMode, 'EXPRATE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boEXPRATE := True;
      Envir.m_nEXPRATE := Str_ToInt(sParam1, -1);
    end else begin
      Envir.m_boEXPRATE := False;
    end;
  end else
    if CompareText(sMapMode, 'PKWINLEVEL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boPKWINLEVEL := True;
      Envir.m_nPKWINLEVEL := Str_ToInt(sParam1, -1);
    end else begin
      Envir.m_boPKWINLEVEL := False;
    end;
  end else
    if CompareText(sMapMode, 'PKWINEXP') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boPKWINEXP := True;
      Envir.m_nPKWINEXP := Str_ToInt(sParam1, -1);
    end else begin
      Envir.m_boPKWINEXP := False;
    end;
  end else
    if CompareText(sMapMode, 'PKLOSTLEVEL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boPKLOSTLEVEL := True;
      Envir.m_nPKLOSTLEVEL := Str_ToInt(sParam1, -1);
    end else begin
      Envir.m_boPKLOSTLEVEL := False;
    end;
  end else
    if CompareText(sMapMode, 'PKLOSTEXP') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boPKLOSTEXP := True;
      Envir.m_nPKLOSTEXP := Str_ToInt(sParam1, -1);
    end else begin
      Envir.m_boPKLOSTEXP := False;
    end;
  end else
    if CompareText(sMapMode, 'DECHP') = 0 then begin
    if (sParam1 <> '') and (sParam2 <> '') then begin
      Envir.m_boDECHP := True;
      Envir.m_nDECHPTIME := Str_ToInt(sParam1, -1);
      Envir.m_nDECHPPOINT := Str_ToInt(sParam2, -1);
    end else begin
      Envir.m_boDECHP := False;
    end;
  end else
    if CompareText(sMapMode, 'DECGAMEGOLD') = 0 then begin
    if (sParam1 <> '') and (sParam2 <> '') then begin
      Envir.m_boDecGameGold := True;
      Envir.m_nDECGAMEGOLDTIME := Str_ToInt(sParam1, -1);
      Envir.m_nDecGameGold := Str_ToInt(sParam2, -1);
    end else begin
      Envir.m_boDecGameGold := False;
    end;
  end else
    if CompareText(sMapMode, 'RUNHUMAN') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boRUNHUMAN := True;
    end else begin
      Envir.m_boRUNHUMAN := False;
    end;
  end else
    if CompareText(sMapMode, 'RUNMON') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boRUNMON := True;
    end else begin
      Envir.m_boRUNMON := False;
    end;
  end else
    if CompareText(sMapMode, 'NEEDHOLE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNEEDHOLE := True;
    end else begin
      Envir.m_boNEEDHOLE := False;
    end;
  end else
    if CompareText(sMapMode, 'NORECALL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNORECALL := True;
    end else begin
      Envir.m_boNORECALL := False;
    end;
  end else
    if CompareText(sMapMode, 'NOGUILDRECALL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNOGUILDRECALL := True;
    end else begin
      Envir.m_boNOGUILDRECALL := False;
    end;
  end else
    if CompareText(sMapMode, 'NODEARRECALL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNODEARRECALL := True;
    end else begin
      Envir.m_boNODEARRECALL := False;
    end;
  end else
    if CompareText(sMapMode, 'NOMASTERRECALL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNOMASTERRECALL := True;
    end else begin
      Envir.m_boNOMASTERRECALL := False;
    end;
  end else
    if CompareText(sMapMode, 'NORANDOMMOVE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNORANDOMMOVE := True;
    end else begin
      Envir.m_boNORANDOMMOVE := False;
    end;
  end else
    if CompareText(sMapMode, 'NODRUG') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNODRUG := True;
    end else begin
      Envir.m_boNODRUG := False;
    end;
  end else
    if CompareText(sMapMode, 'MINE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boMINE := True;
    end else begin
      Envir.m_boMINE := False;
    end;
  end else
    if CompareText(sMapMode, 'NOPOSITIONMOVE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNOPOSITIONMOVE := True;
    end else begin
      Envir.m_boNOPOSITIONMOVE := False;
    end;
  end;
end;

procedure TNormNpc.ActionOfSetMemberLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nLevel: Integer;
  cMethod: Char;
begin
  nLevel := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nLevel < 0 then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam2, nLevel);
    if nLevel < 0 then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETMEMBERLEVEL);
      Exit;
    end;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        PlayObject.m_nMemberLevel := nLevel;
      end;
    '-': begin
        Dec(PlayObject.m_nMemberLevel, nLevel);
        if PlayObject.m_nMemberLevel < 0 then PlayObject.m_nMemberLevel := 0;
      end;
    '+': begin
        Inc(PlayObject.m_nMemberLevel, nLevel);
        if PlayObject.m_nMemberLevel > 65535 then PlayObject.m_nMemberLevel := 65535;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sChangeMemberLevelMsg, [PlayObject.m_nMemberLevel]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfSetMemberType(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nType: Integer;
  cMethod: Char;
begin
  nType := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nType < 0 then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam2, nType);
    if nType < 0 then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETMEMBERTYPE);
      Exit;
    end;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        PlayObject.m_nMemberType := nType;
      end;
    '-': begin
        Dec(PlayObject.m_nMemberType, nType);
        if PlayObject.m_nMemberType < 0 then PlayObject.m_nMemberType := 0;
      end;
    '+': begin
        Inc(PlayObject.m_nMemberType, nType);
        if PlayObject.m_nMemberType > 65535 then PlayObject.m_nMemberType := 65535;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sChangeMemberTypeMsg, [PlayObject.m_nMemberType]), c_Green, t_Hint);
  end;
end;

function TNormNpc.ConditionOfActMission(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin

end;

function TNormNpc.ConditionOfCheckGuildList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
end;

function TNormNpc.ConditionOfCheckMonMapCount(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  sMapName: string;
  nCount: Integer;
  nMapRangeCount: Integer;
  Envir: TEnvirnoment;
  MonList: TList;
  AObject: TActorObject;
begin
  Result := False;
  sMapName := QuestConditionInfo.sParam1;
  nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    if nCount < 0 then
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nCount);
  end;

  Envir := g_MapManager.FindMap(sMapName);
  if (Envir = nil) then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam1, sMapName);
      Envir := g_MapManager.FindMap(sMapName);
    end;
  end;

  if (Envir = nil) or (nCount < 0) then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sCHECKMONMAP);
    Exit;
  end;

  MonList := TList.Create;
  nMapRangeCount := UserEngine.GetMapMonster(Envir, MonList);
  for I := MonList.Count - 1 downto 0 do begin
    if MonList.Count <= 0 then Break;
    AObject := TActorObject(MonList.Items[I]);
    if (AObject.m_btRaceServer < RC_ANIMAL) or (AObject.m_btRaceServer = RC_ARCHERGUARD) or (AObject.m_Master <> nil) or (AObject.m_btRaceServer = RC_NPC) or (AObject.m_btRaceServer = RC_PEACENPC) then
      MonList.Delete(I);
  end;
  nMapRangeCount := MonList.Count;
  if nMapRangeCount >= nCount then Result := True;
  MonList.Free;
end;

function TNormNpc.ConditionOfCheckRangeMonCount(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I, II: Integer;
  sMapName: string;
  nX, nY, nRange, nCount: Integer;
  cMethod: Char;
  nMapRangeCount: Integer;
  Envir: TEnvirnoment;
  MonGen: pTMonGenInfo;
  AObject: TActorObject;
  MonList: TList;
begin
  Result := False;
  sMapName := QuestConditionInfo.sParam1;
  nX := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nY := Str_ToInt(QuestConditionInfo.sParam3, -1);
  nRange := Str_ToInt(QuestConditionInfo.sParam4, -1);
  cMethod := QuestConditionInfo.sParam5[1];
  nCount := Str_ToInt(QuestConditionInfo.sParam6, -1);
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    if nX < 0 then GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nX);
    if nY < 0 then GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam3, nY);
    if nRange < 0 then GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam4, nRange);
    if nCount < 0 then GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam6, nCount);
  end;
  Envir := g_MapManager.FindMap(sMapName);
  if (Envir = nil) or (nX < 0) or (nY < 0) or (nRange < 0) or (nCount < 0) then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKRANGEMONCOUNT);
    Exit;
  end;

  MonList := TList.Create;
  nMapRangeCount := Envir.GetRangeActorObject(nX, nY, nRange, True, MonList);
  for I := MonList.Count - 1 downto 0 do begin
    if MonList.Count <= 0 then Break;
    AObject := TActorObject(MonList.Items[I]);
    if (AObject.m_btRaceServer < RC_ANIMAL) or (AObject.m_btRaceServer = RC_ARCHERGUARD) or (AObject.m_Master <> nil) or (AObject.m_btRaceServer = RC_NPC) or (AObject.m_btRaceServer = RC_PEACENPC) then
      MonList.Delete(I);
  end;
  nMapRangeCount := MonList.Count;
  MonList.Free;

  case cMethod of
    '=': if nMapRangeCount = nCount then Result := True;
    '>': if nMapRangeCount > nCount then Result := True;
    '<': if nMapRangeCount < nCount then Result := True;
  else if nMapRangeCount >= nCount then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckRangeGroupCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  nRange, nCount: Integer;
  cMethod: Char;
  nMapRangeCount: Integer;
  GroupHuman: TPlayObject;
begin
  Result := False;
  if (PlayObject.m_GroupOwner <> nil) and (PlayObject.m_GroupOwner.m_GroupMembers <> nil) then begin
    nRange := Str_ToInt(QuestConditionInfo.sParam1, -1);
    if QuestConditionInfo.sParam2 <> '' then
      cMethod := QuestConditionInfo.sParam2[1];
    nCount := Str_ToInt(QuestConditionInfo.sParam3, -1);

    if nRange < 0 then GetVarValue(PlayObject, QuestConditionInfo.sParam1, nRange);
    if nCount < 0 then GetVarValue(PlayObject, QuestConditionInfo.sParam3, nCount);

    if (nRange < 0) or (nCount < 0) or (cMethod = '') then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKRANGEROUPCOUNT);
      Exit;
    end;

    nMapRangeCount := 0;
    for I := 0 to PlayObject.m_GroupOwner.m_GroupMembers.Count - 1 do begin
      GroupHuman := TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[I]);
      if GroupHuman.m_PEnvir = PlayObject.m_PEnvir then begin
        if (abs(PlayObject.m_nCurrX - GroupHuman.m_nCurrX) <= nRange) and (abs(PlayObject.m_nCurrY - GroupHuman.m_nCurrY) <= nRange) then begin
          Inc(nMapRangeCount);
        end;
      end;
    end;

    case cMethod of
      '=': if nMapRangeCount = nCount then Result := True;
      '>': if nMapRangeCount > nCount then Result := True;
      '<': if nMapRangeCount < nCount then Result := True;
    else if nMapRangeCount >= nCount then Result := True;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckOnLinePlayCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nCount: Integer;
begin
  Result := False;
  if (QuestConditionInfo.sParam1 = '') or (QuestConditionInfo.sParam2 = '') then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKONLINEPLAYCOUNT);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then GetVarValue(PlayObject, QuestConditionInfo.sParam2, nCount);
  if nCount < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKONLINEPLAYCOUNT);
    Exit;
  end;
  case cMethod of
    '=': if UserEngine.PlayObjectCount = nCount then Result := True;
    '>': if UserEngine.PlayObjectCount > nCount then Result := True;
    '<': if UserEngine.PlayObjectCount < nCount then Result := True;
  else if UserEngine.PlayObjectCount >= nCount then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckItemBindUse(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nWhere: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  Result := False;
  nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);
  if nWhere < 0 then GetVarValue(PlayObject, QuestConditionInfo.sParam1, nWhere); //增加变量支持
  if nWhere < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKUSEITEMBIND);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (UserItem.wIndex <= 0) or (StdItem = nil) then begin
    PlayObject.SysMsg('You are not wearing any eligible Item.', c_Red, t_Hint);
    Exit;
  end;
  Result := PlayObject.CheckItemBindUse(UserItem, True) = 2;
end;

function TNormNpc.ConditionOfItemNewAddValue(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  UserItem: pTUserItem;
  nItemType: Integer;
begin
  Result := False;
  UserItem := nil;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;
  if UserItem <> nil then begin
    if QuestConditionInfo.sParam1 = '' then begin
      Result := UserItem.AddPoint[1] > 0;
    end else begin
      nItemType := Str_ToInt(QuestConditionInfo.sParam1, -1);
      if nItemType in [1..5] then begin
        Result := UserItem.AddPoint[1] = nItemType;
      end else begin
        ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMNEWADDVALUE);
      end;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckItemNewAddValueCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nItemType: Integer;
  nCount: Integer;
  nPoint: Integer;
  UserItem: pTUserItem;
begin
  Result := False;
  UserItem := nil;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;
  if UserItem <> nil then begin
    nItemType := Str_ToInt(QuestConditionInfo.sParam1, -1);
    nCount := Str_ToInt(QuestConditionInfo.sParam3, -1);
    cMethod := QuestConditionInfo.sParam2[1];
    if (nItemType in [1..16]) and (nCount >= 0) then begin
      if (nItemType in [1..5]) then begin
        if UserItem.AddPoint[1] = nItemType then begin
          nPoint := UserItem.AddPoint[2];
        end else begin
          nPoint := -1;
        end;
        case cMethod of
          '=': if nPoint = nCount then Result := True;
          '>': if nPoint > nCount then Result := True;
          '<': if nPoint < nCount then Result := True;
        else if nPoint >= nCount then Result := True;
        end;
      end else begin
        nPoint := UserItem.AddPoint[nItemType - 3];
        case cMethod of
          '=': if nPoint = nCount then Result := True;
          '>': if nPoint > nCount then Result := True;
          '<': if nPoint < nCount then Result := True;
        else if nPoint >= nCount then Result := True;
        end;
      end;
    end else begin

      PlayObject.SendChangeItemFail;
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMNEWADDVALUECOUNT);
    end;
  end;
end;

function TNormNpc.ConditionOfCheckHeroGroup(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nLevel: Integer;
begin
  Result := False;
  if (PlayObject.m_MyHero <> nil) then begin
    cMethod := QuestConditionInfo.sParam1[1];
    nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
    case cMethod of
      '=': if THeroObject(PlayObject.m_MyHero).m_btHeroGroup = nLevel then Result := True;
      '>': if THeroObject(PlayObject.m_MyHero).m_btHeroGroup > nLevel then Result := True;
      '<': if THeroObject(PlayObject.m_MyHero).m_btHeroGroup < nLevel then Result := True;
    else if THeroObject(PlayObject.m_MyHero).m_btHeroGroup >= nLevel then Result := True;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckPutItemType(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nType: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  Result := False;

  UserItem := nil;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;

  nType := Str_ToInt(QuestConditionInfo.sParam1, -1);
  if nType < 0 then
    GetVarValue(PlayObject, QuestConditionInfo.sParam1, nType);

  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (StdItem <> nil) and (StdItem.StdMode = nType) then begin
    Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckItemBind(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  UserItem: pTUserItem;
begin
  Result := False;
  UserItem := nil;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;
  if UserItem <> nil then begin
    Result := PlayObject.CheckItemBindUse(UserItem, True) = 2;
  end;
end;

function TNormNpc.ConditionOfCheckItemLimit(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  UserItem: pTUserItem;
begin
  Result := False;
  UserItem := nil;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;
  if UserItem <> nil then begin
    Result := UserItem.AddValue[0] = 0;
  end;
end;

function TNormNpc.ConditionOfCheckItemLimitCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  UserItem: pTUserItem;
  cMethod: Char;
  nItemDateCount, nCount: Integer;
begin
  Result := False;
  cMethod := QuestConditionInfo.sParam1[1];
  nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then GetVarValue(PlayObject, QuestConditionInfo.sParam2, nCount);
  if nCount < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMLIMITCOUNT);
    Exit;
  end;
  UserItem := nil;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;
  if (UserItem <> nil) and (UserItem.AddValue[0] = 1) then begin
    nItemDateCount := GetDayCount(UserItem.MaxDate, Now);
    case cMethod of
      '=': if nItemDateCount = nCount then Result := True;
      '>': if nItemDateCount > nCount then Result := True;
      '<': if nItemDateCount < nCount then Result := True;
    else if nItemDateCount >= nCount then Result := True;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckMemoryItem(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
  function IsRememberItem(UserItem: pTUserItem): Boolean;
  var
    StdItem: pTStdItem;
  begin
    Result := False;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem = nil then Exit;
    Result := (StdItem.StdMode = 31) and (StdItem.AniCount <> 0) and (StdItem.Shape = 1);
  end;
var
  UserItem: pTUserItem;
begin
  Result := False;
  UserItem := nil;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;
  if UserItem <> nil then begin
    Result := IsRememberItem(UserItem);
  end;
end;

function TNormNpc.ConditionOfUpgradeItems(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  UserItem: pTUserItem;
begin
  Result := False;
  UserItem := nil;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;
  if UserItem <> nil then begin
    Result := UserEngine._AllowUpgradeItem(UserItem);
  end;
end;

function TNormNpc.ConditionOfPutItem(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  UserItem: pTUserItem;
begin
  Result := False;
  UserItem := nil;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;
  Result := UserItem <> nil;
end;

function TNormNpc.ConditionOfCheckUseItemStarsLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;

  nWhere, nCount: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  Result := False;
  nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);
  if nWhere < 0 then
    GetVarValue(PlayObject, QuestConditionInfo.sParam1, nWhere); //增加变量支持
  if not (nWhere in [0..12]) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKUSEITEMSTARSLEVEL);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (UserItem.wIndex <= 0) or (StdItem = nil) then begin
    PlayObject.SysMsg('You are not wearing any eligible Items.', c_Red, t_Hint);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam2[1];
  nCount := Str_ToInt(QuestConditionInfo.sParam3, -1);
  if nCount < 0 then
    GetVarValue(PlayObject, QuestConditionInfo.sParam3, nCount);
  if nCount < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKUSEITEMSTARSLEVEL);
    Exit;
  end;
  case cMethod of
    '=': if UserItem.AddValue[13] = nCount then Result := True;
    '>': if UserItem.AddValue[13] > nCount then Result := True;
    '<': if UserItem.AddValue[13] < nCount then Result := True;
  else if UserItem.AddValue[13] >= nCount then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckBagItemStarsLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  UserItem: pTUserItem;
  cMethod: Char;
  nItemDateCount, nCount: Integer;
begin
  Result := False;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin
    PlayObject.SendChangeItemFail;
    Exit;
  end;

  UserItem := nil;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin
      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;
  if (UserItem <> nil) then begin
    cMethod := QuestConditionInfo.sParam1[1];
    nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nCount < 0 then
      GetVarValue(PlayObject, QuestConditionInfo.sParam2, nCount);
    if nCount < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKBAGITEMSTARSLEVEL);
      Exit;
    end;
    case cMethod of
      '=': if UserItem.AddValue[13] = nCount then Result := True;
      '>': if UserItem.AddValue[13] > nCount then Result := True;
      '<': if UserItem.AddValue[13] < nCount then Result := True;
    else if UserItem.AddValue[13] >= nCount then Result := True;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckReNewLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  cMethod: Char;
begin
  Result := False;
  nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nLevel < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nLevel);
    if nLevel < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKLEVELEX);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_btReLevel = nLevel then Result := True;
    '>': if PlayObject.m_btReLevel > nLevel then Result := True;
    '<': if PlayObject.m_btReLevel < nLevel then Result := True;
  else if PlayObject.m_btReLevel >= nLevel then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckSlaveLevel(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  nLevel: Integer;
  cMethod: Char;
  AObject: TActorObject;
  nSlaveLevel: Integer;
begin
  Result := False;
  nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if not (nLevel in [0..7]) then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam2, nLevel);
      if not (nLevel in [0..7]) then begin
        ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKSLAVELEVEL);
        Exit;
      end;
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam2, nLevel);
      if not (nLevel in [0..7]) then begin
        ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKSLAVELEVEL);
        Exit;
      end;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  for I := 0 to BaseObject.m_SlaveList.Count - 1 do begin
    AObject := TActorObject(BaseObject.m_SlaveList.Items[I]);
    case cMethod of
      '=':
        if AObject.m_btSlaveExpLevel = nLevel then begin
          Result := True;
          break;
        end;
      '>':
        if AObject.m_btSlaveExpLevel > nLevel then begin
          Result := True;
          break;
        end;
      '<':
        if AObject.m_btSlaveExpLevel < nLevel then begin
          Result := True;
          break;
        end;
    else begin
        if AObject.m_btSlaveExpLevel >= nLevel then begin
          Result := True;
          break;
        end;
      end;
    end;
  end;
end;


function TNormNpc.ConditionOfCheckUseItem(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nWhere: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  Result := False;
  nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    if nWhere < 0 then GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam1, nWhere);
  end else
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
    if nWhere < 0 then GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam1, nWhere);
  end;
  if (nWhere < 0) or (nWhere > High(THumanUseItems)) then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKUSEITEM);
    Exit;
  end;
  if BaseObject.m_UseItems[nWhere].wIndex > 0 then
    Result := True;
end;

function TNormNpc.ConditionOfCheckSlaveRange(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  sCharName: string;
  nRange: Integer;
  nSlavenRange: Integer;
  cMethod: Char;
  AObject: TActorObject;
  boFind: Boolean;
begin
  Result := False;
  sCharName := QuestConditionInfo.sParam1;

  nRange := Str_ToInt(QuestConditionInfo.sParam3, -1);
  if nRange < 0 then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam3, nRange);
      if nRange < 0 then begin
        ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKSLAVERANGE);
        Exit;
      end;
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam3, nRange);
      if nRange < 0 then begin
        ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKSLAVERANGE);
        Exit;
      end;
    end;
  end;

  boFind := False;
  for I := 0 to BaseObject.m_SlaveList.Count - 1 do begin
    AObject := TActorObject(BaseObject.m_SlaveList.Items[I]);
    if CompareText(sCharName, AObject.m_sCharName) = 0 then begin
      boFind := True;
      break;
    end;
  end;

  if not boFind then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam1, sCharName);
    end else
      if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
      GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam1, sCharName);
    end;
  end;

  cMethod := QuestConditionInfo.sParam2[1];

  for I := 0 to BaseObject.m_SlaveList.Count - 1 do begin
    AObject := TActorObject(BaseObject.m_SlaveList.Items[I]);
    if CompareText(sCharName, AObject.m_sCharName) = 0 then begin
      nSlavenRange := abs(AObject.m_nCurrX - BaseObject.m_nCurrX) + abs(AObject.m_nCurrY - BaseObject.m_nCurrY);
      case cMethod of
        '=': if nSlavenRange = nRange then Result := True;
        '>': if nSlavenRange > nRange then Result := True;
        '<': if nSlavenRange < nRange then Result := True;
      else if nSlavenRange >= nRange then Result := True;
      end;
      break;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckVar(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  sType: string;
  VarType: TVarType;
  sVarName: string;
  sVarValue: string;
  nVarValue: Integer;
  sName: string;
  sMethod: string;
  cMethod: Char;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
resourcestring
  sVarFound = '变量%s已存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  Result := False;
  sType := QuestConditionInfo.sParam1;
  sVarName := QuestConditionInfo.sParam2;
  sMethod := QuestConditionInfo.sParam3;
  nVarValue := Str_ToInt(QuestConditionInfo.sParam4, 0);
  sVarValue := QuestConditionInfo.sParam4;

  if (sType = '') or (sVarName = '') or (sMethod = '') then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKVAR);
    Exit;
  end;
  cMethod := sMethod[1];
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then begin
    ScriptConditionError(PlayObject {,format(sVarTypeError,[sType])}, QuestConditionInfo, sSC_CHECKVAR);
    Exit;
  end else begin
    for I := 0 to DynamicVarList.Count - 1 do begin
      DynamicVar := DynamicVarList.Items[I];
      if CompareText(DynamicVar.sName, sVarName) = 0 then begin
        case DynamicVar.VarType of
          vInteger: begin
              case cMethod of
                '=': if DynamicVar.nInternet = nVarValue then Result := True;
                '>': if DynamicVar.nInternet > nVarValue then Result := True;
                '<': if DynamicVar.nInternet < nVarValue then Result := True;
              else if DynamicVar.nInternet >= nVarValue then Result := True;
              end;
            end;
          vString: begin
              case cMethod of
                '=': if DynamicVar.sString = sVarValue then Result := True;
              end;
            end;
        end;
        boFoundVar := True;
        Break;
      end;
    end;
    if not boFoundVar then
      ScriptConditionError(PlayObject, {format(sVarFound,[sVarName,sType]),} QuestConditionInfo, sSC_CHECKVAR);
  end;
end;

function TNormNpc.ConditionOfHaveMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if PlayObject.m_sMasterName <> '' then
    Result := True;
end;

function TNormNpc.ConditionOfPoseHaveMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TActorObject;
begin
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    if (TPlayObject(PoseHuman).m_sMasterName <> '') then
      Result := True;
  end;
end;

procedure TNormNpc.ActionOfUnMaster(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  LoadList: TStringList;
  sUnMarryFileName: string;
  sMsg: string;
  I: Integer;
begin
  if PlayObject.m_sMasterName = '' then begin
    GotoLable(PlayObject, '@ExeMasterFail', False);
    Exit;
  end;
  PoseHuman := TPlayObject(PlayObject.GetPoseCreate);
  if PoseHuman = nil then begin
    GotoLable(PlayObject, '@UnMasterCheckDir', False);
  end;
  if PoseHuman <> nil then begin
    if QuestActionInfo.sParam1 = '' then begin
      if PoseHuman.m_btRaceServer <> RC_PLAYOBJECT then begin
        GotoLable(PlayObject, '@UnMasterTypeErr', False);
        Exit;
      end;
      if PoseHuman.GetPoseCreate = PlayObject then begin
        if (PlayObject.m_sMasterName = PoseHuman.m_sCharName) then begin
          if PlayObject.m_boMaster then begin
            GotoLable(PlayObject, '@UnIsMaster', False);
            Exit;
          end;
          if PlayObject.m_sMasterName <> PoseHuman.m_sCharName then begin
            GotoLable(PlayObject, '@UnMasterError', False);
            Exit;
          end;

          GotoLable(PlayObject, '@StartUnMaster', False);
          GotoLable(PoseHuman, '@WateUnMaster', False);
          Exit;
        end;
      end;
    end;
  end;
  if (CompareText(QuestActionInfo.sParam1, 'REQUESTUNMASTER' {sREQUESTUNMARRY}) = 0) then begin
    if (QuestActionInfo.sParam2 = '') then begin
      if PoseHuman <> nil then begin
        PlayObject.m_boStartUnMaster := True;
        if PlayObject.m_boStartUnMaster and PoseHuman.m_boStartUnMaster then begin

          for I := PoseHuman.m_MasterList.Count - 1 downto 0 do begin //2008-11-28增加出师后删除徒弟记录
            if PoseHuman.m_MasterList.Items[I] = PlayObject then begin
              PoseHuman.m_MasterList.Delete(I);
              break;
            end;
          end;

          sMsg := AnsiReplaceText(g_sNPCSayUnMasterOKMsg, '%n', m_sCharName);
          sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.m_sCharName);
          sMsg := AnsiReplaceText(sMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sMsg, t_Say);
          PlayObject.m_sMasterName := '';
          PoseHuman.m_sMasterName := '';
          PlayObject.m_boStartUnMaster := False;
          PoseHuman.m_boStartUnMaster := False;
          PlayObject.RefShowName;
          PoseHuman.RefShowName;
          GotoLable(PlayObject, '@UnMasterEnd', False);
          GotoLable(PoseHuman, '@UnMasterEnd', False);
        end else begin
          GotoLable(PlayObject, '@WateUnMaster', False);
          GotoLable(PoseHuman, '@RevUnMaster', False);
        end;
      end;
      Exit;
    end else begin
      //强行出师
      if (CompareText(QuestActionInfo.sParam2, 'FORCE') = 0) then begin
        sMsg := AnsiReplaceText(g_sNPCSayForceUnMasterMsg, '%n', m_sCharName);
        sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.m_sCharName);
        sMsg := AnsiReplaceText(sMsg, '%d', PlayObject.m_sMasterName);
        UserEngine.SendBroadCastMsg(sMsg, t_Say);

        PoseHuman := UserEngine.GetPlayObject(PlayObject.m_sMasterName);
        if PoseHuman <> nil then begin
          PoseHuman.m_sMasterName := '';
          PoseHuman.RefShowName;
        end else begin
          g_UnForceMasterList.Lock;
          try
            g_UnForceMasterList.Add(PlayObject.m_sMasterName);
            SaveUnForceMasterList();
          finally
            g_UnForceMasterList.UnLock;
          end;
        end;
        PlayObject.m_sMasterName := '';
        GotoLable(PlayObject, '@UnMasterEnd', False);
        PlayObject.RefShowName;
      end;
      Exit;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckCastleGold(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nGold: Integer;
begin
  Result := False;
  nGold := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nGold < 0 then GetVarValue(PlayObject, QuestConditionInfo.sParam2, nGold);
  if (nGold < 0) or (m_Castle = nil) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCASTLEGOLD);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if TUserCastle(m_Castle).m_nTotalGold = nGold then Result := True;
    '>': if TUserCastle(m_Castle).m_nTotalGold > nGold then Result := True;
    '<': if TUserCastle(m_Castle).m_nTotalGold < nGold then Result := True;
  else if TUserCastle(m_Castle).m_nTotalGold >= nGold then Result := True;
  end;
  {
  Result:=False;
  nGold:=Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nGold < 0 then begin
    ScriptConditionError(PlayObject,QuestConditionInfo,sSC_CHECKCASTLEGOLD);
    exit;
  end;
  cMethod:=QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if UserCastle.m_nTotalGold = nGold then Result:=True;
    '>': if UserCastle.m_nTotalGold > nGold then Result:=True;
    '<': if UserCastle.m_nTotalGold < nGold then Result:=True;
    else if UserCastle.m_nTotalGold >= nGold then Result:=True;
  end;
  }
end;


function TNormNpc.ConditionOfCheckContribution(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nContribution: Integer;
  cMethod: Char;
begin
  Result := False;
  nContribution := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nContribution < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nContribution);
    if nContribution < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCONTRIBUTION);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_wContribution = nContribution then Result := True;
    '>': if PlayObject.m_wContribution > nContribution then Result := True;
    '<': if PlayObject.m_wContribution < nContribution then Result := True;
  else if PlayObject.m_wContribution >= nContribution then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckCreditPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCreditPoint: Integer;
  cMethod: Char;
begin
  Result := False;
  nCreditPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nCreditPoint < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nCreditPoint);
    if nCreditPoint < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCREDITPOINT);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_btCreditPoint = nCreditPoint then Result := True;
    '>': if PlayObject.m_btCreditPoint > nCreditPoint then Result := True;
    '<': if PlayObject.m_btCreditPoint < nCreditPoint then Result := True;
  else if PlayObject.m_btCreditPoint >= nCreditPoint then Result := True;
  end;
end;

procedure TNormNpc.ActionOfClearNeedItems(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  nNeed: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  nNeed := Str_ToInt(QuestActionInfo.sParam1, -1);
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    GetVarValue(TPlayObject(BaseObject), QuestActionInfo.sParam1, nNeed); //增加变量支持
  end else
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
    GetVarValue(TPlayObject(BaseObject.m_Master), QuestActionInfo.sParam1, nNeed); //增加变量支持
  end;
  if (nNeed < 0) then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_CLEARNEEDITEMS);
    Exit;
  end;
  for I := BaseObject.m_ItemList.Count - 1 downto 0 do begin
    if BaseObject.m_ItemList.Count <= 0 then Break;
    UserItem := BaseObject.m_ItemList.Items[I];
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) and (StdItem.Need = nNeed) then begin
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
        TPlayObject(BaseObject).SendDelItems(UserItem);
      end else begin
        if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
          THeroObject(BaseObject).SendDelItems(UserItem);
        end;
      end;
      BaseObject.m_ItemList.Delete(I);
      Dispose(UserItem);
    end;
  end;
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    for I := TPlayObject(BaseObject).m_StorageItemList.Count - 1 downto 0 do begin
      if TPlayObject(BaseObject).m_StorageItemList.Count <= 0 then Break;
      UserItem := TPlayObject(BaseObject).m_StorageItemList.Items[I];
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if (StdItem <> nil) and (StdItem.Need = nNeed) then begin
        TPlayObject(BaseObject).m_StorageItemList.Delete(I);
        Dispose(UserItem);
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfClearMakeItems(BaseObject: TActorObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  nMakeIndex: Integer;
  sItemName: string;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  boMatchName: Boolean;
begin
  sItemName := QuestActionInfo.sParam1;
  nMakeIndex := QuestActionInfo.nParam2;
  boMatchName := QuestActionInfo.sParam3 = '1';
  if (sItemName = '') or (nMakeIndex <= 0) then begin
    ScriptActionError(BaseObject, '', QuestActionInfo, sSC_CLEARMAKEITEMS);
    Exit;
  end;
  for I := BaseObject.m_ItemList.Count - 1 downto 0 do begin
    if BaseObject.m_ItemList.Count <= 0 then Break;
    UserItem := BaseObject.m_ItemList.Items[I];
    if UserItem.MakeIndex <> nMakeIndex then Continue;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if not boMatchName or ((StdItem <> nil) and (CompareText(StdItem.Name, sItemName) = 0)) then begin
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
        TPlayObject(BaseObject).SendDelItems(UserItem);
      end else begin
        if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
          THeroObject(BaseObject).SendDelItems(UserItem);
        end;
      end;
      BaseObject.m_ItemList.Delete(I);
      Dispose(UserItem);
    end;
  end;
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    for I := TPlayObject(BaseObject).m_StorageItemList.Count - 1 downto 0 do begin
      if TPlayObject(BaseObject).m_StorageItemList.Count <= 0 then Break;
      UserItem := TPlayObject(BaseObject).m_ItemList.Items[I];
      if UserItem.MakeIndex <> nMakeIndex then Continue;
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if not boMatchName or ((StdItem <> nil) and (CompareText(StdItem.Name, sItemName) = 0)) then begin
        TPlayObject(BaseObject).m_StorageItemList.Delete(I);
        Dispose(UserItem);
      end;
    end;
  end;
  for I := Low(BaseObject.m_UseItems) to High(BaseObject.m_UseItems) do begin
    UserItem := @BaseObject.m_UseItems[I];
    if UserItem.MakeIndex <> nMakeIndex then Continue;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if not boMatchName or ((StdItem <> nil) and (CompareText(StdItem.Name, sItemName) = 0)) then begin
      UserItem.wIndex := 0;
    end;
  end;
end;

procedure TNormNpc.SendCustemMsg(PlayObject: TPlayObject; sMsg: string);
begin
  if not g_Config.boSendCustemMsg then begin
    PlayObject.SysMsg(g_sSendCustMsgCanNotUseNowMsg, c_Red, t_Hint);
    Exit;
  end;
  if PlayObject.m_boSendMsgFlag then begin
    PlayObject.m_boSendMsgFlag := False;
    UserEngine.SendBroadCastMsg(PlayObject.GetUnknowCharName + ': ' + sMsg, t_Cust); //神秘人
  end else begin

  end;
end;

function TNormNpc.ConditionOfCheckOfGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sGuildName: string;
begin
  Result := False;
  if QuestConditionInfo.sParam1 = '' then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKOFGUILD);
    Exit;
  end;
  if (PlayObject.m_MyGuild <> nil) then begin
    sGuildName := QuestConditionInfo.sParam1;
    GetVarValue(PlayObject, QuestConditionInfo.sParam1, sGuildName);

    if CompareText(TGUild(PlayObject.m_MyGuild).sGuildName, sGuildName) = 0 then begin
      Result := True;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckOnlineLongMin(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nOnlineMin: Integer;
  nOnlineTime: Integer;
begin
  Result := False;
  nOnlineMin := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nOnlineMin < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nOnlineMin);
    if nOnlineMin < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ONLINELONGMIN);
      Exit;
    end;
  end;
  nOnlineTime := (GetTickCount - PlayObject.m_dwLogonTick) div 60000;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if nOnlineTime = nOnlineMin then Result := True;
    '>': if nOnlineTime > nOnlineMin then Result := True;
    '<': if nOnlineTime < nOnlineMin then Result := True;
  else if nOnlineTime >= nOnlineMin then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckPasswordErrorCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nErrorCount: Integer;
  cMethod: Char;
begin
  Result := False;
  nErrorCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nErrorCount < 0 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam2, nErrorCount);
    if nErrorCount < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_PASSWORDERRORCOUNT);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_btPwdFailCount = nErrorCount then Result := True;
    '>': if PlayObject.m_btPwdFailCount > nErrorCount then Result := True;
    '<': if PlayObject.m_btPwdFailCount < nErrorCount then Result := True;
  else if PlayObject.m_btPwdFailCount >= nErrorCount then Result := True;
  end;
end;

function TNormNpc.ConditionOfIsLockPassword(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := PlayObject.m_boPasswordLocked;
end;

function TNormNpc.ConditionOfIsLockStorage(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := not PlayObject.m_boCanGetBackItem;
end;

function TNormNpc.ConditionOfCheckPayMent(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nPayMent: Integer;
begin
  Result := False;
  nPayMent := Str_ToInt(QuestConditionInfo.sParam1, -1);
  if nPayMent < 1 then begin
    GetVarValue(PlayObject, QuestConditionInfo.sParam1, nPayMent);
    if nPayMent < 1 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKPAYMENT);
      Exit;
    end;
  end;
  if PlayObject.m_nPayMent = nPayMent then Result := True;
end;

function TNormNpc.ConditionOfCheckSlaveName(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  sSlaveName: string;
  AObject: TActorObject;
begin
  Result := False;
  if QuestConditionInfo.sParam1 = '' then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKSLAVENAME);
    Exit;
  end;
  sSlaveName := QuestConditionInfo.sParam1;
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam1, sSlaveName);
  end else
    if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin
    GetVarValue(TPlayObject(BaseObject.m_Master), QuestConditionInfo.sParam1, sSlaveName);
  end;
  for I := 0 to BaseObject.m_SlaveList.Count - 1 do begin
    AObject := TActorObject(BaseObject.m_SlaveList.Items[I]);
    if CompareText(sSlaveName, AObject.m_sCharName) = 0 then begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TNormNpc.ActionOfUpgradeItems(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate, nWhere, nValType, nPoint, nAddPoint: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  sCheckItemName: string;
begin
  nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
  nRate := Str_ToInt(QuestActionInfo.sParam2, -1);
  nPoint := Str_ToInt(QuestActionInfo.sParam3, -1);
  if nWhere < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam1, nWhere); //增加变量支持
  if nRate < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam2, nRate); //增加变量支持
  if nPoint < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam3, nPoint); //增加变量支持
  if (nWhere < 0) or (nWhere > High(THumanUseItems)) or (nRate < 0) or (nPoint < 0) or (nPoint > 255) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_UPGRADEITEMS);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (UserItem.wIndex <= 0) or (StdItem = nil) then begin
    PlayObject.SysMsg('You are not wearing any eligible Items.', c_Red, t_Hint);
    Exit;
  end;

  if Assigned(PlugInEngine.CheckCanUpgradeItem) then begin //禁止升级
    sCheckItemName := StdItem.Name;
    if PlugInEngine.CheckCanUpgradeItem(PlayObject, PChar(sCheckItemName), True) then begin
      Exit;
    end;
  end;

  nRate := Random(nRate);
  nPoint := Random(nPoint);
  nValType := Random(14);
  if nRate <> 0 then begin
    PlayObject.SysMsg('Item upgrade failed.', c_Red, t_Hint);
    Exit;
  end;
  if nValType = 14 then begin
    nAddPoint := (nPoint * 1000);
    if UserItem.DuraMax + nAddPoint > High(Word) then begin
      nAddPoint := High(Word) - UserItem.DuraMax;
    end;
    UserItem.DuraMax := UserItem.DuraMax + nAddPoint;
  end else begin
    nAddPoint := nPoint;
    if UserItem.btValue[nValType] + nAddPoint > High(Byte) then begin
      nAddPoint := High(Byte) - UserItem.btValue[nValType];
    end;
    UserItem.btValue[nValType] := UserItem.btValue[nValType] + nAddPoint;
  end;
  PlayObject.SendUpdateItem(UserItem);
  PlayObject.SysMsg('Item upgraded successfully', c_Green, t_Hint);
  PlayObject.SysMsg(StdItem.Name + ': ' +
    IntToStr(UserItem.Dura) + '/' +
    IntToStr(UserItem.DuraMax) + '/' +
    IntToStr(UserItem.btValue[0]) + '/' +
    IntToStr(UserItem.btValue[1]) + '/' +
    IntToStr(UserItem.btValue[2]) + '/' +

    IntToStr(UserItem.btValue[3]) + '/' +
    IntToStr(UserItem.btValue[4]) + '/' +
    IntToStr(UserItem.btValue[5]) + '/' +
    IntToStr(UserItem.btValue[6]) + '/' +
    IntToStr(UserItem.btValue[7]) + '/' +
    IntToStr(UserItem.btValue[8]) + '/' +
    IntToStr(UserItem.btValue[9]) + '/' +
    IntToStr(UserItem.btValue[10]) + '/' +
    IntToStr(UserItem.btValue[11]) + '/' +
    IntToStr(UserItem.btValue[12]) + '/' +
    IntToStr(UserItem.btValue[13])
    , c_Blue, t_Hint);
end;

procedure TNormNpc.ActionOfUpgradeItemsEx(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate, nWhere, nValType, nValType1, nPoint, nAddPoint: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  nUpgradeItemStatus: Integer;
  nRatePoint: Integer;
  sCheckItemName: string;
begin
  nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
  nValType := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nValType <= 14 then begin
    nRate := Str_ToInt(QuestActionInfo.sParam3, -1);
    nPoint := Str_ToInt(QuestActionInfo.sParam4, -1);
    if nWhere < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam1, nWhere); //增加变量支持
    if nValType < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam2, nValType); //增加变量支持
    if nRate < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam3, nRate); //增加变量支持
    if nPoint < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam4, nPoint); //增加变量支持
    nUpgradeItemStatus := Str_ToInt(QuestActionInfo.sParam5, -1);
    if (nValType < 0) or (nValType > 21) or (nWhere < 0) or (nWhere > High(THumanUseItems)) or (nRate < 0) or (nPoint < 0) or (nPoint > 255) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_UPGRADEITEMSEX);
      Exit;
    end;
    UserItem := @PlayObject.m_UseItems[nWhere];
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (UserItem.wIndex <= 0) or (StdItem = nil) then begin
      PlayObject.SysMsg('You are not wearing any eligible Items.', c_Red, t_Hint);
      Exit;
    end;

    if Assigned(PlugInEngine.CheckCanUpgradeItem) then begin //禁止升级
      sCheckItemName := StdItem.Name;
      if PlugInEngine.CheckCanUpgradeItem(PlayObject, PChar(sCheckItemName), True) then begin
        Exit;
      end;
    end;

    nRatePoint := Random(nRate * 10);
    nPoint := _MAX(1, Random(nPoint));

    if not (nRatePoint in [0..10]) then begin
      case nUpgradeItemStatus of //
        0: begin
            PlayObject.SysMsg('Item upgrade failed', c_Red, t_Hint);
          end;
        1: begin
            PlayObject.SendDelItems(UserItem);
            UserItem.wIndex := 0;
            PlayObject.SysMsg('Item was broken!', c_Red, t_Hint);
          end;
        2: begin
            PlayObject.SysMsg('Item upgrade failed and has been restored to default Stats', c_Red, t_Hint);
            if nValType <> 14 then
              UserItem.btValue[nValType] := 0;
          end;
      end;
      Exit;
    end;
    if nValType = 14 then begin
      nAddPoint := (nPoint * 1000);
      if UserItem.DuraMax + nAddPoint > High(Word) then begin
        nAddPoint := High(Word) - UserItem.DuraMax;
      end;
      UserItem.DuraMax := UserItem.DuraMax + nAddPoint;
    end else begin
      nAddPoint := nPoint;
      if UserItem.btValue[nValType] + nAddPoint > High(Byte) then begin
        nAddPoint := High(Byte) - UserItem.btValue[nValType];
      end;
      UserItem.btValue[nValType] := UserItem.btValue[nValType] + nAddPoint;
    end;
    PlayObject.SendUpdateItem(UserItem);
    PlayObject.SysMsg('Item upgraded', c_Green, t_Hint);
    PlayObject.SysMsg(StdItem.Name + ': ' +
      IntToStr(UserItem.Dura) + '/' +
      IntToStr(UserItem.DuraMax) + '-' +
      IntToStr(UserItem.btValue[0]) + '/' +
      IntToStr(UserItem.btValue[1]) + '/' +
      IntToStr(UserItem.btValue[2]) + '/' +
      IntToStr(UserItem.btValue[3]) + '/' +
      IntToStr(UserItem.btValue[4]) + '/' +
      IntToStr(UserItem.btValue[5]) + '/' +
      IntToStr(UserItem.btValue[6]) + '/' +
      IntToStr(UserItem.btValue[7]) + '/' +
      IntToStr(UserItem.btValue[8]) + '/' +
      IntToStr(UserItem.btValue[9]) + '/' +
      IntToStr(UserItem.btValue[10]) + '/' +
      IntToStr(UserItem.btValue[11]) + '/' +
      IntToStr(UserItem.btValue[12]) + '/' +
      IntToStr(UserItem.btValue[13])
      , c_Blue, t_Hint);
  end else begin

    nValType1 := Str_ToInt(QuestActionInfo.sParam3, -1);
    nRate := Str_ToInt(QuestActionInfo.sParam4, -1);
    nPoint := Str_ToInt(QuestActionInfo.sParam5, -1);
    if nWhere < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam1, nWhere); //增加变量支持
    if nValType < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam2, nValType); //增加变量支持
    if nValType1 < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam3, nValType); //增加变量支持
    if nRate < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam4, nRate); //增加变量支持
    if nPoint < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam5, nPoint); //增加变量支持
    nUpgradeItemStatus := Str_ToInt(QuestActionInfo.sParam6, -1);
    if (nValType < 0) or (nValType > 20) or (not nValType1 in [1..3]) or (nWhere < 0) or (nWhere > High(THumanUseItems)) or (nRate < 0) or (nPoint < 0) or (nPoint > 255) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_UPGRADEITEMSEX);
      Exit;
    end;
    UserItem := @PlayObject.m_UseItems[nWhere];
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (UserItem.wIndex <= 0) or (StdItem = nil) then begin
      PlayObject.SysMsg('You are not wearing any eligible Items.', c_Red, t_Hint);
      Exit;
    end;

    if Assigned(PlugInEngine.CheckCanUpgradeItem) then begin //禁止升级
      sCheckItemName := StdItem.Name;
      if PlugInEngine.CheckCanUpgradeItem(PlayObject, PChar(sCheckItemName), True) then begin
        Exit;
      end;
    end;

    nRatePoint := Random(nRate * 10);
    nPoint := _MAX(1, Random(nPoint));

    Dec(nValType, 14);
    if not (nRatePoint in [0..10]) then begin
      case nUpgradeItemStatus of //
        0: begin
            PlayObject.SysMsg('Item upgrade failed', c_Red, t_Hint);
          end;
        1: begin
            PlayObject.SendDelItems(UserItem);
            UserItem.wIndex := 0;
            PlayObject.SysMsg('Item was broken!', c_Red, t_Hint);
          end;
        2: begin
            PlayObject.SysMsg('Item upgrade failed and has been restored to default Stats', c_Red, t_Hint);
            UserItem.AddValue[nValType1] := 0;
            UserItem.AddValue[nValType1 + 3] := 0;
            PlayObject.SendUpdateItem(UserItem);
          end;
      end;
      Exit;
    end;

    nAddPoint := nPoint;
    if UserItem.AddValue[nValType1] <> nValType then begin
      UserItem.AddValue[nValType1] := nValType;
      UserItem.AddValue[nValType1 + 3] := 0;
    end;
    if UserItem.AddValue[nValType1 + 3] + nAddPoint > High(Byte) then begin
      nAddPoint := High(Byte) - UserItem.AddValue[nValType1 + 3];
    end;

    UserItem.AddValue[nValType1 + 3] := UserItem.AddValue[nValType1 + 3] + nAddPoint;
    if UserItem.AddValue[nValType1 + 3] > 0 then UserItem.AddValue[nValType1] := nValType;
    PlayObject.SendUpdateItem(UserItem);
    PlayObject.SysMsg('Item upgraded', c_Green, t_Hint);
    PlayObject.SysMsg(StdItem.Name + ': ' +
      IntToStr(UserItem.Dura) + '/' +
      IntToStr(UserItem.DuraMax) + '-' +
      IntToStr(UserItem.AddValue[1]) + '/' +
      IntToStr(UserItem.AddValue[2]) + '/' +
      IntToStr(UserItem.AddValue[3]) + '/' +
      IntToStr(UserItem.AddValue[4]) + '/' +
      IntToStr(UserItem.AddValue[5]) + '/' +
      IntToStr(UserItem.AddValue[6])
      , c_Blue, t_Hint);

  end;
end;

procedure TNormNpc.ActionOfOpenHomePage(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMsg, s10: string;
begin
  s10 := QuestActionInfo.sParam1;
  sMsg := GetLineVariableText(PlayObject, s10);
  PlayObject.SendMsg(Self, RM_SENDOPENHOMEPAGE, 0, 0, 0, 0, sMsg);
end;

procedure TNormNpc.ActionOfChangeItemNewAddValue(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  cMethod: Char;
  nValue, nOValue, nWhere: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  UserItem := nil;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;
  if UserItem <> nil then begin
    nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
    if QuestActionInfo.sParam2 <> '' then begin
      cMethod := QuestActionInfo.sParam2[1];
    end;
    nValue := Str_ToInt(QuestActionInfo.sParam3, -1);
    if nWhere < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam1, nWhere); //增加变量支持
    if nValue < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam3, nValue); //增加变量支持
    if (nWhere <= 0) or (nWhere > 16) or (not (nValue in [0..255])) then begin

      PlayObject.SendChangeItemFail;
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEITEMNEWADDVALUE);
      Exit;
    end;
    if nWhere <= 5 then begin
      UserItem.AddPoint[1] := nWhere;
      case cMethod of
        '+': UserItem.AddPoint[2] := UserItem.AddPoint[2] + nValue;
        '-': UserItem.AddPoint[2] := UserItem.AddPoint[2] - nValue;
        '=': UserItem.AddPoint[2] := nValue;
      end;
    end else begin
      case cMethod of
        '+': UserItem.AddPoint[nWhere - 3] := UserItem.AddPoint[nWhere - 3] + nValue;
        '-': UserItem.AddPoint[nWhere - 3] := UserItem.AddPoint[nWhere - 3] - nValue;
        '=': UserItem.AddPoint[nWhere - 3] := nValue;
      end;
    end;
    //PlayObject.SendUpdateItem(UserItem);
    PlayObject.SendUpdateChangeItem(UserItem);
  end else begin

    PlayObject.SendChangeItemFail;
  end;
end;

procedure TNormNpc.ActionOfSetItemsLightEx(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nValue, nOValue: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  UserItem := nil;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;
  if UserItem <> nil then begin
    nValue := Str_ToInt(QuestActionInfo.sParam1, -1);
    if nValue < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam1, nValue); //增加变量支持
    if nValue < 0 then begin

      PlayObject.SendChangeItemFail;
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETITEMSLIGHTEX);
      Exit;
    end;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (UserItem.wIndex <= 0) or (StdItem = nil) then begin
      PlayObject.SendChangeItemFail;
      Exit;
    end;
    nOValue := UserItem.AddValue[12];
    UserItem.AddValue[12] := nValue;
    if nOValue <> nValue then
      PlayObject.SendUpdateChangeItem(UserItem);
  end;
  //PlayObject.SysMsg('装备升级成功', c_Green, t_Hint);
end;

procedure TNormNpc.ActionOfSetItemsLight(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nValue, nOValue, nWhere: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
  nValue := Str_ToInt(QuestActionInfo.sParam2, 0);
  if nWhere < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam1, nWhere); //增加变量支持
  if (nWhere < 0) or (nWhere > High(THumanUseItems)) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETITEMSLIGHT);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (UserItem.wIndex <= 0) or (StdItem = nil) then begin
    PlayObject.SysMsg('You are not wearing any eligible Items.', c_Red, t_Hint);
    Exit;
  end;
  nOValue := UserItem.AddValue[12];
  UserItem.AddValue[12] := nValue;
  if nOValue <> nValue then
    PlayObject.SendUpdateItem(UserItem);
  //PlayObject.SysMsg('装备升级成功', c_Green, t_Hint);
end;

procedure TNormNpc.ActionOfSnow(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sMapName: string;
  Envir: TEnvirnoment;
  nLevel: Integer;
  boOldSnow: Boolean;
  nOldLevel: Integer;
  OnLineObject: TPlayObject;
begin
  sMapName := QuestActionInfo.sParam1;
  nLevel := Str_ToInt(QuestActionInfo.sParam2, -1);
  Envir := g_MapManager.FindMap(sMapName);
  if (nLevel < 0) or (Envir = nil) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SNOW);
    Exit;
  end;
  boOldSnow := Envir.m_boSNOW;
  nOldLevel := Envir.m_nSNOWLEVEL;
  Envir.m_boSNOW := nLevel > 0;
  Envir.m_nSNOWLEVEL := nLevel;
  if (boOldSnow <> Envir.m_boSNOW) or (Envir.m_nSNOWLEVEL <> nOldLevel) then begin
    for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
      OnLineObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[I]);
      if (not OnLineObject.m_boGhost) and
        (not OnLineObject.m_boDeath) and
        (OnLineObject.m_boHeroVersion) and
        (OnLineObject.m_PEnvir = Envir) and
        (not OnLineObject.m_boNotOnlineAddExp) and
        (not OnLineObject.m_boAI) then
        OnLineObject.SendDefMessage(SM_SENDSNOW, Envir.m_nSNOWLEVEL, Integer(Envir.m_boSNOW), 0, 0, '');
    end;
  end;
end;

procedure TNormNpc.ActionOfRandomUpgradeItem(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nType: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  UserItem := nil;
  if (PlayObject.m_nItemIndex < 0) or (PlayObject.m_nItemIndex >= PlayObject.m_ItemList.Count) then begin

    PlayObject.SendChangeItemFail;
    Exit;
  end;
  if (PlayObject.m_nItemIndex >= 0) and (PlayObject.m_nItemIndex < PlayObject.m_ItemList.Count) then begin
    UserItem := pTUserItem(PlayObject.m_ItemList.Items[PlayObject.m_nItemIndex]);
    if (UserItem.MakeIndex <> PlayObject.m_nUpgradeItemIndex) then begin

      PlayObject.SendChangeItemFail;
      Exit;
    end;
  end;
  if UserItem <> nil then begin
    nType := Str_ToInt(QuestActionInfo.sParam1, -1);
    case nType of
      0: begin
          if Random(g_Config.nScriptRandomAddValue {10}) = 0 then //几率控制
            UserEngine.RandomUpgradeItem(UserItem); //生成极品装备
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26] then begin
            if StdItem.Shape in [130, 131, 132] then begin
              UserEngine.GetUnknowItemValue(UserItem);
            end;
          end;
        end;
      1: begin
          UserEngine._RandomItemLimitDay(UserItem, g_Config.nScriptRandomNotLimit);
        end;
      2: begin
          if Random(g_Config.nScriptRandomNewAddValue {10}) = 0 then
            UserEngine._RandomUpgradeItem(UserItem);
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26] then begin
            if StdItem.Shape in [130, 131, 132] then begin
              UserEngine._GetUnknowItemValue(UserItem);
            end;
          end;
        end;
      3: begin
          if Random(g_Config.nScriptRandomAddPoint) = 0 then
            UserEngine.RandomItemAddPoint(UserItem);
        end;
    else begin
        if Random(g_Config.nScriptRandomAddValue {10}) = 0 then //几率控制
          UserEngine.RandomUpgradeItem(UserItem); //生成极品装备

        UserEngine._RandomItemLimitDay(UserItem, g_Config.nScriptRandomNotLimit);
        if Random(g_Config.nScriptRandomNewAddValue {10}) = 0 then
          UserEngine._RandomUpgradeItem(UserItem);

        if Random(g_Config.nScriptRandomAddPoint) = 0 then
          UserEngine.RandomItemAddPoint(UserItem);

        StdItem := UserEngine.GetStdItem(UserItem.wIndex);

        if StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26] then begin
          if StdItem.Shape in [130, 131, 132] then begin
            UserEngine.GetUnknowItemValue(UserItem);

            UserEngine._GetUnknowItemValue(UserItem);
          end;
        end;
      end;
    end;
    PlayObject.SendUpdateChangeItem(UserItem);
  end;
  //PlayObject.SysMsg('装备升级成功', c_Green, t_Hint);
end;

procedure TNormNpc.ActionOfReadRandomStr(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  LoadList: TStringList;
  sListFileName: string;
  nIndex: Integer;
  sStr: string;

  sVar, sValue: string;
  nValue: Integer;
  VarInfo: TVarInfo;
begin
  if (QuestActionInfo.sParam1 = '') or (QuestActionInfo.sParam2 = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_READRANDOMSTR);
    Exit;
  end;
  sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;

  LoadList := TStringList.Create;
  if FileExists(sListFileName) then begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
  end;
  nIndex := Random(LoadList.Count - 1);

  if (nIndex >= 0) and (nIndex < LoadList.Count) then begin
    sStr := LoadList.Strings[nIndex];
  end else begin
    sStr := '';
  end;
  LoadList.Free;

  VarInfo := GetVarValue(PlayObject, QuestActionInfo.sParam2, sVar, sValue, nValue);
  case VarInfo.VarAttr of
    aNone,
      aConst: ScriptActionError(PlayObject, '', QuestActionInfo, sSC_READRANDOMSTR);
    aFixStr: SetValNameValue(PlayObject, sVar, sStr, nValue);
    aDynamic: SetDynamicValue(PlayObject, sVar, sStr, nValue);
  end;
end;

procedure TNormNpc.ActionOfChangeRangeMonPos(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMonName: string;
  sMAP, sNewMap: string;

  nX, nY, nNewX, nNewY: Integer;
  nRange: Integer;

  OEnvir: TEnvirnoment;
  NEnvir: TEnvirnoment;
  ActorObject: TActorObject;
  ObjectList: TList;
  I: Integer;
begin
  sMonName := QuestActionInfo.sParam1;
  GetVarValue(PlayObject, QuestActionInfo.sParam1, sMonName);
  sMAP := QuestActionInfo.sParam2;
  //GetVarValue(PlayObject, QuestActionInfo.sParam2, sMAP);

  nX := Str_ToInt(QuestActionInfo.sParam3, -1);
  nY := Str_ToInt(QuestActionInfo.sParam4, -1);
  nRange := Str_ToInt(QuestActionInfo.sParam5, -1);

  sNewMap := QuestActionInfo.sParam6;
  //GetVarValue(PlayObject, QuestActionInfo.sParam6, sNewMap);

  nNewX := Str_ToInt(QuestActionInfo.sParam7, -1);
  nNewY := Str_ToInt(QuestActionInfo.sParam8, -1);

  if nX < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam3, nX);
  if nY < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam4, nY);
  if nNewX < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam7, nNewX);
  if nNewY < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam8, nNewY);

  if (sMonName = '') or (sMAP = '') or (sNewMap = '') or (nRange < 0) or
    (nX < 0) or (nY < 0) or (nNewX < 0) or (nNewY < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGERANGEMONPOS);
    Exit;
  end;
  OEnvir := g_MapManager.FindMap(sMAP);
  if OEnvir = nil then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam2, sMAP);
    OEnvir := g_MapManager.FindMap(sMAP);
  end;

  NEnvir := g_MapManager.FindMap(sNewMap);
  if NEnvir = nil then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam6, sNewMap);
    NEnvir := g_MapManager.FindMap(sNewMap);
  end;

  if (OEnvir = nil) or (NEnvir = nil) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGERANGEMONPOS);
    Exit;
  end;
  ObjectList := TList.Create;
  try
    if OEnvir.GetRangeActorObject(nX, nY, nRange, True, ObjectList) > 0 then begin
      for I := 0 to ObjectList.Count - 1 do begin
        ActorObject := TActorObject(ObjectList.Items[I]);
        if CompareText(ActorObject.m_sCharName, sMonName) = 0 then
          ActorObject.SpaceMove(sNewMap, nNewX, nNewY, 0);
      end;
    end;
  finally
    ObjectList.Free;
  end;
end;

procedure TNormNpc.ActionOfSpell(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sMapName: string;
  nX, nY: Integer;
  nRange: Integer;
  nType: Integer;
  nPower: Integer;
  Envir: TEnvirnoment;
  ActorObject: TActorObject;
  RobotObject: TRobotObject;
  ActorObjectList: TList;
begin
  sMapName := QuestActionInfo.sParam1;
  nX := Str_ToInt(QuestActionInfo.sParam2, -1);
  nY := Str_ToInt(QuestActionInfo.sParam3, -1);
  nRange := Str_ToInt(QuestActionInfo.sParam4, -1);
  nType := Str_ToInt(QuestActionInfo.sParam5, -1);
  nPower := Str_ToInt(QuestActionInfo.sParam6, -1);
  if nX < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam2, nX);
  if nY < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam3, nY);
  if nRange < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam4, nRange);
  if nType < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam5, nType);
  if nPower < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam6, nPower);
  Envir := g_MapManager.FindMap(sMapName);
  if Envir = nil then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam1, sMapName);
    Envir := g_MapManager.FindMap(sMapName);
  end;

  if (sMapName = '') or (nX < 0) or (nY < 0) or (nRange < 0) or (nType < 0) or (Envir = nil) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SPELL);
    Exit;
  end;
  if PlayObject is TRobotObject then begin
    RobotObject := TRobotObject(PlayObject);

    ActorObjectList := TList.Create;
    if Envir.GetRangeActorObject(nX, nY, nRange, False, ActorObjectList) > 0 then begin
      for I := 0 to ActorObjectList.Count - 1 do begin
        ActorObject := TActorObject(ActorObjectList.Items[I]);
        if RobotObject.IsProperTarget(ActorObject) then begin
          ActorObject.SendMsg(nil, RM_MAGSTRUCK_MINE, 0, nPower, 0, 0, '');
        end;
      end;
    end;
    ActorObjectList.Free;

    RobotObject.SendRefMsg(Envir, nX, nY, RM_10205, 0, nX, nY, nType, '');
  end else begin

  end;
end;

procedure TNormNpc.ActionOfAddMapMagicEvent(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sMapName: string;
  nX, nY: Integer;
  nRange: Integer;
  nType: Integer;
  nUseType: Integer;
  nPower: Integer;
  boClose: Boolean;
  nTime: Integer;
  Envir: TEnvirnoment;
  Event: TMapMagicEvent;
begin
  sMapName := QuestActionInfo.sParam1;
  nX := Str_ToInt(QuestActionInfo.sParam2, -1);
  nY := Str_ToInt(QuestActionInfo.sParam3, -1);
  nRange := Str_ToInt(QuestActionInfo.sParam4, -1);
  nType := Str_ToInt(QuestActionInfo.sParam5, -1);
  nPower := Str_ToInt(QuestActionInfo.sParam6, -1);
  nUseType := Str_ToInt(QuestActionInfo.sParam7, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam8, 0);

  if nX < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam2, nX);
  if nY < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam3, nY);
  if nRange < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam4, nRange);
  if nType < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam5, nType);
  if nPower < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam6, nPower);

  if (nUseType < 0) or (nUseType > 1) then begin
    boClose := False;
    nUseType := 0;
  end else begin
    boClose := True;
  end;

  Envir := g_MapManager.FindMap(sMapName);
  if Envir = nil then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam1, sMapName);
    Envir := g_MapManager.FindMap(sMapName);
  end;

  if (sMapName = '') or (nX < 0) or (nY < 0) or (nRange < 0) or (nType < 0) or (Envir = nil) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDMAPMAGICEVENT);
    Exit;
  end;
  //if g_EventManager.GetEvent(Envir, nX, nY, ET_MAPMAGIC) = nil then begin
  Event := TMapMagicEvent.Create(Envir, nX, nY, nType + 100);
  Event.m_nDamage := nPower;
  Event.m_nRange := nRange;
  Event.m_boAllowClose := boClose;
  Event.m_btUseType := nUseType;
  if Event.m_btUseType = 1 then begin
    Event.m_nUseCount := 0;
    Event.m_nMaxCount := nTime;
  end else Event.m_dwContinueTime := 1000 * nTime;
  g_EventManager.AddEvent(Event);
  //end;
end;

procedure TNormNpc.ActionOfRandomAddMapMagicEvent(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
  function GetRandXY(Envir: TEnvirnoment; var nX: Integer; var nY: Integer): Boolean;
  var
    n14, n18, n1C: Integer;
  begin
    Result := False;
    if Envir.m_nWidth < 80 then n18 := 3
    else n18 := 10;
    if Envir.m_nHeight < 150 then begin
      if Envir.m_nHeight < 50 then n1C := 2
      else n1C := 15;
    end else n1C := 50;
    n14 := 0;
    while (True) do begin
      if Envir.CanWalk(nX, nY, True) { and Envir.CanWalkOfEvent(Self, nX, nY) and (not InLockRect(Envir, nX, nY))} then begin
        Result := True;
        Break;
      end;
      if nX < (Envir.m_nWidth - n1C - 1) then Inc(nX, n18)
      else begin
        nX := Random(Envir.m_nWidth);
        if nY < (Envir.m_nHeight - n1C - 1) then Inc(nY, n18)
        else nY := Random(Envir.m_nHeight);
      end;
      Inc(n14);
      if n14 >= 201 then Break;
    end;
  end;
var
  I: Integer;
  sMapName: string;
  nX, nY: Integer;
  nCount: Integer;
  nRange: Integer;
  nType: Integer;
  nUseType: Integer;
  nPower: Integer;
  boClose: Boolean;
  nTime: Integer;
  Envir: TEnvirnoment;
  Event: TMapMagicEvent;
begin
  sMapName := QuestActionInfo.sParam1;

  nRange := Str_ToInt(QuestActionInfo.sParam2, -1);
  nType := Str_ToInt(QuestActionInfo.sParam3, -1);
  nPower := Str_ToInt(QuestActionInfo.sParam4, -1);
  nUseType := Str_ToInt(QuestActionInfo.sParam5, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam6, 0);

  nCount := Str_ToInt(QuestActionInfo.sParam7, -1);

  if nRange < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam2, nRange);
  if nType < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam3, nType);
  if nPower < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam4, nPower);
  if nCount < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam7, nCount);
  if (nUseType < 0) or (nUseType > 1) then begin
    boClose := False;
    nUseType := 0;
  end else begin
    boClose := True;
  end;

  Envir := g_MapManager.FindMap(sMapName);
  if Envir = nil then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam1, sMapName);
    Envir := g_MapManager.FindMap(sMapName);
  end;

  if (sMapName = '') or (nCount <= 0) or (nRange < 0) or (nType < 0) or (Envir = nil) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_RANDOMADDMAPMAGICEVENT);
    Exit;
  end;

  for I := 0 to nCount - 1 do begin
  //if g_EventManager.GetEvent(Envir, nX, nY, ET_MAPMAGIC) = nil then begin
    nX := Random(Envir.m_nWidth);
    nY := Random(Envir.m_nHeight);
    if GetRandXY(Envir, nX, nY) then begin
      Event := TMapMagicEvent.Create(Envir, nX, nY, nType + 100);
      Event.m_nDamage := nPower;
      Event.m_nRange := nRange;
      Event.m_boAllowClose := boClose;
      Event.m_btUseType := nUseType;
      if Event.m_btUseType = 1 then begin
        Event.m_nUseCount := 0;
        Event.m_nMaxCount := nTime;
      end else Event.m_dwContinueTime := 1000 * nTime;
      g_EventManager.AddEvent(Event);
    end;
  end;
  //end;
end;

procedure TNormNpc.ActionOfDropItemMap(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sMapName: string;
  sItemName: string;
  nX, nY: Integer;
  nCount: Integer;
  nRange: Integer;
  Envir: TEnvirnoment;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  sMapName := QuestActionInfo.sParam1;
  nX := Str_ToInt(QuestActionInfo.sParam2, -1);
  nY := Str_ToInt(QuestActionInfo.sParam3, -1);
  nRange := Str_ToInt(QuestActionInfo.sParam4, -1);
  nCount := Str_ToInt(QuestActionInfo.sParam6, -1);
  sItemName := QuestActionInfo.sParam5;
  Envir := g_MapManager.FindMap(sMapName);

  if Envir = nil then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam1, sMapName);
    Envir := g_MapManager.FindMap(sMapName);
  end;

  if nX < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam2, nX);
  if nY < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam3, nY);
  if nRange < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam4, nRange);
  if nCount < 0 then GetVarValue(PlayObject, QuestActionInfo.sParam6, nCount);

  StdItem := UserEngine.GetStdItem(sItemName);
  if (StdItem = nil) then begin
    GetVarValue(PlayObject, QuestActionInfo.sParam5, sItemName);
    StdItem := UserEngine.GetStdItem(sItemName);
  end;

  if (sMapName = '') or (nCount < 0) or (nX < 0) or (nY < 0) or (nRange < 0) or (Envir = nil) or (StdItem = nil) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DROPITEMMAP);
    Exit;
  end;
  for I := 0 to nCount - 1 do begin
    New(UserItem);
    if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
      PlayObject.DropItemDown(UserItem, nRange, PlayObject, Envir, nX, nY);
    end;
    Dispose(UserItem);
  end;
end;

//声明变量
//VAR 数据类型(Integer String) 类型(HUMAN GUILD GLOBAL) 变量值

procedure TNormNpc.ActionOfActVarList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I, II: Integer;
  sListFileName: string;
  sLineText: string;
  sCmd: string;
  nCMD: Integer;
  sType: string;
  VarType: TVarType;

  sVarType: string;
  sVarName: string;
  sVarValue: string;
  nVarValue: Integer;

  sName: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;

  LoadList: TStringList;

  sFileName: string;
  IniFile: TIniFile;
resourcestring
  sVarFound = '变量%s已存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
  if not FileExists(sListFileName) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ACTVARLIST);
    Exit;
  end;

  LoadList := TStringList.Create;
  if FileExists(sListFileName) then begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
  end;

  for I := 0 to LoadList.Count - 1 do begin
    sLineText := Trim(LoadList.Strings[I]);
    if (sLineText = '') or (sLineText[1] = ';') then Continue;
    sLineText := GetValidStrCap(sLineText, sCmd, [' ', #9]);
    sCmd := UpperCase(sCmd);
    nCMD := 0;
    if sCmd = sSC_VAR then nCMD := nSC_VAR;
    if sCmd = sSC_LOADVAR then nCMD := nSC_LOADVAR;
    if sCmd = sSC_SAVEVAR then nCMD := nSC_SAVEVAR;

    case nCMD of
      nSC_VAR: begin
          VarType := vNone;
          sLineText := GetValidStrCap(sLineText, sVarType, [' ', #9]);
          sLineText := GetValidStrCap(sLineText, sType, [' ', #9]);
          sLineText := GetValidStrCap(sLineText, sVarName, [' ', #9]);
          sLineText := GetValidStrCap(sLineText, sVarValue, [' ', #9]);
          nVarValue := Str_ToInt(QuestActionInfo.sParam4, 0);

          if CompareText(sVarType, 'Integer') = 0 then VarType := vInteger;
          if CompareText(sVarType, 'String') = 0 then VarType := vString;
          if (sType = '') or (sVarName = '') or (VarType = vNone) then Continue;

          DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
          if DynamicVarList = nil then Continue;

          boFoundVar := False;
          for II := 0 to DynamicVarList.Count - 1 do begin
            if CompareText(pTDynamicVar(DynamicVarList.Items[I]).sName, sVarName) = 0 then begin
              boFoundVar := True;
              Break;
            end;
          end;

          if not boFoundVar then begin
            New(DynamicVar);
            DynamicVar.sName := sVarName;
            DynamicVar.VarType := VarType;
            DynamicVar.nInternet := nVarValue;
            DynamicVar.sString := sVarValue;
            DynamicVarList.Add(DynamicVar);
          end;
        end;
      nSC_LOADVAR: begin
          sLineText := GetValidStrCap(sLineText, sType, [' ', #9]);
          sLineText := GetValidStrCap(sLineText, sVarName, [' ', #9]);
          sLineText := GetValidStrCap(sLineText, sFileName, [' ', #9]);
          sFileName := g_Config.sEnvirDir + m_sPath + sFileName;

          if (sType = '') or (sVarName = '') or not FileExists(sFileName) then Continue;

          DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);

          if DynamicVarList = nil then Continue;

          boFoundVar := False;
          IniFile := TIniFile.Create(sFileName);
          //IniFile := GetMemoryIniFile(sFileName);
          for II := 0 to DynamicVarList.Count - 1 do begin
            DynamicVar := DynamicVarList.Items[II];
            if CompareText(DynamicVar.sName, sVarName) = 0 then begin
              case DynamicVar.VarType of
                vInteger: DynamicVar.nInternet := IniFile.ReadInteger(sName, DynamicVar.sName, 0);
                vString: DynamicVar.sString := IniFile.ReadString(sName, DynamicVar.sName, '');
              end;
              boFoundVar := True;
              Break;
            end;
          end;
          IniFile.Free;
        end;
      nSC_SAVEVAR: begin
          sLineText := GetValidStrCap(sLineText, sType, [' ', #9]);
          sLineText := GetValidStrCap(sLineText, sVarName, [' ', #9]);
          sLineText := GetValidStrCap(sLineText, sFileName, [' ', #9]);
          sFileName := g_Config.sEnvirDir + m_sPath + sFileName;

          if (sType = '') or (sVarName = '') or not FileExists(sFileName) then Continue;

          DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);

          if DynamicVarList = nil then Continue;

          boFoundVar := False;
          IniFile := TIniFile.Create(sFileName);
          //IniFile := GetMemoryIniFile(sFileName);
          for II := 0 to DynamicVarList.Count - 1 do begin
            DynamicVar := DynamicVarList.Items[II];
            if CompareText(DynamicVar.sName, sVarName) = 0 then begin
              case DynamicVar.VarType of
                vInteger: IniFile.WriteInteger(sName, DynamicVar.sName, DynamicVar.nInternet);
                vString: IniFile.WriteString(sName, DynamicVar.sName, DynamicVar.sString);
              end;
              boFoundVar := True;
              Break;
            end;
          end;
          IniFile.Free;
        end;
    else Continue;
    end;
  end;
  LoadList.Free;
end;

//声明变量
//VAR 数据类型(Integer String) 类型(HUMAN GUILD GLOBAL) 变量值

procedure TNormNpc.ActionOfVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sType: string;
  VarType: TVarType;
  sVarName: string;
  sVarValue: string;
  nVarValue: Integer;
  sName: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
resourcestring
  sVarFound = '变量%s已存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  sType := QuestActionInfo.sParam2;
  sVarName := QuestActionInfo.sParam3;
  sVarValue := QuestActionInfo.sParam4;
  nVarValue := Str_ToInt(QuestActionInfo.sParam4, 0);
  VarType := vNone;
  if CompareText(QuestActionInfo.sParam1, 'Integer') = 0 then VarType := vInteger;
  if CompareText(QuestActionInfo.sParam1, 'String') = 0 then VarType := vString;

  if (sType = '') or (sVarName = '') or (VarType = vNone) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_VAR);
    Exit;
  end;

  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);

  if (DynamicVarList = nil) then begin
    ScriptActionError(PlayObject, Format(sVarTypeError, [sType]), QuestActionInfo, sSC_VAR);
    Exit;
  end;

  boFoundVar := False;
  for I := 0 to DynamicVarList.Count - 1 do begin
    if CompareText(pTDynamicVar(DynamicVarList.Items[I]).sName, sVarName) = 0 then begin
      boFoundVar := True;
      Break;
    end;
  end;
  if not boFoundVar then begin
    New(DynamicVar);
    DynamicVar.sName := sVarName;
    DynamicVar.VarType := VarType;
    DynamicVar.nInternet := nVarValue;
    DynamicVar.sString := sVarValue;
    DynamicVarList.Add(DynamicVar);
  end else begin
    ScriptActionError(PlayObject, Format(sVarFound, [sVarName, sType]), QuestActionInfo, sSC_VAR);
  end;
end;

procedure TNormNpc.ActionOfLoadVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sType: string;
  sVarName: string;
  sFileName: string;
  sName: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
  IniFile: TIniFile;
resourcestring
  sVarFound = '变量%s不存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  sType := QuestActionInfo.sParam1;
  sVarName := QuestActionInfo.sParam2;
  sFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam3;
  if (sType = '') or (sVarName = '') or not FileExists(sFileName) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_LOADVAR);
    Exit;
  end;
  boFoundVar := False;
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  //IniFile := GetMemoryIniFile(sFileName);
  if (DynamicVarList = nil) then begin
    ScriptActionError(PlayObject, Format(sVarTypeError, [sType]), QuestActionInfo, sSC_LOADVAR);
  end else begin
    IniFile := TIniFile.Create(sFileName);
    if IniFile <> nil then begin
      for I := 0 to DynamicVarList.Count - 1 do begin
        DynamicVar := DynamicVarList.Items[I];
        if CompareText(DynamicVar.sName, sVarName) = 0 then begin
          DynamicVar.sFileName := sFileName;
          try
            case DynamicVar.VarType of
              vInteger: DynamicVar.nInternet := IniFile.ReadInteger(sName, DynamicVar.sName, 0);
              vString: DynamicVar.sString := IniFile.ReadString(sName, DynamicVar.sName, '');
            end;
          except
            on E: Exception do begin
              MainOutMessage('[Exception] TNormNpc::ActionOfLoadVar');
              MainOutMessage(E.Message);
            end;
          end;
          boFoundVar := True;
          Break;
        end;
      end;
      IniFile.Free;
    end;
    if not boFoundVar then
      ScriptActionError(PlayObject, Format(sVarFound, [sVarName, sType]), QuestActionInfo, sSC_LOADVAR);
  end;
end;

//保存变量值
//SAVEVAR 变量类型 变量名 文件名

procedure TNormNpc.ActionOfSaveVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sType: string;
  sVarName: string;
  sFileName: string;
  sName: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
  IniFile: TIniFile;
resourcestring
  sVarFound = '变量%s不存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  sType := QuestActionInfo.sParam1;
  sVarName := QuestActionInfo.sParam2;
  sFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam3;
  if (sType = '') or (sVarName = '') or not FileExists(sFileName) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SAVEVAR);
    Exit;
  end;

  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  //IniFile := GetMemoryIniFile(sFileName);
  if (DynamicVarList = nil) then begin
    ScriptActionError(PlayObject, Format(sVarTypeError, [sType]), QuestActionInfo, sSC_SAVEVAR);
  end else begin
    boFoundVar := False;
    IniFile := TIniFile.Create(sFileName);
    if IniFile <> nil then begin
      for I := 0 to DynamicVarList.Count - 1 do begin
        DynamicVar := DynamicVarList.Items[I];
        if CompareText(DynamicVar.sName, sVarName) = 0 then begin
          try
            case DynamicVar.VarType of
              vInteger: IniFile.WriteInteger(sName, DynamicVar.sName, DynamicVar.nInternet);
              vString: IniFile.WriteString(sName, DynamicVar.sName, DynamicVar.sString);
            end;
          except
            on E: Exception do begin
              MainOutMessage('[Exception] TNormNpc::ActionOfSaveVar');
              MainOutMessage(E.Message);
            end;
          end;
          boFoundVar := True;
          Break;
        end;
      end;
      IniFile.Free;
    end;
    if not boFoundVar then
      ScriptActionError(PlayObject, Format(sVarFound, [sVarName, sType]), QuestActionInfo, sSC_SAVEVAR);
  end;
end;

procedure TNormNpc.ActionOfCalcVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sType: string;
  sVarName: string;
  sName: string;
  sVarValue: string;
  nVarValue: Integer;
  sMethod: string;
  cMethod: Char;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
resourcestring
  sVarFound = '变量%s不存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  sType := QuestActionInfo.sParam1;
  sVarName := QuestActionInfo.sParam2;
  sMethod := QuestActionInfo.sParam3;
  sVarValue := QuestActionInfo.sParam4;
  nVarValue := Str_ToInt(QuestActionInfo.sParam4, 0);

  if (sType = '') or (sVarName = '') or (sMethod = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CALCVAR);
    Exit;
  end;

  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);

  if (DynamicVarList = nil) then begin
    ScriptActionError(PlayObject, Format(sVarTypeError, [sType]), QuestActionInfo, sSC_CALCVAR);
    Exit;
  end;

  boFoundVar := False;
  cMethod := sMethod[1];

  for I := 0 to DynamicVarList.Count - 1 do begin
    DynamicVar := DynamicVarList.Items[I];
    if CompareText(DynamicVar.sName, sVarName) = 0 then begin
      case DynamicVar.VarType of
        vInteger: begin
            case cMethod of
              '=': DynamicVar.nInternet := nVarValue;
              '+': DynamicVar.nInternet := DynamicVar.nInternet + nVarValue;
              '-': DynamicVar.nInternet := DynamicVar.nInternet - nVarValue;
              '*': DynamicVar.nInternet := DynamicVar.nInternet * nVarValue;
              '/': if nVarValue > 0 then DynamicVar.nInternet := DynamicVar.nInternet div nVarValue;
            end;
          end;
        vString: begin
            case cMethod of
              '=': DynamicVar.sString := sVarValue;
              '+': DynamicVar.sString := DynamicVar.sString + sVarValue;
            end;
          end;
      end;
      boFoundVar := True;
      Break;
    end;
  end;

  if not boFoundVar then
    ScriptActionError(PlayObject, Format(sVarFound, [sVarName, sType]), QuestActionInfo, sSC_CALCVAR);
end;

//读取变量值
//LOADVAR 变量类型 变量名 文件名

procedure TNormNpc.ActionOfReadVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sVarName: string;
  sName: string;
  sFileName: string;
  IniFile: TIniFile;

  sClass: string;
  sNo: string;
  nValNo: Integer;
  nValue: Integer;
  sValue: string;

  sVar: string;
  VarInfo: TVarInfo;
begin
  sFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam2;
  if (QuestActionInfo.sParam1 = '') or not FileExists(sFileName) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_READ);
    Exit;
  end;

 { if (sVarName[1] = '<') and (sVarName[Length(sVarName)] = '>') then begin //<$STR(S0)>
    sVarName := ArrestStringEx(sVarName, '<', '>', sName);
  end;

  if CompareLStr(sName, '$STR(', Length('$STR(')) then begin //$STR(S0)
    sVarName := ArrestStringEx(sName, '(', ')', sName);
  end;

  if (sName[1] = '$') then begin //$S0
    sName := Copy(sName, 2, Length(sName) - 1);
  end;

  if sName = '' then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_READ);
    Exit;
  end;

  sClass := UpperCase(sName[1]);
  sNo := Copy(sVarName, 2, Length(sName) - 1);
  nValNo := Str_ToInt(sNo, 0);
  sClass := sClass + IntToStr(nValNo); }


  VarInfo := GetVarValue(PlayObject, QuestActionInfo.sParam1, sVar, sValue, nValue);

  if (sVar[1] = '<') and (sVar[Length(sVar)] = '>') then begin //<$STR(S0)>
    sName := sVar;
    sName := ArrestStringEx(sName, '<', '>', sVarName);
  end;

  if CompareLStr(sVarName, '$STR(', Length('$STR(')) then begin //$STR(S0)
    IniFile := TIniFile.Create(sFileName);

    sName := sVarName;
    sName := ArrestStringEx(sName, '(', ')', sVarName);

    sNo := Copy(sVarName, 2, Length(sVarName) - 1);
    nValNo := Str_ToInt(sNo, -1);

    if (nValNo < 0) or (not IsNumber(sNo)) then begin
      sClass := sVarName;
      {case VarInfo.VarType of
        vInteger:
          if PlayObject.m_StringList.GetIndex(UpperCase(sVarName)) >= 0 then begin
            sClass := sVarName;
          end;
        vString:
          if PlayObject.m_StringList.GetIndex(UpperCase(sVarName)) >= 0 then begin
            sClass := sVarName;
          end;
      end;}
    end else begin
      sClass := UpperCase(sVarName[1]);
      sClass := sClass + IntToStr(nValNo);
    end;

    case VarInfo.VarAttr of
      aNone, aConst: begin
          ScriptActionError(PlayObject, '', QuestActionInfo, sSC_READ);
          //Exit;
        end;
      aFixStr: begin
          {case VarInfo.VarType of
            vInteger: nValue := IniFile.ReadInteger(PlayObject.m_sCharName, sClass, nValue);
            vString: sValue := IniFile.ReadString(PlayObject.m_sCharName, sClass, sValue);
          end;  }
          sValue := IniFile.ReadString(PlayObject.m_sCharName, sClass, sValue);
          nValue := Str_ToInt(sValue, 0);
          SetValNameValue(PlayObject, sVar, sValue, nValue);
        end;
      aDynamic: begin
          {case VarInfo.VarType of
            vInteger: nValue := IniFile.ReadInteger(PlayObject.m_sCharName, sClass, nValue);
            vString: sValue := IniFile.ReadString(PlayObject.m_sCharName, sClass, sValue);
          end;  }
          sValue := IniFile.ReadString(PlayObject.m_sCharName, sClass, sValue);
          nValue := Str_ToInt(sValue, 0);
          SetDynamicValue(PlayObject, sVar, sValue, nValue);
        end;
    end;
    IniFile.Free;
  end else ScriptActionError(PlayObject, '', QuestActionInfo, sSC_READ);
end;

//保存变量值
//SAVEVAR 变量类型 变量名 文件名

procedure TNormNpc.ActionOfWriteVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sVarName: string;
  sName: string;
  sFileName: string;
  IniFile: TIniFile;

  sClass: string;
  sNo: string;
  sVar: string;
  nValNo: Integer;
  nValue: Integer;
  sValue: string;
  VarInfo: TVarInfo;
begin
  sFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam2;
  if (QuestActionInfo.sParam1 = '') or not FileExists(sFileName) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_WRITE);
    Exit;
  end;

  {if (sVarName[1] = '<') and (sVarName[Length(sVarName)] = '>') then begin //<$STR(S0)>
    sVarName := ArrestStringEx(sVarName, '<', '>', sName);
  end;

  if CompareLStr(sName, '$STR(', Length('$STR(')) then begin //$STR(S0)
    sVarName := ArrestStringEx(sName, '(', ')', sName);
  end;

  if (sName[1] = '$') then begin //$S0
    sName := Copy(sName, 2, Length(sName) - 1);
  end;

  if sName = '' then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_WRITE);
    Exit;
  end;

  sClass := UpperCase(sName[1]);
  sNo := Copy(sVarName, 2, Length(sName) - 1);
  nValNo := Str_ToInt(sNo, 0);
  sClass := sClass + IntToStr(nValNo); }



  VarInfo := GetVarValue(PlayObject, QuestActionInfo.sParam1, sVar, sValue, nValue);

  if (sVar[1] = '<') and (sVar[Length(sVar)] = '>') then begin //<$STR(S0)>
    sName := sVar;
    sName := ArrestStringEx(sName, '<', '>', sVarName);
  end;

  if CompareLStr(sVarName, '$STR(', Length('$STR(')) then begin //$STR(S0)
    IniFile := TIniFile.Create(sFileName);
    sName := sVarName;
    sName := ArrestStringEx(sName, '(', ')', sVarName);
    {
    sClass := UpperCase(sVarName[1]);
    sNo := Copy(sVarName, 2, Length(sVarName) - 1);
    nValNo := Str_ToInt(sNo, 0);
    sClass := sClass + IntToStr(nValNo);
     }

    sNo := Copy(sVarName, 2, Length(sVarName) - 1);
    nValNo := Str_ToInt(sNo, -1);

    if (nValNo < 0) or (not IsNumber(sNo)) then begin
      sClass := sVarName;
     { case VarInfo.VarType of
        vInteger:
          if PlayObject.m_StringList.GetIndex(UpperCase(sVarName)) >= 0 then begin
            sClass := sVarName;
          end;
        vString:
          if PlayObject.m_StringList.GetIndex(UpperCase(sVarName)) >= 0 then begin
             sClass := sVarName;
          end;
      end;}
    end else begin
      sClass := UpperCase(sVarName[1]);
      sClass := sClass + IntToStr(nValNo);
    end;

    case VarInfo.VarAttr of
      aNone, aConst: begin
          ScriptActionError(PlayObject, '', QuestActionInfo, sSC_WRITE);
        //Exit;
        end;
      aFixStr, aDynamic: begin
          IniFile.WriteString(PlayObject.m_sCharName, sClass, sValue);
         { case VarInfo.VarType of
            vInteger: IniFile.WriteInteger(PlayObject.m_sCharName, sClass, nValue);
            vString: IniFile.WriteString(PlayObject.m_sCharName, sClass, sValue);
          end; }
        end;
    end;
    IniFile.Free;
  end else ScriptActionError(PlayObject, '', QuestActionInfo, sSC_WRITE);
end;

procedure TNormNpc.Initialize;
begin
  inherited;
  m_Castle := g_CastleManager.InCastleWarArea(Self);
end;

function TNormNpc.ConditionOfCheckNameDateList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sListFileName, sLineText, sHumName, sDate: string;
  boDeleteExprie, boNoCompareHumanName: Boolean;
  dOldDate: TDateTime;
  cMethod: Char;
  nValNo, nValNoDay, nDayCount, nDay: Integer;

  sVar, sValue: string;
  nValue: Integer;
  VarInfo: TVarInfo;
begin
  Result := False;
  nDayCount := Str_ToInt(QuestConditionInfo.sParam3, -1);
  boDeleteExprie := CompareText(QuestConditionInfo.sParam6, '清理') = 0;
  boNoCompareHumanName := CompareText(QuestConditionInfo.sParam6, '1') = 0;
  cMethod := QuestConditionInfo.sParam2[1];
  if nDayCount < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKNAMEDATELIST);
    Exit;
  end;
  sListFileName := g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1;
  if FileExists(sListFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
      if (CompareText(sHumName, PlayObject.m_sCharName) = 0) or boNoCompareHumanName then begin
        nDay := High(Integer);
        if TryStrToDateTime(sDate, dOldDate) then
          nDay := GetDayCount(Now, dOldDate);

        case cMethod of
          '=': if nDay = nDayCount then Result := True;
          '>': if nDay > nDayCount then Result := True;
          '<': if nDay < nDayCount then Result := True;
        else if nDay >= nDayCount then Result := True;
        end;

        VarInfo := GetVarValue(PlayObject, QuestConditionInfo.sParam4, sVar, sValue, nValue);
        case VarInfo.VarAttr of
          aNone, aConst: begin
              ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKNAMEDATELIST);
              break;
            end;
          aFixStr: SetValNameValue(PlayObject, sVar, sValue, nDay);
          aDynamic: SetDynamicValue(PlayObject, sVar, sValue, nDay);
        end;

        VarInfo := GetVarValue(PlayObject, QuestConditionInfo.sParam5, sVar, sValue, nValue);
        case VarInfo.VarAttr of
          aNone, aConst: begin
              ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKNAMEDATELIST);
              break;
            end;
          aFixStr: SetValNameValue(PlayObject, sVar, sValue, nDayCount - nDay);
          aDynamic: SetDynamicValue(PlayObject, sVar, sValue, nDayCount - nDay);
        end;

        if not Result then begin
          if boDeleteExprie then begin
            LoadList.Delete(I);
            try
              LoadList.SaveToFile(sListFileName);
            except
              MainOutMessage('Save fail.... => ' + sListFileName);
            end;
          end;
        end;
        Break;
      end;
    end;
    LoadList.Free;
  end else begin
    MainOutMessage('file not found => ' + sListFileName);
  end;
end;

function TNormNpc.ConditionOfCheckGuildNameDateList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sListFileName, sLineText, sHumName, sDate: string;
  boDeleteExprie, boNoCompareHumanName: Boolean;
  dOldDate: TDateTime;
  cMethod: Char;
  nValNo, nValNoDay, nDayCount, nDay: Integer;

  sVar, sValue: string;
  nValue: Integer;
  VarInfo: TVarInfo;
begin
  Result := False;
  if PlayObject.m_MyGuild <> nil then begin
    nDayCount := Str_ToInt(QuestConditionInfo.sParam3, -1);
    boDeleteExprie := CompareText(QuestConditionInfo.sParam6, '清理') = 0;
    boNoCompareHumanName := CompareText(QuestConditionInfo.sParam6, '1') = 0;
    cMethod := QuestConditionInfo.sParam2[1];
    if nDayCount < 0 then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGUILDNAMEDATELIST);
      Exit;
    end;
    sListFileName := g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1;
    if FileExists(sListFileName) then begin
      LoadList := TStringList.Create;
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
      for I := 0 to LoadList.Count - 1 do begin
        sLineText := Trim(LoadList.Strings[I]);
        sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
        if (CompareText(sHumName, TGUild(PlayObject.m_MyGuild).sGuildName) = 0) or boNoCompareHumanName then begin
          nDay := High(Integer);
          if TryStrToDateTime(sDate, dOldDate) then
            nDay := GetDayCount(Now, dOldDate);
          case cMethod of
            '=': if nDay = nDayCount then Result := True;
            '>': if nDay > nDayCount then Result := True;
            '<': if nDay < nDayCount then Result := True;
          else if nDay >= nDayCount then Result := True;
          end;
          if QuestConditionInfo.sParam4 <> '' then begin
            VarInfo := GetVarValue(PlayObject, QuestConditionInfo.sParam4, sVar, sValue, nValue);
            case VarInfo.VarAttr of
              aNone, aConst: begin
                  ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGUILDNAMEDATELIST);
                  break;
                end;
              aFixStr: SetValNameValue(PlayObject, sVar, sValue, nDay);
              aDynamic: SetDynamicValue(PlayObject, sVar, sValue, nDay);
            end;
          end;
          if QuestConditionInfo.sParam5 <> '' then begin
            VarInfo := GetVarValue(PlayObject, QuestConditionInfo.sParam5, sVar, sValue, nValue);
            case VarInfo.VarAttr of
              aNone, aConst: begin
                  ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGUILDNAMEDATELIST);
                  break;
                end;
              aFixStr: SetValNameValue(PlayObject, sVar, sValue, nDayCount - nDay);
              aDynamic: SetDynamicValue(PlayObject, sVar, sValue, nDayCount - nDay);
            end;
          end;

          if not Result then begin
            if boDeleteExprie then begin
              LoadList.Delete(I);
              try
                LoadList.SaveToFile(sListFileName);
              except
                MainOutMessage('Save fail.... => ' + sListFileName);
              end;
            end;
          end;
          Break;
        end;
      end;
      LoadList.Free;
    end else begin
      MainOutMessage('file not found => ' + sListFileName);
    end;
  end;
end;
//CHECKMAPHUMANCOUNT MAP = COUNT

function TNormNpc.ConditionOfCheckMapHumanCount(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount, nHumanCount: Integer;
  cMethod: Char;
  sMapName: string;
  Envir: TEnvirnoment;
begin
  Result := False;
  nCount := Str_ToInt(QuestConditionInfo.sParam3, -1);

  if nCount < 0 then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam3, nCount);
      if nCount < 0 then begin
        ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKMAPHUMANCOUNT);
        Exit;
      end;
    end else begin
      ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKMAPHUMANCOUNT);
      Exit;
    end;
  end;

  sMapName := QuestConditionInfo.sParam1;
  Envir := g_MapManager.FindMap(sMapName);

  if (Envir = nil) then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam1, sMapName);
      Envir := g_MapManager.FindMap(sMapName);
    end;
  end;

  if (Envir = nil) then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKMAPHUMANCOUNT);
    Exit;
  end;

  nHumanCount := UserEngine.GetMapHuman(Envir);
  cMethod := QuestConditionInfo.sParam2[1];
  case cMethod of
    '=': if nHumanCount = nCount then Result := True;
    '>': if nHumanCount > nCount then Result := True;
    '<': if nHumanCount < nCount then Result := True;
  else if nHumanCount >= nCount then Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckMapMonCount(BaseObject: TActorObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount, nMonCount: Integer;
  cMethod: Char;
  sMapName: string;
  Envir: TEnvirnoment;
begin
  Result := False;
  nCount := Str_ToInt(QuestConditionInfo.sParam3, -1);
  sMapName := QuestConditionInfo.sParam1;
  Envir := g_MapManager.FindMap(sMapName);
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    if nCount < 0 then
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam3, nCount);
    if (Envir = nil) then begin
      GetVarValue(TPlayObject(BaseObject), QuestConditionInfo.sParam1, sMapName);
      Envir := g_MapManager.FindMap(sMapName);
    end;
  end;
  if (nCount < 0) or (Envir = nil) then begin
    ScriptConditionError(BaseObject, QuestConditionInfo, sSC_CHECKMAPMONCOUNT);
    Exit;
  end;
  nMonCount := UserEngine.GetMapMonster(Envir, nil);
  cMethod := QuestConditionInfo.sParam2[1];
  case cMethod of
    '=': if nMonCount = nCount then Result := True;
    '>': if nMonCount > nCount then Result := True;
    '<': if nMonCount < nCount then Result := True;
  else if nMonCount >= nCount then Result := True;
  end;
end;

function TNormNpc.GetDynamicVarList(PlayObject: TPlayObject;
  sType: string; var sName: string): TList;
begin
  Result := nil;
  if CompareLStr(sType, 'HUMAN', Length('HUMAN')) then begin
    Result := PlayObject.m_DynamicVarList;
    sName := PlayObject.m_sCharName;
  end else
    if CompareLStr(sType, 'GUILD', Length('GUILD')) then begin
    if PlayObject.m_MyGuild = nil then Exit;
    Result := TGUild(PlayObject.m_MyGuild).m_DynamicVarList;
    sName := TGUild(PlayObject.m_MyGuild).sGuildName;
  end else
    if CompareLStr(sType, 'GLOBAL', Length('GLOBAL')) then begin
    Result := g_DynamicVarList;
    sName := 'GLOBAL';
  end;
end;

{ TGuildOfficial }

procedure TGuildOfficial.Click(PlayObject: TPlayObject; sLabel: string);
begin
  //  GotoLable(PlayObject,'@main');
  inherited;
end;

procedure TGuildOfficial.GetVariableText(PlayObject: TPlayObject;
  var sMsg: string; sVariable: string);
var
  I, II: Integer;
  sText: string;
  List: TStringList;
  sStr: string;
begin
  inherited;
  if sVariable = '$REQUESTCASTLELIST' then begin
    sText := '';
    List := TStringList.Create;
    g_CastleManager.GetCastleNameList(List);
    for I := 0 to List.Count - 1 do begin
      II := I + 1;
      if ((II div 2) * 2 = II) then sStr := '\'
      else sStr := '';
      sText := sText + Format('<%s/@requestcastlewarnow%d> %s', [List.Strings[I], I, sStr]);
    end;
    sText := sText + '\ \';
    List.Free;
    sMsg := sub_49ADB8(sMsg, '<$REQUESTCASTLELIST>', sText);
  end;
end;

procedure TGuildOfficial.Run;
begin
  if Random(40) = 0 then begin
    TurnTo(Random(8));
  end else begin
    if Random(30) = 0 then
      SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  end;
  inherited;
end;

procedure TGuildOfficial.UserSelect(PlayObject: TPlayObject; sData: string);
var
  sMsg, sLabel: string;
  boCanJmp: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TGuildOfficial::UserSelect... ';
begin
  inherited;
  try
    //    PlayObject.m_nScriptGotoCount:=0;
    if (sData <> '') and (sData[1] = '@') then begin
      sMsg := GetValidStr3(sData, sLabel, [#13]);

      boCanJmp := PlayObject.LableIsCanJmp(sLabel);

      GotoLable(PlayObject, sLabel, not boCanJmp);

      //GotoLable(PlayObject,sLabel,not PlayObject.LableIsCanJmp(sLabel));
      if not boCanJmp then Exit;
      if CompareText(sLabel, sBUILDGUILDNOW) = 0 then begin
        ReQuestBuildGuild(PlayObject, sMsg);
      end else
        if CompareText(sLabel, sSCL_GUILDWAR) = 0 then begin
        ReQuestGuildWar(PlayObject, sMsg);
      end else
        if CompareText(sLabel, sDONATE) = 0 then begin
        DoNate(PlayObject);
      end else
        {
        if CompareText(sLabel,sREQUESTCASTLEWAR) = 0 then begin
          ReQuestCastleWar(PlayObject,sMsg);
        end else
        }
        if CompareLStr(sLabel, sREQUESTCASTLEWAR, Length(sREQUESTCASTLEWAR)) then begin
        ReQuestCastleWar(PlayObject, Copy(sLabel, Length(sREQUESTCASTLEWAR) + 1, Length(sLabel) - Length(sREQUESTCASTLEWAR)));
      end else
        if CompareText(sLabel, sEXIT) = 0 then begin
        PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self), 0, 0, '');
      end else
        if CompareText(sLabel, sBACK) = 0 then begin
        if PlayObject.m_sScriptGoBackLable = '' then PlayObject.m_sScriptGoBackLable := sMAIN;
        GotoLable(PlayObject, PlayObject.m_sScriptGoBackLable, False);
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
  //  inherited;
end;

function TGuildOfficial.ReQuestBuildGuild(PlayObject: TPlayObject; sGuildName: string): Integer;
var
  UserItem: pTUserItem;
  sKey: string;
begin
  Result := 0;
  sGuildName := Trim(sGuildName);
  UserItem := nil;
  if sGuildName = '' then begin
    Result := -4;
  end;
  if PlayObject.m_MyGuild = nil then begin
    if PlayObject.m_nGold >= g_Config.nBuildGuildPrice then begin
      UserItem := PlayObject.CheckItems(g_Config.sWomaHorn);
      if UserItem = nil then begin
        Result := -3; //'你没有准备好需要的全部物品。'
      end;
    end else Result := -2; //'缺少创建费用。'
  end else Result := -1; //'您已经加入其它行会。'
  if Result = 0 then begin
    if g_GuildManager.AddGuild(sGuildName, PlayObject.m_sCharName) then begin
      //UserEngine.SendServerGroupMsg(SS_205, nServerIndex, sGuildName + '/' + PlayObject.m_sCharName);
      PlayObject.SendDelItems(UserItem);
      PlayObject.DelBagItem(UserItem.MakeIndex, g_Config.sWomaHorn);
      PlayObject.DecGold(g_Config.nBuildGuildPrice);
      PlayObject.GoldChanged();
      PlayObject.m_MyGuild := g_GuildManager.MemberOfGuild(PlayObject.m_sCharName);
      if PlayObject.m_MyGuild <> nil then begin
        PlayObject.m_sGuildRankName := TGUild(PlayObject.m_MyGuild).GetRankName(PlayObject, PlayObject.m_nGuildRankNo);
        RefShowName();
      end;
    end else Result := -4;
  end;
  if Result >= 0 then begin
    PlayObject.SendMsg(Self, RM_BUILDGUILD_OK, 0, 0, 0, 0, '');
  end else begin
    PlayObject.SendMsg(Self, RM_BUILDGUILD_FAIL, 0, Result, 0, 0, '');
  end;
end;

function TGuildOfficial.ReQuestGuildWar(PlayObject: TPlayObject; sGuildName: string): Integer;
begin
  if g_GuildManager.FindGuild(sGuildName) <> nil then begin
    if PlayObject.m_nGold >= g_Config.nGuildWarPrice then begin
      PlayObject.DecGold(g_Config.nGuildWarPrice);
      PlayObject.GoldChanged();
      PlayObject.ReQuestGuildWar(sGuildName);
    end else begin
      PlayObject.SysMsg('You do not have enough Gold.', c_Red, t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('The Guild ' + sGuildName + '  does not exist.', c_Red, t_Hint);
  end;
  Result := 1;
end;

procedure TGuildOfficial.DoNate(PlayObject: TPlayObject);
begin
  PlayObject.SendMsg(Self, RM_DONATE_OK, 0, 0, 0, 0, '');
end;

procedure TGuildOfficial.ReQuestCastleWar(PlayObject: TPlayObject; sIndex: string);
var
  UserItem: pTUserItem;
  Castle: TUserCastle;
  nIndex: Integer;
begin
  //  if PlayObject.IsGuildMaster and
  //     (not UserCastle.IsMasterGuild(TGuild(PlayObject.m_MyGuild))) then begin
  nIndex := Str_ToInt(sIndex, -1);
  if nIndex < 0 then nIndex := 0;

  Castle := g_CastleManager.GetCastle(nIndex);
  if PlayObject.IsGuildMaster and
    not Castle.IsMember(PlayObject) then begin

    UserItem := PlayObject.CheckItems(g_Config.sZumaPiece);
    if UserItem <> nil then begin
      if Castle.AddAttackerInfo(TGUild(PlayObject.m_MyGuild)) then begin
        PlayObject.SendDelItems(UserItem);
        PlayObject.DelBagItem(UserItem.MakeIndex, g_Config.sZumaPiece);
        GotoLable(PlayObject, '~@request_ok', False);
      end else begin
        PlayObject.SysMsg('Unable to request War.', c_Red, t_Hint);
      end;
      (*{$IFEND}*)

    end else begin
      PlayObject.SysMsg('You need one ' + g_Config.sZumaPiece + '!', c_Red, t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('Your request has been canceled', c_Red, t_Hint);
  end;
end;

procedure TCastleOfficial.RepairDoor(PlayObject: TPlayObject);
begin
  if m_Castle = nil then begin
    PlayObject.SysMsg('NPC not part of a Castle.', c_Red, t_Hint);
    Exit;
  end;
  if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nRepairDoorPrice then begin
    if TUserCastle(m_Castle).RepairDoor then begin
      Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nRepairDoorPrice);
      PlayObject.SysMsg('Repair successful', c_Green, t_Hint);
    end else begin
      PlayObject.SysMsg('Gates need repairing', c_Green, t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('Insufficient funds', c_Red, t_Hint);
  end;
  {
  if UserCastle.m_nTotalGold >= g_Config.nRepairDoorPrice then begin
    if UserCastle.RepairDoor then begin
      Dec(UserCastle.m_nTotalGold,g_Config.nRepairDoorPrice);
      PlayObject.SysMsg('修理成功。',c_Green,t_Hint);
    end else begin
      PlayObject.SysMsg('城门不需要修理！！！',c_Green,t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('城内资金不足！！！',c_Red,t_Hint);
  end;
  }
end;

procedure TCastleOfficial.RepairWallNow(nWallIndex: Integer;
  PlayObject: TPlayObject);
begin
  if m_Castle = nil then begin
    PlayObject.SysMsg('NPC is not part of a Castle', c_Red, t_Hint);
    Exit;
  end;

  if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nRepairWallPrice then begin
    if TUserCastle(m_Castle).RepairWall(nWallIndex) then begin
      Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nRepairWallPrice);
      PlayObject.SysMsg('Repair successful', c_Green, t_Hint);
    end else begin
      PlayObject.SysMsg('Walls need repairing', c_Green, t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('Insufficient funds', c_Red, t_Hint);
  end;
  {
  if UserCastle.m_nTotalGold >= g_Config.nRepairWallPrice then begin
    if UserCastle.RepairWall(nWallIndex) then begin
      Dec(UserCastle.m_nTotalGold,g_Config.nRepairWallPrice);
      PlayObject.SysMsg('修理成功。',c_Green,t_Hint);
    end else begin
      PlayObject.SysMsg('城门不需要修理！！！',c_Green,t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('城内资金不足！！！',c_Red,t_Hint);
  end;
  }
end;

constructor TCastleOfficial.Create;
begin
  inherited;

end;

destructor TCastleOfficial.Destroy;
begin

  inherited;
end;

constructor TGuildOfficial.Create;
begin
  inherited;
  m_btRaceImg := RCC_MERCHANT;
  m_wAppr := 8;
end;

destructor TGuildOfficial.Destroy;
begin

  inherited;
end;

procedure TGuildOfficial.SendCustemMsg(PlayObject: TPlayObject;
  sMsg: string);
begin
  inherited;

end;

procedure TCastleOfficial.SendCustemMsg(PlayObject: TPlayObject;
  sMsg: string);
begin
  if not g_Config.boSubkMasterSendMsg then begin
    PlayObject.SysMsg(g_sSubkMasterMsgCanNotUseNowMsg, c_Red, t_Hint);
    Exit;
  end;
  if PlayObject.m_boSendMsgFlag then begin
    PlayObject.m_boSendMsgFlag := False;
    UserEngine.SendBroadCastMsg(PlayObject.GetUnknowCharName + ': ' + sMsg, t_Castle); //神秘人
  end else begin

  end;
end;

end.

