unit GroupItems;

interface
uses
  Windows, Classes, SysUtils, Variants, IniFiles, Grobal2;
type
  TUseGroupItem = record
    ItemIndex: Integer;
    ItemName: string[14];
  end;

  TGroupItem = record
    FLD_USEITEMS: array[Low(THumanUseItems)..High(THumanUseItems)] of string[14]; //TUseGroupItem;
    FLD_RATE: array[0..20 - 1] of Integer;
    FLD_FLAG: array[0..20 - 1] of Boolean;
    FLD_HINTMSG: string[100];
  end;
  pTGroupItem = ^TGroupItem;

  TGroupItems = class
  private
    FList: TList;
    function GetCount: Integer;
    function GetItems(Index: Integer): pTGroupItem;
  public
    constructor Create();
    destructor Destroy; override;
    procedure LoadFromFile;
    procedure SaveToFile;
    function MemberCount(Item: pTGroupItem): Integer;
    function IsMember(Item: pTGroupItem; ItemName: string): Boolean;
    function Get(UseItems: THumanUseItems; GroupList: TList): Integer;

    function Find(Item: pTGroupItem): Boolean;
    function FindA(GroupItem: pTGroupItem): Boolean;
    function Add(Item: pTGroupItem): Boolean;
    function RateValue(Rate, Value: LongInt): LongInt;

    function Delete(GroupItem: pTGroupItem): Boolean;
    function UpDate(Item: pTGroupItem): Boolean;
    property Items[Index: Integer]: pTGroupItem read GetItems;
    property Count: Integer read GetCount;
  end;
implementation
uses M2Share, HUtil32;

constructor TGroupItems.Create();
begin
  inherited;
  FList := TList.Create;
end;

destructor TGroupItems.Destroy;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do begin
    Dispose(pTGroupItem(FList.Items[I]));
  end;
  FList.Free;
  inherited;
end;

function TGroupItems.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TGroupItems.GetItems(Index: Integer): pTGroupItem;
begin
  Result := FList.Items[Index];
end;

procedure TGroupItems.LoadFromFile;
var
  I, II: Integer;
  sFileName: string;
  Ini: TIniFile;
  GroupItem: pTGroupItem;
  Sections: TStringList;
