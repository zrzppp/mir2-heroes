object FrmSetting: TFrmSetting
  Left = 1544
  Top = 195
  BorderStyle = bsDialog
  Caption = 'General'
  ClientHeight = 153
  ClientWidth = 322
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
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
    Caption = 'Options'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object CheckBoxAttack: TCheckBox
      Left = 168
      Top = 64
      Width = 89
      Height = 17
      Caption = 'Check Attack'
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
      Caption = 'Deny Char Name'
      TabOrder = 1
      OnClick = CheckBoxDenyChrNameClick
    end
    object CheckBoxMinimize: TCheckBox
      Left = 16
      Top = 64
      Width = 137
      Height = 17
      Caption = 'Minimize'
      TabOrder = 2
      OnClick = CheckBoxMinimizeClick
    end
    object CheckBoxDeleteChrName: TCheckBox
      Left = 165
      Top = 17
      Width = 132
      Height = 17
      Caption = 'Delete Char Name'
      TabOrder = 3
      OnClick = CheckBoxDeleteChrNameClick
    end
    object CheckBoxRandomNumber: TCheckBox
      Left = 165
      Top = 41
      Width = 108
      Height = 17
      Caption = 'Random Number'
      TabOrder = 4
      OnClick = CheckBoxRandomNumberClick
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 16
      Width = 81
      Height = 17
      Caption = 'Not Sure'
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
    Caption = 'OK &O)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = ButtonOKClick
  end
end
