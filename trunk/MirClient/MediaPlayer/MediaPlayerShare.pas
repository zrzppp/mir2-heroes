unit MediaPlayerShare;

interface
uses
  Windows, SysUtils, Variants, Classes, Graphics, OleCtrls, BmpBtn, WMPLib_TLB;
type
  //TMyProcedure = procedure of object;

  TPlayFile = record
    BmpBotton: TBmpButton;
    sShowName: string;
    sSource: string;
  end;
  pTPlayFile = ^TPlayFile;

  TPlayList = class
    m_PlayList: TStringList;
    m_sFileName: string;
  private
    function GetCount: Integer;
  public
    constructor Create(sFileName: string);
    destructor Destroy; override;
    function Get(FileName: string): Integer;
    function GetSource(Const Source: string): Integer;
    procedure LoadPlayList();
    procedure UnLoadPlayList();
    procedure SaveToFile();
    function Add(FileName: string): Integer;
    procedure Clear;
    procedure Delete(PlayFile: pTPlayFile);
    property Count: Integer read GetCount;
  published
    //property Directory: string read GetDirectory;
    //property SecrchSuccess: Boolean read GetSecrchSuccess;

  end;

var
  g_SoundBarInnerLeft: TBitmap;
  g_SoundBarInnerRight: TBitmap;
  g_SoundBarLeft: TBitmap;
  g_SoundBarRight: TBitmap;

  g_ProgressBarBGLeft: TBitmap;
  g_ProgressBarFGLeft: TBitmap;
  g_SeekBarBuffered: TBitmap;
  g_SeekBarInnerLeft: TBitmap;
  g_SeekBarInnerRight: TBitmap;
  g_SeekBarLeft: TBitmap;
  g_SeekBarRight: TBitmap;
  g_SeekBarRightBuffered: TBitmap;

  g_boGetMediaInfo: Boolean = False;

  g_btVolume: Byte = 100;

  g_boHandicraft: Boolean = True;
  g_boChangeProgress: Boolean = False;




  g_CurrentPlayFile: pTPlayFile;
  g_SelectPlayFile: pTPlayFile;

  g_sCurrentSource: string;
  g_boMp3Type: Boolean;

  g_PlayList: TPlayList;
  g_nCurrentIndex: Integer = 0;
  g_nSelectIndex: Integer = 0;
  g_nMouseMoveIndex: Integer = -1;
  g_nOldMouseMoveIndex: Integer = -1;
  g_boMouseDown: Boolean = False;
  //g_dwMouseMoveTick: LongWord;

  g_sPlayListFileName: string = 'PlayList.txt';
  g_boStartBuffering: Boolean;
implementation

uses HUtil32;

constructor TPlayList.Create(sFileName: string);
begin
  m_PlayList := TStringList.Create;
  m_sFileName := sFileName;
end;

destructor TPlayList.Destroy;
begin
  UnLoadPlayList();
  m_PlayList.Free;
end;

function TPlayList.Get(FileName: string): Integer;
var
  I: Integer;
  sLineText, sShowName, sFileName: string;
