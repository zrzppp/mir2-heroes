unit PlugOfEngine;

interface
uses
  Windows, Classes, SysUtils, Forms, Grobal2, SDK, ObjBase, ObjActor, ObjHero, Envir, Guild, ObjNpc,
  Castle, UsrEngn, Magic, LocalDB, EncryptUnit, Common, PlugIn, RunSock;

type
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
  _TUserEngine_GetPlayObjectFreeList = function: TList; stdcall;
  _TUserEngine_GetLoadPlayCount = function: Integer; stdcall;
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

  _TUserEngine_GetMaxPlayObjectCount = function: Integer; stdcall;
  _TUserEngine_SetMaxPlayObjectCount = procedure(Buffer: PChar; nLen: Integer); stdcall;

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

  TPlugEngine = record
    AppHandle: THandle;
    Module: THandle;
    MsgProc: TMsgProc;
    PlugInManage: TPlugInManage;
    UserEngine: TUserEngine;
    EngineOut: TEngineOut;
    Buffer: PChar;
  end;
  pTPlugEngine = ^TPlugEngine;

  {TPlugEngine = record
    AppHandle: THandle;
    //IconHandle: THandle;
    Module: THandle;
    MsgProc: TMsgProc;
    PlugInManage: TPlugInManage;
    UserEngine: TUserEngine;
    EngineOut: TEngineOut;
    Buffer: PChar;
  end;
  pTPlugEngine = ^TPlugEngine; }

  TPlugInit = function(PlugEngine: pTPlugEngine): PChar; stdcall;

function TList_Create: TList; stdcall;
procedure TList_Free(List: TList); stdcall;
function TList_Count(List: TList): Integer; stdcall;
function TList_Add(List: TList; Item: Pointer): Integer; stdcall;
procedure TList_Insert(List: TList; nIndex: Integer; Item: Pointer); stdcall;
function TList_Get(List: TList; nIndex: Integer): Pointer; stdcall;
procedure TList_Put(List: TList; nIndex: Integer; Item: Pointer); stdcall;
procedure TList_Delete(List: TList; nIndex: Integer); stdcall;
procedure TList_Clear(List: TList); stdcall;
procedure TList_Exchange(List: TList; nIndex1, nIndex2: Integer); stdcall;
function TStringList_Create(): TStringList; stdcall;
procedure TStringList_Free(List: TStringList); stdcall;
function TStringList_Count(List: TStringList): Integer; stdcall;
function TStringList_Add(List: TStringList; s: PChar): Integer; stdcall;
function TStringList_AddObject(List: TStringList; s: PChar; AObject: TObject): Integer; stdcall;
procedure TStringList_Insert(List: TStringList; nIndex: Integer; s: PChar); stdcall;
function TStringList_Get(List: TStringList; nIndex: Integer): PChar; stdcall;
function TStringList_GetObject(List: TStringList; nIndex: Integer): TObject; stdcall;
procedure TStringList_Put(List: TStringList; nIndex: Integer; s: PChar); stdcall;
procedure TStringList_PutObject(List: TStringList; nIndex: Integer; AObject: TObject); stdcall;
procedure TStringList_Delete(List: TStringList; nIndex: Integer); stdcall;
procedure TStringList_Clear(List: TStringList); stdcall;
procedure TStringList_Exchange(List: TStringList; nIndex1, nIndex2: Integer); stdcall;
procedure TStringList_LoadFormFile(List: TStringList; pszFileName: PChar); stdcall;
procedure TStringList_SaveToFile(List: TStringList; pszFileName: PChar); stdcall;

procedure MainOutMessageAPI(pszMsg: PChar); stdcall;
procedure AddGameDataLogAPI(pszMsg: PChar); stdcall;
function GetGameGoldName(): PTShortString; stdcall;
procedure EDcode_Decode6BitBuf(pszSource: PChar; pszDest: PChar; nSrcLen, nDestLen: Integer); stdcall;
procedure EDcode_Encode6BitBuf(pszSource: PChar; pszDest: PChar; nSrcLen, nDestLen: Integer); stdcall;
procedure EDcode_DeCodeString(pszSource: PChar; pszDest: PChar); stdcall;
procedure EDcode_EncodeString(pszSource: PChar; pszDest: PChar); stdcall;
procedure EDcode_EncodeBuffer(Buf: PChar; bufsize: Integer; pszDest: PChar); stdcall;
procedure EDcode_DecodeBuffer(pszSource: PChar; pszDest: PChar; bufsize: Integer); stdcall;

function TConfig_sEnvirDir(): _LPTDIRNAME; stdcall;
function TConfig_AmyOunsulPoint: PInteger; stdcall;

function TActorObject_Create(): TActorObject; stdcall;
procedure TActorObject_Free(BaseObject: TActorObject); stdcall;
function TActorObject_sMapFileName(BaseObject: TActorObject): PTShortString; stdcall;
function TActorObject_sMapName(BaseObject: TActorObject): PTShortString; stdcall;
function TActorObject_sMapNameA(BaseObject: TActorObject): _LPTMAPNAME; stdcall;
function TActorObject_sCharName(BaseObject: TActorObject): PTShortString; stdcall;
function TActorObject_sCharNameA(BaseObject: TActorObject): _LPTACTORNAME; stdcall;

