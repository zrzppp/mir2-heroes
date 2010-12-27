unit SysManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Menus;

type
  TfrmSysManager = class(TForm)
    PanelStatus: TPanel;
    ListView: TListView;
    PopupMenu: TPopupMenu;
    PopupMenu_Ref: TMenuItem;
    PopupMenu_ShowHum: TMenuItem;
    PopupMenu_ShowMon: TMenuItem;
    PopupMenu_ShowNpc: TMenuItem;
    PopupMenu_ShowItem: TMenuItem;
    PopupMenu_: TMenuItem;
    PopupMenu_AutoRef: TMenuItem;
    PopupMenu__: TMenuItem;
    PopupMenu_MonGen: TMenuItem;
    PopupMenu_RunHum: TMenuItem;
    PopupMenu_RunMon: TMenuItem;
    PopupMenu_Horser: TMenuItem;

    Timer: TTimer;
    StatusBar: TStatusBar;
    N1: TMenuItem;
    PopupMenu_ClearMon: TMenuItem;
    PopupMenu_ClearItem: TMenuItem;
    procedure PopupMenu_RefClick(Sender: TObject);
    procedure PopupMenu_ShowHumClick(Sender: TObject);
    procedure PopupMenu_AutoRefClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure PopupMenu_ShowMonClick(Sender: TObject);
    procedure PopupMenu_ShowNpcClick(Sender: TObject);
    procedure PopupMenu_ShowItemClick(Sender: TObject);
    procedure ListViewClick(Sender: TObject);
    procedure PopupMenu_MonGenClick(Sender: TObject);
    procedure PopupMenu_ClearMonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefListViewSession;
    procedure RefStatus;
    procedure Open();
  end;

var
  frmSysManager: TfrmSysManager;

implementation
uses HUtil32, M2Share, ObjBase, ObjActor, Envir, UsrEngn, ViewOnlineHuman,
  ConfigMonGen, ConfigMerchant, ConfigItem;
{$R *.dfm}

procedure TfrmSysManager.RefListViewSession;
var
  I: Integer;
  Envirnoment: TEnvirnoment;
  ListItem: TListItem;
begin
  PanelStatus.Caption := '正在取得数据...';
  ListView.Visible := False;
  ListView.Items.Clear;
  for I := 0 to g_MapManager.Count - 1 do begin
    Envirnoment := TEnvirnoment(g_MapManager.Items[I]);
    ListItem := ListView.Items.Add;
    ListItem.Caption := Envirnoment.MapName;
    ListItem.SubItems.AddObject(Envirnoment.sMapDesc, Envirnoment);
    ListItem.SubItems.Add(IntToStr(Envirnoment.m_nHumCount));
    ListItem.SubItems.Add(IntToStr(Envirnoment.m_nHeroCount));
    ListItem.SubItems.Add(IntToStr(Envirnoment.m_nMonCount));
    ListItem.SubItems.Add(IntToStr(Envirnoment.m_nNpcCount));
    ListItem.SubItems.Add(IntToStr(Envirnoment.m_nItemCount));

    ListItem.SubItems.Add(BooleanToStr(Envirnoment.m_boMonGen));
    ListItem.SubItems.Add(BooleanToStr(Envirnoment.m_boRUNHUMAN));
    ListItem.SubItems.Add(BooleanToStr(Envirnoment.m_boRUNMON));
    ListItem.SubItems.Add(BooleanToStr(Envirnoment.m_boHorse));
  end;
  ListView.Visible := True;
  RefStatus;
end;

procedure TfrmSysManager.RefStatus;
begin
  StatusBar.Panels[0].Text := '地图总数：' + IntToStr(g_MapManager.Count);
  StatusBar.Panels[1].Text := '人物总数：' + IntToStr(g_MapManager.m_nHumCount);
  StatusBar.Panels[2].Text := '英雄总数：' + IntToStr(g_MapManager.m_nHeroCount);
  StatusBar.Panels[3].Text := '怪物总数：' + IntToStr(g_MapManager.m_nMonCount);
  StatusBar.Panels[4].Text := 'NPC总数：' + IntToStr(g_MapManager.m_nNpcCount);
  StatusBar.Panels[5].Text := '物品总数：' + IntToStr(g_MapManager.m_nItemCount);
