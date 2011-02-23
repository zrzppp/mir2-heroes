object frmItemManage: TfrmItemManage
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
  object RzPanel1: TPanel
    Left = 0
    Top = 0
    Width = 233
    Height = 477
    Align = alLeft
    TabOrder = 0
    object RzPanel5: TPanel
      Left = 1
      Top = 1
      Width = 231
      Height = 105
      Align = alTop
      TabOrder = 0
      object RzLabel24: TLabel
        Left = 8
        Top = 16
        Width = 24
        Height = 12
        Caption = #20998#31867
        Transparent = True
      end
      object RzLabel25: TLabel
        Left = 8
        Top = 40
        Width = 24
        Height = 12
        Caption = #21517#31216
        Transparent = True
      end
      object ComboBoxItemType: TComboBox
        Left = 40
        Top = 16
        Width = 185
        Height = 20
        Style = csDropDownList
        Ctl3D = False
        DropDownCount = 16
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 0
        OnClick = ComboBoxItemTypeClick
        Items.Strings = (
          '0-'#33647#21697
          '1-'#24178#32905
          '2-'#33647
          '3-'#21367#20070#12289#27833#12289#27700
          '4-'#20070#31821
          '5-'#27494#22120'1'
          '6-'#27494#22120'2'
          '10-'#30007#34915
          '11-'#22899#34915
          '15-'#22836#30420
          '19-'#39033#38142#65288#39764#27861#36530#36991#22411#65289
          '20-'#39033#38142
          '21-'#39033#38142#65288#25915#20987#21152#36895#22411#65289
          '22-'#25106#25351
          '23-'#25106#25351#65288#29305#21035#22411#65289
          '24-'#25163#38255
          '25-'#27602#31526
          '26-'#25163#22871#25163#38255
          '30-'#34593#28891#12289#28779#25226#12289#21195#31456
          '31-'#25414#21253
          '36-'#20070#20449#12289#28784#26408#12289#32418#26408
          '40-'#32905
          '41-'#29305#21035#35777#20070
          '42-'#37197#33647#21407#26009
          '43-'#30719#30707
          '44-'#29305#31181#29289#21697
          '45-'#20315#29260
          '46-'#20973#35777#31609#30721
          '47-'#37329#26465#12289#30742#12289#30418
          '50-'#20171#32461#20449)
      end
      object ComboBoxItemList: TComboBox
        Left = 40
        Top = 40
        Width = 185
        Height = 20
        Style = csDropDownList
        Ctl3D = False
        DropDownCount = 16
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 1
      end
      object Button_Search_Add: TButton
        Left = 6
        Top = 72
        Width = 51
        Height = 25
        Caption = #28155#21152
        TabOrder = 2
        OnClick = Button_Search_AddClick
      end
      object Button_Search_Del: TButton
        Left = 94
        Top = 72
        Width = 51
        Height = 25
        Caption = #21024#38500
        TabOrder = 3
        OnClick = Button_Search_DelClick
      end
      object Button_Search_Clear: TButton
        Left = 174
        Top = 72
        Width = 51
        Height = 25
        Caption = #28165#31354
        TabOrder = 4
        OnClick = Button_Search_ClearClick
      end
    end
    object Panel_Search_Item: TPanel
      Left = 1
      Top = 344
      Width = 231
      Height = 132
      Align = alBottom
      TabOrder = 1
      object Label1: TLabel
        Left = 8
        Top = 108
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
      object MenuButton_ClearCopyItem: TRzMenuButton
        Left = 96
        Top = 48
        Width = 121
        FrameColor = 7617536
        Caption = #28165#38500#25152#26377#22797#21046#35013#22791
        HotTrack = True
        TabOrder = 3
        DropDownMenu = PopupMenu_ClearCopyItem
      end
      object Button_Search_FindByList: TButton
        Left = 6
        Top = 16
        Width = 75
        Height = 25
        Caption = #25353#21015#34920#26597#25214
        TabOrder = 0
        OnClick = Button_Search_FindByListClick
      end
      object Button_Search_FindCopyItem: TButton
        Left = 96
        Top = 16
        Width = 121
        Height = 25
        Caption = #26597#25214#25152#26377#22797#21046#35013#22791
        TabOrder = 1
        OnClick = Button_Search_FindCopyItemClick
      end
      object Button_Search_FindByID: TButton
        Left = 6
        Top = 48
        Width = 75
        Height = 25
        Caption = #25353'ID'#26597#25214
        TabOrder = 2
        OnClick = Button_Search_FindByIDClick
      end
      object ButtonStopSearch: TButton
        Left = 8
        Top = 80
        Width = 75
        Height = 25
        Caption = #20572#27490#26597#25214
        TabOrder = 4
        OnClick = ButtonStopSearchClick
      end
    end
    object ListView_Search_Item: TListView
      Left = 1
      Top = 106
      Width = 231
      Height = 238
      Align = alClient
      Columns = <
        item
          Caption = #29289#21697#32534#21495
          Width = 60
        end
        item
          Caption = #29289#21697#21517#31216
          Width = 152
        end>
      GridLines = True
      RowSelect = True
      SortType = stBoth
      TabOrder = 2
      ViewStyle = vsReport
    end
  end
  object RzPanel2: TPanel
    Left = 233
    Top = 0
    Width = 467
    Height = 477
    Align = alClient
    TabOrder = 1
    object SizePanel1: TRzSizePanel
      Left = 1
      Top = 214
      Width = 465
      Height = 262
      Align = alBottom
      Color = clMoneyGreen
      HotSpotVisible = True
      SizeBarStyle = ssGroupBar
      SizeBarWidth = 7
      TabOrder = 0
      VisualStyle = vsGradient
      object RzGroupBox2: TRzGroupBox
        Left = 0
        Top = 8
        Width = 465
        Height = 254
        Align = alClient
        Alignment = taCenter
        Caption = #22797#21046#29289#21697#21015#34920
        GroupStyle = gsBanner
        TabOrder = 0
        object ListView_Search_CopyItem: TListView
          Left = 0
          Top = 20
          Width = 465
          Height = 234
          Align = alClient
          Columns = <
            item
              Caption = #20301#32622
              Width = 60
            end
            item
              Caption = #20154#29289#36134#21495
              Width = 60
            end
            item
              Caption = #20154#29289#21517#31216
              Width = 60
            end
            item
              Caption = #35013#22791#21517#31216
              Width = 60
            end
            item
              Caption = #31995#21015#21495
              Width = 60
            end
            item
              Caption = #25345#20037
              Width = 60
            end
            item
              Caption = #25915
              Width = 60
            end
            item
              Caption = #39764
              Width = 60
            end
            item
              Caption = #36947
              Width = 60
            end
            item
              Caption = #38450
              Width = 60
            end
            item
              Caption = #39764#38450
              Width = 60
            end
            item
              Caption = #38468#21152#23646#24615
              Width = 145
            end>
          GridLines = True
          MultiSelect = True
          RowSelect = True
          PopupMenu = PopupMenu_Search_CopyItem
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
    end
    object RzPanel3: TPanel
      Left = 1
      Top = 1
      Width = 465
      Height = 213
      Align = alClient
      TabOrder = 1
      object RzGroupBox1: TRzGroupBox
        Left = 1
        Top = 1
        Width = 463
        Height = 211
        Align = alClient
        Alignment = taCenter
        Caption = #29289#21697#25152#23646#21015#34920
        GroupStyle = gsBanner
        TabOrder = 0
        object ListView_Search_CharItem: TListView
          Left = 0
          Top = 20
          Width = 463
          Height = 191
          Align = alClient
          Columns = <
            item
              Caption = #20301#32622
              Width = 60
            end
            item
              Caption = #20154#29289#36134#21495
              Width = 60
            end
            item
              Caption = #20154#29289#21517#31216
              Width = 60
            end
            item
              Caption = #35013#22791#21517#31216
              Width = 60
            end
            item
              Caption = #31995#21015#21495
              Width = 60
            end
            item
              Caption = #25345#20037
              Width = 60
            end
            item
              Caption = #25915
              Width = 60
            end
            item
              Caption = #39764
              Width = 60
            end
            item
              Caption = #36947
              Width = 60
            end
            item
              Caption = #38450
              Width = 60
            end
            item
              Caption = #39764#38450
              Width = 60
            end
            item
              Caption = #38468#21152#23646#24615
              Width = 145
            end>
          GridLines = True
          MultiSelect = True
          RowSelect = True
          PopupMenu = PopupMenu_Search_CharItem
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
    end
  end
  object PopupMenu_Search_CharItem: TPopupMenu
    Left = 402
    Top = 131
    object Menu_Search_CharItem_CopyAccount: TMenuItem
      Caption = #22797#21046#20154#29289#36134#21495
      OnClick = Menu_Search_CharItem_CopyAccountClick
    end
    object Menu_Search_CharItem_CopyCharName: TMenuItem
      Caption = #22797#21046#20154#29289#21517#31216
      OnClick = Menu_Search_CharItem_CopyCharNameClick
    end
    object Menu_Search_CharItem_CopyItemName: TMenuItem
      Caption = #22797#21046#35013#22791#21517#31216
      OnClick = Menu_Search_CharItem_CopyItemNameClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Menu_Search_CharItem_SelectAll: TMenuItem
      Caption = #20840#37096#36873#20013
      OnClick = Menu_Search_CharItem_SelectAllClick
    end
    object Menu_Search_CharItem_NoSelectAll: TMenuItem
      Caption = #20840#37096#19981#36873
      OnClick = Menu_Search_CharItem_NoSelectAllClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object Menu_Search_CharItem_Del: TMenuItem
      Caption = #21024#38500#36873#20013#29289#21697
      OnClick = Menu_Search_CharItem_DelClick
    end
  end
  object PopupMenu_ClearCopyItem: TPopupMenu
    Left = 98
    Top = 427
    object MenuItem_ClearFirst: TMenuItem
      Caption = #28165#38500#21069#32773
      OnClick = MenuItem_ClearFirstClick
    end
    object MenuItem_ClearNext: TMenuItem
      Caption = #28165#38500#21518#32773
      OnClick = MenuItem_ClearNextClick
    end
  end
  object PopupMenu_Search_CopyItem: TPopupMenu
    Left = 410
    Top = 363
    object Menu_Search_CopyItem_CopyAccount: TMenuItem
      Caption = #22797#21046#20154#29289#36134#21495
      OnClick = Menu_Search_CopyItem_CopyAccountClick
    end
    object Menu_Search_CopyItem_CopyCharName: TMenuItem
      Caption = #22797#21046#20154#29289#21517#31216
      OnClick = Menu_Search_CopyItem_CopyCharNameClick
    end
    object Menu_Search_Copytem_CopyItemName: TMenuItem
      Caption = #22797#21046#35013#22791#21517#31216
      OnClick = Menu_Search_Copytem_CopyItemNameClick
    end
    object MenuItem4: TMenuItem
      Caption = '-'
    end
    object Menu_Search_CopyItem_SelectAll: TMenuItem
      Caption = #20840#37096#36873#20013
      OnClick = Menu_Search_CopyItem_SelectAllClick
    end
    object Menu_Search_CopyItem_NoSelectAll: TMenuItem
      Caption = #20840#37096#19981#36873
      OnClick = Menu_Search_CopyItem_NoSelectAllClick
    end
    object MenuItem7: TMenuItem
      Caption = '-'
    end
    object Menu_Search_CopyItem_Del: TMenuItem
      Caption = #21024#38500#36873#20013#29289#21697
      OnClick = Menu_Search_CopyItem_DelClick
    end
  end
end
