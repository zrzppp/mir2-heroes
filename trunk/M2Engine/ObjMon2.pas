unit ObjMon2;

interface
uses
  Windows, Classes, Grobal2, ObjBase, ObjActor, ObjMon;
type
  TStickMonster = class(TAnimalObject)
    bo550: Boolean;
    n554: Integer;
    n558: Integer;
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; virtual;
    procedure sub_FFEA; virtual;
    procedure sub_FFE9; virtual;
    procedure VisbleActors; virtual; //FFE8
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override;
  end;
  TBeeQueen = class(TAnimalObject)
    BBList: TList;
  private
    procedure MakeChildBee;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override;
  end;
  TCentipedeKingMonster = class(TStickMonster)
    m_dwAttickTick: LongWord; //0x560
  private
    function sub_4A5B0C: Boolean;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure sub_FFE9; override;
    procedure Run; override;
  end;
  TBigHeartMonster = class(TAnimalObject)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;

    function AttackTarget(): Boolean; virtual;
    procedure Run; override;
  end;
  TSpiderHouseMonster = class(TAnimalObject)
    BBList: TList;
  private
    procedure GenBB;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override;
  end;
  TExplosionSpider = class(TMonster)
    dw558: LongWord;
  private
    procedure sub_4A65C4;

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    function AttackTarget(): Boolean; override; //FFEB
  end;
  TGuardUnit = class(TAnimalObject)
    dw54C: LongWord; //0x54C
    m_nX550: Integer; //0x550
    m_nY554: Integer; //0x554
    m_nDirection: Integer; //0x558
  public
    function IsProperTarget(ActorObject: TActorObject): Boolean; override; //FFF4
    procedure Struck(hiter: TActorObject); override; //FFEC
  end;
  TArcherGuard = class(TGuardUnit)
  private
    procedure sub_4A6B30(TargeTActorObject: TActorObject);

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
  TArcherPolice = class(TArcherGuard)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TCastleDoor = class(TGuardUnit)
    dw55C: LongWord; //0x55C
    dw560: LongWord; //0x560
    m_boOpened: Boolean; //0x564
    bo565n: Boolean; //0x565
    bo566n: Boolean; //0x566
    bo567n: Boolean; //0x567
  private
    procedure SetMapXYFlag(nFlag: Integer);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Die; override;
    procedure Run; override;
    procedure Initialize(); override;
    procedure Close;
    procedure Open;
    procedure RefStatus;
  end;
  TWallStructure = class(TGuardUnit)
    n55C: Integer;
    dw560: LongWord;
    boSetMapFlaged: Boolean;
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Initialize; override;
    procedure Die; override;
    procedure Run; override;
    procedure RefStatus;
  end;
  TSoccerBall = class(TAnimalObject)
    n548: Integer;
    n550: Integer;
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Struck(hiter: TActorObject); virtual; //FFEC
    procedure Run; override;
  end;
implementation

uses M2Share, HUtil32, Castle, Guild;


{ TStickMonster }

constructor TStickMonster.Create; //004A51C0
begin
  inherited;
  bo550 := False;
  m_nViewRange := 7;
  m_nRunTime := 250;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 85;
  n554 := 4;
  n558 := 4;
  m_boFixedHideMode := True;
  m_boStickMode := True;
  m_boAnimal := True;
end;

destructor TStickMonster.Destroy; //004A5290
begin

  inherited;
end;

function TStickMonster.AttackTarget: Boolean;
var
  btDir: Byte;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetAttackDir(m_TargetCret, btDir) then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      Attack(m_TargetCret, btDir);
    end;
    Result := True;
    Exit;
  end;
  if m_TargetCret.m_PEnvir = m_PEnvir then begin
    SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
  end else begin
    DelTargetCreat(); {0FFF1h}
  end;
end;

procedure TStickMonster.sub_FFE9();
begin
  m_boFixedHideMode := False;
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
end;

procedure TStickMonster.VisbleActors(); //004A53E4
var
  I: Integer;
resourcestring
  sExceptionMsg = '[Exception] TStickMonster::VisbleActors Dispose';
