object frmGeneralConfig: TfrmGeneralConfig
  Left = 244
  Top = 276
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'General Options'
  ClientHeight = 193
  ClientWidth = 370
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBoxNet: TGroupBox
    Left = 8
    Top = 8
    Width = 185
    Height = 145
    Caption = 'IP/ Ports'
    TabOrder = 0
    object LabelGateIPaddr: TLabel
      Left = 8
      Top = 20
      Width = 54
      Height = 12
      Caption = 'Gate Addr:'
    end
    object LabelGatePort: TLabel
      Left = 8
      Top = 44
      Width = 54
      Height = 12
      Caption = 'Gate Port:'
    end
    object LabelServerPort: TLabel
      Left = 8
      Top = 92
      Width = 66
      Height = 12
      Caption = 'Server Port:'
    end
    object LabelServerIPaddr: TLabel
      Left = 8
      Top = 68
      Width = 66
      Height = 12
      Caption = 'Server Addr:'
    end
    object EditGateIPaddr: TEdit
      Left = 80
      Top = 16
      Width = 97
      Height = 20
      Hint = 'Gate IP Address should be set to 0.0.0.0'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = '0.0.0.0'
    end
    object EditGatePort: TEdit
      Left = 80
      Top = 40
      Width = 41
      Height = 20
      Hint = 'Gate Port as a default should be set to 7200'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '7200'
    end
    object EditServerPort: TEdit
      Left = 80
      Top = 88
      Width = 41
      Height = 20
      Hint = 'Server Port as default should be set to 5000'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = '5000'
    end
    object EditServerIPaddr: TEdit
      Left = 80
      Top = 64
      Width = 97
      Height = 20
      Hint = 'For offline use this IP should be set to 127.0.0.1'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = '127.0.0.1'
    end
  end
  object GroupBoxInfo: TGroupBox
    Left = 200
    Top = 8
    Width = 161
    Height = 145
    Caption = 'Information'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 30
      Height = 12
      Caption = 'Title:'
    end
    object LabelShowLogLevel: TLabel
      Left = 8
      Top = 44
      Width = 78
      Height = 12
      Caption = 'Speed:'
    end
    object LabelShowBite: TLabel
      Left = 8
      Top = 92
      Width = 78
      Height = 12
      Caption = 'Bytes:'
    end
    object EditTitle: TEdit
      Left = 40
      Top = 16
      Width = 105
      Height = 20
      Hint = 'Title of the gate should be set here'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = 'text1'
    end
    object TrackBarLogLevel: TTrackBar
      Left = 8
      Top = 56
      Width = 145
      Height = 25
      Hint = 'As a default the bar should be set to just below middle'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object ComboBoxShowBite: TComboBox
      Left = 88
      Top = 88
      Width = 57
      Height = 20
      Hint = 'As a default setting this should be set to B'
      Style = csDropDownList
      ItemHeight = 12
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Items.Strings = (
        'KB'
        'B')
    end
    object CheckBoxMinimize: TCheckBox
      Left = 8
      Top = 120
      Width = 97
      Height = 17
      Caption = 'Minimize'
      TabOrder = 3
      OnClick = CheckBoxMinimizeClick
    end
  end
  object ButtonOK: TButton
    Left = 296
    Top = 160
    Width = 65
    Height = 25
    Hint = 'If you are happy with your new setting press OK'
    Caption = 'OK(&O)'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = ButtonOKClick
  end
end
