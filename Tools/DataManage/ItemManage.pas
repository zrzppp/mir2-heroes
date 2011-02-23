unit ItemManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, HUtil32, Grobal2, HumDB, IDDB, ObjBase, Menus, RzPanel, RzSplit,
  ComCtrls, RzListVw, RzButton, StdCtrls, RzCmboBx, RzLabel, ExtCtrls, Clipbrd;

type
  TClearCopyItemThread = class(TThread)
  protected
    procedure Execute; override;
  end;
  TfrmItemManage = class(TFrame)
    PopupMenu_Search_CharItem: TPopupMenu;
    Menu_Search_CharItem_CopyAccount: TMenuItem;
    N3: TMenuItem;
    Menu_Search_CharItem_SelectAll: TMenuItem;
    Menu_Search_CharItem_NoSelectAll: TMenuItem;
    N6: TMenuItem;
    Menu_Search_CharItem_Del: TMenuItem;
    PopupMenu_ClearCopyItem: TPopupMenu;
    MenuItem_ClearFirst: TMenuItem;
    MenuItem_ClearNext: TMenuItem;
    Menu_Search_CharItem_CopyCharName: TMenuItem;
    Menu_Search_CharItem_CopyItemName: TMenuItem;
    PopupMenu_Search_CopyItem: TPopupMenu;
    Menu_Search_CopyItem_CopyAccount: TMenuItem;
    Menu_Search_CopyItem_CopyCharName: TMenuItem;
    Menu_Search_Copytem_CopyItemName: TMenuItem;
    MenuItem4: TMenuItem;
    Menu_Search_CopyItem_SelectAll: TMenuItem;
    Menu_Search_CopyItem_NoSelectAll: TMenuItem;
    MenuItem7: TMenuItem;
    Menu_Search_CopyItem_Del: TMenuItem;
    RzPanel1: TPanel;
    RzPanel5: TPanel;
    ComboBoxItemType: TComboBox;
    ComboBoxItemList: TComboBox;
    Button_Search_Add: TButton;
    Button_Search_Del: TButton;
    Button_Search_Clear: TButton;
    Panel_Search_Item: TPanel;
    Label1: TLabel;
    MenuButton_ClearCopyItem: TRzMenuButton;
    Button_Search_FindByList: TButton;
    Button_Search_FindCopyItem: TButton;
    Button_Search_FindByID: TButton;
    ButtonStopSearch: TButton;
    RzPanel2: TPanel;
    SizePanel1: TRzSizePanel;
    RzGroupBox2: TRzGroupBox;
    RzPanel3: TPanel;
    RzGroupBox1: TRzGroupBox;
    ListView_Search_Item: TListView;
    ListView_Search_CopyItem: TListView;
    ListView_Search_CharItem: TListView;
    RzLabel24: TLabel;
    RzLabel25: TLabel;
    procedure ComboBoxItemTypeClick(Sender: TObject);
    procedure Button_Search_AddClick(Sender: TObject);
    procedure Button_Search_DelClick(Sender: TObject);
    procedure Button_Search_ClearClick(Sender: TObject);
    procedure Button_Search_FindByListClick(Sender: TObject);
    procedure Button_Search_FindByIDClick(Sender: TObject);
    procedure Button_Search_FindCopyItemClick(Sender: TObject);
    procedure MenuItem_ClearFirstClick(Sender: TObject);
    procedure MenuItem_ClearNextClick(Sender: TObject);
    procedure ButtonStopSearchClick(Sender: TObject);
    procedure Menu_Search_CharItem_CopyAccountClick(Sender: TObject);
    procedure Menu_Search_CharItem_CopyCharNameClick(Sender: TObject);
    procedure Menu_Search_CharItem_CopyItemNameClick(Sender: TObject);
    procedure Menu_Search_CharItem_SelectAllClick(Sender: TObject);
    procedure Menu_Search_CharItem_NoSelectAllClick(Sender: TObject);
    procedure Menu_Search_CharItem_DelClick(Sender: TObject);
    procedure Menu_Search_CopyItem_CopyAccountClick(Sender: TObject);
    procedure Menu_Search_CopyItem_CopyCharNameClick(Sender: TObject);
    procedure Menu_Search_Copytem_CopyItemNameClick(Sender: TObject);
    procedure Menu_Search_CopyItem_SelectAllClick(Sender: TObject);
    procedure Menu_Search_CopyItem_NoSelectAllClick(Sender: TObject);
    procedure Menu_Search_CopyItem_DelClick(Sender: TObject);
  private
    { Private declarations }
    function IsIndex(Index: Integer): Boolean;
    function FindItem(UserItem: pTUserItem): Boolean;
  public
    { Public declarations }
    procedure Init;
  end;

var
  frmItemManage: TfrmItemManage;

implementation
uses Share;
var
  StopSearch: Boolean;
{$R *.dfm}



procedure TfrmItemManage.Init;
begin
{$IFDEF VCL70_OR_HIGHER}
  ParentBackground := False;
{$ENDIF}
  StopSearch := False;
