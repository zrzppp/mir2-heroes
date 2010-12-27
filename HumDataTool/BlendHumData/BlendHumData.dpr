program BlendHumData;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  LogMain in 'LogMain.pas' {frmLog},
  Share in 'Share.pas',
  IDDB in 'IDDB.pas',
  HumDB in 'HumDB.pas',
  HUtil32 in '..\..\Common\HUtil32.pas',
  MemoryIniFiles in 'MemoryIniFiles.pas',
  Grobal in 'Grobal.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

