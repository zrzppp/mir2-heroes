unit LZRW;

interface

uses SysUtils, Classes;

{$IFDEF WIN32}
type
  Int16 = SmallInt;
{$ELSE}
type
  Int16 = Integer;
{$ENDIF}

const
  BufferMaxSize = 32768;
  BufferMax     = BufferMaxSize - 1;
  FLAG_Copied   = $80;
  FLAG_Compress = $40;
  FSignature = 'LZRW';
  
type
  BufferIndex = 0..BufferMax + 15;
  BufferSize  = 0..BufferMaxSize;
  { extra bytes needed here if compression fails      *dh *}
  BufferArray = array [BufferIndex] of BYTE;
  BufferPtr   = ^BufferArray;


  ELzrw1KHCompressor = class(Exception);


function Compression(Source, Dest: BufferPtr; SourceSize: BufferSize): BufferSize;
function Decompression(Source, Dest: BufferPtr; SourceSize: BufferSize): BufferSize;

procedure CompressStream(InStream, OutStream: TStream; InSize: LongInt);
procedure DeCompressStream(InStream, OutStream: TStream);

implementation

type
  HashTable  = array [0..4095] of Int16;
  HashTabPtr = ^Hashtable;

var
  Hash: HashTabPtr;

  { check if this string has already been seen }
  { in the current 4 KB window }
  
function GetMatch(Source: BufferPtr; X: BufferIndex;
  SourceSize: BufferSize; Hash: HashTabPtr; var Size: WORD;
  var Pos: BufferIndex): BOOLEAN;
var
  HashValue: WORD;
  TmpHash: Int16;
begin
  HashValue := (40543 * ((((Source^[X] shl 4) xor Source^[X + 1]) shl 4) xor
    Source^[X + 2]) shr 4) and $0FFF;
  Result := False;
  TmpHash := Hash^[HashValue];
  if (TmpHash <> -1) and (X - TmpHash < 4096) then
  begin
    Pos  := TmpHash;
    Size := 0;
    while ((Size < 18) and (Source^[X + Size] = Source^[Pos + Size]) and
      (X + Size < SourceSize)) do
    begin
      INC(Size);
    end;
    Result := (Size >= 3)
  end;
  Hash^[HashValue] := X
end;

{ compress a buffer of max. 32 KB }

function Compression(Source, Dest: BufferPtr;
  SourceSize: BufferSize): BufferSize;
var
  Bit, Command, Size: WORD;
  Key: Word;
  X, Y, Z, Pos: BufferIndex;
begin
  FillChar(Hash^, SizeOf(Hashtable), $FF);
  Dest^[0] := FLAG_Compress;
  X := 0;
  Y := 3;
  Z := 1;
  Bit := 0;
  Command := 0;
  while (X < SourceSize) and (Y <= SourceSize) do
  begin
    if (Bit > 15) then
    begin
      Dest^[Z] := HI(Command);
      Dest^[Z + 1] := LO(Command);
      Z := Y;
      Bit := 0;
      INC(Y, 2)
    end;
    Size := 1;
    while ((Source^[X] = Source^[X + Size]) and (Size < $FFF) and
      (X + Size < SourceSize)) do
    begin
      INC(Size);
    end;
    if (Size >= 16) then
    begin
      Dest^[Y] := 0;
      Dest^[Y + 1] := HI(Size - 16);
      Dest^[Y + 2] := LO(Size - 16);
      Dest^[Y + 3] := Source^[X];
      INC(Y, 4);
      INC(X, Size);
      Command := (Command shl 1) + 1;
    end
    else
    begin { not size >= 16 }
      if (GetMatch(Source, X, SourceSize, Hash, Size, Pos)) then
      begin
        Key := ((X - Pos) shl 4) + (Size - 3);
        Dest^[Y] := HI(Key);
        Dest^[Y + 1] := LO(Key);
        INC(Y, 2);
        INC(X, Size);
        Command := (Command shl 1) + 1
      end
      else
      begin
        Dest^[Y] := Source^[X];
        INC(Y);
        INC(X);
        Command := Command shl 1
      end;
    end; { size <= 16 }
    INC(Bit);
  end; { while x < sourcesize ... }
  Command := Command shl (16 - Bit);
  Dest^[Z] := HI(Command);
  Dest^[Z + 1] := LO(Command);
  if (Y > SourceSize) then
  begin
    MOVE(Source^[0], Dest^[1], SourceSize);
    Dest^[0] := FLAG_Copied;
    Y        := SUCC(SourceSize)
  end;
  Result := Y
end;

{ decompress a buffer of max 32 KB }

