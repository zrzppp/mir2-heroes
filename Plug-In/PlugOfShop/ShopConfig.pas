unit ShopConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ComCtrls, EngineInterface, RzTabs, StrUtils;

type
  TFrmShopItem = class(TForm)
    GroupBox2: TGroupBox;
    ListBoxItemList: TListBox;
    Label1: TLabel;
    EditShopItemName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    ButtonChgShopItem: TButton;
    ButtonDelShopItem: TButton;
    SpinEditPrice: TSpinEdit;
    Memo2: TMemo;
    ButtonAddShopItem: TButton;
    ButtonLoadShopItemList: TButton;
    ButtonSaveShopItemList: TButton;
    RzPageControlShop: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    TabSheet5: TRzTabSheet;
    ListViewItemList1: TListView;
    TabSheet6: TRzTabSheet;
    Label4: TLabel;
    Memo1: TEdit;
    ListViewItemList2: TListView;
    ListViewItemList3: TListView;
    ListViewItemList4: TListView;
    ListViewItemList5: TListView;
    ListViewItemList6: TListView;
    Label5: TLabel;
    EditPicture: TEdit;
    CheckBoxRandomUpgrade: TCheckBox;
    CheckBoxLimitDay: TCheckBox;
    EditMaxLimitDay: TSpinEdit;
    EditAddValueRate: TSpinEdit;
    Label6: TLabel;
    EditItemCount: TSpinEdit;
    procedure ListViewItemList1Click(Sender: TObject);
    procedure ButtonChgShopItemClick(Sender: TObject);
    procedure ButtonDelShopItemClick(Sender: TObject);
    procedure ButtonAddShopItemClick(Sender: TObject);
    procedure ListBoxItemListClick(Sender: TObject);
    procedure ButtonSaveShopItemListClick(Sender: TObject);
    procedure ButtonLoadShopItemListClick(Sender: TObject);
  private
    { Private declarations }
    function InListViewItemList(sItemName: string): Boolean;
    procedure RefLoadShopItemList();
    function GetListView: TListView; overload;
    function GetListView(nIndex: Integer): TListView; overload;
    procedure RefListView(btType: Byte);
    procedure RefActiveListView();
    function GetActiveShopList: Classes.TList;
  public
    { Public declarations }
    procedure Open();
  end;

var
  FrmShopItem: TFrmShopItem;

implementation
uses PlayShop, HUtil32, PlugShare;
{$R *.dfm}

function TFrmShopItem.InListViewItemList(sItemName: string): Boolean;
var
  I: Integer;
  ListItem: TListItem;
begin
  Result := False;
  GetListView.Items.BeginUpdate;
  try
    for I := 0 to GetListView.Items.Count - 1 do begin
      ListItem := GetListView.Items.Item[I];
      if CompareText(sItemName, ListItem.Caption) = 0 then begin
        Result := True;
        Break;
      end;
    end;
  finally
    GetListView.Items.EndUpdate;
  end;
end;

procedure TFrmShopItem.RefListView(btType: Byte);
var
  I: Integer;
  ListItem: TListItem;
  ShopItem: pTShopItem;
  ListView: TListView;
begin
  ListView := GetListView(btType);
  if ListView <> nil then begin
    ListView.Clear;
    if g_ShopItemList[btType] <> nil then begin
      for I := 0 to g_ShopItemList[btType].Count - 1 do begin
        ShopItem := pTShopItem(g_ShopItemList[btType].Items[I]);
        ListView.Items.BeginUpdate;
        try
          ListItem := ListView.Items.Add;
          ListItem.Caption := ShopItem.StdItem.Name;
          ListItem.SubItems.AddObject(IntToStr(ShopItem.StdItem.Price), TObject(ShopItem));
          ListItem.SubItems.Add(Format('%d-%d', [ShopItem.nBeginIdx, ShopItem.nEndIdx]));
          ListItem.SubItems.Add(ShopItem.sMemo1);
          ListItem.SubItems.Add(ShopItem.sMemo2);
          if ShopItem.boLimitDay then begin
            ListItem.SubItems.Add(DateToStr(ShopItem.nMaxLimitDay + Date));
          end else begin
            ListItem.SubItems.Add('永久使用');
          end;
        finally
          ListView.Items.EndUpdate;
        end;
      end;
    end;
  end;
