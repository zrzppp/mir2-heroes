unit ItemSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Spin, ExtCtrls;

type
  TfrmItemSet = class(TForm)
    PageControl: TPageControl;
    TabSheet8: TTabSheet;
    ItemSetPageControl: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox141: TGroupBox;
    Label108: TLabel;
    Label109: TLabel;
    EditItemExpRate: TSpinEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    TabSheet2: TTabSheet;
    GroupBox142: TGroupBox;
    Label110: TLabel;
    Label3: TLabel;
    EditItemPowerRate: TSpinEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    ButtonItemSetSave: TButton;
    TabSheet9: TTabSheet;
    AddValuePageControl: TPageControl;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    TabSheet15: TTabSheet;
    TabSheet16: TTabSheet;
    ButtonAddValueSave: TButton;
    TabSheet17: TTabSheet;
    TabSheet18: TTabSheet;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    EditMonRandomAddValue: TSpinEdit;
    Label7: TLabel;
    EditMakeRandomAddValue: TSpinEdit;
    GroupBox4: TGroupBox;
    Label8: TLabel;
    EditWeaponDCAddValueMaxLimit: TSpinEdit;
    EditWeaponDCAddValueRate: TSpinEdit;
    Label9: TLabel;
    GroupBox5: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    EditWeaponMCAddValueMaxLimit: TSpinEdit;
    EditWeaponMCAddValueRate: TSpinEdit;
    GroupBox6: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    EditWeaponSCAddValueMaxLimit: TSpinEdit;
    EditWeaponSCAddValueRate: TSpinEdit;
    GroupBox7: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    EditDressDCAddValueMaxLimit: TSpinEdit;
    EditDressDCAddValueRate: TSpinEdit;
    GroupBox8: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    EditDressMCAddValueMaxLimit: TSpinEdit;
    EditDressMCAddValueRate: TSpinEdit;
    GroupBox9: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    EditDressSCAddValueMaxLimit: TSpinEdit;
    EditDressSCAddValueRate: TSpinEdit;
    EditDressDCAddRate: TSpinEdit;
    Label20: TLabel;
    EditDressMCAddRate: TSpinEdit;
    Label21: TLabel;
    Label22: TLabel;
    EditDressSCAddRate: TSpinEdit;
    GroupBox10: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    EditNeckLace19DCAddValueMaxLimit: TSpinEdit;
    EditNeckLace19DCAddValueRate: TSpinEdit;
    EditNeckLace19DCAddRate: TSpinEdit;
    GroupBox11: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    EditNeckLace19MCAddValueMaxLimit: TSpinEdit;
    EditNeckLace19MCAddValueRate: TSpinEdit;
    EditNeckLace19MCAddRate: TSpinEdit;
    GroupBox12: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    EditNeckLace19SCAddValueMaxLimit: TSpinEdit;
    EditNeckLace19SCAddValueRate: TSpinEdit;
    EditNeckLace19SCAddRate: TSpinEdit;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    GroupBox13: TGroupBox;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    EditNeckLace202124DCAddValueMaxLimit: TSpinEdit;
    EditNeckLace202124DCAddValueRate: TSpinEdit;
    EditNeckLace202124DCAddRate: TSpinEdit;
    GroupBox14: TGroupBox;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    EditNeckLace202124MCAddValueMaxLimit: TSpinEdit;
    EditNeckLace202124MCAddValueRate: TSpinEdit;
    EditNeckLace202124MCAddRate: TSpinEdit;
    GroupBox15: TGroupBox;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    EditNeckLace202124SCAddValueMaxLimit: TSpinEdit;
    EditNeckLace202124SCAddValueRate: TSpinEdit;
    EditNeckLace202124SCAddRate: TSpinEdit;
    GroupBox16: TGroupBox;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    EditArmRing26MCAddValueMaxLimit: TSpinEdit;
    EditArmRing26MCAddValueRate: TSpinEdit;
    EditArmRing26MCAddRate: TSpinEdit;
    GroupBox17: TGroupBox;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    EditArmRing26DCAddValueMaxLimit: TSpinEdit;
    EditArmRing26DCAddValueRate: TSpinEdit;
    EditArmRing26DCAddRate: TSpinEdit;
    GroupBox18: TGroupBox;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    EditArmRing26SCAddValueMaxLimit: TSpinEdit;
    EditArmRing26SCAddValueRate: TSpinEdit;
    EditArmRing26SCAddRate: TSpinEdit;
    Label54: TLabel;
    GroupBox19: TGroupBox;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    EditRing22DCAddValueMaxLimit: TSpinEdit;
    EditRing22DCAddValueRate: TSpinEdit;
    EditRing22DCAddRate: TSpinEdit;
    GroupBox20: TGroupBox;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    EditRing22SCAddValueMaxLimit: TSpinEdit;
    EditRing22SCAddValueRate: TSpinEdit;
    EditRing22SCAddRate: TSpinEdit;
    GroupBox21: TGroupBox;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    EditRing22MCAddValueMaxLimit: TSpinEdit;
    EditRing22MCAddValueRate: TSpinEdit;
    EditRing22MCAddRate: TSpinEdit;
    Label64: TLabel;
    GroupBox22: TGroupBox;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    EditRing23DCAddValueMaxLimit: TSpinEdit;
    EditRing23DCAddValueRate: TSpinEdit;
    EditRing23DCAddRate: TSpinEdit;
    GroupBox23: TGroupBox;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    EditRing23MCAddValueMaxLimit: TSpinEdit;
    EditRing23MCAddValueRate: TSpinEdit;
    EditRing23MCAddRate: TSpinEdit;
    GroupBox24: TGroupBox;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    EditRing23SCAddValueMaxLimit: TSpinEdit;
    EditRing23SCAddValueRate: TSpinEdit;
    EditRing23SCAddRate: TSpinEdit;
    Label74: TLabel;
    GroupBox25: TGroupBox;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    EditHelMetDCAddValueMaxLimit: TSpinEdit;
    EditHelMetDCAddValueRate: TSpinEdit;
    EditHelMetDCAddRate: TSpinEdit;
    GroupBox26: TGroupBox;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    EditHelMetMCAddValueMaxLimit: TSpinEdit;
    EditHelMetMCAddValueRate: TSpinEdit;
    EditHelMetMCAddRate: TSpinEdit;
    GroupBox27: TGroupBox;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    EditHelMetSCAddValueMaxLimit: TSpinEdit;
    EditHelMetSCAddValueRate: TSpinEdit;
    EditHelMetSCAddRate: TSpinEdit;
    Label84: TLabel;
    GroupBox28: TGroupBox;
    Label85: TLabel;
    Label86: TLabel;
    EditGuildRecallTime: TSpinEdit;
    GroupBox29: TGroupBox;
    Label87: TLabel;
    Label88: TLabel;
    TabSheet19: TTabSheet;
    PageControl1: TPageControl;
    TabSheet25: TTabSheet;
    TabSheet27: TTabSheet;
    GroupBox49: TGroupBox;
    Label152: TLabel;
    Label153: TLabel;
    EditUnknowRingDCAddRate: TSpinEdit;
    EditUnknowRingDCAddValueMaxLimit: TSpinEdit;
    GroupBox50: TGroupBox;
    Label155: TLabel;
    Label156: TLabel;
    EditUnknowRingMCAddRate: TSpinEdit;
    EditUnknowRingMCAddValueMaxLimit: TSpinEdit;
    GroupBox51: TGroupBox;
    Label158: TLabel;
    Label159: TLabel;
    EditUnknowRingSCAddRate: TSpinEdit;
    EditUnknowRingSCAddValueMaxLimit: TSpinEdit;
    GroupBox30: TGroupBox;
    Label89: TLabel;
    Label90: TLabel;
    EditUnknowRingACAddRate: TSpinEdit;
    EditUnknowRingACAddValueMaxLimit: TSpinEdit;
    GroupBox31: TGroupBox;
    Label91: TLabel;
    Label92: TLabel;
    EditUnknowRingMACAddRate: TSpinEdit;
    EditUnknowRingMACAddValueMaxLimit: TSpinEdit;
    ButtonUnKnowItemSave: TButton;
    GroupBox32: TGroupBox;
    Label93: TLabel;
    Label94: TLabel;
    EditUnknowNecklaceSCAddRate: TSpinEdit;
    EditUnknowNecklaceSCAddValueMaxLimit: TSpinEdit;
    GroupBox33: TGroupBox;
    Label95: TLabel;
    Label96: TLabel;
    EditUnknowNecklaceMACAddRate: TSpinEdit;
    EditUnknowNecklaceMACAddValueMaxLimit: TSpinEdit;
    GroupBox34: TGroupBox;
    Label97: TLabel;
    Label98: TLabel;
    EditUnknowNecklaceACAddRate: TSpinEdit;
    EditUnknowNecklaceACAddValueMaxLimit: TSpinEdit;
    GroupBox35: TGroupBox;
    Label99: TLabel;
    Label100: TLabel;
    EditUnknowNecklaceDCAddRate: TSpinEdit;
    EditUnknowNecklaceDCAddValueMaxLimit: TSpinEdit;
    GroupBox36: TGroupBox;
    Label101: TLabel;
    Label102: TLabel;
    EditUnknowNecklaceMCAddRate: TSpinEdit;
    EditUnknowNecklaceMCAddValueMaxLimit: TSpinEdit;
    TabSheet20: TTabSheet;
    GroupBox37: TGroupBox;
    Label103: TLabel;
    Label104: TLabel;
    EditUnknowHelMetSCAddRate: TSpinEdit;
    EditUnknowHelMetSCAddValueMaxLimit: TSpinEdit;
    GroupBox38: TGroupBox;
    Label105: TLabel;
    Label106: TLabel;
    EditUnknowHelMetMCAddRate: TSpinEdit;
    EditUnknowHelMetMCAddValueMaxLimit: TSpinEdit;
    GroupBox39: TGroupBox;
    Label107: TLabel;
    Label111: TLabel;
    EditUnknowHelMetDCAddRate: TSpinEdit;
    EditUnknowHelMetDCAddValueMaxLimit: TSpinEdit;
    GroupBox40: TGroupBox;
    Label112: TLabel;
    Label113: TLabel;
    EditUnknowHelMetACAddRate: TSpinEdit;
    EditUnknowHelMetACAddValueMaxLimit: TSpinEdit;
    GroupBox41: TGroupBox;
    Label114: TLabel;
    Label115: TLabel;
    EditUnknowHelMetMACAddRate: TSpinEdit;
    EditUnknowHelMetMACAddValueMaxLimit: TSpinEdit;
    GroupBox44: TGroupBox;
    GroupBox45: TGroupBox;
    Label122: TLabel;
    Label123: TLabel;
    GroupBox42: TGroupBox;
    EditAttackPosionRate: TSpinEdit;
    Label120: TLabel;
    Label116: TLabel;
    EditAttackPosionTime: TSpinEdit;
    GroupBox43: TGroupBox;
    GroupBox46: TGroupBox;
    Label117: TLabel;
    Label118: TLabel;
    GroupBox47: TGroupBox;
    CheckBoxUserMoveCanDupObj: TCheckBox;
    CheckBoxUserMoveCanOnItem: TCheckBox;
    Label119: TLabel;
    EditUserMoveTime: TSpinEdit;
    Label121: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    EditScriptRandomAddValue: TSpinEdit;
    GroupBox53: TGroupBox;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    EditArmRing26NewAddValueMaxLimit: TSpinEdit;
    EditArmRing26NewAddValueRate: TSpinEdit;
    EditArmRing26NewAddRate: TSpinEdit;
    GroupBox54: TGroupBox;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    EditRing22NewAddValueMaxLimit: TSpinEdit;
    EditRing22NewAddValueRate: TSpinEdit;
    EditRing22NewAddRate: TSpinEdit;
    GroupBox55: TGroupBox;
    Label140: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    EditRing23NewAddValueMaxLimit: TSpinEdit;
    EditRing23NewAddValueRate: TSpinEdit;
    EditRing23NewAddRate: TSpinEdit;
    GroupBox56: TGroupBox;
    Label143: TLabel;
    Label144: TLabel;
    Label145: TLabel;
    EditHelMetNewAddValueMaxLimit: TSpinEdit;
    EditHelMetNewAddValueRate: TSpinEdit;
    EditHelMetNewAddRate: TSpinEdit;
    GroupBox57: TGroupBox;
    Label146: TLabel;
    Label147: TLabel;
    EditWeaponNewAddValueMaxLimit: TSpinEdit;
    EditWeaponNewAddValueRate: TSpinEdit;
    GroupBox58: TGroupBox;
    Label148: TLabel;
    Label149: TLabel;
    Label150: TLabel;
    EditDressNewAddValueMaxLimit: TSpinEdit;
    EditDressNewAddValueRate: TSpinEdit;
    EditDressNewAddRate: TSpinEdit;
    GroupBox59: TGroupBox;
    Label151: TLabel;
    Label154: TLabel;
    Label157: TLabel;
    EditNeckLace19NewAddValueMaxLimit: TSpinEdit;
    EditNeckLace19NewAddValueRate: TSpinEdit;
    EditNeckLace19NewAddRate: TSpinEdit;
    GroupBox60: TGroupBox;
    Label160: TLabel;
    Label161: TLabel;
    Label162: TLabel;
    EditNeckLace202124NewAddValueMaxLimit: TSpinEdit;
    EditNeckLace202124NewAddValueRate: TSpinEdit;
    EditNeckLace202124NewAddRate: TSpinEdit;
    TabSheet22: TTabSheet;
    GroupBox48: TGroupBox;
    Label126: TLabel;
    Label127: TLabel;
    Label128: TLabel;
    EditMonRandomNewAddValue: TSpinEdit;
    EditMakeRandomNewAddValue: TSpinEdit;
    EditScriptRandomNewAddValue: TSpinEdit;
    ButtonAddValue2Save: TButton;
    TabSheet21: TTabSheet;
    PageControl2: TPageControl;
    TabSheet23: TTabSheet;
    GroupBox52: TGroupBox;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    EditMonRandomNotLimit: TSpinEdit;
    EditMakeRandomNotLimit: TSpinEdit;
    EditScriptRandomNotLimit: TSpinEdit;
    TabSheet24: TTabSheet;
    Label166: TLabel;
    GroupBox62: TGroupBox;
    Label167: TLabel;
    Label168: TLabel;
    Label165: TLabel;
    EditWeaponMaxLimitDay: TSpinEdit;
    EditWeaponLimitDayRate: TSpinEdit;
    EditWeaponNotLimitRate: TSpinEdit;
    TabSheet26: TTabSheet;
    Label175: TLabel;
    GroupBox65: TGroupBox;
    Label172: TLabel;
    Label173: TLabel;
    Label169: TLabel;
    EditDressMaxLimitDay: TSpinEdit;
    EditDressLimitDayRate: TSpinEdit;
    EditDressNotLimitRate: TSpinEdit;
    TabSheet28: TTabSheet;
    Label188: TLabel;
    GroupBox66: TGroupBox;
    Label174: TLabel;
    Label176: TLabel;
    Label177: TLabel;
    EditNeckLaceMaxLimitDay: TSpinEdit;
    EditNeckLaceLimitDayRate: TSpinEdit;
    EditNeckLaceNotLimitRate: TSpinEdit;
    TabSheet30: TTabSheet;
    Label214: TLabel;
    GroupBox68: TGroupBox;
    Label179: TLabel;
    Label180: TLabel;
    Label178: TLabel;
    EditArmRingMaxLimitDay: TSpinEdit;
    EditArmRingLimitDayRate: TSpinEdit;
    EditArmRingNotLimitRate: TSpinEdit;
    TabSheet31: TTabSheet;
    Label227: TLabel;
    GroupBox82: TGroupBox;
    Label228: TLabel;
    Label229: TLabel;
    Label181: TLabel;
    EditRingMaxLimitDay: TSpinEdit;
    EditRingLimitDayRate: TSpinEdit;
    EditRingNotLimitRate: TSpinEdit;
    TabSheet33: TTabSheet;
    Label253: TLabel;
    GroupBox61: TGroupBox;
    Label163: TLabel;
    Label164: TLabel;
    Label182: TLabel;
    EditHelMetMaxLimitDay: TSpinEdit;
    EditHelMetLimitDayRate: TSpinEdit;
    EditHelMetNotLimitRate: TSpinEdit;
    TabSheet34: TTabSheet;
    GroupBox64: TGroupBox;
    Label170: TLabel;
    Label171: TLabel;
    Label183: TLabel;
    EditOtherMaxLimitDay: TSpinEdit;
    EditOtherLimitDayRate: TSpinEdit;
    EditOtherNotLimitRate: TSpinEdit;
    ButtonItemTimeSave: TButton;
    TabSheet29: TTabSheet;
    ItemPointPageControl: TPageControl;
    TabSheet32: TTabSheet;
    GroupBox63: TGroupBox;
    Label132: TLabel;
    Label136: TLabel;
    Label184: TLabel;
    EditMonRandomAddPoint: TSpinEdit;
    EditMakeRandomAddPoint: TSpinEdit;
    EditScriptRandomAddPoint: TSpinEdit;
    TabSheet35: TTabSheet;
    Label185: TLabel;
    GroupBox71: TGroupBox;
    Label193: TLabel;
    Label194: TLabel;
    EditWeaponPointAddValueMaxLimit: TSpinEdit;
    EditWeaponPointAddValueRate: TSpinEdit;
    TabSheet36: TTabSheet;
    Label195: TLabel;
    TabSheet37: TTabSheet;
    Label208: TLabel;
    TabSheet38: TTabSheet;
    Label222: TLabel;
    TabSheet39: TTabSheet;
    Label238: TLabel;
    TabSheet40: TTabSheet;
    Label251: TLabel;
    TabSheet41: TTabSheet;
    Label265: TLabel;
    TabSheet42: TTabSheet;
    Label278: TLabel;
    RadioGroupWeapon: TRadioGroup;
    RadioGroupDress: TRadioGroup;
    RadioGroupNeckLace: TRadioGroup;
    RadioGroupArmRing: TRadioGroup;
    RadioGroupShoes: TRadioGroup;
    RadioGroupRing: TRadioGroup;
    RadioGroupBelt: TRadioGroup;
    RadioGroupHelMet: TRadioGroup;
    GroupBox67: TGroupBox;
    Label186: TLabel;
    Label187: TLabel;
    EditDressPointAddValueMaxLimit: TSpinEdit;
    EditDressPointAddValueRate: TSpinEdit;
    GroupBox69: TGroupBox;
    Label189: TLabel;
    Label190: TLabel;
    EditNeckLacePointAddValueMaxLimit: TSpinEdit;
    EditNeckLacePointAddValueRate: TSpinEdit;
    GroupBox70: TGroupBox;
    Label191: TLabel;
    Label192: TLabel;
    EditArmRingPointAddValueMaxLimit: TSpinEdit;
    EditArmRingPointAddValueRate: TSpinEdit;
    GroupBox72: TGroupBox;
    Label196: TLabel;
    Label197: TLabel;
    EditRingPointAddValueMaxLimit: TSpinEdit;
    EditRingPointAddValueRate: TSpinEdit;
    GroupBox73: TGroupBox;
    Label198: TLabel;
    Label199: TLabel;
    EditHelMetPointAddValueMaxLimit: TSpinEdit;
    EditHelMetPointAddValueRate: TSpinEdit;
    GroupBox74: TGroupBox;
    Label200: TLabel;
    Label201: TLabel;
    EditShoesPointAddValueMaxLimit: TSpinEdit;
    EditShoesPointAddValueRate: TSpinEdit;
    GroupBox75: TGroupBox;
    Label202: TLabel;
    Label203: TLabel;
    EditBeltPointAddValueMaxLimit: TSpinEdit;
    EditBeltPointAddValueRate: TSpinEdit;
    ButtonItemPoint: TButton;
    Label204: TLabel;
    EditWeaponPointAddRate: TSpinEdit;
    Label205: TLabel;
    Label206: TLabel;
    Label207: TLabel;
    Label209: TLabel;
    Label210: TLabel;
    Label211: TLabel;
    Label212: TLabel;
    EditDressPointAddRate: TSpinEdit;
    EditNeckLacePointAddRate: TSpinEdit;
    EditArmRingPointAddRate: TSpinEdit;
    EditRingPointAddRate: TSpinEdit;
    EditHelMetPointAddRate: TSpinEdit;
    EditShoesPointAddRate: TSpinEdit;
    EditBeltPointAddRate: TSpinEdit;
    GroupBox76: TGroupBox;
    CheckBoxAllowItemAddValue: TCheckBox;
    GroupBox77: TGroupBox;
    CheckBoxAllowItemAddPoint: TCheckBox;
    GroupBox78: TGroupBox;
    CheckBoxAllowItemTime: TCheckBox;
    GroupBoxHelMetNewAbil: TGroupBox;
    GroupBoxRingNewAbil: TGroupBox;
    GroupBoxShoesNewAbil: TGroupBox;
    GroupBoxBeltNewAbil: TGroupBox;
    CheckBox28: TCheckBox;
    CheckBox29: TCheckBox;
    CheckBox30: TCheckBox;
    CheckBox31: TCheckBox;
    CheckBox32: TCheckBox;
    CheckBox33: TCheckBox;
    CheckBox34: TCheckBox;
    CheckBox35: TCheckBox;
    CheckBox36: TCheckBox;
    GroupBoxWeaponNewAbil: TGroupBox;
    GroupBoxDressNewAbil: TGroupBox;
    GroupBoxNeckLaceNewAbil: TGroupBox;
    GroupBoxArmRingNewAbil: TGroupBox;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox26: TCheckBox;
    CheckBox27: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox37: TCheckBox;
    CheckBox38: TCheckBox;
    CheckBox39: TCheckBox;
    CheckBox40: TCheckBox;
    CheckBox41: TCheckBox;
    CheckBox42: TCheckBox;
    CheckBox43: TCheckBox;
    CheckBox44: TCheckBox;
    CheckBox45: TCheckBox;
    CheckBox46: TCheckBox;
    CheckBox47: TCheckBox;
    CheckBox48: TCheckBox;
    CheckBox49: TCheckBox;
    CheckBox50: TCheckBox;
    CheckBox51: TCheckBox;
    CheckBox52: TCheckBox;
    CheckBox53: TCheckBox;
    CheckBox54: TCheckBox;
    CheckBox55: TCheckBox;
    CheckBox56: TCheckBox;
    CheckBox57: TCheckBox;
    CheckBox58: TCheckBox;
    CheckBox59: TCheckBox;
    CheckBox60: TCheckBox;
    CheckBox61: TCheckBox;
    CheckBox62: TCheckBox;
    CheckBox63: TCheckBox;
    CheckBox64: TCheckBox;
    CheckBox65: TCheckBox;
    CheckBox66: TCheckBox;
    CheckBox67: TCheckBox;
    CheckBox68: TCheckBox;
    CheckBox69: TCheckBox;
    CheckBox70: TCheckBox;
    CheckBox71: TCheckBox;
    CheckBox72: TCheckBox;
    CheckBox73: TCheckBox;
    CheckBox74: TCheckBox;
    CheckBox75: TCheckBox;
    CheckBox76: TCheckBox;
    CheckBox77: TCheckBox;
    CheckBox78: TCheckBox;
    CheckBox79: TCheckBox;
    CheckBox80: TCheckBox;
    CheckBox81: TCheckBox;
    CheckBox82: TCheckBox;
    CheckBox83: TCheckBox;
    CheckBox84: TCheckBox;
    CheckBox85: TCheckBox;
    CheckBox86: TCheckBox;
    CheckBox87: TCheckBox;
    CheckBox88: TCheckBox;
    procedure EditItemExpRateChange(Sender: TObject);
    procedure EditItemPowerRateChange(Sender: TObject);
    procedure ButtonItemSetSaveClick(Sender: TObject);
    procedure ButtonAddValueSaveClick(Sender: TObject);
    procedure EditMonRandomAddValueChange(Sender: TObject);
    procedure EditMakeRandomAddValueChange(Sender: TObject);
    procedure EditWeaponDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditWeaponDCAddValueRateChange(Sender: TObject);
    procedure EditWeaponMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditWeaponMCAddValueRateChange(Sender: TObject);
    procedure EditWeaponSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditWeaponSCAddValueRateChange(Sender: TObject);
    procedure EditDressDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressDCAddValueRateChange(Sender: TObject);
    procedure EditDressMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressMCAddValueRateChange(Sender: TObject);
    procedure EditDressSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressSCAddValueRateChange(Sender: TObject);
    procedure EditDressDCAddRateChange(Sender: TObject);
    procedure EditDressMCAddRateChange(Sender: TObject);
    procedure EditDressSCAddRateChange(Sender: TObject);
    procedure EditNeckLace19DCAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace19DCAddValueRateChange(Sender: TObject);
    procedure EditNeckLace19DCAddRateChange(Sender: TObject);
    procedure EditNeckLace19SCAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace19SCAddValueRateChange(Sender: TObject);
    procedure EditNeckLace19SCAddRateChange(Sender: TObject);
    procedure EditNeckLace19MCAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace19MCAddValueRateChange(Sender: TObject);
    procedure EditNeckLace19MCAddRateChange(Sender: TObject);
    procedure EditNeckLace202124DCAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace202124DCAddValueRateChange(Sender: TObject);
    procedure EditNeckLace202124DCAddRateChange(Sender: TObject);
    procedure EditNeckLace202124SCAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace202124SCAddValueRateChange(Sender: TObject);
    procedure EditNeckLace202124SCAddRateChange(Sender: TObject);
    procedure EditNeckLace202124MCAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace202124MCAddValueRateChange(Sender: TObject);
    procedure EditNeckLace202124MCAddRateChange(Sender: TObject);
    procedure EditArmRing26DCAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmRing26DCAddValueRateChange(Sender: TObject);
    procedure EditArmRing26DCAddRateChange(Sender: TObject);
    procedure EditArmRing26SCAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmRing26SCAddValueRateChange(Sender: TObject);
    procedure EditArmRing26SCAddRateChange(Sender: TObject);
    procedure EditArmRing26MCAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmRing26MCAddValueRateChange(Sender: TObject);
    procedure EditArmRing26MCAddRateChange(Sender: TObject);
    procedure EditRing22DCAddValueMaxLimitChange(Sender: TObject);
    procedure EditRing22DCAddValueRateChange(Sender: TObject);
    procedure EditRing22DCAddRateChange(Sender: TObject);
    procedure EditRing22SCAddValueMaxLimitChange(Sender: TObject);
    procedure EditRing22SCAddValueRateChange(Sender: TObject);
    procedure EditRing22SCAddRateChange(Sender: TObject);
    procedure EditRing22MCAddValueMaxLimitChange(Sender: TObject);
    procedure EditRing22MCAddValueRateChange(Sender: TObject);
    procedure EditRing22MCAddRateChange(Sender: TObject);
    procedure EditRing23DCAddValueMaxLimitChange(Sender: TObject);
    procedure EditRing23DCAddValueRateChange(Sender: TObject);
    procedure EditRing23DCAddRateChange(Sender: TObject);
    procedure EditRing23SCAddValueMaxLimitChange(Sender: TObject);
    procedure EditRing23SCAddValueRateChange(Sender: TObject);
    procedure EditRing23SCAddRateChange(Sender: TObject);
    procedure EditRing23MCAddValueMaxLimitChange(Sender: TObject);
    procedure EditRing23MCAddValueRateChange(Sender: TObject);
    procedure EditRing23MCAddRateChange(Sender: TObject);
    procedure EditHelMetDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelMetDCAddValueRateChange(Sender: TObject);
    procedure EditHelMetDCAddRateChange(Sender: TObject);
    procedure EditHelMetSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelMetSCAddValueRateChange(Sender: TObject);
    procedure EditHelMetSCAddRateChange(Sender: TObject);
    procedure EditHelMetMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelMetMCAddValueRateChange(Sender: TObject);
    procedure EditHelMetMCAddRateChange(Sender: TObject);
    procedure EditGuildRecallTimeChange(Sender: TObject);
    procedure ButtonUnKnowItemSaveClick(Sender: TObject);
    procedure EditUnknowRingDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowRingDCAddRateChange(Sender: TObject);
    procedure EditUnknowRingMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowRingMCAddRateChange(Sender: TObject);
    procedure EditUnknowRingSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowRingSCAddRateChange(Sender: TObject);
    procedure EditUnknowRingACAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowRingACAddRateChange(Sender: TObject);
    procedure EditUnknowRingMACAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowRingMACAddRateChange(Sender: TObject);
    procedure EditUnknowNecklaceDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowNecklaceDCAddRateChange(Sender: TObject);
    procedure EditUnknowNecklaceMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowNecklaceMCAddRateChange(Sender: TObject);
    procedure EditUnknowNecklaceSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowNecklaceSCAddRateChange(Sender: TObject);
    procedure EditUnknowNecklaceACAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowNecklaceACAddRateChange(Sender: TObject);
    procedure EditUnknowNecklaceMACAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowNecklaceMACAddRateChange(Sender: TObject);
    procedure EditUnknowHelMetDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowHelMetDCAddRateChange(Sender: TObject);
    procedure EditUnknowHelMetMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowHelMetMCAddRateChange(Sender: TObject);
    procedure EditUnknowHelMetSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowHelMetSCAddRateChange(Sender: TObject);
    procedure EditUnknowHelMetACAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowHelMetACAddRateChange(Sender: TObject);
    procedure EditUnknowHelMetMACAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowHelMetMACAddRateChange(Sender: TObject);
    procedure EditAttackPosionRateChange(Sender: TObject);
    procedure EditAttackPosionTimeChange(Sender: TObject);
    procedure CheckBoxUserMoveCanDupObjClick(Sender: TObject);
    procedure CheckBoxUserMoveCanOnItemClick(Sender: TObject);
    procedure EditUserMoveTimeChange(Sender: TObject);
    procedure EditScriptRandomAddValueChange(Sender: TObject);
    procedure EditMonRandomNewAddValueChange(Sender: TObject);
    procedure EditMakeRandomNewAddValueChange(Sender: TObject);
    procedure EditScriptRandomNewAddValueChange(Sender: TObject);
    procedure EditMonRandomNotLimitChange(Sender: TObject);
    procedure EditMakeRandomNotLimitChange(Sender: TObject);
    procedure EditScriptRandomNotLimitChange(Sender: TObject);
    procedure EditArmRing26NewAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmRing26NewAddValueRateChange(Sender: TObject);
    procedure EditArmRing26NewAddRateChange(Sender: TObject);
    procedure EditRing22NewAddValueMaxLimitChange(Sender: TObject);
    procedure EditRing22NewAddValueRateChange(Sender: TObject);
    procedure EditRing22NewAddRateChange(Sender: TObject);
    procedure EditRing23NewAddValueMaxLimitChange(Sender: TObject);
    procedure EditRing23NewAddValueRateChange(Sender: TObject);
    procedure EditRing23NewAddRateChange(Sender: TObject);
    procedure EditHelMetNewAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelMetNewAddValueRateChange(Sender: TObject);
    procedure EditHelMetNewAddRateChange(Sender: TObject);
    procedure EditWeaponNewAddValueMaxLimitChange(Sender: TObject);
    procedure EditWeaponNewAddValueRateChange(Sender: TObject);
    procedure EditDressNewAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressNewAddValueRateChange(Sender: TObject);
    procedure EditDressNewAddRateChange(Sender: TObject);
    procedure EditNeckLace19NewAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace19NewAddValueRateChange(Sender: TObject);
    procedure EditNeckLace19NewAddRateChange(Sender: TObject);
    procedure EditNeckLace202124NewAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace202124NewAddValueRateChange(Sender: TObject);
    procedure EditNeckLace202124NewAddRateChange(Sender: TObject);
    procedure EditWeaponMaxLimitDayChange(Sender: TObject);
    procedure EditWeaponLimitDayRateChange(Sender: TObject);
    procedure EditWeaponNotLimitRateChange(Sender: TObject);
    procedure EditDressMaxLimitDayChange(Sender: TObject);
    procedure EditDressLimitDayRateChange(Sender: TObject);
    procedure EditDressNotLimitRateChange(Sender: TObject);
    procedure EditNeckLaceMaxLimitDayChange(Sender: TObject);
    procedure EditNeckLaceLimitDayRateChange(Sender: TObject);
    procedure EditNeckLaceNotLimitRateChange(Sender: TObject);
    procedure EditArmRingMaxLimitDayChange(Sender: TObject);
    procedure EditArmRingLimitDayRateChange(Sender: TObject);
    procedure EditArmRingNotLimitRateChange(Sender: TObject);
    procedure EditRingMaxLimitDayChange(Sender: TObject);
    procedure EditRingLimitDayRateChange(Sender: TObject);
    procedure EditRingNotLimitRateChange(Sender: TObject);
    procedure EditHelMetMaxLimitDayChange(Sender: TObject);
    procedure EditHelMetLimitDayRateChange(Sender: TObject);
    procedure EditHelMetNotLimitRateChange(Sender: TObject);
    procedure EditOtherMaxLimitDayChange(Sender: TObject);
    procedure EditOtherLimitDayRateChange(Sender: TObject);
    procedure EditOtherNotLimitRateChange(Sender: TObject);
    procedure ButtonAddValue2SaveClick(Sender: TObject);
    procedure ButtonItemTimeSaveClick(Sender: TObject);
    procedure EditMonRandomAddPointChange(Sender: TObject);
    procedure EditMakeRandomAddPointChange(Sender: TObject);
    procedure EditScriptRandomAddPointChange(Sender: TObject);
    procedure RadioGroupWeaponClick(Sender: TObject);
    procedure EditWeaponPointAddValueMaxLimitChange(Sender: TObject);
    procedure EditWeaponPointAddValueRateChange(Sender: TObject);
    procedure EditWeaponPointAddRateChange(Sender: TObject);
    procedure RadioGroupDressClick(Sender: TObject);
    procedure EditDressPointAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressPointAddValueRateChange(Sender: TObject);
    procedure EditDressPointAddRateChange(Sender: TObject);
    procedure RadioGroupNeckLaceClick(Sender: TObject);
    procedure EditNeckLacePointAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLacePointAddValueRateChange(Sender: TObject);
    procedure EditNeckLacePointAddRateChange(Sender: TObject);
    procedure RadioGroupArmRingClick(Sender: TObject);
    procedure EditArmRingPointAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmRingPointAddValueRateChange(Sender: TObject);
    procedure EditArmRingPointAddRateChange(Sender: TObject);
    procedure RadioGroupRingClick(Sender: TObject);
    procedure EditRingPointAddValueMaxLimitChange(Sender: TObject);
    procedure EditRingPointAddValueRateChange(Sender: TObject);
    procedure EditRingPointAddRateChange(Sender: TObject);
    procedure RadioGroupHelMetClick(Sender: TObject);
    procedure EditHelMetPointAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelMetPointAddValueRateChange(Sender: TObject);
    procedure EditHelMetPointAddRateChange(Sender: TObject);
    procedure RadioGroupShoesClick(Sender: TObject);
    procedure EditShoesPointAddValueMaxLimitChange(Sender: TObject);
    procedure EditShoesPointAddValueRateChange(Sender: TObject);
    procedure EditShoesPointAddRateChange(Sender: TObject);
    procedure RadioGroupBeltClick(Sender: TObject);
    procedure EditBeltPointAddValueMaxLimitChange(Sender: TObject);
    procedure EditBeltPointAddValueRateChange(Sender: TObject);
    procedure EditBeltPointAddRateChange(Sender: TObject);
    procedure ButtonItemPointClick(Sender: TObject);
    procedure CheckBoxAllowItemAddValueClick(Sender: TObject);
    procedure CheckBoxAllowItemAddPointClick(Sender: TObject);
    procedure CheckBoxAllowItemTimeClick(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure CheckBox18Click(Sender: TObject);
    procedure CheckBox45Click(Sender: TObject);
    procedure CheckBox54Click(Sender: TObject);
    procedure CheckBox63Click(Sender: TObject);
    procedure CheckBox72Click(Sender: TObject);
    procedure CheckBox27Click(Sender: TObject);
    procedure CheckBox28Click(Sender: TObject);
  private
    boOpened: Boolean;
    boModValued: Boolean;
    procedure ModValue();
    procedure uModValue();
    procedure RefUnknowItem();
    procedure RefShapeItem();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmItemSet: TfrmItemSet;

implementation

uses M2Share, Grobal2;

{$R *.dfm}

{ TfrmItemSet }

procedure TfrmItemSet.ModValue;
begin
  boModValued := True;
  ButtonItemSetSave.Enabled := True;
  ButtonAddValueSave.Enabled := True;
  ButtonUnKnowItemSave.Enabled := True;
  ButtonAddValue2Save.Enabled := True;
  ButtonItemTimeSave.Enabled := True;
  ButtonItemPoint.Enabled := True;
end;

procedure TfrmItemSet.uModValue;
begin
  boModValued := False;
  ButtonItemSetSave.Enabled := False;
  ButtonAddValueSave.Enabled := False;
  ButtonUnKnowItemSave.Enabled := False;
  ButtonAddValue2Save.Enabled := False;
  ButtonItemTimeSave.Enabled := False;
  ButtonItemPoint.Enabled := False;
end;

procedure TfrmItemSet.Open;
var
  I: Integer;
  CheckBox: TCheckBox;
begin
  boOpened := False;
  uModValue();

  EditItemExpRate.Value := g_Config.nItemExpRate;
  EditItemPowerRate.Value := g_Config.nItemPowerRate;

  EditMonRandomAddValue.Value := g_Config.nMonRandomAddValue;
  EditMakeRandomAddValue.Value := g_Config.nMakeRandomAddValue;
  EditScriptRandomAddValue.Value := g_Config.nScriptRandomAddValue;

  EditWeaponDCAddValueMaxLimit.Value := g_Config.nWeaponDCAddValueMaxLimit;
  EditWeaponDCAddValueRate.Value := g_Config.nWeaponDCAddValueRate;
  EditWeaponMCAddValueMaxLimit.Value := g_Config.nWeaponMCAddValueMaxLimit;
  EditWeaponMCAddValueRate.Value := g_Config.nWeaponMCAddValueRate;
  EditWeaponSCAddValueMaxLimit.Value := g_Config.nWeaponSCAddValueMaxLimit;
  EditWeaponSCAddValueRate.Value := g_Config.nWeaponSCAddValueRate;

  EditDressDCAddRate.Value := g_Config.nDressDCAddRate;
  EditDressDCAddValueMaxLimit.Value := g_Config.nDressDCAddValueMaxLimit;
  EditDressDCAddValueRate.Value := g_Config.nDressDCAddValueRate;
  EditDressMCAddRate.Value := g_Config.nDressMCAddRate;
  EditDressMCAddValueMaxLimit.Value := g_Config.nDressMCAddValueMaxLimit;
  EditDressMCAddValueRate.Value := g_Config.nDressMCAddValueRate;
  EditDressSCAddRate.Value := g_Config.nDressSCAddRate;
  EditDressSCAddValueMaxLimit.Value := g_Config.nDressSCAddValueMaxLimit;
  EditDressSCAddValueRate.Value := g_Config.nDressSCAddValueRate;

  EditNeckLace19DCAddRate.Value := g_Config.nNeckLace19DCAddRate;
  EditNeckLace19DCAddValueMaxLimit.Value := g_Config.nNeckLace19DCAddValueMaxLimit;
  EditNeckLace19DCAddValueRate.Value := g_Config.nNeckLace19DCAddValueRate;
  EditNeckLace19MCAddRate.Value := g_Config.nNeckLace19MCAddRate;
  EditNeckLace19MCAddValueMaxLimit.Value := g_Config.nNeckLace19MCAddValueMaxLimit;
  EditNeckLace19MCAddValueRate.Value := g_Config.nNeckLace19MCAddValueRate;
  EditNeckLace19SCAddRate.Value := g_Config.nNeckLace19SCAddRate;
  EditNeckLace19SCAddValueMaxLimit.Value := g_Config.nNeckLace19SCAddValueMaxLimit;
  EditNeckLace19SCAddValueRate.Value := g_Config.nNeckLace19SCAddValueRate;

  EditNeckLace202124DCAddRate.Value := g_Config.nNeckLace202124DCAddRate;
  EditNeckLace202124DCAddValueMaxLimit.Value := g_Config.nNeckLace202124DCAddValueMaxLimit;
  EditNeckLace202124DCAddValueRate.Value := g_Config.nNeckLace202124DCAddValueRate;
  EditNeckLace202124MCAddRate.Value := g_Config.nNeckLace202124MCAddRate;
  EditNeckLace202124MCAddValueMaxLimit.Value := g_Config.nNeckLace202124MCAddValueMaxLimit;
  EditNeckLace202124MCAddValueRate.Value := g_Config.nNeckLace202124MCAddValueRate;
  EditNeckLace202124SCAddRate.Value := g_Config.nNeckLace202124SCAddRate;
  EditNeckLace202124SCAddValueMaxLimit.Value := g_Config.nNeckLace202124SCAddValueMaxLimit;
  EditNeckLace202124SCAddValueRate.Value := g_Config.nNeckLace202124SCAddValueRate;

  EditArmRing26DCAddRate.Value := g_Config.nArmRing26DCAddRate;
  EditArmRing26DCAddValueMaxLimit.Value := g_Config.nArmRing26DCAddValueMaxLimit;
  EditArmRing26DCAddValueRate.Value := g_Config.nArmRing26DCAddValueRate;
  EditArmRing26MCAddRate.Value := g_Config.nArmRing26MCAddRate;
  EditArmRing26MCAddValueMaxLimit.Value := g_Config.nArmRing26MCAddValueMaxLimit;
  EditArmRing26MCAddValueRate.Value := g_Config.nArmRing26MCAddValueRate;
  EditArmRing26SCAddRate.Value := g_Config.nArmRing26SCAddRate;
  EditArmRing26SCAddValueMaxLimit.Value := g_Config.nArmRing26SCAddValueMaxLimit;
  EditArmRing26SCAddValueRate.Value := g_Config.nArmRing26SCAddValueRate;

  EditRing22DCAddRate.Value := g_Config.nRing22DCAddRate;
  EditRing22DCAddValueMaxLimit.Value := g_Config.nRing22DCAddValueMaxLimit;
  EditRing22DCAddValueRate.Value := g_Config.nRing22DCAddValueRate;
  EditRing22MCAddRate.Value := g_Config.nRing22MCAddRate;
  EditRing22MCAddValueMaxLimit.Value := g_Config.nRing22MCAddValueMaxLimit;
  EditRing22MCAddValueRate.Value := g_Config.nRing22MCAddValueRate;
  EditRing22SCAddRate.Value := g_Config.nRing22SCAddRate;
  EditRing22SCAddValueMaxLimit.Value := g_Config.nRing22SCAddValueMaxLimit;
  EditRing22SCAddValueRate.Value := g_Config.nRing22SCAddValueRate;

  EditRing23DCAddRate.Value := g_Config.nRing23DCAddRate;
  EditRing23DCAddValueMaxLimit.Value := g_Config.nRing23DCAddValueMaxLimit;
  EditRing23DCAddValueRate.Value := g_Config.nRing23DCAddValueRate;
  EditRing23MCAddRate.Value := g_Config.nRing23MCAddRate;
  EditRing23MCAddValueMaxLimit.Value := g_Config.nRing23MCAddValueMaxLimit;
  EditRing23MCAddValueRate.Value := g_Config.nRing23MCAddValueRate;
  EditRing23SCAddRate.Value := g_Config.nRing23SCAddRate;
  EditRing23SCAddValueMaxLimit.Value := g_Config.nRing23SCAddValueMaxLimit;
  EditRing23SCAddValueRate.Value := g_Config.nRing23SCAddValueRate;

  EditHelMetDCAddRate.Value := g_Config.nHelMetDCAddRate;
  EditHelMetDCAddValueMaxLimit.Value := g_Config.nHelMetDCAddValueMaxLimit;
  EditHelMetDCAddValueRate.Value := g_Config.nHelMetDCAddValueRate;
  EditHelMetMCAddRate.Value := g_Config.nHelMetMCAddRate;
  EditHelMetMCAddValueMaxLimit.Value := g_Config.nHelMetMCAddValueMaxLimit;
  EditHelMetMCAddValueRate.Value := g_Config.nHelMetMCAddValueRate;
  EditHelMetSCAddRate.Value := g_Config.nHelMetSCAddRate;
  EditHelMetSCAddValueMaxLimit.Value := g_Config.nHelMetSCAddValueMaxLimit;
  EditHelMetSCAddValueRate.Value := g_Config.nHelMetSCAddValueRate;
  EditGuildRecallTime.Value := g_Config.nGuildRecallTime;

  EditMonRandomNewAddValue.Value := g_Config.nMonRandomNewAddValue;
  EditMakeRandomNewAddValue.Value := g_Config.nMakeRandomNewAddValue;
  EditScriptRandomNewAddValue.Value := g_Config.nScriptRandomNewAddValue;
  EditMonRandomNotLimit.Value := g_Config.nMonRandomNotLimit;
  EditMakeRandomNotLimit.Value := g_Config.nMakeRandomNotLimit;
  EditScriptRandomNotLimit.Value := g_Config.nScriptRandomNotLimit;

  EditWeaponNewAddValueMaxLimit.Value := g_Config.nWeaponNewAddValueMaxLimit;
  EditWeaponNewAddValueRate.Value := g_Config.nWeaponNewAddValueRate;

  EditDressNewAddRate.Value := g_Config.nDressNewAddRate;
  EditDressNewAddValueMaxLimit.Value := g_Config.nDressNewAddValueMaxLimit;
  EditDressNewAddValueRate.Value := g_Config.nDressNewAddValueRate;

  EditNeckLace19NewAddRate.Value := g_Config.nNeckLace19NewAddRate;
  EditNeckLace19NewAddValueMaxLimit.Value := g_Config.nNeckLace19NewAddValueMaxLimit;
  EditNeckLace19NewAddValueRate.Value := g_Config.nNeckLace19NewAddValueRate;

  EditNeckLace202124NewAddRate.Value := g_Config.nNeckLace202124NewAddRate;
  EditNeckLace202124NewAddValueMaxLimit.Value := g_Config.nNeckLace202124NewAddValueMaxLimit;
  EditNeckLace202124NewAddValueRate.Value := g_Config.nNeckLace202124NewAddValueRate;

  EditArmRing26NewAddRate.Value := g_Config.nArmRing26NewAddRate;
  EditArmRing26NewAddValueMaxLimit.Value := g_Config.nArmRing26NewAddValueMaxLimit;
  EditArmRing26NewAddValueRate.Value := g_Config.nArmRing26NewAddValueRate;

  EditRing22NewAddRate.Value := g_Config.nRing22NewAddRate;
  EditRing22NewAddValueMaxLimit.Value := g_Config.nRing22NewAddValueMaxLimit;
  EditRing22NewAddValueRate.Value := g_Config.nRing22NewAddValueRate;

  EditRing23NewAddRate.Value := g_Config.nRing23NewAddRate;
  EditRing23NewAddValueMaxLimit.Value := g_Config.nRing23NewAddValueMaxLimit;
  EditRing23NewAddValueRate.Value := g_Config.nRing23NewAddValueRate;

  EditHelMetNewAddRate.Value := g_Config.nHelMetNewAddRate;
  EditHelMetNewAddValueMaxLimit.Value := g_Config.nHelMetNewAddValueMaxLimit;
  EditHelMetNewAddValueRate.Value := g_Config.nHelMetNewAddValueRate;





  EditWeaponMaxLimitDay.Value := g_Config.nWeaponMaxLimitDay;
  EditWeaponLimitDayRate.Value := g_Config.nWeaponLimitDayRate;
  EditWeaponNotLimitRate.Value := g_Config.nWeaponNotLimitRate;

  EditDressMaxLimitDay.Value := g_Config.nDressMaxLimitDay;
  EditDressLimitDayRate.Value := g_Config.nDressLimitDayRate;
  EditDressNotLimitRate.Value := g_Config.nDressNotLimitRate;

  EditNeckLaceMaxLimitDay.Value := g_Config.nNeckLaceMaxLimitDay;
  EditNeckLaceLimitDayRate.Value := g_Config.nNeckLaceLimitDayRate;
  EditNeckLaceNotLimitRate.Value := g_Config.nNeckLaceNotLimitRate;

  EditArmRingMaxLimitDay.Value := g_Config.nArmRingMaxLimitDay;
  EditArmRingLimitDayRate.Value := g_Config.nArmRingLimitDayRate;
  EditArmRingNotLimitRate.Value := g_Config.nArmRingNotLimitRate;

  EditRingMaxLimitDay.Value := g_Config.nRingMaxLimitDay;
  EditRingLimitDayRate.Value := g_Config.nRingLimitDayRate;
  EditRingNotLimitRate.Value := g_Config.nRingNotLimitRate;

  EditHelMetMaxLimitDay.Value := g_Config.nHelMetMaxLimitDay;
  EditHelMetLimitDayRate.Value := g_Config.nHelMetLimitDayRate;
  EditHelMetNotLimitRate.Value := g_Config.nHelMetNotLimitRate;

  EditOtherMaxLimitDay.Value := g_Config.nOtherMaxLimitDay;
  EditOtherLimitDayRate.Value := g_Config.nOtherLimitDayRate;
  EditOtherNotLimitRate.Value := g_Config.nOtherNotLimitRate;


  RefUnknowItem();
  RefShapeItem();


  TabSheet21.TabVisible := True;
  TabSheet22.TabVisible := True;
  TabSheet29.TabVisible := True;


  EditMonRandomAddPoint.Value := g_Config.nMonRandomAddPoint;
  EditMakeRandomAddPoint.Value := g_Config.nMakeRandomAddPoint;
  EditScriptRandomAddPoint.Value := g_Config.nScriptRandomAddPoint;

  RadioGroupWeapon.ItemIndex := g_Config.nWeaponPointType;
  EditWeaponPointAddRate.Value := g_Config.nWeaponPointAddRate;
  EditWeaponPointAddValueMaxLimit.Value := g_Config.nWeaponPointAddValueMaxLimit;
  EditWeaponPointAddValueRate.Value := g_Config.nWeaponPointAddValueRate;

  RadioGroupDress.ItemIndex := g_Config.nDressPointType;
  EditDressPointAddRate.Value := g_Config.nDressPointAddRate;
  EditDressPointAddValueMaxLimit.Value := g_Config.nDressPointAddValueMaxLimit;
  EditDressPointAddValueRate.Value := g_Config.nDressPointAddValueRate;

  RadioGroupNeckLace.ItemIndex := g_Config.nNeckLacePointType;
  EditNeckLacePointAddRate.Value := g_Config.nNeckLacePointAddRate;
  EditNeckLacePointAddValueMaxLimit.Value := g_Config.nNeckLacePointAddValueMaxLimit;
  EditNeckLacePointAddValueRate.Value := g_Config.nNeckLacePointAddValueRate;

  RadioGroupArmRing.ItemIndex := g_Config.nArmRingPointType;
  EditArmRingPointAddRate.Value := g_Config.nArmRingPointAddRate;
  EditArmRingPointAddValueMaxLimit.Value := g_Config.nArmRingPointAddValueMaxLimit;
  EditArmRingPointAddValueRate.Value := g_Config.nArmRingPointAddValueRate;

  RadioGroupRing.ItemIndex := g_Config.nRingPointType;
  EditRingPointAddRate.Value := g_Config.nRingPointAddRate;
  EditRingPointAddValueMaxLimit.Value := g_Config.nRingPointAddValueMaxLimit;
  EditRingPointAddValueRate.Value := g_Config.nRingPointAddValueRate;

  RadioGroupHelMet.ItemIndex := g_Config.nHelMetPointType;
  EditHelMetPointAddRate.Value := g_Config.nHelMetPointAddRate;
  EditHelMetPointAddValueMaxLimit.Value := g_Config.nHelMetPointAddValueMaxLimit;
  EditHelMetPointAddValueRate.Value := g_Config.nHelMetPointAddValueRate;

  RadioGroupShoes.ItemIndex := g_Config.nShoesPointType;
  EditShoesPointAddRate.Value := g_Config.nShoesPointAddRate;
  EditShoesPointAddValueMaxLimit.Value := g_Config.nShoesPointAddValueMaxLimit;
  EditShoesPointAddValueRate.Value := g_Config.nShoesPointAddValueRate;

  RadioGroupBelt.ItemIndex := g_Config.nBeltPointType;
  EditBeltPointAddRate.Value := g_Config.nBeltPointAddRate;
  EditBeltPointAddValueMaxLimit.Value := g_Config.nBeltPointAddValueMaxLimit;
  EditBeltPointAddValueRate.Value := g_Config.nBeltPointAddValueRate;


  CheckBoxAllowItemAddValue.Checked := g_Config.boAllowItemAddValue;
  CheckBoxAllowItemAddPoint.Checked := g_Config.boAllowItemAddPoint;
  CheckBoxAllowItemTime.Checked := g_Config.boAllowItemTime;


  for I := 0 to GroupBoxWeaponNewAbil.ControlCount - 1 do begin
    if GroupBoxWeaponNewAbil.Controls[I] is TCheckBox then begin
      CheckBox := TCheckBox(GroupBoxWeaponNewAbil.Controls[I]);
      CheckBox.Checked := g_Config.WeaponNewAbil[CheckBox.Tag];
    end;
  end;
  for I := 0 to GroupBoxDressNewAbil.ControlCount - 1 do begin
    if GroupBoxDressNewAbil.Controls[I] is TCheckBox then begin
      CheckBox := TCheckBox(GroupBoxDressNewAbil.Controls[I]);
      CheckBox.Checked := g_Config.DressNewAbil[CheckBox.Tag];
    end;
  end;
  for I := 0 to GroupBoxNeckLaceNewAbil.ControlCount - 1 do begin
    if GroupBoxNeckLaceNewAbil.Controls[I] is TCheckBox then begin
      CheckBox := TCheckBox(GroupBoxNeckLaceNewAbil.Controls[I]);
      CheckBox.Checked := g_Config.NeckLaceNewAbil[CheckBox.Tag];
    end;
  end;
  for I := 0 to GroupBoxArmRingNewAbil.ControlCount - 1 do begin
    if GroupBoxArmRingNewAbil.Controls[I] is TCheckBox then begin
      CheckBox := TCheckBox(GroupBoxArmRingNewAbil.Controls[I]);
      CheckBox.Checked := g_Config.ArmRingNewAbil[CheckBox.Tag];
    end;
  end;
  for I := 0 to GroupBoxRingNewAbil.ControlCount - 1 do begin
    if GroupBoxRingNewAbil.Controls[I] is TCheckBox then begin
      CheckBox := TCheckBox(GroupBoxRingNewAbil.Controls[I]);
      CheckBox.Checked := g_Config.RingNewAbil[CheckBox.Tag];
    end;
  end;
  for I := 0 to GroupBoxHelMetNewAbil.ControlCount - 1 do begin
    if GroupBoxHelMetNewAbil.Controls[I] is TCheckBox then begin
      CheckBox := TCheckBox(GroupBoxHelMetNewAbil.Controls[I]);
      CheckBox.Checked := g_Config.HelMetNewAbil[CheckBox.Tag];
    end;
  end;
  for I := 0 to GroupBoxShoesNewAbil.ControlCount - 1 do begin
    if GroupBoxShoesNewAbil.Controls[I] is TCheckBox then begin
      CheckBox := TCheckBox(GroupBoxShoesNewAbil.Controls[I]);
      CheckBox.Checked := g_Config.ShoesNewAbil[CheckBox.Tag];
    end;
  end;
  for I := 0 to GroupBoxBeltNewAbil.ControlCount - 1 do begin
    if GroupBoxBeltNewAbil.Controls[I] is TCheckBox then begin
      CheckBox := TCheckBox(GroupBoxBeltNewAbil.Controls[I]);
      CheckBox.Checked := g_Config.BeltNewAbil[CheckBox.Tag];
    end;
  end;

  boOpened := True;
  PageControl.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 0;
  AddValuePageControl.ActivePageIndex := 0;
  ItemSetPageControl.ActivePageIndex := 0;
  ItemPointPageControl.ActivePageIndex := 0;
  ShowModal;
end;

procedure TfrmItemSet.ButtonItemSetSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'ItemPowerRate', g_Config.nItemPowerRate);
  Config.WriteInteger('Setup', 'ItemExpRate', g_Config.nItemExpRate);
  Config.WriteInteger('Setup', 'GuildRecallTime', g_Config.nGuildRecallTime);
  Config.WriteInteger('Setup', 'GroupRecallTime', g_Config.nGroupRecallTime);
  Config.WriteInteger('Setup', 'GroupRecallTime', g_Config.nAttackPosionRate);
  Config.WriteInteger('Setup', 'AttackPosionRate', g_Config.nAttackPosionRate);
  Config.WriteInteger('Setup', 'AttackPosionTime', g_Config.nAttackPosionTime);
  Config.WriteBool('Setup', 'UserMoveCanDupObj', g_Config.boUserMoveCanDupObj);
  Config.WriteBool('Setup', 'UserMoveCanOnItem', g_Config.boUserMoveCanOnItem);
  Config.WriteInteger('Setup', 'UserMoveTime', g_Config.dwUserMoveTime);
{$IFEND}
  uModValue();
