unit Wis;

interface
uses
  Windows, Classes, Graphics, SysUtils, Controls, DIB, Textures, GameImages, MapFiles;
type
  TWisFileHeaderInfo = packed record
    nTitle: Integer; //04 $41534957 = WISA
    VerFlag: Integer; //01
    Reserve1: Integer; //00
    DateTime: TDateTime;
    Reserve2: Integer;
    Reserve3: Integer;
    CopyRight: string[20];
    aTemp1: array[1..107] of Char;
    nHeaderEncrypt: Integer; //0XA0
    nHeaderLen: Integer; //0XA4
    nImageCount: Integer; //0XA8
    nHeaderData: Integer; //0XAC

    aTemp2: array[1..$200 - $AC] of Char;
  end;
  PWisFileHeaderInfo = ^TWisFileHeaderInfo;

  TWisHeader = packed record
    OffSet: Integer;
    Length: Integer;
    temp3: Integer;
  end;
  PTWisHeader = ^TWisHeader;
  TWisFileHeaderArray = array of TWisHeader;

  TImgInfo = packed record
    btEncr0: Byte; //0X00
    btEncr1: Byte; //0X01
    bt2: Byte; //0X02
    bt3: Byte; //0X03
    wW: Smallint; //0X04
    wH: Smallint; //0X06
    wPx: Smallint; //0X08
    wPy: Smallint; //0X0A
  end;
  PTImgInfo = ^TImgInfo;

  TWisImages = class(TGameImages)
  private
    FIndexOffset: Integer;
    FileHeader: TWisFileHeaderInfo;
    FileStream: TFileStream; //TMapStream; //
    IndexArray: TWisFileHeaderArray;
    function Decode(ASrc: PByte; DIB: TDIB; ASrcSize: Integer): Integer;
    function DecodeWis(ASrc, ADst: PByte; ASrcSize, ADstSize: Integer): Boolean;
    function LoadIndex: Boolean;
    function GetDIB(Index: Integer): TDIB;
    function Get(Index: Integer; var PX, PY: Smallint): TDIB;
    procedure LoadDxImage(WisHeader: PTWisHeader; DXImage: pTDXImage);
  protected
    function GetCachedSurface(Index: Integer): TTexture; override;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Initialize; override;
    procedure Finalize; override;
    function GetCachedImage(Index: Integer; var PX, PY: Integer): TTexture; override;
    property Items[Index: Integer]: TDIB read GetDIB;
  end;

implementation
uses Math; //, MShare;    , Share
var
  MainPalette: TRGBQuads; // array[0..255] of TRGBQuad;

function SGL_RLE8_Decode(ASrc, ADst: PByte; ASrcSize,
  ADstSize: Integer): Boolean;
var
  L, I: Byte;
begin
  while (ASrcSize > 0) and (ADstSize > 0) do begin
    if (PByte(ASrc)^ and $80) = 0 then begin //0..127
      L := ASrc^;
      Inc(ASrc);
      Dec(ASrcSize, 2);
      if L > ADstSize then L := ADstSize;
      Dec(ADstSize, L);
      for I := 1 to L do
      begin
        ADst^ := ASrc^;
        Inc(ADst);
      end;
      Inc(ASrc);
    end else begin
      L := PByte(ASrc)^ and $7F;
      Inc(PByte(ASrc));
      Dec(ASrcSize, L + 1);
      if L > ADstSize then L := ADstSize;
      Dec(ADstSize, L);
      for I := 1 to L do begin
        ADst^ := ASrc^;
        Inc(ADst);
        Inc(ASrc);
      end;
    end;
  end;
  Result := True;
end;

function TWisImages.Decode(ASrc: PByte; DIB: TDIB; ASrcSize: Integer): Integer;
var
  V, Len, Len1, I: Byte;
  ADstSize: Integer;
  boSkip: Boolean;
  X, Y: Integer;

  function WritePixel(Color: Byte): Boolean;
  var
    Row: PByteArray;
  begin
    if X = DIB.Height then begin
      Result := True;
      Exit;
    end;
    Row := DIB.ScanLine[X];
    Row[Y] := Color;
    Y := Y + 1;
    Result := False;
    if Y = DIB.Width then begin
      Y := 0;
      X := X + 1;
      Result := True;
    end;
  end;
