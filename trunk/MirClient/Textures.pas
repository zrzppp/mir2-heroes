unit Textures;

interface
uses
  Windows, SysUtils, Classes, Graphics, Controls, Math, DIB, DXClass, Forms;

type
  TTexture = class(TObject)
  private
    FHeight: Integer;
    FWidth: Integer;
    FPitch: Integer;
    FPBits: Pointer;
    FBitCount: Byte;
    FTransparentColor: TColor;
    procedure SetWidth(Value: Integer);
    procedure SetHeight(Value: Integer);
    function GetPBits: Pointer;

    procedure SetTransparentColor(Value: TColor);
    function GetClientRect(): TRect;
    function GetPixel(X, Y: Integer): Dword;
    procedure SetPixel(X, Y: Integer; Value: Dword);
    function GetPixel16(X, Y: Integer): Word;
    procedure SetPixel16(X, Y: Integer; Value: Word);
    procedure ChangeSize(AWidth, AHeight: Integer);
    function GetScanLine(Y: Integer): Pointer;
  public
    constructor Create();
    destructor Destroy; override;
    property ClientRect: TRect read GetClientRect;
    property BitCount: Byte read FBitCount;
    property Width: Integer read FWidth write SetWidth;
    property Height: Integer read FHeight write SetHeight;
    property Pitch: Integer read FPitch;
    property PBits: Pointer read GetPBits;
    property ScanLine[Y: Integer]: Pointer read GetScanLine;
    property Pixels[X, Y: Integer]: DWord read GetPixel write SetPixel;
    property Pixels16[X, Y: Integer]: Word read GetPixel16 write SetPixel16;

    property TransparentColor: TColor read FTransparentColor write FTransparentColor;
    procedure SetSize(AWidth, AHeight: Integer);

    procedure LoadFromFile(const FileName: string);
    procedure LoadFromDIB(const Source: TDIB);
    procedure SaveToFile(const FileName: string);

    procedure Assign(Source: TTexture);

    procedure Draw(X, Y: Integer; SrcRect: TRect; Source: TTexture;
      TRANSPARENT: Boolean = True; MIRRORUPDOWN: Boolean = FALSE); overload;
    procedure Draw(X, Y: Integer; Source: TTexture; TRANSPARENT: Boolean = True); overload;
    procedure DrawAlpha(const Dest, Src: TRect; Source: TTexture;
      TRANSPARENT: Boolean; Alpha: Integer);
    procedure DrawSurface(SrcR, DestR: TRect; DestP: PByte; DestPitch, BitCount: Integer);
    procedure FastDrawAlpha(const Dest, Src: TRect; Source: TTexture; TRANSPARENT: Boolean = True);

    procedure StretchDraw(const Dest, Src: TRect; Source: TTexture;
      TRANSPARENT: Boolean); overload;
    procedure StretchDraw(const Dest: TRect; Source: TTexture;
      TRANSPARENT: Boolean = True); overload;
    procedure Filter(const Rect: TRect; DevColor: TColor);
    procedure Fill(DevColor: TColor);
    procedure FillRect(const Rect: TRect; DevColor: TColor);
    procedure FillRectAlpha(const Rect: TRect; Color: TColor; Alpha: Integer);
    procedure FrameRect(const Rect: TRect; DevColor: TColor);
    procedure Line(X1, Y1, X2, Y2: Integer; DevColor: TColor);

    function TextWidth(const Text: string): Integer;
    function TextHeight(const Text: string): Integer;

    procedure TextOut(X, Y: Integer;
      const Text: string; FColor: TColor = clWhite; Bcolor: TColor = clBlack);
    procedure TextRect(Rect: TRect;
      X, Y: Integer; const Text: string;
      FColor: TColor = clWhite; Bcolor: TColor = clBlack);

    procedure BoldTextOut(X, Y: Integer;
      const Text: string; FColor: TColor = clWhite; Bcolor: TColor = $00050505);

    procedure BoldTextRect(Rect: TRect;
      X, Y: Integer; const Text: string;
      FColor: TColor = clWhite; Bcolor: TColor = $00050505);
    procedure Noise(Color: TColor);
    procedure Side(Source, MarkColor: TColor);
  end;

  TTextureList = class
  private
    function GetCount: Integer;
    function GetTexture(Index: Integer): TTexture;
  public
    List: TList;
    constructor Create();
    destructor Destroy; override;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TTexture read GetTexture;
  end;

  TTextureDevice = class(TComponent)
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
  end;

  pTTextureFont = ^TTextureFont;
  TTextureFont = packed record
    Data: PByte;
    Text: string;
    Time: LongWord;
    Name: TFontName;
    Size: Integer;
    Style: TFontStyles;
    Width: Integer;
    Height: Integer;
  end;

  pTFontText = ^TFontText;
  TFontText = packed record
    Font: TTexture;
    Text: string;
    Time: LongWord;
    Name: TFontName;
    Size: Integer;
    Style: TFontStyles;
    FColor: TColor;
    Bcolor: TColor;
  end;

  TImageFont = class
  private
    FontList: TList;
    FontTextList: TList;
    FreeOutTimeTick: LongWord;
    FreeFontTextOutTimeTick: LongWord;
    procedure FreeOutTime;
    procedure FreeFontTextOutTime;
    function GetCount: Integer;
    function GetTextData(Text: string): pTTextureFont;
    procedure DrawFont(pSrc, pDst: PByte; nPitch, nWidth, nHeight: Integer; Color: TColor);
  public
    constructor Create();
    destructor Destroy; override;
    procedure Clear;
    function TextHeight(const Text: string): Integer;
    function TextWidth(const Text: string): Integer;

    procedure DrawRect(DIB: TTexture; Rect: TRect; X, Y: Integer; const Text: string;
      FColor: TColor = clWhite; BColor: TColor = clBlack);

    procedure BoldDrawRect(DIB: TTexture;
      Rect: TRect; X, Y: Integer; const Text: string;
      FColor: TColor = clWhite; BColor: TColor = clBlack);

    procedure Draw(DIB: TTexture; X, Y: Integer; const Text: string; FColor: TColor = clWhite; BColor: TColor = clBlack);
    procedure BoldDraw(DIB: TTexture; X, Y: Integer; const Text: string; FColor: TColor = clWhite; BColor: TColor = clBlack);

    procedure DrawEditText(DIB: TTexture; const X, Y: Integer;
      const ARect, BRect, CRect: TRect;
      const AText, BText, CText: string;
      FontColor: TColor = clBlack;
      SelFontColor: TColor = clWhite;
      SelBackColor: TColor = clBlue);

    function GetTextDIB(Text: string; FColor, BColor: TColor): TTexture;
    property Count: Integer read GetCount;
  end;
procedure Move(const Source; var Dest; count: Integer);
function RGB16(r, G, b: Integer): Word; overload;
function RGB16(c: TColor): Word; overload;
function Bit16To64(Val: Word): Int64;
procedure Register;
var
  //TextureList: TTextureList;
  ImageFont: TImageFont = nil;
  Background: TTexture = nil;
  ImageCanvas: TTexture = nil;
  MainForm: TDxForm = nil;

  IsMMX: Boolean;
  IsSSE: Boolean;
implementation
uses MSI_CPU;
var
  mask_r: Int64 = $F800F800F800F800; // 红色掩码
  mask_g: Int64 = $07E007E007E007E0; // 绿色掩码
  mask_b: Int64 = $001F001F001F001F; // 蓝色掩码

function Bit16To64(Val: Word): Int64;
var
  bit64: Int64;
begin
  bit64 := Val;
  Result := bit64 or (bit64 shl 16) or (bit64 shl 32) or (bit64 shl 48);
end;

// 将红，绿，蓝三分量转换为COLOR

function RGB16(r, G, b: Integer): Word;
begin
  Result := Word((b and $F8) shr 3 or (G and $FC) shl 3 or (r and $F8) shl 8);
end;

// 将32位GDI颜色值转换为COLOR

function RGB16(c: TColor): Word;
begin
  Result := Word((c shl 8 and $F800) or (c shr 5 and $7E0) or (c shr 19 and $1F));
end;

function RGB32(c: Word): TColor;
begin
  Result := RGB(c and $F800 shr 8, c and $07E0 shr 3, c and $001F shl 3);
end;

procedure TextOutFile(Msg: string);
var
  flname: string;
  fhandle: TextFile;
begin
//DScreen.AddChatBoardString(msg,clWhite, clBlack);
 // exit;
  flname := '.\OutFile.txt';
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

function ClipRect(var DestRect: TRect; const DestRect2: TRect): Boolean;
begin
  with DestRect do
  begin
    Left := Max(Left, DestRect2.Left);
    Right := Min(Right, DestRect2.Right);
    Top := Max(Top, DestRect2.Top);
    Bottom := Min(Bottom, DestRect2.Bottom);

    Result := (Left < Right) and (Top < Bottom);
  end;
end;

function ClipRect2(var DestRect, SrcRect: TRect; const DestRect2, SrcRect2: TRect): Boolean;
begin
  if DestRect.Left < DestRect2.Left then
  begin
    SrcRect.Left := SrcRect.Left + (DestRect2.Left - DestRect.Left);
    DestRect.Left := DestRect2.Left;
  end;

  if DestRect.Top < DestRect2.Top then
  begin
    SrcRect.Top := SrcRect.Top + (DestRect2.Top - DestRect.Top);
    DestRect.Top := DestRect2.Top;
  end;

  if SrcRect.Left < SrcRect2.Left then
  begin
    DestRect.Left := DestRect.Left + (SrcRect2.Left - SrcRect.Left);
    SrcRect.Left := SrcRect2.Left;
  end;

  if SrcRect.Top < SrcRect2.Top then
  begin
    DestRect.Top := DestRect.Top + (SrcRect2.Top - SrcRect.Top);
    SrcRect.Top := SrcRect2.Top;
  end;

  if DestRect.Right > DestRect2.Right then
  begin
    SrcRect.Right := SrcRect.Right - (DestRect.Right - DestRect2.Right);
    DestRect.Right := DestRect2.Right;
  end;

  if DestRect.Bottom > DestRect2.Bottom then
  begin
    SrcRect.Bottom := SrcRect.Bottom - (DestRect.Bottom - DestRect2.Bottom);
    DestRect.Bottom := DestRect2.Bottom;
  end;

  if SrcRect.Right > SrcRect2.Right then
  begin
    DestRect.Right := DestRect.Right - (SrcRect.Right - SrcRect2.Right);
    SrcRect.Right := SrcRect2.Right;
  end;

  if SrcRect.Bottom > SrcRect2.Bottom then
  begin
    DestRect.Bottom := DestRect.Bottom - (SrcRect.Bottom - SrcRect2.Bottom);
    SrcRect.Bottom := SrcRect2.Bottom;
  end;

  Result := (DestRect.Left < DestRect.Right) and (DestRect.Top < DestRect.Bottom) and
    (SrcRect.Left < SrcRect.Right) and (SrcRect.Top < SrcRect.Bottom);
end;

procedure Move(const Source; var Dest; count: Integer);
asm
  cmp     eax, edx
  je      @@Exit {Source = Dest}
  cmp     ecx, 32
  ja      @@LargeMove {Count > 32 or Count < 0}
  sub     ecx, 8
  jg      @@SmallMove
@@TinyMove: {0..8 Byte Move}
  jmp     dword ptr [@@JumpTable+32+ecx*4]
@@SmallMove: {9..32 Byte Move}
  fild    qword ptr [eax+ecx] {Load Last 8}
  fild    qword ptr [eax] {Load First 8}
  cmp     ecx, 8
  jle     @@Small16
  fild    qword ptr [eax+8] {Load Second 8}
  cmp     ecx, 16
  jle     @@Small24
  fild    qword ptr [eax+16] {Load Third 8}
  fistp   qword ptr [edx+16] {Save Third 8}
@@Small24:
  fistp   qword ptr [edx+8] {Save Second 8}
@@Small16:
  fistp   qword ptr [edx] {Save First 8}
  fistp   qword ptr [edx+ecx] {Save Last 8}
@@exit:
  ret
  nop {4-Byte Align JumpTable}
  nop
@@JumpTable: {4-Byte Aligned}
  dd      @@Exit, @@M01, @@M02, @@M03, @@M04, @@M05, @@M06, @@M07, @@M08
@@LargeForwardMove: {4-Byte Aligned}
  push    edx
  fild    qword ptr [eax] {First 8}
  lea     eax, [eax+ecx-8]
  lea     ecx, [ecx+edx-8]
  fild    qword ptr [eax] {Last 8}
  push    ecx
  neg     ecx
  and     edx, -8 {8-Byte Align Writes}
  lea     ecx, [ecx+edx+8]
  pop     edx
