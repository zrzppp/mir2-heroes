program M2Server;

uses
  FastMM4,
  Forms,
  Windows,
  Graphics,
  svMain in 'svMain.pas' {FrmMain},
  LocalDB in 'LocalDB.pas' {FrmDB},
  IdSrvClient in 'IdSrvClient.pas' {FrmIDSoc},
  FSrvValue in 'FSrvValue.pas' {FrmServerValue},
  UsrEngn in 'UsrEngn.pas',
  ObjNpc in 'ObjNpc.pas',
  ObjMon2 in 'ObjMon2.pas',
  ObjMon in 'ObjMon.pas',
  ObjGuard in 'ObjGuard.pas',
  ObjActor in 'ObjActor.pas',
  ObjAxeMon in 'ObjAxeMon.pas',
  NoticeM in 'NoticeM.pas',
  Mission in 'Mission.pas',
  Magic in 'Magic.pas',
  M2Share in 'M2Share.pas',
  ItmUnit in 'ItmUnit.pas',
  FrnEngn in 'FrnEngn.pas',
  Event in 'Event.pas',
  Envir in 'Envir.pas',
  Castle in 'Castle.pas',
  RunDB in 'RunDB.pas',
  RunSock in 'RunSock.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  Mudutil in '..\Common\Mudutil.pas',
  PlugIn in 'PlugIn.pas',
  GeneralConfig in 'GeneralConfig.pas' {frmGeneralConfig},
  GameConfig in 'GameConfig.pas' {frmGameConfig},
  FunctionConfig in 'FunctionConfig.pas' {frmFunctionConfig},
  ObjRobot in 'ObjRobot.pas',
  BnkEngn in 'BnkEngn.pas',
  ViewSession in 'ViewSession.pas' {frmViewSession},
  ViewOnlineHuman in 'ViewOnlineHuman.pas' {frmViewOnlineHuman},
  ViewLevel in 'ViewLevel.pas' {frmViewLevel},
  ViewList in 'ViewList.pas' {frmViewList},
  OnlineMsg in 'OnlineMsg.pas' {frmOnlineMsg},
  HumanInfo in 'HumanInfo.pas' {frmHumanInfo},
  ViewKernelInfo in 'ViewKernelInfo.pas' {frmViewKernelInfo},
  ItemSet in 'ItemSet.pas' {frmItemSet},
  ConfigMonGen in 'ConfigMonGen.pas' {frmConfigMonGen},
  PlugInManage in 'PlugInManage.pas' {ftmPlugInManage},
  GameCommand in 'GameCommand.pas' {frmGameCmd},
  MonsterConfig in 'MonsterConfig.pas' {frmMonsterConfig},
  ActionSpeedConfig in 'ActionSpeedConfig.pas' {frmActionSpeed},
  CastleManage in 'CastleManage.pas' {frmCastleManage},
  Common in '..\Common\Common.pas',
  AttackSabukWallConfig in 'AttackSabukWallConfig.pas' {FrmAttackSabukWall},
  AboutUnit in 'AboutUnit.pas' {FrmAbout},
  Guild in 'Guild.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  ObjPlayRobot in 'ObjPlayRobot.pas',
  ObjHero in 'ObjHero.pas',
  SDK in '..\Common\SDK.pas',
  HeroConfig in 'HeroConfig.pas' {frmHeroConfig},
  PlugOfEngine in 'PlugOfEngine.pas',
  DataEngn in 'DataEngn.pas',
  SellEngn in 'SellEngn.pas',
  StorageEngn in 'StorageEngn.pas',
  ObjBase in 'ObjBase.pas',
  SysManager in 'SysManager.pas' {frmSysManager},
  ConfigItem in 'ConfigItem.pas' {frmConfigItem},
  ConfigMerchant in 'ConfigMerchant.pas' {frmConfigMerchant},
  DuelEngn in 'DuelEngn.pas',
  EncryptUnit in '..\Common\EncryptUnit.pas',
  MapPoint in 'MapPoint.pas',
  AI3 in 'AI3.pas',
  MyListBox in 'MyListBox.pas',
  ItemEvent in 'ItemEvent.pas';

{$R *.res}

procedure Start();
begin
  g_Config.nServerFile_CRCA := CalcFileCRC(Application.ExeName);
  Application.Initialize;
  Application.HintPause := 100;
  Application.HintShortPause := 100;
  Application.HintHidePause := 5000;
  Application.CreateForm(TFrmMain, FrmMain);
  asm
    jz @@Start
    jnz @@Start
    db 0EBh
    @@Start:
  end;
  Application.CreateForm(TFrmIDSoc, FrmIDSoc);

  Application.CreateForm(TftmPlugInManage, ftmPlugInManage);
  Application.CreateForm(TfrmGameCmd, frmGameCmd);
  Application.CreateForm(TfrmMonsterConfig, frmMonsterConfig);
  Application.Run;
end;

asm
  jz @@Start
  jnz @@Start
  db 0E8h
@@Start:
  lea eax,Start
  call eax
  jz @@end
  jnz @@end
  db 0F4h
  db 0FFh
@@end:
end.

