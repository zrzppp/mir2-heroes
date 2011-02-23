unit HumManage;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grobal2, HumDB, IDDB, Menus, Clipbrd, RzButton, RzRadChk, ComCtrls,
  Grids, RzPanel, StdCtrls, Buttons, ExtCtrls, RzSplit;

type
  TfrmHumManage = class(TFrame)
    RzSizePanel1: TRzSizePanel;
    PopupMenu_GridUserItem: TPopupMenu;
    PopupMenu_GridUserItem_Del: TMenuItem;
    PopupMenu_ListViewBagItem: TPopupMenu;
    PopupMenu_ListViewBagItem_Del: TMenuItem;
    PopupMenu_ListViewStorageItem: TPopupMenu;
    PopupMenu_ListViewStorageItem_Del: TMenuItem;
    PopupMenu_ListViewMagic: TPopupMenu;
    PopupMenu_ListViewMagic_Del: TMenuItem;
    PopupMenu_ListViewBigStorageItem: TPopupMenu;
    PopupMenu_ListViewBigStorageItem_Del: TMenuItem;
    PopupMenu_ListViewSellItem: TPopupMenu;
    PopupMenu_ListViewSellItem_Del: TMenuItem;
    PopupMenu_GridUserItem_CopyItemName: TMenuItem;
    PopupMenu_ListViewBagItem_CopyItemName: TMenuItem;
    PopupMenu_ListViewStorageItem_CopyItemName: TMenuItem;
    PopupMenu_ListViewMagic_CopyItemName: TMenuItem;
    PopupMenu_ListViewBigStorageItem_CopyItemName: TMenuItem;
    PopupMenu_ListViewSellItem_CopyItemName: TMenuItem;
    PanelActCharSearch: TPanel;
    ButtonPrecisionSearchAccount: TRzToolbarButton;
    ButtonMistySearchAccount: TRzToolbarButton;
    ButtonPrecisionSearchCharName: TRzToolbarButton;
    ButtonMistySearchCharName: TRzToolbarButton;
    Label1: TLabel;
    RzLabel26: TLabel;
    RzLabel27: TLabel;
    RzLabel28: TLabel;
    RzLabel29: TLabel;
    RzLabel30: TLabel;
    ComboBoxAccount: TComboBox;
    ComboBoxCharName: TComboBox;
    ComboBoxHeroName: TComboBox;
    EditAccount: TEdit;
    EditCharName: TEdit;
    GroupBoxHumData: TRzGroupBox;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    RzLabel1: TLabel;
    RzLabel10: TLabel;
    RzLabel11: TLabel;
    RzLabel12: TLabel;
    RzLabel13: TLabel;
    RzLabel14: TLabel;
    RzLabel15: TLabel;
    RzLabel16: TLabel;
    RzLabel17: TLabel;
    RzLabel18: TLabel;
    RzLabel19: TLabel;
    RzLabel2: TLabel;
    RzLabel20: TLabel;
    RzLabel21: TLabel;
    RzLabel22: TLabel;
    RzLabel23: TLabel;
    RzLabel24: TLabel;
    RzLabel3: TLabel;
    RzLabel4: TLabel;
    RzLabel5: TLabel;
    RzLabel6: TLabel;
    RzLabel7: TLabel;
    RzLabel8: TLabel;
    RzLabel9: TLabel;
    ButtonDelCharName: TRzButton;
    ButtonOK: TRzButton;
    EditCreditPoint: TEdit;
    EditCurX: TEdit;
    EditCurY: TEdit;
    EditDearName: TEdit;
    EditDir: TEdit;
    EditExp: TEdit;
    EditGold: TEdit;
    EditHair: TEdit;
    EditHeroName: TEdit;
    EditHomeMap: TEdit;
    EditHomeX: TEdit;
    EditHomeY: TEdit;
    EditHP: TEdit;
    EditJob: TEdit;
    EditLevel: TEdit;
    EditMap: TEdit;
    EditMasterName: TEdit;
    EditMaxExp: TEdit;
    EditMaxHP: TEdit;
    EditMaxMP: TEdit;
    EditMP: TEdit;
    EditPKPoint: TEdit;
    EditSex: TEdit;
    EditStoragePwd: TEdit;
    TabSheet2: TTabSheet;
    GridUserItem: TStringGrid;
    TabSheet3: TTabSheet;
    ListViewBagItem: TListView;
    TabSheet4: TTabSheet;
    ListViewStorageItem: TListView;
    TabSheet5: TTabSheet;
    ListViewMagic: TListView;
    TabSheet6: TTabSheet;
    ListViewBigStorageItem: TListView;
    TabSheet7: TTabSheet;
    ListViewSellItem: TListView;
    GroupBoxHumList: TRzGroupBox;
    ListView: TListView;
    CheckBoxIsHero: TCheckBox;
    CheckBoxHasHero: TCheckBox;
    ButtonDelHeroRec: TRzButton;
    ButtonDelCharHeroRec: TRzButton;
    procedure ComboBoxAccountSelect(Sender: TObject);
    procedure ComboBoxCharNameSelect(Sender: TObject);
    procedure ComboBoxHeroNameSelect(Sender: TObject);
    procedure CheckBoxIsHeroClick(Sender: TObject);
    procedure ListViewClick(Sender: TObject);
    procedure ButtonPrecisionSearchAccountClick(Sender: TObject);
    procedure ButtonMistySearchAccountClick(Sender: TObject);
    procedure ButtonPrecisionSearchCharNameClick(Sender: TObject);
    procedure ButtonMistySearchCharNameClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure EditMapChange(Sender: TObject);
    procedure PopupMenu_GridUserItem_DelClick(Sender: TObject);
    procedure PopupMenu_GridUserItem_CopyItemNameClick(Sender: TObject);
    procedure PopupMenu_ListViewBagItem_DelClick(Sender: TObject);
    procedure PopupMenu_ListViewStorageItem_DelClick(Sender: TObject);
    procedure PopupMenu_ListViewBigStorageItem_DelClick(Sender: TObject);
    procedure PopupMenu_ListViewSellItem_DelClick(Sender: TObject);
    procedure PopupMenu_ListViewMagic_DelClick(Sender: TObject);
    procedure PopupMenu_ListViewBagItem_CopyItemNameClick(Sender: TObject);
    procedure PopupMenu_ListViewStorageItem_CopyItemNameClick(
      Sender: TObject);
    procedure PopupMenu_ListViewBigStorageItem_CopyItemNameClick(
      Sender: TObject);
    procedure PopupMenu_ListViewSellItem_CopyItemNameClick(
      Sender: TObject);
    procedure PopupMenu_ListViewMagic_CopyItemNameClick(Sender: TObject);
    procedure ButtonDelCharNameClick(Sender: TObject);
    procedure ButtonDelCharHeroRecClick(Sender: TObject);
  private
    { Private declarations }
    procedure AddHumDataToListView(HumData: pTHumDataInfo);
    procedure AddHumDataToEdit(HumData: pTHumDataInfo);
    function CheckUserEntrys: Boolean;
  public
    { Public declarations }
    procedure Init;
  end;

