object frmPrefConfig: TfrmPrefConfig
  Left = 1016
  Top = 314
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Performance'
  ClientHeight = 155
  ClientWidth = 193
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBoxServer: TGroupBox
    Left = 8
    Top = 8
    Width = 177
    Height = 49
    Caption = 'Server Check Time Out'
    TabOrder = 0
    object LabelCheckTimeOut: TLabel
      Left = 8
      Top = 20
      Width = 54
      Height = 12
      Caption = 'Time Out:'
      end
    end
    object EditServerCheckTimeOut: TSpinEdit
      Left = 72
      Top = 26
      Width = 49
      Height = 21
      Hint = 'Server check time out to be set in this box'
      EditorEnabled = False
      Increment = 30
      MaxLength = 600
      MaxValue = 60
      MinValue = 60
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 0
      OnChange = EditServerCheckTimeOutChange
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 64
    Width = 177
    Height = 49
    Caption = 'Client Block Size'
    TabOrder = 1
    object LabelSendBlockSize: TLabel
      Left = 8
      Top = 20
      Width = 54
      Height = 12
      Caption = 'Client Block:'
    end
    object EditSendBlockSize: TSpinEdit
      Left = 72
      Top = 16
      Width = 57
      Height = 21
      Hint = 'Client block size to be set here'
      EditorEnabled = False
      Increment = 50
      MaxLength = 600
      MaxValue = 5000
      MinValue = 100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 100
      OnChange = EditSendBlockSizeChange
    end
  end
  object ButtonOK: TButton
    Left = 120
    Top = 120
    Width = 65
    Height = 25
    Caption = 'OK (&O)'
    TabOrder = 2
    OnClick = ButtonOKClick
  end
end
