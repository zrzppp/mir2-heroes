unit MemoryIniFiles;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, IniFiles;
type
  TQuickSortList = class(TStringList)
  private
    CriticalSection: TRTLCriticalSection;
    function GetCaseSensitive: Boolean;
    procedure SetCaseSensitive(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    procedure SortString(nMIN, nMax: Integer);
    function GetIndex(const S: string): Integer;
    function AddRecord(const S: string; AObject: TObject): Boolean;
    procedure Lock;
    procedure UnLock;
  published
    property boCaseSensitive: Boolean read GetCaseSensitive write SetCaseSensitive;
  end;

  TMemoryIniFile = class
  private
    FLoadOK: Boolean;
    FChanged: Boolean;
    FOnChange: TNotifyEvent;
    procedure Get(FileList: TStrings);
    procedure Changed(Sender: TObject);
  public
    Sections: TQuickSortList;
    constructor Create(); overload;
    constructor Create(FileList: TStrings); overload;
    constructor Create(Text: string); overload;
    constructor Create(Data: Pointer; Size: Integer); overload;
    destructor Destroy; override;
    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);
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

    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;
implementation
uses RTLConsts,M2Share;
{ TValueList }



{=============================TQuickSortList====================================}

function TQuickSortList.GetIndex(const S: string): Integer;
var
  nLow, nHigh, nMed, nCompareVal: Integer;
