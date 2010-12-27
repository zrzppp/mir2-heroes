unit MemoryIniFiles;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, IniFiles;
type
  TMemoryIniFile = class
  private
    { Private declarations }
    procedure Get(FileList: TStrings);
  public
    Sections: TStringList;
    constructor Create(); overload;
    constructor Create(FileList: TStrings); overload;
    constructor Create(Text: string); overload;
    constructor Create(Data: Pointer; Size: Integer); overload;
    destructor Destroy; override;
    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);

    function Read(const Section: string): TStrings;
    procedure Write(const Section: string; Strings: TStrings);
    procedure Delete(const Section: string);

    function ReadString(const Section, Ident, Default: string): string; overload;
    procedure WriteString(const Section, Ident, Value: string); overload;

    function ReadInteger(const Section, Ident: string; Default: Longint): Longint; overload;
    procedure WriteInteger(const Section, Ident: string; Value: Longint); overload;

    function ReadBool(const Section, Ident: string; Default: Boolean): Boolean; overload;
    procedure WriteBool(const Section, Ident: string; Value: Boolean); overload;



    function ReadDate(const Section, Name: string; Default: TDateTime): TDateTime; overload;
    function ReadDateTime(const Section, Name: string; Default: TDateTime): TDateTime; overload;
    function ReadFloat(const Section, Name: string; Default: Double): Double; overload;
    function ReadTime(const Section, Name: string; Default: TDateTime): TDateTime; overload;





    function ReadString(Section: Integer; const Ident, Default: string): string; overload;
    procedure WriteString(Section: Integer; const Ident, Value: string); overload;

    function ReadInteger(Section: Integer; const Ident: string; Default: Longint): Longint; overload;
    procedure WriteInteger(Section: Integer; const Ident: string; Value: Longint); overload;

    function ReadBool(Section: Integer; const Ident: string; Default: Boolean): Boolean; overload;
    procedure WriteBool(Section: Integer; const Ident: string; Value: Boolean); overload;


    function ReadDate(Section: Integer; const Name: string; Default: TDateTime): TDateTime; overload;
    function ReadDateTime(Section: Integer; const Name: string; Default: TDateTime): TDateTime; overload;
    function ReadFloat(Section: Integer; const Name: string; Default: Double): Double; overload;
    function ReadTime(Section: Integer; const Name: string; Default: TDateTime): TDateTime; overload;
  end;
implementation

constructor TMemoryIniFile.Create();
begin
  Sections := TStringList.Create;
end;

constructor TMemoryIniFile.Create(FileList: TStrings);
begin
  Sections := TStringList.Create;
  Get(FileList);
end;

constructor TMemoryIniFile.Create(Text: string);
var
  Strings: TStringList;
begin
  Strings := TStringList.Create;
  Strings.Text := Text;
  Create(Strings);
  Strings.Free;
end;

constructor TMemoryIniFile.Create(Data: Pointer; Size: Integer);
var
  Text: string;
  Strings: TStringList;
begin
  SetLength(Text, Size);
  Move(Data^, Text[1], Size);
  Strings := TStringList.Create;
  Strings.Text := Text;
  Create(Strings);
  Strings.Free;
end;

destructor TMemoryIniFile.Destroy;
var
  I: Integer;
begin
  for I := 0 to Sections.Count - 1 do
    TStrings(Sections.Objects[I]).Free;
  Sections.Free;
  inherited Destroy;
end;

procedure TMemoryIniFile.LoadFromFile(const FileName: string);
var
  I: Integer;
  Strings: TStringList;
begin
  Strings := TStringList.Create;
  try
    Strings.LoadFromFile(FileName);
    for I := 0 to Sections.Count - 1 do
      TStrings(Sections.Objects[I]).Free;
    Sections.Clear;
    Get(Strings);
  finally
    Strings.Free;
  end;
end;

procedure TMemoryIniFile.SaveToFile(const FileName: string);
var
  I, II: Integer;
  SaveList: TStringList;
  Strings: TStrings;
begin
  SaveList := TStringList.Create;
  for I := 0 to Sections.Count - 1 do begin
    SaveList.Add('[' + Sections[I] + ']');
    Strings := TStrings(Sections.Objects[I]);
    for II := 0 to Strings.Count - 1 do begin
      SaveList.Add(Strings[II]);
    end;
  end;

  try
    SaveList.SaveToFile(FileName);
  finally
    SaveList.Free;
  end;
end;

procedure TMemoryIniFile.Get(FileList: TStrings);
var
  I: Integer;
  Strings: TStringList;
  LineText: string;
