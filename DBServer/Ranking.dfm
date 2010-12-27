object FrmRankingDlg: TFrmRankingDlg
  Left = 709
  Top = 244
  BorderStyle = bsDialog
  Caption = #25490#34892#27036#31649#29702
  ClientHeight = 465
  ClientWidth = 450
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 433
    Height = 97
    Caption = #25490#34892#27036#35774#32622
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 44
      Width = 54
      Height = 12
      Caption = #36215#22987#31561#32423':'
    end
    object Label2: TLabel
      Left = 8
      Top = 68
      Width = 54
      Height = 12
      Caption = #26368#39640#31561#32423':'
    end
    object Label3: TLabel
      Left = 128
      Top = 44
      Width = 12
      Height = 12
      Caption = #32423
    end
    object Label4: TLabel
      Left = 128
      Top = 68
      Width = 12
      Height = 12
      Caption = #32423
    end
    object Label5: TLabel
      Left = 256
      Top = 42
      Width = 12
      Height = 12
      Caption = #28857
    end
    object Label6: TLabel
      Left = 256
      Top = 66
      Width = 24
      Height = 12
      Caption = #23567#26102
    end
    object Label7: TLabel
      Left = 344
      Top = 42
      Width = 12
      Height = 12
      Caption = #20998
    end
    object Label8: TLabel
      Left = 344
      Top = 66
      Width = 12
      Height = 12
      Caption = #20998
    end
    object CheckBoxAutoRefRanking: TCheckBox
      Left = 8
      Top = 16
      Width = 105
      Height = 17
      Caption = #33258#21160#21047#26032#25490#34892#27036
      TabOrder = 0
      OnClick = CheckBoxAutoRefRankingClick
    end
    object EditMinLevel: TSpinEdit
      Left = 64
      Top = 40
      Width = 57
      Height = 21
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
      Height = 21
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
      Caption = #27599#22825
      TabOrder = 3
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 144
      Top = 66
      Width = 49
      Height = 17
      Caption = #27599#38548
      Checked = True
      TabOrder = 4
      TabStop = True
      OnClick = RadioButton1Click
    end
    object EditTime: TSpinEdit
      Left = 200
      Top = 40
      Width = 49
      Height = 21
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
      Height = 21
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
      Height = 21
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
      Height = 21
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
      Caption = #20445#23384'(&S)'
      TabOrder = 9
      OnClick = ButtonSaveClick
    end
    object ButtonRefRanking: TButton
      Left = 366
      Top = 64
      Width = 59
      Height = 20
      Caption = #21047#26032'(&R)'
      TabOrder = 10
      OnClick = ButtonRefRankingClick
    end
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 112
    Width = 433
    Height = 345
    ActivePage = TabSheet1
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #20010#20154#27036
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 425
        Height = 318
        ActivePage = TabSheet4
        Align = alClient
        TabOrder = 0
        object TabSheet4: TTabSheet
          Caption = #32676#33521#27036
          object ListViewHum: TListView
            Left = 0
            Top = 0
            Width = 417
            Height = 291
            Align = alClient
            Columns = <
              item
                Caption = #24207#21495
                Width = 60
              end
              item
                Caption = #21517#31216
                Width = 100
              end
              item
                Caption = #31561#32423
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
          Caption = #25112#31070#27036
          ImageIndex = 1
          object ListViewWarrior: TListView
            Left = 0
            Top = 0
            Width = 417
            Height = 291
            Align = alClient
            Columns = <
              item
                Caption = #24207#21495
                Width = 60
              end
              item
                Caption = #21517#31216
                Width = 100
              end
              item
                Caption = #31561#32423
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
          Caption = #27861#22307#27036
          ImageIndex = 2
          object ListViewWizzard: TListView
            Left = 0
            Top = 0
            Width = 417
            Height = 291
            Align = alClient
            Columns = <
              item
                Caption = #24207#21495
                Width = 60
              end
              item
                Caption = #21517#31216
                Width = 100
              end
              item
                Caption = #31561#32423
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
          Caption = #36947#23562#27036
          ImageIndex = 3
          object ListViewMonk: TListView
            Left = 0
            Top = 0
            Width = 417
            Height = 291
            Align = alClient
            Columns = <
              item
                Caption = #24207#21495
                Width = 60
              end
              item
                Caption = #21517#31216
                Width = 100
              end
              item
                Caption = #31561#32423
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
      Caption = #33521#38596#27036
      ImageIndex = 1
      object PageControl3: TPageControl
        Left = 0
        Top = 0
        Width = 425
        Height = 318
        ActivePage = TabSheet7
        Align = alClient
        TabOrder = 0
        object TabSheet7: TTabSheet
          Caption = #32676#33521#27036
          object ListViewHero: TListView
            Left = 0
            Top = 0
            Width = 417
            Height = 291
            Align = alClient
            Columns = <
              item
                Caption = #24207#21495
                Width = 60
              end
              item
                Caption = #33521#38596#21517#31216
                Width = 100
              end
              item
                Caption = #35282#33394#21517#31216
                Width = 100
              end
              item
                Caption = #31561#32423
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
          Caption = #25112#31070#27036
          ImageIndex = 1
          object ListViewHeroWarrior: TListView
            Left = 0
            Top = 0
            Width = 417
            Height = 291
            Align = alClient
            Columns = <
              item
                Caption = #24207#21495
                Width = 60
              end
              item
                Caption = #33521#38596#21517#31216
                Width = 100
              end
              item
                Caption = #35282#33394#21517#31216
                Width = 100
              end
              item
                Caption = #31561#32423
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
          Caption = #27861#22307#27036
          ImageIndex = 2
          object ListViewHeroWizzard: TListView
            Left = 0
            Top = 0
            Width = 417
            Height = 291
            Align = alClient
            Columns = <
              item
                Caption = #24207#21495
                Width = 60
              end
              item
                Caption = #33521#38596#21517#31216
                Width = 100
              end
              item
                Caption = #35282#33394#21517#31216
                Width = 100
              end
              item
                Caption = #31561#32423
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
          Caption = #36947#23562#27036
          ImageIndex = 3
          object ListViewHeroMonk: TListView
            Left = 0
            Top = 0
            Width = 417
            Height = 291
            Align = alClient
            Columns = <
              item
                Caption = #24207#21495
                Width = 60
              end
              item
                Caption = #33521#38596#21517#31216
                Width = 100
              end
              item
                Caption = #35282#33394#21517#31216
                Width = 100
              end
              item
                Caption = #31561#32423
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
      Caption = #21517#24072#27036
      ImageIndex = 2
      object ListViewMaster: TListView
        Left = 0
        Top = 0
        Width = 425
        Height = 318
        Align = alClient
        Columns = <
          item
            Caption = #24207#21495
            Width = 60
          end
          item
            Caption = #21517#31216
            Width = 100
          end
          item
            Caption = #20986#24072#24466#24351#25968
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
