program DBServer;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  DBShare in 'DBShare.pas',
  SelectClient in 'SelectClient.pas',
  IDSocCli in 'IDSocCli.pas' {FrmIDSoc},
  HumDB in 'HumDB.pas',
  ServerClient in 'ServerClient.pas',
  SDK in '..\Common\SDK.pas',
  Ranking in 'Ranking.pas' {FrmRankingDlg},
  FIDHum in 'FIDHum.pas' {FrmIDHum},
  CreateChr in 'CreateChr.pas' {FrmCreateChr},
  viewrcd in 'viewrcd.pas' {FrmFDBViewer},
  EditRcd in 'EditRcd.pas' {frmEditRcd},
  RouteEdit in 'RouteEdit.pas' {frmRouteEdit},
  RouteManage in 'RouteManage.pas' {frmRouteManage},
  TestSelGate in 'TestSelGate.pas' {frmTestSelGate},
  Grobal2 in '..\Common\Grobal2.pas',
  EncryptUnit in '..\Common\EncryptUnit.pas',
  Common in '..\Common\Common.pas',
  Setting in 'Setting.pas' {FrmSetting};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmIDSoc, FrmIDSoc);
  Application.CreateForm(TFrmIDHum, FrmIDHum);
  Application.CreateForm(TFrmCreateChr, FrmCreateChr);
  Application.CreateForm(TFrmFDBViewer, FrmFDBViewer);
  Application.CreateForm(TfrmEditRcd, frmEditRcd);
  Application.CreateForm(TfrmRouteEdit, frmRouteEdit);
  Application.CreateForm(TfrmRouteManage, frmRouteManage);
  Application.CreateForm(TFrmRankingDlg, FrmRankingDlg);
  Application.Run;
end.