begin
  SendRefMsg(RM_DIGDOWN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  for I := 0 to m_VisibleActors.Count - 1 do begin
    try
      Dispose(pTVisibleBaseObject(m_VisibleActors.Items[I]));
    except
      MainOutMessage(sExceptionMsg);
    end;
  end;
  m_VisibleActors.Clear;
  m_boFixedHideMode := True;
end;

procedure TStickMonster.sub_FFEA();
var
  I: Integer;
  ActorObject: TActorObject;
begin
  for I := 0 to m_VisibleActors.Count - 1 do begin
    ActorObject := TActorObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
    if ActorObject.m_boDeath then Continue;
    if IsProperTarget(ActorObject) then begin
      if not ActorObject.m_boHideMode or m_boCoolEye then begin
        if (abs(m_nCurrX - ActorObject.m_nCurrX) < n554) and (abs(m_nCurrY - ActorObject.m_nCurrY) < n554) then begin
          sub_FFE9();
          Break;
        end;
      end;
    end;
  end; // for
end;

function TStickMonster.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);
end;

procedure TStickMonster.Run; //004A5614
var
  bo05: Boolean;
begin
  if not m_boGhost and
    not m_boDeath and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then begin
    if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
      m_dwWalkTick := GetTickCount();
      if m_boFixedHideMode then begin
        sub_FFEA();
      end else begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          SearchTarget();
        end;
        bo05 := False;
        if m_TargetCret <> nil then begin
          if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > n558) or
            (abs(m_TargetCret.m_nCurrY - m_nCurrY) > n558) then begin
            bo05 := True;
          end;
        end else bo05 := True;
        if bo05 then begin
          VisbleActors();
        end else begin
          if AttackTarget then begin
            inherited;
            Exit;
          end;
        end;
      end;
    end;
  end;
  inherited;
end;



{ TSoccerBall }

constructor TSoccerBall.Create; //004A764C
begin
  inherited;
  m_boAnimal := False;
  m_boSuperMan := True;
  n550 := 0;
  m_nTargetX := -1;
end;

destructor TSoccerBall.Destroy;
begin

  inherited;
end;



procedure TSoccerBall.Run;
var
  n08, n0C: Integer;
  bo0D: Boolean;
begin
  if n550 > 0 then begin
    if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 1, n08, n0C) then begin
      if m_PEnvir.CanWalk(n08, n0C, bo0D) then begin
        case m_btDirection of //
          0: m_btDirection := 4;
          1: m_btDirection := 7;
          2: m_btDirection := 6;
          3: m_btDirection := 5;
          4: m_btDirection := 0;
          5: m_btDirection := 3;
          6: m_btDirection := 2;
          7: m_btDirection := 1;
        end; // case
        m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, n550, m_nTargetX, m_nTargetY)
      end;
    end;
  end else begin //004A78A1
    m_nTargetX := -1;
  end;
  if m_nTargetX <> -1 then begin
    GotoTargetXY();
    if (m_nTargetX = m_nCurrX) and (m_nTargetY = m_nCurrY) then
      n550 := 0;
  end;

  inherited;

end;

procedure TSoccerBall.Struck(hiter: TActorObject);
begin
  if hiter = nil then Exit;
  m_btDirection := hiter.m_btDirection;
  n550 := Random(4) + (n550 + 4);
  n550 := _MIN(20, n550);
  m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, n550, m_nTargetX, m_nTargetY);
end;

{ TBeeQueen }

constructor TBeeQueen.Create; //004A5750
begin
  inherited;
  m_nViewRange := 9;
  m_nRunTime := 250;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := GetTickCount();
  m_boStickMode := True;
  BBList := TList.Create;
end;

destructor TBeeQueen.Destroy; //004A57F0
begin
  BBList.Free;
  inherited;
end;

procedure TBeeQueen.MakeChildBee;
begin
  if BBList.Count >= 15 then Exit;
  SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  SendDelayMsg(Self, RM_ZEN_BEE, 0, 0, 0, 0, '', 500);
end;

function TBeeQueen.Operate(ProcessMsg: pTProcessMessage): Boolean;
var
  BB: TActorObject;
begin
  if ProcessMsg.wIdent = RM_ZEN_BEE then begin
    BB := UserEngine.RegenMonsterByName(nil, m_PEnvir.sMapName, m_nCurrX, m_nCurrY, g_Config.sBee);
    if BB <> nil then begin
      BB.SetTargetCreat(m_TargetCret);
      BBList.Add(BB);
    end;
  end;
  Result := inherited Operate(ProcessMsg);