var
  frmHumManage: TfrmHumManage;

implementation
uses Share, ObjBase, HUtil32;
var
  HumDataInfo: pTHumDataInfo;
  AccountDBRecord: pTAccountDBRecord;
{$R *.dfm}

procedure RefAccountList;
var
  nItemIndex: Integer;
begin
  with frmHumManage do begin
    nItemIndex := ComboBoxAccount.ItemIndex;
    ComboBoxAccount.Items.Clear;
    ComboBoxAccount.Items.AddStrings(g_FileIDDB.m_IDDBList);
    if nItemIndex >= 0 then begin
      if nItemIndex < ComboBoxAccount.Items.Count then
        ComboBoxAccount.ItemIndex := nItemIndex;
    end;
  end;
end;

procedure TfrmHumManage.Init;
begin
{$IFDEF VCL70_OR_HIGHER}
  ParentBackground := False;
{$ENDIF}
  PageControl.ActivePageIndex := 0;
  SetLength(g_StartProc, Length(g_StartProc) + 1);
  g_StartProc[Length(g_StartProc) - 1] := RefAccountList;
  RefAccountList;
  HumDataInfo := nil;
  GridUserItem.Cells[0, 0] := '装备位置';
  GridUserItem.Cells[1, 0] := '装备名称';
  GridUserItem.Cells[2, 0] := '系列号';
  GridUserItem.Cells[3, 0] := '持久';
  GridUserItem.Cells[4, 0] := '攻';
  GridUserItem.Cells[5, 0] := '魔';
  GridUserItem.Cells[6, 0] := '道';
  GridUserItem.Cells[7, 0] := '防';
  GridUserItem.Cells[8, 0] := '魔防';
  GridUserItem.Cells[9, 0] := '附加属性';

  GridUserItem.Cells[0, 1] := '衣服';
  GridUserItem.Cells[0, 2] := '武器';
  GridUserItem.Cells[0, 3] := '照明物';
  GridUserItem.Cells[0, 4] := '项链';
  GridUserItem.Cells[0, 5] := '头盔';
  GridUserItem.Cells[0, 6] := '左手镯';
  GridUserItem.Cells[0, 7] := '右手镯';
  GridUserItem.Cells[0, 8] := '左戒指';
  GridUserItem.Cells[0, 9] := '右戒指';
  GridUserItem.Cells[0, 10] := '物品';
  GridUserItem.Cells[0, 11] := '腰带';
  GridUserItem.Cells[0, 12] := '鞋子';
  GridUserItem.Cells[0, 13] := '宝石';
  ButtonOK.Enabled := False;
  ButtonDelCharName.Enabled := False;
end;

function GetJob(btJob: Byte): string;
begin
  case btJob of
    0: Result := '战士';
    1: Result := '法师';
    2: Result := '道士';
  else Result := '未知';
  end;
end;

function GetSex(btSex: Byte): string;
begin
  case btSex of
    0: Result := '男';
    1: Result := '女';
  else Result := '不男不女';
  end;
end;

procedure TfrmHumManage.AddHumDataToListView(HumData: pTHumDataInfo);
var
  ListItem: TListItem;
begin
  {try
    ListView.Items.BeginUpdate;}
  ListItem := ListView.Items.Add;
  ListItem.Caption := HumData.Data.sAccount;
  ListItem.SubItems.AddObject(HumData.Data.sChrName, TObject(HumData));
  ListItem.SubItems.Add(HumData.Data.sCurMap);
  ListItem.SubItems.Add(IntToStr(HumData.Data.wCurX));
  ListItem.SubItems.Add(IntToStr(HumData.Data.wCurY));
  ListItem.SubItems.Add(IntToStr(HumData.Data.btDir));
  ListItem.SubItems.Add(GetJob(HumData.Data.btJob));
  ListItem.SubItems.Add(GetSex(HumData.Data.btSex));
  ListItem.SubItems.Add(IntToStr(HumData.Data.btHair));
  ListItem.SubItems.Add(IntToStr(HumData.Data.nGold));
  ListItem.SubItems.Add(HumData.Data.sHomeMap);
  ListItem.SubItems.Add(IntToStr(HumData.Data.wHomeX));
  ListItem.SubItems.Add(IntToStr(HumData.Data.wHomeY));
  ListItem.SubItems.Add(IntToStr(HumData.Data.Abil.Level));
  ListItem.SubItems.Add(IntToStr(HumData.Data.Abil.HP));
  ListItem.SubItems.Add(IntToStr(HumData.Data.Abil.MaxHP));
  ListItem.SubItems.Add(IntToStr(HumData.Data.Abil.MP));
  ListItem.SubItems.Add(IntToStr(HumData.Data.Abil.MaxMP));
  ListItem.SubItems.Add(IntToStr(HumData.Data.Abil.Exp));
  ListItem.SubItems.Add(IntToStr(HumData.Data.Abil.MaxExp));
  ListItem.SubItems.Add(IntToStr(HumData.Data.nPKPOINT));
  ListItem.SubItems.Add(HumData.Data.sDearName);
  ListItem.SubItems.Add(HumData.Data.sMasterName);
  ListItem.SubItems.Add(HumData.Data.sStoragePwd);
  ListItem.SubItems.Add(IntToStr(HumData.Data.btCreditPoint));
  ListItem.SubItems.Add(BooleanToStr(HumData.Header.boIsHero));
  ListItem.SubItems.Add(BooleanToStr(HumData.Data.sHeroChrName <> ''));
  ListItem.SubItems.Add(BooleanToStr(HumData.Header.boDeleted));
  {finally
    ListView.Items.EndUpdate;
  end; }
end;

procedure TfrmHumManage.AddHumDataToEdit(HumData: pTHumDataInfo);
var
  I, nCount: Integer;
  StdItem: pTStdItem_;
  Magic: pTMagic;
  Item: TStdItem_;
  UserItem: pTUserItem;
  ListItem: TListItem;
  ChrList: TList;
