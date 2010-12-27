object FrmMain: TFrmMain
  Left = 464
  Top = 189
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'MakeGM'#33050#26412#21152#23494#25554#20214#24037#20855
  ClientHeight = 330
  ClientWidth = 777
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 329
    Height = 313
    Caption = #25554#20214#20449#24687#37197#21046
    TabOrder = 0
    object RzLabel1: TLabel
      Left = 8
      Top = 23
      Width = 54
      Height = 12
      Caption = #25554#20214#21517#31216':'
    end
    object RzLabel2: TLabel
      Left = 8
      Top = 47
      Width = 78
      Height = 12
      Caption = #21152#36733#25104#21151#20449#24687':'
    end
    object RzLabel3: TLabel
      Left = 8
      Top = 71
      Width = 78
      Height = 12
      Caption = #21152#36733#22833#36133#20449#24687':'
    end
    object RzLabel4: TLabel
      Left = 8
      Top = 95
      Width = 54
      Height = 12
      Caption = #21368#36733#20449#24687':'
    end
    object RzLabel5: TLabel
      Left = 8
      Top = 119
      Width = 54
      Height = 12
      Caption = #25554#20214#23494#30721':'
    end
    object RzLabel6: TLabel
      Left = 8
      Top = 144
      Width = 54
      Height = 12
      Caption = #29256#26412#31867#22411':'
    end
    object Label4: TLabel
      Left = 96
      Top = 168
      Width = 48
      Height = 12
      Caption = #35797#29992#22825#25968
    end
    object EditName: TEdit
      Left = 96
      Top = 20
      Width = 225
      Height = 20
      TabOrder = 0
    end
    object EditLoadPlugSucced: TEdit
      Left = 96
      Top = 43
      Width = 225
      Height = 20
      TabOrder = 1
    end
    object EditLoadPlugFail: TEdit
      Left = 96
      Top = 67
      Width = 225
      Height = 20
      TabOrder = 2
    end
    object EditUnLoadPlug: TEdit
      Left = 96
      Top = 91
      Width = 225
      Height = 20
      TabOrder = 3
    end
    object EditPassWord: TEdit
      Left = 96
      Top = 115
      Width = 225
      Height = 20
      TabOrder = 4
    end
    object EditVersion: TSpinEdit
      Left = 96
      Top = 139
      Width = 230
      Height = 21
      MaxValue = 65535
      MinValue = 0
      TabOrder = 5
      Value = 0
      OnChange = EditVersionChange
    end
    object MemoMsg: TMemo
      Left = 8
      Top = 190
      Width = 313
      Height = 78
      TabOrder = 6
    end
    object ButtonExit: TButton
      Left = 222
      Top = 276
      Width = 99
      Height = 25
      Caption = #20851#38381'(&E)'
      TabOrder = 7
      OnClick = ButtonExitClick
    end
    object ButtonCreatePlug: TButton
      Left = 8
      Top = 276
      Width = 99
      Height = 25
      Caption = #21019#24314#25554#20214'(&C)'
      TabOrder = 8
    end
    object ButtonSavePlug: TButton
      Left = 113
      Top = 276
      Width = 98
      Height = 25
      Caption = #20445#23384#25554#20214#20449#24687'(&S)'
      TabOrder = 9
      OnClick = ButtonSavePlugClick
    end
    object CheckBoxShareMode: TCheckBox
      Left = 8
      Top = 166
      Width = 73
      Height = 17
      Caption = #20801#35768#35797#29992
      TabOrder = 10
    end
    object EditShareDay: TSpinEdit
      Left = 152
      Top = 164
      Width = 169
      Height = 21
      MaxValue = 365
      MinValue = 1
      TabOrder = 11
      Value = 3
    end
  end
  object GroupBox3: TGroupBox
    Left = 343
    Top = 8
    Width = 425
    Height = 313
    Caption = #25554#20214#27880#20876
    TabOrder = 1
    object GroupBox4: TGroupBox
      Left = 9
      Top = 24
      Width = 313
      Height = 130
      Caption = #27880#20876#20449#24687
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 24
        Width = 42
        Height = 12
        Caption = #26426#22120#30721':'
      end
      object Label3: TLabel
        Left = 8
        Top = 49
        Width = 54
        Height = 12
        Caption = #27880#20876#22825#25968':'
      end
      object Label2: TLabel
        Left = 8
        Top = 76
        Width = 54
        Height = 12
        Caption = #29256#26412#31867#22411':'
      end
      object LabelDate: TLabel
        Left = 8
        Top = 104
        Width = 54
        Height = 12
        Caption = #27880#20876#26085#26399':'
      end
      object EditVersion1: TSpinEdit
        Left = 68
        Top = 73
        Width = 233
        Height = 21
        MaxValue = 65535
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object EditDays: TSpinEdit
        Left = 68
        Top = 46
        Width = 233
        Height = 21
        MaxValue = 65535
        MinValue = 0
        TabOrder = 1
        Value = 30
        OnChange = EditDaysChange
      end
      object ComboBoxSerialNumber: TComboBox
        Left = 68
        Top = 20
        Width = 233
        Height = 20
        ItemHeight = 12
        TabOrder = 2
      end
    end
    object RadioGroupLicDay: TRadioGroup
      Left = 328
      Top = 24
      Width = 89
      Height = 130
      Caption = #25480#26435#22825#25968
      ItemIndex = 0
      Items.Strings = (
        #19968#20010#26376
        #21322#24180
        #19968#24180)
      TabOrder = 1
      OnClick = RadioGroupLicDayClick
    end
    object MemoKey: TMemo
      Left = 8
      Top = 160
      Width = 314
      Height = 110
      TabOrder = 2
    end
    object RadioGroupUserMode: TRadioGroup
      Left = 328
      Top = 160
      Width = 89
      Height = 110
      Caption = #27880#20876#31867#22411
      ItemIndex = 0
      Items.Strings = (
        #26085#26399#38480#21046
        #26080#38480#21046)
      TabOrder = 3
      OnClick = RadioGroupUserModeClick
    end
    object ButtonOK: TButton
      Left = 3
      Top = 276
      Width = 98
      Height = 25
      Caption = #35745#31639#27880#20876#30721'(&M)'
      TabOrder = 4
    end
    object ButtonSave: TButton
      Left = 107
      Top = 276
      Width = 98
      Height = 25
      Caption = #20445#23384#29992#25143#20449#24687'(&S)'
      TabOrder = 5
      OnClick = ButtonSaveClick
    end
    object ButtonDel: TButton
      Left = 211
      Top = 276
      Width = 98
      Height = 25
      Caption = #21024#38500#29992#25143#20449#24687'(&D)'
      TabOrder = 6
      OnClick = ButtonDelClick
    end
    object Button2: TButton
      Left = 315
      Top = 276
      Width = 99
      Height = 25
      Caption = #20851#38381'(&E)'
      TabOrder = 7
      OnClick = ButtonExitClick
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 100
    Left = 344
    Top = 184
  end
end
