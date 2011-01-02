object FrmBasicSet: TFrmBasicSet
  Left = 620
  Top = 178
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'General'
  ClientHeight = 240
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 401
    Height = 193
    ActivePage = TabSheet2
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Accounts'
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 177
        Height = 73
        Caption = 'Accounts'
        TabOrder = 0
        object CheckBoxTestServer: TCheckBox
          Left = 16
          Top = 16
          Width = 97
          Height = 17
          Caption = 'Test Server'
          TabOrder = 0
          OnClick = CheckBoxTestServerClick
        end
        object CheckBoxEnableMakingID: TCheckBox
          Left = 16
          Top = 32
          Width = 97
          Height = 17
          Caption = 'Making Accounts'
          TabOrder = 1
          OnClick = CheckBoxEnableMakingIDClick
        end
        object CheckBoxEnableGetbackPassword: TCheckBox
          Left = 16
          Top = 48
          Width = 97
          Height = 17
          Caption = 'Get Back Password'
          TabOrder = 2
          OnClick = CheckBoxEnableGetbackPasswordClick
        end
      end
      object GroupBox2: TGroupBox
        Left = 200
        Top = 8
        Width = 185
        Height = 73
        Caption = 'Auto Delete'
        TabOrder = 1
        object Label1: TLabel
          Left = 16
          Top = 40
          Width = 30
          Height = 12
          Caption = 'Time:'
        end
        object CheckBoxAutoClear: TCheckBox
          Left = 16
          Top = 16
          Width = 97
          Height = 17
          Caption = 'Auto Clear Accounts'
          TabOrder = 0
          OnClick = CheckBoxAutoClearClick
        end
        object SpinEditAutoClearTime: TSpinEdit
          Left = 72
          Top = 36
          Width = 65
          Height = 21
          MaxValue = 1000000
          MinValue = 1
          TabOrder = 1
          Value = 1
          OnChange = SpinEditAutoClearTimeChange
        end
      end
      object ButtonRestoreBasic: TButton
        Left = 320
        Top = 136
        Width = 67
        Height = 25
        Caption = 'Default(&D)'
        TabOrder = 2
        OnClick = ButtonRestoreBasicClick
      end
      object GroupBox7: TGroupBox
        Left = 8
        Top = 88
        Width = 177
        Height = 65
        Caption = 'Unlock Accounts'
        TabOrder = 3
        object Label9: TLabel
          Left = 8
          Top = 40
          Width = 72
          Height = 12
          Caption = 'Unlock Time:'
        end
        object CheckBoxAutoUnLockAccount: TCheckBox
          Left = 8
          Top = 16
          Width = 121
          Height = 17
          Hint = 
            'This feature is used for when someone has tried the password too' +
            ' many times.'
          Caption = 'Auto Unlock Account'
          TabOrder = 0
          OnClick = CheckBoxAutoUnLockAccountClick
        end
        object SpinEditUnLockAccountTime: TSpinEdit
          Left = 88
          Top = 36
          Width = 65
          Height = 21
          MaxValue = 1000000
          MinValue = 1
          TabOrder = 1
          Value = 1
          OnChange = SpinEditUnLockAccountTimeChange
        end
      end
      object CheckBoxMinimize: TCheckBox
        Left = 200
        Top = 136
        Width = 121
        Height = 17
        Caption = 'Minimize'
        TabOrder = 4
        OnClick = CheckBoxMinimizeClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Ports / IPs'
      ImageIndex = 1
      object ButtonRestoreNet: TButton
        Left = 312
        Top = 136
        Width = 75
        Height = 25
        Caption = 'Default (&D)'
        TabOrder = 0
        OnClick = ButtonRestoreNetClick
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 185
        Height = 65
        Caption = 'Game Addr / Port'
        TabOrder = 1
        object Label3: TLabel
          Left = 8
          Top = 18
          Width = 60
          Height = 12
          Caption = 'Gate Addr:'
        end
        object Label4: TLabel
          Left = 8
          Top = 42
          Width = 60
          Height = 12
          Caption = 'Game Port:'
        end
        object EditGateAddr: TEdit
          Left = 72
          Top = 14
          Width = 105
          Height = 20
          TabOrder = 0
          OnChange = EditGateAddrChange
        end
        object EditGatePort: TEdit
          Left = 72
          Top = 38
          Width = 57
          Height = 20
          TabOrder = 1
          OnChange = EditGatePortChange
        end
      end
      object GroupBox4: TGroupBox
        Left = 200
        Top = 8
        Width = 185
        Height = 65
        Caption = 'Mon Addr / Port'
        TabOrder = 2
        object Label5: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = 'Mon Addr:'
        end
        object Label6: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = 'Mon Port:'
        end
        object EditMonAddr: TEdit
          Left = 72
          Top = 14
          Width = 105
          Height = 20
          TabOrder = 0
          OnChange = EditMonAddrChange
        end
        object EditMonPort: TEdit
          Left = 72
          Top = 38
          Width = 57
          Height = 20
          TabOrder = 1
          OnChange = EditMonPortChange
        end
      end
      object GroupBox5: TGroupBox
        Left = 8
        Top = 88
        Width = 185
        Height = 65
        Caption = 'Server Addr / Port'
        TabOrder = 3
        object Label7: TLabel
          Left = 8
          Top = 18
          Width = 72
          Height = 12
          Caption = 'Server Addr:'
        end
        object Label8: TLabel
          Left = 8
          Top = 42
          Width = 72
          Height = 12
          Caption = 'Server Port:'
        end
        object EditServerAddr: TEdit
          Left = 80
          Top = 14
          Width = 97
          Height = 20
          TabOrder = 0
          OnChange = EditServerAddrChange
        end
        object EditServerPort: TEdit
          Left = 88
          Top = 38
          Width = 57
          Height = 20
          TabOrder = 1
          OnChange = EditServerPortChange
        end
      end
      object GroupBox6: TGroupBox
        Left = 200
        Top = 88
        Width = 153
        Height = 41
        Caption = 'Dynamic IP'
        TabOrder = 4
        object CheckBoxDynamicIPMode: TCheckBox
          Left = 16
          Top = 16
          Width = 121
          Height = 17
          Caption = 'Dynamic IP Mode'
          TabOrder = 0
          OnClick = CheckBoxDynamicIPModeClick
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Not Used'
      ImageIndex = 2
    end
  end
  object ButtonSave: TButton
    Left = 248
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Save (&S)'
    TabOrder = 1
    OnClick = ButtonSaveClick
  end
  object ButtonClose: TButton
    Left = 334
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Close (&O)'
    TabOrder = 2
    OnClick = ButtonCloseClick
  end
end
