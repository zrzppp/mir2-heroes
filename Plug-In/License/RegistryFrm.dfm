object FrmRegistryDlg: TFrmRegistryDlg
  Left = 963
  Top = 571
  BorderStyle = bsDialog
  Caption = #27880#20876
  ClientHeight = 145
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 337
    Height = 129
    Caption = #27880#20876#20449#24687
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 28
      Width = 42
      Height = 12
      Caption = #26426#22120#30721':'
    end
    object Label2: TLabel
      Left = 16
      Top = 60
      Width = 42
      Height = 12
      Caption = #27880#20876#30721':'
    end
    object EditSerialNumber: TEdit
      Left = 64
      Top = 24
      Width = 257
      Height = 20
      ReadOnly = True
      TabOrder = 0
    end
    object EditRegistryNumber: TEdit
      Left = 64
      Top = 56
      Width = 257
      Height = 20
      TabOrder = 1
    end
    object ButtonOK: TButton
      Left = 24
      Top = 88
      Width = 75
      Height = 25
      Caption = #30830#23450
      TabOrder = 2
      OnClick = ButtonOKClick
    end
    object ButtonCancel: TButton
      Left = 240
      Top = 88
      Width = 75
      Height = 25
      Caption = #21462#28040
      TabOrder = 3
      OnClick = ButtonCancelClick
    end
  end
end
