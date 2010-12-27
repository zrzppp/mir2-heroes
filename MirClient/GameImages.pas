unit GameImages;

interface
uses
  Windows, Classes, Graphics, SysUtils, DIB, Textures, HUtil32; //SDK,
type
  TDXImage = record
    nPx: SmallInt;
    nPy: SmallInt;
    Bitmap: TBitmap;
    Texture: TTexture;
    dwLatestTime: longword;
  end;
  pTDxImage = ^TDXImage;

  TLibType = (ltUseCache, ltLoadBmp, ltLoadBmpFile, ltLoadMemory);
  TDxImageArr = array[0..MaxListSize div 4] of TDXImage;
  PTDxImageArr = ^TDxImageArr;

  TGameImages = class(TObject)
    m_dwFreeMemCheckTick: longword;
    m_dwUseCheckTick: longword;
    m_dwMemChecktTick: longword;
  private
    FFileName: string; //0x24
    FImageCount: Integer; //0x28

    FAppr: Word;
    FBitCount: Byte;
    FInitialized: Boolean;
    FLibType: TLibType;
  protected
    function GetCachedSurface(Index: Integer): TTexture; virtual;
    function GetCachedBitmap(Index: Integer): TBitmap; virtual;
  public
    IndexList: TList;
    m_ImgArr: PTDxImageArr;
    constructor Create(); virtual;
    destructor Destroy; override;
    procedure FreeOldMemorys(Index: Integer); overload;
    procedure FreeOldMemorys; overload;
    procedure Initialize; virtual;
    procedure Finalize; virtual;
    procedure ClearCache; virtual;

    function GetCachedImage(Index: Integer; var px, py: Integer): TTexture; virtual;
    function GetBitmap(Index: Integer; var PX, PY: Integer): TBitmap; virtual;

    procedure StretchBlt(Index: Integer; DC: HDC; X, Y: Integer; var Width, Height: Integer; ROP: Cardinal);
    procedure DrawZoom(paper: TCanvas; X, Y, Index: Integer; Zoom: Real);
    procedure DrawZoomEx(paper: TCanvas; X, Y, Index: Integer; Zoom: Real; leftzero: Boolean); overload;
    procedure DrawZoomEx(ABitmap: TBitmap; DC: HDC; X, Y, Width, Height: Integer); overload;
    property Images[Index: Integer]: TTexture read GetCachedSurface;
    property Bitmaps[Index: Integer]: TBitmap read GetCachedBitmap;
    property FileName: string read FFileName write FFileName;
    property ImageCount: Integer read FImageCount write FImageCount;
    property Appr: Word read FAppr write FAppr;
    property BitCount: byte read FBitCount write FBitCount;
    property Initialized: Boolean read FInitialized write FInitialized;
    property LibType: TLibType read FLibType write FLibType;
  end;
implementation

constructor TGameImages.Create();
begin
  FLibType := ltUseCache;
  FInitialized := False;
  FBitCount := 8;
  FImageCount := 0;
  FAppr := 0;
  m_ImgArr := nil;
  IndexList := TList.Create;
  m_dwUseCheckTick := GetTickCount;
  m_dwMemChecktTick := GetTickCount;
end;

destructor TGameImages.Destroy;
begin
  Finalize;
  IndexList.Free;
  inherited;
end;

procedure TGameImages.Initialize;
begin

end;

procedure TGameImages.Finalize;
begin

end;

procedure TGameImages.ClearCache;
var
  I: Integer;
begin
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
  end;
  IndexList.Clear;
end;

function TGameImages.GetCachedSurface(Index: Integer): TTexture;
begin
  Result := nil;
end;

function TGameImages.GetCachedImage(Index: Integer; var px, py: Integer): TTexture;
begin
  Result := nil;
end;

function TGameImages.GetBitmap(Index: Integer; var PX, PY: Integer): TBitmap;
begin
  Result := nil;
end;

function TGameImages.GetCachedBitmap(Index: Integer): TBitmap;
begin
  Result := nil;
end;

procedure TGameImages.FreeOldMemorys(Index: Integer);
var
  I: Integer;
  nIndex, nCount: Integer;
  //dwTimeTick: longword;
begin
  //dwTimeTick := GetTickCount;
  if m_ImgArr <> nil then begin
    for I := IndexList.Count - 1 downto 0 do begin
      nIndex := Integer(IndexList.Items[I]);
      if (Index <> nIndex) and (nIndex >= 0) and (nIndex < FImageCount) then begin
        if (GetTickCount - m_ImgArr[nIndex].dwLatestTime > 60 * 1000 * 5) then begin
          IndexList.Delete(I);
          try
            if m_ImgArr[nIndex].Texture <> nil then
              FreeAndNil(m_ImgArr[nIndex].Texture);
          except
            m_ImgArr[nIndex].Texture := nil;
          end;
          try
            if m_ImgArr[nIndex].Bitmap <> nil then
              FreeAndNil(m_ImgArr[nIndex].Bitmap);
          except
            m_ImgArr[nIndex].Bitmap := nil;
          end;
          m_ImgArr[nIndex].Bitmap := nil;
          m_ImgArr[nIndex].Texture := nil;
        end;
      end;
    end;
  end;
