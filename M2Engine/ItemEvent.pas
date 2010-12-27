unit ItemEvent;

interface
uses
  Windows, Classes, SysUtils, SyncObjs, ObjBase, Grobal2, SDK, HUtil32;
type
  TItemObject = class(TBaseObject)
    m_wLooks: Word;
    m_btAniCount: Byte;
    m_btReserved: Byte;
    m_nCount: Integer;
    m_OfActorObject: TObject;
    m_DropActorObject: TObject;
    m_dwCanPickUpTick: LongWord;
    m_UserItem: TUserItem;
    m_sName: string[30];

    m_PEnvir: TObject;
    m_boGhost: Boolean; //0x2FC
    m_dwGhostTick: LongWord; //0x300
    m_dwRunTick: LongWord; //0x300
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run();
    procedure MakeGhost;
  end;

  TItemManager = class
    m_ItemList: TGList;
    m_FreeItemList: TGList;
    m_nProcItemIDx: Integer;
  private
    function GetItemCount: Integer;
  public
    constructor Create();
    destructor Destroy; override;
    procedure Run();
    procedure AddItem(ItemObject: TItemObject);
    function FindItem(Envir: TObject; ItemObject: TItemObject): TItemObject; overload;
    function FindItem(Envir: TObject; nX, nY: Integer): TItemObject; overload;
    function FindItem(Envir: TObject; nX, nY: Integer; ItemObject: TItemObject): TItemObject; overload;
    function FindItem(Envir: TObject; nX, nY, nRange: Integer; List: TList): Integer; overload;
    property ItemCount: Integer read GetItemCount;
  end;
implementation
uses ObjActor, Envir, M2Share;