begin
  Result := -1;
  sLineText := FileName;
  if Pos('|', sLineText) > 0 then begin
    sLineText := GetValidStr3(sLineText, sShowName, [#9, '|']);
    sLineText := GetValidStr3(sLineText, sFileName, [#9, '|']);
    sLineText := sFileName;
  end;
  for I := 0 to m_PlayList.Count - 1 do begin
    if CompareText(pTPlayFile(m_PlayList.Objects[I]).sSource, sLineText) = 0 then begin
      Result := I;
      Break;
    end;
  end;
end;

function TPlayList.GetSource(Const Source: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to m_PlayList.Count - 1 do begin
    if CompareText(pTPlayFile(m_PlayList.Objects[I]).sSource, Source) = 0 then begin
      Result := I;
      Break;
    end;
  end;
end;

procedure TPlayList.LoadPlayList();
var
  I: Integer;
  List: TStringList;
  sLineText, sShowName, sFileName: string;
  PlayFile: pTPlayFile;
begin
  if FileExists(ExtractFilePath(ParamStr(0)) + m_sFileName) then begin
    UnLoadPlayList();
    List := TStringList.Create;
    List.LoadFromFile(ExtractFilePath(ParamStr(0)) + m_sFileName);
    for I := 0 to List.Count - 1 do begin
      sLineText := Trim(List.Strings[I]);
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        if Get(sLineText) >= 0 then Continue;
        if Pos('|', sLineText) > 0 then begin
          sLineText := GetValidStr3(sLineText, sShowName, [#9, '|']);
          sLineText := GetValidStr3(sLineText, sFileName, [#9, '|']);
        end else begin
          sFileName := sLineText;
          sShowName := ExtractFileNameOnly(sLineText);
        end;
        if (sFileName <> '') and (sShowName <> '') then begin
          New(PlayFile);
          PlayFile.sShowName := sShowName;
          PlayFile.sSource := sFileName;
          m_PlayList.AddObject(sShowName, TObject(PlayFile));
        end;
      end;
    end;
    List.Free;
  end;
end;

procedure TPlayList.UnLoadPlayList();
var
  I: Integer;
begin
  for I := 0 to m_PlayList.Count - 1 do begin
    Dispose(pTPlayFile(m_PlayList.Objects[I]));
  end;
  m_PlayList.Clear;
end;

procedure TPlayList.SaveToFile();
var
  I: Integer;
  PlayFile: pTPlayFile;
  ServerList: TStringList;
  sLineText: string;
begin
  ServerList := TStringList.Create;
  for I := 0 to m_PlayList.Count - 1 do begin
    PlayFile := pTPlayFile(m_PlayList.Objects[I]);
    sLineText := PlayFile.sShowName + '|' + PlayFile.sSource;
    ServerList.Add(sLineText);
  end;
  FileSetAttr(ExtractFilePath(ParamStr(0)) + m_sFileName, 0);
  try
    ServerList.SaveToFile(ExtractFilePath(ParamStr(0)) + m_sFileName);
  except
  end;
  FileSetAttr(ExtractFilePath(ParamStr(0)) + m_sFileName, 2);
  ServerList.Free;
end;

function TPlayList.GetCount: Integer;
begin
  Result := m_PlayList.Count;
end;


function GetLastFileName(const sFileName: string): string;
var
  I, nLen: Integer;
begin
  Result := sFileName;
  nLen := Length(sFileName);
  if (nLen > 0) and ((sFileName[nLen] = '/') or (sFileName[nLen] = '\')) then Dec(nLen);
  for I := nLen downto 1 do begin
    if (sFileName[I] = '/') or (sFileName[I] = '\') then begin
      Result := Copy(sFileName, I + 1, Length(sFileName) - I);
      Exit;
    end;
  end;
  //if Pos(':', sFileName) > 0 then Result := sFileName[1];
end;

function TPlayList.Add(FileName: string): Integer;
var
  sLineText, sShowName, sFileName: string;
  PlayFile: pTPlayFile;
begin
  Result := Get(FileName);
  if Result >= 0 then Exit;
  sLineText := FileName;
  if Pos('|', sLineText) > 0 then begin
    sLineText := GetValidStr3(sLineText, sShowName, [#9, '|']);
    sLineText := GetValidStr3(sLineText, sFileName, [#9, '|']);
  end else
    if Pos('http', sLineText) > 0 then begin
    sFileName := sLineText;
    sShowName := ExtractFileNameOnly(GetLastFileName(sLineText));
  end else begin
    sFileName := sLineText;
    sShowName := ExtractFileNameOnly(sLineText);
  end;
  if (sFileName <> '') and (sShowName <> '') then begin
    New(PlayFile);
    PlayFile.BmpBotton := nil;
    PlayFile.sShowName := sShowName;
    PlayFile.sSource := sFileName;
    m_PlayList.AddObject(sShowName, TObject(PlayFile));
    Result := m_PlayList.Count - 1;
  end;
end;

procedure TPlayList.Clear;
var
  I: Integer;
begin
  for I := 0 to m_PlayList.Count - 1 do begin
    Dispose(pTPlayFile(m_PlayList.Objects[I]));
  end;
  m_PlayList.Clear;
end;

procedure TPlayList.Delete(PlayFile: pTPlayFile);
var
  I: Integer;
begin
  for I := m_PlayList.Count - 1 downto 0 do begin
    if pTPlayFile(m_PlayList.Objects[I]) = PlayFile then begin
      Dispose(pTPlayFile(m_PlayList.Objects[I]));
      m_PlayList.Delete(I);
      Break;
    end;
  end;
end;

end.

