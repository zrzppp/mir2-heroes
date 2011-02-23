unit DataClear;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, Mask, RzEdit, RzSpnEdt, RzRadChk, RzLabel,
  RzPanel, ExtCtrls, Spin;

type
  TfrmDataClear = class(TFrame)
    RzPanel11: TPanel;
    RzGroupBox2: TRzGroupBox;
    RzPanel6: TPanel;
    RzGroupBox1: TRzGroupBox;
    Panel_Clear: TPanel;
    Label1: TLabel;
    RzButton2: TButton;
    Button_Clear_Data: TButton;
    RzButtonReviseCreateHeroFail: TButton;
    CheckBox_Clear_Hum_DelChr1: TCheckBox;
    CheckBox_Clear_Hum_DelChr2: TCheckBox;
    CheckBox_Clear_ID_DelID1: TCheckBox;
    CheckBox_Clear_ID_DelID2: TCheckBox;
    CheckBox_Clear_Hum_DelChr3: TCheckBox;
    Edit_Clear_Hum_Day: TSpinEdit;
    Edit_Clear_Hum_Level: TSpinEdit;
    Edit_Clear_ID_Day: TSpinEdit;
    RzLabel1: TLabel;
    RzLabel2: TLabel;
    RzLabel4: TLabel;
    RzLabel31: TLabel;
    RzLabel32: TLabel;
    procedure Button_Clear_DataClick(Sender: TObject);
    procedure RzButtonReviseCreateHeroFailClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Init;
  end;

var
  frmDataClear: TfrmDataClear;

implementation
uses Share, ObjBase, HUtil32, Grobal2, HumDB, IDDB;
{$R *.dfm}

procedure TfrmDataClear.Init;
begin
//{$IFDEF VCL70_OR_HIGHER}
  ParentBackground := False;
//{$ENDIF}
end;

procedure TfrmDataClear.Button_Clear_DataClick(Sender: TObject);
var
  I, II, III, IIII, nIndex, n1C: Integer;
  HumDataInfo: pTHumDataInfo;
  HumInfo: pTHumInfo;
  AccountDBRecord: pTAccountDBRecord;
  ChrList: TList;