end;

function TfrmItemManage.IsIndex(Index: Integer): Boolean;
var
  I: Integer;
  ListItem: TListItem;
  StdItem: pTStdItem_;
begin
  Result := False;
  for I := 0 to ListView_Search_Item.Items.Count - 1 do begin
    ListItem := ListView_Search_Item.Items.Item[I];
    StdItem := pTStdItem_(ListItem.SubItems.Objects[0]);
    if StdItem.Index = Index - 1 then begin
      Result := True;
      Exit;
    end;
  end;
end;

function TfrmItemManage.FindItem(UserItem: pTUserItem): Boolean;
var
  I: Integer;
  ListItem: TListItem;
begin
  Result := False;
  for I := 0 to ListView_Search_CopyItem.Items.Count - 1 do begin
    ListItem := ListView_Search_CopyItem.Items.Item[I];
    if pTUserItem(ListItem.SubItems.Objects[0]) = UserItem then begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure TfrmItemManage.ComboBoxItemTypeClick(Sender: TObject);
var
  nStdMode: Integer;
begin
  nStdMode := -1;
  case ComboBoxItemType.ItemIndex of
    0..6: nStdMode := ComboBoxItemType.ItemIndex;
    7: nStdMode := 10;
    8: nStdMode := 11;
    9: nStdMode := 15;
    10: nStdMode := 19;
    11: nStdMode := 20;
    12: nStdMode := 21;
    13: nStdMode := 22;
    14: nStdMode := 23;
    15: nStdMode := 24;
    16: nStdMode := 25;
    17: nStdMode := 26;
    18: nStdMode := 30;
    19: nStdMode := 31;

    20: nStdMode := 36;
    21: nStdMode := 40;
    22: nStdMode := 41;
    23: nStdMode := 42;
    24: nStdMode := 43;
    25: nStdMode := 44;
    26: nStdMode := 45;
    27: nStdMode := 46;
    28: nStdMode := 47;
    29: nStdMode := 50;
  end;
  g_LocalDB.GetStdItemList(nStdMode, ComboBoxItemList.Items);
end;

procedure TfrmItemManage.Button_Search_AddClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  StdItem: pTStdItem_;
  //sIdx: string;
begin
  if (ComboBoxItemType.ItemIndex < 0) or (ComboBoxItemList.ItemIndex < 0) then Exit;

  for I := 0 to ListView_Search_Item.Items.Count - 1 do begin
    ListItem := ListView_Search_Item.Items.Item[I];
    if ListItem.SubItems.Objects[0] = ComboBoxItemList.Items.Objects[ComboBoxItemList.ItemIndex] then begin
      Exit;
    end;
  end;

  StdItem := pTStdItem_(ComboBoxItemList.Items.Objects[ComboBoxItemList.ItemIndex]);
  //ArrestStringEx(ComboBoxItemList.Items.Strings[ComboBoxItemList.ItemIndex], '(', ')', sIdx);
  try
    ListView_Search_Item.Items.BeginUpdate;
    ListItem := ListView_Search_Item.Items.Add;
    ListItem.Caption := IntToStr(StdItem.Index);
    ListItem.SubItems.AddObject(StdItem.Name, TObject(StdItem));
  finally
    ListView_Search_Item.Items.EndUpdate;
  end;
end;

procedure TfrmItemManage.Button_Search_DelClick(Sender: TObject);
begin
  ListView_Search_Item.Items.BeginUpdate;
  try
    ListView_Search_Item.DeleteSelected;
  finally
    ListView_Search_Item.Items.EndUpdate;
  end;
end;

procedure TfrmItemManage.Button_Search_ClearClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认要清空？',
    '提示信息',
    MB_YESNO + MB_ICONQUESTION) <> IDYES then Exit;
  ListView_Search_Item.Items.BeginUpdate;
  try
    ListView_Search_Item.Clear;
  finally
    ListView_Search_Item.Items.EndUpdate;
  end;
end;

procedure TfrmItemManage.Button_Search_FindByListClick(Sender: TObject);

var
  I, II, III: Integer;
  HumDataInfo: pTHumDataInfo;
  SellOffInfo: pTSellOffInfo;
  BigStorage: pTBigStorage;
  HumData: pTHumData;
  StdItem: pTStdItem_;
  Item: TStdItem_;
  UserItem: pTUserItem;
  ListItem: TListItem;
