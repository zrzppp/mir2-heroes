unit OtherOption;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzRadChk, RzButton, RzSpnEdt, StdCtrls, Mask, RzEdit, RzLabel,
  RzPanel, ExtCtrls, RzCmboBx, Grobal2, HumDB, IDDB, Spin;

type
  TfrmOtherOption = class(TFrame)
    GroupBox: TRzGroupBox;
    RzPanel: TPanel;
    Label1: TLabel;
    ComboBoxDelItem: TComboBox;
    ComboBoxDelMagic: TComboBox;
    ComboBoxLevel: TComboBox;
    ComboBoxGold: TComboBox;
    ComboBoxPK: TComboBox;
    ButtonChgMapXY: TButton;
    ButtonChgHomeMapXY: TButton;
    ButtonChgItemID: TButton;
    ButtonChgMagicID: TButton;
    ButtonDelItem: TButton;
    ButtonDelMagic: TButton;
    ButtonChgLevel: TButton;
    ButtonChgGold: TButton;
    ButtonChgPK: TButton;
    EditMap: TEdit;
    EditHomeMap: TEdit;
    CheckBoxItemReserve: TCheckBox;
    CheckBoxMagicReserve: TCheckBox;
    EditMapX: TSpinEdit;
    EditHomeMapX: TSpinEdit;
    EditMapY: TSpinEdit;
    EditHomeMapY: TSpinEdit;
    EditItemIDOld: TSpinEdit;
    EditMagicIDOld: TSpinEdit;
    EditItemIDNew: TSpinEdit;
    EditMagicIDNew: TSpinEdit;
    EditDelItemID: TSpinEdit;
    EditDelMagicID: TSpinEdit;
    EditLevel: TSpinEdit;
    EditGold: TSpinEdit;
    EditPK: TSpinEdit;
    RzLabel1: TLabel;
    RzLabel2: TLabel;
    RzLabel3: TLabel;
    RzLabel4: TLabel;
    RzLabel5: TLabel;
    RzLabel6: TLabel;
    RzLabel7: TLabel;
    RzLabel8: TLabel;
    RzLabel9: TLabel;
    RzLabel10: TLabel;
    RzLabel11: TLabel;
    RzLabel12: TLabel;
    RzLabel13: TLabel;
    RzLabel14: TLabel;
    RzLabel15: TLabel;
    RzLabel16: TLabel;
    RzLabel17: TLabel;
    procedure ButtonChgMapXYClick(Sender: TObject);
    procedure ButtonChgHomeMapXYClick(Sender: TObject);
    procedure ButtonChgItemIDClick(Sender: TObject);
    procedure ButtonChgMagicIDClick(Sender: TObject);
    procedure ButtonDelItemClick(Sender: TObject);
    procedure ButtonDelMagicClick(Sender: TObject);
    procedure ButtonChgLevelClick(Sender: TObject);
    procedure ButtonChgGoldClick(Sender: TObject);
    procedure ButtonChgPKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Init;
  end;

var
  frmOtherOption: TfrmOtherOption;

implementation
uses Share, ObjBase, HUtil32;
{$R *.dfm}

procedure TfrmOtherOption.Init;
begin
{$IFDEF VCL70_OR_HIGHER}
  ParentBackground := False;
{$ENDIF}
end;

procedure TfrmOtherOption.ButtonChgMapXYClick(Sender: TObject);
var
  sMap: string;
  I, nX, nY: Integer;
  HumDataInfo: pTHumDataInfo;