end;

procedure TFrmShopItem.RefActiveListView();
begin
  RefListView(RzPageControlShop.ActivePageIndex);
end;

procedure TFrmShopItem.RefLoadShopItemList();
var
  I: Integer;
begin
  for I := Low(g_ShopItemList) to High(g_ShopItemList) do begin
    if g_ShopItemList[I] <> nil then RefListView(I);
  end;
end;

procedure TFrmShopItem.Open();
var
  I: Integer;
  StdItem: pTStdItem;
  List: Classes.TList;
begin
  ButtonChgShopItem.Enabled := False;
  ButtonDelShopItem.Enabled := False;
  ButtonAddShopItem.Enabled := False;
  ListBoxItemList.Items.Clear;
  List := Classes.TList(g_UserManage.m_StdItemList);
  if List <> nil then begin
    for I := 0 to g_UserManage.EngineOut.List_Count(List) - 1 do begin
      StdItem := g_UserManage.EngineOut.List_Get(List, I);
      ListBoxItemList.Items.AddObject(StdItem.Name, TObject(StdItem));
    end;
  end;
  //LoadShopItemList();
  RefLoadShopItemList();
  ShowModal;
end;

procedure TFrmShopItem.ListViewItemList1Click(Sender: TObject);
var
  ListItem: TListItem;
  ShopItem: pTShopItem;
begin
  try
    ListItem := GetListView.Selected;
    if ListItem <> nil then begin
      ShopItem := pTShopItem(ListItem.SubItems.Objects[0]);
      EditShopItemName.Text := ShopItem.StdItem.Name;
      SpinEditPrice.Value := ShopItem.StdItem.Price;
      EditPicture.Text := Format('%d-%d', [ShopItem.nBeginIdx, ShopItem.nEndIdx]);
      Memo1.Text := ShopItem.sMemo1;
      Memo2.Lines.Text := ShopItem.sMemo2;
      CheckBoxLimitDay.Checked := ShopItem.boLimitDay;
      EditMaxLimitDay.Value := ShopItem.nMaxLimitDay;
      CheckBoxRandomUpgrade.Checked := ShopItem.boRandomUpgrade;
      EditAddValueRate.Value := ShopItem.nAddValueRate;
      ButtonChgShopItem.Enabled := True;
      ButtonDelShopItem.Enabled := True;
    end;
  except
    ButtonChgShopItem.Enabled := False;
    ButtonDelShopItem.Enabled := False;
  end;
end;

procedure TFrmShopItem.ButtonChgShopItemClick(Sender: TObject);
var
  ListItem: TListItem;
  I: Integer;
  ShopItem: pTShopItem;
  nEndCount: Integer;
  sMemo2, sPicture: string;
  sBegin: string;
begin
  if Memo2.Lines.Count >= 6 then nEndCount := 6 else nEndCount := Memo2.Lines.Count;
  sMemo2 := '';
  for I := 0 to nEndCount - 1 do begin
    sMemo2 := sMemo2 + Memo2.Lines.Strings[I] + #13;
  end;
  sMemo2 := Copy(sMemo2, 1, Length(sMemo2) - 1);
  sPicture := Trim(EditPicture.Text);
  sPicture := GetValidStr3(sPicture, sBegin, ['-']);
  try
    ListItem := GetListView.Selected;
    if ListItem <> nil then begin
      ShopItem := pTShopItem(ListItem.SubItems.Objects[0]);
      ShopItem.StdItem.Price := SpinEditPrice.Value;
      ShopItem.nBeginIdx := Str_ToInt(sBegin, -1);
      ShopItem.nEndIdx := Str_ToInt(sPicture, -1);
      ShopItem.sMemo1 := Trim(Memo1.Text);
      ShopItem.sMemo2 := sMemo2;
      ShopItem.boRandomUpgrade := CheckBoxRandomUpgrade.Checked;
      ShopItem.nAddValueRate := EditAddValueRate.Value;
      ShopItem.boLimitDay := CheckBoxLimitDay.Checked;
      ShopItem.nMaxLimitDay := EditMaxLimitDay.Value;

      ListItem.SubItems.Strings[0] := IntToStr(ShopItem.StdItem.Price);
      ListItem.SubItems.Strings[1] := Format('%d-%d', [ShopItem.nBeginIdx, ShopItem.nEndIdx]);
      ListItem.SubItems.Strings[2] := ShopItem.sMemo1;
      ListItem.SubItems.Strings[3] := ShopItem.sMemo2;
      if ShopItem.boLimitDay then begin
        ListItem.SubItems.Strings[4] := DateToStr(ShopItem.nMaxLimitDay + Date);
      end else begin
        ListItem.SubItems.Strings[4] := '永久使用';
      end;
    end;
  except

  end;