begin
  EditMap.Text := HumData.Data.sCurMap;
  EditCurX.Text := IntToStr(HumData.Data.wCurX);
  EditCurY.Text := IntToStr(HumData.Data.wCurY);
  EditDir.Text := IntToStr(HumData.Data.btDir);
  EditJob.Text := IntToStr(HumData.Data.btJob);
  EditSex.Text := IntToStr(HumData.Data.btSex);
  EditHair.Text := IntToStr(HumData.Data.btHair);
  EditGold.Text := IntToStr(HumData.Data.nGold);
  EditHomeMap.Text := HumData.Data.sHomeMap;
  EditHomeX.Text := IntToStr(HumData.Data.wHomeX);
  EditHomeY.Text := IntToStr(HumData.Data.wHomeY);
  EditLevel.Text := IntToStr(HumData.Data.Abil.Level);

  EditHP.Text := IntToStr(HumData.Data.Abil.HP);
  EditMaxHP.Text := IntToStr(HumData.Data.Abil.MaxHP);
  EditMP.Text := IntToStr(HumData.Data.Abil.MP);
  EditMaxMP.Text := IntToStr(HumData.Data.Abil.MaxMP);
  EditExp.Text := IntToStr(HumData.Data.Abil.Exp);
  EditMaxExp.Text := IntToStr(HumData.Data.Abil.MaxExp);

  EditPKPoint.Text := IntToStr(HumData.Data.nPKPOINT);
  EditDearName.Text := HumData.Data.sDearName;

  EditMasterName.Text := HumData.Data.sMasterName;
  EditStoragePwd.Text := HumData.Data.sStoragePwd;
  EditCreditPoint.Text := IntToStr(HumData.Data.btCreditPoint);

  CheckBoxHasHero.Checked := HumData.Data.boHasHero;
  EditHeroName.Text := HumData.Data.sHeroChrName;
  CheckBoxIsHero.Checked := HumData.Data.boIsHero;

  ListViewBagItem.Items.Clear;
  ListViewStorageItem.Items.Clear;
  ListViewMagic.Items.Clear;
  ListViewBigStorageItem.Items.Clear;
  ListViewSellItem.Items.Clear;

  //读取身上装备 9件
  for I := Low(HumData.Data.HumItems) to High(HumData.Data.HumItems) do begin
    if g_boSoftClose then Break;
    UserItem := @HumData.Data.HumItems[I];
    StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
    if StdItem = nil then begin
      GridUserItem.Cells[1, I + 1] := '';
      GridUserItem.Cells[2, I + 1] := '';
      GridUserItem.Cells[3, I + 1] := '';
      GridUserItem.Cells[4, I + 1] := '';
      GridUserItem.Cells[5, I + 1] := '';
      GridUserItem.Cells[6, I + 1] := '';
      GridUserItem.Cells[7, I + 1] := '';
      GridUserItem.Cells[8, I + 1] := '';
      GridUserItem.Cells[9, I + 1] := '';
      GridUserItem.Objects[1, I + 1] := nil;
      Continue;
    end;
    Item := StdItem^;
    g_LocalDB.GetItemAddValue(UserItem, Item);
    //showmessage(StdItem.Name+':'+IntToStr(StdItem.AC));
    GridUserItem.Objects[1, I + 1] := TObject(UserItem);
    GridUserItem.Cells[1, I + 1] := Item.Name;
    GridUserItem.Cells[2, I + 1] := IntToStr(UserItem.MakeIndex);
    GridUserItem.Cells[3, I + 1] := Format('%d/%d', [UserItem.Dura, UserItem.DuraMax]);
    GridUserItem.Cells[4, I + 1] := Format('%d/%d', [LoWord(Item.DC), HiWord(Item.DC)]);
    GridUserItem.Cells[5, I + 1] := Format('%d/%d', [LoWord(Item.MC), HiWord(Item.MC)]);
    GridUserItem.Cells[6, I + 1] := Format('%d/%d', [LoWord(Item.SC), HiWord(Item.SC)]);
    GridUserItem.Cells[7, I + 1] := Format('%d/%d', [LoWord(Item.AC), HiWord(Item.AC)]);
    GridUserItem.Cells[8, I + 1] := Format('%d/%d', [LoWord(Item.MAC), HiWord(Item.MAC)]);
    GridUserItem.Cells[9, I + 1] := Format('%d/%d/%d/%d/%d/%d/%d', [UserItem.btValue[0],
      UserItem.btValue[1],
        UserItem.btValue[2],
        UserItem.btValue[3],
        UserItem.btValue[4],
        UserItem.btValue[5],
        UserItem.btValue[6]]);
  end;

  //读取身上装备 增加的4件
  for I := Low(HumData.Data.HumAddItems) to High(HumData.Data.HumAddItems) do begin
    if g_boSoftClose then Break;
    UserItem := @HumData.Data.HumAddItems[I];
    StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
    if StdItem = nil then begin
      GridUserItem.Cells[1, I + 1] := '';
      GridUserItem.Cells[2, I + 1] := '';
      GridUserItem.Cells[3, I + 1] := '';
      GridUserItem.Cells[4, I + 1] := '';
      GridUserItem.Cells[5, I + 1] := '';
      GridUserItem.Cells[6, I + 1] := '';
      GridUserItem.Cells[7, I + 1] := '';
      GridUserItem.Cells[8, I + 1] := '';
      GridUserItem.Cells[9, I + 1] := '';
      GridUserItem.Objects[1, I + 1] := nil;
      Continue;
    end;
    Item := StdItem^;
    g_LocalDB.GetItemAddValue(UserItem, Item);
    GridUserItem.Objects[1, I + 1] := TObject(UserItem);
    GridUserItem.Cells[1, I + 1] := Item.Name;
    GridUserItem.Cells[2, I + 1] := IntToStr(UserItem.MakeIndex);
    GridUserItem.Cells[3, I + 1] := Format('%d/%d', [UserItem.Dura, UserItem.DuraMax]);
    GridUserItem.Cells[4, I + 1] := Format('%d/%d', [LoWord(Item.DC), HiWord(Item.DC)]);
    GridUserItem.Cells[5, I + 1] := Format('%d/%d', [LoWord(Item.MC), HiWord(Item.MC)]);
    GridUserItem.Cells[6, I + 1] := Format('%d/%d', [LoWord(Item.SC), HiWord(Item.SC)]);
    GridUserItem.Cells[7, I + 1] := Format('%d/%d', [LoWord(Item.AC), HiWord(Item.AC)]);
    GridUserItem.Cells[8, I + 1] := Format('%d/%d', [LoWord(Item.MAC), HiWord(Item.MAC)]);
    GridUserItem.Cells[9, I + 1] := Format('%d/%d/%d/%d/%d/%d/%d', [UserItem.btValue[0],
      UserItem.btValue[1],
        UserItem.btValue[2],
        UserItem.btValue[3],
        UserItem.btValue[4],
        UserItem.btValue[5],
        UserItem.btValue[6]]);
  end;

  //读取包裹装备
  nCount := 0;
  for I := Low(HumData.Data.BagItems) to High(HumData.Data.BagItems) do begin
    if g_boSoftClose then Break;
    UserItem := @HumData.Data.BagItems[I];
    StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
    if StdItem = nil then Continue;
    Inc(nCount);
    Item := StdItem^;
    g_LocalDB.GetItemAddValue(UserItem, Item);
    ListItem := ListViewBagItem.Items.Add;
    ListItem.Caption := IntToStr(nCount);
    ListItem.SubItems.AddObject(Item.Name, TObject(UserItem));
    ListItem.SubItems.Add(IntToStr(UserItem.MakeIndex));
    ListItem.SubItems.Add(Format('%d/%d', [UserItem.Dura, UserItem.DuraMax]));
    ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.DC), HiWord(Item.DC)]));
    ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.MC), HiWord(Item.MC)]));
    ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.SC), HiWord(Item.SC)]));
    ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.AC), HiWord(Item.AC)]));
    ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.MAC), HiWord(Item.MAC)]));
    ListItem.SubItems.Add(Format('%d/%d/%d/%d/%d/%d/%d', [UserItem.btValue[0],
      UserItem.btValue[1],
        UserItem.btValue[2],
        UserItem.btValue[3],
        UserItem.btValue[4],
        UserItem.btValue[5],
        UserItem.btValue[6]]));
  end;

  //读取魔法
  nCount := 0;
  for I := Low(HumData.Data.HumMagics) to High(HumData.Data.HumMagics) do begin
    if g_boSoftClose then Break;
    if HumData.Data.HumMagics[I].wMagIdx > 0 then begin
      if CheckBoxIsHero.Checked then begin
        Magic := g_LocalDB.FindHeroMagic(HumData.Data.HumMagics[I].wMagIdx);
      end else begin
        Magic := g_LocalDB.FindMagic(HumData.Data.HumMagics[I].wMagIdx);
      end;
      if Magic = nil then Continue;
      Inc(nCount);
      ListItem := ListViewMagic.Items.Add;
      ListItem.Caption := IntToStr(nCount);
      ListItem.SubItems.AddObject(Magic.sMagicName, TObject(@(HumData.Data.HumMagics[I])));
      ListItem.SubItems.Add(IntToStr(HumData.Data.HumMagics[I].wMagIdx));
      ListItem.SubItems.Add(IntToStr(HumData.Data.HumMagics[I].btLevel));
      ListItem.SubItems.Add(IntToStr(HumData.Data.HumMagics[I].btKey));
      ListItem.SubItems.Add(IntToStr(HumData.Data.HumMagics[I].nTranPoint));
    end;
  end;

  if CheckBoxIsHero.Checked then begin
    GroupBoxHumData.Caption := '英雄(' + HumData.Data.sChrName + ')';
  end else begin
    GroupBoxHumData.Caption := '人物(' + HumData.Data.sChrName + ')';

    //读取仓库装备
    nCount := 0;
    for I := Low(HumData.Data.StorageItems) to High(HumData.Data.StorageItems) do begin
      if g_boSoftClose then Break;
      UserItem := @HumData.Data.StorageItems[I];
      StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
      if StdItem = nil then Continue;
      Inc(nCount);
      Item := StdItem^;
      g_LocalDB.GetItemAddValue(UserItem, Item);
      ListItem := ListViewStorageItem.Items.Add;
      ListItem.Caption := IntToStr(nCount);
      ListItem.SubItems.AddObject(Item.Name, TObject(UserItem));
      ListItem.SubItems.Add(IntToStr(UserItem.MakeIndex));
      ListItem.SubItems.Add(Format('%d/%d', [UserItem.Dura, UserItem.DuraMax]));
      ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.DC), HiWord(Item.DC)]));
      ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.MC), HiWord(Item.MC)]));
      ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.SC), HiWord(Item.SC)]));
      ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.AC), HiWord(Item.AC)]));
      ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.MAC), HiWord(Item.MAC)]));
      ListItem.SubItems.Add(Format('%d/%d/%d/%d/%d/%d/%d', [UserItem.btValue[0],
        UserItem.btValue[1],
          UserItem.btValue[2],
          UserItem.btValue[3],
          UserItem.btValue[4],
          UserItem.btValue[5],
          UserItem.btValue[6]]));
    end;

    //读取无限仓库装备
    nCount := 0;
    if g_Storage.m_BigStorageList.GetList(HumData.Data.sChrName, ChrList) >= 0 then begin
      for I := 0 to ChrList.Count - 1 do begin
        if g_boSoftClose then Break;
        UserItem := @(pTBigStorage(ChrList.Items[I]).UserItem);
        StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
        if StdItem = nil then Continue;
        Inc(nCount);
        Item := StdItem^;
        g_LocalDB.GetItemAddValue(UserItem, Item);
        ListItem := ListViewBigStorageItem.Items.Add;
        ListItem.Caption := IntToStr(nCount);
        ListItem.SubItems.AddObject(Item.Name, TObject(UserItem));
        ListItem.SubItems.Add(IntToStr(UserItem.MakeIndex));
        ListItem.SubItems.Add(Format('%d/%d', [UserItem.Dura, UserItem.DuraMax]));
        ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.DC), HiWord(Item.DC)]));
        ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.MC), HiWord(Item.MC)]));
        ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.SC), HiWord(Item.SC)]));
        ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.AC), HiWord(Item.AC)]));
        ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.MAC), HiWord(Item.MAC)]));
        ListItem.SubItems.Add(Format('%d/%d/%d/%d/%d/%d/%d', [UserItem.btValue[0],
          UserItem.btValue[1],
            UserItem.btValue[2],
            UserItem.btValue[3],
            UserItem.btValue[4],
            UserItem.btValue[5],
            UserItem.btValue[6]]));
      end;
    end;

    //读取拍卖装备
    nCount := 0;
    if g_SellOff.m_SellOffList.GetList(HumData.Data.sChrName, ChrList) >= 0 then begin
      for I := 0 to ChrList.Count - 1 do begin
        if g_boSoftClose then Break;
        UserItem := @(pTSellOffInfo(ChrList.Items[I]).UserItem);
        StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
        if StdItem = nil then Continue;
        Inc(nCount);
        Item := StdItem^;
        g_LocalDB.GetItemAddValue(UserItem, Item);
        ListItem := ListViewSellItem.Items.Add;
        ListItem.Caption := IntToStr(nCount);
        ListItem.SubItems.AddObject(Item.Name, TObject(UserItem));
        ListItem.SubItems.Add(IntToStr(UserItem.MakeIndex));
        ListItem.SubItems.Add(Format('%d/%d', [UserItem.Dura, UserItem.DuraMax]));
        ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.DC), HiWord(Item.DC)]));
        ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.MC), HiWord(Item.MC)]));
        ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.SC), HiWord(Item.SC)]));
        ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.AC), HiWord(Item.AC)]));
        ListItem.SubItems.Add(Format('%d/%d', [LoWord(Item.MAC), HiWord(Item.MAC)]));
        ListItem.SubItems.Add(Format('%d/%d/%d/%d/%d/%d/%d', [UserItem.btValue[0],
          UserItem.btValue[1],
            UserItem.btValue[2],
            UserItem.btValue[3],
            UserItem.btValue[4],
            UserItem.btValue[5],
            UserItem.btValue[6]]));
      end;
    end;
  end;
