unit ViewList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, Spin, Grobal2, ExtCtrls;

type
  TfrmViewList = class(TForm)
    PageControlViewList: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    GroupBox2: TGroupBox;
    ListBoxItemList: TListBox;
    GroupBox1: TGroupBox;
    ListBoxEnableMakeList: TListBox;
    ButtonEnableMakeAdd: TButton;
    ButtonEnableMakeDelete: TButton;
    ButtonEnableMakeSave: TButton;
    GroupBox3: TGroupBox;
    ListBoxDisableMakeList: TListBox;
    GroupBox4: TGroupBox;
    ListBoxitemList1: TListBox;
    ButtonDisableMakeAdd: TButton;
    ButtonDisableMakeDelete: TButton;
    ButtonDisableMakeSave: TButton;
    ButtonEnableMakeAddAll: TButton;
    ButtonEnableMakeDeleteAll: TButton;
    ButtonDisableMakeAddAll: TButton;
    ButtonDisableMakeDeleteAll: TButton;
    GridItemBindAccount: TStringGrid;
    GridItemBindCharName: TStringGrid;
    GridItemBindIPaddr: TStringGrid;
    GroupBox5: TGroupBox;
    ListBoxDisableMoveMap: TListBox;
    ButtonDisableMoveMapAdd: TButton;
    ButtonDisableMoveMapDelete: TButton;
    ButtonDisableMoveMapAddAll: TButton;
    ButtonDisableMoveMapDeleteAll: TButton;
    ButtonDisableMoveMapSave: TButton;
    GroupBox6: TGroupBox;
    ListBoxMapList: TListBox;
    TabSheetMonDrop: TTabSheet;
    StringGridMonDropLimit: TStringGrid;
    GroupBox7: TGroupBox;
    ButtonMonDropLimitSave: TButton;
    Label29: TLabel;
    EditDropCount: TSpinEdit;
    Label1: TLabel;
    EditCountLimit: TSpinEdit;
    EditNoDropCount: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    EditItemName: TEdit;
    TabSheet8: TTabSheet;
    GroupBox8: TGroupBox;
    ListBoxGameLogList: TListBox;
    ButtonGameLogAdd: TButton;
    ButtonGameLogDel: TButton;
    ButtonGameLogAddAll: TButton;
    ButtonGameLogDelAll: TButton;
    ButtonGameLogSave: TButton;
    GroupBox9: TGroupBox;
    ListBoxitemList2: TListBox;
    TabSheet9: TTabSheet;
    GroupBox10: TGroupBox;
    ListBoxDisableTakeOffList: TListBox;
    ButtonDisableTakeOffAdd: TButton;
    ButtonDisableTakeOffDel: TButton;
    ButtonDisableTakeOffAddAll: TButton;
    ButtonDisableTakeOffDelAll: TButton;
    ButtonDisableTakeOffSave: TButton;
    GroupBox11: TGroupBox;
    ListBoxitemList3: TListBox;
    TabSheet10: TTabSheet;
    GroupBox12: TGroupBox;
    ListBoxAdminList: TListBox;
    TabSheet11: TTabSheet;
    GroupBox13: TGroupBox;
    ListBoxNoClearMonList: TListBox;
    ButtonNoClearMonAdd: TButton;
    ButtonNoClearMonDel: TButton;
    ButtonNoClearMonAddAll: TButton;
    ButtonNoClearMonDelAll: TButton;
    ButtonNoClearMonSave: TButton;
    GroupBox14: TGroupBox;
    ListBoxMonList: TListBox;
    GroupBox15: TGroupBox;
    Label4: TLabel;
    EditAdminName: TEdit;
    EditAdminPremission: TSpinEdit;
    Label5: TLabel;
    ButtonAdminListAdd: TButton;
    ButtonAdminListChange: TButton;
    ButtonAdminListDel: TButton;
    ButtonAdminLitsSave: TButton;
    ButtonMonDropLimitAdd: TButton;
    ButtonMonDropLimitRef: TButton;
    ButtonMonDropLimitDel: TButton;
    GroupBox16: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ButtonItemBindAcountMod: TButton;
    EditItemBindAccountItemIdx: TSpinEdit;
    EditItemBindAccountItemMakeIdx: TSpinEdit;
    EditItemBindAccountItemName: TEdit;
    ButtonItemBindAcountAdd: TButton;
    ButtonItemBindAcountRef: TButton;
    ButtonItemBindAcountDel: TButton;
    EditItemBindAccountName: TEdit;
    GroupBox17: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ButtonItemBindCharNameMod: TButton;
    EditItemBindCharNameItemIdx: TSpinEdit;
    EditItemBindCharNameItemMakeIdx: TSpinEdit;
    EditItemBindCharNameItemName: TEdit;
    ButtonItemBindCharNameAdd: TButton;
    ButtonItemBindCharNameRef: TButton;
    ButtonItemBindCharNameDel: TButton;
    EditItemBindCharNameName: TEdit;
    GroupBox18: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    ButtonItemBindIPaddrMod: TButton;
    EditItemBindIPaddrItemIdx: TSpinEdit;
    EditItemBindIPaddrItemMakeIdx: TSpinEdit;
    EditItemBindIPaddrItemName: TEdit;
    ButtonItemBindIPaddrAdd: TButton;
    ButtonItemBindIPaddrRef: TButton;
    ButtonItemBindIPaddrDel: TButton;
    EditItemBindIPaddrName: TEdit;
    TabSheet12: TTabSheet;
    GridItemNameList: TStringGrid;
    GroupBox19: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    ButtonItemNameMod: TButton;
    EditItemNameIdx: TSpinEdit;
    EditItemNameMakeIndex: TSpinEdit;
    EditItemNameOldName: TEdit;
    ButtonItemNameAdd: TButton;
    ButtonItemNameRef: TButton;
    ButtonItemNameDel: TButton;
    EditItemNameNewName: TEdit;
    LabelAdminIPaddr: TLabel;
    EditAdminIPaddr: TEdit;
    TabSheet13: TTabSheet;
    GroupBox20: TGroupBox;
    ListBoxSellOffList: TListBox;
    GroupBox21: TGroupBox;
    ListBoxitemList4: TListBox;
    ButtonSellOffAdd: TButton;
    ButtonSellOffDel: TButton;
    ButtonSellOffAddAll: TButton;
    ButtonSellOffDelAll: TButton;
    ButtonSellOffSave: TButton;
    TabSheet14: TTabSheet;
    GroupBox22: TGroupBox;
    ListBoxAllowPickUpItem: TListBox;
    GroupBox23: TGroupBox;
    ListBoxitemList5: TListBox;
    ButtonPickItemAdd: TButton;
    ButtonPickItemDel: TButton;
    ButtonPickItemAddAll: TButton;
    ButtonPickItemDelAll: TButton;
    ButtonPickItemSave: TButton;
    TabSheet15: TTabSheet;
    ButtonGroupItemAdd: TButton;
    ButtonGroupItemDel: TButton;
    ButtonGroupItemChg: TButton;
    ButtonGroupItemSave: TButton;
    GroupBox26: TGroupBox;
    ListBox1: TListBox;
    GroupBox27: TGroupBox;
    ListBox2: TListBox;
    ButtonUpgradeAdd: TButton;
    ButtonUpgradeDel: TButton;
    ButtonUpgradeAddAll: TButton;
    ButtonUpgradeDelAll: TButton;
    ButtonUpgradesave: TButton;
    TabSheet16: TTabSheet;
    GroupBox28: TGroupBox;
    ListBoxitemList6: TListBox;
    GroupBox29: TGroupBox;
    ListBoxAllowScatterItem: TListBox;
    ButtonScatterItemAdd: TButton;
    ButtonScatterItemDel: TButton;
    ButtonScatterItemAddAll: TButton;
    ButtonScatterItemDelAll: TButton;
    ButtonScatterItemSave: TButton;
    GroupBoxUseGroupItem: TGroupBox;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    EditDRESSNAME: TEdit;
    EditWEAPONNAME: TEdit;
    EditNECKLACENAME: TEdit;
    EditRIGHTHANDNAME: TEdit;
    EditRINGLNAME: TEdit;
    EditARMRINGRNAME: TEdit;
    EditARMRINGLNAME: TEdit;
    EditHELMETNAME: TEdit;
    EditBELTNAME: TEdit;
    EditBUJUKNAME: TEdit;
    EditRINGRNAME: TEdit;
    EditBOOTSNAME: TEdit;
    EditCHARMNAME: TEdit;
    GroupBoxGroupItem: TGroupBox;
    lbl9: TLabel;
    lbl11: TLabel;
    lbl14: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    lbl25: TLabel;
    lbl27: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label30: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    EditGroupItemDCRate: TSpinEdit;
    EditGroupItemMCRate: TSpinEdit;
    EditGroupItemSCRate: TSpinEdit;
    EditGroupItemHPRate: TSpinEdit;
    EditGroupItemMPRate: TSpinEdit;
    EditGroupItemACRate: TSpinEdit;
    EditGroupItemMACRate: TSpinEdit;
    EditHitPoint: TSpinEdit;
    EditSpeedPoint: TSpinEdit;
    EditAntiMagic: TSpinEdit;
    EditAntiPoison: TSpinEdit;
    EditPoisonRecover: TSpinEdit;
    EditHealthRecover: TSpinEdit;
    EditSpellRecover: TSpinEdit;
    CheckBoxGroupItemFlag1: TCheckBox;
    CheckBoxGroupItemFlag2: TCheckBox;
    CheckBoxGroupItemFlag3: TCheckBox;
    CheckBoxGroupItemFlag4: TCheckBox;
    CheckBoxGroupItemFlag8: TCheckBox;
    CheckBoxGroupItemFlag7: TCheckBox;
    CheckBoxGroupItemFlag6: TCheckBox;
    CheckBoxGroupItemFlag5: TCheckBox;
    CheckBoxGroupItemFlag16: TCheckBox;
    CheckBoxGroupItemFlag15: TCheckBox;
    CheckBoxGroupItemFlag14: TCheckBox;
    CheckBoxGroupItemFlag13: TCheckBox;
    CheckBoxGroupItemFlag12: TCheckBox;
    CheckBoxGroupItemFlag11: TCheckBox;
    CheckBoxGroupItemFlag10: TCheckBox;
    CheckBoxGroupItemFlag9: TCheckBox;
    GroupBox24: TGroupBox;
    ListViewGroupItemList: TListView;
    EditGroupItemHint: TEdit;
    lbl29: TLabel;
    TabSheet17: TTabSheet;
    GroupBox72: TGroupBox;
    ListViewBoxItems: TListView;
    GroupBox71: TGroupBox;
    ListBoxBoxs: TListBox;
    EditBoxItemCount: TSpinEdit;
    Label171: TLabel;
    ButtonBoxItemAdd: TButton;
    ButtonBoxItemDel: TButton;
    ButtonBoxItemSave: TButton;
    GroupBox25: TGroupBox;
    ListBoxitemList7: TListBox;
    RadioGroupBoxItemType: TRadioGroup;
    Label170: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ListBoxItemListClick(Sender: TObject);
    procedure ListBoxEnableMakeListClick(Sender: TObject);
    procedure ButtonEnableMakeAddClick(Sender: TObject);
    procedure ButtonEnableMakeDeleteClick(Sender: TObject);
    procedure ButtonEnableMakeSaveClick(Sender: TObject);
    procedure ButtonDisableMakeAddAllClick(Sender: TObject);
    procedure ButtonDisableMakeDeleteAllClick(Sender: TObject);
    procedure ButtonEnableMakeAddAllClick(Sender: TObject);
    procedure ButtonEnableMakeDeleteAllClick(Sender: TObject);
    procedure ListBoxitemList1Click(Sender: TObject);
    procedure ListBoxDisableMakeListClick(Sender: TObject);
    procedure ButtonDisableMakeAddClick(Sender: TObject);
    procedure ButtonDisableMakeDeleteClick(Sender: TObject);
    procedure ButtonDisableMakeSaveClick(Sender: TObject);
    procedure ButtonDisableMoveMapAddClick(Sender: TObject);
    procedure ButtonDisableMoveMapDeleteClick(Sender: TObject);
    procedure ButtonDisableMoveMapAddAllClick(Sender: TObject);
    procedure ButtonDisableMoveMapSaveClick(Sender: TObject);
    procedure ButtonDisableMoveMapDeleteAllClick(Sender: TObject);
    procedure ListBoxMapListClick(Sender: TObject);
    procedure ListBoxDisableMoveMapClick(Sender: TObject);
    procedure ButtonMonDropLimitRefClick(Sender: TObject);
    procedure StringGridMonDropLimitClick(Sender: TObject);
    procedure EditDropCountChange(Sender: TObject);
    procedure EditCountLimitChange(Sender: TObject);
    procedure EditNoDropCountChange(Sender: TObject);
    procedure ButtonMonDropLimitSaveClick(Sender: TObject);
    procedure ListBoxGameLogListClick(Sender: TObject);
    procedure ListBoxitemList2Click(Sender: TObject);
    procedure ButtonGameLogAddClick(Sender: TObject);
    procedure ButtonGameLogDelClick(Sender: TObject);
    procedure ButtonGameLogAddAllClick(Sender: TObject);
    procedure ButtonGameLogDelAllClick(Sender: TObject);
    procedure ButtonGameLogSaveClick(Sender: TObject);
    procedure ButtonDisableTakeOffAddClick(Sender: TObject);
    procedure ButtonDisableTakeOffDelClick(Sender: TObject);
    procedure ListBoxDisableTakeOffListClick(Sender: TObject);
    procedure ListBoxitemList3Click(Sender: TObject);
    procedure ButtonDisableTakeOffAddAllClick(Sender: TObject);
    procedure ButtonDisableTakeOffDelAllClick(Sender: TObject);
    procedure ButtonDisableTakeOffSaveClick(Sender: TObject);
    procedure ButtonNoClearMonAddClick(Sender: TObject);
    procedure ButtonNoClearMonDelClick(Sender: TObject);
    procedure ButtonNoClearMonAddAllClick(Sender: TObject);
    procedure ButtonNoClearMonDelAllClick(Sender: TObject);
    procedure ButtonNoClearMonSaveClick(Sender: TObject);
    procedure ListBoxNoClearMonListClick(Sender: TObject);
    procedure ListBoxMonListClick(Sender: TObject);
    procedure ButtonAdminLitsSaveClick(Sender: TObject);
    procedure ListBoxAdminListClick(Sender: TObject);
    procedure ButtonAdminListChangeClick(Sender: TObject);
    procedure ButtonAdminListAddClick(Sender: TObject);
    procedure ButtonAdminListDelClick(Sender: TObject);
    procedure ButtonMonDropLimitAddClick(Sender: TObject);
    procedure ButtonMonDropLimitDelClick(Sender: TObject);
    procedure GridItemBindAccountClick(Sender: TObject);
    procedure EditItemBindAccountItemIdxChange(Sender: TObject);
    procedure EditItemBindAccountItemMakeIdxChange(Sender: TObject);
    procedure ButtonItemBindAcountModClick(Sender: TObject);
    procedure EditItemBindAccountNameChange(Sender: TObject);
    procedure ButtonItemBindAcountRefClick(Sender: TObject);
    procedure ButtonItemBindAcountAddClick(Sender: TObject);
    procedure ButtonItemBindAcountDelClick(Sender: TObject);
    procedure GridItemBindCharNameClick(Sender: TObject);
    procedure EditItemBindCharNameItemIdxChange(Sender: TObject);
    procedure EditItemBindCharNameItemMakeIdxChange(Sender: TObject);
    procedure EditItemBindCharNameNameChange(Sender: TObject);
    procedure ButtonItemBindCharNameAddClick(Sender: TObject);
    procedure ButtonItemBindCharNameModClick(Sender: TObject);
    procedure ButtonItemBindCharNameDelClick(Sender: TObject);
    procedure ButtonItemBindCharNameRefClick(Sender: TObject);
    procedure GridItemBindIPaddrClick(Sender: TObject);
    procedure EditItemBindIPaddrItemIdxChange(Sender: TObject);
    procedure EditItemBindIPaddrItemMakeIdxChange(Sender: TObject);
    procedure EditItemBindIPaddrNameChange(Sender: TObject);
    procedure ButtonItemBindIPaddrAddClick(Sender: TObject);
    procedure ButtonItemBindIPaddrModClick(Sender: TObject);
    procedure ButtonItemBindIPaddrDelClick(Sender: TObject);
    procedure ButtonItemBindIPaddrRefClick(Sender: TObject);
    procedure EditItemNameIdxChange(Sender: TObject);
    procedure EditItemNameMakeIndexChange(Sender: TObject);
    procedure EditItemNameNewNameChange(Sender: TObject);
    procedure ButtonItemNameAddClick(Sender: TObject);
    procedure ButtonItemNameModClick(Sender: TObject);
    procedure ButtonItemNameDelClick(Sender: TObject);
    procedure GridItemNameListClick(Sender: TObject);
    procedure ButtonItemNameRefClick(Sender: TObject);
    procedure ListBoxitemList4Click(Sender: TObject);
    procedure ButtonSellOffDelClick(Sender: TObject);
    procedure ListBoxSellOffListClick(Sender: TObject);
    procedure ButtonSellOffAddAllClick(Sender: TObject);
    procedure ButtonSellOffDelAllClick(Sender: TObject);
    procedure ButtonSellOffSaveClick(Sender: TObject);
    procedure ButtonSellOffAddClick(Sender: TObject);
    procedure ListBoxAllowPickUpItemClick(Sender: TObject);
    procedure ListBoxitemList5Click(Sender: TObject);
    procedure ButtonPickItemAddAllClick(Sender: TObject);
    procedure ButtonPickItemDelAllClick(Sender: TObject);
    procedure ButtonPickItemSaveClick(Sender: TObject);
    procedure ButtonPickItemAddClick(Sender: TObject);
    procedure ButtonPickItemDelClick(Sender: TObject);
    procedure ButtonGroupItemAddClick(Sender: TObject);
    procedure ButtonGroupItemDelClick(Sender: TObject);
    procedure ButtonGroupItemChgClick(Sender: TObject);
    procedure ListViewGroupItemClick(Sender: TObject);
    procedure ButtonGroupItemSaveClick(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ButtonUpgradeAddClick(Sender: TObject);
    procedure ButtonUpgradeDelClick(Sender: TObject);
    procedure ButtonUpgradeAddAllClick(Sender: TObject);
    procedure ButtonUpgradeDelAllClick(Sender: TObject);
    procedure ButtonUpgradesaveClick(Sender: TObject);
    procedure ButtonScatterItemAddClick(Sender: TObject);
    procedure ButtonScatterItemDelClick(Sender: TObject);
    procedure ButtonScatterItemAddAllClick(Sender: TObject);
    procedure ButtonScatterItemDelAllClick(Sender: TObject);
    procedure ButtonScatterItemSaveClick(Sender: TObject);
    procedure ListBoxAllowScatterItemClick(Sender: TObject);
    procedure ListBoxitemList6Click(Sender: TObject);
    procedure ListViewGroupItemListClick(Sender: TObject);
    procedure ButtonBoxItemAddClick(Sender: TObject);
    procedure ListBoxBoxsClick(Sender: TObject);
    procedure ButtonBoxItemDelClick(Sender: TObject);
    procedure ListViewBoxItemsClick(Sender: TObject);
    procedure RadioGroupBoxItemTypeClick(Sender: TObject);
    procedure ListBoxitemList7Click(Sender: TObject);
    procedure ButtonBoxItemSaveClick(Sender: TObject);
    procedure EditBoxItemCountChange(Sender: TObject);
  private
    boOpened: Boolean;
    boModValued: Boolean;

    procedure ModValue();
    procedure uModValue();
    procedure RefMonDropLimit();
    procedure RefAdminList;
    procedure RefNoClearMonList();
    procedure RefItemBindAccount();
    procedure RefItemBindCharName();
    procedure RefItemBindIPaddr();
    procedure RefItemCustomNameList();
    procedure RefMsgFilterList();
    procedure RefGroupItemList;

    procedure RefListViewBoxItems(ItemList: TStringList);
    procedure RefItemBox();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmViewList: TfrmViewList;

implementation

uses M2Share, UsrEngn, Envir, HUtil32, LocalDB, GroupItems;
var
  SelBoxItem: pTBoxItem;
  SelItemBox: pTItemBox;
{$R *.dfm}

{ TfrmViewList }

procedure TfrmViewList.ModValue;
begin
  boModValued := True;
  ButtonEnableMakeSave.Enabled := True;
  ButtonDisableMakeSave.Enabled := True;
  ButtonDisableMoveMapSave.Enabled := True;
  ButtonGameLogSave.Enabled := True;
  ButtonDisableTakeOffSave.Enabled := True;
  ButtonNoClearMonSave.Enabled := True;
  ButtonSellOffSave.Enabled := True;
  ButtonPickItemSave.Enabled := True;
  ButtonGroupItemSave.Enabled := True;
  ButtonUpgradesave.Enabled := True;
  ButtonScatterItemSave.Enabled := True;
  ButtonBoxItemSave.Enabled := True;
end;

procedure TfrmViewList.uModValue;
begin
  boModValued := False;
  ButtonEnableMakeSave.Enabled := False;
  ButtonDisableMakeSave.Enabled := False;
  ButtonDisableMoveMapSave.Enabled := False;
  ButtonGameLogSave.Enabled := False;
  ButtonDisableTakeOffSave.Enabled := False;
  ButtonNoClearMonSave.Enabled := False;
  ButtonSellOffSave.Enabled := False;
  ButtonPickItemSave.Enabled := False;
  ButtonGroupItemSave.Enabled := False;
  ButtonUpgradesave.Enabled := False;
  ButtonScatterItemSave.Enabled := False;
  ButtonBoxItemSave.Enabled := False;
end;

procedure TfrmViewList.Open;
var
  I: Integer;
  StdItem: pTStdItem;
  Envir: TEnvirnoment;
begin
  boOpened := False;
  uModValue();
  ListBoxDisableMakeList.Items.Clear;
  ListBoxEnableMakeList.Items.Clear;
  ListBoxItemList.Items.Clear;
  ListBoxitemList1.Items.Clear;
  ListBoxitemList4.Items.Clear;
  ListBoxitemList5.Items.Clear;
  ListBoxitemList6.Items.Clear;
  ListBoxitemList7.Items.Clear;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    ListBoxitemList2.Items.AddObject(g_sHumanDieEvent, TObject(nil));
    ListBoxitemList2.Items.AddObject(sSTRING_GOLDNAME, TObject(nil));
    ListBoxitemList2.Items.AddObject(g_Config.sGameGoldName, TObject(nil));
    ListBoxitemList2.Items.AddObject(g_Config.sGamePointName, TObject(nil));
    for I := 0 to UserEngine.StdItemList.Count - 1 do begin
      StdItem := UserEngine.StdItemList.Items[I];
      ListBoxItemList.Items.AddObject(StdItem.Name, TObject(StdItem));
      ListBoxitemList1.Items.AddObject(StdItem.Name, TObject(StdItem));
      ListBoxitemList2.Items.AddObject(StdItem.Name, TObject(StdItem));
      ListBoxitemList3.Items.AddObject(StdItem.Name, TObject(I));
      ListBoxitemList4.Items.AddObject(StdItem.Name, TObject(I));
      ListBoxitemList5.Items.AddObject(StdItem.Name, TObject(I));
      ListBoxitemList6.Items.AddObject(StdItem.Name, TObject(I));
      ListBoxitemList7.Items.AddObject(StdItem.Name, TObject(StdItem));
      ListBox2.Items.AddObject(StdItem.Name, TObject(I));
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;

  for I := 0 to g_MapManager.Count - 1 do begin
    Envir := TEnvirnoment(g_MapManager.Items[I]);
    ListBoxMapList.Items.Add(Envir.sMapName);
  end;

  g_EnableMakeItemList.Lock;
  try
    for I := 0 to g_EnableMakeItemList.Count - 1 do begin
      ListBoxEnableMakeList.Items.Add(g_EnableMakeItemList.Strings[I]);
    end;
  finally
    g_EnableMakeItemList.UnLock;
  end;

  g_DisableMakeItemList.Lock;
  try
    for I := 0 to g_DisableMakeItemList.Count - 1 do begin
      ListBoxDisableMakeList.Items.Add(g_DisableMakeItemList.Strings[I]);
    end;
  finally
    g_DisableMakeItemList.UnLock;
  end;

  g_GameLogItemNameList.Lock;
  try
    for I := 0 to g_GameLogItemNameList.Count - 1 do begin
      ListBoxGameLogList.Items.Add(g_GameLogItemNameList.Strings[I]);
    end;
  finally
    g_GameLogItemNameList.UnLock;
  end;

  g_DisableTakeOffList.Lock;
  try
    for I := 0 to g_DisableTakeOffList.Count - 1 do begin
      ListBoxDisableTakeOffList.Items.AddObject(IntToStr(Integer(g_DisableTakeOffList.Objects[I])) + '  ' + g_DisableTakeOffList.Strings[I], g_DisableTakeOffList.Objects[I]);
    end;
  finally
    g_DisableTakeOffList.UnLock;
  end;

  g_AllowSellOffItemList.Lock;
  try
    for I := 0 to g_AllowSellOffItemList.Count - 1 do begin
      ListBoxSellOffList.Items.Add(g_AllowSellOffItemList.Strings[I]);
    end;
  finally
    g_AllowSellOffItemList.UnLock;
  end;

    ListBoxAllowPickUpItem.Items.Clear;
    g_AllowPickUpItemList.Lock;
    try
      ListBoxAllowPickUpItem.Items.AddStrings(g_AllowPickUpItemList);
      {for I := 0 to g_AllowPickUpItemList.Count - 1 do begin
        //if g_AllowPickUpItemList.Strings[i][1]<> ';' then
        ListBoxAllowPickUpItem.Items.Add(g_AllowPickUpItemList.Strings[I]);
      end; }
    finally
      g_AllowPickUpItemList.UnLock;
    end;

  if g_AllowScatterItemList <> nil then begin
    ListBoxAllowScatterItem.Items.Clear;
    g_AllowScatterItemList.Lock;
    try
      for I := 0 to g_AllowScatterItemList.Count - 1 do begin
        ListBoxAllowScatterItem.Items.Add(g_AllowScatterItemList.Strings[I]);
      end;
    finally
      g_AllowScatterItemList.UnLock;
    end;
  end;


  g_DisableMoveMapList.Lock;
  try
    for I := 0 to g_DisableMoveMapList.Count - 1 do begin
      ListBoxDisableMoveMap.Items.Add(g_DisableMoveMapList.Strings[I]);
    end;
  finally
    g_DisableMoveMapList.UnLock;
  end;


  g_EnableUpgradeItemList.Lock;
  try
    for I := 0 to g_EnableUpgradeItemList.Count - 1 do begin
      ListBox1.Items.Add(g_EnableUpgradeItemList.Strings[I]);
    end;
  finally
    g_EnableUpgradeItemList.UnLock;
  end;


  RefItemBindAccount();

  RefItemBindCharName();

  RefItemBindIPaddr();

  RefMonDropLimit();
  RefAdminList();
  RefNoClearMonList();
  RefItemCustomNameList();
  RefMsgFilterList();

  RefGroupItemList;
  RefItemBox();
  boOpened := True;
  PageControlViewList.ActivePageIndex := 0;
  ShowModal;
end;

procedure TfrmViewList.FormCreate(Sender: TObject);
begin
  GridItemBindAccount.Cells[0, 0] := '物品名称';
  GridItemBindAccount.Cells[1, 0] := '物品IDX';
  GridItemBindAccount.Cells[2, 0] := '物品系列号';
  GridItemBindAccount.Cells[3, 0] := '绑定帐号';

  GridItemBindCharName.Cells[0, 0] := '物品名称';
  GridItemBindCharName.Cells[1, 0] := '物品IDX';
  GridItemBindCharName.Cells[2, 0] := '物品系列号';
  GridItemBindCharName.Cells[3, 0] := '绑定人物';

  GridItemBindIPaddr.Cells[0, 0] := '物品名称';
  GridItemBindIPaddr.Cells[1, 0] := '物品IDX';
  GridItemBindIPaddr.Cells[2, 0] := '物品系列号';
  GridItemBindIPaddr.Cells[3, 0] := '绑定IP';


  StringGridMonDropLimit.Cells[0, 0] := '物品名称';
  StringGridMonDropLimit.Cells[1, 0] := '爆数量';
  StringGridMonDropLimit.Cells[2, 0] := '限制数量';
  StringGridMonDropLimit.Cells[3, 0] := '未爆数量';

  GridItemNameList.Cells[0, 0] := '原始名称';
  GridItemNameList.Cells[1, 0] := '物品编号';
  GridItemNameList.Cells[2, 0] := '自定义名称';

  TabSheetMonDrop.TabVisible := True;



  ButtonEnableMakeAdd.Enabled := False;
  ButtonEnableMakeDelete.Enabled := False;
  ButtonDisableMakeAdd.Enabled := False;
  ButtonDisableMakeDelete.Enabled := False;
  ButtonDisableMoveMapAdd.Enabled := False;
  ButtonDisableMoveMapDelete.Enabled := False;
  ButtonGameLogAdd.Enabled := False;
  ButtonGameLogDel.Enabled := False;

  ButtonNoClearMonAdd.Enabled := False;
  ButtonDisableTakeOffDel.Enabled := False;

  ButtonDisableTakeOffAdd.Enabled := False;
  ButtonNoClearMonDel.Enabled := False;

  ButtonSellOffAdd.Enabled := False;
  ButtonSellOffDel.Enabled := False;
  ButtonPickItemAdd.Enabled := False;
  ButtonPickItemDel.Enabled := False;

  ButtonScatterItemAdd.Enabled := False;
  ButtonScatterItemDel.Enabled := False;
{$IF SoftVersion = VERDEMO}
  Caption := '查看列表信息[演示版本，所有设置调整有效，但不能保存]';
{$IFEND}

{$IF VEROWNER = WL}
  EditAdminIPaddr.Visible := True;
  LabelAdminIPaddr.Visible := True;
{$ELSE}
  EditAdminIPaddr.Visible := False;
  LabelAdminIPaddr.Visible := False;
{$IFEND}
end;

procedure TfrmViewList.RefItemBox();
var
  I: Integer;
  ItemBox: pTItemBox;
begin
  SelBoxItem := nil;
  SelItemBox := nil;
  ListBoxBoxs.Items.Clear;
  ListViewBoxItems.Items.Clear;
  ListBoxBoxs.Items.AddStrings(g_ItemBoxList);
  ButtonBoxItemAdd.Enabled := False;
  ButtonBoxItemDel.Enabled := False;
  ButtonBoxItemSave.Enabled := False;
  ButtonBoxItemDel.Enabled := False;
end;

procedure TfrmViewList.ListBoxItemListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxItemList.ItemIndex >= 0 then
    ButtonEnableMakeAdd.Enabled := True;
end;

procedure TfrmViewList.ListBoxEnableMakeListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxEnableMakeList.ItemIndex >= 0 then
    ButtonEnableMakeDelete.Enabled := True;
end;

procedure TfrmViewList.ButtonEnableMakeAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBoxItemList.ItemIndex >= 0 then begin
    for I := 0 to ListBoxEnableMakeList.Items.Count - 1 do begin
      if ListBoxEnableMakeList.Items.Strings[I] = ListBoxItemList.Items.Strings[ListBoxItemList.ItemIndex] then begin
        Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    ListBoxEnableMakeList.Items.Add(ListBoxItemList.Items.Strings[ListBoxItemList.ItemIndex]);
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonEnableMakeAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxEnableMakeList.Items.Clear;
  for I := 0 to ListBoxItemList.Items.Count - 1 do begin
    ListBoxEnableMakeList.Items.Add(ListBoxItemList.Items.Strings[I]);
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonEnableMakeDeleteAllClick(Sender: TObject);
begin
  ListBoxEnableMakeList.Items.Clear;
  ButtonEnableMakeDelete.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ButtonEnableMakeDeleteClick(Sender: TObject);
begin
  if ListBoxEnableMakeList.ItemIndex >= 0 then begin
    ListBoxEnableMakeList.Items.Delete(ListBoxEnableMakeList.ItemIndex);
    ModValue();
  end;
  if ListBoxEnableMakeList.ItemIndex < 0 then
    ButtonEnableMakeDelete.Enabled := False;
end;


procedure TfrmViewList.ButtonEnableMakeSaveClick(Sender: TObject);
var
  I: Integer;
begin
  g_EnableMakeItemList.Lock;
  try
    g_EnableMakeItemList.Clear;
    for I := 0 to ListBoxEnableMakeList.Items.Count - 1 do begin
      g_EnableMakeItemList.Add(ListBoxEnableMakeList.Items.Strings[I])
    end;
  finally
    g_EnableMakeItemList.UnLock;
  end;
  SaveEnableMakeItem();
  uModValue();
end;

procedure TfrmViewList.ListBoxitemList1Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxitemList1.ItemIndex >= 0 then
    ButtonDisableMakeAdd.Enabled := True;
end;

procedure TfrmViewList.ListBoxDisableMakeListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxDisableMakeList.ItemIndex >= 0 then
    ButtonDisableMakeDelete.Enabled := True;
end;

procedure TfrmViewList.ButtonDisableMakeAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBoxitemList1.ItemIndex >= 0 then begin
    for I := 0 to ListBoxDisableMakeList.Items.Count - 1 do begin
      if ListBoxDisableMakeList.Items.Strings[I] = ListBoxitemList1.Items.Strings[ListBoxitemList1.ItemIndex] then begin
        Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    ListBoxDisableMakeList.Items.Add(ListBoxitemList1.Items.Strings[ListBoxitemList1.ItemIndex]);
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonDisableMakeDeleteClick(Sender: TObject);
begin
  if ListBoxDisableMakeList.ItemIndex >= 0 then begin
    ListBoxDisableMakeList.Items.Delete(ListBoxDisableMakeList.ItemIndex);
    ModValue();
  end;
  if ListBoxDisableMakeList.ItemIndex < 0 then
    ButtonDisableMakeDelete.Enabled := False;
end;

procedure TfrmViewList.ButtonDisableMakeAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxDisableMakeList.Items.Clear;
  for I := 0 to ListBoxitemList1.Items.Count - 1 do begin
    ListBoxDisableMakeList.Items.Add(ListBoxitemList1.Items.Strings[I]);
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonDisableMakeDeleteAllClick(Sender: TObject);
begin
  ListBoxDisableMakeList.Items.Clear;
  ButtonDisableMakeDelete.Enabled := False;
  ModValue();
end;



procedure TfrmViewList.ButtonDisableMakeSaveClick(Sender: TObject);
var
  I: Integer;
begin
  g_DisableMakeItemList.Lock;
  try
    g_DisableMakeItemList.Clear;
    for I := 0 to ListBoxDisableMakeList.Items.Count - 1 do begin
      g_DisableMakeItemList.Add(ListBoxDisableMakeList.Items.Strings[I])
    end;
  finally
    g_DisableMakeItemList.UnLock;
  end;
  SaveDisableMakeItem();
  uModValue();
end;

procedure TfrmViewList.ButtonDisableMoveMapAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBoxMapList.ItemIndex >= 0 then begin
    for I := 0 to ListBoxDisableMoveMap.Items.Count - 1 do begin
      if ListBoxDisableMoveMap.Items.Strings[I] = ListBoxMapList.Items.Strings[ListBoxMapList.ItemIndex] then begin
        Application.MessageBox('此地图已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    ListBoxDisableMoveMap.Items.Add(ListBoxMapList.Items.Strings[ListBoxMapList.ItemIndex]);
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonDisableMoveMapDeleteClick(Sender: TObject);
begin
  if ListBoxDisableMoveMap.ItemIndex >= 0 then begin
    ListBoxDisableMoveMap.Items.Delete(ListBoxDisableMoveMap.ItemIndex);
    ModValue();
  end;
  if ListBoxDisableMoveMap.ItemIndex < 0 then
    ButtonDisableMoveMapDelete.Enabled := False;
end;

procedure TfrmViewList.ButtonDisableMoveMapAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxDisableMoveMap.Items.Clear;
  for I := 0 to ListBoxMapList.Items.Count - 1 do begin
    ListBoxDisableMoveMap.Items.Add(ListBoxMapList.Items.Strings[I]);
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonDisableMoveMapSaveClick(Sender: TObject);
var
  I: Integer;
begin
  g_DisableMoveMapList.Lock;
  try
    g_DisableMoveMapList.Clear;
    for I := 0 to ListBoxDisableMoveMap.Items.Count - 1 do begin
      g_DisableMoveMapList.Add(ListBoxDisableMoveMap.Items.Strings[I])
    end;
  finally
    g_DisableMoveMapList.UnLock;
  end;
  SaveDisableMoveMap();
  uModValue();
end;

procedure TfrmViewList.ButtonDisableMoveMapDeleteAllClick(Sender: TObject);
begin
  ListBoxDisableMoveMap.Items.Clear;
  ButtonDisableMoveMapDelete.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ListBoxMapListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxMapList.ItemIndex >= 0 then
    ButtonDisableMoveMapAdd.Enabled := True;
end;

procedure TfrmViewList.ListBoxDisableMoveMapClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxDisableMoveMap.ItemIndex >= 0 then
    ButtonDisableMoveMapDelete.Enabled := True;
end;

procedure TfrmViewList.RefGroupItemList;
var
  I, nIndex: Integer;
  ListItem: TListItem;
  GroupItem: pTGroupItem;
begin
  nIndex := ListViewGroupItemList.ItemIndex;
  ListViewGroupItemList.Items.Clear;
  for I := 0 to g_GroupItems.Count - 1 do begin
    GroupItem := g_GroupItems.Items[I];
    ListItem := ListViewGroupItemList.Items.Add;
    ListItem.Caption := IntToStr(I);
    with GroupItem^ do begin
      ListItem.SubItems.AddObject(Format('%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s',
        [FLD_USEITEMS[0], FLD_USEITEMS[1], FLD_USEITEMS[2], FLD_USEITEMS[3], FLD_USEITEMS[4], FLD_USEITEMS[5], FLD_USEITEMS[6],
        FLD_USEITEMS[7], FLD_USEITEMS[8], FLD_USEITEMS[9], FLD_USEITEMS[10], FLD_USEITEMS[11], FLD_USEITEMS[12]]), TObject(GroupItem));
      ListItem.SubItems.Add(FLD_HINTMSG);
    end;
  end;
  if (nIndex >= 0) and (nIndex < ListViewGroupItemList.Items.Count) then
    ListViewGroupItemList.ItemIndex := nIndex;
end;

procedure TfrmViewList.RefMsgFilterList;
begin

end;

procedure TfrmViewList.RefMonDropLimit;
var
  I: Integer;
  MonDrop: pTMonDrop;
begin
  g_MonDropLimitLIst.Lock;
  try
    StringGridMonDropLimit.RowCount := g_MonDropLimitLIst.Count + 1;
    if StringGridMonDropLimit.RowCount > 1 then StringGridMonDropLimit.FixedRows := 1;

    for I := 0 to g_MonDropLimitLIst.Count - 1 do begin
      MonDrop := pTMonDrop(g_MonDropLimitLIst.Objects[I]);
      StringGridMonDropLimit.Cells[0, I + 1] := MonDrop.sItemName;
      StringGridMonDropLimit.Cells[1, I + 1] := IntToStr(MonDrop.nDropCount);
      StringGridMonDropLimit.Cells[2, I + 1] := IntToStr(MonDrop.nCountLimit);
      StringGridMonDropLimit.Cells[3, I + 1] := IntToStr(MonDrop.nNoDropCount);
    end;
  finally
    g_MonDropLimitLIst.UnLock;
  end;
end;

procedure TfrmViewList.ButtonMonDropLimitRefClick(Sender: TObject);
begin
  RefMonDropLimit();
end;

procedure TfrmViewList.StringGridMonDropLimitClick(Sender: TObject);
var
  nItemIndex: Integer;
  MonDrop: pTMonDrop;
begin
  nItemIndex := StringGridMonDropLimit.Row - 1;
  if nItemIndex < 0 then Exit;

  g_MonDropLimitLIst.Lock;
  try
    if nItemIndex >= g_MonDropLimitLIst.Count then Exit;
    MonDrop := pTMonDrop(g_MonDropLimitLIst.Objects[nItemIndex]);
    EditItemName.Text := MonDrop.sItemName;
    EditDropCount.Value := MonDrop.nDropCount;
    EditCountLimit.Value := MonDrop.nCountLimit;
    EditNoDropCount.Value := MonDrop.nNoDropCount;
  finally
    g_MonDropLimitLIst.UnLock;
  end;
end;

procedure TfrmViewList.EditDropCountChange(Sender: TObject);
begin
  if EditDropCount.Text = '' then begin
    EditDropCount.Text := '0';
    Exit;
  end;

end;

procedure TfrmViewList.EditCountLimitChange(Sender: TObject);
begin
  if EditCountLimit.Text = '' then begin
    EditCountLimit.Text := '0';
    Exit;
  end;
end;

procedure TfrmViewList.EditNoDropCountChange(Sender: TObject);
begin
  if EditNoDropCount.Text = '' then begin
    EditNoDropCount.Text := '0';
    Exit;
  end;
end;

procedure TfrmViewList.ButtonMonDropLimitSaveClick(Sender: TObject);
var
  sItemName: string;
  nNoDropCount: Integer;
  nDropCount: Integer;
  nDropLimit: Integer;
  nSelIndex: Integer;
  MonDrop: pTMonDrop;
begin
  sItemName := Trim(EditItemName.Text);
  nDropCount := EditDropCount.Value;
  nDropLimit := EditCountLimit.Value;
  nNoDropCount := EditNoDropCount.Value;

  nSelIndex := StringGridMonDropLimit.Row - 1;
  if nSelIndex < 0 then Exit;
  g_MonDropLimitLIst.Lock;
  try
    if nSelIndex >= g_MonDropLimitLIst.Count then Exit;
    MonDrop := pTMonDrop(g_MonDropLimitLIst.Objects[nSelIndex]);
    MonDrop.sItemName := sItemName;
    MonDrop.nDropCount := nDropCount;
    MonDrop.nNoDropCount := nNoDropCount;
    MonDrop.nCountLimit := nDropLimit;
  finally
    g_MonDropLimitLIst.UnLock;
  end;
  SaveMonDropLimitList();
  RefMonDropLimit();
end;

procedure TfrmViewList.ButtonMonDropLimitAddClick(Sender: TObject);
var
  I: Integer;
  sItemName: string;
  nNoDropCount: Integer;
  nDropCount: Integer;
  nDropLimit: Integer;
  MonDrop: pTMonDrop;
begin
  sItemName := Trim(EditItemName.Text);
  nDropCount := EditDropCount.Value;
  nDropLimit := EditCountLimit.Value;
  nNoDropCount := EditNoDropCount.Value;

  g_MonDropLimitLIst.Lock;
  try
    for I := 0 to g_MonDropLimitLIst.Count - 1 do begin
      MonDrop := pTMonDrop(g_MonDropLimitLIst.Objects[I]);
      if CompareText(MonDrop.sItemName, sItemName) = 0 then begin
        Application.MessageBox('输入的物品名已经在列表中！！！', '提示信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    New(MonDrop);
    MonDrop.sItemName := sItemName;
    MonDrop.nDropCount := nDropCount;
    MonDrop.nNoDropCount := nNoDropCount;
    MonDrop.nCountLimit := nDropLimit;
    g_MonDropLimitLIst.AddObject(sItemName, TObject(MonDrop));
  finally
    g_MonDropLimitLIst.UnLock;
  end;
  SaveMonDropLimitList();
  RefMonDropLimit();
end;


procedure TfrmViewList.ButtonMonDropLimitDelClick(Sender: TObject);
var
  nSelIndex: Integer;
  MonDrop: pTMonDrop;
begin

  nSelIndex := StringGridMonDropLimit.Row - 1;
  if nSelIndex < 0 then Exit;
  g_MonDropLimitLIst.Lock;
  try
    if nSelIndex >= g_MonDropLimitLIst.Count then Exit;
    MonDrop := pTMonDrop(g_MonDropLimitLIst.Objects[nSelIndex]);
    Dispose(MonDrop);
    g_MonDropLimitLIst.Delete(nSelIndex);
  finally
    g_MonDropLimitLIst.UnLock;
  end;
  SaveMonDropLimitList();
  RefMonDropLimit();
end;

procedure TfrmViewList.ListBoxGameLogListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxGameLogList.ItemIndex >= 0 then
    ButtonGameLogDel.Enabled := True;
end;

procedure TfrmViewList.ListBoxitemList2Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxitemList2.ItemIndex >= 0 then
    ButtonGameLogAdd.Enabled := True;
end;

procedure TfrmViewList.ButtonGameLogAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBoxitemList2.ItemIndex >= 0 then begin
    for I := 0 to ListBoxGameLogList.Items.Count - 1 do begin
      if ListBoxGameLogList.Items.Strings[I] = ListBoxitemList2.Items.Strings[ListBoxitemList2.ItemIndex] then begin
        Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    ListBoxGameLogList.Items.Add(ListBoxitemList2.Items.Strings[ListBoxitemList2.ItemIndex]);
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonGameLogDelClick(Sender: TObject);
begin
  if ListBoxGameLogList.ItemIndex >= 0 then begin
    ListBoxGameLogList.Items.Delete(ListBoxGameLogList.ItemIndex);
    ModValue();
  end;
  if ListBoxGameLogList.ItemIndex < 0 then
    ButtonGameLogDel.Enabled := False;
end;

procedure TfrmViewList.ButtonGameLogAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxGameLogList.Items.Clear;
  for I := 0 to ListBoxitemList2.Items.Count - 1 do begin
    ListBoxGameLogList.Items.Add(ListBoxitemList2.Items.Strings[I]);
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonGameLogDelAllClick(Sender: TObject);
begin
  ListBoxGameLogList.Items.Clear;
  ButtonGameLogDel.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ButtonGameLogSaveClick(Sender: TObject);
var
  I: Integer;
begin

  g_GameLogItemNameList.Lock;
  try
    g_GameLogItemNameList.Clear;
    for I := 0 to ListBoxGameLogList.Items.Count - 1 do begin
      g_GameLogItemNameList.Add(ListBoxGameLogList.Items.Strings[I])
    end;
  finally
    g_GameLogItemNameList.UnLock;
  end;
  uModValue();
{$IF SoftVersion <> VERDEMO}
  SaveGameLogItemNameList();
{$IFEND}
  if Application.MessageBox('此设置必须重新加载物品数据库才能生效，是否重新加载？', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    FrmDB.LoadItemsDB();
  end;
end;

procedure TfrmViewList.ButtonDisableTakeOffAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBoxitemList3.ItemIndex >= 0 then begin
    for I := 0 to ListBoxDisableTakeOffList.Items.Count - 1 do begin
      if ListBoxDisableTakeOffList.Items.Strings[I] = ListBoxitemList3.Items.Strings[ListBoxitemList3.ItemIndex] then begin
        Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    ListBoxDisableTakeOffList.Items.AddObject(IntToStr(ListBoxitemList3.ItemIndex) + '  ' + ListBoxitemList3.Items.Strings[ListBoxitemList3.ItemIndex], TObject(ListBoxitemList3.ItemIndex));
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonDisableTakeOffDelClick(Sender: TObject);
begin
  if ListBoxDisableTakeOffList.ItemIndex >= 0 then begin
    ListBoxDisableTakeOffList.Items.Delete(ListBoxDisableTakeOffList.ItemIndex);
    ModValue();
  end;
  if ListBoxDisableTakeOffList.ItemIndex < 0 then
    ButtonDisableTakeOffDel.Enabled := False;
end;

procedure TfrmViewList.ListBoxDisableTakeOffListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxDisableTakeOffList.ItemIndex >= 0 then
    ButtonDisableTakeOffDel.Enabled := True;
end;

procedure TfrmViewList.ListBoxitemList3Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxitemList3.ItemIndex >= 0 then
    ButtonDisableTakeOffAdd.Enabled := True;
end;

procedure TfrmViewList.ButtonDisableTakeOffAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxDisableTakeOffList.Items.Clear;
  for I := 0 to ListBoxitemList3.Items.Count - 1 do begin
    ListBoxDisableTakeOffList.Items.AddObject(IntToStr(I) + '  ' + ListBoxitemList3.Items.Strings[I], TObject(I));
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonDisableTakeOffDelAllClick(Sender: TObject);
begin
  ListBoxDisableTakeOffList.Items.Clear;
  ButtonDisableTakeOffDel.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ButtonDisableTakeOffSaveClick(Sender: TObject);
var
  I: Integer;
  sItemIdx: string;
begin
  g_DisableTakeOffList.Lock;
  try
    g_DisableTakeOffList.Clear;
    for I := 0 to ListBoxDisableTakeOffList.Items.Count - 1 do begin
      g_DisableTakeOffList.AddObject(Trim(GetValidStr3(ListBoxDisableTakeOffList.Items.Strings[I], sItemIdx, [' ', '/', ',', #9])), ListBoxDisableTakeOffList.Items.Objects[I]);
    end;
  finally
    g_DisableTakeOffList.UnLock;
  end;
  SaveDisableTakeOffList();
  uModValue();
end;

procedure TfrmViewList.RefAdminList();
var
  I: Integer;
  AdminInfo: pTAdminInfo;
begin
  ListBoxAdminList.Clear;
  EditAdminName.Text := '';
  EditAdminIPaddr.Text := '';
  EditAdminPremission.Value := 0;
  ButtonAdminListChange.Enabled := False;
  ButtonAdminListDel.Enabled := False;
  UserEngine.m_AdminList.Lock;
  try
    for I := 0 to UserEngine.m_AdminList.Count - 1 do begin
      AdminInfo := pTAdminInfo(UserEngine.m_AdminList.Items[I]);
{$IF VEROWNER = WL}
      ListBoxAdminList.Items.Add(AdminInfo.sChrName + ' - ' + IntToStr(AdminInfo.nLv) + ' - ' + AdminInfo.sIPaddr)
{$ELSE}
      ListBoxAdminList.Items.Add(AdminInfo.sChrName + ' - ' + IntToStr(AdminInfo.nLv))
{$IFEND}
    end;
  finally
    UserEngine.m_AdminList.UnLock;
  end;
end;

procedure TfrmViewList.RefNoClearMonList;
var
  MonInfo: pTMonInfo;
  I: Integer;
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    for I := 0 to UserEngine.MonsterList.Count - 1 do begin
      MonInfo := UserEngine.MonsterList.Items[I];
      ListBoxMonList.Items.AddObject(MonInfo.sName, TObject(MonInfo));
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;

  g_NoClearMonList.Lock;
  try
    for I := 0 to g_NoClearMonList.Count - 1 do begin
      ListBoxNoClearMonList.Items.Add(g_NoClearMonList.Strings[I]);
    end;
  finally
    g_NoClearMonList.UnLock;
  end;
end;

procedure TfrmViewList.ButtonNoClearMonAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBoxMonList.ItemIndex >= 0 then begin
    for I := 0 to ListBoxNoClearMonList.Items.Count - 1 do begin
      if ListBoxNoClearMonList.Items.Strings[I] = ListBoxMonList.Items.Strings[ListBoxMonList.ItemIndex] then begin
        Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    ListBoxNoClearMonList.Items.Add(ListBoxMonList.Items.Strings[ListBoxMonList.ItemIndex]);
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonNoClearMonDelClick(Sender: TObject);
begin
  if ListBoxNoClearMonList.ItemIndex >= 0 then begin
    ListBoxNoClearMonList.Items.Delete(ListBoxNoClearMonList.ItemIndex);
    ModValue();
  end;
  if ListBoxNoClearMonList.ItemIndex < 0 then
    ButtonNoClearMonDel.Enabled := False;
end;

procedure TfrmViewList.ButtonNoClearMonAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxNoClearMonList.Items.Clear;
  for I := 0 to ListBoxMonList.Items.Count - 1 do begin
    ListBoxNoClearMonList.Items.Add(ListBoxMonList.Items.Strings[I]);
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonNoClearMonDelAllClick(Sender: TObject);
begin
  ListBoxNoClearMonList.Items.Clear;
  ButtonNoClearMonDel.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ButtonNoClearMonSaveClick(Sender: TObject);
var
  I: Integer;
begin
  g_NoClearMonList.Lock;
  try
    g_NoClearMonList.Clear;
    for I := 0 to ListBoxNoClearMonList.Items.Count - 1 do begin
      g_NoClearMonList.Add(ListBoxNoClearMonList.Items.Strings[I]);
    end;
  finally
    g_NoClearMonList.UnLock;
  end;
  SaveNoClearMonList();
  uModValue();
end;

procedure TfrmViewList.ListBoxNoClearMonListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxNoClearMonList.ItemIndex >= 0 then
    ButtonNoClearMonDel.Enabled := True;
end;

procedure TfrmViewList.ListBoxMonListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxMonList.ItemIndex >= 0 then
    ButtonNoClearMonAdd.Enabled := True;
end;

procedure TfrmViewList.ButtonAdminLitsSaveClick(Sender: TObject);
begin
  SaveAdminList();
  ButtonAdminLitsSave.Enabled := False;
end;

procedure TfrmViewList.ListBoxAdminListClick(Sender: TObject);
var
  nIndex: Integer;
  AdminInfo: pTAdminInfo;
begin
  nIndex := ListBoxAdminList.ItemIndex;
  UserEngine.m_AdminList.Lock;
  try
    if (nIndex < 0) and (nIndex >= UserEngine.m_AdminList.Count) then Exit;
    ButtonAdminListChange.Enabled := True;
    ButtonAdminListDel.Enabled := True;
    AdminInfo := UserEngine.m_AdminList.Items[nIndex];
    EditAdminName.Text := AdminInfo.sChrName;
    EditAdminIPaddr.Text := AdminInfo.sIPaddr;
    EditAdminPremission.Value := AdminInfo.nLv;
  finally
    UserEngine.m_AdminList.UnLock;
  end;
end;

procedure TfrmViewList.ButtonAdminListAddClick(Sender: TObject);
var
  I: Integer;
  sAdminName: string;
  sAdminIPaddr: string;
  nAdminPerMission: Integer;
  AdminInfo: pTAdminInfo;
begin
  sAdminName := Trim(EditAdminName.Text);
  sAdminIPaddr := Trim(EditAdminIPaddr.Text);
  nAdminPerMission := EditAdminPremission.Value;
  if (nAdminPerMission < 1) or (sAdminName = '') or not (nAdminPerMission in [0..10]) then begin
    Application.MessageBox('输入不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    EditAdminName.SetFocus;
    Exit;
  end;
{$IF VEROWNER = WL}
  if (sAdminIPaddr = '') then begin
    Application.MessageBox('登录IP输入不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    EditAdminIPaddr.SetFocus;
    Exit;
  end;
{$IFEND}

  UserEngine.m_AdminList.Lock;
  try
    for I := 0 to UserEngine.m_AdminList.Count - 1 do begin
      if CompareText(pTAdminInfo(UserEngine.m_AdminList.Items[I]).sChrName, sAdminName) = 0 then begin
        Application.MessageBox('输入的角色名已经在GM列表中！！！', '提示信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    New(AdminInfo);
    AdminInfo.nLv := nAdminPerMission;
    AdminInfo.sChrName := sAdminName;
    AdminInfo.sIPaddr := sAdminIPaddr;
    UserEngine.m_AdminList.Add(AdminInfo);
  finally
    UserEngine.m_AdminList.UnLock;
  end;
  RefAdminList();
  ButtonAdminLitsSave.Enabled := True;
end;

procedure TfrmViewList.ButtonAdminListChangeClick(Sender: TObject);
var
  nIndex: Integer;
  sAdminName: string;
  sAdminIPaddr: string;
  nAdminPerMission: Integer;
  AdminInfo: pTAdminInfo;
begin
  nIndex := ListBoxAdminList.ItemIndex;
  if nIndex < 0 then Exit;

  sAdminName := Trim(EditAdminName.Text);
  sAdminIPaddr := Trim(EditAdminIPaddr.Text);
  nAdminPerMission := EditAdminPremission.Value;
  if (nAdminPerMission < 1) or (sAdminName = '') or not (nAdminPerMission in [0..10]) then begin
    Application.MessageBox('输入不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    EditAdminName.SetFocus;
    Exit;
  end;
{$IF VEROWNER = WL}
  if (sAdminIPaddr = '') then begin
    Application.MessageBox('登录IP输入不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    EditAdminIPaddr.SetFocus;
    Exit;
  end;
{$IFEND}
  UserEngine.m_AdminList.Lock;
  try
    if (nIndex < 0) and (nIndex >= UserEngine.m_AdminList.Count) then Exit;
    AdminInfo := UserEngine.m_AdminList.Items[nIndex];
    AdminInfo.sChrName := sAdminName;
    AdminInfo.nLv := nAdminPerMission;
    AdminInfo.sIPaddr := sAdminIPaddr;
  finally
    UserEngine.m_AdminList.UnLock;
  end;
  RefAdminList();
  ButtonAdminLitsSave.Enabled := True;
end;


procedure TfrmViewList.ButtonAdminListDelClick(Sender: TObject);
var
  nIndex: Integer;
begin
  nIndex := ListBoxAdminList.ItemIndex;
  if nIndex < 0 then Exit;
  UserEngine.m_AdminList.Lock;
  try
    if (nIndex < 0) and (nIndex >= UserEngine.m_AdminList.Count) then Exit;
    Dispose(pTAdminInfo(UserEngine.m_AdminList.Items[nIndex]));
    UserEngine.m_AdminList.Delete(nIndex);
  finally
    UserEngine.m_AdminList.UnLock;
  end;
  RefAdminList();
  ButtonAdminLitsSave.Enabled := True;
end;


procedure TfrmViewList.RefItemBindAccount;
var
  I: Integer;
  ItemBind: pTItemBind;
begin
  GridItemBindAccount.RowCount := 2;
  GridItemBindAccount.Cells[0, 1] := '';
  GridItemBindAccount.Cells[1, 1] := '';
  GridItemBindAccount.Cells[2, 1] := '';
  GridItemBindAccount.Cells[3, 1] := '';
  ButtonItemBindAcountMod.Enabled := False;
  ButtonItemBindAcountDel.Enabled := False;

  g_ItemBindAccount.Lock;
  try
    GridItemBindAccount.RowCount := g_ItemBindAccount.Count + 1;
    for I := 0 to g_ItemBindAccount.Count - 1 do begin
      ItemBind := g_ItemBindAccount.Items[I];
      if ItemBind <> nil then begin
        GridItemBindAccount.Cells[0, I + 1] := UserEngine.GetStdItemName(ItemBind.nItemIdx);
        GridItemBindAccount.Cells[1, I + 1] := IntToStr(ItemBind.nItemIdx);
        GridItemBindAccount.Cells[2, I + 1] := IntToStr(ItemBind.nMakeIdex);
        GridItemBindAccount.Cells[3, I + 1] := ItemBind.sBindName;
      end;
    end;
  finally
    g_ItemBindAccount.UnLock;
  end;
end;

procedure TfrmViewList.GridItemBindAccountClick(Sender: TObject);
var
  nIndex: Integer;
  ItemBind: pTItemBind;
begin

  nIndex := GridItemBindAccount.Row - 1;
  if nIndex < 0 then Exit;

  g_ItemBindAccount.Lock;
  try
    if nIndex < g_ItemBindAccount.Count then begin
      ItemBind := pTItemBind(g_ItemBindAccount.Items[nIndex]);
      EditItemBindAccountItemName.Text := UserEngine.GetStdItemName(ItemBind.nItemIdx);
      EditItemBindAccountItemIdx.Value := ItemBind.nItemIdx;
      EditItemBindAccountItemMakeIdx.Value := ItemBind.nMakeIdex;
      EditItemBindAccountName.Text := ItemBind.sBindName;
    end;
  finally
    g_ItemBindAccount.UnLock;
  end;
  ButtonItemBindAcountDel.Enabled := True;
end;

procedure TfrmViewList.EditItemBindAccountItemIdxChange(Sender: TObject);
begin
  if EditItemBindAccountItemIdx.Text = '' then begin
    EditItemBindAccountItemIdx.Text := '0';
    Exit;
  end;
  EditItemBindAccountItemName.Text := UserEngine.GetStdItemName(EditItemBindAccountItemIdx.Value);
  ButtonItemBindAcountMod.Enabled := True;
end;

procedure TfrmViewList.EditItemBindAccountItemMakeIdxChange(
  Sender: TObject);
begin
  if EditItemBindAccountItemIdx.Text = '' then begin
    EditItemBindAccountItemIdx.Text := '0';
    Exit;
  end;
  ButtonItemBindAcountMod.Enabled := True;
end;


procedure TfrmViewList.EditItemBindAccountNameChange(Sender: TObject);
begin
  ButtonItemBindAcountMod.Enabled := True;
end;

procedure TfrmViewList.ButtonItemBindAcountModClick(Sender: TObject);
var
  nSelIndex: Integer;
  nMakeIdex: Integer;
  nItemIdx: Integer;
  sBindName: string;
  ItemBind: pTItemBind;
begin
  nItemIdx := EditItemBindAccountItemIdx.Value;
  nMakeIdex := EditItemBindAccountItemMakeIdx.Value;
  sBindName := Trim(EditItemBindAccountName.Text);
  nSelIndex := GridItemBindAccount.Row - 1;
  if nSelIndex < 0 then Exit;
  g_ItemBindAccount.Lock;
  try
    if nSelIndex < g_ItemBindAccount.Count then begin
      ItemBind := g_ItemBindAccount.Items[nSelIndex];
      ItemBind.nItemIdx := nItemIdx;
      ItemBind.nMakeIdex := nMakeIdex;
      ItemBind.sBindName := sBindName;
    end;
  finally
    g_ItemBindAccount.UnLock;
  end;
  SaveItemBindAccount();
  RefItemBindAccount();

end;


procedure TfrmViewList.ButtonItemBindAcountRefClick(Sender: TObject);
begin
  RefItemBindAccount();
end;


procedure TfrmViewList.ButtonItemBindAcountAddClick(Sender: TObject);
var
  I: Integer;
  nMakeIdex: Integer;
  nItemIdx: Integer;
  sBindName: string;
  ItemBind: pTItemBind;
  boFind: Boolean;
begin
  nItemIdx := EditItemBindAccountItemIdx.Value;
  nMakeIdex := EditItemBindAccountItemMakeIdx.Value;
  sBindName := Trim(EditItemBindAccountName.Text);

  if (nItemIdx <= 0) or (nMakeIdex < 0) or (sBindName = '') then begin
    Application.MessageBox('输入的信息不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    Exit;
  end;
  boFind := False;
  g_ItemBindAccount.Lock;
  try
    for I := 0 to g_ItemBindAccount.Count - 1 do begin
      ItemBind := g_ItemBindAccount.Items[I];
      if (ItemBind.nItemIdx = nItemIdx) and (ItemBind.nMakeIdex = nMakeIdex) then begin
        Application.MessageBox('此物品已经绑定到其他的帐号了！！！', '提示信息', MB_OK + MB_ICONERROR);
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
  SaveItemBindAccount();
  RefItemBindAccount();
end;


procedure TfrmViewList.ButtonItemBindAcountDelClick(Sender: TObject);
var
  ItemBind: pTItemBind;
  nSelIndex: Integer;
begin

  nSelIndex := GridItemBindAccount.Row - 1;
  if nSelIndex < 0 then Exit;
  g_ItemBindAccount.Lock;
  try
    if nSelIndex < g_ItemBindAccount.Count then begin
      ItemBind := g_ItemBindAccount.Items[nSelIndex];
      Dispose(ItemBind);
      g_ItemBindAccount.Delete(nSelIndex);
    end;
  finally
    g_ItemBindAccount.UnLock;
  end;
  SaveItemBindAccount();
  RefItemBindAccount();
end;

procedure TfrmViewList.RefItemBindCharName;
var
  I: Integer;
  ItemBind: pTItemBind;
begin
  GridItemBindCharName.RowCount := 2;
  GridItemBindCharName.Cells[0, 1] := '';
  GridItemBindCharName.Cells[1, 1] := '';
  GridItemBindCharName.Cells[2, 1] := '';
  GridItemBindCharName.Cells[3, 1] := '';
  ButtonItemBindCharNameMod.Enabled := False;
  ButtonItemBindCharNameDel.Enabled := False;
  g_ItemBindCharName.Lock;
  try
    GridItemBindCharName.RowCount := g_ItemBindCharName.Count + 1;
    for I := 0 to g_ItemBindCharName.Count - 1 do begin
      ItemBind := g_ItemBindCharName.Items[I];
      if ItemBind <> nil then begin
        GridItemBindCharName.Cells[0, I + 1] := UserEngine.GetStdItemName(ItemBind.nItemIdx);
        GridItemBindCharName.Cells[1, I + 1] := IntToStr(ItemBind.nItemIdx);
        GridItemBindCharName.Cells[2, I + 1] := IntToStr(ItemBind.nMakeIdex);
        GridItemBindCharName.Cells[3, I + 1] := ItemBind.sBindName;
      end;
    end;
  finally
    g_ItemBindCharName.UnLock;
  end;
end;

procedure TfrmViewList.GridItemBindCharNameClick(Sender: TObject);
var
  nIndex: Integer;
  ItemBind: pTItemBind;
begin

  nIndex := GridItemBindCharName.Row - 1;
  if nIndex < 0 then Exit;

  g_ItemBindCharName.Lock;
  try
    if nIndex >= g_ItemBindCharName.Count then Exit;
    ItemBind := pTItemBind(g_ItemBindCharName.Items[nIndex]);
    EditItemBindCharNameItemName.Text := UserEngine.GetStdItemName(ItemBind.nItemIdx);
    EditItemBindCharNameItemIdx.Value := ItemBind.nItemIdx;
    EditItemBindCharNameItemMakeIdx.Value := ItemBind.nMakeIdex;
    EditItemBindCharNameName.Text := ItemBind.sBindName;
  finally
    g_ItemBindCharName.UnLock;
  end;
  ButtonItemBindCharNameDel.Enabled := True;
end;

procedure TfrmViewList.EditItemBindCharNameItemIdxChange(Sender: TObject);
begin
  if EditItemBindCharNameItemIdx.Text = '' then begin
    EditItemBindCharNameItemIdx.Text := '0';
    Exit;
  end;
  EditItemBindCharNameItemName.Text := UserEngine.GetStdItemName(EditItemBindCharNameItemIdx.Value);
  ButtonItemBindCharNameMod.Enabled := True;
end;

procedure TfrmViewList.EditItemBindCharNameItemMakeIdxChange(
  Sender: TObject);
begin
  if EditItemBindCharNameItemMakeIdx.Text = '' then begin
    EditItemBindCharNameItemMakeIdx.Text := '0';
    Exit;
  end;
  ButtonItemBindCharNameMod.Enabled := True;
end;

procedure TfrmViewList.EditItemBindCharNameNameChange(Sender: TObject);
begin
  ButtonItemBindCharNameMod.Enabled := True;
end;

procedure TfrmViewList.ButtonItemBindCharNameAddClick(Sender: TObject);
var
  I: Integer;
  nMakeIdex: Integer;
  nItemIdx: Integer;
  sBindName: string;
  ItemBind: pTItemBind;
begin
  nItemIdx := EditItemBindCharNameItemIdx.Value;
  nMakeIdex := EditItemBindCharNameItemMakeIdx.Value;
  sBindName := Trim(EditItemBindCharNameName.Text);

  if (nItemIdx <= 0) or (nMakeIdex < 0) or (sBindName = '') then begin
    Application.MessageBox('输入的信息不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    Exit;
  end;

  g_ItemBindCharName.Lock;
  try
    for I := 0 to g_ItemBindCharName.Count - 1 do begin
      ItemBind := g_ItemBindCharName.Items[I];
      if (ItemBind.nItemIdx = nItemIdx) and (ItemBind.nMakeIdex = nMakeIdex) then begin
        Application.MessageBox('此物品已经绑定到其他的角色上了！！！', '提示信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    New(ItemBind);
    ItemBind.nItemIdx := nItemIdx;
    ItemBind.nMakeIdex := nMakeIdex;
    ItemBind.sBindName := sBindName;
    g_ItemBindCharName.Insert(0, ItemBind);
  finally
    g_ItemBindCharName.UnLock;
  end;
  SaveItemBindCharName();
  RefItemBindCharName();
end;

procedure TfrmViewList.ButtonItemBindCharNameModClick(Sender: TObject);
var
  nSelIndex: Integer;
  nMakeIdex: Integer;
  nItemIdx: Integer;
  sBindName: string;
  ItemBind: pTItemBind;
begin

  nItemIdx := EditItemBindCharNameItemIdx.Value;
  nMakeIdex := EditItemBindCharNameItemMakeIdx.Value;
  sBindName := Trim(EditItemBindCharNameName.Text);
  nSelIndex := GridItemBindCharName.Row - 1;
  if nSelIndex < 0 then Exit;

  g_ItemBindCharName.Lock;
  try
    if nSelIndex >= g_ItemBindCharName.Count then Exit;
    ItemBind := g_ItemBindCharName.Items[nSelIndex];
    ItemBind.nItemIdx := nItemIdx;
    ItemBind.nMakeIdex := nMakeIdex;
    ItemBind.sBindName := sBindName;
  finally
    g_ItemBindCharName.UnLock;
  end;

  SaveItemBindCharName();
  RefItemBindCharName();

end;

procedure TfrmViewList.ButtonItemBindCharNameDelClick(Sender: TObject);
var
  ItemBind: pTItemBind;
  nSelIndex: Integer;
begin

  nSelIndex := GridItemBindCharName.Row - 1;
  if nSelIndex < 0 then Exit;
  g_ItemBindCharName.Lock;
  try
    if nSelIndex >= g_ItemBindCharName.Count then Exit;
    ItemBind := g_ItemBindCharName.Items[nSelIndex];
    Dispose(ItemBind);
    g_ItemBindCharName.Delete(nSelIndex);
  finally
    g_ItemBindCharName.UnLock;
  end;
  SaveItemBindCharName();
  RefItemBindCharName();
end;

procedure TfrmViewList.ButtonItemBindCharNameRefClick(Sender: TObject);
begin
  RefItemBindCharName();
end;


procedure TfrmViewList.RefItemBindIPaddr;
var
  I: Integer;
  ItemBind: pTItemBind;
begin
  GridItemBindIPaddr.RowCount := 2;
  GridItemBindIPaddr.Cells[0, 1] := '';
  GridItemBindIPaddr.Cells[1, 1] := '';
  GridItemBindIPaddr.Cells[2, 1] := '';
  GridItemBindIPaddr.Cells[3, 1] := '';
  ButtonItemBindIPaddrMod.Enabled := False;
  ButtonItemBindIPaddrDel.Enabled := False;
  g_ItemBindIPaddr.Lock;
  try
    GridItemBindIPaddr.RowCount := g_ItemBindIPaddr.Count + 1;
    for I := 0 to g_ItemBindIPaddr.Count - 1 do begin
      ItemBind := g_ItemBindIPaddr.Items[I];
      if ItemBind <> nil then begin
        GridItemBindIPaddr.Cells[0, I + 1] := UserEngine.GetStdItemName(ItemBind.nItemIdx);
        GridItemBindIPaddr.Cells[1, I + 1] := IntToStr(ItemBind.nItemIdx);
        GridItemBindIPaddr.Cells[2, I + 1] := IntToStr(ItemBind.nMakeIdex);
        GridItemBindIPaddr.Cells[3, I + 1] := ItemBind.sBindName;
      end;
    end;
  finally
    g_ItemBindIPaddr.UnLock;
  end;
end;

procedure TfrmViewList.GridItemBindIPaddrClick(Sender: TObject);
var
  nIndex: Integer;
  ItemBind: pTItemBind;
begin

  nIndex := GridItemBindIPaddr.Row - 1;
  if nIndex < 0 then Exit;

  g_ItemBindIPaddr.Lock;
  try
    if nIndex >= g_ItemBindIPaddr.Count then Exit;
    ItemBind := pTItemBind(g_ItemBindIPaddr.Items[nIndex]);
    EditItemBindIPaddrItemName.Text := UserEngine.GetStdItemName(ItemBind.nItemIdx);
    EditItemBindIPaddrItemIdx.Value := ItemBind.nItemIdx;
    EditItemBindIPaddrItemMakeIdx.Value := ItemBind.nMakeIdex;
    EditItemBindIPaddrName.Text := ItemBind.sBindName;
  finally
    g_ItemBindIPaddr.UnLock;
  end;
  ButtonItemBindIPaddrDel.Enabled := True;
end;

procedure TfrmViewList.EditItemBindIPaddrItemIdxChange(Sender: TObject);
begin
  if EditItemBindIPaddrItemIdx.Text = '' then begin
    EditItemBindIPaddrItemIdx.Text := '0';
    Exit;
  end;
  EditItemBindIPaddrItemName.Text := UserEngine.GetStdItemName(EditItemBindIPaddrItemIdx.Value);
  ButtonItemBindIPaddrMod.Enabled := True;
end;

procedure TfrmViewList.EditItemBindIPaddrItemMakeIdxChange(
  Sender: TObject);
begin
  if EditItemBindIPaddrItemMakeIdx.Text = '' then begin
    EditItemBindIPaddrItemMakeIdx.Text := '0';
    Exit;
  end;
  ButtonItemBindIPaddrMod.Enabled := True;
end;

procedure TfrmViewList.EditItemBindIPaddrNameChange(Sender: TObject);
begin
  ButtonItemBindIPaddrMod.Enabled := True;
end;

procedure TfrmViewList.ButtonItemBindIPaddrAddClick(Sender: TObject);
var
  I: Integer;
  nMakeIdex: Integer;
  nItemIdx: Integer;
  sBindName: string;
  ItemBind: pTItemBind;
begin
  nItemIdx := EditItemBindIPaddrItemIdx.Value;
  nMakeIdex := EditItemBindIPaddrItemMakeIdx.Value;
  sBindName := Trim(EditItemBindIPaddrName.Text);

  if not IsIPaddr(sBindName) then begin
    Application.MessageBox('IP地址格式输入不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    EditItemBindIPaddrName.SetFocus;
    Exit;
  end;


  if (nItemIdx <= 0) or (nMakeIdex < 0) then begin
    Application.MessageBox('输入的信息不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    Exit;
  end;

  g_ItemBindIPaddr.Lock;
  try
    for I := 0 to g_ItemBindIPaddr.Count - 1 do begin
      ItemBind := g_ItemBindIPaddr.Items[I];
      if (ItemBind.nItemIdx = nItemIdx) and (ItemBind.nMakeIdex = nMakeIdex) then begin
        Application.MessageBox('此物品已经绑定到其他的IP地址上了！！！', '提示信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    New(ItemBind);
    ItemBind.nItemIdx := nItemIdx;
    ItemBind.nMakeIdex := nMakeIdex;
    ItemBind.sBindName := sBindName;
    g_ItemBindIPaddr.Insert(0, ItemBind);
  finally
    g_ItemBindIPaddr.UnLock;
  end;
  SaveItemBindIPaddr();
  RefItemBindIPaddr();
end;

procedure TfrmViewList.ButtonItemBindIPaddrModClick(Sender: TObject);
var
  nSelIndex: Integer;
  nMakeIdex: Integer;
  nItemIdx: Integer;
  sBindName: string;
  ItemBind: pTItemBind;
begin

  nItemIdx := EditItemBindIPaddrItemIdx.Value;
  nMakeIdex := EditItemBindIPaddrItemMakeIdx.Value;
  sBindName := Trim(EditItemBindIPaddrName.Text);
  if not IsIPaddr(sBindName) then begin
    Application.MessageBox('IP地址格式输入不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    EditItemBindIPaddrName.SetFocus;
    Exit;
  end;
  nSelIndex := GridItemBindIPaddr.Row - 1;
  if nSelIndex < 0 then Exit;

  g_ItemBindIPaddr.Lock;
  try
    if nSelIndex >= g_ItemBindIPaddr.Count then Exit;
    ItemBind := g_ItemBindIPaddr.Items[nSelIndex];
    ItemBind.nItemIdx := nItemIdx;
    ItemBind.nMakeIdex := nMakeIdex;
    ItemBind.sBindName := sBindName;
  finally
    g_ItemBindIPaddr.UnLock;
  end;
  SaveItemBindIPaddr();
  RefItemBindIPaddr();
end;

procedure TfrmViewList.ButtonItemBindIPaddrDelClick(Sender: TObject);
var
  ItemBind: pTItemBind;
  nSelIndex: Integer;
begin

  nSelIndex := GridItemBindIPaddr.Row - 1;
  if nSelIndex < 0 then Exit;
  g_ItemBindIPaddr.Lock;
  try
    if nSelIndex >= g_ItemBindIPaddr.Count then Exit;
    ItemBind := g_ItemBindIPaddr.Items[nSelIndex];
    Dispose(ItemBind);
    g_ItemBindIPaddr.Delete(nSelIndex);
  finally
    g_ItemBindIPaddr.UnLock;
  end;
  SaveItemBindIPaddr();
  RefItemBindIPaddr();
end;

procedure TfrmViewList.ButtonItemBindIPaddrRefClick(Sender: TObject);
begin
  RefItemBindIPaddr();
end;

procedure TfrmViewList.RefItemCustomNameList;
var
  I: Integer;
  ItemName: pTItemName;
begin
  //  GridItemNameList.RowCount:=2;
  GridItemNameList.Cells[0, 1] := '';
  GridItemNameList.Cells[1, 1] := '';
  GridItemNameList.Cells[2, 1] := '';

  ButtonItemNameMod.Enabled := False;
  ButtonItemNameDel.Enabled := False;
  ItemUnit.m_ItemNameList.Lock;
  try
    GridItemNameList.RowCount := ItemUnit.m_ItemNameList.Count + 1;
    for I := 0 to ItemUnit.m_ItemNameList.Count - 1 do begin
      ItemName := ItemUnit.m_ItemNameList.Items[I];
      if ItemName <> nil then begin
        GridItemNameList.Cells[0, I + 1] := UserEngine.GetStdItemName(ItemName.nItemIndex);
        GridItemNameList.Cells[1, I + 1] := IntToStr(ItemName.nMakeIndex);
        GridItemNameList.Cells[2, I + 1] := ItemName.sItemName;
      end;
    end;
  finally
    ItemUnit.m_ItemNameList.UnLock;
  end;
end;

procedure TfrmViewList.GridItemNameListClick(Sender: TObject);
var
  nIndex: Integer;
  ItemName: pTItemName;
begin

  nIndex := GridItemNameList.Row - 1;
  if nIndex < 0 then Exit;

  ItemUnit.m_ItemNameList.Lock;
  try
    if nIndex >= ItemUnit.m_ItemNameList.Count then Exit;
    ItemName := pTItemName(ItemUnit.m_ItemNameList.Items[nIndex]);
    EditItemNameOldName.Text := UserEngine.GetStdItemName(ItemName.nItemIndex);
    EditItemNameIdx.Value := ItemName.nItemIndex;
    EditItemNameMakeIndex.Value := ItemName.nMakeIndex;
    EditItemNameNewName.Text := ItemName.sItemName;
  finally
    ItemUnit.m_ItemNameList.UnLock;
  end;
  ButtonItemNameDel.Enabled := True;
end;

procedure TfrmViewList.EditItemNameIdxChange(Sender: TObject);
begin
  EditItemNameOldName.Text := UserEngine.GetStdItemName(EditItemNameIdx.Value);
  ButtonItemNameMod.Enabled := True;
end;

procedure TfrmViewList.EditItemNameMakeIndexChange(Sender: TObject);
begin
  ButtonItemNameMod.Enabled := True;
end;

procedure TfrmViewList.EditItemNameNewNameChange(Sender: TObject);
begin
  ButtonItemNameMod.Enabled := True;
end;

procedure TfrmViewList.ButtonItemNameAddClick(Sender: TObject);
var
  I: Integer;
  nMakeIdex: Integer;
  nItemIdx: Integer;
  sNewName: string;
  ItemName: pTItemName;
begin
  nItemIdx := EditItemNameIdx.Value;
  nMakeIdex := EditItemNameMakeIndex.Value;
  sNewName := Trim(EditItemNameNewName.Text);

  if (nItemIdx <= 0) or (nMakeIdex < 0) or (sNewName = '') then begin
    Application.MessageBox('输入的信息不正确！！！', '提示信息', MB_OK + MB_ICONERROR);
    Exit;
  end;

  ItemUnit.m_ItemNameList.Lock;
  try
    for I := 0 to ItemUnit.m_ItemNameList.Count - 1 do begin
      ItemName := ItemUnit.m_ItemNameList.Items[I];
      if (ItemName.nItemIndex = nItemIdx) and (ItemName.nMakeIndex = nMakeIdex) then begin
        Application.MessageBox('此物品已经自定义过名称了！！！', '提示信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    New(ItemName);
    ItemName.nItemIndex := nItemIdx;
    ItemName.nMakeIndex := nMakeIdex;
    ItemName.sItemName := sNewName;
    ItemUnit.m_ItemNameList.Insert(0, ItemName);
  finally
    ItemUnit.m_ItemNameList.UnLock;
  end;
  ItemUnit.SaveCustomItemName();
  RefItemCustomNameList();
end;

procedure TfrmViewList.ButtonItemNameModClick(Sender: TObject);
var
  nSelIndex: Integer;
  nMakeIdex: Integer;
  nItemIdx: Integer;
  sNewName: string;
  ItemName: pTItemName;
begin
  nItemIdx := EditItemNameIdx.Value;
  nMakeIdex := EditItemNameMakeIndex.Value;
  sNewName := Trim(EditItemNameNewName.Text);
  nSelIndex := GridItemNameList.Row - 1;
  if nSelIndex < 0 then Exit;
  ItemUnit.m_ItemNameList.Lock;
  try
    if nSelIndex >= ItemUnit.m_ItemNameList.Count then Exit;
    ItemName := ItemUnit.m_ItemNameList.Items[nSelIndex];
    ItemName.nItemIndex := nItemIdx;
    ItemName.nMakeIndex := nMakeIdex;
    ItemName.sItemName := sNewName;
  finally
    ItemUnit.m_ItemNameList.UnLock;
  end;
  ItemUnit.SaveCustomItemName();
  RefItemCustomNameList();
end;

procedure TfrmViewList.ButtonItemNameDelClick(Sender: TObject);
var
  ItemName: pTItemName;
  nSelIndex: Integer;
begin

  nSelIndex := GridItemNameList.Row - 1;
  if nSelIndex < 0 then Exit;
  ItemUnit.m_ItemNameList.Lock;
  try
    if nSelIndex >= ItemUnit.m_ItemNameList.Count then Exit;
    ItemName := ItemUnit.m_ItemNameList.Items[nSelIndex];
    Dispose(ItemName);
    ItemUnit.m_ItemNameList.Delete(nSelIndex);
  finally
    ItemUnit.m_ItemNameList.UnLock;
  end;
  ItemUnit.SaveCustomItemName();
  RefItemCustomNameList();
end;


procedure TfrmViewList.ButtonItemNameRefClick(Sender: TObject);
begin
  RefItemCustomNameList();
end;

procedure TfrmViewList.ListBoxitemList4Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxitemList4.ItemIndex >= 0 then
    ButtonSellOffAdd.Enabled := True;
end;

procedure TfrmViewList.ButtonSellOffDelClick(Sender: TObject);
begin
  if ListBoxSellOffList.ItemIndex >= 0 then begin
    ListBoxSellOffList.Items.Delete(ListBoxSellOffList.ItemIndex);
    ModValue();
  end;
  if ListBoxSellOffList.ItemIndex < 0 then
    ButtonSellOffDel.Enabled := False;
end;

procedure TfrmViewList.ListBoxSellOffListClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxSellOffList.ItemIndex >= 0 then
    ButtonSellOffDel.Enabled := True;
end;

procedure TfrmViewList.ButtonSellOffAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxSellOffList.Items.Clear;
  for I := 0 to ListBoxitemList4.Items.Count - 1 do begin
    ListBoxSellOffList.Items.Add(ListBoxitemList4.Items.Strings[I]);
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonSellOffDelAllClick(Sender: TObject);
begin
  ListBoxSellOffList.Items.Clear;
  ButtonSellOffDelAll.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ButtonSellOffSaveClick(Sender: TObject);
var
  I: Integer;
  sItemIdx: string;
begin
  g_AllowSellOffItemList.Lock;
  try
    g_AllowSellOffItemList.Clear;
    for I := 0 to ListBoxSellOffList.Items.Count - 1 do begin
      g_AllowSellOffItemList.Add(Trim(ListBoxSellOffList.Items.Strings[I]));
    end;
  finally
    g_AllowSellOffItemList.UnLock;
  end;
  SaveAllowSellOffItemList();
  uModValue();
end;

procedure TfrmViewList.ButtonSellOffAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBoxitemList4.ItemIndex >= 0 then begin
    for I := 0 to ListBoxSellOffList.Items.Count - 1 do begin
      if ListBoxSellOffList.Items.Strings[I] = ListBoxitemList4.Items.Strings[ListBoxitemList4.ItemIndex] then begin
        Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    ListBoxSellOffList.Items.Add(ListBoxitemList4.Items.Strings[ListBoxitemList4.ItemIndex]);
    ModValue();
  end;
end;

procedure TfrmViewList.ListBoxAllowPickUpItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxAllowPickUpItem.ItemIndex >= 0 then
    ButtonPickItemDel.Enabled := True;
end;

procedure TfrmViewList.ListBoxitemList5Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxitemList5.ItemIndex >= 0 then
    ButtonPickItemAdd.Enabled := True;
end;

procedure TfrmViewList.ButtonPickItemAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxAllowPickUpItem.Items.Clear;
  for I := 0 to ListBoxitemList5.Items.Count - 1 do begin
    ListBoxAllowPickUpItem.Items.Add(ListBoxitemList5.Items.Strings[I]);
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonPickItemDelAllClick(Sender: TObject);
begin
  ListBoxAllowPickUpItem.Items.Clear;
  ButtonPickItemDelAll.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ButtonPickItemSaveClick(Sender: TObject);
var
  I: Integer;
  sItemIdx: string;
  sFileName: string;
begin
  sFileName := g_Config.sEnvirDir + 'AllowPickUpItemList.txt';
  g_AllowPickUpItemList.Lock;
  try
    g_AllowPickUpItemList.Clear;
    g_AllowPickUpItemList.AddStrings(ListBoxAllowPickUpItem.Items);
    //g_AllowPickUpItemList.Add(';允许分身捡取物品列表');
    {for I := 0 to ListBoxAllowPickUpItem.Items.Count - 1 do begin
      g_AllowPickUpItemList.Add(Trim(ListBoxAllowPickUpItem.Items.Strings[I]));
    end;}
  finally
    g_AllowPickUpItemList.UnLock;
  end;
  try
    g_AllowPickUpItemList.SaveToFile(sFileName);
  except
  end;
  uModValue();
end;

procedure TfrmViewList.ButtonPickItemAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBoxitemList5.ItemIndex >= 0 then begin
    for I := 0 to ListBoxAllowPickUpItem.Items.Count - 1 do begin
      if ListBoxAllowPickUpItem.Items.Strings[I] = ListBoxitemList5.Items.Strings[ListBoxitemList5.ItemIndex] then begin
        Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    ListBoxAllowPickUpItem.Items.Add(ListBoxitemList5.Items.Strings[ListBoxitemList5.ItemIndex]);
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonPickItemDelClick(Sender: TObject);
begin
  if ListBoxAllowPickUpItem.ItemIndex >= 0 then begin
    ListBoxAllowPickUpItem.Items.Delete(ListBoxAllowPickUpItem.ItemIndex);
    ModValue();
  end;
  if ListBoxAllowPickUpItem.ItemIndex < 0 then
    ButtonPickItemDel.Enabled := False;
end;

procedure TfrmViewList.ButtonGroupItemAddClick(Sender: TObject);
var
  I: Integer;
  Edit: TEdit;
  SpinEdit: TSpinEdit;
  CheckBox: TCheckBox;
  GroupItem: TGroupItem;
begin
  FillChar(GroupItem, SizeOf(TGroupItem), #0);

  for I := 0 to GroupBoxUseGroupItem.ControlCount - 1 do begin
    if GroupBoxUseGroupItem.Controls[I] is TEdit then begin
      Edit := TEdit(GroupBoxUseGroupItem.Controls[I]);
      GroupItem.FLD_USEITEMS[Edit.Tag] := Trim(Edit.Text);
    end;
  end;

  for I := 0 to GroupBoxGroupItem.ControlCount - 1 do begin
    if GroupBoxGroupItem.Controls[I] is TCheckBox then begin
      CheckBox := TCheckBox(GroupBoxGroupItem.Controls[I]);
      GroupItem.FLD_FLAG[CheckBox.Tag] := CheckBox.Checked;
    end else
      if GroupBoxGroupItem.Controls[I] is TSpinEdit then begin
      SpinEdit := TSpinEdit(GroupBoxGroupItem.Controls[I]);
      GroupItem.FLD_RATE[SpinEdit.Tag] := SpinEdit.Value;
    end;
  end;
  GroupItem.FLD_HINTMSG := EditGroupItemHint.Text;

  if g_GroupItems.MemberCount(@GroupItem) <= 0 then begin
    Application.MessageBox('套装名称输入不正确！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditDRESSNAME.SetFocus;
    Exit;
  end;

  if g_GroupItems.Find(@GroupItem) then begin
    Application.MessageBox('此套装已经存在！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditDRESSNAME.SetFocus;
    Exit;
  end;
  if g_GroupItems.Add(@GroupItem) then begin
    ButtonGroupItemSave.Enabled := True;
    RefGroupItemList;
    Application.MessageBox('增加成功！！！', '提示信息', MB_OK + MB_ICONWARNING);
  end else begin
    Application.MessageBox('增加失败！！！', '错误信息', MB_OK + MB_ICONERROR);
  end;
end;

procedure TfrmViewList.ButtonGroupItemDelClick(Sender: TObject);
var
  I: Integer;
  Edit: TSpinEdit;
  CheckBox: TCheckBox;
  GroupItem: pTGroupItem;
  ListItem: TListItem;
begin
  ListItem := ListViewGroupItemList.Selected;
  if ListItem <> nil then begin
    GroupItem := pTGroupItem(ListItem.SubItems.Objects[0]);
    ButtonGroupItemDel.Enabled := False;
    if g_GroupItems.Delete(GroupItem) then begin
      ButtonGroupItemSave.Enabled := True;
      RefGroupItemList;
      Application.MessageBox('删除成功！！！', '提示信息', MB_OK + MB_ICONWARNING);
    end else begin
      Application.MessageBox('删除失败！！！', '错误信息', MB_OK + MB_ICONERROR);
    end;
  end;
end;

procedure TfrmViewList.ButtonGroupItemChgClick(Sender: TObject);
var
  I, nIndex: Integer;
  Edit: TEdit;
  SpinEdit: TSpinEdit;
  CheckBox: TCheckBox;
  OGroupItem: TGroupItem;
  GroupItem: TGroupItem;
  Item: pTGroupItem;
  ListItem: TListItem;
begin
  ListItem := ListViewGroupItemList.Selected;
  if ListItem <> nil then begin
    Item := pTGroupItem(ListItem.SubItems.Objects[0]);
    OGroupItem := Item^;

    FillChar(GroupItem, SizeOf(TGroupItem), #0);

    for I := 0 to GroupBoxUseGroupItem.ControlCount - 1 do begin
      if GroupBoxUseGroupItem.Controls[I] is TEdit then begin
        Edit := TEdit(GroupBoxUseGroupItem.Controls[I]);
        GroupItem.FLD_USEITEMS[Edit.Tag] := Trim(Edit.Text);
      end;
    end;

    GroupItem.FLD_HINTMSG := Trim(EditGroupItemHint.Text);

    for I := 0 to GroupBoxGroupItem.ControlCount - 1 do begin
      if GroupBoxGroupItem.Controls[I] is TCheckBox then begin
        CheckBox := TCheckBox(GroupBoxGroupItem.Controls[I]);
        GroupItem.FLD_FLAG[CheckBox.Tag] := CheckBox.Checked;
      end else
        if GroupBoxGroupItem.Controls[I] is TSpinEdit then begin
        SpinEdit := TSpinEdit(GroupBoxGroupItem.Controls[I]);
        GroupItem.FLD_RATE[SpinEdit.Tag] := SpinEdit.Value;
      end;
    end;
    if g_GroupItems.MemberCount(@GroupItem) <= 0 then begin
      //Item^ := OGroupItem;
      Application.MessageBox('套装名称输入不正确！！！', '错误信息', MB_OK + MB_ICONERROR);
      EditDRESSNAME.SetFocus;
      Exit;
    end;
  {  if g_GroupItems.Find(@GroupItem) then begin
      Application.MessageBox('此套装已经存在！！！', '错误信息', MB_OK + MB_ICONERROR);
      EditDRESSNAME.SetFocus;
      Exit;
    end; }
    Item^ := GroupItem;
    ButtonGroupItemSave.Enabled := True;
    ButtonGroupItemChg.Enabled := False;
    RefGroupItemList;
    Application.MessageBox('修改成功！！！', '提示信息', MB_OK + MB_ICONWARNING);
  end;
end;

procedure TfrmViewList.ListViewGroupItemClick(Sender: TObject);
var
  I: Integer;
  GroupItem: pTGroupItem;
  ListItem: TListItem;

  Edit: TEdit;
  SpinEdit: TSpinEdit;
  CheckBox: TCheckBox;
begin
  ListItem := ListViewGroupItemList.Selected;
  if ListItem <> nil then begin
    GroupItem := pTGroupItem(ListItem.SubItems.Objects[0]);

    EditDRESSNAME.Text := GroupItem.FLD_USEITEMS[0];
    EditWEAPONNAME.Text := GroupItem.FLD_USEITEMS[1];
    EditRIGHTHANDNAME.Text := GroupItem.FLD_USEITEMS[2];
    EditNECKLACENAME.Text := GroupItem.FLD_USEITEMS[3];
    EditHELMETNAME.Text := GroupItem.FLD_USEITEMS[4];
    EditARMRINGLNAME.Text := GroupItem.FLD_USEITEMS[5];
    EditARMRINGRNAME.Text := GroupItem.FLD_USEITEMS[6];
    EditRINGLNAME.Text := GroupItem.FLD_USEITEMS[7];
    EditRINGRNAME.Text := GroupItem.FLD_USEITEMS[8];
    EditBUJUKNAME.Text := GroupItem.FLD_USEITEMS[9];
    EditBELTNAME.Text := GroupItem.FLD_USEITEMS[10];
    EditBOOTSNAME.Text := GroupItem.FLD_USEITEMS[11];
    EditCHARMNAME.Text := GroupItem.FLD_USEITEMS[12];
    EditGroupItemHint.Text := GroupItem.FLD_HINTMSG;

    for I := 0 to GroupBoxGroupItem.ControlCount - 1 do begin
      if GroupBoxGroupItem.Controls[I] is TCheckBox then begin
        CheckBox := TCheckBox(GroupBoxGroupItem.Controls[I]);
        CheckBox.Checked := GroupItem.FLD_FLAG[CheckBox.Tag];
      end else
        if GroupBoxGroupItem.Controls[I] is TSpinEdit then begin
        SpinEdit := TSpinEdit(GroupBoxGroupItem.Controls[I]);
        SpinEdit.Value := GroupItem.FLD_RATE[SpinEdit.Tag];
      end;
    end;

    ButtonGroupItemDel.Enabled := True;
    ButtonGroupItemChg.Enabled := True;
  end else begin
    ButtonGroupItemDel.Enabled := False;
    ButtonGroupItemChg.Enabled := False;
  end;
end;

procedure TfrmViewList.ButtonGroupItemSaveClick(Sender: TObject);
begin
  g_GroupItems.SaveToFile;
  ButtonGroupItemSave.Enabled := False;
  uModValue();
end;

procedure TfrmViewList.ListBox2Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBox2.ItemIndex >= 0 then
    ButtonUpgradeAdd.Enabled := True;
end;

procedure TfrmViewList.ListBox1Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBox1.ItemIndex >= 0 then
    ButtonUpgradeDel.Enabled := True;
end;

procedure TfrmViewList.ButtonUpgradeAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBox2.ItemIndex >= 0 then begin
    for I := 0 to ListBox1.Items.Count - 1 do begin
      if ListBox1.Items.Strings[I] = ListBox2.Items.Strings[ListBox2.ItemIndex] then begin
        Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    ListBox1.Items.Add(ListBox2.Items.Strings[ListBox2.ItemIndex]);
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonUpgradeDelClick(Sender: TObject);
begin
  if ListBox1.ItemIndex >= 0 then begin
    ListBox1.Items.Delete(ListBox1.ItemIndex);
    ModValue();
  end;
  if ListBox1.ItemIndex < 0 then
    ButtonUpgradeDel.Enabled := False;
end;

procedure TfrmViewList.ButtonUpgradeAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBox1.Items.Clear;
  for I := 0 to ListBox2.Items.Count - 1 do begin
    ListBox1.Items.Add(ListBox2.Items.Strings[I]);
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonUpgradeDelAllClick(Sender: TObject);
begin
  ListBox1.Items.Clear;
  ButtonUpgradeDel.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ButtonUpgradesaveClick(Sender: TObject);
var
  I: Integer;
begin
  g_EnableUpgradeItemList.Lock;
  try
    g_EnableUpgradeItemList.Clear;
    for I := 0 to ListBox1.Items.Count - 1 do begin
      g_EnableUpgradeItemList.Add(ListBox1.Items.Strings[I])
    end;
  finally
    g_EnableUpgradeItemList.UnLock;
  end;
  SaveEnableUpgradeItem();
  uModValue();
end;

procedure TfrmViewList.ButtonScatterItemAddClick(Sender: TObject);
var
  I: Integer;
begin
  if ListBoxitemList6.ItemIndex >= 0 then begin
    for I := 0 to ListBoxAllowScatterItem.Items.Count - 1 do begin
      if ListBoxAllowScatterItem.Items.Strings[I] = ListBoxitemList6.Items.Strings[ListBoxitemList6.ItemIndex] then begin
        Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    ListBoxAllowScatterItem.Items.Add(ListBoxitemList6.Items.Strings[ListBoxitemList6.ItemIndex]);
    ModValue();
  end;
end;

procedure TfrmViewList.ButtonScatterItemDelClick(Sender: TObject);
begin
  if ListBoxAllowScatterItem.ItemIndex >= 0 then begin
    ListBoxAllowScatterItem.Items.Delete(ListBoxAllowScatterItem.ItemIndex);
    ModValue();
  end;
  if ListBoxAllowScatterItem.ItemIndex < 0 then
    ButtonScatterItemDel.Enabled := False;
end;

procedure TfrmViewList.ButtonScatterItemAddAllClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxAllowScatterItem.Items.Clear;
  for I := 0 to ListBoxitemList6.Items.Count - 1 do begin
    ListBoxAllowScatterItem.Items.Add(ListBoxitemList6.Items.Strings[I]);
  end;
  ModValue();
end;

procedure TfrmViewList.ButtonScatterItemDelAllClick(Sender: TObject);
begin
  ListBoxAllowScatterItem.Items.Clear;
  ButtonScatterItemDelAll.Enabled := False;
  ModValue();
end;

procedure TfrmViewList.ButtonScatterItemSaveClick(Sender: TObject);
var
  I: Integer;
  sItemIdx: string;
  sFileName: string;
begin
  sFileName := g_Config.sEnvirDir + 'ScatterItemAllowList.txt';
  g_AllowScatterItemList.Lock;
  try
    g_AllowScatterItemList.Clear;
    for I := 0 to ListBoxAllowScatterItem.Items.Count - 1 do begin
      g_AllowScatterItemList.Add(Trim(ListBoxAllowScatterItem.Items.Strings[I]));
    end;
  finally
    g_AllowScatterItemList.UnLock;
  end;
  try
    g_AllowScatterItemList.SaveToFile(sFileName);
  except
  end;
  uModValue();
end;

procedure TfrmViewList.ListBoxAllowScatterItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxAllowScatterItem.ItemIndex >= 0 then
    ButtonScatterItemDel.Enabled := True;
end;

procedure TfrmViewList.ListBoxitemList6Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if ListBoxitemList6.ItemIndex >= 0 then
    ButtonScatterItemAdd.Enabled := True;
end;

procedure TfrmViewList.ListViewGroupItemListClick(Sender: TObject);
var
  I: Integer;
  GroupItem: pTGroupItem;
  ListItem: TListItem;

  Edit: TEdit;
  SpinEdit: TSpinEdit;
  CheckBox: TCheckBox;
begin
  ListItem := ListViewGroupItemList.Selected;
  if ListItem <> nil then begin
    GroupItem := pTGroupItem(ListItem.SubItems.Objects[0]);

    EditDRESSNAME.Text := GroupItem.FLD_USEITEMS[0];
    EditWEAPONNAME.Text := GroupItem.FLD_USEITEMS[1];
    EditRIGHTHANDNAME.Text := GroupItem.FLD_USEITEMS[2];
    EditNECKLACENAME.Text := GroupItem.FLD_USEITEMS[3];
    EditHELMETNAME.Text := GroupItem.FLD_USEITEMS[4];
    EditARMRINGLNAME.Text := GroupItem.FLD_USEITEMS[5];
    EditARMRINGRNAME.Text := GroupItem.FLD_USEITEMS[6];
    EditRINGLNAME.Text := GroupItem.FLD_USEITEMS[7];
    EditRINGRNAME.Text := GroupItem.FLD_USEITEMS[8];
    EditBUJUKNAME.Text := GroupItem.FLD_USEITEMS[9];
    EditBELTNAME.Text := GroupItem.FLD_USEITEMS[10];
    EditBOOTSNAME.Text := GroupItem.FLD_USEITEMS[11];
    EditCHARMNAME.Text := GroupItem.FLD_USEITEMS[12];
    EditGroupItemHint.Text := GroupItem.FLD_HINTMSG;

    for I := 0 to GroupBoxGroupItem.ControlCount - 1 do begin
      if GroupBoxGroupItem.Controls[I] is TCheckBox then begin
        CheckBox := TCheckBox(GroupBoxGroupItem.Controls[I]);
        CheckBox.Checked := GroupItem.FLD_FLAG[CheckBox.Tag];
      end else
        if GroupBoxGroupItem.Controls[I] is TSpinEdit then begin
        SpinEdit := TSpinEdit(GroupBoxGroupItem.Controls[I]);
        SpinEdit.Value := GroupItem.FLD_RATE[SpinEdit.Tag];
      end;
    end;

    ButtonGroupItemDel.Enabled := True;
    ButtonGroupItemChg.Enabled := True;
  end else begin
    ButtonGroupItemDel.Enabled := False;
    ButtonGroupItemChg.Enabled := False;
  end;
end;

procedure TfrmViewList.RefListViewBoxItems(ItemList: TStringList);
var
  I: Integer;
  ListItem: TListItem;
  BoxItem: pTBoxItem;
begin
  ListViewBoxItems.Items.BeginUpdate;
  try
    ListViewBoxItems.Items.Clear;
    if ItemList <> nil then begin
      for I := 0 to ItemList.Count - 1 do begin
        BoxItem := pTBoxItem(ItemList.Objects[I]);
        ListItem := ListViewBoxItems.Items.Add;
        ListItem.Caption := GetBoxItemTypeName(BoxItem.ItemType);
        ListItem.SubItems.AddObject(BoxItem.sItemName, TObject(BoxItem));
        ListItem.SubItems.Add(IntToStr(BoxItem.nItemCount));
      end;
    end;
  finally
    ListViewBoxItems.Items.EndUpdate;
  end;
end;

procedure TfrmViewList.ButtonBoxItemAddClick(Sender: TObject);
var
  I: Integer;
  boFind: Boolean;
  StdItem: pTStdItem;
  BoxItem: pTBoxItem;
  nItemIndex: Integer;
begin
  if (SelItemBox = nil) then Exit;
  nItemIndex := ListBoxitemList7.ItemIndex;
  if nItemIndex >= 0 then begin
    StdItem := pTStdItem(ListBoxitemList7.Items.Objects[nItemIndex]);
    boFind := False;
    {for I := 0 to SelItemBox.ItemList.Count - 1 do begin
      if CompareText(StdItem.Name, pTBoxItem(SelItemBox.ItemList.Objects[I]).sItemName) = 0 then begin
        boFind := True;
        Break;
      end;
    end; }
    if RadioGroupBoxItemType.ItemIndex < 0 then begin
      Application.MessageBox('请选择物品类型！！！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;

    if not boFind then begin
      New(BoxItem);
      BoxItem.sItemName := StdItem.Name;
      BoxItem.ItemType := TBoxItemType(RadioGroupBoxItemType.ItemIndex);
      BoxItem.nItemCount := EditBoxItemCount.Value;
      SelItemBox.ItemList.AddObject(SelItemBox.StdItem.Name, TObject(BoxItem));
      RefListViewBoxItems(SelItemBox.ItemList);
      ButtonBoxItemSave.Enabled := True;
    end else begin
      Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
  end;
end;

procedure TfrmViewList.ListBoxBoxsClick(Sender: TObject);
var
  nItemIndex: Integer;
begin
  SelItemBox := nil;
  nItemIndex := ListBoxBoxs.ItemIndex;
  if nItemIndex >= 0 then begin
    SelItemBox := pTItemBox(ListBoxBoxs.Items.Objects[nItemIndex]);
    RefListViewBoxItems(SelItemBox.ItemList);
    ButtonBoxItemDel.Enabled := False;
  end;
end;

procedure TfrmViewList.ButtonBoxItemDelClick(Sender: TObject);
var
  I: Integer;
begin
  if (SelBoxItem = nil) or (SelItemBox = nil) then Exit;
  for I := SelItemBox.ItemList.Count - 1 downto 0 do begin
    if pTBoxItem(SelItemBox.ItemList.Objects[I]) = SelBoxItem then begin
      SelItemBox.ItemList.Delete(I);
      Dispose(SelBoxItem);
      Break;
    end;
  end;
  SelBoxItem := nil;
  RefListViewBoxItems(SelItemBox.ItemList);
  ButtonBoxItemSave.Enabled := True;
  ButtonBoxItemDel.Enabled := False;
end;

procedure TfrmViewList.ListViewBoxItemsClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  if (SelItemBox = nil) then Exit;
  SelBoxItem := nil;
  ListItem := ListViewBoxItems.Selected;
  if ListItem <> nil then begin
    SelBoxItem := pTBoxItem(ListItem.SubItems.Objects[0]);
    RadioGroupBoxItemType.ItemIndex := Integer(SelBoxItem.ItemType);
    EditBoxItemCount.Value := SelBoxItem.nItemCount;
    ButtonBoxItemDel.Enabled := True;
  end else begin
    ButtonBoxItemDel.Enabled := False;
  end;
end;

procedure TfrmViewList.RadioGroupBoxItemTypeClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  if (SelBoxItem = nil) or (SelItemBox = nil) then Exit;
  ListItem := ListViewBoxItems.Selected;
  if ListItem <> nil then begin
    SelBoxItem.ItemType := TBoxItemType(RadioGroupBoxItemType.ItemIndex);
    ListItem.Caption := GetBoxItemTypeName(SelBoxItem.ItemType);
    ButtonBoxItemSave.Enabled := True;
  end;
end;

procedure TfrmViewList.ListBoxitemList7Click(Sender: TObject);
begin
  if not boOpened then Exit;
  if (ListBoxBoxs.ItemIndex < 0) then Exit;
  ButtonBoxItemAdd.Enabled := True;
end;

procedure TfrmViewList.ButtonBoxItemSaveClick(Sender: TObject);
begin
  SaveBoxList();
  ButtonBoxItemAdd.Enabled := False;
  ButtonBoxItemDel.Enabled := False;
  uModValue();
end;

procedure TfrmViewList.EditBoxItemCountChange(Sender: TObject);
var
  ListItem: TListItem;
begin
  if (SelBoxItem = nil) or (SelItemBox = nil) then Exit;
  ListItem := ListViewBoxItems.Selected;
  if ListItem <> nil then begin
    SelBoxItem.nItemCount := EditBoxItemCount.Value;
    ListItem.SubItems.Strings[1] := IntToStr(SelBoxItem.nItemCount);
    ButtonBoxItemSave.Enabled := True;
  end;
end;

end.
