unit Welcome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw;

type
  TfrmWelcome = class(TFrame)
    WebBrowser: TWebBrowser;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Init;
  end;

var
  frmWelcome: TfrmWelcome;

implementation

{$R *.dfm}
procedure TfrmWelcome.Init;
begin
{$IFDEF VCL70_OR_HIGHER}
  ParentBackground := False;
{$ENDIF}
  WebBrowser.Navigate('http://www.MakeGM.com');
end;

end.