@FwdLoop:
  fild    qword ptr [eax+ecx]
  fistp   qword ptr [edx+ecx]
  add     ecx, 8
  jl      @FwdLoop
  fistp   qword ptr [edx] {Last 8}
  pop     edx
  fistp   qword ptr [edx] {First 8}
  ret
@@LargeMove:
  jng     @@LargeDone {Count < 0}
  cmp     eax, edx
  ja      @@LargeForwardMove
  sub     edx, ecx
  cmp     eax, edx
  lea     edx, [edx+ecx]
  jna     @@LargeForwardMove
  sub     ecx, 8 {Backward Move}
  push    ecx
  fild    qword ptr [eax+ecx] {Last 8}
  fild    qword ptr [eax] {First 8}
  add     ecx, edx
  and     ecx, -8 {8-Byte Align Writes}
  sub     ecx, edx
@BwdLoop:
  fild    qword ptr [eax+ecx]
  fistp   qword ptr [edx+ecx]
  sub     ecx, 8
  jg      @BwdLoop
  pop     ecx
  fistp   qword ptr [edx] {First 8}
  fistp   qword ptr [edx+ecx] {Last 8}
@@LargeDone:
  ret
@@M01:
  movzx   ecx, [eax]
  mov     [edx], cl
  ret
@@M02:
  movzx   ecx, word ptr [eax]
  mov     [edx], cx
  ret
@@M03:
  mov     cx, [eax]
  mov     al, [eax+2]
  mov     [edx], cx
  mov     [edx+2], al
  ret
@@M04:
  mov     ecx, [eax]
  mov     [edx], ecx
  ret
@@M05:
  mov     ecx, [eax]
  mov     al, [eax+4]
  mov     [edx], ecx
  mov     [edx+4], al
  ret
@@M06:
  mov     ecx, [eax]
  mov     ax, [eax+4]
  mov     [edx], ecx
  mov     [edx+4], ax
  ret
@@M07:
  mov     ecx, [eax]
  mov     eax, [eax+3]
  mov     [edx], ecx
  mov     [edx+3], eax
  ret
@@M08:
  fild    qword ptr [eax]
  fistp   qword ptr [edx]
end;

constructor TTexture.Create();
begin
  inherited;
  //if Assigned(TextureList) then
    //TextureList.List.Add(Self);
  FTransparentColor := $0000;
  FWidth := 0;
  FHeight := 0;
  FPitch := 0;
  FPBits := nil;
  FBitCount := 16;
end;

destructor TTexture.Destroy;
begin
  if Assigned(FPBits) then
    FreeMem(FPBits);
  //if Assigned(TextureList) then
    //TextureList.List.Remove(Self);
  inherited;
end;

procedure TTexture.ChangeSize(AWidth, AHeight: Integer);
begin
  if (FWidth <> AWidth) or (FHeight <> AHeight) then begin
    FWidth := AWidth;
    FHeight := AHeight;
    FPitch := (((FWidth * BitCount) + 31) shr 5) * 4;

    if Assigned(FPBits) then begin
      FreeMem(FPBits);
      FPBits := nil;
    end;
    FPBits := AllocMem(FPitch * FHeight);
  end;
end;

function TTexture.GetPBits: Pointer;
begin
  Result := FPBits;
end;

function TTexture.GetScanLine(Y: Integer): Pointer;
begin
  if (Y >= 0) and (Y < Height) then
    Result := Pointer(Integer(FPBits) + Y * FPitch)
  else
    Result := nil;
end;

procedure TTexture.SetSize(AWidth, AHeight: Integer);
begin
  ChangeSize(AWidth, AHeight);
end;

procedure TTexture.SetHeight(Value: Integer);
begin
  if Value <> FHeight then begin
    ChangeSize(FWidth, Value);
  end;
end;

procedure TTexture.SetWidth(Value: Integer);
begin
  if Value <> FWidth then begin
    ChangeSize(Value, FHeight);
  end;
end;

procedure TTexture.SetPixel(X, Y: Integer; Value: Dword);
begin
  if (X >= 0) and (X < Width) and (Y >= 0) and (Y < Height) then
    PWord(Integer(FPBits) + Y * Pitch + X * 2)^ := RGB16(Value);
end;

function TTexture.GetPixel(X, Y: Integer): Dword;
begin
  Result := 0;
  if (X >= 0) and (X < Width) and (Y >= 0) and (Y < Height) then
    Result := RGB32(PWord(Integer(FPBits) + Y * Pitch + X * 2)^);
end;

procedure TTexture.SetPixel16(X, Y: Integer; Value: Word);
begin
  if (X >= 0) and (X < Width) and (Y >= 0) and (Y < Height) then
    PWord(Integer(FPBits) + Y * Pitch + X * 2)^ := Value;
end;

function TTexture.GetPixel16(X, Y: Integer): Word;
begin
  Result := 0;
  if (X >= 0) and (X < Width) and (Y >= 0) and (Y < Height) then
    Result := PWord(Integer(FPBits) + Y * Pitch + X * 2)^;
end;

function TTexture.GetClientRect(): TRect;
begin
  Result := Bounds(0, 0, Width, Height);
end;

procedure TTexture.SetTransparentColor(Value: TColor);
begin
  FTransparentColor := Value;
end;

procedure TTexture.LoadFromDIB(const Source: TDIB);
var
  I, II: Integer;
  pSrc, pDst: PByte;
begin
  SetSize(Source.Width, Source.Height);
  Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
  Source.BitCount := 16;
  for I := 0 to Source.Height - 1 do begin
    pSrc := PByte(Integer(Source.PBits) + (Source.Height - 1 - I) * Source.WidthBytes);
    pDst := PByte(Integer(PBits) + I * Pitch);
    Move(pSrc^, pDst^, Min(Pitch, Source.WidthBytes));
  end;
end;

procedure TTexture.LoadFromFile(const FileName: string);
var
  I, II: Integer;
  Source: TDIB;
  pSrc, pDst: PByte;
begin
  Source := TDIB.Create;
  try
    Source.LoadFromFile(FileName);
    Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
    Source.BitCount := 16;
    SetSize(Source.Width, Source.Height);
    for I := 0 to Source.Height - 1 do begin
      pSrc := PByte(Integer(Source.PBits) + (Source.Height - 1 - I) * Source.WidthBytes);
      pDst := PByte(Integer(PBits) + I * Pitch);
      Move(pSrc^, pDst^, Pitch);
    end;
  finally
    Source.Free;
  end;
end;

procedure TTexture.SaveToFile(const FileName: string);
var
  I: Integer;
  Source: TDIB;
  pSrc, pDst: PByte;
begin
  Source := TDIB.Create;
  try
    Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
    Source.SetSize(Width, Height, 16);
    for I := 0 to Source.Height - 1 do begin
      pSrc := PByte(Integer(PBits) + (Source.Height - I - 1) * Pitch);
      pDst := PByte(Integer(Source.PBits) + I * Source.Width * 2);
      Move(pSrc^, pDst^, Pitch);
    end;
    Source.SaveToFile(FileName);
  finally
    Source.Free;
  end;
end;

procedure TTexture.Assign(Source: TTexture);
begin
  SetSize(Source.Width, Source.Height);
  TransparentColor := Source.TransparentColor;
  Draw(0, 0, Source, False);
end;

procedure TTexture.Filter(const Rect: TRect; DevColor: TColor);
begin

end;

procedure TTexture.Draw(X, Y: Integer; SrcRect: TRect; Source: TTexture;
  TRANSPARENT: Boolean = True;
  MIRRORUPDOWN: Boolean = FALSE);
var
  DestRect: TRect;
  I, j, k, L: Integer;
  nX, nY: Integer;
  pSrc, pDst: PByte;
  nWidth: Integer;
  nHeight: Integer;
  nCol64: Int64;
  wColor: Word;
  nSLeft: Integer;
  nDLeft: Integer;
  nMMXM: Integer;
  nSSEM: Integer;
  nMMXW: Integer;
  nSSEW: Integer;
begin
  if Source <> nil then begin
    if (X > Width) or (Y > Height) then Exit;
    with SrcRect do
      DestRect := Bounds(X, Y, Right - Left, Bottom - Top);

    if not MIRRORUPDOWN then begin

      if ClipRect2(DestRect, SrcRect, ClientRect, Source.ClientRect) then begin
        nWidth := SrcRect.Right - SrcRect.Left;
        nHeight := SrcRect.Bottom - SrcRect.Top;
        if TRANSPARENT then begin

          wColor := RGB16(Source.TransparentColor);
          nCol64 := Bit16To64(wColor);
          nSLeft := SrcRect.Left * 2;
          nDLeft := DestRect.Left * 2;

          if IsSSE then begin
            nSSEM := nWidth mod 8;
            nSSEW := nWidth div 8;
          end else begin
            nSSEM := 0;
            nSSEW := 0;
          end;

          if nSSEW > 0 then begin
            nMMXM := nSSEM mod 4;
            nMMXW := nSSEM div 4;
          end else begin
            nMMXM := nWidth mod 4;
            nMMXW := nWidth div 4;
          end;

          for nY := 0 to nHeight - 1 do begin
            pSrc := PByte(Integer(Source.PBits) + (SrcRect.Top + nY) * Source.Pitch + nSLeft);
            pDst := PByte(Integer(PBits) + (DestRect.Top + nY) * Pitch + nDLeft);
            k := nWidth;

            if IsSSE then begin
              for nX := 0 to nSSEW - 1 do begin
                asm
                 mov     edx,  pDst		// edx = 目的指针
                 mov     ecx,  pSrc		// ecx = 源指针
                 movlps  xmm7, nCol64		// 64位颜色键
                 movhps  xmm7, nCol64		// 64位颜色键
                 movdqu  xmm0, [ecx]		// 从源地址取8象素数据
                 movdqu  xmm2, [edx]		// 从源地址取8象素数据

                 movdqu  xmm1, xmm0		// 源数据给mm1
                 pcmpeqw xmm0, xmm7	// mm0为透明掩码
                 psubusw xmm1, xmm0	// 源数据透明点置0
                 pand    xmm0, xmm2		// 目的数据非透明点置0
                 por     xmm0, xmm1		// 相与得结果数据
                 movdqu  [edx],xmm0		// 结果送目的地址

                 add     ecx,  16
                 add     edx, 16
                 sub     k,   8
                 mov     integer ptr[pSrc], ecx
                 mov     integer ptr[pDst], edx
                end;
              end;
            end;

            for nX := 0 to nMMXW - 1 do begin
              asm
                 mov     edx,  pDst		// edx = 目的指针
                 mov     ecx,  pSrc		// ecx = 源指针
                 movq    mm7,  nCol64		// 64位颜色键
                 movq    mm0, [ecx]		// 从源地址取4象素数据
                 movq    mm2, [edx]		// 从源地址取8象素数据
                 movq    mm1, mm0		// 源数据给mm1
                 pcmpeqw mm0, mm7	// mm0为透明掩码
                 psubusw mm1, mm0	// 源数据透明点置0
                 pand    mm0, mm2		// 目的数据非透明点置0
                 por     mm0, mm1		// 相与得结果数据
                 movq    [edx], mm0		// 结果送目的地址
                 add     ecx, 8
                 add     edx, 8
                 sub     k,   4
                 mov     integer ptr[pSrc], ecx
                 mov     integer ptr[pDst], edx
              end;
            end;

            asm
              emms
            end;

            for nX := 0 to k - 1 do begin //剩余处理
              if PWord(pSrc)^ <> wColor then
                PWord(pDst)^ := PWord(pSrc)^;
              Inc(pSrc, 2);
              Inc(pDst, 2);
            end;
          end;

        end else begin
          nSLeft := SrcRect.Left * 2;
          nDLeft := DestRect.Left * 2;
          nWidth := nWidth * 2;
          for nY := 0 to nHeight - 1 do begin
            pSrc := PByte(Integer(Source.PBits) + (SrcRect.Top + nY) * Source.Pitch + nSLeft);
            pDst := PByte(Integer(PBits) + (DestRect.Top + nY) * Pitch + nDLeft);
            Move(pSrc^, pDst^, nWidth);
          end;
        end;
      end;

    end else begin //if not MIRRORUPDOWN then begin
      if ClipRect2(DestRect, SrcRect, ClientRect, Source.ClientRect) then begin
        nWidth := SrcRect.Right - SrcRect.Left;
        nHeight := SrcRect.Bottom - SrcRect.Top;
        if TRANSPARENT then begin
          wColor := RGB16(Source.TransparentColor);
          nCol64 := Bit16To64(wColor);
          nSLeft := SrcRect.Left * 2;
          nDLeft := DestRect.Left * 2;

          if IsSSE then begin
            nSSEM := nWidth mod 8;
            nSSEW := nWidth div 8;
          end else begin
            nSSEM := 0;
            nSSEW := 0;
          end;

          if nSSEW > 0 then begin
            nMMXM := nSSEM mod 4;
            nMMXW := nSSEM div 4;
          end else begin
            nMMXM := nWidth mod 4;
            nMMXW := nWidth div 4;
          end;

          for nY := nHeight - 1 downto 0 do begin
            pSrc := PByte(Integer(Source.PBits) + (SrcRect.Top + nHeight - nY - 1) * Source.Pitch + nSLeft);
            pDst := PByte(Integer(PBits) + (DestRect.Top + nY) * Pitch + nDLeft);
            k := nWidth;

            if IsSSE then begin
              for nX := 0 to nSSEW - 1 do begin
                asm
                 mov     edx,  pDst		// edx = 目的指针
                 mov     ecx,  pSrc		// ecx = 源指针
                 movlps  xmm7, nCol64		// 64位颜色键
                 movhps  xmm7, nCol64		// 64位颜色键
                 movdqu  xmm0, [ecx]		// 从源地址取8象素数据
                 movdqu  xmm2, [edx]		// 从源地址取8象素数据
                 add     ecx,  16
                 movdqu  xmm1, xmm0		// 源数据给mm1
                 pcmpeqw xmm0, xmm7	// mm0为透明掩码
                 psubusw xmm1, xmm0	// 源数据透明点置0
                 pand    xmm0, xmm2		// 目的数据非透明点置0
                 por     xmm0, xmm1		// 相与得结果数据
                 movdqu  [edx],xmm0		// 结果送目的地址
                 add     edx, 16
                 sub     k,   8
                 mov     integer ptr[pSrc], ecx
                 mov     integer ptr[pDst], edx
                end;
              end;
            end;

            for nX := 0 to nMMXW - 1 do begin
              asm
                 mov     edx,  pDst		// edx = 目的指针
                 mov     ecx,  pSrc		// ecx = 源指针
                 movq    mm7,  nCol64		// 64位颜色键
                 movq    mm0, [ecx]		// 从源地址取4象素数据
                 movq    mm2, [edx]		// 从源地址取8象素数据
                 add     ecx, 8
                 movq    mm1, mm0		// 源数据给mm1
                 pcmpeqw mm0, mm7	// mm0为透明掩码
                 psubusw mm1, mm0	// 源数据透明点置0
                 pand    mm0, mm2		// 目的数据非透明点置0
                 por     mm0, mm1		// 相与得结果数据
                 movq    [edx], mm0		// 结果送目的地址
                 add     edx, 8
                 sub     k,   4
                 mov     integer ptr[pSrc], ecx
                 mov     integer ptr[pDst], edx
              end;
            end;

            asm
               emms
            end;

            for nX := 0 to k - 1 do begin //剩余处理
              if PWord(pSrc)^ <> wColor then PWord(pDst)^ := PWord(pSrc)^;
              Inc(pSrc, 2);
              Inc(pDst, 2);
            end;
          end;

        end else begin
          nSLeft := SrcRect.Left * 2;
          nDLeft := DestRect.Left * 2;
          nWidth := nWidth * 2;
          for nY := nHeight - 1 downto 0 do begin
            pSrc := PByte(Integer(Source.PBits) + (SrcRect.Top + nHeight - nY - 1) * Source.Pitch + nSLeft);
            pDst := PByte(Integer(PBits) + (DestRect.Top + nY) * Pitch + nDLeft);

            Move(pSrc^, pDst^, nWidth);
          end;
        end;
      end;
    end;
  end;
