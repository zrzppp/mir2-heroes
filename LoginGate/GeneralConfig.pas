unit GeneralConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, IniFiles, Spin;

type
  TfrmGeneralConfig = class(TForm)
    GroupBoxNet: TGroupBox;
    LabelGateIPaddr: TLabel;
    EditGateIPaddr: TEdit;
    EditGatePort: TEdit;
    LabelGatePort: TLabel;
    EditServerPort: TEdit;
    LabelServerPort: TLabel;
    LabelServerIPaddr: TLabel;
    EditServerIPaddr: TEdit;
    GroupBoxInfo: TGroupBox;
    Label1: TLabel;
    EditTitle: TEdit;
    ButtonOK: TButton;
    CheckBoxMinimize: TCheckBox;
    Label2: TLabel;
    EditMaxCount: TSpinEdit;
    procedure ButtonOKClick(Sender: TObject);
    procedure CheckBoxMinimizeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open();
  end;

var
  frmGeneralConfig: TfrmGeneralConfig;

implementation

uses HUtil32, Share;

{$R *.dfm}

procedure TfrmGeneralConfig.ButtonOKClick(Sender: TObject);
var
  sGateIPaddr, sServerIPaddr, sTitle: string;
  nGatePort, nServerPort, nMaxCount: Integer;
  Conf: TIniFile;
begin
  sGateIPaddr := Trim(EditGateIPaddr.Text);
  nGatePort := Str_ToInt(Trim(EditGatePort.Text), -1);
  sServerIPaddr := Trim(EditServerIPaddr.Text);
  nServerPort := Str_ToInt(Trim(EditServerPort.Text), -1);
  nMaxCount := EditMaxCount.Value;
  sTitle := Trim(EditTitle.Text);

  if not IsIpAddr(sGateIPaddr) then begin
    Application.MessageBox('网关地址设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditGateIPaddr.SetFocus;
    Exit;
  end;

  if (nGatePort < 0) or (nGatePort > 65535) then begin
    Application.MessageBox('网关端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditGatePort.SetFocus;
    Exit;
  end;

  if not IsIpAddr(sServerIPaddr) then begin
    Application.MessageBox('服务器地址设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditServerIPaddr.SetFocus;
    Exit;
  end;

  if (nServerPort < 0) or (nServerPort > 65535) then begin
    Application.MessageBox('网关端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditServerPort.SetFocus;
    Exit;
  end;
  if sTitle = '' then begin
    Application.MessageBox('标题设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditTitle.SetFocus;
    Exit;
  end;
  g_Config.TitleName := sTitle;
  g_Config.ServerAddr := sServerIPaddr;
  g_Config.ServerPort := nServerPort;
  g_Config.GateAddr := sGateIPaddr;
  g_Config.GatePort := nGatePort;
  g_Config.nMaxCount := nMaxCount;
  Conf := TIniFile.Create('.\Config.ini');
  Conf.WriteString(GateClass, 'Title', g_Config.TitleName);
  Conf.WriteString(GateClass, 'ServerAddr', g_Config.ServerAddr);
  Conf.WriteInteger(GateClass, 'ServerPort', g_Config.ServerPort);
  Conf.WriteString(GateClass, 'GateAddr', g_Config.GateAddr);
  Conf.WriteInteger(GateClass, 'GatePort', g_Config.GatePort);
  Conf.WriteBool(GateClass, 'Minimize', g_Config.boMinimize);
  Conf.WriteInteger(GateClass, 'MaxCount', g_Config.nMaxCount);
  Conf.Free;
  Close;
end;

procedure TfrmGeneralConfig.CheckBoxMinimizeClick(Sender: TObject);
begin
  g_Config.boMinimize := CheckBoxMinimize.Checked;
end;

procedure TfrmGeneralConfig.Open();
begin
  EditGateIPaddr.Text := g_Config.GateAddr;
  EditGatePort.Text := IntToStr(g_Config.GatePort);
  EditServerIPaddr.Text := g_Config.ServerAddr;
  EditServerPort.Text := IntToStr(g_Config.ServerPort);
  EditTitle.Text := g_Config.TitleName;
  EditMaxCount.Value := g_Config.nMaxCount;
  CheckBoxMinimize.Checked := g_Config.boMinimize;
  ShowModal;
end;

end.

