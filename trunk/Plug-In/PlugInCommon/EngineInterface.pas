unit EngineInterface;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, StdCtrls, Forms;
const
  HEROVERSION = 1; //编译开关 0=企业版 1=英雄版

  MAXPATHLEN = 255;
  DIRPATHLEN = 80;
  MAPNAMELEN = 16;
  ACTORNAMELEN = 14;
  DEFBLOCKSIZE = 16;
  BUFFERSIZE = 10000;
  DATA_BUFSIZE2 = 16348; //8192;
  DATA_BUFSIZE = 8192; //8192;
  GROUPMAX = 11;


  sGameLogMsg = '%d'#9'%s'#9'%d'#9'%d'#9'%s'#9'%s'#9'%d'#9'%s'#9'%s';
  GAMELOGNUMBERBASE = 100;
  GAMELOGBUYITEM = GAMELOGNUMBERBASE + 1;
  LOG_GAMEGOLD = 111;
  LOG_GAMEPOINT = 112;
  LOG_BUYSHOPITEM = 30;

  U_DRESS = 0;
  U_WEAPON = 1;
  U_RIGHTHAND = 2;
  U_NECKLACE = 3;
  U_HELMET = 4;
  U_ARMRINGL = 5;
  U_ARMRINGR = 6;
  U_RINGL = 7;
  U_RINGR = 8;
  U_BUJUK = 9;
  U_BELT = 10; //腰带
  U_BOOTS = 11; //鞋
  U_CHARM = 12;

  RC_PLAYOBJECT = 0;
  RC_HEROOBJECT = 66; //英雄
  RC_PLAYMOSTER = 150; //人形怪物

  RC_GUARD = 11; //大刀守卫
  RC_PEACENPC = 15;
  RC_ANIMAL = 50;
  RC_MONSTER = 80;
  RC_NPC = 10;
  RC_ARCHERGUARD = 112;

  CM_QUERYBAGITEMS = 81;
  SM_HORSERUN = 5;
  SM_WALK = 11;
  SM_RUN = 13;
  SM_ALIVE = 27;
  SM_DEATH = 32;
  SM_SKELETON = 33;
  SM_NOWDEATH = 34;
  SM_LEVELUP = 45;
  SM_ABILITY = 52;
  SM_BAGITEMS = 201;
  SM_SENDMYMAGIC = 211;
  SM_SENDUSERSTATE = 751;
  SM_SUBABILITY = 752;
  SM_SPACEMOVE_SHOW = 801;
  SM_SPACEMOVE_SHOW2 = 807;
  SM_CHANGEFACE = 1104;
  CM_USERBASE = 8000;
  SM_USERBASE = 9000;
  RM_USERBASE = 61000;
  RM_ABILITY = 10051;
  RM_HEALTHSPELLCHANGED = 10052;
  RM_DURACHANGE = 10125;
