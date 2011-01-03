object FrmRankingDlg: TFrmRankingDlg
  Left = 709
  Top = 244
  BorderStyle = bsDialog
  Caption = 'Ranking'
  ClientHeight = 465
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 433
    Height = 97
    Caption = '?????'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 44
      Width = 23
      Height = 16
      Caption = '????:'
    end
    object Label2: TLabel
      Left = 8
      Top = 68
      Width = 23
      Height = 16
      Caption = '????:'
    end
    object Label3: TLabel
      Left = 128
      Top = 44
      Width = 5
      Height = 16
      Caption = '?'
    end
    object Label4: TLabel
      Left = 128
      Top = 68
      Width = 5
      Height = 16
      Caption = '?'
    end
    object Label5: TLabel
      Left = 256
      Top = 42
      Width = 5
      Height = 16
      Caption = '?'
    end
    object Label6: TLabel
      Left = 256
      Top = 66
      Width = 10
      Height = 16
      Caption = '??'
    end
    object Label7: TLabel
      Left = 344
      Top = 42
      Width = 5
      Height = 16
      Caption = '?'
    end
    object Label8: TLabel
      Left = 344
      Top = 66
      Width = 5
      Height = 16
      Caption = '?'
    end
    object CheckBoxAutoRefRanking: TCheckBox
      Left = 8
      Top = 16
      Width = 105
      Height = 17
      Caption = '???????'
      TabOrder = 0
      OnClick = CheckBoxAutoRefRankingClick
    end
    object EditMinLevel: TSpinEdit
      Left = 64
      Top = 40
      Width = 57
      Height = 26
      MaxValue = 65535
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = EditMinLevelChange
    end
    object EditMaxLevel: TSpinEdit
      Left = 64
      Top = 64
      Width = 57
      Height = 26
      MaxValue = 65535
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnChange = EditMaxLevelChange
    end
    object RadioButton1: TRadioButton
      Left = 144
      Top = 42
      Width = 49
      Height = 17
      Caption = '??'
      TabOrder = 3
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 144
      Top = 66
      Width = 49
      Height = 17
      Caption = '??'
      Checked = True
      TabOrder = 4
      TabStop = True
      OnClick = RadioButton1Click
    end
    object EditTime: TSpinEdit
      Left = 200
      Top = 40
      Width = 49
      Height = 26
      MaxValue = 65535
      MinValue = 0
      TabOrder = 5
      Value = 0
      OnChange = EditTimeChange
    end
    object EditHour: TSpinEdit
      Left = 200
      Top = 64
      Width = 49
      Height = 26
      MaxValue = 65535
      MinValue = 0
      TabOrder = 6
      Value = 0
      OnChange = EditHourChange
    end
    object EditMinute1: TSpinEdit
      Left = 288
      Top = 40
      Width = 49
      Height = 26
      MaxValue = 65535
      MinValue = 0
      TabOrder = 7
      Value = 0
      OnChange = EditMinute1Change
    end
    object EditMinute2: TSpinEdit
      Left = 288
      Top = 64
      Width = 49
      Height = 26
      MaxValue = 65535
      MinValue = 0
      TabOrder = 8
      Value = 0
      OnChange = EditMinute2Change
    end
    object ButtonSave: TButton
      Left = 366
      Top = 38
      Width = 59
      Height = 20
      Caption = '??(&S)'
      TabOrder = 9
      OnClick = ButtonSaveClick
    end
    object ButtonRefRanking: TButton
      Left = 366
      Top = 64
      Width = 59
      Height = 20
      Caption = '??(&R)'
      TabOrder = 10
      OnClick = ButtonRefRankingClick
    end
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 112
    Width = 433
    Height = 345
    ActivePage = TabSheet3
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Characters'
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 425
        Height = 314
        ActivePage = TabSheet10
        Align = alClient
        TabOrder = 0
        object TabSheet4: TTabSheet
          Caption = 'All'
          object ListViewHum: TListView
            Left = 0
            Top = 0
            Width = 417
            Height = 283
            Align = alClient
            Columns = <
              item
                Caption = 'Class'
                Width = 60
              end
              item
                Caption = 'Name'
                Width = 100
              end
              item
                Caption = 'Level'
                Width = 60
              end>
            GridLines = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object TabSheet5: TTabSheet
          Caption = 'Warrior'
          ImageIndex = 1
          object ListViewWarrior: TListView
            Left = 0
            Top = 0
            Width = 417
            Height = 283
            Align = alClient
            Columns = <
              item
                Caption = 'Index'
                Width = 60
              end
              item
                Caption = 'Name'
                Width = 100
              end
              item
                Caption = 'Level'
                Width = 60
              end>
            GridLines = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object TabSheet6: TTabSheet
          Caption = 'Wizard'
          ImageIndex = 2
          object ListViewWizzard: TListView
            Left = 0
            Top = 0
            Width = 417
            Height = 283
            Align = alClient
            Columns = <
              item
                Caption = 'Index'
                Width = 60
              end
              item
                Caption = 'Name'
                Width = 100
              end
              item
                Caption = 'level'
                Width = 60
              end>
            GridLines = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object TabSheet10: TTabSheet
          Caption = 'Taoist'
          ImageIndex = 3
          object ListViewMonk: TListView
            Left = 0
            Top = 0
            Width = 417
            Height = 283
            Align = alClient
            Columns = <
              item
                Caption = 'Index'
                Width = 60
              end
              item
                Caption = 'Name'
                Width = 100
              end
              item
                Caption = 'Level'
                Width = 60
              end>
            GridLines = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Hero'
      ImageIndex = 1
      object PageControl3: TPageControl
        Left = 0
        Top = 0
        Width = 425
        Height = 314
        ActivePage = TabSheet11
        Align = alClient
        TabOrder = 0
        object TabSheet7: TTabSheet
          Caption = 'All'
          object ListViewHero: TListView
            Left = 0
            Top = 0
            Width = 417
            Height = 283
            Align = alClient
            Columns = <
              item
                Caption = 'Class'
                Width = 60
              end
              item
                Caption = 'Name'
                Width = 100
              end
              item
                Caption = 'Owner'
                Width = 100
              end
              item
                Caption = 'Level'
                Width = 60
              end>
            GridLines = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object TabSheet8: TTabSheet
          Caption = 'Warrior'
          ImageIndex = 1
          object ListViewHeroWarrior: TListView
            Left = 0
            Top = 0
            Width = 417
            Height = 283
            Align = alClient
            Columns = <
              item
                Caption = 'Index'
                Width = 60
              end
              item
                Caption = 'name'
                Width = 100
              end
              item
                Caption = 'Owner'
                Width = 100
              end
              item
                Caption = 'Level'
                Width = 60
              end>
            GridLines = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object TabSheet9: TTabSheet
          Caption = 'Wizard'
          ImageIndex = 2
          object ListViewHeroWizzard: TListView
            Left = 0
            Top = 0
            Width = 417
            Height = 283
            Align = alClient
            Columns = <
              item
                Caption = 'Index'
                Width = 60
              end
              item
                Caption = 'Name'
                Width = 100
              end
              item
                Caption = 'Owner'
                Width = 100
              end
              item
                Caption = 'Class'
                Width = 60
              end>
            GridLines = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object TabSheet11: TTabSheet
          Caption = 'Taoist'
          ImageIndex = 3
          object ListViewHeroMonk: TListView
            Left = 0
            Top = 0
            Width = 417
            Height = 283
            Align = alClient
            Columns = <
              item
                Caption = 'Index'
                Width = 60
              end
              item
                Caption = 'Name'
                Width = 100
              end
              item
                Caption = 'Owner'
                Width = 100
              end
              item
                Caption = 'Level'
                Width = 60
              end>
            GridLines = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Master'
      ImageIndex = 2
      object ListViewMaster: TListView
        Left = 0
        Top = 0
        Width = 425
        Height = 314
        Align = alClient
        Columns = <
          item
            Caption = 'Index'
            Width = 60
          end
          item
            Caption = 'Name'
            Width = 100
          end
          item
            Caption = 'Level'
            Width = 100
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
  end
end
