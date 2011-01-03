unit ClMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, MMSystem, Forms, Dialogs,
  JSocket, ExtCtrls, Textures, DXDraws, DirectX, DXClass, DrawScrn, IntroScn, PlayScn,
  Grobal2, DIB, StdCtrls, WIL, HUtil32, EncryptUnit, Actor, Mpeg, MapUnit,
  DWinCtl, ClFunc, magiceff, SoundUtil, clEvent, Wave, IniFiles, Registry,
  Spin, ComCtrls, Grids, Menus, Mask, MShare, Share, StrUtils, HTTPGet, MD5EncodeStr,
  SoundEngn, ShellApi, tlHelp32, psAPI, PlugIn, GameImages,
  PathFind, zLibx, MPlayer, OleCtrls, GuaJi;

const
  BO_FOR_TEST = False;
  EnglishVersion = True; //TRUE;
  BoNeedPatch = True;
type
  TKornetWorld = record
    CPIPcode: string;
    SVCcode: string;
    LoginID: string;
    CheckSum: string;
  end;
  TOneClickMode = (toNone, toKornetWorld);

type
  TfrmMain = class(TDxForm)
    CSocket: TClientSocket;
    TimerRun: TTimer;
    MouseTimer: TTimer;
    WaitMsgTimer: TTimer;
    SelChrWaitTimer: TTimer;
    CmdTimer: TTimer;
    MinTimer: TTimer;
    DXDraw: TDXDraw;
    HTTPGetString: THTTPGet;
    PopupMenu1: TPopupMenu;
    SpeedHackTimer: TTimer;
    HTTPGetCheckPro: THTTPGet;
    FindPathTimer: TTimer;
    TextureDevice1: TTextureDevice;
    TimerPlayMedia: TTimer;
    procedure DXDrawInitialize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DXDrawMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure TimerRunTimer(Sender: TObject);
    procedure DXDrawMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MouseTimerTimer(Sender: TObject);

    procedure DXDrawDblClick(Sender: TObject);
    procedure WaitMsgTimerTimer(Sender: TObject);
    procedure SelChrWaitTimerTimer(Sender: TObject);
    procedure DXDrawClick(Sender: TObject);
    procedure CmdTimerTimer(Sender: TObject);
    procedure MinTimerTimer(Sender: TObject);
    procedure HTTPGetStringDoneString(Sender: TObject; Result: string);

    procedure SpeedHackTimerTimer(Sender: TObject);
    procedure DXDrawFinalize(Sender: TObject);
    procedure FontChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HTTPGetCheckProDoneString(Sender: TObject; Result: string);
    procedure FindPathTimerTimer(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TimerPlayMediaTimer(Sender: TObject);
  private
    WarningLevel: Integer;
    TimerCmd: TTimerCommand;
    MakeNewId: string;

    ActionLockTime: LongWord;
    LastHitTick: LongWord;
    ActionFailLock: Boolean;
    ActionFailLockTime: LongWord;
    FailAction, FailDir: Integer;


    CursorSurface: TTexture;
    mousedowntime: LongWord;
    WaitingMsg: TDefaultMessage;
    WaitingStr: string;

    FFrameRate: Integer;
    FInitialized: Boolean;
    FInterval: Cardinal;
    FInterval2: Cardinal;
    FNowFrameRate: Integer;
    FOldTime: DWORD;
    FOldTime2: DWORD;
    function GetMessage(Msg: pTProcessMessage): Boolean;
    function Operate(ProcessMsg: pTProcessMessage): Boolean;
    procedure ClearMsg;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function GetProcesses: Boolean; //查找系统进程
    function GetModules(ProcessID: DWORD): Boolean; //查找进程模块
    procedure CloseProcess(ProcessID: Integer); //结束进程

    procedure CheckSpeedHack(rtime: LongWord);


    procedure DecodeMessagePacket(sDataBlock: string);
    procedure ActionFailed;

    procedure UseMagicSpell(who, effnum, targetx, targety, magic_id: Integer);
    procedure UseMagicFire(who, efftype, effnum, targetx, targety, target: Integer);
    procedure UseMagicFireFail(who: Integer);
    procedure UseSerieMagic(); //使用连击
    procedure StartSerieMagic(); //开始连击
    procedure StopSerieMagic(); //停止连击
    procedure CloseAllWindows;
    procedure ClearDropItems;
    procedure ResetGameVariables;
    procedure ChangeServerClearGameVariables;
    procedure _DXDrawMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    function CheckDoorAction(dx, dy: Integer): Boolean;

    procedure ClientGetMsg(sData: string);
    procedure ClientGetRandomCode(sData: string; nKey: Integer);
    procedure ClientNewIDSuccess();
    procedure ClientNewIDFail(nFailCode: Integer);
    procedure ClientLoginFail(nFailCode: Integer);
    procedure ClientUpdateAccountSuccess();
    procedure ClientUpdateAccountFail();
    procedure ClientQueryChrFail(nFailCode: Integer);
    procedure ClientNewChrFail(nFailCode: Integer);
    procedure ClientChgPasswdSuccess();
    procedure ClientChgPasswdFail(nFailCode: Integer);
    procedure ClientDelChrFail(nFailCode: Integer);
    procedure ClientStartPlayFail();
    procedure ClientVersionFail();
    procedure ClientGetNewMap(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientGetUserLogin(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientGetAreaState(nAreaState: Integer);
    procedure ClientGetMyStatus(DefMsg: pTDefaultMessage);
    procedure ClientGetObjTurn(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientGetBackStep(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientSpaceMoveShow(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientSpaceMoveHide(DefMsg: pTDefaultMessage);
    procedure ClientObjWalk(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjRun(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientChangeLigth(DefMsg: pTDefaultMessage);
    procedure ClientLampChangeDura(DefMsg: pTDefaultMessage);
    procedure ClientObjMoveFail(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjButch(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjHit(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjFlyAxe(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjLighting(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjSpell(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjMagicFire(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjMagicFireFail(DefMsg: pTDefaultMessage);

    procedure ClientOutofConnection();
    procedure ClientObjDeath(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjSkeLeton(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjAbility(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjSubAbility(DefMsg: pTDefaultMessage);
    procedure ClientDayChanging(DefMsg: pTDefaultMessage);
    procedure ClientObjWinExp(DefMsg: pTDefaultMessage);
    procedure ClientObjLevelUp(DefMsg: pTDefaultMessage);
    procedure ClientObjHealthSpellChanged(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjStruck(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjChangeFace(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjInputPassword();
    procedure ClientObjOpenHealth(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjCloseHealth(DefMsg: pTDefaultMessage);
    procedure ClientObjInstanceOpenHealth(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjBreakWeapon(DefMsg: pTDefaultMessage);
    procedure ClientGetMessage(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientGetUserName(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjChangeNameColor(DefMsg: pTDefaultMessage);
    procedure ClientObjHide(DefMsg: pTDefaultMessage);
    procedure ClientObjDigUp(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjDigDown(DefMsg: pTDefaultMessage);
    procedure ClientGetShowEvent(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientGetHideEvent(DefMsg: pTDefaultMessage);

    procedure ClientObjHeroLogOn(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjHeroLogOnOK(nRecog: Integer);

    procedure ClientObjHeroLogOut(DefMsg: pTDefaultMessage);
    procedure ClientObjHeroLogOutOK(nRecog: Integer);

    procedure ClientObjHeroAbility(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjHeroSubAbility(DefMsg: pTDefaultMessage);
    procedure ClientObjFireDragonPoint(DefMsg: pTDefaultMessage);
    procedure ClientObjHeroTakeOnOK(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjHeroTakeOnFail();
    procedure ClientObjHeroTakeOffOK(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjHeroTakeOffFail();
    procedure ClientObjTakeOffHeroBagOK(DefMsg: pTDefaultMessage);
    procedure ClientObjTakeOffHeroBagFail();
    procedure ClientObjTakeOffMasterBagOK(DefMsg: pTDefaultMessage);
    procedure ClientObjTakeOffMasterBagFail();
    procedure ClientObjToMasterBagOK();
    procedure ClientObjToMasterBagFail();
    procedure ClientObjToHeroBagOK();
    procedure ClientObjToHeroBagFail();
    procedure ClientObjHeroBagCount(DefMsg: pTDefaultMessage);
    procedure ClientObjHeroWeigthChanged(DefMsg: pTDefaultMessage);
    procedure ClientObjHeroEatOK();
    procedure ClientObjHeroEatFail();
    procedure ClientObjHeroWinExp(DefMsg: pTDefaultMessage);
    procedure ClientObjHeroLevelUp(DefMsg: pTDefaultMessage);
    procedure ClientObjRepaiFireDragon(DefMsg: pTDefaultMessage);
    procedure ClientObjTakeOnOK(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjTakeOnFail();
    procedure ClientObjTakeOffOK(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjTakeOffFail();
    procedure ClientObjWeigthChanged(DefMsg: pTDefaultMessage);
    procedure ClientObjGoldChanged(DefMsg: pTDefaultMessage);
    procedure ClientObjCleanObjects();
    procedure ClientObjEatOK();
    procedure ClientObjEatFail();
    procedure ClientObjBuyPrice(nGold: Integer);
    procedure ClientObjSellItemOK(nGold: Integer);
    procedure ClientObjSellItemFail();
    procedure ClientObjRepairCost(nGold: Integer);
    procedure ClientObjRepairItemOK(DefMsg: pTDefaultMessage);
    procedure ClientObjRepairItemFail();
    procedure ClientObjStorageOK(DefMsg: pTDefaultMessage);
    procedure ClientObjTakeBackStorageItemOK(DefMsg: pTDefaultMessage);
    procedure ClientObjBuyItemSuccess(DefMsg: pTDefaultMessage);
    procedure ClientObjBuyItemFail(nFailCode: Integer);
    procedure ClientObjMakeDrugOK(nGold: Integer);
    procedure ClientObjMakeDrugFail(nFailCode: Integer);
    procedure ClientObjGroupModeChanged(nOpen: Integer);
    procedure ClientObjCreateGroupOK();
    procedure ClientObjCreateGroupFail(nFailCode: Integer);
    procedure ClientObjGroupAddManFail(nFailCode: Integer);
    procedure ClientObjGroupDelManFail(nFailCode: Integer);
    procedure ClientObjOpenGuildDlgFail();
    procedure ClientObjDealtryFail();
    procedure ClientObjDealMenu(sData: string);
    procedure ClientObjDealCancel();
    procedure ClientObjDealAddItemOK();
    procedure ClientObjDealDelItemOK();
    procedure ClientObjDealDelItemFail();
    procedure ClientObjDealChgGoldOK(DefMsg: pTDefaultMessage);
    procedure ClientObjDealChgGoldFail(DefMsg: pTDefaultMessage);
    procedure ClientObjDealRemotChgGold(DefMsg: pTDefaultMessage);
    procedure ClientGetReadMiniMapFail();
    procedure ClientObjGuildAddMemberFail(nFailCode: Integer);
    procedure ClientObjGuildDelMemberFail(nFailCode: Integer);
    procedure ClientObjGuildRankUpdateFail(nFailCode: Integer);
    procedure ClientObjGuildMakeAllyFail(nFailCode: Integer);
    procedure ClientObjGuildBreakAllyFail(nFailCode: Integer);
    procedure ClientObjBuildGuildOK();
    procedure ClientObjBuildGuildFail(nFailCode: Integer);
    procedure ClientObjMenuOK(sData: string);
    procedure ClientObjDlgMsg(sData: string);
    procedure ClientObjPalyDice(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjBuyShopItemFail(nFailCode: Integer);
    procedure ClientObjBuySellOffItemFail(nFailCode: Integer);
    procedure ClientObjSellSellOffItemOK();
    procedure ClientObjSellSellOffItemFail(nFailCode: Integer);
    procedure ClientObjGetCastle(DefMsg: pTDefaultMessage);
    procedure ClientObjShowBox(nBoxType: Integer);
    procedure ClientObjOpenBoxOK(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientObjOpenBoxFail(nFailCode: Integer);
    procedure ClientObjGetBoxIndex(nSelBoxItemIdx: Integer);
    procedure ClientObjOpenBook(nMerchant, nBookType: Integer);
    procedure ClientObjCloseMDlg();
    procedure ClientGetDelChr(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientGetDelChrFail(nFailError: Integer);
    procedure ClientGetDelChrOK(sData: string);
    procedure ClientObjGetBackBoxOK();
    procedure ClientGetRandomDIB(boOpen: Boolean; BitCount: Integer; sData: string);


    procedure ClientObjChangeItemFail(nFailCode: Integer);
    procedure ClientObjChangeItemOK(sData: string);

    procedure ClientObjUpgradeItemOK(sData: string);
    procedure ClientObjUpgradeItemFail(nFailCode: Integer; sData: string);


    procedure ClientObjDueltryFail(nFailCode: Integer);
    procedure ClientObjDuelMenu(sData: string);
    procedure ClientObjDuelCancel();
    procedure ClientObjDuelAddItemOK();
    procedure ClientObjDuelDelItemOK();
    procedure ClientObjDuelDelItemFail();
    procedure ClientObjDuelChgGoldOK(DefMsg: pTDefaultMessage);
    procedure ClientObjDuelChgGoldFail(DefMsg: pTDefaultMessage);
    procedure ClientObjDuelRemotChgGold(DefMsg: pTDefaultMessage);
    procedure ClientGetDuelRemoteAddItem(body: string);
    procedure ClientGetDuelRemoteDelItem(body: string);

    procedure ClientObjChangeState(DefMsg: pTDefaultMessage);

    procedure ClientObjFindItemOK(sData: string; nWho: Integer);
    procedure ClientObjFindItemFail();
    procedure ClientSnow(DefMsg: pTDefaultMessage); //下雪
    procedure ClientStore(DefMsg: pTDefaultMessage); //摆摊
    procedure ClientDelStoreItem(body: string);
    procedure ClientGetSendUserStoreState(body: string);
    procedure ClientObjBuyStoreItemOK(); //摆摊物品购买成功
    procedure ClientObjBuyStoreItemFail(DefMsg: pTDefaultMessage); //摆摊物品购买失败
    procedure ClientObjStartStoreOK();
    procedure ClientObjStopStoreOK();
    procedure ClientObjStartStoreFail();

    procedure ClientGetPasswdSuccess(body: string);
    procedure ClientGetNeedUpdateAccount(body: string);
    procedure ClientGetSelectServer;
    procedure ClientGetPasswordOK(DefMsg: pTDefaultMessage; sBody: string);
    procedure ClientGetServerName(DefMsg: pTDefaultMessage; sBody: string);

    procedure ClientGetReceiveChrs(body: string);
    procedure ClientGetStartPlay(body: string);
    procedure ClientGetReconnect(body: string);
    procedure ClientGetServerConfig(DefMsg: pTDefaultMessage; sBody: string);
    procedure ClientGetMapDescription(DefMsg: pTDefaultMessage; sBody: string);
    procedure ClientGetGameGoldName(DefMsg: pTDefaultMessage; sBody: string);

    procedure ClientGetAdjustBonus(bonus: Integer; body: string);
    procedure ClientGetAddItem(body: string);
    procedure ClientGetUpdateItem(body: string);
    procedure ClientGetUpdateItem2(body: string);
    procedure ClientGetDelItem(body: string);
    procedure ClientGetDelItems(body: string);
    procedure ClientGetBagItmes(DefMsg: pTDefaultMessage; body: string);
    procedure ClientGetDropItemFail(iname: string; sindex: Integer);

    procedure ClientGetShowItem(DefMsg: pTDefaultMessage; sData: string);
    procedure ClientGetHideItem(DefMsg: pTDefaultMessage);
    procedure ClientGetSenduseItems(body: string);
    procedure ClientGetSendAddUseItems(body: string);
    procedure ClientGetAddMagic(body: string);
    procedure ClientGetDelMagic(magid: Integer);
    procedure ClientGetMyMagics(body: string);
    procedure ClientGetMagicLvExp(magid, maglv, magtrain: Integer);
    procedure ClientGetDuraChange(uidx, newdura, newduramax: Integer);
    procedure ClientGetMerchantSay(merchant, face: Integer; saying: string);
    procedure ClientGetSendGoodsList(merchant, Count: Integer; body: string);
    procedure ClientGetSendMakeDrugList(merchant: Integer; body: string);
    procedure ClientGetSendUserSell(merchant: Integer);
    procedure ClientGetSendUserRepair(merchant: Integer);
    procedure ClientGetSendUserStorage(merchant: Integer);
    procedure ClientGetSaveItemList(merchant, Page: Integer; bodystr: string);
    procedure ClientGetSendDetailGoodsList(merchant, Count, topline: Integer; bodystr: string);
    procedure ClientGetSendNotice(body: string);
    procedure ClientGetGroupMembers(bodystr: string);
    procedure ClientGetOpenGuildDlg(bodystr: string);
    procedure ClientGetSendGuildMemberList(body: string);
    procedure ClientGetDealRemoteAddItem(body: string);
    procedure ClientGetDealRemoteDelItem(body: string);
    procedure ClientGetReadMiniMap(mapindex: Integer);
    procedure ClientGetChangeGuildName(body: string);
    procedure ClientGetSendUserState(body: string);
    procedure DrawEffectHum(nType, nX, nY, nTarget: Integer);
    procedure ClientGetNeedPassword(body: string);
    procedure ClientGetPasswordStatus(DefMsg: pTDefaultMessage; body: string);
    procedure ClientGetRegInfo(DefMsg: pTDefaultMessage; body: string);
    procedure ClientGetShopItems(DefMsg: pTDefaultMessage; body: string);
    procedure ClientPlaySound(sFileName: string);
    procedure ClientObjBlasthit(DefMsg: pTDefaultMessage);
    procedure ClientObjCartInfo(DefMsg: pTDefaultMessage; sCharName: string);
    procedure ClientObjDelCartInfo(DefMsg: pTDefaultMessage);

    procedure SetInputStatus();
    procedure CmdShowHumanMsg(sParam1, sParam2, sParam3, sParam4,
      sParam5: string);
    procedure ShowHumanMsg(DefMsg: pTDefaultMessage);
    procedure SendPowerBlock;
    procedure SendDomainName(); //发送注册域名

    procedure ClientGetHeroDropItemFail(iname: string; sindex: Integer);
    procedure ClientGetHeroAddMagic(body: string);
    procedure ClientGetHeroDelMagic(magid: Integer);
    procedure ClientGetMyHeroMagics(body: string);
    procedure ClientGetSendHerouseItems(body: string);
    procedure ClientGetSendHeroAddUseItems(body: string);

    procedure ClientGetHeroChangeItem(body: string);
    procedure ClientGetHeroAddItem(body: string);
    procedure ClientGetHeroUpdateItem(body: string);
    procedure ClientGetHeroDelItem(body: string);
    procedure ClientGetHeroDelItems(body: string);
    procedure ClientGetHeroBagItmes(DefMsg: pTDefaultMessage; body: string);
    procedure ClientGetHeroMagicLvExp(magid, maglv, magtrain: Integer);
    procedure ClientGetHeroDuraChange(uidx, newdura, newduramax: Integer);
    //procedure WMSysCommand(var message: TMessage); message WM_SYSCOMMAND;
    function GetHeroUseMagic(wMagicId: Integer): PTClientMagic;

    procedure ClientGetSellItems(DefMsg: pTDefaultMessage; body: string);

    procedure ClientGetSendUserSellOff(merchant: Integer);
    procedure ClientGetSendUserChangeItem(merchant: Integer);



    procedure ClientObjNewStatus(DefMsg: pTDefaultMessage);
    procedure ClientAutoGotoXY(nX, nY: Integer; sMapName: string);

    procedure ClientGetRanking(DefMsg: pTDefaultMessage; sBody: string);

    procedure ClientTakeOnItem(nMakeIndex, nWhere: Integer; sItemName: string);
    procedure ClientTakeOffItem(nMakeIndex, nWhere: Integer; sItemName: string);
    procedure ClientHeroTakeOnItem(nMakeIndex, nWhere: Integer; sItemName: string);
    procedure ClientHeroTakeOffItem(nMakeIndex, nWhere: Integer; sItemName: string);

    procedure ClientStartVibration(nCount: Integer);
    procedure ClientOpenBigDiaLogBox(nImageIndex: Integer);
    procedure ClientCloseBigDiaLogBox();
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA;
  public
    LoginID, LoginPasswd {, CharName}: string;
    Certification: Integer;
    ActionLock: Boolean;
    ActionKey: Word;
    //MainSurface: TTexture;

    m_boOpen: Boolean;
    m_dwGetMsgTick: LongWord;
    m_MsgList: TGList;

    procedure ProcessKeyMessages;
    procedure ProcessActionMessages;
    procedure DXDrawMouseDown_(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DXDrawMouseMove_(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure AttackTarget(target: TActor);
    function FindMagic(wMagicId: Word): PTClientMagic;
    procedure UseMagic(tx, ty: Integer; pcm: PTClientMagic);
    function GetMagicByKey(Key: Char): PTClientMagic;
    function FindSerieMagic(wMagicId: Word): PTClientMagic;

    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure ProcOnIdle;
    procedure AppOnIdle(Sender: TObject; var Done: Boolean);
    procedure Logout;
    procedure AppLogout;
    procedure AppExit;
    procedure PrintScreenNow;
    procedure EatItem(idx: Integer);

    procedure SendMsg(Actor: TActor; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; sMsg: string);
    procedure SendDelayMsg(Actor: TActor; wIdent,
      wParam: Word; lParam1, lParam2, lParam3: Integer; sMsg: string;
      dwDelay: LongWord);
    procedure SendUpdateDelayMsg(Actor: TActor; wIdent,
      wParam: Word; lParam1, lParam2, lParam3: Integer; sMsg: string;
      dwDelay: LongWord);
    procedure SendUpdateMsg(Actor: TActor; wIdent, wParam: Word;
      lParam1, lParam2, lParam3: Integer; sMsg: string);

    procedure SendClientMessage(Msg, Recog, param, tag, series: Integer);
    procedure SendLogin(uid, passwd: string);
    procedure SendGetRandomCode;
    procedure SendNewAccount(ue: TUserEntry; ua: TUserEntryAdd);
    procedure SendUpdateAccount(ue: TUserEntry; ua: TUserEntryAdd);
    procedure SendSelectServer(svname: string);
    procedure SendChgPw(id, passwd, newpasswd: string);
    procedure SendNewChr(uid, uname, shair, sjob, ssex: string);
    procedure SendQueryChr;
    procedure SendDelChr(chrname: string);
    procedure SendSelChr(chrname: string);

    procedure SendRestoreSelChr(uid, uname: string);
    procedure SendQueryDelChr(uid: string);

    procedure SendRunLogin;
    procedure SendSay(Str: string);
    procedure SendActMsg(ident, X, Y, dir: Integer);
    procedure SendSpellMsg(ident, X, Y, dir, target: Integer);
    procedure SendQueryUserName(targetid, X, Y: Integer);
    procedure SendDropItem(Name: string; itemserverindex: Integer);
    procedure SendPickup;
    procedure SendTakeOnItem(where: Byte; itmindex: Integer; itmname: string);
    procedure SendTakeOffItem(where: Byte; itmindex: Integer; itmname: string);

    procedure SendTakeOffItemToMasterBag(where: Byte; itmindex: Integer; itmname: string);
    procedure SendTakeOffItemToHeroBag(where: Byte; itmindex: Integer; itmname: string);
    procedure SendItemToHeroBag(where: Byte; itmindex: Integer; itmname: string); //主人包裹到英雄包裹
    procedure SendItemToMasterBag(where: Byte; itmindex: Integer; itmname: string); //英雄包裹到主人包裹

    procedure SendHeroTakeOnItem(where: Byte; itmindex: Integer; itmname: string);
    procedure SendHeroTakeOffItem(where: Byte; itmindex: Integer; itmname: string);

    procedure SendTakeOnItemFromHeroBag(where: Byte; itmindex: Integer; itmname: string); //从英雄包裹穿装备到主人包裹
    procedure SendTakeOnItemFromMasterBag(where: Byte; itmindex: Integer; itmname: string); //从主人包裹穿装备到英雄包裹
    procedure SendHeroEat(itmindex: Integer; itmname: string);
    procedure HeroEatItem(idx: Integer);

    procedure SendHeroDropItem(Name: string; itemserverindex: Integer);
    procedure SendRepairFirDragon(nType: Byte; itmindex: Integer; itmname: string);
    procedure SendOnHorse();

    procedure SendEat(itmindex: Integer; itmname: string);
    procedure SendButchAnimal(X, Y, dir, actorid: Integer);
    procedure SendMagicKeyChange(magid: Integer; keych: Char);
    procedure SendMerchantDlgSelect(merchant: Integer; rstr: string);
    procedure SendQueryPrice(merchant, itemindex: Integer; itemname: string);
    procedure SendQueryRepairCost(merchant, itemindex: Integer; itemname: string);
    procedure SendSellItem(merchant, itemindex: Integer; itemname: string);
    procedure SendSellOffItem(merchant, itemindex: Integer; itemname: string);
    procedure SendChangeItem(merchant, itemindex: Integer; itemname: string);
    procedure SendRepairItem(merchant, itemindex: Integer; itemname: string);
    procedure SendStorageItem(merchant, itemindex: Integer; itemname: string);
    procedure SendGetDetailItem(merchant, menuindex: Integer; itemname: string);
    procedure SendBuyItem(merchant, itemserverindex: Integer; itemname: string);
    procedure SendTakeBackStorageItem(merchant, itemserverindex: Integer; itemname: string);
    procedure SendMakeDrugItem(merchant: Integer; itemname: string);
    procedure SendDropGold(dropgold: Integer);
    procedure SendGroupMode(onoff: Boolean);
    procedure SendCreateGroup(withwho: string);
    procedure SendWantMiniMap;
    procedure SendDealTry;
    procedure SendGuildDlg;
    procedure SendCancelDeal;
    procedure SendAddDealItem(ci: TClientItem);
    procedure SendDelDealItem(ci: TClientItem);
    procedure SendChangeDealGold(gold: Integer);
    procedure SendDealEnd;
    procedure SendAddGroupMember(withwho: string);
    procedure SendDelGroupMember(withwho: string);
    procedure SendGuildHome;
    procedure SendGuildMemberList;
    procedure SendGuildAddMem(who: string);
    procedure SendGuildDelMem(who: string);
    procedure SendGuildUpdateNotice(notices: string);
    procedure SendGuildUpdateGrade(rankinfo: string);
    procedure SendSpeedHackUser;
    procedure SendAdjustBonus(remain: Integer; babil: TNakedAbility);
    procedure SendPassword(sPassword: string; nIdent: Integer);
    procedure SendShopDlg(nPage, nTabePage, nSuperTabePage: Integer);
    procedure SendBuyShopItem(sItems: string; btType: Byte);
    procedure SendStartStore();
    procedure SendBuyStoreItem(sItems: string; nMakeIndex, nRecogId: Integer);

    procedure SendGetMyRanking(nTabelPage, nTabelType: Integer);
    procedure SendGetRanking(nTabelPage, nTabelType, nPage: Integer);

    function CanAttack(ndir: Integer; target: TActor): Boolean;
    function IsAttackTarget(Actor: TActor): Boolean;
    function TargetInSwordLongAttackRange(ndir: Integer; target: TActor; nRange: Integer): Boolean; overload;
    function TargetInSwordLongAttackRange(ndir: Integer): Boolean; overload;
    function TargetInSwordWideAttackRange(ndir: Integer): Boolean;
    function TargetInSwordCrsAttackRange(ndir: Integer): Boolean;
    function TargetInKTZAttackRange(ndir: Integer): Boolean;
    procedure OnProgramException(Sender: TObject; E: Exception);
    procedure SendSocket(sendstr: string);
    function ServerAcceptNextAction: Boolean;
    function CanNextAction: Boolean;
    function CanNextHit: Boolean;
    function IsUnLockAction(Action, adir: Integer): Boolean;
    procedure ActiveCmdTimer(cmd: TTimerCommand);
    function IsGroupMember(uname: string): Boolean;
    procedure SelectChr(sChrName: string);

    procedure ProcessCommand(sData: string);

    procedure AutoSendSay();
    function SearchHitMsg(tdir: Integer): Integer;
    function SearchLongHit(tdir: Integer): Integer;
    procedure SendQuerySellItems(nType, nPage: Integer; sItemName: string);
    procedure SendSearchSellItems(sItemName: string);
    procedure SendBuySellItem(nItemServerIndex: Integer; sItemName: string);
    procedure SendGetSellItemGold(nItemServerIndex: Integer; sItemName: string);

    procedure SendOpenBox(sName: string; nItemServerIndex: Integer);
    procedure SendUpgradeItem(UpgradeItemIndexs: TUpgradeItemIndexs);


    procedure SendCancelDuel;
    procedure SendAddDuelItem(ci: TClientItem);
    procedure SendDelDuelItem(ci: TClientItem);
    procedure SendChangeDuelGold(gold: Integer);
    procedure SendDuelEnd;

    procedure SendDuelTry;

    procedure SendRandomCode(sCode: string);
    procedure SendGetRandomBuffer();

    procedure FillCharBoxItems();

    procedure SendFindUserItem(nWho: Integer; sData: string);
    procedure SendHeroMagicKeyChange(magid: Integer);

    procedure AutoOrderItem;
    procedure DuraWarning();
    function AutoEatItem(idx: Integer): Boolean;
    function AutoHeroEatItem(idx: Integer): Boolean;

    procedure AutoUseItem(Sender: TObject);
    procedure AutoEatHPItem(Sender: TObject);
    procedure AutoEatMPItem(Sender: TObject);
    procedure AutoHeroEatHPItem(Sender: TObject);
    procedure AutoHeroEatMPItem(Sender: TObject);

    procedure AutoUseBookItem(Sender: TObject);
    procedure PlayMedia(const sFileName: string);
  end;

function IsDebug(): Boolean;
function IsDebugA(): Boolean;
procedure RefreshMessages;
procedure WaitAndPass(msec: LongWord);
procedure LoadConfig();
function ProgressDlg: TModalResult;
function IsWarrSkill(wMagIdx: Integer): Boolean; //是否是战士技能
var
  frmMain: TfrmMain;

  Code: Byte = 1;
  Busy: Boolean = False;

  nLeft: Integer = 10;
  nTop: Integer = 10;
  nWidth: Integer;
  nHeight: Integer;
  g_boShowMemoLog: Boolean = False;
  g_boShowRecog: Integer = 0;

  LocalLanguage: TImeMode = imSHanguel;

  TestServerAddr: string = '127.0.0.1';
  BGMusicList: TStringList;
  KornetWorld: TKornetWorld;

  BoOneClick: Boolean;
  OneClickMode: TOneClickMode;
  m_boPasswordIntputStatus: Boolean = False;

  g_sSockText: string;
  g_sBufferText: string;
implementation

uses FState, Progress;

{$R *.DFM}

var
  ShowMsgActor: TActor;
  AppHandle: HWnd;

function ProgressDlg: TModalResult;
begin
  FrmProgress := TFrmProgress.Create(Application);
  FrmProgress.ShowModal;
  Result := FrmProgress.ModalResult;
  FrmProgress.Free;
end;

procedure TfrmMain.SendMsg(Actor: TActor; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; sMsg: string);
var
  ProcessMessage: pTProcessMessage;
begin
  m_MsgList.Lock;
  try
    New(ProcessMessage);
    ProcessMessage.wIdent := wIdent;
    ProcessMessage.wParam := wParam;
    ProcessMessage.nParam1 := nParam1;
    ProcessMessage.nParam2 := nParam2;
    ProcessMessage.nParam3 := nParam3;
    ProcessMessage.dwDeliveryTime := 0;
    ProcessMessage.BaseObject := Actor;
    ProcessMessage.boLateDelivery := False;
    ProcessMessage.sMsg := sMsg;
    m_MsgList.Add(ProcessMessage);
  finally
    m_MsgList.UnLock;
  end;
end;

procedure TfrmMain.SendDelayMsg(Actor: TActor; wIdent,
  wParam: Word; lParam1, lParam2, lParam3: Integer; sMsg: string;
  dwDelay: LongWord);
var
  ProcessMessage: pTProcessMessage;
begin
  try
    m_MsgList.Lock;
    New(ProcessMessage);
    ProcessMessage.wIdent := wIdent;
    ProcessMessage.wParam := wParam;
    ProcessMessage.nParam1 := lParam1;
    ProcessMessage.nParam2 := lParam2;
    ProcessMessage.nParam3 := lParam3;
    ProcessMessage.dwDeliveryTime := GetTickCount + dwDelay;
    ProcessMessage.BaseObject := Actor;
    ProcessMessage.boLateDelivery := True;
    ProcessMessage.sMsg := sMsg;
    m_MsgList.Add(ProcessMessage);
  finally
    m_MsgList.UnLock;
  end;
end;

procedure TfrmMain.SendUpdateDelayMsg(Actor: TActor; wIdent,
  wParam: Word; lParam1, lParam2, lParam3: Integer; sMsg: string;
  dwDelay: LongWord);
var
  ProcessMessage: pTProcessMessage;
  I: Integer;
begin
  m_MsgList.Lock;
  try
    I := 0;
    while (True) do begin
      if m_MsgList.Count <= I then Break;
      ProcessMessage := m_MsgList.Items[I];
      if (ProcessMessage.wIdent = wIdent) and (ProcessMessage.nParam1 = lParam1) then begin
        m_MsgList.Delete(I);
        Dispose(ProcessMessage);
        Continue;
      end;
      Inc(I);
    end;
  finally
    m_MsgList.UnLock;
  end;
  SendDelayMsg(Actor, wIdent, wParam, lParam1, lParam2, lParam3, sMsg, dwDelay);
end;

procedure TfrmMain.SendUpdateMsg(Actor: TActor; wIdent, wParam: Word;
  lParam1, lParam2, lParam3: Integer; sMsg: string);
var
  ProcessMessage: pTProcessMessage;
  I: Integer;
begin
  try
    m_MsgList.Lock;
    I := 0;
    while (True) do begin
      if m_MsgList.Count <= I then Break;
      ProcessMessage := m_MsgList.Items[I];
      if ProcessMessage.wIdent = wIdent then begin
        m_MsgList.Delete(I);
        Dispose(ProcessMessage);
        Continue;
      end;
      Inc(I);
    end;
  finally
    m_MsgList.UnLock;
  end;
  SendMsg(Actor, wIdent, wParam, lParam1, lParam2, lParam3, sMsg);
end;

procedure TfrmMain.ClearMsg;
var
  I: Integer;
  ProcessMessage: pTProcessMessage;
begin
  try
    m_MsgList.Lock;
    for I := 0 to m_MsgList.Count - 1 do begin
      ProcessMessage := m_MsgList.Items[I];
      m_MsgList.Delete(I);
      Dispose(ProcessMessage);
    end;
  finally
    m_MsgList.UnLock;
  end;
end;

function TfrmMain.GetMessage(Msg: pTProcessMessage): Boolean;
var
  I: Integer;
  ProcessMessage: pTProcessMessage;
begin
  Result := False;
  m_MsgList.Lock;
  try
    I := 0;
    Msg.wIdent := 0;
    while m_MsgList.Count > I do begin
      ProcessMessage := m_MsgList.Items[I];
      if (ProcessMessage.dwDeliveryTime <> 0) and (GetTickCount < ProcessMessage.dwDeliveryTime) then begin
        Inc(I);
        Continue;
      end;
      m_MsgList.Delete(I);
      Msg^ := ProcessMessage^;
      Dispose(ProcessMessage);
      Result := True;
      Break;
    end;
  finally
    m_MsgList.UnLock;
  end;
end;

function TfrmMain.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := True;
  case ProcessMsg.wIdent of
    SM_TAKEONITEM: ClientTakeOnItem(ProcessMsg.nParam1, ProcessMsg.wParam, ProcessMsg.sMsg);
    SM_TAKEOFFITEM: ClientTakeOffItem(ProcessMsg.nParam1, ProcessMsg.wParam, ProcessMsg.sMsg);
    SM_HEROTAKEONITEM: ClientHeroTakeOnItem(ProcessMsg.nParam1, ProcessMsg.wParam, ProcessMsg.sMsg);
    SM_HEROTAKEOFFITEM: ClientHeroTakeOffItem(ProcessMsg.nParam1, ProcessMsg.wParam, ProcessMsg.sMsg);
    SM_STARTSERIESPELL_OK: UseSerieMagic;
    SM_STARTSERIESPELL_FAIL: StopSerieMagic;
  else Result := False;
  end;
end;


procedure RefreshMessages;
var
  nX, nY: Integer;
begin
  if g_MySelf = nil then Exit;
  //if GetTickCount - g_dwRefreshMessagesTick > 5 then begin
    //g_dwRefreshMessagesTick := GetTickCount();
  PlayScene.Run(False);
    {nX := UNITX * 3 + g_MySelf.m_nShiftX;
    nY := UNITY * 2 + g_MySelf.m_nShiftY;
    if nX < 0 then nX := 0;
    if nY < 0 then nY := 0;
    frmMain.ProcessKeyMessages;
    frmMain.ProcessActionMessages;
    if (PlayScene.m_nOldCurrX = nX) and (PlayScene.m_nOldCurrY = nY) then begin
      PlayScene.Run(True);
    end else begin
      //g_dwRunTimeTick := GetTickCount() - 70;
      PlayScene.Run(False);
    end;}
 // end;
end;


procedure WaitAndPass(msec: LongWord);
var
  start: LongWord;
begin
  start := GetTickCount;
  while GetTickCount - start < msec do begin
    Application.ProcessMessages;
  end;
end;

function KeyboardHookProc(Code: Integer; wParam: Longint; var Msg: TMsg): Longint; stdcall;
begin
  Result := 0;
  if ((wParam = 9) {or (WParam = 13)}) and (g_nLastHookKey = 18) and (GetTickCount - g_dwLastHookKeyTime < 500) then begin
    if frmMain.WindowState <> wsMinimized then begin
      frmMain.WindowState := wsMinimized;
    end else
      Result := CallNextHookEx(g_ToolMenuHook, Code, wParam, Longint(@Msg));
    Exit;
  end;
  g_nLastHookKey := wParam;
  g_dwLastHookKeyTime := GetTickCount;
  Result := CallNextHookEx(g_ToolMenuHook, Code, wParam, Longint(@Msg));
end;

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
var
  SendData: TCopyDataStruct;
  nParam: Integer;
begin
  nParam := MakeLong(Word(0), wIdent);
  SendData.cbData := Length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameLoginHandle, WM_COPYDATA, nParam, Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

procedure TfrmMain.MyMessage(var MsgData: TWmCopyData);
var
  sData: string;
  wIdent: Word;
begin
  wIdent := HiWord(MsgData.From);
  sData := StrPas(MsgData.CopyDataStruct^.lpData);
  case wIdent of
    GL_QUIT: begin
        g_ConnectionStep := cnsStart;
        Close;
      end;
  end;
end;

procedure TfrmMain.AppMessage(var Msg: TMsg; var Handled: Boolean);
var
  wKey: Word;
  Key: Char;
begin
  Handled := False;
  if Msg.Message = WM_KeyDown then begin
    wKey := Msg.wParam;
    if Msg.wParam = VK_TAB then begin
      FormKeyDown(Self, wKey, []);
      Key := Char(wKey);
      FormKeyPress(Self, Key);
    end;
  end else
    if Msg.Message = WM_KeyUp then begin
    if Msg.wParam = VK_TAB then begin
      if (g_FocusCret <> nil) and (g_FocusCret.m_btHair < 4) then begin
        FrmDlg.SetInputVisible(g_ConfigClient.btMainInterface = 1);
        FrmDlg.EdChat.Visible := True;
        FrmDlg.EdChat.SetFocus;
        FrmDlg.EdChat.Text := '/' + g_FocusCret.m_sUserName;
      end;
    end;
    Key := Char(Msg.wParam);
  end;
end;

procedure TfrmMain.FillCharBoxItems();
var
  I: Integer;
begin
  g_boShowItemBox := False;
  g_boOpenItemBox := False;
  g_boGetBoxItem := False;
  g_boGetBoxItemOK := False;
  g_btBoxItem := 4;
  g_btRandomBoxItem := 4;
  g_btSelBoxItemIndex := 4;
  g_btBoxType := 0;
  g_nBoxIndex := 0;
  g_nBoxButtonIndex := 515;
  FillChar(g_OpenBoxingItem, SizeOf(TClientItem), #0);
  g_dwOpenBoxTime := GetTickCount;

  g_dwBoxFlashTick := GetTickCount;
  g_nBoxTrunCount := 0;
  g_dwChgSpeed := 30;
  g_nChgCount := 0;
  g_boSelItemOK := False;
  g_nBoxFlashIdx := 0;

  for I := Low(g_BoxItems) to High(g_BoxItems) do begin
    g_BoxItems[I].S.Name := '';
  end;
end;

procedure TfrmMain.OnProgramException(Sender: TObject; E: Exception);
begin
  DebugOutStr(E.Message);
end;

procedure TfrmMain.WMSysCommand(var Message: TWMSysCommand);
begin
   {  with Message do begin
       // if (CmdType and $FFF0) = SC_KEYMENU then begin
           if (Key = VK_TAB) or (Key = VK_RETURN) then begin
             showmessage('TfrmMain.WMSysCommand VK_TAB');
              //FrmMain.WindowState := wsMinimized;
           end else inherited;
       // end else inherited;
     end; }

  {if Message.CmdType = SC_MINIMIZE then begin
    DebugOutStr('Message.CmdType = SC_MINIMIZE');
  end;
  if Message.CmdType = SC_MAXIMIZE then begin
    DebugOutStr('Message.CmdType = SC_MAXIMIZE');
  end;}

  inherited;
end;

function IsWarrSkill(wMagIdx: Integer): Boolean; //是否是战士技能
begin
  Result := False;
  if wMagIdx in [3, 4, 7, 12, 25, 26, 27, 40, 43, 58, 60, 77] then
    Result := True;
end;

function ComposeColor(Dest, Src: TRGBQuad; Percent: Integer): TRGBQuad;
begin
  with Result do begin
    rgbRed := Src.rgbRed + ((Dest.rgbRed - Src.rgbRed) * Percent div 256);
    rgbGreen := Src.rgbGreen + ((Dest.rgbGreen - Src.rgbGreen) * Percent div 256);
    rgbBlue := Src.rgbBlue + ((Dest.rgbBlue - Src.rgbBlue) * Percent div 256);
    rgbReserved := 0;
  end;
end;

function DefaultWebName: string;
const
  R_MyRootKey = HKEY_CLASSES_ROOT; //注册表根键
  R_MySubKey = '\http\shell';
var
  rRegObject: TRegistry;
begin
  rRegObject := TRegistry.Create;
  Result := '';
  try
    with rRegObject do begin
      RootKey := R_MyRootKey;
      if OpenKey(R_MySubKey, True) then begin
        Result := Trim(ReadString(''));
      end;
      CloseKey;
    end;
  finally
    rRegObject.Free;
  end;
end;

procedure OpenHomePage();
var
  //MemoryStream: TMemoryStream;
  ClientOption: TClientOption;
  ConfigClient: TConfigClient;
  nSize: PInteger;
  nCrc: PInteger;
  Buffer: Pointer;
  sBuffer: string;
  nBuffer: Integer;
  nPos: Integer;
  sWebName: string;
begin
  //ShellExecute(0, PChar('Open'), PChar('iexplore.exe'), PChar('http://www.cqfir.com'), nil, SW_SHOWNORMAL);
  //Exit;
 { MemoryStream := TMemoryStream.Create;
  MemoryStream.LoadFromFile(Application.ExeName);
  nBuffer := Length(EncryptBuffer(@ClientOption, SizeOf(TClientOption)));
  nPos := Length(EncryptBuffer(@ConfigClient, SizeOf(TConfigClient)));

  MemoryStream.Seek(-(nBuffer + nPos), soFromEnd);
  }
  {if g_ConfigBuffer= nil then begin
    Showmessage('g_ConfigBuffer = nil');
    Exit;
  end;}
  //sWebName:= DefaultWebName+'.exe';
 // Showmessage(sWebName);

  if g_ConfigBuffer <> nil then begin
    Move(g_ConfigBuffer^, nBuffer, SizeOf(Integer));

    SetLength(sBuffer, nBuffer);
    Move(g_ConfigBuffer[SizeOf(Integer)], sBuffer[1], nBuffer);

  //SetLength(sBuffer, nBuffer);
  //MemoryStream.Read(sBuffer[1], nBuffer);
    DecryptBuffer(sBuffer, @ClientOption, SizeOf(TClientOption));

    if ClientOption.sClosePage1 <> '' then
      ShellExecute(frmMain.Handle, nil, PChar(string(ClientOption.sClosePage1)), nil, nil, SW_SHOWNORMAL);
     // ShellExecute(0, PChar('Open'), nil {PChar(sWebName)}, PChar(string(ClientOption.sClosePage1)), nil, SW_SHOWNORMAL); //'iexplore.exe'
    if ClientOption.sClosePage2 <> '' then
      ShellExecute(frmMain.Handle, nil, PChar(string(ClientOption.sClosePage2)), nil, nil, SW_SHOWNORMAL);
      //ShellExecute(0, PChar('Open'), nil {PChar(sWebName)}, PChar(string(ClientOption.sClosePage2)), nil, SW_SHOWNORMAL);
  end;
  //MemoryStream.Free;
end;

procedure OpenHomePage1;
begin
    //ShellExecute(0, PChar(DecryptString(g_s00001)), PChar(DecryptString(g_s00002)), PChar(DecryptString(g_sOpenHomePage)), nil, SW_SHOWNORMAL);
end;

procedure OpenDuelDlg();
begin
  FrmDlg.OpenDuelDlg;
end;

procedure OpenDuelDlg1();
begin
    //FrmDlg.OpenDuelDlg;
end;

procedure OpenStoreDlg;
begin
  FrmDlg.OpenStoreDlg;
end;

procedure OpenStoreDlg1;
begin
    //FrmDlg.OpenStoreDlg;
end;

procedure OpenUserStoreDlg;
begin
  FrmDlg.OpenUserStoreDlg;
end;

procedure OpenUserStoreDlg1;
begin
    //FrmDlg.OpenUserStoreDlg;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  flname, Str: string;
  ini: TIniFile;
  FtpConf: TIniFile;
  nServerCount, I, AddHeight: Integer;
  ServerInfo: pTServerInfo;
  sServerName: string;
  //Res: TResourceStream;
 // sMir: string;

  nRegInfo: Integer;
  RegInfo: TRegInfo;
  sRegInfo: string;
  MirServer: TMirServer;
  //MemoryStream: TMemoryStream;
  {ClientOption: TClientOption;
  ConfigClient: TConfigClient;
  nSize: PInteger;
  nCrc: PInteger;
  Buffer: Pointer;
  ReadBuffer: PChar;
  sBuffer: string;
  nBuffer: Integer;
  nPos: Integer;

  dwTickTime: LongWord; }
begin
  DebugOutStr('----------------------- start ------------------------');
  GetWindowThreadProcessId(Handle, @g_nSelfThreadProcessId);
  g_sAppFilePath := ExtractFilePath(Application.ExeName);
  //Sets Main Interface 0 = Original, 1 = CQFir, 2 = Original again? or not used.
  g_ConfigClient.btMainInterface := 1; //2;
  FInterval2 := 1;
  FInterval := 50;
  FOldTime := TimeGetTime;
  FOldTime2 := TimeGetTime;
       //FrmDlg.DBackground.Parent:=Self;
  {DXTimer := TDXTimer.Create(Self);
  DXTimer.ActiveOnly := False;
  DXTimer.Enabled := False;
  DXTimer.OnTimer := OnTimer;
  DXTimer.Interval := 500;}
{$IF CLIENTTEST = 0}
  g_dwGameLoginHandle := Str_ToInt(ParamStr(1), 0);
  g_sMainParam2 := ParamStr(2); //读取设置参数

  DecryptBuffer(g_sMainParam2, @MirServer, SizeOf(TMirServer));

  g_boFullScreen := MirServer.boFullScreen;
  g_sServerAddr := MirServer.sServeraddr;
  g_nServerPort := MirServer.nServerPort;

  SCREENWIDTH := MirServer.nScreenWidth;
  SCREENHEIGHT := MirServer.nScreenHegiht;
{$ELSE}
  ini := TIniFile.Create('.\mir.ini');
  if ini <> nil then begin
    g_sCurFontName := ini.ReadString('Client Options', 'FontName', g_sCurFontName);
    g_boFullScreen := ini.ReadBool('Client Options', 'FullScreen', g_boFullScreen);
    g_sServerAddr := ini.ReadString('Client Options', 'ServerIP', g_sServerAddr);
    g_nServerPort := ini.ReadInteger('Client Options', 'ServerPort', g_nServerPort);
    SCREENWIDTH := ini.ReadInteger('Client Options', 'ScreenWidth', SCREENWIDTH);
    SCREENHEIGHT := ini.ReadInteger('Client Options', 'ScreenHeight', SCREENHEIGHT);

    ini.ReadInteger('Client Setup', 'LineColor', g_btFColor);
    ini.ReadInteger('Client Setup', 'RectangleColor', g_btBColor);
    ini.ReadInteger('Client Setup', 'BlendAlpha', g_btAlpha);
    ini.Free;
  end;
{$IFEND}
  MAPSURFACEWIDTH := SCREENWIDTH;
  if (g_ConfigClient.btMainInterface = 1) or (SCREENWIDTH = 1024) then begin
    MAPSURFACEHEIGHT := SCREENHEIGHT;
  end else begin
    MAPSURFACEHEIGHT := SCREENHEIGHT - 155;
  end;
  WINRIGHT := SCREENWIDTH - 60;
  BOTTOMEDGE := SCREENHEIGHT - 30;
  MAXX := SCREENWIDTH div 20;
  MAXY := SCREENWIDTH div 20;

  g_dwShowVersionBmpTick := GetTickCount;

  MainForm := Self;
  Application.OnMessage := AppMessage;

  ImageCanvas.SetSize(SCREENWIDTH, SCREENHEIGHT);

  g_BackSurface := TTexture.Create;
  g_BackSurface.SetSize(1, 1);

  {for I := 0 to Length(g_BackSurfaces) - 1 do begin
    g_BackSurfaces[I] := TTexture.Create;
    g_BackSurfaces[I].SetSize(SCREENWIDTH, SCREENHEIGHT);
  end;}

  PlugInManage := TPlugInManage.Create;
  g_PlugInfo.AppHandle := Handle;

  //DXDraw.Display.BitCount := 16;
  BorderStyle := bsSingle;
  BorderIcons := [biSystemMenu, biMinimize];

  SendGameCenterMsg(CM_HANDLE, IntToStr(Handle));

  g_Buffer := nil;
  g_ConfigBuffer := nil;
  ClientWidth := SCREENWIDTH;
  ClientHeight := SCREENHEIGHT;

  Application.OnMessage := AppMessage;
  Canvas.Font.OnChange := FontChange;

  g_GuaJi := TGuaJi.Create;

  g_UnbindItemList := TList.Create;
  g_UnbindItemFileList := TStringList.Create;
  g_ShowItemFileList := TStringList.Create;
  g_ShowItemList := TFileItemDB.Create;
  g_MediaList := TGStringList.Create;

  g_ItemDescList := TGStringList.Create;
  g_ExtractStringList := TStringList.Create;

{$IF CLIENTTEST = 0}
  LoadConfig();
{$ELSE}
  g_ConfigClient.WEffectImg := lmUseWil;
  g_ConfigClient.WDragonImg := lmUseWil;
  g_ConfigClient.WMainImages := lmUseWil;
  g_ConfigClient.WMain2Images := lmUseWil;
  g_ConfigClient.WMain3Images := lmUseWil;
  g_ConfigClient.WChrSelImages := lmUseWil;
  g_ConfigClient.WMMapImages := lmUseWil;
  g_ConfigClient.WHumWingImages := lmUseWil;
  g_ConfigClient.WHum1WingImages := lmUseWil;
  g_ConfigClient.WHum2WingImages := lmUseWil;
  g_ConfigClient.WBagItemImages := lmUseWil;
  g_ConfigClient.WStateItemImages := lmUseWil;
  g_ConfigClient.WDnItemImages := lmUseWil;
  g_ConfigClient.WHumImgImages := lmUseWil;
  g_ConfigClient.WHairImgImages := lmUseWil;
  g_ConfigClient.WHair2ImgImages := lmUseWil;
  g_ConfigClient.WWeaponImages := lmUseWil;
  g_ConfigClient.WMagIconImages := lmUseWil;
  g_ConfigClient.WNpcImgImages := lmUseWil;
  g_ConfigClient.WFirNpcImgImages := lmUseFir;
  g_ConfigClient.WMagicImages := lmUseWil;
  g_ConfigClient.WMagic2Images := lmUseWil;
  g_ConfigClient.WMagic3Images := lmUseWil;
  g_ConfigClient.WMagic4Images := lmUseWil;
  g_ConfigClient.WMagic5Images := lmUseWil;
  g_ConfigClient.WMagic6Images := lmUseWil;
  g_ConfigClient.WHorseImages := lmUseWil;
  g_ConfigClient.WHumHorseImages := lmUseWil;
  g_ConfigClient.WHairHorseImages := lmUseWil;
  for I := 0 to Length(g_ConfigClient.WMonImages) - 1 do
    g_ConfigClient.WMonImages[I] := lmUseWil;
  LoadItemDescList;
{$IFEND}

  LoadWMImagesLib();

  {g_nPos := nil;
  g_nLen := nil;
  g_nSize := nil;
  g_nCrc := nil;  }


  ini := nil;
  FtpConf := nil;

    //g_DWinMan := TDWinManager.Create(Self);
  g_DXDraw := DXDraw;

  Randomize;

  g_ServerList := TStringList.Create;

    //g_boFullScreen:=True;
 // Caption := g_sLogoText;

  if g_boFullScreen then begin
    BorderStyle := bsNone;
    Left := 0;
    Top := 0;
    DXDraw.Options := DXDraw.Options + [doFullScreen]; //全屏
  end else begin
    {BorderStyle := bsSingle;
    BorderIcons := BorderIcons - [biMaximize];  }
  end;

  DXDraw.Display.Width := SCREENWIDTH;
  DXDraw.Display.Height := SCREENHEIGHT;

  Application.OnException := OnProgramException;

  //LoadWMImagesLib();

  g_ProcessesList := TStringList.Create;

  //g_ShowFormList := TList.Create;
  m_MsgList := TGList.Create;

  NpcImageList := TList.Create;
  ItemImageList := TList.Create;
  WeaponImageList := TList.Create;
  HumImageList := TList.Create;
  {g_DXSound := TDXSound.Create(Self);
  g_DXSound.Initialize;}
  DXDraw.Display.Width := SCREENWIDTH;
  DXDraw.Display.Height := SCREENHEIGHT;

  SoundEngine := TPlaySound.Create(Self);
  SoundEngine.Initialize;

  asm
   nop
   nop
   nop
   nop
  end;

  g_ToolMenuHook := SetWindowsHookEx(WH_KEYBOARD, @KeyboardHookProc, 0, GetCurrentThreadId);

  asm
   nop
   nop
   nop
   nop
  end;

  g_SoundList := TStringList.Create;
  BGMusicList := TStringList.Create;

  flname := '.\wav\sound.lst';
  //if not FileExists(flname) then
    //flname := '.\wav\sound.lst';

  LoadSoundList(flname);

  flname := '.\wav\BGList.lst';
  LoadBGMusicList(flname);
  //if FileExists (flname) then
  //   SoundList.LoadFromFile (flname);
  DScreen := TDrawScreen.Create;
  IntroScene := TIntroScene.Create;
  LoginScene := TLoginScene.Create;
  SelectChrScene := TSelectChrScene.Create;
  PlayScene := TPlayScene.Create;

  LoginNoticeScene := TLoginNotice.Create;

  Map := TMap.Create;
  LegendMap := TLegendMap.Create;

  g_MapDesc := TMapDesc.Create;
  g_MapDesc.LoadFromFile(MAPDESC1FILE);


  g_DropedItemList := TGList.Create;
  g_MagicList := TList.Create;
  g_HeroMagicList := TList.Create;
  g_FreeActorList := TList.Create;
  g_SerieMagicList := TList.Create; //连击
  g_SerieMagicingList := TList.Create;
  //DObjList := TList.Create;
  EventMan := TClEventManager.Create;
  g_ChangeFaceReadyList := TList.Create;

  g_HintList := TStringList.Create;
  PlugInManage.LoadPlugIn;

  g_MainHandle := Handle;

  for I := Screen.Fonts.Count - 1 downto 0 do
  begin
    if Pos(g_sFontName, Screen.Fonts.Strings[I]) > 0 then begin
      g_sFontName := Screen.Fonts.Strings[I];
      break;
    end;
  end;

  g_MySelf := nil;
  g_MyHero := nil; //英雄
  FillChar(g_HeroUseItems, SizeOf(TClientItem) * 13, #0);
  FillChar(g_HeroItemArr, SizeOf(TClientItem) * MAXHEROBAGITEM, #0);
  FillChar(g_UseItems, SizeOf(TClientItem) * 13, #0);
  FillChar(g_ItemArr, SizeOf(TClientItem) * MAXBAGITEMCL, #0);
  FillChar(g_DealItems, SizeOf(TClientItem) * 10, #0);
  FillChar(g_DealRemoteItems, SizeOf(TClientItem) * 20, #0);

  FillChar(g_MouseShopItems.ShopItem, SizeOf(TShopItem), #0);
  //FillChar(g_MouseShopItems, Sizeof(TPlayShopItem), #0);
  FillChar(g_UpgradeItems, SizeOf(TClientItem) * 3, #0);
  FillChar(g_UpgradeItemsWait, SizeOf(TClientItem) * 3, #0);

  FillChar(g_DuelDlgItem, SizeOf(TClientItem), #0);
  FillChar(g_DuelItems, SizeOf(TClientItem) * 5, #0);
  FillChar(g_DuelRemoteItems, SizeOf(TClientItem) * 5, #0);

  FillChar(g_DrawUseItems, SizeOf(TDrawEffect) * 13, #0);
  FillChar(g_DrawUseItems1, SizeOf(TDrawEffect) * 13, #0);
  FillChar(g_DrawHeroUseItems, SizeOf(TDrawEffect) * 13, #0);

  FillChar(g_DrawItemArr, SizeOf(TDrawEffect) * 46, #0);
  FillChar(g_DrawHeroItemArr, SizeOf(TDrawEffect) * 40, #0);
  FillChar(g_DrawDealRemoteItems, SizeOf(TDrawEffect) * 20, #0);
  FillChar(g_DrawDealItems, SizeOf(TDrawEffect) * 20, #0);


  FillChar(g_DrawUseItems_, SizeOf(TDrawEffect) * 13, #0);
  FillChar(g_DrawUseItems1_, SizeOf(TDrawEffect) * 13, #0);
  FillChar(g_DrawHeroUseItems_, SizeOf(TDrawEffect) * 13, #0);

  FillChar(g_DrawItemArr_, SizeOf(TDrawEffect) * 46, #0);
  FillChar(g_DrawHeroItemArr_, SizeOf(TDrawEffect) * 40, #0);
  FillChar(g_DrawDealRemoteItems_, SizeOf(TDrawEffect) * 20, #0);
  FillChar(g_DrawDealItems_, SizeOf(TDrawEffect) * 20, #0);


  FillChar(g_StoreItems, SizeOf(TStoreItem) * 15, #0);
  FillChar(g_StoreRemoteItems, SizeOf(TStoreItem) * 15, #0);
  FillChar(g_DrawStoreItems, SizeOf(TDrawEffect) * 15, #0);
  FillChar(g_DrawStoreItems_, SizeOf(TDrawEffect) * 15, #0);
  FillChar(g_DrawStoreRemoteItems, SizeOf(TDrawEffect) * 15, #0);
  FillChar(g_DrawStoreRemoteItems_, SizeOf(TDrawEffect) * 15, #0);

  for I := 0 to 255 - 1 do begin
    g_DrawStarsTick[I].nIndex := 60;
    g_DrawStarsTick[I].nCount := 0;
    g_DrawStarsTick[I].dwDrawTick := GetTickCount;
  end;

  SafeFillChar(g_SerieMagic, SizeOf(TSerieMagic) * 8, #0);
  g_SerieTarget := nil;
  g_boSerieMagic := False;
  g_boSerieMagicing := False;
  g_nSerieIndex := -1;
  g_dwSerieMagicTick := GetTickCount;
  g_SerieMagicingList.Clear;

  g_QueryBagItem := q_QueryHum;
  g_boQueryHumBagItem := False;
  g_boQueryHeroBagItem := False;
  g_CartInfoList := TGList.Create;

  g_MouseShopItems.nPicturePosition := -1;
  g_MouseShopItems.dwPlaySpeedTick := 0;

  g_SaveItemList := TList.Create;
  g_MenuItemList := TList.Create;
  g_WaitingUseItem.Item.S.Name := '';
  g_EatingItem.S.Name := '';
  g_HeroEatingItem.S.Name := '';
  g_nTargetX := -1;
  g_nTargetY := -1;
  g_TargetCret := nil;
  g_FocusCret := nil;
  g_FocusItem := nil;
  g_MagicTarget := nil;
  g_nDebugCount := 0;
  g_nDebugCount1 := 0;
  g_nDebugCount2 := 0;
  g_nTestSendCount := 0;
  g_nTestReceiveCount := 0;
  g_boServerChanging := False;
  g_boBagLoaded := False;
  g_boAutoDig := False;

  g_dwLatestClientTime2 := 0;
  g_dwFirstClientTime := 0;
  g_dwFirstServerTime := 0;
  g_dwFirstClientTimerTime := 0;
  g_dwLatestClientTimerTime := 0;
  g_dwFirstClientGetTime := 0;
  g_dwLatestClientGetTime := 0;

  g_nTimeFakeDetectCount := 0;
  g_nTimeFakeDetectTimer := 0;
  g_nTimeFakeDetectSum := 0;

  g_dwSHGetTime := 0;
  g_dwSHTimerTime := 0;
  g_nSHFakeCount := 0;

  g_nDayBright := 3;
  g_nAreaStateValue := 0;
  g_ConnectionStep := cnsStart;
  g_boSendLogin := False;
  g_boServerConnected := False;
  g_sSockText := '';
  WarningLevel := 0;
  ActionFailLock := False;
  g_boMapMoving := False;
  g_boMapMovingWait := False;
  g_boCheckBadMapMode := False;
  g_boCheckSpeedHackDisplay := False;
  g_boViewMiniMap := False;
  g_boShowWhiteHint := True;
  FailDir := 0;
  FailAction := 0;
  g_nDupSelection := 0;

  g_dwLastAttackTick := GetTickCount;
  g_dwLastMoveTick := GetTickCount;
  g_dwLatestSpellTick := GetTickCount;

  g_boFirstTime := True;
  g_boItemMoving := False;
  g_boDoFadeIn := False;
  g_boDoFadeOut := False;
  g_boDoFastFadeOut := False;
  g_boAttackSlow := False;
  g_boMoveSlow := False;
  g_boNextTimePowerHit := False;
  g_boCanLongHit := False;
  g_boCanWideHit := False;
  g_boCanCrsHit := False;
  g_boCanTwnHit := False;

  g_boNextTimeFireHit := False;
  g_boNextTimeKTZHit := False;
  g_boNextTimePKJHit := False;

  g_boNoDarkness := False;
  g_SoftClosed := False;
  g_boQueryPrice := False;
  g_sSellPriceStr := '';

  g_boAllowGroup := False;
  g_GroupMembers := TStringList.Create;

  MainWinHandle := DXDraw.Handle;

  g_nMerchantPosition := 0;
  SafeFillChar(g_MerchantFontColor, SizeOf(TNPCFontColor), 0);
  g_MerchantFontColorTick := GetTickCount;
  g_SelMerchant := 0;

  BoOneClick := False;
  OneClickMode := toNone;

  g_boSound := True;
  g_boBGSound := True;
  FillCharBoxItems();

  GetMem(g_Buffer, 1024 * 2);

  RegInfo.boShare := True;
  RegInfo.nParam1 := Random(High(Integer));
  RegInfo.nParam2 := Random(High(Integer));
  if (g_ConfigClient.sDomainName <> '') and (StringCrc(g_ConfigClient.sDomainName) = g_ConfigClient.nDomainName) then begin
    RegInfo.nParam2 := StringCrc(EncryStrHex3(DecryptString(g_ConfigClient.sDomainName), IntToStr(RegInfo.nParam1)));
  end;
  RegInfo.nProcedure[19] := Integer(@OpenHomePage);
  RegInfo.nProcedure[18] := Integer(@OpenHomePage1);
  RegInfo.nProcedure[17] := Integer(@OpenDuelDlg);
  RegInfo.nProcedure[16] := Integer(@OpenStoreDlg);
  RegInfo.nProcedure[15] := Integer(@OpenUserStoreDlg);

    {
    DebugOutStr('RegInfo.nProcedure[19]:' + IntToStr(RegInfo.nProcedure[19]));
    DebugOutStr('RegInfo.nProcedure[18]:' + IntToStr(RegInfo.nProcedure[18]));
    DebugOutStr('RegInfo.nProcedure[17]:' + IntToStr(RegInfo.nProcedure[17]));
    DebugOutStr('RegInfo.nProcedure[16]:' + IntToStr(RegInfo.nProcedure[16]));
    DebugOutStr('RegInfo.nProcedure[15]:' + IntToStr(RegInfo.nProcedure[15]));
    }

  sRegInfo := EncryptBuffer(@RegInfo, SizeOf(TRegInfo));
  nRegInfo := Length(sRegInfo);
  Move(nRegInfo, g_Buffer^, SizeOf(Integer));
  Move(sRegInfo[1], g_Buffer[SizeOf(Integer)], nRegInfo);

  g_nCodeMsgSize := GetCodeMsgSize(SizeOf(TCharDesc) * 4 / 3);

  New(g_dwOpenHomePageTick);
  g_dwOpenHomePageTick^ := GetTickCount;

  CSocket.Address := g_sServerAddr;
  CSocket.Port := g_nServerPort;
  
  asm
   nop
   nop
   nop
   nop
  end;

  CSocket.Active := True;

  asm
   nop
   nop
   nop
   nop
  end;
  //PlugInManage.LoadPlugIn;
  DebugOutStr('----------------------- started ------------------------');

    //Module := LoadLibrary('test.dll');

  //g_boSocketConnect := False;
  g_dwShowVersionBmpTick := GetTickCount;
  Application.OnIdle := AppOnIdle;
  //DXTimer.Enabled := True;

  TimerRun.Enabled := True;

  MouseTimer.Enabled := True;
  MinTimer.Enabled := True;

  g_sMainParam5 := '';
  //TimerConnect.Enabled := True;
end;

procedure TfrmMain.DXDrawInitialize(Sender: TObject);
var
  I, nTop: Integer;
  DLabel: TDLabel;
  DCheckBox: TDCheckBox;
  ItemList: TStringList;
  ShowItem: pTShowItem;
  //Shift: TShiftState;
  //nKey: Integer;
  List: TList;
begin
  g_PlugInfo.AppHandle := Handle;
  g_MainHandle := Handle;
  if Assigned(g_PlugInfo.HookInitialize) then begin
    g_PlugInfo.HookInitialize();
  end;

  if g_boFirstTime then begin
    g_boFirstTime := False;
    //DebugOutStr('DXDraw.Display.BitCount:' + IntToStr(DXDraw.Display.BitCount));
    SoundEngine.Resume;

    DXDraw.SurfaceWidth := SCREENWIDTH;
    DXDraw.SurfaceHeight := SCREENHEIGHT;
{$IF USECURSOR = DEFAULTCURSOR}
    DXDraw.Cursor := crDefault; //crHourGlass;
{$ELSE}
    DXDraw.Cursor := crNone;
{$IFEND}
    frmMain.Font.Name := g_sCurFontName;
    frmMain.Canvas.Font.Name := g_sCurFontName;
    DXDraw.Surface.Canvas.Font.Assign(frmMain.Font);
    DXDraw.Surface.Canvas.Font.Name := g_sCurFontName;
    //FrmDlg.EdChat.Font.Name := g_sCurFontName;

    g_DXDraw := DXDraw;
    IniTWilImagesLib();
    DScreen.Initialize;
    PlayScene.Initialize;

   { FrmDlg.DCheckBoxDamageUseItem1.Caption := g_ConfigClient.DamageUseItemNames[0];
    FrmDlg.DCheckBoxDamageUseItem2.Caption := g_ConfigClient.DamageUseItemNames[1];
    FrmDlg.DCheckBoxDamageUseItem3.Caption := g_ConfigClient.DamageUseItemNames[2];
    FrmDlg.DCheckBoxDamageUseItem4.Caption := g_ConfigClient.DamageUseItemNames[3]; }

    FrmDlg.Initialize;

    nTop := 1;
    List := TList.Create;
    with FrmDlg do begin
      DMemoTab2.Clear;
      if DComboboxItemType.itemindex <= 0 then begin
        g_ShowItemList.Get(i_All, List);
      end else begin
        g_ShowItemList.Get(TItemType(DComboboxItemType.itemindex - 1), List);
      end;

      for I := 0 to List.Count - 1 do begin
        if (I mod 50 = 0) and (g_boShowVersionBmp) then begin
          frmMain.ProcOnIdle;
          Application.ProcessMessages;
        end;
        ShowItem := List.Items[I];
        ItemList := DMemoTab2.Add;
        TLines(ItemList).Data := ShowItem;
        DLabel := TDLabel.Create(DMemoTab2);
        DLabel.Caption := AddSpace(ShowItem.sItemName, 72);
        DLabel.DParent := DMemoTab2;
        DLabel.Left := TLines(ItemList).Width;
        DLabel.Top := nTop;
        DLabel.Style := bsRadio;
        DLabel.UpColor := clWhite;
        DLabel.HotColor := clWhite;
        DLabel.DownColor := clRed;
        DMemoTab2.AddSuItem(ItemList, DLabel);

        DCheckBox := TDCheckBox.Create(DMemoTab2);
        DCheckBox.DParent := DMemoTab2;
        DCheckBox.Data := ShowItem;
        DCheckBox.Left := 156;
        DCheckBox.Top := nTop;
        DCheckBox.SetImgIndex(g_WMain2Images, 228);
        DCheckBox.OnDirectPaint := DButtonTab1DirectPaint;
        DCheckBox.OnClick := DDCheckBoxHintClick;
        DCheckBox.Checked := ShowItem.boHintMsg;
        DMemoTab2.AddSuItem(ItemList, DCheckBox);

        DCheckBox := TDCheckBox.Create(DMemoTab2);
        DCheckBox.DParent := DMemoTab2;
        DCheckBox.Data := ShowItem;
        DCheckBox.Left := 230;
        DCheckBox.Top := nTop;
        DCheckBox.SetImgIndex(g_WMain2Images, 228);
        DCheckBox.OnDirectPaint := DButtonTab1DirectPaint;
        DCheckBox.OnClick := DDCheckBoxPickupClick;
        DCheckBox.Checked := ShowItem.boPickup;
        DMemoTab2.AddSuItem(ItemList, DCheckBox);

        DCheckBox := TDCheckBox.Create(DMemoTab2);
        DCheckBox.DParent := DMemoTab2;
        DCheckBox.Data := ShowItem;
        DCheckBox.Left := 300;
        DCheckBox.Top := nTop;
        DCheckBox.SetImgIndex(g_WMain2Images, 228);
        DCheckBox.OnDirectPaint := DButtonTab1DirectPaint;
        DCheckBox.OnClick := DDCheckBoxShowNameClick;
        DCheckBox.Checked := ShowItem.boShowName;
        DMemoTab2.AddSuItem(ItemList, DCheckBox);

        Inc(nTop, 17);
      end;
    end;
    List.Free;

    if doFullScreen in DXDraw.Options then begin
         //Screen.Cursor := crNone;
    end else begin
    end;

    g_ImgMixSurface := TTexture.Create();
    g_MiniMapSurface := TTexture.Create();
    g_RandomSurface := TTexture.Create();
    g_RandomSurface.SetSize(120, 60);

  end else begin
    DXDraw.Display.Width := SCREENWIDTH;
    DXDraw.Display.Height := SCREENHEIGHT;
    DXDraw.SurfaceWidth := SCREENWIDTH;
    DXDraw.SurfaceHeight := SCREENHEIGHT;
    if doFullScreen in DXDraw.Options then begin
         //Screen.Cursor := crNone;

    end else begin
         // DF WindowModeFix 1
      Self.ClientWidth := SCREENWIDTH;
      Self.ClientHeight := SCREENHEIGHT;
      Self.Left := Round((Screen.Width - Self.Width) / 2);
      Self.Top := Round((Screen.Height - Self.Height) / 2);
    end;

    Self.Font.Name := g_sCurFontName;
    Self.Canvas.Font.Name := g_sCurFontName;
    DXDraw.Surface.Canvas.Font.Assign(frmMain.Font);
    DXDraw.Surface.Canvas.Font.Name := g_sCurFontName;
  end;

  if Assigned(g_PlugInfo.HookInitializeEnd) then begin
    g_PlugInfo.HookInitializeEnd();
  end;
  g_boCanDraw := True;
  FontChange(Self);
end;

{------------------------------------------------------------}

procedure TfrmMain.ProcOnIdle;
var
  Done: Boolean;
begin
  AppOnIdle(Self, Done);
end;

function Sc_PassWord(Ws: Integer; fh, sz, dx, xx: Boolean): string;
var
  I: Integer;
  templist, templist1, templist2, templist3, templist4: TStringList;
begin
  templist := TStringList.Create;
  templist1 := TStringList.Create;
  templist2 := TStringList.Create;
  templist3 := TStringList.Create;
  templist4 := TStringList.Create;
  for I := 33 to 47 do templist1.Add(Chr(I)); //符号
  for I := 48 to 57 do templist2.Add(Chr(I)); //数字
  for I := 58 to 64 do templist1.Add(Chr(I)); //符号
  for I := 65 to 90 do templist3.Add(Chr(I)); //大写字母
  for I := 91 to 96 do templist1.Add(Chr(I)); //符号
  for I := 97 to 122 do templist4.Add(Chr(I)); //小写字母
  for I := 123 to 126 do templist1.Add(Chr(I)); //符号
  if fh then templist.Text := templist.Text + templist1.Text;
  if sz then templist.Text := templist.Text + templist2.Text;
  if dx then templist.Text := templist.Text + templist3.Text;
  if xx then templist.Text := templist.Text + templist4.Text;
  if templist.Count = 0 then begin
    Result := '';
    Exit;
  end;
  Randomize;
  Result := '';
  while Length(Result) < Ws do begin
    I := 0;
    I := Random(templist.Count);
    if (I >= 0) and (I < templist.Count) then
      Result := Result + templist.Strings[I];
  end;
end;

procedure TfrmMain.AppOnIdle(Sender: TObject; var Done: Boolean);
var
  t, t2: DWORD;
  LagCount: Integer;

  I, j: Integer;
  p: TPoint;
  DF: TDDBLTFX;
  d: TTexture;
  nC: Integer;
  nLeft, nTop: Integer;
  nSize: Integer;
  FontStyles: TFontStyles;
  sText: string;
  dwTickTime: LongWord;
  sdsd: TDDSurfaceDesc2;
  ddsd: TDDSurfaceDesc2;
  boCanDraw: Boolean;
begin
  //dwTickTime := GetTickCount;
  Done := True;
  boCanDraw := False;
  g_boMinimized := WindowState = wsMinimized;
  if (not CanDraw) then begin
    ProcessKeyMessages;
    ProcessActionMessages;
    PlayScene.Run(True);
    if g_MySelf <> nil then begin
      if g_boVibration then begin
        g_nVibrationX := g_nVibrationX + g_VibrationValue[g_nVibrationPos].X;
        g_nVibrationY := g_nVibrationY + g_VibrationValue[g_nVibrationPos].Y;
        Inc(g_nVibrationPos);
        if g_nVibrationPos >= Length(g_VibrationValue) then begin
          g_nVibrationPos := 0;
          Inc(g_nVibrationCount);
        end;
        g_boVibration := g_nVibrationCount < g_nVibrationTotal;
      end;
    end;
    Exit;
  end;

  t := TimeGetTime;
  t2 := t - FOldTime;
  if t2 >= FInterval then begin
    FOldTime := t;

    LagCount := t2 div FInterval2;
    if LagCount < 1 then LagCount := 1;

    Inc(FNowFrameRate);

    i := Max(t - FOldTime2, 1);
    if i >= 1000 then begin
      FFrameRate := Round(FNowFrameRate * 1000 / i);
      FNowFrameRate := 0;
      FOldTime2 := t;
    end;
    boCanDraw := True;
    //DoTimer(LagCount);
  end;

  ProcessKeyMessages;
  ProcessActionMessages;
  DWinMan.Process;
  //Inc(g_dwProcessTime);

  //if g_dwProcessTime > g_nProcessInterval then begin
  if boCanDraw then begin
    if (g_boShowVersionBmp) then begin
      d := g_BackSurface;
      if d <> nil then begin
        ImageCanvas.Fill(d.Pixels[0, 0]); //clWhite
        ImageCanvas.Draw((ImageCanvas.Width - d.Width) div 2, (ImageCanvas.Height - d.Height) div 2, d);
      end;
    end else begin
      ImageCanvas.Fill(0);

     { for I := 0 to Length(g_BackSurfaces) - 1 do
        g_BackSurfaces[I].Fill(0);}

      DScreen.DrawScreen(ImageCanvas);

     // if (g_ConnectionStep <> cnsPlay) then begin
     // DScreen.Draw(ImageCanvas);
     // if g_MySelf = nil then
      DWinMan.DirectPaint(ImageCanvas);

      DScreen.DrawScreenTop(ImageCanvas);

      DScreen.DrawHint(ImageCanvas);

      DScreen.DrawMsg(ImageCanvas);
     //  end;
{------------------------------------------------------------------------------}
      if g_boItemMoving then begin
        //ImageCanvas.FillRectAlpha(g_MoveRect, clGreen, 160);
        if (g_MovingItem.Item.S.Name <> g_sGoldName {'金币'}) then
          d := g_WBagItemImages.Images[g_MovingItem.Item.S.looks]
        else d := g_WBagItemImages.Images[115]; //金币外形

        if d <> nil then begin
          GetCursorPos(p);
          p := ScreenToClient(p);
        //iamwgh 画移动物品跟随鼠标，此处修正坐标以适应非全屏状态位置
          ImageCanvas.Draw(p.X - (d.ClientRect.Right div 2),
            p.Y - (d.ClientRect.Bottom div 2),
            d.ClientRect,
            d);
        end;
      end;
{------------------------------------------------------------------------------}
      if g_boDoFadeOut then begin
        g_nFadeIndex := 1;
      end else
        if g_boDoFadeIn then begin
        g_nFadeIndex := 29;
      end else
        if g_boDoFastFadeOut then begin
        g_nFadeIndex := 1;
      end;

{------------------------------------------------------------------------------}
      if g_ConnectionStep < cnsSelChr then begin
        with ImageCanvas do begin
          BoldTextOut((SCREENWIDTH - TextHeight(sGameNoticeName)) div 2 - TextWidth('A') * 6, SCREENHEIGHT - TextHeight('A') * 5, sGameNoticeName, GetRGB(150));
          BoldTextOut((SCREENWIDTH - TextWidth(sGameNoticeStr1)) div 2, SCREENHEIGHT - TextHeight('A') * 3, sGameNoticeStr1, GetRGB(150));
          BoldTextOut((SCREENWIDTH - TextWidth(sGameNoticeStr1)) div 2, SCREENHEIGHT - TextHeight('A') * 2 + TextHeight('A') div 2, sGameNoticeStr2, GetRGB(150));
        end;
      end;
      if g_ConnectionStep <> cnsPlay then
        with ImageCanvas do
          TextOut(TextHeight('A'), SCREENHEIGHT - TextHeight('A'), sVERSION, clGray);
{------------------------------------------------------------------------------}
      if g_ConfigClient.boShowFullScreen then begin
        if not g_boFullScreen then begin
          sText := 'Alt + Enter 键切换到全屏模式';
        end else begin
          sText := 'Alt + Enter 键切换到窗口模式';
        end;
        with ImageCanvas do begin
          nC := TextWidth(sText) + 20;
          BoldTextOut((SCREENWIDTH - nC) + ((nC - TextWidth(sText)) div 2),
            SCREENHEIGHT - 65 - TextHeight('A') * 2, sText, clLime);

          //TextOut(0, SCREENHEIGHT - TextHeight('A') * 10, 'g_WMainImages.ImageCount:' + IntToStr(g_WMain3Images.ImageCount), GetRGB(150));
          //TextOut(0, SCREENHEIGHT - TextHeight('A') * 9, 'g_WMainImages.m_IndexList.Count:' + IntToStr(g_WMain3Images.m_IndexList.Count), GetRGB(150));
        end;
      end;
    end;

{---------------------------------输出到表面-----------------------------------}
    ddsd.dwSize := SizeOf(ddsd);
    //EnterCriticalSection(g_Flib_CS);
    DXDraw.Surface.Lock(TRect(nil^), ddsd);
    try
      ImageCanvas.DrawSurface(ImageCanvas.ClientRect,
        DXDraw.Surface.ClientRect,
        PByte(ddsd.lpSurface),
        ddsd.lPitch,
        DXDraw.Surface.BitCount);
    finally
      DXDraw.Surface.UnLock;
      //LeaveCriticalSection(g_Flib_CS);
    end;


    //if g_ConnectionStep <> cnsPlay then

    //DXDraw.Primary.Draw(0,0,DXDraw.Surface.ClientRect,DXDraw.Surface,False);

  { Draw FrameRate }
   { with DXDraw.Surface.Canvas do
    begin
      try
        Brush.Style := bsClear;
        Font.Color := clWhite;
        Font.Size := 12;
        Textout(0, 20, 'FPS: ' + inttostr(FFrameRate));

      finally
        Release;
      end;
    end;}
     //if g_ConnectionStep <> cnsPlay then
    DXDraw.Flip;
{---------------------------------输出到表面-----------------------------------}
    g_dwProcessTime := 0;
  end else begin
    //if g_dwRunTime > 4 then begin //g_nProcessInterval
    PlayScene.Run(True);
      //g_dwRunTime := 0;
    //end else Inc(g_dwRunTime);
  end;
end;

procedure TfrmMain.Logout;
begin
  g_boLoadUserConfig := False;
  SendClientMessage(CM_SOFTCLOSE, 0, 0, 0, 0);
  PlayScene.ClearActors;
  CloseAllWindows;
  if not BoOneClick then begin
      //         PlayScene.MemoLog.Lines.Add('小退关闭');
    g_SoftClosed := True;
    ActiveCmdTimer(tcSoftClose);
  end else begin
    ActiveCmdTimer(tcReSelConnect);
  end;
  if g_boBagLoaded then
    Savebags('.\Data\' + g_sServerName + '.' + g_sSelChrName + '.itm', @g_ItemArr);
  g_boBagLoaded := False;
end;

procedure TfrmMain.AppLogout;
begin
  if mrOk = FrmDlg.DMessageDlg('你是否退出 ?', [mbOk, mbCancel]) then begin
    DScreen.ClearHint;
    Logout;
  end;
end;

procedure TfrmMain.AppExit;
begin
  if mrOk = FrmDlg.DMessageDlg('你真的要退出游戏吗?', [mbOk, mbCancel]) then begin
    if g_boBagLoaded then
      Savebags('.\Data\' + g_sServerName + '.' + g_sSelChrName + '.itm', @g_ItemArr);
    g_boBagLoaded := False;
    frmMain.Close;
  end;
end;

procedure TfrmMain.PrintScreenNow;
  function IntToStr2(n: Integer): string;
  begin
    if n < 10 then Result := '0' + IntToStr(n)
    else Result := IntToStr(n);
  end;
  procedure BoldOut(Surface: TDirectDrawSurface; X, Y, FColor, Bcolor: Integer; Str: string); //输出抖动加粗
  begin
    with Surface do begin
      Canvas.Font.Color := Bcolor;
      Canvas.TextOut(X - 1, Y, Str);
      Canvas.TextOut(X + 1, Y, Str);
      Canvas.TextOut(X, Y - 1, Str);
      Canvas.TextOut(X, Y + 1, Str);
      Canvas.Font.Color := FColor;
      Canvas.TextOut(X, Y, Str);
    end;
  end;
var
  I, k, n, CheckSum: Integer;
  flname: string;
  ddsd: TDDSurfaceDesc2;
  sptr, dptr: PByte;
  wksite: string;
  sDirectory: string;
begin
  if not CanDraw then Exit;

  sDirectory := 'Images\';
  if not DirectoryExists(sDirectory) then CreateDir(sDirectory);

  sDirectory := '.\Images\';
  while True do begin
    flname := 'Images' + IntToStr2(g_nCaptureSerial) + '.BMP';
    if not FileExists(sDirectory + flname) then begin
      DScreen.AddChatBoardString('[Screenshot: ' + flname + '] saved.', clGreen, clWhite);
      Break;
    end;
    Inc(g_nCaptureSerial);
  end;

  flname := sDirectory + flname;

  ddsd.dwSize := SizeOf(ddsd);
  CheckSum := 0; //计算验证码
  try
    DXDraw.Surface.Lock(TRect(nil^), ddsd);
    for I := (600 - 120) to SCREENHEIGHT - 10 do begin
      sptr := PByte(Integer(ddsd.lpSurface) + (SCREENHEIGHT - 1 - I) * ddsd.lPitch + 200);
      for k := 0 to 400 - 1 do begin
        CheckSum := CheckSum + Byte(PByte(Integer(sptr) + k)^);
      end;
    end;
  finally
    DXDraw.Surface.UnLock();
  end;
  n := 0;
  if g_MySelf <> nil then begin
    ImageCanvas.BoldTextOut(0, 0, g_sServerName + ' ' + g_MySelf.m_sUserName);
    Inc(n, 1);
  end;
  {g_Background.BoldTextOut(0, (n) * 12, 'CheckSum=' + IntToStr(CheckSum));
  g_Background.BoldTextOut(0, (n + 1) * 12, DateToStr(Date));
  g_Background.BoldTextOut(0, (n + 2) * 12, TimeToStr(Time));
  g_Background.BoldTextOut(0, (n + 3) * 12, DecodeString(sMyQQ));}

  SetBkMode(DXDraw.Surface.Canvas.Handle, TRANSPARENT);
  DXDraw.Surface.Canvas.Font.Color := clWhite;
  n := 0;
  if g_MySelf <> nil then begin
    BoldOut(DXDraw.Surface, 1, 1, clWhite, clBlack, g_sServerName + ' ' + g_MySelf.m_sUserName);
    //DXDraw.Surface.Canvas.TextOut(0, 0, g_sServerName + ' ' + g_MySelf.m_sUserName);
    Inc(n, 1);
  end;
  BoldOut(DXDraw.Surface, 1, (n) * 12 + 1, clWhite, clBlack, 'CheckSum=' + IntToStr(CheckSum));
  BoldOut(DXDraw.Surface, 1, (n + 1) * 12 + 1, clWhite, clBlack, DateToStr(Date));
  BoldOut(DXDraw.Surface, 1, (n + 2) * 12 + 1, clWhite, clBlack, TimeToStr(Time));
  //BoldOut(DXDraw.Surface, 1, (n + 3) * 12 + 1, clWhite, clBlack, DecodeString(sMyQQ));
  //DXDraw.Surface.Canvas.TextOut(0, (n + 1) * 12, DateToStr(Date));
  //DXDraw.Surface.Canvas.TextOut(0, (n + 2) * 12, TimeToStr(Time));
  //DXDraw.Surface.Canvas.TextOut(0, (n + 3) * 12, DecodeString(sMyQQ));
  DXDraw.Surface.Canvas.Release;

  DXDraw.Surface.SaveToFile(flname);
end;

{------------------------------------------------------------}

procedure TfrmMain.ProcessKeyMessages;
begin
  //if GetTickCount - g_dwProcessKeyTick < 100 then Exit;
  case ActionKey of
    VK_F1, VK_F2, VK_F3, VK_F4, VK_F5, VK_F6, VK_F7, VK_F8: begin
        UseMagic(g_nMouseX, g_nMouseY, GetMagicByKey(Char((ActionKey - VK_F1) + Byte('1'))));
        ActionKey := 0;
        g_nTargetX := -1;
        Exit;
      end;
    12..19: begin
        UseMagic(g_nMouseX, g_nMouseY, GetMagicByKey(Char((ActionKey - 12) + Byte('1') + Byte($14))));
        ActionKey := 0;
        g_nTargetX := -1;
        Exit;
      end;
  end;
end;
{
 鼠标控制 左　键 控制基本的行动：行走、攻击拾取物品和其他东西
右　键 近处的点击能够看到物品使用方法，远处的点击能够在地图上跑动。
Shift + 左键 强制攻击
Ctrl + 左键 跑动
Ctrl + 右键 关于对手的信息，如同F10一样。
Alt + 右键 取得肉或者其他玩家因为死亡丢失的东西。
双　击 拾取在地上的物品或者使用自己包裹中的物品。
}

procedure TfrmMain.ProcessActionMessages;
var
  mx, my, dx, dy, crun, stdcount: Integer;
  ndir, adir, mdir: Byte;
  bowalk, bostop: Boolean;
  //I: Integer;
label
  LB_WALK, LB_RUN;
begin
  if g_MySelf = nil then Exit;
  //Move
  if (g_nTargetX >= 0) and CanNextAction and ServerAcceptNextAction then begin
    if (g_nTargetX <> g_MySelf.m_nCurrX) or (g_nTargetY <> g_MySelf.m_nCurrY) then begin
      //   TTTT:
      mx := g_MySelf.m_nCurrX;
      my := g_MySelf.m_nCurrY;
      dx := g_nTargetX;
      dy := g_nTargetY;
      ndir := GetNextDirection(mx, my, dx, dy);
      case g_ChrAction of
        caWalk: begin
            LB_WALK:
            {
            DScreen.AddSysMsg ('caWalk ' + IntToStr(Myself.XX) + ' ' +
                                           IntToStr(Myself.m_nCurrY) + ' ' +
                                           IntToStr(TargetX) + ' ' +
                                           IntToStr(TargetY));
                                           }
            crun := g_MySelf.CanWalk;
            if IsUnLockAction(CM_WALK, ndir) and (crun > 0) then begin
              GetNextPosXY(ndir, mx, my);
              bowalk := True;
              bostop := False;
              if not PlayScene.CanWalk(mx, my) then begin
                bowalk := False;
                adir := 0;
                if not bowalk then begin
                  mx := g_MySelf.m_nCurrX;
                  my := g_MySelf.m_nCurrY;
                  GetNextPosXY(ndir, mx, my);
                  if CheckDoorAction(mx, my) then
                    bostop := True;
                end;
                if not bostop and not PlayScene.CrashMan(mx, my) then begin
                  mx := g_MySelf.m_nCurrX;
                  my := g_MySelf.m_nCurrY;
                  adir := PrivDir(ndir);
                  GetNextPosXY(adir, mx, my);
                  if not Map.CanMove(mx, my) then begin
                    mx := g_MySelf.m_nCurrX;
                    my := g_MySelf.m_nCurrY;
                    adir := NextDir(ndir);
                    GetNextPosXY(adir, mx, my);
                    if Map.CanMove(mx, my) then bowalk := True;
                  end else bowalk := True;
                end;
                if bowalk then begin
                  g_MySelf.UpdateMsg(CM_WALK, mx, my, adir, 0, 0, '', 0);
                  g_dwLastMoveTick := GetTickCount;
                end else begin
                  mdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, dx, dy);
                  if mdir <> g_MySelf.m_btDir then
                    g_MySelf.SendMsg(CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, 0, 0, '', 0);
                  g_nTargetX := -1;
                end;
              end else begin
                g_MySelf.UpdateMsg(CM_WALK, mx, my, ndir, 0, 0, '', 0);
                g_dwLastMoveTick := GetTickCount;
              end;
            end else begin
              g_nTargetX := -1;
            end;
          end;
        caRun: begin
            // New Running Method
            LB_RUN:
            stdcount := 1;
            if (g_MySelf.m_nState and $00100000) <> 0 then
                  stdcount := 0;
            if g_nRunReadyCount >= stdcount then begin
            crun := g_MySelf.CanRun;
            if (GetDistance(mx, my, dx, dy) >= 2) and (crun > 0) then begin
              if IsUnLockAction(CM_RUN, ndir) then begin
                GetNextRunXY(ndir, mx, my);
                if PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my) then begin
                  g_MySelf.UpdateMsg(CM_RUN, mx, my, ndir, 0, 0, '', 0);
                  g_dwLastMoveTick := GetTickCount;
                end else begin
                  mx := g_MySelf.m_nCurrX;
                  my := g_MySelf.m_nCurrY;
                  goto LB_WALK;
                end;
              end else g_nTargetX := -1;
            end else begin
              goto LB_WALK;
            end;
            end else begin
              Inc (g_nRunReadyCount);
              goto LB_WALK;
              end;
            end;
        caHorseRun: begin
            crun := g_MySelf.CanRun;
            if (GetDistance(mx, my, dx, dy) >= 3) and (crun > 0) then begin
              if IsUnLockAction(CM_RUN, ndir) then begin
                GetNextHorseRunXY(ndir, mx, my);
                bowalk := True;
                bostop := False;
                if not PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my) then begin
                  bowalk := False;
                  mdir := 0;
                  if not bowalk then begin
                    mx := g_MySelf.m_nCurrX;
                    my := g_MySelf.m_nCurrY;
                    GetNextHorseRunXY(ndir, mx, my);
                    if CheckDoorAction(mx, my) then
                      bostop := True;
                  end;
                  if not bostop then begin
                    mx := g_MySelf.m_nCurrX;
                    my := g_MySelf.m_nCurrY;
                    GetNextRunXY(ndir, mx, my);
                    if PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my) then begin
                      mx := g_MySelf.m_nCurrX;
                      my := g_MySelf.m_nCurrY;
                      goto LB_RUN;
                    end else begin
                      if CheckDoorAction(mx, my) then begin
                        mx := g_MySelf.m_nCurrX;
                        my := g_MySelf.m_nCurrY;
                        goto LB_RUN;
                      end else begin
                        mx := g_MySelf.m_nCurrX;
                        my := g_MySelf.m_nCurrY;
                        goto LB_WALK;
                      end;
                    end;
                  end else begin
                    mx := g_MySelf.m_nCurrX;
                    my := g_MySelf.m_nCurrY;
                    GetNextHorseRunXY(ndir, mx, my);
                    g_MySelf.UpdateMsg(CM_HORSERUN, mx, my, ndir, 0, 0, '', 0);
                    g_dwLastMoveTick := GetTickCount;
                  end;
                end else begin
                  g_MySelf.UpdateMsg(CM_HORSERUN, mx, my, ndir, 0, 0, '', 0);
                  g_dwLastMoveTick := GetTickCount;
                end;
              end else g_nTargetX := -1;
            end else begin
              if (GetDistance(mx, my, dx, dy) >= 2) and (crun > 0) then begin
                goto LB_RUN;
              end else begin
                goto LB_WALK;
              end;
            end;
          end;
      end;
    end;
  end;
  g_nTargetX := -1;
  if g_MySelf.RealActionMsg.ident > 0 then begin
    FailAction := g_MySelf.RealActionMsg.ident;
    FailDir := g_MySelf.RealActionMsg.dir;
    if g_MySelf.RealActionMsg.ident = CM_SPELL then begin
      SendSpellMsg(g_MySelf.RealActionMsg.ident,
        g_MySelf.RealActionMsg.X,
        g_MySelf.RealActionMsg.Y,
        g_MySelf.RealActionMsg.dir,
        g_MySelf.RealActionMsg.State);
    end else begin
      SendActMsg(g_MySelf.RealActionMsg.ident,
        g_MySelf.RealActionMsg.X,
        g_MySelf.RealActionMsg.Y,
        g_MySelf.RealActionMsg.dir);
    end;
    g_MySelf.RealActionMsg.ident := 0;
    if g_nMDlgX <> -1 then begin
      if (abs(g_nMDlgX - g_MySelf.m_nCurrX) >= 8) or (abs(g_nMDlgY - g_MySelf.m_nCurrY) >= 8) then begin
        FrmDlg.CloseMDlg;
        FrmDlg.CloseBigMDlg;
        FrmDlg.DBook.Visible := False;
        g_nMDlgX := -1;
      end;
    end;
  end;
end;

procedure TakeOnItem(nType, nCount: Integer);
var
  I: Integer;
  sName: string;
begin
  if g_WaitingUseItem.Item.S.Name = '' then begin
    for I := Low(g_ItemArr) to High(g_ItemArr) do begin
    {DScreen.AddChatBoardString('g_ItemArr[I].S.StdMode ' + IntTostr(g_ItemArr[I].S.StdMode), clyellow, clRed);
    DScreen.AddChatBoardString('g_ItemArr[I].S.Shape ' + IntTostr(g_ItemArr[I].S.Shape), clyellow, clRed);
    DScreen.AddChatBoardString('Round(g_UseItems[I].Dura / 100) ' + IntTostr(Round(g_UseItems[I].Dura / 100)), clyellow, clRed);}
      if (g_ItemArr[I].S.Name <> '') and (g_ItemArr[I].S.StdMode = 25) and (g_ItemArr[I].S.Shape = nType) and (Round(g_ItemArr[I].Dura / 100) >= nCount) then begin
        g_WaitingUseItem.Item := g_ItemArr[I];
        g_WaitingUseItem.Index := U_BUJUK;
        g_ItemArr[I].S.Name := '';
        sName := g_WaitingUseItem.Item.S.Name;
        frmMain.SendTakeOnItem(U_BUJUK, g_WaitingUseItem.Item.MakeIndex, sName);
      //DScreen.AddChatBoardString('TakeOnItem ' + sName, clyellow, clRed);
        Break;
      end;
    end;
  end;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Msg, wc, dir, mx, my, nKey, I: Integer;
  ini: TIniFile;
  nCount: Integer;
  Magic: PTClientMagic;
  dwSpellTime: LongWord;
  target: TActor;
  AShift: TShiftState;
  PickupList: TList;
  DropItem: pTDropItem;
  ShowItem: pTShowItem;
begin
  if not CanDraw then Exit;
  case Key of
    //VK_HOME, VK_MULTIPLY, VK_F12:DScreen.AddChatBoardString (IntToStr(Key), clBlue, clWhite);//Showmessage(IntToStr(Key));
    VK_PAUSE: begin
        Key := 0;
        PrintScreenNow();
      end;
    VK_RETURN: begin
        if (ssAlt in Shift) and (Key = VK_RETURN) then begin
          DXDraw.Finalize;

          if doFullScreen in DXDraw.Options then begin
            RestoreWindow;

            //DXDraw.Cursor := crDefault;
            BorderStyle := bsSingle; //bsSizeable;//
            DXDraw.Options := DXDraw.Options - [doFullScreen];
          end else begin
            StoreWindow;

            //DXDraw.Cursor := crNone;
            BorderStyle := bsNone;
            DXDraw.Options := DXDraw.Options + [doFullScreen];
          end;
          g_boFullScreen := doFullScreen in DXDraw.Options;
          DXDraw.Initialize;
          Exit;
        end;
      end;
  end;

  if DWinMan.KeyDown(Key, Shift) then Exit;

  if (g_MySelf = nil) or (DScreen.CurrentScene <> PlayScene) then Exit;

  if Assigned(g_PlugInfo.HookKeyDown) then begin
    if g_PlugInfo.HookKeyDown(Key, Shift) then Exit;
  end;

  mx := g_MySelf.m_nCurrX;
  my := g_MySelf.m_nCurrY;

  case Key of
    VK_HOME, {VK_MULTIPLY,} VK_F12: begin
        FrmDlg.DOptionClick();
      end;
  end;

  if g_Config.boUseHotkey then begin
    if (g_Config.nSerieSkill <> 0) then begin
      nKey := GetInputKey(g_Config.nSerieSkill, AShift);
      if (nKey = Key) and (AShift = Shift) then begin
        StartSerieMagic();
        //DScreen.AddChatBoardString('StartSerieMagic();', clyellow, clRed);
        Key := 0;
      end;
    end;

    if (g_Config.nHeroSetAttackState <> 0) then begin
      nKey := GetInputKey(g_Config.nHeroSetAttackState, AShift);
      if (nKey = Key) and (AShift = Shift) then begin
        if (g_MyHero <> nil) and (not g_MyHero.m_boDeath) then g_MyHero.Rest;
        Key := 0;
      end;
    end;
    if g_Config.nHeroCallHero <> 0 then begin
      nKey := GetInputKey(g_Config.nHeroCallHero, AShift);
      if (nKey = Key) and (AShift = Shift) then begin
        if g_MyHero = nil then begin
          frmMain.SendClientMessage(CM_HEROLOGON, 0, 0, 0, 0);
        end else begin
          frmMain.SendClientMessage(CM_HEROLOGOUT, g_MyHero.m_nRecogId, 0, 0, 0);
        end;
        Key := 0;
      end;
    end;
    if g_Config.nHeroSetTarget <> 0 then begin
      nKey := GetInputKey(g_Config.nHeroSetTarget, AShift);
      if (nKey = Key) and (AShift = Shift) then begin
        if (g_MyHero <> nil) and (not g_MyHero.m_boDeath) then g_MyHero.target;
        Key := 0;
      end;
    end;
    if g_Config.nHeroUnionHit <> 0 then begin
      nKey := GetInputKey(g_Config.nHeroUnionHit, AShift);
      if (nKey = Key) and (AShift = Shift) then begin
        if (g_MyHero <> nil) and (not g_MyHero.m_boDeath) then g_MyHero.GroupAttack;
        Key := 0;
      end;
    end;
    if g_Config.nHeroSetGuard <> 0 then begin
      nKey := GetInputKey(g_Config.nHeroSetGuard, AShift);
      if (nKey = Key) and (AShift = Shift) then begin
        if (g_MyHero <> nil) and (not g_MyHero.m_boDeath) then g_MyHero.Protect;
        Key := 0;
      end;
    end;
    if g_Config.nSwitchAttackMode <> 0 then begin
      nKey := GetInputKey(g_Config.nSwitchAttackMode, AShift);
      if (nKey = Key) and (AShift = Shift) then begin
        SendSay('@AttackMode');
        Key := 0;
      end;
    end;
    if g_Config.nSwitchMiniMap <> 0 then begin
      nKey := GetInputKey(g_Config.nSwitchMiniMap, AShift);
      if (nKey = Key) and (AShift = Shift) then begin
        //if not PlayScene.EdChat.Visible then begin
        if not g_boViewMiniMap then begin
          if GetTickCount > g_dwQueryMsgTick then begin
            g_dwQueryMsgTick := GetTickCount + 3000;
            frmMain.SendWantMiniMap;
            g_nViewMinMapLv := 1;
          end;
        end else begin
          if g_nViewMinMapLv >= 3 then begin
            g_nViewMinMapLv := 0;
            g_boViewMiniMap := False;
          end else Inc(g_nViewMinMapLv);
        end;
        FrmDlg.DMiniMap.Visible := g_boViewMiniMap;
        if not FrmDlg.DMiniMap.Visible then begin
          FrmDlg.DMiniMap.Width := FrmDlg.DMapTitle.Width;
          FrmDlg.DMiniMap.Height := 120;
        end;
        //end;
        Key := 0;
      end;
    end;
  end;

  case Key of
    VK_F1, VK_F2, VK_F3, VK_F4,
      VK_F5, VK_F6, VK_F7, VK_F8: begin
        if g_ServerConfig.boChgSpeed then begin
          //dwSpellTime := g_Config.dwSpellTime;
          dwSpellTime := 500 - Trunc((g_MySelf.m_Abil.AttackSpeed * 500) / 100);
        end else begin
          dwSpellTime := 500;
        end;
        if (GetTickCount - g_dwLatestSpellTick > (dwSpellTime {500} + g_dwMagicDelayTime)) and (ActionKey = 0) then begin
        //if (GetTickCount - g_dwLatestSpellTick > (g_dwMagicDelayTime)) then begin
          if ssCtrl in Shift then begin
            ActionKey := Key - 100;
          end else begin
            ActionKey := Key;
          end;
          Magic := nil;
          case ActionKey of
            VK_F1, VK_F2, VK_F3, VK_F4, VK_F5, VK_F6, VK_F7, VK_F8: begin
                Magic := GetMagicByKey(Char((ActionKey - VK_F1) + Byte('1')));
              end;
            12..19: begin
                Magic := GetMagicByKey(Char((ActionKey - 12) + Byte('1') + Byte($14)));
              end;
          end;

          if Magic <> nil then begin
            if not IsWarrSkill(Magic.Def.wMagicId) then begin
              if (g_MySelf.m_btHorse > 0) and g_Config.boAutoHorse then SendOnHorse();
            end;
          end;

          if g_MySelf.m_btJob = 2 then begin //毒符互换
            if Magic <> nil then begin
          {if Config.boUseSpellOffHoser then begin
            if not IsWarrSkill(Magic.Def.wMagicId) then begin
              if g_PlugInfo.Actor_btHorse(m_MySelf)^ > 0 then begin
                SendClientMessage(5059, 0, 0, 0, 0);
              end;
            end;
          end;}

              if g_Config.boChangeSign and (g_WaitingUseItem.Item.S.Name = '') then begin
                case Magic.Def.wMagicId of //自动换毒
                  6, 38: begin
                      if g_Config.boChangePoison then begin
                        if g_nPoisonIndex < 0 then g_nPoisonIndex := g_Config.nPoisonIndex + 1;
                        if (g_UseItems[U_BUJUK].S.Name = '') or (g_UseItems[U_BUJUK].S.StdMode <> 25) or (g_UseItems[U_BUJUK].S.Shape <> g_nPoisonIndex) then begin
                          TakeOnItem(g_nPoisonIndex, 1);
                          Inc(g_nPoisonIndex);
                          if g_nPoisonIndex > 2 then g_nPoisonIndex := 1;
                      //g_dwProcessKeyTick := GetTickCount;
              //DScreen.AddChatBoardString('AutoChgItemType3' , clyellow, clRed);
                        end;
                      end else begin
                        g_nPoisonIndex := g_Config.nPoisonIndex + 1;
                        if (g_UseItems[U_BUJUK].S.Name = '') or (g_UseItems[U_BUJUK].S.StdMode <> 25) or (g_UseItems[U_BUJUK].S.Shape <> g_nPoisonIndex) then begin
                          TakeOnItem(g_nPoisonIndex, 1);
                      //g_dwProcessKeyTick := GetTickCount;
                        end;
                      end;
                    end;
                  13, 14, 15, 16, 17, 18, 19, 30, 57, 72, 76: begin //自动换符
                      nCount := 1;
                      if (Magic.Def.wMagicId = 30) or (Magic.Def.wMagicId = 72) then nCount := 5;
                      if (g_UseItems[U_BUJUK].S.Name = '') or (g_UseItems[U_BUJUK].S.StdMode <> 25) or (g_UseItems[U_BUJUK].S.Shape <> 5) then begin
                        TakeOnItem(5, nCount);
                    //g_dwProcessKeyTick := GetTickCount;
                      end else begin
                        if (Round(g_UseItems[U_BUJUK].Dura / 100) < nCount) then begin
                          TakeOnItem(5, nCount);
                      //g_dwProcessKeyTick := GetTickCount;
                        end;
                      end;
                    end;
                  52: begin //自动换符 诅咒术
                      if (g_UseItems[U_BUJUK].S.Name = '') or (g_UseItems[U_BUJUK].S.StdMode <> 25) or (g_UseItems[U_BUJUK].S.Shape <> 3) then begin
                        TakeOnItem(3, 3);
                    //g_dwProcessKeyTick := GetTickCount;
                      end else begin
                        if (Round(g_UseItems[U_BUJUK].Dura / 100) < 3) then begin
                          TakeOnItem(3, 3);
                      //g_dwProcessKeyTick := GetTickCount;
                        end;
                      end;
                    end;
                end;
              end;
            end;
          end;
        end;
        Key := 0;
      end;


    {
    快捷键 F10 打开/关闭角色窗口
    F9 打开/关闭包裹窗口
    F11 打开/关闭角色能力窗口
    Pause Break 在游戏中截图，截图将以IMAGE格式自动保存在MIR的目录下。
    F1, F2, F3, F4, F5, F6, F7, F8 由玩家自己设置的快捷键，这些魔法技能的快捷键设置可以加快游戏的操作性和流畅性，比如对火球，治愈等魔法的设置。
    }
    VK_F9: begin
        FrmDlg.OpenItemBag;
        Key := 0;
      end;
    VK_F10: begin
        FrmDlg.StatePage := 0;
        FrmDlg.OpenMyStatus;
        Key := 0;
      end;
    VK_F11: begin
        FrmDlg.StatePage := 3;
        FrmDlg.OpenMyStatus;
        Key := 0;
      end;

    {
    Ctrl + H 选择自己喜欢的攻击模式
    和平攻击模式：除了对暴民以外其他攻击都无效。
    行会联盟攻击模式：对自己行会内的其他玩家攻击无效
    编组攻击模式：处于同一小组的玩家攻击无效
    全体攻击模式：对所有的玩家和暴民都具有攻击效果。
    善恶攻击模式：PK红名专用攻击模式。
     }
    Word('H'): begin
        if ssCtrl in Shift then begin
          SendSay('@AttackMode');
          Key := 0;
        end;
      end;
    Word('A'): begin
        if ssCtrl in Shift then begin
          SendSay('@Rest');
          Key := 0;
        end;
      end;
    Word('D'): begin
        if ssAlt in Shift then begin
          SendPassword('', 0);
          Key := 0;
          {
          SetInputStatus();

          if m_boPasswordIntputStatus then
            DScreen.AddChatBoardString ('请输入密码：', clBlue, clWhite);
          }
        end else
          if ssCtrl in Shift then begin
          StartSerieMagic();
        end;
      end;
    Word('E'): begin //英雄状态更改
        if ssCtrl in Shift then begin
          if g_MyHero = nil then Exit;
          g_MyHero.Rest;
          Key := 0;
        end;
      end;
    Word('W'): begin //英雄攻击指定目标
        if ssCtrl in Shift then begin
          if g_MyHero = nil then Exit;
          g_MyHero.target;
          Key := 0;
        end;
      end;

    Word('Q'): begin //英雄守护
        if ssCtrl in Shift then begin
          if g_MyHero = nil then Exit;
          g_MyHero.Protect;
          Key := 0;
        end else begin
          if g_MySelf = nil then Exit;
          if ssAlt in Shift then begin
          //强行退出
            g_dwLatestStruckTick := GetTickCount() + 10001;
            g_dwLatestMagicTick := GetTickCount() + 10001;
            g_dwLatestHitTick := GetTickCount() + 10001;
          //
            if (GetTickCount - g_dwLatestStruckTick > 10000) and
              (GetTickCount - g_dwLatestMagicTick > 10000) and
              (GetTickCount - g_dwLatestHitTick > 10000) or
              (g_MySelf.m_boDeath) then begin
              AppExit;
            end else DScreen.AddChatBoardString('You cannot leave the Battle?..', clyellow, clRed);
          end;
        end;
      end;
    Word('B'): begin //英雄挂机
        if ssCtrl in Shift then begin
          if (g_MyHero <> nil) and not g_MyHero.m_boDeath then begin
            //SendHeroAutoAttack();
            Key := 0;
          end;
        end;
      end;
    Word('S'): begin //英雄合击
        if ssCtrl in Shift then begin
          if (g_MyHero <> nil) and (not g_MyHero.m_boDeath) then g_MyHero.GroupAttack;
        end;
      end;
    {VK_HOME, VK_F12, VK_MULTIPLY: begin //打开外挂
        FrmDlg.DOptionClick();
      end; }
    {
    word('D'): begin
      if ssCtrl in Shift then begin
        FrmDlg.DChgGamePwd.Visible:=not FrmDlg.DChgGamePwd.Visible;
      end;
    end;
    }
{
Ctrl + F 改版游戏的字体，你可以选择8种不同的字体
}
    Word('F'): begin
        if ssCtrl in Shift then begin
          if g_nCurFont < MAXFONT - 1 then Inc(g_nCurFont)
          else g_nCurFont := 0;
          g_sCurFontName := g_FontArr[g_nCurFont];
          DXDraw.Surface.Canvas.Font.Name := g_sCurFontName;
          FrmDlg.EdChat.Font.Name := g_sCurFontName;
          frmMain.Font.Name := g_sCurFontName;
          frmMain.Canvas.Font.Name := g_sCurFontName;
          Key := 0;
        end;
      end;
    Word('Z'): begin
        if ssCtrl in Shift then begin
          g_boShowAllItem := not g_boShowAllItem;
        end else
          //if CanNextAction and ServerAcceptNextAction then begin
          SendPickup; //捡物品
          //end;
        Key := 0;
      end;
    {
    Alt + X 重新开始游戏（当角色死亡后特别有用）
    }
    Word('R'): begin
        if ssAlt in Shift then begin //刷新包裹
          case g_QueryBagItem of
            q_QueryHum: begin
                if g_MyHero <> nil then
                  g_QueryBagItem := q_QueryHero;
                if g_MySelf <> nil then begin
                  g_boQueryHumBagItem := True;
                  SendClientMessage(CM_QUERYBAGITEMS, 0, 0, 0, 0);
                  DScreen.AddChatBoardString('Reloading Bag.', clWhite, clFuchsia);
                end;
              end;
            q_QueryHero: begin
                if g_MyHero <> nil then begin
                  g_QueryBagItem := q_QueryHum;
                  g_boQueryHeroBagItem := True;
                  SendClientMessage(CM_QUERYHEROBAGITEMS, 0, 0, 0, 0);
                  DScreen.AddChatBoardString('Reloading Hero Bag.', clWhite, clFuchsia);
                end else begin
                  g_QueryBagItem := q_QueryHum;
                  if g_MySelf <> nil then begin
                    g_boQueryHumBagItem := True;
                    SendClientMessage(CM_QUERYBAGITEMS, 0, 0, 0, 0);
                    DScreen.AddChatBoardString('Reloading Bag.', clWhite, clFuchsia);
                  end;
                end;
              end;
          end;
          Key := 0;
        end;
      end;
    Word('X'): begin
        if g_MySelf = nil then Exit;
        if ssAlt in Shift then begin
          //强行退出
          g_dwLatestStruckTick := GetTickCount() + 10001;
          g_dwLatestMagicTick := GetTickCount() + 10001;
          g_dwLatestHitTick := GetTickCount() + 10001;
          //
          if (GetTickCount - g_dwLatestStruckTick > 10000) and
            (GetTickCount - g_dwLatestMagicTick > 10000) and
            (GetTickCount - g_dwLatestHitTick > 10000) or
            (g_MySelf.m_boDeath) then begin
            AppLogout;
          end else DScreen.AddChatBoardString('You cannot leave the Battle?.', clyellow, clRed);
        end;
      end;
    {Word('Q'): begin
        if g_MySelf = nil then Exit;
        if ssAlt in Shift then begin
          //强行退出
          g_dwLatestStruckTick := GetTickCount() + 10001;
          g_dwLatestMagicTick := GetTickCount() + 10001;
          g_dwLatestHitTick := GetTickCount() + 10001;
          //
          if (GetTickCount - g_dwLatestStruckTick > 10000) and
            (GetTickCount - g_dwLatestMagicTick > 10000) and
            (GetTickCount - g_dwLatestHitTick > 10000) or
            (g_MySelf.m_boDeath) then begin
            AppExit;
          end else
            DScreen.AddChatBoardString('你目前正在战斗中不能离开..', clYellow, clRed);
        end;
      end;}
    Word('V'): begin
        if not g_boViewMiniMap then begin
          if GetTickCount > g_dwQueryMsgTick then begin
            g_dwQueryMsgTick := GetTickCount + 3000;
            frmMain.SendWantMiniMap;
            g_nViewMinMapLv := 1;
          end;
        end else begin
          if g_nViewMinMapLv >= 3 then begin
            g_nViewMinMapLv := 0;
            g_boViewMiniMap := False;
          end else Inc(g_nViewMinMapLv);
        end;
        FrmDlg.DMiniMap.Visible := g_boViewMiniMap;
        if not FrmDlg.DMiniMap.Visible then begin
          FrmDlg.DMiniMap.Width := FrmDlg.DMapTitle.Width;
          FrmDlg.DMiniMap.Height := 120;
        end;
        Key := 0;
      end;
    VK_TAB: begin
        // Pickup item if standing over it.
        SendPickup;
      end;
    Word('T'): begin
        if GetTickCount > g_dwQueryMsgTick then begin
          g_dwQueryMsgTick := GetTickCount + 3000;
          frmMain.SendDealTry;
          Key := 0;
        end;
      end;
    Word('G'): begin
        if ssCtrl in Shift then begin
          if g_FocusCret <> nil then
            if g_GroupMembers.Count = 0 then
              SendCreateGroup(g_FocusCret.m_sUserName)
            else SendAddGroupMember(g_FocusCret.m_sUserName);
          FrmDlg.EdChat.Text := g_FocusCret.m_sUserName;
        end else begin
          if ssAlt in Shift then begin
            if g_FocusCret <> nil then
              SendDelGroupMember(g_FocusCret.m_sUserName)
          end else begin
            if FrmDlg.DGuildDlg.Visible then begin
              FrmDlg.DGuildDlg.Visible := False;
            end else
              if GetTickCount > g_dwQueryMsgTick then begin
              g_dwQueryMsgTick := GetTickCount + 3000;
              frmMain.SendGuildDlg;
            end;
          end;
        end;
        Key := 0;
      end;
    Word('P'): begin
        if ssAlt in Shift then begin
          if Assigned(g_PlugInfo.MediaPlayer.Player) then begin
            g_PlugInfo.MediaPlayer.Player(nil, True, False);
          end;
        end else begin
          FrmDlg.ToggleShowGroupDlg;
        end;
        Key := 0;
      end;

    Word('C'): begin
        FrmDlg.StatePage := 0;
        FrmDlg.OpenMyStatus;
        Key := 0;
      end;

    Word('I'): begin
        FrmDlg.OpenItemBag;
        Key := 0;
      end;


    Word('M'): begin //骑马
        if ssCtrl in Shift then begin
          SendOnHorse();
        end else begin
          FrmDlg.OpenAdjustAbility;
        end;
        Key := 0;
      end;
    //Word('L'): begin //挂机
        //if ssCtrl in Shift then begin
          //g_GuaJi.Started := not g_GuaJi.Started;
          {if g_GuaJi.Started then begin
            DScreen.AddChatBoardString('开始挂机 Ctrl + L..', clYellow, clRed);
          end else begin
            DScreen.AddChatBoardString('停止挂机 Ctrl + L..', clYellow, clRed);
          end; }
        //end;
      //end;
  end;

  with FrmDlg.DScrollChat do begin
    case Key of
      VK_UP: Previous;
      VK_DOWN: Next;
      VK_PRIOR: Position := Position - Increment * 9;
      VK_NEXT: Position := Position + Increment * 9;
    end;
  end;
end;

procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if not CanDraw then Exit;
  if DWinMan.KeyPress(Key) then Exit;

  if Assigned(g_PlugInfo.HookKeyPress) then begin
    if g_PlugInfo.HookKeyPress(Key) then Exit;
  end;

  if DScreen.CurrentScene = PlayScene then begin
    case Byte(Key) of
      Byte('1')..Byte('6'): begin
          EatItem(Byte(Key) - Byte('1')); //吃药
        end;

      //if not FrmDlg.EdChat.Visible then begin
      Byte(' '), 13: begin
          if FrmDlg.EdChat.Visible and (not FrmDlg.EdChat.Focused) then begin
            FrmDlg.EdChat.SetFocus;
            Exit;
          end;
          FrmDlg.SetInputVisible(g_ConfigClient.btMainInterface = 1);
          FrmDlg.EdChat.Visible := True;
          FrmDlg.EdChat.SetFocus;
          SetImeMode(FrmDlg.EdChat.Handle, LocalLanguage);
          if FrmDlg.BoGuildChat then begin
            FrmDlg.EdChat.Text := '!~';
            FrmDlg.EdChat.SelStart := Length(FrmDlg.EdChat.Text);
            FrmDlg.EdChat.SelLength := 0;
          end else begin
            FrmDlg.EdChat.Text := '';
          end;
        end;
      Byte('@'),
        Byte('!'),
        Byte('/'): begin
          FrmDlg.SetInputVisible(g_ConfigClient.btMainInterface = 1);
          FrmDlg.EdChat.Visible := True;
          FrmDlg.EdChat.SetFocus;
          SetImeMode(FrmDlg.EdChat.Handle, LocalLanguage);
          if Key = '/' then begin
            if WhisperName = '' then FrmDlg.EdChat.Text := Key
            else if Length(WhisperName) > 2 then FrmDlg.EdChat.Text := '/' + WhisperName + ' '
            else FrmDlg.EdChat.Text := Key;
            FrmDlg.EdChat.SelStart := Length(FrmDlg.EdChat.Text);
            FrmDlg.EdChat.SelLength := 0;
          end else begin
            FrmDlg.EdChat.Text := Key;
            FrmDlg.EdChat.SelStart := 1;
            FrmDlg.EdChat.SelLength := 0;
          end;
        end;
     // end;
      //Key := #0;
    end;
  end;
end;

function TfrmMain.GetMagicByKey(Key: Char): PTClientMagic;
var
  I: Integer;
  pm: PTClientMagic;
begin
  Result := nil;
  for I := 0 to g_MagicList.Count - 1 do begin
    pm := PTClientMagic(g_MagicList[I]);
    if pm.Key = Key then begin
      Result := pm;
      Break;
    end;
  end;
end;

function TfrmMain.FindSerieMagic(wMagicId: Word): PTClientMagic;
var
  I: Integer;
  pm: PTClientMagic;
begin
  Result := nil;
  for I := 0 to g_SerieMagicList.Count - 1 do begin
    pm := PTClientMagic(g_SerieMagicList[I]);
    if pm.Def.wMagicId = wMagicId then begin
      Result := pm;
      Break;
    end;
  end;
end;

function TfrmMain.FindMagic(wMagicId: Word): PTClientMagic;
var
  I: Integer;
  pm: PTClientMagic;
begin
  Result := nil;
  for I := 0 to g_MagicList.Count - 1 do begin
    pm := PTClientMagic(g_MagicList[I]);
    if pm.Def.wMagicId = wMagicId then begin
      Result := pm;
      Break;
    end;
  end;
end;

function TfrmMain.GetHeroUseMagic(wMagicId: Integer): PTClientMagic;
var
  I: Integer;
  pm: PTClientMagic;
begin
  Result := nil;
  for I := 0 to g_HeroMagicList.Count - 1 do begin
    pm := PTClientMagic(g_HeroMagicList[I]);
    if pm.Def.wMagicId = wMagicId then begin
      Result := pm;
      Break;
    end;
  end;
end;

procedure TfrmMain.UseMagic(tx, ty: Integer; pcm: PTClientMagic);
var
  tdir, targx, targy, targid: Integer;
  pmag: PTUseMagicInfo;
  OldMagicTarget: TActor;
  dwSpellTime: LongWord;
  nCount: Integer;
begin
  if (pcm = nil) or g_MySelf.m_boStartStore then Exit;
  if (g_NewStatus > sNone) then Exit; //骑马不允许使用魔法

  //是否可以使用魔法：需要的点数<当前点数，或者是魔法EffectType = 0
  if (pcm.Def.wSpell + pcm.Def.btDefSpell <= g_MySelf.m_Abil.MP) or (pcm.Def.btEffectType = 0) then begin
    if (pcm.Def.btEffectType = 0) { and (pcm.Def.wMagicId <> 60) } then begin
      //if pcm.Def.wMagicId in [3, 7] then Exit;
      if pcm.Def.wMagicId = 26 then begin //烈火
        if GetTickCount - g_dwLatestFireHitTick < g_ServerConfig.nFireDelayTime then begin
          Exit;
        end;
        g_dwAutoFireTick := GetTickCount;
      end;
      if pcm.Def.wMagicId = 43 then begin //开天斩
        if GetTickCount - g_dwLatestKTZHitTick < g_ServerConfig.nKTZDelayTime then begin
          Exit;
        end;
        g_dwAutoKTZTick := GetTickCount;
      end;
      if pcm.Def.wMagicId = 43 then begin //破空剑
        if GetTickCount - g_dwLatestPKJHitTick < g_ServerConfig.nPKJDelayTime then begin
          Exit;
        end;
        g_dwAutoPKJTick := GetTickCount;
      end;
      if pcm.Def.wMagicId = 77 then begin //逐日剑法
        if GetTickCount - g_dwLatestZRJFHitTick < g_ServerConfig.nZRJFDelayTime then begin
          Exit;
        end;
        g_dwAutoZRJFTick := GetTickCount;
      end;
      if pcm.Def.wMagicId = 27 then begin //野蛮冲撞
        if GetTickCount - g_dwLatestRushRushTick < 3 * 1000 then begin
          Exit;
        end;
      end;
      if g_ServerConfig.boChgSpeed then begin
        //dwSpellTime := g_Config.dwSpellTime;
        dwSpellTime := 500 - Trunc((g_MySelf.m_Abil.AttackSpeed * 500) / 100);
      end else begin
        dwSpellTime := 500;
      end;

      if GetTickCount - g_dwLatestSpellTick > dwSpellTime {500} then begin
        g_dwLatestSpellTick := GetTickCount;
        g_dwMagicDelayTime := 0; //pcm.Def.DelayTime;
        SendSpellMsg(CM_SPELL, g_MySelf.m_btDir {x}, 0, pcm.Def.wMagicId, 0);
      end;
    end else begin
      if (g_MySelf.m_btHorse > 0) or (g_NewStatus > sNone) then Exit;

      tdir := GetFlyDirection(390, 175, tx, ty);

      //魔法锁定
      if (pcm.Def.wMagicId = 2)
        or (pcm.Def.wMagicId = 14)
        or (pcm.Def.wMagicId = 15)
        or (pcm.Def.wMagicId = 19) or (pcm.Def.wMagicId in [60..65]) then begin
        g_MagicTarget := g_FocusCret;
      end else begin
        if g_Config.boMagicLock then begin
          if PlayScene.IsValidActor(g_MagicLockActor) then begin
            if g_MagicLockActor.m_boDeath then g_MagicLockActor := nil;
          end else g_MagicLockActor := nil;
        end;
        if not g_Config.boMagicLock or (PlayScene.IsValidActor(g_FocusCret) and (not g_FocusCret.m_boDeath)) or (g_MagicLockActor = nil) then begin
          g_MagicLockActor := g_FocusCret;
        end;
        g_MagicTarget := g_MagicLockActor;
      end;

      if pcm.Def.wMagicId = 22 then g_MagicTarget := nil;
      if not PlayScene.IsValidActor(g_MagicTarget) then
        g_MagicTarget := nil;

      if g_MagicTarget = nil then begin
        PlayScene.CXYfromMouseXY(tx, ty, targx, targy);
        targid := 0;
      end else begin
        targx := g_MagicTarget.m_nCurrX;
        targy := g_MagicTarget.m_nCurrY;
        targid := g_MagicTarget.m_nRecogId;
      end;

      if CanNextAction and ServerAcceptNextAction then begin
        g_dwLatestSpellTick := GetTickCount;
        New(pmag);
        SafeFillChar(pmag^, SizeOf(TUseMagicInfo), #0);
        pmag.EffectNumber := pcm.Def.btEffect;
        pmag.MagicSerial := pcm.Def.wMagicId;
        pmag.MagicFire := False;
        pmag.ServerMagicCode := 0;
        g_dwMagicDelayTime := 200 + pcm.Def.dwDelayTime;

        if g_ServerConfig.boChgSpeed then begin
          //g_dwMagicDelayTime := Round(g_dwMagicDelayTime / _MAX(1, 1));
          g_dwMagicDelayTime := g_dwMagicDelayTime - Trunc((g_MySelf.m_Abil.AttackSpeed * g_dwMagicDelayTime) / 100);
          {
          case g_Config.dwSpellTime of
            500: g_dwMagicDelayTime := Round(g_dwMagicDelayTime / _MAX(1, 1));
            400: g_dwMagicDelayTime := Round(g_dwMagicDelayTime / _MAX(2, 1));
            300: g_dwMagicDelayTime := Round(g_dwMagicDelayTime / _MAX(3, 1));
            200: g_dwMagicDelayTime := Round(g_dwMagicDelayTime / _MAX(4, 1));
            100: g_dwMagicDelayTime := Round(g_dwMagicDelayTime / _MAX(5, 1));
            0: g_dwMagicDelayTime := Round(g_dwMagicDelayTime / _MAX(6, 1));
          end;
          }
        end;

        case pmag.MagicSerial of
          //0, 2, 11, 12, 15, 16, 17, 13, 23, 24, 26, 27, 28, 29: ;
          2, 14, 15, 16, 17, 18, 19, 21,
            12, 25, 26, 28, 29, 30, 31: ;
        else g_dwLatestMagicTick := GetTickCount;
        end;

        g_dwMagicPKDelayTime := 0;
        if g_MagicTarget <> nil then
          if g_MagicTarget.m_btRace = 0 then
            g_dwMagicPKDelayTime := g_Config.dwMagicPKDelayTime; //(600+200 + MagicDelayTime div 5);
            //g_dwMagicPKDelayTime := 300 + Random(1100);

        if g_ServerConfig.boChgSpeed then begin
          //g_dwMagicPKDelayTime := Round(g_Config.dwMagicPKDelayTime / _MAX(frmFMain.TrackBarSpellSpeed.Position, 1));
        end;

        if pcm.Def.wMagicId = 56 then begin
          PlayScene.CXYfromMouseXY(tx, ty, targx, targy);
          g_MySelf.SendMsg(CM_SPELL, targx, targy, tdir, Integer(pmag), 0, '', 0);
        end else begin
          g_MySelf.SendMsg(CM_SPELL, targx, targy, tdir, Integer(pmag), targid, '', 0);
        end;
      end;
    end;
  end else DScreen.AddSysMsg('魔法值不够....', 30, 40, clAqua);
end;

procedure TfrmMain.UseMagicSpell(who, effnum, targetx, targety, magic_id: Integer);
var
  Actor: TActor;
  adir: Integer;
  UseMagic: PTUseMagicInfo;
begin
  Actor := PlayScene.FindActor(who);
  if Actor <> nil then begin
    adir := GetFlyDirection(Actor.m_nCurrX, Actor.m_nCurrY, targetx, targety);
    New(UseMagic);
    SafeFillChar(UseMagic^, SizeOf(TUseMagicInfo), #0);
    UseMagic.EffectNumber := effnum; //magnum;
    UseMagic.ServerMagicCode := 0;
    UseMagic.MagicFire := False;
    UseMagic.MagicSerial := magic_id;
    //Actor.SendUpdateMsg(SM_SPELL, 0, 0, adir, Integer(UseMagic), 0, '', 0);
    Actor.SendMsg(SM_SPELL, 0, 0, adir, Integer(UseMagic), 0, '', 0);
    Inc(g_nSpellCount);
  end else Inc(g_nSpellFailCount);
end;

procedure TfrmMain.UseMagicFire(who, efftype, effnum, targetx, targety, target: Integer);
var
  Actor: TActor;
  adir, sound: Integer;
  pmag: PTUseMagicInfo;
begin
  sound := 0; //jacky
  Actor := PlayScene.FindActor(who);
  if Actor <> nil then begin
    Actor.SendMsg(SM_MAGICFIRE, target {111magid}, efftype, effnum, targetx, targety, '', sound);
    if g_nFireCount < g_nSpellCount then
      Inc(g_nFireCount);
  end;
  g_MagicTarget := nil;
end;

procedure TfrmMain.UseMagicFireFail(who: Integer);
var
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(who);
  if Actor <> nil then begin
    Actor.SendMsg(SM_MAGICFIRE_FAIL, 0, 0, 0, 0, 0, '', 0);
  end;
  g_MagicTarget := nil;
end;

procedure TfrmMain.StartSerieMagic(); //开始连击
var
  I: Integer;
begin
  if (g_MySelf = nil) or g_MySelf.m_boDeath or g_boSerieMagic or g_boSerieMagicing or (g_SerieMagicList.Count <= 1) or (g_MySelf.m_btHorse > 0) or
    g_MySelf.m_boStartStore or (ActionKey <> 0) or (g_NewStatus > sNone) or (not ServerAcceptNextAction) then Exit; //{or (not (CanNextAction and ServerAcceptNextAction))}
  g_SerieMagicingList.Clear;
  for I := 0 to 7 do begin
    if g_SerieMagic[I].nMagicID >= 0 then begin
      if (g_SerieMagic[I].nMagicID > 0) and
        (FindSerieMagic(g_SerieMagic[I].nMagicID) = nil) then
        Continue;

      g_SerieMagicingList.Add(Pointer(g_SerieMagic[I].nMagicID));
    end;
  end;

  if g_SerieMagicingList.Count >= 2 then begin
    if g_SerieTarget = nil then begin
      if PlayScene.IsValidActor(g_TargetCret) and (not g_TargetCret.m_boDeath) then begin
        g_SerieTarget := g_TargetCret;
        g_MagicLockActor := g_TargetCret;
        //g_TargetCret := nil;
      end;
    end;

    if g_SerieTarget = nil then begin
      if PlayScene.IsValidActor(g_FocusCret) and (not g_FocusCret.m_boDeath) then begin
        g_SerieTarget := g_FocusCret;
        g_MagicLockActor := g_FocusCret;
      end else begin
        if PlayScene.IsValidActor(g_MagicLockActor) and (not g_MagicLockActor.m_boDeath) then begin
          g_SerieTarget := g_MagicLockActor;
        end;
      end;
    end;

    if (not PlayScene.IsValidActor(g_SerieTarget)) or g_SerieTarget.m_boDeath then begin
      g_SerieTarget := nil;
    end;

    if (g_SerieTarget <> nil) and (g_SerieTarget.m_btRace = RCC_MERCHANT) then
      g_SerieTarget := nil;

    if g_SerieTarget <> nil then begin
      g_nCurrenMagic := -1;
      g_nSerieIndex := 0;
      g_boSerieMagic := True;
      SendClientMessage(CM_STARTSERIESPELL, g_SerieTarget.m_nRecogId, g_SerieTarget.m_nCurrX, g_SerieTarget.m_nCurrY, 0);
    end;
  end;
end;

procedure TfrmMain.StopSerieMagic(); //停止连击
begin
  g_SerieTarget := nil;
  g_boSerieMagic := False;

  g_nSerieIndex := -1;
  g_nCurrenMagic := -1;
  g_nSerieError := 0;
  g_dwSerieMagicTick := GetTickCount;
  g_SerieMagicingList.Clear;
  if g_boSerieMagicing then begin
    g_boSerieMagicing := False;
    SendClientMessage(CM_STOPSERIESPELL, 0, 0, 0, 0);
  end;
end;

procedure TfrmMain.UseSerieMagic(); //使用连击
var
  tdir, targx, targy, targid: Integer;
  pmag: PTUseMagicInfo;
  OldMagicTarget: TActor;
  dwSpellTime: LongWord;
  nCount: Integer;
  Magic: PTClientMagic;
  nTargetX, nTargetY, nTarget: Integer;
  nMagicID: Integer;
begin
  //DScreen.AddSysMsg('TfrmMain.UseSerieMagic();1', 30, 40, clAqua);
  if (g_MySelf = nil) or g_MySelf.m_boDeath or (g_MySelf.m_btHorse > 0) or g_MySelf.m_boStartStore or (ActionKey <> 0) or (g_NewStatus > sNone) or
    (g_nSerieIndex < 0) or (g_nSerieIndex >= g_SerieMagicingList.Count) or (g_SerieMagicList.Count <= 1) then begin
    StopSerieMagic();
    Exit;
  end;

  if g_SerieTarget = nil then begin
    if PlayScene.IsValidActor(g_TargetCret) and (not g_TargetCret.m_boDeath) then begin
      g_SerieTarget := g_TargetCret;
      g_MagicLockActor := g_TargetCret;
      //g_TargetCret := nil;
    end;
  end;

  if g_SerieTarget = nil then begin
    if PlayScene.IsValidActor(g_FocusCret) and (not g_FocusCret.m_boDeath) then begin
      g_SerieTarget := g_FocusCret;
      g_MagicLockActor := g_FocusCret;
    end else begin
      if PlayScene.IsValidActor(g_MagicLockActor) and (not g_MagicLockActor.m_boDeath) then begin
        g_SerieTarget := g_MagicLockActor;
      end;
    end;
  end;


  if (not PlayScene.IsValidActor(g_SerieTarget)) or g_SerieTarget.m_boDeath then begin
    g_SerieTarget := nil;
  end;

  if (g_SerieTarget <> nil) and (g_SerieTarget.m_btRace = RCC_MERCHANT) then
    g_SerieTarget := nil;

  if g_SerieTarget = nil then begin
    StopSerieMagic();
    Exit;
  end;

  if {CanNextAction and}  ServerAcceptNextAction then begin
    g_dwSerieMagicTick := GetTickCount;
    g_nSerieError := 0;
    nTargetX := g_SerieTarget.m_nCurrX;
    nTargetY := g_SerieTarget.m_nCurrY;
    nTarget := g_SerieTarget.m_nRecogId;

    nMagicID := Integer(g_SerieMagicingList.Items[g_nSerieIndex]);
    if nMagicID > 0 then begin
      Magic := FindSerieMagic(nMagicID);
    end else begin
      nMagicID := Random(g_SerieMagicList.Count - 1);
      Magic := PTClientMagic(g_SerieMagicList.Items[nMagicID]);
      nMagicID := Magic.Def.wMagicId;
    end;

    if Magic = nil then begin
      StopSerieMagic();
      Exit;
    end;

    g_nSerieIndex := g_nSerieIndex + 1;
    g_nCurrenMagic := 0;
    if Magic.Def.wMagicId in [100..103] then begin
      g_nCurrenMagic := Magic.Def.wMagicId + 3200;
      Exit;
    end;

    g_dwLatestSpellTick := GetTickCount;
    New(pmag);
    SafeFillChar(pmag^, SizeOf(TUseMagicInfo), #0);
    pmag.EffectNumber := Magic.Def.btEffect;
    pmag.MagicSerial := Magic.Def.wMagicId;

    pmag.ServerMagicCode := 0;
    g_dwMagicDelayTime := 200 + Magic.Def.dwDelayTime;

    if g_ServerConfig.boChgSpeed then begin
      g_dwMagicDelayTime := g_dwMagicDelayTime - Trunc((g_MySelf.m_Abil.AttackSpeed * g_dwMagicDelayTime) / 100);
    end;

    g_dwMagicPKDelayTime := 0;

    //tdir := GetFlyDirection(390, 175, g_nMouseX, g_nMouseY);
    tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_SerieTarget.m_nCurrX, g_SerieTarget.m_nCurrY);
    g_MySelf.SendMsg(CM_SPELL, nTargetX, nTargetY, tdir, Integer(pmag), nTarget, '', 0);
  end else begin
    if g_nSerieError < 3 then begin
      g_nSerieError := 0;
      SendDelayMsg(g_MySelf, SM_STARTSERIESPELL_OK, 0, 0, 0, 0, '', 500);
    end else begin
      StopSerieMagic();
    end;
  end;
end;

procedure TfrmMain.EatItem(idx: Integer);
begin
  if idx in [0..MAXBAGITEMCL - 1] then begin
    if (g_EatingItem.S.Name <> '') and (GetTickCount - g_dwEatTime > 5 * 1000) then begin
      g_EatingItem.S.Name := '';
    end;
    if (g_EatingItem.S.Name = '') and (g_ItemArr[idx].S.Name <> '') and (g_ItemArr[idx].S.StdMode <= 3) then begin
      g_EatingItem := g_ItemArr[idx];
      g_ItemArr[idx].S.Name := '';
      if (g_ItemArr[idx].S.StdMode = 4) and (g_ItemArr[idx].S.Shape < 100) then begin
        if g_ItemArr[idx].S.Shape < 50 then begin
          if mrYes <> FrmDlg.DMessageDlg('是否确认开始练习 "' + g_EatingItem.S.Name + '"?', [mbYes, mbNo]) then begin
            g_ItemArr[idx] := g_EatingItem;
            Exit;
          end;
        end else begin
          if mrYes <> FrmDlg.DMessageDlg('是否确认开始练习 "' + g_EatingItem.S.Name + '"?', [mbYes, mbNo]) then begin
            g_ItemArr[idx] := g_EatingItem;
            Exit;
          end;
        end;
      end;
      if (g_ItemArr[idx].S.StdMode = 49) {and (g_ItemArr[idx].Dura >= g_ItemArr[idx].DuraMax)} then begin
        if mrYes <> FrmDlg.DMessageDlg('是否释放' + g_EatingItem.S.Name + '的经验?', [mbYes, mbNo]) then begin
          g_ItemArr[idx] := g_EatingItem;
          Exit;
        end;
      end;

      g_dwEatTime := GetTickCount;
      SendEat(g_EatingItem.MakeIndex, g_EatingItem.S.Name);
      ItemUseSound(g_EatingItem.S.StdMode);
    end;
  end else begin
    if (idx = -1) and g_boItemMoving then begin
      g_boItemMoving := False;
      g_EatingItem := g_MovingItem.Item;
      g_MovingItem.Item.S.Name := '';
      if (g_EatingItem.S.StdMode = 4) and (g_EatingItem.S.Shape < 100) then begin
        if g_EatingItem.S.Shape < 50 then begin
          if mrYes <> FrmDlg.DMessageDlg('是否确认开始练习 "' + g_EatingItem.S.Name + '"?', [mbYes, mbNo]) then begin
            AddItemBag(g_EatingItem);
            Exit;
          end;
        end else begin
          if mrYes <> FrmDlg.DMessageDlg('是否确认开始练习 "' + g_EatingItem.S.Name + '"?', [mbYes, mbNo]) then
          begin
            AddItemBag(g_EatingItem);
            Exit;
          end;
        end;
      end;
      if (g_ItemArr[idx].S.StdMode = 49) {and (g_ItemArr[idx].Dura >= g_ItemArr[idx].DuraMax)} then begin
        if mrYes <> FrmDlg.DMessageDlg('是否释放' + g_EatingItem.S.Name + '的经验?', [mbYes, mbNo]) then begin
          g_ItemArr[idx] := g_EatingItem;
          Exit;
        end;
      end;
      g_dwEatTime := GetTickCount;
      SendEat(g_EatingItem.MakeIndex, g_EatingItem.S.Name);
      ItemUseSound(g_EatingItem.S.StdMode);
    end;
  end;
  ArrangeItemBag;
end;

//英雄吃药

procedure TfrmMain.HeroEatItem(idx: Integer);
begin
  if idx in [0..g_MyHero.m_nBagCount] then begin
    if (g_HeroEatingItem.S.Name <> '') and (GetTickCount - g_dwHeroEatTime > 5 * 1000) then begin
      g_HeroEatingItem.S.Name := '';
    end;
    if (g_HeroEatingItem.S.Name = '') and (g_HeroItemArr[idx].S.Name <> '') and (g_HeroItemArr[idx].S.StdMode <= 3) then begin
      g_HeroEatingItem := g_HeroItemArr[idx];
      g_HeroItemArr[idx].S.Name := '';
      if (g_HeroEatingItem.S.StdMode = 4) and (g_HeroEatingItem.S.Shape < 100) then begin
        if g_HeroEatingItem.S.Shape < 50 then begin
          if mrYes <> FrmDlg.DMessageDlg('是否确认开始练习 "' + g_HeroEatingItem.S.Name + '"?', [mbYes, mbNo]) then begin
            g_HeroItemArr[idx] := g_HeroEatingItem;
            Exit;
          end;
        end else begin
          if mrYes <> FrmDlg.DMessageDlg('是否确认开始练习 "' + g_HeroEatingItem.S.Name + '"?', [mbYes, mbNo]) then begin
            g_HeroItemArr[idx] := g_HeroEatingItem;
            Exit;
          end;
        end;
      end;
      g_dwHeroEatTime := GetTickCount;
      SendHeroEat(g_HeroEatingItem.MakeIndex, g_HeroEatingItem.S.Name);
      ItemUseSound(g_HeroEatingItem.S.StdMode);
      {g_dwHeroEatTime := GetTickCount;
      SendHeroEat(g_HeroItemArr[idx].MakeIndex, g_HeroItemArr[idx].S.name);
      ItemUseSound(g_HeroItemArr[idx].S.StdMode);}
    end;
  end else begin
    if (idx = -1) and g_boItemMoving then begin
      g_boItemMoving := False;
      g_HeroEatingItem := g_MovingItem.Item;
      g_MovingItem.Item.S.Name := '';
      if (g_HeroEatingItem.S.StdMode = 4) and (g_HeroEatingItem.S.Shape < 100) then begin
        if g_HeroEatingItem.S.Shape < 50 then begin
          if mrYes <> FrmDlg.DMessageDlg('是否确认开始练习 "' + g_HeroEatingItem.S.Name + '"?', [mbYes, mbNo]) then begin
            AddHeroItemBag(g_HeroEatingItem);
            Exit;
          end;
        end else begin
          if mrYes <> FrmDlg.DMessageDlg('是否确认开始练习 "' + g_HeroEatingItem.S.Name + '"?', [mbYes, mbNo]) then begin
            AddHeroItemBag(g_HeroEatingItem);
            Exit;
          end;
        end;
      end;
      g_dwHeroEatTime := GetTickCount;
      SendHeroEat(g_HeroEatingItem.MakeIndex, g_HeroEatingItem.S.Name);
      ItemUseSound(g_HeroEatingItem.S.StdMode);
    end;
  end;
  ArrangeHeroItemBag;
end;

function TfrmMain.IsAttackTarget(Actor: TActor): Boolean;
var
  sUserName, sText: string;
begin
  Result := False;
  if not Actor.m_boDeath then begin
    if (Actor.m_btRace <> RCC_MERCHANT) and (Actor <> g_MyHero) then begin
      Result := True;
      if (Pos('(', Actor.m_sUserName) = 0) then begin
        sText := Actor.m_sUserName;
        sText := ArrestStringEx(sText, '(', ')', sUserName);
        if CompareText(sUserName, g_MySelf.m_sUserName) = 0 then Result := False;
        if (g_MyHero <> nil) and (CompareText(sUserName, g_MyHero.m_sUserName) = 0) then Result := False;
      end;
    end;
  end;
end;

function TfrmMain.CanAttack(ndir: Integer; target: TActor): Boolean;
var
  nX, nY: Integer;
  Actor: TActor;
begin
  Result := False;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nX, nY);
  if (target.m_nCurrX = nX) and (target.m_nCurrY = nY) then begin
    Actor := PlayScene.FindActorXY(nX, nY);
    if (Actor <> nil) then
      Result := IsAttackTarget(Actor);
  end;
end;

function TfrmMain.TargetInSwordLongAttackRange(ndir: Integer): Boolean;
var
  nX, nY: Integer;
  Actor: TActor;
begin
  Result := False;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nX, nY);
  GetFrontPosition(nX, nY, ndir, nX, nY);
  if (abs(g_MySelf.m_nCurrX - nX) = 2) or (abs(g_MySelf.m_nCurrY - nY) = 2) then begin
    Actor := PlayScene.FindActorXY(nX, nY);
    if (Actor <> nil) then
      Result := IsAttackTarget(Actor);
  end;
end;

function TfrmMain.TargetInSwordLongAttackRange(ndir: Integer; target: TActor; nRange: Integer): Boolean;
var
  nX, nY: Integer;
  Actor: TActor;
begin
  Result := False;
  if nRange in [1, 2] then begin
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nX, nY);
    Actor := PlayScene.FindActorXY(nX, nY);
    if (Actor = target) and IsAttackTarget(Actor) then begin
      Result := True;
      Exit;
    end;
  end;

  if nRange in [2, 3] then begin
    if nRange = 3 then
      GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nX, nY);

    GetFrontPosition(nX, nY, ndir, nX, nY);
    if (abs(g_MySelf.m_nCurrX - nX) = 2) or (abs(g_MySelf.m_nCurrY - nY) = 2) then begin
      Actor := PlayScene.FindActorXY(nX, nY);
      if Actor = target then
        if (Actor = target) and IsAttackTarget(Actor) then
          Result := True;
    end;
  end;
end;


function TfrmMain.TargetInSwordWideAttackRange(ndir: Integer): Boolean; //半月的范围
var
  nX, nY, rx, ry, mdir: Integer;
  Actor, ractor: TActor;
begin
  Result := False;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nX, nY);
  Actor := PlayScene.FindActorXY(nX, nY);

  mdir := (ndir + 1) mod 8;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
  ractor := PlayScene.FindActorXY(rx, ry);
  if ractor = nil then
  begin
    mdir := (ndir + 2) mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
    ractor := PlayScene.FindActorXY(rx, ry);
  end;
  if ractor = nil then
  begin
    mdir := (ndir + 7) mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
    ractor := PlayScene.FindActorXY(rx, ry);
  end;
  Result := (Actor <> nil) and (ractor <> nil) and (Actor <> ractor) and IsAttackTarget(Actor) and IsAttackTarget(ractor);
end;

function TfrmMain.TargetInSwordCrsAttackRange(ndir: Integer): Boolean;
const
  CrsAttack: array[0..6] of Byte = (7, 1, 2, 3, 4, 5, 6);
var
  nX, nY, rx, ry, mdir, n10, nC, n12: Integer;
  Actor, ractor: TActor;
begin
  Result := False;
  nC := 0;
  n12 := 0;
  while (True) do begin
    n10 := (ndir + CrsAttack[nC]) mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, n10, nX, nY);
    Actor := PlayScene.FindActorXY(nX, nY);
    if (Actor <> nil) and IsAttackTarget(Actor) then Inc(n12);
    Inc(nC);
    if nC >= 7 then Break;
  end;
  if n12 >= 5 then Result := True;

end;

function TfrmMain.TargetInKTZAttackRange(ndir: Integer): Boolean; //开天斩
var
  nX, nY, nCount: Integer;
  Actor: TActor;
  I: Integer;
begin
  Result := False;
  nCount := 0;
  for I := 1 to 4 do begin
    nX := g_MySelf.m_nCurrX;
    nY := g_MySelf.m_nCurrY;
    GetFrontPosition(nX, nY, ndir, nX, nY);
    Actor := PlayScene.FindActorXY(nX, nY);
    if (Actor <> nil) and IsAttackTarget(Actor) then begin
      Inc(nCount);
    end;
  end;
  if nCount > 1 then Result := True;
end;

{--------------------- Mouse Interface ----------------------}

procedure TfrmMain.DXDrawMouseMove_(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  I, mx, my, msx, msy, sel: Integer;
  target: TActor;
  itemnames: string;
begin
  g_boShowMiniMapXY := False;
  if (g_MySelf = nil) or (DScreen.CurrentScene <> PlayScene) or (g_NewStatus > sNone) then Exit;
  g_boSelectMyself := PlayScene.IsSelectMyself(X, Y);

  target := PlayScene.GetAttackFocusCharacter(X, Y, g_nDupSelection, sel, False);
  if g_nDupSelection <> sel then g_nDupSelection := 0;
  if target <> nil then begin
    if (target.m_sUserName = '') and (GetTickCount - target.m_dwSendQueryUserNameTime > 10 * 1000) then begin
      target.m_dwSendQueryUserNameTime := GetTickCount;
      SendQueryUserName(target.m_nRecogId, target.m_nCurrX, target.m_nCurrY);
    end;
    g_FocusCret := target;
  end else g_FocusCret := nil;

 { g_FocusItem := PlayScene.GetDropItems(X, Y, itemnames);
  if g_FocusItem <> nil then begin
    PlayScene.ScreenXYfromMCXY(g_FocusItem.X, g_FocusItem.Y, mx, my);
    g_HintList.Clear;
    ExtractStrings(['\'], [], PChar(itemnames), g_HintList);
    //g_HintList.AddObject(itemnames, TObject(clWhite));
    for I := 0 to g_HintList.Count - 1 do g_HintList.Objects[I] := TObject(clWhite);
    DScreen.ShowHint(mx - 20,
      my - 10,
      g_HintList, //PTDropItem(ilist[i]).Name,
      True);
  end else DScreen.ClearHint;  }

  g_FocusItem := PlayScene.GetDropItems(X, Y, itemnames);
  if g_FocusItem <> nil then begin
    g_boClearFocusItemMsg := False;
    PlayScene.ScreenXYfromMCXY(g_FocusItem.X, g_FocusItem.Y, mx, my);
    DScreen.ShowHint(mx - 20,
      my - 10,
      itemnames, //PTDropItem(ilist[i]).Name,
      clWhite,
      True);
  end else begin
    if not g_boClearFocusItemMsg then begin
      g_boClearFocusItemMsg := True;
      DScreen.ClearHint;
    end;
    DScreen.ClearHint;
  end;
   //DScreen.ClearHint;
  PlayScene.CXYfromMouseXY(X, Y, g_nMouseCurrX, g_nMouseCurrY);
  g_nMouseX := X;
  g_nMouseY := Y;
  g_MouseItem.S.Name := '';
  g_MouseHeroItem.S.Name := '';
  g_MouseStateItem.S.Name := '';
  g_MouseUserStateItem.S.Name := '';
  if ((ssLeft in Shift) or (ssRight in Shift)) and (GetTickCount - mousedowntime > 300) then
    _DXDrawMouseDown(Self, Button, Shift, X, Y);
end;

procedure TfrmMain.DXDrawMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  Button: TMouseButton;
  pt: TPoint;
begin
{
  GetCursorPos(pt);
  pt := ScreenToClient(pt);
  if DWinMan.MouseMove(Shift, pt.X, pt.Y) then Exit;
  if (ssLeft in Shift) then Button := mbLeft;
  if (ssRight in Shift) then Button := mbRight;
  DXDrawMouseMove_(Button, Shift, pt.X, pt.Y);
  }

  if DWinMan.MouseMove(Shift, X, Y) then Exit;
  if (ssLeft in Shift) then Button := mbLeft;
  if (ssRight in Shift) then Button := mbRight;
  DXDrawMouseMove_(Button, Shift, X, Y);
end;

procedure TfrmMain.DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pt: TPoint;
begin
  //GetCursorPos(pt);
  //pt := ScreenToClient(pt);
  //g_DWinMan.MouseUp(Button, Shift,pt.X, pt.Y);
  mousedowntime := GetTickCount;
  g_nRunReadyCount := 0;
  //_DXDrawMouseDown(Sender, Button, Shift, pt.X, pt.Y);
  _DXDrawMouseDown(Sender, Button, Shift, X, Y);
end;

function GetCanCrsHit: Boolean; //抱月
var
  pm: PTClientMagic;
begin
  if not g_boCanCrsHit then begin
    pm := frmMain.FindMagic(40);
    if pm <> nil then begin
      frmMain.UseMagic(g_nMouseX, g_nMouseY, pm);
      frmMain.ActionKey := 0;
      g_nTargetX := -1;
    end;
  end;
  Result := g_boCanCrsHit;
end;

function GetCanWideHit: Boolean; //半月
var
  pm: PTClientMagic;
begin
  if not g_boCanWideHit then begin
    pm := frmMain.FindMagic(25);
    if pm <> nil then begin
      frmMain.UseMagic(g_nMouseX, g_nMouseY, pm);
      frmMain.ActionKey := 0;
      g_nTargetX := -1;
    end;
  end;
  Result := g_boCanWideHit;
end;

function GetCanLongHit: Boolean; //刺杀
var
  pm: PTClientMagic;
begin
  if not g_boCanLongHit then begin
    pm := frmMain.FindMagic(12);
    if pm <> nil then begin
      frmMain.UseMagic(g_nMouseX, g_nMouseY, pm);
      frmMain.ActionKey := 0;
      g_nTargetX := -1;
    end;
  end;
  Result := g_boCanLongHit;
end;

function GetCanPowerHit: Boolean; //攻杀
var
  pm: PTClientMagic;
begin
  if not g_boNextTimePowerHit then begin
    pm := frmMain.FindMagic(7);
    if pm <> nil then begin
      g_boNextTimePowerHit := Random(20) = 0;
     { frmMain.UseMagic(g_nMouseX, g_nMouseY, pm);
      frmMain.ActionKey := 0;
      g_nTargetX := -1; }
    end;
  end;
  Result := g_boNextTimePowerHit;
end;

function TfrmMain.SearchHitMsg(tdir: Integer): Integer;
begin
  {Result := CM_101HIT;
  EXIT;  }
  if g_boSerieMagicing then begin
    Result := g_nCurrenMagic;
    Exit;
  end;
  Result := CM_HIT;
  if g_boNextTime60Hit and (g_MySelf.m_Abil.MP >= 7) then begin
    g_boNextTime60Hit := False;
    Result := CM_60HIT; //破魂
  end else
    if g_boNextTimeZRJFHit and (g_MySelf.m_Abil.MP >= 7) then begin
    g_boNextTimeZRJFHit := False;
    Result := CM_ZRJFHIT; //逐日剑法
  end else
    if g_boNextTimeFireHit and (g_MySelf.m_Abil.MP >= 7) then begin
    g_boNextTimeFireHit := False;
    Result := CM_FIREHIT; //烈火
  end else
    if g_boNextTimeKTZHit and (g_MySelf.m_Abil.MP >= 7) then begin
    g_boNextTimeKTZHit := False;
    Result := CM_KTHIT; //开天斩
  end else
    if g_boNextTimePKJHit and (g_MySelf.m_Abil.MP >= 7) then begin
    g_boNextTimePKJHit := False;
    Result := CM_PKHIT; //破空剑
  end else
    if (Random(50) = 0) and GetCanPowerHit then begin
    Result := CM_POWERHIT; //攻杀
  end else
    if g_boCanCrsHit and (g_MySelf.m_Abil.MP >= 6) and TargetInSwordCrsAttackRange(tdir) then begin //抱月
    Result := CM_CRSHIT;
  end else
    if g_boCanWideHit and (g_MySelf.m_Abil.MP >= 3) and TargetInSwordWideAttackRange(tdir) then begin
    Result := CM_WIDEHIT; //半月
  end else
    if g_boCanLongHit and TargetInSwordLongAttackRange(tdir) then begin
    Result := CM_LONGHIT; //刺杀
  end else
    if g_boNextTimePowerHit then begin //攻杀
    g_boNextTimePowerHit := False;
    Result := CM_POWERHIT;
  end else
    if g_boCanTwnHit and (g_MySelf.m_Abil.MP >= 10) then begin
    g_boCanTwnHit := False;
    Result := CM_TWINHIT;
  end;
  if (Result = CM_FIREHIT) or (Result = CM_KTHIT) or (Result = CM_PKHIT) or (Result = CM_60HIT) or (Result = CM_ZRJFHIT) or (Result <> CM_HIT) then Exit;

  if g_Config.boSmartCrsHit and (g_MySelf.m_Abil.MP >= 6) and TargetInSwordCrsAttackRange(tdir) and GetCanCrsHit then begin
    Result := CM_CRSHIT; //抱月
    Exit;
  end;

  if g_Config.boSmartWideHit and (g_MySelf.m_Abil.MP >= 3) and TargetInSwordWideAttackRange(tdir) and GetCanWideHit then begin
    Result := CM_WIDEHIT; //半月
    Exit;
  end;

  if (Random(50) = 0) and GetCanPowerHit then begin
    Result := CM_POWERHIT; //攻杀
    Exit;
  end;

  if g_Config.boSmartLongHit and GetCanLongHit then begin
    Result := CM_LONGHIT; //刺杀
    Exit;
  end;

  if g_boCanWideHit then begin
    Result := CM_WIDEHIT; //半月
    Exit;
  end;

  if g_boCanLongHit then begin
    Result := CM_LONGHIT; //刺杀
    Exit;
  end;

  if g_boCanCrsHit then begin
    Result := CM_CRSHIT; //抱月
    Exit;
  end;
end;

function TfrmMain.SearchLongHit(tdir: Integer): Integer;
begin
  {Result := CM_101HIT;
  EXIT;}

  if g_boSerieMagicing then begin
    Result := g_nCurrenMagic;
    Exit;
  end;
  Result := CM_HIT;
  if g_boNextTime60Hit and (g_MySelf.m_Abil.MP >= 7) then begin
    Result := CM_60HIT; //破魂
  end else
    if g_boNextTimeZRJFHit and (g_MySelf.m_Abil.MP >= 7) then begin
    Result := CM_ZRJFHIT; //逐日剑法
  end else
    if g_boNextTimeFireHit and (g_MySelf.m_Abil.MP >= 7) then begin
    Result := CM_FIREHIT; //烈火
  end else
    if g_boNextTimeKTZHit and (g_MySelf.m_Abil.MP >= 7) then begin
    Result := CM_KTHIT; //开天斩
  end else
    if g_boNextTimePKJHit and (g_MySelf.m_Abil.MP >= 7) then begin
    Result := CM_PKHIT; //破空剑
  end else
    if (Random(50) = 0) and GetCanPowerHit then begin
    Result := CM_POWERHIT; //攻杀
  end else
    if g_boCanCrsHit and (g_MySelf.m_Abil.MP >= 6) and TargetInSwordCrsAttackRange(tdir) then begin //抱月
    Result := CM_CRSHIT;
  end else
    if g_boCanWideHit and (g_MySelf.m_Abil.MP >= 3) and TargetInSwordWideAttackRange(tdir) then begin
    Result := CM_WIDEHIT; //半月
  end else
    if g_boCanLongHit and TargetInSwordLongAttackRange(tdir) then begin
    Result := CM_LONGHIT; //刺杀
  end else
    if g_boNextTimePowerHit then begin //攻杀
    Result := CM_POWERHIT;
  end else
    if g_boCanTwnHit and (g_MySelf.m_Abil.MP >= 10) then begin
    Result := CM_TWINHIT;
  end;

  if (Result = CM_FIREHIT) or (Result = CM_KTHIT) or (Result = CM_PKHIT) or (Result = CM_60HIT) or (Result = CM_ZRJFHIT) or (Result <> CM_HIT) then Exit;
  //if (Result = CM_FIREHIT) or (Result = CM_KTHIT) or (Result = CM_PKHIT) {or (Result = CM_60HIT) } or (Result = CM_ZRJFHIT) then Exit;

  if g_Config.boSmartCrsHit and (g_MySelf.m_Abil.MP >= 6) and TargetInSwordCrsAttackRange(tdir) and GetCanCrsHit then begin
    Result := CM_CRSHIT; //抱月
    Exit;
  end;

  if g_Config.boSmartWideHit and (g_MySelf.m_Abil.MP >= 3) and TargetInSwordWideAttackRange(tdir) and GetCanWideHit then begin
    Result := CM_WIDEHIT; //半月
    Exit;
  end;

  if (Random(50) = 0) and GetCanPowerHit then begin
    Result := CM_POWERHIT; //攻杀
    Exit;
  end;

  if g_Config.boSmartLongHit and GetCanLongHit then begin
    Result := CM_LONGHIT; //刺杀
    Exit;
  end;

  if g_boCanWideHit then begin
    Result := CM_WIDEHIT; //半月
    Exit;
  end;

  if g_boCanLongHit then begin
    Result := CM_LONGHIT; //刺杀
    Exit;
  end;

  if g_boCanCrsHit then begin
    Result := CM_CRSHIT; //抱月
    Exit;
  end;
end;

function IsInLine(nTargetX, nTargetY: Integer): Boolean;
var
  I: Integer;
  nCurrX, nCurrY, nX, nY: Integer;
  btDir: Byte;
begin
  Result := False;

  nCurrX := g_MySelf.m_nCurrX;
  nCurrY := g_MySelf.m_nCurrY;
  btDir := GetNextDirection(nCurrX, nCurrY, nTargetX, nTargetY);
  while True do begin
    if (nCurrX = nTargetX) and (nCurrY = nTargetY) then Break;
    GetFrontPosition(nCurrX, nCurrY, btDir, nCurrX, nCurrY);
    btDir := GetNextDirection(nCurrX, nCurrY, nCurrX, nCurrY);
    if (nCurrX = nTargetX) and (nCurrY = nTargetY) then begin
      Result := True;
      Break;
    end;
    if GetNextDirection(nCurrX, nCurrY, nTargetX, nTargetY) <> btDir then begin
      Result := False;
      Break;
    end;
  end;
end;

function IsInRangeLine(nTargetX, nTargetY, nRange: Integer): Boolean; overload;
var
  I: Integer;
  nCurrX, nCurrY: Integer;
  btDir: Byte;
begin
  Result := False;
  nCurrX := g_MySelf.m_nCurrX;
  nCurrY := g_MySelf.m_nCurrY;
  btDir := GetNextDirection(nCurrX, nCurrY, nTargetX, nTargetY);
  for I := 1 to nRange do begin
    if (nCurrX = nTargetX) and (nCurrY = nTargetY) then Break;
    GetFrontPosition(nCurrX, nCurrY, btDir, nCurrX, nCurrY);
    btDir := GetNextDirection(nCurrX, nCurrY, nCurrX, nCurrY);
    if (nCurrX = nTargetX) and (nCurrY = nTargetY) then begin
      Result := True;
      Break;
    end;
    if GetNextDirection(nCurrX, nCurrY, nTargetX, nTargetY) <> btDir then begin
      Result := False;
      Break;
    end;
  end;
end;

function TargetInRangeLine(target: TActor; nRange: Integer): Boolean; overload;
var
  I: Integer;
  Actor: TActor;
  nCurrX, nCurrY: Integer;
  btDir: Byte;
begin
  Result := False;
  nCurrX := g_MySelf.m_nCurrX;
  nCurrY := g_MySelf.m_nCurrY;
  btDir := GetNextDirection(nCurrX, nCurrY, target.m_nCurrX, target.m_nCurrY);
  for I := 1 to nRange do begin
    Actor := PlayScene.FindActorXY(nCurrX, nCurrY);
    if (Actor = target) then begin
      Result := True;
      Break;
    end;
    GetFrontPosition(nCurrX, nCurrY, btDir, nCurrX, nCurrY);
    btDir := GetNextDirection(nCurrX, nCurrY, nCurrX, nCurrY);

    if GetNextDirection(nCurrX, nCurrY, target.m_nCurrX, target.m_nCurrY) <> btDir then begin
      Result := False;
      Break;
    end;
  end;
end;


function GetRangeHit(nHit: Integer): Boolean;
begin
  Result := {(nHit = CM_60HIT) or }(nHit = CM_ZRJFHIT) or (nHit = CM_KTHIT) or (nHit = CM_PKHIT);
end;

function GetWalkLongDir(btDir: Byte): Integer;
begin
  {case btDir OF
  DR_UP :;
  DR_UPRIGHT = 1;
  DR_RIGHT = 2;
  DR_DOWNRIGHT = 3;
  DR_DOWN = 4;
  DR_DOWNLEFT = 5;
  DR_LEFT = 6;
  DR_UPLEFT = 7;}
end;

function GetWalkLongHitXY(nCurrX, nCurrY: Integer; var nX, nY: Integer): Boolean;
var
  btDir: Byte;
  ndir: Integer;
begin
  Result := False;
  nX := nCurrX;
  nY := nCurrY;
  btDir := GetNextDirection(nCurrX, nCurrY, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY);
  GetFrontPosition(nX, nY, btDir, 2, nX, nY);
  if ((nCurrX <> nX) or (nCurrY <> nY)) then begin
    if (abs(g_MySelf.m_nCurrX - nX) <= 1) and (abs(g_MySelf.m_nCurrY - nY) <= 1) then begin
      if PlayScene.CanWalk(nX, nY) then begin
        Result := True;
        Exit;
      end;
    end else begin
      if PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, nX, nY) then begin
        Result := True;
        Exit;
      end;
    end;
  end;

  if btDir + 1 > 7 then btDir := 0 else btDir := btDir + 1;
  GetFrontPosition(nX, nY, btDir, 2, nX, nY);
  if ((nCurrX <> nX) or (nCurrY <> nY)) then begin
    if (abs(g_MySelf.m_nCurrX - nX) <= 1) and (abs(g_MySelf.m_nCurrY - nY) <= 1) then begin
      if PlayScene.CanWalk(nX, nY) then begin
        Result := True;
        Exit;
      end;
    end else begin
      if PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, nX, nY) then begin
        Result := True;
        Exit;
      end;
    end;
  end;

  btDir := GetNextDirection(nCurrX, nCurrY, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY);
  if btDir - 1 < 0 then btDir := 7 else btDir := btDir - 1;
  GetFrontPosition(nX, nY, btDir, 2, nX, nY);
  if ((nCurrX <> nX) or (nCurrY <> nY)) then begin
    if (abs(g_MySelf.m_nCurrX - nX) <= 1) and (abs(g_MySelf.m_nCurrY - nY) <= 1) then begin
      if PlayScene.CanWalk(nX, nY) then begin
        Result := True;
        Exit;
      end;
    end else begin
      if PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, nX, nY) then begin
        Result := True;
        Exit;
      end;
    end;
  end;

//==============================================================================
  ndir := GetNextDirection(nCurrX, nCurrY, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY);
  Inc(ndir);
  if ndir > 7 then ndir := 0;
  Inc(ndir);
  if ndir > 7 then ndir := 0;
  btDir := ndir;

  GetFrontPosition(nX, nY, btDir, 2, nX, nY);
  if ((nCurrX <> nX) or (nCurrY <> nY)) then begin
    if (abs(g_MySelf.m_nCurrX - nX) <= 1) and (abs(g_MySelf.m_nCurrY - nY) <= 1) then begin
      if PlayScene.CanWalk(nX, nY) then begin
        Result := True;
        Exit;
      end;
    end else begin
      if PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, nX, nY) then begin
        Result := True;
        Exit;
      end;
    end;
  end;

  ndir := GetNextDirection(nCurrX, nCurrY, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY);
  Dec(ndir);
  if ndir < 0 then ndir := 7;
  Dec(ndir);
  if ndir < 0 then ndir := 7;
  btDir := ndir;

  GetFrontPosition(nX, nY, btDir, 2, nX, nY);
  if ((nCurrX <> nX) or (nCurrY <> nY)) then begin
    if (abs(g_MySelf.m_nCurrX - nX) <= 1) and (abs(g_MySelf.m_nCurrY - nY) <= 1) then begin
      if PlayScene.CanWalk(nX, nY) then begin
        Result := True;
        Exit;
      end;
    end else begin
      if PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, nX, nY) then begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

procedure TfrmMain.AttackTarget(target: TActor);
var
  tdir, dx, dy, nHitMsg: Integer;
begin
  if target = nil then Exit;

  nHitMsg := CM_HIT;
  if g_UseItems[U_WEAPON].S.StdMode = 6 then nHitMsg := CM_HEAVYHIT;

  tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY);
  if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 1) and (abs(g_MySelf.m_nCurrY - target.m_nCurrY) <= 1) and (not target.m_boDeath) then begin
    if CanNextAction and ServerAcceptNextAction and CanNextHit then begin

      if g_boNextTimePowerHit then begin // Slaying
        g_boNextTimePowerHit := False;
        nHitMsg := CM_POWERHIT;
      end else                          // Thrusting
        if g_boCanLongHit and TargetInSwordLongAttackRange(tdir) then begin
        nHitMsg := CM_LONGHIT;
      end else                          // Halfmoon
        if g_boCanWideHit and (g_MySelf.m_Abil.MP >= 3) and TargetInSwordWideAttackRange(tdir) then begin
        nHitMsg := CM_WIDEHIT;
      end else                          // CrossHalfMoon
        if g_boCanCrsHit and (g_MySelf.m_Abil.MP >= 6) and TargetInSwordCrsAttackRange(tdir) then begin
        nHitMsg := CM_CRSHIT;
      end else
        if g_boCanTwnHit and (g_MySelf.m_Abil.MP >= 10) then begin
        g_boCanTwnHit := False;
        nHitMsg := CM_TWINHIT;
      end;

      g_MySelf.SendMsg(nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
      g_dwLatestHitTick := GetTickCount;
    end;
  end else begin
    g_ChrAction := caWalk;
    GetBackPosition(target.m_nCurrX, target.m_nCurrY, tdir, dx, dy);
    g_nTargetX := dx;
    g_nTargetY := dy;
  end;
end;

procedure TfrmMain.DXDrawMouseDown_(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  tdir, nX, nY, nHitMsg, sel: Integer;
  target: TActor;
  dwMoveTime: LongWord;
begin
  ActionKey := 0;
  g_nMouseX := X;
  g_nMouseY := Y;
  //Showmessage('TfrmMain.DXDrawMouseDown_');
  g_boAutoDig := False;
  if (Button = mbRight) and g_boItemMoving then begin //是否当前在移动物品
    FrmDlg.CancelItemMoving;
    Exit;
  end;

  g_boShowMiniMapXY := False;

  if (g_MySelf = nil) or (DScreen.CurrentScene <> PlayScene) or (g_NewStatus > sNone) then Exit; //如果人物退出则跳过

  if ssRight in Shift then begin //鼠标右键
    if Shift = [ssRight] then Inc(g_nDupSelection); //般闷阑 版快 急琶
    target := PlayScene.GetAttackFocusCharacter(X, Y, g_nDupSelection, sel, False); //取指定坐标上的角色
    if g_nDupSelection <> sel then g_nDupSelection := 0;
    //if target <> g_TargetCret then g_TargetCret := nil; //2008-12-27增加 鼠标右击停止攻击
    if target <> nil then begin
      if ssCtrl in Shift then begin //CTRL + 鼠标右键 = 显示角色的信息
        if GetTickCount - g_dwLastMoveTick > 1000 then begin
          if (target.m_btRace = 0) and (not target.m_boDeath) then begin
            //取得人物信息
            SendClientMessage(CM_QUERYUSERSTATE, target.m_nRecogId, target.m_nCurrX, target.m_nCurrY, 0);
            Exit;
          end;
        end;
      end;
    end else g_nDupSelection := 0;

    if g_MySelf.m_boStartStore then Exit; //摆摊状态禁止走动，

    //按鼠标右键，并且鼠标指向空位置
    PlayScene.CXYfromMouseXY(X, Y, g_nMouseCurrX, g_nMouseCurrY);
    if (abs(g_MySelf.m_nCurrX - g_nMouseCurrX) < 2) and (abs(g_MySelf.m_nCurrY - g_nMouseCurrY) < 2) then begin //目标座标
      tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
      if CanNextAction and ServerAcceptNextAction then begin //转象
        g_MySelf.SendMsg(CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
      end;
    end else begin //跑
      if g_MySelf.m_btHorse = 0 then begin
        g_ChrAction := caRun;
      end else begin
        g_ChrAction := caHorseRun;
      end;
      g_nTargetX := g_nMouseCurrX;
      g_nTargetY := g_nMouseCurrY;
      Exit;
    end;
    { if CanNextAction and ServerAcceptNextAction then begin
            //人物座标与目标座标之间是否小于2，小于则走操作
            if (abs(Myself.XX-MCX) <= 2) and (abs(Myself.m_nCurrY-MCY) <= 2) then begin
               ChrAction := caWalk;
            end else begin //跑操作
               ChrAction := caRun;
            end;
               TargetX := MCX;
               TargetY := MCY;
               exit;
          end;
     }
  end;

  if ssLeft in Shift {Button = mbLeft} then begin //按鼠标左键
    target := PlayScene.GetAttackFocusCharacter(X, Y, g_nDupSelection, sel, True);
    if target = nil then begin
          //骑马不允许操作
      if PlayScene.IsSelectMyself(X, Y) and (g_MySelf <> nil) and (not g_MySelf.m_boDeath) and g_MySelf.m_boStartStore then begin //查询摆摊物品
        if GetTickCount - g_dwQueryStoreTick > 1000 then begin
          g_dwQueryStoreTick := GetTickCount;
          SendClientMessage(CM_QUERYSTORE, g_MySelf.m_nRecogId, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, 0);
          //DScreen.AddChatBoardString('SendClientMessage(CM_QUERYSTORE', clRed, clBlue);
        end;
        Exit;
      end;
    end;

    PlayScene.CXYfromMouseXY(X, Y, g_nMouseCurrX, g_nMouseCurrY);
    g_TargetCret := nil;
    if (g_UseItems[U_WEAPON].S.Name <> '') and (target = nil) and (g_MySelf.m_btHorse = 0) and (not g_MySelf.m_boStartStore) {摆摊状态} and (g_NewStatus = sNone) then begin //骑马状态不可以操作
      //挖矿
      if g_UseItems[U_WEAPON].S.Shape = 19 then begin //鹤嘴锄
        tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
        GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, nX, nY);
        if not Map.CanMove(nX, nY) or (ssShift in Shift) then begin //不能移动或强行挖矿
          if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
            g_MySelf.SendMsg(CM_HIT + 1, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
          end;
          g_boAutoDig := True;
          Exit;
        end;
      end;
    end;

    if (ssAlt in Shift) and (g_MySelf.m_btHorse = 0) and (not g_MySelf.m_boStartStore) and (g_NewStatus = sNone) {摆摊状态} then begin //骑马状态不可以操作
      //挖物品
      tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
      if CanNextAction and ServerAcceptNextAction then begin
        target := PlayScene.ButchAnimal(g_nMouseCurrX, g_nMouseCurrY);
        if target <> nil then begin
          SendButchAnimal(g_nMouseCurrX, g_nMouseCurrY, tdir, target.m_nRecogId);
          g_MySelf.SendMsg(CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
          Exit;
        end;
        g_MySelf.SendMsg(CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
      end;
      g_nTargetX := -1;
    end else begin
      if (target <> nil) or (ssShift in Shift) then begin
        g_nTargetX := -1;
        if target <> nil then begin
          if GetTickCount - g_dwLastMoveTick > 500 then begin
            if (target.m_btRace = RCC_MERCHANT) and (not g_MySelf.m_boStartStore) {摆摊状态} then begin
              SendClientMessage(CM_CLICKNPC, target.m_nRecogId, 0, 0, BoolToInt(FrmDlg.DMerchantBigDlg.Visible));
              Exit;
            end;
          end;
          if (not target.m_boDeath) and (target.m_btRace = 0) and target.m_boStartStore then begin //查询摆摊物品
            if GetTickCount - g_dwQueryStoreTick > 1000 then begin
              g_dwQueryStoreTick := GetTickCount;
              SendClientMessage(CM_QUERYSTORE, target.m_nRecogId, target.m_nCurrX, target.m_nCurrY, 0);
              //DScreen.AddChatBoardString('SendClientMessage(CM_QUERYSTORE', clRed, clBlue);
            end;
            Exit;
          end;
          if (not target.m_boDeath) and (g_MySelf.m_btHorse = 0) and (not g_MySelf.m_boStartStore) {摆摊状态} and (g_NewStatus = sNone) then begin //骑马不允许操作
            g_TargetCret := target;
            nHitMsg := SearchLongHit(tdir);
            if (g_NewStatus = sNone) and
              ((target.m_btRace <> RCC_USERHUMAN) and
              (target.m_btRace <> RCC_GUARD) and
              (target.m_btRace <> 12) and // Guard
              (target.m_btRace <> 45) and // Archer
              (target.m_btRace <> RCC_MERCHANT) and
              (Pos('(', target.m_sUserName) = 0))
              or ((ssShift in Shift) or ((target.m_btRace <> RCC_MERCHANT)) and g_Config.boNotNeedShift) //SHIFT + 鼠标左键
              or (target.m_nNameColor = ENEMYCOLOR) or (GetRangeHit(nHitMsg) and IsInRangeLine(target.m_nCurrX, target.m_nCurrY, 4))
              then begin
              AttackTarget(target);
              g_dwLatestHitTick := GetTickCount;
            end;
          end;

        end else begin
          if (g_MySelf.m_btHorse = 0) and (not g_MySelf.m_boStartStore) {摆摊状态} and (g_NewStatus = sNone) then begin
            tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
            if CanNextAction and ServerAcceptNextAction and CanNextHit then begin

              nHitMsg := CM_HIT+Random(3);
              if g_boCanLongHit and TargetInSwordLongAttackRange(tdir) then begin
                nHitMsg := CM_LONGHIT;
              end;
              if g_boCanWideHit and (g_MySelf.m_Abil.MP >= 3) and TargetInSwordWideAttackRange(tdir) then begin
                nHitMsg := CM_WIDEHIT;
              end;
              if g_boCanCrsHit and (g_MySelf.m_Abil.MP >= 6) and TargetInSwordCrsAttackRange(tdir) then begin
                nHitMsg := CM_CRSHIT;
              end;

              g_MySelf.SendMsg(nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
            end;
            g_dwLastAttackTick := GetTickCount;
          end;
        end;
      end else begin
        if g_MySelf.m_boStartStore {摆摊状态} then Exit;
        //            if (MCX = Myself.XX) and (MCY = Myself.m_nCurrY) then begin
        if (g_nMouseCurrX = (g_MySelf.m_nCurrX)) and (g_nMouseCurrY = (g_MySelf.m_nCurrY)) then begin
          tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
          if CanNextAction and ServerAcceptNextAction then begin
            SendPickup; //捡物品
          end;
        end else
          if g_ServerConfig.boChgSpeed then begin
          //dwMoveTime := g_Config.dwMoveTime;
          dwMoveTime := 1000 - Trunc((g_MySelf.m_Abil.MoveSpeed * 1000) / 100);
        end else begin
          dwMoveTime := 1000;
        end;
        if GetTickCount - g_dwLastAttackTick > dwMoveTime then begin //最后攻击操作停留指定时间才能移动
          if ssCtrl in Shift then begin
            if g_MySelf.m_btHorse = 0 then begin
              g_ChrAction := caRun;
            end else begin
              g_ChrAction := caHorseRun;
            end;
          end else begin
            g_ChrAction := caWalk;
          end;
          g_nTargetX := g_nMouseCurrX;
          g_nTargetY := g_nMouseCurrY;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain._DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  tdir, nX, nY, nHitMsg, sel: Integer;
  target: TActor;
  dwMoveTime: LongWord;
begin
  ActionKey := 0;
  g_nMouseX := X;
  g_nMouseY := Y;
  g_boAutoDig := False;
  if (Button = mbRight) and g_boItemMoving then begin //是否当前在移动物品
    FrmDlg.CancelItemMoving;
    Exit;
  end;
  if DWinMan.MouseDown(Button, Shift, X, Y) then begin
    Exit; //鼠标移到窗口上了则跳过
  end;

  LegendMap.Stop;

  DXDrawMouseDown_(Button, Shift, X, Y);
end;

procedure TfrmMain.DXDrawDblClick(Sender: TObject);
var
  pt: TPoint;
begin
  GetCursorPos(pt);
  pt := ScreenToClient(pt);
  DWinMan.DblClick(pt.X, pt.Y);
end;

function TfrmMain.CheckDoorAction(dx, dy: Integer): Boolean;
var
  nX, nY, ndir, door: Integer;
begin
  Result := False;
  //if not Map.CanMove (dx, dy) then begin
     //if (Abs(dx-Myself.XX) <= 2) and (Abs(dy-Myself.m_nCurrY) <= 2) then begin
  door := Map.GetDoor(dx, dy);
  if door > 0 then begin
    if not Map.IsDoorOpen(dx, dy) then begin
      SendClientMessage(CM_OPENDOOR, door, dx, dy, 0);
      Result := True;
    end;
  end;
  //end;
//end;
end;

procedure TfrmMain.DXDrawMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pt: TPoint;
begin
 // GetCursorPos(pt);
 // pt := ScreenToClient(pt);
  //DWinMan.MouseUp(Button, Shift, pt.X, pt.Y);
  //if g_DWinMan.MouseUp(Button, Shift, X, Y) then Exit;
  DWinMan.MouseUp(Button, Shift, X, Y);
  g_nTargetX := -1;
end;

procedure TfrmMain.DXDrawClick(Sender: TObject);
var
  pt: TPoint;
begin
  GetCursorPos(pt);
  pt := ScreenToClient(pt);
  DWinMan.Click(pt.X, pt.Y);
end;

procedure TfrmMain.MouseTimerTimer(Sender: TObject);
var
  I: Integer;
  pt: TPoint;
  keyvalue: TKeyBoardState;
  Shift: TShiftState;
  pm: PTClientMagic;
  nX, nY: Integer;
begin
  GetCursorPos(pt);
  SetCursorPos(pt.X, pt.Y);

  if g_NewStatus > sNone then begin
    g_TargetCret := nil;
  end;

  if (g_MySelf <> nil) and (not g_MySelf.m_boDeath) then begin
    if g_NewStatus = sConfusion then begin //混乱状态
      if GetTickCount - g_dwConfusionTick > 400 then begin
        g_dwConfusionTick := GetTickCount;
        if Random(10) = 0 then begin
          nX := g_nNewStatusX + Random(2);
        end else begin
          nX := g_nNewStatusX - Random(2);
        end;
        if Random(10) = 0 then begin
          nY := g_nNewStatusY + Random(2);
        end else begin
          nY := g_nNewStatusY - Random(2);
        end;
        if PlayScene.CanWalk(nX, nY) then begin
          if (abs(g_nNewStatusX - nX) <= 2) and (abs(g_nNewStatusY - nY) <= 2) then begin
            if (abs(g_MySelf.m_nCurrX - nX) <= 1) and (abs(g_MySelf.m_nCurrY - nY) <= 1) then
              g_ChrAction := caWalk
            else g_ChrAction := caRun; //跑步砍
            g_nTargetX := nX;
            g_nTargetY := nY;
          end;
        end;
      end;
    end;
  end;

  if g_boSerieMagicing then begin
    if (g_NewStatus > sNone) then StopSerieMagic;
    if (g_SerieTarget <> nil) and PlayScene.IsValidActor(g_SerieTarget) and (not g_SerieTarget.m_boDeath) then begin
      if ActionKey > 0 then begin
        ProcessKeyMessages;
        StopSerieMagic;
      end else begin
        //DScreen.AddChatBoardString('g_boSerieMagicing:1', clyellow, clRed);
        if (GetTickCount - g_dwSerieMagicTick < 10000) then begin
          //DScreen.AddChatBoardString('g_boSerieMagicing:2', clyellow, clRed);
          if (g_nCurrenMagic >= CM_100HIT) and (g_nCurrenMagic <= CM_103HIT) then begin
            //DScreen.AddChatBoardString('g_boSerieMagicing:3', clyellow, clRed);
            //FillChar(keyvalue, SizeOf(TKeyBoardState), #0);
            //if GetKeyboardState(keyvalue) then begin
            //  Shift := [];
             // if ((keyvalue[VK_SHIFT] and $80) <> 0) then Shift := Shift + [ssShift];
             // if ((g_SerieTarget.m_btRace <> RCC_USERHUMAN) and
              //  (g_SerieTarget.m_btRace <> RCC_GUARD) and
              //  (g_SerieTarget.m_btRace <> RCC_MERCHANT) and
              //  (Pos('(', g_SerieTarget.m_sUserName) = 0)
              //  )
              //  or (g_SerieTarget.m_nNameColor = ENEMYCOLOR) //or ((ssShift in Shift) or (target.m_btRace <> RCC_MERCHANT and g_boNeedShift))
              //  or (((ssShift in Shift) or ((g_TargetCret.m_btRace <> RCC_MERCHANT) and g_Config.boNotNeedShift)) {and (not PlayScene.EdChat.Visible)}) then begin
            AttackTarget(g_SerieTarget);
              //end;
            //end;
          end;
        end else begin
          //DScreen.AddChatBoardString('g_boSerieMagicing:4', clyellow, clRed);
          StopSerieMagic;
        end;
      end;
    end else begin
      StopSerieMagic;
    end;
  end else begin
    if g_TargetCret <> nil then begin
      if ActionKey > 0 then begin
        ProcessKeyMessages;
      end else begin
        if not g_boSerieMagicing then begin
          if (g_NewStatus = sNone) and (not g_TargetCret.m_boDeath) and PlayScene.IsValidActor(g_TargetCret) then begin
            FillChar(keyvalue, SizeOf(TKeyBoardState), #0);
            if GetKeyboardState(keyvalue) then begin
              Shift := [];
              if ((keyvalue[VK_SHIFT] and $80) <> 0) then Shift := Shift + [ssShift];
              if ((g_TargetCret.m_btRace <> RCC_USERHUMAN) and
                (g_TargetCret.m_btRace <> RCC_GUARD) and
                (g_TargetCret.m_btRace <> 12) and  // Guard
                (g_TargetCret.m_btRace <> 45) and // Archer
                (g_TargetCret.m_btRace <> RCC_MERCHANT) and
                (Pos('(', g_TargetCret.m_sUserName) = 0) //
                )
                or (g_TargetCret.m_nNameColor = ENEMYCOLOR) //or ((ssShift in Shift) or (target.m_btRace <> RCC_MERCHANT and g_boNeedShift))
                or (((ssShift in Shift) or ((g_TargetCret.m_btRace <> RCC_MERCHANT) and g_Config.boNotNeedShift)) {and (not PlayScene.EdChat.Visible)}) then begin
                AttackTarget(g_TargetCret);
              end; //else begin
          //TargetCret := nil;
       //end
            end;
          end else g_TargetCret := nil;
        end;
      end;
    end;
  end;

  if (g_MySelf <> nil) and (not g_MySelf.m_boDeath) then begin
    if g_boAutoDig then begin
      if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
        g_MySelf.SendMsg(CM_HIT + 1, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_MySelf.m_btDir, 0, 0, '', 0);
      end;
    end;

    //自动烈火
    if g_Config.boSmartFireHit and (GetTickCount - g_dwAutoFireTick > 1000 * 3) and (g_MySelf.m_Abil.MP >= 7) and (not g_boNextTimeFireHit) and (GetTickCount - g_dwLatestFireHitTick >= g_ServerConfig.nFireDelayTime) then begin
      g_dwAutoFireTick := GetTickCount;
      pm := FindMagic(26);
      if pm <> nil then begin
          {if not IsWarrSkill(pm.Def.wMagicId) then begin
            if (g_MySelf.m_btHorse > 0) and g_Config.boAutoHorse then SendOnHorse();
          end;}

        UseMagic(g_nMouseX, g_nMouseY, pm);
        ActionKey := 0;
        g_nTargetX := -1;
      end;
    end;
    //自动开天
    if g_Config.boSmartKaitHit and (GetTickCount - g_dwAutoKTZTick > 1000 * 3) and (g_MySelf.m_Abil.MP >= 7) and (not g_boNextTimeKTZHit) and (GetTickCount - g_dwLatestKTZHitTick >= g_ServerConfig.nKTZDelayTime) then begin
      g_dwAutoKTZTick := GetTickCount;
      pm := FindMagic(58);
      if pm <> nil then begin
      //if TargetInKTZAttackRange(g_MySelf.m_btDir) then begin
        UseMagic(g_nMouseX, g_nMouseY, pm);
        ActionKey := 0;
        g_nTargetX := -1;
      //end;
      end;
    end;
    //自动破空剑
    if g_Config.boSmartPokHit and (GetTickCount - g_dwAutoPKJTick > 1000 * 3) and (g_MySelf.m_Abil.MP >= 7) and (not g_boNextTimePKJHit) and (GetTickCount - g_dwLatestPKJHitTick >= g_ServerConfig.nPKJDelayTime) then begin
      g_dwAutoPKJTick := GetTickCount;
      pm := FindMagic(43);
      if pm <> nil then begin
      //if TargetInKTZAttackRange(g_MySelf.m_btDir) then begin
        UseMagic(g_nMouseX, g_nMouseY, pm);
        ActionKey := 0;
        g_nTargetX := -1;
      //end;
      end;
    end;
    //自动破空剑
    {if g_Config.boSmartPokHit and (GetTickCount - g_dwAutoPKJTick > 1000 * 3) and (g_MySelf.m_Abil.MP >= 7) and (not g_boNextTimePKJHit) and (GetTickCount - g_dwLatestPKJHitTick >= g_ServerConfig.nPKJDelayTime) then begin
      g_dwAutoPKJTick := GetTickCount;
      pm := FindMagic(43);
      if pm <> nil then begin
      //if TargetInKTZAttackRange(g_MySelf.m_btDir) then begin
        UseMagic(g_nMouseX, g_nMouseY, pm);
        ActionKey := 0;
        g_nTargetX := -1;
      //end;
      end;
    end;}
    //自动逐日剑法
    if g_Config.boSmartSwordHit and (GetTickCount - g_dwAutoZRJFTick > 1000 * 3) and (g_MySelf.m_Abil.MP >= 7) and (not g_boNextTimeZRJFHit) and (GetTickCount - g_dwLatestZRJFHitTick >= g_ServerConfig.nZRJFDelayTime) then begin
      g_dwAutoZRJFTick := GetTickCount;
      pm := FindMagic(77);
      if pm <> nil then begin
      //if TargetInKTZAttackRange(g_MySelf.m_btDir) then begin
        UseMagic(g_nMouseX, g_nMouseY, pm);
        ActionKey := 0;
        g_nTargetX := -1;
      //end;
      end;
    end;

    if g_Config.boSmartShield and ((g_MySelf.m_nState and $00100000) = 0) then begin //智能盾
      pm := FindMagic(31);
      if pm <> nil then begin
        if not IsWarrSkill(pm.Def.wMagicId) then begin
          if (g_MySelf.m_btHorse > 0) and g_Config.boAutoHorse then SendOnHorse();
        end;
        if pm.Def.wSpell + pm.Def.btDefSpell <= g_MySelf.m_Abil.MP then begin
          UseMagic(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, pm);
        end;
      end;
    end;

//动自练功
    if g_Config.boAutoUseMagic and (ActionKey = 0) then begin
      if (g_Config.nAutoUseMagicIdx >= 0) and (g_Config.nAutoUseMagicIdx < FrmDlg.DComboboxAutoUseMagic.Items.Count) then begin
        if GetTickCount - g_Config.dwAutoUseMagicTick > g_Config.nAutoUseMagicTime * 1000 then begin
          g_Config.dwAutoUseMagicTick := GetTickCount;
          PlayScene.ScreenXYfromMCXY(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, nX, nY);
          pm := PTClientMagic(FrmDlg.DComboboxAutoUseMagic.Items.Objects[g_Config.nAutoUseMagicIdx]);
          if not IsWarrSkill(pm.Def.wMagicId) then begin
            if (g_MySelf.m_btHorse > 0) and g_Config.boAutoHorse then SendOnHorse();
          end;
          UseMagic(nX, nY, PTClientMagic(FrmDlg.DComboboxAutoUseMagic.Items.Objects[g_Config.nAutoUseMagicIdx]));
        end;
      end;
    end;

//智能无极真气
    if g_Config.boSmartWjzq and (GetTickCount - g_Config.dwSmartWjzqTick > g_ServerConfig.nSkill50DelayTime) then begin
      g_Config.dwSmartWjzqTick := GetTickCount;
      pm := FindMagic(50);
      if pm <> nil then begin
        if not IsWarrSkill(pm.Def.wMagicId) then begin
          if (g_MySelf.m_btHorse > 0) and g_Config.boAutoHorse then SendOnHorse();
        end;
        if pm.Def.wSpell + pm.Def.btDefSpell <= g_MySelf.m_Abil.MP then begin
          UseMagic(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, pm);
        end;
      end;
    end;
  end;
  if g_NewStatus = sNone then g_GuaJi.Run;
end;

procedure TfrmMain.WaitMsgTimerTimer(Sender: TObject);
begin
  if g_MySelf = nil then Exit;
  if g_MySelf.ActionFinished then begin
    StopSerieMagic;
    WaitMsgTimer.Enabled := False;
    //      PlayScene.MemoLog.Lines.Add('WaitingMsg: ' + IntToStr(WaitingMsg.Ident));
    case WaitingMsg.ident of
      SM_CHANGEMAP: begin
          LegendMap.Stop; //停止寻路

          g_boMapMovingWait := False;
          g_boMapMoving := False;
          //
          if g_nMDlgX <> -1 then begin
            FrmDlg.CloseMDlg;
            FrmDlg.CloseBigMDlg;
            g_nMDlgX := -1;
          end;

          {g_WMagicImages.ClearCache;
          g_WMagic2Images.ClearCache;
          g_WMagic3Images.ClearCache;
          g_WMagic4Images.ClearCache;
          g_WMagic5Images.ClearCache;
          g_WMagic6Images.ClearCache;
          g_WHumImgImages.ClearCache;
          g_WWeaponImages.ClearCache;
          g_WHumWingImages.ClearCache;
          ObjectsClearCache;
          g_WMonImages.ClearCache;}

          ClearDropItems;
          PlayScene.CleanObjects;

          g_sMapTitle := '';
          g_MySelf.CleanCharMapSetting(WaitingMsg.param, WaitingMsg.tag);
          PlayScene.SendMsg(SM_CHANGEMAP, 0,
            WaitingMsg.param {x},
            WaitingMsg.tag {y},
            WaitingMsg.series {darkness},
            0, 0,
            WaitingStr {mapname});

          //DScreen.AddSysMsg (IntToStr(WaitingMsg.Param) + ' ' +
          //                   IntToStr(WaitingMsg.Tag) + ' : My ' +
          //                   IntToStr(Myself.XX) + ' ' +
          //                   IntToStr(Myself.m_nCurrY) + ' ' +
          //                   IntToStr(Myself.RX) + ' ' +
          //                   IntToStr(Myself.RY) + ' '
          //                  );
          g_nTargetX := -1;
          g_TargetCret := nil;
          g_FocusCret := nil;

        end;
    end;
  end;
end;

{----------------------- Socket -----------------------}

procedure TfrmMain.SelChrWaitTimerTimer(Sender: TObject);
begin
  SelChrWaitTimer.Enabled := False;
  SendQueryChr;
end;

procedure TfrmMain.ActiveCmdTimer(cmd: TTimerCommand);
begin
  CmdTimer.Enabled := True;
  TimerCmd := cmd;
end;

procedure TfrmMain.CmdTimerTimer(Sender: TObject);
begin
  CmdTimer.Enabled := False;
  CmdTimer.Interval := 2000;

  case TimerCmd of
    tcSoftClose: begin
        CmdTimer.Enabled := False;
        CSocket.Socket.Close;

      end;
    tcReSelConnect: begin
        // try
//            PlayScene.MemoLog.Lines.Add('ConnectionStep -1');
         //霸烙 函荐 檬扁拳...
        ResetGameVariables;
        //            PlayScene.MemoLog.Lines.Add('ConnectionStep -2');
                    //
        DScreen.ChangeScene(stSelectChr);
        //            PlayScene.MemoLog.Lines.Add('ConnectionStep -3');
        g_ConnectionStep := cnsReSelChr;
        {
        except
          on e: Exception do
          PlayScene.MemoLog.Lines.Add(e.Message);
        end;
        }
//            if ConnectionStep = cnsReSelChr then
//              PlayScene.MemoLog.Lines.Add('ConnectionStep -cnsReSelChr');
        if not BoOneClick then begin
          //showmessage('not BoOneClick');
          //               PlayScene.MemoLog.Lines.Add('cnsReSelChr -' +  SelChrAddr + '/' + IntToStr(SelChrPort) );
          with CSocket do begin
            Active := False;
            ClientType := ctNonBlocking;
            Address := g_sSelChrAddr;
            Port := g_nSelChrPort;
            Active := True;
          end;
        end else begin

          if CSocket.Socket.Connected then
            CSocket.Socket.SendText('$S' + g_sSelChrAddr + '/' + IntToStr(g_nSelChrPort) + '%');

          CmdTimer.Interval := 1;
          ActiveCmdTimer(tcFastQueryChr);
        end;
      end;
    tcFastQueryChr: begin
        SendQueryChr;
      end;
  end;
end;

procedure TfrmMain.CloseAllWindows;
begin
  with FrmDlg do begin
    DItemBag.Visible := False;
    DMsgDlg.Visible := False;
    DStateWin.Visible := False;
    DMerchantDlg.Visible := False;
    DMerchantBigDlg.Visible := False;
    DSellDlg.Visible := False;
    DMenuDlg.Visible := False;
    DKeySelDlg.Visible := False;
    DGroupDlg.Visible := False;
    DDealDlg.Visible := False;
    DDealRemoteDlg.Visible := False;
    DGuildDlg.Visible := False;
    DGuildEditNotice.Visible := False;
    DUserState1.Visible := False;
    DAdjustAbility.Visible := False;
    DShop.Visible := False;
    DHeroStateWin.Visible := False;
    DHeroHealthStateWin.Visible := False;
    DHeroItemBag.Visible := False;
    DBoxItems.Visible := False;
    DItemBox.Visible := False;
    CloseSellOffDlg;
    DBook.Visible := False;
    DConfigDlg.Visible := False;
    DMiniMap.Visible := False;
    if g_ConfigClient.btMainInterface = 1 then begin
      SetChatVisible(False);
      SetInputVisible(False);
      SetButVisible(False);
      DMapTitle.Visible := False;
    end;
    CloseStoreDlg;
    CloseUserStoreDlg;
    DStoreMsgDlg.Visible := False;
    DUpgrade.Visible := False;
    DComboboxGuajiQunti.Items.Clear;
    DComboboxGuajiGeti.Items.Clear;
    DComboboxAutoUseMagic.Items.Clear;
    DSerieMagicMenu.Clear;

    DCheckBoxShowMoveNumberLable.OnClick := nil;
    DCheckBoxOrderItem.OnClick := nil;
    DCheckBoxItemDuraHint.OnClick := nil;
    DCheckBoxMusic.OnClick := nil;

    DCheckBoxPickUpItemAll.OnClick := nil;
    DCheckBoxBook.OnClick := nil;

    DCheckBoxLongHit.OnClick := nil;
    DCheckBoxWideHit.OnClick := nil;
    DCheckBoxFireHit.OnClick := nil;
    DCheckBoxSWideHit.OnClick := nil;
    DCheckBoxCrsHit.OnClick := nil;
    DCheckBoxKtHit.OnClick := nil;
    DCheckBoxPok.OnClick := nil;
    DCheckBoxShield.OnClick := nil;
    DCheckBoxWjzq.OnClick := nil;
    DCheckBoxSmartWalkLongHit.OnClick := nil;
    DCheckBoxSmartPosLongHit.OnClick := nil;
    DCheckBoxStruckShield.OnClick := nil;
    DCheckBoxAutoHideSelf.OnClick := nil;
    DCheckBoxAutoUseMagic.OnClick := nil;
    DCheckBoxUseKey.OnClick := nil;
    DCheckBoxSign.OnClick := nil;
    DCheckBoxPoison.OnClick := nil;
    DCheckBoxGuaji.OnClick := nil;


    DEditBookHP.OnChange := nil;
    DEditBookTime.OnChange := nil;

    DEditAutoUseMagicTime.OnChange := nil;


    DCheckBoxHumHP1.OnClick := nil;
    DCheckBoxHumMP1.OnClick := nil;
    DCheckBoxHumHP2.OnClick := nil;
    DCheckBoxHumMP2.OnClick := nil;

    DCheckBoxHeroHP1.OnClick := nil;
    DCheckBoxHeroMP1.OnClick := nil;
    DCheckBoxHeroHP2.OnClick := nil;
    DCheckBoxHeroMP2.OnClick := nil;


    DEditHumHPPercent1.OnChange := nil;
    DEditHumMPPercent1.OnChange := nil;
    DEditHumHPPercent2.OnChange := nil;
    DEditHumMPPercent2.OnChange := nil;

    DEditHeroHPPercent1.OnChange := nil;
    DEditHeroMPPercent1.OnChange := nil;
    DEditHeroHPPercent2.OnChange := nil;
    DEditHeroMPPercent2.OnChange := nil;

    DEditHumHPTime1.OnChange := nil;
    DEditHumMPTime1.OnChange := nil;
    DEditHumHPTime2.OnChange := nil;
    DEditHumMPTime2.OnChange := nil;

    DEditHeroHPTime1.OnChange := nil;
    DEditHeroMPTime1.OnChange := nil;
    DEditHeroHPTime2.OnChange := nil;
    DEditHeroMPTime2.OnChange := nil;


    DComboboxHumHP1.OnChange := nil;
    DComboboxHumMP1.OnChange := nil;
    DComboboxHumHP2.OnChange := nil;
    DComboboxHumMP2.OnChange := nil;

    DComboboxHeroHP1.OnChange := nil;
    DComboboxHeroMP1.OnChange := nil;
    DComboboxHeroHP2.OnChange := nil;
    DComboboxHeroMP2.OnChange := nil;
  end;
  g_nServer_ClientTime := 0;
  FillCharBoxItems();
  if g_nMDlgX <> -1 then begin
    FrmDlg.CloseMDlg;
    FrmDlg.CloseBigMDlg;
    g_nMDlgX := -1;
  end;

  g_boItemMoving := False;
  g_MovingItem.Owner := nil;

  g_GuaJi.Started := False;
  g_QueryBagItem := q_QueryHum;
  g_boQueryHumBagItem := False;
  g_boQueryHeroBagItem := False;
  UnLoadCartInfoList;
  ClearMsg;
end;

procedure TfrmMain.ClearDropItems;
var
  I, II: Integer;
  List: TList;
  DropItem: pTDropItem;
begin
  g_DropedItemList.Lock;
  try
    for I := 0 to g_DropedItemList.Count - 1 do begin
      List := TList(g_DropedItemList.Items[I]);
      for II := 0 to List.Count - 1 do begin
        DropItem := List.Items[II];
        Dispose(DropItem);
      end;
      List.Free;
    end;
    g_DropedItemList.Clear;
  finally
    g_DropedItemList.UnLock;
  end;
end;

procedure TfrmMain.ResetGameVariables;
var
  I: Integer;
  ClientMagic: PTClientMagic;
begin
  try
    CloseAllWindows;
    ClearDropItems;
    for I := 0 to g_MagicList.Count - 1 do begin
      Dispose(PTClientMagic(g_MagicList[I]));
    end;
    g_MagicList.Clear;

    for I := 0 to g_HeroMagicList.Count - 1 do begin
      Dispose(PTClientMagic(g_HeroMagicList[I]));
    end;
    g_HeroMagicList.Clear;

    for I := 0 to g_SerieMagicList.Count - 1 do begin //连击
      Dispose(PTClientMagic(g_SerieMagicList[I]));
    end;
    g_SerieMagicList.Clear;


    g_boItemMoving := False;
    g_MovingItem.Owner := nil;

    g_WaitingUseItem.Item.S.Name := '';
    g_EatingItem.S.Name := '';
    g_HeroEatingItem.S.Name := '';
    g_nTargetX := -1;
    g_TargetCret := nil;
    g_FocusCret := nil;
    g_MagicTarget := nil;
    ActionLock := False;
    g_GroupMembers.Clear;
    g_sGuildRankName := '';
    g_sGuildName := '';

    g_boMapMoving := False;
    WaitMsgTimer.Enabled := False;
    g_boMapMovingWait := False;
    DScreen.ChatBoardTop := 0;
    g_boNextTimePowerHit := False;
    g_boCanLongHit := False;
    g_boCanWideHit := False;
    g_boCanCrsHit := False;
    g_boCanTwnHit := False;

    g_boNextTimeFireHit := False;
    g_boNextTimeKTZHit := False;
    g_boNextTimePKJHit := False;
    g_boNextTime60Hit := False;
    g_boNextTimeZRJFHit := False;

    SafeFillChar(g_UpgradeItems, SizeOf(TClientItem) * 3, #0);
    SafeFillChar(g_UpgradeItemsWait, SizeOf(TClientItem) * 3, #0);

    SafeFillChar(g_DuelDlgItem, SizeOf(TClientItem), #0);
    SafeFillChar(g_DuelItems, SizeOf(TClientItem) * 5, #0);
    SafeFillChar(g_DuelRemoteItems, SizeOf(TClientItem) * 5, #0);

    SafeFillChar(g_HeroUseItems, SizeOf(TClientItem) * 13, #0);
    SafeFillChar(g_HeroItemArr, SizeOf(TClientItem) * MAXHEROBAGITEM, #0);

    SafeFillChar(g_UseItems, SizeOf(TClientItem) * High(g_UseItems), #0);
    SafeFillChar(g_ItemArr, SizeOf(TClientItem) * MAXBAGITEMCL, #0);

    with SelectChrScene do begin
      SafeFillChar(ChrArr, SizeOf(TSelChar) * 2, #0);
      ChrArr[0].FreezeState := True;
      ChrArr[1].FreezeState := True;
    end;
    PlayScene.ClearActors;
    ClearDropItems;
    EventMan.ClearEvents;
    PlayScene.CleanObjects;
    //DxDrawRestoreSurface (self);
    g_MySelf := nil;
    g_MyHero := nil;
    SafeFillChar(g_StoreItems, SizeOf(TStoreItem) * 15, #0);
    SafeFillChar(g_StoreRemoteItems, SizeOf(TStoreItem) * 15, #0);
    SafeFillChar(g_DrawStoreItems, SizeOf(TDrawEffect) * 15, #0);
    SafeFillChar(g_DrawStoreItems_, SizeOf(TDrawEffect) * 15, #0);
    SafeFillChar(g_DrawStoreRemoteItems, SizeOf(TDrawEffect) * 15, #0);
    SafeFillChar(g_DrawStoreRemoteItems_, SizeOf(TDrawEffect) * 15, #0);

    SafeFillChar(g_SerieMagic, SizeOf(TSerieMagic) * 8, #0);
    g_SerieTarget := nil;
    g_boSerieMagic := False;
    g_boSerieMagicing := False;
    g_nSerieIndex := -1;
    g_dwSerieMagicTick := GetTickCount;
    g_SerieMagicingList.Clear;

    g_QueryBagItem := q_QueryHum;
    g_boQueryHumBagItem := False;
    g_boQueryHeroBagItem := False;
  except
    //  on e: Exception do
    //    PlayScene.MemoLog.Lines.Add(e.Message);
  end;
end;

procedure TfrmMain.ChangeServerClearGameVariables;
var
  I: Integer;
begin
  CloseAllWindows;
  ClearDropItems;
  for I := 0 to g_MagicList.Count - 1 do begin
    Dispose(PTClientMagic(g_MagicList[I]));
  end;
  g_MagicList.Clear;

  for I := 0 to g_HeroMagicList.Count - 1 do begin
    Dispose(PTClientMagic(g_HeroMagicList[I]));
  end;
  g_HeroMagicList.Clear;

  for I := 0 to g_SerieMagicList.Count - 1 do begin //连击
    Dispose(PTClientMagic(g_SerieMagicList[I]));
  end;
  g_SerieMagicList.Clear;

  g_boItemMoving := False;
  g_MovingItem.Owner := nil;

  g_WaitingUseItem.Item.S.Name := '';
  g_EatingItem.S.Name := '';
  g_HeroEatingItem.S.Name := '';
  g_nTargetX := -1;
  g_TargetCret := nil;
  g_FocusCret := nil;
  g_MagicTarget := nil;
  ActionLock := False;
  g_GroupMembers.Clear;
  g_sGuildRankName := '';
  g_sGuildName := '';

  g_boMapMoving := False;
  WaitMsgTimer.Enabled := False;
  g_boMapMovingWait := False;
  g_boNextTimePowerHit := False;
  g_boCanLongHit := False;
  g_boCanWideHit := False;
  g_boCanCrsHit := False;
  g_boCanTwnHit := False;

  g_boHumProtect := False;
  g_boHeroProtect := False;

  ClearDropItems;
  EventMan.ClearEvents;
  PlayScene.CleanObjects;
  ClearDate;
  ClearHeroDate;
  ClearUserDate;
end;

procedure TfrmMain.CSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  packet: array[0..255] of Char;
  strbuf: array[0..255] of Char;
  Str: string;
begin
  g_sSockText := '';
  g_sBufferText := '';
  if Assigned(g_PlugInfo.HookSocketConnect) then begin
    g_PlugInfo.HookSocketConnect();
  end;
  g_boServerConnected := True;
  if g_ConnectionStep = cnsStart then g_ConnectionStep := cnsLogin;

 { if g_ConnectionStep = cnsLogin then begin
    if OneClickMode = toKornetWorld then begin
      FillChar(packet, 256, #0);
      Str := 'KwGwMGS'; StrPCopy(strbuf, Str); Move(strbuf, (@packet[0])^, Length(Str));
      Str := 'CONNECT'; StrPCopy(strbuf, Str); Move(strbuf, (@packet[8])^, Length(Str));
      Str := KornetWorld.CPIPcode; StrPCopy(strbuf, Str); Move(strbuf, (@packet[16])^, Length(Str));
      Str := KornetWorld.SVCcode; StrPCopy(strbuf, Str); Move(strbuf, (@packet[32])^, Length(Str));
      Str := KornetWorld.LoginID; StrPCopy(strbuf, Str); Move(strbuf, (@packet[48])^, Length(Str));
      Str := KornetWorld.CheckSum; StrPCopy(strbuf, Str); Move(strbuf, (@packet[64])^, Length(Str));
      Socket.SendBuf(packet, 256);
    end;
    SendClientMessage(CM_QUERYSERVERNAME, 0, 0, 0, 0);
    DScreen.ChangeScene(stLogin);

    g_ProcessesList.Clear;
    if g_ConfigClient.sCheckProcessesUrl <> '' then begin
      HTTPGetCheckPro.URL := g_ConfigClient.sCheckProcessesUrl;
      HTTPGetCheckPro.GetString;
    end;
  end;  }
  if g_ConnectionStep = cnsSelChr then begin
    //SelChrWaitTimer.Enabled := True;
    CmdTimer.Interval := 1;
    ActiveCmdTimer(tcFastQueryChr);
    g_boGetRandomBuffer := True;
    SendGetRandomBuffer();
    LoginScene.OpenLoginDoor;
  end;
  if g_ConnectionStep = cnsReSelChr then begin
    CmdTimer.Interval := 1;
    ActiveCmdTimer(tcFastQueryChr);

    with FrmDlg.DscStart do begin
      Enabled := False;
      g_ClientRect := Bounds(SurfaceX(Left), SurfaceY(Top), Width, Height);
    end;
    g_dwReSelConnectTick := GetTickCount + 500;
    g_boReSelConnect := True;
  end;
  if g_ConnectionStep = cnsPlay then begin
    if not g_boServerChanging then begin
      ClearBag;
      DScreen.ClearChatBoard;
      DScreen.ChangeScene(stLoginNotice);
    end else begin
      ChangeServerClearGameVariables;
    end;
    SendRunLogin;
    //Showmessage('SendRunLogin');
   // DScreen.AddChatBoardString('SendRunLogin', clRed, clBlue);
  end;
end;

procedure TfrmMain.CSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  g_boServerConnected := False;
  if (g_ConnectionStep in [cnsStart, cnsLogin]) and (not g_boSendLogin) then begin
    if not g_boShowVersionBmp then begin
      FrmDlg.DMessageDlg('连接已经关闭...', [mbOk]);
      Close;
    end;
  end;
  if g_SoftClosed then begin
    g_SoftClosed := False;
    ActiveCmdTimer(tcReSelConnect);
  end;
end;

procedure TfrmMain.CSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;

procedure TfrmMain.CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
  n: Integer;
  Data, data2: string;
begin
  Data := Socket.ReceiveText;
  n := Pos('*', Data);
  if n > 0 then begin
    data2 := Copy(Data, 1, n - 1);
    Data := data2 + Copy(Data, n + 1, Length(Data));
    CSocket.Socket.SendText('*');
  end;
  //DebugOutStr('data:'+IntToStr(Length(data)));
  if Assigned(g_PlugInfo.HookSocketRead) then begin
    if g_PlugInfo.HookSocketRead(PChar(Data), Length(Data)) then Exit;
  end;
{  EnterCriticalSection(g_UserCriticalSection);
  try }
  g_sSockText := g_sSockText + Data;
 { finally
    LeaveCriticalSection(g_UserCriticalSection);
  end; }
end;

{-------------------------------------------------------------}

procedure TfrmMain.SendSocket(sendstr: string);
var
  sSendText: string;
begin
  if CSocket.Socket.Connected then begin
    if Assigned(g_PlugInfo.HookSendSocket) then begin
      if g_PlugInfo.HookSendSocket(PChar(sendstr), Length(sendstr)) then Exit;
    end;
    CSocket.Socket.SendText('#' + IntToStr(Code) + sendstr + '!');
    Inc(Code);
    if Code >= 10 then Code := 1;
  end;
end;
//发送验证码

procedure TfrmMain.SendRandomCode(sCode: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SENDRANDOMCODE, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(sCode));
end;

procedure TfrmMain.SendGetRandomBuffer();
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_QUERYRANDOMCODE, 0, DXDraw.Surface.BitCount, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

//挑战相关

procedure TfrmMain.SendCancelDuel;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DUELCANCEL, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendAddDuelItem(ci: TClientItem);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DUELADDITEM, ci.MakeIndex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(ci.S.Name));
end;

procedure TfrmMain.SendDelDuelItem(ci: TClientItem);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DUELDELITEM, ci.MakeIndex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(ci.S.Name));
end;

procedure TfrmMain.SendChangeDuelGold(gold: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DUELCHGGOLD, gold, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
  //DScreen.AddChatBoardString('frmMain.SendChangeDuelGold: ' + IntToStr(gold), clWhite, clPurple);
end;

procedure TfrmMain.SendDuelEnd;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DUELEND, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendOnHorse();
begin
  SendClientMessage(CM_ONHORSE, 0, 0, 0, 0);
end;

procedure TfrmMain.SendFindUserItem(nWho: Integer; sData: string); //查询装备信息2008-3-5
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SENDFINDITEMINFO, nWho, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(sData));
end;


procedure TfrmMain.SendClientMessage(Msg, Recog, param, tag, series: Integer);
var
  dmsg: TDefaultMessage;
begin
  dmsg := MakeDefaultMsg(Msg, Recog, param, tag, series);
  SendSocket(EncodeMessage(dmsg));
end;

procedure TfrmMain.SendLogin(uid, passwd: string);
var
  Msg: TDefaultMessage;
begin
  LoginID := uid;
  LoginPasswd := passwd;
  Msg := MakeDefaultMsg(CM_IDPASSWORD, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(uid + '/' + passwd));
  g_boSendLogin := True; //发送登录消息
end;

procedure TfrmMain.SendGetRandomCode;
var
  Msg: TDefaultMessage;
begin
  //g_nRandomCode := 0;
  //g_sRandomCode := '0';
  Msg := MakeDefaultMsg(CM_RANDOMCODE, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendNewAccount(ue: TUserEntry; ua: TUserEntryAdd);
var
  Msg: TDefaultMessage;
begin
  MakeNewId := ue.sAccount;
  Msg := MakeDefaultMsg(CM_ADDNEWUSER, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeBuffer(@ue, SizeOf(TUserEntry)) + EncodeBuffer(@ua, SizeOf(TUserEntryAdd)));
end;

procedure TfrmMain.SendUpdateAccount(ue: TUserEntry; ua: TUserEntryAdd);
var
  Msg: TDefaultMessage;
begin
  MakeNewId := ue.sAccount;
  Msg := MakeDefaultMsg(CM_UPDATEUSER, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeBuffer(@ue, SizeOf(TUserEntry)) + EncodeBuffer(@ua, SizeOf(TUserEntryAdd)));
end;

procedure TfrmMain.SendSelectServer(svname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SELECTSERVER, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(svname));
end;

procedure TfrmMain.SendChgPw(id, passwd, newpasswd: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_CHANGEPASSWORD, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(id + #9 + passwd + #9 + newpasswd));
end;

procedure TfrmMain.SendNewChr(uid, uname, shair, sjob, ssex: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_NEWCHR, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(uid + '/' + uname + '/' + shair + '/' + sjob + '/' + ssex));
end;

procedure TfrmMain.SendQueryChr;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_QUERYCHR, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(LoginID + '/' + IntToStr(Certification)));
end;

procedure TfrmMain.SendDelChr(chrname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DELCHR, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(chrname));
end;

procedure TfrmMain.SendSelChr(chrname: string);
var
  Msg: TDefaultMessage;
begin
  g_sSelChrName := chrname;
  Msg := MakeDefaultMsg(CM_SELCHR, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(LoginID + '/' + chrname));
  PlayScene.EdAccountt.Visible := False; //2004/05/17
  PlayScene.EdChrNamet.Visible := False; //2004/05/17
end;

procedure TfrmMain.SendQueryDelChr(uid: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_QUERYDELCHR, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(uid));
end;

procedure TfrmMain.SendRestoreSelChr(uid, uname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_RESTORECHR, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(uid + '/' + uname));
end;

procedure TfrmMain.SendRunLogin;
var
  sSendMsg: string;
begin
  sSendMsg := Format('**%s/%s/%d/%d/%d/%d', [LoginID, g_sSelChrName, Certification xor $3EB2C5CC, Certification xor $54B163FD, CLIENT_VERSION_NUMBER, RUNLOGINCODE]);
  SendSocket(EncodeString(sSendMsg));
end;

procedure TfrmMain.AutoSendSay();
begin
  if g_MySelf = nil then Exit;
  if GetTickCount - g_dwAutoShowMsgTick > 1000 * 60 then begin
    g_dwAutoShowMsgTick := GetTickCount;
    if g_sAutoShowMsg <> '' then begin
      SendSay(g_sAutoShowMsg);
    end;
  end;
end;

procedure TfrmMain.SendSay(Str: string);
var
  Msg: TDefaultMessage;
begin
  if Str <> '' then begin
    if m_boPasswordIntputStatus then begin
      m_boPasswordIntputStatus := False;
      FrmDlg.EdChat.PasswordChar := #0;
      FrmDlg.EdChat.Visible := False;
      SendPassword(Str, 1);
      Exit;
    end;
    if CompareLstr(Str, '/cmd', Length('/cmd')) then begin
      ProcessCommand(Str);
      Exit;
    end;
    if Str = '/debug' then begin
      boOutbugStr := not boOutbugStr;
      Exit;
    end;
    if Str = '/debug check' then begin
      g_boShowMemoLog := not g_boShowMemoLog;
      PlayScene.MemoLog.Clear;
      PlayScene.MemoLog.Visible := g_boShowMemoLog;
      Exit;
    end;
    if Str = '/debug powerblock' then begin
      SendPowerBlock();
      Exit;
    end;
    if Str = '/debug screen' then begin
      g_boCheckBadMapMode := not g_boCheckBadMapMode;
      if g_boCheckBadMapMode then DScreen.AddSysMsg('On', 30, 40, clAqua)
      else DScreen.AddSysMsg('Off', 30, 40, clAqua); //是否显示相关检查地图信息(用于调试)
      Exit;
    end;
    if Str = '/check speedhack' then begin
      g_boCheckSpeedHackDisplay := not g_boCheckSpeedHackDisplay;
      Exit; //是否显示机器速度
    end;
    if Str = '/hungry' then begin
      Inc(g_nMyHungryState); //饥饿状态
      if g_nMyHungryState > 4 then g_nMyHungryState := 1;

      Exit;
    end;
    if Str = '/hint screen' then begin
      g_boShowWhiteHint := not g_boShowWhiteHint;
      Exit;
    end;

    if Str = '@password' then begin
      if FrmDlg.EdChat.PasswordChar = #0 then
        FrmDlg.EdChat.PasswordChar := '*'
      else FrmDlg.EdChat.PasswordChar := #0;
      Exit;
    end;
    if FrmDlg.EdChat.PasswordChar = '*' then
      FrmDlg.EdChat.PasswordChar := #0;

    Msg := MakeDefaultMsg(CM_SAY, 0, 0, 0, 0);
    if Str[1] = '/' then
      Msg := MakeDefaultMsg(CM_SAY, 1, MakeWord(g_Config.btHearMsgFColor, g_btWhisperMsgFColor), 0, 0);
    if (Str[1] <> '@') and (Str[1] <> '/') and (Str[1] <> '!') and (Str[1] <> '~') then
      Msg := MakeDefaultMsg(CM_SAY, 1, MakeWord(g_Config.btHearMsgFColor, g_btWhisperMsgFColor), 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(Str));
    if Str[1] = '/' then begin
      DScreen.AddChatBoardString(Str, GetRGB(g_btWhisperMsgFColor) {GetRGB(180)}, clWhite);
      GetValidStr3(Copy(Str, 2, Length(Str) - 1), WhisperName, [' ']);
    end;
  end;
end;

procedure TfrmMain.SendUpgradeItem(UpgradeItemIndexs: TUpgradeItemIndexs);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SENDUPGRADEITEM, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeBuffer(@UpgradeItemIndexs, SizeOf(TUpgradeItemIndexs)));
end;

procedure TfrmMain.SendOpenBox(sName: string; nItemServerIndex: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_OPENITEMBOX, nItemServerIndex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(sName));
end;

procedure TfrmMain.SendGetSellItemGold(nItemServerIndex: Integer; sItemName: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SENDGETSELLITEMGOLD, 0, LoWord(nItemServerIndex), HiWord(nItemServerIndex), 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(sItemName));
end;

procedure TfrmMain.SendBuySellItem(nItemServerIndex: Integer; sItemName: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SENDBUYSELLOFFITEM, 0, LoWord(nItemServerIndex), HiWord(nItemServerIndex), 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(sItemName));
end;

procedure TfrmMain.SendQuerySellItems(nType, nPage: Integer; sItemName: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SENDSELLOFFGOODSLIST, nType, nPage, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(sItemName));
end;

procedure TfrmMain.SendSearchSellItems(sItemName: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SENDSEARCHSELLITEM, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(sItemName));
end;

procedure TfrmMain.SendActMsg(ident, X, Y, dir: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(ident, MakeLong(X, Y), 0, dir, 0);
  SendSocket(EncodeMessage(Msg));
  ActionLock := True;
  ActionLockTime := GetTickCount;
  Inc(g_nSendCount);
end;

procedure TfrmMain.SendSpellMsg(ident, X, Y, dir, target: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(ident, MakeLong(X, Y), LoWord(target), dir, HiWord(target));
  SendSocket(EncodeMessage(Msg));
  ActionLock := True;
  ActionLockTime := GetTickCount;
  Inc(g_nSendCount);
end;

procedure TfrmMain.SendQueryUserName(targetid, X, Y: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_QUERYUSERNAME, targetid, X, Y, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendHeroMagicKeyChange(magid: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_HEROMAGICKEYCHANGE, magid, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendHeroDropItem(Name: string; itemserverindex: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_HERODROPITEM, itemserverindex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(Name));
end;

procedure TfrmMain.SendDropItem(Name: string; itemserverindex: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DROPITEM, itemserverindex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(Name));
end;

procedure TfrmMain.SendPickup;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_PICKUP, 0, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendTakeOnItemFromMasterBag(where: Byte; itmindex: Integer; itmname: string); //从主人包裹穿装备
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_HEROTAKEONITEMFROMMASTER, itmindex, where, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itmname));
end;

procedure TfrmMain.SendTakeOnItemFromHeroBag(where: Byte; itmindex: Integer; itmname: string); //从英雄包裹穿装备
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_TAKEONITEMFROMHERO, itmindex, where, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itmname));
end;

procedure TfrmMain.SendTakeOnItem(where: Byte; itmindex: Integer; itmname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_TAKEONITEM, itmindex, where, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itmname));
end;

procedure TfrmMain.SendTakeOffItem(where: Byte; itmindex: Integer; itmname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_TAKEOFFITEM, itmindex, where, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itmname));
end;

procedure TfrmMain.SendTakeOffItemToHeroBag(where: Byte; itmindex: Integer; itmname: string); //装备脱下到英雄包裹
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_TAKEOFFITEMTOHERO, itmindex, where, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itmname));
end;

procedure TfrmMain.SendTakeOffItemToMasterBag(where: Byte; itmindex: Integer; itmname: string); //装备脱下到主人包裹
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_HEROTAKEOFFITEMTOMASTER, itmindex, where, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itmname));
end;

procedure TfrmMain.SendItemToMasterBag(where: Byte; itmindex: Integer; itmname: string); //英雄包裹到主人包裹
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_HEROBAGTOMASTERBAG, itmindex, where, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itmname));
end;

procedure TfrmMain.SendItemToHeroBag(where: Byte; itmindex: Integer; itmname: string); //主人包裹到英雄包裹
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_MASTERBAGTOHEROBAG, itmindex, where, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itmname));
end;

//英雄

procedure TfrmMain.SendHeroTakeOnItem(where: Byte; itmindex: Integer; itmname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_HEROTAKEONITEM, itmindex, where, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itmname));
end;

procedure TfrmMain.SendHeroTakeOffItem(where: Byte; itmindex: Integer; itmname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_HEROTAKEOFFITEM, itmindex, where, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itmname));
end;
//修理火龙之心

procedure TfrmMain.SendRepairFirDragon(nType: Byte; itmindex: Integer; itmname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_REPAIRFIRDRAGON, itmindex, nType, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itmname));
end;

//吃东西

procedure TfrmMain.SendEat(itmindex: Integer; itmname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_EAT, itmindex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itmname));
end;

//英雄吃东西

procedure TfrmMain.SendHeroEat(itmindex: Integer; itmname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_HEROEAT, itmindex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itmname));
end;

//宰杀动物

procedure TfrmMain.SendButchAnimal(X, Y, dir, actorid: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_BUTCH, actorid, X, Y, dir);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendMagicKeyChange(magid: Integer; keych: Char);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_MAGICKEYCHANGE, magid, Byte(keych), 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendMerchantDlgSelect(merchant: Integer; rstr: string);
var
  Msg: TDefaultMessage;
  param: string;
begin
  if Length(rstr) >= 2 then begin
    if (rstr[1] = '@') and (rstr[2] = '@') then begin
      if rstr = '@@buildguildnow' then
        FrmDlg.DMessageDlg('请输入行会名称.', [mbOk, mbAbort])
      else FrmDlg.DMessageDlg('输入信息.', [mbOk, mbAbort]);
      param := Trim(FrmDlg.DlgEditText);
      rstr := rstr + #13 + param;
    end;
  end;
  Msg := MakeDefaultMsg(CM_MERCHANTDLGSELECT, merchant, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(rstr));
end;

//询问物品价格

procedure TfrmMain.SendQueryPrice(merchant, itemindex: Integer; itemname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_MERCHANTQUERYSELLPRICE, merchant, LoWord(itemindex), HiWord(itemindex), 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;
//询问修理价格

procedure TfrmMain.SendQueryRepairCost(merchant, itemindex: Integer; itemname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_MERCHANTQUERYREPAIRCOST, merchant, LoWord(itemindex), HiWord(itemindex), 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;

//发送要出售的物品

procedure TfrmMain.SendSellItem(merchant, itemindex: Integer; itemname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERSELLITEM, merchant, LoWord(itemindex), HiWord(itemindex), 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;
//发送要出售的寄售物品

procedure TfrmMain.SendSellOffItem(merchant, itemindex: Integer; itemname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SENDSELLOFFITEM, merchant, LoWord(itemindex), HiWord(itemindex), 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;
//发送要修改的物品

procedure TfrmMain.SendChangeItem(merchant, itemindex: Integer; itemname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SENDCHANGEITEM, merchant, LoWord(itemindex), HiWord(itemindex), 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;
//发送要修理的物品

procedure TfrmMain.SendRepairItem(merchant, itemindex: Integer; itemname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERREPAIRITEM, merchant, LoWord(itemindex), HiWord(itemindex), 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;
//发送要存放的物品

procedure TfrmMain.SendStorageItem(merchant, itemindex: Integer; itemname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERSTORAGEITEM, merchant, LoWord(itemindex), HiWord(itemindex), 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;

procedure TfrmMain.SendGetDetailItem(merchant, menuindex: Integer; itemname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERGETDETAILITEM, merchant, menuindex, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;

procedure TfrmMain.SendBuyItem(merchant, itemserverindex: Integer; itemname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERBUYITEM, merchant, LoWord(itemserverindex), HiWord(itemserverindex), 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;

procedure TfrmMain.SendTakeBackStorageItem(merchant, itemserverindex: Integer; itemname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERTAKEBACKSTORAGEITEM, merchant, LoWord(itemserverindex), HiWord(itemserverindex), 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;

procedure TfrmMain.SendMakeDrugItem(merchant: Integer; itemname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERMAKEDRUGITEM, merchant, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;

procedure TfrmMain.SendDropGold(dropgold: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DROPGOLD, dropgold, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendGroupMode(onoff: Boolean);
var
  Msg: TDefaultMessage;
begin
  if onoff then
    Msg := MakeDefaultMsg(CM_GROUPMODE, 0, 1, 0, 0) //on
  else Msg := MakeDefaultMsg(CM_GROUPMODE, 0, 0, 0, 0); //off
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendCreateGroup(withwho: string);
var
  Msg: TDefaultMessage;
begin
  if withwho <> '' then begin
    Msg := MakeDefaultMsg(CM_CREATEGROUP, 0, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(withwho));
  end;
end;

procedure TfrmMain.SendWantMiniMap;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_WANTMINIMAP, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendDealTry;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALTRY, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) { + EncodeString(who)});
end;

procedure TfrmMain.SendDuelTry;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DUELTRY, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendGuildDlg;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_OPENGUILDDLG, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendShopDlg(nPage, nTabePage, nSuperTabePage: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_OPENSHOP, Integer(g_MySelf), nPage, nTabePage, nSuperTabePage);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendGetRanking(nTabelPage, nTabelType, nPage: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GETRANKING, nPage, nTabelPage, nTabelType, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendGetMyRanking(nTabelPage, nTabelType: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GETMYRANKING, 0, nTabelPage, nTabelType, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendBuyShopItem(sItems: string; btType: Byte);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_BUYSHOPITEM, Integer(g_MySelf), 0, 0, btType);
  SendSocket(EncodeMessage(Msg) + EncodeString(sItems));
end;

procedure TfrmMain.SendBuyStoreItem(sItems: string; nMakeIndex, nRecogId: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_BUYSTOREITEM, nRecogId, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(sItems + '/' + IntToStr(nMakeIndex)));
end;

procedure TfrmMain.SendStartStore();
var
  I, nCount: Integer;
  itemindex: TItemIndex;
  sText: string;
  Msg: TDefaultMessage;
begin
  sText := '';
  nCount := 0;
  for I := 0 to 14 do begin
    if g_StoreItems[I].Item.S.Name <> '' then begin
      itemindex.btSellType := g_StoreItems[I].btSellType;
      itemindex.itemname := g_StoreItems[I].Item.S.Name;
      itemindex.MakeIndex := g_StoreItems[I].Item.MakeIndex;
      itemindex.Price := g_StoreItems[I].Item.S.Price;
      sText := sText + EncodeBuffer(@itemindex, SizeOf(TItemIndex)) + '/';
      Inc(nCount);
    end;
  end;
  Msg := MakeDefaultMsg(CM_STARTSTORE, nCount, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + sText);
end;

procedure TfrmMain.SendCancelDeal;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALCANCEL, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendAddDealItem(ci: TClientItem);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALADDITEM, ci.MakeIndex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(ci.S.Name));
end;

procedure TfrmMain.SendDelDealItem(ci: TClientItem);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALDELITEM, ci.MakeIndex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(ci.S.Name));
end;

procedure TfrmMain.SendChangeDealGold(gold: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALCHGGOLD, gold, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendDealEnd;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALEND, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendAddGroupMember(withwho: string);
var
  Msg: TDefaultMessage;
begin
  if withwho <> '' then begin
    Msg := MakeDefaultMsg(CM_ADDGROUPMEMBER, 0, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(withwho));
  end;
end;

procedure TfrmMain.SendDelGroupMember(withwho: string);
var
  Msg: TDefaultMessage;
begin
  if withwho <> '' then begin
    Msg := MakeDefaultMsg(CM_DELGROUPMEMBER, 0, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(withwho));
  end;
end;

procedure TfrmMain.SendGuildHome;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GUILDHOME, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendGuildMemberList;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GUILDMEMBERLIST, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendGuildAddMem(who: string);
var
  Msg: TDefaultMessage;
begin
  if Trim(who) <> '' then begin
    Msg := MakeDefaultMsg(CM_GUILDADDMEMBER, 0, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(who));
  end;
end;

procedure TfrmMain.SendGuildDelMem(who: string);
var
  Msg: TDefaultMessage;
begin
  if Trim(who) <> '' then begin
    Msg := MakeDefaultMsg(CM_GUILDDELMEMBER, 0, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(who));
  end;
end;

procedure TfrmMain.SendGuildUpdateNotice(notices: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GUILDUPDATENOTICE, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(notices));
end;

procedure TfrmMain.SendGuildUpdateGrade(rankinfo: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GUILDUPDATERANKINFO, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(rankinfo));
end;

procedure TfrmMain.SendSpeedHackUser;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SPEEDHACKUSER, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendAdjustBonus(remain: Integer; babil: TNakedAbility);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_ADJUST_BONUS, remain, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeBuffer(@babil, SizeOf(TNakedAbility)));
end;

procedure TfrmMain.SendPowerBlock();
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_POWERBLOCK, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeBuffer(@g_PowerBlock, SizeOf(TPowerBlock)));
end;

procedure TfrmMain.SendDomainName(); //发送注册域名
var
  Msg: TDefaultMessage;
  nParam: Integer;
  //d:TDATE;
  //sDomainName: string;
begin
  if (g_ConfigClient.sDomainName <> '') and (StringCrc(g_ConfigClient.sDomainName) = g_ConfigClient.nDomainName) then begin
    //sDomainName := DecryptString(g_ConfigClient.sDomainName);
    nParam := Random(High(Integer));
    //sDomainName := EncryStrHex3(DecryptString(g_ConfigClient.sDomainName), IntToStr(nParam));
    Msg := MakeDefaultMsg(CM_DOMAINNAME, StringCrc(EncryStrHex3(DecryptString(g_ConfigClient.sDomainName), IntToStr(nParam))), 0, LoWord(nParam), HiWord(nParam));
    SendSocket(EncodeMessage(Msg));
  end;
end;
{---------------------------------------------------------------}

function TfrmMain.ServerAcceptNextAction: Boolean;
begin
  Result := True;
  //若服务器未响应动作命令，则10秒后自动解锁
  if ActionLock then begin
    if GetTickCount - ActionLockTime > 10 * 1000 then begin
      ActionLock := False;
    end;
    Result := False;
  end;
end;

{function  TfrmMain.CanNextAction: Boolean;
begin
   if (g_MySelf.IsIdle) and
      (g_MySelf.m_nState and $04000000 = 0) and
      (GetTickCount - g_dwDizzyDelayStart > g_dwDizzyDelayTime)
   then begin
      Result := TRUE;
   end else
      Result := FALSE;
end;}

function TfrmMain.CanNextAction: Boolean; {//是否被麻痹}
begin
  if (g_MySelf.IsIdle) and (g_MySelf.m_nState and $04000000 = 0) and (GetTickCount - g_dwDizzyDelayStart > g_dwDizzyDelayTime) then begin
    Result := True;
  end else Result := False;
  {if g_Config.boChangeSpeed then begin
    if g_Config.boParalyCanRun or //麻痹是否可以跑
      g_Config.boParalyCanWalk or //麻痹是否可以走
      g_Config.boParalyCanHit or //麻痹是否可以攻击
      g_Config.boParalyCanSpell then begin //麻痹是否可以魔法
      Result := True;
    end else begin
      if (g_MySelf.m_nState and $04000000 = 0) and (GetTickCount - g_dwDizzyDelayStart > g_dwDizzyDelayTime) then begin
        Result := True;
      end else Result := FALSE;
    end;
  end else begin
    if (g_MySelf.IsIdle) and (g_MySelf.m_nState and $04000000 = 0) and (GetTickCount -  g_dwDizzyDelayStart > g_dwDizzyDelayTime) then begin
      Result := True;
    end else Result := FALSE;
  end; }
end;
//是否可以攻击，控制攻击速度

function TfrmMain.CanNextHit: Boolean;
var
  NextHitTime, LevelFastTime, dwHitTime: Integer;
begin
  LevelFastTime := _MIN(370, (g_MySelf.m_Abil.Level * 14));
  LevelFastTime := _MIN(800, LevelFastTime + g_MySelf.m_nHitSpeed * g_nItemSpeed);

  dwHitTime := 1400;
 {
  if g_ServerConfig.boChgSpeed then begin
    //dwHitTime := g_Config.dwHitTime;
    dwHitTime := 1400 - Trunc((g_MySelf.m_Abil.AttackSpeed * 1400) / 100);
  end else begin
    dwHitTime := 1400;
  end;
  }

  if g_boAttackSlow then
    NextHitTime := dwHitTime {1400} - LevelFastTime + 1500 //腕力超过时，减慢攻击速度
  else NextHitTime := dwHitTime {1400} - LevelFastTime;

  if g_ServerConfig.boChgSpeed then begin
    //DebugOutStr('TfrmMain.CanNextHit1 AttackSpeed:'+IntToStr(g_MySelf.m_Abil.AttackSpeed)+' NextHitTime:'+IntToStr(NextHitTime));
    NextHitTime := NextHitTime - Trunc((g_MySelf.m_Abil.AttackSpeed * NextHitTime) / 100);
    //DebugOutStr('TfrmMain.CanNextHit2 AttackSpeed:'+IntToStr(g_MySelf.m_Abil.AttackSpeed)+' NextHitTime:'+IntToStr(NextHitTime));
  end;

  if NextHitTime < 0 then NextHitTime := 0;

  if GetTickCount - LastHitTick > LongWord(NextHitTime) then begin
    LastHitTick := GetTickCount;
    Result := True;
  end else Result := False;
end;

procedure TfrmMain.ActionFailed;
begin
  g_nTargetX := -1;
  g_nTargetY := -1;
  ActionFailLock := True;
  ActionFailLockTime := GetTickCount(); //Jacky
  g_MySelf.MoveFail;
end;

function TfrmMain.IsUnLockAction(Action, adir: Integer): Boolean;
begin
  if ActionFailLock then begin //如果操作被锁定，则在指定时间后解锁
    if GetTickCount() - ActionFailLockTime > 1000 then ActionFailLock := False;
  end;
  if (ActionFailLock) or (g_boMapMoving) or (g_boServerChanging) then begin
    Result := False;
  end else Result := True;
end;

function TfrmMain.IsGroupMember(uname: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to g_GroupMembers.Count - 1 do begin
    if g_GroupMembers[I] = uname then begin
      Result := True;
      Break;
    end;
  end;
end;

{-------------------------------------------------------------}

procedure TfrmMain.TimerRunTimer(Sender: TObject);
var
  Str, Data: string;
  len, I, n, mcnt: Integer;
  nBuffer: Integer;
  sBuffer: string;
  RegInfo: TRegInfo;
  ProcessMsg: TProcessMessage;
begin
  if Busy then Exit;
  Busy := True;
  try
    g_sBufferText := g_sBufferText + g_sSockText;
    g_sSockText := '';

    if g_sBufferText <> '' then begin
      mcnt := 0;
      while Length(g_sBufferText) >= 2 do begin
        if g_boMapMovingWait then Break;
        if Pos('!', g_sBufferText) <= 0 then Break;
        g_sBufferText := ArrestStringEx(g_sBufferText, '#', '!', Data);
        if Data = '' then Break;
        DecodeMessagePacket(Data);
        if Pos('!', g_sBufferText) <= 0 then Break;
      end;
    end;
  finally
    Busy := False;
  end;

  if g_boQueryPrice then begin
    if GetTickCount - g_dwQueryPriceTime > 500 then begin

      g_boQueryPrice := False;
      case FrmDlg.SpotDlgMode of
        dmSell: SendQueryPrice(g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.S.Name);
        dmRepair: SendQueryRepairCost(g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.S.Name);
      end;
      OnClose := FormClose;
    end;
  end;

  if (g_ConnectionStep = cnsPlay) and not g_SoftClosed then begin
    if g_ConfigClient.btMainInterface = 1 then begin
      if g_nBonusPoint > 0 then begin
        FrmDlg.DBotPlusAbil.Visible := True;
      end else begin
        FrmDlg.DBotPlusAbil.Visible := False;
      end;
    end;
    if g_boShowHearMsg then AutoSendSay(); //自动喊话

{$I VMProtectBeginMutation.inc}
    if GetTickCount - g_dwOpenHomePageTick^ > 1000 * 60 * 60 * 1 then begin

      g_dwOpenHomePageTick^ := GetTickCount;
      Move(g_Buffer^, nBuffer, SizeOf(Integer));
      SetLength(sBuffer, nBuffer);
      Move(g_Buffer[SizeOf(Integer)], sBuffer[1], nBuffer);
      DecryptBuffer(sBuffer, @RegInfo, SizeOf(TRegInfo));

      if RegInfo.boShare then begin
        if Assigned(g_PlugInfo.OpenHomePage) then begin
          g_PlugInfo.OpenHomePage(nil);
        end else begin

        end;
      end;
    end;
{$I VMProtectEnd.inc}
  end;

  if g_MySelf <> nil then begin
    m_dwGetMsgTick := GetTickCount();
    while (GetTickCount - m_dwGetMsgTick < 200) and GetMessage(@ProcessMsg) do begin
      if not Operate(@ProcessMsg) then Break;
    end;
  end;

  if g_boShowVersionBmp and (GetTickCount - g_dwShowVersionBmpTick >= 1000 * 3) then begin
    g_boShowVersionBmp := False;
    if g_ConnectionStep in [cnsStart, cnsLogin] then begin
      if CSocket.Socket.Connected then begin
    {if OneClickMode = toKornetWorld then begin
      FillChar(packet, 256, #0);
      Str := 'KwGwMGS'; StrPCopy(strbuf, Str); Move(strbuf, (@packet[0])^, Length(Str));
      Str := 'CONNECT'; StrPCopy(strbuf, Str); Move(strbuf, (@packet[8])^, Length(Str));
      Str := KornetWorld.CPIPcode; StrPCopy(strbuf, Str); Move(strbuf, (@packet[16])^, Length(Str));
      Str := KornetWorld.SVCcode; StrPCopy(strbuf, Str); Move(strbuf, (@packet[32])^, Length(Str));
      Str := KornetWorld.LoginID; StrPCopy(strbuf, Str); Move(strbuf, (@packet[48])^, Length(Str));
      Str := KornetWorld.CheckSum; StrPCopy(strbuf, Str); Move(strbuf, (@packet[64])^, Length(Str));
      Socket.SendBuf(packet, 256);
    end;}
        SendClientMessage(CM_QUERYSERVERNAME, 0, 0, 0, 0);
        DScreen.ChangeScene(stLogin);

        g_ProcessesList.Clear;
        if g_ConfigClient.sCheckProcessesUrl <> '' then begin
          HTTPGetCheckPro.URL := g_ConfigClient.sCheckProcessesUrl;
          HTTPGetCheckPro.GetString;
        end;
      end else begin
        FrmDlg.DMessageDlg('连接已经关闭...', [mbOk]);
        Close;
      end;
    end;
  end;

  if g_MySelf <> nil then
    AutoUseItem(Self);
end;

procedure TfrmMain.ClientGetMsg(sData: string);
begin
  if sData = 'PWR' then g_boNextTimePowerHit := True; //打开攻杀
  if sData = 'LNG' then g_boCanLongHit := True; //打开刺杀
  if sData = 'ULNG' then g_boCanLongHit := False; //关闭刺杀
  if sData = 'WID' then g_boCanWideHit := True; //打开半月
  if sData = 'UWID' then g_boCanWideHit := False; //关闭半月
  if sData = 'CRS' then g_boCanCrsHit := True; //打开双龙    抱月刀法
  if sData = 'UCRS' then g_boCanCrsHit := False; //关闭双龙  抱月刀法
  if sData = 'TWN' then g_boCanTwnHit := True; //打开狂风斩
  if sData = 'UTWN' then g_boCanTwnHit := False; //关闭狂风斩
  if sData = 'STN' then g_boCanStnHit := True; //打开狂风斩;
  if sData = 'USTN' then g_boCanStnHit := False;
  if sData = 'FIR' then begin
    g_boNextTimeFireHit := True; //打开烈火
    g_dwLatestFireHitTick := GetTickCount;
    g_dwAutoFireTick := GetTickCount;
  end;
  if sData = 'KTZ' then begin
    g_boNextTimeKTZHit := True; //打开开天斩
    g_dwLatestKTZHitTick := GetTickCount;
    g_dwAutoKTZTick := GetTickCount;
    //DebugOutStr('打开开天斩');
  end;
  if sData = 'CID' then begin
    g_boNextTimePKJHit := True; //打开破空剑
    g_dwLatestPKJHitTick := GetTickCount;
    g_dwAutoPKJTick := GetTickCount;
    //DebugOutStr('打开破空剑');
  end;
  if sData = 'ZRJF' then begin
    g_boNextTimeZRJFHit := True; //逐日剑法
    g_dwLatestZRJFHitTick := GetTickCount;
    g_dwAutoZRJFTick := GetTickCount;
    //DebugOutStr('逐日剑法');
  end;
  if sData = 'UFIR' then g_boNextTimeFireHit := False; //关闭烈火
  if sData = 'UKTZ' then g_boNextTimeKTZHit := False; //关闭开天斩
  if sData = 'UCID' then g_boNextTimePKJHit := False; //关闭破空剑
  if sData = 'UZRJF' then g_boNextTimeZRJFHit := False; //关闭破空剑

  if sData = 'GOOD' then begin
    ActionLock := False;
    Inc(g_nReceiveCount);
  end;
  if sData = 'FAIL' then begin
    ActionFailed;
    ActionLock := False;
    Inc(g_nReceiveCount);
  end;
end;

procedure TfrmMain.ClientGetRandomCode(sData: string; nKey: Integer);
//var
 // sMsg: string;
begin
  //sMsg := DecodeString(sData);
  //g_sRandomCode := DecryptString256(sMsg, IntToStr(nKey));
end;

procedure TfrmMain.ClientNewIDSuccess();
begin
  FrmDlg.DMessageDlg('Account: ' + MakeNewId + ' Created.\' +
    'Please keep your password safe and contact\the support team if there are any problems.', [mbOk]);
  LoginScene.ShowLoginBox;
end;

procedure TfrmMain.ClientNewIDFail(nFailCode: Integer);
begin
  case nFailCode of
    0: begin
        FrmDlg.DMessageDlg('帐号 "' + MakeNewId + '" 已被其他的玩家使用了。\请选择其它帐号名注册。', [mbOk]);
        LoginScene.NewIdRetry(False);
      end;
    1: FrmDlg.DMessageDlg('验证码输入错误，请重新输入！！！', [mbOk]);
    -2: FrmDlg.DMessageDlg('此帐号名被禁止使用！', [mbOk]);
  else begin
      FrmDlg.DMessageDlg('帐号创建失败，请确认帐号是否包括空格、及非法字符！Code: ' + IntToStr(nFailCode), [mbOk]);
    end;
  end;
  LoginScene.ShowLoginBox;
end;

procedure TfrmMain.ClientLoginFail(nFailCode: Integer);
begin
  case nFailCode of
    -1: FrmDlg.DMessageDlg('Wrong Password.\Please try again, if you have forgotten your password, \contact the support team.', [mbOk]);
    -2: FrmDlg.DMessageDlg('密码输入错误超过3次，此帐号被暂时锁定，请稍候再登录！ Error 2', [mbOk]);
    -3: FrmDlg.DMessageDlg('此帐号已经登录或被异常锁定，请稍候再登录！ Error 3', [mbOk]);
    -4: FrmDlg.DMessageDlg('这个帐号访问失败！\请使用其他帐号登录，\或者申请付费注册。 Error 4', [mbOk]);
    -5: FrmDlg.DMessageDlg('这个帐号被锁定！ Error 5', [mbOk]);
  else FrmDlg.DMessageDlg('Account does not exist.\Please check your account name and try again.', [mbOk]);
  end;
  LoginScene.PassWdFail;
end;

procedure TfrmMain.ClientUpdateAccountSuccess();
begin
  FrmDlg.DMessageDlg('您的帐号信息更新成功。\' +
    '请妥善保管您的帐号和密码。\' +
    '并且不要因任何原因把帐号和密码告诉任何其他人。\' +
    '如果忘记了密码，你可以通过我们的主页重新找回。', [mbOk]);
  ClientGetSelectServer;
end;

procedure TfrmMain.ClientUpdateAccountFail();
begin
  FrmDlg.DMessageDlg('更新帐号失败..', [mbOk]);
  ClientGetSelectServer;
end;

procedure TfrmMain.ClientQueryChrFail(nFailCode: Integer);
begin
  g_boDoFastFadeOut := False;
  g_boDoFadeIn := False;
  g_boDoFadeOut := False;
  FrmDlg.DMessageDlg('服务器认证失败..', [mbOk]);
  Close;
end;

procedure TfrmMain.ClientNewChrFail(nFailCode: Integer);
begin
  case nFailCode of
    0: FrmDlg.DMessageDlg('[错误信息] 输入的角色名称包含非法字符！ 错误代码 = 0', [mbOk]);
    2: FrmDlg.DMessageDlg('[错误信息] 创建角色名称已被其他人使用！ 错误代码 = 2', [mbOk]);
    3: FrmDlg.DMessageDlg('[错误信息] 您只能创建二个游戏角色！ 错误代码 = 3', [mbOk]);
    4: FrmDlg.DMessageDlg('[错误信息] 创建角色时出现错误！ 错误代码 = 4', [mbOk]);
  else FrmDlg.DMessageDlg('[错误信息] 创建角色时出现未知错误！', [mbOk]);
  end;
end;

procedure TfrmMain.ClientChgPasswdSuccess();
begin
  FrmDlg.DMessageDlg('密码修改成功.', [mbOk]);
end;

procedure TfrmMain.ClientChgPasswdFail(nFailCode: Integer);
begin
  case nFailCode of
    -1: FrmDlg.DMessageDlg('输入的原始密码不正确！', [mbOk]);
    -2: FrmDlg.DMessageDlg('此帐号被锁定！', [mbOk]);
  else FrmDlg.DMessageDlg('输入的新密码长度小于四位！', [mbOk]);
  end;
end;

procedure TfrmMain.ClientDelChrFail(nFailCode: Integer);
begin
  FrmDlg.DMessageDlg('[错误信息] 删除游戏角色时出现错误！', [mbOk]);
end;

procedure TfrmMain.ClientStartPlayFail();
begin
  FrmDlg.DMessageDlg('此服务器满员！', [mbOk]);
  ClientGetSelectServer();
end;

procedure TfrmMain.ClientVersionFail();
begin
  FrmDlg.DMessageDlg('Client Version does not match Required Version.', [mbOk]);
  DScreen.AddChatBoardString('Please download the correct Version and try again.', clyellow, clRed);
  CSocket.Close;
end;

procedure TfrmMain.ClientGetNewMap(DefMsg: pTDefaultMessage; sData: string);
var
  sText: string;
begin
  g_sMapTitle := '';
  sText := DecodeString(sData);
  //g_sMapName := sText;
  PlayScene.SendMsg(DefMsg.ident, 0,
    DefMsg.param {x},
    DefMsg.tag {y},
    DefMsg.series {darkness},
    0, 0,
    sText {mapname});
end;

procedure TfrmMain.ClientGetUserLogin(DefMsg: pTDefaultMessage;
  sData: string);
var
  MsgWL: TMessageBodyWL;
  Msg: TDefaultMessage;
  nBuffer: Integer;
  sBuffer: string;
  RegInfo: TRegInfo;
  NewRegInfo: TRegInfo;

  //nParam: Integer;
begin
  g_dwFirstServerTime := 0;
  g_dwFirstClientTime := 0;
  DecodeBuffer(sData, @MsgWL, SizeOf(TMessageBodyWL));
{$I VMProtectBeginMutation.inc}
  OnClose := FormClose;

  Move(g_Buffer^, nBuffer, SizeOf(Integer));
  SetLength(sBuffer, nBuffer);
  Move(g_Buffer[SizeOf(Integer)], sBuffer[1], nBuffer);

  DecryptBuffer(sBuffer, @RegInfo, SizeOf(TRegInfo));
  FillChar(g_Buffer^, 1024, #0);

  PlayScene.SendMsg(DefMsg.ident, DefMsg.Recog, DefMsg.param {x}, DefMsg.tag {y}, DefMsg.series {dir}, MsgWL.lParam1 {desc.Feature}, MsgWL.lParam2 {desc.Status}, '');
  DScreen.ChangeScene(stPlayGame);
  //Showmessage('DScreen.ChangeScene(stPlayGame)');
  SendClientMessage(CM_QUERYBAGITEMS, 0, 0, 0, 0);

  //nParam := Random(High(Integer));

  Msg := MakeDefaultMsg(CM_GETREGINFO, CSocket.Socket.Handle, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + sBuffer);

  //SendDomainName(); //发送注册域名

  NewRegInfo.boShare := True;
  NewRegInfo.nProcedure[0] := RegInfo.nProcedure[19];
  sBuffer := EncryptBuffer(@NewRegInfo, SizeOf(TRegInfo));
  Move(nBuffer, g_Buffer^, SizeOf(Integer));
  Move(sBuffer[1], g_Buffer[SizeOf(Integer)], nBuffer);
{$I VMProtectEnd.inc}

  if LoByte(LoWord(MsgWL.lTag1)) = 1 then g_boAllowGroup := True
  else g_boAllowGroup := False;
  g_boServerChanging := False;
  if g_wAvailIDDay > 0 then begin
    DScreen.AddChatBoardString('您当前通过包月帐号充值。', clGreen, clWhite)
  end else if g_wAvailIPDay > 0 then begin
    DScreen.AddChatBoardString('您当前通过包月IP 充值。', clGreen, clWhite)
  end else if g_wAvailIPHour > 0 then begin
    DScreen.AddChatBoardString('您当前通过计时IP 充值。', clGreen, clWhite)
  end else if g_wAvailIDHour > 0 then begin
    DScreen.AddChatBoardString('您当前通过计时帐号充值。', clGreen, clWhite)
  end;
  //FrmDlg.DMessageDlg('TfrmMain.ClientGetUserLogin', [mbOk]);
end;

procedure TfrmMain.ClientGetAreaState(nAreaState: Integer);
begin
  g_nAreaStateValue := nAreaState;
end;

procedure TfrmMain.ClientGetMyStatus(DefMsg: pTDefaultMessage);
begin
  g_nMyHungryState := DefMsg.param;
end;

procedure TfrmMain.ClientGetObjTurn(DefMsg: pTDefaultMessage;
  sData: string);
var
  sBody2: string;
  sBody: string;
  sColor: string;
  CharDesc: TCharDesc;
  Actor: TActor;
  nData: Integer;
begin
  sBody := '';
  nData := Length(sData);
  if nData > g_nCodeMsgSize then begin
    sBody := Copy(sData, g_nCodeMsgSize + 1, nData - g_nCodeMsgSize);
    sBody := DecodeString(sBody);
    sColor := GetValidStr3(sBody, sBody, ['/']);
  end;
  if nData >= g_nCodeMsgSize then begin
    DecodeBuffer(sData, @CharDesc, SizeOf(TCharDesc));
    PlayScene.SendMsg(DefMsg.ident,
      DefMsg.Recog,
      DefMsg.param {x},
      DefMsg.tag {y},
      DefMsg.series {dir + light},
      CharDesc.feature,
      CharDesc.Status,
      '');
    if sBody <> '' then begin
      Actor := PlayScene.FindActor(DefMsg.Recog);
      if Actor <> nil then begin
        Actor.m_sDescUserName := GetValidStr3(sBody, Actor.m_sUserName, ['\']);
      //Actor.UserName := sBody;    SM_TURN
        if (Actor <> g_MySelf) and (Actor <> g_MyHero) then begin
          Actor.m_Abil.Level := CharDesc.Level;
          Actor.m_Abil.HP := CharDesc.HP;
          Actor.m_Abil.MaxHP := CharDesc.MaxHP;
          Actor.m_btJob := LoByte(LoWord(CharDesc.AddStatus));
          if Actor.m_btRace = RCC_USERHUMAN then begin
            THumActor(Actor).m_btCastle := HiByte(LoWord(CharDesc.AddStatus));
          end;
        end;
        Actor.m_nNameColor := GetRGB(Str_ToInt(sColor, 0));
        Actor.m_boStartStore := LoByte(HiWord(CharDesc.AddStatus)) > 0;
      end;
    end;
  end;
end;

procedure TfrmMain.ClientGetBackStep(DefMsg: pTDefaultMessage;
  sData: string);
var
  sBody2: string;
  sBody: string;
  sColor: string;
  CharDesc: TCharDesc;
  Actor: TActor;
  nData: Integer;
begin
  sBody := '';
  nData := Length(sData);
  if nData > g_nCodeMsgSize then begin
    sBody := Copy(sData, g_nCodeMsgSize + 1, nData - g_nCodeMsgSize);
    sBody := DecodeString(sBody);
    sColor := GetValidStr3(sBody, sBody, ['/']);
  end;
  if nData >= g_nCodeMsgSize then begin
    DecodeBuffer(sData, @CharDesc, SizeOf(TCharDesc));
    PlayScene.SendMsg(DefMsg.ident,
      DefMsg.Recog,
      DefMsg.param {x},
      DefMsg.tag {y},
      DefMsg.series {dir + light},
      CharDesc.feature,
      CharDesc.Status,
      '');
    if sBody <> '' then begin
      Actor := PlayScene.FindActor(DefMsg.Recog);
      if Actor <> nil then begin
        Actor.m_sDescUserName := GetValidStr3(sBody, Actor.m_sUserName, ['\']);
      //Actor.UserName := sBody;
        Actor.m_nNameColor := GetRGB(Str_ToInt(sColor, 0));
        Actor.m_Abil.Level := CharDesc.Level;
        Actor.m_Abil.HP := CharDesc.HP;
        Actor.m_Abil.MaxHP := CharDesc.MaxHP;
        Actor.m_boStartStore := LoByte(HiWord(CharDesc.AddStatus)) > 0;
      end;
    end;
  end;
end;

procedure TfrmMain.ClientSpaceMoveHide(DefMsg: pTDefaultMessage);
begin
  if DefMsg.Recog <> g_MySelf.m_nRecogId then begin
    PlayScene.SendMsg(DefMsg.ident, DefMsg.Recog, DefMsg.param {x}, DefMsg.tag {y}, 0, 0, 0, '')
  end;
end;

procedure TfrmMain.ClientSpaceMoveShow(DefMsg: pTDefaultMessage;
  sData: string);
var
  sBody2: string;
  sBody: string;
  sColor: string;
  CharDesc: TCharDesc;
  Actor: TActor;
  nData: Integer;
begin
  sBody := '';
  nData := Length(sData);
  if nData > g_nCodeMsgSize then begin
    sBody := Copy(sData, g_nCodeMsgSize + 1, nData - g_nCodeMsgSize);
    sBody := DecodeString(sBody);
    sColor := GetValidStr3(sBody, sBody, ['/']);
  end;
  if nData >= g_nCodeMsgSize then begin
    DecodeBuffer(sData, @CharDesc, SizeOf(TCharDesc));
    if DefMsg.Recog <> g_MySelf.m_nRecogId then begin
      PlayScene.NewActor(DefMsg.Recog, DefMsg.param, DefMsg.tag, DefMsg.series, CharDesc.feature, CharDesc.Status);
    end;
    PlayScene.SendMsg(DefMsg.ident,
      DefMsg.Recog,
      DefMsg.param {x},
      DefMsg.tag {y},
      DefMsg.series {dir + light},
      CharDesc.feature,
      CharDesc.Status,
      '');
    if sBody <> '' then begin
      Actor := PlayScene.FindActor(DefMsg.Recog);
      if Actor <> nil then begin
        if (Actor <> g_MySelf) and (Actor <> g_MyHero) then begin
          Actor.m_Abil.Level := CharDesc.Level;
          Actor.m_Abil.HP := CharDesc.HP;
          Actor.m_Abil.MaxHP := CharDesc.MaxHP;
          Actor.m_btJob := LoByte(LoWord(CharDesc.AddStatus));
          if Actor.m_btRace = RCC_USERHUMAN then begin
            THumActor(Actor).m_btCastle := HiByte(LoWord(CharDesc.AddStatus));
          end;
        end;
        Actor.m_sDescUserName := GetValidStr3(sBody, Actor.m_sUserName, ['\']);
      //Actor.UserName := sBody;
        Actor.m_nNameColor := GetRGB(Str_ToInt(sColor, 0));
        Actor.m_boStartStore := LoByte(HiWord(CharDesc.AddStatus)) > 0;
      end;
    end;
  end;
end;

procedure TfrmMain.ClientObjWalk(DefMsg: pTDefaultMessage;
  sData: string);
var
  CharDesc: TCharDesc;
  Actor: TActor;
begin
  if Length(sData) >= g_nCodeMsgSize then begin
    DecodeBuffer(sData, @CharDesc, SizeOf(TCharDesc));
    if (DefMsg.Recog <> g_MySelf.m_nRecogId) or
      (DefMsg.ident = SM_RUSH) or
      (DefMsg.ident = SM_RUSHKUNG) then
      PlayScene.SendMsg(DefMsg.ident, DefMsg.Recog,
        DefMsg.param {x},
        DefMsg.tag {y},
        DefMsg.series {dir+light},
        CharDesc.feature,
        CharDesc.Status, '');
    if DefMsg.ident = SM_RUSH then
      g_dwLatestRushRushTick := GetTickCount;
    Actor := PlayScene.FindActor(DefMsg.Recog);
    if Actor <> nil then begin
      Actor.m_Abil.Level := CharDesc.Level;
      Actor.m_Abil.HP := CharDesc.HP;
      Actor.m_Abil.MaxHP := CharDesc.MaxHP;
      Actor.m_boStartStore := LoByte(HiWord(CharDesc.AddStatus)) > 0;
    end;
  end;
end;

procedure TfrmMain.ClientObjRun(DefMsg: pTDefaultMessage;
  sData: string);
var
  CharDesc: TCharDesc;
  Actor: TActor;
begin
  if Length(sData) >= g_nCodeMsgSize then begin
    DecodeBuffer(sData, @CharDesc, SizeOf(TCharDesc));
    if DefMsg.Recog <> g_MySelf.m_nRecogId then
      PlayScene.SendMsg(DefMsg.ident, DefMsg.Recog,
        DefMsg.param {x},
        DefMsg.tag {y},
        DefMsg.series {dir+light},
        CharDesc.feature,
        CharDesc.Status, '');
    Actor := PlayScene.FindActor(DefMsg.Recog);
    if Actor <> nil then begin
      Actor.m_Abil.Level := CharDesc.Level;
      Actor.m_Abil.HP := CharDesc.HP;
      Actor.m_Abil.MaxHP := CharDesc.MaxHP;
      Actor.m_boStartStore := LoByte(HiWord(CharDesc.AddStatus)) > 0;
    end;
  end;
end;

procedure TfrmMain.ClientChangeLigth(DefMsg: pTDefaultMessage);
var
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if Actor <> nil then begin
    Actor.m_nChrLight := DefMsg.param;
  end;
end;

procedure TfrmMain.ClientLampChangeDura(DefMsg: pTDefaultMessage);
begin
  if g_UseItems[U_RIGHTHAND].S.Name <> '' then begin
    g_UseItems[U_RIGHTHAND].Dura := DefMsg.Recog;
  end;
end;

procedure TfrmMain.ClientObjMoveFail(DefMsg: pTDefaultMessage;
  sData: string);
var
  CharDesc: TCharDesc;
begin
  if Length(sData) >= g_nCodeMsgSize then begin
    ActionFailed;
    DecodeBuffer(sData, @CharDesc, SizeOf(TCharDesc));
    if DefMsg.Recog <> g_MySelf.m_nRecogId then
      PlayScene.SendMsg(SM_TURN, DefMsg.Recog,
        DefMsg.param {x},
        DefMsg.tag {y},
        DefMsg.series {dir+light},
        CharDesc.feature,
        CharDesc.Status, '');
  end;
end;

procedure TfrmMain.ClientObjButch(DefMsg: pTDefaultMessage;
  sData: string);
var
  //CharDesc: TCharDesc;
  Actor: TActor;
begin
  //DecodeBuffer(sData, @CharDesc, SizeOf(TCharDesc));
  if DefMsg.Recog <> g_MySelf.m_nRecogId then begin
    Actor := PlayScene.FindActor(DefMsg.Recog);
    Actor.SendMsg(SM_SITDOWN,
      DefMsg.param {x},
      DefMsg.tag {y},
      DefMsg.series {dir},
      0,
      0,
      '',
      0);
  end;
end;

procedure TfrmMain.ClientObjHit(DefMsg: pTDefaultMessage;
  sData: string);
var
  Actor: TActor;
begin
  //DScreen.AddChatBoardString('DefMsg.ident: ' + IntToStr(DefMsg.ident), clWhite, clPurple);
  if (DefMsg.Recog <> g_MySelf.m_nRecogId) or (DefMsg.ident = SM_101HIT) then begin
    Actor := PlayScene.FindActor(DefMsg.Recog);
    if Actor <> nil then begin
      Actor.SendMsg(DefMsg.ident,
        DefMsg.param {x},
        DefMsg.tag {y},
        DefMsg.series {dir},
        0, 0, '',
        0);
      if DefMsg.ident = SM_HEAVYHIT then begin
        if sData <> '' then
          Actor.m_boDigFragment := True;
      end;
    end;
  end else begin //合击
    if DefMsg.ident in [SM_60HIT..SM_62HIT] then begin
      //DScreen.AddChatBoardString('DefMsg.ident:'+IntToStr(DefMsg.ident), clGreen, clWhite);
      g_MySelf.SendMsg(DefMsg.ident,
        DefMsg.param {x},
        DefMsg.tag {y},
        DefMsg.series {dir},
        0, 0, '',
        0);
    end;
  end;
end;

procedure TfrmMain.ClientObjFlyAxe(DefMsg: pTDefaultMessage;
  sData: string);
var
  MessageBodyW: TMessageBodyW;
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if Actor <> nil then begin
    DecodeBuffer(sData, @MessageBodyW, SizeOf(TMessageBodyW));
    Actor.SendMsg(DefMsg.ident,
      DefMsg.param {x},
      DefMsg.tag {y},
      DefMsg.series {dir},
      0, 0, '',
      0);
    Actor.m_nTargetX := MessageBodyW.Param1; //x
    Actor.m_nTargetY := MessageBodyW.Param2; //y
    Actor.m_nTargetRecog := MakeLong(MessageBodyW.Tag1, MessageBodyW.Tag2);
  end;
end;

procedure TfrmMain.ClientObjLighting(DefMsg: pTDefaultMessage;
  sData: string);
var
  MessageBodyWL: TMessageBodyWL;
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if Actor <> nil then begin
    DecodeBuffer(sData, @MessageBodyWL, SizeOf(TMessageBodyWL));
    Actor.SendMsg(DefMsg.ident,
      DefMsg.param {x},
      DefMsg.tag {y},
      DefMsg.series {dir},
      0, 0, '',
      0);
    Actor.m_nTargetX := MessageBodyWL.lParam1; //x
    Actor.m_nTargetY := MessageBodyWL.lParam2; //y
    Actor.m_nTargetRecog := MessageBodyWL.lTag1;
    Actor.m_nMagicNum := MessageBodyWL.lTag2;
  end;
end;

procedure TfrmMain.ClientObjSpell(DefMsg: pTDefaultMessage;
  sData: string);
begin
  UseMagicSpell(DefMsg.Recog {who}, DefMsg.series {effectnum}, DefMsg.param {tx}, DefMsg.tag {y}, Str_ToInt(sData, 0));
end;

procedure TfrmMain.ClientObjMagicFire(DefMsg: pTDefaultMessage;
  sData: string);
var
  nTarget: Integer;
begin
  DecodeBuffer(sData, @nTarget, SizeOf(Integer));
  UseMagicFire(DefMsg.Recog {who}, LoByte(DefMsg.series) {efftype}, HiByte(DefMsg.series) {effnum}, DefMsg.param {tx}, DefMsg.tag {y}, nTarget);
end;

procedure TfrmMain.ClientObjMagicFireFail(DefMsg: pTDefaultMessage);
begin
  UseMagicFireFail(DefMsg.Recog {who});
end;


procedure TfrmMain.ClientOutofConnection();
begin
  g_boDoFastFadeOut := False;
  g_boDoFadeIn := False;
  g_boDoFadeOut := False;
  FrmDlg.DMessageDlg('服务器连接被强行中断。\连接时间可能超过限制。', [mbOk]);
  Close;
end;

procedure TfrmMain.ClientObjDeath(DefMsg: pTDefaultMessage;
  sData: string);
var
  Actor: TActor;
  CharDesc: TCharDesc;
begin
  if Length(sData) >= g_nCodeMsgSize then begin
    DecodeBuffer(sData, @CharDesc, SizeOf(TCharDesc));
    Actor := PlayScene.FindActor(DefMsg.Recog);
    if Actor <> nil then begin
      Actor.SendMsg(DefMsg.ident,
        DefMsg.param {x}, DefMsg.tag {y}, DefMsg.series {damage},
        CharDesc.feature, CharDesc.Status, '',
        0);
      Actor.m_Abil.HP := 0;
      //Actor.m_Abil.Level := CharDesc.Level;
      //Actor.m_Abil.HP := CharDesc.HP;
      //Actor.m_Abil.MaxHP := CharDesc.MaxHP;
      Actor.m_boStartStore := LoByte(HiWord(CharDesc.AddStatus)) > 0;
    end else begin
      PlayScene.SendMsg(SM_DEATH, DefMsg.Recog, DefMsg.param {x}, DefMsg.tag {y}, DefMsg.series {damage}, CharDesc.feature, CharDesc.Status, '');
    end;
  end;
end;

procedure TfrmMain.ClientObjSkeLeton(DefMsg: pTDefaultMessage;
  sData: string);
var
  CharDesc: TCharDesc;
begin
  if Length(sData) >= g_nCodeMsgSize then begin
    DecodeBuffer(sData, @CharDesc, SizeOf(TCharDesc));
    PlayScene.SendMsg(DefMsg.ident, DefMsg.Recog, DefMsg.param {HP}, DefMsg.tag {maxHP}, DefMsg.series {damage}, CharDesc.feature, CharDesc.Status, '');
  end;
end;

procedure TfrmMain.ClientObjAbility(DefMsg: pTDefaultMessage;
  sData: string);
begin
  if g_MySelf <> nil then begin
    g_MySelf.m_nGold := DefMsg.Recog;
    g_MySelf.m_btJob := DefMsg.param;
    g_MySelf.m_nGameGold := MakeLong(DefMsg.tag, DefMsg.series);
    DecodeBuffer(sData, @g_MySelf.m_Abil, SizeOf(TAbility));

    g_boHumProtect := True;
    {
    g_MySelf.m_Abil.MoveSpeed := 50;
    g_MySelf.m_Abil.AttackSpeed := 100;
    }
    if not g_boLoadUserConfig then begin
      g_boLoadUserConfig := True;
      LoadUserConfig();
      FrmDlg.SetConfigDlg();

    end;
  end;
end;

procedure TfrmMain.ClientObjSubAbility(DefMsg: pTDefaultMessage);
begin
  g_nMyHitPoint := LoByte(DefMsg.param);
  g_nMySpeedPoint := HiByte(DefMsg.param);
  g_nMyAntiPoison := LoByte(DefMsg.tag);
  g_nMyPoisonRecover := HiByte(DefMsg.tag);
  g_nMyHealthRecover := LoByte(DefMsg.series);
  g_nMySpellRecover := HiByte(DefMsg.series);
  g_nMyAntiMagic := LoByte(LongWord(DefMsg.Recog));
end;

procedure TfrmMain.ClientDayChanging(DefMsg: pTDefaultMessage);
begin
  g_nDayBright := DefMsg.param;
  //DarkLevel := DefMsg.tag;
  //if DarkLevel = 0 then g_boViewFog := False
 // else g_boViewFog := True;
 // g_boViewFog := True;
end;

procedure TfrmMain.ClientObjWinExp(DefMsg: pTDefaultMessage);
begin
  // Experience Gained
  g_MySelf.m_Abil.Exp := LongWord(DefMsg.Recog);
  DScreen.AddSysMsg('Gained ' + IntToStr(LongWord(MakeLong(DefMsg.param, DefMsg.tag))) + ' Experience', SCREENWIDTH - 150, 40, clLime);
end;

procedure TfrmMain.ClientObjLevelUp(DefMsg: pTDefaultMessage);
begin
  g_MySelf.m_Abil.Level := MakeLong(DefMsg.param, DefMsg.tag);
  g_MySelf.SendMsg(SM_LEVELUP, g_MySelf.m_nRecogId, g_MySelf.m_nCurrX {X}, g_MySelf.m_nCurrY {Y}, g_MySelf.m_btDir {d}, 0, '', 0);
  DScreen.AddSysMsg('Congratulations, New level aquired!', 30, 40, clAqua);
end;

procedure TfrmMain.ClientObjHealthSpellChanged(DefMsg: pTDefaultMessage;
  sData: string);
var
  Health: THealth;
  Actor: TActor;
  nDamage: Integer;
begin
  //DebugOutStr('TfrmMain.ClientObjHealthSpellChanged:'+sData);
  Actor := nil;
  DecodeBuffer(sData, @Health, SizeOf(THealth));
  {DebugOutStr('TfrmMain.ClientObjHealthSpellChanged Health.HP:'+IntToStr(Health.HP));
  DebugOutStr('TfrmMain.ClientObjHealthSpellChanged Health.MaxHP:'+IntToStr(Health.MaxHP));}
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if Actor <> nil then begin
    nDamage := Actor.m_Abil.HP - Health.HP;

    if nDamage < 0 then begin
      Actor.AddHealthStatus(1, abs(nDamage));
    end else
      if nDamage >= g_ServerConfig.nGreenNumber then begin
      Actor.AddHealthStatus(6, abs(nDamage));
    end else
      if nDamage > 0 then begin
      Actor.AddHealthStatus(2, abs(nDamage));
    end else begin
            //Actor.AddHealthStatus(0, 0);
    end;

    if Actor.m_Abil.MP - Health.MP < 0 then begin
      Actor.AddHealthStatus(3, abs(Actor.m_Abil.MP - Health.MP));
    end else
      if Actor.m_Abil.MP - Health.MP > 0 then begin
      Actor.AddHealthStatus(4, abs(Actor.m_Abil.MP - Health.MP));
    end else begin
            //Actor.AddHealthStatus(0, 0);
    end;
    Actor.m_Abil.HP := Health.HP;
    Actor.m_Abil.MP := Health.MP;
    Actor.m_Abil.MaxHP := Health.MaxHP;
  end else begin
    if (g_MyHero <> nil) and (g_MyHero.m_nRecogId = DefMsg.Recog) then begin
      nDamage := g_MyHero.m_Abil.HP - Health.HP;
      //g_MyHero.m_boOpenHealth := True;
      g_MyHero.m_Abil.HP := Health.HP;
      g_MyHero.m_Abil.MP := Health.MP;
      g_MyHero.m_Abil.MaxHP := Health.MaxHP;
    end;
  end;
end;

procedure TfrmMain.ClientObjStruck(DefMsg: pTDefaultMessage;
  sData: string);
var
  Health: THealth;
  MessageBodyWL: TMessageBodyWL;
  Actor: TActor;
  sData1, sData2: string;
  ClientMagic: PTClientMagic;
  nDamage: Integer;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if Assigned(g_PlugInfo.HookClientObjStruck) then begin
    if g_PlugInfo.HookClientObjStruck(@DefMsg, PChar(sData), Length(sData)) then Exit;
  end;
  if Actor <> nil then begin
    sData1 := Copy(sData, 1, Pos('/', sData) - 1);
    sData2 := Copy(sData, Pos('/', sData) + 1, Length(sData));
    DecodeBuffer(sData1, @MessageBodyWL, SizeOf(TMessageBodyWL));
    DecodeBuffer(sData2, @Health, SizeOf(THealth));

   { if g_Config.boStruckChgColor then begin
      if g_MySelf = Actor then begin
        if g_Config.nStruckChgColor >= 0 then begin
          if g_TargetCret <> nil then
            g_TargetCret.m_nState := (0 and $FFFFF) or (($80000000 shr g_Config.nStruckChgColor) or 0);
        end;
      end else begin
        if g_Config.nStruckChgColor >= 0 then begin
          Actor.m_nState := (0 and $FFFFF) or (($80000000 shr g_Config.nStruckChgColor) or 0);
        end;
      end;
    end; }

    if Actor = g_MySelf then begin
      if g_MySelf.m_nNameColor = 249 then
        g_dwLatestStruckTick := GetTickCount;

      if g_Config.boStruckShield and (not g_MySelf.m_boDeath) and ((g_MySelf.m_nState and $00100000) = 0) then begin //被攻击开盾
        ClientMagic := FindMagic(31);
        if ClientMagic <> nil then begin
          if ClientMagic.Def.wSpell + ClientMagic.Def.btDefSpell <= g_MySelf.m_Abil.MP then begin
            UseMagic(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ClientMagic);
          end;
        end;
      end;

    end else begin
      if Actor.CanCancelAction then
        Actor.CancelAction;
    end;

    if Actor = g_MySelf then begin
      if not g_Config.boStable then begin
        Actor.UpdateMsg(SM_STRUCK, MessageBodyWL.lTag2, 0,
          MakeLong(DefMsg.Tag, DefMsg.series) {damage}, MessageBodyWL.lParam1, MessageBodyWL.lParam2,
          '', MessageBodyWL.lTag1);
      end;
    end else begin
      Actor.m_boOpenHealth := True;
      Actor.UpdateMsg(SM_STRUCK, MessageBodyWL.lTag2, 0,
        MakeLong(DefMsg.Tag, DefMsg.series) {damage}, MessageBodyWL.lParam1, MessageBodyWL.lParam2,
        '', MessageBodyWL.lTag1);
    end;
    nDamage := Actor.m_Abil.HP - Health.HP;
    if Actor.m_Abil.HP = Health.HP then begin
      Actor.AddHealthStatus(0, 0);
    end else
      if nDamage < 0 then begin
      Actor.AddHealthStatus(1, abs(nDamage));
    end else
      if nDamage >= g_ServerConfig.nGreenNumber then begin
      Actor.AddHealthStatus(6, abs(nDamage));
    end else
      if (nDamage < g_ServerConfig.nGreenNumber) then begin
      Actor.AddHealthStatus(2, abs(nDamage));
    end else begin

    end;

    Actor.m_Abil.HP := Health.HP;
    Actor.m_Abil.MaxHP := Health.MaxHP;
  end;
end;

procedure TfrmMain.ClientObjChangeFace(DefMsg: pTDefaultMessage;
  sData: string);
var
  CharDesc: TCharDesc;
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if Actor <> nil then begin
    DecodeBuffer(sData, @CharDesc, SizeOf(TCharDesc));
    Actor.m_nWaitForRecogId := MakeLong(DefMsg.param, DefMsg.tag);
    Actor.m_nWaitForFeature := CharDesc.feature;
    Actor.m_nWaitForStatus := CharDesc.Status;
    AddChangeFace(Actor.m_nWaitForRecogId);
    Actor.m_Abil.Level := CharDesc.Level;
    Actor.m_Abil.HP := CharDesc.HP;
    Actor.m_Abil.MaxHP := CharDesc.MaxHP;
    Actor.m_boStartStore := LoByte(HiWord(CharDesc.AddStatus)) > 0;
  end;
end;

procedure TfrmMain.ClientObjInputPassword();
begin
        //PlayScene.EdChat.PasswordChar:='*';
  SetInputStatus();
end;

procedure TfrmMain.ClientObjOpenHealth(DefMsg: pTDefaultMessage;
  sData: string);
var
  Actor: TActor;
  Health: THealth;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if Actor <> nil then begin
    if Actor <> g_MySelf then begin
      DecodeBuffer(sData, @Health, SizeOf(THealth));
      Actor.m_Abil.HP := Health.HP;
      Actor.m_Abil.MaxHP := Health.MaxHP;
    end;
    Actor.m_boOpenHealth := True;
  end;
end;

procedure TfrmMain.ClientObjCloseHealth(DefMsg: pTDefaultMessage);
var
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if Actor <> nil then begin
    Actor.m_boOpenHealth := False;
  end;
end;

procedure TfrmMain.ClientObjInstanceOpenHealth(DefMsg: pTDefaultMessage;
  sData: string);
var
  Actor: TActor;
  Health: THealth;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if (Actor <> nil) and (Actor <> g_MySelf) then begin
    DecodeBuffer(sData, @Health, SizeOf(THealth));
    Actor.m_Abil.HP := Health.HP;
    Actor.m_Abil.MaxHP := Health.MaxHP;
    Actor.m_noInstanceOpenHealth := True;
    Actor.m_dwOpenHealthTime := 2 * 1000;
    Actor.m_dwOpenHealthStart := GetTickCount;
  end;
end;

procedure TfrmMain.ClientObjBreakWeapon(DefMsg: pTDefaultMessage);
var
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if Actor <> nil then begin
    if Actor is THumActor then
      THumActor(Actor).DoWeaponBreakEffect;
  end;
end;

procedure TfrmMain.ClientGetMessage(DefMsg: pTDefaultMessage;
  sData: string);
var
  sMsg: string;
  Actor: TActor;
begin
  sMsg := DecodeString(sData);
  if Assigned(g_PlugInfo.HookClientGetMessage) then begin
    if g_PlugInfo.HookClientGetMessage(PChar(sMsg), Length(sMsg), GetRGB(LoByte(DefMsg.param)), GetRGB(HiByte(DefMsg.param))) then Exit;
  end;

  case DefMsg.ident of
    SM_GROUPMESSAGE: begin
        if g_boShowGroupMsg then begin
          DScreen.AddChatBoardString(sMsg, GetRGB(LoByte(DefMsg.param)), GetRGB(HiByte(DefMsg.param)));
        end;
      end;
    SM_GUILDMESSAGE: begin
        if g_boShowGuildMsg then begin
          sMsg := DScreen.AddChatBoardString(sMsg, GetRGB(LoByte(DefMsg.param)), GetRGB(HiByte(DefMsg.param)));
          FrmDlg.AddGuildChat(sMsg);
        end;
      end;
    SM_WHISPER: begin
        if g_boShowWhisperMsg then begin
          DScreen.AddChatBoardString(sMsg, GetRGB(LoByte(DefMsg.param)), GetRGB(HiByte(DefMsg.param)));
        end;
      end;
    SM_CRY: begin
        if g_boShowHearMsg then begin
          DScreen.AddChatBoardString(sMsg, GetRGB(LoByte(DefMsg.param)), GetRGB(HiByte(DefMsg.param)));
        end;
      end;
    SM_SYSMESSAGE: begin
        if not g_boShowSysMessage then begin
          DScreen.AddChatBoardString(sMsg, GetRGB(LoByte(DefMsg.param)), GetRGB(HiByte(DefMsg.param)));
        end else begin
                //DScreen.AddSysMoveMsg(Str, Msg.param);
        end;
      end;
    SM_HEAR: begin
        if (LoByte(DefMsg.param) = 255) and (HiByte(DefMsg.param) = 255) then begin
          sMsg := DScreen.AddChatBoardString(sMsg, GetRGB(0), GetRGB(255));
        end else begin
          sMsg := DScreen.AddChatBoardString(sMsg, GetRGB(LoByte(DefMsg.param)), GetRGB(HiByte(DefMsg.param)));
        end;
        if g_NewStatus <> sBlind then begin
          Actor := PlayScene.FindActor(DefMsg.Recog);
          if Actor <> nil then Actor.Say(sMsg);
        end;
      end;
    SM_MOVEMESSAGE: begin
        if (SCREENWIDTH = 1024) and (DefMsg.Series = 330) then begin
          DScreen.AddMoveMsg(sMsg, LoByte(DefMsg.param), HiByte(DefMsg.param), DefMsg.Tag, 495, DefMsg.Recog);
        end else begin
          DScreen.AddMoveMsg(sMsg, LoByte(DefMsg.param), HiByte(DefMsg.param), DefMsg.Tag, DefMsg.Series, DefMsg.Recog);
        end;
      end;
    SM_DELAYMESSAGE: begin
        DScreen.DrawDelayMsg.Add(DefMsg.Recog, sMsg, DefMsg.param, GetRGB(DefMsg.tag));
        //DScreen.AddChatBoardString(sMsg, GetRGB(0), GetRGB(255));
      end;
    SM_DELETEDELAYMESSAGE: begin
        DScreen.DrawDelayMsg.Delete(DefMsg.Recog);
      end;
    SM_CENTERMESSAGE: begin
        //showmessage(sMsg);
        //DScreen.AddChatBoardString(sMsg, GetRGB(0), GetRGB(255));
        DScreen.DrawScreenCenterMsg.Add(sMsg, LoByte(DefMsg.param), HiByte(DefMsg.param), DefMsg.Recog);
      end;
  end;
end;

procedure TfrmMain.ClientGetUserName(DefMsg: pTDefaultMessage;
  sData: string);
var
  Actor: TActor;
  sUserName: string;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if Actor <> nil then begin
    sUserName := DecodeString(sData);
    Actor.m_sDescUserName := GetValidStr3(sUserName, Actor.m_sUserName, ['\']);
    Actor.m_nNameColor := GetRGB(DefMsg.param);
  end;
end;

procedure TfrmMain.ClientObjChangeNameColor(DefMsg: pTDefaultMessage);
var
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if Actor <> nil then begin
    Actor.m_nNameColor := GetRGB(DefMsg.param);
  end;
end;

procedure TfrmMain.ClientObjHide(DefMsg: pTDefaultMessage);
begin
  if g_MySelf.m_nRecogId <> DefMsg.Recog then begin
    PlayScene.SendMsg(SM_HIDE, DefMsg.Recog, DefMsg.param {x}, DefMsg.tag {y}, 0, 0, 0, '');
  end;
end;

procedure TfrmMain.ClientObjDigUp(DefMsg: pTDefaultMessage;
  sData: string);
var
  MessageBodyWL: TMessageBodyWL;
  Actor: TActor;
begin
  DecodeBuffer(sData, @MessageBodyWL, SizeOf(TMessageBodyWL));
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if Actor = nil then begin
    Actor := PlayScene.NewActor(DefMsg.Recog, DefMsg.param, DefMsg.tag, DefMsg.series, MessageBodyWL.lParam1, MessageBodyWL.lParam2);
  end;
  if Actor <> nil then begin
    Actor.m_nCurrentEvent := MessageBodyWL.lTag1;
    Actor.SendMsg(DefMsg.ident,
      DefMsg.param {x},
      DefMsg.tag {y},
      DefMsg.series {dir + light},
      MessageBodyWL.lParam1,
      MessageBodyWL.lParam2, '', 0);
  end;
end;

procedure TfrmMain.ClientObjDigDown(DefMsg: pTDefaultMessage);
begin
  PlayScene.SendMsg(DefMsg.ident, DefMsg.Recog, DefMsg.param {x}, DefMsg.tag {y}, 0, 0, 0, '');
end;

procedure TfrmMain.ClientGetShowEvent(DefMsg: pTDefaultMessage;
  sData: string);
var
  ShortMessage: TShortMessage;
  Event: TEvent;
begin
  DecodeBuffer(sData, @ShortMessage, SizeOf(TShortMessage));
  if DefMsg.param >= ET_SPACEDOOR_1 then begin
    Event := TSpaceDoorEvent.Create(DefMsg.Recog, LoWord(DefMsg.tag) {x}, DefMsg.series {y}, DefMsg.param - ET_SPACEDOOR_1 {e-type});
  end else
    if DefMsg.param >= ET_FIREFLOWER_1 then begin
    Event := TFlowerEvent.Create(DefMsg.Recog, LoWord(DefMsg.tag) {x}, DefMsg.series {y}, DefMsg.param {e-type});
  end else begin
    Event := TClEvent.Create(DefMsg.Recog, LoWord(DefMsg.tag) {x}, DefMsg.series {y}, DefMsg.param {e-type});
  end;
  Event.m_nDir := 0;
  Event.m_nEventParam := ShortMessage.ident;
  EventMan.AddEvent(Event);
end;

procedure TfrmMain.ClientGetHideEvent(DefMsg: pTDefaultMessage);
begin
  EventMan.DelEventById(DefMsg.Recog);
end;

procedure TfrmMain.ClientObjHeroLogOn(DefMsg: pTDefaultMessage; sData: string);
var
  Actor: TActor;
  wl: TMessageBodyWL;
begin
  DecodeBuffer(sData, @wl, SizeOf(TMessageBodyWL));

  PlayScene.SendMsg(SM_HEROLOGON, DefMsg.Recog,
    DefMsg.param {x},
    DefMsg.tag {y},
    DefMsg.series {dir},
    wl.lParam1, //desc.Feature,
    wl.lParam2, //desc.Status,
    '');

  //DScreen.AddChatBoardString('wl.lTag2:'+IntToStr(wl.lTag2)+' g_MySelf.m_nRecogId:'+IntToStr(g_MySelf.m_nRecogId)+' DefMsg.Recog:'+IntToStr(DefMsg.Recog), clWhite, clRed);

  if (wl.lTag2 = g_MySelf.m_nRecogId) then begin
    //DScreen.AddChatBoardString('(wl.lTag1 = g_MySelf.m_nRecogId) 1:'+IntToStr(DefMsg.Recog), clWhite, clRed);
    Actor := PlayScene.FindActor(DefMsg.Recog);
    if Actor <> nil then begin
      g_MyHero := THumActor(Actor);
      //DScreen.AddChatBoardString('(wl.lTag1 = g_MySelf.m_nRecogId) 2:'+IntToStr(DefMsg.Recog), clWhite, clRed);
    end;
  end;
end;

procedure TfrmMain.ClientObjHeroLogOnOK(nRecog: Integer);
var
  Actor: TActor;
begin
  //DScreen.AddChatBoardString('TfrmMain.ClientObjHeroLogOnOK:'+IntToStr(nRecog), clWhite, clRed);
  //Actor:=PlayScene.FindActor(nRecog);
 // g_MyHero := THumActor(PlayScene.FindActor(nRecog));
  if g_MyHero <> nil then begin
    FrmDlg.OpenHeroHealthState;
    SendClientMessage(CM_HEROLOGON_OK, 0, 0, 0, 0);
  end;
end;

procedure TfrmMain.ClientObjHeroLogOutOK(nRecog: Integer);
var
  I: Integer;
  Actor: TActor;
begin //英雄退出
  //DScreen.AddChatBoardString('TfrmMain.ClientObjHeroLogOutOK:'+IntToStr(nRecog), clWhite, clRed);
  {Actor := PlayScene.FindActor(nRecog);
  if Actor <> nil then begin
    Actor.m_dwDeleteTime := GetTickCount;
    UpDataFreeActorList(Actor);
  end else begin
    if (g_MyHero <> nil) and (g_MyHero.m_nRecogId = nRecog) then begin
      g_MyHero.m_dwDeleteTime := GetTickCount;
      UpDataFreeActorList(g_MyHero);
      Actor := g_MyHero;
    end;
  end;}
  g_boHeroProtect := False;
  if (g_MyHero <> nil) {and (g_MyHero.m_nRecogId = nRecog)} then begin
    g_MyHero.m_dwDeleteTime := GetTickCount;
    UpDataFreeActorList(g_MyHero);
  //if Actor = g_MyHero then begin
    g_MyHero := nil;
  end;
  for I := 0 to g_HeroMagicList.Count - 1 do begin
    Dispose(PTClientMagic(g_HeroMagicList.Items[I]));
  end;
  g_HeroMagicList.Clear;

  SafeFillChar(g_HeroUseItems, SizeOf(TClientItem) * 13, #0);
  SafeFillChar(g_HeroItemArr, SizeOf(TClientItem) * MAXHEROBAGITEM, #0);
  FrmDlg.CloseHeroAllWindows;

  g_boQueryHeroBagItem := False;
end;

procedure TfrmMain.ClientObjHeroLogOut(DefMsg: pTDefaultMessage);
var
  Actor: TActor;
begin //英雄登陆
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if (Actor <> nil) {and (Actor = g_MyHero)} then begin
    Actor.SendMsg(SM_HEROLOGOUT, DefMsg.Recog, DefMsg.param, DefMsg.tag, 0, 0, '', 0);
  end;
end;

procedure TfrmMain.ClientObjHeroAbility(DefMsg: pTDefaultMessage;
  sData: string);
var
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if Actor <> nil then begin
    DecodeBuffer(sData, @Actor.m_Abil, SizeOf(TAbility));
    Actor.m_btJob := LoByte(DefMsg.param);
    g_boHeroProtect := True;
  end;
end;

procedure TfrmMain.ClientObjHeroSubAbility(DefMsg: pTDefaultMessage);
begin
  g_nMyHeroHitPoint := LoByte(DefMsg.param);
  g_nMyHeroSpeedPoint := HiByte(DefMsg.param);
  g_nMyHeroAntiPoison := LoByte(DefMsg.tag);
  g_nMyHeroPoisonRecover := HiByte(DefMsg.tag);
  g_nMyHeroHealthRecover := LoByte(DefMsg.series);
  g_nMyHeroSpellRecover := HiByte(DefMsg.series);
  g_nMyHeroAntiMagic := LoByte(LongWord(DefMsg.Recog));
end;

procedure TfrmMain.ClientObjFireDragonPoint(DefMsg: pTDefaultMessage);
begin
  //DScreen.AddChatBoardString('g_MyHero.m_nAngryValue1:'+IntToStr(DefMsg.Param)+' g_MyHero.m_nMaxAngryValue:'+IntToStr(DefMsg.Tag), clWhite, clRed);
  if g_MyHero <> nil then begin
    g_MyHero.m_nAngryValue := DefMsg.param;
    g_MyHero.m_nMaxAngryValue := DefMsg.tag;
    //DScreen.AddChatBoardString('g_MyHero.m_nAngryValue2:'+IntToStr(DefMsg.Param)+' g_MyHero.m_nMaxAngryValue:'+IntToStr(DefMsg.Tag), clWhite, clRed);
  end;
end;

procedure TfrmMain.ClientObjHeroTakeOnOK(DefMsg: pTDefaultMessage; sData: string);
var
  I: Integer;
  sWhere: string;
  nWhere: Integer;
  sItemName: string;
  sMakeIndex: string;
  nMakeIndex: Integer;
begin
  //DScreen.AddChatBoardString('ClientObjHeroTakeOnOK1 ' + sData, clWhite, clPurple);
  if g_MyHero <> nil then begin
    g_MyHero.m_nFeature := DefMsg.Recog;
    if g_WaitingUseItem.Item.S.Name = '' then begin
      sData := GetValidStr3(sData, sWhere, ['/']);
      sData := GetValidStr3(sData, sItemName, ['/']);
      sData := GetValidStr3(sData, sMakeIndex, ['/']);
      nWhere := Str_ToInt(sWhere, -1);
      nMakeIndex := Str_ToInt(sMakeIndex, -1);

      if nWhere in [0..12] then begin
        for I := Low(g_HeroItemArr) to High(g_HeroItemArr) do begin
          if g_HeroItemArr[I].S.Name <> '' then begin
            if (g_HeroItemArr[I].S.Name = sItemName) and (g_HeroItemArr[I].MakeIndex = nMakeIndex) then begin
              g_HeroUseItems[nWhere] := g_HeroItemArr[I];
              g_HeroItemArr[I].S.Name := '';
              Break;
            end;
          end;
        end;
      end;
    end else begin
      if g_WaitingUseItem.Index in [0..12] then
        g_HeroUseItems[g_WaitingUseItem.Index] := g_WaitingUseItem.Item;
    end;
    g_WaitingUseItem.Item.S.Name := '';
    g_MyHero.FeatureChanged;
  end;
end;

procedure TfrmMain.ClientObjHeroTakeOnFail();
begin
  AddHeroItemBag(g_WaitingUseItem.Item);
  g_WaitingUseItem.Item.S.Name := '';
end;

procedure TfrmMain.ClientObjHeroTakeOffOK(DefMsg: pTDefaultMessage; sData: string);
var
  sWhere: string;
  nWhere: Integer;
  sItemName: string;
  sMakeIndex: string;
  nMakeIndex: Integer;
begin
  if g_MyHero <> nil then begin

    g_MyHero.m_nFeature := DefMsg.Recog;
    g_MyHero.FeatureChanged;
    if g_WaitingUseItem.Item.S.Name = '' then begin
      sData := GetValidStr3(sData, sWhere, ['/']);
      sData := GetValidStr3(sData, sItemName, ['/']);
      sData := GetValidStr3(sData, sMakeIndex, ['/']);
      nWhere := Str_ToInt(sWhere, -1);
      nMakeIndex := Str_ToInt(sMakeIndex, -1);
      if nWhere in [0..12] then begin
        if (g_HeroUseItems[nWhere].S.Name = sItemName) and (g_HeroUseItems[nWhere].MakeIndex = nMakeIndex) then begin
          g_HeroUseItems[nWhere].S.Name := '';
        end;
      end;
    end;
    g_WaitingUseItem.Item.S.Name := '';
  end;
end;

procedure TfrmMain.ClientObjHeroTakeOffFail();
var
  nIndex: Integer;
begin
  if g_WaitingUseItem.Index < 0 then begin
    nIndex := -(g_WaitingUseItem.Index + 1);
    g_HeroUseItems[nIndex] := g_WaitingUseItem.Item;
  end;
  g_WaitingUseItem.Item.S.Name := '';
end;

procedure TfrmMain.ClientObjTakeOffHeroBagOK(DefMsg: pTDefaultMessage);
begin
  g_MySelf.m_nFeature := DefMsg.Recog;
  g_MySelf.FeatureChanged;
  g_WaitingUseItem.Item.S.Name := '';
end;

procedure TfrmMain.ClientObjTakeOffHeroBagFail();
var
  nIndex: Integer;
begin
  if g_WaitingUseItem.Index < 0 then begin
    nIndex := -(g_WaitingUseItem.Index + 1);
    g_UseItems[nIndex] := g_WaitingUseItem.Item;
  end;
  g_WaitingUseItem.Item.S.Name := '';
end;

procedure TfrmMain.ClientObjTakeOffMasterBagOK(DefMsg: pTDefaultMessage);
begin
  if g_MyHero <> nil then begin
    g_MyHero.m_nFeature := DefMsg.Recog;
    g_MyHero.FeatureChanged;
    g_WaitingUseItem.Item.S.Name := '';
  end;
end;

procedure TfrmMain.ClientObjTakeOffMasterBagFail();
var
  nIndex: Integer;
begin
  if g_WaitingUseItem.Index < 0 then begin
    nIndex := -(g_WaitingUseItem.Index + 1);
    g_HeroUseItems[nIndex] := g_WaitingUseItem.Item;
  end;
  g_WaitingUseItem.Item.S.Name := '';
end;

procedure TfrmMain.ClientObjToMasterBagOK();
begin //英雄包裹到主人包裹成功
  if g_WaitingUseItem.Item.S.Name <> '' then begin
    AddItemBag(g_WaitingUseItem.Item);
  end;
  g_WaitingUseItem.Item.S.Name := '';
end;

procedure TfrmMain.ClientObjToMasterBagFail();
begin //英雄包裹到主人包裹失败
  if g_WaitingUseItem.Item.S.Name <> '' then begin
    AddHeroItemBag(g_WaitingUseItem.Item);
  end;
  g_WaitingUseItem.Item.S.Name := '';
end;

procedure TfrmMain.ClientObjToHeroBagOK();
begin //主人包裹到英雄包裹
  if g_WaitingUseItem.Item.S.Name <> '' then begin
    AddHeroItemBag(g_WaitingUseItem.Item);
  end;
  g_WaitingUseItem.Item.S.Name := '';
end;

procedure TfrmMain.ClientObjToHeroBagFail();
begin //主人包裹到英雄包裹
  if g_WaitingUseItem.Item.S.Name <> '' then begin
    AddItemBag(g_WaitingUseItem.Item);
  end;
  g_WaitingUseItem.Item.S.Name := '';
end;

procedure TfrmMain.ClientObjHeroBagCount(DefMsg: pTDefaultMessage);
var
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if (Actor <> nil) and (Actor is THumActor) then begin
    THumActor(Actor).m_nBagCount := DefMsg.param;
  end;
end;

procedure TfrmMain.ClientObjHeroWeigthChanged(DefMsg: pTDefaultMessage);
begin
  if g_MyHero <> nil then begin
    g_MyHero.m_Abil.Weight := DefMsg.Recog;
    g_MyHero.m_Abil.WearWeight := DefMsg.param;
    g_MyHero.m_Abil.HandWeight := DefMsg.tag;
  end;
end;

procedure TfrmMain.ClientObjHeroEatOK();
begin //英雄吃物品成功
  if g_MyHero <> nil then begin
    g_HeroEatingItem.S.Name := '';
    ArrangeHeroItemBag;
  end;
end;

procedure TfrmMain.ClientObjHeroEatFail();
begin //英雄吃物品失败
  if g_MyHero <> nil then begin
    AddHeroItemBag(g_HeroEatingItem);
    g_HeroEatingItem.S.Name := '';
  end;
end;

procedure TfrmMain.ClientObjHeroWinExp(DefMsg: pTDefaultMessage);
begin
  if g_MyHero <> nil then begin
    g_MyHero.m_Abil.Exp := LongWord(DefMsg.Recog);
    DScreen.AddSysMsg('Hero Gained ' + IntToStr(LongWord(MakeLong(DefMsg.param, DefMsg.tag))) + ' Experience', SCREENWIDTH - 150, 40, clLime); //SCREENWIDTH - 100, 40, clGreen);
  end;
end;

procedure TfrmMain.ClientObjHeroLevelUp(DefMsg: pTDefaultMessage);
begin
  if g_MyHero <> nil then begin
    g_MyHero.m_Abil.Level := MakeLong(DefMsg.param, DefMsg.tag);
    g_MyHero.SendMsg(SM_LEVELUP, g_MyHero.m_nRecogId, g_MyHero.m_nCurrX {X}, g_MyHero.m_nCurrY {Y}, g_MyHero.m_btDir {d}, 0, '', 0);
    DScreen.AddSysMsg('Congratulations, Hero aquired a new level!', 30, 40, clAqua);
  end;
end;

procedure TfrmMain.ClientObjRepaiFireDragon(DefMsg: pTDefaultMessage);
begin
  case DefMsg.Recog of
    2: AddItemBag(g_WaitingUseItem.Item);
    4: AddHeroItemBag(g_WaitingUseItem.Item);
  end;
  g_WaitingUseItem.Item.S.Name := '';
end;

procedure TfrmMain.ClientObjTakeOnOK(DefMsg: pTDefaultMessage; sData: string);
var
  I: Integer;
  sWhere: string;
  nWhere: Integer;
  sItemName: string;
  sMakeIndex: string;
  nMakeIndex: Integer;
begin
  g_MySelf.m_nFeature := DefMsg.Recog;
  g_MySelf.FeatureChanged;
  if g_WaitingUseItem.Item.S.Name = '' then begin
    sData := GetValidStr3(sData, sWhere, ['/']);
    sData := GetValidStr3(sData, sItemName, ['/']);
    sData := GetValidStr3(sData, sMakeIndex, ['/']);
    nWhere := Str_ToInt(sWhere, -1);
    nMakeIndex := Str_ToInt(sMakeIndex, -1);
    if nWhere in [0..12] then begin
      for I := Low(g_ItemArr) to High(g_ItemArr) do begin
        if g_ItemArr[I].S.Name <> '' then begin
          if (g_ItemArr[I].S.Name = sItemName) and (g_ItemArr[I].MakeIndex = nMakeIndex) then begin
            g_UseItems[nWhere] := g_ItemArr[I];
            g_ItemArr[I].S.Name := '';
            Break;
          end;
        end;
      end;
    end;
  end else begin
    if g_WaitingUseItem.Index in [0..12] then
      g_UseItems[g_WaitingUseItem.Index] := g_WaitingUseItem.Item;
  end;
  g_WaitingUseItem.Item.S.Name := '';
end;

procedure TfrmMain.ClientObjTakeOnFail();
begin
  AddItemBag(g_WaitingUseItem.Item);
  g_WaitingUseItem.Item.S.Name := '';
end;

procedure TfrmMain.ClientObjTakeOffOK(DefMsg: pTDefaultMessage; sData: string);
var
  sWhere: string;
  nWhere: Integer;
  sItemName: string;
  sMakeIndex: string;
  nMakeIndex: Integer;
begin
  g_MySelf.m_nFeature := DefMsg.Recog;
  g_MySelf.FeatureChanged;
  if g_WaitingUseItem.Item.S.Name = '' then begin
    sData := GetValidStr3(sData, sWhere, ['/']);
    sData := GetValidStr3(sData, sItemName, ['/']);
    sData := GetValidStr3(sData, sMakeIndex, ['/']);
    nWhere := Str_ToInt(sWhere, -1);
    nMakeIndex := Str_ToInt(sMakeIndex, -1);
    if nWhere in [0..12] then begin
      if (g_UseItems[nWhere].S.Name = sItemName) and (g_UseItems[nWhere].MakeIndex = nMakeIndex) then begin
        g_UseItems[nWhere].S.Name := '';
      end;
    end;
  end;
  g_WaitingUseItem.Item.S.Name := '';
end;

procedure TfrmMain.ClientObjTakeOffFail();
var
  nIndex: Integer;
begin
  if g_WaitingUseItem.Index < 0 then begin
    nIndex := -(g_WaitingUseItem.Index + 1);
    g_UseItems[nIndex] := g_WaitingUseItem.Item;
  end;
  g_WaitingUseItem.Item.S.Name := '';
end;

procedure TfrmMain.ClientObjWeigthChanged(DefMsg: pTDefaultMessage);
begin
  g_MySelf.m_Abil.Weight := DefMsg.Recog;
  g_MySelf.m_Abil.WearWeight := DefMsg.param;
  g_MySelf.m_Abil.HandWeight := DefMsg.tag;
end;

procedure TfrmMain.ClientObjGoldChanged(DefMsg: pTDefaultMessage);
begin
  SoundUtil.PlaySound(s_money);
  if DefMsg.Recog > g_MySelf.m_nGold then begin
    DScreen.AddSysMsg(IntToStr(DefMsg.Recog - g_MySelf.m_nGold) + ' ' + g_sGoldName + ' 被发现.', 30, 40, clAqua);
  end;
  g_MySelf.m_nGold := DefMsg.Recog;
  g_MySelf.m_nGameGold := MakeLong(DefMsg.param, DefMsg.tag);
end;

procedure TfrmMain.ClientObjCleanObjects();
begin
  PlayScene.CleanObjects;
  g_boMapMoving := True;
end;

procedure TfrmMain.ClientObjEatOK();
begin
  g_EatingItem.S.Name := '';
  ArrangeItemBag;
end;

procedure TfrmMain.ClientObjEatFail();
begin
  //DScreen.AddChatBoardString('TfrmMain.ClientObjEatFail:'+g_EatingItem.S.Name, clWhite, clPurple);
  AddItemBag(g_EatingItem);
  g_EatingItem.S.Name := '';
end;

procedure TfrmMain.ClientObjBuyPrice(nGold: Integer);
begin
  if g_SellDlgItem.S.Name <> '' then begin
    if nGold > 0 then
      g_sSellPriceStr := IntToStr(nGold) + ' ' + g_sGoldName {金币'}
    else g_sSellPriceStr := '???? ' + g_sGoldName {金币'};
  end;
end;

procedure TfrmMain.ClientObjSellItemOK(nGold: Integer);
begin
  FrmDlg.LastestClickTime := GetTickCount;
  g_MySelf.m_nGold := nGold;
  g_SellDlgItemSellWait.S.Name := '';
end;

procedure TfrmMain.ClientObjSellItemFail();
begin
  FrmDlg.LastestClickTime := GetTickCount;
  if g_SellDlgItemSellWait.S.Name <> '' then begin
    AddItemBag(g_SellDlgItemSellWait);
  end;
  g_SellDlgItemSellWait.S.Name := '';
  FrmDlg.DMessageDlg('您不能卖此物品.', [mbOk]);
end;

procedure TfrmMain.ClientObjRepairCost(nGold: Integer);
begin
  if g_SellDlgItem.S.Name <> '' then begin
    if nGold >= 0 then
      g_sSellPriceStr := IntToStr(nGold) + ' ' + g_sGoldName {金币}
    else g_sSellPriceStr := '???? ' + g_sGoldName {金币};
  end;
end;

procedure TfrmMain.ClientObjRepairItemOK(DefMsg: pTDefaultMessage);
begin
  if g_SellDlgItemSellWait.S.Name <> '' then begin
    FrmDlg.LastestClickTime := GetTickCount;
    g_MySelf.m_nGold := DefMsg.Recog;
    g_SellDlgItemSellWait.Dura := DefMsg.param;
    g_SellDlgItemSellWait.DuraMax := DefMsg.tag;
    AddItemBag(g_SellDlgItemSellWait);
    g_SellDlgItemSellWait.S.Name := '';
  end;
end;

procedure TfrmMain.ClientObjRepairItemFail();
begin
  FrmDlg.LastestClickTime := GetTickCount;
  if g_SellDlgItemSellWait.S.Name <> '' then begin
    AddItemBag(g_SellDlgItemSellWait);
  end;
  g_SellDlgItemSellWait.S.Name := '';
  FrmDlg.DMessageDlg('您不能修理此物品.', [mbOk]);
end;

procedure TfrmMain.ClientObjStorageOK(DefMsg: pTDefaultMessage);
begin
  FrmDlg.LastestClickTime := GetTickCount;
  if DefMsg.ident <> SM_STORAGE_OK then begin
    if DefMsg.ident = SM_STORAGE_FULL then begin
      FrmDlg.DMessageDlg('您的个人仓库已经满了，不能再保管任何东西了.', [mbOk]);
    end else begin
      FrmDlg.DMessageDlg('您不能寄存物品.', [mbOk]);
    end;
    if g_SellDlgItemSellWait.S.Name <> '' then begin
      AddItemBag(g_SellDlgItemSellWait);
    end;
  end;
  g_SellDlgItemSellWait.S.Name := '';
end;

procedure TfrmMain.ClientObjTakeBackStorageItemOK(DefMsg: pTDefaultMessage);
begin
  FrmDlg.LastestClickTime := GetTickCount;
  if DefMsg.ident <> SM_TAKEBACKSTORAGEITEM_OK then begin
    if DefMsg.ident = SM_TAKEBACKSTORAGEITEM_FULLBAG then begin
      FrmDlg.DMessageDlg('您无法携带更多物品了.', [mbOk]);
    end else begin
      FrmDlg.DMessageDlg('您无法取回物品.', [mbOk]);
    end;
  end else begin
    FrmDlg.DelStorageItem(DefMsg.Recog);
  end;
end;

procedure TfrmMain.ClientObjBuyItemSuccess(DefMsg: pTDefaultMessage);
begin
  FrmDlg.LastestClickTime := GetTickCount;
  g_MySelf.m_nGold := DefMsg.Recog;
  FrmDlg.SoldOutGoods(MakeLong(DefMsg.param, DefMsg.tag));
end;

procedure TfrmMain.ClientObjBuyItemFail(nFailCode: Integer);
begin
  FrmDlg.LastestClickTime := GetTickCount;
  case nFailCode of
    1: FrmDlg.DMessageDlg('此物品被卖出.', [mbOk]);
    2: FrmDlg.DMessageDlg('您无法携带更多物品了.', [mbOk]);
    3: FrmDlg.DMessageDlg('您没有足够的钱来购买此物品.', [mbOk]);
  end;
end;

procedure TfrmMain.ClientObjMakeDrugOK(nGold: Integer);
begin
  FrmDlg.LastestClickTime := GetTickCount;
  g_MySelf.m_nGold := nGold;
  FrmDlg.DMessageDlg('物品成功打造', [mbOk]);
end;

procedure TfrmMain.ClientObjMakeDrugFail(nFailCode: Integer);
begin
  FrmDlg.LastestClickTime := GetTickCount;
  case nFailCode of
    1: FrmDlg.DMessageDlg('坷幅啊 惯积沁嚼聪促.', [mbOk]);
    2: FrmDlg.DMessageDlg('发生了错误', [mbOk]);
    3: FrmDlg.DMessageDlg(g_sGoldName {'金币'} + '不足.', [mbOk]);
    4: FrmDlg.DMessageDlg('你缺乏所必需的物品。', [mbOk]);
  end;
end;

procedure TfrmMain.ClientObjGroupModeChanged(nOpen: Integer);
begin
  if nOpen > 0 then g_boAllowGroup := True
  else g_boAllowGroup := False;
  g_dwChangeGroupModeTick := GetTickCount;
end;

procedure TfrmMain.ClientObjCreateGroupOK();
begin
  g_dwChangeGroupModeTick := GetTickCount;
  g_boAllowGroup := True;
        {GroupMembers.Add (Myself.UserName);
        GroupMembers.Add (DecodeString(body));}
end;

procedure TfrmMain.ClientObjCreateGroupFail(nFailCode: Integer);
begin
  g_dwChangeGroupModeTick := GetTickCount;
  case nFailCode of
    -1: FrmDlg.DMessageDlg('编组还未成立或者你还不够等级创建！', [mbOk]);
    -2: FrmDlg.DMessageDlg('输入的人物名称不正确！', [mbOk]);
    -3: FrmDlg.DMessageDlg('您想邀请加入编组的人已经加入了其它组！', [mbOk]);
    -4: FrmDlg.DMessageDlg('对方不允许编组！', [mbOk]);
  end;
end;

procedure TfrmMain.ClientObjGroupAddManFail(nFailCode: Integer);
begin
  g_dwChangeGroupModeTick := GetTickCount;
  case nFailCode of
    -1: FrmDlg.DMessageDlg('编组还未成立或者你还不够等级创建！', [mbOk]);
    -2: FrmDlg.DMessageDlg('输入的人物名称不正确！', [mbOk]);
    -3: FrmDlg.DMessageDlg('已经加入编组！', [mbOk]);
    -4: FrmDlg.DMessageDlg('对方不允许编组！', [mbOk]);
    -5: FrmDlg.DMessageDlg('您想邀请加入编组的人已经加入了其它组！', [mbOk]);
  end;
end;

procedure TfrmMain.ClientObjGroupDelManFail(nFailCode: Integer);
begin
  g_dwChangeGroupModeTick := GetTickCount;
  case nFailCode of
    -1: FrmDlg.DMessageDlg('编组还未成立或者您还不够等级创建。', [mbOk]);
    -2: FrmDlg.DMessageDlg('输入的人物名称不正确！', [mbOk]);
    -3: FrmDlg.DMessageDlg('此人不在本组中！', [mbOk]);
  end;
end;

procedure TfrmMain.ClientObjOpenGuildDlgFail();
begin
  g_dwQueryMsgTick := GetTickCount;
  FrmDlg.DMessageDlg('您还没有加入行会！', [mbOk]);
end;

procedure TfrmMain.ClientObjDealtryFail();
begin
  g_dwQueryMsgTick := GetTickCount;
  FrmDlg.DMessageDlg('只有二人面对面才能进行交易。', [mbOk]);
end;

procedure TfrmMain.ClientObjDealMenu(sData: string);
begin
  g_dwQueryMsgTick := GetTickCount;
  g_sDealWho := DecodeString(sData);
  FrmDlg.OpenDealDlg;
end;

procedure TfrmMain.ClientObjDealCancel();
begin
  MoveDealItemToBag;
  if g_DealDlgItem.S.Name <> '' then begin
    AddItemBag(g_DealDlgItem);
    g_DealDlgItem.S.Name := '';
  end;
  if g_nDealGold > 0 then begin
    g_MySelf.m_nGold := g_MySelf.m_nGold + g_nDealGold;
    g_nDealGold := 0;
  end;
  FrmDlg.CloseDealDlg;
end;

procedure TfrmMain.ClientObjDealAddItemOK();
begin
  g_dwDealActionTick := GetTickCount;
  if g_DealDlgItem.S.Name <> '' then begin
    AddDealItem(g_DealDlgItem);
    g_DealDlgItem.S.Name := '';
  end;
end;

procedure TfrmMain.ClientObjDealDelItemOK();
begin
  g_dwDealActionTick := GetTickCount;
  if g_DealDlgItem.S.Name <> '' then begin
    g_DealDlgItem.S.Name := '';
  end;
end;

procedure TfrmMain.ClientObjDealDelItemFail();
begin
  g_dwDealActionTick := GetTickCount;
  if g_DealDlgItem.S.Name <> '' then begin
    DelItemBag(g_DealDlgItem.S.Name, g_DealDlgItem.MakeIndex);
    AddDealItem(g_DealDlgItem);
    g_DealDlgItem.S.Name := '';
  end;
end;

procedure TfrmMain.ClientObjDealChgGoldOK(DefMsg: pTDefaultMessage);
begin
  g_nDealGold := DefMsg.Recog;
  g_MySelf.m_nGold := MakeLong(DefMsg.param, DefMsg.tag);
  g_dwDealActionTick := GetTickCount;
end;

procedure TfrmMain.ClientObjDealChgGoldFail(DefMsg: pTDefaultMessage);
begin
  g_nDealGold := DefMsg.Recog;
  g_MySelf.m_nGold := MakeLong(DefMsg.param, DefMsg.tag);
  g_dwDealActionTick := GetTickCount;
end;

procedure TfrmMain.ClientObjDealRemotChgGold(DefMsg: pTDefaultMessage);
begin
  g_nDealRemoteGold := DefMsg.Recog;
  SoundUtil.PlaySound(s_money);
end;

procedure TfrmMain.ClientGetReadMiniMapFail();
begin
  g_dwQueryMsgTick := GetTickCount;
  DScreen.AddChatBoardString('No MiniMap Available.', clWhite, clRed);
  g_nMiniMapIndex := -1;
end;

procedure TfrmMain.ClientObjGuildAddMemberFail(nFailCode: Integer);
begin
  case nFailCode of
    1: FrmDlg.DMessageDlg('你没有权利使用这个命令。', [mbOk]);
    2: FrmDlg.DMessageDlg('想加入进来的成员应该来面对掌门人。', [mbOk]);
    3: FrmDlg.DMessageDlg('对方已经加入我们的行会。', [mbOk]);
    4: FrmDlg.DMessageDlg('对方已经加入其他行会。', [mbOk]);
    5: FrmDlg.DMessageDlg('对方不允许加入行会。', [mbOk]);
  end;
end;

procedure TfrmMain.ClientObjGuildDelMemberFail(nFailCode: Integer);
begin
  case nFailCode of
    1: FrmDlg.DMessageDlg('不能使用命令！', [mbOk]);
    2: FrmDlg.DMessageDlg('此人非本行会成员！', [mbOk]);
    3: FrmDlg.DMessageDlg('行会掌门人不能开除自己！', [mbOk]);
    4: FrmDlg.DMessageDlg('不能使用命令Z！', [mbOk]);
  end;
end;

procedure TfrmMain.ClientObjGuildRankUpdateFail(nFailCode: Integer);
begin
  case nFailCode of
    -2: FrmDlg.DMessageDlg('[提示信息] 掌门人位置不能为空。', [mbOk]);
    -3: FrmDlg.DMessageDlg('[提示信息] 新的行会掌门人已经被传位。', [mbOk]);
    -4: FrmDlg.DMessageDlg('[提示信息] 一个行会最多只能有二个掌门人。', [mbOk]);
    -5: FrmDlg.DMessageDlg('[提示信息] 掌门人位置不能为空。', [mbOk]);
    -6: FrmDlg.DMessageDlg('[提示信息] 不能添加成员/删除成员。', [mbOk]);
    -7: FrmDlg.DMessageDlg('[提示信息] 职位重复或者出错。', [mbOk]);
  end;
end;

procedure TfrmMain.ClientObjGuildMakeAllyFail(nFailCode: Integer);
begin
  case nFailCode of
    -1: FrmDlg.DMessageDlg('您无此权限！', [mbOk]);
    -2: FrmDlg.DMessageDlg('结盟失败！', [mbOk]);
    -3: FrmDlg.DMessageDlg('行会结盟必须双方掌门人面对面！', [mbOk]);
    -4: FrmDlg.DMessageDlg('对方行会掌门人不允许结盟！', [mbOk]);
  end;
end;

procedure TfrmMain.ClientObjGuildBreakAllyFail(nFailCode: Integer);
begin
  case nFailCode of
    -1: FrmDlg.DMessageDlg('解除结盟！', [mbOk]);
    -2: FrmDlg.DMessageDlg('此行会不是您行会的结盟行会！', [mbOk]);
    -3: FrmDlg.DMessageDlg('没有此行会！', [mbOk]);
  end;
end;

procedure TfrmMain.ClientObjBuildGuildOK();
begin
  FrmDlg.LastestClickTime := GetTickCount;
  FrmDlg.DMessageDlg('行会建立成功。', [mbOk]);
end;

procedure TfrmMain.ClientObjBuildGuildFail(nFailCode: Integer);
begin
  FrmDlg.LastestClickTime := GetTickCount;
  case nFailCode of
    -1: FrmDlg.DMessageDlg('您已经加入其它行会。', [mbOk]);
    -2: FrmDlg.DMessageDlg('缺少创建费用。', [mbOk]);
    -3: FrmDlg.DMessageDlg('你没有准备好需要的全部物品。', [mbOk]);
  else FrmDlg.DMessageDlg('创建行会失败！！！', [mbOk]);
  end;
end;

procedure TfrmMain.ClientObjMenuOK(sData: string);
begin
  FrmDlg.LastestClickTime := GetTickCount;
  if sData <> '' then
    FrmDlg.DMessageDlg(DecodeString(sData), [mbOk]);
end;

procedure TfrmMain.ClientObjDlgMsg(sData: string);
begin
  if sData <> '' then
    FrmDlg.DMessageDlg(DecodeString(sData), [mbOk]);
end;

procedure TfrmMain.ClientObjPalyDice(DefMsg: pTDefaultMessage;
  sData: string);
var
  MessageBodyWL: TMessageBodyWL;
  sBody: string;
begin
  sBody := Copy(sData, GetCodeMsgSize(SizeOf(TMessageBodyWL) * 4 / 3) + 1, Length(sData));
  DecodeBuffer(sData, @MessageBodyWL, SizeOf(TMessageBodyWL));
  sBody := DecodeString(sBody);
  FrmDlg.m_nDiceCount := DefMsg.param; //QuestActionInfo.nParam1
  FrmDlg.m_Dice[0].nDicePoint := LoByte(LoWord(MessageBodyWL.lParam1)); //UserHuman.m_DyVal[0]
  FrmDlg.m_Dice[1].nDicePoint := HiByte(LoWord(MessageBodyWL.lParam1)); //UserHuman.m_DyVal[0]
  FrmDlg.m_Dice[2].nDicePoint := LoByte(HiWord(MessageBodyWL.lParam1)); //UserHuman.m_DyVal[0]
  FrmDlg.m_Dice[3].nDicePoint := HiByte(HiWord(MessageBodyWL.lParam1)); //UserHuman.m_DyVal[0]

  FrmDlg.m_Dice[4].nDicePoint := LoByte(LoWord(MessageBodyWL.lParam2)); //UserHuman.m_DyVal[0]
  FrmDlg.m_Dice[5].nDicePoint := HiByte(LoWord(MessageBodyWL.lParam2)); //UserHuman.m_DyVal[0]
  FrmDlg.m_Dice[6].nDicePoint := LoByte(HiWord(MessageBodyWL.lParam2)); //UserHuman.m_DyVal[0]
  FrmDlg.m_Dice[7].nDicePoint := HiByte(HiWord(MessageBodyWL.lParam2)); //UserHuman.m_DyVal[0]

  FrmDlg.m_Dice[8].nDicePoint := LoByte(LoWord(MessageBodyWL.lTag1)); //UserHuman.m_DyVal[0]
  FrmDlg.m_Dice[9].nDicePoint := HiByte(LoWord(MessageBodyWL.lTag1)); //UserHuman.m_DyVal[0]
  FrmDlg.DialogSize := 0;
  FrmDlg.DMessageDlg('', []);
  SendMerchantDlgSelect(DefMsg.Recog, sBody);
end;

procedure TfrmMain.ClientObjBuyShopItemFail(nFailCode: Integer);
begin
  case nFailCode of
    -1: FrmDlg.DMessageDlg('[失败]你的' + g_sGameGoldName + '不足！！！', [mbOk]);
    -2: FrmDlg.DMessageDlg('[失败]你包裹已满！！！', [mbOk]);
    -3: FrmDlg.DMessageDlg('[失败]你购买的物品不存在！！！', [mbOk]);
  else FrmDlg.DMessageDlg('[失败]未知错误！！！', [mbOk]);
  end;
end;

procedure TfrmMain.ClientObjBuySellOffItemFail(nFailCode: Integer);
begin
  case nFailCode of
    1: FrmDlg.DMessageDlg('[失败]你购买的物品不存在！！！', [mbOk]);
    2: FrmDlg.DMessageDlg('[失败]你包裹已满！！！', [mbOk]);
    3: FrmDlg.DMessageDlg('[失败]你的' + g_sGameGoldName + '不足！！！', [mbOk]);
  else FrmDlg.DMessageDlg('[失败]未知错误！！！', [mbOk]);
  end;
end;

procedure TfrmMain.ClientObjSellSellOffItemOK();
begin
  g_SellDlgItemSellWait.S.Name := '';
        //g_MySelf.m_nGameGold := Msg.Recog;
        //FrmDlg.DMessageDlg('寄售物品成功！！！', [mbOk]);
end;

procedure TfrmMain.ClientObjSellSellOffItemFail(nFailCode: Integer);
begin
  AddItemBag(g_SellDlgItemSellWait);
  g_SellDlgItemSellWait.S.Name := '';
  case nFailCode of
    -1, -4: FrmDlg.DMessageDlg('[失败]此物品不允许寄售！！！', [mbOk]);
    -3: FrmDlg.DMessageDlg('[失败]你寄售的物品已经超过最大限制！！！', [mbOk]);
  else FrmDlg.DMessageDlg('[失败]未知错误！！！', [mbOk]);
  end;
end;

procedure TfrmMain.ClientObjChangeItemOK(sData: string);
var
  Item: TClientItem;
begin
  if sData <> '' then begin
    DecodeBuffer(sData, @Item, SizeOf(TClientItem));
    AddItemBag(Item);
  end else begin
    AddItemBag(g_SellDlgItem);
  end;
  g_sSellPriceStr := '';
  g_SellDlgItem.S.Name := '';
  g_SellDlgItemSellWait.S.Name := '';
        //g_MySelf.m_nGameGold := Msg.Recog;
  //FrmDlg.DMessageDlg('TfrmMain.ClientObjChangeItemOK！！！', [mbOk]);
end;

procedure TfrmMain.ClientObjChangeItemFail(nFailCode: Integer);
begin
  AddItemBag(g_SellDlgItem);
  g_sSellPriceStr := '';
  g_SellDlgItemSellWait.S.Name := '';
  g_SellDlgItem.S.Name := '';
  {case nFailCode of
    -1, -4: FrmDlg.DMessageDlg('[失败]此物品不允许寄售！！！', [mbOk]);
    -3: FrmDlg.DMessageDlg('[失败]你寄售的物品已经超过最大限制！！！', [mbOk]);
  else FrmDlg.DMessageDlg('[失败]未知错误！！！', [mbOk]);
  end;}
end;

procedure TfrmMain.ClientObjUpgradeItemOK(sData: string);
begin
  if sData <> '' then begin
    DecodeBuffer(sData, @g_UpgradeItems[0], SizeOf(TClientItem));
    {DebugOutStr('TfrmMain.ClientObjUpgradeItemOK:' + sData);
    DebugOutStr('TfrmMain.ClientObjUpgradeItemOK Item:' + g_UpgradeItems[0].S.Name);
    DebugOutStr('TfrmMain.ClientObjUpgradeItemOK StdMode:' + IntToStr(g_UpgradeItems[0].S.StdMode));
    DebugOutStr('TfrmMain.ClientObjUpgradeItemOK Weight:' + IntToStr(g_UpgradeItems[0].S.Weight));
    DebugOutStr('TfrmMain.ClientObjUpgradeItemOK AniCount:' + IntToStr(g_UpgradeItems[0].S.AniCount));
    DebugOutStr('TfrmMain.ClientObjUpgradeItemOK Source:' + IntToStr(g_UpgradeItems[0].S.Source));
    DebugOutStr('TfrmMain.ClientObjUpgradeItemOK Reserved:' + IntToStr(g_UpgradeItems[0].S.Reserved));
    DebugOutStr('TfrmMain.ClientObjUpgradeItemOK Looks:' + IntToStr(g_UpgradeItems[0].S.looks));
    DebugOutStr('TfrmMain.ClientObjUpgradeItemOK AC:' + IntToStr(g_UpgradeItems[0].S.AC));
    DebugOutStr('TfrmMain.ClientObjUpgradeItemOK MAC:' + IntToStr(g_UpgradeItems[0].S.MAC));
    DebugOutStr('TfrmMain.ClientObjUpgradeItemOK DC:' + IntToStr(g_UpgradeItems[0].S.DC));
    DebugOutStr('TfrmMain.ClientObjUpgradeItemOK MC:' + IntToStr(g_UpgradeItems[0].S.MC));
    DebugOutStr('TfrmMain.ClientObjUpgradeItemOK SC:' + IntToStr(g_UpgradeItems[0].S.SC));
    DebugOutStr('TfrmMain.ClientObjUpgradeItemOK sDescr:' + g_UpgradeItems[0].S.sDescr);}
  end;
  g_UpgradeItemsWait[0].S.Name := '';
  g_UpgradeItemsWait[1].S.Name := '';
  g_UpgradeItemsWait[2].S.Name := '';
  DScreen.AddChatBoardString('You have successfully upgraded the Item.', clWhite, clRed);
  //DebugOutStr('TfrmMain.ClientObjUpgradeItemOK EncodeBuffer:' + EncodeBuffer(@g_UpgradeItems[0], SizeOf(TClientItem)));
  //FrmDlg.DMessageDlg('TfrmMain.ClientObjChangeItemOK！！！', [mbOk]);
end;

procedure TfrmMain.ClientObjUpgradeItemFail(nFailCode: Integer;
  sData: string);
var
  Item: TClientItem;
begin
  //DebugOutStr('TfrmMain.ClientObjUpgradeItemFail:' + sData);
  if sData <> '' then begin
    //g_UpgradeItemsWait[0].S.sDescr := '';
    DecodeBuffer(sData, @g_UpgradeItemsWait[0], SizeOf(TClientItem));
    //g_UpgradeItemsWait[0] := Item;
    {DebugOutStr('TfrmMain.ClientObjUpgradeItemFail Item:' + g_UpgradeItemsWait[0].S.Name);
    DebugOutStr('TfrmMain.ClientObjUpgradeItemFail Looks:' + IntToStr(g_UpgradeItemsWait[0].S.looks));
    DebugOutStr('TfrmMain.ClientObjUpgradeItemFail sDescr:' + g_UpgradeItemsWait[0].S.sDescr);
    DebugOutStr('TfrmMain.ClientObjUpgradeItemFail Reserved:' + IntToStr(g_UpgradeItemsWait[0].S.Reserved));}
  end;
  case nFailCode of
    0: begin
        g_UpgradeItems := g_UpgradeItemsWait;
        DScreen.AddChatBoardString('You have failed to upgrade this Item.', clWhite, clRed);
      end;
    -1: begin
        g_UpgradeItems[0].S.Name := '';
        g_UpgradeItems[1].S.Name := '';
        g_UpgradeItems[2].S.Name := '';
        DScreen.AddChatBoardString('You have broken this Item.', clWhite, clRed);
      end;
    -2: begin
        g_UpgradeItems[0] := g_UpgradeItemsWait[0];
        g_UpgradeItems[1].S.Name := '';
        g_UpgradeItems[2].S.Name := '';
        DScreen.AddChatBoardString('You have failed to upgrade this Item.', clWhite, clRed);
      end;
  end;
  //Move(g_UpgradeItemsWait,g_UpgradeItems,SizeOf(g_UpgradeItems));
  g_UpgradeItemsWait[0].S.Name := '';
  g_UpgradeItemsWait[1].S.Name := '';
  g_UpgradeItemsWait[2].S.Name := '';
 { DebugOutStr('g_UpgradeItems[0]Item:' + g_UpgradeItems[0].S.Name);
  DebugOutStr('g_UpgradeItems[0]Looks:' + IntToStr(g_UpgradeItems[0].S.looks));
  DebugOutStr('g_UpgradeItems[0]sDescr:' + g_UpgradeItems[0].S.sDescr);   }
end;

procedure TfrmMain.ClientObjGetCastle(DefMsg: pTDefaultMessage); //沙行会信息
var
  Actor: TActor;
begin
  if DefMsg.Recog = g_MySelf.m_nRecogId then begin
    g_MySelf.m_btCastle := DefMsg.param;
  end else begin
    Actor := PlayScene.FindActor(DefMsg.Recog);
    if (Actor <> nil) and (Actor is THumActor) then begin
      THumActor(Actor).m_btCastle := DefMsg.param;
    end;
  end;
end;

procedure TfrmMain.ClientObjShowBox(nBoxType: Integer);
begin
  g_btBoxType := nBoxType;
  g_nBoxIndex := 0;
  g_boOpenItemBox := False;
  g_boShowItemBox := True;

  g_boGetBoxItem := False;
  g_boGetBoxItemOK := False;
  g_btBoxItem := 4;
  g_btRandomBoxItem := 4;
  g_btSelBoxItemIndex := 4;
  g_nBoxIndex := 0;
  g_nBoxButtonIndex := 515;

  g_dwBoxFlashTick := GetTickCount;
  g_nBoxTrunCount := Random(8);
  g_dwChgSpeed := 30;
  g_nChgCount := 0;
  g_boSelItemOK := False;
  g_nBoxFlashIdx := 0;

  FrmDlg.DBoxItems.Visible := False;
  FrmDlg.DItemBox.Visible := True;
end;

procedure TfrmMain.ClientObjOpenBoxOK(DefMsg: pTDefaultMessage;
  sData: string);
var
  I, Index: Integer;
  Str, Data, sMsg: string;
  cu: TClientItem;
begin
  if DefMsg.param > 0 then begin
    g_btBoxType := DefMsg.Recog; //;
    g_nBoxIndex := 0;
    g_boOpenItemBox := True;
    g_boShowItemBox := False;

    g_boGetBoxItem := False;
    g_boGetBoxItemOK := False;
    g_btBoxItem := 4;
    g_btRandomBoxItem := 4;
    g_btSelBoxItemIndex := 4;
    g_nBoxIndex := 0;
    g_nBoxButtonIndex := 515;

    g_dwBoxFlashTick := GetTickCount;
    g_nBoxTrunCount := Random(8);
    g_dwChgSpeed := 30;
    g_nChgCount := 0;
    g_boSelItemOK := False;
    g_nBoxFlashIdx := 0;
  end;
  //DebugOutStr('TfrmMain.ClientObjOpenBoxOK');
  //SafeFillChar(g_BoxItems, SizeOf(TClientItem) * High(g_BoxItems), #0);
  for I := Low(g_BoxItems) to High(g_BoxItems) do begin
    g_BoxItems[I].S.Name := '';
  end;
  sMsg := sData;
  //DebugOutStr(sMsg);
  while True do begin
    if sMsg = '' then Break;
    sMsg := GetValidStr3(sMsg, Str, ['/']);
    sMsg := GetValidStr3(sMsg, Data, ['/']);
    Index := Str_ToInt(Str, -1);
    if Index in [0..8] then begin
      if Data <> '' then begin
        DecodeBuffer(Data, @cu, SizeOf(TClientItem));
        g_BoxItems[Index] := cu;
        //DebugOutStr(cu.S.Name);
      end;
    end;
  end;
  g_OpenBoxingItem.S.Name := '';
  g_boOpenItemBox := True;
  SoundUtil.PlaySound(s_Openbox);
  if DefMsg.param > 0 then begin
    FrmDlg.DBoxItems.Visible := True;
    //FrmDlg.DBoxItemGrid.Visible := FrmDlg.DBoxItems.Visible;
    //Showmessage('ok');
  end;
end;

procedure TfrmMain.ClientObjOpenBoxFail(nFailCode: Integer);
begin
  if g_OpenBoxingItem.S.Name <> '' then begin
    AddItemBag(g_OpenBoxingItem);
    g_OpenBoxingItem.S.Name := '';
  end;
end;

procedure TfrmMain.ClientObjGetBoxIndex(nSelBoxItemIdx: Integer);
begin
  //g_dwRandomBoxItemTick := GetTickCount;
  g_boGetBoxItemOK := True;
  g_btSelBoxItemIndex := nSelBoxItemIdx;
  //DebugOutStr('g_btSelBoxItemIndex '+INTTOSTR(g_btSelBoxItemIndex));
end;

procedure TfrmMain.ClientObjGetBackBoxOK();
begin
  g_btBoxType := 0;
  //FrmDlg.DBoxItems.Visible := False;
  FrmDlg.DItemBox.Visible := False;
  g_boShowItemBox := False;
  //Showmessage('TfrmMain.ClientObjGetBackBoxOK();');
end;

procedure TfrmMain.ClientObjOpenBook(nMerchant, nBookType: Integer);
begin
  g_nCurMerchant := nMerchant;
  g_nMDlgX := g_MySelf.m_nCurrX;
  g_nMDlgY := g_MySelf.m_nCurrY;
  FrmDlg.ResetMenuDlg;
  FrmDlg.CloseMDlg;
  FrmDlg.CloseBigMDlg;
  FrmDlg.SetBookType(nBookType);
end;

procedure TfrmMain.ClientObjCloseMDlg();
begin
  FrmDlg.CloseMDlg;
  FrmDlg.CloseBigMDlg;
  FrmDlg.DBook.Visible := False;
end;

procedure TfrmMain.ClientGetDelChr(DefMsg: pTDefaultMessage;
  sData: string);
var
  I: Integer;
  Data, sMsg: string;
  DelChar: TDelChar;
begin
  with SelectChrScene do begin
    DelChrCount := 0;
    SelDelChar := -1;
    for I := Low(DelCharArray) to High(DelCharArray) do begin
      DelCharArray[I].sChrName := '';
    end;
    sMsg := sData;
  //DebugOutStr(sMsg);
    while True do begin
      if sMsg = '' then Break;
      sMsg := GetValidStr3(sMsg, Data, ['/']);
      if Data <> '' then begin
        DecodeBuffer(Data, @DelChar, SizeOf(TDelChar));
        for I := Low(DelCharArray) to High(DelCharArray) do begin
          if DelCharArray[I].sChrName = '' then begin
            DelCharArray[I] := DelChar;
            Break;
          end;
        end;
        //DebugOutStr(cu.S.Name);
      end;
    end;
    SelChrCreditsClick;
  end;
end;

procedure TfrmMain.ClientGetDelChrFail(nFailError: Integer);
begin
  FrmDlg.DMessageDlg('[失败] 你最多只能为一个账号设置2个角色。', [mbOk]);
end;

procedure TfrmMain.ClientGetDelChrOK(sData: string);
var
  I, select: Integer;
  Str, uname, sjob, shair, slevel, ssex: string;
begin
  SelectChrScene.ClearChrs;
  Str := DecodeString(sData);
  for I := 0 to 1 do begin
    Str := GetValidStr3(Str, uname, ['/']);
    Str := GetValidStr3(Str, sjob, ['/']);
    Str := GetValidStr3(Str, shair, ['/']);
    Str := GetValidStr3(Str, slevel, ['/']);
    Str := GetValidStr3(Str, ssex, ['/']);
    select := 0;
    if (uname <> '') and (slevel <> '') and (ssex <> '') then begin
      if uname[1] = '*' then begin
        select := I;
        uname := Copy(uname, 2, Length(uname) - 1);
      end;
      SelectChrScene.AddChr(uname, Str_ToInt(sjob, 0), Str_ToInt(shair, 0), Str_ToInt(slevel, 0), Str_ToInt(ssex, 0));
    end;
    with SelectChrScene do begin
      if select = 0 then begin
        ChrArr[0].FreezeState := False;
        ChrArr[0].Selected := True;
        ChrArr[1].FreezeState := True;
        ChrArr[1].Selected := False;
      end else begin
        ChrArr[0].FreezeState := True;
        ChrArr[0].Selected := False;
        ChrArr[1].FreezeState := False;
        ChrArr[1].Selected := True;
      end;
    end;
  end;
  PlayScene.EdAccountt.Text := LoginID;
  //2004/05/17  强行登录
  {
  if SelectChrScene.ChrArr[0].Valid and SelectChrScene.ChrArr[0].Selected then PlayScene.EdChrNamet.Text := SelectChrScene.ChrArr[0].UserChr.Name;
  if SelectChrScene.ChrArr[1].Valid and SelectChrScene.ChrArr[1].Selected then PlayScene.EdChrNamet.Text := SelectChrScene.ChrArr[1].UserChr.Name;
  PlayScene.EdAccountt.Visible:=True;
  PlayScene.EdChrNamet.Visible:=True;
  }
  //2004/05/17
end;

procedure TfrmMain.ClientGetRandomDIB(boOpen: Boolean; BitCount: Integer; sData: string);
var
  I, nSize, nX: Integer;
  OColor: TColor;
  DIB: TDIB;
  DIB1: TDIB;
  sText, sFontName: string;
  Texture: TTexture;
begin
  if boOpen and (sData <> '') then begin
    FrmDlg.ShowRandomDlg;

    //g_RandomSurface.Noise(clBlack);
    //g_RandomSurface.Fill(0);  'Comic Sans MS';
    //Texture.SetSize(Texture.TextWidth(DecryptString(sData))*2, Texture.TextHeight('0'));
    sFontName := Canvas.Font.Name;
    nSize := Canvas.Font.Size;
    OColor := Canvas.Font.Color;
    Canvas.Font.Name := 'Comic Sans MS';
    Canvas.Font.Size := 30;
    Canvas.Font.Style := [fsBold];
    Canvas.Font.Color := clWhite;

    g_RandomSurface.Fill($005894B8);
    g_RandomSurface.TextOut(15 + Random(10), 0, DecryptString(sData)); //$00050505
    //g_RandomSurface.Side($00050505,clGreen);
    g_RandomSurface.Noise($00050505);
    Canvas.Font.Name := sFontName;
    Canvas.Font.Size := nSize;
    Canvas.Font.Style := [];
    Canvas.Font.Color := OColor;
    //g_RandomSurface.LoadFromDIB(DIB);

    //DIB.Free;
  end;
end;

//挑战相关

procedure TfrmMain.ClientObjDueltryFail(nFailCode: Integer);
begin
  g_dwQueryMsgTick := GetTickCount;
  case nFailCode of
    0: FrmDlg.DMessageDlg('只有二人面对面才能申请挑战。', [mbOk]);
    -1: FrmDlg.DMessageDlg('你们的挑战还没有分出胜负。', [mbOk]);
    -2: FrmDlg.DMessageDlg('你或者对方的挑战申请已经超出限制。', [mbOk]);
  else FrmDlg.DMessageDlg('申请挑战失败。', [mbOk]);
  end;
end;

procedure TfrmMain.ClientObjDuelMenu(sData: string);
{type
  TOpen = procedure;
var
  nBuffer: Integer;
  sBuffer: string;
  RegInfo: TRegInfo; }
begin
 { Move(g_Buffer^, nBuffer, SizeOf(Integer));
  SetLength(sBuffer, nBuffer);
  Move(g_Buffer[SizeOf(Integer)], sBuffer[1], nBuffer);
  DecryptBuffer(sBuffer, @RegInfo, SizeOf(TRegInfo));
  if (not RegInfo.boShare) and (RegInfo.nProcedure[2] > 0) then
    if RegInfo.nProcedure[2] > 0 then TOpen(RegInfo.nProcedure[2]);  }
  FrmDlg.OpenDuelDlg;
end;

procedure TfrmMain.ClientObjDuelCancel();
begin
  MoveDuelItemToBag;
  if g_DuelDlgItem.S.Name <> '' then begin
    AddItemBag(g_DuelDlgItem);
    g_DuelDlgItem.S.Name := '';
  end;
  if g_nDuelGold > 0 then begin
    g_MySelf.m_nGameGold := g_MySelf.m_nGameGold + g_nDuelGold;
    g_nDuelGold := 0;
  end;
  FrmDlg.CloseDuelDlg;
end;

procedure TfrmMain.ClientObjDuelAddItemOK();
begin
  g_dwDuelActionTick := GetTickCount;
  if g_DuelDlgItem.S.Name <> '' then begin
    AddDuelItem(g_DuelDlgItem);
    g_DuelDlgItem.S.Name := '';
  end;
end;

procedure TfrmMain.ClientObjDuelDelItemOK();
begin
  g_dwDuelActionTick := GetTickCount;
  if g_DuelDlgItem.S.Name <> '' then begin
    g_DuelDlgItem.S.Name := '';
  end;
end;

procedure TfrmMain.ClientObjDuelDelItemFail();
begin
  g_dwDuelActionTick := GetTickCount;
  if g_DuelDlgItem.S.Name <> '' then begin
    DelItemBag(g_DuelDlgItem.S.Name, g_DuelDlgItem.MakeIndex);
    AddDuelItem(g_DuelDlgItem);
    g_DuelDlgItem.S.Name := '';
    g_MovingItem.Item.S.Name := '';
    g_boItemMoving := False;
    g_MovingItem.Owner := nil;
  end;
end;

procedure TfrmMain.ClientObjDuelChgGoldOK(DefMsg: pTDefaultMessage);
begin
  g_nDuelGold := DefMsg.Recog;
  g_MySelf.m_nGameGold := MakeLong(DefMsg.param, DefMsg.tag);
  g_dwDuelActionTick := GetTickCount;
  //DScreen.AddChatBoardString('TfrmMain.ClientObjDuelChgGoldOK: ' + IntToStr(g_nDuelGold), clWhite, clPurple);
end;

procedure TfrmMain.ClientObjDuelChgGoldFail(DefMsg: pTDefaultMessage);
begin
  g_nDuelGold := DefMsg.Recog;
  g_MySelf.m_nGameGold := MakeLong(DefMsg.param, DefMsg.tag);
  g_dwDuelActionTick := GetTickCount;
  //DScreen.AddChatBoardString('TfrmMain.ClientObjDuelChgGoldFail: ' + IntToStr(g_nDuelGold), clWhite, clPurple);
  g_MovingItem.Item.S.Name := '';
  g_boItemMoving := False;
  g_MovingItem.Owner := nil;
end;

procedure TfrmMain.ClientObjDuelRemotChgGold(DefMsg: pTDefaultMessage);
begin
  g_nDuelRemoteGold := DefMsg.Recog;
  SoundUtil.PlaySound(s_money);
end;

procedure TfrmMain.ClientGetDuelRemoteAddItem(body: string);
var
  ci: TClientItem;
begin
  if body <> '' then begin
    DecodeBuffer(body, @ci, SizeOf(TClientItem));
    AddDuelRemoteItem(ci);
  end;
end;

procedure TfrmMain.ClientGetDuelRemoteDelItem(body: string);
var
  ci: TClientItem;
begin
  if body <> '' then begin
    DecodeBuffer(body, @ci, SizeOf(TClientItem));
    DelDuelRemoteItem(ci);
  end;
end;

procedure TfrmMain.ClientObjChangeState(DefMsg: pTDefaultMessage); //护体神盾
var
  Actor: TActor;
begin
  if DefMsg.Recog = g_MySelf.m_nRecogId then begin
    g_MySelf.m_btState := DefMsg.param;
    if g_MySelf.m_btState = 0 then begin
      g_MySelf.m_nStateStartFrame := 790;
      g_MySelf.m_nStateEndFrame := 799;
      PlaySound(s_hero_shield);
    end else begin
      g_MySelf.m_nStateStartFrame := 470;
      g_MySelf.m_nStateEndFrame := 474;
      PlaySound(s_hero_shield);
    end;
  end else begin
    Actor := PlayScene.FindActor(DefMsg.Recog);
    if (Actor <> nil) then begin
      Actor.m_btState := DefMsg.param;
      if Actor.m_btState = 0 then begin
        Actor.m_nStateStartFrame := 790;
        Actor.m_nStateEndFrame := 799;
        PlaySound(s_hero_shield);
      end else begin
        Actor.m_nStateStartFrame := 470;
        Actor.m_nStateEndFrame := 474;
        PlaySound(s_hero_shield);
      end;
    end;
  end;
end;

procedure TfrmMain.ClientObjFindItemOK(sData: string; nWho: Integer);
var
  I, II: Integer;
  ItemList: TStringList;
  ci: TClientItem;
  ItemLabel: TItemLabel;
  d: TDControl;
begin
  if sData <> '' then begin
    DecodeBuffer(sData, @ci, SizeOf(TClientItem));
    with FrmDlg do begin
      for I := 0 to DMemoChat.Count - 1 do begin
        ItemList := DMemoChat.Items[I];
        for II := 0 to ItemList.Count - 1 do begin
          d := TDControl(ItemList.Objects[II]);
          if (d = TDControl(nWho)) and (d is TItemLabel) then begin
            ItemLabel := TItemLabel(d);
            ItemLabel.ClientItem := ci;
           // Showmessage('TfrmMain.ClientObjFindItemOK');
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.ClientObjFindItemFail();
begin

end;

procedure TfrmMain.ClientSnow(DefMsg: pTDefaultMessage); //下雪
begin
  g_boSnow := DefMsg.param > 0;
  g_nSnowLev := DefMsg.Recog;
end;

procedure TfrmMain.ClientStore(DefMsg: pTDefaultMessage); //摆摊
var
  Actor: TActor;
begin
  if DefMsg.Recog = g_MySelf.m_nRecogId then begin
    g_MySelf.m_boStartStore := DefMsg.param > 0;
    if (g_nStoreMasterRecogId = DefMsg.Recog) and (not g_MySelf.m_boStartStore) then begin
      FrmDlg.CloseUserStoreDlg;
    end;
  end else begin
    Actor := PlayScene.FindActor(DefMsg.Recog);
    if (Actor <> nil) and (Actor is THumActor) then begin
      Actor.m_boStartStore := DefMsg.param > 0;
      if (g_nStoreMasterRecogId = DefMsg.Recog) and (not Actor.m_boStartStore) then begin
        FrmDlg.CloseUserStoreDlg;
      end
    end;
  end;
end;

procedure TfrmMain.ClientDelStoreItem(body: string);
var
  ci: TClientItem;
begin
  if body <> '' then begin
    DecodeBuffer(body, @ci, SizeOf(TClientItem));
    DelStoreItem(ci);
    DelStoreRemoteItem(ci);
  end;
end;

procedure TfrmMain.ClientGetSendUserStoreState(body: string);
type
  TOpen = procedure;
var
  UserStoreState: TUserStoreStateInfo;
  nBuffer: Integer;
  sBuffer: string;
  RegInfo: TRegInfo;
begin
  FillChar(UserStoreState, SizeOf(TUserStoreStateInfo), #0);
  DecodeBuffer(body, @UserStoreState, SizeOf(TUserStoreStateInfo));
  UserStoreState.NameColor := GetRGB(UserStoreState.NameColor);
  Move(UserStoreState.UseItems, g_StoreRemoteItems, SizeOf(TStoreItem) * 15);
  g_sStoreMasterName := UserStoreState.UserName;
  g_nStoreMasterRecogId := UserStoreState.RecogId;

  {Move(g_Buffer^, nBuffer, SizeOf(Integer));
  SetLength(sBuffer, nBuffer);
  Move(g_Buffer[SizeOf(Integer)], sBuffer[1], nBuffer);
  DecryptBuffer(sBuffer, @RegInfo, SizeOf(TRegInfo));
  if (not RegInfo.boShare) and (RegInfo.nProcedure[4] > 0) then TOpen(RegInfo.nProcedure[4]);}
  FrmDlg.OpenUserStoreDlg;
end;

procedure TfrmMain.ClientObjBuyStoreItemOK(); //摆摊物品购买成功
begin
  ClearMoveRect();
  g_SelectStoreItem.Item.S.Name := '';
end;

procedure TfrmMain.ClientObjBuyStoreItemFail(DefMsg: pTDefaultMessage); //摆摊物品购买失败
begin
  case DefMsg.Recog of
    -1: FrmDlg.DMessageDlg('[失败] 你的' + GetStorePriceName(DefMsg.tag) + '不足！', [mbOk]);
    -2: FrmDlg.DMessageDlg('[失败] 该物品不存在！', [mbOk]);
    -3: FrmDlg.DMessageDlg('[失败] 你的包裹已经满了！', [mbOk]);
  else FrmDlg.DMessageDlg('[失败] 未知原因！', [mbOk]);
  end;
end;

procedure TfrmMain.ClientAutoGotoXY(nX, nY: Integer; sMapName: string);
begin
  if (g_MySelf <> nil) and (not g_MySelf.m_boDeath) then begin
 // if sMapName <> g_sMapName then begin
  //end else begin
    if (abs(g_MySelf.m_nCurrX - nX) <= 1) and (abs(g_MySelf.m_nCurrY - nY) <= 1) then begin
      LegendMap.Stop;
      DScreen.AddChatBoardString(Format('You have reached the Coordinates set (%d:%d).', [nX, nY]), GetRGB(154), clWhite);
    end else begin
      if LegendMap.StartFind then begin
        if (LegendMap.EndX <> nX) or (LegendMap.EndY <> nY) then
          LegendMap.Stop
        else
          Exit;
      end;
      LegendMap.Stop;

      LegendMap.BeginX := g_MySelf.m_nCurrX;
      LegendMap.BeginY := g_MySelf.m_nCurrY;
      LegendMap.EndX := nX;
      LegendMap.EndY := nY;
      DScreen.AddChatBoardString(Format('Automatically traveling to the location at (%d:%d), press any mouse button to stop.', [nX, nY]), GetRGB(154), clWhite);
    end;
  end;
end;

procedure TfrmMain.ClientTakeOnItem(nMakeIndex, nWhere: Integer; sItemName: string);
var
  where: Integer;
  I: Integer;
  flag: Boolean;
  Item: TClientItem;
begin
  if g_MySelf = nil then Exit;
  if nWhere in [0..12] then begin
    Item.S.Name := '';
    for I := 0 to Length(g_ItemArr) - 1 do begin
      if g_ItemArr[I].S.Name <> '' then begin
        if (Comparetext(g_ItemArr[I].S.Name, sItemName) = 0) and (g_ItemArr[I].MakeIndex = nMakeIndex) then begin
          Item := g_ItemArr[I];
          g_ItemArr[I].S.Name := '';
          Break;
        end;
      end;
    end;
    if Item.S.Name <> '' then begin
      g_UseItems[nWhere] := Item;
    end else begin
      SendDelayMsg(g_MySelf, SM_TAKEONITEM, nWhere, nMakeIndex, 0, 0, sItemName, 1000);
      //DScreen.AddChatBoardString('TfrmMain.ClientTakeOnItem:' + sItemName, GetRGB(154), clWhite);
    end;
  end;
end;

procedure TfrmMain.ClientTakeOffItem(nMakeIndex, nWhere: Integer; sItemName: string);
begin
  if g_MySelf = nil then Exit;
  if nWhere in [0..12] then begin
    if (g_UseItems[nWhere].S.Name <> '') and (g_UseItems[nWhere].S.Name = sItemName) and (g_UseItems[nWhere].MakeIndex = nMakeIndex) then begin
      g_UseItems[nWhere].S.Name := '';
    end else SendDelayMsg(g_MySelf, SM_TAKEOFFITEM, nWhere, nMakeIndex, 0, 0, sItemName, 1000);
  end;
end;

procedure TfrmMain.ClientHeroTakeOnItem(nMakeIndex, nWhere: Integer; sItemName: string);
var
  where: Integer;
  I: Integer;
  flag: Boolean;
  Item: TClientItem;
begin
  if g_MyHero = nil then Exit;
  if nWhere in [0..12] then begin
    Item.S.Name := '';
    for I := Low(g_HeroItemArr) to High(g_HeroItemArr) do begin
      if g_HeroItemArr[I].S.Name <> '' then begin
        if (Comparetext(g_HeroItemArr[I].S.Name, sItemName) = 0) and (g_HeroItemArr[I].MakeIndex = nMakeIndex) then begin
          Item := g_HeroItemArr[I];
          g_HeroItemArr[I].S.Name := '';
          Break;
        end;
      end;
    end;
    if Item.S.Name <> '' then begin
      g_HeroUseItems[nWhere] := Item;
    end else begin
      SendDelayMsg(g_MyHero, SM_HEROTAKEONITEM, nWhere, nMakeIndex, 0, 0, sItemName, 1000);
      //DScreen.AddChatBoardString('TfrmMain.ClientHeroTakeOnItem:' + sItemName, GetRGB(154), clWhite);
    end;
  end;
end;

procedure TfrmMain.ClientHeroTakeOffItem(nMakeIndex, nWhere: Integer; sItemName: string);
begin
  if g_MyHero = nil then Exit;
  if nWhere in [0..12] then begin
    if (g_HeroUseItems[nWhere].S.Name <> '') and (g_HeroUseItems[nWhere].S.Name = sItemName) and (g_HeroUseItems[nWhere].MakeIndex = nMakeIndex) then begin
      g_HeroUseItems[nWhere].S.Name := '';
    end else SendDelayMsg(g_MyHero, SM_HEROTAKEOFFITEM, nWhere, nMakeIndex, 0, 0, sItemName, 1000);
  end;
end;

procedure TfrmMain.ClientObjNewStatus(DefMsg: pTDefaultMessage);
var
  I, II: Integer;
  Status: TNewStatus;
  Actor: TActor;
  HealthStatus: pTHealthStatus;
begin
  g_NewStatusDelayTime := DefMsg.param;
  Status := TNewStatus(DefMsg.tag);
  if Status <> g_NewStatus then begin
    g_NewStatus := Status;
    if g_MySelf <> nil then begin
      g_nNewStatusX := g_MySelf.m_nCurrX;
      g_nNewStatusY := g_MySelf.m_nCurrY;
    end;
    if g_NewStatus <> sNone then begin
      LegendMap.Stop;

    end;
    if g_NewStatus = sBlind then begin
      with PlayScene do begin
        for I := 0 to m_ActorList.Count - 1 do begin
          Actor := m_ActorList[I];
          SafeFillChar(Actor.m_SayingArr, SizeOf(Actor.m_SayingArr), #0);
          for II := 0 to Actor.m_HealthList.Count - 1 do begin
            HealthStatus := Actor.m_HealthList.Items[II];
            Dispose(HealthStatus);
          end;
          Actor.m_HealthList.Clear;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.ClientObjStartStoreOK();
var
  btDir: Byte;
begin
  g_TargetCret := nil;
  g_FocusCret := nil;
  g_MagicTarget := nil;
  g_boStartStoreing := False;
  btDir := g_MySelf.m_btDir;
  case g_MySelf.m_btDir of
    0: btDir := 1;
    2: btDir := 3;
    4: btDir := 5;
    6: btDir := 7;
  end;
  if g_MySelf.m_btDir <> btDir then
    g_MySelf.SendMsg(CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, btDir, 0, 0, '', 0);

  g_MySelf.m_boStartStore := True;
  FrmDlg.DItemBag.Visible := False;
  //FrmDlg.OpenStoreDlg;
end;

procedure TfrmMain.ClientObjStartStoreFail();
begin
  g_boStartStoreing := False;
end;

procedure TfrmMain.ClientObjStopStoreOK();
begin
  g_boStartStoreing := False;
  g_MySelf.m_boStartStore := False;
  if (g_nStoreMasterRecogId = g_MySelf.m_nRecogId) and FrmDlg.DUserStore.Visible then begin
    FrmDlg.CloseUserStoreDlg;
  end;
  g_sStoreMasterName := '';
  g_nStoreMasterRecogId := 0;
end;

procedure TfrmMain.ClientPlaySound(sFileName: string);
begin
  PlaySound(sFileName);
  //Showmessage(sFileName);
end;

procedure TfrmMain.ClientObjBlasthit(DefMsg: pTDefaultMessage); //爆击
var
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if Actor <> nil then begin
    Actor.SendMsg(DefMsg.ident, DefMsg.Recog, DefMsg.param {x}, DefMsg.tag {y}, Actor.m_btDir, 0, '', 0);
 //g_MySelf.SendMsg(SM_LEVELUP, g_MySelf.m_nRecogId, g_MySelf.m_nCurrX {X}, g_MySelf.m_nCurrY {Y}, g_MySelf.m_btDir {d}, 0, '', 0);
  end;
end;

procedure TfrmMain.ClientObjCartInfo(DefMsg: pTDefaultMessage; sCharName: string); //镖车信息
var
  I: Integer;
  CartInfo: pTCartInfo;
  boFind: Boolean;
begin
  g_CartInfoList.Lock;
  try
    boFind := False;
    for I := 0 to g_CartInfoList.Count - 1 do begin
      CartInfo := g_CartInfoList.Items[I];
      if CartInfo.nRecogId = DefMsg.Recog then begin
        CartInfo.sCharName := sCharName;
        CartInfo.nX := DefMsg.param;
        CartInfo.nY := DefMsg.tag;
        boFind := True;
        break;
      end;
    end;
    if not boFind then begin
      New(CartInfo);
      CartInfo.sCharName := sCharName;
      CartInfo.nRecogId := DefMsg.Recog;
      CartInfo.nX := DefMsg.param;
      CartInfo.nY := DefMsg.tag;
      g_CartInfoList.Add(CartInfo);
    end;
  finally
    g_CartInfoList.UnLock;
  end;
end;

procedure TfrmMain.ClientObjDelCartInfo(DefMsg: pTDefaultMessage);
var
  I: Integer;
  CartInfo: pTCartInfo;
begin
  //DScreen.AddChatBoardString('TfrmMain.ClientObjDelCartInfo: ' + IntToStr(DefMsg.Recog), clWhite, clPurple);
  g_CartInfoList.Lock;
  try
    for I := 0 to g_CartInfoList.Count - 1 do begin
      CartInfo := g_CartInfoList.Items[I];
      if CartInfo.nRecogId = DefMsg.Recog then begin
        g_CartInfoList.Delete(I);
        Dispose(CartInfo);
        break;
      end;
    end;
  finally
    g_CartInfoList.UnLock;
  end;
end;

procedure TfrmMain.DecodeMessagePacket(sDataBlock: string);
var
  sData: string;
  sTagStr: string;
  sDefMsg: string;
  sBody: string;
  DefMsg: TDefaultMessage;
  nCode: Integer;
  Buffer: array[0..BUFFERSIZE - 1] of Char;
  nLen: Integer;
begin
  nCode := 0;
  if sDataBlock[1] = '+' then begin
    sData := Copy(sDataBlock, 2, Length(sDataBlock) - 1);
    sData := GetValidStr3(sData, sTagStr, ['/']);
    ClientGetMsg(sTagStr);
    //DScreen.AddChatBoardString(Format('sData:%s', [sData]), clRed, clWhite);
    if g_ServerConfig.boCheckSpeedHack and (sData <> '') then begin
      //DScreen.AddChatBoardString(Format('sDataBlock:%s', [sDataBlock]), clRed, clWhite);
      //DScreen.AddChatBoardString(Format('sData:%s', [sData]), clRed, clWhite);
      CheckSpeedHack(LongWord(StrToIntDef(sData, 0)));
    end;
    Exit;
  end;
  nCode := 1;
  if Length(sDataBlock) < DEFBLOCKSIZE then begin
    if sDataBlock[1] = '=' then begin
      sData := Copy(sDataBlock, 2, Length(sDataBlock) - 1);
      if sData = 'DIG' then begin
        if g_MySelf <> nil then
          g_MySelf.m_boDigFragment := True;
      end;
    end;
    Exit;
  end;

  nCode := 2;
  nLen := 0;
  sDefMsg := Copy(sDataBlock, 1, DEFBLOCKSIZE);
  sBody := Copy(sDataBlock, DEFBLOCKSIZE + 1, Length(sDataBlock) - DEFBLOCKSIZE);
  DefMsg := DecodeMessage(sDefMsg);
  if Assigned(g_PlugInfo.HookDecodeMessagePacket) then begin
    if g_PlugInfo.HookDecodeMessagePacket(@DefMsg, PChar(sBody), @Buffer, nLen) then Exit;
    if nLen > 0 then begin
      SetLength(sBody, nLen);
      Move(Buffer[1], sBody[1], nLen);
    end else
      if nLen < 0 then begin
      sBody := '';
    end;
  end;

  //DScreen.AddChatBoardString('SM_SPELL: ' + IntToStr(DefMsg.Recog), clWhite, clPurple);
  //DebugOutStr('DefMsg.ident:'+IntToStr(DefMsg.ident));
  nCode := 3;
  if g_MySelf = nil then begin
    case DefMsg.ident of
      SM_GETREGINFO: ClientGetRegInfo(@DefMsg, sBody);
      SM_SERVERCONFIG: ClientGetServerConfig(@DefMsg, sBody);
      SM_RANDOMCODE: ClientGetRandomCode(sBody, DefMsg.Recog);
      SM_NEWID_SUCCESS: ClientNewIDSuccess();
      SM_NEWID_FAIL: ClientNewIDFail(DefMsg.Recog);
      SM_PASSWD_FAIL: ClientLoginFail(DefMsg.Recog);
      SM_NEEDUPDATE_ACCOUNT: ClientGetNeedUpdateAccount(sBody);
      SM_UPDATEID_SUCCESS: ClientUpdateAccountSuccess();
      SM_UPDATEID_FAIL: ClientUpdateAccountFail();
      SM_PASSOK_SELECTSERVER: ClientGetPasswordOK(@DefMsg, sBody);
      SM_SERVERNAME: ClientGetServerName(@DefMsg, sBody); //获取服务器列表
      SM_SELECTSERVER_OK: ClientGetPasswdSuccess(sBody);
      SM_QUERYCHR: ClientGetReceiveChrs(sBody);
      SM_QUERYCHR_FAIL: ClientQueryChrFail(DefMsg.Recog);
      SM_NEWCHR_SUCCESS: SendQueryChr();
      SM_NEWCHR_FAIL: ClientNewChrFail(DefMsg.Recog);
      SM_CHGPASSWD_SUCCESS: ClientChgPasswdSuccess();
      SM_CHGPASSWD_FAIL: ClientChgPasswdFail(DefMsg.Recog);
      SM_DELCHR_SUCCESS: SendQueryChr();
      SM_DELCHR_FAIL: ClientDelChrFail(DefMsg.Recog);
      SM_STARTPLAY: ClientGetStartPlay(sBody);
      SM_STARTFAIL: ClientStartPlayFail();
      //SM_VERSION_FAIL: ClientVersionFail();
      SM_FINDDELCHR: ClientGetDelChr(@DefMsg, sBody);
      SM_FINDDELCHR_SUCCESS: ClientGetDelChrOK(sBody);
      SM_FINDDELCHR_FAIL: ClientGetDelChrFail(DefMsg.Recog);
      SM_SENDRANDOMCODE: ClientGetRandomDIB(DefMsg.Recog = 0, DefMsg.param, sBody); //获取验证码图片
      SM_OUTOFCONNECTION: ClientOutofConnection();
      SM_NEWMAP,
        SM_LOGON,
        SM_RECONNECT,
        SM_SENDNOTICE: ;
    else
      Exit;
    end;
  end;
  nCode := 4;
  if g_boMapMoving then begin
    if DefMsg.ident = SM_CHANGEMAP then begin
      WaitingMsg := DefMsg;
      WaitingStr := DecodeString(sBody);
      g_boMapMovingWait := True;
      WaitMsgTimer.Enabled := True;
      DefMsg.Ident := 0;
    end;
    Exit;
  end;

  nCode := 5;
  case DefMsg.ident of
    //SM_VERSION_FAIL: ClientVersionFail();
    SM_NEWMAP: ClientGetNewMap(@DefMsg, sBody);
    SM_LOGON: ClientGetUserLogin(@DefMsg, sBody);

    SM_SERVERCONFIG: ClientGetServerConfig(@DefMsg, sBody);
    SM_RECONNECT: ClientGetReconnect(sBody);
    SM_TIMECHECK_MSG: ;
    SM_AREASTATE: ClientGetAreaState(DefMsg.Recog);
    SM_MAPDESCRIPTION: ClientGetMapDescription(@DefMsg, sBody);
    SM_GAMEGOLDNAME: ClientGetGameGoldName(@DefMsg, sBody);
    SM_ADJUST_BONUS: ClientGetAdjustBonus(DefMsg.Recog, sBody);
    SM_MYSTATUS: ClientGetMyStatus(@DefMsg);
    SM_TURN: ClientGetObjTurn(@DefMsg, sBody);
    SM_BACKSTEP: ClientGetBackStep(@DefMsg, sBody);
    SM_SPACEMOVE_HIDE,
      SM_SPACEMOVE_HIDE2: ClientSpaceMoveHide(@DefMsg);
    SM_SPACEMOVE_SHOW,
      SM_SPACEMOVE_SHOW2: ClientSpaceMoveShow(@DefMsg, sBody);
    SM_WALK, SM_RUSH, SM_RUSHKUNG: ClientObjWalk(@DefMsg, sBody);
    SM_RUN, SM_HORSERUN: ClientObjRun(@DefMsg, sBody);
    SM_CHANGELIGHT: ClientChangeLigth(@DefMsg);
    SM_LAMPCHANGEDURA: ClientLampChangeDura(@DefMsg);
    SM_MOVEFAIL: ClientObjMoveFail(@DefMsg, sBody);
    SM_BUTCH,
      SM_SITDOWN: ClientObjButch(@DefMsg, sBody);
    SM_HIT,
      SM_HEAVYHIT,
      SM_POWERHIT,
      SM_LONGHIT,
      SM_WIDEHIT,
      SM_BIGHIT,
      SM_FIREHIT,
      SM_CRSHIT,
      SM_TWINHIT,
      SM_KTHIT,
      SM_PKHIT,
      SM_60HIT,
      SM_61HIT,
      SM_62HIT,
      SM_SUPERFIREHIT,

    SM_ZRJFHIT,
      SM_100HIT,
      SM_101HIT,
      SM_102HIT,
      SM_103HIT
      : ClientObjHit(@DefMsg, sBody);

    SM_FLYAXE: ClientObjFlyAxe(@DefMsg, sBody);
    SM_LIGHTING: ClientObjLighting(@DefMsg, sBody);
    SM_SPELL: ClientObjSpell(@DefMsg, sBody);
    SM_MAGICFIRE: ClientObjMagicFire(@DefMsg, sBody);
    SM_MAGICFIRE_FAIL: ClientObjMagicFireFail(@DefMsg);

    SM_OUTOFCONNECTION: ClientOutofConnection();
    SM_DEATH,
      SM_NOWDEATH: ClientObjDeath(@DefMsg, sBody);
    SM_SKELETON,
      SM_ALIVE: ClientObjSkeLeton(@DefMsg, sBody);
    SM_ABILITY: ClientObjAbility(@DefMsg, sBody);
    SM_SUBABILITY: ClientObjSubAbility(@DefMsg);
    SM_DAYCHANGING: ClientDayChanging(@DefMsg);
    SM_WINEXP: ClientObjWinExp(@DefMsg);
    SM_LEVELUP: ClientObjLevelUp(@DefMsg);
    SM_HEALTHSPELLCHANGED: ClientObjHealthSpellChanged(@DefMsg, sBody);
    SM_STRUCK: ClientObjStruck(@DefMsg, sBody);
    SM_CHANGEFACE: ClientObjChangeFace(@DefMsg, sBody);
    SM_PASSWORD: ClientObjInputPassword();
    SM_OPENHEALTH: ClientObjOpenHealth(@DefMsg, sBody);
    SM_CLOSEHEALTH: ClientObjCloseHealth(@DefMsg);
    SM_INSTANCEHEALGUAGE: ClientObjInstanceOpenHealth(@DefMsg, sBody);
    SM_BREAKWEAPON: ClientObjBreakWeapon(@DefMsg);
    SM_GROUPMESSAGE,
      SM_GUILDMESSAGE,
      SM_WHISPER,
      SM_CRY,
      SM_SYSMESSAGE,
      SM_HEAR,
      SM_MOVEMESSAGE,
      SM_DELAYMESSAGE,
      SM_DELETEDELAYMESSAGE,
      SM_CENTERMESSAGE: ClientGetMessage(@DefMsg, sBody);

    SM_USERNAME: ClientGetUserName(@DefMsg, sBody);
    SM_CHANGENAMECOLOR: ClientObjChangeNameColor(@DefMsg);
    SM_HIDE,
      SM_GHOST,
      SM_DISAPPEAR: ClientObjHide(@DefMsg);
    SM_DIGUP: ClientObjDigUp(@DefMsg, sBody);
    SM_DIGDOWN: ClientObjDigDown(@DefMsg);
    SM_SHOWEVENT: ClientGetShowEvent(@DefMsg, sBody);
    SM_HIDEEVENT: ClientGetHideEvent(@DefMsg);
    SM_ADDITEM: ClientGetAddItem(sBody);
    SM_BAGITEMS: ClientGetBagItmes(@DefMsg, sBody);
    SM_UPDATEITEM: ClientGetUpdateItem(sBody);
    SM_UPDATEITEM2: ClientGetUpdateItem2(sBody);
    SM_DELITEM: ClientGetDelItem(sBody);
    SM_DELITEMS: ClientGetDelItems(sBody);
    SM_DROPITEM_SUCCESS: DelDropItem(DecodeString(sBody), DefMsg.Recog);
    SM_DROPITEM_FAIL: ClientGetDropItemFail(DecodeString(sBody), DefMsg.Recog);
    SM_ITEMSHOW: ClientGetShowItem(@DefMsg, sBody);
    SM_ITEMHIDE: ClientGetHideItem(@DefMsg);
    SM_OPENDOOR_OK: Map.OpenDoor(DefMsg.param, DefMsg.tag);
    SM_OPENDOOR_LOCK: DScreen.AddSysMsg('此门被锁定！', 30, 40, clAqua);
    SM_CLOSEDOOR: Map.CloseDoor(DefMsg.param, DefMsg.tag);

    {==================================排行榜=================================}
    SM_SENGRANKING: ClientGetRanking(@DefMsg, sBody);
    SM_SENGMYRANKING_FAIL: FrmDlg.DMessageDlg('你没有上榜或不在该榜！！！', [mbOk]);
    {==================================英雄相关=================================}
    SM_HEROLOGON: ClientObjHeroLogOn(@DefMsg, sBody);
    SM_HEROLOGON_OK: ClientObjHeroLogOnOK(DefMsg.Recog);

    SM_HEROLOGOUT: ClientObjHeroLogOut(@DefMsg);
    SM_HEROLOGOUT_OK: ClientObjHeroLogOutOK(DefMsg.Recog);

    SM_HEROABILITY: ClientObjHeroAbility(@DefMsg, sBody);
    SM_HEROSUBABILITY: ClientObjHeroSubAbility(@DefMsg);

    SM_HEROANGERVALUE: ClientObjFireDragonPoint(@DefMsg);
    SM_HEROBAGITEMS: ClientGetHeroBagItmes(@DefMsg, sBody);
    SM_HEROADDITEM: ClientGetHeroAddItem(sBody);
    SM_HERODELITEM: ClientGetHeroDelItem(sBody);
    SM_HERODELITEMS: ClientGetHeroDelItems(sBody);
    SM_HEROUPDATEITEM: ClientGetHeroUpdateItem(sBody);
    SM_HEROADDMAGIC: ClientGetHeroAddMagic(sBody);
    SM_SENDMYHEROMAGIC: ClientGetMyHeroMagics(sBody);
    SM_HERODELMAGIC: ClientGetHeroDelMagic(DefMsg.Recog);
    SM_HEROCHANGEITEM: ClientGetHeroChangeItem(sBody);

    SM_HEROTAKEON_OK: ClientObjHeroTakeOnOK(@DefMsg, DecodeString(sBody));
    SM_HEROTAKEON_FAIL: ClientObjHeroTakeOnFail();
    SM_HEROTAKEOFF_OK: ClientObjHeroTakeOffOK(@DefMsg, DecodeString(sBody));
    SM_HEROTAKEOFF_FAIL: ClientObjHeroTakeOffFail();


   { SM_TAKEOFFTOHEROBAG_OK: ClientObjTakeOffHeroBagOK(DefMsg);
    SM_TAKEOFFTOHEROBAG_FAIL: ClientObjTakeOffHeroBagFail();
    SM_TAKEOFFTOMASTERBAG_OK: ClientObjTakeOffMasterBagOK(DefMsg);
    SM_TAKEOFFTOMASTERBAG_FAIL: ClientObjTakeOffMasterBagFail(); }


    SM_TAKEONITEMFROMHERO_OK: ClientObjTakeOnOK(@DefMsg, DecodeString(sBody)); //主人穿装备从英雄包裹   成功
    SM_TAKEONITEMFROMHERO_FAIL: ClientObjHeroTakeOnFail(); //主人穿装备从英雄包裹 失败
    SM_TAKEOFFITEMTOHERO_OK: ClientObjTakeOffHeroBagOK(@DefMsg); //主人脱装备到英雄包裹    成功
    SM_TAKEOFFITEMTOHERO_FAIL: ClientObjTakeOffHeroBagFail(); //主人脱装备到英雄包裹  失败   }

    SM_HEROTAKEONITEMFROMMASTER_OK: ClientObjHeroTakeOnOK(@DefMsg, DecodeString(sBody)); //英雄穿装备从主人  成功
    SM_HEROTAKEONITEMFROMMASTER_FAIL: ClientObjTakeOnFail(); //英雄穿装备从主人 失败
    SM_HEROTAKEOFFITEMTOMASTER_OK: ClientObjTakeOffMasterBagOK(@DefMsg); //英雄脱装备到主人   成功
    SM_HEROTAKEOFFITEMTOMASTER_FAIL: ClientObjTakeOffMasterBagFail(); //英雄脱装备到主人  失败


    SM_MASTERBAGTOHEROBAG_OK: ClientObjToHeroBagOK();
    SM_MASTERBAGTOHEROBAG_FAIL: ClientObjToHeroBagFail();
    SM_HEROBAGTOMASTERBAG_OK: ClientObjToMasterBagOK();
    SM_HEROBAGTOMASTERBAG_FAIL: ClientObjToMasterBagFail();


    SM_SENDHEROUSEITEMS: ClientGetSendHerouseItems(sBody);
    SM_HEROBAGCOUNT: ClientObjHeroBagCount(@DefMsg);
    SM_HEROWEIGHTCHANGED: ClientObjHeroWeigthChanged(@DefMsg);
    SM_HEROEAT_OK: ClientObjHeroEatOK();
    SM_HEROEAT_FAIL: ClientObjHeroEatFail();
    SM_HEROMAGIC_LVEXP: ClientGetHeroMagicLvExp(DefMsg.Recog {magid}, DefMsg.param {lv}, MakeLong(DefMsg.tag, DefMsg.series));
    SM_HERODURACHANGE: ClientGetHeroDuraChange(DefMsg.param {useitem index}, DefMsg.Recog, MakeLong(DefMsg.tag, DefMsg.series));
    SM_HEROWINEXP: ClientObjHeroWinExp(@DefMsg);
    SM_HEROLEVELUP: ClientObjHeroLevelUp(@DefMsg);
    SM_HERODROPITEM_SUCCESS: DelDropItem(DecodeString(sBody), DefMsg.Recog);
    SM_HERODROPITEM_FAIL: ClientGetHeroDropItemFail(DecodeString(sBody), DefMsg.Recog);
    SM_REPAIRFIRDRAGON_OK: g_WaitingUseItem.Item.S.Name := '';
    SM_REPAIRFIRDRAGON_FAIL: ClientObjRepaiFireDragon(@DefMsg);
    {==================================英雄相关====================================}
    SM_TAKEON_OK: ClientObjTakeOnOK(@DefMsg, DecodeString(sBody));
    SM_TAKEON_FAIL: ClientObjTakeOnFail();
    SM_TAKEOFF_OK: ClientObjTakeOffOK(@DefMsg, DecodeString(sBody));
    SM_TAKEOFF_FAIL: ClientObjTakeOffFail();
    SM_EXCHGTAKEON_OK: ;
    SM_EXCHGTAKEON_FAIL: ;
    SM_SENDUSEITEMS: ClientGetSenduseItems(sBody);
    SM_WEIGHTCHANGED: ClientObjWeigthChanged(@DefMsg);
    SM_GOLDCHANGED: ClientObjGoldChanged(@DefMsg);
    SM_FEATURECHANGED: PlayScene.SendMsg(DefMsg.ident, DefMsg.Recog, 0, 0, 0, MakeLong(DefMsg.param, DefMsg.tag), MakeLong(DefMsg.series, 0), '');
    SM_CHARSTATUSCHANGED: PlayScene.SendMsg(DefMsg.ident, DefMsg.Recog, 0, 0, 0, MakeLong(DefMsg.param, DefMsg.tag), DefMsg.series, DecodeString(sBody));
    SM_CLEAROBJECTS: ClientObjCleanObjects();
    SM_EAT_OK: ClientObjEatOK();
    SM_EAT_FAIL: ClientObjEatFail();
    SM_ADDMAGIC: ClientGetAddMagic(sBody);
    SM_SENDMYMAGIC: ClientGetMyMagics(sBody);
    SM_DELMAGIC: ClientGetDelMagic(DefMsg.Recog);
    SM_MAGIC_LVEXP: ClientGetMagicLvExp(DefMsg.Recog {magid}, DefMsg.param {lv}, MakeLong(DefMsg.tag, DefMsg.series));
    SM_DURACHANGE: ClientGetDuraChange(DefMsg.param {useitem index}, DefMsg.Recog, MakeLong(DefMsg.tag, DefMsg.series));
    SM_MERCHANTSAY: ClientGetMerchantSay(DefMsg.Recog, DefMsg.param, DecodeString(sBody));
    SM_MERCHANTDLGCLOSE: ClientObjCloseMDlg();
    SM_SENDGOODSLIST: ClientGetSendGoodsList(DefMsg.Recog, DefMsg.param, sBody);
    SM_SENDUSERMAKEDRUGITEMLIST: ClientGetSendMakeDrugList(DefMsg.Recog, sBody);
    SM_SENDUSERSELL: ClientGetSendUserSell(DefMsg.Recog);
    SM_SENDUSERREPAIR: ClientGetSendUserRepair(DefMsg.Recog);
    SM_SENDBUYPRICE: ClientObjBuyPrice(DefMsg.Recog);
    SM_USERSELLITEM_OK: ClientObjSellItemOK(DefMsg.Recog);
    SM_USERSELLITEM_FAIL: ClientObjSellItemFail();
    SM_SENDREPAIRCOST: ClientObjRepairCost(DefMsg.Recog);
    SM_USERREPAIRITEM_OK: ClientObjRepairItemOK(@DefMsg);
    SM_USERREPAIRITEM_FAIL: ClientObjRepairItemFail();
    SM_STORAGE_OK,
      SM_STORAGE_FULL,
      SM_STORAGE_FAIL: ClientObjStorageOK(@DefMsg);
    SM_SAVEITEMLIST: ClientGetSaveItemList(DefMsg.Recog, DefMsg.param, sBody);
    SM_TAKEBACKSTORAGEITEM_OK,
      SM_TAKEBACKSTORAGEITEM_FAIL,
      SM_TAKEBACKSTORAGEITEM_FULLBAG: ClientObjTakeBackStorageItemOK(@DefMsg);
    SM_BUYITEM_SUCCESS: ClientObjBuyItemSuccess(@DefMsg);
    SM_BUYITEM_FAIL: ClientObjBuyItemFail(DefMsg.Recog);
    SM_MAKEDRUG_SUCCESS: ClientObjMakeDrugOK(DefMsg.Recog);
    SM_MAKEDRUG_FAIL: ClientObjMakeDrugFail(DefMsg.Recog);
    SM_716: DrawEffectHum(DefMsg.series {type}, DefMsg.param {x}, DefMsg.tag {y}, DefMsg.Recog);
    SM_717: DrawEffectHum(DefMsg.param {type}, DefMsg.series, {x} DefMsg.tag {y}, DefMsg.Recog);
    SM_SENDDETAILGOODSLIST: ClientGetSendDetailGoodsList(DefMsg.Recog, DefMsg.param, DefMsg.tag, sBody);
    SM_TEST: Inc(g_nTestReceiveCount);
    SM_SENDNOTICE: ClientGetSendNotice(sBody);
    SM_GROUPMODECHANGED: ClientObjGroupModeChanged(DefMsg.param);
    SM_CREATEGROUP_OK: ClientObjCreateGroupOK();
    SM_CREATEGROUP_FAIL: ClientObjCreateGroupFail(DefMsg.Recog);
    SM_GROUPADDMEM_OK: g_dwChangeGroupModeTick := GetTickCount;
    SM_GROUPADDMEM_FAIL: ClientObjGroupAddManFail(DefMsg.Recog);
    SM_GROUPDELMEM_OK: g_dwChangeGroupModeTick := GetTickCount;
    SM_GROUPDELMEM_FAIL: ClientObjGroupDelManFail(DefMsg.Recog);
    SM_GROUPCANCEL: g_GroupMembers.Clear;
    SM_GROUPMEMBERS: ClientGetGroupMembers(DecodeString(sBody));
    SM_OPENGUILDDLG: ClientGetOpenGuildDlg(sBody);
    SM_SENDGUILDMEMBERLIST: ClientGetSendGuildMemberList(sBody);
    SM_OPENGUILDDLG_FAIL: ClientObjOpenGuildDlgFail();
    SM_DEALTRY_FAIL: ClientObjDealtryFail();
    SM_DEALMENU: ClientObjDealMenu(sBody);
    SM_DEALCANCEL: ClientObjDealCancel();
    SM_DEALADDITEM_OK,
      SM_DEALADDITEM_FAIL: ClientObjDealAddItemOK();
    SM_DEALDELITEM_OK: ClientObjDealDelItemOK();
    SM_DEALDELITEM_FAIL: ClientObjDealDelItemFail();
    SM_DEALREMOTEADDITEM: ClientGetDealRemoteAddItem(sBody);
    SM_DEALREMOTEDELITEM: ClientGetDealRemoteDelItem(sBody);
    SM_DEALCHGGOLD_OK: ClientObjDealChgGoldOK(@DefMsg);
    SM_DEALCHGGOLD_FAIL: ClientObjDealChgGoldFail(@DefMsg);
    SM_DEALREMOTECHGGOLD: ClientObjDealRemotChgGold(@DefMsg);
    SM_DEALSUCCESS: FrmDlg.CloseDealDlg;
    SM_SENDUSERSTORAGEITEM: ClientGetSendUserStorage(DefMsg.Recog);
    SM_READMINIMAP_OK: ClientGetReadMiniMap(DefMsg.param);
    SM_READMINIMAP_FAIL: ClientGetReadMiniMapFail();
    SM_CHANGEGUILDNAME: ClientGetChangeGuildName(DecodeString(sBody));
    SM_SENDUSERSTATE: ClientGetSendUserState(sBody);
    SM_GUILDADDMEMBER_OK: SendGuildMemberList;
    SM_GUILDADDMEMBER_FAIL: ClientObjGuildAddMemberFail(DefMsg.Recog);
    SM_GUILDDELMEMBER_OK: SendGuildMemberList;
    SM_GUILDDELMEMBER_FAIL: ClientObjGuildDelMemberFail(DefMsg.Recog);
    SM_GUILDRANKUPDATE_FAIL: ClientObjGuildRankUpdateFail(DefMsg.Recog);
    SM_GUILDMAKEALLY_OK,
      SM_GUILDMAKEALLY_FAIL: ClientObjGuildMakeAllyFail(DefMsg.Recog);
    SM_GUILDBREAKALLY_OK,
      SM_GUILDBREAKALLY_FAIL: ClientObjGuildBreakAllyFail(DefMsg.Recog);
    SM_BUILDGUILD_OK: ClientObjBuildGuildOK();
    SM_BUILDGUILD_FAIL: ClientObjBuildGuildFail(DefMsg.Recog);
    SM_MENU_OK: ClientObjMenuOK(sBody);
    SM_DLGMSG: ClientObjDlgMsg(sBody);
    SM_DONATE_OK,
      SM_DONATE_FAIL: FrmDlg.LastestClickTime := GetTickCount;
    SM_PLAYDICE: ClientObjPalyDice(@DefMsg, sBody);
    SM_NEEDPASSWORD: ClientGetNeedPassword(sBody);
    SM_PASSWORDSTATUS: ClientGetPasswordStatus(@DefMsg, sBody);
    SM_SENGSHOPITEMS: ClientGetShopItems(@DefMsg, sBody); //获取商铺物品
    //SM_QUERYUSERLEVELSORT: ClientGetSortItems(@DefMsg, sBody);
    SM_SENDUSERSELLOFFITEM: ClientGetSendUserSellOff(DefMsg.Recog);
    SM_SENDSELLOFFGOODSLIST: ClientGetSellItems(@DefMsg, sBody);
    SM_BUYSHOPITEM_FAIL: ClientObjBuyShopItemFail(DefMsg.Recog);
    SM_GETREGINFO: ClientGetRegInfo(@DefMsg, sBody);
    SM_SENDBUYSELLOFFITEM_OK: FrmDlg.DMessageDlg('购买成功！！！', [mbOk]);
    SM_SENDBUYSELLOFFITEM_FAIL: ClientObjBuySellOffItemFail(DefMsg.Recog);
    SM_SENDUSERSELLOFFITEM_OK: ClientObjSellSellOffItemOK();
    SM_SENDUSERSELLOFFITEM_FAIL: ClientObjSellSellOffItemFail(DefMsg.Recog); //寄售物品失败
    SM_USERCASTLE: ClientObjGetCastle(@DefMsg);
    SM_SHOWITEMBOX: ClientObjShowBox(DefMsg.Recog);
    SM_OPENITEMBOX_OK: ClientObjOpenBoxOK(@DefMsg, sBody);
    SM_OPENITEMBOX_FAIL: ClientObjOpenBoxFail(DefMsg.Recog);
    SM_GETSELBOXITEMNUM: ClientObjGetBoxIndex(DefMsg.Recog);

    SM_GETBACKITEMBOX_OK: ClientObjGetBackBoxOK(); //取回宝箱成功
    //SM_GETBACKITEMBOX_FAIL: ; //取回宝箱失败

    SM_OPENBOOK: ClientObjOpenBook(DefMsg.Recog, DefMsg.param);
    SM_SENDCHANGEITEM: ClientGetSendUserChangeItem(DefMsg.Recog);
    SM_SENDCHANGEITEM_OK: ClientObjChangeItemOK(sBody);
    SM_SENDCHANGEITEM_FAIL: ClientObjChangeItemFail(DefMsg.Recog);

    SM_SENDUPGRADEITEM_OK: ClientObjUpgradeItemOK(sBody);
    SM_SENDUPGRADEITEM_FAIL: ClientObjUpgradeItemFail(DefMsg.Recog, sBody);

    SM_DUELTRY_FAIL: ClientObjDueltryFail(DefMsg.Recog);
    SM_DUELMENU: ClientObjDuelMenu(sBody);
    SM_DUELCANCEL: ClientObjDuelCancel();
    SM_DUELADDITEM_OK,
      SM_DUELADDITEM_FAIL: ClientObjDuelAddItemOK();
    SM_DUELDELITEM_OK: ClientObjDuelDelItemOK();
    SM_DUELDELITEM_FAIL: ClientObjDuelDelItemFail();
    SM_DUELREMOTEADDITEM: ClientGetDuelRemoteAddItem(sBody);
    SM_DUELREMOTEDELITEM: ClientGetDuelRemoteDelItem(sBody);
    SM_DUELCHGGOLD_OK: ClientObjDuelChgGoldOK(@DefMsg);
    SM_DUELCHGGOLD_FAIL: ClientObjDuelChgGoldFail(@DefMsg);
    SM_DUELREMOTECHGGOLD: ClientObjDuelRemotChgGold(@DefMsg);
    SM_DUELSUCCESS: FrmDlg.CloseDuelDlg;

    SM_STATE_BUBBLEDEFENCEUP: ClientObjChangeState(@DefMsg);
    SM_SENDOPENHOMEPAGE: if Assigned(g_PlugInfo.OpenHomePage) then g_PlugInfo.OpenHomePage(PChar(DecodeString(sBody)));

    SM_SENDFINDITEMINFO_OK: ClientObjFindItemOK(sBody, DefMsg.Recog);
    SM_SENDFINDITEMINFO_FAIL: ;
    SM_SENDSNOW: ClientSnow(@DefMsg);
    SM_SENDSTORE: ClientStore(@DefMsg);
    SM_DELSTOREITEM: ClientDelStoreItem(sBody);
    SM_USERSTOREITEMS: ClientGetSendUserStoreState(sBody);
    SM_SENDBUYSTOREITEM_OK: ClientObjBuyStoreItemOK(); //摆摊物品购买成功
    SM_SENDBUYSTOREITEM_FAIL: ClientObjBuyStoreItemFail(@DefMsg); //摆摊物品购买失败
    SM_SENDSTARTSTORE_OK: ClientObjStartStoreOK(); //摆摊成功
    SM_SENDSTOPSTORE_OK: ClientObjStopStoreOK();
    SM_SENDSTARTSTORE_FAIL: ClientObjStartStoreFail(); //摆摊成功

    SM_NEWSTATUS: ClientObjNewStatus(@DefMsg);

    SM_AUTOGOTOXY: ClientAutoGotoXY(DefMsg.param, DefMsg.tag, DecodeString(sBody));

    SM_TAKEONITEM: ClientTakeOnItem(DefMsg.Recog, DefMsg.param, DecodeString(sBody)); //穿装备
    SM_TAKEOFFITEM: ClientTakeOffItem(DefMsg.Recog, DefMsg.param, DecodeString(sBody)); //脱装备
    SM_HEROTAKEONITEM: ClientHeroTakeOnItem(DefMsg.Recog, DefMsg.param, DecodeString(sBody)); //穿装备
    SM_HEROTAKEOFFITEM: ClientHeroTakeOffItem(DefMsg.Recog, DefMsg.param, DecodeString(sBody)); //脱装备
    SM_PLAYSOUND: ClientPlaySound(DecodeString(sBody));
    SM_VIBRATION: ClientStartVibration(DefMsg.param);
    SM_OPENBIGDIALOGBOX: ClientOpenBigDiaLogBox(DefMsg.Recog);
    SM_CLOSEBIGDIALOGBOX: ClientCloseBigDiaLogBox();

    SM_STARTSERIESPELL_OK: begin
        g_dwSerieMagicTick := GetTickCount;
        g_boSerieMagic := False;
        g_boSerieMagicing := True;
        UseSerieMagic;
      end;
    SM_STARTSERIESPELL_FAIL: StopSerieMagic;
    SM_BLASTHHIT: ClientObjBlasthit(@DefMsg);
    SM_SENDCARTINFO: ClientObjCartInfo(@DefMsg, DecodeString(sBody));
    SM_DELCARTINFO: ClientObjDelCartInfo(@DefMsg);
  else begin
      {if g_MySelf = nil then Exit; //在未进入游戏时不处理下面
      PlayScene.MemoLog.Lines.Add('Ident: ' + IntToStr(DefMsg.ident));
      PlayScene.MemoLog.Lines.Add('Recog: ' + IntToStr(DefMsg.Recog));
      PlayScene.MemoLog.Lines.Add('Param: ' + IntToStr(DefMsg.param));
      PlayScene.MemoLog.Lines.Add('Tag: ' + IntToStr(DefMsg.tag));
      PlayScene.MemoLog.Lines.Add('Series: ' + IntToStr(DefMsg.series));}
    end;
  end;
  {if Pos('#', sDataBlock) > 0 then
    DScreen.AddSysMsg(sDataBlock, 30, 40, clAqua);  }
end;

procedure TfrmMain.ClientGetPasswdSuccess(body: string);
begin
  LoginScene.ShowLoginBox;
end;


procedure TfrmMain.ClientGetServerName(DefMsg: pTDefaultMessage;
  sBody: string);
var
  I: Integer;
  sServerName: string;
  sServerStatus: string;
  nCount: Integer;
begin
  sBody := DecodeString(sBody);
  //FrmDlg.DMessageDlg (sBody + '/' + IntToStr(Msg.Series), [mbOk]);
  nCount := _MIN(6, DefMsg.series);
  g_ServerList.Clear;
  for I := 0 to nCount - 1 do begin
    sBody := GetValidStr3(sBody, sServerName, ['/']);
    sBody := GetValidStr3(sBody, sServerStatus, ['/']);
    g_ServerList.AddObject(sServerName, TObject(Str_ToInt(sServerStatus, 0)));
  end;
  ClientGetSelectServer;
end;

procedure TfrmMain.ClientGetPasswordOK(DefMsg: pTDefaultMessage;
  sBody: string);
var
  Str, runaddr, runport, uid, certifystr: string;
begin
  LoginScene.OpenLoginDoor;
  Str := DecodeString(sBody);
  Str := GetValidStr3(Str, runaddr, ['/']);
  Str := GetValidStr3(Str, runport, ['/']);
  Str := GetValidStr3(Str, certifystr, ['/']);
  Certification := Str_ToInt(certifystr, 0);
  {Showmessage(runaddr);
   Showmessage(runport);}
  if not BoOneClick then begin
    CSocket.Active := False;
    CSocket.Host := '';
    CSocket.Port := 0;
    FrmDlg.DSelServerDlg.Visible := False;
    //WaitAndPass(500); //WaitAndPass(500);
    g_ConnectionStep := cnsSelChr;

    with CSocket do begin
      g_sSelChrAddr := runaddr;
      g_nSelChrPort := Str_ToInt(runport, 0);
      ClientType := ctNonBlocking;
      Address := g_sSelChrAddr;
      Port := g_nSelChrPort;
      Active := True;
    end;

  end else begin
    FrmDlg.DSelServerDlg.Visible := False;
    g_sSelChrAddr := runaddr;
    g_nSelChrPort := Str_ToInt(runport, 0);

    if CSocket.Socket.Connected then
      CSocket.Socket.SendText('$S' + runaddr + '/' + runport + '%');

    //WaitAndPass(500);
    g_ConnectionStep := cnsSelChr;
    LoginScene.OpenLoginDoor;
    SelChrWaitTimer.Enabled := True;
  end;

end;
{var
  I: Integer;
  sServerName: string;
  sServerStatus: string;
  nCount: Integer;
begin

  sBody := DecodeString(sBody);
  //  FrmDlg.DMessageDlg (sBody + '/' + IntToStr(Msg.Series), [mbOk]);
  nCount := _MIN(6, Msg.series);
  g_ServerList.Clear;
  for I := 0 to nCount - 1 do begin
    sBody := GetValidStr3(sBody, sServerName, ['/']);
    sBody := GetValidStr3(sBody, sServerStatus, ['/']);
    g_ServerList.AddObject(sServerName, TObject(Str_ToInt(sServerStatus, 0)));
  end;

  }
  //ExtractStrings(['|', '\', '/', ','], [], PChar(sMagic), TempList);
  {g_wAvailIDDay := LoWord(Msg.Recog);
  g_wAvailIDHour := HiWord(Msg.Recog);
  g_wAvailIPDay := Msg.param;
  g_wAvailIPHour := Msg.tag;

  {if g_wAvailIDDay > 0 then
  begin
    if g_wAvailIDDay = 1 then
      FrmDlg.DMessageDlg('您当前ID费用到今天为止。', [mbOk])
    else if g_wAvailIDDay <= 3 then
      FrmDlg.DMessageDlg('您当前IP费用还剩 ' + IntToStr(g_wAvailIDDay) + ' 天。', [mbOk]);
  end else if g_wAvailIPDay > 0 then
  begin
    if g_wAvailIPDay = 1 then
      FrmDlg.DMessageDlg('您当前IP费用到今天为止。', [mbOk])
    else if g_wAvailIPDay <= 3 then
      FrmDlg.DMessageDlg('您当前IP费用还剩 ' + IntToStr(g_wAvailIPDay) + ' 天。', [mbOk]);
  end else if g_wAvailIPHour > 0 then
  begin
    if g_wAvailIPHour <= 100 then
      FrmDlg.DMessageDlg('您当前IP费用还剩 ' + IntToStr(g_wAvailIPHour) + ' 小时。', [mbOk]);
  end else if g_wAvailIDHour > 0 then
  begin
    FrmDlg.DMessageDlg('您当前ID费用还剩 ' + IntToStr(g_wAvailIDHour) + ' 小时。', [mbOk]); ;
  end;    }

  {if not LoginScene.m_boUpdateAccountMode then
    ClientGetSelectServer;
  LoginScene.OpenLoginDoor;
end;   }

procedure TfrmMain.ClientGetSelectServer;
begin
  LoginScene.HideLoginBox;
  FrmDlg.ShowSelectServerDlg;
end;

procedure TfrmMain.ClientGetNeedUpdateAccount(body: string);
var
  ue: TUserEntry;
begin
  DecodeBuffer(body, @ue, SizeOf(TUserEntry));
  LoginScene.UpdateAccountInfos(ue);
end;

procedure TfrmMain.ClientGetReceiveChrs(body: string);
var
  I, select: Integer;
  Str, uname, sjob, shair, slevel, ssex: string;
begin

  SelectChrScene.ClearChrs;
  Str := DecodeString(body);
  //showmessage(Str);
  for I := 0 to 1 do begin
    Str := GetValidStr3(Str, uname, ['/']);
    Str := GetValidStr3(Str, sjob, ['/']);
    Str := GetValidStr3(Str, shair, ['/']);
    Str := GetValidStr3(Str, slevel, ['/']);
    Str := GetValidStr3(Str, ssex, ['/']);
    select := 0;
    if (uname <> '') and (slevel <> '') and (ssex <> '') then begin
      if uname[1] = '*' then begin
        select := I;
        uname := Copy(uname, 2, Length(uname) - 1);
      end;
      SelectChrScene.AddChr(uname, Str_ToInt(sjob, 0), Str_ToInt(shair, 0), Str_ToInt(slevel, 0), Str_ToInt(ssex, 0));
    end;
    with SelectChrScene do begin
      if select = 0 then begin
        ChrArr[0].FreezeState := False;
        ChrArr[0].Selected := True;
        ChrArr[1].FreezeState := True;
        ChrArr[1].Selected := False;
      end else begin
        ChrArr[0].FreezeState := True;
        ChrArr[0].Selected := False;
        ChrArr[1].FreezeState := False;
        ChrArr[1].Selected := True;
      end;
    end;
  end;
  PlayScene.EdAccountt.Text := LoginID;
  //2004/05/17  强行登录
  {
  if SelectChrScene.ChrArr[0].Valid and SelectChrScene.ChrArr[0].Selected then PlayScene.EdChrNamet.Text := SelectChrScene.ChrArr[0].UserChr.Name;
  if SelectChrScene.ChrArr[1].Valid and SelectChrScene.ChrArr[1].Selected then PlayScene.EdChrNamet.Text := SelectChrScene.ChrArr[1].UserChr.Name;
  PlayScene.EdAccountt.Visible:=True;
  PlayScene.EdChrNamet.Visible:=True;
  }
  //2004/05/17
end;

procedure TfrmMain.ClientGetStartPlay(body: string);
var
  Str, addr, sport: string;
begin
  Str := DecodeString(body);
  sport := GetValidStr3(Str, g_sRunServerAddr, ['/']);
  g_nRunServerPort := Str_ToInt(sport, 0);

  if not BoOneClick then begin
    CSocket.Active := False;
    CSocket.Host := '';
    CSocket.Port := 0;

    WaitAndPass(500);
    g_ConnectionStep := cnsPlay;

    with CSocket do begin
      Address := g_sRunServerAddr;
      Port := g_nRunServerPort;
      Active := True;
    end;
  end else begin
    g_sSockText := '';
    g_sBufferText := '';
    if CSocket.Socket.Connected then
      CSocket.Socket.SendText('$R' + addr + '/' + sport + '%');

    g_ConnectionStep := cnsPlay;
    ClearBag;
    DScreen.ClearChatBoard;
    DScreen.ChangeScene(stLoginNotice);

    WaitAndPass(500);
    SendRunLogin;
  end;
end;

procedure TfrmMain.ClientGetReconnect(body: string);
var
  Str, addr, sport: string;
begin
  Str := DecodeString(body);
  sport := GetValidStr3(Str, addr, ['/']);

  if not BoOneClick then begin
    if g_boBagLoaded then
      Savebags('.\Data\' + g_sServerName + '.' + g_sSelChrName + '.itm', @g_ItemArr);
    g_boBagLoaded := False;

    g_boServerChanging := True;

    CSocket.Active := False;
    CSocket.Host := '';
    CSocket.Port := 0;

    WaitAndPass(500);

    g_ConnectionStep := cnsPlay;

    with CSocket do begin
      Address := addr;
      Port := Str_ToInt(sport, 0);
      Active := True;
    end;

  end else begin
    if g_boBagLoaded then
      Savebags('.\Data\' + g_sServerName + '.' + g_sSelChrName + '.itm', @g_ItemArr);
    g_boBagLoaded := False;

    g_boServerChanging := True;

    g_sSockText := '';
    g_sBufferText := '';
    if CSocket.Socket.Connected then
      CSocket.Socket.SendText('$C' + addr + '/' + sport + '%');

    WaitAndPass(500);

    if CSocket.Socket.Connected then
      CSocket.Socket.SendText('$R' + addr + '/' + sport + '%');

    g_ConnectionStep := cnsPlay;
    ClearBag;
    DScreen.ClearChatBoard;
    DScreen.ChangeScene(stLoginNotice);

    WaitAndPass(300);
    ChangeServerClearGameVariables;

    SendRunLogin;
  end;
end;

procedure TfrmMain.ClientGetMapDescription(DefMsg: pTDefaultMessage; sBody: string);
var
  sTitle: string;
  sMapMusic: string;
begin
  sBody := DecodeString(sBody);
  sBody := GetValidStr3(sBody, sTitle, [#13]);
  sBody := GetValidStr3(sBody, sMapMusic, ['|']);
  if g_sMapTitle <> sTitle then begin
    g_sMapTitle := sTitle;
    g_nMapMusic := DefMsg.Recog;
    g_nPlayMusicCount := Str_ToInt(sBody, 0);
    g_sMapMusic := sMapMusic;
    if g_Config.boBGSound then
      PlayMapMusic(g_Config.boBGSound);
  end;
end;

procedure TfrmMain.ClientGetGameGoldName(DefMsg: pTDefaultMessage; sBody: string);
var
  sData: string;
begin
  if sBody <> '' then begin
    sBody := DecodeString(sBody);
    sBody := GetValidStr3(sBody, sData, [#13]);
    g_sGameGoldName := sData;
    g_sGamePointName := sBody;
  end;
  g_MySelf.m_nGameGold := DefMsg.Recog;
  g_MySelf.m_nGamePoint := MakeLong(DefMsg.param, DefMsg.tag);
end;

procedure TfrmMain.ClientGetAdjustBonus(bonus: Integer; body: string);
var
  str1, str2, str3: string;
  sMsg: string;
begin
  g_nBonusPoint := bonus;
  sMsg := body;
  sMsg := GetValidStr3(sMsg, str1, ['/']);
  str3 := GetValidStr3(sMsg, str2, ['/']);
  DecodeBuffer(str1, @g_BonusTick, SizeOf(TNakedAbility));
  DecodeBuffer(str2, @g_BonusAbil, SizeOf(TNakedAbility));
  DecodeBuffer(str3, @g_NakedAbil, SizeOf(TNakedAbility));
  FillChar(g_BonusAbilChg, SizeOf(TNakedAbility), #0);
end;

procedure TfrmMain.ClientGetAddItem(body: string);
var
  cu: TClientItem;
begin
  if body <> '' then begin
    DecodeBuffer(body, @cu, SizeOf(TClientItem));
    AddItemBag(cu);
    DScreen.AddSysMsg(cu.S.Name + ' 被发现.', 30, 40, clAqua);
  end;
end;

procedure TfrmMain.ClientGetUpdateItem(body: string);
var
  I: Integer;
  cu: TClientItem;
begin
  if body <> '' then begin
    DecodeBuffer(body, @cu, SizeOf(TClientItem));
    UpdateItemBag(cu);
    for I := Low(g_UseItems) to High(g_UseItems) do begin
      if (g_UseItems[I].S.Name = cu.S.Name) and (g_UseItems[I].MakeIndex = cu.MakeIndex) then begin
        g_UseItems[I] := cu;
      end;
    end;
  end;
end;

procedure TfrmMain.ClientGetUpdateItem2(body: string);
var
  I: Integer;
  cu: TClientItem;
begin
  if body <> '' then begin
    DecodeBuffer(body, @cu, SizeOf(TClientItem));
    UpdateItemBag2(cu);
    for I := Low(g_UseItems) to High(g_UseItems) do begin
      if {(g_UseItems[I].S.Name = cu.S.Name) and }(g_UseItems[I].MakeIndex = cu.MakeIndex) then begin
        g_UseItems[I] := cu;
      end;
    end;
  end;
end;

procedure TfrmMain.ClientGetDelItem(body: string);
var
  I: Integer;
  cu: TClientItem;
begin
  if body <> '' then begin
    DecodeBuffer(body, @cu, SizeOf(TClientItem));
    DelItemBag(cu.S.Name, cu.MakeIndex);
    for I := Low(g_UseItems) to High(g_UseItems) do begin
      if (g_UseItems[I].S.Name = cu.S.Name) and (g_UseItems[I].MakeIndex = cu.MakeIndex) then begin
        g_UseItems[I].S.Name := '';
      end;
    end;
  end;
end;

procedure TfrmMain.ClientGetDelItems(body: string);
var
  I, iindex: Integer;
  Str, iname: string;
  cu: TClientItem;
  sMsg: string;
begin
  sMsg := DecodeString(body);
  while sMsg <> '' do begin
    sMsg := GetValidStr3(sMsg, iname, ['/']);
    sMsg := GetValidStr3(sMsg, Str, ['/']);
    if (iname <> '') and (Str <> '') then begin
      iindex := Str_ToInt(Str, 0);
      DelItemBag(iname, iindex);
      for I := Low(g_UseItems) to High(g_UseItems) do begin
        if (g_UseItems[I].S.Name = iname) and (g_UseItems[I].MakeIndex = iindex) then begin
          g_UseItems[I].S.Name := '';
        end;
      end;
    end else Break;
  end;
end;

procedure TfrmMain.ClientGetBagItmes(DefMsg: pTDefaultMessage; body: string);
var
  nSize, nCrc, nInteger: Integer;
  nWord: Integer;
  nParam: Integer;
  Str: string;
  sMsg: string;
  cu: TClientItem;
  ItemSaveArr: array[0..MAXBAGITEMCL - 1] of TClientItem;

  function CompareItemArr: Boolean;
  var
    I, j: Integer;
    flag: Boolean;
  begin
    flag := True;
    for I := 0 to MAXBAGITEMCL - 1 do begin
      if ItemSaveArr[I].S.Name <> '' then begin
        flag := False;
        for j := 0 to MAXBAGITEMCL - 1 do begin
          if (g_ItemArr[j].S.Name = ItemSaveArr[I].S.Name) and
            (g_ItemArr[j].MakeIndex = ItemSaveArr[I].MakeIndex) then begin
            if (g_ItemArr[j].Dura = ItemSaveArr[I].Dura) and
              (g_ItemArr[j].DuraMax = ItemSaveArr[I].DuraMax) then begin
              flag := True;
            end;
            Break;
          end;
        end;
        if not flag then Break;
      end;
    end;
    if flag then begin
      for I := 0 to MAXBAGITEMCL - 1 do begin
        if g_ItemArr[I].S.Name <> '' then begin
          flag := False;
          for j := 0 to MAXBAGITEMCL - 1 do begin
            if (g_ItemArr[I].S.Name = ItemSaveArr[j].S.Name) and
              (g_ItemArr[I].MakeIndex = ItemSaveArr[j].MakeIndex) then begin
              if (g_ItemArr[I].Dura = ItemSaveArr[j].Dura) and
                (g_ItemArr[I].DuraMax = ItemSaveArr[j].DuraMax) then begin
                flag := True;
              end;
              Break;
            end;
          end;
          if not flag then Break;
        end;
      end;
    end;
    Result := flag;
  end;
begin
  //DScreen.AddSysMsg('TfrmMain.ClientGetBagItmes', 30, 40, clAqua);
  //nParam := DefMsg.param;
  //if nParam = 0 then begin
  SafeFillChar(g_ItemArr, SizeOf(TClientItem) * MAXBAGITEMCL, #0);
  //end;

  sMsg := body;
  while True do begin
    if sMsg = '' then Break;
    sMsg := GetValidStr3(sMsg, Str, ['/']);
    if Str <> '' then begin
      DecodeBuffer(Str, @cu, SizeOf(TClientItem));
      //cu.s.AddValue[13]  := 100;
      AddItemBag(cu);
    end else Break;
  end;
  SafeFillChar(ItemSaveArr, SizeOf(TClientItem) * MAXBAGITEMCL, #0);
  Loadbags('.\Data\' + g_sServerName + '.' + g_sSelChrName + '.itm', @ItemSaveArr);
  if CompareItemArr then begin
    Move(ItemSaveArr, g_ItemArr, SizeOf(TClientItem) * MAXBAGITEMCL);
  end;
  ArrangeItemBag;
  g_boBagLoaded := True;

  if g_boQueryHumBagItem then
    DScreen.AddChatBoardString('Bag reloaded.', clWhite, clFuchsia);
end;

//英雄相关

procedure TfrmMain.ClientGetHeroAddItem(body: string);
var
  cu: TClientItem;
begin
  if body <> '' then begin
    DecodeBuffer(body, @cu, SizeOf(TClientItem));
    AddHeroItemBag(cu);
    DScreen.AddSysMsg('英雄包裹 ' + cu.S.Name + ' 被发现.', 30, 40, clAqua);
  end;
end;

{procedure TfrmMain.ClientGetHeroChangeItem(body: string);
  function FindHeroUseItem(iname: string; iindex: Integer): Integer;
  var
    I: Integer;
  begin
    Result := -1;
    for I := High(g_HeroUseItems) downto Low(g_HeroUseItems) do begin
      if (g_HeroUseItems[I].S.Name = iname) and (g_HeroUseItems[I].MakeIndex = iindex) then begin
        Result := I;
        Break;
      end;
    end;
  end;

  function FindHeroItemBag(iname: string; iindex: Integer): Integer;
  var
    I: Integer;
  begin
    Result := -1;
    for I := High(g_HeroItemArr) downto Low(g_HeroItemArr) do begin
      if (g_HeroItemArr[I].S.Name = iname) and (g_HeroItemArr[I].MakeIndex = iindex) then begin
        Result := I;
        Break;
      end;
    end;
  end;

var
  Index, Index0, Index1: Integer;
  nWhere1, nWhere2: Integer;
  Str, str1, data: string;
  cu0, cu1: TClientItem;
  sMsg: string;
begin
  Index0 := -1;
  Index1 := -1;
  FillChar(cu0, SizeOf(TClientItem), #0);
  FillChar(cu1, SizeOf(TClientItem), #0);
  sMsg := body;
  while True do begin
    if sMsg = '' then Break;
    sMsg := GetValidStr3(sMsg, Str, ['/']);
    sMsg := GetValidStr3(sMsg, str1, ['/']);
    sMsg := GetValidStr3(sMsg, data, ['/']);
    Index := Str_ToInt(Str, -1);
    case Index of
      0: begin
          nWhere1 := Str_ToInt(str1, -1);
          DecodeBuffer(data, @cu0, SizeOf(TClientItem));
        end;
      1: begin
          nWhere2 := Str_ToInt(str1, -1);
          DecodeBuffer(data, @cu1, SizeOf(TClientItem));
        end;
    end;
    str1 := '';
  end;
  if cu1.S.Name <> '' then begin
    Index1 := FindHeroUseItem(cu1.S.Name, cu1.MakeIndex);
    if (cu0.S.Name <> '') and (Index1 >= 0) then begin
      Index0 := FindHeroItemBag(cu0.S.Name, cu0.MakeIndex);
      if Index0 >= 0 then begin
        g_HeroUseItems[Index1] := cu0;
        g_HeroItemArr[Index0].S.Name := '';
        AddHeroItemBag(cu1);
        DScreen.AddSysMsg('英雄包裹 ' + cu1.S.Name + ' 被发现.', 30, 40, clAqua);
      end;
    end else begin
      g_HeroUseItems[Index1].S.Name := '';
      AddHeroItemBag(cu1);
      DScreen.AddSysMsg('英雄包裹 ' + cu1.S.Name + ' 被发现.', 30, 40, clAqua);
    end;
  end else
    if cu0.S.Name <> '' then begin
    Index0 := FindHeroItemBag(cu0.S.Name, cu0.MakeIndex);
    if Index0 >= 0 then begin
      if nWhere1 in [Low(g_HeroUseItems)..High(g_HeroUseItems)] then begin
        g_HeroUseItems[nWhere1] := cu0;
        g_HeroItemArr[Index0].S.Name := '';
      end;
    end;
  end;
end; }

procedure TfrmMain.ClientGetHeroChangeItem(body: string);
  function FindHeroUseItem(iname: string; iindex: Integer): Integer;
  var
    I: Integer;
  begin
    Result := -1;
    for I := High(g_HeroUseItems) downto Low(g_HeroUseItems) do begin
      if (g_HeroUseItems[I].S.Name = iname) and (g_HeroUseItems[I].MakeIndex = iindex) then begin
        Result := I;
        Break;
      end;
    end;
  end;

  function FindHeroItemBag(iname: string; iindex: Integer): Integer;
  var
    I: Integer;
  begin
    Result := -1;
    for I := High(g_HeroItemArr) downto Low(g_HeroItemArr) do begin
      if (g_HeroItemArr[I].S.Name = iname) and (g_HeroItemArr[I].MakeIndex = iindex) then begin
        Result := I;
        Break;
      end;
    end;
  end;

var
  nIndex, nWhere: Integer;
  nMakeIndex: Integer;
  sItemName: string;
  sindex: string;
  sMakeIndex: string;
  UseItem: TClientItem;
  sMsg: string;
  boFlag: Boolean;
begin
  //if g_boItemMoving then Exit;
  sMsg := DecodeString(body);
  sMsg := GetValidStr3(sMsg, sindex, ['/']);
  sMsg := GetValidStr3(sMsg, sItemName, ['/']);
  sMsg := GetValidStr3(sMsg, sMakeIndex, ['/']);
  nWhere := Str_ToInt(sindex, -1);
  nMakeIndex := Str_ToInt(sMakeIndex, 0);
  if (nWhere in [U_DRESS..U_CHARM]) and (nMakeIndex <> 0) and (sItemName <> '') then begin
    nIndex := FindHeroItemBag(sItemName, nMakeIndex);
    if (nIndex >= 0) and (g_HeroItemArr[nIndex].S.Name <> '') then begin
      boFlag := False;
      case GetTakeOnPosition(g_HeroItemArr[nIndex].S.StdMode) of
        U_DRESS: begin
            if g_MySelf.m_btSex = 0 then
              if g_HeroItemArr[nIndex].S.StdMode <> 10 then
                Exit;
            if g_MySelf.m_btSex = 1 then
              if g_HeroItemArr[nIndex].S.StdMode <> 11 then
                Exit;
            boFlag := True;
          end;
      else boFlag := True;
      end;
      if boFlag then begin
        if g_HeroUseItems[nWhere].S.Name <> '' then begin
          UseItem := g_HeroUseItems[nWhere];
          g_HeroUseItems[nWhere] := g_HeroItemArr[nIndex];
          g_HeroItemArr[nIndex] := UseItem;
        end else begin
          g_HeroUseItems[nWhere] := g_HeroItemArr[nIndex];
          g_HeroItemArr[nIndex].S.Name := '';
        end;
      end;
    end;
  end;
  ArrangeHeroItemBag;
end;

procedure TfrmMain.ClientGetHeroUpdateItem(body: string);
var
  I: Integer;
  cu: TClientItem;
begin
  if body <> '' then begin
    DecodeBuffer(body, @cu, SizeOf(TClientItem));
    UpdateHeroItemBag(cu);
    for I := Low(g_HeroUseItems) to High(g_HeroUseItems) do begin
      if (g_HeroUseItems[I].S.Name = cu.S.Name) and (g_HeroUseItems[I].MakeIndex = cu.MakeIndex) then begin
        g_HeroUseItems[I] := cu;
      end;
    end;
  end;
  ArrangeHeroItemBag;
end;

procedure TfrmMain.ClientGetHeroDelItem(body: string);
var
  I: Integer;
  cu: TClientItem;
begin
  if body <> '' then begin
    DecodeBuffer(body, @cu, SizeOf(TClientItem));
    DelHeroItemBag(cu.S.Name, cu.MakeIndex);
    for I := Low(g_HeroUseItems) to High(g_HeroUseItems) do begin
      if (g_HeroUseItems[I].S.Name = cu.S.Name) and (g_HeroUseItems[I].MakeIndex = cu.MakeIndex) then begin
        g_HeroUseItems[I].S.Name := '';
      end;
    end;
  end;
  ArrangeHeroItemBag;
end;

procedure TfrmMain.ClientGetHeroDelItems(body: string);
var
  I, iindex: Integer;
  Str, iname, sMsg: string;
  cu: TClientItem;
begin
  sMsg := DecodeString(body);
  while sMsg <> '' do begin
    sMsg := GetValidStr3(sMsg, iname, ['/']);
    sMsg := GetValidStr3(sMsg, Str, ['/']);
    if (iname <> '') and (Str <> '') then begin
      iindex := Str_ToInt(Str, 0);
      DelHeroItemBag(iname, iindex);
      for I := Low(g_HeroUseItems) to High(g_HeroUseItems) do begin
        if (g_HeroUseItems[I].S.Name = iname) and (g_HeroUseItems[I].MakeIndex = iindex) then begin
          g_HeroUseItems[I].S.Name := '';
        end;
      end;
    end else Break;
  end;
  ArrangeHeroItemBag;
end;

procedure TfrmMain.ClientGetHeroBagItmes(DefMsg: pTDefaultMessage; body: string);
var
  sData, Str: string;
  cu: TClientItem;
begin
  ClearHeroBag;
  sData := body;
  while True do begin
    if sData = '' then Break;
    sData := GetValidStr3(sData, Str, ['/']);
    if Str <> '' then begin
      DecodeBuffer(Str, @cu, SizeOf(TClientItem));
      AddHeroItemBag(cu);
    end;
  end;
  ArrangeHeroItemBag;

  if g_boQueryHeroBagItem then
    DScreen.AddChatBoardString('Hero Bag reloaded.', clWhite, clFuchsia);
end;

procedure TfrmMain.ClientGetShopItems(DefMsg: pTDefaultMessage; body: string);
  procedure AddItemToShop(ShopItem: TShopItem);
  var
    I: Integer;
  begin
    if ShopItem.StdItem.Name <> '' then begin
      if (ShopItem.btItemType >= 0) and (ShopItem.btItemType <= 4) then begin
        for I := 0 to 9 do begin
          if g_ShopItems[ShopItem.btItemType, I].StdItem.Name = '' then begin
            g_ShopItems[ShopItem.btItemType, I] := ShopItem;
            Break;
          end;
        end;
      end else
        if ShopItem.btItemType = 5 then begin
        for I := 0 to 4 do begin
          if g_SuperShopItems[I].StdItem.Name = '' then begin
            g_SuperShopItems[I] := ShopItem;
            Break;
          end;
        end;
      end;
    end;
  end;
var
  Str, sData: string;
  cu: TShopItem;
  ShopItem: pTShopItem;
  I: Integer;
begin
  sData := body;
  if DefMsg.series in [0..5] then begin
    if DefMsg.series = 5 then begin
      for I := Low(g_SuperShopItems) to High(g_SuperShopItems) do g_SuperShopItems[I].StdItem.Name := '';
      //FillChar(g_SuperShopItems, SizeOf(TShopItem) * 5, #0);
    end else begin
      for I := Low(g_ShopItems[DefMsg.series]) to High(g_ShopItems[DefMsg.series]) do g_ShopItems[DefMsg.series, I].StdItem.Name := '';
      //FillChar(g_ShopItems[Msg.series], SizeOf(TShopItem) * 10, #0);
    end;
    while True do begin
      if sData = '' then Break;
      sData := GetValidStr3(sData, Str, ['/']);
      if Str <> '' then begin
        DecodeBuffer(Str, @cu, SizeOf(TShopItem));
        AddItemToShop(cu);
      end else Break;
    end;
    FrmDlg.ShopPage[DefMsg.series] := DefMsg.tag;
    FrmDlg.ShopPageCount := DefMsg.param;
  end;
  //Showmessage('Length(body): ' + IntToStr(Length(body)));
  {Showmessage('Msg.tag ' + IntToStr(Msg.tag));
  Showmessage('Msg.series ' + IntToStr(Msg.series));
  Showmessage('Msg.Param ' + IntToStr(Msg.Param)); }
end;


procedure TfrmMain.ClientGetRanking(DefMsg: pTDefaultMessage;
  sBody: string);

  procedure AddUserRanking(Ranking: TUserLevelRanking);
  var
    I: Integer;
  begin
    for I := 0 to 9 do begin
      if g_UserLevelRankings[I].sChrName = '' then begin
        g_UserLevelRankings[I] := Ranking;
        Break;
      end;
    end;
  end;
  procedure AddHeroRanking(Ranking: THeroLevelRanking);
  var
    I: Integer;
  begin
    for I := 0 to 9 do begin
      if g_HeroLevelRankings[I].sChrName = '' then begin
        g_HeroLevelRankings[I] := Ranking;
        Break;
      end;
    end;
  end;
  procedure AddMasterRanking(Ranking: TUserMasterRanking);
  var
    I: Integer;
  begin
    for I := 0 to 9 do begin
      if g_UserMasterRankings[I].sChrName = '' then begin
        g_UserMasterRankings[I] := Ranking;
        Break;
      end;
    end;
  end;
var
  UserRanking: TUserLevelRanking;
  HeroRanking: THeroLevelRanking;
  MasterRanking: TUserMasterRanking;
  Str: string;
begin
  if DefMsg.param in [0..2] then begin
    g_nRankingsTablePage := DefMsg.param;
    g_nRankingsTableType := DefMsg.Recog;
    g_nRankingsPage := DefMsg.tag;
    g_nRankingsPageCount := DefMsg.series;
    //FrmDlg.RankingPage := Msg.Param;
    case g_nRankingsTablePage of
      0: begin
          //FrmDlg.DBotCharRanking.Down := True;
          SafeFillChar(g_UserLevelRankings, SizeOf(TUserLevelRanking) * 10, #0);
          while True do begin
            if sBody = '' then Break;
            sBody := GetValidStr3(sBody, Str, ['/']);
            DecodeBuffer(Str, @UserRanking, SizeOf(TUserLevelRanking));
            AddUserRanking(UserRanking);
          end;
        end;
      1: begin
          //FrmDlg.DBotHeroRanking.Down := True;
          SafeFillChar(g_HeroLevelRankings, SizeOf(THeroLevelRanking) * 10, #0);
          while True do begin
            if sBody = '' then Break;
            sBody := GetValidStr3(sBody, Str, ['/']);
            DecodeBuffer(Str, @HeroRanking, SizeOf(THeroLevelRanking));
            AddHeroRanking(HeroRanking);
          end;
        end;
      2: begin
          //FrmDlg.DBotMasterRanking.Down := True;
          SafeFillChar(g_UserMasterRankings, SizeOf(TUserMasterRanking) * 10, #0);
          while True do begin
            if sBody = '' then Break;
            sBody := GetValidStr3(sBody, Str, ['/']);
            DecodeBuffer(Str, @MasterRanking, SizeOf(TUserMasterRanking));
            AddMasterRanking(MasterRanking);
          end;
        end;
    end;
  end;
end;

{procedure TfrmMain.ClientGetSortItems(DefMsg: pTDefaultMessage; body: string);
  procedure AddUserLevelSortList(UserLevelSort: TUserLevelSort);
  var
    I: Integer;
  begin
    for I := Low(g_PlaySortItems) to High(g_PlaySortItems) do begin
      if g_PlaySortItems[I].sChrName = '' then begin
        g_PlaySortItems[I] := UserLevelSort;
        Break;
      end;
    end;
  end;
  procedure AddHeroLevelSortList(HeroLevelSort: THeroLevelSort);
  var
    I: Integer;
  begin
    for I := Low(g_HeroSortItems) to High(g_HeroSortItems) do begin
      if g_HeroSortItems[I].sChrName = '' then begin
        g_HeroSortItems[I] := HeroLevelSort;
        Break;
      end;
    end;
  end;
  procedure AddUserMasterSortList(UserMasterSort: TUserMasterSort);
  var
    I: Integer;
  begin
    for I := Low(g_UserMasterItems) to High(g_UserMasterItems) do begin
      if g_UserMasterItems[I].sChrName = '' then begin
        g_UserMasterItems[I] := UserMasterSort;
        Break;
      end;
    end;
  end;

var
  I: Integer;
  Str, sData: string;
  UserLevelSort: TUserLevelSort;
  HeroLevelSort: THeroLevelSort;
  UserMasterSort: TUserMasterSort;
begin
  if Msg.Recog >= 0 then begin
    FrmDlg.SortStatePage := Msg.Recog;
    FrmDlg.SortPage := Msg.param;
    FrmDlg.SortPageCount := Msg.series;
  end;

  sData := body;
  case Msg.Recog of
    -1: begin
        FrmDlg.DMessageDlg('你没有上榜或不在该榜！！！', [mbOk]);
      end;
    0: begin
        FrmDlg.PlayJobSortStatePage := Msg.tag;
        while True do begin
          if sData = '' then Break;
          sData := GetValidStr3(sData, Str, ['/']);
          if Str <> '' then begin
            DecodeBuffer(Str, @UserLevelSort, SizeOf(TUserLevelSort));
            AddUserLevelSortList(UserLevelSort);
          end else Break;
        end;
      end;
    1: begin
        FrmDlg.HeroJobSortStatePage := Msg.tag;
        while True do begin
          if sData = '' then Break;
          sData := GetValidStr3(sData, Str, ['/']);
          if Str <> '' then begin
            DecodeBuffer(Str, @HeroLevelSort, SizeOf(THeroLevelSort));
            AddHeroLevelSortList(HeroLevelSort);
          end else Break;
        end;
      end;
    2: begin
        while True do begin
          if sData = '' then Break;
          sData := GetValidStr3(sData, Str, ['/']);
          if Str <> '' then begin
            DecodeBuffer(Str, @UserMasterSort, SizeOf(TUserMasterSort));
            AddUserMasterSortList(UserMasterSort);
          end else Break;
        end;
      end;
  end;
end; }

procedure TfrmMain.ClientGetSellItems(DefMsg: pTDefaultMessage; body: string);
  procedure AddSellItem(cu: TClientSellItem);
  var
    I: Integer;
  begin
    for I := Low(g_SellItems) to High(g_SellItems) do begin
      if (g_SellItems[I].sCharName = '') or (g_SellItems[I].SellItem.S.Name = '') then begin
        g_SellItems[I] := cu;
        Break;
      end;
    end;
  end;
  procedure ClearSellItem();
  var
    I: Integer;
  begin
    for I := Low(g_SellItems) to High(g_SellItems) do begin
      g_SellItems[I].sCharName := '';
      g_SellItems[I].SellItem.S.Name := '';
    end;
    g_MouseSellItems.SellItem.S.Name := '';
  end;
var
  Str, sData: string;
  cu: TClientSellItem;
  I: Integer;
begin
  FrmDlg.OpenSellOffDlg;
  if DefMsg.Recog >= 0 then begin
    g_nSellItemType := DefMsg.Recog;
    g_nSellItemPage := DefMsg.param;
    g_nSellItemPageCount := DefMsg.tag;
  end;
  SafeFillChar(g_SellItems, SizeOf(TClientSellItem) * 10, #0);
  SafeFillChar(g_MouseSellItems, SizeOf(TClientSellItem), #0);
  ClearSellItem();
  sData := DecodeString(body);
  while True do begin
    if sData = '' then Break;
    sData := GetValidStr3(sData, Str, ['/']);
    if Str <> '' then begin
      DecodeBuffer(Str, @cu, SizeOf(TClientSellItem));
      if (cu.SellItem.S.Name <> '') and (cu.sCharName <> '') then begin
        AddSellItem(cu);
      end;
    end else Break;
  end;
end;

procedure TfrmMain.ClientGetHeroDropItemFail(iname: string; sindex: Integer);
var
  pc: PTClientItem;
begin
  pc := GetDropItem(iname, sindex);
  if pc <> nil then begin
    AddHeroItemBag(pc^);
    DelDropItem(iname, sindex);
  end;
end;

procedure TfrmMain.ClientGetDropItemFail(iname: string; sindex: Integer);
var
  pc: PTClientItem;
begin
  pc := GetDropItem(iname, sindex);
  if pc <> nil then begin
    AddItemBag(pc^);
    DelDropItem(iname, sindex);
  end;
end;

procedure TfrmMain.ClientGetShowItem(DefMsg: pTDefaultMessage;
  sData: string);
var
  I, II: Integer;
  List: TList;
  DropItem: pTDropItem;
  boFind: Boolean;
  boFindItem: Boolean;
begin
  List := nil;
  boFind := False;
  boFindItem := False;
  g_DropedItemList.Lock;
  try
    for I := 0 to g_DropedItemList.Count - 1 do begin
      List := TList(g_DropedItemList.Items[I]);
      if List.Count > 0 then begin
        if (pTDropItem(List.Items[0]).X = DefMsg.param) and (pTDropItem(List.Items[0]).Y = DefMsg.tag) then begin
          for II := 0 to List.Count - 1 do begin
            if pTDropItem(List.Items[II]).id = DefMsg.Recog then begin
              boFindItem := True;
              Break;
            end;
          end;
          if boFindItem then Break;
          boFind := True;
          Break;
        end else List := nil;
      end else List := nil;
      if boFind then Break;
    end;
    if not boFindItem then begin
      if List = nil then begin
        List := TList.Create;
        g_DropedItemList.Add(List);
      end;
      New(DropItem);
      DropItem.id := DefMsg.Recog;
      DropItem.X := DefMsg.param;
      DropItem.Y := DefMsg.tag;
      DropItem.looks := DefMsg.series;
      DropItem.Name := DecodeString(sData);
      DropItem.FlashTime := GetTickCount - LongWord(Random(3000));
      DropItem.BoFlash := False;
      List.Insert(0, DropItem);
      if g_Config.boItemHint then
        g_ShowItemList.Hint(DropItem);
    end;
  finally
    g_DropedItemList.UnLock;
  end;
end;

procedure TfrmMain.ClientGetHideItem(DefMsg: pTDefaultMessage);
var
  I, II: Integer;
  List: TList;
  boFind: Boolean;
  DropItem: pTDropItem;
begin
  g_DropedItemList.Lock;
  try
    boFind := False;
    for I := g_DropedItemList.Count - 1 downto 0 do begin
      List := TList(g_DropedItemList.Items[I]);
      for II := List.Count - 1 downto 0 do begin
        DropItem := List.Items[II];
        if DropItem.id = DefMsg.Recog then begin
          List.Delete(II);
          Dispose(DropItem);
          if List.Count <= 0 then begin
            g_DropedItemList.Delete(I);
            List.Free;
          end;
          boFind := True;
          Break;
        end;
      end;
      if boFind then Break;
    end;
  finally
    g_DropedItemList.UnLock;
  end;
end;

//////////////////////////////////英雄相关//////////////////////////////////////

procedure TfrmMain.ClientGetSendHerouseItems(body: string); //英雄装备
var
  Index: Integer;
  Str, Data, sMsg: string;
  cu: TClientItem;
begin
  SafeFillChar(g_HeroUseItems, SizeOf(TClientItem) * High(g_HeroUseItems), #0);
  sMsg := body;
  while True do begin
    if sMsg = '' then Break;
    sMsg := GetValidStr3(sMsg, Str, ['/']);
    sMsg := GetValidStr3(sMsg, Data, ['/']);
    Index := Str_ToInt(Str, -1);
    if Index in [0..12] then begin
      if Data <> '' then begin
        DecodeBuffer(Data, @cu, SizeOf(TClientItem));
        g_HeroUseItems[Index] := cu;
      end;
    end;
  end;
end;

procedure TfrmMain.ClientGetHeroAddMagic(body: string);
var
  pcm: PTClientMagic;
begin
  if body <> '' then begin
    New(pcm);
    DecodeBuffer(body, @(pcm^), SizeOf(TClientMagic));
    if pcm.Def.sMagicName <> '' then begin
      g_HeroMagicList.Add(pcm);
    end else begin
      Dispose(pcm);
    end;
  end;
end;

procedure TfrmMain.ClientGetHeroDelMagic(magid: Integer);
var
  I: Integer;
begin
  for I := g_HeroMagicList.Count - 1 downto 0 do begin
    if PTClientMagic(g_HeroMagicList[I]).Def.wMagicId = magid then begin
      Dispose(PTClientMagic(g_HeroMagicList[I]));
      g_HeroMagicList.Delete(I);
      Break;
    end;
  end;
end;

procedure TfrmMain.ClientGetMyHeroMagics(body: string);
var
  I: Integer;
  Data, sMsg: string;
  pcm: PTClientMagic;
begin
  for I := 0 to g_HeroMagicList.Count - 1 do begin
    Dispose(PTClientMagic(g_HeroMagicList.Items[I]));
  end;
  g_HeroMagicList.Clear;
  sMsg := body;
  while True do begin
    if sMsg = '' then Break;
    sMsg := GetValidStr3(sMsg, Data, ['/']);
    if Data <> '' then begin
      New(pcm);
      DecodeBuffer(Data, @(pcm^), SizeOf(TClientMagic));
      if pcm.Def.sMagicName <> '' then begin
        g_HeroMagicList.Add(pcm);
      end else begin
        Dispose(pcm);
        Break;
      end;
    end else Break;
  end;
end;

procedure TfrmMain.ClientGetSendHeroAddUseItems(body: string);
var
  Index: Integer;
  Str, Data, sMsg: string;
  cu: TClientItem;
begin
  sMsg := body;
  while True do begin
    if sMsg = '' then Break;
    sMsg := GetValidStr3(sMsg, Str, ['/']);
    sMsg := GetValidStr3(sMsg, Data, ['/']);
    Index := Str_ToInt(Str, -1);
    if Index in [9..12] then begin
      DecodeBuffer(Data, @cu, SizeOf(TClientItem));
      g_HeroUseItems[Index] := cu;
    end;
  end;
end;
/////////////////////////////////////////////////////////////////////////////////

procedure TfrmMain.ClientGetSendAddUseItems(body: string);
var
  Index: Integer;
  Str, Data, sMsg: string;
  cu: TClientItem;
begin
  sMsg := body;
  while True do begin
    if sMsg = '' then Break;
    sMsg := GetValidStr3(sMsg, Str, ['/']);
    sMsg := GetValidStr3(sMsg, Data, ['/']);
    Index := Str_ToInt(Str, -1);
    if Index in [9..12] then begin
      DecodeBuffer(Data, @cu, SizeOf(TClientItem));
      g_UseItems[Index] := cu;
    end else Break;
  end;
end;

procedure TfrmMain.ClientGetSenduseItems(body: string);
var
  Index: Integer;
  Str, Data, sMsg: string;
  cu: TClientItem;
begin
  SafeFillChar(g_UseItems, SizeOf(TClientItem) * 13, #0);
  sMsg := body;
  while True do begin
    if sMsg = '' then Break;
    sMsg := GetValidStr3(sMsg, Str, ['/']);
    sMsg := GetValidStr3(sMsg, Data, ['/']);
    Index := Str_ToInt(Str, -1);
    if Index in [0..12] then begin
      DecodeBuffer(Data, @cu, SizeOf(TClientItem));
      g_UseItems[Index] := cu;
    end else Break;
  end;
end;

procedure TfrmMain.ClientGetAddMagic(body: string);
var
  pcm: PTClientMagic;
begin
  New(pcm);
  DecodeBuffer(body, @(pcm^), SizeOf(TClientMagic));
  if pcm.Def.wMagicId in [100..111] then begin
    g_SerieMagicList.Add(pcm);
    if FrmDlg.DSerieMagicMenu.Count <= 0 then begin
      FrmDlg.DSerieMagicMenu.Add('清除技能', nil);
      FrmDlg.DSerieMagicMenu.Add('随机选择', nil);
      FrmDlg.DSerieMagicMenu.Add('-', nil);
    end;
    FrmDlg.DSerieMagicMenu.Add(pcm.Def.sMagicName, nil);
  end else begin
    g_MagicList.Add(pcm);
    FrmDlg.DComboboxAutoUseMagic.Items.AddObject(pcm.Def.sMagicName, TObject(pcm));
    FrmDlg.DComboboxGuajiQunti.Items.AddObject(pcm.Def.sMagicName, TObject(pcm));
    FrmDlg.DComboboxGuajiGeti.Items.AddObject(pcm.Def.sMagicName, TObject(pcm));
  end;
end;

procedure TfrmMain.ClientGetDelMagic(magid: Integer);
var
  I: Integer;
  pcm: PTClientMagic;
  boSave: Boolean;
begin
  for I := g_MagicList.Count - 1 downto 0 do begin
    if PTClientMagic(g_MagicList[I]).Def.wMagicId = magid then begin
      Dispose(PTClientMagic(g_MagicList[I]));
      g_MagicList.Delete(I);
      Break;
    end;
  end;
  for I := 0 to g_SerieMagicList.Count - 1 do begin //连击
    if PTClientMagic(g_SerieMagicList[I]).Def.wMagicId = magid then begin
      Dispose(PTClientMagic(g_SerieMagicList[I]));
      g_SerieMagicList.Delete(I);
      Break;
    end;
  end;
  FrmDlg.DSerieMagicMenu.Clear;
  FrmDlg.DComboboxAutoUseMagic.Items.Clear;
  FrmDlg.DComboboxGuajiQunti.Items.Clear;
  FrmDlg.DComboboxGuajiGeti.Items.Clear;
  for I := 0 to g_MagicList.Count - 1 do begin
    FrmDlg.DComboboxAutoUseMagic.Items.AddObject(PTClientMagic(g_MagicList.Items[I]).Def.sMagicName, TObject(g_MagicList.Items[I]));
    FrmDlg.DComboboxGuajiQunti.Items.AddObject(PTClientMagic(g_MagicList.Items[I]).Def.sMagicName, TObject(g_MagicList.Items[I]));
    FrmDlg.DComboboxGuajiGeti.Items.AddObject(PTClientMagic(g_MagicList.Items[I]).Def.sMagicName, TObject(g_MagicList.Items[I]));
  end;

  if (g_SerieMagicList.Count > 0) and (FrmDlg.DSerieMagicMenu.Count <= 0) then begin
    FrmDlg.DSerieMagicMenu.Add('清除技能', nil);
    FrmDlg.DSerieMagicMenu.Add('随机选择', nil);
    FrmDlg.DSerieMagicMenu.Add('-', nil);
  end;

  for I := 0 to g_SerieMagicList.Count - 1 do begin
    FrmDlg.DSerieMagicMenu.Add(PTClientMagic(g_SerieMagicList.Items[I]).Def.sMagicName, nil);
  end;
  boSave := False;
  for I := 0 to 7 do begin
    if g_SerieMagic[I].nMagicID > 0 then begin
      pcm := FindSerieMagic(g_SerieMagic[I].nMagicID);
      if pcm <> nil then begin
        g_SerieMagic[I].Magic := pcm^;
      end else begin
        g_SerieMagic[I].nMagicID := -1;
        g_SerieMagic[I].Magic.Def.wMagicId := 0;
        g_SerieMagic[I].Magic.Def.sMagicName := '';
        boSave := True;

      end;
    end;
  end;
  if boSave then SaveUserConfig();
end;

procedure TfrmMain.ClientGetMyMagics(body: string);
var
  I: Integer;
  Data, sMsg: string;
  pcm: PTClientMagic;
  boSave: Boolean;
begin
  for I := 0 to g_MagicList.Count - 1 do
    Dispose(PTClientMagic(g_MagicList[I]));
  g_MagicList.Clear;
  for I := 0 to g_SerieMagicList.Count - 1 do //连击
    Dispose(PTClientMagic(g_SerieMagicList[I]));
  g_SerieMagicList.Clear;

  FrmDlg.DSerieMagicMenu.Clear;
  FrmDlg.DComboboxAutoUseMagic.Items.Clear;
  sMsg := body;
  while True do begin
    if sMsg = '' then Break;
    sMsg := GetValidStr3(sMsg, Data, ['/']);
    if Data <> '' then begin
      New(pcm);
      DecodeBuffer(Data, @(pcm^), SizeOf(TClientMagic));
      if pcm.Def.sMagicName <> '' then begin
        if pcm.Def.wMagicId in [100..111] then begin
          g_SerieMagicList.Add(pcm);
          if (g_SerieMagicList.Count > 0) and (FrmDlg.DSerieMagicMenu.Count <= 0) then begin
            FrmDlg.DSerieMagicMenu.Add('清除技能', nil);
            FrmDlg.DSerieMagicMenu.Add('随机选择', nil);
            FrmDlg.DSerieMagicMenu.Add('-', nil);
          end;
          FrmDlg.DSerieMagicMenu.Add(pcm.Def.sMagicName, nil);
        end else begin
          g_MagicList.Add(pcm);
          FrmDlg.DComboboxAutoUseMagic.Items.AddObject(pcm.Def.sMagicName, TObject(pcm));
          FrmDlg.DComboboxGuajiQunti.Items.AddObject(pcm.Def.sMagicName, TObject(pcm));
          FrmDlg.DComboboxGuajiGeti.Items.AddObject(pcm.Def.sMagicName, TObject(pcm));
        end;
      end else begin
        Dispose(pcm);
        Break;
      end;
    end else Break;
  end;
  FrmDlg.DComboboxAutoUseMagic.itemindex := g_Config.nAutoUseMagicIdx;

  boSave := False;
  for I := 0 to 7 do begin
    if g_SerieMagic[I].nMagicID > 0 then begin
      pcm := FindSerieMagic(g_SerieMagic[I].nMagicID);
      if pcm <> nil then begin
        g_SerieMagic[I].Magic := pcm^;
      end else begin
        g_SerieMagic[I].nMagicID := -1;
        g_SerieMagic[I].Magic.Def.wMagicId := 0;
        g_SerieMagic[I].Magic.Def.sMagicName := '';
        boSave := True;
      end;
    end;
  end;
  if boSave then SaveUserConfig();
end;

procedure TfrmMain.ClientGetMagicLvExp(magid, maglv, magtrain: Integer);
var
  I: Integer;
begin
  for I := 0 to g_MagicList.Count - 1 do begin
    if PTClientMagic(g_MagicList[I]).Def.wMagicId = magid then begin
      PTClientMagic(g_MagicList[I]).Level := maglv;
      PTClientMagic(g_MagicList[I]).CurTrain := magtrain;
      Break;
    end;
  end;

  for I := 0 to g_SerieMagicList.Count - 1 do begin
    if PTClientMagic(g_SerieMagicList[I]).Def.wMagicId = magid then begin
      PTClientMagic(g_SerieMagicList[I]).Level := maglv;
      PTClientMagic(g_SerieMagicList[I]).CurTrain := magtrain;
      Break;
    end;
  end;
end;

procedure TfrmMain.ClientGetDuraChange(uidx, newdura, newduramax: Integer);
begin
  if uidx in [0..12] then begin
    if g_UseItems[uidx].S.Name <> '' then begin
      g_UseItems[uidx].Dura := newdura;
      g_UseItems[uidx].DuraMax := newduramax;
    end;
  end;
end;

procedure TfrmMain.ClientGetHeroMagicLvExp(magid, maglv, magtrain: Integer);
var
  I: Integer;
begin
  for I := 0 to g_HeroMagicList.Count - 1 do begin
    if PTClientMagic(g_HeroMagicList[I]).Def.wMagicId = magid then begin
      PTClientMagic(g_HeroMagicList[I]).Level := maglv;
      PTClientMagic(g_HeroMagicList[I]).CurTrain := magtrain;
      Break;
    end;
  end;
end;

procedure TfrmMain.ClientGetHeroDuraChange(uidx, newdura, newduramax: Integer);
begin
  if uidx in [0..12] then begin
    if g_HeroUseItems[uidx].S.Name <> '' then begin
      g_HeroUseItems[uidx].Dura := newdura;
      g_HeroUseItems[uidx].DuraMax := newduramax;
    end;
  end;
end;

procedure TfrmMain.ClientGetMerchantSay(merchant, face: Integer; saying: string);
var
  npcname, sMsg: string;
begin
  g_nMDlgX := g_MySelf.m_nCurrX;
  g_nMDlgY := g_MySelf.m_nCurrY;
  if g_nCurMerchant <> merchant then begin
    g_nCurMerchant := merchant;
    FrmDlg.ResetMenuDlg;
    FrmDlg.CloseMDlg;
  end;
  //FrmDlg.CloseMDlg;

  FrmDlg.DBook.Visible := False;
  sMsg := saying;
  sMsg := GetValidStr3(sMsg, npcname, ['/']);
  g_sCurMerchantName := npcname;
  g_nCurMerchantFace := face;
  //DScreen.AddChatBoardString('TfrmMain.ClientGetMerchantSay', clyellow, clRed);
  FrmDlg.ShowMDlg(face, npcname, sMsg);
end;

procedure TfrmMain.ClientGetSendGoodsList(merchant, Count: Integer; body: string);
var
  I: Integer;
  Data, gname, gsub, gprice, gstock, sMsg: string;
  pcg: PTClientGoods;
begin
  FrmDlg.ResetMenuDlg;
  g_nCurMerchant := merchant;
  with FrmDlg do begin
    sMsg := DecodeString(body);
    while sMsg <> '' do begin
      sMsg := GetValidStr3(sMsg, gname, ['/']);
      sMsg := GetValidStr3(sMsg, gsub, ['/']);
      sMsg := GetValidStr3(sMsg, gprice, ['/']);
      sMsg := GetValidStr3(sMsg, gstock, ['/']);
      if (gname <> '') and (gprice <> '') and (gstock <> '') then begin
        New(pcg);
        pcg.Name := gname;
        pcg.SubMenu := Str_ToInt(gsub, 0);
        pcg.Price := Str_ToInt(gprice, 0);
        pcg.Stock := Str_ToInt(gstock, 0);
        pcg.Grade := -1;
        MenuList.Add(pcg);
      end else Break;
    end;
    FrmDlg.ShowShopMenuDlg;
    FrmDlg.CurDetailItem := '';
  end;
end;

procedure TfrmMain.ClientGetSendMakeDrugList(merchant: Integer; body: string);
var
  I: Integer;
  Data, gname, gsub, gprice, gstock, sMsg: string;
  pcg: PTClientGoods;
begin
  FrmDlg.ResetMenuDlg;

  g_nCurMerchant := merchant;
  with FrmDlg do begin
    sMsg := DecodeString(body);
    while sMsg <> '' do begin
      sMsg := GetValidStr3(sMsg, gname, ['/']);
      sMsg := GetValidStr3(sMsg, gsub, ['/']);
      sMsg := GetValidStr3(sMsg, gprice, ['/']);
      sMsg := GetValidStr3(sMsg, gstock, ['/']);
      if (gname <> '') and (gprice <> '') and (gstock <> '') then begin
        New(pcg);
        pcg.Name := gname;
        pcg.SubMenu := Str_ToInt(gsub, 0);
        pcg.Price := Str_ToInt(gprice, 0);
        pcg.Stock := Str_ToInt(gstock, 0);
        pcg.Grade := -1;
        MenuList.Add(pcg);
      end else Break;
    end;
    FrmDlg.ShowShopMenuDlg;
    FrmDlg.CurDetailItem := '';
    FrmDlg.BoMakeDrugMenu := True;
  end;
end;

procedure TfrmMain.ClientGetSendUserChangeItem(merchant: Integer);
begin
  FrmDlg.CloseDSellDlg;
  g_nCurMerchant := merchant;
  FrmDlg.SpotDlgMode := dmChange;
  FrmDlg.ShowShopSellDlg;
  //Showmessage('TfrmMain.ClientGetSendUserChangeItem');
end;

procedure TfrmMain.ClientGetSendUserSellOff(merchant: Integer);
begin
  FrmDlg.CloseDSellDlg;
  g_nCurMerchant := merchant;
  FrmDlg.SpotDlgMode := dmSellOff;
  FrmDlg.ShowShopSellDlg;
end;

procedure TfrmMain.ClientGetSendUserSell(merchant: Integer);
begin
  FrmDlg.CloseDSellDlg;
  g_nCurMerchant := merchant;
  FrmDlg.SpotDlgMode := dmSell;
  FrmDlg.ShowShopSellDlg;
end;

procedure TfrmMain.ClientGetSendUserRepair(merchant: Integer);
begin
  FrmDlg.CloseDSellDlg;
  g_nCurMerchant := merchant;
  FrmDlg.SpotDlgMode := dmRepair;
  FrmDlg.ShowShopSellDlg;
end;

procedure TfrmMain.ClientGetSendUserStorage(merchant: Integer);
begin
  FrmDlg.CloseDSellDlg;
  g_nCurMerchant := merchant;
  FrmDlg.SpotDlgMode := dmStorage;
  FrmDlg.ShowShopSellDlg;
end;

procedure TfrmMain.ClientGetRegInfo(DefMsg: pTDefaultMessage; body: string);
var
  nBuffer: Integer;
  sBuffer: string;
 // RegInfo: TRegInfo;
begin
  FillChar(g_Buffer^, 1024, #0);
  sBuffer := body;
  nBuffer := Length(sBuffer);
  Move(nBuffer, g_Buffer^, SizeOf(Integer));
  Move(sBuffer[1], g_Buffer[SizeOf(Integer)], nBuffer);

  SendClientMessage(CM_GETREGINFO_OK, 0, 0, 0, 0);

  {DecryptBuffer(sBuffer, @RegInfo, SizeOf(TRegInfo));
  if not RegInfo.boShare then begin

  end;}
end;

procedure TfrmMain.ClientGetSaveItemList(merchant, Page: Integer; bodystr: string);
var
  I: Integer;
  Data, sMsg: string;
  pc: PTClientItem;
  pcg: PTClientGoods;
  SaveItemList: TList;
begin
  if Page = 0 then begin
    FrmDlg.ResetMenuDlg;
    for I := 0 to g_SaveItemList.Count - 1 do begin
      Dispose(PTClientItem(g_SaveItemList[I]));
    end;
    g_SaveItemList.Clear;
  end;

  SaveItemList := TList.Create;

  sMsg := bodystr;
  while True do begin
    if sMsg = '' then Break;
    sMsg := GetValidStr3(sMsg, Data, ['/']);
    if Data <> '' then begin
      New(pc);
      DecodeBuffer(Data, @(pc^), SizeOf(TClientItem));
      SaveItemList.Add(pc);
    end else Break;
  end;

  g_nCurMerchant := merchant;
  with FrmDlg do begin
    //deocde body received from server
    for I := 0 to SaveItemList.Count - 1 do begin
      New(pcg);
      pcg.Name := PTClientItem(SaveItemList[I]).S.Name;
      pcg.SubMenu := 0;
      pcg.Price := PTClientItem(SaveItemList[I]).MakeIndex;
      pcg.Stock := Round(PTClientItem(SaveItemList[I]).Dura / 1000);
      pcg.Grade := Round(PTClientItem(SaveItemList[I]).DuraMax / 1000);
      MenuList.Add(pcg);
      g_SaveItemList.Add(SaveItemList[I]);
    end;
    if Page = 0 then begin
      FrmDlg.ShowShopMenuDlg;
      FrmDlg.BoStorageMenu := True;
    end;
  end;
  SaveItemList.Free;
end;

procedure TfrmMain.ClientGetSendDetailGoodsList(merchant, Count, topline: Integer; bodystr: string);
var
  I: Integer;
  body, Data, gname, gprice, gstock, ggrade, sMsg: string;
  pcg: PTClientGoods;
  pc: PTClientItem;
begin
  FrmDlg.ResetMenuDlg;

  g_nCurMerchant := merchant;

  sMsg := DecodeString(bodystr);
  while True do begin
    if sMsg = '' then Break;
    sMsg := GetValidStr3(sMsg, Data, ['/']);
    if Data <> '' then begin
      New(pc);
      DecodeBuffer(Data, @(pc^), SizeOf(TClientItem));
      g_MenuItemList.Add(pc);
    end else Break;
  end;

  with FrmDlg do begin
    //clear shop menu list
    for I := 0 to g_MenuItemList.Count - 1 do begin
      New(pcg);
      pcg.Name := PTClientItem(g_MenuItemList[I]).S.Name;
      pcg.SubMenu := 0;
      pcg.Price := PTClientItem(g_MenuItemList[I]).DuraMax;
      pcg.Stock := PTClientItem(g_MenuItemList[I]).MakeIndex;
      pcg.Grade := Round(PTClientItem(g_MenuItemList[I]).Dura / 1000);
      MenuList.Add(pcg);
    end;
    FrmDlg.ShowShopMenuDlg;
    FrmDlg.BoDetailMenu := True;
    FrmDlg.MenuTopLine := topline;
  end;
end;

procedure TfrmMain.ClientGetSendNotice(body: string);
var
  Data, msgstr, sMsg: string;
begin
  g_boDoFastFadeOut := False;
  msgstr := '';
  sMsg := DecodeString(body);
  while True do begin
    if sMsg = '' then Break;
    sMsg := GetValidStr3(sMsg, Data, [#27]);
    msgstr := msgstr + Data + '\';
  end;
  FrmDlg.DialogSize := 2;
  if FrmDlg.DMessageDlg(msgstr, [mbOk]) = mrOk then begin
    SendClientMessage(CM_LOGINNOTICEOK, GetTickCount, 0, 0, ClientType);
  end;
end;

procedure TfrmMain.ClientGetGroupMembers(bodystr: string);
var
  memb, sMsg: string;
begin
  g_GroupMembers.Clear;
  sMsg := bodystr;
  while True do begin
    if sMsg = '' then Break;
    sMsg := GetValidStr3(sMsg, memb, ['/']);
    if memb <> '' then
      g_GroupMembers.Add(memb)
    else Break;
  end;
end;

procedure TfrmMain.ClientGetOpenGuildDlg(bodystr: string);
var
  Str, Data, linestr, s1: string;
  pstep: Integer;
begin
  g_dwQueryMsgTick := GetTickCount;
  //if g_boShowMemoLog then PlayScene.MemoLog.Lines.Add('ClientGetOpenGuildDlg');
  Str := DecodeString(bodystr);
  Str := GetValidStr3(Str, FrmDlg.Guild, [#13]);
  Str := GetValidStr3(Str, FrmDlg.GuildFlag, [#13]);
  Str := GetValidStr3(Str, Data, [#13]);
  if Data = '1' then FrmDlg.GuildCommanderMode := True
  else FrmDlg.GuildCommanderMode := False;

  FrmDlg.GuildStrs.Clear;
  FrmDlg.GuildNotice.Clear;
  pstep := 0;
  while True do begin
    if Str = '' then Break;
    Str := GetValidStr3(Str, Data, [#13]);
    if Data = '<Notice>' then begin
      FrmDlg.GuildStrs.AddObject(Char(7) + '行会公告', TObject(clWhite));
      FrmDlg.GuildStrs.Add(' ');
      pstep := 1;
      Continue;
    end;
    if Data = '<KillGuilds>' then begin
      FrmDlg.GuildStrs.Add(' ');
      FrmDlg.GuildStrs.AddObject(Char(7) + '敌对行会', TObject(clWhite));
      FrmDlg.GuildStrs.Add(' ');
      pstep := 2;
      linestr := '';
      Continue;
    end;
    if Data = '<AllyGuilds>' then begin
      if linestr <> '' then FrmDlg.GuildStrs.Add(linestr);
      linestr := '';
      FrmDlg.GuildStrs.Add(' ');
      FrmDlg.GuildStrs.AddObject(Char(7) + '联盟行会', TObject(clWhite));
      FrmDlg.GuildStrs.Add(' ');
      pstep := 3;
      Continue;
    end;
    if pstep = 1 then
      FrmDlg.GuildNotice.Add(Data);

    if Data <> '' then begin
      if Data[1] = '<' then begin
        ArrestStringEx(Data, '<', '>', s1);
        if s1 <> '' then begin
          FrmDlg.GuildStrs.Add(' ');
          FrmDlg.GuildStrs.AddObject(Char(7) + s1, TObject(clWhite));
          FrmDlg.GuildStrs.Add(' ');
          Continue;
        end;
      end;
    end;
    if (pstep = 2) or (pstep = 3) then begin
      if Length(linestr) > 80 then begin
        FrmDlg.GuildStrs.Add(linestr);
        linestr := '';
      end else
        linestr := linestr + fmstr(Data, 18);
      Continue;
    end;

    FrmDlg.GuildStrs.Add(Data);
  end;
  if linestr <> '' then FrmDlg.GuildStrs.Add(linestr);
  FrmDlg.ShowGuildDlg;
end;

procedure TfrmMain.ClientGetSendGuildMemberList(body: string);
var
  Str, Data, rankname, members: string;
  rank: Integer;
begin
  g_dwQueryMsgTick := GetTickCount;
  Str := DecodeString(body);
  FrmDlg.GuildStrs.Clear;
  FrmDlg.GuildMembers.Clear;
  rank := 0;
  while True do begin
    if Str = '' then Break;
    Str := GetValidStr3(Str, Data, ['/']);
    if Data <> '' then begin
      if Data[1] = '#' then begin
        rank := Str_ToInt(Copy(Data, 2, Length(Data) - 1), 0);
        Continue;
      end;
      if Data[1] = '*' then begin
        if members <> '' then FrmDlg.GuildStrs.Add(members);
        rankname := Copy(Data, 2, Length(Data) - 1);
        members := '';
        FrmDlg.GuildStrs.Add(' ');
        if FrmDlg.GuildCommanderMode then
          FrmDlg.GuildStrs.AddObject(fmstr('(' + IntToStr(rank) + ')', 3) + '<' + rankname + '>', TObject(clWhite))
        else
          FrmDlg.GuildStrs.AddObject('<' + rankname + '>', TObject(clWhite));
        FrmDlg.GuildMembers.Add('#' + IntToStr(rank) + ' <' + rankname + '>');
        Continue;
      end;
      if Length(members) > 80 then begin
        FrmDlg.GuildStrs.Add(members);
        members := '';
      end;
      members := members + fmstr(Data, 18);
      FrmDlg.GuildMembers.Add(Data);
    end;
  end;
  if members <> '' then
    FrmDlg.GuildStrs.Add(members);
end;

procedure TfrmMain.MinTimerTimer(Sender: TObject);
var
  I: Integer;
  timertime: LongWord;
begin
  with PlayScene do
    if m_ActorList <> nil then begin
      for I := 0 to m_ActorList.Count - 1 do begin
        if IsGroupMember(TActor(m_ActorList[I]).m_sUserName) then begin
          TActor(m_ActorList[I]).m_boGrouped := True;
        end else TActor(m_ActorList[I]).m_boGrouped := False;
      end;
      //DScreen.AddChatBoardString('m_ActorList.Count:' + IntToStr(m_ActorList.Count), clyellow, clRed);
    end;
  if g_FreeActorList <> nil then begin
    for I := g_FreeActorList.Count - 1 downto 0 do begin
      if GetTickCount - TActor(g_FreeActorList[I]).m_dwDeleteTime > 1000 * 20 then begin
        TActor(g_FreeActorList[I]).Free;
        g_FreeActorList.Delete(I);
      end;
    end;
    //DScreen.AddChatBoardString('g_FreeActorList.Count:' + IntToStr(g_FreeActorList.Count), clyellow, clRed);
  end;
  FreeOldWMImagesLib();
end;

procedure TfrmMain.ClientGetDealRemoteAddItem(body: string);
var
  ci: TClientItem;
begin
  if body <> '' then begin
    DecodeBuffer(body, @ci, SizeOf(TClientItem));
    AddDealRemoteItem(ci);
  end;
end;

procedure TfrmMain.ClientGetDealRemoteDelItem(body: string);
var
  ci: TClientItem;
begin
  if body <> '' then begin
    DecodeBuffer(body, @ci, SizeOf(TClientItem));
    DelDealRemoteItem(ci);
  end;
end;

procedure TfrmMain.ClientGetReadMiniMap(mapindex: Integer);
begin
  g_dwQueryMsgTick := GetTickCount;
  if mapindex >= 1 then begin
    g_boViewMiniMap := True;
    g_nMiniMapIndex := mapindex - 1;
    FrmDlg.DMiniMap.Visible := g_boViewMiniMap;
    if not FrmDlg.DMiniMap.Visible then begin
      FrmDlg.DMiniMap.Width := FrmDlg.DMapTitle.Width;
      FrmDlg.DMiniMap.Height := 120;
    end;
    //DScreen.AddChatBoardString('g_nMiniMapIndex:' + IntToStr(g_nMiniMapIndex), clyellow, clRed);
  end;
end;

procedure TfrmMain.ClientGetChangeGuildName(body: string);
var
  Str, sMsg: string;
begin
  sMsg := body;
  Str := GetValidStr3(sMsg, g_sGuildName, ['/']);
  g_sGuildRankName := Trim(Str);
end;

procedure TfrmMain.ClientGetSendUserState(body: string);
var
  UserState: TUserStateInfo;
begin
  SafeFillChar(UserState, SizeOf(TUserStateInfo), #0);
  DecodeBuffer(body, @UserState, SizeOf(TUserStateInfo));
  UserState.NameColor := GetRGB(UserState.NameColor);
  FrmDlg.OpenUserState(UserState);
end;

procedure TfrmMain.DrawEffectHum(nType, nX, nY, nTarget: Integer);
var
  Effect: TMagicEff; //TNormalDrawEffect;
  n14: TNormalDrawEffect;
  bo15: Boolean;
begin
  Effect := nil;
  n14 := nil;
  //DScreen.AddChatBoardString('TfrmMain.DrawEffectHum:' + IntToStr(nType), clWhite, clRed);
  case nType of
    0: begin
      end;
    1: Effect := TNormalDrawEffect.Create(nX, nY, g_WMonImages.Indexs[14], 410, 6, 120, False);
    2: Effect := TNormalDrawEffect.Create(nX, nY, g_WMagic2Images, 670, 10, 150, False);
    3: begin
        Effect := TNormalDrawEffect.Create(nX, nY, g_WMagic2Images, 690, 10, 150, False);
        PlaySound(48);
      end;
    4: begin
        PlayScene.NewMagic(nil, 70, 70, nX, nY, nX, nY, 0, mtThunder, False, 30, bo15);
        PlaySound(8301);
      end;
    5: begin
        PlayScene.NewMagic(nil, 71, 71, nX, nY, nX, nY, 0, mtThunder, False, 30, bo15);
        PlayScene.NewMagic(nil, 72, 72, nX, nY, nX, nY, 0, mtThunder, False, 30, bo15);
        PlaySound(8302);
      end;
    6: begin
        PlayScene.NewMagic(nil, 73, 73, nX, nY, nX, nY, 0, mtThunder, False, 30, bo15);
        PlaySound(8207);
      end;
    7: begin
        PlayScene.NewMagic(nil, 74, 74, nX, nY, nX, nY, 0, mtThunder, False, 30, bo15);
        PlaySound(8226);
      end;
    8: begin
        Effect := TMapMagicEffect.Create(230, nX, nY, nil);
        Effect.ExplosionFrame := 6;
        Effect.ImgLib := g_WDragonImg;
        PlaySound(8301);
      end;
    9: begin
        Effect := TMapMagicEffect.Create(440, nX, nY, nil);
        Effect.ExplosionFrame := 20;
        Effect.ImgLib := g_WDragonImg;
        PlaySound(10011);
      end;
    10: begin
        Effect := TMapMagicEffect.Create(470, nX, nY, nil);
        Effect.ExplosionFrame := 10;
        Effect.ImgLib := g_WDragonImg;
        PlaySound(10011);
      end;
    11: begin
        Effect := TMapMagicEffect.Create(350, nX, nY, nil);
        Effect.ExplosionFrame := 35;
        Effect.ImgLib := g_WDragonImg;
        PlaySound(10011);
      end;
    12: begin //流星火雨
        PlayScene.NewMagic(nil, 75, 51, nX, nY, nX, nY, 0, mtExplosion, False, 30, bo15);
        PlaySound(10542);
      end;
    13: begin //灵魂火符
        PlayScene.NewMagic(nil, 75, 51, nX, nY, nX, nY, nTarget, mtFly, False, 30, bo15);
        PlaySound(10000 + 13 * 10 + 2);
      end;

    14: begin //破魂斩
        PlayScene.NewMagic(nil, 60, 60, nX, nY, nX, nY, nTarget, mtExplosion, False, 30, bo15);
        PlaySound(10512);
      end;

    15: begin //灵魂火符
        PlayScene.NewMagic(nil, 13, 10, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, nX, nY, nTarget, mtExploBujauk, False, 30, bo15);
        PlaySound(10000 + 13 * 10 + 2);
        //DScreen.AddChatBoardString('灵魂火符', clWhite, clRed);
      end;

   { 15: begin
        PlayScene.NewMagic(nil, 61, 61, nX, nY, nX, nY, 0, mtExplosion, FALSE, 30, bo15);
      end; }
    16: begin
        PlayScene.NewMagic(nil, 62, 62, nX, nY, nX, nY, 0, mtExplosion, False, 30, bo15);
      end;
    17: begin
        PlayScene.NewMagic(nil, 64, 64, nX, nY, nX, nY, 0, mtFly, False, 30, bo15);
      end;
    18: begin
        PlayScene.NewMagic(nil, 65, 65, nX, nY, nX, nY, 0, mtExplosion, False, 30, bo15);
      end;
    101: begin
        PlayScene.NewMagic(nil, 101, 101, nX, nY, nX, nY, 0, mtFly, False, 30, bo15);
      end;
    102: begin
        PlayScene.NewMagic(nil, 102, 102, nX, nY, nX, nY, 0, mtFly, False, 30, bo15);
      end;
  end;
  if Effect <> nil then begin
    Effect.MagOwner := g_MySelf;
    PlayScene.m_EffectList.Add(Effect);
  end;
  if n14 <> nil then begin
    Effect.MagOwner := g_MySelf;
    PlayScene.m_EffectList.Add(Effect);
  end;
end;

function IsDebugA(): Boolean;
var
  isDebuggerPresent: function: Boolean;
  DllModule: THandle;
begin
  DllModule := LoadLibrary('kernel32.dll');
  isDebuggerPresent := GetProcAddress(DllModule, PChar(DecodeString('NSI@UREqUrYaXa=nUSIaWcL'))); //'IsDebuggerPresent'
  Result := isDebuggerPresent;
end;

function IsDebug(): Boolean;
var
  isDebuggerPresent: function: Boolean;
  DllModule: THandle;
begin
  DllModule := LoadLibrary('kernel32.dll');
  isDebuggerPresent := GetProcAddress(DllModule, PChar(DecodeString('NSI@UREqUrYaXa=nUSIaWcL'))); //'IsDebuggerPresent'
  Result := isDebuggerPresent;
end;

//2004/05/17

procedure TfrmMain.SelectChr(sChrName: string);
begin
  PlayScene.EdChrNamet.Text := sChrName;
end;
//2004/05/17


procedure TfrmMain.ClientGetNeedPassword(body: string);
begin
  FrmDlg.DChgGamePwd.Visible := True;
end;

procedure TfrmMain.ClientGetPasswordStatus(DefMsg: pTDefaultMessage;
  body: string);
begin

end;

procedure TfrmMain.SendPassword(sPassword: string; nIdent: Integer);
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(CM_PASSWORD, 0, nIdent, 0, 0);
  SendSocket(EncodeMessage(DefMsg) + EncodeString(sPassword));
end;

procedure TfrmMain.SetInputStatus;
begin
  if m_boPasswordIntputStatus then begin
    m_boPasswordIntputStatus := False;
    FrmDlg.EdChat.PasswordChar := #0;
    FrmDlg.EdChat.Visible := False;
  end else begin
    m_boPasswordIntputStatus := True;
    FrmDlg.EdChat.PasswordChar := '*';
    FrmDlg.SetInputVisible(g_ConfigClient.btMainInterface = 1);
    FrmDlg.EdChat.Visible := True;
    FrmDlg.EdChat.SetFocus;
  end;
end;

procedure TfrmMain.ClientGetServerConfig(DefMsg: pTDefaultMessage; sBody: string);
begin
  DecodeBuffer(sBody, @g_ServerConfig, SizeOf(TServerConfig));
  if g_ServerConfig.nMaxLevel <= 0 then g_ServerConfig.nMaxLevel := High(Word);
end;

procedure TfrmMain.ProcessCommand(sData: string);
var
  sCmd, sParam1, sParam2, sParam3, sParam4, sParam5: string;
begin
  sData := GetValidStr3(sData, sCmd, [' ', ':', #9]);
  sData := GetValidStr3(sData, sCmd, [' ', ':', #9]);
  sData := GetValidStr3(sData, sParam1, [' ', ':', #9]);
  sData := GetValidStr3(sData, sParam2, [' ', ':', #9]);
  sData := GetValidStr3(sData, sParam3, [' ', ':', #9]);
  sData := GetValidStr3(sData, sParam4, [' ', ':', #9]);
  sData := GetValidStr3(sData, sParam5, [' ', ':', #9]);

  {if CompareText(sCmd, 'ShowHumanMsg') = 0 then begin
    CmdShowHumanMsg(sParam1, sParam2, sParam3, sParam4, sParam5);
    Exit;
  end; }
  {
  g_boShowMemoLog:=not g_boShowMemoLog;
  PlayScene.MemoLog.Clear;
  PlayScene.MemoLog.Visible:=g_boShowMemoLog;
  }
end;

procedure TfrmMain.CmdShowHumanMsg(sParam1, sParam2, sParam3, sParam4, sParam5: string);
var
  sHumanName: string;
begin
  sHumanName := sParam1;
  if (sHumanName <> '') and (sHumanName[1] = 'C') then begin
    PlayScene.MemoLog.Clear;
    Exit;
  end;
  if sHumanName <> '' then begin
    ShowMsgActor := PlayScene.FindActor(sHumanName);
    if ShowMsgActor = nil then begin
      DScreen.AddChatBoardString(Format('%s was not found', [sHumanName]), clWhite, clRed);
      Exit;
    end;
  end;
  g_boShowMemoLog := not g_boShowMemoLog;
  PlayScene.MemoLog.Clear;
  PlayScene.MemoLog.Visible := g_boShowMemoLog;
end;

procedure TfrmMain.ShowHumanMsg(DefMsg: pTDefaultMessage);
  function GetIdent(nIdent: Integer): string;
  begin
    case nIdent of
      SM_RUSH: Result := 'SM_RUSH';
      SM_RUSHKUNG: Result := 'SM_RUSHKUNG';
      SM_FIREHIT: Result := 'SM_FIREHIT';
      SM_BACKSTEP: Result := 'SM_BACKSTEP';
      SM_TURN: Result := 'SM_TURN';
      SM_WALK: Result := 'SM_WALK';
      SM_SITDOWN: Result := 'SM_SITDOWN';
      SM_RUN: Result := 'SM_RUN';
      SM_HIT: Result := 'SM_HIT';
      SM_HEAVYHIT: Result := 'SM_HEAVYHIT';
      SM_BIGHIT: Result := 'SM_BIGHIT';
      SM_SPELL: Result := 'SM_SPELL';
      SM_POWERHIT: Result := 'SM_POWERHIT';
      SM_LONGHIT: Result := 'SM_LONGHIT';
      SM_DIGUP: Result := 'SM_DIGUP';
      SM_DIGDOWN: Result := 'SM_DIGDOWN';
      SM_FLYAXE: Result := 'SM_FLYAXE';
      SM_LIGHTING: Result := 'SM_LIGHTING';
      SM_WIDEHIT: Result := 'SM_WIDEHIT';
      SM_ALIVE: Result := 'SM_ALIVE';
      SM_MOVEFAIL: Result := 'SM_MOVEFAIL';
      SM_HIDE: Result := 'SM_HIDE';
      SM_DISAPPEAR: Result := 'SM_DISAPPEAR';
      SM_STRUCK: Result := 'SM_STRUCK';
      SM_DEATH: Result := 'SM_DEATH';
      SM_SKELETON: Result := 'SM_SKELETON';
      SM_NOWDEATH: Result := 'SM_NOWDEATH';
      SM_CRSHIT: Result := 'SM_CRSHIT';
      SM_TWINHIT: Result := 'SM_TWINHIT';
      SM_HEAR: Result := 'SM_HEAR';
      SM_FEATURECHANGED: Result := 'SM_FEATURECHANGED';
      SM_USERNAME: Result := 'SM_USERNAME';
      SM_WINEXP: Result := 'SM_WINEXP';
      SM_LEVELUP: Result := 'SM_LEVELUP';
      SM_DAYCHANGING: Result := 'SM_DAYCHANGING';
      SM_ITEMSHOW: Result := 'SM_ITEMSHOW';
      SM_ITEMHIDE: Result := 'SM_ITEMHIDE';
      SM_MAGICFIRE: Result := 'SM_MAGICFIRE';
      SM_CHANGENAMECOLOR: Result := 'SM_CHANGENAMECOLOR';
      SM_CHARSTATUSCHANGED: Result := 'SM_CHARSTATUSCHANGED';

      SM_SPACEMOVE_HIDE: Result := 'SM_SPACEMOVE_HIDE';
      SM_SPACEMOVE_SHOW: Result := 'SM_SPACEMOVE_SHOW';
      SM_SHOWEVENT: Result := 'SM_SHOWEVENT';
      SM_HIDEEVENT: Result := 'SM_HIDEEVENT';
    else Result := IntToStr(nIdent);
    end;
  end;
var
  sLineText: string;
begin
  if (ShowMsgActor = nil) or (ShowMsgActor <> nil) and (ShowMsgActor.m_nRecogId = DefMsg.Recog) then
  begin
    sLineText := Format('ID:%d Ident:%s', [DefMsg.Recog, GetIdent(DefMsg.ident)]);
    PlayScene.MemoLog.Lines.Add(sLineText);
  end;
end;

procedure TfrmMain.HTTPGetStringDoneString(Sender: TObject;
  Result: string);
begin
  FrmDlg.ShowMDlg(g_nCurMerchantFace, g_sCurMerchantName, Result);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
  {procedure OpenHomePage();
  begin
    ShellExecute(0, PChar(DecryptString(g_s00001)), PChar(DecryptString(g_s00002)), PChar(DecryptString(g_sOpenHomePage)), nil, SW_SHOWNORMAL);
  end;}
type
  TOpen = procedure;
var
  nBuffer: Integer;
  sBuffer: string;
  RegInfo: TRegInfo;
  nProcedure: Integer;
begin
//{$I VMProtectBeginUltra.inc}
  Move(g_Buffer^, nBuffer, SizeOf(Integer));
  SetLength(sBuffer, nBuffer);
  Move(g_Buffer[SizeOf(Integer)], sBuffer[1], nBuffer);
  DecryptBuffer(sBuffer, @RegInfo, SizeOf(TRegInfo));
  nProcedure := RegInfo.nProcedure[0];
  {
  Showmessage('nProcedure:'+IntToStr(nProcedure));
  Showmessage('OpenHomePage:'+IntToStr(Integer(@OpenHomePage)));
  Showmessage('OpenHomePage1:'+IntToStr(Integer(@OpenHomePage1)));
  }
  //OpenHomePage;
  //OpenHomePage1;
  try
    TOpen(nProcedure);
  except
  end;
//{$I VMProtectEnd.inc}
end;

function DelFileExt(sName: string): string;
var
  nPos: Integer;
begin
  nPos := Pos('.', sName);
  if nPos > 0 then begin
    Result := Copy(sName, 1, nPos - 1);
  end else begin
    Result := sName;
  end;
end;

function FindProcesses(sName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  //sName := ChangeFileExt(ExtractFileName(sName), '');
  //sName := ExtractFileNameOnly(sName);
  sName := DelFileExt(sName);
  for I := 0 to g_ProcessesList.Count - 1 do begin
    if (Comparetext(sName, g_ProcessesList.Strings[I]) = 0) then begin
      Result := True;
      Break;
    end;
  end;
end;

function TfrmMain.GetProcesses: Boolean;
  function CheckModuleOwnerProcessID(ProcessID: DWORD): Boolean;
  var
    hSnap: THandle;
    ModuleEntry: TModuleEntry32;
    Proceed: Boolean;
  begin
    Result := False;
    hSnap := CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, ProcessID);
    if hSnap <> -1 then
    begin
      ModuleEntry.dwSize := SizeOf(TModuleEntry32);
      Proceed := Module32First(hSnap, ModuleEntry);
      while Proceed do begin
        with ModuleEntry do
          if th32ProcessID <> ProcessID then begin
            Result := True;
            Break;
          end;
        Proceed := Module32Next(hSnap, ModuleEntry);
      end;
      CloseHandle(hSnap);
    end;
  end;

  function CheckThreadOwnerProcessID(ProcessID: DWORD): Boolean;
  var
    hSnap: THandle;
    ThreadEntry: TThreadEntry32;
    Proceed: Boolean;
  begin
    Result := False;
    hSnap := CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, ProcessID);
    if hSnap <> -1 then
    begin
      ThreadEntry.dwSize := SizeOf(TThreadEntry32);
      Proceed := Thread32First(hSnap, ThreadEntry);
      while Proceed do begin
        with ThreadEntry do
          if th32OwnerProcessID <> ProcessID then begin
            Result := True;
            Break;
          end;
        Proceed := Thread32Next(hSnap, ThreadEntry);
      end;
      CloseHandle(hSnap);
    end;
  end;

var
  hSnap: THandle;
  ProcessEntry: TProcessEntry32;
  Proceed: Boolean;
begin
  Result := False;
  hSnap := CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0); //创建系统快照
  if hSnap <> -1 then
  begin
    ProcessEntry.dwSize := SizeOf(TProcessEntry32); //先初始化 FProcessEntry32 的大小
    Proceed := Process32First(hSnap, ProcessEntry);
    while Proceed do
    begin
      with ProcessEntry do
        if FindProcesses(StrPas(szEXEFile)) then begin
        //if (CompareText(StrPas(szEXEFile), 'JS.UCU') = 0) then begin
          //CloseProcess(Th32ProcessID);
          Result := True;
          Break;
        end else begin
          if GetModules(Th32ProcessID) then begin
            Result := True;
            Break;
          end;
        end;
       { with listview_pro.Items.Add do
        begin
          Caption := szEXEFile;
          subitems.Add(IntToStr(Th32ProcessID));
          subitems.Add(IntToStr(th32ParentProcessID));
          subitems.Add(IntToStr(Th32ModuleID));
          subitems.Add(IntToStr(cntUsage));
          subitems.Add(IntToStr(cntThreads));
          subitems.Add(IntToStr(pcPriClassBase));
        end; }
      Proceed := Process32Next(hSnap, ProcessEntry);
    end;
    CloseHandle(hSnap);
  end;
  //if not Result then
    //Result := CheckModuleOwnerProcessID(g_nSelfThreadProcessId) {or CheckThreadOwnerProcessID(g_nSelfThreadProcessId)};
end;

function TfrmMain.GetModules(ProcessID: DWORD): Boolean;
var hSnap: THandle;
  ModuleEntry: TModuleEntry32;
  Proceed: Boolean;
begin
  Result := False;
  hSnap := CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, ProcessID);
  if hSnap <> -1 then
  begin
    ModuleEntry.dwSize := SizeOf(TModuleEntry32);
    Proceed := Module32First(hSnap, ModuleEntry);
    while Proceed do
    begin
      with ModuleEntry do
        if FindProcesses(StrPas(szModule)) then begin
        //if (CompareText(szModule, 'WINIO.DLL') = 0) or (CompareText(szModule, 'JSHJ.DLL') = 0) then begin
          //CloseProcess(ProcessID);
          Result := True;
          Break;
        end;
        {with listview_mod.Items.Add do
        begin
          Caption := szModule;
          subitems.Add(ExtractFilePath(szEXEPath));
          subitems.Add(IntToStr(Th32ModuleID));
          subitems.Add(FloatToStr(ModBaseSize / 1024));
          subitems.Add(IntToStr(GlblCntUsage));
        end; }
      Proceed := Module32Next(hSnap, ModuleEntry);
    end;
    CloseHandle(hSnap);
  end;
     {else
     ShowMessage( 'Oops...' + SysErrorMessage(GetLastError));  }
end;

procedure TfrmMain.CloseProcess(ProcessID: Integer);
var
  ProcessHndle: THandle; UExitCode: Byte;
begin
  ProcessHndle := OpenProcess(PROCESS_TERMINATE, False, ProcessID);
  TerminateProcess(ProcessHndle, UExitCode);
  CloseHandle(ProcessHndle);
end;

procedure TfrmMain.SpeedHackTimerTimer(Sender: TObject);
var
  gcount, timer: LongWord;
  ahour, amin, asec, amsec: Word;
begin
  {if not g_ClientConfig.boCheckSpeedHack then begin
    g_nSHFakeCount := 0;
    Exit;
  end;}
   {
  if g_dwLastSpeedHackTick = 0 then begin
    g_dwLastSpeedHackTick := GetTickCount;
  end else begin
    DebugOutStr('GetTickCount:' + IntToStr(GetTickCount - g_dwLastSpeedHackTick));
    if (GetTickCount - g_dwLastSpeedHackTick < 1000) or (GetTickCount - g_dwLastSpeedHackTick > 1000) then begin
      Inc(g_nSpeedHackCount)
    end else begin
      if g_nSpeedHackCount > 0 then Dec(g_nSpeedHackCount) else
      g_nSpeedHackCount := 0;
    end;
    g_dwLastSpeedHackTick := GetTickCount;
  end;

  if g_nSpeedHackCount > 4 then begin
    FrmDlg.DMessageDlg('速度异常，游戏已被中止。 \' +
      '如有问题请联系游戏管理员。',
      [mbOk]);
    frmMain.Close;
    Exit;
  end;
       }

  if GetTickCount - g_dwGetProcessesTick > 1000 * 10 then begin
    g_dwGetProcessesTick := GetTickCount;
    if GetProcesses then begin
      CSocket.Active := False;
      SpeedHackTimer.Enabled := False;
      FrmDlg.DMessageDlg('(0)速度异常，游戏已被中止。 \' +
        '如有问题请联系游戏管理员。',
        [mbOk]);
      //frmMain.Close;
      Exit;
    end;
  end;

  //DebugOutStr('GetTickCount:'+IntToStr(GetTickCount));
  DecodeTime(Time, ahour, amin, asec, amsec);
  timer := ahour * 1000 * 60 * 60 + amin * 1000 * 60 + asec * 1000 + amsec;
  gcount := GetTickCount;
  if g_dwSHGetTime > 0 then begin
    //DScreen.AddChatBoardString(Format('timer:%d', [abs((gcount - g_dwSHGetTime) - (timer - g_dwSHTimerTime))]), clRed, clWhite);
    if abs((gcount - g_dwSHGetTime) - (timer - g_dwSHTimerTime)) > 50 then begin
      Inc(g_nSHFakeCount);
    end else
      g_nSHFakeCount := 0;
    if g_nSHFakeCount > 4 then begin
      CSocket.Active := False;
      SpeedHackTimer.Enabled := False;
      FrmDlg.DMessageDlg('(1)速度异常，游戏已被中止。 \' +
        '如有问题请联系游戏管理员。',
        [mbOk]);
      //frmMain.Close;
    end;
    if g_boCheckSpeedHackDisplay then begin
         {DScreen.AddSysMsg ('->' + IntToStr(gcount - g_dwSHGetTime) + ' - ' +
                                   IntToStr(timer - g_dwSHTimerTime) + ' = ' +
                                   IntToStr(abs((gcount - g_dwSHGetTime) - (timer - g_dwSHTimerTime))) + ' (' +
                                   IntToStr(g_nSHFakeCount) + ')'); }
    end;
  end;
  g_dwSHGetTime := gcount;
  g_dwSHTimerTime := timer;
end;

procedure TfrmMain.CheckSpeedHack(rtime: LongWord);
var
  nServer_ClientTime, nServer_Client: Integer;
  //nIndex, nServer_ClientTime: Integer;
begin
  //DScreen.AddChatBoardString(Format('rtime:%d', [rtime]), clRed, clWhite);
  if rtime > 0 then begin
    if g_nServer_ClientTime > 0 then begin

      nServer_ClientTime := abs(rtime - GetTickCount);

      {g_ClientSpeedTime.Add(IntToStr(nServer_ClientTime));

      if g_ClientSpeedTime.Count > 10 then begin
        g_ClientSpeedTime.NumberSort(True);
        g_nTimeFakeDetectCount := 0;
        g_nServer_ClientTime := StrToInt(g_ClientSpeedTime.Strings[5]);
        g_ClientSpeedTime.Clear;
        Exit;
      end;}

      nServer_ClientTime := abs(g_nServer_ClientTime - nServer_ClientTime);
      //DScreen.AddChatBoardString(Format('nServer_ClientTime0:%d', [nServer_ClientTime]), clRed, clWhite);

      if nServer_ClientTime > 1500 then begin
        Inc(g_nTimeFakeDetectCount);
        //DScreen.AddChatBoardString(Format('abs(g_nServer_ClientTime - nServer_ClientTime)1:%d', [abs(g_nServer_ClientTime - nServer_ClientTime)]), clRed, clWhite);
      end else begin
        g_nTimeFakeDetectCount := 0;
        //DScreen.AddChatBoardString(Format('abs(g_nServer_ClientTime - nServer_ClientTime)2:%d', [abs(g_nServer_ClientTime - nServer_ClientTime)]), clRed, clWhite);
      end;
      if g_nTimeFakeDetectCount > 4 then begin
        CSocket.Active := False;
        SpeedHackTimer.Enabled := False;
        FrmDlg.DMessageDlg('(2)速度异常，游戏已被中止。 \' +
          '如有问题请联系游戏管理员。',
          [mbOk]);
      //frmMain.Close;
      end;
    end else begin
      g_nTimeFakeDetectCount := 0;
      g_nServer_ClientTime := abs(rtime - GetTickCount);
      //g_ClientSpeedTime.Add(IntToStr(g_nServer_ClientTime));
      //DScreen.AddChatBoardString(Format('g_nServer_ClientTime:%d Server:%d Client:%d', [g_nServer_ClientTime, rtime , GetTickCount]), clRed, clWhite);
    end;
    //DScreen.AddChatBoardString(Format('g_nServer_ClientTime:%d', [g_nServer_ClientTime]), clRed, clWhite);
  end;
end;

(*var
  cltime, svtime: Integer;
  Str: string;
begin
  if g_dwFirstServerTime > 0 then begin
    if (GetTickCount - g_dwFirstClientTime) > 1 * 60 * 60 * 1000 then begin
      g_dwFirstServerTime := rtime;
      g_dwFirstClientTime := GetTickCount;
         //ServerTimeGap := rtime - int64(GetTickCount);
    end;
    cltime := GetTickCount - g_dwFirstClientTime;
    svtime := rtime - g_dwFirstServerTime + 3000;

    if cltime > svtime then begin
      Inc(g_nTimeFakeDetectCount);
      if g_nTimeFakeDetectCount > 6 then begin
        Str := 'Bad';
            //SendSpeedHackUser;
        SpeedHackTimer.Enabled := False;
        CSocket.Active := False;
        FrmDlg.DMessageDlg('系统不稳定或网络状态极差，游戏被中止\' +
          '如有问题请联系游戏管理员。',
          [mbOk]);
        frmMain.Close;
      end;
    end else begin
      Str := 'Good';
      g_nTimeFakeDetectCount := 0;
    end;
    if g_boCheckSpeedHackDisplay then begin
       {  DScreen.AddSysMsg (IntToStr(svtime) + ' - ' +
                            IntToStr(cltime) + ' = ' +
                            IntToStr(svtime-cltime) +
                            ' ' + str);  }
    end;
  end else begin
    g_dwFirstServerTime := rtime;
    g_dwFirstClientTime := GetTickCount;
      //ServerTimeGap := int64(GetTickCount) - longword(msg.Recog);
  end;
end;*)

procedure TfrmMain.DXDrawFinalize(Sender: TObject);
begin
  if g_boClose then Exit;
  g_boCanDraw := False;
  if Assigned(g_PlugInfo.HookFinalize) then begin
    g_PlugInfo.HookFinalize();
  end;
end;

procedure TfrmMain.FontChange(Sender: TObject);
begin
  //DWinMan.SetCanvas(DXDraw.Surface.Canvas);
end;

procedure LoadConfig();
var
  I: Integer;
  MemoryStream: TMemoryStream;
  ClientOption: TClientOption;
  ConfigClient: TConfigClient;
  nSize: PInteger;
  nCrc: PInteger;
  Buffer: Pointer;
  sBuffer: string;
  nBuffer: Integer;
  nLen: Integer;
  nConfigClient: Integer;
  nClientOption: Integer;

  InBuf: Pointer;
  InBytes: Integer;
  OutBuf: Pointer;
  OutBytes: Integer;

  sFileName: string;

  SaveList: TStringList;
  DIB: TDIB;
begin
  g_MemoryStream := TMemoryStream.Create;
  g_MemoryStream.LoadFromFile(Application.ExeName);
{-------------------------------------------------------------------------------}
  nConfigClient := Length(EncryptBuffer(@ConfigClient, SizeOf(TConfigClient)));
  g_MemoryStream.Seek(-nConfigClient, soFromEnd);
  SetLength(sBuffer, nConfigClient);
  g_MemoryStream.Read(sBuffer[1], nConfigClient);
  DecryptBuffer(sBuffer, @g_ConfigClient, SizeOf(TConfigClient));
{-------------------------------------------------------------------------------}
  nClientOption := Length(EncryptBuffer(@ClientOption, SizeOf(TClientOption)));
  nLen := nConfigClient + nClientOption + g_ConfigClient.nDataSize + g_ConfigClient.nBackBmpSize + g_ConfigClient.nBindItemSize + g_ConfigClient.nShowItemSize + g_ConfigClient.nItemDescSize;
  GetMem(g_ConfigBuffer, nClientOption + SizeOf(Integer));
  Move(nClientOption, g_ConfigBuffer^, SizeOf(Integer));
  g_MemoryStream.Seek(-nLen, soFromEnd);
  g_MemoryStream.Read(g_ConfigBuffer[SizeOf(Integer)], nClientOption);
{-------------------------------------------------------------------------------}
  g_MemoryStream.Seek(0, soFromBeginning);
  SetLength(sBuffer, nClientOption);
  Move(g_ConfigBuffer[SizeOf(Integer)], sBuffer[1], nClientOption);
  DecryptBuffer(sBuffer, @ClientOption, SizeOf(TClientOption));
{-------------------------------------------------------------------------------}
  InBytes := ClientOption.nSize;
  g_MemoryStream.Seek(0, soFromBeginning);
  InBuf := g_MemoryStream.Memory;
  if (BufferCRC(InBuf, InBytes) = ClientOption.nCrc) then begin
{-------------------------------------------------------------------------------}
    InBytes := g_ConfigClient.nSize;
    g_MemoryStream.Seek(0, soFromBeginning);
    InBuf := g_MemoryStream.Memory;

    if (BufferCRC(InBuf, InBytes) = g_ConfigClient.nCrc) then begin
      for I := 0 to 9 do begin
        if g_ConfigClient.PlugArr[I] <> '' then begin
          PlugInManage.PlugFileList.Add(g_ConfigClient.PlugArr[I]);
        end;
      end;

{-------------------------------------------------------------------------------}
      if g_ConfigClient.nDataSize > 0 then begin
        InBytes := g_ConfigClient.nDataSize;
        GetMem(InBuf, InBytes);
        try
          g_MemoryStream.Seek(g_ConfigClient.nDataOffSet, soFromBeginning);
          g_MemoryStream.Read(InBuf^, InBytes);
          DecompressBuf(InBuf, InBytes, 0, OutBuf, OutBytes);
        finally
          FreeMem(InBuf);
        end;
        if OutBytes > 0 then begin
          sFileName := ExtractFilePath(Application.ExeName) + 'Data\F-Cqfir.Data';
          FileSetAttr(sFileName, 0);
          MemoryStream := TMemoryStream.Create;
          MemoryStream.Write(OutBuf^, OutBytes);
          try
            MemoryStream.SaveToFile(sFileName);
          except

          end;
          FreeMem(OutBuf);
          MemoryStream.Free;
        end;
      end;
{-------------------------------------------------------------------------------}
      //sFileName := ExtractFilePath(Application.ExeName) + 'Data\ui\cqfir.uib';
      //FileSetAttr(sFileName, 0);
      //DeleteFile(sFileName);
      if g_ConfigClient.nBackBmpSize > 0 then begin
        InBytes := g_ConfigClient.nBackBmpSize;
        GetMem(InBuf, InBytes);
        try
          g_MemoryStream.Seek(g_ConfigClient.nBackBmpOffSet, soFromBeginning);
          g_MemoryStream.Read(InBuf^, InBytes);
          DecompressBuf(InBuf, InBytes, 0, OutBuf, OutBytes);
        finally
          FreeMem(InBuf);
        end;
        if OutBytes > 0 then begin
          MemoryStream := TMemoryStream.Create;
          MemoryStream.Write(OutBuf^, OutBytes);
          MemoryStream.Position := 0;
          DIB := TDIB.Create;
          DIB.LoadFromStream(MemoryStream);
          g_BackSurface.LoadFromDIB(DIB);
          MemoryStream.Free;
          DIB.Free;
          FreeMem(OutBuf);
        end;
      end;
{-------------------------------------------------------------------------------}
      if g_ConfigClient.nBindItemSize > 0 then begin
        InBytes := g_ConfigClient.nBindItemSize;
        GetMem(InBuf, InBytes);
        try
          g_MemoryStream.Seek(g_ConfigClient.nBindItemOffSet, soFromBeginning);
          g_MemoryStream.Read(InBuf^, InBytes);
          DecompressBuf(InBuf, InBytes, 0, OutBuf, OutBytes);
        finally
          FreeMem(InBuf);
        end;
        if OutBytes > 0 then begin
          SetLength(sBuffer, OutBytes);
          Move(OutBuf^, sBuffer[1], OutBytes);
          g_UnbindItemFileList.Text := sBuffer;
          //g_UnbindItemFileList.SaveToFile('g_UnbindItemFileList.txt');
          FreeMem(OutBuf);
          LoadBindItemList;
        end;
      end;

{-------------------------------------------------------------------------------}
      if g_ConfigClient.nShowItemSize > 0 then begin
        InBytes := g_ConfigClient.nShowItemSize;
        GetMem(InBuf, InBytes);
        try
          g_MemoryStream.Seek(g_ConfigClient.nShowItemOffSet, soFromBeginning);
          g_MemoryStream.Read(InBuf^, InBytes);
          DecompressBuf(InBuf, InBytes, 0, OutBuf, OutBytes);
        finally
          FreeMem(InBuf);
        end;
        if OutBytes > 0 then begin
          SetLength(sBuffer, OutBytes);
          Move(OutBuf^, sBuffer[1], OutBytes);
          g_ShowItemFileList.Text := sBuffer;
          //g_ShowItemFileList.SaveToFile('g_ShowItemFileList.txt');
          FreeMem(OutBuf);
          g_ShowItemList.LoadFormList(g_ShowItemFileList);
        end;
      end;
{-------------------------------------------------------------------------------}
      if g_ConfigClient.nItemDescSize > 0 then begin
        InBytes := g_ConfigClient.nItemDescSize;
        GetMem(InBuf, InBytes);
        try
          g_MemoryStream.Seek(g_ConfigClient.nItemDescOffSet, soFromBeginning);
          g_MemoryStream.Read(InBuf^, InBytes);
          DecompressBuf(InBuf, InBytes, 0, OutBuf, OutBytes);
        finally
          FreeMem(InBuf);
        end;

        if OutBytes > 0 then begin
          sFileName := ExtractFilePath(Application.ExeName) + ITEMDESCFILE;
          SaveList := TStringList.Create;
          SetLength(sBuffer, OutBytes);
          Move(OutBuf^, sBuffer[1], OutBytes);
          SaveList.Text := sBuffer;
          FileSetAttr(sFileName, 0);
          try
            SaveList.SaveToFile(sFileName);
          except
          end;
          SaveList.Free;
          FreeMem(OutBuf);

          LoadItemDescList;
        end;
      end;
    end else begin
      //DebugOutStr(Format('Application.Terminate1 BufferCRC:%d g_ConfigClient.nCrc:%d', [BufferCRC(InBuf, InBytes), g_ConfigClient.nCrc]));
      //Showmessage('1');
      Application.Terminate;
    end;
  end else begin
    //Showmessage('2');
    //DebugOutStr(Format('Application.Terminate2 BufferCRC:%d ClientOption.nCrc:%d g_MemoryStream.Size:%d ClientOption.nSize:%d', [g_MemoryStream.Size,  ClientOption.nSize, BufferCRC(InBuf, InBytes), ClientOption.nCrc]));
    Application.Terminate;
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  I: Integer;
  ini: TIniFile;
  Msg: pTProcessMessage;
begin
  g_boClose := True;
  ActiveControl := nil;
  //Dispose(g_PlugInfo);
  ini := TIniFile.Create('.\mir.ini');
  if ini <> nil then begin
    ini.WriteString('Client Options', 'FontName', g_sCurFontName);
    ini.WriteBool('Client Options', 'FullScreen', g_boFullScreen);
    ini.WriteString('Client Options', 'ServerIP', g_sServerAddr);
    ini.WriteInteger('Client Options', 'ServerPort', g_nServerPort);
    ini.WriteInteger('Client Options', 'ScreenWidth', SCREENWIDTH);
    ini.WriteInteger('Client Options', 'ScreenHeight', SCREENHEIGHT);

    ini.WriteInteger('Client Setup', 'LineColor', g_btFColor);
    ini.WriteInteger('Client Setup', 'RectangleColor', g_btBColor);
    ini.WriteInteger('Client Setup', 'BlendAlpha', g_btAlpha);
    ini.Free;
  end;

  MouseTimer.Enabled := False;

  UnhookWindowsHookEx(g_ToolMenuHook);

  TimerRun.Enabled := False;
  MinTimer.Enabled := False;

  UnLoadWMImagesLib();

  for I := 0 to NpcImageList.Count - 1 do begin
    TGameImages(NpcImageList.Items[I]).Free;
  end;
  for I := 0 to ItemImageList.Count - 1 do begin
    TGameImages(ItemImageList.Items[I]).Free;
  end;
  for I := 0 to WeaponImageList.Count - 1 do begin
    TGameImages(WeaponImageList.Items[I]).Free;
  end;
  for I := 0 to HumImageList.Count - 1 do begin
    TGameImages(HumImageList.Items[I]).Free;
  end;

  for I := 0 to m_MsgList.Count - 1 do begin
    Msg := m_MsgList.Items[I];
    Dispose(Msg);
  end;
  m_MsgList.Free;


  DScreen.Finalize;
  PlayScene.Finalize;
  SoundEngine.Terminate;
  LoginNoticeScene.Finalize;

  DScreen.Free;

  IntroScene.Free;

  LoginScene.Free;
  SelectChrScene.Free;

  PlayScene.Free;


  LoginNoticeScene.Free;
  g_SaveItemList.Free;
  g_MenuItemList.Free;

  g_GuaJi.Free;
  LegendMap.Free;
  g_MapDesc.Free;
  Map.Free;
  g_DropedItemList.Free;

  g_MediaList.Free;
  for I := 0 to g_MagicList.Count - 1 do begin
    Dispose(PTClientMagic(g_MagicList[I]));
  end;
  for I := 0 to g_HeroMagicList.Count - 1 do begin
    Dispose(PTClientMagic(g_HeroMagicList[I]));
  end;
  for I := 0 to g_SerieMagicList.Count - 1 do begin //连击
    Dispose(PTClientMagic(g_SerieMagicList[I]));
  end;
  for I := 0 to g_FreeActorList.Count - 1 do begin
    TActor(g_FreeActorList[I]).Free;
  end;

  g_MagicList.Free;

  g_HeroMagicList.Free;
  g_FreeActorList.Free;
  g_ChangeFaceReadyList.Free;

  g_ServerList.Free;

  g_SerieMagicList.Free;
  g_SerieMagicingList.Free;

  //if MainSurface <> nil then MainSurface.Free;

  g_ProcessesList.Free;

  g_SoundList.Free;
  BGMusicList.Free;
  //DObjList.Free;
  EventMan.Free;
  NpcImageList.Free;
  ItemImageList.Free;
  WeaponImageList.Free;
  HumImageList.Free;
  g_HintList.Free;
  g_ImgMixSurface.Free;
  g_MiniMapSurface.Free;
  g_RandomSurface.Free;

  //g_ShowFormList.Free;

  g_UnbindItemFileList.Free;
  g_ShowItemFileList.Free;
  g_ShowItemList.Free;
  g_BackSurface.Free;

{  for I := 0 to Length(g_BackSurfaces) - 1 do begin
    g_BackSurfaces[I].Free;
  end; }

  UnLoadBindItemList;

  UnLoadItemDescList;

  UnLoadCartInfoList;
  g_CartInfoList.Free;

  Dispose(g_dwOpenHomePageTick);

  if g_Buffer <> nil then begin
    FreeMem(g_Buffer);
    g_Buffer := nil;
  end;
  if g_ConfigBuffer <> nil then begin
    FreeMem(g_ConfigBuffer);
    g_ConfigBuffer := nil;
  end;

  if g_MemoryStream <> nil then
    g_MemoryStream.Free;

 // try
  PlugInManage.Free;
 { except
    Application.Terminate;
  end; }
  DebugOutStr('----------------------- closed -------------------------');
end;

procedure TfrmMain.HTTPGetCheckProDoneString(Sender: TObject;
  Result: string);
var
  I: Integer;
begin
  g_ProcessesList.Text := Result;
  for I := 0 to g_ProcessesList.Count - 1 do begin
    g_ProcessesList.Strings[I] := DelFileExt(Trim(g_ProcessesList.Strings[I]));
  end;
  //g_ProcessesList.SaveToFile('2ProcessesList.txt');
end;

procedure TfrmMain.FindPathTimerTimer(Sender: TObject);
var
  I, tdir, dx, dy, nIndex: Integer;
  pt: TPoint;
begin
  if g_MySelf = nil then begin
    LegendMap.Stop;
    Exit;
  end;

  if (g_MySelf <> nil) and g_MySelf.m_boDeath then begin
    LegendMap.Stop;
    Exit;
  end;

  if (LegendMap.EndX > 0) and (LegendMap.EndY > 0) then begin
    if (abs(g_MySelf.m_nCurrX - LegendMap.EndX) <= 1) and (abs(g_MySelf.m_nCurrY - LegendMap.EndY) <= 1) then begin
      DScreen.AddChatBoardString(Format('You have reached the location at (%d:%d).', [LegendMap.EndX, LegendMap.EndY]), GetRGB(154), clWhite);
      LegendMap.Stop;
    end else begin
      if GetTickCount - g_dwAutoFindPathTick > 200 then begin
        g_dwAutoFindPathTick := GetTickCount;

        if LegendMap.StartFind then Exit;

        if (Length(LegendMap.RunPath) <= 0) and (not LegendMap.StartFind) and (LegendMap.FindCount = 0) then begin
          LegendMap.Find(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, LegendMap.EndX, LegendMap.EndY);
          Exit;
        end;

        if LegendMap.StartFind then Exit;

        if Length(LegendMap.RunPath) <= 0 then begin
          DScreen.AddChatBoardString(Format('Unable to reach location at (%d:%d)', [LegendMap.EndX, LegendMap.EndY]), GetRGB(154), clWhite);
          LegendMap.Stop;
        end else begin
          if (LegendMap.PathPositionIndex >= 0) and (LegendMap.PathPositionIndex < Length(LegendMap.RunPath)) then begin
            if g_nAutoWalkX < 0 then begin
              g_nAutoWalkX := g_MySelf.m_nCurrX;
              g_nAutoWalkY := g_MySelf.m_nCurrY;
            end;

            if (g_MySelf.m_nCurrX = g_nAutoWalkX) and (g_MySelf.m_nCurrY = g_nAutoWalkY) then begin
              g_dwAutoWalkTick := GetTickCount;
              g_nAutoWalkErrorCount := 0;
              pt := LegendMap.RunPath[LegendMap.PathPositionIndex];
              LegendMap.PathPositionIndex := LegendMap.PathPositionIndex + 1;
              g_nTargetX := pt.X;
              g_nTargetY := pt.Y;
              g_nAutoWalkX := pt.X;
              g_nAutoWalkY := pt.Y;

              if (abs(g_MySelf.m_nCurrX - pt.X) <= 1) and (abs(g_MySelf.m_nCurrY - pt.Y) <= 1) then begin
                //if PlayScene.CanWalk(pt.X, pt.Y) then begin
                g_ChrAction := caWalk;
                //DScreen.AddChatBoardString(Format('Walk (%d:%d) (%d:%d) Step:%d', [g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nAutoWalkX, g_nAutoWalkY, Length(LegendMap.RunPath)]), GetRGB(154), clWhite);
                {end else begin
                  g_nAutoWalkX := -1;
                  g_nAutoWalkY := -1;
                  DScreen.AddChatBoardString('not CanWalk', GetRGB(154), clWhite);
                  LegendMap.Find(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, LegendMap.EndX, LegendMap.EndY);
                  LegendMap.PathPositionIndex := 0;
                end;}
              end else begin
                //if PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, pt.X, pt.Y) then begin
                g_ChrAction := caRun;
                //DScreen.AddChatBoardString(Format('Run (%d:%d) (%d:%d) Step:%d', [g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nAutoWalkX, g_nAutoWalkY, Length(LegendMap.RunPath)]), GetRGB(154), clWhite);
                {end else begin
                  g_nAutoWalkX := -1;
                  g_nAutoWalkY := -1;
                  DScreen.AddChatBoardString('not CanRun', GetRGB(154), clWhite);
                  LegendMap.Find(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, LegendMap.EndX, LegendMap.EndY);
                  LegendMap.PathPositionIndex := 0;
                end; }
              end;
            end else begin
              g_nTargetX := g_nAutoWalkX;
              g_nTargetY := g_nAutoWalkY;
              if GetTickCount - g_dwAutoWalkTick > 2000 then begin
                g_dwAutoWalkTick := GetTickCount;
               { if g_ChrAction= caRun then
                DScreen.AddChatBoardString(Format('Run Fail (%d:%d) (%d:%d) Step:%d', [g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nAutoWalkX, g_nAutoWalkY, Length(LegendMap.RunPath)]), GetRGB(154), clWhite);
                if g_ChrAction= caWalk then
                DScreen.AddChatBoardString(Format('Walk Fail (%d:%d) (%d:%d) Step:%d', [g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nAutoWalkX, g_nAutoWalkY, Length(LegendMap.RunPath)]), GetRGB(154), clWhite);
                }
                g_nAutoWalkX := -1;
                g_nAutoWalkY := -1;
                Inc(g_nAutoWalkErrorCount);
                if g_nAutoWalkErrorCount < 3 then begin
                  LegendMap.Find(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, LegendMap.EndX, LegendMap.EndY);
                  LegendMap.PathPositionIndex := 0;
                end else begin
                  DScreen.AddChatBoardString(Format('Unable to reach location at (%d:%d)', [LegendMap.EndX, LegendMap.EndY]), GetRGB(154), clWhite);
                  LegendMap.Stop;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  DWinMan.MouseWheelDown(Shift, MousePos);

end;

procedure TfrmMain.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  DWinMan.MouseWheelUp(Shift, MousePos);
end;
//==============================================================================

procedure TfrmMain.AutoOrderItem; //自动放药
var
  I, II, nIndex: Integer;
  StdItem: TStdItem;
  boFind: Boolean;
  btBindItemType: Byte;
  sName: string;
  sBindItemName: string;
begin
  if (g_EatingItem.S.Name = '') and
    (g_WaitingUseItem.Item.S.Name = '') then begin
    if {(g_MovingItem.Item.s.Name <> '')}  g_boItemMoving and (g_MovingItem.Owner = FrmDlg.DItemBag) and (GetTickCount - g_dwMoveItemTick > 100) then begin
      for I := Low(g_OldItemArr) to High(g_OldItemArr) do begin
        if (g_ItemArr[I].S.Name <> g_OldItemArr[I].S.Name) then begin
          g_OldItemArr[I] := g_ItemArr[I];
        end;
      end;
      Exit;
    end;

    if (GetTickCount - g_dwAutoOrderItemTick > 500) { and (GetTickCount - g_dwMoveItemTick > 100) } and not g_boItemMoving then begin
      g_dwAutoOrderItemTick := GetTickCount;
      for I := Low(g_OldItemArr) to High(g_OldItemArr) do begin
        if g_ItemArr[I].S.Name <> '' then begin
          if (g_ItemArr[I].S.Name <> g_OldItemArr[I].S.Name) then begin
            g_OldItemArr[I] := g_ItemArr[I];
          end;
        end;
      end;

      for I := Low(g_OldItemArr) to High(g_OldItemArr) do begin
        if (g_ItemArr[I].S.Name = '') and (g_OldItemArr[I].S.Name <> '') then begin
          boFind := False;
          for II := Low(g_ItemArr) + 6 to High(g_ItemArr) do begin
            if g_ItemArr[II].S.Name <> '' then begin
              if (g_ItemArr[II].S.Name = g_OldItemArr[I].S.Name) then begin
                g_ItemArr[I] := g_ItemArr[II];
                g_ItemArr[II].S.Name := '';
                boFind := True;
                Break;
              end;
            end;
          end;

          if not boFind then begin //查找解包
            if BagItemCount <= 40 then begin
              nIndex := FindItemArrBindItemName(g_OldItemArr[I].S.Name);
              if nIndex >= 0 then begin
                AutoEatItem(nIndex);
              end else begin
                g_OldItemArr[I].S.Name := '';
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

//自动吃药

function TfrmMain.AutoEatItem(idx: Integer): Boolean;
begin
  Result := False;
  if (idx in [0..46 - 1]) and (g_WaitingUseItem.Item.S.Name = '') then begin
    if (g_EatingItem.S.Name <> '') and (GetTickCount - g_dwEatTime > 5 * 1000) then begin
      g_EatingItem.S.Name := '';
    end;
    if (g_EatingItem.S.Name = '') then begin
      if (g_ItemArr[idx].S.Name <> '') and ((g_ItemArr[idx].S.StdMode <= 3) or (g_ItemArr[idx].S.StdMode = 31)) then begin
        g_dwEatTime := GetTickCount;
        g_EatingItem := g_ItemArr[idx];
        g_ItemArr[idx].S.Name := '';
        SendEat(g_EatingItem.MakeIndex, g_EatingItem.S.Name);
        Result := True;
      end;
    end;
  end;
end;
//自动吃药

function TfrmMain.AutoHeroEatItem(idx: Integer): Boolean;
begin
  Result := False;
  if (idx in [0..40 - 1]) and (g_WaitingUseItem.Item.S.Name = '') then begin
    if (g_HeroEatingItem.S.Name <> '') and (GetTickCount - g_dwHeroEatTime > 5 * 1000) then begin
      g_HeroEatingItem.S.Name := '';
    end;
    if (g_HeroEatingItem.S.Name = '') then begin
      if (g_HeroItemArr[idx].S.Name <> '') and ((g_HeroItemArr[idx].S.StdMode <= 3) or (g_HeroItemArr[idx].S.StdMode = 31)) then begin
        g_dwHeroEatTime := GetTickCount;
        g_HeroEatingItem := g_HeroItemArr[idx];
        g_HeroItemArr[idx].S.Name := '';
        SendHeroEat(g_HeroEatingItem.MakeIndex, g_HeroEatingItem.S.Name);
        Result := True;
      end;
    end;
  end;
end;

procedure TfrmMain.AutoUseItem(Sender: TObject);
begin
  AutoOrderItem;

  if g_boHumProtect then begin
    AutoEatHPItem(Sender);
    AutoEatMPItem(Sender);
    AutoUseBookItem(Sender);
  end;

  if g_boHeroProtect then begin
    AutoHeroEatHPItem(Sender);
    AutoHeroEatMPItem(Sender);
  end;

  DuraWarning();
end;

procedure TfrmMain.AutoEatHPItem(Sender: TObject);
var
  nIndex: Integer;
  sItemName: string;
  function EatHPItem1(flag: Boolean): Boolean;
  begin
    Result := False;
    if (g_Config.nRenewHumHPIndex1 >= 0) and (GetTickCount - g_dwRenewHumHPTick1 > g_Config.nRenewHumHPTime1) and (flag or (g_MySelf.m_Abil.HP < g_Config.nRenewHumHPPercent1)) then begin
      sItemName := g_Config.sRenewHumHPItem1Name;
      nIndex := FindBagItemName(sItemName);
      if nIndex >= 0 then begin
        g_dwRenewHumHPTick1 := GetTickCount;
        Result := AutoEatItem(nIndex);
      end;
    end;
  end;
  function EatHPItem2(flag: Boolean): Boolean;
  begin
    Result := False;
    if (g_Config.nRenewHumHPIndex2 >= 0) and (GetTickCount - g_dwRenewHumHPTick2 > g_Config.nRenewHumHPTime2) and (flag or (g_MySelf.m_Abil.HP < g_Config.nRenewHumHPPercent2)) then begin
      sItemName := g_Config.sRenewHumHPItem2Name;
      nIndex := FindBagItemName(sItemName);
      if nIndex >= 0 then begin
        g_dwRenewHumHPTick2 := GetTickCount;
        Result := AutoEatItem(nIndex);
      end;
    end;
  end;
begin
  if (g_WaitingUseItem.Item.S.Name = '') and (g_MySelf <> nil) and
    (not g_MySelf.m_boDeath) and (g_MySelf.m_Abil.HP > 0) then begin
    if g_Config.boRenewHumHPIsAuto1 and g_Config.boRenewHumHPIsAuto2 then begin
      if g_Config.nRenewHumHPPercent2 < g_Config.nRenewHumHPPercent1 then begin
        if (g_MySelf.m_Abil.HP < g_Config.nRenewHumHPPercent2) then begin
          if not EatHPItem2(False) then
            if not EatHPItem1(False) then

        end else begin
          if not EatHPItem1(False) then
            if not EatHPItem2(False) then

        end;
      end else begin
        if (g_MySelf.m_Abil.HP < g_Config.nRenewHumHPPercent1) then begin
          if not EatHPItem1(False) then
            if not EatHPItem2(False) then

        end else begin
          if not EatHPItem2(False) then
            if not EatHPItem1(False) then

        end;
      end;

    end else
      if g_Config.boRenewHumHPIsAuto1 and (not g_Config.boRenewHumHPIsAuto2) then begin
      EatHPItem1(False);
    end else
      if (not g_Config.boRenewHumHPIsAuto1) and g_Config.boRenewHumHPIsAuto2 then begin
      EatHPItem2(False);
    end;
  end;
end;

procedure TfrmMain.AutoEatMPItem(Sender: TObject);
var
  nIndex: Integer;
  sItemName: string;
  function EatMPItem1(flag: Boolean): Boolean;
  begin
    Result := False;
    if (g_Config.nRenewHumMPIndex1 >= 0) and (GetTickCount - g_dwRenewHumMPTick1 > g_Config.nRenewHumMPTime1) and (flag or (g_MySelf.m_Abil.MP < g_Config.nRenewHumMPPercent1)) then begin
      sItemName := g_Config.sRenewHumMPItem1Name;
      nIndex := FindBagItemName(sItemName);
      if nIndex >= 0 then begin
        g_dwRenewHumMPTick1 := GetTickCount;
        Result := AutoEatItem(nIndex);
      end;
    end;
  end;
  function EatMPItem2(flag: Boolean): Boolean;
  begin
    Result := False;
    if (g_Config.nRenewHumMPIndex2 >= 0) and (GetTickCount - g_dwRenewHumMPTick2 > g_Config.nRenewHumMPTime2) and (flag or (g_MySelf.m_Abil.MP < g_Config.nRenewHumMPPercent2)) then begin
      sItemName := g_Config.sRenewHumMPItem2Name;
      nIndex := FindBagItemName(sItemName);
      if nIndex >= 0 then begin
        g_dwRenewHumMPTick2 := GetTickCount;
        Result := AutoEatItem(nIndex);
      end;
    end;
  end;
begin
  if (g_WaitingUseItem.Item.S.Name = '') and (g_MySelf <> nil) and
    (not g_MySelf.m_boDeath) {and (g_MySelf.m_Abil.MP > 0)} then begin
    if g_Config.boRenewHumMPIsAuto1 and g_Config.boRenewHumMPIsAuto2 then begin

      if g_Config.nRenewHumMPPercent2 < g_Config.nRenewHumMPPercent1 then begin
        if (g_MySelf.m_Abil.MP < g_Config.nRenewHumMPPercent2) then begin
          if not EatMPItem2(False) then
            if not EatMPItem1(False) then

        end else begin
          if not EatMPItem1(False) then
            if not EatMPItem2(False) then

        end;
      end else begin
        if (g_MySelf.m_Abil.MP < g_Config.nRenewHumMPPercent1) then begin
          if not EatMPItem1(False) then
            if not EatMPItem2(False) then

        end else begin
          if not EatMPItem2(False) then
            if not EatMPItem1(False) then

        end;
      end;

    end else
      if g_Config.boRenewHumMPIsAuto1 and (not g_Config.boRenewHumMPIsAuto2) then begin
      EatMPItem1(False);
    end else
      if (not g_Config.boRenewHumMPIsAuto1) and g_Config.boRenewHumMPIsAuto2 then begin
      EatMPItem2(False);
    end;
  end;
end;

procedure TfrmMain.AutoUseBookItem(Sender: TObject);
var
  nIndex: Integer;
  sItemName: string;
  function EatBookItem(flag: Boolean): Boolean;
  begin
    Result := False;
    if (GetTickCount - g_dwRenewBookTick > g_Config.nRenewBookTime * 1000) and (flag or (g_MySelf.m_Abil.HP < g_Config.nRenewBookPercent)) then begin
      //DScreen.AddChatBoardString('TfrmMain.EatBookItem:', clyellow, clRed);
      //sItemName := FrmDlg.DComboboxBookIndex.Items.Strings[g_Config.nRenewBookNowBookIndex];
      sItemName := g_Config.sRenewBookNowBookItem;
      //DScreen.AddChatBoardString('TfrmMain.EatBookItem1:' + sItemName, clyellow, clRed);
      nIndex := FindBagItemName(sItemName);
      if nIndex >= 0 then begin
        g_dwRenewBookTick := GetTickCount;
        Result := AutoEatItem(nIndex);
        //DScreen.AddChatBoardString('TfrmMain.EatBookItem2:' + sItemName, clyellow, clRed);
      end else begin
        nIndex := FindItemArrBindItemName(sItemName);
        //DScreen.AddChatBoardString('TfrmMain.EatBookItem3:' + sItemName, clyellow, clRed);
        if nIndex >= 0 then begin
          g_dwRenewBookTick := GetTickCount;
          //DScreen.AddChatBoardString('TfrmMain.EatBookItem4:' + sItemName, clyellow, clRed);
          Result := AutoEatItem(nIndex);
        end;
      end;
    end;
  end;
begin
  if g_Config.boRenewBookIsAuto and (g_Config.sRenewBookNowBookItem <> '') and
    //(g_Config.nRenewBookNowBookIndex < FrmDlg.DComboboxBookIndex.Items.Count) and
    {(FrmDlg.DComboboxBookIndex.Itemindex >= 0) and
    (FrmDlg.DComboboxBookIndex.Itemindex < FrmDlg.DComboboxBookIndex.Items.Count) and }
    {(g_EatingItem.S.Name = '') and }
  (g_WaitingUseItem.Item.S.Name = '') and (g_MySelf <> nil) and
    (not g_MySelf.m_boDeath) and (g_MySelf.m_Abil.HP > 0) then EatBookItem(False);
end;

procedure TfrmMain.AutoHeroEatHPItem(Sender: TObject);
var
  nIndex: Integer;
  sItemName: string;
  function EatHPItem1(flag: Boolean): Boolean;
  begin
    Result := False;
    if (g_Config.nRenewHeroHPIndex1 >= 0) and (GetTickCount - g_dwRenewHeroHPTick1 > g_Config.nRenewHeroHPTime1) and (flag or (g_MyHero.m_Abil.HP < g_Config.nRenewHeroHPPercent1)) then begin
      sItemName := g_Config.sRenewHeroHPItem1Name;
      nIndex := FindHeroBagItemName(sItemName);
      if nIndex >= 0 then begin
        g_dwRenewHeroHPTick1 := GetTickCount;
        Result := AutoHeroEatItem(nIndex);
      end;
    end;
  end;
  function EatHPItem2(flag: Boolean): Boolean;
  begin
    Result := False;
    if (g_Config.nRenewHeroHPIndex2 >= 0) and (GetTickCount - g_dwRenewHeroHPTick2 > g_Config.nRenewHeroHPTime2) and (flag or (g_MyHero.m_Abil.HP < g_Config.nRenewHeroHPPercent2)) then begin
      sItemName := g_Config.sRenewHeroHPItem2Name;
      nIndex := FindHeroBagItemName(sItemName);
      if nIndex >= 0 then begin
        g_dwRenewHeroHPTick2 := GetTickCount;
        Result := AutoHeroEatItem(nIndex);
      end;
    end;
  end;
begin
  if (g_WaitingUseItem.Item.S.Name = '') and (g_MyHero <> nil) and
    (not g_MyHero.m_boDeath) and (g_MyHero.m_Abil.HP > 0) then begin
    if (g_Config.boRenewHeroHPIsAuto1) and (g_Config.boRenewHeroHPIsAuto2) then begin

      if g_Config.nRenewHeroHPPercent2 < g_Config.nRenewHeroHPPercent1 then begin
        if (g_MyHero.m_Abil.HP < g_Config.nRenewHeroHPPercent2) then begin
          if not EatHPItem2(False) then
            if not EatHPItem1(False) then

        end else begin
          if not EatHPItem1(False) then
            if not EatHPItem2(False) then

        end;
      end else begin
        if (g_MyHero.m_Abil.HP < g_Config.nRenewHeroHPPercent1) then begin
          if not EatHPItem1(False) then
            if not EatHPItem2(False) then

        end else begin
          if not EatHPItem2(False) then
            if not EatHPItem1(False) then

        end;
      end;

    end else
      if (g_Config.boRenewHeroHPIsAuto1) and (not g_Config.boRenewHeroHPIsAuto2) then begin
      EatHPItem1(False);
    end else
      if (not g_Config.boRenewHeroHPIsAuto1) and (g_Config.boRenewHeroHPIsAuto2) then begin
      EatHPItem2(False);
    end;
  end;
end;

procedure TfrmMain.AutoHeroEatMPItem(Sender: TObject);
var
  nIndex: Integer;
  sItemName: string;
  function EatMPItem1(flag: Boolean): Boolean;
  begin
    Result := False;
    if (g_Config.nRenewHeroMPIndex1 > 0) and (GetTickCount - g_dwRenewHeroMPTick1 > g_Config.nRenewHeroMPTime1) and (flag or (g_MyHero.m_Abil.MP < g_Config.nRenewHeroMPPercent1)) then begin
      sItemName := g_Config.sRenewHeroMPItem1Name;
      nIndex := FindHeroBagItemName(sItemName);
      if nIndex >= 0 then begin
        g_dwRenewHeroMPTick1 := GetTickCount;
        Result := AutoHeroEatItem(nIndex);
      end;
    end;
  end;

  function EatMPItem2(flag: Boolean): Boolean;
  begin
    Result := False;
    if (g_Config.nRenewHeroMPIndex2 > 0) and (GetTickCount - g_dwRenewHeroMPTick2 > g_Config.nRenewHeroMPTime2) and (flag or (g_MyHero.m_Abil.MP < g_Config.nRenewHeroMPPercent2)) then begin
      sItemName := g_Config.sRenewHeroMPItem2Name;
      nIndex := FindHeroBagItemName(sItemName);
      if nIndex >= 0 then begin
        g_dwRenewHeroMPTick2 := GetTickCount;
        Result := AutoHeroEatItem(nIndex);
      end;
    end;
  end;
begin
  if (g_WaitingUseItem.Item.S.Name = '') and (g_MyHero <> nil) and
    (not g_MyHero.m_boDeath) {and (g_MyHero.m_Abil.MP > 0)} then begin
    if g_Config.boRenewHeroMPIsAuto1 and g_Config.boRenewHeroMPIsAuto2 then begin
      if g_Config.nRenewHeroMPPercent2 < g_Config.nRenewHeroMPPercent1 then begin
        if (g_MyHero.m_Abil.MP < g_Config.nRenewHeroMPPercent2) then begin
          if not EatMPItem2(False) then
            if not EatMPItem1(False) then

        end else begin
          if not EatMPItem1(False) then
            if not EatMPItem2(False) then

        end;
      end else begin
        if (g_MyHero.m_Abil.MP < g_Config.nRenewHeroMPPercent1) then begin
          if not EatMPItem1(False) then
            if not EatMPItem2(False) then
        end else begin
          if not EatMPItem2(False) then
            if not EatMPItem1(False) then
        end;
      end;
    end else
      if g_Config.boRenewHeroMPIsAuto1 and (not g_Config.boRenewHeroMPIsAuto2) then begin
      EatMPItem1(False);
    end else
      if (not g_Config.boRenewHeroMPIsAuto1) and g_Config.boRenewHeroMPIsAuto2 then begin
      EatMPItem2(False);
    end;
  end;
end;

procedure TfrmMain.DuraWarning();
var
  I: Integer;
  sHint: string;
begin
  if g_Config.boDuraWarning and (g_MySelf <> nil) { and (not g_MySelf.m_boDeath)} then begin
    if GetTickCount - g_dwHintItemDuraTick > 1000 * 2 then begin
      g_dwHintItemDuraTick := GetTickCount;
      for I := U_DRESS to U_CHARM do begin
        if g_UseItems[I].S.Name <> '' then begin
          if g_UseItems[I].Dura <= Round(g_UseItems[I].DuraMax * 10 / 100) then begin
            sHint := g_UseItems[I].S.Name + ' 持久过低';
            DScreen.AddChatBoardString(sHint, clyellow, clRed);
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (g_MySelf <> nil) and (g_ConnectionStep = cnsPlay) then begin
    if mrOk = FrmDlg.DMessageDlg('你真的要退出游戏吗?', [mbOk, mbCancel]) then begin
      if g_boBagLoaded then
        Savebags('.\Data\' + g_sServerName + '.' + g_sSelChrName + '.itm', @g_ItemArr);
      g_boBagLoaded := False;
      SendGameCenterMsg(CM_QUIT, IntToStr(Handle));
    end else CanClose := False;
  end else SendGameCenterMsg(CM_QUIT, IntToStr(Handle));
end;

procedure TfrmMain.PlayMedia(const sFileName: string);
begin
  g_MediaList.Lock;
  try
    if g_MediaList.IndexOf(sFileName) < 0 then
      g_MediaList.Add(sFileName)
    else Exit;
  finally
    g_MediaList.UnLock;
  end;
  if g_nPlayMediaCount = 0 then begin
    g_dwPlayMediaTick := GetTickCount;
    g_dwPlayMediaTime := 5000;
  end else begin
    g_dwPlayMediaTick := GetTickCount;
    g_dwPlayMediaTime := 3000;
  end;
  Inc(g_nPlayMediaCount);
  if not TimerPlayMedia.Enabled then
    TimerPlayMedia.Enabled := True;
end;

procedure TfrmMain.TimerPlayMediaTimer(Sender: TObject);
var
  I: Integer;
begin
  if GetTickCount - g_dwPlayMediaTick > g_dwPlayMediaTime then begin
    g_dwPlayMediaTick := GetTickCount;
    g_MediaList.Lock;
    try
      for I := 0 to g_MediaList.Count - 1 do begin
        try
          if Assigned(g_PlugInfo.MediaPlayer.Player) then begin
            g_PlugInfo.MediaPlayer.Player(PChar(g_MediaList[I]), False, True);
          end;
        except
        end;
      end;
      g_MediaList.Clear;
    finally
      g_MediaList.UnLock;
    end;
  end;
end;

procedure TfrmMain.ClientStartVibration(nCount: Integer);
var
  X, Y, nLen, nValue: Integer;
begin
  if (g_MySelf <> nil) and (not g_MySelf.m_boDeath) and (not g_boVibration) then begin
    nLen := -1;
    nValue := 10;
    g_nVibrationPos := 0;
    g_nVibrationCount := 0;
    g_nVibrationTotal := nCount;
    SetLength(g_VibrationValue, 0);
    for Y := 1 to 2 do begin
      for X := 1 to 2 do begin
        Inc(nLen);
        SetLength(g_VibrationValue, nLen + 1);
        g_VibrationValue[nLen].X := 0;
        g_VibrationValue[nLen].Y := g_VibrationValue[nLen].Y - nValue div Y;

        Inc(nLen);
        SetLength(g_VibrationValue, nLen + 1);
        g_VibrationValue[nLen].X := g_VibrationValue[nLen].X - nValue div Y;
        g_VibrationValue[nLen].Y := 0;

        Inc(nLen);
        SetLength(g_VibrationValue, nLen + 1);
        g_VibrationValue[nLen].X := 0;
        g_VibrationValue[nLen].Y := g_VibrationValue[nLen].Y + nValue div Y;

        Inc(nLen);
        SetLength(g_VibrationValue, nLen + 1);
        g_VibrationValue[nLen].X := g_VibrationValue[nLen].X + nValue div Y;
        g_VibrationValue[nLen].Y := 0;
      end;
    end;
    g_boVibration := True;
  end;
end;

procedure TfrmMain.ClientOpenBigDiaLogBox(nImageIndex: Integer);
var
  I: Integer;
  c: TControl;
begin
  g_nCurMerchantFaceIdx := nImageIndex;
  FrmDlg.ResetMenuDlg;
  FrmDlg.CloseMDlg;

  for I := FrmDlg.DMerchantBigDlg.DControls.Count - 1 downto 0 do begin
    c := TControl(FrmDlg.DMerchantBigDlg.DControls.Items[I]);
    if (c is TDLabel) or (c is TNpcLabel) then begin
      c.Free;
    end;
  end;
  FrmDlg.DMerchantBigDlg.Floating := True;
  try
    FrmDlg.DMerchantBigDlg.Visible := True;
  finally
    FrmDlg.DMerchantBigDlg.Floating := False;
  end;
  //DScreen.AddChatBoardString('TfrmMain.ClientOpenBigDiaLogBox:'+IntToStr(g_nCurMerchantFaceIdx), clyellow, clRed);
end;

procedure TfrmMain.ClientCloseBigDiaLogBox();
begin
  FrmDlg.CloseBigMDlg;
end;

initialization

finalization

end.

