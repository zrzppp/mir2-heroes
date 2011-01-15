unit HeroConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Spin, Grids, Grobal2;

type
  TLevelExpScheme = (s_None, s_OldLevelExp, s_StdLevelExp, s_2Mult, s_5Mult, s_8Mult, s_10Mult, s_20Mult, s_30Mult, s_40Mult, s_50Mult, s_60Mult, s_70Mult, s_80Mult, s_90Mult, s_100Mult, s_150Mult, s_200Mult, s_250Mult, s_300Mult);
  TfrmHeroConfig = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    GroupBoxLevelExp: TGroupBox;
    Label37: TLabel;
    ComboBoxLevelExp: TComboBox;
    GridLevelExp: TStringGrid;
    GroupBox8: TGroupBox;
    Label23: TLabel;
    EditKillMonExpRate: TSpinEdit;
    GroupBox29: TGroupBox;
    Label61: TLabel;
    EditStartLevel: TSpinEdit;
    GroupBox59: TGroupBox;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    SpinEditWarrorAttackTime: TSpinEdit;
    SpinEditWizardAttackTime: TSpinEdit;
    SpinEditTaoistAttackTime: TSpinEdit;
    ButtonHeroExpSave: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    SpinEditNeedLevel: TSpinEdit;
    ComboBoxBagItemCount: TComboBox;
    TabSheet2: TTabSheet;
    GroupBox67: TGroupBox;
    CheckBoxKillByMonstDropUseItem: TCheckBox;
    CheckBoxKillByHumanDropUseItem: TCheckBox;
    CheckBoxDieScatterBag: TCheckBox;
    CheckBoxDieRedScatterBagAll: TCheckBox;
    GroupBox69: TGroupBox;
    Label130: TLabel;
    Label2: TLabel;
    Label134: TLabel;
    ScrollBarDieDropUseItemRate: TScrollBar;
    EditDieDropUseItemRate: TEdit;
    ScrollBarDieRedDropUseItemRate: TScrollBar;
    EditDieRedDropUseItemRate: TEdit;
    ScrollBarDieScatterBagRate: TScrollBar;
    EditDieScatterBagRate: TEdit;
    ButtonHeroDieSave: TButton;
    GroupBox2: TGroupBox;
    Label124: TLabel;
    Label125: TLabel;
    SpinEditEatHPItemRate: TSpinEdit;
    SpinEditEatMPItemRate: TSpinEdit;
    Label126: TLabel;
    Label3: TLabel;
    TabSheet3: TTabSheet;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    EditMaxFirDragonPoint: TSpinEdit;
    Label5: TLabel;
    EditAddFirDragonPoint: TSpinEdit;
    Label6: TLabel;
    EditDecFirDragonPoint: TSpinEdit;
    ButtonHeroAttackSave: TButton;
    GroupBox52: TGroupBox;
    Label135: TLabel;
    EditSkill60Rate: TSpinEdit;
    Label7: TLabel;
    EditHeroNameColor: TSpinEdit;
    LabelHeroNameColor: TLabel;
    GroupBox6: TGroupBox;
    Label10: TLabel;
    EditSkill61Rate: TSpinEdit;
    GroupBox7: TGroupBox;
    Label11: TLabel;
    EditSkill62Rate: TSpinEdit;
    GroupBox9: TGroupBox;
    Label12: TLabel;
    EditSkill63Rate: TSpinEdit;
    GroupBox10: TGroupBox;
    Label13: TLabel;
    EditSkill64Rate: TSpinEdit;
    GroupBox11: TGroupBox;
    Label14: TLabel;
    EditSkill65Rate: TSpinEdit;
    Label15: TLabel;
    EditRecallHeroTime: TSpinEdit;
    EditRecallHeroHint: TEdit;
    GroupBox78: TGroupBox;
    CheckBoxHeroUseBagItem: TCheckBox;
    CheckBoxSafeNoAllowTargetBB: TCheckBox;
    GroupBox66: TGroupBox;
    EditHeroWarrorWalkTime: TSpinEdit;
    EditHeroWizardWalkTime: TSpinEdit;
    EditHeroTaoistWalkTime: TSpinEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label16: TLabel;
    procedure ComboBoxLevelExpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonHeroExpSaveClick(Sender: TObject);
    procedure EditStartLevelChange(Sender: TObject);
    procedure EditKillMonExpRateChange(Sender: TObject);
    procedure ComboBoxBagItemCountChange(Sender: TObject);
    procedure SpinEditNeedLevelChange(Sender: TObject);
    procedure SpinEditWarrorAttackTimeChange(Sender: TObject);
    procedure SpinEditWizardAttackTimeChange(Sender: TObject);
    procedure SpinEditTaoistAttackTimeChange(Sender: TObject);
    procedure ButtonHeroDieSaveClick(Sender: TObject);
    procedure CheckBoxKillByMonstDropUseItemClick(Sender: TObject);
    procedure CheckBoxKillByHumanDropUseItemClick(Sender: TObject);
    procedure CheckBoxDieScatterBagClick(Sender: TObject);
    procedure CheckBoxDieRedScatterBagAllClick(Sender: TObject);
    procedure ScrollBarDieDropUseItemRateChange(Sender: TObject);
    procedure ScrollBarDieRedDropUseItemRateChange(Sender: TObject);
    procedure ScrollBarDieScatterBagRateChange(Sender: TObject);
    procedure SpinEditEatHPItemRateChange(Sender: TObject);
    procedure SpinEditEatMPItemRateChange(Sender: TObject);
    procedure ButtonHeroAttackSaveClick(Sender: TObject);
    procedure EditMaxFirDragonPointChange(Sender: TObject);
    procedure EditAddFirDragonPointChange(Sender: TObject);
    procedure EditDecFirDragonPointChange(Sender: TObject);
    procedure EditSkill60RateChange(Sender: TObject);
    procedure EditHeroNameColorChange(Sender: TObject);
    procedure EditSkill61RateChange(Sender: TObject);
    procedure EditSkill62RateChange(Sender: TObject);
    procedure EditSkill63RateChange(Sender: TObject);
    procedure EditSkill64RateChange(Sender: TObject);
    procedure EditSkill65RateChange(Sender: TObject);
    procedure EditRecallHeroTimeChange(Sender: TObject);
    procedure EditRecallHeroHintChange(Sender: TObject);
    procedure CheckBoxHeroUseBagItemClick(Sender: TObject);
    procedure CheckBoxSafeNoAllowTargetBBClick(Sender: TObject);
    procedure EditHeroWarrorWalkTimeChange(Sender: TObject);
    procedure EditHeroWizardWalkTimeChange(Sender: TObject);
    procedure EditHeroTaoistWalkTimeChange(Sender: TObject);
  private
    { Private declarations }
    boOpened: Boolean;
    boModValued: Boolean;
    OldLevelExpScheme: TLevelExpScheme;
    procedure ModValue();
    procedure uModValue();
  public
    { Public declarations }
    procedure Open();
  end;

