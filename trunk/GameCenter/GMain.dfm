object frmMain: TfrmMain
  Left = 687
  Top = 162
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'MakeGM???'
  ClientHeight = 470
  ClientWidth = 670
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 10
    Top = 10
    Width = 650
    Height = 450
    ActivePage = TabSheet1
    HotTrack = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Server Starter'
      object GroupBox5: TGroupBox
        Left = 10
        Top = 10
        Width = 621
        Height = 391
        Caption = '?????'
        TabOrder = 0
        object EditM2ServerProgram: TEdit
          Left = 590
          Top = 80
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 0
          Visible = False
        end
        object EditDBServerProgram: TEdit
          Left = 590
          Top = 20
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 1
          Visible = False
        end
        object EditLoginSrvProgram: TEdit
          Left = 590
          Top = 50
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 2
          Visible = False
        end
        object EditLogServerProgram: TEdit
          Left = 590
          Top = 110
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 3
          Visible = False
        end
        object EditLoginGateProgram: TEdit
          Left = 590
          Top = 140
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 4
          Visible = False
        end
        object EditSelGateProgram: TEdit
          Left = 590
          Top = 170
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 5
          Visible = False
        end
        object EditRunGateProgram: TEdit
          Left = 590
          Top = 200
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 6
          Visible = False
        end
        object ButtonStartGame: TButton
          Left = 220
          Top = 340
          Width = 181
          Height = 41
          Caption = 'Start Server (&S)'
          TabOrder = 7
          OnClick = ButtonStartGameClick
        end
        object CheckBoxM2Server: TCheckBox
          Left = 10
          Top = 45
          Width = 201
          Height = 21
          Caption = 'M2Server:'
          TabOrder = 8
          OnClick = CheckBoxM2ServerClick
        end
        object CheckBoxDBServer: TCheckBox
          Left = 10
          Top = 25
          Width = 221
          Height = 21
          Caption = 'DBServer:'
          TabOrder = 9
          OnClick = CheckBoxDBServerClick
        end
        object CheckBoxLoginServer: TCheckBox
          Left = 230
          Top = 25
          Width = 221
          Height = 21
          Caption = 'LoginSrv:'
          TabOrder = 10
          OnClick = CheckBoxLoginServerClick
        end
        object CheckBoxLogServer: TCheckBox
          Left = 230
          Top = 45
          Width = 221
          Height = 21
          Caption = 'LogDataServer:'
          TabOrder = 11
          OnClick = CheckBoxLogServerClick
        end
        object CheckBoxLoginGate: TCheckBox
          Left = 10
          Top = 65
          Width = 201
          Height = 21
          Caption = 'LoginGate:'
          TabOrder = 12
          OnClick = CheckBoxLoginGateClick
        end
        object CheckBoxSelGate: TCheckBox
          Left = 230
          Top = 65
          Width = 201
          Height = 21
          Caption = 'SelGate:'
          TabOrder = 13
          OnClick = CheckBoxSelGateClick
        end
        object CheckBoxRunGate: TCheckBox
          Left = 10
          Top = 85
          Width = 201
          Height = 21
          Caption = 'Rungate:'
          TabOrder = 14
          OnClick = CheckBoxRunGateClick
        end
        object CheckBoxRunGate1: TCheckBox
          Left = 230
          Top = 85
          Width = 201
          Height = 21
          Caption = 'Rungate:'
          TabOrder = 15
          OnClick = CheckBoxRunGateClick
        end
        object EditRunGate1Program: TEdit
          Left = 590
          Top = 230
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 16
          Visible = False
        end
        object CheckBoxRunGate2: TCheckBox
          Left = 10
          Top = 105
          Width = 201
          Height = 21
          Caption = 'Rungate:'
          TabOrder = 17
          OnClick = CheckBoxRunGateClick
        end
        object EditRunGate2Program: TEdit
          Left = 590
          Top = 260
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 18
          Visible = False
        end
        object MemoLog: TMemo
          Left = 10
          Top = 190
          Width = 591
          Height = 131
          Color = clNone
          Font.Charset = ANSI_CHARSET
          Font.Color = clLime
          Font.Height = -15
          Font.Name = '??'
          Font.Style = []
          ParentFont = False
          TabOrder = 19
          OnChange = MemoLogChange
        end
        object CheckBoxRunGate3: TCheckBox
          Left = 230
          Top = 105
          Width = 201
          Height = 21
          Caption = 'Rungate:'
          TabOrder = 20
          OnClick = CheckBoxRunGateClick
        end
        object CheckBoxRunGate4: TCheckBox
          Left = 10
          Top = 125
          Width = 201
          Height = 21
          Caption = 'Rungate:'
          TabOrder = 21
          OnClick = CheckBoxRunGateClick
        end
        object CheckBoxRunGate5: TCheckBox
          Left = 230
          Top = 125
          Width = 201
          Height = 21
          Caption = 'Rungate:'
          TabOrder = 22
          OnClick = CheckBoxRunGateClick
        end
        object CheckBoxRunGate6: TCheckBox
          Left = 10
          Top = 145
          Width = 201
          Height = 21
          Caption = 'Rungate:'
          TabOrder = 23
          OnClick = CheckBoxRunGateClick
        end
        object CheckBoxRunGate7: TCheckBox
          Left = 230
          Top = 145
          Width = 201
          Height = 21
          Caption = 'Rungate:'
          TabOrder = 24
          OnClick = CheckBoxRunGateClick
        end
      end
    end
    object TabSheet14: TTabSheet
      Caption = '?????'
      ImageIndex = 4
      object GroupBox21: TGroupBox
        Left = 10
        Top = 10
        Width = 621
        Height = 401
        Caption = '?????'
        TabOrder = 0
        object Label24: TLabel
          Left = 10
          Top = 20
          Width = 38
          Height = 15
          Caption = '?????:'
        end
        object Label25: TLabel
          Left = 10
          Top = 195
          Width = 31
          Height = 15
          Caption = '????:'
        end
        object Label26: TLabel
          Left = 10
          Top = 220
          Width = 31
          Height = 15
          Caption = '????:'
        end
        object LabelConnect: TLabel
          Left = 150
          Top = 220
          Width = 3
          Height = 15
        end
        object Label27: TLabel
          Left = 360
          Top = 195
          Width = 38
          Height = 15
          Caption = '?????:'
        end
        object MemoGameList: TMemo
          Left = 10
          Top = 40
          Width = 501
          Height = 141
          Lines.Strings = (
            'MakeGM|MakeGM||127.0.0.1|7000|http://www.MakeGM.com'
            '')
          ScrollBars = ssHorizontal
          TabOrder = 0
          OnChange = MemoGameListChange
        end
        object EditNoticeUrl: TEdit
          Left = 80
          Top = 190
          Width = 251
          Height = 23
          TabOrder = 1
          Text = 'http://www.MakeGM.com'
          OnChange = EditNoticeUrlChange
        end
        object Memo1: TMemo
          Left = 10
          Top = 240
          Width = 501
          Height = 141
          TabOrder = 2
        end
        object Button2: TButton
          Left = 520
          Top = 40
          Width = 91
          Height = 31
          Caption = '????'
          Enabled = False
          TabOrder = 3
          OnClick = Button2Click
        end
        object EditClientForm: TSpinEdit
          Left = 450
          Top = 190
          Width = 61
          Height = 24
          MaxValue = 20
          MinValue = -1
          TabOrder = 4
          Value = -1
          OnChange = EditClientFormChange
        end
      end
    end
    object TabSheet15: TTabSheet
      Caption = '????'
      ImageIndex = 5
      object GroupBox25: TGroupBox
        Left = 10
        Top = 10
        Width = 621
        Height = 401
        Caption = '??????'
        TabOrder = 0
        object Label30: TLabel
          Left = 20
          Top = 30
          Width = 31
          Height = 15
          Caption = '????:'
        end
        object EditSearchLoginAccount: TEdit
          Left = 90
          Top = 25
          Width = 131
          Height = 23
          TabOrder = 0
        end
        object ButtonSearchLoginAccount: TButton
          Left = 230
          Top = 20
          Width = 81
          Height = 31
          Caption = '??(&S)'
          TabOrder = 1
          OnClick = ButtonSearchLoginAccountClick
        end
        object GroupBox26: TGroupBox
          Left = 10
          Top = 60
          Width = 601
          Height = 331
          Caption = '????'
          TabOrder = 2
          object Label31: TLabel
            Left = 71
            Top = 20
            Width = 17
            Height = 15
            Alignment = taRightJustify
            Caption = '??:'
          end
          object Label32: TLabel
            Left = 311
            Top = 20
            Width = 17
            Height = 15
            Alignment = taRightJustify
            Caption = '??:'
          end
          object Label33: TLabel
            Left = 57
            Top = 50
            Width = 31
            Height = 15
            Alignment = taRightJustify
            Caption = '????:'
          end
          object Label34: TLabel
            Left = 297
            Top = 50
            Width = 31
            Height = 15
            Alignment = taRightJustify
            Caption = '????:'
          end
          object Label35: TLabel
            Left = 71
            Top = 80
            Width = 17
            Height = 15
            Alignment = taRightJustify
            Caption = '??:'
          end
          object Label36: TLabel
            Left = 64
            Top = 170
            Width = 24
            Height = 15
            Alignment = taRightJustify
            Caption = '???:'
          end
          object Label37: TLabel
            Left = 64
            Top = 200
            Width = 24
            Height = 15
            Alignment = taRightJustify
            Caption = '???:'
          end
          object Label38: TLabel
            Left = 64
            Top = 230
            Width = 24
            Height = 15
            Alignment = taRightJustify
            Caption = '???:'
          end
          object Label39: TLabel
            Left = 64
            Top = 260
            Width = 24
            Height = 15
            Alignment = taRightJustify
            Caption = '???:'
          end
          object Label40: TLabel
            Left = 57
            Top = 140
            Width = 31
            Height = 15
            Alignment = taRightJustify
            Caption = '????:'
          end
          object Label41: TLabel
            Left = 304
            Top = 80
            Width = 24
            Height = 15
            Alignment = taRightJustify
            Caption = '???:'
          end
          object Label42: TLabel
            Left = 304
            Top = 110
            Width = 24
            Height = 15
            Alignment = taRightJustify
            Caption = '???:'
          end
          object Label43: TLabel
            Left = 67
            Top = 293
            Width = 31
            Height = 15
            Alignment = taRightJustify
            Caption = '????:'
          end
          object Label44: TLabel
            Left = 71
            Top = 110
            Width = 17
            Height = 15
            Alignment = taRightJustify
            Caption = '??:'
          end
          object EditLoginAccount: TEdit
            Left = 100
            Top = 20
            Width = 151
            Height = 23
            Enabled = False
            MaxLength = 10
            TabOrder = 0
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountPasswd: TEdit
            Left = 340
            Top = 20
            Width = 121
            Height = 23
            MaxLength = 10
            TabOrder = 1
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountUserName: TEdit
            Left = 100
            Top = 50
            Width = 151
            Height = 23
            MaxLength = 20
            TabOrder = 2
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountSSNo: TEdit
            Left = 340
            Top = 50
            Width = 151
            Height = 23
            MaxLength = 14
            TabOrder = 3
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountBirthDay: TEdit
            Left = 100
            Top = 80
            Width = 151
            Height = 23
            MaxLength = 10
            TabOrder = 4
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountQuiz: TEdit
            Left = 100
            Top = 170
            Width = 261
            Height = 23
            MaxLength = 20
            TabOrder = 5
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountAnswer: TEdit
            Left = 100
            Top = 200
            Width = 261
            Height = 23
            MaxLength = 12
            TabOrder = 6
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountQuiz2: TEdit
            Left = 100
            Top = 230
            Width = 261
            Height = 23
            MaxLength = 20
            TabOrder = 7
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountAnswer2: TEdit
            Left = 100
            Top = 260
            Width = 261
            Height = 23
            MaxLength = 12
            TabOrder = 8
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountMobilePhone: TEdit
            Left = 100
            Top = 140
            Width = 151
            Height = 23
            MaxLength = 13
            TabOrder = 9
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountMemo1: TEdit
            Left = 340
            Top = 80
            Width = 251
            Height = 23
            MaxLength = 20
            TabOrder = 10
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountEMail: TEdit
            Left = 100
            Top = 290
            Width = 261
            Height = 23
            MaxLength = 40
            TabOrder = 11
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountMemo2: TEdit
            Left = 340
            Top = 110
            Width = 251
            Height = 23
            MaxLength = 20
            TabOrder = 12
            OnChange = EditLoginAccountChange
          end
          object CkFullEditMode: TCheckBox
            Left = 470
            Top = 20
            Width = 121
            Height = 21
            Caption = '??????'
            TabOrder = 13
            OnClick = CkFullEditModeClick
          end
          object ButtonLoginAccountOK: TButton
            Left = 510
            Top = 280
            Width = 81
            Height = 31
            Caption = '??(&O)'
            Enabled = False
            TabOrder = 14
            OnClick = ButtonLoginAccountOKClick
          end
          object EditLoginAccountPhone: TEdit
            Left = 100
            Top = 110
            Width = 151
            Height = 23
            MaxLength = 13
            TabOrder = 15
            OnChange = EditLoginAccountChange
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = '????'
      ImageIndex = 1
      object PageControl2: TPageControl
        Left = 600
        Top = 180
        Width = 361
        Height = 241
        TabOrder = 0
      end
      object PageControl3: TPageControl
        Left = 0
        Top = 0
        Width = 642
        Height = 420
        ActivePage = TabSheet4
        Align = alClient
        TabOrder = 1
        TabPosition = tpBottom
        object TabSheet4: TTabSheet
          Caption = '???(????)'
          object GroupBox1: TGroupBox
            Left = 10
            Top = 10
            Width = 611
            Height = 221
            Caption = '????????????'
            TabOrder = 0
            object Label1: TLabel
              Left = 10
              Top = 35
              Width = 66
              Height = 15
              Caption = '?????????:'
            end
            object Label2: TLabel
              Left = 10
              Top = 65
              Width = 52
              Height = 15
              Caption = '???????:'
            end
            object Label3: TLabel
              Left = 10
              Top = 95
              Width = 73
              Height = 15
              Caption = '??????????:'
            end
            object Label4: TLabel
              Left = 10
              Top = 125
              Width = 77
              Height = 15
              Caption = '???????IP??:'
            end
            object Label59: TLabel
              Left = 240
              Top = 163
              Width = 17
              Height = 15
              Caption = '??:'
            end
            object Label66: TLabel
              Left = 350
              Top = 163
              Width = 7
              Height = 15
              Caption = '?'
            end
            object EditGameDir: TEdit
              Left = 170
              Top = 30
              Width = 281
              Height = 23
              Hint = '???????????????'#8220'D:\MirServer\'#8221'?'
              TabOrder = 0
              Text = 'D:\MirServer\'
            end
            object Button1: TButton
              Left = 500
              Top = 25
              Width = 91
              Height = 31
              Caption = '??(&B)'
              TabOrder = 1
              Visible = False
            end
            object EditHeroDB: TEdit
              Left = 170
              Top = 60
              Width = 281
              Height = 23
              Hint = '????BDE ?????,??? '#8220'HeroDB'#8221'?'
              TabOrder = 2
              Text = 'HeroDB'
            end
            object EditGameName: TEdit
              Left = 170
              Top = 90
              Width = 201
              Height = 23
              Hint = '????????'
              TabOrder = 3
              Text = '????'
            end
            object EditGameExtIPaddr: TEdit
              Left = 170
              Top = 120
              Width = 121
              Height = 23
              Hint = '????????IP???'
              TabOrder = 4
              Text = '127.0.0.1'
            end
            object CheckBoxDynamicIPMode: TCheckBox
              Left = 300
              Top = 120
              Width = 101
              Height = 21
              Hint = '??IP????,??????IP????,??????,??????????IP,??????IP???'
              Caption = '??IP??'
              TabOrder = 5
              OnClick = CheckBoxDynamicIPModeClick
            end
            object ButtonGeneralDefalult: TButton
              Left = 500
              Top = 180
              Width = 101
              Height = 31
              Caption = '????(&D)'
              TabOrder = 6
              OnClick = ButtonGeneralDefalultClick
            end
            object CheckBoxAutoStartServer: TCheckBox
              Left = 10
              Top = 160
              Width = 221
              Height = 21
              Caption = '?????????????'
              TabOrder = 7
              OnClick = CheckBoxAutoStartServerClick
            end
            object EditAutoStartDelayTime: TSpinEdit
              Left = 280
              Top = 160
              Width = 61
              Height = 24
              MaxValue = 0
              MinValue = 0
              TabOrder = 8
              Value = 0
              OnChange = EditAutoStartDelayTimeChange
            end
          end
          object ButtonNext1: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = '???(&N)'
            TabOrder = 1
            OnClick = ButtonNext1Click
          end
          object ButtonReLoadConfig: TButton
            Left = 510
            Top = 279
            Width = 101
            Height = 41
            Caption = '???(&R)'
            TabOrder = 2
            OnClick = ButtonReLoadConfigClick
          end
        end
        object TabSheet5: TTabSheet
          Caption = '???(????)'
          ImageIndex = 1
          object ButtonNext2: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = '???(&N)'
            TabOrder = 0
            OnClick = ButtonNext2Click
          end
          object GroupBox2: TGroupBox
            Left = 10
            Top = 10
            Width = 611
            Height = 221
            Caption = '??????'
            TabOrder = 1
            object GroupBox7: TGroupBox
              Left = 10
              Top = 20
              Width = 161
              Height = 91
              Caption = '????'
              TabOrder = 0
              object Label9: TLabel
                Left = 10
                Top = 25
                Width = 24
                Height = 15
                Caption = '??X:'
              end
              object Label10: TLabel
                Left = 10
                Top = 55
                Width = 23
                Height = 15
                Caption = '??Y:'
              end
              object EditLoginGate_MainFormX: TSpinEdit
                Left = 60
                Top = 20
                Width = 81
                Height = 21
                Hint = '?????????????,??X?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditLoginGate_MainFormXChange
              end
              object EditLoginGate_MainFormY: TSpinEdit
                Left = 60
                Top = 50
                Width = 81
                Height = 21
                Hint = '?????????????,??Y?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditLoginGate_MainFormYChange
              end
            end
            object ButtonLoginGateDefault: TButton
              Left = 500
              Top = 180
              Width = 101
              Height = 31
              Caption = '????(&D)'
              TabOrder = 1
              OnClick = ButtonLoginGateDefaultClick
            end
            object GroupBox23: TGroupBox
              Left = 180
              Top = 20
              Width = 161
              Height = 61
              Caption = '?????'
              TabOrder = 2
              object Label28: TLabel
                Left = 10
                Top = 25
                Width = 17
                Height = 15
                Caption = '??:'
              end
              object EditLoginGate_GatePort: TEdit
                Left = 70
                Top = 20
                Width = 51
                Height = 20
                TabOrder = 0
                Text = '7000'
              end
            end
            object GroupBox27: TGroupBox
              Left = 10
              Top = 120
              Width = 181
              Height = 51
              Caption = '????'
              TabOrder = 3
              object CheckBoxboLoginGate_GetStart: TCheckBox
                Left = 10
                Top = 20
                Width = 161
                Height = 21
                Caption = '??????'
                TabOrder = 0
                OnClick = CheckBoxboLoginGate_GetStartClick
              end
            end
          end
          object ButtonPrv2: TButton
            Left = 400
            Top = 329
            Width = 101
            Height = 41
            Caption = '???(&P)'
            TabOrder = 2
            OnClick = ButtonPrv2Click
          end
        end
        object TabSheet6: TTabSheet
          Caption = '???(????)'
          ImageIndex = 2
          object GroupBox3: TGroupBox
            Left = 10
            Top = 10
            Width = 611
            Height = 221
            Caption = '??????'
            TabOrder = 0
            object GroupBox8: TGroupBox
              Left = 10
              Top = 20
              Width = 161
              Height = 91
              Caption = '????'
              TabOrder = 0
              object Label11: TLabel
                Left = 10
                Top = 25
                Width = 24
                Height = 15
                Caption = '??X:'
              end
              object Label12: TLabel
                Left = 10
                Top = 55
                Width = 23
                Height = 15
                Caption = '??Y:'
              end
              object EditSelGate_MainFormX: TSpinEdit
                Left = 60
                Top = 20
                Width = 81
                Height = 21
                Hint = '?????????????,??X?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditSelGate_MainFormXChange
              end
              object EditSelGate_MainFormY: TSpinEdit
                Left = 60
                Top = 50
                Width = 81
                Height = 21
                Hint = '?????????????,??Y?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditSelGate_MainFormYChange
              end
            end
            object ButtonSelGateDefault: TButton
              Left = 500
              Top = 180
              Width = 101
              Height = 31
              Caption = '????(&D)'
              TabOrder = 1
              OnClick = ButtonSelGateDefaultClick
            end
            object GroupBox24: TGroupBox
              Left = 180
              Top = 20
              Width = 161
              Height = 91
              Caption = '?????'
              TabOrder = 2
              object Label29: TLabel
                Left = 10
                Top = 25
                Width = 17
                Height = 15
                Caption = '??:'
              end
              object Label49: TLabel
                Left = 10
                Top = 55
                Width = 17
                Height = 15
                Caption = '??:'
              end
              object EditSelGate_GatePort: TEdit
                Left = 70
                Top = 20
                Width = 51
                Height = 20
                TabOrder = 0
                Text = '7100'
              end
              object EditSelGate_GatePort1: TEdit
                Left = 70
                Top = 50
                Width = 51
                Height = 20
                TabOrder = 1
                Text = '7100'
              end
            end
            object GroupBox28: TGroupBox
              Left = 10
              Top = 120
              Width = 191
              Height = 51
              Caption = '????'
              TabOrder = 3
              object CheckBoxboSelGate_GetStart: TCheckBox
                Left = 10
                Top = 20
                Width = 161
                Height = 21
                Caption = '??????'
                TabOrder = 0
                OnClick = CheckBoxboSelGate_GetStartClick
              end
            end
          end
          object ButtonPrv3: TButton
            Left = 400
            Top = 329
            Width = 101
            Height = 41
            Caption = '???(&P)'
            TabOrder = 1
            OnClick = ButtonPrv3Click
          end
          object ButtonNext3: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = '???(&N)'
            TabOrder = 2
            OnClick = ButtonNext3Click
          end
        end
        object TabSheet12: TTabSheet
          Caption = '???(????)'
          ImageIndex = 8
          object ButtonPrv4: TButton
            Left = 400
            Top = 329
            Width = 101
            Height = 41
            Caption = '???(&P)'
            TabOrder = 0
            OnClick = ButtonPrv4Click
          end
          object ButtonNext4: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = '???(&N)'
            TabOrder = 1
            OnClick = ButtonNext4Click
          end
          object GroupBox17: TGroupBox
            Left = 10
            Top = 10
            Width = 611
            Height = 221
            Caption = '??????'
            TabOrder = 2
            object GroupBox18: TGroupBox
              Left = 10
              Top = 20
              Width = 161
              Height = 91
              Caption = '????'
              Enabled = False
              TabOrder = 0
              object Label21: TLabel
                Left = 10
                Top = 25
                Width = 24
                Height = 15
                Caption = '??X:'
                Enabled = False
              end
              object Label22: TLabel
                Left = 10
                Top = 55
                Width = 23
                Height = 15
                Caption = '??Y:'
                Enabled = False
              end
              object EditRunGate_MainFormX: TSpinEdit
                Left = 60
                Top = 20
                Width = 81
                Height = 21
                Hint = '?????????????,??X?'
                Enabled = False
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
              end
              object EditRunGate_MainFormY: TSpinEdit
                Left = 60
                Top = 50
                Width = 81
                Height = 21
                Hint = '?????????????,??Y?'
                Enabled = False
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
              end
            end
            object GroupBox19: TGroupBox
              Left = 10
              Top = 120
              Width = 161
              Height = 71
              Caption = '??????'
              TabOrder = 1
              object Label23: TLabel
                Left = 10
                Top = 25
                Width = 17
                Height = 15
                Caption = '??:'
              end
              object EditRunGate_Connt: TSpinEdit
                Left = 60
                Top = 20
                Width = 81
                Height = 21
                Hint = '??????????,??200?????????,400?????????,400??????????'
                MaxValue = 8
                MinValue = 1
                TabOrder = 0
                Value = 1
                OnChange = EditRunGate_ConntChange
              end
            end
            object GroupBox22: TGroupBox
              Left = 180
              Top = 20
              Width = 261
              Height = 171
              Caption = '?????'
              TabOrder = 2
              object LabelRunGate_GatePort1: TLabel
                Left = 10
                Top = 25
                Width = 10
                Height = 15
                Caption = '?:'
              end
              object LabelLabelRunGate_GatePort2: TLabel
                Left = 10
                Top = 55
                Width = 10
                Height = 15
                Caption = '?:'
              end
              object LabelRunGate_GatePort3: TLabel
                Left = 10
                Top = 85
                Width = 10
                Height = 15
                Caption = '?:'
              end
              object LabelRunGate_GatePort4: TLabel
                Left = 10
                Top = 115
                Width = 10
                Height = 15
                Caption = '?:'
              end
              object LabelRunGate_GatePort5: TLabel
                Left = 10
                Top = 145
                Width = 10
                Height = 15
                Caption = '?:'
              end
              object LabelRunGate_GatePort6: TLabel
                Left = 130
                Top = 25
                Width = 10
                Height = 15
                Caption = '?:'
              end
              object LabelRunGate_GatePort7: TLabel
                Left = 130
                Top = 55
                Width = 10
                Height = 15
                Caption = '?:'
              end
              object LabelRunGate_GatePort78: TLabel
                Left = 130
                Top = 85
                Width = 10
                Height = 15
                Caption = '?:'
              end
              object EditRunGate_GatePort1: TEdit
                Left = 70
                Top = 20
                Width = 51
                Height = 20
                TabOrder = 0
                Text = '7200'
              end
              object EditRunGate_GatePort2: TEdit
                Left = 70
                Top = 50
                Width = 51
                Height = 20
                TabOrder = 1
                Text = '7200'
              end
              object EditRunGate_GatePort3: TEdit
                Left = 70
                Top = 80
                Width = 51
                Height = 20
                TabOrder = 2
                Text = '7200'
              end
              object EditRunGate_GatePort4: TEdit
                Left = 70
                Top = 110
                Width = 51
                Height = 20
                TabOrder = 3
                Text = '7200'
              end
              object EditRunGate_GatePort5: TEdit
                Left = 70
                Top = 140
                Width = 51
                Height = 20
                TabOrder = 4
                Text = '7200'
              end
              object EditRunGate_GatePort6: TEdit
                Left = 190
                Top = 20
                Width = 51
                Height = 20
                TabOrder = 5
                Text = '7200'
              end
              object EditRunGate_GatePort7: TEdit
                Left = 190
                Top = 50
                Width = 51
                Height = 20
                TabOrder = 6
                Text = '7200'
              end
              object EditRunGate_GatePort8: TEdit
                Left = 190
                Top = 80
                Width = 51
                Height = 20
                TabOrder = 7
                Text = '7200'
              end
            end
            object ButtonRunGateDefault: TButton
              Left = 500
              Top = 180
              Width = 101
              Height = 31
              Caption = '????(&D)'
              TabOrder = 3
              OnClick = ButtonRunGateDefaultClick
            end
          end
        end
        object TabSheet7: TTabSheet
          Caption = '???(?????)'
          ImageIndex = 3
          object GroupBox9: TGroupBox
            Left = 10
            Top = 10
            Width = 611
            Height = 221
            Caption = '???????'
            TabOrder = 0
            object GroupBox10: TGroupBox
              Left = 10
              Top = 20
              Width = 161
              Height = 91
              Caption = '????'
              TabOrder = 0
              object Label13: TLabel
                Left = 10
                Top = 25
                Width = 24
                Height = 15
                Caption = '??X:'
              end
              object Label14: TLabel
                Left = 10
                Top = 55
                Width = 23
                Height = 15
                Caption = '??Y:'
              end
              object EditLoginServer_MainFormX: TSpinEdit
                Left = 60
                Top = 20
                Width = 81
                Height = 21
                Hint = '?????????????,??X?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditLoginServer_MainFormXChange
              end
              object EditLoginServer_MainFormY: TSpinEdit
                Left = 60
                Top = 50
                Width = 81
                Height = 21
                Hint = '?????????????,??Y?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditLoginServer_MainFormYChange
              end
            end
            object ButtonLoginServerConfig: TButton
              Left = 390
              Top = 180
              Width = 101
              Height = 31
              Caption = '????'
              TabOrder = 1
              Visible = False
              OnClick = ButtonLoginServerConfigClick
            end
            object ButtonLoginSrvDefault: TButton
              Left = 500
              Top = 180
              Width = 101
              Height = 31
              Caption = '????(&D)'
              TabOrder = 2
              OnClick = ButtonLoginSrvDefaultClick
            end
            object GroupBox33: TGroupBox
              Left = 180
              Top = 20
              Width = 261
              Height = 91
              Caption = '???????'
              TabOrder = 3
              object Label50: TLabel
                Left = 10
                Top = 25
                Width = 31
                Height = 15
                Caption = '????:'
              end
              object Label51: TLabel
                Left = 10
                Top = 55
                Width = 31
                Height = 15
                Caption = '????:'
              end
              object EditLoginServerGatePort: TEdit
                Left = 80
                Top = 20
                Width = 51
                Height = 20
                TabOrder = 0
                Text = '7200'
              end
              object EditLoginServerServerPort: TEdit
                Left = 80
                Top = 50
                Width = 51
                Height = 20
                TabOrder = 1
                Text = '7200'
              end
            end
            object GroupBox34: TGroupBox
              Left = 10
              Top = 120
              Width = 201
              Height = 51
              Caption = '????'
              TabOrder = 4
              object CheckBoxboLoginServer_GetStart: TCheckBox
                Left = 10
                Top = 20
                Width = 171
                Height = 21
                Caption = '???????'
                TabOrder = 0
                OnClick = CheckBoxboLoginServer_GetStartClick
              end
            end
          end
          object ButtonPrv5: TButton
            Left = 400
            Top = 329
            Width = 101
            Height = 41
            Caption = '???(&P)'
            TabOrder = 1
            OnClick = ButtonPrv5Click
          end
          object ButtonNext5: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = '???(&N)'
            TabOrder = 2
            OnClick = ButtonNext5Click
          end
        end
        object TabSheet8: TTabSheet
          Caption = '???(??????)'
          ImageIndex = 4
          object GroupBox11: TGroupBox
            Left = 10
            Top = 10
            Width = 611
            Height = 221
            Caption = '????????'
            TabOrder = 0
            object GroupBox12: TGroupBox
              Left = 10
              Top = 20
              Width = 161
              Height = 91
              Caption = '????'
              TabOrder = 0
              object Label15: TLabel
                Left = 10
                Top = 25
                Width = 24
                Height = 15
                Caption = '??X:'
              end
              object Label16: TLabel
                Left = 10
                Top = 55
                Width = 23
                Height = 15
                Caption = '??Y:'
              end
              object EditDBServer_MainFormX: TSpinEdit
                Left = 60
                Top = 20
                Width = 81
                Height = 21
                Hint = '?????????????,??X?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditDBServer_MainFormXChange
              end
              object EditDBServer_MainFormY: TSpinEdit
                Left = 60
                Top = 50
                Width = 81
                Height = 21
                Hint = '?????????????,??Y?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditDBServer_MainFormYChange
              end
            end
            object GroupBox20: TGroupBox
              Left = 180
              Top = 120
              Width = 161
              Height = 51
              Caption = '??????'
              TabOrder = 1
              Visible = False
              object CheckBoxDisableAutoGame: TCheckBox
                Left = 10
                Top = 20
                Width = 131
                Height = 21
                Caption = '??????'
                TabOrder = 0
                OnClick = CheckBoxDisableAutoGameClick
              end
            end
            object ButtonDBServerDefault: TButton
              Left = 500
              Top = 180
              Width = 101
              Height = 31
              Caption = '????(&D)'
              TabOrder = 2
              OnClick = ButtonDBServerDefaultClick
            end
            object GroupBox35: TGroupBox
              Left = 10
              Top = 120
              Width = 161
              Height = 51
              Caption = '????'
              TabOrder = 3
              object CheckBoxDBServerGetStart: TCheckBox
                Left = 10
                Top = 20
                Width = 141
                Height = 21
                Caption = '????????'
                TabOrder = 0
                OnClick = CheckBoxDBServerGetStartClick
              end
            end
            object GroupBox36: TGroupBox
              Left = 180
              Top = 20
              Width = 261
              Height = 91
              Caption = '???????'
              TabOrder = 4
              object Label52: TLabel
                Left = 10
                Top = 25
                Width = 31
                Height = 15
                Caption = '????:'
              end
              object Label53: TLabel
                Left = 10
                Top = 55
                Width = 31
                Height = 15
                Caption = '????:'
              end
              object EditDBServerGatePort: TEdit
                Left = 80
                Top = 20
                Width = 51
                Height = 20
                TabOrder = 0
                Text = '5100'
              end
              object EditDBServerServerPort: TEdit
                Left = 80
                Top = 50
                Width = 51
                Height = 20
                TabOrder = 1
                Text = '6000'
              end
            end
          end
          object ButtonPrv6: TButton
            Left = 400
            Top = 329
            Width = 101
            Height = 41
            Caption = '???(&P)'
            TabOrder = 1
            OnClick = ButtonPrv6Click
          end
          object ButtonNext6: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = '???(&N)'
            TabOrder = 2
            OnClick = ButtonNext6Click
          end
        end
        object TabSheet9: TTabSheet
          Caption = '???(???????)'
          ImageIndex = 5
          object GroupBox13: TGroupBox
            Left = 10
            Top = 10
            Width = 611
            Height = 221
            Caption = '?????????'
            TabOrder = 0
            object GroupBox14: TGroupBox
              Left = 10
              Top = 20
              Width = 161
              Height = 91
              Caption = '????'
              TabOrder = 0
              object Label17: TLabel
                Left = 10
                Top = 25
                Width = 24
                Height = 15
                Caption = '??X:'
              end
              object Label18: TLabel
                Left = 10
                Top = 55
                Width = 23
                Height = 15
                Caption = '??Y:'
              end
              object EditLogServer_MainFormX: TSpinEdit
                Left = 60
                Top = 20
                Width = 81
                Height = 21
                Hint = '?????????????,??X?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditLogServer_MainFormXChange
              end
              object EditLogServer_MainFormY: TSpinEdit
                Left = 60
                Top = 50
                Width = 81
                Height = 21
                Hint = '?????????????,??Y?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditLogServer_MainFormYChange
              end
            end
            object ButtonLogServerDefault: TButton
              Left = 500
              Top = 180
              Width = 101
              Height = 31
              Caption = '????(&D)'
              TabOrder = 1
              OnClick = ButtonLogServerDefaultClick
            end
            object GroupBox37: TGroupBox
              Left = 10
              Top = 120
              Width = 161
              Height = 51
              Caption = '????'
              TabOrder = 2
              object CheckBoxLogServerGetStart: TCheckBox
                Left = 10
                Top = 20
                Width = 141
                Height = 21
                Caption = '???????'
                TabOrder = 0
                OnClick = CheckBoxLogServerGetStartClick
              end
            end
            object GroupBox38: TGroupBox
              Left = 180
              Top = 20
              Width = 261
              Height = 91
              Caption = '????'
              TabOrder = 3
              object Label54: TLabel
                Left = 10
                Top = 25
                Width = 31
                Height = 15
                Caption = '????:'
              end
              object EditLogServerPort: TEdit
                Left = 80
                Top = 20
                Width = 51
                Height = 20
                TabOrder = 0
                Text = '10000'
              end
            end
          end
          object ButtonPrv7: TButton
            Left = 400
            Top = 329
            Width = 101
            Height = 41
            Caption = '???(&P)'
            TabOrder = 1
            OnClick = ButtonPrv7Click
          end
          object ButtonNext7: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = '???(&N)'
            TabOrder = 2
            OnClick = ButtonNext7Click
          end
        end
        object TabSheet10: TTabSheet
          Caption = '???(????????)'
          ImageIndex = 6
          object GroupBox15: TGroupBox
            Left = 10
            Top = 10
            Width = 611
            Height = 221
            Caption = '?????????'
            TabOrder = 0
            object GroupBox16: TGroupBox
              Left = 10
              Top = 20
              Width = 161
              Height = 91
              Caption = '????'
              TabOrder = 0
              object Label19: TLabel
                Left = 10
                Top = 25
                Width = 24
                Height = 15
                Caption = '??X:'
              end
              object Label20: TLabel
                Left = 10
                Top = 55
                Width = 23
                Height = 15
                Caption = '??Y:'
              end
              object EditM2Server_MainFormX: TSpinEdit
                Left = 60
                Top = 20
                Width = 81
                Height = 21
                Hint = '?????????????,??X?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditM2Server_MainFormXChange
              end
              object EditM2Server_MainFormY: TSpinEdit
                Left = 60
                Top = 50
                Width = 81
                Height = 21
                Hint = '?????????????,??Y?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditM2Server_MainFormYChange
              end
            end
            object ButtonM2ServerDefault: TButton
              Left = 500
              Top = 180
              Width = 101
              Height = 31
              Caption = '????(&D)'
              TabOrder = 1
              OnClick = ButtonM2ServerDefaultClick
            end
            object GroupBox32: TGroupBox
              Left = 420
              Top = 20
              Width = 181
              Height = 91
              Caption = '????'
              TabOrder = 2
              object Label61: TLabel
                Left = 10
                Top = 25
                Width = 31
                Height = 15
                Caption = '????:'
              end
              object Label62: TLabel
                Left = 10
                Top = 55
                Width = 31
                Height = 15
                Caption = '????:'
              end
              object EditM2Server_TestLevel: TSpinEdit
                Left = 85
                Top = 20
                Width = 86
                Height = 21
                Hint = '???????'
                MaxValue = 20000
                MinValue = 0
                TabOrder = 0
                Value = 10
                OnChange = EditM2Server_TestLevelChange
              end
              object EditM2Server_TestGold: TSpinEdit
                Left = 85
                Top = 50
                Width = 86
                Height = 21
                Hint = '????????????'
                Increment = 1000
                MaxValue = 20000000
                MinValue = 0
                TabOrder = 1
                Value = 10
                OnChange = EditM2Server_TestGoldChange
              end
            end
            object GroupBox39: TGroupBox
              Left = 180
              Top = 20
              Width = 231
              Height = 91
              Caption = '???????'
              TabOrder = 3
              object Label55: TLabel
                Left = 10
                Top = 25
                Width = 31
                Height = 15
                Caption = '????:'
              end
              object Label56: TLabel
                Left = 10
                Top = 55
                Width = 31
                Height = 15
                Caption = '????:'
              end
              object EditM2ServerGatePort: TEdit
                Left = 80
                Top = 20
                Width = 51
                Height = 20
                TabOrder = 0
                Text = '5000'
              end
              object EditM2ServerMsgSrvPort: TEdit
                Left = 80
                Top = 50
                Width = 51
                Height = 20
                TabOrder = 1
                Text = '4900'
              end
            end
            object GroupBox40: TGroupBox
              Left = 10
              Top = 120
              Width = 241
              Height = 51
              Caption = '????'
              TabOrder = 4
              object CheckBoxM2ServerGetStart: TCheckBox
                Left = 10
                Top = 20
                Width = 211
                Height = 21
                Caption = '???????'
                TabOrder = 0
                OnClick = CheckBoxM2ServerGetStartClick
              end
            end
          end
          object ButtonPrv8: TButton
            Left = 400
            Top = 329
            Width = 101
            Height = 41
            Caption = '???(&P)'
            TabOrder = 1
            OnClick = ButtonPrv8Click
          end
          object ButtonNext8: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = '???(&N)'
            TabOrder = 2
            OnClick = ButtonNext8Click
          end
        end
        object TabSheet11: TTabSheet
          Caption = '???(????)'
          ImageIndex = 7
          object ButtonSave: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = '??(&S)'
            TabOrder = 0
            OnClick = ButtonSaveClick
          end
          object ButtonGenGameConfig: TButton
            Left = 290
            Top = 329
            Width = 101
            Height = 41
            Caption = '????(&G)'
            TabOrder = 1
            OnClick = ButtonGenGameConfigClick
          end
          object ButtonPrv9: TButton
            Left = 400
            Top = 329
            Width = 101
            Height = 41
            Caption = '???(&P)'
            TabOrder = 2
            OnClick = ButtonPrv9Click
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = '????'
      ImageIndex = 2
      object LabelBackMsg: TLabel
        Left = 480
        Top = 380
        Width = 8
        Height = 15
        Font.Charset = GB2312_CHARSET
        Font.Color = clGreen
        Font.Height = -15
        Font.Name = '??'
        Font.Style = []
        ParentFont = False
      end
      object GroupBox4: TGroupBox
        Left = 10
        Top = 10
        Width = 621
        Height = 191
        Caption = '????'
        TabOrder = 0
        object ListViewDataBackup: TListView
          Left = 10
          Top = 20
          Width = 601
          Height = 161
          Columns = <
            item
              Caption = '????'
              Width = 275
            end
            item
              Caption = '????'
              Width = 275
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
        Left = 10
        Top = 210
        Width = 621
        Height = 151
        Caption = '??'
        TabOrder = 1
        object Label5: TLabel
          Left = 10
          Top = 25
          Width = 31
          Height = 15
          Caption = '????:'
        end
        object Label6: TLabel
          Left = 10
          Top = 55
          Width = 31
          Height = 15
          Caption = '????:'
        end
        object Label7: TLabel
          Left = 150
          Top = 85
          Width = 7
          Height = 15
          Caption = '?'
        end
        object Label8: TLabel
          Left = 250
          Top = 85
          Width = 7
          Height = 15
          Caption = '?'
        end
        object Label64: TLabel
          Left = 145
          Top = 115
          Width = 14
          Height = 15
          Caption = '??'
        end
        object Label65: TLabel
          Left = 250
          Top = 115
          Width = 7
          Height = 15
          Caption = '?'
        end
        object RadioButtonBackMode1: TRadioButton
          Left = 10
          Top = 80
          Width = 61
          Height = 21
          Caption = '??'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = RadioButtonBackMode1Click
        end
        object RzButtonEditSource: TRzButtonEdit
          Left = 80
          Top = 20
          Width = 531
          Height = 23
          TabOrder = 1
          AltBtnWidth = 19
          ButtonWidth = 19
          OnButtonClick = RzButtonEditSourceButtonClick
        end
        object RzButtonEditDest: TRzButtonEdit
          Left = 80
          Top = 50
          Width = 531
          Height = 23
          TabOrder = 2
          AltBtnWidth = 19
          ButtonWidth = 19
          OnButtonClick = RzButtonEditDestButtonClick
        end
        object RadioButtonBackMode2: TRadioButton
          Left = 10
          Top = 110
          Width = 61
          Height = 21
          Caption = '??'
          TabOrder = 3
          OnClick = RadioButtonBackMode2Click
        end
        object RzSpinEditHour1: TRzSpinEdit
          Left = 80
          Top = 80
          Width = 59
          Height = 23
          Max = 23.000000000000000000
          TabOrder = 4
        end
        object RzSpinEditHour2: TRzSpinEdit
          Left = 80
          Top = 110
          Width = 59
          Height = 23
          Max = 10000000000.000000000000000000
          TabOrder = 5
        end
        object RzSpinEditMin1: TRzSpinEdit
          Left = 180
          Top = 80
          Width = 59
          Height = 23
          Max = 59.000000000000000000
          TabOrder = 6
        end
        object CheckBoxBackUp: TCheckBox
          Left = 280
          Top = 100
          Width = 61
          Height = 21
          Caption = '??'
          TabOrder = 7
        end
        object RzSpinEditMin2: TRzSpinEdit
          Left = 180
          Top = 110
          Width = 59
          Height = 23
          Max = 59.000000000000000000
          TabOrder = 8
        end
        object CheckBoxZip: TCheckBox
          Left = 360
          Top = 100
          Width = 61
          Height = 21
          Caption = '??'
          TabOrder = 9
        end
      end
      object ButtonBackChg: TButton
        Left = 10
        Top = 370
        Width = 81
        Height = 31
        Caption = '??(&C)'
        TabOrder = 2
        OnClick = ButtonBackChgClick
      end
      object ButtonBackDel: TButton
        Left = 100
        Top = 370
        Width = 81
        Height = 31
        Caption = '??(&D)'
        TabOrder = 3
        OnClick = ButtonBackDelClick
      end
      object ButtonBackAdd: TButton
        Left = 190
        Top = 370
        Width = 81
        Height = 31
        Caption = '??(&A)'
        TabOrder = 4
        OnClick = ButtonBackAddClick
      end
      object ButtonBackStart: TButton
        Left = 370
        Top = 370
        Width = 94
        Height = 31
        Caption = '??(&B)'
        TabOrder = 5
        OnClick = ButtonBackStartClick
      end
      object ButtonBackSave: TButton
        Left = 280
        Top = 370
        Width = 81
        Height = 31
        Caption = '??(&S)'
        TabOrder = 6
        OnClick = ButtonBackSaveClick
      end
    end
    object TabSheet13: TTabSheet
      Caption = 'Game Info'
      ImageIndex = 3
      object GroupBox41: TGroupBox
        Left = 10
        Top = 10
        Width = 621
        Height = 291
        Caption = '????'
        TabOrder = 0
        object LabelVersion: TLabel
          Left = 10
          Top = 20
          Width = 151
          Height = 15
          Caption = '????: MakeGM??????????'
        end
        object Label60: TLabel
          Left = 10
          Top = 40
          Width = 51
          Height = 15
          Caption = '????: 2.0'
        end
        object Label63: TLabel
          Left = 10
          Top = 60
          Width = 96
          Height = 15
          Caption = '????: 2010/09/01'
        end
      end
    end
    object TabSheetDebug: TTabSheet
      Caption = '??'
      ImageIndex = 6
      object GroupBox29: TGroupBox
        Left = 10
        Top = 0
        Width = 621
        Height = 411
        Caption = '????'
        TabOrder = 0
        object GroupBox30: TGroupBox
          Left = 10
          Top = 20
          Width = 331
          Height = 141
          Caption = '????'
          TabOrder = 0
          object Label45: TLabel
            Left = 10
            Top = 25
            Width = 17
            Height = 15
            Caption = '??:'
          end
          object Label46: TLabel
            Left = 10
            Top = 55
            Width = 24
            Height = 15
            Caption = '???:'
          end
          object Label58: TLabel
            Left = 10
            Top = 85
            Width = 24
            Height = 15
            Caption = '???:'
          end
          object EditM2CheckCodeAddr: TEdit
            Left = 70
            Top = 20
            Width = 121
            Height = 23
            TabOrder = 0
          end
          object EditM2CheckCode: TEdit
            Left = 70
            Top = 50
            Width = 121
            Height = 23
            TabOrder = 1
          end
          object ButtonM2Suspend: TButton
            Left = 250
            Top = 40
            Width = 71
            Height = 31
            Caption = '????'
            TabOrder = 2
            Visible = False
            OnClick = ButtonM2SuspendClick
          end
          object EditM2CheckStr: TEdit
            Left = 70
            Top = 80
            Width = 251
            Height = 23
            TabOrder = 3
          end
        end
        object GroupBox31: TGroupBox
          Left = 10
          Top = 170
          Width = 331
          Height = 131
          Caption = '???'
          TabOrder = 1
          object Label47: TLabel
            Left = 10
            Top = 25
            Width = 17
            Height = 15
            Caption = '??:'
          end
          object Label48: TLabel
            Left = 10
            Top = 55
            Width = 24
            Height = 15
            Caption = '???:'
          end
          object Label57: TLabel
            Left = 10
            Top = 85
            Width = 21
            Height = 15
            Caption = '???'
          end
          object EditDBCheckCodeAddr: TEdit
            Left = 70
            Top = 20
            Width = 121
            Height = 23
            TabOrder = 0
          end
          object EditDBCheckCode: TEdit
            Left = 70
            Top = 50
            Width = 121
            Height = 23
            TabOrder = 1
          end
          object Button3: TButton
            Left = 250
            Top = 40
            Width = 71
            Height = 31
            Caption = '????'
            TabOrder = 2
            Visible = False
            OnClick = ButtonM2SuspendClick
          end
          object EditDBCheckStr: TEdit
            Left = 70
            Top = 80
            Width = 251
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
