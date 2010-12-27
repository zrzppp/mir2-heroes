object frmHeroConfig: TfrmHeroConfig
  Left = 591
  Top = 239
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #33521#38596#35774#32622
  ClientHeight = 401
  ClientWidth = 489
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
  object PageControl: TPageControl
    Left = 8
    Top = 8
    Width = 473
    Height = 385
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #22522#26412#35774#32622
      object Label15: TLabel
        Left = 8
        Top = 296
        Width = 54
        Height = 12
        Caption = #21484#21796#24310#26102':'
      end
      object Label17: TLabel
        Left = 136
        Top = 296
        Width = 48
        Height = 12
        Caption = #31186' '#25552#31034':'
      end
      object GroupBoxLevelExp: TGroupBox
        Left = 8
        Top = 8
        Width = 169
        Height = 193
        Caption = #21319#32423#32463#39564
        TabOrder = 0
        object Label37: TLabel
          Left = 11
          Top = 165
          Width = 30
          Height = 12
          Caption = #35745#21010':'
        end
        object ComboBoxLevelExp: TComboBox
          Left = 48
          Top = 160
          Width = 113
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 0
          OnClick = ComboBoxLevelExpClick
        end
        object GridLevelExp: TStringGrid
          Left = 8
          Top = 16
          Width = 153
          Height = 137
          ColCount = 2
          DefaultRowHeight = 18
          RowCount = 1001
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
          TabOrder = 1
          ColWidths = (
            64
            67)
          RowHeights = (
            18
            18
            19
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18)
        end
      end
      object GroupBox8: TGroupBox
        Left = 184
        Top = 8
        Width = 129
        Height = 49
        Caption = #32463#39564
        TabOrder = 1
        object Label23: TLabel
          Left = 11
          Top = 24
          Width = 54
          Height = 12
          Caption = #20998#37197#27604#20363':'
        end
        object EditKillMonExpRate: TSpinEdit
          Left = 68
          Top = 20
          Width = 53
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 0
          Value = 40
          OnChange = EditKillMonExpRateChange
        end
      end
      object GroupBox29: TGroupBox
        Left = 184
        Top = 64
        Width = 129
        Height = 65
        Caption = #20986#36523#29366#24577
        TabOrder = 2
        object Label61: TLabel
          Left = 8
          Top = 20
          Width = 54
          Height = 12
          Caption = #24320#22987#31561#32423':'
        end
        object Label7: TLabel
          Left = 8
          Top = 44
          Width = 54
          Height = 12
          Caption = #21517#23383#39068#33394':'
        end
        object LabelHeroNameColor: TLabel
          Left = 112
          Top = 42
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditStartLevel: TSpinEdit
          Left = 68
          Top = 16
          Width = 53
          Height = 21
          Hint = #20154#29289#36215#22987#31561#32423#12290
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = EditStartLevelChange
        end
        object EditHeroNameColor: TSpinEdit
          Left = 68
          Top = 40
          Width = 45
          Height = 21
          Hint = #20154#29289#36215#22987#31561#32423#12290
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 6
          OnChange = EditHeroNameColorChange
        end
      end
      object GroupBox59: TGroupBox
        Left = 320
        Top = 8
        Width = 137
        Height = 89
        Caption = #25915#20987#36895#24230
        TabOrder = 3
        object Label131: TLabel
          Left = 8
          Top = 16
          Width = 54
          Height = 12
          Caption = #25112#22763#36895#24230':'
        end
        object Label132: TLabel
          Left = 8
          Top = 40
          Width = 54
          Height = 12
          Caption = #27861#24072#36895#24230':'
        end
        object Label133: TLabel
          Left = 8
          Top = 64
          Width = 54
          Height = 12
          Caption = #36947#22763#36895#24230':'
        end
        object SpinEditWarrorAttackTime: TSpinEdit
          Left = 72
          Top = 12
          Width = 57
          Height = 21
          Hint = #21333#20301#27627#31186
          Increment = 10
          MaxValue = 10000
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = SpinEditWarrorAttackTimeChange
        end
        object SpinEditWizardAttackTime: TSpinEdit
          Left = 72
          Top = 36
          Width = 57
          Height = 21
          Hint = #21333#20301#27627#31186
          Increment = 10
          MaxLength = 10000
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = SpinEditWizardAttackTimeChange
        end
        object SpinEditTaoistAttackTime: TSpinEdit
          Left = 72
          Top = 60
          Width = 57
          Height = 21
          Hint = #21333#20301#27627#31186
          Increment = 10
          MaxValue = 10000
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnChange = SpinEditTaoistAttackTimeChange
        end
      end
      object ButtonHeroExpSave: TButton
        Left = 392
        Top = 317
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonHeroExpSaveClick
      end
      object GroupBox1: TGroupBox
        Left = 184
        Top = 136
        Width = 129
        Height = 65
        Caption = #21253#35065#35774#32622
        TabOrder = 5
        object Label1: TLabel
          Left = 8
          Top = 44
          Width = 54
          Height = 12
          Caption = #38656#35201#31561#32423':'
        end
        object SpinEditNeedLevel: TSpinEdit
          Left = 68
          Top = 40
          Width = 53
          Height = 21
          Hint = #25351#23450#21253#35065#25968#38656#35201#30340#31561#32423#12290
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = SpinEditNeedLevelChange
        end
        object ComboBoxBagItemCount: TComboBox
          Left = 8
          Top = 16
          Width = 113
          Height = 20
          ItemHeight = 12
          TabOrder = 1
          Text = #36873#25321#21253#35065#25968
          OnChange = ComboBoxBagItemCountChange
          Items.Strings = (
            '20'#26684
            '30'#26684
            '35'#26684
            '40'#26684)
        end
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 208
        Width = 281
        Height = 73
        Caption = #33521#38596#21507#33647
        TabOrder = 6
        object Label124: TLabel
          Left = 8
          Top = 21
          Width = 108
          Height = 12
          Caption = #34880#20540#20302#20110#24635#34880#20540#30340#65306
        end
        object Label125: TLabel
          Left = 8
          Top = 45
          Width = 132
          Height = 12
          Caption = #39764#27861#20540#20302#20110#24635#39764#27861#20540#30340#65306
        end
        object Label126: TLabel
          Left = 200
          Top = 21
          Width = 72
          Height = 12
          Caption = '% '#26102#24320#22987#21507#33647
        end
        object Label3: TLabel
          Left = 200
          Top = 45
          Width = 72
          Height = 12
          Caption = '% '#26102#24320#22987#21507#33647
        end
        object SpinEditEatHPItemRate: TSpinEdit
          Left = 144
          Top = 19
          Width = 49
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 60
          OnChange = SpinEditEatHPItemRateChange
        end
        object SpinEditEatMPItemRate: TSpinEdit
          Left = 144
          Top = 43
          Width = 49
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 60
          OnChange = SpinEditEatMPItemRateChange
        end
      end
      object EditRecallHeroTime: TSpinEdit
        Left = 64
        Top = 292
        Width = 65
        Height = 21
        MaxValue = 1000
        MinValue = 0
        TabOrder = 7
        Value = 0
        OnChange = EditRecallHeroTimeChange
      end
      object EditRecallHeroHint: TEdit
        Left = 184
        Top = 292
        Width = 273
        Height = 20
        TabOrder = 8
        Text = #20320#30340#33521#38596#20307#36136#36824#24456#34394#24369'.'#38656#35201'%d'#31186#25165#33021#32487#32493#21484#21796
        OnChange = EditRecallHeroHintChange
      end
      object GroupBox78: TGroupBox
        Left = 296
        Top = 208
        Width = 145
        Height = 41
        Caption = #33521#38596#20351#29992#21253#35065#20013#30340#27602#31526
        TabOrder = 9
        object CheckBoxHeroUseBagItem: TCheckBox
          Left = 8
          Top = 16
          Width = 129
          Height = 17
          Caption = #20351#29992#21253#35065#20013#30340#27602#31526
          TabOrder = 0
          OnClick = CheckBoxHeroUseBagItemClick
        end
      end
      object CheckBoxSafeNoAllowTargetBB: TCheckBox
        Left = 296
        Top = 264
        Width = 129
        Height = 17
        Caption = #23433#20840#21306#31105#27490#38145#23450#23453#23453
        TabOrder = 10
        OnClick = CheckBoxSafeNoAllowTargetBBClick
      end
      object GroupBox66: TGroupBox
        Left = 320
        Top = 104
        Width = 137
        Height = 97
        Caption = #34892#36208#36895#24230
        TabOrder = 11
        object Label8: TLabel
          Left = 8
          Top = 68
          Width = 54
          Height = 12
          Caption = #36947#22763#36895#24230':'
        end
        object Label9: TLabel
          Left = 8
          Top = 44
          Width = 54
          Height = 12
          Caption = #27861#24072#36895#24230':'
        end
        object Label16: TLabel
          Left = 8
          Top = 20
          Width = 54
          Height = 12
          Caption = #25112#22763#36895#24230':'
        end
        object EditHeroWarrorWalkTime: TSpinEdit
          Left = 74
          Top = 16
          Width = 55
          Height = 21
          MaxValue = 10000
          MinValue = 10
          TabOrder = 0
          Value = 10
          OnChange = EditHeroWarrorWalkTimeChange
        end
        object EditHeroWizardWalkTime: TSpinEdit
          Left = 74
          Top = 40
          Width = 55
          Height = 21
          MaxValue = 10000
          MinValue = 10
          TabOrder = 1
          Value = 10
          OnChange = EditHeroWizardWalkTimeChange
        end
        object EditHeroTaoistWalkTime: TSpinEdit
          Left = 74
          Top = 64
          Width = 55
          Height = 21
          MaxValue = 10000
          MinValue = 10
          TabOrder = 2
          Value = 10
          OnChange = EditHeroTaoistWalkTimeChange
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #33521#38596#27515#20129
      ImageIndex = 1
      object GroupBox67: TGroupBox
        Left = 8
        Top = 8
        Width = 177
        Height = 89
        Caption = #27515#20129#25481#29289#21697#35268#21017
        TabOrder = 0
        object CheckBoxKillByMonstDropUseItem: TCheckBox
          Left = 8
          Top = 16
          Width = 121
          Height = 17
          Hint = #24403#20154#29289#34987#24618#29289#26432#27515#26102#20250#25353#25481#33853#26426#29575#25481#33853#36523#19978#25140#30340#29289#21697#12290
          Caption = #34987#24618#29289#26432#27515#25481#35013#22791
          TabOrder = 0
          OnClick = CheckBoxKillByMonstDropUseItemClick
        end
        object CheckBoxKillByHumanDropUseItem: TCheckBox
          Left = 8
          Top = 32
          Width = 121
          Height = 17
          Hint = #24403#20154#29289#34987#21035#20154#26432#27515#26102#20250#25353#25481#33853#26426#29575#25481#33853#36523#19978#25140#30340#29289#21697#12290
          Caption = #34987#20154#29289#26432#27515#25481#35013#22791
          TabOrder = 1
          OnClick = CheckBoxKillByHumanDropUseItemClick
        end
        object CheckBoxDieScatterBag: TCheckBox
          Left = 8
          Top = 48
          Width = 113
          Height = 17
          Hint = #24403#20154#29289#27515#20129#26102#20250#25353#25481#33853#26426#29575#25481#33853#32972#21253#37324#30340#29289#21697#12290
          Caption = #27515#20129#25481#32972#21253#29289#21697
          TabOrder = 2
          OnClick = CheckBoxDieScatterBagClick
        end
        object CheckBoxDieRedScatterBagAll: TCheckBox
          Left = 8
          Top = 64
          Width = 145
          Height = 17
          Hint = #32418#21517#20154#29289#27515#20129#26102#25481#33853#32972#21253#20013#20840#37096#29289#21697#12290
          Caption = #32418#21517#25481#20840#37096#32972#21253#29289#21697
          TabOrder = 3
          OnClick = CheckBoxDieRedScatterBagAllClick
        end
      end
      object GroupBox69: TGroupBox
        Left = 192
        Top = 8
        Width = 265
        Height = 89
        Caption = #25481#29289#21697#26426#29575
        TabOrder = 1
        object Label130: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #25481#33853#35013#22791':'
        end
        object Label2: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #32418#21517#35013#22791':'
        end
        object Label134: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #32972#21253#29289#21697':'
        end
        object ScrollBarDieDropUseItemRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = #20154#29289#27515#20129#25481#33853#36523#19978#25140#30340#29289#21697#26426#29575#65292#35774#32622#30340#25968#23383#36234#23567#65292#26426#29575#36234#22823#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarDieDropUseItemRateChange
        end
        object EditDieDropUseItemRate: TEdit
          Left = 216
          Top = 16
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarDieRedDropUseItemRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = #32418#21517#20154#29289#27515#20129#25481#33853#36523#19978#25140#30340#29289#21697#26426#29575#65292#35774#32622#30340#25968#23383#36234#23567#65292#26426#29575#36234#22823#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarDieRedDropUseItemRateChange
        end
        object EditDieRedDropUseItemRate: TEdit
          Left = 216
          Top = 40
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarDieScatterBagRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = #20154#29289#27515#20129#25481#33853#32972#21253#20013#30340#29289#21697#26426#29575#65292#35774#32622#30340#25968#23383#36234#23567#65292#26426#29575#36234#22823#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarDieScatterBagRateChange
        end
        object EditDieScatterBagRate: TEdit
          Left = 216
          Top = 64
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object ButtonHeroDieSave: TButton
        Left = 392
        Top = 317
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonHeroDieSaveClick
      end
    end
    object TabSheet3: TTabSheet
      Caption = #33521#38596#21512#20987
      ImageIndex = 2
      object GroupBox3: TGroupBox
        Left = 8
        Top = 0
        Width = 177
        Height = 97
        Caption = #24594#27133
        TabOrder = 0
        object Label4: TLabel
          Left = 8
          Top = 24
          Width = 66
          Height = 12
          Caption = #24594#27133#26368#22823#20540':'
        end
        object Label5: TLabel
          Left = 8
          Top = 48
          Width = 78
          Height = 12
          Caption = #24594#27133#27599#27425#22686#21152':'
        end
        object Label6: TLabel
          Left = 8
          Top = 72
          Width = 102
          Height = 12
          Caption = #28779#40857#20043#24515#27599#27425#20943#23569':'
        end
        object EditMaxFirDragonPoint: TSpinEdit
          Left = 116
          Top = 20
          Width = 53
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 0
          Value = 40
          OnChange = EditMaxFirDragonPointChange
        end
        object EditAddFirDragonPoint: TSpinEdit
          Left = 116
          Top = 44
          Width = 53
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 1
          Value = 40
          OnChange = EditAddFirDragonPointChange
        end
        object EditDecFirDragonPoint: TSpinEdit
          Left = 116
          Top = 68
          Width = 53
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 2
          Value = 40
          OnChange = EditDecFirDragonPointChange
        end
      end
      object ButtonHeroAttackSave: TButton
        Left = 392
        Top = 317
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonHeroAttackSaveClick
      end
      object GroupBox52: TGroupBox
        Left = 8
        Top = 103
        Width = 144
        Height = 99
        Caption = #30772#39746#26025
        TabOrder = 2
        object Label135: TLabel
          Left = 8
          Top = 20
          Width = 60
          Height = 12
          Caption = #23041#21147#20493#25968#65306
        end
        object EditSkill60Rate: TSpinEdit
          Left = 72
          Top = 16
          Width = 49
          Height = 21
          Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
          MaxValue = 10000
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = EditSkill60RateChange
        end
      end
      object GroupBox6: TGroupBox
        Left = 158
        Top = 102
        Width = 147
        Height = 100
        Caption = #21128#26143#26025
        TabOrder = 3
        object Label10: TLabel
          Left = 8
          Top = 20
          Width = 60
          Height = 12
          Caption = #23041#21147#20493#25968#65306
        end
        object EditSkill61Rate: TSpinEdit
          Left = 72
          Top = 16
          Width = 49
          Height = 21
          Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
          MaxValue = 10000
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = EditSkill61RateChange
        end
      end
      object GroupBox7: TGroupBox
        Left = 311
        Top = 103
        Width = 151
        Height = 99
        Caption = #38647#38662#19968#20987
        TabOrder = 4
        object Label11: TLabel
          Left = 8
          Top = 20
          Width = 60
          Height = 12
          Caption = #23041#21147#20493#25968#65306
        end
        object EditSkill62Rate: TSpinEdit
          Left = 72
          Top = 16
          Width = 49
          Height = 21
          Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
          MaxValue = 10000
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = EditSkill62RateChange
        end
      end
      object GroupBox9: TGroupBox
        Left = 8
        Top = 208
        Width = 144
        Height = 99
        Caption = #22124#39746#27836#27901
        TabOrder = 5
        object Label12: TLabel
          Left = 8
          Top = 20
          Width = 60
          Height = 12
          Caption = #23041#21147#20493#25968#65306
        end
        object EditSkill63Rate: TSpinEdit
          Left = 72
          Top = 16
          Width = 49
          Height = 21
          Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
          MaxValue = 10000
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = EditSkill63RateChange
        end
      end
      object GroupBox10: TGroupBox
        Left = 158
        Top = 208
        Width = 147
        Height = 100
        Caption = #26411#26085#23457#21028
        TabOrder = 6
        object Label13: TLabel
          Left = 8
          Top = 20
          Width = 60
          Height = 12
          Caption = #23041#21147#20493#25968#65306
        end
        object EditSkill64Rate: TSpinEdit
          Left = 72
          Top = 16
          Width = 49
          Height = 21
          Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
          MaxValue = 10000
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = EditSkill64RateChange
        end
      end
      object GroupBox11: TGroupBox
        Left = 311
        Top = 212
        Width = 151
        Height = 99
        Caption = #28779#40857#27668#28976
        TabOrder = 7
        object Label14: TLabel
          Left = 8
          Top = 20
          Width = 60
          Height = 12
          Caption = #23041#21147#20493#25968#65306
        end
        object EditSkill65Rate: TSpinEdit
          Left = 72
          Top = 16
          Width = 49
          Height = 21
          Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
          MaxValue = 10000
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = EditSkill65RateChange
        end
      end
    end
  end
end
