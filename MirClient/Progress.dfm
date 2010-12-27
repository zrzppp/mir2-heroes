object FrmProgress: TFrmProgress
  Left = 703
  Top = 225
  BorderStyle = bsNone
  Caption = 'FrmProgress'
  ClientHeight = 99
  ClientWidth = 550
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Image: TImage
    Left = 0
    Top = 0
    Width = 550
    Height = 99
    Align = alClient
  end
  object Label1: TLabel
    Left = 14
    Top = 76
    Width = 84
    Height = 12
    Caption = #35831' '#31245' '#31561'......'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object LabelMsg: TLabel
    Left = 144
    Top = 24
    Width = 7
    Height = 14
    Font.Charset = GB2312_CHARSET
    Font.Color = clYellow
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object ProgressBar: TProgressBar
    Left = 12
    Top = 54
    Width = 528
    Height = 12
    TabOrder = 0
  end
  object Timer: TTimer
    Interval = 20
    OnTimer = TimerTimer
    Left = 248
    Top = 32
  end
end