begin
  Result := 0;
  Len := 0;
  Len1 := 0;
  X := 0;
  Y := 0;
  ADstSize := 0;
  boSkip := False;
  while ADstSize < ASrcSize do begin
    if not boSkip then begin
      V := ASrc^;
      Inc(PByte(ASrc));
      Inc(Result);
    end;
    if (V = 0) and (Len <= 0) then begin
      V := ASrc^;
      Len := V;
      Inc(PByte(ASrc));
      Inc(Result);
      boSkip := True;
    end;
    if boSkip then begin
      if Len <> 0 then begin
        Inc(ADstSize, Len);
        Inc(Result, Len);
        //Move(ASrc^, ADst^, Len);
        for I := 1 to Len do begin
          WritePixel(ASrc^);
          Inc(PByte(ASrc));
        end;
        //Inc(PByte(ASrc), Len);
        //Inc(PByte(ADst), Len);
        Len := 0;
      end else begin
        boSkip := False;
      end;
    end else begin
      Len1 := V;
      Inc(Result);
      Inc(ADstSize, Len1);
      for I := 1 to Len1 do begin
        WritePixel(ASrc^);
        //ADst^ := ASrc^;
        //Inc(PByte(ADst));
      end;
      Inc(PByte(ASrc));
      Len1 := 0;
    end;
  end;
end;

function TWisImages.DecodeWis(ASrc, ADst: PByte; ASrcSize,
  ADstSize: Integer): Boolean;
var
  V, Len, L, I: Byte;
  boSkip: Boolean;
begin
  Result := False;
  boSkip := False;
  Len := 0;
  L := 0;
  while (ASrcSize > 0) and (ADstSize > 0) do begin
    if not boSkip then begin
      V := ASrc^;
      Dec(ASrcSize);
      Inc(PByte(ASrc));
    end;
    if (V = 0) and (Len <= 0) then begin
      V := ASrc^;
      Len := V;
      Dec(ASrcSize);
      Inc(PByte(ASrc));
      boSkip := True;
    end;
    if boSkip then begin
      if Len <> 0 then begin
        Dec(ADstSize, Len);
        Dec(ASrcSize, Len);
        Move(ASrc^, ADst^, Len);
        Inc(PByte(ADst), Len);
        Inc(PByte(ASrc), Len);
      end else begin
        boSkip := False;
      end;
      Len := 0;
    end else begin
      L := V;
      Dec(ASrcSize);
      Dec(ADstSize, L);
      V := ASrc^;
      Inc(PByte(ASrc));
      for I := 1 to L do begin
        ADst^ := V;
        Inc(ADst);
      end;
      L := 0;
    end;
  end;

  Result := True;
end;

constructor TWisImages.Create();
begin
  inherited;
  FileStream := nil;
  IndexArray := nil;
end;

destructor TWisImages.Destroy;
begin
  inherited;
end;

procedure TWisImages.Initialize;
begin
  if not Initialized then begin
    if FileExists(FileName) then begin
      //FileStream := TMapStream.Create(FileName);
      //FileStream.Active := True;

      if LoadIndex then begin
        FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
        //if FileStream = nil then
          //FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
        //FileStream.Read(FileHeader, SizeOf(TWisFileHeaderInfo));
        m_ImgArr := AllocMem(SizeOf(TDXImage) * ImageCount);
        Initialized := True;
      end;
    end;
  end;
end;

procedure TWisImages.Finalize;
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
    IndexArray := nil;
    ImageCount := 0;
    if FileStream <> nil then
      FreeAndNil(FileStream);
  end;
end;

function TWisImages.LoadIndex: Boolean;
  function DecPointer(P: Pointer; Size: Integer): Pointer;
  begin
    Result := Pointer(Integer(P) - Size);
  end;
var
  iFileOffset, nIndex, nIndexOffset: Integer;

  WisHeader: pTWisHeader;
  WisIndexArray: TWisFileHeaderArray;
  MapStream: TMapStream;
