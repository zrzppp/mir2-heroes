unit FunctionConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ComCtrls, EngineInterface, Menus, IniFiles;

type
  TFrmFunctionConfig = class(TForm)
    FunctionConfigControl: TPageControl;
    Label14: TLabel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet5: TTabSheet;
    GroupBox52: TGroupBox;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Label128: TLabel;
    SpinEditStartHPRock: TSpinEdit;
    SpinEditRockAddHP: TSpinEdit;
    SpinEditHPRockSpell: TSpinEdit;
    CheckBoxStartHPRock: TCheckBox;
    GroupBox53: TGroupBox;
    Label122: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label123: TLabel;
    Label129: TLabel;
    SpinEditStartMPRock: TSpinEdit;
    SpinEditRockAddMP: TSpinEdit;
    SpinEditMPRockSpell: TSpinEdit;
    CheckBoxStartMPRock: TCheckBox;
    ButtonSuperRockSave: TButton;
    Label1: TLabel;
    EditStartHPRockMsg: TEdit;
    Label2: TLabel;
    EditStartMPRockMsg: TEdit;
    GroupBox21: TGroupBox;
    ListBoxitemList: TListBox;
    ButtonDisallowDel: TButton;
    ButtonDisallowSave: TButton;
    GroupBox22: TGroupBox;
    ListViewMsgFilter: TListView;
    GroupBox23: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    EditFilterMsg: TEdit;
    EditNewMsg: TEdit;
    ButtonMsgFilterAdd: TButton;
    ButtonMsgFilterDel: TButton;
    ButtonMsgFilterSave: TButton;
    ButtonMsgFilterChg: TButton;
    GroupBox5: TGroupBox;
    ListBoxUserCommand: TListBox;
    Label3: TLabel;
    EditCommandName: TEdit;
    ButtonUserCommandAdd: TButton;
    Label4: TLabel;
    SpinEditCommandIdx: TSpinEdit;
    ButtonUserCommandDel: TButton;
    ButtonUserCommandChg: TButton;
    GroupBox1: TGroupBox;
    ListViewDisallow: TListView;
    ButtonUserCommandSave: TButton;
    ButtonLoadCheckItemList: TButton;
    ButtonLoadUserCommandList: TButton;
    ButtonLoadMsgFilterList: TButton;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    SpinEditRockAddHPMP: TSpinEdit;
    CheckBoxStartHPMPRock: TCheckBox;
    EditStartHPMPRockMsg: TEdit;
    SpinEditHPMPRockSpell: TSpinEdit;
    Label5: TLabel;
    Label8: TLabel;
    PopupMenu_Disallow: TPopupMenu;
    PopupMenu_Disallow_ItemName: TMenuItem;
    PopupMenu_Disallow_CanDrop: TMenuItem;
    PopupMenu_Disallow_CanDeal: TMenuItem;
    PopupMenu_Disallow_CanStorage: TMenuItem;
    PopupMenu_Disallow_CanRepair: TMenuItem;
    PopupMenu_Disallow_CanUpgrade: TMenuItem;
    PopupMenu_Disallow_CanSell: TMenuItem;
    PopupMenu_Disallow_CanScatter: TMenuItem;
    PopupMenu_Disallow_CanDieScatter: TMenuItem;
    PopupMenu_Disallow_CanOffLineTake: TMenuItem;
    N1: TMenuItem;
    CheckBoxGotoLabel: TCheckBox;
    procedure CheckBoxStartHPRockClick(Sender: TObject);
    procedure CheckBoxStartMPRockClick(Sender: TObject);
    procedure EditStartHPRockMsgChange(Sender: TObject);
    procedure EditStartMPRockMsgChange(Sender: TObject);
    procedure ButtonSuperRockSaveClick(Sender: TObject);
    procedure SpinEditStartHPRockChange(Sender: TObject);
    procedure SpinEditHPRockSpellChange(Sender: TObject);
    procedure SpinEditRockAddHPChange(Sender: TObject);
    procedure SpinEditMPRockSpellChange(Sender: TObject);
    procedure SpinEditRockAddMPChange(Sender: TObject);
    procedure SpinEditStartMPRockChange(Sender: TObject);
    procedure ListBoxUserCommandClick(Sender: TObject);
    procedure ButtonUserCommandAddClick(Sender: TObject);
    procedure ButtonUserCommandDelClick(Sender: TObject);
    procedure ButtonUserCommandChgClick(Sender: TObject);
    procedure ButtonUserCommandSaveClick(Sender: TObject);
    procedure ButtonLoadUserCommandListClick(Sender: TObject);
    procedure ListBoxitemListDblClick(Sender: TObject);
    procedure ListViewDisallowClick(Sender: TObject);
    procedure ButtonDisallowSaveClick(Sender: TObject);
    procedure ButtonLoadCheckItemListClick(Sender: TObject);
    procedure ListViewMsgFilterClick(Sender: TObject);
    procedure ButtonLoadMsgFilterListClick(Sender: TObject);
    procedure ButtonMsgFilterSaveClick(Sender: TObject);
    procedure ButtonMsgFilterAddClick(Sender: TObject);
    procedure ButtonMsgFilterChgClick(Sender: TObject);
    procedure ButtonMsgFilterDelClick(Sender: TObject);
    procedure SpinEditHPMPRockSpellChange(Sender: TObject);
    procedure SpinEditRockAddHPMPChange(Sender: TObject);
    procedure CheckBoxStartHPMPRockClick(Sender: TObject);
    procedure EditStartHPMPRockMsgChange(Sender: TObject);
    procedure PopupMenu_Disallow_CanDropClick(Sender: TObject);
    procedure ButtonDisallowDelClick(Sender: TObject);
  private
    { Private declarations }
    procedure uModValue;
    procedure ModValue;
    procedure RefSuperRock();
    procedure RefLoadMsgFilterList();
    procedure RefLoadDisallowStdItems();
    procedure RefLoadAttackInfo();
    function InCommandListOfName(sCommandName: string): Boolean;
    function InCommandListOfIndex(nIndex: Integer): Boolean;
    function InListBoxitemList(sItemName: string): Boolean;
    function InFilterMsgList(sFilterMsg: string): Boolean;
  public
    { Public declarations }
    procedure Open();
  end;
