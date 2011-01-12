object FrmAttackSabukWall: TFrmAttackSabukWall
  Left = 338
  Top = 57
  BorderStyle = bsDialog
  Caption = 'FrmAttackSabukWall'
  ClientHeight = 450
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 10
    Top = 385
    Width = 69
    Height = 15
    Caption = 'Guild Name:'
  end
  object Label2: TLabel
    Left = 10
    Top = 415
    Width = 54
    Height = 15
    Caption = 'War Date:'
  end
  object GroupBox1: TGroupBox
    Left = 10
    Top = 10
    Width = 351
    Height = 361
    Caption = '????'
    TabOrder = 0
    object ListBoxGuild: TListBox
      Left = 10
      Top = 20
      Width = 331
      Height = 331
      ItemHeight = 15
      TabOrder = 0
      OnClick = ListBoxGuildClick
    end
  end
  object EditGuildName: TEdit
    Left = 80
    Top = 380
    Width = 171
    Height = 23
    TabOrder = 1
    Text = 'EditGuildName'
  end
  object RzDateTimeEditAttackDate: TRzDateTimeEdit
    Left = 80
    Top = 410
    Width = 171
    Height = 23
    CaptionTodayBtn = '????'
    CaptionClearBtn = '????'
    EditType = etDate
    TabOrder = 2
  end
  object ButtonOK: TButton
    Left = 260
    Top = 410
    Width = 94
    Height = 31
    Caption = 'Ok(&O)'
    TabOrder = 3
    OnClick = ButtonOKClick
  end
  object CheckBoxAll: TCheckBox
    Left = 270
    Top = 380
    Width = 91
    Height = 21
    Caption = '????'
    TabOrder = 4
    OnClick = CheckBoxAllClick
  end
end
