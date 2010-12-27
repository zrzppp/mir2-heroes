unit Event;

interface

uses
  Windows, Classes, SysUtils, SyncObjs, ObjActor, ObjBase, Envir, Grobal2, SDK, HUtil32;
type
  TEvent = class;

  pTMagicEvent = ^TMagicEvent;
  TMagicEvent = record
    BaseObjectList: TList;
    dwStartTick: DWord;
    dwTime: DWord;
    Events: array[0..7] of TEvent;
  end;

  TEvent = class(TBaseObject)
    //nVisibleFlag: Integer;
    m_Envir: TEnvirnoment;
    m_nX: Integer;
    m_nY: Integer;
    m_nServerEventType: Integer;
    m_nEventType: Integer;
    m_nEventParam: Integer;
    m_dwOpenStartTick: LongWord;
    m_dwContinueTime: LongWord; //  显示时间长度
    m_dwCloseTick: LongWord;
    m_boClosed: Boolean;
    m_nDamage: Integer;
    m_OwnActorObject: TActorObject;
    m_dwRunStart: LongWord;
    m_dwRunTick: LongWord;
    m_boVisible: Boolean;
    m_boActive: Boolean;
    m_boAllowClose: Boolean;
  public
    constructor Create(tEnvir: TEnvirnoment; nTX, nTY, nType, dwETime: Integer; boVisible: Boolean);
    destructor Destroy; override;
    procedure Run(); virtual;
    procedure Close(); virtual;
  end;
  TStoneMineEvent = class(TEvent)
    m_nMineCount: Integer;
    m_nAddStoneCount: Integer;
    m_dwAddStoneMineTick: LongWord;
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer);
    procedure AddStoneMine();
  end;
  TPileStones = class(TEvent)
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType, nTime: Integer);
    procedure AddEventParam();
  end;
  THolyCurtainEvent = class(TEvent)
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType, nTime: Integer);
  end;
  TFireBurnEvent = class(TEvent)
    m_dwRunTick: LongWord;
  public
    constructor Create(Creat: TActorObject; nX, nY: Integer; nType: Integer; nTime, nDamage: Integer);
    procedure Run(); override;
  end;
  TSafeEvent = class(TEvent) //安全区光环
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer);
  end;

  TFlowerEvent = class(TEvent) //烟花
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType, nTime: Integer);
    procedure Run(); override;
  end;

  TSpaceLockEvent = class(TEvent) //空间锁定
  public
    constructor Create(Creat: TActorObject; nX, nY: Integer; nType, nTime: Integer);
    procedure Run(); override;
    procedure Close(); override;
  end;

  TMapMagicEvent = class(TEvent)
    m_VisibleHumanList: TList;
    m_nUseCount: Integer;
    m_nMaxCount: Integer;
    m_btUseType: Byte;
    m_nRange: Integer;
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer);
    destructor Destroy; override;
    procedure Run(); override;
    procedure Close; override;
    function IsProperTarget(BaseObject: TActorObject): Boolean;
    procedure SendRefMsg(wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; sMsg: string);
  end;

  //==============================================================================
  TEventManager = class
    m_EventList: TGList;
    m_ClosedEventList: TGList;
    m_nProcEventIDx: Integer;
  public
    constructor Create();
    destructor Destroy; override;
    function GetEvent(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer): TEvent; overload;
    function GetEvent(Envir: TEnvirnoment; nType: Integer; List: TList): Integer; overload;
    function GetLockEvent(Envir: TEnvirnoment; List: TList): Integer;
    function GetRangeEvent(Envir: TEnvirnoment; OwnActorObject: TActorObject; nX, nY, nRange: Integer; nType: Integer): Integer;
    procedure AddEvent(Event: TEvent);
    function FindEvent(Envir: TEnvirnoment; Event: TEvent): TEvent;
    procedure Run();
  end;

implementation

uses M2Share;
{TMapMagicEvent 地图魔法}

constructor TMapMagicEvent.Create(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer);
begin
  inherited Create(Envir, nX, nY, ET_MAPMAGIC, 1000 * 1000, True);
  m_boAllowClose := False;
  m_boVisible := False;
  m_VisibleHumanList := TList.Create;
  m_nServerEventType := nType;
  m_nRange := 1;
  m_nUseCount := 0;
  m_nMaxCount := 0;
  m_btUseType := 0;