begin
  Strings := nil;
  for I := 0 to FileList.Count - 1 do begin
    LineText := Trim(FileList[I]);
    if (LineText <> '') and (LineText[1] = '[') and (Pos(']', LineText) > 0) then begin
      Strings := TStringList.Create;
      Sections.AddObject(Copy(LineText, 2, Pos(']', LineText) - 2), Strings);
    end else begin
      if (Strings <> nil) and (LineText <> '') then
        Strings.Add(FileList[I]);
    end;
  end;
end;


function TMemoryIniFile.Read(const Section: string): TStrings;
var
  nIndex: Integer;
begin
  Result := nil;
  nIndex := Sections.IndexOf(Section);
  if (nIndex >= 0) then
    Result := TStrings(Sections.Objects[nIndex]);
end;

procedure TMemoryIniFile.Write(const Section: string; Strings: TStrings);
var
  I, nIndex: Integer;
  Ident, S: string;
  P: Integer;
  StringsA: TStrings;
begin
  nIndex := Sections.IndexOf(Section);
  if (nIndex >= 0) then begin
    StringsA := TStrings(Sections.Objects[nIndex]);
    for I := 0 to Strings.Count - 1 do begin
      P := AnsiPos(Strings.NameValueSeparator, Strings[I]);
      if (P <> 0) then
        Ident := Copy(Strings[I], 1, P - 1);

      nIndex := StringsA.IndexOfName(Ident);
      if (nIndex >= 0) then begin
      //S := Copy(Strings[nIndex], 1, Length(Ident) + 2);
      //Strings[nIndex] := S + Value;
      //Strings[nIndex] := Ident + '=' + Value;
      end else begin
        StringsA.AddObject(Strings[I], Strings.Objects[I]);
      end;
    end;
  end else begin
    Sections.AddObject(Section, Strings);
  end;
end;

procedure TMemoryIniFile.Delete(const Section: string);
var
  nIndex: Integer;
  Strings: TStrings;
begin
  nIndex := Sections.IndexOf(Section);
  if (nIndex >= 0) then begin
    Strings := TStrings(Sections.Objects[nIndex]);
    Sections.Delete(nIndex);
    Strings.Free;
  end;
end;

function TMemoryIniFile.ReadString(const Section, Ident, Default: string): string;
var
  nIndex: Integer;
  Strings: TStrings;
begin
  Result := Default;
  nIndex := Sections.IndexOf(Section);
  if (nIndex >= 0) then begin
    Strings := TStrings(Sections.Objects[nIndex]);
    nIndex := Strings.IndexOfName(Ident);
    if (nIndex >= 0) then begin
      Result := Copy(Strings[nIndex], Length(Ident) + 2, Maxint);
    end;
  end;
end;

procedure TMemoryIniFile.WriteString(const Section, Ident, Value: string);
var
  nIndex: Integer;
  Strings: TStrings;
  S: string;
begin
  nIndex := Sections.IndexOf(Section);
  if (nIndex >= 0) then begin
    Strings := TStrings(Sections.Objects[nIndex]);
    nIndex := Strings.IndexOfName(Ident);
    if (nIndex >= 0) then begin
      //S := Copy(Strings[nIndex], 1, Length(Ident) + 2);
      //Strings[nIndex] := S + Value;
      Strings[nIndex] := Ident + '=' + Value;
    end;
  end else begin
    Strings := TStringList.Create;
    Sections.AddObject(Section, Strings);
    Strings.Add(Ident + '=' + Value);
  end;
end;

function TMemoryIniFile.ReadInteger(const Section, Ident: string; Default: Longint): Longint;
var
  IntStr: string;
begin
  IntStr := ReadString(Section, Ident, '');
  if (Length(IntStr) > 2) and (IntStr[1] = '0') and
    ((IntStr[2] = 'X') or (IntStr[2] = 'x')) then
    IntStr := '$' + Copy(IntStr, 3, Maxint);
  Result := StrToIntDef(IntStr, Default);
end;

procedure TMemoryIniFile.WriteInteger(const Section, Ident: string; Value: Longint);
begin
  WriteString(Section, Ident, IntToStr(Value));
end;

function TMemoryIniFile.ReadBool(const Section, Ident: string; Default: Boolean): Boolean;
begin
  Result := ReadInteger(Section, Ident, Ord(Default)) <> 0;
end;

procedure TMemoryIniFile.WriteBool(const Section, Ident: string; Value: Boolean);
const
  Values: array[Boolean] of string = ('0', '1');
begin
  WriteString(Section, Ident, Values[Value]);
end;
{------------------------------------------------------------------------------}

function TMemoryIniFile.ReadString(Section: Integer; const Ident, Default: string): string;
var
  nIndex: Integer;
  Strings: TStrings;
