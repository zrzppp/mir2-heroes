unit EngineAPI;

interface
uses
  Windows, EngineType;
function TList_Create(): TList; stdcall;
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
function TStringList_Add(List: TStringList; S: PChar): Integer; stdcall;
function TStringList_AddObject(List: TStringList; S: PChar; AObject: TObject): Integer; stdcall;
procedure TStringList_Insert(List: TStringList; nIndex: Integer; S: PChar); stdcall;
function TStringList_Get(List: TStringList; nIndex: Integer): PChar; stdcall;
function TStringList_GetObject(List: TStringList; nIndex: Integer): TObject; stdcall;
procedure TStringList_Put(List: TStringList; nIndex: Integer; S: PChar); stdcall;
procedure TStringList_PutObject(List: TStringList; nIndex: Integer; AObject: TObject); stdcall;
procedure TStringList_Delete(List: TStringList; nIndex: Integer); stdcall;
procedure TStringList_Clear(List: TStringList); stdcall;
procedure TStringList_Exchange(List: TStringList; nIndex1, nIndex2: Integer); stdcall;
procedure TStringList_LoadFormFile(List: TStringList; pszFileName: PChar); stdcall;
procedure TStringList_SaveToFile(List: TStringList; pszFileName: PChar); stdcall;
procedure MainOutMessage(pszMsg: PChar); stdcall;
procedure AddGameDataLog(pszMsg: PChar); stdcall;
function GetGameGoldName(): _LPTSHORTSTRING; stdcall;

procedure EDcode_Decode6BitBuf(pszSource: PChar; pszDest: PChar; nSrcLen, nDestLen: Integer); stdcall;
procedure EDcode_Encode6BitBuf(pszSource: PChar; pszDest: PChar; nSrcLen, nDestLen: Integer); stdcall;
procedure EDcode_SetDecode(Decode: _TEDCODE); stdcall;
procedure EDcode_SetEncode(Encode: _TEDCODE); stdcall;
procedure EDcode_DeCodeString(pszSource: PChar; pszDest: PChar); stdcall;
procedure EDcode_EncodeString(pszSource: PChar; pszDest: PChar); stdcall;
procedure EDcode_EncodeBuffer(Buf: PChar; bufsize: Integer; pszDest: PChar); stdcall;
procedure EDcode_DecodeBuffer(pszSource: PChar; pszDest: PChar; bufsize: Integer); stdcall;

function TConfig_sEnvirDir(): _LPTDIRNAME; stdcall;
function TConfig_AmyOunsulPoint: PInteger; stdcall;

function TActorObject_Create(): TActorObject; stdcall;
procedure TActorObject_Free(BaseObject: TActorObject); stdcall;
function TActorObject_sMapFileName(BaseObject: TActorObject): _LPTSHORTSTRING; stdcall;
function TActorObject_sMapName(BaseObject: TActorObject): _LPTSHORTSTRING; stdcall;
function TActorObject_sMapNameA(BaseObject: TActorObject): _LPTMAPNAME; stdcall;
function TActorObject_sCharName(BaseObject: TActorObject): _LPTSHORTSTRING; stdcall;
function TActorObject_sCharNameA(BaseObject: TActorObject): _LPTACTORNAME; stdcall;

