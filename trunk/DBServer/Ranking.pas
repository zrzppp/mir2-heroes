unit Ranking;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ComCtrls, IniFiles, Main, DBShare, Grobal2;

type
  TFrmRankingDlg = class(TForm)
    GroupBox1: TGroupBox;
    CheckBoxAutoRefRanking: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    EditMinLevel: TSpinEdit;
    EditMaxLevel: TSpinEdit;
    Label3: TLabel;
    Label4: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    EditTime: TSpinEdit;
    EditHour: TSpinEdit;
    Label5: TLabel;
    Label6: TLabel;
    EditMinute1: TSpinEdit;
    EditMinute2: TSpinEdit;
    Label7: TLabel;
    Label8: TLabel;
    ButtonSave: TButton;
    ButtonRefRanking: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet10: TTabSheet;
    PageControl3: TPageControl;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheet11: TTabSheet;
    ListViewHum: TListView;
    ListViewWarrior: TListView;
    ListViewWizzard: TListView;
    ListViewMonk: TListView;
    ListViewHero: TListView;
    ListViewHeroWarrior: TListView;
    ListViewHeroWizzard: TListView;
    ListViewHeroMonk: TListView;
    ListViewMaster: TListView;
    procedure ButtonRefRankingClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure CheckBoxAutoRefRankingClick(Sender: TObject);
    procedure EditMinLevelChange(Sender: TObject);
    procedure EditMaxLevelChange(Sender: TObject);
    procedure EditTimeChange(Sender: TObject);
    procedure EditHourChange(Sender: TObject);
    procedure EditMinute1Change(Sender: TObject);
    procedure EditMinute2Change(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure RefRanking;
  public
    { Public declarations }
    procedure Open;
  end;

var
  FrmRankingDlg: TFrmRankingDlg;

implementation

{$R *.dfm}

procedure TFrmRankingDlg.Open;
begin
  CheckBoxAutoRefRanking.Checked := g_boAutoRefRanking;
  EditMinLevel.Value := g_nRankingMinLevel;
  EditMaxLevel.Value := g_nRankingMaxLevel;
  EditTime.Value := g_nRefRankingHour1;
  EditHour.Value := g_nRefRankingHour2;
  EditMinute1.Value := g_nRefRankingMinute1;
  EditMinute2.Value := g_nRefRankingMinute2;
  if g_nAutoRefRankingType = 0 then RadioButton1.Checked := True;
  if g_nAutoRefRankingType = 1 then RadioButton2.Checked := True;
  //RadioButton2.Checked:= Boolean(g_nAutoRefRankingType);
  ButtonSave.Enabled := False;
  RefRanking;
  Self.ShowModal;
end;

procedure TFrmRankingDlg.RefRanking;
var
  I: Integer;
  ListItem: TListItem;
  HumRanking: pTUserLevelRanking;
  HeroRanking: pTHeroLevelRanking;
  MasterRanking: pTUserMasterRanking;
begin
  ListViewHum.Clear;
  ListViewWarrior.Clear;
  ListViewWizzard.Clear;
  ListViewMonk.Clear;
  ListViewHero.Clear;
  ListViewHeroWarrior.Clear;
  ListViewHeroWizzard.Clear;
  ListViewHeroMonk.Clear;
  ListViewMaster.Clear;

  EnterCriticalSection(g_Ranking_CS);
  try
    for I := 0 to g_HumRanking.Count - 1 do begin
      HumRanking := pTUserLevelRanking(g_HumRanking.Objects[I]);
      ListItem := ListViewHum.Items.Add;
      ListItem.Caption := IntToStr(I);
      ListItem.SubItems.AddObject(HumRanking.sChrName, TObject(HumRanking));
      ListItem.SubItems.Add(IntToStr(HumRanking.nLevel));
    end;
    for I := 0 to g_WarriorRanking.Count - 1 do begin
      HumRanking := pTUserLevelRanking(g_WarriorRanking.Objects[I]);
      ListItem := ListViewWarrior.Items.Add;
      ListItem.Caption := IntToStr(I);
      ListItem.SubItems.AddObject(HumRanking.sChrName, TObject(HumRanking));
      ListItem.SubItems.Add(IntToStr(HumRanking.nLevel));
    end;
    for I := 0 to g_WizzardRanking.Count - 1 do begin
      HumRanking := pTUserLevelRanking(g_WizzardRanking.Objects[I]);
      ListItem := ListViewWizzard.Items.Add;
      ListItem.Caption := IntToStr(I);
      ListItem.SubItems.AddObject(HumRanking.sChrName, TObject(HumRanking));
      ListItem.SubItems.Add(IntToStr(HumRanking.nLevel));
    end;
    for I := 0 to g_MonkRanking.Count - 1 do begin
      HumRanking := pTUserLevelRanking(g_MonkRanking.Objects[I]);
      ListItem := ListViewMonk.Items.Add;
      ListItem.Caption := IntToStr(I);
      ListItem.SubItems.AddObject(HumRanking.sChrName, TObject(HumRanking));
      ListItem.SubItems.Add(IntToStr(HumRanking.nLevel));
    end;

    for I := 0 to g_HeroRanking.Count - 1 do begin
      HeroRanking := pTHeroLevelRanking(g_HeroRanking.Objects[I]);
      ListItem := ListViewHero.Items.Add;
      ListItem.Caption := IntToStr(I);
      ListItem.SubItems.AddObject(HeroRanking.sHeroName, TObject(HeroRanking));
      ListItem.SubItems.Add(HeroRanking.sChrName);
      ListItem.SubItems.Add(IntToStr(HeroRanking.nLevel));
    end;

    for I := 0 to g_HeroWarriorRanking.Count - 1 do begin
      HeroRanking := pTHeroLevelRanking(g_HeroWarriorRanking.Objects[I]);
      ListItem := ListViewHeroWarrior.Items.Add;
      ListItem.Caption := IntToStr(I);
      ListItem.SubItems.AddObject(HeroRanking.sHeroName, TObject(HeroRanking));
      ListItem.SubItems.Add(HeroRanking.sChrName);
      ListItem.SubItems.Add(IntToStr(HeroRanking.nLevel));
    end;

    for I := 0 to g_HeroWizzardRanking.Count - 1 do begin
      HeroRanking := pTHeroLevelRanking(g_HeroWizzardRanking.Objects[I]);
      ListItem := ListViewHeroWizzard.Items.Add;
      ListItem.Caption := IntToStr(I);
      ListItem.SubItems.AddObject(HeroRanking.sHeroName, TObject(HeroRanking));
      ListItem.SubItems.Add(HeroRanking.sChrName);
      ListItem.SubItems.Add(IntToStr(HeroRanking.nLevel));
    end;

    for I := 0 to g_HeroMonkRanking.Count - 1 do begin
      HeroRanking := pTHeroLevelRanking(g_HeroMonkRanking.Objects[I]);
      ListItem := ListViewHeroMonk.Items.Add;
      ListItem.Caption := IntToStr(I);
      ListItem.SubItems.AddObject(HeroRanking.sHeroName, TObject(HeroRanking));
      ListItem.SubItems.Add(HeroRanking.sChrName);
      ListItem.SubItems.Add(IntToStr(HeroRanking.nLevel));
    end;


    for I := 0 to g_MasterRanking.Count - 1 do begin
      MasterRanking := pTUserMasterRanking(g_MasterRanking.Objects[I]);
      ListItem := ListViewMaster.Items.Add;
      ListItem.Caption := IntToStr(I);
      ListItem.SubItems.AddObject(MasterRanking.sChrName, TObject(MasterRanking));
      ListItem.SubItems.Add(IntToStr(MasterRanking.nMasterCount));
    end;

  finally
    LeaveCriticalSection(g_Ranking_CS);
  end;
end;

procedure TFrmRankingDlg.ButtonRefRankingClick(Sender: TObject);
begin
  ButtonRefRanking.Enabled := False;
  g_dwAutoRefRankingTick := GetTickCount;
  //FrmMain.RefRanking;
  RefRanking;
  ButtonRefRanking.Enabled := True;
end;

procedure TFrmRankingDlg.ButtonSaveClick(Sender: TObject);
var
  Conf: TIniFile;
  LoadInteger: Integer;
begin
  Conf := TIniFile.Create(g_sConfFileName);
  if Conf <> nil then begin
    Conf.WriteBool('Setup', 'AutoRefRanking', g_boAutoRefRanking);
    Conf.WriteInteger('Setup', 'RankingMinLevel', g_nRankingMinLevel);
    Conf.WriteInteger('Setup', 'RankingMaxLevel', g_nRankingMaxLevel);
    Conf.WriteInteger('Setup', 'RefRankingHour1', g_nRefRankingHour1);
    Conf.WriteInteger('Setup', 'RefRankingHour2', g_nRefRankingHour2);

    Conf.WriteInteger('Setup', 'RefRankingMinute1', g_nRefRankingMinute1);
    Conf.WriteInteger('Setup', 'RefRankingMinute2', g_nRefRankingMinute2);

    Conf.WriteInteger('Setup', 'AutoRefRankingType', g_nAutoRefRankingType);
  end;
  Conf.Free;
  ButtonSave.Enabled := False;
end;

procedure TFrmRankingDlg.CheckBoxAutoRefRankingClick(Sender: TObject);
begin
  g_boAutoRefRanking := CheckBoxAutoRefRanking.Checked;
  ButtonSave.Enabled := True;
end;

procedure TFrmRankingDlg.EditMinLevelChange(Sender: TObject);
begin
  g_nRankingMinLevel := EditMinLevel.Value;
  ButtonSave.Enabled := True;
end;

procedure TFrmRankingDlg.EditMaxLevelChange(Sender: TObject);
begin
  g_nRankingMaxLevel := EditMaxLevel.Value;
  ButtonSave.Enabled := True;
end;

procedure TFrmRankingDlg.EditTimeChange(Sender: TObject);
begin
  g_nRefRankingHour1 := EditTime.Value;
  ButtonSave.Enabled := True;
end;

procedure TFrmRankingDlg.EditHourChange(Sender: TObject);
begin
  g_nRefRankingHour2 := EditHour.Value;
  ButtonSave.Enabled := True;
end;

procedure TFrmRankingDlg.EditMinute1Change(Sender: TObject);
begin
  g_nRefRankingMinute1 := EditMinute1.Value;
  ButtonSave.Enabled := True;
end;

procedure TFrmRankingDlg.EditMinute2Change(Sender: TObject);
begin
  g_nRefRankingMinute2 := EditMinute2.Value;
  ButtonSave.Enabled := True;
end;

procedure TFrmRankingDlg.RadioButton1Click(Sender: TObject);
begin
  if RadioButton1.Checked then g_nAutoRefRankingType := 0 else g_nAutoRefRankingType := 1;
  ButtonSave.Enabled := True;
end;

procedure TFrmRankingDlg.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 0;
end;

end.
