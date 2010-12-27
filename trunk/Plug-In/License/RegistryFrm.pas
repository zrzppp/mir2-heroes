unit RegistryFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, EncryptUnit, Main, PlugShare, Share;

type
  TFrmRegistryDlg = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditSerialNumber: TEdit;
    EditRegistryNumber: TEdit;
    Label2: TLabel;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRegistryDlg: TFrmRegistryDlg;

implementation

{$R *.dfm}

procedure TFrmRegistryDlg.ButtonOKClick(Sender: TObject);
var
  RegistryConfig: TRegistryConfig;
  sSerialNumber: string;
  sKey: string;
  InData, OutData: Pointer;
begin
  if R_SystemInitialize^ and (R_nOwner^ <> 0) then begin
    sKey := Trim(EditRegistryNumber.Text);
    if sKey <> '' then begin
      DecryptBuffer(sKey, @RegistryConfig, SizeOf(TRegistryConfig) - 4);
      sSerialNumber := RegistryConfig.SerialNumber;
      {Showmessage(sSerialNumber);
      Showmessage(GetSerialNumber(R_nUserNumber^, R_nVersion^));
      Showmessage(Format('RegistryConfig.nUserNumber:%d,R_nUserNumber:%d',[RegistryConfig.nUserNumber,R_nUserNumber^]));
      }
      if (RegistryConfig.nUserNumber = R_nUserNumber^) and (sSerialNumber = GetSerialNumber(R_nUserNumber^, R_nVersion^)) then begin
        if WriteRegKey(1, R_MySubKey, R_Key, sKey) then begin
          if Assigned(R_SystemConfig.RegistrySuccess) then begin
            R_SystemConfig.RegistrySuccess;
          end;
          Close;
        end;
      end else begin
        if Assigned(R_SystemConfig.RegistryFail) then begin
          R_SystemConfig.RegistryFail;
        end;
      end;
    end;
  end else Close;
end;

procedure TFrmRegistryDlg.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmRegistryDlg.FormCreate(Sender: TObject);
begin
  EditSerialNumber.Text := GetSerialNumber(R_nUserNumber^, R_nVersion^);
end;

end.

