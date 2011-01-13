object frmGameConfig: TfrmGameConfig
  Left = 163
  Top = 76
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Game Config'
  ClientHeight = 387
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label14: TLabel
    Left = 10
    Top = 362
    Width = 314
    Height = 18
    Caption = '?????????,???????????????,??????????'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = '??'
    Font.Style = []
    ParentFont = False
  end
  object GameConfigControl: TPageControl
    Left = 10
    Top = 10
    Width = 615
    Height = 343
    ActivePage = ExpSheet
    MultiLine = True
    TabOrder = 0
    OnChanging = GameConfigControlChanging
    object GeneralSheet: TTabSheet
      Caption = 'General'
      ImageIndex = 2
      object GroupBox5: TGroupBox
        Left = 211
        Top = 6
        Width = 182
        Height = 55
        Caption = 'Show User Count'
        TabOrder = 0
        object Label17: TLabel
          Left = 10
          Top = 25
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object EditConsoleShowUserCountTime: TSpinEdit
          Left = 85
          Top = 20
          Width = 78
          Height = 23
          Hint = '????????????????'
          EditorEnabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 0
          Value = 10
          OnChange = EditConsoleShowUserCountTimeChange
        end
      end
      object GroupBox6: TGroupBox
        Left = 10
        Top = 127
        Width = 192
        Height = 126
        Caption = 'Line Message'
        TabOrder = 1
        object Label18: TLabel
          Left = 10
          Top = 25
          Width = 75
          Height = 14
          Caption = 'Show Line Msg'
        end
        object Label19: TLabel
          Left = 10
          Top = 55
          Width = 25
          Height = 14
          Caption = 'Color'
        end
        object Label21: TLabel
          Left = 10
          Top = 85
          Width = 28
          Height = 14
          Caption = 'Prefix'
        end
        object EditShowLineNoticeTime: TSpinEdit
          Left = 81
          Top = 19
          Width = 71
          Height = 23
          Hint = '????????????????'
          EditorEnabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 0
          Value = 10
          OnChange = EditShowLineNoticeTimeChange
        end
        object ComboBoxLineNoticeColor: TComboBox
          Left = 81
          Top = 51
          Width = 71
          Height = 22
          Hint = '???????????'
          Style = csDropDownList
          ItemHeight = 14
          TabOrder = 1
          OnChange = ComboBoxLineNoticeColorChange
        end
        object EditLineNoticePreFix: TEdit
          Left = 81
          Top = 81
          Width = 91
          Height = 22
          MaxLength = 20
          TabOrder = 2
          Text = '????'
          OnChange = EditLineNoticePreFixChange
        end
      end
      object ButtonGeneralSave: TButton
        Left = 513
        Top = 218
        Width = 81
        Height = 31
        Caption = 'Save'
        TabOrder = 2
        OnClick = ButtonGeneralSaveClick
      end
      object GroupBox35: TGroupBox
        Left = 402
        Top = 0
        Width = 183
        Height = 112
        Caption = 'M2 Options'
        TabOrder = 3
        object CheckBoxShowMakeItemMsg: TCheckBox
          Left = 10
          Top = 17
          Width = 163
          Height = 22
          Caption = 'Show Make Gm Item Msg'
          TabOrder = 0
          OnClick = CheckBoxShowMakeItemMsgClick
        end
        object CbViewHack: TCheckBox
          Left = 10
          Top = 38
          Width = 122
          Height = 21
          Caption = 'View Hack'
          TabOrder = 1
          OnClick = CbViewHackClick
        end
        object CkViewAdmfail: TCheckBox
          Left = 10
          Top = 58
          Width = 122
          Height = 22
          Caption = 'View Admin Fail'
          TabOrder = 2
          OnClick = CkViewAdmfailClick
        end
        object CheckBoxShowExceptionMsg: TCheckBox
          Left = 10
          Top = 78
          Width = 122
          Height = 21
          Caption = 'Show Exception Msg'
          TabOrder = 3
          OnClick = CheckBoxShowExceptionMsgClick
        end
      end
      object GroupBox51: TGroupBox
        Left = 10
        Top = 6
        Width = 192
        Height = 116
        Caption = 'Online Message'
        TabOrder = 4
        object Label98: TLabel
          Left = 10
          Top = 45
          Width = 53
          Height = 14
          Caption = 'Count Rate'
        end
        object Label99: TLabel
          Left = 10
          Top = 75
          Width = 83
          Height = 14
          Caption = 'Send Online Time'
        end
        object EditSendOnlineCountRate: TSpinEdit
          Left = 103
          Top = 40
          Width = 79
          Height = 23
          Hint = '????????????,???????10,???10????,11 ??1.1??'
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 10
          TabOrder = 0
          Value = 10
          OnChange = EditSendOnlineCountRateChange
        end
        object EditSendOnlineTime: TSpinEdit
          Left = 102
          Top = 70
          Width = 78
          Height = 23
          Hint = '???????????'
          EditorEnabled = False
          Increment = 10
          MaxValue = 200000
          MinValue = 5
          TabOrder = 1
          Value = 10
          OnChange = EditSendOnlineTimeChange
        end
        object CheckBoxSendOnlineCount: TCheckBox
          Left = 10
          Top = 17
          Width = 163
          Height = 22
          Hint = '??????????????,???????????????????????'
          Caption = 'Send Online Count'
          TabOrder = 2
          OnClick = CheckBoxSendOnlineCountClick
        end
      end
      object GroupBox52: TGroupBox
        Left = 211
        Top = 69
        Width = 182
        Height = 122
        Caption = 'Rates'
        TabOrder = 5
        object Label101: TLabel
          Left = 10
          Top = 25
          Width = 58
          Height = 14
          Caption = 'Mob Power '
        end
        object Label102: TLabel
          Left = 10
          Top = 55
          Width = 19
          Height = 14
          Caption = 'Item'
        end
        object Label103: TLabel
          Left = 10
          Top = 85
          Width = 49
          Height = 14
          Caption = 'Ac Power'
        end
        object EditMonsterPowerRate: TSpinEdit
          Left = 85
          Top = 20
          Width = 87
          Height = 23
          Hint = '??????(HP?MP?DC?MC?SC),???????????10?'
          EditorEnabled = False
          MaxValue = 20000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditMonsterPowerRateChange
        end
        object EditEditItemsPowerRate: TSpinEdit
          Left = 85
          Top = 51
          Width = 87
          Height = 23
          Hint = '??????(DC?MC?SC),???????????10?'
          EditorEnabled = False
          MaxValue = 20000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditEditItemsPowerRateChange
        end
        object EditItemsACPowerRate: TSpinEdit
          Left = 85
          Top = 81
          Width = 87
          Height = 23
          Hint = '??????(AC?MAC??),???????????10?'
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditItemsACPowerRateChange
        end
      end
      object GroupBox77: TGroupBox
        Left = 401
        Top = 120
        Width = 184
        Height = 90
        Caption = 'Robot'
        TabOrder = 6
        object Label149: TLabel
          Left = 10
          Top = 50
          Width = 56
          Height = 14
          Caption = 'Attack Time'
        end
        object CheckBoxRobotAttack: TCheckBox
          Left = 10
          Top = 20
          Width = 162
          Height = 22
          Hint = '???????LoginSrv'
          Caption = 'Robot Attack'
          TabOrder = 0
          OnClick = CheckBoxRobotAttackClick
        end
        object EditRobotAttackTime: TSpinEdit
          Left = 80
          Top = 45
          Width = 83
          Height = 23
          Hint = '??????,??15?'
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 1
          Value = 15
          OnChange = EditRobotAttackTimeChange
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Options'
      ImageIndex = 7
      object GroupBox28: TGroupBox
        Left = 10
        Top = 10
        Width = 153
        Height = 112
        Caption = 'Server Mode'
        TabOrder = 0
        object CheckBoxTestServer: TCheckBox
          Left = 10
          Top = 17
          Width = 92
          Height = 22
          Hint = '????,?????,?????????????????'
          Caption = 'Test Server'
          TabOrder = 0
          OnClick = CheckBoxTestServerClick
        end
        object CheckBoxServiceMode: TCheckBox
          Left = 10
          Top = 38
          Width = 92
          Height = 21
          Hint = '????,?????????????'
          Caption = 'Service Mode'
          TabOrder = 1
          OnClick = CheckBoxServiceModeClick
        end
        object CheckBoxVentureMode: TCheckBox
          Left = 10
          Top = 58
          Width = 102
          Height = 22
          Caption = 'Venture Mode'
          TabOrder = 2
          OnClick = CheckBoxVentureModeClick
        end
        object CheckBoxNonPKMode: TCheckBox
          Left = 10
          Top = 78
          Width = 102
          Height = 21
          Caption = 'No Pk Mode'
          TabOrder = 3
          OnClick = CheckBoxNonPKModeClick
        end
      end
      object GroupBox29: TGroupBox
        Left = 10
        Top = 130
        Width = 183
        Height = 123
        Caption = 'Test Settings'
        TabOrder = 1
        object Label61: TLabel
          Left = 10
          Top = 25
          Width = 50
          Height = 14
          Caption = 'Test Level'
        end
        object Label62: TLabel
          Left = 10
          Top = 55
          Width = 46
          Height = 14
          Caption = 'Test Gold'
        end
        object Label63: TLabel
          Left = 10
          Top = 85
          Width = 71
          Height = 14
          Caption = 'Test User Limit'
        end
        object EditTestLevel: TSpinEdit
          Left = 85
          Top = 20
          Width = 87
          Height = 22
          Hint = '???????'
          MaxValue = 20000
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = EditTestLevelChange
          OnKeyDown = EditTestLevelKeyDown
        end
        object EditTestGold: TSpinEdit
          Left = 85
          Top = 51
          Width = 87
          Height = 22
          Hint = '????????????'
          Increment = 1000
          MaxValue = 20000000
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditTestGoldChange
        end
        object EditTestUserLimit: TSpinEdit
          Left = 85
          Top = 81
          Width = 87
          Height = 22
          Hint = '??????????????'
          Increment = 10
          MaxValue = 2000
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditTestUserLimitChange
        end
      end
      object GroupBox30: TGroupBox
        Left = 382
        Top = 10
        Width = 162
        Height = 62
        Caption = 'Start'
        TabOrder = 2
        object Label60: TLabel
          Left = 10
          Top = 25
          Width = 52
          Height = 14
          Caption = 'Permission'
        end
        object EditStartPermission: TSpinEdit
          Left = 85
          Top = 20
          Width = 67
          Height = 22
          Hint = '????????,???0?'
          EditorEnabled = False
          MaxValue = 10
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = EditStartPermissionChange
        end
      end
      object ButtonOptionSave0: TButton
        Left = 462
        Top = 227
        Width = 82
        Height = 31
        Caption = 'Save'
        TabOrder = 3
        OnClick = ButtonOptionSave0Click
      end
      object GroupBox31: TGroupBox
        Left = 201
        Top = 191
        Width = 132
        Height = 62
        Caption = 'Users'
        TabOrder = 4
        object Label64: TLabel
          Left = 10
          Top = 25
          Width = 20
          Height = 14
          Caption = 'Max'
        end
        object EditUserFull: TSpinEdit
          Left = 55
          Top = 20
          Width = 67
          Height = 22
          Hint = '?????????,??????????????'
          MaxValue = 10000
          MinValue = 0
          TabOrder = 0
          Value = 1000
          OnChange = EditUserFullChange
        end
      end
      object GroupBox33: TGroupBox
        Left = 171
        Top = 10
        Width = 203
        Height = 92
        Caption = 'Gold Options'
        TabOrder = 5
        object Label68: TLabel
          Left = 10
          Top = 25
          Width = 45
          Height = 14
          Caption = 'Max Gold'
        end
        object Label69: TLabel
          Left = 10
          Top = 46
          Width = 68
          Height = 28
          Caption = 'Try Mode Max'#13'Gold'
        end
        object EditHumanMaxGold: TSpinEdit
          Left = 85
          Top = 20
          Width = 108
          Height = 22
          Increment = 10000
          MaxValue = 200000000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditHumanMaxGoldChange
        end
        object EditHumanTryModeMaxGold: TSpinEdit
          Left = 85
          Top = 51
          Width = 108
          Height = 22
          Increment = 10000
          MaxValue = 200000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditHumanTryModeMaxGoldChange
        end
      end
      object GroupBox34: TGroupBox
        Left = 201
        Top = 106
        Width = 173
        Height = 76
        Caption = 'Try Mode Settings'
        TabOrder = 6
        object Label70: TLabel
          Left = 1
          Top = 25
          Width = 74
          Height = 14
          Caption = 'Try Mode Level'
        end
        object EditTryModeLevel: TSpinEdit
          Left = 85
          Top = 20
          Width = 78
          Height = 22
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditTryModeLevelChange
        end
        object CheckBoxTryModeUseStorage: TCheckBox
          Left = 10
          Top = 47
          Width = 153
          Height = 22
          Hint = '???????????'
          Caption = 'Try Mode Use Storage'
          TabOrder = 1
          OnClick = CheckBoxTryModeUseStorageClick
        end
      end
      object GroupBox19: TGroupBox
        Left = 341
        Top = 191
        Width = 112
        Height = 62
        Caption = 'Group Members'
        TabOrder = 7
        object Label41: TLabel
          Left = 10
          Top = 25
          Width = 23
          Height = 14
          Caption = 'Max '
        end
        object EditGroupMembersMax: TSpinEdit
          Left = 55
          Top = 20
          Width = 47
          Height = 22
          Hint = '???????'
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditGroupMembersMaxChange
        end
      end
      object GroupBox81: TGroupBox
        Left = 381
        Top = 82
        Width = 204
        Height = 52
        Caption = 'Level'
        TabOrder = 8
        object Label151: TLabel
          Left = 10
          Top = 25
          Width = 20
          Height = 14
          Caption = 'Max'
        end
        object EditMaxLevel: TSpinEdit
          Left = 85
          Top = 22
          Width = 108
          Height = 22
          Hint = '?????????'
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 65535
          OnChange = EditMaxLevelChange
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Map'
      ImageIndex = 4
      object ButtonOptionSave: TButton
        Left = 462
        Top = 227
        Width = 82
        Height = 31
        Caption = 'Save'
        TabOrder = 0
        OnClick = ButtonOptionSaveClick
      end
      object GroupBox16: TGroupBox
        Left = 10
        Top = 10
        Width = 132
        Height = 62
        Caption = 'Saze Zone'
        TabOrder = 1
        object Label39: TLabel
          Left = 10
          Top = 25
          Width = 21
          Height = 14
          Caption = 'Size'
        end
        object EditSafeZoneSize: TSpinEdit
          Left = 55
          Top = 20
          Width = 57
          Height = 23
          Hint = '????????'
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditSafeZoneSizeChange
        end
      end
      object GroupBox18: TGroupBox
        Left = 10
        Top = 81
        Width = 132
        Height = 61
        Caption = 'Start Point'
        TabOrder = 2
        object Label40: TLabel
          Left = 10
          Top = 25
          Width = 21
          Height = 14
          Caption = 'Size'
        end
        object EditStartPointSize: TSpinEdit
          Left = 55
          Top = 20
          Width = 57
          Height = 23
          Hint = '???????,????????????'
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditStartPointSizeChange
        end
      end
      object GroupBox20: TGroupBox
        Left = 151
        Top = 10
        Width = 182
        Height = 112
        Caption = 'Red Home'
        TabOrder = 3
        object Label42: TLabel
          Left = 10
          Top = 55
          Width = 26
          Height = 14
          Caption = 'Co X:'
        end
        object Label43: TLabel
          Left = 10
          Top = 85
          Width = 27
          Height = 14
          Caption = 'Co Y:'
        end
        object Label44: TLabel
          Left = 10
          Top = 25
          Width = 20
          Height = 14
          Caption = 'Map'
        end
        object EditRedHomeX: TSpinEdit
          Left = 66
          Top = 51
          Width = 66
          Height = 23
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditRedHomeXChange
        end
        object EditRedHomeY: TSpinEdit
          Left = 66
          Top = 81
          Width = 66
          Height = 23
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditRedHomeYChange
        end
        object EditRedHomeMap: TEdit
          Left = 66
          Top = 20
          Width = 91
          Height = 22
          Hint = '????????????'
          TabOrder = 2
          Text = '3'
          OnChange = EditRedHomeMapChange
        end
      end
      object GroupBox21: TGroupBox
        Left = 151
        Top = 130
        Width = 182
        Height = 112
        Caption = 'Red Die'
        TabOrder = 4
        object Label45: TLabel
          Left = 10
          Top = 55
          Width = 26
          Height = 14
          Caption = 'Co X:'
        end
        object Label46: TLabel
          Left = 10
          Top = 85
          Width = 27
          Height = 14
          Caption = 'Co Y:'
        end
        object Label47: TLabel
          Left = 10
          Top = 25
          Width = 23
          Height = 14
          Caption = 'Map:'
        end
        object EditRedDieHomeX: TSpinEdit
          Left = 66
          Top = 51
          Width = 66
          Height = 23
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditRedDieHomeXChange
        end
        object EditRedDieHomeY: TSpinEdit
          Left = 66
          Top = 81
          Width = 66
          Height = 23
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditRedDieHomeYChange
        end
        object EditRedDieHomeMap: TEdit
          Left = 66
          Top = 20
          Width = 91
          Height = 22
          TabOrder = 2
          Text = '3'
          OnChange = EditRedDieHomeMapChange
        end
      end
      object GroupBox22: TGroupBox
        Left = 341
        Top = 10
        Width = 183
        Height = 112
        Caption = 'Home'
        TabOrder = 5
        object Label48: TLabel
          Left = 10
          Top = 55
          Width = 26
          Height = 14
          Caption = 'Co X:'
        end
        object Label49: TLabel
          Left = 10
          Top = 85
          Width = 27
          Height = 14
          Caption = 'Co Y:'
        end
        object Label50: TLabel
          Left = 10
          Top = 25
          Width = 20
          Height = 14
          Caption = 'Map'
        end
        object EditHomeX: TSpinEdit
          Left = 66
          Top = 51
          Width = 66
          Height = 23
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditHomeXChange
        end
        object EditHomeY: TSpinEdit
          Left = 66
          Top = 81
          Width = 66
          Height = 23
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditHomeYChange
        end
        object EditHomeMap: TEdit
          Left = 66
          Top = 20
          Width = 91
          Height = 22
          TabOrder = 2
          Text = '3'
          OnChange = EditHomeMapChange
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Pk'
      ImageIndex = 6
      object ButtonOptionSave2: TButton
        Left = 462
        Top = 227
        Width = 82
        Height = 31
        Caption = 'Save'
        TabOrder = 0
        OnClick = ButtonOptionSave2Click
      end
      object GroupBox23: TGroupBox
        Left = 10
        Top = 10
        Width = 192
        Height = 92
        Caption = '???PK???'
        TabOrder = 1
        object Label51: TLabel
          Left = 10
          Top = 25
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object Label52: TLabel
          Left = 10
          Top = 55
          Width = 28
          Height = 14
          Caption = 'Count'
        end
        object EditDecPkPointTime: TSpinEdit
          Left = 85
          Top = 20
          Width = 67
          Height = 23
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditDecPkPointTimeChange
        end
        object EditDecPkPointCount: TSpinEdit
          Left = 85
          Top = 51
          Width = 67
          Height = 23
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditDecPkPointCountChange
        end
      end
      object GroupBox24: TGroupBox
        Left = 10
        Top = 111
        Width = 132
        Height = 61
        Caption = 'Pk Flag Time'
        TabOrder = 2
        object Label54: TLabel
          Left = 10
          Top = 25
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object EditPKFlagTime: TSpinEdit
          Left = 55
          Top = 20
          Width = 67
          Height = 23
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditPKFlagTimeChange
        end
      end
      object GroupBox25: TGroupBox
        Left = 10
        Top = 181
        Width = 132
        Height = 61
        Caption = 'Kill Hum Add Point'
        TabOrder = 3
        object Label55: TLabel
          Left = 1
          Top = 25
          Width = 46
          Height = 14
          Caption = 'Add Point'
        end
        object EditKillHumanAddPKPoint: TSpinEdit
          Left = 55
          Top = 20
          Width = 67
          Height = 23
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditKillHumanAddPKPointChange
        end
      end
      object GroupBox32: TGroupBox
        Left = 211
        Top = 10
        Width = 333
        Height = 213
        Caption = 'Pk Options'
        TabOrder = 4
        object Label58: TLabel
          Left = 141
          Top = 25
          Width = 71
          Height = 14
          Caption = 'Hum Win Level'
        end
        object Label65: TLabel
          Left = 141
          Top = 55
          Width = 77
          Height = 14
          Caption = 'Hum Lose Level'
        end
        object Label66: TLabel
          Left = 141
          Top = 85
          Width = 63
          Height = 14
          Caption = 'Hum Win Exp'
        end
        object Label56: TLabel
          Left = 141
          Top = 112
          Width = 66
          Height = 14
          Caption = 'Hum Lost Exp'
        end
        object Label67: TLabel
          Left = 79
          Top = 115
          Width = 26
          Height = 14
          Caption = 'Level'
        end
        object Label114: TLabel
          Left = 141
          Top = 145
          Width = 77
          Height = 14
          Caption = 'Pk Protect Level'
        end
        object Label115: TLabel
          Left = 112
          Top = 176
          Width = 99
          Height = 14
          Caption = 'Red Pk Protect Level'
        end
        object CheckBoxKillHumanWinLevel: TCheckBox
          Left = 10
          Top = 23
          Width = 122
          Height = 21
          Caption = 'Hum Win Level'
          TabOrder = 0
          OnClick = CheckBoxKillHumanWinLevelClick
        end
        object CheckBoxKilledLostLevel: TCheckBox
          Left = 10
          Top = 45
          Width = 122
          Height = 22
          Caption = 'Killed Lose Level'
          TabOrder = 1
          OnClick = CheckBoxKilledLostLevelClick
        end
        object CheckBoxKilledLostExp: TCheckBox
          Left = 10
          Top = 85
          Width = 122
          Height = 22
          Caption = 'Killed Lose Exp'
          TabOrder = 2
          OnClick = CheckBoxKilledLostExpClick
        end
        object CheckBoxKillHumanWinExp: TCheckBox
          Left = 10
          Top = 66
          Width = 122
          Height = 21
          Caption = 'Kill Win Exp'
          TabOrder = 3
          OnClick = CheckBoxKillHumanWinExpClick
        end
        object EditKillHumanWinLevel: TSpinEdit
          Left = 232
          Top = 20
          Width = 91
          Height = 23
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 4
          Value = 10
          OnChange = EditKillHumanWinLevelChange
        end
        object EditKilledLostLevel: TSpinEdit
          Left = 232
          Top = 51
          Width = 91
          Height = 23
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 5
          Value = 10
          OnChange = EditKilledLostLevelChange
        end
        object EditKillHumanWinExp: TSpinEdit
          Left = 232
          Top = 81
          Width = 91
          Height = 23
          Increment = 1000
          MaxValue = 200000000
          MinValue = 1
          TabOrder = 6
          Value = 10
          OnChange = EditKillHumanWinExpChange
        end
        object EditKillHumanLostExp: TSpinEdit
          Left = 232
          Top = 111
          Width = 91
          Height = 23
          Increment = 1000
          MaxValue = 200000000
          MinValue = 1
          TabOrder = 7
          Value = 10
          OnChange = EditKillHumanLostExpChange
        end
        object EditHumanLevelDiffer: TSpinEdit
          Left = 10
          Top = 111
          Width = 62
          Height = 23
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 8
          Value = 10
          OnChange = EditHumanLevelDifferChange
        end
        object CheckBoxPKLevelProtect: TCheckBox
          Left = 10
          Top = 145
          Width = 112
          Height = 22
          Hint = 
            '??PK????,??????,??????????????????????????(????????????),???????' +
            '????????????????(????????????)?'
          Caption = 'Pk Level Protect'
          TabOrder = 9
          OnClick = CheckBoxPKLevelProtectClick
        end
        object EditPKProtectLevel: TSpinEdit
          Left = 232
          Top = 141
          Width = 91
          Height = 23
          Hint = '???????????????,????????????'
          EditorEnabled = False
          MaxValue = 65535
          MinValue = 1
          TabOrder = 10
          Value = 10
          OnChange = EditPKProtectLevelChange
        end
        object EditRedPKProtectLevel: TSpinEdit
          Left = 232
          Top = 171
          Width = 91
          Height = 23
          Hint = 
            '????PK??,???????????????????????????????????????????????????????' +
            '?'
          EditorEnabled = False
          MaxValue = 65535
          MinValue = 1
          TabOrder = 11
          Value = 10
          OnChange = EditRedPKProtectLevelChange
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'More'
      ImageIndex = 5
      object GroupBox17: TGroupBox
        Left = 352
        Top = 10
        Width = 192
        Height = 213
        Caption = 'Run Through'
        TabOrder = 0
        object CheckBoxDisHumRun: TCheckBox
          Left = 34
          Top = 22
          Width = 122
          Height = 16
          Hint = '??????,???????????????'
          Caption = 'Disable Hum Run'
          TabOrder = 0
          OnClick = CheckBoxDisHumRunClick
        end
        object CheckBoxRunHum: TCheckBox
          Left = 34
          Top = 40
          Width = 123
          Height = 17
          Hint = '??????,???????????'
          Caption = 'Run Hum'
          TabOrder = 1
          OnClick = CheckBoxRunHumClick
        end
        object CheckBoxRunMon: TCheckBox
          Left = 34
          Top = 65
          Width = 124
          Height = 16
          Hint = '??????,?????????'
          Caption = 'Run Mon'
          TabOrder = 2
          OnClick = CheckBoxRunMonClick
        end
        object CheckBoxWarDisHumRun: TCheckBox
          Left = 34
          Top = 127
          Width = 153
          Height = 16
          Hint = '??????,?????,????????'
          Caption = 'War Disable Run'
          TabOrder = 3
          OnClick = CheckBoxWarDisHumRunClick
        end
        object CheckBoxRunNpc: TCheckBox
          Left = 34
          Top = 84
          Width = 124
          Height = 16
          Hint = '??????,???????NPC'
          Caption = 'Run Npc'
          TabOrder = 4
          OnClick = CheckBoxRunNpcClick
        end
        object CheckBoxGMRunAll: TCheckBox
          Left = 34
          Top = 150
          Width = 153
          Height = 16
          Hint = '??????,????????????????'
          Caption = 'Gm Run All'
          TabOrder = 5
          OnClick = CheckBoxGMRunAllClick
        end
        object CheckBoxRunGuard: TCheckBox
          Left = 34
          Top = 104
          Width = 124
          Height = 17
          Hint = '??????,?????????(??????)'
          Caption = 'Run Guard'
          TabOrder = 6
          OnClick = CheckBoxRunGuardClick
        end
        object CheckBoxSafeArea: TCheckBox
          Left = 34
          Top = 171
          Width = 148
          Height = 22
          Caption = 'Safe Area'
          TabOrder = 7
          OnClick = CheckBoxSafeAreaClick
        end
      end
      object ButtonOptionSave3: TButton
        Left = 462
        Top = 227
        Width = 82
        Height = 31
        Caption = 'Save'
        TabOrder = 1
        OnClick = ButtonOptionSave3Click
      end
      object GroupBox53: TGroupBox
        Left = 10
        Top = 10
        Width = 162
        Height = 132
        Caption = 'Deal'
        TabOrder = 2
        object Label20: TLabel
          Left = 10
          Top = 25
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object Label104: TLabel
          Left = 10
          Top = 55
          Width = 38
          Height = 14
          Caption = 'Ok Time'
        end
        object Label105: TLabel
          Left = 135
          Top = 25
          Width = 6
          Height = 14
          Caption = '?'
        end
        object Label106: TLabel
          Left = 135
          Top = 54
          Width = 6
          Height = 14
          Caption = '?'
        end
        object EditTryDealTime: TSpinEdit
          Left = 85
          Top = 20
          Width = 47
          Height = 23
          Hint = '?????,??????????????'
          EditorEnabled = False
          MaxValue = 10
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditTryDealTimeChange
        end
        object EditDealOKTime: TSpinEdit
          Left = 85
          Top = 51
          Width = 47
          Height = 23
          Hint = '???????,??????????????'
          EditorEnabled = False
          MaxValue = 10
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditDealOKTimeChange
        end
        object CheckBoxCanNotGetBackDeal: TCheckBox
          Left = 14
          Top = 81
          Width = 138
          Height = 16
          Hint = '??????,???????????????,????????????'
          Caption = 'Can Not Get Back'
          TabOrder = 2
          OnClick = CheckBoxCanNotGetBackDealClick
        end
        object CheckBoxDisableDeal: TCheckBox
          Left = 14
          Top = 100
          Width = 138
          Height = 17
          Hint = '?????,?????????????'
          Caption = 'Disable Deal'
          TabOrder = 3
          OnClick = CheckBoxDisableDealClick
        end
      end
      object GroupBox26: TGroupBox
        Left = 10
        Top = 160
        Width = 162
        Height = 63
        Caption = 'Poison Dec Health '
        TabOrder = 3
        object Label57: TLabel
          Left = 10
          Top = 25
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object EditPosionDecHealthTime: TSpinEdit
          Left = 85
          Top = 20
          Width = 67
          Height = 23
          Hint = '??????,??????????'
          Increment = 100
          MaxValue = 20000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditPosionDecHealthTimeChange
        end
      end
      object GroupBox27: TGroupBox
        Left = 181
        Top = 160
        Width = 163
        Height = 63
        Caption = 'Poison Damage Armour'
        TabOrder = 4
        object Label59: TLabel
          Left = 10
          Top = 25
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object EditPosionDamagarmor: TSpinEdit
          Left = 55
          Top = 20
          Width = 67
          Height = 23
          Hint = '???????????????,?????10??????'
          EditorEnabled = False
          MaxValue = 20000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditPosionDamagarmorChange
        end
      end
      object GroupBox64: TGroupBox
        Left = 181
        Top = 10
        Width = 163
        Height = 142
        Caption = 'Drops'
        TabOrder = 5
        object Label118: TLabel
          Left = 10
          Top = 55
          Width = 72
          Height = 14
          Caption = 'Can Drop Price'
        end
        object Label119: TLabel
          Left = 10
          Top = 85
          Width = 70
          Height = 14
          Caption = 'Can Drop Gold'
        end
        object EditCanDropPrice: TSpinEdit
          Left = 85
          Top = 51
          Width = 67
          Height = 23
          Hint = '????????,???????,????????'
          Increment = 100
          MaxValue = 20000000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditCanDropPriceChange
        end
        object CheckBoxControlDropItem: TCheckBox
          Left = 14
          Top = 25
          Width = 138
          Height = 17
          Hint = '??????,?????????????????,?????????????????????,?????????'
          Caption = 'Control Drop Item'
          TabOrder = 1
          OnClick = CheckBoxControlDropItemClick
        end
        object EditCanDropGold: TSpinEdit
          Left = 85
          Top = 81
          Width = 67
          Height = 23
          Hint = '?????????,??????'
          Increment = 100
          MaxValue = 20000000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditCanDropGoldChange
        end
        object CheckBoxIsSafeDisableDrop: TCheckBox
          Left = 14
          Top = 115
          Width = 142
          Height = 17
          Hint = '??????,????????????'
          Caption = 'Safe Zone Disable Drop'
          TabOrder = 3
          OnClick = CheckBoxIsSafeDisableDropClick
        end
      end
    end
    object GameSpeedSheet: TTabSheet
      Caption = 'Timers'
      object GroupBox1: TGroupBox
        Left = 10
        Top = 10
        Width = 129
        Height = 213
        Caption = 'Interval Times'
        TabOrder = 0
        object Label1: TLabel
          Left = 14
          Top = 30
          Width = 12
          Height = 14
          Caption = 'Hit'
        end
        object Label2: TLabel
          Left = 14
          Top = 60
          Width = 28
          Height = 14
          Caption = 'Magic'
        end
        object Label3: TLabel
          Left = 14
          Top = 90
          Width = 19
          Height = 14
          Caption = 'Run'
        end
        object Label4: TLabel
          Left = 14
          Top = 121
          Width = 23
          Height = 14
          Caption = 'Walk'
        end
        object Label5: TLabel
          Left = 14
          Top = 181
          Width = 31
          Height = 14
          Caption = 'Dig Up'
          Enabled = False
        end
        object Label6: TLabel
          Left = 14
          Top = 151
          Width = 22
          Height = 14
          Caption = 'Turn'
        end
        object EditHitIntervalTime: TSpinEdit
          Left = 72
          Top = 25
          Width = 57
          Height = 23
          EditorEnabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 0
          Value = 900
          OnChange = EditHitIntervalTimeChange
        end
        object EditMagicHitIntervalTime: TSpinEdit
          Left = 72
          Top = 55
          Width = 57
          Height = 23
          EditorEnabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 1
          Value = 800
          OnChange = EditMagicHitIntervalTimeChange
        end
        object EditRunIntervalTime: TSpinEdit
          Left = 72
          Top = 85
          Width = 57
          Height = 23
          EditorEnabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 2
          Value = 600
          OnChange = EditRunIntervalTimeChange
        end
        object EditWalkIntervalTime: TSpinEdit
          Left = 72
          Top = 115
          Width = 57
          Height = 23
          EditorEnabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 3
          Value = 600
          OnChange = EditWalkIntervalTimeChange
        end
        object EditTurnIntervalTime: TSpinEdit
          Left = 72
          Top = 145
          Width = 57
          Height = 23
          EditorEnabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 4
          Value = 600
          OnChange = EditTurnIntervalTimeChange
        end
        object EditDigUpIntervalTime: TSpinEdit
          Left = 72
          Top = 176
          Width = 57
          Height = 23
          EditorEnabled = False
          Enabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 5
          Value = 10
          OnChange = EditWalkIntervalTimeChange
        end
      end
      object GroupBox2: TGroupBox
        Left = 141
        Top = 10
        Width = 101
        Height = 213
        Caption = 'Max Count'
        TabOrder = 1
        object Label7: TLabel
          Left = 14
          Top = 30
          Width = 12
          Height = 14
          Caption = 'Hit'
        end
        object Label8: TLabel
          Left = 14
          Top = 60
          Width = 28
          Height = 14
          Caption = 'Magic'
        end
        object Label9: TLabel
          Left = 14
          Top = 90
          Width = 19
          Height = 14
          Caption = 'Run'
        end
        object Label10: TLabel
          Left = 14
          Top = 121
          Width = 23
          Height = 14
          Caption = 'Walk'
        end
        object Label11: TLabel
          Left = 14
          Top = 181
          Width = 31
          Height = 14
          Caption = 'Dig Up'
        end
        object Label12: TLabel
          Left = 14
          Top = 151
          Width = 22
          Height = 14
          Caption = 'Turn'
        end
        object EditMaxHitMsgCount: TSpinEdit
          Left = 55
          Top = 25
          Width = 37
          Height = 23
          Hint = '????????,??????1(?????,??????????)'
          EditorEnabled = False
          MaxValue = 50
          MinValue = 1
          TabOrder = 0
          Value = 2
          OnChange = EditMaxHitMsgCountChange
        end
        object EditMaxSpellMsgCount: TSpinEdit
          Left = 55
          Top = 55
          Width = 37
          Height = 23
          Hint = '????????,??????1(?????,??????????)'
          EditorEnabled = False
          MaxValue = 50
          MinValue = 1
          TabOrder = 1
          Value = 2
          OnChange = EditMaxSpellMsgCountChange
        end
        object EditMaxRunMsgCount: TSpinEdit
          Left = 55
          Top = 85
          Width = 37
          Height = 23
          Hint = '????????,??????1(?????,??????????)'
          EditorEnabled = False
          MaxValue = 50
          MinValue = 1
          TabOrder = 2
          Value = 2
          OnChange = EditMaxRunMsgCountChange
        end
        object EditMaxWalkMsgCount: TSpinEdit
          Left = 55
          Top = 115
          Width = 37
          Height = 23
          Hint = '????????,??????1(?????,??????????)'
          EditorEnabled = False
          MaxValue = 50
          MinValue = 1
          TabOrder = 3
          Value = 2
          OnChange = EditMaxWalkMsgCountChange
        end
        object EditMaxTurnMsgCount: TSpinEdit
          Left = 55
          Top = 145
          Width = 37
          Height = 23
          Hint = '????????,??????1(?????,??????????)'
          EditorEnabled = False
          MaxValue = 50
          MinValue = 1
          TabOrder = 4
          Value = 2
          OnChange = EditMaxTurnMsgCountChange
        end
        object EditMaxDigUpMsgCount: TSpinEdit
          Left = 55
          Top = 176
          Width = 37
          Height = 23
          Hint = '????????,??????1(?????,??????????)'
          EditorEnabled = False
          MaxValue = 50
          MinValue = 1
          TabOrder = 5
          Value = 2
          OnChange = EditMaxDigUpMsgCountChange
        end
      end
      object GroupBox3: TGroupBox
        Left = 452
        Top = 90
        Width = 142
        Height = 52
        Caption = 'Item Speed'
        TabOrder = 2
        object Label13: TLabel
          Left = 24
          Top = 20
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object EditItemSpeedTime: TSpinEdit
          Left = 75
          Top = 15
          Width = 57
          Height = 23
          Hint = '????????,??????,?????'
          EditorEnabled = False
          MaxValue = 50
          MinValue = 1
          TabOrder = 0
          Value = 50
          OnChange = EditItemSpeedTimeChange
        end
      end
      object ButtonGameSpeedSave: TButton
        Left = 513
        Top = 253
        Width = 81
        Height = 31
        Caption = 'Save'
        TabOrder = 3
        OnClick = ButtonGameSpeedSaveClick
      end
      object GroupBox4: TGroupBox
        Left = 452
        Top = 10
        Width = 142
        Height = 72
        Caption = 'Mode'
        TabOrder = 4
        object RadioButtonDelyMode: TRadioButton
          Left = 10
          Top = 20
          Width = 122
          Height = 22
          Hint = '??????????????,???????,?????????????????????'
          Caption = 'Delay Mode'
          TabOrder = 0
          OnClick = RadioButtonDelyModeClick
        end
        object RadioButtonFilterMode: TRadioButton
          Left = 10
          Top = 40
          Width = 122
          Height = 21
          Hint = '??????????????,????????,??????????????????,??????'
          Caption = 'Filter Mode'
          TabOrder = 1
          OnClick = RadioButtonFilterModeClick
        end
      end
      object GroupBox7: TGroupBox
        Left = 251
        Top = 130
        Width = 163
        Height = 93
        Caption = 'Struck Time'
        TabOrder = 5
        object Label22: TLabel
          Left = 14
          Top = 20
          Width = 25
          Height = 14
          Caption = 'Time:'
        end
        object EditStruckTime: TSpinEdit
          Left = 85
          Top = 15
          Width = 67
          Height = 23
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 10
          TabOrder = 0
          Value = 100
          OnChange = EditStruckTimeChange
        end
        object CheckBoxDisableStruck: TCheckBox
          Left = 14
          Top = 46
          Width = 131
          Height = 22
          Caption = 'Disable'
          TabOrder = 1
          OnClick = CheckBoxDisableStruckClick
        end
        object CheckBoxDisableSelfStruck: TCheckBox
          Left = 14
          Top = 67
          Width = 131
          Height = 21
          Caption = 'Disable Sell'
          TabOrder = 2
          OnClick = CheckBoxDisableSelfStruckClick
        end
      end
      object GroupBox15: TGroupBox
        Left = 251
        Top = 10
        Width = 193
        Height = 120
        Caption = '??????'
        TabOrder = 6
        object Label38: TLabel
          Left = 14
          Top = 85
          Width = 34
          Height = 28
          Caption = 'Speed '#13'Kick'
        end
        object Label142: TLabel
          Left = 103
          Top = 76
          Width = 31
          Height = 42
          Caption = 'Drop'#13'Over'#13'Speed'
        end
        object EditOverSpeedKickCount: TSpinEdit
          Left = 55
          Top = 81
          Width = 37
          Height = 23
          Hint = '????,???????????'
          EditorEnabled = False
          MaxValue = 50
          MinValue = 1
          TabOrder = 0
          Value = 4
          OnChange = EditOverSpeedKickCountChange
        end
        object CheckBoxboKickOverSpeed: TCheckBox
          Left = 10
          Top = 59
          Width = 172
          Height = 22
          Hint = '????????????'
          Caption = 'Kick Over Speed'
          TabOrder = 1
          OnClick = CheckBoxboKickOverSpeedClick
        end
        object EditDropOverSpeed: TSpinEdit
          Left = 139
          Top = 81
          Width = 52
          Height = 23
          Hint = '????????,??????,?????????????????(??)'
          EditorEnabled = False
          Increment = 10
          MaxValue = 1000
          MinValue = 1
          TabOrder = 2
          Value = 50
          OnChange = EditDropOverSpeedChange
        end
        object CheckBoxSpellSendUpdateMsg: TCheckBox
          Left = 10
          Top = 19
          Width = 162
          Height = 21
          Hint = '??????????????,?????????????'
          Caption = 'Send Update Msg'
          TabOrder = 3
          OnClick = CheckBoxSpellSendUpdateMsgClick
        end
        object CheckBoxActionSendActionMsg: TCheckBox
          Left = 10
          Top = 39
          Width = 162
          Height = 21
          Hint = '??????????????,?????????????'
          Caption = 'Send Action Msg'
          TabOrder = 4
          OnClick = CheckBoxActionSendActionMsgClick
        end
      end
      object ButtonGameSpeedDefault: TButton
        Left = 422
        Top = 252
        Width = 82
        Height = 31
        Caption = 'Default'
        TabOrder = 7
        OnClick = ButtonGameSpeedDefaultClick
      end
      object ButtonActionSpeedConfig: TButton
        Left = 271
        Top = 252
        Width = 143
        Height = 31
        Caption = 'Action'
        TabOrder = 8
        OnClick = ButtonActionSpeedConfigClick
      end
      object GroupBox80: TGroupBox
        Left = 452
        Top = 151
        Width = 142
        Height = 51
        Caption = 'Sell Item'
        TabOrder = 9
        object Label150: TLabel
          Left = 14
          Top = 20
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object EditUseItemSpeedTime: TSpinEdit
          Left = 60
          Top = 15
          Width = 72
          Height = 23
          Hint = '?????????,????,????????, ????,???0????????1000??=1?'
          EditorEnabled = False
          MaxValue = 10000
          MinValue = 0
          TabOrder = 0
          Value = 1000
          OnChange = EditUseItemSpeedTimeChange
        end
      end
    end
    object TabSheet10: TTabSheet
      Caption = 'Para'
      ImageIndex = 13
      object ButtonCharStatusSave: TButton
        Left = 462
        Top = 227
        Width = 82
        Height = 31
        Caption = 'Save'
        TabOrder = 0
        OnClick = ButtonCharStatusSaveClick
      end
      object GroupBox72: TGroupBox
        Left = 10
        Top = 10
        Width = 232
        Height = 112
        Caption = 'If Para'
        TabOrder = 1
        object CheckBoxParalyCanRun: TCheckBox
          Left = 10
          Top = 20
          Width = 181
          Height = 22
          Hint = '????????????,???????'
          Caption = 'Can Run'
          TabOrder = 0
          OnClick = CheckBoxParalyCanRunClick
        end
        object CheckBoxParalyCanWalk: TCheckBox
          Left = 10
          Top = 40
          Width = 92
          Height = 21
          Hint = '????????????,???????'
          Caption = 'Can Walk'
          TabOrder = 1
          OnClick = CheckBoxParalyCanWalkClick
        end
        object CheckBoxParalyCanHit: TCheckBox
          Left = 10
          Top = 60
          Width = 92
          Height = 22
          Hint = '????????????,???????'
          Caption = 'Can Hit'
          TabOrder = 2
          OnClick = CheckBoxParalyCanHitClick
        end
        object CheckBoxParalyCanSpell: TCheckBox
          Left = 10
          Top = 81
          Width = 92
          Height = 21
          Hint = '????????????,???????'
          Caption = 'Can Use Spell'
          TabOrder = 3
          OnClick = CheckBoxParalyCanSpellClick
        end
      end
    end
    object ExpSheet: TTabSheet
      Caption = 'Exp'
      ImageIndex = 1
      object GroupBox8: TGroupBox
        Left = 232
        Top = 10
        Width = 182
        Height = 112
        Caption = 'MPlayer'
        TabOrder = 0
        object Label23: TLabel
          Left = 14
          Top = 30
          Width = 16
          Height = 14
          Caption = 'By:'
        end
        object EditKillMonExpMultiple: TSpinEdit
          Left = 55
          Top = 25
          Width = 67
          Height = 23
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditKillMonExpMultipleChange
        end
        object CheckBoxHighLevelKillMonFixExp: TCheckBox
          Left = 14
          Top = 57
          Width = 158
          Height = 21
          Caption = 'Fix High level'
          TabOrder = 1
          OnClick = CheckBoxHighLevelKillMonFixExpClick
        end
        object CheckBoxHighLevelGroupFixExp: TCheckBox
          Left = 14
          Top = 81
          Width = 158
          Height = 21
          Caption = 'GroupExp fix'
          TabOrder = 2
          OnClick = CheckBoxHighLevelGroupFixExpClick
        end
      end
      object ButtonExpSave: TButton
        Left = 503
        Top = 218
        Width = 82
        Height = 31
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonExpSaveClick
      end
      object GroupBoxLevelExp: TGroupBox
        Left = 10
        Top = 10
        Width = 213
        Height = 232
        Caption = 'Level and Exp list'
        TabOrder = 2
        object Label37: TLabel
          Left = 14
          Top = 208
          Width = 15
          Height = 14
          Caption = 'To:'
        end
        object ComboBoxLevelExp: TComboBox
          Left = 60
          Top = 201
          Width = 142
          Height = 22
          Style = csDropDownList
          ItemHeight = 14
          TabOrder = 0
          OnClick = ComboBoxLevelExpClick
        end
        object GridLevelExp: TStringGrid
          Left = 10
          Top = 20
          Width = 192
          Height = 173
          ColCount = 2
          DefaultRowHeight = 18
          RowCount = 1001
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
          TabOrder = 1
          OnSetEditText = GridLevelExpSetEditText
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
      object GroupBox74: TGroupBox
        Left = 232
        Top = 130
        Width = 202
        Height = 112
        Caption = '1000???????'
        TabOrder = 3
        object Label15: TLabel
          Left = 10
          Top = 51
          Width = 27
          Height = 14
          Caption = '????:'
        end
        object Label145: TLabel
          Left = 10
          Top = 81
          Width = 27
          Height = 14
          Caption = '????:'
        end
        object CheckBoxFixExp: TCheckBox
          Left = 10
          Top = 20
          Width = 183
          Height = 22
          Caption = '??????????'
          TabOrder = 0
          OnClick = CheckBoxFixExpClick
        end
        object SpinEditBaseExp: TSpinEdit
          Left = 81
          Top = 45
          Width = 112
          Height = 23
          Hint = '??????'
          MaxValue = 2100000000
          MinValue = 0
          TabOrder = 1
          Value = 100000000
          OnChange = SpinEditBaseExpChange
        end
        object SpinEditAddExp: TSpinEdit
          Left = 81
          Top = 78
          Width = 112
          Height = 23
          Hint = '?????????'
          MaxValue = 2100000000
          MinValue = 0
          TabOrder = 2
          Value = 1000000
          OnChange = SpinEditAddExpChange
        end
      end
      object GroupBox75: TGroupBox
        Left = 422
        Top = 10
        Width = 172
        Height = 112
        Caption = '????'
        TabOrder = 4
        object Label146: TLabel
          Left = 10
          Top = 30
          Width = 27
          Height = 14
          Caption = '????:'
        end
        object Label147: TLabel
          Left = 10
          Top = 60
          Width = 27
          Height = 14
          Caption = '????:'
        end
        object SpinEditLimitExpLevel: TSpinEdit
          Left = 81
          Top = 25
          Width = 82
          Height = 23
          Hint = '??????????,??????????????'
          EditorEnabled = False
          MaxValue = 65535
          MinValue = 1
          TabOrder = 0
          Value = 1000
          OnChange = SpinEditLimitExpLevelChange
        end
        object SpinEditLimitExpValue: TSpinEdit
          Left = 81
          Top = 55
          Width = 82
          Height = 23
          EditorEnabled = False
          MaxValue = 2100000000
          MinValue = 1
          TabOrder = 1
          Value = 1
          OnChange = SpinEditLimitExpValueChange
        end
      end
    end
    object CastleSheet: TTabSheet
      Caption = 'Castle'
      ImageIndex = 3
      object GroupBox9: TGroupBox
        Left = 10
        Top = 10
        Width = 202
        Height = 142
        Caption = 'Cost'
        TabOrder = 0
        object Label24: TLabel
          Left = 14
          Top = 20
          Width = 26
          Height = 14
          Caption = 'Door:'
        end
        object Label25: TLabel
          Left = 14
          Top = 51
          Width = 24
          Height = 14
          Caption = 'Wait:'
        end
        object Label26: TLabel
          Left = 14
          Top = 81
          Width = 37
          Height = 14
          Caption = 'Archer:'
        end
        object Label27: TLabel
          Left = 14
          Top = 111
          Width = 33
          Height = 14
          Caption = 'Guard:'
        end
        object EditRepairDoorPrice: TSpinEdit
          Left = 90
          Top = 15
          Width = 103
          Height = 23
          Increment = 10000
          MaxValue = 100000000
          MinValue = 10000
          TabOrder = 0
          Value = 2000000
          OnChange = EditRepairDoorPriceChange
        end
        object EditRepairWallPrice: TSpinEdit
          Left = 90
          Top = 45
          Width = 103
          Height = 23
          Increment = 10000
          MaxValue = 100000000
          MinValue = 10000
          TabOrder = 1
          Value = 500000
          OnChange = EditRepairWallPriceChange
        end
        object EditHireArcherPrice: TSpinEdit
          Left = 90
          Top = 75
          Width = 103
          Height = 23
          Increment = 10000
          MaxValue = 100000000
          MinValue = 10000
          TabOrder = 2
          Value = 300000
          OnChange = EditHireArcherPriceChange
        end
        object EditHireGuardPrice: TSpinEdit
          Left = 90
          Top = 106
          Width = 103
          Height = 23
          Increment = 10000
          MaxValue = 100000000
          MinValue = 10000
          TabOrder = 3
          Value = 300000
          OnChange = EditHireGuardPriceChange
        end
      end
      object GroupBox10: TGroupBox
        Left = 10
        Top = 157
        Width = 202
        Height = 85
        Caption = 'Taking'
        TabOrder = 1
        object Label31: TLabel
          Left = 14
          Top = 20
          Width = 23
          Height = 14
          Caption = 'Max:'
        end
        object Label32: TLabel
          Left = 14
          Top = 51
          Width = 28
          Height = 14
          Caption = '1Day:'
        end
        object EditCastleGoldMax: TSpinEdit
          Left = 90
          Top = 15
          Width = 103
          Height = 23
          Increment = 10000
          MaxValue = 100000000
          MinValue = 10000
          TabOrder = 0
          Value = 10000000
          OnChange = EditCastleGoldMaxChange
        end
        object EditCastleOneDayGold: TSpinEdit
          Left = 90
          Top = 45
          Width = 103
          Height = 23
          Increment = 10000
          MaxValue = 100000000
          MinValue = 10000
          TabOrder = 1
          Value = 2000000
          OnChange = EditCastleOneDayGoldChange
        end
      end
      object GroupBox11: TGroupBox
        Left = 372
        Top = 73
        Width = 152
        Height = 109
        Caption = 'Home'
        TabOrder = 2
        object Label28: TLabel
          Left = 14
          Top = 20
          Width = 23
          Height = 14
          Caption = 'Map:'
        end
        object Label29: TLabel
          Left = 14
          Top = 51
          Width = 26
          Height = 14
          Caption = 'Co X:'
        end
        object Label30: TLabel
          Left = 14
          Top = 81
          Width = 27
          Height = 14
          Caption = 'Co Y:'
        end
        object EditCastleHomeX: TSpinEdit
          Left = 70
          Top = 45
          Width = 72
          Height = 23
          MaxValue = 1000
          MinValue = 1
          TabOrder = 0
          Value = 644
          OnChange = EditCastleHomeXChange
        end
        object EditCastleHomeY: TSpinEdit
          Left = 70
          Top = 75
          Width = 72
          Height = 23
          MaxValue = 1000
          MinValue = 1
          TabOrder = 1
          Value = 290
          OnChange = EditCastleHomeYChange
        end
        object EditCastleHomeMap: TEdit
          Left = 70
          Top = 15
          Width = 72
          Height = 22
          MaxLength = 20
          TabOrder = 2
          Text = '3'
          OnChange = EditCastleHomeMapChange
        end
      end
      object GroupBox12: TGroupBox
        Left = 221
        Top = 10
        Width = 142
        Height = 79
        Caption = 'WarZone'
        TabOrder = 3
        object Label34: TLabel
          Left = 14
          Top = 20
          Width = 55
          Height = 14
          Caption = 'X Distance:'
        end
        object Label35: TLabel
          Left = 14
          Top = 51
          Width = 56
          Height = 14
          Caption = 'Y Distance:'
        end
        object EditWarRangeX: TSpinEdit
          Left = 70
          Top = 15
          Width = 62
          Height = 23
          MaxValue = 1000
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = EditWarRangeXChange
        end
        object EditWarRangeY: TSpinEdit
          Left = 70
          Top = 45
          Width = 62
          Height = 23
          MaxValue = 1000
          MinValue = 1
          TabOrder = 1
          Value = 100
          OnChange = EditWarRangeYChange
        end
      end
      object ButtonCastleSave: TButton
        Left = 462
        Top = 208
        Width = 82
        Height = 31
        Caption = '&Save'
        TabOrder = 4
        OnClick = ButtonCastleSaveClick
      end
      object GroupBox13: TGroupBox
        Left = 221
        Top = 93
        Width = 142
        Height = 79
        Caption = 'Tax'
        TabOrder = 5
        object Label36: TLabel
          Left = 14
          Top = 51
          Width = 21
          Height = 14
          Caption = 'Tax:'
        end
        object EditTaxRate: TSpinEdit
          Left = 70
          Top = 45
          Width = 62
          Height = 23
          MaxValue = 1000
          MinValue = 1
          TabOrder = 0
          Value = 5
          OnChange = EditTaxRateChange
        end
        object CheckBoxGetAllNpcTax: TCheckBox
          Left = 14
          Top = 16
          Width = 118
          Height = 22
          Caption = 'All-NPC'
          TabOrder = 1
          OnClick = CheckBoxGetAllNpcTaxClick
        end
      end
      object GroupBox14: TGroupBox
        Left = 372
        Top = 10
        Width = 152
        Height = 56
        Caption = 'Name'
        TabOrder = 6
        object Label33: TLabel
          Left = 10
          Top = 25
          Width = 30
          Height = 14
          Caption = 'Name:'
        end
        object EditCastleName: TEdit
          Left = 51
          Top = 20
          Width = 91
          Height = 22
          TabOrder = 0
          Text = '???'
          OnChange = EditCastleNameChange
        end
      end
      object GroupBox54: TGroupBox
        Left = 221
        Top = 183
        Width = 142
        Height = 59
        Caption = 'Member'
        TabOrder = 7
        object Label107: TLabel
          Left = 14
          Top = 20
          Width = 27
          Height = 14
          Caption = 'Price:'
        end
        object EditCastleMemberPriceRate: TSpinEdit
          Left = 70
          Top = 15
          Width = 62
          Height = 23
          Hint = '???????????????????????'
          MaxValue = 200
          MinValue = 10
          TabOrder = 0
          Value = 10
          OnChange = EditCastleMemberPriceRateChange
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Msg'
      ImageIndex = 8
      object GroupBox36: TGroupBox
        Left = 10
        Top = 10
        Width = 162
        Height = 92
        Caption = 'Message Options'
        TabOrder = 0
        object Label71: TLabel
          Left = 14
          Top = 30
          Width = 56
          Height = 14
          Caption = 'Max Length'
        end
        object Label72: TLabel
          Left = 14
          Top = 60
          Width = 65
          Height = 14
          Caption = 'Red Msg Max'
        end
        object EditSayMsgMaxLen: TSpinEdit
          Left = 85
          Top = 25
          Width = 67
          Height = 22
          Hint = '???????????'
          MaxValue = 255
          MinValue = 1
          TabOrder = 0
          Value = 50
          OnChange = EditSayMsgMaxLenChange
        end
        object EditSayRedMsgMaxLen: TSpinEdit
          Left = 85
          Top = 55
          Width = 67
          Height = 22
          Hint = 'GM????????????'
          MaxValue = 255
          MinValue = 1
          TabOrder = 1
          Value = 50
          OnChange = EditSayRedMsgMaxLenChange
        end
      end
      object GroupBox37: TGroupBox
        Left = 10
        Top = 111
        Width = 162
        Height = 61
        Caption = 'Can Shout'
        TabOrder = 1
        object Label73: TLabel
          Left = 14
          Top = 30
          Width = 26
          Height = 14
          Caption = 'Level'
        end
        object EditCanShoutMsgLevel: TSpinEdit
          Left = 85
          Top = 25
          Width = 67
          Height = 22
          Hint = '??????,?????????????????'
          MaxValue = 65535
          MinValue = 1
          TabOrder = 0
          Value = 50
          OnChange = EditCanShoutMsgLevelChange
        end
      end
      object GroupBox38: TGroupBox
        Left = 181
        Top = 10
        Width = 234
        Height = 82
        Caption = 'Red Message Options'
        TabOrder = 2
        object Label75: TLabel
          Left = 14
          Top = 51
          Width = 92
          Height = 14
          Caption = 'Red Msg Command'
        end
        object CheckBoxShutRedMsgShowGMName: TCheckBox
          Left = 10
          Top = 20
          Width = 206
          Height = 22
          Hint = 'GM?????????????????????'
          Caption = 'Red Msg Show Gm Name'
          TabOrder = 0
          OnClick = CheckBoxShutRedMsgShowGMNameClick
        end
        object EditGMRedMsgCmd: TEdit
          Left = 125
          Top = 46
          Width = 52
          Height = 21
          Hint = '?????????????????'#8216'!'#8217'?'
          MaxLength = 20
          TabOrder = 1
          OnChange = EditGMRedMsgCmdChange
        end
      end
      object ButtonMsgSave: TButton
        Left = 462
        Top = 208
        Width = 82
        Height = 31
        Caption = 'Save'
        TabOrder = 3
        OnClick = ButtonMsgSaveClick
      end
      object GroupBox68: TGroupBox
        Left = 181
        Top = 100
        Width = 182
        Height = 123
        Caption = 'More Message Options'
        TabOrder = 4
        object Label135: TLabel
          Left = 14
          Top = 30
          Width = 19
          Height = 14
          Caption = 'Say'
        end
        object Label138: TLabel
          Left = 14
          Top = 60
          Width = 28
          Height = 14
          Caption = 'Count'
        end
        object Label139: TLabel
          Left = 14
          Top = 90
          Width = 38
          Height = 14
          Caption = 'Disable '
        end
        object Label140: TLabel
          Left = 144
          Top = 30
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object Label141: TLabel
          Left = 144
          Top = 90
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object EditSayMsgTime: TSpinEdit
          Left = 85
          Top = 25
          Width = 57
          Height = 22
          MaxValue = 1000000
          MinValue = 1
          TabOrder = 0
          Value = 50
          OnChange = EditSayMsgTimeChange
        end
        object EditSayMsgCount: TSpinEdit
          Left = 85
          Top = 55
          Width = 57
          Height = 22
          MaxValue = 255
          MinValue = 1
          TabOrder = 1
          Value = 50
          OnChange = EditSayMsgCountChange
        end
        object EditDisableSayMsgTime: TSpinEdit
          Left = 85
          Top = 85
          Width = 57
          Height = 22
          MaxValue = 100000
          MinValue = 1
          TabOrder = 2
          Value = 50
          OnChange = EditDisableSayMsgTimeChange
        end
      end
      object GroupBox71: TGroupBox
        Left = 10
        Top = 181
        Width = 162
        Height = 61
        Caption = 'Prefix'
        TabOrder = 5
        object CheckBoxShowPreFixMsg: TCheckBox
          Left = 10
          Top = 20
          Width = 132
          Height = 22
          Hint = '?????????????????????'
          Caption = 'Show Prefix Msg'
          TabOrder = 0
          OnClick = CheckBoxShowPreFixMsgClick
        end
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'Chat'
      ImageIndex = 11
      object ButtonMsgColorSave: TButton
        Left = 462
        Top = 208
        Width = 82
        Height = 31
        Caption = '&Save'
        TabOrder = 0
        OnClick = ButtonMsgColorSaveClick
      end
      object GroupBox55: TGroupBox
        Left = 10
        Top = 10
        Width = 132
        Height = 79
        Caption = 'Talk'
        TabOrder = 1
        object Label108: TLabel
          Left = 14
          Top = 20
          Width = 17
          Height = 14
          Caption = 'FG:'
        end
        object Label109: TLabel
          Left = 14
          Top = 51
          Width = 18
          Height = 14
          Caption = 'BG:'
        end
        object LabeltHearMsgFColor: TLabel
          Left = 111
          Top = 17
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelHearMsgBColor: TLabel
          Left = 111
          Top = 47
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditHearMsgFColor: TSpinEdit
          Left = 51
          Top = 15
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditHearMsgFColorChange
        end
        object EdittHearMsgBColor: TSpinEdit
          Left = 51
          Top = 45
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EdittHearMsgBColorChange
        end
      end
      object GroupBox56: TGroupBox
        Left = 10
        Top = 90
        Width = 132
        Height = 80
        Caption = 'PM'
        TabOrder = 2
        object Label110: TLabel
          Left = 14
          Top = 20
          Width = 17
          Height = 14
          Caption = 'FG:'
        end
        object Label111: TLabel
          Left = 14
          Top = 51
          Width = 18
          Height = 14
          Caption = 'BG:'
        end
        object LabelWhisperMsgFColor: TLabel
          Left = 111
          Top = 17
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelWhisperMsgBColor: TLabel
          Left = 111
          Top = 47
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditWhisperMsgFColor: TSpinEdit
          Left = 51
          Top = 15
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditWhisperMsgFColorChange
        end
        object EditWhisperMsgBColor: TSpinEdit
          Left = 51
          Top = 45
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditWhisperMsgBColorChange
        end
      end
      object GroupBox57: TGroupBox
        Left = 10
        Top = 171
        Width = 132
        Height = 79
        Caption = 'GM PM'
        TabOrder = 3
        object Label112: TLabel
          Left = 14
          Top = 20
          Width = 17
          Height = 14
          Caption = 'FG:'
        end
        object Label113: TLabel
          Left = 14
          Top = 51
          Width = 18
          Height = 14
          Caption = 'BG:'
        end
        object LabelGMWhisperMsgFColor: TLabel
          Left = 111
          Top = 17
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelGMWhisperMsgBColor: TLabel
          Left = 111
          Top = 47
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditGMWhisperMsgFColor: TSpinEdit
          Left = 51
          Top = 15
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditGMWhisperMsgFColorChange
        end
        object EditGMWhisperMsgBColor: TSpinEdit
          Left = 51
          Top = 45
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditGMWhisperMsgBColorChange
        end
      end
      object GroupBox58: TGroupBox
        Left = 151
        Top = 10
        Width = 132
        Height = 79
        Caption = 'Red Msg'
        TabOrder = 4
        object Label116: TLabel
          Left = 14
          Top = 20
          Width = 17
          Height = 14
          Caption = 'FG:'
        end
        object Label117: TLabel
          Left = 14
          Top = 51
          Width = 18
          Height = 14
          Caption = 'BG:'
        end
        object LabelRedMsgFColor: TLabel
          Left = 111
          Top = 17
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelRedMsgBColor: TLabel
          Left = 111
          Top = 47
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditRedMsgFColor: TSpinEdit
          Left = 51
          Top = 15
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditRedMsgFColorChange
        end
        object EditRedMsgBColor: TSpinEdit
          Left = 51
          Top = 45
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditRedMsgBColorChange
        end
      end
      object GroupBox59: TGroupBox
        Left = 151
        Top = 90
        Width = 132
        Height = 80
        Caption = 'Green'
        TabOrder = 5
        object Label120: TLabel
          Left = 14
          Top = 20
          Width = 17
          Height = 14
          Caption = 'FG:'
        end
        object Label121: TLabel
          Left = 14
          Top = 51
          Width = 18
          Height = 14
          Caption = 'BG:'
        end
        object LabelGreenMsgFColor: TLabel
          Left = 111
          Top = 17
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelGreenMsgBColor: TLabel
          Left = 111
          Top = 47
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditGreenMsgFColor: TSpinEdit
          Left = 51
          Top = 15
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditGreenMsgFColorChange
        end
        object EditGreenMsgBColor: TSpinEdit
          Left = 51
          Top = 45
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditGreenMsgBColorChange
        end
      end
      object GroupBox60: TGroupBox
        Left = 151
        Top = 171
        Width = 132
        Height = 79
        Caption = 'Blue'
        TabOrder = 6
        object Label124: TLabel
          Left = 14
          Top = 20
          Width = 17
          Height = 14
          Caption = 'FG:'
        end
        object Label125: TLabel
          Left = 14
          Top = 51
          Width = 18
          Height = 14
          Caption = 'BG:'
        end
        object LabelBlueMsgFColor: TLabel
          Left = 111
          Top = 17
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelBlueMsgBColor: TLabel
          Left = 111
          Top = 47
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditBlueMsgFColor: TSpinEdit
          Left = 51
          Top = 15
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditBlueMsgFColorChange
        end
        object EditBlueMsgBColor: TSpinEdit
          Left = 51
          Top = 45
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditBlueMsgBColorChange
        end
      end
      object GroupBox61: TGroupBox
        Left = 292
        Top = 10
        Width = 131
        Height = 79
        Caption = 'Loud'
        TabOrder = 7
        object Label128: TLabel
          Left = 14
          Top = 20
          Width = 17
          Height = 14
          Caption = 'FG:'
        end
        object Label129: TLabel
          Left = 14
          Top = 51
          Width = 18
          Height = 14
          Caption = 'BG:'
        end
        object LabelCryMsgFColor: TLabel
          Left = 111
          Top = 17
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelCryMsgBColor: TLabel
          Left = 111
          Top = 47
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditCryMsgFColor: TSpinEdit
          Left = 51
          Top = 15
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditCryMsgFColorChange
        end
        object EditCryMsgBColor: TSpinEdit
          Left = 51
          Top = 45
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditCryMsgBColorChange
        end
      end
      object GroupBox62: TGroupBox
        Left = 292
        Top = 90
        Width = 131
        Height = 80
        Caption = 'Guild'
        TabOrder = 8
        object Label132: TLabel
          Left = 14
          Top = 20
          Width = 17
          Height = 14
          Caption = 'FG:'
        end
        object Label133: TLabel
          Left = 14
          Top = 51
          Width = 18
          Height = 14
          Caption = 'BG:'
        end
        object LabelGuildMsgFColor: TLabel
          Left = 111
          Top = 17
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelGuildMsgBColor: TLabel
          Left = 111
          Top = 47
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditGuildMsgFColor: TSpinEdit
          Left = 51
          Top = 15
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditGuildMsgFColorChange
        end
        object EditGuildMsgBColor: TSpinEdit
          Left = 51
          Top = 45
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditGuildMsgBColorChange
        end
      end
      object GroupBox63: TGroupBox
        Left = 292
        Top = 171
        Width = 131
        Height = 79
        Caption = 'Group'
        TabOrder = 9
        object Label136: TLabel
          Left = 14
          Top = 20
          Width = 17
          Height = 14
          Caption = 'FG:'
        end
        object Label137: TLabel
          Left = 14
          Top = 51
          Width = 18
          Height = 14
          Caption = 'BG:'
        end
        object LabelGroupMsgFColor: TLabel
          Left = 111
          Top = 17
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelGroupMsgBColor: TLabel
          Left = 111
          Top = 47
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditGroupMsgFColor: TSpinEdit
          Left = 51
          Top = 15
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditGroupMsgFColorChange
        end
        object EditGroupMsgBColor: TSpinEdit
          Left = 51
          Top = 45
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditGroupMsgBColorChange
        end
      end
      object GroupBox65: TGroupBox
        Left = 432
        Top = 10
        Width = 132
        Height = 79
        Caption = 'Group'
        TabOrder = 10
        object Label122: TLabel
          Left = 14
          Top = 20
          Width = 17
          Height = 14
          Caption = 'FG:'
        end
        object Label123: TLabel
          Left = 14
          Top = 51
          Width = 18
          Height = 14
          Caption = 'BG:'
        end
        object LabelCustMsgFColor: TLabel
          Left = 111
          Top = 17
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelCustMsgBColor: TLabel
          Left = 111
          Top = 47
          Width = 11
          Height = 22
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditCustMsgFColor: TSpinEdit
          Left = 51
          Top = 15
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditCustMsgFColorChange
        end
        object EditCustMsgBColor: TSpinEdit
          Left = 51
          Top = 45
          Width = 51
          Height = 23
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditCustMsgBColorChange
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Times'
      ImageIndex = 9
      object GroupBox39: TGroupBox
        Left = 10
        Top = 10
        Width = 132
        Height = 62
        Caption = 'Start Sabuk War'
        TabOrder = 0
        object Label74: TLabel
          Left = 14
          Top = 30
          Width = 28
          Height = 14
          Caption = 'Every'
        end
        object Label77: TLabel
          Left = 104
          Top = 30
          Width = 25
          Height = 14
          Caption = 'Days'
        end
        object EditStartCastleWarDays: TSpinEdit
          Left = 55
          Top = 25
          Width = 47
          Height = 22
          Hint = '????????,?????'
          MaxValue = 10
          MinValue = 2
          TabOrder = 0
          Value = 4
          OnChange = EditStartCastleWarDaysChange
        end
      end
      object GroupBox40: TGroupBox
        Left = 10
        Top = 81
        Width = 132
        Height = 61
        Caption = 'Start Castle War'
        TabOrder = 1
        object Label76: TLabel
          Left = 14
          Top = 30
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object Label78: TLabel
          Left = 104
          Top = 30
          Width = 15
          Height = 14
          Caption = ':00'
        end
        object EditStartCastlewarTime: TSpinEdit
          Left = 55
          Top = 25
          Width = 47
          Height = 22
          Hint = '??????,20??20:00'
          MaxValue = 24
          MinValue = 1
          TabOrder = 0
          Value = 20
          OnChange = EditStartCastlewarTimeChange
        end
      end
      object GroupBox41: TGroupBox
        Left = 10
        Top = 151
        Width = 132
        Height = 61
        Caption = 'Castle War End Msg'
        TabOrder = 2
        object Label79: TLabel
          Left = 14
          Top = 30
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object Label80: TLabel
          Left = 104
          Top = 30
          Width = 22
          Height = 14
          Caption = 'Mins'
        end
        object EditShowCastleWarEndMsgTime: TSpinEdit
          Left = 55
          Top = 25
          Width = 47
          Height = 22
          Hint = '?????????????'
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditShowCastleWarEndMsgTimeChange
        end
      end
      object GroupBox42: TGroupBox
        Left = 151
        Top = 10
        Width = 142
        Height = 62
        Caption = 'Castle War'
        TabOrder = 3
        object Label81: TLabel
          Left = 14
          Top = 30
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object Label82: TLabel
          Left = 114
          Top = 30
          Width = 22
          Height = 14
          Caption = 'Mins'
        end
        object EditCastleWarTime: TSpinEdit
          Left = 55
          Top = 25
          Width = 57
          Height = 22
          Hint = '??????,???3????'
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 180
          OnChange = EditCastleWarTimeChange
        end
      end
      object GroupBox43: TGroupBox
        Left = 151
        Top = 81
        Width = 143
        Height = 61
        Caption = 'Get Castle '
        TabOrder = 4
        object Label83: TLabel
          Left = 14
          Top = 30
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object Label84: TLabel
          Left = 104
          Top = 30
          Width = 22
          Height = 14
          Caption = 'Mins'
        end
        object EditGetCastleTime: TSpinEdit
          Left = 55
          Top = 25
          Width = 47
          Height = 22
          Hint = '??????,???????????'
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditGetCastleTimeChange
        end
      end
      object GroupBox44: TGroupBox
        Left = 302
        Top = 10
        Width = 138
        Height = 62
        Caption = 'Save Human Rcd'
        TabOrder = 5
        object Label85: TLabel
          Left = 14
          Top = 30
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object Label86: TLabel
          Left = 104
          Top = 30
          Width = 6
          Height = 14
          Caption = '?'
        end
        object EditSaveHumanRcdTime: TSpinEdit
          Left = 55
          Top = 25
          Width = 47
          Height = 22
          Hint = '?????????????'
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditSaveHumanRcdTimeChange
        end
      end
      object GroupBox45: TGroupBox
        Left = 302
        Top = 155
        Width = 138
        Height = 55
        Caption = 'Human Free Delay'
        TabOrder = 6
        object Label87: TLabel
          Left = 14
          Top = 30
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object Label88: TLabel
          Left = 104
          Top = 30
          Width = 6
          Height = 14
          Caption = '?'
        end
        object EditHumanFreeDelayTime: TSpinEdit
          Left = 55
          Top = 25
          Width = 47
          Height = 22
          Hint = '?????????????,????????,?????????'
          Enabled = False
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 5
          OnChange = EditHumanFreeDelayTimeChange
        end
      end
      object GroupBox46: TGroupBox
        Left = 16
        Top = 219
        Width = 278
        Height = 75
        Caption = 'Drops'
        TabOrder = 7
        object Label89: TLabel
          Left = 14
          Top = 22
          Width = 82
          Height = 14
          Caption = 'Make Ghost Time'
        end
        object Label91: TLabel
          Left = 14
          Top = 52
          Width = 126
          Height = 14
          Caption = 'Clear Drops On Floor Time'
        end
        object EditMakeGhostTime: TSpinEdit
          Left = 193
          Top = 16
          Width = 67
          Height = 22
          Hint = '?????????'
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 180
          OnChange = EditMakeGhostTimeChange
        end
        object EditClearDropOnFloorItemTime: TSpinEdit
          Left = 193
          Top = 46
          Width = 67
          Height = 22
          Hint = '?????????'
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 1
          Value = 3600
          OnChange = EditClearDropOnFloorItemTimeChange
        end
      end
      object GroupBox47: TGroupBox
        Left = 300
        Top = 81
        Width = 140
        Height = 61
        Caption = 'Floor Item Can Pick Up'
        TabOrder = 8
        object Label93: TLabel
          Left = 14
          Top = 30
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object Label94: TLabel
          Left = 114
          Top = 30
          Width = 16
          Height = 14
          Caption = 'Min'
        end
        object EditFloorItemCanPickUpTime: TSpinEdit
          Left = 55
          Top = 25
          Width = 57
          Height = 22
          Hint = '??????????????????'
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditFloorItemCanPickUpTimeChange
        end
      end
      object ButtonTimeSave: TButton
        Left = 501
        Top = 252
        Width = 82
        Height = 31
        Caption = 'Save'
        TabOrder = 9
        OnClick = ButtonTimeSaveClick
      end
      object GroupBox70: TGroupBox
        Left = 151
        Top = 155
        Width = 142
        Height = 57
        Caption = 'Guild War'
        TabOrder = 10
        object Label143: TLabel
          Left = 14
          Top = 30
          Width = 22
          Height = 14
          Caption = 'Time'
        end
        object Label144: TLabel
          Left = 114
          Top = 30
          Width = 22
          Height = 14
          Caption = 'Mins'
        end
        object EditGuildWarTime: TSpinEdit
          Left = 55
          Top = 25
          Width = 57
          Height = 22
          Hint = '????????'
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditGuildWarTimeChange
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Prices'
      ImageIndex = 10
      object GroupBox48: TGroupBox
        Left = 10
        Top = 10
        Width = 172
        Height = 62
        Caption = 'Build Guild'
        TabOrder = 0
        object Label95: TLabel
          Left = 14
          Top = 30
          Width = 24
          Height = 14
          Caption = 'Price'
        end
        object EditBuildGuildPrice: TSpinEdit
          Left = 55
          Top = 25
          Width = 97
          Height = 22
          Hint = '???????????'
          MaxValue = 100000000
          MinValue = 1000
          TabOrder = 0
          Value = 1000000
          OnChange = EditBuildGuildPriceChange
        end
      end
      object GroupBox49: TGroupBox
        Left = 10
        Top = 81
        Width = 172
        Height = 61
        Caption = 'Guild War'
        TabOrder = 1
        object Label96: TLabel
          Left = 14
          Top = 30
          Width = 24
          Height = 14
          Caption = 'Price'
        end
        object EditGuildWarPrice: TSpinEdit
          Left = 55
          Top = 25
          Width = 97
          Height = 22
          Hint = '???????????'
          MaxValue = 100000000
          MinValue = 1000
          TabOrder = 0
          Value = 30000
          OnChange = EditGuildWarPriceChange
        end
      end
      object GroupBox50: TGroupBox
        Left = 10
        Top = 151
        Width = 172
        Height = 61
        Caption = 'Make Drug'
        TabOrder = 2
        object Label97: TLabel
          Left = 14
          Top = 30
          Width = 24
          Height = 14
          Caption = 'Price'
        end
        object EditMakeDurgPrice: TSpinEdit
          Left = 55
          Top = 25
          Width = 97
          Height = 22
          Hint = '?????????'
          MaxValue = 100000000
          MinValue = 10
          TabOrder = 0
          Value = 100
          OnChange = EditMakeDurgPriceChange
        end
      end
      object ButtonPriceSave: TButton
        Left = 10
        Top = 218
        Width = 82
        Height = 31
        Caption = 'Save'
        TabOrder = 3
        OnClick = ButtonPriceSaveClick
      end
      object GroupBox66: TGroupBox
        Left = 191
        Top = 10
        Width = 172
        Height = 92
        Caption = 'Repair'
        TabOrder = 4
        object Label126: TLabel
          Left = 14
          Top = 30
          Width = 96
          Height = 14
          Caption = 'Special Repair Price'
        end
        object Label127: TLabel
          Left = 14
          Top = 60
          Width = 79
          Height = 14
          Caption = 'Repair Dec Dura'
        end
        object EditSuperRepairPriceRate: TSpinEdit
          Left = 115
          Top = 25
          Width = 48
          Height = 22
          Hint = '????????,??????'
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 0
          Value = 3
          OnChange = EditSuperRepairPriceRateChange
        end
        object EditRepairItemDecDura: TSpinEdit
          Left = 111
          Top = 55
          Width = 52
          Height = 22
          Hint = '??????????'
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 1
          Value = 3
          OnChange = EditRepairItemDecDuraChange
        end
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'Death Drops'
      ImageIndex = 12
      object ButtonHumanDieSave: TButton
        Left = 482
        Top = 218
        Width = 82
        Height = 31
        Caption = 'Save'
        TabOrder = 0
        OnClick = ButtonHumanDieSaveClick
      end
      object GroupBox67: TGroupBox
        Left = 10
        Top = 10
        Width = 213
        Height = 132
        Caption = 'Death Drop Options'
        TabOrder = 1
        object CheckBoxKillByMonstDropUseItem: TCheckBox
          Left = 10
          Top = 20
          Width = 189
          Height = 22
          Hint = '????????????????????????'
          Caption = 'Kill By Mob Drop User Item'
          TabOrder = 0
          OnClick = CheckBoxKillByMonstDropUseItemClick
        end
        object CheckBoxKillByHumanDropUseItem: TCheckBox
          Left = 10
          Top = 40
          Width = 181
          Height = 21
          Hint = '????????????????????????'
          Caption = 'Kill By Hum Drop User Item'
          TabOrder = 1
          OnClick = CheckBoxKillByHumanDropUseItemClick
        end
        object CheckBoxDieScatterBag: TCheckBox
          Left = 10
          Top = 60
          Width = 189
          Height = 22
          Hint = '?????????????????????'
          Caption = 'Die Scatter Bag'
          TabOrder = 2
          OnClick = CheckBoxDieScatterBagClick
        end
        object CheckBoxDieDropGold: TCheckBox
          Left = 10
          Top = 81
          Width = 189
          Height = 21
          Hint = '???????????????'
          Caption = 'Die Drop Gold'
          TabOrder = 3
          OnClick = CheckBoxDieDropGoldClick
        end
        object CheckBoxDieRedScatterBagAll: TCheckBox
          Left = 10
          Top = 100
          Width = 198
          Height = 22
          Hint = '?????????????????'
          Caption = 'Red Die Scatter All Bag'
          TabOrder = 4
          OnClick = CheckBoxDieRedScatterBagAllClick
        end
      end
      object GroupBox69: TGroupBox
        Left = 232
        Top = 10
        Width = 372
        Height = 112
        Caption = 'Rates'
        TabOrder = 2
        object Label130: TLabel
          Left = 10
          Top = 23
          Width = 85
          Height = 14
          Caption = 'Die Drop Use Item'
        end
        object Label131: TLabel
          Left = 10
          Top = 53
          Width = 107
          Height = 14
          Caption = 'Die Red Drop Use Item'
        end
        object Label134: TLabel
          Left = 10
          Top = 83
          Width = 75
          Height = 14
          Caption = 'Die Scatter Bag'
        end
        object ScrollBarDieDropUseItemRate: TScrollBar
          Left = 124
          Top = 20
          Width = 182
          Height = 22
          Hint = '??????????????,???????,?????'
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarDieDropUseItemRateChange
        end
        object EditDieDropUseItemRate: TEdit
          Left = 314
          Top = 20
          Width = 52
          Height = 20
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarDieRedDropUseItemRate: TScrollBar
          Left = 124
          Top = 51
          Width = 182
          Height = 21
          Hint = '????????????????,???????,?????'
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarDieRedDropUseItemRateChange
        end
        object EditDieRedDropUseItemRate: TEdit
          Left = 314
          Top = 51
          Width = 52
          Height = 20
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarDieScatterBagRate: TScrollBar
          Left = 124
          Top = 81
          Width = 182
          Height = 21
          Hint = '??????????????,???????,?????'
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarDieScatterBagRateChange
        end
        object EditDieScatterBagRate: TEdit
          Left = 314
          Top = 81
          Width = 52
          Height = 20
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
    end
    object TabSheet11: TTabSheet
      Caption = 'Client'
      ImageIndex = 14
      object ButtonClientlSave: TButton
        Left = 484
        Top = 218
        Width = 81
        Height = 31
        Caption = 'Save'
        TabOrder = 0
        OnClick = ButtonClientlSaveClick
      end
      object GroupBox73: TGroupBox
        Left = 10
        Top = 10
        Width = 192
        Height = 72
        Caption = 'Client Options'
        TabOrder = 1
        object CheckBoxCanOldClientLogon: TCheckBox
          Left = 10
          Top = 20
          Width = 162
          Height = 22
          Hint = '??????????????,?????,???????,??????????????'
          Caption = 'Can Login Using Old Client'
          TabOrder = 0
          OnClick = CheckBoxCanOldClientLogonClick
        end
        object CheckBoxCheckClientVersion: TCheckBox
          Left = 10
          Top = 40
          Width = 172
          Height = 21
          Hint = '???????'
          Caption = 'Check Client Version'
          TabOrder = 1
          OnClick = CheckBoxCheckClientVersionClick
        end
      end
      object GroupBox78: TGroupBox
        Left = 10
        Top = 89
        Width = 192
        Height = 63
        Caption = 'Allow Client Change Speed'
        TabOrder = 2
        object CheckBoxAllowClientChgSpeed: TCheckBox
          Left = 10
          Top = 20
          Width = 162
          Height = 22
          Hint = '?????????????'
          Caption = 'Enabled'
          TabOrder = 0
          OnClick = CheckBoxAllowClientChgSpeedClick
        end
      end
      object GroupBox79: TGroupBox
        Left = 10
        Top = 159
        Width = 192
        Height = 53
        Caption = '?????'
        TabOrder = 3
        object CheckBox1: TCheckBox
          Left = 10
          Top = 20
          Width = 162
          Height = 22
          Hint = '?????????????'
          Caption = '?????????'
          TabOrder = 0
        end
      end
      object ButtonRefClientConfig: TButton
        Left = 322
        Top = 218
        Width = 154
        Height = 31
        Caption = 'Configure'
        TabOrder = 4
        OnClick = ButtonRefClientConfigClick
      end
      object GroupBoxInfo: TGroupBox
        Left = 211
        Top = 10
        Width = 182
        Height = 56
        Caption = 'Software Version'
        TabOrder = 5
        object Label16: TLabel
          Left = 10
          Top = 25
          Width = 22
          Height = 14
          Caption = 'Date'
        end
        object EditSoftVersionDate: TEdit
          Left = 81
          Top = 20
          Width = 91
          Height = 21
          Hint = '?????????,???????????????????,????????????????????????'
          TabOrder = 0
          Text = '20020522'
          OnChange = EditSoftVersionDateChange
        end
      end
      object RadioGroupShowClientItemStyle: TRadioGroup
        Left = 211
        Top = 70
        Width = 182
        Height = 82
        Caption = 'Show Client Item Style'
        ItemIndex = 0
        Items.Strings = (
          '????'
          '????')
        TabOrder = 6
        OnClick = RadioGroupShowClientItemStyleClick
      end
      object GroupBox82: TGroupBox
        Left = 402
        Top = 10
        Width = 192
        Height = 56
        Caption = 'Green Number'
        TabOrder = 7
        object Label152: TLabel
          Left = 10
          Top = 25
          Width = 27
          Height = 14
          Caption = '????:'
        end
        object EditGreenNumber: TSpinEdit
          Left = 81
          Top = 20
          Width = 91
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = EditGreenNumberChange
        end
      end
      object GroupBox76: TGroupBox
        Left = 402
        Top = 70
        Width = 192
        Height = 52
        Caption = 'Walk Speed Rate'
        TabOrder = 8
        object ScrollBarWalkSpeedRate: TScrollBar
          Left = 10
          Top = 20
          Width = 172
          Height = 22
          Hint = '????'
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarWalkSpeedRateChange
        end
      end
      object GroupBox83: TGroupBox
        Left = 402
        Top = 130
        Width = 192
        Height = 52
        Caption = 'Attack Speed Rate'
        TabOrder = 9
        object ScrollBarAttackSpeedRate: TScrollBar
          Left = 10
          Top = 20
          Width = 172
          Height = 22
          Hint = '????'
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarAttackSpeedRateChange
        end
      end
      object GroupBox84: TGroupBox
        Left = 211
        Top = 159
        Width = 182
        Height = 53
        Caption = 'Check Speed Hack'
        TabOrder = 10
        object CheckBoxCheckSpeedHack: TCheckBox
          Left = 10
          Top = 20
          Width = 122
          Height = 22
          Hint = '????????'
          Caption = 'Enabled'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = CheckBoxCheckSpeedHackClick
        end
      end
    end
  end
end
