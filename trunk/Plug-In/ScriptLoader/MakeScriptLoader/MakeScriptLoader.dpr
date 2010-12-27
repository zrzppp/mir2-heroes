program MakeScriptLoader;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  Common in '..\..\..\Common\Common.pas',
  EncryptUnit in '..\..\..\Common\EncryptUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