var
  frmHeroConfig: TfrmHeroConfig;

implementation
uses M2Share, HUtil32, SDK, ActionSpeedConfig;
{$R *.dfm}
var
  dwOldNeedExps: TLevelNeedExp;

procedure TfrmHeroConfig.ModValue();
begin
  boModValued := True;
  ButtonHeroExpSave.Enabled := True;
  ButtonHeroDieSave.Enabled := True;
  ButtonHeroAttackSave.Enabled := True;
end;

procedure TfrmHeroConfig.uModValue();
begin
  boModValued := False;
  ButtonHeroExpSave.Enabled := False;
  ButtonHeroDieSave.Enabled := False;
  ButtonHeroAttackSave.Enabled := False;
end;

procedure TfrmHeroConfig.ComboBoxLevelExpClick(Sender: TObject);
var
  I: Integer;
  LevelExpScheme: TLevelExpScheme;
  dwOneLevelExp: LongWord;
  dwExp: LongWord;
begin
  if not boOpened then Exit;
  if Application.MessageBox('升级经验计划设置的经验将立即生效，是否确认使用此经验计划？', '确认信息', MB_YESNO + MB_ICONQUESTION) = IDNO then begin
    Exit;
  end;

  LevelExpScheme := TLevelExpScheme(ComboBoxLevelExp.Items.Objects[ComboBoxLevelExp.ItemIndex]);
  case LevelExpScheme of
    s_OldLevelExp: g_Config.dwHeroNeedExps := g_dwOldNeedExps;
    s_StdLevelExp: begin
        g_Config.dwHeroNeedExps := g_dwOldNeedExps;
        dwOneLevelExp := 4000000000 div High(g_Config.dwHeroNeedExps);
        for I := 1 to MAXCHANGELEVEL do begin
          if (26 + I) > MAXCHANGELEVEL then Break;
          dwExp := dwOneLevelExp * LongWord(I);
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[26 + I] := dwExp;
        end;
      end;
    s_2Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 2;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_5Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 5;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_8Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 8;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_10Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 10;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_20Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 20;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_30Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 30;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_40Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 40;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_50Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 50;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_60Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 60;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_70Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 70;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_80Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 80;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_90Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 90;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_100Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 100;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_150Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 150;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_200Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 200;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_250Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 250;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_300Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 300;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
  end;
  for I := 1 to GridLevelExp.RowCount - 1 do begin
    GridLevelExp.Cells[1, I] := IntToStr(g_Config.dwHeroNeedExps[I]);
  end;
  ModValue();