end;

procedure TBeeQueen.Run;
var
  I: Integer;
  BB: TActorObject;
begin
  if not m_boGhost and
    not m_boDeath and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then begin
    if Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed then begin
      m_dwWalkTick := GetTickCount();
      if Integer(GetTickCount - m_dwHitTick) >= m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        SearchTarget();
        if m_TargetCret <> nil then MakeChildBee();
      end;
      for I := BBList.Count - 1 downto 0 do begin
        BB := TActorObject(BBList.Items[I]);
        if (BB <> nil) and (BB.m_boDeath) or (BB.m_boGhost) then BBList.Delete(I);
      end;
    end;
  end;
  inherited;
end;

{ TCentipedeKingMonster }



constructor TCentipedeKingMonster.Create; //004A5A8C
begin
  inherited;
  m_nViewRange := 6;
  n554 := 4;
  n558 := 6;
  m_boAnimal := False;
  m_dwAttickTick := GetTickCount();
end;

destructor TCentipedeKingMonster.Destroy;
begin

  inherited;
end;

function TCentipedeKingMonster.sub_4A5B0C: Boolean;
var
  I: Integer;
  ActorObject: TActorObject;
begin
  Result := False;
  for I := 0 to m_VisibleActors.Count - 1 do begin
    ActorObject := TActorObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
    if ActorObject.m_boDeath then Continue;
    if IsProperTarget(ActorObject) then begin
      if (abs(m_nCurrX - ActorObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY - ActorObject.m_nCurrY) <= m_nViewRange) then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

function TCentipedeKingMonster.AttackTarget: Boolean;
var
  WAbil: pTAbility;
  nPower, I: Integer;
  ActorObject: TActorObject;