function TActorObject_nCurrX(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_nCurrY(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_btDirection(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_btGender(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_btHair(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_btJob(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_nGold(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_Ability(BaseObject: TActorObject): _LPTABILITY; stdcall;

function TActorObject_WAbility(BaseObject: TActorObject): _LPTABILITY; stdcall;
function TActorObject_nCharStatus(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_sHomeMap(BaseObject: TActorObject): _LPTSHORTSTRING; stdcall;
function TActorObject_nHomeX(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_nHomeY(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_boOnHorse(BaseObject: TActorObject): PBoolean; stdcall;
function TActorObject_btHorseType(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_btDressEffType(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_nPkPoint(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_boAllowGroup(BaseObject: TActorObject): PBoolean; stdcall;
function TActorObject_boAllowGuild(BaseObject: TActorObject): PBoolean; stdcall;
function TActorObject_nFightZoneDieCount(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_nBonusPoint(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_nHungerStatus(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_boAllowGuildReCall(BaseObject: TActorObject): PBoolean; stdcall;
function TActorObject_duBodyLuck(BaseObject: TActorObject): PDouble; stdcall;
function TActorObject_nBodyLuckLevel(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_wGroupRcallTime(BaseObject: TActorObject): PWord; stdcall;
function TActorObject_boAllowGroupReCall(BaseObject: TActorObject): PBoolean; stdcall;
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
function TActorObject_GroupOwner(BaseObject: TActorObject): TActorObject; stdcall;
function TActorObject_GroupMembersList(BaseObject: TActorObject): TStringList; stdcall;
function TActorObject_boHearWhisper(BaseObject: TActorObject): PBoolean; stdcall;
function TActorObject_boBanShout(BaseObject: TActorObject): PBoolean; stdcall;
function TActorObject_boBanGuildChat(BaseObject: TActorObject): PBoolean; stdcall;
function TActorObject_boAllowDeal(BaseObject: TActorObject): PBoolean; stdcall;
function TActorObject_nSlaveType(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_Master(BaseObject: TActorObject): PTActorObject; stdcall;
function TActorObject_btAttatckMode(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_nNameColor(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_nLight(BaseObject: TActorObject): PInteger; stdcall;
function TActorObject_ItemList(BaseObject: TActorObject): TList; stdcall;
function TActorObject_MagicList(BaseObject: TActorObject): TList; stdcall;
function TActorObject_MyGuild(BaseObject: TActorObject): TGuild; stdcall;
function TActorObject_UseItems(BaseObject: TActorObject): _LPTPLAYUSEITEMS; stdcall;
function TActorObject_btMonsterWeapon(BaseObject: TActorObject): PByte; stdcall;
function TActorObject_PEnvir(BaseObject: TActorObject): PTEnvirnoment; stdcall;
function TActorObject_boGhost(BaseObject: TActorObject): PBoolean; stdcall;
function TActorObject_boDeath(BaseObject: TActorObject): PBoolean; stdcall;

function TActorObject_DeleteBagItem(BaseObject: TActorObject; UserItem: _LPTUSERITEM): BOOL; stdcall;

function TActorObject_AddCustomData(BaseObject: TActorObject; Data: Pointer): Integer; stdcall;
function TActorObject_GetCustomData(BaseObject: TActorObject; nIndex: Integer): Pointer; stdcall;

procedure TActorObject_SendMsg(SelfObject, BaseObject: TActorObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: PChar); stdcall;
procedure TActorObject_SendRefMsg(BaseObject: TActorObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: PChar); stdcall;
procedure TActorObject_SendDelayMsg(SelfObject, BaseObject: TActorObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: PChar; dwDelayTime: LongWord); stdcall;

procedure TActorObject_SysMsg(BaseObject: TActorObject; pszMsg: PChar; MsgColor: _TMSGCOLOR; MsgType: _TMSGTYPE); stdcall;
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
procedure TActorObject_TrainSkillPoint(BaseObject: TActorObject; UserMagic: _LPTUSERMAGIC; nTranPoint: Integer); stdcall;
function TActorObject_GetAttackPower(BaseObject: TActorObject; nBasePower, nPower: Integer): Integer; stdcall;
function TActorObject_MakeSlave(BaseObject: TActorObject; pszMonName: PChar; nMakeLevel, nExpLevel, nMaxMob, nType: Integer; dwRoyaltySec: LongWord): TActorObject; stdcall;
procedure TActorObject_MakeGhost(BaseObject: TActorObject); stdcall;
procedure TActorObject_RefNameColor(BaseObject: TActorObject); stdcall;
//AddItem 占用内存由自己处理，API内部会自动申请内存
function TActorObject_AddItemToBag(BaseObject: TActorObject; AddItem: _LPTUSERITEM): BOOL; stdcall;
function TActorObject_AddItemToStorage(BaseObject: TActorObject; AddItem: _LPTUSERITEM): BOOL; stdcall;
procedure TActorObject_ClearBagItem(BaseObject: TActorObject); stdcall;
procedure TActorObject_ClearStorageItem(BaseObject: TActorObject); stdcall;

procedure TActorObject_SetHookGetFeature(ObjectActionFeature: _TOBJECTACTIONFEATURE); stdcall;
procedure TActorObject_SetHookEnterAnotherMap(EnterAnotherMap: _TOBJECTACTIONENTERMAP); stdcall;
procedure TActorObject_SetHookObjectDie(ObjectDie: _TOBJECTACTIONEX); stdcall;
procedure TActorObject_SetHookChangeCurrMap(ChangeCurrMap: _TOBJECTACTIONEX); stdcall;
function TActorObject_GetPoseCreate(BaseObject: TActorObject): TActorObject; stdcall;
function TActorObject_MagMakeDefenceArea(BaseObject: TActorObject; nX, nY, nRange, nSec: Integer; btState: Byte; boState: Boolean): Integer; stdcall;
function TActorObject_MagBubbleDefenceUp(BaseObject: TActorObject; nLevel, nSec: Integer): Boolean; stdcall;

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
procedure TPlayObject_SendSocket(PlayObject: TPlayObject; DefMsg: _LPTDEFAULTMESSAGE; pszMsg: PChar); stdcall;
procedure TPlayObject_SendDefMessage(PlayObject: TPlayObject; wIdent: Word; nRecog: Integer; nParam, nTag, nSeries: Word; pszMsg: PChar); stdcall;

function TPlayObject_IsEnoughBag(PlayObject: TPlayObject): Boolean; stdcall;
procedure TPlayObject_SendAddItem(PlayObject: TPlayObject; AddItem: _LPTUSERITEM); stdcall;
procedure TPlayObject_SendDelItem(PlayObject: TPlayObject; DelItem: _LPTUSERITEM); stdcall;
function TPlayObject_TargetInNearXY(PlayObject: TPlayObject; Target: TActorObject; nX, nY: Integer): Boolean; stdcall;
procedure TPlayObject_SetBankPassword(PlayObject: TPlayObject; pszPassword: PChar); stdcall;

function TActorObject_GetBaseObjectTick(PlayObject: TActorObject; nCount: Integer): PLongWord; stdcall;

procedure TPlayObject_SetHookCreate( PlayObjectCreate: _TOBJECTACTION); stdcall;
function TPlayObject_GetHookCreate(): _TOBJECTACTION; stdcall;
procedure TPlayObject_SetHookDestroy( PlayObjectDestroy: _TOBJECTACTION); stdcall;
function TPlayObject_GetHookDestroy(): _TOBJECTACTION; stdcall;
procedure TPlayObject_SetHookUserLogin1(PlayObjectUserLogin: _TOBJECTACTION); stdcall;
procedure TPlayObject_SetHookUserLogin2(PlayObjectUserLogin: _TOBJECTACTION); stdcall;
procedure TPlayObject_SetHookUserLogin3(PlayObjectUserLogin: _TOBJECTACTION); stdcall;
procedure TPlayObject_SetHookUserLogin4(PlayObjectUserLogin: _TOBJECTACTION); stdcall;

procedure TPlayObject_SetHookUserCmd(PlayObjectUserCmd: _TOBJECTUSERCMD); stdcall;
function TPlayObject_GetHookUserCmd(): _TOBJECTUSERCMD; stdcall;

procedure TPlayObject_SetHookPlayOperateMessage(PlayObjectOperateMessage: _TOBJECTOPERATEMESSAGE); stdcall;
function TPlayObject_GetHookPlayOperateMessage(): _TOBJECTOPERATEMESSAGE; stdcall;
procedure TPlayObject_SetHookClientQueryBagItems(ClientQueryBagItems: _TOBJECTACTION); stdcall;
procedure TPlayObject_SetHookClientQueryUserState(ClientQueryUserState: _TOBJECTACTIONXY); stdcall;
procedure TPlayObject_SetHookSendActionGood(SendActionGood: _TOBJECTACTION); stdcall;
procedure TPlayObject_SetHookSendActionFail(SendActionFail: _TOBJECTACTION); stdcall;

procedure TPlayObject_SetHookSendWalkMsg(ObjectActioinXYD: _TOBJECTACTIONXYD); stdcall;
procedure TPlayObject_SetHookSendHorseRunMsg(ObjectActioinXYD: _TOBJECTACTIONXYD); stdcall;
procedure TPlayObject_SetHookSendRunMsg(ObjectActioinXYD: _TOBJECTACTIONXYD); stdcall;
procedure TPlayObject_SetHookSendDeathMsg(ObjectActioinXYDM: _TOBJECTACTIONXYDM); stdcall;
procedure TPlayObject_SetHookSendSkeletonMsg(ObjectActioinXYD: _TOBJECTACTIONXYD); stdcall;
procedure TPlayObject_SetHookSendAliveMsg(ObjectActioinXYD: _TOBJECTACTIONXYD); stdcall;
procedure TPlayObject_SetHookSendSpaceMoveMsg(ObjectActioinXYDWS: _TOBJECTACTIONXYDWS); stdcall;
procedure TPlayObject_SetHookSendChangeFaceMsg(ObjectActioinObject: _TOBJECTACTIONOBJECT); stdcall;
procedure TPlayObject_SetHookSendUseitemsMsg(ObjectActioin: _TOBJECTACTION); stdcall;
procedure TPlayObject_SetHookSendUserLevelUpMsg(ObjectActioinObject: _TOBJECTACTION); stdcall;
procedure TPlayObject_SetHookSendUserAbilieyMsg(ObjectActioinObject: _TOBJECTACTION); stdcall;
procedure TPlayObject_SetHookSendUserStatusMsg(ObjectActioinXYDWS: _TOBJECTACTIONXYDWS); stdcall;
procedure TPlayObject_SetHookSendUserStruckMsg(ObjectActioinObject: _TOBJECTACTIONOBJECT); stdcall;
procedure TPlayObject_SetHookSendUseMagicMsg(ObjectActioin: _TOBJECTACTION); stdcall;
procedure TPlayObject_SetHookSendSocket(SendSocket: _TPLAYSENDSOCKET); stdcall;
procedure TPlayObject_SetHookSendGoodsList(SendGoodsList: _TOBJECTACTIONSENDGOODS); stdcall;
procedure TPlayObject_SetCheckClientDropItem(ActionDropItem: _TOBJECTACTIONITEM); stdcall;
procedure TPlayObject_SetCheckClientDealItem(ActionItem: _TOBJECTACTIONITEM); stdcall;
procedure TPlayObject_SetCheckClientStorageItem(ActionItem: _TOBJECTACTIONITEM); stdcall;
procedure TPlayObject_SetCheckClientRepairItem(ActionItem: _TOBJECTACTIONITEM); stdcall;
procedure TPlayObject_SetHookCheckUserItems(ObjectActioin: _TOBJECTACTIONCHECKUSEITEM); stdcall;
procedure TPlayObject_SetHookRun(PlayRun: _TOBJECTACTION); stdcall;
procedure TPlayObject_SetHookFilterMsg(FilterMsg: _TOBJECTFILTERMSG); stdcall;


procedure TPlayObject_SetCheckClientUpgradeItem(ActionItem: _TOBJECTACTIONITEM); stdcall;
procedure TPlayObject_SetCheckClientSellItem(ActionItem: _TOBJECTACTIONITEM); stdcall;
procedure TActorObject_SetCheckClientNotScatterItem(ActionItem: _TOBJECTACTIONITEM); stdcall;
procedure TActorObject_SetCheckClientDieScatterItem(ActionItem: _TOBJECTACTIONITEM); stdcall;

procedure TPlayObject_SetHookOffLine(ObjectOffLine: _TOBJECTACTION); stdcall;


procedure TPlayObject_SetHookUserRunMsg(ObjectUserRunMsg: _TOBJECTUSERRUNMSG); stdcall;
procedure TPlayObject_SetUserInPutInteger(PlayObject: TPlayObject; nData: Integer); stdcall;
procedure TPlayObject_SetUserInPutString(PlayObject: TPlayObject; pszData: PChar); stdcall;
function TPlayObject_IncGold(PlayObject: TPlayObject; nAddGold: Integer): Boolean; stdcall;
procedure TPlayObject_IncGameGold(PlayObject: TPlayObject; nAddGameGold: Integer); stdcall;
procedure TPlayObject_IncGamePoint(PlayObject: TPlayObject; nAddGamePoint: Integer); stdcall;
function TPlayObject_DecGold(PlayObject: TPlayObject; nDecGold: Integer): Boolean; stdcall;
procedure TPlayObject_DecGameGold(PlayObject: TPlayObject; nDecGameGold: Integer); stdcall;
procedure TPlayObject_DecGamePoint(PlayObject: TPlayObject; nDecGamePoint: Integer); stdcall;
function TPlayObject_PlayUseItems(PlayObject: TPlayObject): _LPTPLAYUSEITEMS; stdcall;
function TPlayObject_MyHero(PlayObject: TPlayObject): PTActorObject; stdcall;
procedure THeroObject_SendAddItem(HeroObject: THeroObject; AddItem: _LPTUSERITEM); stdcall;
procedure THeroObject_SendDelItem(HeroObject: THeroObject; DelItem: _LPTUSERITEM); stdcall;


function TNormNpc_sFilePath(NormNpc: TNormNpc): _LPTPATHNAME; stdcall;
function TNormNpc_sPath(NormNpc: TNormNpc): _LPTPATHNAME; stdcall;
procedure TNormNpc_GetLineVariableText(NormNpc: TNormNpc; BaseObject: TActorObject; pszMsg: PChar; pszOutMsg: PChar; nOutMsgLen: Integer); stdcall;
procedure TNormNpc_SetScriptActionCmd( ActionCmd: _TSCRIPTCMD); stdcall;
function TNormNpc_GetScriptActionCmd(): _TSCRIPTCMD; stdcall;

procedure TNormNpc_SetScriptConditionCmd( ConditionCmd: _TSCRIPTCMD); stdcall;
function TNormNpc_GetScriptConditionCmd(): _TSCRIPTCMD; stdcall;

function TNormNpc_GetManageNpc(): TNormNpc; stdcall;
function TNormNpc_GetFunctionNpc(): TNormNpc; stdcall;
procedure TNormNpc_GotoLable(NormNpc: TNormNpc; PlayObject: TPlayObject; pszLabel: PChar); stdcall;

procedure TNormNpc_SetScriptAction( ScriptAction: _TSCRIPTACTION); stdcall;
function TNormNpc_GetScriptAction(): _TSCRIPTACTION; stdcall;

procedure TNormNpc_SetScriptCondition( ScriptAction: _TSCRIPTCONDITION); stdcall;
function TNormNpc_GetScriptCondition(): _TSCRIPTCONDITION; stdcall;
function TMerchant_GoodsList(Merchant: TMerchant): TList; stdcall;

function TMerchant_GetItemPrice(Merchant: TMerchant; nIndex: Integer): Integer; stdcall;
function TMerchant_GetUserPrice(Merchant: TMerchant; PlayObject: TPlayObject; nPrice: Integer): Integer; stdcall;
function TMerchant_GetUserItemPrice(Merchant: TMerchant; UserItem: _LPTUSERITEM): Integer; stdcall;

procedure TMerchant_SetHookClientGetDetailGoodsList(GetDetailGoods: _TOBJECTACTIONDETAILGOODS); stdcall;
function TMerchant_SetCheckUserSelect( ObjectActionUserSelect: _TOBJECTACTIONUSERSELECT): Boolean; stdcall;
function TMerchant_GetCheckUserSelect(): _TOBJECTACTIONUSERSELECT; stdcall;

function TUserEngine_Create(): TUserEngine; stdcall;
procedure TUserEngine_Free(UserEngine: TUserEngine); stdcall;
function TUserEngine_GetUserEngine(): TUserEngine; stdcall;

function TUserEngine_GetPlayObject(szPlayName: PChar; boGetHide: Boolean): TPlayObject; stdcall;

function TUserEngine_GetLoadPlayList(): TStringList; stdcall;
function TUserEngine_GetPlayObjectList(): TStringList; stdcall;
function TUserEngine_GetLoadPlayCount(): Integer; stdcall;
function TUserEngine_GetPlayObjectCount(): Integer; stdcall;
function TUserEngine_GetStdItemByName(pszItemName: PChar): _LPTSTDITEM; stdcall;
function TUserEngine_GetStdItemByIndex(nIndex: Integer): _LPTSTDITEM; stdcall;
function TUserEngine_CopyToUserItemFromName(const pszItemName: PChar; UserItem: _LPTUSERITEM): BOOL; stdcall;

function TUserEngine_GetStdItemList(): TList; stdcall;
function TUserEngine_GetMagicList(): TList; stdcall;
function TUserEngine_FindMagic(nMagIdx: Integer): _LPTMAGIC; stdcall;
function TUserEngine_AddMagic(Magic: _LPTMAGIC): Boolean; stdcall;
function TUserEngine_DelMagic(wMagicId: Word): Boolean; stdcall;

function TMapManager_FindMap(pszMapName: PChar): TEnvirnoment; stdcall;
function TEnvirnoment_GetRangeActorObject(Envir: TEnvirnoment; nX, nY, nRage: Integer; boFlag: Boolean; BaseObjectList: TList): Integer; stdcall;
function TEnvirnoment_boCANRIDE(Envir: TEnvirnoment): PBoolean; stdcall;
function TEnvirnoment_boCANBAT(Envir: TEnvirnoment): PBoolean; stdcall;

procedure TUserEngine_SetHookRun( UserEngineRun: _TOBJECTACTION); stdcall;
function TUserEngine_GetHookRun(): _TOBJECTACTION; stdcall;
procedure TUserEngine_SetHookClientUserMessage(ClientMsg: _TOBJECTCLIENTMSG); stdcall;
procedure TUserEngine_RandomUpgradeItem(Item: _LPTUSERITEM); stdcall;
procedure TUserEngine_GetUnknowItemValue(Item: _LPTUSERITEM); stdcall;
procedure TUserEngine_RandomUpgradeItem_(Item: _LPTUSERITEM); stdcall;
procedure TUserEngine_GetUnknowItemValue_(Item: _LPTUSERITEM); stdcall;

function TGuild_RankList(Guild: TGuild): TList; stdcall;

procedure TItemUnit_GetItemAddValue(UserItem: _LPTUSERITEM; var StdItem: _TSTDITEM); stdcall;

function TMagicManager_GetMagicManager(): TMagicManager; stdcall;
function TMagicManager_DoSpell(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean; stdcall;

function TMagicManager_MPow(UserMagic: _LPTUSERMAGIC): Integer; stdcall;
function TMagicManager_GetPower(nPower: Integer; UserMagic: _LPTUSERMAGIC): Integer; stdcall;
function TMagicManager_GetPower13(nInt: Integer; UserMagic: _LPTUSERMAGIC): Integer; stdcall;
function TMagicManager_GetRPow(wInt: Integer): Word; stdcall;
function TMagicManager_IsWarrSkill(MagicManager: TMagicManager; wMagIdx: Integer): Boolean; stdcall;

function TMagicManager_MagBigHealing(MagicManager: TMagicManager; PlayObject: TActorObject; nPower, nX, nY: Integer): Boolean; stdcall;
function TMagicManager_MagPushArround(MagicManager: TMagicManager; PlayObject: TActorObject; nPushLevel: Integer): Integer; stdcall;
function TMagicManager_MagPushArroundTaos(MagicManager: TMagicManager; PlayObject: TActorObject; nPushLevel: Integer): Integer; stdcall;
function TMagicManager_MagTurnUndead(MagicManager: TMagicManager; BaseObject, TargeTActorObject: TActorObject; nTargetX, nTargetY: Integer; nLevel: Integer): Boolean; stdcall;
function TMagicManager_MagMakeHolyCurtain(MagicManager: TMagicManager; BaseObject: TActorObject; nPower: Integer; nX, nY: Integer): Integer; stdcall;
function TMagicManager_MagMakeGroupTransparent(MagicManager: TMagicManager; BaseObject: TActorObject; nX, nY: Integer; nHTime: Integer): Boolean; stdcall;
function TMagicManager_MagTamming(MagicManager: TMagicManager; BaseObject, TargeTActorObject: TActorObject; nTargetX, nTargetY: Integer; nMagicLevel: Integer): Boolean; stdcall;
function TMagicManager_MagSaceMove(MagicManager: TMagicManager; BaseObject: TActorObject; nLevel: Integer): Boolean; stdcall;
function TMagicManager_MagMakeFireCross(MagicManager: TMagicManager; PlayObject: TPlayObject; nDamage, nHTime, nX, nY: Integer): Integer; stdcall;
function TMagicManager_MagBigExplosion(MagicManager: TMagicManager; BaseObject: TActorObject; nPower, nX, nY: Integer; nRage: Integer): Boolean; stdcall;
function TMagicManager_MagElecBlizzard(MagicManager: TMagicManager; BaseObject: TActorObject; nPower: Integer): Boolean; stdcall;
function TMagicManager_MabMabe(MagicManager: TMagicManager; BaseObject, TargeTActorObject: TActorObject; nPower, nLevel, nTargetX, nTargetY: Integer): Boolean; stdcall;
function TMagicManager_MagMakeSlave(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC): Boolean; stdcall;
function TMagicManager_MagMakeSinSuSlave(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC): Boolean; stdcall;
function TMagicManager_MagWindTebo(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC): Boolean; stdcall;
function TMagicManager_MagGroupLightening(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject; var boSpellFire: Boolean): Boolean; stdcall;
function TMagicManager_MagGroupAmyounsul(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean; stdcall;
function TMagicManager_MagGroupDeDing(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean; stdcall;
function TMagicManager_MagGroupMb(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean; stdcall;
function TMagicManager_MagHbFireBall(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean; stdcall;
function TMagicManager_MagLightening(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject; var boSpellFire: Boolean): Boolean; stdcall;
function TMagicManager_CheckAmulet(PlayObject: TPlayObject; nCount: Integer; nType: Integer; var Idx: Integer): Boolean; stdcall;
procedure TMagicManager_UseAmulet(PlayObject: TPlayObject; nCount: Integer; nType: Integer; var Idx: Integer); stdcall;
function TMagicManager_MagMakeSuperFireCross(MagicManager: TMagicManager; PlayObject: TPlayObject; nDamage, nHTime, nX, nY: Integer; nCount: Integer): Integer; stdcall;
function TMagicManager_MagMakePrivateTransparent(MagicManager: TMagicManager; PlayObject: TPlayObject; nDamage: Integer): Boolean; stdcall;

function TMagicManager_MagMakeFireball(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean; stdcall;
function TMagicManager_MagTreatment(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; var nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean; stdcall;
function TMagicManager_MagMakeHellFire(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean; stdcall;
function TMagicManager_MagMakeQuickLighting(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; var nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean; stdcall;
function TMagicManager_MagMakeLighting(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean; stdcall;
function TMagicManager_MagMakeFireCharm(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean; stdcall;
function TMagicManager_MagMakeUnTreatment(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean; stdcall;
function TMagicManager_MagMakeLivePlayObject(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; TargeTActorObject: TActorObject): Boolean; stdcall;
function TMagicManager_MagMakeArrestObject(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; TargeTActorObject: TActorObject): Boolean; stdcall;
function TMagicManager_MagChangePosition(MagicManager: TMagicManager; PlayObject: TPlayObject; nTargetX, nTargetY: Integer; TargeTActorObject: TActorObject): Boolean; stdcall;
function TMagicManager_MagMakeFireDay(MagicManager: TMagicManager; PlayObject: TPlayObject; UserMagic: _LPTUSERMAGIC; nTargetX, nTargetY: Integer; var TargeTActorObject: TActorObject): Boolean; stdcall;

procedure TMagicManager_SetHookDoSpell(DoSpell: _TDOSPELL); stdcall;

function TPlugOfEngine_GetProductVersion(): Integer; stdcall;
function TPlugOfEngine_GetUpDateVersion(): Integer; stdcall;
procedure ShortStringToPChar(S: _LPTSHORTSTRING; pszDest: PChar);
implementation
//将短字符类型的数据转换成PChar
//pszDest指向的字符大小在256个字符
procedure ShortStringToPChar(S: _LPTSHORTSTRING; pszDest: PChar);
begin
  Move(S.Strings, pszDest^, S.btLen);
  pszDest[S.btLen] := #0;
end;

function TList_Create; external LibName name 'TList_Create';
procedure TList_Free; external LibName name 'TList_Free';
function TList_Count; external LibName name 'TList_Count';
function TList_Add; external LibName name 'TList_Add';
procedure TList_Insert; external LibName name 'TList_Insert';
function TList_Get; external LibName name 'TList_Get';
procedure TList_Put; external LibName name 'TList_Put';
procedure TList_Delete; external LibName name 'TList_Delete';
procedure TList_Clear; external LibName name 'TList_Delete';
procedure TList_Exchange; external LibName name 'TList_Delete';

function TStringList_Create; external LibName name 'TStringList_Create';
procedure TStringList_Free; external LibName name 'TStringList_Free';
function TStringList_Count; external LibName name 'TStringList_Count';
function TStringList_Add; external LibName name 'TStringList_Add';
function TStringList_AddObject; external LibName name 'TStringList_AddObject';
procedure TStringList_Insert; external LibName name 'TStringList_Insert';
function TStringList_Get; external LibName name 'TStringList_Get';
function TStringList_GetObject; external LibName name 'TStringList_GetObject';
procedure TStringList_Put; external LibName name 'TStringList_Put';
procedure TStringList_PutObject; external LibName name 'TStringList_PutObject';
procedure TStringList_Delete; external LibName name 'TStringList_Delete';
procedure TStringList_Clear; external LibName name 'TStringList_Clear';
procedure TStringList_Exchange; external LibName name 'TStringList_Exchange';
procedure TStringList_LoadFormFile; external LibName name 'TStringList_Exchange';
procedure TStringList_SaveToFile; external LibName name 'TStringList_Exchange';

procedure MainOutMessage; external LibName name 'MainOutMessageAPI';
procedure AddGameDataLog; external LibName name 'AddGameDataLogAPI';
function GetGameGoldName; external LibName name 'GetGameGoldName';

procedure EDcode_Decode6BitBuf; external LibName name 'EDcode_Decode6BitBuf';
procedure EDcode_Encode6BitBuf; external LibName name 'EDcode_Encode6BitBuf';
procedure EDcode_SetDecode; external LibName name 'EDcode_SetDecode';
procedure EDcode_SetEncode; external LibName name 'EDcode_SetEncode';
procedure EDcode_DeCodeString; external LibName name 'EDcode_DeCodeString';
procedure EDcode_EncodeString; external LibName name 'EDcode_EncodeString';
procedure EDcode_EncodeBuffer; external LibName name 'EDcode_EncodeBuffer';
procedure EDcode_DecodeBuffer; external LibName name 'EDcode_DecodeBuffer';

function TConfig_sEnvirDir; external LibName name 'TConfig_sEnvirDir';
function TConfig_AmyOunsulPoint; external LibName name 'TConfig_AmyOunsulPoint';

function TActorObject_Create; external LibName name 'TBaseObject_Create';
procedure TActorObject_Free; external LibName name 'TBaseObject_Free';
function TActorObject_sMapFileName; external LibName name 'TBaseObject_sMapFileName';
function TActorObject_sMapName; external LibName name 'TBaseObject_sMapName';
function TActorObject_sMapNameA; external LibName name 'TBaseObject_sMapNameA';
function TActorObject_sCharName; external LibName name 'TBaseObject_sCharName';
function TActorObject_sCharNameA; external LibName name 'TBaseObject_sCharNameA';
function TActorObject_nCurrX; external LibName name 'TBaseObject_nCurrX';
function TActorObject_nCurrY; external LibName name 'TBaseObject_nCurrY';
function TActorObject_btDirection; external LibName name 'TBaseObject_btDirection';
function TActorObject_btGender; external LibName name 'TBaseObject_btGender';
function TActorObject_btHair; external LibName name 'TBaseObject_btHair';
function TActorObject_btJob; external LibName name 'TBaseObject_btJob';
function TActorObject_nGold; external LibName name 'TBaseObject_nGold';
function TActorObject_Ability; external LibName name 'TBaseObject_Ability';

function TActorObject_WAbility; external LibName name 'TBaseObject_WAbility';
function TActorObject_nCharStatus; external LibName name 'TBaseObject_nCharStatus';
function TActorObject_sHomeMap; external LibName name 'TBaseObject_sHomeMap';
function TActorObject_nHomeX; external LibName name 'TBaseObject_nHomeX';
function TActorObject_nHomeY; external LibName name 'TBaseObject_nHomeY';

function TActorObject_boOnHorse; external LibName name 'TBaseObject_boOnHorse';
function TActorObject_btHorseType; external LibName name 'TBaseObject_btHorseType';
function TActorObject_btDressEffType; external LibName name 'TBaseObject_btDressEffType';
function TActorObject_nPkPoint; external LibName name 'TBaseObject_nPkPoint';
function TActorObject_boAllowGroup; external LibName name 'TBaseObject_boAllowGroup';
function TActorObject_boAllowGuild; external LibName name 'TBaseObject_boAllowGuild';
function TActorObject_nFightZoneDieCount; external LibName name 'TBaseObject_nFightZoneDieCount';
function TActorObject_nBonusPoint; external LibName name 'TBaseObject_nBonusPoint';
function TActorObject_nHungerStatus; external LibName name 'TBaseObject_nHungerStatus';
function TActorObject_boAllowGuildReCall; external LibName name 'TBaseObject_boAllowGuildReCall';
function TActorObject_duBodyLuck; external LibName name 'TBaseObject_duBodyLuck';
function TActorObject_nBodyLuckLevel; external LibName name 'TBaseObject_nBodyLuckLevel';
function TActorObject_wGroupRcallTime; external LibName name 'TBaseObject_wGroupRcallTime';
function TActorObject_boAllowGroupReCall; external LibName name 'TBaseObject_boAllowGroupReCall';
function TActorObject_nCharStatusEx; external LibName name 'TBaseObject_nCharStatusEx';
function TActorObject_dwFightExp; external LibName name 'TBaseObject_dwFightExp';
function TActorObject_nViewRange; external LibName name 'TBaseObject_nViewRange';
function TActorObject_wAppr; external LibName name 'TBaseObject_wAppr';
function TActorObject_btRaceServer; external LibName name 'TBaseObject_btRaceServer';
function TActorObject_btRaceImg; external LibName name 'TBaseObject_btRaceImg';
function TActorObject_btHitPoint; external LibName name 'TBaseObject_btHitPoint';
function TActorObject_nHitPlus; external LibName name 'TBaseObject_nHitPlus';
function TActorObject_nHitDouble; external LibName name 'TBaseObject_nHitDouble';
function TActorObject_boRecallSuite; external LibName name 'TBaseObject_boRecallSuite';
function TActorObject_nHealthRecover; external LibName name 'TBaseObject_nHealthRecover';
function TActorObject_nSpellRecover; external LibName name 'TBaseObject_nSpellRecover';
function TActorObject_btAntiPoison; external LibName name 'TBaseObject_btAntiPoison';
function TActorObject_nPoisonRecover; external LibName name 'TBaseObject_nPoisonRecover';
function TActorObject_nAntiMagic; external LibName name 'TBaseObject_nAntiMagic';
function TActorObject_nLuck; external LibName name 'TBaseObject_nLuck';
function TActorObject_nPerHealth; external LibName name 'TBaseObject_nPerHealth';
function TActorObject_nPerHealing; external LibName name 'TBaseObject_nPerHealing';
function TActorObject_nPerSpell; external LibName name 'TBaseObject_nPerSpell';
function TActorObject_btGreenPoisoningPoint; external LibName name 'TBaseObject_btGreenPoisoningPoint';
function TActorObject_nGoldMax; external LibName name 'TBaseObject_nGoldMax';
function TActorObject_btSpeedPoint; external LibName name 'TBaseObject_btSpeedPoint';
function TActorObject_btPermission; external LibName name 'TBaseObject_btPermission';
function TActorObject_nHitSpeed; external LibName name 'TBaseObject_nHitSpeed';
function TActorObject_TargetCret; external LibName name 'TBaseObject_TargetCret';
function TActorObject_LastHiter; external LibName name 'TBaseObject_LastHiter';
function TActorObject_ExpHiter; external LibName name 'TBaseObject_ExpHitter';
function TActorObject_btLifeAttrib; external LibName name 'TBaseObject_btLifeAttrib';
function TActorObject_GroupOwner; external LibName name 'TBaseObject_GroupOwner';
function TActorObject_GroupMembersList; external LibName name 'TBaseObject_GroupMembersList';
function TActorObject_boHearWhisper; external LibName name 'TBaseObject_boHearWhisper';
function TActorObject_boBanShout; external LibName name 'TBaseObject_boBanShout';
function TActorObject_boBanGuildChat; external LibName name 'TBaseObject_boBanGuildChat';
function TActorObject_boAllowDeal; external LibName name 'TBaseObject_boAllowDeal';
function TActorObject_nSlaveType; external LibName name 'TBaseObject_nSlaveType';
function TActorObject_Master; external LibName name 'TBaseObject_Master';
function TActorObject_btAttatckMode; external LibName name 'TBaseObject_btAttatckMode';
function TActorObject_nNameColor; external LibName name 'TBaseObject_nNameColor';
function TActorObject_nLight; external LibName name 'TBaseObject_nLight';
function TActorObject_ItemList; external LibName name 'TBaseObject_ItemList';
function TActorObject_MagicList; external LibName name 'TBaseObject_MagicList';
function TActorObject_MyGuild; external LibName name 'TBaseObject_MyGuild';
function TActorObject_UseItems; external LibName name 'TBaseObject_UseItems';
function TActorObject_btMonsterWeapon; external LibName name 'TBaseObject_btMonsterWeapon';
function TActorObject_PEnvir; external LibName name 'TBaseObject_PEnvir';
function TActorObject_boGhost; external LibName name 'TBaseObject_boGhost';
function TActorObject_boDeath; external LibName name 'TBaseObject_boDeath';

function TActorObject_DeleteBagItem; external LibName name 'TBaseObject_DeleteBagItem';

function TActorObject_AddCustomData; external LibName name 'TBaseObject_AddCustomData';
function TActorObject_GetCustomData; external LibName name 'TBaseObject_GetCustomData';

procedure TActorObject_SendMsg; external LibName name 'TBaseObject_SendMsg';
procedure TActorObject_SendRefMsg; external LibName name 'TBaseObject_SendRefMsg';
procedure TActorObject_SendDelayMsg; external LibName name 'TBaseObject_SendDelayMsg';

procedure TActorObject_SysMsg; external LibName name 'TBaseObject_SysMsg';
function TActorObject_GetFrontPosition; external LibName name 'TBaseObject_GetFrontPosition';
function TActorObject_GetRecallXY; external LibName name 'TBaseObject_GetRecallXY';
procedure TActorObject_SpaceMove; external LibName name 'TBaseObject_SpaceMove';
procedure TActorObject_FeatureChanged; external LibName name 'TBaseObject_FeatureChanged';
procedure TActorObject_StatusChanged; external LibName name 'TBaseObject_StatusChanged';
function TActorObject_GetFeatureToLong; external LibName name 'TBaseObject_GetFeatureToLong';
function TActorObject_GetFeature; external LibName name 'TBaseObject_GetFeature';
function TActorObject_GetCharColor; external LibName name 'TBaseObject_GetCharColor';
function TActorObject_GetNamecolor; external LibName name 'TBaseObject_GetNamecolor';
procedure TActorObject_GoldChanged; external LibName name 'TBaseObject_GoldChanged';
procedure TActorObject_GameGoldChanged; external LibName name 'TBaseObject_GameGoldChanged';
function TActorObject_MagCanHitTarget; external LibName name 'TBaseObject_MagCanHitTarget';
procedure TActorObject_SetTargetCreat; external LibName name 'TBaseObject_SetTargetCreat';
function TActorObject_IsProtectTarget; external LibName name 'TBaseObject_IsProtectTarget';
function TActorObject_IsAttackTarget; external LibName name 'TBaseObject_IsAttackTarget';
function TActorObject_IsProperTarget; external LibName name 'TBaseObject_IsProperTarget';
function TActorObject_IsProperFriend; external LibName name 'TBaseObject_IsProperFriend';
procedure TActorObject_TrainSkillPoint; external LibName name 'TBaseObject_TrainSkillPoint';
function TActorObject_GetAttackPower; external LibName name 'TBaseObject_GetAttackPower';
function TActorObject_MakeSlave; external LibName name 'TBaseObject_MakeSlave';
procedure TActorObject_MakeGhost; external LibName name 'TBaseObject_MakeGhost';
procedure TActorObject_RefNameColor; external LibName name 'TBaseObject_RefNameColor';
function TActorObject_AddItemToBag; external LibName name 'TBaseObject_AddItemToBag';
function TActorObject_AddItemToStorage; external LibName name 'TBaseObject_AddItemToStorage';
procedure TActorObject_ClearBagItem; external LibName name 'TBaseObject_ClearBagItem';
procedure TActorObject_ClearStorageItem; external LibName name 'TBaseObject_ClearStorageItem';

procedure TActorObject_SetHookGetFeature; external LibName name 'TBaseObject_SetHookGetFeature';
procedure TActorObject_SetHookEnterAnotherMap; external LibName name 'TBaseObject_SetHookEnterAnotherMap';
procedure TActorObject_SetHookObjectDie; external LibName name 'TBaseObject_SetHookObjectDie';
procedure TActorObject_SetHookChangeCurrMap; external LibName name 'TBaseObject_SetHookChangeCurrMap';
function TActorObject_GetPoseCreate; external LibName name 'TBaseObject_GetPoseCreate';
function TActorObject_MagMakeDefenceArea; external LibName name 'TBaseObject_MagMakeDefenceArea';
function TActorObject_MagBubbleDefenceUp; external LibName name 'TBaseObject_MagBubbleDefenceUp';

function TPlayObject_nSoftVersionDate; external LibName name 'TPlayObject_nSoftVersionDate';
function TPlayObject_nSoftVersionDateEx; external LibName name 'TPlayObject_nSoftVersionDateEx';
function TPlayObject_dLogonTime; external LibName name 'TPlayObject_dLogonTime';
function TPlayObject_dwLogonTick; external LibName name 'TPlayObject_dwLogonTick';
function TPlayObject_nMemberType; external LibName name 'TPlayObject_nMemberType';
function TPlayObject_nMemberLevel; external LibName name 'TPlayObject_nMemberLevel';
function TPlayObject_nGameGold; external LibName name 'TPlayObject_nGameGold';
function TPlayObject_nGamePoint; external LibName name 'TPlayObject_nGamePoint';
function TPlayObject_nPayMentPoint; external LibName name 'TPlayObject_nPayMentPoint';
function TPlayObject_nClientFlag; external LibName name 'TPlayObject_nClientFlag';
function TPlayObject_nSelectID; external LibName name 'TPlayObject_nSelectID';
function TPlayObject_nClientFlagMode; external LibName name 'TPlayObject_nClientFlagMode';
function TPlayObject_dwClientTick; external LibName name 'TPlayObject_dwClientTick';
function TPlayObject_wClientType; external LibName name 'TPlayObject_wClientType';
function TPlayObject_sBankPassword; external LibName name 'TPlayObject_sBankPassword';
function TPlayObject_nBankGold; external LibName name 'TPlayObject_nBankGold';

function TPlayObject_Create; external LibName name 'TPlayObject_Create';
procedure TPlayObject_Free; external LibName name 'TPlayObject_Free';
procedure TPlayObject_SendSocket; external LibName name 'TPlayObject_SendSocket';
procedure TPlayObject_SendDefMessage; external LibName name 'TPlayObject_SendDefMessage';
procedure TPlayObject_SendAddItem; external LibName name 'TPlayObject_SendAddItem';
procedure TPlayObject_SendDelItem; external LibName name 'TPlayObject_SendDelItem';
function TPlayObject_TargetInNearXY; external LibName name 'TPlayObject_TargetInNearXY';
procedure TPlayObject_SetBankPassword; external LibName name 'TPlayObject_SetBankPassword';

function TActorObject_GetBaseObjectTick; external LibName name 'TBaseObject_GetBaseObjectTick';

procedure TPlayObject_SetHookCreate; external LibName name 'TPlayObject_SetHookCreate';
function TPlayObject_GetHookCreate; external LibName name 'TPlayObject_GetHookCreate';
procedure TPlayObject_SetHookDestroy; external LibName name 'TPlayObject_SetHookDestroy';
function TPlayObject_GetHookDestroy; external LibName name 'TPlayObject_GetHookDestroy';
procedure TPlayObject_SetHookUserLogin1; external LibName name 'TPlayObject_SetHookUserLogin1';
procedure TPlayObject_SetHookUserLogin2; external LibName name 'TPlayObject_SetHookUserLogin2';
procedure TPlayObject_SetHookUserLogin3; external LibName name 'TPlayObject_SetHookUserLogin3';
procedure TPlayObject_SetHookUserLogin4; external LibName name 'TPlayObject_SetHookUserLogin4';
procedure TPlayObject_SetHookUserCmd; external LibName name 'TPlayObject_SetHookUserCmd';
function TPlayObject_GetHookUserCmd; external LibName name 'TPlayObject_GetHookUserCmd';

procedure TPlayObject_SetHookPlayOperateMessage; external LibName name 'TPlayObject_SetHookPlayOperateMessage';
function TPlayObject_GetHookPlayOperateMessage; external LibName name 'TPlayObject_GetHookPlayOperateMessage';

procedure TPlayObject_SetHookClientQueryBagItems; external LibName name 'TPlayObject_SetHookClientQueryBagItems';
procedure TPlayObject_SetHookClientQueryUserState; external LibName name 'TPlayObject_SetHookClientQueryUserState';
procedure TPlayObject_SetHookSendActionGood; external LibName name 'TPlayObject_SetHookSendActionGood';
procedure TPlayObject_SetHookSendActionFail; external LibName name 'TPlayObject_SetHookSendActionFail';

function TPlayObject_IsEnoughBag; external LibName name 'TPlayObject_IsEnoughBag';

procedure TPlayObject_SetHookSendWalkMsg; external LibName name 'TPlayObject_SetHookSendWalkMsg';
procedure TPlayObject_SetHookSendHorseRunMsg; external LibName name 'TPlayObject_SetHookSendHorseRunMsg';
procedure TPlayObject_SetHookSendRunMsg; external LibName name 'TPlayObject_SetHookSendRunMsg';
procedure TPlayObject_SetHookSendDeathMsg; external LibName name 'TPlayObject_SetHookSendDeathMsg';
procedure TPlayObject_SetHookSendSkeletonMsg; external LibName name 'TPlayObject_SetHookSendSkeletonMsg';
procedure TPlayObject_SetHookSendAliveMsg; external LibName name 'TPlayObject_SetHookSendAliveMsg';
procedure TPlayObject_SetHookSendSpaceMoveMsg; external LibName name 'TPlayObject_SetHookSendSpaceMoveMsg';
procedure TPlayObject_SetHookSendChangeFaceMsg; external LibName name 'TPlayObject_SetHookSendChangeFaceMsg';
procedure TPlayObject_SetHookSendUseitemsMsg; external LibName name 'TPlayObject_SetHookSendUseitemsMsg';
procedure TPlayObject_SetHookSendUserLevelUpMsg; external LibName name 'TPlayObject_SetHookSendUserLevelUpMsg';
procedure TPlayObject_SetHookSendUserAbilieyMsg; external LibName name 'TPlayObject_SetHookSendUserAbilieyMsg';
procedure TPlayObject_SetHookSendUserStatusMsg; external LibName name 'TPlayObject_SetHookSendUserStatusMsg';
procedure TPlayObject_SetHookSendUserStruckMsg; external LibName name 'TPlayObject_SetHookSendUserStruckMsg';
procedure TPlayObject_SetHookSendUseMagicMsg; external LibName name 'TPlayObject_SetHookSendUseMagicMsg';
procedure TPlayObject_SetHookSendSocket; external LibName name 'TPlayObject_SetHookSendSocket';
procedure TPlayObject_SetHookSendGoodsList; external LibName name 'TPlayObject_SetHookSendGoodsList';
procedure TPlayObject_SetCheckClientDropItem; external LibName name 'TPlayObject_SetCheckClientDropItem';
procedure TPlayObject_SetCheckClientDealItem; external LibName name 'TPlayObject_SetCheckClientDealItem';
procedure TPlayObject_SetCheckClientStorageItem; external LibName name 'TPlayObject_SetCheckClientStorageItem';
procedure TPlayObject_SetCheckClientRepairItem; external LibName name 'TPlayObject_SetCheckClientRepairItem';
procedure TPlayObject_SetHookCheckUserItems; external LibName name 'TPlayObject_SetHookCheckUserItems';
procedure TPlayObject_SetHookRun; external LibName name 'TPlayObject_SetHookRun';
procedure TPlayObject_SetHookFilterMsg; external LibName name 'TPlayObject_SetHookFilterMsg';
procedure TPlayObject_SetHookUserRunMsg; external LibName name 'TPlayObject_SetHookUserRunMsg';
procedure TPlayObject_SetUserInPutInteger; external LibName name 'TPlayObject_SetUserInPutInteger';
procedure TPlayObject_SetUserInPutString; external LibName name 'TPlayObject_SetUserInPutString';
function TPlayObject_IncGold; external LibName name 'TPlayObject_IncGold';
procedure TPlayObject_IncGameGold; external LibName name 'TPlayObject_IncGameGold';
procedure TPlayObject_IncGamePoint; external LibName name 'TPlayObject_IncGamePoint';
function TPlayObject_DecGold; external LibName name 'TPlayObject_DecGold';
procedure TPlayObject_DecGameGold; external LibName name 'TPlayObject_DecGameGold';
procedure TPlayObject_DecGamePoint; external LibName name 'TPlayObject_DecGamePoint';
function TPlayObject_PlayUseItems; external LibName name 'TPlayObject_PlayUseItems';
function TPlayObject_MyHero; external LibName name 'TPlayObject_MyHero';

procedure TPlayObject_SetCheckClientUpgradeItem; external LibName name 'TPlayObject_SetCheckClientUpgradeItem';
procedure TPlayObject_SetCheckClientSellItem; external LibName name 'TPlayObject_SetCheckClientSellItem';
procedure TActorObject_SetCheckClientNotScatterItem; external LibName name 'TBaseObject_SetCheckClientNotScatterItem';
procedure TActorObject_SetCheckClientDieScatterItem; external LibName name 'TBaseObject_SetCheckClientDieScatterItem';

procedure TPlayObject_SetHookOffLine; external LibName name 'TPlayObject_SetHookOffLine';

procedure THeroObject_SendAddItem; external LibName name 'THeroObject_SendAddItem';
procedure THeroObject_SendDelItem; external LibName name 'THeroObject_SendDelItem';


function TNormNpc_sFilePath; external LibName name 'TNormNpc_sFilePath';
function TNormNpc_sPath; external LibName name 'TNormNpc_sPath';
procedure TNormNpc_GetLineVariableText; external LibName name 'TNormNpc_GetLineVariableText';

procedure TNormNpc_SetScriptActionCmd; external LibName name 'TNormNpc_SetScriptActionCmd';
function TNormNpc_GetScriptActionCmd; external LibName name 'TNormNpc_GetScriptActionCmd';

procedure TNormNpc_SetScriptConditionCmd; external LibName name 'TNormNpc_SetScriptConditionCmd';
function TNormNpc_GetScriptConditionCmd; external LibName name 'TNormNpc_GetScriptConditionCmd';

procedure TNormNpc_SetScriptAction; external LibName name 'TNormNpc_SetScriptAction';
function TNormNpc_GetScriptAction; external LibName name 'TNormNpc_GetScriptAction';

procedure TNormNpc_SetScriptCondition; external LibName name 'TNormNpc_SetScriptCondition';
function TNormNpc_GetScriptCondition; external LibName name 'TNormNpc_GetScriptCondition';

function TNormNpc_GetManageNpc; external LibName name 'TNormNpc_GetManageNpc';
function TNormNpc_GetFunctionNpc; external LibName name 'TNormNpc_GetFunctionNpc';
procedure TNormNpc_GotoLable; external LibName name 'TNormNpc_GotoLable';

function TMerchant_GoodsList; external LibName name 'TMerchant_GoodsList';

function TMerchant_GetItemPrice; external LibName name 'TMerchant_GetItemPrice';
function TMerchant_GetUserPrice; external LibName name 'TMerchant_GetUserPrice';
function TMerchant_GetUserItemPrice; external LibName name 'TMerchant_GetUserPrice';

procedure TMerchant_SetHookClientGetDetailGoodsList; external LibName name 'TMerchant_SetHookClientGetDetailGoodsList';
function TMerchant_SetCheckUserSelect; external LibName name 'TMerchant_SetCheckUserSelect';
function TMerchant_GetCheckUserSelect; external LibName name 'TMerchant_GetCheckUserSelect';
function TMapManager_FindMap; external LibName name 'TMapManager_FindMap';
function TEnvirnoment_GetRangeActorObject; external LibName name 'TEnvirnoment_GetRangeBaseObject';
function TEnvirnoment_boCANRIDE; external LibName name 'TEnvirnoment_boCANRIDE';
function TEnvirnoment_boCANBAT; external LibName name 'TEnvirnoment_boCANBAT';

function TUserEngine_Create; external LibName name 'TUserEngine_Create';
procedure TUserEngine_Free; external LibName name 'TUserEngine_Free';
function TUserEngine_GetUserEngine; external LibName name 'TUserEngine_GetUserEngine';

function TUserEngine_GetPlayObject; external LibName name 'TUserEngine_GetPlayObject';

function TUserEngine_GetLoadPlayList; external LibName name 'TUserEngine_GetLoadPlayList';
function TUserEngine_GetPlayObjectList; external LibName name 'TUserEngine_GetPlayObjectList';
function TUserEngine_GetLoadPlayCount; external LibName name 'TUserEngine_GetLoadPlayCount';
function TUserEngine_GetPlayObjectCount; external LibName name 'TUserEngine_GetPlayObjectCount';
function TUserEngine_GetStdItemByName; external LibName name 'TUserEngine_GetStdItemByName';
function TUserEngine_GetStdItemByIndex; external LibName name 'TUserEngine_GetStdItemByIndex';
function TUserEngine_CopyToUserItemFromName; external LibName name 'TUserEngine_CopyToUserItemFromName';

procedure TUserEngine_SetHookRun; external LibName name 'TUserEngine_SetHookRun';
function TUserEngine_GetHookRun; external LibName name 'TUserEngine_GetHookRun';
procedure TUserEngine_SetHookClientUserMessage; external LibName name 'TUserEngine_SetHookClientUserMessage';
function TUserEngine_GetStdItemList; external LibName name 'TUserEngine_GetStdItemList';
function TUserEngine_GetMagicList; external LibName name 'TUserEngine_GetMagicList';
function TUserEngine_FindMagic; external LibName name 'TUserEngine_FindMagic';
function TUserEngine_AddMagic; external LibName name 'TUserEngine_AddMagic';
function TUserEngine_DelMagic; external LibName name 'TUserEngine_DelMagic';
procedure TUserEngine_RandomUpgradeItem; external LibName name 'TUserEngine_RandomUpgradeItem';
procedure TUserEngine_GetUnknowItemValue; external LibName name 'TUserEngine_GetUnknowItemValue';
procedure TUserEngine_RandomUpgradeItem_; external LibName name 'TUserEngine_RandomUpgradeItem_';
procedure TUserEngine_GetUnknowItemValue_; external LibName name 'TUserEngine_GetUnknowItemValue_';


function TGuild_RankList; external LibName name 'TGuild_RankList';
procedure TItemUnit_GetItemAddValue; external LibName name 'TItemUnit_GetItemAddValue';

function TMagicManager_GetMagicManager; external LibName name 'TMagicManager_GetMagicManager';
function TMagicManager_DoSpell; external LibName name 'TMagicManager_DoSpell';
function TMagicManager_MPow; external LibName name 'TMagicManager_MPow';
function TMagicManager_GetPower; external LibName name 'TMagicManager_GetPower';
function TMagicManager_GetPower13; external LibName name 'TMagicManager_GetPower13';
function TMagicManager_GetRPow; external LibName name 'TMagicManager_GetRPow';
function TMagicManager_IsWarrSkill; external LibName name 'TMagicManager_IsWarrSkill';

function TMagicManager_MagBigHealing; external LibName name 'TMagicManager_MagBigHealing';
function TMagicManager_MagPushArround; external LibName name 'TMagicManager_MagPushArround';
function TMagicManager_MagPushArroundTaos; external LibName name 'TMagicManager_MagPushArroundTaos';
function TMagicManager_MagTurnUndead; external LibName name 'TMagicManager_MagTurnUndead';
function TMagicManager_MagMakeHolyCurtain; external LibName name 'TMagicManager_MagMakeHolyCurtain';
function TMagicManager_MagMakeGroupTransparent; external LibName name 'TMagicManager_MagMakeGroupTransparent';
function TMagicManager_MagTamming; external LibName name 'TMagicManager_MagTamming';
function TMagicManager_MagSaceMove; external LibName name 'TMagicManager_MagSaceMove';
function TMagicManager_MagMakeFireCross; external LibName name 'TMagicManager_MagMakeFireCross';
function TMagicManager_MagBigExplosion; external LibName name 'TMagicManager_MagBigExplosion';
function TMagicManager_MagElecBlizzard; external LibName name 'TMagicManager_MagElecBlizzard';
function TMagicManager_MabMabe; external LibName name 'TMagicManager_MabMabe';
function TMagicManager_MagMakeSlave; external LibName name 'TMagicManager_MagMakeSlave';
function TMagicManager_MagMakeSinSuSlave; external LibName name 'TMagicManager_MagMakeSinSuSlave';
function TMagicManager_MagWindTebo; external LibName name 'TMagicManager_MagWindTebo';
function TMagicManager_MagGroupLightening; external LibName name 'TMagicManager_MagGroupLightening';
function TMagicManager_MagGroupAmyounsul; external LibName name 'TMagicManager_MagGroupAmyounsul';
function TMagicManager_MagGroupDeDing; external LibName name 'TMagicManager_MagGroupDeDing';
function TMagicManager_MagGroupMb; external LibName name 'TMagicManager_MagGroupMb';
function TMagicManager_MagHbFireBall; external LibName name 'TMagicManager_MagHbFireBall';
function TMagicManager_MagLightening; external LibName name 'TMagicManager_MagLightening';

function TMagicManager_CheckAmulet; external LibName name 'TMagicManager_CheckAmulet';
procedure TMagicManager_UseAmulet; external LibName name 'TMagicManager_UseAmulet';
function TMagicManager_MagMakeSuperFireCross; external LibName name 'TMagicManager_MagMakeSuperFireCross';

function TMagicManager_MagMakeFireball; external LibName name 'TMagicManager_MagMakeFireball';
function TMagicManager_MagTreatment; external LibName name 'TMagicManager_MagTreatment';
function TMagicManager_MagMakeHellFire; external LibName name 'TMagicManager_MagMakeHellFire';
function TMagicManager_MagMakeQuickLighting; external LibName name 'TMagicManager_MagMakeQuickLighting';
function TMagicManager_MagMakeLighting; external LibName name 'TMagicManager_MagMakeLighting';
function TMagicManager_MagMakeFireCharm; external LibName name 'TMagicManager_MagMakeFireCharm';
function TMagicManager_MagMakeUnTreatment; external LibName name 'TMagicManager_MagMakeUnTreatment';
function TMagicManager_MagMakePrivateTransparent; external LibName name 'TMagicManager_MagMakePrivateTransparent';

function TMagicManager_MagMakeLivePlayObject; external LibName name 'TMagicManager_MagMakeLivePlayObject';
function TMagicManager_MagMakeArrestObject; external LibName name 'TMagicManager_MagMakeArrestObject';
function TMagicManager_MagChangePosition; external LibName name 'TMagicManager_MagChangePosition';
function TMagicManager_MagMakeFireDay; external LibName name 'TMagicManager_MagMakeFireDay';

procedure TMagicManager_SetHookDoSpell; external LibName name 'TMagicManager_SetHookDoSpell';
function TPlugOfEngine_GetProductVersion; external LibName name 'TPlugOfEngine_GetProductVersion';
function TPlugOfEngine_GetUpDateVersion; external LibName name 'TPlugOfEngine_GetUpDateVersion';
initialization
  begin

  end;

finalization
  begin
  end;

end.