constructor TItemObject.Create();
begin
  inherited;
  m_ObjType := t_Item;
  m_sName := '';

  m_wLooks := 0;
  m_btAniCount := 0;
  m_btReserved := 0;
  m_nCount := 0;
  m_OfActorObject := nil;
  m_DropActorObject := nil;
  m_dwCanPickUpTick := 0;

  m_PEnvir := nil;
  m_boGhost := False;
  m_dwGhostTick := 0;
  m_dwRunTick := GetTickCount;
  FillChar(m_UserItem, SizeOf(TUserItem), #0);
end;

destructor TItemObject.Destroy;
begin
  if m_PEnvir <> nil then begin
    TEnvirnoment(m_PEnvir).DeleteFromMap(m_nMapX, m_nMapY, Self);
    m_PEnvir := nil;
  end;
  //g_TestList.Add('Handle:'+IntToStr(Integer(Self))+' TItemObject.Destroy');
  inherited;
end;

procedure TItemObject.Run();
begin
  if not m_boGhost then begin
    if (((GetTickCount - m_dwAddTime) > g_Config.dwClearDropOnFloorItemTime {60 * 60 * 1000}) or
      (m_UserItem.AddValue[0] = 1) and (GetDayCount(m_UserItem.MaxDate, Now) <= 0)) then begin //删除到期装备
      m_boGhost := True;
      m_dwGhostTick := GetTickCount;
    end;
  end;

  if not m_boGhost then begin
    if (m_OfActorObject <> nil) or (m_DropActorObject <> nil) then begin
      if (GetTickCount - m_dwCanPickUpTick) > g_Config.dwFloorItemCanPickUpTime {2 * 60 * 1000} then begin
        m_OfActorObject := nil;
        m_DropActorObject := nil;
      end else begin
        if TActorObject(m_OfActorObject) <> nil then begin
          if TActorObject(m_OfActorObject).m_boGhost then m_OfActorObject := nil;
        end;
        if TActorObject(m_DropActorObject) <> nil then begin
          if TActorObject(m_DropActorObject).m_boGhost then m_DropActorObject := nil;
        end;
      end;
    end;
  end else begin
    if m_PEnvir <> nil then begin
      TEnvirnoment(m_PEnvir).DeleteFromMap(m_nMapX, m_nMapY, Self);
      m_PEnvir := nil;
    end;
  end;
end;

procedure TItemObject.MakeGhost;
begin
  m_boGhost := True;
  m_dwGhostTick := GetTickCount;
  //m_PEnvir := nil;
end;

constructor TItemManager.Create();
begin
  m_ItemList := TGList.Create;
  m_FreeItemList := TGList.Create;
  m_nProcItemIDx := 0;
end;

destructor TItemManager.Destroy;
var
  I: Integer;
begin
  for I := 0 to m_ItemList.Count - 1 do begin
    TItemObject(m_ItemList.Items[I]).Free;
  end;
  m_ItemList.Free;

  for I := 0 to m_FreeItemList.Count - 1 do begin
    TItemObject(m_FreeItemList.Items[I]).Free;
  end;
  m_FreeItemList.Free;
  inherited;
end;

function TItemManager.GetItemCount: Integer;
begin
  //m_ItemList.Lock;
  //try
  Result := m_ItemList.Count;
  //finally
  //  m_ItemList.UnLock;
  //end;
end;

procedure TItemManager.AddItem(ItemObject: TItemObject);
begin
  //m_ItemList.Lock;
  //try
  m_ItemList.Add(ItemObject);
  //finally
  //  m_ItemList.UnLock;
  //end;
end;

function TItemManager.FindItem(Envir: TObject; ItemObject: TItemObject): TItemObject;
var
  I: Integer;
begin
  Result := nil;
  //m_ItemList.Lock;
  //try
  for I := 0 to m_ItemList.Count - 1 do begin
    if (not TItemObject(m_ItemList.Items[I]).m_boGhost) and (TItemObject(m_ItemList.Items[I]).m_PEnvir = Envir) and (TItemObject(m_ItemList.Items[I]) = ItemObject) then begin
      Result := TItemObject(m_ItemList.Items[I]);
      Break;
    end;
  end;
  //finally
  //  m_ItemList.UnLock;
  //end;
end;

function TItemManager.FindItem(Envir: TObject; nX, nY: Integer): TItemObject;
var
  I: Integer;
  ItemObject: TItemObject;
begin
  Result := nil;
 // m_ItemList.Lock;
 // try
  for I := 0 to m_ItemList.Count - 1 do begin
    ItemObject := TItemObject(m_ItemList.Items[I]);
    if (not ItemObject.m_boGhost) and (ItemObject.m_PEnvir = Envir) and
      (ItemObject.m_nMapX = nX) and
      (ItemObject.m_nMapY = nY) then begin
      Result := ItemObject;
      Break;
    end;
  end;
 // finally
 //   m_ItemList.UnLock;
 // end;
end;

function TItemManager.FindItem(Envir: TObject; nX, nY: Integer; ItemObject: TItemObject): TItemObject;
var
  I: Integer;
  AItemObject: TItemObject;
begin
  Result := nil;
 // m_ItemList.Lock;
 // try
  for I := 0 to m_ItemList.Count - 1 do begin
    AItemObject := TItemObject(m_ItemList.Items[I]);
    if (not AItemObject.m_boGhost) and (AItemObject.m_PEnvir = Envir) and (AItemObject = ItemObject) and
      (ItemObject.m_nMapX = nX) and
      (ItemObject.m_nMapY = nY) then begin
      Result := ItemObject;
      Break;
    end;
  end;
  {finally
    m_ItemList.UnLock;
  end;}
end;

function TItemManager.FindItem(Envir: TObject; nX, nY, nRange: Integer; List: TList): Integer;
var
  I, nCount: Integer;
  ItemObject: TItemObject;
begin
  Result := 0;
  nCount := 0;
  //m_ItemList.Lock;
 // try
  for I := 0 to m_ItemList.Count - 1 do begin
    ItemObject := TItemObject(m_ItemList.Items[I]);
    if (not ItemObject.m_boGhost) and (ItemObject.m_PEnvir = Envir) and
      (abs(ItemObject.m_nMapX - nX) <= nRange) and
      (abs(ItemObject.m_nMapY - nY) <= nRange) then begin
      Inc(nCount);
      if List <> nil then List.Add(ItemObject);
    end;
  end;
  Result := nCount;
  //finally
  //  m_ItemList.UnLock;
  //end;
end;

procedure TItemManager.Run();
var
  I, nIdx: Integer;
  ItemObject: TItemObject;
  dwCurTick, dwCheckTime: LongWord;
  boCheckTimeLimit: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TItemManager::Run';
begin
  boCheckTimeLimit := False;
  dwCheckTime := GetTickCount();
  dwCurTick := GetTickCount();
  nIdx := m_nProcItemIDx;
  try
    //m_ItemList.Lock;
    //try
    while True do begin
      if m_ItemList.Count <= nIdx then Break;

      ItemObject := TItemObject(m_ItemList.Items[nIdx]);
      if (not ItemObject.m_boGhost) and ((GetTickCount - ItemObject.m_dwRunTick) > 250) then begin
        ItemObject.m_dwRunTick := GetTickCount();
        ItemObject.Run();
      end;

      if ItemObject.m_boGhost then begin
        m_FreeItemList.Add(ItemObject);
        m_ItemList.Delete(nIdx);
        Continue;
      end;

      Inc(nIdx);
      if (GetTickCount - dwCheckTime) > 10 then begin
        boCheckTimeLimit := True;
        m_nProcItemIDx := nIdx;
        Break;
      end;
    end; //while True do begin
    {finally
      m_ItemList.UnLock;
    end;}
    if not boCheckTimeLimit then m_nProcItemIDx := 0;
  except
    MainOutMessage(sExceptionMsg);
  end;
  {
  m_ItemList.Lock;
  try
    for I := m_ItemList.Count - 1 downto 0 do begin
      ItemObject := TItemObject(m_ItemList.Items[I]);
      if (not ItemObject.m_boGhost) and ((GetTickCount - ItemObject.m_dwRunTick) > 250) then begin
        ItemObject.m_dwRunTick := GetTickCount();
        ItemObject.Run();
      end;
      if ItemObject.m_boGhost then begin
        m_FreeItemList.Add(ItemObject);
        m_ItemList.Delete(I);
      end;
    end;
  finally
    m_ItemList.UnLock;
  end; }

 { m_FreeItemList.Lock;
  try }
  for I := 0 to m_FreeItemList.Count - 1 do begin
    ItemObject := TItemObject(m_FreeItemList.Items[I]);
    if (GetTickCount - ItemObject.m_dwGhostTick) > 5 * 60 * 1000 then begin
      m_FreeItemList.Delete(I);
      ItemObject.Free;
      break;
    end;
  end;
  {finally
    m_FreeItemList.UnLock;
  end;  }
end;

end.

