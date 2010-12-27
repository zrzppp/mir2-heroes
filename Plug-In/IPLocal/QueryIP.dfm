object FrmQueryIP: TFrmQueryIP
  Left = 566
  Top = 315
  BorderStyle = bsDialog
  Caption = 'IP'#26597#35810
  ClientHeight = 226
  ClientWidth = 413
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
  object EditIP: TEdit
    Left = 8
    Top = 8
    Width = 317
    Height = 20
    TabOrder = 0
    Text = '127.0.0.1'
  end
  object ButtonOK: TButton
    Left = 331
    Top = 8
    Width = 75
    Height = 25
    Caption = #26597#35810
    TabOrder = 1
    OnClick = ButtonOKClick
  end
  object MemoIP: TMemo
    Left = 8
    Top = 39
    Width = 398
    Height = 179
    Lines.Strings = (
      'MemoIP')
    ScrollBars = ssBoth
    TabOrder = 2
  end
end
