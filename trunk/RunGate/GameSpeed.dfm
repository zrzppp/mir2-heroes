object FrmGameSpeed: TFrmGameSpeed
  Left = 655
  Top = 162
  BorderStyle = bsDialog
  Caption = #22806#25346#25511#21046
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
    Caption = #21442#25968#35774#32622
    TabOrder = 0
    object GroupBox15: TGroupBox
      Left = 8
      Top = 16
      Width = 113
      Height = 81
      Caption = #36895#24230#25511#21046
      TabOrder = 0
      object Label5: TLabel
        Left = 11
        Top = 40
        Width = 30
        Height = 12
        Caption = #38388#38548':'
      end
      object CheckBoxSpeedingControl: TCheckBox
        Left = 8
        Top = 15
        Width = 73
        Height = 17
        Caption = #36895#24230#25511#21046
        TabOrder = 0
        OnClick = CheckBoxSpeedingControlClick
      end
      object EditSpeedingTime: TSpinEdit
        Left = 44
        Top = 36
        Width = 61
        Height = 21
        Hint = #25968#25454#36234#22823#36234#20005#26684#40664#35748'400'
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
      Caption = #40664#35748'(&R)'
      TabOrder = 1
      OnClick = ButtonRefClick
    end
    object ButtonSave: TButton
      Left = 280
      Top = 216
      Width = 75
      Height = 25
      Caption = #20445#23384'(&S)'
      TabOrder = 2
      OnClick = ButtonSaveClick
    end
    object ButtonClose: TButton
      Left = 360
      Top = 216
      Width = 75
      Height = 25
      Caption = #20851#38381'(&E)'
      TabOrder = 3
      OnClick = ButtonCloseClick
    end
    object RadioGroupSpeedingDataManage: TRadioGroup
      Left = 128
      Top = 16
      Width = 113
      Height = 81
      Caption = #21152#36895#23553#21253#22788#29702#26041#24335
      ItemIndex = 0
      Items.Strings = (
        #36716#25442#23553#21253
        #20002#25481#23553#21253
        #23553#21253#26080#25928)
      TabOrder = 4
      OnClick = RadioGroupSpeedingDataManageClick
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 104
      Width = 425
      Height = 97
      Caption = #21152#36895#25552#31034
      TabOrder = 5
      object CheckBoxShowSpeedingMsg: TCheckBox
        Left = 8
        Top = 16
        Width = 73
        Height = 17
        Caption = #21152#36895#25552#31034
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
        Caption = #25552#31034#26041#24335
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #23494#20154#25552#31034
          #24377#31383#25552#31034)
        TabOrder = 2
        OnClick = RadioGroupShowSpeedingMsgClick
      end
    end
  end
end
