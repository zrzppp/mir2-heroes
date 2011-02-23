unit MirShare;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, StrUtils, GameImages, HUtil32, Zlibx, CompressUnit, CompressUnit1;
const
  EI3 = 1;
  GT3 = 2;

  g_sTitle = '飞尔世界真彩图片资源文件 2010/02/25 http://www.cqfir.net';
  GMMODE = 0;
var
  g_ErrorList: TStringList;
  CurrImageFile: TMirImages;
  g_boWalking: Boolean = False;
function WidthBytes(w: Integer): Integer;
function DoSearchFile(Path, FType: string; var Files: TStringList): Boolean;

function GetPoint(FileName: string): TPoint;
function GetPointA(FileName: string): TPoint;
procedure SetPoint(FileName: string; Point: TPoint);

function Comp(Compress: Integer; const InData: Pointer; InSize: LongInt; out OutData: Pointer): Integer;
function UnComp(Compress: Integer; const InData: Pointer; InSize: LongInt; out OutData: Pointer): Integer;

implementation

procedure SetPoint(FileName: string; Point: TPoint);
var
  sFileName: string;
  SaveList: TStringList;
begin
  sFileName := ExtractFilePath(FileName) + 'Placements\';
  if not DirectoryExists(sFileName) then begin
    CreateDir(sFileName);
  end;
  sFileName := sFileName + ExtractFileNameOnly(FileName) + '.txt';
  SaveList := TStringList.Create;
  SaveList.Add(IntToStr(Point.X));
  SaveList.Add(IntToStr(Point.Y));
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
end;

function GetPointA(FileName: string): TPoint;
var
  sFileName: string;
  LoadList: TStringList;
  nX, nY: Integer;
begin
  Result := Point(0, 0);
  sFileName := FileName;
  if (not FileExists(sFileName)) then Exit;
  LoadList := TStringList.Create;
  LoadList.LoadFromFile(sFileName);
  nX := 0;
  nY := 0;
  if LoadList.Count > 0 then nX := Str_ToInt(LoadList.Strings[0], 0);
  if LoadList.Count > 1 then nY := Str_ToInt(LoadList.Strings[1], 0);
  LoadList.Free;
  Result := Point(nX, nY);
end;

function GetPoint(FileName: string): TPoint;
var
  sFileName: string;
  LoadList: TStringList;
  nX, nY: Integer;
begin
  Result := Point(0, 0);
  //if (not DirectoryExists(FileName)) {or (not DirectoryExists('Placements')) }then Exit;

  sFileName := ExtractFilePath(FileName) + 'Placements\' + ExtractFileNameOnly(FileName) + '.txt';
  //Showmessage(sFileName);
  //sFileName := ExtractFilePath(sFileName) + ExtractFileNameOnly(FileName) + '.txt';
  if (not FileExists(sFileName)) then Exit;
  LoadList := TStringList.Create;
  LoadList.LoadFromFile(sFileName);
  nX := 0;
  nY := 0;
  if LoadList.Count > 0 then nX := Str_ToInt(LoadList.Strings[0], 0);
  if LoadList.Count > 1 then nY := Str_ToInt(LoadList.Strings[1], 0);
  LoadList.Free;

  Result := Point(nX, nY);
end;

function WidthBytes(w: Integer): Integer;
begin
  Result := (((w * 8) + 31) div 32) * 4;
end;

procedure UnCompressRle16(const InData: Pointer; InSize: LongInt; out OutData: Pointer; out OutSize: LongInt);
//function UnCompressRle(dbuf, sbuf: PByte; sbuflen: Integer): Integer;
var
  I, J, K, a: integer;
  wsbuf, wdbuf: PWordArray;