procedure InitUserConfig();
var
  FrmFunctionConfig: TFrmFunctionConfig;
  boModValued, boOpened: Boolean;
implementation
uses
  PlayUserCmd, PlayUser, PlugShare;
{$R *.dfm}

procedure TFrmFunctionConfig.ButtonSuperRockSaveClick(Sender: TObject);
var
  Config: TIniFile;
  sFileName: string;
begin
  sFileName := '.\zPlugOfEngine.ini';
  Config := TIniFile.Create(sFileName);
  if Config <> nil then begin
    Config.WriteInteger(PlugClass, 'StartHPRock', nStartHPRock);
    Config.WriteInteger(PlugClass, 'StartMPRock', nStartMPRock);
    Config.WriteInteger(PlugClass, 'HPRockSpell', nHPRockSpell);
    Config.WriteInteger(PlugClass, 'MPRockSpell', nMPRockSpell);
    Config.WriteInteger(PlugClass, 'HPMPRockSpell', nHPMPRockSpell);
    Config.WriteInteger(PlugClass, 'RockAddHP', nRockAddHP);
    Config.WriteInteger(PlugClass, 'RockAddMP', nRockAddMP);
    Config.WriteInteger(PlugClass, 'RockAddHPMP', nRockAddHPMP);
    Config.WriteBool(PlugClass, 'StartHPRockHint', boStartHPRockMsg);
    Config.WriteBool(PlugClass, 'StartMPRockHint', boStartMPRockMsg);
    Config.WriteBool(PlugClass, 'StartHPMPRockHint', boStartHPMPRockMsg);
    Config.WriteString(PlugClass, 'StartHPRockMsg', sStartHPRockMsg);
    Config.WriteString(PlugClass, 'StartMPRockMsg', sStartMPRockMsg);
    Config.WriteString(PlugClass, 'StartHPMPRockMsg', sStartHPMPRockMsg);
    Config.Free;
  end;
  uModValue();
end;

procedure InitUserConfig();
var
  Config: TIniFile;
  sFileName: string;
  nLoadInteger: Integer;
  LoadString: string;