end;

procedure TfrmHumManage.ComboBoxAccountSelect(Sender: TObject);
var
  I: Integer;
  nItemIndex: Integer;
  ChrList: TList;
  HumInfo: pTHumInfo;
  sAccount: string;
begin
  nItemIndex := ComboBoxAccount.ItemIndex;
  if nItemIndex >= 0 then begin
    sAccount := ComboBoxAccount.Items.Strings[nItemIndex];
    ComboBoxCharName.Items.Clear;
    ComboBoxHeroName.Items.Clear;
    if g_FileHumDB.m_HumDBList.GetList(sAccount, ChrList) >= 0 then begin
      for I := 0 to ChrList.Count - 1 do begin
        HumInfo := ChrList.Items[I];
        if HumInfo.boIsHero then
          ComboBoxHeroName.Items.AddObject(HumInfo.sChrName, TObject(HumInfo))
        else
          ComboBoxCharName.Items.AddObject(HumInfo.sChrName, TObject(HumInfo));
      end;
    end;
    EditAccount.Text := sAccount;
  end;
end;

procedure TfrmHumManage.ComboBoxCharNameSelect(Sender: TObject);
var
  nItemIndex: Integer;
  sCharName: string;
  nIndex: Integer;
begin
  HumDataInfo := nil;
  nItemIndex := ComboBoxCharName.ItemIndex;
  if nItemIndex >= 0 then begin
    sCharName := ComboBoxCharName.Items.Strings[nItemIndex];
    ListView.Items.BeginUpdate;
    try
      ListView.Clear;
    finally
      ListView.Items.EndUpdate;
    end;
    nIndex := g_FileDB.m_MirCharNameList.GetIndex(sCharName);
    if nIndex >= 0 then begin
      HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[nIndex]);
      AddHumDataToListView(HumDataInfo);
      AddHumDataToEdit(HumDataInfo);
      EditCharName.Text := sCharName;
    end;
  end;
