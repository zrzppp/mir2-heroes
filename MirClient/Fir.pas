unit Fir;

interface

uses
  Windows, Classes, Graphics, SysUtils, Controls, MapFiles, Textures, GameImages, DIB, ZlibEx,
  CompressUnit, CompressUnit1;

type
  TDataHeader = record //新定义的Data文件头
    Title: string[40];
    Size: Integer;
    ImageCount: Integer;
    IndexOffSet: Integer;
    BitCount: Word;
    Compression: Word;
  end;
  pTDataHeader = ^TDataHeader;

  TDataImageInfo = record //新定义Data图片信息
    nWidth: Smallint;
    nHeight: Smallint;
    Px: Smallint;
    Py: SmallInt;
    nSize: Integer; //数据大小
  end;
  pTDataImageInfo = ^TDataImageInfo;

  TLoadMode = (lmUseWil, lmUseData, lmAutoWil, lmAutoData);

  pTFirImages = ^TFirImages;
  TFirImages = class(TGameImages)
  private
    FCompress: Integer;
    FHeader: TDataHeader;
    function Comp(const InData: Pointer; InSize: LongInt; out OutData: Pointer): Integer;
    function UnComp(const InData: Pointer; InSize: LongInt; out OutData: Pointer): Integer;
    procedure LoadIndex();
    procedure LoadDxImage(Position: Integer; DXImage: pTDXImage);
    procedure LoadDxBitmap(Position: Integer; DXImage: pTDXImage);
  protected
    function GetCachedSurface(Index: Integer): TTexture; override;
    function GetCachedBitmap(Index: Integer): TBitmap; override;
  public
    m_IndexList: TList;
    m_FileStream: TFileStream; //TMapStream; //TFileStream;
    constructor Create(); override;
    destructor Destroy; override;
    procedure Initialize; override;
    procedure Finalize; override;
    function GetCachedImage(Index: Integer; var PX, PY: Integer): TTexture; override;
    function GetBitmap(Index: Integer; var PX, PY: Integer): TBitmap; override;
    property Compress: Integer read FCompress write FCompress;
  end;

implementation

procedure UnCompressRle(const InData: Pointer; InSize: LongInt; out OutData: Pointer; out OutSize: LongInt);
//function UnCompressRle(dbuf, sbuf: PByte; sbuflen: Integer): Integer;
var
  I, J, K, a: integer;
  wsbuf, wdbuf: PWordArray;
begin
  wsbuf := PWordArray(InData);
  wdbuf := PWordArray(OutData);
  J := 0;
  I := 0;
  while I < InSize div 2 do begin
    if (wsbuf[I] = $AAAA) then begin
      for K := 0 to wsbuf[I + 2] - 1 do begin
        wdbuf[J] := wsbuf[I + 1];
        Inc(J);
      end;
      Inc(I, 2);
    end else begin
      wdbuf[J] := wsbuf[I];
      Inc(J);
    end;
    Inc(I);
  end;
  OutSize := J * 2;
end;

procedure CompressRle(const InData: Pointer; InSize: LongInt; out OutData: Pointer; out OutSize: LongInt);
//function CompressRle(dbuf, sbuf: PByte; sbuflen: Integer): Integer; //RLE 又叫 Run Length Encoding 压缩
var
  I, J, K: integer;
  wsbuf, wdbuf: PWordArray;
  repeatCount: integer;
  repeatWord: word;
begin
  wsbuf := PWordArray(InData);
  wdbuf := PWordArray(OutData);
  repeatCount := 0;
  repeatWord := 0;
  J := 0;
  for I := 0 to InSize div 2 - 1 do begin
    if (wsbuf[I] = repeatWord) and (repeatCount < 60000) then Inc(repeatCount)
    else begin
      if (repeatCount > 3) then begin
        wdbuf[J] := $AAAA;
        Inc(J);
        wdbuf[J] := repeatWord;
        Inc(J);
        wdbuf[J] := repeatCount;
        Inc(J);
      end else
        if (repeatCount > 0) then begin
        for K := 0 to repeatCount - 1 do begin
          wdbuf[J] := repeatWord;
          Inc(J);
        end;
      end;
      repeatWord := wsbuf[I];
      repeatCount := 1;
    end;
    if (I = InSize div 2 - 1) then begin
      if (repeatCount > 3) then begin
        wdbuf[J] := $AAAA;
        Inc(J);
        wdbuf[J] := repeatWord;
        Inc(J);
        wdbuf[J] := repeatCount;
        Inc(J);
      end else
        if (repeatCount > 0) and (repeatWord = $AAAA) then begin
        wdbuf[J] := $AAAA;
        Inc(J);
        wdbuf[J] := repeatWord;
        Inc(J);
        wdbuf[J] := repeatCount;
        Inc(J);
      end else
        if (repeatCount > 0) then begin
        for K := 0 to repeatCount - 1 do begin
          wdbuf[J] := repeatWord;
          Inc(J);
        end;
      end;
    end;
  end;
  OutSize := J * 2;
