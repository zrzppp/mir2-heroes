object frmViewList: TfrmViewList
  Left = 792
  Top = 293
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #26597#30475#21015#34920#20449#24687
  ClientHeight = 458
  ClientWidth = 793
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PageControlViewList: TPageControl
    Left = 8
    Top = 8
    Width = 777
    Height = 441
    ActivePage = TabSheet15
    MultiLine = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #31105#27490#21046#36896#29289#21697
      object GroupBox3: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 365
        Caption = #31105#27490#21046#36896#21015#34920
        TabOrder = 0
        object ListBoxDisableMakeList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxDisableMakeListClick
        end
      end
      object GroupBox4: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 365
        Caption = #29289#21697#21015#34920
        TabOrder = 1
        object ListBoxitemList1: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          ItemHeight = 12
          MultiSelect = True
          TabOrder = 0
          OnClick = ListBoxitemList1Click
        end
      end
      object ButtonDisableMakeAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonDisableMakeAddClick
      end
      object ButtonDisableMakeDelete: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonDisableMakeDeleteClick
      end
      object ButtonDisableMakeSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonDisableMakeSaveClick
      end
      object ButtonDisableMakeAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 5
        OnClick = ButtonDisableMakeAddAllClick
      end
      object ButtonDisableMakeDeleteAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 6
        OnClick = ButtonDisableMakeDeleteAllClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = #20801#35768#21046#36896#29289#21697
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 365
        Caption = #29289#21697#21015#34920
        TabOrder = 0
        object ListBoxItemList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxItemListClick
        end
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 365
        Caption = #20801#35768#21046#36896#21015#34920
        TabOrder = 1
        object ListBoxEnableMakeList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxEnableMakeListClick
        end
      end
      object ButtonEnableMakeAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonEnableMakeAddClick
      end
      object ButtonEnableMakeDelete: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonEnableMakeDeleteClick
      end
      object ButtonEnableMakeSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonEnableMakeSaveClick
      end
      object ButtonEnableMakeAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 5
        OnClick = ButtonEnableMakeAddAllClick
      end
      object ButtonEnableMakeDeleteAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 6
        OnClick = ButtonEnableMakeDeleteAllClick
      end
    end
    object TabSheet8: TTabSheet
      Hint = #28216#25103#26085#24535#36807#28388#65292#21487#20197#25351#23450#35760#24405#37027#20123#29289#21697#20135#29983#30340#26085#24535#65292#20174#32780#20943#23569#26085#24535#30340#22823#23567#12290
      Caption = #28216#25103#26085#24535#36807#28388
      ImageIndex = 8
      object GroupBox8: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 365
        Caption = #35760#24405#29289#21697'/'#20107#20214#21015#34920
        TabOrder = 0
        object ListBoxGameLogList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxGameLogListClick
        end
      end
      object ButtonGameLogAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 1
        OnClick = ButtonGameLogAddClick
      end
      object ButtonGameLogDel: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 2
        OnClick = ButtonGameLogDelClick
      end
      object ButtonGameLogAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 3
        OnClick = ButtonGameLogAddAllClick
      end
      object ButtonGameLogDelAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonGameLogDelAllClick
      end
      object ButtonGameLogSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonGameLogSaveClick
      end
      object GroupBox9: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 365
        Caption = #20107#20214'/'#29289#21697#21015#34920
        TabOrder = 6
        object ListBoxitemList2: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxitemList2Click
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #31105#27490#20256#36865#22320#22270
      ImageIndex = 2
      object GroupBox5: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 365
        Caption = #31105#27490#22320#22270#21015#34920
        TabOrder = 0
        object ListBoxDisableMoveMap: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxDisableMoveMapClick
        end
      end
      object ButtonDisableMoveMapAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 1
        OnClick = ButtonDisableMoveMapAddClick
      end
      object ButtonDisableMoveMapDelete: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 2
        OnClick = ButtonDisableMoveMapDeleteClick
      end
      object ButtonDisableMoveMapAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 3
        OnClick = ButtonDisableMoveMapAddAllClick
      end
      object ButtonDisableMoveMapDeleteAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonDisableMoveMapDeleteAllClick
      end
      object ButtonDisableMoveMapSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonDisableMoveMapSaveClick
      end
      object GroupBox6: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 365
        Caption = #22320#22270#21015#34920
        TabOrder = 6
        object ListBoxMapList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxMapListClick
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #35013#22791#31105#27490#21319#32423
      ImageIndex = 3
      object GroupBox26: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 365
        Caption = #31105#27490#21319#32423#21015#34920
        TabOrder = 0
        object ListBox1: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBox1Click
        end
      end
      object GroupBox27: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 365
        Caption = #29289#21697#21015#34920
        TabOrder = 1
        object ListBox2: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBox2Click
        end
      end
      object ButtonUpgradeAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        Enabled = False
        TabOrder = 2
        OnClick = ButtonUpgradeAddClick
      end
      object ButtonUpgradeDel: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        Enabled = False
        TabOrder = 3
        OnClick = ButtonUpgradeDelClick
      end
      object ButtonUpgradeAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 4
        OnClick = ButtonUpgradeAddAllClick
      end
      object ButtonUpgradeDelAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 5
        OnClick = ButtonUpgradeDelAllClick
      end
      object ButtonUpgradesave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 6
        OnClick = ButtonUpgradesaveClick
      end
    end
    object TabSheet5: TTabSheet
      Caption = #29289#21697#24080#21495#32465#23450
      ImageIndex = 4
      object GridItemBindAccount: TStringGrid
        Left = 8
        Top = 8
        Width = 337
        Height = 361
        Hint = #21152#20837#27492#21015#34920#20013#30340#29289#21697#23558#19982#25351#23450#30340#30331#24405#24080#21495#32465#23450#65292#21482#26377#20197#32465#23450#30340#30331#24405#24080#21495#30331#24405#30340#20154#29289#25165#21487#20197#25140#19978#27492#29289#21697#12290
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
        Left = 352
        Top = 8
        Width = 169
        Height = 177
        Caption = #35268#21017#35774#32622
        TabOrder = 1
        object Label6: TLabel
          Left = 8
          Top = 42
          Width = 48
          Height = 12
          Caption = #29289#21697'IDX:'
        end
        object Label7: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #29289#21697#24207#21495':'
        end
        object Label8: TLabel
          Left = 8
          Top = 90
          Width = 54
          Height = 12
          Caption = #32465#23450#24080#21495':'
        end
        object Label9: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object ButtonItemBindAcountMod: TButton
          Left = 96
          Top = 112
          Width = 65
          Height = 25
          Caption = #20462#25913'(&S)'
          TabOrder = 0
          OnClick = ButtonItemBindAcountModClick
        end
        object EditItemBindAccountItemIdx: TSpinEdit
          Left = 68
          Top = 39
          Width = 93
          Height = 21
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemBindAccountItemIdxChange
        end
        object EditItemBindAccountItemMakeIdx: TSpinEdit
          Left = 68
          Top = 63
          Width = 93
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditItemBindAccountItemMakeIdxChange
        end
        object EditItemBindAccountItemName: TEdit
          Left = 68
          Top = 16
          Width = 93
          Height = 20
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonItemBindAcountAdd: TButton
          Left = 8
          Top = 112
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 4
          OnClick = ButtonItemBindAcountAddClick
        end
        object ButtonItemBindAcountRef: TButton
          Left = 96
          Top = 144
          Width = 65
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 5
          OnClick = ButtonItemBindAcountRefClick
        end
        object ButtonItemBindAcountDel: TButton
          Left = 8
          Top = 144
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 6
          OnClick = ButtonItemBindAcountDelClick
        end
        object EditItemBindAccountName: TEdit
          Left = 68
          Top = 88
          Width = 93
          Height = 20
          TabOrder = 7
          OnChange = EditItemBindAccountNameChange
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = #29289#21697#20154#29289#32465#23450
      ImageIndex = 5
      object GridItemBindCharName: TStringGrid
        Left = 8
        Top = 8
        Width = 337
        Height = 361
        Hint = #21152#20837#27492#21015#34920#20013#30340#29289#21697#23558#19982#25351#23450#30340#20154#29289#21517#31216#32465#23450#65292#21482#26377#32465#23450#30340#20154#29289#25165#21487#20197#25140#19978#27492#29289#21697#12290
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
        Left = 352
        Top = 8
        Width = 169
        Height = 177
        Caption = #35268#21017#35774#32622
        TabOrder = 1
        object Label10: TLabel
          Left = 8
          Top = 42
          Width = 48
          Height = 12
          Caption = #29289#21697'IDX:'
        end
        object Label11: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #29289#21697#24207#21495':'
        end
        object Label12: TLabel
          Left = 8
          Top = 90
          Width = 54
          Height = 12
          Caption = #32465#23450#20154#29289':'
        end
        object Label13: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object ButtonItemBindCharNameMod: TButton
          Left = 96
          Top = 112
          Width = 65
          Height = 25
          Caption = #20462#25913'(&S)'
          TabOrder = 0
          OnClick = ButtonItemBindCharNameModClick
        end
        object EditItemBindCharNameItemIdx: TSpinEdit
          Left = 68
          Top = 39
          Width = 93
          Height = 21
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemBindCharNameItemIdxChange
        end
        object EditItemBindCharNameItemMakeIdx: TSpinEdit
          Left = 68
          Top = 63
          Width = 93
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditItemBindCharNameItemMakeIdxChange
        end
        object EditItemBindCharNameItemName: TEdit
          Left = 68
          Top = 16
          Width = 93
          Height = 20
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonItemBindCharNameAdd: TButton
          Left = 8
          Top = 112
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 4
          OnClick = ButtonItemBindCharNameAddClick
        end
        object ButtonItemBindCharNameRef: TButton
          Left = 96
          Top = 144
          Width = 65
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 5
          OnClick = ButtonItemBindCharNameRefClick
        end
        object ButtonItemBindCharNameDel: TButton
          Left = 8
          Top = 144
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 6
          OnClick = ButtonItemBindCharNameDelClick
        end
        object EditItemBindCharNameName: TEdit
          Left = 68
          Top = 88
          Width = 93
          Height = 20
          TabOrder = 7
          OnChange = EditItemBindCharNameNameChange
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = #29289#21697'IP'#32465#23450
      ImageIndex = 6
      object GridItemBindIPaddr: TStringGrid
        Left = 8
        Top = 8
        Width = 337
        Height = 361
        Hint = #21152#20837#27492#21015#34920#20013#30340#29289#21697#23558#19982#25351#23450#30340#30331#24405'IP'#22320#22336#32465#23450#65292#21482#26377#20197#32465#23450#30340#30331#24405'IP'#22320#22336#30331#24405#30340#20154#29289#25165#21487#20197#25140#19978#27492#29289#21697#12290
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
        Left = 352
        Top = 8
        Width = 169
        Height = 177
        Caption = #35268#21017#35774#32622
        TabOrder = 1
        object Label14: TLabel
          Left = 8
          Top = 42
          Width = 48
          Height = 12
          Caption = #29289#21697'IDX:'
        end
        object Label15: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #29289#21697#24207#21495':'
        end
        object Label16: TLabel
          Left = 8
          Top = 90
          Width = 42
          Height = 12
          Caption = #32465#23450'IP:'
        end
        object Label17: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object ButtonItemBindIPaddrMod: TButton
          Left = 96
          Top = 112
          Width = 65
          Height = 25
          Caption = #20462#25913'(&S)'
          TabOrder = 0
          OnClick = ButtonItemBindIPaddrModClick
        end
        object EditItemBindIPaddrItemIdx: TSpinEdit
          Left = 68
          Top = 39
          Width = 93
          Height = 21
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemBindIPaddrItemIdxChange
        end
        object EditItemBindIPaddrItemMakeIdx: TSpinEdit
          Left = 68
          Top = 63
          Width = 93
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditItemBindIPaddrItemMakeIdxChange
        end
        object EditItemBindIPaddrItemName: TEdit
          Left = 68
          Top = 16
          Width = 93
          Height = 20
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonItemBindIPaddrAdd: TButton
          Left = 8
          Top = 112
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 4
          OnClick = ButtonItemBindIPaddrAddClick
        end
        object ButtonItemBindIPaddrRef: TButton
          Left = 96
          Top = 144
          Width = 65
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 5
          OnClick = ButtonItemBindIPaddrRefClick
        end
        object ButtonItemBindIPaddrDel: TButton
          Left = 8
          Top = 144
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 6
          OnClick = ButtonItemBindIPaddrDelClick
        end
        object EditItemBindIPaddrName: TEdit
          Left = 68
          Top = 88
          Width = 93
          Height = 20
          TabOrder = 7
          OnChange = EditItemBindIPaddrNameChange
        end
      end
    end
    object TabSheet12: TTabSheet
      Caption = #29289#21697#21517#31216#33258#23450#20041
      ImageIndex = 12
      object GridItemNameList: TStringGrid
        Left = 8
        Top = 8
        Width = 337
        Height = 361
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
        Left = 352
        Top = 8
        Width = 169
        Height = 361
        Caption = #29289#21697#33258#23450#20041#21517#31216
        TabOrder = 1
        object Label18: TLabel
          Left = 8
          Top = 42
          Width = 48
          Height = 12
          Caption = #29289#21697'IDX:'
        end
        object Label19: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #29289#21697#24207#21495':'
        end
        object Label20: TLabel
          Left = 8
          Top = 90
          Width = 54
          Height = 12
          Caption = #33258#23450#20041#21517':'
        end
        object Label21: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object ButtonItemNameMod: TButton
          Left = 96
          Top = 112
          Width = 65
          Height = 25
          Caption = #20462#25913'(&S)'
          TabOrder = 0
          OnClick = ButtonItemNameModClick
        end
        object EditItemNameIdx: TSpinEdit
          Left = 68
          Top = 39
          Width = 93
          Height = 21
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemNameIdxChange
        end
        object EditItemNameMakeIndex: TSpinEdit
          Left = 68
          Top = 63
          Width = 93
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditItemNameMakeIndexChange
        end
        object EditItemNameOldName: TEdit
          Left = 68
          Top = 16
          Width = 93
          Height = 20
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonItemNameAdd: TButton
          Left = 8
          Top = 112
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 4
          OnClick = ButtonItemNameAddClick
        end
        object ButtonItemNameRef: TButton
          Left = 96
          Top = 144
          Width = 65
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 5
          OnClick = ButtonItemNameRefClick
        end
        object ButtonItemNameDel: TButton
          Left = 8
          Top = 144
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 6
          OnClick = ButtonItemNameDelClick
        end
        object EditItemNameNewName: TEdit
          Left = 68
          Top = 88
          Width = 93
          Height = 20
          TabOrder = 7
          OnChange = EditItemNameNewNameChange
        end
      end
    end
    object TabSheetMonDrop: TTabSheet
      Caption = #24618#29289#29190#29289#21697
      ImageIndex = 7
      object StringGridMonDropLimit: TStringGrid
        Left = 8
        Top = 8
        Width = 281
        Height = 361
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
        Left = 296
        Top = 8
        Width = 169
        Height = 361
        Caption = #35268#21017#35774#32622
        TabOrder = 1
        object Label29: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #24050#29190#25968#37327':'
        end
        object Label1: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #38480#21046#25968#37327':'
        end
        object Label2: TLabel
          Left = 8
          Top = 90
          Width = 54
          Height = 12
          Caption = #26410#29190#25968#37327':'
        end
        object Label3: TLabel
          Left = 8
          Top = 18
          Width = 48
          Height = 12
          Caption = #29289#21697#21517#31216
        end
        object ButtonMonDropLimitSave: TButton
          Left = 96
          Top = 112
          Width = 65
          Height = 25
          Caption = #20462#25913'(&S)'
          TabOrder = 0
          OnClick = ButtonMonDropLimitSaveClick
        end
        object EditDropCount: TSpinEdit
          Left = 68
          Top = 39
          Width = 61
          Height = 21
          MaxValue = 100000
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditDropCountChange
        end
        object EditCountLimit: TSpinEdit
          Left = 68
          Top = 63
          Width = 61
          Height = 21
          MaxValue = 100000
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditCountLimitChange
        end
        object EditNoDropCount: TSpinEdit
          Left = 68
          Top = 87
          Width = 61
          Height = 21
          MaxValue = 100000
          MinValue = 0
          TabOrder = 3
          Value = 10
          OnChange = EditNoDropCountChange
        end
        object EditItemName: TEdit
          Left = 68
          Top = 16
          Width = 89
          Height = 20
          TabOrder = 4
        end
        object ButtonMonDropLimitAdd: TButton
          Left = 8
          Top = 112
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 5
          OnClick = ButtonMonDropLimitAddClick
        end
        object ButtonMonDropLimitRef: TButton
          Left = 96
          Top = 144
          Width = 65
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 6
          OnClick = ButtonMonDropLimitRefClick
        end
        object ButtonMonDropLimitDel: TButton
          Left = 8
          Top = 144
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 7
          OnClick = ButtonMonDropLimitDelClick
        end
      end
    end
    object TabSheet9: TTabSheet
      Hint = #31105#27490#21462#19979#29289#21697#35774#32622#65292#21152#20837#27492#21015#34920#30340#29289#21697#25140#22312#36523#19978#21518#23558#19981#21487#20197#21462#19979#26469#65292#27515#20129#20063#19981#20250#25481#33853#12290
      Caption = #31105#27490#21462#19979#29289#21697
      ImageIndex = 9
      object GroupBox10: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 365
        Caption = #31105#27490#21462#19979#29289#21697#21015#34920
        TabOrder = 0
        object ListBoxDisableTakeOffList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          Hint = #31105#27490#21462#19979#29289#21697#35774#32622#65292#21152#20837#27492#21015#34920#30340#29289#21697#25140#22312#36523#19978#21518#23558#19981#21487#20197#21462#19979#26469#65292#27515#20129#20063#19981#20250#25481#33853#12290
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxDisableTakeOffListClick
        end
      end
      object ButtonDisableTakeOffAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 1
        OnClick = ButtonDisableTakeOffAddClick
      end
      object ButtonDisableTakeOffDel: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 2
        OnClick = ButtonDisableTakeOffDelClick
      end
      object ButtonDisableTakeOffAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 3
        OnClick = ButtonDisableTakeOffAddAllClick
      end
      object ButtonDisableTakeOffDelAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonDisableTakeOffDelAllClick
      end
      object ButtonDisableTakeOffSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonDisableTakeOffSaveClick
      end
      object GroupBox11: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 365
        Caption = #29289#21697#21015#34920
        TabOrder = 6
        object ListBoxitemList3: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxitemList3Click
        end
      end
    end
    object TabSheet13: TTabSheet
      Caption = #20801#35768#23492#21806#29289#21697
      ImageIndex = 10
      object GroupBox20: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 365
        Caption = #20801#35768#23492#21806#29289#21697#21015#34920
        TabOrder = 0
        object ListBoxSellOffList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          Hint = #20801#35768#23492#21806#29289#21697#35774#32622#65292#21152#20837#27492#21015#34920#30340#29289#21697#25165#21487#20197#36827#34892#25293#21334
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxSellOffListClick
        end
      end
      object GroupBox21: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 365
        Caption = #29289#21697#21015#34920
        TabOrder = 1
        object ListBoxitemList4: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxitemList4Click
        end
      end
      object ButtonSellOffAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonSellOffAddClick
      end
      object ButtonSellOffDel: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonSellOffDelClick
      end
      object ButtonSellOffAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 4
        OnClick = ButtonSellOffAddAllClick
      end
      object ButtonSellOffDelAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 5
        OnClick = ButtonSellOffDelAllClick
      end
      object ButtonSellOffSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 6
        OnClick = ButtonSellOffSaveClick
      end
    end
    object TabSheet11: TTabSheet
      Caption = #31105#27490#28165#29702#24618#29289#21015#34920
      ImageIndex = 11
      object GroupBox13: TGroupBox
        Left = 8
        Top = 3
        Width = 177
        Height = 366
        Caption = #31105#27490#28165#29702#24618#29289#21015#34920
        TabOrder = 0
        object ListBoxNoClearMonList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 345
          Hint = #31105#27490#28165#38500#24618#29289#35774#32622#65292#29992#20110#33050#26412#21629#20196'CLEARMAPMON'#65292#21152#20837#27492#21015#34920#30340#24618#29289#65292#22312#20351#29992#27492#33050#26412#21629#20196#26102#19981#20250#34987#28165#38500#12290
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxNoClearMonListClick
        end
      end
      object ButtonNoClearMonAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 1
        OnClick = ButtonNoClearMonAddClick
      end
      object ButtonNoClearMonDel: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 2
        OnClick = ButtonNoClearMonDelClick
      end
      object ButtonNoClearMonAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 3
        OnClick = ButtonNoClearMonAddAllClick
      end
      object ButtonNoClearMonDelAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonNoClearMonDelAllClick
      end
      object ButtonNoClearMonSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonNoClearMonSaveClick
      end
      object GroupBox14: TGroupBox
        Left = 288
        Top = 3
        Width = 177
        Height = 366
        Caption = #24618#29289#21015#34920
        TabOrder = 6
        object ListBoxMonList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 345
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxMonListClick
        end
      end
    end
    object TabSheet10: TTabSheet
      Caption = #31649#29702#21592#21015#34920
      ImageIndex = 10
      object GroupBox12: TGroupBox
        Left = 8
        Top = 4
        Width = 273
        Height = 365
        Caption = #31649#29702#21592#21015#34920
        TabOrder = 0
        object ListBoxAdminList: TListBox
          Left = 8
          Top = 16
          Width = 257
          Height = 337
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxAdminListClick
        end
      end
      object GroupBox15: TGroupBox
        Left = 288
        Top = 4
        Width = 209
        Height = 141
        Caption = #31649#29702#21592#20449#24687
        TabOrder = 1
        object Label4: TLabel
          Left = 8
          Top = 20
          Width = 54
          Height = 12
          Caption = #35282#33394#21517#31216':'
        end
        object Label5: TLabel
          Left = 8
          Top = 44
          Width = 54
          Height = 12
          Caption = #35282#33394#31561#32423':'
        end
        object LabelAdminIPaddr: TLabel
          Left = 8
          Top = 68
          Width = 42
          Height = 12
          Caption = #30331#24405'IP:'
        end
        object EditAdminName: TEdit
          Left = 64
          Top = 16
          Width = 97
          Height = 20
          TabOrder = 0
        end
        object EditAdminPremission: TSpinEdit
          Left = 64
          Top = 39
          Width = 61
          Height = 21
          MaxValue = 10
          MinValue = 1
          TabOrder = 1
          Value = 10
        end
        object ButtonAdminListAdd: TButton
          Left = 16
          Top = 104
          Width = 57
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 2
          OnClick = ButtonAdminListAddClick
        end
        object ButtonAdminListChange: TButton
          Left = 80
          Top = 104
          Width = 57
          Height = 25
          Caption = #20462#25913'(&M)'
          TabOrder = 3
          OnClick = ButtonAdminListChangeClick
        end
        object ButtonAdminListDel: TButton
          Left = 144
          Top = 104
          Width = 57
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 4
          OnClick = ButtonAdminListDelClick
        end
        object EditAdminIPaddr: TEdit
          Left = 64
          Top = 64
          Width = 97
          Height = 20
          TabOrder = 5
        end
      end
      object ButtonAdminLitsSave: TButton
        Left = 440
        Top = 152
        Width = 57
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonAdminLitsSaveClick
      end
    end
    object TabSheet14: TTabSheet
      Caption = #20801#35768#20998#36523#25441#21462#29289#21697
      ImageIndex = 14
      object GroupBox22: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 365
        Caption = #20998#36523#20801#35768#25441#21462#29289#21697#21015#34920
        TabOrder = 0
        object ListBoxAllowPickUpItem: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          Hint = #20801#35768#20998#36523#25441#21462#29289#21697#35774#32622#65292#21152#20837#27492#21015#34920#30340#29289#21697#20998#36523#25165#20250#25441#21462
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxAllowPickUpItemClick
        end
      end
      object GroupBox23: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 365
        Caption = #29289#21697#21015#34920
        TabOrder = 1
        object ListBoxitemList5: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxitemList5Click
        end
      end
      object ButtonPickItemAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonPickItemAddClick
      end
      object ButtonPickItemDel: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonPickItemDelClick
      end
      object ButtonPickItemAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 4
        OnClick = ButtonPickItemAddAllClick
      end
      object ButtonPickItemDelAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 5
        OnClick = ButtonPickItemDelAllClick
      end
      object ButtonPickItemSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 6
        OnClick = ButtonPickItemSaveClick
      end
    end
    object TabSheet15: TTabSheet
      Caption = #22871#35013#31995#32479
      ImageIndex = 15
      object lbl29: TLabel
        Left = 8
        Top = 347
        Width = 42
        Height = 12
        Caption = #25552'  '#31034':'
      end
      object ButtonGroupItemAdd: TButton
        Left = 408
        Top = 336
        Width = 65
        Height = 25
        Caption = #28155#21152'(&A)'
        TabOrder = 0
        OnClick = ButtonGroupItemAddClick
      end
      object ButtonGroupItemDel: TButton
        Left = 480
        Top = 336
        Width = 65
        Height = 25
        Caption = #21024#38500'(&D)'
        Enabled = False
        TabOrder = 1
        OnClick = ButtonGroupItemDelClick
      end
      object ButtonGroupItemChg: TButton
        Left = 552
        Top = 336
        Width = 65
        Height = 25
        Caption = #20462#25913'(&M)'
        Enabled = False
        TabOrder = 2
        OnClick = ButtonGroupItemChgClick
      end
      object ButtonGroupItemSave: TButton
        Left = 624
        Top = 336
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        Enabled = False
        TabOrder = 3
        OnClick = ButtonGroupItemSaveClick
      end
      object GroupBoxUseGroupItem: TGroupBox
        Left = 4
        Top = 4
        Width = 165
        Height = 333
        Caption = #22871#35013#29289#21697
        TabOrder = 4
        object Label31: TLabel
          Left = 8
          Top = 20
          Width = 42
          Height = 12
          Caption = #34915'  '#26381':'
        end
        object Label32: TLabel
          Left = 8
          Top = 44
          Width = 42
          Height = 12
          Caption = #27494'  '#22120':'
        end
        object Label33: TLabel
          Left = 8
          Top = 92
          Width = 42
          Height = 12
          Caption = #39033'  '#38142':'
        end
        object Label34: TLabel
          Left = 8
          Top = 68
          Width = 42
          Height = 12
          Caption = #21195'  '#31456':'
        end
        object Label35: TLabel
          Left = 8
          Top = 188
          Width = 42
          Height = 12
          Caption = #24038#25106#25351':'
        end
        object Label36: TLabel
          Left = 8
          Top = 164
          Width = 42
          Height = 12
          Caption = #21491#25163#38255':'
        end
        object Label37: TLabel
          Left = 8
          Top = 140
          Width = 42
          Height = 12
          Caption = #24038#25163#38255':'
        end
        object Label38: TLabel
          Left = 8
          Top = 116
          Width = 42
          Height = 12
          Caption = #22836'  '#30420':'
        end
        object Label39: TLabel
          Left = 8
          Top = 236
          Width = 42
          Height = 12
          Caption = #36947'  '#31526':'
        end
        object Label40: TLabel
          Left = 8
          Top = 212
          Width = 42
          Height = 12
          Caption = #21491#25106#25351':'
        end
        object Label41: TLabel
          Left = 8
          Top = 260
          Width = 42
          Height = 12
          Caption = #33136'  '#24102':'
        end
        object Label42: TLabel
          Left = 8
          Top = 284
          Width = 42
          Height = 12
          Caption = #38772'  '#23376':'
        end
        object Label43: TLabel
          Left = 8
          Top = 308
          Width = 42
          Height = 12
          Caption = #23453'  '#30707':'
        end
        object EditDRESSNAME: TEdit
          Left = 56
          Top = 16
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 0
        end
        object EditWEAPONNAME: TEdit
          Tag = 1
          Left = 56
          Top = 40
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 1
        end
        object EditNECKLACENAME: TEdit
          Tag = 3
          Left = 56
          Top = 88
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 2
        end
        object EditRIGHTHANDNAME: TEdit
          Tag = 2
          Left = 56
          Top = 64
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 3
        end
        object EditRINGLNAME: TEdit
          Tag = 7
          Left = 56
          Top = 184
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 4
        end
        object EditARMRINGRNAME: TEdit
          Tag = 6
          Left = 56
          Top = 160
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 5
        end
        object EditARMRINGLNAME: TEdit
          Tag = 5
          Left = 56
          Top = 136
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 6
        end
        object EditHELMETNAME: TEdit
          Tag = 4
          Left = 56
          Top = 112
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 7
        end
        object EditBELTNAME: TEdit
          Tag = 10
          Left = 56
          Top = 256
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 8
        end
        object EditBUJUKNAME: TEdit
          Tag = 9
          Left = 56
          Top = 232
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 9
        end
        object EditRINGRNAME: TEdit
          Tag = 8
          Left = 56
          Top = 208
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 10
        end
        object EditBOOTSNAME: TEdit
          Tag = 11
          Left = 56
          Top = 280
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 11
        end
        object EditCHARMNAME: TEdit
          Tag = 12
          Left = 56
          Top = 304
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 12
        end
      end
      object GroupBoxGroupItem: TGroupBox
        Left = 178
        Top = 4
        Width = 223
        Height = 333
        Caption = #38468#21152#23646#24615#35774#32622
        TabOrder = 5
        object lbl9: TLabel
          Left = 8
          Top = 116
          Width = 42
          Height = 12
          Caption = #25915#20987#21147':'
        end
        object lbl11: TLabel
          Left = 8
          Top = 140
          Width = 42
          Height = 12
          Caption = #39764#27861#21147':'
        end
        object lbl14: TLabel
          Left = 8
          Top = 164
          Width = 42
          Height = 12
          Caption = #36947#26415#21147':'
        end
        object lbl19: TLabel
          Left = 8
          Top = 20
          Width = 42
          Height = 12
          Caption = 'HP'#19978#38480':'
        end
        object lbl20: TLabel
          Left = 8
          Top = 44
          Width = 42
          Height = 12
          Caption = 'MP'#19978#38480':'
        end
        object lbl25: TLabel
          Left = 8
          Top = 68
          Width = 42
          Height = 12
          Caption = #29289'  '#38450':'
        end
        object lbl27: TLabel
          Left = 8
          Top = 92
          Width = 42
          Height = 12
          Caption = #39764'  '#38450':'
        end
        object Label22: TLabel
          Left = 104
          Top = 20
          Width = 54
          Height = 12
          Caption = '% '#20934'  '#30830':'
        end
        object Label23: TLabel
          Left = 104
          Top = 164
          Width = 54
          Height = 12
          Caption = '% MP'#24674#22797':'
        end
        object Label24: TLabel
          Left = 104
          Top = 140
          Width = 54
          Height = 12
          Caption = '% HP'#24674#22797':'
        end
        object Label25: TLabel
          Left = 104
          Top = 116
          Width = 54
          Height = 12
          Caption = '% '#27602#24674#22797':'
        end
        object Label26: TLabel
          Left = 104
          Top = 92
          Width = 54
          Height = 12
          Caption = '% '#27602#36530#36991':'
        end
        object Label27: TLabel
          Left = 104
          Top = 68
          Width = 54
          Height = 12
          Caption = '% '#39764#36530#36991':'
        end
        object Label28: TLabel
          Left = 104
          Top = 44
          Width = 54
          Height = 12
          Caption = '% '#25935'  '#25463':'
        end
        object Label30: TLabel
          Left = 208
          Top = 20
          Width = 6
          Height = 12
          Caption = '%'
        end
        object Label44: TLabel
          Left = 208
          Top = 44
          Width = 6
          Height = 12
          Caption = '%'
        end
        object Label45: TLabel
          Left = 208
          Top = 68
          Width = 6
          Height = 12
          Caption = '%'
        end
        object Label46: TLabel
          Left = 208
          Top = 92
          Width = 6
          Height = 12
          Caption = '%'
        end
        object Label47: TLabel
          Left = 208
          Top = 116
          Width = 6
          Height = 12
          Caption = '%'
        end
        object Label48: TLabel
          Left = 208
          Top = 140
          Width = 6
          Height = 12
          Caption = '%'
        end
        object Label49: TLabel
          Left = 208
          Top = 164
          Width = 6
          Height = 12
          Caption = '%'
        end
        object EditGroupItemDCRate: TSpinEdit
          Tag = 4
          Left = 56
          Top = 112
          Width = 41
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
        object EditGroupItemMCRate: TSpinEdit
          Tag = 5
          Left = 56
          Top = 136
          Width = 41
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 1
          Value = 0
        end
        object EditGroupItemSCRate: TSpinEdit
          Tag = 6
          Left = 56
          Top = 160
          Width = 41
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 2
          Value = 0
        end
        object EditGroupItemHPRate: TSpinEdit
          Left = 56
          Top = 16
          Width = 41
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 3
          Value = 0
        end
        object EditGroupItemMPRate: TSpinEdit
          Tag = 1
          Left = 56
          Top = 40
          Width = 41
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 4
          Value = 0
        end
        object EditGroupItemACRate: TSpinEdit
          Tag = 2
          Left = 56
          Top = 64
          Width = 41
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 5
          Value = 0
        end
        object EditGroupItemMACRate: TSpinEdit
          Tag = 3
          Left = 56
          Top = 88
          Width = 41
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 6
          Value = 0
        end
        object EditHitPoint: TSpinEdit
          Tag = 7
          Left = 160
          Top = 16
          Width = 41
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 7
          Value = 0
        end
        object EditSpeedPoint: TSpinEdit
          Tag = 8
          Left = 160
          Top = 40
          Width = 41
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 8
          Value = 0
        end
        object EditAntiMagic: TSpinEdit
          Tag = 9
          Left = 160
          Top = 64
          Width = 41
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 9
          Value = 0
        end
        object EditAntiPoison: TSpinEdit
          Tag = 10
          Left = 160
          Top = 88
          Width = 41
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 10
          Value = 0
        end
        object EditPoisonRecover: TSpinEdit
          Tag = 11
          Left = 160
          Top = 112
          Width = 41
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 11
          Value = 0
        end
        object EditHealthRecover: TSpinEdit
          Tag = 12
          Left = 160
          Top = 136
          Width = 41
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 12
          Value = 0
        end
        object EditSpellRecover: TSpinEdit
          Tag = 13
          Left = 160
          Top = 160
          Width = 41
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 13
          Value = 0
        end
        object CheckBoxGroupItemFlag1: TCheckBox
          Left = 24
          Top = 192
          Width = 49
          Height = 17
          Caption = #40635#30201
          TabOrder = 14
        end
        object CheckBoxGroupItemFlag2: TCheckBox
          Tag = 1
          Left = 24
          Top = 208
          Width = 49
          Height = 17
          Caption = #25252#36523
          TabOrder = 15
        end
        object CheckBoxGroupItemFlag3: TCheckBox
          Tag = 2
          Left = 24
          Top = 224
          Width = 49
          Height = 17
          Caption = #20256#36865
          TabOrder = 16
        end
        object CheckBoxGroupItemFlag4: TCheckBox
          Tag = 3
          Left = 24
          Top = 240
          Width = 49
          Height = 17
          Caption = #22797#27963
          TabOrder = 17
        end
        object CheckBoxGroupItemFlag8: TCheckBox
          Tag = 7
          Left = 24
          Top = 304
          Width = 49
          Height = 17
          Caption = #21560#34880
          Enabled = False
          TabOrder = 18
        end
        object CheckBoxGroupItemFlag7: TCheckBox
          Tag = 6
          Left = 24
          Top = 288
          Width = 49
          Height = 17
          Caption = #25506#27979
          TabOrder = 19
        end
        object CheckBoxGroupItemFlag6: TCheckBox
          Tag = 5
          Left = 24
          Top = 272
          Width = 49
          Height = 17
          Caption = #25216#24039
          TabOrder = 20
        end
        object CheckBoxGroupItemFlag5: TCheckBox
          Tag = 4
          Left = 24
          Top = 256
          Width = 49
          Height = 17
          Caption = #36127#36733
          TabOrder = 21
        end
        object CheckBoxGroupItemFlag16: TCheckBox
          Tag = 15
          Left = 112
          Top = 304
          Width = 89
          Height = 17
          Caption = #19981#25481#36523#19978#35013#22791
          TabOrder = 22
        end
        object CheckBoxGroupItemFlag15: TCheckBox
          Tag = 14
          Left = 112
          Top = 288
          Width = 89
          Height = 17
          Caption = #19981#25481#32972#21253#35013#22791
          TabOrder = 23
        end
        object CheckBoxGroupItemFlag14: TCheckBox
          Tag = 13
          Left = 112
          Top = 272
          Width = 65
          Height = 17
          Caption = #35760#24518#23646#24615
          Enabled = False
          TabOrder = 24
        end
        object CheckBoxGroupItemFlag13: TCheckBox
          Tag = 12
          Left = 112
          Top = 256
          Width = 57
          Height = 17
          Caption = #30772#25252#36523
          TabOrder = 25
        end
        object CheckBoxGroupItemFlag12: TCheckBox
          Tag = 11
          Left = 112
          Top = 240
          Width = 65
          Height = 17
          Caption = #30772#22797#27963
          TabOrder = 26
        end
        object CheckBoxGroupItemFlag11: TCheckBox
          Tag = 10
          Left = 112
          Top = 224
          Width = 57
          Height = 17
          Caption = #38450#20840#27602
          TabOrder = 27
        end
        object CheckBoxGroupItemFlag10: TCheckBox
          Tag = 9
          Left = 112
          Top = 208
          Width = 65
          Height = 17
          Caption = #38450#40635#30201
          TabOrder = 28
        end
        object CheckBoxGroupItemFlag9: TCheckBox
          Tag = 8
          Left = 112
          Top = 192
          Width = 49
          Height = 17
          Caption = #38544#36523
          TabOrder = 29
        end
      end
      object GroupBox24: TGroupBox
        Left = 408
        Top = 4
        Width = 289
        Height = 321
        Caption = #22871#35013#21015#34920
        TabOrder = 6
        object ListViewGroupItemList: TListView
          Left = 8
          Top = 16
          Width = 273
          Height = 281
          Columns = <
            item
              Caption = #24207#21495
              Width = 40
            end
            item
              Caption = #22871#35013#29289#21697
              Width = 120
            end
            item
              Caption = #25552#31034
              Width = 100
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
        Left = 56
        Top = 344
        Width = 345
        Height = 20
        Hint = #31359#40784#19968#22871#21518#30340#25552#31034','#22914#26524#19981#38656#35201#25552#31034#21487#20197#19981#22635#20889'.'
        MaxLength = 100
        TabOrder = 7
        Text = #22871#35013'1'#29983#25928','#29289#38450#25552#21319'15%!'
      end
    end
    object TabSheet16: TTabSheet
      Caption = #29190#29289#21697#20801#35768#35302#21457#21015#34920
      ImageIndex = 16
      object GroupBox28: TGroupBox
        Left = 288
        Top = 7
        Width = 177
        Height = 365
        Caption = #29289#21697#21015#34920
        TabOrder = 0
        object ListBoxitemList6: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxitemList6Click
        end
      end
      object GroupBox29: TGroupBox
        Left = 8
        Top = 7
        Width = 177
        Height = 365
        Caption = #29190#29289#21697#20801#35768#35302#21457#21015#34920
        TabOrder = 1
        object ListBoxAllowScatterItem: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 337
          Hint = #29190#29289#21697#20801#35768#35302#21457#35774#32622#65292#21152#20837#27492#21015#34920#30340#29289#21697','#24618#29289#29190#20986#21518#25165#20250#35302#21457#33050#26412
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxAllowScatterItemClick
        end
      end
      object ButtonScatterItemAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonScatterItemAddClick
      end
      object ButtonScatterItemDel: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonScatterItemDelClick
      end
      object ButtonScatterItemAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 4
        OnClick = ButtonScatterItemAddAllClick
      end
      object ButtonScatterItemDelAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 5
        OnClick = ButtonScatterItemDelAllClick
      end
      object ButtonScatterItemSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 6
        OnClick = ButtonScatterItemSaveClick
      end
    end
    object TabSheet17: TTabSheet
      Caption = #23453#31665#21015#34920
      ImageIndex = 17
      object Label171: TLabel
        Left = 376
        Top = 328
        Width = 198
        Height = 12
        Caption = #29289#21697#30340'StdMode=8'#35774#32622#30340#25968#37327#25165#20250#26377#25928
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label170: TLabel
        Left = 376
        Top = 280
        Width = 30
        Height = 12
        Caption = #25968#37327':'
      end
      object GroupBox72: TGroupBox
        Left = 192
        Top = 4
        Width = 385
        Height = 261
        Caption = #23453#31665#29289#21697
        TabOrder = 0
        object ListViewBoxItems: TListView
          Left = 8
          Top = 16
          Width = 369
          Height = 233
          Columns = <
            item
              Caption = #29289#21697#31867#22411
              Width = 60
            end
            item
              Caption = #29289#21697#21517#31216
              Width = 80
            end
            item
              Caption = #25968#37327
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
        Left = 8
        Top = 4
        Width = 177
        Height = 389
        Caption = #23453#31665#21015#34920
        TabOrder = 1
        object ListBoxBoxs: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 361
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxBoxsClick
        end
      end
      object EditBoxItemCount: TSpinEdit
        Left = 408
        Top = 276
        Width = 169
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 2
        Value = 0
        OnChange = EditBoxItemCountChange
      end
      object ButtonBoxItemAdd: TButton
        Left = 336
        Top = 360
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 3
        OnClick = ButtonBoxItemAddClick
      end
      object ButtonBoxItemDel: TButton
        Left = 416
        Top = 360
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonBoxItemDelClick
      end
      object ButtonBoxItemSave: TButton
        Left = 496
        Top = 360
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonBoxItemSaveClick
      end
      object GroupBox25: TGroupBox
        Left = 584
        Top = 4
        Width = 177
        Height = 389
        Caption = #29289#21697#21015#34920
        TabOrder = 6
        object ListBoxitemList7: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 361
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxitemList7Click
        end
      end
      object RadioGroupBoxItemType: TRadioGroup
        Left = 192
        Top = 272
        Width = 177
        Height = 73
        Caption = #29289#21697#31867#22411
        Items.Strings = (
          #20013#38388#29289#21697
          #20801#35768#33719#21462
          #22635#20805#29289#21697)
        TabOrder = 7
        OnClick = RadioGroupBoxItemTypeClick
      end
    end
  end
end
