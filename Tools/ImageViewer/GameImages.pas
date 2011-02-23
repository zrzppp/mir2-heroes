unit GameImages;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, StrUtils, DIB, HUtil32, Dialogs, MapFiles;
type
  TImageType = (t_Wil, t_Wis, t_Fir, t_GT);

  TWMImageHeader = record //WIL头
    Title: string[40]; //'WEMADE Entertainment inc.'
    ImageCount: Integer;
    ColorCount: LongWord;
    PaletteSize: Integer;
    VerFlag: Integer;
  end;
  PTWMImageHeader = ^TWMImageHeader;

  TWMImageInfo = record //WIL数据
    nWidth: SmallInt;
    nHeight: SmallInt;
    px: SmallInt;
    py: SmallInt;
    Bits: PByte;
  end;
  pTWMImageInfo = ^TWMImageInfo;

  TWMIndexHeader = record
    Title: string[40]; //'WEMADE Entertainment inc.'
    IndexCount: Integer;
    VerFlag: Integer;
  end;
  pTWMIndexHeader = ^TWMIndexHeader;

  TWMIndexInfo = record
    Position: Integer;
    Size: Integer;
  end;
  pTWMIndexInfo = ^TWMIndexInfo;

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

  TDataHeader = record //新定义的Data文件头
    Title: string[40];
    Size: DWORD;
    ImageCount: DWORD;
    IndexOffSet: LongWord;
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


  TNewWilHeader = packed record
    Comp: Smallint;
    Title: array[0..19] of Char;
    Ver: Smallint;
    ImageCount: Integer;
  end;

  TNewWilImageInfo = packed record
    Width: Smallint;
    Height: Smallint;
    Px: Smallint;
    Py: SmallInt;
    Shadow: Byte;
    Shadowx: Smallint;
    Shadowy: Smallint;
    Length: Integer;
  end;
  pTNewWilImageInfo = ^TNewWilImageInfo;

  TNewWilImageData = packed record
    Width: Smallint;
    Height: Smallint;
    Px: Smallint;
    Py: SmallInt;
    Shadow: Byte;
    Shadowx: Smallint;
    Shadowy: Smallint;
    Length: Integer;
    PBits: PByte;
  end;
  pTNewWilImageData = ^TNewWilImageData;

  TNewWixHeader = packed record
    Title: array[0..19] of char;
    ImageCount: Integer;
  end;
  TXY = array[0..65536] of Integer;

  TBitmapInfo = packed record
    BitMap: TDIB;
    LastTick: LongWord;
  end;

  TMirImages = class
    m_IndexList: TList;
    m_FileStream: TFileStream;
  private
    FFileName: string;
    FImageCount: Integer;
    FImageType: TImageType;
    FBitCount: Integer;
    FInitialized: Boolean;

    Source: TDIB;
    procedure DrawZoomEx(ABitmap: TGraphic; DC: HDC; X, Y, Width, Height: Integer);
  protected
    function GetBitmap(Index: Integer): TDIB; virtual; abstract;
    function GetPoint(Index: Integer): TPoint; virtual; abstract;
    procedure SetPoint(Index: Integer; Value: TPoint); virtual; abstract;
  public

    constructor Create(const AFileName: string; const Image: TImageType); virtual;
    destructor Destroy; override;

    function FillDIB: TDIB; virtual;
    procedure ReverseDIB(DIB: TDIB);
    procedure Initialize; virtual;
    procedure Finalize; virtual;

    function CreateFile(ABitCount: Byte = 8): Boolean;
    procedure StretchBlt(Index: Integer; DC: HDC; X, Y: Integer; var Width, Height: Integer; ROP: Cardinal);

    function Get(Index: Integer; var PX, PY: Integer): TDIB; virtual; abstract;

    function Add(Source: TDIB; X, Y: Integer): Boolean; virtual; abstract;
    function Delete(StartIndex, StopIndex: Integer): Boolean; virtual; abstract;
    function Fill(StartIndex, StopIndex: Integer): Boolean; virtual; abstract;

    function StartReplace(StartIndex, StopIndex: Integer; var Position: Int64; var P: Pointer; var Size: Int64): Boolean; virtual; abstract;
    function StopReplace(StartIndex, StopIndex: Integer; Position: Int64; P: Pointer; Size: Int64): Boolean; virtual; abstract;
    function Replace(Index: Integer; Source: TDIB): Boolean; overload; virtual; abstract;
    function Replace(Index: Integer; Source: TDIB; X, Y: Integer): Boolean; overload; virtual; abstract;

    function StartInsert(Index: Integer; var P: Pointer; var Size: Int64): Boolean; virtual; abstract;
    function StopInsert(Index, InsertCount, InsertSize: Integer; P: Pointer; Size: Int64): Boolean; virtual; abstract;
    function Insert(Index: Integer; Source: TDIB; X, Y: Integer): Boolean; virtual; abstract;

    property FileName: string read FFileName write FFileName;
    property Bitmaps[Index: Integer]: TDIB read GetBitmap;

    property ImageCount: Integer read FImageCount write FImageCount;
    property ImagePoint[Index: Integer]: TPoint read GetPoint write SetPoint;
    property ImageType: TImageType read FImageType write FImageType;
    property BitCount: Integer read FBitCount write FBitCount;
    property Initialized: Boolean read FInitialized write FInitialized;
  end;

  TWil = class(TMirImages)
  private
    btVersion: Byte;
    FHeader: TWMImageHeader;
    procedure LoadIndex;
    procedure LoadPalette;
  protected
    function GetBitmap(Index: Integer): TDIB; override;
    function GetPoint(Index: Integer): TPoint; override;
    procedure SetPoint(Index: Integer; Value: TPoint); override;
  public
    RGBQuads: TRGBQuads;
    constructor Create(const AFileName: string);
    destructor Destroy; override;

    procedure Initialize; override;
    procedure Finalize; override;

    function Add(DIB: TDIB; X, Y: Integer): Boolean; override;
    function Delete(StartIndex, StopIndex: Integer): Boolean; override;
    function Fill(StartIndex, StopIndex: Integer): Boolean; override;

    function StartInsert(Index: Integer; var P: Pointer; var Size: Int64): Boolean; override;
    function StopInsert(Index, InsertCount, InsertSize: Integer; P: Pointer; Size: Int64): Boolean; override;
    function Insert(Index: Integer; DIB: TDIB; X, Y: Integer): Boolean; override;

    function StartReplace(StartIndex, StopIndex: Integer; var Position: Int64; var P: Pointer; var Size: Int64): Boolean; override;
    function StopReplace(StartIndex, StopIndex: Integer; Position: Int64; P: Pointer; Size: Int64): Boolean; override;
    function Replace(Index: Integer; DIB: TDIB): Boolean; overload; override;
    function Replace(Index: Integer; DIB: TDIB; X, Y: Integer): Boolean; overload; override;

    function Get(Index: Integer; var PX, PY: Integer): TDIB; override;
  end;

  TWis = class(TMirImages)
  private
    FIndexOffset: Integer;
    function LoadIndex: Boolean;
    function Decode(ASrc: PByte; DIB: TDIB; ASrcSize: Integer): Integer;
    function DecodeWis(ASrc, ADst: PByte; ASrcSize, ADstSize: Integer): Boolean;
  protected
    function GetBitmap(Index: Integer): TDIB; override;
    function GetPoint(Index: Integer): TPoint; override;
    procedure SetPoint(Index: Integer; Value: TPoint); override;
  public
    constructor Create(const AFileName: string);
    destructor Destroy; override;
    function FillDIB: TDIB; override;
    procedure Initialize; override;
    procedure Finalize; override;

    function Add(DIB: TDIB; X, Y: Integer): Boolean; override;
    function Delete(StartIndex, StopIndex: Integer): Boolean; overload; override;
    function Fill(StartIndex, StopIndex: Integer): Boolean; override;

    function Insert(Index: Integer; DIB: TDIB; X, Y: Integer): Boolean; overload; override;
    function Replace(Index: Integer; DIB: TDIB): Boolean; override;

    function Get(Index: Integer; var PX, PY: Integer): TDIB; override;
  end;

  TData = class(TMirImages)
  private
    FHeader: TDataHeader;
    procedure LoadIndex;
  protected
    function GetBitmap(Index: Integer): TDIB; override;
    function GetPoint(Index: Integer): TPoint; override;
    procedure SetPoint(Index: Integer; Value: TPoint); override;
  public
    constructor Create(const AFileName: string);
    destructor Destroy; override;

    procedure Initialize; override;
    procedure Finalize; override;

    function Add(DIB: TDIB; X, Y: Integer): Boolean; override;
    function Delete(StartIndex, StopIndex: Integer): Boolean; override;
    function Fill(StartIndex, StopIndex: Integer): Boolean; override;

    function StartInsert(Index: Integer; var P: Pointer; var Size: Int64): Boolean; override;
    function StopInsert(Index, InsertCount, InsertSize: Integer; P: Pointer; Size: Int64): Boolean; override;
    function Insert(Index: Integer; DIB: TDIB; X, Y: Integer): Boolean; override;

    function StartReplace(StartIndex, StopIndex: Integer; var Position: Int64; var P: Pointer; var Size: Int64): Boolean; override;
    function StopReplace(StartIndex, StopIndex: Integer; Position: Int64; P: Pointer; Size: Int64): Boolean; override;
    function Replace(Index: Integer; DIB: TDIB): Boolean; overload; override;
    function Replace(Index: Integer; DIB: TDIB; X, Y: Integer): Boolean; overload; override;

    function Get(Index: Integer; var PX, PY: Integer): TDIB; override;
    property Compression: Word read FHeader.Compression;
  end;
function WidthBytes(w: Integer): Integer;
var
  MainPalette: TRGBQuads;
implementation
uses MirShare;

function WidthBytes(w: Integer): Integer;
begin
  Result := (((w * 8) + 31) div 32) * 4;
end;

constructor TMirImages.Create(const AFileName: string; const Image: TImageType);
begin
  FFileName := AFileName;
  FImageType := Image;
  FImageCount := 0;
  FBitCount := 8;
  FInitialized := False;
  m_FileStream := nil;
  m_IndexList := TList.Create;
  Source := nil;
end;

destructor TMirImages.Destroy;
begin
  Finalize;
  m_IndexList.Free;

  inherited;
end;


procedure TMirImages.Initialize;
begin

end;

procedure TMirImages.Finalize;
begin
  m_IndexList.Clear;
  if Source <> nil then
    FreeAndNil(Source);
end;

procedure TMirImages.ReverseDIB(DIB: TDIB);
var
  I: Integer;
  lsDIB: TDIB;
  SrcP: PByte;
  DesP: PByte;
begin
  lsDIB := TDIB.Create;
  lsDIB.Assign(DIB);
  DesP := DIB.PBits;
  for I := lsDIB.Height - 1 downto 0 do begin
    SrcP := Pointer(Integer(lsDIB.PBits) + I * lsDIB.WidthBytes);
    Move(SrcP^, DesP^, DIB.WidthBytes);
    Inc(Integer(DesP), DIB.WidthBytes);
  end;
  lsDIB.Free;
end;

procedure TMirImages.DrawZoomEx(ABitmap: TGraphic; DC: HDC; X, Y, Width, Height: Integer);
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

procedure TMirImages.StretchBlt(Index: Integer; DC: HDC; X, Y: Integer; var Width, Height: Integer; ROP: Cardinal);
var
  ABitmap: TGraphic;
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

function TMirImages.FillDIB: TDIB;
var
  Source: TDIB;
begin
  Source := nil;
  case BitCount of
    8: begin
        Source := TDIB.Create;
        Source.SetSize(4, 1, 8);
        Source.ColorTable := MainPalette;
        Source.UpdatePalette;
        Source.Canvas.Brush.Color := clblack;
        Source.Canvas.FillRect(Source.Canvas.ClipRect);
      end;
    16: begin
        Source := TDIB.Create;
        Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
        Source.SetSize(4, 1, 16);
        Source.Canvas.Brush.Color := clblack;
        Source.Canvas.FillRect(Source.Canvas.ClipRect);
      end;
    24: begin
        Source := TDIB.Create;
        Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
        Source.SetSize(4, 1, 24);
        Source.Canvas.Brush.Color := clblack;
        Source.Canvas.FillRect(Source.Canvas.ClipRect);
      end;
    32: begin
        Source := TDIB.Create;
        Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
        Source.SetSize(4, 1, 32);
        Source.Canvas.Brush.Color := clblack;
        Source.Canvas.FillRect(Source.Canvas.ClipRect);
      end;
  end;
  Result := Source;
end;