begin
  Result := -1;
  if Self.Count <> 0 then begin
    if Self.Sorted then begin
      if Self.Count = 1 then begin
        if CompareStr(S, Self.Strings[0]) = 0 then Result := 0;
      end else begin
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            if CompareStr(S, Self.Strings[nHigh]) = 0 then Result := nHigh;
            if CompareStr(S, Self.Strings[nLow]) = 0 then Result := nLow;
            Break;
          end else begin
            nCompareVal := CompareStr(S, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := nMed;
            Break;
          end;
        end;
      end;
    end else begin
      if Self.Count = 1 then begin
        if CompareText(S, Self.Strings[0]) = 0 then Result := 0;
      end else begin
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            if CompareText(S, Self.Strings[nHigh]) = 0 then Result := nHigh;
            if CompareText(S, Self.Strings[nLow]) = 0 then Result := nLow;
            Break;
          end else begin
            nCompareVal := CompareText(S, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := nMed;
            Break;
          end;
        end;
      end;
    end;
  end;
end;

procedure TQuickSortList.SortString(nMIN, nMax: Integer);
var
  ntMin, ntMax: Integer;
  s18: string;
begin
  if Self.Count > 0 then
    while (True) do begin
      ntMin := nMIN;
      ntMax := nMax;
      s18 := Self.Strings[(nMIN + nMax) shr 1];
      while (True) do begin
        while (CompareText(Self.Strings[ntMin], s18) < 0) do Inc(ntMin);
        while (CompareText(Self.Strings[ntMax], s18) > 0) do Dec(ntMax);
        if ntMin <= ntMax then begin
          Self.Exchange(ntMin, ntMax);
          Inc(ntMin);
          Dec(ntMax);
        end;
        if ntMin > ntMax then Break
      end;
      if nMIN < ntMax then SortString(nMIN, ntMax);
      nMIN := ntMin;
      if ntMin >= nMax then Break;
    end;
end;

function TQuickSortList.AddRecord(const S: string; AObject: TObject): Boolean;
var
  nLow, nHigh, nMed, nCompareVal: Integer;
begin
  Result := True;
  if Self.Count = 0 then begin
    Self.AddObject(S, AObject);
  end else begin
    if Self.Sorted then begin
      if Self.Count = 1 then begin
        nMed := CompareStr(S, Self.Strings[0]);
        if nMed > 0 then
          Self.AddObject(S, AObject)
        else begin
          if nMed < 0 then Self.InsertObject(0, S, AObject);
        end;
      end else begin
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            nMed := CompareStr(S, Self.Strings[nHigh]);
            if nMed > 0 then begin
              Self.InsertObject(nHigh + 1, S, AObject);
              Break;
            end else begin
              nMed := CompareStr(S, Self.Strings[nLow]);
              if nMed > 0 then begin
                Self.InsertObject(nLow + 1, S, AObject);
                Break;
              end else begin
                if nMed < 0 then begin
                  Self.InsertObject(nLow, S, AObject);
                  Break; ;
                end else begin
                  Result := False;
                  Break;
                end;
              end;
            end;
          end else begin
            nCompareVal := CompareStr(S, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := False;
            Break;
          end;
        end;
      end;
    end else begin
      if Self.Count = 1 then begin
        nMed := CompareText(S, Self.Strings[0]);
        if nMed > 0 then
          Self.AddObject(S, AObject)
        else begin
          if nMed < 0 then Self.InsertObject(0, S, AObject);
        end;
      end else begin //
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            nMed := CompareText(S, Self.Strings[nHigh]);
            if nMed > 0 then begin
              Self.InsertObject(nHigh + 1, S, AObject);
              Break;
            end else begin
              nMed := CompareText(S, Self.Strings[nLow]);
              if nMed > 0 then begin
                Self.InsertObject(nLow + 1, S, AObject);
                Break;
              end else begin
                if nMed < 0 then begin
                  Self.InsertObject(nLow, S, AObject);
                  Break;
                end else begin
                  Result := False;
                  Break;
                end;
              end;
            end;
          end else begin
            nCompareVal := CompareText(S, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := False;
            Break;
          end;
        end;
      end;
    end;
  end;
end;

function TQuickSortList.GetCaseSensitive: Boolean;
begin
  Result := CaseSensitive;
end;

procedure TQuickSortList.SetCaseSensitive(const Value: Boolean);
begin
  CaseSensitive := Value;
end;

procedure TQuickSortList.Lock;
begin
  EnterCriticalSection(CriticalSection);
end;

procedure TQuickSortList.UnLock;
begin
  LeaveCriticalSection(CriticalSection);
end;

constructor TQuickSortList.Create;
begin
  inherited;
  InitializeCriticalSection(CriticalSection);
end;

destructor TQuickSortList.Destroy;
begin
  DeleteCriticalSection(CriticalSection);
  inherited;
end;

{==============================================================================}

constructor TMemoryIniFile.Create();
begin
  FChanged := False;
  FLoadOK := False;
  Sections := TQuickSortList.Create;
  Sections.OnChange := Changed;
end;

constructor TMemoryIniFile.Create(FileList: TStrings);
begin
  FChanged := False;
  FLoadOK := False;
  Sections := TQuickSortList.Create;
  Sections.OnChange := Changed;
  Get(FileList);
end;

constructor TMemoryIniFile.Create(Text: string);
var
  Strings: TStringList;
begin
  FChanged := False;
  FLoadOK := False;
  Strings := TStringList.Create;
  Strings.OnChange := Changed;
  Strings.Text := Text;
  Create(Strings);
  Strings.Free;
end;

constructor TMemoryIniFile.Create(Data: Pointer; Size: Integer);
var
  Text: string;
  Strings: TStringList;
begin
  FChanged := False;
  FLoadOK := False;
  SetLength(Text, Size);
  Move(Data^, Text[1], Size);
  Strings := TStringList.Create;
  Strings.OnChange := Changed;
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

procedure TMemoryIniFile.Changed(Sender: TObject);
begin
  FChanged := True;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TMemoryIniFile.LoadFromFile(const FileName: string);
var
  I: Integer;
  Strings: TStringList;
begin
  FChanged := False;
  Strings := TStringList.Create;
  try
    Strings.LoadFromFile(FileName);
    for I := 0 to Sections.Count - 1 do
      TStrings(Sections.Objects[I]).Free;
    Sections.Clear;
    Get(Strings);
  except
  end;
  Strings.Free;
end;

procedure TMemoryIniFile.SaveToFile(const FileName: string);
var
  I, II: Integer;
  SaveList: TStringList;
  Strings: TValueList;
begin
  //if FChanged and FLoadOK then begin
    FChanged := False;
    SaveList := TStringList.Create;
    for I := 0 to Sections.Count - 1 do begin
      SaveList.Add('[' + Sections.Strings[I] + ']');
      Strings := TValueList(Sections.Objects[I]);
      for II := 0 to Strings.Count - 1 do begin
        SaveList.Add(Strings.Names[II] + '=' + Strings.Strings[II]);
      end;
    end;
    try
      SaveList.SaveToFile(FileName);
    except

    end;
    SaveList.Free;
  //end;
end;

function FastCharPos(const aSource: string; const C: Char; StartPos: Integer): Integer;
var
  L: Integer;
begin
  //If this assert failed, it is because you passed 0 for StartPos, lowest value is 1 !!
  Assert(StartPos > 0);

  Result := 0;
  L := Length(aSource);
  if L = 0 then exit;
  if StartPos > L then exit;
  Dec(StartPos);
  asm
      PUSH EDI                 //Preserve this register

      mov  EDI, aSource        //Point EDI at aSource
      add  EDI, StartPos
      mov  ECX, L              //Make a note of how many chars to search through
      sub  ECX, StartPos
      mov  AL,  C              //and which char we want
    @Loop:
      cmp  Al, [EDI]           //compare it against the SourceString
      jz   @Found
      inc  EDI
      dec  ECX
      jnz  @Loop
      jmp  @NotFound
    @Found:
      sub  EDI, aSource        //EDI has been incremented, so EDI-OrigAdress = Char pos !
      inc  EDI
      mov  Result,   EDI
    @NotFound:

      POP  EDI
  end;
end;

procedure TMemoryIniFile.Get(FileList: TStrings);
var
  I, nPos: Integer;
  Strings: TValueList;
  LineText: string;
  sName, sValue: string;
begin
  Strings := nil;
  FLoadOK := False;
  for I := 0 to FileList.Count - 1 do begin
    LineText := TrimLeft(FileList.Strings[I]);
    nPos := FastCharPos(LineText, ']', 1); //nPos := Pos(']', LineText);/
    if (LineText <> '') and (LineText[1] = '[') and (nPos > 0) then begin //(Pos(']', LineText) > 0)
      Strings := TValueList.Create;
      Strings.OnChange := Changed;
      Sections.AddObject(Copy(LineText, 2, nPos - 2), Strings);
    end else begin
      if (Strings <> nil) and (LineText <> '') then begin
        nPos := Pos('=', LineText);
        if nPos > 0 then begin
          sName := Copy(LineText, 1, nPos - 1);
          sValue := Copy(LineText, nPos + 1, Length(LineText));
          Strings.AddRecord(sName, sValue);
        end;
      end;
    end;
  end;
  Sections.SortString(0, Sections.Count - 1);
  FLoadOK := True;
end;

function TMemoryIniFile.ReadString(const Section, Ident, Default: string): string;
var
  nIndex: Integer;
  Strings: TValueList;
begin
  Result := Default;
  nIndex := Sections.GetIndex(Section);
  if (nIndex >= 0) then begin
    Strings := TValueList(Sections.Objects[nIndex]);
    nIndex := Strings.GetIndex(Ident);
    if (nIndex >= 0) then begin
      Result := Strings.Strings[nIndex];
    end;
  end;
end;

procedure TMemoryIniFile.WriteString(const Section, Ident, Value: string);
var
  nIndex: Integer;
  Strings: TValueList;
  S: string;
begin
  FChanged := True;
  nIndex := Sections.GetIndex(Section);
  if (nIndex >= 0) then begin
    Strings := TValueList(Sections.Objects[nIndex]);
    nIndex := Strings.GetIndex(Ident);
    if (nIndex >= 0) then begin
      Strings.Strings[nIndex] := Value;
      //MainOutMessage('procedure TMemoryIniFile.WriteString:'+Value);
    end else begin
      Strings.AddRecord(Ident, Value);
      //MainOutMessage('procedure TMemoryIniFile.WriteString Strings.AddRecord(Ident, Value):'+Value);
    end;
  end else begin
    Strings := TValueList.Create;
    Strings.OnChange := Changed;
    Sections.AddRecord(Section, Strings);
    Strings.AddRecord(Ident, Value);
    //MainOutMessage('procedure TMemoryIniFile.WriteString if (nIndex >= 0) then begin:'+Value);
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
  Strings: TValueList;
begin
  Result := Default;
  if (Section >= 0) and (Section < Sections.Count) then begin
    Strings := TValueList(Sections.Objects[Section]);
    nIndex := Strings.GetIndex(Ident);
    if (nIndex >= 0) then begin
      Result := Strings.Strings[nIndex];
    end;
  end;
end;

procedure TMemoryIniFile.WriteString(Section: Integer; const Ident, Value: string);
var
  nIndex: Integer;
  Strings: TValueList;
  S: string;
begin
  if (Section >= 0) and (Section < Sections.Count) then begin
    Strings := TValueList(Sections.Objects[Section]);
    nIndex := Strings.GetIndex(Ident);
    if (nIndex >= 0) then begin
      Strings.Strings[nIndex] := Value;
    end else begin
      Strings.AddRecord(Ident, Value);
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

