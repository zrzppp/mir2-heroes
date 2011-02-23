program DataConvert;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  HUtil32 in '..\..\Common\HUtil32.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
