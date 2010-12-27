unit HumanInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ObjBase, ObjActor, ObjHero, StdCtrls, Spin, ComCtrls, ExtCtrls, Grids;

type
  TfrmHumanInfo = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EditName: TEdit;
    EditMap: TEdit;
    EditXY: TEdit;
    EditAccount: TEdit;
    EditIPaddr: TEdit;
    EditLogonTime: TEdit;
    EditLogonLong: TEdit;
    GroupBox2: TGroupBox;
    Label12: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    EditLevel: TSpinEdit;
    EditGold: TSpinEdit;
    EditPKPoint: TSpinEdit;
    EditExp: TSpinEdit;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    GroupBox3: TGroupBox;
    Label11: TLabel;
    EditAC: TEdit;
    Label13: TLabel;
    EditMAC: TEdit;
    Label14: TLabel;
    EditDC: TEdit;
    EditMC: TEdit;
    Label15: TLabel;
    EditSC: TEdit;
    Label16: TLabel;
    EditHP: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    EditMP: TEdit;
    Timer: TTimer;
    GroupBox4: TGroupBox;
    CheckBoxMonitor: TCheckBox;
    GroupBox5: TGroupBox;
    EditHumanStatus: TEdit;
    GroupBox6: TGroupBox;
    CheckBoxGameMaster: TCheckBox;
    CheckBoxSuperMan: TCheckBox;
    CheckBoxObserver: TCheckBox;
    ButtonKick: TButton;
    GroupBox7: TGroupBox;
    GroupBox9: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    EditGameGold: TSpinEdit;
    EditGamePoint: TSpinEdit;
    EditCreditPoint: TSpinEdit;
    EditBonusPoint: TSpinEdit;
    Label19: TLabel;
    EditEditBonusPointUsed: TSpinEdit;
    ButtonSave: TButton;
    GridUserItem: TStringGrid;
    GroupBox8: TGroupBox;
    GridBagItem: TStringGrid;
    GroupBox10: TGroupBox;
    GridStorageItem: TStringGrid;
    GroupBox11: TGroupBox;
    Label20: TLabel;
    EditSayMsg: TEdit;
    Label21: TLabel;
    EditMaxExp: TSpinEdit;
    TabSheet10: TTabSheet;
    GridMagicList: TStringGrid;
    procedure TimerTimer(Sender: TObject);
    procedure CheckBoxMonitorClick(Sender: TObject);
    procedure ButtonKickClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure RefHumanInfo();
    { Private declarations }
  public
    ActorObject: TActorObject;
    procedure Open();
    { Public declarations }
  end;

var
  frmHumanInfo: TfrmHumanInfo;

implementation

uses UsrEngn, M2Share, Grobal2;

{$R *.dfm}
var
  boRefHuman: Boolean = False;
  { TfrmHumanInfo }