end;

procedure TfrmHeroConfig.Open();
var
  I: Integer;
  s01: string;
begin
  boOpened := False;
  PageControl.ActivePageIndex := 0;
  uModValue();
  dwOldNeedExps := g_Config.dwHeroNeedExps;
  for I := 1 to GridLevelExp.RowCount - 1 do begin
    GridLevelExp.Cells[1, I] := IntToStr(g_Config.dwNeedExps[I]);
  end;

  GroupBoxLevelExp.Caption := Format('Experience Settings)', [g_Config.nMaxLevel]);

  EditStartLevel.Value := g_Config.nHeroStartLevel;
  EditKillMonExpRate.Value := g_Config.nHeroKillMonExpRate;
  ComboBoxBagItemCount.Items.Clear;

  for I := Low(g_Config.HeroBagItemCounts) to High(g_Config.HeroBagItemCounts) do begin
    case I of
      0: s01 := '10 Item';
      1: s01 := '20 Item';
      2: s01 := '30 Item';
      3: s01 := '35 Item';
      4: s01 := '40 Item';
    end;
    ComboBoxBagItemCount.Items.AddObject(s01, TObject(g_Config.HeroBagItemCounts[I]));
  end;


  SpinEditWarrorAttackTime.Value := g_Config.dwHeroWarrorAttackTime;
  SpinEditWizardAttackTime.Value := g_Config.dwHeroWizardAttackTime;
  SpinEditTaoistAttackTime.Value := g_Config.dwHeroTaoistAttackTime;

  EditHeroWarrorWalkTime.Value := g_Config.dwHeroWarrorWalkTime;
  EditHeroWizardWalkTime.Value := g_Config.dwHeroWizardWalkTime;
  EditHeroTaoistWalkTime.Value := g_Config.dwHeroTaoistWalkTime;

  CheckBoxKillByMonstDropUseItem.Checked := g_Config.boHeroKillByMonstDropUseItem;
  CheckBoxKillByHumanDropUseItem.Checked := g_Config.boHeroKillByHumanDropUseItem;
  CheckBoxDieScatterBag.Checked := g_Config.boHeroDieScatterBag;
  CheckBoxDieRedScatterBagAll.Checked := g_Config.boHeroDieRedScatterBagAll;

  ScrollBarDieDropUseItemRate.Min := 1;
  ScrollBarDieDropUseItemRate.Max := 200;
  ScrollBarDieDropUseItemRate.Position := g_Config.nHeroDieDropUseItemRate;
  ScrollBarDieRedDropUseItemRate.Min := 1;
  ScrollBarDieRedDropUseItemRate.Max := 200;
  ScrollBarDieRedDropUseItemRate.Position := g_Config.nHeroDieRedDropUseItemRate;
  ScrollBarDieScatterBagRate.Min := 1;
  ScrollBarDieScatterBagRate.Max := 200;
  ScrollBarDieScatterBagRate.Position := g_Config.nHeroDieScatterBagRate;

  SpinEditEatHPItemRate.Value := g_Config.nHeroAddHPRate;
  SpinEditEatMPItemRate.Value := g_Config.nHeroAddMPRate;

  ComboBoxBagItemCount.ItemIndex := -1;
  ComboBoxBagItemCount.Text := '选择包裹数';
  SpinEditNeedLevel.Value := 1;
  SpinEditNeedLevel.Enabled := False;
  EditMaxFirDragonPoint.Value := g_Config.nMaxAngryValue;
  EditAddFirDragonPoint.Value := g_Config.nAddAngryValue;
  EditDecFirDragonPoint.Value := g_Config.nDecAngryValue;
  EditSkill60Rate.Value := g_Config.nSkill60Rate;
  EditSkill61Rate.Value := g_Config.nSkill61Rate;
  EditSkill62Rate.Value := g_Config.nSkill62Rate;
  EditSkill63Rate.Value := g_Config.nSkill63Rate;
  EditSkill64Rate.Value := g_Config.nSkill64Rate;
  EditSkill65Rate.Value := g_Config.nSkill65Rate;
  EditHeroNameColor.Value := g_Config.btHeroNameColor;
  LabelHeroNameColor.Color := GetRGB(g_Config.btHeroNameColor);


  EditRecallHeroTime.Value := g_Config.nRecallHeroTime;
  EditRecallHeroHint.Text := g_Config.sRecallHeroHint;

  CheckBoxHeroUseBagItem.Checked := g_Config.boHeroUseBagItem;

  CheckBoxSafeNoAllowTargetBB.Checked := g_Config.boSafeNoAllowTargetBB;

  boOpened := True;
  ShowModal;
