unit SGL;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls, ComCtrls;
const
  TARGA_NO_COLORMAP = 0;
  TARGA_COLORMAP = 1;

  TARGA_EMPTY_IMAGE = 0;
  TARGA_INDEXED_IMAGE = 1;
  TARGA_TRUECOLOR_IMAGE = 2;
  TARGA_BW_IMAGE = 3;
  TARGA_INDEXED_RLE_IMAGE = 9;
  TARGA_TRUECOLOR_RLE_IMAGE = 10;
  TARGA_BW_RLE_IMAGE = 11;

  Sgl_Title = 'Shanda Game Lib.';

procedure TargaEncode32(Source, Dest: PDWord; Count: Integer; var BytesStored: Integer);
procedure TargaBuild32(Stream: TStream; ASource: PDWord; AWidth, AHeight: Integer; const AImageID: string; Compressed: Boolean);

type
  TTargaHeader = packed record
    IDLength,
      ColorMapType,
      ImageType: Byte;
    ColorMapOrigin,
      ColorMapSize: Word;
    ColorMapEntrySize: Byte;
    XOrigin,
      YOrigin,
      Width,
      Height: Word;
    PixelSize: Byte;
    ImageDescriptor: Byte;
  end;

//------------------------------------------------------------------------------
// SGL File

  TSglHeader = packed record
    shTitle: array[0..31] of Char;
    shComp: DWord;
    shOffset: DWord;
  end;

  TSglImage = packed record
    siUnknown1: Byte;
    siFormat: Byte;
    siFrames: Word;
    siUnknown2: Word;
  end;
  PSglImage = ^TSglImage;

  TSglFrame = packed record
    sfWidth: Smallint;
    sfHeight: Smallint;
    sfX: Smallint;
    sfY: Smallint;
    sfXBlocks: Byte;
    sfYBlocks: Byte;
  end;
  PSglFrame = ^TSglFrame;

  TSglFile = class(TObject)
  private
    FStream: TStream;
    FFileName: string;
    FHeaderInfo: TSglHeader;
    FImageCount: Integer;
    FImageOffs: array of DWord;
    FFrameOffs: array of DWord;
    FFrames: array of TSglFrame;

    FDumpImageInfo: TSglImage;
    FImageInfo: TSglImage;
    FImageIndex: Integer;
    function GetImageCount: Integer;
    function GetImageOffset(Index: Integer): DWord;
    procedure SetImageIndex(const Value: Integer);
    function GetFrameCount: Integer;
    function GetFrame(Index: Integer): PSglFrame;
    function GetFrameOffset(Index: Integer): DWord;
    function GetImage(Index: Integer): PSglImage;
  protected
    procedure ReadFrames;
    function SGL_Decode1(ASrc, ADst: PByte; AWidth, AHeight: Integer): Boolean;
    function SGL_Decode2(ASrc, ADst: PByte; AWidth, AHeight: Integer): Boolean;
    function SGL_RLE8_Decode(ASrc, ADst: PByte; ASrcSize, ADstSize: Integer): Boolean;
    function SGL_RLE8_Decode2(ASrc, ADst: PByte; ASrcSize, ADstSize: Integer): Boolean;
    function SGL_RLE16_Decode(ASrc, ADst: PWord; ASrcSize, ADstSize: Integer): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function Open(FileName: string): Boolean;
    procedure Close;
    function DecodeFrame16(AFrame: Integer; ADst: PByte; AWidthBytes: Integer; ChooseColor: TColor = clWhite): Boolean;
    function DecodeFrame32(AFrame: Integer; ADst: PByte; AWidthBytes: Integer): Boolean;
    procedure LoadAllImages(List: TList);


    property FileName: string read FFileName;
    property HeaderInfo: TSglHeader read FHeaderInfo;
    property ImageInfo: TSglImage read FImageInfo;
    property Images[Index: Integer]: PSglImage read GetImage;
    property Frames[Index: Integer]: PSglFrame read GetFrame;
    property ImageOffsets[Index: Integer]: DWord read GetImageOffset;
    property FrameOffsets[Index: Integer]: DWord read GetFrameOffset;
    property ImageCount: Integer read GetImageCount;
    property FrameCount: Integer read GetFrameCount;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
  published

  end;
//------------------------------------------------------------------------------
// Main Form

  TMyFrame = record
    mfSglFile: TSglFile;
    mfSglImage: Integer;
    mfSglFrame: Integer;
  end;

  TMyImage = record
    miTitle: string;
    miCount: Integer;
    miColor: TColor;
    miFrames: array of TMyFrame;
  end;
  PMyImage = ^TMyImage;

implementation
uses MirShare;

procedure TargaEncode32(Source, Dest: PDWord; Count: Integer; var BytesStored: Integer);
var
  DiffCount: Integer;
  SameCount: Integer;
  SourcePtr: PDWord;
  TargetPtr: PDWord;
  P: PDWord;
  I: Integer;
  C: Integer;
  Pixel: DWord;
begin
  BytesStored := 0;
  SourcePtr := Source;
  TargetPtr := Dest;

  while Count > 0 do
  begin

    DiffCount := 0;
    P := SourcePtr;
    if Count = 1 then
      DiffCount := 1
    else
    begin
      Pixel := P^;
      for I := 1 to Count - 1 do
      begin
        Inc(P);
        if P^ = Pixel then Break;
        Pixel := P^;
        Inc(DiffCount);
      end;
      if P^ <> Pixel then Inc(DiffCount);
    end;

    Dec(Count, DiffCount);
    while DiffCount > 0 do
    begin
      if DiffCount > 128 then
        C := 128
      else
        C := DiffCount;
      PByte(TargetPtr)^ := C - 1;
      Inc(PByte(TargetPtr));
      Inc(BytesStored, C * 4 + 1);
      MoveMemory(TargetPtr, SourcePtr, C * 4);
      Inc(TargetPtr, C);
      Inc(SourcePtr, C);
      Dec(DiffCount, C);
    end;

    SameCount := 1;
    P := SourcePtr;
    Pixel := P^;
    for I := 1 to Count - 1 do
    begin
      Inc(P);
      if P^ <> Pixel then Break;
      Inc(SameCount);
    end;

    if SameCount > 1 then
    begin
      Dec(Count, SameCount);
      while SameCount > 0 do
      begin
        if SameCount > 128 then
          C := 128
        else
          C := SameCount;
        PByte(TargetPtr)^ := (C - 1) or $80;
        Inc(PByte(TargetPtr));
        Inc(BytesStored, 5);
        TargetPtr^ := SourcePtr^;
        Inc(TargetPtr);
        Inc(SourcePtr, C);
        Dec(SameCount, C);
      end;
    end;
  end;
end;

procedure TargaBuild32(Stream: TStream; ASource: PDWord; AWidth, AHeight: Integer; const AImageID: string; Compressed: Boolean);
var
  RLEBuffer: PDWord;
  I: Integer;
  LineSize: Integer;
  WriteLength: Integer;
  Header: TTargaHeader;