type
  TObjType = (t_None, t_Actor, t_Item, t_Event, t_Gate, t_Switch, t_MapEvent, t_Door, t_Roon, t_MapMagicEvent);
  TMsgColor = (c_Red, c_Green, c_Blue, c_White);
  TMsgType = (t_Notice, t_Hint, t_System, t_Say, t_Mon, t_GM, t_Cust, t_Castle);

  TBaseObject = TObject;
  pTBaseObject = ^TBaseObject;
  
  TActorObject = TObject;
  pTActorObject = ^TActorObject;
  TGUild = TObject;
  TEnvirnoment = TObject;
  pTEnvirnoment = ^TEnvirnoment;
  TPlayObject = TObject;
  pTPlayObject = ^TPlayObject;
  TNormNpc = TObject;
  pTNormNpc = ^TNormNpc;
  TUserEngine = TObject;
  TMerchant = TObject;
  pTMerchant = ^TMerchant;
  THeroObject = TObject;


  TMsgProc = procedure(Msg: PChar; nMsgLen: Integer; nMode: Integer); stdcall;
  TIPLocal = procedure(sIPaddr: PChar; sLocal: PChar; nLocalLen: Integer); stdcall;
  TDeCryptString = procedure(Src, Dest: PChar; nSrc: Integer); stdcall;
  TChangeCaptionText = procedure(Msg: PChar; nLen: Integer); stdcall;
  TChangeGateSocket = procedure(boOpenGateSocket: Boolean); stdcall;

  TShortString = packed record
    btLen: Byte;
    Strings: array[0..High(Byte) - 1] of Char;
  end;
  PTShortString = ^TShortString;

  _TBANKPWD = string[6];
  _LPTBANKPWD = ^_TBANKPWD;
  _TMAPNAME = string[MAPNAMELEN];
  _LPTMAPNAME = ^_TMAPNAME;
  _TACTORNAME = string[ACTORNAMELEN];
  _LPTACTORNAME = ^_TACTORNAME;
  _TPATHNAME = string[MAXPATHLEN];
  _LPTPATHNAME = ^_TPATHNAME;
  _TDIRNAME = string[DIRPATHLEN];
  _LPTDIRNAME = ^_TDIRNAME;

  TDefaultMessage = record
    Recog: Integer;
    Ident: Word;
    Param: Word;
    Tag: Word;
    Series: Word;
  end;
  pTDefaultMessage = ^TDefaultMessage;

  TValue = array[0..13] of Byte;
  TValueA = array[0..1] of Byte;
  TStdItem = packed record
{$IF HEROVERSION = 1}
    Name: string[30];
{$ELSE}
    Name: string[14];
{$IFEND}
    StdMode: Byte;
    Shape: Byte;
    Weight: Byte;
    AniCount: Byte;
    Source: ShortInt;
    Reserved: Byte;
    NeedIdentify: Byte;
    Looks: Word;
    DuraMax: Word;
    Reserved1: Word;
    AC: Integer;
    MAC: Integer;
    DC: Integer;
    MC: Integer;
    SC: Integer;
    Need: Integer;
    NeedLevel: Integer;
    Price: Integer;
{$IF HEROVERSION = 1}
    AddValue: TValue;
    AddPoint: TValue;
    MaxDate: TDateTime;
{$IFEND}
  end;
  pTStdItem = ^TStdItem;

  TOStdItem = packed record //OK
    Name: string[14];
    StdMode: Byte;
    Shape: Byte;
    Weight: Byte;
    AniCount: Byte;
    Source: ShortInt;
    Reserved: Byte;
    NeedIdentify: Byte;
    Looks: Word;
    DuraMax: Word;
    AC: Word;
    MAC: Word;
    DC: Word;
    MC: Word;
    SC: Word;
    Need: Byte;
    NeedLevel: Byte;
    w26: Word;
    Price: Integer;
  end;
  pTOStdItem = ^TOStdItem;

  TOClientItem = record //OK
    s: TOStdItem;
    MakeIndex: Integer;
    Dura: Word;
    DuraMax: Word;
  end;
  pTOClientItem = ^TOClientItem;

  TClientItem = record //OK
    s: TStdItem;
    MakeIndex: Integer;
    Dura: Word;
    DuraMax: Word;
  end;
  PTClientItem = ^TClientItem;

  TMagic = record
    wMagicId: Word;
    sMagicName: string[12];
    btEffectType: Byte;
    btEffect: Byte;
    bt11: Byte;
    wSpell: Word;
    wPower: Word;
    TrainLevel: array[0..3] of Byte;
    w02: Word;
    MaxTrain: array[0..3] of Integer;
    btTrainLv: Byte;
    btJob: Byte;
    wMagicIdx: Word;
    dwDelayTime: LongWord;
    btDefSpell: Byte;
    btDefPower: Byte;
    wMaxPower: Word;
    btDefMaxPower: Byte;
    sDescr: string[18];
  end;
  pTMagic = ^TMagic;

  TClientMagic = record //84
    Key: Char;
    Level: Byte;
    CurTrain: Integer;
    Def: TMagic;
  end;
  PTClientMagic = ^TClientMagic;

  TUserMagic = record
    MagicInfo: pTMagic;
    wMagIdx: Word;
    btLevel: Byte;
    btKey: Byte;
    nTranPoint: Integer;
  end;
  pTUserMagic = ^TUserMagic;

  TNakedAbility = packed record //Size 20
    DC: Word;
    MC: Word;
    SC: Word;
    AC: Word;
    MAC: Word;
    HP: Word;
    MP: Word;
    Hit: Word;
    Speed: Word;
    X2: Word;
  end;
  pTNakedAbility = ^TNakedAbility;

  TAbility = packed record //OK    //Size 40
{$IF HEROVERSION = 1}
    Level: LongInt; //0x198  //0x34  0x00
{$ELSE}
    Level: Word; //0x198  //0x34  0x00
{$IFEND}
    AC: Integer; //0x19A  //0x36  0x02
    MAC: Integer; //0x19C  //0x38  0x04
    DC: Integer; //0x19E  //0x3A  0x06
    MC: Integer; //0x1A0  //0x3C  0x08
    SC: Integer; //0x1A2  //0x3E  0x0A
{$IF HEROVERSION = 1}
    HP: LongInt; //0x1A4  //0x40  0x0C
    MP: LongInt; //0x1A6  //0x42  0x0E
    MaxHP: LongInt; //0x1A8  //0x44  0x10
    MaxMP: LongInt; //0x1AA  //0x46  0x12
{$ELSE}
    HP: Word; //0x1A4  //0x40  0x0C
    MP: Word; //0x1A6  //0x42  0x0E
    MaxHP: Word; //0x1A8  //0x44  0x10
    MaxMP: Word; //0x1AA  //0x46  0x12
{$IFEND}
    Exp: LongWord; //0x1B0  //0x4C 0x18
    MaxExp: LongWord; //0x1B4  //0x50 0x1C
    Weight: Word; //0x1B8   //0x54 0x20
    MaxWeight: Word; //0x1BA   //0x56 0x22  背包
    WearWeight: Word; //0x1BC   //0x58 0x24
    MaxWearWeight: Word; //0x1BD   //0x59 0x25  负重
    HandWeight: Word; //0x1BE   //0x5A 0x26
    MaxHandWeight: Word; //0x1BF   //0x5B 0x27  腕力
    ATOM_DC: array[1..7] of Word;
    ATOM_MC: array[1..7] of Word;
    ATOM_MAC: array[1..7] of Word;
    MoveSpeed: Byte;
    AttackSpeed: Byte;
    AddPoint: array[0..13] of Byte;
  end;
  pTAbility = ^TAbility;

  TOAbility = packed record
    Level: Word;
    AC: Word;
    MAC: Word;
    DC: Word;
    MC: Word;
    SC: Word;
    HP: Word;
    MP: Word;
    MaxHP: Word;
    MaxMP: Word;
    btReserved1: Byte;
    btReserved2: Byte;
    btReserved3: Byte;
    btReserved4: Byte;
    Exp: LongWord;
    MaxExp: LongWord;
    Weight: Word;
    MaxWeight: Word; //背包
    WearWeight: Byte;
    MaxWearWeight: Byte; //负重
    HandWeight: Byte;
    MaxHandWeight: Byte; //腕力
  end;
  pTOAbility = ^TOAbility;

  TUserItem = packed record
    MakeIndex: Integer;
    wIndex: Word; //物品id
    Dura: Word; //当前持久值
    DuraMax: Word; //最大持久值
    btValue: TValue; //array[0..13] of Byte;
{$IF HEROVERSION = 1}
    AddValue: TValue;
    AddPoint: TValue;
    btValue2: TValue;
    MaxDate: TDateTime;
{$IFEND}
  end;
  pTUserItem = ^TUserItem;

  TOUserStateInfo = packed record //OK
    feature: Integer;
    UserName: string[15]; // 15
    GuildName: string[14]; //14
    GuildRankName: string[16]; //15
    NAMECOLOR: Word;
    UseItems: array[0..8] of TOClientItem;
  end;

  TUserStateInfo = record
    feature: Integer;
    UserName: string[ACTORNAMELEN];
    NAMECOLOR: Integer;
    GuildName: string[ACTORNAMELEN];
    GuildRankName: string[16];
    UseItems: array[0..12] of TClientItem;
  end;
  pTUserStateInfo = ^TUserStateInfo;

  THumMagic = record
    wMagIdx: Word;
    btLevel: Byte;
    btKey: Byte;
    nTranPoint: Integer; //当前持久值
  end;
  pTHumMagic = ^THumMagic;

  //TStatusTime = array[0..MAX_STATUS_ATTRIBUTE - 1] of Word;

  THumItems = array[0..8] of TUserItem;
  THumAddItems = array[9..12] of TUserItem;
  TBagItems = array[0..45] of TUserItem;
  TStorageItems = array[0..45] of TUserItem;
  THumMagics = array[0..29] of THumMagic;
  THumanUseItems = array[0..12] of TUserItem;
  THeroItems = array[0..12] of TUserItem;
  THeroBagItems = array[0..40 - 1] of TUserItem;
  pTHumanUseItems = ^THumanUseItems;

  pTHeroItems = ^THeroItems;
  pTHumItems = ^THumItems;
  pTBagItems = ^TBagItems;
  pTStorageItems = ^TStorageItems;
  pTHumAddItems = ^THumAddItems;
  pTHumMagics = ^THumMagics;
  pTHeroBagItems = ^THeroBagItems;

  TObjectAction = procedure(PlayObject: TObject); stdcall;
  TObjectActionEx = function(PlayObject: TObject): BOOL; stdcall;
  TObjectActionXY = procedure(AObject, BObject: TObject; nX, nY: Integer); stdcall;
  TObjectActionXYD = procedure(AObject, BObject: TObject; nX, nY: Integer; btDir: Byte); stdcall;
  TObjectActionXYDM = procedure(AObject, BObject: TObject; nX, nY: Integer; btDir: Byte; nMode: Integer); stdcall;
  TObjectActionXYDWS = procedure(AObject, BObject: TObject; wIdent: Word; nX, nY: Integer; btDir: Byte; pszMsg: PChar); stdcall;
  TObjectActionObject = procedure(AObject, BObject, CObject: TObject; nInt: Integer); stdcall;
  TObjectActionDetailGoods = procedure(Merchant: TObject; PlayObject: TObject; pszItemName: PChar; nInt: Integer); stdcall;
  TObjectActionUserSelect = procedure(Merchant: TObject; PlayObject: TObject; pszLabel, pszData: PChar); stdcall;
  TObjectUserCmd = function(AObject: TObject; pszCmd, pszParam1, pszParam2, pszParam3, pszParam4, pszParam5, pszParam6, pszParam7: PChar): Boolean; stdcall;
  TPlaySendSocket = function(AObject: TObject; DefMsg: pTDefaultMessage; pszMsg: PChar): Boolean; stdcall;
  TObjectActionItem = function(AObject: TObject; pszItemName: PChar; boHintMsg: Boolean): Boolean; stdcall;
  TObjectClientMsg = function(PlayObject: TObject; DefMsg: pTDefaultMessage; Buff: PChar; NewBuff: PChar): Integer; stdcall;
  TObjectActionFeature = function(AObject, BObject: TObject): Integer; stdcall;
  TObjectActionSendGoods = procedure(AObject: TObject; nNpcRecog, nCount, nPostion: Integer; pszData: PChar); stdcall;
  TObjectActionCheckUserItem = function(nIdx: Integer; StdItem: pTStdItem): Boolean; stdcall;
  TObjectActionEnterMap = function(AObject: TObject; Envir: TObject; nX, nY: Integer): Boolean; stdcall;
  TObjectFilterMsg = function(PlayObject: TObject; pszSrcMsg, pszDestMsg: PChar; var boGotoLabel: Boolean): Boolean; stdcall;
  TEDCode = procedure(pszSource: PChar; pszDest: PChar; nSrcLen, nDestLen: Integer); stdcall;
  TDoSpell = function(MagicManager: TObject; PlayObject: TObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TObject; var boSpellFail, boSpellFire: Boolean): Boolean; stdcall;

  TScriptCmd = function(pszCmd: PChar): Integer; stdcall;
  TSetMaxPlayObjectCount = procedure(Buffer: PChar; nLen: Integer); stdcall;
  TGetMaxPlayObjectCount = function(): Integer; stdcall;
  TStartProc = procedure(); stdcall;

  TScriptAction = procedure(NPC: TObject;
    PlayObject: TObject;
    nCMDCode: Integer;
    pszParam1: PChar;
    nParam1: Integer;
    pszParam2: PChar;
    nParam2: Integer;
    pszParam3: PChar;
    nParam3: Integer;
    pszParam4: PChar;
    nParam4: Integer;
    pszParam5: PChar;
    nParam5: Integer;
    pszParam6: PChar;
    nParam6: Integer;
    pszParam7: PChar;
    nParam7: Integer;
    pszParam8: PChar;
    nParam8: Integer;
    pszParam9: PChar;
    nParam9: Integer;
    pszParam10: PChar;
    nParam10: Integer); stdcall;

  TScriptCondition = function(NPC: TObject;
    PlayObject: TObject;
    nCMDCode: Integer;
    pszParam1: PChar;
    nParam1: Integer;
    pszParam2: PChar;
    nParam2: Integer;
    pszParam3: PChar;
    nParam3: Integer;
    pszParam4: PChar;
    nParam4: Integer;
    pszParam5: PChar;
    nParam5: Integer;
    pszParam6: PChar;
    nParam6: Integer;
    pszParam7: PChar;
    nParam7: Integer;
    pszParam8: PChar;
    nParam8: Integer;
    pszParam9: PChar;
    nParam9: Integer;
    pszParam10: PChar;
    nParam10: Integer): Boolean; stdcall;

  TObjectOperateMessage = function(BaseObject: TObject;
    wIdent: Word;
    wParam: Word;
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
    MsgObject: TObject;
    dwDeliveryTime: LongWord;
    pszMsg: PChar; var boReturn: Boolean): Boolean; stdcall;

  TPlugOfEngine = class
  public
    procedure HookDeCodeString(Value: TDeCryptString); virtual; abstract;
    procedure HookChangeCaptionText(Value: TChangeCaptionText); virtual; abstract;
    procedure HookChangeGateSocket(Value: TChangeGateSocket); virtual; abstract;
    procedure HookIPLocal(Value: TIPLocal); virtual; abstract;
    procedure HookGetMaxPlayObjectCount(Value: TGetMaxPlayObjectCount); virtual; abstract;
    procedure HookSetMaxPlayObjectCount(Value: TSetMaxPlayObjectCount); virtual; abstract;

    procedure HookGetFeature(Value: TObjectActionFeature); virtual; abstract;
    procedure HookObjectEnterAnotherMap(Value: TObjectActionEnterMap); virtual; abstract;
    procedure HookObjectDie(Value: TObjectActionEx); virtual; abstract;
    procedure HookObjectOffLine(Value: TObjectAction); virtual; abstract;
    procedure HookChangeCurrMap(Value: TObjectActionEx); virtual; abstract;
    procedure HookClientQueryBagItems(Value: TObjectAction); virtual; abstract;
    procedure HookClientQueryUserState(Value: TObjectActionXY); virtual; abstract;
    procedure HookSendActionGood(Value: TObjectAction); virtual; abstract;
    procedure HookSendActionFail(Value: TObjectAction); virtual; abstract;
    procedure HookSendWalkMsg(Value: TObjectActionXYD); virtual; abstract;
    procedure HookSendHorseRunMsg(Value: TObjectActionXYD); virtual; abstract;
    procedure HookSendRunMsg(Value: TObjectActionXYD); virtual; abstract;
    procedure HookSendDeathMsg(Value: TObjectActionXYDM); virtual; abstract;
    procedure HookSendSkeletonMsg(Value: TObjectActionXYD); virtual; abstract;
    procedure HookSendAliveMsg(Value: TObjectActionXYD); virtual; abstract;
    procedure HookSendSpaceMoveMsg(Value: TObjectActionXYDWS); virtual; abstract;
    procedure HookSendChangeFaceMsg(Value: TObjectActionObject); virtual; abstract;
    procedure HookSendUseitemsMsg(Value: TObjectAction); virtual; abstract;
    procedure HookSendUseMagicMsg(Value: TObjectAction); virtual; abstract;
    procedure HookSendUserLevelUpMsg(Value: TObjectAction); virtual; abstract;
    procedure HookSendUserAbilieyMsg(Value: TObjectAction); virtual; abstract;
    procedure HookSendUserStruckMsg(Value: TObjectActionObject); virtual; abstract;
    procedure HookSendSocket(Value: TPlaySendSocket); virtual; abstract;
    procedure HookSendGoodsList(Value: TObjectActionSendGoods); virtual; abstract;
    procedure HookSendUserStatusMsg(Value: TObjectActionXYDWS); virtual; abstract;
    procedure HookCheckCanDropItem(Value: TObjectActionItem); virtual; abstract;
    procedure HookCheckCanDealItem(Value: TObjectActionItem); virtual; abstract;
    procedure HookCheckCanStorageItem(Value: TObjectActionItem); virtual; abstract;
    procedure HookCheckCanRepairItem(Value: TObjectActionItem); virtual; abstract;
    procedure HookCheckUserItems(Value: TObjectActionCheckUserItem); virtual; abstract;
    procedure HookPlayObjectRun(Value: TObjectAction); virtual; abstract;
    procedure HookPlayObjectFilterMsg(Value: TObjectFilterMsg); virtual; abstract;
    procedure HookMerchantClientGetDetailGoodsList(Value: TObjectActionDetailGoods); virtual; abstract;
    procedure HookUserEngineRun(Value: TObjectAction); virtual; abstract;
    procedure HookObjectClientMsg(Value: TObjectClientMsg); virtual; abstract;
    procedure HookSetHookDoSpell(Value: TDoSpell); virtual; abstract;
    procedure HookPlayObjectUserLogin1(Value: TObjectAction); virtual; abstract;
    procedure HookPlayObjectUserLogin2(Value: TObjectAction); virtual; abstract;
    procedure HookPlayObjectUserLogin3(Value: TObjectAction); virtual; abstract;
    procedure HookPlayObjectUserLogin4(Value: TObjectAction); virtual; abstract;
    procedure HookPlayObjectCreate(Value: TObjectAction); virtual; abstract;
    procedure HookPlayObjectDestroy(Value: TObjectAction); virtual; abstract;
    procedure HookPlayObjectUserCmd(Value: TObjectUserCmd); virtual; abstract;
    procedure HookObjectOperateMessage(Value: TObjectOperateMessage); virtual; abstract;
    procedure HookQuestActionScriptCmd(Value: TScriptCmd); virtual; abstract;
    procedure HookQuestConditionScriptCmd(Value: TScriptCmd); virtual; abstract;
    procedure HookActionScriptProcess(Value: TScriptAction); virtual; abstract;
    procedure HookConditionScriptProcess(Value: TScriptCondition); virtual; abstract;
    procedure HookPlayObjectUserSelect(Value: TObjectActionUserSelect); virtual; abstract;
    procedure HookCheckCanUpgradeItem(Value: TObjectActionItem); virtual; abstract;
    procedure HookCheckCanSellItem(Value: TObjectActionItem); virtual; abstract;
    procedure HookCheckNotCanScatterItem(Value: TObjectActionItem); virtual; abstract;
    procedure HookCheckCanDieScatterItem(Value: TObjectActionItem); virtual; abstract;

    procedure HookProcessHumans(Value: PChar; Len: Integer); virtual; abstract;


    procedure GetDeCodeString(Buffer: PChar; var Len: Integer); virtual; abstract;
    procedure GetChangeCaptionText(Buffer: PChar; var Len: Integer); virtual; abstract;
    procedure GetChangeGateSocket(Buffer: PChar; var Len: Integer); virtual; abstract;
    procedure GetIPLocal(Buffer: PChar; var Len: Integer); virtual; abstract;
    procedure GetGetMaxPlayObjectCount(Buffer: PChar; var Len: Integer); virtual; abstract;
    procedure GetSetMaxPlayObjectCount(Buffer: PChar; var Len: Integer); virtual; abstract;


    function GetGetFeature: TObjectActionFeature; virtual; abstract;
    function GetObjectEnterAnotherMap: TObjectActionEnterMap; virtual; abstract;
    function GetObjectDie: TObjectActionEx; virtual; abstract;
    function GetObjectOffLine: TObjectAction; virtual; abstract;
    function GetChangeCurrMap: TObjectActionEx; virtual; abstract;
    function GetClientQueryBagItems: TObjectAction; virtual; abstract;
    function GetClientQueryUserState: TObjectActionXY; virtual; abstract;
    function GetSendActionGood: TObjectAction; virtual; abstract;
    function GetSendActionFail: TObjectAction; virtual; abstract;
    function GetSendWalkMsg: TObjectActionXYD; virtual; abstract;
    function GetSendHorseRunMsg: TObjectActionXYD; virtual; abstract;
    function GetSendRunMsg: TObjectActionXYD; virtual; abstract;
    function GetSendDeathMsg: TObjectActionXYDM; virtual; abstract;
    function GetSendSkeletonMsg: TObjectActionXYD; virtual; abstract;
    function GetSendAliveMsg: TObjectActionXYD; virtual; abstract;
    function GetSendSpaceMoveMsg: TObjectActionXYDWS; virtual; abstract;
    function GetSendChangeFaceMsg: TObjectActionObject; virtual; abstract;
    function GetSendUseitemsMsg: TObjectAction; virtual; abstract;
    function GetSendUseMagicMsg: TObjectAction; virtual; abstract;
    function GetSendUserLevelUpMsg: TObjectAction; virtual; abstract;
    function GetSendUserAbilieyMsg: TObjectAction; virtual; abstract;
    function GetSendUserStruckMsg: TObjectActionObject; virtual; abstract;
    function GetSendSocket: TPlaySendSocket; virtual; abstract;
    function GetSendGoodsList: TObjectActionSendGoods; virtual; abstract;
    function GetSendUserStatusMsg: TObjectActionXYDWS; virtual; abstract;
    function GetCheckCanDropItem: TObjectActionItem; virtual; abstract;
    function GetCheckCanDealItem: TObjectActionItem; virtual; abstract;
    function GetCheckCanStorageItem: TObjectActionItem; virtual; abstract;
    function GetCheckCanRepairItem: TObjectActionItem; virtual; abstract;
    function GetCheckUserItems: TObjectActionCheckUserItem; virtual; abstract;
    function GetPlayObjectRun: TObjectAction; virtual; abstract;
    function GetPlayObjectFilterMsg: TObjectFilterMsg; virtual; abstract;
    function GetMerchantClientGetDetailGoodsList: TObjectActionDetailGoods; virtual; abstract;
    function GetUserEngineRun: TObjectAction; virtual; abstract;
    function GetObjectClientMsg: TObjectClientMsg; virtual; abstract;
    function GetSetHookDoSpell: TDoSpell; virtual; abstract;
    function GetPlayObjectUserLogin1: TObjectAction; virtual; abstract;
    function GetPlayObjectUserLogin2: TObjectAction; virtual; abstract;
    function GetPlayObjectUserLogin3: TObjectAction; virtual; abstract;
    function GetPlayObjectUserLogin4: TObjectAction; virtual; abstract;
    function GetPlayObjectCreate: TObjectAction; virtual; abstract;
    function GetPlayObjectDestroy: TObjectAction; virtual; abstract;
    function GetPlayObjectUserCmd: TObjectUserCmd; virtual; abstract;
    function GetObjectOperateMessage: TObjectOperateMessage; virtual; abstract;
    function GetQuestActionScriptCmd: TScriptCmd; virtual; abstract;
    function GetQuestConditionScriptCmd: TScriptCmd; virtual; abstract;
    function GetActionScriptProcess: TScriptAction; virtual; abstract;
    function GetConditionScriptProcess: TScriptCondition; virtual; abstract;
    function GetPlayObjectUserSelect: TObjectActionUserSelect; virtual; abstract;
    function GetCheckCanUpgradeItem: TObjectActionItem; virtual; abstract;
    function GetCheckCanSellItem: TObjectActionItem; virtual; abstract;
    function GetCheckNotCanScatterItem: TObjectActionItem; virtual; abstract;
    function GetCheckCanDieScatterItem: TObjectActionItem; virtual; abstract;
  end;

  _TList_Create = function: TList; stdcall;
  _TList_Free = procedure(List: TList); stdcall;
  _TList_Count = function(List: TList): Integer; stdcall;
  _TList_Add = function(List: TList; Item: Pointer): Integer; stdcall;
  _TList_Insert = procedure(List: TList; nIndex: Integer; Item: Pointer); stdcall;

  _TList_Get = function(List: TList; nIndex: Integer): Pointer; stdcall;
  _TList_Put = procedure(List: TList; nIndex: Integer; Item: Pointer); stdcall;
  _TList_Delete = procedure(List: TList; nIndex: Integer); stdcall;
  _TList_Clear = procedure(List: TList); stdcall;
  _TList_Exchange = procedure(List: TList; nIndex1, nIndex2: Integer); stdcall;

  _TStringList_Create = function: TStringList; stdcall;
  _TStringList_Free = procedure(List: TStringList); stdcall;
  _TStringList_Count = function(List: TStringList): Integer; stdcall;
  _TStringList_Add = function(List: TStringList; S: PChar): Integer; stdcall;
  _TStringList_AddObject = function(List: TStringList; S: PChar; AObject: TObject): Integer; stdcall;
  _TStringList_Insert = procedure(List: TStringList; nIndex: Integer; S: PChar); stdcall;
  _TStringList_Get = function(List: TStringList; nIndex: Integer): PChar; stdcall;
  _TStringList_GetObject = function(List: TStringList; nIndex: Integer): TObject; stdcall;
  _TStringList_Put = procedure(List: TStringList; nIndex: Integer; S: PChar); stdcall;
  _TStringList_PutObject = procedure(List: TStringList; nIndex: Integer; AObject: TObject); stdcall;
  _TStringList_Delete = procedure(List: TStringList; nIndex: Integer); stdcall;
  _TStringList_Clear = procedure(List: TStringList); stdcall;
  _TStringList_Exchange = procedure(List: TStringList; nIndex1, nIndex2: Integer); stdcall;
  _TStringList_LoadFormFile = procedure(List: TStringList; pszFileName: PChar); stdcall;
  _TStringList_SaveToFile = procedure(List: TStringList; pszFileName: PChar); stdcall;

  _TMainOutMessageAPI = procedure(pszMsg: PChar); stdcall;
  _TAddGameDataLogAPI = procedure(pszMsg: PChar); stdcall;
  _TGetGameGoldName = function: PTShortString; stdcall;
  _TEDcode_Decode6BitBuf = procedure(pszSource: PChar; pszDest: PChar; nSrcLen, nDestLen: Integer); stdcall;
  _TEDcode_Encode6BitBuf = procedure(pszSource: PChar; pszDest: PChar; nSrcLen, nDestLen: Integer); stdcall;
  _TEDcode_DeCodeString = procedure(pszSource: PChar; pszDest: PChar); stdcall;
  _TEDcode_EncodeString = procedure(pszSource: PChar; pszDest: PChar); stdcall;
  _TEDcode_EncodeBuffer = procedure(Buf: PChar; bufsize: Integer; pszDest: PChar); stdcall;
  _TEDcode_DecodeBuffer = procedure(pszSource: PChar; pszDest: PChar; bufsize: Integer); stdcall;

  _TConfig_sEnvirDir = function: _LPTDIRNAME; stdcall;
  _TConfig_AmyOunsulPoint = function: PInteger; stdcall;

  _TActorObject_Create = function: TActorObject; stdcall;
  _TActorObject_Free = procedure(BaseObject: TActorObject); stdcall;
  _TActorObject_sMapFileName = function(BaseObject: TActorObject): PTShortString; stdcall;
  _TActorObject_sMapName = function(BaseObject: TActorObject): PTShortString; stdcall;
  _TActorObject_sMapNameA = function(BaseObject: TActorObject): _LPTMAPNAME; stdcall;
  _TActorObject_sCharName = function(BaseObject: TActorObject): PTShortString; stdcall;
  _TActorObject_sCharNameA = function(BaseObject: TActorObject): _LPTACTORNAME; stdcall;

  _TActorObject_nCurrX = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_nCurrY = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_btDirection = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_btGender = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_btHair = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_btJob = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_nGold = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_Ability = function(BaseObject: TActorObject): pTAbility; stdcall;

  _TActorObject_WAbility = function(BaseObject: TActorObject): pTAbility; stdcall;
  _TActorObject_nCharStatus = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_sHomeMap = function(BaseObject: TActorObject): PTShortString; stdcall;
  _TActorObject_nHomeX = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_nHomeY = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_boOnHorse = function(BaseObject: TActorObject): PBoolean; stdcall;
  _TActorObject_btHorseType = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_btDressEffType = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_nPkPoint = function(BaseObject: TActorObject): PInteger; stdcall;

  _TActorObject_duBodyLuck = function(BaseObject: TActorObject): PDouble; stdcall;
  _TActorObject_nBodyLuckLevel = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_nFightZoneDieCount = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_nBonusPoint = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_nCharStatusEx = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_dwFightExp = function(BaseObject: TActorObject): PLongWord; stdcall;
  _TActorObject_nViewRange = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_wAppr = function(BaseObject: TActorObject): PWord; stdcall;
  _TActorObject_btRaceServer = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_btRaceImg = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_btHitPoint = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_nHitPlus = function(BaseObject: TActorObject): PShortInt; stdcall;
  _TActorObject_nHitDouble = function(BaseObject: TActorObject): PShortInt; stdcall;
  _TActorObject_boRecallSuite = function(BaseObject: TActorObject): PBoolean; stdcall;
  _TActorObject_nHealthRecover = function(BaseObject: TActorObject): PShortInt; stdcall;
  _TActorObject_nSpellRecover = function(BaseObject: TActorObject): PShortInt; stdcall;
  _TActorObject_btAntiPoison = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_nPoisonRecover = function(BaseObject: TActorObject): PShortInt; stdcall;
  _TActorObject_nAntiMagic = function(BaseObject: TActorObject): PShortInt; stdcall;
  _TActorObject_nLuck = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_nPerHealth = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_nPerHealing = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_nPerSpell = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_btGreenPoisoningPoint = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_nGoldMax = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_btSpeedPoint = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_btPermission = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_nHitSpeed = function(BaseObject: TActorObject): PShortInt; stdcall;
  _TActorObject_TargetCret = function(BaseObject: TActorObject): PTActorObject; stdcall;
  _TActorObject_LastHiter = function(BaseObject: TActorObject): PTActorObject; stdcall;
  _TActorObject_ExpHiter = function(BaseObject: TActorObject): PTActorObject; stdcall;

  _TActorObject_btLifeAttrib = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_nSlaveType = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_Master = function(BaseObject: TActorObject): PTActorObject; stdcall;
  _TActorObject_btAttatckMode = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_btNameColor = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_nLight = function(BaseObject: TActorObject): PInteger; stdcall;
  _TActorObject_ItemList = function(BaseObject: TActorObject): TList; stdcall;
  _TActorObject_MagicList = function(BaseObject: TActorObject): TList; stdcall;
  _TActorObject_MyGuild = function(BaseObject: TActorObject): TGUild; stdcall;
  _TActorObject_UseItems = function(BaseObject: TActorObject): pTHumanUseItems; stdcall;
  _TActorObject_btMonsterWeapon = function(BaseObject: TActorObject): PByte; stdcall;
  _TActorObject_PEnvir = function(BaseObject: TActorObject): PTEnvirnoment; stdcall;
  _TActorObject_boGhost = function(BaseObject: TActorObject): PBoolean; stdcall;
  _TActorObject_boDeath = function(BaseObject: TActorObject): PBoolean; stdcall;
  _TActorObject_DeleteBagItem = function(BaseObject: TActorObject; UserItem: pTUserItem): BOOL; stdcall;

  _TActorObject_SendMsg = procedure(SelfObject, BaseObject: TActorObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: PChar); stdcall;
  _TActorObject_SendRefMsg = procedure(BaseObject: TActorObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: PChar); stdcall;
  _TActorObject_SendDelayMsg = procedure(SelfObject, BaseObject: TActorObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: PChar; dwDelayTime: LongWord); stdcall;

  _TActorObject_SysMsg = procedure(BaseObject: TActorObject; pszMsg: PChar; MsgColor: TMsgColor; MsgType: TMsgType); stdcall;
  _TActorObject_GetFrontPosition = function(BaseObject: TActorObject; var nX: Integer; var nY: Integer): Boolean; stdcall;
  _TActorObject_GetRecallXY = function(BaseObject: TActorObject; nX, nY: Integer; nRange: Integer; var nDX: Integer; var nDY: Integer): Boolean; stdcall;
  _TActorObject_SpaceMove = procedure(BaseObject: TActorObject; pszMap: PChar; nX, nY: Integer; nInt: Integer); stdcall;
  _TActorObject_FeatureChanged = procedure(BaseObject: TActorObject); stdcall;
  _TActorObject_StatusChanged = procedure(BaseObject: TActorObject); stdcall;
  _TActorObject_GetFeatureToLong = function(BaseObject: TActorObject): Integer; stdcall;
  _TActorObject_GetFeature = function(SelfObject, BaseObject: TActorObject): Integer; stdcall;
  _TActorObject_GetCharColor = function(SelfObject, BaseObject: TActorObject): Byte; stdcall;
  _TActorObject_GetNamecolor = function(BaseObject: TActorObject): Byte; stdcall;
  _TActorObject_GoldChanged = procedure(BaseObject: TActorObject); stdcall;
  _TActorObject_GameGoldChanged = procedure(BaseObject: TActorObject); stdcall;
  _TActorObject_MagCanHitTarget = function(BaseObject: TActorObject; nX, nY: Integer; TargeTActorObject: TActorObject): Boolean; stdcall;

  _TActorObject_SetTargetCreat = procedure(AObject, BObject: TActorObject); stdcall;
  _TActorObject_IsProtectTarget = function(AObject, BObject: TActorObject): Boolean; stdcall;
  _TActorObject_IsAttackTarget = function(AObject, BObject: TActorObject): Boolean; stdcall;
  _TActorObject_IsProperTarget = function(AObject, BObject: TActorObject): Boolean; stdcall;
  _TActorObject_IsProperFriend = function(AObject, BObject: TActorObject): Boolean; stdcall;
  _TActorObject_TrainSkillPoint = procedure(BaseObject: TActorObject; UserMagic: pTUserMagic; nTranPoint: Integer); stdcall;
  _TActorObject_GetAttackPower = function(BaseObject: TActorObject; nBasePower, nPower: Integer): Integer; stdcall;
  _TActorObject_MakeSlave = function(BaseObject: TActorObject; pszMonName: PChar; nMakeLevel, nExpLevel, nMaxMob, nType: Integer; dwRoyaltySec: LongWord): TActorObject; stdcall;
  _TActorObject_MakeGhost = procedure(BaseObject: TActorObject); stdcall;
  _TActorObject_RefNameColor = procedure(BaseObject: TActorObject); stdcall;
