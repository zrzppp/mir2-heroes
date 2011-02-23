object frmAccountManage: TfrmAccountManage
  Left = 0
  Top = 0
  Width = 700
  Height = 477
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object RzSizePanel2: TRzSizePanel
    Left = 0
    Top = 195
    Width = 700
    Height = 282
    Align = alBottom
    BorderColor = clBlack
    Color = clMoneyGreen
    SizeBarWidth = 6
    TabOrder = 1
    object RzGroupBox2: TRzGroupBox
      Left = 0
      Top = 7
      Width = 700
      Height = 275
      Align = alClient
      Alignment = taCenter
      Caption = #29992#25143#36134#21495#20449#24687
      GroupStyle = gsBanner
      TabOrder = 0
      object RzPanel16: TPanel
        Left = 0
        Top = 20
        Width = 700
        Height = 255
        Align = alClient
        TabOrder = 0
        object Label1: TLabel
          Left = 472
          Top = 12
          Width = 208
          Height = 12
          Caption = #35831#22312#26381#21153#31471#20851#38381#30340#24773#20917#19979#20351#29992#65281#65281#65281
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object RzLabel9: TLabel
          Left = 280
          Top = 184
          Width = 54
          Height = 12
          Caption = #21019#24314#26102#38388':'
          Transparent = True
        end
        object RzLabel10: TLabel
          Left = 16
          Top = 64
          Width = 54
          Height = 12
          Caption = #29992#25143#21517#31216':'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object RzLabel11: TLabel
          Left = 16
          Top = 16
          Width = 54
          Height = 12
          Caption = #30331#38470#23494#30721':'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object RzLabel13: TLabel
          Left = 16
          Top = 112
          Width = 54
          Height = 12
          Caption = #36523#20221#35777#21495':'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object RzLabel14: TLabel
          Left = 16
          Top = 136
          Width = 42
          Height = 12
          Caption = #38382#39064#19968':'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object RzLabel15: TLabel
          Left = 16
          Top = 184
          Width = 42
          Height = 12
          Caption = #38382#39064#20108':'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object RzLabel16: TLabel
          Left = 280
          Top = 208
          Width = 54
          Height = 12
          Caption = #32852#31995#30005#35805':'
          Transparent = True
        end
        object RzLabel17: TLabel
          Left = 16
          Top = 232
          Width = 54
          Height = 12
          Caption = #32852#31995#37038#31665':'
          Transparent = True
        end
        object RzLabel18: TLabel
          Left = 280
          Top = 160
          Width = 54
          Height = 12
          Caption = #26368#36817#30331#38470':'
          Transparent = True
        end
        object RzLabel19: TLabel
          Left = 16
          Top = 40
          Width = 54
          Height = 12
          Caption = #30830#35748#23494#30721':'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object RzLabel20: TLabel
          Left = 16
          Top = 88
          Width = 54
          Height = 12
          Caption = #20986#29983#26085#26399':'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object RzLabel21: TLabel
          Left = 16
          Top = 160
          Width = 42
          Height = 12
          Caption = #31572#26696#19968':'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object RzLabel22: TLabel
          Left = 16
          Top = 208
          Width = 42
          Height = 12
          Caption = #31572#26696#20108':'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object RzLabel23: TLabel
          Left = 280
          Top = 232
          Width = 54
          Height = 12
          Caption = #25163#26426#21495#30721':'
          Transparent = True
        end
        object ButtonOK: TButton
          Left = 472
          Top = 224
          Width = 75
          Height = 25
          Caption = #20445#23384#20462#25913
          TabOrder = 14
          OnClick = ButtonOKClick
        end
        object ButtonDelAccount: TButton
          Left = 472
          Top = 192
          Width = 75
          Height = 25
          Caption = #21024#38500#36134#21495
          TabOrder = 16
          OnClick = ButtonDelAccountClick
        end
        object EditCreateDate: TEdit
          Left = 344
          Top = 180
          Width = 121
          Height = 20
          Color = clBtnFace
          Enabled = False
          TabOrder = 0
        end
        object EditPassword: TEdit
          Left = 88
          Top = 12
          Width = 121
          Height = 20
          TabOrder = 1
          OnChange = EditPasswordChange
          OnEnter = EditEnter
        end
        object EditYourName: TEdit
          Left = 88
          Top = 60
          Width = 121
          Height = 20
          TabOrder = 2
          OnChange = EditPasswordChange
          OnEnter = EditEnter
        end
        object EditSSNo: TEdit
          Left = 88
          Top = 108
          Width = 121
          Height = 20
          TabOrder = 3
          OnChange = EditPasswordChange
          OnEnter = EditEnter
        end
        object EditQuiz1: TEdit
          Left = 88
          Top = 132
          Width = 121
          Height = 20
          TabOrder = 4
          OnChange = EditPasswordChange
          OnEnter = EditEnter
        end
        object EditQuiz2: TEdit
          Left = 88
          Top = 180
          Width = 121
          Height = 20
          TabOrder = 5
          OnChange = EditPasswordChange
          OnEnter = EditEnter
        end
        object EditPhone: TEdit
          Left = 344
          Top = 204
          Width = 121
          Height = 20
          TabOrder = 6
          OnChange = EditPasswordChange
        end
        object EditEMail: TEdit
          Left = 88
          Top = 228
          Width = 121
          Height = 20
          TabOrder = 7
          OnChange = EditPasswordChange
        end
        object EditUpdate: TEdit
          Left = 344
          Top = 156
          Width = 121
          Height = 20
          Color = clBtnFace
          Enabled = False
          TabOrder = 8
        end
        object EditConfirm: TEdit
          Left = 88
          Top = 36
          Width = 121
          Height = 20
          TabOrder = 9
          OnChange = EditPasswordChange
          OnEnter = EditEnter
        end
        object EditBirthDay: TEdit
          Left = 88
          Top = 84
          Width = 121
          Height = 20
          TabOrder = 10
          OnChange = EditPasswordChange
          OnEnter = EditEnter
        end
        object EditAnswer1: TEdit
          Left = 88
          Top = 156
          Width = 121
          Height = 20
          TabOrder = 11
          OnChange = EditPasswordChange
          OnEnter = EditEnter
        end
        object EditAnswer2: TEdit
          Left = 88
          Top = 204
          Width = 121
          Height = 20
          TabOrder = 12
          OnChange = EditPasswordChange
          OnEnter = EditEnter
        end
        object EditMobPhone: TEdit
          Left = 344
          Top = 228
          Width = 121
          Height = 20
          TabOrder = 13
          OnChange = EditPasswordChange
        end
        object MemoHelp: TMemo
          Left = 217
          Top = 9
          Width = 249
          Height = 145
          TabOrder = 15
        end
      end
    end
  end
  object PanelActSearchAccount: TPanel
    Left = 0
    Top = 0
    Width = 700
    Height = 57
    Align = alTop
    TabOrder = 0
    object ButtonPrecisionSearch: TRzToolbarButton
      Left = 400
      Top = 20
      Width = 81
      Height = 22
      Hint = 'Find'
      Caption = #31934#30830#26597#25214
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000730E0000730E00000001000000010000000000003300
        00006600000099000000CC000000FF0000000033000033330000663300009933
        0000CC330000FF33000000660000336600006666000099660000CC660000FF66
        000000990000339900006699000099990000CC990000FF99000000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
        0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
        330000333300333333006633330099333300CC333300FF333300006633003366
        33006666330099663300CC663300FF6633000099330033993300669933009999
        3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
        330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
        66006600660099006600CC006600FF0066000033660033336600663366009933
        6600CC336600FF33660000666600336666006666660099666600CC666600FF66
        660000996600339966006699660099996600CC996600FF99660000CC660033CC
        660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
        6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
        990000339900333399006633990099339900CC339900FF339900006699003366
        99006666990099669900CC669900FF6699000099990033999900669999009999
        9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
        990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
        CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
        CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
        CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
        FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
        FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
        FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
        FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
        000000808000800000008000800080800000C0C0C00080808000191919004C4C
        4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
        6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8B4D8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E281E8E8E8E8E8E8E8E8E8E8E8E8E8
        B46C6CD8E8E8E8E8E8E8E8E8E8E8E8E8E2818181E8E8E8E8E8E8E8E8E8E8E8E8
        B46CD86CD8E8E8E8E8E8E8E8E8E8E8E8E281818181E8E8E8E8E8E8E8E8E8E8E8
        B46C6CD86CD8E8E8E8E8E8E8E8E8E8E8E28181818181E8E8E8E8E8E8E8E8E8D7
        5E6C6C6CB46CD8E8E8E8E8E8E8E8E8D781818181E28181E8E8E8E8E8E8E8E8D7
        89896CB4B4B46CD8E8E8E8E8E8E8E8D7ACAC81E2E2E28181E8E8E8E8E8E8D789
        89D7D7B4C7C7C76CE8E8E8E8E8E8D7ACACD7D7E2ACACAC81E8E8E8E8E8D78989
        D7D7D7D76C6C6CE8E8E8E8E8E8D7ACACD7D7D7D7818181E8E8E8E8E8D78989D7
        D7D75E5EE8E8E8E8E8E8E8E8D7ACACD7D7D78181E8E8E8E8E8E8E8D78989D7D7
        D75EE8E8E8E8E8E8E8E8E8D7ACACD7D7D781E8E8E8E8E8E8E8E8D78989D7D7D7
        5EB4E8E8E8E8E8E8E8E8D7ACACD7D7D781E2E8E8E8E8E8E8E8E85E89D7D7D75E
        B4E8E8E8E8E8E8E8E8E881ACD7D7D781E2E8E8E8E8E8E8E8E8E8E85ED7D75EE8
        E8E8E8E8E8E8E8E8E8E8E881D7D781E8E8E8E8E8E8E8E8E8E8E8E8E85E5EE8E8
        E8E8E8E8E8E8E8E8E8E8E8E88181E8E8E8E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
      OnClick = ButtonPrecisionSearchClick
      HotNumGlyphs = 0
    end
    object ButtonMistySearch: TRzToolbarButton
      Left = 488
      Top = 20
      Width = 81
      Height = 22
      Hint = 'Find'
      Caption = #27169#31946#26597#25214
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000730E0000730E00000001000000010000000000003300
        00006600000099000000CC000000FF0000000033000033330000663300009933
        0000CC330000FF33000000660000336600006666000099660000CC660000FF66
        000000990000339900006699000099990000CC990000FF99000000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
        0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
        330000333300333333006633330099333300CC333300FF333300006633003366
        33006666330099663300CC663300FF6633000099330033993300669933009999
        3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
        330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
        66006600660099006600CC006600FF0066000033660033336600663366009933
        6600CC336600FF33660000666600336666006666660099666600CC666600FF66
        660000996600339966006699660099996600CC996600FF99660000CC660033CC
        660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
        6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
        990000339900333399006633990099339900CC339900FF339900006699003366
        99006666990099669900CC669900FF6699000099990033999900669999009999
        9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
        990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
        CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
        CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
        CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
        FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
        FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
        FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
        FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
        000000808000800000008000800080800000C0C0C00080808000191919004C4C
        4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
        6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8B4D8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E281E8E8E8E8E8E8E8E8E8E8E8E8E8
        B46C6CD8E8E8E8E8E8E8E8E8E8E8E8E8E2818181E8E8E8E8E8E8E8E8E8E8E8E8
        B46CD86CD8E8E8E8E8E8E8E8E8E8E8E8E281818181E8E8E8E8E8E8E8E8E8E8E8
        B46C6CD86CD8E8E8E8E8E8E8E8E8E8E8E28181818181E8E8E8E8E8E8E8E8E8D7
        5E6C6C6CB46CD8E8E8E8E8E8E8E8E8D781818181E28181E8E8E8E8E8E8E8E8D7
        89896CB4B4B46CD8E8E8E8E8E8E8E8D7ACAC81E2E2E28181E8E8E8E8E8E8D789
        89D7D7B4C7C7C76CE8E8E8E8E8E8D7ACACD7D7E2ACACAC81E8E8E8E8E8D78989
        D7D7D7D76C6C6CE8E8E8E8E8E8D7ACACD7D7D7D7818181E8E8E8E8E8D78989D7
        D7D75E5EE8E8E8E8E8E8E8E8D7ACACD7D7D78181E8E8E8E8E8E8E8D78989D7D7
        D75EE8E8E8E8E8E8E8E8E8D7ACACD7D7D781E8E8E8E8E8E8E8E8D78989D7D7D7
        5EB4E8E8E8E8E8E8E8E8D7ACACD7D7D781E2E8E8E8E8E8E8E8E85E89D7D7D75E
        B4E8E8E8E8E8E8E8E8E881ACD7D7D781E2E8E8E8E8E8E8E8E8E8E85ED7D75EE8
        E8E8E8E8E8E8E8E8E8E8E881D7D781E8E8E8E8E8E8E8E8E8E8E8E8E85E5EE8E8
        E8E8E8E8E8E8E8E8E8E8E8E88181E8E8E8E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
      OnClick = ButtonMistySearchClick
      HotNumGlyphs = 0
    end
    object RzLabel7: TLabel
      Left = 16
      Top = 24
      Width = 36
      Height = 12
      Caption = #27880#20876'ID'
      Transparent = True
    end
    object RzLabel8: TLabel
      Left = 224
      Top = 24
      Width = 36
      Height = 12
      Caption = #27880#20876'ID'
      Transparent = True
    end
    object EditAccount: TEdit
      Left = 272
      Top = 20
      Width = 121
      Height = 20
      TabOrder = 1
      OnEnter = EditEnter
    end
    object ComboBoxAccount: TComboBox
      Left = 64
      Top = 20
      Width = 145
      Height = 20
      Style = csDropDownList
      Ctl3D = False
      DropDownCount = 16
      ItemHeight = 12
      ParentCtl3D = False
      TabOrder = 0
      OnSelect = ComboBoxAccountSelect
    end
  end
  object RzPanel4: TPanel
    Left = 0
    Top = 57
    Width = 700
    Height = 138
    Align = alClient
    TabOrder = 2
    object RzGroupBox1: TRzGroupBox
      Left = 1
      Top = 1
      Width = 698
      Height = 136
      Align = alClient
      Alignment = taCenter
      Caption = #29992#25143#36134#21495#21015#34920
      GroupStyle = gsBanner
      TabOrder = 0
      object ListView: TListView
        Left = 0
        Top = 20
        Width = 698
        Height = 116
        Align = alClient
        Columns = <
          item
            Caption = #36134#21495
            Width = 60
          end
          item
            Caption = #23494#30721
            Width = 60
          end
          item
            Caption = #29992#25143#21517#31216
            Width = 60
          end
          item
            Caption = #36523#20221#35777#21495
            Width = 80
          end
          item
            Caption = #29983#26085
            Width = 80
          end
          item
            Caption = #38382#39064#19968
            Width = 60
          end
          item
            Caption = #31572#26696#19968
            Width = 60
          end
          item
            Caption = #38382#39064#20108
            Width = 60
          end
          item
            Caption = #31572#26696#20108
            Width = 60
          end
          item
            Caption = #30005#35805
            Width = 60
          end
          item
            Caption = #31227#21160#30005#35805
            Width = 60
          end
          item
            Caption = #30005#23376#37038#31665
            Width = 60
          end
          item
            Caption = #22791#27880#19968
            Width = 60
          end
          item
            Caption = #22791#27880#20108
            Width = 60
          end
          item
            Caption = #21019#24314#26102#38388
            Width = 60
          end
          item
            Caption = #26368#21518#30331#24405#26102#38388
            Width = 534
          end>
        GridLines = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = ListViewClick
      end
    end
  end
end
