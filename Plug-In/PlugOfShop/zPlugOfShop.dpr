library zPlugOfShop;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  Windows,
  SysUtils,
  Classes,
  PlugMain in 'PlugMain.pas',
  PlugShare in 'PlugShare.pas',
  PlayShop in 'PlayShop.pas',
  ShopConfig in 'ShopConfig.pas' {FrmShopItem},
  HUtil32 in '..\PlugInCommon\HUtil32.pas',
  EngineInterface in '..\PlugInCommon\EngineInterface.pas';

{$R *.res}
const
  PlugName = 'MakeGM商铺插件 (2010/09/01)';
  LoadPlus = '加载MakeGM商铺插件成功...';
  UnLoadPlus = '卸载MakeGM商铺插件成功...';

function Start(): Boolean; stdcall;
begin
  Result := StartPlug;
end;

function Init(PlugEngine: pTPlugEngine): PChar; stdcall;
begin
  g_PlugEngine := PlugEngine^;
  g_UserManage := TUserManage.Create();
  g_CharObject := TCharObject.Create();
  g_CharObject.EngineOut := g_PlugEngine.EngineOut;
  g_UserManage.EngineOut := g_PlugEngine.EngineOut;
  g_UserManage.UserEngine := g_PlugEngine.UserEngine;
  MainOutMessage(LoadPlus, 0);
  InitPlug();
  Result := PChar(PlugName);
end;

procedure UnInit(); stdcall;
begin
  g_UserManage.Free;
  g_CharObject.Free;
  UnInitPlug();
  MainOutMessage(UnLoadPlus, 0);
end;

procedure Config(); stdcall;
begin
  FrmShopItem := TFrmShopItem.Create(nil);
  FrmShopItem.Open;
  FrmShopItem.Free;
end;

exports
  Init, UnInit, Start, Config;
begin

end.

