object frmOption: TfrmOption
  Left = 487
  Top = 310
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'IP Filter'
  ClientHeight = 329
  ClientWidth = 636
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
    Caption = 'Max Connect:'
  end
  object Label5: TLabel
    Left = 440
    Top = 44
    Width = 42
    Height = 12
    Caption = 'Con TimeOut:'
  end
  object Label11: TLabel
    Left = 440
    Top = 68
    Width = 78
    Height = 12
    Caption = 'Con Check:'
  end
  object Label1: TLabel
    Left = 440
    Top = 92
    Width = 54
    Height = 12
    Caption = 'Max On Count:'
  end
  object Label7: TLabel
    Left = 440
    Top = 116
    Width = 48
    Height = 12
    Caption = 'Load IP List:'
  end
  object GroupBoxActive: TGroupBox
    Left = 8
    Top = 8
    Width = 137
    Height = 257
    Caption = 'Block List'
    TabOrder = 0
    object LabelActive: TLabel
      Left = 8
      Top = 24
      Width = 54
      Height = 12
      Caption = 'test1:'
    end
    object ListBoxActiveList: TListBox
      Left = 8
      Top = 40
      Width = 121
      Height = 209
      Hint = ' command? Ctrl + F IP'
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
    Caption = 'Char Block List'
    TabOrder = 1
    object LabelBlock: TLabel
      Left = 8
      Top = 24
      Width = 54
      Height = 12
      Caption = 'test13:'
    end
    object ListBoxBlockList: TListBox
      Left = 13
      Top = 42
      Width = 121
      Height = 209
      Hint = 'hint box 2'
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
    Hint = 'hint box 6'
    MaxValue = 10000
    MinValue = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Value = 50
    OnChange = EditMaxConnectChange
  end
  object ButtonOK: TButton
    Left = 540
    Top = 296
    Width = 89
    Height = 25
    Caption = 'OK(&O)'
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
    Hint = 'hint box 5'
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
    Caption = 'IP Block List'
    TabOrder = 6
    object LabelIPArray: TLabel
      Left = 8
      Top = 24
      Width = 54
      Height = 12
      Caption = 'IPtest15:'
    end
    object ListBoxIPArrayList: TListBox
      Left = 8
      Top = 40
      Width = 121
      Height = 209
      Hint = 'box hint1'
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
    Hint = 'Max Online Count Edited'
    EditorEnabled = False
    MaxValue = 10000
    MinValue = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    Value = 500
    OnChange = EditMaxOnlineCountChange
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 268
    Width = 425
    Height = 53
    Caption = 'IP List Site'
    TabOrder = 8
    object Label6: TLabel
      Left = 8
      Top = 24
      Width = 42
      Height = 12
      Caption = 'IP List:'
    end
    object ButtonLoadIpList: TButton
      Left = 367
      Top = 20
      Width = 50
      Height = 20
      Caption = 'Save'
      TabOrder = 0
      OnClick = ButtonLoadIpListClick
    end
    object EditIpList: TEdit
      Left = 56
      Top = 20
      Width = 305
      Height = 20
      TabOrder = 1
      Text = 'http://www.cqfir.net/IpList.txt'
    end
  end
  object EditRefLoadIpListTime: TSpinEdit
    Left = 520
    Top = 112
    Width = 65
    Height = 21
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    Value = 5000
    OnChange = EditRefLoadIpListTimeChange
  end
  object ActiveListPopupMenu: TPopupMenu
    Left = 56
    Top = 160
    object APOPMENU_REFLIST: TMenuItem
      Caption = 'Ref List(&R)'
      OnClick = APOPMENU_REFLISTClick
    end
    object APOPMENU_BLOCKLIST: TMenuItem
      Caption = 'Block List(&D)'
      OnClick = APOPMENU_BLOCKLISTClick
    end
    object APOPMENU_ALLADDLIST: TMenuItem
      Caption = 'Add List(&S'
      OnClick = APOPMENU_ALLADDLISTClick
    end
    object APOPMENU_KICK: TMenuItem
      Caption = 'Kick(&K)'
      OnClick = APOPMENU_KICKClick
    end
  end
  object BlockListPopupMenu: TPopupMenu
    Left = 200
    Top = 160
    object BPOPMENU_REFLIST: TMenuItem
      Caption = 'Ref List(&R)'
      OnClick = BPOPMENU_REFLISTClick
    end
    object BPOPMENU_ADD: TMenuItem
      Caption = 'Add(&A)'
      OnClick = BPOPMENU_ADDClick
    end
    object BPOPMENU_CLEAR: TMenuItem
      Caption = 'Clear(&C)'
      OnClick = BPOPMENU_CLEARClick
    end
    object BPOPMENU_DELETE: TMenuItem
      Caption = 'Delete(&D)'
      OnClick = BPOPMENU_DELETEClick
    end
  end
  object ArrayPopupMenu: TPopupMenu
    Left = 352
    Top = 160
    object AYPOPMENU_REFLIST: TMenuItem
      Caption = 'Ref List(&R)'
      OnClick = AYPOPMENU_REFLISTClick
    end
    object AYPOPMENU_ADD: TMenuItem
      Caption = 'Add(&A)'
      OnClick = AYPOPMENU_ADDClick
    end
    object AYPOPMENU_CLEAR: TMenuItem
      Caption = 'Clear(&C)'
      OnClick = AYPOPMENU_CLEARClick
    end
    object AYPOPMENU_DELETE: TMenuItem
      Caption = 'Delete(&D)'
      OnClick = AYPOPMENU_DELETEClick
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'IpList|*.txt'
    Left = 440
    Top = 272
  end
end