begin
  StopSearch := False;
  Button_Search_FindByList.Enabled := False;

  ListView_Search_CharItem.Items.BeginUpdate;
  try
    ListView_Search_CharItem.Clear;
  finally
    ListView_Search_CharItem.Items.EndUpdate;
  end;

  if Assigned(g_FileDB.OnStart) then g_FileDB.OnStart(Self,
      g_FileDB.m_MirCharNameList.Count, '正在查找，请稍候...');

  for I := 0 to g_FileDB.m_MirCharNameList.Count - 1 do begin
    if Assigned(g_FileDB.OnProgress) then g_FileDB.OnProgress(Self, I + 1,
        '');
    Application.ProcessMessages;
    if StopSearch or g_boSoftClose then Break;
    HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[I]);
    HumData := @HumDataInfo.Data;
    for II := Low(HumData.HumItems) to High(HumData.HumItems) do begin
      UserItem := @HumData.HumItems[II];
      if (UserItem.wIndex > 0) and IsIndex(UserItem.wIndex) then begin
        StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
        if StdItem = nil then Continue;
        Item := StdItem^;
        ListItem := ListView_Search_CharItem.Items.Add;
        ListItem.Caption := '身上';
        ListItem.SubItems.AddObject(HumData.sAccount, TObject(UserItem));
        ListItem.SubItems.Add(HumData.sChrName);
        ListItem.SubItems.Add(Item.Name);
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
    for II := Low(HumData.HumAddItems) to High(HumData.HumAddItems) do begin
      UserItem := @HumData.HumAddItems[II];
      if (UserItem.wIndex > 0) and IsIndex(UserItem.wIndex) then begin
        StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
        if StdItem = nil then Continue;
        Item := StdItem^;
        ListItem := ListView_Search_CharItem.Items.Add;
        ListItem.Caption := '身上';
        ListItem.SubItems.AddObject(HumData.sAccount, TObject(UserItem));
        ListItem.SubItems.Add(HumData.sChrName);
        ListItem.SubItems.Add(Item.Name);
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
    for II := Low(HumData.BagItems) to High(HumData.BagItems) do begin
      UserItem := @HumData.BagItems[II];
      if (UserItem.wIndex > 0) and IsIndex(UserItem.wIndex) then begin
        StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
        if StdItem = nil then Continue;
        Item := StdItem^;
        ListItem := ListView_Search_CharItem.Items.Add;
        ListItem.Caption := '包裹';
        ListItem.SubItems.AddObject(HumData.sAccount, TObject(UserItem));
        ListItem.SubItems.Add(HumData.sChrName);
        ListItem.SubItems.Add(Item.Name);
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
    for II := Low(HumData.StorageItems) to High(HumData.StorageItems) do begin
      UserItem := @HumData.StorageItems[II];
      if (UserItem.wIndex > 0) and IsIndex(UserItem.wIndex) then begin
        StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
        if StdItem = nil then Continue;
        Item := StdItem^;
        ListItem := ListView_Search_CharItem.Items.Add;
        ListItem.Caption := '仓库';
        ListItem.SubItems.AddObject(HumData.sAccount, TObject(UserItem));
        ListItem.SubItems.Add(HumData.sChrName);
        ListItem.SubItems.Add(Item.Name);
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

  if Assigned(g_Storage.OnStart) then g_Storage.OnStart(Self,
      g_Storage.m_ItemList.Count, '正在查找，请稍候...');

  for I := 0 to g_Storage.m_ItemList.Count - 1 do begin
    if Assigned(g_Storage.OnProgress) then g_Storage.OnProgress(Self, I + 1,
        '');
    Application.ProcessMessages;
    if StopSearch or g_boSoftClose then Break;
    BigStorage := pTBigStorage(g_Storage.m_ItemList.Objects[I]);
    HumDataInfo := g_FileDB.Get(BigStorage.sCharName);
    if HumDataInfo <> nil then begin
      HumData := @HumDataInfo.Data;

      UserItem := @BigStorage.UserItem;
      if (UserItem.wIndex > 0) and IsIndex(UserItem.wIndex) then begin
        StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
        if StdItem = nil then Continue;
        Item := StdItem^;
        ListItem := ListView_Search_CharItem.Items.Add;
        ListItem.Caption := '无限仓库';
        ListItem.SubItems.AddObject(HumData.sAccount, TObject(UserItem));
        ListItem.SubItems.Add(HumData.sChrName);
        ListItem.SubItems.Add(Item.Name);
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

  if Assigned(g_SellOff.OnStart) then g_SellOff.OnStart(Self,
      g_SellOff.m_ItemList.Count, '正在查找，请稍候...');

  for I := 0 to g_SellOff.m_ItemList.Count - 1 do begin
    if Assigned(g_SellOff.OnProgress) then g_SellOff.OnProgress(Self, I + 1,
        '');
    Application.ProcessMessages;
    if StopSearch or g_boSoftClose then Break;
    SellOffInfo := pTSellOffInfo(g_SellOff.m_ItemList.Objects[I]);
    HumDataInfo := g_FileDB.Get(SellOffInfo.sCharName);
    if HumDataInfo <> nil then begin
      HumData := @HumDataInfo.Data;
      UserItem := @SellOffInfo.UserItem;

      if (UserItem.wIndex > 0) and IsIndex(UserItem.wIndex) then begin
        StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
        if StdItem = nil then Continue;
        Item := StdItem^;
        ListItem := ListView_Search_CharItem.Items.Add;
        ListItem.Caption := '拍卖';
        ListItem.SubItems.AddObject(HumData.sAccount, TObject(UserItem));
        ListItem.SubItems.Add(HumData.sChrName);
        ListItem.SubItems.Add(Item.Name);
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

  Button_Search_FindByList.Enabled := True;
  if Assigned(g_SellOff.OnStop) then g_SellOff.OnStop(Self, 0,
      '查找完成');
