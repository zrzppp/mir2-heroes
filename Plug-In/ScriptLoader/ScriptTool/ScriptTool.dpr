program ScriptTool;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  EngineInterface in '..\..\PlugInCommon\EngineInterface.pas',
  Common in '..\..\..\Common\Common.pas',
  EncryptUnit in '..\..\..\Common\EncryptUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