begin
  sFileName := '.\zPlugOfEngine.ini';
  Config := TIniFile.Create(sFileName);
  if Config <> nil then begin
    nLoadInteger := Config.ReadInteger(PlugClass, 'StartHPRock', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'StartHPRock', nStartHPRock)
    else nStartHPRock := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'StartMPRock', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'StartMPRock', nStartMPRock)
    else nStartMPRock := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'HPRockSpell', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'HPRockSpell', nHPRockSpell)
    else nHPRockSpell := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'MPRockSpell', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'MPRockSpell', nMPRockSpell)
    else nMPRockSpell := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'HPMPRockSpell', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'HPMPRockSpell', nHPMPRockSpell)
    else nHPMPRockSpell := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'RockAddHP', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'RockAddHP', nRockAddHP)
    else nRockAddHP := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'RockAddMP', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'RockAddMP', nRockAddMP)
    else nRockAddMP := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'RockAddHPMP', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'RockAddHPMP', nRockAddHPMP)
    else nRockAddHPMP := nLoadInteger;

    if Config.ReadInteger(PlugClass, 'StartHPRockHint', -1) < 0 then
      Config.WriteBool(PlugClass, 'StartHPRockHint', boStartHPRockMsg);
    boStartHPRockMsg := Config.ReadBool(PlugClass, 'StartHPRockHint', boStartHPRockMsg);

    if Config.ReadInteger(PlugClass, 'StartMPRockHint', -1) < 0 then
      Config.WriteBool(PlugClass, 'StartMPRockHint', boStartMPRockMsg);
    boStartMPRockMsg := Config.ReadBool(PlugClass, 'StartMPRockHint', boStartMPRockMsg);

    if Config.ReadInteger(PlugClass, 'StartHPMPRockHint', -1) < 0 then
      Config.WriteBool(PlugClass, 'StartHPMPRockHint', boStartHPMPRockMsg);
    boStartHPMPRockMsg := Config.ReadBool(PlugClass, 'StartHPMPRockHint', boStartHPMPRockMsg);

    LoadString := Config.ReadString(PlugClass, 'StartHPRockMsg', '');
    if LoadString = '' then
      Config.WriteString(PlugClass, 'StartHPRockMsg', sStartHPRockMsg)
    else sStartHPRockMsg := LoadString;

    LoadString := Config.ReadString(PlugClass, 'StartMPRockMsg', '');
    if LoadString = '' then
      Config.WriteString(PlugClass, 'StartMPRockMsg', sStartMPRockMsg)
    else sStartMPRockMsg := LoadString;

    LoadString := Config.ReadString(PlugClass, 'StartHPMPRockMsg', '');
    if LoadString = '' then
      Config.WriteString(PlugClass, 'StartHPMPRockMsg', sStartHPMPRockMsg)
    else sStartHPMPRockMsg := LoadString;

    Config.Free;
  end;
end;

procedure TFrmFunctionConfig.Open();
var
  I: Integer;
  StdItem: pTStdItem;
  List: Classes.TList;
begin
  boOpened := False;
  uModValue();
  ListBoxitemList.Items.Clear;
  ListBoxUserCommand.Items.Clear;

  List := g_UserManage.m_StdItemList;
  for I := 0 to g_UserManage.EngineOut.List_Count(List) - 1 do begin
    StdItem := g_UserManage.EngineOut.List_Get(List, I);
    ListBoxitemList.Items.AddObject(StdItem.Name, TObject(StdItem));
  end;

  RefSuperRock();
  RefLoadMsgFilterList();
  RefLoadDisallowStdItems();
  RefLoadAttackInfo();
  ListBoxUserCommand.Items.AddStrings(g_UserCmdList);
  boOpened := True;
  FunctionConfigControl.ActivePageIndex := 0;
  ShowModal;
end;

procedure TFrmFunctionConfig.ModValue;
begin
  boModValued := True;
  ButtonSuperRockSave.Enabled := True;
  ButtonUserCommandSave.Enabled := True;
  ButtonDisallowSave.Enabled := True;
  ButtonMsgFilterSave.Enabled := True;
end;

procedure TFrmFunctionConfig.uModValue;
begin
  boModValued := False;
  ButtonSuperRockSave.Enabled := False;
  ButtonUserCommandDel.Enabled := False;
  ButtonUserCommandChg.Enabled := False;
  ButtonDisallowDel.Enabled := False;
  ButtonMsgFilterDel.Enabled := False;
  ButtonMsgFilterChg.Enabled := False;
end;

procedure TFrmFunctionConfig.RefSuperRock();
begin
  SpinEditStartHPRock.Value := nStartHPRock;
  SpinEditStartMPRock.Value := nStartMPRock;
  SpinEditHPRockSpell.Value := nHPRockSpell;
  SpinEditMPRockSpell.Value := nMPRockSpell;
  SpinEditHPMPRockSpell.Value := nHPMPRockSpell;
  SpinEditRockAddHP.Value := nRockAddHP;
  SpinEditRockAddMP.Value := nRockAddMP;
  SpinEditRockAddHPMP.Value := nRockAddHPMP;
  CheckBoxStartHPRock.Checked := boStartHPRockMsg;
  CheckBoxStartMPRock.Checked := boStartMPRockMsg;
  CheckBoxStartHPMPRock.Checked := boStartHPMPRockMsg;
  EditStartHPRockMsg.Text := sStartHPRockMsg;
  EditStartMPRockMsg.Text := sStartMPRockMsg;
  EditStartHPMPRockMsg.Text := sStartHPMPRockMsg;
end;

procedure TFrmFunctionConfig.CheckBoxStartHPRockClick(Sender: TObject);
begin
  if not boOpened then Exit;
  boStartHPRockMsg := CheckBoxStartHPRock.Checked;
  ButtonSuperRockSave.Enabled := True;
  if boStartHPRockMsg then
    EditStartHPRockMsg.Enabled := True
  else EditStartHPRockMsg.Enabled := False;
end;

