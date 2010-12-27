unit Wil;

interface

uses
  Windows, Classes, Graphics, SysUtils, Controls, MapFiles, Textures, GameImages, DIB;

type
  TWMImageHeader = record
    Title: string[40]; //'WEMADE Entertainment inc.'
    ImageCount: Integer;
    ColorCount: Integer;
    PaletteSize: Integer;
    VerFlag: Integer;
  end;

  PTWMImageHeader = ^TWMImageHeader;
  TWMImageInfo = record
    nWidth: SmallInt;
    nHeight: SmallInt;
    px: SmallInt;
    py: SmallInt;
    bits: PByte;
  end;
  PTWMImageInfo = ^TWMImageInfo;

  TWMIndexHeader = record
    Title: string[40]; //'WEMADE Entertainment inc.'
    IndexCount: integer;
    VerFlag: integer;
  end;

  PTWMIndexHeader = ^TWMIndexHeader;

  TWMIndexInfo = record
    Position: Integer;
    Size: Integer;
  end;
  PTWMIndexInfo = ^TWMIndexInfo;

  pTWilImages = ^TWilImages;
  TWilImages = class(TGameImages)

  private
    btVersion: Byte;

    FHeader: TWMImageHeader;

    procedure LoadPalette;

    procedure LoadIndex(sIdxFile: string);
    procedure LoadDxImage(Position: Integer; DXImage: pTDXImage);
    procedure LoadDxBitmap(Position: Integer; DXImage: pTDXImage);
  protected
    function GetCachedSurface(Index: Integer): TTexture; override;
    function GetCachedBitmap(Index: Integer): TBitmap; override;
  public
    m_IndexList: TList;
    m_FileStream: TFileStream; //TMapStream; //TFileStream;
    MainPalette: TRGBQuads;

    constructor Create(); override;
    destructor Destroy; override;
    procedure Initialize; override;
    procedure Finalize; override;
    function GetCachedImage(Index: Integer; var PX, PY: Integer): TTexture; override;
    function GetBitmap(Index: Integer; var PX, PY: Integer): TBitmap; override;
  end;
implementation
//uses Share;

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

constructor TWilImages.Create();
begin
  inherited;
  //FLoadMode := lmAutoWil;
  btVersion := 0;
  m_FileStream := nil;
  m_IndexList := TList.Create;
end;

destructor TWilImages.Destroy;
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

procedure TWilImages.Initialize;
var
  idxfile, sFileName, sFileExt: string;
begin
  if not Initialized then begin
    if FileExists(FileName) then begin
      m_FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);

      m_FileStream.Read(FHeader, SizeOf(TWMImageHeader));
      if (FHeader.VerFlag = 0) or (FHeader.ColorCount = 65536) then begin
        btVersion := 1;
        m_FileStream.Seek(-4, soFromCurrent);
      end;

      case FHeader.ColorCount of
        256: BitCount := 8;
        65536: BitCount := 16;
        16777216: BitCount := 24;
      else BitCount := 32;
      end;

      ImageCount := FHeader.ImageCount;

      m_ImgArr := AllocMem(SizeOf(TDXImage) * ImageCount);

      idxfile := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.WIX';
      LoadPalette;

      LoadIndex(idxfile);
      Initialized := True;
    end;
  end;
end;

procedure TWilImages.Finalize;
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

procedure TWilImages.LoadPalette;
begin
  if btVersion <> 0 then
    m_FileStream.Seek(SizeOf(TWMImageHeader) - 4, 0)
  else
    m_FileStream.Seek(SizeOf(TWMImageHeader), 0);

  m_FileStream.Read(MainPalette, SizeOf(TRGBQuad) * 256);
end;

procedure TWilImages.LoadIndex(sIdxFile: string);
var
  FHandle, I, Value: integer;
  Header: TWMIndexHeader;
  PValue: PInteger;
