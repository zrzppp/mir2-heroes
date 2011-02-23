object frmDataClear: TfrmDataClear
  Left = 0
  Top = 0
  Width = 629
  Height = 489
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object RzPanel11: TPanel
    Left = 0
    Top = 245
    Width = 629
    Height = 244
    Align = alBottom
    TabOrder = 0
    object RzGroupBox2: TRzGroupBox
      Left = 1
      Top = 1
      Width = 627
      Height = 242
      Align = alClient
      Alignment = taCenter
      Caption = #25968#25454#24211#28165#29702#19982#20462#22797
      GroupStyle = gsBanner
      TabOrder = 0
    end
  end
  object RzPanel6: TPanel
    Left = 0
    Top = 0
    Width = 629
    Height = 245
    Align = alClient
    TabOrder = 1
    object RzGroupBox1: TRzGroupBox
      Left = 1
      Top = 1
      Width = 627
      Height = 243
      Align = alClient
      Alignment = taCenter
      BiDiMode = bdRightToLeft
      Caption = #25968#25454#24211#28165#29702#19982#20462#22797
      GroupStyle = gsBanner
      ParentBiDiMode = False
      TabOrder = 0
      object Panel_Clear: TPanel
        Left = 0
        Top = 20
        Width = 627
        Height = 223
        Align = alClient
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 196
          Width = 208
          Height = 12
          BiDiMode = bdLeftToRight
          Caption = #35831#22312#26381#21153#31471#20851#38381#30340#24773#20917#19979#20351#29992#65281#65281#65281
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
          Transparent = True
        end
        object RzLabel1: TLabel
          Left = 160
          Top = 20
          Width = 24
          Height = 12
          Caption = #21019#24314
          Transparent = True
        end
        object RzLabel2: TLabel
          Left = 264
          Top = 20
          Width = 36
          Height = 12
          Caption = #22825#26410#21040
          Transparent = True
        end
        object RzLabel4: TLabel
          Left = 384
          Top = 20
          Width = 12
          Height = 12
          Caption = #32423
          Transparent = True
        end
        object RzLabel31: TLabel
          Left = 160
          Top = 92
          Width = 24
          Height = 12
          Caption = #36317#20170
          Transparent = True
        end
        object RzLabel32: TLabel
          Left = 264
          Top = 92
          Width = 48
          Height = 12
          Caption = #22825#26410#35775#38382
          Transparent = True
        end
        object RzButton2: TButton
          Left = 520
          Top = 56
          Width = 75
          Height = 25
          Caption = #20462#22797
          Enabled = False
          TabOrder = 4
        end
        object Button_Clear_Data: TButton
          Left = 520
          Top = 96
          Width = 75
          Height = 25
          Caption = #28165#29702
          TabOrder = 5
          OnClick = Button_Clear_DataClick
        end
        object RzButtonReviseCreateHeroFail: TButton
          Left = 440
          Top = 128
          Width = 155
          Height = 25
          Caption = #20462#22797#19981#33021#21019#24314#33521#38596#30340#38169#35823
          TabOrder = 10
          OnClick = RzButtonReviseCreateHeroFailClick
        end
        object CheckBox_Clear_Hum_DelChr1: TCheckBox
          Left = 17
          Top = 18
          Width = 137
          Height = 17
          BiDiMode = bdLeftToRight
          Caption = #28165#29702#20154#29289#65288#31561#32423#26410#21040#65289
          ParentBiDiMode = False
          TabOrder = 0
        end
        object CheckBox_Clear_Hum_DelChr2: TCheckBox
          Left = 17
          Top = 42
          Width = 136
          Height = 17
          BiDiMode = bdLeftToRight
          Caption = #28165#29702#20154#29289#65288#24050#21024#38500#30340#65289
          ParentBiDiMode = False
          TabOrder = 1
        end
        object CheckBox_Clear_ID_DelID1: TCheckBox
          Left = 16
          Top = 88
          Width = 142
          Height = 17
          BiDiMode = bdLeftToRight
          Caption = #28165#29702#36134#21495#65288#20037#26410#35775#38382#65289
          ParentBiDiMode = False
          TabOrder = 6
        end
        object CheckBox_Clear_ID_DelID2: TCheckBox
          Left = 16
          Top = 112
          Width = 153
          Height = 17
          BiDiMode = bdLeftToRight
          Caption = #28165#29702#36134#21495#65288#26080#35282#33394#36134#21495#65289
          ParentBiDiMode = False
          TabOrder = 7
        end
        object CheckBox_Clear_Hum_DelChr3: TCheckBox
          Left = 17
          Top = 65
          Width = 160
          Height = 17
          BiDiMode = bdLeftToRight
          Caption = #28165#29702#20154#29289#65288#26080#25968#25454#30340#35282#33394#65289
          ParentBiDiMode = False
          TabOrder = 9
        end
        object Edit_Clear_Hum_Day: TSpinEdit
          Left = 192
          Top = 16
          Width = 65
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 60
        end
        object Edit_Clear_Hum_Level: TSpinEdit
          Left = 312
          Top = 16
          Width = 65
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 35
        end
        object Edit_Clear_ID_Day: TSpinEdit
          Left = 192
          Top = 88
          Width = 65
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 8
          Value = 60
        end
      end
    end
  end
end
