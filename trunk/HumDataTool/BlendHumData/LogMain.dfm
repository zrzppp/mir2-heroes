object frmLog: TfrmLog
  Left = 371
  Top = 210
  Width = 685
  Height = 361
  Caption = #37325#21517#21464#26356#35760#24405#65288#20174#24211#65289
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 12
  object PanelLeft: TRzPanel
    Left = 0
    Top = 0
    Width = 225
    Height = 308
    Align = alLeft
    TabOrder = 0
    object RzGroupBox1: TRzGroupBox
      Left = 2
      Top = 2
      Width = 221
      Height = 304
      Align = alClient
      Caption = #36134#21495#37325#21517#21464#26356#65306'LogId.txt'
      TabOrder = 0
      object MemoIDLog: TRzMemo
        Left = 1
        Top = 13
        Width = 219
        Height = 290
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object PanelRight: TRzPanel
    Left = 448
    Top = 0
    Width = 229
    Height = 308
    Align = alRight
    TabOrder = 1
    object RzGroupBox3: TRzGroupBox
      Left = 2
      Top = 2
      Width = 225
      Height = 304
      Align = alClient
      Caption = #34892#20250#37325#21517#21464#26356#65306'LogGuild.txt'
      TabOrder = 0
      object MemoGuildLog: TRzMemo
        Left = 1
        Top = 13
        Width = 223
        Height = 290
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object PanelClient: TRzPanel
    Left = 225
    Top = 0
    Width = 223
    Height = 308
    Align = alClient
    TabOrder = 2
    object RzGroupBox2: TRzGroupBox
      Left = 2
      Top = 2
      Width = 219
      Height = 304
      Align = alClient
      Caption = #20154#29289#37325#21517#21464#26356#65306'LogHum.txt'
      TabOrder = 0
      object MemoHumLog: TRzMemo
        Left = 1
        Top = 13
        Width = 217
        Height = 290
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object RzStatusBar1: TRzStatusBar
    Left = 0
    Top = 308
    Width = 677
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    TabOrder = 3
    VisualStyle = vsGradient
    object StatusPaneID: TRzStatusPane
      Left = 0
      Top = 0
      Width = 201
      Height = 19
      Align = alLeft
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object StatusPaneGuild: TRzStatusPane
      Left = 466
      Top = 0
      Width = 211
      Height = 19
      Align = alRight
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
    object StatusPaneHum: TRzStatusPane
      Left = 201
      Top = 0
      Width = 265
      Height = 19
      Align = alClient
      BlinkIntervalOff = 1
      BlinkIntervalOn = 1
    end
  end
end