begin
  Panel_Clear.Enabled := False;
 { ListView_Search_CopyItem.Items.BeginUpdate;
  try
    ListView_Search_CopyItem.Clear;
  finally
    ListView_Search_CopyItem.Items.EndUpdate;
  end; }
  if Assigned(g_FileIDDB.OnStart) then g_FileIDDB.OnStart(Self, g_FileIDDB.m_IDDBList.Count, '正在清理，请稍候...');
  n1C := 0;
  for I := g_FileIDDB.m_IDDBList.Count - 1 downto 0 do begin
    if g_boSoftClose then Break;
    Inc(n1C);
    if Assigned(g_FileIDDB.OnProgress) then g_FileIDDB.OnProgress(Self, n1C, '');
    Application.ProcessMessages;
    AccountDBRecord := pTAccountDBRecord(g_FileIDDB.m_IDDBList.Objects[I]);
    if CheckBox_Clear_ID_DelID2.Checked then begin
      if g_FileHumDB.m_HumDBList.GetList(g_FileIDDB.m_IDDBList.Strings[I], ChrList) < 0 then begin
        g_FileIDDB.m_IDDBList.Delete(I);
        Dispose(AccountDBRecord);
        Continue;
      end;
    end;
    if CheckBox_Clear_ID_DelID1.Checked then begin
      if (GetDayCount(Now, AccountDBRecord.Header.UpdateDate) >= Edit_Clear_ID_Day.Value) then begin
        g_FileIDDB.m_IDDBList.Delete(I);
        Dispose(AccountDBRecord);
        Continue;
      end;
    end;
  end;

  g_FileIDDB.m_IDDBList.SortString(0, g_FileIDDB.m_IDDBList.Count - 1);
  g_FileHumDB.m_HumDBList.SortString(0, g_FileHumDB.m_HumDBList.Count - 1);
  g_FileHumDB.m_HumCharNameList.SortString(0, g_FileHumDB.m_HumCharNameList.Count - 1);
  g_FileDB.m_MirDBList.SortString(0, g_FileDB.m_MirDBList.Count - 1);
  g_FileDB.m_MirCharNameList.SortString(0, g_FileDB.m_MirCharNameList.Count - 1);


  n1C := 0;
  if Assigned(g_FileHumDB.OnStart) then g_FileHumDB.OnStart(Self, g_FileHumDB.m_HumCharNameList.Count, '正在清理，请稍候...');
  for I := g_FileHumDB.m_HumCharNameList.Count - 1 downto 0 do begin
    if g_boSoftClose then Break;
    if Assigned(g_FileHumDB.OnProgress) then g_FileHumDB.OnProgress(Self, n1C,
        '');
    Application.ProcessMessages;
    HumInfo := pTHumInfo(g_FileHumDB.m_HumCharNameList.Objects[I]);
    if g_FileIDDB.m_IDDBList.GetIndex(HumInfo.sAccount) < 0 then begin

      if HumInfo.boIsHero then begin
        for II := 0 to g_FileDB.m_MirCharNameList.Count - 1 do begin
          if g_boSoftClose then Break;
          HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[II]);
          if HumDataInfo.data.sHeroChrName = HumInfo.sChrName then begin
            HumDataInfo.data.sHeroChrName := '';
            HumDataInfo.data.boHasHero := False;
            Break;
          end;
        end;
      end;

      nIndex := g_FileDB.m_MirCharNameList.GetIndex(HumInfo.sChrName);
      if nIndex >= 0 then begin
        HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[nIndex]);
        g_FileDB.Delete(HumDataInfo);
        Dispose(HumDataInfo);
      end;

      if not HumInfo.boIsHero then begin
        g_SellOff.Delete(HumInfo.sChrName);
        g_Storage.Delete(HumInfo.sChrName);
      end;

      g_FileHumDB.Delete(HumInfo);
      Dispose(HumInfo);
      Continue;
    end;

    if CheckBox_Clear_Hum_DelChr2.Checked then begin
      if HumInfo.boDeleted or (HumInfo.Header.sName = '') then begin
        nIndex := g_FileDB.m_MirCharNameList.GetIndex(HumInfo.sChrName);

        if HumInfo.boIsHero then begin
          for II := 0 to g_FileDB.m_MirCharNameList.Count - 1 do begin
            if g_boSoftClose then Break;
            HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[II]);
            if HumDataInfo.data.sHeroChrName = HumInfo.sChrName then begin
              HumDataInfo.data.sHeroChrName := '';
              HumDataInfo.data.boHasHero := False;
              Break;
            end;
          end;
        end;

        if nIndex >= 0 then begin
          HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[nIndex]);
          g_FileDB.Delete(HumDataInfo);
          Dispose(HumDataInfo);
        end;

        if not HumInfo.boIsHero then begin
          g_SellOff.Delete(HumInfo.sChrName);
          g_Storage.Delete(HumInfo.sChrName);
        end;

        g_FileHumDB.Delete(HumInfo);
        Dispose(HumInfo);
        Continue;
      end;
    end;

    if CheckBox_Clear_Hum_DelChr1.Checked then begin
      if (GetDayCount(Now, HumInfo.Header.dCreateDate) >= Edit_Clear_Hum_Day.Value) then begin
        nIndex := g_FileDB.m_MirCharNameList.GetIndex(HumInfo.sChrName);
        if nIndex >= 0 then begin
          HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[nIndex]);
          if (HumDataInfo.data.Abil.Level <= Edit_Clear_Hum_Level.Value) then begin
            if HumInfo.boIsHero then begin
              for II := 0 to g_FileDB.m_MirCharNameList.Count - 1 do begin
                if g_boSoftClose then Break;
                HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[II]);
                if HumDataInfo.data.sHeroChrName = HumInfo.sChrName then begin
                  HumDataInfo.data.sHeroChrName := '';
                  HumDataInfo.data.boHasHero := False;
                  Break;
                end;
              end;
            end;

            g_FileDB.Delete(HumDataInfo);
            Dispose(HumDataInfo);

            if not HumInfo.boIsHero then begin
              g_SellOff.Delete(HumInfo.sChrName);
              g_Storage.Delete(HumInfo.sChrName);
            end;

            g_FileHumDB.Delete(HumInfo);
            Dispose(HumInfo);
            Continue;
          end;
        end;
      end;
    end;

    if CheckBox_Clear_Hum_DelChr3.Checked then begin
      if g_FileDB.m_MirCharNameList.GetIndex(HumInfo.sChrName) < 0 then begin

        if HumInfo.boIsHero then begin
          for II := 0 to g_FileDB.m_MirCharNameList.Count - 1 do begin
            if g_boSoftClose then Break;
            HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[II]);
            if HumDataInfo.data.sHeroChrName = HumInfo.sChrName then begin
              HumDataInfo.data.sHeroChrName := '';
              HumDataInfo.data.boHasHero := False;
              Break;
            end;
          end;
        end;

        if not HumInfo.boIsHero then begin
          g_SellOff.Delete(HumInfo.sChrName);
          g_Storage.Delete(HumInfo.sChrName);
        end;

        g_FileHumDB.Delete(HumInfo);
        Dispose(HumInfo);
      end;
    end;
  end;

  g_FileIDDB.m_IDDBList.SortString(0, g_FileIDDB.m_IDDBList.Count - 1);
  g_FileHumDB.m_HumDBList.SortString(0, g_FileHumDB.m_HumDBList.Count - 1);
  g_FileHumDB.m_HumCharNameList.SortString(0, g_FileHumDB.m_HumCharNameList.Count - 1);
  g_FileDB.m_MirDBList.SortString(0, g_FileDB.m_MirDBList.Count - 1);
  g_FileDB.m_MirCharNameList.SortString(0, g_FileDB.m_MirCharNameList.Count - 1);

  g_SellOff.m_SellOffList.SortString(0, g_SellOff.m_SellOffList.Count - 1);
  g_SellOff.m_ItemList.SortString(0, g_SellOff.m_ItemList.Count - 1);

  g_Storage.m_BigStorageList.SortString(0, g_Storage.m_BigStorageList.Count - 1);
  g_Storage.m_ItemList.SortString(0, g_Storage.m_ItemList.Count - 1);


  {StartProcess(g_FileDB.m_MirCharNameList.Count);
  for I := g_FileDB.m_MirCharNameList.Count - 1 downto 0 do begin
    ProcessStatus();
    Application.ProcessMessages;
    HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[I]);
    if CheckBox_Clear_Hum_DelChr2.Checked then begin
      if HumDataInfo.Header.boDeleted or (HumDataInfo.Header.sName = '') then begin
        g_FileDB.m_MirCharNameList.Delete(I);
        g_FileDB.Delete(HumDataInfo);
        Dispose(HumDataInfo);
        Continue;
      end;
    end;

    if CheckBox_Clear_Hum_DelChr1.Checked then begin
      if (GetDayCount(Now, HumDataInfo.Header.dCreateDate) >= Edit_Clear_Hum_Day.IntValue) and
        (HumDataInfo.Data.Abil.Level <= Edit_Clear_Hum_Level.IntValue) then begin
        g_FileDB.m_MirCharNameList.Delete(I);
        g_FileDB.Delete(HumDataInfo);
        Dispose(HumDataInfo);
        Continue;
      end;
    end;
  end;}

  for I := 0 to Length(g_StartProc) - 1 do begin
    TStartProc(g_StartProc[I])();
  end;

  ProcessMessage(Format('ID:%d Hum:%d Mir:%d', [g_FileIDDB.m_IDDBList.Count,
    g_FileHumDB.m_HumCharNameList.Count, g_FileDB.m_MirCharNameList.Count]), 1);

  Panel_Clear.Enabled := True;

  if Assigned(g_FileHumDB.OnStop) then g_FileHumDB.OnStop(Self, 0, '清理完成');
