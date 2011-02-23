program MapEdit;

uses
  Forms,
  EdMain in 'EdMain.pas' {FrmMain},
  mpalett in 'mpalett.pas' {FrmMainPal},
  FObj in 'FObj.pas' {FrmObj},
  ObjEdit in 'ObjEdit.pas' {FrmObjEdit},
  ObjSet in 'ObjSet.pas' {FrmObjSet},
  Tile in 'Tile.pas' {FrmTile},
  MapSize in 'MapSize.pas' {FrmMapSize},
  segunit in 'segunit.pas' {FrmSegment},
  SmTile in 'SmTile.pas',
  glight in 'glight.pas' {FrmGetLight},
  DoorDlg in 'DoorDlg.pas' {FrmDoorDlg},
  FScrlXY in 'FScrlXY.pas' {FrmScrollMap},
  MoveObj in 'MoveObj.pas' {FrmMoveObj},
  About in 'About.pas' {frmAbout},
  HUtil32 in '..\..\Common\HUtil32.pas',
  SelBitCount in 'SelBitCount.pas' {frmBitCount},
  Wis in '..\..\MirClient\Wis.pas',
  GameImages in '..\..\MirClient\GameImages.pas',
  Wil in '..\..\MirClient\Wil.pas',
  Textures in '..\..\MirClient\Textures.pas',
  Uib in '..\..\MirClient\Uib.pas',
  Fir in '..\..\MirClient\Fir.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'µØÍ¼±à¼­Æ÷';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmMainPal, FrmMainPal);
  Application.CreateForm(TFrmObj, FrmObj);
  Application.CreateForm(TFrmObjEdit, FrmObjEdit);
  Application.CreateForm(TFrmObjSet, FrmObjSet);
  Application.CreateForm(TFrmTile, FrmTile);
  Application.CreateForm(TFrmMapSize, FrmMapSize);
  Application.CreateForm(TFrmSegment, FrmSegment);
  Application.CreateForm(TFrmSmTile, FrmSmTile);
  Application.CreateForm(TFrmGetLight, FrmGetLight);
  Application.CreateForm(TFrmDoorDlg, FrmDoorDlg);
  Application.CreateForm(TFrmScrollMap, FrmScrollMap);
  Application.CreateForm(TFrmMoveObj, FrmMoveObj);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.