end;

destructor TMapMagicEvent.Destroy;
begin
  m_VisibleHumanList.Free;
  inherited;
end;

procedure TMapMagicEvent.Close;
begin
  m_dwCloseTick := GetTickCount();
  m_boVisible := False;
  if m_Envir <> nil then begin
    m_Envir.DeleteFromMap(m_nX, m_nY, Self);
  end;
  m_Envir := nil;
end;

procedure TMapMagicEvent.Run();
var
  I: Integer;
  ActorObjectList: TList;
  ActorObject: TActorObject;
begin
  if (GetTickCount - m_dwRunTick) > 1500 then begin
    m_dwRunTick := GetTickCount();
    if m_nRange < 0 then m_nRange := 0;
    ActorObjectList := TList.Create;
    if m_Envir.GetRangeActorObject(m_nX, m_nY, m_nRange, False, ActorObjectList) > 0 then begin
      for I := 0 to ActorObjectList.Count - 1 do begin
        ActorObject := TActorObject(ActorObjectList.Items[I]);
        if IsProperTarget(ActorObject) then begin
          ActorObject.SendMsg(nil, RM_MAGSTRUCK_MINE, 0, m_nDamage, 0, 0, '');
        end;
      end;
      SendRefMsg(RM_10205, 0, m_nX, m_nY, m_nServerEventType - 100, '');
      if m_btUseType = 1 then Inc(m_nUseCount);
    end;
    ActorObjectList.Free;
  end;

  if m_btUseType = 1 then begin
    if m_nUseCount >= m_nMaxCount then begin
      m_boClosed := True;
      Close();
    end;
  end else begin
    if m_boAllowClose then begin
      if (GetTickCount - m_dwOpenStartTick) > m_dwContinueTime then begin
        m_boClosed := True;
        Close();
      end;
    end;
    {if (m_OwnActorObject <> nil) and (m_OwnActorObject.m_boGhost or m_OwnActorObject.m_boDeath) then begin
      m_OwnActorObject := nil;
    end;}
  end;
  
end;