end;

procedure TfrmHeroConfig.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  GridLevelExp.ColWidths[0] := 30;
  GridLevelExp.ColWidths[1] := 100;
  GridLevelExp.Cells[0, 0] := 'Lvl';
  GridLevelExp.Cells[1, 0] := 'Exp';
  for I := 1 to GridLevelExp.RowCount - 1 do begin
    GridLevelExp.Cells[0, I] := IntToStr(I);
  end;

  ComboBoxLevelExp.AddItem('Old exp', TObject(s_OldLevelExp));
  ComboBoxLevelExp.AddItem('Standard exp', TObject(s_StdLevelExp));
  ComboBoxLevelExp.AddItem('1/2 Current exp', TObject(s_2Mult));
  ComboBoxLevelExp.AddItem('1/5 Current exp', TObject(s_5Mult));
  ComboBoxLevelExp.AddItem('1/8 Current exp', TObject(s_8Mult));
  ComboBoxLevelExp.AddItem('1/10 Current exp', TObject(s_10Mult));
  ComboBoxLevelExp.AddItem('1/20 Current exp', TObject(s_20Mult));
  ComboBoxLevelExp.AddItem('1/30 Current exp', TObject(s_30Mult));
  ComboBoxLevelExp.AddItem('1/40 Current exp', TObject(s_40Mult));
  ComboBoxLevelExp.AddItem('1/50 Current exp', TObject(s_50Mult));
  ComboBoxLevelExp.AddItem('1/60 Current exp', TObject(s_60Mult));
  ComboBoxLevelExp.AddItem('1/70 Current exp', TObject(s_70Mult));
  ComboBoxLevelExp.AddItem('1/80 Current exp', TObject(s_80Mult));
  ComboBoxLevelExp.AddItem('1/90 Current exp', TObject(s_90Mult));
  ComboBoxLevelExp.AddItem('1/100 Current exp', TObject(s_100Mult));
  ComboBoxLevelExp.AddItem('1/150 Current exp', TObject(s_150Mult));
  ComboBoxLevelExp.AddItem('1/200 Current exp', TObject(s_200Mult));
  ComboBoxLevelExp.AddItem('1/250 Current exp', TObject(s_250Mult));
  ComboBoxLevelExp.AddItem('1/300 current exp', TObject(s_300Mult));
  OldLevelExpScheme := s_None;
end;

procedure TfrmHeroConfig.ButtonHeroExpSaveClick(Sender: TObject);
var
  I: Integer;
  dwExp: LongWord;
  NeedExps: TLevelNeedExp;
  LevelExpScheme: TLevelExpScheme;
