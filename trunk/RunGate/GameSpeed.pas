unit GameSpeed;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, GateShare, ExtCtrls;

type
  TFrmGameSpeed = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox15: TGroupBox;
    CheckBoxSpeedingControl: TCheckBox;
    ButtonRef: TButton;
    ButtonSave: TButton;
    ButtonClose: TButton;
    Label5: TLabel;
    EditSpeedingTime: TSpinEdit;
    RadioGroupSpeedingDataManage: TRadioGroup;
    GroupBox2: TGroupBox;
    CheckBoxShowSpeedingMsg: TCheckBox;
    EditSpeedingMsg: TEdit;
    RadioGroupShowSpeedingMsg: TRadioGroup;
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonRefClick(Sender: TObject);
    procedure CheckBoxSpeedingControlClick(Sender: TObject);
    procedure RadioGroupSpeedingDataManageClick(Sender: TObject);
    procedure RadioGroupShowSpeedingMsgClick(Sender: TObject);
    procedure CheckBoxShowSpeedingMsgClick(Sender: TObject);
    procedure EditSpeedingMsgChange(Sender: TObject);
    procedure EditSpeedingTimeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open();
  end;

var
  FrmGameSpeed: TFrmGameSpeed;

implementation

{$R *.dfm}

procedure TFrmGameSpeed.Open();
begin
  CheckBoxSpeedingControl.Checked := g_boSpeedingControl;
  RadioGroupSpeedingDataManage.ItemIndex := g_nSpeedingDataManage;
  RadioGroupShowSpeedingMsg.ItemIndex := g_nShowSpeedingMsg;
  CheckBoxShowSpeedingMsg.Checked := g_boShowSpeedingMsg;
  EditSpeedingMsg.Text := g_sSpeedingMsg;
  EditSpeedingTime.Value := g_nSpeedingTime;

  ButtonSave.Enabled := False;
  ShowModal;
end;

procedure TFrmGameSpeed.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmGameSpeed.ButtonSaveClick(Sender: TObject);
begin
  if Conf <> nil then begin
    Conf.WriteInteger(GateClass, 'SpeedingDataManage', g_nSpeedingDataManage);
    Conf.WriteInteger(GateClass, 'SpeedingTime', g_nSpeedingTime);
    Conf.WriteInteger(GateClass, 'ShowSpeedingMsgType', g_nShowSpeedingMsg);
    Conf.WriteBool(GateClass, 'SpeedingControl', g_boSpeedingControl);
    Conf.WriteBool(GateClass, 'ShowSpeedingMsg', g_boShowSpeedingMsg);
    Conf.WriteString(GateClass, 'SpeedingMsg', g_sSpeedingMsg);
    ButtonSave.Enabled := False;
  end;
end;

procedure TFrmGameSpeed.ButtonRefClick(Sender: TObject);
begin
  g_nSpeedingDataManage := 2;
  g_boSpeedingControl := False;
  g_nSpeedingTime := 400;
  g_boShowSpeedingMsg := False;
  g_nShowSpeedingMsg := 0;
  g_sSpeedingMsg := '[提示]: 请爱护游戏环境，关闭加速外挂重新登陆';

  CheckBoxSpeedingControl.Checked := g_boSpeedingControl;
  RadioGroupSpeedingDataManage.ItemIndex := g_nSpeedingDataManage;
  RadioGroupShowSpeedingMsg.ItemIndex := g_nShowSpeedingMsg;
  CheckBoxShowSpeedingMsg.Checked := g_boShowSpeedingMsg;
  EditSpeedingMsg.Text := g_sSpeedingMsg;
  EditSpeedingTime.Value := g_nSpeedingTime;
  ButtonSave.Enabled := True;
end;

procedure TFrmGameSpeed.CheckBoxSpeedingControlClick(Sender: TObject);
begin
  g_boSpeedingControl := CheckBoxSpeedingControl.Checked;
  ButtonSave.Enabled := True;
end;

procedure TFrmGameSpeed.RadioGroupSpeedingDataManageClick(Sender: TObject);
begin
  g_nSpeedingDataManage := RadioGroupSpeedingDataManage.ItemIndex;
  ButtonSave.Enabled := True;
end;

procedure TFrmGameSpeed.RadioGroupShowSpeedingMsgClick(Sender: TObject);
begin
  g_nShowSpeedingMsg := RadioGroupShowSpeedingMsg.ItemIndex;
  ButtonSave.Enabled := True;
end;

procedure TFrmGameSpeed.CheckBoxShowSpeedingMsgClick(Sender: TObject);
begin
  g_boShowSpeedingMsg := CheckBoxShowSpeedingMsg.Checked;
  ButtonSave.Enabled := True;
end;

procedure TFrmGameSpeed.EditSpeedingMsgChange(Sender: TObject);
begin
  g_sSpeedingMsg := Trim(EditSpeedingMsg.Text);
  ButtonSave.Enabled := True;
end;

procedure TFrmGameSpeed.EditSpeedingTimeChange(Sender: TObject);
begin
  g_nSpeedingTime := EditSpeedingTime.Value;
  ButtonSave.Enabled := True;
end;

end.

