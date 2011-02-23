program DataManage;

{%TogetherDiagram 'ModelSupport_DataManage\default.txaPackage'}

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  AccountManage in 'AccountManage.pas' {frmAccountManage: TFrame},
  DataClear in 'DataClear.pas' {frmDataClear: TFrame},
  HumDB in 'HumDB.pas',
  HumManage in 'HumManage.pas' {frmHumManage: TFrame},
  IDDB in 'IDDB.pas',
  ItemManage in 'ItemManage.pas' {frmItemManage: TFrame},
  LocalDB in 'LocalDB.pas',
  Login in 'Login.pas' {frmLogin},
  MagicManage in 'MagicManage.pas' {frmMagic},
  ObjBase in 'ObjBase.pas',
  OtherOption in 'OtherOption.pas' {frmOtherOption: TFrame},
  Progress in 'Progress.pas' {frmProgress},
  Share in 'Share.pas',
  Welcome in 'Welcome.pas' {frmWelcome: TFrame};

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
