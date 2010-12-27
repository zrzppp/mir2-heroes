program HumDataConvert;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  HumDB in 'HumDB.pas',
  Share in 'Share.pas',
  HUtil32 in '..\..\Common\HUtil32.pas',
  Grobal2 in '..\..\Common\Grobal2.pas',
  IDDB in 'IDDB.pas',
  EncryptUnit in '..\..\Common\EncryptUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
