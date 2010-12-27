
library MediaPlayer;

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
  WMPLib_TLB,
  Controls,
  MediaPlayerShare,
  Graphics,
  PlugShare in 'PlugShare.pas',
  HUtil32 in '..\..\Common\HUtil32.pas',
  PlugCommon in '..\Common\PlugCommon.pas',
  MediaPlayerMain in 'MediaPlayerMain.pas' {frmCqFirMediaPlayer},
  OpenDialogNew in 'OpenDialogNew.pas' {frmOpenDiaLogNew},
  BmpBtn in 'BmpBtn.pas',
  PlayListBox in 'PlayListBox.pas';

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
  if frmCqFirMediaPlayer = nil then begin
    frmCqFirMediaPlayer := TfrmCqFirMediaPlayer.CreateParented(g_PlugInfo.AppHandle);
    frmCqFirMediaPlayer.Left := 0;
    frmCqFirMediaPlayer.Top := 0;
  end;

  if frmOpenDiaLogNew = nil then begin
    if g_PlugInfo.FullScreen^ then begin
      frmOpenDiaLogNew := TfrmOpenDiaLogNew.CreateParented(g_PlugInfo.AppHandle);
      frmOpenDiaLogNew.Left := 200;
      frmOpenDiaLogNew.Top := 100;
    end else begin
      frmOpenDiaLogNew := TfrmOpenDiaLogNew.Create(nil);
      frmOpenDiaLogNew.FormStyle := fsStayOnTop;
    end;
  end;
  if Assigned(OldHookInitialize) then OldHookInitialize();
end;

procedure HookFinalize; stdcall;
begin
  if frmOpenDiaLogNew <> nil then begin
    FreeAndnil(frmOpenDiaLogNew);
  end;

  if frmCqFirMediaPlayer <> nil then begin
    frmCqFirMediaPlayer.Close;
    try
      FreeAndnil(frmCqFirMediaPlayer);
    except
      frmCqFirMediaPlayer := nil;
    end;
  end;

  if Assigned(OldHookFinalize) then OldHookFinalize();
end;

procedure AddMediaPlayer(FileName: PChar; boShow, boPlay: Boolean); stdcall;
var
  sFileName: string;
begin
  sFileName := StrPas(FileName);
  frmCqFirMediaPlayer.Play(sFileName, boShow, boPlay);
end;

procedure Stop; stdcall;
begin
  if frmCqFirMediaPlayer <> nil then begin
    with frmCqFirMediaPlayer do
      WindowsMediaPlayer.Controls.stop;
    g_boHandicraft := True;
  end;
end;

procedure StopPlay(FileName: PChar); stdcall;
begin
  if frmCqFirMediaPlayer <> nil then begin

    frmCqFirMediaPlayer.StopPlay(FileName);
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
  g_PlugInfo.MediaPlayer.Player := AddMediaPlayer;
  g_PlugInfo.MediaPlayer.StopPlay := StopPlay;

  g_PlayList := TPlayList.Create(g_sPlayListFileName);
  g_PlayList.LoadPlayList;

  frmCqFirMediaPlayer := nil;
  frmOpenDiaLogNew := nil;
end;

procedure PlugFinalize;
begin
  g_PlugInfo.HookInitialize := OldHookInitialize;
  g_PlugInfo.HookFinalize := OldHookFinalize;
  g_PlugInfo.HookKeyDown := OldHookKeyDown;
  g_PlugInfo.HookKeyPress := OldHookKeyPress;

  if frmOpenDiaLogNew <> nil then begin
    try
      FreeAndnil(frmOpenDiaLogNew);
    except
      frmOpenDiaLogNew := nil;
    end;
  end;

  if frmCqFirMediaPlayer <> nil then begin
    frmCqFirMediaPlayer.Close;
    try
      FreeAndnil(frmCqFirMediaPlayer);
    except
      frmCqFirMediaPlayer := nil;
    end;
  end;

  g_PlayList.SaveToFile;
  g_PlayList.Free;
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

