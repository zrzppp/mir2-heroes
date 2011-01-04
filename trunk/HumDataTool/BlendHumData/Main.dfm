object frmMain: TfrmMain
  Left = 261
  Top = 179
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'MakeGM??????V20100901'
  ClientHeight = 585
  ClientWidth = 874
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object LabelStatus: TRzLabel
    Left = 420
    Top = 448
    Width = 4
    Height = 14
    BlinkIntervalOff = 1
    BlinkIntervalOn = 1
  end
  object StatusBar: TRzStatusBar
    Left = 0
    Top = 526
    Width = 874
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
      Width = 524
      Height = 19
      Align = alLeft
      ParentShowHint = False
      PartsComplete = 0
      Percent = 0
      ShowPercent = True
      TotalParts = 0
    end
    object RzStatusPane: TRzStatusPane
      Left = 524
      Top = 0
      Width = 350
      Height = 19
      Align = alClient
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
  end
  object Panel: TRzPanel
    Left = 0
    Top = 113
    Width = 874
    Height = 411
    Align = alTop
    BorderOuter = fsLowered
    TabOrder = 1
    object ScrollBox: TScrollBox
      Left = 2
      Top = 2
      Width = 870
      Height = 407
      Align = alClient
      TabOrder = 0
      object RzGroupBox1: TRzGroupBox
        Left = 9
        Top = 9
        Width = 412
        Height = 263
        Caption = 'Old Data'
        TabOrder = 0
        object RzLabel1: TRzLabel
          Left = 19
          Top = 28
          Width = 31
          Height = 14
          Caption = 'ID.DB'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel2: TRzLabel
          Left = 19
          Top = 56
          Width = 43
          Height = 14
          Caption = 'Hum.db'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel3: TRzLabel
          Left = 19
          Top = 84
          Width = 33
          Height = 14
          Caption = 'Mir.db'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel4: TRzLabel
          Left = 19
          Top = 112
          Width = 51
          Height = 14
          Caption = 'GuildBase'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel5: TRzLabel
          Left = 19
          Top = 140
          Width = 59
          Height = 14
          Caption = 'BigStorage'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel20: TRzLabel
          Left = 19
          Top = 168
          Width = 57
          Height = 14
          Caption = 'SellOff.Sell'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel21: TRzLabel
          Left = 19
          Top = 196
          Width = 63
          Height = 14
          Caption = 'SellOff.Gold'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel24: TRzLabel
          Left = 19
          Top = 224
          Width = 57
          Height = 14
          Caption = '!Setup.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object ButtonEditIDDB1: TRzButtonEdit
          Left = 75
          Top = 28
          Width = 328
          Height = 22
          Text = 'D:\MirServer\LoginSrv\IDDB\Id.DB'
          TabOrder = 0
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = ButtonEditIDDB1ButtonClick
        end
        object ButtonEditHumDB1: TRzButtonEdit
          Left = 75
          Top = 56
          Width = 328
          Height = 22
          Text = 'D:\MirServer\DBServer\FDB\Hum.DB'
          TabOrder = 1
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = ButtonEditHumDB1ButtonClick
        end
        object ButtonEditMirDB1: TRzButtonEdit
          Left = 75
          Top = 84
          Width = 328
          Height = 22
          Text = 'D:\MirServer\DBServer\FDB\Mir.DB'
          TabOrder = 2
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = ButtonEditMirDB1ButtonClick
        end
        object ButtonEditGuildBase1: TRzButtonEdit
          Left = 93
          Top = 112
          Width = 310
          Height = 22
          Text = 'D:\MirServer\Mir200\GuildBase'
          TabOrder = 3
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = ButtonEditGuildBase1ButtonClick
        end
        object ButtonEditBigStorage1: TRzButtonEdit
          Left = 93
          Top = 140
          Width = 310
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\Market_Storage\UserStorage.db'
          TabOrder = 4
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = ButtonEditBigStorage1ButtonClick
        end
        object ButtonEditSellOffSell1: TRzButtonEdit
          Left = 112
          Top = 168
          Width = 291
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\Market_SellOff\UserSellOff.sell'
          TabOrder = 5
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = ButtonEditSellOffSell1ButtonClick
        end
        object ButtonEditSellOffGold1: TRzButtonEdit
          Left = 112
          Top = 196
          Width = 291
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\Market_SellOff\UserSellOff.gold'
          TabOrder = 6
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = ButtonEditSellOffGold1ButtonClick
        end
        object ButtonEditSetup1: TRzButtonEdit
          Left = 103
          Top = 224
          Width = 300
          Height = 22
          Text = 'D:\MirServer\Mir200\!Setup.txt'
          TabOrder = 7
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = ButtonEditSetup1ButtonClick
        end
      end
      object RzGroupBox2: TRzGroupBox
        Left = 428
        Top = 9
        Width = 412
        Height = 263
        Caption = 'New Data'
        TabOrder = 1
        object RzLabel6: TRzLabel
          Left = 19
          Top = 28
          Width = 31
          Height = 14
          Caption = 'ID.DB'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel7: TRzLabel
          Left = 19
          Top = 56
          Width = 43
          Height = 14
          Caption = 'Hum.db'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel8: TRzLabel
          Left = 19
          Top = 84
          Width = 33
          Height = 14
          Caption = 'Mir.db'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel9: TRzLabel
          Left = 19
          Top = 112
          Width = 51
          Height = 14
          Caption = 'GuildBase'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel10: TRzLabel
          Left = 19
          Top = 140
          Width = 59
          Height = 14
          Caption = 'BigStorage'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel22: TRzLabel
          Left = 19
          Top = 168
          Width = 57
          Height = 14
          Caption = 'SellOff.Sell'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel23: TRzLabel
          Left = 19
          Top = 196
          Width = 63
          Height = 14
          Caption = 'SellOff.Gold'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel25: TRzLabel
          Left = 19
          Top = 224
          Width = 57
          Height = 14
          Caption = '!Setup.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object ButtonEditIDDB2: TRzButtonEdit
          Left = 75
          Top = 28
          Width = 328
          Height = 22
          Text = 'D:\MirServer\LoginSrv\IDDB\Id.DB'
          TabOrder = 0
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = ButtonEditIDDB2ButtonClick
        end
        object ButtonEditHumDB2: TRzButtonEdit
          Left = 75
          Top = 56
          Width = 328
          Height = 22
          Text = 'D:\MirServer\DBServer\FDB\Hum.DB'
          TabOrder = 1
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = ButtonEditHumDB2ButtonClick
        end
        object ButtonEditMirDB2: TRzButtonEdit
          Left = 75
          Top = 84
          Width = 328
          Height = 22
          Text = 'D:\MirServer\DBServer\FDB\Mir.DB'
          TabOrder = 2
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = ButtonEditMirDB2ButtonClick
        end
        object ButtonEditGuildBase2: TRzButtonEdit
          Left = 93
          Top = 112
          Width = 310
          Height = 22
          Text = 'D:\MirServer\Mir200\GuildBase'
          TabOrder = 3
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = ButtonEditGuildBase2ButtonClick
        end
        object ButtonEditBigStorage2: TRzButtonEdit
          Left = 93
          Top = 140
          Width = 310
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\Market_Storage\UserStorage.db'
          TabOrder = 4
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = ButtonEditBigStorage2ButtonClick
        end
        object ButtonEditSellOffSell2: TRzButtonEdit
          Left = 112
          Top = 168
          Width = 291
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\Market_SellOff\UserSellOff.sell'
          TabOrder = 5
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = ButtonEditSellOffSell2ButtonClick
        end
        object ButtonEditSellOffGold2: TRzButtonEdit
          Left = 112
          Top = 196
          Width = 291
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\Market_SellOff\UserSellOff.gold'
          TabOrder = 6
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = ButtonEditSellOffGold2ButtonClick
        end
        object ButtonEditSetup2: TRzButtonEdit
          Left = 103
          Top = 224
          Width = 300
          Height = 22
          Text = 'D:\MirServer\Mir200\!Setup.txt'
          TabOrder = 7
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = ButtonEditSetup2ButtonClick
        end
      end
      object RzGroupBox3: TRzGroupBox
        Left = 9
        Top = 280
        Width = 412
        Height = 113
        Caption = '??????(?)'
        TabOrder = 2
        object RzLabel14: TRzLabel
          Left = 9
          Top = 25
          Width = 115
          Height = 14
          Caption = 'ItemBindAccount.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel17: TRzLabel
          Left = 9
          Top = 53
          Width = 118
          Height = 14
          Caption = 'ItemBindChrName.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel18: TRzLabel
          Left = 9
          Top = 81
          Width = 104
          Height = 14
          Caption = 'ItemBindIPaddr.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object EditBindAccountA: TRzButtonEdit
          Left = 159
          Top = 21
          Width = 244
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\ItemBindAccount.txt'
          TabOrder = 0
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = EditBindAccountAButtonClick
        end
        object EditBindCharNameA: TRzButtonEdit
          Left = 159
          Top = 49
          Width = 244
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\ItemBindChrName.txt'
          TabOrder = 1
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = EditBindCharNameAButtonClick
        end
        object EditBindIPaddrA: TRzButtonEdit
          Left = 159
          Top = 77
          Width = 244
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\ItemBindIPaddr.txt'
          TabOrder = 2
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = EditBindIPaddrAButtonClick
        end
      end
      object RzGroupBox4: TRzGroupBox
        Left = 428
        Top = 280
        Width = 412
        Height = 113
        Caption = '??????(?)'
        TabOrder = 3
        object RzLabel26: TRzLabel
          Left = 9
          Top = 25
          Width = 115
          Height = 14
          Caption = 'ItemBindAccount.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel27: TRzLabel
          Left = 9
          Top = 53
          Width = 118
          Height = 14
          Caption = 'ItemBindChrName.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel28: TRzLabel
          Left = 9
          Top = 81
          Width = 104
          Height = 14
          Caption = 'ItemBindIPaddr.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object EditBindAccountB: TRzButtonEdit
          Left = 159
          Top = 21
          Width = 244
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\ItemBindAccount.txt'
          TabOrder = 0
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = EditBindAccountBButtonClick
        end
        object EditBindCharNameB: TRzButtonEdit
          Left = 159
          Top = 49
          Width = 244
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\ItemBindChrName.txt'
          TabOrder = 1
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = EditBindCharNameBButtonClick
        end
        object EditBindIPaddrB: TRzButtonEdit
          Left = 159
          Top = 77
          Width = 244
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\ItemBindIPaddr.txt'
          TabOrder = 2
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = EditBindIPaddrBButtonClick
        end
      end
      object RzGroupBox6: TRzGroupBox
        Left = 428
        Top = 401
        Width = 412
        Height = 58
        Caption = '??????(?)'
        TabOrder = 4
        object RzLabel30: TRzLabel
          Left = 9
          Top = 25
          Width = 123
          Height = 14
          Caption = 'RememberItemList.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object EditRememberItemListB: TRzButtonEdit
          Left = 159
          Top = 21
          Width = 244
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\RememberItemList.txt'
          TabOrder = 0
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = EditRememberItemListBButtonClick
        end
      end
      object RzGroupBox5: TRzGroupBox
        Left = 9
        Top = 401
        Width = 412
        Height = 58
        Caption = '??????(?)'
        TabOrder = 5
        object RzLabel29: TRzLabel
          Left = 9
          Top = 25
          Width = 123
          Height = 14
          Caption = 'RememberItemList.txt'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object EditRememberItemListA: TRzButtonEdit
          Left = 159
          Top = 21
          Width = 244
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\RememberItemList.txt'
          TabOrder = 0
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = EditRememberItemListAButtonClick
        end
      end
      object RzGroupBox7: TRzGroupBox
        Left = 9
        Top = 466
        Width = 412
        Height = 86
        Caption = '????(?)'
        TabOrder = 6
        object RzLabel31: TRzLabel
          Left = 9
          Top = 25
          Width = 52
          Height = 14
          Caption = 'Duel.Duel'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel33: TRzLabel
          Left = 9
          Top = 51
          Width = 54
          Height = 14
          Caption = 'Duel.Item'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object EditDuelInfoA: TRzButtonEdit
          Left = 79
          Top = 21
          Width = 324
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\Market_Duel\Duel.Duel'
          TabOrder = 0
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = EditDuelInfoAButtonClick
        end
        object EditDuelItemA: TRzButtonEdit
          Left = 79
          Top = 51
          Width = 324
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\Market_Duel\Duel.Item'
          TabOrder = 1
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = EditDuelItemAButtonClick
        end
      end
      object RzGroupBox8: TRzGroupBox
        Left = 428
        Top = 466
        Width = 412
        Height = 86
        Caption = '????(?)'
        TabOrder = 7
        object RzLabel32: TRzLabel
          Left = 9
          Top = 25
          Width = 52
          Height = 14
          Caption = 'Duel.Duel'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object RzLabel34: TRzLabel
          Left = 9
          Top = 51
          Width = 54
          Height = 14
          Caption = 'Duel.Item'
          BlinkIntervalOff = 1
          BlinkIntervalOn = 1
        end
        object EditDuelInfoB: TRzButtonEdit
          Left = 79
          Top = 21
          Width = 324
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\Market_Duel\Duel.Duel'
          TabOrder = 0
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = EditDuelInfoBButtonClick
        end
        object EditDuelItemB: TRzButtonEdit
          Left = 79
          Top = 51
          Width = 324
          Height = 22
          Text = 'D:\MirServer\Mir200\Envir\Market_Duel\Duel.Item'
          TabOrder = 1
          AltBtnWidth = 18
          ButtonWidth = 18
          OnButtonClick = EditDuelItemBButtonClick
        end
      end
      object RzGroupBox9: TRzGroupBox
        Left = 6
        Top = 559
        Width = 834
        Height = 338
        Caption = '???????'
        TabOrder = 8
        object RzGroupBox10: TRzGroupBox
          Left = 11
          Top = 19
          Width = 404
          Height = 272
          Caption = '??'
          TabOrder = 0
          object ListBoxDynamicVarA: TListBox
            Left = 14
            Top = 23
            Width = 379
            Height = 202
            ItemHeight = 14
            TabOrder = 0
            OnClick = ListBoxDynamicVarAClick
            OnMouseDown = ListBoxDynamicVarAMouseDown
          end
          object EditDynamicVarA: TRzButtonEdit
            Left = 14
            Top = 232
            Width = 379
            Height = 22
            TabOrder = 1
            AltBtnWidth = 18
            ButtonWidth = 18
            OnButtonClick = EditDynamicVarAButtonClick
          end
        end
        object RzGroupBox11: TRzGroupBox
          Left = 422
          Top = 19
          Width = 405
          Height = 272
          Caption = '??'
          TabOrder = 1
          object ListBoxDynamicVarB: TListBox
            Left = 14
            Top = 23
            Width = 379
            Height = 202
            ItemHeight = 14
            TabOrder = 0
            OnClick = ListBoxDynamicVarBClick
            OnMouseDown = ListBoxDynamicVarBMouseDown
          end
          object EditDynamicVarB: TRzButtonEdit
            Left = 14
            Top = 232
            Width = 379
            Height = 22
            TabOrder = 1
            AltBtnWidth = 18
            ButtonWidth = 18
            OnButtonClick = EditDynamicVarBButtonClick
          end
        end
        object ButtonDynamicVarAdd: TButton
          Left = 634
          Top = 299
          Width = 87
          Height = 29
          Caption = '??'
          TabOrder = 2
          OnClick = ButtonDynamicVarAddClick
        end
        object ButtonDynamicVarDel: TButton
          Left = 728
          Top = 299
          Width = 88
          Height = 29
          Caption = '??'
          Enabled = False
          TabOrder = 3
          OnClick = ButtonDynamicVarDelClick
        end
      end
      object RzGroupBox12: TRzGroupBox
        Left = 6
        Top = 904
        Width = 834
        Height = 339
        Caption = '??????'
        TabOrder = 9
        object RzGroupBox13: TRzGroupBox
          Left = 11
          Top = 19
          Width = 404
          Height = 272
          Caption = '??'
          TabOrder = 0
          object ListBoxCharNameA: TListBox
            Left = 14
            Top = 23
            Width = 379
            Height = 202
            ItemHeight = 14
            TabOrder = 0
            OnClick = ListBoxCharNameAClick
            OnMouseDown = ListBoxCharNameAMouseDown
          end
          object EditCharNameA: TRzButtonEdit
            Left = 14
            Top = 232
            Width = 379
            Height = 22
            TabOrder = 1
            AltBtnWidth = 18
            ButtonWidth = 18
            OnButtonClick = EditCharNameAButtonClick
          end
        end
        object RzGroupBox14: TRzGroupBox
          Left = 422
          Top = 19
          Width = 405
          Height = 272
          Caption = '??'
          TabOrder = 1
          object ListBoxCharNameB: TListBox
            Left = 14
            Top = 23
            Width = 379
            Height = 202
            ItemHeight = 14
            TabOrder = 0
            OnClick = ListBoxCharNameBClick
            OnMouseDown = ListBoxCharNameBMouseDown
          end
          object EditCharNameB: TRzButtonEdit
            Left = 14
            Top = 232
            Width = 379
            Height = 22
            TabOrder = 1
            AltBtnWidth = 18
            ButtonWidth = 18
            OnButtonClick = EditCharNameBButtonClick
          end
        end
        object ButtonCharNameAdd: TButton
          Left = 634
          Top = 299
          Width = 87
          Height = 29
          Caption = '??'
          TabOrder = 2
          OnClick = ButtonCharNameAddClick
        end
        object ButtonCharNameDel: TButton
          Left = 728
          Top = 299
          Width = 88
          Height = 29
          Caption = '??'
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
    Width = 874
    Height = 113
    Align = alTop
    BorderOuter = fsBump
    TabOrder = 2
    object RzLabel11: TRzLabel
      Left = 187
      Top = 14
      Width = 25
      Height = 14
      Caption = 'Days'
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object RzLabel12: TRzLabel
      Left = 280
      Top = 14
      Width = 18
      Height = 14
      Caption = '???'
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object RzLabel13: TRzLabel
      Left = 373
      Top = 14
      Width = 28
      Height = 14
      Caption = 'Level'
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object RzLabel15: TRzLabel
      Left = 187
      Top = 70
      Width = 25
      Height = 14
      Caption = 'Days'
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object RzLabel16: TRzLabel
      Left = 280
      Top = 70
      Width = 24
      Height = 14
      Caption = '????'
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object RzLabel19: TRzLabel
      Left = 397
      Top = 79
      Width = 92
      Height = 14
      Caption = 'Save Directory'
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object CheckBoxClearHumLevel: TRzCheckBox
      Left = 9
      Top = 9
      Width = 112
      Height = 20
      Caption = 'Clear Hum Level'
      State = cbUnchecked
      TabOrder = 0
      OnClick = CheckBoxClearHumLevelClick
    end
    object CheckBoxClearDeleteHum: TRzCheckBox
      Left = 9
      Top = 28
      Width = 151
      Height = 20
      Caption = 'Delete Hum'
      State = cbUnchecked
      TabOrder = 1
      OnClick = CheckBoxClearDeleteHumClick
    end
    object CheckBoxClearID1: TRzCheckBox
      Left = 9
      Top = 65
      Width = 104
      Height = 20
      Caption = '????(????)'
      State = cbUnchecked
      TabOrder = 2
      OnClick = CheckBoxClearID1Click
    end
    object CheckBoxClearID2: TRzCheckBox
      Left = 9
      Top = 84
      Width = 120
      Height = 20
      Caption = '????(?????)'
      State = cbUnchecked
      TabOrder = 3
      OnClick = CheckBoxClearID2Click
    end
    object NumericEditDay: TRzNumericEdit
      Left = 216
      Top = 9
      Width = 48
      Height = 22
      TabOrder = 4
      OnChange = NumericEditDayChange
      Max = 999999999.000000000000000000
      Value = 60.000000000000000000
      DisplayFormat = '0'
    end
    object NumericEditLevel: TRzNumericEdit
      Left = 327
      Top = 9
      Width = 38
      Height = 22
      TabOrder = 5
      OnChange = NumericEditLevelChange
      Max = 65535.000000000000000000
      Value = 35.000000000000000000
      DisplayFormat = '0'
    end
    object NumericEditDay1: TRzNumericEdit
      Left = 224
      Top = 65
      Width = 48
      Height = 22
      TabOrder = 6
      OnChange = NumericEditDay1Change
      Max = 999999999.000000000000000000
      Value = 60.000000000000000000
      DisplayFormat = '0'
    end
    object ButtonEditSaveDir: TRzButtonEdit
      Left = 492
      Top = 75
      Width = 339
      Height = 22
      Text = '.\'
      TabOrder = 7
      AltBtnWidth = 18
      ButtonWidth = 18
      OnButtonClick = ButtonEditSaveDirButtonClick
    end
    object CheckBoxBigStorage: TRzCheckBox
      Left = 579
      Top = 9
      Width = 113
      Height = 20
      Caption = '??????'
      Checked = True
      State = cbChecked
      TabOrder = 8
      OnClick = CheckBoxBigStorageClick
    end
    object CheckBoxSellOff: TRzCheckBox
      Left = 579
      Top = 28
      Width = 85
      Height = 20
      Caption = '????'
      Checked = True
      State = cbChecked
      TabOrder = 9
      OnClick = CheckBoxSellOffClick
    end
    object CheckBoxCheckCopyItems: TRzCheckBox
      Left = 411
      Top = 9
      Width = 134
      Height = 20
      Caption = 'Check Copy Items'
      Checked = True
      State = cbChecked
      TabOrder = 10
      OnClick = CheckBoxCheckCopyItemsClick
    end
    object CheckBoxSetItemMakeIndex: TRzCheckBox
      Left = 411
      Top = 28
      Width = 150
      Height = 20
      Caption = 'Item Make Index'
      Checked = True
      State = cbChecked
      TabOrder = 11
      OnClick = CheckBoxSetItemMakeIndexClick
    end
    object CheckBoxClearNotDataHum: TRzCheckBox
      Left = 9
      Top = 47
      Width = 179
      Height = 20
      Caption = '????(?????)'
      State = cbUnchecked
      TabOrder = 12
      OnClick = CheckBoxClearNotDataHumClick
    end
    object RzCheckBoxItemBind: TRzCheckBox
      Left = 699
      Top = 9
      Width = 141
      Height = 20
      Caption = '????????'
      Checked = True
      State = cbChecked
      TabOrder = 13
      OnClick = RzCheckBoxItemBindClick
    end
    object RzCheckBoxDuel: TRzCheckBox
      Left = 579
      Top = 48
      Width = 113
      Height = 20
      Caption = '??????'
      Checked = True
      State = cbChecked
      TabOrder = 14
      OnClick = RzCheckBoxDuelClick
    end
    object RzCheckBoxItemDblClick: TRzCheckBox
      Left = 699
      Top = 28
      Width = 141
      Height = 20
      Caption = '????????'
      Checked = True
      State = cbChecked
      TabOrder = 15
      OnClick = RzCheckBoxItemDblClickClick
    end
    object CheckBoxDeleteLowLevel: TCheckBox
      Left = 411
      Top = 47
      Width = 161
      Height = 20
      Caption = 'Delete Low Level'
      Checked = True
      State = cbChecked
      TabOrder = 16
      OnClick = CheckBoxDeleteLowLevelClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 545
    Width = 874
    Height = 40
    Align = alBottom
    TabOrder = 3
    object LabelVersion: TRzLabel
      Left = 9
      Top = 11
      Width = 158
      Height = 14
      Caption = '???? (C) 2010-2020 MakeGM'
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object RzURLLabel2: TRzURLLabel
      Left = 267
      Top = 17
      Width = 116
      Height = 13
      Caption = 'http://www.lomcn.co.uk'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
      URL = 'http://www.51pao.com'
    end
    object BitBtnStart: TRzBitBtn
      Left = 557
      Top = 5
      Width = 94
      Height = 29
      Caption = 'Start'
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
      Spacing = 5
    end
    object BitBtnLog: TRzBitBtn
      Left = 658
      Top = 5
      Width = 88
      Height = 29
      Caption = 'Log'
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
      Spacing = 5
    end
    object BitBtnCLose: TRzBitBtn
      Left = 753
      Top = 5
      Width = 87
      Height = 29
      Caption = 'Close'
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
      Spacing = 5
    end
  end
  object OpenDialog: TOpenDialog
    Left = 280
    Top = 32
  end
end