end;

procedure TTexture.Draw(X, Y: Integer; Source: TTexture; TRANSPARENT: Boolean = True);
begin
  Draw(X, Y, Source.ClientRect, Source, TRANSPARENT);
end;

procedure TTexture.DrawAlpha(const Dest, Src: TRect; Source: TTexture;
  TRANSPARENT: Boolean; Alpha: Integer);
var
  DestRect, SrcRect: TRect;
  nX, nY, j, k, L: Integer;
  pSrc, pDst: PByte;
  nWidth: Integer;
  nHeight: Integer;
  nCol64: Int64;
  wColor: Word;
  nAlpha64: Int64;
  nSLeft: Integer;
  nDLeft: Integer;
  r, G, b, dr, dg, db: byte;

  nMMXM: Integer;
  nSSEM: Integer;
  nMMXW: Integer;
  nSSEW: Integer;
begin
  if Source <> nil then begin
    DestRect := Dest;
    SrcRect := Src;
    if ClipRect2(DestRect, SrcRect, ClientRect, Source.ClientRect) then begin
      if (Alpha >= 0) and (Alpha <= 256) then begin
        wColor := RGB16(Source.TransparentColor);
        nCol64 := Bit16To64(wColor);
        nAlpha64 := Bit16To64(Alpha shr 3);
        nWidth := SrcRect.Right - SrcRect.Left;
        nHeight := SrcRect.Bottom - SrcRect.Top;

        if TRANSPARENT then begin
          k := nWidth mod 4;
          nSLeft := SrcRect.Left * 2;
          nDLeft := DestRect.Left * 2;

          if IsSSE then begin
            nSSEM := nWidth mod 8;
            nSSEW := nWidth div 8;
          end else begin
            nSSEM := 0;
            nSSEW := 0;
          end;

          if nSSEW > 0 then begin
            nMMXM := nSSEM mod 4;
            nMMXW := nSSEM div 4;
          end else begin
            nMMXM := nWidth mod 4;
            nMMXW := nWidth div 4;
          end;

          for nY := 0 to nHeight - 1 do begin
            pSrc := PByte(Integer(Source.PBits) + (SrcRect.Top + nY) * Source.Pitch + nSLeft);
            pDst := PByte(Integer(PBits) + (DestRect.Top + nY) * Pitch + nDLeft);
            k := nWidth;

            if IsSSE then begin
              for nX := 0 to nSSEW - 1 do begin
                asm
                   mov edx, pDst		// edx = 目的指针
                   mov ecx, pSrc		// ecx = 源指针
                   movlps xmm1, nCol64
                   movhps xmm1, nCol64

                 {  movd eax, xmm1
                   cmp [ecx], eax
                   jnz @notequal_sse
                   cmp [ecx+8], eax
                   jnz @notequal_sse
                   jmp @finishone_sse   }

             //  @notequal_sse:
                   movdqu xmm3, [edx]
                   movdqu xmm0, [ecx]
                   movlps xmm7, nAlpha64
                   movhps xmm7, nAlpha64
                   pcmpeqw xmm1, xmm0
                   psubusw xmm7, xmm1
                   // 调用Alpha混合
                   {$include SSE.inc}
                   movdqu [edx], xmm0
               //@finishone_sse:
                   add ecx, 16
                   add edx, 16
                   sub k, 8
                   mov integer ptr[pSrc],ecx
                   mov integer ptr[pDst],edx
                end;
              end;
            end;

            for nX := 0 to nMMXW - 1 do begin
              asm
                 mov edx, pDst		// edx = 目的指针
                 mov ecx, pSrc		// ecx = 源指针
                 movq mm1, nCol64
                 movd eax, mm1
                 cmp [ecx], eax
                 jnz @notequal
                 cmp[ecx + 4], eax
                 jnz @notequal
                 jmp @finishone
             @notequal:
                 movq mm3, [edx]
                 movq mm0, [ecx]
                 movq mm7, nAlpha64
                 pcmpeqw mm1, mm0
                 psubusw mm7, mm1
                 {$INCLUDE MMX.inc}
                 movq[edx], mm0
             @finishone:
                 add ecx, 8
                 add edx, 8
                 sub k, 4
                 mov integer ptr[pSrc],ecx
                 mov integer ptr[pDst],edx
              end;
            end;

            asm
               emms
            end;

            for nX := 0 to k - 1 do begin //剩余处理
              if PWord(pSrc)^ <> wColor then begin
                r := PWord(pSrc)^ and $F800 shr 8;
                G := PWord(pSrc)^ and $07E0 shr 3;
                b := PWord(pSrc)^ and $001F shl 3;

                dr := PWord(pDst)^ and $F800 shr 8;
                dg := PWord(pDst)^ and $07E0 shr 3;
                db := PWord(pDst)^ and $001F shl 3;

                r := (r * (Alpha) + dr * (256 - Alpha)) shr 8;
                G := (G * (Alpha) + dg * (256 - Alpha)) shr 8;
                b := (b * (Alpha) + db * (256 - Alpha)) shr 8;

                PWord(pDst)^ := (r shl 8 and $F800) or (G shl 3 and $07E0) or (b shr 3 and $001F);
              end;
              Inc(pSrc, 2);
              Inc(pDst, 2);
            end;
          end;

        end else begin
          nSLeft := SrcRect.Left * 2;
          nDLeft := DestRect.Left * 2;
          k := nWidth mod 4;

          if IsSSE then begin
            nSSEM := nWidth mod 8;
            nSSEW := nWidth div 8;
          end else begin
            nSSEM := 0;
            nSSEW := 0;
          end;

          if nSSEW > 0 then begin
            nMMXM := nSSEM mod 4;
            nMMXW := nSSEM div 4;
          end else begin
            nMMXM := nWidth mod 4;
            nMMXW := nWidth div 4;
          end;

          for nY := 0 to nHeight - 1 do begin
            pSrc := PByte(Integer(Source.PBits) + (SrcRect.Top + nY) * Source.Pitch + nSLeft);
            pDst := PByte(Integer(PBits) + (DestRect.Top + nY) * Pitch + nDLeft);
            k := nWidth;

            if IsSSE then begin
              for nX := 0 to nSSEW - 1 do begin
                asm
                mov edx, pDst		// edi = 目的指针
                mov ecx, pSrc		// esi = 源指针

                movlps xmm7, nAlpha64
                movhps xmm7, nAlpha64

                movdqu xmm3, [edx]
                movdqu xmm0, [ecx]

                {$include SSE.inc}

                add ecx, 16
                movdqu [edx], xmm0
                add edx, 16
                sub k, 8
                mov integer ptr[pSrc],ecx
                mov integer ptr[pDst],edx
                end;
              end;
            end;

            for nX := 0 to nMMXW - 1 do begin
              asm
                mov edx, pDst		// edi = 目的指针
                mov ecx, pSrc		// esi = 源指针

                movq mm7, nAlpha64		// 透明度
                movq mm3, [edx]
                movq mm0, [ecx]

                {$include MMX.inc}

                add ecx, 8
                movq [edx], mm0
                add edx, 8
                sub k, 4
                mov integer ptr[pSrc],ecx
                mov integer ptr[pDst],edx
              end;
            end;

            asm
               emms
            end;

            for nX := 0 to k - 1 do begin //剩余处理
              r := PWord(pSrc)^ and $F800 shr 8;
              G := PWord(pSrc)^ and $07E0 shr 3;
              b := PWord(pSrc)^ and $001F shl 3;

              dr := PWord(pDst)^ and $F800 shr 8;
              dg := PWord(pDst)^ and $07E0 shr 3;
              db := PWord(pDst)^ and $001F shl 3;

              r := (r * (Alpha) + dr * (256 - Alpha)) shr 8;
              G := (G * (Alpha) + dg * (256 - Alpha)) shr 8;
              b := (b * (Alpha) + db * (256 - Alpha)) shr 8;

              PWord(pDst)^ := (r shl 8 and $F800) or (G shl 3 and $07E0) or (b shr 3 and $001F);

              Inc(pSrc, 2);
              Inc(pDst, 2);
            end;
          end;

        end;
      end else begin
        Draw(DestRect.Left, DestRect.Top, SrcRect, Source, TRANSPARENT);
      end;
    end;
  end;
end;

procedure TTexture.FastDrawAlpha(const Dest, Src: TRect; Source: TTexture; TRANSPARENT: Boolean);
var
  DestRect, SrcRect: TRect;
  pSrc, pDst: PByte;
  nWidth: Integer;
  nHeight: Integer;
  j, k, L: Integer;
  nX, nY: Integer;
  nCol64: Int64;
  wColor: Word;
  Mask: Int64;
  wSP, wDP: Word;
  //nSPitch, nDPitch: Integer;
  r, G, b: byte;
  nSLeft: Integer;
  nDLeft: Integer;

  nMMXM: Integer;
  nSSEM: Integer;
  nMMXW: Integer;
  nSSEW: Integer;
