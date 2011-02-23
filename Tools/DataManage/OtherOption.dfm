object frmOtherOption: TfrmOtherOption
  Left = 0
  Top = 0
  Width = 708
  Height = 514
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object GroupBox: TRzGroupBox
    Left = 0
    Top = 0
    Width = 708
    Height = 514
    Align = alClient
    Alignment = taCenter
    Caption = #35831#22312#20572#26426#29366#24577#19979#20351#29992#25209#37327#20462#25913
    GroupStyle = gsBanner
    TabOrder = 0
    object RzPanel: TPanel
      Left = 0
      Top = 20
      Width = 708
      Height = 494
      Align = alClient
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 240
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
      object RzLabel1: TLabel
        Left = 16
        Top = 24
        Width = 54
        Height = 12
        Caption = #24403#21069#22320#22270':'
        Transparent = True
      end
      object RzLabel2: TLabel
        Left = 16
        Top = 48
        Width = 54
        Height = 12
        Caption = #22238#22478#22320#22270':'
        Transparent = True
      end
      object RzLabel3: TLabel
        Left = 160
        Top = 24
        Width = 36
        Height = 12
        Caption = 'X'#22352#26631':'
        Transparent = True
      end
      object RzLabel4: TLabel
        Left = 160
        Top = 48
        Width = 36
        Height = 12
        Caption = 'X'#22352#26631':'
        Transparent = True
      end
      object RzLabel5: TLabel
        Left = 272
        Top = 24
        Width = 36
        Height = 12
        Caption = 'Y'#22352#26631':'
        Transparent = True
      end
      object RzLabel6: TLabel
        Left = 272
        Top = 48
        Width = 36
        Height = 12
        Caption = 'Y'#22352#26631':'
        Transparent = True
      end
      object RzLabel7: TLabel
        Left = 16
        Top = 72
        Width = 96
        Height = 12
        Caption = #29289#21697#20195#30721#26367#25442' '#21407':'
        Transparent = True
      end
      object RzLabel8: TLabel
        Left = 16
        Top = 96
        Width = 96
        Height = 12
        Caption = #25216#33021#20195#30721#26367#25442' '#21407':'
        Transparent = True
      end
      object RzLabel9: TLabel
        Left = 176
        Top = 72
        Width = 24
        Height = 12
        Caption = '='#26032':'
        Transparent = True
      end
      object RzLabel10: TLabel
        Left = 176
        Top = 96
        Width = 24
        Height = 12
        Caption = '='#26032':'
        Transparent = True
      end
      object RzLabel11: TLabel
        Left = 16
        Top = 120
        Width = 54
        Height = 12
        Caption = #29289#21697#21024#38500':'
        Transparent = True
      end
      object RzLabel12: TLabel
        Left = 16
        Top = 144
        Width = 54
        Height = 12
        Caption = #25216#33021#21024#38500':'
        Transparent = True
      end
      object RzLabel13: TLabel
        Left = 168
        Top = 120
        Width = 30
        Height = 12
        Caption = #20195#30721':'
        Transparent = True
      end
      object RzLabel14: TLabel
        Left = 168
        Top = 144
        Width = 30
        Height = 12
        Caption = #20195#30721':'
        Transparent = True
      end
      object RzLabel15: TLabel
        Left = 16
        Top = 168
        Width = 30
        Height = 12
        Caption = #31561#32423':'
        Transparent = True
      end
      object RzLabel16: TLabel
        Left = 16
        Top = 192
        Width = 30
        Height = 12
        Caption = #37329#24065':'
        Transparent = True
      end
      object RzLabel17: TLabel
        Left = 16
        Top = 216
        Width = 30
        Height = 12
        Caption = 'PK'#20540':'
        Transparent = True
      end
      object ComboBoxDelItem: TComboBox
        Left = 72
        Top = 116
        Width = 89
        Height = 20
        Style = csDropDownList
        Ctl3D = False
        DragKind = dkDock
        DropDownCount = 16
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 16
        Items.Strings = (
          #25351#23450#29289#21697
          #25152#26377#29289#21697
          #36523#19978#29289#21697
          #21253#35065#29289#21697
          #20179#24211#29289#21697)
      end
      object ComboBoxDelMagic: TComboBox
        Left = 72
        Top = 140
        Width = 89
        Height = 20
        Style = csDropDownList
        Ctl3D = False
        DragKind = dkDock
        DropDownCount = 16
        ItemHeight = 12
        ItemIndex = 0
        ParentCtl3D = False
        TabOrder = 17
        Text = #25351#23450#25216#33021
        Items.Strings = (
          #25351#23450#25216#33021
          #25152#26377#25216#33021)
      end
      object ComboBoxLevel: TComboBox
        Left = 72
        Top = 164
        Width = 89
        Height = 20
        Style = csDropDownList
        Ctl3D = False
        DragKind = dkDock
        DropDownCount = 16
        ItemHeight = 12
        ItemIndex = 0
        ParentCtl3D = False
        TabOrder = 22
        Text = #20840#37096#22686#21152
        Items.Strings = (
          #20840#37096#22686#21152
          #20840#37096#20943#23569
          #20840#37096#31561#20110)
      end
      object ComboBoxGold: TComboBox
        Left = 72
        Top = 188
        Width = 89
        Height = 20
        Style = csDropDownList
        Ctl3D = False
        DragKind = dkDock
        DropDownCount = 16
        ItemHeight = 12
        ItemIndex = 0
        ParentCtl3D = False
        TabOrder = 24
        Text = #20840#37096#22686#21152
        Items.Strings = (
          #20840#37096#22686#21152
          #20840#37096#20943#23569
          #20840#37096#31561#20110)
      end
      object ComboBoxPK: TComboBox
        Left = 72
        Top = 212
        Width = 89
        Height = 20
        Style = csDropDownList
        Ctl3D = False
        DragKind = dkDock
        DropDownCount = 16
        ItemHeight = 12
        ItemIndex = 0
        ParentCtl3D = False
        TabOrder = 28
        Text = #20840#37096#22686#21152
        Items.Strings = (
          #20840#37096#22686#21152
          #20840#37096#20943#23569
          #20840#37096#31561#20110)
      end
      object ButtonChgMapXY: TButton
        Left = 382
        Top = 16
        Width = 75
        Height = 25
        Caption = #25191#34892
        TabOrder = 6
        OnClick = ButtonChgMapXYClick
      end
      object ButtonChgHomeMapXY: TButton
        Left = 382
        Top = 40
        Width = 75
        Height = 25
        Caption = #25191#34892
        TabOrder = 7
        OnClick = ButtonChgHomeMapXYClick
      end
      object ButtonChgItemID: TButton
        Left = 382
        Top = 64
        Width = 75
        Height = 25
        Caption = #25191#34892
        TabOrder = 12
        OnClick = ButtonChgItemIDClick
      end
      object ButtonChgMagicID: TButton
        Left = 382
        Top = 88
        Width = 75
        Height = 25
        Caption = #25191#34892
        TabOrder = 13
        OnClick = ButtonChgMagicIDClick
      end
      object ButtonDelItem: TButton
        Left = 270
        Top = 112
        Width = 75
        Height = 25
        Caption = #25191#34892
        TabOrder = 20
        OnClick = ButtonDelItemClick
      end
      object ButtonDelMagic: TButton
        Left = 270
        Top = 136
        Width = 75
        Height = 25
        Caption = #25191#34892
        TabOrder = 21
        OnClick = ButtonDelMagicClick
      end
      object ButtonChgLevel: TButton
        Left = 270
        Top = 160
        Width = 75
        Height = 25
        Caption = #25191#34892
        TabOrder = 26
        OnClick = ButtonChgLevelClick
      end
      object ButtonChgGold: TButton
        Left = 270
        Top = 184
        Width = 75
        Height = 25
        Caption = #25191#34892
        TabOrder = 27
        OnClick = ButtonChgGoldClick
      end
      object ButtonChgPK: TButton
        Left = 270
        Top = 208
        Width = 75
        Height = 25
        Caption = #25191#34892
        TabOrder = 30
        OnClick = ButtonChgPKClick
      end
      object EditMap: TEdit
        Left = 72
        Top = 20
        Width = 81
        Height = 20
        TabOrder = 0
      end
      object EditHomeMap: TEdit
        Left = 72
        Top = 44
        Width = 81
        Height = 20
        TabOrder = 1
      end
      object CheckBoxItemReserve: TCheckBox
        Left = 272
        Top = 70
        Width = 81
        Height = 17
        Caption = #20445#25345#21407#23646#24615
        Checked = True
        State = cbChecked
        TabOrder = 14
      end
      object CheckBoxMagicReserve: TCheckBox
        Left = 272
        Top = 94
        Width = 81
        Height = 17
        Caption = #20445#25345#21407#23646#24615
        Checked = True
        State = cbChecked
        TabOrder = 15
      end
      object EditMapX: TSpinEdit
        Left = 200
        Top = 20
        Width = 65
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 2
        Value = 0
      end
      object EditHomeMapX: TSpinEdit
        Left = 200
        Top = 44
        Width = 65
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object EditMapY: TSpinEdit
        Left = 312
        Top = 20
        Width = 65
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 4
        Value = 0
      end
      object EditHomeMapY: TSpinEdit
        Left = 312
        Top = 44
        Width = 65
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 5
        Value = 0
      end
      object EditItemIDOld: TSpinEdit
        Left = 112
        Top = 68
        Width = 57
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 8
        Value = 0
      end
      object EditMagicIDOld: TSpinEdit
        Left = 112
        Top = 92
        Width = 57
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 9
        Value = 0
      end
      object EditItemIDNew: TSpinEdit
        Left = 200
        Top = 68
        Width = 65
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 10
        Value = 0
      end
      object EditMagicIDNew: TSpinEdit
        Left = 200
        Top = 92
        Width = 65
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 11
        Value = 0
      end
      object EditDelItemID: TSpinEdit
        Left = 200
        Top = 116
        Width = 65
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 18
        Value = 0
      end
      object EditDelMagicID: TSpinEdit
        Left = 200
        Top = 140
        Width = 65
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 19
        Value = 0
      end
      object EditLevel: TSpinEdit
        Left = 168
        Top = 164
        Width = 97
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 23
        Value = 0
      end
      object EditGold: TSpinEdit
        Left = 168
        Top = 188
        Width = 97
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 25
        Value = 0
      end
      object EditPK: TSpinEdit
        Left = 168
        Top = 212
        Width = 97
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 29
        Value = 0
      end
    end
  end
end