begin
  Result := False;

  MapStream := TMapStream.Create;
  if MapStream.LoadFromFile(FileName) then begin
    iFileOffset := 512;
    nIndexOffset := MapStream.Size;
    WisHeader := Pointer(Integer(MapStream.Memory) + MapStream.Size);
    while True do begin
      if nIndexOffset > iFileOffset then begin
        Dec(nIndexOffset, SizeOf(TWisHeader));
        WisHeader := DecPointer(WisHeader, SizeOf(TWisHeader));
        if (WisHeader.OffSet >= iFileOffset) and (WisHeader.Length >= 1) then begin
          SetLength(WisIndexArray, Length(WisIndexArray) + 1);
          WisIndexArray[Length(WisIndexArray) - 1] := WisHeader^;
          if (WisHeader.OffSet <= iFileOffset) then begin
            FIndexOffset := nIndexOffset;
            break;
          end;
        end else break;
      end else begin
        FIndexOffset := nIndexOffset;
        break;
      end;
    end;
  {
  MapStream := TMapStream.Create(FileName);
  MapStream.Active := True;

  iFileOffset := 512;
  nIndexOffset := MapStream.Size;
  WisHeader := Pointer(Integer(MapStream.Memory) + MapStream.Size);
  while True do begin
    if nIndexOffset > iFileOffset then begin
      Dec(nIndexOffset, SizeOf(TWisHeader));
      WisHeader := DecPointer(WisHeader, SizeOf(TWisHeader));
      if (WisHeader.OffSet >= iFileOffset) and (WisHeader.Length >= 1) then begin
        SetLength(WisIndexArray, Length(WisIndexArray) + 1);
        WisIndexArray[Length(WisIndexArray) - 1] := WisHeader^;
        if (WisHeader.OffSet <= iFileOffset) then begin
          FIndexOffset := nIndexOffset;
          break;
        end;
      end else break;
    end else begin
      FIndexOffset := nIndexOffset;
      break;
    end;
  end;
  MapStream.Free;
  }

    SetLength(IndexArray, Length(WisIndexArray));
    for nIndex := 0 to Length(WisIndexArray) - 1 do begin
      IndexArray[nIndex] := WisIndexArray[Length(WisIndexArray) - nIndex - 1];
    end;
    ImageCount := Length(IndexArray);

    Result := True;
  end;
  MapStream.Free;
end;

function TWisImages.GetCachedImage(Index: Integer; var PX, PY: Integer): TTexture;
begin
  Result := nil;
  m_dwUseCheckTick := GetTickCount;
  if (Index >= 0) and (Index < ImageCount) then begin
    if GetTickCount - m_dwMemChecktTick > 10000 then begin
      m_dwMemChecktTick := GetTickCount;
      FreeOldMemorys(Index);
    end;
    if m_ImgArr[Index].Texture = nil then begin
      LoadDxImage(@IndexArray[Index], @m_ImgArr[Index]);
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

function TWisImages.GetCachedSurface(Index: Integer): TTexture;
begin
  Result := nil;
  m_dwUseCheckTick := GetTickCount;
  if (Index >= 0) and (Index < ImageCount) then begin
    if GetTickCount - m_dwMemChecktTick > 10000 then begin
      m_dwMemChecktTick := GetTickCount;
      FreeOldMemorys(Index);
    end;
    if m_ImgArr[Index].Texture = nil then begin
      LoadDxImage(@IndexArray[Index], @m_ImgArr[Index]);
      Result := m_ImgArr[Index].Texture;
    end else begin
      m_ImgArr[Index].dwLatestTime := GetTickCount;
      Result := m_ImgArr[Index].Texture;
    end;
  end;
end;

function WidthBytes(w: integer): integer;
begin
  Result := (((w * 8) + 31) div 32) * 4;
end;

procedure TWisImages.LoadDxImage(WisHeader: PTWisHeader; DXImage: pTDXImage);
var
  I, J, nError: Integer;
  ImgInfo: TImgInfo;

  S, D: Pointer;

  SrcP: PByte;
  DesP: PByte;
  nSize: Integer;
  RGB: TRGBQuad;
