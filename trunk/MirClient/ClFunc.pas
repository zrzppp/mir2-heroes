unit ClFunc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Textures, DirectX, DXClass, Grobal2, ExtCtrls, HUtil32;

const
  DR_0 = 0;
  DR_1 = 1;
  DR_2 = 2;
  DR_3 = 3;
  DR_4 = 4;
  DR_5 = 5;
  DR_6 = 6;
  DR_7 = 7;
  DR_8 = 8;
  DR_9 = 9;
  DR_10 = 10;
  DR_11 = 11;
  DR_12 = 12;
  DR_13 = 13;
  DR_14 = 14;
  DR_15 = 15;

//type
{  TDynamicObject = record //官蹿俊 如利
    X: Integer; //某腐 谅钎拌
    Y: Integer;
    px: Integer; //shiftx ,y
    py: Integer;
    dsurface: TTexture;
  end;
  PTDynamicObject = ^TDynamicObject; }


var
  DropItems: TList; //lsit of TClientItem

function fmstr(Str: string; len: Integer): string;
function GetGoldStr(gold: Integer): string;
procedure Savebags(flname: string; pbuf: PByte);
procedure Loadbags(flname: string; pbuf: PByte);
procedure ClearBag;
function AddItemBag(cu: TClientItem): Boolean;
function UpdateItemBag(cu: TClientItem): Boolean;
function UpdateItemBag2(cu: TClientItem): Boolean;
function DelItemBag(iname: string; iindex: Integer): Boolean;
procedure ArrangeItemBag;

procedure ClearHeroBag;
function AddHeroItemBag(cu: TClientItem): Boolean;
function UpdateHeroItemBag(cu: TClientItem): Boolean;
function DelHeroItemBag(iname: string; iindex: Integer): Boolean;
procedure ArrangeHeroItemBag;

procedure ClearDate;
procedure ClearHeroDate;
procedure ClearUserDate;

procedure AddDropItem(ci: TClientItem);
function GetDropItem(iname: string; MakeIndex: Integer): PTClientItem;
procedure DelDropItem(iname: string; MakeIndex: Integer);
procedure AddDealItem(ci: TClientItem);
procedure DelDealItem(ci: TClientItem);
procedure MoveDealItemToBag;
procedure AddDealRemoteItem(ci: TClientItem);
procedure DelDealRemoteItem(ci: TClientItem);
function GetDistance(sx, sY, dx, dy: Integer): Integer;
procedure GetNextPosXY(dir: Byte; var X, Y: Integer);
procedure GetNextRunXY(dir: Byte; var X, Y: Integer);
procedure GetNextHorseRunXY(dir: Byte; var X, Y: Integer);
function GetNextDirection(sx, sY, dx, dy: Integer): Byte;
function GetBack(dir: Integer): Integer;
procedure GetBackPosition(sx, sY, dir: Integer; var NewX, NewY: Integer);
procedure GetFrontPosition(sx, sY, dir: Integer; var NewX, NewY: Integer); overload;
procedure GetFrontPosition(sx, sY, dir, nFlag: Integer; var NewX, NewY: Integer); overload;
procedure GetPixelFrontPosition(sx, sY, dir, nFlag: Integer; var NewX, NewY: Integer);
function GetFlyDirection(sx, sY, ttx, tty: Integer): Integer;
function GetFlyDirection16(sx, sY, ttx, tty: Integer): Integer;
function PrivDir(ndir: Integer): Integer;
function NextDir(ndir: Integer): Integer;

function GetTakeOnPosition(smode: Integer): Integer;
function IsKeyPressed(Key: Byte): Boolean;

procedure AddChangeFace(recogid: Integer);
procedure DelChangeFace(recogid: Integer);
function IsChangingFace(recogid: Integer): Boolean;

procedure AddDuelItem(ci: TClientItem);
procedure DelDuelItem(ci: TClientItem);
procedure MoveDuelItemToBag;
procedure AddDuelRemoteItem(ci: TClientItem);
procedure DelDuelRemoteItem(ci: TClientItem);

procedure DelStoreItem(ci: TClientItem);
procedure DelStoreRemoteItem(ci: TClientItem);
implementation

uses
  MShare, Share;

function fmstr(Str: string; len: Integer): string;
var I: Integer;
begin
  try
    Result := Str + ' ';
    for I := 1 to len - Length(Str) - 1 do
      Result := Result + ' ';
  except
    Result := Str + ' ';
  end;
end;

function GetGoldStr(gold: Integer): string;
var
  I, n: Integer;
  Str: string;
begin
  Str := IntToStr(gold);
  n := 0;
  Result := '';
  for I := Length(Str) downto 1 do begin
    if n = 3 then begin
      Result := Str[I] + ',' + Result;
      n := 1;
    end else begin
      Result := Str[I] + Result;
      Inc(n);
    end;
  end;
end;

procedure Savebags(flname: string; pbuf: PByte);
var
  fhandle: Integer;
begin
  if FileExists(flname) then
    fhandle := FileOpen(flname, fmOpenWrite or fmShareDenyNone)
  else fhandle := FileCreate(flname);
  if fhandle > 0 then begin
    FileWrite(fhandle, pbuf^, SizeOf(TClientItem) * MAXBAGITEMCL);
    FileClose(fhandle);
  end;