begin
  with Header do
  begin
    IDLength := Length(AImageID);
    ColorMapType := 0;
    if not Compressed then
      ImageType := TARGA_TRUECOLOR_IMAGE
    else
      ImageType := TARGA_TRUECOLOR_RLE_IMAGE;

    ColorMapOrigin := 0;
    ColorMapSize := 256;
    ColorMapEntrySize := 24;
    XOrigin := 0;
    YOrigin := 0;
    Width := AWidth;
    Height := AHeight;
    PixelSize := 32;
    ImageDescriptor := $20;
  end;

  Stream.Write(Header, SizeOf(Header));
  if Header.IDLength > 0 then Stream.Write(AImageID[1], Header.IDLength);

  LineSize := AWidth * 4;
  // finally write image data
  if Compressed then
  begin
    GetMem(RLEBuffer, 2 * LineSize);
    try
      for I := 0 to AHeight - 1 do
      begin
        TargaEncode32(ASource, RLEBuffer, AWidth, WriteLength);
        Stream.WriteBuffer(RLEBuffer^, WriteLength);
        Inc(ASource, AWidth);
      end;
    finally
      FreeMem(RLEBuffer);
    end;
  end
  else
  begin
    for I := 0 to AHeight - 1 do
    begin
      Stream.WriteBuffer(ASource^, LineSize);
      Inc(ASource, AWidth);
    end;
  end;
end;

//------------------------------------------------------------------------------
// TSglFile
//------------------------------------------------------------------------------

procedure TSglFile.Close;
begin
  if FStream <> nil then
  begin
    FStream.Free;
    FStream := nil;
  end;
  SetLength(FImageOffs, 0);
  FillChar(FHeaderInfo, SizeOf(TSglHeader), 0);
  FillChar(FImageInfo, SizeOf(TSglImage), 0);
  FImageIndex := -1;
  FFileName := '';

end;

constructor TSglFile.Create;
begin

end;


function TSglFile.SGL_Decode2(ASrc, ADst: PByte; AWidth,
  AHeight: Integer): Boolean;
const
  MASK = $000000F0;
  MULT = $00005556;
var
  wR1: Word;
  wG1: Word;
  wB1: Word;
  wA1: Word;
  wR2: Word;
  wG2: Word;
  wB2: Word;
  wA2: Word;
  I: Integer;
  J: Integer;
  dwTemp: DWord;
  lpPixel: PWord;
  Pal: array[0..3] of Word;
begin
  for J := 0 to AHeight div 4 - 1 do
  begin
    for I := 0 to AWidth div 4 - 1 do
    begin
      lpPixel := PWord(Integer(ADst) + I * 8);

      //dwTemp = $FFB7A572, Pal[0] = $FBA7, Pal[1] = $F752
      dwTemp := PDWord(ASrc)^;
      Inc(ASrc, 4);

      wB1 := (dwTemp) and MASK; //wB1 = 0070
      wG1 := (dwTemp shr 8) and MASK; //wG1 = 00A0
      wR1 := (dwTemp shr 16) and MASK; //wR1 = 00B0
      wA1 := (dwTemp shr 24) and MASK; //wA1 = 00F0

      wB2 := (dwTemp shl 4) and MASK; //wB2 = 0020
      wG2 := (dwTemp shr 4) and MASK; //wG2 = 0050
      wR2 := (dwTemp shr 12) and MASK; //wR2 = 0070
      wA2 := (dwTemp shr 20) and MASK; //wA2 = 00F0

      Pal[0] := wB1 shr 4 or wG1 or wR1 shl 4 or wA1 shl 8; //Pal[0] = $FBA7
      Pal[1] := wB2 shr 4 or wG2 or wR2 shl 4 or wA2 shl 8; //Pal[1] = $F752
      Pal[2] :=
        ((wB1 shl 1 + wB2) * MULT shr 16 + 8) and MASK shr 4 or
        ((wG1 shl 1 + wG2) * MULT shr 16 + 8) and MASK or
        ((wR1 shl 1 + wR2) * MULT shr 16 + 8) and MASK shl 4 or
        ((wA1 shl 1 + wA2) * MULT shr 16 + 8) and MASK shl 8; //Pal[2] = $FA85
      Pal[3] :=
        ((wB2 shl 1 + wB1) * MULT shr 16 + 8) and MASK shr 4 or
        ((wG2 shl 1 + wG1) * MULT shr 16 + 8) and MASK or
        ((wR2 shl 1 + wR1) * MULT shr 16 + 8) and MASK shl 4 or
        ((wA2 shl 1 + wA1) * MULT shr 16 + 8) and MASK shl 8; //Pal[2] = $F874

      dwTemp := PDWord(ASrc)^;
      Inc(ASrc, 4);

      lpPixel^ := Pal[dwTemp and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 2) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 4) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 6) and 3];
      Inc(lpPixel, AWidth - 3);

      lpPixel^ := Pal[(dwTemp shr 8) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 10) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 12) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 14) and 3];
      Inc(lpPixel, AWidth - 3);

      lpPixel^ := Pal[(dwTemp shr 16) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 18) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 20) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 22) and 3];
      Inc(lpPixel, AWidth - 3);

      lpPixel^ := Pal[(dwTemp shr 24) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 26) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 28) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 30) and 3];
    end;
    Inc(ADst, AWidth * 8);
  end;
  Result := True;
end;

function TSglFile.SGL_Decode1(ASrc, ADst: PByte; AWidth,
  AHeight: Integer): Boolean;
const
  MASK = $000000F0;
  MULT = $00005556;
var
  wR1: Word;
  wG1: Word;
  wB1: Word;
  wR2: Word;
  wG2: Word;
  wB2: Word;
  I: Integer;
  J: Integer;
  dwTemp: DWord;
  lpPixel: PWord;
  Pal: array[0..3] of Word;
begin
  for J := 0 to AHeight div 4 - 1 do
  begin
    for I := 0 to AWidth div 4 - 1 do
    begin
      lpPixel := PWord(Integer(ADst) + I * 8);

      //dwTemp = $FFB7A572, Color1 = $FBA7, Color2 = $F752
      dwTemp := PDWord(ASrc)^;
      Inc(ASrc, 3);

      wB1 := (dwTemp) and MASK; //wB1 = 0070
      wG1 := (dwTemp shr 8) and MASK; //wG1 = 00A0
      wR1 := (dwTemp shr 16) and MASK; //wR1 = 00B0

      wB2 := (dwTemp shl 4) and MASK; //wB2 = 0020
      wG2 := (dwTemp shr 4) and MASK; //wG2 = 0050
      wR2 := (dwTemp shr 12) and MASK; //wR2 = 0070

      Pal[0] := wB1 shr 4 or wG1 or wR1 shl 4 or $F000; //Pal[0] = $FBA7
      Pal[1] := wB2 shr 4 or wG2 or wR2 shl 4 or $F000; //Pal[1] = $F752
      Pal[2] := //Pal[2] = $FA85
        ((wB1 shl 1 + wB2) * MULT shr 16 + 8) and MASK shr 4 or
        ((wG1 shl 1 + wG2) * MULT shr 16 + 8) and MASK or
        ((wR1 shl 1 + wR2) * MULT shr 16 + 8) and MASK shl 4 or $F000;
      Pal[3] := //Pal[2] = $F874
        ((wB2 shl 1 + wB1) * MULT shr 16 + 8) and MASK shr 4 or
        ((wG2 shl 1 + wG1) * MULT shr 16 + 8) and MASK or
        ((wR2 shl 1 + wR1) * MULT shr 16 + 8) and MASK shl 4 or $F000;

      dwTemp := PDWord(ASrc)^;
      Inc(ASrc, 4);

      lpPixel^ := Pal[dwTemp and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 2) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 4) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 6) and 3];
      Inc(lpPixel, AWidth - 3);

      lpPixel^ := Pal[(dwTemp shr 8) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 10) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 12) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 14) and 3];
      Inc(lpPixel, AWidth - 3);

      lpPixel^ := Pal[(dwTemp shr 16) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 18) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 20) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 22) and 3];
      Inc(lpPixel, AWidth - 3);

      lpPixel^ := Pal[(dwTemp shr 24) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 26) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 28) and 3];
      Inc(lpPixel);
      lpPixel^ := Pal[(dwTemp shr 30) and 3];
    end;
    Inc(ADst, AWidth * 8);
  end;
  Result := True;