begin
  sMap := Trim(EditMap.Text);
  nX := EditMapX.Value;
  nY := EditMapY.Value;
  if sMap = '' then begin
    Application.MessageBox('请输入当前地图名称！', '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  RzPanel.Enabled := False;

  if Assigned(g_FileDB.OnStart) then g_FileDB.OnStart(Self,
      g_FileDB.m_MirCharNameList.Count, '正在修改，请稍候...');
  for I := 0 to g_FileDB.m_MirCharNameList.Count - 1 do begin
    if g_boSoftClose then Break;
    if Assigned(g_FileDB.OnProgress) then g_FileDB.OnProgress(Self, I + 1, '');
    Application.ProcessMessages;
    HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[I]);
    HumDataInfo.Data.sCurMap := sMap;
    HumDataInfo.Data.wCurX := nX;
    HumDataInfo.Data.wCurY := nY;
  end;
  if Assigned(g_FileDB.OnStop) then g_FileDB.OnStop(Self, 0,
      '修改完成');
  RzPanel.Enabled := True;
  Application.MessageBox('修改完成！', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmOtherOption.ButtonChgHomeMapXYClick(Sender: TObject);
var
  sMap: string;
  I, nX, nY: Integer;
  HumDataInfo: pTHumDataInfo;
begin
  sMap := Trim(EditHomeMap.Text);
  nX := EditHomeMapX.Value;
  nY := EditHomeMapY.Value;
  if sMap = '' then begin
    Application.MessageBox('请输入回城地图名称！', '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  RzPanel.Enabled := False;
  if Assigned(g_FileDB.OnStart) then g_FileDB.OnStart(Self,
      g_FileDB.m_MirCharNameList.Count, '正在修改，请稍候...');
  for I := 0 to g_FileDB.m_MirCharNameList.Count - 1 do begin
    if g_boSoftClose then Break;
    if Assigned(g_FileDB.OnProgress) then g_FileDB.OnProgress(Self, I + 1, '');
    Application.ProcessMessages;
    HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[I]);
    HumDataInfo.Data.sHomeMap := sMap;
    HumDataInfo.Data.wHomeX := nX;
    HumDataInfo.Data.wHomeY := nY;
  end;
  if Assigned(g_FileDB.OnStop) then g_FileDB.OnStop(Self, 0,
      '修改完成');
  RzPanel.Enabled := True;
  Application.MessageBox('修改完成！', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmOtherOption.ButtonChgItemIDClick(Sender: TObject);
var
  nOldID, nNewID: Integer;
  I, II, III: Integer;
  HumDataInfo: pTHumDataInfo;
  SellOffInfo: pTSellOffInfo;
  BigStorage: pTBigStorage;
  HumData: pTHumData;

  UserItem: pTUserItem;
begin
  nOldID := EditItemIDOld.Value + 1;
  nNewID := EditItemIDNew.Value + 1;
  if (nOldID = nNewID) or (nOldID <= 0) or (nNewID <= 0) then begin
    Application.MessageBox('物品代码设置有误！', '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  RzPanel.Enabled := False;

  if Assigned(g_FileDB.OnStart) then g_FileDB.OnStart(Self,
      g_FileDB.m_MirCharNameList.Count, '正在修改，请稍候...');

  for I := 0 to g_FileDB.m_MirCharNameList.Count - 1 do begin
    if g_boSoftClose then Break;
    if Assigned(g_FileDB.OnProgress) then g_FileDB.OnProgress(Self, I + 1, '');
    Application.ProcessMessages;
    HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[I]);
    HumData := @HumDataInfo.Data;
    for II := Low(HumData.HumItems) to High(HumData.HumItems) do begin
      if g_boSoftClose then Break;
      UserItem := @HumData.HumItems[II];
      if (UserItem.wIndex > 0) and (UserItem.wIndex = nOldID) then begin
        UserItem.wIndex := nNewID;
        if not CheckBoxItemReserve.Checked then begin
          FillChar(UserItem.btValue, SizeOf(TValue), 0);
          FillChar(UserItem.btValue2, SizeOf(TValue), 0);
          FillChar(UserItem.AddValue, SizeOf(TValue), 0);
          FillChar(UserItem.AddPoint, SizeOf(TValue), 0);
        end;
      end;
    end;
    for II := Low(HumData.HumAddItems) to High(HumData.HumAddItems) do begin
      if g_boSoftClose then Break;
      UserItem := @HumData.HumAddItems[II];
      if (UserItem.wIndex > 0) and (UserItem.wIndex = nOldID) then begin
        UserItem.wIndex := nNewID;
        if not CheckBoxItemReserve.Checked then begin
          FillChar(UserItem.btValue, SizeOf(TValue), 0);
          FillChar(UserItem.btValue2, SizeOf(TValue), 0);
          FillChar(UserItem.AddValue, SizeOf(TValue), 0);
          FillChar(UserItem.AddPoint, SizeOf(TValue), 0);
        end;
      end;
    end;
    for II := Low(HumData.BagItems) to High(HumData.BagItems) do begin
      if g_boSoftClose then Break;
      UserItem := @HumData.BagItems[II];
      if (UserItem.wIndex > 0) and (UserItem.wIndex = nOldID) then begin
        UserItem.wIndex := nNewID;
        if not CheckBoxItemReserve.Checked then begin
          FillChar(UserItem.btValue, SizeOf(TValue), 0);
          FillChar(UserItem.btValue2, SizeOf(TValue), 0);
          FillChar(UserItem.AddValue, SizeOf(TValue), 0);
          FillChar(UserItem.AddPoint, SizeOf(TValue), 0);
        end;
      end;
    end;
    for II := Low(HumData.StorageItems) to High(HumData.StorageItems) do begin
      if g_boSoftClose then Break;
      UserItem := @HumData.StorageItems[II];
      if (UserItem.wIndex > 0) and (UserItem.wIndex = nOldID) then begin
        UserItem.wIndex := nNewID;
        if not CheckBoxItemReserve.Checked then begin
          FillChar(UserItem.btValue, SizeOf(TValue), 0);
          FillChar(UserItem.btValue2, SizeOf(TValue), 0);
          FillChar(UserItem.AddValue, SizeOf(TValue), 0);
          FillChar(UserItem.AddPoint, SizeOf(TValue), 0);
        end;
      end;
    end;
  end;

  if Assigned(g_Storage.OnStart) then g_Storage.OnStart(Self,g_Storage.m_ItemList.Count, '正在修改，请稍候...');
  for I := 0 to g_Storage.m_ItemList.Count - 1 do begin
    if g_boSoftClose then Break;
    if Assigned(g_FileDB.OnProgress) then g_FileDB.OnProgress(Self, I + 1, '');
    Application.ProcessMessages;
    BigStorage := pTBigStorage(g_Storage.m_ItemList.Objects[I]);
    UserItem := @BigStorage.UserItem;
    if (UserItem.wIndex > 0) and (UserItem.wIndex = nOldID) then begin
      UserItem.wIndex := nNewID;
      if not CheckBoxItemReserve.Checked then begin
        FillChar(UserItem.btValue, SizeOf(TValue), 0);
        FillChar(UserItem.btValue2, SizeOf(TValue), 0);
        FillChar(UserItem.AddValue, SizeOf(TValue), 0);
        FillChar(UserItem.AddPoint, SizeOf(TValue), 0);
      end;
    end;
  end;

  if Assigned(g_SellOff.OnStart) then g_SellOff.OnStart(Self, g_Storage.m_ItemList.Count, '正在修改，请稍候...');
  for I := 0 to g_SellOff.m_ItemList.Count - 1 do begin
    if g_boSoftClose then Break;
    if Assigned(g_SellOff.OnProgress) then g_SellOff.OnProgress(Self, I + 1,  '');
    Application.ProcessMessages;
    SellOffInfo := pTSellOffInfo(g_SellOff.m_ItemList.Objects[I]);
    UserItem := @SellOffInfo.UserItem;
    if (UserItem.wIndex > 0) and (UserItem.wIndex = nOldID) then begin
      UserItem.wIndex := nNewID;
      if not CheckBoxItemReserve.Checked then begin
        FillChar(UserItem.btValue, SizeOf(TValue), 0);
        FillChar(UserItem.btValue2, SizeOf(TValue), 0);
        FillChar(UserItem.AddValue, SizeOf(TValue), 0);
        FillChar(UserItem.AddPoint, SizeOf(TValue), 0);
      end;
    end;
  end;

  if Assigned(g_FileDB.OnStop) then g_FileDB.OnStop(Self, 0, '修改完成');

  RzPanel.Enabled := True;
  Application.MessageBox('修改完成！', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmOtherOption.ButtonChgMagicIDClick(Sender: TObject);
var
  nOldID, nNewID: Integer;
  I, II, III: Integer;
  HumDataInfo: pTHumDataInfo;
  HumData: pTHumData;
  HumMagics: pTHumMagics;
  HumMagic: pTHumMagic;
begin
  nOldID := EditMagicIDOld.Value;
  nNewID := EditMagicIDNew.Value;

  if (nOldID = nNewID) or (nOldID <= 0) or (nNewID <= 0) then begin
    Application.MessageBox('魔法代码设置有误！', '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  RzPanel.Enabled := False;

  if Assigned(g_FileDB.OnStart) then g_FileDB.OnStart(Self, g_FileDB.m_MirCharNameList.Count, '正在修改，请稍候...');

  for I := 0 to g_FileDB.m_MirCharNameList.Count - 1 do begin
    if g_boSoftClose then Break;
    if Assigned(g_FileDB.OnProgress) then g_FileDB.OnProgress(Self, I + 1, '');
    Application.ProcessMessages;
    HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[I]);
    HumData := @HumDataInfo.Data;
    for II := Low(HumData.HumMagics) to High(HumData.HumMagics) do begin
      HumMagic := @HumData.HumMagics[II];
      if (HumMagic.wMagIdx > 0) and (HumMagic.wMagIdx = nOldID) then begin
        HumMagic.wMagIdx := nNewID;
        if not CheckBoxMagicReserve.Checked then begin
          HumMagic.btLevel := 0;
          HumMagic.btKey := 0;
          HumMagic.nTranPoint := 0;
        end;
      end;
    end;
  end;
  if Assigned(g_FileDB.OnStop) then g_FileDB.OnStop(Self, 0, '修改完成');

  RzPanel.Enabled := True;
  Application.MessageBox('修改完成！', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmOtherOption.ButtonDelItemClick(Sender: TObject);
var
  nItemID: Integer;
  I, II, III, nIndex: Integer;
  HumDataInfo: pTHumDataInfo;
  SellOffInfo: pTSellOffInfo;
  BigStorage: pTBigStorage;
  HumData: pTHumData;

  UserItem: pTUserItem;

begin
  nIndex := ComboBoxDelItem.ItemIndex;
  nItemID := EditDelItemID.Value + 1;
  if (nIndex < 0) then begin
    Application.MessageBox('请选择删除物品的操作方式！', '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  if (nIndex = 0) and (nItemID <= 0) then begin
    Application.MessageBox('物品代码设置有误！', '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  RzPanel.Enabled := False;

  if Assigned(g_FileDB.OnStart) then g_FileDB.OnStart(Self, g_FileDB.m_MirCharNameList.Count, '正在删除，请稍候...');

  for I := 0 to g_FileDB.m_MirCharNameList.Count - 1 do begin
    if g_boSoftClose then Break;
    if Assigned(g_FileDB.OnProgress) then g_FileDB.OnProgress(Self, I + 1,  '');
    Application.ProcessMessages;
    HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[I]);
    HumData := @HumDataInfo.Data;
    for II := Low(HumData.HumItems) to High(HumData.HumItems) do begin
      UserItem := @HumData.HumItems[II];
      if (UserItem.wIndex > 0) then begin
        case nIndex of
          0: begin
              if UserItem.wIndex = nItemID then UserItem.wIndex := 0;
            end;
          1, 2: UserItem.wIndex := 0;
        end;
      end;
    end;
    for II := Low(HumData.HumAddItems) to High(HumData.HumAddItems) do begin
      UserItem := @HumData.HumAddItems[II];
      if (UserItem.wIndex > 0) then begin
        case nIndex of
          0: begin
              if UserItem.wIndex = nItemID then UserItem.wIndex := 0;
            end;
          1, 2: UserItem.wIndex := 0;
        end;
      end;
    end;
    for II := Low(HumData.BagItems) to High(HumData.BagItems) do begin
      UserItem := @HumData.BagItems[II];
      if (UserItem.wIndex > 0) then begin
        case nIndex of
          0: begin
              if UserItem.wIndex = nItemID then UserItem.wIndex := 0;
            end;
          1, 3: UserItem.wIndex := 0;
        end;
      end;
    end;
    for II := Low(HumData.StorageItems) to High(HumData.StorageItems) do begin
      UserItem := @HumData.StorageItems[II];
      if (UserItem.wIndex > 0) then begin
        case nIndex of
          0: begin
              if UserItem.wIndex = nItemID then UserItem.wIndex := 0;
            end;
          1, 4: UserItem.wIndex := 0;
        end;
      end;
    end;
  end;
  if Assigned(g_FileDB.OnStop) then g_FileDB.OnStop(Self, 0,
      '删除完成');

  RzPanel.Enabled := True;
  Application.MessageBox('删除完成！', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmOtherOption.ButtonDelMagicClick(Sender: TObject);
var
  nMagicID: Integer;
  I, II, nIndex: Integer;
  HumDataInfo: pTHumDataInfo;
  HumData: pTHumData;
  HumMagics: pTHumMagics;
  HumMagic: pTHumMagic;
begin
  nIndex := ComboBoxDelMagic.ItemIndex;
  nMagicID := EditDelMagicID.Value;
  if (nIndex < 0) then begin
    Application.MessageBox('请选择删除魔法的操作方式！', '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  if (nIndex = 0) and (nMagicID <= 0) then begin
    Application.MessageBox('魔法代码设置有误！', '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  RzPanel.Enabled := False;

  if Assigned(g_FileDB.OnStart) then g_FileDB.OnStart(Self, g_FileDB.m_MirCharNameList.Count, '正在删除，请稍候...');

  for I := 0 to g_FileDB.m_MirCharNameList.Count - 1 do begin
    if g_boSoftClose then Break;
    if Assigned(g_FileDB.OnProgress) then g_FileDB.OnProgress(Self, I + 1,  '');
    Application.ProcessMessages;
    HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[I]);
    case nIndex of
      0: begin
          HumData := @HumDataInfo.Data;
          for II := Low(HumData.HumMagics) to High(HumData.HumMagics) do begin
          //for II in HumData.HumMagics  do begin
            HumMagic := @HumData.HumMagics[II];
            //if (HumMagic.wMagIdx = nMagicID) then FillChar(HumMagic,  SizeOf(THumMagic), #0);
            if (HumMagic.wMagIdx = nMagicID) then  HumMagic^.wMagIdx :=0;
          end;
        end;
        1:begin
          FillChar(HumDataInfo.Data.HumMagics, SizeOf(THumMagic), #0);
        end;
    end;
  end;
  if Assigned(g_FileDB.OnStop) then g_FileDB.OnStop(Self, 0, '删除完成');
  RzPanel.Enabled := True;
  Application.MessageBox('删除完成！', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmOtherOption.ButtonChgLevelClick(Sender: TObject);
var
  nLevel: Integer;
  I, II, nIndex: Integer;
  HumDataInfo: pTHumDataInfo;
begin
  nIndex := ComboBoxLevel.ItemIndex;
  nLevel := EditLevel.Value;
  if (nIndex < 0) then begin
    Application.MessageBox('请选择修改等级的方式！', '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  if (nIndex in [0, 1]) and (nLevel <= 0) then begin
    Application.MessageBox('等级设置有误！', '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  RzPanel.Enabled := False;

  if Assigned(g_FileDB.OnStart) then g_FileDB.OnStart(Self, g_FileDB.m_MirCharNameList.Count, '正在修改，请稍候...');

  for I := 0 to g_FileDB.m_MirCharNameList.Count - 1 do begin
    if g_boSoftClose then Break;
    if Assigned(g_FileDB.OnProgress) then g_FileDB.OnProgress(Self, I + 1,  '');
    Application.ProcessMessages;
    HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[I]);
    case nIndex of
      0: HumDataInfo.Data.Abil.Level := _MIN(HumDataInfo.Data.Abil.Level + nLevel, 65535);
      1: HumDataInfo.Data.Abil.Level := _MAX(HumDataInfo.Data.Abil.Level - nLevel, 0);
      2: HumDataInfo.Data.Abil.Level := nLevel;
    end;
  end;
  if Assigned(g_FileDB.OnStop) then g_FileDB.OnStop(Self, 0, '修改完成');

  RzPanel.Enabled := True;
  Application.MessageBox('修改完成！', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmOtherOption.ButtonChgGoldClick(Sender: TObject);
var
  nGold: Integer;
  I, II, nIndex: Integer;
  HumDataInfo: pTHumDataInfo;
begin
  nIndex := ComboBoxGold.ItemIndex;
  nGold := EditGold.Value;
  if (nIndex < 0) then begin
    Application.MessageBox('请选择修改金币的方式！', '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  if (nIndex in [0, 1]) and (nGold <= 0) then begin
    Application.MessageBox('金币设置有误！', '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  RzPanel.Enabled := False;

  if Assigned(g_FileDB.OnStart) then g_FileDB.OnStart(Self, g_FileDB.m_MirCharNameList.Count, '正在修改，请稍候...');

  for I := 0 to g_FileDB.m_MirCharNameList.Count - 1 do begin
    if g_boSoftClose then Break;
    if Assigned(g_FileDB.OnProgress) then g_FileDB.OnProgress(Self, I + 1, '');
    Application.ProcessMessages;
    HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[I]);
    case nIndex of
      0: HumDataInfo.Data.nGold := nGold + HumDataInfo.Data.nGold;
      1: HumDataInfo.Data.nGold := HumDataInfo.Data.nGold - nGold;
      2: HumDataInfo.Data.nGold := nGold;
    end;
  end;
  if Assigned(g_FileDB.OnStop) then g_FileDB.OnStop(Self, 0, '修改完成');

  RzPanel.Enabled := True;
  Application.MessageBox('修改完成！', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmOtherOption.ButtonChgPKClick(Sender: TObject);
var
  nPK: Integer;
  I, II, nIndex: Integer;
  HumDataInfo: pTHumDataInfo;
begin
  nIndex := ComboBoxPK.ItemIndex;
  nPK := EditPK.Value;
  if (nIndex < 0) then begin
    Application.MessageBox('请选择修改PK值的方式！', '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  if (nIndex in [0, 1]) and (nPK <= 0) then begin
    Application.MessageBox('PK值设置有误！', '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  RzPanel.Enabled := False;

  if Assigned(g_FileDB.OnStart) then g_FileDB.OnStart(Self, g_FileDB.m_MirCharNameList.Count, '正在修改，请稍候...');

  for I := 0 to g_FileDB.m_MirCharNameList.Count - 1 do begin
    if g_boSoftClose then Break;
    if Assigned(g_FileDB.OnProgress) then g_FileDB.OnProgress(Self, I + 1, '');
    Application.ProcessMessages;
    HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[I]);
    case nIndex of
      0: HumDataInfo.Data.nPKPOINT := nPK + HumDataInfo.Data.nPKPOINT;
      1: HumDataInfo.Data.nPKPOINT := HumDataInfo.Data.nPKPOINT - nPK;
      2: HumDataInfo.Data.nPKPOINT := nPK;
    end;
  end;
  if Assigned(g_FileDB.OnStop) then g_FileDB.OnStop(Self, 0, '修改完成');

  RzPanel.Enabled := True;
  Application.MessageBox('修改完成！', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

end.