//AddItem 占用内存由自己处理，API内部会自动申请内存
  _TActorObject_AddItemToBag = function(BaseObject: TActorObject; AddItem: pTUserItem): BOOL; stdcall;
  _TActorObject_ClearBagItem = procedure(BaseObject: TActorObject); stdcall;
  _TActorObject_GetBaseObjectTick = function(BaseObject: TActorObject; nCount: Integer): PLongWord; stdcall;

  _TActorObject_MagMakeDefenceArea = function(BaseObject: TActorObject; nX, nY, nRange, nSec: Integer; btState: Byte; boState: Boolean): Integer; stdcall;
  _TActorObject_MagBubbleDefenceUp = function(BaseObject: TActorObject; nLevel, nSec: Integer): Boolean; stdcall;

  _TPlayObject_AddItemToStorage = function(PlayObject: TPlayObject; AddItem: pTUserItem): BOOL; stdcall;
  _TPlayObject_ClearStorageItem = procedure(PlayObject: TPlayObject); stdcall;
  _TPlayObject_GroupOwner = function(PlayObject: TPlayObject): TPlayObject; stdcall;
  _TPlayObject_GroupMembersList = function(PlayObject: TPlayObject): TStringList; stdcall;
  _TPlayObject_boHearWhisper = function(PlayObject: TPlayObject): PBoolean; stdcall;
  _TPlayObject_boBanShout = function(PlayObject: TPlayObject): PBoolean; stdcall;
  _TPlayObject_boBanGuildChat = function(PlayObject: TPlayObject): PBoolean; stdcall;
  _TPlayObject_boAllowDeal = function(PlayObject: TPlayObject): PBoolean; stdcall;
  _TPlayObject_boAllowGroup = function(PlayObject: TPlayObject): PBoolean; stdcall;
  _TPlayObject_boAllowGuild = function(PlayObject: TPlayObject): PBoolean; stdcall;
  _TPlayObject_nHungerStatus = function(PlayObject: TPlayObject): PInteger; stdcall;
  _TPlayObject_boAllowGuildReCall = function(PlayObject: TPlayObject): PBoolean; stdcall;
  _TPlayObject_wGroupRcallTime = function(PlayObject: TPlayObject): PWord; stdcall;
  _TPlayObject_boAllowGroupReCall = function(PlayObject: TPlayObject): PBoolean; stdcall;
  _TPlayObject_IsEnoughBag = function(PlayObject: TPlayObject): Boolean; stdcall;
  _TPlayObject_nSoftVersionDate = function(PlayObject: TPlayObject): PInteger; stdcall;
  _TPlayObject_nSoftVersionDateEx = function(PlayObject: TPlayObject): PInteger; stdcall;
  _TPlayObject_dLogonTime = function(PlayObject: TPlayObject): PDateTime; stdcall;
  _TPlayObject_dwLogonTick = function(PlayObject: TPlayObject): PLongWord; stdcall;
  _TPlayObject_nMemberType = function(PlayObject: TPlayObject): PInteger; stdcall;
  _TPlayObject_nMemberLevel = function(PlayObject: TPlayObject): PInteger; stdcall;
  _TPlayObject_nGameGold = function(PlayObject: TPlayObject): PInteger; stdcall;
  _TPlayObject_nGamePoint = function(PlayObject: TPlayObject): PInteger; stdcall;
  _TPlayObject_nPayMentPoint = function(PlayObject: TPlayObject): PInteger; stdcall;
  _TPlayObject_nClientFlag = function(PlayObject: TPlayObject): PInteger; stdcall;
  _TPlayObject_nSelectID = function(PlayObject: TPlayObject): PInteger; stdcall;
  _TPlayObject_nClientFlagMode = function(PlayObject: TPlayObject): PInteger; stdcall;
  _TPlayObject_dwClientTick = function(PlayObject: TPlayObject): PLongWord; stdcall;
  _TPlayObject_wClientType = function(PlayObject: TPlayObject): PWord; stdcall;
  _TPlayObject_sBankPassword = function(PlayObject: TPlayObject): _LPTBANKPWD; stdcall;
  _TPlayObject_nBankGold = function(PlayObject: TPlayObject): PInteger; stdcall;
  _TPlayObject_Create = function: TPlayObject; stdcall;
  _TPlayObject_Free = procedure(PlayObject: TPlayObject); stdcall;
  _TPlayObject_SendSocket = procedure(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; pszMsg: PChar); stdcall;
  _TPlayObject_SendDefMessage = procedure(PlayObject: TPlayObject; wIdent: Word; nRecog: Integer; nParam, nTag, nSeries: Word; pszMsg: PChar); stdcall;
  _TPlayObject_SendAddItem = procedure(PlayObject: TPlayObject; AddItem: pTUserItem); stdcall;
  _TPlayObject_SendDelItem = procedure(PlayObject: TPlayObject; DelItem: pTUserItem); stdcall;
  _TPlayObject_TargetInNearXY = function(PlayObject: TPlayObject; Target: TActorObject; nX, nY: Integer): Boolean; stdcall;
  _TPlayObject_SetBankPassword = procedure(PlayObject: TPlayObject; pszPassword: PChar); stdcall;
  _TPlayObject_MyHero = function(PlayObject: TPlayObject): PTActorObject; stdcall;

  _TPlayObject_IncGold = function(PlayObject: TPlayObject; nAddGold: Integer): Boolean; stdcall;
  _TPlayObject_IncGameGold = procedure(PlayObject: TPlayObject; nAddGameGold: Integer); stdcall;
  _TPlayObject_IncGamePoint = procedure(PlayObject: TPlayObject; nAddGamePoint: Integer); stdcall;
  _TPlayObject_DecGold = function(PlayObject: TPlayObject; nDecGold: Integer): Boolean; stdcall;
  _TPlayObject_DecGameGold = procedure(PlayObject: TPlayObject; nDECGAMEGOLD: Integer); stdcall;
  _TPlayObject_DecGamePoint = procedure(PlayObject: TPlayObject; nDECGAMEPOINT: Integer); stdcall;
  _TPlayObject_SetUserInPutInteger = procedure(PlayObject: TPlayObject; nData: Integer); stdcall;
  _TPlayObject_SetUserInPutString = procedure(PlayObject: TPlayObject; pszData: PChar); stdcall;
  _TPlayObject_PlayUseItems = function(PlayObject: TPlayObject): pTHumanUseItems; stdcall;

  _THeroObject_SendAddItem = procedure(HeroObject: THeroObject; Item: pTUserItem); stdcall;
  _THeroObject_SendDelItem = procedure(HeroObject: THeroObject; Item: pTUserItem); stdcall;

  _TNormNpc_sFilePath = function(NormNpc: TNormNpc): _LPTPATHNAME; stdcall;
  _TNormNpc_sPath = function(NormNpc: TNormNpc): _LPTPATHNAME; stdcall;
  _TNormNpc_GetLineVariableText = procedure(NormNpc: TNormNpc; BaseObject: TActorObject; pszMsg: PChar; pszOutMsg: PChar; nOutMsgLen: Integer); stdcall;

  _TNormNpc_GetManageNpc = function: TNormNpc; stdcall;
  _TNormNpc_GetFunctionNpc = function: TNormNpc; stdcall;
  _TNormNpc_GotoLable = procedure(NormNpc: TNormNpc; PlayObject: TPlayObject; pszLabel: PChar); stdcall;

  _TUserEngine_GetPlayObject = function(szPlayName: PChar; boGetHide: Boolean): TPlayObject; stdcall;

  _TUserEngine_GetLoadPlayList = function: TStringList; stdcall;
  _TUserEngine_GetPlayObjectList = function: TStringList; stdcall;
  _TUserEngine_GetLoadPlayCount = function: Integer; stdcall;
  _TUserEngine_GetPlayObjectFreeList = function: TList; stdcall;
  _TUserEngine_GetPlayObjectCount = function: Integer; stdcall;
  _TUserEngine_GetStdItemByName = function(pszItemName: PChar): pTStdItem; stdcall;
  _TUserEngine_GetStdItemByIndex = function(nIndex: Integer): pTStdItem; stdcall;
  _TUserEngine_CopyToUserItemFromName = function(const pszItemName: PChar; UserItem: pTUserItem): BOOL; stdcall;
  _TUserEngine_GetStdItemList = function: TObject; stdcall;
  _TUserEngine_GetMagicList = function: TObject; stdcall;

  _TUserEngine_FindMagic = function(nMagIdx: Integer): pTMagic; stdcall;
  _TUserEngine_AddMagic = function(Magic: pTMagic): Boolean; stdcall;
  _TUserEngine_DelMagic = function(wMagicId: Word): Boolean; stdcall;

  _TUserEngine_RandomUpgradeItem = procedure(Item: pTUserItem); stdcall;
  _TUserEngine_GetUnknowItemValue = procedure(Item: pTUserItem); stdcall;

  _TUserEngine_RandomUpgradeItem_ = procedure(Item: pTUserItem); stdcall;
  _TUserEngine_GetUnknowItemValue_ = procedure(Item: pTUserItem); stdcall;


  _TMapManager_FindMap = function(pszMapName: PChar): TEnvirnoment; stdcall;
  _TEnvirnoment_GetRangeActorObject = function(Envir: TEnvirnoment; nX, nY, nRage: Integer; boFlag: Boolean; BaseObjectList: TList): Integer; stdcall;


  _TGuild_RankList = function(Guild: TGUild): TList; stdcall;

  _TItemUnit_GetItemAddValue = procedure(UserItem: pTUserItem; var StdItem: TStdItem); stdcall;

  {_TUserEngine_GetMaxPlayObjectCount = function: Integer; stdcall;
  _TUserEngine_SetMaxPlayObjectCount = procedure(Buffer: PChar; nLen: Integer); stdcall; }

  TEngineOut = record
    List_Create: _TList_Create;
    List_Free: _TList_Free;
    List_Count: _TList_Count;
    List_Add: _TList_Add;
    List_Insert: _TList_Insert;

    List_Get: _TList_Get;
    List_Put: _TList_Put;
    List_Delete: _TList_Delete;
    List_Clear: _TList_Clear;
    List_Exchange: _TList_Exchange;

    StringList_Create: _TStringList_Create;
    StringList_Free: _TStringList_Free;
    StringList_Count: _TStringList_Count;
    StringList_Add: _TStringList_Add;
    StringList_AddObject: _TStringList_AddObject;
    StringList_Insert: _TStringList_Insert;
    StringList_Get: _TStringList_Get;
    StringList_GetObject: _TStringList_GetObject;
    StringList_Put: _TStringList_Put;
    StringList_PutObject: _TStringList_PutObject;
    StringList_Delete: _TStringList_Delete;
    StringList_Clear: _TStringList_Clear;
    StringList_Exchange: _TStringList_Exchange;
    StringList_LoadFormFile: _TStringList_LoadFormFile;
    StringList_SaveToFile: _TStringList_SaveToFile;
    
    MainOutMessageAPI: _TMainOutMessageAPI;
    AddGameDataLogAPI: _TAddGameDataLogAPI;

    TGetGameGoldName: _TGetGameGoldName;
    TEDcode_Decode6BitBuf: _TEDcode_Decode6BitBuf;
    TEDcode_Encode6BitBuf: _TEDcode_Encode6BitBuf;
    TEDcode_DeCodeString: _TEDcode_DeCodeString;
    TEDcode_EncodeString: _TEDcode_EncodeString;
    TEDcode_EncodeBuffer: _TEDcode_EncodeBuffer;
    TEDcode_DecodeBuffer: _TEDcode_DecodeBuffer;

    TConfig_sEnvirDir: _TConfig_sEnvirDir;
    TConfig_AmyOunsulPoint: _TConfig_AmyOunsulPoint;

    TActorObject_Create: _TActorObject_Create;
    TActorObject_Free: _TActorObject_Free;
    TActorObject_sMapFileName: _TActorObject_sMapFileName;
    TActorObject_sMapName: _TActorObject_sMapName;
    TActorObject_sMapNameA: _TActorObject_sMapNameA;
    TActorObject_sCharName: _TActorObject_sCharName;
    TActorObject_sCharNameA: _TActorObject_sCharNameA;

    TActorObject_nCurrX: _TActorObject_nCurrX;
    TActorObject_nCurrY: _TActorObject_nCurrY;
    TActorObject_btDirection: _TActorObject_btDirection;
    TActorObject_btGender: _TActorObject_btGender;
    TActorObject_btHair: _TActorObject_btHair;
    TActorObject_btJob: _TActorObject_btJob;
    TActorObject_nGold: _TActorObject_nGold;
    TActorObject_Ability: _TActorObject_Ability;

    TActorObject_WAbility: _TActorObject_WAbility;
    TActorObject_nCharStatus: _TActorObject_nCharStatus;
    TActorObject_sHomeMap: _TActorObject_sHomeMap;
    TActorObject_nHomeX: _TActorObject_nHomeX;
    TActorObject_nHomeY: _TActorObject_nHomeY;
    TActorObject_boOnHorse: _TActorObject_boOnHorse;
    TActorObject_btHorseType: _TActorObject_btHorseType;
    TActorObject_btDressEffType: _TActorObject_btDressEffType;
    TActorObject_nPkPoint: _TActorObject_nPkPoint;

    TActorObject_duBodyLuck: _TActorObject_duBodyLuck;
    TActorObject_nBodyLuckLevel: _TActorObject_nBodyLuckLevel;
    TActorObject_nFightZoneDieCount: _TActorObject_nFightZoneDieCount;
    TActorObject_nBonusPoint: _TActorObject_nBonusPoint;
    TActorObject_nCharStatusEx: _TActorObject_nCharStatusEx;
    TActorObject_dwFightExp: _TActorObject_dwFightExp;
    TActorObject_nViewRange: _TActorObject_nViewRange;
    TActorObject_wAppr: _TActorObject_wAppr;
    TActorObject_btRaceServer: _TActorObject_btRaceServer;
    TActorObject_btRaceImg: _TActorObject_btRaceImg;
    TActorObject_btHitPoint: _TActorObject_btHitPoint;
    TActorObject_nHitPlus: _TActorObject_nHitPlus;
    TActorObject_nHitDouble: _TActorObject_nHitDouble;
    TActorObject_boRecallSuite: _TActorObject_boRecallSuite;
    TActorObject_nHealthRecover: _TActorObject_nHealthRecover;
    TActorObject_nSpellRecover: _TActorObject_nSpellRecover;
    TActorObject_btAntiPoison: _TActorObject_btAntiPoison;
    TActorObject_nPoisonRecover: _TActorObject_nPoisonRecover;
    TActorObject_nAntiMagic: _TActorObject_nAntiMagic;
    TActorObject_nLuck: _TActorObject_nLuck;
    TActorObject_nPerHealth: _TActorObject_nPerHealth;
    TActorObject_nPerHealing: _TActorObject_nPerHealing;
    TActorObject_nPerSpell: _TActorObject_nPerSpell;
    TActorObject_btGreenPoisoningPoint: _TActorObject_btGreenPoisoningPoint;
    TActorObject_nGoldMax: _TActorObject_nGoldMax;
    TActorObject_btSpeedPoint: _TActorObject_btSpeedPoint;
    TActorObject_btPermission: _TActorObject_btPermission;
    TActorObject_nHitSpeed: _TActorObject_nHitSpeed;
    TActorObject_TargetCret: _TActorObject_TargetCret;
    TActorObject_LastHiter: _TActorObject_LastHiter;
    TActorObject_ExpHiter: _TActorObject_ExpHiter;

    TActorObject_btLifeAttrib: _TActorObject_btLifeAttrib;
    TActorObject_nSlaveType: _TActorObject_nSlaveType;
    TActorObject_Master: _TActorObject_Master;
    TActorObject_btAttatckMode: _TActorObject_btAttatckMode;
    TActorObject_btNameColor: _TActorObject_btNameColor;
    TActorObject_nLight: _TActorObject_nLight;
    TActorObject_ItemList: _TActorObject_ItemList;
    TActorObject_MagicList: _TActorObject_MagicList;
    TActorObject_MyGuild: _TActorObject_MyGuild;
    TActorObject_UseItems: _TActorObject_UseItems;
    TActorObject_btMonsterWeapon: _TActorObject_btMonsterWeapon;
    TActorObject_PEnvir: _TActorObject_PEnvir;
    TActorObject_boGhost: _TActorObject_boGhost;
    TActorObject_boDeath: _TActorObject_boDeath;
    TActorObject_DeleteBagItem: _TActorObject_DeleteBagItem;

    TActorObject_SendMsg: _TActorObject_SendMsg;
    TActorObject_SendRefMsg: _TActorObject_SendRefMsg;
    TActorObject_SendDelayMsg: _TActorObject_SendDelayMsg;

    TActorObject_SysMsg: _TActorObject_SysMsg;
    TActorObject_GetFrontPosition: _TActorObject_GetFrontPosition;
    TActorObject_GetRecallXY: _TActorObject_GetRecallXY;
    TActorObject_SpaceMove: _TActorObject_SpaceMove;
    TActorObject_FeatureChanged: _TActorObject_FeatureChanged;
    TActorObject_StatusChanged: _TActorObject_StatusChanged;
    TActorObject_GetFeatureToLong: _TActorObject_GetFeatureToLong;
    TActorObject_GetFeature: _TActorObject_GetFeature;
    TActorObject_GetCharColor: _TActorObject_GetCharColor;
    TActorObject_GetNamecolor: _TActorObject_GetNamecolor;
    TActorObject_GoldChanged: _TActorObject_GoldChanged;
    TActorObject_GameGoldChanged: _TActorObject_GameGoldChanged;
    TActorObject_MagCanHitTarget: _TActorObject_MagCanHitTarget;

    TActorObject_SetTargetCreat: _TActorObject_SetTargetCreat;
    TActorObject_IsProtectTarget: _TActorObject_IsProtectTarget;
    TActorObject_IsAttackTarget: _TActorObject_IsAttackTarget;
    TActorObject_IsProperTarget: _TActorObject_IsProperTarget;
    TActorObject_IsProperFriend: _TActorObject_IsProperFriend;
    TActorObject_TrainSkillPoint: _TActorObject_TrainSkillPoint;
    TActorObject_GetAttackPower: _TActorObject_GetAttackPower;
    TActorObject_MakeSlave: _TActorObject_MakeSlave;
    TActorObject_MakeGhost: _TActorObject_MakeGhost;
    TActorObject_RefNameColor: _TActorObject_RefNameColor;

    TActorObject_AddItemToBag: _TActorObject_AddItemToBag;
    TActorObject_ClearBagItem: _TActorObject_ClearBagItem;
    TActorObject_GetBaseObjectTick: _TActorObject_GetBaseObjectTick;

    TActorObject_MagMakeDefenceArea: _TActorObject_MagMakeDefenceArea;
    TActorObject_MagBubbleDefenceUp: _TActorObject_MagBubbleDefenceUp;

    TPlayObject_AddItemToStorage: _TPlayObject_AddItemToStorage;
    TPlayObject_ClearStorageItem: _TPlayObject_ClearStorageItem;
    TPlayObject_GroupOwner: _TPlayObject_GroupOwner;
    TPlayObject_GroupMembersList: _TPlayObject_GroupMembersList;
    TPlayObject_boHearWhisper: _TPlayObject_boHearWhisper;
    TPlayObject_boBanShout: _TPlayObject_boBanShout;
    TPlayObject_boBanGuildChat: _TPlayObject_boBanGuildChat;
    TPlayObject_boAllowDeal: _TPlayObject_boAllowDeal;
    TPlayObject_boAllowGroup: _TPlayObject_boAllowGroup;
    TPlayObject_boAllowGuild: _TPlayObject_boAllowGuild;
    TPlayObject_nHungerStatus: _TPlayObject_nHungerStatus;
    TPlayObject_boAllowGuildReCall: _TPlayObject_boAllowGuildReCall;
    TPlayObject_wGroupRcallTime: _TPlayObject_wGroupRcallTime;
    TPlayObject_boAllowGroupReCall: _TPlayObject_boAllowGroupReCall;
    TPlayObject_IsEnoughBag: _TPlayObject_IsEnoughBag;
    TPlayObject_nSoftVersionDate: _TPlayObject_nSoftVersionDate;
    TPlayObject_nSoftVersionDateEx: _TPlayObject_nSoftVersionDateEx;
    TPlayObject_dLogonTime: _TPlayObject_dLogonTime;
    TPlayObject_dwLogonTick: _TPlayObject_dwLogonTick;
    TPlayObject_nMemberType: _TPlayObject_nMemberType;
    TPlayObject_nMemberLevel: _TPlayObject_nMemberLevel;
    TPlayObject_nGameGold: _TPlayObject_nGameGold;
    TPlayObject_nGamePoint: _TPlayObject_nGamePoint;
    TPlayObject_nPayMentPoint: _TPlayObject_nPayMentPoint;
    TPlayObject_nClientFlag: _TPlayObject_nClientFlag;
    TPlayObject_nSelectID: _TPlayObject_nSelectID;
    TPlayObject_nClientFlagMode: _TPlayObject_nClientFlagMode;
    TPlayObject_dwClientTick: _TPlayObject_dwClientTick;
    TPlayObject_wClientType: _TPlayObject_wClientType;
    TPlayObject_sBankPassword: _TPlayObject_sBankPassword;
    TPlayObject_nBankGold: _TPlayObject_nBankGold;
    TPlayObject_Create: _TPlayObject_Create;
    TPlayObject_Free: _TPlayObject_Free;
    TPlayObject_SendSocket: _TPlayObject_SendSocket;
    TPlayObject_SendDefMessage: _TPlayObject_SendDefMessage;
    TPlayObject_SendAddItem: _TPlayObject_SendAddItem;
    TPlayObject_SendDelItem: _TPlayObject_SendDelItem;
    TPlayObject_TargetInNearXY: _TPlayObject_TargetInNearXY;
    TPlayObject_SetBankPassword: _TPlayObject_SetBankPassword;
    TPlayObject_MyHero: _TPlayObject_MyHero;

    TPlayObject_IncGold: _TPlayObject_IncGold;
    TPlayObject_IncGameGold: _TPlayObject_IncGameGold;
    TPlayObject_IncGamePoint: _TPlayObject_IncGamePoint;
    TPlayObject_DecGold: _TPlayObject_DecGold;
    TPlayObject_DecGameGold: _TPlayObject_DecGameGold;
    TPlayObject_DecGamePoint: _TPlayObject_DecGamePoint;
    TPlayObject_SetUserInPutInteger: _TPlayObject_SetUserInPutInteger;
    TPlayObject_SetUserInPutString: _TPlayObject_SetUserInPutString;
    TPlayObject_PlayUseItems: _TPlayObject_PlayUseItems;

    THeroObject_SendAddItem: _THeroObject_SendAddItem;
    THeroObject_SendDelItem: _THeroObject_SendDelItem;

    TNormNpc_sFilePath: _TNormNpc_sFilePath;
    TNormNpc_sPath: _TNormNpc_sPath;
    TNormNpc_GetLineVariableText: _TNormNpc_GetLineVariableText;

    TNormNpc_GetManageNpc: _TNormNpc_GetManageNpc;
    TNormNpc_GetFunctionNpc: _TNormNpc_GetFunctionNpc;
    TNormNpc_GotoLable: _TNormNpc_GotoLable;

    TUserEngine_GetPlayObject: _TUserEngine_GetPlayObject;

    TUserEngine_GetLoadPlayList: _TUserEngine_GetLoadPlayList;
    TUserEngine_GetPlayObjectList: _TUserEngine_GetPlayObjectList;
    TUserEngine_GetPlayObjectFreeList: _TUserEngine_GetPlayObjectFreeList;
    TUserEngine_GetLoadPlayCount: _TUserEngine_GetLoadPlayCount;

    TUserEngine_GetPlayObjectCount: _TUserEngine_GetPlayObjectCount;
    TUserEngine_GetStdItemByName: _TUserEngine_GetStdItemByName;
    TUserEngine_GetStdItemByIndex: _TUserEngine_GetStdItemByIndex;
    TUserEngine_CopyToUserItemFromName: _TUserEngine_CopyToUserItemFromName;
    TUserEngine_GetStdItemList: _TUserEngine_GetStdItemList;
    TUserEngine_GetMagicList: _TUserEngine_GetMagicList;

    TUserEngine_FindMagic: _TUserEngine_FindMagic;
    TUserEngine_AddMagic: _TUserEngine_AddMagic;
    TUserEngine_DelMagic: _TUserEngine_DelMagic;

    TUserEngine_RandomUpgradeItem: _TUserEngine_RandomUpgradeItem;
    TUserEngine_GetUnknowItemValue: _TUserEngine_GetUnknowItemValue;

    TUserEngine_RandomUpgradeItem_: _TUserEngine_RandomUpgradeItem_;
    TUserEngine_GetUnknowItemValue_: _TUserEngine_GetUnknowItemValue_;

    TMapManager_FindMap: _TMapManager_FindMap;
    TEnvirnoment_GetRangeActorObject: _TEnvirnoment_GetRangeActorObject;

    TGuild_RankList: _TGuild_RankList;

    ItemUnit_GetItemAddValue: _TItemUnit_GetItemAddValue;

    {TUserEngine_GetMaxPlayObjectCount: _TUserEngine_GetMaxPlayObjectCount;
    TUserEngine_SetMaxPlayObjectCount: _TUserEngine_SetMaxPlayObjectCount; }
  end;
  pTEngineOut = ^TEngineOut;

 { TPlugEngine = record
    AppHandle: THandle;
    Module: THandle;
    MsgProc: TMsgProc;
    PlugOfEngine: TPlugOfEngine;
    UserEngine: TUserEngine;
    EngineOut: TEngineOut;
    Buffer: PChar;
  end;
  pTPlugEngine = ^TPlugEngine; }

  TPlugEngine = record
    AppHandle: THandle;
    Module: THandle;
    MsgProc: TMsgProc;
    PlugOfEngine: TPlugOfEngine;
    UserEngine: TUserEngine;
    EngineOut: TEngineOut;
    Buffer: PChar;
  end;
  pTPlugEngine = ^TPlugEngine;


  TPlugInit = function(PlugEngine: pTPlugEngine): PChar; stdcall;

  TCharObject = class
    EngineOut: TEngineOut;
    BaseObject: TObject;
  private
    function GetCurrX: Integer;
    procedure SetCurrX(Value: Integer);
    function GetCurrY: Integer;
    procedure SetCurrY(Value: Integer);

    function GetDirection: Byte;
    procedure SetDirection(Value: Byte);

    function GetJob: Byte;
    procedure SetJob(Value: Byte);
    function GetAbility: pTAbility;
    function GetWAbility: pTAbility;
    function GetGhost: Boolean;
    procedure SetGhost(Value: Boolean);
    function GetDeath: Boolean;
    procedure SetDeath(Value: Boolean);

    function GetHumanUseItems: pTHumanUseItems;
    function GetTargetCret: pTActorObject;
    function GetLastHiter: pTActorObject;
    function GetExpHiter: pTActorObject;

    function GetObjectRunTick(Index: Integer): LongWord;
    procedure SetObjectRunTick(Index: Integer; Value: LongWord);

    function GetRaceServer: Byte;
    function GetItemList: TList;

    function GetGender: Byte;
    procedure SetGender(Value: Byte);

    function GetEnvir: TEnvirnoment;
    procedure SetEnvir(Value: TEnvirnoment);

    function GetMyGuild: TObject;

    function GetGold: Integer;
    procedure SetGold(Value: Integer);

    function GetGameGold: Integer;
    procedure SetGameGold(Value: Integer);
    function GetGamePoint: Integer;
    procedure SetGamePoint(Value: Integer);
    function GetPkPoint: Integer;
    procedure SetPkPoint(Value: Integer);

    function GetCharName: string;
    procedure SetCharName(Value: string);
    function GetMapName: string;
    procedure SetMapName(Value: string);

    function GetMyHero: pTActorObject;
    function GetGameGoldName: string;
  public
    constructor Create();
    destructor Destroy; override;
    procedure SendMsg(AObject: TObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: string);
    procedure SendRefMsg(wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: string);
    procedure SendDelayMsg(AObject: TObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: string; dwDelayTime: LongWord);
    procedure SysMsg(sMsg: string; MsgColor: TMsgColor; MsgType: TMsgType);
    procedure DeleteBagItem(UserItem: pTUserItem);
    procedure SetUserInPutInteger(Value: Integer);
    procedure SetUserInPutString(Value: string);
    procedure GotoLable(PlayObject: TPlayObject; sLabel: string);
    function GetRangeActorObject(Envir: TEnvirnoment; nX, nY, nRage: Integer; boFlag: Boolean; BaseObjectList: TList): Integer;
    function AddItemToBag(UserItem: pTUserItem): BOOL;
    procedure GoldChanged;
    procedure GameGoldChanged;
    function IsEnoughBag: Boolean;

    procedure SendSocket(DefMsg: pTDefaultMessage; sMsg: string);
    procedure SendDefMessage(wIdent: Word; nRecog: Integer; nParam, nTag, nSeries: Word; sMsg: string);
    procedure SendAddItem(UserItem: pTUserItem);
    procedure SendDelItem(UserItem: pTUserItem);
    function IncGold(nGold: Integer): Boolean;
    procedure IncGameGold(nGameGold: Integer);
    procedure IncGamePoint(nGamePoint: Integer);
    function DecGold(nGold: Integer): Boolean;
    procedure DecGameGold(nGameGold: Integer);
    procedure DecGamePoint(nGamePoint: Integer);

    procedure SendHeroAddItem(UserItem: pTUserItem);
    procedure SendHeroDelItem(UserItem: pTUserItem);

    property m_nCurrX: Integer read GetCurrX write SetCurrX;
    property m_nCurrY: Integer read GetCurrY write SetCurrY;
    property m_btGender: Byte read GetGender write SetGender;
    property m_btDirection: Byte read GetDirection write SetDirection;
    property m_btJob: Byte read GetJob write SetJob;
    property m_Abil: pTAbility read GetAbility;
    property m_WAbil: pTAbility read GetWAbility;
    property m_boGhost: Boolean read GetGhost write SetGhost;
    property m_boDeath: Boolean read GetGhost write SetGhost;
    property m_UseItems: pTHumanUseItems read GetHumanUseItems;
    property m_TargetCret: pTActorObject read GetTargetCret;
    property m_LastHiter: pTActorObject read GetLastHiter;
    property m_ExpHiter: pTActorObject read GetExpHiter;
    property m_ObjectRunTick[Index: Integer]: Longword read GetObjectRunTick write SetObjectRunTick;
    property m_btRaceServer: Byte read GetRaceServer;
    property m_ItemList: TList read GetItemList;
    property m_PEnvir: TEnvirnoment read GetEnvir write SetEnvir;
    property m_MyGuild: TObject read GetMyGuild;
    property m_nGold: Integer read GetGold write SetGold;

    property m_nGameGold: Integer read GetGameGold write SetGameGold;
    property m_nGamePoint: Integer read GetGamePoint write SetGamePoint;
    property m_nPkPoint: Integer read GetPkPoint write SetPkPoint;
    property m_sCharName: string read GetCharName write SetCharName;
    property m_sMapName: string read GetMapName write SetMapName;
    property m_sGameGoldName: string read GetGameGoldName;
    property m_MyHero: pTActorObject read GetMyHero;
  end;

  TUserManage = class
    EngineOut: TEngineOut;
    UserEngine: TUserEngine;
  private
    function GetStdItemList: TList;
    function GetMagicList: TList;
    function GetPlayObjectFreeList: TList;
    function GetPlayObjectCount: Integer;
    function GetManageNPC: TObject;
    function GetFunctionNPC: TObject;
  public
    constructor Create();
    destructor Destroy; override;
    function GetStdItem(Index: Integer): pTStdItem; overload;
    function GetStdItem(sName: string): pTStdItem; overload;
    function GetPlayObject(sPlayName: string): TPlayObject;
    function CopyToUserItemFromName(const sItemName: string; UserItem: pTUserItem): BOOL;
    function FindMagic(nMagIdx: Integer): pTMagic;
    function AddMagic(Magic: pTMagic): Boolean;
    function DelMagic(nMagIdx: Integer): Boolean;
    procedure RandomUpgradeItem(Item: pTUserItem);
    procedure GetUnknowItemValue(Item: pTUserItem);
    procedure RandomUpgradeItem_(Item: pTUserItem);
    procedure GetUnknowItemValue_(Item: pTUserItem);
    procedure GetItemAddValue(UserItem: pTUserItem; var StdItem: TStdItem);

    property m_PlayObjectFreeList: TList read GetPlayObjectFreeList;
    property m_StdItemList: TList read GetStdItemList;
    property m_MagicList: TList read GetMagicList;
    property m_PlayObjectCount: Integer read GetPlayObjectCount;
    property m_ManageNPC: TObject read GetManageNPC;
    property m_FunctionNPC: TObject read GetFunctionNPC;
  end;