procedure TFrmFunctionConfig.CheckBoxStartMPRockClick(Sender: TObject);
begin
  if not boOpened then Exit;
  boStartMPRockMsg := CheckBoxStartMPRock.Checked;
  ButtonSuperRockSave.Enabled := True;
  if boStartMPRockMsg then
    EditStartMPRockMsg.Enabled := True
  else EditStartMPRockMsg.Enabled := False;
end;

procedure TFrmFunctionConfig.EditStartHPRockMsgChange(Sender: TObject);
begin
  if not boOpened then Exit;
  sStartHPRockMsg := Trim(EditStartHPRockMsg.Text);
  ButtonSuperRockSave.Enabled := True;
end;

procedure TFrmFunctionConfig.EditStartMPRockMsgChange(Sender: TObject);
begin
  if not boOpened then Exit;
  sStartMPRockMsg := Trim(EditStartMPRockMsg.Text);
  ButtonSuperRockSave.Enabled := True;
end;

procedure TFrmFunctionConfig.SpinEditStartHPRockChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nStartHPRock := SpinEditStartHPRock.Value;
  ButtonSuperRockSave.Enabled := True;
end;

procedure TFrmFunctionConfig.SpinEditHPRockSpellChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nHPRockSpell := SpinEditHPRockSpell.Value;
  ButtonSuperRockSave.Enabled := True;
end;

procedure TFrmFunctionConfig.SpinEditRockAddHPChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nRockAddHP := SpinEditRockAddHP.Value;
  ButtonSuperRockSave.Enabled := True;
end;

procedure TFrmFunctionConfig.SpinEditMPRockSpellChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nMPRockSpell := SpinEditMPRockSpell.Value;
  ButtonSuperRockSave.Enabled := True;
end;

procedure TFrmFunctionConfig.SpinEditRockAddMPChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nRockAddMP := SpinEditRockAddMP.Value;
  ButtonSuperRockSave.Enabled := True;
end;

procedure TFrmFunctionConfig.SpinEditStartMPRockChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nStartMPRock := SpinEditStartMPRock.Value;
  ButtonSuperRockSave.Enabled := True;
end;

procedure TFrmFunctionConfig.ListBoxUserCommandClick(Sender: TObject);
begin
  try
    EditCommandName.Text := ListBoxUserCommand.Items.Strings[ListBoxUserCommand.ItemIndex];
    SpinEditCommandIdx.Value := Integer(ListBoxUserCommand.Items.Objects[ListBoxUserCommand.ItemIndex]);
    ButtonUserCommandDel.Enabled := True;
    ButtonUserCommandChg.Enabled := True;
  except
    EditCommandName.Text := '';
    SpinEditCommandIdx.Value := 0;
    ButtonUserCommandDel.Enabled := False;
    ButtonUserCommandChg.Enabled := False;
  end;
end;