begin
  if Source <> nil then
  begin
    DestRect := Dest;
    SrcRect := Src;
    //nSPitch := Source.Pitch;
    //nDPitch := Pitch;
    if ClipRect2(DestRect, SrcRect, ClientRect, Source.ClientRect) then
    begin
      Mask := $7BEF7BEF7BEF7BEF;
      nWidth := SrcRect.Right - SrcRect.Left;
      nHeight := SrcRect.Bottom - SrcRect.Top;
      if TRANSPARENT then begin
        wColor := RGB16(Source.TransparentColor);
        nCol64 := Bit16To64(wColor);
        nSLeft := SrcRect.Left * 2;
        nDLeft := DestRect.Left * 2;
        k := nWidth mod 4;

        if IsSSE then begin
          nSSEM := nWidth mod 8;
          nSSEW := nWidth div 8;
        end else begin
          nSSEM := 0;
          nSSEW := 0;
        end;

        if nSSEW > 0 then begin
          nMMXM := nSSEM mod 4;
          nMMXW := nSSEM div 4;
        end else begin
          nMMXM := nWidth mod 4;
          nMMXW := nWidth div 4;
        end;

        for nY := 0 to nHeight - 1 do begin
          pSrc := PByte(Integer(Source.PBits) + (SrcRect.Top + nY) * Source.Pitch + nSLeft);
          pDst := PByte(Integer(PBits) + (DestRect.Top + nY) * Pitch + nDLeft);
          k := nWidth;

          if IsSSE then begin
            for nX := 0 to nSSEW - 1 do begin
              asm
               mov ecx, pDst
               mov eax, pSrc

               movlps xmm6, nCol64
               movhps xmm6, nCol64
               movlps xmm7, mask
               movhps xmm7, mask

               movdqu xmm0, [eax]
               movdqu xmm1, [ecx]
               movdqu xmm5, xmm0
               movdqu xmm2, xmm1
               pcmpeqw xmm5, xmm6	// xmm5为透明掩码
               psrlq xmm2, 1
               psrlq xmm0, 1
               pand xmm2, xmm7
               pand xmm0, xmm7
               paddw xmm2, xmm0		// xmm2为混合结果
               pand xmm1, xmm5		// 目的数据非透明点置0
               psubusw xmm2, xmm5	// 混合结果透明点置0
               por xmm1, xmm2		// 相或得最终结果
               movdqu [ecx], xmm1

               add eax, 16
               add ecx, 16
               sub k, 8
               mov integer ptr[pSrc],eax
               mov integer ptr[pDst],ecx
              end;
            end;
          end;

          for nX := 0 to nMMXW - 1 do begin
            asm
               mov ecx, pDst
               mov eax, pSrc
               movq mm6, nCol64
               movq mm7, mask
               movlps xmm6, nCol64
               movhps xmm6, nCol64
               movlps xmm7, mask
               movhps xmm7, mask
               movd   edx, mm6

               cmp [eax], edx
               jnz @notequal
               cmp [eax+4], edx
               jnz @notequal
               jmp @finishone
            @notequal:
               movq mm0, [eax]
               movq mm1, [ecx]
               movq mm5, mm0
               movq mm2, mm1
               pcmpeqw mm5, mm6	// mm5为透明掩码
               psrlq mm2, 1
               psrlq mm0, 1
               pand mm2, mm7
               pand mm0, mm7
               paddw mm2, mm0		// mm2为混合结果
               pand mm1, mm5		// 目的数据非透明点置0
               psubusw mm2, mm5	// 混合结果透明点置0
               por mm1, mm2		// 相或得最终结果
               movq [ecx], mm1
            @finishone:
               add eax, 8
               add ecx, 8
               sub k,   4
               mov integer ptr[pSrc],eax
               mov integer ptr[pDst],ecx
            end;
          end;

          asm
             emms
          end;

          for nX := 0 to k - 1 do begin //剩余处理
            if wColor <> PWord(pSrc)^ then begin
              wSP := PWord(pSrc)^ shr 1 and $7BEF;
              wDP := PWord(pDst)^ shr 1 and $7BEF;
              r := (wSP shr 11) + (wDP shr 11);
              G := (wSP shr 5 and $3F) + (wDP shr 5 and $3F);
              b := (wSP and $1F) + (wDP and $1F);
              PWord(pDst)^ := (r shl 11) or (G shl 5) or b;
            end;
            Inc(pSrc, 2);
            Inc(pDst, 2);
          end;
        end;
      end else begin
        nSLeft := SrcRect.Left * 2;
        nDLeft := DestRect.Left * 2;
        k := nWidth mod 4;

        if IsSSE then begin
          nSSEM := nWidth mod 8;
          nSSEW := nWidth div 8;
        end else begin
          nSSEM := 0;
          nSSEW := 0;
        end;

        if nSSEW > 0 then begin
          nMMXM := nSSEM mod 4;
          nMMXW := nSSEM div 4;
        end else begin
          nMMXM := nWidth mod 4;
          nMMXW := nWidth div 4;
        end;

        for nY := 0 to nHeight - 1 do begin
          pSrc := PByte(Integer(Source.PBits) + (SrcRect.Top + nY) * Source.Pitch + nSLeft);
          pDst := PByte(Integer(PBits) + (DestRect.Top + nY) * Pitch + nDLeft);
          k := nWidth;
          if IsSSE then begin
            for nX := 0 to nSSEW - 1 do begin
              asm
               mov edx, pDst		// edi = 目的指针
               mov ecx, pSrc		// esi = 源指针
               movlps xmm7, mask
               movhps xmm7, mask

               movdqu xmm0, [ecx]		// 取源数据到mm0
               movdqu xmm1, [edx]		// 取目的数据到mm1
               psrlq xmm0, 1		// src? = 0rrrrrggggggbbbb
               psrlq xmm1, 1		// dst? = 0rrrrrggggggbbbb
               pand xmm0, xmm7		// src? = 0rrrr0ggggg0bbbb
               pand xmm1, xmm7		// dst? = 0rrrr0ggggg0bbbb
               paddw xmm0, xmm1		// result? = rrrrrggggggbbbbb
               add ecx, 16
               movdqu [edx], xmm0		// 写回目的地址
               add edx, 16
               sub k, 8
               mov integer ptr[pSrc],ecx
               mov integer ptr[pDst],edx
              end;
            end;
          end;

          for nX := 0 to nMMXW - 1 do begin
            asm
               mov edx, pDst		// edi = 目的指针
               mov ecx, pSrc		// esi = 源指针
               movq mm7, mask		// 64位掩码
               movq mm0, [ecx]		// 取源数据到mm0
               movq mm1, [edx]		// 取目的数据到mm1
               psrlq mm0, 1		// src? = 0rrrrrggggggbbbb
               psrlq mm1, 1		// dst? = 0rrrrrggggggbbbb
               pand mm0, mm7		// src? = 0rrrr0ggggg0bbbb
               pand mm1, mm7		// dst? = 0rrrr0ggggg0bbbb
               paddw mm0, mm1		// result? = rrrrrggggggbbbbb
               add ecx, 8
               movq [edx], mm0		// 写回目的地址
               add edx, 8
               sub k, 4
               mov integer ptr[pSrc],ecx
               mov integer ptr[pDst],edx
            end;
          end;

          asm
             emms
          end;

          for nX := 0 to k - 1 do begin //剩余处理
            wSP := PWord(pSrc)^ shr 1 and $7BEF;
            wDP := PWord(pDst)^ shr 1 and $7BEF;
            r := (wSP shr 11) + (wDP shr 11);
            G := (wSP shr 5 and $3F) + (wDP shr 5 and $3F);
            b := (wSP and $1F) + (wDP and $1F);
            PWord(pDst)^ := (r shl 11) or (G shl 5) or b;

            Inc(pSrc, 2);
            Inc(pDst, 2);
          end;
        end;
 // 算法: 将颜色值全部右移一位, 再与掩码做且运算, 则三色分量均除以2
 // 源数据和目的数据均做上述操作, 再相加即实现半透明
      end;
    end;
  end;
end;

procedure TTexture.StretchDraw(const Dest, Src: TRect; Source: TTexture;
  TRANSPARENT: Boolean);
var
  DIB: TTexture;

  DestRect, SrcRect: TRect;

  pSrc, pDst: PByte;
  nWidth: Integer;
  nHeight: Integer;

  nSLeft: Integer;
  nDLeft: Integer;

  nX, nY: Integer;

  xrIntFloat_16: Integer;
  yrIntFloat_16: Integer;

  srcx_16: Integer;
  srcy_16: Integer;
begin
  if Source <> nil then begin
    DestRect := Dest;
    SrcRect := Src;

    if ClipRect2(DestRect, SrcRect, ClientRect, Source.ClientRect) then begin
      nWidth := DestRect.Right - DestRect.Left;
      nHeight := DestRect.Bottom - DestRect.Top;

      srcy_16 := 0;
      xrIntFloat_16 := ((SrcRect.Right - SrcRect.Left) shl 16) div nWidth + 1;
      yrIntFloat_16 := ((SrcRect.Bottom - SrcRect.Top) shl 16) div nHeight + 1;

      nSLeft := SrcRect.Left * 2;
      nDLeft := DestRect.Left * 2;

      if TRANSPARENT then begin
        DIB := TTexture.Create;
        DIB.SetSize(Width, Height);
        for nY := 0 to nHeight - 1 do begin
          pSrc := PByte(Integer(Source.PBits) + SrcRect.Top * Source.Pitch + Source.Pitch * (srcy_16 shr 16) + nSLeft);
          pDst := PByte(Integer(DIB.PBits) + (DestRect.Top + nY) * DIB.Pitch + nDLeft);
          srcx_16 := 0;
          for nX := 0 to nWidth - 1 do begin
            PWordArray(pDst)[nX] := PWordArray(pSrc)[srcx_16 shr 16];
            Inc(srcx_16, xrIntFloat_16);
          end;
          Inc(srcy_16, yrIntFloat_16);
        end;
        Self.Draw(DestRect.Left, DestRect.Top, DestRect, DIB);

        DIB.Free;

      end else begin

        for nY := 0 to nHeight - 1 do begin
          pSrc := PByte(Integer(Source.PBits) + SrcRect.Top * Source.Pitch + Source.Pitch * (srcy_16 shr 16) + nSLeft);
          pDst := PByte(Integer(PBits) + (DestRect.Top + nY) * Pitch + nDLeft);
          srcx_16 := 0;
          for nX := 0 to nWidth - 1 do begin
            PWordArray(pDst)[nX] := PWordArray(pSrc)[srcx_16 shr 16];
            Inc(srcx_16, xrIntFloat_16);
          end;
          Inc(srcy_16, yrIntFloat_16);
        end;
      end;
    end;
  end;
end;

procedure TTexture.StretchDraw(const Dest: TRect; Source: TTexture;
  TRANSPARENT: Boolean);
var
  DIB: TTexture;

  DestRect, SrcRect: TRect;
  pSrc, pDst: PByte;
  SrcP, DstP: PWord;

  nWidth: Integer;
  nHeight: Integer;

  nX, nY: Integer;

  nLeft: Integer;

  xrIntFloat_16: Integer;
  yrIntFloat_16: Integer;

  srcx_16: Integer;
  srcy_16: Integer;
begin
  if Source <> nil then begin
    if (Source.Width = (Dest.Right - Dest.Left)) and
      (Source.Height = (Dest.Bottom - Dest.Top)) then begin
      Self.Draw(Dest.Left, Dest.Top, Source, TRANSPARENT);
    end else begin
      DestRect := Dest;
      SrcRect := Source.ClientRect;
      if ClipRect(DestRect, ClientRect) then begin
        nWidth := DestRect.Right - DestRect.Left;
        nHeight := DestRect.Bottom - DestRect.Top;
        if TRANSPARENT then begin
          DIB := TTexture.Create;
          DIB.SetSize(Width, Height);

          srcy_16 := 0;
          xrIntFloat_16 := (Source.Width shl 16) div nWidth + 1;
          yrIntFloat_16 := (Source.Height shl 16) div nHeight + 1;

          for nY := 0 to nHeight - 1 do begin
            pSrc := PByte(Integer(Source.PBits) + Source.Pitch * (srcy_16 shr 16));
            pDst := PByte(Integer(DIB.PBits) + nY * DIB.Pitch);
            srcx_16 := 0;
            for nX := 0 to nWidth - 1 do begin
              PWordArray(pDst)[nX] := PWordArray(pSrc)[srcx_16 shr 16];
              Inc(srcx_16, xrIntFloat_16);
            end;
            Inc(srcy_16, yrIntFloat_16);
          end;
          Self.Draw(DestRect.Left, DestRect.Top, DestRect, DIB);
          DIB.Free;
        end else begin
          nLeft := DestRect.Left * 2;
          srcy_16 := 0;

          xrIntFloat_16 := (Source.Width shl 16) div nWidth + 1;
          yrIntFloat_16 := (Source.Height shl 16) div nHeight + 1;

          for nY := 0 to nHeight - 1 do begin
            pSrc := PByte(Integer(Source.PBits) + Source.Pitch * (srcy_16 shr 16));
            pDst := PByte(Integer(PBits) + (DestRect.Top + nY) * Pitch + nLeft);
            srcx_16 := 0;
            for nX := 0 to nWidth - 1 do begin
              PWordArray(pDst)[nX] := PWordArray(pSrc)[srcx_16 shr 16];
              Inc(srcx_16, xrIntFloat_16);
            end;
            Inc(srcy_16, yrIntFloat_16);
          end;
        end;
      end;
    end;
  end;