procedure ShortStringToPChar(S: PTShortString; pszDest: PChar);
implementation

procedure ShortStringToPChar(S: PTShortString; pszDest: PChar);
begin
  Move(S.Strings, pszDest^, S.btLen);
  pszDest[S.btLen] := #0;
end;

procedure TCharObject.SendHeroAddItem(UserItem: pTUserItem);
begin
  EngineOut.THeroObject_SendAddItem(BaseObject, UserItem);
end;

procedure TCharObject.SendHeroDelItem(UserItem: pTUserItem);
begin
  EngineOut.THeroObject_SendDelItem(BaseObject, UserItem);
end;

function TCharObject.GetMyHero: pTActorObject;
begin
  Result := EngineOut.TPlayObject_MyHero(BaseObject);
end;

procedure TCharObject.SendSocket(DefMsg: pTDefaultMessage; sMsg: string);
begin
  EngineOut.TPlayObject_SendSocket(BaseObject, DefMsg, PChar(sMsg));
end;

procedure TCharObject.SendDefMessage(wIdent: Word; nRecog: Integer; nParam, nTag, nSeries: Word; sMsg: string);
begin
  EngineOut.TPlayObject_SendDefMessage(BaseObject, wIdent, nRecog, nParam, nTag, nSeries, PChar(sMsg));