procedure TfrmHumanInfo.FormCreate(Sender: TObject);
begin
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

  GridBagItem.Cells[0, 0] := '序号';
  GridBagItem.Cells[1, 0] := '装备名称';
  GridBagItem.Cells[2, 0] := '系列号';
  GridBagItem.Cells[3, 0] := '持久';
  GridBagItem.Cells[4, 0] := '攻';
  GridBagItem.Cells[5, 0] := '魔';
  GridBagItem.Cells[6, 0] := '道';
  GridBagItem.Cells[7, 0] := '防';
  GridBagItem.Cells[8, 0] := '魔防';
  GridBagItem.Cells[9, 0] := '附加属性';

  GridStorageItem.Cells[0, 0] := '序号';
  GridStorageItem.Cells[1, 0] := '装备名称';
  GridStorageItem.Cells[2, 0] := '系列号';
  GridStorageItem.Cells[3, 0] := '持久';
  GridStorageItem.Cells[4, 0] := '攻';
  GridStorageItem.Cells[5, 0] := '魔';
  GridStorageItem.Cells[6, 0] := '道';
  GridStorageItem.Cells[7, 0] := '防';
  GridStorageItem.Cells[8, 0] := '魔防';
  GridStorageItem.Cells[9, 0] := '附加属性';

  GridMagicList.Cells[0, 0] := '序号';
  GridMagicList.Cells[1, 0] := '魔法名称';
  GridMagicList.Cells[2, 0] := '魔法等级';


  {
  GridHeroUserItem.Cells[0, 0] := '装备位置';
  GridHeroUserItem.Cells[1, 0] := '装备名称';
  GridHeroUserItem.Cells[2, 0] := '系列号';
  GridHeroUserItem.Cells[3, 0] := '持久';
  GridHeroUserItem.Cells[4, 0] := '攻';
  GridHeroUserItem.Cells[5, 0] := '魔';
  GridHeroUserItem.Cells[6, 0] := '道';
  GridHeroUserItem.Cells[7, 0] := '防';
  GridHeroUserItem.Cells[8, 0] := '魔防';
  GridHeroUserItem.Cells[9, 0] := '附加属性';

  GridHeroUserItem.Cells[0, 1] := '衣服';
  GridHeroUserItem.Cells[0, 2] := '武器';
  GridHeroUserItem.Cells[0, 3] := '照明物';
  GridHeroUserItem.Cells[0, 4] := '项链';
  GridHeroUserItem.Cells[0, 5] := '头盔';
  GridHeroUserItem.Cells[0, 6] := '左手镯';
  GridHeroUserItem.Cells[0, 7] := '右手镯';
  GridHeroUserItem.Cells[0, 8] := '左戒指';
  GridHeroUserItem.Cells[0, 9] := '右戒指';
  GridHeroUserItem.Cells[0, 10] := '物品';
  GridHeroUserItem.Cells[0, 11] := '腰带';
  GridHeroUserItem.Cells[0, 12] := '鞋子';
  GridHeroUserItem.Cells[0, 13] := '宝石';

  GridHeroBagItem.Cells[0, 0] := '序号';
  GridHeroBagItem.Cells[1, 0] := '装备名称';
  GridHeroBagItem.Cells[2, 0] := '系列号';
  GridHeroBagItem.Cells[3, 0] := '持久';
  GridHeroBagItem.Cells[4, 0] := '攻';
  GridHeroBagItem.Cells[5, 0] := '魔';
  GridHeroBagItem.Cells[6, 0] := '道';
  GridHeroBagItem.Cells[7, 0] := '防';
  GridHeroBagItem.Cells[8, 0] := '魔防';
  GridHeroBagItem.Cells[9, 0] := '附加属性'; }

  PageControl1.ActivePageIndex := 0;

 // PageControl1.Pages[6].TabVisible := True;
 // PageControl1.Pages[7].TabVisible := True;
 // PageControl1.Pages[8].TabVisible := True;
  EditCreditPoint.MaxValue := High(Integer);
end;