function TMirImages.CreateFile(ABitCount: Byte = 8): Boolean;
var
  sFileName: string;
  FileStream: TFileStream;

  WilImageHeader: TWMImageHeader;
  WixIndexHeader: TWMIndexHeader;
  DataHeader: TDataHeader;
begin
  Result := False;
  case FImageType of
    t_Wil: begin
        if FileExists(FileName) then
          FileStream := TFileStream.Create(FileName, fmOpenReadWrite or fmShareDenyNone)
        else
          FileStream := TFileStream.Create(FileName, fmOpenReadWrite or fmShareDenyNone or fmCreate);

        WilImageHeader.Title := 'WEMADE Entertainment inc.';
        WilImageHeader.ImageCount := 0;
        WilImageHeader.PaletteSize := SizeOf(TRGBQuad) * 256 + SizeOf(TWMImageHeader) - 4;
        WilImageHeader.VerFlag := 0;
        case ABitCount of
          8: WilImageHeader.ColorCount := 256;
          16: WilImageHeader.ColorCount := 65536;
          24: WilImageHeader.ColorCount := 16777216;
          32: WilImageHeader.ColorCount := High(LongWord);
        end;

        FileStream.Write(WilImageHeader, SizeOf(TWMImageHeader) - 4);
        FileStream.Write(MainPalette, SizeOf(TRGBQuad) * 256);
        FileStream.Size := SizeOf(TRGBQuad) * 256 + SizeOf(TWMImageHeader) - 4;
        FileStream.Free;

        sFileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.WIX';
        if FileExists(sFileName) then
          FileStream := TFileStream.Create(sFileName, fmOpenReadWrite or fmShareDenyNone)
        else
          FileStream := TFileStream.Create(sFileName, fmOpenReadWrite or fmShareDenyNone or fmCreate);

        WixIndexHeader.Title := 'WEMADE Entertainment inc.';
        WixIndexHeader.IndexCount := 0;
        WixIndexHeader.VerFlag := 0;

        FileStream.Write(WixIndexHeader, SizeOf(TWMImageHeader) - 4);
        FileStream.Size := SizeOf(TWMImageHeader) - 4;
        FileStream.Free;
        Result := True;
      end;
    t_Wis: begin

      end;
    t_Fir: begin
        if FileExists(FileName) then begin
          FileSetAttr(FileName, 0);
          FileStream := TFileStream.Create(FileName, fmOpenReadWrite or fmShareDenyNone);
        end else begin
          FileStream := TFileStream.Create(FileName, fmOpenReadWrite or fmShareDenyNone or fmCreate);
        end;
        DataHeader.Title := g_sTitle;
        DataHeader.Size := SizeOf(TDataHeader);
        DataHeader.Compression := 0;
        DataHeader.ImageCount := 0;
        DataHeader.IndexOffSet := SizeOf(TDataHeader);
        DataHeader.BitCount := 16;
        FileStream.Size := SizeOf(TDataHeader);
        FileStream.Seek(0, soBeginning);
        FileStream.Write(DataHeader, SizeOf(TDataHeader));
        FileStream.Free;
        Result := True;
      end;
    t_GT: begin

      end;
  end;
end;
{------------------------------------------------------------------------------}

constructor TWil.Create(const AFileName: string);
begin
  inherited Create(AFileName, t_Wil);
  btVersion := 0;
end;

destructor TWil.Destroy;
begin
  inherited;
end;

function TWil.GetPoint(Index: Integer): TPoint;
var
  nPosition: Integer;
  ImageInfo: TWMImageInfo;
begin
  if (Index >= 0) and (Index < ImageCount) then begin
    nPosition := Integer(m_IndexList.Items[Index]);
    m_FileStream.Seek(nPosition, 0);
    if btVersion <> 0 then m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo) - 4)
    else m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo));
    Result := Point(ImageInfo.px, ImageInfo.py);
  end else Result := Point(0, 0);
end;

procedure TWil.SetPoint(Index: Integer; Value: TPoint);
var
  nPosition: Integer;
  ImageInfo: TWMImageInfo;
begin
  if (Index >= 0) and (Index < ImageCount) then begin
    nPosition := Integer(m_IndexList.Items[Index]);
    m_FileStream.Seek(nPosition, 0);
    if btVersion <> 0 then m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo) - 4)
    else m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo));
    ImageInfo.px := Value.X;
    ImageInfo.py := Value.Y;
    m_FileStream.Seek(nPosition, 0);
    if btVersion <> 0 then m_FileStream.Write(ImageInfo, SizeOf(TWMImageInfo) - 4)
    else m_FileStream.Write(ImageInfo, SizeOf(TWMImageInfo));
  end;
end;

procedure TWil.LoadPalette;
begin
  if btVersion <> 0 then
    m_FileStream.Seek(SizeOf(TWMImageHeader) - 4, 0)
  else
    m_FileStream.Seek(SizeOf(TWMImageHeader), 0);

  m_FileStream.Read(RGBQuads, SizeOf(TRGBQuad) * 256);
end;

procedure TWil.LoadIndex;
var
  I, Value: Integer;
  PValue: PInteger;
  sFileName: string;
  FileStream: TFileStream;
  IndexHeader: TWMIndexHeader;
begin
  m_IndexList.Clear;
  sFileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.WIX';

  if FileExists(sFileName) then begin
    FileStream := TFileStream.Create(sFileName, fmOpenRead or fmShareDenyNone);

    if btVersion <> 0 then
      FileStream.Read(IndexHeader, SizeOf(TWMIndexHeader) - 4)
    else
      FileStream.Read(IndexHeader, SizeOf(TWMIndexHeader));

    GetMem(PValue, 4 * IndexHeader.IndexCount);
    FileStream.Read(PValue^, 4 * IndexHeader.IndexCount);
    for I := 0 to IndexHeader.IndexCount - 1 do begin
      Value := PInteger(Integer(PValue) + 4 * I)^;
      m_IndexList.Add(Pointer(Value));
    end;
    FreeMem(PValue);
    FileStream.Free;
  end;
end;

procedure TWil.Initialize;
begin
  if FileExists(FileName) then begin
    if m_FileStream = nil then
      m_FileStream := TFileStream.Create(FileName, fmOpenReadWrite or fmShareDenyNone);
    m_FileStream.Read(FHeader, SizeOf(TWMImageHeader));
    if (FHeader.VerFlag = 0) or (FHeader.ColorCount >= 65536) then begin
      btVersion := 1;
      m_FileStream.Seek(-4, soFromCurrent);
    end;

    case FHeader.ColorCount of
      256: BitCount := 8;
      65536: BitCount := 16;
      16777216: BitCount := 24;
      //4294967296:BitCount := 32;    High(LongWord)
    else BitCount := 32;
    end;

    {case BitCount of
      8: begin
          Source := TDIB.Create;
          Source.SetSize(1, 1, 8);
          Source.ColorTable := MainPalette;
          Source.UpdatePalette;
        end;
      16: begin
          Source := TDIB.Create;
          Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
          Source.SetSize(1, 1, 16);
        end;
      24: begin
          Source := TDIB.Create;
          Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
          Source.SetSize(1, 1, 24);
        end;
      32: begin
          Source := TDIB.Create;
          Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
          Source.SetSize(1, 1, 32);
        end;
    end;}

    ImageCount := FHeader.ImageCount;

    LoadPalette;
    LoadIndex;
    Initialized := True;
  end;
end;

procedure TWil.Finalize;
begin
  if Initialized then begin
    Initialized := False;
    if m_FileStream <> nil then
      FreeAndNil(m_FileStream);
  end;
  inherited;
end;

function TWil.GetBitmap(Index: Integer): TDIB;
var
  I, nPosition: Integer;
  ImageInfo: TWMImageInfo;

  SrcP: PByte;
begin
  if Initialized then begin
    if (Index >= 0) and (Index < m_IndexList.Count) then begin

      nPosition := Integer(m_IndexList.Items[Index]);
      m_FileStream.Seek(nPosition, 0);
      if btVersion <> 0 then m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo) - 4)
      else m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo));

      if Source <> nil then FreeAndNil(Source);
      case BitCount of
        8: begin
            Source := TDIB.Create;
            Source.SetSize(WidthBytes(ImageInfo.nWidth), ImageInfo.nHeight, 8);
            Source.ColorTable := MainPalette;
            Source.UpdatePalette;
          end;
        16: begin
            Source := TDIB.Create;
            Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
            Source.SetSize(ImageInfo.nWidth, ImageInfo.nHeight, 16);
          end;
        24: begin
            Source := TDIB.Create;
            Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
            Source.SetSize(ImageInfo.nWidth, ImageInfo.nHeight, 24);
          end;
        32: begin
            Source := TDIB.Create;
            Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
            Source.SetSize(ImageInfo.nWidth, ImageInfo.nHeight, 32);
          end;
      end;
      Source.Canvas.Brush.Color := clblack;
      Source.Canvas.FillRect(Source.Canvas.ClipRect);

      SrcP := Source.PBits;
      m_FileStream.Read(SrcP^, Source.Width * (BitCount div 8) * Source.Height);
      {for I := 0 to Source.Height - 1 do begin
        SrcP := PByte(Integer(Source.PBits) + I * Source.WidthBytes);
        m_FileStream.Read(SrcP^, Source.Width * (BitCount div 8));
      end; }
      Result := Source;

    end else Result := nil;
  end else Result := nil;
end;

function TWil.Get(Index: Integer; var PX, PY: Integer): TDIB;
var
  I, nPosition: Integer;
  ImageInfo: TWMImageInfo;
  SrcP: PByte;
begin
  PX := 0;
  PY := 0;
  if Initialized then begin
    if (Index >= 0) and (Index < m_IndexList.Count) then begin

      nPosition := Integer(m_IndexList.Items[Index]);
      m_FileStream.Seek(nPosition, 0);
      if btVersion <> 0 then m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo) - 4)
      else m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo));

      if Source <> nil then FreeAndNil(Source);

      case BitCount of
        8: begin
            Source := TDIB.Create;
            Source.SetSize(WidthBytes(ImageInfo.nWidth), ImageInfo.nHeight, 8);
            Source.ColorTable := MainPalette;
            Source.UpdatePalette;
          end;
        16: begin
            Source := TDIB.Create;
            Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
            Source.SetSize(ImageInfo.nWidth, ImageInfo.nHeight, 16);
          end;
        24: begin
            Source := TDIB.Create;
            Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
            Source.SetSize(ImageInfo.nWidth, ImageInfo.nHeight, 24);
          end;
        32: begin
            Source := TDIB.Create;
            Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
            Source.SetSize(ImageInfo.nWidth, ImageInfo.nHeight, 32);
          end;
      end;
      Source.Canvas.Brush.Color := clblack;
      Source.Canvas.FillRect(Source.Canvas.ClipRect);

      PX := ImageInfo.px;
      PY := ImageInfo.py;


      SrcP := Source.PBits;
      m_FileStream.Read(SrcP^, Source.Width * (BitCount div 8) * Source.Height);
      {for I := 0 to Source.Height - 1 do begin
        SrcP := PByte(Integer(Source.PBits) + I * Source.WidthBytes);
        m_FileStream.Read(SrcP^, Source.Width * (BitCount div 8));
      end; }
      Result := Source;

    end else Result := nil;
  end else Result := nil;
end;

function TWil.Add(DIB: TDIB; X, Y: Integer): Boolean;
var
  I, nIndex: Integer;
  nPosition: Int64;
  sFileName: string;
  FileStream: TFileStream;
  IndexHeader: TWMIndexHeader;
  ImageInfo: TWMImageInfo;
  SrcP: PByte;