end;

procedure TTexture.Side(Source, MarkColor: TColor);
begin

end;

procedure TTexture.Noise(Color: TColor);
var
  pDst: PByte;
  wColor: Word;
  wSrcColor: Word;
  C1, C2, C3, C4, C5: PWord;
  I, II, Amount, nCount, X, Y: Integer;
begin
  nCount := 0;
  Amount := Width * Height div 3;
  wColor := RGB16(Color);
  wSrcColor := PWord(Integer(FPBits))^;
  while nCount < Amount do begin
    Y := Random(Height - 1);
    X := Random(Width - 1);
    C1 := PWord(Integer(FPBits) + Y * Pitch + X * 2);
    if (C1^ = wSrcColor) then begin
      C1^ := wColor;
    end;
    Inc(nCount);
  end;
end;

procedure TTexture.Fill(DevColor: TColor);
var
  pDst: PByte;
  nX, nY, k: Integer;
  nWidth: Integer;
  nHeight: Integer;

  maskkey: Int64;
  wColor: Word;

  nMMXM: Integer;
  nSSEM: Integer;
  nMMXW: Integer;
  nSSEW: Integer;
begin
  pDst := PByte(Integer(PBits));
  nWidth := Width;
  nHeight := Height;
  wColor := RGB16(DevColor);
  maskkey := Bit16To64(wColor);

  k := nWidth mod 4;

  if IsSSE then begin
    nSSEM := nWidth mod 8;
    nSSEW := nWidth div 8;
  end else begin
    nSSEM := 0;
    nSSEW := 0;
  end;

  if nSSEW > 0 then begin
    nMMXM := nSSEM mod 4;
    nMMXW := nSSEM div 4;
  end else begin
    nMMXM := nWidth mod 4;
    nMMXW := nWidth div 4;
  end;

  for nY := 0 to nHeight - 1 do begin
    pDst := PByte(Integer(PBits) + nY * Pitch);
    k := nWidth;

    if IsSSE then begin
      for nX := 0 to nSSEW - 1 do begin
        asm
           mov     edx,  pDst		// edx = 目的指针
           movlps xmm0, maskkey
           movhps xmm0, maskkey
           movdqu  [edx],xmm0		// 直接写入目的地址
           add     edx,  16
           sub     k,   8
           mov     integer ptr[pDst], edx
        end;
      end;
    end;

    for nX := 0 to nMMXW - 1 do begin
      asm
         mov     edx,  pDst		// edx = 目的指针
         movq    mm0,  maskkey		// 从源地址取4象素数据
         movq    [edx],mm0		// 直接写入目的地址
         add     edx,  8
         sub     k,   4
         mov     integer ptr[pDst], edx
      end;
    end;

    asm
       emms
    end;

    for nX := 0 to k - 1 do begin //剩余处理
      PWord(pDst)^ := wColor;
      Inc(pDst, 2);
    end;
  end;
end;

procedure TTexture.FillRect(const Rect: TRect; DevColor: TColor);
var
  DestRect: TRect;
  pDst: PByte;
  nX, nY, k: Integer;
  nWidth: Integer;
  nHeight: Integer;
  nLeft: Integer;
  maskkey: Int64;
  wColor: Word;

  nMMXM: Integer;
  nSSEM: Integer;
  nMMXW: Integer;
  nSSEW: Integer;
begin
  DestRect := Rect;
  if ClipRect(DestRect, ClientRect) then begin
    pDst := PByte(Integer(PBits) + Pitch * DestRect.Top + DestRect.Left * 2);
    nWidth := DestRect.Right - DestRect.Left;
    nHeight := DestRect.Bottom - DestRect.Top;
    wColor := RGB16(DevColor);
    maskkey := Bit16To64(wColor);
    nLeft := DestRect.Left * 2;
    k := nWidth mod 4;

    if IsSSE then begin
      nSSEM := nWidth mod 8;
      nSSEW := nWidth div 8;
    end else begin
      nSSEM := 0;
      nSSEW := 0;
    end;

    if nSSEW > 0 then begin
      nMMXM := nSSEM mod 4;
      nMMXW := nSSEM div 4;
    end else begin
      nMMXM := nWidth mod 4;
      nMMXW := nWidth div 4;
    end;

    for nY := 0 to nHeight - 1 do begin
      pDst := PByte(Integer(PBits) + (DestRect.Top + nY) * Pitch + nLeft);
      k := nWidth;

      if IsSSE then begin
        for nX := 0 to nSSEW - 1 do begin
          asm
             mov     edx,  pDst		// edx = 目的指针
             movlps xmm0, maskkey
             movhps xmm0, maskkey
             movdqu  [edx],xmm0		// 直接写入目的地址
             add     edx,  16
             sub     k,   8
             mov     integer ptr[pDst], edx
          end;
        end;
      end;

      for nX := 0 to nMMXW - 1 do begin
        asm
           mov     edx,  pDst		// edx = 目的指针
           movq    mm0,  maskkey		// 从源地址取4象素数据
           movq    [edx],mm0		// 直接写入目的地址
           add     edx,  8
           sub     k,   4
           mov     integer ptr[pDst], edx
        end;
      end;

      asm
         emms
      end;

      for nX := 0 to k - 1 do begin //剩余处理
        PWord(pDst)^ := wColor;
        Inc(pDst, 2);
      end;
    end;
  end;
end;

procedure TTexture.FillRectAlpha(const Rect: TRect; Color: TColor; Alpha: Integer);
var
  DestRect: TRect;
  nX, nY: Integer;
  pSrc, pDst: PByte;
  nWidth: Integer;
  nHeight: Integer;
  nLeft: Integer;
  nCol64: Int64;
  nAlpha64: Int64;
  wColor: Word;
  j, k, L: Integer;
  r, G, b, dr, dg, db: byte;
  nMMXM: Integer;
  nSSEM: Integer;
  nMMXW: Integer;
  nSSEW: Integer;
begin
  DestRect := Rect;
  if ClipRect(DestRect, ClientRect) then begin
    if (Alpha < 0) or (Alpha > 256) then begin
      FillRect(Rect, Color);
    end else begin
      wColor := RGB16(Color);
      nCol64 := Bit16To64(wColor);
      nAlpha64 := Bit16To64(Alpha shr 3);
      nWidth := DestRect.Right - DestRect.Left;
      nHeight := DestRect.Bottom - DestRect.Top;
      pSrc := PByte(@nCol64);
      k := nWidth mod 4;
      nLeft := DestRect.Left * 2;

      if IsSSE then begin
        nSSEM := nWidth mod 8;
        nSSEW := nWidth div 8;
      end else begin
        nSSEM := 0;
        nSSEW := 0;
      end;

      if nSSEW > 0 then begin
        nMMXM := nSSEM mod 4;
        nMMXW := nSSEM div 4;
      end else begin
        nMMXM := nWidth mod 4;
        nMMXW := nWidth div 4;
      end;

      for nY := 0 to nHeight - 1 do begin
        pDst := PByte(Integer(PBits) + (DestRect.Top + nY) * Pitch + nLeft);
        k := nWidth;

        if IsSSE then begin
          for nX := 0 to nSSEW - 1 do begin
            asm
               mov edx, pDst		// edi = 目的指针
               mov ecx, pSrc		// esi = 源指针
               movlps xmm7, nAlpha64
               movhps xmm7, nAlpha64
               movlps xmm0, nCol64
               movhps xmm0, nCol64
               movdqu xmm3, [edx]

               {$include SSE.inc}

               movdqu[edx], xmm0
               add edx, 16
               sub k, 8
               mov Integer ptr[pDst], edx
            end;
          end;
        end;

        for nX := 0 to nMMXW - 1 do begin
          asm
             mov edx, pDst		// edi = 目的指针
             mov ecx, pSrc		// esi = 源指针
             movq mm7, nAlpha64		// 透明度
             movq mm3, [edx]
             movq mm0, [ecx]

             {$INCLUDE MMX.inc}

             movq[edx], mm0
             add edx, 8
             sub k, 4
             mov Integer ptr[pDst], edx
          end;
        end;

        asm
           emms
        end;

        for nX := 0 to k - 1 do begin //剩余处理
          r := wColor and $F800 shr 8;
          G := wColor and $07E0 shr 3;
          b := wColor and $001F shl 3;

          dr := PWord(pDst)^ and $F800 shr 8;
          dg := PWord(pDst)^ and $07E0 shr 3;
          db := PWord(pDst)^ and $001F shl 3;

          r := (r * (Alpha) + dr * (256 - Alpha)) shr 8;
          G := (G * (Alpha) + dg * (256 - Alpha)) shr 8;
          b := (b * (Alpha) + db * (256 - Alpha)) shr 8;

          PWord(pDst)^ := (r shl 8 and $F800) or (G shl 3 and $07E0) or (b shr 3 and $001F);

          Inc(pDst, 2);
        end;
      end;
    end;
  end;
end;

procedure TTexture.FrameRect(const Rect: TRect; DevColor: TColor);
var
  DestRect: TRect;
  DRect: TRect;
begin
  DestRect := Rect;
  if ClipRect(DestRect, ClientRect) then begin
    DRect := DestRect;
    DRect.Bottom := DRect.Top + 1;
    FillRect(DRect, DevColor);

    DRect := DestRect;
    DRect.Top := DRect.Bottom - 1;
    FillRect(DRect, DevColor);

    DRect := DestRect;
    DRect.Right := DRect.Left + 1;
    FillRect(DRect, DevColor);

    DRect := DestRect;
    DRect.Left := DRect.Right - 1;
    FillRect(DRect, DevColor);
  end;
end;

procedure TTexture.Line(X1, Y1, X2, Y2: Integer; DevColor: TColor);
var
  d, ax, ay, sx, sy, dx, dy: Integer;
  C: Word;
begin
  C := RGB16(DevColor);
  dx := X2 - X1;
  ax := Abs(dx) shl 1;
  if dx < 0 then
    sx := -1
  else
    sx := 1;
  dy := Y2 - Y1;
  ay := Abs(dy) shl 1;
  if dy < 0 then
    sy := -1
  else
    sy := 1;
  Pixels16[X1, Y1] := C;
  if ax > ay then
  begin
    d := ay - (ax shr 1);
    while X1 <> X2 do
    begin
      if d > -1 then
      begin
        Inc(Y1, sy);
        Dec(d, ax);
      end;
      Inc(X1, sx);
      Inc(d, ay);
      Pixels16[X1, Y1] := C;
    end;
  end
  else
  begin
    d := ax - (ay shr 1);
    while Y1 <> Y2 do
    begin
      if d >= 0 then
      begin
        Inc(X1, sx);
        Dec(d, ay);
      end;
      Inc(Y1, sy);
      Inc(d, ax);
      Pixels16[X1, Y1] := C;
    end;
  end;
end;

procedure TTexture.DrawSurface(SrcR, DestR: TRect;
  DestP: PByte; DestPitch, BitCount: Integer);
var
  SrcRect, DestRect: TRect;
  nX, nY: Integer;
  pSrc, pDst: PByte;
  nWidth: Integer;
  nHeight: Integer;
  nDPitch: Integer;
  nSPitch: Integer;
  j, k, L: Integer;
  RGBQuad: PRGBQuad;
  RGBTriple: PRGBTriple;
  nLeft, nBitCount: Integer;

  nMMXM: Integer;
  nSSEM: Integer;
  nMMXW: Integer;
  nSSEW: Integer;
