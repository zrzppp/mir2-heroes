object frmMonsterConfig: TfrmMonsterConfig
  Left = 272
  Top = 48
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Monster Options'
  ClientHeight = 400
  ClientWidth = 770
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
  object PageControl1: TPageControl
    Left = 10
    Top = 10
    Width = 751
    Height = 371
    ActivePage = TabSheet2
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Gold'
      object GroupBox1: TGroupBox
        Left = 10
        Top = 10
        Width = 721
        Height = 321
        TabOrder = 0
        object GroupBox8: TGroupBox
          Left = 10
          Top = 20
          Width = 191
          Height = 91
          Caption = 'Drops'
          TabOrder = 0
          object Label23: TLabel
            Left = 14
            Top = 30
            Width = 24
            Height = 15
            Caption = 'Max:'
          end
          object EditMonOneDropGoldCount: TSpinEdit
            Left = 75
            Top = 25
            Width = 96
            Height = 24
            MaxValue = 99999999
            MinValue = 1
            TabOrder = 0
            Value = 10
            OnChange = EditMonOneDropGoldCountChange
          end
          object CheckBoxDropGoldToPlayBag: TCheckBox
            Left = 10
            Top = 60
            Width = 171
            Height = 21
            Caption = 'AutoBag'
            TabOrder = 1
            OnClick = CheckBoxDropGoldToPlayBagClick
          end
        end
        object ButtonGeneralSave: TButton
          Left = 630
          Top = 276
          Width = 81
          Height = 32
          Caption = 'Save(&S)'
          TabOrder = 1
          OnClick = ButtonGeneralSaveClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Blank'
      ImageIndex = 1
    end
  end
end