end;

function TSglFile.SGL_RLE16_Decode(ASrc, ADst: PWord; ASrcSize,
  ADstSize: Integer): Boolean;
var
  L: Byte;
begin
  while (ASrcSize > 0) and (ADstSize > 0) do
  begin
    if (PByte(ASrc)^ and $80) = 0 then
    begin
      L := PByte(ASrc)^;
      Inc(PByte(ASrc));
      Dec(ASrcSize, 3);
      if L > ADstSize then L := ADstSize;
      Dec(ADstSize, L * 2);
      for L := 1 to L do
      begin
        ADst^ := ASrc^;
        Inc(ADst);
      end;
      Inc(ASrc);
    end
    else
    begin
      L := PByte(ASrc)^ and $7F;
      Inc(PByte(ASrc));
      Dec(ASrcSize, L * 2 + 1);
      if L > ADstSize then L := ADstSize;
      Dec(ADstSize, L * 2);
      for L := 1 to L do
      begin
        ADst^ := ASrc^;
        Inc(ADst);
        Inc(ASrc);
      end;
    end;
  end;
  Result := True;
end;

function TSglFile.SGL_RLE8_Decode(ASrc, ADst: PByte; ASrcSize,
  ADstSize: Integer): Boolean;
var
  L: Byte;
begin
  while (ASrcSize > 0) and (ADstSize > 0) do
  begin
    if (PByte(ASrc)^ and $80) = 0 then
    begin
      L := ASrc^;
      Inc(ASrc);
      Dec(ASrcSize, 2);
      if L > ADstSize then L := ADstSize;
      Dec(ADstSize, L);
      for L := 1 to L do
      begin
        ADst^ := ASrc^;
        Inc(ADst);
      end;
      Inc(ASrc);
    end
    else
    begin
      L := PByte(ASrc)^ and $7F;
      Inc(PByte(ASrc));
      Dec(ASrcSize, L + 1);
      if L > ADstSize then L := ADstSize;
      Dec(ADstSize, L);
      for L := 1 to L do
      begin
        ADst^ := ASrc^;
        Inc(ADst);
        Inc(ASrc);
      end;
    end;
  end;
  Result := True;
end;

function TSglFile.SGL_RLE8_Decode2(ASrc, ADst: PByte; ASrcSize,
  ADstSize: Integer): Boolean;
var
  L: Byte;
begin
  while (ASrcSize > 0) and (ADstSize > 0) do
  begin
    if (PByte(ASrc)^ and $80) = 0 then
    begin
      L := ASrc^ * 2;
      Inc(ASrc);
      Dec(ASrcSize, 2);
      if L > ADstSize then L := ADstSize;
      Dec(ADstSize, L);
      for L := 1 to L do
      begin
        ADst^ := ASrc^;
        Inc(ADst);
      end;
      Inc(ASrc);
    end
    else
    begin
      L := PByte(ASrc)^ and $7F;
      Inc(PByte(ASrc));
      Dec(ASrcSize, L + 1);
      if L > ADstSize then L := ADstSize;
      Dec(ADstSize, L);
      for L := 1 to L do
      begin
        ADst^ := ASrc^;
        Inc(ADst);
        ADst^ := ASrc^;
        Inc(ADst);
        Inc(ASrc);
      end;
    end;
  end;
  Result := True;
end;

function TSglFile.DecodeFrame16(AFrame: Integer; ADst: PByte;
  AWidthBytes: Integer; ChooseColor: TColor): Boolean;

  function Coloration4444(ScrCol1, ScrCol2: Word): Word;
  var
    R1, G1, B1: Byte;
  begin
    case ScrCol1 of
      $0000: Result := 0;
      $FFFF: Result := ScrCol2;
    else
      B1 := ((ScrCol1 shr 1) and $0F) * (ScrCol2 and $0F) div $0F;
      G1 := ((ScrCol1 shr 7) and $0F) * ((ScrCol2 shr 4) and $0F) div $0F;
      R1 := ((ScrCol1 shr 12) and $0F) * ((ScrCol2 shr 8) and $0F) div $0F;

      if B1 > $0F then B1 := $0F;
      if G1 > $0F then G1 := $0F;
      if R1 > $0F then R1 := $0F;

      Result := (B1 or (G1 shl 4) or (R1 shl 8) or (ScrCol2 and $F000));
    end;
  end;

  function Coloration565(ScrCol1, ScrCol2: Word): Word;
  var
    R1, G1, B1: Byte;
  begin
    case ScrCol1 of
      $0000: Result := 0;
      $FFFF: Result := ScrCol2;
    else
      B1 := (ScrCol1 and $1F) * (ScrCol2 and $1F) div $1F;
      G1 := ((ScrCol1 shr 5) and $3F) * ((ScrCol2 shr 5) and $3F) div $3F;
      R1 := ((ScrCol1 shr 11) and $1F) * ((ScrCol2 shr 11) and $1F) div $1F;

      if B1 > $1F then B1 := $1F;
      if G1 > $3F then G1 := $3F;
      if R1 > $1F then R1 := $1F;

      Result := (B1 or (G1 shl 5) or (R1 shl 11));
    end;
  end;

  procedure Blend4444(ScrCol: Word; var DesCol: Word);
  var
    Alpha: Byte;
    dR, dG, dB: Byte;
  begin
    Alpha := (ScrCol shr 12) and $0F;
    case Alpha of
      $00: ;
      $0F: DesCol := (((ScrCol shl 1) and $1E) or
          (((ScrCol shr 2) and $3C) shl 5) or
          (((ScrCol shr 7) and $1E) shl 11));
    else
      dB := DesCol and $1F;
      dG := (DesCol shr 5) and $3F;
      dR := (DesCol shr 11) and $1F;

      DesCol := ((Alpha * ((ScrCol shl 1) and $1E - dB) shr 4 + dB) or
        ((Alpha * ((ScrCol shr 2) and $3C - dG) shr 4 + dG) shl 5) or
        ((Alpha * ((ScrCol shr 7) and $1E - dR) shr 4 + dR) shl 11));
    end;
  end;

  procedure Blend4448(Alpha: Byte; ScrCol: Word; var DesCol: Word);
  var
    dR, dG, dB: Byte;
  begin
    case Alpha of
      $00: ;
      $FF: DesCol := (((ScrCol shl 1) and $1E) or
          (((ScrCol shr 2) and $3C) shl 5) or
          (((ScrCol shr 7) and $1E) shl 11));
    else
      dB := DesCol and $1F;
      dG := (DesCol shr 5) and $3F;
      dR := (DesCol shr 11) and $1F;

      DesCol := ((Alpha * ((ScrCol shl 1) and $1E - dB) shr 8 + dB) or
        ((Alpha * ((ScrCol shr 2) and $3C - dG) shr 8 + dG) shl 5) or
        ((Alpha * ((ScrCol shr 7) and $1E - dR) shr 8 + dR) shl 11));
    end;
  end;

  procedure Blend5658(Alpha: Byte; ScrCol: Word; var DesCol: Word);
  var
    //sR, sG, sB: Byte;
    dR, dG, dB: Byte;
    //R, G, B: Byte;
  begin
    case Alpha of
      $00: ;
      $0F: DesCol := ScrCol;
    else
      {sB := ScrCol and $1F;
      sG := (ScrCol shr 5) and $3F;
      sR := (ScrCol shr 11) and $1F;}
      dB := DesCol and $1F;
      dG := (DesCol shr 5) and $3F;
      dR := (DesCol shr 11) and $1F;
      {B := Alpha * (sB - dB) shr 8 + dB;
      G := Alpha * (sG - dG) shr 8 + dG;
      R := Alpha * (sR - dR) shr 8 + dR;

      DesCol := (B or (G shl 5) or (R shl 11)); }

      DesCol := ((Alpha * ((ScrCol and $1F) - dB) shr 8 + dB) or
        ((Alpha * (((ScrCol shr 5) and $3F) - dG) shr 8 + dG) shl 5) or
        ((Alpha * (((ScrCol shr 11) and $1F) - dR) shr 8 + dR) shl 11));
    end;
  end;