procedure TfrmHumanInfo.Open;
begin
  RefHumanInfo();
  ButtonKick.Enabled := True;
  Timer.Enabled := True;
  if (ActorObject <> nil) then begin
    if (ActorObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      Caption := '人物属性';
    end else begin
      Caption := '英雄属性';
    end;
  end;
  ShowModal;
  CheckBoxMonitor.Checked := False;
  Timer.Enabled := False;
end;

procedure TfrmHumanInfo.RefHumanInfo;
var
  I: Integer;
  nTotleUsePoint: Integer;
  StdItem: pTStdItem;
  Item: TStdItem;
  UserItem: pTUserItem;
  PlayObject: TPlayObject;
  UserMagic: pTUserMagic;
begin
  if (ActorObject = nil) then begin
    Exit;
  end;

  if (ActorObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    if TPlayObject(ActorObject).m_boNotOnlineAddExp then EditSayMsg.Enabled := True else EditSayMsg.Enabled := False;
    EditSayMsg.Text := TPlayObject(ActorObject).m_sAutoSendMsg;
  end else begin
    TabSheet3.TabVisible := False;
    TabSheet6.TabVisible := False;
    GroupBox6.Visible := False;
    GroupBox9.Visible := False;
    GroupBox11.Visible := False;
  end;

  EditName.Text := ActorObject.m_sCharName;
  EditMap.Text := ActorObject.m_sMapName + '(' + ActorObject.m_PEnvir.sMapDesc + ')';
  EditXY.Text := IntToStr(ActorObject.m_nCurrX) + ':' + IntToStr(ActorObject.m_nCurrY);

  if (ActorObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    EditAccount.Text := TPlayObject(ActorObject).m_sUserID;
    EditIPaddr.Text := TPlayObject(ActorObject).m_sIPaddr;
    EditLogonTime.Text := DateTimeToStr(TPlayObject(ActorObject).m_dLogonTime);
    EditLogonLong.Text := IntToStr((GetTickCount - TPlayObject(ActorObject).m_dwLogonTick) div (60 * 1000)) + ' 分钟';
  end else begin
    EditAccount.Text := THeroObject(ActorObject).m_sUserID;
    EditIPaddr.Text := TPlayObject(ActorObject.m_Master).m_sIPaddr;
    EditLogonTime.Text := DateTimeToStr(THeroObject(ActorObject).m_dLogonTime);
    EditLogonLong.Text := IntToStr((GetTickCount - THeroObject(ActorObject).m_dwLogonTick) div (60 * 1000)) + ' 分钟';
  end;

  EditLevel.Value := ActorObject.m_Abil.Level;
  EditGold.Value := ActorObject.m_nGold;
  EditPKPoint.Value := ActorObject.m_nPkPoint;
  EditExp.Value := ActorObject.m_Abil.Exp;
  EditMaxExp.Value := ActorObject.m_Abil.MaxExp;

  EditAC.Text := IntToStr(LoWord(ActorObject.m_WAbil.AC)) + '/' + IntToStr(HiWord(ActorObject.m_WAbil.AC));
  EditMAC.Text := IntToStr(LoWord(ActorObject.m_WAbil.MAC)) + '/' + IntToStr(HiWord(ActorObject.m_WAbil.MAC));
  EditDC.Text := IntToStr(LoWord(ActorObject.m_WAbil.DC)) + '/' + IntToStr(HiWord(ActorObject.m_WAbil.DC));
  EditMC.Text := IntToStr(LoWord(ActorObject.m_WAbil.MC)) + '/' + IntToStr(HiWord(ActorObject.m_WAbil.MC));
  EditSC.Text := IntToStr(LoWord(ActorObject.m_WAbil.SC)) + '/' + IntToStr(HiWord(ActorObject.m_WAbil.SC));
  EditHP.Text := IntToStr(ActorObject.m_WAbil.HP) + '/' + IntToStr(ActorObject.m_WAbil.MaxHP);
  EditMP.Text := IntToStr(ActorObject.m_WAbil.MP) + '/' + IntToStr(ActorObject.m_WAbil.MaxMP);

  if (ActorObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    EditGameGold.Value := TPlayObject(ActorObject).m_nGameGold;
    EditGamePoint.Value := TPlayObject(ActorObject).m_nGamePoint;
    EditCreditPoint.Value := TPlayObject(ActorObject).m_btCreditPoint;
    EditBonusPoint.Value := TPlayObject(ActorObject).m_nBonusPoint;

    nTotleUsePoint := TPlayObject(ActorObject).m_BonusAbil.DC +
      TPlayObject(ActorObject).m_BonusAbil.MC +
      TPlayObject(ActorObject).m_BonusAbil.SC +
      TPlayObject(ActorObject).m_BonusAbil.AC +
      TPlayObject(ActorObject).m_BonusAbil.MAC +
      TPlayObject(ActorObject).m_BonusAbil.HP +
      TPlayObject(ActorObject).m_BonusAbil.MP +
      TPlayObject(ActorObject).m_BonusAbil.Hit +
      TPlayObject(ActorObject).m_BonusAbil.Speed +
      TPlayObject(ActorObject).m_BonusAbil.X2;

    EditEditBonusPointUsed.Value := nTotleUsePoint;

    CheckBoxGameMaster.Checked := TPlayObject(ActorObject).m_boAdminMode;
    CheckBoxSuperMan.Checked := TPlayObject(ActorObject).m_boSuperMan;
    CheckBoxObserver.Checked := TPlayObject(ActorObject).m_boObMode;
  end;

  if ActorObject.m_boDeath then begin
    EditHumanStatus.Text := '死亡';
  end else
    if ActorObject.m_boGhost then begin
    EditHumanStatus.Text := '下线';
    ActorObject := nil;
  end else EditHumanStatus.Text := '在线';

  if ActorObject = nil then Exit;

  for I := Low(ActorObject.m_UseItems) to High(ActorObject.m_UseItems) do begin
    UserItem := @ActorObject.m_UseItems[I];
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
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
      Continue;
    end;
    Item := StdItem^;
    ItemUnit.GetItemAddValue(UserItem, Item);

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

  if ActorObject.m_ItemList.Count <= 0 then GridBagItem.RowCount := 2
  else GridBagItem.RowCount := ActorObject.m_ItemList.Count + 1;

  for I := 0 to ActorObject.m_ItemList.Count - 1 do begin
    UserItem := ActorObject.m_ItemList.Items[I];
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem = nil then begin
      GridBagItem.Cells[1, I + 1] := '';
      GridBagItem.Cells[2, I + 1] := '';
      GridBagItem.Cells[3, I + 1] := '';
      GridBagItem.Cells[4, I + 1] := '';
      GridBagItem.Cells[5, I + 1] := '';
      GridBagItem.Cells[6, I + 1] := '';
      GridBagItem.Cells[7, I + 1] := '';
      GridBagItem.Cells[8, I + 1] := '';
      GridBagItem.Cells[9, I + 1] := '';
      Continue;
    end;
    Item := StdItem^;
    ItemUnit.GetItemAddValue(UserItem, Item);
    GridBagItem.Cells[0, I + 1] := IntToStr(I);
    GridBagItem.Cells[1, I + 1] := Item.Name;
    GridBagItem.Cells[2, I + 1] := IntToStr(UserItem.MakeIndex);
    GridBagItem.Cells[3, I + 1] := Format('%d/%d', [UserItem.Dura, UserItem.DuraMax]);
    GridBagItem.Cells[4, I + 1] := Format('%d/%d', [LoWord(Item.DC), HiWord(Item.DC)]);
    GridBagItem.Cells[5, I + 1] := Format('%d/%d', [LoWord(Item.MC), HiWord(Item.MC)]);
    GridBagItem.Cells[6, I + 1] := Format('%d/%d', [LoWord(Item.SC), HiWord(Item.SC)]);
    GridBagItem.Cells[7, I + 1] := Format('%d/%d', [LoWord(Item.AC), HiWord(Item.AC)]);
    GridBagItem.Cells[8, I + 1] := Format('%d/%d', [LoWord(Item.MAC), HiWord(Item.MAC)]);
    GridBagItem.Cells[9, I + 1] := Format('%d/%d/%d/%d/%d/%d/%d', [UserItem.btValue[0],
      UserItem.btValue[1],
        UserItem.btValue[2],
        UserItem.btValue[3],
        UserItem.btValue[4],
        UserItem.btValue[5],
        UserItem.btValue[6]]);
  end;

  if (ActorObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    PlayObject := TPlayObject(ActorObject);
    if PlayObject.m_StorageItemList.Count <= 0 then GridStorageItem.RowCount := 2
    else GridStorageItem.RowCount := PlayObject.m_StorageItemList.Count + 1;

    for I := 0 to PlayObject.m_StorageItemList.Count - 1 do begin
      UserItem := PlayObject.m_StorageItemList.Items[I];
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem = nil then begin
        GridStorageItem.Cells[1, I + 1] := '';
        GridStorageItem.Cells[2, I + 1] := '';
        GridStorageItem.Cells[3, I + 1] := '';
        GridStorageItem.Cells[4, I + 1] := '';
        GridStorageItem.Cells[5, I + 1] := '';
        GridStorageItem.Cells[6, I + 1] := '';
        GridStorageItem.Cells[7, I + 1] := '';
        GridStorageItem.Cells[8, I + 1] := '';
        GridStorageItem.Cells[9, I + 1] := '';
        Continue;
      end;
      Item := StdItem^;
      ItemUnit.GetItemAddValue(UserItem, Item);

      GridStorageItem.Cells[0, I + 1] := IntToStr(I);
      GridStorageItem.Cells[1, I + 1] := Item.Name;
      GridStorageItem.Cells[2, I + 1] := IntToStr(UserItem.MakeIndex);
      GridStorageItem.Cells[3, I + 1] := Format('%d/%d', [UserItem.Dura, UserItem.DuraMax]);
      GridStorageItem.Cells[4, I + 1] := Format('%d/%d', [LoWord(Item.DC), HiWord(Item.DC)]);
      GridStorageItem.Cells[5, I + 1] := Format('%d/%d', [LoWord(Item.MC), HiWord(Item.MC)]);
      GridStorageItem.Cells[6, I + 1] := Format('%d/%d', [LoWord(Item.SC), HiWord(Item.SC)]);
      GridStorageItem.Cells[7, I + 1] := Format('%d/%d', [LoWord(Item.AC), HiWord(Item.AC)]);
      GridStorageItem.Cells[8, I + 1] := Format('%d/%d', [LoWord(Item.MAC), HiWord(Item.MAC)]);
      GridStorageItem.Cells[9, I + 1] := Format('%d/%d/%d/%d/%d/%d/%d', [UserItem.btValue[0],
        UserItem.btValue[1],
          UserItem.btValue[2],
          UserItem.btValue[3],
          UserItem.btValue[4],
          UserItem.btValue[5],
          UserItem.btValue[6]]);
    end;
  end;

  if ActorObject.m_MagicList.Count <= 0 then GridMagicList.RowCount := 2
  else GridMagicList.RowCount := ActorObject.m_MagicList.Count + 1;

  for I := 0 to ActorObject.m_MagicList.Count - 1 do begin
    UserMagic := ActorObject.m_MagicList.Items[I];
    GridMagicList.Cells[0, I + 1] := IntToStr(I);
    GridMagicList.Cells[1, I + 1] := UserMagic.MagicInfo.sMagicName;
    GridMagicList.Cells[2, I + 1] := IntToStr(UserMagic.btLevel);
  end;
end;


procedure TfrmHumanInfo.TimerTimer(Sender: TObject);
begin
  if ActorObject = nil then Exit;
  if ActorObject.m_boGhost then begin
    EditHumanStatus.Text := '下线';
    ActorObject := nil;
    Exit;
  end;
  if boRefHuman then RefHumanInfo();
end;

procedure TfrmHumanInfo.CheckBoxMonitorClick(Sender: TObject);
begin
  boRefHuman := CheckBoxMonitor.Checked;
  ButtonSave.Enabled := not boRefHuman;
end;

procedure TfrmHumanInfo.ButtonKickClick(Sender: TObject);
var
  PlayObject: TPlayObject;
  HeroObject: THeroObject;
begin
  if ActorObject = nil then Exit;
  if (ActorObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    PlayObject := TPlayObject(ActorObject);

    PlayObject.m_boEmergencyClose := True;
    PlayObject.m_boNotOnlineAddExp := False;
  end else begin
    HeroObject := THeroObject(ActorObject);
    HeroObject.LogOut;
  end;
  ButtonKick.Enabled := False;
end;

procedure TfrmHumanInfo.ButtonSaveClick(Sender: TObject);
var
  nOLevel: Integer;
  nLevel: Integer;
  nGold: Integer;
  nPKPOINT: Integer;
  nGameGold: Integer;
  nGamePoint: Integer;
  nCreditPoint: Integer;
  nBonusPoint: Integer;
  boGameMaster: Boolean;
  boObServer: Boolean;
  boSuperman: Boolean;
  sAutoSendMsg: string;

  PlayObject: TPlayObject;
  HeroObject: THeroObject;
begin
  if ActorObject = nil then Exit;
  if (ActorObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    PlayObject := TPlayObject(ActorObject);
  end else begin
    HeroObject := THeroObject(ActorObject);
  end;
  sAutoSendMsg := Trim(EditSayMsg.Text);
  nLevel := EditLevel.Value;
  nGold := EditGold.Value;
  nPKPOINT := EditPKPoint.Value;
  nGameGold := EditGameGold.Value;
  nGamePoint := EditGamePoint.Value;
  nCreditPoint := EditCreditPoint.Value;
  nBonusPoint := EditBonusPoint.Value;
  boGameMaster := CheckBoxGameMaster.Checked;
  boObServer := CheckBoxObserver.Checked;
  boSuperman := CheckBoxSuperMan.Checked;
  if (nLevel < 0) or (nLevel > g_Config.nMaxLevel) or (nGold < 0) or (nGold > 200000000) or (nPKPOINT < 0) or
    (nPKPOINT > 2000000) or (nCreditPoint < 0) or (nCreditPoint > High(Integer)) or (nBonusPoint < 0) or (nBonusPoint > 20000000) then begin
    MessageBox(Handle, '输入数据不正确！！！', '错误信息', MB_OK);
    Exit;
  end;

  if (ActorObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    PlayObject.m_sAutoSendMsg := sAutoSendMsg;
    PlayObject.m_nGold := nGold;
    PlayObject.m_nPkPoint := nPKPOINT;
    PlayObject.m_nGameGold := nGameGold;
    PlayObject.m_nGamePoint := nGamePoint;
    PlayObject.m_btCreditPoint := nCreditPoint;
    PlayObject.m_nBonusPoint := nBonusPoint;
    PlayObject.m_boAdminMode := boGameMaster;
    PlayObject.m_boObMode := boObServer;
    PlayObject.m_boSuperMan := boSuperman;
    PlayObject.GoldChanged;
  end;
  nOLevel := ActorObject.m_Abil.Level;
  ActorObject.m_Abil.Level := nLevel;
  if nOLevel <> ActorObject.m_Abil.Level then begin
    ActorObject.HasLevelUp(0);
  end else begin

  end;
  if (ActorObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    MessageBox(Handle, '人物数据已保存。', '提示信息', MB_OK);
  end else begin
    MessageBox(Handle, '英雄数据已保存。', '提示信息', MB_OK);
  end;
end;

end.

