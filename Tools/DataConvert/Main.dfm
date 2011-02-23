object FrmMain: TFrmMain
  Left = 586
  Top = 277
  BorderStyle = bsDialog
  Caption = #26087'Data'#36716#25442#26032'Data'#25991#20214
  ClientHeight = 111
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 16
    Top = 20
    Width = 42
    Height = 12
    Caption = #26087'Data:'
  end
  object Label2: TLabel
    Left = 16
    Top = 44
    Width = 42
    Height = 12
    Caption = #26032'Data:'
  end
  object ButtonOK: TButton
    Left = 176
    Top = 64
    Width = 75
    Height = 25
    Caption = #36716#25442
    TabOrder = 0
    OnClick = ButtonOKClick
  end
  object EditOldFile: TRzButtonEdit
    Left = 72
    Top = 16
    Width = 345
    Height = 20
    TabOrder = 1
    OnButtonClick = EditOldFileButtonClick
  end
  object EditNewFile: TRzButtonEdit
    Left = 72
    Top = 40
    Width = 345
    Height = 20
    TabOrder = 2
    OnButtonClick = EditNewFileButtonClick
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 94
    Width = 428
    Height = 17
    Align = alBottom
    TabOrder = 3
  end
  object OpenDialog: TOpenDialog
    Filter = 'Data'#25991#20214'|*.data'
    Left = 288
    Top = 16
  end
  object SaveDialog: TSaveDialog
    Filter = 'Data'#25991#20214'|*.data'
    Left = 328
    Top = 16
  end
end
