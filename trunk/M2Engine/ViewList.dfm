object frmViewList: TfrmViewList
  Left = 272
  Top = 238
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '??????'
  ClientHeight = 534
  ClientWidth = 925
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object PageControlViewList: TPageControl
    Left = 9
    Top = 9
    Width = 907
    Height = 515
    ActivePage = TabSheet17
    MultiLine = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Make Disable'
      object GroupBox3: TGroupBox
        Left = 9
        Top = 5
        Width = 207
        Height = 426
        Caption = 'Disable Make List'
        TabOrder = 0
        object ListBoxDisableMakeList: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxDisableMakeListClick
        end
      end
      object GroupBox4: TGroupBox
        Left = 336
        Top = 5
        Width = 207
        Height = 426
        Caption = 'Item List'
        TabOrder = 1
        object ListBoxitemList1: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          ItemHeight = 14
          MultiSelect = True
          TabOrder = 0
          OnClick = ListBoxitemList1Click
        end
      end
      object ButtonDisableMakeAdd: TButton
        Left = 233
        Top = 28
        Width = 86
        Height = 29
        Caption = 'Add'
        TabOrder = 2
        OnClick = ButtonDisableMakeAddClick
      end
      object ButtonDisableMakeDelete: TButton
        Left = 233
        Top = 65
        Width = 86
        Height = 30
        Caption = 'Delete'
        TabOrder = 3
        OnClick = ButtonDisableMakeDeleteClick
      end
      object ButtonDisableMakeSave: TButton
        Left = 233
        Top = 177
        Width = 86
        Height = 30
        Caption = 'Save'
        TabOrder = 4
        OnClick = ButtonDisableMakeSaveClick
      end
      object ButtonDisableMakeAddAll: TButton
        Left = 233
        Top = 103
        Width = 86
        Height = 29
        Caption = 'Add All'
        TabOrder = 5
        OnClick = ButtonDisableMakeAddAllClick
      end
      object ButtonDisableMakeDeleteAll: TButton
        Left = 233
        Top = 140
        Width = 86
        Height = 29
        Caption = 'Delete All'
        TabOrder = 6
        OnClick = ButtonDisableMakeDeleteAllClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Make Enable'
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 336
        Top = 5
        Width = 207
        Height = 426
        Caption = 'Item List'
        TabOrder = 0
        object ListBoxItemList: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxItemListClick
        end
      end
      object GroupBox1: TGroupBox
        Left = 9
        Top = 5
        Width = 207
        Height = 426
        Caption = 'Enabled Make List'
        TabOrder = 1
        object ListBoxEnableMakeList: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxEnableMakeListClick
        end
      end
      object ButtonEnableMakeAdd: TButton
        Left = 233
        Top = 28
        Width = 86
        Height = 29
        Caption = 'Add'
        TabOrder = 2
        OnClick = ButtonEnableMakeAddClick
      end
      object ButtonEnableMakeDelete: TButton
        Left = 233
        Top = 65
        Width = 86
        Height = 30
        Caption = 'Delete'
        TabOrder = 3
        OnClick = ButtonEnableMakeDeleteClick
      end
      object ButtonEnableMakeSave: TButton
        Left = 233
        Top = 177
        Width = 86
        Height = 30
        Caption = 'Save'
        TabOrder = 4
        OnClick = ButtonEnableMakeSaveClick
      end
      object ButtonEnableMakeAddAll: TButton
        Left = 233
        Top = 103
        Width = 86
        Height = 29
        Caption = 'Add All'
        TabOrder = 5
        OnClick = ButtonEnableMakeAddAllClick
      end
      object ButtonEnableMakeDeleteAll: TButton
        Left = 233
        Top = 140
        Width = 86
        Height = 29
        Caption = 'Delete All'
        TabOrder = 6
        OnClick = ButtonEnableMakeDeleteAllClick
      end
    end
    object TabSheet8: TTabSheet
      Hint = '??????,???????????????,??????????'
      Caption = 'Log'
      ImageIndex = 8
      object GroupBox8: TGroupBox
        Left = 9
        Top = 5
        Width = 207
        Height = 426
        Caption = 'Game Log'
        TabOrder = 0
        object ListBoxGameLogList: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxGameLogListClick
        end
      end
      object ButtonGameLogAdd: TButton
        Left = 233
        Top = 28
        Width = 86
        Height = 29
        Caption = 'Add'
        TabOrder = 1
        OnClick = ButtonGameLogAddClick
      end
      object ButtonGameLogDel: TButton
        Left = 233
        Top = 65
        Width = 86
        Height = 30
        Caption = 'Delete'
        TabOrder = 2
        OnClick = ButtonGameLogDelClick
      end
      object ButtonGameLogAddAll: TButton
        Left = 233
        Top = 103
        Width = 86
        Height = 29
        Caption = 'Add All'
        TabOrder = 3
        OnClick = ButtonGameLogAddAllClick
      end
      object ButtonGameLogDelAll: TButton
        Left = 233
        Top = 140
        Width = 86
        Height = 29
        Caption = 'Delete All'
        TabOrder = 4
        OnClick = ButtonGameLogDelAllClick
      end
      object ButtonGameLogSave: TButton
        Left = 233
        Top = 177
        Width = 86
        Height = 30
        Caption = 'Save'
        TabOrder = 5
        OnClick = ButtonGameLogSaveClick
      end
      object GroupBox9: TGroupBox
        Left = 336
        Top = 5
        Width = 207
        Height = 426
        Caption = 'List'
        TabOrder = 6
        object ListBoxitemList2: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxitemList2Click
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Map'
      ImageIndex = 2
      object GroupBox5: TGroupBox
        Left = 9
        Top = 5
        Width = 207
        Height = 426
        Caption = 'Disable Map Move'
        TabOrder = 0
        object ListBoxDisableMoveMap: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxDisableMoveMapClick
        end
      end
      object ButtonDisableMoveMapAdd: TButton
        Left = 233
        Top = 28
        Width = 86
        Height = 29
        Caption = 'Add'
        TabOrder = 1
        OnClick = ButtonDisableMoveMapAddClick
      end
      object ButtonDisableMoveMapDelete: TButton
        Left = 233
        Top = 65
        Width = 86
        Height = 30
        Caption = 'Delete'
        TabOrder = 2
        OnClick = ButtonDisableMoveMapDeleteClick
      end
      object ButtonDisableMoveMapAddAll: TButton
        Left = 233
        Top = 103
        Width = 86
        Height = 29
        Caption = 'Add All'
        TabOrder = 3
        OnClick = ButtonDisableMoveMapAddAllClick
      end
      object ButtonDisableMoveMapDeleteAll: TButton
        Left = 233
        Top = 140
        Width = 86
        Height = 29
        Caption = 'Delete All'
        TabOrder = 4
        OnClick = ButtonDisableMoveMapDeleteAllClick
      end
      object ButtonDisableMoveMapSave: TButton
        Left = 233
        Top = 177
        Width = 86
        Height = 30
        Caption = 'Save'
        TabOrder = 5
        OnClick = ButtonDisableMoveMapSaveClick
      end
      object GroupBox6: TGroupBox
        Left = 336
        Top = 5
        Width = 207
        Height = 426
        Caption = 'List'
        TabOrder = 6
        object ListBoxMapList: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxMapListClick
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Upgrade'
      ImageIndex = 3
      object GroupBox26: TGroupBox
        Left = 9
        Top = 5
        Width = 207
        Height = 426
        Caption = 'Upgrade List'
        TabOrder = 0
        object ListBox1: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBox1Click
        end
      end
      object GroupBox27: TGroupBox
        Left = 336
        Top = 5
        Width = 207
        Height = 426
        Caption = 'List'
        TabOrder = 1
        object ListBox2: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBox2Click
        end
      end
      object ButtonUpgradeAdd: TButton
        Left = 233
        Top = 28
        Width = 86
        Height = 29
        Caption = 'Add'
        Enabled = False
        TabOrder = 2
        OnClick = ButtonUpgradeAddClick
      end
      object ButtonUpgradeDel: TButton
        Left = 233
        Top = 65
        Width = 86
        Height = 30
        Caption = 'Delete'
        Enabled = False
        TabOrder = 3
        OnClick = ButtonUpgradeDelClick
      end
      object ButtonUpgradeAddAll: TButton
        Left = 233
        Top = 103
        Width = 86
        Height = 29
        Caption = 'Add All'
        TabOrder = 4
        OnClick = ButtonUpgradeAddAllClick
      end
      object ButtonUpgradeDelAll: TButton
        Left = 233
        Top = 140
        Width = 86
        Height = 29
        Caption = 'Delete All'
        TabOrder = 5
        OnClick = ButtonUpgradeDelAllClick
      end
      object ButtonUpgradesave: TButton
        Left = 233
        Top = 177
        Width = 86
        Height = 30
        Caption = 'Save'
        TabOrder = 6
        OnClick = ButtonUpgradesaveClick
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Bind'
      ImageIndex = 4
      object GridItemBindAccount: TStringGrid
        Left = 9
        Top = 9
        Width = 394
        Height = 422
        Hint = '????????????????????,????????????????????????'
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = GridItemBindAccountClick
        ColWidths = (
          91
          63
          68
          88)
      end
      object GroupBox16: TGroupBox
        Left = 411
        Top = 9
        Width = 278
        Height = 207
        Caption = 'Account Item'
        TabOrder = 1
        object Label6: TLabel
          Left = 9
          Top = 49
          Width = 17
          Height = 14
          Caption = 'Idx'
        end
        object Label7: TLabel
          Left = 9
          Top = 77
          Width = 49
          Height = 14
          Caption = 'Make Idx'
        end
        object Label8: TLabel
          Left = 9
          Top = 105
          Width = 81
          Height = 14
          Caption = 'Account Name'
        end
        object Label9: TLabel
          Left = 9
          Top = 21
          Width = 31
          Height = 14
          Caption = 'Name'
        end
        object ButtonItemBindAcountMod: TButton
          Left = 184
          Top = 171
          Width = 76
          Height = 29
          Caption = 'Modify'
          TabOrder = 0
          OnClick = ButtonItemBindAcountModClick
        end
        object EditItemBindAccountItemIdx: TSpinEdit
          Left = 135
          Top = 46
          Width = 109
          Height = 23
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemBindAccountItemIdxChange
        end
        object EditItemBindAccountItemMakeIdx: TSpinEdit
          Left = 135
          Top = 74
          Width = 109
          Height = 23
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditItemBindAccountItemMakeIdxChange
        end
        object EditItemBindAccountItemName: TEdit
          Left = 135
          Top = 19
          Width = 109
          Height = 22
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonItemBindAcountAdd: TButton
          Left = 9
          Top = 131
          Width = 76
          Height = 29
          Caption = 'Add'
          TabOrder = 4
          OnClick = ButtonItemBindAcountAddClick
        end
        object ButtonItemBindAcountRef: TButton
          Left = 184
          Top = 136
          Width = 76
          Height = 29
          Caption = 'Ref'
          TabOrder = 5
          OnClick = ButtonItemBindAcountRefClick
        end
        object ButtonItemBindAcountDel: TButton
          Left = 9
          Top = 168
          Width = 76
          Height = 29
          Caption = 'Delete'
          TabOrder = 6
          OnClick = ButtonItemBindAcountDelClick
        end
        object EditItemBindAccountName: TEdit
          Left = 135
          Top = 103
          Width = 109
          Height = 22
          TabOrder = 7
          OnChange = EditItemBindAccountNameChange
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Item Bind'
      ImageIndex = 5
      object GridItemBindCharName: TStringGrid
        Left = 9
        Top = 9
        Width = 394
        Height = 422
        Hint = '????????????????????,????????????????'
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = GridItemBindCharNameClick
        ColWidths = (
          91
          63
          68
          88)
      end
      object GroupBox17: TGroupBox
        Left = 411
        Top = 9
        Width = 197
        Height = 207
        Caption = 'Item Bind Char Name'
        TabOrder = 1
        object Label10: TLabel
          Left = 9
          Top = 49
          Width = 17
          Height = 14
          Caption = 'Idx'
        end
        object Label11: TLabel
          Left = 9
          Top = 77
          Width = 58
          Height = 14
          Caption = 'Market Idx'
        end
        object Label12: TLabel
          Left = 9
          Top = 105
          Width = 59
          Height = 14
          Caption = 'Char Name'
        end
        object Label13: TLabel
          Left = 9
          Top = 21
          Width = 31
          Height = 14
          Caption = 'Name'
        end
        object ButtonItemBindCharNameMod: TButton
          Left = 112
          Top = 131
          Width = 76
          Height = 29
          Caption = 'Modify'
          TabOrder = 0
          OnClick = ButtonItemBindCharNameModClick
        end
        object EditItemBindCharNameItemIdx: TSpinEdit
          Left = 79
          Top = 46
          Width = 109
          Height = 23
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemBindCharNameItemIdxChange
        end
        object EditItemBindCharNameItemMakeIdx: TSpinEdit
          Left = 79
          Top = 74
          Width = 109
          Height = 23
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditItemBindCharNameItemMakeIdxChange
        end
        object EditItemBindCharNameItemName: TEdit
          Left = 79
          Top = 19
          Width = 109
          Height = 22
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonItemBindCharNameAdd: TButton
          Left = 9
          Top = 131
          Width = 76
          Height = 29
          Caption = 'Add'
          TabOrder = 4
          OnClick = ButtonItemBindCharNameAddClick
        end
        object ButtonItemBindCharNameRef: TButton
          Left = 112
          Top = 168
          Width = 76
          Height = 29
          Caption = 'Ref'
          TabOrder = 5
          OnClick = ButtonItemBindCharNameRefClick
        end
        object ButtonItemBindCharNameDel: TButton
          Left = 9
          Top = 168
          Width = 76
          Height = 29
          Caption = 'Delete'
          TabOrder = 6
          OnClick = ButtonItemBindCharNameDelClick
        end
        object EditItemBindCharNameName: TEdit
          Left = 79
          Top = 103
          Width = 109
          Height = 22
          TabOrder = 7
          OnChange = EditItemBindCharNameNameChange
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Ip'
      ImageIndex = 6
      object GridItemBindIPaddr: TStringGrid
        Left = 9
        Top = 9
        Width = 394
        Height = 422
        Hint = '????????????????IP????,????????IP????????????????'
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = GridItemBindIPaddrClick
        ColWidths = (
          91
          63
          68
          88)
      end
      object GroupBox18: TGroupBox
        Left = 411
        Top = 9
        Width = 197
        Height = 207
        Caption = '????'
        TabOrder = 1
        object Label14: TLabel
          Left = 9
          Top = 49
          Width = 35
          Height = 14
          Caption = '??IDX:'
        end
        object Label15: TLabel
          Left = 9
          Top = 77
          Width = 28
          Height = 14
          Caption = '????:'
        end
        object Label16: TLabel
          Left = 9
          Top = 105
          Width = 27
          Height = 14
          Caption = '??IP:'
        end
        object Label17: TLabel
          Left = 9
          Top = 21
          Width = 28
          Height = 14
          Caption = '????:'
        end
        object ButtonItemBindIPaddrMod: TButton
          Left = 112
          Top = 131
          Width = 76
          Height = 29
          Caption = '??(&S)'
          TabOrder = 0
          OnClick = ButtonItemBindIPaddrModClick
        end
        object EditItemBindIPaddrItemIdx: TSpinEdit
          Left = 79
          Top = 46
          Width = 109
          Height = 23
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemBindIPaddrItemIdxChange
        end
        object EditItemBindIPaddrItemMakeIdx: TSpinEdit
          Left = 79
          Top = 74
          Width = 109
          Height = 23
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditItemBindIPaddrItemMakeIdxChange
        end
        object EditItemBindIPaddrItemName: TEdit
          Left = 79
          Top = 19
          Width = 109
          Height = 22
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonItemBindIPaddrAdd: TButton
          Left = 9
          Top = 131
          Width = 76
          Height = 29
          Caption = '??(&A)'
          TabOrder = 4
          OnClick = ButtonItemBindIPaddrAddClick
        end
        object ButtonItemBindIPaddrRef: TButton
          Left = 112
          Top = 168
          Width = 76
          Height = 29
          Caption = '??(&R)'
          TabOrder = 5
          OnClick = ButtonItemBindIPaddrRefClick
        end
        object ButtonItemBindIPaddrDel: TButton
          Left = 9
          Top = 168
          Width = 76
          Height = 29
          Caption = '??(&D)'
          TabOrder = 6
          OnClick = ButtonItemBindIPaddrDelClick
        end
        object EditItemBindIPaddrName: TEdit
          Left = 79
          Top = 103
          Width = 109
          Height = 22
          TabOrder = 7
          OnChange = EditItemBindIPaddrNameChange
        end
      end
    end
    object TabSheet12: TTabSheet
      Caption = 'Name'
      ImageIndex = 12
      object GridItemNameList: TStringGrid
        Left = 9
        Top = 9
        Width = 394
        Height = 422
        ColCount = 3
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = GridItemNameListClick
        ColWidths = (
          97
          69
          145)
      end
      object GroupBox19: TGroupBox
        Left = 411
        Top = 9
        Width = 197
        Height = 422
        Caption = 'Item Name'
        TabOrder = 1
        object Label18: TLabel
          Left = 9
          Top = 49
          Width = 17
          Height = 14
          Caption = 'Idx'
        end
        object Label19: TLabel
          Left = 9
          Top = 77
          Width = 63
          Height = 14
          Caption = 'Make Index'
        end
        object Label20: TLabel
          Left = 9
          Top = 105
          Width = 60
          Height = 14
          Caption = 'New Name'
        end
        object Label21: TLabel
          Left = 9
          Top = 21
          Width = 53
          Height = 14
          Caption = 'Old Name'
        end
        object ButtonItemNameMod: TButton
          Left = 112
          Top = 131
          Width = 76
          Height = 29
          Caption = 'Modify'
          TabOrder = 0
          OnClick = ButtonItemNameModClick
        end
        object EditItemNameIdx: TSpinEdit
          Left = 79
          Top = 46
          Width = 109
          Height = 23
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemNameIdxChange
        end
        object EditItemNameMakeIndex: TSpinEdit
          Left = 79
          Top = 74
          Width = 109
          Height = 23
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditItemNameMakeIndexChange
        end
        object EditItemNameOldName: TEdit
          Left = 79
          Top = 19
          Width = 109
          Height = 22
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonItemNameAdd: TButton
          Left = 9
          Top = 131
          Width = 76
          Height = 29
          Caption = 'Add'
          TabOrder = 4
          OnClick = ButtonItemNameAddClick
        end
        object ButtonItemNameRef: TButton
          Left = 112
          Top = 168
          Width = 76
          Height = 29
          Caption = 'Ref'
          TabOrder = 5
          OnClick = ButtonItemNameRefClick
        end
        object ButtonItemNameDel: TButton
          Left = 9
          Top = 168
          Width = 76
          Height = 29
          Caption = 'Delete'
          TabOrder = 6
          OnClick = ButtonItemNameDelClick
        end
        object EditItemNameNewName: TEdit
          Left = 79
          Top = 103
          Width = 109
          Height = 22
          TabOrder = 7
          OnChange = EditItemNameNewNameChange
        end
      end
    end
    object TabSheetMonDrop: TTabSheet
      Caption = 'Drop'
      ImageIndex = 7
      object StringGridMonDropLimit: TStringGrid
        Left = 9
        Top = 9
        Width = 328
        Height = 422
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = StringGridMonDropLimitClick
        ColWidths = (
          81
          64
          57
          52)
      end
      object GroupBox7: TGroupBox
        Left = 345
        Top = 9
        Width = 198
        Height = 422
        Caption = 'Mon Drop Limit'
        TabOrder = 1
        object Label29: TLabel
          Left = 9
          Top = 49
          Width = 63
          Height = 14
          Caption = 'Drop Count'
        end
        object Label1: TLabel
          Left = 9
          Top = 77
          Width = 25
          Height = 14
          Caption = 'Limit'
        end
        object Label2: TLabel
          Left = 9
          Top = 105
          Width = 82
          Height = 14
          Caption = 'No Drop Count'
        end
        object Label3: TLabel
          Left = 9
          Top = 21
          Width = 61
          Height = 14
          Caption = 'Item Name'
        end
        object ButtonMonDropLimitSave: TButton
          Left = 112
          Top = 131
          Width = 76
          Height = 29
          Caption = 'Modify'
          TabOrder = 0
          OnClick = ButtonMonDropLimitSaveClick
        end
        object EditDropCount: TSpinEdit
          Left = 111
          Top = 46
          Width = 72
          Height = 23
          MaxValue = 100000
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditDropCountChange
        end
        object EditCountLimit: TSpinEdit
          Left = 111
          Top = 74
          Width = 72
          Height = 23
          MaxValue = 100000
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditCountLimitChange
        end
        object EditNoDropCount: TSpinEdit
          Left = 111
          Top = 102
          Width = 72
          Height = 23
          MaxValue = 100000
          MinValue = 0
          TabOrder = 3
          Value = 10
          OnChange = EditNoDropCountChange
        end
        object EditItemName: TEdit
          Left = 79
          Top = 19
          Width = 104
          Height = 22
          TabOrder = 4
        end
        object ButtonMonDropLimitAdd: TButton
          Left = 9
          Top = 131
          Width = 76
          Height = 29
          Caption = 'Add'
          TabOrder = 5
          OnClick = ButtonMonDropLimitAddClick
        end
        object ButtonMonDropLimitRef: TButton
          Left = 112
          Top = 168
          Width = 76
          Height = 29
          Caption = 'Ref'
          TabOrder = 6
          OnClick = ButtonMonDropLimitRefClick
        end
        object ButtonMonDropLimitDel: TButton
          Left = 9
          Top = 168
          Width = 76
          Height = 29
          Caption = 'Delete'
          TabOrder = 7
          OnClick = ButtonMonDropLimitDelClick
        end
      end
    end
    object TabSheet9: TTabSheet
      Hint = '????????,????????????????????,????????'
      Caption = 'Take Off'
      ImageIndex = 9
      object GroupBox10: TGroupBox
        Left = 9
        Top = 5
        Width = 207
        Height = 426
        Caption = 'Disable Take Off Item List'
        TabOrder = 0
        object ListBoxDisableTakeOffList: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          Hint = '????????,????????????????????,????????'
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxDisableTakeOffListClick
        end
      end
      object ButtonDisableTakeOffAdd: TButton
        Left = 233
        Top = 28
        Width = 86
        Height = 29
        Caption = 'Add'
        TabOrder = 1
        OnClick = ButtonDisableTakeOffAddClick
      end
      object ButtonDisableTakeOffDel: TButton
        Left = 233
        Top = 65
        Width = 86
        Height = 30
        Caption = 'Delete'
        TabOrder = 2
        OnClick = ButtonDisableTakeOffDelClick
      end
      object ButtonDisableTakeOffAddAll: TButton
        Left = 233
        Top = 103
        Width = 86
        Height = 29
        Caption = 'Add All'
        TabOrder = 3
        OnClick = ButtonDisableTakeOffAddAllClick
      end
      object ButtonDisableTakeOffDelAll: TButton
        Left = 233
        Top = 140
        Width = 86
        Height = 29
        Caption = 'Delete All'
        TabOrder = 4
        OnClick = ButtonDisableTakeOffDelAllClick
      end
      object ButtonDisableTakeOffSave: TButton
        Left = 233
        Top = 177
        Width = 86
        Height = 30
        Caption = 'Save'
        TabOrder = 5
        OnClick = ButtonDisableTakeOffSaveClick
      end
      object GroupBox11: TGroupBox
        Left = 336
        Top = 5
        Width = 207
        Height = 426
        Caption = 'List'
        TabOrder = 6
        object ListBoxitemList3: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxitemList3Click
        end
      end
    end
    object TabSheet13: TTabSheet
      Caption = 'Sell'
      ImageIndex = 10
      object GroupBox20: TGroupBox
        Left = 9
        Top = 5
        Width = 207
        Height = 426
        Caption = 'Disable Sell Item List'
        TabOrder = 0
        object ListBoxSellOffList: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          Hint = '????????,???????????????'
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxSellOffListClick
        end
      end
      object GroupBox21: TGroupBox
        Left = 336
        Top = 5
        Width = 207
        Height = 426
        Caption = 'List'
        TabOrder = 1
        object ListBoxitemList4: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxitemList4Click
        end
      end
      object ButtonSellOffAdd: TButton
        Left = 233
        Top = 28
        Width = 86
        Height = 29
        Caption = 'Add'
        TabOrder = 2
        OnClick = ButtonSellOffAddClick
      end
      object ButtonSellOffDel: TButton
        Left = 233
        Top = 65
        Width = 86
        Height = 30
        Caption = 'Delete'
        TabOrder = 3
        OnClick = ButtonSellOffDelClick
      end
      object ButtonSellOffAddAll: TButton
        Left = 233
        Top = 103
        Width = 86
        Height = 29
        Caption = 'Add All'
        TabOrder = 4
        OnClick = ButtonSellOffAddAllClick
      end
      object ButtonSellOffDelAll: TButton
        Left = 233
        Top = 140
        Width = 86
        Height = 29
        Caption = 'Delete All'
        TabOrder = 5
        OnClick = ButtonSellOffDelAllClick
      end
      object ButtonSellOffSave: TButton
        Left = 233
        Top = 177
        Width = 86
        Height = 30
        Caption = 'Save'
        TabOrder = 6
        OnClick = ButtonSellOffSaveClick
      end
    end
    object TabSheet11: TTabSheet
      Caption = 'Mon'
      ImageIndex = 11
      object GroupBox13: TGroupBox
        Left = 9
        Top = 4
        Width = 207
        Height = 427
        Caption = 'No Clear Mon List'
        TabOrder = 0
        object ListBoxNoClearMonList: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 402
          Hint = '????????,??????CLEARMAPMON,????????,???????????????'
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxNoClearMonListClick
        end
      end
      object ButtonNoClearMonAdd: TButton
        Left = 233
        Top = 28
        Width = 86
        Height = 29
        Caption = 'Add'
        TabOrder = 1
        OnClick = ButtonNoClearMonAddClick
      end
      object ButtonNoClearMonDel: TButton
        Left = 233
        Top = 65
        Width = 86
        Height = 30
        Caption = 'Delete'
        TabOrder = 2
        OnClick = ButtonNoClearMonDelClick
      end
      object ButtonNoClearMonAddAll: TButton
        Left = 233
        Top = 103
        Width = 86
        Height = 29
        Caption = 'Add All'
        TabOrder = 3
        OnClick = ButtonNoClearMonAddAllClick
      end
      object ButtonNoClearMonDelAll: TButton
        Left = 233
        Top = 140
        Width = 86
        Height = 29
        Caption = 'Delete All'
        TabOrder = 4
        OnClick = ButtonNoClearMonDelAllClick
      end
      object ButtonNoClearMonSave: TButton
        Left = 233
        Top = 177
        Width = 86
        Height = 30
        Caption = 'Save'
        TabOrder = 5
        OnClick = ButtonNoClearMonSaveClick
      end
      object GroupBox14: TGroupBox
        Left = 336
        Top = 4
        Width = 207
        Height = 427
        Caption = 'List'
        TabOrder = 6
        object ListBoxMonList: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 402
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxMonListClick
        end
      end
    end
    object TabSheet10: TTabSheet
      Caption = 'Admin'
      ImageIndex = 10
      object GroupBox12: TGroupBox
        Left = 9
        Top = 5
        Width = 319
        Height = 426
        Caption = 'List'
        TabOrder = 0
        object ListBoxAdminList: TListBox
          Left = 9
          Top = 19
          Width = 300
          Height = 393
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxAdminListClick
        end
      end
      object GroupBox15: TGroupBox
        Left = 336
        Top = 5
        Width = 244
        Height = 164
        Caption = 'Admin'
        TabOrder = 1
        object Label4: TLabel
          Left = 9
          Top = 23
          Width = 31
          Height = 14
          Caption = 'Name'
        end
        object Label5: TLabel
          Left = 9
          Top = 51
          Width = 56
          Height = 14
          Caption = 'Permission'
        end
        object LabelAdminIPaddr: TLabel
          Left = 9
          Top = 79
          Width = 11
          Height = 14
          Caption = 'Ip'
        end
        object EditAdminName: TEdit
          Left = 75
          Top = 19
          Width = 113
          Height = 22
          TabOrder = 0
        end
        object EditAdminPremission: TSpinEdit
          Left = 91
          Top = 46
          Width = 71
          Height = 23
          MaxValue = 10
          MinValue = 1
          TabOrder = 1
          Value = 10
        end
        object ButtonAdminListAdd: TButton
          Left = 19
          Top = 121
          Width = 66
          Height = 30
          Caption = 'Add'
          TabOrder = 2
          OnClick = ButtonAdminListAddClick
        end
        object ButtonAdminListChange: TButton
          Left = 93
          Top = 121
          Width = 67
          Height = 30
          Caption = 'Change'
          TabOrder = 3
          OnClick = ButtonAdminListChangeClick
        end
        object ButtonAdminListDel: TButton
          Left = 168
          Top = 121
          Width = 67
          Height = 30
          Caption = 'Delete'
          TabOrder = 4
          OnClick = ButtonAdminListDelClick
        end
        object EditAdminIPaddr: TEdit
          Left = 75
          Top = 75
          Width = 113
          Height = 22
          TabOrder = 5
        end
      end
      object ButtonAdminLitsSave: TButton
        Left = 513
        Top = 177
        Width = 67
        Height = 30
        Caption = 'Save'
        TabOrder = 2
        OnClick = ButtonAdminLitsSaveClick
      end
    end
    object TabSheet14: TTabSheet
      Caption = 'Pick Up'
      ImageIndex = 14
      object GroupBox22: TGroupBox
        Left = 9
        Top = 5
        Width = 207
        Height = 426
        Caption = 'Disable   Pick Up Item'
        TabOrder = 0
        object ListBoxAllowPickUpItem: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          Hint = '??????????,??????????????'
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxAllowPickUpItemClick
        end
      end
      object GroupBox23: TGroupBox
        Left = 336
        Top = 5
        Width = 207
        Height = 426
        Caption = 'List'
        TabOrder = 1
        object ListBoxitemList5: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxitemList5Click
        end
      end
      object ButtonPickItemAdd: TButton
        Left = 233
        Top = 28
        Width = 86
        Height = 29
        Caption = 'Add'
        TabOrder = 2
        OnClick = ButtonPickItemAddClick
      end
      object ButtonPickItemDel: TButton
        Left = 233
        Top = 65
        Width = 86
        Height = 30
        Caption = 'Delete'
        TabOrder = 3
        OnClick = ButtonPickItemDelClick
      end
      object ButtonPickItemAddAll: TButton
        Left = 233
        Top = 103
        Width = 86
        Height = 29
        Caption = 'Add All'
        TabOrder = 4
        OnClick = ButtonPickItemAddAllClick
      end
      object ButtonPickItemDelAll: TButton
        Left = 233
        Top = 140
        Width = 86
        Height = 29
        Caption = 'Delete All'
        TabOrder = 5
        OnClick = ButtonPickItemDelAllClick
      end
      object ButtonPickItemSave: TButton
        Left = 233
        Top = 177
        Width = 86
        Height = 30
        Caption = 'Save'
        TabOrder = 6
        OnClick = ButtonPickItemSaveClick
      end
    end
    object TabSheet15: TTabSheet
      Caption = 'Item'
      ImageIndex = 15
      object lbl29: TLabel
        Left = 9
        Top = 405
        Width = 24
        Height = 14
        Caption = '?  ?:'
      end
      object ButtonGroupItemAdd: TButton
        Left = 476
        Top = 392
        Width = 76
        Height = 29
        Caption = 'Add'
        TabOrder = 0
        OnClick = ButtonGroupItemAddClick
      end
      object ButtonGroupItemDel: TButton
        Left = 560
        Top = 392
        Width = 76
        Height = 29
        Caption = 'Delete'
        Enabled = False
        TabOrder = 1
        OnClick = ButtonGroupItemDelClick
      end
      object ButtonGroupItemChg: TButton
        Left = 644
        Top = 392
        Width = 76
        Height = 29
        Caption = 'Modify'
        Enabled = False
        TabOrder = 2
        OnClick = ButtonGroupItemChgClick
      end
      object ButtonGroupItemSave: TButton
        Left = 728
        Top = 392
        Width = 76
        Height = 29
        Caption = 'Save'
        Enabled = False
        TabOrder = 3
        OnClick = ButtonGroupItemSaveClick
      end
      object GroupBoxUseGroupItem: TGroupBox
        Left = 5
        Top = 5
        Width = 192
        Height = 388
        Caption = 'Item'
        TabOrder = 4
        object Label31: TLabel
          Left = 9
          Top = 23
          Width = 29
          Height = 14
          Caption = 'Dress'
        end
        object Label32: TLabel
          Left = 9
          Top = 51
          Width = 46
          Height = 14
          Caption = 'Weapon'
        end
        object Label33: TLabel
          Left = 9
          Top = 107
          Width = 48
          Height = 14
          Caption = 'Necklace'
        end
        object Label34: TLabel
          Left = 9
          Top = 79
          Width = 39
          Height = 14
          Caption = 'R Hand'
        end
        object Label35: TLabel
          Left = 9
          Top = 219
          Width = 33
          Height = 14
          Caption = 'L Ring'
        end
        object Label36: TLabel
          Left = 9
          Top = 191
          Width = 41
          Height = 14
          Caption = 'R Brace'
        end
        object Label37: TLabel
          Left = 9
          Top = 163
          Width = 40
          Height = 14
          Caption = 'L Brace'
        end
        object Label38: TLabel
          Left = 9
          Top = 135
          Width = 39
          Height = 14
          Caption = 'Helmet'
        end
        object Label39: TLabel
          Left = 9
          Top = 275
          Width = 24
          Height = 14
          Caption = '?  ?:'
        end
        object Label40: TLabel
          Left = 9
          Top = 247
          Width = 34
          Height = 14
          Caption = 'R Ring'
        end
        object Label41: TLabel
          Left = 9
          Top = 303
          Width = 21
          Height = 14
          Caption = 'Belt'
        end
        object Label42: TLabel
          Left = 9
          Top = 331
          Width = 26
          Height = 14
          Caption = 'Boot'
        end
        object Label43: TLabel
          Left = 9
          Top = 359
          Width = 34
          Height = 14
          Caption = 'Charm'
        end
        object EditDRESSNAME: TEdit
          Left = 65
          Top = 19
          Width = 114
          Height = 22
          MaxLength = 14
          TabOrder = 0
        end
        object EditWEAPONNAME: TEdit
          Tag = 1
          Left = 65
          Top = 47
          Width = 114
          Height = 22
          MaxLength = 14
          TabOrder = 1
        end
        object EditNECKLACENAME: TEdit
          Tag = 3
          Left = 65
          Top = 103
          Width = 114
          Height = 22
          MaxLength = 14
          TabOrder = 2
        end
        object EditRIGHTHANDNAME: TEdit
          Tag = 2
          Left = 65
          Top = 75
          Width = 114
          Height = 22
          MaxLength = 14
          TabOrder = 3
        end
        object EditRINGLNAME: TEdit
          Tag = 7
          Left = 65
          Top = 215
          Width = 114
          Height = 22
          MaxLength = 14
          TabOrder = 4
        end
        object EditARMRINGRNAME: TEdit
          Tag = 6
          Left = 65
          Top = 187
          Width = 114
          Height = 22
          MaxLength = 14
          TabOrder = 5
        end
        object EditARMRINGLNAME: TEdit
          Tag = 5
          Left = 65
          Top = 159
          Width = 114
          Height = 22
          MaxLength = 14
          TabOrder = 6
        end
        object EditHELMETNAME: TEdit
          Tag = 4
          Left = 65
          Top = 131
          Width = 114
          Height = 22
          MaxLength = 14
          TabOrder = 7
        end
        object EditBELTNAME: TEdit
          Tag = 10
          Left = 65
          Top = 299
          Width = 114
          Height = 22
          MaxLength = 14
          TabOrder = 8
        end
        object EditBUJUKNAME: TEdit
          Tag = 9
          Left = 65
          Top = 271
          Width = 114
          Height = 22
          MaxLength = 14
          TabOrder = 9
        end
        object EditRINGRNAME: TEdit
          Tag = 8
          Left = 65
          Top = 243
          Width = 114
          Height = 22
          MaxLength = 14
          TabOrder = 10
        end
        object EditBOOTSNAME: TEdit
          Tag = 11
          Left = 65
          Top = 327
          Width = 114
          Height = 22
          MaxLength = 14
          TabOrder = 11
        end
        object EditCHARMNAME: TEdit
          Tag = 12
          Left = 65
          Top = 355
          Width = 114
          Height = 22
          MaxLength = 14
          TabOrder = 12
        end
      end
      object GroupBoxGroupItem: TGroupBox
        Left = 208
        Top = 5
        Width = 260
        Height = 388
        Caption = '??????'
        TabOrder = 5
        object lbl9: TLabel
          Left = 9
          Top = 135
          Width = 43
          Height = 14
          Caption = 'Dc Rate'
        end
        object lbl11: TLabel
          Left = 9
          Top = 163
          Width = 44
          Height = 14
          Caption = 'Mc Rate'
        end
        object lbl14: TLabel
          Left = 9
          Top = 191
          Width = 42
          Height = 14
          Caption = 'Sc Rate'
        end
        object lbl19: TLabel
          Left = 9
          Top = 23
          Width = 44
          Height = 14
          Caption = 'Hp Rate'
        end
        object lbl20: TLabel
          Left = 9
          Top = 51
          Width = 45
          Height = 14
          Caption = 'Mp Rate'
        end
        object lbl25: TLabel
          Left = 9
          Top = 79
          Width = 43
          Height = 14
          Caption = 'Ac Rate'
        end
        object lbl27: TLabel
          Left = 9
          Top = 107
          Width = 50
          Height = 14
          Caption = 'Mac Rate'
        end
        object Label22: TLabel
          Left = 121
          Top = 23
          Width = 44
          Height = 14
          Caption = 'Hit Rate'
        end
        object Label23: TLabel
          Left = 121
          Top = 191
          Width = 64
          Height = 14
          Caption = 'Mp Recover'
        end
        object Label24: TLabel
          Left = 121
          Top = 163
          Width = 63
          Height = 14
          Caption = 'Hp Recover'
        end
        object Label25: TLabel
          Left = 121
          Top = 135
          Width = 69
          Height = 14
          Caption = 'Pois Recover'
        end
        object Label26: TLabel
          Left = 121
          Top = 107
          Width = 61
          Height = 14
          Caption = 'Anti Poison'
        end
        object Label27: TLabel
          Left = 121
          Top = 79
          Width = 56
          Height = 14
          Caption = 'Anti Magic'
        end
        object Label28: TLabel
          Left = 121
          Top = 51
          Width = 64
          Height = 14
          Caption = 'Speed Rate'
        end
        object Label30: TLabel
          Left = 243
          Top = 23
          Width = 12
          Height = 14
          Caption = '%'
        end
        object Label44: TLabel
          Left = 243
          Top = 51
          Width = 12
          Height = 14
          Caption = '%'
        end
        object Label45: TLabel
          Left = 243
          Top = 79
          Width = 12
          Height = 14
          Caption = '%'
        end
        object Label46: TLabel
          Left = 243
          Top = 107
          Width = 12
          Height = 14
          Caption = '%'
        end
        object Label47: TLabel
          Left = 243
          Top = 135
          Width = 12
          Height = 14
          Caption = '%'
        end
        object Label48: TLabel
          Left = 243
          Top = 163
          Width = 12
          Height = 14
          Caption = '%'
        end
        object Label49: TLabel
          Left = 243
          Top = 191
          Width = 12
          Height = 14
          Caption = '%'
        end
        object EditGroupItemDCRate: TSpinEdit
          Tag = 4
          Left = 65
          Top = 131
          Width = 48
          Height = 23
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
        object EditGroupItemMCRate: TSpinEdit
          Tag = 5
          Left = 65
          Top = 159
          Width = 48
          Height = 23
          MaxValue = 65535
          MinValue = 0
          TabOrder = 1
          Value = 0
        end
        object EditGroupItemSCRate: TSpinEdit
          Tag = 6
          Left = 65
          Top = 187
          Width = 48
          Height = 23
          MaxValue = 65535
          MinValue = 0
          TabOrder = 2
          Value = 0
        end
        object EditGroupItemHPRate: TSpinEdit
          Left = 65
          Top = 19
          Width = 48
          Height = 23
          MaxValue = 65535
          MinValue = 0
          TabOrder = 3
          Value = 0
        end
        object EditGroupItemMPRate: TSpinEdit
          Tag = 1
          Left = 65
          Top = 47
          Width = 48
          Height = 23
          MaxValue = 65535
          MinValue = 0
          TabOrder = 4
          Value = 0
        end
        object EditGroupItemACRate: TSpinEdit
          Tag = 2
          Left = 65
          Top = 75
          Width = 48
          Height = 23
          MaxValue = 65535
          MinValue = 0
          TabOrder = 5
          Value = 0
        end
        object EditGroupItemMACRate: TSpinEdit
          Tag = 3
          Left = 65
          Top = 103
          Width = 48
          Height = 23
          MaxValue = 65535
          MinValue = 0
          TabOrder = 6
          Value = 0
        end
        object EditHitPoint: TSpinEdit
          Tag = 7
          Left = 187
          Top = 19
          Width = 48
          Height = 23
          MaxValue = 65535
          MinValue = 0
          TabOrder = 7
          Value = 0
        end
        object EditSpeedPoint: TSpinEdit
          Tag = 8
          Left = 187
          Top = 47
          Width = 48
          Height = 23
          MaxValue = 65535
          MinValue = 0
          TabOrder = 8
          Value = 0
        end
        object EditAntiMagic: TSpinEdit
          Tag = 9
          Left = 187
          Top = 75
          Width = 48
          Height = 23
          MaxValue = 65535
          MinValue = 0
          TabOrder = 9
          Value = 0
        end
        object EditAntiPoison: TSpinEdit
          Tag = 10
          Left = 187
          Top = 103
          Width = 48
          Height = 23
          MaxValue = 65535
          MinValue = 0
          TabOrder = 10
          Value = 0
        end
        object EditPoisonRecover: TSpinEdit
          Tag = 11
          Left = 187
          Top = 131
          Width = 48
          Height = 23
          MaxValue = 65535
          MinValue = 0
          TabOrder = 11
          Value = 0
        end
        object EditHealthRecover: TSpinEdit
          Tag = 12
          Left = 187
          Top = 159
          Width = 48
          Height = 23
          MaxValue = 65535
          MinValue = 0
          TabOrder = 12
          Value = 0
        end
        object EditSpellRecover: TSpinEdit
          Tag = 13
          Left = 187
          Top = 187
          Width = 48
          Height = 23
          MaxValue = 65535
          MinValue = 0
          TabOrder = 13
          Value = 0
        end
        object CheckBoxGroupItemFlag1: TCheckBox
          Left = 28
          Top = 224
          Width = 57
          Height = 20
          Caption = '??'
          TabOrder = 14
        end
        object CheckBoxGroupItemFlag2: TCheckBox
          Tag = 1
          Left = 28
          Top = 243
          Width = 57
          Height = 20
          Caption = '??'
          TabOrder = 15
        end
        object CheckBoxGroupItemFlag3: TCheckBox
          Tag = 2
          Left = 28
          Top = 261
          Width = 57
          Height = 20
          Caption = '??'
          TabOrder = 16
        end
        object CheckBoxGroupItemFlag4: TCheckBox
          Tag = 3
          Left = 28
          Top = 280
          Width = 57
          Height = 20
          Caption = '??'
          TabOrder = 17
        end
        object CheckBoxGroupItemFlag8: TCheckBox
          Tag = 7
          Left = 28
          Top = 355
          Width = 57
          Height = 20
          Caption = '??'
          Enabled = False
          TabOrder = 18
        end
        object CheckBoxGroupItemFlag7: TCheckBox
          Tag = 6
          Left = 28
          Top = 336
          Width = 57
          Height = 20
          Caption = '??'
          TabOrder = 19
        end
        object CheckBoxGroupItemFlag6: TCheckBox
          Tag = 5
          Left = 28
          Top = 317
          Width = 57
          Height = 20
          Caption = '??'
          TabOrder = 20
        end
        object CheckBoxGroupItemFlag5: TCheckBox
          Tag = 4
          Left = 28
          Top = 299
          Width = 57
          Height = 20
          Caption = '??'
          TabOrder = 21
        end
        object CheckBoxGroupItemFlag16: TCheckBox
          Tag = 15
          Left = 131
          Top = 355
          Width = 104
          Height = 20
          Caption = '??????'
          TabOrder = 22
        end
        object CheckBoxGroupItemFlag15: TCheckBox
          Tag = 14
          Left = 131
          Top = 336
          Width = 104
          Height = 20
          Caption = '??????'
          TabOrder = 23
        end
        object CheckBoxGroupItemFlag14: TCheckBox
          Tag = 13
          Left = 131
          Top = 317
          Width = 76
          Height = 20
          Caption = '????'
          Enabled = False
          TabOrder = 24
        end
        object CheckBoxGroupItemFlag13: TCheckBox
          Tag = 12
          Left = 131
          Top = 299
          Width = 66
          Height = 20
          Caption = '???'
          TabOrder = 25
        end
        object CheckBoxGroupItemFlag12: TCheckBox
          Tag = 11
          Left = 131
          Top = 280
          Width = 76
          Height = 20
          Caption = '???'
          TabOrder = 26
        end
        object CheckBoxGroupItemFlag11: TCheckBox
          Tag = 10
          Left = 131
          Top = 261
          Width = 66
          Height = 20
          Caption = '???'
          TabOrder = 27
        end
        object CheckBoxGroupItemFlag10: TCheckBox
          Tag = 9
          Left = 131
          Top = 243
          Width = 76
          Height = 20
          Caption = '???'
          TabOrder = 28
        end
        object CheckBoxGroupItemFlag9: TCheckBox
          Tag = 8
          Left = 131
          Top = 224
          Width = 57
          Height = 20
          Caption = '??'
          TabOrder = 29
        end
      end
      object GroupBox24: TGroupBox
        Left = 476
        Top = 5
        Width = 337
        Height = 374
        Caption = '????'
        TabOrder = 6
        object ListViewGroupItemList: TListView
          Left = 9
          Top = 19
          Width = 319
          Height = 328
          Columns = <
            item
              Caption = '??'
              Width = 47
            end
            item
              Caption = '????'
              Width = 140
            end
            item
              Caption = '??'
              Width = 117
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListViewGroupItemListClick
        end
      end
      object EditGroupItemHint: TEdit
        Left = 65
        Top = 401
        Width = 403
        Height = 22
        Hint = '????????,????????????.'
        MaxLength = 100
        TabOrder = 7
        Text = '??1??,????15%!'
      end
    end
    object TabSheet16: TTabSheet
      Caption = 'Scatter Item'
      ImageIndex = 16
      object GroupBox28: TGroupBox
        Left = 336
        Top = 8
        Width = 207
        Height = 426
        Caption = '????'
        TabOrder = 0
        object ListBoxitemList6: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxitemList6Click
        end
      end
      object GroupBox29: TGroupBox
        Left = 9
        Top = 8
        Width = 207
        Height = 426
        Caption = '?????????'
        TabOrder = 1
        object ListBoxAllowScatterItem: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 393
          Hint = '?????????,????????,???????????'
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxAllowScatterItemClick
        end
      end
      object ButtonScatterItemAdd: TButton
        Left = 233
        Top = 28
        Width = 86
        Height = 29
        Caption = '??(&A)'
        TabOrder = 2
        OnClick = ButtonScatterItemAddClick
      end
      object ButtonScatterItemDel: TButton
        Left = 233
        Top = 65
        Width = 86
        Height = 30
        Caption = '??(&D)'
        TabOrder = 3
        OnClick = ButtonScatterItemDelClick
      end
      object ButtonScatterItemAddAll: TButton
        Left = 233
        Top = 103
        Width = 86
        Height = 29
        Caption = '????(&A)'
        TabOrder = 4
        OnClick = ButtonScatterItemAddAllClick
      end
      object ButtonScatterItemDelAll: TButton
        Left = 233
        Top = 140
        Width = 86
        Height = 29
        Caption = '????(&D)'
        TabOrder = 5
        OnClick = ButtonScatterItemDelAllClick
      end
      object ButtonScatterItemSave: TButton
        Left = 233
        Top = 177
        Width = 86
        Height = 30
        Caption = '??(&S)'
        TabOrder = 6
        OnClick = ButtonScatterItemSaveClick
      end
    end
    object TabSheet17: TTabSheet
      Caption = '????'
      ImageIndex = 17
      object Label171: TLabel
        Left = 439
        Top = 383
        Width = 170
        Height = 17
        Caption = '???StdMode=8?????????'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -15
        Font.Name = '??'
        Font.Style = []
        ParentFont = False
      end
      object Label170: TLabel
        Left = 439
        Top = 327
        Width = 16
        Height = 14
        Caption = '??:'
      end
      object GroupBox72: TGroupBox
        Left = 224
        Top = 5
        Width = 449
        Height = 304
        Caption = '????'
        TabOrder = 0
        object ListViewBoxItems: TListView
          Left = 9
          Top = 19
          Width = 431
          Height = 272
          Columns = <
            item
              Caption = '????'
              Width = 70
            end
            item
              Caption = '????'
              Width = 93
            end
            item
              Caption = '??'
              Width = 58
            end>
          ColumnClick = False
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListViewBoxItemsClick
        end
      end
      object GroupBox71: TGroupBox
        Left = 9
        Top = 5
        Width = 207
        Height = 454
        Caption = '????'
        TabOrder = 1
        object ListBoxBoxs: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 421
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxBoxsClick
        end
      end
      object EditBoxItemCount: TSpinEdit
        Left = 476
        Top = 322
        Width = 197
        Height = 23
        MaxValue = 0
        MinValue = 0
        TabOrder = 2
        Value = 0
        OnChange = EditBoxItemCountChange
      end
      object ButtonBoxItemAdd: TButton
        Left = 392
        Top = 420
        Width = 85
        Height = 29
        Caption = 'Add'
        TabOrder = 3
        OnClick = ButtonBoxItemAddClick
      end
      object ButtonBoxItemDel: TButton
        Left = 485
        Top = 420
        Width = 86
        Height = 29
        Caption = 'Delete'
        TabOrder = 4
        OnClick = ButtonBoxItemDelClick
      end
      object ButtonBoxItemSave: TButton
        Left = 579
        Top = 420
        Width = 85
        Height = 29
        Caption = 'Save'
        TabOrder = 5
        OnClick = ButtonBoxItemSaveClick
      end
      object GroupBox25: TGroupBox
        Left = 681
        Top = 5
        Width = 207
        Height = 454
        Caption = '????'
        TabOrder = 6
        object ListBoxitemList7: TListBox
          Left = 9
          Top = 19
          Width = 188
          Height = 421
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBoxitemList7Click
        end
      end
      object RadioGroupBoxItemType: TRadioGroup
        Left = 224
        Top = 317
        Width = 207
        Height = 86
        Caption = '????'
        Items.Strings = (
          '????'
          '????'
          '????')
        TabOrder = 7
        OnClick = RadioGroupBoxItemTypeClick
      end
    end
  end
end
