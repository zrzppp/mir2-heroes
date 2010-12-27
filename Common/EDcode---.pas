unit EDcode;

interface

uses
  Windows, SysUtils, Classes, Grobal2;
type
  TKeyByte = array[0..999] of Byte;
  TDesMode = (dmEncry, dmDecry);
function EncodeMessage(sMsg: TDefaultMessage): string;
function DecodeMessage(Str: string): TDefaultMessage;
function EncodeString(Str: string): string;
function DeCodeString(Str: string): string;
function EncodeBuffer(Buf: PChar; bufsize: Integer): string;
procedure DecodeBuffer(Src: string; Buf: PChar; bufsize: Integer);
procedure Decode6BitBuf(sSource: PChar; pbuf: PChar; nSrcLen, nBufLen: Integer);
procedure Encode6BitBuf(pSrc, PDest: PChar; nSrcLen, nDestLen: Integer);
function MakeDefaultMsg(wIdent: Word; nRecog: Integer; wParam, wTag, wSeries: Word): TDefaultMessage;

function CalcFileCRC(sFileName: string): Integer; OVERLOAD;
function CalcFileCRC(sFileName: string; Offset: LongInt): Integer; OVERLOAD;
function CalcBufferCRC(Buffer: PChar; nSize: Integer): Integer;
function Base64EncodeStr(const Value: string): string;
function Base64DecodeStr(const Value: string): string;
function Base64Encode(pInput: Pointer; pOutput: Pointer; Size: LongInt): LongInt;
function Base64Decode(pInput: Pointer; pOutput: Pointer; Size: LongInt): LongInt;

{function EncryStr(Str, Key: string): string;
function DecryStr(Str, Key: string): string;
function EncryStrHex(Str, Key: string): string;
function DecryStrHex(StrHex, Key: string): string;

function EncryStrHex_3DES(Str, Key: string): string;
function DecryStrHex_3DES(StrHex, Key: string): string;
function DecryStr_3DES(Str, Key: string): string;
function EncryStr_3DES(Str, Key: string): string;

function EncryStrHex_XDES(Str, Key: string): string;
function DecryStrHex_XDES(StrHex, Key: string): string;
function DecryStr_XDES(Str, Key: string): string;
function EncryStr_XDES(Str, Key: string): string;

function EncryptEvenNumberString(const AText: string): string;
function DecryptEvenNumberString(const AText: string): string; }



function ReverseString(const AText: string): string;
function Chinese2UniCode(AiChinese: string): Integer;
function GetUniCode(Msg: string): Integer;
{function Encode(Src: string; var Dest: string): Boolean;
function Decode(Src: string; var Dest: string): Boolean;
function DecryptString(Src: string): string;
function EncryptString(Src: string): string;
function EncryptBuffer(Buf: PChar; bufsize: Integer): string;
function DecryptBuffer(Src: string; Buf: PChar; bufsize: Integer): Boolean;}

function HashPJW(const Value: string): Longint;
function Sc_PassWord(Ws: Integer; fh, sz, dx, xx: Boolean): string;
{function _DecryptString(const Src: string): string;
function _EncryptString(const Src: string): string;
function _EncryptBuffer(Buf: PChar; bufsize: Integer): string;
procedure _DecryptBuffer(const Src: string; Buf: PChar; bufsize: Integer);

function SeqEnc(Str: string; Key: Integer; Times: Integer): string;
function SeqDec(Str: string; Key: Integer; Times: Integer): string;}
implementation
const
  B64: array[0..63] of Byte = (65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
    81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108,
    109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 48, 49, 50, 51, 52, 53,
    54, 55, 56, 57, 43, 47);
  Key: array[0..2, 0..7] of Byte = (($FF, $FE, $FF, $FE, $FF, $FE, $FF, $FF), ($FF, $FE, $FF, $FE, $FF, $FE, $FF, $FF), ($FF, $FE, $FF, $FE, $FF, $FE, $FF, $FF));

  BitIP: array[0..63] of Byte = //初始值置IP
  (57, 49, 41, 33, 25, 17, 9, 1,
    59, 51, 43, 35, 27, 19, 11, 3,
    61, 53, 45, 37, 29, 21, 13, 5,
    63, 55, 47, 39, 31, 23, 15, 7,
    56, 48, 40, 32, 24, 16, 8, 0,
    58, 50, 42, 34, 26, 18, 10, 2,
    60, 52, 44, 36, 28, 20, 12, 4,
    62, 54, 46, 38, 30, 22, 14, 6);

  BitCP: array[0..63] of Byte = //逆初始置IP-1
  (39, 7, 47, 15, 55, 23, 63, 31,
    38, 6, 46, 14, 54, 22, 62, 30,
    37, 5, 45, 13, 53, 21, 61, 29,
    36, 4, 44, 12, 52, 20, 60, 28,
    35, 3, 43, 11, 51, 19, 59, 27,
    34, 2, 42, 10, 50, 18, 58, 26,
    33, 1, 41, 9, 49, 17, 57, 25,
    32, 0, 40, 8, 48, 16, 56, 24);

  BitExp: array[0..47] of Integer = // 位选择函数E
  (31, 0, 1, 2, 3, 4, 3, 4, 5, 6, 7, 8, 7, 8, 9, 10,
    11, 12, 11, 12, 13, 14, 15, 16, 15, 16, 17, 18, 19, 20, 19, 20,
    21, 22, 23, 24, 23, 24, 25, 26, 27, 28, 27, 28, 29, 30, 31, 0);

  BitPM: array[0..31] of Byte = //置换函数P
  (15, 6, 19, 20, 28, 11, 27, 16, 0, 14, 22, 25, 4, 17, 30, 9,
    1, 7, 23, 13, 31, 26, 2, 8, 18, 12, 29, 5, 21, 10, 3, 24);

  sBox: array[0..7] of array[0..63] of Byte = //S盒
  ((14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7,
    0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8,
    4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0,
    15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13),

    (15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10,
    3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5,
    0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15,
    13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9),

    (10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8,
    13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1,
    13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7,
    1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12),

    (7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15,
    13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9,
    10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4,
    3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14),

    (2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9,
    14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6,
    4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14,
    11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3),

    (12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11,
    10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8,
    9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6,
    4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13),

    (4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1,
    13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6,
    1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2,
    6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12),

    (13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7,
    1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2,
    7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8,
    2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11));

  BitPMC1: array[0..55] of Byte = //选择置换PC-1
  (56, 48, 40, 32, 24, 16, 8,
    0, 57, 49, 41, 33, 25, 17,
    9, 1, 58, 50, 42, 34, 26,
    18, 10, 2, 59, 51, 43, 35,
    62, 54, 46, 38, 30, 22, 14,
    6, 61, 53, 45, 37, 29, 21,
    13, 5, 60, 52, 44, 36, 28,
    20, 12, 4, 27, 19, 11, 3);

  BitPMC2: array[0..47] of Byte = //选择置换PC-2
  (13, 16, 10, 23, 0, 4,
    2, 27, 14, 5, 20, 9,
    22, 18, 11, 3, 25, 7,
    15, 6, 26, 19, 12, 1,
    40, 51, 30, 36, 46, 54,
    29, 39, 50, 44, 32, 47,
    43, 48, 38, 55, 33, 52,
    45, 41, 49, 35, 28, 31);

