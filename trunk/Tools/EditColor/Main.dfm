object frmMain: TfrmMain
  Left = 263
  Top = 339
  Width = 975
  Height = 179
  BorderIcons = [biSystemMenu]
  Caption = 'frmMain'
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
  object RzLabel1: TRzLabel
    Left = 0
    Top = 80
    Width = 54
    Height = 12
    Caption = #23383#20307#39068#33394':'
  end
  object RzLabel2: TRzLabel
    Left = 0
    Top = 120
    Width = 54
    Height = 12
    Caption = #32972#26223#39068#33394':'
  end
  object LabelColor: TLabel
    Left = 56
    Top = 6
    Width = 841
    Height = 51
    Alignment = taCenter
    AutoSize = False
    Caption = #39134#23572#19990#30028' http://www.cqfir.com'
    Color = clRed
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -48
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object TrackBarFColor: TRzTrackBar
    Left = 52
    Top = 64
    Width = 857
    Max = 255
    Position = 0
    TrackFrame = fsButtonUp
    OnChange = TrackBarFColorChange
    TabOrder = 0
  end
  object TrackBarBColor: TRzTrackBar
    Left = 52
    Top = 104
    Width = 857
    Max = 255
    Position = 0
    ThumbStyle = tsXPPointer
    TrackFrame = fsButtonUp
    OnChange = TrackBarBColorChange
    TabOrder = 1
  end
  object EditFColor: TRzNumericEdit
    Left = 912
    Top = 80
    Width = 49
    Height = 20
    TabOrder = 2
    OnChange = EditFColorChange
    Max = 255.000000000000000000
    DisplayFormat = '0'
  end
  object EditBColor: TRzNumericEdit
    Left = 912
    Top = 120
    Width = 49
    Height = 20
    MaxLength = 255
    TabOrder = 3
    OnChange = EditBColorChange
    DisplayFormat = '0'
  end
end
