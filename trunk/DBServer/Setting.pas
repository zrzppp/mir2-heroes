unit Setting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, Grobal2;

type
  TFrmSetting = class(TForm)
    GroupBox1: TGroupBox;
    ButtonOK: TButton;
    CheckBoxAttack: TCheckBox;
    CheckBoxDenyChrName: TCheckBox;
    CheckBoxMinimize: TCheckBox;
    CheckBoxDeleteChrName: TCheckBox;
    CheckBoxRandomNumber: TCheckBox;
    CheckBox1: TCheckBox;
    procedure CheckBoxAttackClick(Sender: TObject);
    procedure CheckBoxDenyChrNameClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure CheckBoxMinimizeClick(Sender: TObject);
    procedure CheckBoxDeleteChrNameClick(Sender: TObject);
    procedure CheckBoxRandomNumberClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open();
  end;

var
  FrmSetting: TFrmSetting;

implementation
uses DBShare;
{$R *.dfm}

procedure TFrmSetting.Open();
begin
  //CheckBoxAttack.Checked := boAttack;
  CheckBoxDenyChrName.Checked := g_boDenyChrName;
  CheckBoxMinimize.Checked := g_boMinimize;
  CheckBoxDeleteChrName.Checked := g_boDeleteChrName;
  CheckBoxRandomNumber.Checked := g_boRandomNumber;
  ButtonOK.Enabled := False;
  ShowModal;
end;

procedure TFrmSetting.CheckBoxAttackClick(Sender: TObject);
begin
  //boAttack := CheckBoxAttack.Checked;
  //ButtonOK.Enabled := True;
end;

procedure TFrmSetting.CheckBoxDeleteChrNameClick(Sender: TObject);
begin
  g_boDeleteChrName := CheckBoxDeleteChrName.Checked;
  ButtonOK.Enabled := True;
end;

procedure TFrmSetting.CheckBoxDenyChrNameClick(Sender: TObject);
begin
  g_boDenyChrName := CheckBoxDenyChrName.Checked;
  ButtonOK.Enabled := True;
end;

procedure TFrmSetting.ButtonOKClick(Sender: TObject);
var
  Conf: TIniFile;
begin
  Conf := TIniFile.Create(g_sConfFileName);
  if Conf <> nil then begin
    //Conf.WriteBool('Setup', 'Attack', boAttack);
    Conf.WriteBool('Setup', 'DenyChrName', g_boDenyChrName);
    Conf.WriteBool('Setup', 'Minimize', g_boMinimize);
    Conf.WriteBool('Setup', 'DeleteChrName', g_boDeleteChrName);
    Conf.WriteBool('Setup', 'RandomNumber', g_boRandomNumber);

    Conf.Free;
    ButtonOK.Enabled := False;
  end;
end;

procedure TFrmSetting.CheckBoxMinimizeClick(Sender: TObject);
begin
  g_boMinimize := CheckBoxMinimize.Checked;
  ButtonOK.Enabled := True;
end;

procedure TFrmSetting.CheckBoxRandomNumberClick(Sender: TObject);
begin
  g_boRandomNumber := CheckBoxRandomNumber.Checked;
  ButtonOK.Enabled := True;
end;

procedure TFrmSetting.FormCreate(Sender: TObject);
begin
{$IF HEROVERSION = 1}
  CheckBoxRandomNumber.Enabled := True;
{$ELSE}
  CheckBoxRandomNumber.Enabled := False;
{$IFEND}
end;

end.
