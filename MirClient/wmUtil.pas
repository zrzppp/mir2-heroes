unit wmutil;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, DIB,
  DXDraws, DXClass;

type

  TWMImageHeader = record
    Title: string[40]; //'WEMADE Entertainment inc.'
    ImageCount: integer;
    ColorCount: integer;
    PaletteSize: integer;
    VerFlag: integer;
  end;

{
   TWMImageHeader = record
      Title: string[40];        //'WEMADE Entertainment inc.'
      ImageCount: integer;
      ColorCount: integer;
      PaletteSize: integer;
   end;
}
  PTWMImageHeader = ^TWMImageHeader;

  TWMImageInfo = record
    nWidth: SmallInt;
    nHeight: SmallInt;
    px: SmallInt;
    py: SmallInt;
    bits: PByte;
  end;
  PTWMImageInfo = ^TWMImageInfo;

  TDataHeader = record //iamwgh新定义的ids文件头
    Title: string[40];
    Size: DWORD;
    ImageCount: DWORD;
    Planes: LongWord;
    BitCount: word;
    Compression: word;
  end;
  PTDataHeader = ^TDataHeader;

  TDataImageInfo = record //iamwgh新定义ids图片信息
    nWidth: SmallInt;
    nHeight: SmallInt;
    px: SmallInt;
    py: SmallInt;
    nSize: uint; //数据大小
  end;
  PTDataImageInfo = ^TDataImageInfo;

  TWMIndexHeader = record
    Title: string[40]; //'WEMADE Entertainment inc.'
    IndexCount: integer;
    VerFlag: integer;
  end;

  PTWMIndexHeader = ^TWMIndexHeader;

  TWMIndexInfo = record
    Position: integer;
    Size: integer;
  end;
  PTWMIndexInfo = ^TWMIndexInfo;

{  TDxImage = record
    nPx: SmallInt;
    nPy: SmallInt;
    Surface: TTexture;
    dwLatestTime: LongWord;
  end;
  PTDxImage = ^TDxImage;   }


function WidthBytes(w: integer): integer;
function PaletteFromBmpInfo(BmpInfo: PBitmapInfo): HPalette;
function MakeBmp(w, h: integer; bits: pointer; pal: TRGBQuads): TBitmap;
procedure DrawBits(Canvas: TCanvas; XDest, YDest: integer; PSource: PByte; Width, Height: integer);

implementation


function WidthBytes(w: integer): integer;
begin
  Result := (((w * 8) + 31) div 32) * 4;
end;

function PaletteFromBmpInfo(BmpInfo: PBitmapInfo): HPalette;
var
  PalSize, n: integer;
  Palette: PLogPalette;
begin
     //Allocate Memory for Palette
  PalSize := SizeOf(TLogPalette) + (256 * SizeOf(TPaletteEntry));
  Palette := AllocMem(PalSize);

     //Fill in structure
  with Palette^ do
  begin
    palVersion := $300;
    palNumEntries := 256;
    for n := 0 to 255 do
    begin
      palPalEntry[n].peRed := BmpInfo^.bmiColors[n].rgbRed;
      palPalEntry[n].peGreen := BmpInfo^.bmiColors[n].rgbGreen;
      palPalEntry[n].peBlue := BmpInfo^.bmiColors[n].rgbBlue;
      palPalEntry[n].peFlags := 0;
    end;
  end;
  Result := CreatePalette(Palette^);
  FreeMem(Palette, PalSize);
end;

procedure CreateDIB256(var bmp: TBitmap; BmpInfo: PBitmapInfo; bits: PByte);
var
  DC, MemDc: hdc;
  OldPal: HPalette;
begin
  DC := 0;
  MemDc := 0; //jacky
   //First Release Handle and Palette from BMP
  DeleteObject(bmp.ReleaseHandle);
  DeleteObject(bmp.ReleasePalette);

  try
    DC := GetDC(0);
    try
      MemDc := CreateCompatibleDC(DC);
      DeleteObject(SelectObject(MemDc, CreateCompatibleBitmap(DC, 1, 1)));

      OldPal := 0;
      bmp.Palette := PaletteFromBmpInfo(BmpInfo);
      OldPal := SelectPalette(MemDc, bmp.Palette, False);
      RealizePalette(MemDc);
      try
        bmp.handle := CreateDIBitmap(MemDc, BmpInfo^.bmiHeader, CBM_INIT,
          pointer(bits), BmpInfo^, DIB_RGB_COLORS);
      finally
        if OldPal <> 0 then
          SelectPalette(MemDc, OldPal, True);
      end;
    finally
      if MemDc <> 0 then
        DeleteDC(MemDc);
    end;
  finally
    if DC <> 0 then
      ReleaseDC(0, DC);
  end;
  if bmp.handle = 0 then
    Exception.Create('CreateDIBitmap failed');
end;

function MakeBmp(w, h: integer; bits: pointer; pal: TRGBQuads): TBitmap;
var
  I: integer;
  BmpInfo: PBitmapInfo;
  HeaderSize: integer;
  bmp: TBitmap;
begin
  HeaderSize := SizeOf(TBitmapInfo) + (256 * SizeOf(TRGBQuad));
  GetMem(BmpInfo, HeaderSize);
  for I := 0 to 255 do begin
    BmpInfo.bmiColors[I] := pal[I];
  end;
  with BmpInfo^.bmiHeader do begin
    biSize := SizeOf(TBitmapInfoHeader);
    biWidth := w;
    biHeight := h;
    biPlanes := 1;
    biBitCount := 8; //8bit
    biCompression := BI_RGB;
    biClrUsed := 0;
    biClrImportant := 0;
  end;
  bmp := TBitmap.Create;
  CreateDIB256(bmp, BmpInfo, bits);
  FreeMem(BmpInfo);
  Result := bmp;
end;

procedure DrawBits(Canvas: TCanvas; XDest, YDest: integer; PSource: PByte; Width, Height: integer);
var
  HeaderSize: integer;
  BmpInfo: PBitmapInfo;
begin
  if PSource = nil then Exit;

  HeaderSize := SizeOf(TBitmapInfo) + (256 * SizeOf(TRGBQuad));
  BmpInfo := AllocMem(HeaderSize);
  if BmpInfo = nil then raise Exception.Create('TNoryImg: Failed to allocate a DIB');
  with BmpInfo^.bmiHeader do begin
    biSize := SizeOf(TBitmapInfoHeader);
    biWidth := Width;
    biHeight := -Height;
    biPlanes := 1;
    biBitCount := 8;
    biCompression := BI_RGB;
    biClrUsed := 0;
    biClrImportant := 0;
  end;
  SetDIBitsToDevice(Canvas.handle, XDest, YDest, Width, Height, 0, 0, 0, Height,
    PSource, BmpInfo^, DIB_RGB_COLORS);
  FreeMem(BmpInfo, HeaderSize);
end;

end.