begin
  wsbuf := PWordArray(InData);
  wdbuf := PWordArray(OutData);
  J := 0;
  I := 0;
  while I < InSize div 2 do begin
    if (wsbuf[I] = $AAAA) then begin
      for K := 0 to wsbuf[I + 2] - 1 do begin
        wdbuf[J] := wsbuf[I + 1];
        Inc(J);
      end;
      Inc(I, 2);
    end else begin
      wdbuf[J] := wsbuf[I];
      Inc(J);
    end;
    Inc(I);
  end;
  OutSize := J * 2;
end;

procedure CompressRle16(const InData: Pointer; InSize: LongInt; out OutData: Pointer; out OutSize: LongInt);
 //RLE 又叫 Run Length Encoding 压缩
var
  I, J, K: integer;
  wsbuf, wdbuf: PWordArray;
  repeatCount: integer;
  repeatWord: word;
begin
  wsbuf := PWordArray(InData);
  wdbuf := PWordArray(OutData);
  repeatCount := 0;
  repeatWord := 0;
  J := 0;
  for I := 0 to InSize div 2 - 1 do begin
    if (wsbuf[I] = repeatWord) and (repeatCount < 60000) then Inc(repeatCount)
    else begin
      if (repeatCount > 3) then begin
        wdbuf[J] := $AAAA;
        Inc(J);
        wdbuf[J] := repeatWord;
        Inc(J);
        wdbuf[J] := repeatCount;
        Inc(J);
      end else
        if (repeatCount > 0) then begin
        for K := 0 to repeatCount - 1 do begin
          wdbuf[J] := repeatWord;
          Inc(J);
        end;
      end;
      repeatWord := wsbuf[I];
      repeatCount := 1;
    end;
    if (I = InSize div 2 - 1) then begin
      if (repeatCount > 3) then begin
        wdbuf[J] := $AAAA;
        Inc(J);
        wdbuf[J] := repeatWord;
        Inc(J);
        wdbuf[J] := repeatCount;
        Inc(J);
      end else
        if (repeatCount > 0) and (repeatWord = $AAAA) then begin
        wdbuf[J] := $AAAA;
        Inc(J);
        wdbuf[J] := repeatWord;
        Inc(J);
        wdbuf[J] := repeatCount;
        Inc(J);
      end else
        if (repeatCount > 0) then begin
        for K := 0 to repeatCount - 1 do begin
          wdbuf[J] := repeatWord;
          Inc(J);
        end;
      end;
    end;
  end;
  OutSize := J * 2;
end;

procedure UnCompressRle32(const InData: Pointer; InSize: LongInt; out OutData: Pointer; out OutSize: LongInt);
//function UnCompressRle(dbuf, sbuf: PByte; sbuflen: Integer): Integer;
var
  I, J, K, a: Integer;
  wsbuf, wdbuf: PIntegerArray;
begin
  wsbuf := PIntegerArray(InData);
  wdbuf := PIntegerArray(OutData);
  J := 0;
  I := 0;
  while I < InSize div 4 do begin
    if (wsbuf[I] = -2) then begin
      for K := 0 to wsbuf[I + 2] - 1 do begin
        wdbuf[J] := wsbuf[I + 1];
        Inc(J);
      end;
      Inc(I, 2);
    end else begin
      wdbuf[J] := wsbuf[I];
      Inc(J);
    end;
    Inc(I);
  end;
  OutSize := J * 4;
end;

procedure CompressRle32(const InData: Pointer; InSize: LongInt; out OutData: Pointer; out OutSize: LongInt);
 //RLE 又叫 Run Length Encoding 压缩
var
  I, J, K: integer;
  wsbuf, wdbuf: PIntegerArray;
  RepeatCount: Integer;
  RepeatWord: Integer;
