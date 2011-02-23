program EditColor;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  Share in 'Share.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
