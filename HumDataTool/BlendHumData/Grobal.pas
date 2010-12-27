unit Grobal;

interface
uses
  Windows, Classes, JSocket, Controls;
{$DEFINE HEROVERSION}
const
  CLIENT_VERSION_NUMBER = 120090510; //版本号
//==============================================================================
  ACCOUNTLEN = 30;
  MAXPATHLEN = 255;
  DIRPATHLEN = 80;
  MAPNAMELEN = 16;
  ACTORNAMELEN = 14;
  DEFBLOCKSIZE = 16;
  BUFFERSIZE = 10000;
  DATA_BUFSIZE2 = 16348; //8192;
  DATA_BUFSIZE = 8192; //8192;
  GROUPMAX = 11;
  BAGGOLD = 5000000;
  BODYLUCKUNIT = 10;
  MAX_STATUS_ATTRIBUTE = 12;

type
  TNewStatus = (sNone, sBlind, sConfusion); //失明 混乱 状态

  TValue = array[0..13] of Byte;

  TStdItem = packed record
{$IFDEF HEROVERSION}
    Name: string[30];
{$ELSE}
    Name: string[14];
{$ENDIF}
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
{$IFDEF HEROVERSION}
    AddValue: TValue;
    AddPoint: TValue;
    MaxDate: TDateTime;
    //sDescr: string[40];
{$ENDIF}
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
  pTClientItem = ^TClientItem;

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

  THumMagic = record
    wMagIdx: Word;
    btLevel: Byte;
    btKey: Byte;
    nTranPoint: Integer; //当前持久值
  end;
  pTHumMagic = ^THumMagic;

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
{$IFDEF HEROVERSION}
    Level: LongInt; //0x198  //0x34  0x00
{$ELSE}
    Level: Word; //0x198  //0x34  0x00
{$ENDIF}
    AC: Integer; //0x19A  //0x36  0x02
    MAC: Integer; //0x19C  //0x38  0x04
    DC: Integer; //0x19E  //0x3A  0x06
    MC: Integer; //0x1A0  //0x3C  0x08
    SC: Integer; //0x1A2  //0x3E  0x0A
{$IFDEF HEROVERSION}
    HP: LongInt; //0x1A4  //0x40  0x0C
    MP: LongInt; //0x1A6  //0x42  0x0E
    MaxHP: LongInt; //0x1A8  //0x44  0x10
    MaxMP: LongInt; //0x1AA  //0x46  0x12
{$ELSE}
    HP: Word; //0x1A4  //0x40  0x0C
    MP: Word; //0x1A6  //0x42  0x0E
    MaxHP: Word; //0x1A8  //0x44  0x10
    MaxMP: Word; //0x1AA  //0x46  0x12
{$ENDIF}
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
  end;
  pTAbility = ^TAbility;

  TOAbility = packed record
{$IFDEF HEROVERSION}
    Level: LongInt; //0x198  //0x34  0x00
{$ELSE}
    Level: Word; //0x198  //0x34  0x00
{$ENDIF}
    AC: Word;
    MAC: Word;
    DC: Word;
    MC: Word;
    SC: Word;
{$IFDEF HEROVERSION}
    HP: LongInt; //0x1A4  //0x40  0x0C
    MP: LongInt; //0x1A6  //0x42  0x0E
    MaxHP: LongInt; //0x1A8  //0x44  0x10
    MaxMP: LongInt; //0x1AA  //0x46  0x12
{$ELSE}
    HP: Word; //0x1A4  //0x40  0x0C
    MP: Word; //0x1A6  //0x42  0x0E
    MaxHP: Word; //0x1A8  //0x44  0x10
    MaxMP: Word; //0x1AA  //0x46  0x12
{$ENDIF}
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

  TOUserItem = packed record
    MakeIndex: Integer;
    wIndex: Word; //物品id
    Dura: Word; //当前持久值
    DuraMax: Word; //最大持久值
    btValue: TValue; //array[0..13] of Byte;
  end;
  pTOUserItem = ^TOUserItem;


  TUserItem = packed record
    MakeIndex: Integer;
    wIndex: Word; //物品id
    Dura: Word; //当前持久值
    DuraMax: Word; //最大持久值
    btValue: TValue; //array[0..13] of Byte;
{$IFDEF HEROVERSION}
    AddValue: TValue;
    AddPoint: TValue;
    btValue2: TValue;
    MaxDate: TDateTime;
{$ENDIF}
  end;
  pTUserItem = ^TUserItem;

  TSellOffHeader = record
    nItemCount: Integer;
  end;

  TSellOffInfo = packed record //Size 59    拍卖数据结构
    sCharName: string[ACTORNAMELEN];
    dSellDateTime: TDateTime;
    nSellGold: Integer;
    n: Integer;
    UseItems: TUserItem;
    nIndex: Integer;
  end;
  pTSellOffInfo = ^TSellOffInfo;

  TClientSellItem = packed record
    //boSelled: Boolean;
    sCharName: string[ACTORNAMELEN];
    dSellDateTime: TDateTime;
    SellItem: TClientItem;
  end;
  pTClientSellItem = ^TClientSellItem;

  TItemCount = Integer;

  TBigStorage = packed record //无限仓库数据结构
    boDelete: Boolean;
    sCharName: string[ACTORNAMELEN];
    SaveDateTime: TDateTime;
    UseItems: TUserItem;
    nIndex: Integer;
  end;
  pTBigStorage = ^TBigStorage;

  TDuelItem = packed record //挑战
    boFinish: Boolean; //挑战完成
    boDelete: Boolean;
    btDuel: Byte;
    sOwnerName: string[ACTORNAMELEN];
    sDuelName: string[ACTORNAMELEN];
    UseItem: TUserItem;
    n01: Integer;
    n02: Integer;
    nIndex: Integer;
  end;
  pTDuelItem = ^TDuelItem;

  TDuel = packed record //挑战
    boDelete: Boolean;
    boVictory: Boolean; //胜利
    sCharName: string[ACTORNAMELEN];
    nDuelGold: Integer;
    nItemCount: Integer;
    n01: Integer;
    n02: Integer;
  end;
  pTDuel = ^TDuel;

  TDuelInfo = packed record //挑战
    boDelete: Boolean;
    btDuel: Byte;
    SaveDateTime: TDateTime;
    Owner: TDuel; //主动挑战人
    Duel: TDuel; //被动挑战人
    boFinish: Boolean; //挑战完成
    n03: Integer;
    n04: Integer;
    nIndex: Integer;
  end;
  pTDuelInfo = ^TDuelInfo;

  //摆摊
  TItemIndex = record
    btSellType: Byte; //0金币 1元宝 2声望 3能量
    ItemName: string[30];
    MakeIndex: Integer;
    Price: Integer;
  end;
  pTItemIndex = ^TItemIndex;

  TItemIndexs = array[0..14] of TItemIndex;
  pTItemIndexs = ^TItemIndexs;

  TStoreServerItem = record
    btSellType: Byte; //0金币 1元宝 2声望 3能量
    Price: Integer;
    UserItem: pTUserItem;
  end;
  pTStoreServerItem = ^TStoreServerItem;

  TStoreItem = record
    btSellType: Byte; //0金币 1元宝 2声望 3能量
    Item: TClientItem;
  end;
  pTStoreItem = ^TStoreItem;

  TUserStoreStateInfo = record
    RecogId: Integer;
    UserName: string[30];
    NAMECOLOR: Integer;
    SellMsg: string[30];
    UseItems: array[0..14] of TStoreItem;
  end;
  pTUserStoreStateInfo = ^TUserStoreStateInfo;

  TBindItemFile = record
    btItemType: Byte;
    sItemName: string;
    sBindItemName: string;
  end;
  pTBindItemFile = ^TBindItemFile;

  TBindItem = record
    sUnbindItemName: string[ACTORNAMELEN];
    nStdMode: Integer;
    nShape: Integer;
    btItemType: Byte;
  end;
  pTBindItem = ^TBindItem;


  TIDRecordHeader = packed record
    boDeleted: Boolean;
    bt1: Byte;
    bt2: Byte;
    bt3: Byte;
    CreateDate: TDateTime;
    UpdateDate: TDateTime;
    sAccount: string[ACCOUNTLEN];
  end;
  pTIDRecordHeader = ^TIDRecordHeader;

  TRecordHeader = packed record //Size 12
    boDeleted: Boolean;
    nSelectID: Byte;
    boIsHero: Boolean;
    bt2: Byte;
    dCreateDate: TDateTime; //创建时间
    sName: string[15]; //0x15  //角色名称   28
  end;
  pTRecordHeader = ^TRecordHeader;


  THumInfo = packed record //Size 72
    Header: TRecordHeader;
    sChrName: string[14]; //0x14  //角色名称   44
    sAccount: string[ACCOUNTLEN]; //账号
    boDeleted: Boolean; //是否删除
    boIsHero: Boolean;
    dModDate: TDateTime;
    btCount: Byte; //操作计次
    boSelected: Boolean; //是否选择
    n6: array[0..5] of Byte;
  end;
  pTHumInfo = ^THumInfo;



  TUnKnow = array[0..35] of Byte;

  TAddByte = array[0..16] of Byte;

  TQuestUnit = array[0..127] of Byte;
  TQuestFlag = array[0..127] of Byte;
  TStatusTime = array[0..MAX_STATUS_ATTRIBUTE - 1] of Word;

  TOHumItems = array[0..8] of TOUserItem;
  TOHumAddItems = array[9..12] of TOUserItem;
  TOBagItems = array[0..45] of TOUserItem;
  TOStorageItems = array[0..45] of TOUserItem;
  TOHumanUseItems = array[0..12] of TOUserItem;
  TOHumMagics = array[0..19] of THumMagic;

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

  pTOHumItems = ^TOHumItems;
  pTOBagItems = ^TOBagItems;
  pTOStorageItems = ^TOStorageItems;
  pTOHumAddItems = ^TOHumAddItems;

  pTOHumMagics = ^TOHumMagics;

