unit ConfigMerchant;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ObjNpc, ObjRobot, Envir, Menus, ComCtrls, ExtCtrls, Grobal2;

type
  TfrmConfigMerchant = class(TForm)
    PanelStatus: TPanel;
    ListView: TListView;
    PopupMenu: TPopupMenu;
    PopupMenu_Ref: TMenuItem;
    PopupMenu_AutoRef: TMenuItem;
    PopupMenu_: TMenuItem;
    PopupMenu_Load: TMenuItem;
    PopupMenu_Clear: TMenuItem;
    PopupMenu_Open: TMenuItem;
    procedure PopupMenu_RefClick(Sender: TObject);
    procedure PopupMenu_LoadClick(Sender: TObject);
    procedure PopupMenu_ClearClick(Sender: TObject);
    procedure PopupMenu_OpenClick(Sender: TObject);
    procedure ListViewClick(Sender: TObject);
    procedure ListViewDblClick(Sender: TObject);
  private
    boOpened: Boolean;
    boModValued: Boolean;
    procedure RefListViewSession;
    { Private declarations }
  public
    procedure Open(Envir: TEnvirnoment);
    { Public declarations }
  end;

var
  frmConfigMerchant: TfrmConfigMerchant;
  SelEnvirnoment: TEnvirnoment;
implementation
uses HUtil32, UsrEngn, M2Share;
{$R *.dfm}

procedure TfrmConfigMerchant.RefListViewSession;
var
  I, n01: Integer;
  Merchant: TMerchant;
  ListItem: TListItem;
begin
  PanelStatus.Caption := '正在取得数据...';
  ListView.Visible := False;
  ListView.Items.Clear;
  n01 := 0;

  UserEngine.m_MerchantList.Lock;
  try
    for I := 0 to UserEngine.m_MerchantList.Count - 1 do begin
      Merchant := TMerchant(UserEngine.m_MerchantList.Items[I]);
      if Merchant.m_PEnvir <> SelEnvirnoment then Continue;
      Inc(n01);
      ListItem := ListView.Items.Add;
      ListItem.Caption := IntToStr(n01);
      ListItem.SubItems.AddObject(Merchant.m_sCharName, Merchant);
      //ListItem.SubItems.Add(Merchant.m_sMapName);
      ListItem.SubItems.Add(IntToStr(Merchant.m_nCurrX) + ':' + IntToStr(Merchant.m_nCurrY));
      ListItem.SubItems.Add('是');
      ListItem.SubItems.Add('否');
      ListItem.SubItems.Add(BooleanToStr(Merchant.m_boIsHide));
    end;
  finally
    UserEngine.m_MerchantList.UnLock;
  end;

  for I := 0 to UserEngine.QuestNPCList.Count - 1 do begin
    Merchant := TMerchant(UserEngine.QuestNPCList.Items[I]);
    if Merchant.m_PEnvir <> SelEnvirnoment then Continue;

    Inc(n01);
    ListItem := ListView.Items.Add;
    ListItem.Caption := IntToStr(n01);
    ListItem.SubItems.AddObject(Merchant.m_sCharName, Merchant);
      //ListItem.SubItems.Add(Merchant.m_sMapName);
    ListItem.SubItems.Add(IntToStr(Merchant.m_nCurrX) + ':' + IntToStr(Merchant.m_nCurrY));
    ListItem.SubItems.Add('否');
    ListItem.SubItems.Add('是');
    ListItem.SubItems.Add(BooleanToStr(Merchant.m_boIsHide));
  end;
  Caption := SelEnvirnoment.sMapDesc + ' ' + 'NPC数:' + IntToStr(ListView.Items.Count);
  ListView.Visible := True;
end;

procedure TfrmConfigMerchant.Open(Envir: TEnvirnoment);
begin
  SelEnvirnoment := Envir;
  boOpened := False;
  RefListViewSession;
  boOpened := True;
  ShowModal;
end;

procedure TfrmConfigMerchant.PopupMenu_RefClick(Sender: TObject);
begin
  RefListViewSession;
end;