begin
  Result := False;
  sFileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.WIX';
  if FileExists(sFileName) then begin
    if m_IndexList.Count > 0 then begin
      nPosition := Integer(m_IndexList.Items[m_IndexList.Count - 1]);
      m_FileStream.Seek(nPosition, soBeginning);
      if btVersion <> 0 then begin
        m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo) - 4);
        if BitCount = 8 then
          nPosition := nPosition + SizeOf(TWMImageInfo) - 4 + WidthBytes(ImageInfo.nWidth) * ImageInfo.nHeight * (BitCount div 8)
        else
          nPosition := nPosition + SizeOf(TWMImageInfo) - 4 + ImageInfo.nWidth * ImageInfo.nHeight * (BitCount div 8);
      end else begin
        m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo));
        if BitCount = 8 then
          nPosition := nPosition + SizeOf(TWMImageInfo) + WidthBytes(ImageInfo.nWidth) * ImageInfo.nHeight * (BitCount div 8)
        else
          nPosition := nPosition + SizeOf(TWMImageInfo) - 4 + ImageInfo.nWidth * ImageInfo.nHeight * (BitCount div 8);
      end;
    end else begin
      nPosition := SizeOf(TWMImageHeader) + SizeOf(TRGBQuad) * 256;
    end;

    ImageInfo.nWidth := DIB.Width;
    ImageInfo.nHeight := DIB.Height;
    ImageInfo.px := X;
    ImageInfo.py := Y;

    FHeader.ImageCount := FHeader.ImageCount + 1;
    m_FileStream.Seek(0, soBeginning);
    m_FileStream.Write(FHeader, SizeOf(TWMImageHeader));

    m_FileStream.Seek(nPosition, soBeginning);
    if btVersion <> 0 then m_FileStream.Write(ImageInfo, SizeOf(TWMImageInfo) - 4)
    else m_FileStream.Write(ImageInfo, SizeOf(TWMImageInfo));

    SrcP := DIB.PBits;
    m_FileStream.Write(SrcP^, DIB.Width * (BitCount div 8) * DIB.Height);

    {for I := 0 to DIB.Height - 1 do begin
      SrcP := PByte(Integer(DIB.PBits) + I * DIB.WidthBytes);
      m_FileStream.Write(SrcP^, DIB.Width * (BitCount div 8));
    end; }

//===================================================================================
    FileStream := TFileStream.Create(sFileName, fmOpenReadWrite or fmShareDenyNone);
    if btVersion <> 0 then begin
      FileStream.Read(IndexHeader, SizeOf(TWMIndexHeader) - 4);
      IndexHeader.IndexCount := IndexHeader.IndexCount + 1;

      FileStream.Seek(0, soBeginning);
      FileStream.Write(IndexHeader, SizeOf(TWMIndexHeader) - 4);

      FileStream.Seek(SizeOf(TWMIndexHeader) - 4 + SizeOf(Integer) * (IndexHeader.IndexCount - 1), soBeginning);
    end else begin
      FileStream.Read(IndexHeader, SizeOf(TWMIndexHeader));
      IndexHeader.IndexCount := IndexHeader.IndexCount + 1;

      FileStream.Seek(0, soBeginning);
      FileStream.Write(IndexHeader, SizeOf(TWMIndexHeader));

      FileStream.Seek(SizeOf(TWMIndexHeader) + SizeOf(Integer) * (IndexHeader.IndexCount - 1), soBeginning);
    end;
    FileStream.Write(nPosition, SizeOf(Integer));
    FileStream.Free;
    m_IndexList.Add(Pointer(nPosition));
    ImageCount := ImageCount + 1;
    Result := True;
  end;
end;

function TWil.Insert(Index: Integer; DIB: TDIB; X, Y: Integer): Boolean;
var
  I: Integer;
  SrcP: PByte;
  nPosition: Int64;
  ImageInfo: TWMImageInfo;
begin
  Result := False;
  if (Index >= 0) and (Index < m_IndexList.Count) then begin
    nPosition := m_FileStream.Position;
    ImageInfo.nWidth := DIB.Width;
    ImageInfo.nHeight := DIB.Height;
    ImageInfo.px := X;
    ImageInfo.py := Y;

    if btVersion <> 0 then begin
      m_FileStream.Write(ImageInfo, SizeOf(TWMImageInfo) - 4);
    end else begin
      m_FileStream.Write(ImageInfo, SizeOf(TWMImageInfo));
    end;

    SrcP := DIB.PBits;
    m_FileStream.Write(SrcP^, DIB.Width * (BitCount div 8) * DIB.Height);

   { for I := 0 to DIB.Height - 1 do begin
      SrcP := PByte(Integer(DIB.PBits) + I * DIB.WidthBytes);
      m_FileStream.Write(SrcP^, DIB.Width * (BitCount div 8));
    end;}

    m_IndexList.Insert(Index, Pointer(nPosition));

    Result := True;
  end;
end;

function TWil.StartInsert(Index: Integer; var P: Pointer; var Size: Int64): Boolean;
var
  nPosition: Int64;
  sFileName: string;
begin
  Result := False;
  if (Index >= 0) and (Index < m_IndexList.Count) then begin
    sFileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.WIX';
    if FileExists(sFileName) then begin
      nPosition := Integer(m_IndexList.Items[Index]);
      m_FileStream.Seek(0, soBeginning);
      Size := _MAX(m_FileStream.Size - nPosition, 0);
      if Size > 0 then begin
        m_FileStream.Seek(nPosition, soBeginning);
        GetMem(P, Size);
        m_FileStream.Read(P^, Size);
      end;
      m_FileStream.Seek(nPosition, soBeginning);
      Result := True;
    end;
  end;
end;

function TWil.StopInsert(Index, InsertCount, InsertSize: Integer; P: Pointer; Size: Int64): Boolean;
var
  nIndex: Integer;
  nPosition, nSize: Int64;
  sFileName: string;
  FileStream: TFileStream;
  IndexHeader: TWMIndexHeader;
begin
  Result := False;
  if (Index >= 0) and (Index < m_IndexList.Count) then begin
    sFileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.WIX';
    if FileExists(sFileName) then begin
      if Size > 0 then begin
        m_FileStream.Write(P^, Size);
        FreeMem(P);
      end;

      FHeader.ImageCount := FHeader.ImageCount + InsertCount;
      m_FileStream.Seek(0, soBeginning);
      m_FileStream.Write(FHeader, SizeOf(TWMImageHeader));

//------------------------------------------------------------------------------

      FileStream := TFileStream.Create(sFileName, fmOpenReadWrite or fmShareDenyNone);

      if btVersion <> 0 then begin
        FileStream.Read(IndexHeader, SizeOf(TWMIndexHeader) - 4);
        IndexHeader.IndexCount := IndexHeader.IndexCount + InsertCount;
        FileStream.Seek(0, soBeginning);
        FileStream.Write(IndexHeader, SizeOf(TWMIndexHeader) - 4);
      end else begin
        FileStream.Read(IndexHeader, SizeOf(TWMIndexHeader));
        IndexHeader.IndexCount := IndexHeader.IndexCount + InsertCount;
        FileStream.Seek(0, soBeginning);
        FileStream.Write(IndexHeader, SizeOf(TWMIndexHeader));
      end;
      FileStream.Seek(Index * SizeOf(Integer), soCurrent);

      if btVersion <> 0 then begin
        nSize := (SizeOf(TWMImageInfo) - 4) * InsertCount + InsertSize;
      end else begin
        nSize := SizeOf(TWMImageInfo) * InsertCount + InsertSize;
      end;

      for nIndex := Index to Index + InsertCount - 1 do begin
        nPosition := Integer(m_IndexList.Items[nIndex]);
        FileStream.Write(nPosition, SizeOf(Integer));
      end;

      for nIndex := Index + InsertCount to m_IndexList.Count - 1 do begin
        nPosition := Integer(m_IndexList.Items[nIndex]) + nSize;
        m_IndexList.Items[nIndex] := Pointer(nPosition);
        FileStream.Write(nPosition, SizeOf(Integer));
      end;

      FileStream.Free;

      ImageCount := ImageCount + InsertCount;
      Result := True;
    end;
  end;
end;

function TWil.Delete(StartIndex, StopIndex: Integer): Boolean;
var
  nIndex: Integer;
  nPosition, nStartPosition, nStopPosition, nSize, nLen, nDeleteCount: Int64;
  sFileName: string;
  FileStream: TFileStream;
  MemoryStream: TMemoryStream;
  IndexHeader: TWMIndexHeader;
begin
  Result := False;
  if (StartIndex >= 0) and (StartIndex < m_IndexList.Count) and
    (StopIndex >= 0) and (StopIndex < m_IndexList.Count) and
    (StopIndex >= StartIndex) and (m_IndexList.Count > 0) then begin
    sFileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.WIX';
    if FileExists(sFileName) then begin
      nDeleteCount := (StopIndex - StartIndex + 1);
      if StopIndex = m_IndexList.Count - 1 then begin
        nPosition := Integer(m_IndexList.Items[StartIndex]);
        m_FileStream.Size := nPosition;

        FHeader.ImageCount := FHeader.ImageCount - nDeleteCount;
        m_FileStream.Seek(0, soBeginning);
        m_FileStream.Write(FHeader, SizeOf(TWMImageHeader));

      end else begin
        nPosition := Integer(m_IndexList.Items[StopIndex + 1]);
        nStopPosition := Integer(m_IndexList.Items[StopIndex]);
        nStartPosition := Integer(m_IndexList.Items[StartIndex]);
        nSize := nPosition - nStartPosition;

        m_FileStream.Seek(0, soBeginning);
        nLen := m_FileStream.Size - nPosition;

        MemoryStream := TMemoryStream.Create;
        MemoryStream.LoadFromStream(m_FileStream);
        MemoryStream.Seek(nPosition, soBeginning);
        m_FileStream.Seek(nStartPosition, soBeginning);

        m_FileStream.CopyFrom(MemoryStream, nLen);
        m_FileStream.Size := m_FileStream.Size - nSize;
        MemoryStream.Free;

        FHeader.ImageCount := FHeader.ImageCount - nDeleteCount;
        m_FileStream.Seek(0, soBeginning);
        m_FileStream.Write(FHeader, SizeOf(TWMImageHeader));

      end;

//------------------------------------------------------------------------------
      FileStream := TFileStream.Create(sFileName, fmOpenReadWrite or fmShareDenyNone);

      if btVersion <> 0 then begin
        FileStream.Read(IndexHeader, SizeOf(TWMIndexHeader) - 4);
        IndexHeader.IndexCount := IndexHeader.IndexCount - nDeleteCount;
        FileStream.Seek(0, soBeginning);
        FileStream.Write(IndexHeader, SizeOf(TWMIndexHeader) - 4);
      end else begin
        FileStream.Read(IndexHeader, SizeOf(TWMIndexHeader));
        IndexHeader.IndexCount := IndexHeader.IndexCount - nDeleteCount;
        FileStream.Seek(0, soBeginning);
        FileStream.Write(IndexHeader, SizeOf(TWMIndexHeader));
      end;

      for nIndex := StartIndex to StopIndex do begin
        m_IndexList.Items[nIndex] := Pointer(-1);
      end;

      for nIndex := m_IndexList.Count - 1 downto 0 do begin
        if Integer(m_IndexList.Items[nIndex]) < 0 then
          m_IndexList.Delete(nIndex);
      end;

      FileStream.Seek(StartIndex * SizeOf(Integer), soCurrent);
      for nIndex := StartIndex to m_IndexList.Count - 1 do begin
        nPosition := Integer(m_IndexList.Items[nIndex]) - nSize;
        m_IndexList.Items[nIndex] := Pointer(nPosition);
        FileStream.Write(nPosition, SizeOf(Integer));
      end;

      FileStream.Size := FileStream.Size - SizeOf(Integer) * nDeleteCount;

      FileStream.Free;

      ImageCount := ImageCount - nDeleteCount;
      Result := True;
    end;
  end;
end;

function TWil.Fill(StartIndex, StopIndex: Integer): Boolean;
var
  nIndex: Integer;
  nPosition, nStartPosition, nStopPosition, nSize, nLen, nDeleteCount: Int64;
  sFileName: string;
  FileStream: TFileStream;
  MemoryStream: TMemoryStream;
  IndexHeader: TWMIndexHeader;
  ImageInfo: TWMImageInfo;

  DIB: TDIB;