begin
  Result := Default;
  if (Section >= 0) and (Section < Sections.Count) then begin
    Strings := TStrings(Sections.Objects[Section]);
    nIndex := Strings.IndexOfName(Ident);
    if (nIndex >= 0) then begin
      Result := Copy(Strings[nIndex], Length(Ident) + 2, Maxint);
    end;
  end;
end;

procedure TMemoryIniFile.WriteString(Section: Integer; const Ident, Value: string);
var
  nIndex: Integer;
  Strings: TStrings;
  S: string;
begin
  //nIndex := Sections.IndexOf(Section);
  if (Section >= 0) and (Section < Sections.Count) then begin
    Strings := TStrings(Sections.Objects[Section]);
    nIndex := Strings.IndexOfName(Ident);
    if (nIndex >= 0) then begin
      //S := Copy(Strings[nIndex], 1, Length(Ident) + 2);
      //Strings[nIndex] := S + Value;
      Strings[nIndex] := Ident + '=' + Value;
    end;
  end;
end;

function TMemoryIniFile.ReadInteger(Section: Integer; const Ident: string; Default: Longint): Longint;
var
  IntStr: string;
begin
  IntStr := ReadString(Section, Ident, '');
  if (Length(IntStr) > 2) and (IntStr[1] = '0') and
    ((IntStr[2] = 'X') or (IntStr[2] = 'x')) then
    IntStr := '$' + Copy(IntStr, 3, Maxint);
  Result := StrToIntDef(IntStr, Default);
end;

procedure TMemoryIniFile.WriteInteger(Section: Integer; const Ident: string; Value: Longint);
begin
  WriteString(Section, Ident, IntToStr(Value));
end;

function TMemoryIniFile.ReadBool(Section: Integer; const Ident: string; Default: Boolean): Boolean;
begin
  Result := ReadInteger(Section, Ident, Ord(Default)) <> 0;
end;

procedure TMemoryIniFile.WriteBool(Section: Integer; const Ident: string; Value: Boolean);
const
  Values: array[Boolean] of string = ('0', '1');
begin
  WriteString(Section, Ident, Values[Value]);
end;


function TMemoryIniFile.ReadDate(const Section, Name: string; Default: TDateTime): TDateTime;
var
  DateStr: string;
begin
  DateStr := ReadString(Section, Name, '');
  Result := Default;
  if DateStr <> '' then
  try
    Result := StrToDate(DateStr);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
  else
    raise;
  end;
end;

function TMemoryIniFile.ReadDateTime(const Section, Name: string; Default: TDateTime): TDateTime;
var
  DateStr: string;
begin
  DateStr := ReadString(Section, Name, '');
  Result := Default;
  if DateStr <> '' then
  try
    Result := StrToDateTime(DateStr);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
  else
    raise;
  end;
end;

function TMemoryIniFile.ReadFloat(const Section, Name: string; Default: Double): Double;
var
  FloatStr: string;
begin
  FloatStr := ReadString(Section, Name, '');
  Result := Default;
  if FloatStr <> '' then
  try
    Result := StrToFloat(FloatStr);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
  else
    raise;
  end;
end;

function TMemoryIniFile.ReadTime(const Section, Name: string; Default: TDateTime): TDateTime;
var
  TimeStr: string;
begin
  TimeStr := ReadString(Section, Name, '');
  Result := Default;
  if TimeStr <> '' then
  try
    Result := StrToTime(TimeStr);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
  else
    raise;
  end;
end;

function TMemoryIniFile.ReadDate(Section: Integer; const Name: string; Default: TDateTime): TDateTime;
var
  DateStr: string;
begin
  DateStr := ReadString(Section, Name, '');
  Result := Default;
  if DateStr <> '' then
  try
    Result := StrToDate(DateStr);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
  else
    raise;
  end;
end;

function TMemoryIniFile.ReadDateTime(Section: Integer; const Name: string; Default: TDateTime): TDateTime;
var
  DateStr: string;
begin
  DateStr := ReadString(Section, Name, '');
  Result := Default;
  if DateStr <> '' then
  try
    Result := StrToDateTime(DateStr);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
  else
    raise;
  end;
end;

function TMemoryIniFile.ReadFloat(Section: Integer; const Name: string; Default: Double): Double;
var
  FloatStr: string;
begin
  FloatStr := ReadString(Section, Name, '');
  Result := Default;
  if FloatStr <> '' then
  try
    Result := StrToFloat(FloatStr);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
  else
    raise;
  end;
end;

function TMemoryIniFile.ReadTime(Section: Integer; const Name: string; Default: TDateTime): TDateTime;
var
  TimeStr: string;
begin
  TimeStr := ReadString(Section, Name, '');
  Result := Default;
  if TimeStr <> '' then
  try
    Result := StrToTime(TimeStr);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
  else
    raise;
  end;
end;

end.

