unit SoundEngn;

interface
uses
  Windows, Classes, SysUtils, DXSounds, Mpeg;
type
  TPlaySound = class(TThread)
    m_UserCriticalSection: TRTLCriticalSection;
    m_SoundList: TStringList;
    m_SoundTempList: TStringList;

    m_MediaList: TStringList;
    m_MediaTempList: TStringList;
    m_sFileName: string;
    m_DXSound: TDXSound;
    m_Sound: TSoundEngine;
    m_boSound: Boolean;
    m_MP3: TMPEG;
  private
    { Private declarations }
    procedure Run;
    function GetInitialized: Boolean;
    procedure PlayMedia;
  protected
    procedure Execute; override;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure MediaPlayer(const sFileName: string);
    procedure PlayMp3(const sFileName: string);
    procedure PlayBGM(const sFileName: string);
    procedure PlaySound(const sFileName: string);
    procedure PlayOnLineSound(const sFileName: string);
    procedure Initialize;
    procedure Clear;
    property Initialized: Boolean read GetInitialized;
  end;

implementation
uses ClMain, PlugIn;
var
  boFirstMedia: Boolean = True;

constructor TPlaySound.Create(AOwner: TComponent);
begin
  inherited Create(False);
  InitializeCriticalSection(m_UserCriticalSection);
  m_SoundList := TStringList.Create;
  m_SoundTempList := TStringList.Create;
  m_MediaList := TStringList.Create;
  m_MediaTempList := TStringList.Create;
  m_DXSound := TDXSound.Create(AOwner);
  m_Sound := nil;
  m_MP3 := nil;
  m_boSound := True;
  //  FreeOnTerminate:=True;
end;

destructor TPlaySound.Destroy;
begin
  m_SoundList.Free;
  m_SoundTempList.Free;
  m_MediaList.Free;
  m_MediaTempList.Free;
  if m_Sound <> nil then m_Sound.Free;
  if m_MP3 <> nil then m_MP3.Free;
  m_DXSound.Free;
  DeleteCriticalSection(m_UserCriticalSection);
  inherited Destroy;
end;

procedure TPlaySound.Execute;
//resourcestring
 // sExceptionMsg = '[Exception] TPlaySound::Execute';
begin
  while not Terminated do begin
    try
      Run();
    except

    end;
    Sleep(1);
  end;
end;

procedure TPlaySound.Initialize;
begin
  m_DXSound.Initialize;
  if m_DXSound.Initialized then begin
    m_Sound := TSoundEngine.Create(m_DXSound.DSound);
    m_MP3 := TMPEG.Create(nil);
  end;
end;

function TPlaySound.GetInitialized: Boolean;
begin
  Result := m_DXSound.Initialized;
end;

procedure TPlaySound.PlaySound(const sFileName: string);
begin
  EnterCriticalSection(m_UserCriticalSection);
  try
    if m_SoundList.Count > 0 then begin
      m_SoundList.InsertObject(0, sFileName, TObject(GetTickCount));
    end else begin
      m_SoundList.AddObject(sFileName, TObject(GetTickCount));
    end;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

procedure TPlaySound.PlayOnLineSound(const sFileName: string);
begin
  m_sFileName := sFileName;
  {EnterCriticalSection(m_UserCriticalSection);
  try
    //m_SoundOnLineList.InsertObject(0, sFileName, TObject(GetTickCount));
    if m_SoundList.Count > 0 then begin
      m_SoundList.InsertObject(0, sFileName, TObject(GetTickCount));
    end else begin
      m_SoundList.AddObject(sFileName, TObject(GetTickCount));
    end;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end; }

end;

procedure TPlaySound.MediaPlayer(const sFileName: string);
begin
  EnterCriticalSection(m_UserCriticalSection);
  try
    if m_MediaList.IndexOf(sFileName) < 0 then
      m_MediaList.AddObject(sFileName, TObject(GetTickCount));
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

procedure TPlaySound.PlayMedia;
var
  I: Integer;
begin
  for I := 0 to m_MediaList.Count - 1 do begin
    if Assigned(g_PlugInfo.MediaPlayer.Player) then begin
      g_PlugInfo.MediaPlayer.Player(PChar(m_MediaList[I]), False, True);
    end;
  end;
  m_MediaList.Clear;
end;

procedure TPlaySound.Run;
var
  I: Integer;
begin
  EnterCriticalSection(m_UserCriticalSection);
  try
    m_SoundTempList.Clear;
    m_SoundTempList.AddStrings(m_SoundList);
    m_SoundList.Clear;
    if (m_Sound <> nil) and m_boSound then begin
      for I := 0 to m_SoundTempList.Count - 1 do begin
        if (m_SoundTempList[I] <> '') and ((GetTickCount - LongWord(m_SoundTempList.Objects[I])) < 100) then begin
          if FileExists(m_SoundTempList[I]) then begin
            try
              //Sleep(10);
              m_Sound.EffectFile(m_SoundTempList[I], False, False);
            except
            end;
          end;
        end;
      end;
    end;

    m_MediaTempList.Clear;
    m_MediaTempList.AddStrings(m_MediaList);
    m_MediaList.Clear;

    for I := 0 to m_MediaTempList.Count - 1 do begin
      if (m_MediaTempList[I] <> '') then begin
        if boFirstMedia then begin
          if ((GetTickCount - LongWord(m_MediaTempList.Objects[I])) > 3000) then begin
            boFirstMedia := False;
            try
              if Assigned(g_PlugInfo.MediaPlayer.Player) then begin
                g_PlugInfo.MediaPlayer.Player(PChar(m_MediaTempList[I]), False, True);
              //m_MediaTempList.SaveToFile('m_MediaTempList.txt');
              end;
            except
            end;
          end else m_MediaList.AddObject(m_MediaTempList[I], m_MediaTempList.Objects[I]);
        end else begin
          try
            if Assigned(g_PlugInfo.MediaPlayer.Player) then begin
              g_PlugInfo.MediaPlayer.Player(PChar(m_MediaTempList[I]), False, True);
              //m_MediaTempList.SaveToFile('m_MediaTempList.txt');
            end;
          except
          end;
        end;
      end;
    end;
    //m_MediaPlayerList.Clear;
    //Synchronize(PlayMedia);
   // Synchronize(MediaPlayer);
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

procedure TPlaySound.PlayBGM(const sFileName: string);
begin
  //if not g_boBGSound then Exit;
  if (m_Sound <> nil) and FileExists(sFileName) then begin
   // m_Sound.Enabled := g_boBGSound;
    try
      m_Sound.EffectFile(sFileName, True, False);

    except
    end;
  end;
end;

procedure TPlaySound.Clear;
begin
  m_SoundList.Clear;
  if m_Sound <> nil then begin
    m_Sound.Clear;
  end;
end;

procedure TPlaySound.PlayMp3(const sFileName: string);
begin
  if m_MP3 <> nil then begin
    if sFileName <> '' then
      if FileExists(sFileName) then begin
        try
          m_MP3.stop;
          m_MP3.play(sFileName);
        except
        end;
      end;
  end;
end;

end.

