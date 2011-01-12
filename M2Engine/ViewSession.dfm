object frmViewSession: TfrmViewSession
  Left = 937
  Top = 494
  Width = 418
  Height = 209
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Session'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object ButtonRefGrid: TButton
    Left = 410
    Top = 180
    Width = 91
    Height = 31
    Caption = '&Refresh'
    TabOrder = 0
    OnClick = ButtonRefGridClick
  end
  object PanelStatus: TPanel
    Left = 10
    Top = 10
    Width = 491
    Height = 161
    TabOrder = 1
    object GridSession: TStringGrid
      Left = 0
      Top = 0
      Width = 491
      Height = 161
      ColCount = 6
      DefaultRowHeight = 18
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 0
      ColWidths = (
        34
        83
        86
        56
        44
        58)
    end
  end
end