end;

procedure TfrmItemManage.Button_Search_FindByIDClick(Sender: TObject);
var
  sID: string;
  nIndex: Integer;

  I, II, III: Integer;
  HumDataInfo: pTHumDataInfo;
  SellOffInfo: pTSellOffInfo;
  BigStorage: pTBigStorage;
  HumData: pTHumData;
  StdItem: pTStdItem_;
  Item: TStdItem_;
  UserItem: pTUserItem;
  ListItem: TListItem;
begin
  if not InputQuery('输入要查询物品ID', '', sID) then Exit;
  nIndex := Str_ToInt(sID, -1);
  if nIndex < 0 then Exit;

  StopSearch := False;
  Button_Search_FindByList.Enabled := False;

  ListView_Search_CharItem.Items.BeginUpdate;
  try
    ListView_Search_CharItem.Clear;
  finally
    ListView_Search_CharItem.Items.EndUpdate;
  end;

  if Assigned(g_FileDB.OnStart) then g_FileDB.OnStart(Self,
      g_FileDB.m_MirCharNameList.Count, '正在查找，请稍候...');

  for I := 0 to g_FileDB.m_MirCharNameList.Count - 1 do begin
    if Assigned(g_FileDB.OnProgress) then g_FileDB.OnProgress(Self, I + 1,
        '');
    Application.ProcessMessages;
    if StopSearch or g_boSoftClose then Break;
    HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[I]);
    HumData := @HumDataInfo.Data;
    for II := Low(HumData.HumItems) to High(HumData.HumItems) do begin
      UserItem := @HumData.HumItems[II];
      if (UserItem.wIndex > 0) and (UserItem.wIndex = nIndex + 1) then begin
        StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
        if StdItem = nil then Continue;
        Item := StdItem^;
        ListItem := ListView_Search_CharItem.Items.Add;
        ListItem.Caption := '身上';
        ListItem.SubItems.AddObject(HumData.sAccount, TObject(UserItem));
        ListItem.SubItems.Add(HumData.sChrName);
        ListItem.SubItems.Add(Item.Name);
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
    for II := Low(HumData.HumAddItems) to High(HumData.HumAddItems) do begin
      UserItem := @HumData.HumAddItems[II];
      if (UserItem.wIndex > 0) and (UserItem.wIndex = nIndex + 1) then begin
        StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
        if StdItem = nil then Continue;
        Item := StdItem^;
        ListItem := ListView_Search_CharItem.Items.Add;
        ListItem.Caption := '身上';
        ListItem.SubItems.AddObject(HumData.sAccount, TObject(UserItem));
        ListItem.SubItems.Add(HumData.sChrName);
        ListItem.SubItems.Add(Item.Name);
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
    for II := Low(HumData.BagItems) to High(HumData.BagItems) do begin
      UserItem := @HumData.BagItems[II];
      if (UserItem.wIndex > 0) and (UserItem.wIndex = nIndex + 1) then begin
        StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
        if StdItem = nil then Continue;
        Item := StdItem^;
        ListItem := ListView_Search_CharItem.Items.Add;
        ListItem.Caption := '包裹';
        ListItem.SubItems.AddObject(HumData.sAccount, TObject(UserItem));
        ListItem.SubItems.Add(HumData.sChrName);
        ListItem.SubItems.Add(Item.Name);
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
    for II := Low(HumData.StorageItems) to High(HumData.StorageItems) do begin
      UserItem := @HumData.StorageItems[II];
      if (UserItem.wIndex > 0) and (UserItem.wIndex = nIndex + 1) then begin
        StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
        if StdItem = nil then Continue;
        Item := StdItem^;
        ListItem := ListView_Search_CharItem.Items.Add;
        ListItem.Caption := '仓库';
        ListItem.SubItems.AddObject(HumData.sAccount, TObject(UserItem));
        ListItem.SubItems.Add(HumData.sChrName);
        ListItem.SubItems.Add(Item.Name);
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

  if Assigned(g_Storage.OnStart) then g_Storage.OnStart(Self,
      g_Storage.m_ItemList.Count, '正在查找，请稍候...');
  for I := 0 to g_Storage.m_ItemList.Count - 1 do begin
    if Assigned(g_Storage.OnProgress) then g_Storage.OnProgress(Self, I + 1,
        '');
    Application.ProcessMessages;
    if StopSearch or g_boSoftClose then Break;
    BigStorage := pTBigStorage(g_Storage.m_ItemList.Objects[I]);
    HumDataInfo := g_FileDB.Get(BigStorage.sCharName);
    if HumDataInfo <> nil then begin
      HumData := @HumDataInfo.Data;

      UserItem := @BigStorage.UserItem;
      if (UserItem.wIndex > 0) and (UserItem.wIndex = nIndex + 1) then begin
        StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
        if StdItem = nil then Continue;
        Item := StdItem^;
        ListItem := ListView_Search_CharItem.Items.Add;
        ListItem.Caption := '无限仓库';
        ListItem.SubItems.AddObject(HumData.sAccount, TObject(UserItem));
        ListItem.SubItems.Add(HumData.sChrName);
        ListItem.SubItems.Add(Item.Name);
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

  if Assigned(g_SellOff.OnStart) then g_SellOff.OnStart(Self,
      g_SellOff.m_ItemList.Count, '正在查找，请稍候...');
  for I := 0 to g_SellOff.m_ItemList.Count - 1 do begin
    if Assigned(g_SellOff.OnProgress) then g_SellOff.OnProgress(Self, I + 1,
        '');
    Application.ProcessMessages;
    if StopSearch or g_boSoftClose then Break;
    SellOffInfo := pTSellOffInfo(g_SellOff.m_ItemList.Objects[I]);
    HumDataInfo := g_FileDB.Get(SellOffInfo.sCharName);
    if HumDataInfo <> nil then begin
      HumData := @HumDataInfo.Data;
      UserItem := @SellOffInfo.UserItem;

      if (UserItem.wIndex > 0) and (UserItem.wIndex = nIndex + 1) then begin
        StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
        if StdItem = nil then Continue;
        Item := StdItem^;
        ListItem := ListView_Search_CharItem.Items.Add;
        ListItem.Caption := '拍卖';
        ListItem.SubItems.AddObject(HumData.sAccount, TObject(UserItem));
        ListItem.SubItems.Add(HumData.sChrName);
        ListItem.SubItems.Add(Item.Name);
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

  if Assigned(g_SellOff.OnStop) then g_SellOff.OnStop(Self, 0,
      '查找完成');

  Button_Search_FindByList.Enabled := True;
