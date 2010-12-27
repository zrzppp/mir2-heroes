unit MapPoint;

interface
uses
  Windows, SysUtils, StrUtils, Classes, SDK, Envir, ObjBase, Grobal2;
type
  TPathType = (t_Dynamic, t_Fixed);

  TMapPoint = class
  private
    FX, FY: Integer;
    FThrough: Boolean;
  public
    constructor Create(nX, nY: Integer);
    destructor Destroy; override;
    property X: Integer read FX write FX;
    property Y: Integer read FY write FY;

    property Through: Boolean read FThrough write FThrough;
  end;

  TPointManager = class
    m_nCurrX, m_nCurrY: Integer;
    m_nPostion: Integer;
    m_btDirection: Byte;
    m_nTurnCount: Integer;
    m_PEnvir: TEnvirnoment;
  private
    FPointList: TList;
    FBaseObject: TBaseObject;
    FPathType: TPathType;
    function GetCount: Integer;
  public
    constructor Create(ABaseObject: TBaseObject);
    destructor Destroy; override;
    procedure Initialize(Envir: TEnvirnoment);
    function GetPoint(var nX, nY: Integer): Boolean;
    property Count: Integer read GetCount;
    property PathType: TPathType read FPathType write FPathType;
  end;
implementation
uses
  M2Share, ObjActor;

constructor TMapPoint.Create(nX, nY: Integer);
begin
  FX := nX;
  FY := nY;
  FThrough := False;
end;

destructor TMapPoint.Destroy;
begin
  inherited;
end;

{----------------------------------TPointManager--------------------------------}

constructor TPointManager.Create(ABaseObject: TBaseObject);
begin
  m_nCurrX := -1;
  m_nCurrY := -1;
  m_nPostion := -1;
  FBaseObject := ABaseObject;
  FPointList := TList.Create;
  FPathType := t_Dynamic; //t_Fixed; //t_Dynamic;
  m_PEnvir := nil;
end;

destructor TPointManager.Destroy;
begin
  FPointList.Free;
  inherited;
end;

function TPointManager.GetCount: Integer;
begin
  Result := FPointList.Count;
end;

procedure TPointManager.Initialize(Envir: TEnvirnoment);
begin
  m_PEnvir := Envir;
  m_nPostion := 0;
end;

function TPointManager.GetPoint(var nX, nY: Integer): Boolean;
  function GetNextDir(btDir: Byte): Byte;
  begin
    //if btDir = DR_UP then Result := DR_UPLEFT else Result := btDir - 1;
    case btDir of
      DR_UP: Result := DR_UPRIGHT;
      DR_UPRIGHT: Result := DR_RIGHT;
      DR_RIGHT: Result := DR_DOWNRIGHT;
      DR_DOWNRIGHT: Result := DR_DOWN;
      DR_DOWN: Result := DR_DOWNLEFT;
      DR_DOWNLEFT: Result := DR_LEFT;
      DR_LEFT: Result := DR_UPLEFT;
      DR_UPLEFT: Result := DR_UP;
    end;
  end;
var
  I, nMX, nMY, nC, n10, nIndex, nPostion: Integer;
  MapPoint, MapPoint10: TMapPoint;
  boFind: Boolean;
  nCurrX, nCurrY: Integer;
  btDir: Byte;
  //Point:TPoint;
  Pt: Integer;

  nX1, nY1, nX2, nY2, nStep: Integer;