begin
  Result := False;
  if not sub_4A5B0C then begin
    Exit;
  end;
  if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    SendAttackMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
    WAbil := @m_WAbil;
    nPower := (Random(Integer(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    for I := 0 to m_VisibleActors.Count - 1 do begin
      ActorObject := TActorObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if ActorObject.m_boDeath then Continue;
      if IsProperTarget(ActorObject) then begin
        if (abs(m_nCurrX - ActorObject.m_nCurrX) < m_nViewRange) and (abs(m_nCurrY - ActorObject.m_nCurrY) < m_nViewRange) then begin
          m_dwTargetFocusTick := GetTickCount();
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(ActorObject.m_nCurrX, ActorObject.m_nCurrY), MakeLong(2, 0), Integer(ActorObject), '', 600);
          if Random(4) = 0 then begin
            if Random(3) <> 0 then begin
              ActorObject.MakePosion(POISON_DECHEALTH, 60, 3);
            end else begin
              ActorObject.MakePosion(POISON_STONE, 5, 0);
            end;
            m_TargetCret := ActorObject;
          end;
        end;
      end;
    end; // for
  end;
  Result := True;
end;

procedure TCentipedeKingMonster.sub_FFE9;
begin
  inherited;
  m_WAbil.HP := m_WAbil.MaxHP;
end;

procedure TCentipedeKingMonster.Run;
var
  I: Integer;
  ActorObject: TActorObject;
begin
  if not m_boGhost and
    not m_boDeath and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then begin
    if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
      m_dwWalkTick := GetTickCount();
      if m_boFixedHideMode then begin
        if (GetTickCount - m_dwAttickTick) > 10000 then begin
          for I := 0 to m_VisibleActors.Count - 1 do begin
            ActorObject := TActorObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
            if ActorObject.m_boDeath then Continue;
            if IsProperTarget(ActorObject) then begin
              if not ActorObject.m_boHideMode or m_boCoolEye then begin
                if (abs(m_nCurrX - ActorObject.m_nCurrX) < n554) and (abs(m_nCurrY - ActorObject.m_nCurrY) < n554) then begin
                  sub_FFE9();
                  m_dwAttickTick := GetTickCount();
                  Break;
                end;
              end;
            end;
          end;
        end; //004A5F86
      end else begin
        if (GetTickCount - m_dwAttickTick) > 3000 then begin
          if AttackTarget() then begin
            inherited;
            Exit;
          end;
          if (GetTickCount - m_dwAttickTick) > 10000 then begin
            VisbleActors();
            m_dwAttickTick := GetTickCount();
          end;
        end;
      end;
    end;
  end;
  inherited;
end;


{ TBigHeartMonster }


constructor TBigHeartMonster.Create;
begin
  inherited;
  m_nViewRange := 16;
  m_boAnimal := False;
end;

destructor TBigHeartMonster.Destroy;
begin

  inherited;
end;

function TBigHeartMonster.AttackTarget(): Boolean;
var
  I: Integer;
  ActorObject: TActorObject;
  nPower: Integer;
  WAbil: pTAbility;
begin
  Result := False;
  if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    WAbil := @m_WAbil;
    nPower := (Random(Integer(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    for I := 0 to m_VisibleActors.Count - 1 do begin
      ActorObject := TActorObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if ActorObject.m_boDeath then Continue;
      if IsProperTarget(ActorObject) then begin
        if (abs(m_nCurrX - ActorObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY - ActorObject.m_nCurrY) <= m_nViewRange) then begin
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(ActorObject.m_nCurrX, ActorObject.m_nCurrY), MakeLong(2, 0), Integer(ActorObject), '', 200);
          SendRefMsg(RM_10205, 0, ActorObject.m_nCurrX, ActorObject.m_nCurrY, 1 {type}, '');
        end;
      end;
    end; // for
    Result := True;
  end;
  //  inherited;
end;

procedure TBigHeartMonster.Run; //004A617C
begin
  if not m_boGhost and
    not m_boDeath and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then begin
    if m_VisibleActors.Count > 0 then
      AttackTarget();
  end;
  inherited;
end;

{ TSpiderHouseMonster }

constructor TSpiderHouseMonster.Create; //004A61D0
begin
  inherited;
  m_nViewRange := 9;
  m_nRunTime := 250;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := 0;
  m_boStickMode := True;
  BBList := TList.Create;
end;

destructor TSpiderHouseMonster.Destroy;
begin
  BBList.Free;
  inherited;
end;

procedure TSpiderHouseMonster.GenBB;
begin
  if BBList.Count < 15 then begin
    SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    SendDelayMsg(Self, RM_ZEN_BEE, 0, 0, 0, 0, '', 500);
  end;
end;

function TSpiderHouseMonster.Operate(ProcessMsg: pTProcessMessage): Boolean;
var
  BB: TActorObject;
  n08, n0C: Integer;
begin
  if ProcessMsg.wIdent = RM_ZEN_BEE then begin
    n08 := m_nCurrX;
    n0C := m_nCurrY + 1;
    if m_PEnvir.CanWalk(n08, n0C, True) and m_PEnvir.CanWalkOfEvent(Self, n08, n0C) then begin
      BB := UserEngine.RegenMonsterByName(nil, m_PEnvir.sMapName, n08, n0C, g_Config.sSpider);
      if BB <> nil then begin
        BB.SetTargetCreat(m_TargetCret);
        BBList.Add(BB);
      end;
    end;
  end;
  Result := inherited Operate(ProcessMsg);
end;

procedure TSpiderHouseMonster.Run;
var
  I: Integer;
  BB: TActorObject;
begin
  if not m_boGhost and
    not m_boDeath and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then begin
    if Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed then begin
      m_dwWalkTick := GetTickCount();
      if Integer(GetTickCount - m_dwHitTick) >= m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        SearchTarget();
        if m_TargetCret <> nil then GenBB();
      end;
      for I := BBList.Count - 1 downto 0 do begin
        if BBList.Count <= 0 then Break;
        BB := TActorObject(BBList.Items[I]);
        if BB <> nil then begin
          if BB.m_boDeath or (BB.m_boGhost) then BBList.Delete(I);
        end;
      end; // for
    end;
  end;
  inherited;
end;

{ TExplosionSpider }

constructor TExplosionSpider.Create;
//004A6538
begin
  inherited;
  m_nViewRange := 5;
  m_nRunTime := 250;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := 0;
  dw558 := GetTickCount();
end;

destructor TExplosionSpider.Destroy;
begin

  inherited;
end;

procedure TExplosionSpider.sub_4A65C4;
var
  WAbil: pTAbility;
  I, nPower, n10: Integer;
  ActorObject: TActorObject;
begin
  m_WAbil.HP := 0;
  WAbil := @m_WAbil;
  nPower := (Random(Integer(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
  for I := 0 to m_VisibleActors.Count - 1 do begin
    ActorObject := TActorObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
    if ActorObject.m_boDeath then Continue;
    if IsProperTarget(ActorObject) then begin
      if (abs(m_nCurrX - ActorObject.m_nCurrX) <= 1) and (abs(m_nCurrY - ActorObject.m_nCurrY) <= 1) then begin
        n10 := 0;

        nPower := nPower + GetAddPowerPoint(5, nPower);

        Inc(n10, ActorObject.GetHitStruckDamage(Self, nPower div 2));
        Inc(n10, ActorObject.GetMagStruckDamage(Self, nPower div 2));
        ActorObject.StartNewShield();
        if n10 > 0 then begin
          ActorObject.StruckDamage(n10);
          ActorObject.SendDelayMsg(TActorObject(RM_STRUCK), RM_10101, n10, ActorObject.m_WAbil.HP, ActorObject.m_WAbil.MaxHP, Integer(Self), '', 700);

          n10 := ActorObject.GetAddPowerPoint(4, n10); //·´ÉäÉËº¦
          if n10 > 0 then begin
            //n10 := n10 + ActorObject.GetAddPowerPoint(5, n10);
            StruckDamage(n10);
            SendDelayMsg(TActorObject(RM_STRUCK), RM_10101, n10, m_WAbil.HP, m_WAbil.MaxHP, Integer(ActorObject), '', 700);
          end;

        end;
      end;
    end;
  end; // for
end;

function TExplosionSpider.AttackTarget: Boolean;
var
  btDir: Byte;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetAttackDir(m_TargetCret, btDir) then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      sub_4A65C4();
    end;
    Result := True;
  end else begin
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    end else begin
      DelTargetCreat();
    end;
  end;
end;

procedure TExplosionSpider.Run;
begin
  if not m_boDeath and not m_boGhost then
    if (GetTickCount - dw558) > 60 * 1000 then begin
      dw558 := GetTickCount();
      sub_4A65C4();
    end;

  inherited;
end;

{ TGuardUnit }

procedure TGuardUnit.Struck(hiter: TActorObject);
begin
  inherited;
  if m_Castle <> nil then begin
    bo2B0 := True;
    m_dw2B4Tick := GetTickCount();
  end;
end;

function TGuardUnit.IsProperTarget(ActorObject: TActorObject): Boolean;
begin
  Result := False;
  if m_Castle <> nil then begin
    if m_LastHiter = ActorObject then Result := True;
    if (ActorObject <> nil) and (ActorObject.bo2B0) then begin
      if (GetTickCount - ActorObject.m_dw2B4Tick) < 2 * 60 * 1000 then begin
        Result := True;
      end else ActorObject.bo2B0 := False;
      if ActorObject.m_Castle <> nil then begin
        ActorObject.bo2B0 := False;
        Result := False;
      end;
    end;
    if TUserCastle(m_Castle).m_boUnderWar then Result := True;
    if TUserCastle(m_Castle).m_MasterGuild <> nil then begin
      if ActorObject.Master = nil then begin
        if (TUserCastle(m_Castle).m_MasterGuild = ActorObject.m_MyGuild) or
          (TUserCastle(m_Castle).m_MasterGuild.IsAllyGuild(TGUild(ActorObject.m_MyGuild))) then begin
          if m_LastHiter <> ActorObject then Result := False;
        end;
      end else begin
        if (TUserCastle(m_Castle).m_MasterGuild = ActorObject.Master.m_MyGuild) or
          (TUserCastle(m_Castle).m_MasterGuild.IsAllyGuild(TGUild(ActorObject.Master.m_MyGuild))) then begin
          if (m_LastHiter <> ActorObject.Master) and (m_LastHiter <> ActorObject) then Result := False;
        end;
      end;
    end;
    if (ActorObject <> nil) and
      ActorObject.m_boAdminMode or
      ActorObject.m_boStoneMode or
      ((ActorObject.m_btRaceServer >= 10) and
      (ActorObject.m_btRaceServer < 50)) or
      (ActorObject = Self) or (ActorObject.m_Castle = Self.m_Castle) then begin
      Result := False;
    end;
    Exit;
  end;
  if m_LastHiter = ActorObject then Result := True;
  if (ActorObject.m_TargetCret <> nil) and (ActorObject.m_TargetCret.m_btRaceServer = 112) then
    Result := True;
  if (ActorObject <> nil) and (ActorObject.PKLevel >= 2) then Result := True;
  if (ActorObject <> nil) and ActorObject.m_boAdminMode or
    ActorObject.m_boStoneMode or
    (ActorObject = Self) then Result := False;
end;

{ TArcherGuard }

constructor TArcherGuard.Create;
begin
  inherited;
  m_nViewRange := 12;
  m_boWantRefMsg := True;
  m_Castle := nil;
  m_nDirection := -1;
  m_btRaceServer := 112;
end;

destructor TArcherGuard.Destroy;
begin

  inherited;
end;

procedure TArcherGuard.sub_4A6B30(TargeTActorObject: TActorObject); //004A6B30
var
  nPower: Integer;
  WAbil: pTAbility;
begin
  if TargeTActorObject <> nil then begin
    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, TargeTActorObject.m_nCurrX, TargeTActorObject.m_nCurrY);
    WAbil := @m_WAbil;
    nPower := (Random(Integer(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));

    nPower := nPower + GetAddPowerPoint(5, nPower);

    if nPower > 0 then
      nPower := TargeTActorObject.GetHitStruckDamage(Self, nPower);
    TargeTActorObject.StartNewShield();
    if nPower > 0 then begin
      TargeTActorObject.SetLastHiter(Self);
      TargeTActorObject.m_ExpHitter := nil;
      TargeTActorObject.StruckDamage(nPower);

      TargeTActorObject.SendDelayMsg(TActorObject(RM_STRUCK), RM_10101, nPower, TargeTActorObject.m_WAbil.HP, TargeTActorObject.m_WAbil.MaxHP, Integer(Self), '',
        _MAX(abs(m_nCurrX - TargeTActorObject.m_nCurrX), abs(m_nCurrY - TargeTActorObject.m_nCurrY)) * 50 + 600);


      nPower := TargeTActorObject.GetAddPowerPoint(4, nPower); //·´ÉäÉËº¦
      if nPower > 0 then begin
        //nPower := nPower + TargeTActorObject.GetAddPowerPoint(5, nPower);
        StruckDamage(nPower);
        SendDelayMsg(TActorObject(RM_STRUCK), RM_10101, nPower, m_WAbil.HP, m_WAbil.MaxHP, Integer(TargeTActorObject), '', _MAX(abs(m_nCurrX - TargeTActorObject.m_nCurrX), abs(m_nCurrY - TargeTActorObject.m_nCurrY)) * 50 + 600);
      end;

    end;
    SendRefMsg(RM_FLYAXE, m_btDirection, m_nCurrX, m_nCurrY, Integer(TargeTActorObject), '');
  end;
end;

procedure TArcherGuard.Run;
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
    not m_boGhost and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then begin
    if Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed then begin
      m_dwWalkTick := GetTickCount();
      for I := 0 to m_VisibleActors.Count - 1 do begin
        ActorObject := TActorObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if ActorObject.m_boDeath then Continue;
        if IsProperTarget(ActorObject) then begin
          nAbs := abs(m_nCurrX - ActorObject.m_nCurrX) + abs(m_nCurrY - ActorObject.m_nCurrY);
          if nAbs < nRage then begin
            nRage := nAbs;
            TargeTActorObject := ActorObject;
          end;
        end;
      end;
      if TargeTActorObject <> nil then begin
        SetTargetCreat(TargeTActorObject);
      end else begin
        DelTargetCreat();
      end;
    end;
    if m_TargetCret <> nil then begin
      if Integer(GetTickCount - m_dwHitTick) >= m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        sub_4A6B30(m_TargetCret);
      end;
    end else begin
      if (m_nDirection >= 0) and (m_btDirection <> m_nDirection) then begin
        TurnTo(m_nDirection);
      end;
    end;
  end;
  inherited;
end;

{ TArcherPolice }

constructor TArcherPolice.Create;
begin
  inherited;
  m_btRaceServer := 20;
end;

destructor TArcherPolice.Destroy;
begin

  inherited;
end;


{ TCastleDoor }

constructor TCastleDoor.Create;
begin
  inherited;
  m_boAnimal := False;
  m_boStickMode := True;
  m_boOpened := False;
  m_btAntiPoison := 200;
end;

destructor TCastleDoor.Destroy;
begin

  inherited;
end;

procedure TCastleDoor.SetMapXYFlag(nFlag: Integer);
var
  bo06: Boolean;
begin
  m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY - 2, True);
  m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 1, True);
  m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 2, True);
  if nFlag = 1 then bo06 := False
  else bo06 := True;
  m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY - 1, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY - 2, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 1, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 2, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX - 1, m_nCurrY, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX - 2, m_nCurrY, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX - 1, m_nCurrY - 1, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX - 1, m_nCurrY + 1, bo06);
  if nFlag = 0 then begin
    m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY - 2, False);
    m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 1, False);
    m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 2, False);
  end;