begin
  Result := False;
  if (StartIndex >= 0) and (StartIndex < m_IndexList.Count) and
    (StopIndex >= 0) and (StopIndex < m_IndexList.Count) and
    (StopIndex >= StartIndex) and (m_IndexList.Count > 0) then begin
    sFileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.WIX';
    if FileExists(sFileName) then begin

      if StopIndex = m_IndexList.Count - 1 then begin
        nPosition := Integer(m_IndexList.Items[StartIndex]);
        m_FileStream.Size := nPosition;

        m_FileStream.Seek(nPosition, soBeginning);
        DIB := FillDIB;

        ImageInfo.nWidth := DIB.Width;
        ImageInfo.nHeight := DIB.Height;
        ImageInfo.px := 0;
        ImageInfo.py := 0;

        for nIndex := StartIndex to StopIndex do begin
          m_IndexList.Items[nIndex] := Pointer(m_FileStream.Position);
          if btVersion <> 0 then begin
            m_FileStream.Write(ImageInfo, SizeOf(TWMImageInfo) - 4);
          end else begin
            m_FileStream.Write(ImageInfo, SizeOf(TWMImageInfo));
          end;
          m_FileStream.Write(DIB.PBits^, DIB.Width * DIB.Height * (BitCount div 8));
        end;
        DIB.Free;

      end else begin
        nPosition := Integer(m_IndexList.Items[StopIndex + 1]);
        nStopPosition := Integer(m_IndexList.Items[StopIndex]);
        nStartPosition := Integer(m_IndexList.Items[StartIndex]);

        m_FileStream.Seek(0, soBeginning);
        nLen := m_FileStream.Size - nPosition;

        MemoryStream := TMemoryStream.Create;
        MemoryStream.LoadFromStream(m_FileStream);
        MemoryStream.Seek(nPosition, soBeginning);

        m_FileStream.Size := nStartPosition;
        m_FileStream.Seek(nStartPosition, soBeginning);

        DIB := FillDIB;
        ImageInfo.nWidth := DIB.Width;
        ImageInfo.nHeight := DIB.Height;
        ImageInfo.px := 0;
        ImageInfo.py := 0;
        for nIndex := StartIndex to StopIndex do begin
          m_IndexList.Items[nIndex] := Pointer(m_FileStream.Position);
          if btVersion <> 0 then begin
            m_FileStream.Write(ImageInfo, SizeOf(TWMImageInfo) - 4);
          end else begin
            m_FileStream.Write(ImageInfo, SizeOf(TWMImageInfo));
          end;
          m_FileStream.Write(DIB.PBits^, DIB.Width * DIB.Height * (BitCount div 8));
        end;

        nDeleteCount := (StopIndex - StartIndex + 1);
        if btVersion <> 0 then begin
          nSize := (SizeOf(TWMImageInfo) - 4) * nDeleteCount;
        end else begin
          nSize := SizeOf(TWMImageInfo) * nDeleteCount;
        end;

        nSize := nSize + DIB.Width * DIB.Height * (BitCount div 8) * nDeleteCount;
        //nSize := _MAX((nPosition - nStartPosition) - nSize, 0);
        nSize := nPosition - nStartPosition - nSize;

        DIB.Free;

        m_FileStream.CopyFrom(MemoryStream, nLen);
        MemoryStream.Free;

      end;

//------------------------------------------------------------------------------
      FileStream := TFileStream.Create(sFileName, fmOpenReadWrite or fmShareDenyNone);

      if btVersion <> 0 then begin
        FileStream.Seek(SizeOf(TWMIndexHeader) - 4, soBeginning);
      end else begin
        FileStream.Seek(SizeOf(TWMIndexHeader), soBeginning);
      end;

      FileStream.Seek(StartIndex * SizeOf(Integer), soCurrent);
      for nIndex := StartIndex to StopIndex do begin
        nPosition := Integer(m_IndexList.Items[nIndex]);
        FileStream.Write(nPosition, SizeOf(Integer));
      end;

      for nIndex := StopIndex + 1 to m_IndexList.Count - 1 do begin
        nPosition := Integer(m_IndexList.Items[nIndex]) - nSize;
        m_IndexList.Items[nIndex] := Pointer(nPosition);
        FileStream.Write(nPosition, SizeOf(Integer));
      end;

      FileStream.Free;
      Result := True;
    end;
  end;
end;

function TWil.StartReplace(StartIndex, StopIndex: Integer; var Position: Int64; var P: Pointer; var Size: Int64): Boolean;
var
  nPosition, nStartPos, nStopPos: Int64;
  sFileName: string;
begin
  Result := False;
  if (StartIndex >= 0) and (StartIndex < m_IndexList.Count) and
    (StopIndex >= 0) and (StopIndex < m_IndexList.Count) and
    (StopIndex >= StartIndex) and (m_IndexList.Count > 0) then begin
    sFileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.WIX';
    if FileExists(sFileName) then begin
      nStartPos := Integer(m_IndexList.Items[StartIndex]);
      nStopPos := Integer(m_IndexList.Items[StopIndex]);

      if StopIndex = m_IndexList.Count - 1 then begin
        //Position := Integer(m_IndexList.Items[StopIndex]);
        Position := m_FileStream.Size;
      end else begin
        Position := Integer(m_IndexList.Items[StopIndex + 1]);
      end;
      P := nil;

      m_FileStream.Seek(0, soBeginning);
      Size := m_FileStream.Size - Position;
      if Size > 0 then begin
        m_FileStream.Seek(Position, soBeginning);
        GetMem(P, Size);
        m_FileStream.Read(P^, Size);
      end;
      m_FileStream.Size := nStartPos;
      m_FileStream.Seek(nStartPos, soBeginning);
      Result := True;
    end;
  end;
end;

function TWil.StopReplace(StartIndex, StopIndex: Integer; Position: Int64; P: Pointer; Size: Int64): Boolean;
var
  nIndex, InsertCount: Integer;
  nPosition, nSize: Int64;
  sFileName: string;
  FileStream: TFileStream;
  IndexHeader: TWMIndexHeader;
begin
  Result := False;
  if (StartIndex >= 0) and (StartIndex < m_IndexList.Count) and
    (StopIndex >= 0) and (StopIndex < m_IndexList.Count) and
    (StopIndex >= StartIndex) and (m_IndexList.Count > 0) then begin
    sFileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.WIX';
    if FileExists(sFileName) then begin
      nSize := m_FileStream.Position - Position;

      if Size > 0 then begin
        m_FileStream.Write(P^, Size);
        FreeMem(P);
      end;

//------------------------------------------------------------------------------
      FileStream := TFileStream.Create(sFileName, fmOpenReadWrite or fmShareDenyNone);
      if btVersion <> 0 then begin
        FileStream.Seek(SizeOf(TWMIndexHeader) - 4, soBeginning);
      end else begin
        FileStream.Seek(SizeOf(TWMIndexHeader), soBeginning);
      end;

      FileStream.Seek(StartIndex * SizeOf(Integer), soCurrent);

      for nIndex := StartIndex to StopIndex do begin
        nPosition := Integer(m_IndexList.Items[nIndex]);
        FileStream.Write(nPosition, SizeOf(Integer));
      end;

      for nIndex := StopIndex + 1 to m_IndexList.Count - 1 do begin
        nPosition := Integer(m_IndexList.Items[nIndex]) + nSize;
        m_IndexList.Items[nIndex] := Pointer(nPosition);
        FileStream.Write(nPosition, SizeOf(Integer));
      end;

      FileStream.Free;
      Result := True;
    end;
  end;
end;

function TWil.Replace(Index: Integer; DIB: TDIB; X, Y: Integer): Boolean;
var
  I: Integer;
  SrcP: PByte;
  ImageInfo: TWMImageInfo;
begin
  Result := False;
  if (Index >= 0) and (Index < m_IndexList.Count) then begin
    m_IndexList.Items[Index] := Pointer(m_FileStream.Position);

    ImageInfo.nWidth := DIB.Width;
    ImageInfo.nHeight := DIB.Height;
    ImageInfo.px := X;
    ImageInfo.py := Y;

    if btVersion <> 0 then begin
      m_FileStream.Write(ImageInfo, SizeOf(TWMImageInfo) - 4);
    end else begin
      m_FileStream.Write(ImageInfo, SizeOf(TWMImageInfo));
    end;

    SrcP := DIB.PBits;
    m_FileStream.Write(SrcP^, DIB.Width * (BitCount div 8) * DIB.Height);

   { for I := 0 to DIB.Height - 1 do begin
      SrcP := PByte(Integer(DIB.PBits) + I * DIB.WidthBytes);
      m_FileStream.Write(SrcP^, DIB.Width * (BitCount div 8));
    end;}

    Result := True;
  end;
end;

function TWil.Replace(Index: Integer; DIB: TDIB): Boolean;
var
  I, nIndex: Integer;
  nPosition, nSize, nNewSize, nOldSize, nLen: Int64;
  sFileName: string;
  FileStream: TFileStream;
  MemoryStream: TMemoryStream;
  ImageInfo: TWMImageInfo;
  SrcP: PByte;
begin
  Result := False;
  if (Index >= 0) and (Index < m_IndexList.Count) and (m_IndexList.Count > 0) then begin
    sFileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.WIX';
    if FileExists(sFileName) then begin

      if Index = m_IndexList.Count - 1 then begin
        nPosition := Integer(m_IndexList.Items[Index]);
        m_FileStream.Seek(nPosition, soBeginning);

        if btVersion <> 0 then begin
          m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo) - 4);
        end else begin
          m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo));
        end;

        ImageInfo.nWidth := DIB.Width;
        ImageInfo.nHeight := DIB.Height;

        if btVersion <> 0 then begin
          nSize := (SizeOf(TWMImageInfo) - 4) + DIB.Width * DIB.Height * (BitCount div 8);
        end else begin
          nSize := SizeOf(TWMImageInfo) + DIB.Width * DIB.Height * (BitCount div 8);
        end;

        m_FileStream.Seek(nPosition, soBeginning);
        if btVersion <> 0 then begin
          m_FileStream.Write(ImageInfo, SizeOf(TWMImageInfo) - 4);
        end else begin
          m_FileStream.Write(ImageInfo, SizeOf(TWMImageInfo));
        end;

        SrcP := DIB.PBits;
        m_FileStream.Write(SrcP^, DIB.Width * (BitCount div 8) * DIB.Height);

        {for I := 0 to DIB.Height - 1 do begin
          SrcP := PByte(Integer(DIB.PBits) + I * DIB.WidthBytes);
          m_FileStream.Write(SrcP^, DIB.Width * (BitCount div 8));
        end;}

        m_FileStream.Size := nPosition + nSize;

      end else begin
        nPosition := Integer(m_IndexList.Items[Index]);
        m_FileStream.Seek(nPosition, soBeginning);
        if btVersion <> 0 then begin
          m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo) - 4);
        end else begin
          m_FileStream.Read(ImageInfo, SizeOf(TWMImageInfo));
        end;

        nSize := Integer(m_IndexList.Items[Index + 1]) - nPosition;

        if btVersion <> 0 then begin
          nNewSize := (SizeOf(TWMImageInfo) - 4) + DIB.Width * DIB.Height * (BitCount div 8);
        end else begin
          nNewSize := SizeOf(TWMImageInfo) + DIB.Width * DIB.Height * (BitCount div 8);
        end;

        m_FileStream.Seek(0, soBeginning);
        nLen := m_FileStream.Size - Integer(m_IndexList.Items[Index + 1]);

        MemoryStream := TMemoryStream.Create;
        MemoryStream.LoadFromStream(m_FileStream);
        MemoryStream.Seek(Integer(m_IndexList.Items[Index + 1]), soBeginning);
        m_FileStream.Seek(nPosition, soBeginning);

        ImageInfo.nWidth := DIB.Width;
        ImageInfo.nHeight := DIB.Height;

        if btVersion <> 0 then begin
          m_FileStream.Write(ImageInfo, SizeOf(TWMImageInfo) - 4);
        end else begin
          m_FileStream.Write(ImageInfo, SizeOf(TWMImageInfo));
        end;

        SrcP := DIB.PBits;
        m_FileStream.Write(SrcP^, DIB.Width * (BitCount div 8) * DIB.Height);

        {for I := 0 to DIB.Height - 1 do begin
          SrcP := PByte(Integer(DIB.PBits) + I * DIB.WidthBytes);
          m_FileStream.Write(SrcP^, DIB.Width * (BitCount div 8));
        end;}

        m_FileStream.CopyFrom(MemoryStream, nLen);
        m_FileStream.Size := m_FileStream.Size - (nSize - nNewSize);
        MemoryStream.Free;

//------------------------------------------------------------------------------
        if nSize <> nNewSize then begin
          FileStream := TFileStream.Create(sFileName, fmOpenReadWrite or fmShareDenyNone);

          if btVersion <> 0 then begin
            FileStream.Seek(SizeOf(TWMIndexHeader) - 4, soBeginning);
          end else begin
            FileStream.Seek(SizeOf(TWMIndexHeader), soBeginning);
          end;

          FileStream.Seek((Index + 1) * SizeOf(Integer), soCurrent);
          for nIndex := Index + 1 to m_IndexList.Count - 1 do begin
            nPosition := Integer(m_IndexList.Items[nIndex]) - (nSize - nNewSize);
            m_IndexList.Items[nIndex] := Pointer(nPosition);
            FileStream.Write(nPosition, SizeOf(Integer));
          end;
          FileStream.Free;
        end;
      end;

      Result := True;
    end;
  end;
end;

{------------------------------------------------------------------------------}

constructor TWis.Create(const AFileName: string);
begin
  inherited Create(AFileName, t_Wis);
end;

destructor TWis.Destroy;
begin
  inherited;
end;