var
  I: Integer;
  J: Integer;
  X: Integer;
  Y: Integer;
  W: Byte;
  H: Byte;
  nSize: DWord;
  lpSrc: PWord;
  lpData: PWord;
  lpAlpha: PByte;
  lpDLine: PByte;
  lpSCur: PWord;
  lpDCur: PWord;
  lpACur: PByte;
  wColor: Word;
  FrameInfo: PSglFrame;
begin
  Result := False;
  if (AFrame < Low(FFrames)) and (AFrame > High(FFrames)) then Exit;

  wColor := ((ChooseColor shr 19) and $001F) or ((ChooseColor shr 5) and $07E0) or ((ChooseColor shl 8) and $F800);
  FrameInfo := @FFrames[AFrame];
  FStream.Seek(FFrameOffs[AFrame] + SizeOf(TSglFrame), soBeginning);
  case FImageInfo.siFormat of
//------------------------------------------------------------------------------
    $02: //未压缩  （高速版本）
      begin
        for Y := 0 to FrameInfo.sfYBlocks - 1 do
          for X := 0 to FrameInfo.sfXBlocks - 1 do
          begin
            FStream.ReadBuffer(W, SizeOf(Byte));
            FStream.ReadBuffer(H, SizeOf(Byte));
            nSize := (H + 1) * (W + 1) * 2;
            if FStream.Position + nSize > FStream.Size then Exit;

            GetMem(lpSrc, nSize);
            try
              FStream.ReadBuffer(lpSrc^, nSize);

              lpSCur := lpSrc;
              lpDLine := PByte(Integer(ADst) + Y * 256 * AWidthBytes + X * 256 * 2);
              for J := 0 to H do
              begin
                lpDCur := PWord(lpDLine);
                for I := 0 to W do
                begin
                  Blend4444(Coloration4444(wColor, lpSCur^), lpDCur^);
                  //Blend4444(lpSCur^, lpDCur^);
                  Inc(lpSCur);
                  Inc(lpDCur);
                end;
                Inc(lpDLine, AWidthBytes);
              end;

            finally
              FreeMem(lpSrc);
            end;
          end;
        Result := True;
      end;
//------------------------------------------------------------------------------
    $82: //未压缩 有Alpha （高速版本）
      begin
        nSize := FrameInfo.sfHeight * FrameInfo.sfWidth * 2;
        if FStream.Position + nSize > FStream.Size then Exit;
        GetMem(lpSrc, nSize);
        try
          FStream.ReadBuffer(lpSrc^, nSize);

          nSize := FrameInfo.sfHeight * FrameInfo.sfWidth;
          if FStream.Position + nSize > FStream.Size then Exit;
          GetMem(lpAlpha, nSize);
          try
            FStream.ReadBuffer(lpAlpha^, nSize);

            lpACur := lpAlpha;
            lpSCur := lpSrc;
            lpDLine := PByte(ADst);
            for Y := 1 to FrameInfo.sfHeight do
            begin
              lpDCur := PWord(lpDLine);
              for X := 1 to FrameInfo.sfWidth do
              begin
                Blend5658(lpACur^, Coloration565(wColor, lpSCur^), lpDCur^);
                //Blend5658(lpACur^, lpSCur^, lpDCur^);
                Inc(lpACur);
                Inc(lpSCur);
                Inc(lpDCur);
              end;
              Inc(lpDLine, AWidthBytes);
            end;

            Result := True;
          finally
            FreeMem(lpAlpha);
          end;
        finally
          FreeMem(lpSrc);
        end;
      end;
//------------------------------------------------------------------------------
    $88: //未压缩  （高速版本）
      begin
        nSize := FrameInfo.sfHeight * FrameInfo.sfWidth * 2;
        if FStream.Position + nSize > FStream.Size then Exit;

        GetMem(lpSrc, nSize);
        try
          FStream.ReadBuffer(lpSrc^, nSize);

          lpSCur := lpSrc;
          lpDLine := PByte(ADst);
          for Y := 1 to FrameInfo.sfHeight do
          begin
            lpDCur := PWord(lpDLine);
            for X := 1 to FrameInfo.sfWidth do
            begin
              if (lpSCur^ <> $FF00) then
                lpDCur^ := Coloration565(wColor, lpSCur^);
                //lpDCur^ := lpSCur^;
              Inc(lpSCur);
              Inc(lpDCur);
            end;
            Inc(lpDLine, AWidthBytes);
          end;

          Result := True;
        finally
          FreeMem(lpSrc);
        end;

      end;
//------------------------------------------------------------------------------
    $06: //已压缩 有Alpha（高速版本）
      begin
        FStream.ReadBuffer(nSize, SizeOf(DWord));
        if FStream.Position + nSize > FStream.Size then Exit;
        I := FrameInfo.sfHeight * FrameInfo.sfWidth * 2;
        GetMem(lpSrc, I);
        try
          GetMem(lpData, nSize);
          try
            FStream.ReadBuffer(lpData^, nSize);
            SGL_RLE16_Decode(lpData, lpSrc, nSize, I);
          finally
            FreeMem(lpData);
          end;

          FStream.ReadBuffer(nSize, SizeOf(DWord));
          if FStream.Position + nSize > FStream.Size then Exit;
          I := FrameInfo.sfHeight * FrameInfo.sfWidth;
          GetMem(lpAlpha, I);
          try
            GetMem(lpData, nSize);
            try
              FStream.ReadBuffer(lpData^, nSize);
              SGL_RLE8_Decode(PByte(lpData), lpAlpha, nSize, I);
            finally
              FreeMem(lpData);
            end;

            lpACur := lpAlpha;
            lpSCur := lpSrc;
            lpDLine := PByte(ADst);
            for Y := 1 to FrameInfo.sfHeight do
            begin
              lpDCur := PWord(lpDLine);
              for X := 1 to FrameInfo.sfWidth do
              begin
                Blend5658(lpACur^, Coloration565(wColor, lpSCur^), lpDCur^);
                //Blend5658(lpACur^, lpSCur^, lpDCur^);
                Inc(lpACur);
                Inc(lpSCur);
                Inc(lpDCur);
              end;
              Inc(lpDLine, AWidthBytes);
            end;

            Result := True;
          finally
            FreeMem(lpAlpha);
          end;
        finally
          FreeMem(lpSrc);
        end;
      end;
