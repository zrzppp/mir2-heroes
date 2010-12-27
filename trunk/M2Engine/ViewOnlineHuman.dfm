object frmViewOnlineHuman: TfrmViewOnlineHuman
  Left = 561
  Top = 131
  Width = 924
  Height = 450
  Caption = #22312#32447#20154#29289
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object PanelStatus: TPanel
    Left = 0
    Top = 0
    Width = 916
    Height = 360
    Align = alClient
    Caption = #27491#22312#35835#21462#25968#25454'...'
    TabOrder = 0
    object GridHuman: TStringGrid
      Left = 1
      Top = 1
      Width = 914
      Height = 358
      Align = alClient
      ColCount = 18
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 25
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 0
      OnDblClick = GridHumanDblClick
      ColWidths = (
        33
        78
        31
        44
        39
        37
        47
        74
        89
        32
        138
        59
        55
        57
        64
        70
        64
        96)
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 360
    Width = 916
    Height = 56
    Align = alBottom
    TabOrder = 1
    object Label1: TLabel
      Left = 72
      Top = 20
      Width = 30
      Height = 12
      Caption = #25490#24207':'
    end
    object Label2: TLabel
      Left = 344
      Top = 24
      Width = 36
      Height = 12
      Caption = #31561#32423' <'
    end
    object ButtonRefGrid: TButton
      Left = 8
      Top = 15
      Width = 57
      Height = 25
      Caption = #21047#26032'(&R)'
      TabOrder = 0
      OnClick = ButtonRefGridClick
    end
    object ComboBoxSort: TComboBox
      Left = 104
      Top = 20
      Width = 113
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 1
      OnClick = ComboBoxSortClick
      Items.Strings = (
        #21517#31216
        #24615#21035
        #32844#19994
        #31561#32423
        #22320#22270
        #65321#65328
        #26435#38480
        #25152#22312#22320#21306)
    end
    object EditSearchName: TEdit
      Left = 224
      Top = 20
      Width = 113
      Height = 20
      TabOrder = 2
    end
    object ButtonSearch: TButton
      Left = 528
      Top = 15
      Width = 57
      Height = 25
      Caption = #25628#32034'(&S)'
      TabOrder = 3
      OnClick = ButtonSearchClick
    end
    object ButtonView: TButton
      Left = 656
      Top = 15
      Width = 81
      Height = 25
      Caption = #20154#29289#20449#24687'(&H)'
      TabOrder = 4
      OnClick = ButtonViewClick
    end
    object ButtonKick: TButton
      Left = 591
      Top = 15
      Width = 58
      Height = 25
      Caption = #36386#19979#32447'(&K)'
      ModalResult = 1
      TabOrder = 5
      OnClick = ButtonSearchClick
    end
    object EditLevel: TSpinEdit
      Left = 384
      Top = 20
      Width = 57
      Height = 21
      MaxValue = 65535
      MinValue = 0
      TabOrder = 6
      Value = 100
    end
    object MenuButtonOffLine: TRzMenuButton
      Left = 744
      Top = 16
      Width = 145
      Caption = #36386#38500#31163#32447#25346#26426#20154#29289'(&K)'
      TabOrder = 7
      DropDownMenu = PopupMenu
    end
    object CheckBoxHero: TCheckBox
      Left = 448
      Top = 20
      Width = 65
      Height = 17
      Caption = #26174#31034#33521#38596
      TabOrder = 8
      OnClick = CheckBoxHeroClick
    end
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 280
    Top = 392
  end
  object PopupMenu: TPopupMenu
    Left = 784
    Top = 344
    object T1: TMenuItem
      Caption = #36386#38500#20154#29289
      OnClick = T1Click
    end
    object T2: TMenuItem
      Caption = #36386#38500#33521#38596
      OnClick = T2Click
    end
    object T3: TMenuItem
      Caption = #36386#38500#26426#22120#20154
      OnClick = T3Click
    end
  end
end