function TWis.DecodeWis(ASrc, ADst: PByte; ASrcSize,
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
      Inc(ASrc);
      Dec(ASrcSize);
    end;
    if (V = 0) and (Len <= 0) then begin
      V := ASrc^;
      Len := V;
      Inc(ASrc);
      Dec(ASrcSize);
      boSkip := True;
    end;
    if boSkip then begin
      if Len <> 0 then begin
        Dec(ADstSize, Len);
        Dec(ASrcSize, Len);
        Move(ASrc^, ADst^, Len);
        Inc(ADst, Len);
        Inc(ASrc, Len);
      end else begin
        boSkip := False;
      end;
      Len := 0;
    end else begin
      L := V;
      Dec(ADstSize, L);
      for I := 1 to L do begin
        ADst^ := ASrc^;
        Inc(ADst);
      end;
      L := 0;
      Inc(ASrc);
      Dec(ASrcSize);
    end;
  end;
  Result := True;
end;

function TWis.Decode(ASrc: PByte; DIB: TDIB; ASrcSize: Integer): Integer;
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

function TWis.GetPoint(Index: Integer): TPoint;
var
  nPosition: Integer;
  ImageInfo: TImgInfo;
begin
  if (Index >= 0) and (Index < m_IndexList.Count) then begin
    nPosition := pTWisHeader(m_IndexList.Items[Index]).OffSet;
    m_FileStream.Seek(nPosition, 0);
    m_FileStream.Read(ImageInfo, SizeOf(TImgInfo));
    Result := Point(ImageInfo.wPx, ImageInfo.wPy);
  end else Result := Point(0, 0);
end;

procedure TWis.SetPoint(Index: Integer; Value: TPoint);
var
  nPosition: Integer;
  ImageInfo: TImgInfo;
begin
  if (Index >= 0) and (Index < m_IndexList.Count) then begin
    nPosition := pTWisHeader(m_IndexList.Items[Index]).OffSet;
    m_FileStream.Seek(nPosition, 0);
    m_FileStream.Read(ImageInfo, SizeOf(TImgInfo));
    ImageInfo.wPx := Value.X;
    ImageInfo.wPy := Value.Y;
    m_FileStream.Seek(nPosition, 0);
    m_FileStream.Write(ImageInfo, SizeOf(TImgInfo));
  end;
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

function TWis.LoadIndex: Boolean;
  function DecPointer(P: Pointer; Size: Integer): Pointer;
  begin
    Result := Pointer(Integer(P) - Size);
  end;
  function IncPointer(P: Pointer; Size: Integer): Pointer;
  begin
    Result := Pointer(Integer(P) + Size);
  end;
var
  iFileOffset, nIndex, nIndexOffset: Integer;

  MapStream: TMapStream;
  WisHeader: PTWisHeader;
  WisIndexArray: TWisFileHeaderArray;
begin
  Result := False;

  for nIndex := 0 to m_IndexList.Count - 1 do begin
    Dispose(PTWisHeader(m_IndexList.Items[nIndex]));
  end;
  m_IndexList.Clear;

  MapStream := TMapStream.Create();
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
            {for nIndex := 0 to 3 do begin
              TextOutStr(Format('Index:%d OffSet:%d Length:%d  temp3:%d', [nIndex, WisHeader.OffSet, WisHeader.Length, WisHeader.temp3]));
              WisHeader := IncPointer(WisHeader, SizeOf(TWisHeader));
            end;}
            break;
          end;
        end else break;
      end else begin
        FIndexOffset := nIndexOffset;
        break;
      end;
    end;
  end;

  MapStream.Free;

  for nIndex := 0 to Length(WisIndexArray) - 1 do begin
    New(WisHeader);
    WisHeader^ := WisIndexArray[Length(WisIndexArray) - nIndex - 1];
    m_IndexList.Add(WisHeader);
  end;

  ImageCount := m_IndexList.Count;

  Result := True;
end;

procedure TWis.Initialize;
begin
  if FileExists(FileName) then begin
    if LoadIndex then begin
      if m_FileStream = nil then
        m_FileStream := TFileStream.Create(FileName, fmOpenReadWrite or fmShareDenyNone);
     { Source := TDIB.Create;
      Source.SetSize(1, 1, 8);
      Source.ColorTable := MainPalette;
      Source.UpdatePalette;  }
      Initialized := True;
    end;
  end;
end;

procedure TWis.Finalize;
var
  I: Integer;
begin
  if Initialized then begin
    Initialized := False;

    if m_FileStream <> nil then
      FreeAndNil(m_FileStream);

    for I := 0 to m_IndexList.Count - 1 do begin
      Dispose(pTWisHeader(m_IndexList.Items[I]));
    end;
    m_IndexList.Clear;
  end;
  inherited;
end;

function TWis.FillDIB: TDIB;
var
  Source: TDIB;
begin
  Source := nil;
  case BitCount of
    8: begin
        Source := TDIB.Create;
        Source.SetSize(1, 1, 8);
        Source.ColorTable := MainPalette;
        Source.UpdatePalette;
        Source.Canvas.Brush.Color := clblack;
        Source.Canvas.FillRect(Source.Canvas.ClipRect);
      end;
    16: begin
        Source := TDIB.Create;
        Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
        Source.SetSize(1, 1, 16);
        Source.Canvas.Brush.Color := clblack;
        Source.Canvas.FillRect(Source.Canvas.ClipRect);
      end;
    24: begin
        Source := TDIB.Create;
        Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
        Source.SetSize(1, 1, 24);
        Source.Canvas.Brush.Color := clblack;
        Source.Canvas.FillRect(Source.Canvas.ClipRect);
      end;
    32: begin
        Source := TDIB.Create;
        Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
        Source.SetSize(1, 1, 32);
        Source.Canvas.Brush.Color := clblack;
        Source.Canvas.FillRect(Source.Canvas.ClipRect);
      end;
  end;
  Result := Source;
end;

function TWis.GetBitmap(Index: Integer): TDIB;
var
  I: Integer;
  nSize: Integer;
  nPosition: Integer;
  ImageInfo: TImgInfo;

  P: PByte;
  S, D: Pointer;
  SrcP: PByte;
  DesP: PByte;

  WisHeader: pTWisHeader;
begin
  try
   { Source.SetSize(1, 1, 8);
    Source.ColorTable := MainPalette;
    Source.UpdatePalette;  }
    if Initialized then begin
      if (Index >= 0) and (Index < ImageCount) then begin

        WisHeader := pTWisHeader(m_IndexList.Items[Index]);
        nPosition := WisHeader.OffSet;
        m_FileStream.Position := nPosition;
        m_FileStream.Read(ImageInfo, SizeOf(TImgInfo));

        nSize := ImageInfo.wW * ImageInfo.wH;

        if Source <> nil then FreeAndNil(Source);
        Source := TDIB.Create;
        Source.SetSize(WidthBytes(ImageInfo.wW), ImageInfo.wH, 8);
        Source.ColorTable := MainPalette;
        Source.UpdatePalette;
        Source.Canvas.Brush.Color := clBlack;
        Source.Canvas.FillRect(Source.Canvas.ClipRect);
        if ImageInfo.btEncr0 = 1 then begin
          GetMem(S, WisHeader.Length);
          GetMem(D, nSize);

          SrcP := S;
          DesP := D;

          m_FileStream.Read(SrcP^, WisHeader.Length);
          DecodeWis(SrcP, DesP, WisHeader.Length, nSize);

          FreeMem(S);

          S := D;

          for I := 0 to Source.Height - 1 do begin
            SrcP := PByte(Integer(S) + I * ImageInfo.wW);
            DesP := PByte(Integer(Source.PBits) + (Source.Height - 1 - I) * Source.WidthBytes);
            Move(SrcP^, DesP^, ImageInfo.wW);
          end;

          FreeMem(S);
        end else begin
          GetMem(S, WisHeader.Length);
          SrcP := S;
          m_FileStream.Read(SrcP^, WisHeader.Length);
          //ReverseDIB(Source);

          for I := 0 to Source.Height - 1 do begin
            SrcP := PByte(Integer(S) + I * ImageInfo.wW);
            DesP := PByte(Integer(Source.PBits) + (Source.Height - 1 - I) * Source.WidthBytes);
            Move(SrcP^, DesP^, ImageInfo.wW);
          end;
          FreeMem(S);
        end;

        Result := Source;
      end else Result := nil;
    end else Result := nil;
  except
    Result := nil;
    if Source <> nil then
      Source.Free;
  end;
end;

function TWis.Get(Index: Integer; var PX, PY: Integer): TDIB;
var
  I: Integer;
  nSize: Integer;
  nPosition: Integer;
  ImageInfo: TImgInfo;

  P: PByte;
  S, D: Pointer;
  SrcP: PByte;
  DesP: PByte;

  BitMap: TBitMap;
  WisHeader: pTWisHeader;
begin
  PX := 0;
  PY := 0;
  try
   { Source.SetSize(1, 1, 8);
    Source.ColorTable := MainPalette;
    Source.UpdatePalette;}
    if Initialized then begin
      if (Index >= 0) and (Index < ImageCount) then begin
        WisHeader := pTWisHeader(m_IndexList.Items[Index]);
        nPosition := WisHeader.OffSet;
        m_FileStream.Position := nPosition;
        m_FileStream.Read(ImageInfo, SizeOf(TImgInfo));

        PX := ImageInfo.wPx;
        PY := ImageInfo.wPy;

        nSize := ImageInfo.wW * ImageInfo.wH;

        if Source <> nil then FreeAndNil(Source);
        Source := TDIB.Create;
        Source.SetSize(WidthBytes(ImageInfo.wW), ImageInfo.wH, 8);
        Source.ColorTable := MainPalette;
        Source.UpdatePalette;
        Source.Canvas.Brush.Color := clblack;
        Source.Canvas.FillRect(Source.Canvas.ClipRect);

        if ImageInfo.btEncr0 = 1 then begin
          GetMem(S, WisHeader.Length);
          GetMem(D, nSize);

          SrcP := S;
          DesP := D;

          m_FileStream.Read(SrcP^, WisHeader.Length);
          DecodeWis(SrcP, DesP, WisHeader.Length, nSize);

          FreeMem(S);

          S := D;

          for I := 0 to Source.Height - 1 do begin
            SrcP := PByte(Integer(S) + I * ImageInfo.wW);
            DesP := PByte(Integer(Source.PBits) + (Source.Height - 1 - I) * Source.WidthBytes);
            Move(SrcP^, DesP^, ImageInfo.wW);
          end;

          FreeMem(S);
        end else begin
          GetMem(S, WisHeader.Length);
          SrcP := S;
          m_FileStream.Read(SrcP^, WisHeader.Length);
          //ReverseDIB(Source);

          for I := 0 to Source.Height - 1 do begin
            SrcP := PByte(Integer(S) + I * ImageInfo.wW);
            DesP := PByte(Integer(Source.PBits) + (Source.Height - 1 - I) * Source.WidthBytes);
            Move(SrcP^, DesP^, ImageInfo.wW);
          end;
          FreeMem(S);
        end;
        Result := Source;
      end else Result := nil;
    end else Result := nil;
  except
    Result := nil;
    if Source <> nil then
      Source.Free;
  end;
end;

function TWis.Add(DIB: TDIB; X, Y: Integer): Boolean;
begin

end;

function TWis.Insert(Index: Integer; DIB: TDIB; X, Y: Integer): Boolean;
begin

end;

function TWis.Delete(StartIndex, StopIndex: Integer): Boolean;
var
  nIndex: Integer;
  nPosition, nStartPosition, nStopPosition, nSize, nLen, nDeleteCount: Int64;
  WisHeader: pTWisHeader;
  MemoryStream: TMemoryStream;
begin
  Result := False;
  if (StartIndex >= 0) and (StartIndex < m_IndexList.Count) and
    (StopIndex >= 0) and (StopIndex < m_IndexList.Count) and
    (StopIndex >= StartIndex) and (m_IndexList.Count > 0) then begin

    nDeleteCount := (StopIndex - StartIndex + 1);
    if StopIndex = m_IndexList.Count - 1 then begin
      nPosition := PTWisHeader(m_IndexList.Items[StartIndex]).OffSet;
      m_FileStream.Size := nPosition;
    end else begin
      nPosition := pTWisHeader(m_IndexList.Items[StopIndex + 1]).OffSet;
      nStopPosition := pTWisHeader(m_IndexList.Items[StopIndex]).OffSet;
      nStartPosition := pTWisHeader(m_IndexList.Items[StartIndex]).OffSet;
      nSize := nPosition - nStartPosition;

      m_FileStream.Seek(0, soBeginning);
      nLen := m_FileStream.Size - nPosition;

      MemoryStream := TMemoryStream.Create;
      MemoryStream.LoadFromStream(m_FileStream);
      MemoryStream.Seek(nPosition, soBeginning);
      m_FileStream.Seek(nStartPosition, soBeginning);

      m_FileStream.CopyFrom(MemoryStream, nLen);
      m_FileStream.Size := m_FileStream.Size - nSize - m_IndexList.Count * SizeOf(Integer);
      MemoryStream.Free;
    end;

//------------------------------------------------------------------------------

    for nIndex := StartIndex to StopIndex do begin
      pTWisHeader(m_IndexList.Items[nIndex]).OffSet := -1;
    end;

    for nIndex := m_IndexList.Count - 1 downto 0 do begin
      if pTWisHeader(m_IndexList.Items[nIndex]).OffSet < 0 then begin
        Dispose(pTWisHeader(m_IndexList.Items[nIndex]));
        m_IndexList.Delete(nIndex);
      end;
    end;

    for nIndex := StartIndex to m_IndexList.Count - 1 do begin
      nPosition := pTWisHeader(m_IndexList.Items[nIndex]).OffSet - nSize;
      pTWisHeader(m_IndexList.Items[nIndex]).OffSet := nPosition;
    end;

    m_FileStream.Seek(0, soEnd);
    for nIndex := 0 to m_IndexList.Count - 1 do begin
      WisHeader := pTWisHeader(m_IndexList.Items[nIndex]);
      m_FileStream.Write(WisHeader^, SizeOf(TWisHeader));
    end;

    ImageCount := ImageCount - nDeleteCount;
    Result := True;
  end;
end;

function TWis.Fill(StartIndex, StopIndex: Integer): Boolean;
var
  nIndex: Integer;
  nPosition, nStartPosition, nStopPosition, nSize, nLen, nDeleteCount, nDataLen: Int64;

  FileStream: TFileStream;
  MemoryStream: TMemoryStream;
  ImageInfo: TImgInfo;
  WisHeader: PTWisHeader;
  DIB: TDIB;
begin
  Result := False;
  if (StartIndex >= 0) and (StartIndex < m_IndexList.Count) and
    (StopIndex >= 0) and (StopIndex < m_IndexList.Count) and
    (StopIndex >= StartIndex) and (m_IndexList.Count > 0) then begin

    if StopIndex = m_IndexList.Count - 1 then begin
      nPosition := PTWisHeader(m_IndexList.Items[StartIndex]).OffSet;
      m_FileStream.Size := nPosition;

      m_FileStream.Seek(nPosition, soBeginning);
      DIB := FillDIB;

      ImageInfo.btEncr0 := 0;
      ImageInfo.btEncr1 := 0;
      ImageInfo.wW := DIB.Width;
      ImageInfo.wH := DIB.Height;
      ImageInfo.wPx := 0;
      ImageInfo.wPy := 0;
      nDataLen := DIB.Width * DIB.Height * (BitCount div 8);
      for nIndex := StartIndex to StopIndex do begin
        PTWisHeader(m_IndexList.Items[nIndex]).OffSet := m_FileStream.Position;
        PTWisHeader(m_IndexList.Items[nIndex]).Length := nDataLen;
        m_FileStream.Write(ImageInfo, SizeOf(TImgInfo));
        m_FileStream.Write(DIB.PBits^, nDataLen);
      end;
      DIB.Free;

    end else begin
      m_FileStream.Seek(0, soBeginning);
      m_FileStream.Size := m_FileStream.Size - m_IndexList.Count * SizeOf(TWisHeader);

      nPosition := pTWisHeader(m_IndexList.Items[StopIndex + 1]).OffSet;
      nStopPosition := pTWisHeader(m_IndexList.Items[StopIndex]).OffSet;
      nStartPosition := pTWisHeader(m_IndexList.Items[StartIndex]).OffSet;

      m_FileStream.Seek(0, soBeginning);
      nLen := m_FileStream.Size - nPosition;

      MemoryStream := TMemoryStream.Create;
      MemoryStream.LoadFromStream(m_FileStream);
      MemoryStream.Seek(nPosition, soBeginning);

      m_FileStream.Size := nStartPosition;
      m_FileStream.Seek(nStartPosition, soBeginning);

      DIB := FillDIB;

      ImageInfo.btEncr0 := 0;
      ImageInfo.btEncr1 := 0;
      ImageInfo.wW := DIB.Width;
      ImageInfo.wH := DIB.Height;
      ImageInfo.wPx := 0;
      ImageInfo.wPy := 0;

      nDataLen := DIB.Width * DIB.Height * (BitCount div 8);
      for nIndex := StartIndex to StopIndex do begin
        PTWisHeader(m_IndexList.Items[nIndex]).OffSet := m_FileStream.Position;
        PTWisHeader(m_IndexList.Items[nIndex]).Length := nDataLen;
        m_FileStream.Write(ImageInfo, SizeOf(TImgInfo));
        m_FileStream.Write(DIB.PBits^, nDataLen);
      end;
      DIB.Free;

      nDeleteCount := (StopIndex - StartIndex + 1);
      nSize := SizeOf(TImgInfo) * nDeleteCount + nDataLen * nDeleteCount;

      nSize := (nPosition - nStartPosition) - nSize;

      m_FileStream.CopyFrom(MemoryStream, nLen);
      MemoryStream.Free;
    end;

//------------------------------------------------------------------------------
    for nIndex := StopIndex + 1 to m_IndexList.Count - 1 do begin
      nPosition := PTWisHeader(m_IndexList.Items[nIndex]).OffSet - nSize;
      PTWisHeader(m_IndexList.Items[nIndex]).OffSet := nPosition;
    end;

    m_FileStream.Seek(0, soEnd);
    for nIndex := 0 to m_IndexList.Count - 1 do begin
      WisHeader := m_IndexList.Items[nIndex];
      m_FileStream.Write(WisHeader^, SizeOf(TWisHeader));
    end;

    Result := True;
  end;
end;

function TWis.Replace(Index: Integer; DIB: TDIB): Boolean;
begin

end;
{------------------------------------------------------------------------------}

constructor TData.Create(const AFileName: string);
begin
  inherited Create(AFileName, t_Fir);
  BitCount := 16;
end;

destructor TData.Destroy;
begin
  inherited;
end;

function TData.GetPoint(Index: Integer): TPoint;
var
  nPosition: Integer;
  ImageInfo: TDataImageInfo;
begin
  if Initialized then begin
    if (Index >= 0) and (Index < m_IndexList.Count) then begin
      nPosition := Integer(m_IndexList.Items[Index]);
      m_FileStream.Seek(nPosition, 0);
      m_FileStream.Read(ImageInfo, SizeOf(TDataImageInfo));
      Result := Point(ImageInfo.Px, ImageInfo.Py);
    end else Result := Point(0, 0);
  end else Result := Point(0, 0);
end;

procedure TData.SetPoint(Index: Integer; Value: TPoint);
var
  nPosition: Integer;
  ImageInfo: TDataImageInfo;
begin
  if Initialized then begin
    if (Index >= 0) and (Index < m_IndexList.Count) then begin
      nPosition := Integer(m_IndexList.Items[Index]);
      m_FileStream.Seek(nPosition, soBeginning);
      m_FileStream.Read(ImageInfo, SizeOf(TDataImageInfo));
      ImageInfo.Px := Value.X;
      ImageInfo.Py := Value.Y;
      m_FileStream.Seek(nPosition, soBeginning);
      m_FileStream.Write(ImageInfo, SizeOf(TDataImageInfo));
    end;
  end;
end;

procedure TData.LoadIndex;
var
  I: Integer;
  PValue: PInteger;
  P: Pointer;
  Value, nSize: Integer;
  nPosition: Integer;
  ImageInfo: TDataImageInfo;
begin
  m_IndexList.Clear;
  GetMem(PValue, 4 * ImageCount);
  m_FileStream.Seek(FHeader.IndexOffSet, soBeginning);
  m_FileStream.Read(PValue^, SizeOf(Integer) * ImageCount);
  for I := 0 to ImageCount - 1 do begin
    Value := PInteger(Integer(PValue) + 4 * I)^;
    m_IndexList.Add(Pointer(Value));
  end;
  FreeMem(PValue);

  if (FHeader.IndexOffSet = SizeOf(TDataHeader)) and (m_IndexList.Count > 0) then begin
    nSize := m_FileStream.Size - m_FileStream.Position;
    GetMem(P, nSize);
    m_FileStream.Read(P^, nSize);
    m_FileStream.Seek(FHeader.IndexOffSet, soBeginning);
    m_FileStream.Write(P^, nSize);
    FHeader.IndexOffSet := m_FileStream.Position;

    for I := 0 to m_IndexList.Count - 1 do begin
      Value := Integer(m_IndexList.Items[I]) - SizeOf(Integer) * m_IndexList.Count;
      m_IndexList.Items[I] := Pointer(Value);
      m_FileStream.Write(Value, SizeOf(Integer));
    end;

    m_FileStream.Seek(0, soBeginning);
    m_FileStream.Write(FHeader, SizeOf(TDataHeader));

    FreeMem(P);
  end;
end;

procedure TData.Initialize;
begin
  FillChar(FHeader, SizeOf(TDataHeader), #0);
  if FileExists(FileName) then begin
    FileSetAttr(FileName, 0);
    if m_FileStream = nil then
      m_FileStream := TFileStream.Create(FileName, fmOpenReadWrite or fmShareDenyNone);
    m_FileStream.Read(FHeader, SizeOf(TDataHeader));
    ImageCount := FHeader.ImageCount;
    if FHeader.IndexOffSet = 0 then
      FHeader.IndexOffSet := SizeOf(TDataHeader);

    {Source := TDIB.Create;
    Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
    Source.SetSize(1, 1, 16); }

    LoadIndex;
    Initialized := True;
  end;
end;

procedure TData.Finalize;
begin
  if Initialized then begin
    Initialized := False;

    if m_FileStream <> nil then
      FreeAndNil(m_FileStream);

    m_IndexList.Clear;
  end;
  inherited;
end;

function TData.GetBitmap(Index: Integer): TDIB;
var
  I, nPosition: Integer;
  ImageInfo: TDataImageInfo;
  S, P: Pointer;
  SrcP: Pointer;
  DesP: Pointer;
  BitMap: TBitMap;
begin
  if Initialized then begin
    if (Index >= 0) and (Index < m_IndexList.Count) then begin
      nPosition := Integer(m_IndexList.Items[Index]);
      m_FileStream.Seek(nPosition, 0);
      m_FileStream.Read(ImageInfo, SizeOf(TDataImageInfo));

      //TextOutStr(Format('Width:%d Height:%d Compression:%d', [ImageInfo.nWidth, ImageInfo.nHeight, FHeader.Compression]));
      if Source <> nil then FreeAndNil(Source);
      Source := TDIB.Create;
      Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);

      Source.SetSize(ImageInfo.nWidth, ImageInfo.nHeight, 16);
      Source.Canvas.Brush.Color := clblack;
      Source.Canvas.FillRect(Source.Canvas.ClipRect);


      if (ImageInfo.nSize > 0) then begin
        if FHeader.Compression > 0 then begin
          GetMem(P, ImageInfo.nSize);
          GetMem(S, Source.Width * Source.Height * 2);
          SrcP := P;
          DesP := S;
          m_FileStream.Read(SrcP^, ImageInfo.nSize);
          if (ImageInfo.nWidth * ImageInfo.nHeight > 4) then begin
            UnComp(FHeader.Compression, SrcP, ImageInfo.nSize, DesP);
          end else begin
            Move(SrcP^, DesP^, ImageInfo.nSize);
          end;
          FreeMem(P);

          SrcP := S;
          for I := 0 to Source.Height - 1 do begin
            DesP := Pointer(Integer(Source.PBits) + (Source.Height - 1 - I) * Source.WidthBytes);
            Move(SrcP^, DesP^, Source.Width * 2);
            Inc(PByte(SrcP), Source.Width * 2);
          end;
          FreeMem(S);

        end else begin
          SrcP := Source.PBits;
          m_FileStream.Read(SrcP^, ImageInfo.nSize);
          ReverseDIB(Source);
          {for I := 0 to Source.Height - 1 do begin
            SrcP := Pointer(Integer(Source.PBits) + (Source.Height - 1 - I) * Source.WidthBytes);
            m_FileStream.Read(SrcP^, Source.Width * 2);
          end;}
        end;
      end;
      Result := Source;
    end else Result := nil;
  end else Result := nil;
end;

function TData.Get(Index: Integer; var PX, PY: Integer): TDIB;
var
  I, nPosition: Integer;
  ImageInfo: TDataImageInfo;
  S, P: Pointer;
  SrcP: Pointer;
  DesP: Pointer;
begin
  PX := 0;
  PY := 0;
  if Initialized then begin
    if (Index >= 0) and (Index < m_IndexList.Count) then begin
      nPosition := Integer(m_IndexList.Items[Index]);
      m_FileStream.Seek(nPosition, 0);
      m_FileStream.Read(ImageInfo, SizeOf(TDataImageInfo));
      PX := ImageInfo.Px;
      PY := ImageInfo.Py;

      if Source <> nil then FreeAndNil(Source);

      Source := TDIB.Create;
      Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);

      Source.SetSize(ImageInfo.nWidth, ImageInfo.nHeight, 16);
      Source.Canvas.Brush.Color := clblack;
      Source.Canvas.FillRect(Source.Canvas.ClipRect);

      if (ImageInfo.nSize > 0) then begin
        if FHeader.Compression > 0 then begin
          GetMem(P, ImageInfo.nSize);
          GetMem(S, Source.Width * Source.Height * 2);
          SrcP := P;
          DesP := S;
          m_FileStream.Read(SrcP^, ImageInfo.nSize);
          if (ImageInfo.nWidth * ImageInfo.nHeight > 4) then begin
            UnComp(FHeader.Compression, SrcP, ImageInfo.nSize, DesP);
          end else begin
            Move(SrcP^, DesP^, ImageInfo.nSize);
          end;
          FreeMem(P);

          SrcP := S;
          for I := 0 to Source.Height - 1 do begin
            DesP := Pointer(Integer(Source.PBits) + (Source.Height - 1 - I) * Source.WidthBytes);
            Move(SrcP^, DesP^, Source.Width * 2);
            Inc(PByte(SrcP), Source.Width * 2);
          end;
          FreeMem(S);
        end else begin
          SrcP := Source.PBits;
          m_FileStream.Read(SrcP^, ImageInfo.nSize);
          ReverseDIB(Source);
          {for I := 0 to Source.Height - 1 do begin
            SrcP := Pointer(Integer(Source.PBits) + (Source.Height - 1 - I) * Source.WidthBytes);
            m_FileStream.Read(SrcP^, Source.Width * 2);
          end;}
        end;
          //ReverseDIB(Source);
      end;
      Result := Source;
    end else Result := nil;
  end else Result := nil;