begin
  m_IndexList.Clear;
  if FileExists(sIdxFile) then begin
    FHandle := FileOpen(sIdxFile, fmOpenRead or fmShareDenyNone);
    if FHandle > 0 then begin
      if btVersion <> 0 then
        FileRead(FHandle, Header, SizeOf(TWMIndexHeader) - 4)
      else
        FileRead(FHandle, Header, SizeOf(TWMIndexHeader));

      GetMem(PValue, 4 * Header.IndexCount);
      FileRead(FHandle, PValue^, 4 * Header.IndexCount);
      for I := 0 to Header.IndexCount - 1 do begin
        Value := PInteger(Integer(PValue) + 4 * I)^;
        m_IndexList.Add(Pointer(Value));
      end;
      FreeMem(PValue);
      FileClose(FHandle);
    end;
  end;
end;

{----------------- Private Variables ---------------------}

function WidthBytes(w: integer): integer;
begin
  Result := (((w * 8) + 31) div 32) * 4;
end;

procedure TWilImages.LoadDxImage(Position: Integer; DXImage: pTDXImage);
const
  RGB565_MASK_RED = $F800;
  RGB555_MASK_RED = $07C0;
var
  ImageInfo: TWMImageInfo;

  nPitch: Integer;
  nWidth, nSize: Integer;

  I, J: Integer;
  S: Pointer;
  SrcP: PByte;
  DesP: Pointer;
  RGB: TRGBQuad;

  Source: TDIB;
