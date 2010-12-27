unit Grobal;

interface
uses
  Windows, Classes, Controls;
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
  BAGGOLD = 5000000;
  BODYLUCKUNIT = 10;
  MAX_STATUS_ATTRIBUTE = 12;
type
  TValue = array[0..13] of Byte;
  TItemCount = Integer;
  TOAbility = packed record
    Level: word;
    AC: word;
    MAC: word;
    DC: word;
    MC: word;
    SC: word;
    HP: word;
    MP: word;
    MaxHP: word;
    MaxMP: word;
    btReserved1: Byte;
    btReserved2: Byte;
    btReserved3: Byte;
    btReserved4: Byte;
    Exp: LongWord;
    MaxExp: LongWord;
    Weight: word;
    MaxWeight: word; //背包
    WearWeight: Byte;
    MaxWearWeight: Byte; //负重
    HandWeight: Byte;
    MaxHandWeight: Byte; //腕力
  end;
  pTOAbility = ^TOAbility;

  TNakedAbility = packed record //Size 20
    DC: word;
    MC: word;
    SC: word;
    AC: word;
    MAC: word;
    HP: word;
    MP: word;
    Hit: word;
    Speed: word;
    X2: word;
  end;
  pTNakedAbility = ^TNakedAbility;

  THumMagic = record
    wMagIdx: word;
    btLevel: Byte;
    btKey: Byte;
    nTranPoint: Integer; //当前持久值
  end;
  pTHumMagic = ^THumMagic;

  TUserItem = packed record
    MakeIndex: Integer;
    wIndex: word; //物品id
    Dura: word; //当前持久值
    DuraMax: word; //最大持久值
    btValue: TValue; //array[0..13] of Byte;
    AddValue: TValue;
    MaxDate: TDateTime;
  end;
  pTUserItem = ^TUserItem;

  TOUserItem = packed record
    MakeIndex: Integer;
    wIndex: word; //物品id
    Dura: word; //当前持久值
    DuraMax: word; //最大持久值
    btValue: TValue; //array[0..13] of Byte;
  end;
  pTOUserItem = ^TOUserItem;

  TBigStorage = packed record //无限仓库数据结构
    boDelete: Boolean;
    sCharName: string[ACTORNAMELEN];
    SaveDateTime: TDateTime;
    UseItems: TUserItem;
    nIndex: Integer;
  end;
  pTBigStorage = ^TBigStorage;

  TOBigStorage = packed record //无限仓库数据结构
    boDelete: Boolean;
    sCharName: string[ACTORNAMELEN];
    SaveDateTime: TDateTime;
    UseItems: TOUserItem;
    nIndex: Integer;
  end;
  pTOBigStorage = ^TOBigStorage;

  TSellOffInfo = packed record //Size 59    拍卖数据结构
    sCharName: string[ACTORNAMELEN];
    dSellDateTime: TDateTime;
    nSellGold: Integer;
    n: Integer;
    UseItems: TUserItem;
    nIndex: Integer;
  end;
  pTSellOffInfo = ^TSellOffInfo;

  TOSellOffInfo = packed record //Size 59    拍卖数据结构
    sCharName: string[ACTORNAMELEN];
    dSellDateTime: TDateTime;
    nSellGold: Integer;
    n: Integer;
    UseItems: TOUserItem;
    nIndex: Integer;
  end;
  pTOSellOffInfo = ^TOSellOffInfo;

  TRecordHeader = packed record //Size 12
    boDeleted: Boolean;
    nSelectID: Byte;
    boIsHero: Boolean;
    bt2: Byte;
    dCreateDate: TDateTime; //创建时间
    sName: string[15]; //0x15  //角色名称   28
  end;
  pTRecordHeader = ^TRecordHeader;

  TUnKnow = array[0..35] of Byte;
  TQuestUnit = array[0..127] of Byte;
  TQuestFlag = array[0..127] of Byte;
  TStatusTime = array[0..MAX_STATUS_ATTRIBUTE - 1] of word;

  THumItems = array[0..8] of TUserItem;
  THumAddItems = array[9..12] of TUserItem;
  TBagItems = array[0..45] of TUserItem;
  TStorageItems = array[0..45] of TUserItem;
  THumMagics = array[0..19] of THumMagic;
  THumanUseItems = array[0..12] of TUserItem;
  THeroItems = array[0..12] of TUserItem;
  THeroBagItems = array[0..40 - 1] of TUserItem;

  TOHumItems = array[0..8] of TOUserItem;
  TOHumAddItems = array[9..12] of TOUserItem;
  TOBagItems = array[0..45] of TOUserItem;
  TOStorageItems = array[0..45] of TOUserItem;
  //TOHumMagics = array[0..19] of TOHumMagic;
  TOHumanUseItems = array[0..12] of TOUserItem;
  TOHeroItems = array[0..12] of TOUserItem;
  TOHeroBagItems = array[0..40 - 1] of TOUserItem;

  pTHeroItems = ^THeroItems;
  pTHumItems = ^THumItems;
  pTBagItems = ^TBagItems;
  pTStorageItems = ^TStorageItems;
  pTHumAddItems = ^THumAddItems;
  pTHumMagics = ^THumMagics;
  pTHeroBagItems = ^THeroBagItems;

  pTOHeroItems = ^TOHeroItems;
  pTOHumItems = ^TOHumItems;
  pTOBagItems = ^TOBagItems;
  pTOStorageItems = ^TOStorageItems;
  pTOHumAddItems = ^TOHumAddItems;
  //pTOHumMagics = ^THumMagics;
  pTOHeroBagItems = ^TOHeroBagItems;

  TData = packed record //Size = 3164
    sChrName: string[ACTORNAMELEN];
    sCurMap: string[MAPNAMELEN];
    wCurX: word;
    wCurY: word;
    btDir: Byte;
    btHair: Byte;
    btSex: Byte;
    btJob: Byte;
    nGold: Integer;
    abil: TOAbility; //+40
    wStatusTimeArr: TStatusTime; //+24
    sHomeMap: string[MAPNAMELEN];
    btUnKnow1: Byte;
    wHomeX: word;
    wHomeY: word;
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
    wContribution: word;
    nHungerStatus: Integer;
    boAllowGuildReCall: Boolean; //  是否允许行会合一
    wGroupRcallTime: word; //队传送时间
    dBodyLuck: Double; //幸运度  8
    boAllowGroupReCall: Boolean; // 是否允许天地合一
    nEXPRATE: Integer; //经验倍数
    nExpTime: Integer; //经验倍数时间
    btLastOutStatus: Byte; //2006-01-12增加 退出状态 1为死亡退出
    wMasterCount: word; //出师徒弟数
    boHasHero: Boolean; //是否有英雄
    boIsHero: Boolean; //是否是英雄
    btStatus: Byte; //状态
    sHeroChrName: string[ACTORNAMELEN];
    nGrudge: Integer;
    UnKnow: TUnKnow;
    QuestFlag: TQuestFlag; //脚本变量
  end;

  pTHumData = ^THumData;
  THumData = packed record //Size = 3164
    Data: TData;
    HumItems: THumItems; //9格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
    BagItems: TBagItems; //包裹装备
    HumMagics: THumMagics; //魔法
    StorageItems: TStorageItems; //仓库物品
    HumAddItems: THumAddItems; //新增4格 护身符 腰带 鞋子 宝石
  end;

  pTOHumData = ^TOHumData;
  TOHumData = packed record //Size = 3164
    Data: TData;
    HumItems: TOHumItems; //9格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
    BagItems: TOBagItems; //包裹装备
    HumMagics: THumMagics; //魔法
    StorageItems: TOStorageItems; //仓库物品
    HumAddItems: TOHumAddItems; //新增4格 护身符 腰带 鞋子 宝石
  end;

  THumDataInfo = packed record //Size 3164
    Header: TRecordHeader;
    Data: THumData;
  end;
  pTHumDataInfo = ^THumDataInfo;

  TOHumDataInfo = packed record //Size 3164
    Header: TRecordHeader;
    Data: TOHumData;
  end;
  pTOHumDataInfo = ^TOHumDataInfo;

implementation

end.