begin
  try
    nError := 0;
    FileStream.Position := WisHeader.OffSet;
    nError := 1;
    FileStream.Read(ImgInfo, SizeOf(ImgInfo));
    nError := 2;
    nSize := ImgInfo.wW * ImgInfo.wH;
    nError := 3;
    if (nSize > 0) and (nSize < 999999) then begin
      DXImage.Texture := TTexture.Create;
      DXImage.nPx := ImgInfo.wPx;
      DXImage.nPy := ImgInfo.wPy;
      DXImage.dwLatestTime := GetTickCount;
      nError := 4;
      DXImage.Texture.SetSize(WidthBytes(ImgInfo.wW), ImgInfo.wH);
      nError := 5;
      if ImgInfo.btEncr0 = 1 then begin
        nError := 6;
        GetMem(S, WisHeader.Length);
        nError := 7;
        GetMem(D, nSize);
        nError := 8;
        SrcP := S;
        DesP := D;
        FileStream.Read(SrcP^, WisHeader.Length);
        nError := 9;
        DecodeWis(SrcP, DesP, WisHeader.Length, nSize);
        nError := 10;
        FreeMem(S);
        nError := 11;
        S := D;
        nError := 12;
        for I := 0 to DXImage.Texture.Height - 1 do begin //256色数据转换成16位数据
          SrcP := PByte(Integer(S) + I * ImgInfo.wW);
          DesP := PByte(Integer(DXImage.Texture.PBits) + I * DXImage.Texture.Pitch); //(DXImage.Texture.Height - 1 - I)
          for J := 0 to ImgInfo.wW - 1 do begin
            RGB := MainPalette[SrcP^];
            if Integer(RGB) = 0 then begin
              PWord(DesP)^ := 0;
            end else begin
              //PWord(DesP)^ := RGBColors[RGB.rgbRed, RGB.rgbGreen, RGB.rgbBlue];
              PWord(DesP)^ := Word((Max(RGB.rgbRed and $F8, 8) shl 8) or (Max(RGB.rgbGreen and $FC, 8) shl 3) or (Max(RGB.rgbBlue and $F8, 8) shr 3)); //565格式
            end;
            Inc(SrcP);
            Inc(DesP, 2);
          end;
        end;
        nError := 13;
        FreeMem(S);
        nError := 14;
      end else begin
        nError := 15;
        GetMem(S, nSize);
        nError := 16;
        FileStream.Read(S^, nSize);
        nError := 17;
        for I := 0 to DXImage.Texture.Height - 1 do begin //256色数据转换成16位数据
          SrcP := PByte(Integer(S) + I * ImgInfo.wW);
          DesP := PByte(Integer(DXImage.Texture.PBits) + I * DXImage.Texture.Pitch); //(DXImage.Texture.Height - 1 - I)
          for J := 0 to ImgInfo.wW - 1 do begin
            RGB := MainPalette[SrcP^];
            if Integer(RGB) = 0 then begin
              PWord(DesP)^ := 0;
            end else begin
              //PWord(DesP)^ := RGBColors[RGB.rgbRed, RGB.rgbGreen, RGB.rgbBlue];
              PWord(DesP)^ := Word((Max(RGB.rgbRed and $F8, 8) shl 8) or (Max(RGB.rgbGreen and $FC, 8) shl 3) or (Max(RGB.rgbBlue and $F8, 8) shr 3)); //565格式
            end;
            Inc(SrcP);
            Inc(DesP, 2);
          end;
        end;
        nError := 18;
        FreeMem(S);
        nError := 19;
      end;
    end;
  except
    //DebugOutStr('TWisImages.LoadDxImage:' + IntToStr(nError));
  end;
end;

function TWisImages.GetDIB(Index: Integer): TDIB;
var
  I, nError: Integer;
  ImgInfo: TImgInfo;
  S, D: Pointer;
  SrcP: PByte;
  DesP: PByte;
  nSize: Integer;
  lsDIB: TDIB;