end;

procedure TCharObject.SendAddItem(UserItem: pTUserItem);
begin
  EngineOut.TPlayObject_SendAddItem(BaseObject, UserItem);
end;

procedure TCharObject.SendDelItem(UserItem: pTUserItem);
begin
  EngineOut.TPlayObject_SendDelItem(BaseObject, UserItem);
end;

function TCharObject.IncGold(nGold: Integer): Boolean;
begin
  Result := EngineOut.TPlayObject_IncGold(BaseObject, nGold);
end;

procedure TCharObject.IncGameGold(nGameGold: Integer);
begin
  EngineOut.TPlayObject_IncGameGold(BaseObject, nGameGold);
end;

procedure TCharObject.IncGamePoint(nGamePoint: Integer);
begin
  EngineOut.TPlayObject_IncGamePoint(BaseObject, nGamePoint);
end;

function TCharObject.DecGold(nGold: Integer): Boolean;
begin
  Result := EngineOut.TPlayObject_DecGold(BaseObject, nGold);
end;

procedure TCharObject.DecGameGold(nGameGold: Integer);
begin
  EngineOut.TPlayObject_DecGameGold(BaseObject, nGameGold);
end;

procedure TCharObject.DecGamePoint(nGamePoint: Integer);
begin
  EngineOut.TPlayObject_DecGamePoint(BaseObject, nGamePoint);