end;

procedure TClearCopyItemThread.Execute;
begin

end;

procedure TfrmItemManage.Button_Search_FindCopyItemClick(Sender: TObject);
  function GetStartTime(nTime: LongWord): string;
  var
    h, s, m, s1: LongWord;
  begin
    if nTime >= 3600 then begin
      h := nTime div 3600;
      s := nTime mod 3600; //剩余秒
      m := s div 60;
      s1 := s mod 60;
      Result := Format('%d:%d:%d', [h, m, s1]);
    end else begin
      if nTime >= 60 then begin
        m := nTime div 60;
        s := nTime mod 60;
        Result := Format('%d:%d', [m, s]);
      end else begin
        Result := Format('%d', [nTime]);
      end;
    end;
  end;
var
  I, II, III: Integer;
  HumDataInfo: pTHumDataInfo;
  SellOffInfo: pTSellOffInfo;
  BigStorage: pTBigStorage;
  HumData: pTHumData;
  StdItem: pTStdItem_;
  Item: TStdItem_;
  UserItem: pTUserItem;
  ListItem: TListItem;
  ItemList: TList;
  ItemDataType: pTItemDataType;
  ItemDataType01: pTItemDataType;
  dwTimeTick: LongWord;
  dwLicTimeTick: LongWord;
  dwTempTimeTick: LongWord;
