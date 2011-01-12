object frmGlobaSession: TfrmGlobaSession
  Left = 94
  Top = 117
  BorderStyle = bsSingle
  Caption = '??????'
  ClientHeight = 435
  ClientWidth = 670
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object StringGrid: TStringGrid
    Left = 10
    Top = 36
    Width = 654
    Height = 204
    DefaultRowHeight = 18
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
    TabOrder = 0
    ColWidths = (
      69
      73
      70
      121
      64)
  end
  object RefTimer: TTimer
    Enabled = False
    OnTimer = RefTimerTimer
    Left = 329
    Top = 219
  end
end