end;

function ExtractFilePath(const FileName: string): string;
var
  I: integer;
begin
  I := LastDelimiter(PathDelim + DriveDelim, FileName);
  Result := Copy(FileName, 1, I);
end;

function ExtractFileNameOnly(const fname: string): string;
var
  extpos: integer;
  ext, fn: string;
begin
  ext := ExtractFileExt(fname);
  fn := ExtractFileName(fname);
  if ext <> '' then begin
    extpos := Pos(ext, fn);
    Result := Copy(fn, 1, extpos - 1);
  end else
    Result := fn;
end;

function _MIN(N1, N2: integer): integer;
begin
  if N1 < N2 then Result := N1
  else Result := N2;
end;

function _MAX(N1, N2: integer): integer;
begin
  if N1 > N2 then Result := N1
  else Result := N2;
end;

function IncPointer(P: Pointer; Size: Integer): Pointer;
begin
  Result := Pointer(Integer(P) + Size);
end;

constructor TFirImages.Create();
begin
  inherited;
  m_FileStream := nil;
  m_IndexList := TList.Create;
end;

destructor TFirImages.Destroy;
begin
  m_IndexList.Free;
  inherited;
end;

procedure TextOutStr(Msg: string);
var
  flname: string;
  fhandle: TextFile;
begin
  flname := '.\Text.txt';
  if FileExists(flname) then begin
    AssignFile(fhandle, flname);
    Append(fhandle);
  end else begin
    AssignFile(fhandle, flname);
    Rewrite(fhandle);
  end;
  Writeln(fhandle, TimeToStr(Time) + ' ' + Msg);
  CloseFile(fhandle);
end;

procedure TFirImages.Initialize;
begin
  if not Initialized then begin
    FileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.Data';
    if FileExists(FileName) then begin
      m_FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
      //m_FileStream := TMapStream.Create;
      //if m_FileStream.LoadFromFile(FileName) then begin
      BitCount := 16;
      m_FileStream.Read(FHeader, SizeOf(TDataHeader));
      ImageCount := FHeader.ImageCount;
      FCompress := FHeader.Compression;
      if FHeader.IndexOffSet = 0 then
        FHeader.IndexOffSet := SizeOf(TDataHeader);
      m_ImgArr := AllocMem(SizeOf(TDXImage) * ImageCount);

      LoadIndex();
      Initialized := True;
    end;
    //end;
  end;
end;

procedure TFirImages.Finalize;
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
    if m_FileStream <> nil then
      FreeAndNil(m_FileStream);
  end;
end;

procedure TFirImages.LoadIndex();
var
  I, Value: Integer;
  PValue: PInteger;
begin
  m_IndexList.Clear;
  m_FileStream.Position := FHeader.IndexOffSet;
  GetMem(PValue, ImageCount * SizeOf(Integer));
  m_FileStream.Read(PValue^, ImageCount * SizeOf(Integer));
  //PValue := IncPointer(m_FileStream.Memory, FHeader.IndexOffSet);
  for I := 0 to ImageCount - 1 do begin
    Value := PInteger(Integer(PValue) + SizeOf(Integer) * I)^;
    m_IndexList.Add(Pointer(Value));
  end;
  FreeMem(PValue);
end;


//=====================================压缩=====================================

function TFirImages.Comp(const InData: Pointer; InSize: LongInt; out OutData: Pointer): Integer;
begin
  case FCompress of
    1: CompressRle(InData, InSize, OutData, Result);
    2: CompressBufZ(InData, InSize, OutData, Result);
    3: CompressBufferL(InData, InSize, OutData, Result);
    4: CompBufferL(InData, InSize, OutData, Result);
  end;
end;

//====================================解压缩====================================