end;

function TCharObject.IsEnoughBag: Boolean;
begin
  Result := EngineOut.TPlayObject_IsEnoughBag(BaseObject);
end;

function TCharObject.GetGameGold: Integer;
begin
  Result := EngineOut.TPlayObject_nGameGold(BaseObject)^;
end;

procedure TCharObject.SetGameGold(Value: Integer);
begin
  EngineOut.TPlayObject_nGameGold(BaseObject)^ := Value;
end;

function TCharObject.GetGamePoint: Integer;
begin
  Result := EngineOut.TPlayObject_nGamePoint(BaseObject)^;
end;

procedure TCharObject.SetGamePoint(Value: Integer);
begin
  EngineOut.TPlayObject_nGamePoint(BaseObject)^ := Value;
end;

function TCharObject.GetPkPoint: Integer;
begin
  Result := EngineOut.TActorObject_nPkPoint(BaseObject)^;
end;

procedure TCharObject.SetPkPoint(Value: Integer);
begin
  EngineOut.TActorObject_nPkPoint(BaseObject)^ := Value;
end;

function TCharObject.GetGameGoldName: string;
var
  ShortString: PTShortString;
  sGameGoldName: string;
begin
  Result := '';
  ShortString := EngineOut.TGetGameGoldName();
  if ShortString <> nil then begin
    SetLength(sGameGoldName, ShortString.btLen);
    ShortStringToPChar(ShortString, @sGameGoldName[1]);
    Result := sGameGoldName;
  end;