end;

procedure TfrmHumManage.ComboBoxHeroNameSelect(Sender: TObject);
var
  nItemIndex: Integer;
  sCharName: string;
  nIndex: Integer;
begin
  HumDataInfo := nil;
  nItemIndex := ComboBoxHeroName.ItemIndex;
  if nItemIndex >= 0 then begin
    sCharName := ComboBoxHeroName.Items.Strings[nItemIndex];
    ListView.Items.BeginUpdate;
    try
      ListView.Clear;
    finally
      ListView.Items.EndUpdate;
    end;
    nIndex := g_FileDB.m_MirCharNameList.GetIndex(sCharName);
    if nIndex >= 0 then begin
      HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[nIndex]);
      AddHumDataToListView(HumDataInfo);
      AddHumDataToEdit(HumDataInfo);
      EditCharName.Text := sCharName;
    end;
  end;
end;

procedure TfrmHumManage.CheckBoxIsHeroClick(Sender: TObject);
begin
  TabSheet4.TabVisible := not CheckBoxIsHero.Checked;
  TabSheet6.TabVisible := not CheckBoxIsHero.Checked;
  TabSheet7.TabVisible := not CheckBoxIsHero.Checked;
  EditHeroName.Enabled := not CheckBoxIsHero.Checked;
  EditStoragePwd.Enabled := not CheckBoxIsHero.Checked;
  EditGold.Enabled := not CheckBoxIsHero.Checked;
  EditDearName.Enabled := not CheckBoxIsHero.Checked;
  EditCreditPoint.Enabled := not CheckBoxIsHero.Checked;
  EditMasterName.ReadOnly := CheckBoxIsHero.Checked;
  if CheckBoxIsHero.Checked then begin
    EditHeroName.Text := '';
    EditStoragePwd.Text := '';
    EditGold.Text := '';
    EditDearName.Text := '';
    EditCreditPoint.Text := '';
  end;
end;

procedure TfrmHumManage.ListViewClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  HumDataInfo := nil;
  ListItem := ListView.Selected;
  if ListItem <> nil then begin
    HumDataInfo := pTHumDataInfo(ListItem.SubItems.Objects[0]);
    AddHumDataToEdit(HumDataInfo);
    if HumDataInfo.Data.boIsHero then begin
      ButtonDelCharName.Enabled := False;
      ButtonDelHeroRec.Enabled := True;
      ButtonDelCharHeroRec.Enabled := False;
    end else begin
      ButtonDelCharName.Enabled := True;
      ButtonDelHeroRec.Enabled := False;

      ButtonDelCharHeroRec.Enabled := HumDataInfo.Data.sHeroChrName <> '';
    end;
  end;
end;

procedure TfrmHumManage.ButtonPrecisionSearchAccountClick(Sender: TObject);
var
  sAccount: string;
  I: Integer;
  HumData: pTHumDataInfo;
  nIndex: Integer;
begin
  sAccount := Trim(EditAccount.Text);
  if Length(sAccount) < 4 then Exit;
  PanelActCharSearch.Enabled := False;
  ListView.Items.BeginUpdate;
  try
    ListView.Clear;
  finally
    ListView.Items.EndUpdate;
  end;
  if Assigned(g_FileIDDB.OnStart) then g_FileIDDB.OnStart(Self,
      g_FileIDDB.m_IDDBList.Count, '正在查找，请稍候...');
  for I := 0 to g_FileIDDB.m_IDDBList.Count - 1 do begin
    if Assigned(g_FileIDDB.OnProgress) then g_FileIDDB.OnProgress(Self, I + 1,
        '');
    Application.ProcessMessages;
    if CompareText(g_FileIDDB.m_IDDBList.Strings[I], sAccount) = 0 then begin
      ComboBoxAccount.ItemIndex := I;
      Break;
    end;
  end;
  ComboBoxAccountSelect(ComboBoxAccount);

  for I := 0 to ComboBoxCharName.Items.Count - 1 do begin
    nIndex := g_FileDB.m_MirCharNameList.GetIndex(ComboBoxCharName.Items.Strings[I]);
    if nIndex >= 0 then begin
      HumData := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[nIndex]);
      AddHumDataToListView(HumData);
    end;
  end;


  for I := 0 to ComboBoxHeroName.Items.Count - 1 do begin
    nIndex := g_FileDB.m_MirCharNameList.GetIndex(ComboBoxHeroName.Items.Strings[I]);
    if nIndex >= 0 then begin
      HumData := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[nIndex]);
      AddHumDataToListView(HumData);
    end;
  end;

  PanelActCharSearch.Enabled := True;

  if Assigned(g_FileIDDB.OnStop) then g_FileIDDB.OnStop(Self, 0,
      '查找完成');
end;

procedure TfrmHumManage.ButtonMistySearchAccountClick(Sender: TObject);
var
  sAccount: string;
  I, II: Integer;
  DBRecord: pTAccountDBRecord;
  HumData: pTHumDataInfo;
  nIndex: Integer;
  ChrList: TList;
begin
  sAccount := Trim(EditAccount.Text);
  if Length(sAccount) < 1 then Exit;
  PanelActCharSearch.Enabled := False;
  if Assigned(g_FileIDDB.OnStart) then g_FileIDDB.OnStart(Self,
      g_FileIDDB.m_IDDBList.Count, '正在查找，请稍候...');
  ListView.Items.BeginUpdate;
  try
    ListView.Clear;
  finally
    ListView.Items.EndUpdate;
  end;
  for I := 0 to g_FileIDDB.m_IDDBList.Count - 1 do begin
    if Assigned(g_FileIDDB.OnProgress) then g_FileIDDB.OnProgress(Self, I + 1,
        '');
    Application.ProcessMessages;
    if (CompareText(g_FileIDDB.m_IDDBList.Strings[I], sAccount) = 0) or
      AnsiContainsText(g_FileIDDB.m_IDDBList.Strings[I], sAccount) or
      AnsiContainsText(sAccount, g_FileIDDB.m_IDDBList.Strings[I]) then begin
      if g_FileDB.m_MirDBList.GetList(g_FileIDDB.m_IDDBList.Strings[I], ChrList) >= 0 then begin
        for II := 0 to ChrList.Count - 1 do begin
          HumData := pTHumDataInfo(ChrList.Items[II]);
          AddHumDataToListView(HumData);
        end;
      end;
    end;
  end;
  if Assigned(g_FileIDDB.OnStop) then g_FileIDDB.OnStop(Self, 0,
      '查找完成');
  PanelActCharSearch.Enabled := True;