//------------------------------------------------------------------------------
    $18: //已压缩  （高速版本）
      begin
        FStream.ReadBuffer(nSize, SizeOf(DWord));
        if FStream.Position + nSize > FStream.Size then Exit;

        I := FrameInfo.sfHeight * FrameInfo.sfWidth * 2;
        GetMem(lpSrc, I);
        try
          GetMem(lpData, nSize);
          try
            FStream.ReadBuffer(lpData^, nSize);
            SGL_RLE16_Decode(lpData, lpSrc, nSize, I);
          finally
            FreeMem(lpData);
          end;

          lpSCur := lpSrc;
          lpDLine := PByte(ADst);
          for Y := 1 to FrameInfo.sfHeight do
          begin
            lpDCur := PWord(lpDLine);
            for X := 1 to FrameInfo.sfWidth do
            begin
              if (lpSCur^ <> $FF00) then
                lpDCur^ := Coloration565(wColor, lpSCur^);
                //lpDCur^ := lpSCur^;
              Inc(lpSCur);
              Inc(lpDCur);
            end;
            Inc(lpDLine, AWidthBytes);
          end;

          Result := True;
        finally
          FreeMem(lpSrc);
        end;
      end;
//------------------------------------------------------------------------------
    $28: //已压缩  （高速版本）
      (*begin
        FStream.ReadBuffer(nSize, SizeOf(DWord));
        if FStream.Position + nSize > FStream.Size then Exit;

        I := FrameInfo.sfHeight * FrameInfo.sfWidth * 2;
        GetMem(lpSrc, I);
        try
          GetMem(lpData, nSize);
          try
            FStream.ReadBuffer(lpData^, nSize);
            //SGL_Decode1(PByte(lpData), PByte(lpSrc), FrameInfo.sfWidth, FrameInfo.sfHeight);
          finally
            FreeMem(lpData);
          end;

          lpSCur := lpSrc;
          lpDLine := PByte(ADst);
          for Y := 1 to FrameInfo.sfHeight do
          begin
            lpDCur := PWord(lpDLine);
            for X := 1 to FrameInfo.sfWidth do
            begin
              Blend4444(lpSCur^, lpDCur^);
              Inc(lpSCur);
              Inc(lpDCur);
            end;
            Inc(lpDLine, AWidthBytes);
          end;

          Result := True;
        finally
          FreeMem(lpSrc);
        end;
      end*);
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
    $11, $12: //已压缩  （高画质版本）
      begin
        for Y := 0 to FrameInfo.sfYBlocks - 1 do
          for X := 0 to FrameInfo.sfXBlocks - 1 do
          begin
            FStream.ReadBuffer(W, SizeOf(Byte));
            FStream.ReadBuffer(H, SizeOf(Byte));
            FStream.ReadBuffer(nSize, SizeOf(DWord));
            if FStream.Position + nSize > FStream.Size then Exit;

            I := (H + 1) * (W + 1) * 2;
            GetMem(lpSrc, I);
            try
              GetMem(lpData, nSize);
              try
                FStream.ReadBuffer(lpData^, nSize);
                SGL_RLE16_Decode(lpData, lpSrc, nSize, I);
              finally
                FreeMem(lpData);
              end;

              lpSCur := lpSrc;
              lpDLine := PByte(Integer(ADst) + Y * 256 * AWidthBytes + X * 256 * 2);
              for J := 0 to H do
              begin
                lpDCur := PWord(lpDLine);
                for I := 0 to W do
                begin
                  Blend4444(Coloration4444(wColor, lpSCur^), lpDCur^);
                  //Blend4444(lpSCur^, lpDCur^);
                  Inc(lpSCur);
                  Inc(lpDCur);
                end;
                Inc(lpDLine, AWidthBytes);
              end;

            finally
              FreeMem(lpSrc);
            end;
          end;
        Result := True;
      end;
//------------------------------------------------------------------------------
    $22: //已压缩  （高画质版本）
      begin
        for Y := 0 to FrameInfo.sfYBlocks - 1 do
          for X := 0 to FrameInfo.sfXBlocks - 1 do
          begin
            FStream.ReadBuffer(W, SizeOf(Byte));
            FStream.ReadBuffer(H, SizeOf(Byte));
            FStream.ReadBuffer(nSize, SizeOf(DWord));
            if FStream.Position + nSize > FStream.Size then Exit;

            I := (H + 1) * (W + 1) * 2;
            GetMem(lpSrc, I);
            try
              GetMem(lpData, nSize);
              try
                FStream.ReadBuffer(lpData^, nSize);
                SGL_Decode1(PByte(lpData), PByte(lpSrc), W + 1, H + 1);
              finally
                FreeMem(lpData);
              end;

              lpSCur := lpSrc;
              lpDLine := PByte(Integer(ADst) + Y * 256 * AWidthBytes + X * 256 * 2);
              for J := 0 to H do
              begin
                lpDCur := PWord(lpDLine);
                for I := 0 to W do
                begin
                  Blend4444(Coloration4444(wColor, lpSCur^), lpDCur^);
                  //Blend4444(lpSCur^, lpDCur^);
                  Inc(lpSCur);
                  Inc(lpDCur);
                end;
                Inc(lpDLine, AWidthBytes);
              end;

            finally
              FreeMem(lpSrc);
            end;
          end;
        Result := True;
      end;
//------------------------------------------------------------------------------
    $62: //已压缩  有Alpha通道（高画质版本）
      begin
        for Y := 0 to FrameInfo.sfYBlocks - 1 do
          for X := 0 to FrameInfo.sfXBlocks - 1 do
          begin
            FStream.ReadBuffer(W, SizeOf(Byte));
            FStream.ReadBuffer(H, SizeOf(Byte));
            FStream.ReadBuffer(nSize, SizeOf(DWord));
            if FStream.Position + nSize > FStream.Size then Exit;

            I := (H + 1) * (W + 1) * 2;
            GetMem(lpSrc, I);
            try
              GetMem(lpData, nSize);
              try
                FStream.ReadBuffer(lpData^, nSize);
                SGL_Decode1(PByte(lpData), PByte(lpSrc), W + 1, H + 1);
              finally
                FreeMem(lpData);
              end;

              FStream.ReadBuffer(nSize, SizeOf(DWord));
              if FStream.Position + nSize > FStream.Size then Exit;
              I := (H + 1) * (W + 1);
              GetMem(lpAlpha, I);
              try
                GetMem(lpData, nSize);
                try
                  FStream.ReadBuffer(lpData^, nSize);
                  SGL_RLE8_Decode2(PByte(lpData), lpAlpha, nSize, I);
                finally
                  FreeMem(lpData);
                end;

                lpACur := lpAlpha;
                lpSCur := lpSrc;
                lpDLine := PByte(Integer(ADst) + Y * 256 * AWidthBytes + X * 256 * 2);
                for J := 0 to H do
                begin
                  lpDCur := PWord(lpDLine);
                  for I := 0 to W do
                  begin
                    Blend4448(lpACur^, Coloration4444(wColor, lpSCur^), lpDCur^);
                    //Blend4448(lpACur^, lpSCur^, lpDCur^);
                    Inc(lpACur);
                    Inc(lpSCur);
                    Inc(lpDCur);
                  end;
                  Inc(lpDLine, AWidthBytes);
                end;

              finally
                FreeMem(lpAlpha);
              end;
            finally
              FreeMem(lpSrc);
            end;
          end;
        Result := True;
      end;
