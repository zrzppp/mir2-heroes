object FrmMain: TFrmMain
  Left = 495
  Top = 312
  BorderStyle = bsDialog
  Caption = 'FrmMain'
  ClientHeight = 83
  ClientWidth = 431
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 36
    Height = 12
    Caption = 'Mir.DB'
  end
  object EditMir: TRzButtonEdit
    Left = 53
    Top = 8
    Width = 369
    Height = 20
    Text = 'D:\MirServer\DBServer\FDB\Mir.DB'
    TabOrder = 0
    AltBtnWidth = 15
    ButtonWidth = 15
    OnButtonClick = EditMirButtonClick
  end
  object ButtonConvert: TRzButton
    Left = 172
    Top = 34
    Caption = #36716#25442
    TabOrder = 1
    OnClick = ButtonConvertClick
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 66
    Width = 431
    Height = 17
    Align = alBottom
    TabOrder = 2
  end
  object OpenDialog: TOpenDialog
    Left = 288
    Top = 8
  end
  object SaveDialog: TSaveDialog
    Filter = 'M2Server|*.exe'
    Left = 320
    Top = 8
  end
end
