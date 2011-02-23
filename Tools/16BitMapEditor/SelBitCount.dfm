object frmBitCount: TfrmBitCount
  Left = 584
  Top = 378
  BorderStyle = bsDialog
  Caption = #36873#25321
  ClientHeight = 104
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 297
    Height = 57
    TabOrder = 0
    object RadioButton8Bit: TRadioButton
      Left = 8
      Top = 24
      Width = 121
      Height = 17
      Caption = #30427#22823#22320#22270'(Wil'#25991#20214')'
      TabOrder = 0
    end
    object RadioButton16Bit: TRadioButton
      Left = 136
      Top = 24
      Width = 153
      Height = 17
      Caption = #39134#23572#30495#24425#22320#22270'(Data'#25991#20214')'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  object ButtonOk: TButton
    Left = 112
    Top = 72
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 1
    OnClick = ButtonOkClick
  end
end