end;

procedure TfrmDataClear.RzButtonReviseCreateHeroFailClick(Sender: TObject);
var
  I, II, III, IIII, nIndex, nIndex1: Integer;
  HumDataInfo: pTHumDataInfo;
  HumInfo: pTHumInfo;
  AccountDBRecord: pTAccountDBRecord;
  ChrList: TList;
begin
  Panel_Clear.Enabled := False;

  if Assigned(g_FileDB.OnStart) then g_FileDB.OnStart(Self,
      g_FileDB.m_MirCharNameList.Count, '正在修复，请稍候...');
  //HumInfo := pTHumInfo(g_FileHumDB.m_HumCharNameList.Objects[I]);
  for I := g_FileDB.m_MirCharNameList.Count - 1 downto 0 do begin
    if Assigned(g_FileDB.OnProgress) then g_FileDB.OnProgress(Self, I + 1, '');
    Application.ProcessMessages;
    if g_boSoftClose then Break;
    HumDataInfo := pTHumDataInfo(g_FileDB.m_MirCharNameList.Objects[I]);
    if HumDataInfo.data.boHasHero then begin
      nIndex := g_FileDB.m_MirCharNameList.GetIndex(HumDataInfo.data.sHeroChrName);
      if nIndex < 0 then begin
        nIndex1 := g_FileHumDB.m_HumCharNameList.GetIndex(HumDataInfo.data.sHeroChrName);
        if nIndex1 >= 0 then begin
          HumInfo := pTHumInfo(g_FileHumDB.m_HumCharNameList.Objects[nIndex1]);
          Dispose(HumInfo);
          g_FileHumDB.m_HumCharNameList.Delete(nIndex1);
        end;
        HumDataInfo.data.sHeroChrName := '';
        HumDataInfo.data.boHasHero := False;
      end;
    end else
      if HumDataInfo.data.boIsHero then begin
      nIndex := g_FileDB.m_MirCharNameList.GetIndex(HumDataInfo.data.sMasterName);
      if nIndex < 0 then begin
        nIndex1 := g_FileHumDB.m_HumCharNameList.GetIndex(HumDataInfo.data.sChrName);
        if nIndex1 >= 0 then begin
          HumInfo := pTHumInfo(g_FileHumDB.m_HumCharNameList.Objects[nIndex1]);
          Dispose(HumInfo);
          g_FileHumDB.m_HumCharNameList.Delete(nIndex1);
        end;
        Dispose(HumDataInfo);
        g_FileDB.m_MirCharNameList.Delete(I);
      end;
    end;
  end;

  for I := 0 to Length(g_StartProc) - 1 do begin
    TStartProc(g_StartProc[I])();
  end;

  Panel_Clear.Enabled := True;
  if Assigned(g_FileDB.OnStop) then g_FileDB.OnStop(Self, 0, '修复完成');
end;

end.