function TFirImages.UnComp(const InData: Pointer; InSize: LongInt; out OutData: Pointer): Integer;
begin
  case FCompress of
    1: UnCompressRle(InData, InSize, OutData, Result);
    2: DecompressBufZ(InData, InSize, 0, OutData, Result);
    3: UnCompressBufferL(InData, InSize, OutData, Result);
    4: UnCompBufferL(InData, InSize, OutData, Result);
  end;
end;

procedure TFirImages.LoadDxImage(Position: Integer; DXImage: pTDXImage);
const
  RGB565_MASK_RED = $F800;
  RGB555_MASK_RED = $07C0;
var
  ImageInfo: TDataImageInfo;

  nPitch: Integer;
  nWidth, nSize: Integer;

  I, J: Integer;
  S: Pointer;
  SrcP: PByte;
  DesP: Pointer;
  RGB: TRGBQuad;

  Source: TDIB;
begin
  m_FileStream.Position := Position;
  m_FileStream.Read(ImageInfo, SizeOf(TDataImageInfo));
  //ImageInfo := IncPointer(m_FileStream.Memory, Position);
  if (ImageInfo.nWidth * ImageInfo.nHeight <= 0) then Exit;

  DXImage.Texture := TTexture.Create;
  DXImage.Texture.SetSize(ImageInfo.nWidth, ImageInfo.nHeight);
  DXImage.nPx := ImageInfo.px;
  DXImage.nPy := ImageInfo.py;

  if Compress > 0 then begin
    GetMem(S, DXImage.Texture.Width * DXImage.Texture.Height * 2);
    GetMem(SrcP, ImageInfo.nSize);
    try
      DesP := S;
      m_FileStream.Read(SrcP^, ImageInfo.nSize);
      if ImageInfo.nWidth * ImageInfo.nHeight > 4 then begin
      //SrcP := IncPointer(ImageInfo, SizeOf(TDataImageInfo));
        nSize := UnComp(Pointer(SrcP), ImageInfo.nSize, Pointer(DesP)); //解压缩位图数据
      end else begin
        Move(SrcP^, DesP^, ImageInfo.nSize);
      end;
      FreeMem(SrcP);

      SrcP := S;
      for I := 0 to DXImage.Texture.Height - 1 do begin
        DesP := Pointer(Integer(DXImage.Texture.PBits) + I * DXImage.Texture.Pitch);
        Move(SrcP^, DesP^, DXImage.Texture.Width * 2);
        Inc(SrcP, DXImage.Texture.Width * 2);
      end;
    finally
      FreeMem(S);
    end;
  end else begin
    //SrcP := IncPointer(ImageInfo, SizeOf(TDataImageInfo));
    //for I := 0 to DXImage.Texture.Height - 1 do begin
      //DesP := Pointer(Integer(DXImage.Texture.PBits) + I * DXImage.Texture.Pitch);
      //Move(SrcP^, DesP^, DXImage.Texture.Width * 2);
      //Inc(SrcP, DXImage.Texture.Width * 2);
    //end;
    SrcP := DXImage.Texture.PBits;
    m_FileStream.Read(SrcP^, ImageInfo.nSize);
    {for I := 0 to DXImage.Texture.Height - 1 do begin
      SrcP := Pointer(Integer(DXImage.Texture.PBits) + I * DXImage.Texture.Pitch);
      m_FileStream.Read(SrcP^, DXImage.Texture.Width * 2);
    end;}
  end;
end;

procedure TFirImages.LoadDxBitmap(Position: Integer; DXImage: pTDXImage);
const
  RGB565_MASK_RED = $F800;
  RGB555_MASK_RED = $07C0;
var
  ImageInfo: TDataImageInfo;

  nPitch: Integer;
  nWidth, nSize: Integer;

  I, J: Integer;
  S: Pointer;
  SrcP: PByte;
  DesP: Pointer;
  RGB: TRGBQuad;

  Source: TDIB;
