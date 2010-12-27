object FrmFunctionConfig: TFrmFunctionConfig
  Left = 727
  Top = 192
  BorderStyle = bsDialog
  Caption = #21151#33021#35774#32622
  ClientHeight = 376
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Label14: TLabel
    Left = 8
    Top = 359
    Width = 432
    Height = 12
    Caption = #35843#25972#30340#21442#25968#31435#21363#29983#25928#65292#22312#32447#26102#35831#30830#35748#27492#21442#25968#30340#20316#29992#20877#35843#25972#65292#20081#35843#25972#23558#23548#33268#28216#25103#28151#20081
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object FunctionConfigControl: TPageControl
    Left = 8
    Top = 8
    Width = 457
    Height = 345
    ActivePage = TabSheet3
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #27668#34880#30707#35774#32622
      object GroupBox52: TGroupBox
        Left = 8
        Top = 8
        Width = 433
        Height = 97
        Caption = #27668#34880#30707
        TabOrder = 0
        object Label116: TLabel
          Left = 8
          Top = 24
          Width = 132
          Height = 12
          Caption = #24403#20154#29289#34880#20540#20302#20110#24635#34880#20540#30340
        end
        object Label117: TLabel
          Left = 192
          Top = 24
          Width = 156
          Height = 12
          Caption = '% '#26102#21551#21160#27668#34880#30707#12290#20351#29992#38388#38548#65306
        end
        object Label118: TLabel
          Left = 8
          Top = 48
          Width = 72
          Height = 12
          Caption = #27599#27425#22686#21152#34880#20540
        end
        object Label119: TLabel
          Left = 152
          Top = 48
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label128: TLabel
          Left = 400
          Top = 24
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label1: TLabel
          Left = 120
          Top = 70
          Width = 60
          Height = 12
          Caption = #25552#31034#20449#24687#65306
        end
        object SpinEditStartHPRock: TSpinEdit
          Left = 144
          Top = 20
          Width = 41
          Height = 21
          Hint = #24635#34880#20540#30340#30334#20998#27604
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 10
          OnChange = SpinEditStartHPRockChange
        end
        object SpinEditRockAddHP: TSpinEdit
          Left = 88
          Top = 44
          Width = 57
          Height = 21
          MaxValue = 65535
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 10
          OnChange = SpinEditRockAddHPChange
        end
        object SpinEditHPRockSpell: TSpinEdit
          Left = 352
          Top = 20
          Width = 41
          Height = 21
          Hint = #27599#27425#20351#29992#30340#38388#38548#26102#38388
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 3
          OnChange = SpinEditHPRockSpellChange
        end
        object CheckBoxStartHPRock: TCheckBox
          Left = 8
          Top = 68
          Width = 105
          Height = 17
          Hint = #36873#25321#21518#21551#21160#26102#65292#20250#22312#32842#22825#26639#20013#65292#32418#33394#23383#20307#25552#31034#29609#23478
          Caption = #21551#21160#26102#25552#31034#29992#25143
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = CheckBoxStartHPRockClick
        end
        object EditStartHPRockMsg: TEdit
          Left = 184
          Top = 68
          Width = 241
          Height = 20
          TabOrder = 4
          OnChange = EditStartHPRockMsgChange
        end
      end
      object GroupBox53: TGroupBox
        Left = 8
        Top = 112
        Width = 433
        Height = 97
        Caption = #24187#39764#30707
        TabOrder = 1
        object Label122: TLabel
          Left = 8
          Top = 24
          Width = 156
          Height = 12
          Caption = #24403#20154#29289#39764#27861#20540#20302#20110#24635#39764#27861#20540#30340
        end
        object Label124: TLabel
          Left = 8
          Top = 48
          Width = 84
          Height = 12
          Caption = #27599#27425#22686#21152#39764#27861#20540
        end
        object Label125: TLabel
          Left = 176
          Top = 48
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label123: TLabel
          Left = 216
          Top = 24
          Width = 156
          Height = 12
          Caption = '% '#26102#21551#21160#27668#39764#30707#12290#20351#29992#38388#38548#65306
        end
        object Label129: TLabel
          Left = 416
          Top = 24
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label2: TLabel
          Left = 120
          Top = 70
          Width = 60
          Height = 12
          Caption = #25552#31034#20449#24687#65306
        end
        object SpinEditStartMPRock: TSpinEdit
          Left = 168
          Top = 20
          Width = 41
          Height = 21
          Hint = #24635#39764#27861#20540#30340#30334#20998#27604
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 10
          OnChange = SpinEditStartMPRockChange
        end
        object SpinEditRockAddMP: TSpinEdit
          Left = 104
          Top = 44
          Width = 65
          Height = 21
          MaxValue = 65535
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 10
          OnChange = SpinEditRockAddMPChange
        end
        object SpinEditMPRockSpell: TSpinEdit
          Left = 368
          Top = 20
          Width = 41
          Height = 21
          Hint = #27599#27425#20351#29992#30340#38388#38548#26102#38388
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 3
          OnChange = SpinEditMPRockSpellChange
        end
        object CheckBoxStartMPRock: TCheckBox
          Left = 8
          Top = 68
          Width = 105
          Height = 17
          Hint = #36873#25321#21518#21551#21160#26102#65292#20250#22312#32842#22825#26639#20013#65292#32418#33394#23383#20307#25552#31034#29609#23478
          Caption = #21551#21160#26102#25552#31034#29992#25143
          TabOrder = 3
          OnClick = CheckBoxStartMPRockClick
        end
        object EditStartMPRockMsg: TEdit
          Left = 184
          Top = 68
          Width = 241
          Height = 20
          TabOrder = 4
          OnChange = EditStartMPRockMsgChange
        end
      end
      object ButtonSuperRockSave: TButton
        Left = 376
        Top = 291
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonSuperRockSaveClick
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 216
        Width = 433
        Height = 73
        Caption = #39764#34880#30707
        TabOrder = 3
        object Label6: TLabel
          Left = 8
          Top = 24
          Width = 48
          Height = 12
          Caption = #27599#27425#22686#21152
        end
        object Label7: TLabel
          Left = 128
          Top = 24
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label10: TLabel
          Left = 120
          Top = 46
          Width = 60
          Height = 12
          Caption = #25552#31034#20449#24687#65306
        end
        object Label5: TLabel
          Left = 400
          Top = 24
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label8: TLabel
          Left = 296
          Top = 24
          Width = 48
          Height = 12
          Caption = #20351#29992#38388#38548
        end
        object SpinEditRockAddHPMP: TSpinEdit
          Left = 64
          Top = 20
          Width = 57
          Height = 21
          MaxValue = 65535
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 10
          OnChange = SpinEditRockAddHPMPChange
        end
        object CheckBoxStartHPMPRock: TCheckBox
          Left = 8
          Top = 44
          Width = 105
          Height = 17
          Hint = #36873#25321#21518#21551#21160#26102#65292#20250#22312#32842#22825#26639#20013#65292#32418#33394#23383#20307#25552#31034#29609#23478
          Caption = #21551#21160#26102#25552#31034#29992#25143
          TabOrder = 1
          OnClick = CheckBoxStartHPMPRockClick
        end
        object EditStartHPMPRockMsg: TEdit
          Left = 184
          Top = 44
          Width = 241
          Height = 20
          TabOrder = 2
          OnChange = EditStartHPMPRockMsgChange
        end
        object SpinEditHPMPRockSpell: TSpinEdit
          Left = 352
          Top = 20
          Width = 41
          Height = 21
          Hint = #27599#27425#20351#29992#30340#38388#38548#26102#38388
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 3
          OnChange = SpinEditHPMPRockSpellChange
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #33258#23450#20041#21629#20196
      ImageIndex = 1
      object Label3: TLabel
        Left = 216
        Top = 168
        Width = 60
        Height = 12
        Caption = #21629#20196#21517#31216#65306
      end
      object Label4: TLabel
        Left = 216
        Top = 192
        Width = 60
        Height = 12
        Caption = #21629#20196#32534#21495#65306
      end
      object GroupBox5: TGroupBox
        Left = 8
        Top = 8
        Width = 201
        Height = 297
        Caption = #33258#23450#20041#21629#20196#21015#34920
        TabOrder = 0
        object ListBoxUserCommand: TListBox
          Left = 8
          Top = 16
          Width = 185
          Height = 273
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxUserCommandClick
        end
      end
      object EditCommandName: TEdit
        Left = 280
        Top = 164
        Width = 161
        Height = 20
        TabOrder = 1
      end
      object ButtonUserCommandAdd: TButton
        Left = 288
        Top = 216
        Width = 75
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonUserCommandAddClick
      end
      object SpinEditCommandIdx: TSpinEdit
        Left = 280
        Top = 188
        Width = 161
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object ButtonUserCommandDel: TButton
        Left = 368
        Top = 216
        Width = 75
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonUserCommandDelClick
      end
      object ButtonUserCommandChg: TButton
        Left = 288
        Top = 248
        Width = 75
        Height = 25
        Caption = #20462#25913'(&C)'
        TabOrder = 5
        OnClick = ButtonUserCommandChgClick
      end
      object ButtonUserCommandSave: TButton
        Left = 368
        Top = 248
        Width = 75
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 6
        OnClick = ButtonUserCommandSaveClick
      end
      object ButtonLoadUserCommandList: TButton
        Left = 288
        Top = 280
        Width = 153
        Height = 25
        Caption = #37325#26032#21152#36733#33258#23450#20041#21629#20196#21015#34920
        TabOrder = 7
        OnClick = ButtonLoadUserCommandListClick
      end
    end
    object TabSheet3: TTabSheet
      Caption = #31105#27490#29289#21697#35774#32622
      ImageIndex = 2
      object GroupBox21: TGroupBox
        Left = 312
        Top = 8
        Width = 133
        Height = 241
        Caption = #29289#21697#21015#34920
        TabOrder = 0
        object ListBoxitemList: TListBox
          Left = 8
          Top = 16
          Width = 113
          Height = 217
          Hint = #21452#20987#22686#21152#29289#21697#21040#31105#27490#29289#21697#21015#34920
          ItemHeight = 12
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnDblClick = ListBoxitemListDblClick
        end
      end
      object ButtonDisallowDel: TButton
        Left = 312
        Top = 256
        Width = 57
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 1
        OnClick = ButtonDisallowDelClick
      end
      object ButtonDisallowSave: TButton
        Left = 384
        Top = 256
        Width = 59
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonDisallowSaveClick
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 297
        Height = 305
        Caption = #31105#27490#29289#21697#21015#34920
        TabOrder = 3
        object ListViewDisallow: TListView
          Left = 8
          Top = 16
          Width = 281
          Height = 281
          Hint = '0'#20026#20801#35768' 1'#20026#31105#27490
          Columns = <
            item
              Caption = #29289#21697#21517#31216
              Width = 80
            end
            item
              Caption = #20173
              Width = 40
            end
            item
              Caption = #20132#26131
              Width = 40
            end
            item
              Caption = #23384
              Width = 40
            end
            item
              Caption = #20462#29702
              Width = 40
            end
            item
              Caption = #21319#32423
              Width = 40
            end
            item
              Caption = #20986#21806
              Width = 40
            end
            item
              Caption = #29190#20986
              Width = 40
            end
            item
              Caption = #24517#29190
              Width = 40
            end
            item
              Caption = #23567#36864#28040#22833
              Width = 60
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          ParentShowHint = False
          PopupMenu = PopupMenu_Disallow
          ShowHint = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListViewDisallowClick
        end
      end
      object ButtonLoadCheckItemList: TButton
        Left = 312
        Top = 288
        Width = 129
        Height = 25
        Caption = #37325#26032#21152#36733#31105#27490#29289#21697#37197#32622
        TabOrder = 4
        OnClick = ButtonLoadCheckItemListClick
      end
    end
    object TabSheet5: TTabSheet
      Caption = #28040#24687#36807#28388
      ImageIndex = 4
      object GroupBox22: TGroupBox
        Left = 8
        Top = 8
        Width = 433
        Height = 161
        Caption = #28040#24687#36807#28388#21015#34920
        TabOrder = 0
        object ListViewMsgFilter: TListView
          Left = 8
          Top = 16
          Width = 417
          Height = 137
          Columns = <
            item
              Caption = #36807#28388#28040#24687
              Width = 170
            end
            item
              Caption = #26367#25442#28040#24687
              Width = 170
            end
            item
              Caption = #35302#21457#33050#26412
              Width = 60
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListViewMsgFilterClick
        end
      end
      object GroupBox23: TGroupBox
        Left = 8
        Top = 176
        Width = 433
        Height = 105
        Caption = #28040#24687#36807#28388#21015#34920#32534#36753
        TabOrder = 1
        object Label22: TLabel
          Left = 8
          Top = 24
          Width = 60
          Height = 12
          Caption = #36807#28388#28040#24687#65306
        end
        object Label23: TLabel
          Left = 8
          Top = 48
          Width = 60
          Height = 12
          Caption = #26367#25442#28040#24687#65306
        end
        object EditFilterMsg: TEdit
          Left = 72
          Top = 20
          Width = 353
          Height = 20
          TabOrder = 0
        end
        object EditNewMsg: TEdit
          Left = 72
          Top = 44
          Width = 353
          Height = 20
          Hint = #26367#25442#28040#24687#20026#31354#26102#65292#20002#25481#25972#21477#12290
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object CheckBoxGotoLabel: TCheckBox
          Left = 8
          Top = 72
          Width = 73
          Height = 17
          Caption = #35302#21457#33050#26412
          TabOrder = 2
        end
      end
      object ButtonMsgFilterAdd: TButton
        Left = 8
        Top = 288
        Width = 65
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonMsgFilterAddClick
      end
      object ButtonMsgFilterDel: TButton
        Left = 80
        Top = 288
        Width = 65
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonMsgFilterDelClick
      end
      object ButtonMsgFilterSave: TButton
        Left = 224
        Top = 288
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonMsgFilterSaveClick
      end
      object ButtonMsgFilterChg: TButton
        Left = 152
        Top = 288
        Width = 65
        Height = 25
        Caption = #20462#25913'(&C)'
        TabOrder = 5
        OnClick = ButtonMsgFilterChgClick
      end
      object ButtonLoadMsgFilterList: TButton
        Left = 296
        Top = 288
        Width = 145
        Height = 25
        Caption = #37325#26032#21152#36733#28040#24687#36807#28388#21015#34920
        TabOrder = 6
        OnClick = ButtonLoadMsgFilterListClick
      end
    end
  end
  object PopupMenu_Disallow: TPopupMenu
    Left = 164
    Top = 167
    object PopupMenu_Disallow_ItemName: TMenuItem
      Caption = #29289#21697#21517#31216':'
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object PopupMenu_Disallow_CanDrop: TMenuItem
      Caption = #31105#27490#25172
      OnClick = PopupMenu_Disallow_CanDropClick
    end
    object PopupMenu_Disallow_CanDeal: TMenuItem
      Caption = #31105#27490#20132#26131
      OnClick = PopupMenu_Disallow_CanDropClick
    end
    object PopupMenu_Disallow_CanStorage: TMenuItem
      Caption = #31105#27490#23384
      OnClick = PopupMenu_Disallow_CanDropClick
    end
    object PopupMenu_Disallow_CanRepair: TMenuItem
      Caption = #31105#27490#20462#29702
      OnClick = PopupMenu_Disallow_CanDropClick
    end
    object PopupMenu_Disallow_CanUpgrade: TMenuItem
      Caption = #31105#27490#21319#32423
      OnClick = PopupMenu_Disallow_CanDropClick
    end
    object PopupMenu_Disallow_CanSell: TMenuItem
      Caption = #31105#27490#20986#21806
      OnClick = PopupMenu_Disallow_CanDropClick
    end
    object PopupMenu_Disallow_CanScatter: TMenuItem
      Caption = #31105#27490#29190#20986
      OnClick = PopupMenu_Disallow_CanDropClick
    end
    object PopupMenu_Disallow_CanDieScatter: TMenuItem
      Caption = #27515#20129#24517#29190
      OnClick = PopupMenu_Disallow_CanDropClick
    end
    object PopupMenu_Disallow_CanOffLineTake: TMenuItem
      Caption = #23567#36864#28040#22833
      OnClick = PopupMenu_Disallow_CanDropClick
    end
  end
end
