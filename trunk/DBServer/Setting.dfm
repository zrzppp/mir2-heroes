object FrmSetting: TFrmSetting
  Left = 539
  Top = 382
  BorderStyle = bsDialog
  Caption = #22522#26412#35774#32622
  ClientHeight = 153
  ClientWidth = 322
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 305
    Height = 105
    Caption = #22522#26412#35774#32622
    TabOrder = 0
    object CheckBoxAttack: TCheckBox
      Left = 168
      Top = 64
      Width = 89
      Height = 17
      Caption = #38450#25915#20987#20445#25252
      Enabled = False
      TabOrder = 0
      Visible = False
      OnClick = CheckBoxAttackClick
    end
    object CheckBoxDenyChrName: TCheckBox
      Left = 16
      Top = 40
      Width = 145
      Height = 17
      Caption = #20801#35768#29305#27530#23383#31526#21019#24314#20154#29289
      TabOrder = 1
      OnClick = CheckBoxDenyChrNameClick
    end
    object CheckBoxMinimize: TCheckBox
      Left = 16
      Top = 64
      Width = 137
      Height = 17
      Caption = #21551#21160#25104#21151#21518#26368#23567#21270
      TabOrder = 2
      OnClick = CheckBoxMinimizeClick
    end
    object CheckBoxDeleteChrName: TCheckBox
      Left = 165
      Top = 17
      Width = 100
      Height = 17
      Caption = #20801#35768#21024#38500#20154#29289
      TabOrder = 3
      OnClick = CheckBoxDeleteChrNameClick
    end
    object CheckBoxRandomNumber: TCheckBox
      Left = 165
      Top = 41
      Width = 108
      Height = 17
      Caption = #24320#21551#39564#35777#30721#21151#33021
      TabOrder = 4
      OnClick = CheckBoxRandomNumberClick
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 16
      Width = 81
      Height = 17
      Caption = #24320#21551#25490#34892#27036
      TabOrder = 5
      Visible = False
      OnClick = CheckBoxDenyChrNameClick
    end
  end
  object ButtonOK: TButton
    Left = 240
    Top = 120
    Width = 75
    Height = 25
    Caption = #30830#23450'(&O)'
    TabOrder = 1
    OnClick = ButtonOKClick
  end
end