end;

procedure TfrmSysManager.Open();
begin
  RefListViewSession;
  PopupMenu_AutoRef.Checked := True;
  Timer.Enabled := PopupMenu_AutoRef.Checked;
  ShowModal;
end;

procedure TfrmSysManager.PopupMenu_RefClick(Sender: TObject);
begin
  RefListViewSession;
end;

procedure TfrmSysManager.PopupMenu_ShowHumClick(Sender: TObject);
var
  ListItem: TListItem;
  Envirnoment: TEnvirnoment;
begin
  ListItem := ListView.Selected;
  if ListItem <> nil then begin
    Envirnoment := TEnvirnoment(ListItem.SubItems.Objects[0]);
    frmViewOnlineHuman := TfrmViewOnlineHuman.Create(Owner);
    frmViewOnlineHuman.Top := Self.Top + 20;
    frmViewOnlineHuman.Left := Self.Left;
    frmViewOnlineHuman.Open(Envirnoment);
    frmViewOnlineHuman.Free;
  end;
end;

procedure TfrmSysManager.PopupMenu_AutoRefClick(Sender: TObject);
begin
  PopupMenu_AutoRef.Checked := not PopupMenu_AutoRef.Checked;
  Timer.Enabled := PopupMenu_AutoRef.Checked;
end;

procedure TfrmSysManager.TimerTimer(Sender: TObject);
var
  I: Integer;
  Envirnoment: TEnvirnoment;
  ListItem: TListItem;
begin
  for I := 0 to ListView.Items.Count - 1 do begin
    ListItem := ListView.Items.Item[I];
    Envirnoment := TEnvirnoment(ListItem.SubItems.Objects[0]);
    if Str_ToInt(ListItem.SubItems.Strings[1], 0) <> Envirnoment.m_nHumCount then
      ListItem.SubItems.Strings[1] := IntToStr(Envirnoment.m_nHumCount);

    if Str_ToInt(ListItem.SubItems.Strings[2], 0) <> Envirnoment.m_nHeroCount then
      ListItem.SubItems.Strings[2] := IntToStr(Envirnoment.m_nHeroCount);


    if Str_ToInt(ListItem.SubItems.Strings[3], 0) <> Envirnoment.m_nMonCount then
      ListItem.SubItems.Strings[3] := IntToStr(Envirnoment.m_nMonCount);

    if Str_ToInt(ListItem.SubItems.Strings[4], 0) <> Envirnoment.m_nNpcCount then
      ListItem.SubItems.Strings[4] := IntToStr(Envirnoment.m_nNpcCount);

    if Str_ToInt(ListItem.SubItems.Strings[5], 0) <> Envirnoment.m_nItemCount then
      ListItem.SubItems.Strings[5] := IntToStr(Envirnoment.m_nItemCount);

    if ListItem.SubItems.Strings[6] <> BooleanToStr(Envirnoment.m_boMonGen) then
      ListItem.SubItems.Strings[6] := BooleanToStr(Envirnoment.m_boMonGen);
    if ListItem.SubItems.Strings[7] <> BooleanToStr(Envirnoment.m_boRUNHUMAN) then
      ListItem.SubItems.Strings[7] := BooleanToStr(Envirnoment.m_boRUNHUMAN);
    if ListItem.SubItems.Strings[8] <> BooleanToStr(Envirnoment.m_boRUNMON) then
      ListItem.SubItems.Strings[8] := BooleanToStr(Envirnoment.m_boRUNMON);
    if ListItem.SubItems.Strings[9] <> BooleanToStr(Envirnoment.m_boHorse) then
      ListItem.SubItems.Strings[9] := BooleanToStr(Envirnoment.m_boHorse);
  end;
  RefStatus;
end;

procedure TfrmSysManager.PopupMenu_ShowMonClick(Sender: TObject);
var
  ListItem: TListItem;
  Envirnoment: TEnvirnoment;
begin
  ListItem := ListView.Selected;
  if ListItem <> nil then begin
    Envirnoment := TEnvirnoment(ListItem.SubItems.Objects[0]);
    frmConfigMonGen := TfrmConfigMonGen.Create(Owner);
    frmConfigMonGen.Top := Self.Top + 20;
    frmConfigMonGen.Left := Self.Left;
    frmConfigMonGen.Open(Envirnoment);
    frmConfigMonGen.Free;
  end;
