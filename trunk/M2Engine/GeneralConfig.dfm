object frmGeneralConfig: TfrmGeneralConfig
  Left = 386
  Top = 203
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'General Options'
  ClientHeight = 331
  ClientWidth = 488
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label26: TLabel
    Left = 12
    Top = 308
    Width = 204
    Height = 17
    Caption = '???????????,??????????????'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = '??'
    Font.Style = []
    ParentFont = False
  end
  object PageControl: TPageControl
    Left = 9
    Top = 9
    Width = 468
    Height = 291
    ActivePage = ServerInfoSheet
    TabOrder = 0
    OnChanging = PageControlChanging
    object NetWorkSheet: TTabSheet
      Caption = 'Network'
      ImageIndex = 2
      object GroupBoxNet: TGroupBox
        Left = 9
        Top = 6
        Width = 216
        Height = 79
        Caption = '????'
        TabOrder = 0
        object LabelGateIPaddr: TLabel
          Left = 9
          Top = 23
          Width = 24
          Height = 13
          Caption = '????:'
        end
        object LabelGatePort: TLabel
          Left = 9
          Top = 51
          Width = 24
          Height = 13
          Caption = '????:'
        end
        object EditGateAddr: TEdit
          Left = 93
          Top = 19
          Width = 114
          Height = 21
          Hint = '??????????IP,????????IP??,?????????0.0.0.0?'
          TabOrder = 0
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
        object EditGatePort: TEdit
          Left = 93
          Top = 47
          Width = 48
          Height = 21
          Hint = '????????,??????5000?'
          TabOrder = 1
          Text = '5000'
          OnChange = EditValueChange
        end
      end
      object ButtonNetWorkSave: TButton
        Left = 373
        Top = 221
        Width = 76
        Height = 29
        Caption = 'Save (&S)'
        TabOrder = 1
        OnClick = ButtonNetWorkSaveClick
      end
      object GroupBox1: TGroupBox
        Left = 9
        Top = 90
        Width = 216
        Height = 79
        Caption = 'Database Server Configuration'
        TabOrder = 2
        object Label4: TLabel
          Left = 9
          Top = 51
          Width = 72
          Height = 13
          Caption = 'DBServer Port:'
        end
        object Label5: TLabel
          Left = 9
          Top = 23
          Width = 62
          Height = 13
          Caption = 'DBServer IP:'
        end
        object EditDBPort: TEdit
          Left = 93
          Top = 47
          Width = 48
          Height = 21
          Hint = 'Enter The Database Server Port...'
          TabOrder = 0
          Text = '6000'
          OnChange = EditValueChange
        end
        object EditDBAddr: TEdit
          Left = 93
          Top = 19
          Width = 114
          Height = 21
          Hint = 'Enter The Database Server IP Address...'
          TabOrder = 1
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
      end
      object GroupBox2: TGroupBox
        Left = 233
        Top = 6
        Width = 216
        Height = 79
        Caption = 'Login Server Configuration'
        TabOrder = 3
        object Label2: TLabel
          Left = 9
          Top = 51
          Width = 68
          Height = 13
          Caption = 'LoginSrv Port:'
        end
        object Label3: TLabel
          Left = 9
          Top = 23
          Width = 58
          Height = 13
          Caption = 'LoginSrv IP:'
        end
        object EditIDSPort: TEdit
          Left = 93
          Top = 47
          Width = 48
          Height = 21
          Hint = 'Enter The Login Server Port...'
          TabOrder = 0
          Text = '5600'
          OnChange = EditValueChange
        end
        object EditIDSAddr: TEdit
          Left = 93
          Top = 19
          Width = 114
          Height = 21
          Hint = 'Enter The Login Server IP Address...'
          TabOrder = 1
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
      end
      object GroupBox3: TGroupBox
        Left = 233
        Top = 90
        Width = 216
        Height = 79
        Caption = 'Log Server Configuration'
        TabOrder = 4
        object Label6: TLabel
          Left = 9
          Top = 51
          Width = 76
          Height = 13
          Caption = 'LogServer Port:'
        end
        object Label7: TLabel
          Left = 9
          Top = 23
          Width = 66
          Height = 13
          Caption = 'LogServer IP:'
        end
        object EditLogServerPort: TEdit
          Left = 93
          Top = 47
          Width = 48
          Height = 21
          Hint = 'Enter The Log Server Port...'
          TabOrder = 0
          Text = '10000'
          OnChange = EditValueChange
        end
        object EditLogServerAddr: TEdit
          Left = 93
          Top = 19
          Width = 114
          Height = 21
          Hint = 'Enter The Log Server IP Address...'
          TabOrder = 1
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
      end
      object GroupBox4: TGroupBox
        Left = 9
        Top = 174
        Width = 216
        Height = 79
        Caption = 'Message Server Configuration'
        TabOrder = 5
        object Label8: TLabel
          Left = 9
          Top = 51
          Width = 78
          Height = 13
          Caption = 'MsgServer Port:'
        end
        object Label9: TLabel
          Left = 9
          Top = 23
          Width = 68
          Height = 13
          Caption = 'MsgServer IP:'
        end
        object EditMsgSrvPort: TEdit
          Left = 93
          Top = 47
          Width = 48
          Height = 21
          Hint = 'Enter The Message Server Port...'
          TabOrder = 0
          Text = '4900'
          OnChange = EditValueChange
        end
        object EditMsgSrvAddr: TEdit
          Left = 93
          Top = 19
          Width = 114
          Height = 21
          Hint = 
            'Enter The Message Server IP Address, For Multiple Servers Enter ' +
            'The IP Address of The First Server...'
          TabOrder = 1
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
      end
    end
    object ServerInfoSheet: TTabSheet
      Caption = 'Server Configuration'
      object GroupBoxInfo: TGroupBox
        Left = 9
        Top = 6
        Width = 216
        Height = 113
        Caption = '????'
        TabOrder = 0
        object Label1: TLabel
          Left = 9
          Top = 23
          Width = 24
          Height = 13
          Caption = '????:'
        end
        object Label10: TLabel
          Left = 9
          Top = 51
          Width = 24
          Height = 13
          Caption = '????:'
        end
        object Label11: TLabel
          Left = 112
          Top = 51
          Width = 24
          Height = 13
          Caption = '????:'
        end
        object EditGameName: TEdit
          Left = 75
          Top = 19
          Width = 132
          Height = 21
          Hint = '????????'
          TabOrder = 0
          Text = '????'
          OnChange = EditValueChange
        end
        object EditServerIndex: TEdit
          Left = 75
          Top = 47
          Width = 29
          Height = 21
          Hint = '???????,?????????????,???????0?'
          TabOrder = 1
          Text = '0'
          OnChange = EditValueChange
        end
        object EditServerNumber: TEdit
          Left = 177
          Top = 47
          Width = 30
          Height = 21
          Hint = '??????,??????'
          TabOrder = 2
          Text = '0'
          OnChange = EditValueChange
        end
        object CheckBoxServiceMode: TCheckBox
          Left = 121
          Top = 75
          Width = 86
          Height = 20
          Hint = '????,?????????????'
          Caption = '????'
          TabOrder = 3
          Visible = False
          OnClick = EditValueChange
        end
        object CheckBoxMinimize: TCheckBox
          Left = 9
          Top = 75
          Width = 160
          Height = 20
          Caption = '????????'
          TabOrder = 4
          OnClick = CheckBoxMinimizeClick
        end
      end
      object GroupBox5: TGroupBox
        Left = 233
        Top = 6
        Width = 179
        Height = 113
        TabOrder = 1
        Visible = False
        object Label12: TLabel
          Left = 9
          Top = 23
          Width = 24
          Height = 13
          Caption = '????:'
        end
        object Label13: TLabel
          Left = 9
          Top = 51
          Width = 24
          Height = 13
          Caption = '????:'
        end
        object Label14: TLabel
          Left = 9
          Top = 79
          Width = 24
          Height = 13
          Caption = '????:'
        end
        object EditTestLevel: TEdit
          Left = 75
          Top = 19
          Width = 85
          Height = 21
          Hint = '????,???????'
          TabOrder = 0
          Text = '0'
          OnChange = EditValueChange
        end
        object EditTestGold: TEdit
          Left = 75
          Top = 47
          Width = 85
          Height = 21
          Hint = '????,????????'
          TabOrder = 1
          Text = '0'
          OnChange = EditValueChange
        end
        object EditTestUserLimit: TEdit
          Left = 75
          Top = 75
          Width = 85
          Height = 21
          Hint = '????,???????'
          TabOrder = 2
          Text = '0'
          OnChange = EditValueChange
        end
        object CheckBoxTestServer: TCheckBox
          Left = 9
          Top = -2
          Width = 86
          Height = 20
          Hint = '????,?????,?????????????????'
          Caption = '????'
          TabOrder = 3
          OnClick = CheckBoxTestServerClick
        end
      end
      object ButtonServerInfoSave: TButton
        Left = 373
        Top = 221
        Width = 76
        Height = 29
        Caption = '??(&S)'
        TabOrder = 2
        OnClick = ButtonServerInfoSaveClick
      end
      object GroupBox6: TGroupBox
        Left = 9
        Top = 131
        Width = 216
        Height = 57
        Caption = '??????'
        TabOrder = 3
        Visible = False
        object Label15: TLabel
          Left = 9
          Top = 23
          Width = 24
          Height = 13
          Caption = '????:'
        end
        object EditUserFull: TEdit
          Left = 75
          Top = 19
          Width = 48
          Height = 21
          Hint = '????????????'
          TabOrder = 0
          Text = '1000'
          OnChange = EditValueChange
        end
      end
      object GroupBox7: TGroupBox
        Left = 9
        Top = 196
        Width = 216
        Height = 57
        Caption = '???????'
        TabOrder = 4
        object Label16: TLabel
          Left = 9
          Top = 23
          Width = 24
          Height = 13
          Caption = '????:'
        end
        object EditDBName: TEdit
          Left = 75
          Top = 19
          Width = 85
          Height = 21
          TabOrder = 0
          Text = 'HeroDB'
          OnChange = EditValueChange
        end
      end
    end
    object ShareSheet: TTabSheet
      Caption = 'Directories'
      ImageIndex = 1
      object Label17: TLabel
        Left = 9
        Top = 14
        Width = 24
        Height = 13
        Caption = '????:'
      end
      object Label18: TLabel
        Left = 9
        Top = 42
        Width = 24
        Height = 13
        Caption = '????:'
      end
      object Label24: TLabel
        Left = 9
        Top = 210
        Width = 24
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = '????:'
        ParentBiDiMode = False
      end
      object Label23: TLabel
        Left = 9
        Top = 182
        Width = 24
        Height = 13
        Caption = '????:'
      end
      object Label22: TLabel
        Left = 9
        Top = 154
        Width = 24
        Height = 13
        Caption = '????:'
      end
      object Label21: TLabel
        Left = 9
        Top = 126
        Width = 24
        Height = 13
        Caption = '????:'
      end
      object Label20: TLabel
        Left = 9
        Top = 98
        Width = 24
        Height = 13
        Caption = '????:'
      end
      object Label19: TLabel
        Left = 9
        Top = 70
        Width = 24
        Height = 13
        Caption = '????:'
      end
      object Label25: TLabel
        Left = 9
        Top = 238
        Width = 42
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Venture:'
        ParentBiDiMode = False
      end
      object EditGuildDir: TEdit
        Left = 75
        Top = 9
        Width = 281
        Height = 21
        Hint = '?????????'
        TabOrder = 0
        OnChange = EditValueChange
      end
      object EditGuildFile: TEdit
        Left = 75
        Top = 37
        Width = 281
        Height = 21
        Hint = '??????????'
        TabOrder = 1
        OnChange = EditValueChange
      end
      object EditConLogDir: TEdit
        Left = 75
        Top = 65
        Width = 281
        Height = 21
        Hint = '?????????????'
        TabOrder = 2
        OnChange = EditValueChange
      end
      object EditCastleDir: TEdit
        Left = 75
        Top = 93
        Width = 281
        Height = 21
        TabOrder = 3
        OnChange = EditValueChange
      end
      object EditEnvirDir: TEdit
        Left = 75
        Top = 121
        Width = 281
        Height = 21
        TabOrder = 4
        OnChange = EditValueChange
      end
      object EditMapDir: TEdit
        Left = 75
        Top = 149
        Width = 281
        Height = 21
        TabOrder = 5
        OnChange = EditValueChange
      end
      object EditNoticeDir: TEdit
        Left = 75
        Top = 177
        Width = 281
        Height = 21
        TabOrder = 6
        OnChange = EditValueChange
      end
      object EditPlugDir: TEdit
        Left = 75
        Top = 205
        Width = 281
        Height = 21
        TabOrder = 7
        OnChange = EditValueChange
      end
      object EditVentureDir: TEdit
        Left = 75
        Top = 233
        Width = 281
        Height = 21
        TabOrder = 8
        OnChange = EditValueChange
      end
      object ButtonShareDirSave: TButton
        Left = 373
        Top = 221
        Width = 76
        Height = 29
        Caption = '??(&S)'
        TabOrder = 9
        OnClick = ButtonShareDirSaveClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = '????'
      ImageIndex = 3
      object GroupBox8: TGroupBox
        Left = 9
        Top = 9
        Width = 226
        Height = 142
        Caption = '??????'
        TabOrder = 0
        object ColorBoxHint: TColorBox
          Left = 9
          Top = 19
          Width = 132
          Height = 22
          Hint = '?????????'
          ItemHeight = 16
          TabOrder = 0
          OnChange = ColorBoxHintChange
        end
      end
    end
  end
end
