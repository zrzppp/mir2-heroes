object FrmMain: TFrmMain
  Left = 463
  Top = 244
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #33050#26412#21152#35299#23494#24037#20855
  ClientHeight = 506
  ClientWidth = 718
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
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 705
    Height = 489
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #33050#26412#21152#35299#23494
      object Label1: TLabel
        Left = 429
        Top = 220
        Width = 36
        Height = 13
        AutoSize = False
        Caption = #23494#30721#65306
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object ButtonSelEncodeFile: TButton
        Left = 0
        Top = 212
        Width = 89
        Height = 25
        Caption = #25171#24320#21152#23494#33050#26412
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = ButtonSelEncodeFileClick
      end
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 697
        Height = 201
        Lines.Strings = (
          #31243#24207#21046#20316#65306'MakeGM'
          #32852#31995'QQ'#65306'1037527564'
          #31243#24207#32593#22336#65306'http://www.MakeGM.com')
        PopupMenu = PopupMenu1
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object Memo2: TMemo
        Left = 0
        Top = 248
        Width = 697
        Height = 208
        Lines.Strings = (
          #31243#24207#21046#20316#65306'MakeGM'
          #32852#31995'QQ'#65306'1037527564'
          #31243#24207#32593#22336#65306'http://www.MakeGM.com')
        PopupMenu = PopupMenu2
        ScrollBars = ssBoth
        TabOrder = 2
      end
      object ButtonSelDecodeFile: TButton
        Left = 96
        Top = 212
        Width = 89
        Height = 25
        Caption = #25171#24320#26222#36890#33050#26412
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = ButtonSelDecodeFileClick
      end
      object ButtonDecode: TButton
        Left = 190
        Top = 212
        Width = 59
        Height = 25
        Caption = #35299#23494
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = ButtonDecodeClick
      end
      object ButtonEncode: TButton
        Left = 254
        Top = 212
        Width = 59
        Height = 25
        Caption = #21152#23494
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = ButtonEncodeClick
      end
      object EditPassWord: TEdit
        Left = 464
        Top = 216
        Width = 217
        Height = 20
        TabOrder = 6
      end
    end
    object TabSheet2: TTabSheet
      Caption = #25209#37327#22788#29702
      ImageIndex = 1
      object LabeMsg: TLabel
        Left = 16
        Top = 440
        Width = 42
        Height = 12
        Caption = 'LabeMsg'
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 681
        Height = 57
        Caption = #22522#26412#35774#32622
        TabOrder = 0
        object Label2: TLabel
          Left = 16
          Top = 24
          Width = 60
          Height = 12
          Caption = 'MirServer:'
        end
        object Label3: TLabel
          Left = 384
          Top = 24
          Width = 30
          Height = 12
          Caption = #23494#30721':'
        end
        object EditMirserver: TRzButtonEdit
          Left = 80
          Top = 22
          Width = 297
          Height = 20
          Text = 'D:\MirServer\'
          TabOrder = 0
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EditMirserverButtonClick
        end
        object EditPassWord1: TEdit
          Left = 424
          Top = 21
          Width = 249
          Height = 20
          TabOrder = 1
        end
      end
      object PageControl2: TPageControl
        Left = 8
        Top = 72
        Width = 681
        Height = 361
        ActivePage = TabSheet3
        TabOrder = 1
        object TabSheet3: TTabSheet
          Caption = #25209#37327#21152#23494
          object GroupBox2: TGroupBox
            Left = 8
            Top = 5
            Width = 281
            Height = 316
            Caption = #25152#26377#25991#20214#21015#34920
            TabOrder = 0
            object ListBoxFile: TListBox
              Left = 13
              Top = 16
              Width = 265
              Height = 289
              Hint = #21491#20987#28155#21152#38656#35201#21152#23494#30340#25991#20214','#25665#20303'CTRL'#38190#21487#20197#36827#34892#22810#36873#13#21452#20987#25171#24320#33050#26412
              ItemHeight = 12
              MultiSelect = True
              ParentShowHint = False
              PopupMenu = PopupMenu3
              ShowHint = True
              TabOrder = 0
              OnDblClick = ListBoxFileDblClick
            end
          end
          object ButtonEncode1: TButton
            Left = 296
            Top = 40
            Width = 75
            Height = 25
            Caption = #24320#22987#21152#23494
            TabOrder = 1
            OnClick = ButtonEncode1Click
          end
          object ButtonSearch: TButton
            Left = 296
            Top = 8
            Width = 73
            Height = 25
            Caption = #25628#32034#33050#26412
            TabOrder = 2
            OnClick = ButtonSearchClick
          end
          object GroupBox4: TGroupBox
            Left = 376
            Top = 5
            Width = 289
            Height = 316
            Caption = #21152#23494#25991#20214#21015#34920
            TabOrder = 3
            object ListBoxEncodeList: TListBox
              Left = 13
              Top = 16
              Width = 273
              Height = 289
              Hint = #21491#20987#21024#38500#19981#38656#35201#21152#23494#30340#25991#20214','#25665#20303'CTRL'#38190#21487#20197#36827#34892#22810#36873#13#21452#20987#25171#24320#33050#26412
              ItemHeight = 12
              MultiSelect = True
              ParentShowHint = False
              PopupMenu = PopupMenu4
              ShowHint = True
              TabOrder = 0
              OnDblClick = ListBoxEncodeListDblClick
            end
          end
        end
        object TabSheet4: TTabSheet
          Caption = #25209#37327#35299#23494
          ImageIndex = 1
          object Label4: TLabel
            Left = 8
            Top = 8
            Width = 54
            Height = 12
            Caption = #20445#23384#30446#24405':'
          end
          object ButtonSearchEncodeFile: TButton
            Left = 376
            Top = 0
            Width = 113
            Height = 25
            Caption = #25628#32034#24182#35299#23494#33050#26412
            TabOrder = 0
            OnClick = ButtonSearchEncodeFileClick
          end
          object EditSave: TRzButtonEdit
            Left = 72
            Top = 6
            Width = 297
            Height = 20
            Text = 'D:\MirServer\Mir200\Envir'
            TabOrder = 1
            AltBtnWidth = 15
            ButtonWidth = 15
            OnButtonClick = EditSaveButtonClick
          end
          object MemoLog: TMemo
            Left = 8
            Top = 32
            Width = 657
            Height = 297
            Lines.Strings = (
              'MemoLog')
            ScrollBars = ssBoth
            TabOrder = 2
          end
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = #25991#26412#25991#20214'|*.txt'
    Left = 208
    Top = 16
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 304
    Top = 72
    object N6: TMenuItem
      Caption = #21098#20999
      OnClick = N6Click
    end
    object N7: TMenuItem
      Caption = #22797#21046
      OnClick = N7Click
    end
    object N8: TMenuItem
      Caption = #31896#36148
      OnClick = N8Click
    end
    object N9: TMenuItem
      Caption = #21024#38500
      OnClick = N9Click
    end
    object N1: TMenuItem
      Caption = #28165#38500
      OnClick = N1Click
    end
    object N10: TMenuItem
      Caption = #20840#36873
      OnClick = N10Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object N2: TMenuItem
      Caption = #20445#23384
      OnClick = N2Click
    end
  end
  object PopupMenu3: TPopupMenu
    Left = 200
    Top = 304
    object MenuItem1: TMenuItem
      Caption = #28155#21152
      OnClick = MenuItem1Click
    end
  end
  object PopupMenu4: TPopupMenu
    Left = 496
    Top = 304
    object MenuItem2: TMenuItem
      Caption = #21024#38500
      OnClick = MenuItem2Click
    end
  end
  object PopupMenu2: TPopupMenu
    OnPopup = PopupMenu2Popup
    Left = 320
    Top = 312
    object MenuItem3: TMenuItem
      Caption = #21098#20999
      OnClick = MenuItem3Click
    end
    object MenuItem4: TMenuItem
      Caption = #22797#21046
      OnClick = MenuItem4Click
    end
    object MenuItem5: TMenuItem
      Caption = #31896#36148
      OnClick = MenuItem5Click
    end
    object MenuItem6: TMenuItem
      Caption = #21024#38500
      OnClick = MenuItem6Click
    end
    object MenuItem7: TMenuItem
      Caption = #28165#38500
      OnClick = N3Click
    end
    object MenuItem8: TMenuItem
      Caption = #20840#36873
      OnClick = MenuItem8Click
    end
    object MenuItem9: TMenuItem
      Caption = '-'
    end
    object MenuItem10: TMenuItem
      Caption = #20445#23384
      OnClick = N4Click
    end
  end
end