begin
  m_FileStream.Position := Position;
  m_FileStream.Read(ImageInfo, SizeOf(TDataImageInfo));
  //ImageInfo := IncPointer(m_FileStream.Memory, Position);
  if (ImageInfo.nWidth * ImageInfo.nHeight <= 0) then Exit;

  DXImage.Bitmap := TBitmap.Create;
  DXImage.Bitmap.Width := ImageInfo.nWidth;
  DXImage.Bitmap.Height := ImageInfo.nHeight;
  DXImage.Bitmap.PixelFormat := pf16bit;
  //DXImage.Bitmap.Canvas.FillRect(DXImage.Bitmap.Canvas.ClipRect);

  DXImage.nPx := ImageInfo.px;
  DXImage.nPy := ImageInfo.py;

  if Compress > 0 then begin
    GetMem(S, DXImage.Bitmap.Width * DXImage.Bitmap.Height * 2);
    GetMem(SrcP, ImageInfo.nSize);
    try
      DesP := S;
      m_FileStream.Read(SrcP^, ImageInfo.nSize);
      if ImageInfo.nWidth * ImageInfo.nHeight > 4 then begin
        nSize := UnComp(Pointer(SrcP), ImageInfo.nSize, Pointer(DesP)); //解压缩位图数据
      end else begin
        nSize := ImageInfo.nSize;
        Move(SrcP^, DesP^, ImageInfo.nSize);
      end;
      FreeMem(SrcP);

      SrcP := S;

      Source := TDIB.Create;
      Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
      Source.SetSize(ImageInfo.nWidth, ImageInfo.nHeight, 16);
      Source.Canvas.Brush.Color := clblack;
      Source.Canvas.FillRect(Source.Canvas.ClipRect);

      DesP := Source.PBits;
      Move(SrcP^, DesP^, nSize);
      Source.Mirror(False,True);
      DXImage.Bitmap.Canvas.Draw(0, 0, Source);
      Source.Free;

    finally
      FreeMem(S);
    end;
  end else begin
    //GetMem(SrcP, ImageInfo.nSize);
    Source := TDIB.Create;
    Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
    Source.SetSize(ImageInfo.nWidth, ImageInfo.nHeight, 16);
    Source.Canvas.Brush.Color := clblack;
    Source.Canvas.FillRect(Source.Canvas.ClipRect);
    SrcP := Source.PBits;
    m_FileStream.Read(SrcP^, ImageInfo.nSize);
    Source.Mirror(False,True);
    //Move(SrcP^, DesP^, ImageInfo.nSize);
    //FreeMem(SrcP);

    DXImage.Bitmap.Canvas.Draw(0, 0, Source);
    Source.Free;


    //SrcP := IncPointer(ImageInfo, SizeOf(TDataImageInfo));
    //for I := 0 to DXImage.Bitmap.Height - 1 do begin
    //  DesP := DXImage.Bitmap.ScanLine[I];
    //  Move(SrcP^, DesP^, DXImage.Bitmap.Width * 2);
    //  Inc(SrcP, DXImage.Bitmap.Width * 2);
    //end;
    {for I := 0 to DXImage.Bitmap.Height - 1 do begin
      SrcP := DXImage.Bitmap.ScanLine[I];
      m_FileStream.Read(SrcP^, DXImage.Bitmap.Width * 2);
    end; }
  end;
end;

function TFirImages.GetCachedBitmap(Index: Integer): TBitmap;
var
  nPosition: Integer;
  nErrCode: Integer;
begin
  Result := nil;
  try
    nErrCode := 0;
    if (Index >= 0) and (Index < ImageCount) and (m_FileStream <> nil) and (Initialized) then begin

      if GetTickCount - m_dwMemChecktTick > 1000 * 5 then begin
        m_dwMemChecktTick := GetTickCount;
        FreeOldMemorys(Index);
      end;

      nErrCode := 4;
      if m_ImgArr[Index].Bitmap = nil then begin
        nErrCode := 5;
        if Index < m_IndexList.Count then begin
          IndexList.Add(Pointer(Index));
          nErrCode := 6;
          nPosition := Integer(m_IndexList[Index]);
          nErrCode := 7;
          LoadDxBitmap(nPosition, @m_ImgArr[Index]);
          nErrCode := 8;
          m_ImgArr[Index].dwLatestTime := GetTickCount;
          Result := m_ImgArr[Index].Bitmap;
        end;
      end else begin
        m_ImgArr[Index].dwLatestTime := GetTickCount;
        Result := m_ImgArr[Index].Bitmap;
      end;
    end;
  except
    Result := nil;
  end;
end;

function TFirImages.GetCachedSurface(Index: Integer): TTexture;
var
  nPosition: Integer;
  nErrCode: Integer;
