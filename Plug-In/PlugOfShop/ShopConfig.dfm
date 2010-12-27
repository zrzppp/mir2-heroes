object FrmShopItem: TFrmShopItem
  Left = 505
  Top = 77
  BorderStyle = bsDialog
  Caption = #21830#21697#32534#36753
  ClientHeight = 408
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 296
    Width = 60
    Height = 12
    Caption = #21830#21697#21517#31216#65306
  end
  object Label2: TLabel
    Left = 8
    Top = 320
    Width = 60
    Height = 12
    Caption = #21830#21697#20215#26684#65306
  end
  object Label3: TLabel
    Left = 400
    Top = 320
    Width = 60
    Height = 12
    Caption = #21830#21697#25551#36848#65306
  end
  object Label4: TLabel
    Left = 400
    Top = 296
    Width = 60
    Height = 12
    Caption = #31616#21333#20171#32461#65306
  end
  object Label5: TLabel
    Left = 136
    Top = 320
    Width = 60
    Height = 12
    Caption = #22270#29255#20171#32461#65306
  end
  object Label6: TLabel
    Left = 272
    Top = 348
    Width = 54
    Height = 12
    Caption = #29289#21697#25968#37327':'
  end
  object GroupBox2: TGroupBox
    Left = 624
    Top = 8
    Width = 145
    Height = 393
    Caption = #29289#21697#21015#34920
    TabOrder = 0
    object ListBoxItemList: TListBox
      Left = 8
      Top = 16
      Width = 129
      Height = 369
      ItemHeight = 12
      TabOrder = 0
      OnClick = ListBoxItemListClick
    end
  end
  object EditShopItemName: TEdit
    Left = 72
    Top = 296
    Width = 193
    Height = 20
    ReadOnly = True
    TabOrder = 1
  end
  object ButtonChgShopItem: TButton
    Left = 72
    Top = 344
    Width = 65
    Height = 25
    Caption = #20462#25913'(&C)'
    TabOrder = 2
    OnClick = ButtonChgShopItemClick
  end
  object ButtonDelShopItem: TButton
    Left = 8
    Top = 344
    Width = 65
    Height = 25
    Caption = #21024#38500'(&D)'
    TabOrder = 3
    OnClick = ButtonDelShopItemClick
  end
  object SpinEditPrice: TSpinEdit
    Left = 72
    Top = 320
    Width = 57
    Height = 21
    MaxValue = 100000000
    MinValue = 0
    TabOrder = 4
    Value = 100
  end
  object Memo2: TMemo
    Left = 464
    Top = 320
    Width = 153
    Height = 81
    TabOrder = 5
  end
  object ButtonAddShopItem: TButton
    Left = 136
    Top = 344
    Width = 65
    Height = 25
    Caption = #22686#21152'(&A)'
    TabOrder = 6
    OnClick = ButtonAddShopItemClick
  end
  object ButtonLoadShopItemList: TButton
    Left = 8
    Top = 376
    Width = 257
    Height = 25
    Caption = #37325#26032#21152#36733#21830#21697#21015#34920'(&R)'
    TabOrder = 7
    OnClick = ButtonLoadShopItemListClick
  end
  object ButtonSaveShopItemList: TButton
    Left = 200
    Top = 344
    Width = 65
    Height = 25
    Caption = #20445#23384'(&S)'
    TabOrder = 8
    OnClick = ButtonSaveShopItemListClick
  end
  object RzPageControlShop: TRzPageControl
    Left = 8
    Top = 8
    Width = 609
    Height = 281
    ActivePage = TabSheet1
    TabIndex = 0
    TabOrder = 9
    OnClick = ListViewItemList1Click
    FixedDimension = 18
    object TabSheet1: TRzTabSheet
      Caption = #39318#39280
      object ListViewItemList1: TListView
        Left = 4
        Top = 10
        Width = 597
        Height = 239
        Columns = <
          item
            Caption = #21830#21697#21517#31216
            Width = 100
          end
          item
            Caption = #21830#21697#20215#26684
            Width = 60
          end
          item
            Caption = #22270#29255#20171#32461
            Width = 60
          end
          item
            Caption = #31616#21333#20171#32461
            Width = 100
          end
          item
            Caption = #21830#21697#25551#36848
            Width = 160
          end
          item
            Caption = #21040#26399#26102#38388
            Width = 80
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = ListViewItemList1Click
      end
    end
    object TabSheet2: TRzTabSheet
      Caption = #34917#32473
      object ListViewItemList2: TListView
        Left = 4
        Top = 10
        Width = 597
        Height = 239
        Columns = <
          item
            Caption = #21830#21697#21517#31216
            Width = 100
          end
          item
            Caption = #21830#21697#20215#26684
            Width = 60
          end
          item
            Caption = #22270#29255#20171#32461
            Width = 60
          end
          item
            Caption = #31616#21333#20171#32461
            Width = 100
          end
          item
            Caption = #21830#21697#25551#36848
            Width = 160
          end
          item
            Caption = #21040#26399#26102#38388
            Width = 80
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = ListViewItemList1Click
      end
    end
    object TabSheet3: TRzTabSheet
      Caption = #24378#21270
      object ListViewItemList3: TListView
        Left = 4
        Top = 10
        Width = 597
        Height = 239
        Columns = <
          item
            Caption = #21830#21697#21517#31216
            Width = 100
          end
          item
            Caption = #21830#21697#20215#26684
            Width = 60
          end
          item
            Caption = #22270#29255#20171#32461
            Width = 60
          end
          item
            Caption = #31616#21333#20171#32461
            Width = 100
          end
          item
            Caption = #21830#21697#25551#36848
            Width = 160
          end
          item
            Caption = #21040#26399#26102#38388
            Width = 80
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = ListViewItemList1Click
      end
    end
    object TabSheet4: TRzTabSheet
      Caption = #22909#21451
      object ListViewItemList4: TListView
        Left = 4
        Top = 10
        Width = 597
        Height = 239
        Columns = <
          item
            Caption = #21830#21697#21517#31216
            Width = 100
          end
          item
            Caption = #21830#21697#20215#26684
            Width = 60
          end
          item
            Caption = #22270#29255#20171#32461
            Width = 60
          end
          item
            Caption = #31616#21333#20171#32461
            Width = 100
          end
          item
            Caption = #21830#21697#25551#36848
            Width = 160
          end
          item
            Caption = #21040#26399#26102#38388
            Width = 80
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = ListViewItemList1Click
      end
    end
    object TabSheet5: TRzTabSheet
      Caption = #38480#37327
      object ListViewItemList5: TListView
        Left = 4
        Top = 10
        Width = 597
        Height = 239
        Columns = <
          item
            Caption = #21830#21697#21517#31216
            Width = 100
          end
          item
            Caption = #21830#21697#20215#26684
            Width = 60
          end
          item
            Caption = #22270#29255#20171#32461
            Width = 60
          end
          item
            Caption = #31616#21333#20171#32461
            Width = 100
          end
          item
            Caption = #21830#21697#25551#36848
            Width = 160
          end
          item
            Caption = #21040#26399#26102#38388
            Width = 80
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = ListViewItemList1Click
      end
    end
    object TabSheet6: TRzTabSheet
      Caption = #22855#29645
      object ListViewItemList6: TListView
        Left = 4
        Top = 10
        Width = 597
        Height = 239
        Columns = <
          item
            Caption = #21830#21697#21517#31216
            Width = 100
          end
          item
            Caption = #21830#21697#20215#26684
            Width = 60
          end
          item
            Caption = #22270#29255#20171#32461
            Width = 60
          end
          item
            Caption = #31616#21333#20171#32461
            Width = 100
          end
          item
            Caption = #21830#21697#25551#36848
            Width = 160
          end
          item
            Caption = #21040#26399#26102#38388
            Width = 80
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = ListViewItemList1Click
      end
    end
  end
  object Memo1: TEdit
    Left = 464
    Top = 296
    Width = 153
    Height = 20
    TabOrder = 10
  end
  object EditPicture: TEdit
    Left = 200
    Top = 320
    Width = 65
    Height = 20
    TabOrder = 11
    Text = '490-497'
  end
  object CheckBoxRandomUpgrade: TCheckBox
    Left = 272
    Top = 320
    Width = 73
    Height = 17
    Caption = #29983#25104#26497#21697
    TabOrder = 12
  end
  object CheckBoxLimitDay: TCheckBox
    Left = 272
    Top = 296
    Width = 65
    Height = 17
    Caption = #38480#21046#26102#38388
    TabOrder = 13
  end
  object EditMaxLimitDay: TSpinEdit
    Left = 344
    Top = 296
    Width = 49
    Height = 21
    Hint = #38480#21046#29289#21697#20351#29992#22825#25968
    MaxValue = 100000
    MinValue = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
    Value = 10
  end
  object EditAddValueRate: TSpinEdit
    Left = 344
    Top = 320
    Width = 49
    Height = 21
    Hint = #20135#29983#26497#21697#30340#20960#29575
    MaxValue = 100
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
    Value = 100
  end
  object EditItemCount: TSpinEdit
    Left = 328
    Top = 344
    Width = 129
    Height = 21
    MaxValue = 0
    MinValue = 0
    TabOrder = 16
    Value = 0
  end
end