{$IFDEF HEROVERSION}
  THumData = packed record //Size = 3164
    sChrName: string[ACTORNAMELEN];
    sCurMap: string[MAPNAMELEN];
    wCurX: Word;
    wCurY: Word;
    btDir: Byte;
    btHair: Byte;
    btSex: Byte;
    btJob: Byte;
    nGold: Integer;
    Abil: TOAbility; //+40
    wStatusTimeArr: TStatusTime; //+24
    sHomeMap: string[MAPNAMELEN];
    wHomeX: Word;
    wHomeY: Word;
    sDearName: string[ACTORNAMELEN];
    sMasterName: string[ACTORNAMELEN];
    boMaster: Boolean;
    btCreditPoint: Integer;
    btDivorce: Byte; //是否结婚
    btMarryCount: Byte; //结婚次数
    sStoragePwd: string[7];
    btReLevel: Byte;
    boOnHorse: Boolean;
    BonusAbil: TNakedAbility; //+20
    nBonusPoint: Integer;
    nGameGold: Integer;
    nGamePoint: Integer;
    nGameDiamond: Integer; //金刚石
    nGameGird: Integer; //灵符
    nGameGlory: Integer; //荣誉
    nPayMentPoint: Integer; //充值点
    nPKPOINT: Integer;
    btAllowGroup: Byte;
    btF9: Byte;
    btAttatckMode: Byte;
    btIncHealth: Byte;
    btIncSpell: Byte;
    btIncHealing: Byte;
    btFightZoneDieCount: Byte;
    sAccount: string[ACCOUNTLEN];
    btEE: Byte;
    btEF: Byte;
    boLockLogon: Boolean;
    wContribution: Word;
    nHungerStatus: Integer;
    boAllowGuildReCall: Boolean; //  是否允许行会合一
    wGroupRcallTime: Word; //队传送时间
    dBodyLuck: Double; //幸运度  8
    boAllowGroupReCall: Boolean; // 是否允许天地合一
    nEXPRATE: Integer; //经验倍数
    nExpTime: Integer; //经验倍数时间
    btLastOutStatus: Byte; //2006-01-12增加 退出状态 1为死亡退出
    wMasterCount: Word; //出师徒弟数
    boHasHero: Boolean; //是否有英雄
    boIsHero: Boolean; //是否是英雄
    btStatus: Byte; //状态
    sHeroChrName: string[ACTORNAMELEN];
    nGrudge: Integer;
    QuestFlag: TQuestFlag; //脚本变量
    NewStatus: TNewStatus; //1失明 2混乱 状态
    wStatusDelayTime: Word; //失明混乱时间
    AddByte: TAddByte;
    HumItems: THumItems; //9格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
    BagItems: TBagItems; //包裹装备
    HumMagics: THumMagics; //魔法
    StorageItems: TStorageItems; //仓库物品
    HumAddItems: THumAddItems; //新增4格 护身符 腰带 鞋子 宝石
  end;
  pTHumData = ^THumData;
{$ELSE}
  THumData = packed record //Size = 3164
    sChrName: string[ACTORNAMELEN];
    sCurMap: string[MAPNAMELEN];
    wCurX: Word;
    wCurY: Word;
    btDir: Byte;
    btHair: Byte;
    btSex: Byte;
    btJob: Byte;
    nGold: Integer;
    Abil: TOAbility; //+40
    wStatusTimeArr: TStatusTime; //+24
    sHomeMap: string[MAPNAMELEN];
    btUnKnow1: Byte;
    wHomeX: Word;
    wHomeY: Word;
    sDearName: string[ACTORNAMELEN];
    sMasterName: string[ACTORNAMELEN];
    boMaster: Boolean;
    btCreditPoint: Byte;
    btDivorce: Byte; //是否结婚
    btMarryCount: Byte; //结婚次数
    sStoragePwd: string[7];
    btReLevel: Byte;
    boOnHorse: Boolean;
    btUnKnow2: array[0..1] of Byte;
    BonusAbil: TNakedAbility; //+20
    nBonusPoint: Integer;
    nGameGold: Integer;
    nGamePoint: Integer;
    nPayMentPoint: Integer; //充值点
    n: Integer;
    nPKPOINT: Integer;
    btAllowGroup: Byte;
    btF9: Byte;
    btAttatckMode: Byte;
    btIncHealth: Byte;
    btIncSpell: Byte;
    btIncHealing: Byte;
    btFightZoneDieCount: Byte;
    sAccount: string[10];
    btEE: Byte;
    btEF: Byte;
    boLockLogon: Boolean;
    wContribution: Word;
    nHungerStatus: Integer;
    boAllowGuildReCall: Boolean; //  是否允许行会合一
    wGroupRcallTime: Word; //队传送时间
    dBodyLuck: Double; //幸运度  8
    boAllowGroupReCall: Boolean; // 是否允许天地合一
    nEXPRATE: Integer; //经验倍数
    nExpTime: Integer; //经验倍数时间
    btLastOutStatus: Byte; //2006-01-12增加 退出状态 1为死亡退出
    wMasterCount: Word; //出师徒弟数
    boHasHero: Boolean; //是否有英雄
    boIsHero: Boolean; //是否是英雄
    btStatus: Byte; //状态
    sHeroChrName: string[ACTORNAMELEN];
    nGrudge: Integer;
    UnKnow: TUnKnow;
    QuestFlag: TQuestFlag; //脚本变量

    HumItems: THumItems; //9格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
    BagItems: TBagItems; //包裹装备
    HumMagics: THumMagics; //魔法
    StorageItems: TStorageItems; //仓库物品
    HumAddItems: THumAddItems; //新增4格 护身符 腰带 鞋子 宝石
  end;
  pTHumData = ^THumData;
{$ENDIF}

  THumDataInfo = packed record //Size 3164
    Header: TRecordHeader;
    Data: THumData;
  end;
  pTHumDataInfo = ^THumDataInfo;

  TRememberItem = record
    sMapName: string[MAPNAMELEN];
    nCurrX: Integer;
    nCurrY: Integer;
  end;
  pTRememberItem = ^TRememberItem;

  TItemEvent = record
    sItemName: string[ACTORNAMELEN];
    nMakeIndex: Integer;
    RememberItem: array[0..5] of TRememberItem;
  end;
  pTItemEvent = ^TItemEvent;

  TRecordDeletedHeader = packed record
    boDeleted: Boolean;
    bt1: Byte;
    bt2: Byte;
    bt3: Byte;
    CreateDate: TDateTime;
    LastLoginDate: TDateTime;
    n14: Integer;
    nNextDeletedIdx: Integer;
    //    sAccount   :String[11];//0x14
  end;

  TUserEntry = packed record
    sAccount: string[ACCOUNTLEN];
    sPassword: string[16];
    sUserName: string[20];
    sSSNo: string[14];
    sPhone: string[14];
    sQuiz: string[20];
    sAnswer: string[12];
    sEMail: string[40];
  end;

  TUserEntryAdd = packed record
    sQuiz2: string[20];
    sAnswer2: string[12];
    sBirthDay: string[10];
    sMobilePhone: string[13];
    sMemo: string[20];
    sMemo2: string[20];
  end;

  TAccountDBRecord = packed record
    Header: TIDRecordHeader;
    UserEntry: TUserEntry;
    UserEntryAdd: TUserEntryAdd;
    nErrorCount: Integer;
    dwActionTick: LongWord;
    dwCreateTick: LongWord;
    n: array[0..34] of Byte;
  end;
  pTAccountDBRecord = ^TAccountDBRecord;

implementation


end.