begin
  SrcRect := SrcR;
  DestRect := DestR;
  if ClipRect(DestRect, DestR) and ClipRect(SrcRect, ClientRect) then begin

    nWidth := Min(SrcRect.Right - SrcRect.Left, DestRect.Right - DestRect.Left);
    nHeight := Min(SrcRect.Bottom - SrcRect.Top, DestRect.Bottom - DestRect.Top);

    with SrcRect do begin
      Right := Left + nWidth;
      Bottom := Top + nHeight;
    end;

    with DestRect do begin
      Right := Left + nWidth;
      Bottom := Top + nHeight;
    end;

    if ClipRect(DestRect, DestRect) and ClipRect(SrcRect, SrcRect) then begin
      case BitCount of
        16: begin
            nLeft := SrcRect.Left * 2;
            nBitCount := BitCount div 8;
            nWidth := nWidth * 2;
            for nY := 0 to nHeight - 1 do begin
              pSrc := PByte(Integer(PBits) + (SrcRect.Top + nY) * Pitch + nLeft);
              pDst := PByte(Integer(DestP) + (DestRect.Top + nY) * DestPitch + DestRect.Left * nBitCount);
              Move(pSrc^, pDst^, nWidth);
            end;
          end;
        24: begin
            nLeft := SrcRect.Left * 2;
            nBitCount := BitCount div 8;
            nWidth := nWidth * 2;
            for nY := 0 to nHeight - 1 do begin
              pSrc := PByte(Integer(PBits) + (SrcRect.Top + nY) * Pitch + nLeft);
              pDst := PByte(Integer(DestP) + (DestRect.Top + nY) * DestPitch + DestRect.Left * nBitCount);
              for nX := 0 to nWidth - 1 do begin
                RGBTriple := PRGBTriple(pDst);
                RGBTriple.rgbtRed := PWord(pSrc)^ and $F800 shr 8;
                RGBTriple.rgbtGreen := PWord(pSrc)^ and $07E0 shr 3;
                RGBTriple.rgbtBlue := PWord(pSrc)^ and $001F shl 3;
                Inc(pSrc, 2);
                Inc(pDst, 3);
              end;
            end;
          end;
        32: begin //16转32 MMX优化
            k := nWidth mod 4;
            nLeft := SrcRect.Left * 2;
            nBitCount := BitCount div 8;

            if IsSSE then begin
              nSSEM := nWidth mod 8;
              nSSEW := nWidth div 8;
            end else begin
              nSSEM := 0;
              nSSEW := 0;
            end;

            if nSSEW > 0 then begin
              nMMXM := nSSEM mod 4;
              nMMXW := nSSEM div 4;
            end else begin
              nMMXM := nWidth mod 4;
              nMMXW := nWidth div 4;
            end;

            for nY := 0 to nHeight - 1 do begin
              pSrc := PByte(Integer(PBits) + (SrcRect.Top + nY) * Pitch + nLeft);
              pDst := PByte(Integer(DestP) + (DestRect.Top + nY) * DestPitch + DestRect.Left * nBitCount);

              k := nWidth;

              if IsSSE then begin
                for nX := 0 to nSSEW - 1 do begin
                  asm
                   mov     edx,  pDst		// edx = 目的指针
                   mov     ecx,  pSrc		// ecx = 源指针

                   movlps xmm4, mask_r
                   movhps xmm4, mask_r

                   movlps xmm5, mask_g
                   movhps xmm5, mask_g

                   movlps xmm6, mask_b
                   movhps xmm6, mask_b

                   movdqu xmm0, [ecx]
                   movdqu xmm7, xmm0				// save src 4 X 16bit color data

                   pand xmm0, xmm4				// & r mask   r := pSrc^ and $F800
                   psrlw xmm0, 8				// >> 8       r := r shr 8;

                   movdqu xmm1, xmm7				// restore mm1 data

                   pand xmm1, xmm5				// & g mask   g := pSrc^ and $07E0;
                   psrlw xmm1, 3				// >> 3       g := g shr 3;
                   movdqu xmm2, xmm7				// restore mm1 data

                   pand xmm2, xmm6				// & b mask   b := pSrc^ and $001F;
                   psllw xmm2, 3				// << 3       b := b shl 3;

                   psllq xmm1, 8				// << 8       g := g shl 8;

                   por xmm1, xmm2				// 4 pixel b\g  g := g or b;
                   movdqu xmm7, xmm1				// save mm1

                   punpcklwd xmm1, xmm0
                   movdqu [edx], xmm1
                   add	edx, 16					// write 4 X 32bit

                   movdqu xmm1, xmm7

                   punpckhwd xmm1, xmm0
                   movdqu [edx], xmm1

                   add	ecx, 16					// read 4 X 16bit
                   add	edx, 16					// write 4 X 32bit

                   sub     k,   8
                   mov     integer ptr[pSrc], ecx
                   mov     integer ptr[pDst], edx
                  end;
                end;
              end;

              for nX := 0 to nMMXW - 1 do begin
                asm
                   mov     edx,  pDst		// edx = 目的指针
                   mov     ecx,  pSrc		// ecx = 源指针

                   movq mm4, mask_r
                   movq mm5, mask_g
                   movq mm6, mask_b

                   movq mm0, [ecx]
                   movq mm7, mm0				// save src 4 X 16bit color data

                   pand mm0, mm4				// & r mask   r := pSrc^ and $F800
                   psrlw mm0, 8				// >> 8       r := r shr 8;

                   movq mm1, mm7				// restore mm1 data

                   pand mm1, mm5				// & g mask   g := pSrc^ and $07E0;
                   psrlw mm1, 3				// >> 3       g := g shr 3;
                   movq mm2, mm7				// restore mm1 data

                   pand mm2, mm6				// & b mask   b := pSrc^ and $001F;
                   psllw mm2, 3				// << 3       b := b shl 3;

                   psllq mm1, 8				// << 8       g := g shl 8;

                   por mm1, mm2				// 4 pixel b\g  g := g or b;
                   movq mm7, mm1				// save mm1

                   punpcklwd mm1, mm0
                   movq [edx], mm1
                   add	edx, 8					// write 4 X 32bit

                   movq mm1, mm7

                   punpckhwd mm1, mm0
                   movq [edx], mm1

                   add	ecx, 8					// read 4 X 16bit
                   add	edx, 8					// write 4 X 32bit

                   sub     k,   4
                   mov     integer ptr[pSrc], ecx
                   mov     integer ptr[pDst], edx
                end;
              end;

              asm
                 emms
              end;
            //TextOutFile('k:' + IntToStr(k) + ' Width:' + IntToStr(nWidth) + ' nSSEW:' + IntToStr(nSSEW) + ' nMMXW:' + IntToStr(nMMXW));

              for nX := 1 to k do begin //剩余处理
                RGBQuad := PRGBQuad(pDst);
                RGBQuad.rgbRed := PWord(pSrc)^ and $F800 shr 8;
                RGBQuad.rgbGreen := PWord(pSrc)^ and $07E0 shr 3;
                RGBQuad.rgbBlue := PWord(pSrc)^ and $001F shl 3;
                RGBQuad.rgbReserved := 0;
                Inc(pSrc, 2);
                Inc(pDst, 4);
              end;
            end;

          end;
      end;
    end;
  end;
end;

function TTexture.TextWidth(const Text: string): Integer;
begin
  Result := ImageFont.TextWidth(Text);
end;

function TTexture.TextHeight(const Text: string): Integer;
begin
  Result := ImageFont.TextHeight(Text);
end;

procedure TTexture.TextRect(Rect: TRect;
  X, Y: Integer; const Text: string;
  FColor: TColor; BColor: TColor);
begin
  ImageFont.DrawRect(Self, Rect, X, Y, Text, FColor, BColor);
end;

procedure TTexture.TextOut(X, Y: Integer; const Text: string; FColor: TColor; Bcolor: TColor);
begin
  ImageFont.Draw(Self, X, Y, Text, FColor, BColor);
end;

procedure TTexture.BoldTextOut(X, Y: Integer; const Text: string; FColor: TColor; BColor: TColor);
begin
  ImageFont.BoldDraw(Self, X, Y, Text, FColor, BColor);
end;

procedure TTexture.BoldTextRect(Rect: TRect;
  X, Y: Integer; const Text: string;
  FColor: TColor; Bcolor: TColor);
begin
  ImageFont.BoldDrawRect(Self, Rect, X, Y, Text, FColor, BColor);
end;

{--------------------------------TTextureList--------------------------------}

constructor TTextureList.Create();
begin
  MainForm := nil;
  List := TList.Create;
end;

destructor TTextureList.Destroy;
begin
  while Count > 0 do
    Items[Count - 1].Free;

  List.Free;
  inherited Destroy;
end;

function TTextureList.GetCount: Integer;
begin
  Result := List.Count;
end;

function TTextureList.GetTexture(Index: Integer): TTexture;
begin
  Result := TTexture(List[Index]);
end;

{---------------------------------TTextureFontList----------------------------------}

constructor TImageFont.Create();
begin
  FreeOutTimeTick := GetTickCount;
  FreeFontTextOutTimeTick := GetTickCount;
  FontList := TList.Create;
  FontTextList := TList.Create;
end;

destructor TImageFont.Destroy;
begin
  Clear;
  FontList.Free;
  FontTextList.Free;
  inherited;
end;

procedure TImageFont.Clear;
var
  I: Integer;
  TextureFont: pTTextureFont;
  FontText: pTFontText;
begin
  for I := 0 to FontList.Count - 1 do begin
    TextureFont := FontList.Items[I];
    FreeMem(TextureFont.Data);
    Dispose(TextureFont);
  end;
  FontList.Clear;

  for I := 0 to FontTextList.Count - 1 do begin
    FontText := FontTextList.Items[I];
    FontText.Font.Free;
    Dispose(FontText);
  end;
  FontTextList.Clear;
end;

function TImageFont.GetCount: Integer;
begin
  Result := FontList.Count;
end;

procedure TImageFont.FreeOutTime;
var
  I: Integer;
  TextureFont: pTTextureFont;
  FontText: pTFontText;
begin
  if (GetTickCount - FreeOutTimeTick > 1000 * 30) then begin
    FreeOutTimeTick := GetTickCount;
    for I := FontList.Count - 1 downto 0 do begin
      TextureFont := FontList.Items[I];
      if (GetTickCount - TextureFont.Time > 1000 * 60 * 5) then begin
        FontList.Delete(I);
        FreeMem(TextureFont.Data);
        Dispose(TextureFont);
      end;
    end;
  end;
end;

procedure TImageFont.FreeFontTextOutTime;
var
  I: Integer;
  FontText: pTFontText;
begin
  if (GetTickCount - FreeFontTextOutTimeTick > 1000 * 30) then begin
    FreeFontTextOutTimeTick := GetTickCount;

    for I := FontTextList.Count - 1 downto 0 do begin
      FontText := FontTextList.Items[I];
      if (GetTickCount - FontText.Time > 1000 * 60 * 5) then begin
        FontTextList.Delete(I);
        FontText.Font.Free;
        Dispose(FontText);
      end;
    end;
  end;
end;

function TImageFont.TextWidth(const Text: string): Integer;
var
  tm: TEXTMETRIC;
  HHDC: hdc;
  tempDC: hdc;
  Point: Size;
begin
 // 创建兼容DC并选入字体          TextWidth(Text), DIB.TextHeight
  tempDC := GetDC(MainForm.Handle);
  HHDC := CreateCompatibleDC(tempDC);

  SelectObject(HHDC, MainForm.Canvas.Font.Handle);

  Windows.GetTextExtentPoint32(HHDC, PChar(Text), Length(Text), Point);
  Result := Point.cx;
  //nHeight := Point.cy;
  DeleteDC(HHDC);
  ReleaseDC(0, tempDC);
end;

function TImageFont.TextHeight(const Text: string): Integer;
var
  tm: TEXTMETRIC;
  HHDC: hdc;
  tempDC: hdc;
  Point: Size;
begin
 // 创建兼容DC并选入字体          TextWidth(Text), DIB.TextHeight
  tempDC := GetDC(MainForm.Handle);
  HHDC := CreateCompatibleDC(tempDC);

  SelectObject(HHDC, MainForm.Canvas.Font.Handle);

  Windows.GetTextExtentPoint32(HHDC, PChar(Text), Length(Text), Point);
  // Point.cx;
  Result := Point.cy;
  DeleteDC(HHDC);
  ReleaseDC(0, tempDC);
end;

function TImageFont.GetTextDIB(Text: string; FColor, Bcolor: TColor): TTexture;
var
  I: Integer;
  FontText: pTFontText;
  FontStyle: TFontStyles;
begin
  Result := nil;
  for I := 0 to FontTextList.Count - 1 do begin
    FontText := FontTextList.Items[I];
    if (CompareStr(FontText.Text, Text) = 0) and
      (CompareText(MainForm.Canvas.Font.Name, FontText.Name) = 0) and
      (MainForm.Canvas.Font.Size = FontText.Size) and
      (MainForm.Canvas.Font.Style = FontText.Style) and
      (FColor = FontText.FColor) and
      (BColor = FontText.BColor) then begin
      FontText.Time := GetTickCount;
      Result := FontText.Font;
      Exit;
    end;
  end;
  FreeFontTextOutTime;
end;

function TImageFont.GetTextData(Text: string): pTTextureFont;
var
  tm: TEXTMETRIC;
  BitmapInfo: TBitmapInfo;
  Data: Pointer;
  HHBitmap: HBitmap;
  HHDC: hdc;
  tempDC: hdc;
  Point: Size;
  nWidth, nHeight: Integer;
  I, II: Integer;
  DstP: PByte;
  RGBQuad: PRGBQuad;
  TextureFont: pTTextureFont;

  FontStyle: TFontStyles;