//------------------------------------------------------------------------------
  end;

end;

function TSglFile.DecodeFrame32(AFrame: Integer; ADst: PByte;
  AWidthBytes: Integer): Boolean;

var
  I: Integer;
  J: Integer;
  X: Integer;
  Y: Integer;
  W: Byte;
  H: Byte;
  nSize: DWord;
  lpSrc: PWord;
  lpData: PWord;
  lpAlpha: PByte;
  lpDLine: PByte;
  lpSCur: PWord;
  lpDCur: PDWord;
  lpACur: PByte;
  FrameInfo: PSglFrame;
begin
  Result := False;
  if (AFrame < Low(FFrames)) and (AFrame > High(FFrames)) then Exit;

  FrameInfo := @FFrames[AFrame];
  FStream.Seek(FFrameOffs[AFrame] + SizeOf(TSglFrame), soBeginning);
  case FImageInfo.siFormat of
//------------------------------------------------------------------------------
    $02: //未压缩  （高速版本）
      begin
        for Y := 0 to FrameInfo.sfYBlocks - 1 do
          for X := 0 to FrameInfo.sfXBlocks - 1 do
          begin
            FStream.ReadBuffer(W, SizeOf(Byte));
            FStream.ReadBuffer(H, SizeOf(Byte));
            nSize := (H + 1) * (W + 1) * 2;
            if FStream.Position + nSize > FStream.Size then Exit;

            GetMem(lpSrc, nSize);
            try
              FStream.ReadBuffer(lpSrc^, nSize);

              lpSCur := lpSrc;
              lpDLine := PByte(Integer(ADst) + Y * 256 * AWidthBytes + X * 256 * 4);
              for J := 0 to H do
              begin
                lpDCur := PDWord(lpDLine);
                for I := 0 to W do
                begin
                  //Blend(lpSCur^, lpDCur^);
                  lpDCur^ := (lpSCur^ and $F000 shl 16) or //Alpha
                    (lpSCur^ and $0F00 shl 12) or //Red
                    (lpSCur^ and $00F0 shl 8) or //Green
                    (lpSCur^ and $000F shl 4); //Blue
                  Inc(lpSCur);
                  Inc(lpDCur);
                end;
                Inc(lpDLine, AWidthBytes);
              end;

            finally
              FreeMem(lpSrc);
            end;
          end;
        Result := True;
      end;
//------------------------------------------------------------------------------
    $82: //未压缩 有Alpha （高速版本）
      begin
        nSize := FrameInfo.sfHeight * FrameInfo.sfWidth * 2;
        if FStream.Position + nSize > FStream.Size then Exit;
        GetMem(lpSrc, nSize);
        try
          FStream.ReadBuffer(lpSrc^, nSize);

          nSize := FrameInfo.sfHeight * FrameInfo.sfWidth;
          if FStream.Position + nSize > FStream.Size then Exit;
          GetMem(lpAlpha, nSize);
          try
            FStream.ReadBuffer(lpAlpha^, nSize);

            lpACur := lpAlpha;
            lpSCur := lpSrc;
            lpDLine := PByte(ADst);
            for Y := 1 to FrameInfo.sfHeight do
            begin
              lpDCur := PDWord(lpDLine);
              for X := 1 to FrameInfo.sfWidth do
              begin
                //AlphaBlend(lpACur^, lpSCur^, lpDCur^);
                lpDCur^ := (lpACur^ shl 24) or //Alpha
                  (lpSCur^ and $F800 shl 8) or //Red
                  (lpSCur^ and $07E0 shl 5) or //Green
                  (lpSCur^ and $001F shl 3); //Blue
                Inc(lpACur);
                Inc(lpSCur);
                Inc(lpDCur);
              end;
              Inc(lpDLine, AWidthBytes);
            end;

            Result := True;
          finally
            FreeMem(lpAlpha);
          end;
        finally
          FreeMem(lpSrc);
        end;
      end;
//------------------------------------------------------------------------------
    $88: //未压缩  （高速版本）
      begin
        nSize := FrameInfo.sfHeight * FrameInfo.sfWidth * 2;
        if FStream.Position + nSize > FStream.Size then Exit;

        GetMem(lpSrc, nSize);
        try
          FStream.ReadBuffer(lpSrc^, nSize);

          lpSCur := lpSrc;
          lpDLine := PByte(ADst);
          for Y := 1 to FrameInfo.sfHeight do
          begin
            lpDCur := PDWord(lpDLine);
            for X := 1 to FrameInfo.sfWidth do
            begin
              //if (lpSCur^ <> $FF00) then lpDCur^ := lpSCur^;
              lpDCur^ := $FF000000 or //Alpha
                (lpSCur^ and $F800 shl 8) or //Red
                (lpSCur^ and $07E0 shl 5) or //Green
                (lpSCur^ and $001F shl 3); //Blue
              Inc(lpSCur);
              Inc(lpDCur);
            end;
            Inc(lpDLine, AWidthBytes);
          end;

          Result := True;
        finally
          FreeMem(lpSrc);
        end;

      end;
//------------------------------------------------------------------------------
    $06: //已压缩 有Alpha（高速版本）
      begin
        FStream.ReadBuffer(nSize, SizeOf(DWord));
        if FStream.Position + nSize > FStream.Size then Exit;
        I := FrameInfo.sfHeight * FrameInfo.sfWidth * 2;
        GetMem(lpSrc, I);
        try
          GetMem(lpData, nSize);
          try
            FStream.ReadBuffer(lpData^, nSize);
            SGL_RLE16_Decode(lpData, lpSrc, nSize, I);
          finally
            FreeMem(lpData);
          end;

          FStream.ReadBuffer(nSize, SizeOf(DWord));
          if FStream.Position + nSize > FStream.Size then Exit;
          I := FrameInfo.sfHeight * FrameInfo.sfWidth;
          GetMem(lpAlpha, I);
          try
            GetMem(lpData, nSize);
            try
              FStream.ReadBuffer(lpData^, nSize);
              SGL_RLE8_Decode(PByte(lpData), lpAlpha, nSize, I);
            finally
              FreeMem(lpData);
            end;

            lpACur := lpAlpha;
            lpSCur := lpSrc;
            lpDLine := PByte(ADst);
            for Y := 1 to FrameInfo.sfHeight do
            begin
              lpDCur := PDWord(lpDLine);
              for X := 1 to FrameInfo.sfWidth do
              begin
                //AlphaBlend(lpACur^, lpSCur^, lpDCur^);
                lpDCur^ := (lpACur^ shl 24) or //Alpha
                  (lpSCur^ and $F800 shl 8) or //Red
                  (lpSCur^ and $07E0 shl 5) or //Green
                  (lpSCur^ and $001F shl 3); //Blue
                Inc(lpACur);
                Inc(lpSCur);
                Inc(lpDCur);
              end;
              Inc(lpDLine, AWidthBytes);
            end;

            Result := True;
          finally
            FreeMem(lpAlpha);
          end;
        finally
          FreeMem(lpSrc);
        end;
      end;