begin
  wsbuf := PIntegerArray(InData);
  wdbuf := PIntegerArray(OutData);
  RepeatCount := 0;
  RepeatWord := 0;
  J := 0;
  for I := 0 to InSize div 4 - 1 do begin
    if (wsbuf[I] = RepeatWord) {and (repeatCount < 60000)} then Inc(RepeatCount)

    else begin
      if (RepeatCount > 3) then begin
        wdbuf[J] := -2;
        Inc(J);
        wdbuf[J] := RepeatWord;
        Inc(J);
        wdbuf[J] := RepeatCount;
        Inc(J);
      end else
        if (RepeatCount > 0) then begin
        for K := 0 to RepeatCount - 1 do begin
          wdbuf[J] := RepeatWord;
          Inc(J);
        end;
      end;
      RepeatWord := wsbuf[I];
      RepeatCount := 1;
    end;
    if (I = InSize div 4 - 1) then begin
      if (RepeatCount > 3) then begin
        wdbuf[J] := -2;
        Inc(J);
        wdbuf[J] := RepeatWord;
        Inc(J);
        wdbuf[J] := RepeatCount;
        Inc(J);
      end else
        if (RepeatCount > 0) and (RepeatWord = -2) then begin
        wdbuf[J] := -2;
        Inc(J);
        wdbuf[J] := RepeatWord;
        Inc(J);
        wdbuf[J] := RepeatCount;
        Inc(J);
      end else
        if (RepeatCount > 0) then begin
        for K := 0 to RepeatCount - 1 do begin
          wdbuf[J] := RepeatWord;
          Inc(J);
        end;
      end;
    end;
  end;
  OutSize := J * 4;
end;

//=====================================压缩=====================================

function Comp(Compress: Integer; const InData: Pointer; InSize: LongInt; out OutData: Pointer): Integer;
begin
{$IF GMMODE = 1}
  case Compress of
    0: begin
        Move(InData^, OutData^, InSize);
        Result := InSize;
      end;
    1: CompressRle16(InData, InSize, OutData, Result);
    2: CompressBufZ(InData, InSize, OutData, Result);
    3: CompressBufferL(InData, InSize, OutData, Result);
    4: CompBufferL(InData, InSize, OutData, Result);
  end;
{$ELSE}
  Move(InData^, OutData^, InSize);
  Result := InSize;
{$IFEND}

end;

//====================================解压缩====================================

function UnComp(Compress: Integer; const InData: Pointer; InSize: LongInt; out OutData: Pointer): Integer;
begin
{$IF GMMODE = 1}
  case Compress of
    0: begin
        Move(InData^, OutData^, InSize);
        Result := InSize;
      end;
    1: UnCompressRle16(InData, InSize, OutData, Result);

    2: DecompressBufZ(InData, InSize, 0, OutData, Result);
    3: UnCompressBufferL(InData, InSize, OutData, Result);
    4: UnCompBufferL(InData, InSize, OutData, Result);
  end;
{$ELSE}
  Move(InData^, OutData^, InSize);
  Result := InSize;
{$IFEND}
end;

function DoSearchFile(Path, FType: string; var Files: TStringList): Boolean;
var
  Info: TSearchRec;
  s01: string;
  procedure ProcessAFile(FileName: string);
  begin
   {if Assigned(PnlPanel) then
     PnlPanel.Caption := FileName;
   Label2.Caption := FileName;}
  end;
  function IsDir: Boolean;
  begin
    with Info do
      Result := (Name <> '.') and (Name <> '..') and ((Attr and faDirectory) = faDirectory);
  end;
  function IsFile: Boolean;
  begin
    Result := (not ((Info.Attr and faDirectory) = faDirectory)) and (CompareText(ExtractFileExt(Info.Name), FType) = 0);
  end;
begin
  try
    //Files.Clear;
    Result := False;
    if FindFirst(Path + '*.*', faAnyFile, Info) = 0 then begin
     { if IsFile then begin
        s01 := Path + Info.Name;
        Files.Add(s01);
      end; }
      while True do begin
        if IsFile then begin
          s01 := Path + Info.Name;
          Files.Add(s01);
        end;

        Application.ProcessMessages;
        if FindNext(Info) <> 0 then Break;
      end;
    end;
    Result := True;
  finally
    FindClose(Info);
  end;
end;

initialization

end.

