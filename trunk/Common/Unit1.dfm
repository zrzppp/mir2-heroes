object Form1: TForm1
  Left = 485
  Top = 180
  Caption = #21152#23494#28436#31034
  ClientHeight = 506
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox3: TGroupBox
    Left = 8
    Top = 288
    Width = 489
    Height = 177
    Caption = #21152#23494#26126#25991
    TabOrder = 4
    object Memo2: TMemo
      Left = 8
      Top = 16
      Width = 473
      Height = 153
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 489
    Height = 193
    Caption = #35299#23494#26126#25991
    TabOrder = 3
    object Memo1: TMemo
      Left = 8
      Top = 16
      Width = 473
      Height = 169
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 208
    Width = 489
    Height = 73
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 66
      Height = 12
      Caption = #21152#23494#31639#27861'   '
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 72
      Height = 12
      Caption = #21152#23494#23494#38053'    '
    end
    object RzLabel1: TRzLabel
      Left = 280
      Top = 48
      Width = 60
      Height = 12
      Caption = #23494#30721#38271#24230#65306
    end
    object ComboBox1: TComboBox
      Left = 72
      Top = 16
      Width = 129
      Height = 20
      ItemHeight = 12
      TabOrder = 0
      Text = 'blowfish'
    end
    object Edit3: TEdit
      Left = 72
      Top = 40
      Width = 201
      Height = 20
      TabOrder = 1
      Text = '12d3fg4g3h32j4k4j32'
    end
    object ComboBox2: TComboBox
      Left = 344
      Top = 16
      Width = 137
      Height = 20
      ItemHeight = 12
      TabOrder = 2
      Text = 'HAVAL'
    end
    object Button5: TButton
      Left = 416
      Top = 40
      Width = 65
      Height = 25
      Caption = #29983#25104#23494#30721
      TabOrder = 3
      OnClick = Button5Click
    end
    object RzSpinner1: TRzSpinner
      Left = 344
      Top = 46
      Width = 65
      Max = 120
      Min = 20
      Value = 20
      ParentColor = False
      TabOrder = 4
    end
  end
  object Button1: TButton
    Left = 280
    Top = 472
    Width = 73
    Height = 25
    Caption = #21152#23494
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 400
    Top = 472
    Width = 73
    Height = 25
    Caption = #32467#26463
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 160
    Top = 472
    Width = 73
    Height = 25
    Caption = 'HASH'#21152#23494
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 32
    Top = 472
    Width = 75
    Height = 25
    Caption = #35299#23494
    TabOrder = 6
    OnClick = Button4Click
  end
end
