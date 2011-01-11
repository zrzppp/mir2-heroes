unit FState;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DWinCtl, StdCtrls, Textures, Grids, Grobal2, ClFunc, HUtil32, Actor,
  MapUnit, SoundUtil, ComCtrls, EncryptUnit, Share, WIL, ExtCtrls;

const
  BOTTOMBOARD800 = 371; //主操作介面图形号
  BOTTOMBOARD1024 = 2; //主操作介面图形号
  VIEWCHATLINE = 9;
  MAXSTATEPAGE = 4;
  MAXHEROSTATEPAGE = 4;
  LISTLINEHEIGHT = 13;
  MAXMENU = 10;

  AdjustAbilHints: array[0..8] of string = (
    '攻击力',
    '魔法(魔法师)',
    '道术(道士)',
    '防御',
    '魔法防御',
    '生命值',
    '魔法值',
    '准确',
    '敏捷'
    );

type
  TSpotDlgMode = (dmSell, dmRepair, dmStorage, dmSellOff, dmChange);

  TClickPoint = record
    rc: TRect;
    rstr: string;
  end;
  pTClickPoint = ^TClickPoint;
  TDiceInfo = record
    nDicePoint: Integer;
    nPlayPoint: Integer; //当前骰子点数
    nX: Integer;
    nY: Integer;
    n67C: Integer;
    n680: Integer;
    dwPlayTick: LongWord;
  end;
  pTDiceInfo = ^TDiceInfo;

  TNpcLabel = class(TDLabel)
  private
    m_nColorPosition: Integer;
  public
    m_dwChgColorTick: LongWord;
    m_ColorList: TList;
    m_nRecogId: Integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Process; override;
    procedure AddColor(btColor: Byte);
  end;

  TEffectTick = record
    nIndex: Integer;
    dwDrawTick: LongWord;
  end;
  pTEffectTick = ^TEffectTick;

  TItemLabel = class(TDButton)

  private
    FClientItem: TClientItem;
    FClickTimeTick: LongWord;
    FEffectTick: array[0..2] of TEffectTick;
    FGetClientItem: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DirectPaint(dsurface: TTexture); override;
    procedure Process; override;
  published
    property ClientItem: TClientItem read FClientItem write FClientItem;
    property ClickTimeTick: LongWord read FClickTimeTick write FClickTimeTick;
    property GetClientItem: Boolean read FGetClientItem write FGetClientItem;
  end;


  TFrmDlg = class(TForm)
    DBackground: TDWindow;
    DStateWin: TDWindow;
    DItemBag: TDWindow;
    DBottom: TDWindow;
    DPrevState: TDButton;
    DCloseState: TDButton;
    DLogIn: TDWindow;
    DNewAccount: TDWindow;
    DSelectChr: TDWindow;
    DscSelect1: TDButton;
    DscSelect2: TDButton;
    DscStart: TDButton;
    DscNewChr: TDButton;
    DscEraseChr: TDButton;
    DscCredits: TDButton;
    DscExit: TDButton;
    DCreateChr: TDWindow;
    DccWarrior: TDButton;
    DccWizzard: TDButton;
    DccMonk: TDButton;
    DccReserved: TDButton;
    DccMale: TDButton;
    DccFemale: TDButton;
    DccLeftHair: TDButton;
    DccRightHair: TDButton;
    DccOk: TDButton;
    DccClose: TDButton;
    DMsgDlg: TDWindow;
    DNextState: TDButton;
    DSWNecklace: TDButton;
    DSWLight: TDButton;
    DSWArmRingR: TDButton;
    DSWArmRingL: TDButton;
    DSWRingR: TDButton;
    DSWRingL: TDButton;
    DSWWeapon: TDButton;
    DSWDress: TDButton;
    DSWHelmet: TDButton;
    DBelt2: TDButton;
    DBelt3: TDButton;
    DBelt4: TDButton;
    DBelt5: TDButton;
    DBelt6: TDButton;
    DChgPw: TDWindow;
    DChgpwOk: TDButton;
    DChgpwCancel: TDButton;
    DMenuDlg: TDWindow;
    DMenuPrev: TDButton;
    DMenuNext: TDButton;
    DMenuBuy: TDButton;
    DMenuClose: TDButton;
    DSellDlg: TDWindow;
    DStMag1: TDButton;
    DStMag2: TDButton;
    DStMag3: TDButton;
    DStMag4: TDButton;
    DStMag5: TDButton;
    DKeySelDlg: TDWindow;
    DKsIcon: TDButton;
    DKsF1: TDButton;
    DKsF2: TDButton;
    DKsF3: TDButton;
    DKsF4: TDButton;
    DKsNone: TDButton;
    DKsOk: TDButton;
    DBotGroup: TDButton;
    DBotTrade: TDButton;
    DBotMiniMap: TDButton;
    DGroupDlg: TDWindow;
    DGrpAllowGroup: TDButton;
    DGrpDlgClose: TDButton;
    DGrpCreate: TDButton;
    DGrpAddMem: TDButton;
    DGrpDelMem: TDButton;
    DBotLogout: TDButton;
    DBotExit: TDButton;
    DBotGuild: TDButton;
    DStPageUp: TDButton;
    DStPageDown: TDButton;
    DDealRemoteDlg: TDWindow;
    DDealDlg: TDWindow;
    DDRGrid: TDGrid;
    DDGrid: TDGrid;
    DDealOk: TDButton;
    DDealClose: TDButton;
    DDGold: TDButton;
    DDRGold: TDButton;
    DSelServerDlg: TDWindow;
    DUserState1: TDWindow;
    DCloseUS1: TDButton;
    DWeaponUS1: TDButton;
    DHelmetUS1: TDButton;
    DNecklaceUS1: TDButton;
    DDressUS1: TDButton;
    DLightUS1: TDButton;
    DArmringRUS1: TDButton;
    DRingRUS1: TDButton;
    DArmringLUS1: TDButton;
    DRingLUS1: TDButton;
    DGuildDlg: TDWindow;
    DGDHome: TDButton;
    DGDList: TDButton;
    DGDChat: TDButton;
    DGDAddMem: TDButton;
    DGDDelMem: TDButton;
    DGDEditNotice: TDButton;
    DGDEditGrade: TDButton;
    DGDAlly: TDButton;
    DGDBreakAlly: TDButton;
    DGDWar: TDButton;
    DGDCancelWar: TDButton;
    DGDUp: TDButton;
    DGDDown: TDButton;
    DGDClose: TDButton;
    DGuildEditNotice: TDWindow;
    DGEClose: TDButton;
    DGEOk: TDButton;
    DAdjustAbility: TDWindow;
    DPlusDC: TDButton;
    DPlusMC: TDButton;
    DPlusSC: TDButton;
    DPlusAC: TDButton;
    DPlusMAC: TDButton;
    DPlusHP: TDButton;
    DPlusMP: TDButton;
    DPlusHit: TDButton;
    DPlusSpeed: TDButton;
    DMinusDC: TDButton;
    DMinusMC: TDButton;
    DMinusSC: TDButton;
    DMinusAC: TDButton;
    DMinusMAC: TDButton;
    DMinusMP: TDButton;
    DMinusHP: TDButton;
    DMinusHit: TDButton;
    DMinusSpeed: TDButton;
    DAdjustAbilClose: TDButton;
    DAdjustAbilOk: TDButton;
    DBotPlusAbil: TDButton;
    DKsF5: TDButton;
    DKsF6: TDButton;
    DKsF7: TDButton;
    DKsF8: TDButton;
    DKsConF1: TDButton;
    DKsConF2: TDButton;
    DKsConF3: TDButton;
    DKsConF4: TDButton;
    DKsConF8: TDButton;
    DKsConF7: TDButton;
    DKsConF6: TDButton;
    DKsConF5: TDButton;
    DSWCharm: TDButton;
    DSWBoots: TDButton;
    DSWBelt: TDButton;
    DSWBujuk: TDButton;
    DBujukUS1: TDButton;
    DBeltUS1: TDButton;
    DBootsUS1: TDButton;
    DCharmUS1: TDButton;
    DBotMemo: TDButton;
    DFriendDlg: TDWindow;
    DFrdFriend: TDButton;
    DFrdBlackList: TDButton;
    DFrdClose: TDButton;
    DFrdPgUp: TDButton;
    DFrdPgDn: TDButton;
    DMailListDlg: TDWindow;
    DMailListClose: TDButton;
    DMailListPgUp: TDButton;
    DMailListPgDn: TDButton;
    DMailDlg: TDWindow;
    DBlockListDlg: TDWindow;
    DBLPgUp: TDButton;
    DBlockListClose: TDButton;
    DBLPgDn: TDButton;
    DMemo: TDWindow;
    DMemoClose: TDButton;
    DConfigDlgClose: TDButton;
    DFrdAdd: TDButton;
    DFrdDel: TDButton;
    DFrdMemo: TDButton;
    DFrdMail: TDButton;
    DFrdWhisper: TDButton;
    DMLReply: TDButton;
    DMLRead: TDButton;
    DMLLock: TDButton;
    DMLDel: TDButton;
    DMLBlock: TDButton;
    DBLDel: TDButton;
    DBLAdd: TDButton;
    DMemoB2: TDButton;
    DMemoB1: TDButton;
    DChgGamePwd: TDWindow;
    DChgGamePwdClose: TDButton;
    DButton2: TDButton;
    DButton1: TDButton;
    DShopExit: TDButton;
    DButtonFriend: TDButton;
    DButtonHeroBag: TDButton;
    DButFunc1: TDButton;
    DButFunc2: TDButton;
    DButFunc3: TDButton;
    DButFunc4: TDButton;
    DButFunc5: TDButton;
    DHeroStateWin: TDWindow;
    DCloseHeroState: TDButton;
    DPrevHeroState: TDButton;
    DNextHeroState: TDButton;
    DHeroSWWeapon: TDButton;
    DHeroSWHelmet: TDButton;
    DHeroSWArmRingR: TDButton;
    DHeroSWRingR: TDButton;
    DHeroSWDress: TDButton;
    DHeroSWNecklace: TDButton;
    DHeroSWLight: TDButton;
    DHeroSWArmRingL: TDButton;
    DHeroSWRingL: TDButton;
    DHeroStMag1: TDButton;
    DHeroStMag2: TDButton;
    DHeroStMag3: TDButton;
    DHeroStMag4: TDButton;
    DHeroStMag5: TDButton;
    DHeroStPageUp: TDButton;
    DHeroStPageDown: TDButton;
    DHeroSWCharm: TDButton;
    DHeroSWBoots: TDButton;
    DHeroSWBelt: TDButton;
    DHeroSWBujuk: TDButton;
    DButtonDuel: TDButton;
    DHeroItemBag: TDWindow;
    DHeroHealthStateWin: TDWindow;
    DShop: TDWindow;
    DMiniMap: TDWindow;
    DUpgrade: TDWindow;
    DItemBox: TDWindow;
    DUserSellOff: TDWindow;
    DBoxItems: TDWindow;
    DBook: TDWindow;
    DFindChr: TDWindow;
    DStoreDlg: TDWindow;
    DUserStore: TDWindow;
    DStoreMsgDlg: TDWindow;
    DEditStore: TDEdit;
    DGStore: TDGrid;
    DStoreName: TDButton;
    DStoreClose: TDButton;
    DStoreOpen: TDButton;
    DStoreCancel: TDButton;
    DStoreMsgDlgOk: TDButton;
    EdStoreDlgEdit: TDEdit;
    DStoreMsgDlgCancel: TDButton;
    DEditUserStore: TDEdit;
    DGUserStore: TDGrid;
    DUserStoreBuy: TDButton;
    DUserStoreClose: TDButton;
    DJewelry: TDButton;
    DMedicine: TDButton;
    DEnhance: TDButton;
    Dfriend: TDButton;
    DLimit: TDButton;
    DShopIntroduce: TDButton;
    DShopItemGrid: TDGrid;
    DSuperShopItemGrid: TDGrid;
    DPrevShop: TDButton;
    DNextShop: TDButton;
    DShopBuy: TDButton;
    DShopFree: TDButton;
    DShopClose: TDButton;
    DNewAccountClose: TDButton;
    DNewAccountCancel: TDButton;
    DNewAccountOk: TDButton;
    DLoginClose: TDButton;
    DLoginChgPw: TDButton;
    DLoginNew: TDButton;
    DLoginOk: TDButton;
    DCloseUpgrade: TDButton;
    DStartUpgrade: TDButton;
    DUpgradeItem3: TDButton;
    DUpgradeItem2: TDButton;
    DUpgradeItem1: TDButton;
    DSellClose: TDButton;
    DCloseSell: TDButton;
    DNextSell: TDButton;
    DSellItem: TDButton;
    DRefreshSell: TDButton;
    DBuySellItem: TDButton;
    DPrevSell: TDButton;
    DSearchSellOff: TDButton;
    EdSearch: TDEdit;
    DItemLock: TDButton;
    DBookPage: TDButton;
    DBookClose: TDButton;
    DBookPrevPage: TDButton;
    DBookNextPage: TDButton;
    DFindChrNext: TDButton;
    DFindChrPrior: TDButton;
    DFindChrClose: TDButton;
    DFindOK: TDButton;
    DSServer2: TDButton;
    DSServer1: TDButton;
    DSSrvClose: TDButton;
    DEngServer1: TDButton;
    DSServer4: TDButton;
    DSServer3: TDButton;
    DSServer6: TDButton;
    DSServer5: TDButton;
    EdDlgEdit: TDEdit;
    DMsgDlgOk: TDButton;
    DMsgDlgYes: TDButton;
    DMsgDlgCancel: TDButton;
    DMsgDlgNo: TDButton;
    DSellDlgSpot: TDButton;
    DSellDlgClose: TDButton;
    DSellDlgOk: TDButton;
    DCloseHeroBag: TDButton;
    DItemGrid: TDGrid;
    DGold: TDButton;
    DOpenUpgrade: TDButton;
    DCloseBag: TDButton;
    EdId: TDEdit;
    EdPasswd: TDEdit;
    DBoxItemGrid: TDGrid;
    DGetBoxItemFlash: TDButton;
    DHeroItemGrid: TDGrid;
    DWDuel: TDWindow;
    DDuelClose: TDButton;
    DDDuelGold: TDButton;
    DDDuelGrid: TDGrid;
    DDRDuelGrid: TDGrid;
    DDRDuelGold: TDButton;
    DDuelCancel: TDButton;
    DDuelOK: TDButton;
    DBelt1: TDButton;
    EdChat: TDEdit;
    DVoice: TDButton;
    DPlayTool: TDButton;
    DOnHouser: TDButton;
    DMyState: TDButton;
    DMyMagic: TDButton;
    DMyBag: TDButton;
    DHelp: TDButton;
    DFirDragon: TDButton;
    DButtonShop: TDButton;
    DButtonReCallHero: TDButton;
    DRanking: TDButton;
    DButtonOption2: TDButton;
    DButtonOption1: TDButton;
    DButtonMP: TDButton;
    DButtonHP: TDButton;
    DButtonHeroState: TDButton;
    DMapTitle: TDWindow;
    DMerchantDlg: TDWindow;
    DMerchantDlgClose: TDButton;
    DWRandomCode: TDWindow;
    DBRandomCodeOK: TDButton;
    DBRandomCodeChg: TDButton;
    DEditRandomCode: TDEdit;
    DButton4: TDButton;
    DRankingDlg: TDWindow;
    DBotCharRanking: TDButton;
    DBotHeroRanking: TDButton;
    DBotMasterRanking: TDButton;
    DBotActorRanking: TDButton;
    DBotWarriorRanking: TDButton;
    DBotWizzardRanking: TDButton;
    DBotMonkRanking: TDButton;
    DBotHeroActorRanking: TDButton;
    DBotHeroWarriorRanking: TDButton;
    DBotHeroWizzardRanking: TDButton;
    DBotHeroMonkRanking: TDButton;
    DBotRankingHome: TDButton;
    DBotRankingUp: TDButton;
    DBotRankingDown: TDButton;
    DBotRankingLast: TDButton;
    DBotRankingSelf: TDButton;
    DBotRankingClose: TDButton;
    DHeroStMag6: TDButton;
    DStMag6: TDButton;
    DMainMenu: TDPopupMenu;
    DMenuBook: TDPopupMenu;
    DMagicMenu: TDPopupMenu;
    DChatDlg: TDWindow;
    DMemoChat: TDMemo;
    DScrollChat: TDScroll;
    DEdChat: TDWindow;
    DShowChat: TDButton;
    DConfigDlg: TDPageControl;
    DWindowTab1: TDWindow;
    DWindowTab2: TDWindow;
    DWindowTab3: TDWindow;
    DWindowTab4: TDWindow;
    DWindowTab5: TDWindow;
    DWindowTab6: TDWindow;
    DWindowTab7: TDWindow;
    DWindowTab8: TDWindow;
    DMemoTab1: TDMemo;
    DScrollTab1: TDScroll;
    DMemoTab2: TDMemo;
    DScrollTab2: TDScroll;
    DButtonTab1: TDButton;
    DButtonTab2: TDButton;
    DButtonTab3: TDButton;
    DButtonTab4: TDButton;
    DButtonTab5: TDButton;
    DButtonTab6: TDButton;
    DButtonTab7: TDButton;
    DButtonTab8: TDButton;
    DMemoTab3: TDMemo;
    DScrollTab3: TDScroll;
    DMemoTab4: TDMemo;
    DScrollTab4: TDScroll;
    DMemoTab5: TDMemo;
    DScrollTab5: TDScroll;
    DMemoTab6: TDMemo;
    DScrollTab6: TDScroll;
    DMemoTab7: TDMemo;
    DScrollTab7: TDScroll;
    DMemoTab8: TDMemo;
    DScrollTab8: TDScroll;

    DCheckBoxShowMoveNumberLable: TDCheckBox;
    DCheckBoxMusic: TDCheckBox;
    DCheckBoxOrderItem: TDCheckBox;
    DCheckBoxItemDuraHint: TDCheckBox;
    DCheckBoxCompareItem: TDCheckBox;

    DLabelItemName: TDLabel;
    DLabelItemHint: TDLabel;
    DLabelPickUpItem: TDLabel;
    DLabelShowItemName: TDLabel;
    DEditSearchItem: TDEdit;
    DComboboxItemType: TDCombobox;
    DCheckBoxPickUpItemAll: TDCheckBox;
    DLabelOption: TDLabel;
    DLabelBookItem: TDLabel;
    DComboboxBookIndex: TDCombobox;
    DCheckBoxBook: TDCheckBox;
    DLabelBookHP: TDLabel;
    DEditBookHP: TDEdit;
    DEditBookTime: TDEdit;
    DLabelBookTime: TDLabel;
    DLabelBookItemType: TDLabel;
    DLabel1: TDLabel;
    DLabel2: TDLabel;
    DLabel3: TDLabel;
    DLabel10: TDLabel;
    DCheckBoxLongHit: TDCheckBox;
    DCheckBoxWideHit: TDCheckBox;
    DCheckBoxFireHit: TDCheckBox;
    DCheckBoxSWideHit: TDCheckBox;
    DCheckBoxCrsHit: TDCheckBox;
    DCheckBoxKtHit: TDCheckBox;
    DCheckBoxShield: TDCheckBox;
    DCheckBoxSign: TDCheckBox;
    DCheckBoxPoison: TDCheckBox;
    DCheckBoxWjzq: TDCheckBox;
    DCheckBoxAutoUseMagic: TDCheckBox;
    DEditAutoUseMagicTime: TDEdit;
    DComboboxAutoUseMagic: TDCombobox;
    DComboboxPoison: TDCombobox;
    DCheckBoxAutoHideSelf: TDCheckBox;
    DLabel11: TDLabel;
    DLabelKeyOriginal: TDLabel;
    DLabelKeyChange: TDLabel;
    DLabelKey1: TDLabel;
    DLabelKey2: TDLabel;
    DLabelKey3: TDLabel;
    DLabelKey4: TDLabel;
    DLabelKey5: TDLabel;
    DLabelKey6: TDLabel;
    DLabelKey7: TDLabel;
    DLabelHeroCallHero1: TDLabel;
    DLabelHeroSetTarget1: TDLabel;
    DLabelHeroUnionHit1: TDLabel;
    DLabelHeroSetAttackState1: TDLabel;
    DLabelHeroSetGuard1: TDLabel;
    DLabelSwitchAttackMode1: TDLabel;
    DLabelSwitchMiniMap1: TDLabel;
    DLabelSwitchMiniMap: TDLabel;
    DLabelSwitchAttackMode: TDLabel;
    DLabelHeroSetGuard: TDLabel;
    DLabelHeroSetAttackState: TDLabel;
    DLabelHeroUnionHit: TDLabel;
    DLabelHeroSetTarget: TDLabel;
    DLabelHeroCallHero: TDLabel;
    DLabelKeyMemo: TDLabel;
    DCheckBoxUseKey: TDCheckBox;
    DMenuPoison: TDPopupMenu;
    DMenuItemType: TDPopupMenu;
    DCategorizeSys: TDButton;
    DCategorizeGroup: TDButton;
    DCategorizeGuild: TDButton;
    DCategorizePrivate: TDButton;
    DButOther: TDButton;
    DCheckBoxPok: TDCheckBox;
    DCheckBoxStruckShield: TDCheckBox;
    DCheckBoxSmartPosLongHit: TDCheckBox;
    DCheckBoxSmartWalkLongHit: TDCheckBox;
    DCheckBoxGuaji: TDCheckBox;
    DLabelGuajiQunti: TDLabel;
    DComboboxGuajiQunti: TDCombobox;
    DLabelGuajiGeti: TDLabel;
    DComboboxGuajiGeti: TDCombobox;
    DLabelGuaJiStart: TDLabel;
    DMerchantBigDlg: TDWindow;
    DMerchantBigDlgClose: TDButton;
    DLabelSerieSkill1: TDLabel;
    DLabelKey0: TDLabel;
    DLabelSerieSkill: TDLabel;
    DSerieMagic1: TDButton;
    DLabel12: TDLabel;
    DSerieMagic2: TDButton;
    DSerieMagic3: TDButton;
    DSerieMagic4: TDButton;
    DSerieMagic5: TDButton;
    DSerieMagic6: TDButton;
    DSerieMagic7: TDButton;
    DSerieMagic8: TDButton;
    DSerieMagicMenu: TDPopupMenu;
    DEditSerieMagic: TDButton;
    DEditAdjustIncrement: TDEdit;
    DLabelAdjustIncrement: TDLabel;
    DEditHumHPPercent1: TDEdit;
    DCheckBoxHumHP1: TDCheckBox;
    DEditHumHPTime1: TDEdit;
    DCheckBoxHumMP1: TDCheckBox;
    DEditHumMPPercent1: TDEdit;
    DEditHumMPTime1: TDEdit;
    DLabelHumHP1: TDLabel;
    DLabelHumMP1: TDLabel;
    DComboboxHumHP1: TDCombobox;
    DMenuHumItem: TDPopupMenu;
    DComboboxHumMP1: TDCombobox;
    DCheckBoxHumHP2: TDCheckBox;
    DCheckBoxHumMP2: TDCheckBox;
    DEditHumHPPercent2: TDEdit;
    DEditHumMPPercent2: TDEdit;
    DComboboxHumHP2: TDCombobox;
    DComboboxHumMP2: TDCombobox;
    DEditHumHPTime2: TDEdit;
    DEditHumMPTime2: TDEdit;
    DLabelHumHP2: TDLabel;
    DLabelHumMP2: TDLabel;
    DCheckBoxHeroHP2: TDCheckBox;
    DCheckBoxHeroMP2: TDCheckBox;
    DEditHeroHPPercent2: TDEdit;
    DEditHeroMPPercent2: TDEdit;
    DComboboxHeroHP2: TDCombobox;
    DComboboxHeroMP2: TDCombobox;
    DEditHeroHPTime2: TDEdit;
    DEditHeroMPTime2: TDEdit;
    DLabelHeroHP2: TDLabel;
    DLabelHeroMP2: TDLabel;
    DLabelHeroMP1: TDLabel;
    DLabelHeroHP1: TDLabel;
    DEditHeroHPTime1: TDEdit;
    DEditHeroMPTime1: TDEdit;
    DComboboxHeroHP1: TDCombobox;
    DComboboxHeroMP1: TDCombobox;
    DEditHeroHPPercent1: TDEdit;
    DEditHeroMPPercent1: TDEdit;
    DCheckBoxHeroHP1: TDCheckBox;
    DCheckBoxHeroMP1: TDCheckBox;
    DMenuHeroItem: TDPopupMenu;

    procedure DBottomInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DBottomDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DMyStateDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DSoundClick();
    procedure DItemBagDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DStateWinDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure FormCreate(Sender: TObject);
    procedure DPrevStateDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DLoginNewDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DscSelect1DirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DccCloseDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DItemGridGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TTexture);
    procedure DItemGridDblClick(Sender: TObject);
    procedure DMsgDlgOkDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DMsgDlgDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DMsgDlgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DCloseBagDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DBackgroundBackgroundClick(Sender: TObject);
    procedure DItemGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DBelt1DirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure FormDestroy(Sender: TObject);
    procedure DBelt1DblClick(Sender: TObject);
    procedure DLoginCloseClick(Sender: TObject; X, Y: Integer);
    procedure DLoginOkClick(Sender: TObject; X, Y: Integer);
    procedure DLoginNewClick(Sender: TObject; X, Y: Integer);
    procedure DLoginChgPwClick(Sender: TObject; X, Y: Integer);
    procedure DNewAccountOkClick(Sender: TObject; X, Y: Integer);
    procedure DNewAccountCloseClick(Sender: TObject; X, Y: Integer);
    procedure DccCloseClick(Sender: TObject; X, Y: Integer);
    procedure DChgpwOkClick(Sender: TObject; X, Y: Integer);
    procedure DscSelect1Click(Sender: TObject; X, Y: Integer);
    procedure DCloseStateClick(Sender: TObject; X, Y: Integer);
    procedure DPrevStateClick(Sender: TObject; X, Y: Integer);
    procedure DNextStateClick(Sender: TObject; X, Y: Integer);
    procedure DSWWeaponClick(Sender: TObject; X, Y: Integer);
    procedure DMsgDlgOkClick(Sender: TObject; X, Y: Integer);
    procedure DCloseBagClick(Sender: TObject; X, Y: Integer);
    procedure DBelt1Click(Sender: TObject; X, Y: Integer);
    procedure DMyStateClick(Sender: TObject; X, Y: Integer);
    procedure DStateWinClick(Sender: TObject; X, Y: Integer);
    procedure DSWWeaponMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBelt1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DMerchantDlgDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DMerchantDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DMerchantDlgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DMenuCloseClick(Sender: TObject; X, Y: Integer);
    procedure DMenuDlgDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DMenuDlgClick(Sender: TObject; X, Y: Integer);
    procedure DSellDlgDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DSellDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DSellDlgSpotClick(Sender: TObject; X, Y: Integer);
    procedure DSellDlgSpotDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DSellDlgSpotMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DSellDlgOkClick(Sender: TObject; X, Y: Integer);
    procedure DMenuBuyClick(Sender: TObject; X, Y: Integer);
    procedure DMenuPrevClick(Sender: TObject; X, Y: Integer);
    procedure DMenuNextClick(Sender: TObject; X, Y: Integer);
    procedure DGoldClick(Sender: TObject; X, Y: Integer);
    procedure DSWLightDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DBackgroundMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DStateWinMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DLoginNewClickSound(Sender: TObject;
      Clicksound: TClickSound);
    procedure DStMag1DirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DStMag1Click(Sender: TObject; X, Y: Integer);
    procedure DKsIconDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DKsF1DirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DKsOkClick(Sender: TObject; X, Y: Integer);
    procedure DKsF1Click(Sender: TObject; X, Y: Integer);
    procedure DKeySelDlgDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DBotGroupDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DGrpAllowGroupDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DGrpDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBotGroupClick(Sender: TObject; X, Y: Integer);
    procedure DGrpAllowGroupClick(Sender: TObject; X, Y: Integer);
    procedure DGrpCreateClick(Sender: TObject; X, Y: Integer);
    procedure DGroupDlgDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DGrpAddMemClick(Sender: TObject; X, Y: Integer);
    procedure DGrpDelMemClick(Sender: TObject; X, Y: Integer);
    procedure DBotLogoutClick(Sender: TObject; X, Y: Integer);
    procedure DBotExitClick(Sender: TObject; X, Y: Integer);
    procedure DStPageUpClick(Sender: TObject; X, Y: Integer);
    procedure DBottomMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DDealOkClick(Sender: TObject; X, Y: Integer);
    procedure DDealCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBotTradeClick(Sender: TObject; X, Y: Integer);
    procedure DDealRemoteDlgDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DDealDlgDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DDGridGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DDGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TTexture);
    procedure DDGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DDRGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TTexture);
    procedure DDRGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DDGoldClick(Sender: TObject; X, Y: Integer);
    procedure DSServer1Click(Sender: TObject; X, Y: Integer);
    procedure DSSrvCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBotMiniMapClick(Sender: TObject; X, Y: Integer);
    procedure DMenuDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DUserState1DirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DUserState1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DWeaponUS1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DCloseUS1Click(Sender: TObject; X, Y: Integer);
    procedure DNecklaceUS1DirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DBotGuildClick(Sender: TObject; X, Y: Integer);
    procedure DGuildDlgDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DGDUpClick(Sender: TObject; X, Y: Integer);
    procedure DGDDownClick(Sender: TObject; X, Y: Integer);
    procedure DGDCloseClick(Sender: TObject; X, Y: Integer);
    procedure DGDHomeClick(Sender: TObject; X, Y: Integer);
    procedure DGDListClick(Sender: TObject; X, Y: Integer);
    procedure DGDAddMemClick(Sender: TObject; X, Y: Integer);
    procedure DGDDelMemClick(Sender: TObject; X, Y: Integer);
    procedure DGDEditNoticeClick(Sender: TObject; X, Y: Integer);
    procedure DGDEditGradeClick(Sender: TObject; X, Y: Integer);
    procedure DGECloseClick(Sender: TObject; X, Y: Integer);
    procedure DGEOkClick(Sender: TObject; X, Y: Integer);
    procedure DGuildEditNoticeDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DGDChatClick(Sender: TObject; X, Y: Integer);
    procedure DGoldDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DNewAccountDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DAdjustAbilCloseClick(Sender: TObject; X, Y: Integer);
    procedure DAdjustAbilityDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DBotPlusAbilClick(Sender: TObject; X, Y: Integer);
    procedure DPlusDCClick(Sender: TObject; X, Y: Integer);
    procedure DMinusDCClick(Sender: TObject; X, Y: Integer);
    procedure DAdjustAbilOkClick(Sender: TObject; X, Y: Integer);
    procedure DBotPlusAbilDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DAdjustAbilityMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DUserState1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DEngServer1Click(Sender: TObject; X, Y: Integer);
    procedure DGDAllyClick(Sender: TObject; X, Y: Integer);
    procedure DGDBreakAllyClick(Sender: TObject; X, Y: Integer);
    procedure DSelServerDlgDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DBotMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DChgGamePwdCloseClick(Sender: TObject; X, Y: Integer);
    procedure DChgGamePwdDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DButtonShopDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DShopDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DJewelryDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DShopExitClick(Sender: TObject; X, Y: Integer);
    procedure DJewelryClick(Sender: TObject; X, Y: Integer);
    procedure DMedicineClick(Sender: TObject; X, Y: Integer);
    procedure DEnhanceClick(Sender: TObject; X, Y: Integer);
    procedure DfriendClick(Sender: TObject; X, Y: Integer);
    procedure DLimitClick(Sender: TObject; X, Y: Integer);
    procedure DBottomMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DShopIntroduceDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DPrevShopClick(Sender: TObject; X, Y: Integer);
    procedure DNextShopClick(Sender: TObject; X, Y: Integer);
    procedure DShopBuyClick(Sender: TObject; X, Y: Integer);
    procedure DButtonReCallHeroDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DButFunc1DirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DButFunc1Click(Sender: TObject; X, Y: Integer);

    procedure DHeroHealthStateWinDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DHeroStateWinDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DCloseHeroStateDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DHeroSWLightDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DHeroSWWeaponMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DHeroSWWeaponClick(Sender: TObject; X, Y: Integer);
    procedure DHeroItemBagDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DCloseHeroBagClick(Sender: TObject; X, Y: Integer);
    procedure DHeroItemGridDblClick(Sender: TObject);
    procedure DHeroItemGridGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DHeroItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TTexture);
    procedure DHeroItemGridGridMouseMove(Sender: TObject; ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DButtonReCallHeroClick(Sender: TObject; X, Y: Integer);
    procedure DButtonHeroStateClick(Sender: TObject; X, Y: Integer);
    procedure DButtonHeroBagClick(Sender: TObject; X, Y: Integer);
    procedure DCloseHeroStateClick(Sender: TObject; X, Y: Integer);
    procedure DCloseHeroBagDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DPrevHeroStateClick(Sender: TObject; X, Y: Integer);
    procedure DNextHeroStateClick(Sender: TObject; X, Y: Integer);
    procedure DHeroStMag1DirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DHeroStPageUpClick(Sender: TObject; X, Y: Integer);
    procedure DHeroStateWinMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DHeroHealthStateWinClick(Sender: TObject; X, Y: Integer);
    procedure DFirDragonDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DSearchSellOffDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DUserSellOffDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DPrevSellDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DBuySellItemDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DCloseSellClick(Sender: TObject; X, Y: Integer);
    procedure DUserSellOffClick(Sender: TObject; X, Y: Integer);
    procedure DPrevSellClick(Sender: TObject; X, Y: Integer);
    procedure DRefreshSellClick(Sender: TObject; X, Y: Integer);
    procedure DNextSellClick(Sender: TObject; X, Y: Integer);
    procedure DSearchSellOffClick(Sender: TObject; X, Y: Integer);
    procedure DBuySellItemClick(Sender: TObject; X, Y: Integer);
    procedure DPrevSellMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DUserSellOffMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBoxItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TTexture);
    procedure DBoxItemsDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DItemBoxDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DBoxItemGridDblClick(Sender: TObject);
    procedure DBoxItemGridGridMouseMove(Sender: TObject; ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DOnHouserClick(Sender: TObject; X, Y: Integer);
    procedure DHelpClick(Sender: TObject; X, Y: Integer);
    procedure DBoxItemsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DUserSellOffMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBookCloseDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DBookPageDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DBookPrevPageClick(Sender: TObject; X, Y: Integer);
    procedure DBookNextPageClick(Sender: TObject; X, Y: Integer);
    procedure DBookNextPageDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DBookDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DBookCloseClick(Sender: TObject; X, Y: Integer);
    procedure DFindOKDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DFindChrCloseClick(Sender: TObject; X, Y: Integer);
    procedure DFindChrClick(Sender: TObject; X, Y: Integer);
    procedure DFindChrDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DFindOKClick(Sender: TObject; X, Y: Integer);
    procedure DBookNextPageInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DOpenUpgradeClick(Sender: TObject; X, Y: Integer);
    procedure DCloseUpgradeClick(Sender: TObject; X, Y: Integer);
    procedure DUpgradeItem1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DUpgradeItem1Click(Sender: TObject; X, Y: Integer);
    procedure DUpgradeItem1DirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DUpgradeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DItemBagMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DOpenUpgradeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DStartUpgradeClick(Sender: TObject; X, Y: Integer);
    procedure DStartUpgradeMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DButtonDuelClick(Sender: TObject; X, Y: Integer);
    procedure DDRDuelGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TTexture);
    procedure DDDuelGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TTexture);
    procedure DWDuelDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DDRDuelGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DDDuelGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DDDuelGridGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DDDuelGoldClick(Sender: TObject; X, Y: Integer);
    procedure DDuelCloseClick(Sender: TObject; X, Y: Integer);
    procedure DWDuelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DItemBoxDblClick(Sender: TObject);
    procedure DItemBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DGetBoxItemFlashDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DHeroItemBagMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

    procedure DShopItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TTexture);
    procedure DSuperShopItemGridGridPaint(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TTexture);
    procedure DShopItemGridGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DSuperShopItemGridGridSelect(Sender: TObject; ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DShopItemGridGridMouseMove(Sender: TObject; ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DHumManSortMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DShopMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DMiniMapDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DMiniMapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DHeroHealthStateWinMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure DMiniMapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DMapTitleDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DButtonOption1Click(Sender: TObject; X, Y: Integer);
    procedure DEdChatClick(Sender: TObject; X, Y: Integer);
    procedure DButtonOption1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DButtonOption2Click(Sender: TObject; X, Y: Integer);
    procedure DPlayToolClick(Sender: TObject; X, Y: Integer);
    procedure DCategorizeSysClick(Sender: TObject; X, Y: Integer);
    procedure DCategorizeSysDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DShowChatClick(Sender: TObject; X, Y: Integer);
    procedure DEdChatDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DEdChatInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DShowChatMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DEdChatMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DListBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure DButtonShopClick(Sender: TObject; X, Y: Integer);
    procedure DDuelOKClick(Sender: TObject; X, Y: Integer);
    procedure DDDuelGoldMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure EdSearchKeyPress(Sender: TObject; var Key: Char);
    procedure DStoreOpenDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DStoreCloseClick(Sender: TObject; X, Y: Integer);
    procedure DStoreMsgDlgOkClick(Sender: TObject; X, Y: Integer);
    procedure DStoreMsgDlgDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure EdStoreDlgEditKeyPress(Sender: TObject; var Key: Char);
    procedure DStoreDlgClick(Sender: TObject; X, Y: Integer);
    procedure DUserStoreClick(Sender: TObject; X, Y: Integer);
    procedure DUserStoreCloseClick(Sender: TObject; X, Y: Integer);
    procedure DGStoreGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TTexture);
    procedure DGStoreGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DGStoreGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DGUserStoreGridMouseMove(Sender: TObject; ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DGUserStoreGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TTexture);
    procedure DStoreDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DUserStoreMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DStoreDlgDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DUserStoreDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DStoreOpenClick(Sender: TObject; X, Y: Integer);
    procedure DStoreCancelClick(Sender: TObject; X, Y: Integer);
    procedure DGUserStoreGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DUserStoreBuyClick(Sender: TObject; X, Y: Integer);
    procedure DStoreMsgDlgClick(Sender: TObject; X, Y: Integer);
    procedure DMainMenuClick(Sender: TObject; X, Y: Integer);
    procedure EdIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdPasswdKeyPress(Sender: TObject; var Key: Char);
    procedure EdChatKeyPress(Sender: TObject; var Key: Char);
    procedure EdDlgEditKeyPress(Sender: TObject; var Key: Char);
    procedure EdChatMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DGetBoxItemFlashMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure DGetBoxItemMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DGetBoxItemFlashClick(Sender: TObject; X, Y: Integer);
    procedure DWRandomCodeDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DBRandomCodeOKClick(Sender: TObject; X, Y: Integer);
    procedure DBRandomCodeChgClick(Sender: TObject; X, Y: Integer);
    procedure DSWWeaponDblClick(Sender: TObject);
    procedure EdChatMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DMerchantDlgInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DAdjustAbilOkDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DPlusSCDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DMinusSCDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DMerchantDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBotCharRankingDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DRankingDlgDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DHeroStMag1Click(Sender: TObject; X, Y: Integer);
    procedure DBotActorRankingDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DRankingDlgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBotCharRankingClick(Sender: TObject; X, Y: Integer);
    procedure DBotActorRankingClick(Sender: TObject; X, Y: Integer);
    procedure DBotRankingCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBotRankingHomeClick(Sender: TObject; X, Y: Integer);
    procedure DBotRankingUpClick(Sender: TObject; X, Y: Integer);
    procedure DBotRankingDownClick(Sender: TObject; X, Y: Integer);
    procedure DBotRankingLastClick(Sender: TObject; X, Y: Integer);
    procedure DBotRankingSelfClick(Sender: TObject; X, Y: Integer);
    procedure DRankingClick(Sender: TObject; X, Y: Integer);
    procedure DScrollScrollDirectPaint(Sender: TObject; dsurface: TTexture);
    procedure DScrollCenterScrollDirectPaint(Sender: TObject; dsurface: TTexture);


    procedure DMemoChatClick(Sender: TObject; X, Y: Integer);
    procedure DChatDlgClick(Sender: TObject; X, Y: Integer);
    procedure DMemoChatMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DButtonTab1DirectPaint(Sender: TObject; dsurface: TTexture);
    procedure DButtonTab1Click(Sender: TObject; X, Y: Integer);
    procedure DEditSearchItemDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DConfigDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBookPageInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DLabelHeroCallHeroDirectPaint(Sender: TObject;
      dsurface: TTexture);
    procedure DLabelHeroCallHeroKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DLabelHeroCallHeroMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DMemoChatMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DMemoChatDirectPaint(Sender: TObject; dsurface: TTexture);
    procedure DComboboxItemTypeChange(Sender: TObject);
    procedure DLabelOptionClick(Sender: TObject; X, Y: Integer);
    procedure DCheckBoxShowActorLableClick(Sender: TObject; X, Y: Integer);
    procedure DEditSpecialHPChange(Sender: TObject);
    procedure DComboboxBookIndexChange(Sender: TObject);
    procedure DComboboxAutoUseMagicChange(Sender: TObject);
    procedure DComboboxPoisonChange(Sender: TObject);
    procedure DConfigDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DEdChatMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DConfigDlgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DCheckBoxMusicClick(Sender: TObject; X, Y: Integer);
    procedure DscStartInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DEditSearchItemChange(Sender: TObject);
    procedure DChatDlgDirectPaint(Sender: TObject; dsurface: TTexture);
    procedure EdSearchDirectPaint(Sender: TObject; dsurface: TTexture);
    procedure DItemLockClick(Sender: TObject; X, Y: Integer);
    procedure DMerchantBigDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DSerieMagic1DirectPaint(Sender: TObject; dsurface: TTexture);
    procedure DSerieMagic1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DSerieMagicMenuClick(Sender: TObject; X, Y: Integer);
    procedure DEditSerieMagicClick(Sender: TObject; X, Y: Integer);
    procedure DSerieMagic1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DComboboxBookIndexPopup(Sender: TObject);
    procedure DEditRandomCodeKeyPress(Sender: TObject; var Key: Char);
    procedure DEditAdjustIncrementChange(Sender: TObject);
    procedure DComboboxHeroHP1Change(Sender: TObject);
    procedure DComboboxHeroMP1Change(Sender: TObject);
    procedure DComboboxHeroHP2Change(Sender: TObject);
    procedure DComboboxHeroMP2Change(Sender: TObject);
    procedure DComboboxHumHP1Change(Sender: TObject);
    procedure DComboboxHumMP1Change(Sender: TObject);
    procedure DComboboxHumHP2Change(Sender: TObject);
    procedure DComboboxHumMP2Change(Sender: TObject);
  private
    DlgTemp: TList;
    magcur, magtop: Integer;
    Heromagcur, Heromagtop: Integer;
    //EdDlgEdit: TEdit;
    Memo: TMemo;

    ViewDlgEdit: Boolean;
    msglx, msgly: Integer;
    MenuTop: Integer;

    MagKeyIcon, MagKeyCurKey: Integer;
    MagKeyMagName: string;
    MagicPage: Integer;

    AbilPage: Integer;

    HeroMagicPage: Integer;
    BlinkTime: LongWord;
    BlinkCount: Integer;
    GameOptionPage: Integer;

    //UseNpcLabel: Boolean;

    m_btSelectShop: Byte;

    PlayerFullScreen: Boolean;

    RankingPage: Integer;
    RankingSelectLine: Integer;

    ChatDlgLeft: Integer;
    procedure HideAllControls;
    procedure RestoreHideControls;
    procedure PageChanged;
    procedure HeroPageChanged;
    procedure DealItemReturnBag(mitem: TClientItem);
    procedure DealZeroGold;

    procedure SuperShopItemPrev;
    procedure SuperShopItemNext;

    procedure ChgShopSelButton(nType: Integer);
    procedure DuelItemReturnBag(mitem: TClientItem);

    procedure NpcLabelClick(Sender: TObject; X, Y: Integer);
    procedure CharMove(X: Integer);

    procedure RankingPageChanged(Sender: TObject);

    procedure DItemLabelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DItemLabelClick(Sender: TObject; X, Y: Integer);


  public
    StatePage: Integer;
    HeroStatePage: Integer;
    ShopTabPage: Integer;
    ShopPage: array[0..5] of Integer;
    ShopPageCount: Integer;
    SortStatePage: Integer;
    PlayJobSortStatePage: Integer;
    HeroJobSortStatePage: Integer;
    SortPage: Integer;
    SortPageCount: Integer;
    MsgText: string;
    DialogSize: Integer;
    {
    m_n66C:Integer;
    m_n688:Integer;
    m_n6A4:Integer;
    m_n6A8:Integer;
    }
//    m_Dicea:array[0..35] of Integer;

    m_nDiceCount: Integer;
    m_boPlayDice: Boolean;
    m_Dice: array[0..9] of TDiceInfo;

    MerchantName: string;
    MerchantFace: Integer;
    MDlgStr: string;
    MDlgPoints: TList;
    RequireAddPoints: Boolean;
    SelectMenuStr: string;
    LastestClickTime: LongWord;
    SpotDlgMode: TSpotDlgMode;

    MenuList: TList; //list of PTClientGoods
    menuindex: Integer;
    SellItemIndex: Integer;
    MoveSellItemIndex: Integer;
    CurDetailItem: string;
    MenuTopLine: Integer;
    BoDetailMenu: Boolean;
    BoStorageMenu: Boolean;
    BoNoDisplayMaxDura: Boolean;
    BoMakeDrugMenu: Boolean;
    NAHelps: TStringList;
    NewAccountTitle: string;

    DlgEditText: string;
    StoreDlgEditText: string;
    UserState1: TUserStateInfo;

    Guild: string;
    GuildFlag: string;
    GuildCommanderMode: Boolean;
    GuildStrs: TStringList;
    GuildStrs2: TStringList;
    GuildNotice: TStringList;
    GuildMembers: TStringList;
    GuildTopLine: Integer;
    GuildEditHint: string;
    GuildChats: TStringList;
    BoGuildChat: Boolean;

    HintList: TStringList;

    SelItemLabel: TDLabel;
    Initialized: Boolean;
    EdChatVisible: Boolean;
    //procedure Paint; override;

    procedure DDCheckBoxHintClick(Sender: TObject; X, Y: Integer);
    procedure DDCheckBoxPickupClick(Sender: TObject; X, Y: Integer);
    procedure DDCheckBoxShowNameClick(Sender: TObject; X, Y: Integer);

    procedure Initialize;
    procedure OpenMyStatus;
    procedure OpenUserState(UserState: TUserStateInfo);
    procedure OpenItemBag;
    procedure ViewBottomBox(Value: Boolean);
    procedure CancelItemMoving;
    procedure DropMovingItem;
    procedure OpenAdjustAbility;

    procedure ShowSelectServerDlg;
    function DMessageDlg(msgstr: string; DlgButtons: TMsgDlgButtons): TModalResult;


    procedure DNpcLabelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure GetMerchantSayLabel(sData: string; nRecogID: Integer);
    procedure ShowMDlg(face: Integer; mname, msgstr: string);
    procedure ShowGuildDlg;
    procedure ShowGuildEditNotice;
    procedure ShowGuildEditGrade;

    procedure ResetMenuDlg;
    procedure ShowShopMenuDlg;
    procedure ShowShopSellDlg;
    procedure CloseDSellDlg;
    procedure CloseMDlg;
    procedure CloseBigMDlg;
    procedure ToggleShowGroupDlg;
    procedure OpenDealDlg;
    procedure CloseDealDlg;

    procedure OpenFriendDlg;

    procedure SoldOutGoods(itemserverindex: Integer);
    procedure DelStorageItem(itemserverindex: Integer);

    procedure GetMouseItemInfo(Actor: TActor; MouseItem: pTClientItem; var iname, line1, line2, line3: string; var useable: Boolean);

    procedure SetMagicKeyDlg(icon: Integer; magname: string; var curkey: Word);
    procedure AddGuildChat(Str: string);

    procedure OpenShopDlg;
    procedure OpenHeroHealthState;
    procedure CloseHeroAllWindows;
    procedure DOptionClick();

    procedure OpenSellOffDlg;
    procedure CloseSellOffDlg;

    procedure OpenStoreDlg;
    procedure CloseStoreDlg;

    procedure OpenUserStoreDlg;
    procedure CloseUserStoreDlg;

    procedure SetBookType(nType: Integer);
    procedure OpenDuelDlg;
    procedure CloseDuelDlg;
    procedure SetButVisible(Value: Boolean);
    procedure SetInputVisible(Value: Boolean);
    procedure SetChatVisible(Value: Boolean);

    function DStoreMessageDlg(): TModalResult;

    procedure ShowRandomDlg;
    procedure CloseRandomDlg;

    function AddMemoChat(Str: string; FColor, BColor: Integer): string;
    procedure SetConfigDlg();
  end;


var
  FrmDlg: TFrmDlg;

implementation

uses
  ClMain, MShare, PlugIn;

{$R *.DFM}

function GetAddPoint(AddPoint: TValue): Boolean;
begin
  Result := (AddPoint[3] > 0) or (AddPoint[4] > 0) or (AddPoint[5] > 0) or (AddPoint[6] > 0) or
    (AddPoint[7] > 0) or (AddPoint[8] > 0) or (AddPoint[9] > 0) or (AddPoint[10] > 0) or (AddPoint[11] > 0) or (AddPoint[12] > 0) or (AddPoint[13] > 0);
end;

constructor TNpcLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  m_nColorPosition := -1;
  m_nRecogId := -1;
  //m_sClickString := '';
  m_ColorList := TList.Create;
end;

destructor TNpcLabel.Destroy;
begin
  m_ColorList.Free;
  inherited;
end;

procedure TNpcLabel.AddColor(btColor: Byte);
begin
  m_ColorList.Add(Pointer(btColor));
end;

procedure TNpcLabel.Process;
begin
  inherited;
  if GetTickCount - m_dwChgColorTick > 500 then begin
    m_dwChgColorTick := GetTickCount;
    if m_ColorList.Count > 0 then begin
      if (m_nColorPosition >= 0) and (m_nColorPosition < m_ColorList.Count) then begin
        UpColor := GetRGB(Integer(m_ColorList.Items[m_nColorPosition]));
        Inc(m_nColorPosition);
      end else begin
        m_nColorPosition := 0;
      end;
    end;
  end;
end;

constructor TItemLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FillChar(FClientItem, SizeOf(TClientItem), #0);
  FClientItem.s.Name := '';
  FClickTimeTick := GetTickCount;
  FGetClientItem := True;
end;

destructor TItemLabel.Destroy;
begin
  inherited;
end;

procedure TItemLabel.DirectPaint(dsurface: TTexture);
var
  d: TTexture;
begin
  inherited DirectPaint(dsurface);
  {if (FClientItem.s.Name <> '') then begin
    if (FClientItem.s.AddValue[12] in [1, 3]) or (GetAddPoint(FClientItem.s.AddPoint)) then begin
      if GetTickCount - FEffectTick[0].dwDrawTick >= 200 then begin
        FEffectTick[0].dwDrawTick := GetTickCount;
        if FEffectTick[0].nIndex <= 0 then FEffectTick[0].nIndex := 260 - 1;
        Inc(FEffectTick[0].nIndex);
        if FEffectTick[0].nIndex > 265 then FEffectTick[0].nIndex := 260;
      end;
      d := g_WMain2Images.Images[FEffectTick[0].nIndex];
      if d <> nil then begin
        DrawBlend(dsurface, SurfaceX(Left) - Width div 2, SurfaceY(Top) - Height div 2, d);
      end;
    end;

    if FClientItem.s.AddValue[12] >= 2 then begin
      if GetTickCount - FEffectTick[1].dwDrawTick >= 200 then begin
        FEffectTick[1].dwDrawTick := GetTickCount;
        if FEffectTick[1].nIndex <= 0 then FEffectTick[1].nIndex := 600 - 1;
        Inc(FEffectTick[1].nIndex);
        if FEffectTick[1].nIndex > 617 then FEffectTick[1].nIndex := 600;
      end;
      d := g_WMain3Images.Images[FEffectTick[1].nIndex];
      if d <> nil then begin
        DrawBlend(dsurface, SurfaceX(Left) - Width div 2, SurfaceY(Top) - Height div 2, d);
      end;
    end;
  end;}
end;

procedure TItemLabel.Process;
begin

end;

procedure TFrmDlg.NpcLabelClick(Sender: TObject; X, Y: Integer);
var
  sMsg, Str, sClickString: string;
  nCode: Integer;
begin
  //ShowMessage('TFrmDlg.NpcLabelClick:' + m_sClickString);
  //ShowMessage('TFrmDlg.NpcLabelClick:' + TNpcLabel(Sender).m_sClickString);
  nCode := 0;
  try
    if GetTickCount < LastestClickTime then Exit;
    LastestClickTime := GetTickCount + 3000;
    nCode := 1;
    sClickString := TNpcLabel(Sender).Text;
    nCode := 2;
    PlaySound(s_glass_button_click);
    if Pos('@http://', sClickString) > 0 then begin
      sMsg := Copy(sClickString, 2, Length(sClickString) - 1);
      g_sCurMerchantSay := '';
      g_nDownWorkCount := 0;
      g_nDownWorkCountMax := 0;
      g_sMerchantReadAddr := Trim(sMsg);
      CloseMDlg;
      ShowMDlg(g_nCurMerchantFace, g_sCurMerchantName, '正在读取数据，请稍候...');
      frmMain.HTTPGetString.URL := g_sMerchantReadAddr;
      frmMain.HTTPGetString.GetString;
    end else
      if Pos('@rmst://', sClickString) > 0 then begin
      sMsg := Copy(sClickString, 9, Length(sClickString) - 8);
      sMsg := GetValidStr3(sMsg, Str, ['|']);
      if (sMsg <> '') and (Str <> '') then begin
        g_boStartPlayMedia := False;
        g_nWaiteTime := 0;
        g_sSongName := Str;
        g_sDownSongAddr := sMsg;

        if Assigned(g_PlugInfo.MediaPlayer.Player) then begin
          g_PlugInfo.MediaPlayer.Player(PChar(g_sDownSongAddr), False, True);
        end;

      end;

    end else
      if Pos('@Media://', sClickString) > 0 then begin
      sMsg := Copy(sClickString, 10, Length(sClickString) - 9);
      if Assigned(g_PlugInfo.MediaPlayer.Player) then begin
        g_PlugInfo.MediaPlayer.Player(PChar(sMsg), True, True);
      end;
    end else begin
      nCode := 3;
      frmMain.SendMerchantDlgSelect(g_nCurMerchant {TNpcLabel(Sender).m_nRecogId}, sClickString);
      nCode := 4;
    end;

  except
    //Showmessage('TFrmDlg.NpcLabelClick Fail:'+IntToStr(nCode));
  end;
end;

procedure TFrmDlg.FormCreate(Sender: TObject);
begin
  Initialized := False;
  StatePage := 0;
  HeroStatePage := 0;
  //ShopPage := 0;
  SafeFillChar(ShopPage, SizeOf(ShopPage), 0);
  ShopPageCount := 0;
  ShopTabPage := 0;
  SortStatePage := 0;
  SortPage := 0;
  SortPageCount := 0;
  PlayJobSortStatePage := 0;
  HeroJobSortStatePage := 0;
  DlgTemp := TList.Create;
  DialogSize := 1;
  m_nDiceCount := 0;
  m_boPlayDice := False;
  magcur := 0;
  magtop := 0;
  Heromagcur := 0;
  Heromagtop := 0;
  MDlgPoints := TList.Create;
  SelectMenuStr := '';
  MenuList := TList.Create;
  menuindex := -1;
  SellItemIndex := -1;
  MoveSellItemIndex := -1;
  MenuTopLine := 0;
  BoDetailMenu := False;
  BoStorageMenu := False;
  BoNoDisplayMaxDura := False;
  BoMakeDrugMenu := False;
  MagicPage := 0;
  AbilPage := 0;
  HeroMagicPage := 0;
  NAHelps := TStringList.Create;
  BlinkTime := GetTickCount;
  BlinkCount := 0;
  GameOptionPage := 0;
  g_SellDlgItem.s.Name := '';
  Guild := '';
  GuildFlag := '';
  GuildCommanderMode := False;
  GuildStrs := TStringList.Create;
  GuildStrs2 := TStringList.Create;
  GuildNotice := TStringList.Create;
  GuildMembers := TStringList.Create;
  GuildChats := TStringList.Create;
  HintList := TStringList.Create;

  PlayerFullScreen := False;

  RankingSelectLine := -1;
  ChatDlgLeft := 0;
 { EdDlgEdit := TEdit.Create(frmMain.Owner);
  with EdDlgEdit do begin
    Parent := frmMain;
    Color := clblack;
    Font.Color := clWhite;
    Font.Size := 10;
    MaxLength := 200;
    Height := 16;
    Ctl3D := False;
    BorderStyle := bsSingle;
    Visible := False;
  end;  }

  Memo := TMemo.Create(frmMain.Owner);
  with Memo do begin
    Parent := frmMain;
    Color := clblack;
    Font.Color := clWhite;
    Font.Size := 10;
    Ctl3D := False;
    BorderStyle := bsSingle; {OnKeyPress := EdDlgEditKeyPress;}
    Visible := False;
  end;
  //UseNpcLabel := True;
  SelItemLabel := nil;
end;

procedure TFrmDlg.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  DlgTemp.Free;
  MDlgPoints.Free;
  MenuList.Free;
  NAHelps.Free;
  GuildStrs.Free;
  GuildStrs2.Free;
  GuildNotice.Free;
  GuildMembers.Free;
  GuildChats.Free;
  HintList.Free;
end;

{procedure TFrmDlg.Paint;
begin
  //if csDesigning in ComponentState then begin
    inherited;
  //end;
end;   }

procedure TFrmDlg.HideAllControls;
var
  I: Integer;
  c: TControl;
begin
  DlgTemp.Clear;
  with frmMain do
    for I := 0 to ControlCount - 1 do begin
      c := Controls[I];
      if c is TEdit then
        if (c.Visible) and (c <> EdDlgEdit) then begin
          DlgTemp.Add(c);
          c.Visible := False;
        end;
    end;
end;

procedure TFrmDlg.RestoreHideControls;
var
  I: Integer;
  c: TControl;
begin
  for I := 0 to DlgTemp.Count - 1 do begin
    TControl(DlgTemp[I]).Visible := True;
  end;
end;

procedure TFrmDlg.SetBookType(nType: Integer);
var
  d: TTexture;
begin
  DBook.Visible := False;
  g_nBookType := nType;
  g_nBookPage := 0;

  d := nil;
  if g_nBookType = 0 then begin
    d := g_WUIBImages.Images[0];
    if d <> nil then begin
      DBook.SetImgIndex(g_WUIBImages, 0);
      DBook.Left := (SCREENWIDTH - d.Width) div 2;
      DBook.Top := (SCREENHEIGHT - d.Height) div 2 - 90;
    end;
  end else begin
    d := g_WBookImages.Images[g_nBookType + 6];
    if d <> nil then begin
      DBook.SetImgIndex(g_WBookImages, g_nBookType + 6);
      DBook.Left := (SCREENWIDTH - d.Width) div 2;
      DBook.Top := (SCREENHEIGHT - d.Height) div 2 - 90;
    end;
  end;

  d := g_WUIBImages.Images[1];
  if d <> nil then begin
    if g_nBookType = 0 then begin
      DBookClose.Left := DBook.Width - d.Width - 3;
      DBookClose.Top := 0;
    end else begin
      DBookClose.Left := DBook.Width - d.Width;
      DBookClose.Top := 0;
    end;
  end;

  if g_nBookPage = 4 then begin
    d := g_WBookImages.Images[5];
    if d <> nil then begin
      DBookNextPage.SetImgIndex(g_WUIBImages, 5);
      DBookNextPage.Left := 470 - d.Width;
      DBookNextPage.Top := 318;
    end;
  end else begin
    d := g_WUIBImages.Images[3];
    if d <> nil then begin
      DBookNextPage.SetImgIndex(g_WUIBImages, 3);
      DBookNextPage.Left := 470 - d.Width;
      DBookNextPage.Top := 318;
    end;
  end;

  case nType of
    0: begin
        DBookPrevPage.Visible := False;
        DBookNextPage.Visible := True;
        DBookPage.Visible := True;
      end;
  else begin
      DBookPrevPage.Visible := False;
      DBookNextPage.Visible := False;
      DBookPage.Visible := False;
    end;
  end;
  DBook.Visible := True;
end;

procedure TFrmDlg.Initialize;
var
  d: TTexture;
  Res: TResourceStream;

  MemoryStream: TMemoryStream;
  ClientOption: TClientOption;
  ConfigClient: TConfigClient;
  nSize: Integer;
  nCrc: Integer;
  Buffer: Pointer;
  ReadBuffer: PChar;
  sBuffer: string;
  nBuffer: Integer;
  nPos: Integer;


  I, II, nIndex: Integer;
  ItemList: TStringList;
  DLabel: TDLabel;
  sText: string;
begin
  if csDesigning in ComponentState then Exit;
  if Initialized then Exit;

  DComboboxGuajiQunti.Items.Clear;
  DComboboxGuajiGeti.Items.Clear;
  DComboboxAutoUseMagic.Items.Clear;
  DSerieMagicMenu.Clear;

  DWinMan.ClearAll;

  DBackground.Left := 0;
  DBackground.Top := 0;
  DBackground.Width := SCREENWIDTH;
  DBackground.Height := SCREENHEIGHT;
  DBackground.Background := True;

  DWinMan.AddDControl(DBackground, True);
  DWinMan.AddDControl(DMainMenu, False);

  if Assigned(g_PlugInfo.HookGuiInitializeBegin) then begin
    g_PlugInfo.HookGuiInitializeBegin();
  end;

  {g_nTopDrawPos := frmMain.Top + Top;
  g_nLeftDrawPos := frmMain.Left + Left; }


{-------------------------------------------------------------------------------}
  if g_ConfigClient.btMainInterface in [0, 2] then begin //仿盛大
//{$IF SWH = SWH800}
    d := g_WMain3Images.Images[BOTTOMBOARD800];
//{$ELSEIF SWH = SWH1024}
   // d := g_WMain3Images.Images[BOTTOMBOARD800];
//{$IFEND}
    if d <> nil then begin
      DBottom.Left := (SCREENWIDTH - d.Width) div 2;
      DBottom.Top := SCREENHEIGHT - d.Height;
      DBottom.SetImgIndex(g_WMain3Images, 371);
    end;
{-------------------------------------------------------------------------------}

   //底部状态栏的4个快捷按钮
    DMyState.SetImgIndex(g_WMainImages, 8);
    DMyState.Left := DBottom.Width div 2 + (DBottom.Width div 2 - (400 - 243)) {643};
    DMyState.Top := 61;
    DMyBag.SetImgIndex(g_WMainImages, 9);
    DMyBag.Left := DBottom.Width div 2 + (DBottom.Width div 2 - (400 - 282)) {682};
    DMyBag.Top := 41;
    DMyMagic.SetImgIndex(g_WMainImages, 10);
    DMyMagic.Left := DBottom.Width div 2 + (DBottom.Width div 2 - (400 - 322)) {722};
    DMyMagic.Top := 21;
    DVoice.SetImgIndex(g_WMainImages, 11);
    DVoice.Left := DBottom.Width div 2 + (DBottom.Width div 2 - (400 - 364)) {764};
    DVoice.Top := 11;

  {-----------------------------商铺按钮（Mars）----------------------}
    DButtonShop.SetImgIndex(g_WMain3Images, 297);
    DButtonShop.Left := DBottom.Width - 45;
    DButtonShop.Top := 204;

  {-----------------------------英雄按钮（Mars）----------------------}
    DButtonReCallHero.SetImgIndex(g_WMain3Images, 372);
    DButtonReCallHero.Left := 638;
    DButtonReCallHero.Top := 107;

    DButtonHeroState.SetImgIndex(g_WMain3Images, 373);
    DButtonHeroState.Left := DButtonReCallHero.Left + DButtonReCallHero.Width + 6;
    DButtonHeroState.Top := 107;

    DButtonHeroBag.SetImgIndex(g_WMain3Images, 374);
    DButtonHeroBag.Left := DButtonHeroState.Left + DButtonHeroState.Width + 6 + 1;
    DButtonHeroBag.Top := 107; ;

    d := g_WMain3Images.Images[410];
    if d <> nil then begin
      DFirDragon.Left := DBottom.Width - 197;
      DFirDragon.Top := 86;
      DFirDragon.SetImgIndex(g_WMain3Images, 410);
      DFirDragon.Visible := False;
    end;

  //底部状态栏的小地图、交易、行会、组按钮
    DBotMiniMap.SetImgIndex(g_WMainImages, 130);
    DBotMiniMap.Left := 219;
    DBotMiniMap.Top := 104;
    DBotTrade.SetImgIndex(g_WMainImages, 132);
    DBotTrade.Left := 219 + 30; //560 - 30;
    DBotTrade.Top := 104;
    DBotGuild.SetImgIndex(g_WMainImages, 134);
    DBotGuild.Left := 219 + 30 * 2;
    DBotGuild.Top := 104;
    DBotGroup.SetImgIndex(g_WMainImages, 128);
    DBotGroup.Left := 219 + 30 * 3;
    DBotGroup.Top := 104;
    DButtonFriend.SetImgIndex(g_WMain3Images, 34); //关系系统
    DButtonFriend.Left := 219 + 30 * 4;
    DButtonFriend.Top := 104;
    DButtonDuel.SetImgIndex(g_WMain3Images, 36); //挑战
    DButtonDuel.Left := 219 + 30 * 5;
    DButtonDuel.Top := 104;
    DRanking.SetImgIndex(g_WMain3Images, 460); //人物排行
    DRanking.Left := 219 + 30 * 6;
    DRanking.Top := 104;

    DOnHouser.SetImgIndex(g_WCqFirImages, 58); //骑马
    DOnHouser.Left := 219 + 30 * 7;
    DOnHouser.Top := 104;

    DHelp.SetImgIndex(g_WCqFirImages, 56); //帮助
    DHelp.Left := 219 + 30 * 8;
    DHelp.Top := 104;

    DBotPlusAbil.SetImgIndex(g_WMainImages, 218);
    DBotPlusAbil.Left := 219 + 30 * 9;
    DBotPlusAbil.Top := 104;

    DBotMemo.SetImgIndex(g_WMainImages, 532);
    DBotMemo.Left := 753;
    DBotMemo.Top := 204;

    DBotExit.SetImgIndex(g_WMainImages, 138);
    DBotExit.Left := 560;
    DBotExit.Top := 104;

    DBotLogout.SetImgIndex(g_WMainImages, 136);
    DBotLogout.Left := 560 - 30;
    DBotLogout.Top := 104;

    DButFunc1.SetImgIndex(g_WMain3Images, 280);
    DButFunc1.Left := 176;
    DButFunc1.Top := 120;

    DButFunc2.SetImgIndex(g_WMain3Images, 282);
    DButFunc2.Left := 176;
    DButFunc2.Top := DButFunc1.Top + 25;

    DButFunc3.SetImgIndex(g_WMain3Images, 284);
    DButFunc3.Left := 176;
    DButFunc3.Top := DButFunc1.Top + 25 * 2;

    DButFunc4.SetImgIndex(g_WMain3Images, 286);
    DButFunc4.Left := 176;
    DButFunc4.Top := DButFunc1.Top + 25 * 3;

    DButFunc5.SetImgIndex(g_WMain3Images, 288);
    DButFunc5.Left := 176;
    DButFunc5.Top := DButFunc1.Top + 25 * 4;
    DButFunc5.Downed := True; //是按钮处于摁住状态

  {-----------------------------------------------------------}

  //Belt 快捷栏
    DBelt1.Left := DBottom.Width div 2 - 115; //285;
    DBelt1.Width := 32;
    DBelt1.Top := 59;
    DBelt1.Height := 29;

    DBelt2.Left := DBelt1.Left + 43; //328;
    DBelt2.Width := 32;
    DBelt2.Top := 59;
    DBelt2.Height := 29;

    DBelt3.Left := DBelt2.Left + 43; //371;
    DBelt3.Width := 32;
    DBelt3.Top := 59;
    DBelt3.Height := 29;

    DBelt4.Left := DBelt3.Left + 43; //415;
    DBelt4.Width := 32;
    DBelt4.Top := 59;
    DBelt4.Height := 29;

    DBelt5.Left := DBelt4.Left + 43; //459;
    DBelt5.Width := 32;
    DBelt5.Top := 59;
    DBelt5.Height := 29;

    DBelt6.Left := DBelt5.Left + 43; //503;
    DBelt6.Width := 32;
    DBelt6.Top := 59;
    DBelt6.Height := 29;

  {-----------------------------------------------------------}
  //英雄
    d := g_WMain3Images.Images[385];
    if d <> nil then begin
      DHeroHealthStateWin.SetImgIndex(g_WMain3Images, 385);
      DHeroHealthStateWin.Left := 5;
      DHeroHealthStateWin.Top := 5;
    end;


    DPlayTool.Visible := False;
    DButtonOption1.Visible := False;
    DButtonOption2.Visible := False;
    DButOther.Visible := False;
    DMapTitle.Visible := False;
    DCategorizeSys.Visible := False;
    DCategorizeGuild.Visible := False;
    DCategorizeGroup.Visible := False;
    DCategorizePrivate.Visible := False;
    DShowChat.Visible := False;

{-------------------------------------------------------------------------------}

    DChatDlg.Left := 208;
    DChatDlg.Top := 120; //SCREENHEIGHT - 251 + 118;
    DChatDlg.Width := 388;
    DChatDlg.Height := 126;
    DChatDlg.DParent := DBottom;
    DChatDlg.Floating := False;

    DMemoChat.Left := 0;
    DMemoChat.Top := 0;
    DMemoChat.Width := 388;
    DMemoChat.Height := 12 * 9;
    DMemoChat.SpareSize := DMemoChat.Height - 12 * 2;

    EdChat.Left := 0;
    EdChat.Top := 12 * 9 + 4;
    EdChat.Width := 388;
    EdChat.Height := 16;
    EdChat.DParent := DChatDlg;
    EdChat.Visible := False;
    EdChat.Text := '';
    EdChat.SelTextFontColor := clWhite;


    DScrollChat.SetImgIndex(g_WMain2Images, 291);
    DScrollChat.LeftButton.SetImgIndex(g_WMain2Images, 292);
    DScrollChat.RightButton.SetImgIndex(g_WMain2Images, 294);
    DScrollChat.CenterButton.SetImgIndex(g_WMain2Images, 581);

    DScrollChat.LeftButton.OnDirectPaint := DScrollScrollDirectPaint;
    DScrollChat.RightButton.OnDirectPaint := DScrollScrollDirectPaint;
    DScrollChat.CenterButton.OnDirectPaint := nil;
    DScrollChat.Left := DMemoChat.Width;
    DScrollChat.Top := -90;
    DScrollChat.Increment := 12;
    DScrollChat.LeftButton.Left := 1;
    DScrollChat.LeftButton.Top := 1;
    DScrollChat.RightButton.Left := 1;
    DScrollChat.RightButton.Top := DScrollChat.Height - DScrollChat.RightButton.Height - 1;
    DScrollChat.CenterButton.Left := 1;
    DScrollChat.CenterButton.Top := DScrollChat.LeftButton.Top + DScrollChat.LeftButton.Height;



    DScrollChat.Left := 0;
    DScrollChat.Top := 0;
    DScrollChat.Width := 0;
    DScrollChat.Height := 0;

    DScrollChat.VisibleScroll := False;

    DShowChat.Visible := False;
  end else begin
    d := g_WCqFirImages.Images[65];
    if d <> nil then begin
      DBottom.Left := (SCREENWIDTH - d.Width) div 2;
      DBottom.Top := SCREENHEIGHT - d.Height;
      DBottom.SetImgIndex(g_WCqFirImages, 65);
    end;
  {-----------------------------------------------------------}

   //底部状态栏的4个快捷按钮

    DMyState.SetImgIndex(g_WCqFirImages, 67); //状态
    DMyState.Left := 440;
    DMyState.Top := 3;

    DMyBag.SetImgIndex(g_WCqFirImages, 66); //包裹
    DMyBag.Left := 440 + 36;
    DMyBag.Top := 3;

    DMyMagic.SetImgIndex(g_WCqFirImages, 68); //魔法
    DMyMagic.Left := 440 + 36 * 2;
    DMyMagic.Top := 3;


    DHelp.SetImgIndex(g_WCqFirImages, 69); //摆摊
    DHelp.Left := 440 + 36 * 3;
    DHelp.Top := 3;
    DHelp.OnDirectPaint := DMyStateDirectPaint;
    DHelp.ClickCount := csGlass;

    DButtonReCallHero.SetImgIndex(g_WCqFirImages, 70); //英雄
    DButtonReCallHero.Left := 440 + 36 * 4;
    DButtonReCallHero.Top := 3;
    DButtonReCallHero.ClickCount := csGlass;

    DButtonShop.Left := 440 + 36 * 5; //607              //商铺
    DButtonShop.Top := 3;
    DButtonShop.SetImgIndex(g_WCqFirImages, 71);
    DButtonShop.ClickCount := csGlass;

    DPlayTool.SetImgIndex(g_WCqFirImages, 72); //影音
    DPlayTool.Left := 440 + 36 * 6;
    DPlayTool.Top := 3;



    DBotLogout.SetImgIndex(g_WCqFirImages, 127);
    DBotLogout.Left := 766;
    DBotLogout.Top := 3;
    DBotLogout.OnDirectPaint := DMyStateDirectPaint;

    DBotExit.SetImgIndex(g_WCqFirImages, 128);
    DBotExit.Left := 766;
    DBotExit.Top := 21;
    DBotExit.OnDirectPaint := DMyStateDirectPaint;

  //英雄
    d := g_WCqFirImages.Images[129];
    if d <> nil then begin
      DHeroHealthStateWin.SetImgIndex(g_WCqFirImages, 129);
      DHeroHealthStateWin.Left := 5;
      DHeroHealthStateWin.Top := 5;
    end;


    DButtonHeroBag.DParent := DHeroHealthStateWin;
    DButtonHeroState.DParent := DHeroHealthStateWin;

    DButtonHeroBag.SetImgIndex(g_WCqFirImages, 134);
    DButtonHeroBag.Left := 59;
    DButtonHeroBag.Top := 44;

    DButtonHeroState.SetImgIndex(g_WCqFirImages, 135);
    DButtonHeroState.Left := 59 + 22;
    DButtonHeroState.Top := 45;



    DFirDragon.Visible := False;
    DButtonDuel.Visible := False;


    DBotMiniMap.DParent := DBackground;
    DOnHouser.DParent := DBackground;
    DBotTrade.DParent := DBackground;
    DBotGuild.DParent := DBackground;
    DBotPlusAbil.DParent := DBackground;
    DButtonFriend.DParent := DBackground;
    DRanking.DParent := DBackground;
    DVoice.DParent := DBackground;
    DVoice.OnDirectPaint := DBotGroupDirectPaint;

    DBotGroup.DParent := DBackground;


  //底部状态栏的小地图、交易、行会、组按钮
    DBotMiniMap.SetImgIndex(g_WCqFirImages, 76);
    DBotMiniMap.Left := DBottom.Width - 23 * 9 - 3 * 8 + DBottom.Left;
    DBotMiniMap.Top := SCREENHEIGHT - 58;


    DBotTrade.SetImgIndex(g_WCqFirImages, 80);
    DBotTrade.Left := DBottom.Width - 23 * 8 - 3 * 7 + DBottom.Left;
    DBotTrade.Top := SCREENHEIGHT - 58;

    DBotGuild.SetImgIndex(g_WCqFirImages, 82);
    DBotGuild.Left := DBottom.Width - 23 * 7 - 3 * 6 + DBottom.Left;
    DBotGuild.Top := SCREENHEIGHT - 58;

    DBotGroup.SetImgIndex(g_WCqFirImages, 143);
    DBotGroup.Left := DBottom.Width - 23 * 6 - 3 * 5 + DBottom.Left;
    DBotGroup.Top := SCREENHEIGHT - 58;

    DOnHouser.SetImgIndex(g_WCqFirImages, 78); //骑马
    DOnHouser.Left := DBottom.Width - 23 * 5 - 3 * 4 + DBottom.Left;
    DOnHouser.Top := SCREENHEIGHT - 58;

    DButtonFriend.SetImgIndex(g_WCqFirImages, 86); //关系系统
    DButtonFriend.Left := DBottom.Width - 23 * 4 - 3 * 3 + DBottom.Left;
    DButtonFriend.Top := SCREENHEIGHT - 58;

    DRanking.SetImgIndex(g_WCqFirImages, 88); //人物排行
    DRanking.Left := DBottom.Width - 23 * 3 - 3 * 2 + DBottom.Left;
    DRanking.Top := SCREENHEIGHT - 58;

    DVoice.SetImgIndex(g_WCqFirImages, 90);
    DVoice.Left := DBottom.Width - 23 * 2 - 3 + DBottom.Left;
    DVoice.Top := SCREENHEIGHT - 58;

    DButOther.SetImgIndex(g_WCqFirImages, 92);
    DButOther.Left := DBottom.Width - 23 * 1 + DBottom.Left;
    DButOther.Top := SCREENHEIGHT - 58;

    DBotPlusAbil.SetImgIndex(g_WCqFirImages, 84);
    DBotPlusAbil.Left := DBottom.Width - 23 * 10 - 3 * 9 + DBottom.Left;
    DBotPlusAbil.Top := SCREENHEIGHT - 58;

    SetButVisible(False);


    DMapTitle.SetImgIndex(g_WCqFirImages, 126);
    DMapTitle.Left := SCREENWIDTH - 139;
    DMapTitle.Top := 0;
    DMapTitle.Height := 17;

    DButFunc1.Visible := False;
    DButFunc2.Visible := False;
    DButFunc3.Visible := False;
    DButFunc4.Visible := False;

    DButFunc5.DParent := DEdChat;

    DButFunc5.SetImgIndex(g_WCqFirImages, 94);
    DButFunc5.Left := 3;
    DButFunc5.Top := 2;

    DButFunc5.Downed := True; //是按钮处于摁住状态

    DCategorizeSys.SetImgIndex(g_WCqFirImages, 106);
    DCategorizeSys.Left := 150;
    DCategorizeSys.Top := 520;

    DCategorizeGuild.SetImgIndex(g_WCqFirImages, 108);
    DCategorizeGuild.Left := 150 + 36;
    DCategorizeGuild.Top := 520;

    DCategorizeGroup.SetImgIndex(g_WCqFirImages, 110);
    DCategorizeGroup.Left := 150 + 36 * 2;
    DCategorizeGroup.Top := 520;

    DCategorizePrivate.SetImgIndex(g_WCqFirImages, 112);
    DCategorizePrivate.Left := 150 + 36 * 3;
    DCategorizePrivate.Top := 520;



    DShowChat.SetImgIndex(g_WCqFirImages, 145);
    DShowChat.Left := 373;
    DShowChat.Top := 2;



  //Belt 快捷栏
    DBelt1.Left := 224;
    DBelt1.Width := 30;
    DBelt1.Top := 4;
    DBelt1.Height := 30;

    DBelt2.Left := 224 + 36;
    DBelt2.Width := 30;
    DBelt2.Top := 4;
    DBelt2.Height := 30;

    DBelt3.Left := 224 + 36 * 2;
    DBelt3.Width := 30;
    DBelt3.Top := 4;
    DBelt3.Height := 30;

    DBelt4.Left := 224 + 36 * 3;
    DBelt4.Width := 30;
    DBelt4.Top := 4;
    DBelt4.Height := 30;

    DBelt5.Left := 224 + 36 * 4;
    DBelt5.Width := 30;
    DBelt5.Top := 4;
    DBelt5.Height := 30;

    DBelt6.Left := 224 + 36 * 5;
    DBelt6.Width := 30;
    DBelt6.Top := 4;
    DBelt6.Height := 30;

     {
  //Belt 快捷栏
    DBelt1.Left := 172;
    DBelt1.Width := 30;
    DBelt1.Top := 10;
    DBelt1.Height := 29;

    DBelt2.Left := DBelt1.Left + 37;
    DBelt2.Width := 30;
    DBelt2.Top := 10;
    DBelt2.Height := 29;

    DBelt3.Left := DBelt2.Left + 37;
    DBelt3.Width := 30;
    DBelt3.Top := 10;
    DBelt3.Height := 29;

    DBelt4.Left := DBelt3.Left + 37;
    DBelt4.Width := 30;
    DBelt4.Top := 10;
    DBelt4.Height := 29;

    DBelt5.Left := DBelt4.Left + 37;
    DBelt5.Width := 30;
    DBelt5.Top := 10;
    DBelt5.Height := 29;

    DBelt6.Left := DBelt5.Left + 37;
    DBelt6.Width := 30;
    DBelt6.Top := 10;
    DBelt6.Height := 29;
      }

    DButtonOption1.SetImgIndex(g_WCqFirImages, 115);
    DButtonOption1.Left := DBelt6.Left + 36 + 1;
    DButtonOption1.Top := 10;

    DButtonOption2.SetImgIndex(g_WCqFirImages, 117);
    DButtonOption2.Left := DBelt6.Left + 36 + 1;
    DButtonOption2.Top := 10 + 18;

    DButtonOption1.Visible := False;
    DButtonOption2.Visible := False;

    DMyState.OnDirectPaint := DButtonShopDirectPaint;
    DMyBag.OnDirectPaint := DButtonShopDirectPaint;
    DMyMagic.OnDirectPaint := DButtonShopDirectPaint;
    DPlayTool.OnDirectPaint := DButtonShopDirectPaint;
    DHelp.OnDirectPaint := DButtonShopDirectPaint;
    DButtonReCallHero.OnDirectPaint := DButtonShopDirectPaint;


    DEdChat.SetImgIndex(g_WCqFirImages, 123);
    DEdChat.Floating := False;
    DEdChat.Left := DBottom.Left;
    DEdChat.Top := SCREENHEIGHT - DEdChat.Height - DBottom.Height;
    DEdChat.DParent := DBackground;

    EdChat.Left := 20;
    EdChat.Top := 3;
    EdChat.Width := 349;
    EdChat.Height := 14;
    EdChat.DParent := DEdChat;
    EdChat.Visible := False;
    EdChat.Text := '';
    EdChat.SelTextColor := $00DC802C;
    EdChat.SelTextFontColor := clWhite;


    DChatDlg.Height := 12 * 9 + 2;
    DChatDlg.Width := DEdChat.Width;
    DChatDlg.Left := DBottom.Left;
    DChatDlg.Top := SCREENHEIGHT - DChatDlg.Height - DEdChat.Height - DBottom.Height; //SCREENHEIGHT - 251 + 118;

    DChatDlg.DParent := DBackground;
    DChatDlg.Floating := False;
    DChatDlg.Visible := False;

    DMemoChat.Left := 2;
    DMemoChat.Top := 2;
    DMemoChat.Width := DChatDlg.Width - 18;
    DMemoChat.Height := 12 * 9;
    DMemoChat.SpareSize := DMemoChat.Height - 12;
    //DMemoChat.Border:=True;

    {DScrollChat.SetImgIndex(g_WMain2Images, 291);
    DScrollChat.LeftButton.SetImgIndex(g_WMain2Images, 292);
    DScrollChat.RightButton.SetImgIndex(g_WMain2Images, 294);
    DScrollChat.CenterButton.SetImgIndex(g_WMain2Images, 581);}

    DScrollChat.SetImgIndex(g_WCqFirImages, 124);
    DScrollChat.LeftButton.SetImgIndex(g_WCqFirImages, 119);
    DScrollChat.RightButton.SetImgIndex(g_WCqFirImages, 121);
    DScrollChat.CenterButton.SetImgIndex(g_WCqFirImages, 118);

    DScrollChat.LeftButton.OnDirectPaint := DScrollScrollDirectPaint;
    DScrollChat.RightButton.OnDirectPaint := DScrollScrollDirectPaint;
    DScrollChat.OnDirectPaint := DScrollCenterScrollDirectPaint;
    DScrollChat.Left := DMemoChat.Width + 1;
    DScrollChat.Top := 0;
    DScrollChat.Height := DChatDlg.Height;

    DScrollChat.Increment := 12;
    DScrollChat.LeftButton.Left := (DScrollChat.Width - DScrollChat.LeftButton.Width) div 2;
    DScrollChat.LeftButton.Top := 1;
    DScrollChat.RightButton.Left := (DScrollChat.Width - DScrollChat.RightButton.Width) div 2;
    DScrollChat.RightButton.Top := DScrollChat.Height - DScrollChat.RightButton.Height - 1;
    DScrollChat.CenterButton.Left := (DScrollChat.Width - DScrollChat.CenterButton.Width) div 2;
    DScrollChat.CenterButton.Top := DScrollChat.LeftButton.Top + DScrollChat.LeftButton.Height;

   { DMemoChat.Left := DScrollChat.Width + 1;
    DMemoChat.Top := 0;
    DMemoChat.Width := DChatDlg.Width - 18;
    DMemoChat.Height := 12 * 9;  }


    SetInputVisible(False);
    SetChatVisible(False);
  end;


  {-----------------------------------------------------------}
  d := g_WMainImages.Images[360];
  if d <> nil then begin
    DMsgDlg.SetImgIndex(g_WMainImages, 360);
    DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
    DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
  end;
  DMsgDlgOk.SetImgIndex(g_WMainImages, 361);
  DMsgDlgYes.SetImgIndex(g_WMainImages, 363);
  DMsgDlgCancel.SetImgIndex(g_WMainImages, 365);
  DMsgDlgNo.SetImgIndex(g_WMainImages, 367);
  DMsgDlgOk.Top := 126;
  DMsgDlgYes.Top := 126;
  DMsgDlgCancel.Top := 126;
  DMsgDlgNo.Top := 126;

  with EdDlgEdit do begin
    Text := '';
    Width := DMsgDlg.Width - 70;
    Left := (DMsgDlg.Width - Width) div 2;
    Top := (DMsgDlg.Height - Height) div 2 - 10;
  end;

  {-----------------------------------------------------------}
  {d := g_WCqFirImages.Images[49];
  if d <> nil then begin
    DIntro.SetImgIndex(g_WCqFirImages, 49);
    DIntro.Left := (SCREENWIDTH - d.Width) div 2;
    DIntro.Top := (SCREENHEIGHT - d.Height) div 2;
    DIntro.Width := d.Width;
    DIntro.Height := d.Height;
  end;}


  d := g_WMainImages.Images[60];
  if d <> nil then begin
    DLogIn.SetImgIndex(g_WMainImages, 60);
    DLogIn.Left := (SCREENWIDTH - d.Width) div 2;
    DLogIn.Top := (SCREENHEIGHT - d.Height) div 2;
    DLogIn.Width := d.Width;
    DLogIn.Height := d.Height;
  end;
  DLoginNew.SetImgIndex(g_WMainImages, 61);
  DLoginNew.Left := 24;
  DLoginNew.Top := 207;
  DLoginOk.SetImgIndex(g_WMainImages, 62);
  DLoginOk.Left := 171;
  DLoginOk.Top := 165;
  DLoginChgPw.SetImgIndex(g_WMainImages, 53);
  DLoginChgPw.Left := 111 + 18;
  DLoginChgPw.Top := 207;
  DLoginClose.SetImgIndex(g_WMainImages, 64);
  DLoginClose.Left := 252;
  DLoginClose.Top := 28;

  EdId.Left := 96;
  EdId.Top := 83;
  EdId.Width := 137;
  EdId.Text := '';

  EdPasswd.Left := 96;
  EdPasswd.Top := 115;
  EdPasswd.Width := 137;
  EdPasswd.Text := '';
  {-----------------------------------------------------------}
  //服务器选择窗口
  d := g_WMainImages.Images[256]; //81];
  if d <> nil then begin
    DSelServerDlg.SetImgIndex(g_WMainImages, 256);
    DSelServerDlg.Left := (SCREENWIDTH - d.Width) div 2;
    DSelServerDlg.Top := (SCREENHEIGHT - d.Height) div 2;
  end;
  DSSrvClose.SetImgIndex(g_WMainImages, 64);
  DSSrvClose.Left := 245;
  DSSrvClose.Top := 31;
    {
          DEngServer1.SetImgIndex (g_WMainImages, 257);
          DEngServer1.Left := 65;
          DEngServer1.Top  := 204;
    }

  DSServer1.SetImgIndex(g_WMain3Images, 2);
  DSServer1.Left := 65;
  DSServer1.Top := 100;

  DSServer2.SetImgIndex(g_WMain3Images, 2);
  DSServer2.Left := 65;
  DSServer2.Top := 145;

  DSServer3.SetImgIndex(g_WMain3Images, 2);
  DSServer3.Left := 65;
  DSServer3.Top := 190;

  DSServer4.SetImgIndex(g_WMain3Images, 2);
  DSServer4.Left := 65;
  DSServer4.Top := 235;

  DSServer5.SetImgIndex(g_WMain3Images, 2);
  DSServer5.Left := 65;
  DSServer5.Top := 280;

  DSServer6.SetImgIndex(g_WMain3Images, 2);
  DSServer6.Left := 65;
  DSServer6.Top := 325;

  DEngServer1.Visible := False;
  DSServer1.Visible := False;
  DSServer2.Visible := False;
  DSServer3.Visible := False;
  DSServer4.Visible := False;
  DSServer5.Visible := False;
  DSServer6.Visible := False;

  {-----------------------------------------------------------}
  {Res := TResourceStream.Create(HInstance, 'NewAccount', PChar('bmp'));
  Bitmap:= TBitmap.Create;
  Bitmap.LoadFromStream(Res);
  Res.Free;
  g_WMainImages.SetCachedSurface(63, Res); }
  //登录窗口
  d := g_WMainImages.Images[63];
  if d <> nil then begin
    DNewAccount.SetImgIndex(g_WMainImages, 63);
    DNewAccount.Left := (SCREENWIDTH - d.Width) div 2;
    DNewAccount.Top := (SCREENHEIGHT - d.Height) div 2;
  end;

  {d := g_WCqFirImages.Images[0];
  if d <> nil then begin
    DNewAccount.SetImgIndex(g_WCqFirImages, 0);
    DNewAccount.Left := (SCREENWIDTH - d.Width) div 2;
    DNewAccount.Top := (SCREENHEIGHT - d.Height) div 2;
  end;}

  DNewAccountOk.SetImgIndex(g_WMainImages, 62);
  DNewAccountOk.Left := 160;
  DNewAccountOk.Top := 417;
  DNewAccountCancel.SetImgIndex(g_WMainImages, 52);
  DNewAccountCancel.Left := 448;
  DNewAccountCancel.Top := 419;
  DNewAccountClose.SetImgIndex(g_WMainImages, 64);
  DNewAccountClose.Left := 587;
  DNewAccountClose.Top := 33;

  {-----------------------------------------------------------}

  //修改密码窗口
  d := g_WMainImages.Images[50];
  if d <> nil then begin
    DChgPw.SetImgIndex(g_WMainImages, 50);
    DChgPw.Left := (SCREENWIDTH - d.Width) div 2;
    DChgPw.Top := (SCREENHEIGHT - d.Height) div 2;
  end;
  DChgpwOk.SetImgIndex(g_WMainImages, 62);
  DChgpwOk.Left := 182;
  DChgpwOk.Top := 252;
  DChgpwCancel.SetImgIndex(g_WMainImages, 52);
  DChgpwCancel.Left := 277;
  DChgpwCancel.Top := 251;

  {-----------------------------------------------------------}

  //选择角色窗口
  DSelectChr.Left := 0;
  DSelectChr.Top := 0;
  DSelectChr.Width := SCREENWIDTH;
  DSelectChr.Height := SCREENHEIGHT;
  DscSelect1.SetImgIndex(g_WMainImages, 66);
  DscSelect2.SetImgIndex(g_WMainImages, 67);
  DscStart.SetImgIndex(g_WMain2Images, 481);
  DscNewChr.SetImgIndex(g_WMainImages, 69);
  DscEraseChr.SetImgIndex(g_WMainImages, 70);
  //DscCredits.SetImgIndex(g_WMainImages, 71);
  DscCredits.SetImgIndex(g_WMain3Images, 405);
  DscExit.SetImgIndex(g_WMainImages, 72);

  DscSelect1.Left := (SCREENWIDTH - 800) div 2 + 134 - 1 {134};
  DscSelect1.Top := (SCREENHEIGHT - 600) div 2 + 454 - 1 {454};
  DscSelect2.Left := (SCREENWIDTH - 800) div 2 + 685 {685};
  DscSelect2.Top := (SCREENHEIGHT - 600) div 2 + 454 {454};
  DscStart.Left := (SCREENWIDTH - 800) div 2 + 385 - 12 {385};
  DscStart.Top := (SCREENHEIGHT - 600) div 2 + 456 - 4 {456};
  DscNewChr.Left := (SCREENWIDTH - 800) div 2 + 348 {348};
  DscNewChr.Top := (SCREENHEIGHT - 600) div 2 + 486 {486};
  DscEraseChr.Left := (SCREENWIDTH - 800) div 2 + 347 {347};
  DscEraseChr.Top := (SCREENHEIGHT - 600) div 2 + 506 {506};
  DscCredits.Left := (SCREENWIDTH - 800) div 2 + 346 {362};
  DscCredits.Top := (SCREENHEIGHT - 600) div 2 + 527 {527};
  DscExit.Left := (SCREENWIDTH - 800) div 2 + 379 {379};
  DscExit.Top := (SCREENHEIGHT - 600) div 2 + 547 {547};

  {-----------------------------------------------------------}

  //创建角色窗口
  d := g_WMainImages.Images[73];
  if d <> nil then begin
    DCreateChr.SetImgIndex(g_WMainImages, 73);
    DCreateChr.Left := (SCREENWIDTH - d.Width) div 2;
    DCreateChr.Top := (SCREENHEIGHT - d.Height) div 2;
  end;
  DccWarrior.SetImgIndex(g_WMainImages, 74);
  DccWizzard.SetImgIndex(g_WMainImages, 75);
  DccMonk.SetImgIndex(g_WMainImages, 76);
  //DccReserved.SetImgIndex (g_WMainImages.Images[76], TRUE);
  DccMale.SetImgIndex(g_WMainImages, 77);
  DccFemale.SetImgIndex(g_WMainImages, 78);
  DccLeftHair.SetImgIndex(g_WMainImages, 79);
  DccRightHair.SetImgIndex(g_WMainImages, 80);
  DccOk.SetImgIndex(g_WMainImages, 62);
  DccClose.SetImgIndex(g_WMainImages, 64);
  DccWarrior.Left := 48;
  DccWarrior.Top := 157;
  DccWizzard.Left := 93;
  DccWizzard.Top := 157;
  DccMonk.Left := 138;
  DccMonk.Top := 157;
  //DccReserved.Left := 183;
  //DccReserved.Top := 157;
  DccMale.Left := 93;
  DccMale.Top := 231;
  DccFemale.Left := 138;
  DccFemale.Top := 231;
  DccLeftHair.Left := 76;
  DccLeftHair.Top := 308;
  DccRightHair.Left := 170;
  DccRightHair.Top := 308;
  DccOk.Left := 104;
  DccOk.Top := 361;
  DccClose.Left := 248;
  DccClose.Top := 31;


  {-----------------------------------------------------------}
  d := g_WMainImages.Images[50]; //修改密码窗口
  if d <> nil then begin
    DChgGamePwd.SetImgIndex(g_WMainImages, 689);
    DChgGamePwd.Left := (SCREENWIDTH - d.Width) div 2;
    DChgGamePwd.Top := (SCREENHEIGHT - d.Height) div 2;
  end;
  DChgGamePwdClose.Left := 291; // 399;
  DChgGamePwdClose.Top := 8;
  DChgGamePwdClose.SetImgIndex(g_WMainImages, 64);


  //人物状态窗口
 { d := g_WMain3Images.Images[207]; //惑怕  370
  if d <> nil then begin
    DStateWin.SetImgIndex(g_WMain3Images, 207);
    DStateWin.Left := SCREENWIDTH - d.Width;
    DStateWin.Top := 0;
  end;}

  d := g_WUIBImages.Images[10]; //惑怕  370
  if d <> nil then begin
    DStateWin.SetImgIndex(g_WUIBImages, 10);
    DStateWin.Left := SCREENWIDTH - d.Width;
    DStateWin.Top := 0;
  end else begin
  //人物状态窗口
    d := g_WMain3Images.Images[207]; //惑怕  370
    if d <> nil then begin
      DStateWin.SetImgIndex(g_WMain3Images, 207);
      DStateWin.Left := SCREENWIDTH - d.Width;
      DStateWin.Top := 0;
    end;
  end;


  DSWNecklace.Left := 38 + 130;
  DSWNecklace.Top := 52 + 35;
  DSWNecklace.Width := 34;
  DSWNecklace.Height := 31;
  DSWHelmet.Left := 38 + 77;
  DSWHelmet.Top := 52 + 41;
  DSWHelmet.Width := 18;
  DSWHelmet.Height := 18;
  DSWLight.Left := 38 + 130;
  DSWLight.Top := 52 + 73;
  DSWLight.Width := 34;
  DSWLight.Height := 31;
  DSWArmRingR.Left := 38 + 4;
  DSWArmRingR.Top := 52 + 124;
  DSWArmRingR.Width := 34;
  DSWArmRingR.Height := 31;
  DSWArmRingL.Left := 38 + 130;
  DSWArmRingL.Top := 52 + 124;
  DSWArmRingL.Width := 34;
  DSWArmRingL.Height := 31;
  DSWRingR.Left := 38 + 4;
  DSWRingR.Top := 52 + 163;
  DSWRingR.Width := 34;
  DSWRingR.Height := 31;
  DSWRingL.Left := 38 + 130;
  DSWRingL.Top := 52 + 163;
  DSWRingL.Width := 34;
  DSWRingL.Height := 31;
  DSWWeapon.Left := 38 + 9;
  DSWWeapon.Top := 52 + 28;
  DSWWeapon.Width := 47;
  DSWWeapon.Height := 87;
  DSWDress.Left := 38 + 58;
  DSWDress.Top := 52 + 70;
  DSWDress.Width := 53;
  DSWDress.Height := 112;

  DSWBujuk.Left := 42;
  DSWBujuk.Top := 254;
  DSWBujuk.Width := 34;
  DSWBujuk.Height := 31;

  DSWBelt.Left := 84;
  DSWBelt.Top := 254;
  DSWBelt.Width := 34;
  DSWBelt.Height := 31;

  DSWBoots.Left := 126;
  DSWBoots.Top := 254;
  DSWBoots.Width := 34;
  DSWBoots.Height := 31;

  DSWCharm.Left := 168;
  DSWCharm.Top := 254;
  DSWCharm.Width := 34;
  DSWCharm.Height := 31;

  DStMag1.Left := 38 + 8;
  DStMag1.Top := 52 + 7;
  DStMag1.Width := 31;
  DStMag1.Height := 33;

  DStMag2.Left := 38 + 8;
  DStMag2.Top := 52 + 44;
  DStMag2.Width := 31;
  DStMag2.Height := 33;

  DStMag3.Left := 38 + 8;
  DStMag3.Top := 52 + 82;
  DStMag3.Width := 31;
  DStMag3.Height := 33;

  DStMag4.Left := 38 + 8;
  DStMag4.Top := 52 + 119;
  DStMag4.Width := 31;
  DStMag4.Height := 33;

  DStMag5.Left := 38 + 8;
  DStMag5.Top := 52 + 156;
  DStMag5.Width := 31;
  DStMag5.Height := 33;

  DStMag6.Left := 38 + 8;
  DStMag6.Top := 52 + 195;
  DStMag6.Width := 31;
  DStMag6.Height := 33;


  DStPageUp.SetImgIndex(g_WMainImages, 398);
  DStPageDown.SetImgIndex(g_WMainImages, 396);
  DStPageUp.Left := 213;
  DStPageUp.Top := 113;
  DStPageDown.Left := 213;
  DStPageDown.Top := 143;

  DCloseState.SetImgIndex(g_WMainImages, 371);
  DCloseState.Left := 8;
  DCloseState.Top := 39;
  DPrevState.SetImgIndex(g_WMainImages, 373);
  DNextState.SetImgIndex(g_WMainImages, 372);
  DPrevState.Left := 7;
  DPrevState.Top := 128;
  DNextState.Left := 7;
  DNextState.Top := 187;

  {-----------------------------------------------------------}

  //英雄状态窗口
  d := g_WMain3Images.Images[384];
  if d <> nil then begin
    DHeroStateWin.SetImgIndex(g_WMain3Images, 384);
    DHeroStateWin.Left := SCREENWIDTH - d.Width;
    DHeroStateWin.Top := 0;
  end;

  DHeroSWNecklace.Left := 38 + 130;
  DHeroSWNecklace.Top := 52 + 35;
  DHeroSWNecklace.Width := 34;
  DHeroSWNecklace.Height := 31;
  DHeroSWHelmet.Left := 38 + 77;
  DHeroSWHelmet.Top := 52 + 41;
  DHeroSWHelmet.Width := 18;
  DHeroSWHelmet.Height := 18;
  DHeroSWLight.Left := 38 + 130;
  DHeroSWLight.Top := 52 + 73;
  DHeroSWLight.Width := 34;
  DHeroSWLight.Height := 31;
  DHeroSWArmRingR.Left := 38 + 4;
  DHeroSWArmRingR.Top := 52 + 124;
  DHeroSWArmRingR.Width := 34;
  DHeroSWArmRingR.Height := 31;
  DHeroSWArmRingL.Left := 38 + 130;
  DHeroSWArmRingL.Top := 52 + 124;
  DHeroSWArmRingL.Width := 34;
  DHeroSWArmRingL.Height := 31;
  DHeroSWRingR.Left := 38 + 4;
  DHeroSWRingR.Top := 52 + 163;
  DHeroSWRingR.Width := 34;
  DHeroSWRingR.Height := 31;
  DHeroSWRingL.Left := 38 + 130;
  DHeroSWRingL.Top := 52 + 163;
  DHeroSWRingL.Width := 34;
  DHeroSWRingL.Height := 31;
  DHeroSWWeapon.Left := 38 + 9;
  DHeroSWWeapon.Top := 52 + 28;
  DHeroSWWeapon.Width := 47;
  DHeroSWWeapon.Height := 87;
  DHeroSWDress.Left := 38 + 58;
  DHeroSWDress.Top := 52 + 70;
  DHeroSWDress.Width := 53;
  DHeroSWDress.Height := 112;

  DHeroSWBujuk.Left := 42;
  DHeroSWBujuk.Top := 254;
  DHeroSWBujuk.Width := 34;
  DHeroSWBujuk.Height := 31;

  DHeroSWBelt.Left := 84;
  DHeroSWBelt.Top := 254;
  DHeroSWBelt.Width := 34;
  DHeroSWBelt.Height := 31;

  DHeroSWBoots.Left := 126;
  DHeroSWBoots.Top := 254;
  DHeroSWBoots.Width := 34;
  DHeroSWBoots.Height := 31;

  DHeroSWCharm.Left := 168;
  DHeroSWCharm.Top := 254;
  DHeroSWCharm.Width := 34;
  DHeroSWCharm.Height := 31;

  DHeroStMag1.Left := 38 + 8;
  DHeroStMag1.Top := 52 + 7;
  DHeroStMag1.Width := 31;
  DHeroStMag1.Height := 33;

  DHeroStMag2.Left := 38 + 8;
  DHeroStMag2.Top := 52 + 44;
  DHeroStMag2.Width := 31;
  DHeroStMag2.Height := 33;

  DHeroStMag3.Left := 38 + 8;
  DHeroStMag3.Top := 52 + 82;
  DHeroStMag3.Width := 31;
  DHeroStMag3.Height := 33;

  DHeroStMag4.Left := 38 + 8;
  DHeroStMag4.Top := 52 + 119;
  DHeroStMag4.Width := 31;
  DHeroStMag4.Height := 33;

  DHeroStMag5.Left := 38 + 8;
  DHeroStMag5.Top := 52 + 156;
  DHeroStMag5.Width := 31;
  DHeroStMag5.Height := 33;

  DHeroStMag6.Left := 38 + 8;
  DHeroStMag6.Top := 52 + 195;
  DHeroStMag6.Width := 31;
  DHeroStMag6.Height := 33;


  DHeroStPageUp.SetImgIndex(g_WMainImages, 398);
  DHeroStPageDown.SetImgIndex(g_WMainImages, 396);
  DHeroStPageUp.Left := 213;
  DHeroStPageUp.Top := 113;
  DHeroStPageDown.Left := 213;
  DHeroStPageDown.Top := 143;

  DCloseHeroState.SetImgIndex(g_WMainImages, 371);
  DCloseHeroState.Left := 8;
  DCloseHeroState.Top := 39;

  DPrevHeroState.SetImgIndex(g_WMainImages, 373);
  DNextHeroState.SetImgIndex(g_WMainImages, 372);
  DPrevHeroState.Left := 7;
  DPrevHeroState.Top := 128;
  DNextHeroState.Left := 7;
  DNextHeroState.Top := 187;

  {-----------------------------------------------------------}

  //人物状态窗口(查看别人信息)
  {d := g_WMain3Images.Images[207]; //惑怕  370
  if d <> nil then begin
    DUserState1.SetImgIndex(g_WMain3Images, 207);
    DUserState1.Left := SCREENWIDTH - d.Width - d.Width;
    DUserState1.Top := 0;
  end;
  }
  d := g_WUIBImages.Images[10]; //惑怕  370
  if d <> nil then begin
    DUserState1.SetImgIndex(g_WUIBImages, 10);
    DUserState1.Left := SCREENWIDTH - d.Width - d.Width;
    DUserState1.Top := 0;
  end else begin
    d := g_WMain3Images.Images[207]; //惑怕  370
    if d <> nil then begin
      DUserState1.SetImgIndex(g_WMain3Images, 207);
      DUserState1.Left := SCREENWIDTH - d.Width - d.Width;
      DUserState1.Top := 0;
    end;
  end;

  DNecklaceUS1.Left := 38 + 130;
  DNecklaceUS1.Top := 52 + 35;
  DNecklaceUS1.Width := 34;
  DNecklaceUS1.Height := 31;

  DHelmetUS1.Left := 38 + 77;
  DHelmetUS1.Top := 52 + 41;
  DHelmetUS1.Width := 18;
  DHelmetUS1.Height := 18;

  DLightUS1.Left := 38 + 130;
  DLightUS1.Top := 52 + 73;
  DLightUS1.Width := 34;
  DLightUS1.Height := 31;

  DArmringRUS1.Left := 38 + 4;
  DArmringRUS1.Top := 52 + 124;
  DArmringRUS1.Width := 34;
  DArmringRUS1.Height := 31;

  DArmringLUS1.Left := 38 + 130;
  DArmringLUS1.Top := 52 + 124;
  DArmringLUS1.Width := 34;
  DArmringLUS1.Height := 31;

  DRingRUS1.Left := 38 + 4;
  DRingRUS1.Top := 52 + 163;
  DRingRUS1.Width := 34;
  DRingRUS1.Height := 31;

  DRingLUS1.Left := 38 + 130;
  DRingLUS1.Top := 52 + 163;
  DRingLUS1.Width := 34;
  DRingLUS1.Height := 31;

  DWeaponUS1.Left := 38 + 9;
  DWeaponUS1.Top := 52 + 28;
  DWeaponUS1.Width := 47;
  DWeaponUS1.Height := 87;

  DDressUS1.Left := 38 + 58;
  DDressUS1.Top := 52 + 70;
  DDressUS1.Width := 53;
  DDressUS1.Height := 112;

  DBujukUS1.Left := 42;
  DBujukUS1.Top := 254;
  DBujukUS1.Width := 34;
  DBujukUS1.Height := 31;

  DBeltUS1.Left := 84;
  DBeltUS1.Top := 254;
  DBeltUS1.Width := 34;
  DBeltUS1.Height := 31;

  DBootsUS1.Left := 126;
  DBootsUS1.Top := 254;
  DBootsUS1.Width := 34;
  DBootsUS1.Height := 31;

  DCharmUS1.Left := 168;
  DCharmUS1.Top := 254;
  DCharmUS1.Width := 34;
  DCharmUS1.Height := 31;

  DCloseUS1.SetImgIndex(g_WMainImages, 371);
  DCloseUS1.Left := 8;
  DCloseUS1.Top := 39;

  {-------------------------------------------------------------}

   //物品包裹栏
  d := g_WMain2Images.Images[180];
  if (d = nil) or ((d <> nil) and (d.Width < 100)) then begin
    DItemBag.SetImgIndex(g_WMain3Images, 6);
  end else begin
    DItemBag.SetImgIndex(g_WMain2Images, 180)
  end;

  DItemBag.Left := 0;
  DItemBag.Top := 80;

  DItemGrid.Left := 29;
  DItemGrid.Top := 41;
  DItemGrid.Width := 286;
  DItemGrid.Height := 162;

  DOpenUpgrade.SetImgIndex(g_WMain2Images, 183);
  DOpenUpgrade.Left := 300 - 1;
  DOpenUpgrade.Top := 212;

  DUpgrade.SetImgIndex(g_WMain3Images, 462);
  DUpgrade.Left := 352;
  DUpgrade.Top := 83;

  DCloseUpgrade.SetImgIndex(g_WMainImages, 371);
  DCloseUpgrade.Left := 231; //248 - 16 - 1;
  DCloseUpgrade.Top := 0;

  DUpgradeItem1.Left := 101;
  DUpgradeItem1.Top := 33;
  DUpgradeItem1.Width := 36;
  DUpgradeItem1.Height := 36;

  DUpgradeItem2.Left := 40;
  DUpgradeItem2.Top := 110;
  DUpgradeItem2.Width := 36;
  DUpgradeItem2.Height := 36;

  DUpgradeItem3.Left := 160;
  DUpgradeItem3.Top := 112;
  DUpgradeItem3.Width := 36;
  DUpgradeItem3.Height := 36;

  d := g_WMain3Images.Images[463];
  if d <> nil then begin
    DStartUpgrade.SetImgIndex(g_WMain3Images, 463);
    DStartUpgrade.Left := (248 - 18 - d.Width) div 2 + 2;
    DStartUpgrade.Top := 212 - 37;
  end;
  {-------------------------------------------------------------}

   //英雄物品包裹栏

  d := g_WUIBImages.Images[14];

  if d <> nil then begin
    DHeroItemBag.SetImgIndex(g_WUIBImages, 14);
    DHeroItemBag.Left := SCREENWIDTH - d.Width;
    DHeroItemBag.Top := 0;
    DHeroItemBag.Width := d.Width;
    DHeroItemBag.Height := d.Height;
  end else begin
    d := g_WMain3Images.Images[375 + 4];
    if d <> nil then begin
      DHeroItemBag.SetImgIndex(g_WMain3Images, 375 + 4);
      DHeroItemBag.Left := SCREENWIDTH - d.Width;
      DHeroItemBag.Top := 0;
      DHeroItemBag.Width := d.Width;
      DHeroItemBag.Height := d.Height;
    end;
  end;
  {DHeroItemBag.Left := SCREENWIDTH - d.Width;
  DHeroItemBag.Top := 0;}
  {DHeroItemBag.SetImgIndex(g_WMain3Images, 375);
  DHeroItemBag.Left := SCREENWIDTH - 10 - DHeroItemBag.Width;
  DHeroItemBag.Top := 10;}

  DHeroItemGrid.Left := 15;
  DHeroItemGrid.Top := 15;

  DHeroItemGrid.Width := 228 - 50;
  DHeroItemGrid.Height := 32 * 2;

  DCloseHeroBag.SetImgIndex(g_WMainImages, 371);
  //DCloseHeroBag.Downed := True; //??
  DCloseHeroBag.Left := 228 - 20;
  DCloseHeroBag.Top := DHeroItemBag.Top;
  {DCloseHeroBag.Width := 14;
  DCloseHeroBag.Height := 20;}

  //黄金、修理物品、关闭包裹按钮
  DGold.SetImgIndex(g_WMainImages, 29);
  DGold.Left := 18;
  DGold.Top := 218;

  {DRepairItem.SetImgIndex(g_WMainImages, 26);
  DRepairItem.Left := 254;
  DRepairItem.Top := 183;
  DRepairItem.Width := 48;
  DRepairItem.Height := 22; }
  DCloseBag.SetImgIndex(g_WMainImages, 371);
  DCloseBag.Downed := True; //??
  DCloseBag.Left := 336;
  DCloseBag.Top := 59;
  DCloseBag.Width := 14;
  DCloseBag.Height := 20;


{  d := g_WUIBImages.Images[11]; //惑怕  370
  if d <> nil then begin
    DStateWin.SetImgIndex(g_WUIBImages, 11);
    DStateWin.Left := SCREENWIDTH - d.Width;
    DStateWin.Top := 0;
  end else
  d := g_WUIBImages.Images[10]; //惑怕  370
  if d <> nil then begin
    DStateWin.SetImgIndex(g_WUIBImages, 10);
    DStateWin.Left := SCREENWIDTH - d.Width;
    DStateWin.Top := 0;
  end else begin
  //人物状态窗口
    d := g_WMain3Images.Images[207]; //惑怕  370
    if d <> nil then begin
      DStateWin.SetImgIndex(g_WMain3Images, 207);
      DStateWin.Left := SCREENWIDTH - d.Width;
      DStateWin.Top := 0;
    end;
  end;  }

 { d := g_WUIBImages.Images[10]; //惑怕  370
  if d <> nil then begin
    DStateWin.SetImgIndex(g_WUIBImages, 10);
    DStateWin.Left := SCREENWIDTH - d.Width;
    DStateWin.Top := 0;
  end else begin
    d := g_WMain3Images.Images[207]; //惑怕
    if d <> nil then begin
      DStateWin.SetImgIndex(g_WMain3Images, 207);
      DStateWin.Left := SCREENWIDTH - d.Width;
      DStateWin.Top := 0;
    end;
  end; }
  {-----------------------------------------------------------}

  //商人对话框
  d := g_WMainImages.Images[384];
  if d <> nil then begin
    DMerchantDlg.Left := 0;
    DMerchantDlg.Top := 0;
    DMerchantDlg.SetImgIndex(g_WMainImages, 384);
  end;
  DMerchantDlgClose.Left := 399;
  DMerchantDlgClose.Top := 1;
  DMerchantDlgClose.SetImgIndex(g_WMainImages, 64);

//NPC大对话框
  d := g_WCqFirImages.Images[0];
  if d <> nil then begin
    DMerchantBigDlg.Left := 0;
    DMerchantBigDlg.Top := 0;
    DMerchantBigDlg.SetImgIndex(g_WCqFirImages, 0);
  end;
  DMerchantBigDlgClose.Left := 551;
  DMerchantBigDlgClose.Top := 1;
  DMerchantBigDlgClose.SetImgIndex(g_WMainImages, 64);

  {-----------------------------------------------------------}
  //菜单对话框
  d := g_WMainImages.Images[385];
  if d <> nil then begin
    DMenuDlg.Left := 138;
    DMenuDlg.Top := 163;
    DMenuDlg.SetImgIndex(g_WMainImages, 385);
  end;
  DMenuPrev.Left := 43;
  DMenuPrev.Top := 175;
  DMenuPrev.SetImgIndex(g_WMainImages, 388);
  DMenuNext.Left := 90;
  DMenuNext.Top := 175;
  DMenuNext.SetImgIndex(g_WMainImages, 387);
  DMenuBuy.Left := 215;
  DMenuBuy.Top := 171;
  DMenuBuy.SetImgIndex(g_WMainImages, 386);
  DMenuClose.Left := 291;
  DMenuClose.Top := 0;
  DMenuClose.SetImgIndex(g_WMainImages, 64);

  {-----------------------------------------------------------}

  //出售
  d := g_WMainImages.Images[392];
  if d <> nil then begin
    DSellDlg.Left := 328;
    DSellDlg.Top := 163;
    DSellDlg.SetImgIndex(g_WMainImages, 392);
  end;
  DSellDlgOk.Left := 85;
  DSellDlgOk.Top := 150;
  DSellDlgOk.SetImgIndex(g_WMainImages, 393);
  DSellDlgClose.Left := 115;
  DSellDlgClose.Top := 0;
  DSellDlgClose.SetImgIndex(g_WMainImages, 64);
  DSellDlgSpot.Left := 27;
  DSellDlgSpot.Top := 67;
  DSellDlgSpot.Width := 61;
  DSellDlgSpot.Height := 52;

  {-----------------------------------------------------------}

  //设置魔法快捷对话框
  d := g_WMain3Images.Images[126];
  if d <> nil then begin
    DKeySelDlg.Left := (SCREENWIDTH - d.Width) div 2;
    DKeySelDlg.Top := (SCREENHEIGHT - d.Height) div 2;
    DKeySelDlg.SetImgIndex(g_WMain3Images, 126);
  end;
  DKsIcon.Left := 51;
  DKsIcon.Top := 31;
  DKsF1.SetImgIndex(g_WMainImages, 232);
  DKsF1.Left := 25;
  DKsF1.Top := 78;
  DKsF2.SetImgIndex(g_WMainImages, 234);
  DKsF2.Left := 57;
  DKsF2.Top := 78;
  DKsF3.SetImgIndex(g_WMainImages, 236);
  DKsF3.Left := 89;
  DKsF3.Top := 78;
  DKsF4.SetImgIndex(g_WMainImages, 238);
  DKsF4.Left := 121;
  DKsF4.Top := 78;
  DKsF5.SetImgIndex(g_WMainImages, 240);
  DKsF5.Left := 160;
  DKsF5.Top := 78;
  DKsF6.SetImgIndex(g_WMainImages, 242);
  DKsF6.Left := 192;
  DKsF6.Top := 78;
  DKsF7.SetImgIndex(g_WMainImages, 244);
  DKsF7.Left := 224;
  DKsF7.Top := 78;
  DKsF8.SetImgIndex(g_WMainImages, 246);
  DKsF8.Left := 256;
  DKsF8.Top := 78;

  DKsConF1.SetImgIndex(g_WMain3Images, 132);
  DKsConF1.Left := 25;
  DKsConF1.Top := 120;
  DKsConF2.SetImgIndex(g_WMain3Images, 134);
  DKsConF2.Left := 57;
  DKsConF2.Top := 120;
  DKsConF3.SetImgIndex(g_WMain3Images, 136);
  DKsConF3.Left := 89;
  DKsConF3.Top := 120;
  DKsConF4.SetImgIndex(g_WMain3Images, 138);
  DKsConF4.Left := 121;
  DKsConF4.Top := 120;
  DKsConF5.SetImgIndex(g_WMain3Images, 140);
  DKsConF5.Left := 160;
  DKsConF5.Top := 120;
  DKsConF6.SetImgIndex(g_WMain3Images, 142);
  DKsConF6.Left := 192;
  DKsConF6.Top := 120;
  DKsConF7.SetImgIndex(g_WMain3Images, 144);
  DKsConF7.Left := 224;
  DKsConF7.Top := 120;
  DKsConF8.SetImgIndex(g_WMain3Images, 146);
  DKsConF8.Left := 256;
  DKsConF8.Top := 120;


  DKsNone.SetImgIndex(g_WMain3Images, 129);
  DKsNone.Left := 296;
  DKsNone.Top := 78;

  DKsOk.SetImgIndex(g_WMain3Images, 127);
  DKsOk.Left := 296;
  DKsOk.Top := 120;

  {d := g_WMainImages.Images[229];
  if d <> nil then begin
    DKeySelDlg.Left := (SCREENWIDTH - d.Width) div 2;
    DKeySelDlg.Top := (SCREENHEIGHT - d.Height) div 2;
    DKeySelDlg.SetImgIndex(g_WMainImages, 229);
  end;
  DKsIcon.Left := 52; //DMagIcon...
  DKsIcon.Top := 29;
  DKsF1.SetImgIndex(g_WMainImages, 232);
  DKsF1.Left := 34;
  DKsF1.Top := 83;
  DKsF2.SetImgIndex(g_WMainImages, 234);
  DKsF2.Left := 66;
  DKsF2.Top := 83;
  DKsF3.SetImgIndex(g_WMainImages, 236);
  DKsF3.Left := 98;
  DKsF3.Top := 83;
  DKsF4.SetImgIndex(g_WMainImages, 238);
  DKsF4.Left := 130;
  DKsF4.Top := 83;
  DKsF5.SetImgIndex(g_WMainImages, 240);
  DKsF5.Left := 171;
  DKsF5.Top := 83;
  DKsF6.SetImgIndex(g_WMainImages, 242);
  DKsF6.Left := 203;
  DKsF6.Top := 83;
  DKsF7.SetImgIndex(g_WMainImages, 244);
  DKsF7.Left := 235;
  DKsF7.Top := 83;
  DKsF8.SetImgIndex(g_WMainImages, 246);
  DKsF8.Left := 267;
  DKsF8.Top := 83;

  DKsNone.SetImgIndex(g_WMainImages, 230);
  DKsNone.Left := 299;
  DKsNone.Top := 83;
  DKsOk.SetImgIndex(g_WMainImages, 62);
  DKsOk.Left := 222;
  DKsOk.Top := 131; }

  {-----------------------------------------------------------}
  //组对话框
  d := g_WMainImages.Images[120];
  if d <> nil then begin
    DGroupDlg.Left := (SCREENWIDTH - d.Width) div 2;
    DGroupDlg.Top := (SCREENHEIGHT - d.Height) div 2;
    DGroupDlg.SetImgIndex(g_WMainImages, 120);
  end;
  DGrpDlgClose.SetImgIndex(g_WMainImages, 64);
  DGrpDlgClose.Left := 260;
  DGrpDlgClose.Top := 0;
  DGrpAllowGroup.SetImgIndex(g_WMainImages, 122);
  DGrpAllowGroup.Left := 20;
  DGrpAllowGroup.Top := 18;
  DGrpCreate.SetImgIndex(g_WMainImages, 123);
  DGrpCreate.Left := 21 + 1;
  DGrpCreate.Top := 202 + 1;
  DGrpAddMem.SetImgIndex(g_WMainImages, 124);
  DGrpAddMem.Left := 96 + 1;
  DGrpAddMem.Top := 202 + 1;
  DGrpDelMem.SetImgIndex(g_WMainImages, 125);
  DGrpDelMem.Left := 171 + 1;
  DGrpDelMem.Top := 202 + 1;

  {-----------------------------------------------------------}
  //交易对话框
  d := g_WMainImages.Images[389]; //卖出方
  if d <> nil then begin
    DDealDlg.Left := SCREENWIDTH - d.Width;
    DDealDlg.Top := 0;
    DDealDlg.SetImgIndex(g_WMainImages, 389);
  end;
  DDGrid.Left := 21;
  DDGrid.Top := 56;
  DDGrid.Width := 36 * 5;
  DDGrid.Height := 33 * 2;
  DDealOk.SetImgIndex(g_WMainImages, 391);
  DDealOk.Left := 155;
  DDealOk.Top := 193 - 65;
  DDealClose.SetImgIndex(g_WMainImages, 64);
  DDealClose.Left := 220;
  DDealClose.Top := 42;
  DDGold.SetImgIndex(g_WMainImages, 28);
  DDGold.Left := 11;
  DDGold.Top := 202 - 65;

  d := g_WMainImages.Images[390]; //买进方
  if d <> nil then begin
    DDealRemoteDlg.Left := DDealDlg.Left - d.Width;
    DDealRemoteDlg.Top := 0;
    DDealRemoteDlg.SetImgIndex(g_WMainImages, 390);
  end;
  DDRGrid.Left := 21;
  DDRGrid.Top := 56;
  DDRGrid.Width := 36 * 5;
  DDRGrid.Height := 33 * 2;
  DDRGold.SetImgIndex(g_WMainImages, 28);
  DDRGold.Left := 11;
  DDRGold.Top := 202 - 65;

//商铺
  {-----------------------------------------------------------}

  d := g_WMain3Images.Images[298];
  if d <> nil then begin
    DShop.Left := (SCREENWIDTH - d.Width) div 2;
    DShop.Top := 0 {(SCREENHEIGHT - d.Height) div 2};
    DShop.SetImgIndex(g_WMain3Images, 298);
  end;
  DJewelry.Left := 176;
  DJewelry.Top := 13;
  DJewelry.SetImgIndex(g_WMain3Images, 299); {首饰}

  DMedicine.Left := 234;
  DMedicine.Top := 13;
  DMedicine.SetImgIndex(g_WMain3Images, 300); {补给}

  DEnhance.Left := 292 + 1;
  DEnhance.Top := 13;
  DEnhance.SetImgIndex(g_WMain3Images, 301); {强化}

  Dfriend.Left := 350 - 1;
  Dfriend.Top := 13;
  Dfriend.SetImgIndex(g_WMain3Images, 302); {好友}

  DLimit.Left := 408 - 1;
  DLimit.Top := 13;
  DLimit.SetImgIndex(g_WMain3Images, 303); {限量}

  DShopExit.SetImgIndex(g_WMainImages, 64);
  DShopExit.Left := 600 + 6;
  DShopExit.Top := 5;


  DPrevShop.Left := 197;
  DPrevShop.Top := 349;
  DPrevShop.SetImgIndex(g_WMainImages, 388); {上一页}

  DNextShop.Left := 287;
  DNextShop.Top := 349;
  DNextShop.SetImgIndex(g_WMainImages, 387); {下一页}

  DShopBuy.Left := 328;
  DShopBuy.Top := 364;
  DShopBuy.SetImgIndex(g_WMain3Images, 304); {购买}

  DShopFree.Left := DShopBuy.Left + 58;
  DShopFree.Top := 364;
  DShopFree.SetImgIndex(g_WMain3Images, 305); {赠送}

  DShopClose.Left := DShopFree.Left + 58;
  DShopClose.Top := 364;
  DShopClose.SetImgIndex(g_WMain3Images, 306); {购买}


  DShopItemGrid.Left := 178;
  DShopItemGrid.Top := 58;
  DShopItemGrid.Width := 340;
  DShopItemGrid.Height := 270;

  DSuperShopItemGrid.Left := 517;
  DSuperShopItemGrid.Top := 65;
  DSuperShopItemGrid.Width := 90;
  DSuperShopItemGrid.Height := 65 * 5;

  DShopIntroduce.Left := 15;
  DShopIntroduce.Width := 150;
  DShopIntroduce.Top := 25;
  DShopIntroduce.Height := 180;

  {-----------------------------------------------------------}
  //排行

  d := g_WMain3Images.Images[420];
  if d <> nil then begin
    DRankingDlg.Left := (SCREENWIDTH - d.Width) div 2;
    DRankingDlg.Top := (SCREENHEIGHT - d.Height) div 2 - 80;
    DRankingDlg.SetImgIndex(g_WMain3Images, 420);
  end;
  DBotRankingClose.Left := 326;
  DBotRankingClose.Top := 46;
  DBotRankingClose.SetImgIndex(g_WMainImages, 64);


  DBotCharRanking.Left := 28;
  DBotCharRanking.Top := 61;
  DBotCharRanking.SetImgIndex(g_WMain3Images, 443);

  DBotHeroRanking.Left := 122;
  DBotHeroRanking.Top := 61;
  DBotHeroRanking.SetImgIndex(g_WMain3Images, 444);

  DBotMasterRanking.Left := 220;
  DBotMasterRanking.Top := 61;
  DBotMasterRanking.SetImgIndex(g_WMain3Images, 445);


  d := g_WMain3Images.Images[427];
  if d <> nil then begin
    DBotActorRanking.Left := (DRankingDlg.Width - d.Width) div 2;
    DBotActorRanking.Top := 92 + (248 - d.Height * 4) div 5;
    DBotActorRanking.SetImgIndex(g_WMain3Images, 427);
  end;

  d := g_WMain3Images.Images[431];
  if d <> nil then begin
    DBotWarriorRanking.Left := (DRankingDlg.Width - d.Width) div 2;
    DBotWarriorRanking.Top := 92 + d.Height + (248 - d.Height * 4) div 5 * 2;
    DBotWarriorRanking.SetImgIndex(g_WMain3Images, 431);
  end;

  d := g_WMain3Images.Images[433];
  if d <> nil then begin
    DBotWizzardRanking.Left := (DRankingDlg.Width - d.Width) div 2;
    DBotWizzardRanking.Top := 92 + d.Height * 2 + (248 - d.Height * 4) div 5 * 3;
    DBotWizzardRanking.SetImgIndex(g_WMain3Images, 433);
  end;

  d := g_WMain3Images.Images[435];
  if d <> nil then begin
    DBotMonkRanking.Left := (DRankingDlg.Width - d.Width) div 2;
    DBotMonkRanking.Top := 92 + d.Height * 3 + (248 - d.Height * 4) div 5 * 4;
    DBotMonkRanking.SetImgIndex(g_WMain3Images, 435);
  end;


  d := g_WMain3Images.Images[429];
  if d <> nil then begin
    DBotHeroActorRanking.Left := (DRankingDlg.Width - d.Width) div 2;
    DBotHeroActorRanking.Top := 92 + (248 - d.Height * 4) div 5;
    DBotHeroActorRanking.SetImgIndex(g_WMain3Images, 429);
  end;

  d := g_WMain3Images.Images[437];
  if d <> nil then begin
    DBotHeroWarriorRanking.Left := (DRankingDlg.Width - d.Width) div 2;
    DBotHeroWarriorRanking.Top := 92 + d.Height + (248 - d.Height * 4) div 5 * 2;
    DBotHeroWarriorRanking.SetImgIndex(g_WMain3Images, 437);
  end;

  d := g_WMain3Images.Images[439];
  if d <> nil then begin
    DBotHeroWizzardRanking.Left := (DRankingDlg.Width - d.Width) div 2;
    DBotHeroWizzardRanking.Top := 92 + d.Height * 2 + (248 - d.Height * 4) div 5 * 3;
    DBotHeroWizzardRanking.SetImgIndex(g_WMain3Images, 439);
  end;

  d := g_WMain3Images.Images[441];
  if d <> nil then begin
    DBotHeroMonkRanking.Left := (DRankingDlg.Width - d.Width) div 2;
    DBotHeroMonkRanking.Top := 92 + d.Height * 3 + (248 - d.Height * 4) div 5 * 4;
    DBotHeroMonkRanking.SetImgIndex(g_WMain3Images, 441);
  end;


  DBotRankingHome.Left := 22;
  DBotRankingHome.Top := 344;
  DBotRankingHome.SetImgIndex(g_WMain3Images, 450);

  DBotRankingUp.Left := 22 + 55;
  DBotRankingUp.Top := 344;
  DBotRankingUp.SetImgIndex(g_WMain3Images, 452);

  DBotRankingDown.Left := 22 + 55 * 2 - 3;
  DBotRankingDown.Top := 344;
  DBotRankingDown.SetImgIndex(g_WMain3Images, 454);

  DBotRankingLast.Left := 22 + 55 * 3 - 6;
  DBotRankingLast.Top := 344;
  DBotRankingLast.SetImgIndex(g_WMain3Images, 456);

  DBotRankingSelf.Left := 244;
  DBotRankingSelf.Top := 344;
  DBotRankingSelf.SetImgIndex(g_WMain3Images, 458);

  RankingPageChanged(DBotCharRanking);


  {-----------------------------------------------------------}
  //拍卖
  //d := g_WMain3Images.Images[176];
  //if d <> nil then begin
  DUserSellOff.Left := 0;
  DUserSellOff.Top := 0;
  DUserSellOff.SetImgIndex(g_WMain3Images, 176);
 // end;

  EdSearch.Left := 12;
  EdSearch.Top := 328;
  EdSearch.Width := 136;
  EdSearch.Text := '';

  DSellClose.Left := 446;
  DSellClose.Top := 6;
  DSellClose.SetImgIndex(g_WMainImages, 64);

  DSellItem.Left := 224;
  DSellItem.Top := 262;

  DSearchSellOff.Left := 146;
  DSearchSellOff.Top := 325;
  DSearchSellOff.SetImgIndex(g_WMain3Images, 182);

  DBuySellItem.Left := 330;
  DBuySellItem.Top := 325;
  DBuySellItem.SetImgIndex(g_WMain3Images, 178);

  DCloseSell.Left := 397;
  DCloseSell.Top := 325;
  DCloseSell.SetImgIndex(g_WMain3Images, 180);

  DPrevSell.Left := 215;
  DPrevSell.Top := 355;
  DPrevSell.SetImgIndex(g_WMainImages, 388);

  DRefreshSell.Left := 259;
  DRefreshSell.Top := 356;
  DRefreshSell.SetImgIndex(g_WMain3Images, 177);

  DNextSell.Left := 302;
  DNextSell.Top := 355;
  DNextSell.SetImgIndex(g_WMainImages, 387);

  {
  d := g_WCqFirImages.Images[43];
  if d <> nil then begin
    DUserSellOff.Left := 0;
    DUserSellOff.Top := 0 ;
    DUserSellOff.SetImgIndex(g_WCqFirImages, 43);
  end;

  EdSearch.Left := 34;
  EdSearch.Top := 354;
  EdSearch.Width := 142;
  EdSearch.Text := '';

  DSellClose.Left := DUserSellOff.Width - 25;
  DSellClose.Top := 5;
  DSellClose.SetImgIndex(g_WCqFirImages, 55);

  DSellItem.Left := 392 - 145;
  DSellItem.Top := 312 - 15;

  DSearchSellOff.Left := 180;
  DSearchSellOff.Top := 353;
  DSearchSellOff.SetImgIndex(g_WCqFirImages, 49);

  DBuySellItem.Left := 346;
  DBuySellItem.Top := 353;
  DBuySellItem.SetImgIndex(g_WCqFirImages, 51);

  DCloseSell.Left := 416;
  DCloseSell.Top := 353;
  DCloseSell.SetImgIndex(g_WCqFirImages, 46);

  DPrevSell.Left := 198;
  DPrevSell.Top := 389;
  DPrevSell.SetImgIndex(g_WCqFirImages, 45);

  DRefreshSell.Left := 247;
  DRefreshSell.Top := 388;
  DRefreshSell.SetImgIndex(g_WCqFirImages, 48);

  DNextSell.Left := 302;
  DNextSell.Top := 388;
  DNextSell.SetImgIndex(g_WCqFirImages, 44);

  }
  {-----------------------------------------------------------}

  d := g_WMain3Images.Images[510];
  if d <> nil then begin
    DBoxItems.Left := (SCREENWIDTH - d.Width) div 2;
    DBoxItems.Top := (SCREENHEIGHT - d.Height) div 2;
    DBoxItems.SetImgIndex(g_WMain3Images, 510);
  end;

  DBoxItemGrid.Left := 22;
  DBoxItemGrid.Top := 16;
  DBoxItemGrid.ColWidth := 52;
  DBoxItemGrid.RowHeight := 48;
  DBoxItemGrid.Width := DBoxItemGrid.ColWidth * 3;
  DBoxItemGrid.Height := DBoxItemGrid.RowHeight * 3;

  {DBoxItemGrid.Width := DBoxItems.Width - 44;
  DBoxItemGrid.Height := DBoxItems.Height - 44 - 10;  }

  d := g_WMain3Images.Images[520];
  if d <> nil then begin
    DItemBox.Left := (SCREENWIDTH - d.Width) div 2;
    DItemBox.Top := (SCREENHEIGHT - d.Height) div 2 - 60;
    DItemBox.SetImgIndex(g_WMain3Images, 520);
  end;

  DItemLock.Left := 176;
  DItemLock.Top := 190;
  DItemLock.Width := 22;
  DItemLock.Height := 32;

 { d := g_WMain3Images.Images[510];
  if d <> nil then begin
    DGetBoxItem.SetImgIndex(g_WMain3Images, 510);
    DGetBoxItem.Left := (DBoxItems.Width - d.Width) div 2;
    DGetBoxItem.Top := DBoxItems.Top - d.Height;
  end;  }

  {d := g_WMain3Images.Images[515];
  if d <> nil then begin
    DGetBoxItemFlash.Left := (DItemBox.Width - d.Width) div 2;
    DGetBoxItemFlash.Top := DItemBox.Height - 50 - 2;
  end;  }

  DGetBoxItemFlash.Left := (DBoxItems.Width - 20) div 2;
  DGetBoxItemFlash.Top := 180;
  DGetBoxItemFlash.Width := 20;
  DGetBoxItemFlash.Height := 15;

  d := g_WUIBImages.Images[0];
  if d <> nil then begin
    DBook.SetImgIndex(g_WUIBImages, 0);
    DBook.Left := (SCREENWIDTH - d.Width) div 2;
    DBook.Top := (SCREENHEIGHT - d.Height) div 2 - 90;
  end;

  d := g_WBookImages.Images[0];
  if d <> nil then begin
    DBookPage.SetImgIndex(g_WBookImages, 0);
    DBookPage.Left := (DBook.Width - d.Width) div 2;
    DBookPage.Top := (DBook.Height - d.Height) div 2;
  end;

  d := g_WUIBImages.Images[1];
  if d <> nil then begin
    DBookClose.SetImgIndex(g_WUIBImages, 1);
    DBookClose.Left := DBook.Width - d.Width - 3;
    DBookClose.Top := 0;
  end;

  d := g_WUIBImages.Images[5];
  if d <> nil then begin
    DBookPrevPage.SetImgIndex(g_WUIBImages, 5);
    DBookPrevPage.Left := 48;
    DBookPrevPage.Top := 318;
  end;

  d := g_WUIBImages.Images[3];
  if d <> nil then begin
    DBookNextPage.SetImgIndex(g_WUIBImages, 3);
    DBookNextPage.Left := 470 - d.Width;
    DBookNextPage.Top := 318;
  end;

  //行会
  d := g_WMainImages.Images[180];
  if d <> nil then begin
    DGuildDlg.Left := 0;
    DGuildDlg.Top := 0;
    DGuildDlg.SetImgIndex(g_WMainImages, 180);
  end;
  DGDClose.Left := 584;
  DGDClose.Top := 6;
  DGDClose.SetImgIndex(g_WMainImages, 64);
  DGDHome.Left := 13;
  DGDHome.Top := 411;
  DGDHome.SetImgIndex(g_WMainImages, 198);
  DGDList.Left := 13;
  DGDList.Top := 429;
  DGDList.SetImgIndex(g_WMainImages, 200);
  DGDChat.Left := 94;
  DGDChat.Top := 429;
  DGDChat.SetImgIndex(g_WMainImages, 190);
  DGDAddMem.Left := 243;
  DGDAddMem.Top := 411;
  DGDAddMem.SetImgIndex(g_WMainImages, 182);
  DGDDelMem.Left := 243;
  DGDDelMem.Top := 429;
  DGDDelMem.SetImgIndex(g_WMainImages, 192);
  DGDEditNotice.Left := 325;
  DGDEditNotice.Top := 411;
  DGDEditNotice.SetImgIndex(g_WMainImages, 196);
  DGDEditGrade.Left := 325;
  DGDEditGrade.Top := 429;
  DGDEditGrade.SetImgIndex(g_WMainImages, 194);
  DGDAlly.Left := 407;
  DGDAlly.Top := 411;
  DGDAlly.SetImgIndex(g_WMainImages, 184);
  DGDBreakAlly.Left := 407;
  DGDBreakAlly.Top := 429;
  DGDBreakAlly.SetImgIndex(g_WMainImages, 186);
  DGDWar.Left := 529;
  DGDWar.Top := 411;
  DGDWar.SetImgIndex(g_WMainImages, 202);
  DGDCancelWar.Left := 529;
  DGDCancelWar.Top := 429;
  DGDCancelWar.SetImgIndex(g_WMainImages, 188);

  DGDUp.Left := 595;
  DGDUp.Top := 239;
  DGDUp.SetImgIndex(g_WMainImages, 373);
  DGDDown.Left := 595;
  DGDDown.Top := 291;
  DGDDown.SetImgIndex(g_WMainImages, 372);

  //行会通告编辑框
  DGuildEditNotice.SetImgIndex(g_WMainImages, 204);
  DGEOk.SetImgIndex(g_WMainImages, 361);
  DGEOk.Left := 514;
  DGEOk.Top := 287;
  DGEClose.SetImgIndex(g_WMainImages, 64);
  DGEClose.Left := 584;
  DGEClose.Top := 6;


  {-----------------------------------------------------------}
  //属性调整对话框
  DAdjustAbility.SetImgIndex(g_WMainImages, 226);
  DAdjustAbilClose.SetImgIndex(g_WMainImages, 64);
  DAdjustAbilClose.Left := 316;
  DAdjustAbilClose.Top := 1;
  DAdjustAbilOk.SetImgIndex(g_WMainImages, 224);
  DAdjustAbilOk.Left := 220;
  DAdjustAbilOk.Top := 298;

  DPlusDC.SetImgIndex(g_WMainImages, 212);
  DPlusDC.Left := 217;
  DPlusDC.Top := 101;
  DPlusMC.SetImgIndex(g_WMainImages, 212);
  DPlusMC.Left := 217;
  DPlusMC.Top := 121;
  DPlusSC.SetImgIndex(g_WMainImages, 212);
  DPlusSC.Left := 217;
  DPlusSC.Top := 140;
  DPlusAC.SetImgIndex(g_WMainImages, 212);
  DPlusAC.Left := 217;
  DPlusAC.Top := 160;
  DPlusMAC.SetImgIndex(g_WMainImages, 212);
  DPlusMAC.Left := 217;
  DPlusMAC.Top := 181;
  DPlusHP.SetImgIndex(g_WMainImages, 212);
  DPlusHP.Left := 217;
  DPlusHP.Top := 201;
  DPlusMP.SetImgIndex(g_WMainImages, 212);
  DPlusMP.Left := 217;
  DPlusMP.Top := 220;
  DPlusHit.SetImgIndex(g_WMainImages, 212);
  DPlusHit.Left := 217;
  DPlusHit.Top := 240;
  DPlusSpeed.SetImgIndex(g_WMainImages, 212);
  DPlusSpeed.Left := 217;
  DPlusSpeed.Top := 261;

  DMinusDC.SetImgIndex(g_WMainImages, 214);
  DMinusDC.Left := 227 + 6;
  DMinusDC.Top := 101;
  DMinusMC.SetImgIndex(g_WMainImages, 214);
  DMinusMC.Left := 227 + 6;
  DMinusMC.Top := 121;
  DMinusSC.SetImgIndex(g_WMainImages, 214);
  DMinusSC.Left := 227 + 6;
  DMinusSC.Top := 140;
  DMinusAC.SetImgIndex(g_WMainImages, 214);
  DMinusAC.Left := 227 + 6;
  DMinusAC.Top := 160;
  DMinusMAC.SetImgIndex(g_WMainImages, 214);
  DMinusMAC.Left := 227 + 6;
  DMinusMAC.Top := 181;
  DMinusHP.SetImgIndex(g_WMainImages, 214);
  DMinusHP.Left := 227 + 6;
  DMinusHP.Top := 201;
  DMinusMP.SetImgIndex(g_WMainImages, 214);
  DMinusMP.Left := 227 + 6;
  DMinusMP.Top := 220;
  DMinusHit.SetImgIndex(g_WMainImages, 214);
  DMinusHit.Left := 227 + 6;
  DMinusHit.Top := 240;
  DMinusSpeed.SetImgIndex(g_WMainImages, 214);
  DMinusSpeed.Left := 227 + 6;
  DMinusSpeed.Top := 261;

  DEditAdjustIncrement.Left := 150;
  DEditAdjustIncrement.Top := 303;
  DEditAdjustIncrement.Width := 65;

  DLabelAdjustIncrement.Left := 34;
  DLabelAdjustIncrement.Top := 304;
  DLabelAdjustIncrement.Width := 116;
  DLabelAdjustIncrement.Height := 14;

  {d := g_WMain3Images.Images[34];
  if d <> nil then begin
    DFriendDlg.SetImgIndex(g_WMain3Images, 34);
    DFriendDlg.Left := 0;
    DFriendDlg.Top := 0;
  end;
  DFrdClose.SetImgIndex(g_WMainImages, 371);
  DFrdClose.Left := 247;
  DFrdClose.Top := 5;
  DFrdPgUp.SetImgIndex(g_WMainImages, 373);
  DFrdPgUp.Left := 259;
  DFrdPgUp.Top := 102;
  DFrdPgDn.SetImgIndex(g_WMainImages, 372);
  DFrdPgDn.Left := 259;
  DFrdPgDn.Top := 154;
  DFrdFriend.SetImgIndex(g_WMain3Images, 42);
  DFrdFriend.Left := 15;
  DFrdFriend.Top := 35;
  DFrdBlackList.SetImgIndex(g_WMainImages, 573);
  DFrdBlackList.Left := 130;
  DFrdBlackList.Top := 35;
  DFrdAdd.SetImgIndex(g_WMainImages, 554);
  DFrdAdd.Left := 90;
  DFrdAdd.Top := 233;
  DFrdDel.SetImgIndex(g_WMainImages, 556);
  DFrdDel.Left := 124;
  DFrdDel.Top := 233;
  DFrdMemo.SetImgIndex(g_WMainImages, 558);
  DFrdMemo.Left := 158;
  DFrdMemo.Top := 233;
  DFrdMail.SetImgIndex(g_WMainImages, 560);
  DFrdMail.Left := 192;
  DFrdMail.Top := 233;
  DFrdWhisper.SetImgIndex(g_WMainImages, 562);
  DFrdWhisper.Left := 226;
  DFrdWhisper.Top := 233;  }

  d := g_WMainImages.Images[536];
  if d <> nil then begin
    DMailListDlg.SetImgIndex(g_WMainImages, 536);
    DMailListDlg.Left := 512;
    DMailListDlg.Top := 0;
  end;
  DMailListClose.SetImgIndex(g_WMainImages, 371);
  DMailListClose.Left := 247;
  DMailListClose.Top := 5;
  DMailListPgUp.SetImgIndex(g_WMainImages, 373);
  DMailListPgUp.Left := 259;
  DMailListPgUp.Top := 102;
  DMailListPgDn.SetImgIndex(g_WMainImages, 372);
  DMailListPgDn.Left := 259;
  DMailListPgDn.Top := 154;
  DMLReply.SetImgIndex(g_WMainImages, 564);
  DMLReply.Left := 90;
  DMLReply.Top := 233;
  DMLRead.SetImgIndex(g_WMainImages, 566);
  DMLRead.Left := 124;
  DMLRead.Top := 233;
  DMLDel.SetImgIndex(g_WMainImages, 556);
  DMLDel.Left := 158;
  DMLDel.Top := 233;
  DMLLock.SetImgIndex(g_WMainImages, 568);
  DMLLock.Left := 192;
  DMLLock.Top := 233;
  DMLBlock.SetImgIndex(g_WMainImages, 570);
  DMLBlock.Left := 226;
  DMLBlock.Top := 233;

  d := g_WMainImages.Images[536];
  if d <> nil then begin
    DBlockListDlg.SetImgIndex(g_WMainImages, 536);
    DBlockListDlg.Left := 512;
    DBlockListDlg.Top := 0;
  end;
  DBlockListClose.SetImgIndex(g_WMainImages, 371);
  DBlockListClose.Left := 247;
  DBlockListClose.Top := 5;
  DBLPgUp.SetImgIndex(g_WMainImages, 373);
  DBLPgUp.Left := 259;
  DBLPgUp.Top := 102;
  DBLPgDn.SetImgIndex(g_WMainImages, 372);
  DBLPgDn.Left := 259;
  DBLPgDn.Top := 154;
  DBLAdd.SetImgIndex(g_WMainImages, 554);
  DBLAdd.Left := 192;
  DBLAdd.Top := 233;
  DBLDel.SetImgIndex(g_WMainImages, 556);
  DBLDel.Left := 226;
  DBLDel.Top := 233;

  d := g_WMainImages.Images[537];
  if d <> nil then begin
    DMemo.SetImgIndex(g_WMainImages, 537);
    DMemo.Left := 290;
    DMemo.Top := 0;
  end;
  DMemoClose.SetImgIndex(g_WMainImages, 371);
  DMemoClose.Left := 205;
  DMemoClose.Top := 1;
  DMemoB1.SetImgIndex(g_WMainImages, 544);
  DMemoB1.Left := 58;
  DMemoB1.Top := 114;
  DMemoB2.SetImgIndex(g_WMainImages, 538);
  DMemoB2.Left := 126;
  DMemoB2.Top := 114;

  DButtonHP.Left := 40;
  DButtonHP.Top := 91;
  DButtonHP.Width := 45;
  DButtonHP.Height := 90;

  DButtonMP.Left := 40 + 47;
  DButtonMP.Top := 91;
  DButtonMP.Width := 45;
  DButtonMP.Height := 90;
  {
     //背包物品窗口
     DItemBag.SetImgIndex (g_WMain3Images, 6);
     DItemBag.Left := 0;
     DItemBag.Top := 0;

     DItemGrid.Left := 29;
     DItemGrid.Top  := 41;
     DItemGrid.Width := 286;
     DItemGrid.Height := 162;

     DClosebag.Downed:=True;
     DCloseBag.Left := 336;
     DCloseBag.Top := 59;
     DCloseBag.Width := 14;
     DCloseBag.Height := 20;

     DGold.Left := 18;
     DGold.Top  := 218;
     d := g_WMain3Images.Images[207];  //惑怕
     if d <> nil then begin
        DStateWin.SetImgIndex (g_WMain3Images, 207);
        DStateWin.Left := SCREENWIDTH - d.Width;
        DStateWin.Top := 0;
     end;}

  d := g_WMain3Images.Images[406];
  if d <> nil then begin
    DFindChr.SetImgIndex(g_WMain3Images, 406);
    DFindChr.Left := (SCREENWIDTH - d.Width) div 2;
    DFindChr.Top := (SCREENHEIGHT - d.Height) div 2;
  end;

  DFindOK.SetImgIndex(g_WMain3Images, 407);
  DFindChrClose.SetImgIndex(g_WMainImages, 64);

  DFindOK.Left := 104;
  DFindOK.Top := 361;
  DFindChrClose.Left := 248;
  DFindChrClose.Top := 31;


  {-----------------------------------------------------------}
  //挑战对话框
  d := g_WMain3Images.Images[465]; //挑战方
  if d <> nil then begin
    DWDuel.Left := SCREENWIDTH - d.Width;
    DWDuel.Top := 0;
    DWDuel.SetImgIndex(g_WMain3Images, 465);
  end;
  DDDuelGrid.Left := 27;
  DDDuelGrid.Top := 156;
  DDDuelGrid.Width := 38 * 5;
  DDDuelGrid.Height := 33;

  DDDuelGold.SetImgIndex(g_WMainImages, 28);
  DDDuelGold.Left := 27;
  DDDuelGold.Top := 202 - 4;

  DDRDuelGrid.Left := 27;
  DDRDuelGrid.Top := 56;
  DDRDuelGrid.Width := 38 * 5;
  DDRDuelGrid.Height := 33;

  DDRDuelGold.SetImgIndex(g_WMainImages, 28);
  DDRDuelGold.Left := 27;
  DDRDuelGold.Top := 56 + 33 + 8;

  DDuelOK.SetImgIndex(g_WMain3Images, 463);
  DDuelOK.Left := 76 - 3;
  DDuelOK.Top := 250 - 20;

  DDuelCancel.SetImgIndex(g_WMain3Images, 466);
  DDuelCancel.Left := 128 - 6;
  DDuelCancel.Top := 250 - 19;

  DDuelClose.SetImgIndex(g_WMainImages, 64);
  DDuelClose.Left := 240;
  DDuelClose.Top := 0;


  DStoreDlg.SetImgIndex(g_WCqFirImages, 156);
  DStoreDlg.Left := (SCREENWIDTH - DStoreDlg.Width) div 2;
  DStoreDlg.Top := (SCREENHEIGHT - DStoreDlg.Height - 50) div 2;

  DGStore.Left := 20;
  DGStore.Top := 80;
  DGStore.Width := 41 * 5;
  DGStore.Height := 38 * 3;

  DStoreOpen.SetImgIndex(g_WCqFirImages, 165);
  DStoreOpen.Left := 95;
  DStoreOpen.Top := 208;

  DStoreCancel.SetImgIndex(g_WCqFirImages, 173);
  DStoreCancel.Left := 163;
  DStoreCancel.Top := 208;

  DStoreClose.SetImgIndex(g_WMainImages, 64);
  DStoreClose.Left := 245;
  DStoreClose.Top := 1;

  DStoreName.SetImgIndex(g_WCqFirImages, 171);
  DStoreName.Left := 16;
  DStoreName.Top := 52;

  DEditStore.Left := 25;
  DEditStore.Top := 306;
  DEditStore.Width := 190;
  DEditStore.Text := '';



  DUserStore.SetImgIndex(g_WCqFirImages, 163);
  DUserStore.Left := (SCREENWIDTH - DUserStore.Width) div 2;
  DUserStore.Top := (SCREENHEIGHT - DUserStore.Height - 50) div 2;

  DUserStoreClose.SetImgIndex(g_WMainImages, 64);
  DUserStoreClose.Left := 245;
  DUserStoreClose.Top := 1;

  DGUserStore.Left := 20;
  DGUserStore.Top := 52;
  DGUserStore.Width := 41 * 5;
  DGUserStore.Height := 38 * 3;


  DUserStoreBuy.SetImgIndex(g_WCqFirImages, 161);
  DUserStoreBuy.Left := 170;
  DUserStoreBuy.Top := 208;

  DEditUserStore.Left := 25;
  DEditUserStore.Top := 306;
  DEditUserStore.Width := 190;
  DEditUserStore.Text := '';




  DStoreMsgDlg.SetImgIndex(g_WCqFirImages, 157);
  DStoreMsgDlg.Left := (SCREENWIDTH - DUserStore.Width) div 2;
  DStoreMsgDlg.Top := (SCREENHEIGHT - DUserStore.Height - 50) div 2;

  DStoreMsgDlgOk.SetImgIndex(g_WCqFirImages, 169);
  DStoreMsgDlgOk.Left := 88;
  DStoreMsgDlgOk.Top := 97;

  DStoreMsgDlgCancel.SetImgIndex(g_WCqFirImages, 167);
  DStoreMsgDlgCancel.Left := 228;
  DStoreMsgDlgCancel.Top := 97;

  EdStoreDlgEdit.Left := 132;
  EdStoreDlgEdit.Top := 66;
  EdStoreDlgEdit.Width := 152;
  EdStoreDlgEdit.Text := '';




  DWRandomCode.SetImgIndex(g_WMain3Images, 43);
  DWRandomCode.Left := (SCREENWIDTH - DWRandomCode.Width) div 2;
  DWRandomCode.Top := (SCREENHEIGHT - DWRandomCode.Height) div 2;

  DBRandomCodeOK.SetImgIndex(g_WCqFirImages, 183);
  DBRandomCodeOK.Left := 35;
  DBRandomCodeOK.Top := 112;

  DBRandomCodeChg.SetImgIndex(g_WCqFirImages, 185);
  DBRandomCodeChg.Left := 115;
  DBRandomCodeChg.Top := 112;

  DEditRandomCode.Left := 93;
  DEditRandomCode.Top := 9;
  DEditRandomCode.Width := 93;
  DEditRandomCode.Text := '';



   //配置窗口
  d := g_WMain2Images.Images[607];
  if d <> nil then begin
    DConfigDlg.SetImgIndex(g_WMain2Images, 607);
    DConfigDlg.Left := (SCREENWIDTH - d.Width) div 2;
    DConfigDlg.Top := (SCREENHEIGHT - d.Height) div 2;
  end;
  DConfigDlgClose.Left := DConfigDlg.Width - 22;
  DConfigDlgClose.Top := 2;
  DConfigDlgClose.SetImgIndex(g_WMain2Images, 279);

  DButtonTab1.Left := 10;
  DButtonTab1.Top := 12;
  DButtonTab1.SetImgIndex(g_WMain2Images, 608);
  DButtonTab2.Left := 10 + 48;
  DButtonTab2.Top := 12;
  DButtonTab2.SetImgIndex(g_WMain2Images, 608);
  DButtonTab3.Left := 10 + 48 * 2;
  DButtonTab3.Top := 12;
  DButtonTab3.SetImgIndex(g_WMain2Images, 608);
  DButtonTab4.Left := 10 + 48 * 3;
  DButtonTab4.Top := 12;
  DButtonTab4.SetImgIndex(g_WMain2Images, 608);
  DButtonTab5.Left := 10 + 48 * 4;
  DButtonTab5.Top := 12;
  DButtonTab5.SetImgIndex(g_WMain2Images, 608);
  DButtonTab6.Left := 10 + 48 * 5;
  DButtonTab6.Top := 12;
  DButtonTab6.SetImgIndex(g_WMain2Images, 608);
  DButtonTab7.Left := 10 + 48 * 6;
  DButtonTab7.Top := 12;
  DButtonTab7.SetImgIndex(g_WMain2Images, 608);
  DButtonTab8.Left := 10 + 48 * 7;
  DButtonTab8.Top := 12;
  DButtonTab8.SetImgIndex(g_WMain2Images, 608);



  DConfigDlg.TabLeft := 14;
  DConfigDlg.TabTop := 36;
  DConfigDlg.TabWidth := 384;
  DConfigDlg.TabHeight := 206;


  DMemoTab1.Left := 20;
  DMemoTab1.Top := 20;
  DMemoTab1.Width := 384 - 16 - 20;
  DMemoTab1.Height := 208 - 20;

  DMemoTab2.Left := 12;
  DMemoTab2.Top := 24 + 4;
  DMemoTab2.Width := 384 - 16 - 18;
  DMemoTab2.Height := 206 - 14 - 24 - 10 - 6;


  DMemoTab3.Left := 10;
  DMemoTab3.Top := 10;
  DMemoTab3.Width := 384 - 16 - 10;
  DMemoTab3.Height := 208 - 10;

  DMemoTab4.Left := 10;
  DMemoTab4.Top := 10;
  DMemoTab4.Width := 384 - 16;
  DMemoTab4.Height := 208;

  DMemoTab5.Left := 0;
  DMemoTab5.Top := 0;
  DMemoTab5.Width := 384 - 16;
  DMemoTab5.Height := 208;

  DMemoTab6.Left := 0;
  DMemoTab6.Top := 0;
  DMemoTab6.Width := 384 - 16;
  DMemoTab6.Height := 208;

  DMemoTab7.Left := 0;
  DMemoTab7.Top := 0;
  DMemoTab7.Width := 384 - 16;
  DMemoTab7.Height := 208;

  DMemoTab8.Left := 1;
  DMemoTab8.Top := 10;
  DMemoTab8.Width := 384 - 18;
  DMemoTab8.Height := 208 - 10;

  //DScrollTab1.VisibleScroll:=False;
  DScrollTab1.SetImgIndex(g_WMain2Images, 291);
  DScrollTab1.LeftButton.SetImgIndex(g_WMain2Images, 292);
  DScrollTab1.RightButton.SetImgIndex(g_WMain2Images, 294);
  DScrollTab1.CenterButton.SetImgIndex(g_WMain2Images, 581);
  DScrollTab1.LeftButton.OnDirectPaint := DScrollScrollDirectPaint;
  DScrollTab1.RightButton.OnDirectPaint := DScrollScrollDirectPaint;
  DScrollTab1.OnDirectPaint := DScrollCenterScrollDirectPaint;
  DScrollTab1.Left := 384 - DScrollTab1.Width + 1;
  DScrollTab1.Top := 0;
  DScrollTab1.Height := 208;
  DScrollTab1.Increment := 12;
  DScrollTab1.LeftButton.Left := 1;
  DScrollTab1.LeftButton.Top := 1;
  DScrollTab1.RightButton.Left := 1;
  DScrollTab1.RightButton.Top := DScrollTab1.Height - DScrollTab1.RightButton.Height - 1;
  DScrollTab1.CenterButton.Left := 1;
  DScrollTab1.CenterButton.Top := DScrollTab1.LeftButton.Top + DScrollTab1.LeftButton.Height;

  DScrollTab2.SetImgIndex(g_WMain2Images, 291);
  DScrollTab2.LeftButton.SetImgIndex(g_WMain2Images, 292);
  DScrollTab2.RightButton.SetImgIndex(g_WMain2Images, 294);
  DScrollTab2.CenterButton.SetImgIndex(g_WMain2Images, 581);
  DScrollTab2.LeftButton.OnDirectPaint := DScrollScrollDirectPaint;
  DScrollTab2.RightButton.OnDirectPaint := DScrollScrollDirectPaint;
  DScrollTab2.OnDirectPaint := DScrollCenterScrollDirectPaint;
  DScrollTab2.Left := 384 - DScrollTab2.Width + 1;
  DScrollTab2.Top := 0;
  DScrollTab2.Height := 208;
  DScrollTab2.Increment := 17;
  DScrollTab2.LeftButton.Left := 1;
  DScrollTab2.LeftButton.Top := 1;
  DScrollTab2.RightButton.Left := 1;
  DScrollTab2.RightButton.Top := DScrollTab2.Height - DScrollTab2.RightButton.Height - 1;
  DScrollTab2.CenterButton.Left := 1;
  DScrollTab2.CenterButton.Top := DScrollTab2.LeftButton.Top + DScrollTab2.LeftButton.Height;

  DScrollTab3.SetImgIndex(g_WMain2Images, 291);
  DScrollTab3.LeftButton.SetImgIndex(g_WMain2Images, 292);
  DScrollTab3.RightButton.SetImgIndex(g_WMain2Images, 294);
  DScrollTab3.CenterButton.SetImgIndex(g_WMain2Images, 581);
  DScrollTab3.LeftButton.OnDirectPaint := DScrollScrollDirectPaint;
  DScrollTab3.RightButton.OnDirectPaint := DScrollScrollDirectPaint;
  DScrollTab3.OnDirectPaint := DScrollCenterScrollDirectPaint;
  DScrollTab3.Left := 384 - DScrollTab3.Width + 1;
  DScrollTab3.Top := 0;
  DScrollTab3.Height := 208;
  DScrollTab3.Increment := 12;
  DScrollTab3.LeftButton.Left := 1;
  DScrollTab3.LeftButton.Top := 1;
  DScrollTab3.RightButton.Left := 1;
  DScrollTab3.RightButton.Top := DScrollTab3.Height - DScrollTab3.RightButton.Height - 1;
  DScrollTab3.CenterButton.Left := 1;
  DScrollTab3.CenterButton.Top := DScrollTab3.LeftButton.Top + DScrollTab3.LeftButton.Height;


  DScrollTab4.SetImgIndex(g_WMain2Images, 291);
  DScrollTab4.LeftButton.SetImgIndex(g_WMain2Images, 292);
  DScrollTab4.RightButton.SetImgIndex(g_WMain2Images, 294);
  DScrollTab4.CenterButton.SetImgIndex(g_WMain2Images, 581);
  DScrollTab4.LeftButton.OnDirectPaint := DScrollScrollDirectPaint;
  DScrollTab4.RightButton.OnDirectPaint := DScrollScrollDirectPaint;
  DScrollTab4.OnDirectPaint := DScrollCenterScrollDirectPaint;
  DScrollTab4.Left := 384 - DScrollTab4.Width + 1;
  DScrollTab4.Top := 0;
  DScrollTab4.Height := 208;
  DScrollTab4.Increment := 12;
  DScrollTab4.LeftButton.Left := 1;
  DScrollTab4.LeftButton.Top := 1;
  DScrollTab4.RightButton.Left := 1;
  DScrollTab4.RightButton.Top := DScrollTab4.Height - DScrollTab4.RightButton.Height - 1;
  DScrollTab4.CenterButton.Left := 1;
  DScrollTab4.CenterButton.Top := DScrollTab4.LeftButton.Top + DScrollTab4.LeftButton.Height;

  DScrollTab5.SetImgIndex(g_WMain2Images, 291);
  DScrollTab5.LeftButton.SetImgIndex(g_WMain2Images, 292);
  DScrollTab5.RightButton.SetImgIndex(g_WMain2Images, 294);
  DScrollTab5.CenterButton.SetImgIndex(g_WMain2Images, 581);
  DScrollTab5.LeftButton.OnDirectPaint := DScrollScrollDirectPaint;
  DScrollTab5.RightButton.OnDirectPaint := DScrollScrollDirectPaint;
  DScrollTab5.OnDirectPaint := DScrollCenterScrollDirectPaint;
  DScrollTab5.Left := 384 - DScrollTab5.Width + 1;
  DScrollTab5.Top := 0;
  DScrollTab5.Height := 208;
  DScrollTab5.Increment := 12;
  DScrollTab5.LeftButton.Left := 1;
  DScrollTab5.LeftButton.Top := 1;
  DScrollTab5.RightButton.Left := 1;
  DScrollTab5.RightButton.Top := DScrollTab5.Height - DScrollTab5.RightButton.Height - 1;
  DScrollTab5.CenterButton.Left := 1;
  DScrollTab5.CenterButton.Top := DScrollTab5.LeftButton.Top + DScrollTab5.LeftButton.Height;

  DScrollTab6.SetImgIndex(g_WMain2Images, 291);
  DScrollTab6.LeftButton.SetImgIndex(g_WMain2Images, 292);
  DScrollTab6.RightButton.SetImgIndex(g_WMain2Images, 294);
  DScrollTab6.CenterButton.SetImgIndex(g_WMain2Images, 581);
  DScrollTab6.LeftButton.OnDirectPaint := DScrollScrollDirectPaint;
  DScrollTab6.RightButton.OnDirectPaint := DScrollScrollDirectPaint;
  DScrollTab6.OnDirectPaint := DScrollCenterScrollDirectPaint;
  DScrollTab6.Left := 384 - DScrollTab6.Width + 1;
  DScrollTab6.Top := 0;
  DScrollTab6.Height := 208;
  DScrollTab6.Increment := 12;
  DScrollTab6.LeftButton.Left := 1;
  DScrollTab6.LeftButton.Top := 1;
  DScrollTab6.RightButton.Left := 1;
  DScrollTab6.RightButton.Top := DScrollTab6.Height - DScrollTab6.RightButton.Height - 1;
  DScrollTab6.CenterButton.Left := 1;
  DScrollTab6.CenterButton.Top := DScrollTab6.LeftButton.Top + DScrollTab6.LeftButton.Height;

  DScrollTab7.SetImgIndex(g_WMain2Images, 291);
  DScrollTab7.LeftButton.SetImgIndex(g_WMain2Images, 292);
  DScrollTab7.RightButton.SetImgIndex(g_WMain2Images, 294);
  DScrollTab7.CenterButton.SetImgIndex(g_WMain2Images, 581);
  DScrollTab7.LeftButton.OnDirectPaint := DScrollScrollDirectPaint;
  DScrollTab7.RightButton.OnDirectPaint := DScrollScrollDirectPaint;
  DScrollTab7.OnDirectPaint := DScrollCenterScrollDirectPaint;
  DScrollTab7.Left := 384 - DScrollTab7.Width + 1;
  DScrollTab7.Top := 0;
  DScrollTab7.Height := 208;
  DScrollTab7.Increment := 12;
  DScrollTab7.LeftButton.Left := 1;
  DScrollTab7.LeftButton.Top := 1;
  DScrollTab7.RightButton.Left := 1;
  DScrollTab7.RightButton.Top := DScrollTab7.Height - DScrollTab7.RightButton.Height - 1;
  DScrollTab7.CenterButton.Left := 1;
  DScrollTab7.CenterButton.Top := DScrollTab7.LeftButton.Top + DScrollTab7.LeftButton.Height;

  DScrollTab8.SetImgIndex(g_WMain2Images, 291);
  DScrollTab8.LeftButton.SetImgIndex(g_WMain2Images, 292);
  DScrollTab8.RightButton.SetImgIndex(g_WMain2Images, 294);
  DScrollTab8.CenterButton.SetImgIndex(g_WMain2Images, 581);
  DScrollTab8.LeftButton.OnDirectPaint := DScrollScrollDirectPaint;
  DScrollTab8.RightButton.OnDirectPaint := DScrollScrollDirectPaint;
  DScrollTab8.OnDirectPaint := DScrollCenterScrollDirectPaint;
  DScrollTab8.Left := 384 - DScrollTab8.Width + 1;
  DScrollTab8.Top := 0;
  DScrollTab8.Height := 208;
  DScrollTab8.Increment := 12;
  DScrollTab8.LeftButton.Left := 1;
  DScrollTab8.LeftButton.Top := 1;
  DScrollTab8.RightButton.Left := 1;
  DScrollTab8.RightButton.Top := DScrollTab8.Height - DScrollTab8.RightButton.Height - 1;
  DScrollTab8.CenterButton.Left := 1;
  DScrollTab8.CenterButton.Top := DScrollTab8.LeftButton.Top + DScrollTab8.LeftButton.Height;

{----------------------DMemoTab1------------------------------}
  {DMemoTab1.PosX := 20;
  DMemoTab1.PosY := 20;  }

  DCheckBoxShowMoveNumberLable.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxMusic.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxOrderItem.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxItemDuraHint.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxCompareItem.SetImgIndex(g_WMain2Images, 228);

  DCheckBoxShowMoveNumberLable.Left := 0;
  DCheckBoxShowMoveNumberLable.Top := 0;

  DCheckBoxItemDuraHint.Left := 68 + 35;
  DCheckBoxItemDuraHint.Top := 0;

  DCheckBoxMusic.Left := 68 * 2 + 35 * 2;
  DCheckBoxMusic.Top := 0;

  DCheckBoxOrderItem.Left := 0;
  DCheckBoxOrderItem.Top := 30;

  DCheckBoxCompareItem.Left := 68 + 35;
  DCheckBoxCompareItem.Top := 30;

  ItemList := DMemoTab1.Add;
  DMemoTab1.AddSuItem(ItemList, DCheckBoxShowMoveNumberLable);
  DMemoTab1.AddSuItem(ItemList, DCheckBoxItemDuraHint);
  DMemoTab1.AddSuItem(ItemList, DCheckBoxMusic);

  ItemList := DMemoTab1.Add;
  DMemoTab1.AddSuItem(ItemList, DCheckBoxOrderItem);
  DMemoTab1.AddSuItem(ItemList, DCheckBoxCompareItem);

{----------------------DMemoTab2------------------------------}

  DLabelItemName.Left := 10;
  DLabelItemName.Top := 10;

  DLabelItemHint.Left := 147;
  DLabelItemHint.Top := 10;

  DLabelPickUpItem.Left := 220;
  DLabelPickUpItem.Top := 10;

  DLabelShowItemName.Left := 288;
  DLabelShowItemName.Top := 10;

  DComboboxItemType.Left := 10;
  DComboboxItemType.Top := 206 - 10 - 12;
  DMenuItemType.Width := DComboboxItemType.Width;


  DEditSearchItem.Left := 98;
  DEditSearchItem.Top := 206 - 10 - 12;
  DEditSearchItem.Width := 120;
  DEditSearchItem.Text := '';

  DLabelOption.Left := 230;
  DLabelOption.Top := 206 - 10 - 12 + 2;
  DLabelOption.Font.Style := [fsUnderline];

  DCheckBoxPickUpItemAll.Left := 290;
  DCheckBoxPickUpItemAll.Top := 206 - 10 - 12 + 2;
  DCheckBoxPickUpItemAll.SetImgIndex(g_WMain2Images, 228);



  //DMemoTab2.ItemSize := 24;


{----------------------DMemoTab3------------------------------}
  DCheckBoxHumHP1.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxHumMP1.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxHumHP2.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxHumMP2.SetImgIndex(g_WMain2Images, 228);


  DCheckBoxHumHP1.Left := 8;
  DCheckBoxHumHP1.Top := 8;

  DCheckBoxHumMP1.Left := 8;
  DCheckBoxHumMP1.Top := 8 + 30 * 1;

  DCheckBoxHumHP2.Left := 8;
  DCheckBoxHumHP2.Top := 8 + 30 * 2;

  DCheckBoxHumMP2.Left := 8;
  DCheckBoxHumMP2.Top := 8 + 30 * 3;


  DEditHumHPPercent1.Left := 45;
  DEditHumHPPercent1.Top := 8 - 1;

  DEditHumMPPercent1.Left := 45;
  DEditHumMPPercent1.Top := 8 - 1 + 30 * 1;

  DEditHumHPPercent2.Left := 45;
  DEditHumHPPercent2.Top := 8 - 1 + 30 * 2;

  DEditHumMPPercent2.Left := 45;
  DEditHumMPPercent2.Top := 8 - 1 + 30 * 3;


  DEditHumHPPercent1.Width := 80;
  DEditHumMPPercent1.Width := 80;
  DEditHumHPPercent2.Width := 80;
  DEditHumMPPercent2.Width := 80;

  DEditHumHPPercent1.Text := '0';
  DEditHumMPPercent1.Text := '0';
  DEditHumHPPercent2.Text := '0';
  DEditHumMPPercent2.Text := '0';



  DComboboxHumHP1.Left := 140;
  DComboboxHumHP1.Top := 8;

  DComboboxHumMP1.Left := 140;
  DComboboxHumMP1.Top := 8 + 30 * 1;

  DComboboxHumHP2.Left := 140;
  DComboboxHumHP2.Top := 8 + 30 * 2;

  DComboboxHumMP2.Left := 140;
  DComboboxHumMP2.Top := 8 + 30 * 3;

  DComboboxHumHP1.Width := 100;
  DComboboxHumMP1.Width := 100;
  DComboboxHumHP2.Width := 100;
  DComboboxHumMP2.Width := 100;


  DEditHumHPTime1.Left := 250;
  DEditHumHPTime1.Top := 8 - 1;

  DEditHumMPTime1.Left := 250;
  DEditHumMPTime1.Top := 8 - 1 + 30 * 1;

  DEditHumHPTime2.Left := 250;
  DEditHumHPTime2.Top := 8 - 1 + 30 * 2;

  DEditHumMPTime2.Left := 250;
  DEditHumMPTime2.Top := 8 - 1 + 30 * 3;


  DEditHumHPTime1.Width := 46;
  DEditHumMPTime1.Width := 46;
  DEditHumHPTime2.Width := 46;
  DEditHumMPTime2.Width := 46;

  DEditHumHPTime1.Text := '0';
  DEditHumMPTime1.Text := '0';
  DEditHumHPTime2.Text := '0';
  DEditHumMPTime2.Text := '0';

  DLabelHumHP1.Left := 305;
  DLabelHumHP1.Top := 8 + 1;

  DLabelHumMP1.Left := 305;
  DLabelHumMP1.Top := 8 + 1 + 30 * 1;

  DLabelHumHP2.Left := 305;
  DLabelHumHP2.Top := 8 + 1 + 30 * 2;

  DLabelHumMP2.Left := 305;
  DLabelHumMP2.Top := 8 + 1 + 30 * 3;


  ItemList := DMemoTab3.Add;
  DMemoTab3.AddSuItem(ItemList, DCheckBoxHumHP1);
  DMemoTab3.AddSuItem(ItemList, DEditHumHPPercent1);
  DMemoTab3.AddSuItem(ItemList, DComboboxHumHP1);
  DMemoTab3.AddSuItem(ItemList, DEditHumHPTime1);
  DMemoTab3.AddSuItem(ItemList, DLabelHumHP1);

  ItemList := DMemoTab3.Add;
  DMemoTab3.AddSuItem(ItemList, DCheckBoxHumMP1);
  DMemoTab3.AddSuItem(ItemList, DEditHumMPPercent1);
  DMemoTab3.AddSuItem(ItemList, DComboboxHumMP1);
  DMemoTab3.AddSuItem(ItemList, DEditHumMPTime1);
  DMemoTab3.AddSuItem(ItemList, DLabelHumMP1);


  ItemList := DMemoTab3.Add;
  DMemoTab3.AddSuItem(ItemList, DCheckBoxHumHP2);
  DMemoTab3.AddSuItem(ItemList, DEditHumHPPercent2);
  DMemoTab3.AddSuItem(ItemList, DComboboxHumHP2);
  DMemoTab3.AddSuItem(ItemList, DEditHumHPTime2);
  DMemoTab3.AddSuItem(ItemList, DLabelHumHP2);

  ItemList := DMemoTab3.Add;
  DMemoTab3.AddSuItem(ItemList, DCheckBoxHumMP2);
  DMemoTab3.AddSuItem(ItemList, DEditHumMPPercent2);
  DMemoTab3.AddSuItem(ItemList, DComboboxHumMP2);
  DMemoTab3.AddSuItem(ItemList, DEditHumMPTime2);
  DMemoTab3.AddSuItem(ItemList, DLabelHumMP2);

{-----------------------------------------------------------}
  DLabelBookItem.Left := 8;
  DLabelBookItem.Top := 130;
  ItemList := DMemoTab3.Add;
  DMemoTab3.AddSuItem(ItemList, DLabelBookItem);

  DCheckBoxBook.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxBook.Left := 8;
  DCheckBoxBook.Top := 130 + 30;


  DLabelBookHP.Left := 44;
  DLabelBookHP.Top := 130 + 30 + 1;


  DEditBookHP.Left := 58;
  DEditBookHP.Top := 130 + 30;
  DEditBookHP.Width := 46;
  DEditBookHP.Text := '0';

  DEditBookTime.Left := 118;
  DEditBookTime.Top := 130 + 30;
  DEditBookTime.Width := 20;
  DEditBookTime.Text := '0';


  DLabelBookTime.Left := 144;
  DLabelBookTime.Top := 130 + 30 + 2;



  DLabelBookItemType.Left := 144 + 30;
  DLabelBookItemType.Top := 130 + 30 + 1;

  DComboboxBookIndex.Left := 144 + 90;
  DComboboxBookIndex.Top := 130 + 30;
  DComboboxBookIndex.Width := 80;
  DMenuBook.Width := DComboboxBookIndex.Width;


  ItemList := DMemoTab3.Add;
  DMemoTab3.AddSuItem(ItemList, DCheckBoxBook);
  DMemoTab3.AddSuItem(ItemList, DLabelBookHP);
  DMemoTab3.AddSuItem(ItemList, DEditBookHP);
  DMemoTab3.AddSuItem(ItemList, DEditBookTime);
  DMemoTab3.AddSuItem(ItemList, DLabelBookTime);

  DMemoTab3.AddSuItem(ItemList, DLabelBookItemType);
  DMemoTab3.AddSuItem(ItemList, DComboboxBookIndex);

{----------------------DMemoTab4------------------------------}
  DCheckBoxHeroHP1.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxHeroMP1.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxHeroHP2.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxHeroMP2.SetImgIndex(g_WMain2Images, 228);

  DCheckBoxHeroHP1.Left := 8;
  DCheckBoxHeroHP1.Top := 8;

  DCheckBoxHeroMP1.Left := 8;
  DCheckBoxHeroMP1.Top := 8 + 30 * 1;

  DCheckBoxHeroHP2.Left := 8;
  DCheckBoxHeroHP2.Top := 8 + 30 * 2;

  DCheckBoxHeroMP2.Left := 8;
  DCheckBoxHeroMP2.Top := 8 + 30 * 3;


  DEditHeroHPPercent1.Left := 45;
  DEditHeroHPPercent1.Top := 8 - 1;

  DEditHeroMPPercent1.Left := 45;
  DEditHeroMPPercent1.Top := 8 - 1 + 30 * 1;

  DEditHeroHPPercent2.Left := 45;
  DEditHeroHPPercent2.Top := 8 - 1 + 30 * 2;

  DEditHeroMPPercent2.Left := 45;
  DEditHeroMPPercent2.Top := 8 - 1 + 30 * 3;


  DEditHeroHPPercent1.Width := 80;
  DEditHeroMPPercent1.Width := 80;
  DEditHeroHPPercent2.Width := 80;
  DEditHeroMPPercent2.Width := 80;

  DEditHeroHPPercent1.Text := '0';
  DEditHeroMPPercent1.Text := '0';
  DEditHeroHPPercent2.Text := '0';
  DEditHeroMPPercent2.Text := '0';

  DComboboxHeroHP1.Left := 140;
  DComboboxHeroHP1.Top := 8;

  DComboboxHeroMP1.Left := 140;
  DComboboxHeroMP1.Top := 8 + 30 * 1;

  DComboboxHeroHP2.Left := 140;
  DComboboxHeroHP2.Top := 8 + 30 * 2;

  DComboboxHeroMP2.Left := 140;
  DComboboxHeroMP2.Top := 8 + 30 * 3;

  DComboboxHeroHP1.Width := 100;
  DComboboxHeroMP1.Width := 100;
  DComboboxHeroHP2.Width := 100;
  DComboboxHeroMP2.Width := 100;


  DEditHeroHPTime1.Left := 250;
  DEditHeroHPTime1.Top := 8 - 1;

  DEditHeroMPTime1.Left := 250;
  DEditHeroMPTime1.Top := 8 - 1 + 30 * 1;

  DEditHeroHPTime2.Left := 250;
  DEditHeroHPTime2.Top := 8 - 1 + 30 * 2;

  DEditHeroMPTime2.Left := 250;
  DEditHeroMPTime2.Top := 8 - 1 + 30 * 3;


  DEditHeroHPTime1.Width := 46;
  DEditHeroMPTime1.Width := 46;
  DEditHeroHPTime2.Width := 46;
  DEditHeroMPTime2.Width := 46;

  DEditHeroHPTime1.Text := '0';
  DEditHeroMPTime1.Text := '0';
  DEditHeroHPTime2.Text := '0';
  DEditHeroMPTime2.Text := '0';

  DLabelHeroHP1.Left := 305;
  DLabelHeroHP1.Top := 8 + 1;

  DLabelHeroMP1.Left := 305;
  DLabelHeroMP1.Top := 8 + 1 + 30 * 1;

  DLabelHeroHP2.Left := 305;
  DLabelHeroHP2.Top := 8 + 1 + 30 * 2;

  DLabelHeroMP2.Left := 305;
  DLabelHeroMP2.Top := 8 + 1 + 30 * 3;


  ItemList := DMemoTab4.Add;
  DMemoTab4.AddSuItem(ItemList, DCheckBoxHeroHP1);
  DMemoTab4.AddSuItem(ItemList, DEditHeroHPPercent1);
  DMemoTab4.AddSuItem(ItemList, DComboboxHeroHP1);
  DMemoTab4.AddSuItem(ItemList, DEditHeroHPTime1);
  DMemoTab4.AddSuItem(ItemList, DLabelHeroHP1);

  ItemList := DMemoTab4.Add;
  DMemoTab4.AddSuItem(ItemList, DCheckBoxHeroMP1);
  DMemoTab4.AddSuItem(ItemList, DEditHeroMPPercent1);
  DMemoTab4.AddSuItem(ItemList, DComboboxHeroMP1);
  DMemoTab4.AddSuItem(ItemList, DEditHeroMPTime1);
  DMemoTab4.AddSuItem(ItemList, DLabelHeroMP1);

  ItemList := DMemoTab4.Add;
  DMemoTab4.AddSuItem(ItemList, DCheckBoxHeroHP2);
  DMemoTab4.AddSuItem(ItemList, DEditHeroHPPercent2);
  DMemoTab4.AddSuItem(ItemList, DComboboxHeroHP2);
  DMemoTab4.AddSuItem(ItemList, DEditHeroHPTime2);
  DMemoTab4.AddSuItem(ItemList, DLabelHeroHP2);

  ItemList := DMemoTab4.Add;
  DMemoTab4.AddSuItem(ItemList, DCheckBoxHeroMP2);
  DMemoTab4.AddSuItem(ItemList, DEditHeroMPPercent2);
  DMemoTab4.AddSuItem(ItemList, DComboboxHeroMP2);
  DMemoTab4.AddSuItem(ItemList, DEditHeroMPTime2);
  DMemoTab4.AddSuItem(ItemList, DLabelHeroMP2);
{------------------------DMemoTab5---------------------------}


  DLabel1.Left := 10;
  DLabel1.Top := 10;

  DLabel3.Left := 130;
  DLabel3.Top := 10;

  DLabel10.Left := 252;
  DLabel10.Top := 10;

  ItemList := DMemoTab5.Add;
  DMemoTab5.AddSuItem(ItemList, DLabel1);

  DMemoTab5.AddSuItem(ItemList, DLabel3);
  DMemoTab5.AddSuItem(ItemList, DLabel10);

  DCheckBoxLongHit.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxLongHit.Left := 22;
  DCheckBoxLongHit.Top := 36;
  DCheckBoxAutoHideSelf.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxAutoHideSelf.Left := 140;
  DCheckBoxAutoHideSelf.Top := 36;
  DCheckBoxAutoUseMagic.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxAutoUseMagic.Left := 252;
  DCheckBoxAutoUseMagic.Top := 36;

  DEditAutoUseMagicTime.Left := 326;
  DEditAutoUseMagicTime.Top := 36;
  DEditAutoUseMagicTime.Width := 22;
  DEditAutoUseMagicTime.Text := '0';
  DLabel11.Left := 352;
  DLabel11.Top := 38;
  ItemList := DMemoTab5.Add;
  DMemoTab5.AddSuItem(ItemList, DCheckBoxLongHit);
  DMemoTab5.AddSuItem(ItemList, DCheckBoxAutoHideSelf);
  DMemoTab5.AddSuItem(ItemList, DCheckBoxAutoUseMagic);
  DMemoTab5.AddSuItem(ItemList, DEditAutoUseMagicTime);
  DMemoTab5.AddSuItem(ItemList, DLabel11);





  DCheckBoxWideHit.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxWideHit.Left := 22;
  DCheckBoxWideHit.Top := 36 + 24;
  DCheckBoxSign.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxSign.Left := 140;
  DCheckBoxSign.Top := 36 + 24;

  DComboboxAutoUseMagic.Left := 252;
  DComboboxAutoUseMagic.Top := 36 + 24;
  DComboboxAutoUseMagic.Width := 100;
  DMagicMenu.Width := 100;

  ItemList := DMemoTab5.Add;
  DMemoTab5.AddSuItem(ItemList, DCheckBoxWideHit);
  DMemoTab5.AddSuItem(ItemList, DCheckBoxSign);
  DMemoTab5.AddSuItem(ItemList, DComboboxAutoUseMagic);

//======================================================
  DCheckBoxFireHit.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxFireHit.Left := 22;
  DCheckBoxFireHit.Top := 36 + 24 * 2;

  DCheckBoxPoison.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxPoison.Left := 140;
  DCheckBoxPoison.Top := 36 + 24 * 2;


  ItemList := DMemoTab5.Add;
  DMemoTab5.AddSuItem(ItemList, DCheckBoxFireHit);
  DMemoTab5.AddSuItem(ItemList, DCheckBoxPoison);

//======================================================
  DCheckBoxSWideHit.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxSWideHit.Left := 22;
  DCheckBoxSWideHit.Top := 36 + 24 * 3;

  DComboboxPoison.Left := 140;
  DComboboxPoison.Top := 36 + 24 * 3;
  DComboboxPoison.Width := 80;

  DEditSerieMagic.Left := 252;
  DEditSerieMagic.Top := 36 + 24 * 3;
  DEditSerieMagic.SetImgIndex(g_WMainImages, 663);



  DMenuPoison.Width := 80;

  ItemList := DMemoTab5.Add;
  DMemoTab5.AddSuItem(ItemList, DCheckBoxSWideHit);
  DMemoTab5.AddSuItem(ItemList, DComboboxPoison);
  DMemoTab5.AddSuItem(ItemList, DEditSerieMagic);
//======================================================
  DCheckBoxCrsHit.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxCrsHit.Left := 22;
  DCheckBoxCrsHit.Top := 36 + 24 * 4;


  DCheckBoxWjzq.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxWjzq.Left := 140;
  DCheckBoxWjzq.Top := 36 + 24 * 4;




  ItemList := DMemoTab5.Add;
  DMemoTab5.AddSuItem(ItemList, DCheckBoxCrsHit);
  DMemoTab5.AddSuItem(ItemList, DCheckBoxWjzq);
//==============================================================================

  DCheckBoxKtHit.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxKtHit.Left := 22;
  DCheckBoxKtHit.Top := 36 + 24 * 5;

  DLabel2.Left := 130;
  DLabel2.Top := 36 + 24 * 5;

  ItemList := DMemoTab5.Add;
  DMemoTab5.AddSuItem(ItemList, DCheckBoxKtHit);
  DMemoTab5.AddSuItem(ItemList, DLabel2);
//==============================================================================
  DCheckBoxPok.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxPok.Left := 22;
  DCheckBoxPok.Top := 36 + 24 * 6;


  DCheckBoxShield.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxShield.Left := 140;
  DCheckBoxShield.Top := 36 + 24 * 6;
  ItemList := DMemoTab5.Add;
  DMemoTab5.AddSuItem(ItemList, DCheckBoxPok);
  DMemoTab5.AddSuItem(ItemList, DCheckBoxShield);



  DCheckBoxSmartPosLongHit.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxSmartPosLongHit.Left := 22;
  DCheckBoxSmartPosLongHit.Top := 36 + 24 * 7;

  DCheckBoxStruckShield.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxStruckShield.Left := 140;
  DCheckBoxStruckShield.Top := 36 + 24 * 7;

  ItemList := DMemoTab5.Add;
  DMemoTab5.AddSuItem(ItemList, DCheckBoxSmartPosLongHit);
  DMemoTab5.AddSuItem(ItemList, DCheckBoxStruckShield);


  DCheckBoxSmartWalkLongHit.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxSmartWalkLongHit.Left := 22;
  DCheckBoxSmartWalkLongHit.Top := 36 + 24 * 8;
  ItemList := DMemoTab5.Add;
  DMemoTab5.AddSuItem(ItemList, DCheckBoxSmartWalkLongHit);



  DLabel12.Left := 10;
  DLabel12.Top := 36 + 24 * 9;
  ItemList := DMemoTab5.Add;
  DMemoTab5.AddSuItem(ItemList, DLabel12);
  DMemoTab5.AddSuItem(ItemList, DSerieMagic1);
  DMemoTab5.AddSuItem(ItemList, DSerieMagic2);
  DMemoTab5.AddSuItem(ItemList, DSerieMagic3);
  DMemoTab5.AddSuItem(ItemList, DSerieMagic4);
  DMemoTab5.AddSuItem(ItemList, DSerieMagic5);
  DMemoTab5.AddSuItem(ItemList, DSerieMagic6);
  DMemoTab5.AddSuItem(ItemList, DSerieMagic7);
  DMemoTab5.AddSuItem(ItemList, DSerieMagic8);

  DSerieMagic1.Left := 22;
  DSerieMagic1.Top := 36 + 24 * 10;
  DSerieMagic1.Width := 36;
  DSerieMagic1.Height := 34;

  DSerieMagic2.Left := 22 + 42;
  DSerieMagic2.Top := 36 + 24 * 10;
  DSerieMagic2.Width := 36;
  DSerieMagic2.Height := 34;

  DSerieMagic3.Left := 22 + 42 * 2;
  DSerieMagic3.Top := 36 + 24 * 10;
  DSerieMagic3.Width := 36;
  DSerieMagic3.Height := 34;

  DSerieMagic4.Left := 22 + 42 * 3;
  DSerieMagic4.Top := 36 + 24 * 10;
  DSerieMagic4.Width := 36;
  DSerieMagic4.Height := 34;

  DSerieMagic5.Left := 22 + 42 * 4;
  DSerieMagic5.Top := 36 + 24 * 10;
  DSerieMagic5.Width := 36;
  DSerieMagic5.Height := 34;

  DSerieMagic6.Left := 22 + 42 * 5;
  DSerieMagic6.Top := 36 + 24 * 10;
  DSerieMagic6.Width := 36;
  DSerieMagic6.Height := 34;

  DSerieMagic7.Left := 22 + 42 * 6;
  DSerieMagic7.Top := 36 + 24 * 10;
  DSerieMagic7.Width := 36;
  DSerieMagic7.Height := 34;

  DSerieMagic8.Left := 22 + 42 * 7;
  DSerieMagic8.Top := 36 + 24 * 10;
  DSerieMagic8.Width := 36;
  DSerieMagic8.Height := 34;
{-----------------------DMemoTab6---------------------------}
  DCheckBoxUseKey.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxUseKey.Left := 10;
  DCheckBoxUseKey.Top := 6;

  ItemList := DMemoTab6.Add;
  DMemoTab6.AddSuItem(ItemList, DCheckBoxUseKey);


  DLabelKeyMemo.Left := 12;
  DLabelKeyMemo.Top := 26;
  DLabelKeyOriginal.Left := 136;
  DLabelKeyOriginal.Top := 26;
  DLabelKeyChange.Left := 266;
  DLabelKeyChange.Top := 26;

  ItemList := DMemoTab6.Add;
  DMemoTab6.AddSuItem(ItemList, DLabelKeyMemo);
  DMemoTab6.AddSuItem(ItemList, DLabelKeyOriginal);
  DMemoTab6.AddSuItem(ItemList, DLabelKeyChange);


  DLabelKey0.Left := 12;
  DLabelKey0.Top := 48;
  DLabelKey1.Left := 12;
  DLabelKey1.Top := 48 + 22;
  DLabelKey2.Left := 12;
  DLabelKey2.Top := 48 + 22 * 2;
  DLabelKey3.Left := 12;
  DLabelKey3.Top := 48 + 22 * 3;
  DLabelKey4.Left := 12;
  DLabelKey4.Top := 48 + 22 * 4;
  DLabelKey5.Left := 12;
  DLabelKey5.Top := 48 + 22 * 5;
  DLabelKey6.Left := 12;
  DLabelKey6.Top := 48 + 22 * 6;
  DLabelKey7.Left := 12;
  DLabelKey7.Top := 48 + 22 * 7;



  DLabelSerieSkill1.Left := 102;
  DLabelSerieSkill1.Top := 48;
  DLabelSerieSkill1.Width := 128;

  DLabelHeroCallHero1.Left := 102;
  DLabelHeroCallHero1.Top := 48 + 22;
  DLabelHeroCallHero1.Width := 128;


  DLabelHeroSetTarget1.Left := 102;
  DLabelHeroSetTarget1.Top := 48 + 22 * 2;
  DLabelHeroSetTarget1.Width := 128;

  DLabelHeroUnionHit1.Left := 102;
  DLabelHeroUnionHit1.Top := 48 + 22 * 3;
  DLabelHeroUnionHit1.Width := 128;

  DLabelHeroSetAttackState1.Left := 102;
  DLabelHeroSetAttackState1.Top := 48 + 22 * 4;
  DLabelHeroSetAttackState1.Width := 128;

  DLabelHeroSetGuard1.Left := 102;
  DLabelHeroSetGuard1.Top := 48 + 22 * 5;
  DLabelHeroSetGuard1.Width := 128;


  DLabelSwitchAttackMode1.Left := 102;
  DLabelSwitchAttackMode1.Top := 48 + 22 * 6;
  DLabelSwitchAttackMode1.Width := 128;

  DLabelSwitchMiniMap1.Left := 102;
  DLabelSwitchMiniMap1.Top := 48 + 22 * 7;
  DLabelSwitchMiniMap1.Width := 128;



  DLabelSerieSkill.Left := 240 - 2;
  DLabelSerieSkill.Top := 48;
  DLabelSerieSkill.Width := 128;

  DLabelHeroCallHero.Left := 240 - 2;
  DLabelHeroCallHero.Top := 48 + 22;
  DLabelHeroCallHero.Width := 128;

  DLabelHeroSetTarget.Left := 240 - 2;
  DLabelHeroSetTarget.Top := 48 + 22 * 2;
  DLabelHeroSetTarget.Width := 128;

  DLabelHeroUnionHit.Left := 240 - 2;
  DLabelHeroUnionHit.Top := 48 + 22 * 3;
  DLabelHeroUnionHit.Width := 128;

  DLabelHeroSetAttackState.Left := 240 - 2;
  DLabelHeroSetAttackState.Top := 48 + 22 * 4;
  DLabelHeroSetAttackState.Width := 128;

  DLabelHeroSetGuard.Left := 240 - 2;
  DLabelHeroSetGuard.Top := 48 + 22 * 5;
  DLabelHeroSetGuard.Width := 128;


  DLabelSwitchAttackMode.Left := 240 - 2;
  DLabelSwitchAttackMode.Top := 48 + 22 * 6;
  DLabelSwitchAttackMode.Width := 128;

  DLabelSwitchMiniMap.Left := 240 - 2;
  DLabelSwitchMiniMap.Top := 48 + 22 * 7;
  DLabelSwitchMiniMap.Width := 128;


  ItemList := DMemoTab6.Add;
  DMemoTab6.AddSuItem(ItemList, DLabelKey0);
  DMemoTab6.AddSuItem(ItemList, DLabelSerieSkill1);
  DMemoTab6.AddSuItem(ItemList, DLabelSerieSkill);

  ItemList := DMemoTab6.Add;
  DMemoTab6.AddSuItem(ItemList, DLabelKey1);
  DMemoTab6.AddSuItem(ItemList, DLabelHeroCallHero1);
  DMemoTab6.AddSuItem(ItemList, DLabelHeroCallHero);

  ItemList := DMemoTab6.Add;
  DMemoTab6.AddSuItem(ItemList, DLabelKey2);
  DMemoTab6.AddSuItem(ItemList, DLabelHeroSetTarget1);
  DMemoTab6.AddSuItem(ItemList, DLabelHeroSetTarget);

  ItemList := DMemoTab6.Add;
  DMemoTab6.AddSuItem(ItemList, DLabelKey3);
  DMemoTab6.AddSuItem(ItemList, DLabelHeroUnionHit1);
  DMemoTab6.AddSuItem(ItemList, DLabelHeroUnionHit);

  ItemList := DMemoTab6.Add;
  DMemoTab6.AddSuItem(ItemList, DLabelKey4);
  DMemoTab6.AddSuItem(ItemList, DLabelHeroSetAttackState1);
  DMemoTab6.AddSuItem(ItemList, DLabelHeroSetAttackState);

  ItemList := DMemoTab6.Add;
  DMemoTab6.AddSuItem(ItemList, DLabelKey5);
  DMemoTab6.AddSuItem(ItemList, DLabelHeroSetGuard1);
  DMemoTab6.AddSuItem(ItemList, DLabelHeroSetGuard);


  ItemList := DMemoTab6.Add;
  DMemoTab6.AddSuItem(ItemList, DLabelKey6);
  DMemoTab6.AddSuItem(ItemList, DLabelSwitchAttackMode1);
  DMemoTab6.AddSuItem(ItemList, DLabelSwitchAttackMode);

  ItemList := DMemoTab6.Add;
  DMemoTab6.AddSuItem(ItemList, DLabelKey7);
  DMemoTab6.AddSuItem(ItemList, DLabelSwitchMiniMap1);
  DMemoTab6.AddSuItem(ItemList, DLabelSwitchMiniMap);



{-----------------------DMemoTab7---------------------------}
  DCheckBoxGuaji.SetImgIndex(g_WMain2Images, 228);
  DCheckBoxGuaji.Left := 10;
  DCheckBoxGuaji.Top := 6;

  DLabelGuaJiStart.Left := 120;
  DLabelGuaJiStart.Top := 7;
  //DLabelGuaJiStart.Canvas.Font.Style := [fsBold];

  ItemList := DMemoTab7.Add;
  DMemoTab7.AddSuItem(ItemList, DCheckBoxGuaji);
  DMemoTab7.AddSuItem(ItemList, DLabelGuaJiStart);


  ItemList := DMemoTab7.Add;
  DMemoTab7.AddSuItem(ItemList, DLabelGuajiQunti);
  DMemoTab7.AddSuItem(ItemList, DComboboxGuajiQunti);

  ItemList := DMemoTab7.Add;
  DMemoTab7.AddSuItem(ItemList, DLabelGuajiGeti);
  DMemoTab7.AddSuItem(ItemList, DComboboxGuajiGeti);


  DLabelGuajiQunti.Left := 12;
  DLabelGuajiQunti.Top := 38;

  DLabelGuajiGeti.Left := 12;
  DLabelGuajiGeti.Top := 38 + 28;

  DComboboxGuajiQunti.Left := 80;
  DComboboxGuajiQunti.Top := 36;
  DComboboxGuajiQunti.Width := 100;

  DComboboxGuajiGeti.Left := 80;
  DComboboxGuajiGeti.Top := 36 + 26;
  DComboboxGuajiGeti.Width := 100;

{-----------------------DMemoTab8---------------------------}


  if FileExists(EXPLAIN2FILE) then begin
    DMemoTab8.LoadFromFile(EXPLAIN2FILE);
    nIndex := 0;
    for I := 0 to DMemoTab8.Count - 1 do begin
      ItemList := TLines(DMemoTab8.Items[I]);
      sText := ItemList.Strings[0];
      if (Length(sText) <> Length(Trim(sText))) then begin
        for II := 0 to ItemList.Count - 1 do begin
          DLabel := TDLabel(ItemList.Objects[II]);
          DLabel.Canvas.Font.Style := [];
          DLabel.Canvas.Font.Color := clSilver;
          DLabel.Font.Assign(DLabel.Canvas.Font);
          DLabel.UpColor := clSilver;
          DLabel.HotColor := clSilver;
          DLabel.DownColor := clSilver;
          DLabel.Left := DLabel.Left + 6;
          //DLabel.Top := DLabel.Top + nIndex;
        end;
        //Showmessage('(sText = ''):'+sText);
      end else begin
        for II := 0 to ItemList.Count - 1 do begin
          DLabel := TDLabel(ItemList.Objects[II]);
          DLabel.Canvas.Font.Style := [fsBold];
          DLabel.Canvas.Font.Color := clWhite;
          DLabel.Font.Assign(DLabel.Canvas.Font);
          DLabel.UpColor := clWhite;
          DLabel.HotColor := clWhite;
          DLabel.DownColor := clWhite;
          //DLabel.Top := DLabel.Top + nIndex;
        end;
      end;
      //TLines(ItemList).GetHeight;
      //nIndex := nIndex + 4;
    end;
    //nIndex := DMemoTab8.MaxHeight;
  end;

  DMemoTab1.MaxHeight := DMemoTab1.MaxHeight + 24 * 5;
  //DMemoTab2.MaxHeight:=DMemoTab2.MaxHeight+24*4;
  DMemoTab3.MaxHeight := DMemoTab3.MaxHeight + 24 * 4;
  DMemoTab4.MaxHeight := DMemoTab4.MaxHeight + 24 * 4;
  DMemoTab5.MaxHeight := DMemoTab5.MaxHeight + 24 * 4;
  DMemoTab6.MaxHeight := DMemoTab6.MaxHeight + 24 * 4;
  DMemoTab7.MaxHeight := DMemoTab7.MaxHeight + 24 * 4;
  DMemoTab8.MaxHeight := DMemoTab8.MaxHeight + 24 * 4;
  DConfigDlg.ActivePage := 0;
{-----------------------------------------------------------}


  if Assigned(g_PlugInfo.HookGuiInitializeEnd) then begin
    g_PlugInfo.HookGuiInitializeEnd();
  end;
  Initialized := True;
end;

function FastCharPos(const aSource: string; const C: Char; StartPos: Integer): Integer;
var
  L: Integer;
begin
  //If this assert failed, it is because you passed 0 for StartPos, lowest value is 1 !!
  Assert(StartPos > 0);

  Result := 0;
  L := Length(aSource);
  if L = 0 then exit;
  if StartPos > L then exit;
  Dec(StartPos);
  asm
      PUSH EDI                 //Preserve this register

      mov  EDI, aSource        //Point EDI at aSource
      add  EDI, StartPos
      mov  ECX, L              //Make a note of how many chars to search through
      sub  ECX, StartPos
      mov  AL,  C              //and which char we want
    @Loop:
      cmp  Al, [EDI]           //compare it against the SourceString
      jz   @Found
      inc  EDI
      dec  ECX
      jnz  @Loop
      jmp  @NotFound
    @Found:
      sub  EDI, aSource        //EDI has been incremented, so EDI-OrigAdress = Char pos !
      inc  EDI
      mov  Result,   EDI
    @NotFound:

      POP  EDI
  end;
end;

function TFrmDlg.AddMemoChat(Str: string; FColor, BColor: Integer): string;
  {function PosX(nStart:Integer;Search:string;):Integer;
  begin

  end;}
var
  I, len, aline, n, nWidth: Integer;
  dline, temp: string;
  sData, sItemData, sUrl: string;

  //sTemp: string;
  sIdx: string;
  sName: string;
  sItemName: string;
  sLooks: string;
  sItemMakeIdex: string;
  nItemMakeIdex: Integer;
  nIdx: Integer;
  nLooks: Integer;
  DLabel: TDLabel;
  ItemLabel: TItemLabel;
  d: TTexture;
  nTop: Integer;
  ItemList: TStringList;
  nNextHeight: Integer;
//const
  //BOXWIDTH = (SCREENWIDTH div 2 - 214) * 2 {374}; //41 聊天框文字宽度
label AddText;
begin
  Result := '';

  AddText:
  nNextHeight := 0;
  nWidth := 0;
  len := Length(Str);
  temp := '';
  I := 1;
  nTop := DMemoChat.MaxHeight - DScrollChat.Position;
  ItemList := DMemoChat.Add;

  while True do begin
    if I > len then Break;
    if (Str[I] = '<') then begin
      //n := Pos('>', Str);
      n := FastCharPos(Str, '>', I);
      if (n > 0) then begin

        sItemData := Copy(Str, I + 1, n - I - 1);
        //DebugOutStr('Str:' + Str);
        //DebugOutStr('sItemData:' + sItemData + ' Length(Str) - n:' + IntToStr(Length(Str) - n));
        sItemData := GetValidStr3(sItemData, sIdx, ['|']);
        nIdx := StrToIntDef(sIdx, -1);
        nItemMakeIdex := 0;

        case nIdx of
          0: begin
              sItemData := GetValidStr3(sItemData, sName, ['|']);
              sItemData := GetValidStr3(sItemData, sItemName, ['|']);
              sItemData := GetValidStr3(sItemData, sItemMakeIdex, ['|']);
              sItemData := GetValidStr3(sItemData, sLooks, ['|']);
              nItemMakeIdex := StrToIntDef(sItemMakeIdex, 0);
              nLooks := StrToIntDef(sLooks, -1);
            end;
          1: begin
              sItemData := GetValidStr3(sItemData, sName, ['|']);
              sItemData := GetValidStr3(sItemData, sItemName, ['|']);
            end;
          2: begin
              sItemData := GetValidStr3(sItemData, sName, ['|']);
              sItemData := GetValidStr3(sItemData, sItemName, ['|']);
            end;
        end;

        if (nIdx in [0..2]) and (sName <> '') and (sItemName <> '') and (((nIdx = 0) and (nItemMakeIdex <> 0) and (nLooks <> -1)) or ((nIdx > 0) and (nItemMakeIdex = 0))) then begin

          if temp <> '' then begin

            DLabel := TDLabel.Create(DMemoChat);
            DLabel.Font.Assign(MainForm.Canvas.Font);
            DLabel.Font.Style := [];
            DLabel.Font.Color := FColor;

            DLabel.BoldFont := False;
            DLabel.DParent := DMemoChat;
            DLabel.UpColor := FColor;
            DLabel.HotColor := FColor;
            DLabel.DownColor := FColor;
            DLabel.DrawBackground := True;
            DLabel.BackgroundColor := BColor;
            //DLabel.OnClick := DItemLabelClick;
            DLabel.OnMouseMove := DItemLabelMouseMove;

            if BColor = clblack then
              DLabel.BackgroundColor := $00050505;
            DLabel.Caption := temp;
            DLabel.Left := TLines(ItemList).Width;
            DLabel.Top := nTop;
            if nNextHeight < DLabel.Height then
              nNextHeight := DLabel.Height;
            DMemoChat.AddSuItem(ItemList, DLabel);
            Result := Result + temp;

           //temp := '';
          end;

          if nIdx = 0 then begin
            d := g_WBagItemImages.Images[nLooks];
            if d <> nil then begin
              aline := nWidth + d.Width + ImageCanvas.TextWidth(temp);
            end else begin
              aline := nWidth + ImageCanvas.TextWidth(sItemName) + ImageCanvas.TextWidth(temp);
            end;
            if aline > DMemoChat.Width - 6 then begin
              Str := Copy(Str, I, Length(Str));
              //Str := Copy(Str, I, len - I + 1);
              temp := '';
              Break;
            end else begin
              Str := Copy(Str, n + 1, Length(Str));
              len := Length(Str);
              //DebugOutStr('Str:' + Str);
              //Str := Copy(Str, n + 1, len - n + 1);
              I := 0;

              if d <> nil then begin
                ItemLabel := TItemLabel.Create(DMemoChat);
                ItemLabel.DParent := DMemoChat;
                ItemLabel.SetImgIndex(g_WBagItemImages, nLooks);
                ItemLabel.Idx := nIdx;
                ItemLabel.OnClick := DItemLabelClick;
                ItemLabel.OnMouseMove := DItemLabelMouseMove;
                ItemLabel.Caption := sItemName;
                ItemLabel.TData := sName + '|' + sItemName + '|' + sItemMakeIdex;

                ItemLabel.Left := TLines(ItemList).Width;
                ItemLabel.Top := nTop;
                if nNextHeight < ItemLabel.Height then
                  nNextHeight := ItemLabel.Height;
                DMemoChat.AddSuItem(ItemList, ItemLabel);

                Inc(nWidth, ItemLabel.Width);
              end else begin
                DLabel := TDLabel.Create(DMemoChat);
                DLabel.Idx := nIdx;
                DLabel.Font.Assign(MainForm.Canvas.Font);
                DLabel.Font.Style := [fsUnderline];
                DLabel.Font.Color := FColor;

                DLabel.BoldFont := False;
                DLabel.DParent := DMemoChat;
                DLabel.UpColor := FColor;
                DLabel.HotColor := FColor;
                DLabel.DownColor := FColor;
                DLabel.DrawBackground := True;
                DLabel.BackgroundColor := BColor;
                DLabel.OnClick := DItemLabelClick;
                DLabel.OnMouseMove := DItemLabelMouseMove;
                if BColor = clblack then
                  DLabel.BackgroundColor := $00050505;
                DLabel.Style := bsBase;
                DLabel.Caption := sItemName;
                DLabel.TData := sName + '|' + sItemName + '|' + sItemMakeIdex;
                DLabel.Left := TLines(ItemList).Width;
                DLabel.Top := nTop;
                if nNextHeight < DLabel.Height then
                  nNextHeight := DLabel.Height;
                DMemoChat.AddSuItem(ItemList, DLabel);
                Inc(nWidth, DLabel.Width);
              end;
              temp := '';
              Result := Result + sItemName;
            end;
          end else begin //if nIdx = 0 then begin
            aline := nWidth + ImageCanvas.TextWidth(sName) + ImageCanvas.TextWidth(temp);
            if aline > DMemoChat.Width - 6 then begin
              Str := Copy(Str, I, Length(Str));
              temp := '';
              Break;
            end else begin
              Str := Copy(Str, n + 1, Length(Str));
              len := Length(Str);
              I := 0;

              DLabel := TDLabel.Create(DMemoChat);
              DLabel.Idx := nIdx;
              DLabel.Font.Assign(MainForm.Canvas.Font);
              DLabel.Font.Style := [fsUnderline];
              DLabel.Font.Color := FColor;

              DLabel.BoldFont := False;
              DLabel.DParent := DMemoChat;
              DLabel.UpColor := FColor;
              DLabel.HotColor := FColor;
              DLabel.DownColor := FColor;
              DLabel.DrawBackground := True;
              DLabel.BackgroundColor := BColor;
              DLabel.OnClick := DItemLabelClick;
              DLabel.OnMouseMove := DItemLabelMouseMove;
              if BColor = clblack then
                DLabel.BackgroundColor := $00050505;
              DLabel.Style := bsBase;
              DLabel.Caption := sName;
              DLabel.TData := sItemName;
              DLabel.Left := TLines(ItemList).Width;
              DLabel.Top := nTop;
              if nNextHeight < DLabel.Height then
                nNextHeight := DLabel.Height;

              DMemoChat.AddSuItem(ItemList, DLabel);
              Result := Result + sName;
              Inc(nWidth, DLabel.Width);
              temp := '';
            end;
          end;
        end else begin //if (nIdx in [0..2]) and (sName <> '')
          temp := temp + Str[I];
          //nWidth:=ImageCanvas.TextWidth(temp);
          aline := nWidth + ImageCanvas.TextWidth(temp);
          if aline > DMemoChat.Width - 6 then begin

            DLabel := TDLabel.Create(DMemoChat);
            DLabel.Font.Assign(MainForm.Canvas.Font);
            DLabel.Font.Color := FColor;
            DLabel.BoldFont := False;
            DLabel.DParent := DMemoChat;
            DLabel.UpColor := FColor;
            DLabel.HotColor := FColor;
            DLabel.DownColor := FColor;
            DLabel.DrawBackground := True;
            DLabel.BackgroundColor := BColor;
            DLabel.OnMouseMove := DItemLabelMouseMove;
            if BColor = clblack then
              DLabel.BackgroundColor := $00050505;
            DLabel.Caption := temp;

            DLabel.Left := TLines(ItemList).Width;
            DLabel.Top := nTop;
            if nNextHeight < DLabel.Height then
              nNextHeight := DLabel.Height;
            DMemoChat.AddSuItem(ItemList, DLabel);
            Result := Result + temp;

            Str := Copy(Str, I + 1, len - I);
            temp := '';
            Break;
          end;
        end;
      end else begin //if n > 0 then begin
        temp := temp + Str[I];
        aline := nWidth + ImageCanvas.TextWidth(temp);
        if aline > DMemoChat.Width - 6 then begin

          DLabel := TDLabel.Create(DMemoChat);
          DLabel.Font.Assign(MainForm.Canvas.Font);
          DLabel.Font.Color := FColor;
          DLabel.BoldFont := False;
          DLabel.DParent := DMemoChat;
          DLabel.UpColor := FColor;
          DLabel.HotColor := FColor;
          DLabel.DownColor := FColor;
          DLabel.DrawBackground := True;
          DLabel.BackgroundColor := BColor;
          DLabel.OnMouseMove := DItemLabelMouseMove;
          if BColor = clblack then
            DLabel.BackgroundColor := $00050505;
          DLabel.Caption := temp;

          DLabel.Left := TLines(ItemList).Width;
          DLabel.Top := nTop;
          if nNextHeight < DLabel.Height then
            nNextHeight := DLabel.Height;
          DMemoChat.AddSuItem(ItemList, DLabel);
          Result := Result + temp;

          Str := Copy(Str, I + 1, len - I);
          temp := '';
          Break;
        end;
      end;
    end else begin //if (Str[I] = '<') then begin
      if Byte(Str[I]) >= 128 then begin
        temp := temp + Str[I];
        Inc(I);
        if I <= len then begin
          temp := temp + Str[I];
        end else Break;
      end else begin
        temp := temp + Str[I];
      end;
      aline := nWidth + ImageCanvas.TextWidth(temp);
      if aline > DMemoChat.Width - 6 then begin

        DLabel := TDLabel.Create(DMemoChat);
        DLabel.Font.Assign(MainForm.Canvas.Font);
        DLabel.Font.Color := FColor;
        DLabel.BoldFont := False;
        DLabel.DParent := DMemoChat;
        DLabel.UpColor := FColor;
        DLabel.HotColor := FColor;
        DLabel.DownColor := FColor;
        DLabel.DrawBackground := True;
        DLabel.BackgroundColor := BColor;
        DLabel.OnMouseMove := DItemLabelMouseMove;
        if BColor = clblack then
          DLabel.BackgroundColor := $00050505;
        DLabel.Caption := temp;

        DLabel.Left := TLines(ItemList).Width;
        DLabel.Top := nTop;
        if nNextHeight < DLabel.Height then
          nNextHeight := DLabel.Height;

        //DebugOutStr('nTop0:' + IntToStr(nTop) + ' ' + temp);
        DMemoChat.AddSuItem(ItemList, DLabel);
        Result := Result + temp;
        Str := Copy(Str, I + 1, len - I);
        temp := '';
        Break;
      end;
    end;
    Inc(I);
  end;

  if temp <> '' then begin
    DLabel := TDLabel.Create(DMemoChat);
    DLabel.Font.Assign(MainForm.Canvas.Font);
    DLabel.Font.Color := FColor;
    DLabel.BoldFont := False;
    DLabel.DParent := DMemoChat;
    DLabel.UpColor := FColor;
    DLabel.HotColor := FColor;
    DLabel.DownColor := FColor;
    DLabel.DrawBackground := True;
    DLabel.BackgroundColor := BColor;
    DLabel.OnMouseMove := DItemLabelMouseMove;
    if BColor = clblack then
      DLabel.BackgroundColor := $00050505;
    DLabel.Caption := temp;

    DLabel.Left := TLines(ItemList).Width;
    DLabel.Top := nTop;
    //DebugOutStr('nTop1:' + IntToStr(nTop) + ' ' + temp);
    {DebugOutStr('DLabel SurfaceY:' + IntToStr(DLabel.SurfaceY(DLabel.Top)));
    DebugOutStr('DMemoChat:' + IntToStr(DMemoChat.SurfaceY(DMemoChat.Top) + DMemoChat.Height));}
    if nNextHeight < DLabel.Height then
      nNextHeight := DLabel.Height;

    DMemoChat.AddSuItem(ItemList, DLabel);
    Result := Result + temp;
    Str := '';
  end;

  if DMemoChat.Count >= 9 then begin
    while nNextHeight > 0 do begin
      DScrollChat.Next;
      Dec(nNextHeight, DScrollChat.Increment);
    end;
    nNextHeight := 0;
  end;
 // DScrollChat.Position := DScrollChat.Position + nNextHeight;
  //DScrollChat.Next;
  while DMemoChat.Count > 200 do begin
   // DMemoChat.Clear;
    ItemList := DMemoChat.Items[0];
    DMemoChat.Delete(0);
    //DMemoChat.RefreshPos;

    for I := 0 to ItemList.Count - 1 do begin
      TDControl(ItemList.Objects[I]).Free;
    end;
    ItemList.Free;
    //DScrollChat.Next;
    //DScrollChat.Previous;
    //DebugOutStr('DMemoChat.Count > 200');
  end;


  if Str <> '' then begin
    Str := ' ' + Str;
    goto AddText;
  end;
  //DMemoChat.SpareSize:=DMemoChat.Height - 12;
  //DScrollChat.Max:=DMemoChat.MaxHeight+DMemoChat.SpareSize;

end;

//打开/关闭我的属性对话框

procedure TFrmDlg.OpenMyStatus;
begin
  DStateWin.Visible := not DStateWin.Visible;
  PageChanged;
end;
//显示玩加信息对话框

procedure TFrmDlg.OpenUserState(UserState: TUserStateInfo);
begin
  UserState1 := UserState;
  DUserState1.Visible := True;
end;

//显示/关闭物品对话框

procedure TFrmDlg.OpenItemBag;
begin
  DItemBag.Visible := not DItemBag.Visible;
  //if DItemBag.Visible then
    //ArrangeItemBag;
end;

procedure TFrmDlg.SetChatVisible(Value: Boolean);
begin
  DChatDlg.Visible := Value;
end;

procedure TFrmDlg.SetInputVisible(Value: Boolean);
begin
  DEdChat.Visible := Value;
  if not Value then
    EdChat.Visible := Value;
end;


//底部状态框

procedure TFrmDlg.ViewBottomBox(Value: Boolean);
begin
  DBottom.Visible := Value;
  DChatDlg.Visible := Value;
  if g_ConfigClient.btMainInterface = 1 then begin
    SetButVisible(Value);
    DMapTitle.Visible := Value;
    SetInputVisible(Value);
    SetChatVisible(Value);

  end else begin

  end;
  if (DBottom.Visible) and (not g_boFullScreen) then begin
    frmMain.Caption := g_sServerName + ' - ' + g_sSelChrName;
    DBackground.SetFocus;
  end;
end;

// 取消物品移动

procedure TFrmDlg.CancelItemMoving;
var
  Idx, n: Integer;
begin
  //if (g_MovingItem.Owner = DHeroItemBag) or (g_MovingItem.Owner = DHeroStateWin) then Exit;
  if g_boItemMoving then begin
    g_boItemMoving := False;
    Idx := g_MovingItem.Index;
    if Idx < 0 then begin
      if (Idx <= -20) and (Idx > -30) then begin
        AddDealItem(g_MovingItem.Item);
      end else begin
        n := -(Idx + 1);
        if n in [0..12] then begin
          g_UseItems[n] := g_MovingItem.Item;
        end;
      end;
    end else
      if Idx in [0..MAXBAGITEM - 1] then begin
      if g_ItemArr[Idx].s.Name = '' then begin
        g_ItemArr[Idx] := g_MovingItem.Item;
      end else begin
        AddItemBag(g_MovingItem.Item);
      end;
    end;
    g_MovingItem.Item.s.Name := '';
  end;
  ArrangeItemBag;
end;

//把移动的物品放下

procedure TFrmDlg.DropMovingItem;
var
  Idx: Integer;
begin
  //if g_btItemMoving in [3, 4] then Exit;
  if g_boItemMoving then begin
    g_boItemMoving := False;
    if g_MovingItem.Item.s.Name <> '' then begin
      if (g_MovingItem.Owner = DHeroItemBag) then begin
        frmMain.SendHeroDropItem(g_MovingItem.Item.s.Name, g_MovingItem.Item.MakeIndex);
        AddDropItem(g_MovingItem.Item);
        g_MovingItem.Item.s.Name := '';
      end else
        if (g_MovingItem.Owner = DItemBag) then begin
        frmMain.SendDropItem(g_MovingItem.Item.s.Name, g_MovingItem.Item.MakeIndex);
        AddDropItem(g_MovingItem.Item);
        g_MovingItem.Item.s.Name := '';
      end;
    end;
  end;
end;
//打开属性调整对话框

procedure TFrmDlg.OpenAdjustAbility;
begin
  DAdjustAbility.Left := 0;
  DAdjustAbility.Top := 0;
  g_nSaveBonusPoint := g_nBonusPoint;
  FillChar(g_BonusAbilChg, SizeOf(TNakedAbility), #0);
  DAdjustAbility.Visible := True;
end;

procedure TFrmDlg.DBackgroundBackgroundClick(Sender: TObject);
var
  dropgold: Integer;
  valstr: string;
begin
  if g_boItemMoving then begin
    DBackground.WantReturn := True;
    if g_MovingItem.Item.s.Name = g_sGoldName {'金币'} then begin
      g_boItemMoving := False;
      g_MovingItem.Item.s.Name := '';
      DialogSize := 1;
      DMessageDlg('Please enter amount of ' + g_sGoldName, [mbOk, mbAbort]);
      GetValidStrVal(DlgEditText, valstr, [' ']);
      dropgold := Str_ToInt(valstr, 0);
      frmMain.SendDropGold(dropgold);
    end;
    if g_MovingItem.Index >= 0 then DropMovingItem;
  end;
end;

procedure TFrmDlg.DBackgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if g_boItemMoving then begin
    DBackground.WantReturn := True;
  end;
end;

procedure TFrmDlg.DBottomMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;
{------------------------------------------------------------------------}
////显示通用对话框

function TFrmDlg.DMessageDlg(msgstr: string; DlgButtons: TMsgDlgButtons): TModalResult;
const
  XBase = 324;
var
  I: Integer;
  lx, ly: Integer;
  d: TTexture;
  procedure ShowDice();
  var
    I: Integer;
    bo05: Boolean;
  begin
    if m_nDiceCount = 1 then begin
      if m_Dice[0].n67C < 20 then begin
        if GetTickCount - m_Dice[0].dwPlayTick > 100 then begin
          if m_Dice[0].n67C div 5 = 4 then begin
            m_Dice[0].nPlayPoint := Random(6) + 1;
          end else begin
            m_Dice[0].nPlayPoint := m_Dice[0].n67C div 5 + 8;
          end;
          m_Dice[0].dwPlayTick := GetTickCount();
          Inc(m_Dice[0].n67C);
        end;
        Exit;
      end;
      m_Dice[0].nPlayPoint := m_Dice[0].nDicePoint;
      if GetTickCount - m_Dice[0].dwPlayTick > 1500 then begin
        DMsgDlg.Visible := False;
      end;
      Exit;
    end;

    bo05 := True;
    for I := 0 to m_nDiceCount - 1 do begin
      if m_Dice[I].n67C < m_Dice[I].n680 then begin
        if GetTickCount - m_Dice[I].dwPlayTick > 100 then begin
          if m_Dice[I].n67C div 5 = 4 then begin
            m_Dice[I].nPlayPoint := Random(6) + 1;
          end else begin
            m_Dice[I].nPlayPoint := m_Dice[I].n67C div 5 + 8;
          end;
          m_Dice[I].dwPlayTick := GetTickCount();
          Inc(m_Dice[I].n67C);
        end;
        bo05 := False;
      end else begin
        m_Dice[I].nPlayPoint := m_Dice[I].nDicePoint;
        if GetTickCount - m_Dice[I].dwPlayTick < 2000 then begin
          bo05 := False;
        end;
      end;
    end; //for
    if bo05 then begin
      DMsgDlg.Visible := False;
    end;
  end;
begin
  lx := XBase;
  ly := 126;
  case DialogSize of
    0: {//小对话框} begin
        d := g_WMainImages.Images[381];
        if d <> nil then begin
          DMsgDlg.SetImgIndex(g_WMainImages, 381);
          DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
          DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
          msglx := 39;
          msgly := 38;
          lx := 90;
          ly := 36;
        end;
      end;
    1: {//大对话框（横）} begin
        d := g_WMainImages.Images[360];
        if d <> nil then begin
          DMsgDlg.SetImgIndex(g_WMainImages, 360);
          DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
          DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
          msglx := 39;
          msgly := 38;
          lx := XBase;
          ly := 126;
        end;
      end;
    2: {//大对话框（竖）} begin
        d := g_WMainImages.Images[380];
        if d <> nil then begin
          DMsgDlg.SetImgIndex(g_WMainImages, 380);
          DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
          DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
          msglx := 23;
          msgly := 20;
          lx := 90;
          ly := 305;
        end;
      end;
  end;
  MsgText := msgstr;
  ViewDlgEdit := False; //编辑框不可见
  DMsgDlg.Floating := True; //允许鼠标移动
  DMsgDlgOk.Visible := False;
  DMsgDlgYes.Visible := False;
  DMsgDlgCancel.Visible := False;
  DMsgDlgNo.Visible := False;
  DMsgDlg.Left := (SCREENWIDTH - DMsgDlg.Width) div 2;
  DMsgDlg.Top := (SCREENHEIGHT - DMsgDlg.Height) div 2;

  for I := 0 to m_nDiceCount - 1 do begin
    m_Dice[I].n67C := 0;
    m_Dice[I].n680 := Random(m_nDiceCount + 2) * 5 + 10;
    m_Dice[I].nPlayPoint := 1;
    m_Dice[I].dwPlayTick := GetTickCount();
  end;

  if mbCancel in DlgButtons then begin
    DMsgDlgCancel.Left := lx;
    DMsgDlgCancel.Top := ly;
    DMsgDlgCancel.Visible := True;
    lx := lx - 110;
  end;
  if mbNo in DlgButtons then begin
    DMsgDlgNo.Left := lx;
    DMsgDlgNo.Top := ly;
    DMsgDlgNo.Visible := True;
    lx := lx - 110;
  end;
  if mbYes in DlgButtons then begin
    DMsgDlgYes.Left := lx;
    DMsgDlgYes.Top := ly;
    DMsgDlgYes.Visible := True;
    lx := lx - 110;
  end;
  if (mbOk in DlgButtons) or (lx = XBase) then begin
    DMsgDlgOk.Left := lx;
    DMsgDlgOk.Top := ly;
    DMsgDlgOk.Visible := True;
    lx := lx - 110;
  end;
  HideAllControls;
  DMsgDlg.ShowModal;
  if mbAbort in DlgButtons then begin
    ViewDlgEdit := True;
    DMsgDlg.Floating := False;
    with EdDlgEdit do begin
      Text := '';
      Width := DMsgDlg.Width - 70;
      {Left := (SCREENWIDTH - EdDlgEdit.Width) div 2;
      Top := (SCREENHEIGHT - EdDlgEdit.Height) div 2 - 10; }
      Left := (DMsgDlg.Width - Width) div 2;
      Top := (DMsgDlg.Height - Height) div 2 - 10;
      //SetFocus;
      //SetDFocus(EdDlgEdit);
    end;
  end;
  Result := mrOk;

  while True do begin
    if not DMsgDlg.Visible then Break;
    //FrmMain.DXTimerTimer (self, 0);
    frmMain.ProcOnIdle;
    Application.ProcessMessages;
    if m_nDiceCount > 0 then begin
      m_boPlayDice := True;
      for I := 0 to m_nDiceCount - 1 do begin
        m_Dice[I].nX := ((DMsgDlg.Width div 2 + 6) - ((m_nDiceCount * 32 + m_nDiceCount) div 2)) + (I * 32 + I);
        m_Dice[I].nY := DMsgDlg.Height div 2 - 14;
      end;
      ShowDice();
    end;
    if Application.Terminated then Exit;
    Sleep(1);
  end;

  EdDlgEdit.Visible := False;
  RestoreHideControls;
  DlgEditText := EdDlgEdit.Text;
  if EdChat.Visible then EdChat.SetFocus;

  ViewDlgEdit := False;
  Result := DMsgDlg.DialogResult;
  DialogSize := 1;
  m_nDiceCount := 0;
  m_boPlayDice := False;
end;

procedure TFrmDlg.DMsgDlgOkClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DMsgDlgOk then DMsgDlg.DialogResult := mrOk;
  if Sender = DMsgDlgYes then DMsgDlg.DialogResult := mrYes;
  if Sender = DMsgDlgCancel then DMsgDlg.DialogResult := mrCancel;
  if Sender = DMsgDlgNo then DMsgDlg.DialogResult := mrNo;
  DMsgDlg.Visible := False;
end;

procedure TFrmDlg.DMsgDlgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then begin
    if DMsgDlgOk.Visible and not (DMsgDlgYes.Visible or DMsgDlgCancel.Visible or DMsgDlgNo.Visible) then begin
      DMsgDlg.DialogResult := mrOk;
      DMsgDlg.Visible := False;
    end;
    if DMsgDlgYes.Visible and not (DMsgDlgOk.Visible or DMsgDlgCancel.Visible or DMsgDlgNo.Visible) then begin
      DMsgDlg.DialogResult := mrYes;
      DMsgDlg.Visible := False;
    end;
  end;
  if Key = 27 then begin
    if DMsgDlgCancel.Visible then begin
      DMsgDlg.DialogResult := mrCancel;
      DMsgDlg.Visible := False;
    end;
  end;
end;

procedure TFrmDlg.DMsgDlgOkDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  tStr: string;
  OldColor: TColor;
  old: Integer;
  nStatus: Integer;
  OldFontStyle: TFontStyles;
begin
  try
    nStatus := -1;
    d := nil;
    with Sender as TDButton do begin
      if not Downed then begin
        if WLib <> nil then
          d := WLib.Images[FaceIndex]
      end else begin
        if WLib <> nil then
          d := WLib.Images[FaceIndex + 1];
      end;
      //if WLib = nil then Exit;
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      if (Name = 'DSServer1') and (g_ServerList.Count >= 1) then begin
        tStr := g_ServerList.Strings[0];
        nStatus := Integer(g_ServerList.Objects[0]);
      end;
      if (Name = 'DSServer2') and (g_ServerList.Count >= 2) then begin
        tStr := g_ServerList.Strings[1];
        nStatus := Integer(g_ServerList.Objects[1]);
      end;
      if (Name = 'DSServer3') and (g_ServerList.Count >= 3) then begin
        tStr := g_ServerList.Strings[2];
        nStatus := Integer(g_ServerList.Objects[2]);
      end;
      if (Name = 'DSServer4') and (g_ServerList.Count >= 4) then begin
        tStr := g_ServerList.Strings[3];
        nStatus := Integer(g_ServerList.Objects[3]);
      end;
      if (Name = 'DSServer5') and (g_ServerList.Count >= 5) then begin
        tStr := g_ServerList.Strings[4];
        nStatus := Integer(g_ServerList.Objects[4]);
      end;
      if (Name = 'DSServer6') and (g_ServerList.Count >= 6) then begin
        tStr := g_ServerList.Strings[5];
        nStatus := Integer(g_ServerList.Objects[5]);
      end;
      {   case nStatus of    //原来
           0: begin
             tStr:=tStr + '(维护)';
             Color:=clDkGray;
           end;
           1: begin
             tStr:=tStr + '(空闲)';
             Color:=clLime;
           end;
           2: begin
             tStr:=tStr + '(良好)';
             Color:=clGreen;
           end;
           3: begin
             tStr:=tStr + '(繁忙)';
             Color:=clMaroon;
           end;
           4: begin
             tStr:=tStr + '(满员)';
             Color:=clRed;
           end;}
      if d <> nil then begin
        old := MainForm.Canvas.Font.Size;
        OldColor := MainForm.Canvas.Font.Color;
        OldFontStyle := MainForm.Canvas.Font.Style;

        MainForm.Canvas.Font.Size := 12;
        MainForm.Canvas.Font.Style := [fsBold];
        MainForm.Canvas.Font.Color := GetRGB(150) { clyellow};
        if TDButton(Sender).Downed then begin
          dsurface.BoldTextOut(SurfaceX(Left + (d.Width - dsurface.TextWidth(tStr)) div 2) + 2, SurfaceY(Top + (d.Height - dsurface.TextHeight(tStr)) div 2) + 2, tStr, GetRGB(150));
        end else begin
          dsurface.BoldTextOut(SurfaceX(Left + (d.Width - dsurface.TextWidth(tStr)) div 2), SurfaceY(Top + (d.Height - dsurface.TextHeight(tStr)) div 2), tStr, GetRGB(150));
        end;
        MainForm.Canvas.Font.Style := OldFontStyle;
        MainForm.Canvas.Font.Size := old;
        MainForm.Canvas.Font.Color := OldColor;
      end;
    end;
  except
    on E: Exception do begin
      ShowMessage(E.message);
    end;
  end;
end;

procedure TFrmDlg.DMsgDlgDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  I: Integer;
  d: TTexture;
  ly: Integer;
  Str, sData: string;
  nX, nY: Integer;
begin
  d := nil;
  with Sender as TDWindow do begin
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    if m_boPlayDice then begin
      for I := 0 to m_nDiceCount - 1 do begin
        d := g_WBagItemImages.GetCachedImage(m_Dice[I].nPlayPoint + 376 - 1, nX, nY);
        if d <> nil then begin
          dsurface.Draw(SurfaceX(Left) + m_Dice[I].nX + nX - 14, SurfaceY(Top) + m_Dice[I].nY + nY + 38, d.ClientRect, d, True);
        end;
      end;
    end;

    ly := msgly;
    Str := MsgText;
    while True do begin
      if Str = '' then Break;
      Str := GetValidStr3(Str, sData, ['\']);
      if sData <> '' then
        dsurface.BoldTextOut(SurfaceX(Left + msglx), SurfaceY(Top + ly), sData, clWhite);
      ly := ly + 14;
    end;

  end;
  if ViewDlgEdit then begin
    if not EdDlgEdit.Visible then begin
      EdDlgEdit.Visible := True;
      EdDlgEdit.SetFocus;
      //SetDFocus(EdDlgEdit);
    end;
  end;
end;

{------------------------------------------------------------------------}

procedure TFrmDlg.DLoginNewDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    if TDButton(Sender).Downed then begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DLoginNewClick(Sender: TObject; X, Y: Integer);
begin
  //frmMain.SendGetRandomCode;
  LoginScene.NewClick;
end;

procedure TFrmDlg.DLoginOkClick(Sender: TObject; X, Y: Integer);
begin
  LoginScene.OkClick;
end;

procedure TFrmDlg.DLoginCloseClick(Sender: TObject; X, Y: Integer);
begin
  frmMain.Close;
end;

procedure TFrmDlg.DLoginChgPwClick(Sender: TObject; X, Y: Integer);
begin
  LoginScene.ChgPwClick;
end;

procedure TFrmDlg.DLoginNewClickSound(Sender: TObject;
  Clicksound: TClickSound);
begin
  case Clicksound of
    csNorm: PlaySound(s_norm_button_click);
    csStone: PlaySound(s_rock_button_click);
    csGlass: PlaySound(s_glass_button_click);
  end;
end;

procedure TFrmDlg.ShowSelectServerDlg;
begin
  case g_ServerList.Count of
    1: begin
        DSServer1.Visible := True;
        DSServer1.Top := 204;
        DSServer2.Visible := False;
        DSServer3.Visible := False;
        DSServer4.Visible := False;
        DSServer5.Visible := False;
        DSServer6.Visible := False;
      end;
    2: begin
        DSServer1.Visible := True;
        DSServer1.Top := 190;
        DSServer2.Visible := True;
        DSServer2.Top := 235;
        DSServer3.Visible := False;
        DSServer4.Visible := False;
        DSServer5.Visible := False;
        DSServer6.Visible := False;
      end;
    3: begin
        DSServer1.Visible := True;
        DSServer2.Visible := True;
        DSServer3.Visible := True;
        DSServer4.Visible := False;
        DSServer5.Visible := False;
        DSServer6.Visible := False;
      end;
    4: begin
        DSServer1.Visible := True;
        DSServer2.Visible := True;
        DSServer3.Visible := True;
        DSServer4.Visible := True;
        DSServer5.Visible := False;
        DSServer6.Visible := False;
      end;
    5: begin
        DSServer1.Visible := True;
        DSServer2.Visible := True;
        DSServer3.Visible := True;
        DSServer4.Visible := True;
        DSServer5.Visible := True;
        DSServer6.Visible := False;
      end;
    6: begin
        DSServer1.Visible := True;
        DSServer2.Visible := True;
        DSServer3.Visible := True;
        DSServer4.Visible := True;
        DSServer5.Visible := True;
        DSServer6.Visible := True;
      end;
  else begin
      DSServer1.Visible := True;
      DSServer2.Visible := True;
      DSServer3.Visible := True;
      DSServer4.Visible := True;
      DSServer5.Visible := True;
      DSServer6.Visible := True;
    end;
  end;
  DSelServerDlg.Visible := True;
end;

procedure TFrmDlg.DSelServerDlgDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin

end;

procedure TFrmDlg.DSServer1Click(Sender: TObject; X, Y: Integer);
var
  svname: string;
begin
  svname := '';
  if Sender = DSServer1 then begin
    svname := g_ServerList.Strings[0];
    g_sServerMiniName := svname;
  end;
  if Sender = DSServer2 then begin
    svname := g_ServerList.Strings[1];
    g_sServerMiniName := svname;
  end;
  if Sender = DSServer3 then begin
    svname := g_ServerList.Strings[2];
    g_sServerMiniName := svname;
  end;
  if Sender = DSServer4 then begin
    svname := g_ServerList.Strings[3];
    g_sServerMiniName := svname;
  end;
  if Sender = DSServer5 then begin
    svname := g_ServerList.Strings[4];
    g_sServerMiniName := svname;
  end;
  if Sender = DSServer6 then begin
    svname := g_ServerList.Strings[5];
    g_sServerMiniName := svname;
  end;
  if svname <> '' then begin
    if BO_FOR_TEST then begin
      svname := 'MakeGM';
      g_sServerMiniName := 'MakeGM';
    end;
    frmMain.SendSelectServer(svname);
    DSelServerDlg.Visible := False;
    g_sServerName := svname;
    //Showmessage(svname);
  end;
end;

procedure TFrmDlg.DEngServer1Click(Sender: TObject; X, Y: Integer);
var
  svname: string;
begin
  svname := 'MakeGM';
  g_sServerMiniName := svname;

  if svname <> '' then begin
    frmMain.SendSelectServer(svname);
    DSelServerDlg.Visible := False;
    g_sServerName := svname;
  end;
end;


procedure TFrmDlg.DSSrvCloseClick(Sender: TObject; X, Y: Integer);
begin
  DSelServerDlg.Visible := False;
  frmMain.Close;
end;


{------------------------------------------------------------------------}


procedure TFrmDlg.DNewAccountOkClick(Sender: TObject; X, Y: Integer);
begin
  LoginScene.NewAccountOk;
end;

procedure TFrmDlg.DNewAccountCloseClick(Sender: TObject; X, Y: Integer);
begin
  LoginScene.NewAccountClose;
end;

procedure TFrmDlg.DNewAccountDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  I: Integer;
begin
  with dsurface do begin
    with DNewAccount do begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;

    for I := 0 to NAHelps.Count - 1 do begin
      TextOut((SCREENWIDTH div 2 - 320) + 386 + 10, (SCREENHEIGHT div 2 - 238) + 119 + 5 + I * 14, NAHelps[I], clSilver);
    end;

    //TextOut((SCREENWIDTH div 2 - 320) + 290, (SCREENHEIGHT div 2 - 238) + 119 + 5 + 6 * 14, g_sRandomCode, clLime);
    BoldTextOut(79 + 283, 64 + 57, NewAccountTitle);
  end;
end;



{------------------------------------------------------------------------}

procedure TFrmDlg.DChgpwOkClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DChgpwOk then LoginScene.ChgpwOk;
  if Sender = DChgpwCancel then LoginScene.ChgpwCancel;
end;




{------------------------------------------------------------------------}
//某腐磐 急琶


procedure TFrmDlg.DscSelect1DirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    d := nil;
    if Downed then begin
      //WLib := g_WMain2Images;
      if Sender = DscSelect1 then d := g_WMainImages.Images[66];
      if Sender = DscSelect2 then d := g_WMainImages.Images[67];
      if Sender = DscStart then d := g_WMain2Images.Images[482];
      if Sender = DscNewChr then d := g_WMain2Images.Images[485];
      if Sender = DscEraseChr then d := g_WMain2Images.Images[486];
      if Sender = DscCredits then d := g_WMain2Images.Images[487];
      if Sender = DscExit then d := g_WMain2Images.Images[488];
    end else
      if MouseMoveing then begin
      //WLib := g_WMain2Images;
      if Sender = DscSelect1 then d := g_WMain2Images.Images[483];
      if Sender = DscSelect2 then d := g_WMain2Images.Images[484];
      if Sender = DscStart then d := g_WMain2Images.Images[481];
      if Sender = DscNewChr then d := g_WMainImages.Images[69];
      if Sender = DscEraseChr then d := g_WMainImages.Images[70];
      if Sender = DscCredits then d := g_WMain3Images.Images[405];
      if Sender = DscExit then d := g_WMainImages.Images[72];
    end else begin
      if Sender = DscSelect1 then WLib := nil;
      if Sender = DscSelect2 then WLib := nil;
      if Sender = DscStart then WLib := nil;
      if Sender = DscNewChr then WLib := nil;
      if Sender = DscEraseChr then WLib := nil;
      if Sender = DscCredits then WLib := nil;
      if Sender = DscExit then WLib := nil;

      //WLib := g_WMain2Images;
      {if Sender = DscSelect1 then d := g_WMain2Images.Images[484];
      if Sender = DscSelect2 then d := g_WMain2Images.Images[484];
      if Sender = DscStart then d := g_WMain2Images.Images[484];
      if Sender = DscNewChr then d := g_WMain2Images.Images[484];
      if Sender = DscEraseChr then d := g_WMain2Images.Images[484];
      if Sender = DscCredits then d := g_WMain2Images.Images[484];
      if Sender = DscExit then d := g_WMain2Images.Images[484];  }
    end;


    if (d = nil) and (WLib <> nil) then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(Left, Top, d.ClientRect, d, True);

    if (Sender = DscStart) and g_boReSelConnect then begin
      dsurface.FillRectAlpha(g_ClientRect, clblack, 150);
      if GetTickCount - g_dwReSelConnectTick > 100 then begin
        g_dwReSelConnectTick := GetTickCount;
        g_ClientRect.Top := g_ClientRect.Top + 1;
        if g_ClientRect.Top > g_ClientRect.Bottom then begin
          g_boReSelConnect := False;
          Enabled := True;
        end;
      end;
    end;

  end;
end;

procedure TFrmDlg.DscSelect1Click(Sender: TObject; X, Y: Integer);
begin
  if Sender = DscSelect1 then SelectChrScene.SelChrSelect1Click;
  if Sender = DscSelect2 then SelectChrScene.SelChrSelect2Click;
  if Sender = DscStart then SelectChrScene.SelChrStartClick;
  if Sender = DscNewChr then SelectChrScene.SelChrNewChrClick;
  if Sender = DscEraseChr then SelectChrScene.SelChrEraseChrClick;
  if Sender = DscCredits then SelectChrScene.SelChrQueryDelChrClick; //SelectChrScene.SelChrCreditsClick;
  if Sender = DscExit then SelectChrScene.SelChrExitClick;
end;

procedure TFrmDlg.DccCloseDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    if Downed then begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end else begin
      d := nil;
      if Sender = DccWarrior then begin
        with SelectChrScene do
          if (ChrArr[NewIndex].UserChr.job = 0) and (WLib <> nil) then d := WLib.Images[55];
      end;
      if Sender = DccWizzard then begin
        with SelectChrScene do
          if (ChrArr[NewIndex].UserChr.job = 1) and (WLib <> nil) then d := WLib.Images[56];
      end;
      if Sender = DccMonk then begin
        with SelectChrScene do
          if (ChrArr[NewIndex].UserChr.job = 2) and (WLib <> nil) then d := WLib.Images[57];
      end;
      if Sender = DccMale then begin
        with SelectChrScene do
          if (ChrArr[NewIndex].UserChr.sex = 0) and (WLib <> nil) then d := WLib.Images[58];
      end;
      if Sender = DccFemale then begin
        with SelectChrScene do
          if (ChrArr[NewIndex].UserChr.sex = 1) and (WLib <> nil) then d := WLib.Images[59];
      end;

      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DccCloseClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DccClose then SelectChrScene.SelChrNewClose;
  if Sender = DccWarrior then SelectChrScene.SelChrNewJob(0);
  if Sender = DccWizzard then SelectChrScene.SelChrNewJob(1);
  if Sender = DccMonk then SelectChrScene.SelChrNewJob(2);
  if Sender = DccReserved then SelectChrScene.SelChrNewJob(3);
  if Sender = DccMale then SelectChrScene.SelChrNewm_btSex(0);
  if Sender = DccFemale then SelectChrScene.SelChrNewm_btSex(1);
  if Sender = DccLeftHair then SelectChrScene.SelChrNewPrevHair;
  if Sender = DccRightHair then SelectChrScene.SelChrNewNextHair;
  if Sender = DccOk then SelectChrScene.SelChrNewOk;
end;


procedure TFrmDlg.DStateWinDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  I, L, m, pgidx, magline, bbx, bby, mmx, Idx, ax, ay, trainlv: Integer;
  pm: PTClientMagic;
  d: TTexture;
  hcolor, old, keyimg: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;
  c: TColor;
begin
  if g_MySelf = nil then Exit;
  with DStateWin do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    case StatePage of
      0: begin
          pgidx := 29;
          if g_MySelf <> nil then
            if g_MySelf.m_btSex = 1 then pgidx := 30;
          bbx := Left + 38;
          bby := Top + 52;
          d := g_WMain3Images.Images[pgidx];
          if d <> nil then
            dsurface.Draw(SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, False);
          bbx := bbx - 7;
          bby := bby + 44;
          if g_MySelf.m_btHair < 4 then begin
            Idx := 440 + g_MySelf.m_btHair;
          //idx := 440 + g_MySelf.m_btHair div 2;
          //if g_MySelf.m_btSex = 1 then idx := 480 + g_MySelf.m_btHair div 2;
            if Idx > 0 then begin
              d := g_WMainImages.GetCachedImage(Idx, ax, ay);
              if d <> nil then
                dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
            end;
          end;

          if g_UseItems[U_DRESS].s.Name <> '' then begin
            Idx := g_UseItems[U_DRESS].s.looks; //渴 if Myself.m_btSex = 1 then idx := 80; //咯磊渴
            if Idx >= 0 then begin
              //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
              d := GetWStateImg(Idx, ax, ay);
              if d <> nil then
                dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
            end;

            //Load HumEffect image on state armour
            if (g_UseItems[U_DRESS].s.AniCount = 113) and (Idx = 2540) then begin
                d:= GetWStateImg(Idx + 1, ax, ay);
                if d <> nil then
                  DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d);
            end else
            if (g_UseItems[U_DRESS].s.AniCount = 114) and (Idx = 2542) then begin
                d:= GetWStateImg(Idx + 1, ax, ay);
                if d <> nil then
                  DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d);
            end;

            if (g_UseItems[U_DRESS].s.AniCount = 109) and (Idx = 2420) then begin
                d:= GetWStateImg(Idx + 5, ax, ay);
                if d <> nil then
                  DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d);
            end else
            if (g_UseItems[U_DRESS].s.AniCount = 110) and (Idx = 2421) then begin
                d:= GetWStateImg(Idx + 5, ax, ay);
                if d <> nil then
                  DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d);
            end;

          end;
          if g_UseItems[U_WEAPON].s.Name <> '' then begin
            Idx := g_UseItems[U_WEAPON].s.looks;
            if Idx >= 0 then begin
              //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
              d := GetWStateImg(Idx, ax, ay);
              if d <> nil then begin
                dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
                //d.SaveToFile('d.bmp');
              end;
              if (g_UseItems[U_WEAPON].s.Shape = 38) and (Idx = 1404) then begin
                d := GetWStateImg(Idx - 1, ax, ay);
                if d <> nil then
                  DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d);
              end else

              if (g_UseItems[U_WEAPON].s.Shape = 103) and (Idx = 2423) then begin
                d := GetWStateImg(Idx + 4, ax, ay);
                if d <> nil then
                  DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d);
              end else
              //end;
              //Weapon 56
                if (g_UseItems[U_WEAPON].s.Shape = 56) and (Idx = 1880) then begin
                if (g_dwWeapon56Index[0] < 1890) or (g_dwWeapon56Index[0] > 1899) then
                  g_dwWeapon56Index[0] := 1890;
                if GetTickCount - g_dwWeapon56Tick[0] > 100 then begin
                  g_dwWeapon56Tick[0] := GetTickCount;
                  g_dwWeapon56Index[0] := g_dwWeapon56Index[0] + 1;
                end;
                if (g_dwWeapon56Index[0] < 1890) or (g_dwWeapon56Index[0] > 1899) then
                  g_dwWeapon56Index[0] := 1890;

                d := GetWStateImg(g_dwWeapon56Index[0], ax, ay);

                if d <> nil then
                  DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d);

                end;
               //Weapon 105
                if (g_UseItems[U_WEAPON].s.Shape = 105) and (Idx = 2523) then begin
                if (g_dwWeapon105Index[0] < 2530) or (g_dwWeapon105Index[0] > 2537) then
                  g_dwWeapon105Index[0] := 2530;
                if GetTickCount - g_dwWeapon105Tick[0] > 100 then begin
                  g_dwWeapon105Tick[0] := GetTickCount;
                  g_dwWeapon105Index[0] := g_dwWeapon105Index[0] + 1;
                end;
                if (g_dwWeapon105Index[0] < 2530) or (g_dwWeapon105Index[0] > 2537) then
                  g_dwWeapon105Index[0] := 2530;

                d := GetWStateImg(g_dwWeapon105Index[0], ax, ay);

                if d <> nil then
                  DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d);
               //end Weapon 105
               end;
               //Weapon 106
                if (g_UseItems[U_WEAPON].s.Shape = 106) and (Idx = 2524) then begin
                if (g_dwWeapon106Index[0] < 2550) or (g_dwWeapon106Index[0] > 2559) then
                  g_dwWeapon106Index[0] := 2550;
                if GetTickCount - g_dwWeapon106Tick[0] > 100 then begin
                  g_dwWeapon106Tick[0] := GetTickCount;
                  g_dwWeapon106Index[0] := g_dwWeapon106Index[0] + 1;
                end;
                if (g_dwWeapon106Index[0] < 2550) or (g_dwWeapon106Index[0] > 2559) then
                  g_dwWeapon106Index[0] := 2550;

                d := GetWStateImg(g_dwWeapon106Index[0], ax, ay);

                if d <> nil then
                  DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d);
               //end Weapon 106
                end else
               //Weapon 107
                if (g_UseItems[U_WEAPON].s.Shape = 107) and (Idx = 2525) then begin
                if (g_dwWeapon107Index[0] < 2560) or (g_dwWeapon107Index[0] > 2569) then
                  g_dwWeapon107Index[0] := 2560;
                if GetTickCount - g_dwWeapon107Tick[0] > 100 then begin
                  g_dwWeapon107Tick[0] := GetTickCount;
                  g_dwWeapon107Index[0] := g_dwWeapon107Index[0] + 1;
                end;
                if (g_dwWeapon107Index[0] < 2560) or (g_dwWeapon107Index[0] > 2569) then
                  g_dwWeapon107Index[0] := 2560;

                d := GetWStateImg(g_dwWeapon107Index[0], ax, ay);

                if d <> nil then
                  DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d);
               //end Weapon 107
              end;
            end;
          end;
        //end;
          if g_UseItems[U_HELMET].s.Name <> '' then begin
            Idx := g_UseItems[U_HELMET].s.looks;
            if Idx >= 0 then begin
              //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
              d := GetWStateImg(Idx, ax, ay);
              if d <> nil then
                dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
            end;
          end;
        end;
      1: begin //瓷仿摹
          L := Left + 112; //66;
          m := Top + 99;
          with dsurface do begin
            TextOut(SurfaceX(L + 0), SurfaceY(m + 0), IntToStr(Loword(g_MySelf.m_Abil.AC)) + '-' + IntToStr(Hiword(g_MySelf.m_Abil.AC)));
            TextOut(SurfaceX(L + 0), SurfaceY(m + 20), IntToStr(Loword(g_MySelf.m_Abil.MAC)) + '-' + IntToStr(Hiword(g_MySelf.m_Abil.MAC)));
            TextOut(SurfaceX(L + 0), SurfaceY(m + 40), IntToStr(Loword(g_MySelf.m_Abil.DC)) + '-' + IntToStr(Hiword(g_MySelf.m_Abil.DC)));
            TextOut(SurfaceX(L + 0), SurfaceY(m + 60), IntToStr(Loword(g_MySelf.m_Abil.MC)) + '-' + IntToStr(Hiword(g_MySelf.m_Abil.MC)));
            TextOut(SurfaceX(L + 0), SurfaceY(m + 80), IntToStr(Loword(g_MySelf.m_Abil.SC)) + '-' + IntToStr(Hiword(g_MySelf.m_Abil.SC)));
            TextOut(SurfaceX(L + 0), SurfaceY(m + 100), IntToStr(g_MySelf.m_Abil.HP) + '/' + IntToStr(g_MySelf.m_Abil.MaxHP));
            TextOut(SurfaceX(L + 0), SurfaceY(m + 120), IntToStr(g_MySelf.m_Abil.MP) + '/' + IntToStr(g_MySelf.m_Abil.MaxMP));
          end;
        end;
      2: begin //瓷仿摹 汲疙芒
          bbx := Left + 38;
          bby := Top + 52;
          d := g_WMain3Images.Images[32];
          if d <> nil then
            dsurface.Draw(SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, False);

          bbx := bbx + 20;
          bby := bby + 10;

          if AbilPage = 0 then begin
            with dsurface do begin
              mmx := bbx + 85;
              TextOut(bbx, bby, 'Experience ', clSilver);
            //TextOut(mmx, bby, FloatToStrFixFmt(100 * g_MySelf.m_Abil.Exp / g_MySelf.m_Abil.MaxExp, 3, 2) + '%');
              c := clSilver;
              TextOut(mmx, bby, IntToStr(g_MySelf.m_Abil.Exp), clSilver);
              bby := bby + 14;
              TextOut(bbx, bby, 'Next Level Exp. ', clSilver);
              TextOut(mmx, bby, IntToStr(g_MySelf.m_Abil.MaxExp), clSilver);

              TextOut(bbx, bby + 14 * 1, 'Bag Weight ', clSilver);
              if g_MySelf.m_Abil.Weight > g_MySelf.m_Abil.MaxWeight then
                c := clRed
              else
                c := clSilver;
              TextOut(mmx, bby + 14 * 1, IntToStr(g_MySelf.m_Abil.Weight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWeight), c);

              TextOut(bbx, bby + 14 * 2, 'C. Weight ', clSilver);
              if g_MySelf.m_Abil.WearWeight > g_MySelf.m_Abil.MaxWearWeight then
                c := clRed
              else
                c := clSilver;
              TextOut(mmx, bby + 14 * 2, IntToStr(g_MySelf.m_Abil.WearWeight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWearWeight), c);


              TextOut(bbx, bby + 14 * 3, 'Hands W. ', clSilver);
              if g_MySelf.m_Abil.HandWeight > g_MySelf.m_Abil.MaxHandWeight then
                c := clRed
              else
                c := clSilver;
              TextOut(mmx, bby + 14 * 3, IntToStr(g_MySelf.m_Abil.HandWeight) + '/' + IntToStr(g_MySelf.m_Abil.MaxHandWeight), c);

              TextOut(bbx, bby + 14 * 4, 'Accuracy ', clSilver);
              TextOut(mmx, bby + 14 * 4, IntToStr(g_nMyHitPoint), clSilver);

              TextOut(bbx, bby + 14 * 5, 'Agility ', clSilver);
              TextOut(mmx, bby + 14 * 5, IntToStr(g_nMySpeedPoint), clSilver);

              TextOut(bbx, bby + 14 * 6, 'M. Resistance ', clSilver);
              TextOut(mmx, bby + 14 * 6, '+' + IntToStr(g_nMyAntiMagic * 10) + '%', clSilver);

              TextOut(bbx, bby + 14 * 7, 'P. Resistance ', clSilver);
              TextOut(mmx, bby + 14 * 7, '+' + IntToStr(g_nMyAntiPoison * 10) + '%', clSilver);

              TextOut(bbx, bby + 14 * 8, 'P. Recovery ', clSilver);
              TextOut(mmx, bby + 14 * 8, '+' + IntToStr(g_nMyPoisonRecover * 10) + '%', clSilver);

              TextOut(bbx, bby + 14 * 9, 'HP Recovery', clSilver);
              TextOut(mmx, bby + 14 * 9, '+' + IntToStr(g_nMyHealthRecover * 10) + '%', clSilver);

              TextOut(bbx, bby + 14 * 10, 'MP Recovery', clSilver);
              TextOut(mmx, bby + 14 * 10, '+' + IntToStr(g_nMySpellRecover * 10) + '%', clSilver);

              TextOut(bbx, bby + 14 * 11, g_sGameGoldName + ' ', clSilver);
              TextOut(mmx, bby + 14 * 11, IntToStr(g_MySelf.m_nGameGold), clSilver);

              TextOut(bbx, bby + 14 * 12, g_sGamePointName + ' ', clSilver);
              TextOut(mmx, bby + 14 * 12, IntToStr(g_MySelf.m_nGamePoint), clSilver);

              if {(g_ServerConfig.btShowClientItemStyle = 0) and}  g_ServerConfig.boAllowItemAddPoint then begin
                TextOut(bbx, bby + 14 * 13, 'Move Speed ', clSilver);
                TextOut(mmx, bby + 14 * 13, '+' + IntToStr(g_MySelf.m_Abil.MoveSpeed) + '%', clSilver);

                TextOut(bbx, bby + 14 * 14, 'Attack Speed', clSilver);
                TextOut(mmx, bby + 14 * 14, '+' + IntToStr(g_MySelf.m_Abil.AttackSpeed) + '%', clSilver);
              end;

            end;
          end else begin
            mmx := bbx + 110;
            with dsurface do begin
              TextOut(bbx, bby, '物理伤害减少', clSilver);
              TextOut(mmx, bby, '+' + IntToStr(g_MySelf.m_Abil.AddPoint[0]) + '%', clSilver);

              TextOut(bbx, bby + 14 * 1, '魔法伤害减少', clSilver);
              TextOut(mmx, bby + 14 * 1, '+' + IntToStr(g_MySelf.m_Abil.AddPoint[1]) + '%', clSilver);

              TextOut(bbx, bby + 14 * 2, '忽视目标防御', clSilver);
              TextOut(mmx, bby + 14 * 2, '+' + IntToStr(g_MySelf.m_Abil.AddPoint[2]) + '%', clSilver);

              TextOut(bbx, bby + 14 * 3, '所有伤害反射', clSilver);
              TextOut(mmx, bby + 14 * 3, '+' + IntToStr(g_MySelf.m_Abil.AddPoint[3]) + '%', clSilver);

              TextOut(bbx, bby + 14 * 4, '增加攻击伤害', clSilver);
              TextOut(mmx, bby + 14 * 4, '+' + IntToStr(g_MySelf.m_Abil.AddPoint[4]) + '%', clSilver);


              TextOut(bbx, bby + 14 * 5, '物理防御增强', clSilver);
              TextOut(mmx, bby + 14 * 5, '+' + IntToStr(g_MySelf.m_Abil.AddPoint[5]) + '%', clSilver);

              TextOut(bbx, bby + 14 * 6, '魔法防御增强', clSilver);
              TextOut(mmx, bby + 14 * 6, '+' + IntToStr(g_MySelf.m_Abil.AddPoint[6]) + '%', clSilver);

              TextOut(bbx, bby + 14 * 7, '物理攻击增强', clSilver);
              TextOut(mmx, bby + 14 * 7, '+' + IntToStr(g_MySelf.m_Abil.AddPoint[7]) + '%', clSilver);

              TextOut(bbx, bby + 14 * 8, '魔法攻击增强', clSilver);
              TextOut(mmx, bby + 14 * 8, '+' + IntToStr(g_MySelf.m_Abil.AddPoint[8]) + '%', clSilver);

              TextOut(bbx, bby + 14 * 9, '道术攻击增强', clSilver);
              TextOut(mmx, bby + 14 * 9, '+' + IntToStr(g_MySelf.m_Abil.AddPoint[9]) + '%', clSilver);

              TextOut(bbx, bby + 14 * 10, '增加进入失明状态', clSilver);
              TextOut(mmx, bby + 14 * 10, '+' + IntToStr(g_MySelf.m_Abil.AddPoint[10]) + '%', clSilver);

              TextOut(bbx, bby + 14 * 11, '增加进入混乱状态', clSilver);
              TextOut(mmx, bby + 14 * 11, '+' + IntToStr(g_MySelf.m_Abil.AddPoint[11]) + '%', clSilver);

              TextOut(bbx, bby + 14 * 12, '减少进入失明状态', clSilver);
              TextOut(mmx, bby + 14 * 12, '+' + IntToStr(g_MySelf.m_Abil.AddPoint[12]) + '%', clSilver);

              TextOut(bbx, bby + 14 * 13, '减少进入混乱状态', clSilver);
              TextOut(mmx, bby + 14 * 13, '+' + IntToStr(g_MySelf.m_Abil.AddPoint[13]) + '%', clSilver);
            end;
          end;
        end;
      3: begin //魔法
          bbx := Left + 38;
          bby := Top + 52;
          d := g_WMain2Images.Images[743];
          if d <> nil then
            dsurface.Draw(SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, False);

          magtop := MagicPage * 6;
          magline := _MIN(MagicPage * 6 + 6, g_MagicList.Count);
          for I := magtop to magline - 1 do begin
            pm := PTClientMagic(g_MagicList[I]);
            m := I - magtop;
            keyimg := 0;
            {case Byte(pm.Key) of
              Byte('E'): keyimg := 642;
              Byte('F'): keyimg := 643;
              Byte('G'): keyimg := 644;
              Byte('H'): keyimg := 645;
              Byte('I'): keyimg := 646;
              Byte('J'): keyimg := 647;
              Byte('K'): keyimg := 648;
              Byte('L'): keyimg := 649;


              Byte('1'): keyimg := 248;
              Byte('2'): keyimg := 249;
              Byte('3'): keyimg := 250;
              Byte('4'): keyimg := 251;
              Byte('5'): keyimg := 252;
              Byte('6'): keyimg := 253;
              Byte('7'): keyimg := 254;
              Byte('8'): keyimg := 255;


            end;}
            case Byte(pm.Key) of
              Byte('E'): keyimg := 148;
              Byte('F'): keyimg := 149;
              Byte('G'): keyimg := 150;
              Byte('H'): keyimg := 151;
              Byte('I'): keyimg := 152;
              Byte('J'): keyimg := 153;
              Byte('K'): keyimg := 154;
              Byte('L'): keyimg := 155;


              Byte('1'): keyimg := 156;
              Byte('2'): keyimg := 157;
              Byte('3'): keyimg := 158;
              Byte('4'): keyimg := 159;
              Byte('5'): keyimg := 160;
              Byte('6'): keyimg := 161;
              Byte('7'): keyimg := 162;
              Byte('8'): keyimg := 163;
            end;

            if keyimg > 0 then begin
              d := g_WMain3Images.Images[keyimg];
              if d <> nil then
                dsurface.Draw(bbx + 145, bby + 8 + m * 37, d.ClientRect, d, True);
            end;
            d := g_WMainImages.Images[112]; //lv
            if d <> nil then
              dsurface.Draw(bbx + 48, bby + 8 + 15 + m * 37, d.ClientRect, d, True);
            d := g_WMainImages.Images[111]; //exp
            if d <> nil then
              dsurface.Draw(bbx + 48 + 26, bby + 8 + 15 + m * 37, d.ClientRect, d, True);
          end;

          with dsurface do begin
            c := clSilver;
            for I := magtop to magline - 1 do begin
              pm := PTClientMagic(g_MagicList[I]);
              m := I - magtop;
             {
              if not (pm.Level in [0..3]) then pm.Level := 0; //魔法最多3级
              TextOut(bbx + 48, bby + 8 + m * 37,
                pm.Def.sMagicName);
              if pm.Level in [0..3] then trainlv := pm.Level
              else trainlv := 0;
              }
              if pm.Def.wMagicId in [31] then begin //if pm.Def.wMagicId in [13, 26, 31, 45] then begin
                if not (pm.Level in [0..4]) then pm.Level := 0; //魔法最多3级
              end else begin
                if not (pm.Level in [0..3]) then pm.Level := 0; //魔法最多3级
              end;
              TextOut(bbx + 48, bby + 8 + m * 37, pm.Def.sMagicName, c);

              if pm.Def.wMagicId in [31] then begin //if pm.Def.wMagicId in [13, 26, 31, 45] then begin
                if pm.Level in [0..4] then begin
                  trainlv := pm.Level;
                  if trainlv >= 3 then trainlv := trainlv - 1;
                end else trainlv := 0;
              end else begin
                if pm.Level in [0..3] then trainlv := pm.Level
                else trainlv := 0;
              end;

              TextOut(bbx + 48 + 16, bby + 8 + 15 + m * 37, IntToStr(pm.Level), c);
              if pm.Def.MaxTrain[trainlv] > 0 then begin
                if trainlv < 3 then
                  TextOut(bbx + 48 + 46, bby + 8 + 15 + m * 37, IntToStr(pm.CurTrain) + '/' + IntToStr(pm.Def.MaxTrain[trainlv]), c)
                else TextOut(bbx + 48 + 46, bby + 8 + 15 + m * 37, '-', c);
              end;
            end;
          end;
        end;
    end;

     //原为打开，本代码为显示人物身上所带物品信息，显示位置为人物下方
    if (g_ServerConfig.btShowClientItemStyle <> 0) then begin
      if g_MouseStateItem.s.Name <> '' then begin
        g_MouseItem := g_MouseStateItem;
        GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
        if iname <> '' then begin
          if g_MouseItem.Dura = 0 then hcolor := clRed
          else hcolor := clWhite;
          with dsurface do begin
            old := MainForm.Canvas.Font.Size;
            MainForm.Canvas.Font.Size := 9;
            Font.Color := clyellow;
            bbx := SurfaceX(Left + 37);
            bby := SurfaceY(Top + 272 + 35);

            TextOut(bbx, bby, iname, clyellow); //2006-10-24 Mars修改
            TextOut(bbx + TextWidth(iname), bby, d1, hcolor);
            TextOut(bbx, bby + TextHeight('A') + 2, d2, hcolor);
            TextOut(bbx, bby + (TextHeight('A') + 2) * 2, d3, hcolor);

            if d2 <> '' then
              bby := bby + TextHeight('A') + 2;
            if d3 <> '' then
              bby := bby + TextHeight('A') + 2;

            bby := bby + TextHeight('A') + 2;

            for I := 0 to g_ExtractStringList.Count - 1 do begin
              TextOut(bbx, bby + (TextHeight('A') + 2) * I, g_ExtractStringList.Strings[I], hcolor);
            end;

            MainForm.Canvas.Font.Size := old;
          end;
        end;
        //g_MouseItem.s.Name := '';
      end;
    end;
     //玩家名称、行会
    with dsurface do begin
      TextOut(SurfaceX(Left + 122 - TextWidth(g_sSelChrName) div 2),
        SurfaceY(Top + 23), g_MySelf.m_sUserName, g_MySelf.m_nNameColor);
      if StatePage = 0 then begin
        TextOut(SurfaceX(Left + 45), SurfaceY(Top + 55),
          g_sGuildName + ' ' + g_sGuildRankName, clSilver);
      end;
    end;
  end;
end;

procedure TFrmDlg.DSWLightDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  Idx: Integer;
  d: TTexture;
  nWhere: Integer;
begin
  nWhere := -1;
  if StatePage = 0 then begin
    if Sender = DSWNecklace then nWhere := U_NECKLACE;
    if Sender = DSWLight then nWhere := U_RIGHTHAND;
    if Sender = DSWArmRingR then nWhere := U_ARMRINGR;
    if Sender = DSWArmRingL then nWhere := U_ARMRINGL;
    if Sender = DSWRingR then nWhere := U_RINGR;
    if Sender = DSWRingL then nWhere := U_RINGL;
    if Sender = DSWBujuk then nWhere := U_BUJUK;
    if Sender = DSWBelt then nWhere := U_BELT;
    if Sender = DSWBoots then nWhere := U_BOOTS;
    if Sender = DSWCharm then nWhere := U_CHARM;

    if nWhere >= 0 then begin
      if g_UseItems[nWhere].s.Name <> '' then begin
        Idx := g_UseItems[nWhere].s.looks;
        if Idx >= 0 then begin
          d := GetWStateImg(Idx);
          if d <> nil then
            with TDButton(Sender) do
              dsurface.Draw(SurfaceX(Left + (Width - d.Width) div 2),
                SurfaceY(Top + (Height - d.Height) div 2),
                d.ClientRect, d, True);

          if (g_UseItems[nWhere].s.AddValue[12] in [1, 3]) {or (GetAddPoint(g_UseItems[nWhere].s.AddPoint))} then begin
            if GetTickCount - g_DrawUseItems[nWhere].dwDrawTick >= 200 then begin
              g_DrawUseItems[nWhere].dwDrawTick := GetTickCount;
              if g_DrawUseItems[nWhere].nIndex <= 0 then g_DrawUseItems[nWhere].nIndex := 260 - 1;
              Inc(g_DrawUseItems[nWhere].nIndex);
              if g_DrawUseItems[nWhere].nIndex > 265 then g_DrawUseItems[nWhere].nIndex := 260;
            end;
            d := g_WMain2Images.Images[g_DrawUseItems[nWhere].nIndex];
            if d <> nil then begin
              with TDButton(Sender) do
                DrawBlend(dsurface, SurfaceX(Left + (Width - d.Width) div 2),
                  SurfaceY(Top + (Height - d.Height) div 2), d);
            end;
          end;

          if g_UseItems[nWhere].s.AddValue[12] >= 2 then begin
            if GetTickCount - g_DrawUseItems_[nWhere].dwDrawTick >= 200 then begin
              g_DrawUseItems_[nWhere].dwDrawTick := GetTickCount;
              if g_DrawUseItems_[nWhere].nIndex <= 0 then g_DrawUseItems_[nWhere].nIndex := 600 - 1;
              Inc(g_DrawUseItems_[nWhere].nIndex);
              if g_DrawUseItems_[nWhere].nIndex > 617 then g_DrawUseItems_[nWhere].nIndex := 600;
            end;
            d := g_WMain3Images.Images[g_DrawUseItems_[nWhere].nIndex];
            if d <> nil then begin
              with TDButton(Sender) do
                DrawBlend(dsurface, SurfaceX(Left + (Width - d.Width) div 2),
                  SurfaceY(Top + (Height - d.Height) div 2), d);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DStateWinClick(Sender: TObject; X, Y: Integer);
begin
  if StatePage = 3 then begin
    X := DStateWin.LocalX(X) - DStateWin.Left;
    Y := DStateWin.LocalY(Y) - DStateWin.Top;
    if (X >= 33) and (X <= 33 + 166) and (Y >= 55) and (Y <= 55 + 37 * 5) then begin
      magcur := (Y - 55) div 37;
      if (magcur + magtop) >= g_MagicList.Count then
        magcur := (g_MagicList.Count - 1) - magtop;
    end;
  end;
end;

procedure TFrmDlg.DCloseStateClick(Sender: TObject; X, Y: Integer);
begin
  DStateWin.Visible := False;
end;

procedure TFrmDlg.DPrevStateDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    if TDButton(Sender).Downed then begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.PageChanged;
begin
  DScreen.ClearHint;
  case StatePage of
    0: begin
        DSWWeapon.Visible := True;
        DSWHelmet.Visible := True;
        DSWArmRingR.Visible := True;
        DSWRingR.Visible := True;
        DSWDress.Visible := True;
        DSWNecklace.Visible := True;
        DSWLight.Visible := True;
        DSWArmRingL.Visible := True;
        DSWRingL.Visible := True;
        DSWCharm.Visible := True;
        DSWBoots.Visible := True;
        DSWBelt.Visible := True;
        DSWBujuk.Visible := True;

        DStPageUp.Visible := False;
        DStPageDown.Visible := False;

        DStMag1.Visible := False; DStMag2.Visible := False;
        DStMag3.Visible := False; DStMag4.Visible := False;
        DStMag5.Visible := False; DStMag6.Visible := False;
        DStPageUp.Visible := False;
        DStPageDown.Visible := False;
      end;
    2: begin
        DSWWeapon.Visible := False;
        DSWHelmet.Visible := False;
        DSWArmRingR.Visible := False;
        DSWRingR.Visible := False;
        DSWDress.Visible := False;
        DSWNecklace.Visible := False;
        DSWLight.Visible := False;
        DSWArmRingL.Visible := False;
        DSWRingL.Visible := False;
        DSWCharm.Visible := False;
        DSWBoots.Visible := False;
        DSWBelt.Visible := False;
        DSWBujuk.Visible := False;

        DStMag1.Visible := False; DStMag2.Visible := False;
        DStMag3.Visible := False; DStMag4.Visible := False;
        DStMag5.Visible := False; DStMag6.Visible := False;
        DStPageUp.Visible := True;
        DStPageDown.Visible := True;
        AbilPage := 0;
      end;

    3: begin //魔法快捷键
        DSWWeapon.Visible := False;
        DSWHelmet.Visible := False;
        DSWArmRingR.Visible := False;
        DSWRingR.Visible := False;
        DSWDress.Visible := False;
        DSWNecklace.Visible := False;
        DSWLight.Visible := False;
        DSWArmRingL.Visible := False;
        DSWRingL.Visible := False;
        DSWCharm.Visible := False;
        DSWBoots.Visible := False;
        DSWBelt.Visible := False;
        DSWBujuk.Visible := False;

        DStMag1.Visible := True; DStMag2.Visible := True;
        DStMag3.Visible := True; DStMag4.Visible := True;
        DStMag5.Visible := True; DStMag6.Visible := True;

        DStPageUp.Visible := True;
        DStPageDown.Visible := True;
        MagicPage := 0;
      end;
  else begin
      DSWWeapon.Visible := False;
      DSWHelmet.Visible := False;
      DSWArmRingR.Visible := False;
      DSWRingR.Visible := False;
      DSWDress.Visible := False;
      DSWNecklace.Visible := False;
      DSWLight.Visible := False;
      DSWArmRingL.Visible := False;
      DSWRingL.Visible := False;
      DSWCharm.Visible := False;
      DSWBoots.Visible := False;
      DSWBelt.Visible := False;
      DSWBujuk.Visible := False;

      DStMag1.Visible := False; DStMag2.Visible := False;
      DStMag3.Visible := False; DStMag4.Visible := False;
      DStMag5.Visible := False; DStMag6.Visible := False;
      DStPageUp.Visible := False;
      DStPageDown.Visible := False;

    end;
  end;
end;

{procedure TFrmDlg.PageChanged;
begin
  DScreen.ClearHint;
  case StatePage of
    3: begin //魔法 惑怕芒
        DStMag1.Visible := True; DStMag2.Visible := True;
        DStMag3.Visible := True; DStMag4.Visible := True;
        DStMag5.Visible := True; DStMag6.Visible := True;
        DStPageUp.Visible := True;
        DStPageDown.Visible := True;
        MagicPage := 0;
      end;
  else begin
      DStMag1.Visible := False; DStMag2.Visible := False;
      DStMag3.Visible := False; DStMag4.Visible := False;
      DStMag5.Visible := False; DStMag6.Visible := False;
      DStPageUp.Visible := False;
      DStPageDown.Visible := False;
    end;
  end;
end;    }

procedure TFrmDlg.HeroPageChanged;
begin
  DScreen.ClearHint;
  case HeroStatePage of
    0: begin
        DHeroSWWeapon.Visible := True;
        DHeroSWHelmet.Visible := True;
        DHeroSWArmRingR.Visible := True;
        DHeroSWRingR.Visible := True;
        DHeroSWDress.Visible := True;
        DHeroSWNecklace.Visible := True;
        DHeroSWLight.Visible := True;
        DHeroSWArmRingL.Visible := True;
        DHeroSWRingL.Visible := True;
        DHeroSWCharm.Visible := True;
        DHeroSWBoots.Visible := True;
        DHeroSWBelt.Visible := True;
        DHeroSWBujuk.Visible := True;

        DHeroStPageUp.Visible := False;
        DHeroStPageDown.Visible := False;

        DHeroStMag1.Visible := False; DHeroStMag2.Visible := False;
        DHeroStMag3.Visible := False; DHeroStMag4.Visible := False;
        DHeroStMag5.Visible := False; DHeroStMag6.Visible := False;
        DHeroStPageUp.Visible := False;
        DHeroStPageDown.Visible := False;
      end;
    3: begin //魔法快捷键
        DHeroSWWeapon.Visible := False;
        DHeroSWHelmet.Visible := False;
        DHeroSWArmRingR.Visible := False;
        DHeroSWRingR.Visible := False;
        DHeroSWDress.Visible := False;
        DHeroSWNecklace.Visible := False;
        DHeroSWLight.Visible := False;
        DHeroSWArmRingL.Visible := False;
        DHeroSWRingL.Visible := False;
        DHeroSWCharm.Visible := False;
        DHeroSWBoots.Visible := False;
        DHeroSWBelt.Visible := False;
        DHeroSWBujuk.Visible := False;

        DHeroStMag1.Visible := True; DHeroStMag2.Visible := True;
        DHeroStMag3.Visible := True; DHeroStMag4.Visible := True;
        DHeroStMag5.Visible := True; DHeroStMag6.Visible := True;

        DHeroStPageUp.Visible := True;
        DHeroStPageDown.Visible := True;
        HeroMagicPage := 0;
      end;
  else begin
      DHeroSWWeapon.Visible := False;
      DHeroSWHelmet.Visible := False;
      DHeroSWArmRingR.Visible := False;
      DHeroSWRingR.Visible := False;
      DHeroSWDress.Visible := False;
      DHeroSWNecklace.Visible := False;
      DHeroSWLight.Visible := False;
      DHeroSWArmRingL.Visible := False;
      DHeroSWRingL.Visible := False;
      DHeroSWCharm.Visible := False;
      DHeroSWBoots.Visible := False;
      DHeroSWBelt.Visible := False;
      DHeroSWBujuk.Visible := False;

      DHeroStMag1.Visible := False; DHeroStMag2.Visible := False;
      DHeroStMag3.Visible := False; DHeroStMag4.Visible := False;
      DHeroStMag5.Visible := False; DHeroStMag6.Visible := False;
      DHeroStPageUp.Visible := False;
      DHeroStPageDown.Visible := False;
    end;
  end;
end;

procedure TFrmDlg.DPrevStateClick(Sender: TObject; X, Y: Integer);
begin
  Dec(StatePage);
  if StatePage < 0 then
    StatePage := MAXSTATEPAGE - 1;
  PageChanged;
end;

procedure TFrmDlg.DNextStateClick(Sender: TObject; X, Y: Integer);
begin
  Inc(StatePage);
  if StatePage > MAXSTATEPAGE - 1 then
    StatePage := 0;
  PageChanged;
end;

procedure TFrmDlg.DSWWeaponClick(Sender: TObject; X, Y: Integer);
var
  where, n, sel: Integer;
  flag, movcancel: Boolean;
begin
  if g_MySelf = nil then Exit;
  if StatePage <> 0 then Exit;
  //if (g_btItemMoving = 3) or (g_btItemMoving = 6) then Exit;
  if (g_MovingItem.Owner = DDealDlg) or (g_MovingItem.Owner = DHeroStateWin) then Exit;
  if g_boItemMoving then begin
    flag := False;
    movcancel := False;
    if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then Exit;
    if (g_MovingItem.Item.s.Name = '') or (g_WaitingUseItem.Item.s.Name <> '') then Exit;
    where := GetTakeOnPosition(g_MovingItem.Item.s.StdMode);
    if g_MovingItem.Index >= 0 then begin
      case where of
        U_DRESS: begin
            if Sender = DSWDress then begin
              if g_MySelf.m_btSex = 0 then
                if g_MovingItem.Item.s.StdMode <> 10 then
                  Exit;
              if g_MySelf.m_btSex = 1 then
                if g_MovingItem.Item.s.StdMode <> 11 then
                  Exit;
              flag := True;
            end;
          end;
        U_WEAPON: begin
            if Sender = DSWWeapon then begin
              flag := True;
            end;
          end;
        U_NECKLACE: begin
            if Sender = DSWNecklace then
              flag := True;
          end;
        U_RIGHTHAND: begin
            if Sender = DSWLight then
              flag := True;
          end;
        U_HELMET: begin
            if Sender = DSWHelmet then
              flag := True;
          end;
        U_RINGR, U_RINGL: begin
            if Sender = DSWRingL then begin
              where := U_RINGL;
              flag := True;
            end;
            if Sender = DSWRingR then begin
              where := U_RINGR;
              flag := True;
            end;
          end;
        U_ARMRINGR: begin
            if Sender = DSWArmRingL then begin
              where := U_ARMRINGL;
              flag := True;
            end;
            if Sender = DSWArmRingR then begin
              where := U_ARMRINGR;
              flag := True;
            end;
          end;
        U_ARMRINGL: begin //25
            if Sender = DSWArmRingL then begin
              where := U_ARMRINGL;
              flag := True;
            end;
          end;
        U_BUJUK: begin
            if Sender = DSWBujuk then begin
              where := U_BUJUK;
              flag := True;
            end;
            if Sender = DSWArmRingL then begin
              where := U_ARMRINGL;
              flag := True;
            end;
          end;
        U_BELT: begin
            if Sender = DSWBelt then begin
              where := U_BELT;
              flag := True;
            end;
          end;
        U_BOOTS: begin
            if Sender = DSWBoots then begin
              where := U_BOOTS;
              flag := True;
            end;
          end;
        U_CHARM: begin
            if Sender = DSWCharm then begin
              where := U_CHARM;
              flag := True;
            end;
          end;
      end;
    end else begin
      if (g_MovingItem.Owner = DStateWin) then begin
        n := -(g_MovingItem.Index + 1);
        if n in [0..12] then begin
          ItemClickSound(g_MovingItem.Item.s);
          g_UseItems[n] := g_MovingItem.Item;
          g_MovingItem.Item.s.Name := '';
          g_boItemMoving := False;
        end;
      end;
    end;
    if flag then begin
      if (g_MovingItem.Owner = DItemBag) or (g_MovingItem.Owner = DHeroItemBag) or (g_MovingItem.Owner = DUpgrade) then begin
        ItemClickSound(g_MovingItem.Item.s);
        g_WaitingUseItem := g_MovingItem;
        g_WaitingUseItem.Index := where;
        if (g_MovingItem.Owner = DItemBag) or (g_MovingItem.Owner = DUpgrade) then begin
          frmMain.SendTakeOnItem(where, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
        end else
          if (g_MovingItem.Owner = DHeroItemBag) then begin
          frmMain.SendTakeOnItemFromHeroBag(where, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
        end;
        g_MovingItem.Item.s.Name := '';
        g_boItemMoving := False;
      end;
    end;
  end else begin
    ClearMoveRect();
    flag := False;
    if (g_MovingItem.Item.s.Name <> '') or (g_WaitingUseItem.Item.s.Name <> '') then Exit;
    sel := -1;
    if Sender = DSWDress then sel := U_DRESS;
    if Sender = DSWWeapon then sel := U_WEAPON;
    if Sender = DSWHelmet then sel := U_HELMET;
    if Sender = DSWNecklace then sel := U_NECKLACE;
    if Sender = DSWLight then sel := U_RIGHTHAND;
    if Sender = DSWRingL then sel := U_RINGL;
    if Sender = DSWRingR then sel := U_RINGR;
    if Sender = DSWArmRingL then sel := U_ARMRINGL;
    if Sender = DSWArmRingR then sel := U_ARMRINGR;

    if Sender = DSWBujuk then sel := U_BUJUK;
    if Sender = DSWBelt then sel := U_BELT;
    if Sender = DSWBoots then sel := U_BOOTS;
    if Sender = DSWCharm then sel := U_CHARM;

    if sel >= 0 then begin
      if g_UseItems[sel].s.Name <> '' then begin
        ItemClickSound(g_UseItems[sel].s);
        g_MovingItem.Index := -(sel + 1);
        g_MovingItem.Item := g_UseItems[sel];
        g_UseItems[sel].s.Name := '';
        g_boItemMoving := True;
        g_MovingItem.Owner := DStateWin;
      end;
    end;
  end;
end;

procedure TFrmDlg.DSWWeaponMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
  sel: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;
  hcolor: TColor;
  Butt: TDButton;
begin
  if StatePage <> 0 then Exit;
  DScreen.ClearHint;
  sel := -1;
  Butt := TDButton(Sender);
  if Sender = DSWDress then sel := U_DRESS;
  if Sender = DSWWeapon then sel := U_WEAPON;
  if Sender = DSWHelmet then sel := U_HELMET;
  if Sender = DSWNecklace then sel := U_NECKLACE;
  if Sender = DSWLight then sel := U_RIGHTHAND;
  if Sender = DSWRingL then sel := U_RINGL;
  if Sender = DSWRingR then sel := U_RINGR;
  if Sender = DSWArmRingL then sel := U_ARMRINGL;
  if Sender = DSWArmRingR then sel := U_ARMRINGR;
  {
  if Sender = DSWBujuk then sel := U_RINGL;
  if Sender = DSWBelt then sel := U_RINGR;
  if Sender = DSWBoots then sel := U_ARMRINGL;
  if Sender = DSWCharm then sel := U_ARMRINGR;
  }

  if Sender = DSWBujuk then sel := U_BUJUK;
  if Sender = DSWBelt then sel := U_BELT;
  if Sender = DSWBoots then sel := U_BOOTS;
  if Sender = DSWCharm then sel := U_CHARM;

  g_MoveRect := TDButton(Sender).ClientRect;
  g_MoveRect.Right := TDButton(Sender).ClientRect.Right + 2;
  if sel >= 0 then begin
    g_MouseStateItem := g_UseItems[sel];
      //原为注释掉 显示人物身上带的物品信息
    if (g_ServerConfig.btShowClientItemStyle = 0) then begin
      g_MouseItem := g_UseItems[sel];

      GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
      if HintList.Count > 0 then begin
        with Sender as TDButton do
          DScreen.ShowHint(SurfaceX(Left - 30),
            SurfaceY(Top + 50),
            HintList, False);
      end;
      g_MouseItem.s.Name := '';
    end;
  end else ClearMoveRect();
end;

procedure TFrmDlg.DStateWinMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  DScreen.ClearHint;
  HintList.Clear;
  g_MouseStateItem.s.Name := '';
  g_MouseHeroItem.s.Name := '';
end;

procedure TFrmDlg.DStMag1DirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  Idx, icon: Integer;
  d: TTexture;
  pm: PTClientMagic;
begin
  //DScreen.ClearHint;
  with Sender as TDButton do begin
    Idx := _MAX(tag + MagicPage * 6, 0);
    if Idx < g_MagicList.Count then begin
      pm := PTClientMagic(g_MagicList[Idx]);
      icon := pm.Def.btEffect * 2;
      if pm.Def.btEffect = 50 then icon := 84;
      //if pm.Def.btEffect = 51 then icon := 94;

      if pm.Def.btEffect = 70 then icon := 1 * 2;
      if pm.Def.btEffect = 71 then icon := 3 * 2;
      if pm.Def.btEffect = 72 then icon := 10 * 2;

      if pm.Level >= 4 then begin
        case pm.Def.wMagicId of
          13: icon := 140;
          26: icon := 142;
          31: icon := 104;
          45: icon := 144;
        end;
      end;

      if icon >= 0 then begin
        if not Downed then begin
          d := g_WMagIconImages.Images[icon];
          if d <> nil then
            dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        end else begin
          d := g_WMagIconImages.Images[icon + 1];
          if d <> nil then
            dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DStMag1Click(Sender: TObject; X, Y: Integer);
var
  I, Idx: Integer;
  selkey: Word;
  keych: Char;
  pm: PTClientMagic;
begin
  if StatePage = 3 then begin
    Idx := TDButton(Sender).tag + magtop;
    if (Idx >= 0) and (Idx < g_MagicList.Count) then begin
      pm := PTClientMagic(g_MagicList[Idx]);
      selkey := Word(pm.Key);
      SetMagicKeyDlg(pm.Def.btEffect * 2, pm.Def.sMagicName, selkey);
      keych := Char(selkey);
      for I := 0 to g_MagicList.Count - 1 do begin
        pm := PTClientMagic(g_MagicList[I]);
        if pm.Key = keych then begin
          pm.Key := #0;
          frmMain.SendMagicKeyChange(pm.Def.wMagicId, #0);
        end;
      end;
      pm := PTClientMagic(g_MagicList[Idx]);
      //if pm.Def.EffectType <> 0 then begin //八过篮 虐汲沥阑 给窃.
      pm.Key := keych;
      frmMain.SendMagicKeyChange(pm.Def.wMagicId, keych);
      //end;
    end;
  end;
end;

procedure TFrmDlg.DStPageUpClick(Sender: TObject; X, Y: Integer);
begin
  if StatePage = 2 then begin
    if Sender = DStPageUp then begin
      AbilPage := 0;
    end else begin
      AbilPage := 1;
    end;
  end else begin
    if Sender = DStPageUp then begin
      if MagicPage > 0 then
        Dec(MagicPage);
    end else begin
      if MagicPage < (g_MagicList.Count + 5) div 6 - 1 then
        Inc(MagicPage);
    end;
  end;
end;
{------------------------------------------------------------------------}

{------------------------------------------------------------------------}


procedure TFrmDlg.DBottomDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  rc: TRect;
  btop, sx, sY, I, FColor, BColor: Integer;
  r: Real;
  Str: string;
begin
  if g_ConfigClient.btMainInterface in [0, 2] then begin
//{$IF SWH = SWH800}
    d := g_WMain3Images.Images[BOTTOMBOARD800];
//{$ELSEIF SWH = SWH1024}
//    d := g_WMain3Images.Images[BOTTOMBOARD800];
//{$IFEND}
    btop := 0;
    if d <> nil then begin
      dsurface.Draw(DBottom.Left, DBottom.Top, d.ClientRect, d, True);

      btop := SCREENHEIGHT - d.Height;
    end;
   { if d <> nil then begin
      with d.ClientRect do
        rc := Rect(Left, Top, Right, Top + 120);
      btop := SCREENHEIGHT - d.Height;

      dsurface.Draw(0,
        btop,
        rc,
        d, True);

      with d.ClientRect do
        rc := Rect(Left, Top + 120, Right, Bottom);
      dsurface.Draw(0,
        btop + 120,
        rc,
        d, False);
    end;  }

    d := nil;
    case g_nDayBright of
      0: d := g_WMainImages.Images[15]; //早上
      1: d := g_WMainImages.Images[12]; //白天
      2: d := g_WMainImages.Images[13]; //傍晚
      3: d := g_WMainImages.Images[14]; //晚上
    end;
    if d <> nil then
      dsurface.Draw(DBottom.Left + DBottom.Width div 2 + (DBottom.Width div 2 - (400 - 348)) {748}, 79 + DBottom.Top, d.ClientRect, d, False);

    if g_MyHero <> nil then begin
      if g_HeroUseItems[U_BUJUK].s.Name <> '' then begin
        if (g_HeroUseItems[U_BUJUK].s.StdMode = 25) and (g_HeroUseItems[U_BUJUK].s.Shape = 9) then begin
          DFirDragon.Visible := True;
        end else DFirDragon.Visible := False;
      end else DFirDragon.Visible := False;
    end else DFirDragon.Visible := False;

    if g_MySelf <> nil then begin
    //显示HP及MP 图形
      if (g_MySelf.m_Abil.MaxHP > 0) and (g_MySelf.m_Abil.MaxMP > 0) then begin
        if (g_MySelf.m_btJob = 0) and (g_MySelf.m_Abil.Level < 28) then begin //武士
          d := g_WMainImages.Images[5];
          if d <> nil then begin
            rc := d.ClientRect;
            rc.Right := d.ClientRect.Right - 2;
            dsurface.Draw(DBottom.Left + 38, btop + 90, rc, d, False);
          end;
          d := g_WMainImages.Images[6];
          if d <> nil then begin
            rc := d.ClientRect;
            rc.Right := d.ClientRect.Right - 2;
            rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxHP * (g_MySelf.m_Abil.MaxHP - g_MySelf.m_Abil.HP));
            dsurface.Draw(DBottom.Left + 38, btop + 90 + rc.Top, rc, d, False);
          end;
        end else begin
          d := g_WMainImages.Images[4];
          if d <> nil then begin
          //HP 图形
            rc := d.ClientRect;
            rc.Right := d.ClientRect.Right div 2 - 1;
            rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxHP * (g_MySelf.m_Abil.MaxHP - g_MySelf.m_Abil.HP));
            dsurface.Draw(DBottom.Left + 40, btop + 91 + rc.Top, rc, d, False);
          //MP 图形
            rc := d.ClientRect;
            rc.Left := d.ClientRect.Right div 2 + 1;
            rc.Right := d.ClientRect.Right - 1;
            rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxMP * (g_MySelf.m_Abil.MaxMP - g_MySelf.m_Abil.MP));
            dsurface.Draw(DBottom.Left + 40 + rc.Left, btop + 91 + rc.Top, rc, d, False);
          end;
        end;
      end;

    //等级
      with dsurface do begin
        PomiTextOut(dsurface, DBottom.Left + 660, SCREENHEIGHT - 104, IntToStr(g_MySelf.m_Abil.Level));
      end;
    //
      if (g_MySelf.m_Abil.MaxExp > 0) and (g_MySelf.m_Abil.MaxWeight > 0) then begin
        d := g_WMainImages.Images[7];
        if d <> nil then begin
        //经验条
          rc := d.ClientRect;
          if g_MySelf.m_Abil.Exp > 0 then r := g_MySelf.m_Abil.MaxExp / g_MySelf.m_Abil.Exp
          else r := 0;
          if r > 0 then rc.Right := Round(rc.Right / r)
          else rc.Right := 0;
        {
        dsurface.Draw (666, 527, rc, d, FALSE);
        PomiTextOut (dsurface, 660, 528, IntToStr(Myself.Abil.Exp));
        }
          dsurface.Draw(DBottom.Left + 666, SCREENHEIGHT - 73, rc, d, False);
        //PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 260)){660}, SCREENHEIGHT - 72, FloatToStrFixFmt (100 * g_MySelf.m_Abil.Exp / g_MySelf.m_Abil.MaxExp, 3, 2) + '%');
        //PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 260)){660}, SCREENHEIGHT - 57, IntToStr(g_MySelf.m_Abil.MaxExp));

        //背包重量条
          rc := d.ClientRect;
          if g_MySelf.m_Abil.Weight > 0 then r := g_MySelf.m_Abil.MaxWeight / g_MySelf.m_Abil.Weight
          else r := 0;
          if r > 0 then rc.Right := Round(rc.Right / r)
          else rc.Right := 0;
        {
        dsurface.Draw (666, 560, rc, d, FALSE);
        PomiTextOut (dsurface, 660, 561, IntToStr(Myself.Abil.Weight));
        }
          dsurface.Draw(DBottom.Left + 666, SCREENHEIGHT - 40, rc, d, False);
        //PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 260)){660}, SCREENHEIGHT - 39, IntToStr(g_MySelf.m_Abil.Weight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWeight));
        //PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 260)){660}, SCREENHEIGHT - 24, IntToStr(g_MySelf.m_Abil.MaxWeight));
        end;
      end;
    //PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 355)){755}, SCREENHEIGHT - 15, IntToStr(g_nMyHungryState));
    //饥饿程度
      if g_nMyHungryState in [1..4] then begin
        d := g_WMainImages.Images[16 + g_nMyHungryState - 1];
        if d <> nil then begin
          dsurface.Draw(DBottom.Left + 754, 553, d.ClientRect, d, True);
        end;
      end;
    end;

  end else begin
    d := g_WCqFirImages.Images[65];
    if d <> nil then begin
      dsurface.Draw(DBottom.Left, DBottom.Top, d.ClientRect, d, False);
      btop := SCREENHEIGHT - d.Height;
    end;

    {if d <> nil then begin
      with d.ClientRect do
        rc := Rect(Left, Top, Right, Top + 120);
      btop := SCREENHEIGHT - d.Height;
      dsurface.Draw(0,
        btop,
        rc,
        d, True);
      with d.ClientRect do
        rc := Rect(Left, Top + 120, Right, Bottom);
      dsurface.Draw(0,
        btop + 120,
        rc,
        d, False);
    end;}

    d := nil;
    {case g_nDayBright of
      0: d := g_WMainImages.Images[15]; //早上
      1: d := g_WMainImages.Images[12]; //白天
      2: d := g_WMainImages.Images[13]; //傍晚
      3: d := g_WMainImages.Images[14]; //晚上
    end;
    if d <> nil then
      dsurface.Draw(SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 348)), 79 + DBottom.Top, d.ClientRect, d, False);

    if g_MyHero <> nil then begin
      if g_HeroUseItems[U_BUJUK].s.Name <> '' then begin
        if (g_HeroUseItems[U_BUJUK].s.StdMode = 25) and (g_HeroUseItems[U_BUJUK].s.Shape = 9) then begin
          DFirDragon.Visible := True;
        end else DFirDragon.Visible := False;
      end else DFirDragon.Visible := False;
    end else DFirDragon.Visible := False;
    }


    if g_MySelf <> nil then begin
    //显示HP及MP 图形
      if (g_MySelf.m_Abil.MaxHP > 0) and (g_MySelf.m_Abil.MaxMP > 0) then begin
        if (g_MySelf.m_btJob = 0) and (g_MySelf.m_Abil.Level < 28) then begin //武士

          d := g_WCqFirImages.Images[74];
          if d <> nil then begin
            rc := d.ClientRect;
            rc.Right := Round(rc.Right / g_MySelf.m_Abil.MaxHP * g_MySelf.m_Abil.HP);
            dsurface.Draw(DBottom.Left + 3, btop, rc, d, False);
          end;
        end else begin
          d := g_WCqFirImages.Images[74];
          if d <> nil then begin
          //HP 图形
            rc := d.ClientRect;
            rc.Right := Round(rc.Right / g_MySelf.m_Abil.MaxHP * g_MySelf.m_Abil.HP);
            dsurface.Draw(DBottom.Left + 3, btop, rc, d, False);
          end;
          d := g_WCqFirImages.Images[73];
          if d <> nil then begin
          //MP 图形
            rc := d.ClientRect;
            rc.Right := Round(rc.Right / g_MySelf.m_Abil.MaxMP * g_MySelf.m_Abil.MP);
            dsurface.Draw(DBottom.Left + 3, btop + 3 + rc.Bottom, rc, d, False);
          end;
        end;
      end;
    //
      if (g_MySelf.m_Abil.MaxExp > 0) { and (g_MySelf.m_Abil.MaxWeight > 0)} then begin
        d := g_WCqFirImages.Images[75];
        if d <> nil then begin
        //经验条
          rc := d.ClientRect;
          {
          if g_MySelf.m_Abil.Exp > 0 then r := g_MySelf.m_Abil.MaxExp / g_MySelf.m_Abil.Exp
          else r := 0;
          if r > 0 then rc.Right := Round(rc.Right / r)
          else rc.Right := 0;
          }
          rc.Right := Round(rc.Right / g_MySelf.m_Abil.MaxExp * g_MySelf.m_Abil.Exp);


          //dsurface.Draw(DBottom.Left + 2, btop + 1, rc, d, False);
          dsurface.Draw(DBottom.Left + 2, SCREENHEIGHT - d.Height - 3, rc, d, False);
         {
        //背包重量条
          rc := d.ClientRect;
          if g_MySelf.m_Abil.Weight > 0 then r := g_MySelf.m_Abil.MaxWeight / g_MySelf.m_Abil.Weight
          else r := 0;
          if r > 0 then rc.Right := Round(rc.Right / r)
          else rc.Right := 0;
          dsurface.Draw(SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 266)), SCREENHEIGHT - 40, rc, d, False);
          }
        end;
      end;
    //等级
      //PomiTextOut(dsurface, 48, btop + 32, IntToStr(g_MySelf.m_Abil.Level));
      with dsurface do begin
        BoldTextOut(DBottom.Left + 174, btop + 3, IntToStr(g_MySelf.m_Abil.Level));
        BoldTextOut(DBottom.Left + 174, btop + 21, GetJobName(g_MySelf.m_btJob));

        if g_boShowWhiteHint then begin

          if g_MySelf.m_nGameGold > 10 then begin
            BoldTextOut(DBottom.Left + 720, SCREENHEIGHT - DBottom.Height + 4, IntToStr(g_MySelf.m_nGameGold));
          end else begin
            BoldTextOut(DBottom.Left + 720, SCREENHEIGHT - DBottom.Height + 4, IntToStr(g_MySelf.m_nGameGold), clRed);
          end;
          if g_MySelf.m_nGamePoint > 10 then begin
            BoldTextOut(DBottom.Left + 720, SCREENHEIGHT - DBottom.Height + 21, IntToStr(g_MySelf.m_nGamePoint));
          end else begin
            BoldTextOut(DBottom.Left + 720, SCREENHEIGHT - DBottom.Height + 21, IntToStr(g_MySelf.m_nGamePoint), clRed);
          end;

          //显示血
          Str := Format('%d/%d', [g_MySelf.m_Abil.HP, g_MySelf.m_Abil.MaxHP]);
          BoldTextOut(DBottom.Left + 2 + (140 - TextWidth(Str)) div 2, SCREENHEIGHT - DBottom.Height + 3, Str);

          //显示魔
          Str := Format('%d/%d', [g_MySelf.m_Abil.MP, g_MySelf.m_Abil.MaxMP]);
          BoldTextOut(DBottom.Left + 2 + (140 - TextWidth(Str)) div 2, SCREENHEIGHT - DBottom.Height + 21, Str);
        end;
      end;
    //PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 355)){755}, SCREENHEIGHT - 15, IntToStr(g_nMyHungryState));
    //饥饿程度
    end;
  end;
end;

{--------------------------------------------------------------}

procedure TFrmDlg.DBottomInRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
var
  d: TTexture;
begin
  if g_ConfigClient.btMainInterface in [0, 2] then begin
//{$IF SWH = SWH800}
    d := g_WMain3Images.Images[BOTTOMBOARD800];
//{$ELSEIF SWH = SWH1024}
//    d := g_WMain3Images.Images[BOTTOMBOARD800];
//{$IFEND}
  end else begin
    d := g_WCqFirImages.Images[65];
  end;
  if d <> nil then begin
    if d.Pixels[X, Y] > 0 then IsRealArea := True
    else IsRealArea := False;
  end;
end;

procedure TFrmDlg.DMyStateDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TDButton;
  dd: TTexture;
begin
  if Sender is TDButton then begin
    d := TDButton(Sender);
    if d.Downed then begin
      dd := nil;
      if d.WLib <> nil then
        dd := d.WLib.Images[d.FaceIndex];
      if dd <> nil then
        dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, True);
    end;
  end;
end;

procedure TFrmDlg.DBotGroupDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TDButton;
  dd: TTexture;
begin
  if Sender is TDButton then begin
    d := TDButton(Sender);
    if d <> nil then begin
      if not d.Downed then begin
        dd := nil;
        if d.WLib <> nil then
          dd := d.WLib.Images[d.FaceIndex];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, True);
      end else begin
        dd := nil;
        if d.WLib <> nil then
          dd := d.WLib.Images[d.FaceIndex + 1];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DBotPlusAbilDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TDButton;
  dd: TTexture;
begin
  if Sender is TDButton then begin
    dd := nil;
    d := TDButton(Sender);
    if g_ConfigClient.btMainInterface in [0, 2] then begin

      if g_nBonusPoint > 0 then begin
        case BlinkCount of
          0: dd := d.WLib.Images[218];
          1: dd := d.WLib.Images[219];
          2: dd := d.WLib.Images[220];
          3: dd := d.WLib.Images[221];
        end;
      end else begin
        dd := d.WLib.Images[222];
      end;
      if dd <> nil then
        dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, True);

      if GetTickCount - BlinkTime >= 40 then begin
        BlinkTime := GetTickCount;
        Inc(BlinkCount);
        if BlinkCount >= 3 then BlinkCount := 0;
      end;
    end else begin

      if not d.Downed then begin
        if ((BlinkCount mod 2 = 0) or DAdjustAbility.Visible) and (d.WLib <> nil) then dd := d.WLib.Images[150]
        else if (d.WLib <> nil) then dd := d.WLib.Images[151];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, True);
      end else begin
        dd := nil;
        if d.WLib <> nil then
          dd := d.WLib.Images[d.FaceIndex + 1];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, True);
      end;

      if GetTickCount - BlinkTime >= 500 then begin
        BlinkTime := GetTickCount;
        Inc(BlinkCount);
        if BlinkCount >= 10 then BlinkCount := 0;
      end;
    end;
  end;
end;

procedure TFrmDlg.DMyStateClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DMyState then begin
    StatePage := 0;
    OpenMyStatus;
  end;
  if Sender = DMyBag then OpenItemBag;
  if Sender = DMyMagic then begin
    StatePage := 3;
    OpenMyStatus;
  end;
  if Sender = DVoice then DSoundClick;
end;

procedure TFrmDlg.DSoundClick();
begin
  g_boSound := not g_boSound;
  if g_boSound then begin
    DScreen.AddChatBoardString('[Sound Enabled]', clWhite, clblack);
  end else begin
    DScreen.AddChatBoardString('[Sound Disabled]', clWhite, clblack);
    if Assigned(g_PlugInfo.MediaPlayer.StopPlay) then begin
      g_PlugInfo.MediaPlayer.StopPlay(nil);
    end;
  end;
end;
{------------------------------------------------------------------------}

{------------------------------------------------------------------------}

procedure TFrmDlg.DBelt1DirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  Idx: Integer;
  d: TTexture;
begin
  with Sender as TDButton do begin
    Idx := tag;
    if Idx in [0..5] then begin
      if g_ItemArr[Idx].s.Name <> '' then begin
        d := g_WBagItemImages.Images[g_ItemArr[Idx].s.looks];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left + (Width - d.Width) div 2), SurfaceY(Top + (Height - d.Height) div 2), d.ClientRect, d, True);
      end;
    end;
    if g_ConfigClient.btMainInterface in [0, 2] then
      PomiTextOut(dsurface, SurfaceX(Left + 13), SurfaceY(Top + 19), IntToStr(Idx + 1));
  end;
end;

procedure TFrmDlg.DBelt1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  Idx: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;
begin
  DScreen.ClearHint;
  Idx := TDButton(Sender).tag;
  if Idx in [0..5] then begin
    if g_ItemArr[Idx].s.Name <> '' then begin
      g_MouseItem := g_ItemArr[Idx];
      //原为注释掉 显示人物身上带的物品信息
      //
      if (g_ServerConfig.btShowClientItemStyle = 0) or (not DItemBag.Visible) then begin
        GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
        if HintList.Count > 0 then begin
         //DScreen.AddChatBoardString('TFrmDlg.DBelt1MouseMove', clWhite, clPurple);
          with Sender as TDButton do
            DScreen.ShowHint(SurfaceX(Left - 30),
              SurfaceY(Top - HintList.Count * 14) - 20,
              HintList, False);
        end;
      end;
      //g_MouseItem.S.Name := '';
    end;
    g_MoveRect := TDButton(Sender).ClientRect;
    g_MoveRect.Right := g_MoveRect.Right + 2;
  end else ClearMoveRect();
end;

procedure TFrmDlg.DBelt1Click(Sender: TObject; X, Y: Integer);
var
  Idx: Integer;
  temp: TClientItem;
begin
  Idx := TDButton(Sender).tag;
  if Idx in [0..5] then begin
    if not g_boItemMoving then begin
      ClearMoveRect();
      if g_ItemArr[Idx].s.Name <> '' then begin
        ItemClickSound(g_ItemArr[Idx].s);
        g_boItemMoving := True;
        g_MovingItem.Index := Idx;
        g_MovingItem.Item := g_ItemArr[Idx];
        g_ItemArr[Idx].s.Name := '';
        g_MovingItem.Owner := DItemBag;
      end;
    end else begin
      if (g_MovingItem.Owner = DStateWin) or (g_MovingItem.Owner = DHeroStateWin) or (g_MovingItem.Owner = DHeroItemBag) or (g_MovingItem.Owner = DDealDlg) or (g_MovingItem.Owner = DUpgrade) then Exit;
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then Exit;
      if g_MovingItem.Item.s.StdMode <= 3 then begin //器记,澜侥,胶农费
        //ItemClickSound (MovingItem.Item.S.StdMode);
        if g_ItemArr[Idx].s.Name <> '' then begin
          temp := g_ItemArr[Idx];
          g_ItemArr[Idx] := g_MovingItem.Item;
          g_MovingItem.Index := Idx;
          g_MovingItem.Item := temp
        end else begin
          g_ItemArr[Idx] := g_MovingItem.Item;
          g_MovingItem.Item.s.Name := '';
          g_boItemMoving := False;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DBelt1DblClick(Sender: TObject);
var
  Idx: Integer;
begin
  Idx := TDButton(Sender).tag;
  if Idx in [0..5] then begin
    if g_ItemArr[Idx].s.Name <> '' then begin
      if (g_ItemArr[Idx].s.StdMode <= 4) or (g_ItemArr[Idx].s.StdMode = 31) then begin //荤侩且 荐 乐绰 酒捞袍
        frmMain.EatItem(Idx);
      end;
    end else begin
      if g_boItemMoving and (g_MovingItem.Index = Idx) and
        (g_MovingItem.Item.s.StdMode <= 4) or (g_MovingItem.Item.s.StdMode = 31)
        then begin
        frmMain.EatItem(-1);
      end;
    end;
  end;
end;

procedure TFrmDlg.GetMouseItemInfo(Actor: TActor; MouseItem: pTClientItem; var iname, line1, line2, line3: string; var useable: Boolean);
  function GetDuraStr(Dura, maxdura: Integer): string;
  begin
    if not BoNoDisplayMaxDura then
      Result := IntToStr(Round(Dura / 1000)) + '/' + IntToStr(Round(maxdura / 1000))
    else
      Result := IntToStr(Round(Dura / 1000));
  end;
  function GetDura100Str(Dura, maxdura: Integer): string;
  begin
    if not BoNoDisplayMaxDura then
      Result := IntToStr(Round(Dura / 100)) + '/' + IntToStr(Round(maxdura / 100))
    else
      Result := IntToStr(Round(Dura / 100));
  end;
  function GetMoveXY(Value: TValue): string;
  var
    TempRecord: TTempRecord;
  begin
    Move(Value, TempRecord, SizeOf(TTempRecord));
    Result := IntToStr(TempRecord.nX) + ':' + IntToStr(TempRecord.nY);
  end;
  procedure GetAtomStr(Value: TValue);
  begin
    if (not g_ServerConfig.boAllowItemAddValue) or (g_ServerConfig.btShowClientItemStyle <> 0) then Exit;
    if Value[4] > 0 then begin
      HintList.AddObject('Attack Element: ' + GetAtomTypeStr(Value[1]) + '+' + IntToStr(Value[4]), TObject(GetRGB(222)));
    end;
    if Value[5] > 0 then begin
      HintList.AddObject('Magic Element: ' + GetAtomTypeStr(Value[2]) + '+' + IntToStr(Value[5]), TObject(GetRGB(222)));
    end;
    if Value[6] > 0 then begin
      HintList.AddObject('Weak Element: ' + GetAtomTypeStr(Value[3]) + '-' + IntToStr(Value[6]), TObject(GetRGB(254)));
    end;
  end;

  function GetStarsStr(nLevel: Byte): string;
  var
    I: Integer;
  begin
    Result := '';
    if nLevel <= 6 then begin
      for I := 0 to nLevel - 1 do begin
        Result := Result + '★';
      end;
    end;
  end;

  function GetStarsColor(nLevel: Byte): TColor;
  begin
    case nLevel of
      1: Result := clWhite;
      2: Result := clAqua;
      3: Result := clyellow;
      4: Result := clLime;
      5: Result := clPurple;
      6: Result := clFuchsia;
    end;
   { case nLevel of
      1: Result := clWhite;
      2: Result := clAqua;
      3: Result := clAqua;
      4: Result := clyellow;
      5: Result := clyellow;
      6: Result := clLime;
      7: Result := clLime;
      8: Result := clTeal;
      9: Result := clFuchsia;
      10: Result := clFuchsia;
    end; }
  end;
var
  sWgt, sTemp, sItemDesc: string;
  I, nLine: Integer;
  dwExp, dwMaxExp: LongWord;
begin
  HintList.Clear;
  iname := ''; line1 := ''; line2 := ''; line3 := '';
  useable := True;
  if (Actor = nil) or (MouseItem.s.Name = '') then Exit;

  if MouseItem.s.Name <> '' then begin
    HintList.AddObject({'★' + } MouseItem.s.Name, {TObject(clyellow)} TObject(MouseItem.s.AddValue[13]));
    if (g_ServerConfig.btShowClientItemStyle = 0) then begin
      if g_ServerConfig.boAllowItemAddValue or g_ServerConfig.boAllowItemTime or g_ServerConfig.boAllowItemAddPoint then begin
        if MouseItem.s.AddValue[13] > 0 then begin
          sTemp := GetStarsStr(MouseItem.s.AddValue[13]);
          if sTemp <> '' then
            HintList.AddObject(sTemp, TObject(GetStarsColor(MouseItem.s.AddValue[13])));
        end;
      end;
    end;

    iname := MouseItem.s.Name + ' ';
    sWgt := 'Weight.';

    case MouseItem.s.StdMode of
      0: begin //药品
          if MouseItem.s.AC > 0 then begin
            HintList.AddObject('HPRecovery: +' + IntToStr(MouseItem.s.AC) + 'HP', TObject(clWhite));
            line1 := '+' + IntToStr(MouseItem.s.AC) + 'HP ';
          end;
          if MouseItem.s.MAC > 0 then begin
            HintList.AddObject('MPRecovery: +' + IntToStr(MouseItem.s.MAC) + 'MP', TObject(clWhite));
            line1 := line1 + '+' + IntToStr(MouseItem.s.MAC) + 'MP';
          end;
          HintList.AddObject('Weight: ' + IntToStr(MouseItem.s.Weight), TObject(clWhite));
          line1 := line1 + ' Weight.' + IntToStr(MouseItem.s.Weight);
        end;
      1: begin
          case MouseItem.s.Shape of
            1, 2, 5, 6, 7: begin
                HintList.AddObject('Left: ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax) + ' 小时', TObject(GetRGB(254)));
                line2 := 'Left ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax) + ' 小时';
              end;
            3, 4, 8, 9, 10: begin
                HintList.AddObject('Uses: ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax) + ' 小时', TObject(GetRGB(254)));
                line2 := 'Uses ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax) + ' 小时';
              end;
          end;
          line1 := line1 + 'Weight.' + IntToStr(MouseItem.s.Weight);
          HintList.AddObject('Weight: ' + IntToStr(MouseItem.s.Weight), TObject(clWhite));
        end;
      2: begin
          line1 := line1 + 'Weight. ' + IntToStr(MouseItem.s.Weight);
          case MouseItem.s.Shape of
            1: begin
                line2 := 'Dura ' + GetDura100Str(MouseItem.Dura, MouseItem.DuraMax) + ' 次';
                HintList.AddObject('Dura: ' + GetDura100Str(MouseItem.Dura, MouseItem.DuraMax) + ' 次', TObject(GetRGB(254)));
              end;
            2, 3: begin
                line2 := 'Dura ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax) + ' 次';
                HintList.AddObject('Dura: ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax) + ' 次', TObject(GetRGB(254)));
              end;
          end;
          HintList.AddObject('Weight: ' + IntToStr(MouseItem.s.Weight), TObject(clWhite));
        end;
      3: begin
          line1 := line1 + 'Weight.' + IntToStr(MouseItem.s.Weight);
          HintList.AddObject('Weight: ' + IntToStr(MouseItem.s.Weight), TObject(clWhite));
        end;
      8: begin
          line2 := '数量: ' + IntToStr(MouseItem.s.Need);
          HintList.AddObject('数量:' + IntToStr(MouseItem.s.Need), TObject(GetRGB(254)));
        end;
      4: begin
          HintList.AddObject('Weight: ' + IntToStr(MouseItem.s.Weight), TObject(clWhite));
          line1 := line1 + 'Weight. ' + IntToStr(MouseItem.s.Weight);
          line3 := 'Requires Level ' + IntToStr(MouseItem.s.DuraMax);
          useable := False;
          case MouseItem.s.Shape of
            0: begin
                line2 := 'Secret martial art skill of Warrior ';
                if (Actor.m_btJob = 0) and (Actor.m_Abil.Level >= MouseItem.s.DuraMax) then
                  useable := True;
              end;
            1: begin
                line2 := 'Spellbook of Wizard';
                if (Actor.m_btJob = 1) and (Actor.m_Abil.Level >= MouseItem.s.DuraMax) then
                  useable := True;
              end;
            2: begin
                line2 := 'Secret martial art skill of Taoist';
                if (Actor.m_btJob = 2) and (Actor.m_Abil.Level >= MouseItem.s.DuraMax) then
                  useable := True;
              end;
            99: begin
                line2 := 'General Skill';
                if Actor.m_Abil.Level >= MouseItem.s.DuraMax then
                  useable := True;
              end;
          end;
          if useable then begin
            HintList.AddObject('Requires Level: ' + IntToStr(MouseItem.s.DuraMax), TObject(clWhite));
            HintList.AddObject(line2, TObject(clWhite));
          end else begin
            HintList.AddObject('Requires Level: ' + IntToStr(MouseItem.s.DuraMax), TObject(clRed));
            HintList.AddObject(line2, TObject(clRed));
          end;
        end;
      5..6: {//武器} begin
          useable := False;
          if MouseItem.s.Reserved and $01 <> 0 then begin
            iname := '(*)' + iname;
            if HintList.Count > 0 then HintList.Delete(0);
            HintList.InsertObject(0, '★(*)' + MouseItem.s.Name, TObject(MouseItem.s.AddValue[13]));
          end;

          line1 := line1 + 'Weight.' + IntToStr(MouseItem.s.Weight) +
            ' Durability' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);

          HintList.AddObject('Durability: ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax), TObject(GetRGB(254)));
          HintList.AddObject('Weight: ' + IntToStr(MouseItem.s.Weight), TObject(clWhite));

          if MouseItem.s.DC > 0 then begin
            line2 := 'DC' + IntToStr(Loword(MouseItem.s.DC)) + '-' + IntToStr(Hiword(MouseItem.s.DC)) + ' ';
            HintList.AddObject('DC: ' + IntToStr(Loword(MouseItem.s.DC)) + '-' + IntToStr(Hiword(MouseItem.s.DC)), TObject(clWhite));
          end;

          if MouseItem.s.MC > 0 then begin
            line2 := line2 + 'MC' + IntToStr(Loword(MouseItem.s.MC)) + '-' + IntToStr(Hiword(MouseItem.s.MC)) + ' ';
            HintList.AddObject('MC: ' + IntToStr(Loword(MouseItem.s.MC)) + '-' + IntToStr(Hiword(MouseItem.s.MC)), TObject(clWhite));
          end;

          if MouseItem.s.SC > 0 then begin
            HintList.AddObject('SC: ' + IntToStr(Loword(MouseItem.s.SC)) + '-' + IntToStr(Hiword(MouseItem.s.SC)), TObject(clWhite));
            line2 := line2 + 'SC' + IntToStr(Loword(MouseItem.s.SC)) + '-' + IntToStr(Hiword(MouseItem.s.SC)) + ' ';
          end;

          if (MouseItem.s.Source <= -1) and (MouseItem.s.Source >= -50) then begin
            line2 := line2 + 'Holy +' + IntToStr(-MouseItem.s.Source) + ' ';
            HintList.AddObject('Holy: +' + IntToStr(-MouseItem.s.Source), TObject(GetRGB(254)));
          end;
          if (MouseItem.s.Source <= -51) and (MouseItem.s.Source >= -100) then begin
            line2 := line2 + 'Holy -' + IntToStr(-MouseItem.s.Source - 50) + ' ';
            HintList.AddObject('Holy: -' + IntToStr(-MouseItem.s.Source - 50), TObject(GetRGB(254)));
          end;

          if Hiword(MouseItem.s.AC) > 0 then begin
            line3 := line3 + 'Accuracy +' + IntToStr(Hiword(MouseItem.s.AC)) + ' ';
            HintList.AddObject('Accuracy: +' + IntToStr(Hiword(MouseItem.s.AC)), TObject(clWhite));
          end;

          if Hiword(MouseItem.s.MAC) > 0 then begin
            if Hiword(MouseItem.s.MAC) > 10 then begin
              line3 := line3 + 'Attack Speed +' + IntToStr(Hiword(MouseItem.s.MAC) - 10) + ' ';
              HintList.AddObject('Attack Speed: +' + IntToStr(Hiword(MouseItem.s.MAC) - 10), TObject(clWhite))
            end else begin
              line3 := line3 + 'Attack Speed -' + IntToStr(Hiword(MouseItem.s.MAC)) + ' ';
              HintList.AddObject('Attack Speed: -' + IntToStr(Hiword(MouseItem.s.MAC)), TObject(clWhite));
            end;
          end;

          if Loword(MouseItem.s.AC) > 0 then begin
            line3 := line3 + 'Luck+' + IntToStr(Loword(MouseItem.s.AC)) + ' ';
            HintList.AddObject('Luck: +' + IntToStr(Loword(MouseItem.s.AC)), TObject(GetRGB(254)));
          end;
          if Loword(MouseItem.s.MAC) > 0 then begin
            HintList.AddObject('Curse: +' + IntToStr(Loword(MouseItem.s.MAC)), TObject(GetRGB(254)));
            line3 := line3 + 'Curse+' + IntToStr(Loword(MouseItem.s.MAC)) + ' ';
          end;

          GetAtomStr(MouseItem.s.AddValue);

          case MouseItem.s.Need of
            0: begin
                if Actor.m_Abil.Level >= MouseItem.s.NeedLevel then
                  useable := True;
                sTemp := 'Requires Level: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            1: begin
                if Hiword(Actor.m_Abil.DC) >= MouseItem.s.NeedLevel then
                  useable := True;
                sTemp := 'Requires DC: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            2: begin
                if Hiword(Actor.m_Abil.MC) >= MouseItem.s.NeedLevel then
                  useable := True;
                sTemp := 'Requires MC: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            3: begin
                if Hiword(Actor.m_Abil.SC) >= MouseItem.s.NeedLevel then
                  useable := True;
                sTemp := 'Requires SC: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            4: begin
                useable := True;
                sTemp := '所需转生等级: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            40: begin
                useable := True;
                sTemp := '所需转生&等级: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            41: begin
                useable := True;
                sTemp := '所需转生&攻击力: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            42: begin
                useable := True;
                sTemp := '所需转生&魔法力: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            43: begin
                useable := True;
                sTemp := '所需转生&道术: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            44: begin
                useable := True;
                sTemp := '所需转生&声望点: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            5: begin
                useable := True;
                sTemp := '所需声望点: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            6: begin
                useable := True;
                sTemp := '行会成员专用';
                line3 := line3 + sTemp;
              end;
            60: begin
                useable := True;
                sTemp := '行会掌门专用';
                line3 := line3 + sTemp;
              end;
            7: begin
                useable := True;
                sTemp := '沙城成员专用';
                line3 := line3 + sTemp;
              end;
            70: begin
                useable := True;
                sTemp := '沙城城主专用';
                line3 := line3 + sTemp;
              end;
            8: begin
                useable := True;
                sTemp := '会员专用';
                line3 := line3 + sTemp;
              end;
            81: begin
                useable := True;
                sTemp := '会员类型: =' + IntToStr(Loword(MouseItem.s.NeedLevel)) + '会员等级: >=' + IntToStr(Hiword(MouseItem.s.NeedLevel));
                line3 := line3 + sTemp;
              end;
            82: begin
                useable := True;
                sTemp := '会员类型: >=' + IntToStr(Loword(MouseItem.s.NeedLevel)) + '会员等级: >=' + IntToStr(Hiword(MouseItem.s.NeedLevel));
                line3 := line3 + sTemp;
              end;
          end;
          if useable then begin
            HintList.AddObject(sTemp, TObject(clWhite));
          end else begin
            HintList.AddObject(sTemp, TObject(clRed));
          end;
        end;
      7: begin
          line1 := line1 + 'Weight.' + IntToStr(MouseItem.s.Weight);
          case MouseItem.s.Shape of
            0: begin
                line2 := 'Use ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax) + ' 次';
                HintList.AddObject('Use:' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax) + ' 次', TObject(GetRGB(254)));
              end;
            1: begin
                line2 := 'HP ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax) + ' 万';
                HintList.AddObject('HP:' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax) + ' 万', TObject(GetRGB(254)));
              end;
            2: begin
                line2 := 'MP ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax) + ' 万';
                HintList.AddObject('MP:' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax) + ' 万', TObject(GetRGB(254)));
              end;
            3: begin
                line2 := 'HPMP ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax) + ' 万';
                HintList.AddObject('HPMP:' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax) + ' 万', TObject(GetRGB(254)));
              end;
          end;
          HintList.AddObject('Weight: ' + IntToStr(MouseItem.s.Weight), TObject(clWhite));
        end;
      10, 11: {//男衣服, 女衣服} begin
          useable := False;
          line1 := line1 + 'Weight.' + IntToStr(MouseItem.s.Weight) +
            ' Durability' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);

          HintList.AddObject('Durability: ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax), TObject(GetRGB(254)));
          HintList.AddObject('Weight: ' + IntToStr(MouseItem.s.Weight), TObject(clWhite));

          if MouseItem.s.AC > 0 then begin
            HintList.AddObject('AC: ' + IntToStr(Loword(MouseItem.s.AC)) + '-' + IntToStr(Hiword(MouseItem.s.AC)), TObject(clWhite));
            line2 := 'AC' + IntToStr(Loword(MouseItem.s.AC)) + '-' + IntToStr(Hiword(MouseItem.s.AC)) + ' ';
          end;
          if MouseItem.s.MAC > 0 then begin
            HintList.AddObject('AMC: ' + IntToStr(Loword(MouseItem.s.MAC)) + '-' + IntToStr(Hiword(MouseItem.s.MAC)), TObject(clWhite));
            line2 := line2 + 'AMC' + IntToStr(Loword(MouseItem.s.MAC)) + '-' + IntToStr(Hiword(MouseItem.s.MAC)) + ' ';
          end;
          if MouseItem.s.DC > 0 then begin
            HintList.AddObject('DC: ' + IntToStr(Loword(MouseItem.s.DC)) + '-' + IntToStr(Hiword(MouseItem.s.DC)), TObject(clWhite));
            line2 := line2 + 'DC' + IntToStr(Loword(MouseItem.s.DC)) + '-' + IntToStr(Hiword(MouseItem.s.DC)) + ' ';
          end;
          if MouseItem.s.MC > 0 then begin
            HintList.AddObject('MC: ' + IntToStr(Loword(MouseItem.s.MC)) + '-' + IntToStr(Hiword(MouseItem.s.MC)), TObject(clWhite));
            line2 := line2 + 'MC' + IntToStr(Loword(MouseItem.s.MC)) + '-' + IntToStr(Hiword(MouseItem.s.MC)) + ' ';
          end;
          if MouseItem.s.SC > 0 then begin
            HintList.AddObject('SC: ' + IntToStr(Loword(MouseItem.s.SC)) + '-' + IntToStr(Hiword(MouseItem.s.SC)), TObject(clWhite));
            line2 := line2 + 'SC' + IntToStr(Loword(MouseItem.s.SC)) + '-' + IntToStr(Hiword(MouseItem.s.SC));
          end;
          if LoByte(MouseItem.s.Source) > 0 then begin
            HintList.AddObject('Luck: +' + IntToStr(LoByte(MouseItem.s.Source)), TObject(GetRGB(254)));
            line3 := line3 + 'Luck+' + IntToStr(LoByte(MouseItem.s.Source)) + ' ';
          end;
          if HiByte(MouseItem.s.Source) > 0 then begin
            HintList.AddObject('Curse: +' + IntToStr(HiByte(MouseItem.s.Source)), TObject(GetRGB(254)));
            line3 := line3 + 'Curse+' + IntToStr(HiByte(MouseItem.s.Source)) + ' ';
          end;
          GetAtomStr(MouseItem.s.AddValue);

          case MouseItem.s.Need of
            0: begin
                if Actor.m_Abil.Level >= MouseItem.s.NeedLevel then
                  useable := True;
                sTemp := 'Requires Level: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            1: begin
                if Hiword(Actor.m_Abil.DC) >= MouseItem.s.NeedLevel then
                  useable := True;
                sTemp := 'Requires DC: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            2: begin
                if Hiword(Actor.m_Abil.MC) >= MouseItem.s.NeedLevel then
                  useable := True;
                sTemp := 'Requires MC: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            3: begin
                if Hiword(Actor.m_Abil.SC) >= MouseItem.s.NeedLevel then
                  useable := True;
                sTemp := 'Requires SC: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            4: begin
                useable := True;
                sTemp := '所需转生等级: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            40: begin
                useable := True;
                sTemp := '所需转生&等级: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            41: begin
                useable := True;
                sTemp := '所需转生&攻击力: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            42: begin
                useable := True;
                sTemp := '所需转生&魔法力: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            43: begin
                useable := True;
                sTemp := '所需转生&道术: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            44: begin
                useable := True;
                sTemp := '所需转生&声望点: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            5: begin
                useable := True;
                sTemp := '所需声望点: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            6: begin
                useable := True;
                sTemp := '行会成员专用';
                line3 := line3 + sTemp;
              end;
            60: begin
                useable := True;
                sTemp := '行会掌门专用';
                line3 := line3 + sTemp;
              end;
            7: begin
                useable := True;
                sTemp := '沙城成员专用';
                line3 := line3 + sTemp;
              end;
            70: begin
                useable := True;
                sTemp := '沙城城主专用';
                line3 := line3 + sTemp;
              end;
            8: begin
                useable := True;
                sTemp := '会员专用';
                line3 := line3 + sTemp;
              end;
            81: begin
                useable := True;
                sTemp := '会员类型: =' + IntToStr(Loword(MouseItem.s.NeedLevel)) + '会员等级: >=' + IntToStr(Hiword(MouseItem.s.NeedLevel));
                line3 := line3 + sTemp;
              end;
            82: begin
                useable := True;
                sTemp := '会员类型: >=' + IntToStr(Loword(MouseItem.s.NeedLevel)) + '会员等级: >=' + IntToStr(Hiword(MouseItem.s.NeedLevel));
                line3 := line3 + sTemp;
              end;
          end;
          if useable then begin
            HintList.AddObject(sTemp, TObject(clWhite));
          end else begin
            HintList.AddObject(sTemp, TObject(clRed));
          end;
        end;
      15, //头盔,捧备
        19, 20, 21, //项链
        22, 23, //戒指
        24, 26, //手镯
        51,
        52, 62, //鞋
        53, 63,
        54, 64, 30: {//腰带} begin
          useable := False;
          line1 := line1 + 'Weight.' + IntToStr(MouseItem.s.Weight) +
            ' Durability' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);

          HintList.AddObject('Durability: ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax), TObject(GetRGB(254)));
          HintList.AddObject('Weight: ' + IntToStr(MouseItem.s.Weight), TObject(clWhite));

          case MouseItem.s.StdMode of
            19, 53: {//项链} begin
                if MouseItem.s.AC > 0 then begin
                  sTemp := 'M. Evasion: +' + IntToStr(Hiword(MouseItem.s.AC)) + '0%';
                  line2 := line2 + sTemp + ' ';
                  HintList.AddObject(sTemp, TObject(clWhite));
                end;
                if Loword(MouseItem.s.MAC) > 0 then begin
                  sTemp := 'Curse: +' + IntToStr(Loword(MouseItem.s.MAC));
                  line2 := line2 + sTemp + ' ';
                  HintList.AddObject(sTemp, TObject(GetRGB(254)));
                end;
                if Hiword(MouseItem.s.MAC) > 0 then begin
                  sTemp := 'Luck: +' + IntToStr(Hiword(MouseItem.s.MAC));
                  line2 := line2 + sTemp + ' ';
                  HintList.AddObject(sTemp, TObject(GetRGB(254)));
                end;
              end;
            20, 24, 52: {//项链 及 手镯: MaxAC -> Hit,  MaxMac -> Speed} begin
                if MouseItem.s.AC > 0 then begin
                  line2 := line2 + 'Accuracy+' + IntToStr(Hiword(MouseItem.s.AC)) + ' ';
                  HintList.AddObject('Accuracy: +' + IntToStr(Hiword(MouseItem.s.AC)), TObject(clWhite));
                end;
                if MouseItem.s.MAC > 0 then begin
                  line2 := line2 + 'Agility+' + IntToStr(Hiword(MouseItem.s.MAC)) + ' ';
                  HintList.AddObject('Agility: +' + IntToStr(Hiword(MouseItem.s.MAC)), TObject(clWhite));
                end;
              end;
            21, 54: {//项链} begin
                if Hiword(MouseItem.s.AC) > 0 then begin
                  HintList.AddObject('HP Recovery: +' + IntToStr(Hiword(MouseItem.s.AC)) + '0%', TObject(clWhite));
                  line2 := line2 + 'HP Recovery+' + IntToStr(Hiword(MouseItem.s.AC)) + '0% ';
                end;
                if Hiword(MouseItem.s.MAC) > 0 then begin
                  HintList.AddObject('MP Recovery: +' + IntToStr(Hiword(MouseItem.s.MAC)) + '0%', TObject(clWhite));
                  line2 := line2 + 'MP Recovery+' + IntToStr(Hiword(MouseItem.s.MAC)) + '0% ';
                end;
                if Loword(MouseItem.s.AC) > 0 then begin
                  HintList.AddObject('Attack Speed: +' + IntToStr(Loword(MouseItem.s.AC)), TObject(clWhite));
                  line2 := line2 + 'Attack Speed+' + IntToStr(Loword(MouseItem.s.AC)) + ' ';
                end;
                if Loword(MouseItem.s.MAC) > 0 then begin
                  HintList.AddObject('Attack Speed: -' + IntToStr(Loword(MouseItem.s.MAC)), TObject(clWhite));
                  line2 := line2 + 'Attack Speed-' + IntToStr(Loword(MouseItem.s.MAC)) + ' ';
                end;
              end;
            23: {//戒指} begin
                if Hiword(MouseItem.s.AC) > 0 then begin
                  HintList.AddObject('P Evasion: +' + IntToStr(Hiword(MouseItem.s.AC)) + '0%', TObject(clWhite));
                  line2 := line2 + 'P Evasion+' + IntToStr(Hiword(MouseItem.s.AC)) + '0% ';
                end;
                if Hiword(MouseItem.s.MAC) > 0 then begin
                  HintList.AddObject('P Recovery: +' + IntToStr(Hiword(MouseItem.s.MAC)) + '0%', TObject(clWhite));
                  line2 := line2 + 'P Recovery+' + IntToStr(Hiword(MouseItem.s.MAC)) + '0% ';
                end;
                if Loword(MouseItem.s.AC) > 0 then begin
                  HintList.AddObject('Attack Speed: +' + IntToStr(Loword(MouseItem.s.AC)), TObject(clWhite));
                  line2 := line2 + 'Attack Speed+' + IntToStr(Loword(MouseItem.s.AC)) + ' ';
                end;
                if Loword(MouseItem.s.MAC) > 0 then begin
                  HintList.AddObject('Attack Speed: -' + IntToStr(Loword(MouseItem.s.MAC)), TObject(clWhite));
                  line2 := line2 + 'Attack Speed-' + IntToStr(Loword(MouseItem.s.MAC)) + ' ';
                end;
              end;
            62: {//Boots} begin
                {if Hiword(MouseItem.S.AC) > 0 then
                  HintList.AddObject('防御: ' + IntToStr(Hiword(MouseItem.S.AC)), TObject(clWhite));
                if Hiword(MouseItem.S.MAC) > 0 then
                  HintList.AddObject('魔防: ' + IntToStr(Hiword(MouseItem.S.MAC)), TObject(clWhite)); }
                if MouseItem.s.AC > 0 then begin
                  HintList.AddObject('AC: ' + IntToStr(Loword(MouseItem.s.AC)) + '-' + IntToStr(Hiword(MouseItem.s.AC)), TObject(clWhite));
                  line2 := line2 + 'AC' + IntToStr(Loword(MouseItem.s.AC)) + '-' + IntToStr(Hiword(MouseItem.s.AC)) + ' ';
                end;
                if MouseItem.s.MAC > 0 then begin
                  HintList.AddObject('AMC: ' + IntToStr(Loword(MouseItem.s.MAC)) + '-' + IntToStr(Hiword(MouseItem.s.MAC)), TObject(clWhite));
                  line2 := line2 + 'AMC' + IntToStr(Loword(MouseItem.s.MAC)) + '-' + IntToStr(Hiword(MouseItem.s.MAC)) + ' ';
                end;

                //if Loword(MouseItem.S.MAC) > 0 then      //2008-3-3去掉鞋子的魔法恢复
                  //HintList.AddObject('魔法恢复: +' + IntToStr(Loword(MouseItem.S.MAC)), TObject(clWhite));
                if MouseItem.s.AniCount * MouseItem.s.Weight > 0 then begin
                  HintList.AddObject('Weight: +' + IntToStr(MouseItem.s.AniCount * MouseItem.s.Weight), TObject(clWhite));
                  line2 := line2 + 'Weight+' + IntToStr(MouseItem.s.AniCount * MouseItem.s.Weight) + ' ';
                end;
              end;
            63: {//Charm} begin
                if Loword(MouseItem.s.AC) > 0 then begin
                  HintList.AddObject('Strength: +' + IntToStr(Loword(MouseItem.s.AC)), TObject(GetRGB(254)));
                  line2 := line2 + 'Strength+' + IntToStr(Loword(MouseItem.s.AC)) + ' ';
                end;
                if Hiword(MouseItem.s.AC) > 0 then begin
                  HintList.AddObject('Magic: +' + IntToStr(Hiword(MouseItem.s.AC)), TObject(GetRGB(254)));
                  line2 := line2 + 'Magic+' + IntToStr(Hiword(MouseItem.s.AC)) + ' ';
                end;
                if Loword(MouseItem.s.MAC) > 0 then begin
                  HintList.AddObject('Curse: +' + IntToStr(Loword(MouseItem.s.MAC)), TObject(GetRGB(254)));
                  line2 := line2 + 'Curse+' + IntToStr(Loword(MouseItem.s.MAC)) + ' ';
                end;
                if Hiword(MouseItem.s.MAC) > 0 then begin
                  HintList.AddObject('Luck: +' + IntToStr(Hiword(MouseItem.s.MAC)), TObject(GetRGB(254)));
                  line2 := line2 + 'Luck+' + IntToStr(Hiword(MouseItem.s.MAC)) + ' ';
                end;
              end;
          else begin
              if MouseItem.s.AC > 0 then begin
                HintList.AddObject('AC: ' + IntToStr(Loword(MouseItem.s.AC)) + '-' + IntToStr(Hiword(MouseItem.s.AC)), TObject(clWhite));
                line2 := line2 + 'AC' + IntToStr(Loword(MouseItem.s.AC)) + '-' + IntToStr(Hiword(MouseItem.s.AC)) + ' ';
              end;
              if MouseItem.s.MAC > 0 then begin
                HintList.AddObject('AMC: ' + IntToStr(Loword(MouseItem.s.MAC)) + '-' + IntToStr(Hiword(MouseItem.s.MAC)), TObject(clWhite));
                line2 := line2 + 'AMC' + IntToStr(Loword(MouseItem.s.MAC)) + '-' + IntToStr(Hiword(MouseItem.s.MAC)) + ' ';
              end;
            end;
          end;

          if MouseItem.s.DC > 0 then begin
            line2 := line2 + 'DC' + IntToStr(Loword(MouseItem.s.DC)) + '-' + IntToStr(Hiword(MouseItem.s.DC)) + ' ';
            HintList.AddObject('DC: ' + IntToStr(Loword(MouseItem.s.DC)) + '-' + IntToStr(Hiword(MouseItem.s.DC)), TObject(clWhite));
          end;
          if MouseItem.s.MC > 0 then begin
            line2 := line2 + 'MC' + IntToStr(Loword(MouseItem.s.MC)) + '-' + IntToStr(Hiword(MouseItem.s.MC)) + ' ';
            HintList.AddObject('MC: ' + IntToStr(Loword(MouseItem.s.MC)) + '-' + IntToStr(Hiword(MouseItem.s.MC)), TObject(clWhite));
          end;
          if MouseItem.s.SC > 0 then begin
            line2 := line2 + 'SC' + IntToStr(Loword(MouseItem.s.SC)) + '-' + IntToStr(Hiword(MouseItem.s.SC)) + ' ';
            HintList.AddObject('SC: ' + IntToStr(Loword(MouseItem.s.SC)) + '-' + IntToStr(Hiword(MouseItem.s.SC)), TObject(clWhite));
          end;
          if (MouseItem.s.Source <= -1) and (MouseItem.s.Source >= -50) then begin
            line2 := line2 + 'Holy+' + IntToStr(-MouseItem.s.Source);
            HintList.AddObject('Holy: +' + IntToStr(-MouseItem.s.Source), TObject(GetRGB(254)));
          end;
          if (MouseItem.s.Source <= -51) and (MouseItem.s.Source >= -100) then begin
            line2 := line2 + 'Holy-' + IntToStr(-MouseItem.s.Source - 50);
            HintList.AddObject('Holy: -' + IntToStr(-MouseItem.s.Source - 50), TObject(GetRGB(254)));
          end;

          GetAtomStr(MouseItem.s.AddValue);

          case MouseItem.s.Need of
            0: begin
                if Actor.m_Abil.Level >= MouseItem.s.NeedLevel then
                  useable := True;
                sTemp := 'Requires Level: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            1: begin
                if Hiword(Actor.m_Abil.DC) >= MouseItem.s.NeedLevel then
                  useable := True;
                sTemp := 'Requires DC: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            2: begin
                if Hiword(Actor.m_Abil.MC) >= MouseItem.s.NeedLevel then
                  useable := True;
                sTemp := 'Requires MC: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            3: begin
                if Hiword(Actor.m_Abil.SC) >= MouseItem.s.NeedLevel then
                  useable := True;
                sTemp := 'Requires SC: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            4: begin
                useable := True;
                sTemp := '所需转生等级: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            40: begin
                useable := True;
                sTemp := '所需转生&等级: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            41: begin
                useable := True;
                sTemp := '所需转生&攻击力: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            42: begin
                useable := True;
                sTemp := '所需转生&魔法力: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            43: begin
                useable := True;
                sTemp := '所需转生&道术: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            44: begin
                useable := True;
                sTemp := '所需转生&声望点: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            5: begin
                useable := True;
                sTemp := '所需声望点: ' + IntToStr(MouseItem.s.NeedLevel);
                line3 := line3 + sTemp;
              end;
            6: begin
                useable := True;
                sTemp := '行会成员专用';
                line3 := line3 + sTemp;
              end;
            60: begin
                useable := True;
                sTemp := '行会掌门专用';
                line3 := line3 + sTemp;
              end;
            7: begin
                useable := True;
                sTemp := '沙城成员专用';
                line3 := line3 + sTemp;
              end;
            70: begin
                useable := True;
                sTemp := '沙城城主专用';
                line3 := line3 + sTemp;
              end;
            8: begin
                useable := True;
                sTemp := '会员专用';
                line3 := line3 + sTemp;
              end;
            81: begin
                useable := True;
                sTemp := '会员类型: =' + IntToStr(Loword(MouseItem.s.NeedLevel)) + '会员等级: >=' + IntToStr(Hiword(MouseItem.s.NeedLevel));
                line3 := line3 + sTemp;
              end;
            82: begin
                useable := True;
                sTemp := '会员类型: >=' + IntToStr(Loword(MouseItem.s.NeedLevel)) + '会员等级: >=' + IntToStr(Hiword(MouseItem.s.NeedLevel));
                line3 := line3 + sTemp;
              end;
          end;
          if useable then begin
            HintList.AddObject(sTemp, TObject(clWhite));
          end else begin
            HintList.AddObject(sTemp, TObject(clRed));
          end;
        end;
      25: {//护身符及毒药} begin
          line1 := line1 + 'Weight.' + IntToStr(MouseItem.s.Weight);
          case MouseItem.s.Shape of
            1, 2, 3, 4, 5, 6: begin
                line2 := 'Amount ' + GetDura100Str(MouseItem.Dura, MouseItem.DuraMax);
                HintList.AddObject('Amount: ' + GetDura100Str(MouseItem.Dura, MouseItem.DuraMax), TObject(GetRGB(254)));
              end;
            9: begin
                line2 := Format('Amount %d/%d', [MouseItem.Dura, MouseItem.DuraMax]);
                HintList.AddObject(Format('Amount: %d/%d', [MouseItem.Dura, MouseItem.DuraMax]), TObject(GetRGB(254)));
              end;
          end;
          HintList.AddObject('Weight: ' + IntToStr(MouseItem.s.Weight), TObject(clWhite));
        end;
      (*30: {//照明物} begin
          HintList.AddObject('持久 : ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax), TObject(GETRGB(254)));
          HintList.AddObject('重量: ' + IntToStr(MouseItem.S.Weight), TObject(clWhite));
        end;*)
      40: {//肉} begin
          line1 := line1 + 'Weight.' + IntToStr(MouseItem.s.Weight);
          if not g_MouseHeroItem.s.Shape in [13..16] then begin
            line1 := line1 + ' Quality' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
            HintList.AddObject('Quality: ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax), TObject(GetRGB(254)));
          end;
          HintList.AddObject('Weight: ' + IntToStr(MouseItem.s.Weight), TObject(clWhite));
        end;
      42: {//药材} begin
          line1 := line1 + 'Weight.' + IntToStr(MouseItem.s.Weight) + ' plow?';
          HintList.AddObject('Weight: ' + IntToStr(MouseItem.s.Weight), TObject(clWhite));
          HintList.AddObject('距犁', TObject(GetRGB(254)));
        end;
      43: {//矿石} begin
          line1 := line1 + 'Weight.' + IntToStr(MouseItem.s.Weight) + ' Purity' + IntToStr(Round(MouseItem.Dura / 1000));
          HintList.AddObject('Purity: ' + IntToStr(Round(MouseItem.Dura / 1000)), TObject(GetRGB(254)));
          HintList.AddObject('Weight: ' + IntToStr(MouseItem.s.Weight), TObject(clWhite));
        end;
      49: begin
          line1 := line1 + 'Weight.' + IntToStr(MouseItem.s.Weight);
          line2 := Format('Experience: %d/%d', [MouseItem.Dura * 10000, MouseItem.DuraMax * 10000]);
          HintList.AddObject('Weigth: ' + IntToStr(MouseItem.s.Weight), TObject(clWhite));
          HintList.AddObject(Format('Experience: %d/%d', [MouseItem.Dura * 10000, MouseItem.DuraMax * 10000]), TObject(GetRGB(254)));
          //dwExp := MouseItem.Dura * 10000;
          //dwMaxExp := MouseItem.DuraMax * 10000;
          //HintList.AddObject('经验: ' + IntToStr(dwExp) + '/' + IntToStr(dwMaxExp), TObject(GetRGB(254)));
        end; //
      31: begin
          if (MouseItem.s.AniCount <> 0) and (MouseItem.s.Shape = 1) then begin
            line2 := 'Use ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax) + ' 次';
            HintList.AddObject('Use: ' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax) + ' 次', TObject(GetRGB(254)));
            {if MouseItem.s.AddValue[1] <> 0 then begin
              //line2 := '记忆传送: 地图:' + MouseItem.s.sDescr + ' 坐标:' + GetMoveXY(MouseItem.s.AddValue);
              //HintList.AddObject('记忆传送: 地图: ' + MouseItem.s.sDescr + ' 坐标:' + GetMoveXY(MouseItem.s.AddValue), TObject(GetRGB(254)));
              line2 := '坐标:' + GetMoveXY(MouseItem.s.AddValue);
              HintList.AddObject('坐标:' + GetMoveXY(MouseItem.s.AddValue), TObject(GetRGB(254)));
            end else begin
              HintList.AddObject('记忆传送: 未记忆', TObject(GetRGB(254)));
              line2 := '记忆传送: 未记忆';
            end;}
          end;
          line1 := line1 + 'Weight.' + IntToStr(MouseItem.s.Weight);
          HintList.AddObject('Weight: ' + IntToStr(MouseItem.s.Weight), TObject(clWhite));
        end;
    else begin
        line1 := line1 + 'Weight.' + IntToStr(MouseItem.s.Weight);
        HintList.AddObject('Weight: ' + IntToStr(MouseItem.s.Weight), TObject(clWhite));
      end;
    end;

    if (g_ServerConfig.btShowClientItemStyle = 0) then begin
      if g_ServerConfig.boAllowItemAddPoint then begin
        if MouseItem.s.AddPoint[12] > 0 then HintList.AddObject('Walk Speed: ' + IntToStr(MouseItem.s.AddPoint[12]) + '%', TObject(GetRGB(68)));
        if MouseItem.s.AddPoint[13] > 0 then HintList.AddObject('Attack Speed: ' + IntToStr(MouseItem.s.AddPoint[13]) + '%', TObject(GetRGB(68)));
      end;
    end;

    if (g_ServerConfig.btShowClientItemStyle = 0) then begin
      if g_ServerConfig.boAllowItemAddPoint then begin
        case MouseItem.s.AddPoint[1] of
          1: HintList.AddObject('1物理伤害减少: ' + IntToStr(MouseItem.s.AddPoint[2]) + '%', TObject(clFuchsia));
          2: HintList.AddObject('2魔法伤害减少: ' + IntToStr(MouseItem.s.AddPoint[2]) + '%', TObject(clFuchsia));
          3: HintList.AddObject('3忽视目标防御: ' + IntToStr(MouseItem.s.AddPoint[2]) + '%', TObject(clFuchsia));
          4: HintList.AddObject('4所有伤害反射: ' + IntToStr(MouseItem.s.AddPoint[2]) + '%', TObject(clFuchsia));
          5: HintList.AddObject('5增加攻击伤害: ' + IntToStr(MouseItem.s.AddPoint[2]) + '%', TObject(clFuchsia));
        end;
        if MouseItem.s.AddPoint[3] > 0 then HintList.AddObject('6物理防御增强: ' + IntToStr(MouseItem.s.AddPoint[3]) + '%', TObject(GetRGB(180)));
        if MouseItem.s.AddPoint[4] > 0 then HintList.AddObject('7魔法防御增强: ' + IntToStr(MouseItem.s.AddPoint[4]) + '%', TObject(GetRGB(180)));
        if MouseItem.s.AddPoint[5] > 0 then HintList.AddObject('8物理攻击增强: ' + IntToStr(MouseItem.s.AddPoint[5]) + '%', TObject(GetRGB(180)));
        if MouseItem.s.AddPoint[6] > 0 then HintList.AddObject('9魔法攻击增强: ' + IntToStr(MouseItem.s.AddPoint[6]) + '%', TObject(GetRGB(180)));
        if MouseItem.s.AddPoint[7] > 0 then HintList.AddObject('10道术攻击增强: ' + IntToStr(MouseItem.s.AddPoint[7]) + '%', TObject(GetRGB(180)));
        if MouseItem.s.AddPoint[8] > 0 then HintList.AddObject('11增加进入失明状态: ' + IntToStr(MouseItem.s.AddPoint[8]) + '%', TObject(GetRGB(180)));
        if MouseItem.s.AddPoint[9] > 0 then HintList.AddObject('12增加进入混乱状态: ' + IntToStr(MouseItem.s.AddPoint[9]) + '%', TObject(GetRGB(180)));
        if MouseItem.s.AddPoint[10] > 0 then HintList.AddObject('13减少进入失明状态: ' + IntToStr(MouseItem.s.AddPoint[10]) + '%', TObject(GetRGB(180)));
        if MouseItem.s.AddPoint[11] > 0 then HintList.AddObject('14减少进入混乱状态: ' + IntToStr(MouseItem.s.AddPoint[11]) + '%', TObject(GetRGB(180)));
        //if MouseItem.s.AddPoint[12] > 0 then HintList.AddObject('移动加速: ' + IntToStr(MouseItem.s.AddPoint[12]) + '%', TObject(GetRGB(68)));
        //if MouseItem.s.AddPoint[13] > 0 then HintList.AddObject('攻击加速: ' + IntToStr(MouseItem.s.AddPoint[13]) + '%', TObject(GetRGB(68)));
      end;
      if g_ServerConfig.boAllowItemTime then begin
        if MouseItem.s.AddValue[0] = 1 then begin
          HintList.AddObject('Expires: ' + DateToStr(MouseItem.s.MaxDate), TObject(clyellow));
        end else begin
          HintList.AddObject('Expires: Never', TObject(clyellow));
        end;

        {
        if MouseItem.s.sDescr <> '' then begin
          if (MouseItem.s.StdMode = 31) and (MouseItem.s.AniCount <> 0) and (MouseItem.s.Shape = 1) then Exit;
          nLine := 0;
          sTemp := '';
          sDescr := MouseItem.s.sDescr;
          while Pos('/', sDescr) > 0 do begin
            sDescr := GetValidStr3(sDescr, sTemp, ['/']);
            if nLine = 0 then begin
              HintList.AddObject('物品说明: ' + sTemp, TObject(clyellow));
              Inc(nLine);
            end else begin
              HintList.AddObject(sTemp, TObject(clyellow));
              Inc(nLine);
            end;
            sTemp := '';
          end;
          if sDescr <> '' then begin
            if nLine = 0 then begin
              HintList.AddObject('物品说明: ' + sDescr, TObject(clyellow));
              Inc(nLine);
            end else begin
              HintList.AddObject(sDescr, TObject(clyellow));
              Inc(nLine);
            end;
          end;
        end;
        }
      end;
    end;
    g_ExtractStringList.Clear;

    {if (MouseItem.s.StdMode = 31) and
      (MouseItem.s.AniCount <> 0) and
      (MouseItem.s.Shape = 1) then Exit; }

    sItemDesc := GetItemDesc(MouseItem.S.Name);
    if (sItemDesc <> '') then begin
      if Pos('\', sItemDesc) > 0 then begin
        ExtractStrings(['\'], [' '], PChar(sItemDesc), g_ExtractStringList);
        if g_ExtractStringList.Count > 0 then begin
          HintList.AddObject(g_ExtractStringList.Strings[0], TObject(clWhite)); //  TObject(clyellow));//
        end;
        for I := 1 to g_ExtractStringList.Count - 1 do begin
          HintList.AddObject(g_ExtractStringList.Strings[I], TObject(clWhite));
        end;
      end else begin
        g_ExtractStringList.Add(sItemDesc);
          //HintList.AddObject(sItemDesc, TObject(clyellow));
        HintList.AddObject(sItemDesc, TObject(clWhite));
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemBagDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d0, d1, d2, d3: string;
  I, n, nX, nY: Integer;
  useable: Boolean;
  d: TTexture;
begin
  if g_MySelf = nil then Exit;
  with DItemBag do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    if (g_ServerConfig.btShowClientItemStyle <> 0) then begin
      GetMouseItemInfo(g_MySelf, @g_MouseItem, d0, d1, d2, d3, useable);
      with dsurface do begin
        //nX := SurfaceX(Left + 71);

      //TextOut (SurfaceX(Left+64), SurfaceY(Top+185), GetGoldStr(g_MySelf.m_nGold));
        TextOut(SurfaceX(Left + 71), SurfaceY(Top + 212), GetGoldStr(g_MySelf.m_nGold));
      //盛大物品栏
        if d0 <> '' then begin
          n := TextWidth(d0);
          nX := SurfaceX(Left + 77);
          nY := SurfaceY(Top + 243);

          TextOut(nX, nY, d0, clyellow);
          TextOut(nX + n, nY, d1);
          TextOut(nX, nY + 14, d2);
          if not useable then
            TextOut(nX, nY + 14 * 2, d3, clRed)
          else
            TextOut(nX, nY + 14 * 2, d3);

          if d2 <> '' then
            nY := nY + 14;
          if d3 <> '' then
            nY := nY + 14;

          nY := nY + 14;
          for I := 0 to g_ExtractStringList.Count - 1 do begin
            TextOut(nX, nY + 14 * I, g_ExtractStringList.Strings[I]);
          end;

        end else begin
          TextOut(SurfaceX(Left + 71), SurfaceY(Top + 212), GetGoldStr(g_MySelf.m_nGold));
          TextOut(SurfaceX(Left + 77), SurfaceY(Top + 243), 'Double Click Item to Equip');
          TextOut(SurfaceX(Left + 77), SurfaceY(Top + 243 + 14), 'ALT + R to refresh Inventory');
        end;
      end;
    end else begin
      with dsurface do begin
        TextOut(SurfaceX(Left + 71), SurfaceY(Top + 212), GetGoldStr(g_MySelf.m_nGold));
        TextOut(SurfaceX(Left + 77), SurfaceY(Top + 243), 'Double Click Item to Equip');
        TextOut(SurfaceX(Left + 77), SurfaceY(Top + 243 + 14), 'ALT + R to refresh Inventory');
      end;
    end;
  end;
end;

procedure TFrmDlg.DCloseBagDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    if Downed then begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        //DrawBlend(dsurface, SurfaceX(Left), SurfaceY(Top), d, 2);
    end;
  end;
end;

procedure TFrmDlg.DCloseBagClick(Sender: TObject; X, Y: Integer);
begin
  DItemBag.Visible := False;
end;

procedure TFrmDlg.DItemGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  nIdx: Integer;
  temp: TClientItem;
  iname, d1, d2, d3: string;
  useable: Boolean;
  hcolor: TColor;
  nWhere: Integer;
  boShowMsg: Boolean;
  List: TStringList;
begin
  DScreen.ClearHint;
  boShowMsg := False;
  if ssRight in Shift then begin
    if g_boItemMoving then
      DItemGridGridSelect(Self, ACol, ARow, Shift);
  end else begin
    nIdx := ACol + ARow * DItemGrid.ColCount + 6;
    if nIdx in [6..MAXBAGITEM - 1] then begin
      g_MoveRect := DItemGrid.ClientRect;
      g_MoveRect.Right := g_MoveRect.Right - 2;
      g_MoveRect.Top := g_MoveRect.Top + 2;
      g_MouseItem := g_ItemArr[nIdx];
      if (g_MouseItem.s.Name <> '') then begin
        if (g_ServerConfig.btShowClientItemStyle = 0) then begin
          nWhere := GetHumUseItemByBagItem(g_MouseItem.s.StdMode);
          if g_Config.boCompareItem and (nWhere >= 0) then begin

            List := TStringList.Create;
            try
              GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
              List.AddStrings(HintList);

              GetMouseItemInfo(g_MySelf, @g_UseItems[nWhere], iname, d1, d2, d3, useable);
              if HintList.Count > 0 then begin
                HintList.Strings[0] := GetUseItemName(nWhere) + ' ' + HintList.Strings[0];
              end;
              with DItemGrid do
                DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
                  SurfaceY(Top + (ARow + 1) * RowHeight),
                  List, HintList, False);
              HintList.Clear;
            finally
              List.Free;
            end;
            g_MouseItem.s.Name := '';
          end else begin
            GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
            with DItemGrid do
              DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
                SurfaceY(Top + (ARow + 1) * RowHeight),
                HintList, False);
          end;
        end;
      end;
    end else begin
      ClearMoveRect();
      g_MouseItem.s.Name := '';
    end;
  end;
end;

procedure TFrmDlg.DItemGridGridSelect(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);

var
  Idx, mi: Integer;
  temp: TClientItem;
  where: Integer;
  flag: Boolean;
  sData, sData1, sData2: string;
begin
  Idx := ACol + ARow * DItemGrid.ColCount + 6;
  if Idx in [6..MAXBAGITEM - 1] then begin
    if not g_boItemMoving then begin
      ClearMoveRect();
      {if (ssRight in Shift) then Showmessage('ssRight in Shift');
      if (ssShift in Shift) then Showmessage('ssShift in Shift');
      if (ssAlt in Shift) then Showmessage('ssAlt in Shift');
      if (ssCtrl in Shift) then Showmessage('ssCtrl in Shift');
      if (ssLeft in Shift) then Showmessage('ssLeft in Shift');}
      if (ssCtrl in Shift) then begin
        if g_ItemArr[Idx].s.Name <> '' then begin
          if not EdChat.Visible then begin
            SetInputVisible(g_ConfigClient.btMainInterface = 1);
            EdChat.Visible := True;
            EdChat.SetFocus;
          end;
          if EdChat.SelStart = Length(EdChat.Text) then begin
            EdChat.Text := EdChat.Text + '<0|' + g_MySelf.m_sUserName + '|' + g_ItemArr[Idx].s.Name + '|' + IntToStr(g_ItemArr[Idx].MakeIndex) + '|' + IntToStr(g_ItemArr[Idx].s.looks) + '>';
            EdChat.SelStart := Length(EdChat.Text);
          end else begin
            sData := Copy(EdChat.Text, 1, EdChat.SelStart);
            sData1 := Copy(EdChat.Text, EdChat.SelStart + 1, Length(EdChat.Text) - EdChat.SelStart);
            sData2 := '<0|' + g_MySelf.m_sUserName + '|' + g_ItemArr[Idx].s.Name + '|' + IntToStr(g_ItemArr[Idx].MakeIndex) + '|' + IntToStr(g_ItemArr[Idx].s.looks) + '>';
            EdChat.Text := sData + sData2 + sData1;
            EdChat.SelStart := Length(EdChat.Text) - Length(WideString(sData1));
          end;
          EdChat.SelLength := 0;
        end;
        Exit;
      end;

      if g_ItemArr[Idx].s.Name <> '' then begin
        g_dwMoveItemTick := GetTickCount;
        g_boItemMoving := True;
        g_MovingItem.Index := Idx;
        g_MovingItem.Item := g_ItemArr[Idx];
        g_MovingItem.Owner := DItemBag;
        g_ItemArr[Idx].s.Name := '';
      end;
      if g_boItemMoving and (g_MovingItem.Owner = DItemBag) and (g_WaitingUseItem.Item.s.Name = '') then begin
       { if mbRight = Button then begin //右键穿装备
          flag := False;
          where := GetTakeOnPosition(g_MovingItem.Item.s.StdMode);
          if g_MovingItem.Index >= 0 then begin
            case where of
              U_DRESS: begin
                  if g_MySelf.m_btSex = 0 then
                    if g_MovingItem.Item.s.StdMode <> 10 then
                      Exit;
                  if g_MySelf.m_btSex = 1 then
                    if g_MovingItem.Item.s.StdMode <> 11 then
                      Exit;
                  flag := True;
                end;
              U_WEAPON: flag := True;
              U_NECKLACE: flag := True;
              U_RIGHTHAND: flag := True;
              U_HELMET: flag := True;
              U_RINGR, U_RINGL: flag := True;
              U_ARMRINGR, U_ARMRINGL: flag := True;
              U_BUJUK: flag := True;
              U_BELT: flag := True;
              U_BOOTS: flag := True;
              U_CHARM: flag := True;
            end;
            if flag then begin
              if where in [U_RINGR, U_RINGL] then begin
                if g_UseItems[U_RINGR].s.Name = '' then where := U_RINGR;
                if g_UseItems[U_RINGL].s.Name = '' then where := U_RINGL;
                if (g_UseItems[U_RINGR].s.Name <> '') and (g_UseItems[U_RINGL].s.Name <> '') then begin
                  if g_MovingItem.Item.s.Name <> g_UseItems[U_RINGR].s.Name then where := U_RINGR;
                  if g_MovingItem.Item.s.Name <> g_UseItems[U_RINGL].s.Name then where := U_RINGL;
                end;
              end;

              if where in [U_ARMRINGR, U_ARMRINGL] then begin
                if g_UseItems[U_ARMRINGR].s.Name = '' then where := U_ARMRINGR;
                if g_UseItems[U_ARMRINGL].s.Name = '' then where := U_ARMRINGL;
                if (g_UseItems[U_ARMRINGR].s.Name <> '') and (g_UseItems[U_ARMRINGL].s.Name <> '') then begin
                  if g_MovingItem.Item.s.Name <> g_UseItems[U_ARMRINGR].s.Name then where := U_ARMRINGR;
                  if g_MovingItem.Item.s.Name <> g_UseItems[U_ARMRINGL].s.Name then where := U_ARMRINGL;
                end;
              end;

              g_WaitingUseItem := g_MovingItem;
              g_WaitingUseItem.Index := where;
              frmMain.SendTakeOnItem(where, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
              g_MovingItem.Item.s.Name := '';
              g_MovingItem.Owner := nil;
              g_boItemMoving := False;
            end else begin
              g_ItemArr[idx] := g_MovingItem.Item;
              g_MovingItem.Item.s.Name := '';
              g_MovingItem.Owner := nil;
              g_boItemMoving := False;
            end;
          end;
        end else begin }
        ItemClickSound(g_ItemArr[Idx].s);
       // end;
      end;
    end else begin

      mi := g_MovingItem.Index;
      if (mi = -97) or (mi = -98) then Exit;
      if (mi < 0) and (mi >= -13 {-9}) and ((g_MovingItem.Owner = DStateWin) or (g_MovingItem.Owner = DHeroStateWin)) then begin //-99:
        if g_MovingItem.Owner = DStateWin then begin
          frmMain.SendTakeOffItem(-(g_MovingItem.Index + 1), g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
        end else
          if g_MovingItem.Owner = DHeroStateWin then begin
          frmMain.SendTakeOffItemToMasterBag(-(g_MovingItem.Index + 1), g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
        end;
        g_WaitingUseItem := g_MovingItem;
        g_MovingItem.Item.s.Name := '';
        g_boItemMoving := False;
        g_MovingItem.Owner := nil;
        ArrangeItemBag;
        Exit;
      end;
      if (mi <= -20) and (mi > -30) then
        DealItemReturnBag(g_MovingItem.Item);

      if (mi <= -30) and (mi > -40) then
        DuelItemReturnBag(g_MovingItem.Item);

      if (g_MovingItem.Owner = DItemBag) or (g_MovingItem.Owner = DDealDlg) or (g_MovingItem.Owner = DUpgrade) or (g_MovingItem.Owner = DStoreDlg) then begin
        if (g_ItemArr[Idx].s.Name <> '') then begin
          temp := g_ItemArr[Idx];
          g_ItemArr[Idx] := g_MovingItem.Item;
          g_MovingItem.Index := Idx;
          g_MovingItem.Item := temp;
          g_MovingItem.Owner := DItemBag;
        end else begin
          g_ItemArr[Idx] := g_MovingItem.Item;
          g_MovingItem.Item.s.Name := '';
          g_boItemMoving := False;
          g_MovingItem.Owner := nil;
        end;
        ArrangeItemBag;
        Exit;
      end;
      if (g_MovingItem.Owner = DHeroStateWin) or (g_MovingItem.Owner = DHeroItemBag) then begin
        if g_MovingItem.Owner = DHeroStateWin then begin
          frmMain.SendTakeOffItemToMasterBag(-(g_MovingItem.Index + 1), g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
        end else
          if g_MovingItem.Owner = DHeroItemBag then begin
          frmMain.SendItemToMasterBag((g_MovingItem.Index), g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
        end;
        g_WaitingUseItem := g_MovingItem;
        g_MovingItem.Item.s.Name := '';
        g_boItemMoving := False;
        g_MovingItem.Owner := nil;
      end;
    end;
  end;
  ArrangeItemBag;
end;

procedure TFrmDlg.DItemGridDblClick(Sender: TObject);
var
  Idx, I: Integer;
  keyvalue: TKeyBoardState;
  cu: TClientItem;
  where: Integer;
  flag: Boolean;
begin
  Idx := DItemGrid.Col + DItemGrid.Row * DItemGrid.ColCount + 6;
  if Idx in [6..MAXBAGITEM - 1] then begin
    if g_ItemArr[Idx].s.Name <> '' then begin
      FillChar(keyvalue, SizeOf(TKeyBoardState), #0);
      GetKeyboardState(keyvalue);
      if keyvalue[VK_CONTROL] = $80 then begin
        cu := g_ItemArr[Idx];
        g_ItemArr[Idx].s.Name := '';
        AddItemBag(cu);
      end else
        if (g_ItemArr[Idx].s.StdMode <= 4) or (g_ItemArr[Idx].s.StdMode = 31) or ((g_ItemArr[Idx].s.StdMode = 49) {and (g_ItemArr[idx].Dura >= g_ItemArr[idx].DuraMax)}) then begin
        frmMain.EatItem(Idx);
      end else begin
        if (g_WaitingUseItem.Item.s.Name = '') then begin
          flag := False;
          where := GetTakeOnPosition(g_ItemArr[Idx].s.StdMode);
          case where of
            U_DRESS: begin
                if g_MySelf.m_btSex = 0 then
                  if g_ItemArr[Idx].s.StdMode = 10 then
                    flag := True;
                if g_MySelf.m_btSex = 1 then
                  if g_ItemArr[Idx].s.StdMode = 11 then
                    flag := True;
              end;
            U_WEAPON: flag := True;
            U_NECKLACE: flag := True;
            U_RIGHTHAND: flag := True;
            U_HELMET: flag := True;
            U_RINGR, U_RINGL: flag := True;
            U_ARMRINGR, U_ARMRINGL: flag := True;
            U_BUJUK: flag := True;
            U_BELT: flag := True;
            U_BOOTS: flag := True;
            U_CHARM: flag := True;
          end;
          if flag then begin
            if where in [U_RINGR, U_RINGL] then begin
              if g_UseItems[U_RINGR].s.Name = '' then where := U_RINGR;
              if g_UseItems[U_RINGL].s.Name = '' then where := U_RINGL;
              if (g_UseItems[U_RINGR].s.Name <> '') and (g_UseItems[U_RINGL].s.Name <> '') then begin
                if g_ItemArr[Idx].s.Name <> g_UseItems[U_RINGR].s.Name then where := U_RINGR;
                if g_ItemArr[Idx].s.Name <> g_UseItems[U_RINGL].s.Name then where := U_RINGL;
              end;
            end;

            if where in [U_ARMRINGR, U_ARMRINGL] then begin
              if g_UseItems[U_ARMRINGR].s.Name = '' then where := U_ARMRINGR;
              if g_UseItems[U_ARMRINGL].s.Name = '' then where := U_ARMRINGL;
              if (g_UseItems[U_ARMRINGR].s.Name <> '') and (g_UseItems[U_ARMRINGL].s.Name <> '') then begin
                if g_ItemArr[Idx].s.Name <> g_UseItems[U_ARMRINGR].s.Name then where := U_ARMRINGR;
                if g_ItemArr[Idx].s.Name <> g_UseItems[U_ARMRINGL].s.Name then where := U_ARMRINGL;
              end;
            end;
            g_WaitingUseItem.Index := where;
            g_WaitingUseItem.Item := g_ItemArr[Idx];
            g_ItemArr[Idx].s.Name := '';
            frmMain.SendTakeOnItem(where, g_WaitingUseItem.Item.MakeIndex, g_WaitingUseItem.Item.s.Name);
          end;
        end;
        {if not g_boItemMoving then begin
          if g_ItemArr[idx].S.Name <> '' then begin
            g_btItemMoving := 2;
            g_boItemMoving := True;
            g_MovingItem.Index := idx;
            g_MovingItem.Item := g_ItemArr[idx];
            g_ItemArr[idx].S.Name := '';
            ItemClickSound(g_ItemArr[idx].S);
          end;
        end; }
      end;
    end else begin
      if g_boItemMoving and (g_MovingItem.Item.s.Name <> '') then begin
        FillChar(keyvalue, SizeOf(TKeyBoardState), #0);
        GetKeyboardState(keyvalue);
        if keyvalue[VK_CONTROL] = $80 then begin
          cu := g_MovingItem.Item;
          g_MovingItem.Item.s.Name := '';
          g_boItemMoving := False;
          AddItemBag(cu);
        end else
          if (g_MovingItem.Index = Idx) and
          (g_MovingItem.Item.s.StdMode <= 4) or (g_ItemArr[Idx].s.StdMode = 31) or ((g_ItemArr[Idx].s.StdMode = 49) { and (g_ItemArr[idx].Dura >= g_ItemArr[idx].DuraMax)}) then begin
          frmMain.EatItem(-1);
        end else
          if (g_WaitingUseItem.Item.s.Name = '') then begin
          if g_MovingItem.Index >= 0 then begin
            flag := False;
            where := GetTakeOnPosition(g_MovingItem.Item.s.StdMode);
            case where of
              U_DRESS: begin
                  if g_MySelf.m_btSex = 0 then
                    if g_MovingItem.Item.s.StdMode = 10 then
                      flag := True;
                  if g_MySelf.m_btSex = 1 then
                    if g_MovingItem.Item.s.StdMode = 11 then
                      flag := True;
                end;
              U_WEAPON: flag := True;
              U_NECKLACE: flag := True;
              U_RIGHTHAND: flag := True;
              U_HELMET: flag := True;
              U_RINGR, U_RINGL: flag := True;
              U_ARMRINGR, U_ARMRINGL: flag := True;
              U_BUJUK: flag := True;
              U_BELT: flag := True;
              U_BOOTS: flag := True;
              U_CHARM: flag := True;
            end;

            if flag then begin
              if where in [U_RINGR, U_RINGL] then begin
                if g_UseItems[U_RINGR].s.Name = '' then where := U_RINGR;
                if g_UseItems[U_RINGL].s.Name = '' then where := U_RINGL;
                if (g_UseItems[U_RINGR].s.Name <> '') and (g_UseItems[U_RINGL].s.Name <> '') then begin
                  if g_MovingItem.Item.s.Name <> g_UseItems[U_RINGR].s.Name then where := U_RINGR;
                  if g_MovingItem.Item.s.Name <> g_UseItems[U_RINGL].s.Name then where := U_RINGL;
                end;
              end;

              if where in [U_ARMRINGR, U_ARMRINGL] then begin
                if g_UseItems[U_ARMRINGR].s.Name = '' then where := U_ARMRINGR;
                if g_UseItems[U_ARMRINGL].s.Name = '' then where := U_ARMRINGL;
                if (g_UseItems[U_ARMRINGR].s.Name <> '') and (g_UseItems[U_ARMRINGL].s.Name <> '') then begin
                  if g_MovingItem.Item.s.Name <> g_UseItems[U_ARMRINGR].s.Name then where := U_ARMRINGR;
                  if g_MovingItem.Item.s.Name <> g_UseItems[U_ARMRINGL].s.Name then where := U_ARMRINGL;
                end;
              end;

              g_WaitingUseItem := g_MovingItem;
              g_WaitingUseItem.Index := where;
              frmMain.SendTakeOnItem(where, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
              g_MovingItem.Item.s.Name := '';
              g_MovingItem.Owner := nil;
              g_boItemMoving := False;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TTexture);
var
  nIdx: Integer;
  d: TTexture;
begin
  nIdx := ACol + ARow * DItemGrid.ColCount + 6;
  if nIdx in [6..MAXBAGITEM - 1] then begin
    if g_ItemArr[nIdx].s.Name <> '' then begin
      d := g_WBagItemImages.Images[g_ItemArr[nIdx].s.looks];

      if d <> nil then
        with DItemGrid do begin
          dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
            d.ClientRect,
            d, True);
        end;

      with DItemGrid do begin
        if (g_ItemArr[nIdx].s.AddValue[12] in [1, 3]) {or (GetAddPoint(g_ItemArr[nIdx].s.AddPoint))} then begin
          if GetTickCount - g_DrawItemArr[nIdx].dwDrawTick >= 200 then begin
            g_DrawItemArr[nIdx].dwDrawTick := GetTickCount;
            if g_DrawItemArr[nIdx].nIndex <= 0 then g_DrawItemArr[nIdx].nIndex := 260 - 1;
            Inc(g_DrawItemArr[nIdx].nIndex);
            if g_DrawItemArr[nIdx].nIndex > 265 then g_DrawItemArr[nIdx].nIndex := 260;
          end;

          d := g_WMain2Images.Images[g_DrawItemArr[nIdx].nIndex];
          if d <> nil then begin
            DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1), d);
          end;
        end;

        if g_ItemArr[nIdx].s.AddValue[12] >= 2 then begin
          if GetTickCount - g_DrawItemArr_[nIdx].dwDrawTick >= 200 then begin
            g_DrawItemArr_[nIdx].dwDrawTick := GetTickCount;
            if g_DrawItemArr_[nIdx].nIndex <= 0 then g_DrawItemArr_[nIdx].nIndex := 600 - 1;
            Inc(g_DrawItemArr_[nIdx].nIndex);
            if g_DrawItemArr_[nIdx].nIndex > 617 then g_DrawItemArr_[nIdx].nIndex := 600;
          end;

          d := g_WMain3Images.Images[g_DrawItemArr_[nIdx].nIndex];
          if d <> nil then begin
            DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1), d);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DGoldClick(Sender: TObject; X, Y: Integer);
begin
  if g_MySelf = nil then Exit;
  if not g_boItemMoving then begin
    if g_MySelf.m_nGold > 0 then begin
      PlaySound(s_money);
      g_boItemMoving := True;
      g_MovingItem.Index := -98; //捣
      g_MovingItem.Item.s.Name := g_sGoldName {'金币'};
    end;
  end else begin
    if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then begin //捣父..
      g_boItemMoving := False;
      g_MovingItem.Item.s.Name := '';
      if g_MovingItem.Index = -97 then begin //背券芒俊辑 颗
        DealZeroGold;
      end;
    end;
  end;
end;






{------------------------------------------------------------------------}

//惑牢 措拳 芒

{------------------------------------------------------------------------}

procedure TFrmDlg.DNpcLabelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  NpcLabel: TNpcLabel;
begin
  if Sender is TNpcLabel then begin
    NpcLabel := TNpcLabel(Sender);
    with NpcLabel do
      DScreen.ShowHintA(SurfaceX(Left + Width), SurfaceY(Top) + 16, Hint, clInfoText, True);
  end;
end;

procedure TFrmDlg.GetMerchantSayLabel(sData: string; nRecogID: Integer);
var
  ClientOption: TClientOption;
  ConfigClient: TConfigClient;
  nSize: Integer;
  nCrc: Integer;

  function CreateLabel(nX, nY, nRecogID: Integer; FColor: TColor; sData: string; boClick: Boolean): TNpcLabel;
  var
    NpcLabel: TNpcLabel;
  begin
    NpcLabel := TNpcLabel.Create(Self);
    NpcLabel.Font.Assign(frmMain.Font);
    //NpcLabel.Parent := DMerchantDlg;
    //NpcLabel.Name := 'Label';
   { if Pos('|', sData) > 0 then begin
      NpcLabel.Caption := Copy(sData, 1, Pos('|', sData) - 1);
      NpcLabel.Hint := Copy(sData, Pos('|', sData) + 1, Length(sData));
      NpcLabel.OnMouseMove := DNpcLabelMouseMove;
    end else begin
      NpcLabel.Caption := sData;
    end; }
    NpcLabel.Caption := sData;
    NpcLabel.Left := nX;
    NpcLabel.Top := nY;
    NpcLabel.UpColor := FColor;
    NpcLabel.HotColor := FColor;
    NpcLabel.DownColor := FColor;
  //NPCLabel.Font.Size := 10;
    NpcLabel.m_nRecogId := nRecogID;
    if DMerchantBigDlg.Visible then
      NpcLabel.DParent := DMerchantBigDlg //DMerchantDlg;
    else
      NpcLabel.DParent := DMerchantDlg;
    {NpcLabel.Canvas.Font.Assign(DMerchantDlg.Canvas.Font);
    NpcLabel.Canvas.Brush.Assign(DMerchantDlg.Canvas.Brush);}
    NpcLabel.OnClick := nil;

    if boClick then begin
      NpcLabel.OnClick := NpcLabelClick;
      NpcLabel.Cursor := crHandPoint;
      NpcLabel.HotColor := GetRGB(69); //clPurple;//clGreen;//clBlue;//clRed; //clAqua;//clFuchsia;
      NpcLabel.DownColor := clLime;
    end;
    NpcLabel.EnableFocus := False;
    {NpcLabel.Font.Size:=9;
    NpcLabel.Font.Name:=g_sCurFontName;  }
    //NpcLabel.Font.Assign(frmMain.Font);
   { NpcLabel.Visible := True;
    NpcLabel.TransParented:=False;
    NpcLabel.BkgrndColor:= clGreen; }
   { if (ClientOption.nSize = nSize) and (ClientOption.nCrc = nCrc)
      and (ClientOption.nSize > 0) and (ClientOption.nCrc <> 0) then begin
      NpcLabel.OnDestroy := LabelOnDestroy;
      //DebugOutStr('TFrmDlg.GetMerchantSayLabel:NpcLabel.OnDestroy := LabelOnDestroy');
    end else begin
      //NpcLabel.OnClick := nil;
    end;}
    Result := NpcLabel;
  end;

var
  Str, data, fdata, cmdstr, cmdmsg, cmdparam: string;
  lx, ly, sx: Integer;
  drawcenter: Boolean;
  nLength: Integer;
  btColor: Byte;
  UseColor: TColor;
  sColor: string;
  sNPCName: string;
  TempList: TStringList;
  I: Integer;
  NpcLabel: TNpcLabel;
  NpcLabelCmd: TNpcLabel;
  nPos: Integer;
  nAddY: Integer;
  sHintString: string;
begin
  //DebugOutStr('TFrmDlg.GetMerchantSayLabel:'+INTTOSTR(gettickcount - dwtick));

  TempList := TStringList.Create;
  try
    Str := sData;
  //Str := GetValidStr3(Str, sNPCName, ['/']);
    UseColor := clRed;

    lx := 30;
    ly := 20;

    drawcenter := False;

    NpcLabel := nil;
    NpcLabelCmd := nil;
    while True do begin
      if Str = '' then Break;
      Str := GetValidStr3(Str, data, ['\']);
      if data <> '' then begin
        sx := 0;
        fdata := '';
        while (Pos('<', data) > 0) and (Pos('>', data) > 0) and (data <> '') do begin
          if data[1] <> '<' then begin
            data := '<' + GetValidStr3(data, fdata, ['<']);
          end;
          data := ArrestStringEx(data, '<', '>', cmdstr);
          if cmdstr <> '' then begin
            cmdparam := GetValidStr3(cmdstr, cmdstr, ['/']); //cmdparam :
          end else begin
            Continue;
          end;
          if fdata <> '' then begin
            NpcLabel := CreateLabel(lx + sx, ly, MerchantFace, clWhite, fdata, False);
            sx := sx + ImageCanvas.TextWidth(fdata);
          end;
          if (Length(cmdparam) > 0) and (cmdparam[1] <> '@') then begin
            nLength := CompareText(cmdparam, 'FCOLOR=');
            if (nLength > 0) and (Length(cmdparam) > Length('FCOLOR=')) then begin
              sColor := Copy(cmdparam, Length('FCOLOR=') + 1, nLength);
              btColor := Str_ToInt(sColor, 100);
              UseColor := GetRGB(btColor);
              cmdparam := '';
            end else
              nLength := CompareText(cmdparam, 'AUTOCOLOR='); //2007-2-28 Mars增加自动变色NPC字体
            if (nLength >= 0) and (Length(cmdparam) >= Length('AUTOCOLOR=')) then begin
              sColor := Copy(cmdparam, Length('AUTOCOLOR=') + 1, nLength);
              if Pos(',', sColor) > 0 then begin
                TempList.Clear;
                ExtractStrings([','], [], PChar(sColor), TempList);
              end;
              cmdparam := '';
            end else begin

            end;
          end;
          if (Length(cmdparam) > 0) and (cmdparam[1] = '@') then begin

            if Pos('|', cmdstr) > 0 then begin
              sHintString := Copy(cmdstr, Pos('|', cmdstr) + 1, Length(cmdstr));
              cmdstr := Copy(cmdstr, 1, Pos('|', cmdstr) - 1);

              if Pos('|', sHintString) > 0 then
                for I := 1 to Length(sHintString) - 1 do begin
                  if sHintString[I] = '|' then sHintString[I] := '\';
                end;
      //NpcLabel.OnMouseMove := DNpcLabelMouseMove;
            end else begin
              sHintString := ''
            end;

            NpcLabelCmd := CreateLabel(lx + sx, ly, MerchantFace, clyellow, cmdstr, True);
            NpcLabelCmd.Font.Style := NpcLabelCmd.Font.Style + [fsUnderline];
            if sHintString <> '' then begin
              NpcLabelCmd.OnMouseMove := DNpcLabelMouseMove;
              NpcLabelCmd.Hint := sHintString;
            end;
          end else begin
            if Pos('|', cmdstr) > 0 then begin
              sHintString := Copy(cmdstr, Pos('|', cmdstr) + 1, Length(cmdstr));
              cmdstr := Copy(cmdstr, 1, Pos('|', cmdstr) - 1);
              if Pos('|', sHintString) > 0 then
                for I := 1 to Length(sHintString) - 1 do begin
                  if sHintString[I] = '|' then sHintString[I] := '\';
                end;
      //NpcLabel.OnMouseMove := DNpcLabelMouseMove;
            end else begin
              sHintString := ''
            end;
            NpcLabelCmd := CreateLabel(lx + sx, ly, MerchantFace, UseColor, cmdstr, False);
            if sHintString <> '' then begin
              NpcLabelCmd.OnMouseMove := DNpcLabelMouseMove;
              NpcLabelCmd.Hint := sHintString;
            end;
            if TempList.Count > 0 then begin
              for I := 0 to TempList.Count - 1 do begin
                NpcLabelCmd.AddColor(Str_ToInt(TempList.Strings[I], 100));
              end;
              TempList.Clear;
            end;
          end;
          sx := sx + ImageCanvas.TextWidth(cmdstr);
          NpcLabelCmd.Text := cmdparam;
        end; // while (Pos('<', data) > 0)
        if data <> '' then begin
          NpcLabel := CreateLabel(lx + sx, ly, MerchantFace, clWhite, data, False);
        end;
        Inc(ly, 16);
      end else Inc(ly, 16);
    end;
  finally
    TempList.Free;
  end;
end;

procedure TFrmDlg.ShowMDlg(face: Integer; mname, msgstr: string);
var
  I: Integer;
  c: TControl;
begin
  for I := DMerchantDlg.DControls.Count - 1 downto 0 do begin
    c := TControl(DMerchantDlg.DControls.Items[I]);
    if (c is TDLabel) or (c is TNpcLabel) then begin
      c.Free;
    end;
  end;

  for I := DMerchantBigDlg.DControls.Count - 1 downto 0 do begin
    c := TControl(DMerchantBigDlg.DControls.Items[I]);
    if (c is TDLabel) or (c is TNpcLabel) then begin
      c.Free;
    end;
  end;

  GetMerchantSayLabel(msgstr, g_nCurMerchant);

  DMerchantDlg.Left := 0;
  DMerchantDlg.Top := 0;

  DMerchantBigDlg.Left := 0;
  DMerchantBigDlg.Top := 0;

  MerchantFace := face;
  MerchantName := mname;
  MDlgStr := msgstr;
  DItemBag.Left := 475;
  DItemBag.Top := 80;

  if not DMerchantBigDlg.Visible then begin
    DMerchantDlg.Floating := True;
    try
      DMerchantDlg.Visible := True;
    finally
      DMerchantDlg.Floating := False;
    end;
  end;

  RequireAddPoints := True;
  LastestClickTime := GetTickCount;
end;

procedure TFrmDlg.ResetMenuDlg;
var
  I: Integer;
begin
  CloseDSellDlg;
  for I := 0 to g_MenuItemList.Count - 1 do
    Dispose(pTClientItem(g_MenuItemList[I]));
  g_MenuItemList.Clear;

  for I := 0 to MenuList.Count - 1 do
    Dispose(PTClientGoods(MenuList[I]));
  MenuList.Clear;

  //CurDetailItem := '';
  menuindex := -1;
  MenuTopLine := 0;
  BoDetailMenu := False;
  BoStorageMenu := False;
  BoMakeDrugMenu := False;

  DSellDlg.Visible := False;
  DMenuDlg.Visible := False;
  if EdChat.Visible then EdChat.SetFocus;
end;

procedure TFrmDlg.ShowShopMenuDlg;
begin
  menuindex := -1;

  if DMerchantBigDlg.Visible then begin
    DMerchantBigDlg.Left := 0;
    DMerchantBigDlg.Top := 0;
    DMerchantBigDlg.Floating := True;
    try
      DMerchantBigDlg.Visible := True;
    finally
      DMerchantBigDlg.Floating := False;
    end;
  end else begin
    DMerchantDlg.Left := 0;
    DMerchantDlg.Top := 0;
    DMerchantDlg.Floating := True;
    try
      DMerchantDlg.Visible := True;
    finally
      DMerchantDlg.Floating := False;
    end;
  end;
  DSellDlg.Visible := False;

  if DMerchantBigDlg.Visible then begin
    DMenuDlg.Top := 347;
  end else begin
    DMenuDlg.Top := 176;
  end;

  DMenuDlg.Left := 0;
  //DMenuDlg.Top := 176;
  DMenuDlg.Visible := True;
  MenuTop := 0;

  if DMerchantBigDlg.Visible then begin
    DItemBag.Left := 568;
  end else begin
    DItemBag.Left := 475;
  end;
  DItemBag.Top := 80;
  DItemBag.Visible := True;

  LastestClickTime := GetTickCount;
end;

procedure TFrmDlg.ShowShopSellDlg;
begin
  if DMerchantBigDlg.Visible then begin
    DSellDlg.Left := DMerchantBigDlg.Width - DSellDlg.Width;
    DSellDlg.Top := 347;
  end else begin
    DSellDlg.Left := 260;
    DSellDlg.Top := 176;
  end;
  DSellDlg.Visible := True;

  DMenuDlg.Visible := False;

  if DMerchantBigDlg.Visible then begin
    DItemBag.Left := 568;
  end else begin
    DItemBag.Left := 475;
  end;
  DItemBag.Top := 80;
  DItemBag.Visible := True;

  LastestClickTime := GetTickCount;
  g_sSellPriceStr := '';
end;

procedure TFrmDlg.CloseMDlg;
var
  I: Integer;
begin
  MDlgStr := '';
  DMerchantDlg.Visible := False;
  for I := 0 to MDlgPoints.Count - 1 do
    Dispose(pTClickPoint(MDlgPoints[I]));
  MDlgPoints.Clear;

  DItemBag.Left := 0;
  DItemBag.Top := 80;
  DMenuDlg.Visible := False;
  CloseDSellDlg;
end;

procedure TFrmDlg.CloseBigMDlg;
var
  I: Integer;
begin
  g_nCurMerchantFaceIdx := -1;
  MDlgStr := '';
  DMerchantBigDlg.Visible := False;
  for I := 0 to MDlgPoints.Count - 1 do
    Dispose(pTClickPoint(MDlgPoints[I]));
  MDlgPoints.Clear;

  DItemBag.Left := 0;
  DItemBag.Top := 80;
  DMenuDlg.Visible := False;
  CloseDSellDlg;
end;

procedure TFrmDlg.CloseDSellDlg;
begin
  DSellDlg.Visible := False;
  if g_SellDlgItem.s.Name <> '' then
    AddItemBag(g_SellDlgItem);
  g_SellDlgItem.s.Name := '';
end;

procedure TFrmDlg.DMerchantDlgDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDWindow do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then begin
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      if (Sender = DMerchantBigDlg) and (g_nCurMerchantFaceIdx >= 0) then begin
        d := g_WNpcFaceImages.Images[g_nCurMerchantFaceIdx];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left + Width - d.Width - 26), SurfaceY(Top + 8), d.ClientRect, d, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DMerchantDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
  CloseMDlg;
end;

procedure TFrmDlg.DMenuDlgDirectPaint(Sender: TObject;
  dsurface: TTexture);
  function sx(X: Integer): Integer;
  begin
    Result := DMenuDlg.SurfaceX(DMenuDlg.Left + X);
  end;
  function sY(Y: Integer): Integer;
  begin
    Result := DMenuDlg.SurfaceY(DMenuDlg.Top + Y);
  end;
var
  I, lh, k, m, menuline: Integer;
  d: TTexture;
  pg: PTClientGoods;
  Str: string;
  c: TColor;
begin
  with dsurface do begin
    with DMenuDlg do begin
      d := nil;
      if DMenuDlg.WLib <> nil then
        d := DMenuDlg.WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;

    if not BoStorageMenu then begin
      TextOut(sx(19), sY(11), 'Item List');
      TextOut(sx(156), sY(11), 'Price');
      TextOut(sx(245), sY(11), 'Durability');
      lh := LISTLINEHEIGHT;
      menuline := _MIN(MAXMENU, MenuList.Count - MenuTop);
      //惑前 府胶飘
      for I := MenuTop to MenuTop + menuline - 1 do begin
        m := I - MenuTop;
        if I = menuindex then begin
          c := clRed;
          TextOut(sx(12), sY(32 + m * lh), Char(7), c);
        end else c := clWhite;
        pg := PTClientGoods(MenuList[I]);
        TextOut(sx(19), sY(32 + m * lh), pg.Name, c);
        if pg.SubMenu >= 1 then
          TextOut(sx(137), sY(32 + m * lh), #31, c);
        TextOut(sx(156), sY(32 + m * lh), IntToStr(pg.Price) + ' ' + g_sGoldName {金币'}, c);
        Str := '';
        if pg.Grade = -1 then Str := '-'
        else TextOut(sx(245), sY(32 + m * lh), IntToStr(pg.Grade), c);
        {else for k:=0 to pg.Grade-1 do
           str := str + '*';
        if Length(str) >= 4 then begin
           Font.Color := clYellow;
           TextOut (SX(245), SY(32 + m*lh), str);
        end else
           TextOut (SX(245), SY(32 + m*lh), str);}
      end;
    end else begin
      TextOut(sx(19), sY(11), 'Custody list');
      TextOut(sx(156), sY(11), 'Durability');
      TextOut(sx(245), sY(11), '');
      lh := LISTLINEHEIGHT;
      menuline := _MIN(MAXMENU, MenuList.Count - MenuTop);
      //惑前 府胶飘
      for I := MenuTop to MenuTop + menuline - 1 do begin
        m := I - MenuTop;
        if I = menuindex then begin
          c := clRed;
          TextOut(sx(12), sY(32 + m * lh), Char(7), c);
        end else c := clWhite;
        pg := PTClientGoods(MenuList[I]);
        TextOut(sx(19), sY(32 + m * lh), pg.Name, c);
        if pg.SubMenu >= 1 then
          TextOut(sx(137), sY(32 + m * lh), #31, c);
        TextOut(sx(156), sY(32 + m * lh), IntToStr(pg.Stock) + '/' + IntToStr(pg.Grade), c);
      end;
    end;
  end;
end;

procedure TFrmDlg.DMenuDlgClick(Sender: TObject; X, Y: Integer);
var
  lx, ly, Idx: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;
begin
  DScreen.ClearHint;
  lx := DMenuDlg.LocalX(X) - DMenuDlg.Left;
  ly := DMenuDlg.LocalY(Y) - DMenuDlg.Top;
  if (lx >= 14) and (lx <= 279) and (ly >= 32) then begin
    Idx := (ly - 32) div LISTLINEHEIGHT + MenuTop;
    if Idx < MenuList.Count then begin
      PlaySound(s_glass_button_click);
      menuindex := Idx;
    end;
  end;

  if BoStorageMenu then begin
    if (menuindex >= 0) and (menuindex < g_SaveItemList.Count) then begin
      g_MouseItem := pTClientItem(g_SaveItemList[menuindex])^;
      GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
      if HintList.Count > 0 then begin
        lx := 240;
        ly := 32 + (menuindex - MenuTop) * LISTLINEHEIGHT;
        with Sender as TDButton do
          DScreen.ShowHint(DMenuDlg.SurfaceX(Left + lx),
            DMenuDlg.SurfaceY(Top + ly),
            HintList, False);
      end;
      g_MouseItem.s.Name := '';
    end;
  end else begin
    if (menuindex >= 0) and (menuindex < g_MenuItemList.Count) and (PTClientGoods(MenuList[menuindex]).SubMenu = 0) then begin
      g_MouseItem := pTClientItem(g_MenuItemList[menuindex])^;
      BoNoDisplayMaxDura := True;
      GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
      BoNoDisplayMaxDura := False;
      if HintList.Count > 0 then begin
        lx := 240;
        ly := 32 + (menuindex - MenuTop) * LISTLINEHEIGHT;
        with Sender as TDButton do
          DScreen.ShowHint(DMenuDlg.SurfaceX(Left + lx),
            DMenuDlg.SurfaceY(Top + ly),
            HintList, False);
      end;
      g_MouseItem.s.Name := '';
    end;
  end;
end;

procedure TFrmDlg.DMenuDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  with DMenuDlg do
    if (X < SurfaceX(Left + 10)) or (X > SurfaceX(Left + Width - 20)) or (Y < SurfaceY(Top + 30)) or (Y > SurfaceY(Top + Height - 50)) then begin
      DScreen.ClearHint;
    end;
end;

procedure TFrmDlg.DMenuBuyClick(Sender: TObject; X, Y: Integer);
var
  pg: PTClientGoods;
begin
  if GetTickCount < LastestClickTime then Exit; //努腐阑 磊林 给窍霸 力茄
  if (menuindex >= 0) and (menuindex < MenuList.Count) then begin
    pg := PTClientGoods(MenuList[menuindex]);
    LastestClickTime := GetTickCount + 5000;
    if pg.SubMenu > 0 then begin
      frmMain.SendGetDetailItem(g_nCurMerchant, 0, pg.Name);
      MenuTopLine := 0;
      CurDetailItem := pg.Name;
    end else begin
      if BoStorageMenu then begin
        frmMain.SendTakeBackStorageItem(g_nCurMerchant, pg.Price {MakeIndex}, pg.Name);
        Exit;
      end;
      if BoMakeDrugMenu then begin
        frmMain.SendMakeDrugItem(g_nCurMerchant, pg.Name);
        Exit;
      end;
      frmMain.SendBuyItem(g_nCurMerchant, pg.Stock, pg.Name)
    end;
  end;
end;

procedure TFrmDlg.DMenuPrevClick(Sender: TObject; X, Y: Integer);
begin
  if not BoDetailMenu then begin
    if MenuTop > 0 then Dec(MenuTop, MAXMENU - 1);
    if MenuTop < 0 then MenuTop := 0;
  end else begin
    if MenuTopLine > 0 then begin
      MenuTopLine := _MAX(0, MenuTopLine - 10);
      frmMain.SendGetDetailItem(g_nCurMerchant, MenuTopLine, CurDetailItem);
    end;
  end;
end;

procedure TFrmDlg.DMenuNextClick(Sender: TObject; X, Y: Integer);
begin
  if not BoDetailMenu then begin
    if MenuTop + MAXMENU < MenuList.Count then Inc(MenuTop, MAXMENU - 1);
  end else begin
    MenuTopLine := MenuTopLine + 10;
    frmMain.SendGetDetailItem(g_nCurMerchant, MenuTopLine, CurDetailItem);
  end;
end;

procedure TFrmDlg.SoldOutGoods(itemserverindex: Integer);
var
  I: Integer;
  pg: PTClientGoods;
begin
  for I := 0 to MenuList.Count - 1 do begin
    pg := PTClientGoods(MenuList[I]);
    if (pg.Grade >= 0) and (pg.Stock = itemserverindex) then begin
      Dispose(pg);
      MenuList.Delete(I);
      if I < g_MenuItemList.Count then g_MenuItemList.Delete(I);
      if menuindex > MenuList.Count - 1 then menuindex := MenuList.Count - 1;
      Break;
    end;
  end;
end;

procedure TFrmDlg.DelStorageItem(itemserverindex: Integer);
var
  I: Integer;
  pg: PTClientGoods;
begin
  for I := 0 to MenuList.Count - 1 do begin
    pg := PTClientGoods(MenuList[I]);
    if (pg.Price = itemserverindex) then begin //焊包格废牢版款 Price = ItemServerIndex烙.
      Dispose(pg);
      MenuList.Delete(I);
      if I < g_SaveItemList.Count then g_SaveItemList.Delete(I);
      if menuindex > MenuList.Count - 1 then menuindex := MenuList.Count - 1;
      Break;
    end;
  end;
end;

procedure TFrmDlg.DMenuCloseClick(Sender: TObject; X, Y: Integer);
begin
  DMenuDlg.Visible := False;
end;

procedure TFrmDlg.DMerchantDlgMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SelectMenuStr := '';
end;

procedure TFrmDlg.DSellDlgDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  actionname: string;
begin
  with DSellDlg do begin
    d := nil;
    if DMenuDlg.WLib <> nil then
      d := DMenuDlg.WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);

    with dsurface do begin
      actionname := '';
      case SpotDlgMode of
        dmSell: actionname := 'Sell: ';
        dmRepair: actionname := 'Repair: ';
        dmStorage: actionname := 'Store';
        dmSellOff: actionname := '寄售物品: ';
        dmChange: actionname := '修改物品: ';
      end;
      if SpotDlgMode = dmSellOff then begin
        TextOut(SurfaceX(Left + 8), SurfaceY(Top + 6), actionname + g_sSellPriceStr + ' ' + g_sGameGoldName);
      end else begin
        TextOut(SurfaceX(Left + 8), SurfaceY(Top + 6), actionname + g_sSellPriceStr);
      end;
    end;
  end;
end;

procedure TFrmDlg.DSellDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
  CloseDSellDlg;
end;

procedure TFrmDlg.DSellDlgSpotClick(Sender: TObject; X, Y: Integer);
var
  temp: TClientItem;
  sSellPriceStr: string;
begin
  g_sSellPriceStr := '';
  if not g_boItemMoving then begin
    if g_SellDlgItem.s.Name <> '' then begin
      ItemClickSound(g_SellDlgItem.s);
      g_boItemMoving := True;
      g_MovingItem.Index := -99; //sell
      g_MovingItem.Item := g_SellDlgItem;
      g_SellDlgItem.s.Name := '';
    end;
  end else begin
    if (g_MovingItem.Owner = DHeroItemBag) or (g_MovingItem.Owner = DHeroStateWin) then Exit;
    if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then Exit;
    if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then begin
      ItemClickSound(g_MovingItem.Item.s);
      if g_SellDlgItem.s.Name <> '' then begin
        temp := g_SellDlgItem;
        g_SellDlgItem := g_MovingItem.Item;
        g_MovingItem.Index := -99; //sell
        g_MovingItem.Item := temp;
        if SpotDlgMode = dmChange then begin
          g_sSellPriceStr := g_SellDlgItem.s.Name;
          frmMain.SendChangeItem(g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.s.Name);
        end;
      end else begin
        g_SellDlgItem := g_MovingItem.Item;
        g_MovingItem.Item.s.Name := '';
        g_boItemMoving := False;
        if SpotDlgMode = dmSellOff then begin
          DMessageDlg('Enter selling price：', [mbOk, mbAbort]);
          g_sSellPriceStr := IntToStr(Str_ToInt(Trim(DlgEditText), -1));
          {if StrToInt(g_sSellPriceStr) < 0 then begin
            g_MovingItem.Item := g_SellDlgItem;
            g_SellDlgItem.S.Name := '';
            g_boItemMoving := True;
          end; }
        end else
          if SpotDlgMode = dmChange then begin
          g_sSellPriceStr := g_SellDlgItem.s.Name;
          frmMain.SendChangeItem(g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.s.Name);
        end;
      end;
      g_boQueryPrice := True;
      g_dwQueryPriceTime := GetTickCount;
    end;
  end;

end;

procedure TFrmDlg.DSellDlgSpotDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  if g_SellDlgItem.s.Name <> '' then begin
    d := g_WBagItemImages.Images[g_SellDlgItem.s.looks];
    if d <> nil then
      with DSellDlgSpot do
        dsurface.Draw(SurfaceX(Left + (Width - d.Width) div 2),
          SurfaceY(Top + (Height - d.Height) div 2),
          d.ClientRect,
          d, True);
  end;
end;

procedure TFrmDlg.DSellDlgSpotMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  iname, d1, d2, d3: string;
  useable: Boolean;
begin
  g_MouseItem := g_SellDlgItem;
  if g_MouseItem.s.Name <> '' then begin
    GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
    if HintList.Count > 0 then begin
      with DSellDlgSpot do
        DScreen.ShowHint(SurfaceX(Left),
          SurfaceY(Top),
          HintList, False);
    end;
  end;
end;

procedure TFrmDlg.DSellDlgOkClick(Sender: TObject; X, Y: Integer);
begin
  if (g_SellDlgItem.s.Name = '') and (g_SellDlgItemSellWait.s.Name = '') then Exit;
  if GetTickCount < LastestClickTime then Exit;
  case SpotDlgMode of
    dmSell: frmMain.SendSellItem(g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.s.Name);
    dmRepair: frmMain.SendRepairItem(g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.s.Name);
    dmStorage: frmMain.SendStorageItem(g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.s.Name);
    dmSellOff: begin
        if StrToInt(g_sSellPriceStr) < 0 then Exit;
        frmMain.SendSellOffItem(g_nCurMerchant, g_SellDlgItem.MakeIndex, g_sSellPriceStr + '/' + g_SellDlgItem.s.Name);
      end;
    dmChange: frmMain.SendChangeItem(g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.s.Name);
  end;
  if SpotDlgMode <> dmChange then begin //DSellDlg.Visible := False;
    g_SellDlgItemSellWait := g_SellDlgItem;
    g_SellDlgItem.s.Name := '';
    g_sSellPriceStr := '';
  end;
  LastestClickTime := GetTickCount + 5000;
end;





{------------------------------------------------------------------------}

//Magic

{------------------------------------------------------------------------}


procedure TFrmDlg.SetMagicKeyDlg(icon: Integer; magname: string; var curkey: Word);
begin
  MagKeyIcon := icon;
  MagKeyMagName := magname;
  MagKeyCurKey := curkey;


  DKeySelDlg.Left := (SCREENWIDTH - DKeySelDlg.Width) div 2;
  DKeySelDlg.Top := (SCREENHEIGHT - DKeySelDlg.Height) div 2;
  HideAllControls;
  DKeySelDlg.ShowModal;

  while True do begin
    if not DKeySelDlg.Visible then Break;
    //FrmMain.DXTimerTimer (self, 0);
    frmMain.ProcOnIdle;
    Application.ProcessMessages;
    if Application.Terminated then Exit;
    Sleep(1);
  end;

  RestoreHideControls;
  curkey := MagKeyCurKey;
end;

procedure TFrmDlg.DKeySelDlgDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with DKeySelDlg do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    //魔法快捷键
    with dsurface do begin
      TextOut(SurfaceX(Left + 95), SurfaceY(Top + 38), MagKeyMagName + ' 快捷键', clSilver);
    end;
  end;
end;

procedure TFrmDlg.DKsIconDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with DKsIcon do begin
    d := g_WMagIconImages.Images[MagKeyIcon];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
  end;
end;

procedure TFrmDlg.DKsF1DirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  b: TDButton;
  d: TTexture;
begin
  b := nil;
  case MagKeyCurKey of
    Word('1'): b := DKsF1;
    Word('2'): b := DKsF2;
    Word('3'): b := DKsF3;
    Word('4'): b := DKsF4;
    Word('5'): b := DKsF5;
    Word('6'): b := DKsF6;
    Word('7'): b := DKsF7;
    Word('8'): b := DKsF8;
    Word('E'): b := DKsConF1;
    Word('F'): b := DKsConF2;
    Word('G'): b := DKsConF3;
    Word('H'): b := DKsConF4;
    Word('I'): b := DKsConF5;
    Word('J'): b := DKsConF6;
    Word('K'): b := DKsConF7;
    Word('L'): b := DKsConF8;
  else b := DKsNone;
  end;
  {case MagKeyCurKey of
    Word('1'): b := DKsF1;
    Word('2'): b := DKsF2;
    Word('3'): b := DKsF3;
    Word('4'): b := DKsF4;
    Word('5'): b := DKsF5;
    Word('6'): b := DKsF6;
    Word('7'): b := DKsF7;
    Word('8'): b := DKsF8;
  else b := DKsNone;
  end;}
  if b = Sender then begin
    with b do begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex + 1];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
  with Sender as TDButton do begin
    if Downed then begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DKsOkClick(Sender: TObject; X, Y: Integer);
begin
  DKeySelDlg.Visible := False;
end;

procedure TFrmDlg.DKsF1Click(Sender: TObject; X, Y: Integer);
begin
  if Sender = DKsF1 then MagKeyCurKey := Integer('1');
  if Sender = DKsF2 then MagKeyCurKey := Integer('2');
  if Sender = DKsF3 then MagKeyCurKey := Integer('3');
  if Sender = DKsF4 then MagKeyCurKey := Integer('4');
  if Sender = DKsF5 then MagKeyCurKey := Integer('5');
  if Sender = DKsF6 then MagKeyCurKey := Integer('6');
  if Sender = DKsF7 then MagKeyCurKey := Integer('7');
  if Sender = DKsF8 then MagKeyCurKey := Integer('8');
  if Sender = DKsConF1 then MagKeyCurKey := Integer('E');
  if Sender = DKsConF2 then MagKeyCurKey := Integer('F');
  if Sender = DKsConF3 then MagKeyCurKey := Integer('G');
  if Sender = DKsConF4 then MagKeyCurKey := Integer('H');
  if Sender = DKsConF5 then MagKeyCurKey := Integer('I');
  if Sender = DKsConF6 then MagKeyCurKey := Integer('J');
  if Sender = DKsConF7 then MagKeyCurKey := Integer('K');
  if Sender = DKsConF8 then MagKeyCurKey := Integer('L');
  if Sender = DKsNone then MagKeyCurKey := 0;
end;
{------------------------------------------------------------------------}

//Panel Buttons
{------------------------------------------------------------------------}


procedure TFrmDlg.DBotMiniMapClick(Sender: TObject; X, Y: Integer);
begin
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
  DMiniMap.Visible := g_boViewMiniMap;
  if not DMiniMap.Visible then begin
    DMiniMap.Width := DMapTitle.Width;
    DMiniMap.Height := 120;
  end;
end;

procedure TFrmDlg.DBotTradeClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount > g_dwQueryMsgTick then begin
    g_dwQueryMsgTick := GetTickCount + 3000;
    frmMain.SendDealTry;
  end;
end;

procedure TFrmDlg.DBotGuildClick(Sender: TObject; X, Y: Integer);
begin
  if DGuildDlg.Visible then begin
    DGuildDlg.Visible := False;
  end else
    if GetTickCount > g_dwQueryMsgTick then begin
    g_dwQueryMsgTick := GetTickCount + 3000;
    frmMain.SendGuildDlg;
  end;
end;

procedure TFrmDlg.DBotGroupClick(Sender: TObject; X, Y: Integer);
begin
  ToggleShowGroupDlg;
end;


{------------------------------------------------------------------------}

//Group

{------------------------------------------------------------------------}

procedure TFrmDlg.ToggleShowGroupDlg;
begin
  DGroupDlg.Visible := not DGroupDlg.Visible;
end;

procedure TFrmDlg.DGroupDlgDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  lx, ly, n: Integer;
begin
  with DGroupDlg do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    if g_GroupMembers.Count > 0 then begin
      with dsurface do begin
        lx := SurfaceX(28) + Left;
        ly := SurfaceY(80) + Top;
        TextOut(lx, ly, g_GroupMembers[0], clSilver);
        for n := 1 to g_GroupMembers.Count - 1 do begin
          lx := SurfaceX(28) + Left + ((n - 1) mod 2) * 100;
          ly := SurfaceY(80 + 16) + Top + ((n - 1) div 2) * 16;
          TextOut(lx, ly, g_GroupMembers[n], clSilver);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DGrpDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
  DGroupDlg.Visible := False;
end;

procedure TFrmDlg.DGrpAllowGroupDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    if Downed then begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex - 1];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end else begin
      if g_boAllowGroup then begin
        d := nil;
        if WLib <> nil then
          d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DGrpAllowGroupClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount > g_dwChangeGroupModeTick then begin
    g_boAllowGroup := not g_boAllowGroup;
    g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5檬
    frmMain.SendGroupMode(g_boAllowGroup);
  end;
end;

procedure TFrmDlg.DGrpCreateClick(Sender: TObject; X, Y: Integer);
var
  who: string;
begin
  if (GetTickCount > g_dwChangeGroupModeTick) and (g_GroupMembers.Count = 0) then begin
    DialogSize := 1;
    DMessageDlg('Input the name of the player you wish to group.', [mbOk, mbAbort]);
    who := Trim(DlgEditText);
    if who <> '' then begin
      g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5檬
      frmMain.SendCreateGroup(Trim(DlgEditText));
    end;
  end;
end;

procedure TFrmDlg.DGrpAddMemClick(Sender: TObject; X, Y: Integer);
var
  who: string;
begin
  if (GetTickCount > g_dwChangeGroupModeTick) and (g_GroupMembers.Count > 0) then begin
    DialogSize := 1;
    DMessageDlg('Input the name of the player you wish to group.', [mbOk, mbAbort]);
    who := Trim(DlgEditText);
    if who <> '' then begin
      g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5檬
      frmMain.SendAddGroupMember(Trim(DlgEditText));
    end;
  end;
end;

procedure TFrmDlg.DGrpDelMemClick(Sender: TObject; X, Y: Integer);
var
  who: string;
begin
  if (GetTickCount > g_dwChangeGroupModeTick) and (g_GroupMembers.Count > 0) then begin
    DialogSize := 1;
    DMessageDlg('Input the name of the player you wish to delete.', [mbOk, mbAbort]);
    who := Trim(DlgEditText);
    if who <> '' then begin
      g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5檬
      frmMain.SendDelGroupMember(Trim(DlgEditText));
    end;
  end;
end;

procedure TFrmDlg.DBotLogoutClick(Sender: TObject; X, Y: Integer);
begin
  //强行退出
  g_dwLatestStruckTick := GetTickCount() + 10001;
  g_dwLatestMagicTick := GetTickCount() + 10001;
  g_dwLatestHitTick := GetTickCount() + 10001;
  //
  if (GetTickCount - g_dwLatestStruckTick > 10000) and
    (GetTickCount - g_dwLatestMagicTick > 10000) and
    (GetTickCount - g_dwLatestHitTick > 10000) or
    (g_MySelf.m_boDeath) then begin
    frmMain.AppLogout;
  end else
    DScreen.AddChatBoardString('You cannot log out during Battle.', clyellow, clRed);
end;

procedure TFrmDlg.DBotExitClick(Sender: TObject; X, Y: Integer);
begin
  //强行退出
  g_dwLatestStruckTick := GetTickCount() + 10001;
  g_dwLatestMagicTick := GetTickCount() + 10001;
  g_dwLatestHitTick := GetTickCount() + 10001;
  //
  if (GetTickCount - g_dwLatestStruckTick > 10000) and
    (GetTickCount - g_dwLatestMagicTick > 10000) and
    (GetTickCount - g_dwLatestHitTick > 10000) or
    (g_MySelf.m_boDeath) then begin
    //frmMain.AppExit;
    frmMain.Close;
  end else
    DScreen.AddChatBoardString('You cannot Exit the game during Battle.', clyellow, clRed);
end;

procedure TFrmDlg.DBotPlusAbilClick(Sender: TObject; X, Y: Integer);
begin
  if g_nBonusPoint > 0 then
    FrmDlg.OpenAdjustAbility;
end;


{------------------------------------------------------------------------}

//背券 促捞倔肺弊

{------------------------------------------------------------------------}


procedure TFrmDlg.OpenDealDlg;
var
  d: TTexture;
begin
  DDealRemoteDlg.Left := SCREENWIDTH - 236 - 100;
  DDealRemoteDlg.Top := 0;
  DDealDlg.Left := SCREENWIDTH - 236 - 100;
  DDealDlg.Top := DDealRemoteDlg.Height - 15;
  DItemBag.Left := 0; //475;
  DItemBag.Top := 80;
  DItemBag.Visible := True;
  DDealDlg.Visible := True;
  DDealRemoteDlg.Visible := True;

  SafeFillChar(g_DealItems, SizeOf(TClientItem) * 10, #0);
  SafeFillChar(g_DealRemoteItems, SizeOf(TClientItem) * 20, #0);
  g_nDealGold := 0;
  g_nDealRemoteGold := 0;
  g_boDealEnd := False;

  //酒捞袍 啊规俊 儡惑捞 乐绰瘤 八荤
  ArrangeItemBag;
end;

procedure TFrmDlg.CloseDealDlg;
begin
  DDealDlg.Visible := False;
  DDealRemoteDlg.Visible := False;

  //酒捞袍 啊规俊 儡惑捞 乐绰瘤 八荤
  ArrangeItemBag;
end;

procedure TFrmDlg.DDealOkClick(Sender: TObject; X, Y: Integer);
var
  mi: Integer;
begin
  if GetTickCount > g_dwDealActionTick then begin
    //CloseDealDlg;
    frmMain.SendDealEnd;
    g_dwDealActionTick := GetTickCount + 4000;
    g_boDealEnd := True;
    //掉 芒俊辑 付快胶肺 缠绊 乐绰 巴阑 掉芒栏肺 持绰促. 付快胶俊 巢绰 儡惑(汗荤)阑 绝矩促.
    if g_boItemMoving then begin
      mi := g_MovingItem.Index;
      if (mi <= -20) and (mi > -30) then begin //掉 芒俊辑 柯巴父
        AddDealItem(g_MovingItem.Item);
        g_boItemMoving := False;
        g_MovingItem.Item.s.Name := '';
      end;
    end;
  end;
end;

procedure TFrmDlg.DDealCloseClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount > g_dwDealActionTick then begin
    CloseDealDlg;
    frmMain.SendCancelDeal;
  end;
end;

procedure TFrmDlg.DDealRemoteDlgDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with DDealRemoteDlg do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    with dsurface do begin
      TextOut(SurfaceX(Left + 64), SurfaceY(Top + 196 - 65), GetGoldStr(g_nDealRemoteGold));
      TextOut(SurfaceX(Left + 59 + (106 - TextWidth(g_sDealWho)) div 2), SurfaceY(Top + 3) + 3, g_sDealWho);
    end;
  end;
end;

procedure TFrmDlg.DDealDlgDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with DDealDlg do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    with dsurface do begin
      TextOut(SurfaceX(Left + 64), SurfaceY(Top + 196 - 65), GetGoldStr(g_nDealGold));
      TextOut(SurfaceX(Left + 59 + (106 - TextWidth(g_sSelChrName)) div 2), SurfaceY(Top + 3) + 3, g_sSelChrName);
    end;
  end;
end;

procedure TFrmDlg.DealItemReturnBag(mitem: TClientItem);
begin
  if not g_boDealEnd then begin
    g_DealDlgItem := mitem;
    frmMain.SendDelDealItem(g_DealDlgItem);
    g_dwDealActionTick := GetTickCount + 4000;
  end;
end;

procedure TFrmDlg.DuelItemReturnBag(mitem: TClientItem);
begin
  if not g_boDuelEnd then begin
    g_DuelDlgItem := mitem;
    frmMain.SendDelDuelItem(g_DuelDlgItem);
    g_dwDuelActionTick := GetTickCount + 4000;
  end;
end;

procedure TFrmDlg.DDGridGridSelect(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
  temp: TClientItem;
  mi, Idx: Integer;
begin
  if not g_boDealEnd and (GetTickCount > g_dwDealActionTick) then begin
    if not g_boItemMoving then begin
      Idx := ACol + ARow * DDGrid.ColCount;
      if Idx in [0..9] then begin
        ClearMoveRect();
        if g_DealItems[Idx].s.Name <> '' then begin
          g_boItemMoving := True;
          g_MovingItem.Owner := DDealDlg;
          g_MovingItem.Index := -Idx - 20;
          g_MovingItem.Item := g_DealItems[Idx];
          g_DealItems[Idx].s.Name := '';
          ItemClickSound(g_MovingItem.Item.s);
        end;
      end;
    end else begin
      if (g_MovingItem.Owner = DHeroItemBag) or (g_MovingItem.Owner = DStateWin) or (g_MovingItem.Owner = DHeroStateWin) then Exit;
      mi := g_MovingItem.Index;
      if (g_MovingItem.Owner = DItemBag) or (g_MovingItem.Owner = DUpgrade) then begin
        if (mi >= 0) or (mi <= -20) and (mi > -30) then begin
          ItemClickSound(g_MovingItem.Item.s);
          g_boItemMoving := False;
          if mi >= 0 then begin
            g_DealDlgItem := g_MovingItem.Item;
            frmMain.SendAddDealItem(g_DealDlgItem);
            g_dwDealActionTick := GetTickCount + 4000;
          end else
            AddDealItem(g_MovingItem.Item);
          g_MovingItem.Item.s.Name := '';
          g_MovingItem.Owner := nil;
        end;
        if mi = -98 then DDGoldClick(Self, 0, 0);
      end;
    end;
    ArrangeItemBag;
  end;
end;

procedure TFrmDlg.DDGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TTexture);
var
  nIdx: Integer;
  d: TTexture;
begin
  nIdx := ACol + ARow * DDGrid.ColCount;
  if nIdx in [0..9] then begin
    if g_DealItems[nIdx].s.Name <> '' then begin
      d := g_WBagItemImages.Images[g_DealItems[nIdx].s.looks];
      if d <> nil then
        with DDGrid do begin
          dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
            d.ClientRect,
            d, True);
        end;
      with DDGrid do begin
        if (g_DealItems[nIdx].s.AddValue[12] in [1, 3]) {or (GetAddPoint(g_DealItems[nIdx].s.AddPoint))} then begin
          if GetTickCount - g_DrawDealItems[nIdx].dwDrawTick >= 200 then begin
            g_DrawDealItems[nIdx].dwDrawTick := GetTickCount;
            if g_DrawDealItems[nIdx].nIndex <= 0 then g_DrawDealItems[nIdx].nIndex := 260 - 1;
            Inc(g_DrawDealItems[nIdx].nIndex);
            if g_DrawDealItems[nIdx].nIndex > 265 then g_DrawDealItems[nIdx].nIndex := 260;
          end;
          d := g_WMain2Images.Images[g_DrawDealItems[nIdx].nIndex];
          if d <> nil then begin
            DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1), d);
          end;
        end;

        if g_DealItems[nIdx].s.AddValue[12] >= 2 then begin
          if GetTickCount - g_DrawDealItems_[nIdx].dwDrawTick >= 200 then begin
            g_DrawDealItems_[nIdx].dwDrawTick := GetTickCount;
            if g_DrawDealItems_[nIdx].nIndex <= 0 then g_DrawDealItems_[nIdx].nIndex := 600 - 1;
            Inc(g_DrawDealItems_[nIdx].nIndex);
            if g_DrawDealItems_[nIdx].nIndex > 617 then g_DrawDealItems_[nIdx].nIndex := 600;
          end;
          d := g_WMain3Images.Images[g_DrawDealItems_[nIdx].nIndex];
          if d <> nil then begin
            DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1), d);
          end;
        end;

      end;
    end;
  end;
end;

procedure TFrmDlg.DDGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
  nIdx: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;

  nWhere: Integer;
  List: TStringList;
begin
  DScreen.ClearHint;
  nIdx := ACol + ARow * DDGrid.ColCount;
  if nIdx in [0..9] then begin
    g_MoveRect := DDGrid.ClientRect;
    g_MouseItem := g_DealItems[nIdx];

    if g_MouseItem.s.Name <> '' then begin
      nWhere := GetHumUseItemByBagItem(g_MouseItem.s.StdMode);
      if g_Config.boCompareItem and (nWhere >= 0) then begin

        List := TStringList.Create;
        try
          GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
          List.AddStrings(HintList);

          GetMouseItemInfo(g_MySelf, @g_UseItems[nWhere], iname, d1, d2, d3, useable);
          if HintList.Count > 0 then begin
            HintList.Strings[0] := GetUseItemName(nWhere) + ' ' + HintList.Strings[0];
          end;
          with DDGrid do
            DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
              SurfaceY(Top + (ARow + 1) * RowHeight),
              List, HintList, False);
          HintList.Clear;
        finally
          List.Free;
        end;
        g_MouseItem.s.Name := '';
      end else begin
        GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
        with DDGrid do
          DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
            SurfaceY(Top + (ARow + 1) * RowHeight),
            HintList, False);
      end;

    end;

    {if g_MouseItem.s.Name <> '' then begin
      GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
      with DDGrid do
        DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
          SurfaceY(Top + (ARow + 1) * RowHeight),
          HintList, False);
    end;}
  end;
end;

procedure TFrmDlg.DDRGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TTexture);
var
  nIdx: Integer;
  d: TTexture;
begin
  nIdx := ACol + ARow * DDRGrid.ColCount;
  if nIdx in [0..19] then begin
    if g_DealRemoteItems[nIdx].s.Name <> '' then begin
      d := g_WBagItemImages.Images[g_DealRemoteItems[nIdx].s.looks];
      if d <> nil then
        with DDRGrid do begin
          dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
            d.ClientRect,
            d, True);
        end;
      with DDRGrid do begin
        if (g_DealRemoteItems[nIdx].s.AddValue[12] in [1, 3]) {or (GetAddPoint(g_DealRemoteItems[nIdx].s.AddPoint))} then begin
          if GetTickCount - g_DrawDealRemoteItems[nIdx].dwDrawTick >= 200 then begin
            g_DrawDealRemoteItems[nIdx].dwDrawTick := GetTickCount;
            if g_DrawDealRemoteItems[nIdx].nIndex <= 0 then g_DrawDealRemoteItems[nIdx].nIndex := 260 - 1;
            Inc(g_DrawDealRemoteItems[nIdx].nIndex);
            if g_DrawDealRemoteItems[nIdx].nIndex > 265 then g_DrawDealRemoteItems[nIdx].nIndex := 260;
          end;
          d := g_WMain2Images.Images[g_DrawDealRemoteItems[nIdx].nIndex];
          if d <> nil then begin
            DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1), d);
          end;
        end;

        if g_DealRemoteItems[nIdx].s.AddValue[12] >= 2 then begin
          if GetTickCount - g_DrawDealRemoteItems_[nIdx].dwDrawTick >= 200 then begin
            g_DrawDealRemoteItems_[nIdx].dwDrawTick := GetTickCount;
            if g_DrawDealRemoteItems_[nIdx].nIndex <= 0 then g_DrawDealRemoteItems_[nIdx].nIndex := 600 - 1;
            Inc(g_DrawDealRemoteItems_[nIdx].nIndex);
            if g_DrawDealRemoteItems_[nIdx].nIndex > 617 then g_DrawDealRemoteItems_[nIdx].nIndex := 600;
          end;
          d := g_WMain3Images.Images[g_DrawDealRemoteItems_[nIdx].nIndex];
          if d <> nil then begin
            DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1), d);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DDRGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  nIdx: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;

  nWhere: Integer;
  List: TStringList;
begin
  DScreen.ClearHint;
  nIdx := ACol + ARow * DDRGrid.ColCount;
  if nIdx in [0..19] then begin
    g_MouseItem := g_DealRemoteItems[nIdx];

    if g_MouseItem.s.Name <> '' then begin
      nWhere := GetHumUseItemByBagItem(g_MouseItem.s.StdMode);
      if g_Config.boCompareItem and (nWhere >= 0) then begin

        List := TStringList.Create;
        try
          GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
          List.AddStrings(HintList);

          GetMouseItemInfo(g_MySelf, @g_UseItems[nWhere], iname, d1, d2, d3, useable);
          if HintList.Count > 0 then begin
            HintList.Strings[0] := GetUseItemName(nWhere) + ' ' + HintList.Strings[0];
          end;
          with DDRGrid do
            DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
              SurfaceY(Top + (ARow + 1) * RowHeight),
              List, HintList, False);
          HintList.Clear;
        finally
          List.Free;
        end;
        g_MouseItem.s.Name := '';
      end else begin
        GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
        with DDRGrid do
          DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
            SurfaceY(Top + (ARow + 1) * RowHeight),
            HintList, False);
      end;

    end;
    {if g_MouseItem.s.Name <> '' then begin
      GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
      with DDRGrid do
        DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
          SurfaceY(Top + (ARow + 1) * RowHeight),
          HintList, False);
    end;}
  end;
end;

procedure TFrmDlg.DealZeroGold;
begin
  if not g_boDealEnd and (g_nDealGold > 0) then begin
    g_dwDealActionTick := GetTickCount + 4000;
    frmMain.SendChangeDealGold(0);
  end;
end;

procedure TFrmDlg.DDGoldClick(Sender: TObject; X, Y: Integer);
var
  DGold: Integer;
  valstr: string;
begin
  if g_MySelf = nil then Exit;
  if not g_boDealEnd and (GetTickCount > g_dwDealActionTick) then begin
    if not g_boItemMoving then begin
      if g_nDealGold > 0 then begin
        PlaySound(s_money);
        g_boItemMoving := True;
        g_MovingItem.Index := -97; //背券 芒俊辑狼 捣
        g_MovingItem.Item.s.Name := g_sGoldName {'金币'};
      end;
    end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then begin //捣父..
        if (g_MovingItem.Index = -98) then begin //啊规芒俊辑 柯 捣
          if g_MovingItem.Item.s.Name = g_sGoldName {'金币'} then begin
            //倔付甫 滚副 扒瘤 拱绢夯促.
            DialogSize := 1;
            g_boItemMoving := False;
            g_MovingItem.Item.s.Name := '';
            DMessageDlg('Enter amount of ' + g_sGoldName, [mbOk, mbAbort]);
            GetValidStrVal(DlgEditText, valstr, [' ']);
            DGold := Str_ToInt(valstr, 0);
            if (DGold <= (g_nDealGold + g_MySelf.m_nGold)) and (DGold > 0) then begin
              frmMain.SendChangeDealGold(DGold);
              g_dwDealActionTick := GetTickCount + 4000;
            end else
              DGold := 0;
          end;
        end;
        g_boItemMoving := False;
        g_MovingItem.Item.s.Name := '';
      end;
    end;
  end;
end;



{--------------------------------------------------------------}


procedure TFrmDlg.DUserState1DirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  I, L, m, pgidx, bbx, bby, Idx, ax, ay: Integer;
  sex, hair: Byte;
  d: TTexture;
  hcolor, keyimg, old: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;
begin
  with DUserState1 do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);

    sex := DRESSfeature(UserState1.feature) mod 2;
    hair := HAIRfeature(UserState1.feature); //?
    hair := (hair - sex) div 2;
    if sex = 1 then pgidx := 30 //377 Mars 修改
    else pgidx := 29; //376 Mars 修改
    bbx := Left + 38;
    bby := Top + 52;
    d := g_WMain3Images.Images[pgidx]; //Mars 修改
    if d <> nil then
      dsurface.Draw(SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, False);
    bbx := bbx - 7;
    bby := bby + 44;
    Idx := 440 + hair;
    //显示发型
   // idx := 440 + hair div 2;
    Idx := 440 + hair;
    //if sex = 1 then idx := 480 + hair div 2;
    if Idx > 0 then begin
      d := g_WMainImages.GetCachedImage(Idx, ax, ay);
      if d <> nil then
        dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
    end;
    if UserState1.UseItems[U_DRESS].s.Name <> '' then begin
      Idx := UserState1.UseItems[U_DRESS].s.looks;
      if Idx >= 0 then begin
        //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
        d := GetWStateImg(Idx, ax, ay);
        if d <> nil then
          dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
      end;
    end;
    if UserState1.UseItems[U_WEAPON].s.Name <> '' then begin
      Idx := UserState1.UseItems[U_WEAPON].s.looks;
      if Idx >= 0 then begin
        //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
        d := GetWStateImg(Idx, ax, ay);
        if d <> nil then
          dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);

        if (UserState1.UseItems[U_WEAPON].s.Shape = 38) and (Idx = 1404) then begin
          d := GetWStateImg(Idx - 1, ax, ay);
          if d <> nil then
            DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d);
        end else
          if (UserState1.UseItems[U_WEAPON].s.Shape = 56) and (Idx = 1880) then begin
          if (g_dwWeapon56Index[2] < 1890) or (g_dwWeapon56Index[2] > 1899) then
            g_dwWeapon56Index[2] := 1890;
          if GetTickCount - g_dwWeapon56Tick[2] > 100 then begin
            g_dwWeapon56Tick[2] := GetTickCount;
            g_dwWeapon56Index[2] := g_dwWeapon56Index[2] + 1;
          end;
          if (g_dwWeapon56Index[2] < 1890) or (g_dwWeapon56Index[2] > 1899) then
            g_dwWeapon56Index[2] := 1890;

          d := GetWStateImg(g_dwWeapon56Index[2], ax, ay);
          if d <> nil then
            DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d);
        end;
      end;
    end;
    if UserState1.UseItems[U_HELMET].s.Name <> '' then begin
      Idx := UserState1.UseItems[U_HELMET].s.looks;
      if Idx >= 0 then begin
        //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
        d := GetWStateImg(Idx, ax, ay);
        if d <> nil then
          dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
      end;
    end;

    //原为打开，本代码为显示人物身上所带物品信息，显示位置为人物下方
    if (g_ServerConfig.btShowClientItemStyle <> 0) then begin
      if g_MouseUserStateItem.s.Name <> '' then begin
        g_MouseItem := g_MouseUserStateItem;
        GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
        if iname <> '' then begin
          if g_MouseItem.Dura = 0 then hcolor := clRed
          else hcolor := clWhite;
          with dsurface do begin
            old := MainForm.Canvas.Font.Size;
            MainForm.Canvas.Font.Size := 9;
            bbx := SurfaceX(Left + 37);
            bby := SurfaceY(Top + 272 + 35);
            TextOut(bbx, bby, iname, clyellow); //2006-10-24 Mars修改
            TextOut(bbx + TextWidth(iname), bby, d1, hcolor);
            TextOut(bbx, bby + TextHeight('A') + 2, d2, hcolor);
            TextOut(bbx, bby + (TextHeight('A') + 2) * 2, d3, hcolor);

            if d2 <> '' then
              bby := bby + TextHeight('A') + 2;
            if d3 <> '' then
              bby := bby + TextHeight('A') + 2;

            bby := bby + TextHeight('A') + 2;
            for I := 0 to g_ExtractStringList.Count - 1 do begin
              TextOut(bbx, bby + (TextHeight('A') + 2) * I, g_ExtractStringList.Strings[I], hcolor);
            end;
            MainForm.Canvas.Font.Size := old;
          end;
        end;
        g_MouseItem.s.Name := '';
      end;
    end;

    with dsurface do begin
      TextOut(SurfaceX(Left + 122 - TextWidth(UserState1.UserName) div 2),
        SurfaceY(Top + 23), UserState1.UserName, UserState1.NameColor);
      TextOut(SurfaceX(Left + 45), SurfaceY(Top + 58),
        UserState1.GuildName + ' ' + UserState1.GuildRankName, clSilver);
    end;
  end;
end;

procedure TFrmDlg.DUserState1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  X := DUserState1.LocalX(X) - DUserState1.Left;
  Y := DUserState1.LocalY(Y) - DUserState1.Top;
  if (X > 42) and (X < 201) and (Y > 54) and (Y < 71) then begin
    //DScreen.AddSysMsg (IntToStr(X) + ' ' + IntToStr(Y) + ' ' + UserState1.GuildName);
    if UserState1.GuildName <> '' then begin
      SetInputVisible(g_ConfigClient.btMainInterface = 1);
      EdChat.Visible := True;
      EdChat.SetFocus;
      SetImeMode(EdChat.Handle, LocalLanguage);
      EdChat.Text := UserState1.GuildName;
      EdChat.SelStart := Length(EdChat.Text);
      EdChat.SelLength := 0;
    end;
  end;
end;

procedure TFrmDlg.DUserState1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  DScreen.ClearHint;
  g_MouseUserStateItem.s.Name := '';
  g_MouseItem.s.Name := '';
  HintList.Clear;
end;

procedure TFrmDlg.DWeaponUS1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  sel: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;
begin
  sel := -1;
  if Sender = DDressUS1 then sel := U_DRESS;
  if Sender = DWeaponUS1 then sel := U_WEAPON;
  if Sender = DHelmetUS1 then sel := U_HELMET;
  if Sender = DNecklaceUS1 then sel := U_NECKLACE;
  if Sender = DLightUS1 then sel := U_RIGHTHAND;
  if Sender = DRingLUS1 then sel := U_RINGL;
  if Sender = DRingRUS1 then sel := U_RINGR;
  if Sender = DArmringLUS1 then sel := U_ARMRINGL;
  if Sender = DArmringRUS1 then sel := U_ARMRINGR;
  if Sender = DBujukUS1 then sel := U_BUJUK;
  if Sender = DBeltUS1 then sel := U_BELT;
  if Sender = DBootsUS1 then sel := U_BOOTS;
  if Sender = DCharmUS1 then sel := U_CHARM;

  if sel >= 0 then begin
    g_MouseUserStateItem := UserState1.UseItems[sel];
    if (g_ServerConfig.btShowClientItemStyle = 0) then begin
      g_MouseItem := UserState1.UseItems[sel];
    //原为注释掉 显示人物身上带的物品信息
    //GetMouseItemInfo(HintList);
   { with Sender as TDButton do
      DScreen.ShowHint(SurfaceX(Left - 30), SurfaceY(Top + 50), HintList, False);
    }
      GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
      if HintList.Count > 0 then begin
        with Sender as TDButton do
          DScreen.ShowHint(SurfaceX(Left - 30),
            SurfaceY(Top + 50),
            HintList, False);
      end;
      g_MouseItem.s.Name := '';
    end;
  end;
end;

procedure TFrmDlg.DCloseUS1Click(Sender: TObject; X, Y: Integer);
begin
  DUserState1.Visible := False;
end;

procedure TFrmDlg.DNecklaceUS1DirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  Idx: Integer;
  d: TTexture;
  nWhere: Integer;
begin
  nWhere := -1;
  if Sender = DNecklaceUS1 then nWhere := U_NECKLACE;
  if Sender = DLightUS1 then nWhere := U_RIGHTHAND;
  if Sender = DArmringRUS1 then nWhere := U_ARMRINGR;
  if Sender = DArmringLUS1 then nWhere := U_ARMRINGL;
  if Sender = DRingRUS1 then nWhere := U_RINGR;
  if Sender = DRingLUS1 then nWhere := U_RINGL;
  if Sender = DBujukUS1 then nWhere := U_BUJUK;
  if Sender = DBeltUS1 then nWhere := U_BELT;
  if Sender = DBootsUS1 then nWhere := U_BOOTS;
  if Sender = DCharmUS1 then nWhere := U_CHARM;

  if nWhere >= 0 then begin
    if UserState1.UseItems[nWhere].s.Name <> '' then begin
      Idx := UserState1.UseItems[nWhere].s.looks;
      if Idx >= 0 then begin
        d := GetWStateImg(Idx);
        if d <> nil then
          with TDButton(Sender) do
            dsurface.Draw(SurfaceX(Left + (Width - d.Width) div 2),
              SurfaceY(Top + (Height - d.Height) div 2),
              d.ClientRect, d, True);

        if (UserState1.UseItems[nWhere].s.AddValue[12] in [1, 3]) {or (GetAddPoint(UserState1.UseItems[nWhere].s.AddPoint))} then begin
          if GetTickCount - g_DrawUseItems1[nWhere].dwDrawTick >= 200 then begin
            g_DrawUseItems1[nWhere].dwDrawTick := GetTickCount;
            if g_DrawUseItems1[nWhere].nIndex <= 0 then g_DrawUseItems1[nWhere].nIndex := 260 - 1;
            Inc(g_DrawUseItems1[nWhere].nIndex);
            if g_DrawUseItems1[nWhere].nIndex > 265 then g_DrawUseItems1[nWhere].nIndex := 260;
          end;
          d := g_WMain2Images.Images[g_DrawUseItems1[nWhere].nIndex];
          if d <> nil then begin
            with TDButton(Sender) do
              DrawBlend(dsurface, SurfaceX(Left + (Width - d.Width) div 2),
                SurfaceY(Top + (Height - d.Height) div 2), d);
          end;
        end;

        if UserState1.UseItems[nWhere].s.AddValue[12] >= 2 then begin
          if GetTickCount - g_DrawUseItems1_[nWhere].dwDrawTick >= 200 then begin
            g_DrawUseItems1_[nWhere].dwDrawTick := GetTickCount;
            if g_DrawUseItems1_[nWhere].nIndex <= 0 then g_DrawUseItems1_[nWhere].nIndex := 600 - 1;
            Inc(g_DrawUseItems1_[nWhere].nIndex);
            if g_DrawUseItems1_[nWhere].nIndex > 617 then g_DrawUseItems1_[nWhere].nIndex := 600;
          end;
          d := g_WMain3Images.Images[g_DrawUseItems1_[nWhere].nIndex];
          if d <> nil then begin
            with TDButton(Sender) do
              DrawBlend(dsurface, SurfaceX(Left + (Width - d.Width) div 2),
                SurfaceY(Top + (Height - d.Height) div 2), d);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.ShowGuildDlg;
begin
  DGuildDlg.Visible := True; //not DGuildDlg.Visible;
  DGuildDlg.Top := -3;
  DGuildDlg.Left := 0;
  if DGuildDlg.Visible then begin
    if GuildCommanderMode then begin
      DGDAddMem.Visible := True;
      DGDDelMem.Visible := True;
      DGDEditNotice.Visible := True;
      DGDEditGrade.Visible := True;
      DGDAlly.Visible := True;
      DGDBreakAlly.Visible := True;
      DGDWar.Visible := True;
      DGDCancelWar.Visible := True;
    end else begin
      DGDAddMem.Visible := False;
      DGDDelMem.Visible := False;
      DGDEditNotice.Visible := False;
      DGDEditGrade.Visible := False;
      DGDAlly.Visible := False;
      DGDBreakAlly.Visible := False;
      DGDWar.Visible := False;
      DGDCancelWar.Visible := False;
    end;
  end;
  GuildTopLine := 0;
end;

procedure TFrmDlg.ShowGuildEditNotice;
var
  d: TTexture;
  I: Integer;
  sData: string;
begin
  with DGuildEditNotice do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then begin
      Left := (SCREENWIDTH - d.Width) div 2;
      Top := (SCREENHEIGHT - d.Height) div 2;
    end;
    HideAllControls;
    DGuildEditNotice.ShowModal;

    Memo.Left := SurfaceX(Left + 16);
    Memo.Top := SurfaceY(Top + 36);
    Memo.Width := 571;
    Memo.Height := 246;
    Memo.Lines.Assign(GuildNotice);
    Memo.Visible := True;

    while True do begin
      if not DGuildEditNotice.Visible then Break;
      frmMain.ProcOnIdle;
      Application.ProcessMessages;
      if Application.Terminated then Exit;
      Sleep(1);
    end;

    DGuildEditNotice.Visible := False;
    RestoreHideControls;

    if DMsgDlg.DialogResult = mrOk then begin
      sData := '';
      for I := 0 to Memo.Lines.Count - 1 do begin
        if Memo.Lines[I] = '' then
          sData := sData + Memo.Lines[I] + ' '#13
        else sData := sData + Memo.Lines[I] + #13;
      end;
      if Length(sData) > 4000 then begin
        sData := Copy(sData, 1, 4000);
        DMessageDlg('Last part was removed due to the length of the notice (4000 chars max).', [mbOk]);
      end;
      frmMain.SendGuildUpdateNotice(sData);
    end;
  end;
end;

procedure TFrmDlg.ShowGuildEditGrade;
var
  d: TTexture;
  sData: string;
  I: Integer;
begin
  if GuildMembers.Count <= 0 then begin
    DMessageDlg('Press [LIST] to call up information on Guild members.', [mbOk]);
    Exit;
  end;

  with DGuildEditNotice do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then begin
      Left := (SCREENWIDTH - d.Width) div 2;
      Top := (SCREENHEIGHT - d.Height) div 2;
    end;
    HideAllControls;
    DGuildEditNotice.ShowModal;

    Memo.Left := SurfaceX(Left + 16);
    Memo.Top := SurfaceY(Top + 36);
    Memo.Width := 571;
    Memo.Height := 246;
    Memo.Lines.Assign(GuildMembers);
    Memo.Visible := True;

    while True do begin
      if not DGuildEditNotice.Visible then Break;
      frmMain.ProcOnIdle;
      Application.ProcessMessages;
      if Application.Terminated then Exit;
      Sleep(1);
    end;

    DGuildEditNotice.Visible := False;
    RestoreHideControls;

    if DMsgDlg.DialogResult = mrOk then begin
      //GuildMembers.Assign (Memo.Lines);
      sData := '';
      for I := 0 to Memo.Lines.Count - 1 do begin
        sData := sData + Memo.Lines[I] + #13;
      end;
      if Length(sData) > 5000 then begin
        sData := Copy(sData, 1, 5000);
        DMessageDlg('Last part was removed due to long length of sentence.', [mbOk]);
      end;
      frmMain.SendGuildUpdateGrade(sData);
    end;
  end;
end;

procedure TFrmDlg.DGuildDlgDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  I, n, bx, by: Integer;
  c: TColor;
begin
  with DGuildDlg do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    with dsurface do begin
      c := clWhite;
      TextOut(Left + 320, Top + 13, Guild, c);
      bx := Left + 24;
      by := Top + 41;
      for I := GuildTopLine to GuildStrs.Count - 1 do begin
        n := I - GuildTopLine;
        if n * 14 > 356 then Break;
        if Integer(GuildStrs.Objects[I]) <> 0 then c := TColor(GuildStrs.Objects[I])
        else begin
          if BoGuildChat then c := GetRGB(2)
          else c := clSilver;
        end;
        TextOut(bx, by + n * 14, GuildStrs[I], c);
      end;
    end;
  end;
end;

procedure TFrmDlg.DGDUpClick(Sender: TObject; X, Y: Integer);
begin
  if GuildTopLine > 0 then Dec(GuildTopLine, 3);
  if GuildTopLine < 0 then GuildTopLine := 0;
end;

procedure TFrmDlg.DGDDownClick(Sender: TObject; X, Y: Integer);
begin
  if GuildTopLine + 12 < GuildStrs.Count then Inc(GuildTopLine, 3);
end;

procedure TFrmDlg.DGDCloseClick(Sender: TObject; X, Y: Integer);
begin
  DGuildDlg.Visible := False;
  BoGuildChat := False;
end;

procedure TFrmDlg.DGDHomeClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount > g_dwQueryMsgTick then begin
    g_dwQueryMsgTick := GetTickCount + 3000;
    frmMain.SendGuildHome;
    BoGuildChat := False;
  end;
end;

procedure TFrmDlg.DGDListClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount > g_dwQueryMsgTick then begin
    g_dwQueryMsgTick := GetTickCount + 3000;
    frmMain.SendGuildMemberList;
    BoGuildChat := False;
  end;
end;

procedure TFrmDlg.DGDAddMemClick(Sender: TObject; X, Y: Integer);
begin
  DMessageDlg('Type character name you want to add as a Guild Member.', [mbOk, mbAbort]);
  if DlgEditText <> '' then
    frmMain.SendGuildAddMem(DlgEditText);
end;

procedure TFrmDlg.DGDDelMemClick(Sender: TObject; X, Y: Integer);
begin
  DMessageDlg('Type character name you want to delete from the Guild.', [mbOk, mbAbort]);
  if DlgEditText <> '' then
    frmMain.SendGuildDelMem(DlgEditText);
end;

procedure TFrmDlg.DGDEditNoticeClick(Sender: TObject; X, Y: Integer);
begin
  GuildEditHint := '[Edit Guild Notice.]';
  ShowGuildEditNotice;
end;

procedure TFrmDlg.DGDEditGradeClick(Sender: TObject; X, Y: Integer);
begin
  GuildEditHint := '[Amend rank and position of Guild Members.]';
  ShowGuildEditGrade;
end;

procedure TFrmDlg.DGDAllyClick(Sender: TObject; X, Y: Integer);
begin
  if mrOk = DMessageDlg('To create an alliance, the other Guild should be under the state of [AbleToAlly]\' +
    'and you should face with opponent Guild Chief.\' +
    'Would you like to make alliance?', [mbOK, mbCancel]) then
    FrmMain.SendSay('@Alliance');
end;

procedure TFrmDlg.DGDBreakAllyClick(Sender: TObject; X, Y: Integer);
begin
  DMessageDlg('Please type the name of Guild you want break your alliance.', [mbOk, mbAbort]);
  if DlgEditText <> '' then
    frmMain.SendSay('@CancelAlliance ' + DlgEditText);
end;



procedure TFrmDlg.DGuildEditNoticeDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with DGuildEditNotice do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);

    with dsurface do begin
      TextOut(Left + 18, Top + 291, GuildEditHint, clSilver);
    end;
  end;
end;

procedure TFrmDlg.DGECloseClick(Sender: TObject; X, Y: Integer);
begin
  DGuildEditNotice.Visible := False;
  Memo.Visible := False;
  DMsgDlg.DialogResult := mrCancel;
end;

procedure TFrmDlg.DGEOkClick(Sender: TObject; X, Y: Integer);
begin
  DGECloseClick(Self, 0, 0);
  DMsgDlg.DialogResult := mrOk;
end;

procedure TFrmDlg.AddGuildChat(Str: string);
var
  I: Integer;
begin
  GuildChats.Add(Str);
  if GuildChats.Count > 500 then begin
    for I := 0 to 100 do GuildChats.Delete(0);
  end;
  if BoGuildChat then
    GuildStrs.Assign(GuildChats);
end;

procedure TFrmDlg.DGDChatClick(Sender: TObject; X, Y: Integer);
begin
  BoGuildChat := not BoGuildChat;
  if BoGuildChat then begin
    GuildStrs2.Assign(GuildStrs);
    GuildStrs.Assign(GuildChats);
  end else
    GuildStrs.Assign(GuildStrs2);
end;

procedure TFrmDlg.DGoldDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  if g_MySelf = nil then Exit;
  with DGold do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
  end;
end;


{--------------------------------------------------------------}
//瓷仿摹 炼沥 芒

procedure TFrmDlg.DAdjustAbilCloseClick(Sender: TObject; X, Y: Integer);
begin
  DAdjustAbility.Visible := False;
  g_nBonusPoint := g_nSaveBonusPoint;
end;

procedure TFrmDlg.DAdjustAbilityDirectPaint(Sender: TObject;
  dsurface: TTexture);
  procedure AdjustAb(abil: Word; Val: Word; var lov, hiv: Word);
  var
    Lo, Hi: Byte;
    I: Integer;
  begin
    Lo := LoByte(abil);
    Hi := HiByte(abil);
    lov := 0; hiv := 0;
    for I := 1 to Val do begin
      if Lo + 1 < Hi then begin
        Inc(Lo); Inc(lov);
      end else begin
        Inc(Hi); Inc(hiv); end;
    end;
  end;
var
  d: TTexture;
  L, m, adc, amc, asc, aac, amac: Integer;
  ldc, lmc, lsc, lac, lmac, hdc, hmc, hsc, hac, hmac: Word;
  c: TColor;
begin
  if g_MySelf = nil then Exit;
  with dsurface do begin
    with DAdjustAbility do begin
      d := nil;
      if DMenuDlg.WLib <> nil then
        d := DMenuDlg.WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
    L := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 36;
    m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 22;

    TextOut(L, m, 'Congratulations: you are moved up to the next level!.', clSilver);
    TextOut(L, m + 14, 'Choose the ability you want to raise', clSilver);
    TextOut(L, m + 14 * 2, 'You can choose only one time so', clSilver);
    TextOut(L, m + 14 * 3, 'It is better to choose very carefully.', clSilver);

    L := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 100; //66;
    m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 101;

    {
    adc := (g_BonusAbil.DC + g_BonusAbilChg.DC) div g_BonusTick.DC;
    amc := (g_BonusAbil.MC + g_BonusAbilChg.MC) div g_BonusTick.MC;
    asc := (g_BonusAbil.SC + g_BonusAbilChg.SC) div g_BonusTick.SC;
    aac := (g_BonusAbil.AC + g_BonusAbilChg.AC) div g_BonusTick.AC;
    amac := (g_BonusAbil.MAC + g_BonusAbilChg.MAC) div g_BonusTick.MAC;
    }

    if g_BonusTick.HP = 0 then g_BonusTick.HP := 1;
    if g_BonusTick.MP = 0 then g_BonusTick.MP := 1;

    if g_BonusTick.DC = 0 then g_BonusTick.DC := 1;
    if g_BonusTick.MC = 0 then g_BonusTick.MC := 1;
    if g_BonusTick.SC = 0 then g_BonusTick.SC := 1;
    if g_BonusTick.AC = 0 then g_BonusTick.AC := 1;
    if g_BonusTick.MAC = 0 then g_BonusTick.MAC := 1;

    adc := (g_BonusAbilChg.DC) div g_BonusTick.DC;
    amc := (g_BonusAbilChg.MC) div g_BonusTick.MC;
    asc := (g_BonusAbilChg.SC) div g_BonusTick.SC;
    aac := (g_BonusAbilChg.AC) div g_BonusTick.AC;
    amac := (g_BonusAbilChg.MAC) div g_BonusTick.MAC;

    AdjustAb(g_NakedAbil.DC, adc, ldc, hdc);
    AdjustAb(g_NakedAbil.MC, amc, lmc, hmc);
    AdjustAb(g_NakedAbil.SC, asc, lsc, hsc);
    AdjustAb(g_NakedAbil.AC, aac, lac, hac);
    AdjustAb(g_NakedAbil.MAC, amac, lmac, hmac);
    //lac  := 0;  hac := aac;
    //lmac := 0;  hmac := amac;

    TextOut(L + 0, m + 0, IntToStr(_MIN(High(Word), Loword(g_MySelf.m_Abil.DC) + ldc)) + '-' + IntToStr(_MIN(High(Word), Hiword(g_MySelf.m_Abil.DC) + hdc)));
    TextOut(L + 0, m + 20, IntToStr(_MIN(High(Word), Loword(g_MySelf.m_Abil.MC) + lmc)) + '-' + IntToStr(_MIN(High(Word), Hiword(g_MySelf.m_Abil.MC) + hmc)));
    TextOut(L + 0, m + 40, IntToStr(_MIN(High(Word), Loword(g_MySelf.m_Abil.SC) + lsc)) + '-' + IntToStr(_MIN(High(Word), Hiword(g_MySelf.m_Abil.SC) + hsc)));
    TextOut(L + 0, m + 60, IntToStr(_MIN(High(Word), Loword(g_MySelf.m_Abil.AC) + lac)) + '-' + IntToStr(_MIN(High(Word), Hiword(g_MySelf.m_Abil.AC) + hac)));
    TextOut(L + 0, m + 80, IntToStr(_MIN(High(Word), Loword(g_MySelf.m_Abil.MAC) + lmac)) + '-' + IntToStr(_MIN(High(Word), Hiword(g_MySelf.m_Abil.MAC) + hmac)));

    //m_WAbil.MaxHP := MinLong(g_ServerConfig.nMaxLevel, g_MySelf.m_Abil.MaxHP + (g_BonusAbil.HP + g_BonusAbilChg.HP) div g_BonusTick.HP);
    //m_WAbil.MaxMP := MinLong(g_ServerConfig.nMaxLevel, g_MySelf.m_Abil.MaxMP + (g_BonusAbil.MP + g_BonusAbilChg.MP) div g_BonusTick.MP);

    //TextOut(L + 0, m + 100, IntToStr(g_MySelf.m_Abil.MaxHP + (g_BonusAbil.HP + g_BonusAbilChg.HP) div g_BonusTick.HP));
    //TextOut(L + 0, m + 120, IntToStr(g_MySelf.m_Abil.MaxMP + (g_BonusAbil.MP + g_BonusAbilChg.MP) div g_BonusTick.MP));

    TextOut(L + 0, m + 100, IntToStr(MinLong(g_ServerConfig.nMaxLevel, g_MySelf.m_Abil.MaxHP + (g_BonusAbil.HP + g_BonusAbilChg.HP) div g_BonusTick.HP)));
    TextOut(L + 0, m + 120, IntToStr(MinLong(g_ServerConfig.nMaxLevel, g_MySelf.m_Abil.MaxMP + (g_BonusAbil.MP + g_BonusAbilChg.MP) div g_BonusTick.MP)));


    TextOut(L + 0, m + 140, IntToStr(g_nMyHitPoint + (g_BonusAbil.Hit + g_BonusAbilChg.Hit) div g_BonusTick.Hit));
    TextOut(L + 0, m + 160, IntToStr(g_nMySpeedPoint + (g_BonusAbil.Speed + g_BonusAbilChg.Speed) div g_BonusTick.Speed));

    TextOut(L + 0, m + 180, IntToStr(g_nBonusPoint), clyellow);

    c := clWhite;
    L := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 155; //66;
    m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 101;

    if g_BonusAbilChg.DC > 0 then c := clWhite
    else c := clSilver;
    TextOut(L + 0, m + 0, IntToStr(g_BonusAbilChg.DC + g_BonusAbil.DC) + '/' + IntToStr(g_BonusTick.DC), c);

    if g_BonusAbilChg.MC > 0 then c := clWhite
    else c := clSilver;
    TextOut(L + 0, m + 20, IntToStr(g_BonusAbilChg.MC + g_BonusAbil.MC) + '/' + IntToStr(g_BonusTick.MC), c);

    if g_BonusAbilChg.SC > 0 then c := clWhite
    else c := clSilver;
    TextOut(L + 0, m + 40, IntToStr(g_BonusAbilChg.SC + g_BonusAbil.SC) + '/' + IntToStr(g_BonusTick.SC), c);

    if g_BonusAbilChg.AC > 0 then c := clWhite
    else c := clSilver;
    TextOut(L + 0, m + 60, IntToStr(g_BonusAbilChg.AC + g_BonusAbil.AC) + '/' + IntToStr(g_BonusTick.AC), c);

    if g_BonusAbilChg.MAC > 0 then c := clWhite
    else c := clSilver;
    TextOut(L + 0, m + 80, IntToStr(g_BonusAbilChg.MAC + g_BonusAbil.MAC) + '/' + IntToStr(g_BonusTick.MAC), c);

    if g_BonusAbilChg.HP > 0 then c := clWhite
    else c := clSilver;
    TextOut(L + 0, m + 100, IntToStr(MinLong(g_ServerConfig.nMaxLevel, g_BonusAbilChg.HP + g_BonusAbil.HP)) + '/' + IntToStr(g_BonusTick.HP), c);

    if g_BonusAbilChg.MP > 0 then c := clWhite
    else c := clSilver;
    TextOut(L + 0, m + 120, IntToStr(MinLong(g_ServerConfig.nMaxLevel, g_BonusAbilChg.MP + g_BonusAbil.MP)) + '/' + IntToStr(g_BonusTick.MP), c);

    if g_BonusAbilChg.Hit > 0 then c := clWhite
    else c := clSilver;
    TextOut(L + 0, m + 140, IntToStr(g_BonusAbilChg.Hit + g_BonusAbil.Hit) + '/' + IntToStr(g_BonusTick.Hit), c);

    if g_BonusAbilChg.Speed > 0 then c := clWhite
    else c := clSilver;
    TextOut(L + 0, m + 160, IntToStr(g_BonusAbilChg.Speed + g_BonusAbil.Speed) + '/' + IntToStr(g_BonusTick.Speed), c);
  end;

end;

procedure TFrmDlg.DPlusDCClick(Sender: TObject; X, Y: Integer);
var
  incp, nValue: Integer;
begin
  //if g_MySelf = nil then Exit;
  incp := Str_ToInt(DEditAdjustIncrement.Text, -1);
  if incp <= 0 then incp := 1;
  if incp > g_nBonusPoint then incp := g_nBonusPoint;

  if g_nBonusPoint > 0 then begin
   { if IsKeyPressed(VK_CONTROL) and (g_nBonusPoint > 10) then incp := 10
    else incp := 1;
    }
    if Sender = DPlusDC then begin
      if g_BonusAbilChg.DC + g_BonusAbil.DC < High(Word) then begin
        if g_BonusAbilChg.DC + g_BonusAbil.DC + incp <= High(Word) then begin
          Inc(g_BonusAbilChg.DC, incp);
          Dec(g_nBonusPoint, incp);
        end else begin
          nValue := _MIN(High(Word) - g_BonusAbilChg.DC - g_BonusAbil.DC, 0);
          Inc(g_BonusAbilChg.DC, nValue);
          Dec(g_nBonusPoint, nValue);
        end;
      end;
    end else
      if Sender = DPlusMC then begin
      if g_BonusAbilChg.MC + g_BonusAbil.MC < High(Word) then begin
        if g_BonusAbilChg.MC + g_BonusAbil.MC + incp <= High(Word) then begin
          Inc(g_BonusAbilChg.MC, incp);
          Dec(g_nBonusPoint, incp);
        end else begin
          nValue := _MIN(High(Word) - g_BonusAbilChg.MC - g_BonusAbil.MC, 0);
          Inc(g_BonusAbilChg.MC, nValue);
          Dec(g_nBonusPoint, nValue);
        end;
      end
    end else
      if Sender = DPlusSC then begin
      if g_BonusAbilChg.SC + g_BonusAbil.SC < High(Word) then begin
        if g_BonusAbilChg.SC + g_BonusAbil.SC + incp <= High(Word) then begin
          Inc(g_BonusAbilChg.SC, incp);
          Dec(g_nBonusPoint, incp);
        end else begin
          nValue := _MIN(High(Word) - g_BonusAbilChg.SC - g_BonusAbil.SC, 0);
          Inc(g_BonusAbilChg.SC, nValue);
          Dec(g_nBonusPoint, nValue);
        end;
      end;
    end else
      if Sender = DPlusAC then begin
      if g_BonusAbilChg.AC + g_BonusAbil.AC < High(Word) then begin
        if g_BonusAbilChg.AC + g_BonusAbil.AC + incp <= High(Word) then begin
          Inc(g_BonusAbilChg.AC, incp);
          Dec(g_nBonusPoint, incp);
        end else begin
          nValue := _MIN(High(Word) - g_BonusAbilChg.AC - g_BonusAbil.AC, 0);
          Inc(g_BonusAbilChg.AC, nValue);
          Dec(g_nBonusPoint, nValue);
        end;
      end;
    end else
      if Sender = DPlusMAC then begin
      if g_BonusAbilChg.MAC + g_BonusAbil.MAC < High(Word) then begin
        if g_BonusAbilChg.MAC + g_BonusAbil.MAC + incp <= High(Word) then begin
          Inc(g_BonusAbilChg.MAC, incp);
          Dec(g_nBonusPoint, incp);
        end else begin
          nValue := _MIN(High(Word) - g_BonusAbilChg.MAC - g_BonusAbil.MAC, 0);
          Inc(g_BonusAbilChg.MAC, nValue);
          Dec(g_nBonusPoint, nValue);
        end;
      end;
    end else
      if Sender = DPlusHP then begin
      if g_BonusAbilChg.HP + g_BonusAbil.HP < High(Word) then begin
        if g_BonusAbilChg.HP + g_BonusAbil.HP + incp <= High(Word) then begin
          Inc(g_BonusAbilChg.HP, incp);
          Dec(g_nBonusPoint, incp);
        end else begin
          nValue := _MIN(High(Word) - g_BonusAbilChg.HP - g_BonusAbil.HP, 0);
          Inc(g_BonusAbilChg.HP, nValue);
          Dec(g_nBonusPoint, nValue);
        end;
      end;
    end else
      if Sender = DPlusMP then begin
      if g_BonusAbilChg.MP + g_BonusAbil.MP < High(Word) then begin
        if g_BonusAbilChg.MP + g_BonusAbil.MP + incp <= High(Word) then begin
          Inc(g_BonusAbilChg.MP, incp);
          Dec(g_nBonusPoint, incp);
        end else begin
          nValue := _MIN(High(Word) - g_BonusAbilChg.MP - g_BonusAbil.MP, 0);
          Inc(g_BonusAbilChg.MP, nValue);
          Dec(g_nBonusPoint, nValue);
        end;
      end;
    end else
      if Sender = DPlusHit then begin
      if g_BonusAbilChg.Hit + g_BonusAbil.Hit < High(Word) then begin
        if g_BonusAbilChg.Hit + g_BonusAbil.Hit + incp <= High(Word) then begin
          Inc(g_BonusAbilChg.Hit, incp);
          Dec(g_nBonusPoint, incp);
        end else begin
          nValue := _MIN(High(Word) - g_BonusAbilChg.Hit - g_BonusAbil.Hit, 0);
          Inc(g_BonusAbilChg.Hit, nValue);
          Dec(g_nBonusPoint, nValue);
        end;
      end;
    end else
      if Sender = DPlusSpeed then begin
      if g_BonusAbilChg.Speed + g_BonusAbil.Speed < High(Word) then begin
        if g_BonusAbilChg.Speed + g_BonusAbil.Speed + incp <= High(Word) then begin
          Inc(g_BonusAbilChg.Speed, incp);
          Dec(g_nBonusPoint, incp);
        end else begin
          nValue := _MIN(High(Word) - g_BonusAbilChg.Speed - g_BonusAbil.Speed, 0);
          Inc(g_BonusAbilChg.Speed, nValue);
          Dec(g_nBonusPoint, nValue);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DMinusDCClick(Sender: TObject; X, Y: Integer);
var
  decp: Integer;
begin
 { if IsKeyPressed(VK_CONTROL) and (g_nBonusPoint - 10 > 0) then decp := 10
  else decp := 1;
  }
  decp := Str_ToInt(DEditAdjustIncrement.Text, -1);
  if decp <= 0 then decp := 1;

  if Sender = DMinusDC then begin
    if decp > g_BonusAbilChg.DC then decp := g_BonusAbilChg.DC;
    if g_BonusAbilChg.DC >= decp then begin
      Dec(g_BonusAbilChg.DC, decp);
      Inc(g_nBonusPoint, decp);
    end;
  end else
    if Sender = DMinusMC then begin
    if decp > g_BonusAbilChg.MC then decp := g_BonusAbilChg.MC;
    if g_BonusAbilChg.MC >= decp then begin
      Dec(g_BonusAbilChg.MC, decp);
      Inc(g_nBonusPoint, decp);
    end;
  end else
    if Sender = DMinusSC then begin
    if decp > g_BonusAbilChg.SC then decp := g_BonusAbilChg.SC;
    if g_BonusAbilChg.SC >= decp then begin
      Dec(g_BonusAbilChg.SC, decp);
      Inc(g_nBonusPoint, decp);
    end;
  end else
    if Sender = DMinusAC then begin
    if decp > g_BonusAbilChg.AC then decp := g_BonusAbilChg.AC;
    if g_BonusAbilChg.AC >= decp then begin
      Dec(g_BonusAbilChg.AC, decp);
      Inc(g_nBonusPoint, decp);
    end;
  end else
    if Sender = DMinusMAC then begin
    if decp > g_BonusAbilChg.MAC then decp := g_BonusAbilChg.MAC;
    if g_BonusAbilChg.MAC >= decp then begin
      Dec(g_BonusAbilChg.MAC, decp);
      Inc(g_nBonusPoint, decp);
    end;
  end else
    if Sender = DMinusHP then begin
    if decp > g_BonusAbilChg.HP then decp := g_BonusAbilChg.HP;
    if g_BonusAbilChg.HP >= decp then begin
      Dec(g_BonusAbilChg.HP, decp);
      Inc(g_nBonusPoint, decp);
    end;
  end else
    if Sender = DMinusMP then begin
    if decp > g_BonusAbilChg.MP then decp := g_BonusAbilChg.MP;
    if g_BonusAbilChg.MP >= decp then begin
      Dec(g_BonusAbilChg.MP, decp);
      Inc(g_nBonusPoint, decp);
    end;
  end else
    if Sender = DMinusHit then begin
    if decp > g_BonusAbilChg.Hit then decp := g_BonusAbilChg.Hit;
    if g_BonusAbilChg.Hit >= decp then begin
      Dec(g_BonusAbilChg.Hit, decp);
      Inc(g_nBonusPoint, decp);
    end;
  end else
    if Sender = DMinusSpeed then begin
    if decp > g_BonusAbilChg.Speed then decp := g_BonusAbilChg.Speed;
    if g_BonusAbilChg.Speed >= decp then begin
      Dec(g_BonusAbilChg.Speed, decp);
      Inc(g_nBonusPoint, decp);
    end;
  end;
end;

procedure TFrmDlg.DAdjustAbilOkClick(Sender: TObject; X, Y: Integer);
begin
  frmMain.SendAdjustBonus(g_nBonusPoint, g_BonusAbilChg);
  DAdjustAbility.Visible := False;
end;

procedure TFrmDlg.DAdjustAbilityMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  I, lx, ly: Integer;
  flag: Boolean;
begin
  with DAdjustAbility do begin
    lx := LocalX(X - Left);
    ly := LocalY(Y - Top);
    flag := False;
    if (lx >= 50) and (lx < 150) then
      for I := 0 to 8 do begin //DC,MC,SC..狼 腮飘啊 唱坷霸 茄促.
        if (ly >= 98 + I * 20) and (ly < 98 + (I + 1) * 20) then begin
          DScreen.ShowHint(SurfaceX(Left) + lx + 10,
            SurfaceY(Top) + ly + 5,
            AdjustAbilHints[I],
            clWhite,
            False);
          flag := True;
          Break;
        end;
      end;
    if not flag then
      DScreen.ClearHint;
  end;
end;

procedure TFrmDlg.DBotMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
  Butt: TDButton;
  sMsg: string;
begin
  DScreen.ClearHint;
  Butt := TDButton(Sender);
  nHintX := Butt.SurfaceX(Butt.Left);
  if g_ConfigClient.btMainInterface in [0, 2] then begin
    nHintY := DBottom.Top + Butt.Top - 20;
  end else begin
    nHintY := DBottom.Top + Butt.Top - 25;
    if (Sender = DBotMiniMap) or (Sender = DOnHouser) or (Sender = DBotTrade)
      or (Sender = DBotGuild) or (Sender = DButtonFriend) or (Sender = DRanking)
      or (Sender = DVoice) or (Sender = DBotGroup) or (Sender = DButOther) then
      nHintY := DBottom.SurfaceY(Butt.Top) - 25;
    if (Sender = DButtonHeroState) or (Sender = DButtonHeroBag) then
      nHintY := DBottom.SurfaceY(Butt.Top) + 30;
  end;
  if Sender = DBotMiniMap then sMsg := 'MiniMap(Tab)';
  if Sender = DBotTrade then sMsg := 'Trade(T)';
  if Sender = DBotGuild then sMsg := 'Guild(G)';
  if Sender = DBotGroup then sMsg := 'Party(P)';
  if Sender = DBotPlusAbil then sMsg := 'Ability(M)';
  if Sender = DBotLogout then sMsg := 'Log-out (Alt-X)';
  if Sender = DBotExit then sMsg := 'Exit Game(Alt-Q)';
  if Sender = DMyState then sMsg := 'Status(F10)';
  if Sender = DMyBag then sMsg := 'Inventory(F9)';
  if Sender = DMyMagic then sMsg := 'Magic(F11)';
  if Sender = DVoice then sMsg := 'Sound';
  if Sender = DButtonShop then sMsg := 'GameShop';
  if Sender = DButtonFriend then sMsg := 'Friends';
  if (Sender = DButtonDuel) or (Sender = DButOther) then sMsg := 'Duel';
  if Sender = DRanking then sMsg := 'Ranking';
  if Sender = DButtonReCallHero then sMsg := 'Hero';
  if Sender = DButtonHeroState then sMsg := 'Hero Status';
  if Sender = DButtonHeroBag then sMsg := 'Hero Inventory';

  //if (g_MySelf.m_btHorse > 0) and (g_NewStatus > sNone) then Exit;
  if Sender = DOnHouser then sMsg := 'Ride Horse(CTRL+M)';
  if Sender = DHelp then sMsg := 'Stall';
  if Sender = DPlayTool then sMsg := 'Media Player(Alt + P)';

  DScreen.ShowHint(nHintX, nHintY, sMsg, clWhite {clYellow}, False);
  if g_ConfigClient.btMainInterface in [0, 2] then begin
    nHintX := Butt.Left - 100;
    nHintY := DBottom.Top + Butt.Top;
  end else begin
    nHintX := Butt.SurfaceX(Butt.Left);
    nHintY := Butt.SurfaceY(Butt.Top) - 20;
  end;

  if Sender = DButFunc1 then begin
    if DButFunc1.Downed then sMsg := '允许所有公聊信息' else sMsg := '拒绝所有公聊信息';
    DScreen.ShowHint(nHintX, nHintY, sMsg, clWhite {clYellow}, False);
  end;
  if Sender = DButFunc2 then begin
    if DButFunc2.Downed then sMsg := '允许所有喊话信息' else sMsg := '拒绝所有喊话信息';
    DScreen.ShowHint(nHintX, nHintY, sMsg, clWhite {clYellow}, False);
  end;
  if Sender = DButFunc3 then begin
    if DButFunc3.Downed then sMsg := '允许所有私聊信息' else sMsg := '拒绝所有私聊信息';
    DScreen.ShowHint(nHintX, nHintY, sMsg, clWhite {clYellow}, False);
  end;
  if Sender = DButFunc4 then begin
    if DButFunc4.Downed then sMsg := '允许行会聊天信息' else sMsg := '拒绝行会聊天信息';
    DScreen.ShowHint(nHintX, nHintY, sMsg, clWhite {clYellow}, False);
  end;
  if Sender = DButFunc5 then begin
    sMsg := 'ChatButFunc5';
    DScreen.ShowHint(nHintX, nHintY, sMsg, clWhite {clYellow}, False);
  end;
  {nLocalX := Butt.LocalX(X - Butt.Left);
  nLocalY := Butt.LocalY(Y - Butt.Top);
  nHintX := Butt.SurfaceX(Butt.Left) + DBottom.SurfaceX(DBottom.Left) + nLocalX;
  nHintY := Butt.SurfaceY(Butt.Top) + DBottom.SurfaceY(DBottom.Top) + nLocalY; }
end;

procedure TFrmDlg.SetButVisible(Value: Boolean);
begin
  DBotMiniMap.Visible := Value;
  DOnHouser.Visible := Value;
  DBotTrade.Visible := Value;
  DBotGuild.Visible := Value;
  DButtonFriend.Visible := Value;
  DRanking.Visible := Value;
  DVoice.Visible := Value;
  DButOther.Visible := Value;
  if (g_ConfigClient.btMainInterface = 1) then
    DBotPlusAbil.Visible := (g_nBonusPoint > 0) and Value;
  DBotGroup.Visible := Value;
end;


procedure TFrmDlg.OpenFriendDlg();
begin

end;

procedure TFrmDlg.DChgGamePwdCloseClick(Sender: TObject; X, Y: Integer);
begin
  DChgGamePwd.Visible := False;
end;

procedure TFrmDlg.DChgGamePwdDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  lx, ly, sx: Integer;
begin
  with Sender as TDWindow do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);

    with dsurface do begin
      BoldTextOut(SurfaceX(Left + 15), SurfaceY(Top + 13), g_sGameGoldName);

      MainForm.Canvas.Font.Style := MainForm.Canvas.Font.Style + [fsUnderline];
      BoldTextOut(SurfaceX(Left + 12), SurfaceY(Top + 190), g_sGamePointName);
      MainForm.Canvas.Font.Style := MainForm.Canvas.Font.Style - [fsUnderline];
    end;
  end;
end;

procedure TFrmDlg.DButtonShopDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TDButton;
  dd: TTexture;
begin
  if Sender is TDButton then begin
    d := TDButton(Sender);
    //d.DrawQuad(dsurface, Bounds(d.SurfaceX(d.Left), d.SurfaceY(d.Top), d.Width, d.Height), clRed, False, 150);
    if d.Downed then begin
      dd := nil;
      if d.WLib <> nil then
        dd := d.WLib.Images[d.FaceIndex];
      if dd <> nil then
        dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, g_ConfigClient.btMainInterface in [0, 2]);
    end;
  end;
end;

procedure TFrmDlg.DShopDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  iname, d1, d2, d3: string;
  useable: Boolean;
  I, old, nIndex, n: Integer;
  sMemo: string;
  TempList: TStringList;
  StringArray: array[0..9] of string[24];
  c: TColor;
begin
  with DShop do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
  end;
  if g_MouseShopItems.ShopItem.StdItem.Name <> '' then begin
    sMemo := g_MouseShopItems.ShopItem.sMemo2;
    if sMemo = '' then begin
      g_MouseItem.s := g_MouseShopItems.ShopItem.StdItem;
      g_MouseItem.DuraMax := g_MouseItem.s.DuraMax;
      g_MouseItem.Dura := g_MouseItem.s.DuraMax;
      {TempList := TStringList.Create;
      GetMouseItemInfo(TempList);
      }
      GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
      TempList := HintList;
      g_MouseItem.s.Name := '';
      if TempList.Count > 0 then begin
        with dsurface do begin
          old := MainForm.Canvas.Font.Size;
          MainForm.Canvas.Font.Size := 9;
          nIndex := 0;
          n := 1;
          if TempList.Count >= 5 then begin
            TextOut(DShop.SurfaceX(DShop.Left + 20), DShop.SurfaceY(DShop.Top + DShop.Height - 150 + (TextHeight('A') + 2) - TextHeight('A')), TempList.Strings[0], clyellow);
            for I := 1 to TempList.Count - 2 do begin
              if nIndex = 0 then begin
                TextOut(DShop.SurfaceX(DShop.Left + 20), DShop.SurfaceY(DShop.Top + DShop.Height - 150 + (TextHeight('A') + 2) * n), TempList.Strings[I], TColor(TempList.Objects[I]));
                Inc(nIndex);
              end else begin
                TextOut(DShop.SurfaceX(DShop.Left + 20) + TextWidth('A') + TextWidth(TempList.Strings[I - 1]), DShop.SurfaceY(DShop.Top + DShop.Height - 150 + (TextHeight('A') + 2) * n), TempList.Strings[I], TColor(TempList.Objects[I]));
                nIndex := 0;
                Inc(n);
              end
            end;
            if nIndex <> 0 then Inc(n);
            TextOut(DShop.SurfaceX(DShop.Left + 20), DShop.SurfaceY(DShop.Top + DShop.Height - 150 + (TextHeight('A') + 2) * n), TempList.Strings[TempList.Count - 1], TColor(TempList.Objects[TempList.Count - 1]));
          end else begin
            for I := 0 to TempList.Count - 1 do begin
              if I = 0 then c := clyellow
              else c := TColor(TempList.Objects[I]);
              TextOut(DShop.SurfaceX(DShop.Left + 20), DShop.SurfaceY(DShop.Top + DShop.Height - 150 + (TextHeight('A') + 2) * n - TextHeight('A')), TempList.Strings[I], c);
              Inc(n);
            end;
          end;
          MainForm.Canvas.Font.Size := old;
        end;
      end;
      //TempList.Free;
    end else begin
      nIndex := 0;
      SafeFillChar(StringArray, SizeOf(StringArray), #0);
      TempList := TStringList.Create;
      ExtractStrings(['\'], [], PChar(sMemo), TempList);
      for nIndex := 0 to TempList.Count - 1 do begin
        if nIndex > 9 then Break;
        StringArray[nIndex] := TempList.Strings[nIndex];
      end;
      TempList.Free;

      with dsurface do begin
        old := MainForm.Canvas.Font.Size;
        MainForm.Canvas.Font.Size := 9;
        c := clyellow;
        TextOut(DShop.SurfaceX(DShop.Left + 20), DShop.SurfaceY(DShop.Top + DShop.Height - 150), '★' + g_MouseShopItems.ShopItem.StdItem.Name, c);
        c := clWhite;
        n := 0;
        for nIndex := Low(StringArray) to High(StringArray) do begin
          if StringArray[nIndex] <> '' then begin
            if n = 0 then
              TextOut(DShop.SurfaceX(DShop.Left + 20), DShop.SurfaceY(DShop.Top + DShop.Height - 150 + TextHeight('A') + 2), StringArray[nIndex], c);
            if n > 0 then
              TextOut(DShop.SurfaceX(DShop.Left + 20), DShop.SurfaceY(DShop.Top + DShop.Height - 150 + (TextHeight('A') + 2) * n) + TextHeight('A'), StringArray[nIndex], c);
            Inc(n);
          end;
        end;
        Inc(n);
        c := clyellow;
        if g_MouseShopItems.ShopItem.StdItem.AddValue[0] = 0 then begin
          TextOut(DShop.SurfaceX(DShop.Left + 20), DShop.SurfaceY(DShop.Top + DShop.Height - 150 + (TextHeight('A') + 2) * n), '到期时间: 永久使用', c);
        end else begin
          TextOut(DShop.SurfaceX(DShop.Left + 20), DShop.SurfaceY(DShop.Top + DShop.Height - 150 + (TextHeight('A') + 2) * n), '到期时间: ' + DateToStr(g_MouseShopItems.ShopItem.StdItem.MaxDate), c);
        end;
        MainForm.Canvas.Font.Size := old;
      end;
    end;
  end;
end;

procedure TFrmDlg.DJewelryDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TDButton;
  dd: TTexture;
begin
  if Sender is TDButton then begin
    d := TDButton(Sender);
    if d.Downed then begin
      dd := nil;
      if d.WLib <> nil then
        dd := d.WLib.Images[d.FaceIndex];
      if dd <> nil then
        dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, True);
    end;
  end;
end;

procedure TFrmDlg.DShopExitClick(Sender: TObject; X, Y: Integer);
begin
  DShop.Visible := False;
end;

procedure TFrmDlg.ChgShopSelButton(nType: Integer);
begin
  case nType of
    0: begin
        DJewelry.Downed := True;
        DMedicine.Downed := False;
        DEnhance.Downed := False;
        Dfriend.Downed := False;
        DLimit.Downed := False;
      end;
    1: begin
        DJewelry.Downed := False;
        DMedicine.Downed := True;
        DEnhance.Downed := False;
        Dfriend.Downed := False;
        DLimit.Downed := False;
      end;
    2: begin
        DJewelry.Downed := False;
        DMedicine.Downed := False;
        DEnhance.Downed := True;
        Dfriend.Downed := False;
        DLimit.Downed := False;
      end;
    3: begin
        DJewelry.Downed := False;
        DMedicine.Downed := False;
        DEnhance.Downed := False;
        Dfriend.Downed := True;
        DLimit.Downed := False;
      end;
    4: begin
        DJewelry.Downed := False;
        DMedicine.Downed := False;
        DEnhance.Downed := False;
        Dfriend.Downed := False;
        DLimit.Downed := True;
      end;
  end;
end;

procedure TFrmDlg.DJewelryClick(Sender: TObject; X, Y: Integer);
begin
  ShopTabPage := 0;
  g_MouseShopItems.ShopItem.StdItem.Name := '';
  g_MouseShopItems.nPicturePosition := -1;
  g_MouseShopItems.dwPlaySpeedTick := GetTickCount;
  ChgShopSelButton(ShopTabPage);
  if g_ShopItems[ShopTabPage, 0].StdItem.Name = '' then begin
    frmMain.SendShopDlg(ShopPage[ShopTabPage], ShopTabPage, 0);
  end;
end;

procedure TFrmDlg.DMedicineClick(Sender: TObject; X, Y: Integer);
begin
  ShopTabPage := 1;
  g_MouseShopItems.ShopItem.StdItem.Name := '';
  g_MouseShopItems.nPicturePosition := -1;
  g_MouseShopItems.dwPlaySpeedTick := GetTickCount;
  ChgShopSelButton(ShopTabPage);
  if g_ShopItems[ShopTabPage, 0].StdItem.Name = '' then begin
    frmMain.SendShopDlg(ShopPage[ShopTabPage], ShopTabPage, 0);
  end;
end;

procedure TFrmDlg.DEnhanceClick(Sender: TObject; X, Y: Integer);
begin
  ShopTabPage := 2;
  g_MouseShopItems.ShopItem.StdItem.Name := '';
  g_MouseShopItems.nPicturePosition := -1;
  g_MouseShopItems.dwPlaySpeedTick := GetTickCount;
  ChgShopSelButton(ShopTabPage);
  if g_ShopItems[ShopTabPage, 0].StdItem.Name = '' then begin
    frmMain.SendShopDlg(ShopPage[ShopTabPage], ShopTabPage, 0);
  end;
end;

procedure TFrmDlg.DfriendClick(Sender: TObject; X, Y: Integer);
begin
  ShopTabPage := 3;
  g_MouseShopItems.ShopItem.StdItem.Name := '';
  g_MouseShopItems.nPicturePosition := -1;
  g_MouseShopItems.dwPlaySpeedTick := GetTickCount;
  ChgShopSelButton(ShopTabPage);
  if g_ShopItems[ShopTabPage, 0].StdItem.Name = '' then begin
    frmMain.SendShopDlg(ShopPage[ShopTabPage], ShopTabPage, 0);
  end;
end;

procedure TFrmDlg.DLimitClick(Sender: TObject; X, Y: Integer);
begin
  ShopTabPage := 4;
  g_MouseShopItems.ShopItem.StdItem.Name := '';
  g_MouseShopItems.nPicturePosition := -1;
  g_MouseShopItems.dwPlaySpeedTick := GetTickCount;
  ChgShopSelButton(ShopTabPage);
  if g_ShopItems[ShopTabPage, 0].StdItem.Name = '' then begin
    frmMain.SendShopDlg(ShopPage[ShopTabPage], ShopTabPage, 0);
  end;
end;

procedure TFrmDlg.DBottomMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  sStr: string;
begin
  if g_ConfigClient.btMainInterface in [0, 2] then begin
    if (X >= DBottom.Left + 666) and (Y >= SCREENHEIGHT - 73) and
      (X <= DBottom.Left + 730) and (Y <= SCREENHEIGHT - 73 + 13) then begin
      if g_MySelf.m_Abil.MaxExp > 0 then begin
        sStr := 'Experience ' + FloatToStrFixFmt(100 * g_MySelf.m_Abil.Exp / g_MySelf.m_Abil.MaxExp, 3, 2) + '%\';
        DScreen.ShowHint(DBottom.Left + 666, SCREENHEIGHT - 73 + 13, sStr, clWhite, False);
      end;
    end else
      if (X >= DBottom.Left + 666) and (X <= DBottom.Left + 730) and
      (Y >= SCREENHEIGHT - 40) and (Y <= SCREENHEIGHT - 40 + 13) then begin
      sStr := 'Weight ' + IntToStr(g_MySelf.m_Abil.Weight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWeight);
      DScreen.ShowHint(DBottom.Left + 666, SCREENHEIGHT - 40 + 13, sStr, clWhite, False);
    end else begin
      DScreen.ClearHint;
    end;
  end else begin
    if (Y >= SCREENHEIGHT - 8) and (Y <= SCREENHEIGHT) then begin
      if EdChat.Visible then begin
        if (X >= EdChat.SurfaceX(EdChat.Left)) and (X <= EdChat.SurfaceX(EdChat.Left) + EdChat.Width) then begin
          DScreen.ClearHint;
          Exit;
        end;
      end;
      if g_MySelf.m_Abil.MaxExp > 0 then begin
        sStr := 'Experience ' + FloatToStrFixFmt(100 * g_MySelf.m_Abil.Exp / g_MySelf.m_Abil.MaxExp, 3, 2) + '%\';
        DScreen.ShowHint(X, SCREENHEIGHT, sStr, clWhite, True);
      end;
    end else
      DScreen.ClearHint;
  end;
end;

procedure TFrmDlg.OpenShopDlg;
begin
  if not DShop.Visible then begin
    DShop.Visible := True;
  end;
end;

procedure TFrmDlg.DShopIntroduceDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  nIdx: Integer;
  d: TTexture;
begin
  nIdx := -1;
  if g_MouseShopItems.ShopItem.StdItem.Name <> '' then begin
    if g_MouseShopItems.ShopItem.nBeginIdx = g_MouseShopItems.ShopItem.nEndIdx then begin
      nIdx := g_MouseShopItems.ShopItem.nBeginIdx;
    end else
      if g_MouseShopItems.ShopItem.nBeginIdx < g_MouseShopItems.ShopItem.nEndIdx then begin
      if g_MouseShopItems.nPicturePosition >= 0 then begin
        if GetTickCount > g_MouseShopItems.dwPlaySpeedTick then begin
          g_MouseShopItems.dwPlaySpeedTick := GetTickCount + 400;
          Inc(g_MouseShopItems.nPicturePosition);
        end;
        if g_MouseShopItems.nPicturePosition > g_MouseShopItems.ShopItem.nEndIdx then
          g_MouseShopItems.nPicturePosition := g_MouseShopItems.ShopItem.nBeginIdx;
        nIdx := g_MouseShopItems.nPicturePosition;
      end else begin
        g_MouseShopItems.nPicturePosition := g_MouseShopItems.ShopItem.nBeginIdx;
        nIdx := g_MouseShopItems.nPicturePosition;
        g_MouseShopItems.dwPlaySpeedTick := GetTickCount + 400;
      end;
    end;
  end;
  if nIdx = -1 then nIdx := 380;
  d := g_WEffectImg.Images[nIdx];
  if d <> nil then
    dsurface.Draw(DShopIntroduce.SurfaceX(DShopIntroduce.Left + (DShopIntroduce.Width - d.Width) div 2),
      DShopIntroduce.SurfaceY(DShopIntroduce.Top + (DShopIntroduce.Height - d.Height) div 2),
      d.ClientRect, d, True);
end;

procedure TFrmDlg.SuperShopItemPrev;
begin
  if ShopPage[5] > 0 then begin
    Dec(ShopPage[5]);
    g_MouseShopItems.ShopItem.StdItem.Name := '';
    g_MouseShopItems.nPicturePosition := -1;
    frmMain.SendShopDlg(ShopPage[5], 5, 5);
  end;
end;

procedure TFrmDlg.SuperShopItemNext;
begin
  if ShopPage[5] < ShopPageCount then begin
    Inc(ShopPage[5]);
    g_MouseShopItems.ShopItem.StdItem.Name := '';
    g_MouseShopItems.nPicturePosition := -1;
    frmMain.SendShopDlg(ShopPage[5], 5, 5);
  end;
end;

procedure TFrmDlg.DPrevShopClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount > g_dwQueryMsgTick then begin
    g_dwQueryMsgTick := GetTickCount + 1000;
    SuperShopItemPrev;
    if ShopPage[ShopTabPage] > 0 then begin
      Dec(ShopPage[ShopTabPage]);
      if ShopPage[ShopTabPage] < 0 then ShopPage[ShopTabPage] := 0;
      g_MouseShopItems.ShopItem.StdItem.Name := '';
      g_MouseShopItems.nPicturePosition := -1;
      frmMain.SendShopDlg(ShopPage[ShopTabPage], ShopTabPage, 0);
    end;
  end;
end;

procedure TFrmDlg.DNextShopClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount > g_dwQueryMsgTick then begin
    g_dwQueryMsgTick := GetTickCount + 1000;
    SuperShopItemNext;
    if ShopPage[ShopTabPage] < ShopPageCount then begin
      Inc(ShopPage[ShopTabPage]);
      g_MouseShopItems.ShopItem.StdItem.Name := '';
      g_MouseShopItems.nPicturePosition := -1;
      frmMain.SendShopDlg(ShopPage[ShopTabPage], ShopTabPage, 0);
    end;
  end;
end;

procedure TFrmDlg.DShopBuyClick(Sender: TObject; X, Y: Integer);
begin
  if g_MouseShopItems.ShopItem.StdItem.Name <> '' then begin
    if mrOk = DMessageDlg('Are you sure you want to purchase: ' + g_MouseShopItems.ShopItem.StdItem.Name, [mbOk, mbCancel]) then begin
      frmMain.SendBuyShopItem(g_MouseShopItems.ShopItem.StdItem.Name, g_MouseShopItems.ShopItem.btItemType);
    end;
  end;
end;

procedure TFrmDlg.DButtonReCallHeroDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TDButton;
  dd: TTexture;
begin
  if Sender is TDButton then begin
    d := TDButton(Sender);
    if d.Downed then begin
      dd := d.WLib.Images[d.FaceIndex];
      if dd <> nil then
        dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, True);
    end;
  end;
end;

procedure TFrmDlg.DButFunc1DirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TDButton;
  dd: TTexture;
begin
  if Sender is TDButton then begin
    d := TDButton(Sender);
    if d.Downed then begin
      dd := d.WLib.Images[d.FaceIndex + 1];
    end else begin
      dd := d.WLib.Images[d.FaceIndex];
    end;
    if dd <> nil then
      dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, True);
  end;
end;

procedure TFrmDlg.DButFunc1Click(Sender: TObject; X, Y: Integer);
var
  d: TDButton;
  sMsg: string;
begin
 { if Sender is TDButton then begin
    d := TDButton(Sender);
    if d <> nil then begin
      if d.Downed then begin
        Dec(d.FaceIndex)
      end else begin
        Inc(d.FaceIndex);
      end;
    end;
  end; }
  if Sender = DButFunc1 then begin
    g_boShowGroupMsg := not DButFunc1.Downed;
    if g_boShowGroupMsg then begin
      sMsg := 'Show General Chat';
      DScreen.AddChatBoardString(sMsg, GetRGB(222), GetRGB(255));
    end else begin
      sMsg := 'Hide General Chat';
      DScreen.AddChatBoardString(sMsg, GetRGB(222), GetRGB(0));
    end;
  end else
    if Sender = DButFunc2 then begin
    g_boShowHearMsg := not DButFunc2.Downed;
    if g_boShowHearMsg then begin
      sMsg := 'Show Shout Chat';
      DScreen.AddChatBoardString(sMsg, GetRGB(222), GetRGB(255));
    end else begin
      sMsg := 'Hide Shout Chat';
      DScreen.AddChatBoardString(sMsg, GetRGB(222), GetRGB(0));
    end;
  end else
    if Sender = DButFunc3 then begin
    g_boShowWhisperMsg := not DButFunc3.Downed;
    if g_boShowWhisperMsg then begin
      sMsg := '允许接受私聊信息';
      DScreen.AddChatBoardString(sMsg, GetRGB(222), GetRGB(255));
    end else begin
      sMsg := '拒绝接受私聊信息';
      DScreen.AddChatBoardString(sMsg, GetRGB(222), GetRGB(0));
    end;
  end else
    if Sender = DButFunc4 then begin
    g_boShowGuildMsg := not DButFunc4.Downed;
    if g_boShowGuildMsg then begin
      sMsg := '允许接受行会喊话信息';
      DScreen.AddChatBoardString(sMsg, GetRGB(222), GetRGB(255));
    end else begin
      sMsg := '拒绝接受行会喊话信息';
      DScreen.AddChatBoardString(sMsg, GetRGB(222), GetRGB(0));
    end;
  end else
    if Sender = DButFunc5 then begin
    g_boAutoShowHearMsg := not DButFunc5.Downed;
    if g_boAutoShowHearMsg then begin
      sMsg := '启用了自动喊话功能，聊天框中内容已记录为喊话内容';
      DScreen.AddChatBoardString(sMsg, GetRGB(222), GetRGB(255));
      g_dwAutoShowMsgTick := GetTickCount;
      g_sAutoShowMsg := EdChat.Text;
    end else begin
      sMsg := '自动喊话功能已关闭';
      DScreen.AddChatBoardString(sMsg, GetRGB(222), GetRGB(255));
    end;
  end;
end;

procedure TFrmDlg.DHeroHealthStateWinDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  old: Integer;
  rc: TRect;
  OldColor: TColor;
  Idx: Integer;
begin
  if g_MyHero = nil then Exit;
  {case g_MyHero.m_btSex of
    0: begin
        if g_ConfigClient.btMainInterface in [0, 2] then begin
          case g_MyHero.m_btJob of
            0: idx := 365;
            1: idx := 366;
            2: idx := 367;
          end;
        end else begin
          case g_MyHero.m_btJob of
            0: idx := 136;
            1: idx := 137;
            2: idx := 138;
          end;
        end;
      end;
    1: begin
        if g_ConfigClient.btMainInterface in [0, 2] then begin
          case g_MyHero.m_btJob of
            0: idx := 368;
            1: idx := 369;
            2: idx := 370;
          end;
        end else begin
          case g_MyHero.m_btJob of
            0: idx := 139;
            1: idx := 140;
            2: idx := 141;
          end;
        end;
      end;
  end;
  d := nil;
  with DHeroHealthStateWin do begin
    if idx > 0 then begin
      if g_ConfigClient.btMainInterface in [0, 2] then begin
        d := g_WMain3Images.Images[idx];
        if d <> nil then begin
          if g_MyHero.m_boDeath then begin
            g_ImgMixSurface.SetSize(d.Width, d.Height);
            g_ImgMixSurface.Fill(0);
            g_ImgMixSurface.Draw(0, 0, d.ClientRect, d, False);
            DrawEffect(0, 0, g_ImgMixSurface, d, ceGrayScale);
            d := g_ImgMixSurface;
          end;

          dsurface.Draw(SurfaceX(Left) + 16,
            SurfaceY(Top) + 16,
            d.ClientRect, d, True);
        end;
      end else begin
        d := g_WCqFirImages.Images[idx];
        if d <> nil then begin
          if g_MyHero.m_boDeath then begin
            g_ImgMixSurface.SetSize(d.Width, d.Height);
            g_ImgMixSurface.Fill(0);
            g_ImgMixSurface.Draw(0, 0, d.ClientRect, d, False);
            DrawEffect(0, 0, g_ImgMixSurface, d, ceGrayScale);
            d := g_ImgMixSurface;
          end;
          //dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
          dsurface.Draw(SurfaceX(Left) + 6,
            SurfaceY(Top) + 8,
            d.ClientRect, d, True);
        end;
      end;
    end;
    if g_ConfigClient.btMainInterface in [0, 2] then begin
    //显示英雄等级     clBtnFace
      with dsurface do begin
        TextOut(SurfaceX(Left) + 2, SurfaceY(Top) + 56, IntToStr(g_MyHero.m_Abil.Level), g_MyHero.m_nNameColor);
      end;
    end;
  end;  }

  if g_ConfigClient.btMainInterface in [0, 2] then begin

    with DHeroHealthStateWin do begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);

      Idx := -1;
      case g_MyHero.m_btSex of
        0:
          case g_MyHero.m_btJob of
            0: Idx := 365;
            1: Idx := 366;
            2: Idx := 367;
          end;
        1:
          case g_MyHero.m_btJob of
            0: Idx := 368;
            1: Idx := 369;
            2: Idx := 370;
          end;
      end;
      if Idx > 0 then begin
        d := g_WMain3Images.Images[Idx];
        if d <> nil then begin
          if g_MyHero.m_boDeath then begin
            g_ImgMixSurface.SetSize(d.Width, d.Height);
            g_ImgMixSurface.Fill(0);
            g_ImgMixSurface.Draw(0, 0, d.ClientRect, d, False);
            DrawEffect(0, 0, g_ImgMixSurface, d, ceGrayScale);
            d := g_ImgMixSurface;
          end;
          dsurface.Draw(SurfaceX(Left) + 16, SurfaceY(Top) + 16, d.ClientRect, d, True);
        end;
      end;

      d := g_WMain3Images.Images[386]; //显示英雄HP
      if d <> nil then begin
        rc := d.ClientRect;
        if g_MyHero.m_Abil.MaxHP > 0 then
          rc.Right := Round((rc.Right - rc.Left) / g_MyHero.m_Abil.MaxHP * g_MyHero.m_Abil.HP);
        dsurface.Draw(Left + 75, Top + 25, rc, d, False);
      end;

      d := g_WMain3Images.Images[387]; //显示英雄MP
      if d <> nil then begin
        rc := d.ClientRect;
        if g_MyHero.m_Abil.MaxMP > 0 then
          rc.Right := Round((rc.Right - rc.Left) / g_MyHero.m_Abil.MaxMP * g_MyHero.m_Abil.MP);
        dsurface.Draw(Left + 80, Top + 38, rc, d, False);
      end;

      d := g_WMain3Images.Images[388]; //显示英雄EXP
      if d <> nil then begin
        rc := d.ClientRect;
        if g_MyHero.m_Abil.MaxExp > 0 then
          rc.Right := Round((rc.Right - rc.Left) / g_MyHero.m_Abil.MaxExp * g_MyHero.m_Abil.Exp);
        dsurface.Draw(Left + 80, Top + 50, rc, d, False);
      end;

    //显示英雄名称
      with dsurface do begin
        old := MainForm.Canvas.Font.Size;
        MainForm.Canvas.Font.Size := 9;

        TextOut(Left + 80, Top + 6, g_MyHero.m_sUserName, g_MyHero.m_nNameColor);

    //显示英雄等级     clBtnFace
        TextOut(SurfaceX(Left) + 2, SurfaceY(Top) + 60, IntToStr(g_MyHero.m_Abil.Level), g_MyHero.m_nNameColor);
        MainForm.Canvas.Font.Size := old;
      end;
    end;

  end else begin

    with DHeroHealthStateWin do begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);

      Idx := -1;
      case g_MyHero.m_btSex of
        0:
          case g_MyHero.m_btJob of
            0: Idx := 136;
            1: Idx := 137;
            2: Idx := 138;
          end;
        1:
          case g_MyHero.m_btJob of
            0: Idx := 139;
            1: Idx := 140;
            2: Idx := 141;
          end;
      end;
      if Idx > 0 then begin
        d := g_WCqFirImages.Images[Idx];
        if d <> nil then begin
          if g_MyHero.m_boDeath then begin
            g_ImgMixSurface.SetSize(d.Width, d.Height);
            g_ImgMixSurface.Fill(0);
            g_ImgMixSurface.Draw(0, 0, d.ClientRect, d, False);
            DrawEffect(0, 0, g_ImgMixSurface, d, ceGrayScale);
            d := g_ImgMixSurface;
          end;
          dsurface.Draw(SurfaceX(Left) + 8, SurfaceY(Top) + 10, d.ClientRect, d, True);
        end;
      end;

      if g_HeroUseItems[U_BUJUK].s.Name <> '' then begin
        if (g_HeroUseItems[U_BUJUK].s.StdMode = 25) and (g_HeroUseItems[U_BUJUK].s.Shape = 9) then begin

          if g_MyHero.m_nAngryValue >= g_MyHero.m_nMaxAngryValue then begin
            if GetTickCount - g_dwFirDragonTick > 500 then begin
              g_dwFirDragonTick := GetTickCount;
              Inc(g_nFirDragon);
              if g_nFirDragon > 1 then g_nFirDragon := 0;
            end;
            if g_nFirDragon > 0 then
              d := g_WCqFirImages.Images[130]
            else d := g_WCqFirImages.Images[149];
          end else begin
            d := g_WCqFirImages.Images[130]; //显示怒槽
          end;

          if d <> nil then begin
            rc := d.ClientRect;
            if g_MyHero.m_nMaxAngryValue > 0 then
              rc.Right := Round((rc.Right - rc.Left) / g_MyHero.m_nMaxAngryValue * g_MyHero.m_nAngryValue);
            dsurface.Draw(Left + 56, Top + 32, rc, d, False);
          end;
        end;
      end;

      d := g_WCqFirImages.Images[131]; //显示英雄HP
      if d <> nil then begin
        rc := d.ClientRect;
        if g_MyHero.m_Abil.MaxHP > 0 then
          rc.Right := Round((rc.Right - rc.Left) / g_MyHero.m_Abil.MaxHP * g_MyHero.m_Abil.HP);
        dsurface.Draw(Left + 103, Top + 47, rc, d, False);
      end;

      d := g_WCqFirImages.Images[132]; //显示英雄MP
      if d <> nil then begin
        rc := d.ClientRect;
        if g_MyHero.m_Abil.MaxMP > 0 then
          rc.Right := Round((rc.Right - rc.Left) / g_MyHero.m_Abil.MaxMP * g_MyHero.m_Abil.MP);
        dsurface.Draw(Left + 106, Top + 57, rc, d, False);
      end;

      d := g_WCqFirImages.Images[133]; //显示英雄EXP
      if d <> nil then begin
        rc := d.ClientRect;
        if g_MyHero.m_Abil.MaxExp > 0 then
          rc.Right := Round((rc.Right - rc.Left) / g_MyHero.m_Abil.MaxExp * g_MyHero.m_Abil.Exp);
        dsurface.Draw(Left + 103, Top + 66, rc, d, False);
      end;

    //显示英雄名称
      with dsurface do begin
        TextOut(Left + 62 + (88 - TextWidth(g_MyHero.m_sUserName)) div 2, Top + 6 + 12, g_MyHero.m_sUserName, g_MyHero.m_nNameColor);
        TextOut(Left + 148 + (44 - TextWidth(IntToStr(g_MyHero.m_Abil.Level))) div 2, Top + 6 + 12, IntToStr(g_MyHero.m_Abil.Level), g_MyHero.m_nNameColor);
      end;
    end;
  end;
end;

procedure TFrmDlg.DHeroStateWinDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  I, L, m, pgidx, magline, bbx, bby, mmx, Idx, ax, ay, trainlv: Integer;
  pm: PTClientMagic;
  d: TTexture;
  hcolor, old, keyimg: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;

begin
  if g_MyHero = nil then Exit;
  with DHeroStateWin do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    case HeroStatePage of
      0: begin
          pgidx := 380;
          if g_MyHero <> nil then
            if g_MyHero.m_btSex = 1 then pgidx := 381;
          bbx := Left + 38;
          bby := Top + 52;
          d := g_WMain3Images.Images[pgidx];
          if d <> nil then
            dsurface.Draw(SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, False);

          bbx := bbx - 7;
          bby := bby + 44;
          if g_MyHero.m_btHair < 4 then begin
            Idx := 440 + g_MyHero.m_btHair;
          //显示发型
            if Idx > 0 then begin
              d := g_WMainImages.GetCachedImage(Idx, ax, ay);
              if d <> nil then
                dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
            end;
          end;
          if g_HeroUseItems[U_DRESS].s.Name <> '' then begin
            Idx := g_HeroUseItems[U_DRESS].s.looks;
            if Idx >= 0 then begin
              //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
              d := GetWStateImg(Idx, ax, ay);
              if d <> nil then
                dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
            end;
          end;
          if g_HeroUseItems[U_WEAPON].s.Name <> '' then begin
            Idx := g_HeroUseItems[U_WEAPON].s.looks;
            if Idx >= 0 then begin
              //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
              d := GetWStateImg(Idx, ax, ay);
              if d <> nil then
                dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);

              if (g_HeroUseItems[U_WEAPON].s.Shape = 38) and (Idx = 1404) then begin
                d := GetWStateImg(Idx - 1, ax, ay);
                if d <> nil then
                  DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d);
              end else
                if (g_HeroUseItems[U_WEAPON].s.Shape = 56) and (Idx = 1880) then begin
                if (g_dwWeapon56Index[1] < 1890) or (g_dwWeapon56Index[1] > 1899) then
                  g_dwWeapon56Index[1] := 1890;
                if GetTickCount - g_dwWeapon56Tick[1] > 100 then begin
                  g_dwWeapon56Tick[1] := GetTickCount;
                  g_dwWeapon56Index[1] := g_dwWeapon56Index[1] + 1;
                end;
                if (g_dwWeapon56Index[1] < 1890) or (g_dwWeapon56Index[1] > 1899) then
                  g_dwWeapon56Index[1] := 1890;

                d := GetWStateImg(g_dwWeapon56Index[1], ax, ay);
                if d <> nil then
                  DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d);
              end;

            end;
          end;
          if g_HeroUseItems[U_HELMET].s.Name <> '' then begin
            Idx := g_HeroUseItems[U_HELMET].s.looks;
            if Idx >= 0 then begin
              //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
              d := GetWStateImg(Idx, ax, ay);
              if d <> nil then
                dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
            end;
          end;
        end;
      1: begin
          L := Left + 112; //66;
          m := Top + 99;
          bbx := Left + 38;
          bby := Top + 52;
          //d := g_WMain3Images.Images[383];
          d := g_WUIBImages.Images[9];
          if d = nil then d := g_WMain3Images.Images[383];

          if d <> nil then
            dsurface.Draw(SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, False);
          with dsurface do begin
            TextOut(SurfaceX(L + 0), SurfaceY(m + 0), IntToStr(Loword(g_MyHero.m_Abil.AC)) + '-' + IntToStr(Hiword(g_MyHero.m_Abil.AC)));
            TextOut(SurfaceX(L + 0), SurfaceY(m + 20), IntToStr(Loword(g_MyHero.m_Abil.MAC)) + '-' + IntToStr(Hiword(g_MyHero.m_Abil.MAC)));
            TextOut(SurfaceX(L + 0), SurfaceY(m + 40), IntToStr(Loword(g_MyHero.m_Abil.DC)) + '-' + IntToStr(Hiword(g_MyHero.m_Abil.DC)));
            TextOut(SurfaceX(L + 0), SurfaceY(m + 60), IntToStr(Loword(g_MyHero.m_Abil.MC)) + '-' + IntToStr(Hiword(g_MyHero.m_Abil.MC)));
            TextOut(SurfaceX(L + 0), SurfaceY(m + 80), IntToStr(Loword(g_MyHero.m_Abil.SC)) + '-' + IntToStr(Hiword(g_MyHero.m_Abil.SC)));
            TextOut(SurfaceX(L + 0), SurfaceY(m + 100), IntToStr(g_MyHero.m_Abil.HP) + '/' + IntToStr(g_MyHero.m_Abil.MaxHP));
            TextOut(SurfaceX(L + 0), SurfaceY(m + 120), IntToStr(g_MyHero.m_Abil.MP) + '/' + IntToStr(g_MyHero.m_Abil.MaxMP));
          end;
        end;
      2: begin
          bbx := Left + 38;
          bby := Top + 52;
          d := g_WMain3Images.Images[32];
          if d <> nil then
            dsurface.Draw(SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, False);

          bbx := bbx + 20;
          bby := bby + 10;
          with dsurface do begin
            mmx := bbx + 85;
            hcolor := clSilver;
            TextOut(bbx, bby, 'Experience ', hcolor);
            //TextOut(mmx, bby, FloatToStrFixFmt(100 * g_MyHero.m_Abil.Exp / g_MyHero.m_Abil.MaxExp, 3, 2) + '%');

            TextOut(mmx, bby, IntToStr(g_MyHero.m_Abil.Exp), hcolor);
            bby := bby + 14;
            TextOut(bbx, bby, 'Next Level Exp. ', hcolor);
            TextOut(mmx, bby, IntToStr(g_MyHero.m_Abil.MaxExp), hcolor);

            TextOut(bbx, bby + 14 * 1, 'Bag Weight ', hcolor);
            if g_MyHero.m_Abil.Weight > g_MyHero.m_Abil.MaxWeight then
              hcolor := clRed;
            TextOut(mmx, bby + 14 * 1, IntToStr(g_MyHero.m_Abil.Weight) + '/' + IntToStr(g_MyHero.m_Abil.MaxWeight), hcolor);

            hcolor := clSilver;
            TextOut(bbx, bby + 14 * 2, 'C. Weight ', hcolor);
            if g_MyHero.m_Abil.WearWeight > g_MyHero.m_Abil.MaxWearWeight then
              hcolor := clRed;
            TextOut(mmx, bby + 14 * 2, IntToStr(g_MyHero.m_Abil.WearWeight) + '/' + IntToStr(g_MyHero.m_Abil.MaxWearWeight), hcolor);

            hcolor := clSilver;
            TextOut(bbx, bby + 14 * 3, 'Hands W. ', hcolor);
            if g_MyHero.m_Abil.HandWeight > g_MyHero.m_Abil.MaxHandWeight then
              hcolor := clRed;
            TextOut(mmx, bby + 14 * 3, IntToStr(g_MyHero.m_Abil.HandWeight) + '/' + IntToStr(g_MyHero.m_Abil.MaxHandWeight), hcolor);

            hcolor := clSilver;
            TextOut(bbx, bby + 14 * 4, 'Accuracy ', hcolor);
            TextOut(mmx, bby + 14 * 4, IntToStr(g_nMyHeroHitPoint), hcolor);

            TextOut(bbx, bby + 14 * 5, 'Agility ', hcolor);
            TextOut(mmx, bby + 14 * 5, IntToStr(g_nMyHeroSpeedPoint), hcolor);

            TextOut(bbx, bby + 14 * 6, 'M. Resistance ', hcolor);
            TextOut(mmx, bby + 14 * 6, '+' + IntToStr(g_nMyHeroAntiMagic * 10) + '%', hcolor);

            TextOut(bbx, bby + 14 * 7, 'P. Resistance ', hcolor);
            TextOut(mmx, bby + 14 * 7, '+' + IntToStr(g_nMyHeroAntiPoison * 10) + '%', hcolor);

            TextOut(bbx, bby + 14 * 8, 'P. Recovery ', hcolor);
            TextOut(mmx, bby + 14 * 8, '+' + IntToStr(g_nMyHeroPoisonRecover * 10) + '%', hcolor);

            TextOut(bbx, bby + 14 * 9, 'HP Recovery ', hcolor);
            TextOut(mmx, bby + 14 * 9, '+' + IntToStr(g_nMyHeroHealthRecover * 10) + '%', hcolor);

            TextOut(bbx, bby + 14 * 10, 'MP Recovery ', hcolor);
            TextOut(mmx, bby + 14 * 10, '+' + IntToStr(g_nMyHeroSpellRecover * 10) + '%', hcolor);
          end;
        end;
      3: begin //魔法
          bbx := Left + 38;
          bby := Top + 52;
          d := g_WMain2Images.Images[751];
          if d <> nil then
            dsurface.Draw(SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, False);
          Heromagtop := HeroMagicPage * 6;
          magline := _MIN(HeroMagicPage * 6 + 6, g_HeroMagicList.Count);
          for I := Heromagtop to magline - 1 do begin
            pm := PTClientMagic(g_HeroMagicList[I]);
            m := I - Heromagtop;
            keyimg := 0;
            case Byte(pm.Key) of
              Byte('1'): keyimg := 248;
              Byte('2'): keyimg := 249;
              Byte('3'): keyimg := 250;
              Byte('4'): keyimg := 251;
              Byte('5'): keyimg := 252;
              Byte('6'): keyimg := 253;
              Byte('7'): keyimg := 254;
              Byte('8'): keyimg := 255;
            end;
            if keyimg > 0 then begin
              d := g_WMainImages.Images[keyimg];
              if d <> nil then
                dsurface.Draw(bbx + 145, bby + 8 + m * 37, d.ClientRect, d, True);
            end;
            d := g_WMainImages.Images[112]; //lv
            if d <> nil then
              dsurface.Draw(bbx + 48, bby + 8 + 15 + m * 37, d.ClientRect, d, True);
            d := g_WMainImages.Images[111]; //exp
            if d <> nil then
              dsurface.Draw(bbx + 48 + 26, bby + 8 + 15 + m * 37, d.ClientRect, d, True);
          end;

          with dsurface do begin
            for I := Heromagtop to magline - 1 do begin
              pm := PTClientMagic(g_HeroMagicList[I]);
              m := I - Heromagtop;

              hcolor := clWhite;
              if Ord(pm.Key) = 0 then hcolor := clGray;

              if pm.Def.wMagicId in [13, 26, 31, 45] then begin
                if not (pm.Level in [0..4]) then pm.Level := 0; //魔法最多4级
              end else begin
                if not (pm.Level in [0..3]) then pm.Level := 0; //魔法最多3级
              end;
              TextOut(bbx + 48, bby + 8 + m * 37, pm.Def.sMagicName, hcolor);

              if pm.Def.wMagicId in [13, 26, 31, 45] then begin
                if pm.Level in [0..4] then begin
                  trainlv := pm.Level;
                  if trainlv >= 3 then trainlv := trainlv - 1;
                end else trainlv := 0;
              end else begin
                if pm.Level in [0..3] then trainlv := pm.Level
                else trainlv := 0;
              end;

              TextOut(bbx + 48 + 16, bby + 8 + 15 + m * 37, IntToStr(pm.Level), hcolor);
              if pm.Def.MaxTrain[trainlv] > 0 then begin
               { if pm.Def.wMagicId in [13, 26, 45] then begin
                  if trainlv < 4 then
                    TextOut(bbx + 48 + 46, bby + 8 + 15 + m * 37, IntToStr(pm.CurTrain) + '/' + IntToStr(pm.Def.MaxTrain[trainlv]))
                  else TextOut(bbx + 48 + 46, bby + 8 + 15 + m * 37, '-');
                end else begin }
                if trainlv < 3 then
                  TextOut(bbx + 48 + 46, bby + 8 + 15 + m * 37, IntToStr(pm.CurTrain) + '/' + IntToStr(pm.Def.MaxTrain[trainlv]), hcolor)
                else TextOut(bbx + 48 + 46, bby + 8 + 15 + m * 37, '-', hcolor);
                //end;
              end;
            end;
          end;
        end;
    end;
    if (g_ServerConfig.btShowClientItemStyle <> 0) then begin
      if g_MouseHeroStateItem.s.Name <> '' then begin
        g_MouseHeroItem := g_MouseHeroStateItem;
        GetMouseItemInfo(g_MyHero, @g_MouseHeroItem, iname, d1, d2, d3, useable);
        if iname <> '' then begin
          if g_MouseHeroItem.Dura = 0 then hcolor := clRed
          else hcolor := clWhite;
          with dsurface do begin
            bbx := SurfaceX(Left + 37);
            bby := SurfaceY(Top + 272 + 35);
            TextOut(bbx, bby, iname, clyellow);
            TextOut(bbx + TextWidth(iname), bby, d1, hcolor);
            TextOut(bbx, bby + TextHeight('A') + 2, d2, hcolor);
            TextOut(bbx, bby + (TextHeight('A') + 2) * 2, d3, hcolor);
            if d2 <> '' then
              bby := bby + TextHeight('A') + 2;
            if d3 <> '' then
              bby := bby + TextHeight('A') + 2;

            bby := bby + TextHeight('A') + 2;
            for I := 0 to g_ExtractStringList.Count - 1 do begin
              TextOut(bbx, bby + (TextHeight('A') + 2) * I, g_ExtractStringList.Strings[I], hcolor);
            end;
          end;
        end;
        g_MouseHeroItem.s.Name := '';
      end;
    end;
     //玩家名称、行会
    if HeroStatePage = 0 then begin
      dsurface.TextOut(SurfaceX(Left + (Width - dsurface.TextWidth(g_MyHero.m_sUserName)) div 2),
        SurfaceY(Top + 60), g_MyHero.m_sUserName, g_MyHero.m_nNameColor);
    end;
  end;
end;

procedure TFrmDlg.DCloseHeroStateDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    if TDButton(Sender).Downed then begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DHeroSWLightDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  Idx: Integer;
  d: TTexture;
  nWhere: Integer;
begin
  if g_MyHero = nil then Exit;
  nWhere := -1;
  if HeroStatePage = 0 then begin
    if Sender = DHeroSWNecklace then nWhere := U_NECKLACE;
    if Sender = DHeroSWLight then nWhere := U_RIGHTHAND;
    if Sender = DHeroSWArmRingR then nWhere := U_ARMRINGR;
    if Sender = DHeroSWArmRingL then nWhere := U_ARMRINGL;
    if Sender = DHeroSWRingR then nWhere := U_RINGR;
    if Sender = DHeroSWRingL then nWhere := U_RINGL;
    if Sender = DHeroSWBujuk then nWhere := U_BUJUK;
    if Sender = DHeroSWBelt then nWhere := U_BELT;
    if Sender = DHeroSWBoots then nWhere := U_BOOTS;
    if Sender = DHeroSWCharm then nWhere := U_CHARM;

    if nWhere >= 0 then begin
      if g_HeroUseItems[nWhere].s.Name <> '' then begin
        Idx := g_HeroUseItems[nWhere].s.looks;
        if Idx >= 0 then begin
          d := GetWStateImg(Idx);
          if d <> nil then
            with TDButton(Sender) do
              dsurface.Draw(SurfaceX(Left + (Width - d.Width) div 2),
                SurfaceY(Top + (Height - d.Height) div 2),
                d.ClientRect, d, True);

          if (g_HeroUseItems[nWhere].s.AddValue[12] in [1, 3]) { or (GetAddPoint(g_HeroUseItems[nWhere].s.AddPoint))} then begin
            if GetTickCount - g_DrawHeroUseItems[nWhere].dwDrawTick >= 200 then begin
              g_DrawHeroUseItems[nWhere].dwDrawTick := GetTickCount;
              if g_DrawHeroUseItems[nWhere].nIndex <= 0 then g_DrawHeroUseItems[nWhere].nIndex := 260 - 1;
              Inc(g_DrawHeroUseItems[nWhere].nIndex);
              if g_DrawHeroUseItems[nWhere].nIndex > 265 then g_DrawHeroUseItems[nWhere].nIndex := 260;
            end;
            d := g_WMain2Images.Images[g_DrawHeroUseItems[nWhere].nIndex];
            if d <> nil then begin
              with TDButton(Sender) do
                DrawBlend(dsurface, SurfaceX(Left + (Width - d.Width) div 2),
                  SurfaceY(Top + (Height - d.Height) div 2), d);
            end;
          end;

          if g_HeroUseItems[nWhere].s.AddValue[12] >= 2 then begin
            if GetTickCount - g_DrawHeroUseItems_[nWhere].dwDrawTick >= 200 then begin
              g_DrawHeroUseItems_[nWhere].dwDrawTick := GetTickCount;
              if g_DrawHeroUseItems_[nWhere].nIndex <= 0 then g_DrawHeroUseItems_[nWhere].nIndex := 600 - 1;
              Inc(g_DrawHeroUseItems_[nWhere].nIndex);
              if g_DrawHeroUseItems_[nWhere].nIndex > 617 then g_DrawHeroUseItems_[nWhere].nIndex := 600;
            end;
            d := g_WMain3Images.Images[g_DrawHeroUseItems_[nWhere].nIndex];
            if d <> nil then begin
              with TDButton(Sender) do
                DrawBlend(dsurface, SurfaceX(Left + (Width - d.Width) div 2),
                  SurfaceY(Top + (Height - d.Height) div 2), d);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DHeroSWWeaponMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
  sel: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;
  hcolor: TColor;
  Butt: TDButton;
begin
  if HeroStatePage <> 0 then Exit;
  DScreen.ClearHint;
  sel := -1;
  Butt := TDButton(Sender);
  if Sender = DHeroSWDress then sel := U_DRESS;
  if Sender = DHeroSWWeapon then sel := U_WEAPON;
  if Sender = DHeroSWHelmet then sel := U_HELMET;
  if Sender = DHeroSWNecklace then sel := U_NECKLACE;
  if Sender = DHeroSWLight then sel := U_RIGHTHAND;
  if Sender = DHeroSWRingL then sel := U_RINGL;
  if Sender = DHeroSWRingR then sel := U_RINGR;
  if Sender = DHeroSWArmRingL then sel := U_ARMRINGL;
  if Sender = DHeroSWArmRingR then sel := U_ARMRINGR;

  if Sender = DHeroSWBujuk then sel := U_BUJUK;
  if Sender = DHeroSWBelt then sel := U_BELT;
  if Sender = DHeroSWBoots then sel := U_BOOTS;
  if Sender = DHeroSWCharm then sel := U_CHARM;

  g_MoveRect := TDButton(Sender).ClientRect;
  g_MoveRect.Right := g_MoveRect.Right + 4;

  if sel >= 0 then begin
    g_MouseHeroStateItem := g_HeroUseItems[sel];
      //原为注释掉 显示人物身上带的物品信息
    if (g_ServerConfig.btShowClientItemStyle = 0) then begin
      g_MouseHeroItem := g_HeroUseItems[sel];
      GetMouseItemInfo(g_MyHero, @g_MouseHeroItem, iname, d1, d2, d3, useable);
      if HintList.Count > 0 then begin
        with Sender as TDButton do
          DScreen.ShowHint(SurfaceX(Left - 30),
            SurfaceY(Top + 50),
            HintList, False);
      end;
      g_MouseHeroItem.s.Name := '';
    end;
  end else ClearMoveRect();
end;

procedure TFrmDlg.DHeroSWWeaponClick(Sender: TObject; X, Y: Integer);
var
  where, n, sel: Integer;
  flag, movcancel: Boolean;
begin
  if g_MyHero = nil then Exit;
  if HeroStatePage <> 0 then Exit;
  if (g_MovingItem.Owner = DStateWin) then Exit;
  if g_boItemMoving then begin
    flag := False;
    movcancel := False;
    if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then Exit;
    if (g_MovingItem.Owner = DDealDlg) then Exit;
    if (g_MovingItem.Item.s.Name = '') or (g_WaitingUseItem.Item.s.Name <> '') then Exit;
    where := GetTakeOnPosition(g_MovingItem.Item.s.StdMode);
    if g_MovingItem.Index >= 0 then begin
      case where of
        U_DRESS: begin
            if Sender = DHeroSWDress then begin
              if g_MyHero.m_btSex = 0 then
                if g_MovingItem.Item.s.StdMode <> 10 then
                  Exit;
              if g_MyHero.m_btSex = 1 then
                if g_MovingItem.Item.s.StdMode <> 11 then
                  Exit;
              flag := True;
            end;
          end;
        U_WEAPON: begin
            if Sender = DHeroSWWeapon then begin
              flag := True;
            end;
          end;
        U_NECKLACE: begin
            if Sender = DHeroSWNecklace then
              flag := True;
          end;
        U_RIGHTHAND: begin
            if Sender = DHeroSWLight then
              flag := True;
          end;
        U_HELMET: begin
            if Sender = DHeroSWHelmet then
              flag := True;
          end;
        U_RINGR, U_RINGL: begin
            if Sender = DHeroSWRingL then begin
              where := U_RINGL;
              flag := True;
            end;
            if Sender = DHeroSWRingR then begin
              where := U_RINGR;
              flag := True;
            end;
          end;
        U_ARMRINGR: begin
            if Sender = DHeroSWArmRingL then begin
              where := U_ARMRINGL;
              flag := True;
            end;
            if Sender = DHeroSWArmRingR then begin
              where := U_ARMRINGR;
              flag := True;
            end;
          end;
        U_ARMRINGL: begin
            if Sender = DHeroSWArmRingL then begin
              where := U_ARMRINGL;
              flag := True;
            end;
          end;
        U_BUJUK: begin
            if Sender = DHeroSWBujuk then begin
              where := U_BUJUK;
              flag := True;
            end;
            if Sender = DHeroSWArmRingL then begin
              where := U_ARMRINGL;
              flag := True;
            end;
          end;
        U_BELT: begin
            if Sender = DHeroSWBelt then begin
              where := U_BELT;
              flag := True;
            end;
          end;
        U_BOOTS: begin
            if Sender = DHeroSWBoots then begin
              where := U_BOOTS;
              flag := True;
            end;
          end;
        U_CHARM: begin
            if Sender = DHeroSWCharm then begin
              where := U_CHARM;
              flag := True;
            end;
          end;
      end;
    end else begin
      if (g_MovingItem.Owner = DHeroStateWin) then begin
        n := -(g_MovingItem.Index + 1);
        if n in [0..12] then begin
          ItemClickSound(g_MovingItem.Item.s);
          g_HeroUseItems[n] := g_MovingItem.Item;
          g_MovingItem.Item.s.Name := '';
          g_MovingItem.Owner := nil;
          g_boItemMoving := False;
        end;
      end;
    end;
    if flag then begin
      if (g_MovingItem.Owner = DItemBag) or (g_MovingItem.Owner = DUpgrade) or (g_MovingItem.Owner = DHeroItemBag) then begin
        ItemClickSound(g_MovingItem.Item.s);
        g_WaitingUseItem := g_MovingItem;
        g_WaitingUseItem.Index := where;
        if (g_MovingItem.Owner = DUpgrade) or (g_MovingItem.Owner = DItemBag) then begin
          frmMain.SendTakeOnItemFromMasterBag(where, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
        end else
          if (g_MovingItem.Owner = DHeroItemBag) then begin
          frmMain.SendHeroTakeOnItem(where, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
        end;
        g_MovingItem.Item.s.Name := '';
        g_MovingItem.Owner := nil;
        g_boItemMoving := False;
      end;
    end else begin
      if (Sender = DHeroSWBujuk) and (g_MovingItem.Owner = DHeroItemBag) then begin
        if (g_HeroUseItems[U_BUJUK].s.Name <> '') and (g_HeroUseItems[U_BUJUK].s.StdMode = 25) and (g_HeroUseItems[U_BUJUK].s.Shape = 9) then begin
          if g_MovingItem.Item.s.StdMode = 42 then begin
            ItemClickSound(g_MovingItem.Item.s);
            g_WaitingUseItem := g_MovingItem;
            g_WaitingUseItem.Index := U_BUJUK;
            if (g_MovingItem.Owner = DItemBag) then begin
              frmMain.SendRepairFirDragon(2, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
            end else
              if (g_MovingItem.Owner = DHeroItemBag) then begin
              frmMain.SendRepairFirDragon(4, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
            end;
            g_MovingItem.Item.s.Name := '';
            g_boItemMoving := False;
            g_MovingItem.Owner := nil;
          end;
        end;
      end;
    end;
  end else begin
    ClearMoveRect();
    flag := False;
    if (g_MovingItem.Item.s.Name <> '') or (g_WaitingUseItem.Item.s.Name <> '') then Exit;
    sel := -1;
    if Sender = DHeroSWDress then sel := U_DRESS;
    if Sender = DHeroSWWeapon then sel := U_WEAPON;
    if Sender = DHeroSWHelmet then sel := U_HELMET;
    if Sender = DHeroSWNecklace then sel := U_NECKLACE;
    if Sender = DHeroSWLight then sel := U_RIGHTHAND;
    if Sender = DHeroSWRingL then sel := U_RINGL;
    if Sender = DHeroSWRingR then sel := U_RINGR;
    if Sender = DHeroSWArmRingL then sel := U_ARMRINGL;
    if Sender = DHeroSWArmRingR then sel := U_ARMRINGR;

    if Sender = DHeroSWBujuk then sel := U_BUJUK;
    if Sender = DHeroSWBelt then sel := U_BELT;
    if Sender = DHeroSWBoots then sel := U_BOOTS;
    if Sender = DHeroSWCharm then sel := U_CHARM;

    if sel >= 0 then begin
      if g_HeroUseItems[sel].s.Name <> '' then begin
        ItemClickSound(g_HeroUseItems[sel].s);
        g_MovingItem.Index := -(sel + 1);
        g_MovingItem.Item := g_HeroUseItems[sel];
        g_HeroUseItems[sel].s.Name := '';
        g_boItemMoving := True;
        g_MovingItem.Owner := DHeroStateWin;
      end;
    end;
  end;
end;

procedure TFrmDlg.DHeroItemBagDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d0, d1, d2, d3: string;
  I, n, nX, nY: Integer;
  useable: Boolean;
  d: TTexture;
  nFaceIndex: Integer;
begin
  if g_MyHero = nil then Exit;
  with DHeroItemBag do begin
    d := nil;
    nFaceIndex := 375;
    case g_MyHero.m_nBagCount of
      10: nFaceIndex := 375;
      20: nFaceIndex := 376;
      30: nFaceIndex := 377;
      35: nFaceIndex := 378;
      40: nFaceIndex := 379;
    end;

    if FaceIndex <> nFaceIndex then begin
      SetImgIndex(g_WMain3Images, nFaceIndex);
    end;

    if WLib <> nil then
      d := WLib.Images[nFaceIndex];
    if d <> nil then begin
      //if Height <> d.Height then begin
     { Height := d.Height;
      Width := d.Width;
      DHeroItemGrid.RowCount := 2;
      DHeroItemGrid.Height := DHeroItemGrid.RowHeight * 2;}
      case g_MyHero.m_nBagCount of
        10: begin
            DHeroItemGrid.RowCount := 2;
            DHeroItemGrid.Height := DHeroItemGrid.RowHeight * 2;
          end;
        20: begin
            DHeroItemGrid.RowCount := 4;
            DHeroItemGrid.Height := DHeroItemGrid.RowHeight * 4;
          end;
        30: begin
            DHeroItemGrid.RowCount := 6;
            DHeroItemGrid.Height := DHeroItemGrid.RowHeight * 6;
          end;
        35: begin
            DHeroItemGrid.RowCount := 7;
            DHeroItemGrid.Height := DHeroItemGrid.RowHeight * 7;
          end;
        40: begin
            DHeroItemGrid.RowCount := 8;
            DHeroItemGrid.Height := DHeroItemGrid.RowHeight * 8;
          end;
      end;
      //end;
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;

    if (g_ServerConfig.btShowClientItemStyle <> 0) then begin
      GetMouseItemInfo(g_MyHero, @g_MouseHeroItem, d0, d1, d2, d3, useable);
      with dsurface do begin
      //英雄包裹装备信息
        if d0 <> '' then begin
          n := TextWidth(d0);

          nX := DHeroItemGrid.SurfaceX(DHeroItemGrid.Left) - 2;
          nY := DHeroItemGrid.SurfaceY(DHeroItemGrid.Top + DHeroItemGrid.Height + 24);

          TextOut(nX, nY, d0, clyellow);
          TextOut(nX + n, nY, d1);
          TextOut(nX, nY + 14, d2);
          if not useable then
            TextOut(nX, nY + 14 * 2, d3, clRed)
          else
            TextOut(nX, nY + 14 * 2, d3);
          if d2 <> '' then
            nY := nY + 14;
          if d3 <> '' then
            nY := nY + 14;

          nY := nY + 14;
          for I := 0 to g_ExtractStringList.Count - 1 do begin
            TextOut(nX, nY + 14 * I, g_ExtractStringList.Strings[I]);
          end;

        end else begin
          TextOut(DHeroItemGrid.SurfaceX(DHeroItemGrid.Left) - 2, DHeroItemGrid.SurfaceY(DHeroItemGrid.Top + DHeroItemGrid.Height + 24), '左键双击可以装备');
          TextOut(DHeroItemGrid.SurfaceX(DHeroItemGrid.Left) - 2, DHeroItemGrid.SurfaceY(DHeroItemGrid.Top + DHeroItemGrid.Height + 24 + 14), 'ALT + R 键刷新包裹');
          //TextOut(DHeroItemGrid.SurfaceX(DHeroItemGrid.Left) - 2, DHeroItemGrid.SurfaceY(DHeroItemGrid.Top + DHeroItemGrid.Height + 24 + 14 * 2), 'CTRL + B 英雄挂机');
        end;
      end;
    end else begin
      with dsurface do begin
        TextOut(DHeroItemGrid.SurfaceX(DHeroItemGrid.Left) - 2, DHeroItemGrid.SurfaceY(DHeroItemGrid.Top + DHeroItemGrid.Height + 24), '左键双击可以装备');
        TextOut(DHeroItemGrid.SurfaceX(DHeroItemGrid.Left) - 2, DHeroItemGrid.SurfaceY(DHeroItemGrid.Top + DHeroItemGrid.Height + 24 + 14), 'ALT + R 键刷新包裹');
        //TextOut(DHeroItemGrid.SurfaceX(DHeroItemGrid.Left) - 2, DHeroItemGrid.SurfaceY(DHeroItemGrid.Top + DHeroItemGrid.Height + 24 + 14 * 2), 'CTRL + B 英雄挂机');
      end;
    end;
  end;
end;

procedure TFrmDlg.DCloseHeroBagClick(Sender: TObject; X, Y: Integer);
begin
  DHeroItemBag.Visible := False;
end;

procedure TFrmDlg.DHeroItemGridDblClick(Sender: TObject);
var
  Idx, I, where: Integer;
  keyvalue: TKeyBoardState;
  cu: TClientItem;
  flag: Boolean;
begin
  Idx := DHeroItemGrid.Col + DHeroItemGrid.Row * DHeroItemGrid.ColCount;
  if Idx in [0..MAXHEROBAGITEM - 1] then begin
    if g_HeroItemArr[Idx].s.Name <> '' then begin
      FillChar(keyvalue, SizeOf(TKeyBoardState), #0);
      GetKeyboardState(keyvalue);
      if keyvalue[VK_CONTROL] = $80 then begin
        cu := g_HeroItemArr[Idx];
        g_HeroItemArr[Idx].s.Name := '';
        AddHeroItemBag(cu);
      end else
        if (g_HeroItemArr[Idx].s.StdMode <= 4) or (g_HeroItemArr[Idx].s.StdMode = 31) then begin
        frmMain.HeroEatItem(Idx);
      end else begin
        if (g_WaitingUseItem.Item.s.Name = '') then begin
          flag := False;
          where := GetTakeOnPosition(g_HeroItemArr[Idx].s.StdMode);
          case where of
            U_DRESS: begin
                if g_MyHero.m_btSex = 0 then
                  if g_HeroItemArr[Idx].s.StdMode = 10 then
                    flag := True;
                if g_MyHero.m_btSex = 1 then
                  if g_HeroItemArr[Idx].s.StdMode = 11 then
                    flag := True;
              end;
            U_WEAPON: flag := True;
            U_NECKLACE: flag := True;
            U_RIGHTHAND: flag := True;
            U_HELMET: flag := True;
            U_RINGR, U_RINGL: flag := True;
            U_ARMRINGR, U_ARMRINGL: flag := True;
            U_BUJUK: flag := True;
            U_BELT: flag := True;
            U_BOOTS: flag := True;
            U_CHARM: flag := True;
          end;
          if flag then begin
            if where in [U_RINGR, U_RINGL] then begin
              if g_HeroUseItems[U_RINGR].s.Name = '' then where := U_RINGR;
              if g_HeroUseItems[U_RINGL].s.Name = '' then where := U_RINGL;
              if (g_HeroUseItems[U_RINGR].s.Name <> '') and (g_HeroUseItems[U_RINGL].s.Name <> '') then begin
                if g_HeroItemArr[Idx].s.Name <> g_HeroUseItems[U_RINGR].s.Name then where := U_RINGR;
                if g_HeroItemArr[Idx].s.Name <> g_HeroUseItems[U_RINGL].s.Name then where := U_RINGL;
              end;
            end;

            if where in [U_ARMRINGR, U_ARMRINGL] then begin
              if g_HeroUseItems[U_ARMRINGR].s.Name = '' then where := U_ARMRINGR;
              if g_HeroUseItems[U_ARMRINGL].s.Name = '' then where := U_ARMRINGL;
              if (g_HeroUseItems[U_ARMRINGR].s.Name <> '') and (g_HeroUseItems[U_ARMRINGL].s.Name <> '') then begin
                if g_HeroItemArr[Idx].s.Name <> g_HeroUseItems[U_ARMRINGR].s.Name then where := U_ARMRINGR;
                if g_HeroItemArr[Idx].s.Name <> g_HeroUseItems[U_ARMRINGL].s.Name then where := U_ARMRINGL;
              end;
            end;
            g_WaitingUseItem.Index := where;
            g_WaitingUseItem.Item := g_HeroItemArr[Idx];
            g_HeroItemArr[Idx].s.Name := '';
            frmMain.SendHeroTakeOnItem(where, g_WaitingUseItem.Item.MakeIndex, g_WaitingUseItem.Item.s.Name);
          end;
        end;
      end;
    end else begin
      if g_boItemMoving and (g_MovingItem.Item.s.Name <> '') then begin
        FillChar(keyvalue, SizeOf(TKeyBoardState), #0);
        GetKeyboardState(keyvalue);
        if keyvalue[VK_CONTROL] = $80 then begin
          cu := g_MovingItem.Item;
          g_MovingItem.Item.s.Name := '';
          g_boItemMoving := False;
          AddHeroItemBag(cu);
        end else
          if (g_MovingItem.Index = Idx) and
          (g_MovingItem.Item.s.StdMode <= 4) or (g_HeroItemArr[Idx].s.StdMode = 31)
          then begin
          frmMain.HeroEatItem(-1);
        end else
          if (g_WaitingUseItem.Item.s.Name = '') then begin
          if g_MovingItem.Index >= 0 then begin
            flag := False;
            where := GetTakeOnPosition(g_MovingItem.Item.s.StdMode);
            case where of
              U_DRESS: begin
                  if g_MyHero.m_btSex = 0 then
                    if g_MovingItem.Item.s.StdMode = 10 then
                      flag := True;
                  if g_MyHero.m_btSex = 1 then
                    if g_MovingItem.Item.s.StdMode = 11 then
                      flag := True;
                end;
              U_WEAPON: flag := True;
              U_NECKLACE: flag := True;
              U_RIGHTHAND: flag := True;
              U_HELMET: flag := True;
              U_RINGR, U_RINGL: flag := True;
              U_ARMRINGR, U_ARMRINGL: flag := True;
              U_BUJUK: flag := True;
              U_BELT: flag := True;
              U_BOOTS: flag := True;
              U_CHARM: flag := True;
            end;

            if flag then begin
              if where in [U_RINGR, U_RINGL] then begin
                if g_HeroUseItems[U_RINGR].s.Name = '' then where := U_RINGR;
                if g_HeroUseItems[U_RINGL].s.Name = '' then where := U_RINGL;
                if (g_HeroUseItems[U_RINGR].s.Name <> '') and (g_HeroUseItems[U_RINGL].s.Name <> '') then begin
                  if g_MovingItem.Item.s.Name <> g_HeroUseItems[U_RINGR].s.Name then where := U_RINGR;
                  if g_MovingItem.Item.s.Name <> g_HeroUseItems[U_RINGL].s.Name then where := U_RINGL;
                end;
              end;

              if where in [U_ARMRINGR, U_ARMRINGL] then begin
                if g_HeroUseItems[U_ARMRINGR].s.Name = '' then where := U_ARMRINGR;
                if g_HeroUseItems[U_ARMRINGL].s.Name = '' then where := U_ARMRINGL;
                if (g_HeroUseItems[U_ARMRINGR].s.Name <> '') and (g_HeroUseItems[U_ARMRINGL].s.Name <> '') then begin
                  if g_MovingItem.Item.s.Name <> g_HeroUseItems[U_ARMRINGR].s.Name then where := U_ARMRINGR;
                  if g_MovingItem.Item.s.Name <> g_HeroUseItems[U_ARMRINGL].s.Name then where := U_ARMRINGL;
                end;
              end;

              g_WaitingUseItem := g_MovingItem;
              g_WaitingUseItem.Index := where;
              frmMain.SendHeroTakeOnItem(where, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
              g_MovingItem.Item.s.Name := '';
              g_MovingItem.Owner := nil;
              g_boItemMoving := False;
            end;
          end;
        end;
      end;
    end;
  end;
  ArrangeHeroItemBag;
end;

procedure TFrmDlg.DHeroItemGridGridSelect(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  Idx, mi: Integer;
  temp: TClientItem;
  where: Integer;
  flag: Boolean;
begin
  if g_MyHero = nil then Exit;
  //if g_btItemMoving = 5 then Exit;
  Idx := ACol + ARow * DHeroItemGrid.ColCount;
  if Idx in [0..MAXHEROBAGITEM - 1] then begin
    if not g_boItemMoving then begin
      ClearMoveRect();
      if g_HeroItemArr[Idx].s.Name <> '' then begin
        g_boItemMoving := True;
        g_MovingItem.Owner := DHeroItemBag;
        g_MovingItem.Index := Idx;
        g_MovingItem.Item := g_HeroItemArr[Idx];
        g_HeroItemArr[Idx].s.Name := '';
        ItemClickSound(g_HeroItemArr[Idx].s);
      end;
     { if g_boItemMoving and (g_MovingItem.Owner = DHeroItemBag) and (g_WaitingUseItem.Item.s.Name = '') then begin
        if mbRight = Button then begin //右键穿装备
          flag := False;
          where := GetTakeOnPosition(g_MovingItem.Item.s.StdMode);
          if g_MovingItem.Index >= 0 then begin
            case where of
              U_DRESS: begin
                  if g_MyHero.m_btSex = 0 then
                    if g_MovingItem.Item.s.StdMode <> 10 then
                      Exit;
                  if g_MyHero.m_btSex = 1 then
                    if g_MovingItem.Item.s.StdMode <> 11 then
                      Exit;
                  flag := True;
                end;
              U_WEAPON: flag := True;
              U_NECKLACE: flag := True;
              U_RIGHTHAND: flag := True;
              U_HELMET: flag := True;
              U_RINGR, U_RINGL: flag := True;
              U_ARMRINGR, U_ARMRINGL: flag := True;
              U_BUJUK: flag := True;
              U_BELT: flag := True;
              U_BOOTS: flag := True;
              U_CHARM: flag := True;
            end;
            if flag then begin
              if where in [U_RINGR, U_RINGL] then begin
                if g_HeroUseItems[U_RINGR].s.Name = '' then where := U_RINGR;
                if g_HeroUseItems[U_RINGL].s.Name = '' then where := U_RINGL;
                if (g_HeroUseItems[U_RINGR].s.Name <> '') and (g_HeroUseItems[U_RINGL].s.Name <> '') then begin
                  if g_MovingItem.Item.s.Name <> g_HeroUseItems[U_RINGR].s.Name then where := U_RINGR;
                  if g_MovingItem.Item.s.Name <> g_HeroUseItems[U_RINGL].s.Name then where := U_RINGL;
                end;
              end;

              if where in [U_ARMRINGR, U_ARMRINGL] then begin
                if g_HeroUseItems[U_ARMRINGR].s.Name = '' then where := U_ARMRINGR;
                if g_HeroUseItems[U_ARMRINGL].s.Name = '' then where := U_ARMRINGL;
                if (g_HeroUseItems[U_ARMRINGR].s.Name <> '') and (g_HeroUseItems[U_ARMRINGL].s.Name <> '') then begin
                  if g_MovingItem.Item.s.Name <> g_HeroUseItems[U_ARMRINGR].s.Name then where := U_ARMRINGR;
                  if g_MovingItem.Item.s.Name <> g_HeroUseItems[U_ARMRINGL].s.Name then where := U_ARMRINGL;
                end;
              end;

              g_WaitingUseItem := g_MovingItem;
              g_WaitingUseItem.Index := where;
              frmMain.SendHeroTakeOnItem(where, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
              g_MovingItem.Item.s.Name := '';
              g_boItemMoving := False;
            end else begin
              g_HeroItemArr[idx] := g_MovingItem.Item;
              g_MovingItem.Item.s.Name := '';
              g_boItemMoving := False;
            end;
          end;
        end else begin
          ItemClickSound(g_HeroItemArr[idx].s);
        end;
      end;}
    end else begin
      //ItemClickSound (MovingItem.Item.S.StdMode);
      mi := g_MovingItem.Index;
      if (g_MovingItem.Owner = DDealDlg) or (g_MovingItem.Owner = DUpgrade) then Exit;
      if (mi = -97) or (mi = -98) then Exit;
      if (mi < 0) and (mi >= -13 {-9}) and ((g_MovingItem.Owner = DHeroStateWin) or (g_MovingItem.Owner = DStateWin)) then begin //-99: 脱装备
        if (g_MovingItem.Owner = DStateWin) then begin
          frmMain.SendTakeOffItemToHeroBag(-(g_MovingItem.Index + 1), g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
        end else
          if (g_MovingItem.Owner = DHeroStateWin) then begin
          frmMain.SendHeroTakeOffItem(-(g_MovingItem.Index + 1), g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
        end;
        g_WaitingUseItem := g_MovingItem;
        g_MovingItem.Item.s.Name := '';
        g_boItemMoving := False;
        ArrangeHeroItemBag;
        Exit;
      end;

      if (g_MovingItem.Owner = DHeroItemBag) then begin //英雄包裹装备交换
        if (g_HeroItemArr[Idx].s.Name <> '') then begin
          temp := g_HeroItemArr[Idx];
          g_HeroItemArr[Idx] := g_MovingItem.Item;
          g_MovingItem.Index := Idx;
          g_MovingItem.Item := temp;
        end else begin
          g_boItemMoving := False;
          g_HeroItemArr[Idx] := g_MovingItem.Item;
          g_MovingItem.Item.s.Name := '';
          g_MovingItem.Owner := nil;
        end;
        ArrangeHeroItemBag;
        Exit;
      end;

      if (g_MovingItem.Owner = DItemBag) or (g_MovingItem.Owner = DUpgrade) then begin //英雄和主人包裹装备交换
        frmMain.SendItemToHeroBag((g_MovingItem.Index), g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
        g_boItemMoving := False;
        g_WaitingUseItem := g_MovingItem;
        g_MovingItem.Item.s.Name := '';
        ArrangeHeroItemBag;
        Exit;
      end;
    end;
  end;
  ArrangeHeroItemBag;
end;

procedure TFrmDlg.DHeroItemGridGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TTexture);
var
  nIdx: Integer;
  d: TTexture;
begin
  if g_MyHero = nil then Exit;
  nIdx := ACol + ARow * DHeroItemGrid.ColCount;
  if nIdx in [0..MAXHEROBAGITEM - 1] then begin
    if g_HeroItemArr[nIdx].s.Name <> '' then begin
      d := g_WBagItemImages.Images[g_HeroItemArr[nIdx].s.looks];
      if d <> nil then
        with DHeroItemGrid do begin
          dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
            d.ClientRect,
            d, True);
        end;

      with DHeroItemGrid do begin
        if (g_HeroItemArr[nIdx].s.AddValue[12] in [1, 3]) {or (GetAddPoint(g_HeroItemArr[nIdx].s.AddPoint))} then begin
          if GetTickCount - g_DrawHeroItemArr[nIdx].dwDrawTick >= 200 then begin
            g_DrawHeroItemArr[nIdx].dwDrawTick := GetTickCount;
            if g_DrawHeroItemArr[nIdx].nIndex <= 0 then g_DrawHeroItemArr[nIdx].nIndex := 260 - 1;
            Inc(g_DrawHeroItemArr[nIdx].nIndex);
            if g_DrawHeroItemArr[nIdx].nIndex > 265 then g_DrawHeroItemArr[nIdx].nIndex := 260;
          end;
          d := g_WMain2Images.Images[g_DrawHeroItemArr[nIdx].nIndex];
          if d <> nil then begin
            DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1), d);
          end;
        end;

        if g_HeroItemArr[nIdx].s.AddValue[12] >= 2 then begin
          if GetTickCount - g_DrawHeroItemArr_[nIdx].dwDrawTick >= 200 then begin
            g_DrawHeroItemArr_[nIdx].dwDrawTick := GetTickCount;
            if g_DrawHeroItemArr_[nIdx].nIndex <= 0 then g_DrawHeroItemArr_[nIdx].nIndex := 600 - 1;
            Inc(g_DrawHeroItemArr_[nIdx].nIndex);
            if g_DrawHeroItemArr_[nIdx].nIndex > 617 then g_DrawHeroItemArr_[nIdx].nIndex := 600;
          end;
          d := g_WMain3Images.Images[g_DrawHeroItemArr_[nIdx].nIndex];
          if d <> nil then begin
            DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1), d);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DHeroItemGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  nIdx: Integer;
  temp: TClientItem;
  iname, d1, d2, d3: string;
  useable: Boolean;
  hcolor: TColor;
  nWhere: Byte;
  boShowMsg: Boolean;
  List: TStringList;
begin
  DScreen.ClearHint;
  boShowMsg := False;
  if ssRight in Shift then begin
    if g_boItemMoving then
      DHeroItemGridGridSelect(Self, ACol, ARow, Shift);
  end else begin
    nIdx := ACol + ARow * DHeroItemGrid.ColCount;
    if nIdx in [0..MAXHEROBAGITEM - 1] then begin
      g_MoveRect := DHeroItemGrid.ClientRect;
     {g_MoveRect.Right := g_MoveRect.Right - 4;
      g_MoveRect.Top := g_MoveRect.Top + 2;}

      g_MouseHeroItem := g_HeroItemArr[nIdx];
      if (g_MouseHeroItem.s.Name <> '') then begin
        if (g_ServerConfig.btShowClientItemStyle = 0) then begin
          nWhere := GetHeroUseItemByBagItem(g_MouseHeroItem.s.StdMode);
          if g_Config.boCompareItem and (nWhere >= 0) then begin

            List := TStringList.Create;
            try
              GetMouseItemInfo(g_MyHero, @g_MouseHeroItem, iname, d1, d2, d3, useable);
              List.AddStrings(HintList);

              GetMouseItemInfo(g_MyHero, @g_HeroUseItems[nWhere], iname, d1, d2, d3, useable);
              if HintList.Count > 0 then begin
                HintList.Strings[0] := GetUseItemName(nWhere) + ' ' + HintList.Strings[0];
              end;
              with DHeroItemGrid do
                DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
                  SurfaceY(Top + (ARow + 1) * RowHeight),
                  List, HintList, False);
              HintList.Clear;
            finally
              List.Free;
            end;
            g_MouseHeroItem.s.Name := '';
          end else begin
            GetMouseItemInfo(g_MyHero, @g_MouseHeroItem, iname, d1, d2, d3, useable);
            if HintList.Count > 0 then begin
              with DHeroItemGrid do
                DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
                  SurfaceY(Top + (ARow + 1) * RowHeight),
                  HintList, False);
            end;
          end;

          {GetMouseItemInfo(g_MyHero, @g_MouseHeroItem, iname, d1, d2, d3, useable);
          if (HintList.Count > 0) then begin
            with DHeroItemGrid do
              DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
                SurfaceY(Top + (ARow + 1) * RowHeight),
                HintList, False);
          end;}
        end;
      end;
    end else ClearMoveRect();
  end;
end;

procedure TFrmDlg.DButtonReCallHeroClick(Sender: TObject; X, Y: Integer);
begin
  if g_MyHero = nil then begin
    if GetTickCount - g_dwRecallHeroTick > 500 then begin
      g_dwRecallHeroTick := GetTickCount;
      frmMain.SendClientMessage(CM_HEROLOGON, 0, 0, 0, 0);
    end;
  end else begin
    frmMain.SendClientMessage(CM_HEROLOGOUT, g_MyHero.m_nRecogId, 0, 0, 0);
  end;
end;

procedure TFrmDlg.DButtonHeroStateClick(Sender: TObject; X, Y: Integer);
begin
  if g_MyHero = nil then Exit;
  DHeroStateWin.Visible := not DHeroStateWin.Visible;
end;

procedure TFrmDlg.DButtonHeroBagClick(Sender: TObject; X, Y: Integer);
begin
  if g_MyHero = nil then Exit;
  DHeroItemBag.Visible := not DHeroItemBag.Visible;
  //DBoxItemGrid.Visible := DHeroItemBag.Visible;
end;

procedure TFrmDlg.OpenHeroHealthState;
begin
  if not DHeroHealthStateWin.Visible then
    DHeroHealthStateWin.Visible := True;
  if DMerchantDlg.Visible then begin
    DMerchantDlg.Floating := True;
    try
      DMerchantDlg.Visible := True;
    finally
      DMerchantDlg.Floating := False;
    end;
  end;
end;

procedure TFrmDlg.CloseHeroAllWindows;
begin
  DHeroHealthStateWin.Visible := False;
  DHeroItemBag.Visible := False;
  DHeroStateWin.Visible := False;
end;

procedure TFrmDlg.DCloseHeroStateClick(Sender: TObject; X, Y: Integer);
begin
  DHeroStateWin.Visible := False;
end;

procedure TFrmDlg.DCloseHeroBagDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with DCloseHeroBag do begin
    if Downed then begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DPrevHeroStateClick(Sender: TObject; X, Y: Integer);
begin
  Dec(HeroStatePage);
  if HeroStatePage < 0 then
    HeroStatePage := MAXHEROSTATEPAGE - 1;
  HeroPageChanged;
end;

procedure TFrmDlg.DNextHeroStateClick(Sender: TObject; X, Y: Integer);
begin
  Inc(HeroStatePage);
  if HeroStatePage > MAXHEROSTATEPAGE - 1 then
    HeroStatePage := 0;
  HeroPageChanged;
end;

procedure TFrmDlg.DHeroStMag1DirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  Idx, icon: Integer;
  d: TTexture;
  pm: PTClientMagic;
begin
  if g_MyHero = nil then Exit;
  with Sender as TDButton do begin
    Idx := _MAX(tag + HeroMagicPage * 6, 0);
    if Idx < g_HeroMagicList.Count then begin
      pm := PTClientMagic(g_HeroMagicList[Idx]);
      icon := pm.Def.btEffect * 2;
     { if pm.Level >= 4 then begin
        case pm.Def.wMagicId of
          13: icon := 140;
          26: icon := 142;
          31: icon := 104;
          45: icon := 144;
        end;
      end;
      }
      if pm.Def.btEffect = 50 then icon := 84;
      //if pm.Def.btEffect = 51 then icon := 94;

      if pm.Def.btEffect = 70 then icon := 1 * 2;
      if pm.Def.btEffect = 71 then icon := 3 * 2;
      if pm.Def.btEffect = 72 then icon := 10 * 2;

      if pm.Level >= 4 then begin
        case pm.Def.wMagicId of
          13: icon := 140;
          26: icon := 142;
          31: icon := 104;
          45: icon := 144;
        end;
      end;

      if icon >= 0 then begin
        if not Downed then begin
          d := g_WMagIconImages.Images[icon];

          if (Ord(pm.Key) = 0) and (d <> nil) then begin
            g_ImgMixSurface.SetSize(d.Width, d.Height);
            g_ImgMixSurface.Fill(0);
            g_ImgMixSurface.Draw(0, 0, d.ClientRect, d, False);
            DrawEffect(0, 0, g_ImgMixSurface, d, ceGrayScale);
            d := g_ImgMixSurface;
          end;

          if d <> nil then
            dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        end else begin
          d := g_WMagIconImages.Images[icon + 1];

          if (Ord(pm.Key) = 0) and (d <> nil) then begin
            g_ImgMixSurface.SetSize(d.Width, d.Height);
            g_ImgMixSurface.Fill(0);
            g_ImgMixSurface.Draw(0, 0, d.ClientRect, d, False);
            DrawEffect(0, 0, g_ImgMixSurface, d, ceGrayScale);
            d := g_ImgMixSurface;
          end;

          if d <> nil then
            dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DHeroStPageUpClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DHeroStPageUp then begin
    if HeroMagicPage > 0 then
      Dec(HeroMagicPage);
  end else begin
    if HeroMagicPage < (g_HeroMagicList.Count + 5) div 6 - 1 then
      Inc(HeroMagicPage);
  end;
end;

procedure TFrmDlg.DOptionClick();
var
  I: Integer;
begin
  DConfigDlg.Visible := not DConfigDlg.Visible;
  if DConfigDlg.Visible then begin

    // Auto-Pot HP Box One [Player]
    DComboboxHumHP1.Items.Clear;
    for I := Low(g_ItemArr) to High(g_ItemArr) do begin
      if (g_ItemArr[I].s.Name <> '') and (g_ItemArr[I].s.StdMode = 0) and (g_ItemArr[I].s.AC > 0) then
        DComboboxHumHP1.Items.Add(g_ItemArr[I].s.Name);
    end;

    if (g_Config.nRenewHumHPIndex1 >= 0) and (g_Config.nRenewHumHPIndex1 < DComboboxHumHP1.Items.Count) then begin
        if g_Config.sRenewHumHPItem1Name = DComboboxHumHP1.Items.Strings[g_Config.nRenewHumHPIndex1] then Exit;
    end;
    g_Config.nRenewHumHPIndex1 := -1;
    DComboboxHumHP1.ItemIndex := -1;
    for I := 0 to DComboboxHumHP1.Items.Count - 1 do begin
      if CompareText(g_Config.sRenewHumHPItem1Name, DComboboxHumHP1.Items.Strings[I]) = 0 then begin
        g_Config.nRenewHumHPIndex1 := I;
        DComboboxHumHP1.ItemIndex := I;
        Break;
      end;
    end;
    DComboboxHumHP1.Text := g_Config.sRenewHumHPItem1Name;

    // Auto-Pot HP Box Two [Player]
    DComboboxHumHP2.Items.Clear;
    for I := Low(g_ItemArr) to High(g_ItemArr) do begin
      if (g_ItemArr[I].s.Name <> '') and (g_ItemArr[I].s.StdMode = 0) and (g_ItemArr[I].s.AC > 0) then
        DComboboxHumHP2.Items.Add(g_ItemArr[I].s.Name);
    end;

    if (g_Config.nRenewHumHPIndex2 >= 0) and (g_Config.nRenewHumHPIndex2 < DComboboxHumHP2.Items.Count) then begin
        if g_Config.sRenewHumHPItem2Name = DComboboxHumHP2.Items.Strings[g_Config.nRenewHumHPIndex2] then Exit;
    end;
    g_Config.nRenewHumHPIndex2 := -1;
    DComboboxHumHP2.ItemIndex := -1;
    for I := 0 to DComboboxHumHP2.Items.Count - 1 do begin
      if CompareText(g_Config.sRenewHumHPItem2Name, DComboboxHumHP2.Items.Strings[I]) = 0 then begin
        g_Config.nRenewHumHPIndex2 := I;
        DComboboxHumHP2.ItemIndex := I;
        Break;
      end;
    end;
    DComboboxHumHP2.Text := g_Config.sRenewHumHPItem2Name;

    // Auto-Pot MP Box One [Player]
    DComboboxHumMP1.Items.Clear;
    for I := Low(g_ItemArr) to High(g_ItemArr) do begin
      if (g_ItemArr[I].s.Name <> '') and (g_ItemArr[I].s.StdMode = 0) and (g_ItemArr[I].s.MAC > 0) then
        DComboboxHumMP1.Items.Add(g_ItemArr[I].s.Name);
    end;

    if (g_Config.nRenewHumMPIndex1 >= 0) and (g_Config.nRenewHumMPIndex1 < DComboboxHumMP1.Items.Count) then begin
        if g_Config.sRenewHumMPItem1Name = DComboboxHumMP1.Items.Strings[g_Config.nRenewHumMPIndex1] then Exit;
    end;
    g_Config.nRenewHumMPIndex1 := -1;
    DComboboxHumMP1.ItemIndex := -1;
    for I := 0 to DComboboxHumMP1.Items.Count - 1 do begin
      if CompareText(g_Config.sRenewHumMPItem1Name, DComboboxHumMP1.Items.Strings[I]) = 0 then begin
        g_Config.nRenewHumMPIndex1 := I;
        DComboboxHumMP1.ItemIndex := I;
        Break;
      end;
    end;
    DComboboxHumMP1.Text := g_Config.sRenewHumMPItem1Name;

    // Auto-Pot MP Box Two [Player]
    DComboboxHumMP2.Items.Clear;
    for I := Low(g_ItemArr) to High(g_ItemArr) do begin
      if (g_ItemArr[I].s.Name <> '') and (g_ItemArr[I].s.StdMode = 0) and (g_ItemArr[I].s.MAC > 0) then
        DComboboxHumMP2.Items.Add(g_ItemArr[I].s.Name);
    end;

    if (g_Config.nRenewHumMPIndex2 >= 0) and (g_Config.nRenewHumMPIndex2 < DComboboxHumMP2.Items.Count) then begin
        if g_Config.sRenewHumMPItem2Name = DComboboxHumMP2.Items.Strings[g_Config.nRenewHumMPIndex2] then Exit;
    end;
    g_Config.nRenewHumMPIndex2 := -1;
    DComboboxHumMP2.ItemIndex := -1;
    for I := 0 to DComboboxHumMP2.Items.Count - 1 do begin
      if CompareText(g_Config.sRenewHumMPItem2Name, DComboboxHumMP2.Items.Strings[I]) = 0 then begin
        g_Config.nRenewHumMPIndex2 := I;
        DComboboxHumMP2.ItemIndex := I;
        Break;
      end;
    end;
    DComboboxHumMP2.Text := g_Config.sRenewHumMPItem2Name;

    // Auto-Pot HP Box One [Hero]
    DComboboxHeroHP1.Items.Clear;
    for I := Low(g_HeroItemArr) to High(g_HeroItemArr) do begin
      if (g_HeroItemArr[I].s.Name <> '') and (g_HeroItemArr[I].s.StdMode = 0) and (g_HeroItemArr[I].s.AC > 0) then
        DComboboxHeroHP1.Items.Add(g_HeroItemArr[I].s.Name);
    end;

    if (g_Config.nRenewHeroHPIndex1 >= 0) and (g_Config.nRenewHeroHPIndex1 < DComboboxHeroHP1.Items.Count) then begin
        if g_Config.sRenewHeroHPItem1Name = DComboboxHeroHP1.Items.Strings[g_Config.nRenewHeroHPIndex1] then Exit;
    end;
    g_Config.nRenewHeroHPIndex1 := -1;
    DComboboxHeroHP1.ItemIndex := -1;
    for I := 0 to DComboboxHeroHP1.Items.Count - 1 do begin
      if CompareText(g_Config.sRenewHeroHPItem1Name, DComboboxHeroHP1.Items.Strings[I]) = 0 then begin
        g_Config.nRenewHeroHPIndex1 := I;
        DComboboxHeroHP1.ItemIndex := I;
        Break;
      end;
    end;
    DComboboxHeroHP1.Text := g_Config.sRenewHeroHPItem1Name;

    // Auto-Pot HP Box Two [Hero]
    DComboboxHeroHP2.Items.Clear;
    for I := Low(g_HeroItemArr) to High(g_HeroItemArr) do begin
      if (g_HeroItemArr[I].s.Name <> '') and (g_HeroItemArr[I].s.StdMode = 0) and (g_HeroItemArr[I].s.AC > 0) then
        DComboboxHeroHP2.Items.Add(g_HeroItemArr[I].s.Name);
    end;

    if (g_Config.nRenewHeroHPIndex2 >= 0) and (g_Config.nRenewHeroHPIndex2 < DComboboxHeroHP2.Items.Count) then begin
        if g_Config.sRenewHeroHPItem2Name = DComboboxHeroHP2.Items.Strings[g_Config.nRenewHeroHPIndex2] then Exit;
    end;
    g_Config.nRenewHeroHPIndex2 := -1;
    DComboboxHeroHP2.ItemIndex := -1;
    for I := 0 to DComboboxHeroHP2.Items.Count - 1 do begin
      if CompareText(g_Config.sRenewHeroHPItem2Name, DComboboxHeroHP2.Items.Strings[I]) = 0 then begin
        g_Config.nRenewHeroHPIndex2 := I;
        DComboboxHeroHP2.ItemIndex := I;
        Break;
      end;
    end;
    DComboboxHeroHP2.Text := g_Config.sRenewHeroHPItem2Name;

    // Auto-Pot MP Box One [Hero]
    DComboboxHeroMP1.Items.Clear;
    for I := Low(g_HeroItemArr) to High(g_HeroItemArr) do begin
      if (g_HeroItemArr[I].s.Name <> '') and (g_HeroItemArr[I].s.StdMode = 0) and (g_HeroItemArr[I].s.MAC > 0) then
        DComboboxHeroMP1.Items.Add(g_HeroItemArr[I].s.Name);
    end;

    if (g_Config.nRenewHeroMPIndex1 >= 0) and (g_Config.nRenewHeroMPIndex1 < DComboboxHeroMP1.Items.Count) then begin
        if g_Config.sRenewHeroMPItem1Name = DComboboxHeroMP1.Items.Strings[g_Config.nRenewHeroMPIndex1] then Exit;
    end;
    g_Config.nRenewHeroMPIndex1 := -1;
    DComboboxHeroMP1.ItemIndex := -1;
    for I := 0 to DComboboxHeroMP1.Items.Count - 1 do begin
      if CompareText(g_Config.sRenewHeroMPItem1Name, DComboboxHeroMP1.Items.Strings[I]) = 0 then begin
        g_Config.nRenewHeroMPIndex1 := I;
        DComboboxHeroMP1.ItemIndex := I;
        Break;
      end;
    end;
    DComboboxHeroMP1.Text := g_Config.sRenewHeroMPItem1Name;

    // Auto-Pot MP Box Two [Hero]
    DComboboxHeroMP2.Items.Clear;
    for I := Low(g_HeroItemArr) to High(g_HeroItemArr) do begin
      if (g_HeroItemArr[I].s.Name <> '') and (g_HeroItemArr[I].s.StdMode = 0) and (g_HeroItemArr[I].s.AC > 0) then
        DComboboxHeroMP2.Items.Add(g_HeroItemArr[I].s.Name);
    end;

    if (g_Config.nRenewHeroMPIndex2 >= 0) and (g_Config.nRenewHeroMPIndex2 < DComboboxHeroMP2.Items.Count) then begin
        if g_Config.sRenewHeroMPItem2Name = DComboboxHeroMP2.Items.Strings[g_Config.nRenewHeroMPIndex2] then Exit;
    end;
    g_Config.nRenewHeroMPIndex2 := -1;
    DComboboxHeroMP2.ItemIndex := -1;
    for I := 0 to DComboboxHeroMP2.Items.Count - 1 do begin
      if CompareText(g_Config.sRenewHeroMPItem2Name, DComboboxHeroMP2.Items.Strings[I]) = 0 then begin
        g_Config.nRenewHeroMPIndex2 := I;
        DComboboxHeroMP2.ItemIndex := I;
        Break;
      end;
    end;
    DComboboxHeroMP2.Text := g_Config.sRenewHeroMPItem2Name;

    DComboboxBookIndex.Items.Clear;
    for I := Low(g_ItemArr) to High(g_ItemArr) do begin
      if g_ItemArr[I].s.Name <> '' then
        DComboboxBookIndex.Items.Add(g_ItemArr[I].s.Name);
    end;
    if g_Config.sRenewBookNowBookItem <> '' then begin
      if (g_Config.nRenewBookNowBookIndex >= 0) and (g_Config.nRenewBookNowBookIndex < DComboboxBookIndex.Items.Count) then begin
        if g_Config.sRenewBookNowBookItem = DComboboxBookIndex.Items.Strings[g_Config.nRenewBookNowBookIndex] then Exit;
      end;
      g_Config.nRenewBookNowBookIndex := -1;
      DComboboxBookIndex.ItemIndex := -1;
      for I := 0 to DComboboxBookIndex.Items.Count - 1 do begin
        if CompareText(g_Config.sRenewBookNowBookItem, DComboboxBookIndex.Items.Strings[I]) = 0 then begin
          g_Config.nRenewBookNowBookIndex := I;
          DComboboxBookIndex.ItemIndex := I;
          Break;
        end;
      end;
      SaveUserConfig();
    end;
    DComboboxBookIndex.Text := g_Config.sRenewBookNowBookItem;
  end;
end;

procedure TFrmDlg.DHeroStateWinMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  DScreen.ClearHint;
  HintList.Clear;
  g_MouseHeroStateItem.s.Name := '';
  g_MouseHeroItem.s.Name := '';
  g_MouseItem.s.Name := '';
end;

procedure TFrmDlg.DHeroHealthStateWinClick(Sender: TObject; X, Y: Integer);
begin
  if ((g_MovingItem.Owner = DItemBag) or (g_MovingItem.Owner = DUpgrade)) and (g_MovingItem.Item.s.Name <> '') then begin
    g_boItemMoving := False;
    g_WaitingUseItem := g_MovingItem;
    frmMain.SendItemToHeroBag(g_MovingItem.Index, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.s.Name);
    ItemClickSound(g_MovingItem.Item.s);
    g_MovingItem.Item.s.Name := '';
    g_MovingItem.Owner := nil;
  end;
end;

procedure TFrmDlg.DFirDragonDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  rc: TRect;
begin
  with DFirDragon do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);

    d := nil;
    if g_MyHero <> nil then begin
      if g_HeroUseItems[U_BUJUK].s.Name <> '' then begin
        if (g_HeroUseItems[U_BUJUK].s.StdMode = 25) and (g_HeroUseItems[U_BUJUK].s.Shape = 9) then begin
          if g_MyHero.m_nAngryValue >= g_MyHero.m_nMaxAngryValue then begin
            if GetTickCount - g_dwFirDragonTick > 500 then begin
              g_dwFirDragonTick := GetTickCount;
              Inc(g_nFirDragon);
              if g_nFirDragon > 1 then g_nFirDragon := 0;
            end;
            d := g_WMain3Images.Images[411 + g_nFirDragon];
          end else begin
            d := g_WMain3Images.Images[411];
          end;
          if g_MyHero.m_nMaxAngryValue > 0 then begin
            if d <> nil then begin
          //火龙之心
              rc := d.ClientRect;
              rc.Top := Round(rc.Bottom / g_MyHero.m_nMaxAngryValue * (g_MyHero.m_nMaxAngryValue - g_MyHero.m_nAngryValue));

              dsurface.Draw(SurfaceX(Left) + 2, SurfaceY(Top) + rc.Top + 20 {SCREENHEIGHT - d.Height}, rc, d, True);
            //DebugOutStr('dsurface.Draw');
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.OpenSellOffDlg;
begin
  SellItemIndex := -1;
  MoveSellItemIndex := -1;
  DUserSellOff.Visible := True;
  EdSearch.SetFocus;
end;

procedure TFrmDlg.CloseSellOffDlg;
begin
  DUserSellOff.Visible := False;
  ReleaseDFocus;
  if EdChat.Visible then EdChat.SetFocus;
end;

procedure TFrmDlg.OpenStoreDlg;
begin
  if not g_MySelf.m_boStartStore then begin
    DItemBag.Left := SCREENWIDTH - DItemBag.Width - 40; //475;
    DItemBag.Top := 20;
    DItemBag.Visible := True;

    DStoreDlg.Left := DItemBag.Left - DStoreDlg.Width - 30;
    DStoreDlg.Top := 45;
  end;
  DStoreDlg.Visible := True;
  DEditStore.SetFocus;
end;

procedure TFrmDlg.CloseStoreDlg;
var
  I: Integer;
begin
  if (g_MySelf <> nil) and (not g_MySelf.m_boStartStore) and (not g_boStartStoreing) then begin
    for I := 0 to 14 do begin
      if g_StoreItems[I].Item.s.Name <> '' then begin
        AddItemBag(g_StoreItems[I].Item);
      end;
      g_StoreItems[I].Item.s.Name := '';
    end;
  end;
  DItemBag.Left := 0;
  DItemBag.Top := 80;

  DStoreDlg.Visible := False;
  ReleaseDFocus;
  if EdChat.Visible then EdChat.SetFocus;
end;

procedure TFrmDlg.OpenUserStoreDlg;
begin
  g_SelectStoreItem.Item.s.Name := '';
  DUserStore.Visible := True;
  DEditUserStore.SetFocus;
end;

procedure TFrmDlg.CloseUserStoreDlg;
begin
  g_SelectStoreItem.Item.s.Name := '';
  DUserStore.Visible := False;
  ReleaseDFocus;
  if EdChat.Visible then EdChat.SetFocus;
end;

procedure TFrmDlg.DSearchSellOffDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    if TDButton(Sender).Downed then begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex + 1];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end else begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DUserSellOffDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  I: Integer;
  //lh: Integer;
  nPrice: Integer;
  sPage: string;
  sName: string;
  sPrice: string;
  sCharName: string;
  nX1, nX2, nX3: Integer;
  nIndex, nX, nY: Integer;
  hcolor, keyimg, old: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;
  TempList: TStringList;
begin
  with DUserSellOff do begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    //Font.Color := clWhite;
    case g_nSellItemType of
      0: sName := '所有物品';
      1: sName := '所有衣服';
      2: sName := '所有武器';
      3: sName := '所有首饰';
      4: sName := '所有宝石';
      5: sName := '其他物品';
      6: sName := '我的物品';
      7: sName := '取款';
      8: sName := '查询物品';
    end;

    with dsurface do begin
      TextOut(SurfaceX(Left) + 222 - TextWidth(sName) div 2, SurfaceY(Top) + 14, sName);

      if g_nSellItemPageCount = 0 then begin
        sPage := Format('%d/%d', [g_nSellItemPage, g_nSellItemPageCount]);
      end else begin
        sPage := Format('%d/%d', [g_nSellItemPage + 1, g_nSellItemPageCount]);
      end;

      TextOut(SurfaceX(Left) + 410 - TextWidth(sPage) div 2, SurfaceY(Top) + 14, sPage);
      TextOut(SurfaceX(Left) + 73 - TextWidth('AA'), SurfaceY(Top) + 45, '物品');
      TextOut(SurfaceX(Left) + 233 - TextWidth('AA'), SurfaceY(Top) + 45, '价格');

      if g_nSellItemType in [6, 7] then begin
        TextOut(SurfaceX(Left) + 394 - TextWidth('AA'), SurfaceY(Top) + 45, '状态');
      end else begin
        TextOut(SurfaceX(Left) + 394 - TextWidth('AA'), SurfaceY(Top) + 45, '卖家');
      end;
    end;


    nX1 := SurfaceX(Left) + 28;
    nX2 := SurfaceX(Left) + 195;
    nX3 := SurfaceX(Left) + 343;
    nY := SurfaceY(Top) + 69;

    nIndex := 1;
    sName := '';
    sPrice := '';
    for I := Low(g_SellItems) to High(g_SellItems) do begin
      with dsurface do begin
        if (g_SellItems[I].sCharName <> '') and (g_SellItems[I].SellItem.s.Name <> '') then begin
          sName := '';
          sPrice := '';
          nPrice := g_SellItems[I].SellItem.s.Price;
          if nIndex = SellItemIndex then begin
            g_MouseSellItems := g_SellItems[I];
            hcolor := clRed;
          end else begin
            if nPrice < 0 then hcolor := clLime
            else hcolor := clWhite;
          end;

          if I = MoveSellItemIndex then hcolor := GetRGB(253) {clyellow};

          sName := g_SellItems[I].SellItem.s.Name;
          sPrice := IntToStr(abs(nPrice));
          if g_nSellItemType = 6 then begin
            sCharName := '未售出';
          end else
            if g_nSellItemType = 7 then begin
            sCharName := '已售出';
          end else begin
            sCharName := g_SellItems[I].sCharName;
          end;

          TextOut(nX1, nY, sName, hcolor);
          TextOut(nX2, nY, sPrice, hcolor);
          TextOut(nX3, nY, sCharName, hcolor);
          Inc(nY, 19);
          Inc(nIndex);
        end;
      end;
    end;
    if (g_MouseSellItems.sCharName <> '') and (g_MouseSellItems.SellItem.s.Name <> '') then begin
      d := g_WBagItemImages.Images[g_MouseSellItems.SellItem.s.looks];
      if d <> nil then
        dsurface.Draw(SurfaceX(DSellItem.Left), SurfaceY(DSellItem.Top), d.ClientRect, d, True);
      with dsurface do begin
        sName := '寄售日期：' + DateTimeToStr(g_MouseSellItems.dSellDateTime);
        TextOut(SurfaceX(Left) + 19, SurfaceY(Top) + 274, sName);
      end;
      with dsurface do begin
        g_MouseItem := g_MouseSellItems.SellItem;
        GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);

        nX := SurfaceX(DSellItem.Left) + 36;
        nY := SurfaceY(DSellItem.Top) + 2;

        TempList := HintList;
        if TempList.Count > 0 then begin
          with dsurface do begin
            TextOut(nX, nY, TempList.Strings[0], clyellow);
           { for I := 1 to TempList.Count - 1 do begin
              TextOut(nX, nY + TextHeight('A') * I, TempList.Strings[I], TColor(TempList.Objects[I]));
            end;   }
            if TempList.Count > 1 then begin
              TextOut(nX, nY + TextHeight('A') + 2, TempList.Strings[1], TColor(TempList.Objects[1]));
            end;
            if TempList.Count > 2 then begin
              TextOut(nX, nY + (TextHeight('A') + 2) * 2, TempList.Strings[TempList.Count - 1], TColor(TempList.Objects[TempList.Count - 1]));
            end;
          end;
        end;
        g_MouseItem.s.Name := '';
      end;
    end;
  end;
end;

procedure TFrmDlg.DPrevSellDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    if TDButton(Sender).Downed then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DBuySellItemDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    if TDButton(Sender).Downed then begin
      d := WLib.Images[FaceIndex + 1];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end else begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DCloseSellClick(Sender: TObject; X, Y: Integer);
begin
  CloseSellOffDlg;
end;

procedure TFrmDlg.DUserSellOffClick(Sender: TObject; X, Y: Integer);
var
  lx, ly, Idx: Integer;
begin
  lx := X;
  ly := Y;
  if (lx >= 12) and (lx <= 455) and (ly >= 69) then begin
    Idx := (ly - 69) div 19 + 1;
    if Idx in [Low(g_SellItems)..High(g_SellItems)] then begin
      SellItemIndex := Idx;
      //g_MouseSellItems := g_SellItems[SellItemIndex];
      //Move(g_SellItems[SellItemIndex], g_MouseSellItems, SizeOf(TClientSellItem));
      //g_MouseItem := g_SellItems[SellItemIndex].SellItem;
      PlaySound(s_glass_button_click);
    end else begin
      SellItemIndex := -1;
      g_MouseSellItems.sCharName := '';
      g_MouseSellItems.SellItem.s.Name := '';
    end;
  end;
end;

procedure TFrmDlg.DPrevSellClick(Sender: TObject; X, Y: Integer);
begin
  if g_nSellItemPage > 0 then begin
    Dec(g_nSellItemPage);
    frmMain.SendQuerySellItems(g_nSellItemType, g_nSellItemPage, g_sSellItem);
  end;
end;

procedure TFrmDlg.DRefreshSellClick(Sender: TObject; X, Y: Integer);
begin
  frmMain.SendQuerySellItems(g_nSellItemType, g_nSellItemPage, g_sSellItem);
end;

procedure TFrmDlg.DNextSellClick(Sender: TObject; X, Y: Integer);
begin
  if g_nSellItemPage + 1 < g_nSellItemPageCount then begin
    Inc(g_nSellItemPage);
    frmMain.SendQuerySellItems(g_nSellItemType, g_nSellItemPage, g_sSellItem);
  end;
end;

procedure TFrmDlg.DSearchSellOffClick(Sender: TObject; X, Y: Integer);
begin
  g_sSellItem := Trim(EdSearch.Text);
  g_nSellItemType := 8;
  if g_sSellItem <> '' then begin
    frmMain.SendQuerySellItems(g_nSellItemType, g_nSellItemPage, g_sSellItem);
  end else begin
    g_nSellItemType := 0;
    frmMain.SendQuerySellItems(g_nSellItemType, g_nSellItemPage, g_sSellItem);
  end;
end;

procedure TFrmDlg.DBuySellItemClick(Sender: TObject; X, Y: Integer);
var
  sHintString: string;
begin
  if (g_MouseSellItems.sCharName <> '') and (g_MouseSellItems.SellItem.s.Name <> '') then begin
    if g_nSellItemType = 6 then begin
      sHintString := '你是否要取回 ' + g_MouseSellItems.SellItem.s.Name + ' ?';
    end else
      if g_nSellItemType = 7 then begin
      sHintString := '你是否要取回 ' + g_MouseSellItems.SellItem.s.Name + ' 的寄售款？';
    end else begin
      sHintString := '你是否确认购买 ' + g_MouseSellItems.SellItem.s.Name + ' ?';
    end;
    if mrOk = FrmDlg.DMessageDlg(sHintString, [mbOk, mbCancel]) then begin
      if g_nSellItemType = 7 then begin
        frmMain.SendGetSellItemGold(g_MouseSellItems.SellItem.MakeIndex, g_MouseSellItems.SellItem.s.Name);
        Exit;
      end;
      frmMain.SendBuySellItem(g_MouseSellItems.SellItem.MakeIndex, g_MouseSellItems.SellItem.s.Name);
    end;
  end;
end;

procedure TFrmDlg.DPrevSellMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
  Butt: TDButton;
  sMsg: string;
begin
  Butt := TDButton(Sender);
  nHintX := Butt.Left;
  nHintY := DUserSellOff.Top + DUserSellOff.Height;
  if Sender = DPrevSell then sMsg := 'Previous';
  if Sender = DRefreshSell then sMsg := 'Refresh';
  if Sender = DNextSell then sMsg := 'Next';
  DScreen.ShowHint(nHintX, nHintY, sMsg, clWhite, False);
end;

procedure TFrmDlg.DUserSellOffMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DScreen.ClearHint;
end;

procedure TFrmDlg.DBoxItemGridGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TTexture);
  function GetNextIndex(nIndex: Integer): Integer;
  begin
    case nIndex of
      0: Result := 1;
      1: Result := 2;
      2: Result := 5;
      3: Result := 0;
      5: Result := 8;
      6: Result := 3;
      7: Result := 6;
      8: Result := 7;
    else Result := 0;
    end;
  end;
var
  d: TTexture;
  nX, nY: Integer;
  nRandomBoxItem: Integer;
  nnIndex, nIndex: Integer;
begin
  nIndex := ACol + ARow * DBoxItemGrid.ColCount;
  if nIndex in [Low(g_BoxItems)..(High(g_BoxItems))] then begin
    if g_BoxItems[nIndex].s.Name <> '' then begin
      with DBoxItemGrid do begin
        if nIndex = 4 then begin //中间格的处理
          if g_boGetBoxItem then begin //开启转动
            d := g_WMain3Images.Images[513];
            if d <> nil then
              dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                SurfaceY(Rect.Top + (RowHeight - d.Height - 20) div 2 + 1) + 10,
                d.ClientRect,
                d, True);
          end else begin
            d := g_WMain3Images.Images[514];
            if d <> nil then begin
              dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                d.ClientRect,
                d, True);
            end;
            if GetTickCount - g_dwBoxFlashTick > 500 then begin //发光闪烁
              g_dwBoxFlashTick := GetTickCount;
              if g_nBoxFlashIdx <> 600 then g_nBoxFlashIdx := 600
              else Inc(g_nBoxFlashIdx);
            end;
            d := g_WMain3Images.Images[g_nBoxFlashIdx];
            if d <> nil then
              dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                d.ClientRect,
                d, True);
          end;
        end else begin
          if g_boGetBoxItem then begin //开启转动
            if (nIndex = g_btSelBoxItemIndex) and (g_nBoxTrunCount = g_btSelBoxItemIndex) and g_boOpenItemBox then begin //转动结束
              g_boSelItemOK := True;
              if GetTickCount - g_dwBoxFlashTick > 500 then begin //发光闪烁
                g_dwBoxFlashTick := GetTickCount;
                nnIndex := (602 + (g_btBoxType - 1) * 2);
                if g_nBoxFlashIdx <> nnIndex then g_nBoxFlashIdx := nnIndex
                else Inc(g_nBoxFlashIdx);
              end;
              d := g_WMain3Images.Images[514];
              if d <> nil then begin
                dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                  SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                  d.ClientRect,
                  d, True);
              end;
              d := g_WMain3Images.Images[g_nBoxFlashIdx];
              if d <> nil then
                dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                  SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                  d.ClientRect,
                  d, True);
            end else begin
              if not g_boSelItemOK then begin
                if (g_nChgCount > 9) and (g_dwChgSpeed < 1200) then begin //转完三圈后开始减速
                  Inc(g_dwChgSpeed, 120); //调整旋转速度
                  g_nChgCount := 5;
                end;
                if (g_boOpenItemBox and (g_nBoxTrunCount <> g_btSelBoxItemIndex)) or (not g_boOpenItemBox) then begin
                  if GetTickCount - g_dwRandomBoxItemTick > g_dwChgSpeed then begin
                    g_dwRandomBoxItemTick := GetTickCount;
                    g_nBoxTrunCount := GetNextIndex(g_nBoxTrunCount);
                    Inc(g_nChgCount);
                    PlaySound(s_Flashbox);
                  end;
                end;
                nnIndex := 602 + (g_btBoxType - 1) * 2;
                if nIndex = g_nBoxTrunCount then begin
                  d := g_WMain3Images.Images[514];
                  if d <> nil then begin
                    dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                      SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                      d.ClientRect,
                      d, True);
                  end;
                  d := g_WMain3Images.Images[nnIndex];
                  if d <> nil then
                    dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                      SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                      d.ClientRect,
                      d, True);
                end else begin
                  d := g_WMain3Images.Images[514];
                  if d <> nil then
                    dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                      SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                      d.ClientRect,
                      d, True);
                end;
              end else begin
                d := g_WMain3Images.Images[514];
                if d <> nil then
                  dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                    SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                    d.ClientRect,
                    d, True);
              end;
            end;
          end else begin
            d := g_WMain3Images.Images[514];
            if d <> nil then
              dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                d.ClientRect,
                d, True);
          end;
        end;
        d := g_WBagItemImages.Images[g_BoxItems[nIndex].s.looks];
        if d <> nil then
          dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
            d.ClientRect,
            d, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DBoxItemsDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  sMsg: string;
begin
  with DBoxItems do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);

    if g_boGetBoxItemMouseMove then begin
      sMsg := 'BoxItemMessage';
      with dsurface do begin
        TextOut(SurfaceX(Left) + 16, SurfaceY(Top) + 160, sMsg);
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemBoxDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d, d1: TTexture;
  nIndex: Integer;
begin
  if g_btBoxType > 0 then begin
    with DItemBox do begin
      if g_boShowItemBox and (not g_boOpenItemBox) then begin
        d := g_WMain3Images.Images[520 + (g_btBoxType - 1) * 20];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      end else
        if g_boShowItemBox and g_boOpenItemBox then begin
        if g_nBoxIndex < 7 then begin
          if GetTickCount - g_dwOpenBoxTick > 300 then begin
            g_dwOpenBoxTick := GetTickCount;
            Inc(g_nBoxIndex);
          end;
          nIndex := 520 + (g_btBoxType - 1) * 20 + g_nBoxIndex;
          if g_nBoxIndex < 4 then begin
            d := g_WMain3Images.Images[nIndex];
            if d <> nil then
              dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
          end else begin
            d := g_WMain3Images.Images[nIndex];
            d1 := g_WMain3Images.Images[nIndex + 7];
            if d <> nil then
              dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
            if d1 <> nil then
              DrawBlend(dsurface, Left, Top, d1);
          end;
        end else begin
         //g_boBoxItemsVisible := True;
          DItemBox.Visible := False;
          DBoxItems.Visible := True;
          //DBoxItemGrid.Visible := DBoxItems.Visible;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DBoxItemGridDblClick(Sender: TObject);
var
  Idx: Integer;
begin
  Idx := DBoxItemGrid.Col + DBoxItemGrid.Row * DBoxItemGrid.ColCount;
  //Showmessage(IntToStr(idx));
  if (Idx in [Low(g_BoxItems)..(High(g_BoxItems))]) and (Idx = g_btSelBoxItemIndex) then begin
    //Showmessage('frmMain.SendClientMessage');
    frmMain.SendClientMessage(CM_GETSELBOXITEM, Idx, 0, 0, 0);
    DBoxItems.Visible := False;
  end;
end;

procedure TFrmDlg.DBoxItemGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  Index: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;

  nWhere: Integer;
  List: TStringList;
begin
  g_boGetBoxItemMouseMove := False;
  Index := ACol + ARow * DBoxItemGrid.ColCount;
  if Index in [0..8] then begin
    g_MouseItem := g_BoxItems[Index];
    if g_MouseItem.s.Name <> '' then begin
      nWhere := GetHumUseItemByBagItem(g_MouseItem.s.StdMode);
      if g_Config.boCompareItem and (nWhere >= 0) then begin

        List := TStringList.Create;
        try
          GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
          List.AddStrings(HintList);

          GetMouseItemInfo(g_MySelf, @g_UseItems[nWhere], iname, d1, d2, d3, useable);
          if HintList.Count > 0 then begin
            HintList.Strings[0] := GetUseItemName(nWhere) + ' ' + HintList.Strings[0];
          end;
          with DBoxItemGrid do
            DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
              SurfaceY(Top + (ARow + 1) * RowHeight),
              List, HintList, False);
          HintList.Clear;
        finally
          List.Free;
        end;
        g_MouseItem.s.Name := '';
      end else begin
        GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
        with DBoxItemGrid do
          DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
            SurfaceY(Top + (ARow + 1) * RowHeight),
            HintList, False);
      end;

    end;

    {GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
    if HintList.Count > 0 then begin
      with DBoxItemGrid do
        DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
          SurfaceY(Top + (ARow + 1) * RowHeight),
          HintList, False);
    end; }
    g_MouseItem.s.Name := '';
  end;
end;

procedure TFrmDlg.DOnHouserClick(Sender: TObject; X, Y: Integer);
begin
  frmMain.SendOnHorse();
end;

procedure TFrmDlg.DHelpClick(Sender: TObject; X, Y: Integer);
type
  TOpen = procedure;
var
  nBuffer: Integer;
  sBuffer: string;
  RegInfo: TRegInfo;
begin
  if (g_MySelf = nil) then Exit;
  if DStoreDlg.Visible then begin
    CloseStoreDlg;
  end else begin
    OpenStoreDlg;
    {Move(g_Buffer^, nBuffer, SizeOf(Integer));
    SetLength(sBuffer, nBuffer);
    Move(g_Buffer[SizeOf(Integer)], sBuffer[1], nBuffer);
    DecryptBuffer(sBuffer, @RegInfo, SizeOf(TRegInfo));
    if (not RegInfo.boShare) and (RegInfo.nProcedure[3] > 0) then TOpen(RegInfo.nProcedure[3]); }
  end;
  {
  DebugOutStr('RegInfo.boShare:'+BoolTosTR(RegInfo.boShare));
  DebugOutStr('RegInfo.nProcedure[0]:'+IntToStr(RegInfo.nProcedure[0]));
  DebugOutStr('RegInfo.nProcedure[1]:'+IntToStr(RegInfo.nProcedure[1]));
  DebugOutStr('RegInfo.nProcedure[2]:'+IntToStr(RegInfo.nProcedure[2]));
  DebugOutStr('RegInfo.nProcedure[3]:'+IntToStr(RegInfo.nProcedure[3]));
  DebugOutStr('RegInfo.nProcedure[4]:'+IntToStr(RegInfo.nProcedure[4]));
  }
end;

procedure TFrmDlg.DBoxItemsMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  g_boGetBoxItemMouseMove := False;
  DScreen.ClearHint;
end;

procedure TFrmDlg.DUserSellOffMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  lx, ly, Idx: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;
begin
  //lx := DUserSellOff.LocalX(X) - DUserSellOff.Left;
  //ly := DUserSellOff.LocalY(Y) - DUserSellOff.Top - DUserSellOff.SurfaceY(97);
  lx := X;
  ly := Y;
  if (lx >= 12) and (lx <= 455) and (ly >= 69) then begin
    Idx := (ly - 69) div 19 + 1;
    if Idx in [Low(g_SellItems)..High(g_SellItems)] then begin
      MoveSellItemIndex := Idx;
      g_MouseItem := g_SellItems[Idx].SellItem;
      with DUserSellOff do begin
        GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
        if HintList.Count > 0 then begin
          DScreen.ShowHint(SurfaceX(lx),
            SurfaceY(ly) + ImageCanvas.TextHeight('A') * 8,
            HintList, False);
        end;
      end;
      g_MouseItem.s.Name := '';
      Exit;
    end;
  end;
  DScreen.ClearHint;
  MoveSellItemIndex := -1;
end;

procedure TFrmDlg.DBookCloseDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    d := nil;
    if TDButton(Sender).Downed then begin
      if WLib <> nil then
        d := WLib.Images[FaceIndex + 1];
    end else begin
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
    end;
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
  end;
end;

procedure TFrmDlg.DBookPageDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with DBookPage do begin
    if g_nBookType > 0 then begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end else begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex + g_nBookPage];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DBookPrevPageClick(Sender: TObject; X, Y: Integer);
var
  d: TTexture;
begin
  if g_nBookPage > 0 then begin
    Dec(g_nBookPage);
  end else begin
    DBookPrevPage.Visible := False;
  end;
  if g_nBookPage = 0 then DBookPrevPage.Visible := False;
  d := g_WUIBImages.Images[3];
  if d <> nil then begin
    DBookNextPage.SetImgIndex(g_WUIBImages, 3);
    DBookNextPage.Left := 470 - d.Width;
    DBookNextPage.Top := 318;
  end;
end;

procedure TFrmDlg.DBookNextPageClick(Sender: TObject; X, Y: Integer);
var
  d: TTexture;
begin
  if g_nBookPage < 5 then begin
    Inc(g_nBookPage);
    DBookPrevPage.Visible := True;
  end;

  if g_nBookPage = 5 then begin
    DBook.Visible := False;
    g_nBookPage := 0;
    frmMain.SendMerchantDlgSelect(g_nCurMerchant, '@GotoVillage');
    Exit;
  end;

  if g_nBookPage = 4 then begin
    d := g_WBookImages.Images[5];
    if d <> nil then begin
      DBookNextPage.SetImgIndex(g_WUIBImages, 5);
      DBookNextPage.Left := 470 - d.Width;
      DBookNextPage.Top := 318;
    end;
  end else begin
    d := g_WUIBImages.Images[3];
    if d <> nil then begin
      DBookNextPage.SetImgIndex(g_WUIBImages, 3);
      DBookNextPage.Left := 470 - d.Width;
      DBookNextPage.Top := 318;
    end;
  end;
end;

procedure TFrmDlg.DBookNextPageDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    d := nil;
    if TDButton(Sender).Downed then begin
      if g_nBookPage = 4 then begin
        d := g_WBookImages.Images[5 + 1];
      end else begin
        d := g_WUIBImages.Images[3 + 1];
      end;
    end else begin
      if g_nBookPage = 4 then begin
        d := g_WBookImages.Images[5];
      end else begin
        d := g_WUIBImages.Images[3];
      end;
    end;
    if d <> nil then begin
    {  Height := d.Height;
      Width := d.Width;        }
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DBookDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with DBook do begin
    d := nil;
    if g_nBookType = 0 then begin
      d := g_WUIBImages.Images[0];
    end else begin
      d := g_WBookImages.Images[g_nBookType + 6];
    end;
    if d <> nil then begin
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DBookCloseClick(Sender: TObject; X, Y: Integer);
begin
  DBook.Visible := False;
end;

procedure TFrmDlg.DFindOKDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    d := nil;
    if Downed then begin
      if WLib <> nil then
        d := WLib.Images[FaceIndex + 1];
    end else begin
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
    end;
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
  end;
end;

procedure TFrmDlg.DFindChrCloseClick(Sender: TObject; X, Y: Integer);
begin
  DFindChr.Visible := False;
end;

procedure TFrmDlg.DFindChrClick(Sender: TObject; X, Y: Integer);
var
  lx, ly, Idx: Integer;
begin
  lx := DFindChr.LocalX(X) - DFindChr.Left;
  ly := DFindChr.LocalY(Y) - DFindChr.SurfaceY(140);
  if (lx >= 35) and (lx < DFindChr.Width - 40) and
    (ly > 0) and (ly < DFindChr.Height - 140) then begin
    Idx := ly div (LISTLINEHEIGHT + 9);
    with SelectChrScene do begin
      if Idx in [Low(DelCharArray)..High(DelCharArray)] then begin
        SelDelChar := Idx;
      end;
    end;
  end;
end;

procedure TFrmDlg.DFindChrDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  I, fy: Integer;
  d: TTexture;
begin
  with DFindChr do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    with SelectChrScene do begin
      fy := 0;
      DelChrCount := 0;

      with dsurface do begin
        for I := Low(DelCharArray) to High(DelCharArray) do begin
          if DelCharArray[I].sChrName <> '' then begin
            if I = SelDelChar then begin
              BoldTextOut(DFindChr.Left + 30, 140 + fy, '√' + DelCharArray[I].sChrName, clRed);
              BoldTextOut(DFindChr.Left + 125, 140 + fy, IntToStr(DelCharArray[I].wLevel), clRed);
              BoldTextOut(DFindChr.Left + 168, 140 + fy, GetJobName(DelCharArray[I].btJob), clRed);
              BoldTextOut(DFindChr.Left + 218, 140 + fy, GetSexName(DelCharArray[I].btSex), clRed);
            end else begin
              BoldTextOut(DFindChr.Left + 30, 140 + fy, DelCharArray[I].sChrName);
              BoldTextOut(DFindChr.Left + 125, 140 + fy, IntToStr(DelCharArray[I].wLevel));
              BoldTextOut(DFindChr.Left + 168, 140 + fy, GetJobName(DelCharArray[I].btJob));
              BoldTextOut(DFindChr.Left + 218, 140 + fy, GetSexName(DelCharArray[I].btSex));
            end;
            Inc(fy, TextHeight('A') + 9);
            Inc(DelChrCount);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DFindOKClick(Sender: TObject; X, Y: Integer);
begin
  SelectChrScene.SelChrRestoreChrClick;
end;

procedure TFrmDlg.DBookNextPageInRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
begin
  IsRealArea := True;
end;

procedure TFrmDlg.DOpenUpgradeClick(Sender: TObject; X, Y: Integer);
begin
  DUpgrade.Visible := not DUpgrade.Visible;
end;

procedure TFrmDlg.DCloseUpgradeClick(Sender: TObject; X, Y: Integer);
var
  I: Integer;
begin
  for I := 0 to 2 do begin
    if g_UpgradeItems[I].s.Name <> '' then begin
      AddItemBag(g_UpgradeItems[I]);
      g_UpgradeItems[I].s.Name := '';
    end;
  end;
  DUpgrade.Visible := False;
end;

procedure TFrmDlg.DUpgradeItem1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  Idx: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;
begin
  DScreen.ClearHint;
  if g_boItemMoving then begin
    if Sender = DUpgradeItem1 then
      g_MoveRect := DUpgradeItem1.ClientRect;
    if Sender = DUpgradeItem2 then
      g_MoveRect := DUpgradeItem2.ClientRect;
    if Sender = DUpgradeItem3 then
      g_MoveRect := DUpgradeItem3.ClientRect;
  end;
  if Sender = DUpgradeItem1 then Idx := 0;
  if Sender = DUpgradeItem2 then Idx := 1;
  if Sender = DUpgradeItem3 then Idx := 2;
  if Idx in [0..2] then begin
    g_MouseItem := g_UpgradeItems[Idx];
    if g_MouseItem.s.Name <> '' then begin
      GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
      with Sender as TDButton do
        DScreen.ShowHint(SurfaceX(Left - 30),
          SurfaceY(Top + 50),
          HintList, False);
    end;
  end;
end;

procedure TFrmDlg.DUpgradeItem1Click(Sender: TObject; X, Y: Integer);
var
  Idx: Integer;
  temp: TClientItem;
begin
  if (g_UpgradeItemsWait[0].s.Name <> '') or (g_UpgradeItemsWait[1].s.Name <> '') or (g_UpgradeItemsWait[2].s.Name <> '') then Exit;
  if Sender = DUpgradeItem1 then Idx := 0;
  if Sender = DUpgradeItem2 then Idx := 1;
  if Sender = DUpgradeItem3 then Idx := 2;
  if Idx in [0..2] then begin
    if not g_boItemMoving then begin
      ClearMoveRect();
      if g_UpgradeItems[Idx].s.Name <> '' then begin
        g_MovingItem.Owner := DUpgrade;
        g_boItemMoving := True;
        //g_MovingItem.Index := idx;
        g_MovingItem.Item := g_UpgradeItems[Idx];
        g_UpgradeItems[Idx].s.Name := '';
        ItemClickSound(g_MovingItem.Item.s);
      end;
    end else begin
      if (g_MovingItem.Index < 0) or (g_MovingItem.Owner = DDealDlg) or (g_MovingItem.Owner = DHeroItemBag) or (g_MovingItem.Owner = DStateWin) or (g_MovingItem.Owner = DHeroStateWin) then Exit;
      if (g_MovingItem.Owner = DItemBag) or (g_MovingItem.Owner = DUpgrade) then begin
        if (g_UpgradeItems[Idx].s.Name <> '') then begin
          temp := g_UpgradeItems[Idx];
          g_UpgradeItems[Idx] := g_MovingItem.Item;
        //g_MovingItem.Index := idx;
          g_MovingItem.Item := temp;
          g_MovingItem.Owner := DUpgrade;
        end else begin
          g_UpgradeItems[Idx] := g_MovingItem.Item;
          g_MovingItem.Item.s.Name := '';
          g_boItemMoving := False;
          g_MovingItem.Owner := nil;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DUpgradeItem1DirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  Idx: Integer;
  d: TTexture;
begin
  if Sender = DUpgradeItem1 then begin
    if g_UpgradeItems[0].s.Name <> '' then begin
      Idx := g_UpgradeItems[0].s.looks;
      if Idx >= 0 then begin
        d := g_WBagItemImages.Images[Idx];
        if d <> nil then
          dsurface.Draw(DUpgradeItem1.SurfaceX(DUpgradeItem1.Left + (DUpgradeItem1.Width - d.Width) div 2),
            DUpgradeItem1.SurfaceY(DUpgradeItem1.Top + (DUpgradeItem1.Height - d.Height) div 2),
            d.ClientRect, d, True);
      end;
    end;
  end;

  if Sender = DUpgradeItem2 then begin
    if g_UpgradeItems[1].s.Name <> '' then begin
      Idx := g_UpgradeItems[1].s.looks;
      if Idx >= 0 then begin
        d := g_WBagItemImages.Images[Idx];
        if d <> nil then
          dsurface.Draw(DUpgradeItem2.SurfaceX(DUpgradeItem2.Left + (DUpgradeItem2.Width - d.Width) div 2),
            DUpgradeItem2.SurfaceY(DUpgradeItem2.Top + (DUpgradeItem2.Height - d.Height) div 2),
            d.ClientRect, d, True);
      end;
    end;
  end;

  if Sender = DUpgradeItem3 then begin
    if g_UpgradeItems[2].s.Name <> '' then begin
      Idx := g_UpgradeItems[2].s.looks;
      if Idx >= 0 then begin
        d := g_WBagItemImages.Images[Idx];
        if d <> nil then
          dsurface.Draw(DUpgradeItem3.SurfaceX(DUpgradeItem3.Left + (DUpgradeItem3.Width - d.Width) div 2),
            DUpgradeItem3.SurfaceY(DUpgradeItem3.Top + (DUpgradeItem3.Height - d.Height) div 2),
            d.ClientRect, d, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DUpgradeMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  DScreen.ClearHint;
end;

procedure TFrmDlg.DItemBagMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  g_MouseItem.s.Name := '';
  g_MouseHeroItem.s.Name := '';
  HintList.Clear;
  DScreen.ClearHint;
end;

procedure TFrmDlg.DOpenUpgradeMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  nHintX, nHintY: Integer;
begin
  nHintX := DOpenUpgrade.SurfaceX(DOpenUpgrade.Left);
  nHintY := DOpenUpgrade.SurfaceY(DOpenUpgrade.Top);
  DScreen.ShowHint(nHintX, nHintY, '装备升级', clWhite, True);
end;

procedure TFrmDlg.DStartUpgradeClick(Sender: TObject; X, Y: Integer);
var
  I: Integer;
  UpgradeItemIndexs: TUpgradeItemIndexs;
begin
  if (g_UpgradeItemsWait[0].s.Name <> '') or (g_UpgradeItemsWait[1].s.Name <> '') or (g_UpgradeItemsWait[2].s.Name <> '') then begin
    if GetTickCount - g_dwUpgradeItemsWaitTick >= 1000 * 5 then begin
      g_UpgradeItemsWait[0].s.Name := '';
      g_UpgradeItemsWait[1].s.Name := '';
      g_UpgradeItemsWait[2].s.Name := '';
    end;
  end;
  if (g_UpgradeItemsWait[0].s.Name <> '') or (g_UpgradeItemsWait[1].s.Name <> '') or (g_UpgradeItemsWait[2].s.Name <> '') then Exit;
  if (g_UpgradeItems[0].s.Name = '') or (g_UpgradeItems[1].s.Name = '') or (g_UpgradeItems[2].s.Name = '') then Exit;
  g_dwUpgradeItemsWaitTick := GetTickCount;
  g_UpgradeItemsWait := g_UpgradeItems;

  g_UpgradeItems[0].s.Name := '';
  g_UpgradeItems[1].s.Name := '';
  g_UpgradeItems[2].s.Name := '';
  for I := 0 to 2 do
    UpgradeItemIndexs[I] := g_UpgradeItemsWait[I].MakeIndex;
  frmMain.SendUpgradeItem(UpgradeItemIndexs);
end;

procedure TFrmDlg.DStartUpgradeMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  nHintX, nHintY: Integer;
begin
  nHintX := DStartUpgrade.SurfaceX(DStartUpgrade.Left);
  nHintY := DStartUpgrade.SurfaceY(DStartUpgrade.Top);
  DScreen.ShowHint(nHintX, nHintY, '开始升级装备', clWhite, True);
end;

procedure TFrmDlg.DButtonDuelClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount > g_dwQueryMsgTick then begin
    g_dwQueryMsgTick := GetTickCount + 3000;
    frmMain.SendDuelTry;
  end;
end;

procedure TFrmDlg.DDRDuelGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TTexture);
var
  nIdx: Integer;
  d: TTexture;
begin
  nIdx := ACol + ARow * DDRDuelGrid.ColCount;
  if nIdx in [0..4] then begin
    if g_DuelRemoteItems[nIdx].s.Name <> '' then begin
      d := g_WBagItemImages.Images[g_DuelRemoteItems[nIdx].s.looks];
      if d <> nil then
        with DDRDuelGrid do begin
          dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
            d.ClientRect,
            d, True);
        end;
      with DDRDuelGrid do begin
        if (g_DuelRemoteItems[nIdx].s.AddValue[12] in [1, 3]) {or (GetAddPoint(g_DuelRemoteItems[nIdx].s.AddPoint))} then begin
          if GetTickCount - g_DrawDuelRemoteItems[nIdx].dwDrawTick >= 200 then begin
            g_DrawDuelRemoteItems[nIdx].dwDrawTick := GetTickCount;
            if g_DrawDuelRemoteItems[nIdx].nIndex <= 0 then g_DrawDuelRemoteItems[nIdx].nIndex := 260 - 1;
            Inc(g_DrawDuelRemoteItems[nIdx].nIndex);
            if g_DrawDuelRemoteItems[nIdx].nIndex > 265 then g_DrawDuelRemoteItems[nIdx].nIndex := 260;
          end;
          d := g_WMain2Images.Images[g_DrawDuelRemoteItems[nIdx].nIndex];
          if d <> nil then begin
            DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1), d);
          end;
        end;

        if g_DuelRemoteItems[nIdx].s.AddValue[12] >= 2 then begin
          if GetTickCount - g_DrawDuelRemoteItems_[nIdx].dwDrawTick >= 200 then begin
            g_DrawDuelRemoteItems_[nIdx].dwDrawTick := GetTickCount;
            if g_DrawDuelRemoteItems_[nIdx].nIndex <= 0 then g_DrawDuelRemoteItems_[nIdx].nIndex := 600 - 1;
            Inc(g_DrawDuelRemoteItems_[nIdx].nIndex);
            if g_DrawDuelRemoteItems_[nIdx].nIndex > 617 then g_DrawDuelRemoteItems_[nIdx].nIndex := 600;
          end;
          d := g_WMain3Images.Images[g_DrawDuelRemoteItems_[nIdx].nIndex];
          if d <> nil then begin
            DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1), d);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DDDuelGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TTexture);
var
  nIdx: Integer;
  d: TTexture;
begin
  nIdx := ACol + ARow * DDDuelGrid.ColCount;
  if nIdx in [0..4] then begin
    if g_DuelItems[nIdx].s.Name <> '' then begin
      d := g_WBagItemImages.Images[g_DuelItems[nIdx].s.looks];
      if d <> nil then
        with DDDuelGrid do begin
          dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
            d.ClientRect,
            d, True);
        end;

      with DDDuelGrid do begin
        if (g_DuelItems[nIdx].s.AddValue[12] in [1, 3]) { or (GetAddPoint(g_DuelItems[nIdx].s.AddPoint))} then begin
          if GetTickCount - g_DrawDuelItems[nIdx].dwDrawTick >= 200 then begin
            g_DrawDuelItems[nIdx].dwDrawTick := GetTickCount;
            if g_DrawDuelItems[nIdx].nIndex <= 0 then g_DrawDuelItems[nIdx].nIndex := 260 - 1;
            Inc(g_DrawDuelItems[nIdx].nIndex);
            if g_DrawDuelItems[nIdx].nIndex > 265 then g_DrawDuelItems[nIdx].nIndex := 260;
          end;
          d := g_WMain2Images.Images[g_DrawDuelItems[nIdx].nIndex];
          if d <> nil then begin
            DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1), d);
          end;
        end;

        if g_DuelItems[nIdx].s.AddValue[12] >= 2 then begin
          if GetTickCount - g_DrawDuelItems_[nIdx].dwDrawTick >= 200 then begin
            g_DrawDuelItems_[nIdx].dwDrawTick := GetTickCount;
            if g_DrawDuelItems_[nIdx].nIndex <= 0 then g_DrawDuelItems_[nIdx].nIndex := 600 - 1;
            Inc(g_DrawDuelItems_[nIdx].nIndex);
            if g_DrawDuelItems_[nIdx].nIndex > 617 then g_DrawDuelItems_[nIdx].nIndex := 600;
          end;
          d := g_WMain3Images.Images[g_DrawDuelItems_[nIdx].nIndex];
          if d <> nil then begin
            DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1), d);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DWDuelDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with DWDuel do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    with dsurface do begin
      TextOut(SurfaceX(Left + 83), SurfaceY(Top + 101), GetGoldStr(g_nDuelRemoteGold));
      TextOut(SurfaceX(Left + 27 + (90 - TextWidth(g_sDuelWho)) div 2), SurfaceY(Top + 32) + 3, g_sDuelWho);

      TextOut(SurfaceX(Left + 83), SurfaceY(Top + 202), GetGoldStr(g_nDuelGold));
      TextOut(SurfaceX(Left + 27 + (90 - TextWidth(g_sSelChrName)) div 2), SurfaceY(Top + 134) + 3, g_sSelChrName);
    end;
  end;
end;

procedure TFrmDlg.DDRDuelGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  nIdx: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;

  nWhere: Integer;
  List: TStringList;
begin
  DScreen.ClearHint;
  nIdx := ACol + ARow * DDRDuelGrid.ColCount;
  if nIdx in [0..4] then begin
    g_MouseItem := g_DuelRemoteItems[nIdx];
    if g_MouseItem.s.Name <> '' then begin

      nWhere := GetHumUseItemByBagItem(g_MouseItem.s.StdMode);
      if g_Config.boCompareItem and (nWhere >= 0) then begin

        List := TStringList.Create;
        try
          GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
          List.AddStrings(HintList);

          GetMouseItemInfo(g_MySelf, @g_UseItems[nWhere], iname, d1, d2, d3, useable);
          if HintList.Count > 0 then begin
            HintList.Strings[0] := GetUseItemName(nWhere) + ' ' + HintList.Strings[0];
          end;
          with DDRDuelGrid do
            DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
              SurfaceY(Top + (ARow + 1) * RowHeight),
              List, HintList, False);
          HintList.Clear;
        finally
          List.Free;
        end;
        g_MouseItem.s.Name := '';
      end else begin
        GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
        with DDRDuelGrid do
          DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
            SurfaceY(Top + (ARow + 1) * RowHeight),
            HintList, False);
      end;
      {GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
      with DDRDuelGrid do
        DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
          SurfaceY(Top + (ARow + 1) * RowHeight),
          HintList, False);}
    end;
  end;
end;

procedure TFrmDlg.DDDuelGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  nIdx: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;

  nWhere: Integer;
  List: TStringList;
begin
  DScreen.ClearHint;
  nIdx := ACol + ARow * DDDuelGrid.ColCount;
  if nIdx in [0..4] then begin
    g_MoveRect := DDDuelGrid.ClientRect;
    g_MouseItem := g_DuelItems[nIdx];
    if g_MouseItem.s.Name <> '' then begin
      nWhere := GetHumUseItemByBagItem(g_MouseItem.s.StdMode);
      if g_Config.boCompareItem and (nWhere >= 0) then begin

        List := TStringList.Create;
        try
          GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
          List.AddStrings(HintList);

          GetMouseItemInfo(g_MySelf, @g_UseItems[nWhere], iname, d1, d2, d3, useable);
          if HintList.Count > 0 then begin
            HintList.Strings[0] := GetUseItemName(nWhere) + ' ' + HintList.Strings[0];
          end;
          with DDDuelGrid do
            DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
              SurfaceY(Top + (ARow + 1) * RowHeight),
              List, HintList, False);
          HintList.Clear;
        finally
          List.Free;
        end;
        g_MouseItem.s.Name := '';
      end else begin
        GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
        with DDDuelGrid do
          DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
            SurfaceY(Top + (ARow + 1) * RowHeight),
            HintList, False);
      end;

      {GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
      with DDDuelGrid do
        DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
          SurfaceY(Top + (ARow + 1) * RowHeight),
          HintList, False);
          }
    end else DScreen.ClearHint;
  end else DScreen.ClearHint;
end;

procedure TFrmDlg.DDDuelGridGridSelect(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
  temp: TClientItem;
  mi, nIdx: Integer;
begin
  //if mbLeft = Button then begin
  if not g_boDuelEnd and (GetTickCount > g_dwDuelActionTick) then begin
    if not g_boItemMoving then begin
      nIdx := ACol + ARow * DDDuelGrid.ColCount;
      if nIdx in [0..4] then begin
        ClearMoveRect();
        if g_DuelItems[nIdx].s.Name <> '' then begin
          g_boItemMoving := True;
          g_MovingItem.Owner := DWDuel;
          g_MovingItem.Index := -nIdx - 30;
          g_MovingItem.Item := g_DuelItems[nIdx];
          g_DuelItems[nIdx].s.Name := '';
          ItemClickSound(g_MovingItem.Item.s);
        end;
      end;
    end else begin
      if (g_MovingItem.Owner = DHeroItemBag) or (g_MovingItem.Owner = DDealDlg) or (g_MovingItem.Owner = DHeroStateWin) or (g_MovingItem.Owner = DStateWin) then Exit;
      mi := g_MovingItem.Index;
      if (mi >= 0) or (mi <= -30) and (mi > -40) then begin
        ItemClickSound(g_MovingItem.Item.s);
        g_boItemMoving := False;
        if mi >= 0 then begin
          g_DuelDlgItem := g_MovingItem.Item;
          frmMain.SendAddDuelItem(g_DuelDlgItem);
          g_dwDuelActionTick := GetTickCount + 4000;
        end else
          AddDuelItem(g_MovingItem.Item);
        g_MovingItem.Item.s.Name := '';
        g_MovingItem.Owner := nil;
      end;
      if mi = -98 then DDDuelGoldClick(Self, 0, 0);
    end;
    ArrangeItemBag;
  end;
  //end;
end;

procedure TFrmDlg.DDDuelGoldClick(Sender: TObject; X, Y: Integer);
var
  DGold: Integer;
  valstr: string;
begin
  if g_MySelf = nil then Exit;
  if not g_boDuelEnd and (GetTickCount > g_dwDuelActionTick) then begin
    if not g_boItemMoving then begin
      DialogSize := 1;
      DMessageDlg('Please enter amount of' + g_sGameGoldName, [mbOk, mbAbort]);
      GetValidStrVal(DlgEditText, valstr, [' ']);
      DGold := Str_ToInt(valstr, 0);
      if (DGold <= (g_nDuelGold + g_MySelf.m_nGameGold)) and (DGold > 0) then begin
        frmMain.SendChangeDuelGold(DGold);
              //DScreen.AddChatBoardString('frmMain.SendChangeDuelGold(DGold): ' + IntToStr(DGold), clWhite, clPurple);
        g_dwDuelActionTick := GetTickCount + 4000;
      end else begin
        DMessageDlg('Not enough Gold ' + IntToStr(DGold) + '!', [mbOk]);
        DGold := 0;
      end;
    end;
  end;
end;
(*var
  DGold: Integer;
  valstr: string;
begin
  if g_MySelf = nil then Exit;
  if not g_boDuelEnd and (GetTickCount > g_dwDuelActionTick) then begin
    if not g_boItemMoving then begin
      if g_nDuelGold > 0 then begin
        PlaySound(s_money);
        g_boItemMoving := True;
        g_MovingItem.Index := -97;
        g_MovingItem.Item.s.Name := g_sGoldName {'金币'};
      end;
    end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then begin
        if (g_MovingItem.Index = -98) then begin
          if g_MovingItem.Item.s.Name = g_sGoldName {'金币'} then begin

            DialogSize := 1;
            g_boItemMoving := False;
            g_MovingItem.Item.s.Name := '';
            DMessageDlg('请输入要' + g_sGameGoldName + '数量：', [mbOk, mbAbort]);
            GetValidStrVal(DlgEditText, valstr, [' ']);
            DGold := Str_ToInt(valstr, 0);
            if (DGold <= (g_nDuelGold + g_MySelf.m_nGameGold)) and (DGold > 0) then begin
              frmMain.SendChangeDuelGold(DGold);
              //DScreen.AddChatBoardString('frmMain.SendChangeDuelGold(DGold): ' + IntToStr(DGold), clWhite, clPurple);
              g_dwDuelActionTick := GetTickCount + 4000;
            end else DGold := 0;
          end;
        end;
        g_boItemMoving := False;
        g_MovingItem.Item.s.Name := '';
      end;
    end;
  end;
end;*)

procedure TFrmDlg.DDuelCloseClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount > g_dwDuelActionTick then begin
    CloseDuelDlg;
    frmMain.SendCancelDuel;
  end;
end;

procedure TFrmDlg.OpenDuelDlg;
var
  d: TTexture;
begin
  //DWDuel.Left := SCREENWIDTH - 236 - 100;
  DItemBag.Left := 0;
  DItemBag.Top := 80;
  DItemBag.Visible := True;

  DWDuel.Visible := True;

  SafeFillChar(g_DuelItems, SizeOf(TClientItem) * 5, #0);
  SafeFillChar(g_DuelRemoteItems, SizeOf(TClientItem) * 5, #0);
  g_nDuelGold := 0;
  g_nDuelRemoteGold := 0;
  g_boDuelEnd := False;
  ArrangeItemBag;
end;

procedure TFrmDlg.CloseDuelDlg;
begin
  DWDuel.Visible := False;
  ArrangeItemBag;
end;

procedure TFrmDlg.DWDuelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  DScreen.ClearHint;
end;

procedure TFrmDlg.DItemBoxDblClick(Sender: TObject);
begin
  if g_boShowItemBox and (not g_boOpenItemBox) and (g_btBoxType > 0) and (not g_boGetBoxItemOK) then begin
    frmMain.SendClientMessage(CM_GETBACKITEMBOX, 0, 0, 0, 0);
  end;
end;

procedure TFrmDlg.DItemLockClick(Sender: TObject; X, Y: Integer);
begin
  if g_boShowItemBox and (not g_boOpenItemBox) and (g_btBoxType > 0) and (not g_boGetBoxItemOK) then begin
    if (g_nBoxIndex <= 0) and (FrmDlg.DItemBox.Visible) and g_boItemMoving and (g_MovingItem.Owner = DItemBag) and (g_MovingItem.Item.s.Name <> '') and
      (g_MovingItem.Item.s.StdMode = 40) and (g_MovingItem.Item.s.Shape in [13..16]) then begin
      if (g_OpenBoxingItem.s.Name <> '') and (GetTickCount - g_dwOpenBoxTime > 5 * 1000) then begin
        g_OpenBoxingItem.s.Name := '';
      end;
      if g_OpenBoxingItem.s.Name = '' then begin
        g_boItemMoving := False;
        g_OpenBoxingItem := g_MovingItem.Item;
        g_MovingItem.Item.s.Name := '';
        g_MovingItem.Owner := nil;
        g_dwOpenBoxTime := GetTickCount;
        frmMain.SendOpenBox(g_OpenBoxingItem.s.Name, g_OpenBoxingItem.MakeIndex);
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if g_boShowItemBox and (not g_boOpenItemBox) and (g_btBoxType > 0) and (not g_boGetBoxItemOK) then begin
    DScreen.ShowHint(X, Y, '双击收回宝箱', clWhite, True);
  end else DScreen.ClearHint;
end;

procedure TFrmDlg.DGetBoxItemFlashDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  if g_boGetBoxItemMouseMove then begin
    if GetTickCount - g_dwShowGetBoxItemButtonTick > 200 then begin
      g_dwShowGetBoxItemButtonTick := GetTickCount;
      Inc(g_nBoxButtonIndex);
    end;
    if (g_nBoxButtonIndex < 515) or (g_nBoxButtonIndex > 518) then g_nBoxButtonIndex := 515;

    d := g_WMain3Images.Images[g_nBoxButtonIndex];
    if d <> nil then
      DrawBlend(dsurface, DBoxItems.SurfaceX(DBoxItems.Left) + 68, DBoxItems.SurfaceY(Top) + 160 + 120, d);
  end;
end;

procedure TFrmDlg.DHeroItemBagMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  HintList.Clear;
  DScreen.ClearHint;
  g_MouseHeroItem.s.Name := '';
  g_MouseItem.s.Name := '';
end;

procedure TFrmDlg.DShopItemGridGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TTexture);
var
  nIdx: Integer;
  d: TTexture;
  hcolor: TColor;
  old: Integer;
  sMemo1: string;
begin
  nIdx := ACol + ARow * DShopItemGrid.ColCount;
  if nIdx in [0..10 - 1] then begin
    if g_ShopItems[ShopTabPage, nIdx].StdItem.Name <> '' then begin
      d := g_WBagItemImages.Images[g_ShopItems[ShopTabPage, nIdx].StdItem.looks];
      if d <> nil then
        with DShopItemGrid do begin
          dsurface.Draw(SurfaceX(Rect.Left + 10 + (32 - d.Width) div 2 - 1),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
            d.ClientRect,
            d, True);
        end;

      if (m_btSelectShop = 0) and (gdSelected in State) and (g_MouseShopItems.ShopItem.StdItem.Name <> '') then hcolor := clRed else hcolor := clWhite;

      with dsurface do begin
        TextOut(DShopItemGrid.SurfaceX(Rect.Left + 8 + 36 + 8), DShopItemGrid.SurfaceY(Rect.Top + 10), g_ShopItems[ShopTabPage, nIdx].StdItem.Name, clyellow);
        sMemo1 := g_ShopItems[ShopTabPage, nIdx].sMemo1;
        if sMemo1 <> '' then begin
          TextOut(DShopItemGrid.SurfaceX(Rect.Left + 8 + 36 + 8), DShopItemGrid.SurfaceY(Rect.Top + 10 + TextHeight('A')), sMemo1, hcolor);
        end;
        TextOut(DShopItemGrid.SurfaceX(Rect.Left + 8 + 36 + 8), DShopItemGrid.SurfaceY(Rect.Top + 10 + TextHeight('A') * 2), IntToStr(g_ShopItems[ShopTabPage, nIdx].StdItem.Price) + ' ' + g_sGameGoldName, hcolor);
      end;

    end;
  end;
end;

procedure TFrmDlg.DSuperShopItemGridGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TTexture);
var
  nIdx: Integer;
  d: TTexture;
  hcolor: TColor;
  old: Integer;
begin
  nIdx := ACol + ARow * DSuperShopItemGrid.ColCount;
  if nIdx in [0..5 - 1] then begin
    if g_SuperShopItems[nIdx].StdItem.Name <> '' then begin
      d := g_WBagItemImages.Images[g_SuperShopItems[nIdx].StdItem.looks];
      if d <> nil then
        with DSuperShopItemGrid do begin
          dsurface.Draw(SurfaceX(Rect.Left + 39 + (42 - d.Width) div 2 - 1),
            SurfaceY(Rect.Top + (32 - d.Height) div 2 + 1),
            d.ClientRect,
            d, True);
        end;
      if (m_btSelectShop = 1) and (gdSelected in State) and (g_MouseShopItems.ShopItem.StdItem.Name <> '') then hcolor := clRed else hcolor := clWhite;

      with dsurface do begin
        TextOut(DSuperShopItemGrid.SurfaceX(Rect.Left + 1), DSuperShopItemGrid.SurfaceY(Rect.Top + 36), g_SuperShopItems[nIdx].StdItem.Name, clLime);
        TextOut(DSuperShopItemGrid.SurfaceX(Rect.Left + 1), DSuperShopItemGrid.SurfaceY(Rect.Top + 36 + TextHeight('A')), IntToStr(g_SuperShopItems[nIdx].StdItem.Price) + ' ' + g_sGameGoldName, hcolor);
      end;
    end;
  end;
end;

procedure TFrmDlg.DShopItemGridGridSelect(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  Idx: Integer;
begin
  Idx := ACol + ARow * DShopItemGrid.ColCount;
  if (ShopTabPage >= 0) and (ShopTabPage <= 4) and (Idx in [0..9]) then begin
    m_btSelectShop := 0;
    g_MouseShopItems.nPicturePosition := -1;
    g_MouseShopItems.ShopItem := g_ShopItems[ShopTabPage, Idx];
    PlaySound(s_norm_button_click);
  end;
end;

procedure TFrmDlg.DSuperShopItemGridGridSelect(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  Idx: Integer;
begin
  Idx := ACol + ARow * DSuperShopItemGrid.ColCount;
  if (Idx in [0..4]) then begin
    m_btSelectShop := 1;
    g_MouseShopItems.nPicturePosition := -1;
    g_MouseShopItems.ShopItem := g_SuperShopItems[Idx];
    PlaySound(s_norm_button_click);
  end;
end;

procedure TFrmDlg.DShopItemGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  Idx: Integer;
begin
  {idx := ACol + ARow * DShopItemGrid.ColCount;
  if (ShopTabPage >= 0) and (ShopTabPage <= 4) and (idx in [0..9]) then begin
    with DShopItemGrid do begin
      g_MoveRect.Left := SurfaceX(Left + ACol * ColWidth);
      g_MoveRect.Top := SurfaceY(Top + ARow * RowHeight);
      g_MoveRect.Right := g_MoveRect.Left + ColWidth;
      g_MoveRect.Bottom := g_MoveRect.Top + RowHeight;
    end;
  end;}
end;

procedure TFrmDlg.DHumManSortMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  DScreen.ClearHint;
end;

procedure TFrmDlg.DShopMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  DScreen.ClearHint;
end;

procedure TFrmDlg.DMiniMapDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d, dd: TTexture;
  v: Boolean;
  mx, my, nX, nY, I: Integer;
  rc: TRect;
  Actor: TActor;
  X, Y: Integer;
  btColor: Byte;
  Color: TColor;
  sText: string;

  MapDescInfo: pTMapDescInfo;
  DescList: TList;

  nMinX, nMinY, nMaxX, nMaxY: Integer;

  OldColor: TColor;
  old: Integer;
  nStatus: Integer;
  OldFontStyle: TFontStyles;
  CartInfo: pTCartInfo;
begin
  if g_MySelf = nil then Exit;
  if g_nMiniMapIndex < 0 then Exit; //g_nViewMinMapLv=1 局部地图 2全景地图 3全景大地图

  d := nil;
  dd := nil;
  case g_nMiniMapIndex of
    300: d := g_WMiniMapImages.Images[0];
    105, 301: d := g_WMiniMapImages.Images[1];
    302: d := g_WMiniMapImages.Images[2];
    303: d := g_WMiniMapImages.Images[3];
    305: d := g_WMiniMapImages.Images[4];
    306..318: d := g_WMiniMapImages.Images[g_nMiniMapIndex - 301];
    320..323: d := g_WMiniMapImages.Images[g_nMiniMapIndex - 302];
  end;

  if d = nil then
    d := g_WMMapImages.Images[g_nMiniMapIndex];

  if d = nil then Exit;

  if (not LegendMap.StartFind) and (Length(LegendMap.Path) > 0) then begin
    dd := TTexture.Create;
    dd.SetSize(d.Width, d.Height);
    dd.Draw(0, 0, d, False);
    d := dd;
    for X := 0 to Length(LegendMap.Path) - 1 do begin
      ActorXYToMapXY(LegendMap.Path[X].X, LegendMap.Path[X].Y, mx, my);
      dd.Pixels[mx, my] := clRed;
      dd.Pixels[mx + 1, my] := clRed;
      dd.Pixels[mx - 1, my] := clRed;
      dd.Pixels[mx, my + 1] := clRed;
      dd.Pixels[mx, my - 1] := clRed;
    end;
  end;

  g_nMapWidth := d.Width;
  g_nMapHeight := d.Height;
  if g_nViewMinMapLv <= 2 then begin
    DMiniMap.Floating := False;
    if g_nViewMinMapLv = 1 then begin

      ActorXYToMapXY(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my);

      rc.Left := _MAX(0, mx - 60);
      rc.Top := _MAX(0, my - 60);
      rc.Right := _MIN(d.ClientRect.Right, rc.Left + 120);
      rc.Bottom := _MIN(d.ClientRect.Bottom, rc.Top + 120);

      if g_ConfigClient.btMainInterface in [0, 2] then begin
        DMiniMap.Top := 0;
      end else begin
        DMiniMap.Top := DMapTitle.Height;
      end;

      DMiniMap.Width := rc.Right - rc.Left;
      DMiniMap.Height := rc.Bottom - rc.Top;
      DMiniMap.Left := SCREENWIDTH - DMiniMap.Width;

      if g_boShowMiniMapXY then begin
        mx := (g_nMinMapX - DMiniMap.Left + rc.Left);
        if g_ConfigClient.btMainInterface in [0, 2] then begin
          my := g_nMinMapY + rc.Top;
        end else begin
          my := g_nMinMapY - DMapTitle.Height + rc.Top;
        end;
        MapXYToActorXY(mx, my, mx, my);

        sText := IntToStr(mx) + ':' + IntToStr(my);
        g_nMinMapMoveX := mx;
        g_nMinMapMoveY := my;
      end;
      dsurface.Draw(DMiniMap.SurfaceX(DMiniMap.Left), DMiniMap.SurfaceY(DMiniMap.Top), rc, d, False);
    end else begin //全景地图
      rc.Left := SCREENWIDTH - 200;
      rc.Top := 0;
      rc.Right := rc.Left + 200;
      rc.Bottom := 200;

      if g_ConfigClient.btMainInterface in [0, 2] then begin
        DMiniMap.Top := 0;
      end else begin
        DMiniMap.Top := DMapTitle.Height;
        rc.Top := DMapTitle.Height;
        rc.Bottom := rc.Top + rc.Bottom;
      end;

      DMiniMap.Width := 200;
      DMiniMap.Height := 200;
      DMiniMap.Left := SCREENWIDTH - DMiniMap.Width;

      if g_boShowMiniMapXY then begin
        ScreenToMap(d.Width, DMiniMap.Width, g_nMinMapX - DMiniMap.Left, mx);
        ScreenToMap(d.Height, DMiniMap.Height, g_nMinMapY - DMiniMap.Top, my);

        MapXYToActorXY(mx, my, mx, my);
        sText := IntToStr(mx) + ':' + IntToStr(my);
        g_nMinMapMoveX := mx;
        g_nMinMapMoveY := my;
      end;

      dsurface.StretchDraw(rc, d.ClientRect, d, False);
    end;

    if g_nViewMinMapLv = 1 then begin
      ActorXYToMapXY(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my);
      mx := mx - rc.Left;
      my := my - rc.Top;
    end else begin
      ActorXYToMapXY(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my);
      MapToScreen(d.Width, DMiniMap.Width, mx, mx);
      MapToScreen(d.Height, DMiniMap.Height, my, my);
    end;

    dsurface.FrameRect(Bounds(DMiniMap.Left + mx - 3, DMiniMap.Top + my - 3, 3, 3), clLime);
    dsurface.FrameRect(Bounds(DMiniMap.Left + mx - 2, DMiniMap.Top + my - 2, 2, 2), clLime);

    for nX := g_MySelf.m_nCurrX - 12 to g_MySelf.m_nCurrX + 12 do begin
      for nY := g_MySelf.m_nCurrY - 12 to g_MySelf.m_nCurrY + 12 do begin
        Actor := PlayScene.FindActorXY(nX, nY);
        if (Actor <> nil) and (Actor <> g_MySelf) and (not Actor.m_boDeath) then begin
          if g_nViewMinMapLv = 1 then begin
            ActorXYToMapXY(Actor.m_nCurrX, Actor.m_nCurrY, mx, my);
            mx := mx - rc.Left;
            my := my - rc.Top;
          end else begin
            ActorXYToMapXY(Actor.m_nCurrX, Actor.m_nCurrY, mx, my);
            MapToScreen(d.Width, DMiniMap.Width, mx, mx);
            MapToScreen(d.Height, DMiniMap.Height, my, my);
          end;

          case Actor.m_btRace of
            0, 50: btColor := 250; //clLime;
            // btColor := 255;
          else btColor := 249; //clRed;
          end;

          {
          case Actor.m_btRace of
            50, 45, 12: btColor := 250; //clLime;
            0: btColor := 255;
          else btColor := 249; //clRed;
          end;
          }

          if (g_MyHero <> nil) and (g_MyHero = Actor) then
            btColor := 251;

          for X := -1 to 1 do
            for Y := -1 to 1 do
              dsurface.Pixels[DMiniMap.Left + mx + X, DMiniMap.Top + my + Y] := GetRGB(btColor);
        end;
      end;
    end;

    if g_boShowMiniMapXY and (sText <> '') then begin
      with dsurface do begin
        BoldTextOut(DMiniMap.Left + (DMiniMap.Width - TextWidth(sText)) - 1, DMiniMap.Top + DMiniMap.Height - TextWidth('A') * 2, sText);
      end;
    end;
  end else begin
    DMiniMap.Floating := True;
    DMiniMap.Top := 40;
    DMiniMap.Left := 60;
    DMiniMap.Width := SCREENWIDTH - 120;
    DMiniMap.Height := SCREENHEIGHT - 220;

    with DMiniMap do
      dsurface.StretchDraw(Bounds(SurfaceX(Left), SurfaceY(Top), Width, Height), d.ClientRect, d, False);

    ActorXYToMapXY(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my);


    MapToScreen(g_nMapWidth, DMiniMap.Width, mx, mx);
    MapToScreen(g_nMapHeight, DMiniMap.Height, my, my);
    mx := DMiniMap.Left + mx;
    my := DMiniMap.Top + my;

    for X := -3 to 3 do
      for Y := -3 to 3 do
        dsurface.Pixels[mx + X, my + Y] := clLime;

    sText := IntToStr(g_MySelf.m_nCurrX) + ':' + IntToStr(g_MySelf.m_nCurrY);
    dsurface.BoldTextOut(mx + 10, my - 3, sText);

   { if (not LegendMap.StartFind) then begin
      for X := 0 to Length(LegendMap.Path) - 1 do begin

        ActorXYToMapXY(LegendMap.Path[X].X, LegendMap.Path[X].Y, mx, my);
        MapToScreen(g_nMapWidth, DMiniMap.Width, mx, mx);
        MapToScreen(g_nMapHeight, DMiniMap.Height, my, my);
        mx := DMiniMap.Left + mx;
        my := DMiniMap.Top + my;

        dsurface.Pixels[mx, my] := clRed;
      end;
    end;   }

    for X := -3 to 3 do
      for Y := -3 to 3 do
        dsurface.Pixels[g_nScreenMoveX + X, g_nScreenMoveY + Y] := clRed;

    sText := IntToStr(g_nMapMoveX) + ':' + IntToStr(g_nMapMoveY);
    dsurface.BoldTextOut(g_nScreenMoveX + 15, g_nScreenMoveY - 3, sText);
  end;

  if g_MapDesc.Get(g_sMapTitle, g_nViewMinMapLv >= 2, DescList) and (DescList.Count > 0) then begin
    if g_nViewMinMapLv = 1 then begin
      MapXYToActorXY(rc.Left, rc.Top, nMinX, nMinY);
      MapXYToActorXY(rc.Right, rc.Bottom, nMaxX, nMaxY);
      for I := 0 to DescList.Count - 1 do begin
        MapDescInfo := DescList[I];
        if (MapDescInfo.nX >= nMinX) and (MapDescInfo.nX <= nMaxX) and (MapDescInfo.nY >= nMinY) and (MapDescInfo.nY <= nMaxY) then begin
          ActorXYToMapXY(MapDescInfo.nX, MapDescInfo.nY, mx, my);
          mx := mx - rc.Left;
          my := my - rc.Top;
          sText := MapDescInfo.sDescName;
          dsurface.BoldTextOut(DMiniMap.Left + mx - dsurface.TextWidth(sText) div 2, DMiniMap.Top + my, sText, MapDescInfo.FColor);
        end;
      end;
    end else begin
      for I := 0 to DescList.Count - 1 do begin
        MapDescInfo := DescList[I];
        ActorXYToMapXY(MapDescInfo.nX, MapDescInfo.nY, mx, my);
        MapToScreen(d.Width, DMiniMap.Width, mx, mx);
        MapToScreen(d.Height, DMiniMap.Height, my, my);
        sText := MapDescInfo.sDescName;
        dsurface.BoldTextOut(DMiniMap.Left + mx - dsurface.TextWidth(sText) div 2, DMiniMap.Top + my, sText, MapDescInfo.FColor);
      end;
    end;
  end;

//==============================================================================
  if g_nViewMinMapLv > 1 then begin //显示镖车信息
    old := MainForm.Canvas.Font.Size;
    OldColor := MainForm.Canvas.Font.Color;
    OldFontStyle := MainForm.Canvas.Font.Style;

    MainForm.Canvas.Font.Size := 12;
    MainForm.Canvas.Font.Style := [fsBold];
    MainForm.Canvas.Font.Color := clWhite;
    g_CartInfoList.Lock;
    try
      for I := 0 to g_CartInfoList.Count - 1 do begin
        CartInfo := g_CartInfoList.Items[I];
        sText := CartInfo.sCharName;
        Actor := PlayScene.FindActor(CartInfo.nRecogId);
        if Actor = nil then begin
          nX := CartInfo.nX;
          nY := CartInfo.nY;
        end else begin
          nX := Actor.m_nCurrX;
          nY := Actor.m_nCurrY;
        end;
        if g_nViewMinMapLv = 1 then begin
          ActorXYToMapXY(nX, nY, mx, my);
          mx := mx - rc.Left;
          my := my - rc.Top;
        end else begin
          ActorXYToMapXY(nX, nY, mx, my);
          MapToScreen(d.Width, DMiniMap.Width, mx, mx);
          MapToScreen(d.Height, DMiniMap.Height, my, my);
        end;

        if { (Actor = nil) or }(g_nViewMinMapLv > 1) then begin
          if (g_nViewMinMapLv = 3) then begin
            for X := 2 to 10 do
              dsurface.FrameRect(Bounds(DMiniMap.Left + mx - X, DMiniMap.Top + my - X, X, X), clFuchsia);
          end else
            if (g_nViewMinMapLv = 2) then begin
            for X := 2 to 6 do
              dsurface.FrameRect(Bounds(DMiniMap.Left + mx - X, DMiniMap.Top + my - X, X, X), clFuchsia);
          end;
        end;
        dsurface.BoldTextOut(DMiniMap.Left + mx - dsurface.TextWidth(sText) div 2, DMiniMap.Top + my, sText, clWhite);
      end;
    finally
      g_CartInfoList.UnLock;
    end;
    MainForm.Canvas.Font.Style := OldFontStyle;
    MainForm.Canvas.Font.Size := old;
    MainForm.Canvas.Font.Color := OldColor;
  end;
//==============================================================================


  if dd <> nil then dd.Free;
end;

procedure TFrmDlg.DMiniMapMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  nX, nY: Integer;
  Button: TMouseButton;
begin
  if g_nViewMinMapLv > 2 then begin
    g_nOScreenMoveX := X;
    g_nOScreenMoveY := Y;

    //if (g_nScreenMoveX <> g_nOScreenMoveX) or (g_nScreenMoveY <> g_nOScreenMoveY) or (Length(LegendMap.Path) <= 0) then begin
    g_nScreenMoveX := X;
    g_nScreenMoveY := Y;
    nX := X - DMiniMap.Left;
    nY := Y - DMiniMap.Top;
    nX := Round(nX * g_nMapWidth / DMiniMap.Width);
    nY := Round(nY * g_nMapHeight / DMiniMap.Height);
    nX := nX * 32 div 48;
    nY := nY * 32 div 32;
    g_nMapMoveX := nX;
    g_nMapMoveY := nY;

    if g_GuaJi.Started or (g_NewStatus <> sNone) then Exit;
    if (ssLeft in Shift) or (ssRight in Shift) then Exit;

    if {LegendMap.StartFind and }(LegendMap.FindX = g_nMapMoveX) and (LegendMap.FindY = g_nMapMoveY) then Exit;

    if (Length(LegendMap.Path) > 0) and
      (LegendMap.Path[Length(LegendMap.Path) - 1].X = g_nMapMoveX) and
    (LegendMap.Path[Length(LegendMap.Path) - 1].Y = g_nMapMoveY) then Exit;

    if (g_MySelf <> nil) and ((LegendMap.EndX < 0) or (LegendMap.EndY < 0)) then begin
      if GetTickCount - g_dwFindPathTick > 500 then begin
          //DScreen.AddChatBoardString(Format('(%d:%d) LoadAllOk:%s', [nX, nY, BoolToStr(Map.m_boLoadAllOk)]), clRed, clWhite);
        if Map.NewCanMove(nX, nY) then
          LegendMap.Find(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, nX, nY);
        g_dwFindPathTick := GetTickCount;
      end;
    end;
    Exit;
  end;
  if ssRight in Shift then begin
    frmMain.DXDrawMouseMove_(mbRight, Shift, X, Y);
  end else begin
    g_boShowMiniMapXY := True;
    g_nMinMapX := X;
    g_nMinMapY := Y;
  end;
end;

procedure TFrmDlg.DHeroHealthStateWinMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  sStr: string;
begin
  if g_MyHero = nil then Exit;
  if g_ConfigClient.btMainInterface in [0, 2] then begin
    if g_MyHero.m_Abil.MaxExp > 0 then begin
      sStr := 'HP: ' + IntToStr(g_MyHero.m_Abil.HP) + '/' + IntToStr(g_MyHero.m_Abil.MaxHP) + '\' +
        'MP: ' + IntToStr(g_MyHero.m_Abil.MP) + '/' + IntToStr(g_MyHero.m_Abil.MaxMP) + '\' +
        'Experience: ' + FloatToStrFixFmt(100 * g_MyHero.m_Abil.Exp / g_MyHero.m_Abil.MaxExp, 3, 2) + '%\';

      with DHeroHealthStateWin do
        DScreen.ShowHint(Left + Width, 25, sStr, clWhite, False);
    end;
  end else begin
    if g_MyHero.m_Abil.MaxExp > 0 then begin
      sStr := 'HP: ' + IntToStr(g_MyHero.m_Abil.HP) + '/' + IntToStr(g_MyHero.m_Abil.MaxHP) + '\' +
        'MP: ' + IntToStr(g_MyHero.m_Abil.MP) + '/' + IntToStr(g_MyHero.m_Abil.MaxMP) + '\' +
        'Experience: ' + FloatToStrFixFmt(100 * g_MyHero.m_Abil.Exp / g_MyHero.m_Abil.MaxExp, 3, 2) + '%\';

      with DHeroHealthStateWin do
        DScreen.ShowHint(Left + Width, Top + 32, sStr, clWhite, False);
    end;
  end;
end;

procedure TFrmDlg.DMiniMapMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pt: TPoint;
begin
  if g_GuaJi.Started or (g_NewStatus <> sNone) then Exit;
  if Button = mbLeft then begin
    if g_nViewMinMapLv >= 3 then begin
      if (Length(LegendMap.Path) > 0) and (LegendMap.EndX < 0) and (LegendMap.EndY < 0) and (not LegendMap.StartFind) then begin
        //LegendMap.Path := LegendMap.WalkToRun(LegendMap.Path);
        LegendMap.BeginX := g_MySelf.m_nCurrX;
        LegendMap.BeginY := g_MySelf.m_nCurrY;
        LegendMap.EndX := LegendMap.Path[Length(LegendMap.Path) - 1].X;
        LegendMap.EndY := LegendMap.Path[Length(LegendMap.Path) - 1].Y;
        DScreen.AddChatBoardString(Format('Automatically moving to (%d:%d)，press any Mouse Button to stop.', [LegendMap.EndX, LegendMap.EndY]), GetRGB(154), clWhite);
        Exit;
      end;
    end;
    if g_nViewMinMapLv >= 3 then g_nViewMinMapLv := 1
    else Inc(g_nViewMinMapLv);
  end else begin
    GetCursorPos(pt);
    pt := frmMain.ScreenToClient(pt);
    frmMain.DXDrawMouseDown_(Button, Shift, pt.X, pt.Y);
  end;
end;

procedure TFrmDlg.DMapTitleDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  lx, ly, sx: Integer;
  Str: string;
  rc: TRect;
begin
  with Sender as TDWindow do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then begin
      if DMiniMap.Visible then begin
        if g_nViewMinMapLv <= 2 then begin
          rc := Bounds(SCREENWIDTH - DMiniMap.Width, Top, DMiniMap.Width, Height);
        end else begin
          rc := DMapTitle.ClientRect;
        end;
        dsurface.StretchDraw(rc, d.ClientRect, d, True);
      end else begin
        //Left := SCREENWIDTH - Width;
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      end;
      if g_MySelf = nil then Exit;

      Str := g_sMapTitle + ' ' + IntToStr(g_MySelf.m_nCurrX) + ':' + IntToStr(g_MySelf.m_nCurrY);
      with dsurface do begin
        if DMiniMap.Visible then begin
          if g_nViewMinMapLv <= 2 then begin
            BoldTextOut(SurfaceX(rc.Left + (DMiniMap.Width - TextWidth(Str)) div 2), SurfaceY(Top + (17 - TextHeight('A')) div 2), Str);
          end else begin
            BoldTextOut(SurfaceX(rc.Left + (DMapTitle.Width - TextWidth(Str)) div 2), SurfaceY(Top + (17 - TextHeight('A')) div 2), Str);
          end;
        end else begin
          BoldTextOut(SurfaceX(Left + (139 - TextWidth(Str)) div 2), SurfaceY(Top + (17 - TextHeight('A')) div 2), Str);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DButtonOption1Click(Sender: TObject; X, Y: Integer);
begin
  if DEdChat.Visible then begin
    SetChatVisible(False);
    SetInputVisible(False);
  end else begin
    //SetChatVisible(True);
    SetInputVisible(True);
    SetChatVisible(True);
  end;
end;

procedure TFrmDlg.DEdChatClick(Sender: TObject; X, Y: Integer);
begin
  //PlayScene.EdChat.Visible := not PlayScene.EdChat.Visible;
end;

procedure TFrmDlg.DButtonOption1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
  Butt: TDButton;
  sMsg: string;
begin
  DScreen.ClearHint;
  Butt := TDButton(Sender);
  nHintX := Butt.Left;
  nHintY := Butt.SurfaceY(Butt.Top) - 25;
  if Sender = DButtonOption1 then sMsg := 'Show/Hide Chat Bar';
  if Sender = DButtonOption2 then sMsg := 'Show/Hide Control Button';
  DScreen.ShowHint(nHintX, nHintY, sMsg, clWhite {clYellow}, False);
end;

procedure TFrmDlg.DButtonOption2Click(Sender: TObject; X, Y: Integer);
begin
  if DBotMiniMap.Visible then
    SetButVisible(False)
  else SetButVisible(True)
end;

procedure TFrmDlg.DPlayToolClick(Sender: TObject; X, Y: Integer);
begin
  if Assigned(g_PlugInfo.MediaPlayer.Player) then begin
    g_PlugInfo.MediaPlayer.Player(nil, True, False);
  end;
end;


procedure TFrmDlg.DCategorizeSysClick(Sender: TObject; X, Y: Integer);
var
  d: TDButton;
begin
 { if Sender is TDButton then begin
    d := TDButton(Sender);
    if d <> DCategorizeSys then begin
      if DCategorizeSys.Downed then begin
        DCategorizeSys.Downed := False;
        Dec(DCategorizeSys.FaceIndex)
      end;
    end;
    if d <> DCategorizeGuild then begin
      if DCategorizeGuild.Downed then begin
        DCategorizeGuild.Downed := False;
        Dec(DCategorizeGuild.FaceIndex)
      end;
    end;
    if d <> DCategorizeGroup then begin
      if DCategorizeGroup.Downed then begin
        DCategorizeGroup.Downed := False;
        Dec(DCategorizeGroup.FaceIndex)
      end;
    end;
    if d <> DCategorizePrivate then begin
      if DCategorizePrivate.Downed then begin
        DCategorizePrivate.Downed := False;
        Dec(DCategorizePrivate.FaceIndex)
      end;
    end;
    if d <> nil then begin
      if d.Downed then begin
        d.Downed := False;
        Dec(d.FaceIndex)
      end else begin
        d.Downed := True;
        Inc(d.FaceIndex);
      end;
    end;
  end; }
end;

procedure TFrmDlg.DCategorizeSysDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TDButton;
  dd: TTexture;
begin
  if Sender is TDButton then begin
    d := TDButton(Sender);
    dd := d.WLib.Images[d.FaceIndex];
    if dd <> nil then
      dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, False);
  end;
end;

procedure TFrmDlg.DShowChatClick(Sender: TObject; X, Y: Integer);
begin
  if DChatDlg.Visible then begin
    if DMemoChat.Height = 12 * 14 then begin
      DShowChat.SetImgIndex(g_WCqFirImages, 145);
      SetChatVisible(False);
    end else
      if DMemoChat.Height = 12 * 9 then begin
      DChatDlg.Height := 12 * 14 + 2;
      DMemoChat.Height := 12 * 14;
      DChatDlg.Top := SCREENHEIGHT - DChatDlg.Height - DEdChat.Height - DBottom.Height; //SCREENHEIGHT - 251 + 118;

      DScrollChat.Height := DChatDlg.Height;
      DScrollChat.RightButton.Top := DScrollChat.Height - DScrollChat.RightButton.Height - 1;

      DMemoChat.RefreshPos;

      DScrollChat.Max := DMemoChat.MaxHeight + (DMemoChat.Height - 12);

      DShowChat.SetImgIndex(g_WCqFirImages, 147);
      SetChatVisible(True);
    end
  end else begin
    DChatDlg.Height := 12 * 9 + 2;
    DMemoChat.Height := 12 * 9;
    DChatDlg.Top := SCREENHEIGHT - DChatDlg.Height - DEdChat.Height - DBottom.Height; //SCREENHEIGHT - 251 + 118;

    DScrollChat.Height := DChatDlg.Height;
    DScrollChat.RightButton.Top := DScrollChat.Height - DScrollChat.RightButton.Height - 1;

    DMemoChat.RefreshPos;

    DScrollChat.Max := DMemoChat.MaxHeight + (DMemoChat.Height - 12);


    DShowChat.SetImgIndex(g_WCqFirImages, 145);
    SetChatVisible(True);
  end;
  DMemoChat.SpareSize := DMemoChat.Height - 12;
end;

procedure TFrmDlg.DEdChatDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with DEdChat do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, False);
  end;
end;

procedure TFrmDlg.DEdChatInRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
begin
  //IsRealArea := False;
end;

procedure TFrmDlg.DShowChatMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  sMsg: string;
begin
  if (g_nShowChatMemoCount < 5) then begin
    if not DChatDlg.Visible then begin
      sMsg := 'Show Chat';
    end else begin
      if DMemoChat.Height = 12 * 9 then begin
        sMsg := 'Show Big Chat';
      end else begin
        sMsg := 'Hide Chat';
      end;
    end;
    if (GetTickCount - g_dwShowChatMemoTick > 1000) then begin
      g_dwShowChatMemoTick := GetTickCount;
      Inc(g_nShowChatMemoCount);
    end else g_dwShowChatMemoTick := GetTickCount;
    DScreen.ShowHint(DShowChat.SurfaceX(DShowChat.Left), DShowChat.SurfaceY(DShowChat.Top) - 20, sMsg, clWhite {clYellow}, False);
  end;
end;

procedure TFrmDlg.CharMove(X: Integer);
begin
  if g_ConfigClient.btMainInterface in [0, 2] then Exit;
  if ChatDlgLeft > X then begin
    if DChatDlg.Left <= 0 then begin
      ChatDlgLeft := X;
      Exit;
    end;
    DChatDlg.Left := _MAX(DChatDlg.Left - (ChatDlgLeft - X), 0);
    DEdChat.Left := DChatDlg.Left;
  end else begin
    if DChatDlg.Left + DChatDlg.Width >= SCREENWIDTH then begin
      ChatDlgLeft := X;
      Exit;
    end;
    DChatDlg.Left := _MIN(DChatDlg.Left + (X - ChatDlgLeft), SCREENWIDTH - DChatDlg.Width);
    DEdChat.Left := DChatDlg.Left;
  end;
  ChatDlgLeft := X;
  //DEdChat.Top := SCREENHEIGHT - 20 - 44;
  {if DEdChat.Left + DEdChat.Width > SCREENWIDTH then begin //SCREENWIDTH - 23 * 9 - 3 * 8
    DEdChat.Left := SCREENWIDTH - DEdChat.Width;
  end;
  if DEdChat.Left < 0 then DEdChat.Left := 0;
  //PlayScene.EdChat.Top := 539;
  //PlayScene.EdChat.Left := DEdChat.Left + 21;
  DScroll.Left := DEdChat.Left;
  DListBox.Left := DScroll.Left + 15; }
end;

procedure TFrmDlg.DEdChatMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ssLeft in Shift then CharMove(X);
  DScreen.ClearHint;
  if g_ConfigClient.btMainInterface <> 0 then begin
    if not EdChat.Visible then begin
      if (g_nShowEditChatCount < 5) then begin
        if (GetTickCount - g_dwShowEditChatTick > 1000) then begin
          g_dwShowEditChatTick := GetTickCount;
          Inc(g_nShowEditChatCount);
        end else g_dwShowEditChatTick := GetTickCount;
        DScreen.ShowHint(DEdChat.SurfaceX(X), DEdChat.SurfaceY(DEdChat.Top), '鼠标左键点击拖动，可以移动聊天框', clWhite {clYellow}, False);
      end;
    end;
  end;
end;

procedure TFrmDlg.DListBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    frmMain.DXDrawMouseDown_(Button, Shift, X, Y);
end;

procedure TFrmDlg.DButtonShopClick(Sender: TObject; X, Y: Integer);
begin
  if not DShop.Visible then begin
    ChgShopSelButton(ShopTabPage);
    if g_ShopItems[ShopTabPage, 0].StdItem.Name = '' then begin
      if g_SuperShopItems[0].StdItem.Name = '' then begin
        frmMain.SendShopDlg(ShopPage[ShopTabPage], ShopTabPage, 5);
      end else begin
        frmMain.SendShopDlg(ShopPage[ShopTabPage], ShopTabPage, 0);
      end;
    end;
    {if g_SuperShopItems[0].StdItem.Name = '' then begin
      frmMain.SendShopDlg(ShopPage[ShopTabPage], 5);
    end;  }
    OpenShopDlg;
  end else begin
    DShop.Visible := False;
  end;
  //Showmessage(TDButton(Sender).Name+' Left:'+IntToStr(TDButton(Sender).Left)+' Top:'+IntToStr(TDButton(Sender).Top));
end;

procedure TFrmDlg.DDuelOKClick(Sender: TObject; X, Y: Integer);
var
  mi: Integer;
begin
  if GetTickCount > g_dwDuelActionTick then begin
    //CloseDealDlg;
    frmMain.SendDuelEnd;
    g_dwDuelActionTick := GetTickCount + 4000;
    g_boDuelEnd := True;
    if g_boItemMoving then begin
      mi := g_MovingItem.Index;
      if (mi <= -30) and (mi > -40) then begin
        AddDuelItem(g_MovingItem.Item);
        g_boItemMoving := False;
        g_MovingItem.Item.s.Name := '';
      end;
    end;
  end;
end;

procedure TFrmDlg.DDDuelGoldMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  DScreen.ShowHint(DDDuelGold.SurfaceX(DDDuelGold.Left),
    DDDuelGold.SurfaceY(DDDuelGold.Top) - 20, '单击增加元宝', clWhite {clYellow}, False);
end;

procedure TFrmDlg.EdSearchKeyPress(Sender: TObject; var Key: Char);
begin
  //if Length(EdSearch.Text) > 30 then EdSearch.Text := '';
end;

procedure TFrmDlg.DStoreOpenDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  d := nil;
  with Sender as TDButton do begin
    if not Downed then begin
      if WLib <> nil then
        d := WLib.Images[FaceIndex]
    end else begin
      if WLib <> nil then
        d := WLib.Images[FaceIndex + 1];
    end;
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
  end;
end;

procedure TFrmDlg.DStoreCloseClick(Sender: TObject; X, Y: Integer);
begin
  CloseStoreDlg;
end;

procedure TFrmDlg.DStoreMsgDlgOkClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DStoreMsgDlgOk then DStoreMsgDlg.DialogResult := mrOk;
  if Sender = DStoreMsgDlgCancel then DStoreMsgDlg.DialogResult := mrCancel;
  DStoreMsgDlg.Visible := False;
end;

function TFrmDlg.DStoreMessageDlg(): TModalResult;
const
  XBase = 324;
var
  I: Integer;
  lx, ly: Integer;
  d: TTexture;
  procedure ShowDice();
  var
    I: Integer;
    bo05: Boolean;
  begin
    if m_nDiceCount = 1 then begin
      if m_Dice[0].n67C < 20 then begin
        if GetTickCount - m_Dice[0].dwPlayTick > 100 then begin
          if m_Dice[0].n67C div 5 = 4 then begin
            m_Dice[0].nPlayPoint := Random(6) + 1;
          end else begin
            m_Dice[0].nPlayPoint := m_Dice[0].n67C div 5 + 8;
          end;
          m_Dice[0].dwPlayTick := GetTickCount();
          Inc(m_Dice[0].n67C);
        end;
        Exit;
      end;
      m_Dice[0].nPlayPoint := m_Dice[0].nDicePoint;
      if GetTickCount - m_Dice[0].dwPlayTick > 1500 then begin
        DStoreMsgDlg.Visible := False;
      end;
      Exit;
    end;

    bo05 := True;
    for I := 0 to m_nDiceCount - 1 do begin
      if m_Dice[I].n67C < m_Dice[I].n680 then begin
        if GetTickCount - m_Dice[I].dwPlayTick > 100 then begin
          if m_Dice[I].n67C div 5 = 4 then begin
            m_Dice[I].nPlayPoint := Random(6) + 1;
          end else begin
            m_Dice[I].nPlayPoint := m_Dice[I].n67C div 5 + 8;
          end;
          m_Dice[I].dwPlayTick := GetTickCount();
          Inc(m_Dice[I].n67C);
        end;
        bo05 := False;
      end else begin
        m_Dice[I].nPlayPoint := m_Dice[I].nDicePoint;
        if GetTickCount - m_Dice[I].dwPlayTick < 2000 then begin
          bo05 := False;
        end;
      end;
    end; //for
    if bo05 then begin
      DStoreMsgDlg.Visible := False;
    end;
  end;
begin
  //DStoreMsgDlg.Visible := True;
  for I := 0 to m_nDiceCount - 1 do begin
    m_Dice[I].n67C := 0;
    m_Dice[I].n680 := Random(m_nDiceCount + 2) * 5 + 10;
    m_Dice[I].nPlayPoint := 1;
    m_Dice[I].dwPlayTick := GetTickCount();
  end;

  DStoreMsgDlg.ShowModal;
  SetDFocus(EdStoreDlgEdit);
  Result := mrOk;

  while True do begin
    if not DStoreMsgDlg.Visible then Break;
    frmMain.ProcOnIdle;
    Application.ProcessMessages;
    if m_nDiceCount > 0 then begin
      m_boPlayDice := True;
      for I := 0 to m_nDiceCount - 1 do begin
        m_Dice[I].nX := ((DStoreMsgDlg.Width div 2 + 6) - ((m_nDiceCount * 32 + m_nDiceCount) div 2)) + (I * 32 + I);
        m_Dice[I].nY := DStoreMsgDlg.Height div 2 - 14;
      end;
      ShowDice();
    end;
    if Application.Terminated then Exit;
    Sleep(1);
  end;

  StoreDlgEditText := Trim(EdStoreDlgEdit.Text);
  if EdChat.Visible then EdChat.SetFocus;
  Result := DStoreMsgDlg.DialogResult;
  m_nDiceCount := 0;
  m_boPlayDice := False;
end;

procedure TFrmDlg.DStoreMsgDlgDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  I: Integer;
  nX, nY: Integer;
  d: TTexture;
begin
  d := nil;
  with Sender as TDWindow do begin
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    if m_boPlayDice then begin
      for I := 0 to m_nDiceCount - 1 do begin
        d := g_WBagItemImages.GetCachedImage(m_Dice[I].nPlayPoint + 376 - 1, nX, nY);
        if d <> nil then begin
          dsurface.Draw(SurfaceX(Left) + m_Dice[I].nX + nX - 14, SurfaceY(Top) + m_Dice[I].nY + nY + 38, d.ClientRect, d, True);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.EdStoreDlgEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    DStoreMsgDlgOkClick(DStoreMsgDlgOk, 0, 0);
  end;
end;

procedure TFrmDlg.DStoreDlgClick(Sender: TObject; X, Y: Integer);
begin
  ReleaseDFocus;
end;

procedure TFrmDlg.DUserStoreClick(Sender: TObject; X, Y: Integer);
begin
  ReleaseDFocus;
end;

procedure TFrmDlg.DUserStoreCloseClick(Sender: TObject; X, Y: Integer);
begin
  CloseUserStoreDlg;
end;

procedure TFrmDlg.DGStoreGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TTexture);
var
  nIdx: Integer;
  d: TTexture;
begin
  nIdx := ACol + ARow * DGStore.ColCount;
  if nIdx in [0..15 - 1] then begin
    if g_StoreItems[nIdx].Item.s.Name <> '' then begin
      d := g_WBagItemImages.Images[g_StoreItems[nIdx].Item.s.looks];
      if d <> nil then
        with DGStore do begin
          dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
            d.ClientRect,
            d, True);
        end;

      with DGStore do begin
        if (g_StoreItems[nIdx].Item.s.AddValue[12] in [1, 3]) {or (GetAddPoint(g_StoreItems[nIdx].Item.s.AddPoint))} then begin
          if GetTickCount - g_DrawStoreItems[nIdx].dwDrawTick >= 200 then begin
            g_DrawStoreItems[nIdx].dwDrawTick := GetTickCount;
            if g_DrawStoreItems[nIdx].nIndex <= 0 then g_DrawStoreItems[nIdx].nIndex := 260 - 1;
            Inc(g_DrawStoreItems[nIdx].nIndex);
            if g_DrawStoreItems[nIdx].nIndex > 265 then g_DrawStoreItems[nIdx].nIndex := 260;
          end;
          d := g_WMain2Images.Images[g_DrawItemArr[nIdx].nIndex];
          if d <> nil then begin
            DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1), d);
          end;
        end;

        if g_StoreItems[nIdx].Item.s.AddValue[12] >= 2 then begin
          if GetTickCount - g_DrawStoreItems_[nIdx].dwDrawTick >= 200 then begin
            g_DrawStoreItems_[nIdx].dwDrawTick := GetTickCount;
            if g_DrawStoreItems_[nIdx].nIndex <= 0 then g_DrawStoreItems_[nIdx].nIndex := 600 - 1;
            Inc(g_DrawStoreItems_[nIdx].nIndex);
            if g_DrawStoreItems_[nIdx].nIndex > 617 then g_DrawStoreItems_[nIdx].nIndex := 600;
          end;
          d := g_WMain3Images.Images[g_DrawStoreItems_[nIdx].nIndex];
          if d <> nil then begin
            DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1), d);
          end;
        end;
      end;

    end;
  end;
end;

procedure TFrmDlg.DGStoreGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  Idx: Integer;
  Button: TMouseButton;
  iname, d1, d2, d3: string;
  useable: Boolean;

  nWhere: Integer;
  List: TStringList;
begin
  DScreen.ClearHint;
  if ssRight in Shift then begin
    if g_boItemMoving then
      DGStoreGridSelect(Self, ACol, ARow, Shift);
  end else begin
    Idx := ACol + ARow * DGStore.ColCount;
    if Idx in [0..15 - 1] then begin
      g_MoveRect := DGStore.ClientRect;
      g_MoveRect.Right := g_MoveRect.Right - 1;
      g_MoveRect.Top := g_MoveRect.Top + 2;
      g_MoveRect.Bottom := g_MoveRect.Bottom - 1;
      g_MouseItem := g_StoreItems[Idx].Item;
      if (g_MouseItem.s.Name <> '') then begin

        nWhere := GetHumUseItemByBagItem(g_MouseItem.s.StdMode);
        if g_Config.boCompareItem and (nWhere >= 0) then begin

          List := TStringList.Create;
          try
            GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
            HintList.AddObject('售价: ' + IntToStr(g_MouseItem.s.Price) + ' ' + GetStorePriceName(g_StoreItems[Idx].btSellType), TObject(clLime));
            List.AddStrings(HintList);

            GetMouseItemInfo(g_MySelf, @g_UseItems[nWhere], iname, d1, d2, d3, useable);
            if HintList.Count > 0 then begin
              HintList.Strings[0] := GetUseItemName(nWhere) + ' ' + HintList.Strings[0];
            end;
            with DGStore do
              DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
                SurfaceY(Top + (ARow + 1) * RowHeight),
                List, HintList, False);
            HintList.Clear;
          finally
            List.Free;
          end;
          g_MouseItem.s.Name := '';
        end else begin
          GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
          with DGStore do
            DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
              SurfaceY(Top + (ARow + 1) * RowHeight),
              HintList, False);
        end;

        {GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
        HintList.AddObject('售价: ' + IntToStr(g_MouseItem.s.Price) + ' ' + GetStorePriceName(g_StoreItems[Idx].btSellType), TObject(clLime));
        with DGStore do
          DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
            SurfaceY(Top + (ARow + 1) * RowHeight),
            HintList, False); }
      end;
    end else begin
      ClearMoveRect();
      g_MouseItem.s.Name := '';
    end;
  end;
end;

procedure TFrmDlg.DGStoreGridSelect(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
  Idx, Price: Integer;
label InPutPrice;
begin
  if g_MySelf.m_boStartStore or g_boStartStoreing then Exit;
  Idx := ACol + ARow * DGStore.ColCount;
  if Idx in [0..15 - 1] then begin
    if not g_boItemMoving then begin
      ClearMoveRect();
      if g_StoreItems[Idx].Item.s.Name <> '' then begin
        g_boItemMoving := True;
        g_MovingItem.Index := Idx;
        g_MovingItem.Index2 := g_StoreItems[Idx].btSellType;
        g_MovingItem.Item := g_StoreItems[Idx].Item;
        g_MovingItem.Owner := DStoreDlg;
        ItemClickSound(g_StoreItems[Idx].Item.s);
        g_StoreItems[Idx].Item.s.Name := '';
      end;
    end else begin
      if (g_MovingItem.Owner = DItemBag) or (g_MovingItem.Owner = DStoreDlg) then begin
        if g_StoreItems[Idx].Item.s.Name = '' then begin
          if (g_MovingItem.Owner = DItemBag) then begin
            g_WaitingStoreItem := g_MovingItem;
            g_boItemMoving := False;
            g_MovingItem.Item.s.Name := '';
            g_MovingItem.Owner := nil;
            ClearMoveRect();
            InPutPrice:
            if DStoreMessageDlg = mrOk then begin
              Price := Str_ToInt(StoreDlgEditText, 0);
              if Price > 0 then begin
                case DStoreMsgDlg.FaceIndex of
                  157: g_StoreItems[Idx].btSellType := 0;
                  158: g_StoreItems[Idx].btSellType := 1;
                  159: g_StoreItems[Idx].btSellType := 2;
                  160: g_StoreItems[Idx].btSellType := 3;
                end;
                g_StoreItems[Idx].Item := g_WaitingStoreItem.Item;
                g_StoreItems[Idx].Item.s.Price := Price;
                g_WaitingStoreItem.Item.s.Name := '';
                g_boItemMoving := False;
                g_WaitingStoreItem.Owner := nil;
              end else begin
                goto InPutPrice;
                Exit;
              end;
            end else begin
              AddItemBag(g_WaitingStoreItem.Item);
              g_WaitingStoreItem.Item.s.Name := '';
              g_boItemMoving := False;
              g_WaitingStoreItem.Owner := nil;
            end;
          end else begin
            g_StoreItems[Idx].Item := g_MovingItem.Item;
            g_StoreItems[Idx].btSellType := g_MovingItem.Index2;
            g_MovingItem.Item.s.Name := '';
            g_boItemMoving := False;
            g_MovingItem.Owner := nil;
          end;
        end;
      end;
    end;
  end;
  ArrangeItemBag;
end;

procedure TFrmDlg.DGUserStoreGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  Idx: Integer;
  iname, d1, d2, d3: string;
  useable: Boolean;
begin
  DScreen.ClearHint;
  Idx := ACol + ARow * DGUserStore.ColCount;
  if Idx in [0..14] then begin
    g_MouseItem := g_StoreRemoteItems[Idx].Item;
    if g_MouseItem.s.Name <> '' then begin
      GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
      HintList.AddObject('售价: ' + IntToStr(g_MouseItem.s.Price) + ' ' + GetStorePriceName(g_StoreRemoteItems[Idx].btSellType), TObject(clLime));
      with DGUserStore do
        DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
          SurfaceY(Top + (ARow + 1) * RowHeight),
          HintList, False);
    end;
  end;
end;

procedure TFrmDlg.DGUserStoreGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TTexture);
var
  nIdx: Integer;
  d: TTexture;
begin
  nIdx := ACol + ARow * DGUserStore.ColCount;
  if nIdx in [0..14] then begin
    if g_StoreRemoteItems[nIdx].Item.s.Name <> '' then begin
      d := g_WBagItemImages.Images[g_StoreRemoteItems[nIdx].Item.s.looks];
      if d <> nil then
        with DGUserStore do begin
          dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
            d.ClientRect,
            d, True);
        end;

      if (g_SelectStoreItem.Item.s.Name <> '') and (gdSelected in State) then begin
        dsurface.FillRectAlpha(g_MoveRect, clGreen, 150);
      end;

      with DGUserStore do begin
        if (g_StoreRemoteItems[nIdx].Item.s.AddValue[12] in [1, 3]) {or (GetAddPoint(g_StoreRemoteItems[nIdx].Item.s.AddPoint))} then begin
          if GetTickCount - g_DrawStoreRemoteItems[nIdx].dwDrawTick >= 200 then begin
            g_DrawStoreRemoteItems[nIdx].dwDrawTick := GetTickCount;
            if g_DrawStoreRemoteItems[nIdx].nIndex <= 0 then g_DrawStoreRemoteItems[nIdx].nIndex := 260 - 1;
            Inc(g_DrawStoreRemoteItems[nIdx].nIndex);
            if g_DrawStoreRemoteItems[nIdx].nIndex > 265 then g_DrawStoreRemoteItems[nIdx].nIndex := 260;
          end;
          d := g_WMain2Images.Images[g_DrawStoreRemoteItems[nIdx].nIndex];
          if d <> nil then begin
            DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1), d);
          end;
        end;

        if g_StoreRemoteItems[nIdx].Item.s.AddValue[12] >= 2 then begin
          if GetTickCount - g_DrawStoreRemoteItems_[nIdx].dwDrawTick >= 200 then begin
            g_DrawStoreRemoteItems_[nIdx].dwDrawTick := GetTickCount;
            if g_DrawStoreRemoteItems_[nIdx].nIndex <= 0 then g_DrawStoreRemoteItems_[nIdx].nIndex := 600 - 1;
            Inc(g_DrawStoreRemoteItems_[nIdx].nIndex);
            if g_DrawStoreRemoteItems_[nIdx].nIndex > 617 then g_DrawStoreRemoteItems_[nIdx].nIndex := 600;
          end;
          d := g_WMain3Images.Images[g_DrawStoreRemoteItems_[nIdx].nIndex];
          if d <> nil then begin
            DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1), d);
          end;
        end;
      end;
    end;

  end;
end;

procedure TFrmDlg.DStoreDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  DScreen.ClearHint;
end;

procedure TFrmDlg.DUserStoreMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  DScreen.ClearHint;
end;

procedure TFrmDlg.DStoreDlgDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  sStoreName: string;
  old: Integer;
begin
  with DStoreDlg do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    if g_MySelf.m_boStartStore then begin
      sStoreName := g_MySelf.m_sUserName + '的摊位';
      with dsurface do begin
        TextOut(SurfaceX(Left) + 86, SurfaceY(Top) + 56, sStoreName);
      end;
    end;
  end;
end;

procedure TFrmDlg.DUserStoreDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  old: Integer;
begin
  with DUserStore do begin
    d := nil;
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    if g_sStoreMasterName <> '' then begin
      with dsurface do begin
        TextOut(SurfaceX(Left) + 50 + (140 - TextWidth(g_sStoreMasterName)) div 2, SurfaceY(Top) + 26, g_sStoreMasterName);
      end;
    end;
  end;
end;

procedure TFrmDlg.DStoreOpenClick(Sender: TObject; X, Y: Integer);
begin
  if (GetTickCount - g_dwStartStoreTick > 1000 * 5) and g_boStartStoreing then begin
    g_boStartStoreing := False;
  end;

  if g_MySelf.m_boStartStore or g_boStartStoreing then Exit;
  if g_boItemMoving then begin
    DMessageDlg('Do not move the item', [mbOk]);
    Exit;
  end;

  if GetTickCount - g_dwStartStoreTick > 1000 * 3 then begin
    g_dwStartStoreTick := GetTickCount;
    g_boStartStoreing := True;
    {g_TargetCret := nil;
    g_FocusCret := nil;
    g_MagicTarget := nil;  }
    frmMain.SendStartStore;
  end;
end;

procedure TFrmDlg.DStoreCancelClick(Sender: TObject; X, Y: Integer);
begin
  if not g_MySelf.m_boStartStore then Exit;
  if GetTickCount - g_dwStartStoreTick > 1000 * 3 then begin
    g_dwStartStoreTick := GetTickCount;
    frmMain.SendClientMessage(CM_STOPSTORE, g_MySelf.m_nRecogId, 0, 0, 0);
  end;
end;

procedure TFrmDlg.DGUserStoreGridSelect(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  Idx, Price: Integer;
begin
  ClearMoveRect();
  g_SelectStoreItem.Item.s.Name := '';
  Idx := ACol + ARow * DGUserStore.ColCount;
  if Idx in [0..15 - 1] then begin
    if g_StoreRemoteItems[Idx].Item.s.Name <> '' then begin
      with DGUserStore do begin
        g_MoveRect.Left := SurfaceX(Left) + ACol * ColWidth;
        g_MoveRect.Top := SurfaceY(Top) + ARow * RowHeight;
        g_MoveRect.Right := g_MoveRect.Left + ColWidth;
        g_MoveRect.Bottom := g_MoveRect.Top + RowHeight;
      end;
      {g_MoveRect := DGUserStore.ClientRect;
      g_MoveRect.Right := g_MoveRect.Right - 1;
      g_MoveRect.Top := g_MoveRect.Top + 2;
      g_MoveRect.Bottom := g_MoveRect.Bottom - 1; }
      g_SelectStoreItem := g_StoreRemoteItems[Idx];
    end;
  end;
end;

procedure TFrmDlg.DUserStoreBuyClick(Sender: TObject; X, Y: Integer);
begin
  if g_nStoreMasterRecogId = g_MySelf.m_nRecogId then Exit;
  if g_SelectStoreItem.Item.s.Name <> '' then begin
    if mrOk = DMessageDlg('Do you want to buy this item from: ' + g_sStoreMasterName + ' Item: ' + g_SelectStoreItem.Item.s.Name + '?', [mbOk, mbCancel]) then begin
      frmMain.SendBuyStoreItem(g_SelectStoreItem.Item.s.Name, g_SelectStoreItem.Item.MakeIndex, g_nStoreMasterRecogId);
    end;
  end;
end;

procedure TFrmDlg.DStoreMsgDlgClick(Sender: TObject; X, Y: Integer);
var
  nX, nY: Integer;
begin
  nX := X - DStoreMsgDlg.Left;
  nY := Y - DStoreMsgDlg.Top;
  if (nY >= 25) and (nY <= 45) then begin
    if (nX >= 22) and (nX <= 105) then DStoreMsgDlg.FaceIndex := 157;
    if (nX >= 106) and (nX <= 188) then DStoreMsgDlg.FaceIndex := 158;
    if (nX >= 189) and (nX <= 270) then DStoreMsgDlg.FaceIndex := 159;
    if (nX >= 271) and (nX <= 354) then DStoreMsgDlg.FaceIndex := 160;
  end;
end;

procedure TFrmDlg.DMainMenuClick(Sender: TObject; X, Y: Integer);
begin
  if DMainMenu.DControl <> nil then begin
    if DMainMenu.DControl is TDEdit then begin
      case DMainMenu.itemindex of
        0: TDEdit(DMainMenu.DControl).CutText;
        1: TDEdit(DMainMenu.DControl).CopyText;
        2: TDEdit(DMainMenu.DControl).PasteText;
        3: TDEdit(DMainMenu.DControl).DeleteText;
        5: TDEdit(DMainMenu.DControl).SelectAll;
      end;
    end;
  end;
end;

procedure TFrmDlg.EdIdKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    Key := #0;
    LoginScene.m_sLoginId := LowerCase(EdId.Text);
    if LoginScene.m_sLoginId <> '' then begin
      EdPasswd.SetFocus;
      EdPasswd.SelectAll;
    end;
  end else
    if Key = #9 then begin //VK_TAB
    Key := #0;
    EdPasswd.SetFocus;
    EdPasswd.SelectAll;
  end;
end;

procedure TFrmDlg.EdPasswdKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = '~') or (Key = '''') then Key := '_';
  if Key = #13 then begin
    Key := #0;
    LoginScene.m_sLoginId := LowerCase(EdId.Text);
    LoginScene.m_sLoginPasswd := EdPasswd.Text;
    if (LoginScene.m_sLoginId <> '') and (LoginScene.m_sLoginPasswd <> '') then begin
      frmMain.SendLogin(LoginScene.m_sLoginId, LoginScene.m_sLoginPasswd);
      EdId.Text := '';
      EdPasswd.Text := '';
    end else
      if (EdId.Visible) and (EdId.Text = '') then EdId.SetFocus;
  end else
    if Key = #9 then begin
    Key := #0;
    EdId.SetFocus;
    EdId.SelectAll;
  end;
end;

procedure TFrmDlg.EdChatKeyPress(Sender: TObject; var Key: Char);
begin
  if DScreen.CurrentScene = PlayScene then begin
    if Key = #13 then begin
      frmMain.SendSay(EdChat.Text);
      EdChat.Text := '';
      EdChat.Visible := False;
      Key := #0;
    end;
    if Key = #27 then begin
      EdChat.Text := '';
      EdChat.Visible := False;
      Key := #0;
    end;
  end;
end;

procedure TFrmDlg.EdDlgEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    if DMsgDlgOk.Visible then begin
      DMsgDlgOkClick(DMsgDlgOk, 0, 0);
    end else
      if DMsgDlgYes.Visible then begin
      DMsgDlgOkClick(DMsgDlgYes, 0, 0);
    end;
  end;
end;

procedure TFrmDlg.EdChatMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  DScreen.ClearHint;
end;

procedure TFrmDlg.DGetBoxItemFlashMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  g_boGetBoxItemMouseMove := not g_boGetBoxItem;
 { if not g_boGetBoxItem then begin
    g_boGetBoxItemMouseMove := True;
    //DScreen.ShowHint(DGetBoxItem.SurfaceX(X), DGetBoxItem.SurfaceY(Y), '试试运气', clLime, False);
  end;}
  //Showmessage('TFrmDlg.DGetBoxItemFlashMouseMove');
end;

procedure TFrmDlg.DGetBoxItemMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  g_boGetBoxItemMouseMove := True;
end;

procedure TFrmDlg.DGetBoxItemFlashClick(Sender: TObject; X, Y: Integer);
begin
  if g_boGetBoxItem then Exit;
  g_boGetBoxItem := True;
  PlaySound(s_SelectBoxFlash);
  frmMain.SendClientMessage(CM_GETSELBOXITEMNUM, 0, 0, 0, 0);
end;

procedure TFrmDlg.ShowRandomDlg;
begin
  DWRandomCode.Visible := True;
  DEditRandomCode.Visible := True;
  DEditRandomCode.Text := '';
  DEditRandomCode.SetFocus;
end;

procedure TFrmDlg.CloseRandomDlg;
begin
  DWRandomCode.Visible := False;
  DEditRandomCode.Visible := False;
end;

procedure TFrmDlg.DWRandomCodeDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  rc: TRect;
begin
  with DWRandomCode do begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    rc := g_RandomSurface.ClientRect;
    rc.Top := rc.Top + 5;
    dsurface.Draw(SurfaceX(Left) + 40, SurfaceY(Top) + 45, rc, g_RandomSurface, True);
   // dsurface.StretchDraw(Bounds(SurfaceX(Left) + 35, SurfaceY(Top) + 48, 135, 42), g_RandomSurface.ClientRect, g_RandomSurface, True);
  end;
end;

procedure TFrmDlg.DBRandomCodeOKClick(Sender: TObject; X, Y: Integer);
var
  sRandomCode: string;
begin
  sRandomCode := Trim(DEditRandomCode.Text);
  if sRandomCode <> '' then begin
    frmMain.SendRandomCode(sRandomCode);
    CloseRandomDlg;
  end;
end;

procedure TFrmDlg.DBRandomCodeChgClick(Sender: TObject; X, Y: Integer);
begin
  frmMain.SendGetRandomBuffer();
end;

procedure TFrmDlg.DSWWeaponDblClick(Sender: TObject);
var
  where: Integer;
begin
  if g_MySelf = nil then Exit;
  if StatePage <> 0 then Exit;
  if g_boItemMoving or (g_WaitingUseItem.Item.s.Name <> '') then Exit;
  where := -1;
  if Sender = DSWDress then where := U_DRESS;
  if Sender = DSWWeapon then where := U_WEAPON;
  if Sender = DSWHelmet then where := U_HELMET;
  if Sender = DSWNecklace then where := U_NECKLACE;
  if Sender = DSWLight then where := U_RIGHTHAND;
  if Sender = DSWRingL then where := U_RINGL;
  if Sender = DSWRingR then where := U_RINGR;
  if Sender = DSWArmRingL then where := U_ARMRINGL;
  if Sender = DSWArmRingR then where := U_ARMRINGR;

  if Sender = DSWBujuk then where := U_BUJUK;
  if Sender = DSWBelt then where := U_BELT;
  if Sender = DSWBoots then where := U_BOOTS;
  if Sender = DSWCharm then where := U_CHARM;

  if where in [U_DRESS..U_CHARM] then begin
    if g_UseItems[where].s.Name <> '' then begin
      ItemClickSound(g_UseItems[where].s);
      g_WaitingUseItem.Item := g_UseItems[where];
      g_MovingItem.Index := -(where + 1);
      g_UseItems[where].s.Name := '';
      frmMain.SendTakeOffItem(-(g_WaitingUseItem.Index + 1), g_WaitingUseItem.Item.MakeIndex, g_WaitingUseItem.Item.s.Name);
      ArrangeItemBag;
    end;
  end;
end;

procedure TFrmDlg.EdChatMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //DScreen.AddChatBoardString('TFrmDlg.EdChatMouseDown', clyellow, clRed);
end;

procedure TFrmDlg.DMerchantDlgInRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
var
  d: TTexture;
begin
  IsRealArea := True;
  with TDControl(Sender) do begin
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then begin
        if d.Pixels[X, Y] = 0 then
          IsRealArea := False;
      end;
    end;
  end;
end;

procedure TFrmDlg.DAdjustAbilOkDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    if Downed then begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex + 1];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end else begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DPlusSCDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    if g_nBonusPoint > 0 then begin
      FaceIndex := 212;
    end else begin
      FaceIndex := 216;
    end;
    if Downed and (g_nBonusPoint > 0) then begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex + 1];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end else begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;


procedure TFrmDlg.DMinusSCDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;

  decp: Integer;
  boDec: Boolean;
begin
  boDec := False;
  with Sender as TDButton do begin
    if IsKeyPressed(VK_CONTROL) and (g_nBonusPoint - 10 > 0) then decp := 10
    else decp := 1;
    if Sender = DMinusDC then
      if g_BonusAbilChg.DC >= decp then begin
        boDec := True;
      end;
    if Sender = DMinusMC then
      if g_BonusAbilChg.MC >= decp then begin
        boDec := True;
      end;
    if Sender = DMinusSC then
      if g_BonusAbilChg.SC >= decp then begin
        boDec := True;
      end;
    if Sender = DMinusAC then
      if g_BonusAbilChg.AC >= decp then begin
        boDec := True;
      end;
    if Sender = DMinusMAC then
      if g_BonusAbilChg.MAC >= decp then begin
        boDec := True;
      end;
    if Sender = DMinusHP then
      if g_BonusAbilChg.HP >= decp then begin
        boDec := True;
      end;
    if Sender = DMinusMP then
      if g_BonusAbilChg.MP >= decp then begin
        boDec := True;
      end;
    if Sender = DMinusHit then
      if g_BonusAbilChg.Hit >= decp then begin
        boDec := True;
      end;
    if Sender = DMinusSpeed then
      if g_BonusAbilChg.Speed >= decp then begin
        boDec := True;
      end;

    if boDec then begin
      FaceIndex := 214;
    end else begin
      FaceIndex := 217;
    end;

    if Downed and (boDec) then begin
      d := nil;
      if WLib <> nil then
        d := WLib.Images[FaceIndex + 1];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end else begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;


procedure TFrmDlg.DMerchantDlgMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  DScreen.ClearHint;
end;

procedure TFrmDlg.DBotCharRankingDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    d := nil;
    if TDButton(Sender).Downed then begin
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.RankingPageChanged(Sender: TObject);
begin
  RankingPage := -1;
  if Sender = DBotCharRanking then begin
    DBotCharRanking.Downed := True;
    DBotHeroRanking.Downed := False;
    DBotMasterRanking.Downed := False;

    DBotHeroActorRanking.Visible := False;
    DBotHeroWarriorRanking.Visible := False;
    DBotHeroWizzardRanking.Visible := False;
    DBotHeroMonkRanking.Visible := False;
    DBotActorRanking.Visible := True;
    DBotWarriorRanking.Visible := True;
    DBotWizzardRanking.Visible := True;
    DBotMonkRanking.Visible := True;
    g_nRankingsTablePage := 0;

  end else
    if Sender = DBotHeroRanking then begin
    DBotCharRanking.Downed := False;
    DBotHeroRanking.Downed := True;
    DBotMasterRanking.Downed := False;

    DBotActorRanking.Visible := False;
    DBotWarriorRanking.Visible := False;
    DBotWizzardRanking.Visible := False;
    DBotMonkRanking.Visible := False;
    DBotHeroActorRanking.Visible := True;
    DBotHeroWarriorRanking.Visible := True;
    DBotHeroWizzardRanking.Visible := True;
    DBotHeroMonkRanking.Visible := True;
    g_nRankingsTablePage := 1;

  end else
    if Sender = DBotMasterRanking then begin
    DBotCharRanking.Downed := False;
    DBotHeroRanking.Downed := False;
    DBotMasterRanking.Downed := True;

    DBotActorRanking.Visible := False;
    DBotWarriorRanking.Visible := False;
    DBotWizzardRanking.Visible := False;
    DBotMonkRanking.Visible := False;

    DBotHeroActorRanking.Visible := False;
    DBotHeroWarriorRanking.Visible := False;
    DBotHeroWizzardRanking.Visible := False;
    DBotHeroMonkRanking.Visible := False;
    g_nRankingsTablePage := 2;

    RankingPage := 0;
    FillChar(g_UserMasterRankings, SizeOf(TUserMasterRanking) * 10, #0);
    frmMain.SendGetRanking(g_nRankingsTablePage, 0, 0);
  end;
end;

procedure TFrmDlg.DRankingDlgDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  I, lx, ly, n, old: Integer;
  CColor: TColor;
begin
  with DRankingDlg do begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    if DBotCharRanking.Downed then begin
      if RankingPage >= 0 then begin
        d := g_WMain3Images.Images[423];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left + 26), SurfaceY(Top + 91), d.ClientRect, d, True);
        n := 0;

        with dsurface do begin
          CColor := clWhite;
          for I := 0 to Length(g_UserLevelRankings) - 1 do begin
            if I = RankingSelectLine - 1 then CColor := clyellow else CColor := clWhite;
            if g_UserLevelRankings[I].sChrName <> '' then begin
              TextOut(SurfaceX(Left + 52), SurfaceY(Top + 118 + n), IntToStr(g_UserLevelRankings[I].nIndex), CColor);
              TextOut(SurfaceX(Left + 114), SurfaceY(Top + 118 + n), g_UserLevelRankings[I].sChrName, CColor);
              TextOut(SurfaceX(Left + 258), SurfaceY(Top + 118 + n), IntToStr(g_UserLevelRankings[I].nLevel), CColor);
              Inc(n, LISTLINEHEIGHT + 9);
            end;
          end;
        end;
      end;
    end else
      if DBotHeroRanking.Downed then begin
      if RankingPage >= 0 then begin
        d := g_WMain3Images.Images[424];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left + 26), SurfaceY(Top + 91), d.ClientRect, d, True);
        n := 0;

        with dsurface do begin
          CColor := clWhite;
          for I := 0 to Length(g_HeroLevelRankings) - 1 do begin
            if I = RankingSelectLine - 1 then CColor := clyellow else CColor := clWhite;
            if g_HeroLevelRankings[I].sChrName <> '' then begin
              TextOut(SurfaceX(Left + 34), SurfaceY(Top + 118 + n), IntToStr(g_HeroLevelRankings[I].nIndex), CColor);
              TextOut(SurfaceX(Left + 69), SurfaceY(Top + 118 + n), g_HeroLevelRankings[I].sHeroName, CColor);
              TextOut(SurfaceX(Left + 165), SurfaceY(Top + 118 + n), g_HeroLevelRankings[I].sChrName, CColor);
              TextOut(SurfaceX(Left + 274), SurfaceY(Top + 118 + n), IntToStr(g_HeroLevelRankings[I].nLevel), CColor);
              Inc(n, LISTLINEHEIGHT + 9);
            end;
          end;
        end;
      end;
    end else
      if DBotMasterRanking.Downed then begin
      d := g_WMain3Images.Images[425];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left + 26), SurfaceY(Top + 91), d.ClientRect, d, True);

      n := 0;
      with dsurface do begin
        CColor := clWhite;
        for I := 0 to Length(g_UserMasterRankings) - 1 do begin
          if I = RankingSelectLine - 1 then CColor := clyellow else CColor := clWhite;
          if g_UserMasterRankings[I].sChrName <> '' then begin
            TextOut(SurfaceX(Left + 52), SurfaceY(Top + 118 + n), IntToStr(g_UserMasterRankings[I].nIndex), CColor);
            TextOut(SurfaceX(Left + 114), SurfaceY(Top + 118 + n), g_UserMasterRankings[I].sChrName, CColor);
            TextOut(SurfaceX(Left + 258), SurfaceY(Top + 118 + n), IntToStr(g_UserMasterRankings[I].nMasterCount), CColor);
            Inc(n, LISTLINEHEIGHT + 9);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DHeroStMag1Click(Sender: TObject; X, Y: Integer);
var
  I, Idx: Integer;
  selkey: Word;
  keych: Char;
  pm: PTClientMagic;
begin
  if HeroStatePage = 3 then begin
    Idx := TDButton(Sender).tag + Heromagtop;
    if (Idx >= 0) and (Idx < g_HeroMagicList.Count) then begin
      pm := PTClientMagic(g_HeroMagicList[Idx]);
      if Ord(pm.Key) = VK_F1 then pm.Key := Chr(0) else pm.Key := Chr(VK_F1);
      frmMain.SendHeroMagicKeyChange(pm.Def.wMagicId);
      //ShowMessage(pm.Key);
    end;
  end;
end;

procedure TFrmDlg.DBotActorRankingDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    d := nil;
    if TDButton(Sender).Downed then begin
      if WLib <> nil then
        d := WLib.Images[FaceIndex + 1];
    end else begin
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
    end;
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
  end;
end;

procedure TFrmDlg.DRankingDlgMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  lx, ly, Idx: Integer;
begin
  lx := DRankingDlg.LocalX(X) - DRankingDlg.Left;
  ly := DRankingDlg.LocalY(Y) - DRankingDlg.Top - DRankingDlg.SurfaceY(97);
  if (lx >= 55) and (lx <= 300) and (ly >= 0) then begin
    Idx := ly div (LISTLINEHEIGHT + 9);
    if Idx <= 10 then begin
      PlaySound(s_glass_button_click);
      RankingSelectLine := Idx;

      if (Button = mbRight) and (RankingSelectLine > 0) then begin
        if DBotCharRanking.Downed then begin
          if RankingPage >= 0 then begin
            SetInputVisible(g_ConfigClient.btMainInterface = 1);
            EdChat.Visible := True;
            EdChat.SetFocus;
            EdChat.Text := '/' + g_UserLevelRankings[RankingSelectLine - 1].sChrName;
          end;
        end else
          if DBotHeroRanking.Downed then begin
          if RankingPage >= 0 then begin
            SetInputVisible(g_ConfigClient.btMainInterface = 1);
            EdChat.Visible := True;
            EdChat.SetFocus;
            EdChat.Text := '/' + g_HeroLevelRankings[RankingSelectLine - 1].sChrName;
          end;
        end else
          if DBotMasterRanking.Downed then begin
          SetInputVisible(g_ConfigClient.btMainInterface = 1);
          EdChat.Visible := True;
          EdChat.SetFocus;
          EdChat.Text := '/' + g_UserMasterRankings[RankingSelectLine - 1].sChrName;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DBotCharRankingClick(Sender: TObject; X, Y: Integer);
begin
  RankingPageChanged(Sender);
end;

procedure TFrmDlg.DBotActorRankingClick(Sender: TObject; X, Y: Integer);
begin
  RankingPage := TDButton(Sender).tag;

  DBotActorRanking.Visible := False;
  DBotWarriorRanking.Visible := False;
  DBotWizzardRanking.Visible := False;
  DBotMonkRanking.Visible := False;

  DBotHeroActorRanking.Visible := False;
  DBotHeroWarriorRanking.Visible := False;
  DBotHeroWizzardRanking.Visible := False;
  DBotHeroMonkRanking.Visible := False;

  SafeFillChar(g_UserLevelRankings, SizeOf(TUserLevelRanking) * 10, #0);
  SafeFillChar(g_HeroLevelRankings, SizeOf(THeroLevelRanking) * 10, #0);
  SafeFillChar(g_UserMasterRankings, SizeOf(TUserMasterRanking) * 10, #0);

  if RankingPage >= 0 then
    frmMain.SendGetRanking(g_nRankingsTablePage, RankingPage, 0);
end;

procedure TFrmDlg.DBotRankingCloseClick(Sender: TObject; X, Y: Integer);
begin
  DRankingDlg.Visible := False;
end;

procedure TFrmDlg.DBotRankingHomeClick(Sender: TObject; X, Y: Integer);
begin
  if (RankingPage >= 0) and (g_nRankingsPage > 0) and (g_nRankingsPageCount > 10) then
    frmMain.SendGetRanking(g_nRankingsTablePage, RankingPage, 0);
end;

procedure TFrmDlg.DBotRankingUpClick(Sender: TObject; X, Y: Integer);
begin
  if (RankingPage >= 0) and (g_nRankingsPage > 0) then
    frmMain.SendGetRanking(g_nRankingsTablePage, RankingPage, _MAX(g_nRankingsPage - 10, 0));
end;

procedure TFrmDlg.DBotRankingDownClick(Sender: TObject; X, Y: Integer);
begin
  if (RankingPage >= 0) and (g_nRankingsPage + 10 < g_nRankingsPageCount - 1) then
    frmMain.SendGetRanking(g_nRankingsTablePage, RankingPage, _MIN(g_nRankingsPage + 10, g_nRankingsPageCount - 1));
end;

procedure TFrmDlg.DBotRankingLastClick(Sender: TObject; X, Y: Integer);
begin
  if (RankingPage >= 0) and (g_nRankingsPageCount > 10) and (g_nRankingsPage < g_nRankingsPageCount - 10) then begin
    if g_nRankingsPageCount mod 10 = 0 then begin
      frmMain.SendGetRanking(g_nRankingsTablePage, RankingPage, _MIN(_MAX(g_nRankingsPageCount - 10, 0), g_nRankingsPageCount - 1));
    end else begin
      frmMain.SendGetRanking(g_nRankingsTablePage, RankingPage, _MIN(_MAX(g_nRankingsPageCount - g_nRankingsPageCount mod 10, 0), g_nRankingsPageCount - 1));
    end;
  end;
end;

procedure TFrmDlg.DBotRankingSelfClick(Sender: TObject; X, Y: Integer);
begin
  if RankingPage >= 0 then begin
    g_nRankingsPage := 0;
    g_nRankingsPageCount := 0;
    FillChar(g_UserLevelRankings, SizeOf(TUserLevelRanking) * 10, #0);
    FillChar(g_HeroLevelRankings, SizeOf(THeroLevelRanking) * 10, #0);
    FillChar(g_UserMasterRankings, SizeOf(TUserMasterRanking) * 10, #0);
    frmMain.SendGetMyRanking(g_nRankingsTablePage, RankingPage);
  end;
end;

procedure TFrmDlg.DRankingClick(Sender: TObject; X, Y: Integer);
begin
  DRankingDlg.Visible := not DRankingDlg.Visible;
end;

procedure TFrmDlg.DScrollScrollDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  d := nil;
  with Sender as TDButton do begin
    if not Downed then begin
      if WLib <> nil then
        d := WLib.Images[FaceIndex]
    end else begin
      if WLib <> nil then
        d := WLib.Images[FaceIndex + 1];
    end;
    if d <> nil then begin
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d);
    end;
  end;
end;

procedure TFrmDlg.DScrollCenterScrollDirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  d := nil;
  with Sender as TDScroll do begin
    if VisibleScroll then begin
      if WLib <> nil then
        d := WLib.Images[FaceIndex];
      if d <> nil then begin
        dsurface.StretchDraw(Bounds(SurfaceX(Left), SurfaceY(Top), Width, Height), d, False);
      end;
    end;
  end;
end;

procedure TFrmDlg.DMemoChatClick(Sender: TObject; X, Y: Integer);
  function ExtractUserName(line: string): string;
  var
    uname: string;
  begin
    GetValidStr3(line, line, ['(', '!', '*', '/', ')']);
    GetValidStr3(line, uname, [' ', '=', ':']);
    if uname <> '' then
      if (uname[1] = '/') or (uname[1] = '(') or (uname[1] = ' ') or (uname[1] = '[') then
        uname := '';
    Result := uname;
  end;
begin
 { Showmessage(IntToStr(DMemoChat.ItemIndex));
  if (DMemoChat.ItemIndex >= 0) and (DMemoChat.ItemIndex < DMemoChat.Count) then begin
    if not EdChat.Visible then begin
      SetInputVisible(g_ConfigClient.btMainInterface <> 0);
      EdChat.Visible := True;
      EdChat.SetFocus;
    end;
    EdChat.Text := '/' + ExtractUserName(DMemoChat.Strings[DMemoChat.ItemIndex]) + ' ';
    EdChat.SelStart := Length(EdChat.Text);
    EdChat.SelLength := 0;
    Showmessage(EdChat.Text);
  end else EdChat.Text := '';  }
end;


procedure TFrmDlg.DItemLabelClick(Sender: TObject; X, Y: Integer);
var
  sItemData: string;
  sName: string;
  sData: string;
  nIndex: Integer;
  ItemLabel: TItemLabel;
begin
  nIndex := TDControl(Sender).Idx;
  if (nIndex = 0) and (GetTickCount - g_dwLatestFindItemTick < 1000) then Exit;

  case nIndex of
    0: begin
        ItemLabel := TItemLabel(Sender);
        if ItemLabel.ClientItem.s.Name = '' then begin
          g_dwLatestFindItemTick := GetTickCount;
          frmMain.SendFindUserItem(Integer(ItemLabel), ItemLabel.TData);
          //ShowMessage('ItemLabel.TData');
        end;
      end;
    1: begin
        sItemData := TDLabel(Sender).TData;
        //sItemData := GetValidStr3(sItemData, sName, ['|']);
        //sItemData := GetValidStr3(sItemData, sData, ['|']);
        //DScreen.AddChatBoardString(Format('sItemData:%s',[sItemData]), clyellow, clRed);
        if Assigned(g_PlugInfo.MediaPlayer.Player) then begin
          g_PlugInfo.MediaPlayer.Player(PChar(Trim(sItemData)), False, True);
        end;
      end; //frmCqFirMediaPlayer.play(SelItemLabel.data, True);
    2: begin

        sItemData := TDLabel(Sender).TData;
        //DScreen.AddChatBoardString(Format('sItemData:%s',[sItemData]), clyellow, clRed);
        //sItemData := GetValidStr3(sItemData, sName, ['|']);
        //DScreen.AddChatBoardString(Format('sName:%s',[sName]), clyellow, clRed);
        //sItemData := GetValidStr3(sItemData, sData, ['|']);
        //DScreen.AddChatBoardString(Format('sData:%s',[sData]), clyellow, clRed);
        if Assigned(g_PlugInfo.OpenHomePage) then begin
          g_PlugInfo.OpenHomePage(PChar(Trim(sItemData)));
        end;
      end;
  end;
end;

procedure TFrmDlg.DItemLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  iname, d1, d2, d3: string;
  useable: Boolean;
  nIndex: Integer;
  d: TDControl;
  ItemLabel: TItemLabel;
begin
  d := TDControl(Sender);
  with d do begin
    case Idx of
      -1: DScreen.ClearHint;
      0: begin
          ItemLabel := TItemLabel(Sender);
          if (Trim(ItemLabel.ClientItem.s.Name) <> '') {and ItemLabel.GetClientItem} then begin
            g_MouseItem := ItemLabel.ClientItem;
            //Move(ClientItem,g_MouseItem,SizeOf(TClientItem));
            if g_MouseItem.s.Name <> '' then begin
              GetMouseItemInfo(g_MySelf, @g_MouseItem, iname, d1, d2, d3, useable);
              //HintList.Insert(0, Caption);
              if HintList.Count > 0 then begin
                DScreen.ShowHint(SurfaceX(Left),
                  SurfaceY(Top),
                  HintList, True);
              end;
              g_MouseItem.s.Name := '';
            end;
          end else begin
            DScreen.ShowHintA(SurfaceX(Left + Width), SurfaceY(Top) + 16, '点击查询 ' + Caption + ' 的信息', clInfoText, True);
          end;
        end;
      1: DScreen.ShowHintA(SurfaceX(Left + Width), SurfaceY(Top) + 16, '点击播放 ' + Caption, clInfoText, True); //clWhite
      2: DScreen.ShowHintA(SurfaceX(Left + Width), SurfaceY(Top) + 16, '点击打开 ' + Caption, clInfoText, True);
    end;
  end;
end;

procedure TFrmDlg.DChatDlgClick(Sender: TObject; X, Y: Integer);
begin
//  Showmessage('TFrmDlg.DChatDlgClick:'+IntToStr(DMemoChat.ItemIndex));
end;

procedure TFrmDlg.DMemoChatMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  function ExtractUserName(line: string): string;
  var
    uname: string;
  begin
    GetValidStr3(line, line, ['(', '!', '*', '/', ')']);
    GetValidStr3(line, uname, [' ', '=', ':']);
    if uname <> '' then
      if (uname[1] = '/') or (uname[1] = '(') or (uname[1] = ' ') or (uname[1] = '[') then
        uname := '';
    Result := uname;
  end;
var
  pt: TPoint;
begin
  if Button = mbLeft then begin
  //Showmessage(IntToStr(DMemoChat.ItemIndex));
    if (DMemoChat.itemindex >= 0) and (DMemoChat.itemindex < DMemoChat.Count) then begin
      if not EdChat.Visible then begin
        SetInputVisible(g_ConfigClient.btMainInterface = 1);
        EdChat.Visible := True;
        EdChat.SetFocus;
      end;
      EdChat.Text := '/' + ExtractUserName(DMemoChat.Strings[DMemoChat.itemindex]) + ' ';
      EdChat.SelStart := Length(EdChat.Text);
      EdChat.SelLength := 0;
    //Self.AddMemoChat(DMemoChat.Strings[DMemoChat.ItemIndex] + ' ItemIndex:' + IntToStr(DMemoChat.ItemIndex), clWhite, clFuchsia);
    //Self.AddMemoChat('ItemIndex:' + IntToStr(DMemoChat.ItemIndex), clWhite, clFuchsia);
    //Showmessage(DMemoChat.Strings[DMemoChat.ItemIndex]);
    end else EdChat.Text := '';
  end else begin
    if g_ConfigClient.btMainInterface = 1 then begin
      GetCursorPos(pt);
      pt := frmMain.ScreenToClient(pt);
      frmMain.DXDrawMouseDown_(Button, Shift, pt.X, pt.Y);
    //DScreen.AddChatBoardString(Format('X:%d, Y:%d, SX:%d, SY:%d',[DMemoChat.SurfaceX(X), DMemoChat.SurfaceY(Y), pt.X, pt.Y]), clyellow, clRed);
    end;
  end;
end;

procedure TFrmDlg.DButtonTab1DirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      d := nil;
      if Downed then begin
        d := WLib.Images[FaceIndex + 1];
      end else begin
        d := WLib.Images[FaceIndex];
      end;
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DButtonTab1Click(Sender: TObject; X, Y: Integer);
begin
  DConfigDlg.ActivePage := TDButton(Sender).tag;
end;

procedure TFrmDlg.DEditSearchItemDirectPaint(Sender: TObject;
  dsurface: TTexture);
begin
  with Sender as TDEdit do
    if Text = '' then
      dsurface.TextOut(SurfaceX(Left), SurfaceY(Top) + (Height - dsurface.TextHeight('0')) div 2, '[输入物品关键字查找]', clGray);
end;

procedure TFrmDlg.DConfigDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
  DOptionClick();
end;

procedure TFrmDlg.DBookPageInRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
begin
  IsRealArea := True;
end;

procedure TFrmDlg.DLabelHeroCallHeroDirectPaint(Sender: TObject;
  dsurface: TTexture);
begin
  with TDLabel(Sender) do
    if Downed then begin
      dsurface.FrameRect(Bounds(SurfaceX(Left), SurfaceY(Top), Width, Height), $005894B8);
      dsurface.FrameRect(Bounds(SurfaceX(Left) + 1, SurfaceY(Top) + 1, Width - 2, Height - 2), $005894B8);
    end;
end;

procedure TFrmDlg.DLabelHeroCallHeroKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  nKey: Integer;
  sKey: string;
begin
  sKey := GetKeyDownStr(Key, Shift, nKey);
  if nKey > 0 then begin

    if (nKey = g_Config.nSerieSkill) then begin
      g_Config.nSerieSkill := 0;
      DLabelSerieSkill.Caption := '';
    end;

    if (nKey = g_Config.nHeroCallHero) then begin
      g_Config.nHeroCallHero := 0;
      DLabelHeroCallHero.Caption := '';
    end;

    if (nKey = g_Config.nHeroSetTarget) then begin
      g_Config.nHeroSetTarget := 0;
      DLabelHeroSetTarget.Caption := '';
    end;

    if (nKey = g_Config.nHeroUnionHit) then begin
      g_Config.nHeroUnionHit := 0;
      DLabelHeroUnionHit.Caption := '';
    end;

    if (nKey = g_Config.nHeroSetAttackState) then begin
      g_Config.nHeroSetAttackState := 0;
      DLabelHeroSetAttackState.Caption := '';
    end;

    if (nKey = g_Config.nHeroSetGuard) then begin
      g_Config.nHeroSetGuard := 0;
      DLabelHeroSetGuard.Caption := '';
    end;

    if (nKey = g_Config.nSwitchAttackMode) then begin
      g_Config.nSwitchAttackMode := 0;
      DLabelSwitchAttackMode.Caption := '';
    end;

    if (nKey = g_Config.nSwitchMiniMap) then begin
      g_Config.nSwitchMiniMap := 0;
      DLabelSwitchMiniMap.Caption := '';
    end;
  end;

  if Sender = DLabelSerieSkill then begin
    g_Config.nSerieSkill := nKey;
    DLabelSerieSkill.Caption := sKey;
  end;
  if Sender = DLabelHeroCallHero then begin
    g_Config.nHeroCallHero := nKey;
    DLabelHeroCallHero.Caption := sKey;
  end;
  if Sender = DLabelHeroSetTarget then begin
    g_Config.nHeroSetTarget := nKey;
    DLabelHeroSetTarget.Caption := sKey;
  end;
  if Sender = DLabelHeroUnionHit then begin
    g_Config.nHeroUnionHit := nKey;
    DLabelHeroUnionHit.Caption := sKey;
  end;
  if Sender = DLabelHeroSetAttackState then begin
    g_Config.nHeroSetAttackState := nKey;
    DLabelHeroSetAttackState.Caption := sKey;
  end;
  if Sender = DLabelHeroSetGuard then begin
    g_Config.nHeroSetGuard := nKey;
    DLabelHeroSetGuard.Caption := sKey;
  end;
  if Sender = DLabelSwitchAttackMode then begin
    g_Config.nSwitchAttackMode := nKey;
    DLabelSwitchAttackMode.Caption := sKey;
  end;
  if Sender = DLabelSwitchMiniMap then begin
    g_Config.nSwitchMiniMap := nKey;
    DLabelSwitchMiniMap.Caption := sKey;
  end;

  SaveUserConfig();
end;

procedure TFrmDlg.DLabelHeroCallHeroMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then begin
    if Sender = DLabelSerieSkill then begin
      g_Config.nSerieSkill := 0;
      DLabelSerieSkill.Caption := '';
    end;
    if Sender = DLabelHeroCallHero then begin
      g_Config.nHeroCallHero := 0;
      DLabelHeroCallHero.Caption := '';
    end;
    if Sender = DLabelHeroSetTarget then begin
      g_Config.nHeroSetTarget := 0;
      DLabelHeroSetTarget.Caption := '';
    end;
    if Sender = DLabelHeroUnionHit then begin
      g_Config.nHeroUnionHit := 0;
      DLabelHeroUnionHit.Caption := '';
    end;
    if Sender = DLabelHeroSetAttackState then begin
      g_Config.nHeroSetAttackState := 0;
      DLabelHeroSetAttackState.Caption := '';
    end;
    if Sender = DLabelHeroSetGuard then begin
      g_Config.nHeroSetGuard := 0;
      DLabelHeroSetGuard.Caption := '';
    end;
    if Sender = DLabelSwitchAttackMode then begin
      g_Config.nSwitchAttackMode := 0;
      DLabelSwitchAttackMode.Caption := '';
    end;
    if Sender = DLabelSwitchMiniMap then begin
      g_Config.nSwitchMiniMap := 0;
      DLabelSwitchMiniMap.Caption := '';
    end;
    SaveUserConfig();
  end;
end;

procedure TFrmDlg.SetConfigDlg();
var
  I, II: Integer;
  //DLabel: TDLabel;
  DCheckBox: TDCheckBox;
  ItemList: TStringList;
  ShowItem: pTShowItem;
  Shift: TShiftState;
  nKey: Integer;
begin
  if g_MySelf = nil then Exit;

  DCheckBoxShowMoveNumberLable.OnClick := nil;
  DCheckBoxOrderItem.OnClick := nil;
  DCheckBoxItemDuraHint.OnClick := nil;
  DCheckBoxPickUpItemAll.OnClick := nil;
  DCheckBoxMusic.OnClick := nil;

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

  DCheckBoxShowMoveNumberLable.Checked := g_Config.boShowMoveLable;
  DCheckBoxMusic.Checked := g_Config.boBGSound;
  DCheckBoxOrderItem.Checked := g_Config.boOrderItem;
  DCheckBoxItemDuraHint.Checked := g_Config.boDuraWarning;
  DCheckBoxCompareItem.Checked := g_Config.boCompareItem;

  DCheckBoxPickUpItemAll.Checked := False;
  DCheckBoxBook.Checked := g_Config.boRenewBookIsAuto;


  DEditBookHP.Text := IntToStr(g_Config.nRenewBookPercent);

  DEditBookTime.Text := IntToStr(g_Config.nRenewBookTime);

  DCheckBoxHumHP1.Checked := g_Config.boRenewHumHPIsAuto1;
  DCheckBoxHumMP1.Checked := g_Config.boRenewHumMPIsAuto1;
  DCheckBoxHumHP2.Checked := g_Config.boRenewHumHPIsAuto2;
  DCheckBoxHumMP2.Checked := g_Config.boRenewHumMPIsAuto2;

  DCheckBoxHeroHP1.Checked := g_Config.boRenewHeroHPIsAuto1;
  DCheckBoxHeroMP1.Checked := g_Config.boRenewHeroMPIsAuto1;
  DCheckBoxHeroHP2.Checked := g_Config.boRenewHeroHPIsAuto2;
  DCheckBoxHeroMP2.Checked := g_Config.boRenewHeroMPIsAuto2;


  DEditHumHPPercent1.Text := IntToStr(g_Config.nRenewHumHPPercent1);
  DEditHumMPPercent1.Text := IntToStr(g_Config.nRenewHumMPPercent1);
  DEditHumHPPercent2.Text := IntToStr(g_Config.nRenewHumHPPercent2);
  DEditHumMPPercent2.Text := IntToStr(g_Config.nRenewHumMPPercent2);

  DEditHeroHPPercent1.Text := IntToStr(g_Config.nRenewHeroHPPercent1);
  DEditHeroMPPercent1.Text := IntToStr(g_Config.nRenewHeroMPPercent1);
  DEditHeroHPPercent2.Text := IntToStr(g_Config.nRenewHeroHPPercent2);
  DEditHeroMPPercent2.Text := IntToStr(g_Config.nRenewHeroMPPercent2);

  DEditHumHPTime1.Text := IntToStr(g_Config.nRenewHumHPTime1);
  DEditHumMPTime1.Text := IntToStr(g_Config.nRenewHumMPTime1);
  DEditHumHPTime2.Text := IntToStr(g_Config.nRenewHumHPTime2);
  DEditHumMPTime2.Text := IntToStr(g_Config.nRenewHumMPTime2);

  DEditHeroHPTime1.Text := IntToStr(g_Config.nRenewHeroHPTime1);
  DEditHeroMPTime1.Text := IntToStr(g_Config.nRenewHeroMPTime1);
  DEditHeroHPTime2.Text := IntToStr(g_Config.nRenewHeroHPTime2);
  DEditHeroMPTime2.Text := IntToStr(g_Config.nRenewHeroMPTime2);


  DComboboxHumHP1.ItemIndex := g_Config.nRenewHumHPIndex1;
  DComboboxHumMP1.ItemIndex := g_Config.nRenewHumMPIndex1;
  DComboboxHumHP2.ItemIndex := g_Config.nRenewHumHPIndex2;
  DComboboxHumMP2.ItemIndex := g_Config.nRenewHumMPIndex2;

  DComboboxHeroHP1.ItemIndex := g_Config.nRenewHeroHPIndex1;
  DComboboxHeroMP1.ItemIndex := g_Config.nRenewHeroMPIndex1;
  DComboboxHeroHP2.ItemIndex := g_Config.nRenewHeroHPIndex2;
  DComboboxHeroMP2.ItemIndex := g_Config.nRenewHeroMPIndex2;



  DCheckBoxLongHit.Checked := g_Config.boSmartLongHit;
  DCheckBoxWideHit.Checked := g_Config.boSmartWideHit;
  DCheckBoxFireHit.Checked := g_Config.boSmartFireHit;
  DCheckBoxSWideHit.Checked := g_Config.boSmartSWordHit;
  DCheckBoxCrsHit.Checked := g_Config.boSmartCrsHit;
  DCheckBoxKtHit.Checked := g_Config.boSmartKaitHit;
  DCheckBoxPok.Checked := g_Config.boSmartPokHit;

  DCheckBoxShield.Checked := g_Config.boSmartShield;
  DCheckBoxWjzq.Checked := g_Config.boSmartWjzq;
  DCheckBoxStruckShield.Checked := g_Config.boStruckShield;
  DCheckBoxAutoHideSelf.Checked := g_Config.boAutoHideMode;


  DCheckBoxSmartWalkLongHit.Checked := g_Config.boSmartWalkLongHit;
  DCheckBoxSmartPosLongHit.Checked := g_Config.boSmartPosLongHit;

  DCheckBoxAutoUseMagic.Checked := g_Config.boAutoUseMagic;
  DEditAutoUseMagicTime.Text := IntToStr(g_Config.nAutoUseMagicTime);


  DCheckBoxSign.Checked := g_Config.boChangeSign;
  DCheckBoxPoison.Checked := g_Config.boChangePoison;
  DComboboxPoison.ItemIndex := g_Config.nPoisonIndex;

  DCheckBoxGuaji.Checked := False;

  DCheckBoxUseKey.Checked := g_Config.boUseHotkey;
  DLabelSerieSkill.Idx := g_Config.nSerieSkill;
  DLabelHeroCallHero.Idx := g_Config.nHeroCallHero;
  DLabelHeroSetTarget.Idx := g_Config.nHeroSetTarget;
  DLabelHeroUnionHit.Idx := g_Config.nHeroUnionHit;
  DLabelHeroSetAttackState.Idx := g_Config.nHeroSetAttackState;
  DLabelHeroSetGuard.Idx := g_Config.nHeroSetGuard;
  DLabelSwitchAttackMode.Idx := g_Config.nSwitchAttackMode;
  DLabelSwitchMiniMap.Idx := g_Config.nSwitchMiniMap;

  DComboboxBookIndex.ItemIndex := g_Config.nRenewBookNowBookIndex;
  DComboboxBookIndex.Text := g_Config.sRenewBookNowBookItem;
  DComboboxAutoUseMagic.ItemIndex := g_Config.nAutoUseMagicIdx;

  nKey := GetInputKey(g_Config.nSerieSkill, Shift);
  DLabelSerieSkill.Caption := GetKeyDownStr(nKey, Shift, nKey);

  nKey := GetInputKey(g_Config.nHeroCallHero, Shift);
  DLabelHeroCallHero.Caption := GetKeyDownStr(nKey, Shift, nKey);

  nKey := GetInputKey(g_Config.nHeroSetTarget, Shift);
  DLabelHeroSetTarget.Caption := GetKeyDownStr(nKey, Shift, nKey);

  nKey := GetInputKey(g_Config.nHeroUnionHit, Shift);
  DLabelHeroUnionHit.Caption := GetKeyDownStr(nKey, Shift, nKey);

  nKey := GetInputKey(g_Config.nHeroSetAttackState, Shift);
  DLabelHeroSetAttackState.Caption := GetKeyDownStr(nKey, Shift, nKey);

  nKey := GetInputKey(g_Config.nHeroSetGuard, Shift);
  DLabelHeroSetGuard.Caption := GetKeyDownStr(nKey, Shift, nKey);

  nKey := GetInputKey(g_Config.nSwitchAttackMode, Shift);
  DLabelSwitchAttackMode.Caption := GetKeyDownStr(nKey, Shift, nKey);

  nKey := GetInputKey(g_Config.nSwitchMiniMap, Shift);
  DLabelSwitchMiniMap.Caption := GetKeyDownStr(nKey, Shift, nKey);

  for I := 0 to DMemoTab2.Count - 1 do begin
    ItemList := DMemoTab2.Items[I];
    //for II := 1 to ItemList.Count - 1 do begin
    DCheckBox := TDCheckBox(ItemList.Objects[1]);
    DCheckBox.Checked := pTShowItem(DCheckBox.data).boHintMsg;

    DCheckBox := TDCheckBox(ItemList.Objects[2]);
    DCheckBox.Checked := pTShowItem(DCheckBox.data).boPickup;

    DCheckBox := TDCheckBox(ItemList.Objects[3]);
    DCheckBox.Checked := pTShowItem(DCheckBox.data).boShowName;
    //end;
  end;

  DCheckBoxShowMoveNumberLable.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxOrderItem.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxItemDuraHint.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxPickUpItemAll.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxMusic.OnClick := DCheckBoxShowActorLableClick;

  DCheckBoxBook.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxLongHit.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxWideHit.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxFireHit.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxSWideHit.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxCrsHit.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxKtHit.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxPok.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxShield.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxWjzq.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxSmartWalkLongHit.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxSmartPosLongHit.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxStruckShield.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxAutoHideSelf.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxAutoUseMagic.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxUseKey.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxSign.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxPoison.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxGuaji.OnClick := DCheckBoxShowActorLableClick;


  DEditBookHP.OnChange := DEditSpecialHPChange;
  DEditBookTime.OnChange := DEditSpecialHPChange;

  DEditAutoUseMagicTime.OnChange := DEditSpecialHPChange;


  DCheckBoxHumHP1.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxHumMP1.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxHumHP2.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxHumMP2.OnClick := DCheckBoxShowActorLableClick;

  DCheckBoxHeroHP1.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxHeroMP1.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxHeroHP2.OnClick := DCheckBoxShowActorLableClick;
  DCheckBoxHeroMP2.OnClick := DCheckBoxShowActorLableClick;


  DEditHumHPPercent1.OnChange := DEditSpecialHPChange;
  DEditHumMPPercent1.OnChange := DEditSpecialHPChange;
  DEditHumHPPercent2.OnChange := DEditSpecialHPChange;
  DEditHumMPPercent2.OnChange := DEditSpecialHPChange;

  DEditHeroHPPercent1.OnChange := DEditSpecialHPChange;
  DEditHeroMPPercent1.OnChange := DEditSpecialHPChange;
  DEditHeroHPPercent2.OnChange := DEditSpecialHPChange;
  DEditHeroMPPercent2.OnChange := DEditSpecialHPChange;

  DEditHumHPTime1.OnChange := DEditSpecialHPChange;
  DEditHumMPTime1.OnChange := DEditSpecialHPChange;
  DEditHumHPTime2.OnChange := DEditSpecialHPChange;
  DEditHumMPTime2.OnChange := DEditSpecialHPChange;

  DEditHeroHPTime1.OnChange := DEditSpecialHPChange;
  DEditHeroMPTime1.OnChange := DEditSpecialHPChange;
  DEditHeroHPTime2.OnChange := DEditSpecialHPChange;
  DEditHeroMPTime2.OnChange := DEditSpecialHPChange;


  DComboboxHumHP1.OnChange := DComboboxHumHP1Change;
  DComboboxHumMP1.OnChange := DComboboxHumMP1Change;
  DComboboxHumHP2.OnChange := DComboboxHumHP2Change;
  DComboboxHumMP2.OnChange := DComboboxHumMP2Change;

  DComboboxHeroHP1.OnChange := DComboboxHeroHP1Change;
  DComboboxHeroMP1.OnChange := DComboboxHeroMP1Change;
  DComboboxHeroHP2.OnChange := DComboboxHeroHP2Change;
  DComboboxHeroMP2.OnChange := DComboboxHeroMP2Change;

  //Disable Bot
  DButtonTab2.Enabled := False;
  DButtonTab5.Enabled := False;
  DButtonTab7.Enabled := False;
  DCheckBoxGuaji.Enabled := False;
end;

procedure TFrmDlg.DMemoChatMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  pt: TPoint;
begin
  if ssRight in Shift then begin
    GetCursorPos(pt);
    pt := frmMain.ScreenToClient(pt);
    frmMain.DXDrawMouseMove_(mbRight, Shift, pt.X, pt.Y);
  end else
    if (ssLeft in Shift) and (g_ConfigClient.btMainInterface = 1) then begin
    {DEdChat.Left:=DEdChat.SurfaceX(X);
    CharMove();}
  end;
end;

procedure TFrmDlg.DMemoChatDirectPaint(Sender: TObject;
  dsurface: TTexture);
begin
  if g_ConfigClient.btMainInterface = 1 then begin
    with TDControl(Sender) do
      dsurface.FillRectAlpha(Bounds(SurfaceX(Left), SurfaceY(Top), Width, Height), $00608490, 150); //$005894B8
  end;
end;

procedure TFrmDlg.DComboboxItemTypeChange(Sender: TObject);
var
  I, II, nTop: Integer;
  DLabel: TDLabel;
  DCheckBox: TDCheckBox;
  ItemList: TStringList;
  ShowItem: pTShowItem;
  ItemType: TItemType;
begin
  if DEditSearchItem.Text <> '' then Exit;
  if DComboboxItemType.ItemIndex <= 0 then begin
    ItemType := i_All;
  end else begin
    ItemType := TItemType(DComboboxItemType.ItemIndex - 1);
  end;
  nTop := 1;
  DScrollTab2.First;
  for I := 0 to DMemoTab2.Count - 1 do begin
    ItemList := DMemoTab2.Items[I];
    ShowItem := TLines(ItemList).data;
    if (ShowItem.ItemType = ItemType) or (ItemType = i_All) then begin
      DLabel := TDLabel(ItemList.Objects[0]);
      DLabel.Top := nTop;
      DLabel.Visible := True;

      DCheckBox := TDCheckBox(ItemList.Objects[1]);
      DCheckBox.Top := nTop;
      DCheckBox.Checked := pTShowItem(DCheckBox.data).boHintMsg;
      DCheckBox.Visible := True;

      DCheckBox := TDCheckBox(ItemList.Objects[2]);
      DCheckBox.Top := nTop;
      DCheckBox.Checked := pTShowItem(DCheckBox.data).boPickup;
      DCheckBox.Visible := True;

      DCheckBox := TDCheckBox(ItemList.Objects[3]);
      DCheckBox.Top := nTop;
      DCheckBox.Checked := pTShowItem(DCheckBox.data).boShowName;
      DCheckBox.Visible := True;

      TLines(ItemList).GetHeight;
      TLines(ItemList).Visible := True;
      Inc(nTop, 17);
    end else begin
      TLines(ItemList).Visible := False;
      for II := 0 to ItemList.Count - 1 do begin
        TDControl(ItemList.Objects[II]).Visible := False;
      end;
    end;
  end;

  DScrollTab2.Max := DMemoTab2.MaxHeight;
end;

procedure TFrmDlg.DLabelOptionClick(Sender: TObject; X, Y: Integer);
var
  I: Integer;
  DCheckBox: TDCheckBox;
  ItemList: TStringList;
  ShowItem: pTShowItem;
begin
  if mrOk = FrmDlg.DMessageDlg('Are you sure you want to reset settings?', [mbOk, mbCancel]) then begin
    g_ShowItemList.BackUp;
    for I := 0 to DMemoTab2.Count - 1 do begin
      ItemList := DMemoTab2.Items[I];

      DCheckBox := TDCheckBox(ItemList.Objects[1]);
      DCheckBox.Checked := pTShowItem(DCheckBox.data).boHintMsg;

      DCheckBox := TDCheckBox(ItemList.Objects[2]);
      DCheckBox.Checked := pTShowItem(DCheckBox.data).boPickup;

      DCheckBox := TDCheckBox(ItemList.Objects[3]);
      DCheckBox.Checked := pTShowItem(DCheckBox.data).boShowName;
    end;
    g_ShowItemList.SaveToFile;
  end;
end;

procedure TFrmDlg.DDCheckBoxHintClick(Sender: TObject; X, Y: Integer);
var
  DCheckBox: TDCheckBox;
  ShowItem: pTShowItem;
begin
  DCheckBox := TDCheckBox(Sender);
  ShowItem := DCheckBox.data;
  ShowItem.boHintMsg := DCheckBox.Checked;
  g_ShowItemList.SaveToFile;
end;

procedure TFrmDlg.DDCheckBoxPickupClick(Sender: TObject; X, Y: Integer);
var
  DCheckBox: TDCheckBox;
  ShowItem: pTShowItem;
begin
  DCheckBox := TDCheckBox(Sender);
  ShowItem := DCheckBox.data;
  ShowItem.boPickup := DCheckBox.Checked;
  g_ShowItemList.SaveToFile;
end;

procedure TFrmDlg.DDCheckBoxShowNameClick(Sender: TObject; X, Y: Integer);
var
  DCheckBox: TDCheckBox;
  ShowItem: pTShowItem;
begin
  DCheckBox := TDCheckBox(Sender);
  ShowItem := DCheckBox.data;
  ShowItem.boShowName := DCheckBox.Checked;
  g_ShowItemList.SaveToFile;
end;

procedure TFrmDlg.DCheckBoxShowActorLableClick(Sender: TObject; X,
  Y: Integer);
begin
  if (g_MySelf = nil) or (not g_boLoadUserConfig) then Exit;
  if Sender = DCheckBoxShowMoveNumberLable then
    g_Config.boShowMoveLable := DCheckBoxShowMoveNumberLable.Checked;
  if Sender = DCheckBoxOrderItem then
    g_Config.boOrderItem := DCheckBoxOrderItem.Checked;
  if Sender = DCheckBoxItemDuraHint then
    g_Config.boDuraWarning := DCheckBoxItemDuraHint.Checked;
  if Sender = DCheckBoxCompareItem then
    g_Config.boCompareItem := DCheckBoxCompareItem.Checked;

  if Sender = DCheckBoxBook then
    g_Config.boRenewBookIsAuto := DCheckBoxBook.Checked;


  if Sender = DCheckBoxLongHit then
    g_Config.boSmartLongHit := DCheckBoxLongHit.Checked;
  if Sender = DCheckBoxWideHit then
    g_Config.boSmartWideHit := DCheckBoxWideHit.Checked;
  if Sender = DCheckBoxFireHit then
    g_Config.boSmartFireHit := DCheckBoxFireHit.Checked;
  if Sender = DCheckBoxSWideHit then
    g_Config.boSmartSWordHit := DCheckBoxSWideHit.Checked;
  if Sender = DCheckBoxCrsHit then
    g_Config.boSmartCrsHit := DCheckBoxCrsHit.Checked;
  if Sender = DCheckBoxKtHit then
    g_Config.boSmartKaitHit := DCheckBoxKtHit.Checked;
  if Sender = DCheckBoxPok then
    g_Config.boSmartPokHit := DCheckBoxPok.Checked;
  if Sender = DCheckBoxShield then
    g_Config.boSmartShield := DCheckBoxShield.Checked;
  if Sender = DCheckBoxWjzq then
    g_Config.boSmartWjzq := DCheckBoxWjzq.Checked;
  if Sender = DCheckBoxSmartWalkLongHit then
    g_Config.boSmartWalkLongHit := DCheckBoxSmartWalkLongHit.Checked;
  if Sender = DCheckBoxSmartPosLongHit then
    g_Config.boSmartPosLongHit := DCheckBoxSmartPosLongHit.Checked;

  if Sender = DCheckBoxStruckShield then
    g_Config.boStruckShield := DCheckBoxStruckShield.Checked;
  if Sender = DCheckBoxAutoHideSelf then
    g_Config.boAutoHideMode := DCheckBoxAutoHideSelf.Checked;
  if Sender = DCheckBoxAutoUseMagic then
    g_Config.boAutoUseMagic := DCheckBoxAutoUseMagic.Checked;

  if Sender = DCheckBoxUseKey then
    g_Config.boUseHotkey := DCheckBoxUseKey.Checked;

  if Sender = DCheckBoxSign then
    g_Config.boChangeSign := DCheckBoxSign.Checked;
  if Sender = DCheckBoxPoison then
    g_Config.boChangePoison := DCheckBoxPoison.Checked;

  if Sender = DCheckBoxHumHP1 then
    g_Config.boRenewHumHPIsAuto1 := DCheckBoxHumHP1.Checked;
  if Sender = DCheckBoxHumMP1 then
    g_Config.boRenewHumMPIsAuto1 := DCheckBoxHumMP1.Checked;
  if Sender = DCheckBoxHumHP2 then
    g_Config.boRenewHumHPIsAuto2 := DCheckBoxHumHP2.Checked;
  if Sender = DCheckBoxHumMP2 then
    g_Config.boRenewHumMPIsAuto2 := DCheckBoxHumMP2.Checked;
  if Sender = DCheckBoxHeroHP1 then
    g_Config.boRenewHeroHPIsAuto1 := DCheckBoxHeroHP1.Checked;
  if Sender = DCheckBoxHeroMP1 then
    g_Config.boRenewHeroMPIsAuto1 := DCheckBoxHeroMP1.Checked;
  if Sender = DCheckBoxHeroHP2 then
    g_Config.boRenewHeroHPIsAuto2 := DCheckBoxHeroHP2.Checked;
  if Sender = DCheckBoxHeroMP2 then
    g_Config.boRenewHeroMPIsAuto2 := DCheckBoxHeroMP2.Checked;

  SaveUserConfig();
end;

procedure TFrmDlg.DEditSpecialHPChange(Sender: TObject);
begin
  if (g_MySelf = nil) or (not g_boLoadUserConfig) then Exit;

  if Sender = DEditBookHP then
    g_Config.nRenewBookPercent := Str_ToInt(Trim(DEditBookHP.Text), 0);


  if Sender = DEditBookTime then
    g_Config.nRenewBookTime := Str_ToInt(Trim(DEditBookTime.Text), 0);

  if Sender = DEditAutoUseMagicTime then
    g_Config.nAutoUseMagicTime := _MAX(Str_ToInt(Trim(DEditAutoUseMagicTime.Text), 1), 1);

  if Sender = DEditHumHPPercent1 then
    g_Config.nRenewHumHPPercent1 := Str_ToInt(DEditHumHPPercent1.Text, 1);
  if Sender = DEditHumMPPercent1 then
    g_Config.nRenewHumMPPercent1 := Str_ToInt(DEditHumMPPercent1.Text, 1);
  if Sender = DEditHumHPPercent2 then
    g_Config.nRenewHumHPPercent2 := Str_ToInt(DEditHumHPPercent2.Text, 1);
  if Sender = DEditHumMPPercent2 then
    g_Config.nRenewHumMPPercent2 := Str_ToInt(DEditHumMPPercent2.Text, 1);

  if Sender = DEditHeroHPPercent1 then
    g_Config.nRenewHeroHPPercent1 := Str_ToInt(DEditHeroHPPercent1.Text, 1);
  if Sender = DEditHeroMPPercent1 then
    g_Config.nRenewHeroMPPercent1 := Str_ToInt(DEditHeroMPPercent1.Text, 1);
  if Sender = DEditHeroHPPercent2 then
    g_Config.nRenewHeroHPPercent2 := Str_ToInt(DEditHeroHPPercent2.Text, 1);
  if Sender = DEditHeroMPPercent2 then
    g_Config.nRenewHeroMPPercent2 := Str_ToInt(DEditHeroMPPercent2.Text, 1);
  if Sender = DEditHumHPTime1 then
    g_Config.nRenewHumHPTime1 := _MAX(Str_ToInt(DEditHumHPTime1.Text, 1), 100);
  if Sender = DEditHumMPTime1 then
    g_Config.nRenewHumMPTime1 := _MAX(Str_ToInt(DEditHumMPTime1.Text, 1), 100);
  if Sender = DEditHumHPTime2 then
    g_Config.nRenewHumHPTime2 := _MAX(Str_ToInt(DEditHumHPTime2.Text, 1), 100);
  if Sender = DEditHumMPTime2 then
    g_Config.nRenewHumMPTime2 := _MAX(Str_ToInt(DEditHumMPTime2.Text, 1), 100);
  if Sender = DEditHeroHPTime1 then
    g_Config.nRenewHeroHPTime1 := _MAX(Str_ToInt(DEditHeroHPTime1.Text, 1), 100);
  if Sender = DEditHeroMPTime1 then
    g_Config.nRenewHeroMPTime1 := _MAX(Str_ToInt(DEditHeroMPTime1.Text, 1), 100);
  if Sender = DEditHeroHPTime2 then
    g_Config.nRenewHeroHPTime2 := _MAX(Str_ToInt(DEditHeroHPTime2.Text, 1), 100);
  if Sender = DEditHeroMPTime2 then
    g_Config.nRenewHeroMPTime2 := _MAX(Str_ToInt(DEditHeroMPTime2.Text, 1), 100);

  SaveUserConfig();
end;

procedure TFrmDlg.DComboboxBookIndexChange(Sender: TObject);
begin
  if (g_MySelf = nil) or (not g_boLoadUserConfig) then Exit;
  g_Config.nRenewBookNowBookIndex := DComboboxBookIndex.ItemIndex;
  if (DComboboxBookIndex.ItemIndex >= 0) and (DComboboxBookIndex.ItemIndex < DComboboxBookIndex.Items.Count) then
    g_Config.sRenewBookNowBookItem := DComboboxBookIndex.Items.Strings[DComboboxBookIndex.ItemIndex];
  {else
    g_Config.sRenewBookNowBookItem := '';  }
  SaveUserConfig();
end;

procedure TFrmDlg.DComboboxAutoUseMagicChange(Sender: TObject);
begin
  if (g_MySelf = nil) or (not g_boLoadUserConfig) then Exit;
  g_Config.nAutoUseMagicIdx := DComboboxAutoUseMagic.ItemIndex;
  SaveUserConfig();
end;

procedure TFrmDlg.DComboboxPoisonChange(Sender: TObject);
begin
  if (g_MySelf = nil) or (not g_boLoadUserConfig) then Exit;
  g_Config.nPoisonIndex := DComboboxPoison.ItemIndex;
  SaveUserConfig();
end;

procedure TFrmDlg.DConfigDlgMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  DScreen.ClearHint;
end;

procedure TFrmDlg.DEdChatMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChatDlgLeft := X;
end;

procedure TFrmDlg.DConfigDlgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_HOME, {VK_MULTIPLY,} VK_F12: begin
        DOptionClick();
        Key := 0;
      end;
  end;
end;

procedure TFrmDlg.DCheckBoxMusicClick(Sender: TObject; X, Y: Integer);
begin
  if (g_MySelf = nil) or (not g_boLoadUserConfig) then Exit;
  g_Config.boBGSound := DCheckBoxMusic.Checked;
  g_boBGSound := g_Config.boBGSound;
  PlayMapMusic(g_boBGSound);
  SaveUserConfig();
end;

procedure TFrmDlg.DscStartInRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
begin
  IsRealArea := True;
end;

procedure TFrmDlg.DEditSearchItemChange(Sender: TObject);
var
  sText: string;

  I, II, nTop: Integer;
  DLabel: TDLabel;
  DCheckBox: TDCheckBox;
  ItemList: TStringList;
begin
  if (g_MySelf = nil) or (not g_boLoadUserConfig) then Exit;
  if DEditSearchItem.Text = '' then begin
    DComboboxItemTypeChange(Sender);
  end else begin
    sText := DEditSearchItem.Text;

    nTop := 1;
    DScrollTab2.First;
    for I := 0 to DMemoTab2.Count - 1 do begin
      ItemList := DMemoTab2.Items[I];
      if AnsiContainsText(sText, TLines(ItemList).Text) or AnsiContainsText(TLines(ItemList).Text, sText) then begin
        DLabel := TDLabel(ItemList.Objects[0]);
        DLabel.Top := nTop;
        DLabel.Visible := True;

        DCheckBox := TDCheckBox(ItemList.Objects[1]);
        DCheckBox.Top := nTop;
        //DCheckBox.Checked := pTShowItem(DCheckBox.Data).boHintMsg;
        DCheckBox.Visible := True;

        DCheckBox := TDCheckBox(ItemList.Objects[2]);
        DCheckBox.Top := nTop;
        //DCheckBox.Checked := pTShowItem(DCheckBox.Data).boPickup;
        DCheckBox.Visible := True;

        DCheckBox := TDCheckBox(ItemList.Objects[3]);
        DCheckBox.Top := nTop;
        //DCheckBox.Checked := pTShowItem(DCheckBox.Data).boShowName;
        DCheckBox.Visible := True;

        TLines(ItemList).GetHeight;
        TLines(ItemList).Visible := True;
        Inc(nTop, 17);
      end else begin
        TLines(ItemList).Visible := False;
        for II := 0 to ItemList.Count - 1 do begin
          TDControl(ItemList.Objects[II]).Visible := False;
        end;
      end;
    end;

    DScrollTab2.Max := DMemoTab2.MaxHeight;
  end;
end;

procedure TFrmDlg.DChatDlgDirectPaint(Sender: TObject; dsurface: TTexture);
begin
  if g_ConfigClient.btMainInterface = 1 then begin
    with TDControl(Sender) do begin
      dsurface.FillRect(Bounds(SurfaceX(Left), SurfaceY(Top), 2, Height), 11064552); //$00486FA8
      dsurface.FillRect(Bounds(SurfaceX(Left), SurfaceY(Top), Width - 16, 2), 11064552); //$00486FA8
    end;
  end;
end;

procedure TFrmDlg.EdSearchDirectPaint(Sender: TObject; dsurface: TTexture);
begin
  if EdSearch.Text = '' then
    with EdSearch do
      dsurface.TextOut(SurfaceX(Left) + 2, SurfaceY(Top) + 2, '[输入物品名称]', $005894B8);
end;


procedure TFrmDlg.DMerchantBigDlgCloseClick(Sender: TObject; X,
  Y: Integer);
begin
  CloseBigMDlg;
end;

procedure TFrmDlg.DSerieMagic1DirectPaint(Sender: TObject;
  dsurface: TTexture);
var
  d: TTexture;
  nFaceIndex: Integer;
begin
  with Sender as TDButton do begin
    d := g_WCqFirImages.Images[43];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d);
    if g_SerieMagic[Tag].nMagicID >= 0 then begin
      if g_SerieMagic[Tag].nMagicID = 0 then begin
        nFaceIndex := 909;
      end else begin
        case g_SerieMagic[Tag].nMagicID of
          100: nFaceIndex := 952;
          101: nFaceIndex := 950;
          102: nFaceIndex := 956;
          103: nFaceIndex := 954;
          104: nFaceIndex := 944;
          105: nFaceIndex := 942;
          106: nFaceIndex := 946;
          107: nFaceIndex := 940;
          108: nFaceIndex := 934;
          109: nFaceIndex := 936;
          110: nFaceIndex := 932;
          111: nFaceIndex := 930;
        end;
      end;
      //nFaceIndex := (Tag + 930) + Tag * 2;
      if Downed then begin
        d := g_WMainImages.Images[nFaceIndex + 1];
      end else begin
        d := g_WMainImages.Images[nFaceIndex];
      end;
      if d <> nil then
        dsurface.Draw(SurfaceX(Left) + 3, SurfaceY(Top) + 2, d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DSerieMagic1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  D: TDButton;
begin
  if not (g_boSerieMagic or g_boSerieMagicing) then begin
    D := TDButton(Sender);
    if D.SurfaceX(D.Left) + DSerieMagicMenu.Width > SCREENWIDTH then
      DSerieMagicMenu.Left := D.SurfaceX(D.Left) - DSerieMagicMenu.Width
    else DSerieMagicMenu.Left := D.SurfaceX(D.Left);
    if D.SurfaceY(D.Top) + DSerieMagicMenu.Height > SCREENHEIGHT then
      DSerieMagicMenu.Top := D.SurfaceY(D.Top) - DSerieMagicMenu.Height
    else DSerieMagicMenu.Top := D.SurfaceY(D.Top) + D.Height;
    DSerieMagicMenu.Show(D);
    DScreen.ClearHint;
    HintList.Clear;
  end;
end;

procedure TFrmDlg.DSerieMagicMenuClick(Sender: TObject; X, Y: Integer);
var
  sMagicName: string;
  pcm: PTClientMagic;
begin
  if not (g_boSerieMagic or g_boSerieMagicing) then begin
    if DSerieMagicMenu.DControl <> nil then begin
      if DSerieMagicMenu.DControl is TDButton then begin
        with DSerieMagicMenu.DControl as TDButton do begin
          if (DSerieMagicMenu.ItemIndex = 0) then begin
            g_SerieMagic[Tag].Magic.Def.sMagicName := '';
            g_SerieMagic[Tag].Magic.Def.wMagicId := 0;
            g_SerieMagic[Tag].nMagicID := -1;
          end else
            if (DSerieMagicMenu.ItemIndex = 1) then begin
            g_SerieMagic[Tag].nMagicID := 0;
            g_SerieMagic[Tag].Magic.Def.sMagicName := '';
            g_SerieMagic[Tag].Magic.Def.wMagicId := 0;
          end else
            if (DSerieMagicMenu.ItemIndex - 3 >= 0) and (DSerieMagicMenu.ItemIndex - 3 < g_SerieMagicList.Count) then begin
            pcm := g_SerieMagicList.Items[DSerieMagicMenu.ItemIndex - 3];
            if pcm <> nil then begin
              g_SerieMagic[Tag].Magic := pcm^;
              g_SerieMagic[Tag].nMagicID := pcm.Def.wMagicId;
            end else begin
              g_SerieMagic[Tag].Magic.Def.sMagicName := '';
              g_SerieMagic[Tag].Magic.Def.wMagicId := 0;
            end;
          end;
        end;
      end;
    end;
  end;
  SaveUserConfig();
end;

procedure TFrmDlg.DSerieMagic1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  sStr: string;
begin
  DScreen.ClearHint;
  HintList.Clear;
  if not DSerieMagicMenu.Visible then begin
    with Sender as TDButton do begin
      if g_SerieMagic[Tag].Magic.Def.sMagicName <> '' then begin
        sStr := g_SerieMagic[Tag].Magic.Def.sMagicName + '\';
        sStr := sStr + '等级:' + IntToStr(g_SerieMagic[Tag].Magic.Level) + '\';
        sStr := sStr + '经验:' + IntToStr(g_SerieMagic[Tag].Magic.CurTrain) + '/' + IntToStr(g_SerieMagic[Tag].Magic.Def.MaxTrain[g_SerieMagic[Tag].Magic.Level]);
        DScreen.ShowHint(SurfaceX(Left), SurfaceY(Top + Height), sStr, clWhite, False);
        {HintList.AddObject(g_SerieMagic[Tag].Magic.Def.sMagicName, TObject(0)); //TObject(clWhite)
        HintList.AddObject('等级:' + IntToStr(g_SerieMagic[Tag].Magic.Level), TObject(clWhite)); //TObject(clWhite)
        HintList.AddObject('经验:' + IntToStr(g_SerieMagic[Tag].Magic.CurTrain) + '/' + IntToStr(g_SerieMagic[Tag].Magic.Def.MaxTrain[g_SerieMagic[Tag].Magic.Level]), TObject(clWhite)); //TObject(clWhite)
        DScreen.ShowHintA(SurfaceX(Left),
          SurfaceY(Top + Height),
          HintList, False);
          }
      end;
    end;
  end;
end;

procedure TFrmDlg.DEditSerieMagicClick(Sender: TObject; X, Y: Integer);
begin
  DScrollTab5.Position := DScrollTab5.Max;
end;

procedure TFrmDlg.DComboboxBookIndexPopup(Sender: TObject);
var
  I: Integer;
begin
  DComboboxBookIndex.Items.Clear;
  for I := Low(g_ItemArr) to High(g_ItemArr) do begin
    if g_ItemArr[I].s.Name <> '' then
      DComboboxBookIndex.Items.Add(g_ItemArr[I].s.Name);
  end;
  if g_Config.sRenewBookNowBookItem <> '' then begin
    if (g_Config.nRenewBookNowBookIndex >= 0) and (g_Config.nRenewBookNowBookIndex < DComboboxBookIndex.Items.Count) then begin
      if g_Config.sRenewBookNowBookItem = DComboboxBookIndex.Items.Strings[g_Config.nRenewBookNowBookIndex] then Exit;
    end;
    g_Config.nRenewBookNowBookIndex := -1;
    DComboboxBookIndex.ItemIndex := -1;
    for I := 0 to DComboboxBookIndex.Items.Count - 1 do begin
      if g_Config.sRenewBookNowBookItem = DComboboxBookIndex.Items.Strings[I] then begin
        g_Config.nRenewBookNowBookIndex := I;
        DComboboxBookIndex.ItemIndex := I;
        Break;
      end;
    end;
    SaveUserConfig();
  end;
  DComboboxBookIndex.Text := g_Config.sRenewBookNowBookItem;
end;

procedure TFrmDlg.DEditRandomCodeKeyPress(Sender: TObject; var Key: Char);
var
  sRandomCode: string;
begin
  if Key = #13 then begin
    sRandomCode := Trim(DEditRandomCode.Text);
    if sRandomCode <> '' then begin
      frmMain.SendRandomCode(sRandomCode);
      CloseRandomDlg;
    end;
    Key := #0;
  end;
end;

procedure TFrmDlg.DEditAdjustIncrementChange(Sender: TObject);
begin
  if Str_ToInt(DEditAdjustIncrement.Text, -1) <= 0 then DEditAdjustIncrement.Text := '1';
end;

procedure TFrmDlg.DComboboxHeroHP1Change(Sender: TObject);
begin
  if (not g_boLoadUserConfig) then Exit;
  g_Config.nRenewHeroHPIndex1 := DComboboxHeroHP1.ItemIndex;
  if (DComboboxHeroHP1.ItemIndex >= 0) and (DComboboxHeroHP1.ItemIndex < DComboboxHeroHP1.Items.Count) then
    g_Config.sRenewHeroHPItem1Name := DComboboxHeroHP1.Items.Strings[DComboboxHeroHP1.ItemIndex];
  SaveUserConfig();
end;

procedure TFrmDlg.DComboboxHeroMP1Change(Sender: TObject);
begin
  if (not g_boLoadUserConfig) then Exit;
  g_Config.nRenewHeroMPIndex1 := DComboboxHeroMP1.ItemIndex;
  if (DComboboxHeroMP1.ItemIndex >= 0) and (DComboboxHeroMP1.ItemIndex < DComboboxHeroMP1.Items.Count) then
    g_Config.sRenewHeroMPItem1Name := DComboboxHeroMP1.Items.Strings[DComboboxHeroMP1.ItemIndex];
  SaveUserConfig();
end;

procedure TFrmDlg.DComboboxHeroHP2Change(Sender: TObject);
begin
  if (not g_boLoadUserConfig) then Exit;
  g_Config.nRenewHeroHPIndex2 := DComboboxHeroHP2.ItemIndex;
  if (DComboboxHeroHP2.ItemIndex >= 0) and (DComboboxHeroHP2.ItemIndex < DComboboxHeroHP2.Items.Count) then
    g_Config.sRenewHeroHPItem2Name := DComboboxHeroHP2.Items.Strings[DComboboxHeroHP2.ItemIndex];
  SaveUserConfig();
end;

procedure TFrmDlg.DComboboxHeroMP2Change(Sender: TObject);
begin
  if (not g_boLoadUserConfig) then Exit;
  g_Config.nRenewHeroMPIndex2 := DComboboxHeroMP2.ItemIndex;
  if (DComboboxHeroMP2.ItemIndex >= 0) and (DComboboxHeroMP2.ItemIndex < DComboboxHeroMP2.Items.Count) then
    g_Config.sRenewHeroMPItem2Name := DComboboxHeroMP2.Items.Strings[DComboboxHeroMP2.ItemIndex];
  SaveUserConfig();
end;

procedure TFrmDlg.DComboboxHumHP1Change(Sender: TObject);
begin
  if (not g_boLoadUserConfig) then Exit;
  g_Config.nRenewHumHPIndex1 := DComboboxHumHP1.ItemIndex;
  if (DComboboxHumHP1.ItemIndex >= 0) and (DComboboxHumHP1.ItemIndex < DComboboxHumHP1.Items.Count) then
    g_Config.sRenewHumHPItem1Name := DComboboxHumHP1.Items.Strings[DComboboxHumHP1.ItemIndex];
  SaveUserConfig();
end;

procedure TFrmDlg.DComboboxHumMP1Change(Sender: TObject);
begin
  if (not g_boLoadUserConfig) then Exit;
  g_Config.nRenewHumMPIndex1 := DComboboxHumMP1.ItemIndex;
  if (DComboboxHumMP1.ItemIndex >= 0) and (DComboboxHumMP1.ItemIndex < DComboboxHumMP1.Items.Count) then
    g_Config.sRenewHumMPItem1Name := DComboboxHumMP1.Items.Strings[DComboboxHumMP1.ItemIndex];
  SaveUserConfig();
end;

procedure TFrmDlg.DComboboxHumHP2Change(Sender: TObject);
begin
  if (not g_boLoadUserConfig) then Exit;
  g_Config.nRenewHumHPIndex2 := DComboboxHumHP2.ItemIndex;
  if (DComboboxHumHP2.ItemIndex >= 0) and (DComboboxHumHP2.ItemIndex < DComboboxHumHP2.Items.Count) then
    g_Config.sRenewHumHPItem2Name := DComboboxHumHP2.Items.Strings[DComboboxHumHP2.ItemIndex];
  SaveUserConfig();
end;

procedure TFrmDlg.DComboboxHumMP2Change(Sender: TObject);
begin
  if (not g_boLoadUserConfig) then Exit;
  g_Config.nRenewHumMPIndex2 := DComboboxHumMP2.ItemIndex;
  if (DComboboxHumMP2.ItemIndex >= 0) and (DComboboxHumMP2.ItemIndex < DComboboxHumMP2.Items.Count) then
    g_Config.sRenewHumMPItem2Name := DComboboxHumMP2.Items.Strings[DComboboxHumMP2.ItemIndex];
  SaveUserConfig();
end;

end.

