object frmConfigMerchant: TfrmConfigMerchant
  Left = 458
  Top = 338
  Width = 680
  Height = 336
  Caption = 'frmConfigMerchant'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object PanelStatus: TPanel
    Left = 0
    Top = 0
    Width = 672
    Height = 302
    Align = alClient
    TabOrder = 0
    object ListView: TListView
      Left = 1
      Top = 1
      Width = 670
      Height = 300
      Align = alClient
      Columns = <
        item
          Caption = #24207#21495
        end
        item
          Caption = #21517#31216
          Width = 100
        end
        item
          Caption = #22352#26631
          Width = 80
        end
        item
          Caption = #20132#26131'NPC'
          Width = 60
        end
        item
          Caption = #31649#29702'NPC'
          Width = 60
        end
        item
          Caption = #38544#34255
        end
        item
          Caption = #20449#24687
          Width = 200
        end>
      GridLines = True
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      PopupMenu = PopupMenu
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = ListViewClick
      OnDblClick = ListViewDblClick
    end
  end
  object PopupMenu: TPopupMenu
    Left = 344
    Top = 160
    object PopupMenu_Ref: TMenuItem
      Caption = #21047#26032'(&R)'
      OnClick = PopupMenu_RefClick
    end
    object PopupMenu_AutoRef: TMenuItem
      Caption = #33258#21160#21047#26032'(&A)'
      Enabled = False
    end
    object PopupMenu_: TMenuItem
      Caption = '-'
    end
    object PopupMenu_Load: TMenuItem
      Caption = #37325#26032#21152#36733'(&K)'
      OnClick = PopupMenu_LoadClick
    end
    object PopupMenu_Clear: TMenuItem
      Caption = #28165#38500#25968#25454'(&C)'
      OnClick = PopupMenu_ClearClick
    end
    object PopupMenu_Open: TMenuItem
      Caption = #25171#24320#33050#26412'(&O)'
      OnClick = PopupMenu_OpenClick
    end
  end
end