begin
  Result := nil;
  FontStyle := MainForm.Canvas.Font.Style;
  if fsUnderline in MainForm.Canvas.Font.Style then begin
    MainForm.Canvas.Font.Style := MainForm.Canvas.Font.Style - [fsUnderline];
  end;

  for I := 0 to FontList.Count - 1 do begin
    TextureFont := FontList.Items[I];
    if (CompareStr(TextureFont.Text, Text) = 0) and
      (CompareText(MainForm.Canvas.Font.Name, TextureFont.Name) = 0) and
      (MainForm.Canvas.Font.Size = TextureFont.Size) and (MainForm.Canvas.Font.Style = TextureFont.Style) then begin
      TextureFont.Time := GetTickCount;
      if fsUnderline in FontStyle then begin
        MainForm.Canvas.Font.Style := MainForm.Canvas.Font.Style + [fsUnderline];
      end;
      Result := TextureFont;
      Exit;
    end;
  end;

  FreeOutTime; //释放5分钟没有使用的数据

 // 创建兼容DC并选入字体


  tempDC := GetDC(MainForm.Handle);
  HHDC := CreateCompatibleDC(tempDC);

  SelectObject(HHDC, MainForm.Canvas.Font.Handle);

  Windows.GetTextExtentPoint32(HHDC, PChar(Text), Length(Text), Point);
  nWidth := Point.cx;
  nHeight := Point.cy;

  with BitmapInfo.bmiHeader do begin
  //位图信息头
    biSize := SizeOf(BitmapInfo.bmiHeader);
    biWidth := nWidth;
    biHeight := nHeight;
    biPlanes := 1;
    biBitCount := 32;
    biCompression := BI_RGB;
    biSizeImage := 0;
    biXPelsPerMeter := 0;
    biYPelsPerMeter := 0;
    biClrUsed := 0;
    biClrImportant := 0;
  end;

  //创建字符位图
  HHBitmap := CreateDIBSection(HHDC, BitmapInfo, DIB_RGB_COLORS, Data, 0, 0);
  SelectObject(HHDC, HHBitmap); //将字符位图选入DC
  SetTextColor(HHDC, RGB(255, 255, 255)); //设文字颜色为白色
  SetBkColor(HHDC, RGB(0, 0, 0)); //设背景颜色为黑色
  Windows.TextOut(HHDC, 0, 0, PChar(Text), Length(Text));

  New(Result);
  Result.Name := MainForm.Canvas.Font.Name;
  Result.Size := MainForm.Canvas.Font.Size;
  Result.Style := MainForm.Canvas.Font.Style;

  GetMem(Result.Data, nWidth * nHeight + 4);
  Result.Text := Text;
  Result.Width := nWidth;
  Result.Height := nHeight;
  Result.Time := GetTickCount;

  for I := nHeight - 1 downto 0 do begin //32位转换成8位的数据
    RGBQuad := PRGBQuad(Integer(Data) + (nHeight - 1 - I) * nWidth * 4);
    DstP := PByte(Integer(Result.Data) + I * nWidth);
    for II := 0 to nWidth - 1 do begin
      if not (Integer(RGBQuad^) = 0) then begin
        PByte(DstP)^ := 255;
      end else begin
        PByte(DstP)^ := 0;
      end;
      Inc(RGBQuad);
      Inc(DstP);
    end;
  end;

  DeleteObject(HHBitmap);
  DeleteDC(HHDC);
  ReleaseDC(0, tempDC);
  FontList.Add(Result);
  if fsUnderline in FontStyle then begin
    MainForm.Canvas.Font.Style := MainForm.Canvas.Font.Style + [fsUnderline];
  end;
end;

//8位字符点阵数据绘制到16位数据

procedure TImageFont.DrawFont(pSrc, pDst: PByte; nPitch, nWidth, nHeight: Integer; Color: TColor);
var
  nX, nY, I, k: Integer;
  SrcP: PByte;
  DstP: PWord;
  nCol64: Int64;
  wColor: Word;

  nSSEM, nSSEW: Integer;
  nMMXM, nMMXW: Integer;
begin
  wColor := RGB16(Color);
  nCol64 := Bit16To64(wColor);

  if IsSSE then begin
    nSSEM := nWidth mod 8;
    nSSEW := nWidth div 8;
  end else begin
    nSSEM := 0;
    nSSEW := 0;
  end;

  if nSSEW > 0 then begin
    nMMXM := nSSEM mod 4;
    nMMXW := nSSEM div 4;
  end else begin
    nMMXM := nWidth mod 4;
    nMMXW := nWidth div 4;
  end;

  for nY := 0 to nHeight - 1 do begin
    SrcP := PByte(Integer(pSrc) + nWidth * nY);
    DstP := PWord(Integer(pDst) + nPitch * nY);
    k := nWidth;

    if IsSSE then begin
      for nX := 0 to nSSEW - 1 do begin
        asm
           mov edx, DstP // edx = 目的指针
           mov ecx, SrcP // ecx = 字符点阵数据指针
           movdqu xmm0, [edx] // 目的颜色
           movq xmm7, [ecx] // mm7 = 8位字符点阵数据
           movlps xmm1, nCol64		// 64位颜色键
           movhps xmm1, nCol64		// 64位颜色键
           punpcklbw xmm7, xmm7 // 8位点阵数据扩展为128位

           pand xmm1, xmm7 // 不绘点的源颜色值清0
           psubusw xmm0, xmm7 // 待绘点的目的颜色清0
           por xmm0, xmm1 // 相或得结果颜色

           add ecx, 8
           movdqu [edx], xmm0 // 写入4个象素
           add edx, 16
           sub k, 8

           mov integer ptr[SrcP], ecx
           mov integer ptr[DstP], edx
        end;
      end;
    end;

    for nX := 0 to nMMXW - 1 do begin
      asm
         mov edx, DstP // edx = 目的指针
         mov ecx, SrcP // ecx = 字符点阵数据指针
         movq mm0, [edx] // 目的颜色
         movd mm7, [ecx] // mm7 = 8位字符点阵数据
         movq mm1, nCol64 // mm1 = 64位颜色值
         punpcklbw mm7, mm7 // 8位点阵数据扩展为16位

         pand mm1, mm7 // 不绘点的源颜色值清0
         psubusw mm0, mm7 // 待绘点的目的颜色清0
         por mm0, mm1 // 相或得结果颜色

         add ecx, 4
         movq [edx], mm0 // 写入4个象素
         add edx, 8
         sub k, 4

         mov integer ptr[SrcP], ecx
         mov integer ptr[DstP], edx
      end;
    end;

    asm
       emms
    end;
    for I := 0 to k - 1 do begin //剩余处理
      if SrcP^ <> 0 then DstP^ := wColor;
      Inc(SrcP);
      Inc(DstP);
    end;
  end;

end;

procedure TImageFont.DrawRect(DIB: TTexture;
  Rect: TRect; X, Y: Integer; const Text: string;
  FColor: TColor; BColor: TColor);
var
  I: Integer;
  S: string;
  sText: WideString;

  nX, nWidth, nHeight, nPitch: Integer;

  TextureFont: pTTextureFont;
  AChar: Char;

  SourceRect, SrcRect, DestRect, ClientRect: TRect;
  pSrc: PByte;
  pDst: PByte;
  SrcP: PByte;
  DstP: PByte;

  Source: TTexture;
  FontText: pTFontText;
begin
  if Text = '' then Exit;
  SourceRect := Rect;
  if ClipRect(SourceRect, DIB.ClientRect) then begin
    if FColor = clBlack then FColor := $00000000;

    Source := GetTextDIB(Text, FColor, Bcolor);
    if Source = nil then begin
      nX := 0;
      sText := Text;

      Source := TTexture.Create;
      Source.SetSize(TextWidth(Text), TextHeight('0'));
      New(FontText);
      FontText.Font := Source;
      FontText.Text := Text;
      FontText.Time := GetTickCount;
      FontText.Name := MainForm.Canvas.Font.Name;
      FontText.Size := MainForm.Canvas.Font.Size;
      FontText.Style := MainForm.Canvas.Font.Style;
      FontText.FColor := FColor;
      FontText.BColor := BColor;
      FontTextList.Add(FontText);
      pDst := Source.PBits;
      nPitch := Source.Pitch;
      DestRect := Source.ClientRect;
      if BColor <> clBlack then Source.Fill(BColor);

      for I := 1 to Length(sText) do begin
        S := sText[I];
        AChar := S[1];
        if (Ord(AChar) > 32) then begin //可见字符
          TextureFont := GetTextData(S);
          pSrc := TextureFont.Data;
          SrcRect := Bounds(0, 0, TextureFont.Width, TextureFont.Height);

          nWidth := SrcRect.Right - SrcRect.Left;
          nHeight := SrcRect.Bottom - SrcRect.Top;
          SrcP := PByte(Integer(pSrc) + SrcRect.Top * TextureFont.Width + SrcRect.Left);
          DstP := PByte(Integer(pDst) + (DestRect.Left + nX) * 2);

          DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, FColor);
          Inc(nX, nWidth);

        end else begin
          Inc(nX, TextWidth(S));
        end;
      end;
      if fsUnderline in MainForm.Canvas.Font.Style then begin
        Source.FillRect(Bounds(0, Source.Height - 1, Source.Width, Source.Height), FColor);
      end;
    end;

    DIB.Draw(SourceRect.Left, Y, Bounds(SourceRect.Left - X, 0, SourceRect.Right - SourceRect.Left, SourceRect.Bottom - SourceRect.Top), Source);
  end;
end;

procedure TImageFont.BoldDrawRect(DIB: TTexture;
  Rect: TRect; X, Y: Integer; const Text: string;
  FColor: TColor; BColor: TColor);
//procedure TImageFont.BoldDraw(DIB: TTexture; X, Y: Integer; const Text: string; FColor: TColor = clWhite; Bcolor: TColor = clBlack);
var
  I: Integer;
  S: string;
  sText: WideString;

  nX, nWidth, nHeight, nPitch: Integer;

  TextureFont: pTTextureFont;
  AChar: Char;

  SourceRect, SrcRect, DestRect, ClientRect: TRect;
  pSrc: PByte;
  pDst: PByte;
  SrcP: PByte;
  DstP: PByte;

  Source: TTexture;
  FontText: pTFontText;
begin
  if Text = '' then Exit;
  SourceRect := Rect;
  if ClipRect(SourceRect, DIB.ClientRect) then begin
    if FColor = clBlack then FColor := $00000000;

    Source := GetTextDIB(Text, FColor, Bcolor);
    if Source = nil then begin
      sText := Text;
      nX := 0;
      Source := TTexture.Create;
      Source.SetSize(TextWidth(Text) + 2, TextHeight('0') + 2);
      New(FontText);
      FontText.Font := Source;
      FontText.Text := Text;
      FontText.Time := GetTickCount;
      FontText.Name := MainForm.Canvas.Font.Name;
      FontText.Size := MainForm.Canvas.Font.Size;
      FontText.Style := MainForm.Canvas.Font.Style;
      FontText.FColor := FColor;
      FontText.BColor := BColor;
      FontTextList.Add(FontText);

      pDst := Source.PBits;
      nPitch := Source.Pitch;
      DestRect := Source.ClientRect;

      for I := 1 to Length(sText) do begin
        S := sText[I];
        AChar := S[1];
        if (Ord(AChar) > 32) then begin //可见字符
          TextureFont := GetTextData(S);
          pSrc := TextureFont.Data;
          SrcRect := Bounds(0, 0, TextureFont.Width, TextureFont.Height);
          ClientRect := SrcRect;

          nWidth := SrcRect.Right - SrcRect.Left;
          nHeight := SrcRect.Bottom - SrcRect.Top;

          SrcP := PByte(Integer(pSrc) + SrcRect.Top * TextureFont.Width + SrcRect.Left);

          DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX) * 2);
          DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

          DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX + 2) * 2);
          DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

          DstP := PByte(Integer(pDst) + DestRect.Top * nPitch + (DestRect.Left + nX + 1) * 2);
          DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

          DstP := PByte(Integer(pDst) + (DestRect.Top + 2) * nPitch + (DestRect.Left + nX + 1) * 2);
          DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

          DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX + 1) * 2);
          DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, FColor);

          Inc(nX, nWidth);

        end else begin
          Inc(nX, TextWidth(S));
        end;
      end;
      if fsUnderline in MainForm.Canvas.Font.Style then begin
        Source.FillRect(Bounds(0, Source.Height - 1, Source.Width, Source.Height), FColor);
      end;
    end;
    DIB.Draw(SourceRect.Left, Y, Bounds(SourceRect.Left - X, 0, SourceRect.Right - SourceRect.Left, SourceRect.Bottom - SourceRect.Top), Source);
    //DIB.Draw(X, Y, Source.ClientRect, Source);
  end;
end;

procedure TImageFont.Draw(DIB: TTexture; X, Y: Integer; const Text: string; FColor: TColor; BColor: TColor);
var
  I: Integer;
  S: string;
  sText: WideString;

  nX, nWidth, nHeight, nPitch: Integer;

  TextureFont: pTTextureFont;
  AChar: Char;

  SrcRect, DestRect, ClientRect: TRect;
  pSrc: PByte;
  pDst: PByte;
  SrcP: PByte;
  DstP: PByte;

  Source: TTexture;
  FontText: pTFontText;
