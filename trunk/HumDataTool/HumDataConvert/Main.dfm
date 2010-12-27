object frmMain: TfrmMain
  Left = 717
  Top = 244
  BorderStyle = bsDialog
  Caption = #39134#23572#19990#30028#25968#25454#36716#25442#24037#20855'[2008/06/11]'
  ClientHeight = 214
  ClientWidth = 503
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object RzLabel1: TRzLabel
    Left = 8
    Top = 112
    Width = 48
    Height = 12
    Caption = #20445#23384#30446#24405
  end
  object ProgressStatus: TRzProgressStatus
    Left = 0
    Top = 175
    Width = 503
    Align = alBottom
    ParentShowHint = False
    PartsComplete = 0
    Percent = 0
    ShowPercent = True
    TotalParts = 0
  end
  object CheckBoxMir: TRzCheckBox
    Left = 8
    Top = 16
    Width = 57
    Height = 17
    Caption = 'Mir.DB'
    Checked = True
    State = cbChecked
    TabOrder = 0
    OnClick = CheckBoxMirClick
  end
  object EditMir: TRzButtonEdit
    Left = 128
    Top = 16
    Width = 369
    Height = 20
    Text = 'D:\MirServer\DBServer\FDB\Mir.DB'
    TabOrder = 1
    AltBtnWidth = 15
    ButtonWidth = 15
    OnButtonClick = EditMirButtonClick
  end
  object CheckBoxUserStorage: TRzCheckBox
    Left = 8
    Top = 40
    Width = 105
    Height = 17
    Caption = 'UserStorage.DB'
    Checked = True
    State = cbChecked
    TabOrder = 2
    OnClick = CheckBoxUserStorageClick
  end
  object CheckBoxGoldOff: TRzCheckBox
    Left = 8
    Top = 88
    Width = 121
    Height = 17
    Caption = 'UserSellOff.Gold'
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnClick = CheckBoxGoldOffClick
  end
  object EditUserStorage: TRzButtonEdit
    Left = 128
    Top = 40
    Width = 369
    Height = 20
    Text = 'D:\MirServer\Mir200\Envir\Market_Storage\UserStorage.DB'
    TabOrder = 4
    AltBtnWidth = 15
    ButtonWidth = 15
    OnButtonClick = EditUserStorageButtonClick
  end
  object EditSellOff: TRzButtonEdit
    Left = 128
    Top = 64
    Width = 369
    Height = 20
    Text = 'D:\MirServer\Mir200\Envir\Market_SellOff\UserSellOff.sell'
    TabOrder = 5
    AltBtnWidth = 15
    ButtonWidth = 15
    OnButtonClick = EditSellOffButtonClick
  end
  object CheckBoxSellOff: TRzCheckBox
    Left = 8
    Top = 64
    Width = 113
    Height = 17
    Caption = 'UserSellOff.sell'
    Checked = True
    State = cbChecked
    TabOrder = 6
    OnClick = CheckBoxSellOffClick
  end
  object EditGoldOff: TRzButtonEdit
    Left = 128
    Top = 88
    Width = 369
    Height = 20
    Text = 'D:\MirServer\Mir200\Envir\Market_SellOff\UserSellOff.gold'
    TabOrder = 7
    AltBtnWidth = 15
    ButtonWidth = 15
    OnButtonClick = EditGoldOffButtonClick
  end
  object ButtonConvert: TRzButton
    Left = 420
    Top = 144
    Caption = #36716#25442
    TabOrder = 8
    OnClick = ButtonConvertClick
  end
  object EditSaveDir: TRzButtonEdit
    Left = 128
    Top = 112
    Width = 369
    Height = 20
    Text = '.\'
    TabOrder = 9
    AltBtnWidth = 15
    ButtonWidth = 15
    OnButtonClick = EditSaveDirButtonClick
  end
  object StatusBar: TRzStatusBar
    Left = 0
    Top = 195
    Width = 503
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    TabOrder = 10
    VisualStyle = vsGradient
    object RzStatusPane: TRzStatusPane
      Left = 0
      Top = 0
      Width = 503
      Height = 19
      Align = alClient
    end
  end
  object RzRadioButton1: TRzRadioButton
    Left = 8
    Top = 144
    Width = 105
    Height = 17
    Caption = #20998#36523#29256#36716#33521#38596#29256
    Checked = True
    TabOrder = 11
    TabStop = True
    OnClick = RzRadioButton1Click
  end
  object RzRadioButton2: TRzRadioButton
    Left = 128
    Top = 144
    Width = 105
    Height = 17
    Caption = #32769#33521#38596#36716#26032#33521#38596
    TabOrder = 12
    OnClick = RzRadioButton2Click
  end
  object RzRadioButton3: TRzRadioButton
    Left = 239
    Top = 144
    Width = 175
    Height = 17
    Caption = #32769#33521#38596#36716#26032#33521#38596'(2008-08-21)'
    TabOrder = 13
    OnClick = RzRadioButton3Click
  end
  object OpenDialog: TOpenDialog
    Left = 288
    Top = 8
  end
  object Timer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = TimerTimer
    Left = 360
    Top = 360
  end
end
