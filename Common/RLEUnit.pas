unit RLEUnit;

interface
uses
  windows, sysutils, graphics, math;

function EncodeRLE(const Source, Target: Pointer; Count, BPP: Integer): Integer;
//BBP : Byte Per Point; 16bit: 2 ;  24bit: 3
function DecodeRLE(const Source, Target: Pointer; Count, ColorDepth: Cardinal): Integer;
function CountDiffPixels(P: PByte; BPP: Byte; Count: Integer): Integer;
function CountSamePixels(P: PByte; BPP: Byte; Count: Integer): Integer;
function GetPixel(P: PByte; BPP: Byte): Cardinal;

implementation
//******************************************************************************

function EncodeRLE(const Source, Target: Pointer; Count, BPP: Integer): Integer;
var
  DiffCount, // pixel count until two identical
    SameCount: Integer; // number of identical adjacent pixels
  SourcePtr,
    TargetPtr: PByte;
begin
  Result := 0;
  SourcePtr := Source;
  TargetPtr := Target;
  while Count > 0 do
  begin
    DiffCount := CountDiffPixels(SourcePtr, BPP, Count);
    SameCount := CountSamePixels(SourcePtr, BPP, Count);
    if DiffCount > 128 then DiffCount := 128;
    if SameCount > 128 then SameCount := 128;

    if DiffCount > 0 then
    begin
      // create a raw packet
      TargetPtr^ := DiffCount - 1; Inc(TargetPtr);
      Dec(Count, DiffCount);
      Inc(Result, (DiffCount * BPP) + 1);
      while DiffCount > 0 do
      begin
        TargetPtr^ := SourcePtr^; Inc(SourcePtr); Inc(TargetPtr);
        if BPP > 1 then begin TargetPtr^ := SourcePtr^; Inc(SourcePtr); Inc(TargetPtr); end;
        if BPP > 2 then begin TargetPtr^ := SourcePtr^; Inc(SourcePtr); Inc(TargetPtr); end;
        if BPP > 3 then begin TargetPtr^ := SourcePtr^; Inc(SourcePtr); Inc(TargetPtr); end;
        Dec(DiffCount);
      end;
    end;

    if SameCount > 1 then
    begin
      // create a RLE packet
      TargetPtr^ := (SameCount - 1) or $80; Inc(TargetPtr);
      Dec(Count, SameCount);
      Inc(Result, BPP + 1);
      Inc(SourcePtr, (SameCount - 1) * BPP);
      TargetPtr^ := SourcePtr^; Inc(SourcePtr); Inc(TargetPtr);
      if BPP > 1 then begin TargetPtr^ := SourcePtr^; Inc(SourcePtr); Inc(TargetPtr); end;
      if BPP > 2 then begin TargetPtr^ := SourcePtr^; Inc(SourcePtr); Inc(TargetPtr); end;
      if BPP > 3 then begin TargetPtr^ := SourcePtr^; Inc(SourcePtr); Inc(TargetPtr); end;
    end;
  end;
end;
//******************************************************************************

function DecodeRLE(const Source, Target: Pointer; Count, ColorDepth: Cardinal): Integer;
type
  PCardinalArray = ^TCardinalArray;
  TCardinalArray = array[0..MaxInt div 4 - 1] of Cardinal;
var
  I: Integer;
  SourcePtr,
    TargetPtr: PByte;
  RunLength: Cardinal;
  Counter: Cardinal;
  SourceCardinal: Cardinal;
