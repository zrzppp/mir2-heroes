object frmHumManage: TfrmHumManage
  Left = 0
  Top = 0
  Width = 746
  Height = 482
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object RzSizePanel1: TRzSizePanel
    Left = 0
    Top = 244
    Width = 746
    Height = 238
    Align = alBottom
    Color = clMoneyGreen
    SizeBarWidth = 7
    TabOrder = 1
    object RzPanel1: TPanel
      Left = 0
      Top = 8
      Width = 746
      Height = 230
      Align = alClient
      TabOrder = 0
      object GroupBoxHumData: TRzGroupBox
        Left = 1
        Top = 1
        Width = 744
        Height = 228
        Align = alClient
        Alignment = taCenter
        Caption = #20154#29289#25968#25454
        GroupStyle = gsBanner
        TabOrder = 0
        object PageControl: TPageControl
          Left = 0
          Top = 20
          Width = 744
          Height = 208
          ActivePage = TabSheet1
          Align = alClient
          TabOrder = 0
          object TabSheet1: TTabSheet
            Caption = #22522#26412#20449#24687
            ImageIndex = 6
            object RzLabel18: TLabel
              Left = 232
              Top = 137
              Width = 30
              Height = 12
              Caption = #37197#20598':'
              Transparent = True
            end
            object RzLabel17: TLabel
              Left = 8
              Top = 17
              Width = 30
              Height = 12
              Caption = #22320#22270':'
              Transparent = True
            end
            object RzLabel16: TLabel
              Left = 232
              Top = 113
              Width = 18
              Height = 12
              Caption = 'PK:'
              Transparent = True
            end
            object RzLabel20: TLabel
              Left = 232
              Top = 89
              Width = 42
              Height = 12
              Caption = 'MaxExp:'
              Transparent = True
            end
            object RzLabel2: TLabel
              Left = 8
              Top = 65
              Width = 12
              Height = 12
              Caption = 'Y:'
              Transparent = True
            end
            object RzLabel19: TLabel
              Left = 232
              Top = 65
              Width = 24
              Height = 12
              Caption = 'Exp:'
              Transparent = True
            end
            object RzLabel15: TLabel
              Left = 232
              Top = 41
              Width = 36
              Height = 12
              Caption = 'MaxMP:'
              Transparent = True
            end
            object RzLabel11: TLabel
              Left = 120
              Top = 113
              Width = 30
              Height = 12
              Caption = #31561#32423':'
              Transparent = True
            end
            object RzLabel10: TLabel
              Left = 120
              Top = 89
              Width = 36
              Height = 12
              Caption = 'HomeY:'
              Transparent = True
            end
            object RzLabel1: TLabel
              Left = 8
              Top = 41
              Width = 12
              Height = 12
              Caption = 'X:'
              Transparent = True
            end
            object RzLabel14: TLabel
              Left = 232
              Top = 17
              Width = 18
              Height = 12
              Caption = 'MP:'
              Transparent = True
            end
            object RzLabel13: TLabel
              Left = 120
              Top = 161
              Width = 36
              Height = 12
              Caption = 'MaxHP:'
              Transparent = True
            end
            object RzLabel12: TLabel
              Left = 120
              Top = 137
              Width = 18
              Height = 12
              Caption = 'HP:'
              Transparent = True
            end
            object RzLabel8: TLabel
              Left = 120
              Top = 41
              Width = 30
              Height = 12
              Caption = 'Home:'
              Transparent = True
            end
            object RzLabel7: TLabel
              Left = 120
              Top = 17
              Width = 30
              Height = 12
              Caption = #37329#24065':'
              Transparent = True
            end
            object RzLabel6: TLabel
              Left = 8
              Top = 161
              Width = 30
              Height = 12
              Caption = #22836#21457':'
              Transparent = True
            end
            object RzLabel9: TLabel
              Left = 120
              Top = 65
              Width = 36
              Height = 12
              Caption = 'HomeX:'
              Transparent = True
            end
            object RzLabel5: TLabel
              Left = 8
              Top = 137
              Width = 30
              Height = 12
              Caption = #24615#21035':'
              Transparent = True
            end
            object RzLabel23: TLabel
              Left = 360
              Top = 41
              Width = 42
              Height = 12
              Caption = #22768#26395#28857':'
              Transparent = True
            end
            object RzLabel22: TLabel
              Left = 360
              Top = 17
              Width = 54
              Height = 12
              Caption = #20179#24211#23494#30721':'
              Transparent = True
            end
            object RzLabel21: TLabel
              Left = 232
              Top = 161
              Width = 30
              Height = 12
              Caption = #24072#24466':'
              Transparent = True
            end
            object RzLabel4: TLabel
              Left = 8
              Top = 113
              Width = 30
              Height = 12
              Caption = #32844#19994':'
              Transparent = True
            end
            object RzLabel3: TLabel
              Left = 8
              Top = 89
              Width = 30
              Height = 12
              Caption = #26041#21521':'
              Transparent = True
            end
            object RzLabel24: TLabel
              Left = 360
              Top = 113
              Width = 54
              Height = 12
              Caption = #33521#38596#21517#31216':'
              Transparent = True
            end
            object EditHair: TEdit
              Left = 48
              Top = 156
              Width = 57
              Height = 20
              TabOrder = 0
              OnChange = EditMapChange
            end
            object EditGold: TEdit
              Left = 160
              Top = 12
              Width = 57
              Height = 20
              TabOrder = 1
              OnChange = EditMapChange
            end
            object EditExp: TEdit
              Left = 288
              Top = 60
              Width = 57
              Height = 20
              TabOrder = 2
              OnChange = EditMapChange
            end
            object EditHomeX: TEdit
              Left = 160
              Top = 60
              Width = 57
              Height = 20
              TabOrder = 3
              OnChange = EditMapChange
            end
            object EditHomeMap: TEdit
              Left = 160
              Top = 36
              Width = 57
              Height = 20
              TabOrder = 4
              OnChange = EditMapChange
            end
            object EditHeroName: TEdit
              Left = 408
              Top = 108
              Width = 89
              Height = 20
              Color = clInfoBk
              ReadOnly = True
              TabOrder = 5
            end
            object EditDir: TEdit
              Left = 48
              Top = 84
              Width = 57
              Height = 20
              TabOrder = 6
              OnChange = EditMapChange
            end
            object EditCreditPoint: TEdit
              Left = 408
              Top = 36
              Width = 57
              Height = 20
              TabOrder = 7
              OnChange = EditMapChange
            end
            object EditDearName: TEdit
              Left = 288
              Top = 132
              Width = 97
              Height = 20
              TabOrder = 10
              OnChange = EditMapChange
            end
            object EditCurY: TEdit
              Left = 48
              Top = 60
              Width = 57
              Height = 20
              TabOrder = 11
              OnChange = EditMapChange
            end
            object EditCurX: TEdit
              Left = 48
              Top = 36
              Width = 57
              Height = 20
              TabOrder = 12
              OnChange = EditMapChange
            end
            object EditMP: TEdit
              Left = 288
              Top = 12
              Width = 57
              Height = 20
              TabOrder = 13
              OnChange = EditMapChange
            end
            object EditMaxMP: TEdit
              Left = 288
              Top = 36
              Width = 57
              Height = 20
              Color = clInfoBk
              ReadOnly = True
              TabOrder = 14
            end
            object EditMaxHP: TEdit
              Left = 160
              Top = 156
              Width = 57
              Height = 20
              Color = clInfoBk
              ReadOnly = True
              TabOrder = 15
            end
            object EditStoragePwd: TEdit
              Left = 408
              Top = 12
              Width = 57
              Height = 20
              MaxLength = 7
              TabOrder = 16
              OnChange = EditMapChange
            end
            object EditSex: TEdit
              Left = 48
              Top = 132
              Width = 57
              Height = 20
              TabOrder = 17
              OnChange = EditMapChange
            end
            object EditPKPoint: TEdit
              Left = 288
              Top = 108
              Width = 57
              Height = 20
              TabOrder = 18
              OnChange = EditMapChange
            end
            object EditMaxExp: TEdit
              Left = 288
              Top = 84
              Width = 57
              Height = 20
              Color = clInfoBk
              ReadOnly = True
              TabOrder = 19
            end
            object EditJob: TEdit
              Left = 48
              Top = 108
              Width = 57
              Height = 20
              TabOrder = 20
              OnChange = EditMapChange
            end
            object EditHP: TEdit
              Left = 160
              Top = 132
              Width = 57
              Height = 20
              TabOrder = 21
              OnChange = EditMapChange
            end
            object EditHomeY: TEdit
              Left = 160
              Top = 84
              Width = 57
              Height = 20
              TabOrder = 22
              OnChange = EditMapChange
            end
            object EditMasterName: TEdit
              Left = 288
              Top = 156
              Width = 97
              Height = 20
              TabOrder = 23
              OnChange = EditMapChange
            end
            object EditMap: TEdit
              Left = 48
              Top = 12
              Width = 57
              Height = 20
              TabOrder = 24
              OnChange = EditMapChange
            end
            object EditLevel: TEdit
              Left = 160
              Top = 108
              Width = 57
              Height = 20
              TabOrder = 25
              OnChange = EditMapChange
            end
            object ButtonOK: TRzButton
              Left = 496
              Top = 128
              FrameColor = 7617536
              Caption = #20445#23384#20462#25913
              HotTrack = True
              TabOrder = 26
              OnClick = ButtonOKClick
            end
            object ButtonDelCharName: TRzButton
              Left = 576
              Top = 128
              FrameColor = 7617536
              Caption = #21024#38500#20154#29289
              HotTrack = True
              TabOrder = 27
              OnClick = ButtonDelCharNameClick
            end
            object CheckBoxIsHero: TCheckBox
              Left = 360
              Top = 64
              Width = 81
              Height = 17
              Caption = #26159#21542#26159#33521#38596
              Enabled = False
              TabOrder = 8
            end
            object CheckBoxHasHero: TCheckBox
              Left = 360
              Top = 88
              Width = 81
              Height = 17
              Caption = #26159#21542#26377#33521#38596
              Enabled = False
              TabOrder = 9
            end
            object ButtonDelHeroRec: TRzButton
              Left = 656
              Top = 128
              FrameColor = 7617536
              Caption = #21024#38500#33521#38596
              HotTrack = True
              TabOrder = 28
              OnClick = ButtonDelCharNameClick
            end
            object ButtonDelCharHeroRec: TRzButton
              Left = 576
              Top = 156
              Width = 153
              FrameColor = 7617536
              Caption = #21024#38500#20154#29289#30340#33521#38596
              HotTrack = True
              TabOrder = 29
              OnClick = ButtonDelCharHeroRecClick
            end
          end
          object TabSheet2: TTabSheet
            Caption = #35013#22791#20449#24687
            ImageIndex = 6
            object GridUserItem: TStringGrid
              Left = 0
              Top = 0
              Width = 736
              Height = 181
              Align = alClient
              ColCount = 10
              DefaultColWidth = 60
              DefaultRowHeight = 18
              RowCount = 14
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
              PopupMenu = PopupMenu_GridUserItem
              TabOrder = 0
            end
          end
          object TabSheet3: TTabSheet
            Caption = #32972#21253#29289#21697
            ImageIndex = 2
            object ListViewBagItem: TListView
              Left = 0
              Top = 0
              Width = 736
              Height = 181
              Align = alClient
              Columns = <
                item
                  Caption = #24207#21495
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
                  Width = 141
                end>
              GridLines = True
              MultiSelect = True
              RowSelect = True
              PopupMenu = PopupMenu_ListViewBigStorageItem
              TabOrder = 0
              ViewStyle = vsReport
            end
          end
          object TabSheet4: TTabSheet
            Caption = #20179#24211#29289#21697
            ImageIndex = 3
            object ListViewStorageItem: TListView
              Left = 0
              Top = 0
              Width = 736
              Height = 181
              Align = alClient
              Columns = <
                item
                  Caption = #24207#21495
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
                  Width = 141
                end>
              GridLines = True
              MultiSelect = True
              RowSelect = True
              PopupMenu = PopupMenu_ListViewStorageItem
              TabOrder = 0
              ViewStyle = vsReport
            end
          end
          object TabSheet5: TTabSheet
            Caption = #32451#20064#25216#33021
            ImageIndex = 4
            object ListViewMagic: TListView
              Left = 0
              Top = 0
              Width = 736
              Height = 181
              Align = alClient
              Columns = <
                item
                  Caption = #24207#21495
                end
                item
                  Caption = #25216#33021#21517#31216
                  Width = 100
                end
                item
                  Caption = #25216#33021'ID'
                  Width = 80
                end
                item
                  Caption = #31561#32423
                end
                item
                  Caption = #24555#25463#38190
                  Width = 60
                end
                item
                  Caption = #20462#32451#29366#24577
                  Width = 331
                end>
              GridLines = True
              MultiSelect = True
              RowSelect = True
              PopupMenu = PopupMenu_ListViewMagic
              TabOrder = 0
              ViewStyle = vsReport
            end
          end
          object TabSheet6: TTabSheet
            Caption = #26080#38480#20179#24211
            ImageIndex = 5
            object ListViewBigStorageItem: TListView
              Left = 0
              Top = 0
              Width = 736
              Height = 181
              Align = alClient
              Columns = <
                item
                  Caption = #24207#21495
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
                  Width = 141
                end>
              GridLines = True
              MultiSelect = True
              RowSelect = True
              PopupMenu = PopupMenu_ListViewBigStorageItem
              TabOrder = 0
              ViewStyle = vsReport
            end
          end
          object TabSheet7: TTabSheet
            Caption = #25293#21334#29289#21697
            ImageIndex = 6
            object ListViewSellItem: TListView
              Left = 0
              Top = 0
              Width = 736
              Height = 181
              Align = alClient
              Columns = <
                item
                  Caption = #24207#21495
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
                  Width = 141
                end>
              GridLines = True
              MultiSelect = True
              RowSelect = True
              PopupMenu = PopupMenu_ListViewSellItem
              TabOrder = 0
              ViewStyle = vsReport
            end
          end
        end
      end
    end
  end
  object PanelActCharSearch: TPanel
    Left = 0
    Top = 0
    Width = 746
    Height = 89
    Align = alTop
    TabOrder = 0
    object ButtonPrecisionSearchAccount: TRzToolbarButton
      Left = 200
      Top = 36
      Width = 81
      Height = 22
      Hint = 'Find'
      Caption = #31934#30830#26597#25214
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000730E0000730E00000001000000010000000000003300
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
        E8B4D8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E281E8E8E8E8E8E8E8E8E8E8E8E8E8
        B46C6CD8E8E8E8E8E8E8E8E8E8E8E8E8E2818181E8E8E8E8E8E8E8E8E8E8E8E8
        B46CD86CD8E8E8E8E8E8E8E8E8E8E8E8E281818181E8E8E8E8E8E8E8E8E8E8E8
        B46C6CD86CD8E8E8E8E8E8E8E8E8E8E8E28181818181E8E8E8E8E8E8E8E8E8D7
        5E6C6C6CB46CD8E8E8E8E8E8E8E8E8D781818181E28181E8E8E8E8E8E8E8E8D7
        89896CB4B4B46CD8E8E8E8E8E8E8E8D7ACAC81E2E2E28181E8E8E8E8E8E8D789
        89D7D7B4C7C7C76CE8E8E8E8E8E8D7ACACD7D7E2ACACAC81E8E8E8E8E8D78989
        D7D7D7D76C6C6CE8E8E8E8E8E8D7ACACD7D7D7D7818181E8E8E8E8E8D78989D7
        D7D75E5EE8E8E8E8E8E8E8E8D7ACACD7D7D78181E8E8E8E8E8E8E8D78989D7D7
        D75EE8E8E8E8E8E8E8E8E8D7ACACD7D7D781E8E8E8E8E8E8E8E8D78989D7D7D7
        5EB4E8E8E8E8E8E8E8E8D7ACACD7D7D781E2E8E8E8E8E8E8E8E85E89D7D7D75E
        B4E8E8E8E8E8E8E8E8E881ACD7D7D781E2E8E8E8E8E8E8E8E8E8E85ED7D75EE8
        E8E8E8E8E8E8E8E8E8E8E881D7D781E8E8E8E8E8E8E8E8E8E8E8E8E85E5EE8E8
        E8E8E8E8E8E8E8E8E8E8E8E88181E8E8E8E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
      OnClick = ButtonPrecisionSearchAccountClick
      HotNumGlyphs = 0
    end
    object ButtonMistySearchAccount: TRzToolbarButton
      Left = 288
      Top = 36
      Width = 81
      Height = 22
      Hint = 'Find'
      Caption = #27169#31946#26597#25214
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000730E0000730E00000001000000010000000000003300
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
        E8B4D8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E281E8E8E8E8E8E8E8E8E8E8E8E8E8
        B46C6CD8E8E8E8E8E8E8E8E8E8E8E8E8E2818181E8E8E8E8E8E8E8E8E8E8E8E8
        B46CD86CD8E8E8E8E8E8E8E8E8E8E8E8E281818181E8E8E8E8E8E8E8E8E8E8E8
        B46C6CD86CD8E8E8E8E8E8E8E8E8E8E8E28181818181E8E8E8E8E8E8E8E8E8D7
        5E6C6C6CB46CD8E8E8E8E8E8E8E8E8D781818181E28181E8E8E8E8E8E8E8E8D7
        89896CB4B4B46CD8E8E8E8E8E8E8E8D7ACAC81E2E2E28181E8E8E8E8E8E8D789
        89D7D7B4C7C7C76CE8E8E8E8E8E8D7ACACD7D7E2ACACAC81E8E8E8E8E8D78989
        D7D7D7D76C6C6CE8E8E8E8E8E8D7ACACD7D7D7D7818181E8E8E8E8E8D78989D7
        D7D75E5EE8E8E8E8E8E8E8E8D7ACACD7D7D78181E8E8E8E8E8E8E8D78989D7D7
        D75EE8E8E8E8E8E8E8E8E8D7ACACD7D7D781E8E8E8E8E8E8E8E8D78989D7D7D7
        5EB4E8E8E8E8E8E8E8E8D7ACACD7D7D781E2E8E8E8E8E8E8E8E85E89D7D7D75E
        B4E8E8E8E8E8E8E8E8E881ACD7D7D781E2E8E8E8E8E8E8E8E8E8E85ED7D75EE8
        E8E8E8E8E8E8E8E8E8E8E881D7D781E8E8E8E8E8E8E8E8E8E8E8E8E85E5EE8E8
        E8E8E8E8E8E8E8E8E8E8E8E88181E8E8E8E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
      OnClick = ButtonMistySearchAccountClick
      HotNumGlyphs = 0
    end
    object ButtonPrecisionSearchCharName: TRzToolbarButton
      Left = 200
      Top = 60
      Width = 81
      Height = 22
      Hint = 'Find'
      Caption = #31934#30830#26597#25214
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000730E0000730E00000001000000010000000000003300
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
        E8B4D8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E281E8E8E8E8E8E8E8E8E8E8E8E8E8
        B46C6CD8E8E8E8E8E8E8E8E8E8E8E8E8E2818181E8E8E8E8E8E8E8E8E8E8E8E8
        B46CD86CD8E8E8E8E8E8E8E8E8E8E8E8E281818181E8E8E8E8E8E8E8E8E8E8E8
        B46C6CD86CD8E8E8E8E8E8E8E8E8E8E8E28181818181E8E8E8E8E8E8E8E8E8D7
        5E6C6C6CB46CD8E8E8E8E8E8E8E8E8D781818181E28181E8E8E8E8E8E8E8E8D7
        89896CB4B4B46CD8E8E8E8E8E8E8E8D7ACAC81E2E2E28181E8E8E8E8E8E8D789
        89D7D7B4C7C7C76CE8E8E8E8E8E8D7ACACD7D7E2ACACAC81E8E8E8E8E8D78989
        D7D7D7D76C6C6CE8E8E8E8E8E8D7ACACD7D7D7D7818181E8E8E8E8E8D78989D7
        D7D75E5EE8E8E8E8E8E8E8E8D7ACACD7D7D78181E8E8E8E8E8E8E8D78989D7D7
        D75EE8E8E8E8E8E8E8E8E8D7ACACD7D7D781E8E8E8E8E8E8E8E8D78989D7D7D7
        5EB4E8E8E8E8E8E8E8E8D7ACACD7D7D781E2E8E8E8E8E8E8E8E85E89D7D7D75E
        B4E8E8E8E8E8E8E8E8E881ACD7D7D781E2E8E8E8E8E8E8E8E8E8E85ED7D75EE8
        E8E8E8E8E8E8E8E8E8E8E881D7D781E8E8E8E8E8E8E8E8E8E8E8E8E85E5EE8E8
        E8E8E8E8E8E8E8E8E8E8E8E88181E8E8E8E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
      OnClick = ButtonPrecisionSearchCharNameClick
      HotNumGlyphs = 0
    end
    object ButtonMistySearchCharName: TRzToolbarButton
      Left = 288
      Top = 60
      Width = 81
      Height = 22
      Hint = 'Find'
      Caption = #27169#31946#26597#25214
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000730E0000730E00000001000000010000000000003300
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
        E8B4D8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E281E8E8E8E8E8E8E8E8E8E8E8E8E8
        B46C6CD8E8E8E8E8E8E8E8E8E8E8E8E8E2818181E8E8E8E8E8E8E8E8E8E8E8E8
        B46CD86CD8E8E8E8E8E8E8E8E8E8E8E8E281818181E8E8E8E8E8E8E8E8E8E8E8
        B46C6CD86CD8E8E8E8E8E8E8E8E8E8E8E28181818181E8E8E8E8E8E8E8E8E8D7
        5E6C6C6CB46CD8E8E8E8E8E8E8E8E8D781818181E28181E8E8E8E8E8E8E8E8D7
        89896CB4B4B46CD8E8E8E8E8E8E8E8D7ACAC81E2E2E28181E8E8E8E8E8E8D789
        89D7D7B4C7C7C76CE8E8E8E8E8E8D7ACACD7D7E2ACACAC81E8E8E8E8E8D78989
        D7D7D7D76C6C6CE8E8E8E8E8E8D7ACACD7D7D7D7818181E8E8E8E8E8D78989D7
        D7D75E5EE8E8E8E8E8E8E8E8D7ACACD7D7D78181E8E8E8E8E8E8E8D78989D7D7
        D75EE8E8E8E8E8E8E8E8E8D7ACACD7D7D781E8E8E8E8E8E8E8E8D78989D7D7D7
        5EB4E8E8E8E8E8E8E8E8D7ACACD7D7D781E2E8E8E8E8E8E8E8E85E89D7D7D75E
        B4E8E8E8E8E8E8E8E8E881ACD7D7D781E2E8E8E8E8E8E8E8E8E8E85ED7D75EE8
        E8E8E8E8E8E8E8E8E8E8E881D7D781E8E8E8E8E8E8E8E8E8E8E8E8E85E5EE8E8
        E8E8E8E8E8E8E8E8E8E8E8E88181E8E8E8E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
      OnClick = ButtonMistySearchCharNameClick
      HotNumGlyphs = 0
    end
    object Label1: TLabel
      Left = 376
      Top = 68
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
    object RzLabel26: TLabel
      Left = 16
      Top = 16
      Width = 36
      Height = 12
      Caption = #27880#20876'ID'
      Transparent = True
    end
    object RzLabel27: TLabel
      Left = 16
      Top = 40
      Width = 36
      Height = 12
      Caption = #26597#25214'ID'
      Transparent = True
    end
    object RzLabel28: TLabel
      Left = 232
      Top = 16
      Width = 36
      Height = 12
      Caption = #35282#33394#21517
      Transparent = True
    end
    object RzLabel29: TLabel
      Left = 440
      Top = 16
      Width = 36
      Height = 12
      Caption = #33521#38596#21517
      Transparent = True
    end
    object RzLabel30: TLabel
      Left = 16
      Top = 64
      Width = 48
      Height = 12
      Caption = #26597#25214#35282#33394
      Transparent = True
    end
    object ComboBoxAccount: TComboBox
      Left = 72
      Top = 12
      Width = 145
      Height = 20
      Style = csDropDownList
      Ctl3D = False
      DragKind = dkDock
      DropDownCount = 16
      ItemHeight = 12
      ParentCtl3D = False
      TabOrder = 0
      OnSelect = ComboBoxAccountSelect
    end
    object ComboBoxCharName: TComboBox
      Left = 280
      Top = 12
      Width = 145
      Height = 20
      Style = csDropDownList
      Ctl3D = False
      DropDownCount = 16
      ItemHeight = 12
      ParentCtl3D = False
      TabOrder = 1
      OnSelect = ComboBoxCharNameSelect
    end
    object ComboBoxHeroName: TComboBox
      Left = 482
      Top = 12
      Width = 145
      Height = 20
      Style = csDropDownList
      Ctl3D = False
      ItemHeight = 12
      ParentCtl3D = False
      TabOrder = 3
      OnSelect = ComboBoxHeroNameSelect
    end
    object EditAccount: TEdit
      Left = 72
      Top = 36
      Width = 121
      Height = 20
      TabOrder = 2
    end
    object EditCharName: TEdit
      Left = 72
      Top = 60
      Width = 121
      Height = 20
      TabOrder = 4
    end
  end
  object RzPanel2: TPanel
    Left = 0
    Top = 89
    Width = 746
    Height = 155
    Align = alClient
    TabOrder = 2
    object GroupBoxHumList: TRzGroupBox
      Left = 1
      Top = 1
      Width = 744
      Height = 153
      Align = alClient
      Alignment = taCenter
      Caption = #20154#29289#21015#34920
      GroupStyle = gsBanner
      TabOrder = 0
      object ListView: TListView
        Left = 0
        Top = 20
        Width = 744
        Height = 133
        Align = alClient
        Columns = <
          item
            Caption = #30331#24405#24080#21495
            Width = 60
          end
          item
            Caption = #21517#31216
            Width = 60
          end
          item
            Caption = #22320#22270
          end
          item
            Caption = 'X'
            Width = 30
          end
          item
            Caption = 'Y'
            Width = 30
          end
          item
            Caption = #26041#21521
            Width = 40
          end
          item
            Caption = #32844#19994
            Width = 40
          end
          item
            Caption = #24615#21035
            Width = 40
          end
          item
            Caption = #22836#21457
            Width = 40
          end
          item
            Caption = #37329#24065#25968
          end
          item
            Caption = 'Home'
          end
          item
            Caption = 'HomeX'
          end
          item
            Caption = 'HomeY'
          end
          item
            Caption = #31561#32423
            Width = 40
          end
          item
            Caption = 'HP'
            Width = 40
          end
          item
            Caption = 'MaxHP'
            Width = 40
          end
          item
            Caption = 'MP'
            Width = 40
          end
          item
            Caption = 'MaxMP'
            Width = 40
          end
          item
            Caption = #24403#21069#32463#39564
            Width = 60
          end
          item
            Caption = #21319#32423#32463#39564
            Width = 60
          end
          item
            Caption = 'PK'#28857#25968
          end
          item
            Caption = #37197#20598
          end
          item
            Caption = #24072#24466
          end
          item
            Caption = #20179#24211#23494#30721
            Width = 60
          end
          item
            Caption = #22768#26395#28857
            Width = 60
          end
          item
            Caption = #26159#33521#38596
            Width = 60
          end
          item
            Caption = #26377#33521#38596
            Width = 60
          end
          item
            Caption = #21024#38500
            Width = 60
          end>
        GridLines = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = ListViewClick
      end
    end
  end
  object PopupMenu_GridUserItem: TPopupMenu
    Left = 88
    Top = 360
    object PopupMenu_GridUserItem_Del: TMenuItem
      Caption = #21024#38500#29289#21697
      OnClick = PopupMenu_GridUserItem_DelClick
    end
    object PopupMenu_GridUserItem_CopyItemName: TMenuItem
      Caption = #22797#21046#29289#21697#21517#31216
      OnClick = PopupMenu_GridUserItem_CopyItemNameClick
    end
  end
  object PopupMenu_ListViewBagItem: TPopupMenu
    Left = 144
    Top = 360
    object PopupMenu_ListViewBagItem_Del: TMenuItem
      Caption = #21024#38500#29289#21697
      OnClick = PopupMenu_ListViewBagItem_DelClick
    end
    object PopupMenu_ListViewBagItem_CopyItemName: TMenuItem
      Caption = #22797#21046#29289#21697#21517#31216
      OnClick = PopupMenu_ListViewBagItem_CopyItemNameClick
    end
  end
  object PopupMenu_ListViewStorageItem: TPopupMenu
    Left = 192
    Top = 360
    object PopupMenu_ListViewStorageItem_Del: TMenuItem
      Caption = #21024#38500#29289#21697
      OnClick = PopupMenu_ListViewStorageItem_DelClick
    end
    object PopupMenu_ListViewStorageItem_CopyItemName: TMenuItem
      Caption = #22797#21046#29289#21697#21517#31216
      OnClick = PopupMenu_ListViewStorageItem_CopyItemNameClick
    end
  end
  object PopupMenu_ListViewMagic: TPopupMenu
    Left = 232
    Top = 360
    object PopupMenu_ListViewMagic_Del: TMenuItem
      Caption = #21024#38500#39764#27861
      OnClick = PopupMenu_ListViewMagic_DelClick
    end
    object PopupMenu_ListViewMagic_CopyItemName: TMenuItem
      Caption = #22797#21046#39764#27861#21517#31216
      OnClick = PopupMenu_ListViewMagic_CopyItemNameClick
    end
  end
  object PopupMenu_ListViewBigStorageItem: TPopupMenu
    Left = 280
    Top = 360
    object PopupMenu_ListViewBigStorageItem_Del: TMenuItem
      Caption = #21024#38500#29289#21697
      OnClick = PopupMenu_ListViewBigStorageItem_DelClick
    end
    object PopupMenu_ListViewBigStorageItem_CopyItemName: TMenuItem
      Caption = #22797#21046#29289#21697#21517#31216
      OnClick = PopupMenu_ListViewBigStorageItem_CopyItemNameClick
    end
  end
  object PopupMenu_ListViewSellItem: TPopupMenu
    Left = 328
    Top = 360
    object PopupMenu_ListViewSellItem_Del: TMenuItem
      Caption = #21024#38500#29289#21697
      OnClick = PopupMenu_ListViewSellItem_DelClick
    end
    object PopupMenu_ListViewSellItem_CopyItemName: TMenuItem
      Caption = #22797#21046#29289#21697#21517#31216
      OnClick = PopupMenu_ListViewSellItem_CopyItemNameClick
    end
  end
end