begin
  StopSearch := False;
  Button_Search_FindCopyItem.Enabled := False;

  ListView_Search_CopyItem.Items.BeginUpdate;
  try
    ListView_Search_CopyItem.Clear;
  finally
    ListView_Search_CopyItem.Items.EndUpdate;
  end;

  ItemList := TList.Create;

  if Assigned(g_FileDB.OnStart) then g_FileDB.OnStart(Self,
      g_FileDB.m_MirCharNameList.Count,
      '正在查找复制装备，请稍候...');

  for I := 0 to g_FileDB.m_MirCharNameList.Count - 1 do begin
    if Assigned(g_FileDB.OnProgress) then g_FileDB.OnProgress(Self, I + 1,
        '');
    Application.ProcessMessages;
    if StopSearch or g_boSoftClose then Break;
    HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[I]);
    HumData := @HumDataInfo.Data;
    for II := Low(HumData.HumItems) to High(HumData.HumItems) do begin
      if (HumData.HumItems[II].wIndex > 0) then begin
        New(ItemDataType);
        ItemDataType.btType := 0;
        ItemDataType.Item := @(HumData.HumItems[II]);
        ItemDataType.Owner := HumDataInfo;
        ItemList.Add(ItemDataType);
      end;
    end;
    for II := Low(HumData.HumAddItems) to High(HumData.HumAddItems) do begin
      if (HumData.HumAddItems[II].wIndex > 0) then begin
        New(ItemDataType);
        ItemDataType.btType := 0;
        ItemDataType.Item := @(HumData.HumAddItems[II]);
        ItemDataType.Owner := HumDataInfo;
        ItemList.Add(ItemDataType);
      end;
    end;
    for II := Low(HumData.BagItems) to High(HumData.BagItems) do begin
      if (HumData.BagItems[II].wIndex > 0) then begin
        New(ItemDataType);
        ItemDataType.btType := 1;
        ItemDataType.Item := @(HumData.BagItems[II]);
        ItemDataType.Owner := HumDataInfo;
        ItemList.Add(ItemDataType);
      end;
    end;
    for II := Low(HumData.StorageItems) to High(HumData.StorageItems) do begin
      if (HumData.StorageItems[II].wIndex > 0) then begin
        New(ItemDataType);
        ItemDataType.btType := 2;
        ItemDataType.Item := @(HumData.StorageItems[II]);
        ItemDataType.Owner := HumDataInfo;
        ItemList.Add(ItemDataType);
      end;
    end;
  end;

  if Assigned(g_Storage.OnStart) then g_Storage.OnStart(Self,
      g_Storage.m_ItemList.Count,
      '正在查找复制装备，请稍候...');
  for I := 0 to g_Storage.m_ItemList.Count - 1 do begin
    if Assigned(g_Storage.OnProgress) then g_Storage.OnProgress(Self, I + 1, '');
    Application.ProcessMessages;
    if StopSearch then Break;
    BigStorage := pTBigStorage(g_Storage.m_ItemList.Objects[I]);
    if (BigStorage.UserItem.wIndex > 0) then begin
      New(ItemDataType);
      ItemDataType.btType := 3;
      ItemDataType.Item := @(BigStorage.UserItem);
      ItemDataType.Owner := BigStorage;
      ItemList.Add(ItemDataType);
    end;
  end;

  if Assigned(g_SellOff.OnStart) then g_SellOff.OnStart(Self,
      g_SellOff.m_ItemList.Count, '正在查找复制装备，请稍候...');
  for I := 0 to g_SellOff.m_ItemList.Count - 1 do begin
    if Assigned(g_SellOff.OnProgress) then g_SellOff.OnProgress(Self, I + 1, '');
    Application.ProcessMessages;
    if StopSearch then Break;
    SellOffInfo := pTSellOffInfo(g_SellOff.m_ItemList.Objects[I]);
    if (SellOffInfo.UserItem.wIndex > 0) then begin
      New(ItemDataType);
      ItemDataType.btType := 4;
      ItemDataType.Item := @(SellOffInfo.UserItem);
      ItemDataType.Owner := SellOffInfo;
      ItemList.Add(ItemDataType);
    end;
  end;

  if Assigned(g_SellOff.OnStart) then g_SellOff.OnStart(Self,
      ItemList.Count, '正在查找复制装备，请稍候...');
  for I := 0 to ItemList.Count - 1 do begin //Time();
    dwTimeTick := GetTickCount;
    //dwLicTimeTick := GetTickCount;
    dwTempTimeTick := GetTickCount;
    if Assigned(g_SellOff.OnProgress) then g_SellOff.OnProgress(Self, I + 1, '');
    //GetStartTime(Round(dwLicTimeTick * (ItemList.Count - I - 1) / 1000));
    //ProcessMessage(Format('正在查找复制装备(%d/%d)，(%d)', [I + 1, ItemList.Count, (dwLicTimeTick * (ItemList.Count - I - 1)) / 1000]), 0);
    ProcessMessage(Format('正在查找复制装备(%d/%d) 剩余时间:' + GetStartTime(Round(dwLicTimeTick * (ItemList.Count - I - 1) / 1000)), [I + 1, ItemList.Count]), 0);

    Application.ProcessMessages; //剩余时间
    if StopSearch or g_boSoftClose then Break;
    ItemDataType := ItemList.Items[I];
    if Assigned(g_SellGold.OnStart) then g_SellGold.OnStart(Self, ItemList.Count - I - 1, '');
    for II := I + 1 to ItemList.Count - 1 do begin
      if Assigned(g_SellGold.OnProgress) then g_SellGold.OnProgress(Self, II - I, '');
      //Application.ProcessMessages;
      if StopSearch or g_boSoftClose then Break;
      ItemDataType01 := ItemList.Items[II];
      if pTUserItem(ItemDataType.Item).MakeIndex = pTUserItem(ItemDataType01.Item).MakeIndex then begin
        if not FindItem(pTUserItem(ItemDataType.Item)) then begin
          HumDataInfo := nil;
          case ItemDataType.btType of
            0..2: HumDataInfo := pTHumDataInfo(ItemDataType.Owner);
            3: HumDataInfo := g_FileDB.Get(pTBigStorage(ItemDataType.Owner).sCharName);
            4: HumDataInfo := g_FileDB.Get(pTSellOffInfo(ItemDataType.Owner).sCharName);
          end;
          if HumDataInfo <> nil then begin
            UserItem := pTUserItem(ItemDataType.Item);
            HumData := @HumDataInfo.Data;
            StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
            if StdItem = nil then Continue;
            Item := StdItem^;
            ListItem := ListView_Search_CopyItem.Items.Add;
            case ItemDataType.btType of
              0: ListItem.Caption := '身上';
              1: ListItem.Caption := '包裹';
              2: ListItem.Caption := '仓库';
              3: ListItem.Caption := '无限仓库';
              4: ListItem.Caption := '拍卖';
            end;
            ListItem.SubItems.AddObject(HumData.sAccount, TObject(UserItem));
            ListItem.SubItems.Add(HumData.sChrName);
            ListItem.SubItems.Add(Item.Name);
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

        if not FindItem(pTUserItem(ItemDataType01.Item)) then begin
          HumDataInfo := nil;
          case ItemDataType01.btType of
            0..2: HumDataInfo := pTHumDataInfo(ItemDataType01.Owner);
            3: HumDataInfo := g_FileDB.Get(pTBigStorage(ItemDataType01.Owner).sCharName);
            4: HumDataInfo := g_FileDB.Get(pTSellOffInfo(ItemDataType01.Owner).sCharName);
          end;
          if HumDataInfo <> nil then begin
            HumData := @HumDataInfo.Data;
            UserItem := pTUserItem(ItemDataType01.Item);
            StdItem := g_LocalDB.GetStdItem(UserItem.wIndex);
            if StdItem = nil then Continue;
            Item := StdItem^;
            ListItem := ListView_Search_CopyItem.Items.Add;
            case ItemDataType01.btType of
              0: ListItem.Caption := '身上';
              1: ListItem.Caption := '包裹';
              2: ListItem.Caption := '仓库';
              3: ListItem.Caption := '无限仓库';
              4: ListItem.Caption := '拍卖';
            end;
            ListItem.SubItems.AddObject(HumData.sAccount, TObject(UserItem));
            ListItem.SubItems.Add(HumData.sChrName);
            ListItem.SubItems.Add(Item.Name);
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
    end; //for II := I + 1 to ItemList.Count - 1 do begin
    dwLicTimeTick := GetTickCount - dwTimeTick;
    dwTempTimeTick := GetTickCount - dwTimeTick;
    if dwLicTimeTick <> dwTempTimeTick then dwLicTimeTick := dwTempTimeTick;

    if Assigned(g_SellGold.OnStop) then g_SellGold.OnStop(Self, 0, '');
  end;

  for I := 0 to ItemList.Count - 1 do begin
    Dispose(pTItemDataType(ItemList.Items[I]));
  end;
  ItemList.Free;

  Button_Search_FindCopyItem.Enabled := True;
  if Assigned(g_SellGold.OnStop) then g_SellGold.OnStop(Self, 0, '');
  if Assigned(g_SellGold.OnProgress) then g_SellGold.OnProgress(Self, 0, '');
  if Assigned(g_FileIDDB.OnStop) then g_FileIDDB.OnStop(Self, 0,
      '查找完成');