end;

procedure TCastleDoor.Open;
begin
  if m_boDeath then Exit;
  m_btDirection := 7;
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  m_boOpened := True;
  m_boStoneMode := True;
  SetMapXYFlag(0);
  bo2B9 := False;
end;

procedure TCastleDoor.Close;
begin
  if m_boDeath then Exit;
  m_btDirection := 3 - Round(m_WAbil.HP / m_WAbil.MaxHP * 3.0);
  if (m_btDirection - 3) >= 0 then m_btDirection := 0;
  SendRefMsg(RM_DIGDOWN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  m_boOpened := False;
  m_boStoneMode := False;
  SetMapXYFlag(1);
  bo2B9 := True;
end;

procedure TCastleDoor.Die;
begin
  inherited;
  dw560 := GetTickCount();
  SetMapXYFlag(2);
end;

procedure TCastleDoor.Run;
var
  n08: Integer;
begin
  if m_boDeath and (m_Castle <> nil) then
    m_dwDeathTick := GetTickCount()
  else m_nHealthTick := 0;
  if not m_boOpened then begin
    n08 := 3 - Round(m_WAbil.HP / m_WAbil.MaxHP * 3.0);
    if (m_btDirection <> n08) and (n08 < 3) then begin
      m_btDirection := n08;
      SendRefMsg(RM_TURN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    end;
  end;
  inherited;
end;

procedure TCastleDoor.RefStatus;
var
  n08: Integer;
begin
  n08 := 3 - Round(m_WAbil.HP / m_WAbil.MaxHP * 3.0);
  if (n08 - 3) >= 0 then n08 := 0;
  m_btDirection := n08;
  SendRefMsg(RM_ALIVE, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
end;

procedure TCastleDoor.Initialize;
begin
  //  m_btDirection:=0;
  inherited;
  {
  if m_WAbil.HP > 0 then begin
    if m_boOpened then begin
      SetMapXYFlag(0);
      exit;
    end;
    SetMapXYFlag(1);
    exit;
  end;
  SetMapXYFlag(2);
  }
end;

{ TWallStructure }

constructor TWallStructure.Create;
begin
  inherited;
  m_boAnimal := False;
  m_boStickMode := True;
  boSetMapFlaged := False;
  m_btAntiPoison := 200;
end;

destructor TWallStructure.Destroy;
begin

  inherited;
end;

procedure TWallStructure.Initialize;
begin
  m_btDirection := 0;
  inherited;
end;

procedure TWallStructure.RefStatus;
var
  n08: Integer;
begin
  if m_WAbil.HP > 0 then begin
    n08 := 3 - Round(m_WAbil.HP / m_WAbil.MaxHP * 3.0);
  end else begin
    n08 := 4;
  end;
  if n08 >= 5 then n08 := 0;
  m_btDirection := n08;
  SendRefMsg(RM_ALIVE, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
end;

procedure TWallStructure.Die;
begin
  inherited;
  dw560 := GetTickCount();
end;

procedure TWallStructure.Run;
var
  n08: Integer;
begin
  if m_boDeath then begin
    m_dwDeathTick := GetTickCount();
    if boSetMapFlaged then begin
      m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY, True);
      boSetMapFlaged := False;
    end;
  end else begin
    m_nHealthTick := 0;
    if not boSetMapFlaged then begin
      m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY, False);
      boSetMapFlaged := True;
    end;
  end;
  if m_WAbil.HP > 0 then begin
    n08 := 3 - Round(m_WAbil.HP / m_WAbil.MaxHP * 3.0);
  end else begin
    n08 := 4;
  end;
  if (m_btDirection <> n08) and (n08 < 5) then begin
    m_btDirection := n08;
    SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  end;
  inherited;
end;

end.

