(******************************************************************************)
(*                                                                            *)
(* LH5.PAS                                                                    *)
(*                                                                            *)
(* This code compress/decompress data using the same algorithm as LHArc 2.x   *)
(* It is roughly derived from the C source code of AR002 (a C version of a    *)
(* subset of LHArc, written by Haruhiko Okomura).                             *)
(* The algorithm was created by Haruhiko Okomura and Haruyasu Yoshizaki.      *)
(*                                                                            *)
(* 6/11/98  Modified by Gregory L. Bullock with the hope of fixing a
            problem when compiled for 32-bits.
            Some variables of type TWord are sometimes treated as
            ARRAY[0..32759]OF Integer; and other times as
            ARRAY[0..32759]OF Word;
            InsertNode, for example, expects a signed integer since it
            includes the expression Position^[t]<0.
            To account for this, I've defined TwoByteInt which is a 2-byte
            signed integer on either platform.
*)

(* 4/20/98  Modified by Gregory L. Bullock (bullock@tsppd.com)                 *)
(*           - to use TStream (and descendents) instead of files,             *)
(*           - to reduce the memory requirements in the data segment,         *)
(*           - to changed the program to a unit.                              *)
(*          The interface consists of the two procedures                      *)
(*             procedure LHACompress(InStr, OutStr: TStream);                 *)
(*             procedure LHAExpand(InStr, OutStr: TStream);                   *)
(*          These procedures DO NOT change the current position of EITHER     *)
(*          TStream before performing their function.  Thus, LHACompress      *)
(*          starts compressing at InStr's current position and continues to   *)
(*          the end of InStr, placing the compressed output in OutStr         *)
(*          starting at OutStr's current position. If you need the entirety   *)
(*          of InStr compressed or uncompressed, you'll need to set           *)
(*          InStr.Position := 0 before calling one of these procedures.       *)
(*                                                                            *)
(*          See the test program at the end of this unit for an example of    *)
(*          how to use these procedures.                                      *)
(*                                                                            *)
(*          Changing this to a unit required the (internal) addition of       *)
(*             procedure FreeMemory;                                          *)
(*             procedure InitMemory;                                          *)
(*          to ensure that memory gets initialized properly between calls     *)
(*          to the unit's interface procedures.                               *)
(******************************************************************************)

unit CompressUnit1;

{Turn off range checking - MANDATORY ! and stack checking (to speed up things)}
{$B-,R-,S-}
{$WARNINGS OFF}
{$DEFINE PERCOLATE}
(*
NOTE :
   LHArc uses a "percolating" update of its Lempel-Ziv structures.
   If you use the percolating method, the compressor will run slightly faster,
   using a little more memory, and will be slightly less efficient than the
   standard method.
   You can choose either method, and note that the decompressor is not
   affected by this choice and is able to decompress data created by each one
   of the compressors.
*)

interface

uses
  SysUtils, Classes, Dialogs;

procedure LHACompress(InStr, OutStr: TStream);
    (*  LHACompress starts compressing at InStr's current position and continues
        to the end of InStr, placing the compressed output in OutStr starting at
        OutStr's current position. If you need the entirety of InStr compressed
        you'll need to set InStr.Position := 0 before calling.
    *)
procedure LHAExpand(InStr, OutStr: TStream);
    (*  LHAExpand starts expanding at InStr's current position and continues to
        the end of InStr, placing the expanded output in OutStr starting at
        OutStr's current position. If you need the entirety of InStr expanded
        you'll need to set InStr.Position := 0 before calling.
    *)
procedure CompBufferL(const InData: Pointer; InSize: LongInt; out OutData: Pointer; out OutSize: LongInt);
procedure UnCompBufferL(const InData: Pointer; InSize: LongInt; out OutData: Pointer; out OutSize: LongInt);

implementation

type
{$IFDEF WIN32}
  TwoByteInt = SmallInt;
{$ELSE}
  TwoByteInt = Integer;
{$ENDIF}
  PWord = ^TWord;
  TWord = array[0..32759] of TwoByteInt;
  PByte = ^TByte;
  TByte = array[0..65519] of Byte;

const
(*
NOTE :
   The following constants are set to the values used by LHArc.
   You can change three of them as follows :

   DICBIT : Lempel-Ziv dictionnary size.
   Lowering this constant can lower the compression efficiency a lot !
   But increasing it (on a 32 bit platform only, i.e. Delphi 2) will not yield
   noticeably better results.
   If you set DICBIT to 15 or more, set PBIT to 5; and if you set DICBIT to 19
   or more, set NPT to NP, too.

   WINBIT : Sliding window size.
   The compression ratio depends a lot of this value.
   You can increase it to 15 to get better results on large files.
   I recommend doing this if you have enough memory, except if you want that
   your compressed data remain compatible with LHArc.
   On a 32 bit platform, you can increase it to 16. Using a larger value will
   only waste time and memory.

   BUFBIT : I/O Buffer size. You can lower it to save memory, or increase it
   to reduce disk access.
*)

  BITBUFSIZ = 16;
  UCHARMAX = 255;

  DICBIT = 13;
  DICSIZ = 1 shl DICBIT;

  MATCHBIT = 8;
  MAXMATCH = 1 shl MATCHBIT;
  THRESHOLD = 3;
  PERCFLAG = $8000;

  NC = (UCHARMAX + MAXMATCH + 2 - THRESHOLD);
  CBIT = 9;
  CODEBIT = 16;

  NP = DICBIT + 1;
  NT = CODEBIT + 3;
  PBIT = 4; {Log2(NP)}
  TBIT = 5; {Log2(NT)}
  NPT = NT; {Greater from NP and NT}

  NUL = 0;
  MAXHASHVAL = (3 * DICSIZ + (DICSIZ shr 9 + 1) * UCHARMAX);

  WINBIT = 14;
  WINDOWSIZE = 1 shl WINBIT;

  BUFBIT = 13;
  BUFSIZE = 1 shl BUFBIT;

type
  BufferArray = array[0..Pred(BUFSIZE)] of Byte;
  LeftRightArray = array[0..2 * (NC - 1)] of Word;
  CTableArray = array[0..4095] of Word;
  CLenArray = array[0..Pred(NC)] of Byte;
  HeapArray = array[0..NC] of Word;

var
  OrigSize, CompSize: Longint;
  InFile, OutFile: TStream;

  BitBuf: Word;
  n, HeapSize: TwoByteInt;
  SubBitBuf, BitCount: Word;

  Buffer: ^BufferArray;
  BufPtr: Word;

  Left, Right: ^LeftRightArray;

  PtTable: array[0..255] of Word;
  PtLen: array[0..Pred(NPT)] of Byte;
  CTable: ^CTableArray;
  CLen: ^CLenArray;

  BlockSize: Word;

  { The following variables are used by the compression engine only }

  Heap: ^HeapArray;
  LenCnt: array[0..16] of Word;

  Freq, SortPtr: PWord;
  Len: PByte;
  Depth: Word;

  Buf: PByte;

  CFreq: array[0..2 * (NC - 1)] of Word;
  PFreq: array[0..2 * (NP - 1)] of Word;
  TFreq: array[0..2 * (NT - 1)] of Word;

  CCode: array[0..Pred(NC)] of Word;
  PtCode: array[0..Pred(NPT)] of Word;

  CPos, OutputPos, OutputMask: Word;
  Text, ChildCount: PByte;

  Pos, MatchPos, Avail: Word;
  Position, Parent, Prev, Next: PWord;

  Remainder, MatchLen: TwoByteInt;
  Level: PByte;

{********************************** File I/O **********************************}

function GetC: Byte;
begin
  if BufPtr = 0 then
    InFile.Read(Buffer^, BUFSIZE);
  GetC := Buffer^[BufPtr]; BufPtr := SUCC(BufPtr) and Pred(BUFSIZE);
end;

procedure PutC(c: Byte);
begin
  if BufPtr = BUFSIZE then
  begin
    OutFile.Write(Buffer^, BUFSIZE); BufPtr := 0;
  end;
  Buffer^[BufPtr] := c; INC(BufPtr);
end;

function BRead(p: Pointer; n: TwoByteInt): TwoByteInt;
begin
  BRead := InFile.Read(p^, n);
end;

procedure BWrite(p: Pointer; n: TwoByteInt);
begin
  OutFile.Write(p^, n);
end;

{**************************** Bit handling routines ***************************}

procedure FillBuf(n: TwoByteInt);
begin
  BitBuf := (BitBuf shl n);
  while n > BitCount do begin
    Dec(n, BitCount);
    BitBuf := BitBuf or (SubBitBuf shl n);
    if (CompSize <> 0) then
    begin
      Dec(CompSize); SubBitBuf := GetC;
    end else
      SubBitBuf := 0;
    BitCount := 8;
  end;
  Dec(BitCount, n);
  BitBuf := BitBuf or (SubBitBuf shr BitCount);
end;

function GetBits(n: TwoByteInt): Word;
begin
  GetBits := BitBuf shr (BITBUFSIZ - n);
  FillBuf(n);
end;

procedure PutBits(n: TwoByteInt; x: Word);
begin
  if n < BitCount then
  begin
    Dec(BitCount, n);
    SubBitBuf := SubBitBuf or (x shl BitCount);
  end else begin
    Dec(n, BitCount);
    PutC(SubBitBuf or (x shr n)); INC(CompSize);
    if n < 8 then
    begin
      BitCount := 8 - n; SubBitBuf := x shl BitCount;
    end else begin
      PutC(x shr (n - 8)); INC(CompSize);
      BitCount := 16 - n; SubBitBuf := x shl BitCount;
    end;
  end;
end;

procedure InitGetBits;
begin
  BitBuf := 0; SubBitBuf := 0; BitCount := 0; FillBuf(BITBUFSIZ);
end;

procedure InitPutBits;
begin
  BitCount := 8; SubBitBuf := 0;
end;

{******************************** Decompression *******************************}

procedure MakeTable(nchar: TwoByteInt; BitLen: PByte; TableBits: TwoByteInt; Table: PWord);
var
  Count, weight: array[1..16] of Word;
  start: array[1..17] of Word;
  p: PWord;
  I, k, Len, ch, jutbits, Avail, nextCode, mask: TwoByteInt;
begin
  for I := 1 to 16 do
    Count[I] := 0;
  for I := 0 to Pred(nchar) do
    INC(Count[BitLen^[I]]);
  start[1] := 0;
  for I := 1 to 16 do
    start[SUCC(I)] := start[I] + (Count[I] shl (16 - I));
  if start[17] <> 0 then
    Halt(1);
  jutbits := 16 - TableBits;
  for I := 1 to TableBits do
  begin
    start[I] := start[I] shr jutbits; weight[I] := 1 shl (TableBits - I);
  end;
  I := SUCC(TableBits);
  while (I <= 16) do begin
    weight[I] := 1 shl (16 - I); INC(I);
  end;
  I := start[SUCC(TableBits)] shr jutbits;
  if I <> 0 then
  begin
    k := 1 shl TableBits;
    while I <> k do begin
      Table^[I] := 0; INC(I);
    end;
  end;
  Avail := nchar; mask := 1 shl (15 - TableBits);
  for ch := 0 to Pred(nchar) do
  begin
    Len := BitLen^[ch];
    if Len = 0 then
      Continue;
    k := start[Len];
    nextCode := k + weight[Len];
    if Len <= TableBits then
    begin
      for I := k to Pred(nextCode) do
        Table^[I] := ch;
    end else begin
      p := Addr(Table^[Word(k) shr jutbits]); I := Len - TableBits;
      while I <> 0 do begin
        if p^[0] = 0 then
        begin
          Right^[Avail] := 0; Left^[Avail] := 0; p^[0] := Avail; INC(Avail);
        end;
        if (k and mask) <> 0 then
          p := Addr(Right^[p^[0]])
        else
          p := Addr(Left^[p^[0]]);
        k := k shl 1; Dec(I);
      end;
      p^[0] := ch;
    end;
    start[Len] := nextCode;
  end;
end;

procedure ReadPtLen(nn, nBit, ispecial: TwoByteInt);
var
  I, c, n: TwoByteInt;
  mask: Word;
begin
  n := GetBits(nBit);
  if n = 0 then
  begin
    c := GetBits(nBit);
    for I := 0 to Pred(nn) do
      PtLen[I] := 0;
    for I := 0 to 255 do
      PtTable[I] := c;
  end else begin
    I := 0;
    while (I < n) do begin
      c := BitBuf shr (BITBUFSIZ - 3);
      if c = 7 then
      begin
        mask := 1 shl (BITBUFSIZ - 4);
        while (mask and BitBuf) <> 0 do begin
          mask := mask shr 1; INC(c);
        end;
      end;
      if c < 7 then
        FillBuf(3)
      else
        FillBuf(c - 3);
      PtLen[I] := c; INC(I);
      if I = ispecial then
      begin
        c := Pred(TwoByteInt(GetBits(2)));
        while c >= 0 do begin
          PtLen[I] := 0; INC(I); Dec(c);
        end;
      end;
    end;
    while I < nn do begin
      PtLen[I] := 0; INC(I);
    end;
    MakeTable(nn, @PtLen, 8, @PtTable);
  end;
end;

procedure ReadCLen;
var
  I, c, n: TwoByteInt;
  mask: Word;
begin
  n := GetBits(CBIT);
  if n = 0 then
  begin
    c := GetBits(CBIT);
    for I := 0 to Pred(NC) do
      CLen^[I] := 0;
    for I := 0 to 4095 do
      CTable^[I] := c;
  end else begin
    I := 0;
    while I < n do begin
      c := PtTable[BitBuf shr (BITBUFSIZ - 8)];
      if c >= NT then
      begin
        mask := 1 shl (BITBUFSIZ - 9);
        repeat
          if (BitBuf and mask) <> 0 then
            c := Right^[c]
          else
            c := Left^[c];
          mask := mask shr 1;
        until c < NT;
      end;
      FillBuf(PtLen[c]);
      if c <= 2 then
      begin
        if c = 1 then
          c := 2 + GetBits(4)
        else
          if c = 2 then
          c := 19 + GetBits(CBIT);
        while c >= 0 do begin
          CLen^[I] := 0; INC(I); Dec(c);
        end;
      end else begin
        CLen^[I] := c - 2; INC(I);
      end;
    end;
    while I < NC do begin
      CLen^[I] := 0; INC(I);
    end;
    MakeTable(NC, PByte(CLen), 12, PWord(CTable));
  end;
end;

function DecodeC: Word;
var
  j, mask: Word;
begin
  if BlockSize = 0 then
  begin
    BlockSize := GetBits(16);
    ReadPtLen(NT, TBIT, 3);
    ReadCLen;
    ReadPtLen(NP, PBIT, -1);
  end;
  Dec(BlockSize);
  j := CTable^[BitBuf shr (BITBUFSIZ - 12)];
  if j >= NC then
  begin
    mask := 1 shl (BITBUFSIZ - 13);
    repeat
      if (BitBuf and mask) <> 0 then
        j := Right^[j]
      else
        j := Left^[j];
      mask := mask shr 1;
    until j < NC;
  end;
  FillBuf(CLen^[j]);
  DecodeC := j;
end;

function DecodeP: Word;
var
  j, mask: Word;
begin
  j := PtTable[BitBuf shr (BITBUFSIZ - 8)];
  if j >= NP then
  begin
    mask := 1 shl (BITBUFSIZ - 9);
    repeat
      if (BitBuf and mask) <> 0 then
        j := Right^[j]
      else
        j := Left^[j];
      mask := mask shr 1;
    until j < NP;
  end;
  FillBuf(PtLen[j]);
  if j <> 0 then
  begin
    Dec(j); j := (1 shl j) + GetBits(j);
  end;
  DecodeP := j;
end;

{declared as static vars}
var
  decode_i: Word;
  decode_j: TwoByteInt;

procedure DecodeBuffer(Count: Word; Buffer: PByte);
var
  c, r: Word;
begin
  r := 0; Dec(decode_j);
  while (decode_j >= 0) do begin
    Buffer^[r] := Buffer^[decode_i]; decode_i := SUCC(decode_i) and Pred(DICSIZ);
    INC(r);
    if r = Count then
      Exit;
    Dec(decode_j);
  end;
  while True do begin
    c := DecodeC;
    if c <= UCHARMAX then
    begin
      Buffer^[r] := c; INC(r);
      if r = Count then
        Exit;
    end else begin
      decode_j := c - (UCHARMAX + 1 - THRESHOLD);
      decode_i := (Longint(r) - DecodeP - 1) and Pred(DICSIZ);
      Dec(decode_j);
      while decode_j >= 0 do begin
        Buffer^[r] := Buffer^[decode_i];
        decode_i := SUCC(decode_i) and Pred(DICSIZ);
        INC(r);
        if r = Count then
          Exit;
        Dec(decode_j);
      end;
    end;
  end;
end;

procedure Decode;
var
  p: PByte;
  l: Longint;
  a: Word;
begin
  {Initialize decoder variables}
  GetMem(p, DICSIZ);
  InitGetBits; BlockSize := 0;
  decode_j := 0;
  {skip file size}
  l := OrigSize; Dec(CompSize, 4);
  {unpacks the file}
  while l > 0 do begin
    if l > DICSIZ then
      a := DICSIZ
    else
      a := l;
    DecodeBuffer(a, p);
    OutFile.Write(p^, a); Dec(l, a);
  end;
  FreeMem(p, DICSIZ);
end;

{********************************* Compression ********************************}

{-------------------------------- Huffman part --------------------------------}

procedure CountLen(I: TwoByteInt);
begin
  if I < n then
  begin
    if Depth < 16 then
      INC(LenCnt[Depth])
    else
      INC(LenCnt[16]);
  end else begin
    INC(Depth);
    CountLen(Left^[I]); CountLen(Right^[I]);
    Dec(Depth);
  end;
end;

procedure MakeLen(root: TwoByteInt);
var
  I, k: TwoByteInt;
  cum: Word;
begin
  for I := 0 to 16 do
    LenCnt[I] := 0;
  CountLen(root); cum := 0;
  for I := 16 downto 1 do
    INC(cum, LenCnt[I] shl (16 - I));
  while cum <> 0 do begin
    Dec(LenCnt[16]);
    for I := 15 downto 1 do
      if LenCnt[I] <> 0 then
      begin
        Dec(LenCnt[I]); INC(LenCnt[SUCC(I)], 2);
        Break;
      end;
    Dec(cum);
  end;
  for I := 16 downto 1 do begin
    k := Pred(Longint(LenCnt[I]));
    while k >= 0 do begin
      Dec(k); Len^[SortPtr^[0]] := I;
      asm
        ADD WORD PTR SortPtr,2; {SortPtr:=addr(SortPtr^[1]);}
      end;
    end;
  end;
end;

procedure DownHeap(I: TwoByteInt);
var
  j, k: TwoByteInt;
begin
  k := Heap^[I]; j := I shl 1;
  while (j <= HeapSize) do begin
    if (j < HeapSize) and (Freq^[Heap^[j]] > Freq^[Heap^[SUCC(j)]]) then INC(j);
    if Freq^[k] <= Freq^[Heap^[j]] then Break;
    Heap^[I] := Heap^[j]; I := j; j := I shl 1;
  end;
  Heap^[I] := k;
end;

procedure MakeCode(n: TwoByteInt; Len: PByte; Code: PWord);
var
  I, k: TwoByteInt;
  start: array[0..17] of Word;
begin
  start[1] := 0;
  for I := 1 to 16 do
    start[SUCC(I)] := (start[I] + LenCnt[I]) shl 1;
  for I := 0 to Pred(n) do begin
    k := Len^[I];
    Code^[I] := start[k];
    INC(start[k]);
  end;
end;

function MakeTree(NParm: TwoByteInt; Freqparm: PWord; LenParm: PByte; Codeparm: PWord): TwoByteInt;
var
  I, j, k, Avail: TwoByteInt;
begin
  n := NParm; Freq := Freqparm; Len := LenParm; Avail := n; HeapSize := 0; Heap^[1] := 0;
  for I := 0 to Pred(n) do begin
    Len^[I] := 0;
    if Freq^[I] <> 0 then
    begin
      INC(HeapSize); Heap^[HeapSize] := I;
    end;
  end;
  if HeapSize < 2 then
  begin
    Codeparm^[Heap^[1]] := 0; MakeTree := Heap^[1];
    Exit;
  end;
  for I := (HeapSize div 2) downto 1 do DownHeap(I);
  SortPtr := Codeparm;
  repeat
    I := Heap^[1];
    if I < n then
    begin
      SortPtr^[0] := I;
      asm
          ADD WORD PTR SortPtr,2; {SortPtr:=addr(SortPtr^[1]);}
      end;
    end;
    Heap^[1] := Heap^[HeapSize]; Dec(HeapSize); DownHeap(1);
    j := Heap^[1];
    if j < n then
    begin
      SortPtr^[0] := j;
      asm
          ADD WORD PTR SortPtr,2; {SortPtr:=addr(SortPtr^[1]);}
      end;
    end;
    k := Avail; INC(Avail);
    Freq^[k] := Freq^[I] + Freq^[j]; Heap^[1] := k; DownHeap(1);
    Left^[k] := I; Right^[k] := j;
  until HeapSize <= 1;
  SortPtr := Codeparm;
  MakeLen(k); MakeCode(NParm, LenParm, Codeparm);
  MakeTree := k;
end;

procedure CountTFreq;
var
  I, k, n, Count: TwoByteInt;
begin
  for I := 0 to Pred(NT) do
    TFreq[I] := 0; n := NC;
  while (n > 0) and (CLen^[Pred(n)] = 0) do
    Dec(n);
  I := 0;
  while I < n do begin
    k := CLen^[I]; INC(I);
    if k = 0 then
    begin
      Count := 1;
      while (I < n) and (CLen^[I] = 0) do begin
        INC(I); INC(Count);
      end;
      if Count <= 2 then
        INC(TFreq[0], Count)
      else
        if Count <= 18 then
        INC(TFreq[1])
      else
        if Count = 19 then
      begin
        INC(TFreq[0]); INC(TFreq[1]);
      end else
        INC(TFreq[2]);
    end else
      INC(TFreq[k + 2]);
  end;
end;

procedure WritePtLen(n, nBit, ispecial: TwoByteInt);
var
  I, k: TwoByteInt;
begin
  while (n > 0) and (PtLen[Pred(n)] = 0) do
    Dec(n);
  PutBits(nBit, n); I := 0;
  while (I < n) do begin
    k := PtLen[I]; INC(I);
    if k <= 6 then
      PutBits(3, k)
    else
    begin
      Dec(k, 3);
      PutBits(k, (1 shl k) - 2);
    end;
    if I = ispecial then
    begin
      while (I < 6) and (PtLen[I] = 0) do
        INC(I);
      PutBits(2, (I - 3) and 3);
    end;
  end;
end;

procedure WriteCLen;
var
  I, k, n, Count: TwoByteInt;
begin
  n := NC;
  while (n > 0) and (CLen^[Pred(n)] = 0) do
    Dec(n);
  PutBits(CBIT, n); I := 0;
  while (I < n) do begin
    k := CLen^[I]; INC(I);
    if k = 0 then
    begin
      Count := 1;
      while (I < n) and (CLen^[I] = 0) do begin
        INC(I); INC(Count);
      end;
      if Count <= 2 then
        for k := 0 to Pred(Count) do
          PutBits(PtLen[0], PtCode[0])
      else
        if Count <= 18 then
      begin
        PutBits(PtLen[1], PtCode[1]);
        PutBits(4, Count - 3);
      end else
        if Count = 19 then
      begin
        PutBits(PtLen[0], PtCode[0]);
        PutBits(PtLen[1], PtCode[1]);
        PutBits(4, 15);
      end else begin
        PutBits(PtLen[2], PtCode[2]);
        PutBits(CBIT, Count - 20);
      end;
    end else
      PutBits(PtLen[k + 2], PtCode[k + 2]);
  end;
end;

procedure EncodeC(c: TwoByteInt);
begin
  PutBits(CLen^[c], CCode[c]);
end;

procedure EncodeP(p: Word);
var
  c, q: Word;
begin
  c := 0; q := p;
  while q <> 0 do begin
    q := q shr 1; INC(c);
  end;
  PutBits(PtLen[c], PtCode[c]);
  if c > 1 then
    PutBits(Pred(c), p and ($FFFF shr (17 - c)));
end;

procedure SendBlock;
var
  I, k, flags, root, Pos, Size: Word;
begin
  flags := 0;
  root := MakeTree(NC, @CFreq, PByte(CLen), @CCode);
  Size := CFreq[root];
  PutBits(16, Size);
  if root >= NC then
  begin
    CountTFreq;
    root := MakeTree(NT, @TFreq, @PtLen, @PtCode);
    if root >= NT then
      WritePtLen(NT, TBIT, 3)
    else
    begin
      PutBits(TBIT, 0);
      PutBits(TBIT, root);
    end;
    WriteCLen;
  end else begin
    PutBits(TBIT, 0);
    PutBits(TBIT, 0);
    PutBits(CBIT, 0);
    PutBits(CBIT, root);
  end;
  root := MakeTree(NP, @PFreq, @PtLen, @PtCode);
  if root >= NP then
    WritePtLen(NP, PBIT, -1)
  else
  begin
    PutBits(PBIT, 0);
    PutBits(PBIT, root);
  end;
  Pos := 0;
  for I := 0 to Pred(Size) do begin
    if (I and 7) = 0 then
    begin
      flags := Buf^[Pos]; INC(Pos);
    end else
      flags := flags shl 1;
    if (flags and (1 shl 7)) <> 0 then
    begin
      k := Buf^[Pos] + (1 shl 8); INC(Pos); EncodeC(k);
      k := Buf^[Pos] shl 8; INC(Pos); INC(k, Buf^[Pos]); INC(Pos); EncodeP(k);
    end else begin
      k := Buf^[Pos]; INC(Pos); EncodeC(k);
    end;
  end;
  for I := 0 to Pred(NC) do
    CFreq[I] := 0;
  for I := 0 to Pred(NP) do
    PFreq[I] := 0;
end;

procedure Output(c, p: Word);
begin
  OutputMask := OutputMask shr 1;
  if OutputMask = 0 then
  begin
    OutputMask := 1 shl 7;
    if (OutputPos >= WINDOWSIZE - 24) then
    begin
      SendBlock; OutputPos := 0;
    end;
    CPos := OutputPos; INC(OutputPos); Buf^[CPos] := 0;
  end;
  Buf^[OutputPos] := c; INC(OutputPos); INC(CFreq[c]);
  if c >= (1 shl 8) then
  begin
    Buf^[CPos] := Buf^[CPos] or OutputMask;
    Buf^[OutputPos] := (p shr 8); INC(OutputPos);
    Buf^[OutputPos] := p; INC(OutputPos); c := 0;
    while p <> 0 do begin
      p := p shr 1; INC(c);
    end;
    INC(PFreq[c]);
  end;
end;

{------------------------------- Lempel-Ziv part ------------------------------}

procedure InitSlide;
var
  I: Word;
begin
  for I := DICSIZ to (DICSIZ + UCHARMAX) do begin
    Level^[I] := 1;
{$IFDEF PERCOLATE}
    Position^[I] := NUL;
{$ENDIF}
  end;
  for I := DICSIZ to Pred(2 * DICSIZ) do
    Parent^[I] := NUL;
  Avail := 1;
  for I := 1 to DICSIZ - 2 do
    Next^[I] := SUCC(I);
  Next^[Pred(DICSIZ)] := NUL;
  for I := (2 * DICSIZ) to MAXHASHVAL do
    Next^[I] := NUL;
end;

{ Hash function }

function Hash(p: TwoByteInt; c: Byte): TwoByteInt;
begin
  Hash := p + (c shl (DICBIT - 9)) + 2 * DICSIZ;
end;

function Child(q: TwoByteInt; c: Byte): TwoByteInt;
var
  r: TwoByteInt;
begin
  r := Next^[Hash(q, c)]; Parent^[NUL] := q;
  while Parent^[r] <> q do
    r := Next^[r];
  Child := r;
end;

procedure MakeChild(q: TwoByteInt; c: Byte; r: TwoByteInt);
var
  h, t: TwoByteInt;
begin
  h := Hash(q, c);
  t := Next^[h]; Next^[h] := r; Next^[r] := t;
  Prev^[t] := r; Prev^[r] := h; Parent^[r] := q;
  INC(ChildCount^[q]);
end;

procedure Split(old: TwoByteInt);
var
  New, t: TwoByteInt;
begin
  New := Avail; Avail := Next^[New];
  ChildCount^[New] := 0;
  t := Prev^[old]; Prev^[New] := t;
  Next^[t] := New;
  t := Next^[old]; Next^[New] := t;
  Prev^[t] := New;
  Parent^[New] := Parent^[old];
  Level^[New] := MatchLen;
  Position^[New] := Pos;
  MakeChild(New, Text^[MatchPos + MatchLen], old);
  MakeChild(New, Text^[Pos + MatchLen], Pos);
end;

procedure InsertNode;
var
  q, r, j, t: TwoByteInt;
  c: Byte;
  t1, t2: PChar;
begin
  if MatchLen >= 4 then
  begin
    Dec(MatchLen);
    r := SUCC(MatchPos) or DICSIZ;
    q := Parent^[r];
    while q = NUL do begin
      r := Next^[r]; q := Parent^[r];
    end;
    while Level^[q] >= MatchLen do begin
      r := q; q := Parent^[q];
    end;
    t := q;
{$IFDEF PERCOLATE}
    while Position^[t] < 0 do begin
      Position^[t] := Pos; t := Parent^[t];
    end;
    if t < DICSIZ then
      Position^[t] := Pos or PERCFLAG;
{$ELSE}
    while t < DICSIZ do begin
      Position^[t] := Pos; t := Parent^[t];
    end;
{$ENDIF}
  end else begin
    q := Text^[Pos] + DICSIZ; c := Text^[SUCC(Pos)]; r := Child(q, c);
    if r = NUL then
    begin
      MakeChild(q, c, Pos); MatchLen := 1;
      Exit;
    end;
    MatchLen := 2;
  end;
  while True do begin
    if r >= DICSIZ then
    begin
      j := MAXMATCH; MatchPos := r;
    end else begin
      j := Level^[r]; MatchPos := Position^[r] and not PERCFLAG;
    end;
    if MatchPos >= Pos then
      Dec(MatchPos, DICSIZ);
    t1 := Addr(Text^[Pos + MatchLen]); t2 := Addr(Text^[MatchPos + MatchLen]);
    while MatchLen < j do begin
      if t1^ <> t2^ then
      begin
        Split(r);
        Exit;
      end;
      INC(MatchLen); INC(t1); INC(t2);
    end;
    if MatchLen >= MAXMATCH then
      Break;
    Position^[r] := Pos; q := r;
    r := Child(q, Ord(t1^));
    if r = NUL then
    begin
      MakeChild(q, Ord(t1^), Pos);
      Exit;
    end;
    INC(MatchLen);
  end;
  t := Prev^[r]; Prev^[Pos] := t; Next^[t] := Pos;
  t := Next^[r]; Next^[Pos] := t; Prev^[t] := Pos;
  Parent^[Pos] := q; Parent^[r] := NUL; Next^[r] := Pos;
end;

procedure DeleteNode;
var
  r, s, t, u: TwoByteInt;
{$IFDEF PERCOLATE}
  q: TwoByteInt;
{$ENDIF}
begin
  if Parent^[Pos] = NUL then
    Exit;
  r := Prev^[Pos]; s := Next^[Pos]; Next^[r] := s; Prev^[s] := r;
  r := Parent^[Pos]; Parent^[Pos] := NUL; Dec(ChildCount^[r]);
  if (r >= DICSIZ) or (ChildCount^[r] > 1) then
    Exit;
{$IFDEF PERCOLATE}
  t := Position^[r] and not PERCFLAG;
{$ELSE}
  t := Position^[r];
{$ENDIF}
  if t >= Pos then
    Dec(t, DICSIZ);
{$IFDEF PERCOLATE}
  s := t; q := Parent^[r]; u := Position^[q];
  while (u and PERCFLAG) <> 0 do begin
    u := u and not PERCFLAG;
    if u >= Pos then
      Dec(u, DICSIZ);
    if u > s then
      s := u;
    Position^[q] := s or DICSIZ; q := Parent^[q]; u := Position^[q];
  end;
  if q < DICSIZ then
  begin
    if u >= Pos then
      Dec(u, DICSIZ);
    if u > s then
      s := u;
    Position^[q] := s or DICSIZ or PERCFLAG;
  end;
{$ENDIF}
  s := Child(r, Text^[t + Level^[r]]);
  t := Prev^[s]; u := Next^[s]; Next^[t] := u; Prev^[u] := t;
  t := Prev^[r]; Next^[t] := s; Prev^[s] := t;
  t := Next^[r]; Prev^[t] := s; Next^[s] := t;
  Parent^[s] := Parent^[r]; Parent^[r] := NUL;
  Next^[r] := Avail; Avail := r;
end;

procedure GetNextMatch;
var
  n: TwoByteInt;
begin
  Dec(Remainder); INC(Pos);
  if Pos = 2 * DICSIZ then
  begin
    Move(Text^[DICSIZ], Text^[0], DICSIZ + MAXMATCH);
    n := InFile.Read(Text^[DICSIZ + MAXMATCH], DICSIZ);
    INC(Remainder, n); Pos := DICSIZ;
  end;
  DeleteNode; InsertNode;
end;

procedure Encode;
var
  LastMatchLen, LastMatchPos: TwoByteInt;
begin
  { initialize encoder variables }
  GetMem(Text, 2 * DICSIZ + MAXMATCH);
  GetMem(Level, DICSIZ + UCHARMAX + 1);
  GetMem(ChildCount, DICSIZ + UCHARMAX + 1);
{$IFDEF PERCOLATE}
  GetMem(Position, (DICSIZ + UCHARMAX + 1) * SizeOf(Word));
{$ELSE}
  GetMem(Position, (DICSIZ) * SizeOf(Word));
{$ENDIF}
  GetMem(Parent, (DICSIZ * 2) * SizeOf(Word));
  GetMem(Prev, (DICSIZ * 2) * SizeOf(Word));
  GetMem(Next, (MAXHASHVAL + 1) * SizeOf(Word));

  Depth := 0;
  InitSlide;
  GetMem(Buf, WINDOWSIZE);
  Buf^[0] := 0;
  FillChar(CFreq, SizeOf(CFreq), 0);
  FillChar(PFreq, SizeOf(PFreq), 0);
  OutputPos := 0; OutputMask := 0; InitPutBits;
  Remainder := InFile.Read(Text^[DICSIZ], DICSIZ + MAXMATCH);
  MatchLen := 0; Pos := DICSIZ; InsertNode;
  if MatchLen > Remainder then
    MatchLen := Remainder;
  while Remainder > 0 do begin
    LastMatchLen := MatchLen; LastMatchPos := MatchPos; GetNextMatch;
    if MatchLen > Remainder then
      MatchLen := Remainder;
    if (MatchLen > LastMatchLen) or (LastMatchLen < THRESHOLD) then
      Output(Text^[Pred(Pos)], 0)
    else
    begin
      Output(LastMatchLen + (UCHARMAX + 1 - THRESHOLD), (Pos - LastMatchPos - 2) and Pred(DICSIZ));
      Dec(LastMatchLen);
      while LastMatchLen > 0 do begin
        GetNextMatch; Dec(LastMatchLen);
      end;
      if MatchLen > Remainder then
        MatchLen := Remainder;
    end;
  end;
  {flush buffers}
  SendBlock; PutBits(7, 0);
  if BufPtr <> 0 then
    OutFile.Write(Buffer^, BufPtr);

  FreeMem(Buf, WINDOWSIZE);
  FreeMem(Next, (MAXHASHVAL + 1) * SizeOf(Word));
  FreeMem(Prev, (DICSIZ * 2) * SizeOf(Word));
  FreeMem(Parent, (DICSIZ * 2) * SizeOf(Word));
{$IFDEF PERCOLATE}
  FreeMem(Position, (DICSIZ + UCHARMAX + 1) * SizeOf(Word));
{$ELSE}
  FreeMem(Position, (DICSIZ) * SizeOf(Word));
{$ENDIF}
  FreeMem(ChildCount, DICSIZ + UCHARMAX + 1);
  FreeMem(Level, DICSIZ + UCHARMAX + 1);
  FreeMem(Text, 2 * DICSIZ + MAXMATCH);
end;

{****************************** LH5 as Unit Procedures ************************}

procedure FreeMemory;
begin
  if CLen <> nil then Dispose(CLen); CLen := nil;
  if CTable <> nil then Dispose(CTable); CTable := nil;
  if Right <> nil then Dispose(Right); Right := nil;
  if Left <> nil then Dispose(Left); Left := nil;
  if Buffer <> nil then Dispose(Buffer); Buffer := nil;
  if Heap <> nil then Dispose(Heap); Heap := nil;
end;

procedure InitMemory;
begin
  {In should be harmless to call FreeMemory here, since it won't free
   unallocated memory (i.e., nil pointers).
   So let's call it in case an exception was thrown at some point and
   memory wasn't entirely freed.}
  FreeMemory;
  New(Buffer);
  New(Left);
  New(Right);
  New(CTable);
  New(CLen);
  FillChar(Buffer^, SizeOf(Buffer^), 0);
  FillChar(Left^, SizeOf(Left^), 0);
  FillChar(Right^, SizeOf(Right^), 0);
  FillChar(CTable^, SizeOf(CTable^), 0);
  FillChar(CLen^, SizeOf(CLen^), 0);

  decode_i := 0;
  BitBuf := 0;
  n := 0;
  HeapSize := 0;
  SubBitBuf := 0;
  BitCount := 0;
  BufPtr := 0;
  FillChar(PtTable, SizeOf(PtTable), 0);
  FillChar(PtLen, SizeOf(PtLen), 0);
  BlockSize := 0;

  { The following variables are used by the compression engine only }
  New(Heap);
  FillChar(Heap^, SizeOf(Heap^), 0);
  FillChar(LenCnt, SizeOf(LenCnt), 0);
  Depth := 0;
  FillChar(CFreq, SizeOf(CFreq), 0);
  FillChar(PFreq, SizeOf(PFreq), 0);
  FillChar(TFreq, SizeOf(TFreq), 0);
  FillChar(CCode, SizeOf(CCode), 0);
  FillChar(PtCode, SizeOf(PtCode), 0);
  CPos := 0;
  OutputPos := 0;
  OutputMask := 0;
  Pos := 0;
  MatchPos := 0;
  Avail := 0;
  Remainder := 0;
  MatchLen := 0;
end;

{******************************** Interface Procedures ************************}

procedure LHACompress(InStr, OutStr: TStream);
begin
  InitMemory;
  try
    InFile := InStr;
    OutFile := OutStr;
    OrigSize := InFile.Size - InFile.Position;
    CompSize := 0;
    OutFile.Write(OrigSize, 4);
    Encode;
  finally
    FreeMemory;
  end;
end;

procedure LHAExpand(InStr, OutStr: TStream); //½âÂë
begin
  try
    InitMemory;
    InFile := InStr;
    OutFile := OutStr;
    CompSize := InFile.Size - InFile.Position;
    InFile.Read(OrigSize, 4);
    Decode;
  finally
    FreeMemory;
  end;
end;

procedure CompBufferL(const InData: Pointer; InSize: LongInt; out OutData: Pointer; out OutSize: LongInt);
var
  InStr, OutStr: TMemoryStream; //TMemoryStream;
begin
  InitMemory;
  OutData := nil;
  OutSize := 0;
  InStr := TMemoryStream.Create;
  OutStr := TMemoryStream.Create;
  try
    InStr.Write(InData^, InSize);
    InStr.Seek(0, soFromBeginning);
    InFile := InStr;
    OutFile := OutStr;
    OrigSize := InFile.Size;
    CompSize := 0;
    OutFile.Write(OrigSize, 4);
    Encode;
    OutSize := OutStr.Size;
    //OutStr.Seek(0, soFromBeginning);
    OutStr.Read(OutData^, OutSize);
  finally
    FreeMemory;
    InStr.Free;
    OutStr.Free;
  end;
end;

procedure UnCompBufferL(const InData: Pointer; InSize: LongInt; out OutData: Pointer; out OutSize: LongInt);
var
  InStr, OutStr: TMemoryStream;
begin
  OutData := nil;
  OutSize := 0;
  InStr := TMemoryStream.Create;
  OutStr := TMemoryStream.Create;
  InitMemory;
  try
    InStr.Write(InData^, InSize);
    InStr.Seek(0, soFromBeginning);
    InFile := InStr;
    OutFile := OutStr;
    CompSize := InFile.Size;
    InFile.Read(OrigSize, 4);
    Decode;

    OutSize := OutStr.Size;
    OutStr.Seek(0, soFromBeginning);
    OutStr.Read(OutData^, OutSize);
  finally
    FreeMemory;
    InStr.Free;
    OutStr.Free;
  end;
end;

initialization
  CLen := nil;
  CTable := nil;
  Right := nil;
  Left := nil;
  Buffer := nil;
  Heap := nil;
end.