end;

procedure TfrmItemSet.EditItemExpRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nItemExpRate := EditItemExpRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditItemPowerRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nItemPowerRate := EditItemPowerRate.Value;
  ModValue();
end;

procedure TfrmItemSet.ButtonAddValueSaveClick(Sender: TObject);
begin
  Config.WriteInteger('Setup', 'MonRandomAddValue', g_Config.nMonRandomAddValue);
  Config.WriteInteger('Setup', 'MakeRandomAddValue', g_Config.nMakeRandomAddValue);
  Config.WriteInteger('Setup', 'ScriptRandomAddValue', g_Config.nScriptRandomAddValue);
  Config.WriteInteger('Setup', 'WeaponDCAddValueMaxLimit', g_Config.nWeaponDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'WeaponDCAddValueRate', g_Config.nWeaponDCAddValueRate);
  Config.WriteInteger('Setup', 'WeaponMCAddValueMaxLimit', g_Config.nWeaponMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'WeaponMCAddValueRate', g_Config.nWeaponMCAddValueRate);
  Config.WriteInteger('Setup', 'WeaponSCAddValueMaxLimit', g_Config.nWeaponSCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'WeaponSCAddValueRate', g_Config.nWeaponSCAddValueRate);

  Config.WriteInteger('Setup', 'DressDCAddRate', g_Config.nDressDCAddRate);
  Config.WriteInteger('Setup', 'DressDCAddValueMaxLimit', g_Config.nDressDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DressDCAddValueRate', g_Config.nDressDCAddValueRate);
  Config.WriteInteger('Setup', 'DressMCAddRate', g_Config.nDressMCAddRate);
  Config.WriteInteger('Setup', 'DressMCAddValueMaxLimit', g_Config.nDressMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DressMCAddValueRate', g_Config.nDressMCAddValueRate);
  Config.WriteInteger('Setup', 'DressSCAddRate', g_Config.nDressSCAddRate);
  Config.WriteInteger('Setup', 'DressSCAddValueMaxLimit', g_Config.nDressSCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DressSCAddValueRate', g_Config.nDressSCAddValueRate);

  Config.WriteInteger('Setup', 'NeckLace19DCAddRate', g_Config.nNeckLace19DCAddRate);
  Config.WriteInteger('Setup', 'NeckLace19DCAddValueMaxLimit', g_Config.nNeckLace19DCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace19DCAddValueRate', g_Config.nNeckLace19DCAddValueRate);
  Config.WriteInteger('Setup', 'NeckLace19MCAddRate', g_Config.nNeckLace19MCAddRate);
  Config.WriteInteger('Setup', 'NeckLace19MCAddValueMaxLimit', g_Config.nNeckLace19MCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace19MCAddValueRate', g_Config.nNeckLace19MCAddValueRate);
  Config.WriteInteger('Setup', 'NeckLace19SCAddRate', g_Config.nNeckLace19SCAddRate);
  Config.WriteInteger('Setup', 'NeckLace19SCAddValueMaxLimit', g_Config.nNeckLace19SCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace19SCAddValueRate', g_Config.nNeckLace19SCAddValueRate);

  Config.WriteInteger('Setup', 'NeckLace202124DCAddRate', g_Config.nNeckLace202124DCAddRate);
  Config.WriteInteger('Setup', 'NeckLace202124DCAddValueMaxLimit', g_Config.nNeckLace202124DCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace202124DCAddValueRate', g_Config.nNeckLace202124DCAddValueRate);
  Config.WriteInteger('Setup', 'NeckLace202124MCAddRate', g_Config.nNeckLace202124MCAddRate);
  Config.WriteInteger('Setup', 'NeckLace202124MCAddValueMaxLimit', g_Config.nNeckLace202124MCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace202124MCAddValueRate', g_Config.nNeckLace202124MCAddValueRate);
  Config.WriteInteger('Setup', 'NeckLace202124SCAddRate', g_Config.nNeckLace202124SCAddRate);
  Config.WriteInteger('Setup', 'NeckLace202124SCAddValueMaxLimit', g_Config.nNeckLace202124SCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace202124SCAddValueRate', g_Config.nNeckLace202124SCAddValueRate);

  Config.WriteInteger('Setup', 'Ring22DCAddValueMaxLimit', g_Config.nRing22DCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'Ring22DCAddValueRate', g_Config.nRing22DCAddValueRate);
  Config.WriteInteger('Setup', 'Ring22DCAddRate', g_Config.nRing22DCAddRate);
  Config.WriteInteger('Setup', 'Ring22MCAddValueMaxLimit', g_Config.nRing22MCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'Ring22MCAddValueRate', g_Config.nRing22MCAddValueRate);
  Config.WriteInteger('Setup', 'Ring22MCAddRate', g_Config.nRing22MCAddRate);
  Config.WriteInteger('Setup', 'Ring22SCAddValueMaxLimit', g_Config.nRing22SCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'Ring22SCAddValueRate', g_Config.nRing22SCAddValueRate);
  Config.WriteInteger('Setup', 'Ring22SCAddRate', g_Config.nRing22SCAddRate);

  Config.WriteInteger('Setup', 'ArmRing26DCAddRate', g_Config.nArmRing26DCAddRate);
  Config.WriteInteger('Setup', 'ArmRing26DCAddValueMaxLimit', g_Config.nArmRing26DCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmRing26DCAddValueRate', g_Config.nArmRing26DCAddValueRate);
  Config.WriteInteger('Setup', 'ArmRing26MCAddRate', g_Config.nArmRing26MCAddRate);
  Config.WriteInteger('Setup', 'ArmRing26MCAddValueMaxLimit', g_Config.nArmRing26MCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmRing26MCAddValueRate', g_Config.nArmRing26MCAddValueRate);
  Config.WriteInteger('Setup', 'ArmRing26SCAddRate', g_Config.nArmRing26SCAddRate);
  Config.WriteInteger('Setup', 'ArmRing26SCAddValueMaxLimit', g_Config.nArmRing26SCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmRing26SCAddValueRate', g_Config.nArmRing26SCAddValueRate);

  Config.WriteInteger('Setup', 'Ring23DCAddRate', g_Config.nRing23DCAddRate);
  Config.WriteInteger('Setup', 'Ring23DCAddValueMaxLimit', g_Config.nRing23DCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'Ring23DCAddValueRate', g_Config.nRing23DCAddValueRate);
  Config.WriteInteger('Setup', 'Ring23MCAddRate', g_Config.nRing23MCAddRate);
  Config.WriteInteger('Setup', 'Ring23MCAddValueMaxLimit', g_Config.nRing23MCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'Ring23MCAddValueRate', g_Config.nRing23MCAddValueRate);
  Config.WriteInteger('Setup', 'Ring23SCAddRate', g_Config.nRing23SCAddRate);
  Config.WriteInteger('Setup', 'Ring23SCAddValueMaxLimit', g_Config.nRing23SCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'Ring23SCAddValueRate', g_Config.nRing23SCAddValueRate);

  Config.WriteInteger('Setup', 'HelMetDCAddRate', g_Config.nHelMetDCAddRate);
  Config.WriteInteger('Setup', 'HelMetDCAddValueMaxLimit', g_Config.nHelMetDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelMetDCAddValueRate', g_Config.nHelMetDCAddValueRate);
  Config.WriteInteger('Setup', 'HelMetMCAddRate', g_Config.nHelMetMCAddRate);
  Config.WriteInteger('Setup', 'HelMetMCAddValueMaxLimit', g_Config.nHelMetMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelMetMCAddValueRate', g_Config.nHelMetMCAddValueRate);
  Config.WriteInteger('Setup', 'HelMetSCAddRate', g_Config.nHelMetSCAddRate);
  Config.WriteInteger('Setup', 'HelMetSCAddValueMaxLimit', g_Config.nHelMetSCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelMetSCAddValueRate', g_Config.nHelMetSCAddValueRate);

  uModValue();
end;

procedure TfrmItemSet.EditMonRandomAddValueChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMonRandomAddValue := EditMonRandomAddValue.Value;
  ModValue();
end;

procedure TfrmItemSet.EditMakeRandomAddValueChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMakeRandomAddValue := EditMakeRandomAddValue.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponDCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponDCAddValueMaxLimit := EditWeaponDCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponDCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponDCAddValueRate := EditWeaponDCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponMCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponMCAddValueMaxLimit := EditWeaponMCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponMCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponMCAddValueRate := EditWeaponMCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponSCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponSCAddValueMaxLimit := EditWeaponSCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponSCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponSCAddValueRate := EditWeaponSCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressDCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressDCAddValueMaxLimit := EditDressDCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressDCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressDCAddValueRate := EditDressDCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressMCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressMCAddValueMaxLimit := EditDressMCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressMCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressMCAddValueRate := EditDressMCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressSCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressSCAddValueMaxLimit := EditDressSCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressSCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressSCAddValueRate := EditDressSCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressDCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressDCAddRate := EditDressDCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressMCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressMCAddRate := EditDressMCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressSCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressSCAddRate := EditDressSCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19DCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19DCAddValueMaxLimit := EditNeckLace19DCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19DCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19DCAddValueRate := EditNeckLace19DCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19MCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19MCAddValueMaxLimit := EditNeckLace19MCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19MCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19MCAddValueRate := EditNeckLace19MCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19SCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19SCAddValueMaxLimit := EditNeckLace19SCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19SCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19SCAddValueRate := EditNeckLace19SCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19DCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19DCAddRate := EditNeckLace19DCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19MCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19MCAddRate := EditNeckLace19MCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19SCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19SCAddRate := EditNeckLace19SCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124DCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124DCAddValueMaxLimit := EditNeckLace202124DCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124DCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124DCAddValueRate := EditNeckLace202124DCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124MCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124MCAddValueMaxLimit := EditNeckLace202124MCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124MCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124MCAddValueRate := EditNeckLace202124MCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124SCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124SCAddValueMaxLimit := EditNeckLace202124SCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124SCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124SCAddValueRate := EditNeckLace202124SCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124DCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124DCAddRate := EditNeckLace202124DCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124MCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124MCAddRate := EditNeckLace202124MCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124SCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124SCAddRate := EditNeckLace202124SCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26DCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26DCAddValueMaxLimit := EditArmRing26DCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26DCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26DCAddValueRate := EditArmRing26DCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26MCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26MCAddValueMaxLimit := EditArmRing26MCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26MCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26MCAddValueRate := EditArmRing26MCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26SCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26SCAddValueMaxLimit := EditArmRing26SCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26SCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26SCAddValueRate := EditArmRing26SCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26DCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26DCAddRate := EditArmRing26DCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26MCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26MCAddRate := EditArmRing26MCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26SCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26SCAddRate := EditArmRing26SCAddRate.Value;
  ModValue();
end;


procedure TfrmItemSet.EditRing22DCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22DCAddValueMaxLimit := EditRing22DCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22DCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22DCAddValueRate := EditRing22DCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22MCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22MCAddValueMaxLimit := EditRing22MCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22MCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22MCAddValueRate := EditRing22MCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22SCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22SCAddValueMaxLimit := EditRing22SCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22SCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22SCAddValueRate := EditRing22SCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22DCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22DCAddRate := EditRing22DCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22MCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22MCAddRate := EditRing22MCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22SCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22SCAddRate := EditRing22SCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23DCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23DCAddValueMaxLimit := EditRing23DCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23DCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23DCAddValueRate := EditRing23DCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23MCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23MCAddValueMaxLimit := EditRing23MCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23MCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23MCAddValueRate := EditRing23MCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23SCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23SCAddValueMaxLimit := EditRing23SCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23SCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23SCAddValueRate := EditRing23SCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23DCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23DCAddRate := EditRing23DCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23MCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23MCAddRate := EditRing23MCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23SCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23SCAddRate := EditRing23SCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetDCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetDCAddValueMaxLimit := EditHelMetDCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetDCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetDCAddValueRate := EditHelMetDCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetMCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetMCAddValueMaxLimit := EditHelMetMCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetMCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetMCAddValueRate := EditHelMetMCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetSCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetSCAddValueMaxLimit := EditHelMetSCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetSCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetSCAddValueRate := EditHelMetSCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetDCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetDCAddRate := EditHelMetDCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetMCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetMCAddRate := EditHelMetMCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetSCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetSCAddRate := EditHelMetSCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditGuildRecallTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nGuildRecallTime := EditGuildRecallTime.Value;
  ModValue();
end;

procedure TfrmItemSet.ButtonUnKnowItemSaveClick(Sender: TObject);
begin
  Config.WriteInteger('Setup', 'UnknowRingACAddRate', g_Config.nUnknowRingACAddRate);
  Config.WriteInteger('Setup', 'UnknowRingACAddValueMaxLimit', g_Config.nUnknowRingACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowRingMACAddRate', g_Config.nUnknowRingMACAddRate);
  Config.WriteInteger('Setup', 'UnknowRingMACAddValueMaxLimit', g_Config.nUnknowRingMACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowRingDCAddRate', g_Config.nUnknowRingDCAddRate);
  Config.WriteInteger('Setup', 'UnknowRingDCAddValueMaxLimit', g_Config.nUnknowRingDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowRingMCAddRate', g_Config.nUnknowRingMCAddRate);
  Config.WriteInteger('Setup', 'UnknowRingMCAddValueMaxLimit', g_Config.nUnknowRingMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowRingSCAddRate', g_Config.nUnknowRingSCAddRate);
  Config.WriteInteger('Setup', 'UnknowRingSCAddValueMaxLimit', g_Config.nUnknowRingSCAddValueMaxLimit);

  Config.WriteInteger('Setup', 'UnknowNecklaceACAddRate', g_Config.nUnknowNecklaceACAddRate);
  Config.WriteInteger('Setup', 'UnknowNecklaceACAddValueMaxLimit', g_Config.nUnknowNecklaceACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowNecklaceMACAddRate', g_Config.nUnknowNecklaceMACAddRate);
  Config.WriteInteger('Setup', 'UnknowNecklaceMACAddValueMaxLimit', g_Config.nUnknowNecklaceMACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowNecklaceDCAddRate', g_Config.nUnknowNecklaceDCAddRate);
  Config.WriteInteger('Setup', 'UnknowNecklaceDCAddValueMaxLimit', g_Config.nUnknowNecklaceDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowNecklaceMCAddRate', g_Config.nUnknowNecklaceMCAddRate);
  Config.WriteInteger('Setup', 'UnknowNecklaceMCAddValueMaxLimit', g_Config.nUnknowNecklaceMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowNecklaceSCAddRate', g_Config.nUnknowNecklaceSCAddRate);
  Config.WriteInteger('Setup', 'UnknowNecklaceSCAddValueMaxLimit', g_Config.nUnknowNecklaceSCAddValueMaxLimit);

  Config.WriteInteger('Setup', 'UnknowHelMetACAddRate', g_Config.nUnknowHelMetACAddRate);
  Config.WriteInteger('Setup', 'UnknowHelMetACAddValueMaxLimit', g_Config.nUnknowHelMetACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowHelMetMACAddRate', g_Config.nUnknowHelMetMACAddRate);
  Config.WriteInteger('Setup', 'UnknowHelMetMACAddValueMaxLimit', g_Config.nUnknowHelMetMACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowHelMetDCAddRate', g_Config.nUnknowHelMetDCAddRate);
  Config.WriteInteger('Setup', 'UnknowHelMetDCAddValueMaxLimit', g_Config.nUnknowHelMetDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowHelMetMCAddRate', g_Config.nUnknowHelMetMCAddRate);
  Config.WriteInteger('Setup', 'UnknowHelMetMCAddValueMaxLimit', g_Config.nUnknowHelMetMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowHelMetSCAddRate', g_Config.nUnknowHelMetSCAddRate);
  Config.WriteInteger('Setup', 'UnknowHelMetSCAddValueMaxLimit', g_Config.nUnknowHelMetSCAddValueMaxLimit);
  uModValue();
end;

procedure TfrmItemSet.RefUnknowItem;
begin
  EditUnknowRingDCAddValueMaxLimit.Value := g_Config.nUnknowRingDCAddValueMaxLimit;
  EditUnknowRingDCAddRate.Value := g_Config.nUnknowRingDCAddRate;
  EditUnknowRingMCAddValueMaxLimit.Value := g_Config.nUnknowRingMCAddValueMaxLimit;
  EditUnknowRingMCAddRate.Value := g_Config.nUnknowRingMCAddRate;
  EditUnknowRingSCAddValueMaxLimit.Value := g_Config.nUnknowRingSCAddValueMaxLimit;
  EditUnknowRingSCAddRate.Value := g_Config.nUnknowRingSCAddRate;
  EditUnknowRingACAddValueMaxLimit.Value := g_Config.nUnknowRingACAddValueMaxLimit;
  EditUnknowRingACAddRate.Value := g_Config.nUnknowRingACAddRate;
  EditUnknowRingMACAddValueMaxLimit.Value := g_Config.nUnknowRingMACAddValueMaxLimit;
  EditUnknowRingMACAddRate.Value := g_Config.nUnknowRingMACAddRate;

  EditUnknowNecklaceDCAddValueMaxLimit.Value := g_Config.nUnknowNecklaceDCAddValueMaxLimit;
  EditUnknowNecklaceDCAddRate.Value := g_Config.nUnknowNecklaceDCAddRate;
  EditUnknowNecklaceMCAddValueMaxLimit.Value := g_Config.nUnknowNecklaceMCAddValueMaxLimit;
  EditUnknowNecklaceMCAddRate.Value := g_Config.nUnknowNecklaceMCAddRate;
  EditUnknowNecklaceSCAddValueMaxLimit.Value := g_Config.nUnknowNecklaceSCAddValueMaxLimit;
  EditUnknowNecklaceSCAddRate.Value := g_Config.nUnknowNecklaceSCAddRate;
  EditUnknowNecklaceACAddValueMaxLimit.Value := g_Config.nUnknowNecklaceACAddValueMaxLimit;
  EditUnknowNecklaceACAddRate.Value := g_Config.nUnknowNecklaceACAddRate;
  EditUnknowNecklaceMACAddValueMaxLimit.Value := g_Config.nUnknowNecklaceMACAddValueMaxLimit;
  EditUnknowNecklaceMACAddRate.Value := g_Config.nUnknowNecklaceMACAddRate;

  EditUnknowHelMetDCAddValueMaxLimit.Value := g_Config.nUnknowHelMetDCAddValueMaxLimit;
  EditUnknowHelMetDCAddRate.Value := g_Config.nUnknowHelMetDCAddRate;
  EditUnknowHelMetMCAddValueMaxLimit.Value := g_Config.nUnknowHelMetMCAddValueMaxLimit;
  EditUnknowHelMetMCAddRate.Value := g_Config.nUnknowHelMetMCAddRate;
  EditUnknowHelMetSCAddValueMaxLimit.Value := g_Config.nUnknowHelMetSCAddValueMaxLimit;
  EditUnknowHelMetSCAddRate.Value := g_Config.nUnknowHelMetSCAddRate;
  EditUnknowHelMetACAddValueMaxLimit.Value := g_Config.nUnknowHelMetACAddValueMaxLimit;
  EditUnknowHelMetACAddRate.Value := g_Config.nUnknowHelMetACAddRate;
  EditUnknowHelMetMACAddValueMaxLimit.Value := g_Config.nUnknowHelMetMACAddValueMaxLimit;
  EditUnknowHelMetMACAddRate.Value := g_Config.nUnknowHelMetMACAddRate;
end;


procedure TfrmItemSet.EditUnknowRingDCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingDCAddValueMaxLimit := EditUnknowRingDCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingDCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingDCAddRate := EditUnknowRingDCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingMCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingMCAddValueMaxLimit := EditUnknowRingMCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingMCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingMCAddRate := EditUnknowRingMCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingSCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingSCAddValueMaxLimit := EditUnknowRingSCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingSCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingSCAddRate := EditUnknowRingSCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingACAddValueMaxLimit := EditUnknowRingACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingACAddRate := EditUnknowRingACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingMACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingMACAddValueMaxLimit := EditUnknowRingMACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingMACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingMACAddRate := EditUnknowRingMACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceDCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceDCAddValueMaxLimit := EditUnknowNecklaceDCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceDCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceDCAddRate := EditUnknowNecklaceDCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceMCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceMCAddValueMaxLimit := EditUnknowNecklaceMCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceMCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceMCAddRate := EditUnknowNecklaceMCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceSCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceSCAddValueMaxLimit := EditUnknowNecklaceSCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceSCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceSCAddRate := EditUnknowNecklaceSCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceACAddValueMaxLimit := EditUnknowNecklaceACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceACAddRate := EditUnknowNecklaceACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceMACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceMACAddValueMaxLimit := EditUnknowNecklaceMACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceMACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceMACAddRate := EditUnknowNecklaceMACAddRate.Value;
  ModValue();
end;


procedure TfrmItemSet.EditUnknowHelMetDCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetDCAddValueMaxLimit := EditUnknowHelMetDCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetDCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetDCAddRate := EditUnknowHelMetDCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetMCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetMCAddValueMaxLimit := EditUnknowHelMetMCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetMCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetMCAddRate := EditUnknowHelMetMCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetSCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetSCAddValueMaxLimit := EditUnknowHelMetSCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetSCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetSCAddRate := EditUnknowHelMetSCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetACAddValueMaxLimit := EditUnknowHelMetACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetACAddRate := EditUnknowHelMetACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetMACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetMACAddValueMaxLimit := EditUnknowHelMetMACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetMACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetMACAddRate := EditUnknowHelMetMACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.RefShapeItem;
begin
  EditAttackPosionRate.Value := g_Config.nAttackPosionRate;
  EditAttackPosionTime.Value := g_Config.nAttackPosionTime;
  CheckBoxUserMoveCanDupObj.Checked := g_Config.boUserMoveCanDupObj;
  CheckBoxUserMoveCanOnItem.Checked := g_Config.boUserMoveCanOnItem;
  EditUserMoveTime.Value := g_Config.dwUserMoveTime;
end;

procedure TfrmItemSet.EditAttackPosionRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackPosionRate := EditAttackPosionRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditAttackPosionTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackPosionTime := EditAttackPosionTime.Value;
  ModValue();
end;

procedure TfrmItemSet.CheckBoxUserMoveCanDupObjClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boUserMoveCanDupObj := CheckBoxUserMoveCanDupObj.Checked;
  ModValue();
end;

procedure TfrmItemSet.CheckBoxUserMoveCanOnItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boUserMoveCanOnItem := CheckBoxUserMoveCanOnItem.Checked;
  ModValue();
end;

procedure TfrmItemSet.EditUserMoveTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwUserMoveTime := EditUserMoveTime.Value;
  ModValue();
end;

procedure TfrmItemSet.EditScriptRandomAddValueChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nScriptRandomAddValue := EditScriptRandomAddValue.Value;
  ModValue();
end;

procedure TfrmItemSet.EditMonRandomNewAddValueChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMonRandomNewAddValue := EditMonRandomNewAddValue.Value;
  ModValue();
end;

procedure TfrmItemSet.EditMakeRandomNewAddValueChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMakeRandomNewAddValue := EditMakeRandomNewAddValue.Value;
  ModValue();
end;

procedure TfrmItemSet.EditScriptRandomNewAddValueChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nScriptRandomNewAddValue := EditScriptRandomNewAddValue.Value;
  ModValue();
end;

procedure TfrmItemSet.EditMonRandomNotLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMonRandomNotLimit := EditMonRandomNotLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditMakeRandomNotLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMakeRandomNotLimit := EditMakeRandomNotLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditScriptRandomNotLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nScriptRandomNotLimit := EditScriptRandomNotLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26NewAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26NewAddValueMaxLimit := EditArmRing26NewAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26NewAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26NewAddValueRate := EditArmRing26NewAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26NewAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26NewAddRate := EditArmRing26NewAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22NewAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22NewAddValueMaxLimit := EditRing22NewAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22NewAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22NewAddValueRate := EditRing22NewAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22NewAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22NewAddRate := EditRing22NewAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23NewAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23NewAddValueMaxLimit := EditRing23NewAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23NewAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23NewAddValueRate := EditRing23NewAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23NewAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23NewAddRate := EditRing23NewAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetNewAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetNewAddValueMaxLimit := EditHelMetNewAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetNewAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetNewAddValueRate := EditHelMetNewAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetNewAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetNewAddRate := EditHelMetNewAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponNewAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponNewAddValueMaxLimit := EditWeaponNewAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponNewAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponNewAddValueRate := EditWeaponNewAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressNewAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressNewAddValueMaxLimit := EditDressNewAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressNewAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressNewAddValueRate := EditDressNewAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressNewAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressNewAddRate := EditDressNewAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19NewAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19NewAddValueMaxLimit := EditNeckLace19NewAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19NewAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19NewAddValueRate := EditNeckLace19NewAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19NewAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19NewAddRate := EditNeckLace19NewAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124NewAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124NewAddValueMaxLimit := EditNeckLace202124NewAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124NewAddValueRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124NewAddValueRate := EditNeckLace202124NewAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124NewAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124NewAddRate := EditNeckLace202124NewAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponMaxLimitDayChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponMaxLimitDay := EditWeaponMaxLimitDay.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponLimitDayRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponLimitDayRate := EditWeaponLimitDayRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponNotLimitRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponNotLimitRate := EditWeaponNotLimitRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressMaxLimitDayChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressMaxLimitDay := EditDressMaxLimitDay.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressLimitDayRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressLimitDayRate := EditDressLimitDayRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressNotLimitRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressNotLimitRate := EditDressNotLimitRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLaceMaxLimitDayChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLaceMaxLimitDay := EditNeckLaceMaxLimitDay.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLaceLimitDayRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLaceLimitDayRate := EditNeckLaceLimitDayRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLaceNotLimitRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLaceNotLimitRate := EditNeckLaceNotLimitRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRingMaxLimitDayChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRingMaxLimitDay := EditArmRingMaxLimitDay.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRingLimitDayRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRingLimitDayRate := EditArmRingLimitDayRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRingNotLimitRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRingNotLimitRate := EditArmRingNotLimitRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRingMaxLimitDayChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRingMaxLimitDay := EditRingMaxLimitDay.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRingLimitDayRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRingLimitDayRate := EditRingLimitDayRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRingNotLimitRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRingNotLimitRate := EditRingNotLimitRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetMaxLimitDayChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetMaxLimitDay := EditHelMetMaxLimitDay.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetLimitDayRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetLimitDayRate := EditHelMetLimitDayRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetNotLimitRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetNotLimitRate := EditHelMetNotLimitRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditOtherMaxLimitDayChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nOtherMaxLimitDay := EditOtherMaxLimitDay.Value;
  ModValue();
end;

procedure TfrmItemSet.EditOtherLimitDayRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nOtherLimitDayRate := EditOtherLimitDayRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditOtherNotLimitRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nOtherNotLimitRate := EditOtherNotLimitRate.Value;
  ModValue();
end;

procedure TfrmItemSet.ButtonAddValue2SaveClick(Sender: TObject);
begin

  Config.WriteInteger('Setup', 'MonRandomNewAddValue', g_Config.nMonRandomNewAddValue);
  Config.WriteInteger('Setup', 'MakeRandomNewAddValue', g_Config.nMakeRandomNewAddValue);
  Config.WriteInteger('Setup', 'ScriptRandomNewAddValue', g_Config.nScriptRandomNewAddValue);
  Config.WriteBool('Setup', 'AllowItemAddValue', g_Config.boAllowItemAddValue);

  uModValue();
end;

procedure TfrmItemSet.ButtonItemTimeSaveClick(Sender: TObject);
begin
  Config.WriteInteger('Setup', 'MonRandomNotLimit', g_Config.nMonRandomNotLimit);
  Config.WriteInteger('Setup', 'MakeRandomNotLimit', g_Config.nMakeRandomNotLimit);
  Config.WriteInteger('Setup', 'ScriptRandomNotLimit', g_Config.nScriptRandomNotLimit);
  Config.WriteInteger('Setup', 'ItemMaxLimitDay', g_Config.nItemMaxLimitDay);
  Config.WriteInteger('Setup', 'ItemLimitDayRate', g_Config.nItemLimitDayRate);

  Config.WriteInteger('Setup', 'WeaponNewAddValueMaxLimit', g_Config.nWeaponNewAddValueMaxLimit);
  Config.WriteInteger('Setup', 'WeaponNewAddValueRate', g_Config.nWeaponNewAddValueRate);

  Config.WriteInteger('Setup', 'DressNewAddRate', g_Config.nDressNewAddRate);
  Config.WriteInteger('Setup', 'DressNewAddValueMaxLimit', g_Config.nDressNewAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DressNewAddValueRate', g_Config.nDressNewAddValueRate);

  Config.WriteInteger('Setup', 'NeckLace19NewAddRate', g_Config.nNeckLace19NewAddRate);
  Config.WriteInteger('Setup', 'NeckLace19NewAddValueMaxLimit', g_Config.nNeckLace19NewAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace19NewAddValueRate', g_Config.nNeckLace19NewAddValueRate);

  Config.WriteInteger('Setup', 'NeckLace202124NewAddRate', g_Config.nNeckLace202124NewAddRate);
  Config.WriteInteger('Setup', 'NeckLace202124NewAddValueMaxLimit', g_Config.nNeckLace202124NewAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace202124NewAddValueRate', g_Config.nNeckLace202124NewAddValueRate);

  Config.WriteInteger('Setup', 'Ring22NewAddValueMaxLimit', g_Config.nRing22NewAddValueMaxLimit);
  Config.WriteInteger('Setup', 'Ring22NewAddValueRate', g_Config.nRing22NewAddValueRate);
  Config.WriteInteger('Setup', 'Ring22NewAddRate', g_Config.nRing22NewAddRate);

  Config.WriteInteger('Setup', 'ArmRing26NewAddRate', g_Config.nArmRing26NewAddRate);
  Config.WriteInteger('Setup', 'ArmRing26NewAddValueMaxLimit', g_Config.nArmRing26NewAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmRing26NewAddValueRate', g_Config.nArmRing26NewAddValueRate);

  Config.WriteInteger('Setup', 'Ring23NewAddRate', g_Config.nRing23NewAddRate);
  Config.WriteInteger('Setup', 'Ring23NewAddValueMaxLimit', g_Config.nRing23NewAddValueMaxLimit);
  Config.WriteInteger('Setup', 'Ring23NewAddValueRate', g_Config.nRing23NewAddValueRate);

  Config.WriteInteger('Setup', 'HelMetNewAddRate', g_Config.nHelMetNewAddRate);
  Config.WriteInteger('Setup', 'HelMetNewAddValueMaxLimit', g_Config.nHelMetNewAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelMetNewAddValueRate', g_Config.nHelMetNewAddValueRate);

  Config.WriteInteger('Setup', 'WeaponMaxLimitDay', g_Config.nWeaponMaxLimitDay);
  Config.WriteInteger('Setup', 'WeaponLimitDayRate', g_Config.nWeaponLimitDayRate);
  Config.WriteInteger('Setup', 'WeaponNotLimitRate', g_Config.nWeaponNotLimitRate);
  Config.WriteInteger('Setup', 'DressMaxLimitDay', g_Config.nDressMaxLimitDay);
  Config.WriteInteger('Setup', 'DressLimitDayRate', g_Config.nDressLimitDayRate);
  Config.WriteInteger('Setup', 'DressNotLimitRate', g_Config.nDressNotLimitRate);
  Config.WriteInteger('Setup', 'NeckLaceMaxLimitDay', g_Config.nNeckLaceMaxLimitDay);
  Config.WriteInteger('Setup', 'NeckLaceLimitDayRate', g_Config.nNeckLaceLimitDayRate);
  Config.WriteInteger('Setup', 'NeckLaceNotLimitRate', g_Config.nNeckLaceNotLimitRate);
  Config.WriteInteger('Setup', 'ArmRingMaxLimitDay', g_Config.nArmRingMaxLimitDay);
  Config.WriteInteger('Setup', 'ArmRingLimitDayRate', g_Config.nArmRingLimitDayRate);
  Config.WriteInteger('Setup', 'ArmRingNotLimitRate', g_Config.nArmRingNotLimitRate);
  Config.WriteInteger('Setup', 'RingMaxLimitDay', g_Config.nRingMaxLimitDay);
  Config.WriteInteger('Setup', 'RingLimitDayRate', g_Config.nRingLimitDayRate);
  Config.WriteInteger('Setup', 'RingNotLimitRate', g_Config.nRingNotLimitRate);
  Config.WriteInteger('Setup', 'HelMetMaxLimitDay', g_Config.nHelMetMaxLimitDay);
  Config.WriteInteger('Setup', 'HelMetLimitDayRate', g_Config.nHelMetLimitDayRate);
  Config.WriteInteger('Setup', 'HelMetNotLimitRate', g_Config.nHelMetNotLimitRate);
  Config.WriteInteger('Setup', 'OtherMaxLimitDay', g_Config.nOtherMaxLimitDay);
  Config.WriteInteger('Setup', 'OtherLimitDayRate', g_Config.nOtherLimitDayRate);
  Config.WriteInteger('Setup', 'OtherNotLimitRate', g_Config.nOtherNotLimitRate);

  Config.WriteBool('Setup', 'AllowItemTime', g_Config.boAllowItemTime);

  uModValue();
end;

procedure TfrmItemSet.EditMonRandomAddPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMonRandomAddPoint := EditMonRandomAddPoint.Value;
  ModValue();
end;

procedure TfrmItemSet.EditMakeRandomAddPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMakeRandomAddPoint := EditMakeRandomAddPoint.Value;
  ModValue();
end;

procedure TfrmItemSet.EditScriptRandomAddPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nScriptRandomAddPoint := EditScriptRandomAddPoint.Value;
  ModValue();
end;

procedure TfrmItemSet.RadioGroupWeaponClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponPointType := RadioGroupWeapon.ItemIndex;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponPointAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponPointAddValueMaxLimit := EditWeaponPointAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponPointAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponPointAddValueRate := EditWeaponPointAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponPointAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponPointAddRate := EditWeaponPointAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.RadioGroupDressClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressPointType := RadioGroupDress.ItemIndex;
  ModValue();
end;

procedure TfrmItemSet.EditDressPointAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressPointAddValueMaxLimit := EditDressPointAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressPointAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressPointAddValueRate := EditDressPointAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressPointAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressPointAddRate := EditDressPointAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.RadioGroupNeckLaceClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLacePointType := RadioGroupNeckLace.ItemIndex;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLacePointAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLacePointAddValueMaxLimit := EditNeckLacePointAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLacePointAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLacePointAddValueRate := EditNeckLacePointAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLacePointAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLacePointAddRate := EditNeckLacePointAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.RadioGroupArmRingClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRingPointType := RadioGroupArmRing.ItemIndex;
  ModValue();
end;

procedure TfrmItemSet.EditArmRingPointAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRingPointAddValueMaxLimit := EditArmRingPointAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRingPointAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRingPointAddValueRate := EditArmRingPointAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRingPointAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRingPointAddRate := EditArmRingPointAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.RadioGroupRingClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRingPointType := RadioGroupRing.ItemIndex;
  ModValue();
end;

procedure TfrmItemSet.EditRingPointAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRingPointAddValueMaxLimit := EditRingPointAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRingPointAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRingPointAddValueRate := EditRingPointAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRingPointAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRingPointAddRate := EditRingPointAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.RadioGroupHelMetClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetPointType := RadioGroupHelMet.ItemIndex;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetPointAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetPointAddValueMaxLimit := EditHelMetPointAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetPointAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetPointAddValueRate := EditHelMetPointAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetPointAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetPointAddRate := EditHelMetPointAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.RadioGroupShoesClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nShoesPointType := RadioGroupShoes.ItemIndex;
  ModValue();
end;

procedure TfrmItemSet.EditShoesPointAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nShoesPointAddValueMaxLimit := EditShoesPointAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditShoesPointAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nShoesPointAddValueRate := EditShoesPointAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditShoesPointAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nShoesPointAddRate := EditShoesPointAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.RadioGroupBeltClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBeltPointType := RadioGroupBelt.ItemIndex;
  ModValue();
end;

procedure TfrmItemSet.EditBeltPointAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBeltPointAddValueMaxLimit := EditBeltPointAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditBeltPointAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBeltPointAddValueRate := EditBeltPointAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditBeltPointAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBeltPointAddRate := EditBeltPointAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.ButtonItemPointClick(Sender: TObject);
var
  I: Integer;
begin
  Config.WriteInteger('Setup', 'MonRandomAddPoint', g_Config.nMonRandomAddPoint);
  Config.WriteInteger('Setup', 'MakeRandomAddPoint', g_Config.nMakeRandomAddPoint);
  Config.WriteInteger('Setup', 'ScriptRandomAddPoint', g_Config.nScriptRandomAddPoint);
  Config.WriteInteger('Setup', 'WeaponPointType', g_Config.nWeaponPointType);
  Config.WriteInteger('Setup', 'WeaponPointAddRate', g_Config.nWeaponPointAddRate);
  Config.WriteInteger('Setup', 'WeaponPointAddValueMaxLimit', g_Config.nWeaponPointAddValueMaxLimit);
  Config.WriteInteger('Setup', 'WeaponPointAddValueRate', g_Config.nWeaponPointAddValueRate);
  Config.WriteInteger('Setup', 'DressPointType', g_Config.nDressPointType);
  Config.WriteInteger('Setup', 'DressPointAddRate', g_Config.nDressPointAddRate);
  Config.WriteInteger('Setup', 'DressPointAddValueMaxLimit', g_Config.nDressPointAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DressPointAddValueRate', g_Config.nDressPointAddValueRate);
  Config.WriteInteger('Setup', 'NeckLacePointType', g_Config.nNeckLacePointType);
  Config.WriteInteger('Setup', 'NeckLacePointAddRate', g_Config.nNeckLacePointAddRate);
  Config.WriteInteger('Setup', 'NeckLacePointAddValueMaxLimit', g_Config.nNeckLacePointAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLacePointAddValueRate', g_Config.nNeckLacePointAddValueRate);
  Config.WriteInteger('Setup', 'ArmRingPointType', g_Config.nArmRingPointType);
  Config.WriteInteger('Setup', 'ArmRingPointAddRate', g_Config.nArmRingPointAddRate);
  Config.WriteInteger('Setup', 'ArmRingPointAddValueMaxLimit', g_Config.nArmRingPointAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmRingPointAddValueRate', g_Config.nArmRingPointAddValueRate);
  Config.WriteInteger('Setup', 'RingPointType', g_Config.nRingPointType);
  Config.WriteInteger('Setup', 'RingPointAddRate', g_Config.nRingPointAddRate);
  Config.WriteInteger('Setup', 'RingPointAddValueMaxLimit', g_Config.nRingPointAddValueMaxLimit);
  Config.WriteInteger('Setup', 'RingPointAddValueRate', g_Config.nRingPointAddValueRate);
  Config.WriteInteger('Setup', 'HelMetPointType', g_Config.nHelMetPointType);
  Config.WriteInteger('Setup', 'HelMetPointAddRate', g_Config.nHelMetPointAddRate);
  Config.WriteInteger('Setup', 'HelMetPointAddValueMaxLimit', g_Config.nHelMetPointAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelMetPointAddValueRate', g_Config.nHelMetPointAddValueRate);
  Config.WriteInteger('Setup', 'ShoesPointType', g_Config.nShoesPointType);
  Config.WriteInteger('Setup', 'ShoesPointAddRate', g_Config.nShoesPointAddRate);
  Config.WriteInteger('Setup', 'ShoesPointAddValueMaxLimit', g_Config.nShoesPointAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ShoesPointAddValueRate', g_Config.nShoesPointAddValueRate);
  Config.WriteInteger('Setup', 'BeltPointType', g_Config.nBeltPointType);
  Config.WriteInteger('Setup', 'BeltPointAddRate', g_Config.nBeltPointAddRate);
  Config.WriteInteger('Setup', 'BeltPointAddValueMaxLimit', g_Config.nBeltPointAddValueMaxLimit);
  Config.WriteInteger('Setup', 'BeltPointAddValueRate', g_Config.nBeltPointAddValueRate);

  Config.WriteBool('Setup', 'AllowItemAddPoint', g_Config.boAllowItemAddPoint);


  for I := 0 to 10 do begin
    Config.WriteBool('Setup', 'WeaponNewAbil' + IntToStr(I), g_Config.WeaponNewAbil[I]);
  end;
  for I := 0 to 10 do begin
    Config.WriteBool('Setup', 'DressNewAbil' + IntToStr(I), g_Config.DressNewAbil[I]);
  end;
  for I := 0 to 10 do begin
    Config.WriteBool('Setup', 'NeckLaceNewAbil' + IntToStr(I), g_Config.NeckLaceNewAbil[I]);
  end;
  for I := 0 to 10 do begin
    Config.WriteBool('Setup', 'ArmRingNewAbil' + IntToStr(I), g_Config.ArmRingNewAbil[I]);
  end;
  for I := 0 to 10 do begin
    Config.WriteBool('Setup', 'RingNewAbil' + IntToStr(I), g_Config.RingNewAbil[I]);
  end;
  for I := 0 to 10 do begin
    Config.WriteBool('Setup', 'HelMetNewAbil' + IntToStr(I), g_Config.HelMetNewAbil[I]);
  end;
  for I := 0 to 10 do begin
    Config.WriteBool('Setup', 'ShoesNewAbil' + IntToStr(I), g_Config.ShoesNewAbil[I]);
  end;
  for I := 0 to 10 do begin
    Config.WriteBool('Setup', 'BeltNewAbil' + IntToStr(I), g_Config.BeltNewAbil[I]);
  end;

  uModValue();
end;

procedure TfrmItemSet.CheckBoxAllowItemAddValueClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAllowItemAddValue := CheckBoxAllowItemAddValue.Checked;
  ModValue();
end;

procedure TfrmItemSet.CheckBoxAllowItemAddPointClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAllowItemAddPoint := CheckBoxAllowItemAddPoint.Checked;
  ModValue();
end;

procedure TfrmItemSet.CheckBoxAllowItemTimeClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAllowItemTime := CheckBoxAllowItemTime.Checked;
  ModValue();
end;

procedure TfrmItemSet.CheckBox9Click(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.WeaponNewAbil[TCheckBox(Sender).Tag] := TCheckBox(Sender).Checked;
  ModValue();
end;

procedure TfrmItemSet.CheckBox18Click(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.DressNewAbil[TCheckBox(Sender).Tag] := TCheckBox(Sender).Checked;
  ModValue();
end;

procedure TfrmItemSet.CheckBox45Click(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.NeckLaceNewAbil[TCheckBox(Sender).Tag] := TCheckBox(Sender).Checked;
  ModValue();
end;

procedure TfrmItemSet.CheckBox54Click(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.ArmRingNewAbil[TCheckBox(Sender).Tag] := TCheckBox(Sender).Checked;
  ModValue();
end;

procedure TfrmItemSet.CheckBox63Click(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.RingNewAbil[TCheckBox(Sender).Tag] := TCheckBox(Sender).Checked;
  ModValue();
end;

procedure TfrmItemSet.CheckBox72Click(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.HelMetNewAbil[TCheckBox(Sender).Tag] := TCheckBox(Sender).Checked;
  ModValue();
end;

procedure TfrmItemSet.CheckBox27Click(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.ShoesNewAbil[TCheckBox(Sender).Tag] := TCheckBox(Sender).Checked;
  ModValue();
end;

procedure TfrmItemSet.CheckBox28Click(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.BeltNewAbil[TCheckBox(Sender).Tag] := TCheckBox(Sender).Checked;
  ModValue();
end;

end.
