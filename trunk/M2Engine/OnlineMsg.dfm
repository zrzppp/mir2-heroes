object frmOnlineMsg: TfrmOnlineMsg
  Left = 722
  Top = 174
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #22312#32447#21457#36865#28040#24687
  ClientHeight = 332
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 4
    Top = 169
    Width = 54
    Height = 12
    Caption = #22312#32447#20449#24687':'
  end
  object MemoMsg: TMemo
    Left = 3
    Top = 4
    Width = 434
    Height = 153
    Lines.Strings = (
      'MemoMsg')
    TabOrder = 0
    OnChange = MemoMsgChange
  end
  object StringGrid: TStringGrid
    Left = 3
    Top = 219
    Width = 434
    Height = 106
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
    Left = 367
    Top = 191
    Width = 67
    Height = 23
    Caption = #22686#21152'(&A)'
    Enabled = False
    TabOrder = 2
    OnClick = ButtonAddClick
  end
  object ButtonDelete: TButton
    Left = 293
    Top = 191
    Width = 67
    Height = 23
    Caption = #21024#38500'(&D)'
    Enabled = False
    TabOrder = 3
    OnClick = ButtonDeleteClick
  end
  object ButtonSend: TButton
    Left = 148
    Top = 190
    Width = 67
    Height = 23
    Caption = #21457#36865'(&S)'
    TabOrder = 4
    OnClick = ButtonSendClick
  end
  object EditMsg: TEdit
    Left = 64
    Top = 164
    Width = 368
    Height = 20
    TabOrder = 5
    OnChange = EditMsgChange
    OnKeyPress = EditMsgKeyPress
  end
end
