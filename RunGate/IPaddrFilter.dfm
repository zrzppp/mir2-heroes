object frmIPaddrFilter: TfrmIPaddrFilter
  Left = 947
  Top = 379
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'IP Filter'
  ClientHeight = 295
  ClientWidth = 390
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 377
    Height = 281
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'IP Blocks'
      object LabelTempList: TLabel
        Left = 8
        Top = 8
        Width = 54
        Height = 12
        Caption = 'Temp Block List:'
      end
      object Label1: TLabel
        Left = 136
        Top = 8
        Width = 54
        Height = 12
        Caption = 'Block List:'
      end
      object ListBoxTempList: TListBox
        Left = 9
        Top = 26
        Width = 121
        Height = 225
        Hint = 'This is a list of temp blocked IPs'
        ItemHeight = 12
        Items.Strings = (
          '888.888.888.888')
        MultiSelect = True
        ParentShowHint = False
        PopupMenu = TempBlockListPopupMenu
        ShowHint = True
        Sorted = True
        TabOrder = 0
        OnKeyDown = ListBoxTempListKeyDown
      end
      object ListBoxBlockList: TListBox
        Left = 136
        Top = 24
        Width = 121
        Height = 225
        Hint = 'This is a list of blocked IPs'
        ItemHeight = 12
        Items.Strings = (
          '888.888.888.888')
        MultiSelect = True
        ParentShowHint = False
        PopupMenu = BlockListPopupMenu
        ShowHint = True
        Sorted = True
        TabOrder = 1
        OnKeyDown = ListBoxBlockListKeyDown
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Client'
      ImageIndex = 1
      object Label2: TLabel
        Left = 8
        Top = 20
        Width = 54
        Height = 12
        Caption = 'Max Ip Con:'
      end
      object Label9: TLabel
        Left = 8
        Top = 44
        Width = 54
        Height = 12
        Caption = 'Client Timeout:'
      end
      object Label7: TLabel
        Left = 241
        Top = 181
        Width = 120
        Height = 12
        Caption = 'LOMCN - Mir Heroes'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object EditMaxConnect: TSpinEdit
        Left = 64
        Top = 16
        Width = 65
        Height = 21
        Hint = 'This is where you edit the maximum connections'
        EditorEnabled = False
        MaxValue = 1000
        MinValue = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Value = 50
        OnChange = EditMaxConnectChange
      end
      object EditClientTimeOutTime: TSpinEdit
        Left = 64
        Top = 40
        Width = 65
        Height = 21
        EditorEnabled = False
        MaxValue = 10
        MinValue = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Value = 5
        OnChange = EditClientTimeOutTimeChange
      end
      object GroupBox4: TGroupBox
        Left = 192
        Top = 8
        Width = 169
        Height = 161
        Caption = 'Client'
        TabOrder = 2
        object Label6: TLabel
          Left = 8
          Top = 44
          Width = 54
          Height = 12
          Caption = 'Max Size:'
        end
        object Label8: TLabel
          Left = 8
          Top = 68
          Width = 54
          Height = 12
          Caption = 'Max Msg:'
        end
        object Label5: TLabel
          Left = 8
          Top = 20
          Width = 54
          Height = 12
          Caption = 'Min Size:'
        end
        object Label11: TLabel
          Left = 8
          Top = 92
          Width = 78
          Height = 12
          Caption = 'Attack:'
        end
        object Label12: TLabel
          Left = 8
          Top = 116
          Width = 78
          Height = 12
          Caption = 'Attack Count:'
        end
        object EditMaxSize: TSpinEdit
          Left = 64
          Top = 40
          Width = 65
          Height = 21
          Hint = 'Maximum client packet size'
          MaxValue = 20000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 6000
          OnChange = EditMaxSizeChange
        end
        object EditMaxClientMsgCount: TSpinEdit
          Left = 64
          Top = 64
          Width = 65
          Height = 21
          Hint = 'Maximum client message count'
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 5
          OnChange = EditMaxClientMsgCountChange
        end
        object CheckBoxLostLine: TCheckBox
          Left = 64
          Top = 136
          Width = 97
          Height = 17
          Hint = 'Auto mimimize on start up'
          BiDiMode = bdLeftToRight
          Caption = 'Minimize'
          ParentBiDiMode = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = CheckBoxLostLineClick
        end
        object EditNomSize: TSpinEdit
          Left = 64
          Top = 16
          Width = 65
          Height = 21
          Hint = 'Minimum client packet size'
          Increment = 10
          MaxValue = 20000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 100
          OnChange = EditNomSizeChange
        end
        object SpinEditAttackTick: TSpinEdit
          Left = 88
          Top = 88
          Width = 65
          Height = 21
          Increment = 10
          MaxValue = 6000
          MinValue = 100
          TabOrder = 4
          Value = 200
          OnChange = SpinEditAttackTickChange
        end
        object SpinEditAttackCount: TSpinEdit
          Left = 88
          Top = 112
          Width = 65
          Height = 21
          MaxValue = 100
          MinValue = 1
          TabOrder = 5
          Value = 10
          OnChange = SpinEditAttackCountChange
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 72
        Width = 169
        Height = 73
        Caption = 'Radio'
        TabOrder = 3
        object RadioAddBlockList: TRadioButton
          Left = 16
          Top = 48
          Width = 129
          Height = 17
          Hint = 'Not sure'
          Caption = 'Add Block'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = RadioAddBlockListClick
        end
        object RadioAddTempList: TRadioButton
          Left = 16
          Top = 32
          Width = 129
          Height = 17
          Caption = 'Add Temp'
          Hint =  'Not sure'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = RadioAddTempListClick
        end
        object RadioDisConnect: TRadioButton
          Left = 16
          Top = 16
          Width = 129
          Height = 17
          Hint = 'Not sure'
          Caption = 'Disconnect'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = RadioDisConnectClick
        end
      end
      object ButtonOK: TButton
        Left = 264
        Top = 208
        Width = 89
        Height = 25
        Caption = 'OK (&O)'
        Default = True
        TabOrder = 4
        OnClick = ButtonOKClick
      end
    end
  end
  object BlockListPopupMenu: TPopupMenu
    OnPopup = BlockListPopupMenuPopup
    Left = 168
    Top = 144
    object BPOPMENU_REFLIST: TMenuItem
      Caption = 'Ref (&R)'
      OnClick = BPOPMENU_REFLISTClick
    end
    object BPOPMENU_SORT: TMenuItem
      Caption = 'Sort(&S)'
      OnClick = BPOPMENU_SORTClick
    end
    object BPOPMENU_ADD: TMenuItem
      Caption = 'Add(&A)'
      OnClick = BPOPMENU_ADDClick
    end
    object BPOPMENU_ADDTEMPLIST: TMenuItem
      Caption = 'Add Temp List(&A)'
      OnClick = BPOPMENU_ADDTEMPLISTClick
    end
    object BPOPMENU_DELETE: TMenuItem
      Caption = 'Delete (&D)'
      OnClick = BPOPMENU_DELETEClick
    end
  end
  object TempBlockListPopupMenu: TPopupMenu
    OnPopup = TempBlockListPopupMenuPopup
    Left = 40
    Top = 144
    object TPOPMENU_REFLIST: TMenuItem
      Caption = 'Ref(&R)'
      OnClick = TPOPMENU_REFLISTClick
    end
    object TPOPMENU_SORT: TMenuItem
      Caption = 'Sort (&S)'
      OnClick = TPOPMENU_SORTClick
    end
    object TPOPMENU_ADD: TMenuItem
      Caption = 'Add (&A)'
      OnClick = TPOPMENU_ADDClick
    end
    object TPOPMENU_BLOCKLIST: TMenuItem
      Caption = 'Block List(&D)'
      OnClick = TPOPMENU_BLOCKLISTClick
    end
    object TPOPMENU_DELETE: TMenuItem
      Caption = 'Delete (&D)'
      OnClick = TPOPMENU_DELETEClick
    end
  end
end