end;

procedure TGameImages.FreeOldMemorys();
var
  I: Integer;
  nIndex: Integer;
  //dwTimeTick: longword;
begin
  //dwTimeTick := GetTickCount;
  if m_ImgArr <> nil then begin
    if (GetTickCount - m_dwFreeMemCheckTick > 10 * 1000) and (GetTickCount - m_dwUseCheckTick > 60 * 1000 * 5) then begin
      m_dwFreeMemCheckTick := GetTickCount;
      for I := IndexList.Count - 1 downto 0 do begin
        nIndex := Integer(IndexList.Items[I]);
        if (nIndex >= 0) and (nIndex < ImageCount) then begin
          if (GetTickCount - m_ImgArr[nIndex].dwLatestTime > 60 * 1000 * 5) then begin
            IndexList.Delete(I);
            try
              if m_ImgArr[nIndex].Texture <> nil then
                FreeAndNil(m_ImgArr[nIndex].Texture);
            except
              m_ImgArr[nIndex].Texture := nil;
            end;
            try
              if m_ImgArr[nIndex].Bitmap <> nil then
                FreeAndNil(m_ImgArr[nIndex].Bitmap);
            except
              m_ImgArr[nIndex].Bitmap := nil;
            end;
            m_ImgArr[nIndex].Bitmap := nil;
            m_ImgArr[nIndex].Texture := nil;
          end;
        end;
      end;
    end;
  end;
end;

procedure TGameImages.StretchBlt(Index: Integer; DC: HDC; X, Y: Integer; var Width, Height: Integer; ROP: Cardinal);
var
  ABitmap: TBitmap;
begin
  ABitmap := Bitmaps[Index];
  if ABitmap <> nil then begin
  // 缩放方式将 DIB Bits 写到设备环境
    if (ABitmap.Width > Width) or (ABitmap.Height > Height) then begin
      if ABitmap.Width > ABitmap.Height then begin
        Height := Round(Height * ABitmap.Height / ABitmap.Width);
      end else begin
        Width := Round(Width * ABitmap.Width / ABitmap.Height);
      end;
    end else begin
      Height := ABitmap.Height;
      Width := ABitmap.Width;
    end;
    DrawZoomEx(ABitmap, DC, X, Y, Width, Height);
  end;
end;

procedure TGameImages.DrawZoom(paper: TCanvas; X, Y, Index: Integer; Zoom: Real);
var
  rc: TRect;
  bmp: TBitmap;
begin
  bmp := Bitmaps[Index];
  if bmp <> nil then begin
    rc.Left := X;
    rc.Top := Y;
    rc.Right := X + Round(bmp.Width * Zoom);
    rc.Bottom := Y + Round(bmp.Height * Zoom);
    if (rc.Right > rc.Left) and (rc.Bottom > rc.Top) then begin
      paper.StretchDraw(rc, bmp);
    end;
  end;
end;

procedure TGameImages.DrawZoomEx(ABitmap: TBitmap; DC: HDC; X, Y, Width, Height: Integer);
var
  rc: TRect;
  bmp, bmp2: TBitmap;
begin
  //bmp := ABitmap;
  bmp := TBitmap.Create;
  bmp.Width := ABitmap.Width;
  bmp.Height := ABitmap.Height;
  bmp.Canvas.Draw(0, 0, ABitmap);
  //bmp.Assign(ABitmap);

  bmp2 := TBitmap.Create;
  bmp2.Width := Width;
  bmp2.Height := Height;
  rc.Left := X;
  rc.Top := Y;
  rc.Right := X + Width;
  rc.Bottom := Y + Height;

  if (rc.Right > rc.Left) and (rc.Bottom > rc.Top) then begin
    bmp2.Canvas.StretchDraw(Rect(0, 0, bmp2.Width, bmp2.Height), bmp);
    SpliteBitmap(DC, X, Y, bmp2, $0)
  end;

  bmp.Free;
  bmp2.Free;
end;

procedure TGameImages.DrawZoomEx(paper: TCanvas; X, Y, Index: Integer; Zoom: Real; leftzero: Boolean);
var
  nX, nY: integer;
  SrcP, DesP: Pointer;
  rc: TRect;
  bmp, bmp2: TBitmap;
begin
  bmp := Bitmaps[Index];
  if bmp <> nil then begin
    bmp2 := TBitmap.Create;
    bmp2.Width := Round(bmp.Width * Zoom);
    bmp2.Height := Round(bmp.Height * Zoom);
    bmp2.PixelFormat := pf32bit;
    rc.Left := X;
    rc.Top := Y;
    rc.Right := X + Round(bmp.Width * Zoom);
    rc.Bottom := Y + Round(bmp.Height * Zoom);

    if (rc.Right > rc.Left) and (rc.Bottom > rc.Top) then begin
      bmp2.Canvas.StretchDraw(Rect(0, 0, bmp2.Width, bmp2.Height), bmp);
      if leftzero then begin
        SpliteBitmap(paper.handle, X, Y, bmp2, $0)
      end else begin
        SpliteBitmap(paper.handle, X, Y - bmp2.Height, bmp2, $0);
      end;
    end;
    bmp2.Free;
  end;
end;

end.

