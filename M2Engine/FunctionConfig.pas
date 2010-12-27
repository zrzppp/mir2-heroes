unit FunctionConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Spin, Grids, Grobal2, ExtCtrls, MyListBox;

type
  TfrmFunctionConfig = class(TForm)
    FunctionConfigControl: TPageControl;
    Label14: TLabel;
    MonSaySheet: TTabSheet;
    TabSheet1: TTabSheet;
    PasswordSheet: TTabSheet;
    GroupBox1: TGroupBox;
    CheckBoxEnablePasswordLock: TCheckBox;
    GroupBox2: TGroupBox;
    CheckBoxLockGetBackItem: TCheckBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    EditErrorPasswordCount: TSpinEdit;
    CheckBoxErrorCountKick: TCheckBox;
    ButtonPasswordLockSave: TButton;
    GroupBox4: TGroupBox;
    CheckBoxLockWalk: TCheckBox;
    CheckBoxLockRun: TCheckBox;
    CheckBoxLockHit: TCheckBox;
    CheckBoxLockSpell: TCheckBox;
    CheckBoxLockSendMsg: TCheckBox;
    CheckBoxLockInObMode: TCheckBox;
    CheckBoxLockLogin: TCheckBox;
    CheckBoxLockUseItem: TCheckBox;
    CheckBoxLockDropItem: TCheckBox;
    CheckBoxLockDealItem: TCheckBox;
    MagicPageControl: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet18: TTabSheet;
    TabSheet20: TTabSheet;
    TabSheet21: TTabSheet;
    TabSheet22: TTabSheet;
    TabSheet28: TTabSheet;
    TabSheet29: TTabSheet;
    GroupBox5: TGroupBox;
    Label2: TLabel;
    EditBoneFammName: TEdit;
    Label3: TLabel;
    EditBoneFammCount: TSpinEdit;
    GroupBox6: TGroupBox;
    GridBoneFamm: TStringGrid;
    TabSheetGeneral: TTabSheet;
    GroupBox7: TGroupBox;
    CheckBoxHungerSystem: TCheckBox;
    ButtonGeneralSave: TButton;
    GroupBoxHunger: TGroupBox;
    CheckBoxHungerDecPower: TCheckBox;
    CheckBoxHungerDecHP: TCheckBox;
    ButtonSkillSave: TButton;
    GroupBox9: TGroupBox;
    CheckBoxLimitSwordLong: TCheckBox;
    GroupBox10: TGroupBox;
    EditSwordLongPowerRate: TSpinEdit;
    Label4: TLabel;
    GroupBox11: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    EditDogzName: TEdit;
    EditDogzCount: TSpinEdit;
    GroupBox12: TGroupBox;
    GroupBox13: TGroupBox;
    Label7: TLabel;
    EditFireBoomRage: TSpinEdit;
    GroupBox14: TGroupBox;
    Label8: TLabel;
    EditSnowWindRange: TSpinEdit;
    GroupBox15: TGroupBox;
    Label9: TLabel;
    EditElecBlizzardRange: TSpinEdit;
    Label10: TLabel;
    TabSheet32: TTabSheet;
    TabSheet33: TTabSheet;
    TabSheet34: TTabSheet;
    TabSheet35: TTabSheet;
    GridDogz: TStringGrid;
    GroupBox16: TGroupBox;
    Label11: TLabel;
    EditAmyOunsulPoint: TSpinEdit;
    TabSheet36: TTabSheet;
    GroupBox17: TGroupBox;
    Label12: TLabel;
    EditMagicAttackRage: TSpinEdit;
    GroupBox8: TGroupBox;
    Label13: TLabel;
    EditUpgradeWeaponMaxPoint: TSpinEdit;
    Label15: TLabel;
    EditUpgradeWeaponPrice: TSpinEdit;
    Label16: TLabel;
    EditUPgradeWeaponGetBackTime: TSpinEdit;
    Label17: TLabel;
    EditClearExpireUpgradeWeaponDays: TSpinEdit;
    Label18: TLabel;
    Label19: TLabel;
    GroupBox18: TGroupBox;
    ScrollBarUpgradeWeaponDCRate: TScrollBar;
    Label20: TLabel;
    EditUpgradeWeaponDCRate: TEdit;
    Label21: TLabel;
    ScrollBarUpgradeWeaponDCTwoPointRate: TScrollBar;
    EditUpgradeWeaponDCTwoPointRate: TEdit;
    Label22: TLabel;
    ScrollBarUpgradeWeaponDCThreePointRate: TScrollBar;
    EditUpgradeWeaponDCThreePointRate: TEdit;
    GroupBox19: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    ScrollBarUpgradeWeaponSCRate: TScrollBar;
    EditUpgradeWeaponSCRate: TEdit;
    ScrollBarUpgradeWeaponSCTwoPointRate: TScrollBar;
    EditUpgradeWeaponSCTwoPointRate: TEdit;
    ScrollBarUpgradeWeaponSCThreePointRate: TScrollBar;
    EditUpgradeWeaponSCThreePointRate: TEdit;
    GroupBox20: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    ScrollBarUpgradeWeaponMCRate: TScrollBar;
    EditUpgradeWeaponMCRate: TEdit;
    ScrollBarUpgradeWeaponMCTwoPointRate: TScrollBar;
    EditUpgradeWeaponMCTwoPointRate: TEdit;
    ScrollBarUpgradeWeaponMCThreePointRate: TScrollBar;
    EditUpgradeWeaponMCThreePointRate: TEdit;
    ButtonUpgradeWeaponSave: TButton;
    GroupBox21: TGroupBox;
    ButtonMasterSave: TButton;
    GroupBox22: TGroupBox;
    EditMasterOKLevel: TSpinEdit;
    Label29: TLabel;
    GroupBox23: TGroupBox;
    EditMasterOKCreditPoint: TSpinEdit;
    Label30: TLabel;
    EditMasterOKBonusPoint: TSpinEdit;
    Label31: TLabel;
    GroupBox24: TGroupBox;
    ScrollBarMakeMineHitRate: TScrollBar;
    EditMakeMineHitRate: TEdit;
    Label32: TLabel;
    Label33: TLabel;
    ScrollBarMakeMineRate: TScrollBar;
    EditMakeMineRate: TEdit;
    GroupBox25: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    ScrollBarStoneTypeRate: TScrollBar;
    EditStoneTypeRate: TEdit;
    ScrollBarGoldStoneMax: TScrollBar;
    EditGoldStoneMax: TEdit;
    Label36: TLabel;
    ScrollBarSilverStoneMax: TScrollBar;
    EditSilverStoneMax: TEdit;
    Label37: TLabel;
    ScrollBarSteelStoneMax: TScrollBar;
    EditSteelStoneMax: TEdit;
    Label38: TLabel;
    EditBlackStoneMax: TEdit;
    ScrollBarBlackStoneMax: TScrollBar;
    ButtonMakeMineSave: TButton;
    GroupBox26: TGroupBox;
    Label39: TLabel;
    EditStoneMinDura: TSpinEdit;
    Label40: TLabel;
    EditStoneGeneralDuraRate: TSpinEdit;
    Label41: TLabel;
    EditStoneAddDuraRate: TSpinEdit;
    Label42: TLabel;
    EditStoneAddDuraMax: TSpinEdit;
    TabSheet37: TTabSheet;
    GroupBox27: TGroupBox;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    ScrollBarWinLottery1Max: TScrollBar;
    EditWinLottery1Max: TEdit;
    ScrollBarWinLottery2Max: TScrollBar;
    EditWinLottery2Max: TEdit;
    ScrollBarWinLottery3Max: TScrollBar;
    EditWinLottery3Max: TEdit;
    ScrollBarWinLottery4Max: TScrollBar;
    EditWinLottery4Max: TEdit;
    EditWinLottery5Max: TEdit;
    ScrollBarWinLottery5Max: TScrollBar;
    Label48: TLabel;
    ScrollBarWinLottery6Max: TScrollBar;
    EditWinLottery6Max: TEdit;
    EditWinLotteryRate: TEdit;
    ScrollBarWinLotteryRate: TScrollBar;
    Label49: TLabel;
    GroupBox28: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    EditWinLottery1Gold: TSpinEdit;
    EditWinLottery2Gold: TSpinEdit;
    EditWinLottery3Gold: TSpinEdit;
    EditWinLottery4Gold: TSpinEdit;
    Label54: TLabel;
    EditWinLottery5Gold: TSpinEdit;
    Label55: TLabel;
    EditWinLottery6Gold: TSpinEdit;
    ButtonWinLotterySave: TButton;
    TabSheet38: TTabSheet;
    GroupBox29: TGroupBox;
    Label56: TLabel;
    EditReNewNameColor1: TSpinEdit;
    LabelReNewNameColor1: TLabel;
    Label58: TLabel;
    EditReNewNameColor2: TSpinEdit;
    LabelReNewNameColor2: TLabel;
    Label60: TLabel;
    EditReNewNameColor3: TSpinEdit;
    LabelReNewNameColor3: TLabel;
    Label62: TLabel;
    EditReNewNameColor4: TSpinEdit;
    LabelReNewNameColor4: TLabel;
    Label64: TLabel;
    EditReNewNameColor5: TSpinEdit;
    LabelReNewNameColor5: TLabel;
    Label66: TLabel;
    EditReNewNameColor6: TSpinEdit;
    LabelReNewNameColor6: TLabel;
    Label68: TLabel;
    EditReNewNameColor7: TSpinEdit;
    LabelReNewNameColor7: TLabel;
    Label70: TLabel;
    EditReNewNameColor8: TSpinEdit;
    LabelReNewNameColor8: TLabel;
    Label72: TLabel;
    EditReNewNameColor9: TSpinEdit;
    LabelReNewNameColor9: TLabel;
    Label74: TLabel;
    EditReNewNameColor10: TSpinEdit;
    LabelReNewNameColor10: TLabel;
    ButtonReNewLevelSave: TButton;
    GroupBox30: TGroupBox;
    Label57: TLabel;
    EditReNewNameColorTime: TSpinEdit;
    Label59: TLabel;
    TabSheet39: TTabSheet;
    ButtonMonUpgradeSave: TButton;
    GroupBox32: TGroupBox;
    Label65: TLabel;
    LabelMonUpgradeColor1: TLabel;
    Label67: TLabel;
    LabelMonUpgradeColor2: TLabel;
    Label69: TLabel;
    LabelMonUpgradeColor3: TLabel;
    Label71: TLabel;
    LabelMonUpgradeColor4: TLabel;
    Label73: TLabel;
    LabelMonUpgradeColor5: TLabel;
    Label75: TLabel;
    LabelMonUpgradeColor6: TLabel;
    Label76: TLabel;
    LabelMonUpgradeColor7: TLabel;
    Label77: TLabel;
    LabelMonUpgradeColor8: TLabel;
    EditMonUpgradeColor1: TSpinEdit;
    EditMonUpgradeColor2: TSpinEdit;
    EditMonUpgradeColor3: TSpinEdit;
    EditMonUpgradeColor4: TSpinEdit;
    EditMonUpgradeColor5: TSpinEdit;
    EditMonUpgradeColor6: TSpinEdit;
    EditMonUpgradeColor7: TSpinEdit;
    EditMonUpgradeColor8: TSpinEdit;
    GroupBox31: TGroupBox;
    Label61: TLabel;
    Label63: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    EditMonUpgradeKillCount1: TSpinEdit;
    EditMonUpgradeKillCount2: TSpinEdit;
    EditMonUpgradeKillCount3: TSpinEdit;
    EditMonUpgradeKillCount4: TSpinEdit;
    EditMonUpgradeKillCount5: TSpinEdit;
    EditMonUpgradeKillCount6: TSpinEdit;
    EditMonUpgradeKillCount7: TSpinEdit;
    EditMonUpLvNeedKillBase: TSpinEdit;
    EditMonUpLvRate: TSpinEdit;
    Label84: TLabel;
    CheckBoxReNewChangeColor: TCheckBox;
    GroupBox33: TGroupBox;
    CheckBoxReNewLevelClearExp: TCheckBox;
    GroupBox34: TGroupBox;
    Label85: TLabel;
    EditPKFlagNameColor: TSpinEdit;
    LabelPKFlagNameColor: TLabel;
    Label87: TLabel;
    EditPKLevel1NameColor: TSpinEdit;
    LabelPKLevel1NameColor: TLabel;
    Label89: TLabel;
    EditPKLevel2NameColor: TSpinEdit;
    LabelPKLevel2NameColor: TLabel;
    Label91: TLabel;
    EditAllyAndGuildNameColor: TSpinEdit;
    LabelAllyAndGuildNameColor: TLabel;
    Label93: TLabel;
    EditWarGuildNameColor: TSpinEdit;
    LabelWarGuildNameColor: TLabel;
    Label95: TLabel;
    EditInFreePKAreaNameColor: TSpinEdit;
    LabelInFreePKAreaNameColor: TLabel;
    TabSheet40: TTabSheet;
    Label86: TLabel;
    EditMonUpgradeColor9: TSpinEdit;
    LabelMonUpgradeColor9: TLabel;
    GroupBox35: TGroupBox;
    CheckBoxMasterDieMutiny: TCheckBox;
    Label88: TLabel;
    EditMasterDieMutinyRate: TSpinEdit;
    Label90: TLabel;
    EditMasterDieMutinyPower: TSpinEdit;
    Label92: TLabel;
    EditMasterDieMutinySpeed: TSpinEdit;
    GroupBox36: TGroupBox;
    Label94: TLabel;
    Label96: TLabel;
    CheckBoxSpiritMutiny: TCheckBox;
    EditSpiritMutinyTime: TSpinEdit;
    EditSpiritPowerRate: TSpinEdit;
    ButtonSpiritMutinySave: TButton;
    GroupBox37: TGroupBox;
    Label97: TLabel;
    EditMagTurnUndeadLevel: TSpinEdit;
    GroupBox38: TGroupBox;
    Label98: TLabel;
    EditMagTammingLevel: TSpinEdit;
    GroupBox39: TGroupBox;
    Label99: TLabel;
    EditMagTammingTargetLevel: TSpinEdit;
    Label100: TLabel;
    EditMagTammingHPRate: TSpinEdit;
    GroupBox40: TGroupBox;
    CheckBoxMonSayMsg: TCheckBox;
    ButtonMonSayMsgSave: TButton;
    ButtonUpgradeWeaponDefaulf: TButton;
    ButtonMakeMineDefault: TButton;
    ButtonWinLotteryDefault: TButton;
    TabSheet41: TTabSheet;
    GroupBox41: TGroupBox;
    Label101: TLabel;
    EditMabMabeHitRandRate: TSpinEdit;
    Label102: TLabel;
    EditMabMabeHitMinLvLimit: TSpinEdit;
    GroupBox42: TGroupBox;
    EditMabMabeHitSucessRate: TSpinEdit;
    Label103: TLabel;
    GroupBox43: TGroupBox;
    Label104: TLabel;
    EditMabMabeHitMabeTimeRate: TSpinEdit;
    TabSheet42: TTabSheet;
    GroupBox44: TGroupBox;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    ScrollBarWeaponMakeUnLuckRate: TScrollBar;
    EditWeaponMakeUnLuckRate: TEdit;
    ScrollBarWeaponMakeLuckPoint1: TScrollBar;
    EditWeaponMakeLuckPoint1: TEdit;
    ScrollBarWeaponMakeLuckPoint2: TScrollBar;
    EditWeaponMakeLuckPoint2: TEdit;
    ScrollBarWeaponMakeLuckPoint2Rate: TScrollBar;
    EditWeaponMakeLuckPoint2Rate: TEdit;
    EditWeaponMakeLuckPoint3: TEdit;
    ScrollBarWeaponMakeLuckPoint3: TScrollBar;
    Label110: TLabel;
    ScrollBarWeaponMakeLuckPoint3Rate: TScrollBar;
    EditWeaponMakeLuckPoint3Rate: TEdit;
    ButtonWeaponMakeLuckDefault: TButton;
    ButtonWeaponMakeLuckSave: TButton;
    GroupBox45: TGroupBox;
    Label111: TLabel;
    EditTammingCount: TSpinEdit;
    GroupBox46: TGroupBox;
    CheckBoxFireCrossInSafeZone: TCheckBox;
    GroupBox47: TGroupBox;
    Label112: TLabel;
    CheckBoxBBMonAutoChangeColor: TCheckBox;
    EditBBMonAutoChangeColorTime: TSpinEdit;
    TabSheet43: TTabSheet;
    GroupBox48: TGroupBox;
    CheckBoxGroupMbAttackPlayObject: TCheckBox;
    TabSheet44: TTabSheet;
    GroupBox49: TGroupBox;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    SpinEditSellOffCount: TSpinEdit;
    SpinEditSellOffTax: TSpinEdit;
    ButtonSellOffSave: TButton;
    TabSheet45: TTabSheet;
    GroupBox50: TGroupBox;
    TabSheet46: TTabSheet;
    TabSheet49: TTabSheet;
    CheckBoxPullPlayObject: TCheckBox;
    GroupBox51: TGroupBox;
    CheckBoxPlayObjectReduceMP: TCheckBox;
    GroupBox54: TGroupBox;
    CheckBoxGroupMbAttackSlave: TCheckBox;
    TabSheet50: TTabSheet;
    GroupBox55: TGroupBox;
    CheckBoxItemName: TCheckBox;
    Label118: TLabel;
    EditItemName: TEdit;
    ButtonChangeUseItemName: TButton;
    TabSheet51: TTabSheet;
    GroupBox58: TGroupBox;
    Label121: TLabel;
    SpinEditAllowCopyCount: TSpinEdit;
    Label122: TLabel;
    EditCopyHumName: TEdit;
    CheckBoxMasterName: TCheckBox;
    Label123: TLabel;
    SpinEditPickUpItemCount: TSpinEdit;
    Label124: TLabel;
    Label125: TLabel;
    SpinEditEatHPItemRate: TSpinEdit;
    Label126: TLabel;
    SpinEditEatMPItemRate: TSpinEdit;
    Label127: TLabel;
    TabSheet52: TTabSheet;
    CheckBoxAllowGuardAttack: TCheckBox;
    TabSheet53: TTabSheet;
    GroupBox57: TGroupBox;
    CheckBoxDedingAllowPK: TCheckBox;
    GroupBox56: TGroupBox;
    Label119: TLabel;
    Label120: TLabel;
    GroupBox60: TGroupBox;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    EditBagItems1: TEdit;
    EditBagItems2: TEdit;
    EditBagItems3: TEdit;
    GroupBox59: TGroupBox;
    GroupBox61: TGroupBox;
    CheckBoxNeedLevelHighTarget: TCheckBox;
    CheckBoxAllowReCallMobOtherHum: TCheckBox;
    CheckBoxPullCrossInSafeZone: TCheckBox;
    GroupBox62: TGroupBox;
    CheckBoxStartMapEvent: TCheckBox;
    GroupBox63: TGroupBox;
    CheckBoxFireChgMapExtinguish: TCheckBox;
    GroupBox53: TGroupBox;
    Label117: TLabel;
    SpinEditFireDelayTime: TSpinEdit;
    Label116: TLabel;
    SpinEditFirePower: TSpinEdit;
    GroupBox52: TGroupBox;
    Label135: TLabel;
    SpinEditDidingPowerRate: TSpinEdit;
    SpinEditSkill39Sec: TSpinEdit;
    TabSheet54: TTabSheet;
    TabSheet55: TTabSheet;
    GroupBox64: TGroupBox;
    Label134: TLabel;
    Label136: TLabel;
    EditSkill43DelayTime: TSpinEdit;
    GroupBox65: TGroupBox;
    Label137: TLabel;
    EditSkill43PowerRate: TSpinEdit;
    GroupBox66: TGroupBox;
    Label138: TLabel;
    Label139: TLabel;
    EditSkill58DelayTime: TSpinEdit;
    GroupBox67: TGroupBox;
    Label140: TLabel;
    EditSkill58PowerRate: TSpinEdit;
    CheckBoxAllowRecallSelf: TCheckBox;
    TabSheet56: TTabSheet;
    GroupBox68: TGroupBox;
    RadioButtonDogz: TRadioButton;
    RadioButtonMoon: TRadioButton;
    CheckBoxRecallAll: TCheckBox;
    TabSheet58: TTabSheet;
    GroupBox74: TGroupBox;
    Label143: TLabel;
    Label144: TLabel;
    EditSkill50DelayTime: TSpinEdit;
    TabSheet59: TTabSheet;
    GroupBox75: TGroupBox;
    CheckBoxBindItemNoDeal: TCheckBox;
    CheckBoxBindItemNoScatter: TCheckBox;
    CheckBoxBindItemNoDrop: TCheckBox;
    ButtonSaveBindItem: TButton;
    TabSheet60: TTabSheet;
    GroupBox76: TGroupBox;
    CheckBoxCopyItemClear: TCheckBox;
    ButtonClearCopyItem: TButton;
    CheckBoxBindItemNoSellOff: TCheckBox;
    GroupBox77: TGroupBox;
    CheckBoxHumUseBagItem: TCheckBox;
    GroupBox78: TGroupBox;
    CheckBoxMonUseBagItem: TCheckBox;
    TabSheet61: TTabSheet;
    GroupBox79: TGroupBox;
    Label145: TLabel;
    EditNewShieldUseRate: TSpinEdit;
    Label146: TLabel;
    EditNewShieldDamageRate: TSpinEdit;
    GroupBox80: TGroupBox;
    Label147: TLabel;
    EditNewShieldWaitTime: TSpinEdit;
    TabSheet2: TTabSheet;
    GroupBox81: TGroupBox;
    Label148: TLabel;
    Label149: TLabel;
    EditSpaceSkillDelayTime: TSpinEdit;
    GroupBox82: TGroupBox;
    CheckBoxNoAllowWarRangeUseSpaceSkill: TCheckBox;
    CheckBoxAllowSpaceOutAttack: TCheckBox;
    TabSheet5: TTabSheet;
    GroupBox83: TGroupBox;
    Label150: TLabel;
    EditGroupFireCharmPowerRate: TSpinEdit;
    GroupBox84: TGroupBox;
    Label151: TLabel;
    Label152: TLabel;
    EditSpaceSkillKeepTime: TSpinEdit;
    TabSheet7: TTabSheet;
    GroupBox85: TGroupBox;
    Label153: TLabel;
    Label154: TLabel;
    EditMagicMovePositionTime: TSpinEdit;
    GroupBox86: TGroupBox;
    Label155: TLabel;
    EditMagicMovePositionRate: TSpinEdit;
    GroupBox87: TGroupBox;
    CheckBoxNoHintMagicFail: TCheckBox;
    CheckBoxNoHintMagicOK: TCheckBox;
    TabSheet8: TTabSheet;
    GroupBox88: TGroupBox;
    Label156: TLabel;
    Label157: TLabel;
    EditSkillZRJFDelayTime: TSpinEdit;
    GroupBox89: TGroupBox;
    Label158: TLabel;
    EditSkill77PowerRate: TSpinEdit;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    GroupBox90: TGroupBox;
    Label159: TLabel;
    EditSkill75PowerRate: TSpinEdit;
    GroupBox91: TGroupBox;
    Label160: TLabel;
    EditSkill76PowerRate: TSpinEdit;
    CheckBoxNoHintMagicClose: TCheckBox;
    TabSheet12: TTabSheet;
    GroupBox92: TGroupBox;
    CheckBoxSafeCanStore: TCheckBox;
    CheckBoxOpenStoreGMMode: TCheckBox;
    ButtonSaveStore: TButton;
    CheckBoxOpenStoreCheckLevel: TCheckBox;
    EditOpenStoreCheckLevel: TSpinEdit;
    Label161: TLabel;
    CheckBoxDeleteUpgradeFailWeapon: TCheckBox;
    GroupBox93: TGroupBox;
    EditUnKnowName: TEdit;
    Label162: TLabel;
    GroupBox94: TGroupBox;
    Label163: TLabel;
    EditMoonLowPowerRate: TSpinEdit;
    GroupBox95: TGroupBox;
    Label164: TLabel;
    EditMoonHighPowerRate: TSpinEdit;
    GroupBox96: TGroupBox;
    Label165: TLabel;
    EditStatusDelayTime1: TSpinEdit;
    Label166: TLabel;
    Label167: TLabel;
    EditStatusDelayTime2: TSpinEdit;
    Label168: TLabel;
    GroupBox69: TGroupBox;
    Label133: TLabel;
    Label132: TLabel;
    Label131: TLabel;
    SpinEditWarrorAttackTime: TSpinEdit;
    SpinEditWizardAttackTime: TSpinEdit;
    SpinEditTaoistAttackTime: TSpinEdit;
    GroupBox70: TGroupBox;
    Label141: TLabel;
    Label142: TLabel;
    Label169: TLabel;
    EditWarrorWalkTime: TSpinEdit;
    EditWizardWalkTime: TSpinEdit;
    EditTaoistWalkTime: TSpinEdit;
    GroupBox97: TGroupBox;
    CheckBoxChangeMapReleasePoison: TCheckBox;
    CheckBoxBindItemNoPickUp: TCheckBox;
    GroupBox98: TGroupBox;
    CheckBoxGetRandomHomePoint: TCheckBox;
    TabSheet13: TTabSheet;
    ListBoxSerieMagic: TListBox;
    GroupBox71: TGroupBox;
    Label170: TLabel;
    EditSerieMagicTime: TSpinEdit;
    Label171: TLabel;
    GroupBoxSerie: TGroupBox;
    GroupBoxSerieMagicAttackRange: TGroupBox;
    Label172: TLabel;
    EditSerieMagicAttackRange: TSpinEdit;
    GroupBoxSerieMagicPowerRate: TGroupBox;
    Label173: TLabel;
    EditSerieMagicPowerRate: TSpinEdit;
    GroupBoxSerieMagicBlasthitRate: TGroupBox;
    Label174: TLabel;
    EditSerieMagicBlasthitRate1: TSpinEdit;
    Label175: TLabel;
    Label176: TLabel;
    EditSerieMagicBlasthitRate2: TSpinEdit;
    Label177: TLabel;
    Label178: TLabel;
    EditSerieMagicBlasthitRate3: TSpinEdit;
    Label179: TLabel;
    GroupBoxSerieMagicBlasthitPowerRate: TGroupBox;
    Label180: TLabel;
    EditSerieMagicBlasthitPowerRate: TSpinEdit;
    TabSheet14: TTabSheet;
    GroupBox100: TGroupBox;
    Label185: TLabel;
    EditItemMaxStarCount: TSpinEdit;
    PageControlAI: TPageControl;
    TabSheet15: TTabSheet;
    GroupBox72: TGroupBox;
    ListBoxAIList: TMyListBox;
    GroupBox99: TGroupBox;
    Label184: TLabel;
    EditAIName: TEdit;
    ButtonAIListAdd: TButton;
    ButtonAIDel: TButton;
    GroupBox73: TGroupBox;
    Label181: TLabel;
    Label182: TLabel;
    Label183: TLabel;
    EditHomeX: TSpinEdit;
    EditHomeY: TSpinEdit;
    EditHomeMap: TEdit;
    ButtonAILogon: TButton;
    TabSheet16: TTabSheet;
    GroupBox103: TGroupBox;
    CheckBoxAutoRepairItem: TCheckBox;
    GroupBox104: TGroupBox;
    CheckBoxRenewHealth: TCheckBox;
    GroupBox105: TGroupBox;
    Label188: TLabel;
    Label190: TLabel;
    EditRenewPercent: TSpinEdit;
    ButtonSaveAI: TButton;
    GroupBox101: TGroupBox;
    EditConfigListFileName: TEdit;
    GroupBox102: TGroupBox;
    CheckBoxCheckCanUpgradeStarItem: TCheckBox;
    procedure CheckBoxEnablePasswordLockClick(Sender: TObject);
    procedure CheckBoxLockGetBackItemClick(Sender: TObject);
    procedure CheckBoxLockDealItemClick(Sender: TObject);
    procedure CheckBoxLockDropItemClick(Sender: TObject);
    procedure CheckBoxLockWalkClick(Sender: TObject);
    procedure CheckBoxLockRunClick(Sender: TObject);
    procedure CheckBoxLockHitClick(Sender: TObject);
    procedure CheckBoxLockSpellClick(Sender: TObject);
    procedure CheckBoxLockSendMsgClick(Sender: TObject);
    procedure CheckBoxLockInObModeClick(Sender: TObject);
    procedure EditErrorPasswordCountChange(Sender: TObject);
    procedure ButtonPasswordLockSaveClick(Sender: TObject);
    procedure CheckBoxErrorCountKickClick(Sender: TObject);
    procedure CheckBoxLockLoginClick(Sender: TObject);
    procedure CheckBoxLockUseItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxHungerSystemClick(Sender: TObject);
    procedure CheckBoxHungerDecHPClick(Sender: TObject);
    procedure CheckBoxHungerDecPowerClick(Sender: TObject);
    procedure ButtonGeneralSaveClick(Sender: TObject);
    procedure CheckBoxLimitSwordLongClick(Sender: TObject);
    procedure ButtonSkillSaveClick(Sender: TObject);
    procedure EditBoneFammNameChange(Sender: TObject);
    procedure EditBoneFammCountChange(Sender: TObject);
    procedure EditSwordLongPowerRateChange(Sender: TObject);
    procedure EditFireBoomRageChange(Sender: TObject);
    procedure EditSnowWindRangeChange(Sender: TObject);
    procedure EditElecBlizzardRangeChange(Sender: TObject);
    procedure EditDogzCountChange(Sender: TObject);
    procedure EditDogzNameChange(Sender: TObject);
    procedure GridBoneFammSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure EditAmyOunsulPointChange(Sender: TObject);
    procedure EditMagicAttackRageChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponDCRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponDCTwoPointRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponDCThreePointRateChange(
      Sender: TObject);
    procedure ScrollBarUpgradeWeaponSCRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponSCTwoPointRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponSCThreePointRateChange(
      Sender: TObject);
    procedure ScrollBarUpgradeWeaponMCRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponMCTwoPointRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponMCThreePointRateChange(
      Sender: TObject);
    procedure EditUpgradeWeaponMaxPointChange(Sender: TObject);
    procedure EditUpgradeWeaponPriceChange(Sender: TObject);
    procedure EditUPgradeWeaponGetBackTimeChange(Sender: TObject);
    procedure EditClearExpireUpgradeWeaponDaysChange(Sender: TObject);
    procedure ButtonUpgradeWeaponSaveClick(Sender: TObject);
    procedure EditMasterOKLevelChange(Sender: TObject);
    procedure ButtonMasterSaveClick(Sender: TObject);
    procedure EditMasterOKCreditPointChange(Sender: TObject);
    procedure EditMasterOKBonusPointChange(Sender: TObject);
    procedure ScrollBarMakeMineHitRateChange(Sender: TObject);
    procedure ScrollBarMakeMineRateChange(Sender: TObject);
    procedure ScrollBarStoneTypeRateChange(Sender: TObject);
    procedure ScrollBarGoldStoneMaxChange(Sender: TObject);
    procedure ScrollBarSilverStoneMaxChange(Sender: TObject);
    procedure ScrollBarSteelStoneMaxChange(Sender: TObject);
    procedure ScrollBarBlackStoneMaxChange(Sender: TObject);
    procedure ButtonMakeMineSaveClick(Sender: TObject);
    procedure EditStoneMinDuraChange(Sender: TObject);
    procedure EditStoneGeneralDuraRateChange(Sender: TObject);
    procedure EditStoneAddDuraRateChange(Sender: TObject);
    procedure EditStoneAddDuraMaxChange(Sender: TObject);
    procedure ButtonWinLotterySaveClick(Sender: TObject);
    procedure EditWinLottery1GoldChange(Sender: TObject);
    procedure EditWinLottery2GoldChange(Sender: TObject);
    procedure EditWinLottery3GoldChange(Sender: TObject);
    procedure EditWinLottery4GoldChange(Sender: TObject);
    procedure EditWinLottery5GoldChange(Sender: TObject);
    procedure EditWinLottery6GoldChange(Sender: TObject);
    procedure ScrollBarWinLottery1MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery2MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery3MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery4MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery5MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery6MaxChange(Sender: TObject);
    procedure ScrollBarWinLotteryRateChange(Sender: TObject);
    procedure ButtonReNewLevelSaveClick(Sender: TObject);
    procedure EditReNewNameColor1Change(Sender: TObject);
    procedure EditReNewNameColor2Change(Sender: TObject);
    procedure EditReNewNameColor3Change(Sender: TObject);
    procedure EditReNewNameColor4Change(Sender: TObject);
    procedure EditReNewNameColor5Change(Sender: TObject);
    procedure EditReNewNameColor6Change(Sender: TObject);
    procedure EditReNewNameColor7Change(Sender: TObject);
    procedure EditReNewNameColor8Change(Sender: TObject);
    procedure EditReNewNameColor9Change(Sender: TObject);
    procedure EditReNewNameColor10Change(Sender: TObject);
    procedure EditReNewNameColorTimeChange(Sender: TObject);
    procedure FunctionConfigControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure ButtonMonUpgradeSaveClick(Sender: TObject);
    procedure EditMonUpgradeColor1Change(Sender: TObject);
    procedure EditMonUpgradeColor2Change(Sender: TObject);
    procedure EditMonUpgradeColor3Change(Sender: TObject);
    procedure EditMonUpgradeColor4Change(Sender: TObject);
    procedure EditMonUpgradeColor5Change(Sender: TObject);
    procedure EditMonUpgradeColor6Change(Sender: TObject);
    procedure EditMonUpgradeColor7Change(Sender: TObject);
    procedure EditMonUpgradeColor8Change(Sender: TObject);
    procedure EditMonUpgradeColor9Change(Sender: TObject);
    procedure CheckBoxReNewChangeColorClick(Sender: TObject);
    procedure CheckBoxReNewLevelClearExpClick(Sender: TObject);
    procedure EditPKFlagNameColorChange(Sender: TObject);
    procedure EditPKLevel1NameColorChange(Sender: TObject);
    procedure EditPKLevel2NameColorChange(Sender: TObject);
    procedure EditAllyAndGuildNameColorChange(Sender: TObject);
    procedure EditWarGuildNameColorChange(Sender: TObject);
    procedure EditInFreePKAreaNameColorChange(Sender: TObject);
    procedure EditMonUpgradeKillCount1Change(Sender: TObject);
    procedure EditMonUpgradeKillCount2Change(Sender: TObject);
    procedure EditMonUpgradeKillCount3Change(Sender: TObject);
    procedure EditMonUpgradeKillCount4Change(Sender: TObject);
    procedure EditMonUpgradeKillCount5Change(Sender: TObject);
    procedure EditMonUpgradeKillCount6Change(Sender: TObject);
    procedure EditMonUpgradeKillCount7Change(Sender: TObject);
    procedure EditMonUpLvNeedKillBaseChange(Sender: TObject);
    procedure EditMonUpLvRateChange(Sender: TObject);
    procedure CheckBoxMasterDieMutinyClick(Sender: TObject);
    procedure EditMasterDieMutinyRateChange(Sender: TObject);
    procedure EditMasterDieMutinyPowerChange(Sender: TObject);
    procedure EditMasterDieMutinySpeedChange(Sender: TObject);
    procedure ButtonSpiritMutinySaveClick(Sender: TObject);
    procedure CheckBoxSpiritMutinyClick(Sender: TObject);
    procedure EditSpiritMutinyTimeChange(Sender: TObject);
    procedure EditSpiritPowerRateChange(Sender: TObject);
    procedure EditMagTurnUndeadLevelChange(Sender: TObject);
    procedure EditMagTammingLevelChange(Sender: TObject);
    procedure EditMagTammingTargetLevelChange(Sender: TObject);
    procedure EditMagTammingHPRateChange(Sender: TObject);
    procedure ButtonMonSayMsgSaveClick(Sender: TObject);
    procedure CheckBoxMonSayMsgClick(Sender: TObject);
    procedure ButtonUpgradeWeaponDefaulfClick(Sender: TObject);
    procedure ButtonMakeMineDefaultClick(Sender: TObject);
    procedure ButtonWinLotteryDefaultClick(Sender: TObject);
    procedure EditMabMabeHitRandRateChange(Sender: TObject);
    procedure EditMabMabeHitMinLvLimitChange(Sender: TObject);
    procedure EditMabMabeHitSucessRateChange(Sender: TObject);
    procedure EditMabMabeHitMabeTimeRateChange(Sender: TObject);
    procedure ButtonWeaponMakeLuckDefaultClick(Sender: TObject);
    procedure ButtonWeaponMakeLuckSaveClick(Sender: TObject);
    procedure ScrollBarWeaponMakeUnLuckRateChange(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint1Change(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint2Change(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint2RateChange(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint3Change(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint3RateChange(Sender: TObject);
    procedure EditTammingCountChange(Sender: TObject);
    procedure CheckBoxFireCrossInSafeZoneClick(Sender: TObject);
    procedure CheckBoxBBMonAutoChangeColorClick(Sender: TObject);
    procedure EditBBMonAutoChangeColorTimeChange(Sender: TObject);
    procedure CheckBoxGroupMbAttackPlayObjectClick(Sender: TObject);
    procedure SpinEditSellOffCountChange(Sender: TObject);
    procedure SpinEditSellOffTaxChange(Sender: TObject);
    procedure ButtonSellOffSaveClick(Sender: TObject);
    procedure CheckBoxPullPlayObjectClick(Sender: TObject);
    procedure CheckBoxPlayObjectReduceMPClick(Sender: TObject);
    procedure CheckBoxGroupMbAttackSlaveClick(Sender: TObject);
    procedure CheckBoxItemNameClick(Sender: TObject);
    procedure EditItemNameChange(Sender: TObject);
    procedure ButtonChangeUseItemNameClick(Sender: TObject);
    procedure SpinEditSkill39SecChange(Sender: TObject);
    procedure CheckBoxDedingAllowPKClick(Sender: TObject);
    procedure SpinEditAllowCopyCountChange(Sender: TObject);
    procedure EditCopyHumNameChange(Sender: TObject);
    procedure CheckBoxMasterNameClick(Sender: TObject);
    procedure SpinEditPickUpItemCountChange(Sender: TObject);
    procedure SpinEditEatHPItemRateChange(Sender: TObject);
    procedure SpinEditEatMPItemRateChange(Sender: TObject);
    procedure EditBagItems1Change(Sender: TObject);
    procedure EditBagItems2Change(Sender: TObject);
    procedure EditBagItems3Change(Sender: TObject);
    procedure CheckBoxAllowGuardAttackClick(Sender: TObject);
    procedure SpinEditWarrorAttackTimeChange(Sender: TObject);
    procedure SpinEditWizardAttackTimeChange(Sender: TObject);
    procedure SpinEditTaoistAttackTimeChange(Sender: TObject);
    procedure CheckBoxAllowReCallMobOtherHumClick(Sender: TObject);
    procedure CheckBoxNeedLevelHighTargetClick(Sender: TObject);
    procedure CheckBoxPullCrossInSafeZoneClick(Sender: TObject);
    procedure CheckBoxStartMapEventClick(Sender: TObject);
    procedure CheckBoxFireChgMapExtinguishClick(Sender: TObject);
    procedure SpinEditFireDelayTimeClick(Sender: TObject);
    procedure SpinEditFirePowerClick(Sender: TObject);
    procedure EditSkill43DelayTimeChange(Sender: TObject);
    procedure EditSkill58DelayTimeChange(Sender: TObject);
    procedure CheckBoxAllowRecallSelfClick(Sender: TObject);
    procedure RadioButtonDogzClick(Sender: TObject);
    procedure CheckBoxRecallAllClick(Sender: TObject);
    procedure EditSkill50DelayTimeChange(Sender: TObject);
    procedure CheckBoxBindItemNoDealClick(Sender: TObject);
    procedure CheckBoxBindItemNoScatterClick(Sender: TObject);
    procedure CheckBoxBindItemNoDropClick(Sender: TObject);
    procedure ButtonSaveBindItemClick(Sender: TObject);
    procedure CheckBoxCopyItemClearClick(Sender: TObject);
    procedure ButtonClearCopyItemClick(Sender: TObject);
    procedure CheckBoxBindItemNoSellOffClick(Sender: TObject);
    procedure CheckBoxMonUseBagItemClick(Sender: TObject);
    procedure CheckBoxHumUseBagItemClick(Sender: TObject);
    procedure EditNewShieldUseRateChange(Sender: TObject);
    procedure EditNewShieldDamageRateChange(Sender: TObject);
    procedure EditNewShieldWaitTimeChange(Sender: TObject);
    procedure EditSpaceSkillDelayTimeChange(Sender: TObject);
    procedure CheckBoxNoAllowWarRangeUseSpaceSkillClick(Sender: TObject);
    procedure CheckBoxAllowSpaceOutAttackClick(Sender: TObject);
    procedure EditSpaceSkillKeepTimeChange(Sender: TObject);
    procedure EditGroupFireCharmPowerRateChange(Sender: TObject);
    procedure EditMagicMovePositionTimeChange(Sender: TObject);
    procedure EditMagicMovePositionRateChange(Sender: TObject);
    procedure CheckBoxNoHintMagicFailClick(Sender: TObject);
    procedure CheckBoxNoHintMagicOKClick(Sender: TObject);
    procedure EditSkillZRJFDelayTimeChange(Sender: TObject);
    procedure EditSkill77PowerRateChange(Sender: TObject);
    procedure EditSkill75PowerRateChange(Sender: TObject);
    procedure EditSkill76PowerRateChange(Sender: TObject);
    procedure CheckBoxNoHintMagicCloseClick(Sender: TObject);
    procedure ButtonSaveStoreClick(Sender: TObject);
    procedure CheckBoxSafeCanStoreClick(Sender: TObject);
    procedure CheckBoxOpenStoreGMModeClick(Sender: TObject);
    procedure CheckBoxOpenStoreCheckLevelClick(Sender: TObject);
    procedure EditOpenStoreCheckLevelChange(Sender: TObject);
    procedure CheckBoxDeleteUpgradeFailWeaponClick(Sender: TObject);
    procedure EditUnKnowNameChange(Sender: TObject);
    procedure EditMoonHighPowerRateChange(Sender: TObject);
    procedure EditMoonLowPowerRateChange(Sender: TObject);
    procedure EditSkill58PowerRateChange(Sender: TObject);
    procedure EditSkill43PowerRateChange(Sender: TObject);
    procedure SpinEditDidingPowerRateChange(Sender: TObject);
    procedure EditStatusDelayTime1Change(Sender: TObject);
    procedure EditStatusDelayTime2Change(Sender: TObject);
    procedure EditWarrorWalkTimeChange(Sender: TObject);
    procedure EditWizardWalkTimeChange(Sender: TObject);
    procedure EditTaoistWalkTimeChange(Sender: TObject);
    procedure CheckBoxChangeMapReleasePoisonClick(Sender: TObject);
    procedure CheckBoxBindItemNoPickUpClick(Sender: TObject);
    procedure CheckBoxGetRandomHomePointClick(Sender: TObject);
    procedure ListBoxSerieMagicClick(Sender: TObject);
    procedure EditSerieMagicTimeChange(Sender: TObject);
    procedure EditSerieMagicPowerRateChange(Sender: TObject);
    procedure EditSerieMagicAttackRangeChange(Sender: TObject);
    procedure EditSerieMagicBlasthitRate1Change(Sender: TObject);
    procedure EditSerieMagicBlasthitRate2Change(Sender: TObject);
    procedure EditSerieMagicBlasthitRate3Change(Sender: TObject);
    procedure EditSerieMagicBlasthitPowerRateChange(Sender: TObject);
    procedure EditHomeMapChange(Sender: TObject);
    procedure EditHomeXChange(Sender: TObject);
    procedure EditHomeYChange(Sender: TObject);
    procedure ButtonSaveAIClick(Sender: TObject);
    procedure ListBoxAIListClick(Sender: TObject);
    procedure ButtonAIDelClick(Sender: TObject);
    procedure ButtonAIListAddClick(Sender: TObject);
    procedure ButtonAILogonClick(Sender: TObject);
    procedure EditItemMaxStarCountChange(Sender: TObject);
    procedure ListBoxAIListSelect(Sender: TObject);
    procedure CheckBoxAutoRepairItemClick(Sender: TObject);
    procedure CheckBoxRenewHealthClick(Sender: TObject);
    procedure EditRenewPercentChange(Sender: TObject);
    procedure EditConfigListFileNameChange(Sender: TObject);
    procedure CheckBoxCheckCanUpgradeStarItemClick(Sender: TObject);

  private
    boOpened: Boolean;
    boModValued: Boolean;
    procedure ModValue();
    procedure uModValue();
    procedure RefReNewLevelConf;
    procedure RefUpgradeWeapon;
    procedure RefMakeMine;
    procedure RefWinLottery;
    procedure RefMonUpgrade;
    procedure RefGeneral;
    procedure RefSpiritMutiny;
    procedure RefMagicSkill;
    procedure RefMonSayMsg;
    procedure RefWeaponMakeLuck();
    procedure RefCopyHumConf;
    { Private declarations }
  public
    procedure Open;
    { Public declarations }
  end;

var
  frmFunctionConfig: TfrmFunctionConfig;

implementation

uses UsrEngn, M2Share, HUtil32, SDK;

var
  SelBoxItem: pTBoxItem;
  SelItemBox: pTItemBox;
{$R *.dfm}

{ TfrmFunctionConfig }

procedure TfrmFunctionConfig.ModValue;
begin
  boModValued := True;
  ButtonPasswordLockSave.Enabled := True;
  ButtonGeneralSave.Enabled := True;
  ButtonSkillSave.Enabled := True;
  ButtonUpgradeWeaponSave.Enabled := True;
  ButtonMasterSave.Enabled := True;
  ButtonMakeMineSave.Enabled := True;
  ButtonWinLotterySave.Enabled := True;
  ButtonReNewLevelSave.Enabled := True;
  ButtonMonUpgradeSave.Enabled := True;
  ButtonSpiritMutinySave.Enabled := True;
  ButtonMonSayMsgSave.Enabled := True;
  ButtonSellOffSave.Enabled := True;
  ButtonChangeUseItemName.Enabled := True;
  ButtonSaveBindItem.Enabled := True;
  ButtonClearCopyItem.Enabled := True;
  ButtonSaveStore.Enabled := True;
  ButtonSaveAI.Enabled := True;
end;

procedure TfrmFunctionConfig.uModValue;
begin
  boModValued := False;
  ButtonPasswordLockSave.Enabled := False;
  ButtonGeneralSave.Enabled := False;
  ButtonSkillSave.Enabled := False;
  ButtonUpgradeWeaponSave.Enabled := False;
  ButtonMasterSave.Enabled := False;
  ButtonMakeMineSave.Enabled := False;
  ButtonWinLotterySave.Enabled := False;
  ButtonReNewLevelSave.Enabled := False;
  ButtonMonUpgradeSave.Enabled := False;
  ButtonSpiritMutinySave.Enabled := False;
  ButtonMonSayMsgSave.Enabled := False;
  ButtonSellOffSave.Enabled := False;
  ButtonChangeUseItemName.Enabled := False;
  ButtonSaveBindItem.Enabled := False;
  ButtonClearCopyItem.Enabled := False;
  ButtonSaveStore.Enabled := False;
  ButtonSaveAI.Enabled := False;
end;

procedure TfrmFunctionConfig.FunctionConfigControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if boModValued then begin
    if Application.MessageBox('参数设置已经被修改，是否确认不保存修改的设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) = IDYES then begin
      uModValue
    end else AllowChange := False;
  end;
end;

procedure TfrmFunctionConfig.Open;
var
  I: Integer;
begin
  boOpened := False;
  uModValue();

  RefGeneral();
  CheckBoxHungerSystem.Checked := g_Config.boHungerSystem;
  CheckBoxHungerDecHP.Checked := g_Config.boHungerDecHP;
  CheckBoxHungerDecPower.Checked := g_Config.boHungerDecPower;

  CheckBoxHungerSystemClick(CheckBoxHungerSystem);


  CheckBoxEnablePasswordLock.Checked := g_Config.boPasswordLockSystem;
  CheckBoxLockGetBackItem.Checked := g_Config.boLockGetBackItemAction;
  CheckBoxLockDealItem.Checked := g_Config.boLockDealAction;
  CheckBoxLockDropItem.Checked := g_Config.boLockDropAction;
  CheckBoxLockWalk.Checked := g_Config.boLockWalkAction;
  CheckBoxLockRun.Checked := g_Config.boLockRunAction;
  CheckBoxLockHit.Checked := g_Config.boLockHitAction;
  CheckBoxLockSpell.Checked := g_Config.boLockSpellAction;
  CheckBoxLockSendMsg.Checked := g_Config.boLockSendMsgAction;
  CheckBoxLockInObMode.Checked := g_Config.boLockInObModeAction;

  CheckBoxLockLogin.Checked := g_Config.boLockHumanLogin;
  CheckBoxLockUseItem.Checked := g_Config.boLockUserItemAction;

  CheckBoxEnablePasswordLockClick(CheckBoxEnablePasswordLock);
  CheckBoxLockLoginClick(CheckBoxLockLogin);

  EditErrorPasswordCount.Value := g_Config.nPasswordErrorCountLock;


  EditBoneFammName.Text := g_Config.sBoneFamm;
  EditBoneFammCount.Value := g_Config.nBoneFammCount;


  SpinEditSellOffCount.Value := g_Config.nUserSellOffCount;
  SpinEditSellOffTax.Value := g_Config.nUserSellOffTax;

  SpinEditFireDelayTime.Value := g_Config.nFireDelayTimeRate;
  SpinEditFirePower.Value := g_Config.nFirePowerRate;
  CheckBoxFireChgMapExtinguish.Checked := g_Config.boChangeMapFireExtinguish;

  SpinEditDidingPowerRate.Value := g_Config.nDidingPowerRate;

  for I := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do begin
    if g_Config.BoneFammArray[I].nHumLevel <= 0 then Break;

    GridBoneFamm.Cells[0, I + 1] := IntToStr(g_Config.BoneFammArray[I].nHumLevel);
    GridBoneFamm.Cells[1, I + 1] := g_Config.BoneFammArray[I].sMonName;
    GridBoneFamm.Cells[2, I + 1] := IntToStr(g_Config.BoneFammArray[I].nCount);
    GridBoneFamm.Cells[3, I + 1] := IntToStr(g_Config.BoneFammArray[I].nLevel);
  end;

  EditDogzName.Text := g_Config.sDogz;
  EditDogzCount.Value := g_Config.nDogzCount;
  for I := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do begin
    if g_Config.DogzArray[I].nHumLevel <= 0 then Break;
    GridDogz.Cells[0, I + 1] := IntToStr(g_Config.DogzArray[I].nHumLevel);
    GridDogz.Cells[1, I + 1] := g_Config.DogzArray[I].sMonName;
    GridDogz.Cells[2, I + 1] := IntToStr(g_Config.DogzArray[I].nCount);
    GridDogz.Cells[3, I + 1] := IntToStr(g_Config.DogzArray[I].nLevel);
  end;


  RefMagicSkill();

  RefUpgradeWeapon();
  RefMakeMine();
  RefWinLottery();
  EditMasterOKLevel.Value := g_Config.nMasterOKLevel;
  EditMasterOKCreditPoint.Value := g_Config.nMasterOKCreditPoint;
  EditMasterOKBonusPoint.Value := g_Config.nMasterOKBonusPoint;

  CheckBoxPullPlayObject.Checked := g_Config.boPullPlayObject;
  CheckBoxPullCrossInSafeZone.Checked := g_Config.boPullCrossInSafeZone;
  CheckBoxPullCrossInSafeZone.Enabled := g_Config.boPullPlayObject;

  CheckBoxPlayObjectReduceMP.Checked := g_Config.boPlayObjectReduceMP;
  CheckBoxGroupMbAttackSlave.Checked := g_Config.boGroupMbAttackSlave;
  CheckBoxItemName.Checked := g_Config.boChangeUseItemNameByPlayName;
  EditItemName.Text := g_Config.sChangeUseItemName;
  CheckBoxDedingAllowPK.Checked := g_Config.boDedingAllowPK;

  SpinEditSkill39Sec.Value := g_Config.nDedingUseTime;
  CheckBoxStartMapEvent.Checked := g_Config.boStartMapEvent;

  EditSkill43DelayTime.Value := g_Config.nSkill43DelayTime;
  EditSkill58DelayTime.Value := g_Config.nSkill58DelayTime;
  EditSkill43PowerRate.Value := g_Config.nSkill43PowerRate;
  EditSkill58PowerRate.Value := g_Config.nSkill58PowerRate;
  EditSkill50DelayTime.Value := g_Config.nSkill50DelayTime;

  CheckBoxAllowRecallSelf.Checked := g_Config.boAllowRecallSelf;

  RadioButtonDogz.Checked := g_Config.boAllowRecallDogz;
  RadioButtonMoon.Checked := g_Config.boAllowRecallMoon;
  CheckBoxRecallAll.Checked := g_Config.boAllowRecallAll;







  CheckBoxBindItemNoDeal.Checked := g_Config.boBindItemNoDeal;
  CheckBoxBindItemNoScatter.Checked := g_Config.boBindItemNoScatter;
  CheckBoxBindItemNoDrop.Checked := g_Config.boBindItemNoDrop;
  CheckBoxBindItemNoSellOff.Checked := g_Config.boBindItemNoSellOff;
  CheckBoxBindItemNoPickUp.Checked := g_Config.boBindItemNoPickUp;



  CheckBoxCopyItemClear.Checked := g_Config.boCopyItemClear;


  CheckBoxMonUseBagItem.Checked := g_Config.boMonUseBagItem;
  CheckBoxHumUseBagItem.Checked := g_Config.boHumUseBagItem;

  EditNewShieldUseRate.Value := g_Config.nNewShieldUseRate;
  EditNewShieldDamageRate.Value := g_Config.nNewShieldDamageRate;
  EditNewShieldWaitTime.Value := g_Config.nNewShieldWaitTime;

  EditSpaceSkillDelayTime.Value := g_Config.nSpaceSkillDelayTime;
  EditSpaceSkillKeepTime.Value := g_Config.nSpaceSkillKeepTime;


  CheckBoxNoAllowWarRangeUseSpaceSkill.Checked := g_Config.boNoAllowWarRangeUseSpaceSkill;
  CheckBoxAllowSpaceOutAttack.Checked := g_Config.boAllowSpaceOutAttack;

  EditGroupFireCharmPowerRate.Value := g_Config.nGroupFireCharmPowerRate;


  EditMagicMovePositionTime.Value := g_Config.nMagicMovePositionTime;
  EditMagicMovePositionRate.Value := g_Config.nMagicMovePositionRate;


  CheckBoxNoHintMagicFail.Checked := g_Config.boNoHintMagicFail;
  CheckBoxNoHintMagicOK.Checked := g_Config.boNoHintMagicOK;
  CheckBoxNoHintMagicClose.Checked := g_Config.boNoHintMagicClose;


  EditSkillZRJFDelayTime.Value := g_Config.nSkillZRJFDelayTime;
  EditSkill77PowerRate.Value := g_Config.nSkill77PowerRate;
  EditSkill76PowerRate.Value := g_Config.nSkill76PowerRate;
  EditSkill75PowerRate.Value := g_Config.nSkill75PowerRate;



  CheckBoxSafeCanStore.Checked := g_Config.boSafeCanStore;
  CheckBoxOpenStoreGMMode.Checked := g_Config.boOpenStoreGMMode;

  CheckBoxOpenStoreCheckLevel.Checked := g_Config.boOpenStoreCheckLevel;
  EditOpenStoreCheckLevel.Value := g_Config.nOpenStoreCheckLevel;


  EditMoonLowPowerRate.Value := g_Config.nMoonLowPowerRate;
  EditMoonHighPowerRate.Value := g_Config.nMoonHighPowerRate;


  EditStatusDelayTime1.Value := g_Config.StatusDelayTime[1];
  EditStatusDelayTime2.Value := g_Config.StatusDelayTime[2];
  CheckBoxChangeMapReleasePoison.Checked := g_Config.boChangeMapReleasePoison;

  CheckBoxGetRandomHomePoint.Checked := g_Config.boGetRandomHomePoint;

  EditItemMaxStarCount.Value := g_Config.nItemMaxStarCount;

  RefReNewLevelConf();
  RefMonUpgrade();
  RefSpiritMutiny();
  RefMonSayMsg();
  RefWeaponMakeLuck();

  RefCopyHumConf;

  EditUnKnowName.Text := g_Config.sUnKnowName;


  EditHomeMap.Text := g_Config.sAIHomeMap;
  EditHomeX.Value := g_Config.nAIHomeX;
  EditHomeY.Value := g_Config.nAIHomeY;

  CheckBoxAutoRepairItem.Checked := g_Config.boAutoRepairItem;
  CheckBoxRenewHealth.Checked := g_Config.boRenewHealth;
  EditRenewPercent.Value := g_Config.nRenewPercent;

  EditConfigListFileName.Text := g_Config.sAIConfigListFileName;

  g_AICharNameList.Lock;
  try
    ListBoxAIList.Clear;
    ListBoxAIList.Items.AddStrings(g_AICharNameList);
  finally
    g_AICharNameList.UnLock;
  end;
  ButtonAIDel.Enabled := False;
  ButtonAILogon.Enabled := False;


  CheckBoxCheckCanUpgradeStarItem.Checked := g_Config.boCheckCanUpgradeStarItem;


  boOpened := True;
  FunctionConfigControl.ActivePageIndex := 0;

  PageControlAI.ActivePageIndex := 0;

  ShowModal;
end;

procedure TfrmFunctionConfig.FormCreate(Sender: TObject);
begin
  GridBoneFamm.Cells[0, 0] := '人物等级';
  GridBoneFamm.Cells[1, 0] := '怪物名称';
  GridBoneFamm.Cells[2, 0] := '数量';
  GridBoneFamm.Cells[3, 0] := '等级';

  GridDogz.Cells[0, 0] := '人物等级';
  GridDogz.Cells[1, 0] := '怪物名称';
  GridDogz.Cells[2, 0] := '数量';
  GridDogz.Cells[3, 0] := '等级';
  FunctionConfigControl.ActivePageIndex := 0;
  MagicPageControl.ActivePageIndex := 0;
{$IF (SoftVersion = VERPRO) or (SoftVersion = VERENT)}
  CheckBoxHungerDecPower.Visible := True;
{$ELSE}
  CheckBoxHungerDecPower.Visible := False;
{$IFEND}

{$IF SoftVersion = VERDEMO}
  Caption := '功能设置[演示版本，所有设置调整有效，但不能保存]'
{$IFEND}
end;

procedure TfrmFunctionConfig.CheckBoxEnablePasswordLockClick(
  Sender: TObject);
begin
  case CheckBoxEnablePasswordLock.Checked of
    True: begin
        CheckBoxLockGetBackItem.Enabled := True;
        CheckBoxLockLogin.Enabled := True;
      end;
    False: begin
        CheckBoxLockGetBackItem.Checked := False;
        CheckBoxLockLogin.Checked := False;

        CheckBoxLockGetBackItem.Enabled := False;
        CheckBoxLockLogin.Enabled := False;
      end;
  end;
  if not boOpened then Exit;
  g_Config.boPasswordLockSystem := CheckBoxEnablePasswordLock.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockGetBackItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockGetBackItemAction := CheckBoxLockGetBackItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockDealItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockDealAction := CheckBoxLockDealItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockDropItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockDropAction := CheckBoxLockDropItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockUseItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockUserItemAction := CheckBoxLockUseItem.Checked;
  ModValue();

end;

procedure TfrmFunctionConfig.CheckBoxLockLoginClick(Sender: TObject);
begin
  case CheckBoxLockLogin.Checked of //
    True: begin
        CheckBoxLockWalk.Enabled := True;
        CheckBoxLockRun.Enabled := True;
        CheckBoxLockHit.Enabled := True;
        CheckBoxLockSpell.Enabled := True;
        CheckBoxLockInObMode.Enabled := True;
        CheckBoxLockSendMsg.Enabled := True;
        CheckBoxLockDealItem.Enabled := True;
        CheckBoxLockDropItem.Enabled := True;
        CheckBoxLockUseItem.Enabled := True;
      end;
    False: begin
        CheckBoxLockWalk.Checked := False;
        CheckBoxLockRun.Checked := False;
        CheckBoxLockHit.Checked := False;
        CheckBoxLockSpell.Checked := False;
        CheckBoxLockInObMode.Checked := False;
        CheckBoxLockSendMsg.Checked := False;
        CheckBoxLockDealItem.Checked := False;
        CheckBoxLockDropItem.Checked := False;
        CheckBoxLockUseItem.Checked := False;

        CheckBoxLockWalk.Enabled := False;
        CheckBoxLockRun.Enabled := False;
        CheckBoxLockHit.Enabled := False;
        CheckBoxLockSpell.Enabled := False;
        CheckBoxLockInObMode.Enabled := False;
        CheckBoxLockSendMsg.Enabled := False;
        CheckBoxLockDealItem.Enabled := False;
        CheckBoxLockDropItem.Enabled := False;
        CheckBoxLockUseItem.Enabled := False;
      end;
  end;
  if not boOpened then Exit;
  g_Config.boLockHumanLogin := CheckBoxLockLogin.Checked;
  ModValue();

end;

procedure TfrmFunctionConfig.CheckBoxLockWalkClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockWalkAction := CheckBoxLockWalk.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockRunClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockRunAction := CheckBoxLockRun.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockHitClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockHitAction := CheckBoxLockHit.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockSpellClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockSpellAction := CheckBoxLockSpell.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockSendMsgClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockSendMsgAction := CheckBoxLockSendMsg.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockInObModeClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockInObModeAction := CheckBoxLockInObMode.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditErrorPasswordCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nPasswordErrorCountLock := EditErrorPasswordCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxErrorCountKickClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nPasswordErrorCountLock := EditErrorPasswordCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonPasswordLockSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'PasswordLockSystem', g_Config.boPasswordLockSystem);
  Config.WriteBool('Setup', 'PasswordLockDealAction', g_Config.boLockDealAction);
  Config.WriteBool('Setup', 'PasswordLockDropAction', g_Config.boLockDropAction);
  Config.WriteBool('Setup', 'PasswordLockGetBackItemAction', g_Config.boLockGetBackItemAction);
  Config.WriteBool('Setup', 'PasswordLockWalkAction', g_Config.boLockWalkAction);
  Config.WriteBool('Setup', 'PasswordLockRunAction', g_Config.boLockRunAction);
  Config.WriteBool('Setup', 'PasswordLockHitAction', g_Config.boLockHitAction);
  Config.WriteBool('Setup', 'PasswordLockSpellAction', g_Config.boLockSpellAction);
  Config.WriteBool('Setup', 'PasswordLockSendMsgAction', g_Config.boLockSendMsgAction);
  Config.WriteBool('Setup', 'PasswordLockInObModeAction', g_Config.boLockInObModeAction);
  Config.WriteBool('Setup', 'PasswordLockUserItemAction', g_Config.boLockUserItemAction);

  Config.WriteBool('Setup', 'PasswordLockHumanLogin', g_Config.boLockHumanLogin);
  Config.WriteInteger('Setup', 'PasswordErrorCountLock', g_Config.nPasswordErrorCountLock);

{$IFEND}
  uModValue();
end;


procedure TfrmFunctionConfig.RefGeneral();
begin
  EditPKFlagNameColor.Value := g_Config.btPKFlagNameColor;
  EditPKLevel1NameColor.Value := g_Config.btPKLevel1NameColor;
  EditPKLevel2NameColor.Value := g_Config.btPKLevel2NameColor;
  EditAllyAndGuildNameColor.Value := g_Config.btAllyAndGuildNameColor;
  EditWarGuildNameColor.Value := g_Config.btWarGuildNameColor;
  EditInFreePKAreaNameColor.Value := g_Config.btInFreePKAreaNameColor;
end;

procedure TfrmFunctionConfig.CheckBoxHungerSystemClick(Sender: TObject);
begin
  if CheckBoxHungerSystem.Checked then begin
    CheckBoxHungerDecHP.Enabled := True;
    CheckBoxHungerDecPower.Enabled := True;
  end else begin
    CheckBoxHungerDecHP.Checked := False;
    CheckBoxHungerDecPower.Checked := False;
    CheckBoxHungerDecHP.Enabled := False;
    CheckBoxHungerDecPower.Enabled := False;
  end;

  if not boOpened then Exit;
  g_Config.boHungerSystem := CheckBoxHungerSystem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxHungerDecHPClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHungerDecHP := CheckBoxHungerDecHP.Checked;
  ModValue();

end;

procedure TfrmFunctionConfig.CheckBoxHungerDecPowerClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHungerDecPower := CheckBoxHungerDecPower.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonGeneralSaveClick(Sender: TObject);
var
  I: Integer;
  sUnKnowName: string;
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'HungerSystem', g_Config.boHungerSystem);
  Config.WriteBool('Setup', 'HungerDecHP', g_Config.boHungerDecHP);
  Config.WriteBool('Setup', 'HungerDecPower', g_Config.boHungerDecPower);

  Config.WriteInteger('Setup', 'PKFlagNameColor', g_Config.btPKFlagNameColor);
  Config.WriteInteger('Setup', 'AllyAndGuildNameColor', g_Config.btAllyAndGuildNameColor);
  Config.WriteInteger('Setup', 'WarGuildNameColor', g_Config.btWarGuildNameColor);
  Config.WriteInteger('Setup', 'InFreePKAreaNameColor', g_Config.btInFreePKAreaNameColor);
  Config.WriteInteger('Setup', 'PKLevel1NameColor', g_Config.btPKLevel1NameColor);
  Config.WriteInteger('Setup', 'PKLevel2NameColor', g_Config.btPKLevel2NameColor);
  Config.WriteBool('Setup', 'StartMapEvent', g_Config.boStartMapEvent);
  Config.WriteBool('Setup', 'HumUseBagItem', g_Config.boHumUseBagItem);

  for I := 1 to 2 do begin
    Config.WriteInteger('Setup', 'StatusDelayTime' + IntToStr(I), g_Config.StatusDelayTime[I]);
  end;


  sUnKnowName := Trim(EditUnKnowName.Text);
  if sUnKnowName = '' then begin
    Application.MessageBox('名称不能为空！！！', '提示信息', MB_OK + MB_ICONERROR);
    EditUnKnowName.SetFocus;
    Exit;
  end;
  g_Config.sUnKnowName := sUnKnowName;
  Config.WriteString('Setup', 'UnKnowName', g_Config.sUnKnowName);

  Config.WriteBool('Setup', 'GetRandomHomePoint', g_Config.boGetRandomHomePoint);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.EditMagicAttackRageChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagicAttackRage := EditMagicAttackRage.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.RefMagicSkill;
var
  I: Integer;
  Magic: pTMagic;
begin
  EditSwordLongPowerRate.Value := g_Config.nSwordLongPowerRate;
  CheckBoxLimitSwordLong.Checked := g_Config.boLimitSwordLong;
  EditFireBoomRage.Value := g_Config.nFireBoomRage;
  EditSnowWindRange.Value := g_Config.nSnowWindRange;
  EditElecBlizzardRange.Value := g_Config.nElecBlizzardRange;
  EditMagicAttackRage.Value := g_Config.nMagicAttackRage;
  EditAmyOunsulPoint.Value := g_Config.nAmyOunsulPoint;
  EditMagTurnUndeadLevel.Value := g_Config.nMagTurnUndeadLevel;
  EditMagTammingLevel.Value := g_Config.nMagTammingLevel;
  EditMagTammingTargetLevel.Value := g_Config.nMagTammingTargetLevel;
  EditMagTammingHPRate.Value := g_Config.nMagTammingHPRate;
  EditTammingCount.Value := g_Config.nMagTammingCount;
  EditMabMabeHitRandRate.Value := g_Config.nMabMabeHitRandRate;
  EditMabMabeHitMinLvLimit.Value := g_Config.nMabMabeHitMinLvLimit;
  EditMabMabeHitSucessRate.Value := g_Config.nMabMabeHitSucessRate;
  EditMabMabeHitMabeTimeRate.Value := g_Config.nMabMabeHitMabeTimeRate;
  CheckBoxFireCrossInSafeZone.Checked := g_Config.boDisableInSafeZoneFireCross;
  CheckBoxGroupMbAttackPlayObject.Checked := g_Config.boGroupMbAttackPlayObject;

  EditSerieMagicTime.Value := g_Config.nSerieMagicTime;
  ListBoxSerieMagic.Clear;
  for I := 0 to UserEngine.m_MagicList.Count - 1 do begin
    Magic := UserEngine.m_MagicList.Items[I];
    if Magic.wMagicId in [100..111] then begin
      ListBoxSerieMagic.Items.AddObject(Magic.sMagicName, TObject(Magic));
    end;
  end;
  GroupBoxSerie.Enabled := False;
end;

procedure TfrmFunctionConfig.EditBoneFammCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBoneFammCount := EditBoneFammCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDogzCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDogzCount := EditDogzCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLimitSwordLongClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLimitSwordLong := CheckBoxLimitSwordLong.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSwordLongPowerRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSwordLongPowerRate := EditSwordLongPowerRate.Value;
  ModValue()
end;

procedure TfrmFunctionConfig.EditBoneFammNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDogzNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmFunctionConfig.EditFireBoomRageChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFireBoomRage := EditFireBoomRage.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSnowWindRangeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSnowWindRange := EditSnowWindRange.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditElecBlizzardRangeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nElecBlizzardRange := EditElecBlizzardRange.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMagTurnUndeadLevelChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagTurnUndeadLevel := EditMagTurnUndeadLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.GridBoneFammSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmFunctionConfig.EditAmyOunsulPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAmyOunsulPoint := EditAmyOunsulPoint.Value;
  ModValue();
end;


procedure TfrmFunctionConfig.CheckBoxFireChgMapExtinguishClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boChangeMapFireExtinguish := CheckBoxFireChgMapExtinguish.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxFireCrossInSafeZoneClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boDisableInSafeZoneFireCross := CheckBoxFireCrossInSafeZone.Checked;
  ModValue();
end;


procedure TfrmFunctionConfig.CheckBoxGroupMbAttackPlayObjectClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boGroupMbAttackPlayObject := CheckBoxGroupMbAttackPlayObject.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonSkillSaveClick(Sender: TObject);
var
  I, II: Integer;
  RecallArray: array[0..9] of TRecallMigic;
  Rect: TGridRect;
begin
  FillChar(RecallArray, SizeOf(RecallArray), #0);

  g_Config.sBoneFamm := Trim(EditBoneFammName.Text);

  for I := Low(RecallArray) to High(RecallArray) do begin
    RecallArray[I].nHumLevel := Str_ToInt(GridBoneFamm.Cells[0, I + 1], -1);
    RecallArray[I].sMonName := Trim(GridBoneFamm.Cells[1, I + 1]);
    RecallArray[I].nCount := Str_ToInt(GridBoneFamm.Cells[2, I + 1], -1);
    RecallArray[I].nLevel := Str_ToInt(GridBoneFamm.Cells[3, I + 1], -1);
    if GridBoneFamm.Cells[0, I + 1] = '' then Break;
    if (RecallArray[I].nHumLevel <= 0) then begin
      Application.MessageBox('人物等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 0;
      Rect.Top := I + 1;
      Rect.Right := 0;
      Rect.Bottom := I + 1;
      GridBoneFamm.Selection := Rect;
      Exit;
    end;
    if UserEngine.GetMonRace(RecallArray[I].sMonName) <= 0 then begin
      Application.MessageBox('怪物名称设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 1;
      Rect.Top := I + 1;
      Rect.Right := 1;
      Rect.Bottom := I + 1;
      GridBoneFamm.Selection := Rect;
      Exit;
    end;
    if RecallArray[I].nCount <= 0 then begin
      Application.MessageBox('召唤数量设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 2;
      Rect.Top := I + 1;
      Rect.Right := 2;
      Rect.Bottom := I + 1;
      GridBoneFamm.Selection := Rect;
      Exit;
    end;
    if RecallArray[I].nLevel < 0 then begin
      Application.MessageBox('召唤等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 3;
      Rect.Top := I + 1;
      Rect.Right := 3;
      Rect.Bottom := I + 1;
      GridBoneFamm.Selection := Rect;
      Exit;
    end;
  end;

  for I := Low(RecallArray) to High(RecallArray) do begin
    RecallArray[I].nHumLevel := Str_ToInt(GridDogz.Cells[0, I + 1], -1);
    RecallArray[I].sMonName := Trim(GridDogz.Cells[1, I + 1]);
    RecallArray[I].nCount := Str_ToInt(GridDogz.Cells[2, I + 1], -1);
    RecallArray[I].nLevel := Str_ToInt(GridDogz.Cells[3, I + 1], -1);
    if GridDogz.Cells[0, I + 1] = '' then Break;
    if (RecallArray[I].nHumLevel <= 0) then begin
      Application.MessageBox('人物等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 0;
      Rect.Top := I + 1;
      Rect.Right := 0;
      Rect.Bottom := I + 1;
      GridDogz.Selection := Rect;
      Exit;
    end;
    if UserEngine.GetMonRace(RecallArray[I].sMonName) <= 0 then begin
      Application.MessageBox('怪物名称设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 1;
      Rect.Top := I + 1;
      Rect.Right := 1;
      Rect.Bottom := I + 1;
      GridDogz.Selection := Rect;
      Exit;
    end;
    if RecallArray[I].nCount <= 0 then begin
      Application.MessageBox('召唤数量设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 2;
      Rect.Top := I + 1;
      Rect.Right := 2;
      Rect.Bottom := I + 1;
      GridDogz.Selection := Rect;
      Exit;
    end;
    if RecallArray[I].nLevel < 0 then begin
      Application.MessageBox('召唤等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 3;
      Rect.Top := I + 1;
      Rect.Right := 3;
      Rect.Bottom := I + 1;
      GridDogz.Selection := Rect;
      Exit;
    end;
  end;
  FillChar(g_Config.BoneFammArray, SizeOf(g_Config.BoneFammArray), #0);
  for I := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do begin
    Config.WriteInteger('Setup', 'BoneFammHumLevel' + IntToStr(I), 0);
    Config.WriteString('Names', 'BoneFamm' + IntToStr(I), '');
    Config.WriteInteger('Setup', 'BoneFammCount' + IntToStr(I), 0);
    Config.WriteInteger('Setup', 'BoneFammLevel' + IntToStr(I), 0);
  end;
  for I := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do begin
    if GridBoneFamm.Cells[0, I + 1] = '' then Break;
    g_Config.BoneFammArray[I].nHumLevel := Str_ToInt(GridBoneFamm.Cells[0, I + 1], -1);
    g_Config.BoneFammArray[I].sMonName := Trim(GridBoneFamm.Cells[1, I + 1]);
    g_Config.BoneFammArray[I].nCount := Str_ToInt(GridBoneFamm.Cells[2, I + 1], -1);
    g_Config.BoneFammArray[I].nLevel := Str_ToInt(GridBoneFamm.Cells[3, I + 1], -1);

    Config.WriteInteger('Setup', 'BoneFammHumLevel' + IntToStr(I), g_Config.BoneFammArray[I].nHumLevel);
    Config.WriteString('Names', 'BoneFamm' + IntToStr(I), g_Config.BoneFammArray[I].sMonName);
    Config.WriteInteger('Setup', 'BoneFammCount' + IntToStr(I), g_Config.BoneFammArray[I].nCount);
    Config.WriteInteger('Setup', 'BoneFammLevel' + IntToStr(I), g_Config.BoneFammArray[I].nLevel);
  end;

  FillChar(g_Config.DogzArray, SizeOf(g_Config.DogzArray), #0);
  for I := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do begin
    Config.WriteInteger('Setup', 'DogzHumLevel' + IntToStr(I), 0);
    Config.WriteString('Names', 'Dogz' + IntToStr(I), '');
    Config.WriteInteger('Setup', 'DogzCount' + IntToStr(I), 0);
    Config.WriteInteger('Setup', 'DogzLevel' + IntToStr(I), 0);
  end;
  for I := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do begin
    if GridDogz.Cells[0, I + 1] = '' then Break;

    g_Config.DogzArray[I].nHumLevel := Str_ToInt(GridDogz.Cells[0, I + 1], -1);
    g_Config.DogzArray[I].sMonName := Trim(GridDogz.Cells[1, I + 1]);
    g_Config.DogzArray[I].nCount := Str_ToInt(GridDogz.Cells[2, I + 1], -1);
    g_Config.DogzArray[I].nLevel := Str_ToInt(GridDogz.Cells[3, I + 1], -1);

    Config.WriteInteger('Setup', 'DogzHumLevel' + IntToStr(I), g_Config.DogzArray[I].nHumLevel);
    Config.WriteString('Names', 'Dogz' + IntToStr(I), g_Config.DogzArray[I].sMonName);
    Config.WriteInteger('Setup', 'DogzCount' + IntToStr(I), g_Config.DogzArray[I].nCount);
    Config.WriteInteger('Setup', 'DogzLevel' + IntToStr(I), g_Config.DogzArray[I].nLevel);
  end;

{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'LimitSwordLong', g_Config.boLimitSwordLong);
  Config.WriteInteger('Setup', 'SwordLongPowerRate', g_Config.nSwordLongPowerRate);
  Config.WriteInteger('Setup', 'BoneFammCount', g_Config.nBoneFammCount);
  Config.WriteString('Names', 'BoneFamm', g_Config.sBoneFamm);
  Config.WriteInteger('Setup', 'DogzCount', g_Config.nDogzCount);
  Config.WriteString('Names', 'Dogz', g_Config.sDogz);
  Config.WriteInteger('Setup', 'FireBoomRage', g_Config.nFireBoomRage);
  Config.WriteInteger('Setup', 'SnowWindRange', g_Config.nSnowWindRange);
  Config.WriteInteger('Setup', 'ElecBlizzardRange', g_Config.nElecBlizzardRange);
  Config.WriteInteger('Setup', 'AmyOunsulPoint', g_Config.nAmyOunsulPoint);

  Config.WriteInteger('Setup', 'MagicAttackRage', g_Config.nMagicAttackRage);
  Config.WriteInteger('Setup', 'MagTurnUndeadLevel', g_Config.nMagTurnUndeadLevel);
  Config.WriteInteger('Setup', 'MagTammingLevel', g_Config.nMagTammingLevel);
  Config.WriteInteger('Setup', 'MagTammingTargetLevel', g_Config.nMagTammingTargetLevel);
  Config.WriteInteger('Setup', 'MagTammingTargetHPRate', g_Config.nMagTammingHPRate);
  Config.WriteInteger('Setup', 'MagTammingCount', g_Config.nMagTammingCount);

  Config.WriteInteger('Setup', 'MabMabeHitRandRate', g_Config.nMabMabeHitRandRate);
  Config.WriteInteger('Setup', 'MabMabeHitMinLvLimit', g_Config.nMabMabeHitMinLvLimit);
  Config.WriteInteger('Setup', 'MabMabeHitSucessRate', g_Config.nMabMabeHitSucessRate);
  Config.WriteInteger('Setup', 'MabMabeHitMabeTimeRate', g_Config.nMabMabeHitMabeTimeRate);

  Config.WriteBool('Setup', 'DisableInSafeZoneFireCross', g_Config.boDisableInSafeZoneFireCross);
  Config.WriteBool('Setup', 'GroupMbAttackPlayObject', g_Config.boGroupMbAttackPlayObject);

  Config.WriteBool('Setup', 'PullPlayObject', g_Config.boPullPlayObject);
  Config.WriteBool('Setup', 'PullCrossInSafeZone', g_Config.boPullCrossInSafeZone);

  Config.WriteBool('Setup', 'GroupMbAttackSlave', g_Config.boGroupMbAttackSlave);
  Config.WriteBool('Setup', 'DamageMP', g_Config.boPlayObjectReduceMP);


  Config.WriteInteger('Setup', 'MagicValidTimeRate', g_Config.nMagDelayTimeDoubly);
  Config.WriteInteger('Setup', 'MagicPowerRate', g_Config.nMagPowerDoubly);
  Config.WriteInteger('Setup', 'MagicDedingUseTime', g_Config.nDedingUseTime);

  Config.WriteBool('Setup', 'DedingAllowPK', g_Config.boDedingAllowPK);

  Config.WriteInteger('Setup', 'FireDelayTimeRate', g_Config.nFireDelayTimeRate);
  Config.WriteInteger('Setup', 'FirePowerRate', g_Config.nFirePowerRate);
  Config.WriteBool('Setup', 'ChangeMapFireExtinguish', g_Config.boChangeMapFireExtinguish);
  Config.WriteInteger('Setup', 'DidingPowerRate', g_Config.nDidingPowerRate);
  {分身术}
  if not g_Config.boAddMasterName then begin
    if g_Config.sCopyHumName = '' then begin
      Application.MessageBox('分身人物名称不能为空！！！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
  end;
  Config.WriteInteger('Setup', 'CopyHumanBagCount', g_Config.nCopyHumanBagCount);
  Config.WriteInteger('Setup', 'AllowCopyHumanCount', g_Config.nAllowCopyHumanCount);
  Config.WriteBool('Setup', 'AddMasterName', g_Config.boAddMasterName);
  Config.WriteString('Setup', 'CopyHumName', g_Config.sCopyHumName);
  Config.WriteInteger('Setup', 'CopyHumAddHPRate', g_Config.nCopyHumAddHPRate);
  Config.WriteInteger('Setup', 'CopyHumAddMPRate', g_Config.nCopyHumAddMPRate);
  Config.WriteString('Setup', 'CopyHumBagItems1', g_Config.sCopyHumBagItems1);
  Config.WriteString('Setup', 'CopyHumBagItems2', g_Config.sCopyHumBagItems2);
  Config.WriteString('Setup', 'CopyHumBagItems3', g_Config.sCopyHumBagItems3);
  Config.WriteBool('Setup', 'AllowGuardAttack', g_Config.boAllowGuardAttack);
  Config.WriteBool('Setup', 'AllowRecallSelf', g_Config.boAllowRecallSelf);


  Config.WriteInteger('Setup', 'WarrorAttackTime', g_Config.dwWarrorAttackTime);
  Config.WriteInteger('Setup', 'WizardAttackTime', g_Config.dwWizardAttackTime);
  Config.WriteInteger('Setup', 'TaoistAttackTime', g_Config.dwTaoistAttackTime);

  Config.WriteInteger('Setup', 'WarrorWalkTime', g_Config.dwWarrorWalkTime);
  Config.WriteInteger('Setup', 'WizardWalkTime', g_Config.dwWizardWalkTime);
  Config.WriteInteger('Setup', 'TaoistWalkTime', g_Config.dwTaoistWalkTime);



  Config.WriteBool('Setup', 'AllowReCallMobOtherHum', g_Config.boAllowReCallMobOtherHum);
  Config.WriteBool('Setup', 'NeedLevelHighTarget', g_Config.boNeedLevelHighTarget);

  Config.WriteInteger('Setup', 'Skill43DelayTime', g_Config.nSkill43DelayTime);
  Config.WriteInteger('Setup', 'Skill50DelayTime', g_Config.nSkill50DelayTime);
  Config.WriteInteger('Setup', 'Skill58DelayTime', g_Config.nSkill58DelayTime);
  Config.WriteInteger('Setup', 'Skill43PowerRate', g_Config.nSkill43PowerRate);
  Config.WriteInteger('Setup', 'Skill58PowerRate', g_Config.nSkill58PowerRate);

  Config.WriteBool('Setup', 'AllowRecallDogz', g_Config.boAllowRecallDogz);
  Config.WriteBool('Setup', 'AllowRecallMoon', g_Config.boAllowRecallMoon);
  Config.WriteBool('Setup', 'AllowRecallAll', g_Config.boAllowRecallAll);

  Config.WriteBool('Setup', 'MonUseBagItem', g_Config.boMonUseBagItem);


  Config.WriteInteger('Setup', 'NewShieldUseRate', g_Config.nNewShieldUseRate);
  Config.WriteInteger('Setup', 'NewShieldDamageRate', g_Config.nNewShieldDamageRate);
  Config.WriteInteger('Setup', 'NewShieldWaitTime', g_Config.nNewShieldWaitTime);

  Config.WriteInteger('Setup', 'SpaceSkillDelayTime', g_Config.nSpaceSkillDelayTime);
  Config.WriteInteger('Setup', 'SpaceSkillKeepTime', g_Config.nSpaceSkillKeepTime);

  Config.WriteBool('Setup', 'NoAllowWarRangeUseSpaceSkill', g_Config.boNoAllowWarRangeUseSpaceSkill);
  Config.WriteBool('Setup', 'AllowSpaceOutAttack', g_Config.boAllowSpaceOutAttack);

  Config.WriteInteger('Setup', 'GroupFireCharmPowerRate', g_Config.nGroupFireCharmPowerRate);

  Config.WriteInteger('Setup', 'MagicMovePositionTime', g_Config.nMagicMovePositionTime);
  Config.WriteInteger('Setup', 'MagicMovePositionRate', g_Config.nMagicMovePositionRate);

  Config.WriteBool('Setup', 'NoHintMagicFail', g_Config.boNoHintMagicFail);
  Config.WriteBool('Setup', 'NoHintMagicOK', g_Config.boNoHintMagicOK);
  Config.WriteBool('Setup', 'NoHintMagicClose', g_Config.boNoHintMagicClose);

  Config.WriteInteger('Setup', 'SkillZRJFDelayTime', g_Config.nSkillZRJFDelayTime);
  Config.WriteInteger('Setup', 'Skill75PowerRate', g_Config.nSkill75PowerRate);
  Config.WriteInteger('Setup', 'Skill76PowerRate', g_Config.nSkill76PowerRate);
  Config.WriteInteger('Setup', 'Skill77PowerRate', g_Config.nSkill77PowerRate);


  Config.WriteInteger('Setup', 'MoonLowPowerRate', g_Config.nMoonLowPowerRate);
  Config.WriteInteger('Setup', 'MoonHighPowerRate', g_Config.nMoonHighPowerRate);

  Config.WriteBool('Setup', 'ChangeMapReleasePoison', g_Config.boChangeMapReleasePoison);


  Config.WriteInteger('Setup', 'SerieMagicTime', g_Config.nSerieMagicTime);

  for I := 0 to Length(g_Config.SerieMagicPowerRate) - 1 do begin
    Config.WriteInteger('Setup', 'SerieMagicPowerRate' + IntToStr(I), g_Config.SerieMagicPowerRate[I]);
  end;

  for I := 0 to Length(g_Config.SerieMagicBlasthitPowerRate) - 1 do begin
    Config.WriteInteger('Setup', 'SerieMagicBlasthitPowerRate' + IntToStr(I), g_Config.SerieMagicBlasthitPowerRate[I]);
  end;

  for I := 0 to Length(g_Config.SerieMagicAttackRange) - 1 do begin
    Config.WriteInteger('Setup', 'SerieMagicAttackRange' + IntToStr(I), g_Config.SerieMagicAttackRange[I]);
  end;

  for I := 0 to 11 do begin
    for II := 0 to 3 do begin
      Config.WriteInteger('Setup', 'SerieMagicBlasthitRate' + IntToStr(I) + '-' + IntToStr(II), g_Config.SerieMagicBlasthitRate[I, II]);
    end;
  end;
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.RefUpgradeWeapon();
begin
  ScrollBarUpgradeWeaponDCRate.Position := g_Config.nUpgradeWeaponDCRate;
  ScrollBarUpgradeWeaponDCTwoPointRate.Position := g_Config.nUpgradeWeaponDCTwoPointRate;
  ScrollBarUpgradeWeaponDCThreePointRate.Position := g_Config.nUpgradeWeaponDCThreePointRate;

  ScrollBarUpgradeWeaponMCRate.Position := g_Config.nUpgradeWeaponMCRate;
  ScrollBarUpgradeWeaponMCTwoPointRate.Position := g_Config.nUpgradeWeaponMCTwoPointRate;
  ScrollBarUpgradeWeaponMCThreePointRate.Position := g_Config.nUpgradeWeaponMCThreePointRate;

  ScrollBarUpgradeWeaponSCRate.Position := g_Config.nUpgradeWeaponSCRate;
  ScrollBarUpgradeWeaponSCTwoPointRate.Position := g_Config.nUpgradeWeaponSCTwoPointRate;
  ScrollBarUpgradeWeaponSCThreePointRate.Position := g_Config.nUpgradeWeaponSCThreePointRate;

  EditUpgradeWeaponMaxPoint.Value := g_Config.nUpgradeWeaponMaxPoint;
  EditUpgradeWeaponPrice.Value := g_Config.nUpgradeWeaponPrice;
  EditUPgradeWeaponGetBackTime.Value := g_Config.dwUPgradeWeaponGetBackTime div 1000;
  EditClearExpireUpgradeWeaponDays.Value := g_Config.nClearExpireUpgradeWeaponDays;

  CheckBoxDeleteUpgradeFailWeapon.Checked := g_Config.boDeleteUpgradeFailWeapon;
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponDCRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponDCRate.Position;
  EditUpgradeWeaponDCRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponDCRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponDCTwoPointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponDCTwoPointRate.Position;
  EditUpgradeWeaponDCTwoPointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponDCTwoPointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponDCThreePointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponDCThreePointRate.Position;
  EditUpgradeWeaponDCThreePointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponDCThreePointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponSCRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponSCRate.Position;
  EditUpgradeWeaponSCRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponSCRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponSCTwoPointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponSCTwoPointRate.Position;
  EditUpgradeWeaponSCTwoPointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponSCTwoPointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponSCThreePointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponSCThreePointRate.Position;
  EditUpgradeWeaponSCThreePointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponSCThreePointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponMCRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponMCRate.Position;
  EditUpgradeWeaponMCRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponMCRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponMCTwoPointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponMCTwoPointRate.Position;
  EditUpgradeWeaponMCTwoPointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponMCTwoPointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponMCThreePointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponMCThreePointRate.Position;
  EditUpgradeWeaponMCThreePointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponMCThreePointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.EditUpgradeWeaponMaxPointChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponMaxPoint := EditUpgradeWeaponMaxPoint.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditUpgradeWeaponPriceChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponPrice := EditUpgradeWeaponPrice.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditUnKnowNameChange(Sender: TObject);
var
  sUnKnowName: string;
begin
  if not boOpened then Exit;
  sUnKnowName := Trim(EditUnKnowName.Text);
  if sUnKnowName = '' then begin
    Exit;
  end;
  g_Config.sUnKnowName := sUnKnowName;
  ModValue();
end;

procedure TfrmFunctionConfig.EditUPgradeWeaponGetBackTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwUPgradeWeaponGetBackTime := EditUPgradeWeaponGetBackTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditClearExpireUpgradeWeaponDaysChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nClearExpireUpgradeWeaponDays := EditClearExpireUpgradeWeaponDays.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonUpgradeWeaponSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'UpgradeWeaponMaxPoint', g_Config.nUpgradeWeaponMaxPoint);
  Config.WriteInteger('Setup', 'UpgradeWeaponPrice', g_Config.nUpgradeWeaponPrice);
  Config.WriteInteger('Setup', 'ClearExpireUpgradeWeaponDays', g_Config.nClearExpireUpgradeWeaponDays);
  Config.WriteInteger('Setup', 'UPgradeWeaponGetBackTime', g_Config.dwUPgradeWeaponGetBackTime);

  Config.WriteInteger('Setup', 'UpgradeWeaponDCRate', g_Config.nUpgradeWeaponDCRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponDCTwoPointRate', g_Config.nUpgradeWeaponDCTwoPointRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponDCThreePointRate', g_Config.nUpgradeWeaponDCThreePointRate);

  Config.WriteInteger('Setup', 'UpgradeWeaponMCRate', g_Config.nUpgradeWeaponMCRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponMCTwoPointRate', g_Config.nUpgradeWeaponMCTwoPointRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponMCThreePointRate', g_Config.nUpgradeWeaponMCThreePointRate);

  Config.WriteInteger('Setup', 'UpgradeWeaponSCRate', g_Config.nUpgradeWeaponSCRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponSCTwoPointRate', g_Config.nUpgradeWeaponSCTwoPointRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponSCThreePointRate', g_Config.nUpgradeWeaponSCThreePointRate);

  Config.WriteBool('Setup', 'DeleteUpgradeFailWeapon', g_Config.boDeleteUpgradeFailWeapon);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ButtonUpgradeWeaponDefaulfClick(
  Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then begin
    Exit;
  end;
  g_Config.nUpgradeWeaponMaxPoint := 20;
  g_Config.nUpgradeWeaponPrice := 10000;
  g_Config.nClearExpireUpgradeWeaponDays := 8;
  g_Config.dwUPgradeWeaponGetBackTime := 60 * 60 * 1000;

  g_Config.nUpgradeWeaponDCRate := 100;
  g_Config.nUpgradeWeaponDCTwoPointRate := 30;
  g_Config.nUpgradeWeaponDCThreePointRate := 200;

  g_Config.nUpgradeWeaponMCRate := 100;
  g_Config.nUpgradeWeaponMCTwoPointRate := 30;
  g_Config.nUpgradeWeaponMCThreePointRate := 200;

  g_Config.nUpgradeWeaponSCRate := 100;
  g_Config.nUpgradeWeaponSCTwoPointRate := 30;
  g_Config.nUpgradeWeaponSCThreePointRate := 200;
  RefUpgradeWeapon();
end;

procedure TfrmFunctionConfig.EditMasterOKLevelChange(Sender: TObject);
begin
  if EditMasterOKLevel.Text = '' then begin
    EditMasterOKLevel.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nMasterOKLevel := EditMasterOKLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterOKCreditPointChange(
  Sender: TObject);
begin
  if EditMasterOKCreditPoint.Text = '' then begin
    EditMasterOKCreditPoint.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nMasterOKCreditPoint := EditMasterOKCreditPoint.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterOKBonusPointChange(Sender: TObject);
begin
  if EditMasterOKBonusPoint.Text = '' then begin
    EditMasterOKBonusPoint.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nMasterOKBonusPoint := EditMasterOKBonusPoint.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonMasterSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'MasterOKLevel', g_Config.nMasterOKLevel);
  Config.WriteInteger('Setup', 'MasterOKCreditPoint', g_Config.nMasterOKCreditPoint);
  Config.WriteInteger('Setup', 'MasterOKBonusPoint', g_Config.nMasterOKBonusPoint);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ButtonMakeMineSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'MakeMineHitRate', g_Config.nMakeMineHitRate);
  Config.WriteInteger('Setup', 'MakeMineRate', g_Config.nMakeMineRate);
  Config.WriteInteger('Setup', 'StoneTypeRate', g_Config.nStoneTypeRate);
  Config.WriteInteger('Setup', 'StoneTypeRateMin', g_Config.nStoneTypeRateMin);
  Config.WriteInteger('Setup', 'GoldStoneMin', g_Config.nGoldStoneMin);
  Config.WriteInteger('Setup', 'GoldStoneMax', g_Config.nGoldStoneMax);
  Config.WriteInteger('Setup', 'SilverStoneMin', g_Config.nSilverStoneMin);
  Config.WriteInteger('Setup', 'SilverStoneMax', g_Config.nSilverStoneMax);
  Config.WriteInteger('Setup', 'SteelStoneMin', g_Config.nSteelStoneMin);
  Config.WriteInteger('Setup', 'SteelStoneMax', g_Config.nSteelStoneMax);
  Config.WriteInteger('Setup', 'BlackStoneMin', g_Config.nBlackStoneMin);
  Config.WriteInteger('Setup', 'BlackStoneMax', g_Config.nBlackStoneMax);
  Config.WriteInteger('Setup', 'StoneMinDura', g_Config.nStoneMinDura);
  Config.WriteInteger('Setup', 'StoneGeneralDuraRate', g_Config.nStoneGeneralDuraRate);
  Config.WriteInteger('Setup', 'StoneAddDuraRate', g_Config.nStoneAddDuraRate);
  Config.WriteInteger('Setup', 'StoneAddDuraMax', g_Config.nStoneAddDuraMax);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ButtonMakeMineDefaultClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then begin
    Exit;
  end;
  g_Config.nMakeMineHitRate := 4;
  g_Config.nMakeMineRate := 12;
  g_Config.nStoneTypeRate := 120;
  g_Config.nStoneTypeRateMin := 56;
  g_Config.nGoldStoneMin := 1;
  g_Config.nGoldStoneMax := 2;
  g_Config.nSilverStoneMin := 3;
  g_Config.nSilverStoneMax := 20;
  g_Config.nSteelStoneMin := 21;
  g_Config.nSteelStoneMax := 45;
  g_Config.nBlackStoneMin := 46;
  g_Config.nBlackStoneMax := 56;
  g_Config.nStoneMinDura := 3000;
  g_Config.nStoneGeneralDuraRate := 13000;
  g_Config.nStoneAddDuraRate := 20;
  g_Config.nStoneAddDuraMax := 10000;
  RefMakeMine();
end;

procedure TfrmFunctionConfig.RefMakeMine();
begin
  ScrollBarMakeMineHitRate.Position := g_Config.nMakeMineHitRate;
  ScrollBarMakeMineHitRate.Min := 0;
  ScrollBarMakeMineHitRate.Max := 10;

  ScrollBarMakeMineRate.Position := g_Config.nMakeMineRate;
  ScrollBarMakeMineRate.Min := 0;
  ScrollBarMakeMineRate.Max := 50;

  ScrollBarStoneTypeRate.Position := g_Config.nStoneTypeRate;
  ScrollBarStoneTypeRate.Min := g_Config.nStoneTypeRateMin;
  ScrollBarStoneTypeRate.Max := 500;

  ScrollBarGoldStoneMax.Min := 1;
  ScrollBarGoldStoneMax.Max := g_Config.nSilverStoneMax;

  ScrollBarSilverStoneMax.Min := g_Config.nGoldStoneMax;
  ScrollBarSilverStoneMax.Max := g_Config.nSteelStoneMax;

  ScrollBarSteelStoneMax.Min := g_Config.nSilverStoneMax;
  ScrollBarSteelStoneMax.Max := g_Config.nBlackStoneMax;

  ScrollBarBlackStoneMax.Min := g_Config.nSteelStoneMax;
  ScrollBarBlackStoneMax.Max := g_Config.nStoneTypeRate;

  ScrollBarGoldStoneMax.Position := g_Config.nGoldStoneMax;
  ScrollBarSilverStoneMax.Position := g_Config.nSilverStoneMax;
  ScrollBarSteelStoneMax.Position := g_Config.nSteelStoneMax;
  ScrollBarBlackStoneMax.Position := g_Config.nBlackStoneMax;

  EditStoneMinDura.Value := g_Config.nStoneMinDura div 1000;
  EditStoneGeneralDuraRate.Value := g_Config.nStoneGeneralDuraRate div 1000;
  EditStoneAddDuraRate.Value := g_Config.nStoneAddDuraRate;
  EditStoneAddDuraMax.Value := g_Config.nStoneAddDuraMax div 1000;
end;

procedure TfrmFunctionConfig.ScrollBarMakeMineHitRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarMakeMineHitRate.Position;
  EditMakeMineHitRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nMakeMineHitRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarMakeMineRateChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarMakeMineRate.Position;
  EditMakeMineRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nMakeMineRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarStoneTypeRateChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarStoneTypeRate.Position;
  EditStoneTypeRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  ScrollBarBlackStoneMax.Max := nPostion;
  g_Config.nStoneTypeRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarGoldStoneMaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarGoldStoneMax.Position;
  EditGoldStoneMax.Text := IntToStr(g_Config.nGoldStoneMin) + '-' + IntToStr(g_Config.nGoldStoneMax);
  if not boOpened then Exit;
  g_Config.nSilverStoneMin := nPostion + 1;
  ScrollBarSilverStoneMax.Min := nPostion + 1;
  g_Config.nGoldStoneMax := nPostion;
  EditSilverStoneMax.Text := IntToStr(g_Config.nSilverStoneMin) + '-' + IntToStr(g_Config.nSilverStoneMax);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarSilverStoneMaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarSilverStoneMax.Position;
  EditSilverStoneMax.Text := IntToStr(g_Config.nSilverStoneMin) + '-' + IntToStr(g_Config.nSilverStoneMax);
  if not boOpened then Exit;
  ScrollBarGoldStoneMax.Max := nPostion - 1;
  g_Config.nSteelStoneMin := nPostion + 1;
  ScrollBarSteelStoneMax.Min := nPostion + 1;
  g_Config.nSilverStoneMax := nPostion;
  EditGoldStoneMax.Text := IntToStr(g_Config.nGoldStoneMin) + '-' + IntToStr(g_Config.nGoldStoneMax);
  EditSteelStoneMax.Text := IntToStr(g_Config.nSteelStoneMin) + '-' + IntToStr(g_Config.nSteelStoneMax);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarSteelStoneMaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarSteelStoneMax.Position;
  EditSteelStoneMax.Text := IntToStr(g_Config.nSteelStoneMin) + '-' + IntToStr(g_Config.nSteelStoneMax);
  if not boOpened then Exit;
  ScrollBarSilverStoneMax.Max := nPostion - 1;
  g_Config.nBlackStoneMin := nPostion + 1;
  ScrollBarBlackStoneMax.Min := nPostion + 1;
  g_Config.nSteelStoneMax := nPostion;
  EditSilverStoneMax.Text := IntToStr(g_Config.nSilverStoneMin) + '-' + IntToStr(g_Config.nSilverStoneMax);
  EditBlackStoneMax.Text := IntToStr(g_Config.nBlackStoneMin) + '-' + IntToStr(g_Config.nBlackStoneMax);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarBlackStoneMaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarBlackStoneMax.Position;
  EditBlackStoneMax.Text := IntToStr(g_Config.nBlackStoneMin) + '-' + IntToStr(g_Config.nBlackStoneMax);
  if not boOpened then Exit;
  ScrollBarSteelStoneMax.Max := nPostion - 1;
  ScrollBarStoneTypeRate.Min := nPostion;
  g_Config.nBlackStoneMax := nPostion;
  EditSteelStoneMax.Text := IntToStr(g_Config.nSteelStoneMin) + '-' + IntToStr(g_Config.nSteelStoneMax);
  ModValue();
end;

procedure TfrmFunctionConfig.EditStoneMinDuraChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStoneMinDura := EditStoneMinDura.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStoneGeneralDuraRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStoneGeneralDuraRate := EditStoneGeneralDuraRate.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStoneAddDuraRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStoneAddDuraRate := EditStoneAddDuraRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStoneAddDuraMaxChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStoneAddDuraMax := EditStoneAddDuraMax.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.RefWinLottery;
begin
  ScrollBarWinLotteryRate.Max := 100000;
  ScrollBarWinLotteryRate.Position := g_Config.nWinLotteryRate;
  ScrollBarWinLottery1Max.Max := g_Config.nWinLotteryRate;
  ScrollBarWinLottery1Max.Min := g_Config.nWinLottery1Min;
  ScrollBarWinLottery2Max.Max := g_Config.nWinLottery1Max;
  ScrollBarWinLottery2Max.Min := g_Config.nWinLottery2Min;
  ScrollBarWinLottery3Max.Max := g_Config.nWinLottery2Max;
  ScrollBarWinLottery3Max.Min := g_Config.nWinLottery3Min;
  ScrollBarWinLottery4Max.Max := g_Config.nWinLottery3Max;
  ScrollBarWinLottery4Max.Min := g_Config.nWinLottery4Min;
  ScrollBarWinLottery5Max.Max := g_Config.nWinLottery4Max;
  ScrollBarWinLottery5Max.Min := g_Config.nWinLottery5Min;
  ScrollBarWinLottery6Max.Max := g_Config.nWinLottery5Max;
  ScrollBarWinLottery6Max.Min := g_Config.nWinLottery6Min;
  ScrollBarWinLotteryRate.Min := g_Config.nWinLottery1Max;

  ScrollBarWinLottery1Max.Position := g_Config.nWinLottery1Max;
  ScrollBarWinLottery2Max.Position := g_Config.nWinLottery2Max;
  ScrollBarWinLottery3Max.Position := g_Config.nWinLottery3Max;
  ScrollBarWinLottery4Max.Position := g_Config.nWinLottery4Max;
  ScrollBarWinLottery5Max.Position := g_Config.nWinLottery5Max;
  ScrollBarWinLottery6Max.Position := g_Config.nWinLottery6Max;

  EditWinLottery1Gold.Value := g_Config.nWinLottery1Gold;
  EditWinLottery2Gold.Value := g_Config.nWinLottery2Gold;
  EditWinLottery3Gold.Value := g_Config.nWinLottery3Gold;
  EditWinLottery4Gold.Value := g_Config.nWinLottery4Gold;
  EditWinLottery5Gold.Value := g_Config.nWinLottery5Gold;
  EditWinLottery6Gold.Value := g_Config.nWinLottery6Gold;
end;

procedure TfrmFunctionConfig.ButtonWinLotterySaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'WinLottery1Gold', g_Config.nWinLottery1Gold);
  Config.WriteInteger('Setup', 'WinLottery2Gold', g_Config.nWinLottery2Gold);
  Config.WriteInteger('Setup', 'WinLottery3Gold', g_Config.nWinLottery3Gold);
  Config.WriteInteger('Setup', 'WinLottery4Gold', g_Config.nWinLottery4Gold);
  Config.WriteInteger('Setup', 'WinLottery5Gold', g_Config.nWinLottery5Gold);
  Config.WriteInteger('Setup', 'WinLottery6Gold', g_Config.nWinLottery6Gold);
  Config.WriteInteger('Setup', 'WinLottery1Min', g_Config.nWinLottery1Min);
  Config.WriteInteger('Setup', 'WinLottery1Max', g_Config.nWinLottery1Max);
  Config.WriteInteger('Setup', 'WinLottery2Min', g_Config.nWinLottery2Min);
  Config.WriteInteger('Setup', 'WinLottery2Max', g_Config.nWinLottery2Max);
  Config.WriteInteger('Setup', 'WinLottery3Min', g_Config.nWinLottery3Min);
  Config.WriteInteger('Setup', 'WinLottery3Max', g_Config.nWinLottery3Max);
  Config.WriteInteger('Setup', 'WinLottery4Min', g_Config.nWinLottery4Min);
  Config.WriteInteger('Setup', 'WinLottery4Max', g_Config.nWinLottery4Max);
  Config.WriteInteger('Setup', 'WinLottery5Min', g_Config.nWinLottery5Min);
  Config.WriteInteger('Setup', 'WinLottery5Max', g_Config.nWinLottery5Max);
  Config.WriteInteger('Setup', 'WinLottery6Min', g_Config.nWinLottery6Min);
  Config.WriteInteger('Setup', 'WinLottery6Max', g_Config.nWinLottery6Max);
  Config.WriteInteger('Setup', 'WinLotteryRate', g_Config.nWinLotteryRate);


{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ButtonWinLotteryDefaultClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then begin
    Exit;
  end;


  g_Config.nWinLottery1Gold := 1000000;
  g_Config.nWinLottery2Gold := 200000;
  g_Config.nWinLottery3Gold := 100000;
  g_Config.nWinLottery4Gold := 10000;
  g_Config.nWinLottery5Gold := 1000;
  g_Config.nWinLottery6Gold := 500;
  g_Config.nWinLottery6Min := 1;
  g_Config.nWinLottery6Max := 4999;
  g_Config.nWinLottery5Min := 14000;
  g_Config.nWinLottery5Max := 15999;
  g_Config.nWinLottery4Min := 16000;
  g_Config.nWinLottery4Max := 16149;
  g_Config.nWinLottery3Min := 16150;
  g_Config.nWinLottery3Max := 16169;
  g_Config.nWinLottery2Min := 16170;
  g_Config.nWinLottery2Max := 16179;
  g_Config.nWinLottery1Min := 16180;
  g_Config.nWinLottery1Max := 16185;
  g_Config.nWinLotteryRate := 30000;
  RefWinLottery();
end;

procedure TfrmFunctionConfig.EditWinLottery1GoldChange(Sender: TObject);
begin
  if EditWinLottery1Gold.Text = '' then begin
    EditWinLottery1Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery1Gold := EditWinLottery1Gold.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditWinLottery2GoldChange(Sender: TObject);
begin
  if EditWinLottery2Gold.Text = '' then begin
    EditWinLottery2Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery2Gold := EditWinLottery2Gold.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditWinLottery3GoldChange(Sender: TObject);
begin
  if EditWinLottery3Gold.Text = '' then begin
    EditWinLottery3Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery3Gold := EditWinLottery3Gold.Value;
  ModValue();

end;

procedure TfrmFunctionConfig.EditWinLottery4GoldChange(Sender: TObject);
begin
  if EditWinLottery4Gold.Text = '' then begin
    EditWinLottery4Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery4Gold := EditWinLottery4Gold.Value;
  ModValue();

end;

procedure TfrmFunctionConfig.EditWinLottery5GoldChange(Sender: TObject);
begin
  if EditWinLottery5Gold.Text = '' then begin
    EditWinLottery5Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery5Gold := EditWinLottery5Gold.Value;
  ModValue();

end;

procedure TfrmFunctionConfig.EditWinLottery6GoldChange(Sender: TObject);
begin
  if EditWinLottery6Gold.Text = '' then begin
    EditWinLottery6Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery6Gold := EditWinLottery6Gold.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery1MaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery1Max.Position;
  EditWinLottery1Max.Text := IntToStr(g_Config.nWinLottery1Min) + '-' + IntToStr(g_Config.nWinLottery1Max);
  if not boOpened then Exit;
  g_Config.nWinLottery1Max := nPostion;
  ScrollBarWinLottery2Max.Max := nPostion - 1;
  ScrollBarWinLotteryRate.Min := nPostion;
  EditWinLottery1Max.Text := IntToStr(g_Config.nWinLottery1Min) + '-' + IntToStr(g_Config.nWinLottery1Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery2MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery2Max.Position;
  EditWinLottery2Max.Text := IntToStr(g_Config.nWinLottery2Min) + '-' + IntToStr(g_Config.nWinLottery2Max);
  if not boOpened then Exit;
  g_Config.nWinLottery1Min := nPostion + 1;
  ScrollBarWinLottery1Max.Min := nPostion + 1;
  g_Config.nWinLottery2Max := nPostion;
  EditWinLottery2Max.Text := IntToStr(g_Config.nWinLottery2Min) + '-' + IntToStr(g_Config.nWinLottery2Max);
  EditWinLottery1Max.Text := IntToStr(g_Config.nWinLottery1Min) + '-' + IntToStr(g_Config.nWinLottery1Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery3MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery3Max.Position;
  EditWinLottery3Max.Text := IntToStr(g_Config.nWinLottery3Min) + '-' + IntToStr(g_Config.nWinLottery3Max);
  if not boOpened then Exit;
  g_Config.nWinLottery2Min := nPostion + 1;
  ScrollBarWinLottery2Max.Min := nPostion + 1;
  g_Config.nWinLottery3Max := nPostion;
  EditWinLottery3Max.Text := IntToStr(g_Config.nWinLottery3Min) + '-' + IntToStr(g_Config.nWinLottery3Max);
  EditWinLottery2Max.Text := IntToStr(g_Config.nWinLottery2Min) + '-' + IntToStr(g_Config.nWinLottery2Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery4MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery4Max.Position;
  EditWinLottery4Max.Text := IntToStr(g_Config.nWinLottery4Min) + '-' + IntToStr(g_Config.nWinLottery4Max);
  if not boOpened then Exit;
  g_Config.nWinLottery3Min := nPostion + 1;
  ScrollBarWinLottery3Max.Min := nPostion + 1;
  g_Config.nWinLottery4Max := nPostion;
  EditWinLottery4Max.Text := IntToStr(g_Config.nWinLottery4Min) + '-' + IntToStr(g_Config.nWinLottery4Max);
  EditWinLottery3Max.Text := IntToStr(g_Config.nWinLottery3Min) + '-' + IntToStr(g_Config.nWinLottery3Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery5MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery5Max.Position;
  EditWinLottery5Max.Text := IntToStr(g_Config.nWinLottery5Min) + '-' + IntToStr(g_Config.nWinLottery5Max);
  if not boOpened then Exit;
  g_Config.nWinLottery4Min := nPostion + 1;
  ScrollBarWinLottery4Max.Min := nPostion + 1;
  g_Config.nWinLottery5Max := nPostion;
  EditWinLottery5Max.Text := IntToStr(g_Config.nWinLottery5Min) + '-' + IntToStr(g_Config.nWinLottery5Max);
  EditWinLottery4Max.Text := IntToStr(g_Config.nWinLottery4Min) + '-' + IntToStr(g_Config.nWinLottery4Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery6MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery6Max.Position;
  EditWinLottery6Max.Text := IntToStr(g_Config.nWinLottery6Min) + '-' + IntToStr(g_Config.nWinLottery6Max);
  if not boOpened then Exit;
  g_Config.nWinLottery5Min := nPostion + 1;
  ScrollBarWinLottery5Max.Min := nPostion + 1;
  g_Config.nWinLottery6Max := nPostion;
  EditWinLottery6Max.Text := IntToStr(g_Config.nWinLottery6Min) + '-' + IntToStr(g_Config.nWinLottery6Max);
  EditWinLottery5Max.Text := IntToStr(g_Config.nWinLottery5Min) + '-' + IntToStr(g_Config.nWinLottery5Max);
  ModValue();

end;

procedure TfrmFunctionConfig.ScrollBarWinLotteryRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLotteryRate.Position;
  EditWinLotteryRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  ScrollBarWinLottery1Max.Max := nPostion;
  g_Config.nWinLotteryRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.RefReNewLevelConf();
begin
  EditReNewNameColor1.Value := g_Config.ReNewNameColor[0];
  EditReNewNameColor2.Value := g_Config.ReNewNameColor[1];
  EditReNewNameColor3.Value := g_Config.ReNewNameColor[2];
  EditReNewNameColor4.Value := g_Config.ReNewNameColor[3];
  EditReNewNameColor5.Value := g_Config.ReNewNameColor[4];
  EditReNewNameColor6.Value := g_Config.ReNewNameColor[5];
  EditReNewNameColor7.Value := g_Config.ReNewNameColor[6];
  EditReNewNameColor8.Value := g_Config.ReNewNameColor[7];
  EditReNewNameColor9.Value := g_Config.ReNewNameColor[8];
  EditReNewNameColor10.Value := g_Config.ReNewNameColor[9];
  EditReNewNameColorTime.Value := g_Config.dwReNewNameColorTime div 1000;
  CheckBoxReNewChangeColor.Checked := g_Config.boReNewChangeColor;
  CheckBoxReNewLevelClearExp.Checked := g_Config.boReNewLevelClearExp;
end;

procedure TfrmFunctionConfig.ButtonReNewLevelSaveClick(Sender: TObject);
{$IF SoftVersion <> VERDEMO}
var
  I: Integer;
{$IFEND}
begin
{$IF SoftVersion <> VERDEMO}
  for I := Low(g_Config.ReNewNameColor) to High(g_Config.ReNewNameColor) do begin
    Config.WriteInteger('Setup', 'ReNewNameColor' + IntToStr(I), g_Config.ReNewNameColor[I]);
  end;
  Config.WriteInteger('Setup', 'ReNewNameColorTime', g_Config.dwReNewNameColorTime);
  Config.WriteBool('Setup', 'ReNewChangeColor', g_Config.boReNewChangeColor);
  Config.WriteBool('Setup', 'ReNewLevelClearExp', g_Config.boReNewLevelClearExp);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor1Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor1.Value;
  LabelReNewNameColor1.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[0] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor2Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor2.Value;
  LabelReNewNameColor2.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[1] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor3Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor3.Value;
  LabelReNewNameColor3.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[2] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor4Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor4.Value;
  LabelReNewNameColor4.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[3] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor5Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor5.Value;
  LabelReNewNameColor5.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[4] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor6Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor6.Value;
  LabelReNewNameColor6.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[5] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor7Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor7.Value;
  LabelReNewNameColor7.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[6] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor8Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor8.Value;
  LabelReNewNameColor8.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[7] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor9Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor9.Value;
  LabelReNewNameColor9.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[8] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor10Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor10.Value;
  LabelReNewNameColor10.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[9] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColorTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwReNewNameColorTime := EditReNewNameColorTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.RefMonUpgrade();
begin
  EditMonUpgradeColor1.Value := g_Config.SlaveColor[0];
  EditMonUpgradeColor2.Value := g_Config.SlaveColor[1];
  EditMonUpgradeColor3.Value := g_Config.SlaveColor[2];
  EditMonUpgradeColor4.Value := g_Config.SlaveColor[3];
  EditMonUpgradeColor5.Value := g_Config.SlaveColor[4];
  EditMonUpgradeColor6.Value := g_Config.SlaveColor[5];
  EditMonUpgradeColor7.Value := g_Config.SlaveColor[6];
  EditMonUpgradeColor8.Value := g_Config.SlaveColor[7];
  EditMonUpgradeColor9.Value := g_Config.SlaveColor[8];
  EditMonUpgradeKillCount1.Value := g_Config.MonUpLvNeedKillCount[0];
  EditMonUpgradeKillCount2.Value := g_Config.MonUpLvNeedKillCount[1];
  EditMonUpgradeKillCount3.Value := g_Config.MonUpLvNeedKillCount[2];
  EditMonUpgradeKillCount4.Value := g_Config.MonUpLvNeedKillCount[3];
  EditMonUpgradeKillCount5.Value := g_Config.MonUpLvNeedKillCount[4];
  EditMonUpgradeKillCount6.Value := g_Config.MonUpLvNeedKillCount[5];
  EditMonUpgradeKillCount7.Value := g_Config.MonUpLvNeedKillCount[6];
  EditMonUpLvNeedKillBase.Value := g_Config.nMonUpLvNeedKillBase;
  EditMonUpLvRate.Value := g_Config.nMonUpLvRate;

  CheckBoxMasterDieMutiny.Checked := g_Config.boMasterDieMutiny;
  EditMasterDieMutinyRate.Value := g_Config.nMasterDieMutinyRate;
  EditMasterDieMutinyPower.Value := g_Config.nMasterDieMutinyPower;
  EditMasterDieMutinySpeed.Value := g_Config.nMasterDieMutinySpeed;

  CheckBoxMasterDieMutinyClick(CheckBoxMasterDieMutiny);

  CheckBoxBBMonAutoChangeColor.Checked := g_Config.boBBMonAutoChangeColor;
  EditBBMonAutoChangeColorTime.Value := g_Config.dwBBMonAutoChangeColorTime div 1000;
end;

procedure TfrmFunctionConfig.ButtonMonUpgradeSaveClick(Sender: TObject);
{$IF SoftVersion <> VERDEMO}
var
  I: Integer;
{$IFEND}
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'MonUpLvNeedKillBase', g_Config.nMonUpLvNeedKillBase);
  Config.WriteInteger('Setup', 'MonUpLvRate', g_Config.nMonUpLvRate);
  for I := Low(g_Config.MonUpLvNeedKillCount) to High(g_Config.MonUpLvNeedKillCount) do begin
    Config.WriteInteger('Setup', 'MonUpLvNeedKillCount' + IntToStr(I), g_Config.MonUpLvNeedKillCount[I]);
  end;

  for I := Low(g_Config.SlaveColor) to High(g_Config.SlaveColor) do begin
    Config.WriteInteger('Setup', 'SlaveColor' + IntToStr(I), g_Config.SlaveColor[I]);
  end;
  Config.WriteBool('Setup', 'MasterDieMutiny', g_Config.boMasterDieMutiny);
  Config.WriteInteger('Setup', 'MasterDieMutinyRate', g_Config.nMasterDieMutinyRate);
  Config.WriteInteger('Setup', 'MasterDieMutinyPower', g_Config.nMasterDieMutinyPower);
  Config.WriteInteger('Setup', 'MasterDieMutinyPower', g_Config.nMasterDieMutinySpeed);

  Config.WriteBool('Setup', 'BBMonAutoChangeColor', g_Config.boBBMonAutoChangeColor);
  Config.WriteInteger('Setup', 'BBMonAutoChangeColorTime', g_Config.dwBBMonAutoChangeColorTime);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor1Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor1.Value;
  LabelMonUpgradeColor1.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[0] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor2Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor2.Value;
  LabelMonUpgradeColor2.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[1] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor3Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor3.Value;
  LabelMonUpgradeColor3.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[2] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor4Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor4.Value;
  LabelMonUpgradeColor4.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[3] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor5Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor5.Value;
  LabelMonUpgradeColor5.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[4] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor6Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor6.Value;
  LabelMonUpgradeColor6.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[5] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor7Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor7.Value;
  LabelMonUpgradeColor7.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[6] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor8Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor8.Value;
  LabelMonUpgradeColor8.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[7] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor9Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor9.Value;
  LabelMonUpgradeColor9.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[8] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxReNewChangeColorClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boReNewChangeColor := CheckBoxReNewChangeColor.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxReNewLevelClearExpClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boReNewLevelClearExp := CheckBoxReNewLevelClearExp.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditPKFlagNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditPKFlagNameColor.Value;
  LabelPKFlagNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btPKFlagNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditPKLevel1NameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditPKLevel1NameColor.Value;
  LabelPKLevel1NameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btPKLevel1NameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditPKLevel2NameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditPKLevel2NameColor.Value;
  LabelPKLevel2NameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btPKLevel2NameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditAllyAndGuildNameColorChange(
  Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditAllyAndGuildNameColor.Value;
  LabelAllyAndGuildNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btAllyAndGuildNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditWarGuildNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditWarGuildNameColor.Value;
  LabelWarGuildNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btWarGuildNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditInFreePKAreaNameColorChange(
  Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditInFreePKAreaNameColor.Value;
  LabelInFreePKAreaNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btInFreePKAreaNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount1Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[0] := EditMonUpgradeKillCount1.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount2Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[1] := EditMonUpgradeKillCount2.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount3Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[2] := EditMonUpgradeKillCount3.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount4Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[3] := EditMonUpgradeKillCount4.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount5Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[4] := EditMonUpgradeKillCount5.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount6Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[5] := EditMonUpgradeKillCount6.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount7Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[6] := EditMonUpgradeKillCount7.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpLvNeedKillBaseChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMonUpLvNeedKillBase := EditMonUpLvNeedKillBase.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpLvRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMonUpLvRate := EditMonUpLvRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxMasterDieMutinyClick(Sender: TObject);
begin
  if CheckBoxMasterDieMutiny.Checked then begin
    EditMasterDieMutinyRate.Enabled := True;
    EditMasterDieMutinyPower.Enabled := True;
    EditMasterDieMutinySpeed.Enabled := True;
  end else begin
    EditMasterDieMutinyRate.Enabled := False;
    EditMasterDieMutinyPower.Enabled := False;
    EditMasterDieMutinySpeed.Enabled := False;
  end;
  if not boOpened then Exit;
  g_Config.boMasterDieMutiny := CheckBoxMasterDieMutiny.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterDieMutinyRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMasterDieMutinyRate := EditMasterDieMutinyRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterDieMutinyPowerChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMasterDieMutinyPower := EditMasterDieMutinyPower.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterDieMutinySpeedChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMasterDieMutinySpeed := EditMasterDieMutinySpeed.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxBBMonAutoChangeColorClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boBBMonAutoChangeColor := CheckBoxBBMonAutoChangeColor.Checked;
  ModValue();
end;


procedure TfrmFunctionConfig.EditBBMonAutoChangeColorTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwBBMonAutoChangeColorTime := EditBBMonAutoChangeColorTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.RefSpiritMutiny();
begin
  CheckBoxSpiritMutiny.Checked := g_Config.boSpiritMutiny;
  EditSpiritMutinyTime.Value := g_Config.dwSpiritMutinyTime div (60 * 1000);
  EditSpiritPowerRate.Value := g_Config.nSpiritPowerRate;
  CheckBoxSpiritMutinyClick(CheckBoxSpiritMutiny);
end;

procedure TfrmFunctionConfig.ButtonSpiritMutinySaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'SpiritMutiny', g_Config.boSpiritMutiny);
  Config.WriteInteger('Setup', 'SpiritMutinyTime', g_Config.dwSpiritMutinyTime);
  Config.WriteInteger('Setup', 'SpiritPowerRate', g_Config.nSpiritPowerRate);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.CheckBoxSpiritMutinyClick(Sender: TObject);
begin
  if CheckBoxSpiritMutiny.Checked then begin
    EditSpiritMutinyTime.Enabled := True;
    //    EditSpiritPowerRate.Enabled:=True;
  end else begin
    EditSpiritMutinyTime.Enabled := False;
    EditSpiritPowerRate.Enabled := False;
  end;
  if not boOpened then Exit;
  g_Config.boSpiritMutiny := CheckBoxSpiritMutiny.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSpiritMutinyTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwSpiritMutinyTime := EditSpiritMutinyTime.Value * 60 * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSpiritPowerRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSpiritPowerRate := EditSpiritPowerRate.Value;
  ModValue();
end;




procedure TfrmFunctionConfig.EditMagTammingLevelChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagTammingLevel := EditMagTammingLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMagTammingTargetLevelChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagTammingTargetLevel := EditMagTammingTargetLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMagTammingHPRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagTammingHPRate := EditMagTammingHPRate.Value;
  ModValue();
end;


procedure TfrmFunctionConfig.EditTammingCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagTammingCount := EditTammingCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMabMabeHitRandRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMabMabeHitRandRate := EditMabMabeHitRandRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMabMabeHitMinLvLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMabMabeHitMinLvLimit := EditMabMabeHitMinLvLimit.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMabMabeHitSucessRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMabMabeHitSucessRate := EditMabMabeHitSucessRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMabMabeHitMabeTimeRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMabMabeHitMabeTimeRate := EditMabMabeHitMabeTimeRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.RefMonSayMsg;
begin
  CheckBoxMonSayMsg.Checked := g_Config.boMonSayMsg;
end;

procedure TfrmFunctionConfig.ButtonMonSayMsgSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'MonSayMsg', g_Config.boMonSayMsg);
{$IFEND}
  uModValue();
end;


procedure TfrmFunctionConfig.CheckBoxMonSayMsgClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boMonSayMsg := CheckBoxMonSayMsg.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.RefWeaponMakeLuck;
begin
  ScrollBarWeaponMakeUnLuckRate.Min := 1;
  ScrollBarWeaponMakeUnLuckRate.Max := 50;
  ScrollBarWeaponMakeUnLuckRate.Position := g_Config.nWeaponMakeUnLuckRate;

  ScrollBarWeaponMakeLuckPoint1.Min := 1;
  ScrollBarWeaponMakeLuckPoint1.Max := 10;
  ScrollBarWeaponMakeLuckPoint1.Position := g_Config.nWeaponMakeLuckPoint1;

  ScrollBarWeaponMakeLuckPoint2.Min := 1;
  ScrollBarWeaponMakeLuckPoint2.Max := 10;
  ScrollBarWeaponMakeLuckPoint2.Position := g_Config.nWeaponMakeLuckPoint2;

  ScrollBarWeaponMakeLuckPoint3.Min := 1;
  ScrollBarWeaponMakeLuckPoint3.Max := 10;
  ScrollBarWeaponMakeLuckPoint3.Position := g_Config.nWeaponMakeLuckPoint3;

  ScrollBarWeaponMakeLuckPoint2Rate.Min := 1;
  ScrollBarWeaponMakeLuckPoint2Rate.Max := 50;
  ScrollBarWeaponMakeLuckPoint2Rate.Position := g_Config.nWeaponMakeLuckPoint2Rate;

  ScrollBarWeaponMakeLuckPoint3Rate.Min := 1;
  ScrollBarWeaponMakeLuckPoint3Rate.Max := 50;
  ScrollBarWeaponMakeLuckPoint3Rate.Position := g_Config.nWeaponMakeLuckPoint3Rate;
end;

procedure TfrmFunctionConfig.ButtonWeaponMakeLuckDefaultClick(
  Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then begin
    Exit;
  end;
  g_Config.nWeaponMakeUnLuckRate := 20;
  g_Config.nWeaponMakeLuckPoint1 := 1;
  g_Config.nWeaponMakeLuckPoint2 := 3;
  g_Config.nWeaponMakeLuckPoint3 := 7;
  g_Config.nWeaponMakeLuckPoint2Rate := 6;
  g_Config.nWeaponMakeLuckPoint3Rate := 40;
  RefWeaponMakeLuck();
end;

procedure TfrmFunctionConfig.ButtonWeaponMakeLuckSaveClick(
  Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'WeaponMakeUnLuckRate', g_Config.nWeaponMakeUnLuckRate);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint1', g_Config.nWeaponMakeLuckPoint1);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint2', g_Config.nWeaponMakeLuckPoint2);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint3', g_Config.nWeaponMakeLuckPoint3);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint2Rate', g_Config.nWeaponMakeLuckPoint2Rate);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint3Rate', g_Config.nWeaponMakeLuckPoint3Rate);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeUnLuckRateChange(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeUnLuckRate.Position;
  EditWeaponMakeUnLuckRate.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeUnLuckRate := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint1Change(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint1.Position;
  EditWeaponMakeLuckPoint1.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeLuckPoint1 := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint2Change(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint2.Position;
  EditWeaponMakeLuckPoint2.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeLuckPoint2 := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint2RateChange(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint2Rate.Position;
  EditWeaponMakeLuckPoint2Rate.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeLuckPoint2Rate := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint3Change(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint3.Position;
  EditWeaponMakeLuckPoint3.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeLuckPoint3 := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint3RateChange(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint3Rate.Position;
  EditWeaponMakeLuckPoint3Rate.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeLuckPoint3Rate := nInteger;
  ModValue();
end;



procedure TfrmFunctionConfig.SpinEditSellOffCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUserSellOffCount := SpinEditSellOffCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditSellOffTaxChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUserSellOffTax := SpinEditSellOffTax.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonSellOffSaveClick(Sender: TObject);
begin
  Config.WriteInteger('Setup', 'SellOffCountLimit', g_Config.nUserSellOffCount);
  Config.WriteInteger('Setup', 'SellOffRate', g_Config.nUserSellOffTax);
  uModValue();
end;

procedure TfrmFunctionConfig.CheckBoxPullPlayObjectClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boPullPlayObject := CheckBoxPullPlayObject.Checked;
  CheckBoxPullCrossInSafeZone.Enabled := CheckBoxPullPlayObject.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxPlayObjectReduceMPClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boPlayObjectReduceMP := CheckBoxPlayObjectReduceMP.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxGroupMbAttackSlaveClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boGroupMbAttackSlave := CheckBoxGroupMbAttackSlave.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxItemNameClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boChangeUseItemNameByPlayName := CheckBoxItemName.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditItemNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sChangeUseItemName := Trim(EditItemName.Text);
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonChangeUseItemNameClick(Sender: TObject);
begin
  {if (not CheckBoxItemName.Checked) and (g_Config.sChangeUseItemName = '') then begin
    Application.MessageBox('请输入自定义前缀', '提示信息', MB_ICONQUESTION);
    Exit;
  end;}
  Config.WriteBool('Setup', 'ChangeUseItemNameByPlayName', g_Config.boChangeUseItemNameByPlayName);
  Config.WriteString('Setup', 'ChangeUseItemName', g_Config.sChangeUseItemName);
  uModValue();
end;

procedure TfrmFunctionConfig.SpinEditSkill39SecChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDedingUseTime := SpinEditSkill39Sec.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxDedingAllowPKClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boDedingAllowPK := CheckBoxDedingAllowPK.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxDeleteUpgradeFailWeaponClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boDeleteUpgradeFailWeapon := CheckBoxDeleteUpgradeFailWeapon.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditAllowCopyCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAllowCopyHumanCount := SpinEditAllowCopyCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditCopyHumNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sCopyHumName := EditCopyHumName.Text;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxMasterNameClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAddMasterName := CheckBoxMasterName.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditPickUpItemCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nCopyHumanBagCount := SpinEditPickUpItemCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditEatHPItemRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nCopyHumAddHPRate := SpinEditEatHPItemRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditEatMPItemRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nCopyHumAddMPRate := SpinEditEatMPItemRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditFireDelayTimeClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFireDelayTimeRate := SpinEditFireDelayTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditFirePowerClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFirePowerRate := SpinEditFirePower.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditBagItems1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sCopyHumBagItems1 := Trim(EditBagItems1.Text);
  ModValue();
end;

procedure TfrmFunctionConfig.EditBagItems2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sCopyHumBagItems2 := Trim(EditBagItems2.Text);
  ModValue();
end;

procedure TfrmFunctionConfig.EditBagItems3Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sCopyHumBagItems3 := Trim(EditBagItems3.Text);
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxAllowGuardAttackClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAllowGuardAttack := CheckBoxAllowGuardAttack.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.RefCopyHumConf;
begin
  SpinEditAllowCopyCount.Value := g_Config.nAllowCopyHumanCount;
  EditCopyHumName.Text := g_Config.sCopyHumName;
  CheckBoxMasterName.Checked := g_Config.boAddMasterName;
  SpinEditPickUpItemCount.Value := g_Config.nCopyHumanBagCount;
  SpinEditEatHPItemRate.Value := g_Config.nCopyHumAddHPRate;
  SpinEditEatMPItemRate.Value := g_Config.nCopyHumAddMPRate;
  EditBagItems1.Text := g_Config.sCopyHumBagItems1;
  EditBagItems2.Text := g_Config.sCopyHumBagItems2;
  EditBagItems3.Text := g_Config.sCopyHumBagItems3;
  CheckBoxAllowGuardAttack.Checked := g_Config.boAllowGuardAttack;
  SpinEditWarrorAttackTime.Value := g_Config.dwWarrorAttackTime;
  SpinEditWizardAttackTime.Value := g_Config.dwWizardAttackTime;
  SpinEditTaoistAttackTime.Value := g_Config.dwTaoistAttackTime;

  EditWarrorWalkTime.Value := g_Config.dwWarrorWalkTime;
  EditWizardWalkTime.Value := g_Config.dwWizardWalkTime;
  EditTaoistWalkTime.Value := g_Config.dwTaoistWalkTime;

  CheckBoxAllowReCallMobOtherHum.Checked := g_Config.boAllowReCallMobOtherHum;
  CheckBoxNeedLevelHighTarget.Checked := g_Config.boNeedLevelHighTarget;
  CheckBoxNeedLevelHighTarget.Enabled := g_Config.boAllowReCallMobOtherHum;
end;

procedure TfrmFunctionConfig.SpinEditWarrorAttackTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwWarrorAttackTime := SpinEditWarrorAttackTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditWizardAttackTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwWizardAttackTime := SpinEditWizardAttackTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditTaoistAttackTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwTaoistAttackTime := SpinEditTaoistAttackTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxAllowReCallMobOtherHumClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAllowReCallMobOtherHum := CheckBoxAllowReCallMobOtherHum.Checked;
  CheckBoxNeedLevelHighTarget.Enabled := g_Config.boAllowReCallMobOtherHum;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxNeedLevelHighTargetClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boNeedLevelHighTarget := CheckBoxNeedLevelHighTarget.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxPullCrossInSafeZoneClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boPullCrossInSafeZone := CheckBoxPullCrossInSafeZone.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxStartMapEventClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boStartMapEvent := CheckBoxStartMapEvent.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSkill43DelayTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill43DelayTime := EditSkill43DelayTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSkill58DelayTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill58DelayTime := EditSkill58DelayTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxAllowRecallSelfClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAllowRecallSelf := CheckBoxAllowRecallSelf.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.RadioButtonDogzClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if Sender = RadioButtonDogz then begin
    g_Config.boAllowRecallDogz := RadioButtonDogz.Checked;
    g_Config.boAllowRecallMoon := not g_Config.boAllowRecallDogz;
    RadioButtonMoon.Checked := g_Config.boAllowRecallMoon;
  end else
    if Sender = RadioButtonMoon then begin
    g_Config.boAllowRecallMoon := RadioButtonMoon.Checked;
    g_Config.boAllowRecallDogz := not g_Config.boAllowRecallMoon;
    RadioButtonDogz.Checked := g_Config.boAllowRecallDogz;
  end;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxRecallAllClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAllowRecallAll := CheckBoxRecallAll.Checked;
  RadioButtonDogz.Enabled := not g_Config.boAllowRecallAll;
  RadioButtonMoon.Enabled := not g_Config.boAllowRecallAll;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSkill50DelayTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill50DelayTime := EditSkill50DelayTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxBindItemNoDealClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boBindItemNoDeal := CheckBoxBindItemNoDeal.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxBindItemNoScatterClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boBindItemNoScatter := CheckBoxBindItemNoScatter.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxBindItemNoDropClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boBindItemNoDrop := CheckBoxBindItemNoDrop.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonSaveBindItemClick(Sender: TObject);
begin
  Config.WriteBool('Setup', 'BindItemNoDeal', g_Config.boBindItemNoDeal);
  Config.WriteBool('Setup', 'BindItemNoScatter', g_Config.boBindItemNoScatter);
  Config.WriteBool('Setup', 'BindItemNoDrop', g_Config.boBindItemNoDeal);
  Config.WriteBool('Setup', 'BindItemNoSellOff', g_Config.boBindItemNoSellOff);
  Config.WriteBool('Setup', 'BindItemNoPickUp', g_Config.boBindItemNoPickUp);
  uModValue();
end;

procedure TfrmFunctionConfig.CheckBoxCopyItemClearClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boCopyItemClear := CheckBoxCopyItemClear.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonClearCopyItemClick(Sender: TObject);
begin
  Config.WriteBool('Setup', 'CopyItemClear', g_Config.boCopyItemClear);
  Config.WriteInteger('Setup', 'ItemMaxStarCount', g_Config.nItemMaxStarCount);
  Config.WriteBool('Setup', 'CheckCanUpgradeStarItem', g_Config.boCheckCanUpgradeStarItem);
  uModValue();
end;

procedure TfrmFunctionConfig.CheckBoxBindItemNoSellOffClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boBindItemNoSellOff := CheckBoxBindItemNoSellOff.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxMonUseBagItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boMonUseBagItem := CheckBoxMonUseBagItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxHumUseBagItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHumUseBagItem := CheckBoxHumUseBagItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditNewShieldUseRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNewShieldUseRate := EditNewShieldUseRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditNewShieldDamageRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNewShieldDamageRate := EditNewShieldDamageRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditNewShieldWaitTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNewShieldWaitTime := EditNewShieldWaitTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditOpenStoreCheckLevelChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nOpenStoreCheckLevel := EditOpenStoreCheckLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSpaceSkillDelayTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSpaceSkillDelayTime := EditSpaceSkillDelayTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxNoAllowWarRangeUseSpaceSkillClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boNoAllowWarRangeUseSpaceSkill := CheckBoxNoAllowWarRangeUseSpaceSkill.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxAllowSpaceOutAttackClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAllowSpaceOutAttack := CheckBoxAllowSpaceOutAttack.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSpaceSkillKeepTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSpaceSkillKeepTime := EditSpaceSkillKeepTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditGroupFireCharmPowerRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nGroupFireCharmPowerRate := EditGroupFireCharmPowerRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMagicMovePositionTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagicMovePositionTime := EditMagicMovePositionTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMagicMovePositionRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagicMovePositionRate := EditMagicMovePositionRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxNoHintMagicFailClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boNoHintMagicFail := CheckBoxNoHintMagicFail.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxNoHintMagicOKClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boNoHintMagicOK := CheckBoxNoHintMagicOK.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSkillZRJFDelayTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkillZRJFDelayTime := EditSkillZRJFDelayTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSkill77PowerRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill77PowerRate := EditSkill77PowerRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSkill75PowerRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill75PowerRate := EditSkill75PowerRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSkill76PowerRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill76PowerRate := EditSkill76PowerRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxNoHintMagicCloseClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boNoHintMagicClose := CheckBoxNoHintMagicClose.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonSaveStoreClick(Sender: TObject);
begin
  Config.WriteBool('Setup', 'SafeCanStore', g_Config.boSafeCanStore);
  Config.WriteBool('Setup', 'OpenStoreGMMode', g_Config.boOpenStoreGMMode);
  Config.WriteBool('Setup', 'OpenStoreCheckLevel', g_Config.boOpenStoreCheckLevel);
  Config.WriteInteger('Setup', 'OpenStoreNeedCheckLevel', g_Config.nOpenStoreCheckLevel);
  uModValue();
end;

procedure TfrmFunctionConfig.CheckBoxSafeCanStoreClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boSafeCanStore := CheckBoxSafeCanStore.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxOpenStoreCheckLevelClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boOpenStoreCheckLevel := CheckBoxOpenStoreCheckLevel.Checked;
  EditOpenStoreCheckLevel.Enabled := CheckBoxOpenStoreCheckLevel.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxOpenStoreGMModeClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boOpenStoreGMMode := CheckBoxOpenStoreGMMode.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMoonHighPowerRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMoonHighPowerRate := EditMoonHighPowerRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMoonLowPowerRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMoonLowPowerRate := EditMoonLowPowerRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSkill58PowerRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill58PowerRate := EditSkill58PowerRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSkill43PowerRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill43PowerRate := EditSkill43PowerRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditDidingPowerRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDidingPowerRate := SpinEditDidingPowerRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStatusDelayTime1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.StatusDelayTime[1] := EditStatusDelayTime1.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStatusDelayTime2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.StatusDelayTime[2] := EditStatusDelayTime2.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditWarrorWalkTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwWarrorWalkTime := EditWarrorWalkTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditWizardWalkTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwWizardWalkTime := EditWizardWalkTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditTaoistWalkTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwTaoistWalkTime := EditTaoistWalkTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxChangeMapReleasePoisonClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boChangeMapReleasePoison := CheckBoxChangeMapReleasePoison.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxBindItemNoPickUpClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boBindItemNoPickUp := CheckBoxBindItemNoPickUp.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxGetRandomHomePointClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boGetRandomHomePoint := CheckBoxGetRandomHomePoint.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.ListBoxSerieMagicClick(Sender: TObject);
var
  nIndex: Integer;
  Magic: pTMagic;
begin
  if not boOpened then Exit;
  nIndex := ListBoxSerieMagic.ItemIndex;
  if nIndex >= 0 then begin
    GroupBoxSerie.Enabled := True;
    Magic := pTMagic(ListBoxSerieMagic.Items.Objects[nIndex]);
    nIndex := Magic.wMagicId - 100;
    if nIndex >= 0 then begin
      GroupBoxSerie.Caption := Magic.sMagicName;
      EditSerieMagicPowerRate.Value := g_Config.SerieMagicPowerRate[nIndex];
      EditSerieMagicBlasthitPowerRate.Value := g_Config.SerieMagicBlasthitPowerRate[nIndex];
      EditSerieMagicAttackRange.Value := g_Config.SerieMagicAttackRange[nIndex];
      EditSerieMagicBlasthitRate1.Value := g_Config.SerieMagicBlasthitRate[nIndex, 1];
      EditSerieMagicBlasthitRate2.Value := g_Config.SerieMagicBlasthitRate[nIndex, 2];
      EditSerieMagicBlasthitRate3.Value := g_Config.SerieMagicBlasthitRate[nIndex, 3];
      EditSerieMagicAttackRange.Enabled := Magic.wMagicId in [102, 103, 107, 111];
    end else begin
      GroupBoxSerie.Enabled := False;
    end;
  end else begin
    GroupBoxSerie.Enabled := False;
  end;
end;

procedure TfrmFunctionConfig.EditSerieMagicTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSerieMagicTime := EditSerieMagicTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSerieMagicPowerRateChange(
  Sender: TObject);
var
  nIndex: Integer;
  Magic: pTMagic;
begin
  if not boOpened then Exit;
  nIndex := ListBoxSerieMagic.ItemIndex;
  if nIndex >= 0 then begin
    Magic := pTMagic(ListBoxSerieMagic.Items.Objects[nIndex]);
    nIndex := Magic.wMagicId - 100;
    if nIndex >= 0 then begin
      g_Config.SerieMagicPowerRate[nIndex] := EditSerieMagicPowerRate.Value;
      //Config.SerieMagicAttackRange[nIndex] := EditSerieMagicAttackRange.Value;
      //Config.SerieMagicBlasthitRate[nIndex, 1] := EditSerieMagicBlasthitRate1.Value;
      //Config.SerieMagicBlasthitRate[nIndex, 2] := EditSerieMagicBlasthitRate2.Value;
      //Config.SerieMagicBlasthitRate[nIndex, 3] := EditSerieMagicBlasthitRate3.Value;
      ModValue();
    end;
  end;
end;

procedure TfrmFunctionConfig.EditSerieMagicAttackRangeChange(
  Sender: TObject);
var
  nIndex: Integer;
  Magic: pTMagic;
begin
  if not boOpened then Exit;
  nIndex := ListBoxSerieMagic.ItemIndex;
  if nIndex >= 0 then begin
    Magic := pTMagic(ListBoxSerieMagic.Items.Objects[nIndex]);
    nIndex := Magic.wMagicId - 100;
    if nIndex >= 0 then begin
      //Config.SerieMagicPowerRate[nIndex] := EditSerieMagicPowerRate.Value;
      g_Config.SerieMagicAttackRange[nIndex] := EditSerieMagicAttackRange.Value;
      //Config.SerieMagicBlasthitRate[nIndex, 1] := EditSerieMagicBlasthitRate1.Value;
      //Config.SerieMagicBlasthitRate[nIndex, 2] := EditSerieMagicBlasthitRate2.Value;
      //Config.SerieMagicBlasthitRate[nIndex, 3] := EditSerieMagicBlasthitRate3.Value;
      ModValue();
    end;
  end;
end;

procedure TfrmFunctionConfig.EditSerieMagicBlasthitRate1Change(
  Sender: TObject);
var
  nIndex: Integer;
  Magic: pTMagic;
begin
  if not boOpened then Exit;
  nIndex := ListBoxSerieMagic.ItemIndex;
  if nIndex >= 0 then begin
    Magic := pTMagic(ListBoxSerieMagic.Items.Objects[nIndex]);
    nIndex := Magic.wMagicId - 100;
    if nIndex >= 0 then begin
      //Config.SerieMagicPowerRate[nIndex] := EditSerieMagicPowerRate.Value;
      //Config.SerieMagicAttackRange[nIndex] := EditSerieMagicAttackRange.Value;
      g_Config.SerieMagicBlasthitRate[nIndex, 1] := EditSerieMagicBlasthitRate1.Value;
      //Config.SerieMagicBlasthitRate[nIndex, 2] := EditSerieMagicBlasthitRate2.Value;
      //Config.SerieMagicBlasthitRate[nIndex, 3] := EditSerieMagicBlasthitRate3.Value;
      ModValue();
    end;
  end;
end;

procedure TfrmFunctionConfig.EditSerieMagicBlasthitRate2Change(
  Sender: TObject);
var
  nIndex: Integer;
  Magic: pTMagic;
begin
  if not boOpened then Exit;
  nIndex := ListBoxSerieMagic.ItemIndex;
  if nIndex >= 0 then begin
    Magic := pTMagic(ListBoxSerieMagic.Items.Objects[nIndex]);
    nIndex := Magic.wMagicId - 100;
    if nIndex >= 0 then begin
      //g_Config.SerieMagicPowerRate[nIndex] := EditSerieMagicPowerRate.Value;
      //g_Config.SerieMagicAttackRange[nIndex] := EditSerieMagicAttackRange.Value;
      //g_Config.SerieMagicBlasthitRate[nIndex, 1] := EditSerieMagicBlasthitRate1.Value;
      g_Config.SerieMagicBlasthitRate[nIndex, 2] := EditSerieMagicBlasthitRate2.Value;
      //g_Config.SerieMagicBlasthitRate[nIndex, 3] := EditSerieMagicBlasthitRate3.Value;
      ModValue();
    end;
  end;
end;

procedure TfrmFunctionConfig.EditSerieMagicBlasthitRate3Change(
  Sender: TObject);
var
  nIndex: Integer;
  Magic: pTMagic;
begin
  if not boOpened then Exit;
  nIndex := ListBoxSerieMagic.ItemIndex;
  if nIndex >= 0 then begin
    Magic := pTMagic(ListBoxSerieMagic.Items.Objects[nIndex]);
    nIndex := Magic.wMagicId - 100;
    if nIndex >= 0 then begin
      //Config.SerieMagicPowerRate[nIndex] := EditSerieMagicPowerRate.Value;
      //Config.SerieMagicAttackRange[nIndex] := EditSerieMagicAttackRange.Value;
      //Config.SerieMagicBlasthitRate[nIndex, 1] := EditSerieMagicBlasthitRate1.Value;
      //Config.SerieMagicBlasthitRate[nIndex, 2] := EditSerieMagicBlasthitRate2.Value;
      g_Config.SerieMagicBlasthitRate[nIndex, 3] := EditSerieMagicBlasthitRate3.Value;
      ModValue();
    end;
  end;
end;

procedure TfrmFunctionConfig.EditSerieMagicBlasthitPowerRateChange(Sender: TObject);
var
  nIndex: Integer;
  Magic: pTMagic;
begin
  if not boOpened then Exit;
  nIndex := ListBoxSerieMagic.ItemIndex;
  if nIndex >= 0 then begin
    Magic := pTMagic(ListBoxSerieMagic.Items.Objects[nIndex]);
    nIndex := Magic.wMagicId - 100;
    if nIndex >= 0 then begin
      g_Config.SerieMagicBlasthitPowerRate[nIndex] := EditSerieMagicBlasthitPowerRate.Value;
      //Config.SerieMagicAttackRange[nIndex] := EditSerieMagicAttackRange.Value;
      //Config.SerieMagicBlasthitRate[nIndex, 1] := EditSerieMagicBlasthitRate1.Value;
      //Config.SerieMagicBlasthitRate[nIndex, 2] := EditSerieMagicBlasthitRate2.Value;
      //Config.SerieMagicBlasthitRate[nIndex, 3] := EditSerieMagicBlasthitRate3.Value;
      ModValue();
    end;
  end;
end;

procedure TfrmFunctionConfig.EditHomeMapChange(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmFunctionConfig.EditHomeXChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAIHomeX := EditHomeX.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditHomeYChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAIHomeY := EditHomeY.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonSaveAIClick(Sender: TObject);
begin
  if EditHomeMap.Text = '' then begin
    Application.MessageBox('出生地图设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditHomeMap.SetFocus;
    Exit;
  end;
  g_Config.sAIHomeMap := Trim(EditHomeMap.Text);

  if g_MapManager.FindMap(g_Config.sAIHomeMap) = nil then begin
    Application.MessageBox('出生地图设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditHomeMap.SetFocus;
    Exit;
  end;

  g_Config.sAIConfigListFileName := Trim(EditConfigListFileName.Text);

  Config.WriteString('Setup', 'AIHomeMap', g_Config.sAIHomeMap);
  Config.WriteInteger('Setup', 'AIHomeX', g_Config.nAIHomeX);
  Config.WriteInteger('Setup', 'AIHomeY', g_Config.nAIHomeY);
  Config.WriteBool('Setup', 'AutoRepairItem', g_Config.boAutoRepairItem);
  Config.WriteBool('Setup', 'RenewHealth', g_Config.boRenewHealth);
  Config.WriteInteger('Setup', 'RenewPercent', g_Config.nRenewPercent);

  Config.WriteString('Setup', 'AIConfigListFileName', g_Config.sAIConfigListFileName);

  SaveAICharNameList;
  uModValue();
end;

procedure TfrmFunctionConfig.ListBoxAIListClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := ListBoxAIList.ItemIndex;
  if Index >= 0 then begin
    EditAIName.Text := ListBoxAIList.Items.Strings[Index];
    ButtonAIDel.Enabled := True;
    ButtonAILogon.Enabled := True;
    Exit;
  end;
  ButtonAIDel.Enabled := False;
  ButtonAILogon.Enabled := False;
end;

procedure TfrmFunctionConfig.ButtonAIDelClick(Sender: TObject);
var
  Index: Integer;
begin
  ListBoxAIList.DeleteSelected;
  g_AICharNameList.Lock;
  try
    g_AICharNameList.Clear;
    g_AICharNameList.AddStrings(ListBoxAIList.Items);
  finally
    g_AICharNameList.UnLock;
  end;
  ModValue();
  {for Index := 0 to ListBoxAIList.Count - 1 do begin
    if ListBoxAIList.Selected[Index] then begin
      ListBoxAIList.DeleteSelected;
    end;
  end; }
end;

procedure TfrmFunctionConfig.ButtonAIListAddClick(Sender: TObject);
var
  sName: string;
begin
  sName := Trim(EditAIName.Text);
  if (sName <> '') and (not GetAICharNameList(sName)) then begin
    g_AICharNameList.Lock;
    try
      g_AICharNameList.Add(sName);
      ListBoxAIList.Clear;
      ListBoxAIList.Items.AddStrings(g_AICharNameList);
    finally
      g_AICharNameList.UnLock;
    end;
    ModValue();
  end;
end;

procedure TfrmFunctionConfig.ButtonAILogonClick(Sender: TObject);
var
  Index, nC: Integer;
  AI: TAILogon;
begin
  if g_MapManager.FindMap(g_Config.sAIHomeMap) = nil then begin
    Application.MessageBox('出生地图设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditHomeMap.SetFocus;
    Exit;
  end;
  nC := 0;
  AI.sMapName := g_Config.sAIHomeMap;
  AI.sConfigFileName := '';
  AI.sHeroConfigFileName := '';
  AI.sFilePath := g_Config.sEnvirDir + sMarket_Def;
  AI.sConfigListFileName := g_Config.sAIConfigListFileName;


  AI.nX := g_Config.nAIHomeX;
  AI.nY := g_Config.nAIHomeY;

  for Index := 0 to ListBoxAIList.Count - 1 do begin
    if ListBoxAIList.Selected[Index] then begin
      //MainOutMessage('ListBoxAIList.Selected[Index]1:' + ListBoxAIList.Items.Strings[Index]);
      if (UserEngine.GetPlayObject(ListBoxAIList.Items.Strings[Index]) = nil) and (not UserEngine.FindAILogon(ListBoxAIList.Items.Strings[Index])) then begin
        //MainOutMessage('ListBoxAIList.Selected[Index]2:' + ListBoxAIList.Items.Strings[Index]);
        //UserEngine.RegenAIObject(ListBoxAIList.Items.Strings[Index]);
        //UserEngine.m_UserLogonList.AddObject(ListBoxAIList.Items.Strings[Index], TObject(GetTickCount + nC * 3000));
        AI.sCharName := ListBoxAIList.Items.Strings[Index];
        UserEngine.AddAILogon(@AI);
        //UserEngine.AddAILogon(g_Config.sAIHomeMap, ListBoxAIList.Items.Strings[Index], g_Config.nAIHomeX, g_Config.nAIHomeY);
        nC := nC + 1;
      end;
    end;
  end;
  ButtonAILogon.Enabled := False;
 { g_AINameList.Lock;
  try
    for I := 0 to g_AINameList.Count - 1 do begin
      if CompareText(sName, g_AINameList.Strings[I]) = 0 then begin
        Result := True;
        Break;
      end;
    end;
  finally
    g_AINameList.UnLock;
  end; }
end;

procedure TfrmFunctionConfig.EditItemMaxStarCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nItemMaxStarCount := EditItemMaxStarCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ListBoxAIListSelect(Sender: TObject);
begin
  GroupBox72.Caption := '机器人列表 [' + IntToStr(ListBoxAIList.SelCount) + ']';
end;

procedure TfrmFunctionConfig.CheckBoxAutoRepairItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAutoRepairItem := CheckBoxAutoRepairItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxRenewHealthClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boRenewHealth := CheckBoxRenewHealth.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditRenewPercentChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRenewPercent := EditRenewPercent.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditConfigListFileNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxCheckCanUpgradeStarItemClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boCheckCanUpgradeStarItem := CheckBoxCheckCanUpgradeStarItem.Checked;
  ModValue();
end;

end.

