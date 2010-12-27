unit ObjAxeMon;

interface
uses
  Windows, Classes, Grobal2, ObjBase, ObjActor, ObjMon;
type
  TDualAxeMonster = class(TMonster)
    bo558: Boolean;
    m_nAttackCount: Integer;
    m_nAttackMax: Integer;
  private
    procedure FlyAxeAttack(Target: TActorObject);
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
  end;
  TThornDarkMonster = class(TDualAxeMonster)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TArcherMonster = class(TDualAxeMonster)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
implementation

uses M2Share, HUtil32;

{ TDualAxeMonster }

procedure TDualAxeMonster.FlyAxeAttack(Target: TActorObject);
var
  WAbil: pTAbility;
  nDamage: Integer;
begin
  if m_PEnvir.CanFly(m_nCurrX, m_nCurrY, Target.m_nCurrX, Target.m_nCurrY) then begin
    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, Target.m_nCurrX, Target.m_nCurrY);
    WAbil := @m_WAbil;
    nDamage := (Random(Integer(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));

    Target.m_boNotDefendoof := GetNotDefendoof; //ºöÊÓÄ¿±ê·ÀÓù
    nDamage := nDamage + GetAddPowerPoint(5, nDamage);

    if nDamage > 0 then begin
      nDamage := Target.GetHitStruckDamage(Self, nDamage);
    end;
    Target.StartNewShield();
    if nDamage > 0 then begin
      Target.StruckDamage(nDamage);
      Target.SendDelayMsg(TActorObject(RM_STRUCK), RM_10101, nDamage, Target.m_WAbil.HP, Target.m_WAbil.MaxHP, Integer(Self), '',
        _MAX(abs(m_nCurrX - Target.m_nCurrX), abs(m_nCurrY - Target.m_nCurrY)) * 50 + 600);
    end;
    SendRefMsg(RM_FLYAXE, m_btDirection, m_nCurrX, m_nCurrY, Integer(Target), '');
  end;
end;

function TDualAxeMonster.AttackTarget: Boolean; //00459B14
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 7) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 7) then begin
      if (m_nAttackMax - 1) > m_nAttackCount then begin
        Inc(m_nAttackCount);
        m_dwTargetFocusTick := GetTickCount();
        FlyAxeAttack(m_TargetCret);
      end else begin
        if Random(5) = 0 then begin
          m_nAttackCount := 0;
        end;
      end;
      Result := True;
      Exit;
    end;
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;
    end else begin
      DelTargetCreat();
    end;
  end;
end;

constructor TDualAxeMonster.Create;
begin
  inherited;
  bo558 := False;
  m_nViewRange := 5;
  m_nRunTime := 250;
  m_dwSearchTime := 3000;
  m_nAttackCount := 0;
  m_nAttackMax := 2;
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 87;
end;

destructor TDualAxeMonster.Destroy;
begin

  inherited;
end;

procedure TDualAxeMonster.Run;
var
  I: Integer;
  nAbs: Integer;
  nRage: Integer;
  ActorObject: TActorObject;
  TargeTActorObject: TActorObject;
begin
  nRage := 9999;
  TargeTActorObject := nil;
  if not m_boDeath and
    not bo558 and
    not m_boGhost and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then begin

    if (GetTickCount - m_dwSearchEnemyTick) >= 5000 then begin
      m_dwSearchEnemyTick := GetTickCount();
      for I := 0 to m_VisibleActors.Count - 1 do begin
        ActorObject := TActorObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if ActorObject.m_boDeath then Continue;
        if IsProperTarget(ActorObject) then begin
          if not ActorObject.m_boHideMode or m_boCoolEye then begin
            nAbs := abs(m_nCurrX - ActorObject.m_nCurrX) + abs(m_nCurrY - ActorObject.m_nCurrY);
            if nAbs < nRage then begin
              nRage := nAbs;
              TargeTActorObject := ActorObject;
            end;
          end;
        end;
      end;
      if TargeTActorObject <> nil then begin
        SetTargetCreat(TargeTActorObject);
      end;
    end;

    if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) and (m_TargetCret <> nil) then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) then begin
          if Random(5) = 0 then begin
            GetBackPosition(m_nTargetX, m_nTargetY);
          end;
        end else begin
          GetBackPosition(m_nTargetX, m_nTargetY);
        end;
      end;
    end;
  end;
  inherited;
end;

{ TThornDarkMonster }

constructor TThornDarkMonster.Create; //00459EE4
begin
  inherited;
  m_nAttackMax := 3;
  m_btRaceServer := 93;
end;

destructor TThornDarkMonster.Destroy;
begin

  inherited;
end;

{ TArcherMonster }

constructor TArcherMonster.Create;
begin
  inherited;
  m_nAttackMax := 6;
  m_btRaceServer := 104;
end;

destructor TArcherMonster.Destroy;
begin

  inherited;
end;
end.
