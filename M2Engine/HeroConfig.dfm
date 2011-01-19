object frmHeroConfig: TfrmHeroConfig
  Left = 201
  Top = 116
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Hero Config'
  ClientHeight = 468
  ClientWidth = 571
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object PageControl: TPageControl
    Left = 9
    Top = 9
    Width = 552
    Height = 450
    ActivePage = TabSheet3
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Options'
      object Label15: TLabel
        Left = 9
        Top = 393
        Width = 61
        Height = 14
        Caption = 'Recall Time'
      end
      object GroupBoxLevelExp: TGroupBox
        Left = 9
        Top = 8
        Width = 184
        Height = 273
        Caption = 'Experience settings'
        TabOrder = 0
        object Label37: TLabel
          Left = 29
          Top = 225
          Width = 68
          Height = 14
          Caption = 'Mass update'
        end
        object ComboBoxLevelExp: TComboBox
          Left = 8
          Top = 243
          Width = 116
          Height = 22
          Style = csDropDownList
          ItemHeight = 14
          TabOrder = 0
          OnClick = ComboBoxLevelExpClick
        end
        object GridLevelExp: TStringGrid
          Left = 9
          Top = 19
          Width = 168
          Height = 190
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
        Left = 199
        Top = 8
        Width = 170
        Height = 65
        Caption = 'Experience multiplier'
        TabOrder = 1
        object Label23: TLabel
          Left = 5
          Top = 28
          Width = 89
          Height = 14
          Caption = 'KillMon Exp Rate'
        end
        object EditKillMonExpRate: TSpinEdit
          Left = 103
          Top = 23
          Width = 62
          Height = 23
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 0
          Value = 40
          OnChange = EditKillMonExpRateChange
        end
      end
      object GroupBox29: TGroupBox
        Left = 200
        Top = 80
        Width = 169
        Height = 81
        Caption = 'Start Level An Color'
        TabOrder = 2
        object Label61: TLabel
          Left = 9
          Top = 23
          Width = 75
          Height = 14
          Caption = 'Starting Level'
        end
        object Label7: TLabel
          Left = 9
          Top = 51
          Width = 92
          Height = 14
          Caption = 'Hero Name Color'
        end
        object LabelHeroNameColor: TLabel
          Left = 155
          Top = 49
          Width = 10
          Height = 20
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditStartLevel: TSpinEdit
          Left = 103
          Top = 19
          Width = 62
          Height = 23
          Hint = '???????'
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = EditStartLevelChange
        end
        object EditHeroNameColor: TSpinEdit
          Left = 104
          Top = 47
          Width = 52
          Height = 23
          Hint = '???????'
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 6
          OnChange = EditHeroNameColorChange
        end
      end
      object GroupBox59: TGroupBox
        Left = 373
        Top = 8
        Width = 160
        Height = 105
        Caption = 'Attack Speed'
        TabOrder = 3
        object Label131: TLabel
          Left = 9
          Top = 19
          Width = 39
          Height = 14
          Caption = 'Warrior'
        end
        object Label132: TLabel
          Left = 9
          Top = 47
          Width = 36
          Height = 14
          Caption = 'Wizard'
        end
        object Label133: TLabel
          Left = 9
          Top = 75
          Width = 33
          Height = 14
          Caption = 'Taoist'
        end
        object SpinEditWarrorAttackTime: TSpinEdit
          Left = 84
          Top = 14
          Width = 67
          Height = 23
          Hint = '????'
          Increment = 10
          MaxValue = 10000
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = SpinEditWarrorAttackTimeChange
        end
        object SpinEditWizardAttackTime: TSpinEdit
          Left = 84
          Top = 42
          Width = 67
          Height = 23
          Hint = '????'
          Increment = 10
          MaxLength = 10000
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = SpinEditWizardAttackTimeChange
        end
        object SpinEditTaoistAttackTime: TSpinEdit
          Left = 84
          Top = 70
          Width = 67
          Height = 23
          Hint = '????'
          Increment = 10
          MaxValue = 10000
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnChange = SpinEditTaoistAttackTimeChange
        end
      end
      object ButtonHeroExpSave: TButton
        Left = 457
        Top = 386
        Width = 76
        Height = 29
        Caption = 'Save'
        TabOrder = 4
        OnClick = ButtonHeroExpSaveClick
      end
      object GroupBox1: TGroupBox
        Left = 199
        Top = 192
        Width = 170
        Height = 89
        Caption = 'Bag Item Count'
        TabOrder = 5
        object Label1: TLabel
          Left = 9
          Top = 51
          Width = 69
          Height = 14
          Caption = 'Need Level :'
        end
        object SpinEditNeedLevel: TSpinEdit
          Left = 79
          Top = 47
          Width = 62
          Height = 23
          Hint = '???????????'
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = SpinEditNeedLevelChange
        end
        object ComboBoxBagItemCount: TComboBox
          Left = 9
          Top = 19
          Width = 132
          Height = 22
          ItemHeight = 14
          TabOrder = 1
          Text = '10 Item'
          OnChange = ComboBoxBagItemCountChange
          Items.Strings = (
            '20?'
            '30?'
            '35?'
            '40?')
        end
      end
      object GroupBox2: TGroupBox
        Left = 9
        Top = 296
        Width = 336
        Height = 81
        Caption = 'Auto Pot ?'
        TabOrder = 6
        object Label124: TLabel
          Left = 9
          Top = 25
          Width = 96
          Height = 14
          Caption = 'Eat HP Item Rate'
        end
        object Label125: TLabel
          Left = 9
          Top = 53
          Width = 97
          Height = 14
          Caption = 'Eat MP Item Rate'
        end
        object Label126: TLabel
          Left = 233
          Top = 25
          Width = 12
          Height = 14
          Caption = '%'
        end
        object Label3: TLabel
          Left = 233
          Top = 53
          Width = 12
          Height = 14
          Caption = '%'
        end
        object SpinEditEatHPItemRate: TSpinEdit
          Left = 168
          Top = 22
          Width = 57
          Height = 23
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 60
          OnChange = SpinEditEatHPItemRateChange
        end
        object SpinEditEatMPItemRate: TSpinEdit
          Left = 168
          Top = 50
          Width = 57
          Height = 23
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
        Left = 75
        Top = 389
        Width = 76
        Height = 23
        MaxValue = 1000
        MinValue = 0
        TabOrder = 7
        Value = 0
        OnChange = EditRecallHeroTimeChange
      end
      object EditRecallHeroHint: TEdit
        Left = 151
        Top = 389
        Width = 298
        Height = 22
        TabOrder = 8
        Text = '??????????.??%d???????'
        OnChange = EditRecallHeroHintChange
      end
      object GroupBox78: TGroupBox
        Left = 352
        Top = 296
        Width = 179
        Height = 81
        Caption = 'Hero Functions'
        TabOrder = 9
        object CheckBoxHeroUseBagItem: TCheckBox
          Left = 17
          Top = 51
          Width = 151
          Height = 20
          Caption = 'Hero Use Bag Item '
          TabOrder = 0
          OnClick = CheckBoxHeroUseBagItemClick
        end
      end
      object CheckBoxSafeNoAllowTargetBB: TCheckBox
        Left = 369
        Top = 324
        Width = 151
        Height = 20
        Caption = 'No Allow Target'
        TabOrder = 10
        OnClick = CheckBoxSafeNoAllowTargetBBClick
      end
      object GroupBox66: TGroupBox
        Left = 373
        Top = 113
        Width = 160
        Height = 114
        Caption = 'Walk Speed'
        TabOrder = 11
        object Label8: TLabel
          Left = 9
          Top = 79
          Width = 33
          Height = 14
          Caption = 'Taoist'
        end
        object Label9: TLabel
          Left = 9
          Top = 51
          Width = 36
          Height = 14
          Caption = 'Wizard'
        end
        object Label16: TLabel
          Left = 9
          Top = 23
          Width = 39
          Height = 14
          Caption = 'Warrior'
        end
        object EditHeroWarrorWalkTime: TSpinEdit
          Left = 86
          Top = 19
          Width = 65
          Height = 23
          MaxValue = 10000
          MinValue = 10
          TabOrder = 0
          Value = 10
          OnChange = EditHeroWarrorWalkTimeChange
        end
        object EditHeroWizardWalkTime: TSpinEdit
          Left = 86
          Top = 47
          Width = 65
          Height = 23
          MaxValue = 10000
          MinValue = 10
          TabOrder = 1
          Value = 10
          OnChange = EditHeroWizardWalkTimeChange
        end
        object EditHeroTaoistWalkTime: TSpinEdit
          Left = 86
          Top = 75
          Width = 65
          Height = 23
          MaxValue = 10000
          MinValue = 10
          TabOrder = 2
          Value = 10
          OnChange = EditHeroTaoistWalkTimeChange
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Death Drops'
      ImageIndex = 1
      object GroupBox67: TGroupBox
        Left = 9
        Top = 9
        Width = 207
        Height = 104
        Caption = 'On death options'
        TabOrder = 0
        object CheckBoxKillByMonstDropUseItem: TCheckBox
          Left = 9
          Top = 24
          Width = 184
          Height = 15
          Hint = '????????????????????????'
          Caption = 'Kill By Mon Drop User Item'
          TabOrder = 0
          OnClick = CheckBoxKillByMonstDropUseItemClick
        end
        object CheckBoxKillByHumanDropUseItem: TCheckBox
          Left = 9
          Top = 37
          Width = 184
          Height = 20
          Hint = '????????????????????????'
          Caption = 'Kill By Hum Drop Item'
          TabOrder = 1
          OnClick = CheckBoxKillByHumanDropUseItemClick
        end
        object CheckBoxDieScatterBag: TCheckBox
          Left = 9
          Top = 56
          Width = 132
          Height = 20
          Hint = '?????????????????????'
          Caption = 'Die Scatter Bag'
          TabOrder = 2
          OnClick = CheckBoxDieScatterBagClick
        end
        object CheckBoxDieRedScatterBagAll: TCheckBox
          Left = 9
          Top = 75
          Width = 170
          Height = 20
          Hint = '?????????????????'
          Caption = 'Red Die Scatter Bag'
          TabOrder = 3
          OnClick = CheckBoxDieRedScatterBagAllClick
        end
      end
      object GroupBox69: TGroupBox
        Left = 224
        Top = 9
        Width = 309
        Height = 104
        Caption = 'Rates'
        TabOrder = 1
        object Label130: TLabel
          Left = 9
          Top = 21
          Width = 25
          Height = 14
          Caption = 'Rate'
        end
        object Label2: TLabel
          Left = 9
          Top = 49
          Width = 25
          Height = 14
          Caption = 'Rate'
        end
        object Label134: TLabel
          Left = 9
          Top = 77
          Width = 25
          Height = 14
          Caption = 'Rate'
        end
        object ScrollBarDieDropUseItemRate: TScrollBar
          Left = 75
          Top = 19
          Width = 169
          Height = 20
          Hint = '??????????????,???????,?????'
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarDieDropUseItemRateChange
        end
        object EditDieDropUseItemRate: TEdit
          Left = 252
          Top = 19
          Width = 48
          Height = 20
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarDieRedDropUseItemRate: TScrollBar
          Left = 75
          Top = 47
          Width = 169
          Height = 20
          Hint = '????????????????,???????,?????'
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarDieRedDropUseItemRateChange
        end
        object EditDieRedDropUseItemRate: TEdit
          Left = 252
          Top = 47
          Width = 48
          Height = 20
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarDieScatterBagRate: TScrollBar
          Left = 75
          Top = 75
          Width = 169
          Height = 20
          Hint = '??????????????,???????,?????'
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarDieScatterBagRateChange
        end
        object EditDieScatterBagRate: TEdit
          Left = 252
          Top = 75
          Width = 48
          Height = 20
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object ButtonHeroDieSave: TButton
        Left = 457
        Top = 370
        Width = 76
        Height = 29
        Caption = '??(&S)'
        TabOrder = 2
        OnClick = ButtonHeroDieSaveClick
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Skills'
      ImageIndex = 2
      object GroupBox3: TGroupBox
        Left = 9
        Top = 0
        Width = 328
        Height = 113
        Caption = 'Dragon Point'
        TabOrder = 0
        object Label4: TLabel
          Left = 9
          Top = 28
          Width = 96
          Height = 14
          Caption = 'Max Dragon Point'
        end
        object Label5: TLabel
          Left = 9
          Top = 56
          Width = 97
          Height = 14
          Caption = 'Add Dragon Point'
        end
        object Label6: TLabel
          Left = 9
          Top = 84
          Width = 125
          Height = 14
          Caption = 'Decrease Dragon Point'
        end
        object EditMaxFirDragonPoint: TSpinEdit
          Left = 231
          Top = 23
          Width = 62
          Height = 23
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 0
          Value = 40
          OnChange = EditMaxFirDragonPointChange
        end
        object EditAddFirDragonPoint: TSpinEdit
          Left = 231
          Top = 51
          Width = 62
          Height = 23
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 1
          Value = 40
          OnChange = EditAddFirDragonPointChange
        end
        object EditDecFirDragonPoint: TSpinEdit
          Left = 231
          Top = 79
          Width = 62
          Height = 23
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 2
          Value = 40
          OnChange = EditDecFirDragonPointChange
        end
      end
      object ButtonHeroAttackSave: TButton
        Left = 457
        Top = 370
        Width = 76
        Height = 29
        Caption = 'Save'
        TabOrder = 1
        OnClick = ButtonHeroAttackSaveClick
      end
      object GroupBox52: TGroupBox
        Left = 9
        Top = 120
        Width = 168
        Height = 116
        Caption = 'Skill Rate'
        TabOrder = 2
        object Label135: TLabel
          Left = 9
          Top = 23
          Width = 37
          Height = 14
          Caption = 'Skill 60'
        end
        object EditSkill60Rate: TSpinEdit
          Left = 84
          Top = 19
          Width = 57
          Height = 23
          Hint = '???????????100'
          MaxValue = 10000
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = EditSkill60RateChange
        end
      end
      object GroupBox6: TGroupBox
        Left = 184
        Top = 119
        Width = 172
        Height = 117
        Caption = 'Skill Rate'
        TabOrder = 3
        object Label10: TLabel
          Left = 9
          Top = 23
          Width = 37
          Height = 14
          Caption = 'Skill 61'
        end
        object EditSkill61Rate: TSpinEdit
          Left = 84
          Top = 19
          Width = 57
          Height = 23
          Hint = '???????????100'
          MaxValue = 10000
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = EditSkill61RateChange
        end
      end
      object GroupBox7: TGroupBox
        Left = 363
        Top = 120
        Width = 176
        Height = 116
        Caption = 'Skill Rate'
        TabOrder = 4
        object Label11: TLabel
          Left = 9
          Top = 23
          Width = 37
          Height = 14
          Caption = 'Skill 62'
        end
        object EditSkill62Rate: TSpinEdit
          Left = 84
          Top = 19
          Width = 57
          Height = 23
          Hint = '???????????100'
          MaxValue = 10000
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = EditSkill62RateChange
        end
      end
      object GroupBox9: TGroupBox
        Left = 9
        Top = 243
        Width = 168
        Height = 115
        Caption = 'Skill Rate'
        TabOrder = 5
        object Label12: TLabel
          Left = 9
          Top = 23
          Width = 37
          Height = 14
          Caption = 'Skill 63'
        end
        object EditSkill63Rate: TSpinEdit
          Left = 84
          Top = 19
          Width = 57
          Height = 23
          Hint = '???????????100'
          MaxValue = 10000
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = EditSkill63RateChange
        end
      end
      object GroupBox10: TGroupBox
        Left = 184
        Top = 243
        Width = 172
        Height = 116
        Caption = 'Skill Rate'
        TabOrder = 6
        object Label13: TLabel
          Left = 9
          Top = 23
          Width = 37
          Height = 14
          Caption = 'Skill 64'
        end
        object EditSkill64Rate: TSpinEdit
          Left = 84
          Top = 19
          Width = 57
          Height = 23
          Hint = '???????????100'
          MaxValue = 10000
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = EditSkill64RateChange
        end
      end
      object GroupBox11: TGroupBox
        Left = 363
        Top = 247
        Width = 176
        Height = 116
        Caption = 'Skill Rate'
        TabOrder = 7
        object Label14: TLabel
          Left = 9
          Top = 23
          Width = 37
          Height = 14
          Caption = 'Skill 65'
        end
        object EditSkill65Rate: TSpinEdit
          Left = 84
          Top = 19
          Width = 57
          Height = 23
          Hint = '???????????100'
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