end;

procedure TfrmItemManage.MenuItem_ClearFirstClick(Sender: TObject);
var
  I, II: Integer;
  UserItem: pTUserItem;
  UserItem01: pTUserItem;
  ListItem: TListItem;
  ListItem01: TListItem;
begin
  for I := 0 to ListView_Search_CopyItem.Items.Count - 1 do begin
    ListItem := ListView_Search_CopyItem.Items.Item[I];
    UserItem := pTUserItem(ListItem.SubItems.Objects[0]);
    if UserItem.wIndex > 0 then begin
      for II := I + 1 to ListView_Search_CopyItem.Items.Count - 1 do begin
        ListItem01 := ListView_Search_CopyItem.Items.Item[II];
        UserItem01 := pTUserItem(ListItem01.SubItems.Objects[0]);
        if UserItem.MakeIndex = UserItem01.MakeIndex then begin
          UserItem.wIndex := 0;
        end;
      end;
    end;
  end;
  ListView_Search_CopyItem.Items.BeginUpdate;
  try
    ListView_Search_CopyItem.Clear;
  finally
    ListView_Search_CopyItem.Items.EndUpdate;
  end;
end;

procedure TfrmItemManage.MenuItem_ClearNextClick(Sender: TObject);
var
  I, II: Integer;
  UserItem: pTUserItem;
  UserItem01: pTUserItem;
  ListItem: TListItem;
  ListItem01: TListItem;
begin
  for I := 0 to ListView_Search_CopyItem.Items.Count - 1 do begin
    ListItem := ListView_Search_CopyItem.Items.Item[I];
    UserItem := pTUserItem(ListItem.SubItems.Objects[0]);
    if UserItem.wIndex > 0 then begin
      for II := I + 1 to ListView_Search_CopyItem.Items.Count - 1 do begin
        ListItem01 := ListView_Search_CopyItem.Items.Item[II];
        UserItem01 := pTUserItem(ListItem01.SubItems.Objects[0]);
        if UserItem.MakeIndex = UserItem01.MakeIndex then begin
          UserItem01.wIndex := 0;
        end;
      end;
    end;
  end;
  ListView_Search_CopyItem.Items.BeginUpdate;
  try
    ListView_Search_CopyItem.Clear;
  finally
    ListView_Search_CopyItem.Items.EndUpdate;
  end;
