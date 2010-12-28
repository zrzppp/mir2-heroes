object FrmServerValue: TFrmServerValue
  Left = 602
  Top = 186
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '??????'
  ClientHeight = 224
  ClientWidth = 546
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label18: TLabel
    Left = 9
    Top = 204
    Width = 280
    Height = 17
    Caption = '?????????,???????????????,??????????'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = '??'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 429
    Top = 168
    Width = 107
    Height = 29
    Caption = '??(&O)'
    TabOrder = 0
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object CbViewHack: TCheckBox
    Left = 177
    Top = 159
    Width = 188
    Height = 20
    Caption = '??????????'
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = CbViewHackClick
  end
  object CkViewAdmfail: TCheckBox
    Left = 177
    Top = 177
    Width = 244
    Height = 20
    Caption = '????????'
    TabOrder = 2
    OnClick = CkViewAdmfailClick
  end
  object GroupBox1: TGroupBox
    Left = 177
    Top = 9
    Width = 198
    Height = 142
    Caption = '??????'
    TabOrder = 3
    object Label8: TLabel
      Left = 13
      Top = 28
      Width = 34
      Height = 14
      Caption = '?????:'
    end
    object Label7: TLabel
      Left = 11
      Top = 56
      Width = 34
      Height = 14
      Caption = '?????:'
    end
    object Label9: TLabel
      Left = 8
      Top = 81
      Width = 34
      Height = 14
      Caption = '?????:'
      Enabled = False
    end
    object Label10: TLabel
      Left = 8
      Top = 109
      Width = 28
      Height = 14
      Caption = '????:'
    end
    object Label11: TLabel
      Left = 169
      Top = 28
      Width = 7
      Height = 14
      Caption = 'B'
    end
    object Label12: TLabel
      Left = 169
      Top = 56
      Width = 7
      Height = 14
      Caption = 'B'
    end
    object Label13: TLabel
      Left = 169
      Top = 84
      Width = 7
      Height = 14
      Caption = 'B'
    end
    object Label14: TLabel
      Left = 169
      Top = 112
      Width = 14
      Height = 14
      Caption = 'KB'
    end
    object EGateLoad: TSpinEdit
      Left = 91
      Top = 107
      Width = 69
      Height = 23
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = EGateLoadChange
    end
    object EAvailableBlock: TSpinEdit
      Left = 91
      Top = 79
      Width = 69
      Height = 23
      Enabled = False
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = EAvailableBlockChange
    end
    object ECheckBlock: TSpinEdit
      Left = 91
      Top = 51
      Width = 69
      Height = 23
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnChange = ECheckBlockChange
    end
    object ESendBlock: TSpinEdit
      Left = 91
      Top = 25
      Width = 69
      Height = 23
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 0
      OnChange = ESendBlockChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 9
    Top = 9
    Width = 160
    Height = 188
    Caption = '??????(??)'
    TabOrder = 4
    object Label1: TLabel
      Left = 19
      Top = 19
      Width = 28
      Height = 14
      Caption = '????:'
    end
    object Label2: TLabel
      Left = 19
      Top = 47
      Width = 28
      Height = 14
      Caption = '????:'
    end
    object Label3: TLabel
      Left = 19
      Top = 75
      Width = 28
      Height = 14
      Caption = '????:'
    end
    object Label4: TLabel
      Left = 19
      Top = 103
      Width = 28
      Height = 14
      Caption = '????:'
    end
    object Label5: TLabel
      Left = 19
      Top = 159
      Width = 38
      Height = 14
      Caption = 'NPC??:'
    end
    object Label6: TLabel
      Left = 19
      Top = 131
      Width = 28
      Height = 14
      Caption = '????:'
      Enabled = False
    end
    object EHum: TSpinEdit
      Left = 89
      Top = 15
      Width = 55
      Height = 23
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = EHumChange
    end
    object EMon: TSpinEdit
      Left = 89
      Top = 43
      Width = 55
      Height = 23
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = EMonChange
    end
    object EZen: TSpinEdit
      Left = 89
      Top = 71
      Width = 55
      Height = 23
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnChange = EZenChange
    end
    object ESoc: TSpinEdit
      Left = 89
      Top = 99
      Width = 55
      Height = 23
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 0
      OnChange = ESocChange
    end
    object ENpc: TSpinEdit
      Left = 89
      Top = 155
      Width = 55
      Height = 23
      MaxValue = 0
      MinValue = 0
      TabOrder = 4
      Value = 0
      OnChange = ENpcChange
    end
    object EDec: TSpinEdit
      Left = 89
      Top = 127
      Width = 55
      Height = 23
      Enabled = False
      MaxValue = 0
      MinValue = 0
      TabOrder = 5
      Value = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 383
    Top = 9
    Width = 150
    Height = 104
    Caption = '??????'
    TabOrder = 5
    object Label15: TLabel
      Left = 9
      Top = 19
      Width = 28
      Height = 14
      Caption = '????:'
    end
    object Label16: TLabel
      Left = 9
      Top = 75
      Width = 28
      Height = 14
      Caption = '????:'
    end
    object Label17: TLabel
      Left = 9
      Top = 47
      Width = 28
      Height = 14
      Caption = '????:'
    end
    object EditZenMonRate: TSpinEdit
      Left = 79
      Top = 15
      Width = 55
      Height = 23
      MaxValue = 1000
      MinValue = 0
      TabOrder = 0
      Value = 1
      OnChange = EditZenMonRateChange
    end
    object EditProcessTime: TSpinEdit
      Left = 79
      Top = 71
      Width = 55
      Height = 23
      Increment = 10
      MaxValue = 1000
      MinValue = 0
      TabOrder = 1
      Value = 1
      OnChange = EditProcessTimeChange
    end
    object EditZenMonTime: TSpinEdit
      Left = 79
      Top = 43
      Width = 55
      Height = 23
      Increment = 10
      MaxValue = 1000
      MinValue = 0
      TabOrder = 2
      Value = 1
      OnChange = EditZenMonTimeChange
    end
  end
  object ButtonDefault: TButton
    Left = 429
    Top = 131
    Width = 104
    Height = 29
    Caption = '????'
    TabOrder = 6
    OnClick = ButtonDefaultClick
  end
end
