object frmOnlineMsg: TfrmOnlineMsg
  Left = 493
  Top = 174
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Online Message'
  ClientHeight = 415
  ClientWidth = 550
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 5
    Top = 211
    Width = 62
    Height = 15
    Caption = 'Online Msg'
  end
  object MemoMsg: TMemo
    Left = 4
    Top = 5
    Width = 542
    Height = 191
    Lines.Strings = (
      'MemoMsg')
    TabOrder = 0
    OnChange = MemoMsgChange
  end
  object StringGrid: TStringGrid
    Left = 4
    Top = 274
    Width = 542
    Height = 132
    ColCount = 1
    DefaultColWidth = 430
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    ScrollBars = ssVertical
    TabOrder = 1
    OnClick = StringGridClick
    OnDblClick = StringGridDblClick
  end
  object ButtonAdd: TButton
    Left = 459
    Top = 239
    Width = 84
    Height = 29
    Caption = 'Add'
    Enabled = False
    TabOrder = 2
    OnClick = ButtonAddClick
  end
  object ButtonDelete: TButton
    Left = 366
    Top = 239
    Width = 84
    Height = 29
    Caption = 'Delete'
    Enabled = False
    TabOrder = 3
    OnClick = ButtonDeleteClick
  end
  object ButtonSend: TButton
    Left = 185
    Top = 238
    Width = 84
    Height = 28
    Caption = 'Send'
    TabOrder = 4
    OnClick = ButtonSendClick
  end
  object EditMsg: TEdit
    Left = 80
    Top = 205
    Width = 460
    Height = 23
    TabOrder = 5
    OnChange = EditMsgChange
    OnKeyPress = EditMsgKeyPress
  end
end