end;

procedure Loadbags(flname: string; pbuf: PByte);
var
  fhandle: Integer;
begin
  if FileExists(flname) then begin
    fhandle := FileOpen(flname, fmOpenRead or fmShareDenyNone);
    if fhandle > 0 then begin
      FileRead(fhandle, pbuf^, SizeOf(TClientItem) * MAXBAGITEMCL);
      FileClose(fhandle);
    end;
  end;
end;

procedure ClearHeroBag;
var
  I: Integer;
begin
  for I := Low(g_HeroItemArr) to High(g_HeroItemArr) do
    g_HeroItemArr[I].S.Name := '';
end;

function AddHeroItemBag(cu: TClientItem): Boolean;
var
  I: Integer;
  boFind: Boolean;
begin
  Result := False;
  boFind := False;
  for I := Low(g_HeroItemArr) to High(g_HeroItemArr) do begin
    if (g_HeroItemArr[I].MakeIndex = cu.MakeIndex) and (g_HeroItemArr[I].S.Name = cu.S.Name) then begin
      boFind := True;
      Break;
    end;
  end;
  //if cu.S.Name = '' then Exit;
  if (cu.S.Name <> '') and not boFind then begin
    for I := Low(g_HeroItemArr) to High(g_HeroItemArr) do begin
      if g_HeroItemArr[I].S.Name = '' then begin
        g_HeroItemArr[I] := cu;
        Result := True;
        Break;
      end;
    end;
  end;
  ArrangeHeroItemBag;
end;