begin
  for I := 0 to FList.Count - 1 do begin
    Dispose(pTGroupItem(FList.Items[I]));
  end;
  FList.Clear;

  sFileName := g_Config.sEnvirDir + 'GroupItems.txt';
  Ini := TIniFile.Create(sFileName);
  if Ini <> nil then begin
    Sections := TStringList.Create;
    Ini.ReadSections(Sections);

    for I := 0 to Sections.Count - 1 do begin
      New(GroupItem);
      FillChar(GroupItem^, SizeOf(TGroupItem), #0);
      GroupItem.FLD_USEITEMS[0] := Ini.ReadString(IntToStr(I), 'FLD_DRESSNAME', '');
      GroupItem.FLD_USEITEMS[1] := Ini.ReadString(IntToStr(I), 'FLD_WEAPONNAME', '');
      GroupItem.FLD_USEITEMS[2] := Ini.ReadString(IntToStr(I), 'FLD_RIGHTHANDNAME', '');
      GroupItem.FLD_USEITEMS[3] := Ini.ReadString(IntToStr(I), 'FLD_NECKLACENAME', '');
      GroupItem.FLD_USEITEMS[4] := Ini.ReadString(IntToStr(I), 'FLD_HELMETNAME', '');
      GroupItem.FLD_USEITEMS[5] := Ini.ReadString(IntToStr(I), 'FLD_ARMRINGLNAME', '');
      GroupItem.FLD_USEITEMS[6] := Ini.ReadString(IntToStr(I), 'FLD_ARMRINGRNAME', '');
      GroupItem.FLD_USEITEMS[7] := Ini.ReadString(IntToStr(I), 'FLD_RINGLNAME', '');
      GroupItem.FLD_USEITEMS[8] := Ini.ReadString(IntToStr(I), 'FLD_RINGRNAME', '');
      GroupItem.FLD_USEITEMS[9] := Ini.ReadString(IntToStr(I), 'FLD_BUJUKNAME', '');
      GroupItem.FLD_USEITEMS[10] := Ini.ReadString(IntToStr(I), 'FLD_BELTNAME', '');
      GroupItem.FLD_USEITEMS[11] := Ini.ReadString(IntToStr(I), 'FLD_BOOTSNAME', '');
      GroupItem.FLD_USEITEMS[12] := Ini.ReadString(IntToStr(I), 'FLD_CHARMNAME', '');
      GroupItem.FLD_HINTMSG := Ini.ReadString(IntToStr(I), 'FLD_HINTMSG', '');

      for II := 1 to 20 do begin
        GroupItem.FLD_RATE[II - 1] := Ini.ReadInteger(IntToStr(I), 'FLD_RATE' + IntToStr(II), 0);
      end;

      for II := 1 to 20 do begin
        GroupItem.FLD_FLAG[II - 1] := Ini.ReadBool(IntToStr(I), 'FLD_FLAG' + IntToStr(II), False);
      end;

      FList.Add(GroupItem);
    end;
    Sections.Free;
    Ini.Free;
  end;
end;

procedure TGroupItems.SaveToFile;
var
  I, II: Integer;
  sFileName: string;
  Ini: TIniFile;
  GroupItem: pTGroupItem;
  Sections: TStringList;
begin
  sFileName := g_Config.sEnvirDir + 'GroupItems.txt';
  DeleteFile(sFileName);
  Ini := TIniFile.Create(sFileName);
  if Ini <> nil then begin
    for I := 0 to FList.Count - 1 do begin
      GroupItem := FList[I];

      Ini.WriteString(IntToStr(I), 'FLD_DRESSNAME', GroupItem.FLD_USEITEMS[0]);
      Ini.WriteString(IntToStr(I), 'FLD_WEAPONNAME', GroupItem.FLD_USEITEMS[1]);
      Ini.WriteString(IntToStr(I), 'FLD_RIGHTHANDNAME', GroupItem.FLD_USEITEMS[2]);
      Ini.WriteString(IntToStr(I), 'FLD_NECKLACENAME', GroupItem.FLD_USEITEMS[3]);
      Ini.WriteString(IntToStr(I), 'FLD_HELMETNAME', GroupItem.FLD_USEITEMS[4]);
      Ini.WriteString(IntToStr(I), 'FLD_ARMRINGLNAME', GroupItem.FLD_USEITEMS[5]);
      Ini.WriteString(IntToStr(I), 'FLD_ARMRINGRNAME', GroupItem.FLD_USEITEMS[6]);
      Ini.WriteString(IntToStr(I), 'FLD_RINGLNAME', GroupItem.FLD_USEITEMS[7]);
      Ini.WriteString(IntToStr(I), 'FLD_RINGRNAME', GroupItem.FLD_USEITEMS[8]);
      Ini.WriteString(IntToStr(I), 'FLD_BUJUKNAME', GroupItem.FLD_USEITEMS[9]);
      Ini.WriteString(IntToStr(I), 'FLD_BELTNAME', GroupItem.FLD_USEITEMS[10]);
      Ini.WriteString(IntToStr(I), 'FLD_BOOTSNAME', GroupItem.FLD_USEITEMS[11]);
      Ini.WriteString(IntToStr(I), 'FLD_CHARMNAME', GroupItem.FLD_USEITEMS[12]);
      Ini.WriteString(IntToStr(I), 'FLD_HINTMSG', GroupItem.FLD_HINTMSG);

      for II := 1 to 20 do begin
        Ini.WriteInteger(IntToStr(I), 'FLD_RATE' + IntToStr(II), GroupItem.FLD_RATE[II - 1]);
      end;

      for II := 1 to 20 do begin
        Ini.WriteBool(IntToStr(I), 'FLD_FLAG' + IntToStr(II), GroupItem.FLD_FLAG[II - 1]);
      end;
    end;
    Ini.Free;
  end;
end;


function TGroupItems.Get(UseItems: THumanUseItems; GroupList: TList): Integer;
var
  I, II: Integer;
  boFind: Boolean;
  StdItem: pTStdItem;
  GroupItem: pTGroupItem;
begin
  Result := 0;
  for I := 0 to FList.Count - 1 do begin
    GroupItem := FList.Items[I];
    boFind := True;
    for II := Low(THumanUseItems) to High(THumanUseItems) do begin
      if (GroupItem.FLD_USEITEMS[II] <> '') then begin
        if (UseItems[II].wIndex <= 0) then begin
          boFind := False;
          Break;
        end;
        StdItem := UserEngine.GetStdItem(UseItems[II].wIndex);
        if StdItem = nil then begin
          boFind := False;
          Break;
        end;
        if (Comparetext(GroupItem.FLD_USEITEMS[II], StdItem.Name) <> 0) then begin
          boFind := False;
          Break;
        end;
      end;
    end;
    if boFind then begin
      GroupList.Add(GroupItem);
      //Result := GroupItem;
      //Break;
    end;
  end;
  Result := GroupList.Count;
end;

function TGroupItems.MemberCount(Item: pTGroupItem): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := Low(THumanUseItems) to High(THumanUseItems) do
    if Item.FLD_USEITEMS[I] <> '' then Inc(Result);
end;

function TGroupItems.IsMember(Item: pTGroupItem; ItemName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Low(THumanUseItems) to High(THumanUseItems) do
    if (Item.FLD_USEITEMS[I] <> '') and (Comparetext(Item.FLD_USEITEMS[I], ItemName) = 0) then begin
      Result := True;
      Break;
    end;
end;

function TGroupItems.RateValue(Rate, Value: LongInt): LongInt;
begin
  if Rate > 0 then Result := Value + Value * Rate div 100
  else Result := Value;
end;

function TGroupItems.Find(Item: pTGroupItem): Boolean;
var
  I, II: Integer;
  boFind: Boolean;
  GroupItem: pTGroupItem;
begin
  Result := False;
  for I := 0 to FList.Count - 1 do begin
    GroupItem := FList.Items[I];
    boFind := True;
    for II := Low(THumanUseItems) to High(THumanUseItems) do begin
      if (Comparetext(GroupItem.FLD_USEITEMS[II], Item.FLD_USEITEMS[II]) <> 0) then begin
        boFind := False;
        Break;
      end;
    end;
    if boFind then begin
      Result := True;
      Break;
    end;
  end;
end;

function TGroupItems.FindA(GroupItem: pTGroupItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to FList.Count - 1 do begin
    if GroupItem = FList.Items[I] then begin
      Result := True;
      Break;
    end;
  end;
end;

function TGroupItems.Add(Item: pTGroupItem): Boolean;
var
  GroupItem: pTGroupItem;
begin
  Result := False;
  New(GroupItem);
  GroupItem^ := Item^;
  FList.Add(GroupItem);
  Result := True;
end;

function TGroupItems.Delete(GroupItem: pTGroupItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to FList.Count - 1 do begin
    if GroupItem = FList.Items[I] then begin
      Dispose(pTGroupItem(FList.Items[I]));
      FList.Delete(I);
      Result := True;
      break;
    end;
  end;
end;

function TGroupItems.UpDate(Item: pTGroupItem): Boolean;
var
  I: Integer;
  GroupItem: pTGroupItem;
begin
  Result := False;
  for I := 0 to FList.Count - 1 do begin
    if Item = FList.Items[I] then begin
      Result := True;
      Break;
    end;
  end;
end;

end.

