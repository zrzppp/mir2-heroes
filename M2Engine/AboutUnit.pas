unit AboutUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmAbout = class(TForm)
    ButtonOK: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EditProductName: TEdit;
    EditVersion: TEdit;
    EditUpDateTime: TEdit;
    EditProgram: TEdit;
    EditWebSite: TEdit;
    EditBbsSite: TEdit;
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open();
  end;

var
  FrmAbout: TFrmAbout;

implementation
uses M2Share, Common, EncryptUnit;
{$R *.dfm}

procedure TFrmAbout.Open();
var
  ConfigOption: TConfigOption;
  Buffer: Pointer;
  sText: string;
begin
  EditUpDateTime.Text := '';
  EditProductName.Text := '';
  EditProgram.Text := '';
  EditWebSite.Text := ''; ;
  EditBbsSite.Text := '';
  EditVersion.Text := '';

  EditUpDateTime.ReadOnly := True;
  EditProductName.ReadOnly := True;
  EditProgram.ReadOnly := True;
  EditWebSite.ReadOnly := True;
  EditBbsSite.ReadOnly := True;
  EditVersion.ReadOnly := True;

  GetMem(Buffer, ConfigOptionSize);
  try
    g_MemoryStream.Seek(-ConfigOptionSize, soFromEnd);
    g_MemoryStream.Read(Buffer^, ConfigOptionSize);
    SetLength(sText, ConfigOptionSize);
    Move(Buffer^, sText[1], ConfigOptionSize);
  finally
    FreeMem(Buffer);
  end;

  DecryptBuffer(sText, @ConfigOption, SizeOf(TConfigOption));

  EditUpDateTime.Text := ConfigOption.sUpDateTime;
  EditProductName.Text := ConfigOption.sProductName;
  EditProgram.Text := ConfigOption.sProgram;
  EditWebSite.Text := ConfigOption.sWebSite;
  EditBbsSite.Text := ConfigOption.sBbsSite;
  EditVersion.Text := Format(ConfigOption.sVersion, [0]);

  ShowModal;
end;

procedure TFrmAbout.ButtonOKClick(Sender: TObject);
begin
  Close;
end;

end.