end;

function TCharObject.GetCharName: string;
var
  ShortString: PTShortString;
  sCharName: string;
begin
  Result := '';
  ShortString := EngineOut.TActorObject_sCharName(BaseObject);
  if ShortString <> nil then begin
    SetLength(sCharName, ShortString.btLen);
    ShortStringToPChar(ShortString, @sCharName[1]);
    Result := sCharName;
  end;
end;

procedure TCharObject.SetCharName(Value: string);
var
  ShortString: PTShortString;
  Buffer: PChar;
begin
  ShortString := EngineOut.TActorObject_sCharName(BaseObject);
  if ShortString <> nil then begin
    ShortString.btLen := Length(Value);
    Buffer := @ShortString.Strings;
    Move(Value[1], Buffer^, ShortString.btLen);
  end;
end;

function TCharObject.GetMapName: string;
var
  ShortString: PTShortString;
  sMapName: string;
begin
  Result := '';
  ShortString := EngineOut.TActorObject_sMapName(BaseObject);
  if ShortString <> nil then begin
    SetLength(sMapName, ShortString.btLen);
    ShortStringToPChar(ShortString, @sMapName[1]);
    Result := sMapName;
  end;
end;

procedure TCharObject.SetMapName(Value: string);
var
  ShortString: PTShortString;
  Buffer: PChar;