begin
  Result := 0;
  Counter := 0;
  TargetPtr := Target;
  SourcePtr := Source;
  // unrolled decoder loop to speed up process
  case ColorDepth of
    8:
      while Counter < Count do
      begin
        RunLength := 1 + (SourcePtr^ and $7F);
        if SourcePtr^ > $7F then
        begin
          Inc(SourcePtr);
          FillChar(TargetPtr^, RunLength, SourcePtr^);
          Inc(TargetPtr, RunLength);
          Inc(SourcePtr);
          Inc(Result, 2);
        end
        else
        begin
          Inc(SourcePtr);
          Move(SourcePtr^, TargetPtr^, RunLength);
          Inc(SourcePtr, RunLength);
          Inc(TargetPtr, RunLength);
          Inc(Result, RunLength + 1)
        end;
        Inc(Counter, RunLength);
      end;
    15,
      16:
      while Counter < Count do
      begin
        RunLength := 1 + (SourcePtr^ and $7F);
        if SourcePtr^ > $7F then
        begin
          Inc(SourcePtr);
          for I := 0 to RunLength - 1 do
          begin
            TargetPtr^ := SourcePtr^;
            Inc(SourcePtr);
            Inc(TargetPtr);
            TargetPtr^ := SourcePtr^;
            Dec(SourcePtr);
            Inc(TargetPtr);
          end;
          Inc(SourcePtr, 2);
          Inc(Result, 3);
        end
        else
        begin
          Inc(SourcePtr);
          Move(SourcePtr^, TargetPtr^, 2 * RunLength);
          Inc(SourcePtr, 2 * RunLength);
          Inc(TargetPtr, 2 * RunLength);
          Inc(Result, RunLength * 2 + 1);
        end;
        Inc(Counter, 2 * RunLength);
      end;
    24:
      while Counter < Count do
      begin
        RunLength := 1 + (SourcePtr^ and $7F);
        if SourcePtr^ > $7F then
        begin
          Inc(SourcePtr);
          for I := 0 to RunLength - 1 do
          begin
            TargetPtr^ := SourcePtr^;
            Inc(SourcePtr);
            Inc(TargetPtr);
            TargetPtr^ := SourcePtr^;
            Inc(SourcePtr);
            Inc(TargetPtr);
            TargetPtr^ := SourcePtr^;
            Dec(SourcePtr, 2);
            Inc(TargetPtr);
          end;
          Inc(SourcePtr, 3);
          Inc(Result, 4);
        end
        else
        begin
          Inc(SourcePtr);
          Move(SourcePtr^, TargetPtr^, 3 * RunLength);
          Inc(SourcePtr, 3 * RunLength);
          Inc(TargetPtr, 3 * RunLength);
          Inc(Result, RunLength * 3 + 1);
        end;
        Inc(Counter, 3 * RunLength);
      end;
    32:
      while Counter < Count do
      begin
        RunLength := 1 + (SourcePtr^ and $7F);
        if SourcePtr^ > $7F then
        begin
          Inc(SourcePtr);
          SourceCardinal := PCardinalArray(SourcePtr)[0];
          for I := 0 to RunLength - 1 do
            PCardinalArray(TargetPtr)[I] := SourceCardinal;

          Inc(TargetPtr, 4 * RunLength);
          Inc(SourcePtr, 4);
          Inc(Result, 5);
        end
        else
        begin
          Inc(SourcePtr);
          Move(SourcePtr^, TargetPtr^, 4 * RunLength);
          Inc(SourcePtr, 4 * RunLength);
          Inc(TargetPtr, 4 * RunLength);
          Inc(Result, RunLength * 4 + 1);
        end;
        Inc(Counter, 4 * RunLength);
      end;
  end;
end;
//------------------------------------------------------------------------------

function CountDiffPixels(P: PByte; BPP: Byte; Count: Integer): Integer;
// counts pixels in buffer until two identical adjacent ones found
var
  N: Integer;
  Pixel,
    NextPixel: Cardinal;
begin
  N := 0;
  NextPixel := 0; // shut up compiler
  if Count = 1 then Result := Count
  else
  begin
    Pixel := GetPixel(P, BPP);
    while Count > 1 do
    begin
      Inc(P, BPP);
      NextPixel := GetPixel(P, BPP);
      if NextPixel = Pixel then Break;
      Pixel := NextPixel;
      Inc(N);
     //===================================================================================================
      if N = 128 then Break; // 既然行程最大只有 128 何必继续向下搜索
                                                         // 在大片无像素重复时 会造成大量的多余循环
     //====================================================================================================
      Dec(Count);
    end;

    if NextPixel = Pixel then Result := N
    else Result := N + 1;
  end;
end;
//------------------------------------------------------------------------------

function CountSamePixels(P: PByte; BPP: Byte; Count: Integer): Integer;
var
  Pixel,
    NextPixel: Cardinal;
begin
  Result := 1;
  Pixel := GetPixel(P, BPP);
  Dec(Count);
  while Count > 0 do
  begin
    Inc(P, BPP);
    NextPixel := GetPixel(P, BPP);
    if NextPixel <> Pixel then Break;
    Inc(Result);

     //===================================================================================================
    if Result = 128 then Break; // 既然行程最大只有 128 何必继续向下搜索
                                                              // 在大片的像素重复时 会造成大量的多余循环
     //====================================================================================================

    Dec(Count);
  end;

end;
//------------------------------------------------------------------------------

function GetPixel(P: PByte; BPP: Byte): Cardinal;
// Retrieves a pixel value from a buffer. The actual size and order of the bytes is not important
// since we are only using the value for comparisons with other pixels.
begin
  Result := P^;
  Inc(P);
  Dec(BPP);
  while BPP > 0 do
  begin
    Result := Result shl 8;
    Result := Result or P^;
    Inc(P);
    Dec(BPP);
  end;
end;

end.

