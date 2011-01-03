object frmEditRcd: TfrmEditRcd
  Left = 810
  Top = 303
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Character Information'
  ClientHeight = 414
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object PageControl: TPageControl
    Left = 13
    Top = 10
    Width = 541
    Height = 355
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Edit Char'
      object GroupBox1: TGroupBox
        Left = 10
        Top = 10
        Width = 511
        Height = 308
        TabOrder = 0
        object Label1: TLabel
          Left = 10
          Top = 55
          Width = 67
          Height = 15
          Caption = 'Char Name:'
        end
        object Label2: TLabel
          Left = 10
          Top = 85
          Width = 46
          Height = 15
          Caption = 'Account:'
        end
        object Label3: TLabel
          Left = 10
          Top = 115
          Width = 59
          Height = 15
          Caption = 'Password:'
        end
        object Label4: TLabel
          Left = 10
          Top = 145
          Width = 67
          Height = 15
          Caption = 'Dear Name:'
        end
        object Label5: TLabel
          Left = 10
          Top = 175
          Width = 77
          Height = 15
          Caption = 'Master Name:'
        end
        object Label11: TLabel
          Left = 10
          Top = 25
          Width = 32
          Height = 15
          Caption = 'Index:'
        end
        object Label12: TLabel
          Left = 210
          Top = 25
          Width = 70
          Height = 15
          Caption = 'Current Map:'
        end
        object Label13: TLabel
          Left = 210
          Top = 55
          Width = 71
          Height = 15
          Caption = 'Coordinates:'
        end
        object Label14: TLabel
          Left = 210
          Top = 85
          Width = 63
          Height = 15
          Caption = 'Home Map:'
        end
        object Label15: TLabel
          Left = 210
          Top = 115
          Width = 71
          Height = 15
          Caption = 'Coordinates:'
        end
        object EditChrName: TEdit
          Left = 80
          Top = 50
          Width = 121
          Height = 23
          Color = cl3DLight
          ReadOnly = True
          TabOrder = 0
        end
        object EditAccount: TEdit
          Left = 80
          Top = 80
          Width = 121
          Height = 23
          Color = cl3DLight
          ReadOnly = True
          TabOrder = 1
        end
        object EditPassword: TEdit
          Left = 80
          Top = 110
          Width = 121
          Height = 23
          TabOrder = 2
          OnChange = EditPasswordChange
        end
        object EditDearName: TEdit
          Left = 80
          Top = 140
          Width = 121
          Height = 23
          TabOrder = 3
          OnChange = EditPasswordChange
        end
        object EditMasterName: TEdit
          Left = 80
          Top = 170
          Width = 121
          Height = 23
          TabOrder = 4
          OnChange = EditPasswordChange
        end
        object EditIdx: TEdit
          Left = 80
          Top = 20
          Width = 121
          Height = 23
          Color = cl3DLight
          ReadOnly = True
          TabOrder = 5
        end
        object EditCurMap: TEdit
          Left = 280
          Top = 20
          Width = 121
          Height = 23
          TabOrder = 6
          OnChange = EditPasswordChange
        end
        object EditCurX: TSpinEdit
          Left = 280
          Top = 50
          Width = 61
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 7
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditCurY: TSpinEdit
          Left = 340
          Top = 50
          Width = 61
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 8
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditHomeMap: TEdit
          Left = 280
          Top = 80
          Width = 121
          Height = 23
          TabOrder = 9
          OnClick = EditPasswordChange
        end
        object EditHomeX: TSpinEdit
          Left = 280
          Top = 110
          Width = 61
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 10
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditHomeY: TSpinEdit
          Left = 340
          Top = 110
          Width = 61
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 11
          Value = 0
          OnChange = EditPasswordChange
        end
        object CheckBoxIsMaster: TCheckBox
          Left = 80
          Top = 200
          Width = 71
          Height = 21
          Caption = '??'
          TabOrder = 12
          OnClick = EditPasswordChange
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Values'
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 10
        Top = 10
        Width = 511
        Height = 308
        TabOrder = 0
        object Label6: TLabel
          Left = 10
          Top = 25
          Width = 32
          Height = 15
          Caption = 'Level:'
        end
        object Label7: TLabel
          Left = 10
          Top = 55
          Width = 29
          Height = 15
          Caption = 'Gold:'
        end
        object Label8: TLabel
          Left = 10
          Top = 85
          Width = 63
          Height = 15
          Caption = 'GameGold:'
        end
        object Label9: TLabel
          Left = 10
          Top = 115
          Width = 65
          Height = 15
          Caption = 'GamePoint:'
        end
        object Label16: TLabel
          Left = 10
          Top = 175
          Width = 64
          Height = 15
          Caption = 'CreditPoint:'
        end
        object Label10: TLabel
          Left = 10
          Top = 145
          Width = 51
          Height = 15
          Caption = 'PayPoint:'
        end
        object Label17: TLabel
          Left = 10
          Top = 205
          Width = 47
          Height = 15
          Caption = 'PKPoint:'
        end
        object Label18: TLabel
          Left = 10
          Top = 235
          Width = 70
          Height = 15
          Caption = 'Contribution:'
        end
        object Label19: TLabel
          Left = 185
          Top = 24
          Width = 55
          Height = 15
          Caption = 'EXP Rate:'
        end
        object Label20: TLabel
          Left = 185
          Top = 54
          Width = 57
          Height = 15
          Caption = 'EXP Time:'
        end
        object Label21: TLabel
          Left = 10
          Top = 264
          Width = 67
          Height = 15
          Caption = 'BonusPoint:'
        end
        object EditLevel: TSpinEdit
          Left = 80
          Top = 20
          Width = 81
          Height = 24
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditGold: TSpinEdit
          Left = 80
          Top = 50
          Width = 81
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditGameGold: TSpinEdit
          Left = 80
          Top = 80
          Width = 81
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditGamePoint: TSpinEdit
          Left = 80
          Top = 110
          Width = 81
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditCreditPoint: TSpinEdit
          Left = 80
          Top = 170
          Width = 81
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 4
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditPayPoint: TSpinEdit
          Left = 80
          Top = 140
          Width = 81
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 5
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditPKPoint: TSpinEdit
          Left = 80
          Top = 200
          Width = 81
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 6
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditContribution: TSpinEdit
          Left = 80
          Top = 230
          Width = 81
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 7
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditExpRate: TSpinEdit
          Left = 260
          Top = 20
          Width = 121
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 8
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditExpTime: TSpinEdit
          Left = 260
          Top = 50
          Width = 121
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 9
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditBonusPoint: TSpinEdit
          Left = 80
          Top = 260
          Width = 81
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 10
          Value = 0
          OnChange = EditPasswordChange
        end
        object GroupBox6: TGroupBox
          Left = 185
          Top = 80
          Width = 246
          Height = 174
          Caption = 'Stats'
          TabOrder = 11
          object Label22: TLabel
            Left = 14
            Top = 25
            Width = 21
            Height = 15
            Caption = 'DC:'
          end
          object Label23: TLabel
            Left = 14
            Top = 53
            Width = 21
            Height = 15
            Caption = 'MC:'
          end
          object Label24: TLabel
            Left = 14
            Top = 81
            Width = 20
            Height = 15
            Caption = 'SC:'
          end
          object Label25: TLabel
            Left = 14
            Top = 109
            Width = 19
            Height = 15
            Caption = 'AC:'
          end
          object Label26: TLabel
            Left = 14
            Top = 139
            Width = 28
            Height = 15
            Caption = 'MAC:'
          end
          object Label27: TLabel
            Left = 119
            Top = 25
            Width = 20
            Height = 15
            Caption = 'HP:'
          end
          object Label28: TLabel
            Left = 119
            Top = 54
            Width = 20
            Height = 15
            Caption = 'MP:'
          end
          object Label29: TLabel
            Left = 119
            Top = 81
            Width = 18
            Height = 15
            Caption = 'Hit:'
          end
          object Label30: TLabel
            Left = 119
            Top = 109
            Width = 39
            Height = 15
            Caption = 'Speed:'
          end
          object Label31: TLabel
            Left = 119
            Top = 139
            Width = 17
            Height = 15
            Caption = 'X2:'
          end
          object EditDC: TSpinEdit
            Left = 44
            Top = 20
            Width = 67
            Height = 24
            Enabled = False
            MaxValue = 0
            MinValue = 0
            TabOrder = 0
            Value = 0
            OnChange = EditPasswordChange
          end
          object EditMC: TSpinEdit
            Left = 44
            Top = 48
            Width = 67
            Height = 24
            Enabled = False
            MaxValue = 0
            MinValue = 0
            TabOrder = 1
            Value = 0
            OnChange = EditPasswordChange
          end
          object EditSC: TSpinEdit
            Left = 44
            Top = 75
            Width = 67
            Height = 24
            Enabled = False
            MaxValue = 0
            MinValue = 0
            TabOrder = 2
            Value = 0
            OnChange = EditPasswordChange
          end
          object EditAC: TSpinEdit
            Left = 44
            Top = 105
            Width = 67
            Height = 24
            Enabled = False
            MaxValue = 0
            MinValue = 0
            TabOrder = 3
            Value = 0
            OnChange = EditPasswordChange
          end
          object EditMAC: TSpinEdit
            Left = 44
            Top = 135
            Width = 67
            Height = 24
            Enabled = False
            MaxValue = 0
            MinValue = 0
            TabOrder = 4
            Value = 0
            OnChange = EditPasswordChange
          end
          object EditHP: TSpinEdit
            Left = 163
            Top = 20
            Width = 67
            Height = 24
            Enabled = False
            MaxValue = 0
            MinValue = 0
            TabOrder = 5
            Value = 0
            OnChange = EditPasswordChange
          end
          object EditMP: TSpinEdit
            Left = 163
            Top = 48
            Width = 67
            Height = 24
            Enabled = False
            MaxValue = 0
            MinValue = 0
            TabOrder = 6
            Value = 0
            OnChange = EditPasswordChange
          end
          object EditHit: TSpinEdit
            Left = 163
            Top = 75
            Width = 67
            Height = 24
            Enabled = False
            MaxValue = 0
            MinValue = 0
            TabOrder = 7
            Value = 0
            OnChange = EditPasswordChange
          end
          object EditSpeed: TSpinEdit
            Left = 163
            Top = 105
            Width = 67
            Height = 24
            Enabled = False
            MaxValue = 0
            MinValue = 0
            TabOrder = 8
            Value = 0
            OnChange = EditPasswordChange
          end
          object EditX2: TSpinEdit
            Left = 163
            Top = 135
            Width = 67
            Height = 24
            Enabled = False
            MaxValue = 0
            MinValue = 0
            TabOrder = 9
            Value = 0
            OnChange = EditPasswordChange
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Skills'
      ImageIndex = 2
      object GroupBox3: TGroupBox
        Left = 10
        Top = 10
        Width = 511
        Height = 308
        TabOrder = 0
        object ListViewMagic: TListView
          Left = 10
          Top = 20
          Width = 491
          Height = 271
          Columns = <
            item
              Caption = 'ID'
            end
            item
              Caption = 'Index'
              Width = 63
            end
            item
              Caption = 'Name'
              Width = 125
            end
            item
              Caption = 'Level'
            end
            item
              Caption = 'Class'
              Width = 75
            end
            item
              Caption = '???'
              Width = 63
            end>
          GridLines = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Items'
      ImageIndex = 3
      object GroupBox4: TGroupBox
        Left = 10
        Top = 10
        Width = 511
        Height = 308
        TabOrder = 0
        object ListViewUserItem: TListView
          Left = 10
          Top = 20
          Width = 491
          Height = 271
          Columns = <
            item
              Caption = 'ID'
            end
            item
              Caption = 'Index'
              Width = 100
            end
            item
              Caption = '??'
              Width = 63
            end
            item
              Caption = 'Name'
              Width = 113
            end
            item
              Alignment = taCenter
              Caption = 'Duration'
              Width = 113
            end
            item
              Caption = '??'
              Width = 275
            end>
          GridLines = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Storage'
      ImageIndex = 4
      object GroupBox5: TGroupBox
        Left = 10
        Top = 10
        Width = 511
        Height = 308
        TabOrder = 0
        object ListViewStorage: TListView
          Left = 10
          Top = 20
          Width = 491
          Height = 271
          Columns = <
            item
              Caption = 'ID'
            end
            item
              Caption = '????'
              Width = 100
            end
            item
              Caption = '??'
              Width = 63
            end
            item
              Caption = '????'
              Width = 113
            end
            item
              Alignment = taCenter
              Caption = '??'
              Width = 113
            end
            item
              Caption = '??'
              Width = 275
            end>
          GridLines = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
    end
  end
  object ButtonSaveData: TButton
    Left = 10
    Top = 373
    Width = 101
    Height = 31
    Caption = 'Save (&S)'
    TabOrder = 1
    OnClick = ButtonExportDataClick
  end
  object ButtonExportData: TButton
    Left = 119
    Top = 373
    Width = 101
    Height = 31
    Caption = 'Export (&E)'
    TabOrder = 2
    OnClick = ButtonExportDataClick
  end
  object ButtonImportData: TButton
    Left = 228
    Top = 373
    Width = 101
    Height = 31
    Caption = 'Import (&I)'
    TabOrder = 3
    OnClick = ButtonExportDataClick
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'hum'
    Filter = '???? (*.hum)|*.hum'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 296
    Top = 280
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'hum'
    Filter = '???? (*.hum)|*.hum'
    Left = 336
    Top = 280
  end
end