function Decompression(Source, Dest: BufferPtr;
  SourceSize: BufferSize): BufferSize;
var
  X, Y, Pos: BufferIndex;
  Command, Size, K: WORD;
  Bit: BYTE;
  SaveY: BufferIndex; { * dh * unsafe for-loop variable Y }
begin
  if (Source^[0] = FLAG_Copied) then
  begin
    for Y := 1 to PRED(SourceSize) do
    begin
      Dest^[PRED(Y)] := Source^[Y];
      SaveY := Y;
    end;
    Y := SaveY;
  end
  else
  begin
    Y       := 0;
    X       := 3;
    Command := (Source^[1] shl 8) + Source^[2];
    Bit     := 16;
    while (X < SourceSize) do
    begin
      if (Bit = 0) then
      begin
        Command := (Source^[X] shl 8) + Source^[X + 1];
        Bit := 16;
        INC(X, 2)
      end;
      if ((Command and $8000) = 0) then
      begin
        Dest^[Y] := Source^[X];
        INC(X);
        INC(Y)
      end
      else
      begin  { command and $8000 }
        Pos := ((Source^[X] shl 4) + (Source^[X + 1] shr 4));
        if (Pos = 0) then
        begin
          Size := (Source^[X + 1] shl 8) + Source^[X + 2] + 15;
          for K := 0 to Size do
          begin
            Dest^[Y + K] := Source^[X + 3];
          end;
          INC(X, 4);
          INC(Y, Size + 1)
        end
        else
        begin  { pos = 0 }
          Size := (Source^[X + 1] and $0F) + 2;
          for K := 0 to Size do
            Dest^[Y + K] := Dest^[Y - Pos + K];
          INC(X, 2);
          INC(Y, Size + 1)
        end; { pos = 0 }
      end;   { command and $8000 }
      Command := Command shl 1;
      DEC(Bit)
    end { while x < sourcesize }
  end;
  Result := Y
end;  { decompression }

{
  Unit "Finalization" as Delphi 2.0 would have it
}

procedure CompressStream(InStream, OutStream: TStream; InSize: LongInt);
var
  InBuffer, OutBuffer: BufferArray;
  CompressedSize, BytesRead, FinalPos, SizePos, TotalSize: LongInt;
begin
  TotalSize := 0;
  OutStream.WriteBuffer(FSignature, SizeOf(FSignature));
  SizePos := OutStream.Position;
  OutStream.WriteBuffer(TotalSize, SizeOf(TotalSize));
  while InSize > 0 do
  begin
    BytesRead      := InStream.Read(InBuffer, SizeOf(InBuffer));
    CompressedSize := Compression(@InBuffer, @OutBuffer, BytesRead);
    OutStream.WriteBuffer(CompressedSize, SizeOf(CompressedSize));
    OutStream.WriteBuffer(OutBuffer, CompressedSize);
    TotalSize := TotalSize + CompressedSize + SizeOf(CompressedSize);
    InSize    := InSize - BytesRead;
  end;
  FinalPos := OutStream.Position;
  OutStream.Position := SizePos;
  OutStream.WriteBuffer(TotalSize, SizeOf(TotalSize));
  OutStream.Position := FinalPos;
end;

procedure DeCompressStream(InStream, OutStream: TStream);
var
  InBuffer, OutBuffer: BufferArray;
  CompressedSize, UnCompressedSize, InSize: LongInt;
  Sig: array[0..SizeOf(FSignature) - 1] of Char;
begin
  InStream.ReadBuffer(Sig, SizeOf(FSignature));
  if Sig <> FSignature then
    raise Exception.Create('Wrong file type');
  InStream.ReadBuffer(InSize, SizeOf(InSize));
  while InSize > 0 do
  begin
    InStream.ReadBuffer(CompressedSize, SizeOf(CompressedSize));
    InStream.ReadBuffer(InBuffer, CompressedSize);
    UnCompressedSize := DeCompression(@InBuffer, @OutBuffer, CompressedSize);
    OutStream.WriteBuffer(OutBuffer, UnCompressedSize);
    InSize := InSize - CompressedSize - SizeOf(CompressedSize);
  end;
end;

var
  ExitSave: Pointer;

procedure Cleanup; far;
begin
  ExitProc := ExitSave;
  if (Hash <> nil) then
    Freemem(Hash, Sizeof(HashTable));
end;

initialization
  Hash := nil;
  try
    Getmem(Hash, Sizeof(Hashtable));
  except
    raise ELzrw1KHCompressor.Create('LZRW1KH : no memory for HASH table');
  end;
  ExitSave := ExitProc;
  ExitProc := @Cleanup;
end.
