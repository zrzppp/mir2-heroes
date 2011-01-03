object ftmPlugInManage: TftmPlugInManage
  Left = 724
  Top = 332
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Plugins'
  ClientHeight = 230
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object ListBoxPlugin: TListBox
    Left = 8
    Top = 16
    Width = 329
    Height = 201
    ItemHeight = 12
    TabOrder = 0
    OnClick = ListBoxPluginClick
    OnDblClick = ListBoxPluginDblClick
  end
  object ButtonConfig: TButton
    Left = 352
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Config (&C)'
    TabOrder = 1
    OnClick = ButtonConfigClick
  end
end