begin
  lsDIB := nil;
  Result := nil;
  try
    if (Index >= 0) and (Index < ImageCount) then begin
      FileStream.Position := IndexArray[Index].OffSet;
      FileStream.Read(ImgInfo, SizeOf(ImgInfo));

      nSize := ImgInfo.wW * ImgInfo.wH;
      if (nSize > 0) and (nSize < 999999) then begin
        lsDIB := TDIB.Create;
        lsDIB.BitCount := 8;
        lsDIB.ColorTable := MainPalette;
        lsDIB.UpdatePalette;

        lsDIB.Width := WidthBytes(ImgInfo.wW);
        lsDIB.Height := ImgInfo.wH;

        lsDIB.Canvas.Brush.Color := clblack;
        lsDIB.Canvas.FillRect(lsDIB.Canvas.ClipRect);
        if ImgInfo.btEncr0 = 1 then begin
          nError := 6;
          GetMem(S, IndexArray[Index].Length);
          nError := 7;
          GetMem(D, nSize);
          nError := 8;
          SrcP := S;
          DesP := D;
          FileStream.Read(SrcP^, IndexArray[Index].Length);
          nError := 9;
          DecodeWis(SrcP, DesP, IndexArray[Index].Length, nSize);
          nError := 10;
          FreeMem(S);
          nError := 11;
          S := D;
          for I := 0 to lsDIB.Height - 1 do begin
            SrcP := PByte(Integer(S) + I * ImgInfo.wW);
            DesP := PByte(Integer(lsDIB.PBits) + (lsDIB.Height - 1 - I) * lsDIB.WidthBytes);
            Move(SrcP^, DesP^, lsDIB.Width);
          end;
          FreeMem(S);

        end else begin
          for I := 0 to lsDIB.Height - 1 do begin
            SrcP := PByte(Integer(lsDIB.PBits) + (lsDIB.Height - 1 - I) * lsDIB.WidthBytes);
            FileStream.Read(SrcP^, ImgInfo.wW);
          end;
        end;
        Result := lsDIB;
      end else Result := nil;
    end else Result := nil;
  except
    Result := nil;
    if lsDIB <> nil then
      lsDIB.Free;
  end;
end;

function TWisImages.Get(Index: Integer; var PX, PY: Smallint): TDIB;
var
  I, nError: Integer;
  ImgInfo: TImgInfo;
  S, D: Pointer;
  SrcP: PByte;
  DesP: PByte;
  nSize: Integer;
  lsDIB: TDIB;
begin
  lsDIB := nil;
  Result := nil;
  try
    if (Index >= 0) and (Index < ImageCount) then begin
      FileStream.Position := IndexArray[Index].OffSet;
      FileStream.Read(ImgInfo, SizeOf(ImgInfo));
      PX := ImgInfo.wPx;
      PY := ImgInfo.wPy;
      nSize := ImgInfo.wW * ImgInfo.wH;
      if (nSize > 0) and (nSize < 999999) then begin
        lsDIB := TDIB.Create;
        lsDIB.BitCount := 8;
        lsDIB.ColorTable := MainPalette;
        lsDIB.UpdatePalette;

        lsDIB.Width := WidthBytes(ImgInfo.wW);
        lsDIB.Height := ImgInfo.wH;

        lsDIB.Canvas.Brush.Color := clblack;
        lsDIB.Canvas.FillRect(lsDIB.Canvas.ClipRect);
        if ImgInfo.btEncr0 = 1 then begin
          nError := 6;
          GetMem(S, IndexArray[Index].Length);
          nError := 7;
          GetMem(D, nSize);
          nError := 8;
          SrcP := S;
          DesP := D;
          FileStream.Read(SrcP^, IndexArray[Index].Length);
          nError := 9;
          DecodeWis(SrcP, DesP, IndexArray[Index].Length, nSize);
          nError := 10;
          FreeMem(S);
          nError := 11;
          S := D;
          for I := 0 to lsDIB.Height - 1 do begin
            SrcP := PByte(Integer(S) + I * ImgInfo.wW);
            DesP := PByte(Integer(lsDIB.PBits) + (lsDIB.Height - 1 - I) * lsDIB.WidthBytes);
            Move(SrcP^, DesP^, lsDIB.Width);
          end;
          FreeMem(S);

        end else begin
          for I := 0 to lsDIB.Height - 1 do begin
            SrcP := PByte(Integer(lsDIB.PBits) + (lsDIB.Height - 1 - I) * lsDIB.WidthBytes);
            FileStream.Read(SrcP^, ImgInfo.wW);
          end;
        end;
        Result := lsDIB;
      end else Result := nil;
    end else Result := nil;
  except
    Result := nil;
    if lsDIB <> nil then
      lsDIB.Free;
  end;
end;

