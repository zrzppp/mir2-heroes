object frmConfigItem: TfrmConfigItem
  Left = 641
  Top = 246
  Width = 1090
  Height = 390
  Caption = 'frmConfigItem'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PanelStatus: TPanel
    Left = 0
    Top = 0
    Width = 1082
    Height = 356
    Align = alClient
    TabOrder = 0
    object ListView: TListView
      Left = 1
      Top = 1
      Width = 1080
      Height = 354
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
          Caption = #31995#21015#21495
          Width = 80
        end
        item
          Caption = #25345#20037
          Width = 60
        end
        item
          Caption = #25915#20987
          Width = 60
        end
        item
          Caption = #39764#27861
          Width = 60
        end
        item
          Caption = #36947#26415
          Width = 60
        end
        item
          Caption = #38450#24481
          Width = 60
        end
        item
          Caption = #39764#38450
          Width = 60
        end
        item
          Caption = #38468#21152#23646#24615
          Width = 150
        end
        item
          Caption = #20803#32032
          Width = 150
        end
        item
          Caption = #26399#38480
          Width = 100
        end>
      GridLines = True
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      PopupMenu = PopupMenu
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object Timer: TTimer
    Enabled = False
    Left = 312
    Top = 160
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
    object PopupMenu_Clear: TMenuItem
      Caption = #28165#38500#36873#25321'(&K)'
      OnClick = PopupMenu_ClearClick
    end
    object PopupMenu_ClearAll: TMenuItem
      Caption = #28165#38500#25152#26377'(&C)'
      OnClick = PopupMenu_ClearAllClick
    end
  end
end
