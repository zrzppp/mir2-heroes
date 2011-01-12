object frmGameCmd: TfrmGameCmd
  Left = 193
  Top = -1
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Game Commands'
  ClientHeight = 517
  ClientWidth = 804
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
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
    Left = 2
    Top = 10
    Width = 821
    Height = 501
    ActivePage = TabSheet1
    HotTrack = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Player'
      object StringGridGameCmd: TStringGrid
        Left = 3
        Top = 10
        Width = 798
        Height = 331
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goRowSelect]
        TabOrder = 0
        OnClick = StringGridGameCmdClick
        ColWidths = (
          107
          76
          190
          248)
      end
      object GroupBox1: TGroupBox
        Left = 3
        Top = 350
        Width = 798
        Height = 111
        Caption = 'Details'
        TabOrder = 1
        object Label1: TLabel
          Left = 10
          Top = 25
          Width = 30
          Height = 15
          Caption = 'Cmd:'
        end
        object Label6: TLabel
          Left = 220
          Top = 23
          Width = 33
          Height = 15
          Caption = 'Perm:'
        end
        object LabelUserCmdFunc: TLabel
          Left = 80
          Top = 55
          Width = 501
          Height = 15
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = '??'
          Font.Style = []
          ParentFont = False
        end
        object LabelUserCmdParam: TLabel
          Left = 80
          Top = 85
          Width = 501
          Height = 15
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = '??'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 10
          Top = 55
          Width = 36
          Height = 15
          Caption = 'Descr:'
        end
        object Label3: TLabel
          Left = 10
          Top = 85
          Width = 26
          Height = 15
          Caption = 'Use:'
        end
        object EditUserCmdName: TEdit
          Left = 80
          Top = 20
          Width = 131
          Height = 23
          TabOrder = 0
          OnChange = EditUserCmdNameChange
        end
        object EditUserCmdPerMission: TSpinEdit
          Left = 295
          Top = 19
          Width = 56
          Height = 24
          MaxValue = 10
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditUserCmdPerMissionChange
        end
        object EditUserCmdOK: TButton
          Left = 700
          Top = 20
          Width = 81
          Height = 31
          Caption = 'Ok(&O)'
          TabOrder = 2
          OnClick = EditUserCmdOKClick
        end
        object EditUserCmdSave: TButton
          Left = 700
          Top = 70
          Width = 81
          Height = 31
          Caption = 'Save(&S)'
          TabOrder = 3
          OnClick = EditUserCmdSaveClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'GM-S'
      ImageIndex = 1
      object StringGridGameMasterCmd: TStringGrid
        Left = 3
        Top = 10
        Width = 798
        Height = 321
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goRowSelect]
        TabOrder = 0
        OnClick = StringGridGameMasterCmdClick
        ColWidths = (
          119
          83
          161
          248)
      end
      object GroupBox2: TGroupBox
        Left = 13
        Top = 340
        Width = 788
        Height = 111
        Caption = 'Details'
        TabOrder = 1
        object Label4: TLabel
          Left = 10
          Top = 25
          Width = 30
          Height = 15
          Caption = 'Cmd:'
        end
        object Label5: TLabel
          Left = 220
          Top = 23
          Width = 33
          Height = 15
          Caption = 'Perm:'
        end
        object LabelGameMasterCmdFunc: TLabel
          Left = 80
          Top = 55
          Width = 501
          Height = 15
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = '??'
          Font.Style = []
          ParentFont = False
        end
        object LabelGameMasterCmdParam: TLabel
          Left = 80
          Top = 85
          Width = 501
          Height = 15
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = '??'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 10
          Top = 55
          Width = 36
          Height = 15
          Caption = 'Descr:'
        end
        object Label8: TLabel
          Left = 10
          Top = 85
          Width = 26
          Height = 15
          Caption = 'Use:'
        end
        object EditGameMasterCmdName: TEdit
          Left = 80
          Top = 20
          Width = 131
          Height = 23
          TabOrder = 0
          OnChange = EditGameMasterCmdNameChange
        end
        object EditGameMasterCmdPerMission: TSpinEdit
          Left = 295
          Top = 19
          Width = 56
          Height = 24
          MaxValue = 10
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditGameMasterCmdPerMissionChange
        end
        object EditGameMasterCmdOK: TButton
          Left = 690
          Top = 20
          Width = 81
          Height = 31
          Caption = 'Ok(&O)'
          TabOrder = 2
          OnClick = EditGameMasterCmdOKClick
        end
        object EditGameMasterCmdSave: TButton
          Left = 690
          Top = 70
          Width = 81
          Height = 31
          Caption = 'Save(&S)'
          TabOrder = 3
          OnClick = EditGameMasterCmdSaveClick
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Admin'
      ImageIndex = 2
      object StringGridGameDebugCmd: TStringGrid
        Left = 3
        Top = 10
        Width = 798
        Height = 331
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goRowSelect]
        TabOrder = 0
        OnClick = StringGridGameDebugCmdClick
        ColWidths = (
          109
          81
          183
          248)
      end
      object GroupBox3: TGroupBox
        Left = 3
        Top = 350
        Width = 798
        Height = 111
        Caption = 'Details'
        TabOrder = 1
        object Label9: TLabel
          Left = 10
          Top = 25
          Width = 30
          Height = 15
          Caption = 'Cmd:'
        end
        object Label10: TLabel
          Left = 220
          Top = 23
          Width = 33
          Height = 15
          Caption = 'Perm:'
        end
        object LabelGameDebugCmdFunc: TLabel
          Left = 80
          Top = 55
          Width = 501
          Height = 15
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = '??'
          Font.Style = []
          ParentFont = False
        end
        object LabelGameDebugCmdParam: TLabel
          Left = 80
          Top = 85
          Width = 501
          Height = 15
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = '??'
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 10
          Top = 55
          Width = 36
          Height = 15
          Caption = 'Descr:'
        end
        object Label12: TLabel
          Left = 10
          Top = 85
          Width = 26
          Height = 15
          Caption = 'Use:'
        end
        object EditGameDebugCmdName: TEdit
          Left = 80
          Top = 20
          Width = 131
          Height = 23
          TabOrder = 0
          OnChange = EditGameDebugCmdNameChange
        end
        object EditGameDebugCmdPerMission: TSpinEdit
          Left = 295
          Top = 19
          Width = 56
          Height = 24
          MaxValue = 10
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditGameDebugCmdPerMissionChange
        end
        object EditGameDebugCmdOK: TButton
          Left = 700
          Top = 20
          Width = 81
          Height = 31
          Caption = 'OK(&O)'
          TabOrder = 2
          OnClick = EditGameDebugCmdOKClick
        end
        object EditGameDebugCmdSave: TButton
          Left = 700
          Top = 70
          Width = 81
          Height = 31
          Caption = 'Save(&S)'
          TabOrder = 3
          OnClick = EditGameDebugCmdSaveClick
        end
      end
    end
  end
end
