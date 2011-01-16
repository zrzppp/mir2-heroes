object frmFunctionConfig: TfrmFunctionConfig
  Left = 166
  Top = 47
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '????'
  ClientHeight = 531
  ClientWidth = 590
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
  TextHeight = 15
  object Label14: TLabel
    Left = 10
    Top = 509
    Width = 280
    Height = 17
    Caption = '?????????,???????????????,??????????'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = '??'
    Font.Style = []
    ParentFont = False
  end
  object FunctionConfigControl: TPageControl
    Left = 10
    Top = 10
    Width = 571
    Height = 491
    ActivePage = TabSheet12
    MultiLine = True
    TabOrder = 0
    OnChanging = FunctionConfigControlChanging
    object TabSheetGeneral: TTabSheet
      Caption = 'General'
      ImageIndex = 3
      object GroupBox7: TGroupBox
        Left = 370
        Top = 10
        Width = 181
        Height = 141
        Caption = 'Food'
        TabOrder = 0
        object CheckBoxHungerSystem: TCheckBox
          Left = 10
          Top = 20
          Width = 151
          Height = 21
          Hint = '??????,??????????????,?????????,???????'
          Caption = 'Hunger'
          TabOrder = 0
          OnClick = CheckBoxHungerSystemClick
        end
        object GroupBoxHunger: TGroupBox
          Left = 10
          Top = 50
          Width = 161
          Height = 71
          Caption = 'Hunger Take'
          TabOrder = 1
          object CheckBoxHungerDecPower: TCheckBox
            Left = 10
            Top = 40
            Width = 121
            Height = 21
            Hint = '??????,????????,?????????????????'
            Caption = 'Dec Power'
            TabOrder = 0
            OnClick = CheckBoxHungerDecPowerClick
          end
          object CheckBoxHungerDecHP: TCheckBox
            Left = 10
            Top = 20
            Width = 111
            Height = 21
            Hint = '???????????????0?,???????HP?,??0?,?????'
            Caption = 'Dec HP'
            TabOrder = 1
            OnClick = CheckBoxHungerDecHPClick
          end
        end
      end
      object ButtonGeneralSave: TButton
        Left = 460
        Top = 326
        Width = 81
        Height = 32
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonGeneralSaveClick
      end
      object GroupBox34: TGroupBox
        Left = 10
        Top = 10
        Width = 171
        Height = 201
        Caption = 'Name Color'
        TabOrder = 2
        object Label85: TLabel
          Left = 14
          Top = 20
          Width = 18
          Height = 15
          Caption = 'Hit:'
        end
        object LabelPKFlagNameColor: TLabel
          Left = 140
          Top = 18
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label87: TLabel
          Left = 14
          Top = 50
          Width = 26
          Height = 15
          Caption = 'PK1:'
        end
        object LabelPKLevel1NameColor: TLabel
          Left = 140
          Top = 48
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label89: TLabel
          Left = 14
          Top = 80
          Width = 26
          Height = 15
          Caption = 'PK2:'
        end
        object LabelPKLevel2NameColor: TLabel
          Left = 140
          Top = 78
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label91: TLabel
          Left = 14
          Top = 110
          Width = 21
          Height = 15
          Caption = 'Ally:'
        end
        object LabelAllyAndGuildNameColor: TLabel
          Left = 140
          Top = 108
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label93: TLabel
          Left = 14
          Top = 140
          Width = 25
          Height = 15
          Caption = 'War:'
        end
        object LabelWarGuildNameColor: TLabel
          Left = 140
          Top = 138
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label95: TLabel
          Left = 14
          Top = 170
          Width = 50
          Height = 15
          Caption = 'PK Zone:'
        end
        object LabelInFreePKAreaNameColor: TLabel
          Left = 140
          Top = 168
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditPKFlagNameColor: TSpinEdit
          Left = 80
          Top = 15
          Width = 51
          Height = 24
          Hint = '??????????????,???47'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditPKFlagNameColorChange
        end
        object EditPKLevel1NameColor: TSpinEdit
          Left = 80
          Top = 45
          Width = 51
          Height = 24
          Hint = '???PK???100??????,???251'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditPKLevel1NameColorChange
        end
        object EditPKLevel2NameColor: TSpinEdit
          Left = 80
          Top = 75
          Width = 51
          Height = 24
          Hint = '???PK???200??????,???249'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditPKLevel2NameColorChange
        end
        object EditAllyAndGuildNameColor: TSpinEdit
          Left = 80
          Top = 105
          Width = 51
          Height = 24
          Hint = '?????????,??????????????,???180'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditAllyAndGuildNameColorChange
        end
        object EditWarGuildNameColor: TSpinEdit
          Left = 80
          Top = 135
          Width = 51
          Height = 24
          Hint = '?????????,??????????,???69'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditWarGuildNameColorChange
        end
        object EditInFreePKAreaNameColor: TSpinEdit
          Left = 80
          Top = 165
          Width = 51
          Height = 24
          Hint = '?????????????????,???221'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditInFreePKAreaNameColorChange
        end
      end
      object GroupBox62: TGroupBox
        Left = 190
        Top = 10
        Width = 171
        Height = 51
        Caption = '??????'
        TabOrder = 3
        object CheckBoxStartMapEvent: TCheckBox
          Left = 10
          Top = 20
          Width = 151
          Height = 21
          Caption = '????????'
          TabOrder = 0
          OnClick = CheckBoxStartMapEventClick
        end
      end
      object GroupBox77: TGroupBox
        Left = 10
        Top = 300
        Width = 181
        Height = 51
        Caption = '??????????'
        TabOrder = 4
        Visible = False
        object CheckBoxHumUseBagItem: TCheckBox
          Left = 10
          Top = 20
          Width = 161
          Height = 21
          Caption = '????????'
          TabOrder = 0
          OnClick = CheckBoxHumUseBagItemClick
        end
      end
      object GroupBox93: TGroupBox
        Left = 4
        Top = 219
        Width = 327
        Height = 72
        Caption = 'Server Name'
        TabOrder = 5
        object Label162: TLabel
          Left = 14
          Top = 30
          Width = 37
          Height = 15
          Caption = 'Name:'
        end
        object EditUnKnowName: TEdit
          Left = 194
          Top = 28
          Width = 117
          Height = 23
          TabOrder = 0
          OnChange = EditUnKnowNameChange
        end
      end
      object GroupBox96: TGroupBox
        Left = 190
        Top = 70
        Width = 171
        Height = 91
        Caption = '????'
        TabOrder = 6
        object Label165: TLabel
          Left = 10
          Top = 30
          Width = 31
          Height = 15
          Caption = '????:'
        end
        object Label166: TLabel
          Left = 140
          Top = 30
          Width = 7
          Height = 15
          Caption = '?'
        end
        object Label167: TLabel
          Left = 10
          Top = 60
          Width = 31
          Height = 15
          Caption = '????:'
        end
        object Label168: TLabel
          Left = 140
          Top = 60
          Width = 7
          Height = 15
          Caption = '?'
        end
        object EditStatusDelayTime1: TSpinEdit
          Left = 80
          Top = 25
          Width = 61
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditStatusDelayTime1Change
        end
        object EditStatusDelayTime2: TSpinEdit
          Left = 80
          Top = 55
          Width = 61
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditStatusDelayTime2Change
        end
      end
      object GroupBox98: TGroupBox
        Left = 370
        Top = 160
        Width = 181
        Height = 51
        Caption = '?????'
        TabOrder = 7
        object CheckBoxGetRandomHomePoint: TCheckBox
          Left = 10
          Top = 20
          Width = 101
          Height = 21
          Caption = '?????'
          TabOrder = 0
          OnClick = CheckBoxGetRandomHomePointClick
        end
      end
    end
    object PasswordSheet: TTabSheet
      Caption = 'Password'
      ImageIndex = 2
      object GroupBox1: TGroupBox
        Left = 10
        Top = 0
        Width = 541
        Height = 241
        TabOrder = 0
        object CheckBoxEnablePasswordLock: TCheckBox
          Left = 10
          Top = -6
          Width = 151
          Height = 31
          Caption = 'Enable Password Lock'
          TabOrder = 0
          OnClick = CheckBoxEnablePasswordLockClick
        end
        object GroupBox2: TGroupBox
          Left = 10
          Top = 20
          Width = 331
          Height = 211
          Caption = 'Storage'
          TabOrder = 1
          object CheckBoxLockGetBackItem: TCheckBox
            Left = 10
            Top = 20
            Width = 151
            Height = 21
            Caption = 'Get Back'
            TabOrder = 0
            OnClick = CheckBoxLockGetBackItemClick
          end
          object GroupBox4: TGroupBox
            Left = 10
            Top = 50
            Width = 311
            Height = 131
            Caption = 'Lock'
            TabOrder = 1
            object CheckBoxLockWalk: TCheckBox
              Left = 10
              Top = 40
              Width = 131
              Height = 21
              Caption = 'Walk'
              TabOrder = 0
              OnClick = CheckBoxLockWalkClick
            end
            object CheckBoxLockRun: TCheckBox
              Left = 10
              Top = 60
              Width = 131
              Height = 21
              Caption = 'Run'
              TabOrder = 1
              OnClick = CheckBoxLockRunClick
            end
            object CheckBoxLockHit: TCheckBox
              Left = 10
              Top = 80
              Width = 131
              Height = 21
              Caption = 'Hit'
              TabOrder = 2
              OnClick = CheckBoxLockHitClick
            end
            object CheckBoxLockSpell: TCheckBox
              Left = 10
              Top = 100
              Width = 131
              Height = 21
              Caption = 'Spell'
              TabOrder = 3
              OnClick = CheckBoxLockSpellClick
            end
            object CheckBoxLockSendMsg: TCheckBox
              Left = 150
              Top = 40
              Width = 131
              Height = 21
              Caption = 'Send Msg'
              TabOrder = 4
              OnClick = CheckBoxLockSendMsgClick
            end
            object CheckBoxLockInObMode: TCheckBox
              Left = 150
              Top = 20
              Width = 151
              Height = 21
              Hint = '????????,??????????,????????,?????????????'
              Caption = 'Observer'
              TabOrder = 5
              OnClick = CheckBoxLockInObModeClick
            end
            object CheckBoxLockLogin: TCheckBox
              Left = 10
              Top = 20
              Width = 131
              Height = 21
              Caption = 'Login'
              TabOrder = 6
              OnClick = CheckBoxLockLoginClick
            end
            object CheckBoxLockUseItem: TCheckBox
              Left = 150
              Top = 100
              Width = 131
              Height = 21
              Caption = 'Use Item'
              TabOrder = 7
              OnClick = CheckBoxLockUseItemClick
            end
            object CheckBoxLockDropItem: TCheckBox
              Left = 150
              Top = 80
              Width = 131
              Height = 21
              Caption = 'Drop Item'
              TabOrder = 8
              OnClick = CheckBoxLockDropItemClick
            end
            object CheckBoxLockDealItem: TCheckBox
              Left = 150
              Top = 60
              Width = 151
              Height = 21
              Caption = 'Deal Item'
              TabOrder = 9
              OnClick = CheckBoxLockDealItemClick
            end
          end
        end
        object GroupBox3: TGroupBox
          Left = 350
          Top = 20
          Width = 181
          Height = 81
          Caption = 'Attempts'
          TabOrder = 2
          object Label1: TLabel
            Left = 10
            Top = 23
            Width = 26
            Height = 15
            Caption = 'Trys:'
          end
          object EditErrorPasswordCount: TSpinEdit
            Left = 85
            Top = 19
            Width = 66
            Height = 24
            Hint = '????????,????????????,?????,??????????????????'
            EditorEnabled = False
            MaxValue = 10
            MinValue = 1
            TabOrder = 0
            Value = 10
            OnChange = EditErrorPasswordCountChange
          end
          object CheckBoxErrorCountKick: TCheckBox
            Left = 10
            Top = 50
            Width = 161
            Height = 21
            Caption = 'Kick Error'
            Enabled = False
            TabOrder = 1
            OnClick = CheckBoxErrorCountKickClick
          end
        end
        object ButtonPasswordLockSave: TButton
          Left = 450
          Top = 196
          Width = 81
          Height = 32
          Caption = '&Save'
          TabOrder = 3
          OnClick = ButtonPasswordLockSaveClick
        end
      end
    end
    object TabSheet32: TTabSheet
      Caption = 'Blank'
      ImageIndex = 4
    end
    object TabSheet33: TTabSheet
      Caption = 'Master'
      ImageIndex = 5
      object GroupBox21: TGroupBox
        Left = 10
        Top = 10
        Width = 201
        Height = 191
        Caption = 'Master'
        TabOrder = 0
        object GroupBox22: TGroupBox
          Left = 10
          Top = 20
          Width = 181
          Height = 61
          Caption = 'Level'
          TabOrder = 0
          object Label29: TLabel
            Left = 10
            Top = 23
            Width = 32
            Height = 15
            Caption = 'Level:'
          end
          object EditMasterOKLevel: TSpinEdit
            Left = 85
            Top = 19
            Width = 66
            Height = 24
            Hint = '??????,??????,????????????'
            MaxValue = 65535
            MinValue = 1
            TabOrder = 0
            Value = 10
            OnChange = EditMasterOKLevelChange
          end
        end
        object GroupBox23: TGroupBox
          Left = 10
          Top = 90
          Width = 181
          Height = 91
          Caption = 'Points'
          TabOrder = 1
          object Label30: TLabel
            Left = 10
            Top = 23
            Width = 67
            Height = 15
            Caption = 'Credit Point:'
          end
          object Label31: TLabel
            Left = 10
            Top = 53
            Width = 70
            Height = 15
            Caption = 'Bonus Point:'
          end
          object EditMasterOKCreditPoint: TSpinEdit
            Left = 85
            Top = 19
            Width = 66
            Height = 24
            Hint = '?????,??????????'
            MaxValue = 100
            MinValue = 0
            TabOrder = 0
            Value = 10
            OnChange = EditMasterOKCreditPointChange
          end
          object EditMasterOKBonusPoint: TSpinEdit
            Left = 85
            Top = 49
            Width = 66
            Height = 24
            Hint = '?????,??????????'
            MaxValue = 1000
            MinValue = 0
            TabOrder = 1
            Value = 10
            OnChange = EditMasterOKBonusPointChange
          end
        end
      end
      object ButtonMasterSave: TButton
        Left = 450
        Top = 196
        Width = 81
        Height = 32
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonMasterSaveClick
      end
    end
    object TabSheet38: TTabSheet
      Caption = 'Renew'
      ImageIndex = 9
      object GroupBox29: TGroupBox
        Left = 10
        Top = 10
        Width = 141
        Height = 321
        Caption = 'Colour'
        TabOrder = 0
        object Label56: TLabel
          Left = 14
          Top = 20
          Width = 10
          Height = 15
          Caption = '1:'
        end
        object LabelReNewNameColor1: TLabel
          Left = 110
          Top = 18
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label58: TLabel
          Left = 14
          Top = 50
          Width = 10
          Height = 15
          Caption = '2:'
        end
        object LabelReNewNameColor2: TLabel
          Left = 110
          Top = 48
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label60: TLabel
          Left = 14
          Top = 80
          Width = 10
          Height = 15
          Caption = '3:'
        end
        object LabelReNewNameColor3: TLabel
          Left = 110
          Top = 78
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label62: TLabel
          Left = 14
          Top = 110
          Width = 10
          Height = 15
          Caption = '4:'
        end
        object LabelReNewNameColor4: TLabel
          Left = 110
          Top = 108
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label64: TLabel
          Left = 14
          Top = 140
          Width = 10
          Height = 15
          Caption = '5:'
        end
        object LabelReNewNameColor5: TLabel
          Left = 110
          Top = 138
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label66: TLabel
          Left = 14
          Top = 170
          Width = 10
          Height = 15
          Caption = '6:'
        end
        object LabelReNewNameColor6: TLabel
          Left = 110
          Top = 168
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label68: TLabel
          Left = 14
          Top = 200
          Width = 10
          Height = 15
          Caption = '7:'
        end
        object LabelReNewNameColor7: TLabel
          Left = 110
          Top = 198
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label70: TLabel
          Left = 14
          Top = 230
          Width = 10
          Height = 15
          Caption = '8:'
        end
        object LabelReNewNameColor8: TLabel
          Left = 110
          Top = 228
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label72: TLabel
          Left = 14
          Top = 260
          Width = 10
          Height = 15
          Caption = '9:'
        end
        object LabelReNewNameColor9: TLabel
          Left = 110
          Top = 258
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label74: TLabel
          Left = 14
          Top = 290
          Width = 17
          Height = 15
          Caption = '10:'
        end
        object LabelReNewNameColor10: TLabel
          Left = 110
          Top = 288
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditReNewNameColor1: TSpinEdit
          Left = 50
          Top = 15
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditReNewNameColor1Change
        end
        object EditReNewNameColor2: TSpinEdit
          Left = 50
          Top = 45
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditReNewNameColor2Change
        end
        object EditReNewNameColor3: TSpinEdit
          Left = 50
          Top = 75
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditReNewNameColor3Change
        end
        object EditReNewNameColor4: TSpinEdit
          Left = 50
          Top = 105
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditReNewNameColor4Change
        end
        object EditReNewNameColor5: TSpinEdit
          Left = 50
          Top = 135
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditReNewNameColor5Change
        end
        object EditReNewNameColor6: TSpinEdit
          Left = 50
          Top = 165
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditReNewNameColor6Change
        end
        object EditReNewNameColor7: TSpinEdit
          Left = 50
          Top = 195
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditReNewNameColor7Change
        end
        object EditReNewNameColor8: TSpinEdit
          Left = 50
          Top = 225
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditReNewNameColor8Change
        end
        object EditReNewNameColor9: TSpinEdit
          Left = 50
          Top = 255
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditReNewNameColor9Change
        end
        object EditReNewNameColor10: TSpinEdit
          Left = 50
          Top = 285
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 9
          Value = 100
          OnChange = EditReNewNameColor10Change
        end
      end
      object ButtonReNewLevelSave: TButton
        Left = 450
        Top = 196
        Width = 81
        Height = 32
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonReNewLevelSaveClick
      end
      object GroupBox30: TGroupBox
        Left = 160
        Top = 10
        Width = 131
        Height = 81
        Caption = 'Colour'
        TabOrder = 2
        object Label57: TLabel
          Left = 10
          Top = 53
          Width = 31
          Height = 15
          Caption = 'Time:'
        end
        object Label59: TLabel
          Left = 104
          Top = 55
          Width = 9
          Height = 15
          Caption = 'M'
        end
        object EditReNewNameColorTime: TSpinEdit
          Left = 55
          Top = 49
          Width = 46
          Height = 24
          Hint = '??????,??????,????????????'
          EditorEnabled = False
          MaxValue = 10
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditReNewNameColorTimeChange
        end
        object CheckBoxReNewChangeColor: TCheckBox
          Left = 10
          Top = 20
          Width = 111
          Height = 21
          Hint = '??????,????????????????'
          Caption = 'Change'
          TabOrder = 1
          OnClick = CheckBoxReNewChangeColorClick
        end
      end
      object GroupBox33: TGroupBox
        Left = 160
        Top = 100
        Width = 131
        Height = 51
        Caption = 'EXP'
        TabOrder = 3
        object CheckBoxReNewLevelClearExp: TCheckBox
          Left = 10
          Top = 20
          Width = 111
          Height = 21
          Hint = '???????????????'
          Caption = 'Clear Exp'
          TabOrder = 0
          OnClick = CheckBoxReNewLevelClearExpClick
        end
      end
    end
    object TabSheet39: TTabSheet
      Caption = 'MonUp'
      ImageIndex = 10
      object ButtonMonUpgradeSave: TButton
        Left = 450
        Top = 326
        Width = 81
        Height = 32
        Caption = '&Save'
        TabOrder = 0
        OnClick = ButtonMonUpgradeSaveClick
      end
      object GroupBox32: TGroupBox
        Left = 10
        Top = 10
        Width = 141
        Height = 291
        Caption = 'MonColor'
        TabOrder = 1
        object Label65: TLabel
          Left = 14
          Top = 20
          Width = 10
          Height = 15
          Caption = '1:'
        end
        object LabelMonUpgradeColor1: TLabel
          Left = 110
          Top = 18
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label67: TLabel
          Left = 14
          Top = 50
          Width = 10
          Height = 15
          Caption = '2:'
        end
        object LabelMonUpgradeColor2: TLabel
          Left = 110
          Top = 48
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label69: TLabel
          Left = 14
          Top = 80
          Width = 10
          Height = 15
          Caption = '3:'
        end
        object LabelMonUpgradeColor3: TLabel
          Left = 110
          Top = 78
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label71: TLabel
          Left = 14
          Top = 110
          Width = 10
          Height = 15
          Caption = '4:'
        end
        object LabelMonUpgradeColor4: TLabel
          Left = 110
          Top = 108
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label73: TLabel
          Left = 14
          Top = 140
          Width = 10
          Height = 15
          Caption = '5:'
        end
        object LabelMonUpgradeColor5: TLabel
          Left = 110
          Top = 138
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label75: TLabel
          Left = 14
          Top = 170
          Width = 10
          Height = 15
          Caption = '6:'
        end
        object LabelMonUpgradeColor6: TLabel
          Left = 110
          Top = 168
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label76: TLabel
          Left = 14
          Top = 200
          Width = 10
          Height = 15
          Caption = '7:'
        end
        object LabelMonUpgradeColor7: TLabel
          Left = 110
          Top = 198
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label77: TLabel
          Left = 14
          Top = 230
          Width = 10
          Height = 15
          Caption = '8:'
        end
        object LabelMonUpgradeColor8: TLabel
          Left = 110
          Top = 228
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label86: TLabel
          Left = 14
          Top = 260
          Width = 10
          Height = 15
          Caption = '9:'
        end
        object LabelMonUpgradeColor9: TLabel
          Left = 110
          Top = 258
          Width = 11
          Height = 21
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditMonUpgradeColor1: TSpinEdit
          Left = 50
          Top = 15
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditMonUpgradeColor1Change
        end
        object EditMonUpgradeColor2: TSpinEdit
          Left = 50
          Top = 45
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMonUpgradeColor2Change
        end
        object EditMonUpgradeColor3: TSpinEdit
          Left = 50
          Top = 75
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMonUpgradeColor3Change
        end
        object EditMonUpgradeColor4: TSpinEdit
          Left = 50
          Top = 105
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMonUpgradeColor4Change
        end
        object EditMonUpgradeColor5: TSpinEdit
          Left = 50
          Top = 135
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditMonUpgradeColor5Change
        end
        object EditMonUpgradeColor6: TSpinEdit
          Left = 50
          Top = 165
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditMonUpgradeColor6Change
        end
        object EditMonUpgradeColor7: TSpinEdit
          Left = 50
          Top = 195
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditMonUpgradeColor7Change
        end
        object EditMonUpgradeColor8: TSpinEdit
          Left = 50
          Top = 225
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditMonUpgradeColor8Change
        end
        object EditMonUpgradeColor9: TSpinEdit
          Left = 50
          Top = 255
          Width = 51
          Height = 24
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditMonUpgradeColor9Change
        end
      end
      object GroupBox31: TGroupBox
        Left = 160
        Top = 10
        Width = 121
        Height = 291
        Caption = 'Kills'
        TabOrder = 2
        object Label61: TLabel
          Left = 14
          Top = 20
          Width = 10
          Height = 15
          Caption = '1:'
        end
        object Label63: TLabel
          Left = 14
          Top = 50
          Width = 10
          Height = 15
          Caption = '2:'
        end
        object Label78: TLabel
          Left = 14
          Top = 80
          Width = 10
          Height = 15
          Caption = '3:'
        end
        object Label79: TLabel
          Left = 14
          Top = 110
          Width = 10
          Height = 15
          Caption = '4:'
        end
        object Label80: TLabel
          Left = 14
          Top = 140
          Width = 10
          Height = 15
          Caption = '5:'
        end
        object Label81: TLabel
          Left = 14
          Top = 170
          Width = 10
          Height = 15
          Caption = '6:'
        end
        object Label82: TLabel
          Left = 14
          Top = 200
          Width = 10
          Height = 15
          Caption = '7:'
        end
        object Label83: TLabel
          Left = 14
          Top = 230
          Width = 32
          Height = 15
          Caption = 'Base:'
        end
        object Label84: TLabel
          Left = 14
          Top = 260
          Width = 29
          Height = 15
          Caption = 'Rate:'
        end
        object EditMonUpgradeKillCount1: TSpinEdit
          Left = 50
          Top = 15
          Width = 61
          Height = 24
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditMonUpgradeKillCount1Change
        end
        object EditMonUpgradeKillCount2: TSpinEdit
          Left = 50
          Top = 45
          Width = 61
          Height = 24
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMonUpgradeKillCount2Change
        end
        object EditMonUpgradeKillCount3: TSpinEdit
          Left = 50
          Top = 75
          Width = 61
          Height = 24
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMonUpgradeKillCount3Change
        end
        object EditMonUpgradeKillCount4: TSpinEdit
          Left = 50
          Top = 105
          Width = 61
          Height = 24
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMonUpgradeKillCount4Change
        end
        object EditMonUpgradeKillCount5: TSpinEdit
          Left = 50
          Top = 135
          Width = 61
          Height = 24
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditMonUpgradeKillCount5Change
        end
        object EditMonUpgradeKillCount6: TSpinEdit
          Left = 50
          Top = 165
          Width = 61
          Height = 24
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditMonUpgradeKillCount6Change
        end
        object EditMonUpgradeKillCount7: TSpinEdit
          Left = 50
          Top = 195
          Width = 61
          Height = 24
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditMonUpgradeKillCount7Change
        end
        object EditMonUpLvNeedKillBase: TSpinEdit
          Left = 50
          Top = 225
          Width = 61
          Height = 24
          Hint = '????=?? * ?? + ?? + ?? + ????'
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditMonUpLvNeedKillBaseChange
        end
        object EditMonUpLvRate: TSpinEdit
          Left = 50
          Top = 255
          Width = 61
          Height = 24
          Hint = '????=???? * ?? + ?? + ?? + ????'
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditMonUpLvRateChange
        end
      end
      object GroupBox35: TGroupBox
        Left = 290
        Top = 10
        Width = 171
        Height = 141
        Caption = 'Master'
        TabOrder = 3
        object Label88: TLabel
          Left = 14
          Top = 50
          Width = 29
          Height = 15
          Caption = 'Rate:'
        end
        object Label90: TLabel
          Left = 14
          Top = 80
          Width = 38
          Height = 15
          Caption = 'Power:'
        end
        object Label92: TLabel
          Left = 14
          Top = 110
          Width = 39
          Height = 15
          Caption = 'Speed:'
        end
        object CheckBoxMasterDieMutiny: TCheckBox
          Left = 10
          Top = 20
          Width = 141
          Height = 21
          Caption = 'Die Mutiny'
          TabOrder = 0
          OnClick = CheckBoxMasterDieMutinyClick
        end
        object EditMasterDieMutinyRate: TSpinEdit
          Left = 90
          Top = 45
          Width = 61
          Height = 24
          Hint = '????,???????'
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMasterDieMutinyRateChange
        end
        object EditMasterDieMutinyPower: TSpinEdit
          Left = 90
          Top = 75
          Width = 61
          Height = 24
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMasterDieMutinyPowerChange
        end
        object EditMasterDieMutinySpeed: TSpinEdit
          Left = 90
          Top = 105
          Width = 61
          Height = 24
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMasterDieMutinySpeedChange
        end
      end
      object GroupBox47: TGroupBox
        Left = 290
        Top = 160
        Width = 171
        Height = 91
        Caption = 'Change Color'
        TabOrder = 4
        object Label112: TLabel
          Left = 14
          Top = 50
          Width = 31
          Height = 15
          Caption = 'Time:'
        end
        object CheckBoxBBMonAutoChangeColor: TCheckBox
          Left = 10
          Top = 20
          Width = 141
          Height = 21
          Caption = 'Auto Change color'
          TabOrder = 0
          OnClick = CheckBoxBBMonAutoChangeColorClick
        end
        object EditBBMonAutoChangeColorTime: TSpinEdit
          Left = 90
          Top = 45
          Width = 61
          Height = 24
          Hint = '????,??????,??(?)?'
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 1
          TabOrder = 1
          Value = 100
          OnChange = EditBBMonAutoChangeColorTimeChange
        end
      end
    end
    object MonSaySheet: TTabSheet
      Caption = 'MonSay'
      object GroupBox40: TGroupBox
        Left = 10
        Top = 10
        Width = 171
        Height = 61
        Caption = 'Mon Say'
        TabOrder = 0
        object CheckBoxMonSayMsg: TCheckBox
          Left = 10
          Top = 20
          Width = 141
          Height = 21
          Caption = 'Allow Mon Say'
          TabOrder = 0
          OnClick = CheckBoxMonSayMsgClick
        end
      end
      object ButtonMonSayMsgSave: TButton
        Left = 470
        Top = 346
        Width = 81
        Height = 25
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonMonSayMsgSaveClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Misc'
      ImageIndex = 1
      object MagicPageControl: TPageControl
        Left = -8
        Top = 8
        Width = 561
        Height = 381
        ActivePage = TabSheet2
        MultiLine = True
        TabOrder = 0
        TabPosition = tpBottom
        object TabSheet36: TTabSheet
          Caption = 'Magic Attack'
          ImageIndex = 31
          object GroupBox17: TGroupBox
            Left = 10
            Top = 10
            Width = 181
            Height = 61
            Caption = 'Attack'
            TabOrder = 0
            object Label12: TLabel
              Left = 10
              Top = 23
              Width = 40
              Height = 15
              Caption = 'Range:'
            end
            object EditMagicAttackRage: TSpinEdit
              Left = 85
              Top = 19
              Width = 66
              Height = 24
              Hint = '????????,???????????'
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMagicAttackRageChange
            end
          end
          object GroupBox87: TGroupBox
            Left = 10
            Top = 80
            Width = 271
            Height = 131
            Caption = 'Hint'
            TabOrder = 1
            object CheckBoxNoHintMagicFail: TCheckBox
              Left = 20
              Top = 20
              Width = 241
              Height = 31
              Caption = 'No Hint Magic Fail'
              TabOrder = 0
              OnClick = CheckBoxNoHintMagicFailClick
            end
            object CheckBoxNoHintMagicOK: TCheckBox
              Left = 20
              Top = 50
              Width = 241
              Height = 31
              Caption = 'No Hint Magic Ok'
              TabOrder = 1
              OnClick = CheckBoxNoHintMagicOKClick
            end
            object CheckBoxNoHintMagicClose: TCheckBox
              Left = 20
              Top = 80
              Width = 241
              Height = 31
              Caption = 'No Hint Magic Close'
              TabOrder = 2
              OnClick = CheckBoxNoHintMagicCloseClick
            end
          end
        end
        object TabSheet11: TTabSheet
          Caption = 'Thrusting'
          ImageIndex = 10
          object GroupBox9: TGroupBox
            Left = 10
            Top = 10
            Width = 141
            Height = 51
            Caption = 'SwordLong Limit'
            TabOrder = 0
            object CheckBoxLimitSwordLong: TCheckBox
              Left = 10
              Top = 20
              Width = 121
              Height = 21
              Hint = '??????,??????????????,????????'
              Caption = 'S/Long Limit'
              TabOrder = 0
              OnClick = CheckBoxLimitSwordLongClick
            end
          end
          object GroupBox10: TGroupBox
            Left = 10
            Top = 70
            Width = 161
            Height = 51
            Caption = 'Power'
            TabOrder = 1
            object Label4: TLabel
              Left = 10
              Top = 25
              Width = 29
              Height = 15
              Caption = 'Rate:'
            end
            object Label10: TLabel
              Left = 120
              Top = 25
              Width = 24
              Height = 15
              Caption = '/100'
            end
            object EditSwordLongPowerRate: TSpinEdit
              Left = 55
              Top = 19
              Width = 56
              Height = 24
              Hint = '?????,???? ?? 100??????'
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditSwordLongPowerRateChange
            end
          end
        end
        object TabSheet18: TTabSheet
          Caption = 'Taming'
          ImageIndex = 17
          object GroupBox38: TGroupBox
            Left = 10
            Top = 10
            Width = 141
            Height = 51
            Caption = 'Taming'
            TabOrder = 0
            object Label98: TLabel
              Left = 10
              Top = 25
              Width = 26
              Height = 15
              Caption = 'Mag:'
            end
            object EditMagTammingLevel: TSpinEdit
              Left = 55
              Top = 19
              Width = 76
              Height = 24
              Hint = '??????????????,??????????????'
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditMagTammingLevelChange
            end
          end
          object GroupBox39: TGroupBox
            Left = 10
            Top = 70
            Width = 141
            Height = 91
            Caption = 'Target'
            TabOrder = 1
            object Label99: TLabel
              Left = 10
              Top = 25
              Width = 32
              Height = 15
              Caption = 'Level:'
            end
            object Label100: TLabel
              Left = 10
              Top = 55
              Width = 49
              Height = 15
              Caption = 'HP Rate:'
            end
            object EditMagTammingTargetLevel: TSpinEdit
              Left = 80
              Top = 19
              Width = 51
              Height = 24
              Hint = '??????,??????????'
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditMagTammingTargetLevelChange
            end
            object EditMagTammingHPRate: TSpinEdit
              Left = 80
              Top = 49
              Width = 51
              Height = 24
              Hint = '??????,?????,?????'
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 1
              Value = 1
              OnChange = EditMagTammingHPRateChange
            end
          end
          object GroupBox45: TGroupBox
            Left = 160
            Top = 10
            Width = 141
            Height = 51
            Caption = 'Count'
            TabOrder = 2
            object Label111: TLabel
              Left = 10
              Top = 25
              Width = 36
              Height = 15
              Caption = 'Count:'
            end
            object EditTammingCount: TSpinEdit
              Left = 55
              Top = 19
              Width = 76
              Height = 24
              Hint = '????????'
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditTammingCountChange
            end
          end
        end
        object TabSheet20: TTabSheet
          Caption = '??'
          ImageIndex = 19
          object GroupBox46: TGroupBox
            Left = 10
            Top = 10
            Width = 141
            Height = 51
            Caption = '???????'
            TabOrder = 0
            object CheckBoxFireCrossInSafeZone: TCheckBox
              Left = 10
              Top = 20
              Width = 121
              Height = 21
              Hint = '??????,???????????'
              Caption = '????'
              TabOrder = 0
              OnClick = CheckBoxFireCrossInSafeZoneClick
            end
          end
          object GroupBox63: TGroupBox
            Left = 159
            Top = 10
            Width = 192
            Height = 51
            Caption = '???????'
            TabOrder = 1
            object CheckBoxFireChgMapExtinguish: TCheckBox
              Left = 16
              Top = 16
              Width = 135
              Height = 22
              Caption = '???????'
              TabOrder = 0
              OnClick = CheckBoxFireChgMapExtinguishClick
            end
          end
          object GroupBox53: TGroupBox
            Left = 10
            Top = 69
            Width = 231
            Height = 92
            Caption = '????'
            TabOrder = 2
            object Label117: TLabel
              Left = 10
              Top = 25
              Width = 45
              Height = 15
              Caption = '??????:'
            end
            object Label116: TLabel
              Left = 10
              Top = 55
              Width = 31
              Height = 15
              Caption = '????:'
            end
            object SpinEditFireDelayTime: TSpinEdit
              Left = 120
              Top = 20
              Width = 101
              Height = 24
              Hint = '???????????100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = SpinEditFireDelayTimeClick
            end
            object SpinEditFirePower: TSpinEdit
              Left = 120
              Top = 50
              Width = 101
              Height = 24
              Hint = '???????????100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = SpinEditFirePowerClick
            end
          end
        end
        object TabSheet28: TTabSheet
          Caption = 'Turn Undead'
          ImageIndex = 27
          object GroupBox37: TGroupBox
            Left = 10
            Top = 10
            Width = 141
            Height = 51
            Caption = 'Turn Undead'
            TabOrder = 0
            object Label97: TLabel
              Left = 10
              Top = 25
              Width = 32
              Height = 15
              Caption = 'Level:'
            end
            object EditMagTurnUndeadLevel: TSpinEdit
              Left = 55
              Top = 19
              Width = 76
              Height = 24
              Hint = '??????????????,??????????????'
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditMagTurnUndeadLevelChange
            end
          end
        end
        object TabSheet22: TTabSheet
          Caption = 'Thunder Storm'
          ImageIndex = 21
          object GroupBox15: TGroupBox
            Left = 10
            Top = 10
            Width = 141
            Height = 51
            Caption = 'Range'
            TabOrder = 0
            object Label9: TLabel
              Left = 10
              Top = 25
              Width = 32
              Height = 15
              Caption = 'Cells:'
            end
            object EditElecBlizzardRange: TSpinEdit
              Left = 55
              Top = 19
              Width = 76
              Height = 24
              Hint = '?????????'
              EditorEnabled = False
              MaxValue = 12
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditElecBlizzardRangeChange
            end
          end
        end
        object TabSheet21: TTabSheet
          Caption = 'Fire Bang'
          ImageIndex = 20
          object GroupBox13: TGroupBox
            Left = 10
            Top = 10
            Width = 141
            Height = 51
            Caption = 'Range'
            TabOrder = 0
            object Label7: TLabel
              Left = 10
              Top = 25
              Width = 32
              Height = 15
              Caption = 'Cells:'
            end
            object EditFireBoomRage: TSpinEdit
              Left = 55
              Top = 19
              Width = 76
              Height = 24
              Hint = '?????????'
              EditorEnabled = False
              MaxValue = 12
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditFireBoomRageChange
            end
          end
        end
        object TabSheet29: TTabSheet
          Caption = 'Ice Storm'
          ImageIndex = 28
          object GroupBox14: TGroupBox
            Left = 10
            Top = 10
            Width = 141
            Height = 51
            Caption = 'Range'
            TabOrder = 0
            object Label8: TLabel
              Left = 10
              Top = 25
              Width = 32
              Height = 15
              Caption = 'Cells:'
            end
            object EditSnowWindRange: TSpinEdit
              Left = 55
              Top = 19
              Width = 76
              Height = 24
              Hint = '?????????'
              EditorEnabled = False
              MaxValue = 12
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditSnowWindRangeChange
            end
          end
        end
        object TabSheet6: TTabSheet
          Caption = 'Poisoning'
          ImageIndex = 4
          object GroupBox16: TGroupBox
            Left = 10
            Top = 10
            Width = 171
            Height = 61
            Caption = 'Poison'
            TabOrder = 0
            object Label11: TLabel
              Left = 10
              Top = 23
              Width = 38
              Height = 15
              Caption = 'Points:'
            end
            object EditAmyOunsulPoint: TSpinEdit
              Left = 85
              Top = 19
              Width = 66
              Height = 24
              Hint = '???????????,??????????????????,????????????,?????,?????'
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditAmyOunsulPointChange
            end
          end
          object GroupBox97: TGroupBox
            Left = 9
            Top = 80
            Width = 172
            Height = 51
            Caption = '???????'
            TabOrder = 1
            object CheckBoxChangeMapReleasePoison: TCheckBox
              Left = 16
              Top = 16
              Width = 135
              Height = 22
              Caption = '???????'
              TabOrder = 0
              OnClick = CheckBoxChangeMapReleasePoisonClick
            end
          end
        end
        object TabSheet3: TTabSheet
          Caption = 'Bone Fame'
          ImageIndex = 1
          object GroupBox5: TGroupBox
            Left = 6
            Top = 3
            Width = 165
            Height = 168
            Caption = 'Details'
            TabOrder = 0
            object Label2: TLabel
              Left = 10
              Top = 23
              Width = 37
              Height = 15
              Caption = 'Name:'
            end
            object Label3: TLabel
              Left = 10
              Top = 73
              Width = 36
              Height = 15
              Caption = 'Count:'
            end
            object EditBoneFammName: TEdit
              Left = 10
              Top = 40
              Width = 131
              Height = 23
              Hint = '????????????'
              TabOrder = 0
              OnChange = EditBoneFammNameChange
            end
            object EditBoneFammCount: TSpinEdit
              Left = 75
              Top = 69
              Width = 66
              Height = 24
              Hint = '??????????'
              EditorEnabled = False
              MaxValue = 255
              MinValue = 1
              TabOrder = 1
              Value = 10
              OnChange = EditBoneFammCountChange
            end
          end
          object GroupBox6: TGroupBox
            Left = 180
            Top = 3
            Width = 361
            Height = 168
            Caption = 'List'
            TabOrder = 1
            object GridBoneFamm: TStringGrid
              Left = 10
              Top = 20
              Width = 331
              Height = 141
              ColCount = 4
              DefaultRowHeight = 18
              FixedCols = 0
              RowCount = 11
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
              TabOrder = 0
              OnSetEditText = GridBoneFammSetEditText
              ColWidths = (
                55
                76
                57
                52)
            end
          end
        end
        object TabSheet4: TTabSheet
          Caption = 'Shinsu'
          ImageIndex = 2
          object GroupBox11: TGroupBox
            Left = 6
            Top = 3
            Width = 165
            Height = 168
            Caption = 'Details'
            TabOrder = 0
            object Label5: TLabel
              Left = 10
              Top = 23
              Width = 37
              Height = 15
              Caption = 'Name:'
            end
            object Label6: TLabel
              Left = 10
              Top = 73
              Width = 36
              Height = 15
              Caption = 'Count:'
            end
            object EditDogzName: TEdit
              Left = 10
              Top = 40
              Width = 131
              Height = 23
              Hint = '????????????'
              TabOrder = 0
              OnChange = EditDogzNameChange
            end
            object EditDogzCount: TSpinEdit
              Left = 75
              Top = 69
              Width = 66
              Height = 24
              Hint = '??????????'
              EditorEnabled = False
              MaxValue = 255
              MinValue = 1
              TabOrder = 1
              Value = 10
              OnChange = EditDogzCountChange
            end
          end
          object GroupBox12: TGroupBox
            Left = 180
            Top = 3
            Width = 361
            Height = 168
            Caption = 'List'
            TabOrder = 1
            object GridDogz: TStringGrid
              Left = 10
              Top = 20
              Width = 331
              Height = 141
              ColCount = 4
              DefaultRowHeight = 18
              FixedCols = 0
              RowCount = 11
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
              TabOrder = 0
              OnSetEditText = GridBoneFammSetEditText
              ColWidths = (
                55
                76
                57
                52)
            end
          end
        end
        object TabSheet41: TTabSheet
          Caption = 'Paraball'
          ImageIndex = 32
          object GroupBox41: TGroupBox
            Left = 10
            Top = 10
            Width = 181
            Height = 91
            Caption = 'Mabe Hit'
            TabOrder = 0
            object Label101: TLabel
              Left = 10
              Top = 23
              Width = 80
              Height = 15
              Caption = 'Random Rate:'
            end
            object Label102: TLabel
              Left = 10
              Top = 53
              Width = 62
              Height = 15
              Caption = 'Level Limit:'
            end
            object EditMabMabeHitRandRate: TSpinEdit
              Left = 101
              Top = 19
              Width = 66
              Height = 24
              Hint = '???????????????,?????????'
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMabMabeHitRandRateChange
            end
            object EditMabMabeHitMinLvLimit: TSpinEdit
              Left = 101
              Top = 49
              Width = 66
              Height = 24
              Hint = '???????????????,????,?????????'
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 1
              Value = 10
              OnChange = EditMabMabeHitMinLvLimitChange
            end
          end
          object GroupBox42: TGroupBox
            Left = 10
            Top = 110
            Width = 181
            Height = 61
            Caption = 'Success Rate'
            TabOrder = 1
            object Label103: TLabel
              Left = 10
              Top = 23
              Width = 29
              Height = 15
              Caption = 'Rate:'
            end
            object EditMabMabeHitSucessRate: TSpinEdit
              Left = 85
              Top = 19
              Width = 66
              Height = 24
              Hint = '??????,????,?????????'
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMabMabeHitSucessRateChange
            end
          end
          object GroupBox43: TGroupBox
            Left = 200
            Top = 10
            Width = 181
            Height = 61
            Caption = 'Time Rate'
            TabOrder = 2
            object Label104: TLabel
              Left = 10
              Top = 23
              Width = 31
              Height = 15
              Caption = 'Time:'
            end
            object EditMabMabeHitMabeTimeRate: TSpinEdit
              Left = 85
              Top = 19
              Width = 66
              Height = 24
              Hint = '????????,???????????'
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMabMabeHitMabeTimeRateChange
            end
          end
        end
        object TabSheet43: TTabSheet
          Caption = 'Group Attack'
          ImageIndex = 33
          object GroupBox48: TGroupBox
            Left = 10
            Top = 10
            Width = 159
            Height = 51
            Caption = 'Group mob attack player'
            TabOrder = 0
            object CheckBoxGroupMbAttackPlayObject: TCheckBox
              Left = 10
              Top = 20
              Width = 121
              Height = 21
              Hint = '??????,???????'
              Caption = 'Enable'
              TabOrder = 0
              OnClick = CheckBoxGroupMbAttackPlayObjectClick
            end
          end
          object GroupBox54: TGroupBox
            Left = 216
            Top = 10
            Width = 151
            Height = 51
            Caption = 'Group mob attack slave'
            TabOrder = 1
            object CheckBoxGroupMbAttackSlave: TCheckBox
              Left = 10
              Top = 20
              Width = 121
              Height = 21
              Caption = 'Enable'
              TabOrder = 0
              OnClick = CheckBoxGroupMbAttackSlaveClick
            end
          end
        end
        object TabSheet45: TTabSheet
          Caption = '???'
          ImageIndex = 34
          object GroupBox50: TGroupBox
            Left = 10
            Top = 10
            Width = 201
            Height = 81
            Caption = '???????'
            TabOrder = 0
            object CheckBoxPullPlayObject: TCheckBox
              Left = 20
              Top = 20
              Width = 111
              Height = 21
              Caption = '?????'
              TabOrder = 0
              OnClick = CheckBoxPullPlayObjectClick
            end
            object CheckBoxPullCrossInSafeZone: TCheckBox
              Left = 20
              Top = 50
              Width = 151
              Height = 21
              Caption = '????????'
              TabOrder = 1
              OnClick = CheckBoxPullCrossInSafeZoneClick
            end
          end
        end
        object TabSheet46: TTabSheet
          Caption = '???'
          ImageIndex = 35
          object GroupBox51: TGroupBox
            Left = 10
            Top = 10
            Width = 151
            Height = 61
            Caption = '?MP?'
            TabOrder = 0
            object CheckBoxPlayObjectReduceMP: TCheckBox
              Left = 20
              Top = 20
              Width = 121
              Height = 21
              Caption = '???MP?'
              TabOrder = 0
              OnClick = CheckBoxPlayObjectReduceMPClick
            end
          end
        end
        object TabSheet49: TTabSheet
          Caption = '???'
          ImageIndex = 38
          object GroupBox58: TGroupBox
            Left = 10
            Top = 10
            Width = 531
            Height = 181
            Caption = '????(1)'
            TabOrder = 0
            object Label121: TLabel
              Left = 20
              Top = 30
              Width = 45
              Height = 15
              Caption = '??????:'
            end
            object Label122: TLabel
              Left = 20
              Top = 60
              Width = 31
              Height = 15
              Caption = '????:'
            end
            object Label123: TLabel
              Left = 20
              Top = 90
              Width = 73
              Height = 15
              Caption = '??????????:'
            end
            object Label124: TLabel
              Left = 20
              Top = 120
              Width = 59
              Height = 15
              Caption = '????????:'
            end
            object Label125: TLabel
              Left = 20
              Top = 150
              Width = 73
              Height = 15
              Caption = '??????????:'
            end
            object Label126: TLabel
              Left = 310
              Top = 120
              Width = 49
              Height = 15
              Caption = '% ?????'
            end
            object Label127: TLabel
              Left = 310
              Top = 150
              Width = 49
              Height = 15
              Caption = '% ?????'
            end
            object SpinEditAllowCopyCount: TSpinEdit
              Left = 180
              Top = 25
              Width = 151
              Height = 24
              Hint = '???????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = SpinEditAllowCopyCountChange
            end
            object EditCopyHumName: TEdit
              Left = 180
              Top = 55
              Width = 151
              Height = 23
              TabOrder = 1
              OnChange = EditCopyHumNameChange
            end
            object CheckBoxMasterName: TCheckBox
              Left = 340
              Top = 55
              Width = 171
              Height = 21
              Caption = '?????????'
              TabOrder = 2
              OnClick = CheckBoxMasterNameClick
            end
            object SpinEditPickUpItemCount: TSpinEdit
              Left = 180
              Top = 85
              Width = 151
              Height = 24
              Hint = 
                '???????????,??????,?????????????,????????????????,??????????????' +
                ',???????????'
              MaxValue = 0
              MinValue = 0
              TabOrder = 3
              Value = 0
              OnChange = SpinEditPickUpItemCountChange
            end
            object SpinEditEatHPItemRate: TSpinEdit
              Left = 180
              Top = 115
              Width = 121
              Height = 24
              MaxValue = 100
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              Value = 60
              OnChange = SpinEditEatHPItemRateChange
            end
            object SpinEditEatMPItemRate: TSpinEdit
              Left = 180
              Top = 145
              Width = 121
              Height = 24
              MaxValue = 100
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 5
              Value = 60
              OnChange = SpinEditEatMPItemRateChange
            end
            object CheckBoxAllowGuardAttack: TCheckBox
              Left = 340
              Top = 90
              Width = 151
              Height = 21
              Caption = '????????'
              TabOrder = 6
              OnClick = CheckBoxAllowGuardAttackClick
            end
            object CheckBoxAllowRecallSelf: TCheckBox
              Left = 340
              Top = 20
              Width = 151
              Height = 21
              Caption = '????????'
              TabOrder = 7
              OnClick = CheckBoxAllowRecallSelfClick
            end
          end
        end
        object TabSheet51: TTabSheet
          Caption = '???'
          ImageIndex = 39
          object GroupBox59: TGroupBox
            Left = 10
            Top = 10
            Width = 531
            Height = 271
            Caption = '????(2)'
            TabOrder = 0
            object GroupBox61: TGroupBox
              Left = 290
              Top = 20
              Width = 231
              Height = 91
              Caption = '?????????'
              TabOrder = 0
              object CheckBoxNeedLevelHighTarget: TCheckBox
                Left = 10
                Top = 60
                Width = 181
                Height = 21
                Hint = '?????,?????????????????????????'
                Caption = '??????????'
                TabOrder = 0
                OnClick = CheckBoxNeedLevelHighTargetClick
              end
              object CheckBoxAllowReCallMobOtherHum: TCheckBox
                Left = 10
                Top = 30
                Width = 211
                Height = 21
                Hint = 
                  '???????,??????,?????????????,???????????????????????????????????' +
                  '?'
                Caption = '????????????'
                TabOrder = 1
                OnClick = CheckBoxAllowReCallMobOtherHumClick
              end
            end
            object GroupBox78: TGroupBox
              Left = 340
              Top = 120
              Width = 181
              Height = 51
              Caption = '??????????'
              TabOrder = 1
              object CheckBoxMonUseBagItem: TCheckBox
                Left = 10
                Top = 20
                Width = 161
                Height = 21
                Caption = '????????'
                TabOrder = 0
                OnClick = CheckBoxMonUseBagItemClick
              end
            end
            object GroupBox69: TGroupBox
              Left = 10
              Top = 20
              Width = 181
              Height = 111
              Caption = '????'
              TabOrder = 2
              object Label133: TLabel
                Left = 10
                Top = 80
                Width = 45
                Height = 15
                Caption = '??????:'
              end
              object Label132: TLabel
                Left = 10
                Top = 50
                Width = 45
                Height = 15
                Caption = '??????:'
              end
              object Label131: TLabel
                Left = 10
                Top = 20
                Width = 45
                Height = 15
                Caption = '??????:'
              end
              object SpinEditWarrorAttackTime: TSpinEdit
                Left = 110
                Top = 15
                Width = 61
                Height = 24
                Hint = '????'
                Increment = 10
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = SpinEditWarrorAttackTimeChange
              end
              object SpinEditWizardAttackTime: TSpinEdit
                Left = 110
                Top = 45
                Width = 61
                Height = 24
                Hint = '????'
                Increment = 10
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = SpinEditWizardAttackTimeChange
              end
              object SpinEditTaoistAttackTime: TSpinEdit
                Left = 110
                Top = 75
                Width = 61
                Height = 24
                Hint = '????'
                Increment = 10
                MaxValue = 10000
                MinValue = 0
                TabOrder = 2
                Value = 0
                OnChange = SpinEditTaoistAttackTimeChange
              end
            end
            object GroupBox70: TGroupBox
              Left = 10
              Top = 140
              Width = 171
              Height = 121
              Caption = '????'
              TabOrder = 3
              object Label141: TLabel
                Left = 10
                Top = 85
                Width = 31
                Height = 15
                Caption = '????:'
              end
              object Label142: TLabel
                Left = 10
                Top = 55
                Width = 31
                Height = 15
                Caption = '????:'
              end
              object Label169: TLabel
                Left = 10
                Top = 25
                Width = 31
                Height = 15
                Caption = '????:'
              end
              object EditWarrorWalkTime: TSpinEdit
                Left = 93
                Top = 20
                Width = 68
                Height = 24
                MaxValue = 10000
                MinValue = 10
                TabOrder = 0
                Value = 10
                OnChange = EditWarrorWalkTimeChange
              end
              object EditWizardWalkTime: TSpinEdit
                Left = 93
                Top = 50
                Width = 68
                Height = 24
                MaxValue = 10000
                MinValue = 10
                TabOrder = 1
                Value = 10
                OnChange = EditWizardWalkTimeChange
              end
              object EditTaoistWalkTime: TSpinEdit
                Left = 93
                Top = 80
                Width = 68
                Height = 24
                MaxValue = 10000
                MinValue = 10
                TabOrder = 2
                Value = 10
                OnChange = EditTaoistWalkTimeChange
              end
            end
          end
        end
        object TabSheet52: TTabSheet
          Caption = '???'
          ImageIndex = 40
          object GroupBox60: TGroupBox
            Left = 10
            Top = 10
            Width = 531
            Height = 121
            Caption = '??????????'
            TabOrder = 0
            object Label128: TLabel
              Left = 20
              Top = 30
              Width = 17
              Height = 15
              Caption = '??:'
            end
            object Label129: TLabel
              Left = 20
              Top = 60
              Width = 17
              Height = 15
              Caption = '??:'
            end
            object Label130: TLabel
              Left = 20
              Top = 90
              Width = 17
              Height = 15
              Caption = '??:'
            end
            object EditBagItems1: TEdit
              Left = 70
              Top = 25
              Width = 451
              Height = 23
              TabOrder = 0
              OnChange = EditBagItems1Change
            end
            object EditBagItems2: TEdit
              Left = 70
              Top = 55
              Width = 451
              Height = 23
              TabOrder = 1
              OnChange = EditBagItems2Change
            end
            object EditBagItems3: TEdit
              Left = 70
              Top = 85
              Width = 451
              Height = 23
              TabOrder = 2
              OnChange = EditBagItems3Change
            end
          end
        end
        object TabSheet53: TTabSheet
          Caption = '???'
          ImageIndex = 41
          object GroupBox57: TGroupBox
            Left = 250
            Top = 10
            Width = 231
            Height = 71
            Caption = '??PK'
            TabOrder = 0
            object CheckBoxDedingAllowPK: TCheckBox
              Left = 20
              Top = 30
              Width = 121
              Height = 21
              Caption = '??PK'
              TabOrder = 0
              OnClick = CheckBoxDedingAllowPKClick
            end
          end
          object GroupBox56: TGroupBox
            Left = 10
            Top = 10
            Width = 231
            Height = 71
            Caption = '??????'
            TabOrder = 1
            object Label119: TLabel
              Left = 20
              Top = 30
              Width = 17
              Height = 15
              Caption = '??:'
            end
            object Label120: TLabel
              Left = 150
              Top = 30
              Width = 7
              Height = 15
              Caption = '?'
            end
            object SpinEditSkill39Sec: TSpinEdit
              Left = 70
              Top = 25
              Width = 71
              Height = 24
              MaxValue = 100
              MinValue = 0
              TabOrder = 0
              Value = 10
              OnChange = SpinEditSkill39SecChange
            end
          end
          object GroupBox52: TGroupBox
            Left = 10
            Top = 89
            Width = 231
            Height = 92
            Caption = '????'
            TabOrder = 2
            object Label135: TLabel
              Left = 10
              Top = 55
              Width = 31
              Height = 15
              Caption = '????:'
            end
            object SpinEditDidingPowerRate: TSpinEdit
              Left = 120
              Top = 50
              Width = 101
              Height = 24
              Hint = '????????????100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = SpinEditDidingPowerRateChange
            end
          end
        end
        object TabSheet54: TTabSheet
          Caption = '???'
          ImageIndex = 42
          object GroupBox64: TGroupBox
            Left = 10
            Top = 10
            Width = 231
            Height = 71
            Caption = '??????'
            TabOrder = 0
            object Label134: TLabel
              Left = 20
              Top = 30
              Width = 17
              Height = 15
              Caption = '??:'
            end
            object Label136: TLabel
              Left = 150
              Top = 30
              Width = 7
              Height = 15
              Caption = '?'
            end
            object EditSkill43DelayTime: TSpinEdit
              Left = 70
              Top = 25
              Width = 71
              Height = 24
              MaxValue = 100
              MinValue = 0
              TabOrder = 0
              Value = 10
              OnChange = EditSkill43DelayTimeChange
            end
          end
          object GroupBox65: TGroupBox
            Left = 10
            Top = 89
            Width = 231
            Height = 92
            Caption = '????'
            TabOrder = 1
            object Label137: TLabel
              Left = 10
              Top = 55
              Width = 31
              Height = 15
              Caption = '????:'
            end
            object EditSkill43PowerRate: TSpinEdit
              Left = 120
              Top = 50
              Width = 101
              Height = 24
              Hint = '????????????100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditSkill43PowerRateChange
            end
          end
        end
        object TabSheet55: TTabSheet
          Caption = '???'
          ImageIndex = 43
          object GroupBox66: TGroupBox
            Left = 10
            Top = 10
            Width = 231
            Height = 71
            Caption = '??????'
            TabOrder = 0
            object Label138: TLabel
              Left = 20
              Top = 30
              Width = 17
              Height = 15
              Caption = '??:'
            end
            object Label139: TLabel
              Left = 150
              Top = 30
              Width = 7
              Height = 15
              Caption = '?'
            end
            object EditSkill58DelayTime: TSpinEdit
              Left = 70
              Top = 25
              Width = 71
              Height = 24
              MaxValue = 100
              MinValue = 0
              TabOrder = 0
              Value = 10
              OnChange = EditSkill58DelayTimeChange
            end
          end
          object GroupBox67: TGroupBox
            Left = 10
            Top = 89
            Width = 231
            Height = 92
            Caption = '????'
            TabOrder = 1
            object Label140: TLabel
              Left = 10
              Top = 55
              Width = 31
              Height = 15
              Caption = '????:'
            end
            object EditSkill58PowerRate: TSpinEdit
              Left = 120
              Top = 50
              Width = 101
              Height = 24
              Hint = '????????????100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditSkill58PowerRateChange
            end
          end
        end
        object TabSheet56: TTabSheet
          Caption = '????'
          ImageIndex = 44
          object GroupBox68: TGroupBox
            Left = 6
            Top = 3
            Width = 165
            Height = 168
            Caption = '????'
            TabOrder = 0
            object RadioButtonDogz: TRadioButton
              Left = 10
              Top = 30
              Width = 131
              Height = 21
              Caption = '???????'
              TabOrder = 0
              OnClick = RadioButtonDogzClick
            end
            object RadioButtonMoon: TRadioButton
              Left = 10
              Top = 60
              Width = 131
              Height = 21
              Caption = '???????'
              Checked = True
              TabOrder = 1
              TabStop = True
              OnClick = RadioButtonDogzClick
            end
            object CheckBoxRecallAll: TCheckBox
              Left = 10
              Top = 90
              Width = 131
              Height = 21
              Caption = '???????'
              Checked = True
              State = cbChecked
              TabOrder = 2
              OnClick = CheckBoxRecallAllClick
            end
          end
          object GroupBox94: TGroupBox
            Left = 180
            Top = 3
            Width = 211
            Height = 72
            Caption = '????'
            TabOrder = 1
            object Label163: TLabel
              Left = 10
              Top = 35
              Width = 31
              Height = 15
              Caption = '????:'
            end
            object EditMoonLowPowerRate: TSpinEdit
              Left = 90
              Top = 30
              Width = 101
              Height = 24
              Hint = '????????????100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditMoonLowPowerRateChange
            end
          end
          object GroupBox95: TGroupBox
            Left = 180
            Top = 89
            Width = 211
            Height = 82
            Caption = '????'
            TabOrder = 2
            object Label164: TLabel
              Left = 10
              Top = 35
              Width = 31
              Height = 15
              Caption = '????:'
            end
            object EditMoonHighPowerRate: TSpinEdit
              Left = 90
              Top = 30
              Width = 101
              Height = 24
              Hint = '????????????100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditMoonHighPowerRateChange
            end
          end
        end
        object TabSheet58: TTabSheet
          Caption = '????'
          ImageIndex = 45
          object GroupBox74: TGroupBox
            Left = 10
            Top = 10
            Width = 231
            Height = 71
            Caption = '??????'
            TabOrder = 0
            object Label143: TLabel
              Left = 20
              Top = 30
              Width = 17
              Height = 15
              Caption = '??:'
            end
            object Label144: TLabel
              Left = 150
              Top = 30
              Width = 7
              Height = 15
              Caption = '?'
            end
            object EditSkill50DelayTime: TSpinEdit
              Left = 70
              Top = 25
              Width = 71
              Height = 24
              MaxValue = 100
              MinValue = 0
              TabOrder = 0
              Value = 3
              OnChange = EditSkill50DelayTimeChange
            end
          end
        end
        object TabSheet61: TTabSheet
          Caption = '????'
          ImageIndex = 46
          object GroupBox79: TGroupBox
            Left = 10
            Top = 10
            Width = 161
            Height = 91
            Caption = '????'
            TabOrder = 0
            object Label145: TLabel
              Left = 10
              Top = 30
              Width = 31
              Height = 15
              Caption = '????:'
            end
            object Label146: TLabel
              Left = 10
              Top = 60
              Width = 31
              Height = 15
              Caption = '????:'
            end
            object EditNewShieldUseRate: TSpinEdit
              Left = 90
              Top = 25
              Width = 61
              Height = 24
              Hint = '????????'
              MaxValue = 100
              MinValue = 0
              TabOrder = 0
              Value = 3
              OnChange = EditNewShieldUseRateChange
            end
            object EditNewShieldDamageRate: TSpinEdit
              Left = 90
              Top = 55
              Width = 61
              Height = 24
              Hint = '????????'
              MaxValue = 100
              MinValue = 0
              TabOrder = 1
              Value = 10
              OnChange = EditNewShieldDamageRateChange
            end
          end
          object GroupBox80: TGroupBox
            Left = 180
            Top = 10
            Width = 161
            Height = 91
            Caption = '?????????'
            TabOrder = 1
            object Label147: TLabel
              Left = 10
              Top = 30
              Width = 31
              Height = 15
              Hint = '??????(?)'
              Caption = '????:'
            end
            object EditNewShieldWaitTime: TSpinEdit
              Left = 90
              Top = 25
              Width = 61
              Height = 24
              MaxValue = 10000
              MinValue = 0
              TabOrder = 0
              Value = 30
              OnChange = EditNewShieldWaitTimeChange
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = '?????'
          ImageIndex = 24
          object GroupBox81: TGroupBox
            Left = 10
            Top = 10
            Width = 241
            Height = 71
            Caption = '????'
            TabOrder = 0
            object Label148: TLabel
              Left = 20
              Top = 30
              Width = 17
              Height = 15
              Caption = '??:'
            end
            object Label149: TLabel
              Left = 150
              Top = 30
              Width = 7
              Height = 15
              Caption = '?'
            end
            object EditSpaceSkillDelayTime: TSpinEdit
              Left = 70
              Top = 25
              Width = 71
              Height = 24
              MaxValue = 1000000
              MinValue = 0
              TabOrder = 0
              Value = 3
              OnChange = EditSpaceSkillDelayTimeChange
            end
          end
          object GroupBox82: TGroupBox
            Left = 10
            Top = 90
            Width = 241
            Height = 101
            Caption = '????'
            TabOrder = 1
            object CheckBoxNoAllowWarRangeUseSpaceSkill: TCheckBox
              Left = 20
              Top = 30
              Width = 151
              Height = 21
              Caption = '????????'
              TabOrder = 0
              OnClick = CheckBoxNoAllowWarRangeUseSpaceSkillClick
            end
            object CheckBoxAllowSpaceOutAttack: TCheckBox
              Left = 20
              Top = 60
              Width = 211
              Height = 21
              Caption = '????????????'
              TabOrder = 1
              OnClick = CheckBoxAllowSpaceOutAttackClick
            end
          end
          object GroupBox84: TGroupBox
            Left = 270
            Top = 10
            Width = 241
            Height = 71
            Caption = '????'
            TabOrder = 2
            object Label151: TLabel
              Left = 20
              Top = 30
              Width = 17
              Height = 15
              Caption = '??:'
            end
            object Label152: TLabel
              Left = 150
              Top = 30
              Width = 7
              Height = 15
              Caption = '?'
            end
            object EditSpaceSkillKeepTime: TSpinEdit
              Left = 70
              Top = 25
              Width = 71
              Height = 24
              MaxValue = 10000
              MinValue = 0
              TabOrder = 0
              Value = 60
              OnChange = EditSpaceSkillKeepTimeChange
            end
          end
        end
        object TabSheet5: TTabSheet
          Caption = '?????'
          ImageIndex = 25
          object GroupBox83: TGroupBox
            Left = 10
            Top = 9
            Width = 201
            Height = 92
            Caption = '????'
            TabOrder = 0
            object Label150: TLabel
              Left = 10
              Top = 25
              Width = 31
              Height = 15
              Caption = '????:'
            end
            object EditGroupFireCharmPowerRate: TSpinEdit
              Left = 90
              Top = 20
              Width = 101
              Height = 24
              Hint = '???????????100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditGroupFireCharmPowerRateChange
            end
          end
        end
        object TabSheet7: TTabSheet
          Caption = '????'
          ImageIndex = 26
          object GroupBox85: TGroupBox
            Left = 10
            Top = 10
            Width = 171
            Height = 71
            Caption = '????'
            TabOrder = 0
            object Label153: TLabel
              Left = 10
              Top = 30
              Width = 17
              Height = 15
              Caption = '??:'
            end
            object Label154: TLabel
              Left = 140
              Top = 30
              Width = 7
              Height = 15
              Caption = '?'
            end
            object EditMagicMovePositionTime: TSpinEdit
              Left = 60
              Top = 25
              Width = 71
              Height = 24
              MaxValue = 1000000
              MinValue = 0
              TabOrder = 0
              Value = 3
              OnChange = EditMagicMovePositionTimeChange
            end
          end
          object GroupBox86: TGroupBox
            Left = 10
            Top = 90
            Width = 171
            Height = 71
            Caption = '????'
            TabOrder = 1
            object Label155: TLabel
              Left = 10
              Top = 30
              Width = 31
              Height = 15
              Caption = '????:'
            end
            object EditMagicMovePositionRate: TSpinEdit
              Left = 90
              Top = 25
              Width = 61
              Height = 24
              Hint = '????????'
              MaxValue = 100
              MinValue = 0
              TabOrder = 0
              Value = 3
              OnChange = EditMagicMovePositionRateChange
            end
          end
        end
        object TabSheet8: TTabSheet
          Caption = '????'
          ImageIndex = 27
          object GroupBox88: TGroupBox
            Left = 10
            Top = 10
            Width = 171
            Height = 71
            Caption = '????'
            TabOrder = 0
            object Label156: TLabel
              Left = 10
              Top = 30
              Width = 17
              Height = 15
              Caption = '??:'
            end
            object Label157: TLabel
              Left = 140
              Top = 30
              Width = 7
              Height = 15
              Caption = '?'
            end
            object EditSkillZRJFDelayTime: TSpinEdit
              Left = 60
              Top = 25
              Width = 71
              Height = 24
              MaxValue = 1000000
              MinValue = 0
              TabOrder = 0
              Value = 10
              OnChange = EditSkillZRJFDelayTimeChange
            end
          end
          object GroupBox89: TGroupBox
            Left = 10
            Top = 89
            Width = 171
            Height = 62
            Caption = '????'
            TabOrder = 1
            object Label158: TLabel
              Left = 10
              Top = 25
              Width = 31
              Height = 15
              Caption = '????:'
            end
            object EditSkill77PowerRate: TSpinEdit
              Left = 80
              Top = 20
              Width = 81
              Height = 24
              Hint = '???????????100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditSkill77PowerRateChange
            end
          end
        end
        object TabSheet9: TTabSheet
          Caption = '????'
          ImageIndex = 28
          object GroupBox90: TGroupBox
            Left = 10
            Top = 9
            Width = 171
            Height = 62
            Caption = '????'
            TabOrder = 0
            object Label159: TLabel
              Left = 10
              Top = 25
              Width = 31
              Height = 15
              Caption = '????:'
            end
            object EditSkill75PowerRate: TSpinEdit
              Left = 80
              Top = 20
              Width = 81
              Height = 24
              Hint = '???????????100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditSkill75PowerRateChange
            end
          end
        end
        object TabSheet10: TTabSheet
          Caption = '???'
          ImageIndex = 29
          object GroupBox91: TGroupBox
            Left = 10
            Top = 9
            Width = 171
            Height = 62
            Caption = '????'
            TabOrder = 0
            object Label160: TLabel
              Left = 10
              Top = 25
              Width = 31
              Height = 15
              Caption = '????:'
            end
            object EditSkill76PowerRate: TSpinEdit
              Left = 80
              Top = 20
              Width = 81
              Height = 21
              Hint = '???????????100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditSkill76PowerRateChange
            end
          end
        end
        object TabSheet13: TTabSheet
          Caption = '????'
          ImageIndex = 30
          object ListBoxSerieMagic: TListBox
            Left = 10
            Top = 10
            Width = 151
            Height = 211
            Color = clBtnFace
            Ctl3D = False
            Font.Charset = GB2312_CHARSET
            Font.Color = clRed
            Font.Height = -15
            Font.Name = '??'
            Font.Style = []
            ItemHeight = 17
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnClick = ListBoxSerieMagicClick
          end
          object GroupBox71: TGroupBox
            Left = 10
            Top = 230
            Width = 161
            Height = 51
            Caption = '????'
            TabOrder = 1
            object Label170: TLabel
              Left = 10
              Top = 20
              Width = 31
              Height = 15
              Caption = '????:'
            end
            object Label171: TLabel
              Left = 140
              Top = 20
              Width = 7
              Height = 15
              Caption = '?'
            end
            object EditSerieMagicTime: TSpinEdit
              Left = 80
              Top = 15
              Width = 51
              Height = 24
              MaxValue = 0
              MinValue = 0
              TabOrder = 0
              Value = 0
              OnChange = EditSerieMagicTimeChange
            end
          end
          object GroupBoxSerie: TGroupBox
            Left = 180
            Top = 0
            Width = 361
            Height = 231
            TabOrder = 2
            object GroupBoxSerieMagicAttackRange: TGroupBox
              Left = 10
              Top = 160
              Width = 151
              Height = 61
              Caption = '????'
              TabOrder = 0
              object Label172: TLabel
                Left = 10
                Top = 25
                Width = 17
                Height = 15
                Caption = '??:'
              end
              object EditSerieMagicAttackRange: TSpinEdit
                Left = 55
                Top = 19
                Width = 66
                Height = 24
                Hint = '?????????'
                EditorEnabled = False
                MaxValue = 12
                MinValue = 1
                TabOrder = 0
                Value = 1
                OnChange = EditSerieMagicAttackRangeChange
              end
            end
            object GroupBoxSerieMagicPowerRate: TGroupBox
              Left = 10
              Top = 19
              Width = 151
              Height = 62
              Caption = '????'
              TabOrder = 1
              object Label173: TLabel
                Left = 10
                Top = 25
                Width = 31
                Height = 15
                Caption = '????:'
              end
              object EditSerieMagicPowerRate: TSpinEdit
                Left = 80
                Top = 20
                Width = 61
                Height = 24
                Hint = '???????????100'
                MaxValue = 10000
                MinValue = 1
                TabOrder = 0
                Value = 100
                OnChange = EditSerieMagicPowerRateChange
              end
            end
            object GroupBoxSerieMagicBlasthitRate: TGroupBox
              Left = 170
              Top = 19
              Width = 181
              Height = 132
              Caption = '???'
              TabOrder = 2
              object Label174: TLabel
                Left = 10
                Top = 25
                Width = 49
                Height = 15
                Caption = 'Lv.1 ???:'
              end
              object Label175: TLabel
                Left = 165
                Top = 25
                Width = 11
                Height = 15
                Caption = '%'
              end
              object Label176: TLabel
                Left = 10
                Top = 55
                Width = 49
                Height = 15
                Caption = 'Lv.2 ???:'
              end
              object Label177: TLabel
                Left = 164
                Top = 55
                Width = 11
                Height = 15
                Caption = '%'
              end
              object Label178: TLabel
                Left = 10
                Top = 85
                Width = 49
                Height = 15
                Caption = 'Lv.3 ???:'
              end
              object Label179: TLabel
                Left = 164
                Top = 85
                Width = 11
                Height = 15
                Caption = '%'
              end
              object EditSerieMagicBlasthitRate1: TSpinEdit
                Left = 100
                Top = 20
                Width = 61
                Height = 24
                MaxValue = 100
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditSerieMagicBlasthitRate1Change
              end
              object EditSerieMagicBlasthitRate2: TSpinEdit
                Left = 100
                Top = 50
                Width = 61
                Height = 24
                MaxValue = 100
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditSerieMagicBlasthitRate2Change
              end
              object EditSerieMagicBlasthitRate3: TSpinEdit
                Left = 100
                Top = 80
                Width = 61
                Height = 24
                MaxValue = 100
                MinValue = 0
                TabOrder = 2
                Value = 0
                OnChange = EditSerieMagicBlasthitRate3Change
              end
            end
            object GroupBoxSerieMagicBlasthitPowerRate: TGroupBox
              Left = 10
              Top = 89
              Width = 151
              Height = 62
              Caption = '??????'
              TabOrder = 3
              object Label180: TLabel
                Left = 10
                Top = 25
                Width = 31
                Height = 15
                Caption = '????:'
              end
              object EditSerieMagicBlasthitPowerRate: TSpinEdit
                Left = 80
                Top = 20
                Width = 61
                Height = 24
                Hint = '???????????100'
                MaxValue = 10000
                MinValue = 1
                TabOrder = 0
                Value = 100
                OnChange = EditSerieMagicBlasthitPowerRateChange
              end
            end
          end
        end
      end
      object ButtonSkillSave: TButton
        Left = 470
        Top = 386
        Width = 81
        Height = 25
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonSkillSaveClick
      end
    end
    object TabSheet34: TTabSheet
      Caption = 'WepUG'
      ImageIndex = 6
      object GroupBox8: TGroupBox
        Left = 10
        Top = 10
        Width = 201
        Height = 181
        Caption = 'Upgrade'
        TabOrder = 0
        object Label13: TLabel
          Left = 10
          Top = 23
          Width = 24
          Height = 15
          Caption = 'Max:'
        end
        object Label15: TLabel
          Left = 10
          Top = 53
          Width = 29
          Height = 15
          Caption = 'Cost:'
        end
        object Label16: TLabel
          Left = 10
          Top = 83
          Width = 31
          Height = 15
          Caption = 'Time:'
        end
        object Label17: TLabel
          Left = 10
          Top = 113
          Width = 30
          Height = 15
          Caption = 'Expir:'
        end
        object Label18: TLabel
          Left = 170
          Top = 81
          Width = 9
          Height = 15
          Caption = 'M'
        end
        object Label19: TLabel
          Left = 170
          Top = 111
          Width = 9
          Height = 15
          Caption = 'D'
        end
        object EditUpgradeWeaponMaxPoint: TSpinEdit
          Left = 85
          Top = 19
          Width = 76
          Height = 24
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditUpgradeWeaponMaxPointChange
        end
        object EditUpgradeWeaponPrice: TSpinEdit
          Left = 85
          Top = 49
          Width = 76
          Height = 24
          EditorEnabled = False
          MaxValue = 1000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditUpgradeWeaponPriceChange
        end
        object EditUPgradeWeaponGetBackTime: TSpinEdit
          Left = 85
          Top = 79
          Width = 76
          Height = 24
          EditorEnabled = False
          MaxValue = 36000000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditUPgradeWeaponGetBackTimeChange
        end
        object EditClearExpireUpgradeWeaponDays: TSpinEdit
          Left = 85
          Top = 109
          Width = 76
          Height = 24
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditClearExpireUpgradeWeaponDaysChange
        end
        object CheckBoxDeleteUpgradeFailWeapon: TCheckBox
          Left = 10
          Top = 143
          Width = 131
          Height = 21
          Caption = '???????'
          TabOrder = 4
          OnClick = CheckBoxDeleteUpgradeFailWeaponClick
        end
      end
      object GroupBox18: TGroupBox
        Left = 220
        Top = 10
        Width = 331
        Height = 111
        Caption = 'DC Rate'
        TabOrder = 1
        object Label20: TLabel
          Left = 10
          Top = 23
          Width = 31
          Height = 15
          Caption = 'DC 1:'
        end
        object Label21: TLabel
          Left = 10
          Top = 53
          Width = 31
          Height = 15
          Caption = 'DC 2:'
        end
        object Label22: TLabel
          Left = 10
          Top = 83
          Width = 31
          Height = 15
          Caption = 'DC 3:'
        end
        object ScrollBarUpgradeWeaponDCRate: TScrollBar
          Left = 80
          Top = 20
          Width = 181
          Height = 21
          Hint = '???????????,????????'
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponDCRateChange
        end
        object EditUpgradeWeaponDCRate: TEdit
          Left = 270
          Top = 20
          Width = 51
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponDCTwoPointRate: TScrollBar
          Left = 80
          Top = 50
          Width = 181
          Height = 21
          Hint = '????????,????????'
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponDCTwoPointRateChange
        end
        object EditUpgradeWeaponDCTwoPointRate: TEdit
          Left = 270
          Top = 50
          Width = 51
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponDCThreePointRate: TScrollBar
          Left = 80
          Top = 80
          Width = 181
          Height = 21
          Hint = '????????,????????'
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponDCThreePointRateChange
        end
        object EditUpgradeWeaponDCThreePointRate: TEdit
          Left = 270
          Top = 80
          Width = 51
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object GroupBox19: TGroupBox
        Left = 220
        Top = 130
        Width = 331
        Height = 121
        Caption = 'SC Rate'
        TabOrder = 2
        object Label23: TLabel
          Left = 10
          Top = 23
          Width = 30
          Height = 15
          Caption = 'SC 1:'
        end
        object Label24: TLabel
          Left = 10
          Top = 53
          Width = 30
          Height = 15
          Caption = 'SC 2:'
        end
        object Label25: TLabel
          Left = 10
          Top = 83
          Width = 30
          Height = 15
          Caption = 'SC 3:'
        end
        object ScrollBarUpgradeWeaponSCRate: TScrollBar
          Left = 80
          Top = 20
          Width = 181
          Height = 21
          Hint = '??????????,????????'
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponSCRateChange
        end
        object EditUpgradeWeaponSCRate: TEdit
          Left = 270
          Top = 20
          Width = 51
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponSCTwoPointRate: TScrollBar
          Left = 80
          Top = 50
          Width = 181
          Height = 21
          Hint = '????????,????????'
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponSCTwoPointRateChange
        end
        object EditUpgradeWeaponSCTwoPointRate: TEdit
          Left = 270
          Top = 50
          Width = 51
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponSCThreePointRate: TScrollBar
          Left = 80
          Top = 80
          Width = 181
          Height = 21
          Hint = '????????,????????'
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponSCThreePointRateChange
        end
        object EditUpgradeWeaponSCThreePointRate: TEdit
          Left = 270
          Top = 80
          Width = 51
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object GroupBox20: TGroupBox
        Left = 220
        Top = 260
        Width = 331
        Height = 111
        Caption = 'MC Rate'
        TabOrder = 3
        object Label26: TLabel
          Left = 10
          Top = 23
          Width = 31
          Height = 15
          Caption = 'MC 1:'
        end
        object Label27: TLabel
          Left = 10
          Top = 53
          Width = 31
          Height = 15
          Caption = 'MC 2:'
        end
        object Label28: TLabel
          Left = 10
          Top = 83
          Width = 31
          Height = 15
          Caption = 'MC 3:'
        end
        object ScrollBarUpgradeWeaponMCRate: TScrollBar
          Left = 80
          Top = 20
          Width = 181
          Height = 21
          Hint = '??????????,????????'
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponMCRateChange
        end
        object EditUpgradeWeaponMCRate: TEdit
          Left = 270
          Top = 20
          Width = 51
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponMCTwoPointRate: TScrollBar
          Left = 80
          Top = 50
          Width = 181
          Height = 21
          Hint = '????????,????????'
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponMCTwoPointRateChange
        end
        object EditUpgradeWeaponMCTwoPointRate: TEdit
          Left = 270
          Top = 50
          Width = 51
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponMCThreePointRate: TScrollBar
          Left = 80
          Top = 80
          Width = 181
          Height = 21
          Hint = '????????,????????'
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponMCThreePointRateChange
        end
        object EditUpgradeWeaponMCThreePointRate: TEdit
          Left = 270
          Top = 80
          Width = 51
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object ButtonUpgradeWeaponSave: TButton
        Left = 10
        Top = 346
        Width = 81
        Height = 25
        Caption = '&Save'
        TabOrder = 4
        OnClick = ButtonUpgradeWeaponSaveClick
      end
      object ButtonUpgradeWeaponDefaulf: TButton
        Left = 100
        Top = 346
        Width = 81
        Height = 25
        Caption = '&Defults'
        TabOrder = 5
        OnClick = ButtonUpgradeWeaponDefaulfClick
      end
    end
    object TabSheet35: TTabSheet
      Caption = 'Mine'
      ImageIndex = 7
      object GroupBox24: TGroupBox
        Left = 10
        Top = 10
        Width = 341
        Height = 75
        Caption = 'Rates'
        TabOrder = 0
        object Label32: TLabel
          Left = 10
          Top = 23
          Width = 18
          Height = 15
          Caption = 'Hit:'
        end
        object Label33: TLabel
          Left = 10
          Top = 45
          Width = 29
          Height = 15
          Caption = 'Mine:'
        end
        object ScrollBarMakeMineHitRate: TScrollBar
          Left = 90
          Top = 20
          Width = 161
          Height = 19
          Hint = '????????????'
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarMakeMineHitRateChange
        end
        object EditMakeMineHitRate: TEdit
          Left = 260
          Top = 20
          Width = 71
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarMakeMineRate: TScrollBar
          Left = 90
          Top = 45
          Width = 161
          Height = 19
          Hint = '????????????'
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarMakeMineRateChange
        end
        object EditMakeMineRate: TEdit
          Left = 260
          Top = 45
          Width = 71
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
      end
      object GroupBox25: TGroupBox
        Left = 10
        Top = 90
        Width = 341
        Height = 271
        Caption = 'Stones Rate'
        TabOrder = 1
        object Label34: TLabel
          Left = 10
          Top = 23
          Width = 44
          Height = 15
          Caption = 'Copper:'
        end
        object Label35: TLabel
          Left = 10
          Top = 48
          Width = 29
          Height = 15
          Caption = 'Gold:'
        end
        object Label36: TLabel
          Left = 10
          Top = 70
          Width = 33
          Height = 15
          Caption = 'Silver:'
        end
        object Label37: TLabel
          Left = 10
          Top = 95
          Width = 24
          Height = 15
          Caption = 'Iron:'
        end
        object Label38: TLabel
          Left = 10
          Top = 120
          Width = 57
          Height = 15
          Caption = 'Black Iron:'
        end
        object ScrollBarStoneTypeRate: TScrollBar
          Left = 90
          Top = 20
          Width = 161
          Height = 19
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarStoneTypeRateChange
        end
        object EditStoneTypeRate: TEdit
          Left = 260
          Top = 20
          Width = 71
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarGoldStoneMax: TScrollBar
          Left = 90
          Top = 45
          Width = 161
          Height = 19
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarGoldStoneMaxChange
        end
        object EditGoldStoneMax: TEdit
          Left = 260
          Top = 45
          Width = 71
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarSilverStoneMax: TScrollBar
          Left = 90
          Top = 70
          Width = 161
          Height = 19
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarSilverStoneMaxChange
        end
        object EditSilverStoneMax: TEdit
          Left = 260
          Top = 70
          Width = 71
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarSteelStoneMax: TScrollBar
          Left = 90
          Top = 95
          Width = 161
          Height = 19
          Max = 500
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarSteelStoneMaxChange
        end
        object EditSteelStoneMax: TEdit
          Left = 260
          Top = 95
          Width = 71
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditBlackStoneMax: TEdit
          Left = 260
          Top = 120
          Width = 71
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object ScrollBarBlackStoneMax: TScrollBar
          Left = 90
          Top = 120
          Width = 161
          Height = 19
          Max = 500
          PageSize = 0
          TabOrder = 9
          OnChange = ScrollBarBlackStoneMaxChange
        end
      end
      object ButtonMakeMineSave: TButton
        Left = 470
        Top = 346
        Width = 81
        Height = 25
        Caption = '&Save'
        TabOrder = 2
        OnClick = ButtonMakeMineSaveClick
      end
      object GroupBox26: TGroupBox
        Left = 360
        Top = 10
        Width = 191
        Height = 151
        Caption = 'Dura'
        TabOrder = 3
        object Label39: TLabel
          Left = 10
          Top = 23
          Width = 54
          Height = 15
          Caption = 'Minimum:'
        end
        object Label40: TLabel
          Left = 10
          Top = 53
          Width = 47
          Height = 15
          Caption = 'General:'
        end
        object Label41: TLabel
          Left = 10
          Top = 83
          Width = 38
          Height = 15
          Caption = 'Added:'
        end
        object Label42: TLabel
          Left = 10
          Top = 113
          Width = 62
          Height = 15
          Caption = 'Max Added:'
        end
        object EditStoneMinDura: TSpinEdit
          Left = 115
          Top = 19
          Width = 56
          Height = 24
          Hint = '???????????'
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditStoneMinDuraChange
        end
        object EditStoneGeneralDuraRate: TSpinEdit
          Left = 115
          Top = 49
          Width = 56
          Height = 24
          Hint = '?????????????'
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditStoneGeneralDuraRateChange
        end
        object EditStoneAddDuraRate: TSpinEdit
          Left = 115
          Top = 79
          Width = 56
          Height = 24
          Hint = '???????????,????????20???????'
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditStoneAddDuraRateChange
        end
        object EditStoneAddDuraMax: TSpinEdit
          Left = 115
          Top = 109
          Width = 56
          Height = 24
          Hint = '????????????????'
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditStoneAddDuraMaxChange
        end
      end
      object ButtonMakeMineDefault: TButton
        Left = 370
        Top = 346
        Width = 81
        Height = 25
        Caption = '&Defults'
        TabOrder = 4
        OnClick = ButtonMakeMineDefaultClick
      end
    end
    object TabSheet42: TTabSheet
      Caption = 'WLuck'
      ImageIndex = 12
      object GroupBox44: TGroupBox
        Left = 10
        Top = 10
        Width = 341
        Height = 271
        Caption = 'Weapon Luck'
        TabOrder = 0
        object Label105: TLabel
          Left = 10
          Top = 23
          Width = 41
          Height = 15
          Caption = 'Unluck:'
        end
        object Label106: TLabel
          Left = 10
          Top = 48
          Width = 39
          Height = 15
          Caption = 'Luck 1:'
        end
        object Label107: TLabel
          Left = 10
          Top = 70
          Width = 39
          Height = 15
          Caption = 'Luck 2:'
        end
        object Label108: TLabel
          Left = 10
          Top = 95
          Width = 68
          Height = 15
          Caption = 'Luck 2 Rate:'
        end
        object Label109: TLabel
          Left = 10
          Top = 120
          Width = 39
          Height = 15
          Caption = 'Luck 3:'
        end
        object Label110: TLabel
          Left = 10
          Top = 145
          Width = 68
          Height = 15
          Caption = 'Luck 3 Rate:'
        end
        object ScrollBarWeaponMakeUnLuckRate: TScrollBar
          Left = 90
          Top = 20
          Width = 161
          Height = 19
          Hint = '?????????,?????????'
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarWeaponMakeUnLuckRateChange
        end
        object EditWeaponMakeUnLuckRate: TEdit
          Left = 260
          Top = 20
          Width = 71
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarWeaponMakeLuckPoint1: TScrollBar
          Left = 90
          Top = 45
          Width = 161
          Height = 19
          Hint = '???????????????????100% ???'
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarWeaponMakeLuckPoint1Change
        end
        object EditWeaponMakeLuckPoint1: TEdit
          Left = 260
          Top = 45
          Width = 71
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarWeaponMakeLuckPoint2: TScrollBar
          Left = 90
          Top = 70
          Width = 161
          Height = 19
          Hint = '????????????????????????????????'
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarWeaponMakeLuckPoint2Change
        end
        object EditWeaponMakeLuckPoint2: TEdit
          Left = 260
          Top = 70
          Width = 71
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarWeaponMakeLuckPoint2Rate: TScrollBar
          Left = 90
          Top = 95
          Width = 161
          Height = 19
          Hint = '????,?????????'
          Max = 500
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarWeaponMakeLuckPoint2RateChange
        end
        object EditWeaponMakeLuckPoint2Rate: TEdit
          Left = 260
          Top = 95
          Width = 71
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditWeaponMakeLuckPoint3: TEdit
          Left = 260
          Top = 120
          Width = 71
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object ScrollBarWeaponMakeLuckPoint3: TScrollBar
          Left = 90
          Top = 120
          Width = 161
          Height = 19
          Hint = '????????????????????????????????'
          Max = 500
          PageSize = 0
          TabOrder = 9
          OnChange = ScrollBarWeaponMakeLuckPoint3Change
        end
        object ScrollBarWeaponMakeLuckPoint3Rate: TScrollBar
          Left = 90
          Top = 145
          Width = 161
          Height = 19
          Hint = '????,?????????'
          Max = 500
          PageSize = 0
          TabOrder = 10
          OnChange = ScrollBarWeaponMakeLuckPoint3RateChange
        end
        object EditWeaponMakeLuckPoint3Rate: TEdit
          Left = 260
          Top = 145
          Width = 71
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 11
        end
      end
      object ButtonWeaponMakeLuckDefault: TButton
        Left = 370
        Top = 346
        Width = 81
        Height = 25
        Caption = '&Defults'
        TabOrder = 1
        OnClick = ButtonWeaponMakeLuckDefaultClick
      end
      object ButtonWeaponMakeLuckSave: TButton
        Left = 470
        Top = 346
        Width = 81
        Height = 25
        Caption = '&Save'
        TabOrder = 2
        OnClick = ButtonWeaponMakeLuckSaveClick
      end
    end
    object TabSheet37: TTabSheet
      Caption = 'Lotto'
      ImageIndex = 8
      object GroupBox27: TGroupBox
        Left = 10
        Top = 10
        Width = 341
        Height = 211
        Caption = 'Lottory Chances'
        TabOrder = 0
        object Label43: TLabel
          Left = 10
          Top = 53
          Width = 20
          Height = 15
          Caption = '1st:'
        end
        object Label44: TLabel
          Left = 10
          Top = 78
          Width = 24
          Height = 15
          Caption = '2nd:'
        end
        object Label45: TLabel
          Left = 10
          Top = 100
          Width = 21
          Height = 15
          Caption = '3rd:'
        end
        object Label46: TLabel
          Left = 10
          Top = 125
          Width = 20
          Height = 15
          Caption = '4th:'
        end
        object Label47: TLabel
          Left = 10
          Top = 150
          Width = 20
          Height = 15
          Caption = '5th:'
        end
        object Label48: TLabel
          Left = 10
          Top = 175
          Width = 20
          Height = 15
          Caption = '6th:'
        end
        object Label49: TLabel
          Left = 10
          Top = 23
          Width = 53
          Height = 15
          Caption = 'Win Rate:'
        end
        object ScrollBarWinLottery1Max: TScrollBar
          Left = 70
          Top = 50
          Width = 161
          Height = 19
          Max = 1000000
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarWinLottery1MaxChange
        end
        object EditWinLottery1Max: TEdit
          Left = 240
          Top = 50
          Width = 91
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarWinLottery2Max: TScrollBar
          Left = 70
          Top = 75
          Width = 161
          Height = 19
          Max = 1000000
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarWinLottery2MaxChange
        end
        object EditWinLottery2Max: TEdit
          Left = 240
          Top = 75
          Width = 91
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarWinLottery3Max: TScrollBar
          Left = 70
          Top = 100
          Width = 161
          Height = 19
          Max = 1000000
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarWinLottery3MaxChange
        end
        object EditWinLottery3Max: TEdit
          Left = 240
          Top = 100
          Width = 91
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarWinLottery4Max: TScrollBar
          Left = 70
          Top = 125
          Width = 161
          Height = 19
          Max = 1000000
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarWinLottery4MaxChange
        end
        object EditWinLottery4Max: TEdit
          Left = 240
          Top = 125
          Width = 91
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditWinLottery5Max: TEdit
          Left = 240
          Top = 150
          Width = 91
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object ScrollBarWinLottery5Max: TScrollBar
          Left = 70
          Top = 150
          Width = 161
          Height = 19
          Max = 1000000
          PageSize = 0
          TabOrder = 9
          OnChange = ScrollBarWinLottery5MaxChange
        end
        object ScrollBarWinLottery6Max: TScrollBar
          Left = 70
          Top = 175
          Width = 161
          Height = 19
          Max = 1000000
          PageSize = 0
          TabOrder = 10
          OnChange = ScrollBarWinLottery6MaxChange
        end
        object EditWinLottery6Max: TEdit
          Left = 240
          Top = 175
          Width = 91
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 11
        end
        object EditWinLotteryRate: TEdit
          Left = 240
          Top = 20
          Width = 91
          Height = 21
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 12
        end
        object ScrollBarWinLotteryRate: TScrollBar
          Left = 70
          Top = 20
          Width = 161
          Height = 19
          Max = 100000
          PageSize = 0
          TabOrder = 13
          OnChange = ScrollBarWinLotteryRateChange
        end
      end
      object GroupBox28: TGroupBox
        Left = 360
        Top = 10
        Width = 181
        Height = 211
        Caption = 'Prize'
        TabOrder = 1
        object Label50: TLabel
          Left = 10
          Top = 23
          Width = 20
          Height = 15
          Caption = '1st:'
        end
        object Label51: TLabel
          Left = 10
          Top = 53
          Width = 24
          Height = 15
          Caption = '2nd:'
        end
        object Label52: TLabel
          Left = 10
          Top = 83
          Width = 21
          Height = 15
          Caption = '3rd:'
        end
        object Label53: TLabel
          Left = 10
          Top = 113
          Width = 20
          Height = 15
          Caption = '4th:'
        end
        object Label54: TLabel
          Left = 10
          Top = 143
          Width = 20
          Height = 15
          Caption = '5th:'
        end
        object Label55: TLabel
          Left = 10
          Top = 173
          Width = 20
          Height = 15
          Caption = '6th:'
        end
        object EditWinLottery1Gold: TSpinEdit
          Left = 70
          Top = 19
          Width = 101
          Height = 24
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 0
          Value = 100000000
          OnChange = EditWinLottery1GoldChange
        end
        object EditWinLottery2Gold: TSpinEdit
          Left = 70
          Top = 49
          Width = 101
          Height = 24
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditWinLottery2GoldChange
        end
        object EditWinLottery3Gold: TSpinEdit
          Left = 70
          Top = 79
          Width = 101
          Height = 24
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditWinLottery3GoldChange
        end
        object EditWinLottery4Gold: TSpinEdit
          Left = 70
          Top = 109
          Width = 101
          Height = 24
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditWinLottery4GoldChange
        end
        object EditWinLottery5Gold: TSpinEdit
          Left = 70
          Top = 139
          Width = 101
          Height = 24
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 4
          Value = 10
          OnChange = EditWinLottery5GoldChange
        end
        object EditWinLottery6Gold: TSpinEdit
          Left = 70
          Top = 169
          Width = 101
          Height = 24
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 5
          Value = 10
          OnChange = EditWinLottery6GoldChange
        end
      end
      object ButtonWinLotterySave: TButton
        Left = 470
        Top = 346
        Width = 81
        Height = 25
        Caption = '&Save'
        ModalResult = 1
        TabOrder = 2
        OnClick = ButtonWinLotterySaveClick
      end
      object ButtonWinLotteryDefault: TButton
        Left = 370
        Top = 346
        Width = 81
        Height = 25
        Caption = '&Defults'
        TabOrder = 3
        OnClick = ButtonWinLotteryDefaultClick
      end
    end
    object TabSheet40: TTabSheet
      Caption = 'Spirit'
      ImageIndex = 11
      object GroupBox36: TGroupBox
        Left = 10
        Top = 10
        Width = 171
        Height = 111
        Caption = 'Spirit'
        TabOrder = 0
        object Label94: TLabel
          Left = 14
          Top = 50
          Width = 31
          Height = 15
          Caption = 'Time:'
        end
        object Label96: TLabel
          Left = 14
          Top = 80
          Width = 67
          Height = 15
          Caption = 'Power Rate:'
          Enabled = False
        end
        object CheckBoxSpiritMutiny: TCheckBox
          Left = 10
          Top = 20
          Width = 141
          Height = 21
          Caption = 'Spirit Mutiny'
          TabOrder = 0
          OnClick = CheckBoxSpiritMutinyClick
        end
        object EditSpiritMutinyTime: TSpinEdit
          Left = 90
          Top = 45
          Width = 61
          Height = 24
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditSpiritMutinyTimeChange
        end
        object EditSpiritPowerRate: TSpinEdit
          Left = 90
          Top = 75
          Width = 61
          Height = 24
          EditorEnabled = False
          Enabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditSpiritPowerRateChange
        end
      end
      object ButtonSpiritMutinySave: TButton
        Left = 450
        Top = 326
        Width = 81
        Height = 32
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonSpiritMutinySaveClick
      end
    end
    object TabSheet44: TTabSheet
      Caption = 'SellOff'
      ImageIndex = 13
      object GroupBox49: TGroupBox
        Left = 10
        Top = 10
        Width = 231
        Height = 101
        Caption = 'Sell Off'
        TabOrder = 0
        object Label113: TLabel
          Left = 20
          Top = 30
          Width = 36
          Height = 15
          Caption = 'Count:'
        end
        object Label114: TLabel
          Left = 20
          Top = 60
          Width = 29
          Height = 15
          Caption = 'Rate:'
        end
        object Label115: TLabel
          Left = 180
          Top = 60
          Width = 11
          Height = 15
          Caption = '%'
        end
        object SpinEditSellOffCount: TSpinEdit
          Left = 100
          Top = 25
          Width = 71
          Height = 24
          Hint = '??????????'
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = SpinEditSellOffCountChange
        end
        object SpinEditSellOffTax: TSpinEdit
          Left = 100
          Top = 55
          Width = 71
          Height = 24
          Hint = '??????????'
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = SpinEditSellOffTaxChange
        end
      end
      object ButtonSellOffSave: TButton
        Left = 450
        Top = 326
        Width = 81
        Height = 32
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonSellOffSaveClick
      end
    end
    object TabSheet50: TTabSheet
      Caption = '????'
      ImageIndex = 14
      object GroupBox55: TGroupBox
        Left = 10
        Top = 10
        Width = 321
        Height = 101
        Caption = '????'
        TabOrder = 0
        object Label118: TLabel
          Left = 20
          Top = 60
          Width = 38
          Height = 15
          Caption = '?????:'
        end
        object CheckBoxItemName: TCheckBox
          Left = 20
          Top = 30
          Width = 191
          Height = 21
          Caption = '??????????'
          TabOrder = 0
          OnClick = CheckBoxItemNameClick
        end
        object EditItemName: TEdit
          Left = 110
          Top = 55
          Width = 201
          Height = 23
          TabOrder = 1
          Text = '???'
          OnChange = EditItemNameChange
        end
      end
      object ButtonChangeUseItemName: TButton
        Left = 450
        Top = 324
        Width = 81
        Height = 31
        Caption = '??(&S)'
        TabOrder = 1
        OnClick = ButtonChangeUseItemNameClick
      end
    end
    object TabSheet59: TTabSheet
      Caption = 'Bind'
      ImageIndex = 16
      object GroupBox75: TGroupBox
        Left = 10
        Top = 10
        Width = 151
        Height = 131
        Caption = 'Bind Items'
        TabOrder = 0
        object CheckBoxBindItemNoDeal: TCheckBox
          Left = 20
          Top = 20
          Width = 81
          Height = 21
          Caption = 'No Deal'
          TabOrder = 0
          OnClick = CheckBoxBindItemNoDealClick
        end
        object CheckBoxBindItemNoScatter: TCheckBox
          Left = 20
          Top = 40
          Width = 81
          Height = 21
          Caption = 'No Scatter'
          TabOrder = 1
          OnClick = CheckBoxBindItemNoScatterClick
        end
        object CheckBoxBindItemNoDrop: TCheckBox
          Left = 20
          Top = 60
          Width = 71
          Height = 21
          Caption = 'No Drop'
          TabOrder = 2
          OnClick = CheckBoxBindItemNoDropClick
        end
        object CheckBoxBindItemNoSellOff: TCheckBox
          Left = 20
          Top = 80
          Width = 91
          Height = 21
          Caption = 'No Sell Off'
          TabOrder = 3
          OnClick = CheckBoxBindItemNoSellOffClick
        end
        object CheckBoxBindItemNoPickUp: TCheckBox
          Left = 20
          Top = 100
          Width = 121
          Height = 21
          Caption = 'No Pick Up'
          TabOrder = 4
          OnClick = CheckBoxBindItemNoPickUpClick
        end
      end
      object ButtonSaveBindItem: TButton
        Left = 430
        Top = 320
        Width = 94
        Height = 31
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonSaveBindItemClick
      end
    end
    object TabSheet60: TTabSheet
      Caption = '????'
      ImageIndex = 17
      object GroupBox76: TGroupBox
        Left = 10
        Top = 10
        Width = 231
        Height = 81
        Caption = '??????'
        TabOrder = 0
        object CheckBoxCopyItemClear: TCheckBox
          Left = 10
          Top = 30
          Width = 151
          Height = 21
          Caption = '????????'
          TabOrder = 0
          OnClick = CheckBoxCopyItemClearClick
        end
      end
      object ButtonClearCopyItem: TButton
        Left = 430
        Top = 320
        Width = 94
        Height = 31
        Caption = '??(&S)'
        TabOrder = 1
        OnClick = ButtonClearCopyItemClick
      end
      object GroupBox100: TGroupBox
        Left = 10
        Top = 100
        Width = 231
        Height = 81
        Caption = '???????????'
        TabOrder = 2
        object Label185: TLabel
          Left = 20
          Top = 30
          Width = 31
          Height = 15
          Caption = '????:'
        end
        object EditItemMaxStarCount: TSpinEdit
          Left = 100
          Top = 25
          Width = 71
          Height = 24
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = EditItemMaxStarCountChange
        end
      end
      object GroupBox102: TGroupBox
        Left = 10
        Top = 190
        Width = 231
        Height = 81
        Caption = '??????????'
        TabOrder = 3
        object CheckBoxCheckCanUpgradeStarItem: TCheckBox
          Left = 10
          Top = 30
          Width = 181
          Height = 21
          Caption = '??????????'
          TabOrder = 0
          OnClick = CheckBoxCheckCanUpgradeStarItemClick
        end
      end
    end
    object TabSheet12: TTabSheet
      Caption = '????'
      ImageIndex = 18
      object GroupBox92: TGroupBox
        Left = 10
        Top = 10
        Width = 251
        Height = 121
        Caption = '????'
        TabOrder = 0
        object Label161: TLabel
          Left = 178
          Top = 90
          Width = 28
          Height = 15
          Caption = '????'
        end
        object CheckBoxSafeCanStore: TCheckBox
          Left = 10
          Top = 30
          Width = 151
          Height = 21
          Caption = '????????'
          TabOrder = 0
          OnClick = CheckBoxSafeCanStoreClick
        end
        object CheckBoxOpenStoreGMMode: TCheckBox
          Left = 10
          Top = 59
          Width = 121
          Height = 21
          Caption = '??????'
          TabOrder = 1
          OnClick = CheckBoxOpenStoreGMModeClick
        end
        object CheckBoxOpenStoreCheckLevel: TCheckBox
          Left = 10
          Top = 88
          Width = 121
          Height = 21
          Caption = '????'
          TabOrder = 2
          OnClick = CheckBoxOpenStoreCheckLevelClick
        end
        object EditOpenStoreCheckLevel: TSpinEdit
          Left = 101
          Top = 88
          Width = 72
          Height = 24
          Hint = '???????'
          MaxValue = 65535
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnChange = EditOpenStoreCheckLevelChange
        end
      end
      object ButtonSaveStore: TButton
        Left = 430
        Top = 320
        Width = 94
        Height = 31
        Caption = '??(&S)'
        TabOrder = 1
        OnClick = ButtonSaveStoreClick
      end
    end
    object TabSheet14: TTabSheet
      Caption = '???'
      ImageIndex = 18
      object PageControlAI: TPageControl
        Left = 0
        Top = 0
        Width = 563
        Height = 371
        ActivePage = TabSheet16
        Align = alTop
        TabOrder = 0
        object TabSheet15: TTabSheet
          Caption = '????'
          object GroupBox72: TGroupBox
            Left = 20
            Top = 9
            Width = 211
            Height = 252
            Caption = '?????'
            TabOrder = 0
            object ListBoxAIList: TMyListBox
              Left = 10
              Top = 20
              Width = 191
              Height = 221
              ItemHeight = 15
              MultiSelect = True
              TabOrder = 0
              OnClick = ListBoxAIListClick
              OnSelect = ListBoxAIListSelect
            end
          end
          object GroupBox99: TGroupBox
            Left = 240
            Top = 10
            Width = 261
            Height = 106
            TabOrder = 1
            object Label184: TLabel
              Left = 10
              Top = 25
              Width = 31
              Height = 15
              Caption = '????:'
            end
            object EditAIName: TEdit
              Left = 80
              Top = 20
              Width = 171
              Height = 23
              TabOrder = 0
            end
            object ButtonAIListAdd: TButton
              Left = 100
              Top = 60
              Width = 71
              Height = 31
              Caption = '??(&A)'
              TabOrder = 1
              OnClick = ButtonAIListAddClick
            end
            object ButtonAIDel: TButton
              Left = 175
              Top = 60
              Width = 71
              Height = 31
              Caption = '??(&D)'
              TabOrder = 2
              OnClick = ButtonAIDelClick
            end
          end
          object GroupBox73: TGroupBox
            Left = 240
            Top = 120
            Width = 181
            Height = 111
            Caption = '????'
            TabOrder = 2
            object Label181: TLabel
              Left = 10
              Top = 55
              Width = 24
              Height = 15
              Caption = '??X:'
            end
            object Label182: TLabel
              Left = 10
              Top = 85
              Width = 24
              Height = 15
              Caption = '??Y:'
            end
            object Label183: TLabel
              Left = 10
              Top = 25
              Width = 17
              Height = 15
              Caption = '??:'
            end
            object EditHomeX: TSpinEdit
              Left = 65
              Top = 50
              Width = 66
              Height = 24
              MaxValue = 2000
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditHomeXChange
            end
            object EditHomeY: TSpinEdit
              Left = 65
              Top = 80
              Width = 66
              Height = 24
              MaxValue = 2000
              MinValue = 1
              TabOrder = 1
              Value = 10
              OnChange = EditHomeYChange
            end
            object EditHomeMap: TEdit
              Left = 65
              Top = 20
              Width = 91
              Height = 23
              TabOrder = 2
              Text = '3'
              OnChange = EditHomeMapChange
            end
          end
          object ButtonAILogon: TButton
            Left = 440
            Top = 200
            Width = 101
            Height = 31
            Caption = '??(&L)'
            TabOrder = 3
            OnClick = ButtonAILogonClick
          end
          object GroupBox101: TGroupBox
            Left = 20
            Top = 270
            Width = 531
            Height = 61
            Caption = '??????'
            TabOrder = 4
            object EditConfigListFileName: TEdit
              Left = 10
              Top = 23
              Width = 511
              Height = 23
              TabOrder = 0
              Text = 'D:\MirServer\Mir200\Envir\QuestDiary\?????????.txt'
              OnChange = EditConfigListFileNameChange
            end
          end
        end
        object TabSheet16: TTabSheet
          Caption = '????'
          ImageIndex = 1
          object GroupBox103: TGroupBox
            Left = 10
            Top = 10
            Width = 151
            Height = 61
            Caption = '????'
            TabOrder = 0
            object CheckBoxAutoRepairItem: TCheckBox
              Left = 20
              Top = 20
              Width = 111
              Height = 21
              Caption = '??????'
              TabOrder = 0
              OnClick = CheckBoxAutoRepairItemClick
            end
          end
          object GroupBox104: TGroupBox
            Left = 10
            Top = 80
            Width = 151
            Height = 61
            Caption = '????HPMP'
            TabOrder = 1
            object CheckBoxRenewHealth: TCheckBox
              Left = 20
              Top = 20
              Width = 111
              Height = 21
              Caption = '????HPMP'
              TabOrder = 0
              OnClick = CheckBoxRenewHealthClick
            end
          end
          object GroupBox105: TGroupBox
            Left = 10
            Top = 150
            Width = 311
            Height = 61
            Caption = '???'
            TabOrder = 2
            object Label188: TLabel
              Left = 10
              Top = 26
              Width = 79
              Height = 15
              Caption = 'HP?MP?????:'
            end
            object Label190: TLabel
              Left = 210
              Top = 26
              Width = 49
              Height = 15
              Caption = '% ?????'
            end
            object EditRenewPercent: TSpinEdit
              Left = 140
              Top = 24
              Width = 61
              Height = 24
              MaxValue = 100
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Value = 60
              OnChange = EditRenewPercentChange
            end
          end
        end
      end
      object ButtonSaveAI: TButton
        Left = 448
        Top = 380
        Width = 93
        Height = 31
        Caption = '??(&S)'
        TabOrder = 1
        OnClick = ButtonSaveAIClick
      end
    end
  end
end