end;

procedure TfrmSysManager.PopupMenu_ShowNpcClick(Sender: TObject);
var
  ListItem: TListItem;
  Envirnoment: TEnvirnoment;
begin
  ListItem := ListView.Selected;
  if ListItem <> nil then begin
    Envirnoment := TEnvirnoment(ListItem.SubItems.Objects[0]);
    frmConfigMerchant := TfrmConfigMerchant.Create(Owner);
    frmConfigMerchant.Top := Self.Top + 20;
    frmConfigMerchant.Left := Self.Left;
    frmConfigMerchant.Open(Envirnoment);
    frmConfigMerchant.Free;
  end;
end;

procedure TfrmSysManager.PopupMenu_ShowItemClick(Sender: TObject);
var
  ListItem: TListItem;
  Envirnoment: TEnvirnoment;
begin
  ListItem := ListView.Selected;
  if ListItem <> nil then begin
    Envirnoment := TEnvirnoment(ListItem.SubItems.Objects[0]);
    frmConfigItem := TfrmConfigItem.Create(Owner);
    frmConfigItem.Top := Self.Top + 20;
    frmConfigItem.Left := Self.Left;
    frmConfigItem.Open(Envirnoment);
    frmConfigItem.Free;
  end;
end;

procedure TfrmSysManager.ListViewClick(Sender: TObject);
var
  ListItem: TListItem;
  Envirnoment: TEnvirnoment;
begin
  ListItem := ListView.Selected;
  if ListItem <> nil then begin
    Envirnoment := TEnvirnoment(ListItem.SubItems.Objects[0]);
    PopupMenu_MonGen.Checked := Envirnoment.m_boMonGen;
    PopupMenu_RunHum.Checked := Envirnoment.m_boRUNHUMAN;
    PopupMenu_RunMon.Checked := Envirnoment.m_boRUNMON;
    PopupMenu_Horser.Checked := Envirnoment.m_boHorse;
  end;
end;

procedure TfrmSysManager.PopupMenu_MonGenClick(Sender: TObject);
var
  ListItem: TListItem;
  Envirnoment: TEnvirnoment;
begin
  ListItem := ListView.Selected;
  if ListItem <> nil then begin
    Envirnoment := TEnvirnoment(ListItem.SubItems.Objects[0]);
    if Sender = PopupMenu_MonGen then begin
      PopupMenu_MonGen.Checked := not PopupMenu_MonGen.Checked;
      Envirnoment.m_boMonGen := PopupMenu_MonGen.Checked;
    end else
      if Sender = PopupMenu_RunHum then begin
      PopupMenu_RunHum.Checked := not PopupMenu_RunHum.Checked;
      Envirnoment.m_boRUNHUMAN := PopupMenu_RunHum.Checked;
    end else
      if Sender = PopupMenu_RunMon then begin
      PopupMenu_RunMon.Checked := not PopupMenu_RunMon.Checked;
      Envirnoment.m_boRUNMON := PopupMenu_RunMon.Checked;
    end else
      if Sender = PopupMenu_Horser then begin
      PopupMenu_Horser.Checked := not PopupMenu_Horser.Checked;
      Envirnoment.m_boHorse := PopupMenu_Horser.Checked;
    end;
  end;
end;

procedure TfrmSysManager.PopupMenu_ClearMonClick(Sender: TObject);
var
  I: Integer;
  ActorObject: TActorObject;
  ListItem: TListItem;
  Envir: TEnvirnoment;
  MonList: TList;
begin
  ListItem := ListView.Selected;
  if ListItem <> nil then begin
    Envir := TEnvirnoment(ListItem.SubItems.Objects[0]);
    if Envir <> nil then begin
      MonList := TList.Create;
      UserEngine.GetMapMonster(Envir, MonList);
      for I := 0 to MonList.Count - 1 do begin
        ActorObject := TActorObject(MonList.Items[I]);
        if ActorObject.m_Master <> nil then Continue;
        if GetNoClearMonList(ActorObject.m_sCharName) then Continue;
        ActorObject.m_boNoItem := True;
        ActorObject.MakeGhost;
      end;
      MonList.Free;
    end;
  end;
end;

end.