begin
  Result := False;
  if FPathType = t_Dynamic then begin
    m_nCurrX := nX;
    m_nCurrY := nY;
    m_btDirection := TActorObject(FBaseObject).m_btDirection;
    for I := 2 downto 1 do begin
      if TActorObject(FBaseObject).m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, I, nMX, nMY) then begin
        if TActorObject(FBaseObject).CanMove(nMX, nMY, False) then begin
          m_nTurnCount := 0;
          nX := nMX;
          nY := nMY;
          Result := True;
          Exit;
        end;
      end;
    end;
    nC := 0;
    btDir := m_btDirection;
    while True do begin
      btDir := GetNextDir(btDir);
      for I := 2 downto 1 do begin
        if TActorObject(FBaseObject).m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, btDir, I, nMX, nMY) then begin
          if TActorObject(FBaseObject).CanMove(nMX, nMY, False) then begin
            nX := nMX;
            nY := nMY;
            Result := True;
            Exit;
          end;
        end;
      end;
      Inc(nC);
      if (nC >= 8) then Break;
    end;
  end else begin
    nMX := 0;
    nMY := 0;
    if TActorObject(FBaseObject).m_PEnvir <> m_PEnvir then begin
      m_PEnvir := TActorObject(FBaseObject).m_PEnvir;
      m_nPostion := 0;
      m_nCurrX := nX;
      m_nCurrY := nY;
    end;

    nIndex := m_PEnvir.m_PointList.Count;
    n10 := 99999;
    if not ((m_nPostion >= 0) and (m_nPostion < m_PEnvir.m_PointList.Count) and
      (m_nCurrX = nX) and (m_nCurrY = nY)) then begin
      m_nPostion := 0;
    end;
    //MainOutMessage(Format('Postion1:%d', [m_nPostion]));
    for I := m_nPostion to m_PEnvir.m_PointList.Count - 1 do begin
      //MapPoint := TMapPoint(FPointList.Items[I]);
      //if not MapPoint.Through then begin
      Pt := Integer(m_PEnvir.m_PointList.Items[I]);
      nCurrX := LoWord(Pt);
      nCurrY := HiWord(Pt);
      //if m_PEnvir.CanWalkEx(nCurrX, nCurrY, False) and m_PEnvir.CanWalkOfEvent(FBaseObject, nCurrX, nCurrY) then begin
      nC := abs(nX - nCurrX) + abs(nY - nCurrY);
      if nC < n10 then begin
        n10 := nC;
        nMX := nCurrX;
        nMY := nCurrY;
        nIndex := I;
        m_nPostion := I;
        Result := True;
        if (n10 <= 0) then break;
      end;
      //end;
    end;

    //MainOutMessage(Format('Postion2:%d', [m_nPostion]));
    //MainOutMessage(Format('GetThroughPoint:(Index:%d n10:%d %d / %d)', [nIndex, n10, nMX, nMY]));
    if nIndex >= m_PEnvir.m_PointList.Count - 1 then begin
      Result := False;
    end else begin
      if (n10 <= 0) and (nIndex >= 0) then begin
        nStep := 0;

        for I := m_nPostion + 1 to m_PEnvir.m_PointList.Count - 1 do begin
          Pt := Integer(m_PEnvir.m_PointList.Items[I]);
          nCurrX := LoWord(Pt);
          nCurrY := HiWord(Pt);

          if nStep = 0 then begin
            btDir := GetNextDirection(nX, nY, nCurrX, nCurrY);
            nMX := nCurrX;
            nMY := nCurrY;
            m_nPostion := I;
          end else begin
            if (GetNextDirection(nMX, nMY, nCurrX, nCurrY) = btDir) then begin
              nMX := nCurrX;
              nMY := nCurrY;
              m_nPostion := I;
            end else begin
              break;
            end;
          end;
          nStep := nStep + 1;
          if nStep >= 2 then break
        end;
      end;

      if not (TActorObject(FBaseObject).CanRun(nX, nY, nMX, nMY, False) and m_PEnvir.CanWalkOfEvent(FBaseObject, nMX, nMY)) then begin
        //MainOutMessage('if not (m_PEnvir.CanWalkEx(nMX, nMY, False) and m_PEnvir.CanWalkOfEvent(FBaseObject, nMX, nMY)) then begin');
        for I := m_nPostion + 1 to m_PEnvir.m_PointList.Count - 1 do begin
          Pt := Integer(m_PEnvir.m_PointList.Items[I]);
          nCurrX := LoWord(Pt);
          nCurrY := HiWord(Pt);
          m_nPostion := I;
          if m_PEnvir.CanWalkEx(nCurrX, nCurrY, False) and m_PEnvir.CanWalkOfEvent(FBaseObject, nCurrX, nCurrY) then begin
            nMX := nCurrX;
            nMY := nCurrY;
            break;
          end;
        end;
      end;
      nX := nMX;
      nY := nMY;
      m_nCurrX := nX;
      m_nCurrY := nY;
    end;
  end;
end;

end.