function TActorObject_nCurrX(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_nCurrY(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_btDirection(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_btGender(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_btHair(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_btJob(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_nGold(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_Ability(BaseObject: TActorObject): pTAbility; stdcall;

function TActorObject_WAbility(BaseObject: TActorObject): pTAbility; stdcall;
function TActorObject_nCharStatus(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_sHomeMap(BaseObject: TActorObject): PTShortString; stdcall;
function TActorObject_nHomeX(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_nHomeY(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_boOnHorse(BaseObject: TActorObject): PBoolean; stdcall;
function TActorObject_btHorseType(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_btDressEffType(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_nPkPoint(BaseObject: TActorObject): PInteger; stdcall;

function TActorObject_duBodyLuck(BaseObject: TActorObject): PDouble; stdcall;
function TActorObject_nBodyLuckLevel(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_nFightZoneDieCount(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_nBonusPoint(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_nCharStatusEx(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_dwFightExp(BaseObject: TActorObject): PLongWord; stdcall;
function TActorObject_nViewRange(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_wAppr(BaseObject: TActorObject): PWord; stdcall;
function TActorObject_btRaceServer(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_btRaceImg(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_btHitPoint(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_nHitPlus(BaseObject: TActorObject): PShortInt; stdcall;
function TActorObject_nHitDouble(BaseObject: TActorObject): PShortInt; stdcall;
function TActorObject_boRecallSuite(BaseObject: TActorObject): PBoolean; stdcall;
function TActorObject_nHealthRecover(BaseObject: TActorObject): PShortInt; stdcall;
function TActorObject_nSpellRecover(BaseObject: TActorObject): PShortInt; stdcall;
function TActorObject_btAntiPoison(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_nPoisonRecover(BaseObject: TActorObject): PShortInt; stdcall;
function TActorObject_nAntiMagic(BaseObject: TActorObject): PShortInt; stdcall;
function TActorObject_nLuck(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_nPerHealth(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_nPerHealing(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_nPerSpell(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_btGreenPoisoningPoint(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_nGoldMax(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_btSpeedPoint(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_btPermission(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_nHitSpeed(BaseObject: TActorObject): PShortInt; stdcall;
function TActorObject_TargetCret(BaseObject: TActorObject): PTActorObject; stdcall;
function TActorObject_LastHiter(BaseObject: TActorObject): PTActorObject; stdcall;
function TActorObject_ExpHiter(BaseObject: TActorObject): PTActorObject; stdcall;

function TActorObject_btLifeAttrib(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_nSlaveType(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_Master(BaseObject: TActorObject): PTActorObject; stdcall;
function TActorObject_btAttatckMode(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_btNameColor(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_nLight(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_ItemList(BaseObject: TActorObject): TList; stdcall;
function TActorObject_MagicList(BaseObject: TActorObject): TList; stdcall;
function TActorObject_MyGuild(BaseObject: TActorObject): TGUild; stdcall;
function TActorObject_UseItems(BaseObject: TActorObject): pTHumanUseItems; stdcall;
function TActorObject_btMonsterWeapon(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_PEnvir(BaseObject: TActorObject): PTEnvirnoment; stdcall;
function TActorObject_boGhost(BaseObject: TActorObject): PBoolean; stdcall;
function TActorObject_boDeath(BaseObject: TActorObject): PBoolean; stdcall;
function TActorObject_DeleteBagItem(BaseObject: TActorObject; UserItem: pTUserItem): BOOL; stdcall;
function TActorObject_AddCustomData(BaseObject: TActorObject; Data: Pointer): Integer; stdcall;
function TActorObject_GetCustomData(BaseObject: TActorObject; nIndex: Integer): Pointer; stdcall;
procedure TActorObject_SendMsg(SelfObject, BaseObject: TActorObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: PChar); stdcall;
procedure TActorObject_SendRefMsg(BaseObject: TActorObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: PChar); stdcall;
procedure TActorObject_SendDelayMsg(SelfObject, BaseObject: TActorObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: PChar; dwDelayTime: LongWord); stdcall;

procedure TActorObject_SysMsg(BaseObject: TActorObject; pszMsg: PChar; MsgColor: TMsgColor; MsgType: TMsgType); stdcall;
function TActorObject_GetFrontPosition(BaseObject: TActorObject; var nX: Integer; var nY: Integer): Boolean; stdcall;
function TActorObject_GetRecallXY(BaseObject: TActorObject; nX, nY: Integer; nRange: Integer; var nDX: Integer; var nDY: Integer): Boolean; stdcall;
procedure TActorObject_SpaceMove(BaseObject: TActorObject; pszMap: PChar; nX, nY: Integer; nInt: Integer); stdcall;
procedure TActorObject_FeatureChanged(BaseObject: TActorObject); stdcall;
procedure TActorObject_StatusChanged(BaseObject: TActorObject); stdcall;
function TActorObject_GetFeatureToLong(BaseObject: TActorObject): Integer; stdcall;
function TActorObject_GetFeature(SelfObject, BaseObject: TActorObject): Integer; stdcall;
function TActorObject_GetCharColor(SelfObject, BaseObject: TActorObject): Byte; stdcall;
function TActorObject_GetNamecolor(BaseObject: TActorObject): Byte; stdcall;
procedure TActorObject_GoldChanged(BaseObject: TActorObject); stdcall;
procedure TActorObject_GameGoldChanged(BaseObject: TActorObject); stdcall;
function TActorObject_MagCanHitTarget(BaseObject: TActorObject; nX, nY: Integer; TargeTActorObject: TActorObject): Boolean; stdcall;

procedure TActorObject_SetTargetCreat(AObject, BObject: TActorObject); stdcall;
function TActorObject_IsProtectTarget(AObject, BObject: TActorObject): Boolean; stdcall;
function TActorObject_IsAttackTarget(AObject, BObject: TActorObject): Boolean; stdcall;
function TActorObject_IsProperTarget(AObject, BObject: TActorObject): Boolean; stdcall;
function TActorObject_IsProperFriend(AObject, BObject: TActorObject): Boolean; stdcall;
procedure TActorObject_TrainSkillPoint(BaseObject: TActorObject; UserMagic: pTUserMagic; nTranPoint: Integer); stdcall;
function TActorObject_GetAttackPower(BaseObject: TActorObject; nBasePower, nPower: Integer): Integer; stdcall;
function TActorObject_MakeSlave(BaseObject: TActorObject; pszMonName: PChar; nMakeLevel, nExpLevel, nMaxMob, nType: Integer; dwRoyaltySec: LongWord): TActorObject; stdcall;
procedure TActorObject_MakeGhost(BaseObject: TActorObject); stdcall;
procedure TActorObject_RefNameColor(BaseObject: TActorObject); stdcall;
//AddItem 占用内存由自己处理，API内部会自动申请内存
function TActorObject_AddItemToBag(BaseObject: TActorObject; AddItem: pTUserItem): BOOL; stdcall;
procedure TActorObject_ClearBagItem(BaseObject: TActorObject); stdcall;
function TActorObject_GetBaseObjectTick(BaseObject: TActorObject; nCount: Integer): PLongWord; stdcall;

procedure TActorObject_SetHookGetFeature(ObjectActionFeature: TObjectActionFeature); stdcall;
procedure TActorObject_SetHookEnterAnotherMap(EnterAnotherMap: TObjectActionEnterMap); stdcall;
procedure TActorObject_SetHookObjectDie(ObjectDie: TObjectActionEx); stdcall;
procedure TActorObject_SetHookChangeCurrMap(ChangeCurrMap: TObjectActionEx); stdcall;
function TActorObject_GetPoseCreate(BaseObject: TActorObject): TActorObject; stdcall;
function TActorObject_MagMakeDefenceArea(BaseObject: TActorObject; nX, nY, nRange, nSec: Integer; btState: Byte; boState: Boolean): Integer; stdcall;
function TActorObject_MagBubbleDefenceUp(BaseObject: TActorObject; nLevel, nSec: Integer): Boolean; stdcall;

function TPlayObject_AddItemToStorage(PlayObject: TPlayObject; AddItem: pTUserItem): BOOL; stdcall;
procedure TPlayObject_ClearStorageItem(PlayObject: TPlayObject); stdcall;
function TPlayObject_GroupOwner(PlayObject: TPlayObject): TPlayObject; stdcall;
function TPlayObject_GroupMembersList(PlayObject: TPlayObject): TStringList; stdcall;
function TPlayObject_boHearWhisper(PlayObject: TPlayObject): PBoolean; stdcall;
function TPlayObject_boBanShout(PlayObject: TPlayObject): PBoolean; stdcall;
function TPlayObject_boBanGuildChat(PlayObject: TPlayObject): PBoolean; stdcall;
function TPlayObject_boAllowDeal(PlayObject: TPlayObject): PBoolean; stdcall;
function TPlayObject_boAllowGroup(PlayObject: TPlayObject): PBoolean; stdcall;
function TPlayObject_boAllowGuild(PlayObject: TPlayObject): PBoolean; stdcall;
function TPlayObject_nHungerStatus(PlayObject: TPlayObject): PInteger; stdcall;
function TPlayObject_boAllowGuildReCall(PlayObject: TPlayObject): PBoolean; stdcall;
function TPlayObject_wGroupRcallTime(PlayObject: TPlayObject): PWord; stdcall;
function TPlayObject_boAllowGroupReCall(PlayObject: TPlayObject): PBoolean; stdcall;
function TPlayObject_IsEnoughBag(PlayObject: TPlayObject): Boolean; stdcall;
function TPlayObject_nSoftVersionDate(PlayObject: TPlayObject): PInteger; stdcall;
function TPlayObject_nSoftVersionDateEx(PlayObject: TPlayObject): PInteger; stdcall;
function TPlayObject_dLogonTime(PlayObject: TPlayObject): PDateTime; stdcall;
function TPlayObject_dwLogonTick(PlayObject: TPlayObject): PLongWord; stdcall;
function TPlayObject_nMemberType(PlayObject: TPlayObject): PInteger; stdcall;
function TPlayObject_nMemberLevel(PlayObject: TPlayObject): PInteger; stdcall;
function TPlayObject_nGameGold(PlayObject: TPlayObject): PInteger; stdcall;
function TPlayObject_nGamePoint(PlayObject: TPlayObject): PInteger; stdcall;
function TPlayObject_nPayMentPoint(PlayObject: TPlayObject): PInteger; stdcall;
function TPlayObject_nClientFlag(PlayObject: TPlayObject): PInteger; stdcall;
function TPlayObject_nSelectID(PlayObject: TPlayObject): PInteger; stdcall;
function TPlayObject_nClientFlagMode(PlayObject: TPlayObject): PInteger; stdcall;
function TPlayObject_dwClientTick(PlayObject: TPlayObject): PLongWord; stdcall;
function TPlayObject_wClientType(PlayObject: TPlayObject): PWord; stdcall;
function TPlayObject_sBankPassword(PlayObject: TPlayObject): _LPTBANKPWD; stdcall;
function TPlayObject_nBankGold(PlayObject: TPlayObject): PInteger; stdcall;
function TPlayObject_Create(): TPlayObject; stdcall;
procedure TPlayObject_Free(PlayObject: TPlayObject); stdcall;
procedure TPlayObject_SendSocket(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; pszMsg: PChar); stdcall;
procedure TPlayObject_SendDefMessage(PlayObject: TPlayObject; wIdent: Word; nRecog: Integer; nParam, nTag, nSeries: Word; pszMsg: PChar); stdcall;
procedure TPlayObject_SendAddItem(PlayObject: TPlayObject; AddItem: pTUserItem); stdcall;
procedure TPlayObject_SendDelItem(PlayObject: TPlayObject; DelItem: pTUserItem); stdcall;
function TPlayObject_TargetInNearXY(PlayObject: TPlayObject; Target: TActorObject; nX, nY: Integer): Boolean; stdcall;
procedure TPlayObject_SetBankPassword(PlayObject: TPlayObject; pszPassword: PChar); stdcall;
function TPlayObject_MyHero(PlayObject: TPlayObject): PTActorObject; stdcall;

procedure TPlayObject_SetHookCreate(PlayObjectCreate: TObjectAction); stdcall;
function TPlayObject_GetHookCreate(): TObjectAction; stdcall;
procedure TPlayObject_SetHookDestroy(PlayObjectDestroy: TObjectAction); stdcall;
function TPlayObject_GetHookDestroy(): TObjectAction; stdcall;
procedure TPlayObject_SetHookUserLogin1(PlayObjectUserLogin: TObjectAction); stdcall;
procedure TPlayObject_SetHookUserLogin2(PlayObjectUserLogin: TObjectAction); stdcall;
procedure TPlayObject_SetHookUserLogin3(PlayObjectUserLogin: TObjectAction); stdcall;
procedure TPlayObject_SetHookUserLogin4(PlayObjectUserLogin: TObjectAction); stdcall;

procedure TPlayObject_SetHookUserCmd(PlayObjectUserCmd: TObjectUserCmd); stdcall;
function TPlayObject_GetHookUserCmd(): TObjectUserCmd; stdcall;

procedure TPlayObject_SetHookPlayOperateMessage(PlayObjectOperateMessage: TObjectOperateMessage); stdcall;
function TPlayObject_GetHookPlayOperateMessage(): TObjectOperateMessage; stdcall;
procedure TPlayObject_SetHookClientQueryBagItems(ClientQueryBagItems: TObjectAction); stdcall;
procedure TPlayObject_SetHookClientQueryUserState(ClientQueryUserState: TObjectActionXY); stdcall;
procedure TPlayObject_SetHookSendActionGood(SendActionGood: TObjectAction); stdcall;
procedure TPlayObject_SetHookSendActionFail(SendActionFail: TObjectAction); stdcall;

procedure TPlayObject_SetHookSendWalkMsg(ObjectActioinXYD: TObjectActionXYD); stdcall;
procedure TPlayObject_SetHookSendHorseRunMsg(ObjectActioinXYD: TObjectActionXYD); stdcall;
procedure TPlayObject_SetHookSendRunMsg(ObjectActioinXYD: TObjectActionXYD); stdcall;
procedure TPlayObject_SetHookSendDeathMsg(ObjectActioinXYDM: TObjectActionXYDM); stdcall;
procedure TPlayObject_SetHookSendSkeletonMsg(ObjectActioinXYD: TObjectActionXYD); stdcall;
procedure TPlayObject_SetHookSendAliveMsg(ObjectActioinXYD: TObjectActionXYD); stdcall;
procedure TPlayObject_SetHookSendSpaceMoveMsg(ObjectActioinXYDWS: TObjectActionXYDWS); stdcall;
procedure TPlayObject_SetHookSendChangeFaceMsg(ObjectActioinObject: TObjectActionObject); stdcall;
procedure TPlayObject_SetHookSendUseitemsMsg(ObjectActioin: TObjectAction); stdcall;
procedure TPlayObject_SetHookSendUserLevelUpMsg(ObjectActioinObject: TObjectAction); stdcall;
procedure TPlayObject_SetHookSendUserAbilieyMsg(ObjectActioinObject: TObjectAction); stdcall;
procedure TPlayObject_SetHookSendUserStatusMsg(ObjectActioinXYDWS: TObjectActionXYDWS); stdcall;
procedure TPlayObject_SetHookSendUserStruckMsg(ObjectActioinObject: TObjectActionObject); stdcall;
procedure TPlayObject_SetHookSendUseMagicMsg(ObjectActioin: TObjectAction); stdcall;
procedure TPlayObject_SetHookSendSocket(SendSocket: TPlaySendSocket); stdcall;
procedure TPlayObject_SetHookSendGoodsList(SendGoodsList: TObjectActionSendGoods); stdcall;
procedure TPlayObject_SetCheckClientDropItem(ActionDropItem: TObjectActionItem); stdcall;
procedure TPlayObject_SetCheckClientDealItem(ActionItem: TObjectActionItem); stdcall;
procedure TPlayObject_SetCheckClientStorageItem(ActionItem: TObjectActionItem); stdcall;
procedure TPlayObject_SetCheckClientRepairItem(ActionItem: TObjectActionItem); stdcall;
procedure TPlayObject_SetHookCheckUserItems(ObjectActioin: TObjectActionCheckUserItem); stdcall;
procedure TPlayObject_SetHookRun(PlayRun: TObjectAction); stdcall;
procedure TPlayObject_SetHookFilterMsg(FilterMsg: TObjectFilterMsg); stdcall;

procedure TPlayObject_SetCheckClientUpgradeItem(ActionItem: TObjectActionItem); stdcall;
procedure TPlayObject_SetCheckClientSellItem(ActionItem: TObjectActionItem); stdcall;
procedure TActorObject_SetCheckClientNotScatterItem(ActionItem: TObjectActionItem); stdcall;
procedure TActorObject_SetCheckClientDieScatterItem(ActionItem: TObjectActionItem); stdcall;

procedure TPlayObject_SetHookOffLine(ObjectOffLine: TObjectAction); stdcall;

function TPlayObject_IncGold(PlayObject: TPlayObject; nAddGold: Integer): Boolean; stdcall;
procedure TPlayObject_IncGameGold(PlayObject: TPlayObject; nAddGameGold: Integer); stdcall;
procedure TPlayObject_IncGamePoint(PlayObject: TPlayObject; nAddGamePoint: Integer); stdcall;
function TPlayObject_DecGold(PlayObject: TPlayObject; nDecGold: Integer): Boolean; stdcall;
procedure TPlayObject_DecGameGold(PlayObject: TPlayObject; nDECGAMEGOLD: Integer); stdcall;
procedure TPlayObject_DecGamePoint(PlayObject: TPlayObject; nDECGAMEPOINT: Integer); stdcall;
procedure TPlayObject_SetUserInPutInteger(PlayObject: TPlayObject; nData: Integer); stdcall;
procedure TPlayObject_SetUserInPutString(PlayObject: TPlayObject; pszData: PChar); stdcall;
function TPlayObject_PlayUseItems(PlayObject: TPlayObject): pTHumanUseItems; stdcall;

procedure THeroObject_SendAddItem(HeroObject: THeroObject; Item: pTUserItem); stdcall;
procedure THeroObject_SendDelItem(HeroObject: THeroObject; Item: pTUserItem); stdcall;

function TNormNpc_sFilePath(NormNpc: TNormNpc): _LPTPATHNAME; stdcall;
function TNormNpc_sPath(NormNpc: TNormNpc): _LPTPATHNAME; stdcall;
procedure TNormNpc_GetLineVariableText(NormNpc: TNormNpc; BaseObject: TActorObject; pszMsg: PChar; pszOutMsg: PChar; nOutMsgLen: Integer); stdcall;
procedure TNormNpc_SetScriptActionCmd(ActionCmd: TScriptCmd); stdcall;
function TNormNpc_GetScriptActionCmd(): TScriptCmd; stdcall;

procedure TNormNpc_SetScriptConditionCmd(ConditionCmd: TScriptCmd); stdcall;
function TNormNpc_GetScriptConditionCmd(): TScriptCmd; stdcall;

function TNormNpc_GetManageNpc(): TNormNpc; stdcall;
function TNormNpc_GetFunctionNpc(): TNormNpc; stdcall;
procedure TNormNpc_GotoLable(NormNpc: TNormNpc; PlayObject: TPlayObject; pszLabel: PChar); stdcall;

procedure TNormNpc_SetScriptAction(ScriptAction: TScriptAction); stdcall;
function TNormNpc_GetScriptAction(): TScriptAction; stdcall;

procedure TNormNpc_SetScriptCondition(ScriptAction: TScriptCondition); stdcall;
function TNormNpc_GetScriptCondition(): TScriptCondition; stdcall;
function TMerchant_GoodsList(Merchant: TMerchant): TList; stdcall;

function TMerchant_GetItemPrice(Merchant: TMerchant; nIndex: Integer): Integer; stdcall;
function TMerchant_GetUserPrice(Merchant: TMerchant; PlayObject: TPlayObject; nPrice: Integer): Integer; stdcall;
function TMerchant_GetUserItemPrice(Merchant: TMerchant; UserItem: pTUserItem): Integer; stdcall;

procedure TMerchant_SetHookClientGetDetailGoodsList(GetDetailGoods: TObjectActionDetailGoods); stdcall;

procedure TMerchant_SetCheckUserSelect(ObjectActionUserSelect: TObjectActionUserSelect); stdcall;
function TMerchant_GetCheckUserSelect(): TObjectActionUserSelect; stdcall;

function TUserEngine_Create(): TUserEngine; stdcall;
procedure TUserEngine_Free(UserEngine: TUserEngine); stdcall;
function TUserEngine_GetUserEngine(): TUserEngine; stdcall;

function TUserEngine_GetPlayObject(szPlayName: PChar; boGetHide: Boolean): TPlayObject; stdcall;

function TUserEngine_GetLoadPlayList(): TStringList; stdcall;
function TUserEngine_GetPlayObjectList(): TStringList; stdcall;
function TUserEngine_GetLoadPlayCount(): Integer; stdcall;
function TUserEngine_GetPlayObjectFreeList: TList; stdcall;
function TUserEngine_GetPlayObjectCount(): Integer; stdcall;
function TUserEngine_GetStdItemByName(pszItemName: PChar): pTStdItem; stdcall;
function TUserEngine_GetStdItemByIndex(nIndex: Integer): pTStdItem; stdcall;
function TUserEngine_CopyToUserItemFromName(const pszItemName: PChar; UserItem: pTUserItem): BOOL; stdcall;
function TUserEngine_GetStdItemList(): TObject; stdcall;
function TUserEngine_GetMagicList(): TObject; stdcall;

function TUserEngine_FindMagic(nMagIdx: Integer): pTMagic; stdcall;
function TUserEngine_AddMagic(Magic: pTMagic): Boolean; stdcall;
function TUserEngine_DelMagic(wMagicId: Word): Boolean; stdcall;

procedure TUserEngine_RandomUpgradeItem(Item: pTUserItem); stdcall;
procedure TUserEngine_GetUnknowItemValue(Item: pTUserItem); stdcall;

procedure TUserEngine_RandomUpgradeItem_(Item: pTUserItem); stdcall;
procedure TUserEngine_GetUnknowItemValue_(Item: pTUserItem); stdcall;

function TUserEngine_GetMaxPlayObjectCount(): Integer; stdcall;
procedure TUserEngine_SetMaxPlayObjectCount(Buffer: PChar; nLen: Integer); stdcall;

function TMapManager_FindMap(pszMapName: PChar): TEnvirnoment; stdcall;
function TEnvirnoment_GetRangeActorObject(Envir: TEnvirnoment; nX, nY, nRage: Integer; boFlag: Boolean; BaseObjectList: TList): Integer; stdcall;
function TEnvirnoment_boCANRIDE(Envir: TEnvirnoment): PBoolean; stdcall;
function TEnvirnoment_boCANBAT(Envir: TEnvirnoment): PBoolean; stdcall;

procedure TUserEngine_SetHookRun(UserEngineRun: TObjectAction); stdcall;
function TUserEngine_GetHookRun(): TObjectAction; stdcall;
procedure TUserEngine_SetHookClientUserMessage(ClientMsg: TObjectClientMsg); stdcall;

function TGuild_RankList(Guild: TGUild): TList; stdcall;

procedure TItemUnit_GetItemAddValue(UserItem: pTUserItem; var StdItem: TStdItem); stdcall;

procedure InitEngineOut();

var
  g_EngineOut: TEngineOut;
implementation
uses M2Share, HUtil32;
{===============================引擎插件共享函数===============================}

function TList_Create: TList; stdcall;
begin
  Result := TList.Create;
end;

procedure TList_Free(List: TList); stdcall;
begin
  List.Free;
end;

function TList_Count(List: TList): Integer; stdcall;
begin
  Result := List.Count;
end;

function TList_Add(List: TList; Item: Pointer): Integer; stdcall;
begin
  Result := List.Add(Item);
end;

procedure TList_Insert(List: TList; nIndex: Integer; Item: Pointer); stdcall;
begin
  List.Insert(nIndex, Item);
end;

function TList_Get(List: TList; nIndex: Integer): Pointer; stdcall;
begin
  Result := List.Items[nIndex];
end;

procedure TList_Put(List: TList; nIndex: Integer; Item: Pointer); stdcall;
begin
  List.Items[nIndex] := Item;
end;

procedure TList_Delete(List: TList; nIndex: Integer); stdcall;
begin
  List.Delete(nIndex);
end;

procedure TList_Clear(List: TList); stdcall;
begin
  List.Clear;
end;

procedure TList_Exchange(List: TList; nIndex1, nIndex2: Integer); stdcall;
begin
  List.Exchange(nIndex1, nIndex2);
end;

function TStringList_Create(): TStringList; stdcall;
begin
  Result := TStringList.Create;
end;

procedure TStringList_Free(List: TStringList); stdcall;
begin
  List.Free;
end;

function TStringList_Count(List: TStringList): Integer; stdcall;
begin
  Result := List.Count;
end;

function TStringList_Add(List: TStringList; s: PChar): Integer; stdcall;
begin
  List.Add(s);
end;

function TStringList_AddObject(List: TStringList; s: PChar; AObject: TObject): Integer; stdcall;
begin
  List.AddObject(s, AObject);
end;

procedure TStringList_Insert(List: TStringList; nIndex: Integer; s: PChar); stdcall;
begin
  List.Insert(nIndex, s);
end;

function TStringList_Get(List: TStringList; nIndex: Integer): PChar; stdcall;
begin
  Result := PChar(List.Strings[nIndex]);
end;

function TStringList_GetObject(List: TStringList; nIndex: Integer): TObject; stdcall;
begin
  Result := List.Objects[nIndex];
end;

procedure TStringList_Put(List: TStringList; nIndex: Integer; s: PChar); stdcall;
begin
  List.Strings[nIndex] := s;
end;

procedure TStringList_PutObject(List: TStringList; nIndex: Integer; AObject: TObject); stdcall;
begin
  List.Objects[nIndex] := AObject;
end;

procedure TStringList_Delete(List: TStringList; nIndex: Integer); stdcall;
begin
  List.Delete(nIndex);
end;

procedure TStringList_Clear(List: TStringList); stdcall;
begin
  List.Clear;
end;

procedure TStringList_Exchange(List: TStringList; nIndex1, nIndex2: Integer); stdcall;
begin
  List.Exchange(nIndex1, nIndex2);
end;

procedure TStringList_LoadFormFile(List: TStringList; pszFileName: PChar); stdcall;
begin
  List.LoadFromFile(StrPas(pszFileName));
end;

procedure TStringList_SaveToFile(List: TStringList; pszFileName: PChar); stdcall;
begin
  List.SaveToFile(StrPas(pszFileName));
end;

procedure MainOutMessageAPI(pszMsg: PChar);
begin
  MainOutMessage(StrPas(pszMsg));
end;

procedure AddGameDataLogAPI(pszMsg: PChar);
begin
  AddGameDataLog(StrPas(pszMsg));
end;

function GetGameGoldName(): PTShortString;
var
  ShortString: TShortString;
begin
  ShortString.btLen := Length(g_Config.sGameGoldName);
  Move(g_Config.sGameGoldName[1], ShortString.Strings, ShortString.btLen);
  Result := @ShortString;
end;

procedure EDcode_Decode6BitBuf(pszSource: PChar; pszDest: PChar; nSrcLen, nDestLen: Integer);
begin
  Decode6BitBuf(pszSource, pszDest, nSrcLen, nDestLen);
end;

procedure EDcode_Encode6BitBuf(pszSource: PChar; pszDest: PChar; nSrcLen, nDestLen: Integer);
begin
  Encode6BitBuf(pszSource, pszDest, nSrcLen, nDestLen);
end;

procedure EDcode_DecodeBuffer(pszSource: PChar; pszDest: PChar; bufsize: Integer);
begin
  DecodeBuffer(StrPas(pszSource), pszDest, bufsize);
end;

procedure EDcode_EncodeBuffer(Buf: PChar; bufsize: Integer; pszDest: PChar);
var
  sDest: string;
begin
  sDest := EncodeBuffer(Buf, bufsize);
  Move(sDest[1], pszDest^, Length(sDest));
end;

procedure EDcode_EncodeString(pszSource: PChar; pszDest: PChar);
var
  sDest: string;
begin
  sDest := EncodeString(StrPas(pszSource));
  Move(sDest[1], pszDest, Length(sDest));
end;

procedure EDcode_DeCodeString(pszSource: PChar; pszDest: PChar);
var
  sDest: string;
begin
  sDest := DeCodeString(StrPas(pszSource));
  Move(sDest[1], pszDest^, Length(sDest));
end;

procedure EDcode_SetDecode(Decode: TEDCode);
begin

end;

procedure EDcode_SetEncode(Encode: TEDCode);
begin

end;

function TConfig_AmyOunsulPoint: PInteger;
begin
  Result := @g_Config.nAmyOunsulPoint;
end;

function TConfig_sEnvirDir(): _LPTDIRNAME;
var
  sEnvirDir: _TDIRNAME;
begin
  sEnvirDir := g_Config.sEnvirDir;
  Result := @sEnvirDir;
end;

function TActorObject_Create(): TActorObject;
begin
  Result := TActorObject.Create;
end;

procedure TActorObject_Free(BaseObject: TActorObject);
begin
  BaseObject.Free;
end;

function TActorObject_sMapFileName(BaseObject: TActorObject): PTShortString;
var
  ShortString: TShortString;
begin
  ShortString.btLen := Length(BaseObject.m_sMapName);
  Move(BaseObject.m_sMapName[1], ShortString.Strings, ShortString.btLen);
  Result := @ShortString;
end;

function TActorObject_sMapName(BaseObject: TActorObject): PTShortString;
var
  ShortString: TShortString;
begin
  ShortString.btLen := Length(BaseObject.m_sMapName);
  Move(BaseObject.m_sMapName[1], ShortString.Strings, ShortString.btLen);
  Result := @ShortString;
end;

function TActorObject_sMapNameA(BaseObject: TActorObject): _LPTMAPNAME;
var
  sMapName: _TMAPNAME;
begin
  sMapName := BaseObject.m_sMapName;
  Result := @sMapName;
end;

function TActorObject_sCharName(BaseObject: TActorObject): PTShortString;
var
  ShortString: TShortString;
begin
  ShortString.btLen := Length(BaseObject.m_sCharName);
  Move(BaseObject.m_sCharName[1], ShortString.Strings, ShortString.btLen);
  Result := @ShortString;
end;

function TActorObject_sCharNameA(BaseObject: TActorObject): _LPTACTORNAME;
var
  sCharName: _TACTORNAME;
begin
  sCharName := BaseObject.m_sCharName;
  Result := @sCharName;
end;

function TActorObject_nCurrX(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nCurrX;
end;

function TActorObject_nCurrY(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nCurrY;
end;

function TActorObject_btDirection(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btDirection;
end;

function TActorObject_btGender(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btGender;
end;

function TActorObject_btHair(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btHair;
end;

function TActorObject_btJob(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btJob;
end;

function TActorObject_nGold(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nGold;
end;

function TActorObject_Ability(BaseObject: TActorObject): pTAbility;
begin
  Result := @BaseObject.m_Abil;
end;

function TActorObject_WAbility(BaseObject: TActorObject): pTAbility;
begin
  Result := @BaseObject.m_WAbil;
end;

function TActorObject_nCharStatus(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nCharStatus;
end;

function TActorObject_sHomeMap(BaseObject: TActorObject): PTShortString;
var
  ShortString: TShortString;
begin
  ShortString.btLen := Length(BaseObject.m_sHomeMap);
  Move(BaseObject.m_sHomeMap[1], ShortString.Strings, ShortString.btLen);
  Result := @ShortString;
end;

function TActorObject_nHomeX(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nHomeX;
end;

function TActorObject_nHomeY(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nHomeY;
end;

function TActorObject_boOnHorse(BaseObject: TActorObject): PBoolean;
begin
  Result := @BaseObject.m_boOnHorse;
end;

function TActorObject_btHorseType(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btHorseType;
end;

function TActorObject_btDressEffType(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btDressEffType;
end;

function TActorObject_nPkPoint(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nPkPoint;
end;

function TPlayObject_boAllowGroup(PlayObject: TPlayObject): PBoolean;
begin
  Result := @PlayObject.m_boAllowGroup;
end;

function TPlayObject_boAllowGuild(PlayObject: TPlayObject): PBoolean;
begin
  Result := @PlayObject.m_boAllowGuild;
end;

function TActorObject_nFightZoneDieCount(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nFightZoneDieCount;
end;

function TActorObject_nBonusPoint(BaseObject: TActorObject): PInteger;
begin
  //Result := @BaseObject.m_nBonusPoint;
end;

function TPlayObject_nHungerStatus(PlayObject: TPlayObject): PInteger;
begin
  Result := @PlayObject.m_nHungerStatus;
end;

function TPlayObject_boAllowGuildReCall(PlayObject: TPlayObject): PBoolean;
begin
  Result := @PlayObject.m_boAllowGuildReCall;
end;

function TActorObject_duBodyLuck(BaseObject: TActorObject): PDouble;
begin
  Result := @BaseObject.m_dBodyLuck;
end;

function TActorObject_nBodyLuckLevel(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nBodyLuckLevel;
end;

function TPlayObject_wGroupRcallTime(PlayObject: TPlayObject): PWord;
begin
  Result := @PlayObject.m_wGroupRcallTime;
end;

function TPlayObject_boAllowGroupReCall(PlayObject: TPlayObject): PBoolean;
begin
  Result := @PlayObject.m_boAllowGroupReCall;
end;

function TActorObject_nCharStatusEx(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nCharStatusEx;
end;

function TActorObject_dwFightExp(BaseObject: TActorObject): PLongWord;
begin
  Result := @BaseObject.m_dwFightExp;
end;

function TActorObject_nViewRange(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nViewRange;
end;

function TActorObject_wAppr(BaseObject: TActorObject): PWord;
begin
  Result := @BaseObject.m_wAppr;
end;

function TActorObject_btRaceServer(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btRaceServer;
end;

function TActorObject_btRaceImg(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btRaceImg;
end;

function TActorObject_btHitPoint(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btHitPoint;
end;

function TActorObject_nHitPlus(BaseObject: TActorObject): PShortInt;
begin
  Result := @BaseObject.m_nHitPlus;
end;

function TActorObject_nHitDouble(BaseObject: TActorObject): PShortInt;
begin
  Result := @BaseObject.m_nHitDouble;
end;

function TActorObject_boRecallSuite(BaseObject: TActorObject): PBoolean;
begin
  Result := @BaseObject.m_boRecallSuite;
end;

function TActorObject_nHealthRecover(BaseObject: TActorObject): PShortInt;
begin
  Result := @BaseObject.m_nHealthRecover;
end;

function TActorObject_nSpellRecover(BaseObject: TActorObject): PShortInt;
begin
  Result := @BaseObject.m_nSpellRecover;
end;

function TActorObject_btAntiPoison(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btAntiPoison;
end;

function TActorObject_nPoisonRecover(BaseObject: TActorObject): PShortInt;
begin
  Result := @BaseObject.m_nPoisonRecover;
end;

function TActorObject_nAntiMagic(BaseObject: TActorObject): PShortInt;
begin
  Result := @BaseObject.m_nAntiMagic;
end;

function TActorObject_nLuck(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nLuck;
end;

function TActorObject_nPerHealth(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nPerHealth;
end;

function TActorObject_nPerHealing(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nPerHealing;
end;

function TActorObject_nPerSpell(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nPerSpell;
end;

function TActorObject_btGreenPoisoningPoint(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btGreenPoisoningPoint;
end;

function TActorObject_nGoldMax(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nGoldMax;
end;

function TActorObject_btSpeedPoint(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btSpeedPoint;
end;

function TActorObject_btPermission(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btPermission;
end;

function TActorObject_nHitSpeed(BaseObject: TActorObject): PShortInt;
begin
  Result := @BaseObject.m_nHitSpeed;
end;

function TActorObject_TargetCret(BaseObject: TActorObject): PTActorObject;
begin
  Result := @BaseObject.m_TargetCret;
end;

function TActorObject_LastHiter(BaseObject: TActorObject): PTActorObject;
begin
  Result := @BaseObject.m_LastHiter;
end;

function TActorObject_ExpHiter(BaseObject: TActorObject): PTActorObject;
begin
  Result := @BaseObject.m_ExpHitter;
end;

function TActorObject_btLifeAttrib(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btLifeAttrib;
end;

function TPlayObject_GroupOwner(PlayObject: TPlayObject): TPlayObject;
begin
  Result := PlayObject.m_GroupOwner;
end;

function TPlayObject_GroupMembersList(PlayObject: TPlayObject): TStringList;
begin
  Result := @PlayObject.m_GroupMembers;
end;

function TPlayObject_boHearWhisper(PlayObject: TPlayObject): PBoolean;
begin
  Result := @PlayObject.m_boHearWhisper;
end;

function TPlayObject_boBanShout(PlayObject: TPlayObject): PBoolean;
begin
  Result := @PlayObject.m_boBanShout;
end;

function TPlayObject_boBanGuildChat(PlayObject: TPlayObject): PBoolean;
begin
  Result := @PlayObject.m_boBanGuildChat;
end;

function TPlayObject_boAllowDeal(PlayObject: TPlayObject): PBoolean;
begin
  Result := @PlayObject.m_boAllowDeal;
end;

function TActorObject_nSlaveType(BaseObject: TActorObject): PInteger;
begin

end;

function TActorObject_Master(BaseObject: TActorObject): PTActorObject;
begin
  Result := @BaseObject.m_Master;
end;

function TActorObject_btAttatckMode(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btAttatckMode;
end;

function TActorObject_btNameColor(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btNameColor;
end;

function TActorObject_nLight(BaseObject: TActorObject): PInteger;
begin
  Result := @BaseObject.m_nLight;
end;

function TActorObject_ItemList(BaseObject: TActorObject): TList;
begin
  Result := BaseObject.m_ItemList;
end;

function TActorObject_MagicList(BaseObject: TActorObject): TList;
begin
  Result := BaseObject.m_MagicList;
end;

function TActorObject_MyGuild(BaseObject: TActorObject): TGUild;
begin
  Result := TGUild(BaseObject.m_MyGuild);
end;

function TActorObject_UseItems(BaseObject: TActorObject): pTHumanUseItems;
begin
  Result := @BaseObject.m_UseItems;
end;

function TActorObject_btMonsterWeapon(BaseObject: TActorObject): PByte;
begin
  Result := @BaseObject.m_btMonsterWeapon;
end;

function TActorObject_PEnvir(BaseObject: TActorObject): PTEnvirnoment;
begin
  Result := @BaseObject.m_PEnvir;
end;

function TActorObject_boGhost(BaseObject: TActorObject): PBoolean;
begin
  Result := @BaseObject.m_boGhost;
end;

function TActorObject_boDeath(BaseObject: TActorObject): PBoolean;
begin
  Result := @BaseObject.m_boDeath;
end;

function TActorObject_DeleteBagItem(BaseObject: TActorObject; UserItem: pTUserItem): BOOL;
begin
  Result := BaseObject.DelBagItem(UserItem);
end;

function TActorObject_AddCustomData(BaseObject: TActorObject; Data: Pointer): Integer;
begin

end;

function TActorObject_GetCustomData(BaseObject: TActorObject; nIndex: Integer): Pointer;
begin

end;

procedure TActorObject_SendMsg(SelfObject, BaseObject: TActorObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: PChar);
begin
  SelfObject.SendMsg(BaseObject, wIdent, wParam, nParam1, nParam2, nParam3, StrPas(pszMsg));
end;

procedure TActorObject_SendRefMsg(BaseObject: TActorObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: PChar);
begin
  BaseObject.SendRefMsg(wIdent, wParam, nParam1, nParam2, nParam3, StrPas(pszMsg));
end;

procedure TActorObject_SendDelayMsg(SelfObject, BaseObject: TActorObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: PChar; dwDelayTime: LongWord);
begin
  SelfObject.SendDelayMsg(BaseObject, wIdent, wParam, nParam1, nParam2, nParam3, StrPas(pszMsg), dwDelayTime);
end;

procedure TActorObject_SysMsg(BaseObject: TActorObject; pszMsg: PChar; MsgColor: TMsgColor; MsgType: TMsgType);
begin
  BaseObject.SysMsg(StrPas(pszMsg), MsgColor, MsgType);
end;

function TActorObject_GetFrontPosition(BaseObject: TActorObject; var nX: Integer; var nY: Integer): Boolean;
begin
  Result := BaseObject.GetFrontPosition(nX, nY);
end;

function TActorObject_GetRecallXY(BaseObject: TActorObject; nX, nY: Integer; nRange: Integer; var nDX: Integer; var nDY: Integer): Boolean;
begin
  Result := BaseObject.sub_4C5370(nX, nY, nRange, nDX, nDY);
end;

procedure TActorObject_SpaceMove(BaseObject: TActorObject; pszMap: PChar; nX, nY: Integer; nInt: Integer);
begin
  BaseObject.SpaceMove(StrPas(pszMap), nX, nY, nInt);
end;

procedure TActorObject_FeatureChanged(BaseObject: TActorObject);
begin
  BaseObject.FeatureChanged;
end;

procedure TActorObject_StatusChanged(BaseObject: TActorObject);
begin
  BaseObject.StatusChanged;
end;

function TActorObject_GetFeatureToLong(BaseObject: TActorObject): Integer;
begin
  Result := BaseObject.GetFeatureToLong;
end;

function TActorObject_GetFeature(SelfObject, BaseObject: TActorObject): Integer;
begin
  Result := SelfObject.GetFeature(BaseObject);
end;

function TActorObject_GetCharColor(SelfObject, BaseObject: TActorObject): Byte;
begin
  Result := BaseObject.GetCharColor(BaseObject);
end;

function TActorObject_GetNamecolor(BaseObject: TActorObject): Byte;
begin
  Result := BaseObject.GetNamecolor;
end;

procedure TActorObject_GoldChanged(BaseObject: TActorObject);
begin
  BaseObject.GoldChanged;
end;

procedure TActorObject_GameGoldChanged(BaseObject: TActorObject);
begin
  BaseObject.GameGoldChanged;
end;

procedure TActorObject_SetTargetCreat(AObject, BObject: TActorObject);
begin
  AObject.SetTargetCreat(BObject);
end;

function TActorObject_MagCanHitTarget(BaseObject: TActorObject; nX, nY: Integer; TargeTActorObject: TActorObject): Boolean;
begin
  BaseObject.MagCanHitTarget(nX, nY, TargeTActorObject);
end;

function TActorObject_IsProtectTarget(AObject, BObject: TActorObject): Boolean;
begin
  Result := AObject.IsProtectTarget(BObject);
end;

function TActorObject_IsAttackTarget(AObject, BObject: TActorObject): Boolean;
begin
  Result := AObject.IsAttackTarget(BObject);
end;

function TActorObject_IsProperTarget(AObject, BObject: TActorObject): Boolean;
begin
  Result := AObject.IsProperTarget(BObject);
end;

function TActorObject_IsProperFriend(AObject, BObject: TActorObject): Boolean;
begin
  Result := AObject.IsProperFriend(BObject);
end;

procedure TActorObject_TrainSkillPoint(BaseObject: TActorObject; UserMagic: pTUserMagic; nTranPoint: Integer);
begin
  BaseObject.TrainSkill(UserMagic, nTranPoint);
end;

function TActorObject_GetAttackPower(BaseObject: TActorObject; nBasePower, nPower: Integer): Integer;
begin
  Result := BaseObject.GetAttackPower(nBasePower, nPower);
end;

function TActorObject_MakeSlave(BaseObject: TActorObject; pszMonName: PChar; nMakeLevel, nExpLevel, nMaxMob, nType: Integer; dwRoyaltySec: LongWord): TActorObject;
begin
  Result := BaseObject.MakeSlave(StrPas(pszMonName), nMakeLevel, nExpLevel, nMaxMob, dwRoyaltySec);
end;

procedure TActorObject_MakeGhost(BaseObject: TActorObject);
begin
  BaseObject.MakeGhost;
end;

procedure TActorObject_RefNameColor(BaseObject: TActorObject);
begin
  BaseObject.RefNameColor;
end;
//AddItem 占用内存由自己处理，API内部会自动申请内存

function TActorObject_AddItemToBag(BaseObject: TActorObject; AddItem: pTUserItem): BOOL;
var
  UserItem: pTUserItem;
begin
  New(UserItem);
  UserItem^ := AddItem^;
  //Move(AddItem^, UserItem^, SizeOf(TUserItem));
  {UserItem.MakeIndex := AddItem.MakeIndex;
  UserItem.wIndex := AddItem.wIndex;
  UserItem.Dura := AddItem.Dura;
  UserItem.DuraMax := AddItem.DuraMax;
  UserItem.btValue := AddItem.btValue;
  UserItem.AddValue := AddItem.AddValue;}
  Result := BaseObject.AddItemToBag(UserItem);
  if not Result then Dispose(UserItem);
end;

function TPlayObject_AddItemToStorage(PlayObject: TPlayObject; AddItem: pTUserItem): BOOL;
var
  UserItem: pTUserItem;
begin
  Result := False;
  if PlayObject.m_StorageItemList.Count < 46 then begin
    New(UserItem);
    UserItem^ := AddItem^;
    //Move(AddItem^, UserItem^, SizeOf(TUserItem));
    {UserItem.MakeIndex := AddItem.MakeIndex;
    UserItem.wIndex := AddItem.wIndex;
    UserItem.Dura := AddItem.Dura;
    UserItem.DuraMax := AddItem.DuraMax;
    UserItem.btValue := AddItem.btValue;
    UserItem.AddValue := AddItem.AddValue;}
    PlayObject.m_StorageItemList.Add(UserItem);
    Result := True;
  end;
end;

procedure TActorObject_ClearBagItem(BaseObject: TActorObject);
begin
  //BaseObject.ClearBagItem;
end;

procedure TPlayObject_ClearStorageItem(PlayObject: TPlayObject);
begin

end;

procedure TActorObject_SetHookGetFeature(ObjectActionFeature: TObjectActionFeature);
begin
  PlugInEngine.GetFeature := ObjectActionFeature;
end;

procedure TActorObject_SetHookEnterAnotherMap(EnterAnotherMap: TObjectActionEnterMap);
begin
  PlugInEngine.ObjectEnterAnotherMap := EnterAnotherMap;
end;

procedure TActorObject_SetHookObjectDie(ObjectDie: TObjectActionEx);
begin
  PlugInEngine.ObjectDie := ObjectDie;
end;

procedure TActorObject_SetHookChangeCurrMap(ChangeCurrMap: TObjectActionEx);
begin
  PlugInEngine.ChangeCurrMap := ChangeCurrMap;
end;

function TActorObject_MagMakeDefenceArea(BaseObject: TActorObject; nX, nY, nRange, nSec: Integer; btState: Byte; boState: Boolean): Integer;
begin
  BaseObject.MagMakeDefenceArea(nX, nY, nRange, nSec, btState, boState);
end;

function TActorObject_MagBubbleDefenceUp(BaseObject: TActorObject; nLevel, nSec: Integer): Boolean;
begin
  BaseObject.MagBubbleDefenceUp(nLevel, nSec);
end;


//=================================IPlayObject==================================

function TPlayObject_IsEnoughBag(PlayObject: TPlayObject): Boolean;
begin
  Result := PlayObject.IsEnoughBag;
end;

function TPlayObject_nSoftVersionDate(PlayObject: TPlayObject): PInteger;
begin
  Result := @PlayObject.m_nSoftVersionDate;
end;

function TPlayObject_nSoftVersionDateEx(PlayObject: TPlayObject): PInteger;
begin
  Result := @PlayObject.m_nSoftVersionDateEx;
end;

function TPlayObject_dLogonTime(PlayObject: TPlayObject): PDateTime;
begin
  Result := @PlayObject.m_dLogonTime;
end;

function TPlayObject_dwLogonTick(PlayObject: TPlayObject): PLongWord;
begin
  Result := @PlayObject.m_dwLogonTick;
end;

function TPlayObject_nMemberType(PlayObject: TPlayObject): PInteger;
begin
  Result := @PlayObject.m_nMemberType;
end;

function TPlayObject_nMemberLevel(PlayObject: TPlayObject): PInteger;
begin
  Result := @PlayObject.m_nMemberLevel;
end;

function TPlayObject_nGameGold(PlayObject: TPlayObject): PInteger;
begin
  Result := @PlayObject.m_nGameGold;
end;

function TPlayObject_nGamePoint(PlayObject: TPlayObject): PInteger;
begin
  Result := @PlayObject.m_nGamePoint;
end;

function TPlayObject_nPayMentPoint(PlayObject: TPlayObject): PInteger;
begin
  Result := @PlayObject.m_nPayMentPoint;
end;

function TPlayObject_nClientFlag(PlayObject: TPlayObject): PInteger;
begin
  Result := @PlayObject.m_nClientFlagMode;
end;

function TPlayObject_nSelectID(PlayObject: TPlayObject): PInteger;
begin
  Result := @PlayObject.m_nSessionID;
end;

function TPlayObject_nClientFlagMode(PlayObject: TPlayObject): PInteger;
begin
  Result := @PlayObject.m_nClientFlagMode;
end;

function TPlayObject_dwClientTick(PlayObject: TPlayObject): PLongWord;
begin
  Result := @PlayObject.m_dwClientTick;
end;

function TPlayObject_wClientType(PlayObject: TPlayObject): PWord;
begin

end;

function TPlayObject_sBankPassword(PlayObject: TPlayObject): _LPTBANKPWD;
var
  sStoragePwd: _TBANKPWD;
begin
  sStoragePwd := PlayObject.m_sStoragePwd;
  Result := @sStoragePwd;
end;

function TPlayObject_nBankGold(PlayObject: TPlayObject): PInteger;
begin

end;

function TPlayObject_MyHero(PlayObject: TPlayObject): PTActorObject;
begin
  Result := @PlayObject.m_MyHero;
end;

function TPlayObject_Create(): TPlayObject;
begin
  Result := TPlayObject.Create;
end;

procedure TPlayObject_Free(PlayObject: TPlayObject);
begin
  PlayObject.Free;
end;

procedure TPlayObject_SendSocket(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; pszMsg: PChar);
begin
  PlayObject.SendSocket(DefMsg, StrPas(pszMsg));
end;

procedure TPlayObject_SendDefMessage(PlayObject: TPlayObject; wIdent: Word; nRecog: Integer; nParam, nTag, nSeries: Word; pszMsg: PChar);
begin
  PlayObject.SendDefMessage(wIdent, nRecog, nParam, nTag, nSeries, StrPas(pszMsg));
end;

procedure TPlayObject_SendAddItem(PlayObject: TPlayObject; AddItem: pTUserItem);
begin
  PlayObject.SendAddItem(AddItem);
end;

procedure TPlayObject_SendDelItem(PlayObject: TPlayObject; DelItem: pTUserItem);
begin
  PlayObject.SendDelItems(DelItem);
end;

function TPlayObject_TargetInNearXY(PlayObject: TPlayObject; Target: TActorObject; nX, nY: Integer): Boolean;
begin
  Result := PlayObject.CretInNearXY(Target, nX, nY);
end;

procedure TPlayObject_SetBankPassword(PlayObject: TPlayObject; pszPassword: PChar);
begin
  PlayObject.m_sStoragePwd := StrPas(pszPassword);
end;

procedure TPlayObject_SetHookCreate(PlayObjectCreate: TObjectAction);
begin
  PlugInEngine.PlayObjectCreate := PlayObjectCreate;
end;

function TActorObject_GetBaseObjectTick(BaseObject: TActorObject; nCount: Integer): PLongWord;
begin
  if (nCount >= Low(BaseObject.m_dwUserTick)) and (nCount < High(BaseObject.m_dwUserTick)) then begin
    Result := @BaseObject.m_dwUserTick[nCount];
  end else Result := 0;
end;

function TPlayObject_GetHookCreate(): TObjectAction;
begin
  Result := PlugInEngine.PlayObjectCreate;
end;

procedure TPlayObject_SetHookDestroy(PlayObjectDestroy: TObjectAction);
begin
  PlugInEngine.PlayObjectDestroy := PlayObjectDestroy;
end;

function TPlayObject_GetHookDestroy(): TObjectAction;
begin
  Result := PlugInEngine.PlayObjectDestroy;
end;

procedure TPlayObject_SetHookUserLogin1(PlayObjectUserLogin: TObjectAction);
begin
  PlugInEngine.PlayObjectUserLogin1 := PlayObjectUserLogin;
end;

procedure TPlayObject_SetHookUserLogin2(PlayObjectUserLogin: TObjectAction);
begin
  PlugInEngine.PlayObjectUserLogin2 := PlayObjectUserLogin;
end;

procedure TPlayObject_SetHookUserLogin3(PlayObjectUserLogin: TObjectAction);
begin
  PlugInEngine.PlayObjectUserLogin3 := PlayObjectUserLogin;
end;

procedure TPlayObject_SetHookUserLogin4(PlayObjectUserLogin: TObjectAction);
begin
  PlugInEngine.PlayObjectUserLogin4 := PlayObjectUserLogin;
end;

procedure TPlayObject_SetHookUserCmd(PlayObjectUserCmd: TObjectUserCmd);
begin
  PlugInEngine.PlayObjectUserCmd := PlayObjectUserCmd;
end;

function TPlayObject_GetHookUserCmd(): TObjectUserCmd;
begin
  Result := PlugInEngine.PlayObjectUserCmd;
end;

procedure TPlayObject_SetHookPlayOperateMessage(PlayObjectOperateMessage: TObjectOperateMessage);
begin
  PlugInEngine.ObjectOperateMessage := PlayObjectOperateMessage;
end;

function TPlayObject_GetHookPlayOperateMessage(): TObjectOperateMessage;
begin
  Result := PlugInEngine.ObjectOperateMessage;
end;

procedure TPlayObject_SetHookClientQueryBagItems(ClientQueryBagItems: TObjectAction);
begin
  PlugInEngine.ClientQueryBagItems := ClientQueryBagItems;
end;

procedure TPlayObject_SetHookClientQueryUserState(ClientQueryUserState: TObjectActionXY);
begin
  PlugInEngine.ClientQueryUserState := ClientQueryUserState;
end;

procedure TPlayObject_SetHookSendActionGood(SendActionGood: TObjectAction);
begin
  PlugInEngine.SendActionGood := SendActionGood;
end;

procedure TPlayObject_SetHookSendActionFail(SendActionFail: TObjectAction);
begin
  PlugInEngine.SendActionFail := SendActionFail;
end;

procedure TPlayObject_SetHookSendWalkMsg(ObjectActioinXYD: TObjectActionXYD);
begin
  PlugInEngine.SendWalkMsg := ObjectActioinXYD;
end;

procedure TPlayObject_SetHookSendHorseRunMsg(ObjectActioinXYD: TObjectActionXYD);
begin
  PlugInEngine.SendHorseRunMsg := ObjectActioinXYD;
end;

procedure TPlayObject_SetHookSendRunMsg(ObjectActioinXYD: TObjectActionXYD);
begin
  PlugInEngine.SendRunMsg := ObjectActioinXYD;
end;

procedure TPlayObject_SetHookSendDeathMsg(ObjectActioinXYDM: TObjectActionXYDM);
begin
  PlugInEngine.SendDeathMsg := ObjectActioinXYDM;
end;

procedure TPlayObject_SetHookSendSkeletonMsg(ObjectActioinXYD: TObjectActionXYD);
begin
  PlugInEngine.SendSkeletonMsg := ObjectActioinXYD;
end;

procedure TPlayObject_SetHookSendAliveMsg(ObjectActioinXYD: TObjectActionXYD);
begin
  PlugInEngine.SendAliveMsg := ObjectActioinXYD;
end;

procedure TPlayObject_SetHookSendSpaceMoveMsg(ObjectActioinXYDWS: TObjectActionXYDWS);
begin
  PlugInEngine.SendSpaceMoveMsg := ObjectActioinXYDWS;
end;

procedure TPlayObject_SetHookSendChangeFaceMsg(ObjectActioinObject: TObjectActionObject);
begin
  PlugInEngine.SendChangeFaceMsg := ObjectActioinObject;
end;

procedure TPlayObject_SetHookSendUseitemsMsg(ObjectActioin: TObjectAction);
begin
  PlugInEngine.SendUseitemsMsg := ObjectActioin;
end;

procedure TPlayObject_SetHookSendUserLevelUpMsg(ObjectActioinObject: TObjectAction);
begin
  PlugInEngine.SendUserLevelUpMsg := ObjectActioinObject;
end;

procedure TPlayObject_SetHookSendUserAbilieyMsg(ObjectActioinObject: TObjectAction);
begin
  PlugInEngine.SendUserAbilieyMsg := ObjectActioinObject;
end;

procedure TPlayObject_SetHookSendUserStatusMsg(ObjectActioinXYDWS: TObjectActionXYDWS);
begin

end;

procedure TPlayObject_SetHookSendUserStruckMsg(ObjectActioinObject: TObjectActionObject);
begin
  PlugInEngine.SendUserStruckMsg := ObjectActioinObject;
end;

procedure TPlayObject_SetHookSendUseMagicMsg(ObjectActioin: TObjectAction);
begin
  PlugInEngine.SendUseMagicMsg := ObjectActioin;
end;

procedure TPlayObject_SetHookSendSocket(SendSocket: TPlaySendSocket);
begin
  PlugInEngine.SendSocket := SendSocket;
end;

procedure TPlayObject_SetHookSendGoodsList(SendGoodsList: TObjectActionSendGoods);
begin
  PlugInEngine.SendGoodsList := SendGoodsList;
end;

procedure TPlayObject_SetCheckClientDropItem(ActionDropItem: TObjectActionItem);
begin
  PlugInEngine.CheckCanDropItem := ActionDropItem;
end;

procedure TPlayObject_SetCheckClientDealItem(ActionItem: TObjectActionItem);
begin
  PlugInEngine.CheckCanDealItem := ActionItem;
end;

procedure TPlayObject_SetCheckClientStorageItem(ActionItem: TObjectActionItem);
begin
  PlugInEngine.CheckCanStorageItem := ActionItem;
end;

procedure TPlayObject_SetCheckClientRepairItem(ActionItem: TObjectActionItem);
begin
  PlugInEngine.CheckCanRepairItem := ActionItem;
end;

procedure TPlayObject_SetHookCheckUserItems(ObjectActioin: TObjectActionCheckUserItem);
begin
  PlugInEngine.CheckUserItems := ObjectActioin;
end;


procedure TPlayObject_SetCheckClientUpgradeItem(ActionItem: TObjectActionItem);
begin
  PlugInEngine.CheckCanUpgradeItem := ActionItem;
end;

procedure TPlayObject_SetCheckClientSellItem(ActionItem: TObjectActionItem);
begin
  PlugInEngine.CheckCanSellItem := ActionItem;
end;

procedure TActorObject_SetCheckClientNotScatterItem(ActionItem: TObjectActionItem);
begin
  PlugInEngine.CheckNotCanScatterItem := ActionItem;
end;

procedure TActorObject_SetCheckClientDieScatterItem(ActionItem: TObjectActionItem);
begin
  PlugInEngine.CheckCanDieScatterItem := ActionItem;
end;

procedure TPlayObject_SetHookOffLine(ObjectOffLine: TObjectAction);
begin
  PlugInEngine.ObjectOffLine := ObjectOffLine;
end;

procedure TPlayObject_SetHookRun(PlayRun: TObjectAction);
begin
  PlugInEngine.PlayObjectRun := PlayRun;
end;

procedure TPlayObject_SetHookFilterMsg(FilterMsg: TObjectFilterMsg);
begin
  PlugInEngine.PlayObjectFilterMsg := FilterMsg;
end;

function TPlayObject_PlayUseItems(PlayObject: TPlayObject): pTHumanUseItems;
begin
  Result := @PlayObject.m_UseItems;
end;

procedure THeroObject_SendAddItem(HeroObject: THeroObject; Item: pTUserItem);
begin
  HeroObject.SendAddItem(Item);
end;

procedure THeroObject_SendDelItem(HeroObject: THeroObject; Item: pTUserItem);
begin
  HeroObject.SendDelItems(Item);
end;

function TNormNpc_sFilePath(NormNpc: TNormNpc): _LPTPATHNAME;
var
  sFilePath: _TPATHNAME;
begin
  sFilePath := NormNpc.m_sFilePath;
  Result := @sFilePath;
end;

function TNormNpc_sPath(NormNpc: TNormNpc): _LPTPATHNAME;
var
  sPath: _TPATHNAME;
begin
  sPath := NormNpc.m_sPath;
  Result := @sPath;
end;

procedure TNormNpc_GetLineVariableText(NormNpc: TNormNpc; BaseObject: TActorObject; pszMsg: PChar; pszOutMsg: PChar; nOutMsgLen: Integer);
var
  s10, sMsg, sOutMsg: string;
  nC: Integer;
begin
  sMsg := StrPas(pszMsg);
  SetLength(sOutMsg, nOutMsgLen);
  Move(pszOutMsg^, sOutMsg[1], nOutMsgLen);
  nC := 0;
  while True do begin
    if Pos('>', sMsg) <= 0 then Break; //if TagCount(sMsg, '>') < 1 then Break;
    ArrestStringEx(sMsg, '<', '>', s10);
    NormNpc.GetVariableText(TPlayObject(BaseObject), sOutMsg, s10);
    Inc(nC);
    if nC >= 101 then Break;
  end;
end;

procedure TNormNpc_SetScriptActionCmd(ActionCmd: TScriptCmd);
begin
  PlugInEngine.QuestActionScriptCmd := ActionCmd;
end;

function TNormNpc_GetScriptActionCmd(): TScriptCmd;
begin
  Result := PlugInEngine.QuestActionScriptCmd;
end;

procedure TNormNpc_SetScriptConditionCmd(ConditionCmd: TScriptCmd);
begin
  PlugInEngine.QuestConditionScriptCmd := ConditionCmd;
end;

function TNormNpc_GetScriptConditionCmd(): TScriptCmd;
begin
  Result := PlugInEngine.QuestConditionScriptCmd;
end;

function TNormNpc_GetManageNpc(): TNormNpc;
begin
  Result := g_ManageNPC;
end;

function TNormNpc_GetFunctionNpc(): TNormNpc;
begin
  Result := g_FunctionNPC;
end;

procedure TNormNpc_GotoLable(NormNpc: TNormNpc; PlayObject: TPlayObject; pszLabel: PChar);
begin
  PlayObject.m_nScriptGotoCount := 0;
  NormNpc.GotoLable(PlayObject, StrPas(pszLabel), False);
end;

procedure TNormNpc_SetScriptAction(ScriptAction: TScriptAction);
begin
  PlugInEngine.ActionScriptProcess := ScriptAction;
end;

function TNormNpc_GetScriptAction(): TScriptAction;
begin
  Result := PlugInEngine.ActionScriptProcess;
end;

procedure TNormNpc_SetScriptCondition(ScriptAction: TScriptCondition);
begin
  PlugInEngine.ConditionScriptProcess := ScriptAction;
end;

function TNormNpc_GetScriptCondition(): TScriptCondition;
begin
  Result := PlugInEngine.ConditionScriptProcess;
end;

function TMerchant_GoodsList(Merchant: TMerchant): TList;
begin
  Result := Merchant.m_GoodsList;
end;

function TMerchant_GetItemPrice(Merchant: TMerchant; nIndex: Integer): Integer;
begin
  if (nIndex < Merchant.m_ItemPriceList.Count) and (nIndex >= 0) and (Merchant.m_ItemPriceList.Count > 0) then
    Result := pTItemPrice(Merchant.m_ItemPriceList.Items[nIndex]).nPrice else Result := -1;
end;

function TMerchant_GetUserPrice(Merchant: TMerchant; PlayObject: TPlayObject; nPrice: Integer): Integer;
begin
  Result := Merchant.GetUserPrice(PlayObject, nPrice);
end;

function TMerchant_GetUserItemPrice(Merchant: TMerchant; UserItem: pTUserItem): Integer;
begin
  Result := Merchant.GetUserItemPrice(UserItem);
end;

procedure TMerchant_SetHookClientGetDetailGoodsList(GetDetailGoods: TObjectActionDetailGoods);
begin
  PlugInEngine.MerchantClientGetDetailGoodsList := GetDetailGoods;
end;

function TUserEngine_Create(): TUserEngine;
begin
  Result := TUserEngine.Create;
end;

procedure TUserEngine_Free(UserEngine: TUserEngine);
begin
  UserEngine.Free;
end;

function TUserEngine_GetUserEngine(): TUserEngine;
begin
  Result := UserEngine;
end;

function TUserEngine_GetPlayObject(szPlayName: PChar; boGetHide: Boolean): TPlayObject;
begin
  Result := UserEngine.GetPlayObject(StrPas(szPlayName));
end;

function TUserEngine_GetLoadPlayList(): TStringList;
begin
  Result := UserEngine.m_LoadPlayList;
end;

function TUserEngine_GetPlayObjectList(): TStringList;
begin
  //Result := UserEngine.m_PlayObjectList;
end;

function TUserEngine_GetLoadPlayCount(): Integer;
begin
  Result := UserEngine.LoadPlayCount;
end;

function TUserEngine_GetPlayObjectFreeList: TList; stdcall;
begin
  Result := UserEngine.m_PlayObjectFreeList;
end;

function TUserEngine_GetPlayObjectCount(): Integer;
begin
  Result := UserEngine.PlayObjectCount;
end;

function TUserEngine_GetStdItemByName(pszItemName: PChar): pTStdItem;
begin
  Result := UserEngine.GetStdItem(StrPas(pszItemName));
end;

function TUserEngine_GetStdItemByIndex(nIndex: Integer): pTStdItem;
begin
  Result := UserEngine.GetStdItem(nIndex);
end;

function TUserEngine_CopyToUserItemFromName(const pszItemName: PChar; UserItem: pTUserItem): BOOL;
begin
  Result := UserEngine.CopyToUserItemFromName(StrPas(pszItemName), UserItem);
end;

function TMapManager_FindMap(pszMapName: PChar): TEnvirnoment;
begin
  Result := g_MapManager.FindMap(StrPas(pszMapName));
end;

function TEnvirnoment_GetRangeActorObject(Envir: TEnvirnoment; nX, nY, nRage: Integer; boFlag: Boolean; BaseObjectList: TList): Integer;
begin
  Result := Envir.GetRangeActorObject(nX, nY, nRage, boFlag, BaseObjectList);
end;

function TEnvirnoment_boCANRIDE(Envir: TEnvirnoment): PBoolean;
begin

end;

function TEnvirnoment_boCANBAT(Envir: TEnvirnoment): PBoolean;
begin

end;

procedure TUserEngine_SetHookRun(UserEngineRun: TObjectAction);
begin
  PlugInEngine.UserEngineRun := UserEngineRun;
end;

function TUserEngine_GetHookRun(): TObjectAction;
begin
  Result := PlugInEngine.UserEngineRun;
end;

procedure TUserEngine_SetHookClientUserMessage(ClientMsg: TObjectClientMsg);
begin
  PlugInEngine.ObjectClientMsg := ClientMsg;
end;

function TGuild_RankList(Guild: TGUild): TList;
begin
  Result := Guild.m_RankList;
end;

procedure TItemUnit_GetItemAddValue(UserItem: pTUserItem; var StdItem: TStdItem);
begin
  ItemUnit.GetItemAddValue(UserItem, StdItem);
end;

function TMagicManager_GetMagicManager(): TMagicManager;
begin
  Result := MagicManager;
end;

function TMagicManager_DoSpell(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
begin
  Result := MagicManager.DoSpell(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject);
end;

function TMagicManager_MPow(UserMagic: pTUserMagic): Integer;
begin
  Result := MPow(UserMagic);
end;

function TMagicManager_GetPower(nPower: Integer; UserMagic: pTUserMagic): Integer;
begin
  Result := GetPower(nPower, UserMagic);
end;

function TMagicManager_GetPower13(nInt: Integer; UserMagic: pTUserMagic): Integer;
begin
  Result := GetPower13(nInt, UserMagic);
end;

function TMagicManager_GetRPow(wInt: Integer): Word;
begin
  Result := GetRPow(wInt);
end;

function TMagicManager_IsWarrSkill(MagicManager: TMagicManager; wMagIdx: Integer): Boolean;
begin
  Result := MagicManager.IsWarrSkill(wMagIdx);
end;

function TMagicManager_MagBigHealing(MagicManager: TMagicManager; PlayObject: TActorObject; nPower, nX, nY: Integer): Boolean;
begin
  Result := MagicManager.MagBigHealing(PlayObject, nPower, nX, nY);
end;

function TMagicManager_MagPushArround(MagicManager: TMagicManager; PlayObject: TActorObject; nPushLevel: Integer): Integer;
begin
  Result := MagicManager.MagPushArround(PlayObject, nPushLevel);
end;

function TMagicManager_MagPushArroundTaos(MagicManager: TMagicManager; PlayObject: TActorObject; nPushLevel: Integer): Integer;
begin
  Result := MagicManager.MagPushArround(PlayObject, nPushLevel);
end;

function TMagicManager_MagTurnUndead(MagicManager: TMagicManager; BaseObject, TargeTActorObject: TActorObject; nTargetX, nTargetY: Integer; nLevel: Integer): Boolean;
begin
  Result := MagicManager.MagTurnUndead(BaseObject, TargeTActorObject, nTargetX, nTargetY, nLevel);
end;

function TMagicManager_MagMakeHolyCurtain(MagicManager: TMagicManager; BaseObject: TActorObject; nDamage, nHTime, nX, nY: Integer): Integer;
begin
  Result := MagicManager.MagMakeHolyCurtain(BaseObject, nDamage, nHTime, nX, nY);
end;

function TMagicManager_MagMakeGroupTransparent(MagicManager: TMagicManager; BaseObject: TActorObject; nX, nY: Integer; nHTime: Integer): Boolean;
begin
  Result := MagicManager.MagMakeGroupTransparent(BaseObject, nX, nY, nHTime);
end;

function TMagicManager_MagTamming(MagicManager: TMagicManager; BaseObject, TargeTActorObject: TActorObject; nTargetX, nTargetY: Integer; nMagicLevel: Integer): Boolean;
begin
  Result := MagicManager.MagTamming(BaseObject, TargeTActorObject, nTargetX, nTargetY, nMagicLevel);
end;

function TMagicManager_MagSaceMove(MagicManager: TMagicManager; BaseObject: TActorObject; nLevel: Integer): Boolean;
begin
  Result := MagicManager.MagSaceMove(BaseObject, nLevel);
end;

function TMagicManager_MagMakeFireCross(MagicManager: TMagicManager; PlayObject: TPlayObject; nDamage, nHTime, nX, nY: Integer): Integer;
begin
  Result := MagicManager.MagMakeFireCross(PlayObject, nDamage, nHTime, nX, nY);
end;

function TMagicManager_MagBigExplosion(MagicManager: TMagicManager; BaseObject: TActorObject; nPower, nX, nY: Integer; nRage: Integer): Boolean;
begin
  Result := MagicManager.MagBigExplosion(BaseObject, nPower, nX, nY, nRage, 1);
end;

function TMagicManager_MagElecBlizzard(MagicManager: TMagicManager; BaseObject: TActorObject; nPower: Integer): Boolean;
begin
  Result := MagicManager.MagElecBlizzard(BaseObject, nPower);
end;

function TMagicManager_MabMabe(MagicManager: TMagicManager; BaseObject, TargeTActorObject: TActorObject; nPower, nLevel, nTargetX, nTargetY: Integer): Boolean;
begin
  Result := MagicManager.MabMabe(BaseObject, TargeTActorObject, nPower, nLevel, nTargetX, nTargetY);
end;

function TMagicManager_MagMakeSlave(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
begin
  Result := MagicManager.MagMakeSlave(PlayObject, UserMagic);
end;

function TMagicManager_MagMakeSinSuSlave(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
begin
  Result := MagicManager.MagMakeSinSuSlave(PlayObject, UserMagic);
end;

function TMagicManager_MagWindTebo(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
begin
  Result := MagicManager.MagWindTebo(PlayObject, UserMagic);
end;

function TMagicManager_MagGroupLightening(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject; var boSpellFire: Boolean): Boolean;
begin
  Result := MagicManager.MagGroupLightening(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject, boSpellFire);
end;

function TMagicManager_MagGroupAmyounsul(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
begin
  Result := MagicManager.MagGroupAmyounsul(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject);
end;

function TMagicManager_MagGroupDeDing(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
begin
  Result := MagicManager.MagGroupDeDing(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject);
end;

function TMagicManager_MagGroupMb(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
begin
  Result := MagicManager.MagGroupMb(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject);
end;

function TMagicManager_MagHbFireBall(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
begin
  Result := MagicManager.MagHbFireBall(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject);
end;

function TMagicManager_MagLightening(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject; var boSpellFire: Boolean): Boolean;
begin
  Result := MagicManager.MagLightening(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject, boSpellFire);
end;

function TMagicManager_MagMakeSlave_(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; sMonName: PChar; nCount, nHumLevel, nMonLevel: Integer): Boolean;
begin
  MagicManager.MagMakeSlave_(PlayObject, UserMagic, StrPas(sMonName), nCount, nHumLevel, nMonLevel);
end;

function TMagicManager_CheckAmulet(PlayObject: TPlayObject; nCount: Integer; nType: Integer; var Idx: Integer): Boolean;
begin
  Result := CheckAmulet(PlayObject, nCount, nType, Idx);
end;

procedure TMagicManager_UseAmulet(PlayObject: TPlayObject; nCount: Integer; nType: Integer; var Idx: Integer); stdcall;
begin
  UseAmulet(PlayObject, nCount, nType, Idx);
end;

function TMagicManager_MagMakeSuperFireCross(MagicManager: TMagicManager; PlayObject: TPlayObject; nDamage, nHTime, nX, nY: Integer; nCount: Integer): Integer;
begin
  Result := MagicManager.MagMakeSuperFireCross(PlayObject, nDamage, nHTime, nX, nY, nCount);
end;

function TMagicManager_MagMakeFireball(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
begin
  Result := MagicManager.MagMakeFireball(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject);
end;

function TMagicManager_MagTreatment(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; var nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
begin
  Result := MagicManager.MagTreatment(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject);
end;

function TMagicManager_MagMakeHellFire(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
begin
  Result := MagicManager.MagMakeHellFire(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject);
end;

function TMagicManager_MagMakeQuickLighting(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; var nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
begin
  Result := MagicManager.MagMakeQuickLighting(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject);
end;

function TMagicManager_MagMakeLighting(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
begin
  Result := MagicManager.MagMakeLighting(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject);
end;

function TMagicManager_MagMakeFireCharm(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
begin
  Result := MagicManager.MagMakeFireCharm(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject);
end;

function TMagicManager_MagMakeUnTreatment(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
begin
  Result := MagicManager.MagMakeUnTreatment(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject);
end;

function TMagicManager_MagMakePrivateTransparent(MagicManager: TMagicManager; PlayObject: TPlayObject; nDamage: Integer): Boolean;
begin
  Result := MagicManager.MagMakePrivateTransparent(PlayObject, nDamage);
end;

function TMagicManager_MagMakeLivePlayObject(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; TargeTActorObject: TActorObject): Boolean;
begin
  Result := MagicManager.MagMakeReAlive(PlayObject, UserMagic, TargeTActorObject);
end;

function TMagicManager_MagMakeArrestObject(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; TargeTActorObject: TActorObject): Boolean;
begin
  Result := MagicManager.MagMakeArrestObject(PlayObject, UserMagic, TargeTActorObject);
end;

function TMagicManager_MagChangePosition(MagicManager: TMagicManager; PlayObject: TPlayObject; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean;
begin
  Result := MagicManager.MagChangePosition(PlayObject, nTargetX, nTargetY);
end;

function TMagicManager_MagMakeFireDay(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean;
begin
  Result := MagicManager.MagMakeFireDay(PlayObject, UserMagic, nTargetX, nTargetY, TargeTActorObject);
end;

procedure TMagicManager_SetHookDoSpell(DoSpell: TDoSpell);
begin
  PlugInEngine.SetHookDoSpell := DoSpell;
end;

procedure TMerchant_SetCheckUserSelect(ObjectActionUserSelect: TObjectActionUserSelect);
begin
  PlugInEngine.PlayObjectUserSelect := ObjectActionUserSelect;
end;

function TMerchant_GetCheckUserSelect(): TObjectActionUserSelect;
begin
  Result := PlugInEngine.PlayObjectUserSelect;
end;

procedure TPlayObject_SetUserInPutInteger(PlayObject: TPlayObject; nData: Integer);
begin
  PlayObject.m_nInteger[0] := nData;
end;

procedure TPlayObject_SetUserInPutString(PlayObject: TPlayObject; pszData: PChar);
begin
  PlayObject.m_sString[0] := StrPas(pszData);
end;

{procedure TPlayObject_SetHookUserRunMsg(ObjectUserRunMsg: TObjectUserRunMsg);
begin
  PlugInEngine.ObjectUserRunMsg := ObjectUserRunMsg;
end; }

function TPlayObject_IncGold(PlayObject: TPlayObject; nAddGold: Integer): Boolean;
begin
  Result := PlayObject.IncGold(nAddGold);
end;

procedure TPlayObject_IncGameGold(PlayObject: TPlayObject; nAddGameGold: Integer);
begin
  PlayObject.IncGameGold(nAddGameGold);
end;

procedure TPlayObject_IncGamePoint(PlayObject: TPlayObject; nAddGamePoint: Integer);
begin
  PlayObject.IncGamePoint(nAddGamePoint);
end;

function TPlayObject_DecGold(PlayObject: TPlayObject; nDecGold: Integer): Boolean;
begin
  Result := PlayObject.DecGold(nDecGold);
end;

procedure TPlayObject_DecGameGold(PlayObject: TPlayObject; nDECGAMEGOLD: Integer);
begin
  PlayObject.DecGameGold(nDECGAMEGOLD);
end;

procedure TPlayObject_DecGamePoint(PlayObject: TPlayObject; nDECGAMEPOINT: Integer);
begin
  PlayObject.DecGamePoint(nDECGAMEPOINT);
end;

function TActorObject_GetPoseCreate(BaseObject: TActorObject): TActorObject;
begin
  Result := BaseObject.GetPoseCreate;
end;

function TUserEngine_GetStdItemList(): TObject;
begin
  Result := nil;
  if UserEngine <> nil then begin
    Result := TObject(UserEngine.StdItemList);
  end;
end;

function TUserEngine_GetMagicList(): TObject;
begin
  Result := nil;
  if UserEngine <> nil then begin
    Result := TObject(UserEngine.m_MagicList);
  end;
end;

function TUserEngine_FindMagic(nMagIdx: Integer): pTMagic;
begin
  Result := UserEngine.FindMagic(nMagIdx);
end;

function TUserEngine_AddMagic(Magic: pTMagic): Boolean;
begin
  Result := UserEngine.AddMagic(Magic);
end;

function TUserEngine_DelMagic(wMagicId: Word): Boolean;
begin
  Result := UserEngine.DelMagic(wMagicId);
end;

procedure TUserEngine_RandomUpgradeItem(Item: pTUserItem);
begin
  UserEngine.RandomUpgradeItem(Item);
end;

procedure TUserEngine_GetUnknowItemValue(Item: pTUserItem);
begin
  UserEngine.GetUnknowItemValue(Item);
end;

procedure TUserEngine_RandomUpgradeItem_(Item: pTUserItem);
begin

  UserEngine._RandomUpgradeItem(Item);

end;

procedure TUserEngine_GetUnknowItemValue_(Item: pTUserItem);
begin
  UserEngine._GetUnknowItemValue(Item);
end;

function TUserEngine_GetMaxPlayObjectCount(): Integer;
begin
  Result := 2000; //UserEngine.m_PlayObjectList.MaxCount;
end;

procedure TUserEngine_SetMaxPlayObjectCount(Buffer: PChar; nLen: Integer);
var
  sBuffer: string;
  //EngineOption: TEngineOption;
  Len: Integer;
begin
  if nLen > 0 then begin
    g_Buffer := Buffer;
    {SetLength(sBuffer, nLen);
    Move(Buffer^, Len, SizeOf(Integer));
    Move(Buffer[SizeOf(Integer)], sBuffer[1], nLen);
    DecryptBuffer(sBuffer, @EngineOption, SizeOf(TEngineOption));
    UserEngine.m_PlayObjectList.MaxCount := EngineOption.OnlineCount; }
   { MainOutMessage('PEngineOption.OnlineCount^:' + IntToStr(PEngineOption.OnlineCount^));
    MainOutMessage('EngineOption.OnlineCount:' + IntToStr(EngineOption.OnlineCount));
      //UserEngine.m_PlayObjectList.MaxCount := _MAX(PEngineOption.OnlineCount^ - abs(EngineOption.Mode - PEngineOption.Mode^) * 10000, 0);
    MainOutMessage('UserEngine.m_PlayObjectList.MaxCount:' + IntToStr(UserEngine.m_PlayObjectList.MaxCount));   }
  end;
end;

function TPlugOfEngine_GetUserVersion(): Integer;
begin
  Result := g_nUserLicense;
end;

function TPlugOfEngine_GetProcedureVersion(): Integer;
begin
  //Result := g_nProductVersion;
end;

function TPlugOfEngine_GetUpDateVersion(): Integer;
begin
  //Result := g_nUpDateVersion;
end;

function TPlugOfEngine_GetServerVersion(): Integer;
begin
  Result := HEROVERSION;
end;

procedure InitEngineOut();
begin
  g_EngineOut.List_Create := TList_Create;
  g_EngineOut.List_Free := TList_Free;
  g_EngineOut.List_Count := TList_Count;
  g_EngineOut.List_Add := TList_Add;
  g_EngineOut.List_Insert := TList_Insert;

  g_EngineOut.List_Get := TList_Get;
  g_EngineOut.List_Put := TList_Put;
  g_EngineOut.List_Delete := TList_Delete;
  g_EngineOut.List_Clear := TList_Clear;
  g_EngineOut.List_Exchange := TList_Exchange;

  g_EngineOut.StringList_Create := TStringList_Create;
  g_EngineOut.StringList_Free := TStringList_Free;
  g_EngineOut.StringList_Count := TStringList_Count;
  g_EngineOut.StringList_Add := TStringList_Add;
  g_EngineOut.StringList_AddObject := TStringList_AddObject;
  g_EngineOut.StringList_Insert := TStringList_Insert;
  g_EngineOut.StringList_Get := TStringList_Get;
  g_EngineOut.StringList_GetObject := TStringList_GetObject;
  g_EngineOut.StringList_Put := TStringList_Put;
  g_EngineOut.StringList_PutObject := TStringList_PutObject;
  g_EngineOut.StringList_Delete := TStringList_Delete;
  g_EngineOut.StringList_Clear := TStringList_Clear;
  g_EngineOut.StringList_Exchange := TStringList_Exchange;
  g_EngineOut.StringList_LoadFormFile := TStringList_LoadFormFile;
  g_EngineOut.StringList_SaveToFile := TStringList_SaveToFile;

  g_EngineOut.MainOutMessageAPI := @MainOutMessageAPI;
  g_EngineOut.AddGameDataLogAPI := @AddGameDataLogAPI;

  g_EngineOut.TGetGameGoldName := @GetGameGoldName;
  g_EngineOut.TEDcode_Decode6BitBuf := @EDcode_Decode6BitBuf;
  g_EngineOut.TEDcode_Encode6BitBuf := @EDcode_Encode6BitBuf;
  g_EngineOut.TEDcode_DeCodeString := @EDcode_DeCodeString;
  g_EngineOut.TEDcode_EncodeString := @EDcode_EncodeString;
  g_EngineOut.TEDcode_EncodeBuffer := @EDcode_EncodeBuffer;
  g_EngineOut.TEDcode_DecodeBuffer := @EDcode_DecodeBuffer;

  g_EngineOut.TConfig_sEnvirDir := @TConfig_sEnvirDir;
  g_EngineOut.TConfig_AmyOunsulPoint := @TConfig_AmyOunsulPoint;

  g_EngineOut.TActorObject_Create := @TActorObject_Create;
  g_EngineOut.TActorObject_Free := @TActorObject_Free;
  g_EngineOut.TActorObject_sMapFileName := @TActorObject_sMapFileName;
  g_EngineOut.TActorObject_sMapName := @TActorObject_sMapName;
  g_EngineOut.TActorObject_sMapNameA := @TActorObject_sMapNameA;
  g_EngineOut.TActorObject_sCharName := @TActorObject_sCharName;
  g_EngineOut.TActorObject_sCharNameA := @TActorObject_sCharNameA;

  g_EngineOut.TActorObject_nCurrX := @TActorObject_nCurrX;
  g_EngineOut.TActorObject_nCurrY := @TActorObject_nCurrY;
  g_EngineOut.TActorObject_btDirection := @TActorObject_btDirection;
  g_EngineOut.TActorObject_btGender := @TActorObject_btGender;
  g_EngineOut.TActorObject_btHair := @TActorObject_btHair;
  g_EngineOut.TActorObject_btJob := @TActorObject_btJob;
  g_EngineOut.TActorObject_nGold := @TActorObject_nGold;
  g_EngineOut.TActorObject_Ability := @TActorObject_Ability;

  g_EngineOut.TActorObject_WAbility := @TActorObject_WAbility;
  g_EngineOut.TActorObject_nCharStatus := @TActorObject_nCharStatus;
  g_EngineOut.TActorObject_sHomeMap := @TActorObject_sHomeMap;
  g_EngineOut.TActorObject_nHomeX := @TActorObject_nHomeX;
  g_EngineOut.TActorObject_nHomeY := @TActorObject_nHomeY;
  g_EngineOut.TActorObject_boOnHorse := @TActorObject_boOnHorse;
  g_EngineOut.TActorObject_btHorseType := @TActorObject_btHorseType;
  g_EngineOut.TActorObject_btDressEffType := @TActorObject_btDressEffType;
  g_EngineOut.TActorObject_nPkPoint := @TActorObject_nPkPoint;

  g_EngineOut.TActorObject_duBodyLuck := @TActorObject_duBodyLuck;
  g_EngineOut.TActorObject_nBodyLuckLevel := @TActorObject_nBodyLuckLevel;
  g_EngineOut.TActorObject_nFightZoneDieCount := @TActorObject_nFightZoneDieCount;
  g_EngineOut.TActorObject_nBonusPoint := @TActorObject_nBonusPoint;
  g_EngineOut.TActorObject_nCharStatusEx := @TActorObject_nCharStatusEx;
  g_EngineOut.TActorObject_dwFightExp := @TActorObject_dwFightExp;
  g_EngineOut.TActorObject_nViewRange := @TActorObject_nViewRange;
  g_EngineOut.TActorObject_wAppr := @TActorObject_wAppr;
  g_EngineOut.TActorObject_btRaceServer := @TActorObject_btRaceServer;
  g_EngineOut.TActorObject_btRaceImg := @TActorObject_btRaceImg;
  g_EngineOut.TActorObject_btHitPoint := @TActorObject_btHitPoint;
  g_EngineOut.TActorObject_nHitPlus := @TActorObject_nHitPlus;
  g_EngineOut.TActorObject_nHitDouble := @TActorObject_nHitDouble;
  g_EngineOut.TActorObject_boRecallSuite := @TActorObject_boRecallSuite;
  g_EngineOut.TActorObject_nHealthRecover := @TActorObject_nHealthRecover;
  g_EngineOut.TActorObject_nSpellRecover := @TActorObject_nSpellRecover;
  g_EngineOut.TActorObject_btAntiPoison := @TActorObject_btAntiPoison;
  g_EngineOut.TActorObject_nPoisonRecover := @TActorObject_nPoisonRecover;
  g_EngineOut.TActorObject_nAntiMagic := @TActorObject_nAntiMagic;
  g_EngineOut.TActorObject_nLuck := @TActorObject_nLuck;
  g_EngineOut.TActorObject_nPerHealth := @TActorObject_nPerHealth;
  g_EngineOut.TActorObject_nPerHealing := @TActorObject_nPerHealing;
  g_EngineOut.TActorObject_nPerSpell := @TActorObject_nPerSpell;
  g_EngineOut.TActorObject_btGreenPoisoningPoint := @TActorObject_btGreenPoisoningPoint;
  g_EngineOut.TActorObject_nGoldMax := @TActorObject_nGoldMax;
  g_EngineOut.TActorObject_btSpeedPoint := @TActorObject_btSpeedPoint;
  g_EngineOut.TActorObject_btPermission := @TActorObject_btPermission;
  g_EngineOut.TActorObject_nHitSpeed := @TActorObject_nHitSpeed;
  g_EngineOut.TActorObject_TargetCret := @TActorObject_TargetCret;
  g_EngineOut.TActorObject_LastHiter := @TActorObject_LastHiter;
  g_EngineOut.TActorObject_ExpHiter := @TActorObject_ExpHiter;

  g_EngineOut.TActorObject_btLifeAttrib := @TActorObject_btLifeAttrib;
  g_EngineOut.TActorObject_nSlaveType := @TActorObject_nSlaveType;
  g_EngineOut.TActorObject_Master := @TActorObject_Master;
  g_EngineOut.TActorObject_btAttatckMode := @TActorObject_btAttatckMode;
  g_EngineOut.TActorObject_btNameColor := @TActorObject_btNameColor;
  g_EngineOut.TActorObject_nLight := @TActorObject_nLight;
  g_EngineOut.TActorObject_ItemList := @TActorObject_ItemList;
  g_EngineOut.TActorObject_MagicList := @TActorObject_MagicList;
  g_EngineOut.TActorObject_MyGuild := @TActorObject_MyGuild;
  g_EngineOut.TActorObject_UseItems := @TActorObject_UseItems;
  g_EngineOut.TActorObject_btMonsterWeapon := @TActorObject_btMonsterWeapon;
  g_EngineOut.TActorObject_PEnvir := @TActorObject_PEnvir;
  g_EngineOut.TActorObject_boGhost := @TActorObject_boGhost;
  g_EngineOut.TActorObject_boDeath := @TActorObject_boDeath;
  g_EngineOut.TActorObject_DeleteBagItem := @TActorObject_DeleteBagItem;

  g_EngineOut.TActorObject_SendMsg := @TActorObject_SendMsg;
  g_EngineOut.TActorObject_SendRefMsg := @TActorObject_SendRefMsg;
  g_EngineOut.TActorObject_SendDelayMsg := @TActorObject_SendDelayMsg;

  g_EngineOut.TActorObject_SysMsg := @TActorObject_SysMsg;
  g_EngineOut.TActorObject_GetFrontPosition := @TActorObject_GetFrontPosition;
  g_EngineOut.TActorObject_GetRecallXY := @TActorObject_GetRecallXY;
  g_EngineOut.TActorObject_SpaceMove := @TActorObject_SpaceMove;
  g_EngineOut.TActorObject_FeatureChanged := @TActorObject_FeatureChanged;
  g_EngineOut.TActorObject_StatusChanged := @TActorObject_StatusChanged;
  g_EngineOut.TActorObject_GetFeatureToLong := @TActorObject_GetFeatureToLong;
  g_EngineOut.TActorObject_GetFeature := @TActorObject_GetFeature;
  g_EngineOut.TActorObject_GetCharColor := @TActorObject_GetCharColor;
  g_EngineOut.TActorObject_GetNamecolor := @TActorObject_GetNamecolor;
  g_EngineOut.TActorObject_GoldChanged := @TActorObject_GoldChanged;
  g_EngineOut.TActorObject_GameGoldChanged := @TActorObject_GameGoldChanged;
  g_EngineOut.TActorObject_MagCanHitTarget := @TActorObject_MagCanHitTarget;

  g_EngineOut.TActorObject_SetTargetCreat := @TActorObject_SetTargetCreat;
  g_EngineOut.TActorObject_IsProtectTarget := @TActorObject_IsProtectTarget;
  g_EngineOut.TActorObject_IsAttackTarget := @TActorObject_IsAttackTarget;
  g_EngineOut.TActorObject_IsProperTarget := @TActorObject_IsProperTarget;
  g_EngineOut.TActorObject_IsProperFriend := @TActorObject_IsProperFriend;
  g_EngineOut.TActorObject_TrainSkillPoint := @TActorObject_TrainSkillPoint;
  g_EngineOut.TActorObject_GetAttackPower := @TActorObject_GetAttackPower;
  g_EngineOut.TActorObject_MakeSlave := @TActorObject_MakeSlave;
  g_EngineOut.TActorObject_MakeGhost := @TActorObject_MakeGhost;
  g_EngineOut.TActorObject_RefNameColor := @TActorObject_RefNameColor;

  g_EngineOut.TActorObject_AddItemToBag := @TActorObject_AddItemToBag;
  g_EngineOut.TActorObject_ClearBagItem := @TActorObject_ClearBagItem;
  g_EngineOut.TActorObject_GetBaseObjectTick := @TActorObject_GetBaseObjectTick;

  g_EngineOut.TActorObject_MagMakeDefenceArea := @TActorObject_MagMakeDefenceArea;
  g_EngineOut.TActorObject_MagBubbleDefenceUp := @TActorObject_MagBubbleDefenceUp;

  g_EngineOut.TPlayObject_AddItemToStorage := @TPlayObject_AddItemToStorage;
  g_EngineOut.TPlayObject_ClearStorageItem := @TPlayObject_ClearStorageItem;
  g_EngineOut.TPlayObject_GroupOwner := @TPlayObject_GroupOwner;
  g_EngineOut.TPlayObject_GroupMembersList := @TPlayObject_GroupMembersList;
  g_EngineOut.TPlayObject_boHearWhisper := @TPlayObject_boHearWhisper;
  g_EngineOut.TPlayObject_boBanShout := @TPlayObject_boBanShout;
  g_EngineOut.TPlayObject_boBanGuildChat := @TPlayObject_boBanGuildChat;
  g_EngineOut.TPlayObject_boAllowDeal := @TPlayObject_boAllowDeal;
  g_EngineOut.TPlayObject_boAllowGroup := @TPlayObject_boAllowGroup;
  g_EngineOut.TPlayObject_boAllowGuild := @TPlayObject_boAllowGuild;
  g_EngineOut.TPlayObject_nHungerStatus := @TPlayObject_nHungerStatus;
  g_EngineOut.TPlayObject_boAllowGuildReCall := @TPlayObject_boAllowGuildReCall;
  g_EngineOut.TPlayObject_wGroupRcallTime := @TPlayObject_wGroupRcallTime;
  g_EngineOut.TPlayObject_boAllowGroupReCall := @TPlayObject_boAllowGroupReCall;
  g_EngineOut.TPlayObject_IsEnoughBag := @TPlayObject_IsEnoughBag;
  g_EngineOut.TPlayObject_nSoftVersionDate := @TPlayObject_nSoftVersionDate;
  g_EngineOut.TPlayObject_nSoftVersionDateEx := @TPlayObject_nSoftVersionDateEx;
  g_EngineOut.TPlayObject_dLogonTime := @TPlayObject_dLogonTime;
  g_EngineOut.TPlayObject_dwLogonTick := @TPlayObject_dwLogonTick;
  g_EngineOut.TPlayObject_nMemberType := @TPlayObject_nMemberType;
  g_EngineOut.TPlayObject_nMemberLevel := @TPlayObject_nMemberLevel;
  g_EngineOut.TPlayObject_nGameGold := @TPlayObject_nGameGold;
  g_EngineOut.TPlayObject_nGamePoint := @TPlayObject_nGamePoint;
  g_EngineOut.TPlayObject_nPayMentPoint := @TPlayObject_nPayMentPoint;
  g_EngineOut.TPlayObject_nClientFlag := @TPlayObject_nClientFlag;
  g_EngineOut.TPlayObject_nSelectID := @TPlayObject_nSelectID;
  g_EngineOut.TPlayObject_nClientFlagMode := @TPlayObject_nClientFlagMode;
  g_EngineOut.TPlayObject_dwClientTick := @TPlayObject_dwClientTick;
  g_EngineOut.TPlayObject_wClientType := @TPlayObject_wClientType;
  g_EngineOut.TPlayObject_sBankPassword := @TPlayObject_sBankPassword;
  g_EngineOut.TPlayObject_nBankGold := @TPlayObject_nBankGold;
  g_EngineOut.TPlayObject_Create := @TPlayObject_Create;
  g_EngineOut.TPlayObject_Free := @TPlayObject_Free;
  g_EngineOut.TPlayObject_SendSocket := @TPlayObject_SendSocket;
  g_EngineOut.TPlayObject_SendDefMessage := @TPlayObject_SendDefMessage;
  g_EngineOut.TPlayObject_SendAddItem := @TPlayObject_SendAddItem;
  g_EngineOut.TPlayObject_SendDelItem := @TPlayObject_SendDelItem;
  g_EngineOut.TPlayObject_TargetInNearXY := @TPlayObject_TargetInNearXY;
  g_EngineOut.TPlayObject_SetBankPassword := @TPlayObject_SetBankPassword;
  g_EngineOut.TPlayObject_MyHero := @TPlayObject_MyHero;


  g_EngineOut.TPlayObject_IncGold := @TPlayObject_IncGold;
  g_EngineOut.TPlayObject_IncGameGold := @TPlayObject_IncGameGold;
  g_EngineOut.TPlayObject_IncGamePoint := @TPlayObject_IncGamePoint;
  g_EngineOut.TPlayObject_DecGold := @TPlayObject_DecGold;
  g_EngineOut.TPlayObject_DecGameGold := @TPlayObject_DecGameGold;
  g_EngineOut.TPlayObject_DecGamePoint := @TPlayObject_DecGamePoint;
  g_EngineOut.TPlayObject_SetUserInPutInteger := @TPlayObject_SetUserInPutInteger;
  g_EngineOut.TPlayObject_SetUserInPutString := @TPlayObject_SetUserInPutString;
  g_EngineOut.TPlayObject_PlayUseItems := @TPlayObject_PlayUseItems;

  g_EngineOut.THeroObject_SendAddItem := @THeroObject_SendAddItem;
  g_EngineOut.THeroObject_SendDelItem := @THeroObject_SendDelItem;

  g_EngineOut.TNormNpc_sFilePath := @TNormNpc_sFilePath;
  g_EngineOut.TNormNpc_sPath := @TNormNpc_sPath;
  g_EngineOut.TNormNpc_GetLineVariableText := @TNormNpc_GetLineVariableText;

  g_EngineOut.TNormNpc_GetManageNpc := @TNormNpc_GetManageNpc;
  g_EngineOut.TNormNpc_GetFunctionNpc := @TNormNpc_GetFunctionNpc;
  g_EngineOut.TNormNpc_GotoLable := @TNormNpc_GotoLable;

  g_EngineOut.TUserEngine_GetPlayObject := @TUserEngine_GetPlayObject;

  g_EngineOut.TUserEngine_GetLoadPlayList := @TUserEngine_GetLoadPlayList;
  g_EngineOut.TUserEngine_GetPlayObjectList := @TUserEngine_GetPlayObjectList;
  g_EngineOut.TUserEngine_GetPlayObjectFreeList := @TUserEngine_GetPlayObjectFreeList;
  g_EngineOut.TUserEngine_GetLoadPlayCount := @TUserEngine_GetLoadPlayCount;
  g_EngineOut.TUserEngine_GetPlayObjectCount := @TUserEngine_GetPlayObjectCount;
  g_EngineOut.TUserEngine_GetStdItemByName := @TUserEngine_GetStdItemByName;
  g_EngineOut.TUserEngine_GetStdItemByIndex := @TUserEngine_GetStdItemByIndex;
  g_EngineOut.TUserEngine_CopyToUserItemFromName := @TUserEngine_CopyToUserItemFromName;
  g_EngineOut.TUserEngine_GetStdItemList := @TUserEngine_GetStdItemList;
  g_EngineOut.TUserEngine_GetMagicList := @TUserEngine_GetMagicList;

  g_EngineOut.TUserEngine_FindMagic := @TUserEngine_FindMagic;
  g_EngineOut.TUserEngine_AddMagic := @TUserEngine_AddMagic;
  g_EngineOut.TUserEngine_DelMagic := @TUserEngine_DelMagic;

  g_EngineOut.TUserEngine_RandomUpgradeItem := @TUserEngine_RandomUpgradeItem;
  g_EngineOut.TUserEngine_GetUnknowItemValue := @TUserEngine_GetUnknowItemValue;

  g_EngineOut.TUserEngine_RandomUpgradeItem_ := @TUserEngine_RandomUpgradeItem_;
  g_EngineOut.TUserEngine_GetUnknowItemValue_ := @TUserEngine_GetUnknowItemValue_;


  g_EngineOut.TMapManager_FindMap := @TMapManager_FindMap;
  g_EngineOut.TEnvirnoment_GetRangeActorObject := @TEnvirnoment_GetRangeActorObject;


  g_EngineOut.TGuild_RankList := @TGuild_RankList;

  g_EngineOut.ItemUnit_GetItemAddValue := @TItemUnit_GetItemAddValue;

  {g_EngineOut.TUserEngine_GetMaxPlayObjectCount := @TUserEngine_GetMaxPlayObjectCount;
  g_EngineOut.TUserEngine_SetMaxPlayObjectCount := @TUserEngine_SetMaxPlayObjectCount;  }
end;
initialization
  begin
    InitEngineOut();
  end;

end.

