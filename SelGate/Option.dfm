object frmOption: TfrmOption
  Left = 706
  Top = 323
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #37197#21046#20449#24687
  ClientHeight = 273
  ClientWidth = 637
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Label2: TLabel
    Left = 440
    Top = 20
    Width = 54
    Height = 12
    Caption = #36830#25509#38480#21046':'
  end
  object Label3: TLabel
    Left = 592
    Top = 20
    Width = 42
    Height = 12
    Caption = #36830#25509'/IP'
  end
  object Label5: TLabel
    Left = 440
    Top = 44
    Width = 42
    Height = 12
    Caption = #31354#36830#25509':'
  end
  object Label11: TLabel
    Left = 440
    Top = 68
    Width = 78
    Height = 12
    Caption = #38450'CC'#25915#20987#26102#38388':'
  end
  object Label1: TLabel
    Left = 440
    Top = 92
    Width = 54
    Height = 12
    Caption = #36830#25509#38480#21046':'
  end
  object Label4: TLabel
    Left = 587
    Top = 92
    Width = 42
    Height = 12
    Caption = #36830#25509'/IP'
  end
  object GroupBoxActive: TGroupBox
    Left = 8
    Top = 8
    Width = 137
    Height = 257
    Caption = #24403#21069#36830#25509
    TabOrder = 0
    object LabelActive: TLabel
      Left = 8
      Top = 24
      Width = 54
      Height = 12
      Caption = #36830#25509#21015#34920':'
    end
    object ListBoxActiveList: TListBox
      Left = 8
      Top = 40
      Width = 121
      Height = 209
      Hint = #24403#21069#36830#25509#30340'IP'#22320#22336#21015#34920#13'Ctrl + F '#26597#25214'IP'
      ItemHeight = 12
      Items.Strings = (
        '888.888.888.888')
      MultiSelect = True
      ParentShowHint = False
      PopupMenu = ActiveListPopupMenu
      ShowHint = True
      Sorted = True
      TabOrder = 0
      OnKeyDown = ListBoxActiveListKeyDown
    end
  end
  object GroupBox1: TGroupBox
    Left = 152
    Top = 8
    Width = 137
    Height = 257
    Caption = #36807#28388#21015#34920
    TabOrder = 1
    object LabelBlock: TLabel
      Left = 8
      Top = 24
      Width = 54
      Height = 12
      Caption = #27704#20037#36807#28388':'
    end
    object ListBoxBlockList: TListBox
      Left = 13
      Top = 42
      Width = 121
      Height = 209
      Hint = 
        #27704#20037#36807#28388#21015#34920#65292#22312#27492#21015#34920#20013#30340'IP'#23558#26080#27861#24314#31435#36830#25509#65292#27492#21015#34920#23558#20445#23384#20110#37197#32622#25991#20214#20013#65292#22312#31243#24207#37325#26032#21551#21160#26102#20250#37325#26032#21152#36733#27492#21015#34920#13'Ctrl + F '#26597#25214 +
        'IP'
      ItemHeight = 12
      Items.Strings = (
        '888.888.888.888')
      MultiSelect = True
      ParentShowHint = False
      PopupMenu = BlockListPopupMenu
      ShowHint = True
      Sorted = True
      TabOrder = 0
      OnKeyDown = ListBoxBlockListKeyDown
    end
  end
  object EditMaxConnect: TSpinEdit
    Left = 520
    Top = 16
    Width = 65
    Height = 21
    Hint = #21333#20010'IP'#22320#22336#65292#26368#22810#21487#20197#24314#31435#36830#25509#25968#65292#36229#36807#25351#23450#36830#25509#25968#23558#25353#19979#38754#30340#25805#20316#22788#29702
    EditorEnabled = False
    MaxValue = 10000
    MinValue = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Value = 50
    OnChange = EditMaxConnectChange
  end
  object ButtonOK: TButton
    Left = 536
    Top = 240
    Width = 89
    Height = 25
    Caption = #30830#23450'(&O)'
    Default = True
    TabOrder = 3
    OnClick = ButtonOKClick
  end
  object EditKeepConnectTimeOut: TSpinEdit
    Left = 520
    Top = 40
    Width = 105
    Height = 21
    Increment = 1000
    MaxValue = 100000000
    MinValue = 10000
    TabOrder = 4
    Value = 180000
    OnChange = EditKeepConnectTimeOutChange
  end
  object EditConnctCheckTime: TSpinEdit
    Left = 520
    Top = 64
    Width = 81
    Height = 21
    Hint = #25968#23383#36234#22823#36234#20005#26684#65292#40664#35748'100'
    Increment = 10
    MaxValue = 1000
    MinValue = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    Value = 100
    OnChange = EditConnctCheckTimeChange
  end
  object GroupBox2: TGroupBox
    Left = 296
    Top = 8
    Width = 137
    Height = 257
    Caption = 'IP'#27573#36807#28388#21015#34920
    TabOrder = 6
    object LabelIPArray: TLabel
      Left = 8
      Top = 24
      Width = 54
      Height = 12
      Caption = 'IP'#27573#36807#28388':'
    end
    object ListBoxIPArrayList: TListBox
      Left = 8
      Top = 40
      Width = 121
      Height = 209
      Hint = 
        'IP'#27573#36807#28388#21015#34920#12290#27604#22914#35201#36807#28388'221.221.10.1'#21040'221.221.10.225'#30340'IP'#65292#21482#38656#22686#21152#19968#20010#13'221.221.10.*'#65292 +
        #29992'*'#21495#20195#34920'IP'#20013#30340#23383#27573#21363#21487#12290
      ItemHeight = 12
      Items.Strings = (
        '*.*.*.*')
      MultiSelect = True
      ParentShowHint = False
      PopupMenu = ArrayPopupMenu
      ShowHint = True
      Sorted = True
      TabOrder = 0
    end
  end
  object EditMaxOnlineCount: TSpinEdit
    Left = 520
    Top = 88
    Width = 65
    Height = 21
    Hint = #26368#22810#21487#20197#24314#31435#36830#25509#25968#65292#36229#36807#25351#23450#36830#25509#25968#23558#20840#37096#36807#28388#21015#34920
    EditorEnabled = False
    MaxValue = 10000
    MinValue = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    Value = 500
    OnChange = EditMaxOnlineCountChange
  end
  object ActiveListPopupMenu: TPopupMenu
    Left = 56
    Top = 160
    object APOPMENU_REFLIST: TMenuItem
      Caption = #21047#26032'(&R)'
      OnClick = APOPMENU_REFLISTClick
    end
    object APOPMENU_BLOCKLIST: TMenuItem
      Caption = #21152#20837#27704#20037#36807#28388#21015#34920'(&D)'
      OnClick = APOPMENU_BLOCKLISTClick
    end
    object APOPMENU_ALLADDLIST: TMenuItem
      Caption = #20840#37096#21152#20837#27704#20037#36807#28388#21015#34920'(&S'
      OnClick = APOPMENU_ALLADDLISTClick
    end
    object APOPMENU_KICK: TMenuItem
      Caption = #36386#38500#19979#32447'(&K)'
      OnClick = APOPMENU_KICKClick
    end
  end
  object BlockListPopupMenu: TPopupMenu
    Left = 200
    Top = 160
    object BPOPMENU_REFLIST: TMenuItem
      Caption = #21047#26032'(&R)'
      OnClick = BPOPMENU_REFLISTClick
    end
    object BPOPMENU_ADD: TMenuItem
      Caption = #22686#21152'(&A)'
      OnClick = BPOPMENU_ADDClick
    end
    object BPOPMENU_CLEAR: TMenuItem
      Caption = #20840#37096#28165#38500'(&C)'
      OnClick = BPOPMENU_CLEARClick
    end
    object BPOPMENU_DELETE: TMenuItem
      Caption = #21024#38500'(&D)'
      OnClick = BPOPMENU_DELETEClick
    end
  end
  object ArrayPopupMenu: TPopupMenu
    Left = 352
    Top = 160
    object AYPOPMENU_REFLIST: TMenuItem
      Caption = #21047#26032'(&R)'
      OnClick = AYPOPMENU_REFLISTClick
    end
    object AYPOPMENU_ADD: TMenuItem
      Caption = #22686#21152'(&A)'
      OnClick = AYPOPMENU_ADDClick
    end
    object AYPOPMENU_CLEAR: TMenuItem
      Caption = #20840#37096#28165#38500'(&C)'
      OnClick = AYPOPMENU_CLEARClick
    end
    object AYPOPMENU_DELETE: TMenuItem
      Caption = #21024#38500'(&D)'
      OnClick = AYPOPMENU_DELETEClick
    end
  end
end