begin
  if ComboBoxLevelExp.ItemIndex >= 0 then
    LevelExpScheme := TLevelExpScheme(ComboBoxLevelExp.Items.Objects[ComboBoxLevelExp.ItemIndex])
  else LevelExpScheme := s_None;

  if OldLevelExpScheme <> LevelExpScheme then begin
    for I := 1 to GridLevelExp.RowCount - 1 do begin
      dwExp := Str_ToInt(GridLevelExp.Cells[1, I], 0);
      if (dwExp <= 0) or (dwExp > High(LongWord)) then begin
        Application.MessageBox(PChar('等级 ' + IntToStr(I) + ' 升级经验设置错误！！！'), '错误信息', MB_OK + MB_ICONERROR);
        GridLevelExp.Row := I;
        GridLevelExp.SetFocus;
        Exit;
      end;
      NeedExps[I] := dwExp;
    end;
    g_Config.dwHeroNeedExps := NeedExps;
  end;

  if OldLevelExpScheme <> LevelExpScheme then begin
    for I := 1 to 1000 do begin
      if dwOldNeedExps[I] <> g_Config.dwHeroNeedExps[I] then
        Config.WriteString('HeroExp', 'Level' + IntToStr(I), IntToStr(g_Config.dwHeroNeedExps[I]));
    end;
  end;
  Config.WriteInteger('HeroSetup', 'StartLevel', g_Config.nHeroStartLevel);
  Config.WriteInteger('HeroSetup', 'KillMonExpRate', g_Config.nHeroKillMonExpRate);

  for I := Low(g_Config.HeroBagItemCounts) to High(g_Config.HeroBagItemCounts) do begin
    Config.WriteInteger('HeroSetup', 'BagItemCount' + IntToStr(I), g_Config.HeroBagItemCounts[I]);
  end;

  Config.WriteInteger('HeroSetup', 'WarrorAttackTime', g_Config.dwHeroWarrorAttackTime);
  Config.WriteInteger('HeroSetup', 'WizardAttackTime', g_Config.dwHeroWizardAttackTime);
  Config.WriteInteger('HeroSetup', 'TaoistAttackTime', g_Config.dwHeroTaoistAttackTime);

  Config.WriteInteger('HeroSetup', 'WarrorWalkTime', g_Config.dwHeroWarrorWalkTime);
  Config.WriteInteger('HeroSetup', 'WizardWalkTime', g_Config.dwHeroWizardWalkTime);
  Config.WriteInteger('HeroSetup', 'TaoistWalkTime', g_Config.dwHeroTaoistWalkTime);

  Config.WriteInteger('HeroSetup', 'HeroAddHPRate', g_Config.nHeroAddHPRate);
  Config.WriteInteger('HeroSetup', 'HeroAddMPRate', g_Config.nHeroAddMPRate);
  Config.WriteInteger('HeroSetup', 'HeroNameColor', g_Config.btHeroNameColor);

  Config.WriteInteger('HeroSetup', 'RecallHeroTime', g_Config.nRecallHeroTime);
  Config.WriteString('HeroSetup', 'RecallHeroHint', g_Config.sRecallHeroHint);
  Config.WriteBool('HeroSetup', 'HeroUseBagItem', g_Config.boHeroUseBagItem);
  Config.WriteBool('HeroSetup', 'SafeNoAllowTargetBB', g_Config.boSafeNoAllowTargetBB);
  uModValue();
end;

procedure TfrmHeroConfig.EditStartLevelChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroStartLevel := EditStartLevel.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditKillMonExpRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroKillMonExpRate := EditKillMonExpRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.ComboBoxBagItemCountChange(Sender: TObject);
begin
  SpinEditNeedLevel.Value := Integer(ComboBoxBagItemCount.Items.Objects[ComboBoxBagItemCount.ItemIndex]);
  SpinEditNeedLevel.Enabled := True;
end;

procedure TfrmHeroConfig.SpinEditNeedLevelChange(Sender: TObject);
  procedure RefBagcount;
  var
    I: Integer;
  begin
    for I := 0 to ComboBoxBagItemCount.Items.Count - 1 do begin
      g_Config.HeroBagItemCounts[I] := Integer(ComboBoxBagItemCount.Items.Objects[I]);
    end;
  end;
begin
  if not boOpened then Exit;
  ComboBoxBagItemCount.Items.Objects[ComboBoxBagItemCount.ItemIndex] := TObject(SpinEditNeedLevel.Value);
  RefBagcount;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditWarrorAttackTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroWarrorAttackTime := SpinEditWarrorAttackTime.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditWizardAttackTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroWizardAttackTime := SpinEditWizardAttackTime.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditTaoistAttackTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroTaoistAttackTime := SpinEditTaoistAttackTime.Value;
  ModValue();
end;

procedure TfrmHeroConfig.ButtonHeroDieSaveClick(Sender: TObject);
begin
  Config.WriteBool('HeroSetup', 'KillByMonstDropUseItem', g_Config.boHeroKillByMonstDropUseItem);
  Config.WriteBool('HeroSetup', 'KillByHumanDropUseItem', g_Config.boHeroKillByHumanDropUseItem);
  Config.WriteBool('HeroSetup', 'DieScatterBag', g_Config.boHeroDieScatterBag);
  Config.WriteBool('HeroSetup', 'DieRedScatterBagAll', g_Config.boHeroDieRedScatterBagAll);
  Config.WriteInteger('HeroSetup', 'DieDropUseItemRate', g_Config.nHeroDieDropUseItemRate);
  Config.WriteInteger('HeroSetup', 'DieRedDropUseItemRate', g_Config.nHeroDieRedDropUseItemRate);
  Config.WriteInteger('HeroSetup', 'DieScatterBagRate', g_Config.nHeroDieScatterBagRate);
  uModValue();
