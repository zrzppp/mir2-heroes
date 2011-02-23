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
  EditUpDateTime.Text := '23/02/2011';
  EditProductName.Text := 'Legend of Mir 2: Heroes';
  EditProgram.Text := 'Thanks to the CQFir Team';
  EditWebSite.Text := 'www.lomcn.co.uk'; ;
  EditBbsSite.Text := 'http://code.google.com/p/mir2-heroes/';
  EditVersion.Text := 'Beta Build';

  EditUpDateTime.ReadOnly := True;
  EditProductName.ReadOnly := True;
  EditProgram.ReadOnly := True;
  EditWebSite.ReadOnly := True;
  EditBbsSite.ReadOnly := True;
  EditVersion.ReadOnly := True;

  ShowModal;
end;

procedure TFrmAbout.ButtonOKClick(Sender: TObject);
begin
  Close;
end;

end.
