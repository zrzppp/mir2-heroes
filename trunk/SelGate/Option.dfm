object frmOption: TfrmOption
  Left = 478
  Top = 395
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'IP Filter'
  ClientHeight = 273
  ClientWidth = 637
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Label2: TLabel
    Left = 440
    Top = 20
    Width = 66
    Height = 12
    Caption = 'Max Con IP:'
  end
  object Label5: TLabel
    Left = 440
    Top = 44
    Width = 72
    Height = 12
    Caption = 'Con Timeout:'
  end
  object Label11: TLabel
    Left = 440
    Top = 68
    Width = 60
    Height = 12
    Caption = 'Con Check:'
  end
  object Label1: TLabel
    Left = 440
    Top = 92
    Width = 66
    Height = 12
    Caption = 'Max Online:'
  end
  object GroupBoxActive: TGroupBox
    Left = 8
    Top = 8
    Width = 137
    Height = 257
    Caption = 'Active List'
    TabOrder = 0
    object LabelActive: TLabel
      Left = 8
      Top = 24
      Width = 36
      Height = 12
      Caption = 'Lists:'
    end
    object ListBoxActiveList: TListBox
      Left = 8
      Top = 40
      Width = 121
      Height = 209
      Hint = 'This is the active block list'
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
    Caption = 'Block List'
    TabOrder = 1
    object LabelBlock: TLabel
      Left = 8
      Top = 24
      Width = 36
      Height = 12
      Caption = 'Lists:'
    end
    object ListBoxBlockList: TListBox
      Left = 13
      Top = 42
      Width = 121
      Height = 209
      Hint = 'This is your block list'
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
    Hint = '??IP??,?????????,????????????????'
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
    Caption = 'OK (&O)'
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
    Hint = '???????,??100'
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
    Caption = 'IP Array List'
    TabOrder = 6
    object LabelIPArray: TLabel
      Left = 8
      Top = 24
      Width = 36
      Height = 12
      Caption = 'Lists:'
    end
    object ListBoxIPArrayList: TListBox
      Left = 8
      Top = 40
      Width = 121
      Height = 209
      Hint = 'This is your IP array list'
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
    Hint = '?????????,??????????????'
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
      Caption = 'Ref (&R)'
      OnClick = APOPMENU_REFLISTClick
    end
    object APOPMENU_BLOCKLIST: TMenuItem
      Caption = 'Block List (&D)'
      OnClick = APOPMENU_BLOCKLISTClick
    end
    object APOPMENU_ALLADDLIST: TMenuItem
      Caption = 'Add List (&S'
      OnClick = APOPMENU_ALLADDLISTClick
    end
    object APOPMENU_KICK: TMenuItem
      Caption = 'Kick (&K)'
      OnClick = APOPMENU_KICKClick
    end
  end
  object BlockListPopupMenu: TPopupMenu
    Left = 200
    Top = 160
    object BPOPMENU_REFLIST: TMenuItem
      Caption = 'Ref (&R)'
      OnClick = BPOPMENU_REFLISTClick
    end
    object BPOPMENU_ADD: TMenuItem
      Caption = 'Add (&A)'
      OnClick = BPOPMENU_ADDClick
    end
    object BPOPMENU_CLEAR: TMenuItem
      Caption = 'Clear (&C)'
      OnClick = BPOPMENU_CLEARClick
    end
    object BPOPMENU_DELETE: TMenuItem
      Caption = 'Delete (&D)'
      OnClick = BPOPMENU_DELETEClick
    end
  end
  object ArrayPopupMenu: TPopupMenu
    Left = 352
    Top = 160
    object AYPOPMENU_REFLIST: TMenuItem
      Caption = 'Ref (&R)'
      OnClick = AYPOPMENU_REFLISTClick
    end
    object AYPOPMENU_ADD: TMenuItem
      Caption = 'Add (&A)'
      OnClick = AYPOPMENU_ADDClick
    end
    object AYPOPMENU_CLEAR: TMenuItem
      Caption = 'Clear (&C)'
      OnClick = AYPOPMENU_CLEARClick
    end
    object AYPOPMENU_DELETE: TMenuItem
      Caption = 'Delete (&D)'
      OnClick = AYPOPMENU_DELETEClick
    end
  end
end