end;

function TData.Add(DIB: TDIB; X, Y: Integer): Boolean;
var
  I, nIndex, nIndexOffSet: Integer;
  ImageInfo: TDataImageInfo;
  SrcP: Pointer;
begin
  Result := False;
  ImageInfo.nWidth := DIB.Width;
  ImageInfo.nHeight := DIB.Height;
  ImageInfo.px := X;
  ImageInfo.py := Y;
  ImageInfo.nSize := DIB.Width * DIB.Height * (DIB.BitCount div 8);

  nIndexOffSet := FHeader.IndexOffSet;
  m_FileStream.Seek(FHeader.IndexOffSet, soBeginning);
  m_FileStream.Write(ImageInfo, SizeOf(TDataImageInfo));

  ReverseDIB(DIB);
  SrcP := DIB.PBits;
  m_FileStream.Write(SrcP^, DIB.Width * (BitCount div 8) * DIB.Height);

  {for I := 0 to DIB.Height - 1 do begin
    SrcP := Pointer(Integer(DIB.PBits) + (DIB.Height - 1 - I) * DIB.WidthBytes);
    m_FileStream.Write(SrcP^, DIB.Width * 2);
  end;}

  FHeader.ImageCount := FHeader.ImageCount + 1;
  FHeader.IndexOffSet := m_FileStream.Position;
  m_FileStream.Seek(0, soBeginning);
  m_FileStream.Write(FHeader, SizeOf(TDataHeader));

  m_FileStream.Seek(FHeader.IndexOffSet, soBeginning);