function UpdateHeroItemBag(cu: TClientItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := High(g_HeroItemArr) downto Low(g_HeroItemArr) do begin
    if (g_HeroItemArr[I].S.Name = cu.S.Name) and (g_HeroItemArr[I].MakeIndex = cu.MakeIndex) then begin
      g_HeroItemArr[I] := cu;
      Result := True;
      Break;
    end;
  end;
end;

function DelHeroItemBag(iname: string; iindex: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := High(g_HeroItemArr) downto Low(g_HeroItemArr) do begin
    if (g_HeroItemArr[I].S.Name = iname) and (g_HeroItemArr[I].MakeIndex = iindex) then begin
      SafeFillChar(g_HeroItemArr[I], SizeOf(TClientItem), #0);
      Result := True;
      Break;
    end;
  end;
  ArrangeHeroItemBag;
end;

procedure ArrangeHeroItemBag;
var
  I, k: Integer;
begin
  for I := Low(g_HeroItemArr) to High(g_HeroItemArr) do begin
    if g_HeroItemArr[I].S.Name <> '' then begin
      for k := I + 1 to High(g_HeroItemArr) - 1 do begin //检测复制物品
        if (g_HeroItemArr[I].S.Name = g_HeroItemArr[k].S.Name) and (g_HeroItemArr[I].MakeIndex = g_HeroItemArr[k].MakeIndex) then begin
          SafeFillChar(g_HeroItemArr[k], SizeOf(TClientItem), #0);
        end;
      end;
     { for k := Low(g_HeroUseItems) to High(g_HeroUseItems) do begin
        if (g_HeroItemArr[I].S.Name = g_HeroUseItems[k].S.Name) and (g_HeroItemArr[I].MakeIndex = g_HeroUseItems[k].MakeIndex) then begin
          SafeFillChar(g_HeroItemArr[k], SizeOf(TClientItem), #0);
        end;
      end; }
      if (g_HeroItemArr[I].S.Name = g_MovingItem.Item.S.Name) and (g_HeroItemArr[I].MakeIndex = g_MovingItem.Item.MakeIndex) then begin
        g_MovingItem.Index := 0;
        g_MovingItem.Item.S.Name := '';
      end;
    end;
  end;

  for I := Low(g_HeroUseItems) to High(g_HeroUseItems) do begin
    if g_HeroUseItems[I].S.Name <> '' then begin
      for k := I + 1 to High(g_HeroUseItems) - 1 do begin //检测复制物品
        if (g_HeroUseItems[I].S.Name = g_HeroUseItems[k].S.Name) and (g_HeroUseItems[I].MakeIndex = g_HeroUseItems[k].MakeIndex) then begin
          SafeFillChar(g_HeroUseItems[k], SizeOf(TClientItem), #0);
        end;
      end;
      if (g_HeroUseItems[I].S.Name = g_MovingItem.Item.S.Name) and (g_HeroUseItems[I].MakeIndex = g_MovingItem.Item.MakeIndex) then begin
        g_MovingItem.Index := 0;
        g_MovingItem.Item.S.Name := '';
      end;
    end;
  end;

  for I := Low(g_HeroItemArr) to High(g_HeroItemArr) do begin
    if g_HeroItemArr[I].S.Name <> '' then begin
      for k := Low(g_ItemArr) to High(g_ItemArr) do begin //检测复制物品
        if (g_HeroItemArr[I].S.Name = g_ItemArr[k].S.Name) and (g_HeroItemArr[I].MakeIndex = g_ItemArr[k].MakeIndex) then begin
          SafeFillChar(g_HeroItemArr[I], SizeOf(TClientItem), #0);
        end;
      end;
      {for k := Low(g_UseItems) to High(g_UseItems) do begin
        if (g_HeroItemArr[I].S.Name = g_UseItems[k].S.Name) and (g_HeroItemArr[I].MakeIndex = g_UseItems[k].MakeIndex) then begin
          SafeFillChar(g_HeroItemArr[I], SizeOf(TClientItem), #0);
        end;
      end;}
    end;
  end;
  for I := Low(g_HeroUseItems) to High(g_HeroUseItems) do begin
    if g_HeroUseItems[I].S.Name <> '' then begin
      for k := Low(g_ItemArr) to High(g_ItemArr) do begin //检测复制物品
        if (g_HeroUseItems[I].S.Name = g_ItemArr[k].S.Name) and (g_HeroUseItems[I].MakeIndex = g_ItemArr[k].MakeIndex) then begin
          SafeFillChar(g_HeroUseItems[I], SizeOf(TClientItem), #0);
        end;
      end;
      for k := Low(g_UseItems) to High(g_UseItems) do begin
        if (g_HeroUseItems[I].S.Name = g_UseItems[k].S.Name) and (g_HeroUseItems[I].MakeIndex = g_UseItems[k].MakeIndex) then begin
          SafeFillChar(g_HeroUseItems[I], SizeOf(TClientItem), #0);
        end;
      end;
    end;
  end;
  {for i := MAXHEROBAGITEM - 1 downto 0 do begin
    if g_HeroItemArr[i].S.Name <> '' then begin
      for k := 0 to MAXHEROBAGITEM - 1 do begin
        if g_HeroItemArr[k].S.Name = '' then begin
          g_HeroItemArr[k] := g_HeroItemArr[i];
          g_HeroItemArr[i].S.Name := '';
          break;
        end;
      end;
    end;
  end;}

  {for i := 40 to MAXHEROBAGITEM - 1 do begin
    if g_HeroItemArr[i].S.Name <> '' then begin
      for k := 0 to 39 do begin
        if g_HeroItemArr[k].S.Name = '' then begin
          g_HeroItemArr[k] := g_HeroItemArr[i];
          g_HeroItemArr[i].S.Name := '';
          break;
        end;
      end;
    end;
  end; }
end;

procedure ClearUserDate;
var
  I: Integer;
begin
  for I := Low(g_ItemArr) to High(g_ItemArr) do
    g_ItemArr[I].S.Name := '';
  for I := Low(g_UseItems) to High(g_UseItems) do
    g_UseItems[I].S.Name := '';
end;

procedure ClearDate;
var
  I, II: Integer;
begin
 { for I := Low(g_PlaySortItems) to High(g_PlaySortItems) do begin
    g_PlaySortItems[I].sChrName := '';
  end;
  for I := Low(g_HeroSortItems) to High(g_HeroSortItems) do begin
    g_HeroSortItems[I].sHeroName := '';
    g_HeroSortItems[I].sChrName := '';
  end;
  for I := Low(g_UserMasterItems) to High(g_UserMasterItems) do begin
    g_UserMasterItems[I].sChrName := '';
  end;}
  for I := 0 to 4 do begin
    for II := 0 to 9 do begin
      g_ShopItems[I, II].StdItem.Name := '';
    end;
  end;
  for I := Low(g_SuperShopItems) to High(g_SuperShopItems) do begin
    g_SuperShopItems[I].StdItem.Name := '';
  end;
end;

procedure ClearHeroDate;
var
  I: Integer;
begin
  for I := 0 to g_HeroMagicList.Count - 1 do begin
    Dispose(PTClientMagic(g_HeroMagicList[I]));
  end;
  g_HeroMagicList.Clear;

  for I := Low(g_HeroItemArr) to High(g_HeroItemArr) do
    g_HeroItemArr[I].S.Name := '';

  for I := Low(g_HeroUseItems) to High(g_HeroUseItems) do
    g_HeroUseItems[I].S.Name := '';
end;

procedure ClearBag;
var
  I: Integer;
begin
  for I := Low(g_ItemArr) to High(g_ItemArr) do
    g_ItemArr[I].S.Name := '';
  for I := Low(g_HeroItemArr) to High(g_HeroItemArr) do
    g_HeroItemArr[I].S.Name := '';
end;

function AddItemBag(cu: TClientItem): Boolean;
var
  I: Integer;
  boFind: Boolean;
begin
  Result := False;
  boFind := False;
  if cu.S.Name = '' then Exit;
  for I := Low(g_ItemArr) to High(g_ItemArr) do begin
    if (g_ItemArr[I].MakeIndex = cu.MakeIndex) and (g_ItemArr[I].S.Name = cu.S.Name) then begin
      g_ItemArr[I] := cu;
      boFind := True;
      Break;
    end;
  end;
  if (cu.S.StdMode <= 3) and not boFind then begin
    for I := 0 to 5 do
      if g_ItemArr[I].S.Name = '' then begin
        g_ItemArr[I] := cu;
        Result := True;
        boFind := True;
      end;
  end;
  if not boFind then begin
    for I := 6 to High(g_ItemArr) do begin
      if g_ItemArr[I].S.Name = '' then begin
        g_ItemArr[I] := cu;
        Result := True;
        Break;
      end;
    end;
  end;
  ArrangeItemBag;
end;

function UpdateItemBag(cu: TClientItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := High(g_ItemArr) downto Low(g_ItemArr) do begin
    if (g_ItemArr[I].S.Name = cu.S.Name) and (g_ItemArr[I].MakeIndex = cu.MakeIndex) then begin
      g_ItemArr[I] := cu;
      Result := True;
      Break;
    end;
  end;
end;

function UpdateItemBag2(cu: TClientItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := High(g_ItemArr) downto Low(g_ItemArr) do begin
    if {(g_ItemArr[I].S.Name = cu.S.Name) and }(g_ItemArr[I].MakeIndex = cu.MakeIndex) then begin
      g_ItemArr[I] := cu;
      Result := True;
      Break;
    end;
  end;
end;

function DelItemBag(iname: string; iindex: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := High(g_ItemArr) downto Low(g_ItemArr) do begin
    if (g_ItemArr[I].S.Name = iname) and (g_ItemArr[I].MakeIndex = iindex) then begin
      SafeFillChar(g_ItemArr[I], SizeOf(TClientItem), #0);
      Result := True;
      Break;
    end;
  end;
  ArrangeItemBag;
end;

procedure ArrangeItemBag;
var
  I, k: Integer;
begin
  for I := Low(g_ItemArr) to High(g_ItemArr) do begin
    if g_ItemArr[I].S.Name <> '' then begin
      for k := I + 1 to High(g_ItemArr) - 1 do begin
        if (g_ItemArr[I].S.Name = g_ItemArr[k].S.Name) and (g_ItemArr[I].MakeIndex = g_ItemArr[k].MakeIndex) then begin
          SafeFillChar(g_ItemArr[k], SizeOf(TClientItem), #0);
        end;
      end;
     { for k := Low(g_UseItems) to High(g_UseItems) do begin
        if (g_ItemArr[I].S.Name = g_UseItems[k].S.Name) and (g_ItemArr[I].MakeIndex = g_UseItems[k].MakeIndex) then begin
          SafeFillChar(g_ItemArr[I], SizeOf(TClientItem), #0);
        end;
      end;}
      {for k:=0 to 9 do begin
         if (ItemArr[i].S.Name = DealItems[k].S.Name) and (ItemArr[i].MakeIndex = DealItems[k].MakeIndex) then begin
            FillChar (ItemArr[i], sizeof(TClientItem), #0);
            //FillChar (DealItems[k], sizeof(TClientItem), #0);
         end;
      end; }
      if (g_ItemArr[I].S.Name = g_MovingItem.Item.S.Name) and (g_ItemArr[I].MakeIndex = g_MovingItem.Item.MakeIndex) then begin
        g_MovingItem.Index := 0;
        g_MovingItem.Item.S.Name := '';
      end;
    end;
  end;

  for I := Low(g_UseItems) to High(g_UseItems) do begin
    if g_UseItems[I].S.Name <> '' then begin
      for k := I + 1 to High(g_UseItems) - 1 do begin //检测复制物品
        if (g_UseItems[I].S.Name = g_UseItems[k].S.Name) and (g_UseItems[I].MakeIndex = g_UseItems[k].MakeIndex) then begin
          SafeFillChar(g_UseItems[k], SizeOf(TClientItem), #0);
        end;
      end;
      if (g_UseItems[I].S.Name = g_MovingItem.Item.S.Name) and (g_UseItems[I].MakeIndex = g_MovingItem.Item.MakeIndex) then begin
        g_MovingItem.Index := 0;
        g_MovingItem.Item.S.Name := '';
      end;
    end;
  end;

  if g_MyHero <> nil then begin
    for I := Low(g_ItemArr) to High(g_ItemArr) do begin
      if g_ItemArr[I].S.Name <> '' then begin
        for k := Low(g_HeroItemArr) to High(g_HeroItemArr) do begin //检测复制物品
          if (g_ItemArr[I].S.Name = g_HeroItemArr[k].S.Name) and (g_ItemArr[I].MakeIndex = g_HeroItemArr[k].MakeIndex) then begin
            SafeFillChar(g_ItemArr[I], SizeOf(TClientItem), #0);
          end;
        end;
        {for k := Low(g_HeroUseItems) to High(g_HeroUseItems) do begin
          if (g_ItemArr[I].S.Name = g_HeroUseItems[k].S.Name) and (g_ItemArr[I].MakeIndex = g_HeroUseItems[k].MakeIndex) then begin
            SafeFillChar(g_ItemArr[I], SizeOf(TClientItem), #0);
          end;
        end;}
      end;
    end;
    for I := Low(g_UseItems) to High(g_UseItems) do begin
      if g_UseItems[I].S.Name <> '' then begin
        for k := Low(g_HeroItemArr) to High(g_HeroItemArr) do begin //检测复制物品
          if (g_UseItems[I].S.Name = g_HeroItemArr[k].S.Name) and (g_UseItems[I].MakeIndex = g_HeroItemArr[k].MakeIndex) then begin
            SafeFillChar(g_UseItems[I], SizeOf(TClientItem), #0);
          end;
        end;
        for k := Low(g_HeroUseItems) to High(g_HeroUseItems) do begin
          if (g_UseItems[I].S.Name = g_HeroUseItems[k].S.Name) and (g_UseItems[I].MakeIndex = g_HeroUseItems[k].MakeIndex) then begin
            SafeFillChar(g_UseItems[I], SizeOf(TClientItem), #0);
          end;
        end;
      end;
    end;
  end;
  {for i := MAXBAGITEMCL - 1 downto 6 do begin
    if g_ItemArr[i].S.Name <> '' then begin
      for k := 6 to MAXBAGITEMCL - 1 do begin
        if g_ItemArr[k].S.Name = '' then begin
          g_ItemArr[k] := g_ItemArr[i];
          g_ItemArr[i].S.Name := '';
          break;
        end;
      end;
    end;
  end;}

  {for i := 46 to MAXBAGITEMCL - 1 do begin
    if g_ItemArr[i].S.Name <> '' then begin
      for k := 6 to 45 do begin
        if g_ItemArr[k].S.Name = '' then begin
          g_ItemArr[k] := g_ItemArr[i];
          g_ItemArr[i].S.Name := '';
          break;
        end;
      end;
    end;
  end; }
end;

{----------------------------------------------------------}


procedure AddDropItem(ci: TClientItem);
var
  pc: PTClientItem;
begin
  New(pc);
  pc^ := ci;
  DropItems.Add(pc);
end;

function GetDropItem(iname: string; MakeIndex: Integer): PTClientItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to DropItems.Count - 1 do begin
    if (PTClientItem(DropItems[I]).S.Name = iname) and (PTClientItem(DropItems[I]).MakeIndex = MakeIndex) then begin
      Result := PTClientItem(DropItems[I]);
      Break;
    end;
  end;
end;

procedure DelDropItem(iname: string; MakeIndex: Integer);
var
  I: Integer;
begin
  for I := 0 to DropItems.Count - 1 do begin
    if (PTClientItem(DropItems[I]).S.Name = iname) and (PTClientItem(DropItems[I]).MakeIndex = MakeIndex) then begin
      Dispose(PTClientItem(DropItems[I]));
      DropItems.Delete(I);
      Break;
    end;
  end;
end;
{----------------------------------------------------------}

procedure AddDuelItem(ci: TClientItem);
var
  I: Integer;
begin
  for I := 0 to 5 - 1 do begin
    if g_DuelItems[I].S.Name = '' then begin
      g_DuelItems[I] := ci;
      Break;
    end;
  end;
end;

procedure DelDuelItem(ci: TClientItem);
var
  I: Integer;
begin
  for I := 0 to 5 - 1 do begin
    if (g_DuelItems[I].S.Name = ci.S.Name) and (g_DuelItems[I].MakeIndex = ci.MakeIndex) then begin
      SafeFillChar(g_DuelItems[I], SizeOf(TClientItem), #0);
      Break;
    end;
  end;
end;

procedure MoveDuelItemToBag;
var
  I: Integer;
begin
  for I := 0 to 5 - 1 do begin
    if g_DuelItems[I].S.Name <> '' then
      AddItemBag(g_DuelItems[I]);
  end;
  SafeFillChar(g_DuelItems, SizeOf(TClientItem) * 5, #0);
end;

procedure AddDuelRemoteItem(ci: TClientItem);
var
  I: Integer;
begin
  for I := 0 to 5 - 1 do begin
    if g_DuelRemoteItems[I].S.Name = '' then begin
      g_DuelRemoteItems[I] := ci;
      Break;
    end;
  end;
end;

procedure DelDuelRemoteItem(ci: TClientItem);
var
  I: Integer;
begin
  for I := 0 to 5 - 1 do begin
    if (g_DuelRemoteItems[I].S.Name = ci.S.Name) and (g_DuelRemoteItems[I].MakeIndex = ci.MakeIndex) then begin
      SafeFillChar(g_DuelRemoteItems[I], SizeOf(TClientItem), #0);
      Break;
    end;
  end;
end;

procedure DelStoreItem(ci: TClientItem);
var
  I: Integer;
begin
  for I := 0 to 15 - 1 do begin
    if (g_StoreItems[I].Item.S.Name = ci.S.Name) and (g_StoreItems[I].Item.MakeIndex = ci.MakeIndex) then begin
      SafeFillChar(g_StoreItems[I].Item, SizeOf(TClientItem), #0);
      Break;
    end;
  end;
end;

procedure DelStoreRemoteItem(ci: TClientItem);
var
  I: Integer;
begin
  for I := 0 to 15 - 1 do begin
    if (g_StoreRemoteItems[I].Item.S.Name = ci.S.Name) and (g_StoreRemoteItems[I].Item.MakeIndex = ci.MakeIndex) then begin
      SafeFillChar(g_StoreRemoteItems[I].Item, SizeOf(TClientItem), #0);
      Break;
    end;
  end;
end;
{----------------------------------------------------------}
{----------------------------------------------------------}

procedure AddDealItem(ci: TClientItem);
var
  I: Integer;
begin
  for I := 0 to 10 - 1 do begin
    if g_DealItems[I].S.Name = '' then begin
      g_DealItems[I] := ci;
      Break;
    end;
  end;
end;

procedure DelDealItem(ci: TClientItem);
var
  I: Integer;
begin
  for I := 0 to 10 - 1 do begin
    if (g_DealItems[I].S.Name = ci.S.Name) and (g_DealItems[I].MakeIndex = ci.MakeIndex) then begin
      SafeFillChar(g_DealItems[I], SizeOf(TClientItem), #0);
      Break;
    end;
  end;
end;

procedure MoveDealItemToBag;
var
  I: Integer;
begin
  for I := 0 to 10 - 1 do begin
    if g_DealItems[I].S.Name <> '' then
      AddItemBag(g_DealItems[I]);
  end;
  SafeFillChar(g_DealItems, SizeOf(TClientItem) * 10, #0);
end;

procedure AddDealRemoteItem(ci: TClientItem);
var
  I: Integer;
begin
  for I := 0 to 20 - 1 do begin
    if g_DealRemoteItems[I].S.Name = '' then begin
      g_DealRemoteItems[I] := ci;
      Break;
    end;
  end;
end;

procedure DelDealRemoteItem(ci: TClientItem);
var
  I: Integer;
begin
  for I := 0 to 20 - 1 do begin
    if (g_DealRemoteItems[I].S.Name = ci.S.Name) and (g_DealRemoteItems[I].MakeIndex = ci.MakeIndex) then begin
      SafeFillChar(g_DealRemoteItems[I], SizeOf(TClientItem), #0);
      Break;
    end;
  end;
end;

{----------------------------------------------------------}

function GetDistance(sx, sY, dx, dy: Integer): Integer;
begin
  Result := _MAX(abs(sx - dx), abs(sY - dy));
end;

procedure GetNextPosXY(dir: Byte; var X, Y: Integer);
begin
  case dir of
    DR_UP: begin
        X := X; Y := Y - 1; end;
    DR_UPRIGHT: begin
        X := X + 1; Y := Y - 1; end;
    DR_RIGHT: begin
        X := X + 1; Y := Y; end;
    DR_DOWNRIGHT: begin
        X := X + 1; Y := Y + 1; end;
    DR_DOWN: begin
        X := X; Y := Y + 1; end;
    DR_DOWNLEFT: begin
        X := X - 1; Y := Y + 1; end;
    DR_LEFT: begin
        X := X - 1; Y := Y; end;
    DR_UPLEFT: begin
        X := X - 1; Y := Y - 1; end;
  end;
end;

procedure GetNextRunXY(dir: Byte; var X, Y: Integer);
begin
  case dir of
    DR_UP: begin
        X := X; Y := Y - 2; end;
    DR_UPRIGHT: begin
        X := X + 2; Y := Y - 2; end;
    DR_RIGHT: begin
        X := X + 2; Y := Y; end;
    DR_DOWNRIGHT: begin
        X := X + 2; Y := Y + 2; end;
    DR_DOWN: begin
        X := X; Y := Y + 2; end;
    DR_DOWNLEFT: begin
        X := X - 2; Y := Y + 2; end;
    DR_LEFT: begin
        X := X - 2; Y := Y; end;
    DR_UPLEFT: begin
        X := X - 2; Y := Y - 2; end;
  end;
end;

procedure GetNextHorseRunXY(dir: Byte; var X, Y: Integer);
begin
  case dir of
    DR_UP: begin
        X := X; Y := Y - 3; end;
    DR_UPRIGHT: begin
        X := X + 3; Y := Y - 3; end;
    DR_RIGHT: begin
        X := X + 3; Y := Y; end;
    DR_DOWNRIGHT: begin
        X := X + 3; Y := Y + 3; end;
    DR_DOWN: begin
        X := X; Y := Y + 3; end;
    DR_DOWNLEFT: begin
        X := X - 3; Y := Y + 3; end;
    DR_LEFT: begin
        X := X - 3; Y := Y; end;
    DR_UPLEFT: begin
        X := X - 3; Y := Y - 3; end;
  end;
end;

function GetNextDirection(sx, sY, dx, dy: Integer): Byte;
var
  flagx, flagy: Integer;
begin
  Result := DR_DOWN;
  if sx < dx then flagx := 1
  else if sx = dx then flagx := 0
  else flagx := -1;
  if abs(sY - dy) > 2
    then if (sx >= dx - 1) and (sx <= dx + 1) then flagx := 0;

  if sY < dy then flagy := 1
  else if sY = dy then flagy := 0
  else flagy := -1;
  if abs(sx - dx) > 2 then if (sY > dy - 1) and (sY <= dy + 1) then flagy := 0;

  if (flagx = 0) and (flagy = -1) then Result := DR_UP;
  if (flagx = 1) and (flagy = -1) then Result := DR_UPRIGHT;
  if (flagx = 1) and (flagy = 0) then Result := DR_RIGHT;
  if (flagx = 1) and (flagy = 1) then Result := DR_DOWNRIGHT;
  if (flagx = 0) and (flagy = 1) then Result := DR_DOWN;
  if (flagx = -1) and (flagy = 1) then Result := DR_DOWNLEFT;
  if (flagx = -1) and (flagy = 0) then Result := DR_LEFT;
  if (flagx = -1) and (flagy = -1) then Result := DR_UPLEFT;
end;

function GetBack(dir: Integer): Integer;
begin
  Result := DR_UP;
  case dir of
    DR_UP: Result := DR_DOWN;
    DR_DOWN: Result := DR_UP;
    DR_LEFT: Result := DR_RIGHT;
    DR_RIGHT: Result := DR_LEFT;
    DR_UPLEFT: Result := DR_DOWNRIGHT;
    DR_UPRIGHT: Result := DR_DOWNLEFT;
    DR_DOWNLEFT: Result := DR_UPRIGHT;
    DR_DOWNRIGHT: Result := DR_UPLEFT;
  end;
end;

procedure GetBackPosition(sx, sY, dir: Integer; var NewX, NewY: Integer);
begin
  NewX := sx;
  NewY := sY;
  case dir of
    DR_UP: NewY := NewY + 1;
    DR_DOWN: NewY := NewY - 1;
    DR_LEFT: NewX := NewX + 1;
    DR_RIGHT: NewX := NewX - 1;
    DR_UPLEFT: begin
        NewX := NewX + 1;
        NewY := NewY + 1;
      end;
    DR_UPRIGHT: begin
        NewX := NewX - 1;
        NewY := NewY + 1;
      end;
    DR_DOWNLEFT: begin
        NewX := NewX + 1;
        NewY := NewY - 1;
      end;
    DR_DOWNRIGHT: begin
        NewX := NewX - 1;
        NewY := NewY - 1;
      end;
  end;
end;

procedure GetFrontPosition(sx, sY, dir: Integer; var NewX, NewY: Integer);
begin
  NewX := sx;
  NewY := sY;
  case dir of
    DR_UP: NewY := NewY - 1;
    DR_DOWN: NewY := NewY + 1;
    DR_LEFT: NewX := NewX - 1;
    DR_RIGHT: NewX := NewX + 1;
    DR_UPLEFT: begin
        NewX := NewX - 1;
        NewY := NewY - 1;
      end;
    DR_UPRIGHT: begin
        NewX := NewX + 1;
        NewY := NewY - 1;
      end;
    DR_DOWNLEFT: begin
        NewX := NewX - 1;
        NewY := NewY + 1;
      end;
    DR_DOWNRIGHT: begin
        NewX := NewX + 1;
        NewY := NewY + 1;
      end;
  end;
end;

procedure GetFrontPosition(sx, sY, dir, nFlag: Integer; var NewX, NewY: Integer);
begin
  NewX := sx;
  NewY := sY;
  case dir of
    DR_UP: NewY := NewY - nFlag;
    DR_DOWN: NewY := NewY + nFlag;
    DR_LEFT: NewX := NewX - nFlag;
    DR_RIGHT: NewX := NewX + nFlag;
    DR_UPLEFT: begin
        NewX := NewX - nFlag;
        NewY := NewY - nFlag;
      end;
    DR_UPRIGHT: begin
        NewX := NewX + nFlag;
        NewY := NewY - nFlag;
      end;
    DR_DOWNLEFT: begin
        NewX := NewX - nFlag;
        NewY := NewY + nFlag;
      end;
    DR_DOWNRIGHT: begin
        NewX := NewX + nFlag;
        NewY := NewY + nFlag;
      end;
  end;
end;

procedure GetPixelFrontPosition(sx, sY, dir, nFlag: Integer; var NewX, NewY: Integer);
begin
  NewX := sx;
  NewY := sY;
  case dir of
    DR_UP: NewY := NewY - nFlag * UNITY;
    DR_DOWN: NewY := NewY + nFlag * UNITY;
    DR_LEFT: NewX := NewX - nFlag * UNITX;
    DR_RIGHT: NewX := NewX + nFlag * UNITX;
    DR_UPLEFT: begin
        NewX := NewX - nFlag * UNITX;
        NewY := NewY - nFlag * UNITY;
      end;
    DR_UPRIGHT: begin
        NewX := NewX + nFlag * UNITX;
        NewY := NewY - nFlag * UNITY;
      end;
    DR_DOWNLEFT: begin
        NewX := NewX - nFlag * UNITX;
        NewY := NewY + nFlag * UNITY;
      end;
    DR_DOWNRIGHT: begin
        NewX := NewX + nFlag * UNITX;
        NewY := NewY + nFlag * UNITY;
      end;
  end;
end;

function GetFlyDirection(sx, sY, ttx, tty: Integer): Integer;
var
  fx, fy: Real;
begin
  fx := ttx - sx;
  fy := tty - sY;
  sx := 0;
  sY := 0;
  Result := DR_DOWN;
  if fx = 0 then begin
    if fy < 0 then Result := DR_UP
    else Result := DR_DOWN;
    Exit;
  end;
  if fy = 0 then begin
    if fx < 0 then Result := DR_LEFT
    else Result := DR_RIGHT;
    Exit;
  end;
  if (fx > 0) and (fy < 0) then begin
    if - fy > fx * 2.5 then Result := DR_UP
    else if - fy < fx / 3 then Result := DR_RIGHT
    else Result := DR_UPRIGHT;
  end;
  if (fx > 0) and (fy > 0) then begin
    if fy < fx / 3 then Result := DR_RIGHT
    else if fy > fx * 2.5 then Result := DR_DOWN
    else Result := DR_DOWNRIGHT;
  end;
  if (fx < 0) and (fy > 0) then begin
    if fy < -fx / 3 then Result := DR_LEFT
    else if fy > -fx * 2.5 then Result := DR_DOWN
    else Result := DR_DOWNLEFT;
  end;
  if (fx < 0) and (fy < 0) then begin
    if - fy > -fx * 2.5 then Result := DR_UP
    else if - fy < -fx / 3 then Result := DR_LEFT
    else Result := DR_UPLEFT;
  end;
end;

function GetFlyDirection16(sx, sY, ttx, tty: Integer): Integer;
var
  fx, fy: Real;
begin
  fx := ttx - sx;
  fy := tty - sY;
  sx := 0;
  sY := 0;
  Result := 0;
  if fx = 0 then begin
    if fy < 0 then Result := 0
    else Result := 8;
    Exit;
  end;
  if fy = 0 then begin
    if fx < 0 then Result := 12
    else Result := 4;
    Exit;
  end;
  if (fx > 0) and (fy < 0) then begin
    Result := 4;
    if - fy > fx / 4 then Result := 3;
    if - fy > fx / 1.9 then Result := 2;
    if - fy > fx * 1.4 then Result := 1;
    if - fy > fx * 4 then Result := 0;
  end;
  if (fx > 0) and (fy > 0) then begin
    Result := 4;
    if fy > fx / 4 then Result := 5;
    if fy > fx / 1.9 then Result := 6;
    if fy > fx * 1.4 then Result := 7;
    if fy > fx * 4 then Result := 8;
  end;
  if (fx < 0) and (fy > 0) then begin
    Result := 12;
    if fy > -fx / 4 then Result := 11;
    if fy > -fx / 1.9 then Result := 10;
    if fy > -fx * 1.4 then Result := 9;
    if fy > -fx * 4 then Result := 8;
  end;
  if (fx < 0) and (fy < 0) then begin
    Result := 12;
    if - fy > -fx / 4 then Result := 13;
    if - fy > -fx / 1.9 then Result := 14;
    if - fy > -fx * 1.4 then Result := 15;
    if - fy > -fx * 4 then Result := 0;
  end;
end;

function PrivDir(ndir: Integer): Integer;
begin
  if ndir - 1 < 0 then Result := 7
  else Result := ndir - 1;
end;

function NextDir(ndir: Integer): Integer;
begin
  if ndir + 1 > 7 then Result := 0
  else Result := ndir + 1;
end;

function GetTakeOnPosition(smode: Integer): Integer;
begin
  Result := -1;
  {
  case smode of //StdMode
     5, 6: //武器
        Result := U_WEAPON;
     10, 11:
        Result := U_DRESS;
     15,16:
        Result := U_HELMET;
     19,20,21:
        Result := U_NECKLACE;
     22,23:
        Result := U_RINGL;
     24,26:
        Result := U_ARMRINGR;
     25:
        Result := U_ARMRINGL;
     30:
        Result := U_RIGHTHAND;
  end;
  }
  case smode of //StdMode
    5, 6: Result := U_WEAPON; //武器
    10, 11: Result := U_DRESS;
    15, 16: Result := U_HELMET;
    19, 20, 21: Result := U_NECKLACE;
    22, 23: Result := U_RINGL;
    24, 26: Result := U_ARMRINGR;
    30, 28, 29: Result := U_RIGHTHAND;
    25, 51: Result := U_BUJUK; //符
    52, 62: Result := U_BOOTS; //鞋
    7, 53, 63: Result := U_CHARM; //宝石
    54, 64: Result := U_BELT; //腰带
  end;
end;

function IsKeyPressed(Key: Byte): Boolean;
var
  keyvalue: TKeyBoardState;
begin
  Result := False;
  FillChar(keyvalue, SizeOf(TKeyBoardState), #0);
  if GetKeyboardState(keyvalue) then
    if (keyvalue[Key] and $80) <> 0 then
      Result := True;
end;

procedure AddChangeFace(recogid: Integer);
begin
  g_ChangeFaceReadyList.Add(Pointer(recogid));
end;

procedure DelChangeFace(recogid: Integer);
var
  I: Integer;
begin
  for I := g_ChangeFaceReadyList.Count - 1 downto 0 do begin
    if Integer(g_ChangeFaceReadyList[I]) = recogid then begin
      g_ChangeFaceReadyList.Delete(I);
      Break;
    end;
  end;
end;

function IsChangingFace(recogid: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to g_ChangeFaceReadyList.Count - 1 do begin
    if Integer(g_ChangeFaceReadyList[I]) = recogid then begin
      Result := True;
      Break;
    end;
  end;
end;


initialization
  DropItems := TList.Create;

finalization
  DropItems.Free;


end.