begin
  if Text = '' then Exit;

  if FColor = clBlack then FColor := $00050505;

  Source := GetTextDIB(Text, FColor, Bcolor);
  if Source = nil then begin
    nX := 0;
    sText := Text;

    Source := TTexture.Create;
    Source.SetSize(TextWidth(Text), TextHeight('0'));
    New(FontText);
    FontText.Font := Source;
    FontText.Text := Text;
    FontText.Time := GetTickCount;
    FontText.Name := MainForm.Canvas.Font.Name;
    FontText.Size := MainForm.Canvas.Font.Size;
    FontText.Style := MainForm.Canvas.Font.Style;
    FontText.FColor := FColor;
    FontText.BColor := BColor;
    FontTextList.Add(FontText);
    pDst := Source.PBits;
    nPitch := Source.Pitch;
    DestRect := Source.ClientRect;
    if BColor <> clBlack then Source.Fill(BColor);

    for I := 1 to Length(sText) do begin
      S := sText[I];
      AChar := S[1];
      if (Ord(AChar) > 32) then begin //可见字符
        TextureFont := GetTextData(S);
        pSrc := TextureFont.Data;
        SrcRect := Bounds(0, 0, TextureFont.Width, TextureFont.Height);

        nWidth := SrcRect.Right - SrcRect.Left;
        nHeight := SrcRect.Bottom - SrcRect.Top;
        SrcP := PByte(Integer(pSrc) + SrcRect.Top * TextureFont.Width + SrcRect.Left);
        DstP := PByte(Integer(pDst) + (DestRect.Left + nX) * 2);

        DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, FColor);
        Inc(nX, nWidth);

      end else begin
        Inc(nX, TextWidth(S));
      end;
    end;
    if fsUnderline in MainForm.Canvas.Font.Style then begin
      Source.FillRect(Bounds(0, Source.Height - 1, Source.Width, Source.Height), FColor);
    end;
  end;

  DIB.Draw(X, Y, Source.ClientRect, Source);
end;

procedure TImageFont.BoldDraw(DIB: TTexture; X, Y: Integer; const Text: string; FColor: TColor = clWhite; Bcolor: TColor = clBlack);
var
  I: Integer;
  S: string;
  sText: WideString;

  nX, nWidth, nHeight, nPitch: Integer;

  TextureFont: pTTextureFont;
  AChar: Char;

  SrcRect, DestRect, ClientRect: TRect;
  pSrc: PByte;
  pDst: PByte;
  SrcP: PByte;
  DstP: PByte;

  Source: TTexture;
  FontText: pTFontText;
begin
  if Text = '' then Exit;

  if FColor = clBlack then FColor := $00050505;

  Source := GetTextDIB(Text, FColor, Bcolor);
  if Source = nil then begin
    sText := Text;
    nX := 0;
    Source := TTexture.Create;
    Source.SetSize(TextWidth(Text) + 2, TextHeight('0') + 2);
    New(FontText);
    FontText.Font := Source;
    FontText.Text := Text;
    FontText.Time := GetTickCount;
    FontText.Name := MainForm.Canvas.Font.Name;
    FontText.Size := MainForm.Canvas.Font.Size;
    FontText.Style := MainForm.Canvas.Font.Style;
    FontText.FColor := FColor;
    FontText.BColor := BColor;
    FontTextList.Add(FontText);

    pDst := Source.PBits;
    nPitch := Source.Pitch;
    DestRect := Source.ClientRect;

    for I := 1 to Length(sText) do begin
      S := sText[I];
      AChar := S[1];
      if (Ord(AChar) > 32) then begin //可见字符
        TextureFont := GetTextData(S);
        pSrc := TextureFont.Data;
        SrcRect := Bounds(0, 0, TextureFont.Width, TextureFont.Height);
        ClientRect := SrcRect;

        nWidth := SrcRect.Right - SrcRect.Left;
        nHeight := SrcRect.Bottom - SrcRect.Top;

        SrcP := PByte(Integer(pSrc) + SrcRect.Top * TextureFont.Width + SrcRect.Left);

        DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX) * 2);
        DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

        DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX + 2) * 2);
        DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

        DstP := PByte(Integer(pDst) + DestRect.Top * nPitch + (DestRect.Left + nX + 1) * 2);
        DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

        DstP := PByte(Integer(pDst) + (DestRect.Top + 2) * nPitch + (DestRect.Left + nX + 1) * 2);
        DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

        DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX + 1) * 2);
        DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, FColor);

        Inc(nX, nWidth);

      end else begin
        Inc(nX, TextWidth(S));
      end;
    end;
    if fsUnderline in MainForm.Canvas.Font.Style then begin
      Source.FillRect(Bounds(0, Source.Height - 1, Source.Width, Source.Height), FColor);
    end;
  end;

  DIB.Draw(X, Y, Source.ClientRect, Source);
end;

procedure TImageFont.DrawEditText(DIB: TTexture; const X, Y: Integer;
  const ARect, BRect, CRect: TRect;
  const AText, BText, CText: string;
  FontColor: TColor = clBlack;
  SelFontColor: TColor = clWhite;
  SelBackColor: TColor = clBlue);
var
  I: Integer;
  S: string;
  sText: WideString;

  nDrawX, nX, nWidth, nHeight, nPitch: Integer;

  TextureFont: pTTextureFont;
  AChar: Char;

  SrcRect, DestRect, ClientRect, SourceRect: TRect;
  pSrc: PByte;
  pDst: PByte;
  SrcP: PByte;
  DstP: PByte;

  Source: TTexture;
  FontText: pTFontText;
begin
  if (AText = '') and (BText = '') and (CText = '') then Exit;

  nDrawX := 0;
  if FontColor = clBlack then FontColor := $00050505;
  if SelFontColor = clBlack then SelFontColor := $00050505;
  if SelBackColor = clBlack then SelBackColor := $00000000;

  if (AText <> '') and (ARect.Right > ARect.Left) then begin

    Source := GetTextDIB(AText, FontColor, clBlack);
    if Source = nil then begin
      nX := 0;
      sText := AText;

      Source := TTexture.Create;
      Source.SetSize(TextWidth(AText), TextHeight('0'));
      New(FontText);
      FontText.Font := Source;
      FontText.Text := AText;
      FontText.Time := GetTickCount;
      FontText.Name := MainForm.Canvas.Font.Name;
      FontText.Size := MainForm.Canvas.Font.Size;
      FontText.Style := MainForm.Canvas.Font.Style;
      FontText.FColor := FontColor;
      FontText.BColor := clBlack;
      FontTextList.Add(FontText);
      pDst := Source.PBits;
      nPitch := Source.Pitch;
      DestRect := Source.ClientRect;

      for I := 1 to Length(sText) do begin
        S := sText[I];
        AChar := S[1];
        if (Ord(AChar) > 32) then begin //可见字符
          TextureFont := GetTextData(S);
          pSrc := TextureFont.Data;
          SrcRect := Bounds(0, 0, TextureFont.Width, TextureFont.Height);

          nWidth := SrcRect.Right - SrcRect.Left;
          nHeight := SrcRect.Bottom - SrcRect.Top;
          SrcP := PByte(Integer(pSrc) + SrcRect.Top * TextureFont.Width + SrcRect.Left);
          DstP := PByte(Integer(pDst) + (DestRect.Left + nX) * 2);

          DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, FontColor);
          Inc(nX, nWidth);

        end else begin
          Inc(nX, TextWidth(S));
        end;
      end;
      if fsUnderline in MainForm.Canvas.Font.Style then begin
        Source.FillRect(Bounds(0, Source.Height - 1, Source.Width, Source.Height), FontColor);
      end;
    end;

    DIB.Draw(X, Y, ARect, Source);
    nDrawX := ARect.Right - ARect.Left;
  end;

  if (BText <> '') and (BRect.Right > BRect.Left) and (X + nDrawX { + (BRect.Right - BRect.Left)} < DIB.Width) then begin
    Source := GetTextDIB(BText, SelFontColor, SelBackColor);
    if Source = nil then begin
      nX := 0;
      sText := BText;

      Source := TTexture.Create;
      Source.SetSize(TextWidth(BText), TextHeight('0'));
      New(FontText);
      FontText.Font := Source;
      FontText.Text := BText;
      FontText.Time := GetTickCount;
      FontText.Name := MainForm.Canvas.Font.Name;
      FontText.Size := MainForm.Canvas.Font.Size;
      FontText.Style := MainForm.Canvas.Font.Style;
      FontText.FColor := SelFontColor;
      FontText.BColor := SelBackColor;
      FontTextList.Add(FontText);
      pDst := Source.PBits;
      nPitch := Source.Pitch;
      DestRect := Source.ClientRect;
      Source.Fill(SelBackColor);

      for I := 1 to Length(sText) do begin
        S := sText[I];
        AChar := S[1];
        if (Ord(AChar) > 32) then begin //可见字符
          TextureFont := GetTextData(S);
          pSrc := TextureFont.Data;
          SrcRect := Bounds(0, 0, TextureFont.Width, TextureFont.Height);

          nWidth := SrcRect.Right - SrcRect.Left;
          nHeight := SrcRect.Bottom - SrcRect.Top;
          SrcP := PByte(Integer(pSrc) + SrcRect.Top * TextureFont.Width + SrcRect.Left);
          DstP := PByte(Integer(pDst) + (DestRect.Left + nX) * 2);

          DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, SelFontColor);
          Inc(nX, nWidth);

        end else begin
          Inc(nX, TextWidth(S));
        end;
      end;
      if fsUnderline in MainForm.Canvas.Font.Style then begin
        Source.FillRect(Bounds(0, Source.Height - 1, Source.Width, Source.Height), SelFontColor);
      end;
    end;

    DIB.Draw(X + nDrawX, Y, BRect, Source);
    nDrawX := nDrawX + (BRect.Right - BRect.Left);
  end;

  if (CText <> '') and (CRect.Right > CRect.Left) and (X + nDrawX < DIB.Width) then begin
    Source := GetTextDIB(CText, FontColor, clBlack);
    if Source = nil then begin
      nX := 0;
      sText := CText;

      Source := TTexture.Create;
      Source.SetSize(TextWidth(CText), TextHeight('0'));
      New(FontText);
      FontText.Font := Source;
      FontText.Text := CText;
      FontText.Time := GetTickCount;
      FontText.Name := MainForm.Canvas.Font.Name;
      FontText.Size := MainForm.Canvas.Font.Size;
      FontText.Style := MainForm.Canvas.Font.Style;
      FontText.FColor := FontColor;
      FontText.BColor := clBlack;
      FontTextList.Add(FontText);
      pDst := Source.PBits;
      nPitch := Source.Pitch;
      DestRect := Source.ClientRect;

      for I := 1 to Length(sText) do begin
        S := sText[I];
        AChar := S[1];
        if (Ord(AChar) > 32) then begin //可见字符
          TextureFont := GetTextData(S);
          pSrc := TextureFont.Data;
          SrcRect := Bounds(0, 0, TextureFont.Width, TextureFont.Height);

          nWidth := SrcRect.Right - SrcRect.Left;
          nHeight := SrcRect.Bottom - SrcRect.Top;
          SrcP := PByte(Integer(pSrc) + SrcRect.Top * TextureFont.Width + SrcRect.Left);
          DstP := PByte(Integer(pDst) + (DestRect.Left + nX) * 2);

          DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, FontColor);
          Inc(nX, nWidth);

        end else begin
          Inc(nX, TextWidth(S));
        end;
      end;
      if fsUnderline in MainForm.Canvas.Font.Style then begin
        Source.FillRect(Bounds(0, Source.Height - 1, Source.Width, Source.Height), FontColor);
      end;
    end;

    DIB.Draw(X + nDrawX, Y, CRect, Source);
  end;

  //end;
end;
{------------------------------------------------------------------------------}

procedure Register;
begin
  RegisterComponents('MirDevice', [TTextureDevice]);
end;

constructor TTextureDevice.Create(AOwner: TComponent);
var
  CPU: TCPU;
begin
  inherited;
  ImageFont := TImageFont.Create;
  ImageCanvas := TTexture.Create;
  CPU := TCPU.Create;
  CPU.GetInfo();
  IsMMX := CPU.Features.MMX;
  IsSSE := CPU.Features.SSE and CPU.Features.SSE2;

  CPU.Free;
end;

destructor TTextureDevice.Destroy();
begin
  FreeAndNil(ImageFont);
  FreeAndNil(ImageCanvas);
  //FreeAndNil(TextureList);
  inherited;
end;

procedure TTextureDevice.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;

end;

initialization
  begin

  end;

finalization
  begin

  end;

end.