function TMapMagicEvent.IsProperTarget(BaseObject: TActorObject): Boolean;
begin
  Result := False;
  if BaseObject <> nil then begin
    Result := (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or ((BaseObject.m_Master <> nil) and (BaseObject.Master.m_btRaceServer = RC_PLAYOBJECT));
  end;
end;

procedure TMapMagicEvent.SendRefMsg(wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; sMsg: string);
  function AddVisibleHuman(ActorObject: TActorObject): Boolean;
  var
    I: Integer;
  begin
    Result := True;
    for I := 0 to m_VisibleHumanList.Count - 1 do begin
      if TActorObject(m_VisibleHumanList.Items[I]) = ActorObject then begin
        Result := False;
        Exit;
      end;
    end;
    m_VisibleHumanList.Add(ActorObject);
  end;
var
  II, III, nC, nListCount: Integer;
  nCX, nCY, nLX, nLY, nHX, nHY, nNX, nNY: Integer;
  MapCellInfo, MapCellInfoA: pTMapCellinfo;
  BaseObject: TBaseObject;
  ActorObject: TActorObject;
  btType: Byte;
  nErrorCode: Integer;

resourcestring
  sExceptionMsg = '[Exception] TMapMagicEvent::SendRefMsg nil m_Envir';
begin
  if m_Envir = nil then begin
    MainOutMessage(sExceptionMsg);
    Exit;
  end;

  EnterCriticalSection(ProcessMsgCriticalSection);
  try
    m_VisibleHumanList.Clear;
    nLX := m_nX - g_Config.nSendRefMsgRange {12};
    nHX := m_nX + g_Config.nSendRefMsgRange {12};
    nLY := m_nY - g_Config.nSendRefMsgRange {12};
    nHY := m_nY + g_Config.nSendRefMsgRange {12};
    for nCX := nLX to nHX do begin
      for nCY := nLY to nHY do begin
        if m_Envir.GetMapCellInfo(nCX, nCY, MapCellInfo) then begin
          if MapCellInfo.ObjList <> nil then begin
            for II := MapCellInfo.ObjList.Count - 1 downto 0 do begin
              BaseObject := TBaseObject(MapCellInfo.ObjList.Items[II]);
              if (BaseObject <> nil) and (BaseObject.m_ObjType = t_Actor) { and (BaseObject <> Self)} then begin
                if (GetTickCount - BaseObject.m_dwAddTime) >= 60 * 1000 then begin
                  MapCellInfo.ObjList.Delete(II);
                  if MapCellInfo.ObjList.Count <= 0 then begin
                    nErrorCode := 3;
                    FreeAndNil(MapCellInfo.ObjList);
                    Break;
                  end;
                end else begin
                  try
                    ActorObject := TActorObject(BaseObject);
                    if (ActorObject <> nil) and (ActorObject.m_PEnvir = m_Envir) and (not ActorObject.m_boGhost) then begin
                      if ActorObject.m_btRaceServer = RC_PLAYOBJECT then begin
                        if AddVisibleHuman(ActorObject) then begin
                          ActorObject.SendMsg({Self} ActorObject, wIdent, wParam, nParam1, nParam2, nParam3, sMsg);
                        end;
                      end else
                        if ActorObject.m_boWantRefMsg then begin
                        if (wIdent = RM_STRUCK) or (wIdent = RM_HEAR) or (wIdent = RM_DEATH) or (wIdent = RM_CHARSTATUSCHANGED) or (wIdent = RM_RUSH) then begin {增加分身的魔法盾效果}
                          if AddVisibleHuman(ActorObject) then begin
                            ActorObject.SendMsg({Self} ActorObject, wIdent, wParam, nParam1, nParam2, nParam3, sMsg);
                          end;
                        end;
                      end;
                    end;
                  except
                    on E: Exception do begin
                      MainOutMessage(Format(sExceptionMsg, ['']));
                      MainOutMessage(E.Message);
                    end;
                  end;
                end;
              end;
            end; //for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          end; //if MapCellInfo.ObjList <> nil then begin
        end; //if PEnvir.GetMapCellInfo(nC,n10,MapCellInfo) then begin
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

//空间锁定
{ TStoneMineEvent }

constructor TSpaceLockEvent.Create(Creat: TActorObject; nX, nY: Integer; nType, nTime: Integer);
begin
  inherited Create(Creat.m_PEnvir, nX, nY, nType, nTime, True);
  m_OwnActorObject := Creat;
  m_nServerEventType := ET_MAGICLOCK;
end;

procedure TSpaceLockEvent.Close();
var
  I: Integer;
begin
  if (m_OwnActorObject <> nil) then begin
    for I := 0 to m_OwnActorObject.m_LockList.Count - 1 do begin
      TActorObject(m_OwnActorObject.m_LockList.Items[I]).m_boSpaceLock := False;
      TActorObject(m_OwnActorObject.m_LockList.Items[I]).m_SpaceOwner := nil;
    end;
    m_OwnActorObject.m_LockList.Clear;
    m_OwnActorObject.m_boSpaceLock := False;
    m_OwnActorObject.m_SpaceOwner := nil;
    m_OwnActorObject := nil;
  end;
  inherited;
end;

procedure TSpaceLockEvent.Run();
begin
  if m_boAllowClose then begin
    if (GetTickCount - m_dwOpenStartTick) > m_dwContinueTime then begin
      m_boClosed := True;
      Close();
    end;
  end;

  if (m_OwnActorObject <> nil) and (m_OwnActorObject.m_boGhost or m_OwnActorObject.m_boDeath) then begin
    m_boClosed := True;
    Close();
  end;

  if (m_OwnActorObject = nil) and (not m_boClosed) then begin
    m_boClosed := True;
    Close();
  end;
  //inherited;
end;

{ TStoneMineEvent }

constructor TStoneMineEvent.Create(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer);
begin
  inherited Create(Envir, nX, nY, nType, 0, False);
  m_Envir.AddToMapMineEvent(nX, nY, Self);
  m_boVisible := False;
  m_nMineCount := Random(200);
  m_dwAddStoneMineTick := GetTickCount();
  m_boActive := False;
  m_nAddStoneCount := Random(80);
  m_boAllowClose := False;
end;

{ TEventManager }

procedure TEventManager.Run;
var
  I: Integer;
  Event: TEvent;
  nIdx: Integer;
  dwCurTick, dwCheckTime: LongWord;
  boCheckTimeLimit: Boolean;
begin
  boCheckTimeLimit := False;
  dwCheckTime := GetTickCount();
  dwCurTick := GetTickCount();
  nIdx := m_nProcEventIDx;

    //m_EventList.Lock;
    //try
  while True do begin
    if m_EventList.Count <= nIdx then Break;

    Event := TEvent(m_EventList.Items[nIdx]);
    if Event.m_boActive and ((GetTickCount - Event.m_dwRunStart) > 250) then begin
      Event.m_dwRunStart := GetTickCount();
      Event.Run();
    end;

    if Event.m_boClosed then begin
      m_ClosedEventList.Add(Event);
      m_EventList.Delete(nIdx);
      Continue;
    end;

    Inc(nIdx);
    if (GetTickCount - dwCheckTime) > 10 then begin
      boCheckTimeLimit := True;
      m_nProcEventIDx := nIdx;
      Break;
    end;
  end; //while True do begin
  
    {finally
      m_EventList.UnLock;
    end;}
  if not boCheckTimeLimit then m_nProcEventIDx := 0;

 (*
  m_EventList.Lock;
  try
    for I := m_EventList.Count - 1 downto 0 do begin
      Event := TEvent(m_EventList.Items[I]);
      if Event.m_boActive and ((GetTickCount - Event.m_dwRunStart) > 250 {Event.m_dwRunTick}) then begin
        Event.m_dwRunStart := GetTickCount();
        Event.Run();
      end;
      if Event.m_boClosed then begin
        {m_ClosedEventList.Lock;
        try}
          m_ClosedEventList.Add(Event);
        {finally
          m_ClosedEventList.UnLock;
        end;}
        m_EventList.Delete(I);
      end;
    end;
  finally
    m_EventList.UnLock;
  end;
  *)

 { m_ClosedEventList.Lock;
  try}
  for I := m_ClosedEventList.Count - 1 downto 0 do begin
    Event := TEvent(m_ClosedEventList.Items[I]);
    if (GetTickCount - Event.m_dwCloseTick) > 5 * 60 * 1000 then begin
      m_ClosedEventList.Delete(I);
      Event.Free;
      break;
    end;
  end;
  {finally
    m_ClosedEventList.UnLock;
  end; }
end;

function TEventManager.GetRangeEvent(Envir: TEnvirnoment; OwnActorObject: TActorObject;
  nX, nY, nRange: Integer; nType: Integer): Integer;
var
  I: Integer;
  Event: TEvent;
begin
  Result := 0;
  m_EventList.Lock;
  try
    for I := 0 to m_EventList.Count - 1 do begin
      Event := TEvent(m_EventList.Items[I]);
      if Event.m_boVisible and (not Event.m_boClosed) and (Event.m_OwnActorObject = OwnActorObject) and
        (abs(Event.m_nX - nX) <= nRange) and
        (abs(Event.m_nY - nY) <= nRange) and
        (Event.m_nEventType = nType) then begin
        Inc(Result);
      end;
    end;
  finally
    m_EventList.UnLock;
  end;
end;

function TEventManager.GetEvent(Envir: TEnvirnoment; nX, nY,
  nType: Integer): TEvent;
var
  I: Integer;
  Event: TEvent;
begin
  Result := nil;
  m_EventList.Lock;
  try
    for I := 0 to m_EventList.Count - 1 do begin
      Event := TEvent(m_EventList.Items[I]);
      if Event.m_boVisible and (not Event.m_boClosed) and (Event.m_Envir = Envir) and
        (Event.m_nX = nX) and
        (Event.m_nY = nY) and
        (Event.m_nEventType = nType) then begin
        Result := Event;
        Break;
      end;
    end;
  finally
    m_EventList.UnLock;
  end;
end;

function TEventManager.GetEvent(Envir: TEnvirnoment; nType: Integer; List: TList): Integer;
var
  I: Integer;
  Event: TEvent;
begin
  Result := 0;
  if List = nil then Exit;
  m_EventList.Lock;
  try
    for I := 0 to m_EventList.Count - 1 do begin
      Event := TEvent(m_EventList.Items[I]);
      if Event.m_boVisible and (not Event.m_boClosed) and (Event.m_Envir = Envir) and
        (Event.m_nEventType = nType) then begin
        List.Add(Event);
      end;
    end;
    Result := List.Count;
  finally
    m_EventList.UnLock;
  end;
end;

function TEventManager.GetLockEvent(Envir: TEnvirnoment; List: TList): Integer;
var
  I: Integer;
  Event: TEvent;
begin
  Result := 0;
  if List = nil then Exit;
  m_EventList.Lock;
  try
    for I := 0 to m_EventList.Count - 1 do begin
      Event := TEvent(m_EventList.Items[I]);
      if Event.m_boVisible and (not Event.m_boClosed) and (Event.m_Envir = Envir) and
        (Event.m_nServerEventType = ET_MAGICLOCK) then begin
        List.Add(Event);
      end;
    end;
    Result := List.Count;
  finally
    m_EventList.UnLock;
  end;
end;

function TEventManager.FindEvent(Envir: TEnvirnoment; Event: TEvent): TEvent;
var
  I: Integer;
begin
  Result := nil;
  m_EventList.Lock;
  try
    for I := 0 to m_EventList.Count - 1 do begin
      if TEvent(m_EventList.Items[I]).m_boVisible and (not TEvent(m_EventList.Items[I]).m_boClosed) and (TEvent(m_EventList.Items[I]).m_Envir = Envir) and (TEvent(m_EventList.Items[I]) = Event) then begin
        Result := TEvent(m_EventList.Items[I]);
        Break;
      end;
    end;
  finally
    m_EventList.UnLock;
  end;
end;

procedure TEventManager.AddEvent(Event: TEvent);
begin
  m_EventList.Lock;
  try
    m_EventList.Add(Event);
  finally
    m_EventList.UnLock;
  end;
end;

constructor TEventManager.Create();
begin
  m_EventList := TGList.Create;
  m_ClosedEventList := TGList.Create;
  m_nProcEventIDx := 0;
end;

destructor TEventManager.Destroy;
var
  I: Integer;
begin
  for I := 0 to m_EventList.Count - 1 do begin
    TEvent(m_EventList.Items[I]).Free;
  end;
  m_EventList.Free;
  for I := 0 to m_ClosedEventList.Count - 1 do begin
    TEvent(m_ClosedEventList.Items[I]).Free;
  end;
  m_ClosedEventList.Free;
  inherited;
end;

{ THolyCurtainEvent }

constructor THolyCurtainEvent.Create(Envir: TEnvirnoment; nX, nY: Integer; nType, nTime: Integer);
begin
  inherited Create(Envir, nX, nY, nType, nTime, True);
end;


{ TSafeEvent 安全区光环}

constructor TSafeEvent.Create(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer);
begin
  inherited Create(Envir, nX, nY, nType, GetTickCount, True);
  m_boAllowClose := False;
end;


{ TFlowerEvent 烟花}

constructor TFlowerEvent.Create(Envir: TEnvirnoment; nX, nY: Integer; nType, nTime: Integer);
begin
  inherited Create(Envir, nX, nY, nType, nTime, True);
end;

procedure TFlowerEvent.Run();
begin
  inherited;
end;

{ TFireBurnEvent }

constructor TFireBurnEvent.Create(Creat: TActorObject; nX, nY: Integer; nType: Integer; nTime, nDamage: Integer);
begin
  inherited Create(Creat.m_PEnvir, nX, nY, nType, nTime, True);
  m_nDamage := nDamage;
  m_OwnActorObject := Creat;
end;

procedure TFireBurnEvent.Run;
var
  I: Integer;
  ActorObjectList: TList;
  TargeTActorObject: TActorObject;
  nPowerValue: Integer;
begin
  if ((GetTickCount - m_dwRunTick) > 3000) then begin
    m_dwRunTick := GetTickCount();
    ActorObjectList := TList.Create;
    if m_Envir <> nil then begin
      nPowerValue := m_nDamage;
      m_Envir.GeTActorObjects(m_nX, m_nY, True, ActorObjectList);
      for I := 0 to ActorObjectList.Count - 1 do begin
        TargeTActorObject := TActorObject(ActorObjectList.Items[I]);
        if (TargeTActorObject <> nil) and (m_OwnActorObject <> nil) and (m_OwnActorObject.IsProperTarget(TargeTActorObject)) then begin

          nPowerValue := m_OwnActorObject._GetAtomPower(TargeTActorObject, AT_FIRE, m_nDamage);
          nPowerValue := nPowerValue + m_OwnActorObject.GetAddPowerPoint(5, nPowerValue);

          TargeTActorObject.SendMsg(m_OwnActorObject, RM_MAGSTRUCK_MINE, 0, nPowerValue, Integer(TargeTActorObject.m_boNotDefendoof), 0, '');
        end;
      end;
    end;
    ActorObjectList.Free;
  end;

  if g_Config.boChangeMapFireExtinguish and (m_OwnActorObject <> nil) and m_boVisible and (not m_boClosed) and (m_OwnActorObject.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER]) and (not m_OwnActorObject.m_boSuperMan) {2007-02-04 增加 机器人除外} then begin
    if (m_OwnActorObject.m_PEnvir <> m_Envir) then begin //2006-11-12 火墙换地图消失
      //m_OwnActorObject.m_nCharStatus := m_OwnActorObject.GetCharStatus();
      //m_OwnActorObject.StatusChanged();
      m_OwnActorObject := nil;
      m_boClosed := True;
      Close();
    end;
  end;

  inherited;
