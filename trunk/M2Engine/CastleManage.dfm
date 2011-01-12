object frmCastleManage: TfrmCastleManage
  Left = -32
  Top = 162
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '????'
  ClientHeight = 349
  ClientWidth = 705
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 10
    Top = 10
    Width = 241
    Height = 321
    Caption = 'Castle'
    TabOrder = 0
    object ListViewCastle: TListView
      Left = 10
      Top = 20
      Width = 221
      Height = 291
      Columns = <
        item
          Caption = 'ID'
          Width = 45
        end
        item
          Caption = 'ID'
          Width = 45
        end
        item
          Caption = 'Name'
          Width = 125
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = ListViewCastleClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 260
    Top = 10
    Width = 441
    Height = 321
    Caption = 'Stat'
    TabOrder = 1
    object PageControlCastle: TPageControl
      Left = 10
      Top = 20
      Width = 421
      Height = 291
      ActivePage = TabSheet4
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'General'
        object GroupBox3: TGroupBox
          Left = 6
          Top = 6
          Width = 402
          Height = 115
          TabOrder = 0
          object Label2: TLabel
            Left = 10
            Top = 25
            Width = 39
            Height = 15
            Caption = 'Owner:'
          end
          object Label1: TLabel
            Left = 10
            Top = 55
            Width = 29
            Height = 15
            Caption = 'Gold:'
          end
          object Label3: TLabel
            Left = 10
            Top = 85
            Width = 36
            Height = 15
            Caption = 'Today:'
          end
          object Label7: TLabel
            Left = 190
            Top = 55
            Width = 23
            Height = 15
            Caption = 'Tec:'
          end
          object Label8: TLabel
            Left = 190
            Top = 85
            Width = 24
            Height = 15
            Caption = 'Pwr:'
          end
          object EditOwenGuildName: TEdit
            Left = 80
            Top = 20
            Width = 211
            Height = 23
            TabOrder = 0
          end
          object EditTotalGold: TSpinEdit
            Left = 80
            Top = 50
            Width = 101
            Height = 24
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 1
            Value = 0
          end
          object EditTodayIncome: TSpinEdit
            Left = 80
            Top = 80
            Width = 101
            Height = 24
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 2
            Value = 0
          end
          object EditTechLevel: TSpinEdit
            Left = 230
            Top = 50
            Width = 61
            Height = 24
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 3
            Value = 0
          end
          object EditPower: TSpinEdit
            Left = 230
            Top = 80
            Width = 61
            Height = 24
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 4
            Value = 0
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Defence'
        ImageIndex = 2
        object GroupBox5: TGroupBox
          Left = 6
          Top = 0
          Width = 398
          Height = 251
          TabOrder = 0
          object ListViewGuard: TListView
            Left = 10
            Top = 20
            Width = 375
            Height = 181
            Columns = <
              item
                Caption = 'ID'
                Width = 45
              end
              item
                Caption = 'Name'
                Width = 100
              end
              item
                Caption = 'Co'
                Width = 75
              end
              item
                Caption = 'HP'
                Width = 100
              end
              item
                Caption = 'Stat'
                Width = 75
              end>
            GridLines = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
          object ButtonRefresh: TButton
            Left = 300
            Top = 210
            Width = 81
            Height = 31
            Caption = '&Reload'
            TabOrder = 1
            OnClick = ButtonRefreshClick
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Name'
        ImageIndex = 1
        object GroupBox4: TGroupBox
          Left = 6
          Top = 6
          Width = 402
          Height = 245
          TabOrder = 0
          object Label4: TLabel
            Left = 10
            Top = 25
            Width = 37
            Height = 15
            Caption = 'Name:'
          end
          object Label5: TLabel
            Left = 10
            Top = 55
            Width = 39
            Height = 15
            Caption = 'Owner:'
          end
          object Label6: TLabel
            Left = 220
            Top = 85
            Width = 33
            Height = 15
            Caption = 'Map#:'
          end
          object Label9: TLabel
            Left = 10
            Top = 115
            Width = 43
            Height = 15
            Caption = 'Co-Ord:'
          end
          object Label10: TLabel
            Left = 220
            Top = 115
            Width = 28
            Height = 15
            Caption = 'Sent:'
          end
          object Label11: TLabel
            Left = 10
            Top = 85
            Width = 26
            Height = 15
            Caption = 'Map:'
          end
          object EditCastleName: TEdit
            Left = 80
            Top = 20
            Width = 311
            Height = 23
            TabOrder = 0
          end
          object EditCastleOfGuild: TEdit
            Left = 80
            Top = 50
            Width = 311
            Height = 23
            TabOrder = 1
          end
          object EditHomeMap: TEdit
            Left = 290
            Top = 80
            Width = 101
            Height = 23
            TabOrder = 2
          end
          object EditTunnelMap: TEdit
            Left = 290
            Top = 110
            Width = 101
            Height = 23
            TabOrder = 3
          end
          object EditPalace: TEdit
            Left = 80
            Top = 80
            Width = 131
            Height = 23
            TabOrder = 4
          end
          object SpinEditNomeX: TSpinEdit
            Left = 80
            Top = 110
            Width = 71
            Height = 24
            MaxValue = 0
            MinValue = 0
            TabOrder = 5
            Value = 0
          end
          object SpinEditNomeY: TSpinEdit
            Left = 150
            Top = 110
            Width = 61
            Height = 24
            MaxValue = 0
            MinValue = 0
            TabOrder = 6
            Value = 0
          end
          object ButtonSave: TButton
            Left = 300
            Top = 200
            Width = 94
            Height = 31
            Caption = '&Save'
            TabOrder = 7
            OnClick = ButtonSaveClick
          end
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'Wars'
        ImageIndex = 3
        object GroupBox6: TGroupBox
          Left = 10
          Top = 0
          Width = 391
          Height = 251
          TabOrder = 0
          object ListViewAttackSabukWall: TListView
            Left = 10
            Top = 20
            Width = 371
            Height = 181
            Columns = <
              item
                Caption = 'ID'
                Width = 63
              end
              item
                Caption = 'Guild'
                Width = 188
              end
              item
                Caption = 'Date'
                Width = 100
              end>
            GridLines = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnClick = ListViewAttackSabukWallClick
          end
          object ButtonAttackAd: TButton
            Left = 10
            Top = 210
            Width = 81
            Height = 31
            Caption = '&Add'
            TabOrder = 1
            OnClick = ButtonAttackAdClick
          end
          object ButtonAttackEdit: TButton
            Left = 100
            Top = 210
            Width = 81
            Height = 31
            Caption = '&Edit'
            TabOrder = 2
            OnClick = ButtonAttackEditClick
          end
          object ButtonAttackDel: TButton
            Left = 190
            Top = 210
            Width = 81
            Height = 31
            Caption = '&Delete'
            TabOrder = 3
            OnClick = ButtonAttackDelClick
          end
          object ButtonAttackR: TButton
            Left = 300
            Top = 210
            Width = 84
            Height = 31
            Caption = '&Reload'
            TabOrder = 4
            OnClick = ButtonAttackRClick
          end
        end
      end
    end
  end
end