begin
  ShortString := EngineOut.TActorObject_sMapName(BaseObject);
  if ShortString <> nil then begin
    ShortString.btLen := Length(Value);
    Buffer := @ShortString.Strings;
    Move(Value[1], Buffer^, ShortString.btLen);
  end;
end;

function TCharObject.GetGold: Integer;
begin
  Result := EngineOut.TActorObject_nGold(BaseObject)^;
end;

procedure TCharObject.SetGold(Value: Integer);
begin
  EngineOut.TActorObject_nGold(BaseObject)^ := Value;
end;

function TCharObject.AddItemToBag(UserItem: pTUserItem): BOOL;
begin
  Result := EngineOut.TActorObject_AddItemToBag(BaseObject, UserItem);
end;

procedure TCharObject.GoldChanged;
begin
  EngineOut.TActorObject_GoldChanged(BaseObject);
end;

procedure TCharObject.GameGoldChanged;
begin
  EngineOut.TActorObject_GameGoldChanged(BaseObject);
end;

function TCharObject.GetMyGuild: TObject;
begin
  Result := EngineOut.TActorObject_MyGuild(BaseObject);
end;

function TCharObject.GetRangeActorObject(Envir: TEnvirnoment; nX, nY, nRage: Integer; boFlag: Boolean; BaseObjectList: TList): Integer;
begin
  Result := EngineOut.TEnvirnoment_GetRangeActorObject(Envir, nX, nY, nRage, boFlag, BaseObjectList);
end;

function TCharObject.GetEnvir: TEnvirnoment;
begin
  Result := EngineOut.TActorObject_PEnvir(BaseObject)^;
end;

procedure TCharObject.SetEnvir(Value: TEnvirnoment);
begin
  EngineOut.TActorObject_PEnvir(BaseObject)^ := Value;
end;

procedure TCharObject.GotoLable(PlayObject: TPlayObject; sLabel: string);
begin
  EngineOut.TNormNpc_GotoLable(BaseObject, PlayObject, PChar(sLabel));
end;

function TCharObject.GetGender: Byte;
begin
  Result := EngineOut.TActorObject_btGender(BaseObject)^;
end;

procedure TCharObject.SetGender(Value: Byte);
begin
  EngineOut.TActorObject_btGender(BaseObject)^ := Value;
end;

procedure TCharObject.SetUserInPutInteger(Value: Integer);
begin
  EngineOut.TPlayObject_SetUserInPutInteger(BaseObject, Value);
end;

procedure TCharObject.SetUserInPutString(Value: string);
begin
  EngineOut.TPlayObject_SetUserInPutString(BaseObject, PChar(Value));
end;

function TCharObject.GetCurrX: Integer;
begin
  Result := EngineOut.TActorObject_nCurrX(BaseObject)^;
end;

procedure TCharObject.SetCurrX(Value: Integer);
begin
  EngineOut.TActorObject_nCurrX(BaseObject)^ := Value;
end;

function TCharObject.GetCurrY: Integer;
begin
  Result := EngineOut.TActorObject_nCurrY(BaseObject)^;
end;

procedure TCharObject.SetCurrY(Value: Integer);
begin
  EngineOut.TActorObject_nCurrY(BaseObject)^ := Value;
end;

function TCharObject.GetDirection: Byte;
begin
  Result := EngineOut.TActorObject_btDirection(BaseObject)^;
end;

procedure TCharObject.SetDirection(Value: Byte);
begin
  EngineOut.TActorObject_btDirection(BaseObject)^ := Value;
end;

function TCharObject.GetJob: Byte;
begin
  Result := EngineOut.TActorObject_btJob(BaseObject)^;
end;

procedure TCharObject.SetJob(Value: Byte);
begin
  EngineOut.TActorObject_btJob(BaseObject)^ := Value;
end;

function TCharObject.GetWAbility: pTAbility;
begin
  Result := EngineOut.TActorObject_WAbility(BaseObject);
end;

function TCharObject.GetAbility: pTAbility;
begin
  Result := EngineOut.TActorObject_Ability(BaseObject);
end;

function TCharObject.GetGhost: Boolean;
begin
  Result := EngineOut.TActorObject_boGhost(BaseObject)^;
end;

procedure TCharObject.SetGhost(Value: Boolean);
begin
  EngineOut.TActorObject_boGhost(BaseObject)^ := Value;
end;

function TCharObject.GetDeath: Boolean;
begin
  Result := EngineOut.TActorObject_boDeath(BaseObject)^;
end;

procedure TCharObject.SetDeath(Value: Boolean);
begin
  EngineOut.TActorObject_boDeath(BaseObject)^ := Value;
end;

procedure TCharObject.SendMsg(AObject: TObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: string);
begin
  EngineOut.TActorObject_SendMsg(BaseObject, AObject, wIdent, wParam, nParam1, nParam2, nParam3, PChar(pszMsg));
end;

procedure TCharObject.SendRefMsg(wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: string);
begin
  EngineOut.TActorObject_SendRefMsg(BaseObject, wIdent, wParam, nParam1, nParam2, nParam3, PChar(pszMsg));
end;

procedure TCharObject.SendDelayMsg(AObject: TObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: string; dwDelayTime: LongWord);
begin
  EngineOut.TActorObject_SendDelayMsg(BaseObject, AObject, wIdent, wParam, nParam1, nParam2, nParam3, PChar(pszMsg), dwDelayTime);
end;

procedure TCharObject.SysMsg(sMsg: string; MsgColor: TMsgColor; MsgType: TMsgType);
begin
  EngineOut.TActorObject_SysMsg(BaseObject, PChar(sMsg), MsgColor, MsgType);
end;

function TCharObject.GetHumanUseItems: pTHumanUseItems;
begin
  Result := EngineOut.TActorObject_UseItems(BaseObject);
end;

function TCharObject.GetTargetCret: pTActorObject;
begin
  Result := EngineOut.TActorObject_TargetCret(BaseObject);
end;

function TCharObject.GetLastHiter: pTActorObject;
begin
  Result := EngineOut.TActorObject_LastHiter(BaseObject);
end;

function TCharObject.GetExpHiter: pTActorObject;
begin
  Result := EngineOut.TActorObject_ExpHiter(BaseObject);
end;

function TCharObject.GetObjectRunTick(Index: Integer): LongWord;
begin
  Result := EngineOut.TActorObject_GetBaseObjectTick(BaseObject, Index)^;
end;

procedure TCharObject.SetObjectRunTick(Index: Integer; Value: LongWord);
begin
  EngineOut.TActorObject_GetBaseObjectTick(BaseObject, Index)^ := Value;
end;

function TCharObject.GetRaceServer: Byte;
begin
  Result := EngineOut.TActorObject_btRaceServer(BaseObject)^;
end;

function TCharObject.GetItemList: TList;
begin
  Result := TList(EngineOut.TActorObject_ItemList(BaseObject));
end;

procedure TCharObject.DeleteBagItem(UserItem: pTUserItem);
begin
  EngineOut.TActorObject_DeleteBagItem(BaseObject, UserItem);
end;

constructor TCharObject.Create();
begin
  BaseObject := nil;
end;

destructor TCharObject.Destroy;
begin
  inherited;
end;
//==============================================================================

function TUserManage.GetPlayObjectFreeList: TList;
begin
  Result := EngineOut.TUserEngine_GetPlayObjectFreeList;
end;

function TUserManage.GetManageNPC: TObject;
begin
  Result := EngineOut.TNormNpc_GetManageNpc;
end;

function TUserManage.GetFunctionNPC: TObject;
begin
  Result := EngineOut.TNormNpc_GetFunctionNPC;
end;

function TUserManage.GetMagicList: TList;
begin
  Result := TList(EngineOut.TUserEngine_GetMagicList);
end;

function TUserManage.GetStdItem(sName: string): pTStdItem;
begin
  Result := EngineOut.TUserEngine_GetStdItemByName(PChar(sName));
end;

function TUserManage.GetPlayObject(sPlayName: string): TPlayObject;
begin
  Result := EngineOut.TUserEngine_GetPlayObject(PChar(sPlayName), True);
end;

function TUserManage.CopyToUserItemFromName(const sItemName: string; UserItem: pTUserItem): BOOL;
begin
  Result := EngineOut.TUserEngine_CopyToUserItemFromName(PChar(sItemName), UserItem);
end;

function TUserManage.FindMagic(nMagIdx: Integer): pTMagic;
begin
  Result := EngineOut.TUserEngine_FindMagic(nMagIdx);
end;

function TUserManage.AddMagic(Magic: pTMagic): Boolean;
begin
  Result := EngineOut.TUserEngine_AddMagic(Magic);
end;

function TUserManage.DelMagic(nMagIdx: Integer): Boolean;
begin
  Result := EngineOut.TUserEngine_DelMagic(nMagIdx);
end;

procedure TUserManage.RandomUpgradeItem(Item: pTUserItem);
begin
  EngineOut.TUserEngine_RandomUpgradeItem(Item);
end;

procedure TUserManage.GetUnknowItemValue(Item: pTUserItem);
begin
  EngineOut.TUserEngine_GetUnknowItemValue(Item);
end;

procedure TUserManage.RandomUpgradeItem_(Item: pTUserItem);
begin
  EngineOut.TUserEngine_RandomUpgradeItem_(Item);
end;

procedure TUserManage.GetUnknowItemValue_(Item: pTUserItem);
begin
  EngineOut.TUserEngine_GetUnknowItemValue_(Item);
end;

procedure TUserManage.GetItemAddValue(UserItem: pTUserItem; var StdItem: TStdItem);
begin
  EngineOut.ItemUnit_GetItemAddValue(UserItem, StdItem);
end;

function TUserManage.GetStdItem(Index: Integer): pTStdItem;
begin
  Result := EngineOut.TUserEngine_GetStdItemByIndex(Index);
end;

function TUserManage.GetStdItemList: TList;
begin
  Result := TList(EngineOut.TUserEngine_GetStdItemList());
end;

function TUserManage.GetPlayObjectCount: Integer;
begin
  Result := EngineOut.TUserEngine_GetPlayObjectCount;
end;

constructor TUserManage.Create();
begin
  UserEngine := nil;
end;

destructor TUserManage.Destroy;
begin
  inherited;
end;

end.
