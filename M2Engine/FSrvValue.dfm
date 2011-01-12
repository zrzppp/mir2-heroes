object FrmServerValue: TFrmServerValue
  Left = 178
  Top = 186
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Server Values Config'
  ClientHeight = 240
  ClientWidth = 585
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
  TextHeight = 15
  object Label18: TLabel
    Left = 10
    Top = 219
    Width = 314
    Height = 18
    Caption = '?????????,???????????????,??????????'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = '??'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 460
    Top = 180
    Width = 114
    Height = 31
    Caption = '&Save'
    TabOrder = 0
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object CbViewHack: TCheckBox
    Left = 190
    Top = 170
    Width = 201
    Height = 22
    Caption = 'ViewHack'
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = CbViewHackClick
  end
  object CkViewAdmfail: TCheckBox
    Left = 190
    Top = 190
    Width = 261
    Height = 21
    Caption = 'AdmFail'
    TabOrder = 2
    OnClick = CkViewAdmfailClick
  end
  object GroupBox1: TGroupBox
    Left = 190
    Top = 10
    Width = 212
    Height = 152
    Caption = 'Blocks'
    TabOrder = 3
    object Label8: TLabel
      Left = 14
      Top = 30
      Width = 32
      Height = 15
      Caption = 'Send:'
    end
    object Label7: TLabel
      Left = 12
      Top = 60
      Width = 38
      Height = 15
      Caption = 'Check:'
    end
    object Label9: TLabel
      Left = 9
      Top = 87
      Width = 28
      Height = 15
      Caption = 'Avail:'
      Enabled = False
    end
    object Label10: TLabel
      Left = 9
      Top = 117
      Width = 29
      Height = 15
      Caption = 'Gate:'
    end
    object Label11: TLabel
      Left = 181
      Top = 30
      Width = 8
      Height = 15
      Caption = 'B'
    end
    object Label12: TLabel
      Left = 181
      Top = 60
      Width = 8
      Height = 15
      Caption = 'B'
    end
    object Label13: TLabel
      Left = 181
      Top = 90
      Width = 8
      Height = 15
      Caption = 'B'
    end
    object Label14: TLabel
      Left = 181
      Top = 120
      Width = 16
      Height = 15
      Caption = 'KB'
    end
    object EGateLoad: TSpinEdit
      Left = 98
      Top = 115
      Width = 73
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = EGateLoadChange
    end
    object EAvailableBlock: TSpinEdit
      Left = 98
      Top = 85
      Width = 73
      Height = 24
      Enabled = False
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = EAvailableBlockChange
    end
    object ECheckBlock: TSpinEdit
      Left = 98
      Top = 55
      Width = 73
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnChange = ECheckBlockChange
    end
    object ESendBlock: TSpinEdit
      Left = 98
      Top = 27
      Width = 73
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 0
      OnChange = ESendBlockChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 10
    Top = 10
    Width = 171
    Height = 201
    Caption = 'Limits'
    TabOrder = 4
    object Label1: TLabel
      Left = 20
      Top = 20
      Width = 30
      Height = 15
      Caption = 'Hum:'
    end
    object Label2: TLabel
      Left = 20
      Top = 50
      Width = 26
      Height = 15
      Caption = 'Mon:'
    end
    object Label3: TLabel
      Left = 20
      Top = 80
      Width = 24
      Height = 15
      Caption = 'Zen:'
    end
    object Label4: TLabel
      Left = 20
      Top = 110
      Width = 24
      Height = 15
      Caption = 'Soc:'
    end
    object Label5: TLabel
      Left = 20
      Top = 170
      Width = 29
      Height = 15
      Caption = 'NPC:'
    end
    object Label6: TLabel
      Left = 20
      Top = 140
      Width = 25
      Height = 15
      Caption = 'Dec:'
      Enabled = False
    end
    object EHum: TSpinEdit
      Left = 95
      Top = 16
      Width = 59
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = EHumChange
    end
    object EMon: TSpinEdit
      Left = 95
      Top = 46
      Width = 59
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = EMonChange
    end
    object EZen: TSpinEdit
      Left = 95
      Top = 76
      Width = 59
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnChange = EZenChange
    end
    object ESoc: TSpinEdit
      Left = 95
      Top = 106
      Width = 59
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 0
      OnChange = ESocChange
    end
    object ENpc: TSpinEdit
      Left = 95
      Top = 166
      Width = 59
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 4
      Value = 0
      OnChange = ENpcChange
    end
    object EDec: TSpinEdit
      Left = 95
      Top = 136
      Width = 59
      Height = 24
      Enabled = False
      MaxValue = 0
      MinValue = 0
      TabOrder = 5
      Value = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 410
    Top = 10
    Width = 161
    Height = 111
    Caption = 'ZenMon'
    TabOrder = 5
    object Label15: TLabel
      Left = 10
      Top = 20
      Width = 29
      Height = 15
      Caption = 'Rate:'
    end
    object Label16: TLabel
      Left = 10
      Top = 80
      Width = 28
      Height = 15
      Caption = 'Proc:'
    end
    object Label17: TLabel
      Left = 10
      Top = 50
      Width = 35
      Height = 15
      Caption = 'ReGn:'
    end
    object EditZenMonRate: TSpinEdit
      Left = 85
      Top = 16
      Width = 59
      Height = 24
      MaxValue = 1000
      MinValue = 0
      TabOrder = 0
      Value = 1
      OnChange = EditZenMonRateChange
    end
    object EditProcessTime: TSpinEdit
      Left = 85
      Top = 76
      Width = 59
      Height = 24
      Increment = 10
      MaxValue = 1000
      MinValue = 0
      TabOrder = 1
      Value = 1
      OnChange = EditProcessTimeChange
    end
    object EditZenMonTime: TSpinEdit
      Left = 85
      Top = 46
      Width = 59
      Height = 24
      Increment = 10
      MaxValue = 1000
      MinValue = 0
      TabOrder = 2
      Value = 1
      OnChange = EditZenMonTimeChange
    end
  end
  object ButtonDefault: TButton
    Left = 460
    Top = 140
    Width = 111
    Height = 31
    Caption = 'Defult'
    TabOrder = 6
    OnClick = ButtonDefaultClick
  end
end
