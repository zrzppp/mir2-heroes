program DataViewer;

uses
  FastMM4,
  Forms,
  Main in 'Main.pas' {frmMain},
  InPutDlgMain in 'InPutDlgMain.pas' {frmInPutDlg},
  MirShare in 'MirShare.pas',
  InPutManyDlgMain in 'InPutManyDlgMain.pas' {frmInPutManyDlg},
  SelectPath in 'SelectPath.pas',
  SGL in 'SGL.pas',
  HUtil32 in '..\..\Common\HUtil32.pas',
  DelDlgMain in 'DelDlgMain.pas' {frmDelDlg},
  OutPutDlgMain in 'OutPutDlgMain.pas' {frmOutPutDlg},
  XYDlgMain in 'XYDlgMain.pas' {frmXYDlg},
  ConvertDlgMain in 'ConvertDlgMain.pas' {frmConvertDlg},
  CompressUnit1 in '..\..\Common\CompressUnit1.pas',
  CompressUnit in '..\..\Common\CompressUnit.pas',
  ZLibx in '..\..\Common\ZLibx.pas',
  CreateData in 'CreateData.pas' {FrmCreateData},
  GameImages in 'GameImages.pas',
  SDK in '..\..\Common\SDK.pas',
  MapFiles in '..\..\Common\MapFiles.pas';

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmInPutDlg, frmInPutDlg);
  Application.CreateForm(TfrmInPutManyDlg, frmInPutManyDlg);
  Application.CreateForm(TfrmDelDlg, frmDelDlg);
  Application.CreateForm(TfrmOutPutDlg, frmOutPutDlg);
  Application.CreateForm(TfrmXYDlg, frmXYDlg);
  Application.CreateForm(TfrmConvertDlg, frmConvertDlg);
  Application.CreateForm(TFrmCreateData, FrmCreateData);
  Application.Run;
end.

