object frmProgress: TfrmProgress
  Left = 1077
  Top = 385
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'frmProgress'
  ClientHeight = 87
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object LabelMsg: TLabel
    Left = 8
    Top = 16
    Width = 156
    Height = 12
    Caption = #27491#22312#35835#21462#25968#25454#65292#35831#31245#20505'......'
    Transparent = False
  end
  object Label1: TLabel
    Left = 8
    Top = 68
    Width = 208
    Height = 12
    Caption = #35831#22312#26381#21153#31471#20851#38381#30340#24773#20917#19979#20351#29992#65281#65281#65281
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 38
    Width = 424
    Height = 17
    TabOrder = 0
  end
  object Timer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerTimer
    Left = 160
    Top = 16
  end
end