begin
  //try
  m_FileStream.Position := Position;
  if btVersion <> 0 then m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo) - 4)
  else m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo));
  if ImageInfo.nWidth * ImageInfo.nHeight <= 0 then Exit;

  if BitCount = 8 then
    nSize := WidthBytes(ImageInfo.nWidth) * ImageInfo.nHeight
  else
    nSize := ImageInfo.nWidth * ImageInfo.nHeight * (BitCount div 8);

  GetMem(S, nSize);
  m_FileStream.Read(S^, nSize);
  SrcP := S;

    //ImageInfo := IncPointer(m_FileStream.Memory, Position);
    //if ImageInfo.nWidth * ImageInfo.nHeight <= 0 then Exit;
    //if btVersion <> 0 then SrcP := IncPointer(ImageInfo, SizeOf(TWMImageInfo) - 4)
    //else SrcP := IncPointer(ImageInfo, SizeOf(TWMImageInfo));

  case BitCount of
    8: begin
        try
          Source := TDIB.Create;
          Source.SetSize(WidthBytes(ImageInfo.nWidth), ImageInfo.nHeight, 8);
          Source.ColorTable := MainPalette;
          Source.UpdatePalette;
          Source.Canvas.Brush.Color := clblack;
          Source.Canvas.FillRect(Source.Canvas.ClipRect);

          DesP := Source.PBits;
          Move(SrcP^, DesP^, nSize);

          DXImage.Texture := TTexture.Create;
          DXImage.Texture.SetSize(Source.Width, Source.Height);
          DXImage.nPx := ImageInfo.px;
          DXImage.nPy := ImageInfo.py;

          for I := 0 to DXImage.Texture.Height - 1 do begin //256色数据转换成16位数据
              //DesP := PWord(Integer(DXImage.Texture.PBits) + DXImage.Texture.Pitch * (DXImage.Texture.Height - 1 - I));
              //DesP := PWord(Integer(DXImage.Texture.PBits) + DXImage.Texture.Pitch * I);
            DesP := DXImage.Texture.ScanLine[I];
            SrcP := Source.ScanLine[I];
            for J := 0 to DXImage.Texture.Width - 1 do begin
              RGB := MainPalette[SrcP^];
              if Integer(RGB) = 0 then begin
                PWord(DesP)^ := 0;
              end else begin
                PWord(DesP)^ := Word((_Max(RGB.rgbRed and $F8, 8) shl 8) or (_Max(RGB.rgbGreen and $FC, 8) shl 3) or (_Max(RGB.rgbBlue and $F8, 8) shr 3)); //565格式
                  //PWord(DesP)^ := RGBColors[RGB.rgbRed, RGB.rgbGreen, RGB.rgbBlue];
              end;
              Inc(SrcP);
              Inc(PWord(DesP));
            end;
          end;

        finally
          Source.Free;
        end;
      end;
    16: begin
        try
          Source := TDIB.Create;
          Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
          Source.SetSize(ImageInfo.nWidth, ImageInfo.nHeight, 16);
          DesP := Source.PBits;
          Move(SrcP^, DesP^, nSize);

            {for I := 0 to Source.Height - 1 do begin
              DesP := Pointer(Integer(Source.PBits) + I * Source.WidthBytes);
              Move(SrcP^, DesP^, ImageInfo.nWidth * 2);
              Inc(SrcP, ImageInfo.nWidth * 2);
            end;}

          DXImage.Texture := TTexture.Create;
          DXImage.nPx := ImageInfo.px;
          DXImage.nPy := ImageInfo.py;

          DXImage.Texture.LoadFromDIB(Source);

        finally
          Source.Free;
        end;
         { DXImage.Texture := TTexture.Create;
          DXImage.Texture.SetSize(WidthBytes(ImageInfo.nWidth), ImageInfo.nHeight);
          DXImage.nPx := ImageInfo.px;
          DXImage.nPy := ImageInfo.py;
          Move(SrcP^, DXImage.Texture.PBits^, nSize); }
          {for I := 0 to DXImage.Texture.Height - 1 do begin
            DesP := Pointer(Integer(DXImage.Texture.PBits) + (DXImage.Texture.Height - 1 - I) * DXImage.Texture.Pitch);
            Move(SrcP^, DesP^, ImageInfo.nWidth * 2);
            Inc(SrcP, ImageInfo.nWidth * 2);
          end;}
      end;
    24: begin
        try
          Source := TDIB.Create;
          Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
          Source.SetSize(ImageInfo.nWidth, ImageInfo.nHeight, 24);

          DesP := Source.PBits;
          Move(SrcP^, DesP^, nSize);

            {for I := 0 to Source.Height - 1 do begin
              DesP := Pointer(Integer(Source.PBits) + I * Source.WidthBytes);
              Move(SrcP^, DesP^, ImageInfo.nWidth * 3);
              Inc(SrcP, ImageInfo.nWidth * 3);
            end;}

          DXImage.Texture := TTexture.Create;
          DXImage.nPx := ImageInfo.px;
          DXImage.nPy := ImageInfo.py;

          DXImage.Texture.LoadFromDIB(Source);
        finally
          Source.Free;
        end;
      end;
    32: begin
        try
          Source := TDIB.Create;
          Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
          Source.SetSize(ImageInfo.nWidth, ImageInfo.nHeight, 32);

          DesP := Source.PBits;
          Move(SrcP^, DesP^, nSize);

           { for I := 0 to Source.Height - 1 do begin
              DesP := Pointer(Integer(Source.PBits) + I * Source.WidthBytes);
              Move(SrcP^, DesP^, ImageInfo.nWidth * 4);
              Inc(SrcP, ImageInfo.nWidth * 4);
            end;}

          DXImage.Texture := TTexture.Create;
          DXImage.nPx := ImageInfo.px;
          DXImage.nPy := ImageInfo.py;

          DXImage.Texture.LoadFromDIB(Source);
        finally
          Source.Free;
        end;
      end;
  end;
  FreeMem(S);
  //except

  //end;
end;

procedure TWilImages.LoadDxBitmap(Position: Integer; DXImage: pTDXImage);
const
  RGB565_MASK_RED = $F800;
  RGB555_MASK_RED = $07C0;
var
  ImageInfo: TWMImageInfo;

  nPitch: Integer;
  nWidth, nSize: Integer;

  I, J: Integer;
  S: Pointer;
  SrcP: PByte;
  DesP: Pointer;
  RGB: TRGBQuad;

  Source: TDIB;
