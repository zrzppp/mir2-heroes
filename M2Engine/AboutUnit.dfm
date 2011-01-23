object FrmAbout: TFrmAbout
  Left = 506
  Top = 162
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 339
  ClientWidth = 468
  Color = clSilver
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  object Label2: TLabel
    Left = 9
    Top = 289
    Width = 300
    Height = 48
    Caption = 'www.lomcn.co.uk'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -37
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object ButtonOK: TButton
    Left = 371
    Top = 299
    Width = 88
    Height = 29
    Caption = 'OK (&O)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = ButtonOKClick
  end
  object GroupBox1: TGroupBox
    Left = 9
    Top = 187
    Width = 450
    Height = 94
    Caption = 'Message'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 47
      Top = 28
      Width = 347
      Height = 40
      Alignment = taCenter
      Caption = 
        'Please thank the members of LOMCN'#13#10'for providing you with an eng' +
        'lish set of these files.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object GroupBox2: TGroupBox
    Left = 9
    Top = 9
    Width = 450
    Height = 170
    Caption = 'About'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label3: TLabel
      Left = 9
      Top = 19
      Width = 40
      Height = 13
      Caption = 'Product:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 9
      Top = 42
      Width = 38
      Height = 13
      Caption = 'Version:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 9
      Top = 65
      Width = 23
      Height = 13
      Caption = 'Built:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 9
      Top = 89
      Width = 39
      Height = 13
      Caption = 'Thanks:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 9
      Top = 112
      Width = 21
      Height = 13
      Caption = 'Site:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 9
      Top = 135
      Width = 65
      Height = 13
      Caption = 'Source Code:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EditProductName: TEdit
      Left = 91
      Top = 19
      Width = 365
      Height = 23
      BorderStyle = bsNone
      Color = clSilver
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = 'EditProductName'
    end
    object EditVersion: TEdit
      Left = 91
      Top = 42
      Width = 365
      Height = 23
      BorderStyle = bsNone
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = 'EditVersion'
    end
    object EditUpDateTime: TEdit
      Left = 91
      Top = 65
      Width = 365
      Height = 24
      BorderStyle = bsNone
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      Text = 'EditUpDateTime'
    end
    object EditProgram: TEdit
      Left = 91
      Top = 89
      Width = 365
      Height = 23
      BorderStyle = bsNone
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      Text = 'EditProgram'
    end
    object EditWebSite: TEdit
      Left = 91
      Top = 112
      Width = 365
      Height = 23
      BorderStyle = bsNone
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      Text = 'EditWebSite'
    end
    object EditBbsSite: TEdit
      Left = 91
      Top = 135
      Width = 365
      Height = 24
      BorderStyle = bsNone
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
      Text = 'EditBbsSite'
    end
  end
end
