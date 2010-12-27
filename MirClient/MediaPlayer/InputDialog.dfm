object frmInputDialog: TfrmInputDialog
  Left = 876
  Top = 458
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #36755#20837#25991#20214#22320#22336':'
  ClientHeight = 146
  ClientWidth = 406
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  object RzLabel1: TRzLabel
    Left = 16
    Top = 56
    Width = 78
    Height = 12
    Caption = #36755#20837#25991#20214#22320#22336':'
  end
  object RzLabel2: TRzLabel
    Left = 16
    Top = 8
    Width = 78
    Height = 12
    Caption = #36755#20837#26174#31034#21517#31216':'
  end
  object EditFileAddr: TRzEdit
    Left = 16
    Top = 80
    Width = 377
    Height = 20
    AutoSelect = False
    TabOrder = 0
  end
  object ButtonOK: TRzButton
    Left = 128
    Top = 112
    Caption = #30830#23450
    TabOrder = 1
    OnClick = ButtonOKClick
  end
  object ButtonClose: TRzButton
    Left = 208
    Top = 112
    Caption = #21462#28040
    TabOrder = 2
    OnClick = ButtonCloseClick
  end
  object EditShowName: TRzEdit
    Left = 16
    Top = 24
    Width = 121
    Height = 20
    AutoSelect = False
    TabOrder = 3
  end
end
