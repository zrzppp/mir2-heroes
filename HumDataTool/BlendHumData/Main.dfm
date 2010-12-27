object frmMain: TfrmMain
  Left = 458
  Top = 217
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'MakeGM'#20154#29289#25968#25454#21512#24182'V20100901'
  ClientHeight = 501
  ClientWidth = 749
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object LabelStatus: TRzLabel
    Left = 360
    Top = 384
    Width = 6
    Height = 12
    BlinkIntervalOff = 1
    BlinkIntervalOn = 1
  end
  object StatusBar: TRzStatusBar
    Left = 0
    Top = 482
    Width = 749
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    TabOrder = 0
    VisualStyle = vsGradient
    object ProgressStatus: TRzProgressStatus
      Left = 0
      Top = 0
      Width = 449
      Height = 19
      Align = alLeft
      ParentShowHint = False
      PartsComplete = 0
      Percent = 0
      ShowPercent = True
      TotalParts = 0
    end
    object RzStatusPane: TRzStatusPane
      Left = 449
      Top = 0
      Width = 300
      Height = 19
      Align = alClient
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
  end
  object Panel: TRzPanel
    Left = 0
    Top = 97
    Width = 749
    Height = 352
    Align = alTop
    BorderOuter = fsLowered
    TabOrder = 1
    object ScrollBox: TScrollBox
      Left = 2
      Top = 2
      Width = 745
      Height = 348
      Align = alClient
      TabOrder = 0
      object RzGroupBox1: TRzGroupBox
        Left = 8
        Top = 8
        Width = 353
        Height = 225
        Caption = #25968#25454#24211'1'#65288#20027#24211#65289
        TabOrder = 0
        object RzLabel1: TRzLabel
          Left = 16
          Top = 24
          Width = 30
          Height = 12
          Caption = 'ID.DB'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel2: TRzLabel
          Left = 16
          Top = 48
          Width = 36
          Height = 12
          Caption = 'Hum.db'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel3: TRzLabel
          Left = 16
          Top = 72
          Width = 36
          Height = 12
          Caption = 'Mir.db'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel4: TRzLabel
          Left = 16
          Top = 96
          Width = 54
          Height = 12
          Caption = 'GuildBase'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel5: TRzLabel
          Left = 16
          Top = 120
          Width = 60
          Height = 12
          Caption = 'BigStorage'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel20: TRzLabel
          Left = 16
          Top = 144
          Width = 72
          Height = 12
          Caption = 'SellOff.Sell'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel21: TRzLabel
          Left = 16
          Top = 168
          Width = 72
          Height = 12
          Caption = 'SellOff.Gold'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel24: TRzLabel
          Left = 16
          Top = 192
          Width = 60
          Height = 12
          Caption = '!Setup.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object ButtonEditIDDB1: TRzButtonEdit
          Left = 64
          Top = 24
          Width = 281
          Height = 20
          Text = 'D:\MirServer\LoginSrv\IDDB\Id.DB'
          TabOrder = 0
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = ButtonEditIDDB1ButtonClick
        end
        object ButtonEditHumDB1: TRzButtonEdit
          Left = 64
          Top = 48
          Width = 281
          Height = 20
          Text = 'D:\MirServer\DBServer\FDB\Hum.DB'
          TabOrder = 1
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = ButtonEditHumDB1ButtonClick
        end
        object ButtonEditMirDB1: TRzButtonEdit
          Left = 64
          Top = 72
          Width = 281
          Height = 20
          Text = 'D:\MirServer\DBServer\FDB\Mir.DB'
          TabOrder = 2
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = ButtonEditMirDB1ButtonClick
        end
        object ButtonEditGuildBase1: TRzButtonEdit
          Left = 80
          Top = 96
          Width = 265
          Height = 20
          Text = 'D:\MirServer\Mir200\GuildBase'
          TabOrder = 3
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = ButtonEditGuildBase1ButtonClick
        end
        object ButtonEditBigStorage1: TRzButtonEdit
          Left = 80
          Top = 120
          Width = 265
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\Market_Storage\UserStorage.db'
          TabOrder = 4
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = ButtonEditBigStorage1ButtonClick
        end
        object ButtonEditSellOffSell1: TRzButtonEdit
          Left = 96
          Top = 144
          Width = 249
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\Market_SellOff\UserSellOff.sell'
          TabOrder = 5
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = ButtonEditSellOffSell1ButtonClick
        end
        object ButtonEditSellOffGold1: TRzButtonEdit
          Left = 96
          Top = 168
          Width = 249
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\Market_SellOff\UserSellOff.gold'
          TabOrder = 6
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = ButtonEditSellOffGold1ButtonClick
        end
        object ButtonEditSetup1: TRzButtonEdit
          Left = 88
          Top = 192
          Width = 257
          Height = 20
          Text = 'D:\MirServer\Mir200\!Setup.txt'
          TabOrder = 7
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = ButtonEditSetup1ButtonClick
        end
      end
      object RzGroupBox2: TRzGroupBox
        Left = 367
        Top = 8
        Width = 353
        Height = 225
        Caption = #25968#25454#24211'2'#65288#20174#24211#65289
        TabOrder = 1
        object RzLabel6: TRzLabel
          Left = 16
          Top = 24
          Width = 30
          Height = 12
          Caption = 'ID.DB'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel7: TRzLabel
          Left = 16
          Top = 48
          Width = 36
          Height = 12
          Caption = 'Hum.db'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel8: TRzLabel
          Left = 16
          Top = 72
          Width = 36
          Height = 12
          Caption = 'Mir.db'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel9: TRzLabel
          Left = 16
          Top = 96
          Width = 54
          Height = 12
          Caption = 'GuildBase'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel10: TRzLabel
          Left = 16
          Top = 120
          Width = 60
          Height = 12
          Caption = 'BigStorage'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel22: TRzLabel
          Left = 16
          Top = 144
          Width = 72
          Height = 12
          Caption = 'SellOff.Sell'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel23: TRzLabel
          Left = 16
          Top = 168
          Width = 72
          Height = 12
          Caption = 'SellOff.Gold'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel25: TRzLabel
          Left = 16
          Top = 192
          Width = 60
          Height = 12
          Caption = '!Setup.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object ButtonEditIDDB2: TRzButtonEdit
          Left = 64
          Top = 24
          Width = 281
          Height = 20
          Text = 'D:\MirServer\LoginSrv\IDDB\Id.DB'
          TabOrder = 0
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = ButtonEditIDDB2ButtonClick
        end
        object ButtonEditHumDB2: TRzButtonEdit
          Left = 64
          Top = 48
          Width = 281
          Height = 20
          Text = 'D:\MirServer\DBServer\FDB\Hum.DB'
          TabOrder = 1
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = ButtonEditHumDB2ButtonClick
        end
        object ButtonEditMirDB2: TRzButtonEdit
          Left = 64
          Top = 72
          Width = 281
          Height = 20
          Text = 'D:\MirServer\DBServer\FDB\Mir.DB'
          TabOrder = 2
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = ButtonEditMirDB2ButtonClick
        end
        object ButtonEditGuildBase2: TRzButtonEdit
          Left = 80
          Top = 96
          Width = 265
          Height = 20
          Text = 'D:\MirServer\Mir200\GuildBase'
          TabOrder = 3
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = ButtonEditGuildBase2ButtonClick
        end
        object ButtonEditBigStorage2: TRzButtonEdit
          Left = 80
          Top = 120
          Width = 265
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\Market_Storage\UserStorage.db'
          TabOrder = 4
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = ButtonEditBigStorage2ButtonClick
        end
        object ButtonEditSellOffSell2: TRzButtonEdit
          Left = 96
          Top = 144
          Width = 249
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\Market_SellOff\UserSellOff.sell'
          TabOrder = 5
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = ButtonEditSellOffSell2ButtonClick
        end
        object ButtonEditSellOffGold2: TRzButtonEdit
          Left = 96
          Top = 168
          Width = 249
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\Market_SellOff\UserSellOff.gold'
          TabOrder = 6
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = ButtonEditSellOffGold2ButtonClick
        end
        object ButtonEditSetup2: TRzButtonEdit
          Left = 88
          Top = 192
          Width = 257
          Height = 20
          Text = 'D:\MirServer\Mir200\!Setup.txt'
          TabOrder = 7
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = ButtonEditSetup2ButtonClick
        end
      end
      object RzGroupBox3: TRzGroupBox
        Left = 8
        Top = 240
        Width = 353
        Height = 97
        Caption = #35013#22791#32465#23450#25991#20214#65288#20027#65289
        TabOrder = 2
        object RzLabel14: TRzLabel
          Left = 8
          Top = 21
          Width = 114
          Height = 12
          Caption = 'ItemBindAccount.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel17: TRzLabel
          Left = 8
          Top = 45
          Width = 114
          Height = 12
          Caption = 'ItemBindChrName.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel18: TRzLabel
          Left = 8
          Top = 69
          Width = 108
          Height = 12
          Caption = 'ItemBindIPaddr.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object EditBindAccountA: TRzButtonEdit
          Left = 136
          Top = 18
          Width = 209
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\ItemBindAccount.txt'
          TabOrder = 0
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EditBindAccountAButtonClick
        end
        object EditBindCharNameA: TRzButtonEdit
          Left = 136
          Top = 42
          Width = 209
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\ItemBindChrName.txt'
          TabOrder = 1
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EditBindCharNameAButtonClick
        end
        object EditBindIPaddrA: TRzButtonEdit
          Left = 136
          Top = 66
          Width = 209
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\ItemBindIPaddr.txt'
          TabOrder = 2
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EditBindIPaddrAButtonClick
        end
      end
      object RzGroupBox4: TRzGroupBox
        Left = 367
        Top = 240
        Width = 353
        Height = 97
        Caption = #35013#22791#32465#23450#25991#20214#65288#20174#65289
        TabOrder = 3
        object RzLabel26: TRzLabel
          Left = 8
          Top = 21
          Width = 114
          Height = 12
          Caption = 'ItemBindAccount.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel27: TRzLabel
          Left = 8
          Top = 45
          Width = 114
          Height = 12
          Caption = 'ItemBindChrName.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel28: TRzLabel
          Left = 8
          Top = 69
          Width = 108
          Height = 12
          Caption = 'ItemBindIPaddr.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object EditBindAccountB: TRzButtonEdit
          Left = 136
          Top = 18
          Width = 209
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\ItemBindAccount.txt'
          TabOrder = 0
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EditBindAccountBButtonClick
        end
        object EditBindCharNameB: TRzButtonEdit
          Left = 136
          Top = 42
          Width = 209
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\ItemBindChrName.txt'
          TabOrder = 1
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EditBindCharNameBButtonClick
        end
        object EditBindIPaddrB: TRzButtonEdit
          Left = 136
          Top = 66
          Width = 209
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\ItemBindIPaddr.txt'
          TabOrder = 2
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EditBindIPaddrBButtonClick
        end
      end
      object RzGroupBox6: TRzGroupBox
        Left = 367
        Top = 344
        Width = 353
        Height = 49
        Caption = #35760#24518#29289#21697#25991#20214#65288#20174#65289
        TabOrder = 4
        object RzLabel30: TRzLabel
          Left = 8
          Top = 21
          Width = 120
          Height = 12
          Caption = 'RememberItemList.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object EditRememberItemListB: TRzButtonEdit
          Left = 136
          Top = 18
          Width = 209
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\RememberItemList.txt'
          TabOrder = 0
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EditRememberItemListBButtonClick
        end
      end
      object RzGroupBox5: TRzGroupBox
        Left = 8
        Top = 344
        Width = 353
        Height = 49
        Caption = #35760#24518#29289#21697#25991#20214#65288#20027#65289
        TabOrder = 5
        object RzLabel29: TRzLabel
          Left = 8
          Top = 21
          Width = 120
          Height = 12
          Caption = 'RememberItemList.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object EditRememberItemListA: TRzButtonEdit
          Left = 136
          Top = 18
          Width = 209
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\RememberItemList.txt'
          TabOrder = 0
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EditRememberItemListAButtonClick
        end
      end
      object RzGroupBox7: TRzGroupBox
        Left = 8
        Top = 399
        Width = 353
        Height = 74
        Caption = #25361#25112#25968#25454#65288#20027#65289
        TabOrder = 6
        object RzLabel31: TRzLabel
          Left = 8
          Top = 21
          Width = 54
          Height = 12
          Caption = 'Duel.Duel'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel33: TRzLabel
          Left = 8
          Top = 44
          Width = 54
          Height = 12
          Caption = 'Duel.Item'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object EditDuelInfoA: TRzButtonEdit
          Left = 68
          Top = 18
          Width = 277
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\Market_Duel\Duel.Duel'
          TabOrder = 0
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EditDuelInfoAButtonClick
        end
        object EditDuelItemA: TRzButtonEdit
          Left = 68
          Top = 44
          Width = 277
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\Market_Duel\Duel.Item'
          TabOrder = 1
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EditDuelItemAButtonClick
        end
      end
      object RzGroupBox8: TRzGroupBox
        Left = 367
        Top = 399
        Width = 353
        Height = 74
        Caption = #25361#25112#25968#25454#65288#20174#65289
        TabOrder = 7
        object RzLabel32: TRzLabel
          Left = 8
          Top = 21
          Width = 54
          Height = 12
          Caption = 'Duel.Duel'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel34: TRzLabel
          Left = 8
          Top = 44
          Width = 54
          Height = 12
          Caption = 'Duel.Item'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object EditDuelInfoB: TRzButtonEdit
          Left = 68
          Top = 18
          Width = 277
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\Market_Duel\Duel.Duel'
          TabOrder = 0
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EditDuelInfoBButtonClick
        end
        object EditDuelItemB: TRzButtonEdit
          Left = 68
          Top = 44
          Width = 277
          Height = 20
          Text = 'D:\MirServer\Mir200\Envir\Market_Duel\Duel.Item'
          TabOrder = 1
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EditDuelItemBButtonClick
        end
      end
      object RzGroupBox9: TRzGroupBox
        Left = 5
        Top = 479
        Width = 715
        Height = 290
        Caption = #33258#23450#20041#21464#37327#21512#24182
        TabOrder = 8
        object RzGroupBox10: TRzGroupBox
          Left = 9
          Top = 16
          Width = 347
          Height = 233
          Caption = #20027#21306
          TabOrder = 0
          object ListBoxDynamicVarA: TListBox
            Left = 12
            Top = 20
            Width = 325
            Height = 173
            ItemHeight = 12
            TabOrder = 0
            OnClick = ListBoxDynamicVarAClick
            OnMouseDown = ListBoxDynamicVarAMouseDown
          end
          object EditDynamicVarA: TRzButtonEdit
            Left = 12
            Top = 199
            Width = 325
            Height = 20
            TabOrder = 1
            AltBtnWidth = 15
            ButtonWidth = 15
            OnButtonClick = EditDynamicVarAButtonClick
          end
        end
        object RzGroupBox11: TRzGroupBox
          Left = 362
          Top = 16
          Width = 347
          Height = 233
          Caption = #20174#21306
          TabOrder = 1
          object ListBoxDynamicVarB: TListBox
            Left = 12
            Top = 20
            Width = 325
            Height = 173
            ItemHeight = 12
            TabOrder = 0
            OnClick = ListBoxDynamicVarBClick
            OnMouseDown = ListBoxDynamicVarBMouseDown
          end
          object EditDynamicVarB: TRzButtonEdit
            Left = 12
            Top = 199
            Width = 325
            Height = 20
            TabOrder = 1
            AltBtnWidth = 15
            ButtonWidth = 15
            OnButtonClick = EditDynamicVarBButtonClick
          end
        end
        object ButtonDynamicVarAdd: TButton
          Left = 543
          Top = 256
          Width = 75
          Height = 25
          Caption = #22686#21152
          TabOrder = 2
          OnClick = ButtonDynamicVarAddClick
        end
        object ButtonDynamicVarDel: TButton
          Left = 624
          Top = 256
          Width = 75
          Height = 25
          Caption = #21024#38500
          Enabled = False
          TabOrder = 3
          OnClick = ButtonDynamicVarDelClick
        end
      end
      object RzGroupBox12: TRzGroupBox
        Left = 5
        Top = 775
        Width = 715
        Height = 290
        Caption = #21517#31216#21015#34920#21512#24182
        TabOrder = 9
        object RzGroupBox13: TRzGroupBox
          Left = 9
          Top = 16
          Width = 347
          Height = 233
          Caption = #20027#21306
          TabOrder = 0
          object ListBoxCharNameA: TListBox
            Left = 12
            Top = 20
            Width = 325
            Height = 173
            ItemHeight = 12
            TabOrder = 0
            OnClick = ListBoxCharNameAClick
            OnMouseDown = ListBoxCharNameAMouseDown
          end
          object EditCharNameA: TRzButtonEdit
            Left = 12
            Top = 199
            Width = 325
            Height = 20
            TabOrder = 1
            AltBtnWidth = 15
            ButtonWidth = 15
            OnButtonClick = EditCharNameAButtonClick
          end
        end
        object RzGroupBox14: TRzGroupBox
          Left = 362
          Top = 16
          Width = 347
          Height = 233
          Caption = #20174#21306
          TabOrder = 1
          object ListBoxCharNameB: TListBox
            Left = 12
            Top = 20
            Width = 325
            Height = 173
            ItemHeight = 12
            TabOrder = 0
            OnClick = ListBoxCharNameBClick
            OnMouseDown = ListBoxCharNameBMouseDown
          end
          object EditCharNameB: TRzButtonEdit
            Left = 12
            Top = 199
            Width = 325
            Height = 20
            TabOrder = 1
            AltBtnWidth = 15
            ButtonWidth = 15
            OnButtonClick = EditCharNameBButtonClick
          end
        end
        object ButtonCharNameAdd: TButton
          Left = 543
          Top = 256
          Width = 75
          Height = 25
          Caption = #22686#21152
          TabOrder = 2
          OnClick = ButtonCharNameAddClick
        end
        object ButtonCharNameDel: TButton
          Left = 624
          Top = 256
          Width = 75
          Height = 25
          Caption = #21024#38500
          Enabled = False
          TabOrder = 3
          OnClick = ButtonCharNameDelClick
        end
      end
    end
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 0
    Width = 749
    Height = 97
    Align = alTop
    BorderOuter = fsBump
    TabOrder = 2
    object RzLabel11: TRzLabel
      Left = 160
      Top = 12
      Width = 24
      Height = 12
      Caption = #21019#24314
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object RzLabel12: TRzLabel
      Left = 240
      Top = 12
      Width = 36
      Height = 12
      Caption = #22825#26410#21040
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object RzLabel13: TRzLabel
      Left = 320
      Top = 12
      Width = 12
      Height = 12
      Caption = #32423
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object RzLabel15: TRzLabel
      Left = 160
      Top = 60
      Width = 24
      Height = 12
      Caption = #36317#20170
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object RzLabel16: TRzLabel
      Left = 240
      Top = 60
      Width = 48
      Height = 12
      Caption = #22825#26410#35775#38382
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object RzLabel19: TRzLabel
      Left = 368
      Top = 68
      Width = 48
      Height = 12
      Caption = #20445#23384#30446#24405
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object CheckBoxClearHumLevel: TRzCheckBox
      Left = 8
      Top = 8
      Width = 145
      Height = 17
      Caption = #28165#29702#20154#29289#65288#26410#21040#31561#32423#65289
      State = cbUnchecked
      TabOrder = 0
      OnClick = CheckBoxClearHumLevelClick
    end
    object CheckBoxClearDeleteHum: TRzCheckBox
      Left = 8
      Top = 24
      Width = 129
      Height = 17
      Caption = #28165#29702#20154#29289#65288#24050#21024#38500#65289
      State = cbUnchecked
      TabOrder = 1
      OnClick = CheckBoxClearDeleteHumClick
    end
    object CheckBoxClearID1: TRzCheckBox
      Left = 8
      Top = 56
      Width = 145
      Height = 17
      Caption = #28165#29702#36134#21495#65288#20037#26410#35775#38382#65289
      State = cbUnchecked
      TabOrder = 2
      OnClick = CheckBoxClearID1Click
    end
    object CheckBoxClearID2: TRzCheckBox
      Left = 8
      Top = 72
      Width = 153
      Height = 17
      Caption = #28165#29702#36134#21495#65288#26080#35282#33394#36134#21495#65289
      State = cbUnchecked
      TabOrder = 3
      OnClick = CheckBoxClearID2Click
    end
    object NumericEditDay: TRzNumericEdit
      Left = 192
      Top = 8
      Width = 41
      Height = 20
      TabOrder = 4
      OnChange = NumericEditDayChange
      Max = 999999999.000000000000000000
      Value = 60.000000000000000000
      DisplayFormat = '0'
    end
    object NumericEditLevel: TRzNumericEdit
      Left = 280
      Top = 8
      Width = 33
      Height = 20
      TabOrder = 5
      OnChange = NumericEditLevelChange
      Max = 65535.000000000000000000
      Value = 35.000000000000000000
      DisplayFormat = '0'
    end
    object NumericEditDay1: TRzNumericEdit
      Left = 192
      Top = 56
      Width = 41
      Height = 20
      TabOrder = 6
      OnChange = NumericEditDay1Change
      Max = 999999999.000000000000000000
      Value = 60.000000000000000000
      DisplayFormat = '0'
    end
    object ButtonEditSaveDir: TRzButtonEdit
      Left = 422
      Top = 64
      Width = 290
      Height = 20
      Text = '.\'
      TabOrder = 7
      AltBtnWidth = 15
      ButtonWidth = 15
      OnButtonClick = ButtonEditSaveDirButtonClick
    end
    object CheckBoxBigStorage: TRzCheckBox
      Left = 496
      Top = 8
      Width = 97
      Height = 17
      Caption = #21512#24182#26080#38480#20179#24211
      Checked = True
      State = cbChecked
      TabOrder = 8
      OnClick = CheckBoxBigStorageClick
    end
    object CheckBoxSellOff: TRzCheckBox
      Left = 496
      Top = 24
      Width = 73
      Height = 17
      Caption = #21512#24182#25293#21334
      Checked = True
      State = cbChecked
      TabOrder = 9
      OnClick = CheckBoxSellOffClick
    end
    object CheckBoxCheckCopyItems: TRzCheckBox
      Left = 352
      Top = 8
      Width = 97
      Height = 17
      Caption = #21024#38500#22797#21046#35013#22791
      Checked = True
      State = cbChecked
      TabOrder = 10
      OnClick = CheckBoxCheckCopyItemsClick
    end
    object CheckBoxSetItemMakeIndex: TRzCheckBox
      Left = 352
      Top = 24
      Width = 129
      Height = 17
      Caption = #37325#26032#25490#21015#29289#21697'ID'#32534#21495
      Checked = True
      State = cbChecked
      TabOrder = 11
      OnClick = CheckBoxSetItemMakeIndexClick
    end
    object CheckBoxClearNotDataHum: TRzCheckBox
      Left = 8
      Top = 40
      Width = 153
      Height = 17
      Caption = #28165#29702#20154#29289#65288#26080#25968#25454#35282#33394#65289
      State = cbUnchecked
      TabOrder = 12
      OnClick = CheckBoxClearNotDataHumClick
    end
    object RzCheckBoxItemBind: TRzCheckBox
      Left = 599
      Top = 8
      Width = 121
      Height = 17
      Caption = #21512#24182#35013#22791#32465#23450#25968#25454
      Checked = True
      State = cbChecked
      TabOrder = 13
      OnClick = RzCheckBoxItemBindClick
    end
    object RzCheckBoxDuel: TRzCheckBox
      Left = 496
      Top = 41
      Width = 97
      Height = 17
      Caption = #21512#24182#25361#25112#25968#25454
      Checked = True
      State = cbChecked
      TabOrder = 14
      OnClick = RzCheckBoxDuelClick
    end
    object RzCheckBoxItemDblClick: TRzCheckBox
      Left = 599
      Top = 24
      Width = 121
      Height = 17
      Caption = #21512#24182#35760#24518#29289#21697#25968#25454
      Checked = True
      State = cbChecked
      TabOrder = 15
      OnClick = RzCheckBoxItemDblClickClick
    end
    object CheckBoxDeleteLowLevel: TCheckBox
      Left = 352
      Top = 40
      Width = 138
      Height = 17
      Caption = #22810#20010#35282#33394#20445#30041#39640#31561#32423#30340
      Checked = True
      State = cbChecked
      TabOrder = 16
      OnClick = CheckBoxDeleteLowLevelClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 447
    Width = 749
    Height = 35
    Align = alBottom
    TabOrder = 3
    object LabelVersion: TRzLabel
      Left = 8
      Top = 9
      Width = 174
      Height = 12
      Caption = #29256#26435#25152#26377' (C) 2010-2020 MakeGM'
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object RzURLLabel1: TRzURLLabel
      Left = 328
      Top = 8
      Width = 125
      Height = 13
      Caption = 'http://www.MakeGM.com'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
      URL = 'http://www.MakeGM.com'
    end
    object RzURLLabel2: TRzURLLabel
      Left = 208
      Top = 8
      Width = 111
      Height = 13
      Caption = 'http://www.51pao.com'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
      URL = 'http://www.51pao.com'
    end
    object BitBtnStart: TRzBitBtn
      Left = 477
      Top = 4
      Width = 81
      Caption = #24320#22987#21512#24182
      TabOrder = 0
      OnClick = BitBtnStartClick
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        0800000000000002000000000000000000000001000000000000000000003300
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
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8121212
        12121212121212E8E8E8E8E8E881818181818181818181E8E8E8E8E812181818
        1818121812121212E8E8E8E881E2E2E2E2E281E281818181E8E8E8E8121E1818
        1818181218121212E8E8E8E881ACE2E2E2E2E281E2818181E8E8E8E812181E18
        1818181812181212E8E8E8E881E2ACE2E2E2E2E281E28181E8E8E8E8121E181E
        1818181818121812E8E8E8E881ACE2ACE2E2E2E2E281E281E8E8E8E8121E1E18
        1E18181818181212E8E8E8E881ACACE2ACE2E2E2E2E28181E8E8E8E8128D1E1E
        181E181818181812E8E8E8E881E3ACACE2ACE2E2E2E2E281E8E8E8E8128D8D1E
        1E181E1818181812E8E8E8E881E3E3ACACE2ACE2E2E2E281E8E8E8E8E8121212
        12121212121212E8E8E8E8E8E881818181818181818181E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
    end
    object BitBtnLog: TRzBitBtn
      Left = 564
      Top = 4
      Caption = #26085#35760
      TabOrder = 1
      OnClick = BitBtnLogClick
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000520B0000520B00000001000000000000000000003300
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
        0000000000000000000000000000000000000000000000000000E81710101010
        1010101010E8E8E8E8E8E8AC818181818181818181E8E8E8E8E81710D7D7D7D7
        D7D7D7D7D710E8E8E8E8AC81D7D7D7D7D7D7D7D7D781E8E8E8E81710E3E3E3E3
        E3E3E3E3E310E8E8E8E8AC81E3E3E3E3E3E3E3E3E381E8E8E8E81710D7D7D7D7
        D7D7D7D7D710E8E8E8E8AC81D7D7D7D7D7D7D7D7D781E8E8E8E81710E3E3E3E3
        ACACACACAC10E8E8E8E8AC81E3E3E3E3ACACACACAC81E8E8E8E81710D7D7D7D7
        E3E3E3E3E310E8E8E8E8AC81D7D7D7D7E3E3E3E3E381E8E8E8E81710E3E3E3AC
        ACACACACAC10E8E8E8E8AC81E3E3E3ACACACACACAC81E8E8E8E81710D7D7D7E3
        E3E3E3E3E310E8E8E8E8AC81D7D7D7E3E3E3E3E3E381E8E8E8E81710E3E3ACAC
        10101010101010101010AC81E3E3ACAC818181818181818181811710D7D7E310
        17101010101010101010AC81D7D7E381AC8181818181818181811710E3AC1717
        171717101010101010E8AC81E3ACACACACACAC818181818181E81710D7175F5F
        1717171717101010E8E8AC81D7ACE3E3ACACACACAC818181E8E81710175F5F5F
        5F5F1717171710E8E8E8AC81ACE3E3E3E3E3ACACACAC81E8E8E817175F5F5F5F
        5F5F5F5F1710E8E8E8E8ACACE3E3E3E3E3E3E3E3AC81E8E8E8E8E81781D781D7
        81D781D781D7E8E8E8E8E8AC81D781D781D781D781D7E8E8E8E8E8E881AC81AC
        81AC81AC81E8E8E8E8E8E8E881AC81AC81AC81AC81E8E8E8E8E8}
      NumGlyphs = 2
    end
    object BitBtnCLose: TRzBitBtn
      Left = 645
      Top = 4
      Caption = #36864#20986
      TabOrder = 2
      OnClick = BitBtnCLoseClick
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000730B0000730B00000001000000000000000000003300
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
        EEE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8EEE8E8E8E8E8E8E8E8E8E8E8E8EEE3AC
        E3EEE8E8E8E8E8E8E8E8E8E8E8EEE8ACE3EEE8E8E8E8E8E8E8E8E8EEE3E28257
        57E2ACE3EEE8E8E8E8E8E8EEE8E2818181E2ACE8EEE8E8E8E8E8E382578282D7
        578181E2E3E8E8E8E8E8E881818181D7818181E2E8E8E8E8E8E857828989ADD7
        57797979EEE8E8E8E8E88181DEDEACD781818181EEE8E8E8E8E857898989ADD7
        57AAAAA2D7ADE8E8E8E881DEDEDEACD781DEDE81D7ACE8E8E8E857898989ADD7
        57AACEA3AD10E8E8E8E881DEDEDEACD781DEAC81AC81E8E8E8E85789825EADD7
        57ABCFE21110E8E8E8E881DE8181ACD781ACACE28181E8E8E8E8578957D7ADD7
        57ABDE101010101010E881DE56D7ACD781ACDE818181818181E857898257ADD7
        57E810101010101010E881DE8156ACD781E381818181818181E857898989ADD7
        57E882101010101010E881DEDEDEACD781E381818181818181E857898989ADD7
        57ACEE821110E8E8E8E881DEDEDEACD781ACEE818181E8E8E8E857898989ADD7
        57ABE8AB8910E8E8E8E881DEDEDEACD781ACE3ACDE81E8E8E8E857828989ADD7
        57ACE8A3E889E8E8E8E88181DEDEACD781ACE381E8DEE8E8E8E8E8DE5E8288D7
        57A2A2A2E8E8E8E8E8E8E8DE8181DED781818181E8E8E8E8E8E8E8E8E8AC8257
        57E8E8E8E8E8E8E8E8E8E8E8E8AC818181E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
    end
  end
  object OpenDialog: TOpenDialog
    Left = 280
    Top = 32
  end
end