begin
  Result := nil;
  try
    nErrCode := 0;

    if (Index >= 0) and (Index < ImageCount) and (m_FileStream <> nil) and (Initialized) then begin
      if GetTickCount - m_dwMemChecktTick > 1000 * 5 then begin
        m_dwMemChecktTick := GetTickCount;
        FreeOldMemorys(Index);
      end;

      nErrCode := 4;
      if m_ImgArr[Index].Texture = nil then begin
        nErrCode := 5;
        if Index < m_IndexList.Count then begin
          IndexList.Add(Pointer(Index));
          nErrCode := 6;
          nPosition := Integer(m_IndexList[Index]);
          nErrCode := 7;

          LoadDxImage(nPosition, @m_ImgArr[Index]);

          nErrCode := 8;
          m_ImgArr[Index].dwLatestTime := GetTickCount;
          Result := m_ImgArr[Index].Texture;
        end;
      end else begin
        m_ImgArr[Index].dwLatestTime := GetTickCount;
        Result := m_ImgArr[Index].Texture;
      end;
    end;
  except
    Result := nil;
      //DebugOutStr('TFirImages.GetCachedSurface Index: ' + IntToStr(Index) + ' Error Code: ' + IntToStr(nErrCode));
  end;
end;

function TFirImages.GetCachedImage(Index: Integer; var PX, PY: Integer): TTexture;
var
  nPosition: Integer;
  nErrCode: Integer;
begin
  Result := nil;
  try
    nErrCode := 0;
    if (Index >= 0) and (Index < ImageCount) and (m_FileStream <> nil) and (Initialized) then begin
      nErrCode := 1;
      if GetTickCount - m_dwMemChecktTick > 1000 * 5 then begin
        m_dwMemChecktTick := GetTickCount;
        nErrCode := 2;
        FreeOldMemorys(Index);
        nErrCode := 3;
      end;
      nErrCode := 4;
      if m_ImgArr[Index].Texture = nil then begin
        nErrCode := 5;
        if Index < m_IndexList.Count then begin
          IndexList.Add(Pointer(Index));
          nErrCode := 6;
          nPosition := Integer(m_IndexList[Index]);
          nErrCode := 7;
          if LibType = ltUseCache then begin
            LoadDxImage(nPosition, @m_ImgArr[Index]);
          end else begin
            LoadDxBitmap(nPosition, @m_ImgArr[Index]);
          end;
          nErrCode := 8;
          m_ImgArr[Index].dwLatestTime := GetTickCount;
          PX := m_ImgArr[Index].nPx;
          PY := m_ImgArr[Index].nPy;
          Result := m_ImgArr[Index].Texture;
        end;
      end else begin
        m_ImgArr[Index].dwLatestTime := GetTickCount;
        PX := m_ImgArr[Index].nPx;
        PY := m_ImgArr[Index].nPy;
        Result := m_ImgArr[Index].Texture;
      end;
    end;
  except
    Result := nil;
  end;
end;

function TFirImages.GetBitmap(Index: Integer; var PX, PY: Integer): TBitmap;
var
  nPosition: Integer;
  nErrCode: Integer;
begin
  Result := nil;
  try
    nErrCode := 0;
    if (Index >= 0) and (Index < ImageCount) and (m_FileStream <> nil) and (Initialized) then begin
      nErrCode := 1;
      if GetTickCount - m_dwMemChecktTick > 1000 * 5 then begin
        m_dwMemChecktTick := GetTickCount;
        nErrCode := 2;
        FreeOldMemorys(Index);
        nErrCode := 3;
      end;
      nErrCode := 4;
      if m_ImgArr[Index].Bitmap = nil then begin
        nErrCode := 5;
        if Index < m_IndexList.Count then begin
          IndexList.Add(Pointer(Index));
          nErrCode := 6;
          nPosition := Integer(m_IndexList[Index]);
          nErrCode := 7;

          LoadDxBitmap(nPosition, @m_ImgArr[Index]);

          nErrCode := 8;
          m_ImgArr[Index].dwLatestTime := GetTickCount;
          PX := m_ImgArr[Index].nPx;
          PY := m_ImgArr[Index].nPy;
          Result := m_ImgArr[Index].Bitmap;
        end;
      end else begin
        m_ImgArr[Index].dwLatestTime := GetTickCount;
        PX := m_ImgArr[Index].nPx;
        PY := m_ImgArr[Index].nPy;
        Result := m_ImgArr[Index].Bitmap;
      end;
    end;
  except
    Result := nil;
  end;
end;

end.

