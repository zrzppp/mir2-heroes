object FrmLogManage: TFrmLogManage
  Left = 664
  Top = 273
  Width = 749
  Height = 534
  Caption = #26085#35760#26597#35810
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 741
    Height = 49
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 54
      Height = 12
      Caption = #24320#22987#26085#26399':'
    end
    object Label2: TLabel
      Left = 192
      Top = 16
      Width = 54
      Height = 12
      Caption = #32467#26463#26085#26399':'
    end
    object Label3: TLabel
      Left = 376
      Top = 16
      Width = 54
      Height = 12
      Caption = #26597#35810#26465#20214':'
    end
    object DateTimeEditBegin: TRzDateTimeEdit
      Left = 68
      Top = 13
      Width = 109
      Height = 20
      EditType = etDate
      OnDateTimeChange = DateTimeEditBeginDateTimeChange
      TabOrder = 0
    end
    object DateTimeEditEnd: TRzDateTimeEdit
      Left = 252
      Top = 13
      Width = 109
      Height = 20
      EditType = etDate
      OnDateTimeChange = DateTimeEditEndDateTimeChange
      TabOrder = 1
    end
    object ComboBoxCondition: TComboBox
      Left = 436
      Top = 13
      Width = 101
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 2
      Items.Strings = (
        #26080#26465#20214
        #20154#29289#21517#31216
        #29289#21697#21517#31216
        #29289#21697'ID'
        #20132#26131#23545#35937)
    end
    object EditSearch: TEdit
      Left = 543
      Top = 13
      Width = 103
      Height = 20
      TabOrder = 3
    end
    object ButtonStart: TButton
      Left = 652
      Top = 11
      Width = 75
      Height = 25
      Caption = #24320#22987#26597#35810
      TabOrder = 4
      OnClick = ButtonStartClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 49
    Width = 105
    Height = 432
    Align = alLeft
    TabOrder = 1
    object CheckListBox: TCheckListBox
      Left = 1
      Top = 1
      Width = 103
      Height = 430
      OnClickCheck = CheckListBoxClickCheck
      Align = alClient
      ItemHeight = 12
      Items.Strings = (
        #20840#37096#26597#35810
        #21462#22238#29289#21697
        #23384#25918#29289#21697
        #28860#21046#33647#21697
        #25345#20037#28040#22833
        #25441#21462#29289#21697
        #21046#36896#29289#21697
        #38144#27585#29289#21697
        #25172#25481#29289#21697
        #20132#26131#29289#21697
        #20986#21806#29289#21697
        #20351#29992#29289#21697
        #20154#29289#21319#32423
        #20943#23569#37329#24065
        #22686#21152#37329#24065
        #27515#20129#25481#33853
        #25481#33853#29289#21697
        #20154#29289#27515#20129
        #21319#32423#25104#21151
        #21319#32423#22833#36133
        #22478#22561#21462#38065
        #22478#22561#23384#38065
        #21319#32423#21462#22238
        #27494#22120#21319#32423
        #32972#21253#20943#23569
        #25913#21464#22478#20027
        #20803#23453#25913#21464
        #33021#37327#25913#21464
        #21830#38138#36141#20080
        #35013#22791#21319#32423
        #23492#21806#29289#21697
        #23492#21806#36141#20080
        #25361#25112#29289#21697
        #25670#25674#29289#21697)
      TabOrder = 0
    end
  end
  object ListView: TListView
    Left = 105
    Top = 49
    Width = 636
    Height = 432
    Align = alClient
    Columns = <
      item
        Caption = #24207#21495
      end
      item
        Caption = #21160#20316
        Width = 80
      end
      item
        Caption = #22320#22270
        Width = 60
      end
      item
        Caption = #22352#26631'X'
      end
      item
        Caption = #22352#26631'Y'
      end
      item
        Caption = #20154#29289#21517#31216
        Width = 70
      end
      item
        Caption = #29289#21697#21517#31216
        Width = 70
      end
      item
        Caption = #29289#21697'ID'
        Width = 55
      end
      item
        Caption = #20132#26131#23545#35937
        Width = 70
      end
      item
        Caption = #26102#38388
        Width = 70
      end>
    GridLines = True
    MultiSelect = True
    RowSelect = True
    PopupMenu = PopupMenu
    TabOrder = 2
    ViewStyle = vsReport
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 481
    Width = 741
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 400
      end
      item
        Width = 50
      end>
  end
  object PopupMenu: TPopupMenu
    Left = 368
    Top = 248
    object PopupMenu_COPY: TMenuItem
      Caption = #22797#21046
      OnClick = PopupMenu_COPYClick
    end
    object PopupMenu_SELECTALL: TMenuItem
      Caption = #20840#36873
      OnClick = PopupMenu_SELECTALLClick
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerTimer
    Left = 424
    Top = 328
  end
end
