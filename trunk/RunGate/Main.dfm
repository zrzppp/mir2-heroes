object FrmMain: TFrmMain
  Left = 722
  Top = 263
  Width = 308
  Height = 334
  Caption = 'FrmMain'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object MemoLog: TMemo
    Left = 0
    Top = 81
    Width = 292
    Height = 195
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 0
    OnChange = MemoLogChange
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 0
    Width = 292
    Height = 81
    Align = alTop
    BorderOuter = fsNone
    Color = clSilver
    TabOrder = 1
    object LabelUserInfo: TLabel
      Left = 110
      Top = 40
      Width = 93
      Height = 15
      Caption = 'Connection 0/0/0'
    end
    object LabelRefConsoleMsg: TLabel
      Left = 224
      Top = 60
      Width = 67
      Height = 15
      Caption = '0/0/0/0/0/0/0'
    end
    object LabelCheckServerTime: TLabel
      Left = 10
      Top = 60
      Width = 17
      Height = 15
      Caption = '0/0'
    end
    object LabelMsg: TLabel
      Left = 10
      Top = 40
      Width = 17
      Height = 15
      Caption = '0/0'
    end
    object LabelProcessMsg: TLabel
      Left = 110
      Top = 60
      Width = 37
      Height = 15
      Caption = '0/0/0/0'
    end
    object CheckBoxShowData: TCheckBox
      Left = 10
      Top = 10
      Width = 81
      Height = 21
      Caption = 'Show Data'
      Enabled = False
      TabOrder = 0
    end
  end
  object ServerSocket: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = ServerSocketClientConnect
    OnClientDisconnect = ServerSocketClientDisconnect
    OnClientRead = ServerSocketClientRead
    OnClientError = ServerSocketClientError
    Left = 34
    Top = 80
  end
  object SendTimer: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = SendTimerTimer
    Left = 61
    Top = 80
  end
  object ClientSocket: TClientSocket
    Active = False
    Address = '127.0.0.1'
    ClientType = ctNonBlocking
    Port = 50000
    OnConnect = ClientSocketConnect
    OnDisconnect = ClientSocketDisconnect
    OnRead = ClientSocketRead
    OnError = ClientSocketError
    Left = 10
    Top = 80
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 92
    Top = 80
  end
  object DecodeTimer: TTimer
    Interval = 1
    OnTimer = DecodeTimerTimer
    Left = 154
    Top = 80
  end
  object MainMenu: TMainMenu
    Left = 211
    Top = 80
    object MENU_CONTROL: TMenuItem
      Caption = 'Control &C)'
      object MENU_CONTROL_START: TMenuItem
        Caption = 'Start (&S)'
        OnClick = MENU_CONTROL_STARTClick
      end
      object MENU_CONTROL_STOP: TMenuItem
        Caption = 'Stop (&T)'
        OnClick = MENU_CONTROL_STOPClick
      end
      object MENU_CONTROL_RECONNECT: TMenuItem
        Caption = 'Reconnect (&R)'
        OnClick = MENU_CONTROL_RECONNECTClick
      end
      object MENU_CONTROL_RELOADCONFIG: TMenuItem
        Caption = 'Reload Config(&R)'
        OnClick = MENU_CONTROL_RELOADCONFIGClick
      end
      object MENU_CONTROL_CLEAELOG: TMenuItem
        Caption = 'Clear Log(&C)'
        OnClick = MENU_CONTROL_CLEAELOGClick
      end
      object MENU_CONTROL_EXIT: TMenuItem
        Caption = 'Exit (&E)'
        OnClick = MENU_CONTROL_EXITClick
      end
    end
    object MENU_VIEW: TMenuItem
      Caption = 'View (&V)'
      object MENU_VIEW_LOGMSG: TMenuItem
        Caption = 'Log Message(&L)'
        OnClick = MENU_VIEW_LOGMSGClick
      end
    end
    object MENU_OPTION: TMenuItem
      Caption = 'Options (&O)'
      object MENU_OPTION_GENERAL: TMenuItem
        Caption = 'General (&G)'
        OnClick = MENU_OPTION_GENERALClick
      end
      object MENU_OPTION_PERFORM: TMenuItem
        Caption = 'Perform (&P)'
        OnClick = MENU_OPTION_PERFORMClick
      end
      object MENU_OPTION_FILTERMSG: TMenuItem
        Caption = 'Filter Message (&C)'
        OnClick = MENU_OPTION_FILTERMSGClick
      end
      object MENU_OPTION_IPFILTER: TMenuItem
        Caption = 'IP Filter (&S)'
        OnClick = MENU_OPTION_IPFILTERClick
      end
      object MENU_OPTION_WAIGUA: TMenuItem
        Caption = 'Game Speed (&W)'
        OnClick = MENU_OPTION_WAIGUAClick
      end
    end
    object H1: TMenuItem
      Caption = 'Help (&H)'
      object I1: TMenuItem
        Caption = 'Information (&I)'
        OnClick = I1Click
      end
    end
  end
  object StartTimer: TTimer
    Interval = 200
    OnTimer = StartTimerTimer
    Left = 124
    Top = 80
  end
  object PopupMenu: TPopupMenu
    Left = 184
    Top = 80
    object POPMENU_PORT: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Port'
    end
    object POPMENU_CONNSTAT: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Connection Status'
    end
    object POPMENU_CONNCOUNT: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Connection Count'
    end
    object POPMENU_CHECKTICK: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Check Tick'
    end
    object N1: TMenuItem
      Caption = '--------------------'
    end
    object POPMENU_OPEN: TMenuItem
      Caption = 'Open (&O)'
    end
    object POPMENU_START: TMenuItem
      Caption = 'Start (&S)'
      OnClick = MENU_CONTROL_STARTClick
    end
    object POPMENU_CONNSTOP: TMenuItem
      Caption = 'Stop Connection(&T)'
      OnClick = MENU_CONTROL_STOPClick
    end
    object POPMENU_RECONN: TMenuItem
      Caption = 'Reconnect (&R)'
      OnClick = MENU_CONTROL_RECONNECTClick
    end
    object POPMENU_EXIT: TMenuItem
      Caption = 'Exit (&X)'
      OnClick = MENU_CONTROL_EXITClick
    end
  end
end
