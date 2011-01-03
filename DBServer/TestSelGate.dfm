object frmTestSelGate: TfrmTestSelGate
  Left = 918
  Top = 256
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Select Gate Test'
  ClientHeight = 150
  ClientWidth = 261
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 10
    Top = 10
    Width = 241
    Height = 131
    Caption = 'Select Gate Test'
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 25
      Width = 66
      Height = 15
      Caption = 'Select Gate:'
    end
    object Label2: TLabel
      Left = 10
      Top = 55
      Width = 66
      Height = 15
      Caption = 'Game Gate:'
    end
    object EditSelGate: TEdit
      Left = 80
      Top = 20
      Width = 141
      Height = 23
      TabOrder = 0
      Text = '127.0.0.1'
    end
    object EditGameGate: TEdit
      Left = 80
      Top = 50
      Width = 141
      Height = 23
      TabOrder = 1
    end
    object ButtonTest: TButton
      Left = 20
      Top = 90
      Width = 81
      Height = 31
      Caption = 'Test (&T)'
      TabOrder = 2
      OnClick = ButtonTestClick
    end
    object Button1: TButton
      Left = 140
      Top = 90
      Width = 81
      Height = 31
      Caption = 'Close (&C)'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
end