end;

function TFrmShopItem.GetListView: TListView;
begin
  Result := nil;
  case RzPageControlShop.ActivePageIndex of
    0: Result := ListViewItemList1;
    1: Result := ListViewItemList2;
    2: Result := ListViewItemList3;
    3: Result := ListViewItemList4;
    4: Result := ListViewItemList5;
    5: Result := ListViewItemList6;
  end;
end;

function TFrmShopItem.GetListView(nIndex: Integer): TListView;
begin
  Result := nil;
  case nIndex of
    0: Result := ListViewItemList1;
    1: Result := ListViewItemList2;
    2: Result := ListViewItemList3;
    3: Result := ListViewItemList4;
    4: Result := ListViewItemList5;
    5: Result := ListViewItemList6;
  end;
end;

function TFrmShopItem.GetActiveShopList: Classes.TList;
begin
  Result := g_ShopItemList[RzPageControlShop.ActivePageIndex];
end;

procedure TFrmShopItem.ButtonDelShopItemClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  ShopItem: pTShopItem;
  ShopItemList: Classes.TList;
begin
  ListItem := GetListView.Selected;
  if ListItem <> nil then begin
    ShopItemList := GetActiveShopList;
    if ShopItemList <> nil then begin
      for I := ShopItemList.Count - 1 downto 0 do begin
        ShopItem := pTShopItem(ShopItemList.Items[I]);
        if ShopItem = pTShopItem(ListItem.SubItems.Objects[0]) then begin
          Dispose(ShopItem);
          ShopItemList.Delete(I);
          Break;
        end;
      end;
    end;
    RefActiveListView();
  end;
end;

procedure TFrmShopItem.ButtonAddShopItemClick(Sender: TObject);
var
  ListView: TListView;
  ListItem: TListItem;
  sItemName: string;
  sPrice: string;
  sMemo1: string;
  sMemo2: string;
  sPicture: string;
  I: Integer;
  ShopItem: pTShopItem;
  nEndCount: Integer;
  ShopItemList: Classes.TList;
  boFind: Boolean;
  sBegin: string;
  StdItem: pTStdItem;
