unit Uib;

interface
uses
  Windows, Classes, Graphics, SysUtils, Controls, DIB, Textures, GameImages, MapFiles;
type
  TUibImages = class(TGameImages)
    m_FileList: TStringList;
  private
    procedure LoadDxImage(const AFileName: string; DXImage: pTDXImage);
    function GetTextureByName(Name: string): TTexture;
    function GetIndexByName(Name: string): Integer;
  protected
    function GetCachedSurface(Index: Integer): TTexture; override;
  public

    constructor Create(); override;
    destructor Destroy; override;
    procedure Initialize; override;
    procedure Finalize; override;
    function GetCachedImage(Index: Integer; var PX, PY: Integer): TTexture; override;
    property Names[Name: string]: TTexture read GetTextureByName;
  end;

implementation
uses Math;//,MShare;

constructor TUibImages.Create();
begin
  inherited;
  m_FileList := TStringList.Create;
end;

destructor TUibImages.Destroy;
begin
  m_FileList.Free;
  inherited;
end;

procedure TUibImages.Initialize;
begin
  if not Initialized then begin
    BitCount := 8;
    ImageCount := m_FileList.Count;
    //FileName := 'Data\';
    m_ImgArr := AllocMem(SizeOf(TDXImage) * ImageCount);
    Initialized := True;
  end;
end;

procedure TUibImages.Finalize;
var
  I: Integer;
begin
  if Initialized then begin
    Initialized := False;
    IndexList.Clear;
    if m_ImgArr <> nil then begin
      for I := 0 to ImageCount - 1 do begin
        if m_ImgArr[I].Texture <> nil then begin
          m_ImgArr[I].Texture.Free;
          m_ImgArr[I].Texture := nil;
        end;
        if m_ImgArr[I].Bitmap <> nil then begin
          m_ImgArr[I].Bitmap.Free;
          m_ImgArr[I].Bitmap := nil;
        end;
      end;
      FreeMem(m_ImgArr);
    end;
    m_ImgArr := nil;
    ImageCount := 0;
  end;
end;

procedure TUibImages.LoadDxImage(const AFileName: string; DXImage: pTDXImage);
begin
  //DebugOutStr('AFileName1: ' + AFileName);
  if FileExists(AFileName) then begin
    //DebugOutStr('AFileName2: ' + AFileName);
    DXImage.Texture := TTexture.Create;
    DXImage.nPx := 0;
    DXImage.nPy := 0;
    DXImage.Texture.LoadFromFile(AFileName);
    DXImage.Texture.TransparentColor := 0;
  end;
end;

function TUibImages.GetIndexByName(Name: string): Integer;
var
  I: integer;
begin
  Result := -1;
  for I := 0 to m_FileList.Count - 1 do
    if (LowerCase(Name) = LowerCase(m_FileList.Strings[I])) then begin
      Result := I; //Integer(m_FileList.Objects[I]);
      Break;
    end;
  if Result < 0 then begin
    m_FileList.Add(Name);
    Result := m_FileList.Count - 1;
  end;
  ImageCount := m_FileList.Count;
end;

function TUibImages.GetCachedImage(Index: Integer; var PX, PY: Integer): TTexture;
begin
  Result := nil;
  m_dwUseCheckTick := GetTickCount;
  if (Index >= 0) and (Index < ImageCount) and (Initialized) then begin
    if GetTickCount - m_dwMemChecktTick > 10000 then begin
      m_dwMemChecktTick := GetTickCount;
      FreeOldMemorys(Index);
    end;
    if m_ImgArr[Index].Texture = nil then begin
      LoadDxImage(m_FileList.Strings[Index], @m_ImgArr[Index]);
      PX := m_ImgArr[Index].nPx;
      PY := m_ImgArr[Index].nPy;
      Result := m_ImgArr[Index].Texture;
    end else begin
      m_ImgArr[Index].dwLatestTime := GetTickCount;
      PX := m_ImgArr[Index].nPx;
      PY := m_ImgArr[Index].nPy;
      Result := m_ImgArr[Index].Texture;
    end;
  end;
end;

function TUibImages.GetCachedSurface(Index: Integer): TTexture;
begin
  Result := nil;
  m_dwUseCheckTick := GetTickCount;
  if (Index >= 0) and (Index < ImageCount) and (Initialized) then begin
    if GetTickCount - m_dwMemChecktTick > 10000 then begin
      m_dwMemChecktTick := GetTickCount;
      FreeOldMemorys(Index);
    end;
    if m_ImgArr[Index].Texture = nil then begin
      LoadDxImage(m_FileList.Strings[Index], @m_ImgArr[Index]);
      Result := m_ImgArr[Index].Texture;
    end else begin
      m_ImgArr[Index].dwLatestTime := GetTickCount;
      Result := m_ImgArr[Index].Texture;
    end;
  end;
end;

function TUibImages.GetTextureByName(Name: string): TTexture;
var
  Index: integer;
  nPosition: integer;
  nErrCode: integer;
begin
  Result := nil;
  try
    nErrCode := 0;
    if (m_FileList = nil) or (not Initialized) then Exit;
    Index := GetIndexByName(Name);
    if (Index < 0) then Exit;

    nErrCode := 1;
    if GetTickCount - m_dwMemChecktTick > 1000 * 5 then begin
      m_dwMemChecktTick := GetTickCount;
      nErrCode := 2;
      FreeOldMemorys(Index);
      nErrCode := 3;
    end;

    if m_ImgArr[Index].Texture = nil then begin
      nErrCode := 5;
      IndexList.Add(Pointer(Index));
      nErrCode := 7;
      LoadDxImage(Name, @m_ImgArr[Index]);
      nErrCode := 8;
      m_ImgArr[Index].dwLatestTime := GetTickCount;
      Result := m_ImgArr[Index].Texture;
    end else begin
      m_ImgArr[Index].dwLatestTime := GetTickCount;
      Result := m_ImgArr[Index].Texture;
    end;
  except
    Result := nil;
    //DebugOutStr('TWMImages.GetCachedSurface Index: ' + IntToStr(Index) + ' Error Code: ' + IntToStr(nErrCode));
  end;
end;

initialization


end.