//===================================================================================
  for I := 0 to m_IndexList.Count - 1 do begin
    nIndex := Integer(m_IndexList.Items[I]);
    m_FileStream.Write(nIndex, SizeOf(Integer));
  end;
  m_FileStream.Write(nIndexOffSet, SizeOf(Integer));
  m_IndexList.Add(Pointer(nIndexOffSet));

  ImageCount := ImageCount + 1;
  Result := True;
end;

function TData.Delete(StartIndex, StopIndex: Integer): Boolean;
var
  nIndex: Integer;
  nPosition, nStartPosition, nStopPosition, nSize, nLen, nDeleteCount: Int64;

  MemoryStream: TMemoryStream;
begin
  Result := False;
  if (StartIndex >= 0) and (StartIndex < m_IndexList.Count) and
    (StopIndex >= 0) and (StopIndex < m_IndexList.Count) and
    (StopIndex >= StartIndex) and (m_IndexList.Count > 0) then begin

    nDeleteCount := (StopIndex - StartIndex + 1);
    if StopIndex = m_IndexList.Count - 1 then begin
      nPosition := Integer(m_IndexList.Items[StartIndex]);
      m_FileStream.Seek(0, soBeginning);
      m_FileStream.Size := nPosition;
      FHeader.IndexOffSet := nPosition;
      FHeader.ImageCount := FHeader.ImageCount - nDeleteCount;
      m_FileStream.Seek(0, soBeginning);
      m_FileStream.Write(FHeader, SizeOf(TDataHeader));

    end else begin
      nPosition := Integer(m_IndexList.Items[StopIndex + 1]);
      nStopPosition := Integer(m_IndexList.Items[StopIndex]);
      nStartPosition := Integer(m_IndexList.Items[StartIndex]);
      nSize := nPosition - nStartPosition;

      m_FileStream.Seek(0, soBeginning);
      nLen := m_FileStream.Size - nPosition;

      MemoryStream := TMemoryStream.Create;
      MemoryStream.LoadFromStream(m_FileStream);
      MemoryStream.Seek(nPosition, soBeginning);
      m_FileStream.Seek(nStartPosition, soBeginning);

      m_FileStream.CopyFrom(MemoryStream, nLen);

      m_FileStream.Seek(0, soBeginning);
      m_FileStream.Size := m_FileStream.Size - nSize - m_IndexList.Count * SizeOf(Integer);
      MemoryStream.Free;

      FHeader.IndexOffSet := m_FileStream.Size;
      FHeader.ImageCount := FHeader.ImageCount - nDeleteCount;
      m_FileStream.Seek(0, soBeginning);
      m_FileStream.Write(FHeader, SizeOf(TDataHeader));
    end;

//------------------------------------------------------------------------------

    for nIndex := StartIndex to StopIndex do begin
      m_IndexList.Items[nIndex] := Pointer(-1);
    end;

    for nIndex := m_IndexList.Count - 1 downto 0 do begin
      if Integer(m_IndexList.Items[nIndex]) < 0 then
        m_IndexList.Delete(nIndex);
    end;

    for nIndex := StartIndex to m_IndexList.Count - 1 do begin
      nPosition := Integer(m_IndexList.Items[nIndex]) - nSize;
      m_IndexList.Items[nIndex] := Pointer(nPosition);
    end;

    m_FileStream.Seek(FHeader.IndexOffSet, soBeginning);
    for nIndex := 0 to m_IndexList.Count - 1 do begin
      nPosition := Integer(m_IndexList.Items[nIndex]);
      m_FileStream.Write(nPosition, SizeOf(Integer));
    end;

    ImageCount := ImageCount - nDeleteCount;
    Result := True;
  end;
end;

function TData.Fill(StartIndex, StopIndex: Integer): Boolean;
var
  nIndex: Integer;
  nPosition, nStartPosition, nStopPosition, nSize, nLen, nDeleteCount: Int64;

  FileStream: TFileStream;
  MemoryStream: TMemoryStream;
  ImageInfo: TDataImageInfo;

  DIB: TDIB;
begin
  Result := False;
  if (StartIndex >= 0) and (StartIndex < m_IndexList.Count) and
    (StopIndex >= 0) and (StopIndex < m_IndexList.Count) and
    (StopIndex >= StartIndex) and (m_IndexList.Count > 0) then begin

    if StopIndex = m_IndexList.Count - 1 then begin
      nPosition := Integer(m_IndexList.Items[StartIndex]);
      m_FileStream.Size := nPosition;

      m_FileStream.Seek(nPosition, soBeginning);
      DIB := FillDIB;

      ImageInfo.nWidth := DIB.Width;
      ImageInfo.nHeight := DIB.Height;
      ImageInfo.px := 0;
      ImageInfo.py := 0;
      ImageInfo.nSize := DIB.Width * DIB.Height * (DIB.BitCount div 8);

      for nIndex := StartIndex to StopIndex do begin
        m_IndexList.Items[nIndex] := Pointer(m_FileStream.Position);
        m_FileStream.Write(ImageInfo, SizeOf(TDataImageInfo));
        m_FileStream.Write(DIB.PBits^, ImageInfo.nSize);
      end;
      DIB.Free;

      FHeader.IndexOffSet := m_FileStream.Size;
      m_FileStream.Seek(0, soBeginning);
      m_FileStream.Write(FHeader, SizeOf(TDataHeader));

    end else begin
      m_FileStream.Seek(0, soBeginning);
      m_FileStream.Size := m_FileStream.Size - m_IndexList.Count * SizeOf(Integer);

      nPosition := Integer(m_IndexList.Items[StopIndex + 1]);
      nStopPosition := Integer(m_IndexList.Items[StopIndex]);
      nStartPosition := Integer(m_IndexList.Items[StartIndex]);

      m_FileStream.Seek(0, soBeginning);
      nLen := m_FileStream.Size - nPosition;

      MemoryStream := TMemoryStream.Create;
      MemoryStream.LoadFromStream(m_FileStream);
      MemoryStream.Seek(nPosition, soBeginning);

      m_FileStream.Size := nStartPosition;
      m_FileStream.Seek(nStartPosition, soBeginning);

      DIB := FillDIB;
      ImageInfo.nWidth := DIB.Width;
      ImageInfo.nHeight := DIB.Height;
      ImageInfo.px := 0;
      ImageInfo.py := 0;
      ImageInfo.nSize := DIB.Width * DIB.Height * (DIB.BitCount div 8);

      for nIndex := StartIndex to StopIndex do begin
        m_IndexList.Items[nIndex] := Pointer(m_FileStream.Position);
        m_FileStream.Write(ImageInfo, SizeOf(TDataImageInfo));
        m_FileStream.Write(DIB.PBits^, ImageInfo.nSize);
      end;
      DIB.Free;

      nDeleteCount := (StopIndex - StartIndex + 1);
      nSize := SizeOf(TDataImageInfo) * nDeleteCount + ImageInfo.nSize * nDeleteCount;

      nSize := (nPosition - nStartPosition) - nSize;

      m_FileStream.CopyFrom(MemoryStream, nLen);
      MemoryStream.Free;

      m_FileStream.Seek(0, soBeginning);

      FHeader.IndexOffSet := m_FileStream.Size;
      m_FileStream.Write(FHeader, SizeOf(TDataHeader));
    end;

//------------------------------------------------------------------------------
    for nIndex := StopIndex + 1 to m_IndexList.Count - 1 do begin
      nPosition := Integer(m_IndexList.Items[nIndex]) - nSize;
      m_IndexList.Items[nIndex] := Pointer(nPosition);
    end;

    m_FileStream.Seek(FHeader.IndexOffSet, soBeginning);
    for nIndex := 0 to m_IndexList.Count - 1 do begin
      nPosition := Integer(m_IndexList.Items[nIndex]);
      m_FileStream.Write(nPosition, SizeOf(Integer));
    end;

    Result := True;
  end;
end;

function TData.StartInsert(Index: Integer; var P: Pointer; var Size: Int64): Boolean;
var
  nPosition: Int64;
begin
  Result := False;
  if (Index >= 0) and (Index < m_IndexList.Count) then begin
    nPosition := Integer(m_IndexList.Items[Index]);
    m_FileStream.Seek(0, soBeginning);
    m_FileStream.Size := m_FileStream.Size - m_IndexList.Count * SizeOf(Integer);

    Size := _MAX(m_FileStream.Size - nPosition, 0);
    if Size > 0 then begin
      m_FileStream.Seek(nPosition, soBeginning);
      GetMem(P, Size);
      m_FileStream.Read(P^, Size);
    end;
    m_FileStream.Seek(nPosition, soBeginning);
    Result := True;
  end;
end;

function TData.StopInsert(Index, InsertCount, InsertSize: Integer; P: Pointer; Size: Int64): Boolean;
var
  nIndex: Integer;
  nPosition, nSize: Int64;