end;

procedure TfrmHeroConfig.CheckBoxKillByMonstDropUseItemClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroKillByMonstDropUseItem := CheckBoxKillByMonstDropUseItem.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxKillByHumanDropUseItemClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroKillByHumanDropUseItem := CheckBoxKillByHumanDropUseItem.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxDieScatterBagClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroDieScatterBag := CheckBoxDieScatterBag.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxDieRedScatterBagAllClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroDieRedScatterBagAll := CheckBoxDieRedScatterBagAll.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.ScrollBarDieDropUseItemRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarDieDropUseItemRate.Position;
  EditDieDropUseItemRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nHeroDieDropUseItemRate := nPostion;
  ModValue();
end;

procedure TfrmHeroConfig.ScrollBarDieRedDropUseItemRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarDieRedDropUseItemRate.Position;
  EditDieRedDropUseItemRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nHeroDieRedDropUseItemRate := nPostion;
  ModValue();
end;

procedure TfrmHeroConfig.ScrollBarDieScatterBagRateChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarDieScatterBagRate.Position;
  EditDieScatterBagRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nHeroDieScatterBagRate := nPostion;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditEatHPItemRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAddHPRate := SpinEditEatHPItemRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditEatMPItemRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAddMPRate := SpinEditEatMPItemRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.ButtonHeroAttackSaveClick(Sender: TObject);
begin
  Config.WriteInteger('HeroSetup', 'MaxAngryValue', g_Config.nMaxAngryValue);
  Config.WriteInteger('HeroSetup', 'AddAngryValue', g_Config.nAddAngryValue);
  Config.WriteInteger('HeroSetup', 'DecAngryValue', g_Config.nDecAngryValue);
  Config.WriteInteger('HeroSetup', 'Skill60Rate', g_Config.nSkill60Rate);
  Config.WriteInteger('HeroSetup', 'Skill61Rate', g_Config.nSkill61Rate);
  Config.WriteInteger('HeroSetup', 'Skill62Rate', g_Config.nSkill62Rate);
  Config.WriteInteger('HeroSetup', 'Skill63Rate', g_Config.nSkill63Rate);
  Config.WriteInteger('HeroSetup', 'Skill64Rate', g_Config.nSkill64Rate);
  Config.WriteInteger('HeroSetup', 'Skill65Rate', g_Config.nSkill65Rate);
  uModValue();
end;

procedure TfrmHeroConfig.EditMaxFirDragonPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMaxAngryValue := EditMaxFirDragonPoint.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditAddFirDragonPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAddAngryValue := EditAddFirDragonPoint.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditDecFirDragonPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDecAngryValue := EditDecFirDragonPoint.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditSkill60RateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill60Rate := EditSkill60Rate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditSkill61RateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill61Rate := EditSkill61Rate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditSkill62RateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill62Rate := EditSkill62Rate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditSkill63RateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill63Rate := EditSkill63Rate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditSkill64RateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill64Rate := EditSkill64Rate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditSkill65RateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill65Rate := EditSkill65Rate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditHeroNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditHeroNameColor.Value;
  LabelHeroNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btHeroNameColor := btColor;
  ModValue();
end;

procedure TfrmHeroConfig.EditRecallHeroTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRecallHeroTime := EditRecallHeroTime.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditRecallHeroHintChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sRecallHeroHint := EditRecallHeroHint.Text;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxHeroUseBagItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroUseBagItem := CheckBoxHeroUseBagItem.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxSafeNoAllowTargetBBClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boSafeNoAllowTargetBB := CheckBoxSafeNoAllowTargetBB.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.EditHeroWarrorWalkTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroWarrorWalkTime := EditHeroWarrorWalkTime.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditHeroWizardWalkTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroWizardWalkTime := EditHeroWizardWalkTime.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditHeroTaoistWalkTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroTaoistWalkTime := EditHeroTaoistWalkTime.Value;
  ModValue();
end;

end.