//------------------------------------------------------------------------------
    $18: //已压缩  （高速版本）
      begin
        FStream.ReadBuffer(nSize, SizeOf(DWord));
        if FStream.Position + nSize > FStream.Size then Exit;

        I := FrameInfo.sfHeight * FrameInfo.sfWidth * 2;
        GetMem(lpSrc, I);
        try
          GetMem(lpData, nSize);
          try
            FStream.ReadBuffer(lpData^, nSize);
            SGL_RLE16_Decode(lpData, lpSrc, nSize, I);
          finally
            FreeMem(lpData);
          end;

          lpSCur := lpSrc;
          lpDLine := PByte(ADst);
          for Y := 1 to FrameInfo.sfHeight do
          begin
            lpDCur := PDWord(lpDLine);
            for X := 1 to FrameInfo.sfWidth do
            begin
              //if (lpSCur^ <> $FF00) then lpDCur^ := lpSCur^;
              lpDCur^ := $FF000000 or //Alpha
                (lpSCur^ and $F800 shl 8) or //Red
                (lpSCur^ and $07E0 shl 5) or //Green
                (lpSCur^ and $001F shl 3); //Blue
              Inc(lpSCur);
              Inc(lpDCur);
            end;
            Inc(lpDLine, AWidthBytes);
          end;

          Result := True;
        finally
          FreeMem(lpSrc);
        end;
      end;
//------------------------------------------------------------------------------
    $28: ;
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
    $11, $12: //已压缩  （高画质版本）
      begin
        for Y := 0 to FrameInfo.sfYBlocks - 1 do
          for X := 0 to FrameInfo.sfXBlocks - 1 do
          begin
            FStream.ReadBuffer(W, SizeOf(Byte));
            FStream.ReadBuffer(H, SizeOf(Byte));
            FStream.ReadBuffer(nSize, SizeOf(DWord));
            if FStream.Position + nSize > FStream.Size then Exit;

            I := (H + 1) * (W + 1) * 2;
            GetMem(lpSrc, I);
            try
              GetMem(lpData, nSize);
              try
                FStream.ReadBuffer(lpData^, nSize);
                SGL_RLE16_Decode(lpData, lpSrc, nSize, I);
              finally
                FreeMem(lpData);
              end;

              lpSCur := lpSrc;
              lpDLine := PByte(Integer(ADst) + Y * 256 * AWidthBytes + X * 256 * 4);
              for J := 0 to H do
              begin
                lpDCur := PDWord(lpDLine);
                for I := 0 to W do
                begin
                  //Blend(lpSCur^, lpDCur^);
                  lpDCur^ := (lpSCur^ and $F000 shl 16) or //Alpha
                    (lpSCur^ and $0F00 shl 12) or //Red
                    (lpSCur^ and $00F0 shl 8) or //Green
                    (lpSCur^ and $000F shl 4); //Blue
                  Inc(lpSCur);
                  Inc(lpDCur);
                end;
                Inc(lpDLine, AWidthBytes);
              end;

            finally
              FreeMem(lpSrc);
            end;
          end;
        Result := True;
      end;
//------------------------------------------------------------------------------
    $22: //已压缩  （高画质版本）
      begin
        for Y := 0 to FrameInfo.sfYBlocks - 1 do
          for X := 0 to FrameInfo.sfXBlocks - 1 do
          begin
            FStream.ReadBuffer(W, SizeOf(Byte));
            FStream.ReadBuffer(H, SizeOf(Byte));
            FStream.ReadBuffer(nSize, SizeOf(DWord));
            if FStream.Position + nSize > FStream.Size then Exit;

            I := (H + 1) * (W + 1) * 2;
            GetMem(lpSrc, I);
            try
              GetMem(lpData, nSize);
              try
                FStream.ReadBuffer(lpData^, nSize);
                SGL_Decode1(PByte(lpData), PByte(lpSrc), W + 1, H + 1);
              finally
                FreeMem(lpData);
              end;

              lpSCur := lpSrc;
              lpDLine := PByte(Integer(ADst) + Y * 256 * AWidthBytes + X * 256 * 4);
              for J := 0 to H do
              begin
                lpDCur := PDWord(lpDLine);
                for I := 0 to W do
                begin
                  //Blend4444(lpSCur^, lpDCur^);
                  lpDCur^ := (lpSCur^ and $F000 shl 16) or //Alpha
                    (lpSCur^ and $0F00 shl 12) or //Red
                    (lpSCur^ and $00F0 shl 8) or //Green
                    (lpSCur^ and $000F shl 4); //Blue
                  Inc(lpSCur);
                  Inc(lpDCur);
                end;
                Inc(lpDLine, AWidthBytes);
              end;

            finally
              FreeMem(lpSrc);
            end;
          end;
        Result := True;
      end;
//------------------------------------------------------------------------------
    $62: //已压缩  有Alpha通道（高画质版本）
      begin
        for Y := 0 to FrameInfo.sfYBlocks - 1 do
          for X := 0 to FrameInfo.sfXBlocks - 1 do
          begin
            FStream.ReadBuffer(W, SizeOf(Byte));
            FStream.ReadBuffer(H, SizeOf(Byte));
            FStream.ReadBuffer(nSize, SizeOf(DWord));
            if FStream.Position + nSize > FStream.Size then Exit;

            I := (H + 1) * (W + 1) * 2;
            GetMem(lpSrc, I);
            try
              GetMem(lpData, nSize);
              try
                FStream.ReadBuffer(lpData^, nSize);
                SGL_Decode1(PByte(lpData), PByte(lpSrc), W + 1, H + 1);
              finally
                FreeMem(lpData);
              end;

              FStream.ReadBuffer(nSize, SizeOf(DWord));
              if FStream.Position + nSize > FStream.Size then Exit;
              I := (H + 1) * (W + 1);
              GetMem(lpAlpha, I);
              try
                GetMem(lpData, nSize);
                try
                  FStream.ReadBuffer(lpData^, nSize);
                  SGL_RLE8_Decode2(PByte(lpData), lpAlpha, nSize, I);
                finally
                  FreeMem(lpData);
                end;

                lpACur := lpAlpha;
                lpSCur := lpSrc;
                lpDLine := PByte(Integer(ADst) + Y * 256 * AWidthBytes + X * 256 * 4);
                for J := 0 to H do
                begin
                  lpDCur := PDWord(lpDLine);
                  for I := 0 to W do
                  begin
                    //Blend4448(lpACur^, lpSCur^, lpDCur^);
                    lpDCur^ := (lpACur^ shl 24) or //Alpha
                      (lpSCur^ and $0F00 shl 12) or //Red
                      (lpSCur^ and $00F0 shl 8) or //Green
                      (lpSCur^ and $000F shl 4); //Blue
                    Inc(lpACur);
                    Inc(lpSCur);
                    Inc(lpDCur);
                  end;
                  Inc(lpDLine, AWidthBytes);
                end;

              finally
                FreeMem(lpAlpha);
              end;
            finally
              FreeMem(lpSrc);
            end;
          end;
        Result := True;
      end;
//------------------------------------------------------------------------------
  end;

end;