var
  subKey: array[0..15] of TKeyByte;

type
  TDynByteArray = array of byte;
const
  SeedA = 5678; ///  常量 ,你可以修改
  SeedB = 5432; ///  常量 ,你可以修改
///  对数组加密

function Crypt(const s: TDynByteArray; Key: Word; const bEncrypt: boolean = true): TDynByteArray; overload;
var
  i: integer;
begin
  SetLength(Result, Length(s));
  for i := Low(s) to High(s) do
  begin
    Result[i] := s[i] xor (key shr 8);
    if bEncrypt then
      Key := (Result[i] + key) * SeedA + SeedB
    else
      Key := (s[i] + Key) * SeedA + SeedB;
  end;
end;
///  字符串

function Crypt(const s: string; Key: Word; const bEncrypt: boolean = True): string; overload;
var
  i: integer;
  ps, pr: ^byte;
begin
  SetLength(Result, Length(s));
  ps := @s[1];
  pr := @Result[1];
  for i := 1 to length(s) do
  begin
    pr^ := ps^ xor (Key shr 8);
    if bEncrypt then
      Key := (pr^ + Key) * SeedA + SeedB
    else
      Key := (ps^ + Key) * SeedA + SeedB;
    pr := pointer(integer(pr) + 1);
    ps := pointer(integer(ps) + 1);
  end
end;
///  也可以对记录进行加密 ,只要把 TResultData 改成你的记录类型即可！！！！！！
{function Crypt(const s: TResultData; Key: Word; const bEncrypt: boolean = True): TResultData; overload;
var
  i                 : integer;
  ps, pr            : ^byte;
begin
  ps := @s;
  pr := @Result;
  for i := 1 to SizeOf(s) do
  begin
    pr^ := ps^ xor (Key shr 8);
    if bEncrypt then
      Key := (pr^ + Key) * SeedA + SeedB
    else
      Key := (ps^ + Key) * SeedA + SeedB;
    pr := pointer(integer(pr) + 1);
    ps := pointer(integer(ps) + 1);
  end;
end;
}

function cryptstr(const s: string; stype: dword): string;
var
  i: integer;
  fkey: integer;
begin
  result := '';
  case stype of
    0:
      begin
        randomize;
        fkey := random($FF);
        for i := 1 to length(s) do
          result := result + chr(ord(s[i]) xor i xor fkey);
        result := result + char(fkey);
      end;
    1:
      begin
        fkey := ord(s[length(s)]);
        for i := 1 to length(s) - 1 do
          result := result + chr(ord(s[i]) xor i xor fkey);
      end;
  end;
end;

function HashPJW(const Value: string): Longint;
var
  I: Integer;
  G: Longint;
begin
  Result := 0;
  for I := 1 to Length(Value) do begin
    Result := (Result shl 4) + Ord(Value[I]);
    G := Result and $F0000000;
    if G <> 0 then
      Result := (Result xor (G shr 24)) xor G;
  end;
end;

function ReverseString(const AText: string): string;
var
  I: Integer;
  P: PChar;
begin
  SetLength(Result, Length(AText));
  P := PChar(Result);
  for I := Length(AText) downto 1 do
  begin
    P^ := AText[I];
    Inc(P);
  end;
end;

function EncryptEvenNumberString(const AText: string): string;
var
  I: Integer;
  P1, P2: PChar;
begin
  SetLength(Result, Length(AText));
  P1 := PChar(Result);
  P2 := @Result[Length(AText) div 2 + 1];
  for I := 1 to Length(AText) do begin //按照奇偶排列
    if (I <> 1) and (I mod 2 = 0) then begin
      P1^ := AText[I];
      Inc(P1);
    end else begin
      P2^ := AText[I];
      Inc(P2);
    end;
  end;
end;

function DecryptEvenNumberString(const AText: string): string;
var
  I: Integer;
  P, P1, P2: PChar;
begin
  SetLength(Result, Length(AText));
  P := PChar(Result);
  P1 := PChar(AText);
  P2 := @AText[Length(AText) div 2 + 1];
  for I := 1 to Length(AText) do begin //按照奇偶排列
    if (I <> 1) and (I mod 2 = 0) then begin
      P^ := P1^;
      Inc(P);
      Inc(P1);
    end else begin
      P^ := P2^;
      Inc(P);
      Inc(P2);
    end;
  end;
end;

function Chinese2UniCode(AiChinese: string): Integer;
var
  Ch, cl: string[2];
  a: array[1..2] of Char;
begin
  StringToWideChar(Copy(AiChinese, 1, 2), @(a[1]), 2);
  Ch := IntToHex(Integer(a[2]), 2);
  cl := IntToHex(Integer(a[1]), 2);
  Result := StrToInt('$' + Ch + cl);
end;

