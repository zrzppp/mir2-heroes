object frmViewKernelInfo: TfrmViewKernelInfo
  Left = 161
  Top = 125
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '??????'
  ClientHeight = 480
  ClientWidth = 593
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 10
    Top = 10
    Width = 571
    Height = 461
    ActivePage = TabSheet2
    TabOrder = 0
    object TabSheet4: TTabSheet
      Caption = '????'
      ImageIndex = 3
      object GroupBox6: TGroupBox
        Left = 10
        Top = 10
        Width = 221
        Height = 91
        Caption = 'Allocated memory'
        TabOrder = 0
        object Label25: TLabel
          Left = 10
          Top = 25
          Width = 26
          Height = 15
          Caption = 'Size:'
        end
        object Label26: TLabel
          Left = 10
          Top = 55
          Width = 36
          Height = 15
          Caption = 'Count:'
        end
        object EditAllocMemCount: TEdit
          Left = 110
          Top = 50
          Width = 91
          Height = 23
          ReadOnly = True
          TabOrder = 0
        end
        object EditAllocMemSize: TEdit
          Left = 110
          Top = 20
          Width = 91
          Height = 23
          ReadOnly = True
          TabOrder = 1
        end
      end
      object GroupBox1: TGroupBox
        Left = 10
        Top = 265
        Width = 221
        Height = 151
        Caption = 'Human DB'
        TabOrder = 1
        object Label1: TLabel
          Left = 10
          Top = 25
          Width = 31
          Height = 15
          Caption = 'Load:'
        end
        object Label2: TLabel
          Left = 10
          Top = 55
          Width = 37
          Height = 15
          Caption = 'Errors:'
        end
        object Label3: TLabel
          Left = 10
          Top = 85
          Width = 37
          Height = 15
          Caption = 'Saves:'
        end
        object Label4: TLabel
          Left = 10
          Top = 115
          Width = 35
          Height = 15
          Caption = 'Query:'
        end
        object EditLoadHumanDBCount: TEdit
          Left = 110
          Top = 20
          Width = 91
          Height = 23
          ReadOnly = True
          TabOrder = 0
        end
        object EditLoadHumanDBErrorCoun: TEdit
          Left = 110
          Top = 50
          Width = 91
          Height = 23
          ReadOnly = True
          TabOrder = 1
        end
        object EditSaveHumanDBCount: TEdit
          Left = 110
          Top = 80
          Width = 91
          Height = 23
          ReadOnly = True
          TabOrder = 2
        end
        object EditHumanDBQueryID: TEdit
          Left = 110
          Top = 110
          Width = 91
          Height = 23
          ReadOnly = True
          TabOrder = 3
        end
      end
      object GroupBox4: TGroupBox
        Left = 10
        Top = 175
        Width = 221
        Height = 86
        Caption = 'Items DB'
        TabOrder = 2
        object Label7: TLabel
          Left = 10
          Top = 25
          Width = 75
          Height = 15
          Caption = 'Item Number:'
        end
        object Label8: TLabel
          Left = 10
          Top = 55
          Width = 45
          Height = 15
          Caption = 'Item EX:'
        end
        object EditItemNumber: TEdit
          Left = 110
          Top = 20
          Width = 91
          Height = 23
          ReadOnly = True
          TabOrder = 0
        end
        object EditItemNumberEx: TEdit
          Left = 110
          Top = 50
          Width = 91
          Height = 23
          ReadOnly = True
          TabOrder = 1
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = '????'
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 180
        Top = 5
        Width = 191
        Height = 96
        Caption = '????'
        TabOrder = 0
        object Label5: TLabel
          Left = 10
          Top = 25
          Width = 31
          Height = 15
          Caption = '????:'
        end
        object Label6: TLabel
          Left = 10
          Top = 55
          Width = 31
          Height = 15
          Caption = '????:'
        end
        object EditWinLotteryCount: TEdit
          Left = 110
          Top = 20
          Width = 71
          Height = 23
          ReadOnly = True
          TabOrder = 0
        end
        object EditNoWinLotteryCount: TEdit
          Left = 110
          Top = 50
          Width = 71
          Height = 23
          ReadOnly = True
          TabOrder = 1
        end
      end
      object GroupBox3: TGroupBox
        Left = 10
        Top = 5
        Width = 161
        Height = 206
        Caption = '????'
        TabOrder = 1
        object Label9: TLabel
          Left = 10
          Top = 25
          Width = 24
          Height = 15
          Caption = '???:'
        end
        object Label10: TLabel
          Left = 10
          Top = 55
          Width = 24
          Height = 15
          Caption = '???:'
        end
        object Label11: TLabel
          Left = 10
          Top = 85
          Width = 24
          Height = 15
          Caption = '???:'
        end
        object Label12: TLabel
          Left = 10
          Top = 115
          Width = 24
          Height = 15
          Caption = '???:'
        end
        object Label13: TLabel
          Left = 10
          Top = 145
          Width = 24
          Height = 15
          Caption = '???:'
        end
        object Label14: TLabel
          Left = 10
          Top = 175
          Width = 24
          Height = 15
          Caption = '???:'
        end
        object EditWinLotteryLevel1: TEdit
          Left = 70
          Top = 20
          Width = 71
          Height = 23
          ReadOnly = True
          TabOrder = 0
        end
        object EditWinLotteryLevel2: TEdit
          Left = 70
          Top = 50
          Width = 71
          Height = 23
          ReadOnly = True
          TabOrder = 1
        end
        object EditWinLotteryLevel3: TEdit
          Left = 70
          Top = 80
          Width = 71
          Height = 23
          ReadOnly = True
          TabOrder = 2
        end
        object EditWinLotteryLevel4: TEdit
          Left = 70
          Top = 110
          Width = 71
          Height = 23
          ReadOnly = True
          TabOrder = 3
        end
        object EditWinLotteryLevel5: TEdit
          Left = 70
          Top = 140
          Width = 71
          Height = 23
          ReadOnly = True
          TabOrder = 4
        end
        object EditWinLotteryLevel6: TEdit
          Left = 70
          Top = 170
          Width = 71
          Height = 23
          ReadOnly = True
          TabOrder = 5
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = '????'
      ImageIndex = 2
      object GroupBox5: TGroupBox
        Left = 10
        Top = 5
        Width = 531
        Height = 406
        Caption = '??????'
        TabOrder = 0
        object PageControl2: TPageControl
          Left = 10
          Top = 20
          Width = 511
          Height = 371
          ActivePage = TabSheet1
          TabOrder = 0
          object TabSheet1: TTabSheet
            Caption = 'G??'
            object ListViewG: TListView
              Left = 10
              Top = 10
              Width = 481
              Height = 281
              Columns = <
                item
                  Caption = '??'
                  Width = 63
                end
                item
                  Caption = '???'
                  Width = 125
                end>
              GridLines = True
              TabOrder = 0
              ViewStyle = vsReport
            end
            object ButtonClearG: TButton
              Left = 10
              Top = 300
              Width = 111
              Height = 31
              Caption = '???G??'
              TabOrder = 1
              OnClick = ButtonClearGClick
            end
            object ButtonRefG: TButton
              Left = 130
              Top = 300
              Width = 94
              Height = 31
              Caption = '??'
              TabOrder = 2
              OnClick = ButtonRefGClick
            end
          end
          object TabSheet5: TTabSheet
            Caption = 'A??'
            ImageIndex = 1
            object ListViewA: TListView
              Left = 10
              Top = 10
              Width = 481
              Height = 281
              Columns = <
                item
                  Caption = '??'
                  Width = 63
                end
                item
                  Caption = '???'
                  Width = 375
                end>
              GridLines = True
              TabOrder = 0
              ViewStyle = vsReport
            end
            object ButtonClearA: TButton
              Left = 10
              Top = 300
              Width = 111
              Height = 31
              Caption = '???A??'
              TabOrder = 1
              OnClick = ButtonClearAClick
            end
            object ButtonRefA: TButton
              Left = 130
              Top = 300
              Width = 94
              Height = 31
              Caption = '??'
              TabOrder = 2
              OnClick = ButtonRefAClick
            end
          end
        end
      end
    end
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 416
    Top = 160
  end
end
