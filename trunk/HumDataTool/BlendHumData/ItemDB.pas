unit ItemDB;

interface
uses
  Windows, Classes, SysUtils, Forms, IniFiles, Share, Grobal;

function LoadItemBindIPaddr(sFileName: string; List: TList): Boolean;
function SaveItemBindIPaddr(sFileName: string; List: TList): Boolean;
function LoadItemBindAccount(sFileName: string; List: TList): Boolean;
function SaveItemBindAccount(sFileName: string; List: TList): Boolean;
function LoadItemBindCharName(sFileName: string; List: TList): Boolean;
function SaveItemBindCharName(sFileName: string; List: TList): Boolean;
function LoadItemDblClickList(sFileName: string; List: TList): Boolean; //加载物品事件触发列表
function SaveItemDblClickList(sFileName: string; List: TList): Boolean; //保存物品事件触发列表

procedure SetItemBindMakeIdx(List: TList; nOldItemMakeIdx, nNewItemMakeIdx: Integer);
procedure SetItemBindName(List: TList; sOldName, sNewName: string);
procedure SetItemDblClickList(List: TList; nOldItemMakeIdx, nNewItemMakeIdx: Integer);

implementation
uses HUtil32;
procedure SetItemBindMakeIdx(List: TList; nOldItemMakeIdx, nNewItemMakeIdx: Integer);
var
  I: Integer;
begin
  for I := 0 to List.Count - 1 do begin
    if pTItemBind(List.Items[I]).nMakeIdex = nOldItemMakeIdx then begin
      pTItemBind(List.Items[I]).nMakeIdex := nNewItemMakeIdx;
    end;
  end;
end;

procedure SetItemBindName(List: TList; sOldName, sNewName: string);
var
  I: Integer;
begin
  for I := 0 to List.Count - 1 do begin
    if CompareText(pTItemBind(List.Items[I]).sBindName, sOldName) = 0 then begin
      pTItemBind(List.Items[I]).sBindName := sNewName;
    end;
  end;
end;

procedure SetItemDblClickList(List: TList; nOldItemMakeIdx, nNewItemMakeIdx: Integer);
var
  nIndex: Integer;
begin
  {for I := 0 to List.Count - 1 do begin

    if pTItemEvent(List.Items[I]).nMakeIndex = nOldItemMakeIdx then begin
      pTItemEvent(List.Items[I]).nMakeIndex := nNewItemMakeIdx;
    end;
  end; }
end;

function LoadItemBindIPaddr(sFileName: string; List: TList): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sLineText, sMakeIndex, sItemIndex, sBindName: string;
  nMakeIndex, nItemIndex: Integer;
  ItemBind: pTItemBind;
