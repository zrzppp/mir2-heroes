unit ObjGuard;

interface
uses
  Windows, Classes, Grobal2, ObjBase, ObjNpc, SysUtils;
type
  TSuperGuard = class(TNormNpc)
    n564: Integer;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure Run; override;
  end;
implementation

uses ObjActor, M2Share;

{ TSuperGuard }

function TSuperGuard.AttackTarget(): Boolean;
var
  nOldX, nOldY: Integer;
  btOldDir: Byte;
  wHitMode: Word;
begin
  Result := False;
  if m_TargetCret.m_PEnvir = m_PEnvir then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      nOldX := m_nCurrX;
      nOldY := m_nCurrY;
      btOldDir := m_btDirection;
      m_TargetCret.GetBackPosition(m_nCurrX, m_nCurrY);
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
      wHitMode := 0;
      _Attack(wHitMode, m_TargetCret);
      m_TargetCret.SetLastHiter(Self);
      m_TargetCret.m_ExpHitter := nil;
      m_nCurrX := nOldX;
      m_nCurrY := nOldY;
      m_btDirection := btOldDir;
      TurnTo(m_btDirection);
      BreakHolySeizeMode();
      //MainOutMessage('_Attack(wHitMode, m_TargetCret)');
    end;
    Result := True;
  end else begin
    DelTargetCreat();
  end;
end;

constructor TSuperGuard.Create;
begin
  inherited;
  m_btRaceServer := 11;
  m_nViewRange := 7;
  m_nLight := 4;
end;

destructor TSuperGuard.Destroy;
begin

  inherited;
end;

function TSuperGuard.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);
end;

procedure TSuperGuard.Run;
var
  I: Integer;
  ActorObject: TActorObject;
begin
  if m_Master <> nil then m_Master := nil; //不允许召唤为宝宝
  if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
    for I := 0 to m_VisibleActors.Count - 1 do begin
      ActorObject := TActorObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if ActorObject.m_boDeath then Continue;
      if (ActorObject.m_nCopyHumanLevel = 2) and (not g_Config.boAllowGuardAttack) or (ActorObject.m_nCopyHumanLevel = 3) or (ActorObject.m_btRaceServer = 122) {不攻击镖车} then Continue; {不攻击分身}
      if (ActorObject.PKLevel >= 2) or ((ActorObject.m_btRaceServer >= RC_MONSTER) and (not ActorObject.m_boMission)) then begin
        SetTargetCreat(ActorObject);
        Break;
      end;
    end;
  end;
  if m_TargetCret <> nil then AttackTarget();
  inherited;
end;

end.
