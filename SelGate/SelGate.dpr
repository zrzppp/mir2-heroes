program SelGate;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  GateShare in 'GateShare.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  Share in 'Share.pas',
  Common in '..\Common\Common.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  GeneralConfig in 'GeneralConfig.pas' {frmGeneralConfig},
  Option in 'Option.pas' {frmOption},
  Mudutil in '..\Common\Mudutil.pas',
  EncryptUnit in '..\Common\EncryptUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