begin
  Result := False;
  LoadList := TStringList.Create;
  if FileExists(sFileName) then begin
    for I := 0 to List.Count - 1 do begin
      Dispose(pTItemBind(List.Items[I]));
    end;
    List.Clear;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      if sLineText[1] = ';' then Continue;
      sLineText := GetValidStr3(sLineText, sItemIndex, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sMakeIndex, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sBindName, [' ', ',', #9]);
      nMakeIndex := Str_ToInt(sMakeIndex, -1);
      nItemIndex := Str_ToInt(sItemIndex, -1);
      if (nMakeIndex > 0) and (nItemIndex > 0) and (sBindName <> '') then begin
        New(ItemBind);
        ItemBind.nMakeIdex := nMakeIndex;
        ItemBind.nItemIdx := nItemIndex;
        ItemBind.sBindName := sBindName;
        List.Add(ItemBind);
      end;
    end;
    Result := True;
  end else begin
    LoadList.SaveToFile(sFileName);
  end;
  LoadList.Free;
end;

function SaveItemBindIPaddr(sFileName: string; List: TList): Boolean;
var
  I: Integer;
  SaveList: TStringList;
  ItemBind: pTItemBind;
begin
  Result := False;
  SaveList := TStringList.Create;
  for I := 0 to List.Count - 1 do begin
    ItemBind := List.Items[I];
    SaveList.Add(IntToStr(ItemBind.nItemIdx) + #9 + IntToStr(ItemBind.nMakeIdex) + #9 + ItemBind.sBindName);
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Result := True;
end;

function LoadItemBindAccount(sFileName: string; List: TList): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sLineText, sMakeIndex, sItemIndex, sBindName: string;
  nMakeIndex, nItemIndex: Integer;
  ItemBind: pTItemBind;
begin
  Result := False;
  LoadList := TStringList.Create;
  if FileExists(sFileName) then begin
    for I := 0 to List.Count - 1 do begin
      Dispose(pTItemBind(List.Items[I]));
    end;
    List.Clear;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      if sLineText[1] = ';' then Continue;
      sLineText := GetValidStr3(sLineText, sItemIndex, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sMakeIndex, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sBindName, [' ', ',', #9]);
      nMakeIndex := Str_ToInt(sMakeIndex, -1);
      nItemIndex := Str_ToInt(sItemIndex, -1);
      if (nMakeIndex > 0) and (nItemIndex > 0) and (sBindName <> '') then begin
        New(ItemBind);
        ItemBind.nMakeIdex := nMakeIndex;
        ItemBind.nItemIdx := nItemIndex;
        ItemBind.sBindName := sBindName;
        List.Add(ItemBind);
      end;
    end;
    Result := True;
  end else begin
    LoadList.SaveToFile(sFileName);
  end;
  LoadList.Free;
end;

function SaveItemBindAccount(sFileName: string; List: TList): Boolean;
var
  I: Integer;
  SaveList: TStringList;
  ItemBind: pTItemBind;
begin
  Result := False;
  SaveList := TStringList.Create;
  for I := 0 to List.Count - 1 do begin
    ItemBind := List.Items[I];
    SaveList.Add(IntToStr(ItemBind.nItemIdx) + #9 + IntToStr(ItemBind.nMakeIdex) + #9 + ItemBind.sBindName);
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Result := True;
end;

function LoadItemDblClickList(sFileName: string; List: TList): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sLineText, sMakeIndex, sItemName, sMapName, sX, sY: string;
  nMakeIndex: Integer;
  nCurrX: Integer;
  nCurrY: Integer;
  ItemEvent: pTItemEvent;
begin
  {Result := False;
  LoadList := TStringList.Create;

  for I := 0 to List.Count - 1 do begin
    Dispose(pTItemEvent(List.Items[I]));
  end;
  List.Clear;

  if FileExists(sFileName) then begin
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      if (sLineText = '') or (sLineText[1] = ';') then Continue;
      sLineText := GetValidStr3(sLineText, sItemName, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sMakeIndex, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sMapName, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sX, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sY, [' ', ',', #9]);
      nMakeIndex := Str_ToInt(sMakeIndex, -1);
      nCurrX := Str_ToInt(sX, -1);
      nCurrY := Str_ToInt(sY, -1);
      if (nMakeIndex > 0) and (sMapName <> '') and (nCurrX >= 0) and (nCurrY >= 0) then begin
        New(ItemEvent);
        ItemEvent.m_sItemName := sItemName;
        ItemEvent.m_nMakeIndex := nMakeIndex;
        ItemEvent.m_sMapName := sMapName;
        ItemEvent.m_nCurrX := nCurrX;
        ItemEvent.m_nCurrY := nCurrY;
        List.Add(ItemEvent);
      end;
    end;
    Result := True;
  end else begin
    LoadList.SaveToFile(sFileName);
  end;
  LoadList.Free;    }
end;

function SaveItemDblClickList(sFileName: string; List: TList): Boolean;
var
  I: Integer;
  SaveList: TStringList;
  ItemEvent: pTItemEvent;
begin
 { Result := False;
  SaveList := TStringList.Create;

  for I := 0 to List.Count - 1 do begin
    ItemEvent := pTItemEvent(List.Items[I]);
    SaveList.Add(ItemEvent.m_sItemName + #9 + IntToStr(ItemEvent.m_nMakeIndex) + #9 + ItemEvent.m_sMapName + #9 + IntToStr(ItemEvent.m_nCurrX) + #9 + IntToStr(ItemEvent.m_nCurrY));
  end;
  try
    SaveList.SaveToFile(sFileName);
  except

  end;
  SaveList.Free;
  Result := True;  }
end;


function LoadItemBindCharName(sFileName: string; List: TList): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sLineText, sMakeIndex, sItemIndex, sBindName: string;
  nMakeIndex, nItemIndex: Integer;
  ItemBind: pTItemBind;
begin
  Result := False;
  LoadList := TStringList.Create;
  if FileExists(sFileName) then begin
    for I := 0 to List.Count - 1 do begin
      Dispose(pTItemBind(List.Items[I]));
    end;
    List.Clear;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      if sLineText[1] = ';' then Continue;
      sLineText := GetValidStr3(sLineText, sItemIndex, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sMakeIndex, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sBindName, [' ', ',', #9]);
      nMakeIndex := Str_ToInt(sMakeIndex, -1);
      nItemIndex := Str_ToInt(sItemIndex, -1);
      if (nMakeIndex > 0) and (nItemIndex > 0) and (sBindName <> '') then begin
        New(ItemBind);
        ItemBind.nMakeIdex := nMakeIndex;
        ItemBind.nItemIdx := nItemIndex;
        ItemBind.sBindName := sBindName;
        List.Add(ItemBind);
      end;
    end;
    Result := True;
  end else begin
    LoadList.SaveToFile(sFileName);
  end;
  LoadList.Free;
end;

function SaveItemBindCharName(sFileName: string; List: TList): Boolean;
var
  I: Integer;
  SaveList: TStringList;
  ItemBind: pTItemBind;
begin
  Result := False;
  SaveList := TStringList.Create;
  for I := 0 to List.Count - 1 do begin
    ItemBind := List.Items[I];
    SaveList.Add(IntToStr(ItemBind.nItemIdx) + #9 + IntToStr(ItemBind.nMakeIdex) + #9 + ItemBind.sBindName);
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Result := True;
end;

end.