function GetUniCode(Msg: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 1 to Length(Msg) do begin
    Result := Result + Chinese2UniCode(Msg[I]) * I;
  end;
end;

function DecryptString(Src: string): string;
begin
  //if not Decode(Src, Result) then Result := '';
end;

function EncryptString(Src: string): string;
begin
  //if not Encode(Src, Result) then Result := '';
end;

function EncryptBuffer(Buf: PChar; bufsize: Integer): string;
var
  Src: string;
begin
  SetLength(Src, bufsize + 1);
  Move(Buf^, Src[1], bufsize + 1);
  Result := EncryptString(Src);
end;

function DecryptBuffer(Src: string; Buf: PChar; bufsize: Integer): Boolean;
var
  Dest: string;
begin
 { Result := False;
  if Decode(Src, Dest) then begin
    if Dest <> '' then begin
      Move(Dest[1], Buf^, bufsize);
      Result := True;
    end;
  end; }
end;

function Encode(Src: string; var Dest: string): Boolean;
var
  sDest, sEncodeStr: string;
  I, nIndex1, nIndex2, nLen: Integer;
begin
 { Result := False;
  Dest := '';
  try
    if Src <> '' then begin
      sDest := Base64EncodeStr(ReverseString(Src));
      sDest := ReverseString(EncryStrHex(sDest, IntToStr(718846558)));
      nLen := Length(sDest);
      nIndex1 := 1;
      nIndex2 := nLen div 2 + 1;
      SetLength(sEncodeStr, nLen);
      for I := 1 to nLen do begin //按照奇偶排列
        if (I <> 1) and (I mod 2 = 0) then begin
          sEncodeStr[nIndex1] := sDest[I];
          Inc(nIndex1);
        end else begin
          sEncodeStr[nIndex2] := sDest[I];
          Inc(nIndex2);
        end;
      end;

      Dest := ReverseString(sEncodeStr);
    end;
    Result := True;
  except
    Result := False;
  end; }
end;

function Decode(Src: string; var Dest: string): Boolean;
var
  I, nIndex1, nIndex2, nLen: Integer;
  sDest, sDecodeStr: string;
begin
{  Result := False;
  try
    Dest := '';
    sDest := ReverseString(Src);
    if sDest <> '' then begin
      nLen := Length(sDest);
      nIndex1 := 1;
      nIndex2 := nLen div 2 + 1;

      SetLength(sDecodeStr, nLen);
      for I := 1 to nLen do begin //按照奇偶排列
        if (I <> 1) and (I mod 2 = 0) then begin
          sDecodeStr[I] := sDest[nIndex1];
          Inc(nIndex1);
        end else begin
          sDecodeStr[I] := sDest[nIndex2];
          Inc(nIndex2);
        end;
      end;

      sDest := ReverseString(sDecodeStr);
      try
        sDest := DecryStrHex(sDest, IntToStr(718846558));
      except
        Exit;
      end;

      Dest := ReverseString(Base64DecodeStr(sDest));
      Result := True;
    end;
  except
    Result := False;
  end;  }
end;

function Sc_PassWord(Ws: Integer; fh, sz, dx, xx: Boolean): string;
var
  I: Integer;
  templist, templist1, templist2, templist3, templist4: tstringlist;
begin
  templist := tstringlist.Create;
  templist1 := tstringlist.Create;
  templist2 := tstringlist.Create;
  templist3 := tstringlist.Create;
  templist4 := tstringlist.Create;
  for I := 33 to 47 do templist1.Add(Chr(I)); //符号
  for I := 48 to 57 do templist2.Add(Chr(I)); //数字
  for I := 58 to 64 do templist1.Add(Chr(I)); //符号
  for I := 65 to 90 do templist3.Add(Chr(I)); //大写字母
  for I := 91 to 96 do templist1.Add(Chr(I)); //符号
  for I := 97 to 122 do templist4.Add(Chr(I)); //小写字母
  for I := 123 to 126 do templist1.Add(Chr(I)); //符号
  if fh then templist.Text := templist.Text + templist1.Text;
  if sz then templist.Text := templist.Text + templist2.Text;
  if dx then templist.Text := templist.Text + templist3.Text;
  if xx then templist.Text := templist.Text + templist4.Text;
  if templist.Count = 0 then begin
    Result := '';
    Exit;
  end;
  Randomize;
  Result := '';
  while Length(Result) < Ws do begin
    I := 0;
    I := Random(templist.Count);
    Result := Result + templist[I];
  end;
end;

function SeqEnc(Str: string; Key: Integer; Times: Integer): string;
var
  i, c, n: Integer;
  Key1, Key2, Key3, Key4: Byte;
begin
  Result := Str;
  n := Length(Str);
  if n = 0 then Exit;
  Key4 := Byte(Key shr 24);
  Key3 := Byte(Key shr 16);
  Key2 := Byte(Key shr 8);
  Key1 := Byte(Key);
  for c := Times - 1 downto 0 do begin
    Result[1] := Char(Byte(Result[1]) + Key3);
    for i := 2 to n do
      Result[i] := Char((Byte(Result[i - 1]) + Byte(Result[i])) xor Key1);
    Result[n] := Char(Byte(Result[n]) + Key4);
    for i := n - 1 downto 1 do
      Result[i] := Char((Byte(Result[i + 1]) + Byte(Result[i])) xor Key2);
  end;
end;

function SeqDec(Str: string; Key: Integer; Times: Integer): string;
var
  i, c, n: Integer;
  Key1, Key2, Key3, Key4: Byte;
begin
  Result := Str;
  n := Length(Str);
  if n = 0 then Exit;
  Key4 := Byte(Key shr 24);
  Key3 := Byte(Key shr 16);
  Key2 := Byte(Key shr 8);
  Key1 := Byte(Key);
  for c := Times - 1 downto 0 do begin
    for i := 1 to n - 1 do
      Result[i] := Char(Byte(Result[i]) xor Key2 - Byte(Result[i + 1]));
    Result[n] := Char(Byte(Result[n]) - Key4);
    for i := n downto 2 do
      Result[i] := Char(Byte(Result[i]) xor Key1 - Byte(Result[i - 1]));
    Result[1] := Char(Byte(Result[1]) - Key3);
  end;
end;

function _DecryptString(const Src: string): string;
var
  sKey: string;
  sText: string;
begin
  {Result := '';
  if Src = '' then Exit;
  sText := DecryStr_3DES(Base64DecodeStr(Src),IntToStr(2008082220080822));
  sKey := DecryptEvenNumberString(DecryStr_3DES(Copy(sText, 1, 8) + Copy(sText, Length(sText) - 8 + 1, 8), IntToStr(2008082220080822)));
  sText := Copy(sText, 9, Length(sText) - 16);
  sText := DecryStr(sText, sKey);
  sKey := ReverseString(sKey);
  sText := EncryStr(sText, sKey);
  sKey := ReverseString(sKey);
  Result := Base64DecodeStr(DecryStr(sText, sKey));}
end;

function _EncryptString(const Src: string): string;
var
  I: Integer;
  sKey: string;
  sText: string;
  P: PChar;
begin
 { Result := '';
  if Src = '' then Exit;

  SetLength(sKey, 16);
  P := PChar(sKey);
  for I := 1 to 16 do begin
    P^ := Chr(B64[Random(63)]);
    Inc(P);
  end;

  sText := Base64EncodeStr(Src);
  sText := EncryStr(sText, sKey);

  sKey := ReverseString(sKey);
  sText := DecryStr(sText, sKey);

  sKey := ReverseString(sKey);
  sText := EncryStr(sText, sKey);

  sKey := EncryStr_3DES(EncryptEvenNumberString(sKey), IntToStr(2008082220080822));

  sText := Copy(sKey, 1, Length(sKey) div 2) + sText + Copy(sKey, Length(sKey) div 2 + 1, Length(sKey) div 2); //把密码保存到2边
  Result := Base64EncodeStr(EncryStr_3DES(sText, IntToStr(2008082220080822))); }
end;

function _EncryptBuffer(Buf: PChar; bufsize: Integer): string;
var
  Src: string;
begin
  SetLength(Src, bufsize + 1);
  Move(Buf^, Src[1], bufsize + 1);
  Result := _EncryptString(Src);
end;

procedure _DecryptBuffer(const Src: string; Buf: PChar; bufsize: Integer);
var
  Dest: string;
begin
  Dest := _DecryptString(Src);
  if Dest <> '' then begin
    Move(Dest[1], Buf^, bufsize);
  end;
end;

function CalcFileCRC(sFileName: string): Integer;
var
  I: Integer;
  nFileHandle: Integer;
  nFileSize, nBuffSize: Integer;
  Buffer: PChar;
  Int: ^Integer;
  nCrc: Integer;
begin
  Result := 0;
  if not FileExists(sFileName) then Exit;
  nFileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
  if nFileHandle = 0 then
    Exit;
  nFileSize := FileSeek(nFileHandle, 0, 2);
  nBuffSize := (nFileSize div 4) * 4;
  GetMem(Buffer, nBuffSize);
  FillChar(Buffer^, nBuffSize, 0);
  FileSeek(nFileHandle, 0, 0);
  FileRead(nFileHandle, Buffer^, nBuffSize);
  FileClose(nFileHandle);
  Int := Pointer(Buffer);
  nCrc := 0;
  Exception.Create(IntToStr(SizeOf(Integer)));
  for I := 0 to nBuffSize div 4 - 1 do begin
    nCrc := nCrc xor Int^;
    Int := Pointer(Integer(Int) + 4);
  end;
  FreeMem(Buffer);
  Result := nCrc;
end;

function CalcFileCRC(sFileName: string; Offset: LongInt): Integer;
var
  I: Integer;
  nFileHandle: Integer;
  nFileSize, nBuffSize: Integer;
  Buffer: PChar;
  Int: ^Integer;
  nCrc: Integer;
begin
  Result := 0;
  if not FileExists(sFileName) then Exit;
  nFileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
  if nFileHandle = 0 then
    Exit;
  nFileSize := FileSeek(nFileHandle, Offset, 2);
  nBuffSize := (nFileSize div 4) * 4;
  GetMem(Buffer, nBuffSize);
  FillChar(Buffer^, nBuffSize, 0);
  FileSeek(nFileHandle, 0, 0);
  FileRead(nFileHandle, Buffer^, nBuffSize);
  FileClose(nFileHandle);
  Int := Pointer(Buffer);
  nCrc := 0;
  Exception.Create(IntToStr(SizeOf(Integer)));
  for I := 0 to nBuffSize div 4 - 1 do begin
    nCrc := nCrc xor Int^;
    Int := Pointer(Integer(Int) + 4);
  end;
  FreeMem(Buffer);
  Result := nCrc;
end;


function CalcBufferCRC(Buffer: PChar; nSize: Integer): Integer;
var
  I: Integer;
  Int: ^Integer;
  nCrc: Integer;
begin
  Int := Pointer(Buffer);
  nCrc := 0;
  for I := 0 to nSize div 4 - 1 do begin
    nCrc := nCrc xor Int^;
    Int := Pointer(Integer(Int) + 4);
  end;
  Result := nCrc;
end;

function Base64Encode(pInput: Pointer; pOutput: Pointer; Size: LongInt): LongInt;
var
  I, iptr, optr: Integer;
  Input, Output: PByteArray;
begin
  Input := PByteArray(pInput); Output := PByteArray(pOutput);
  iptr := 0; optr := 0;
  for I := 1 to (Size div 3) do begin
    Output^[optr + 0] := B64[Input^[iptr] shr 2];
    Output^[optr + 1] := B64[((Input^[iptr] and 3) shl 4) + (Input^[iptr + 1] shr 4)];
    Output^[optr + 2] := B64[((Input^[iptr + 1] and 15) shl 2) + (Input^[iptr + 2] shr 6)];
    Output^[optr + 3] := B64[Input^[iptr + 2] and 63];
    Inc(optr, 4); Inc(iptr, 3);
  end;
  case (Size mod 3) of
    1: begin
        Output^[optr + 0] := B64[Input^[iptr] shr 2];
        Output^[optr + 1] := B64[(Input^[iptr] and 3) shl 4];
        Output^[optr + 2] := Byte('=');
        Output^[optr + 3] := Byte('=');
      end;
    2: begin
        Output^[optr + 0] := B64[Input^[iptr] shr 2];
        Output^[optr + 1] := B64[((Input^[iptr] and 3) shl 4) + (Input^[iptr + 1] shr 4)];
        Output^[optr + 2] := B64[(Input^[iptr + 1] and 15) shl 2];
        Output^[optr + 3] := Byte('=');
      end;
  end;
  Result := ((Size + 2) div 3) * 4;
end;

function Base64EncodeStr(const Value: string): string;
begin
  SetLength(Result, ((Length(Value) + 2) div 3) * 4);
  Base64Encode(@Value[1], @Result[1], Length(Value));
end;

function Base64Decode(pInput: Pointer; pOutput: Pointer; Size: LongInt): LongInt;
var
  I, J, iptr, optr: Integer;
  temp: array[0..3] of Byte;
  Input, Output: PByteArray;
begin
  Input := PByteArray(pInput); Output := PByteArray(pOutput);
  iptr := 0; optr := 0;
  Result := 0;
  for I := 1 to (Size div 4) do begin
    for J := 0 to 3 do begin
      case Input^[iptr] of
        65..90: temp[J] := Input^[iptr] - Ord('A');
        97..122: temp[J] := Input^[iptr] - Ord('a') + 26;
        48..57: temp[J] := Input^[iptr] - Ord('0') + 52;
        43: temp[J] := 62;
        47: temp[J] := 63;
        61: temp[J] := $FF;
      end;
      Inc(iptr);
    end;
    Output^[optr] := (temp[0] shl 2) or (temp[1] shr 4);
    Result := optr + 1;
    if (temp[2] <> $FF) and (temp[3] = $FF) then begin
      Output^[optr + 1] := (temp[1] shl 4) or (temp[2] shr 2);
      Result := optr + 2;
      Inc(optr)
    end
    else if (temp[2] <> $FF) then begin
      Output^[optr + 1] := (temp[1] shl 4) or (temp[2] shr 2);
      Output^[optr + 2] := (temp[2] shl 6) or temp[3];
      Result := optr + 3;
      Inc(optr, 2);
    end;
    Inc(optr);
  end;
end;

function Base64DecodeStr(const Value: string): string;
begin
  SetLength(Result, (Length(Value) div 4) * 3);
  SetLength(Result, Base64Decode(@Value[1], @Result[1], Length(Value)));
end;

function MakeDefaultMsg(wIdent: Word; nRecog: Integer; wParam, wTag, wSeries: Word): TDefaultMessage;
begin
  Result.Recog := nRecog;
  Result.Ident := wIdent;
  Result.Param := wParam;
  Result.Tag := wTag;
  Result.Series := wSeries;
end;

procedure Encode6BitBuf(pSrc, PDest: PChar; nSrcLen, nDestLen: Integer);
var
  I: Integer;
  nRestCount: Integer;
  nDestPos: Integer;
  btMade: Byte;
  btCh: Byte;
  btRest: Byte;
begin
  nRestCount := 0;
  btRest := 0;
  nDestPos := 0;
  for I := 0 to nSrcLen - 1 do begin
    if nDestPos >= nDestLen then Break;
    btCh := Byte(pSrc[I]);
    btMade := Byte((btRest or (btCh shr (2 + nRestCount))) and $3F);
    btRest := Byte(((btCh shl (8 - (2 + nRestCount))) shr 2) and $3F);
    Inc(nRestCount, 2);

    if nRestCount < 6 then begin
      PDest[nDestPos] := Char(btMade + $3C);
      Inc(nDestPos);
    end else begin
      if nDestPos < nDestLen - 1 then begin
        PDest[nDestPos] := Char(btMade + $3C);
        PDest[nDestPos + 1] := Char(btRest + $3C);
        Inc(nDestPos, 2);
      end else begin
        PDest[nDestPos] := Char(btMade + $3C);
        Inc(nDestPos);
      end;
      nRestCount := 0;
      btRest := 0;
    end;
  end;
  if nRestCount > 0 then begin
    PDest[nDestPos] := Char(btRest + $3C);
    Inc(nDestPos);
  end;
  PDest[nDestPos] := #0;
end;

procedure Decode6BitBuf(sSource: PChar; pbuf: PChar; nSrcLen, nBufLen: Integer);
const
  Masks: array[2..6] of Byte = ($FC, $F8, $F0, $E0, $C0);
  //($FE, $FC, $F8, $F0, $E0, $C0, $80, $00);
var
  I, {nLen,} nBitPos, nMadeBit, nBufPos: Integer;
  btCh, btTmp, btByte: Byte;
begin
  //  nLen:= Length (sSource);
  nBitPos := 2;
  nMadeBit := 0;
  nBufPos := 0;
  btTmp := 0;
  for I := 0 to nSrcLen - 1 do begin
    if Integer(sSource[I]) - $3C >= 0 then
      btCh := Byte(sSource[I]) - $3C
    else begin
      nBufPos := 0;
      Break;
    end;
    if nBufPos >= nBufLen then Break;
    if (nMadeBit + 6) >= 8 then begin
      btByte := Byte(btTmp or ((btCh and $3F) shr (6 - nBitPos)));
      pbuf[nBufPos] := Char(btByte);
      Inc(nBufPos);
      nMadeBit := 0;
      if nBitPos < 6 then Inc(nBitPos, 2)
      else begin
        nBitPos := 2;
        Continue;
      end;
    end;
    btTmp := Byte(Byte(btCh shl nBitPos) and Masks[nBitPos]); // #### ##--
    Inc(nMadeBit, 8 - nBitPos);
  end;
  pbuf[nBufPos] := #0;
end;

function DecodeMessage(Str: string): TDefaultMessage;
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
  Msg: TDefaultMessage;
begin
  Decode6BitBuf(PChar(Str), @EncBuf, Length(Str), SizeOf(EncBuf));
  Move(EncBuf, Msg, SizeOf(TDefaultMessage));
  Result := Msg;
end;

function DeCodeString(Str: string): string;
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  Decode6BitBuf(PChar(Str), @EncBuf, Length(Str), SizeOf(EncBuf));
  Result := StrPas(EncBuf);
end;

procedure DecodeBuffer(Src: string; Buf: PChar; bufsize: Integer);
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  Decode6BitBuf(PChar(Src), @EncBuf, Length(Src), SizeOf(EncBuf));
  Move(EncBuf, Buf^, bufsize);
end;

function EncodeMessage(sMsg: TDefaultMessage): string;
var
  EncBuf, TempBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  Move(sMsg, TempBuf, SizeOf(TDefaultMessage));
  Encode6BitBuf(@TempBuf, @EncBuf, SizeOf(TDefaultMessage), SizeOf(EncBuf));
  Result := StrPas(EncBuf);
end;

function EncodeString(Str: string): string;
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  Encode6BitBuf(PChar(Str), @EncBuf, Length(Str), SizeOf(EncBuf));
  Result := StrPas(EncBuf);
end;

function EncodeBuffer(Buf: PChar; bufsize: Integer): string;
var
  EncBuf, TempBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  if bufsize < BUFFERSIZE then begin
    Move(Buf^, TempBuf, bufsize);
    Encode6BitBuf(@TempBuf, @EncBuf, bufsize, SizeOf(EncBuf));
    Result := StrPas(EncBuf);
  end else Result := '';
end;
{------------------------------------------------------------------------------}

procedure initPermutation(var inData: array of Byte);
var
  newData: array[0..7] of Byte;
  I: Integer;
begin
  FillChar(newData, 8, 0);
  for I := 0 to 63 do
    if (inData[BitIP[I] shr 3] and (1 shl (7 - (BitIP[I] and $07)))) <> 0 then
      newData[I shr 3] := newData[I shr 3] or (1 shl (7 - (I and $07)));
  for I := 0 to 7 do inData[I] := newData[I];
end;

procedure conversePermutation(var inData: array of Byte);
var
  newData: array[0..7] of Byte;
  I: Integer;
begin
  FillChar(newData, 8, 0);
  for I := 0 to 63 do
    if (inData[BitCP[I] shr 3] and (1 shl (7 - (BitCP[I] and $07)))) <> 0 then
      newData[I shr 3] := newData[I shr 3] or (1 shl (7 - (I and $07)));
  for I := 0 to 7 do inData[I] := newData[I];
end;

procedure Expand(inData: array of Byte; var outData: array of Byte);
var
  I: Integer;
begin
  FillChar(outData, 6, 0);
  for I := 0 to 47 do
    if (inData[BitExp[I] shr 3] and (1 shl (7 - (BitExp[I] and $07)))) <> 0 then
      outData[I shr 3] := outData[I shr 3] or (1 shl (7 - (I and $07)));
end;

procedure permutation(var inData: array of Byte);
var
  newData: array[0..3] of Byte;
  I: Integer;
begin
  FillChar(newData, 4, 0);
  for I := 0 to 31 do
    if (inData[BitPM[I] shr 3] and (1 shl (7 - (BitPM[I] and $07)))) <> 0 then
      newData[I shr 3] := newData[I shr 3] or (1 shl (7 - (I and $07)));
  for I := 0 to 3 do inData[I] := newData[I];
end;

function si(s, inByte: Byte): Byte;
var
  c: Byte;
begin
  c := (inByte and $20) or ((inByte and $1E) shr 1) or
    ((inByte and $01) shl 4);
  Result := (sBox[s][c] and $0F);
end;

procedure permutationChoose1(inData: array of Byte;
  var outData: array of Byte);
var
  I: Integer;
begin
  FillChar(outData, 7, 0);
  for I := 0 to 55 do
    if (inData[BitPMC1[I] shr 3] and (1 shl (7 - (BitPMC1[I] and $07)))) <> 0 then
      outData[I shr 3] := outData[I shr 3] or (1 shl (7 - (I and $07)));
end;

procedure permutationChoose2(inData: array of Byte;
  var outData: array of Byte);
var
  I: Integer;
begin
  FillChar(outData, 6, 0);
  for I := 0 to 47 do
    if (inData[BitPMC2[I] shr 3] and (1 shl (7 - (BitPMC2[I] and $07)))) <> 0 then
      outData[I shr 3] := outData[I shr 3] or (1 shl (7 - (I and $07)));
end;

procedure cycleMove(var inData: array of Byte; bitMove: Byte);
var
  I: Integer;
begin
  for I := 0 to bitMove - 1 do begin
    inData[0] := (inData[0] shl 1) or (inData[1] shr 7);
    inData[1] := (inData[1] shl 1) or (inData[2] shr 7);
    inData[2] := (inData[2] shl 1) or (inData[3] shr 7);
    inData[3] := (inData[3] shl 1) or ((inData[0] and $10) shr 4);
    inData[0] := (inData[0] and $0F);
  end;
end;

procedure makeKey(inKey: array of Byte; var outKey: array of TKeyByte);
const
  bitDisplace: array[0..15] of Byte =
  (1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1);
var
  outData56: array[0..6] of Byte;
  key28l: array[0..3] of Byte;
  key28r: array[0..3] of Byte;
  key56o: array[0..6] of Byte;
  I: Integer;
begin
  permutationChoose1(inKey, outData56);

  key28l[0] := outData56[0] shr 4;
  key28l[1] := (outData56[0] shl 4) or (outData56[1] shr 4);
  key28l[2] := (outData56[1] shl 4) or (outData56[2] shr 4);
  key28l[3] := (outData56[2] shl 4) or (outData56[3] shr 4);
  key28r[0] := outData56[3] and $0F;
  key28r[1] := outData56[4];
  key28r[2] := outData56[5];
  key28r[3] := outData56[6];

  for I := 0 to 15 do begin
    cycleMove(key28l, bitDisplace[I]);
    cycleMove(key28r, bitDisplace[I]);
    key56o[0] := (key28l[0] shl 4) or (key28l[1] shr 4);
    key56o[1] := (key28l[1] shl 4) or (key28l[2] shr 4);
    key56o[2] := (key28l[2] shl 4) or (key28l[3] shr 4);
    key56o[3] := (key28l[3] shl 4) or (key28r[0]);
    key56o[4] := key28r[1];
    key56o[5] := key28r[2];
    key56o[6] := key28r[3];
    permutationChoose2(key56o, outKey[I]);
  end;
end;

procedure Encry(inData, subKey: array of Byte;
  var outData: array of Byte);
var
  outBuf: array[0..5] of Byte;
  Buf: array[0..7] of Byte;
  I: Integer;
begin
  Expand(inData, outBuf);
  for I := 0 to 5 do outBuf[I] := outBuf[I] xor subKey[I];
  Buf[0] := outBuf[0] shr 2;
  Buf[1] := ((outBuf[0] and $03) shl 4) or (outBuf[1] shr 4);
  Buf[2] := ((outBuf[1] and $0F) shl 2) or (outBuf[2] shr 6);
  Buf[3] := outBuf[2] and $3F;
  Buf[4] := outBuf[3] shr 2;
  Buf[5] := ((outBuf[3] and $03) shl 4) or (outBuf[4] shr 4);
  Buf[6] := ((outBuf[4] and $0F) shl 2) or (outBuf[5] shr 6);
  Buf[7] := outBuf[5] and $3F;
  for I := 0 to 7 do Buf[I] := si(I, Buf[I]);
  for I := 0 to 3 do outBuf[I] := (Buf[I * 2] shl 4) or Buf[I * 2 + 1];
  permutation(outBuf);
  for I := 0 to 3 do outData[I] := outBuf[I];
end;

procedure desData(desMode: TDesMode;
  inData: array of Byte; var outData: array of Byte);
// inData, outData 都为8Bytes，否则出错
var
  I, J: Integer;
  temp, Buf: array[0..3] of Byte;
begin
  for I := 0 to 7 do outData[I] := inData[I];
  initPermutation(outData);
  if desMode = dmEncry then begin
    for I := 0 to 15 do begin
      for J := 0 to 3 do temp[J] := outData[J]; //temp = Ln
      for J := 0 to 3 do outData[J] := outData[J + 4]; //Ln+1 = Rn
      Encry(outData, subKey[I], Buf); //Rn ==Kn==> buf
      for J := 0 to 3 do outData[J + 4] := temp[J] xor Buf[J]; //Rn+1 = Ln^buf
    end;

    for J := 0 to 3 do temp[J] := outData[J + 4];
    for J := 0 to 3 do outData[J + 4] := outData[J];
    for J := 0 to 3 do outData[J] := temp[J];
  end
  else if desMode = dmDecry then begin
    for I := 15 downto 0 do begin
      for J := 0 to 3 do temp[J] := outData[J];
      for J := 0 to 3 do outData[J] := outData[J + 4];
      Encry(outData, subKey[I], Buf);
      for J := 0 to 3 do outData[J + 4] := temp[J] xor Buf[J];
    end;
    for J := 0 to 3 do temp[J] := outData[J + 4];
    for J := 0 to 3 do outData[J + 4] := outData[J];
    for J := 0 to 3 do outData[J] := temp[J];
  end;
  conversePermutation(outData);
end;

//////////////////////////////////////////////////////////////

function EncryStr(Str, Key: string): string;
var
  StrByte, OutByte, KeyByte: array[0..7] of Byte;
  StrResult: string;
  I, J: Integer;
begin
  if (Length(Str) > 0) and (Ord(Str[Length(Str)]) = 0) then
    raise Exception.Create('Error: the last char is NULL char.');
  if Length(Key) < 8 then
    while Length(Key) < 8 do Key := Key + Chr(0);
  while Length(Str) mod 8 <> 0 do Str := Str + Chr(0);

  for J := 0 to 7 do KeyByte[J] := Ord(Key[J + 1]);
  makeKey(KeyByte, subKey);

  StrResult := '';

  for I := 0 to Length(Str) div 8 - 1 do begin
    for J := 0 to 7 do
      StrByte[J] := Ord(Str[I * 8 + J + 1]);
    desData(dmEncry, StrByte, OutByte);
    for J := 0 to 7 do
      StrResult := StrResult + Chr(OutByte[J]);
  end;

  Result := StrResult;
end;

function DecryStr(Str, Key: string): string;
var
  StrByte, OutByte, KeyByte: array[0..7] of Byte;
  StrResult: string;
  I, J: Integer;
begin
  if Length(Key) < 8 then
    while Length(Key) < 8 do Key := Key + Chr(0);

  for J := 0 to 7 do KeyByte[J] := Ord(Key[J + 1]);
  makeKey(KeyByte, subKey);

  StrResult := '';

  for I := 0 to Length(Str) div 8 - 1 do begin
    for J := 0 to 7 do StrByte[J] := Ord(Str[I * 8 + J + 1]);
    desData(dmDecry, StrByte, OutByte);
    for J := 0 to 7 do
      StrResult := StrResult + Chr(OutByte[J]);
  end;
  while (Length(StrResult) > 0) and
    (Ord(StrResult[Length(StrResult)]) = 0) do
    Delete(StrResult, Length(StrResult), 1);
  Result := StrResult;
end;

///////////////////////////////////////////////////////////

function EncryStrHex_3DES(Str, Key: string): string;
var
  StrResult, TempResult, temp: string;
  I: Integer;
begin
  {TempResult := EncryStr_3DES(Str, Key);
  StrResult := '';
  for I := 0 to Length(TempResult) - 1 do begin
    temp := Format('%x', [Ord(TempResult[I + 1])]);
    if Length(temp) = 1 then temp := '0' + temp;
    StrResult := StrResult + temp;
  end;
  Result := StrResult; }
end;

function DecryStrHex_3DES(StrHex, Key: string): string;
  function HexToInt(Hex: string): Integer;
  var
    I, Res: Integer;
    Ch: Char;
  begin
    Res := 0;
    for I := 0 to Length(Hex) - 1 do begin
      Ch := Hex[I + 1];
      if (Ch >= '0') and (Ch <= '9') then
        Res := Res * 16 + Ord(Ch) - Ord('0')
      else if (Ch >= 'A') and (Ch <= 'F') then
        Res := Res * 16 + Ord(Ch) - Ord('A') + 10
      else if (Ch >= 'a') and (Ch <= 'f') then
        Res := Res * 16 + Ord(Ch) - Ord('a') + 10
      else raise Exception.Create('Error: not a Hex String');
    end;
    Result := Res;
  end;

var
  Str, temp: string;
  I: Integer;
begin
  {Str := '';
  for I := 0 to Length(StrHex) div 2 - 1 do begin
    temp := Copy(StrHex, I * 2 + 1, 2);
    Str := Str + Chr(HexToInt(temp));
  end;
  Result := DecryStr_3DES(Str, Key); }
end;

function EncryStrHex(Str, Key: string): string;
var
  StrResult, TempResult, temp: string;
  I: Integer;
begin
 { TempResult := EncryStr(Str, Key);
  StrResult := '';
  for I := 0 to Length(TempResult) - 1 do begin
    temp := Format('%x', [Ord(TempResult[I + 1])]);
    if Length(temp) = 1 then temp := '0' + temp;
    StrResult := StrResult + temp;
  end;
  Result := StrResult; }
end;

function DecryStrHex(StrHex, Key: string): string;
  function HexToInt(Hex: string): Integer;
  var
    I, Res: Integer;
    Ch: Char;
  begin
    Res := 0;
    for I := 0 to Length(Hex) - 1 do begin
      Ch := Hex[I + 1];
      if (Ch >= '0') and (Ch <= '9') then
        Res := Res * 16 + Ord(Ch) - Ord('0')
      else if (Ch >= 'A') and (Ch <= 'F') then
        Res := Res * 16 + Ord(Ch) - Ord('A') + 10
      else if (Ch >= 'a') and (Ch <= 'f') then
        Res := Res * 16 + Ord(Ch) - Ord('a') + 10
      else raise Exception.Create('Error: not a Hex String');
    end;
    Result := Res;
  end;

var
  Str, temp: string;
  I: Integer;
begin
 { Str := '';
  for I := 0 to Length(StrHex) div 2 - 1 do begin
    temp := Copy(StrHex, I * 2 + 1, 2);
    Str := Str + Chr(HexToInt(temp));
  end;
  Result := DecryStr(Str, Key);  }
end;

function EncryStr_3DES(Str, Key: string): string;
begin
  if Length(Key) < 16 then
    while Length(Key) < 16 do
      Key := Key + Chr(0);

  {Result := EncryStr(Str, Copy(Key, 1, Length(Key) div 2));
  Result := DecryStr(Result, Copy(Key, Length(Key) div 2 + 1, Length(Key) div 2));
  Result := EncryStr(Result, Copy(Key, 1, Length(Key) div 2));}

 { Result := EncryStr(Str, Key);
  Result := DecryStr(Result, EncryptEvenNumberString(Key));
  Result := EncryStr(Result, DecryptEvenNumberString(Key)); }
end;

function DecryStr_3DES(Str, Key: string): string;
begin
  if Length(Key) < 16 then
    while Length(Key) < 16 do
      Key := Key + Chr(0);

  {Result := DecryStr(Str, Copy(Key, 1, Length(Key) div 2));
  Result := EncryStr(Result, Copy(Key, Length(Key) div 2 + 1, Length(Key) div 2));
  Result := DecryStr(Result, Copy(Key, 1, Length(Key) div 2));}

 { Result := DecryStr(Str, DecryptEvenNumberString(Key));
  Result := EncryStr(Result, EncryptEvenNumberString(Key));
  Result := DecryStr(Result, Key);  }
end;

function EncryStrHex_XDES(Str, Key: string): string;
begin
{  Result := '';
  if Str = '' then Exit;
  Result := EncodeString(EncryStr_XDES(EncodeString(Str), Key));    }
end;

function DecryStrHex_XDES(StrHex, Key: string): string;
begin
{  Result := '';
  if StrHex = '' then Exit;
  Result := DeCodeString(DecryStr_XDES(DeCodeString(StrHex), Key));    }
end;

function EncryStr_XDES(Str, Key: string): string;
var
  I: Integer;
  Key1, Key2: string;
begin
{  if Length(Key) < 16 then
    while Length(Key) < 16 do
      Key := Key + Chr(0);
  if Length(Key) mod 2 <> 0 then Key := Key + Chr(0);

  Key1 := '';
  Key2 := '';
  for I := 1 to Length(Key) do begin
    if (I <> 1) and (I mod 2 = 0) then begin
      Key1 := Key1 + Key[I];
    end else begin
      Key2 := Key2 + Key[I];
    end;
  end;
  Key1 := Key1 + Key2;

  Result := EncryStr(Str, Copy(Key, 1, Length(Key) div 2));
  Result := DecryStr(Result, Copy(Key1, Length(Key1) div 2 + 1, Length(Key1) div 2));
  Result := EncryStr(Result, Copy(Key, 1, Length(Key) div 2));   }
end;

function DecryStr_XDES(Str, Key: string): string;
var
  I: Integer;
  Key1, Key2: string;
begin
{  if Length(Key) < 16 then
    while Length(Key) < 16 do
      Key := Key + Chr(0);
  if Length(Key) mod 2 <> 0 then Key := Key + Chr(0);

  Key1 := '';
  Key2 := '';
  for I := 1 to Length(Key) do begin
    if (I <> 1) and (I mod 2 = 0) then begin
      Key1 := Key1 + Key[I];
    end else begin
      Key2 := Key2 + Key[I];
    end;
  end;
  Key1 := Key1 + Key2;

  Result := DecryStr(Str, Copy(Key, 1, Length(Key) div 2));
  Result := EncryStr(Result, Copy(Key1, Length(Key1) div 2 + 1, Length(Key1) div 2));
  Result := DecryStr(Result, Copy(Key, 1, Length(Key) div 2));  }
end;

initialization
  begin
    Randomize;
  end;


finalization
  begin

  end;

end.