procedure TfrmConfigMerchant.PopupMenu_LoadClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  Merchant: TMerchant;
begin
  for I := 0 to ListView.Items.Count - 1 do begin
    ListItem := ListView.Items.Item[I];
    if ListItem.Selected then begin
      Merchant := TMerchant(ListItem.SubItems.Objects[0]);
      try
        EnterCriticalSection(ProcessHumanCriticalSection);
        if CompareText(Merchant.m_sCharName, 'RobotManage') = 0 then begin
          RobotManage.RELOADROBOT();
        end;
        if Merchant.m_NpcType = n_Merchant then begin
          Merchant.ClearScript;
          Merchant.LoadNpcScript;
        end else begin
          TNormNpc(Merchant).ClearScript;
          TNormNpc(Merchant).LoadNpcScript;
        end;
      finally
        LeaveCriticalSection(ProcessHumanCriticalSection);
      end;
      if ListItem.SubItems.Count >= 6 then begin
        ListItem.SubItems.Delete(ListItem.SubItems.Count - 1);
      end;
      ListItem.SubItems.Add(Merchant.m_sCharName + ' 脚本加载完成...');
    end;
  end;
end;

procedure TfrmConfigMerchant.PopupMenu_ClearClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  Merchant: TMerchant;
begin
  for I := 0 to ListView.Items.Count - 1 do begin
    ListItem := ListView.Items.Item[I];
    if ListItem.Selected then begin
      Merchant := TMerchant(ListItem.SubItems.Objects[0]);
      if Merchant.m_NpcType = n_Merchant then begin
        Merchant.ClearData();
        if ListItem.SubItems.Count >= 6 then begin
          ListItem.SubItems.Delete(ListItem.SubItems.Count - 1);
        end;
        ListItem.SubItems.Add(Merchant.m_sCharName + ' 数据清除完成...');
      end;
    end;
  end;
end;

procedure TfrmConfigMerchant.PopupMenu_OpenClick(Sender: TObject);
var
  ListItem: TListItem;
  Merchant: TMerchant;
  sScriptFile: string;
begin
  ListItem := ListView.Selected;

  if ListItem <> nil then begin
    Merchant := TMerchant(ListItem.SubItems.Objects[0]);
    if Merchant.m_NpcType = n_Merchant then begin
      sScriptFile := g_Config.sEnvirDir + Merchant.m_sPath {'Market_Def\'} + Merchant.m_sScript + '-' + Merchant.m_sMapName + '.txt';
    end else begin
      if Merchant.m_boIsQuest then begin
        sScriptFile := g_Config.sEnvirDir + Merchant.m_sPath + Merchant.m_sCharName + '-' + Merchant.m_sMapName + '.txt';
      end else begin
        sScriptFile := g_Config.sEnvirDir + Merchant.m_sPath + Merchant.m_sCharName + '.txt';
      end;
    end;
    WinExec(PChar('Notepad.exe ' + sScriptFile), SW_SHOW);
  end;
end;

procedure TfrmConfigMerchant.ListViewClick(Sender: TObject);
var
  ListItem: TListItem;
  Merchant: TMerchant;
begin
  ListItem := ListView.Selected;
  if ListItem <> nil then begin
    Merchant := TMerchant(ListItem.SubItems.Objects[0]);
    PopupMenu_Clear.Enabled := Merchant.m_NpcType = n_Merchant;
  end;
end;

procedure TfrmConfigMerchant.ListViewDblClick(Sender: TObject);
var
  ListItem: TListItem;
  Merchant: TMerchant;
  sScriptFile: string;
begin
  ListItem := ListView.Selected;

  if ListItem <> nil then begin
    Merchant := TMerchant(ListItem.SubItems.Objects[0]);
    if Merchant.m_NpcType = n_Merchant then begin
      sScriptFile := g_Config.sEnvirDir + Merchant.m_sPath {'Market_Def\'} + Merchant.m_sScript + '-' + Merchant.m_sMapName + '.txt';
    end else begin
      if Merchant.m_boIsQuest then begin
        sScriptFile := g_Config.sEnvirDir + Merchant.m_sPath + Merchant.m_sCharName + '-' + Merchant.m_sMapName + '.txt';
      end else begin
        sScriptFile := g_Config.sEnvirDir + Merchant.m_sPath + Merchant.m_sCharName + '.txt';
      end;
    end;
    WinExec(PChar('Notepad.exe ' + sScriptFile), SW_SHOW);
  end;
end;

end.