end;

procedure TfrmItemManage.ButtonStopSearchClick(Sender: TObject);
begin
  StopSearch := True;
end;

procedure TfrmItemManage.Menu_Search_CharItem_CopyAccountClick(
  Sender: TObject);
var
  Clipboard: TClipboard;
  ListItem: TListItem;
begin
  ListItem := ListView_Search_CharItem.Selected;
  if ListItem <> nil then begin
    Clipboard := TClipboard.Create();
    Clipboard.AsText := ListItem.SubItems.Strings[0];
    Clipboard.Free();
  end;
end;

procedure TfrmItemManage.Menu_Search_CharItem_CopyCharNameClick(
  Sender: TObject);
var
  Clipboard: TClipboard;
  ListItem: TListItem;
begin
  ListItem := ListView_Search_CharItem.Selected;
  if ListItem <> nil then begin
    Clipboard := TClipboard.Create();
    Clipboard.AsText := ListItem.SubItems.Strings[1];
    Clipboard.Free();
  end;
end;

procedure TfrmItemManage.Menu_Search_CharItem_CopyItemNameClick(
  Sender: TObject);
var
  Clipboard: TClipboard;
  ListItem: TListItem;
begin
  ListItem := ListView_Search_CharItem.Selected;
  if ListItem <> nil then begin
    Clipboard := TClipboard.Create();
    Clipboard.AsText := ListItem.SubItems.Strings[2];
    Clipboard.Free();
  end;
end;

procedure TfrmItemManage.Menu_Search_CharItem_SelectAllClick(
  Sender: TObject);
begin
  ListView_Search_CharItem.SelectAll;
end;

procedure TfrmItemManage.Menu_Search_CharItem_NoSelectAllClick(
  Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
begin
  for I := 0 to ListView_Search_CharItem.Items.Count - 1 do begin
    ListItem := ListView_Search_CharItem.Items.Item[I];
    if ListItem.Selected then begin
      ListItem.Selected := False;
    end;
  end;
end;

procedure TfrmItemManage.Menu_Search_CharItem_DelClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  UserItem: pTUserItem;
begin
  for I := ListView_Search_CharItem.Items.Count - 1 downto 0 do begin
    ListItem := ListView_Search_CharItem.Items.Item[I];
    if ListItem.Selected then begin
      UserItem := pTUserItem(ListItem.SubItems.Objects[0]);
      UserItem.wIndex := 0;
      ListView_Search_CharItem.Items.Delete(I);
    end;
  end;
end;

procedure TfrmItemManage.Menu_Search_CopyItem_CopyAccountClick(
  Sender: TObject);
var
  Clipboard: TClipboard;
  ListItem: TListItem;
begin
  ListItem := ListView_Search_CopyItem.Selected;
  if ListItem <> nil then begin
    Clipboard := TClipboard.Create();
    Clipboard.AsText := ListItem.SubItems.Strings[0];
    Clipboard.Free();
  end;
end;

procedure TfrmItemManage.Menu_Search_CopyItem_CopyCharNameClick(
  Sender: TObject);
var
  Clipboard: TClipboard;
  ListItem: TListItem;
begin
  ListItem := ListView_Search_CopyItem.Selected;
  if ListItem <> nil then begin
    Clipboard := TClipboard.Create();
    Clipboard.AsText := ListItem.SubItems.Strings[1];
    Clipboard.Free();
  end;
end;

procedure TfrmItemManage.Menu_Search_Copytem_CopyItemNameClick(
  Sender: TObject);
var
  Clipboard: TClipboard;
  ListItem: TListItem;
begin
  ListItem := ListView_Search_CopyItem.Selected;
  if ListItem <> nil then begin
    Clipboard := TClipboard.Create();
    Clipboard.AsText := ListItem.SubItems.Strings[2];
    Clipboard.Free();
  end;
end;

procedure TfrmItemManage.Menu_Search_CopyItem_SelectAllClick(
  Sender: TObject);
begin
  ListView_Search_CopyItem.SelectAll;
end;

procedure TfrmItemManage.Menu_Search_CopyItem_NoSelectAllClick(
  Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
begin
  for I := 0 to ListView_Search_CopyItem.Items.Count - 1 do begin
    ListItem := ListView_Search_CopyItem.Items.Item[I];
    if ListItem.Selected then begin
      ListItem.Selected := False;
    end;
  end;
end;

procedure TfrmItemManage.Menu_Search_CopyItem_DelClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  UserItem: pTUserItem;
begin
  for I := ListView_Search_CopyItem.Items.Count - 1 downto 0 do begin
    ListItem := ListView_Search_CopyItem.Items.Item[I];
    if ListItem.Selected then begin
      UserItem := pTUserItem(ListItem.SubItems.Objects[0]);
      UserItem.wIndex := 0;
      ListView_Search_CopyItem.Items.Delete(I);
    end;
  end;
end;

end.