begin
  Result := False;
  if (Index >= 0) and (Index < m_IndexList.Count) then begin
    if Size > 0 then begin
      m_FileStream.Write(P^, Size);
      FreeMem(P);
    end;

    FHeader.IndexOffSet := m_FileStream.Size;
    FHeader.ImageCount := FHeader.ImageCount + InsertCount;
    m_FileStream.Seek(0, soBeginning);
    m_FileStream.Write(FHeader, SizeOf(TDataHeader));

//------------------------------------------------------------------------------
    nSize := SizeOf(TDataImageInfo) * InsertCount + InsertSize;
    for nIndex := Index + InsertCount to m_IndexList.Count - 1 do begin
      nPosition := Integer(m_IndexList.Items[nIndex]) + nSize;
      m_IndexList.Items[nIndex] := Pointer(nPosition);
    end;

    m_FileStream.Seek(FHeader.IndexOffSet, soBeginning);
    for nIndex := 0 to m_IndexList.Count - 1 do begin
      nPosition := Integer(m_IndexList.Items[nIndex]);
      m_FileStream.Write(nPosition, SizeOf(Integer));
    end;

    ImageCount := ImageCount + InsertCount;
    Result := True;
  end;
end;

function TData.Insert(Index: Integer; DIB: TDIB; X, Y: Integer): Boolean;
var
  I: Integer;
  SrcP: PByte;
  nPosition: Int64;
  ImageInfo: TDataImageInfo;
begin
  Result := False;
  if (Index >= 0) and (Index < m_IndexList.Count) then begin
    nPosition := m_FileStream.Position;
    ImageInfo.nWidth := DIB.Width;
    ImageInfo.nHeight := DIB.Height;
    ImageInfo.px := X;
    ImageInfo.py := Y;
    ImageInfo.nSize := DIB.Width * DIB.Height * (DIB.BitCount div 8);
    m_FileStream.Write(ImageInfo, SizeOf(TDataImageInfo));

    ReverseDIB(DIB);
    SrcP := DIB.PBits;
    m_FileStream.Write(SrcP^, DIB.Width * (BitCount div 8) * DIB.Height);

    {for I := 0 to DIB.Height - 1 do begin
      SrcP := Pointer(Integer(DIB.PBits) + (DIB.Height - 1 - I) * DIB.WidthBytes);
      m_FileStream.Write(SrcP^, DIB.Width * 2);
    end;}

    m_IndexList.Insert(Index, Pointer(nPosition));

    Result := True;
  end;
end;

function TData.StartReplace(StartIndex, StopIndex: Integer; var Position: Int64; var P: Pointer; var Size: Int64): Boolean;
var
  nPosition, nStartPos, nStopPos: Int64;
begin
  Result := False;
  if (StartIndex >= 0) and (StartIndex < m_IndexList.Count) and
    (StopIndex >= 0) and (StopIndex < m_IndexList.Count) and
    (StopIndex >= StartIndex) and (m_IndexList.Count > 0) then begin
    nStartPos := Integer(m_IndexList.Items[StartIndex]);
    nStopPos := Integer(m_IndexList.Items[StopIndex]);

    m_FileStream.Seek(0, soBeginning);
    m_FileStream.Size := m_FileStream.Size - m_IndexList.Count * SizeOf(Integer);

    if StopIndex = m_IndexList.Count - 1 then begin
      Position := Integer(m_IndexList.Items[StopIndex]);
    end else begin
      Position := Integer(m_IndexList.Items[StopIndex + 1]);
    end;

    m_FileStream.Seek(0, soBeginning);
    Size := _MAX(m_FileStream.Size - Position, 0);
    if Size > 0 then begin
      m_FileStream.Seek(Position, soBeginning);
      GetMem(P, Size);
      m_FileStream.Read(P^, Size);
    end;
    m_FileStream.Size := nStartPos;
    m_FileStream.Seek(nStartPos, soBeginning);
    Result := True;
  end;
end;

function TData.StopReplace(StartIndex, StopIndex: Integer; Position: Int64; P: Pointer; Size: Int64): Boolean;
var
  nIndex, InsertCount: Integer;
  nPosition, nSize: Int64;
begin
  Result := False;
  if (StartIndex >= 0) and (StartIndex < m_IndexList.Count) and
    (StopIndex >= 0) and (StopIndex < m_IndexList.Count) and
    (StopIndex >= StartIndex) and (m_IndexList.Count > 0) then begin

    nSize := m_FileStream.Position - Position;

    if Size > 0 then begin
      m_FileStream.Write(P^, Size);
      FreeMem(P);
    end;

//------------------------------------------------------------------------------
    for nIndex := StopIndex + 1 to m_IndexList.Count - 1 do begin
      nPosition := Integer(m_IndexList.Items[nIndex]) + nSize;
      m_IndexList.Items[nIndex] := Pointer(nPosition);
    end;

    m_FileStream.Seek(0, soBeginning);
    FHeader.IndexOffSet := m_FileStream.Size;
    m_FileStream.Write(FHeader, SizeOf(TDataHeader));

    m_FileStream.Seek(FHeader.IndexOffSet, soBeginning);
    for nIndex := 0 to m_IndexList.Count - 1 do begin
      nPosition := Integer(m_IndexList.Items[nIndex]);
      m_FileStream.Write(nPosition, SizeOf(Integer));
    end;

    Result := True;
  end;
end;

function TData.Replace(Index: Integer; DIB: TDIB; X, Y: Integer): Boolean;
var
  I, nPosition, nLen, nNewSize, nSize, nIndex: Integer;
  SrcP: PByte;
  ImageInfo: TDataImageInfo;
  MemoryStream: TMemoryStream;
begin
  if Index = m_IndexList.Count - 1 then begin
    nPosition := Integer(m_IndexList.Items[Index]);
    m_FileStream.Seek(nPosition, soBeginning);

    m_FileStream.Read(ImageInfo, SizeOf(TDataImageInfo));

    ImageInfo.Px := X;
    ImageInfo.Py := Y;
    ImageInfo.nWidth := DIB.Width;
    ImageInfo.nHeight := DIB.Height;

    ImageInfo.nSize := DIB.Width * DIB.Height * (BitCount div 8);

    m_FileStream.Seek(nPosition, soBeginning);

    m_FileStream.Write(ImageInfo, SizeOf(TDataImageInfo));

    ReverseDIB(DIB);
    SrcP := DIB.PBits;
    m_FileStream.Write(SrcP^, DIB.Width * (BitCount div 8) * DIB.Height);

    m_FileStream.Size := nPosition + SizeOf(TDataImageInfo) + ImageInfo.nSize;


    m_FileStream.Seek(0, soBeginning);
    FHeader.IndexOffSet := m_FileStream.Size;
    m_FileStream.Write(FHeader, SizeOf(TDataHeader));

    m_FileStream.Seek(FHeader.IndexOffSet, soBeginning);
    for I := 0 to m_IndexList.Count - 1 do begin
      nPosition := Integer(m_IndexList.Items[I]);
      m_FileStream.Write(nPosition, SizeOf(Integer));
    end;
  end else begin
    nPosition := Integer(m_IndexList.Items[Index]);
    m_FileStream.Seek(nPosition, soBeginning);
    m_FileStream.Read(ImageInfo, SizeOf(TDataImageInfo));
    nSize := Integer(m_IndexList.Items[Index + 1]) - nPosition;

    nNewSize := SizeOf(TDataImageInfo) + DIB.Width * DIB.Height * (BitCount div 8);

    m_FileStream.Seek(0, soBeginning);
    nLen := m_FileStream.Size - Integer(m_IndexList.Items[Index + 1]);

    MemoryStream := TMemoryStream.Create;
    MemoryStream.LoadFromStream(m_FileStream);
    MemoryStream.Seek(Integer(m_IndexList.Items[Index + 1]), soBeginning);
    m_FileStream.Seek(nPosition, soBeginning);

    ImageInfo.Px := X;
    ImageInfo.Py := Y;
    ImageInfo.nWidth := DIB.Width;
    ImageInfo.nHeight := DIB.Height;
    ImageInfo.nSize := DIB.Width * DIB.Height * (BitCount div 8);

    m_FileStream.Write(ImageInfo, SizeOf(TDataImageInfo));

    ReverseDIB(DIB);
    SrcP := DIB.PBits;
    m_FileStream.Write(SrcP^, DIB.Width * (BitCount div 8) * DIB.Height);

    m_FileStream.CopyFrom(MemoryStream, nLen);
    m_FileStream.Size := m_FileStream.Size - (nSize - nNewSize);
    MemoryStream.Free;

//------------------------------------------------------------------------------
    for nIndex := Index + 1 to m_IndexList.Count - 1 do begin
      nPosition := Integer(m_IndexList.Items[nIndex]) - (nSize - nNewSize);
      m_IndexList.Items[nIndex] := Pointer(nPosition);
    end;
  end;

  m_FileStream.Seek(0, soBeginning);
  FHeader.IndexOffSet := m_FileStream.Size;
  m_FileStream.Write(FHeader, SizeOf(TDataHeader));

  m_FileStream.Seek(FHeader.IndexOffSet, soBeginning);
  for I := 0 to m_IndexList.Count - 1 do begin
    nPosition := Integer(m_IndexList.Items[I]);
    m_FileStream.Write(nPosition, SizeOf(Integer));
  end;
end;


function TData.Replace(Index: Integer; DIB: TDIB): Boolean;
var
  I, nPosition, nLen, nNewSize, nSize, nIndex: Integer;
  SrcP: PByte;
  ImageInfo: TDataImageInfo;
  MemoryStream: TMemoryStream;
begin
  if Index = m_IndexList.Count - 1 then begin
    nPosition := Integer(m_IndexList.Items[Index]);
    m_FileStream.Seek(nPosition, soBeginning);

    m_FileStream.Read(ImageInfo, SizeOf(TDataImageInfo));

    ImageInfo.nWidth := DIB.Width;
    ImageInfo.nHeight := DIB.Height;

    ImageInfo.nSize := DIB.Width * DIB.Height * (BitCount div 8);

    m_FileStream.Seek(nPosition, soBeginning);

    m_FileStream.Write(ImageInfo, SizeOf(TDataImageInfo));

    ReverseDIB(DIB);
    SrcP := DIB.PBits;
    m_FileStream.Write(SrcP^, DIB.Width * (BitCount div 8) * DIB.Height);

    m_FileStream.Size := nPosition + SizeOf(TDataImageInfo) + ImageInfo.nSize;
  end else begin
    nPosition := Integer(m_IndexList.Items[Index]);
    m_FileStream.Seek(nPosition, soBeginning);
    m_FileStream.Read(ImageInfo, SizeOf(TDataImageInfo));
    nSize := Integer(m_IndexList.Items[Index + 1]) - nPosition;

    nNewSize := SizeOf(TDataImageInfo) + DIB.Width * DIB.Height * (BitCount div 8);

    m_FileStream.Seek(0, soBeginning);
    nLen := m_FileStream.Size - Integer(m_IndexList.Items[Index + 1]);

    MemoryStream := TMemoryStream.Create;
    MemoryStream.LoadFromStream(m_FileStream);
    MemoryStream.Seek(Integer(m_IndexList.Items[Index + 1]), soBeginning);
    m_FileStream.Seek(nPosition, soBeginning);

    ImageInfo.nWidth := DIB.Width;
    ImageInfo.nHeight := DIB.Height;
    ImageInfo.nSize := DIB.Width * DIB.Height * (BitCount div 8);

    m_FileStream.Write(ImageInfo, SizeOf(TDataImageInfo));

    ReverseDIB(DIB);
    SrcP := DIB.PBits;
    m_FileStream.Write(SrcP^, DIB.Width * (BitCount div 8) * DIB.Height);

    m_FileStream.CopyFrom(MemoryStream, nLen);
    m_FileStream.Size := m_FileStream.Size - (nSize - nNewSize);
    MemoryStream.Free;

//------------------------------------------------------------------------------
    for nIndex := Index + 1 to m_IndexList.Count - 1 do begin
      nPosition := Integer(m_IndexList.Items[nIndex]) - (nSize - nNewSize);
      m_IndexList.Items[nIndex] := Pointer(nPosition);
    end;
  end;

  m_FileStream.Seek(0, soBeginning);
  FHeader.IndexOffSet := m_FileStream.Size;
  m_FileStream.Write(FHeader, SizeOf(TDataHeader));

  m_FileStream.Seek(FHeader.IndexOffSet, soBeginning);
  for I := 0 to m_IndexList.Count - 1 do begin
    nPosition := Integer(m_IndexList.Items[I]);
    m_FileStream.Write(nPosition, SizeOf(Integer));
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