end;

{ TEvent }

constructor TEvent.Create(tEnvir: TEnvirnoment; nTX, nTY, nType, dwETime: Integer; boVisible: Boolean);
begin
  inherited Create();
  m_ObjType := t_Event;
  m_dwOpenStartTick := GetTickCount();
  m_nServerEventType := nType;
  m_nEventType := nType;
  m_nEventParam := 0;
  m_dwContinueTime := dwETime;
  m_boVisible := boVisible;
  m_boClosed := False;
  m_Envir := tEnvir;
  m_nX := nTX;
  m_nY := nTY;
  m_boActive := True;
  m_nDamage := 0;
  m_OwnActorObject := nil;
  m_dwRunStart := GetTickCount();
  m_dwRunTick := 500;
  m_boAllowClose := True;
  if (m_Envir <> nil) and (m_boVisible) then begin
    if m_Envir.AddToMap(m_nX, m_nY, Self) <> Self then begin
      Close;
    end;
  end else m_boVisible := False;
end;

destructor TEvent.Destroy;
begin
  if (m_Envir <> nil) then
    m_Envir.DeleteFromMap(m_nX, m_nY, Self);
  inherited;
end;

procedure TEvent.Run;
begin
  if m_boAllowClose then begin
    if (GetTickCount - m_dwOpenStartTick) > m_dwContinueTime then begin
      m_boClosed := True;
      Close();
    end;
  end;
  if (m_OwnActorObject <> nil) and (m_OwnActorObject.m_boGhost or m_OwnActorObject.m_boDeath) then begin
    m_OwnActorObject := nil;
  end;
end;

procedure TEvent.Close;
begin
  m_dwCloseTick := GetTickCount();
  if m_boVisible then begin
    m_boVisible := False;
    if m_Envir <> nil then begin
      m_Envir.DeleteFromMap(m_nX, m_nY, Self);
    end;
    m_Envir := nil;
  end;
end;

{ TPileStones }

constructor TPileStones.Create(Envir: TEnvirnoment; nX, nY: Integer; nType, nTime: Integer);
begin
  inherited Create(Envir, nX, nY, nType, nTime, True);
  m_nEventParam := 1;
end;

procedure TPileStones.AddEventParam;
begin
  if m_nEventParam < 5 then Inc(m_nEventParam);
end;

procedure TStoneMineEvent.AddStoneMine;
begin
  m_nMineCount := m_nAddStoneCount;
  m_dwAddStoneMineTick := GetTickCount();
end;

end.

