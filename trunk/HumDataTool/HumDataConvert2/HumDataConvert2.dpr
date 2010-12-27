program HumDataConvert2;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  Share in 'Share.pas',
  HumDB in 'HumDB.pas',
  ShareRecord in 'ShareRecord.pas';

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