begin
  sItemName := EditShopItemName.Text;
  sMemo1 := Trim(Memo1.Text);
  if Memo2.Lines.Count >= 6 then nEndCount := 6 else nEndCount := Memo2.Lines.Count;
  sMemo2 := '';
  for I := 0 to nEndCount - 1 do begin
    sMemo2 := sMemo2 + Memo2.Lines.Strings[I] + #13;
  end;
  sMemo2 := Copy(sMemo2, 1, Length(sMemo2) - 1);
  sPicture := Trim(EditPicture.Text);
  sPicture := GetValidStr3(sPicture, sBegin, ['-']);
  StdItem := g_UserManage.GetStdItem(sItemName);

  if sItemName = '' then begin
    Application.MessageBox('请选择你要添加的商品！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;

  if StdItem = nil then begin
    Application.MessageBox('此物品不存在！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;

  if sPicture = '' then begin
    Application.MessageBox('请输入商品图片介绍！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if sMemo1 = '' then begin
    Application.MessageBox('请输入简单介绍！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  boFind := False;
  ShopItemList := GetActiveShopList;
  if ShopItemList <> nil then begin
    for I := 0 to ShopItemList.Count - 1 do begin
      ShopItem := pTShopItem(ShopItemList.Items[I]);
      if ShopItem.StdItem.Name = sItemName then begin
        boFind := True;
        Break;
      end;
    end;
  end;
  if boFind then begin
    Application.MessageBox('你要添加的商品已经存在，请选择其他商品！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  New(ShopItem);
  ShopItem.btItemType := RzPageControlShop.ActivePageIndex;
  ShopItem.StdItem := StdItem^;
  ShopItem.StdItem.Price := SpinEditPrice.Value;
  ShopItem.nBeginIdx := Str_ToInt(sBegin, -1);
  ShopItem.nEndIdx := Str_ToInt(sPicture, -1);
  ShopItem.sMemo1 := sMemo1;
  ShopItem.sMemo2 := sMemo2;
  ShopItem.boRandomUpgrade := CheckBoxRandomUpgrade.Checked;
  ShopItem.nAddValueRate := EditAddValueRate.Value;
  ShopItem.boLimitDay := CheckBoxLimitDay.Checked;
  ShopItem.nMaxLimitDay := EditMaxLimitDay.Value;
  ShopItemList := GetActiveShopList;
  if ShopItemList <> nil then begin
    ShopItemList.Add(ShopItem);
    RefActiveListView();
  end;
end;

procedure TFrmShopItem.ListBoxItemListClick(Sender: TObject);
var
  nItemIndex: Integer;
begin
  try
    nItemIndex := ListBoxItemList.ItemIndex;
    EditShopItemName.Text := ListBoxItemList.Items.Strings[nItemIndex];
    ButtonAddShopItem.Enabled := True;
  except
    ButtonAddShopItem.Enabled := False;
  end;
end;

procedure TFrmShopItem.ButtonSaveShopItemListClick(Sender: TObject);
var
  I, II: Integer;
  ListItem: TListItem;
  ShopItem: pTShopItem;
  SaveList: Classes.TStringList;
  sLineText: string;
  sFileName: string;
  sItemName: string;
  sPrice: string;
  sPicture: string;
  sMemo1: string;
  sMemo2: string;

  sRandomUpgrade: string;
  sAddValueRate: string;
  sLimitDay: string;
  sMaxLimitDay: string;

begin
  ButtonSaveShopItemList.Enabled := False;
  sFileName := '.\BuyItemList.txt';
  SaveList := Classes.TStringList.Create();
  SaveList.Add(';引擎插件商铺配置文件');
  SaveList.Add(';物品类型'#9'物品名称'#9'出售价格'#9'图片介绍'#9'介绍'#9'描述'#9'到限时间');

  for I := Low(g_ShopItemList) to High(g_ShopItemList) do begin
    for II := 0 to g_ShopItemList[I].Count - 1 do begin
      ShopItem := pTShopItem(g_ShopItemList[I].Items[II]);
      sItemName := ShopItem.StdItem.Name;
      sPrice := IntToStr(ShopItem.StdItem.Price);
      sPicture := Format('%d-%d', [ShopItem.nBeginIdx, ShopItem.nEndIdx]);
      sMemo1 := ShopItem.sMemo1;
      sMemo2 := ShopItem.sMemo2;
      ChgString(sMemo2, #13, '\');
      sRandomUpgrade := IntToStr(Integer(ShopItem.boRandomUpgrade));
      sAddValueRate := IntToStr(ShopItem.nAddValueRate);
      sLimitDay := IntToStr(Integer(ShopItem.boLimitDay));
      sMaxLimitDay := IntToStr(ShopItem.nMaxLimitDay);

      sLineText := IntToStr(I) + #9 + sItemName + #9 + sPrice + #9 + sPicture + #9 + sMemo1 + #9 +
        sRandomUpgrade + #9 + sAddValueRate + #9 + sLimitDay + #9 + sMaxLimitDay + #9 + sMemo2;
      SaveList.Add(sLineText);
    end;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Application.MessageBox('保存完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonSaveShopItemList.Enabled := True;
end;

procedure TFrmShopItem.ButtonLoadShopItemListClick(Sender: TObject);
begin
  ButtonLoadShopItemList.Enabled := False;
  LoadShopItemList();
  RefLoadShopItemList();
  Application.MessageBox('重新加载商列表完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonLoadShopItemList.Enabled := True;
end;

end.