end;

procedure TfrmHumManage.ButtonPrecisionSearchCharNameClick(
  Sender: TObject);
var
  I: Integer;
  nIndex: Integer;
  sCharName: string;
  HumData: pTHumDataInfo;
begin
  sCharName := Trim(EditCharName.Text);
  if Length(sCharName) < 4 then Exit;
  PanelActCharSearch.Enabled := False;
  ListView.Items.BeginUpdate;
  try
    ListView.Clear;
  finally
    ListView.Items.EndUpdate;
  end;

  if Assigned(g_FileHumDB.OnStart) then g_FileHumDB.OnStart(Self,
      g_FileHumDB.m_HumCharNameList.Count, '正在查找，请稍候...');
  for I := 0 to g_FileHumDB.m_HumCharNameList.Count - 1 do begin
    if Assigned(g_FileHumDB.OnProgress) then g_FileHumDB.OnProgress(Self, I + 1,
        '');
    Application.ProcessMessages;
    if CompareStr(g_FileHumDB.m_HumCharNameList.Strings[I], sCharName) = 0 then begin
      nIndex := g_FileDB.m_MirCharNameList.GetIndex(sCharName);
      if nIndex >= 0 then begin
        HumData := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[nIndex]);
        AddHumDataToListView(HumData);
      end;
      Break;
    end;
  end;
  if Assigned(g_FileHumDB.OnStop) then g_FileHumDB.OnStop(Self, 0,
      '查找完成');
  PanelActCharSearch.Enabled := True;
end;

procedure TfrmHumManage.ButtonMistySearchCharNameClick(Sender: TObject);
var
  I: Integer;
  nIndex: Integer;
  sCharName: string;
  HumData: pTHumDataInfo;
begin
  sCharName := Trim(EditCharName.Text);
  if Length(sCharName) < 1 then Exit;
  PanelActCharSearch.Enabled := False;
  ListView.Items.BeginUpdate;
  try
    ListView.Clear;
  finally
    ListView.Items.EndUpdate;
  end;

  if Assigned(g_FileHumDB.OnStart) then g_FileHumDB.OnStart(Self,
      g_FileHumDB.m_HumCharNameList.Count, '正在查找，请稍候...');
  for I := 0 to g_FileHumDB.m_HumCharNameList.Count - 1 do begin

    if Assigned(g_FileHumDB.OnProgress) then g_FileHumDB.OnProgress(Self, I + 1,
        '');
    Application.ProcessMessages;
    if (CompareStr(g_FileHumDB.m_HumCharNameList.Strings[I], sCharName) = 0) or AnsiContainsText(g_FileHumDB.m_HumCharNameList.Strings[I], sCharName) or AnsiContainsText(sCharName, g_FileHumDB.m_HumCharNameList.Strings[I]) then begin
      nIndex := g_FileDB.m_MirCharNameList.GetIndex(g_FileHumDB.m_HumCharNameList.Strings[I]);
      if nIndex >= 0 then begin
        HumData := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[nIndex]);
        AddHumDataToListView(HumData);
      end;
    end;
  end;
  if Assigned(g_FileHumDB.OnStop) then g_FileHumDB.OnStop(Self, 0,
      '查找完成');
  PanelActCharSearch.Enabled := True;
end;

function TfrmHumManage.CheckUserEntrys: Boolean;
begin
  Result := False;

  Result := True;
end;

procedure TfrmHumManage.ButtonOKClick(Sender: TObject);
var
  sCurMap: string;
  wCurX: Integer;
  wCurY: Integer;
  btDir: Integer;
  btJob: Integer;
  btSex: Integer;
  btHair: Integer;
  nGold: Integer;
  sHomeMap: string;
  wHomeX: Integer;
  wHomeY: Integer;
  Level: Integer;
  HP: Integer;
  MP: Integer;
  Exp: Integer;
  nPKPOINT: Integer;
  sDearName: string;
  sMasterName: string;
  sStoragePwd: string;
  btCreditPoint: Integer;
begin
  if HumDataInfo = nil then Exit;
  sCurMap := Trim(EditMap.Text);
  wCurX := Str_ToInt(Trim(EditCurX.Text), -1);
  wCurY := Str_ToInt(Trim(EditCurY.Text), -1);
  btDir := Str_ToInt(Trim(EditDir.Text), -1);
  btJob := Str_ToInt(Trim(EditJob.Text), -1);
  btSex := Str_ToInt(Trim(EditSex.Text), -1);
  btHair := Str_ToInt(Trim(EditHair.Text), -1);
  nGold := Str_ToInt(Trim(EditGold.Text), -1);
  sHomeMap := Trim(EditHomeMap.Text);
  wHomeX := Str_ToInt(Trim(EditHomeX.Text), -1);
  wHomeY := Str_ToInt(Trim(EditHomeY.Text), -1);
  Level := Str_ToInt(Trim(EditLevel.Text), -1);
  HP := Str_ToInt(Trim(EditHP.Text), -1);
  MP := Str_ToInt(Trim(EditMP.Text), -1);
  Exp := Str_ToInt(Trim(EditExp.Text), -1);
  nPKPOINT := Str_ToInt(Trim(EditPKPoint.Text), -1);
  sDearName := Trim(EditDearName.Text);
  sMasterName := Trim(EditMasterName.Text);
  sStoragePwd := Trim(EditStoragePwd.Text);
  btCreditPoint := Str_ToInt(Trim(EditCreditPoint.Text), -1);

  if Length(sCurMap) < 1 then begin
    EditMap.SetFocus;
    Exit;
  end;
  if wCurX < 0 then begin
    EditCurX.SetFocus;
    Exit;
  end;
  if wCurY < 0 then begin
    EditCurY.SetFocus;
    Exit;
  end;
  if not (btDir in [0..7]) then begin
    EditDir.SetFocus;
    Exit;
  end;
  if not (btJob in [0..2]) then begin
    EditJob.SetFocus;
    Exit;
  end;
  if not (btSex in [0..1]) then begin
    EditSex.SetFocus;
    Exit;
  end;
  if btHair < 0 then begin
    EditHair.SetFocus;
    Exit;
  end;
  if nGold < 0 then begin
    EditGold.SetFocus;
    Exit;
  end;
  if Length(sHomeMap) < 1 then begin
    EditHomeMap.SetFocus;
    Exit;
  end;
  if wHomeX < 0 then begin
    EditHomeX.SetFocus;
    Exit;
  end;
  if wHomeY < 0 then begin
    EditHomeY.SetFocus;
    Exit;
  end;
  if (Level < 0) or (Level > 65535) then begin
    EditLevel.SetFocus;
    Exit;
  end;
  if (HP < 0) or (Level > 65535) then begin
    EditHP.SetFocus;
    Exit;
  end;
  if (MP < 0) or (MP > 65535) then begin
    EditMP.SetFocus;
    Exit;
  end;
  if Exp < 0 then begin
    EditExp.SetFocus;
    Exit;
  end;
  if nPKPOINT < 0 then begin
    EditPKPoint.SetFocus;
    Exit;
  end;

  if (sDearName <> '') and (Length(sDearName) < 4) then begin
    EditDearName.SetFocus;
    Exit;
  end;

  if (sMasterName <> '') and (Length(sMasterName) < 4) then begin
    EditMasterName.SetFocus;
    Exit;
  end;

  if (Length(sStoragePwd) < 0) or (Length(sStoragePwd) > 7) then begin
    EditStoragePwd.SetFocus;
    Exit;
  end;

  if (btCreditPoint < 0) or (btCreditPoint > 255) then begin
    EditCreditPoint.SetFocus;
    Exit;
  end;

  HumDataInfo.Data.sCurMap := sCurMap;

  HumDataInfo.Data.wCurX := wCurX;
  HumDataInfo.Data.wCurY := wCurY;
  HumDataInfo.Data.btDir := btDir;
  HumDataInfo.Data.btJob := btJob;
  HumDataInfo.Data.btSex := btSex;

  HumDataInfo.Data.btHair := btHair;
  HumDataInfo.Data.nGold := nGold;
  HumDataInfo.Data.sHomeMap := sHomeMap;
  HumDataInfo.Data.wHomeX := wHomeX;
  HumDataInfo.Data.wHomeY := wHomeY;
  HumDataInfo.Data.Abil.Level := Level;

  HumDataInfo.Data.Abil.HP := HP;

  HumDataInfo.Data.Abil.MP := MP;

  HumDataInfo.Data.Abil.Exp := Exp;

  HumDataInfo.Data.nPKPOINT := nPKPOINT;
  HumDataInfo.Data.sDearName := sDearName;

  HumDataInfo.Data.sMasterName := sMasterName;
  HumDataInfo.Data.sStoragePwd := sStoragePwd;
  HumDataInfo.Data.btCreditPoint := btCreditPoint;
  ButtonOK.Enabled := False;
