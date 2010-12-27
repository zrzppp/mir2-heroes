library WebBrowser;

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
  FastMM4,
  SysUtils,
  Classes,
  Forms,
  PlugShare in 'PlugShare.pas',
  HUtil32 in '..\..\Common\HUtil32.pas',
  WelCome in 'WelCome.pas' {frmWelCome},
  PlugCommon in '..\Common\PlugCommon.pas';

{$R *.res}
var
  OldHookInitialize: TInitialize;
  OldHookFinalize: TInitialize;
  OldHookKeyDown: TKeyDown;
  OldHookKeyPress: TKeyPress;

function HookKeyDown(Key: Word; Shift: TShiftState): Boolean; stdcall;
begin
  Result := False;
  if Assigned(OldHookKeyDown) then begin
    Result := OldHookKeyDown(Key, Shift);
  end;
end;

procedure HookInitialize; stdcall;
begin
  if Assigned(OldHookInitialize) then OldHookInitialize();
end;

procedure HookFinalize; stdcall;
begin
  if frmWelCome <> nil then begin
    frmWelCome.Close;
    FreeAndnil(frmWelCome);
  end; 
  if Assigned(OldHookFinalize) then OldHookFinalize();
end;

procedure OpenHomePage(HomePage: PChar); stdcall;
var
  sHomePage: string;
begin
  sHomePage := StrPas(HomePage);
  if frmWelCome = nil then begin
    if g_PlugInfo.FullScreen^ then begin
      frmWelCome := TfrmWelCome.CreateParented(g_PlugInfo.AppHandle);
      frmWelCome.Left := 0;
      frmWelCome.Top := 0;
    end else begin
      frmWelCome := TfrmWelCome.Create(nil);
      frmWelCome.FormStyle := fsStayOnTop;
    end;
  end;
  if sHomePage = '' then begin
    frmWelCome.Open;
  end else begin
    frmWelCome.Open(sHomePage);
  end;
end;

procedure PlugInitialize;
begin
  OldHookInitialize := g_PlugInfo.HookInitialize;
  OldHookFinalize := g_PlugInfo.HookFinalize;
  OldHookKeyDown := g_PlugInfo.HookKeyDown;
  OldHookKeyPress := g_PlugInfo.HookKeyPress;


  g_PlugInfo.HookKeyDown := HookKeyDown;
  g_PlugInfo.HookInitialize := HookInitialize;
  g_PlugInfo.HookFinalize := HookFinalize;
  g_PlugInfo.OpenHomePage := OpenHomePage;
end;

procedure PlugFinalize;
begin
  g_PlugInfo.HookInitialize := OldHookInitialize;
  g_PlugInfo.HookFinalize := OldHookFinalize;
  g_PlugInfo.HookKeyDown := OldHookKeyDown;
  g_PlugInfo.HookKeyPress := OldHookKeyPress;

  if frmWelCome <> nil then begin
    frmWelCome.Close;
    FreeAndnil(frmWelCome);
  end;
end;

procedure Init(PlugInfo: pTPlugInfo); stdcall;
begin
  g_PlugInfo := PlugInfo;
  PlugInitialize;
end;

procedure UnInit(); stdcall;
begin
  PlugFinalize;
end;

exports
  Init, UnInit;
begin

end.