var
  ColorArray: array[0..1023] of Byte = (
    $00, $00, $00, $00, $00, $00, $80, $00, $00, $80, $00, $00, $00, $80, $80, $00,
    $80, $00, $00, $00, $80, $00, $80, $00, $80, $80, $00, $00, $C0, $C0, $C0, $00,
    $97, $80, $55, $00, $C8, $B9, $9D, $00, $73, $73, $7B, $00, $29, $29, $2D, $00,
    $52, $52, $5A, $00, $5A, $5A, $63, $00, $39, $39, $42, $00, $18, $18, $1D, $00,
    $10, $10, $18, $00, $18, $18, $29, $00, $08, $08, $10, $00, $71, $79, $F2, $00,
    $5F, $67, $E1, $00, $5A, $5A, $FF, $00, $31, $31, $FF, $00, $52, $5A, $D6, $00,
    $00, $10, $94, $00, $18, $29, $94, $00, $00, $08, $39, $00, $00, $10, $73, $00,
    $00, $18, $B5, $00, $52, $63, $BD, $00, $10, $18, $42, $00, $99, $AA, $FF, $00,
    $00, $10, $5A, $00, $29, $39, $73, $00, $31, $4A, $A5, $00, $73, $7B, $94, $00,
    $31, $52, $BD, $00, $10, $21, $52, $00, $18, $31, $7B, $00, $10, $18, $2D, $00,
    $31, $4A, $8C, $00, $00, $29, $94, $00, $00, $31, $BD, $00, $52, $73, $C6, $00,
    $18, $31, $6B, $00, $42, $6B, $C6, $00, $00, $4A, $CE, $00, $39, $63, $A5, $00,
    $18, $31, $5A, $00, $00, $10, $2A, $00, $00, $08, $15, $00, $00, $18, $3A, $00,
    $00, $00, $08, $00, $00, $00, $29, $00, $00, $00, $4A, $00, $00, $00, $9D, $00,
    $00, $00, $DC, $00, $00, $00, $DE, $00, $00, $00, $FB, $00, $52, $73, $9C, $00,
    $4A, $6B, $94, $00, $29, $4A, $73, $00, $18, $31, $52, $00, $18, $4A, $8C, $00,
    $11, $44, $88, $00, $00, $21, $4A, $00, $10, $18, $21, $00, $5A, $94, $D6, $00,
    $21, $6B, $C6, $00, $00, $6B, $EF, $00, $00, $77, $FF, $00, $84, $94, $A5, $00,
    $21, $31, $42, $00, $08, $10, $18, $00, $08, $18, $29, $00, $00, $10, $21, $00,
    $18, $29, $39, $00, $39, $63, $8C, $00, $10, $29, $42, $00, $18, $42, $6B, $00,
    $18, $4A, $7B, $00, $00, $4A, $94, $00, $7B, $84, $8C, $00, $5A, $63, $6B, $00,
    $39, $42, $4A, $00, $18, $21, $29, $00, $29, $39, $46, $00, $94, $A5, $B5, $00,
    $5A, $6B, $7B, $00, $94, $B1, $CE, $00, $73, $8C, $A5, $00, $5A, $73, $8C, $00,
    $73, $94, $B5, $00, $73, $A5, $D6, $00, $4A, $A5, $EF, $00, $8C, $C6, $EF, $00,
    $42, $63, $7B, $00, $39, $56, $6B, $00, $5A, $94, $BD, $00, $00, $39, $63, $00,
    $AD, $C6, $D6, $00, $29, $42, $52, $00, $18, $63, $94, $00, $AD, $D6, $EF, $00,
    $63, $8C, $A5, $00, $4A, $5A, $63, $00, $7B, $A5, $BD, $00, $18, $42, $5A, $00,
    $31, $8C, $BD, $00, $29, $31, $35, $00, $63, $84, $94, $00, $4A, $6B, $7B, $00,
    $5A, $8C, $A5, $00, $29, $4A, $5A, $00, $39, $7B, $9C, $00, $10, $31, $42, $00,
    $21, $AD, $EF, $00, $00, $10, $18, $00, $00, $21, $29, $00, $00, $6B, $9C, $00,
    $5A, $84, $94, $00, $18, $42, $52, $00, $29, $5A, $6B, $00, $21, $63, $7B, $00,
    $21, $7B, $9C, $00, $00, $A5, $DE, $00, $39, $52, $5A, $00, $10, $29, $31, $00,
    $7B, $BD, $CE, $00, $39, $5A, $63, $00, $4A, $84, $94, $00, $29, $A5, $C6, $00,
    $18, $9C, $10, $00, $4A, $8C, $42, $00, $42, $8C, $31, $00, $29, $94, $10, $00,
    $10, $18, $08, $00, $18, $18, $08, $00, $10, $29, $08, $00, $29, $42, $18, $00,
    $AD, $B5, $A5, $00, $73, $73, $6B, $00, $29, $29, $18, $00, $4A, $42, $18, $00,
    $4A, $42, $31, $00, $DE, $C6, $63, $00, $FF, $DD, $44, $00, $EF, $D6, $8C, $00,
    $39, $6B, $73, $00, $39, $DE, $F7, $00, $8C, $EF, $F7, $00, $00, $E7, $F7, $00,
    $5A, $6B, $6B, $00, $A5, $8C, $5A, $00, $EF, $B5, $39, $00, $CE, $9C, $4A, $00,
    $B5, $84, $31, $00, $6B, $52, $31, $00, $D6, $DE, $DE, $00, $B5, $BD, $BD, $00,
    $84, $8C, $8C, $00, $DE, $F7, $F7, $00, $18, $08, $00, $00, $39, $18, $08, $00,
    $29, $10, $08, $00, $00, $18, $08, $00, $00, $29, $08, $00, $A5, $52, $00, $00,
    $DE, $7B, $00, $00, $4A, $29, $10, $00, $6B, $39, $10, $00, $8C, $52, $10, $00,
    $A5, $5A, $21, $00, $5A, $31, $10, $00, $84, $42, $10, $00, $84, $52, $31, $00,
    $31, $21, $18, $00, $7B, $5A, $4A, $00, $A5, $6B, $52, $00, $63, $39, $29, $00,
    $DE, $4A, $10, $00, $21, $29, $29, $00, $39, $4A, $4A, $00, $18, $29, $29, $00,
    $29, $4A, $4A, $00, $42, $7B, $7B, $00, $4A, $9C, $9C, $00, $29, $5A, $5A, $00,
    $14, $42, $42, $00, $00, $39, $39, $00, $00, $59, $59, $00, $2C, $35, $CA, $00,
    $21, $73, $6B, $00, $00, $31, $29, $00, $10, $39, $31, $00, $18, $39, $31, $00,
    $00, $4A, $42, $00, $18, $63, $52, $00, $29, $73, $5A, $00, $18, $4A, $31, $00,
    $00, $21, $18, $00, $00, $31, $18, $00, $10, $39, $18, $00, $4A, $84, $63, $00,
    $4A, $BD, $6B, $00, $4A, $B5, $63, $00, $4A, $BD, $63, $00, $4A, $9C, $5A, $00,
    $39, $8C, $4A, $00, $4A, $C6, $63, $00, $4A, $D6, $63, $00, $4A, $84, $52, $00,
    $29, $73, $31, $00, $5A, $C6, $63, $00, $4A, $BD, $52, $00, $00, $FF, $10, $00,
    $18, $29, $18, $00, $4A, $88, $4A, $00, $4A, $E7, $4A, $00, $00, $5A, $00, $00,
    $00, $88, $00, $00, $00, $94, $00, $00, $00, $DE, $00, $00, $00, $EE, $00, $00,
    $00, $FB, $00, $00, $94, $5A, $4A, $00, $B5, $73, $63, $00, $D6, $8C, $7B, $00,
    $D6, $7B, $6B, $00, $FF, $88, $77, $00, $CE, $C6, $C6, $00, $9C, $94, $94, $00,
    $C6, $94, $9C, $00, $39, $31, $31, $00, $84, $18, $29, $00, $84, $00, $18, $00,
    $52, $42, $4A, $00, $7B, $42, $52, $00, $73, $5A, $63, $00, $F7, $B5, $CE, $00,
    $9C, $7B, $8C, $00, $CC, $22, $77, $00, $FF, $AA, $DD, $00, $2A, $B4, $F0, $00,
    $9F, $00, $DF, $00, $B3, $17, $E3, $00, $F0, $FB, $FF, $00, $A4, $A0, $A0, $00,
    $80, $80, $80, $00, $00, $00, $FF, $00, $00, $FF, $00, $00, $00, $FF, $FF, $00,
    $FF, $00, $00, $00, $FF, $00, $FF, $00, $FF, $FF, $00, $00, $FF, $FF, $FF, $00
    );

initialization
  begin
    Move(ColorArray, MainPalette, SizeOf(ColorArray));
  end;

end.