end;

procedure TfrmHumManage.EditMapChange(Sender: TObject);
begin
  ButtonOK.Enabled := True;
end;

procedure TfrmHumManage.PopupMenu_GridUserItem_DelClick(Sender: TObject);
var
  I: Integer;
  nSelIndex: Integer;
  UserItem: pTUserItem;
begin
  nSelIndex := GridUserItem.Row;
  if (nSelIndex > 0) and (nSelIndex <= GridUserItem.RowCount) then begin
    UserItem := pTUserItem(GridUserItem.Objects[1, nSelIndex]);
    if UserItem = nil then Exit;
    UserItem.wIndex := 0;
    for I := 1 to 9 do begin
      GridUserItem.Cells[I, nSelIndex] := '';
    end;
  end;
end;

procedure TfrmHumManage.PopupMenu_GridUserItem_CopyItemNameClick(
  Sender: TObject);
var
  nSelIndex: Integer;
  UserItem: pTUserItem;
  Clipboard: TClipboard;
begin
  nSelIndex := GridUserItem.Row;
  if (nSelIndex > 0) and (nSelIndex <= GridUserItem.RowCount) then begin
    UserItem := pTUserItem(GridUserItem.Objects[1, nSelIndex]);
    if UserItem = nil then Exit;
    Clipboard := TClipboard.Create();
    Clipboard.AsText := GridUserItem.Cells[1, nSelIndex];
    Clipboard.Free();
  end;
end;