function TFrmFunctionConfig.InCommandListOfIndex(nIndex: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to ListBoxUserCommand.Items.Count - 1 do begin
    if nIndex = Integer(ListBoxUserCommand.Items.Objects[I]) then begin
      Result := True;
      Break;
    end;
  end;
end;

function TFrmFunctionConfig.InCommandListOfName(sCommandName: string): Boolean;
var
  I, nCount: Integer;
begin
  Result := False;
  for I := 0 to ListBoxUserCommand.Items.Count - 1 do begin
    if CompareText(sCommandName, ListBoxUserCommand.Items.Strings[I]) = 0 then begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TFrmFunctionConfig.ButtonUserCommandAddClick(Sender: TObject);
var
  sCommandName: string;
  nCommandIndex: Integer;
begin
  sCommandName := Trim(EditCommandName.Text);
  nCommandIndex := SpinEditCommandIdx.Value;
  if sCommandName = '' then begin
    Application.MessageBox('请输入命令！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InCommandListOfName(sCommandName) then begin
    Application.MessageBox('输入的命令已经存在，请选择其他命令！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InCommandListOfIndex(nCommandIndex) then begin
    Application.MessageBox('输入的命令编号已经存在，请选择其他命令编号！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  ListBoxUserCommand.Items.AddObject(sCommandName, TObject(nCommandIndex));
end;

procedure TFrmFunctionConfig.ButtonUserCommandDelClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认删除此命令？', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    try
      ListBoxUserCommand.DeleteSelected;
    except
    end;
  end;
end;

procedure TFrmFunctionConfig.ButtonUserCommandChgClick(Sender: TObject);
var
  sCommandName: string;
  nCommandIndex: Integer;
  I, nItemIndex: Integer;
begin
  sCommandName := Trim(EditCommandName.Text);
  nCommandIndex := SpinEditCommandIdx.Value;
  if sCommandName = '' then begin
    Application.MessageBox('请输入命令！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InCommandListOfName(sCommandName) then begin
    Application.MessageBox('你要修改的命令已经存在，请选择其他命令！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InCommandListOfIndex(nCommandIndex) then begin
    Application.MessageBox('你要修改的命令编号已经存在，请选择其他命令编号！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  nItemIndex := ListBoxUserCommand.ItemIndex;
  try
    ListBoxUserCommand.Items.Strings[nItemIndex] := sCommandName;
    ListBoxUserCommand.Items.Objects[nItemIndex] := TObject(nCommandIndex);
    Application.MessageBox('修改完成！！！', '提示信息', MB_ICONQUESTION);
  except
    Application.MessageBox('修改失败！！！', '提示信息', MB_ICONQUESTION);
  end;
end;

procedure TFrmFunctionConfig.ButtonUserCommandSaveClick(Sender: TObject);
var
  sFileName: string;
  I: Integer;
  sCommandName: string;
  nCommandIndex: Integer;
  SaveList: Classes.TStringList;
begin
  ButtonUserCommandSave.Enabled := False;
  sFileName := '.\UserCmd.txt';
  SaveList := Classes.TStringList.Create;
  SaveList.Add(';引擎插件配置文件');
  SaveList.Add(';命令名称'#9'对应编号');
  for I := 0 to ListBoxUserCommand.Items.Count - 1 do begin
    sCommandName := ListBoxUserCommand.Items.Strings[I];
    nCommandIndex := Integer(ListBoxUserCommand.Items.Objects[I]);
    SaveList.Add(sCommandName + #9 + IntToStr(nCommandIndex));
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Application.MessageBox('保存完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonUserCommandSave.Enabled := True;
end;

procedure TFrmFunctionConfig.ButtonLoadUserCommandListClick(
  Sender: TObject);
begin
  ButtonLoadUserCommandList.Enabled := False;
  LoadUserCmdList();
  ListBoxUserCommand.Items.Clear;
  ListBoxUserCommand.Items.AddStrings(g_UserCmdList);
  Application.MessageBox('重新加载自定义命令列表完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonLoadUserCommandList.Enabled := True;
end;

function TFrmFunctionConfig.InListBoxitemList(sItemName: string): Boolean;
var
  I: Integer;
  ListItem: TListItem;
begin
  Result := False;
  ListViewDisallow.Items.BeginUpdate;
  try
    for I := 0 to ListViewDisallow.Items.Count - 1 do begin
      ListItem := ListViewDisallow.Items.Item[I];
      if CompareText(sItemName, ListItem.Caption) = 0 then begin
        Result := True;
        Break;
      end;
    end;
  finally
    ListViewDisallow.Items.EndUpdate;
  end;
end;

procedure TFrmFunctionConfig.ListBoxitemListDblClick(Sender: TObject);
var
  ListItem: TListItem;
  sItemName: string;
  CheckItem: pTCheckItem;
  I: Integer;
begin
  try
    sItemName := ListBoxitemList.Items.Strings[ListBoxitemList.ItemIndex];
  except
    sItemName := '';
  end;
  if (sItemName <> '') then begin
    if InListBoxitemList(sItemName) then begin
      Application.MessageBox('你要选择的物品已经在禁止物品列表中，请选择其他物品！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;

    New(CheckItem);
    CheckItem.szItemName := sItemName;
    CheckItem.boCanDrop := False;
    CheckItem.boCanDeal := False;
    CheckItem.boCanStorage := False;
    CheckItem.boCanRepair := False;

    CheckItem.boCanUpgrade := False;
    CheckItem.boCanSell := False;
    CheckItem.boCanNotScatter := False;
    CheckItem.boCanDieScatter := False;
    CheckItem.boCanOffLineTake := False;
    g_CheckItemList.Add(CheckItem);
    RefLoadDisallowStdItems();
  end;
end;

procedure TFrmFunctionConfig.ListViewDisallowClick(Sender: TObject);
var
  ListItem: TListItem;
  CheckItem: pTCheckItem;
begin
  ListItem := ListViewDisallow.Selected;
  if ListItem <> nil then begin
    ListViewDisallow.PopupMenu := PopupMenu_Disallow;
    CheckItem := pTCheckItem(ListItem.SubItems.Objects[0]);
    PopupMenu_Disallow_ItemName.Caption := '物品名称:' + CheckItem.szItemName;
    PopupMenu_Disallow_CanDrop.Checked := CheckItem.boCanDrop;
    PopupMenu_Disallow_CanDeal.Checked := CheckItem.boCanDeal;
    PopupMenu_Disallow_CanStorage.Checked := CheckItem.boCanStorage;
    PopupMenu_Disallow_CanRepair.Checked := CheckItem.boCanRepair;
    PopupMenu_Disallow_CanUpgrade.Checked := CheckItem.boCanUpgrade;
    PopupMenu_Disallow_CanSell.Checked := CheckItem.boCanSell;
    PopupMenu_Disallow_CanScatter.Checked := CheckItem.boCanNotScatter;
    PopupMenu_Disallow_CanDieScatter.Checked := CheckItem.boCanDieScatter;
    PopupMenu_Disallow_CanOffLineTake.Checked := CheckItem.boCanOffLineTake;
    ButtonDisallowDel.Enabled := True;
  end else begin
    ListViewDisallow.PopupMenu := nil;
    ButtonDisallowDel.Enabled := False;
  end;
end;

procedure TFrmFunctionConfig.RefLoadDisallowStdItems();
var
  I: Integer;
  ListItem: TListItem;
  CheckItem: pTCheckItem;
begin
  ListViewDisallow.Clear;
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := pTCheckItem(g_CheckItemList.Items[I]);
    ListViewDisallow.Items.BeginUpdate;
    try
      ListItem := ListViewDisallow.Items.Add;
      ListItem.Caption := CheckItem.szItemName;
      ListItem.SubItems.AddObject(GetCanStr(CheckItem.boCanDrop), TObject(CheckItem));
      ListItem.SubItems.Add(GetCanStr(CheckItem.boCanDeal));
      ListItem.SubItems.Add(GetCanStr(CheckItem.boCanStorage));
      ListItem.SubItems.Add(GetCanStr(CheckItem.boCanRepair));

      ListItem.SubItems.Add(GetCanStr(CheckItem.boCanUpgrade));
      ListItem.SubItems.Add(GetCanStr(CheckItem.boCanSell));
      ListItem.SubItems.Add(GetCanStr(CheckItem.boCanNotScatter));
      ListItem.SubItems.Add(GetCanStr(CheckItem.boCanDieScatter));
      ListItem.SubItems.Add(GetCanStr(CheckItem.boCanOffLineTake));
    finally
      ListViewDisallow.Items.EndUpdate;
    end;
  end;
end;

procedure TFrmFunctionConfig.ButtonDisallowSaveClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: Classes.TStringList;
  sFileName: string;
  sLineText: string;
  CheckItem: pTCheckItem;
begin
  sFileName := '.\CheckItemList.txt';
  SaveList := Classes.TStringList.Create;
  SaveList.Add(';引擎插件禁止物品配置文件');
  SaveList.Add(';物品名称'#9'扔'#9'交易'#9'存'#9'修'#9'升级'#9'出售'#9'禁止爆出'#9'死亡必爆'#9'死亡消失');
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := pTCheckItem(g_CheckItemList.Items[I]);
    sLineText := CheckItem.szItemName + #9 + IntToStr(Integer(CheckItem.boCanDrop)) + #9 +
      IntToStr(Integer(CheckItem.boCanDeal)) + #9 + IntToStr(Integer(CheckItem.boCanStorage)) + #9 +
      IntToStr(Integer(CheckItem.boCanRepair)) + #9 + IntToStr(Integer(CheckItem.boCanUpgrade)) + #9 +
      IntToStr(Integer(CheckItem.boCanSell)) + #9 + IntToStr(Integer(CheckItem.boCanNotScatter)) + #9 +
      IntToStr(Integer(CheckItem.boCanDieScatter)) + #9 + IntToStr(Integer(CheckItem.boCanOffLineTake));
    SaveList.Add(sLineText);
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  ButtonDisallowSave.Enabled := False;
  Application.MessageBox('保存完成！！！', '提示信息', MB_ICONQUESTION);
end;

procedure TFrmFunctionConfig.ButtonLoadCheckItemListClick(Sender: TObject);
begin
  ButtonLoadCheckItemList.Enabled := False;
  LoadCheckItemList();
  RefLoadDisallowStdItems();
  Application.MessageBox('重新加载禁止物品配置完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonLoadCheckItemList.Enabled := True;
end;

procedure TFrmFunctionConfig.RefLoadMsgFilterList();
var
  I: Integer;
  ListItem: TListItem;
  FilterMsg: pTFilterMsg;
begin
  ListViewMsgFilter.Items.BeginUpdate;
  ListViewMsgFilter.Items.Clear;
  try
    for I := 0 to g_MsgFilterList.Count - 1 do begin
      ListItem := ListViewMsgFilter.Items.Add;
      FilterMsg := g_MsgFilterList.Items[I];
      ListItem.Caption := FilterMsg.sFilterMsg;
      ListItem.SubItems.AddObject(FilterMsg.sNewMsg, TObject(FilterMsg));
      ListItem.SubItems.Add(BoolToStr(FilterMsg.boGotoLabel));
    end;
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
end;

procedure TFrmFunctionConfig.ListViewMsgFilterClick(Sender: TObject);
var
  ListItem: TListItem;
  nItemIndex: Integer;
  FilterMsg: pTFilterMsg;
begin
  try
    nItemIndex := ListViewMsgFilter.ItemIndex;
    if nItemIndex >= 0 then begin
      ListItem := ListViewMsgFilter.Items.Item[nItemIndex];
      FilterMsg := pTFilterMsg(ListItem.SubItems.Objects[0]);
      EditFilterMsg.Text := FilterMsg.sFilterMsg;
      EditNewMsg.Text := FilterMsg.sNewMsg;
      CheckBoxGotoLabel.Checked := FilterMsg.boGotoLabel;
      ButtonMsgFilterDel.Enabled := True;
      ButtonMsgFilterChg.Enabled := True;
    end else begin
      EditFilterMsg.Text := '';
      EditNewMsg.Text := '';
      ButtonMsgFilterDel.Enabled := False;
      ButtonMsgFilterChg.Enabled := False;
    end;
  except
    EditFilterMsg.Text := '';
    EditNewMsg.Text := '';
    ButtonMsgFilterDel.Enabled := False;
    ButtonMsgFilterChg.Enabled := False;
  end;
end;

procedure TFrmFunctionConfig.ButtonLoadMsgFilterListClick(Sender: TObject);
begin
  ButtonLoadMsgFilterList.Enabled := False;
  LoadMsgFilterList();
  RefLoadMsgFilterList();
  Application.MessageBox('重新加载消息过滤列表完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonLoadMsgFilterList.Enabled := True;
end;

procedure TFrmFunctionConfig.ButtonMsgFilterSaveClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: Classes.TStringList;
  sFilterMsg: string;
  sNewMsg: string;
  sFileName: string;
  sGoto: string;
  FilterMsg: pTFilterMsg;
begin
  ButtonMsgFilterSave.Enabled := False;
  sFileName := '.\MsgFilterList.txt';
  SaveList := Classes.TStringList.Create;
  SaveList.Add(';引擎插件消息过滤配置文件');
  SaveList.Add(';过滤消息'#9'替换消息'#9'脚本触发');
  for I := 0 to g_MsgFilterList.Count - 1 do begin
    FilterMsg := g_MsgFilterList.Items[I];
    SaveList.Add(IntToStr(Integer(FilterMsg.boGotoLabel)) + #9 + FilterMsg.sFilterMsg + #9 + FilterMsg.sNewMsg);
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Application.MessageBox('保存完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonMsgFilterSave.Enabled := True;
end;

function TFrmFunctionConfig.InFilterMsgList(sFilterMsg: string): Boolean;
var
  I: Integer;
  FilterMsg: pTFilterMsg;
begin
  Result := False;
  for I := 0 to g_MsgFilterList.Count - 1 do begin
    FilterMsg := g_MsgFilterList.Items[I];
    if CompareText(sFilterMsg, FilterMsg.sFilterMsg) = 0 then begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TFrmFunctionConfig.ButtonMsgFilterAddClick(Sender: TObject);
var
  sFilterMsg: string;
  sNewMsg: string;
  FilterMsg: pTFilterMsg;
begin
  sFilterMsg := Trim(EditFilterMsg.Text);
  sNewMsg := Trim(EditNewMsg.Text);
  if sFilterMsg = '' then begin
    Application.MessageBox('请输入过滤消息！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InFilterMsgList(sFilterMsg) then begin
    Application.MessageBox('你输入的过滤消息已经存在！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  New(FilterMsg);
  FilterMsg.sFilterMsg := sFilterMsg;
  FilterMsg.sNewMsg := sNewMsg;
  FilterMsg.boGotoLabel := CheckBoxGotoLabel.Checked;
  g_MsgFilterList.Add(FilterMsg);
  RefLoadMsgFilterList();
end;

procedure TFrmFunctionConfig.ButtonMsgFilterChgClick(Sender: TObject);
var
  I: Integer;
  sFilterMsg: string;
  sNewMsg: string;
  FilterMsg: pTFilterMsg;
begin
  sFilterMsg := Trim(EditFilterMsg.Text);
  sNewMsg := Trim(EditNewMsg.Text);
  if sFilterMsg = '' then begin
    Application.MessageBox('请输入过滤消息！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
 { if InFilterMsgList(sFilterMsg) then begin
    Application.MessageBox('你输入的过滤消息已经存在！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;}
  for I := 0 to g_MsgFilterList.Count - 1 do begin
    FilterMsg := g_MsgFilterList.Items[I];
    if CompareText(sFilterMsg, FilterMsg.sFilterMsg) = 0 then begin
      FilterMsg.sFilterMsg := sFilterMsg;
      FilterMsg.sNewMsg := sNewMsg;
      FilterMsg.boGotoLabel := CheckBoxGotoLabel.Checked;
      RefLoadMsgFilterList();
      break;
    end;
  end;
end;

procedure TFrmFunctionConfig.ButtonMsgFilterDelClick(Sender: TObject);
var
  I: Integer;
  sFilterMsg: string;
  FilterMsg: pTFilterMsg;
begin
  sFilterMsg := Trim(EditFilterMsg.Text);
  for I := 0 to g_MsgFilterList.Count - 1 do begin
    FilterMsg := g_MsgFilterList.Items[I];
    if CompareText(sFilterMsg, FilterMsg.sFilterMsg) = 0 then begin
      Dispose(FilterMsg);
      g_MsgFilterList.Delete(I);
      break;
    end;
  end;
  RefLoadMsgFilterList();
end;

procedure TFrmFunctionConfig.RefLoadAttackInfo();
begin

end;

procedure TFrmFunctionConfig.SpinEditHPMPRockSpellChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nHPMPRockSpell := SpinEditHPMPRockSpell.Value;
  ButtonSuperRockSave.Enabled := True;
end;

procedure TFrmFunctionConfig.SpinEditRockAddHPMPChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nRockAddHPMP := SpinEditRockAddHPMP.Value;
  ButtonSuperRockSave.Enabled := True;
end;

procedure TFrmFunctionConfig.CheckBoxStartHPMPRockClick(Sender: TObject);
begin
  if not boOpened then Exit;
  boStartHPMPRockMsg := CheckBoxStartHPMPRock.Checked;
  ButtonSuperRockSave.Enabled := True;
  if boStartHPMPRockMsg then
    EditStartHPMPRockMsg.Enabled := True
  else EditStartHPMPRockMsg.Enabled := False;
end;

procedure TFrmFunctionConfig.EditStartHPMPRockMsgChange(Sender: TObject);
begin
  if not boOpened then Exit;
  sStartHPMPRockMsg := Trim(EditStartHPMPRockMsg.Text);
  ButtonSuperRockSave.Enabled := True;
end;

procedure TFrmFunctionConfig.PopupMenu_Disallow_CanDropClick(
  Sender: TObject);
var
  ListItem: TListItem;
  CheckItem: pTCheckItem;
  MenuItem: TMenuItem;
begin
  ListItem := ListViewDisallow.Selected;
  if ListItem <> nil then begin
    MenuItem := TMenuItem(Sender);
    MenuItem.Checked := not MenuItem.Checked;

    CheckItem := pTCheckItem(ListItem.SubItems.Objects[0]);

    CheckItem.boCanDrop := PopupMenu_Disallow_CanDrop.Checked;
    CheckItem.boCanDeal := PopupMenu_Disallow_CanDeal.Checked;
    CheckItem.boCanStorage := PopupMenu_Disallow_CanStorage.Checked;
    CheckItem.boCanRepair := PopupMenu_Disallow_CanRepair.Checked;
    CheckItem.boCanUpgrade := PopupMenu_Disallow_CanUpgrade.Checked;
    CheckItem.boCanSell := PopupMenu_Disallow_CanSell.Checked;
    CheckItem.boCanNotScatter := PopupMenu_Disallow_CanScatter.Checked;
    CheckItem.boCanDieScatter := PopupMenu_Disallow_CanDieScatter.Checked;
    CheckItem.boCanOffLineTake := PopupMenu_Disallow_CanOffLineTake.Checked;

    ListItem.SubItems.Strings[0] := GetCanStr(CheckItem.boCanDrop);
    ListItem.SubItems.Strings[1] := GetCanStr(CheckItem.boCanDeal);
    ListItem.SubItems.Strings[2] := GetCanStr(CheckItem.boCanStorage);
    ListItem.SubItems.Strings[3] := GetCanStr(CheckItem.boCanRepair);

    ListItem.SubItems.Strings[4] := GetCanStr(CheckItem.boCanUpgrade);
    ListItem.SubItems.Strings[5] := GetCanStr(CheckItem.boCanSell);
    ListItem.SubItems.Strings[6] := GetCanStr(CheckItem.boCanNotScatter);
    ListItem.SubItems.Strings[7] := GetCanStr(CheckItem.boCanDieScatter);
    ListItem.SubItems.Strings[8] := GetCanStr(CheckItem.boCanOffLineTake);

    ButtonDisallowSave.Enabled := True;
  end;
end;

procedure TFrmFunctionConfig.ButtonDisallowDelClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  CheckItem: pTCheckItem;
begin
  ListItem := ListViewDisallow.Selected;
  if ListItem <> nil then begin
    CheckItem := pTCheckItem(ListItem.SubItems.Objects[0]);
    for I := g_CheckItemList.Count - 1 downto 0 do begin
      if g_CheckItemList.Items[I] = CheckItem then begin
        Dispose(pTCheckItem(g_CheckItemList.Items[I]));
        g_CheckItemList.Delete(I);
        RefLoadDisallowStdItems();
        ButtonDisallowDel.Enabled := False;
        Break;
      end;
    end;
  end;
end;

end.

