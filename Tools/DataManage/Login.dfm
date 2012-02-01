object frmLogin: TfrmLogin
  Left = 349
  Top = 118
  BorderStyle = bsDialog
  Caption = #31995#32479#30331#38470
  ClientHeight = 305
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object RzGroupBox1: TRzGroupBox
    Left = 8
    Top = 8
    Width = 379
    Height = 193
    TabOrder = 0
    object RzLabel1: TLabel
      Left = 8
      Top = 20
      Width = 84
      Height = 12
      Caption = #20256#22855#26381#21153#31471#30446#24405
      Transparent = False
    end
    object EditMirServer: TRzButtonEdit
      Left = 136
      Top = 17
      Width = 233
      Height = 20
      Text = 'D:\MirServer'
      TabOrder = 0
      AltBtnWidth = 15
      ButtonWidth = 15
    end
    object EditIDDBFileName: TRzButtonEdit
      Left = 136
      Top = 40
      Width = 233
      Height = 20
      Text = 'D:\MirServer\LoginSrv\IDDB\ID.DB'
      TabOrder = 1
      AltBtnWidth = 15
      ButtonWidth = 15
    end
    object EditHumDBFileName: TRzButtonEdit
      Left = 136
      Top = 64
      Width = 233
      Height = 20
      Text = 'D:\MirServer\DBServer\FDB\Hum.DB'
      TabOrder = 2
      AltBtnWidth = 15
      ButtonWidth = 15
    end
    object EditMirDBFileName: TRzButtonEdit
      Left = 136
      Top = 88
      Width = 233
      Height = 20
      Text = 'D:\MirServer\DBServer\FDB\Mir.DB'
      TabOrder = 3
      AltBtnWidth = 15
      ButtonWidth = 15
    end
    object EditUserStorage: TRzButtonEdit
      Left = 136
      Top = 112
      Width = 233
      Height = 20
      Text = 'D:\MirServer\Mir200\Envir\Market_Storage\UserStorage.DB'
      TabOrder = 4
      AltBtnWidth = 15
      ButtonWidth = 15
    end
    object EditUserSell: TRzButtonEdit
      Left = 136
      Top = 136
      Width = 233
      Height = 20
      Text = 'D:\MirServer\Mir200\Envir\Market_SellOff\UserSellOff.sell'
      TabOrder = 5
      AltBtnWidth = 15
      ButtonWidth = 15
    end
    object EditUserGold: TRzButtonEdit
      Left = 136
      Top = 160
      Width = 233
      Height = 20
      Text = 'D:\MirServer\Mir200\Envir\Market_SellOff\UserSellOff.Gold'
      TabOrder = 6
      Visible = False
      AltBtnWidth = 15
      ButtonWidth = 15
    end
    object CheckBoxID: TCheckBox
      Left = 8
      Top = 40
      Width = 49
      Height = 17
      Caption = 'ID.DB'
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
    object CheckBoxHumDB: TCheckBox
      Left = 8
      Top = 63
      Width = 56
      Height = 17
      Caption = 'Hum.DB'
      Checked = True
      State = cbChecked
      TabOrder = 8
    end
    object CheckBoxMirDB: TCheckBox
      Left = 8
      Top = 88
      Width = 57
      Height = 17
      Caption = 'Mir.DB'
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
    object CheckBoxUserStorageDB: TCheckBox
      Left = 8
      Top = 112
      Width = 113
      Height = 17
      Caption = 'UserStorage.DB'
      TabOrder = 10
    end
    object CheckBoxUserSellOff: TCheckBox
      Left = 8
      Top = 136
      Width = 113
      Height = 17
      Caption = 'UserSellOff.sell'
      TabOrder = 11
    end
    object CheckBoxUserSellGold: TCheckBox
      Left = 8
      Top = 160
      Width = 122
      Height = 17
      Caption = 'UserSellOff.Gold'
      TabOrder = 12
      Visible = False
    end
  end
  object RzGroupBox2: TGroupBox
    Left = 8
    Top = 208
    Width = 379
    Height = 57
    BiDiMode = bdLeftToRight
    Caption = 'DBE'#25968#25454#24211#35774#32622
    Color = clBtnFace
    ParentBiDiMode = False
    ParentColor = False
    TabOrder = 1
    object RzLabel5: TLabel
      Left = 104
      Top = 24
      Width = 42
      Height = 12
      Caption = #24211#21035#21517':'
      Transparent = False
    end
    object EditDBName: TEdit
      Left = 152
      Top = 20
      Width = 121
      Height = 20
      TabOrder = 0
      Text = 'HeroDB'
    end
  end
  object BitBtnStart: TBitBtn
    Left = 48
    Top = 272
    Width = 75
    Height = 25
    Caption = #30331#38470
    TabOrder = 2
    OnClick = BitBtnStartClick
    Glyph.Data = {
      36060000424D3606000000000000360400002800000020000000100000000100
      08000000000000020000630B0000630B00000001000000000000000000003300
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
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8180C
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E2DFE8E8E8E8E8E8E8E8E8E8E8E8E8181212
      0CE8E8E8E8E8E8E8E8E8E8E8E8E28181DFE8E8E8E8E8E8E8E8E8E8E818121212
      120CE8E8E8E8E8E8E8E8E8E8E281818181DFE8E8E8E8E8E8E8E8E81812121212
      12120CE8E8E8E8E8E8E8E8E2818181818181DFE8E8E8E8E8E8E8E81812120C18
      1212120CE8E8E8E8E8E8E8E28181DFE2818181DFE8E8E8E8E8E8E818120CE8E8
      181212120CE8E8E8E8E8E8E281DFE8E8E2818181DFE8E8E8E8E8E8180CE8E8E8
      E8181212120CE8E8E8E8E8E2DFE8E8E8E8E2818181DFE8E8E8E8E8E8E8E8E8E8
      E8E8181212120CE8E8E8E8E8E8E8E8E8E8E8E2818181DFE8E8E8E8E8E8E8E8E8
      E8E8E8181212120CE8E8E8E8E8E8E8E8E8E8E8E2818181DFE8E8E8E8E8E8E8E8
      E8E8E8E81812120CE8E8E8E8E8E8E8E8E8E8E8E8E28181DFE8E8E8E8E8E8E8E8
      E8E8E8E8E818120CE8E8E8E8E8E8E8E8E8E8E8E8E8E281DFE8E8E8E8E8E8E8E8
      E8E8E8E8E8E8180CE8E8E8E8E8E8E8E8E8E8E8E8E8E8E2DFE8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
    Margin = 2
    NumGlyphs = 2
  end
  object BitBtnClose: TBitBtn
    Left = 272
    Top = 272
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 3
    OnClick = BitBtnCloseClick
    Glyph.Data = {
      36060000424D3606000000000000360400002800000020000000100000000100
      08000000000000020000630B0000630B00000001000000000000000000003300
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
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8B46C6C6CE8
      E8E8E8E8B46C6C6CE8E8E8E2DFDFDFE8E8E8E8E8E2DFDFDFE8E8E8B49090906C
      E8E8E8B49090906CE8E8E8E2818181DFE8E8E8E2818181DFE8E8E8E8B4909090
      6CE8B49090906CE8E8E8E8E8E2818181DFE8E2818181DFE8E8E8E8E8E8B49090
      906C9090906CE8E8E8E8E8E8E8E2818181DF818181DFE8E8E8E8E8E8E8E8B490
      909090906CE8E8E8E8E8E8E8E8E8E28181818181DFE8E8E8E8E8E8E8E8E8E8B4
      9090906CE8E8E8E8E8E8E8E8E8E8E8E2818181DFE8E8E8E8E8E8E8E8E8E8B490
      909090906CE8E8E8E8E8E8E8E8E8E28181818181DFE8E8E8E8E8E8E8E8B49090
      906C9090906CE8E8E8E8E8E8E8E2818181DF818181DFE8E8E8E8E8E8B4909090
      6CE8B49090906CE8E8E8E8E8E2818181DFE8E2818181DFE8E8E8E8B49090906C
      E8E8E8B49090906CE8E8E8E2818181DFE8E8E8E2818181DFE8E8E8B4B4B4B4E8
      E8E8E8E8B4B4B4B4E8E8E8E2E2E2E2E8E8E8E8E8E2E2E2E2E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
    Margin = 2
    NumGlyphs = 2
  end
end