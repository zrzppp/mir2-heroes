object FrmAbout: TFrmAbout
  Left = 751
  Top = 224
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 289
  ClientWidth = 401
  Color = clSilver
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Label2: TLabel
    Left = 8
    Top = 248
    Width = 250
    Height = 37
    Caption = 'www.lomcn.co.uk'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object ButtonOK: TButton
    Left = 318
    Top = 256
    Width = 75
    Height = 25
    Caption = 'OK (&O)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = ButtonOKClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 160
    Width = 385
    Height = 81
    Caption = 'Message'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 40
      Top = 24
      Width = 289
      Height = 32
      Alignment = taCenter
      Caption = 
        'Please thank the members of LOMCN'#13#10'for providing you with an eng' +
        'lish set of these files.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 385
    Height = 145
    Caption = 'About'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label3: TLabel
      Left = 8
      Top = 16
      Width = 40
      Height = 13
      Caption = 'Product:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 8
      Top = 36
      Width = 38
      Height = 13
      Caption = 'Version:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 8
      Top = 56
      Width = 23
      Height = 13
      Caption = 'Built:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 8
      Top = 76
      Width = 42
      Height = 13
      Caption = 'Program:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 8
      Top = 96
      Width = 21
      Height = 13
      Caption = 'Site:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 8
      Top = 116
      Width = 32
      Height = 13
      Caption = 'Forum:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EditProductName: TEdit
      Left = 64
      Top = 16
      Width = 313
      Height = 20
      BorderStyle = bsNone
      Color = clSilver
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = 'EditProductName'
    end
    object EditVersion: TEdit
      Left = 64
      Top = 36
      Width = 313
      Height = 20
      BorderStyle = bsNone
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = 'EditVersion'
    end
    object EditUpDateTime: TEdit
      Left = 64
      Top = 56
      Width = 313
      Height = 20
      BorderStyle = bsNone
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      Text = 'EditUpDateTime'
    end
    object EditProgram: TEdit
      Left = 64
      Top = 76
      Width = 313
      Height = 20
      BorderStyle = bsNone
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      Text = 'EditProgram'
    end
    object EditWebSite: TEdit
      Left = 64
      Top = 96
      Width = 313
      Height = 20
      BorderStyle = bsNone
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      Text = 'EditWebSite'
    end
    object EditBbsSite: TEdit
      Left = 64
      Top = 116
      Width = 313
      Height = 20
      BorderStyle = bsNone
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
      Text = 'EditBbsSite'
    end
  end
end