begin
  //try
  m_FileStream.Position := Position;
  if btVersion <> 0 then m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo) - 4)
  else m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo));
  if ImageInfo.nWidth * ImageInfo.nHeight <= 0 then Exit;

  if BitCount = 8 then
    nSize := WidthBytes(ImageInfo.nWidth) * ImageInfo.nHeight
  else
    nSize := ImageInfo.nWidth * ImageInfo.nHeight * (BitCount div 8);

  GetMem(S, nSize);
  m_FileStream.Read(S^, nSize);
  SrcP := S;

    //ImageInfo := IncPointer(m_FileStream.Memory, Position);
    //if ImageInfo.nWidth * ImageInfo.nHeight <= 0 then Exit;
    //if btVersion <> 0 then SrcP := IncPointer(ImageInfo, SizeOf(TWMImageInfo) - 4)
    //else SrcP := IncPointer(ImageInfo, SizeOf(TWMImageInfo));

  case BitCount of
    8: begin
        try
          Source := TDIB.Create;
          Source.SetSize(WidthBytes(ImageInfo.nWidth), ImageInfo.nHeight, 8);
          Source.ColorTable := MainPalette;
          Source.UpdatePalette;
          Source.Canvas.Brush.Color := clblack;
          Source.Canvas.FillRect(Source.Canvas.ClipRect);

          DesP := Source.PBits;
          Move(SrcP^, DesP^, nSize);

          Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);

          DXImage.Bitmap := TBitmap.Create;
          DXImage.Bitmap.Width := Source.Width;
          DXImage.Bitmap.Height := Source.Height;
          DXImage.Bitmap.PixelFormat := pf16bit;

          DXImage.nPx := ImageInfo.px;
          DXImage.nPy := ImageInfo.py;

          DXImage.Bitmap.Canvas.Draw(0, 0, Source);
          {for I := DXImage.Bitmap.Height - 1 downto 0 do begin
            DesP := DXImage.Bitmap.ScanLine[I];
            SrcP := Source.ScanLine[I];
            Move(SrcP^, DesP^, Source.WidthBytes);
            Inc(SrcP, Source.WidthBytes);
          end;  }

            {for I := 0 to DXImage.Bitmap.Height - 1 do begin //256色数据转换成16位数据
              //DesP := PWord(Integer(DXImage.Texture.PBits) + DXImage.Texture.Pitch * (DXImage.Texture.Height - 1 - I));
              //DesP := PWord(Integer(DXImage.Texture.PBits) + DXImage.Texture.Pitch * I);
              //DesP := DXImage.Texture.ScanLine[I];
              DesP := DXImage.Bitmap.ScanLine[I];
              SrcP := Source.ScanLine[I];
              for J := 0 to DXImage.Texture.Width - 1 do begin
                RGB := MainPalette[SrcP^];
                if Integer(RGB) = 0 then begin
                  PWord(DesP)^ := 0;
                end else begin
                  PWord(DesP)^ := Word((_Max(RGB.rgbRed and $F8, 8) shl 8) or (_Max(RGB.rgbGreen and $FC, 8) shl 3) or (_Max(RGB.rgbBlue and $F8, 8) shr 3)); //565格式
                end;
                Inc(SrcP);
                Inc(PWord(DesP));
              end;
            end;}

        finally
          Source.Free;
        end;

          {
          DXImage.Bitmap := TBitmap.Create;
          DXImage.Bitmap.Width := WidthBytes(ImageInfo.nWidth);
          DXImage.Bitmap.Height := ImageInfo.nHeight;
          DXImage.Bitmap.PixelFormat := pf16bit;
          DXImage.nPx := ImageInfo.px;
          DXImage.nPy := ImageInfo.py;

          for I := DXImage.Bitmap.Height - 1 downto 0 do begin //256色数据转换成16位数据
            DesP := PWord(DXImage.Bitmap.ScanLine[I]);
            for J := 0 to DXImage.Bitmap.Width - 1 do begin
              RGB := MainPalette[SrcP^];
              if Integer(RGB) = 0 then begin
                PWord(DesP)^ := 0;
              end else begin
                PWord(DesP)^ := Word((_Max(RGB.rgbRed and $F8, 8) shl 8) or (_Max(RGB.rgbGreen and $FC, 8) shl 3) or (_Max(RGB.rgbBlue and $F8, 8) shr 3)); //565格式
              end;
              Inc(SrcP);
              Inc(PWord(DesP));
            end;
          end;
          }
      end;
    16: begin
        Source := TDIB.Create;
        Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
        Source.SetSize(ImageInfo.nWidth, ImageInfo.nHeight, 16);
        Source.Canvas.Brush.Color := clblack;
        Source.Canvas.FillRect(Source.Canvas.ClipRect);

        DesP := Source.PBits;
        Move(SrcP^, DesP^, nSize);


        DXImage.Bitmap := TBitmap.Create;
        DXImage.Bitmap.Width := ImageInfo.nWidth;
        DXImage.Bitmap.Height := ImageInfo.nHeight;
        DXImage.Bitmap.PixelFormat := pf16bit;
        DXImage.nPx := ImageInfo.px;
        DXImage.nPy := ImageInfo.py;
        DXImage.Bitmap.Canvas.Draw(0, 0, Source);

        Source.Free;
       { for I := DXImage.Bitmap.Height - 1 downto 0 do begin
          DesP := DXImage.Bitmap.ScanLine[I];
          Move(SrcP^, DesP^, ImageInfo.nWidth * 2);
          Inc(SrcP, ImageInfo.nWidth * 2);
        end;}
      end;
    24: begin
        Source := TDIB.Create;
        Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
        Source.SetSize(ImageInfo.nWidth, ImageInfo.nHeight, 24);
        Source.Canvas.Brush.Color := clblack;
        Source.Canvas.FillRect(Source.Canvas.ClipRect);

        DesP := Source.PBits;
        Move(SrcP^, DesP^, nSize);

        DXImage.Bitmap := TBitmap.Create;
        DXImage.Bitmap.Width := ImageInfo.nWidth;
        DXImage.Bitmap.Height := ImageInfo.nHeight;
        DXImage.Bitmap.PixelFormat := pf24bit;
        DXImage.nPx := ImageInfo.px;
        DXImage.nPy := ImageInfo.py;
        DXImage.Bitmap.Canvas.Draw(0, 0, Source);

        Source.Free;
       { for I := DXImage.Bitmap.Height - 1 downto 0 do begin
          DesP := DXImage.Bitmap.ScanLine[I];
          Move(SrcP^, DesP^, ImageInfo.nWidth * 3);
          Inc(SrcP, ImageInfo.nWidth * 3);
        end;  }
      end;
    32: begin
        Source := TDIB.Create;
        Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
        Source.SetSize(ImageInfo.nWidth, ImageInfo.nHeight, 32);
        Source.Canvas.Brush.Color := clblack;
        Source.Canvas.FillRect(Source.Canvas.ClipRect);
        DXImage.Bitmap := TBitmap.Create;
        DXImage.Bitmap.Width := ImageInfo.nWidth;
        DXImage.Bitmap.Height := ImageInfo.nHeight;
        DXImage.Bitmap.PixelFormat := pf32bit;
        DXImage.nPx := ImageInfo.px;
        DXImage.nPy := ImageInfo.py;
        DXImage.Bitmap.Canvas.Draw(0, 0, Source);

        Source.Free;
        {for I := DXImage.Bitmap.Height - 1 downto 0 do begin
          DesP := DXImage.Bitmap.ScanLine[I];
          Move(SrcP^, DesP^, ImageInfo.nWidth * 4);
          Inc(SrcP, ImageInfo.nWidth * 4);
        end; }
      end;
  end;
  FreeMem(S);
  //except

  //end;
end;

function TWilImages.GetCachedBitmap(Index: Integer): TBitmap;
var
  nPosition: integer;
  nErrCode: integer;
  Name: string;
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

function TWilImages.GetCachedSurface(Index: Integer): TTexture;
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
      //DebugOutStr('TWilImages.GetCachedSurface Index: ' + IntToStr(Index) + ' Error Code: ' + IntToStr(nErrCode));
  end;
end;

function TWilImages.GetCachedImage(Index: Integer; var PX, PY: Integer): TTexture;
var
  nPosition: integer;
  nErrCode: integer;
  Name: string;
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

function TWilImages.GetBitmap(Index: Integer; var PX, PY: Integer): TBitmap;
var
  nPosition: integer;
  nErrCode: integer;
  Name: string;
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

