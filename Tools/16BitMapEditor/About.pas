unit about;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmAbout = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ButtonOK: TButton;
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

procedure TfrmAbout.ButtonOKClick(Sender: TObject);
begin
  Close;
end;

end.

