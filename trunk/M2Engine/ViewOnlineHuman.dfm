object frmViewOnlineHuman: TfrmViewOnlineHuman
  Left = -139
  Top = 130
  Width = 812
  Height = 450
  Caption = 'Online Players'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object PanelStatus: TPanel
    Left = 0
    Top = 0
    Width = 804
    Height = 346
    Align = alClient
    Caption = '??????...'
    TabOrder = 0
    object GridHuman: TStringGrid
      Left = 1
      Top = 1
      Width = 802
      Height = 344
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
    Top = 346
    Width = 804
    Height = 70
    Align = alBottom
    TabOrder = 1
    object Label1: TLabel
      Left = 90
      Top = 25
      Width = 25
      Height = 15
      Caption = 'Sort:'
    end
    object Label2: TLabel
      Left = 430
      Top = 30
      Width = 24
      Height = 15
      Caption = '?? <'
    end
    object ButtonRefGrid: TButton
      Left = 10
      Top = 19
      Width = 71
      Height = 31
      Caption = 'Reload(&R)'
      TabOrder = 0
      OnClick = ButtonRefGridClick
    end
    object ComboBoxSort: TComboBox
      Left = 130
      Top = 25
      Width = 141
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 1
      OnClick = ComboBoxSortClick
      Items.Strings = (
        'Name'
        'Gender'
        'Job'
        'Level'
        'Map'
        'IP'
        'Permission Level'
        'Local IP')
    end
    object EditSearchName: TEdit
      Left = 280
      Top = 25
      Width = 141
      Height = 23
      TabOrder = 2
    end
    object ButtonSearch: TButton
      Left = 660
      Top = 19
      Width = 71
      Height = 31
      Caption = '??(&S)'
      TabOrder = 3
      OnClick = ButtonSearchClick
    end
    object ButtonView: TButton
      Left = 820
      Top = 19
      Width = 101
      Height = 31
      Caption = '????(&H)'
      TabOrder = 4
      OnClick = ButtonViewClick
    end
    object ButtonKick: TButton
      Left = 739
      Top = 19
      Width = 72
      Height = 31
      Caption = '???(&K)'
      ModalResult = 1
      TabOrder = 5
      OnClick = ButtonSearchClick
    end
    object EditLevel: TSpinEdit
      Left = 480
      Top = 25
      Width = 71
      Height = 24
      MaxValue = 65535
      MinValue = 0
      TabOrder = 6
      Value = 100
    end
    object MenuButtonOffLine: TRzMenuButton
      Left = 930
      Top = 20
      Width = 181
      Height = 31
      Caption = '????????(&K)'
      TabOrder = 7
      Margin = 3
      Spacing = 5
      DropDownMenu = PopupMenu
    end
    object CheckBoxHero: TCheckBox
      Left = 560
      Top = 25
      Width = 81
      Height = 21
      Caption = '????'
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
      Caption = '????'
      OnClick = T1Click
    end
    object T2: TMenuItem
      Caption = '????'
      OnClick = T2Click
    end
    object T3: TMenuItem
      Caption = '?????'
      OnClick = T3Click
    end
  end
end
