object frmGeneralConfig: TfrmGeneralConfig
  Left = 217
  Top = 169
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'General Options'
  ClientHeight = 356
  ClientWidth = 526
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
  TextHeight = 14
  object PageControl: TPageControl
    Left = 10
    Top = 10
    Width = 504
    Height = 313
    ActivePage = ServerInfoSheet
    TabOrder = 0
    OnChanging = PageControlChanging
    object NetWorkSheet: TTabSheet
      Caption = 'Network'
      ImageIndex = 2
      object GroupBoxNet: TGroupBox
        Left = 10
        Top = 6
        Width = 232
        Height = 86
        Caption = 'Gate'
        TabOrder = 0
        object LabelGateIPaddr: TLabel
          Left = 10
          Top = 25
          Width = 45
          Height = 14
          Caption = 'Address:'
        end
        object LabelGatePort: TLabel
          Left = 10
          Top = 55
          Width = 48
          Height = 14
          Caption = 'Gate port:'
        end
        object EditGateAddr: TEdit
          Left = 100
          Top = 20
          Width = 123
          Height = 22
          Hint = '??????????IP,????????IP??,?????????0.0.0.0?'
          TabOrder = 0
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
        object EditGatePort: TEdit
          Left = 100
          Top = 51
          Width = 52
          Height = 22
          Hint = '????????,??????5000?'
          TabOrder = 1
          Text = '5000'
          OnChange = EditValueChange
        end
      end
      object ButtonNetWorkSave: TButton
        Left = 402
        Top = 238
        Width = 82
        Height = 31
        Caption = 'Save (&S)'
        TabOrder = 1
        OnClick = ButtonNetWorkSaveClick
      end
      object GroupBox1: TGroupBox
        Left = 10
        Top = 97
        Width = 232
        Height = 85
        Caption = 'Database Server Configuration'
        TabOrder = 2
        object Label4: TLabel
          Left = 10
          Top = 55
          Width = 72
          Height = 14
          Caption = 'DBServer Port:'
        end
        object Label5: TLabel
          Left = 10
          Top = 25
          Width = 61
          Height = 14
          Caption = 'DBServer IP:'
        end
        object EditDBPort: TEdit
          Left = 100
          Top = 51
          Width = 52
          Height = 22
          Hint = 'Enter The Database Server Port...'
          TabOrder = 0
          Text = '6000'
          OnChange = EditValueChange
        end
        object EditDBAddr: TEdit
          Left = 100
          Top = 20
          Width = 123
          Height = 22
          Hint = 'Enter The Database Server IP Address...'
          TabOrder = 1
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
      end
      object GroupBox2: TGroupBox
        Left = 251
        Top = 6
        Width = 233
        Height = 86
        Caption = 'Login Server Configuration'
        TabOrder = 3
        object Label2: TLabel
          Left = 10
          Top = 55
          Width = 68
          Height = 14
          Caption = 'LoginSrv Port:'
        end
        object Label3: TLabel
          Left = 10
          Top = 25
          Width = 57
          Height = 14
          Caption = 'LoginSrv IP:'
        end
        object EditIDSPort: TEdit
          Left = 100
          Top = 51
          Width = 52
          Height = 22
          Hint = 'Enter The Login Server Port...'
          TabOrder = 0
          Text = '5600'
          OnChange = EditValueChange
        end
        object EditIDSAddr: TEdit
          Left = 100
          Top = 20
          Width = 123
          Height = 22
          Hint = 'Enter The Login Server IP Address...'
          TabOrder = 1
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
      end
      object GroupBox3: TGroupBox
        Left = 251
        Top = 97
        Width = 233
        Height = 85
        Caption = 'Log Server Configuration'
        TabOrder = 4
        object Label6: TLabel
          Left = 10
          Top = 55
          Width = 76
          Height = 14
          Caption = 'LogServer Port:'
        end
        object Label7: TLabel
          Left = 10
          Top = 25
          Width = 65
          Height = 14
          Caption = 'LogServer IP:'
        end
        object EditLogServerPort: TEdit
          Left = 100
          Top = 51
          Width = 52
          Height = 22
          Hint = 'Enter The Log Server Port...'
          TabOrder = 0
          Text = '10000'
          OnChange = EditValueChange
        end
        object EditLogServerAddr: TEdit
          Left = 100
          Top = 20
          Width = 123
          Height = 22
          Hint = 'Enter The Log Server IP Address...'
          TabOrder = 1
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
      end
      object GroupBox4: TGroupBox
        Left = 10
        Top = 187
        Width = 232
        Height = 85
        Caption = 'Message Server Configuration'
        TabOrder = 5
        object Label8: TLabel
          Left = 10
          Top = 55
          Width = 78
          Height = 14
          Caption = 'MsgServer Port:'
        end
        object Label9: TLabel
          Left = 10
          Top = 25
          Width = 67
          Height = 14
          Caption = 'MsgServer IP:'
        end
        object EditMsgSrvPort: TEdit
          Left = 100
          Top = 51
          Width = 52
          Height = 22
          Hint = 'Enter The Message Server Port...'
          TabOrder = 0
          Text = '4900'
          OnChange = EditValueChange
        end
        object EditMsgSrvAddr: TEdit
          Left = 100
          Top = 20
          Width = 123
          Height = 22
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
        Left = 10
        Top = 6
        Width = 232
        Height = 122
        Caption = 'Server'
        TabOrder = 0
        object Label1: TLabel
          Left = 10
          Top = 25
          Width = 30
          Height = 14
          Caption = 'Name:'
        end
        object Label10: TLabel
          Left = 10
          Top = 55
          Width = 29
          Height = 14
          Caption = 'Index:'
        end
        object Label11: TLabel
          Left = 121
          Top = 55
          Width = 40
          Height = 14
          Caption = 'Number:'
        end
        object EditGameName: TEdit
          Left = 81
          Top = 20
          Width = 142
          Height = 22
          Hint = '????????'
          TabOrder = 0
          Text = '????'
          OnChange = EditValueChange
        end
        object EditServerIndex: TEdit
          Left = 81
          Top = 51
          Width = 31
          Height = 22
          Hint = '???????,?????????????,???????0?'
          TabOrder = 1
          Text = '0'
          OnChange = EditValueChange
        end
        object EditServerNumber: TEdit
          Left = 191
          Top = 51
          Width = 32
          Height = 22
          Hint = '??????,??????'
          TabOrder = 2
          Text = '0'
          OnChange = EditValueChange
        end
        object CheckBoxServiceMode: TCheckBox
          Left = 130
          Top = 81
          Width = 93
          Height = 21
          Hint = '????,?????????????'
          Caption = '????'
          TabOrder = 3
          Visible = False
          OnClick = EditValueChange
        end
        object CheckBoxMinimize: TCheckBox
          Left = 10
          Top = 81
          Width = 172
          Height = 21
          Caption = '????????'
          TabOrder = 4
          OnClick = CheckBoxMinimizeClick
        end
      end
      object GroupBox5: TGroupBox
        Left = 251
        Top = 6
        Width = 193
        Height = 122
        TabOrder = 1
        Visible = False
        object Label12: TLabel
          Left = 10
          Top = 25
          Width = 27
          Height = 14
          Caption = '????:'
        end
        object Label13: TLabel
          Left = 10
          Top = 55
          Width = 27
          Height = 14
          Caption = '????:'
        end
        object Label14: TLabel
          Left = 10
          Top = 85
          Width = 27
          Height = 14
          Caption = '????:'
        end
        object EditTestLevel: TEdit
          Left = 81
          Top = 20
          Width = 91
          Height = 22
          Hint = '????,???????'
          TabOrder = 0
          Text = '0'
          OnChange = EditValueChange
        end
        object EditTestGold: TEdit
          Left = 81
          Top = 51
          Width = 91
          Height = 22
          Hint = '????,????????'
          TabOrder = 1
          Text = '0'
          OnChange = EditValueChange
        end
        object EditTestUserLimit: TEdit
          Left = 81
          Top = 81
          Width = 91
          Height = 22
          Hint = '????,???????'
          TabOrder = 2
          Text = '0'
          OnChange = EditValueChange
        end
        object CheckBoxTestServer: TCheckBox
          Left = 10
          Top = -2
          Width = 92
          Height = 21
          Hint = '????,?????,?????????????????'
          Caption = '????'
          TabOrder = 3
          OnClick = CheckBoxTestServerClick
        end
      end
      object ButtonServerInfoSave: TButton
        Left = 402
        Top = 238
        Width = 82
        Height = 31
        Caption = '&Save'
        TabOrder = 2
        OnClick = ButtonServerInfoSaveClick
      end
      object GroupBox6: TGroupBox
        Left = 10
        Top = 141
        Width = 232
        Height = 61
        Caption = '??????'
        TabOrder = 3
        Visible = False
        object Label15: TLabel
          Left = 10
          Top = 25
          Width = 27
          Height = 14
          Caption = '????:'
        end
        object EditUserFull: TEdit
          Left = 81
          Top = 20
          Width = 51
          Height = 22
          Hint = '????????????'
          TabOrder = 0
          Text = '1000'
          OnChange = EditValueChange
        end
      end
      object GroupBox7: TGroupBox
        Left = 10
        Top = 211
        Width = 232
        Height = 61
        Caption = 'DB Name'
        TabOrder = 4
        object Label16: TLabel
          Left = 10
          Top = 25
          Width = 30
          Height = 14
          Caption = 'Name:'
        end
        object EditDBName: TEdit
          Left = 81
          Top = 20
          Width = 91
          Height = 22
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
        Left = 10
        Top = 15
        Width = 40
        Height = 14
        Caption = 'GuildDir:'
      end
      object Label18: TLabel
        Left = 10
        Top = 45
        Width = 39
        Height = 14
        Caption = 'GuildLs:'
      end
      object Label24: TLabel
        Left = 10
        Top = 226
        Width = 37
        Height = 14
        BiDiMode = bdRightToLeft
        Caption = 'Plugins:'
        ParentBiDiMode = False
      end
      object Label23: TLabel
        Left = 10
        Top = 196
        Width = 27
        Height = 14
        Caption = 'Notic:'
      end
      object Label22: TLabel
        Left = 10
        Top = 166
        Width = 36
        Height = 14
        Caption = 'MapDir:'
      end
      object Label21: TLabel
        Left = 10
        Top = 136
        Width = 27
        Height = 14
        Caption = 'Envir:'
      end
      object Label20: TLabel
        Left = 10
        Top = 106
        Width = 33
        Height = 14
        Caption = 'Castle:'
      end
      object Label19: TLabel
        Left = 10
        Top = 75
        Width = 41
        Height = 14
        Caption = 'ConnDir:'
      end
      object Label25: TLabel
        Left = 10
        Top = 256
        Width = 42
        Height = 14
        BiDiMode = bdRightToLeft
        Caption = 'Venture:'
        ParentBiDiMode = False
      end
      object EditGuildDir: TEdit
        Left = 81
        Top = 10
        Width = 302
        Height = 22
        Hint = '?????????'
        TabOrder = 0
        OnChange = EditValueChange
      end
      object EditGuildFile: TEdit
        Left = 81
        Top = 40
        Width = 302
        Height = 22
        Hint = '??????????'
        TabOrder = 1
        OnChange = EditValueChange
      end
      object EditConLogDir: TEdit
        Left = 81
        Top = 70
        Width = 302
        Height = 22
        Hint = '?????????????'
        TabOrder = 2
        OnChange = EditValueChange
      end
      object EditCastleDir: TEdit
        Left = 81
        Top = 100
        Width = 302
        Height = 22
        TabOrder = 3
        OnChange = EditValueChange
      end
      object EditEnvirDir: TEdit
        Left = 81
        Top = 130
        Width = 302
        Height = 22
        TabOrder = 4
        OnChange = EditValueChange
      end
      object EditMapDir: TEdit
        Left = 81
        Top = 160
        Width = 302
        Height = 22
        TabOrder = 5
        OnChange = EditValueChange
      end
      object EditNoticeDir: TEdit
        Left = 81
        Top = 191
        Width = 302
        Height = 22
        TabOrder = 6
        OnChange = EditValueChange
      end
      object EditPlugDir: TEdit
        Left = 81
        Top = 221
        Width = 302
        Height = 22
        TabOrder = 7
        OnChange = EditValueChange
      end
      object EditVentureDir: TEdit
        Left = 81
        Top = 251
        Width = 302
        Height = 22
        TabOrder = 8
        OnChange = EditValueChange
      end
      object ButtonShareDirSave: TButton
        Left = 402
        Top = 238
        Width = 82
        Height = 31
        Caption = '&Save'
        TabOrder = 9
        OnClick = ButtonShareDirSaveClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Tips'
      ImageIndex = 3
      object GroupBox8: TGroupBox
        Left = 10
        Top = 10
        Width = 243
        Height = 153
        Caption = 'Colour'
        TabOrder = 0
        object ColorBoxHint: TColorBox
          Left = 10
          Top = 20
          Width = 142
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