destructor TSglFile.Destroy;
begin
  Close;
  inherited;
end;

function TSglFile.GetFrame(Index: Integer): PSglFrame;
begin
  if (Index >= Low(FFrames)) and (Index <= High(FFrames)) then
    Result := @FFrames[Index]
  else
    Result := nil;
end;

function TSglFile.GetFrameCount: Integer;
begin
  Result := FImageInfo.siFrames;
end;

function TSglFile.GetFrameOffset(Index: Integer): DWord;
begin
  if (Index >= Low(FFrameOffs)) and (Index <= High(FFrameOffs)) then
    Result := FFrameOffs[Index]
  else
    Result := 0;
end;

function TSglFile.GetImage(Index: Integer): PSglImage;
begin
  if (Index >= Low(FImageOffs)) and (Index <= High(FImageOffs)) and (FImageOffs[Index] <> 0) then
  begin
    FStream.Position := FImageOffs[Index];
    FStream.ReadBuffer(FDumpImageInfo, SizeOf(TSglImage));
    Result := @FDumpImageInfo;
  end
  else
    Result := nil;

end;

function TSglFile.GetImageCount: Integer;
begin
  Result := FImageCount;
end;

function TSglFile.GetImageOffset(Index: Integer): DWord;
begin
  if (Index >= Low(FImageOffs)) and (Index <= High(FImageOffs)) then
    Result := FImageOffs[Index]
  else
    Result := 0;
end;

function TSglFile.Open(FileName: string): Boolean;
begin
  Close;
  Result := False;
  FStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    FStream.ReadBuffer(FHeaderInfo, SizeOf(TSglHeader));
    if AnsiCompareStr(FHeaderInfo.shTitle, Sgl_Title) <> 0 then Exit;

    FStream.Position := FHeaderInfo.shOffset;
    FStream.ReadBuffer(FImageCount, SizeOf(Integer));
    if Integer(FHeaderInfo.shOffset) + FImageCount * (SizeOf(DWord) + 16) > FStream.Size then Exit;
    SetLength(FImageOffs, FImageCount);
    FStream.ReadBuffer(FImageOffs[0], Length(FImageOffs) * SizeOf(DWord));

    FFileName := FileName;
    Result := True;
  finally
    if not Result then Close;
  end;
end;

procedure TSglFile.ReadFrames;
var
  I: Integer;
  nSize: Integer;
  nBlocks: Integer;
begin
    {Showmessage('FImageCount:'+IntToStr(FImageCount));
    Showmessage('FImageOffs[FImageIndex]:'+IntToStr(FImageOffs[FImageIndex]));}
  FStream.Position := FImageOffs[FImageIndex];
  FStream.ReadBuffer(FImageInfo, SizeOf(TSglImage));
  I := FImageInfo.siFrames;
  SetLength(FFrames, I);
  SetLength(FFrameOffs, I);
  FillChar(FFrames[0], I * SizeOf(TSglFrame), 0);
  FillChar(FFrameOffs[0], I * SizeOf(DWord), 0);
  for I := 0 to I - 1 do
  begin
    FFrameOffs[I] := FStream.Position;
    FStream.ReadBuffer(FFrames[I], SizeOf(TSglFrame));
    with FFrames[I] do
      case FImageInfo.siFormat of
        $82: //未压缩 有Alpha （高速版本）
          begin
            nSize := sfHeight * sfWidth * 4;
            FStream.Seek(nSize, soCurrent);
          end;

        $88: //未压缩  （高速版本）
          begin
            nSize := sfHeight * sfWidth * 2;
            FStream.Seek(nSize, soCurrent);
          end;

        $06: //已压缩 有Alpha（高速版本）
          begin
            FStream.ReadBuffer(nSize, SizeOf(Integer));
            FStream.Seek(nSize, soCurrent);
            FStream.ReadBuffer(nSize, SizeOf(Integer));
            FStream.Seek(nSize, soCurrent);
          end;

        $18, $28: //已压缩  （高速版本）
          begin
            FStream.ReadBuffer(nSize, SizeOf(Integer));
            FStream.Seek(nSize, soCurrent);
          end;

        $02: //未压缩 （高速版本）
          begin
            nBlocks := sfXBlocks * sfYBlocks;
            for nBlocks := 1 to nBlocks do
            begin
              FStream.ReadBuffer(nSize, SizeOf(Word));
              FStream.Seek((nSize and $00FF) * (nSize and $FF00) * 2, soCurrent);
            end;
          end;

        $11, $12, $22: //已压缩  （高画质版本）
          begin
            nBlocks := sfXBlocks * sfYBlocks;
            for nBlocks := 1 to nBlocks do
            begin
              FStream.Seek(2, soCurrent);
              FStream.ReadBuffer(nSize, SizeOf(Integer));
              FStream.Seek(nSize, soCurrent);
            end;
          end;

        $62: //已压缩  有Alpha（高画质版本）
          begin
            nBlocks := sfXBlocks * sfYBlocks;
            for nBlocks := 1 to nBlocks do
            begin
              FStream.Seek(2, soCurrent);
              FStream.ReadBuffer(nSize, SizeOf(Integer));
              FStream.Seek(nSize, soCurrent);
              FStream.ReadBuffer(nSize, SizeOf(Integer));
              FStream.Seek(nSize, soCurrent);
            end;
          end;

      else
        Break;
      end;
  end;
end;

procedure TSglFile.SetImageIndex(const Value: Integer);
begin
  if FImageIndex = Value then Exit;

  if (Value < Low(FImageOffs)) or (Value > High(FImageOffs)) then Exit;
  FImageIndex := Value;
  if FImageOffs[Value] <> 0 then
  begin
    FStream.Position := FImageOffs[Value];
    ReadFrames;
  end
  else
  begin
    SetLength(FFrames, 0);
    SetLength(FFrameOffs, 0);
    FillChar(FImageInfo, SizeOf(TSglImage), 0);
    //Showmessage('TSglFile.SetImageIndex');
  end;
end;

procedure TSglFile.LoadAllImages(List: TList);
var
  I, J, nCount: Integer;
  BM: TBitmap;
  Image: PSglImage;
begin
  nCount := 0;
  try
    BM := TBitmap.Create;
    BM.PixelFormat := pf16Bit;
    BM.Canvas.Brush.Color := clWhite;
    for I := 0 to FImageCount - 1 do begin
      Image := Images[I];
      ImageIndex := I;
      if (Image <> nil) and (Image.siFrames > 0) and (FrameCount > 0) then begin
        for J := 0 to FrameCount - 1 do begin
          if Frames[J] <> nil then begin
            with Frames[J]^ do begin
              if (sfWidth > 0) and (sfHeight > 0) then begin
                BM.Handle := 0;
                BM.Canvas.Brush.Color := clWhite;
                BM.PixelFormat := pf16Bit;
                BM.Width := sfWidth;
                BM.Height := sfHeight;

                DecodeFrame16(J, PByte(BM.ScanLine[0]), -((sfWidth * 2 + 3) and $FFFFFFFC));
                BM.SaveToFile('1\' + IntToStr(nCount) + '.BMP');
              end;
             // List.Add(BM);
          //BM := nil;
              Application.ProcessMessages;
              Inc(nCount);
            end;
          end;
        end;
      end;
    end;
  except
    ShowMessage(IntToStr(nCount));
  end;
end;

end.
