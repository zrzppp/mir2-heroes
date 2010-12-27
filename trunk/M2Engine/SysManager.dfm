object frmSysManager: TfrmSysManager
  Left = 846
  Top = 175
  Width = 663
  Height = 418
  Caption = #31995#32479#31649#29702
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
    Width = 655
    Height = 384
    Align = alClient
    TabOrder = 0
    object ListView: TListView
      Left = 1
      Top = 1
      Width = 653
      Height = 363
      Align = alClient
      Columns = <
        item
          Caption = #25991#20214#21517#31216
          Width = 120
        end
        item
          Caption = #22320#22270#21517#31216
          Width = 120
        end
        item
          Caption = #20154#29289
          Width = 60
        end
        item
          Caption = #33521#38596
          Width = 60
        end
        item
          Caption = #24618#29289
          Width = 60
        end
        item
          Caption = 'NPC'
          Width = 60
        end
        item
          Caption = #29289#21697
          Width = 60
        end
        item
          Caption = #21047#24618
          Width = 40
        end
        item
          Caption = #31359#20154
          Width = 40
        end
        item
          Caption = #31359#24618
          Width = 40
        end
        item
          Caption = #39569#39532
          Width = 40
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      PopupMenu = PopupMenu
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = ListViewClick
    end
    object StatusBar: TStatusBar
      Left = 1
      Top = 364
      Width = 653
      Height = 19
      Panels = <
        item
          Width = 100
        end
        item
          Width = 100
        end
        item
          Width = 100
        end
        item
          Width = 100
        end
        item
          Width = 100
        end
        item
          Width = 50
        end>
    end
  end
  object PopupMenu: TPopupMenu
    Left = 224
    Top = 160
    object PopupMenu_Ref: TMenuItem
      Caption = #21047#26032'(&R)'
      OnClick = PopupMenu_RefClick
    end
    object PopupMenu_AutoRef: TMenuItem
      Caption = #33258#21160#21047#26032'(&A)'
      OnClick = PopupMenu_AutoRefClick
    end
    object PopupMenu__: TMenuItem
      Caption = '-'
    end
    object PopupMenu_MonGen: TMenuItem
      Caption = #20801#35768#21047#24618
      OnClick = PopupMenu_MonGenClick
    end
    object PopupMenu_RunHum: TMenuItem
      Caption = #20801#35768#31359#20154
      OnClick = PopupMenu_MonGenClick
    end
    object PopupMenu_RunMon: TMenuItem
      Caption = #20801#35768#31359#24618
      OnClick = PopupMenu_MonGenClick
    end
    object PopupMenu_Horser: TMenuItem
      Caption = #20801#35768#39569#39532
      OnClick = PopupMenu_MonGenClick
    end
    object PopupMenu_: TMenuItem
      Caption = '-'
    end
    object PopupMenu_ShowHum: TMenuItem
      Caption = #26597#30475#20154#29289'(&H)'
      OnClick = PopupMenu_ShowHumClick
    end
    object PopupMenu_ShowMon: TMenuItem
      Caption = #26597#30475#24618#29289'(&M)'
      OnClick = PopupMenu_ShowMonClick
    end
    object PopupMenu_ShowNpc: TMenuItem
      Caption = #26597#30475'NPC(&N)'
      OnClick = PopupMenu_ShowNpcClick
    end
    object PopupMenu_ShowItem: TMenuItem
      Caption = #26597#30475#29289#21697'(&I)'
      Enabled = False
      OnClick = PopupMenu_ShowItemClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object PopupMenu_ClearMon: TMenuItem
      Caption = #28165#38500#25152#26377#24618#29289
      OnClick = PopupMenu_ClearMonClick
    end
    object PopupMenu_ClearItem: TMenuItem
      Caption = #28165#38500#25152#26377#29289#21697
      Enabled = False
    end
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 192
    Top = 160
  end
end