procedure TfrmHumManage.PopupMenu_ListViewBagItem_DelClick(
  Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  UserItem: pTUserItem;
begin
  for I := ListViewBagItem.Items.Count - 1 downto 0 do begin
    ListItem := ListViewBagItem.Items.Item[I];
    if ListItem.Selected then begin
      UserItem := pTUserItem(ListItem.SubItems.Objects[0]);
      UserItem.wIndex := 0;
      ListViewBagItem.Items.Delete(I);
    end;
  end;
end;

procedure TfrmHumManage.PopupMenu_ListViewStorageItem_DelClick(
  Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  UserItem: pTUserItem;
begin
  for I := ListViewStorageItem.Items.Count - 1 downto 0 do begin
    ListItem := ListViewStorageItem.Items.Item[I];
    if ListItem.Selected then begin
      UserItem := pTUserItem(ListItem.SubItems.Objects[0]);
      UserItem.wIndex := 0;
      ListViewStorageItem.Items.Delete(I);
    end;
  end;
end;

procedure TfrmHumManage.PopupMenu_ListViewBigStorageItem_DelClick(
  Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  UserItem: pTUserItem;
begin
  for I := ListViewBigStorageItem.Items.Count - 1 downto 0 do begin
    ListItem := ListViewBigStorageItem.Items.Item[I];
    if ListItem.Selected then begin
      UserItem := pTUserItem(ListItem.SubItems.Objects[0]);
      UserItem.wIndex := 0;
      ListViewBigStorageItem.Items.Delete(I);
    end;
  end;
end;

procedure TfrmHumManage.PopupMenu_ListViewSellItem_DelClick(
  Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  UserItem: pTUserItem;
begin
  for I := ListViewSellItem.Items.Count - 1 downto 0 do begin
    ListItem := ListViewSellItem.Items.Item[I];
    if ListItem.Selected then begin
      UserItem := pTUserItem(ListItem.SubItems.Objects[0]);
      UserItem.wIndex := 0;
      ListViewSellItem.Items.Delete(I);
    end;
  end;
end;

procedure TfrmHumManage.PopupMenu_ListViewMagic_DelClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  HumMagic: pTHumMagic;
begin
  for I := ListViewMagic.Items.Count - 1 downto 0 do begin
    ListItem := ListViewMagic.Items.Item[I];
    if ListItem.Selected then begin
      HumMagic := pTHumMagic(ListItem.SubItems.Objects[0]);
      HumMagic.wMagIdx := 0;
      ListViewMagic.Items.Delete(I);
    end;
  end;
end;

procedure TfrmHumManage.PopupMenu_ListViewBagItem_CopyItemNameClick(
  Sender: TObject);
var
  Clipboard: TClipboard;
  ListItem: TListItem;
begin
  ListItem := ListViewBagItem.Selected;
  if ListItem <> nil then begin
    Clipboard := TClipboard.Create();
    Clipboard.AsText := ListItem.SubItems.Strings[0];
    Clipboard.Free();
  end;
end;

procedure TfrmHumManage.PopupMenu_ListViewStorageItem_CopyItemNameClick(
  Sender: TObject);
var
  Clipboard: TClipboard;
  ListItem: TListItem;
begin
  ListItem := ListViewStorageItem.Selected;
  if ListItem <> nil then begin
    Clipboard := TClipboard.Create();
    Clipboard.AsText := ListItem.SubItems.Strings[0];
    Clipboard.Free();
  end;
end;

procedure TfrmHumManage.PopupMenu_ListViewBigStorageItem_CopyItemNameClick(
  Sender: TObject);
var
  Clipboard: TClipboard;
  ListItem: TListItem;
begin
  ListItem := ListViewBigStorageItem.Selected;
  if ListItem <> nil then begin
    Clipboard := TClipboard.Create();
    Clipboard.AsText := ListItem.SubItems.Strings[0];
    Clipboard.Free();
  end;
end;

procedure TfrmHumManage.PopupMenu_ListViewSellItem_CopyItemNameClick(
  Sender: TObject);
var
  Clipboard: TClipboard;
  ListItem: TListItem;
begin
  ListItem := ListViewSellItem.Selected;
  if ListItem <> nil then begin
    Clipboard := TClipboard.Create();
    Clipboard.AsText := ListItem.SubItems.Strings[0];
    Clipboard.Free();
  end;
end;

procedure TfrmHumManage.PopupMenu_ListViewMagic_CopyItemNameClick(
  Sender: TObject);
var
  Clipboard: TClipboard;
  ListItem: TListItem;
begin
  ListItem := ListViewMagic.Selected;
  if ListItem <> nil then begin
    Clipboard := TClipboard.Create();
    Clipboard.AsText := ListItem.SubItems.Strings[0];
    Clipboard.Free();
  end;
end;

procedure TfrmHumManage.ButtonDelCharNameClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  HumData: pTHumDataInfo;
  HeroData: pTHumDataInfo;
  MasterData: pTHumDataInfo;
  HumInfo: pTHumInfo;
  sCharName, sHeroChrName: string;
begin
  ListItem := ListView.Selected;
  if ListItem <> nil then begin
    HumData := pTHumDataInfo(ListItem.SubItems.Objects[0]);
    sCharName := HumData.Data.sChrName;
    if ButtonDelCharName = Sender then begin
      if Application.MessageBox(PChar('是否确认要删除人物： ' + sCharName + ' ？'),
        '提示信息',
        MB_YESNO + MB_ICONQUESTION) <> IDYES then Exit;
    end else begin
      if Application.MessageBox(PChar('是否确认要删除英雄： ' + sCharName + ' ？'),
        '提示信息',
        MB_YESNO + MB_ICONQUESTION) <> IDYES then Exit;
    end;

    for I := g_FileHumDB.m_HumCharNameList.Count - 1 downto 0 do begin
      if g_boSoftClose then Break;
      HumInfo := pTHumInfo(g_FileHumDB.m_HumCharNameList.Objects[I]);
      if CompareStr(HumInfo.sChrName, sCharName) = 0 then begin
        if HumData.Data.boIsHero then begin
          MasterData := g_FileDB.Get(HumData.Data.sMasterName);
          if MasterData <> nil then begin
            MasterData.Data.sHeroChrName := '';
            MasterData.Data.boHasHero := False;
          end;

          g_FileHumDB.Delete(HumInfo);
          g_FileDB.Delete(HumData);
          Dispose(HumData);
          Dispose(HumInfo);
          ListView.DeleteSelected;
          Break;
        end else begin
          sHeroChrName := HumData.Data.sHeroChrName;
          g_FileHumDB.Delete(HumInfo);
          g_FileDB.Delete(HumData);
          Dispose(HumData);
          Dispose(HumInfo);
          ListView.DeleteSelected;
          if sHeroChrName <> '' then begin
            HeroData := g_FileDB.Get(sHeroChrName);
            if HeroData <> nil then begin
              HumInfo := g_FileHumDB.Get(HeroData.Data.sChrName);
              if HumInfo <> nil then begin
                g_FileHumDB.Delete(HumInfo);
                Dispose(HumInfo);
              end;
              g_FileDB.Delete(HeroData);
              Dispose(HeroData);
            end;
          end;
          break;
        end;
      end;
    end;
  end;
  g_FileHumDB.m_HumDBList.SortString(0, g_FileHumDB.m_HumDBList.Count - 1);
  g_FileHumDB.m_HumCharNameList.SortString(0, g_FileHumDB.m_HumCharNameList.Count - 1);
  g_FileDB.m_MirDBList.SortString(0, g_FileDB.m_MirDBList.Count - 1);
  g_FileDB.m_MirCharNameList.SortString(0, g_FileDB.m_MirCharNameList.Count - 1);

  ButtonDelCharName.Enabled := False;
  ButtonDelHeroRec.Enabled := False;
end;

procedure TfrmHumManage.ButtonDelCharHeroRecClick(Sender: TObject);
var
  I, II: Integer;
  ListItem: TListItem;
  HumData: pTHumDataInfo;
  HeroData: pTHumDataInfo;
  MasterData: pTHumDataInfo;
  HumInfo: pTHumInfo;
  sCharName, sHeroChrName: string;
begin
  ListItem := ListView.Selected;
  if ListItem <> nil then begin
    HumData := pTHumDataInfo(ListItem.SubItems.Objects[0]);
    sCharName := HumData.Data.sChrName;

    if Application.MessageBox(PChar(Format('是否确认要删除%s的英雄： %s？', [sCharName, HumData.Data.sHeroChrName])),
      '提示信息',
      MB_YESNO + MB_ICONQUESTION) <> IDYES then Exit;

    for I := g_FileHumDB.m_HumCharNameList.Count - 1 downto 0 do begin
      if g_boSoftClose then Break;
      HumInfo := pTHumInfo(g_FileHumDB.m_HumCharNameList.Objects[I]);
      if CompareStr(HumInfo.sChrName, sCharName) = 0 then begin

        HumData.Data.sHeroChrName := '';
        HumData.Data.boHasHero := False;

        sHeroChrName := HumData.Data.sHeroChrName;
        if sHeroChrName <> '' then begin
          HeroData := g_FileDB.Get(sHeroChrName);
          if HeroData <> nil then begin
            HumInfo := g_FileHumDB.Get(HeroData.Data.sChrName);
            if HumInfo <> nil then begin
              g_FileHumDB.Delete(HumInfo);
              Dispose(HumInfo);
            end;

            for II := 0 to ListView.Items.Count - 1 do begin
              ListItem := ListView.Items.Item[II];
              if pTHumDataInfo(ListItem.SubItems.Objects[0]) = HeroData then begin
                ListView.Items.Delete(II);
                break;
              end;
            end;

            g_FileDB.Delete(HeroData);
            Dispose(HeroData);
          end;
        end;
        break;
      end;
    end;
  end;
  g_FileHumDB.m_HumDBList.SortString(0, g_FileHumDB.m_HumDBList.Count - 1);
  g_FileHumDB.m_HumCharNameList.SortString(0, g_FileHumDB.m_HumCharNameList.Count - 1);
  g_FileDB.m_MirDBList.SortString(0, g_FileDB.m_MirDBList.Count - 1);
  g_FileDB.m_MirCharNameList.SortString(0, g_FileDB.m_MirCharNameList.Count - 1);
  ButtonDelCharHeroRec.Enabled := False;
end;

end.

