object frmMain: TfrmMain
  Left = 366
  Top = 134
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Mir2: Heroes Game Center - www.lomcn.co.uk'
  ClientHeight = 376
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 520
    Height = 360
    ActivePage = TabSheet1
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    HotTrack = True
    ParentFont = False
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Main'
      object GroupBox5: TGroupBox
        Left = 8
        Top = 8
        Width = 497
        Height = 313
        Caption = 'Server Components'
        TabOrder = 0
        object EditM2ServerProgram: TEdit
          Left = 472
          Top = 64
          Width = 297
          Height = 23
          ReadOnly = True
          TabOrder = 0
          Visible = False
        end
        object EditDBServerProgram: TEdit
          Left = 472
          Top = 16
          Width = 297
          Height = 23
          ReadOnly = True
          TabOrder = 1
          Visible = False
        end
        object EditLoginSrvProgram: TEdit
          Left = 472
          Top = 40
          Width = 297
          Height = 23
          ReadOnly = True
          TabOrder = 2
          Visible = False
        end
        object EditLogServerProgram: TEdit
          Left = 472
          Top = 88
          Width = 297
          Height = 23
          ReadOnly = True
          TabOrder = 3
          Visible = False
        end
        object EditLoginGateProgram: TEdit
          Left = 472
          Top = 112
          Width = 297
          Height = 23
          ReadOnly = True
          TabOrder = 4
          Visible = False
        end
        object EditSelGateProgram: TEdit
          Left = 472
          Top = 136
          Width = 297
          Height = 23
          ReadOnly = True
          TabOrder = 5
          Visible = False
        end
        object EditRunGateProgram: TEdit
          Left = 472
          Top = 160
          Width = 297
          Height = 23
          ReadOnly = True
          TabOrder = 6
          Visible = False
        end
        object ButtonStartGame: TButton
          Left = 176
          Top = 272
          Width = 145
          Height = 33
          Caption = '&Start Server'
          TabOrder = 7
          OnClick = ButtonStartGameClick
        end
        object CheckBoxM2Server: TCheckBox
          Left = 8
          Top = 36
          Width = 161
          Height = 17
          Caption = 'M2Server'
          TabOrder = 8
          OnClick = CheckBoxM2ServerClick
        end
        object CheckBoxDBServer: TCheckBox
          Left = 8
          Top = 20
          Width = 177
          Height = 17
          Caption = 'DBServer'
          TabOrder = 9
          OnClick = CheckBoxDBServerClick
        end
        object CheckBoxLoginServer: TCheckBox
          Left = 184
          Top = 20
          Width = 177
          Height = 17
          Caption = 'LoginSrv'
          TabOrder = 10
          OnClick = CheckBoxLoginServerClick
        end
        object CheckBoxLogServer: TCheckBox
          Left = 184
          Top = 36
          Width = 177
          Height = 17
          Caption = 'LogServer'
          TabOrder = 11
          OnClick = CheckBoxLogServerClick
        end
        object CheckBoxLoginGate: TCheckBox
          Left = 8
          Top = 52
          Width = 161
          Height = 17
          Caption = 'LoginGate'
          TabOrder = 12
          OnClick = CheckBoxLoginGateClick
        end
        object CheckBoxSelGate: TCheckBox
          Left = 184
          Top = 52
          Width = 161
          Height = 17
          Caption = 'SelGate'
          TabOrder = 13
          OnClick = CheckBoxSelGateClick
        end
        object CheckBoxRunGate: TCheckBox
          Left = 8
          Top = 68
          Width = 161
          Height = 17
          Caption = 'Rungate'
          TabOrder = 14
          OnClick = CheckBoxRunGateClick
        end
        object EditRunGate1Program: TEdit
          Left = 472
          Top = 184
          Width = 297
          Height = 23
          ReadOnly = True
          TabOrder = 15
          Visible = False
        end
        object EditRunGate2Program: TEdit
          Left = 472
          Top = 208
          Width = 297
          Height = 23
          ReadOnly = True
          TabOrder = 16
          Visible = False
        end
        object MemoLog: TMemo
          Left = 8
          Top = 152
          Width = 473
          Height = 105
          Color = clNone
          Font.Charset = ANSI_CHARSET
          Font.Color = clLime
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 17
          OnChange = MemoLogChange
        end
      end
    end
    object TabSheet15: TTabSheet
      Caption = 'Account'
      ImageIndex = 5
      object GroupBox25: TGroupBox
        Left = 8
        Top = 8
        Width = 497
        Height = 321
        Caption = 'Account Management'
        TabOrder = 0
        object Label30: TLabel
          Left = 16
          Top = 24
          Width = 46
          Height = 15
          Caption = 'Account:'
        end
        object EditSearchLoginAccount: TEdit
          Left = 72
          Top = 20
          Width = 105
          Height = 23
          TabOrder = 0
        end
        object ButtonSearchLoginAccount: TButton
          Left = 184
          Top = 16
          Width = 65
          Height = 25
          Caption = '&Search'
          TabOrder = 1
          OnClick = ButtonSearchLoginAccountClick
        end
        object GroupBox26: TGroupBox
          Left = 8
          Top = 48
          Width = 481
          Height = 265
          Caption = 'Account Details'
          TabOrder = 2
          object Label31: TLabel
            Left = 55
            Top = 16
            Width = 15
            Height = 15
            Alignment = taRightJustify
            Caption = 'ID:'
          end
          object Label32: TLabel
            Left = 235
            Top = 16
            Width = 27
            Height = 15
            Alignment = taRightJustify
            Caption = #23494#30721':'
          end
          object Label33: TLabel
            Left = 19
            Top = 40
            Width = 51
            Height = 15
            Alignment = taRightJustify
            Caption = #29992#25143#21517#31216':'
          end
          object Label34: TLabel
            Left = 211
            Top = 40
            Width = 51
            Height = 15
            Alignment = taRightJustify
            Caption = #36523#20221#35777#21495':'
          end
          object Label35: TLabel
            Left = 43
            Top = 64
            Width = 27
            Height = 15
            Alignment = taRightJustify
            Caption = #29983#26085':'
          end
          object Label36: TLabel
            Left = 31
            Top = 136
            Width = 39
            Height = 15
            Alignment = taRightJustify
            Caption = #38382#39064#19968':'
          end
          object Label37: TLabel
            Left = 31
            Top = 160
            Width = 39
            Height = 15
            Alignment = taRightJustify
            Caption = #31572#26696#19968':'
          end
          object Label38: TLabel
            Left = 31
            Top = 184
            Width = 39
            Height = 15
            Alignment = taRightJustify
            Caption = #38382#39064#20108':'
          end
          object Label39: TLabel
            Left = 31
            Top = 208
            Width = 39
            Height = 15
            Alignment = taRightJustify
            Caption = #31572#26696#20108':'
          end
          object Label40: TLabel
            Left = 19
            Top = 112
            Width = 51
            Height = 15
            Alignment = taRightJustify
            Caption = #31227#21160#30005#35805':'
          end
          object Label41: TLabel
            Left = 223
            Top = 64
            Width = 39
            Height = 15
            Alignment = taRightJustify
            Caption = #22791#27880#19968':'
          end
          object Label42: TLabel
            Left = 223
            Top = 88
            Width = 39
            Height = 15
            Alignment = taRightJustify
            Caption = #22791#27880#20108':'
          end
          object Label43: TLabel
            Left = 27
            Top = 234
            Width = 51
            Height = 15
            Alignment = taRightJustify
            Caption = #30005#23376#37038#31665':'
          end
          object Label44: TLabel
            Left = 43
            Top = 88
            Width = 27
            Height = 15
            Alignment = taRightJustify
            Caption = #30005#35805':'
          end
          object EditLoginAccount: TEdit
            Left = 80
            Top = 16
            Width = 121
            Height = 23
            Enabled = False
            MaxLength = 10
            TabOrder = 0
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountPasswd: TEdit
            Left = 272
            Top = 16
            Width = 97
            Height = 23
            MaxLength = 10
            TabOrder = 1
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountUserName: TEdit
            Left = 80
            Top = 40
            Width = 121
            Height = 23
            MaxLength = 20
            TabOrder = 2
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountSSNo: TEdit
            Left = 272
            Top = 40
            Width = 121
            Height = 23
            MaxLength = 14
            TabOrder = 3
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountBirthDay: TEdit
            Left = 80
            Top = 64
            Width = 121
            Height = 23
            MaxLength = 10
            TabOrder = 4
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountQuiz: TEdit
            Left = 80
            Top = 136
            Width = 209
            Height = 23
            MaxLength = 20
            TabOrder = 5
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountAnswer: TEdit
            Left = 80
            Top = 160
            Width = 209
            Height = 23
            MaxLength = 12
            TabOrder = 6
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountQuiz2: TEdit
            Left = 80
            Top = 184
            Width = 209
            Height = 23
            MaxLength = 20
            TabOrder = 7
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountAnswer2: TEdit
            Left = 80
            Top = 208
            Width = 209
            Height = 23
            MaxLength = 12
            TabOrder = 8
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountMobilePhone: TEdit
            Left = 80
            Top = 112
            Width = 121
            Height = 23
            MaxLength = 13
            TabOrder = 9
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountMemo1: TEdit
            Left = 272
            Top = 64
            Width = 201
            Height = 23
            MaxLength = 20
            TabOrder = 10
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountEMail: TEdit
            Left = 80
            Top = 232
            Width = 209
            Height = 23
            MaxLength = 40
            TabOrder = 11
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountMemo2: TEdit
            Left = 272
            Top = 88
            Width = 201
            Height = 23
            MaxLength = 20
            TabOrder = 12
            OnChange = EditLoginAccountChange
          end
          object CkFullEditMode: TCheckBox
            Left = 376
            Top = 16
            Width = 97
            Height = 17
            Caption = #20462#25913#24080#21495#20449#24687
            TabOrder = 13
            OnClick = CkFullEditModeClick
          end
          object ButtonLoginAccountOK: TButton
            Left = 408
            Top = 224
            Width = 65
            Height = 25
            Caption = #30830#23450'(&O)'
            Enabled = False
            TabOrder = 14
            OnClick = ButtonLoginAccountOKClick
          end
          object EditLoginAccountPhone: TEdit
            Left = 80
            Top = 88
            Width = 121
            Height = 23
            MaxLength = 13
            TabOrder = 15
            OnChange = EditLoginAccountChange
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Server'
      ImageIndex = 1
      object PageControl2: TPageControl
        Left = 480
        Top = 144
        Width = 289
        Height = 193
        TabOrder = 0
      end
      object PageControl3: TPageControl
        Left = 0
        Top = 0
        Width = 512
        Height = 330
        ActivePage = TabSheet4
        Align = alClient
        TabOrder = 1
        TabPosition = tpBottom
        object TabSheet4: TTabSheet
          Caption = 'Server Details'
          object GroupBox1: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = 'Server Details'
            TabOrder = 0
            object Label1: TLabel
              Left = 8
              Top = 28
              Width = 104
              Height = 15
              Caption = 'MirServer Location:'
            end
            object Label2: TLabel
              Left = 8
              Top = 52
              Width = 94
              Height = 15
              Caption = 'Database Name:'
            end
            object Label3: TLabel
              Left = 8
              Top = 76
              Width = 75
              Height = 15
              Caption = 'Server Name:'
            end
            object Label4: TLabel
              Left = 8
              Top = 100
              Width = 101
              Height = 15
              Caption = 'Server IP Address:'
            end
            object Label59: TLabel
              Left = 184
              Top = 130
              Width = 34
              Height = 15
              Caption = 'Delay:'
            end
            object Label66: TLabel
              Left = 280
              Top = 130
              Width = 48
              Height = 15
              Caption = 'seconds'
            end
            object EditGameDir: TEdit
              Left = 136
              Top = 24
              Width = 225
              Height = 23
              Hint = #36755#20837#26381#21153#22120#25152#22312#30446#24405#12290#19968#33324#40664#35748#20026#8220'D:\MirServer\'#8221#12290
              TabOrder = 0
              Text = '.\'
            end
            object Button1: TButton
              Left = 400
              Top = 20
              Width = 73
              Height = 25
              Caption = #27983#35272'(&B)'
              TabOrder = 1
              Visible = False
            end
            object EditHeroDB: TEdit
              Left = 136
              Top = 48
              Width = 225
              Height = 23
              Hint = #26381#21153#22120#31471'BDE '#25968#25454#24211#21517#31216#65292#40664#35748#20026' '#8220'HeroDB'#8221#12290
              TabOrder = 2
              Text = 'HeroDB'
            end
            object EditGameName: TEdit
              Left = 136
              Top = 72
              Width = 161
              Height = 23
              Hint = #36755#20837#28216#25103#30340#21517#31216#12290
              TabOrder = 3
              Text = 'LOMCN'
            end
            object EditGameExtIPaddr: TEdit
              Left = 136
              Top = 96
              Width = 97
              Height = 23
              Hint = #36755#20837#26381#21153#22120#30340#22806#32593'IP'#22320#22336#12290
              TabOrder = 4
              Text = '127.0.0.1'
            end
            object CheckBoxDynamicIPMode: TCheckBox
              Left = 240
              Top = 96
              Width = 81
              Height = 17
              Hint = #21160#24577'IP'#22320#22336#27169#24335#65292#25903#25345#25300#21495#21160#24577'IP'#32593#32476#26465#20214#65292#25171#24320#27492#27169#24335#21518#65292#26381#21153#22120#31471#19981#38656#35201#25913#20219#20309'IP'#65292#33258#21160#35782#21035#30331#24405'IP'#22320#22336#12290
              Caption = 'Dynamic IP'
              TabOrder = 5
              OnClick = CheckBoxDynamicIPModeClick
            end
            object ButtonGeneralDefalult: TButton
              Left = 400
              Top = 144
              Width = 81
              Height = 25
              Caption = '&Default'
              TabOrder = 6
              OnClick = ButtonGeneralDefalultClick
            end
            object CheckBoxAutoStartServer: TCheckBox
              Left = 8
              Top = 128
              Width = 177
              Height = 17
              Caption = 'Auto Start Server'
              TabOrder = 7
              OnClick = CheckBoxAutoStartServerClick
            end
            object EditAutoStartDelayTime: TSpinEdit
              Left = 224
              Top = 128
              Width = 49
              Height = 24
              MaxValue = 0
              MinValue = 0
              TabOrder = 8
              Value = 0
              OnChange = EditAutoStartDelayTimeChange
            end
          end
          object ButtonNext1: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Next'
            TabOrder = 1
            OnClick = ButtonNext1Click
          end
          object ButtonReLoadConfig: TButton
            Left = 408
            Top = 223
            Width = 81
            Height = 33
            Caption = '&Reload'
            TabOrder = 2
            OnClick = ButtonReLoadConfigClick
          end
        end
        object TabSheet5: TTabSheet
          Caption = 'LoginGate Details'
          ImageIndex = 1
          object ButtonNext2: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Next'
            TabOrder = 0
            OnClick = ButtonNext2Click
          end
          object GroupBox2: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = 'LoginGate'
            TabOrder = 1
            object GroupBox7: TGroupBox
              Left = 8
              Top = 16
              Width = 105
              Height = 73
              Caption = 'Position'
              TabOrder = 0
              object Label9: TLabel
                Left = 8
                Top = 20
                Width = 10
                Height = 15
                Caption = 'X:'
              end
              object Label10: TLabel
                Left = 8
                Top = 44
                Width = 10
                Height = 15
                Caption = 'Y:'
              end
              object EditLoginGate_MainFormX: TSpinEdit
                Left = 24
                Top = 16
                Width = 65
                Height = 24
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditLoginGate_MainFormXChange
              end
              object EditLoginGate_MainFormY: TSpinEdit
                Left = 24
                Top = 40
                Width = 65
                Height = 24
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditLoginGate_MainFormYChange
              end
            end
            object ButtonLoginGateDefault: TButton
              Left = 400
              Top = 144
              Width = 81
              Height = 25
              Caption = '&Default'
              TabOrder = 1
              OnClick = ButtonLoginGateDefaultClick
            end
            object GroupBox23: TGroupBox
              Left = 120
              Top = 16
              Width = 129
              Height = 49
              Caption = 'Port used'
              TabOrder = 2
              object Label28: TLabel
                Left = 8
                Top = 20
                Width = 22
                Height = 15
                Caption = 'Port'
              end
              object EditLoginGate_GatePort: TEdit
                Left = 56
                Top = 16
                Width = 41
                Height = 23
                TabOrder = 0
                Text = '7000'
              end
            end
            object GroupBox27: TGroupBox
              Left = 8
              Top = 96
              Width = 73
              Height = 41
              Caption = 'Auto Start'
              TabOrder = 3
              object CheckBoxboLoginGate_GetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 57
                Height = 17
                Caption = 'Enable'
                TabOrder = 0
                OnClick = CheckBoxboLoginGate_GetStartClick
              end
            end
          end
          object ButtonPrv2: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Previous'
            TabOrder = 2
            OnClick = ButtonPrv2Click
          end
        end
        object TabSheet6: TTabSheet
          Caption = 'SelGate Details'
          ImageIndex = 2
          object GroupBox3: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = 'SelGate'
            TabOrder = 0
            object GroupBox8: TGroupBox
              Left = 8
              Top = 16
              Width = 105
              Height = 73
              Caption = 'Position'
              TabOrder = 0
              object Label11: TLabel
                Left = 8
                Top = 20
                Width = 10
                Height = 15
                Caption = 'X:'
              end
              object Label12: TLabel
                Left = 8
                Top = 44
                Width = 10
                Height = 15
                Caption = 'Y:'
              end
              object EditSelGate_MainFormX: TSpinEdit
                Left = 24
                Top = 16
                Width = 65
                Height = 24
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditSelGate_MainFormXChange
              end
              object EditSelGate_MainFormY: TSpinEdit
                Left = 24
                Top = 40
                Width = 65
                Height = 24
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditSelGate_MainFormYChange
              end
            end
            object ButtonSelGateDefault: TButton
              Left = 400
              Top = 144
              Width = 81
              Height = 25
              Caption = '&Default'
              TabOrder = 1
              OnClick = ButtonSelGateDefaultClick
            end
            object GroupBox24: TGroupBox
              Left = 120
              Top = 16
              Width = 129
              Height = 73
              Caption = 'Port used'
              TabOrder = 2
              object Label29: TLabel
                Left = 8
                Top = 20
                Width = 25
                Height = 15
                Caption = 'Port:'
              end
              object Label49: TLabel
                Left = 8
                Top = 44
                Width = 25
                Height = 15
                Caption = 'Port:'
              end
              object EditSelGate_GatePort: TEdit
                Left = 56
                Top = 16
                Width = 41
                Height = 23
                TabOrder = 0
                Text = '7100'
              end
              object EditSelGate_GatePort1: TEdit
                Left = 56
                Top = 40
                Width = 41
                Height = 23
                TabOrder = 1
                Text = '7100'
              end
            end
            object GroupBox28: TGroupBox
              Left = 8
              Top = 96
              Width = 73
              Height = 41
              Caption = 'Auto Start'
              TabOrder = 3
              object CheckBoxboSelGate_GetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 57
                Height = 17
                Caption = 'Enable'
                TabOrder = 0
                OnClick = CheckBoxboSelGate_GetStartClick
              end
            end
          end
          object ButtonPrv3: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Previous'
            TabOrder = 1
            OnClick = ButtonPrv3Click
          end
          object ButtonNext3: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Next'
            TabOrder = 2
            OnClick = ButtonNext3Click
          end
        end
        object TabSheet12: TTabSheet
          Caption = 'RunGate Details'
          ImageIndex = 8
          object ButtonPrv4: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Previous'
            TabOrder = 0
            OnClick = ButtonPrv4Click
          end
          object ButtonNext4: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Next'
            TabOrder = 1
            OnClick = ButtonNext4Click
          end
          object GroupBox17: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = 'RunGate'
            TabOrder = 2
            object GroupBox18: TGroupBox
              Left = 8
              Top = 16
              Width = 105
              Height = 73
              Caption = 'Position'
              Enabled = False
              TabOrder = 0
              object Label21: TLabel
                Left = 8
                Top = 20
                Width = 10
                Height = 15
                Caption = 'X:'
              end
              object Label22: TLabel
                Left = 8
                Top = 44
                Width = 10
                Height = 15
                Caption = 'Y:'
              end
              object EditRunGate_MainFormX: TSpinEdit
                Left = 24
                Top = 16
                Width = 65
                Height = 24
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                Enabled = False
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
              end
              object EditRunGate_MainFormY: TSpinEdit
                Left = 24
                Top = 40
                Width = 65
                Height = 24
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                Enabled = False
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
              end
            end
            object GroupBox19: TGroupBox
              Left = 8
              Top = 96
              Width = 129
              Height = 57
              Caption = 'Number of RunGates'
              TabOrder = 1
              object Label23: TLabel
                Left = 8
                Top = 20
                Width = 48
                Height = 15
                Caption = 'Number:'
              end
              object EditRunGate_Connt: TSpinEdit
                Left = 64
                Top = 16
                Width = 41
                Height = 24
                Hint = #35774#32622#24320#21551#28216#25103#32593#20851#25968#37327#65292#19968#33324'200'#20154#20197#19979#30340#24320#19968#20010#32593#20851#65292'400'#20154#20197#19979#30340#24320#20108#20010#32593#20851#65292'400'#20154#20197#19978#30340#24320#19977#20010#32593#20851#12290
                EditorEnabled = False
                Enabled = False
                MaxValue = 8
                MinValue = 1
                TabOrder = 0
                Value = 1
                OnChange = EditRunGate_ConntChange
              end
            end
            object GroupBox22: TGroupBox
              Left = 120
              Top = 16
              Width = 97
              Height = 49
              Caption = 'Port used'
              TabOrder = 2
              object LabelRunGate_GatePort1: TLabel
                Left = 8
                Top = 20
                Width = 25
                Height = 15
                Caption = 'Port:'
              end
              object EditRunGate_GatePort1: TEdit
                Left = 40
                Top = 16
                Width = 41
                Height = 23
                TabOrder = 0
                Text = '7200'
              end
            end
            object ButtonRunGateDefault: TButton
              Left = 400
              Top = 144
              Width = 81
              Height = 25
              Caption = '&Default'
              TabOrder = 3
              OnClick = ButtonRunGateDefaultClick
            end
          end
        end
        object TabSheet7: TTabSheet
          Caption = 'LoginSrv Details'
          ImageIndex = 3
          object GroupBox9: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = 'LoginServer'
            TabOrder = 0
            object GroupBox10: TGroupBox
              Left = 8
              Top = 16
              Width = 105
              Height = 73
              Caption = 'Position'
              TabOrder = 0
              object Label13: TLabel
                Left = 8
                Top = 20
                Width = 10
                Height = 15
                Caption = 'X:'
              end
              object Label14: TLabel
                Left = 8
                Top = 44
                Width = 10
                Height = 15
                Caption = 'Y:'
              end
              object EditLoginServer_MainFormX: TSpinEdit
                Left = 24
                Top = 16
                Width = 65
                Height = 24
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditLoginServer_MainFormXChange
              end
              object EditLoginServer_MainFormY: TSpinEdit
                Left = 24
                Top = 40
                Width = 65
                Height = 24
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditLoginServer_MainFormYChange
              end
            end
            object ButtonLoginServerConfig: TButton
              Left = 296
              Top = 144
              Width = 97
              Height = 25
              Caption = 'LoginSrv Config'
              TabOrder = 1
              Visible = False
              OnClick = ButtonLoginServerConfigClick
            end
            object ButtonLoginSrvDefault: TButton
              Left = 400
              Top = 144
              Width = 81
              Height = 25
              Caption = '&Default'
              TabOrder = 2
              OnClick = ButtonLoginSrvDefaultClick
            end
            object GroupBox33: TGroupBox
              Left = 120
              Top = 16
              Width = 129
              Height = 73
              Caption = 'Ports used'
              TabOrder = 3
              object Label50: TLabel
                Left = 8
                Top = 20
                Width = 51
                Height = 15
                Caption = 'GatePort:'
              end
              object Label51: TLabel
                Left = 8
                Top = 44
                Width = 60
                Height = 15
                Caption = 'ServerPort:'
              end
              object EditLoginServerGatePort: TEdit
                Left = 72
                Top = 16
                Width = 41
                Height = 23
                TabOrder = 0
                Text = '7200'
              end
              object EditLoginServerServerPort: TEdit
                Left = 72
                Top = 40
                Width = 41
                Height = 23
                TabOrder = 1
                Text = '7200'
              end
            end
            object GroupBox34: TGroupBox
              Left = 8
              Top = 96
              Width = 73
              Height = 41
              Caption = 'Auto Start'
              TabOrder = 4
              object CheckBoxboLoginServer_GetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 57
                Height = 17
                Caption = 'Enable'
                TabOrder = 0
                OnClick = CheckBoxboLoginServer_GetStartClick
              end
            end
          end
          object ButtonPrv5: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Previous'
            TabOrder = 1
            OnClick = ButtonPrv5Click
          end
          object ButtonNext5: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Next'
            TabOrder = 2
            OnClick = ButtonNext5Click
          end
        end
        object TabSheet8: TTabSheet
          Caption = 'DBSrv Details'
          ImageIndex = 4
          object GroupBox11: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = 'DB Server'
            TabOrder = 0
            object GroupBox12: TGroupBox
              Left = 8
              Top = 16
              Width = 97
              Height = 73
              Caption = 'Position'
              TabOrder = 0
              object Label15: TLabel
                Left = 8
                Top = 20
                Width = 10
                Height = 15
                Caption = 'X:'
              end
              object Label16: TLabel
                Left = 8
                Top = 44
                Width = 10
                Height = 15
                Caption = 'Y:'
              end
              object EditDBServer_MainFormX: TSpinEdit
                Left = 24
                Top = 16
                Width = 65
                Height = 24
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditDBServer_MainFormXChange
              end
              object EditDBServer_MainFormY: TSpinEdit
                Left = 24
                Top = 40
                Width = 65
                Height = 24
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditDBServer_MainFormYChange
              end
            end
            object GroupBox20: TGroupBox
              Left = 88
              Top = 96
              Width = 89
              Height = 41
              Caption = 'Auto Game'
              TabOrder = 1
              Visible = False
              object CheckBoxDisableAutoGame: TCheckBox
                Left = 8
                Top = 16
                Width = 73
                Height = 17
                Caption = 'Disable'
                TabOrder = 0
                OnClick = CheckBoxDisableAutoGameClick
              end
            end
            object ButtonDBServerDefault: TButton
              Left = 400
              Top = 144
              Width = 81
              Height = 25
              Caption = '&Default'
              TabOrder = 2
              OnClick = ButtonDBServerDefaultClick
            end
            object GroupBox35: TGroupBox
              Left = 8
              Top = 96
              Width = 73
              Height = 41
              Caption = 'Auto Start'
              TabOrder = 3
              object CheckBoxDBServerGetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 57
                Height = 17
                Caption = 'Enable'
                TabOrder = 0
                OnClick = CheckBoxDBServerGetStartClick
              end
            end
            object GroupBox36: TGroupBox
              Left = 112
              Top = 16
              Width = 129
              Height = 73
              Caption = 'Ports used'
              TabOrder = 4
              object Label52: TLabel
                Left = 8
                Top = 20
                Width = 51
                Height = 15
                Caption = 'GatePort:'
              end
              object Label53: TLabel
                Left = 8
                Top = 44
                Width = 60
                Height = 15
                Caption = 'ServerPort:'
              end
              object EditDBServerGatePort: TEdit
                Left = 72
                Top = 16
                Width = 41
                Height = 23
                TabOrder = 0
                Text = '5100'
              end
              object EditDBServerServerPort: TEdit
                Left = 72
                Top = 40
                Width = 41
                Height = 23
                TabOrder = 1
                Text = '6000'
              end
            end
          end
          object ButtonPrv6: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Previous'
            TabOrder = 1
            OnClick = ButtonPrv6Click
          end
          object ButtonNext6: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Next'
            TabOrder = 2
            OnClick = ButtonNext6Click
          end
        end
        object TabSheet9: TTabSheet
          Caption = 'LogData Details'
          ImageIndex = 5
          object GroupBox13: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = 'LogData Server'
            TabOrder = 0
            object GroupBox14: TGroupBox
              Left = 8
              Top = 16
              Width = 105
              Height = 73
              Caption = 'Position'
              TabOrder = 0
              object Label17: TLabel
                Left = 8
                Top = 20
                Width = 10
                Height = 15
                Caption = 'X:'
              end
              object Label18: TLabel
                Left = 8
                Top = 44
                Width = 10
                Height = 15
                Caption = 'Y:'
              end
              object EditLogServer_MainFormX: TSpinEdit
                Left = 24
                Top = 16
                Width = 65
                Height = 24
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditLogServer_MainFormXChange
              end
              object EditLogServer_MainFormY: TSpinEdit
                Left = 24
                Top = 40
                Width = 65
                Height = 24
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditLogServer_MainFormYChange
              end
            end
            object ButtonLogServerDefault: TButton
              Left = 400
              Top = 144
              Width = 81
              Height = 25
              Caption = '&Default'
              TabOrder = 1
              OnClick = ButtonLogServerDefaultClick
            end
            object GroupBox37: TGroupBox
              Left = 8
              Top = 96
              Width = 129
              Height = 41
              Caption = 'Auto Start'
              TabOrder = 2
              object CheckBoxLogServerGetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 113
                Height = 17
                Caption = 'Enable'
                TabOrder = 0
                OnClick = CheckBoxLogServerGetStartClick
              end
            end
            object GroupBox38: TGroupBox
              Left = 120
              Top = 16
              Width = 89
              Height = 49
              Caption = 'Port used'
              TabOrder = 3
              object Label54: TLabel
                Left = 8
                Top = 20
                Width = 25
                Height = 15
                Caption = 'Port:'
              end
              object EditLogServerPort: TEdit
                Left = 40
                Top = 16
                Width = 41
                Height = 23
                TabOrder = 0
                Text = '10000'
              end
            end
          end
          object ButtonPrv7: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Previous'
            TabOrder = 1
            OnClick = ButtonPrv7Click
          end
          object ButtonNext7: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Next'
            TabOrder = 2
            OnClick = ButtonNext7Click
          end
        end
        object TabSheet10: TTabSheet
          Caption = 'M2Server Details'
          ImageIndex = 6
          object GroupBox15: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = 'M2Server'
            TabOrder = 0
            object GroupBox16: TGroupBox
              Left = 8
              Top = 16
              Width = 97
              Height = 73
              Caption = 'Position'
              TabOrder = 0
              object Label19: TLabel
                Left = 8
                Top = 20
                Width = 10
                Height = 15
                Caption = 'X:'
              end
              object Label20: TLabel
                Left = 8
                Top = 44
                Width = 10
                Height = 15
                Caption = 'Y:'
              end
              object EditM2Server_MainFormX: TSpinEdit
                Left = 24
                Top = 16
                Width = 65
                Height = 24
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditM2Server_MainFormXChange
              end
              object EditM2Server_MainFormY: TSpinEdit
                Left = 24
                Top = 40
                Width = 65
                Height = 24
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditM2Server_MainFormYChange
              end
            end
            object ButtonM2ServerDefault: TButton
              Left = 400
              Top = 144
              Width = 81
              Height = 25
              Caption = '&Default'
              TabOrder = 1
              OnClick = ButtonM2ServerDefaultClick
            end
            object GroupBox32: TGroupBox
              Left = 248
              Top = 16
              Width = 145
              Height = 73
              Caption = 'TestServer Details'
              TabOrder = 2
              object Label61: TLabel
                Left = 8
                Top = 20
                Width = 59
                Height = 15
                Caption = 'Test Level:'
              end
              object Label62: TLabel
                Left = 8
                Top = 44
                Width = 56
                Height = 15
                Caption = 'Test Gold:'
              end
              object EditM2Server_TestLevel: TSpinEdit
                Left = 68
                Top = 16
                Width = 69
                Height = 24
                Hint = #20154#29289#36215#22987#31561#32423#12290
                MaxValue = 20000
                MinValue = 0
                TabOrder = 0
                Value = 10
                OnChange = EditM2Server_TestLevelChange
              end
              object EditM2Server_TestGold: TSpinEdit
                Left = 68
                Top = 40
                Width = 69
                Height = 24
                Hint = #27979#35797#27169#24335#20154#29289#36215#22987#37329#24065#25968#12290
                Increment = 1000
                MaxValue = 20000000
                MinValue = 0
                TabOrder = 1
                Value = 10
                OnChange = EditM2Server_TestGoldChange
              end
            end
            object GroupBox39: TGroupBox
              Left = 112
              Top = 16
              Width = 129
              Height = 73
              Caption = 'Ports used'
              TabOrder = 3
              object Label55: TLabel
                Left = 8
                Top = 20
                Width = 54
                Height = 15
                Caption = 'Gate Port:'
              end
              object Label56: TLabel
                Left = 8
                Top = 44
                Width = 63
                Height = 15
                Caption = 'Server Port:'
              end
              object EditM2ServerGatePort: TEdit
                Left = 72
                Top = 16
                Width = 41
                Height = 23
                TabOrder = 0
                Text = '5000'
              end
              object EditM2ServerMsgSrvPort: TEdit
                Left = 72
                Top = 40
                Width = 41
                Height = 23
                TabOrder = 1
                Text = '4900'
              end
            end
            object GroupBox40: TGroupBox
              Left = 8
              Top = 96
              Width = 193
              Height = 41
              Caption = 'Auto Start'
              TabOrder = 4
              object CheckBoxM2ServerGetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 169
                Height = 17
                Caption = 'Enable'
                TabOrder = 0
                OnClick = CheckBoxM2ServerGetStartClick
              end
            end
          end
          object ButtonPrv8: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Previous'
            TabOrder = 1
            OnClick = ButtonPrv8Click
          end
          object ButtonNext8: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Next'
            TabOrder = 2
            OnClick = ButtonNext8Click
          end
        end
        object TabSheet11: TTabSheet
          Caption = 'Save Details'
          ImageIndex = 7
          object ButtonSave: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Save'
            TabOrder = 0
            OnClick = ButtonSaveClick
          end
          object ButtonGenGameConfig: TButton
            Left = 216
            Top = 263
            Width = 97
            Height = 33
            Caption = '&Generate Config'
            TabOrder = 1
            OnClick = ButtonGenGameConfigClick
          end
          object ButtonPrv9: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = '&Previous'
            TabOrder = 2
            OnClick = ButtonPrv9Click
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Backup'
      ImageIndex = 2
      object LabelBackMsg: TLabel
        Left = 384
        Top = 304
        Width = 6
        Height = 12
        Font.Charset = GB2312_CHARSET
        Font.Color = clGreen
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object GroupBox4: TGroupBox
        Left = 8
        Top = 8
        Width = 497
        Height = 153
        Caption = #22791#20221#21015#34920
        TabOrder = 0
        object ListViewDataBackup: TListView
          Left = 8
          Top = 16
          Width = 481
          Height = 129
          Columns = <
            item
              Caption = #25968#25454#30446#24405
              Width = 220
            end
            item
              Caption = #22791#20221#30446#24405
              Width = 220
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListViewDataBackupClick
        end
      end
      object GroupBox6: TGroupBox
        Left = 8
        Top = 168
        Width = 497
        Height = 121
        Caption = #32534#36753
        TabOrder = 1
        object Label5: TLabel
          Left = 8
          Top = 20
          Width = 51
          Height = 15
          Caption = #25968#25454#30446#24405':'
        end
        object Label6: TLabel
          Left = 8
          Top = 44
          Width = 51
          Height = 15
          Caption = #22791#20221#30446#24405':'
        end
        object Label7: TLabel
          Left = 120
          Top = 68
          Width = 12
          Height = 15
          Caption = #28857
        end
        object Label8: TLabel
          Left = 200
          Top = 68
          Width = 12
          Height = 15
          Caption = #20998
        end
        object Label64: TLabel
          Left = 116
          Top = 92
          Width = 24
          Height = 15
          Caption = #23567#26102
        end
        object Label65: TLabel
          Left = 200
          Top = 92
          Width = 12
          Height = 15
          Caption = #20998
        end
        object RadioButtonBackMode1: TRadioButton
          Left = 8
          Top = 64
          Width = 49
          Height = 17
          Caption = #27599#22825
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = RadioButtonBackMode1Click
        end
        object RzButtonEditSource: TRzButtonEdit
          Left = 64
          Top = 16
          Width = 425
          Height = 23
          TabOrder = 1
          OnButtonClick = RzButtonEditSourceButtonClick
        end
        object RzButtonEditDest: TRzButtonEdit
          Left = 64
          Top = 40
          Width = 425
          Height = 23
          TabOrder = 2
          OnButtonClick = RzButtonEditDestButtonClick
        end
        object RadioButtonBackMode2: TRadioButton
          Left = 8
          Top = 88
          Width = 49
          Height = 17
          Caption = #27599#38548
          TabOrder = 3
          OnClick = RadioButtonBackMode2Click
        end
        object RzSpinEditHour1: TRzSpinEdit
          Left = 64
          Top = 64
          Width = 47
          Height = 23
          Max = 23.000000000000000000
          TabOrder = 4
        end
        object RzSpinEditHour2: TRzSpinEdit
          Left = 64
          Top = 88
          Width = 47
          Height = 23
          Max = 10000000000.000000000000000000
          TabOrder = 5
        end
        object RzSpinEditMin1: TRzSpinEdit
          Left = 144
          Top = 64
          Width = 47
          Height = 23
          Max = 59.000000000000000000
          TabOrder = 6
        end
        object CheckBoxBackUp: TCheckBox
          Left = 224
          Top = 80
          Width = 49
          Height = 17
          Caption = #22791#20221
          TabOrder = 7
        end
        object RzSpinEditMin2: TRzSpinEdit
          Left = 144
          Top = 88
          Width = 47
          Height = 23
          Max = 59.000000000000000000
          TabOrder = 8
        end
        object CheckBoxZip: TCheckBox
          Left = 288
          Top = 80
          Width = 49
          Height = 17
          Caption = #21387#32553
          TabOrder = 9
        end
      end
      object ButtonBackChg: TButton
        Left = 8
        Top = 296
        Width = 65
        Height = 25
        Caption = #20462#25913'(&C)'
        TabOrder = 2
        OnClick = ButtonBackChgClick
      end
      object ButtonBackDel: TButton
        Left = 80
        Top = 296
        Width = 65
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonBackDelClick
      end
      object ButtonBackAdd: TButton
        Left = 152
        Top = 296
        Width = 65
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 4
        OnClick = ButtonBackAddClick
      end
      object ButtonBackStart: TButton
        Left = 296
        Top = 296
        Width = 75
        Height = 25
        Caption = #21551#21160'(&B)'
        TabOrder = 5
        OnClick = ButtonBackStartClick
      end
      object ButtonBackSave: TButton
        Left = 224
        Top = 296
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 6
        OnClick = ButtonBackSaveClick
      end
    end
    object TabSheet13: TTabSheet
      Caption = 'About'
      ImageIndex = 3
      object GroupBox41: TGroupBox
        Left = 8
        Top = 8
        Width = 497
        Height = 233
        Caption = 'About'
        TabOrder = 0
        object LabelVersion: TLabel
          Left = 8
          Top = 16
          Width = 144
          Height = 15
          Caption = 'Mir2: Heroes GameCenter'
        end
        object Label60: TLabel
          Left = 8
          Top = 32
          Width = 65
          Height = 15
          Caption = 'Version: 1.0'
        end
        object Label63: TLabel
          Left = 8
          Top = 48
          Width = 122
          Height = 15
          Caption = 'Released: 20/01/2011'
        end
      end
    end
    object TabSheetDebug: TTabSheet
      Caption = #27979#35797
      ImageIndex = 6
      object GroupBox29: TGroupBox
        Left = 8
        Top = 0
        Width = 497
        Height = 329
        Caption = #36827#31243#20449#24687
        TabOrder = 0
        object GroupBox30: TGroupBox
          Left = 8
          Top = 16
          Width = 265
          Height = 113
          Caption = #28216#25103#24341#25806
          TabOrder = 0
          object Label45: TLabel
            Left = 8
            Top = 20
            Width = 27
            Height = 15
            Caption = #22320#22336':'
          end
          object Label46: TLabel
            Left = 8
            Top = 44
            Width = 39
            Height = 15
            Caption = #26816#26597#30721':'
          end
          object Label58: TLabel
            Left = 8
            Top = 68
            Width = 39
            Height = 15
            Caption = #26816#26597#20018':'
          end
          object EditM2CheckCodeAddr: TEdit
            Left = 56
            Top = 16
            Width = 97
            Height = 23
            TabOrder = 0
          end
          object EditM2CheckCode: TEdit
            Left = 56
            Top = 40
            Width = 97
            Height = 23
            TabOrder = 1
          end
          object ButtonM2Suspend: TButton
            Left = 200
            Top = 32
            Width = 57
            Height = 25
            Caption = #26242#20572#31243#24207
            TabOrder = 2
            Visible = False
            OnClick = ButtonM2SuspendClick
          end
          object EditM2CheckStr: TEdit
            Left = 56
            Top = 64
            Width = 201
            Height = 23
            TabOrder = 3
          end
        end
        object GroupBox31: TGroupBox
          Left = 8
          Top = 136
          Width = 265
          Height = 105
          Caption = #25968#25454#24211
          TabOrder = 1
          object Label47: TLabel
            Left = 8
            Top = 20
            Width = 27
            Height = 15
            Caption = #22320#22336':'
          end
          object Label48: TLabel
            Left = 8
            Top = 44
            Width = 39
            Height = 15
            Caption = #26816#26597#30721':'
          end
          object Label57: TLabel
            Left = 8
            Top = 68
            Width = 36
            Height = 15
            Caption = #26816#26597#20018
          end
          object EditDBCheckCodeAddr: TEdit
            Left = 56
            Top = 16
            Width = 97
            Height = 23
            TabOrder = 0
          end
          object EditDBCheckCode: TEdit
            Left = 56
            Top = 40
            Width = 97
            Height = 23
            TabOrder = 1
          end
          object Button3: TButton
            Left = 200
            Top = 32
            Width = 57
            Height = 25
            Caption = #26242#20572#31243#24207
            TabOrder = 2
            Visible = False
            OnClick = ButtonM2SuspendClick
          end
          object EditDBCheckStr: TEdit
            Left = 56
            Top = 64
            Width = 201
            Height = 23
            TabOrder = 3
          end
        end
      end
    end
  end
  object TimerStartGame: TTimer
    Enabled = False
    Interval = 200
    OnTimer = TimerStartGameTimer
    Left = 408
    Top = 24
  end
  object TimerStopGame: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerStopGameTimer
    Left = 440
    Top = 24
  end
  object TimerCheckRun: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = TimerCheckRunTimer
    Left = 472
    Top = 24
  end
  object ServerSocket: TServerSocket
    Active = False
    Address = '0.0.0.0'
    Port = 6350
    ServerType = stNonBlocking
    OnClientConnect = ServerSocketClientConnect
    OnClientDisconnect = ServerSocketClientDisconnect
    OnClientRead = ServerSocketClientRead
    OnClientError = ServerSocketClientError
    Left = 504
    Top = 64
  end
  object Timer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = TimerTimer
    Left = 504
    Top = 24
  end
  object TimerCheckDebug: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerCheckDebugTimer
    Left = 504
    Top = 96
  end
  object TimerUpDate: TTimer
    Enabled = False
    OnTimer = TimerUpDateTimer
    Left = 412
    Top = 55
  end
  object TimerAutoStartServer: TTimer
    Enabled = False
    OnTimer = TimerAutoStartServerTimer
    Left = 404
    Top = 95
  end
end
