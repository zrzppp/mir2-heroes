object FrmGameSpeed: TFrmGameSpeed
  Left = 655
  Top = 162
  BorderStyle = bsDialog
  Caption = 'Game Speed'
  ClientHeight = 275
  ClientWidth = 463
  Color = clSilver
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 449
    Height = 257
    Caption = 'Attack'
    TabOrder = 0
    object GroupBox15: TGroupBox
      Left = 8
      Top = 16
      Width = 113
      Height = 81
      Caption = 'Attack'
      TabOrder = 0
      object Label5: TLabel
        Left = 11
        Top = 40
        Width = 30
        Height = 12
        Caption = 'Attack:'
      end
      object CheckBoxSpeedingControl: TCheckBox
        Left = 8
        Top = 15
        Width = 73
        Height = 17
        Caption = 'test1'
        TabOrder = 0
        OnClick = CheckBoxSpeedingControlClick
      end
      object EditSpeedingTime: TSpinEdit
        Left = 44
        Top = 36
        Width = 61
        Height = 21
        Hint = 'hint1'
        MaxValue = 2000
        MinValue = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Value = 100
        OnChange = EditSpeedingTimeChange
      end
    end
    object ButtonRef: TButton
      Left = 200
      Top = 216
      Width = 75
      Height = 25
      Caption = 'Ref (&R)'
      TabOrder = 1
      OnClick = ButtonRefClick
    end
    object ButtonSave: TButton
      Left = 280
      Top = 216
      Width = 75
      Height = 25
      Caption = 'Save (&S)'
      TabOrder = 2
      OnClick = ButtonSaveClick
    end
    object ButtonClose: TButton
      Left = 360
      Top = 216
      Width = 75
      Height = 25
      Caption = 'Exit (&E)'
      TabOrder = 3
      OnClick = ButtonCloseClick
    end
    object RadioGroupSpeedingDataManage: TRadioGroup
      Left = 128
      Top = 16
      Width = 113
      Height = 81
      Caption = 'Radio Group Speeding Data'
      ItemIndex = 0
      Items.Strings = (
        'string1'
        'string2'
        'string3')
      TabOrder = 4
      OnClick = RadioGroupSpeedingDataManageClick
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 104
      Width = 425
      Height = 97
      Caption = 'test2'
      TabOrder = 5
      object CheckBoxShowSpeedingMsg: TCheckBox
        Left = 8
        Top = 16
        Width = 73
        Height = 17
        Caption = 'Show Speed Msg'
        TabOrder = 0
        OnClick = CheckBoxShowSpeedingMsgClick
      end
      object EditSpeedingMsg: TEdit
        Left = 80
        Top = 13
        Width = 329
        Height = 20
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '['#25552#31034']: '#35831#29233#25252#28216#25103#29615#22659#65292#20851#38381#21152#36895#22806#25346#37325#26032#30331#38470
        OnChange = EditSpeedingMsgChange
      end
      object RadioGroupShowSpeedingMsg: TRadioGroup
        Left = 8
        Top = 40
        Width = 233
        Height = 41
        Caption = 'Radio Group Show Speed Msg'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'string4'
          'string5')
        TabOrder = 2
        OnClick = RadioGroupShowSpeedingMsgClick
      end
    end
  end
end
