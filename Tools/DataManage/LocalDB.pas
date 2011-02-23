unit LocalDB;

interface
uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms, ActiveX,
  Dialogs, DBTables, DB, HUtil32, Grobal2, ObjBase;
type
  TLocalDB = class
    m_StdItemList: TList;
    m_MagicList: TList;
    m_MonsterList: TList;
  private
    { Private declarations }
    function LoadMonsterDB(): Integer;
    function LoadMagicDB(): Integer;
    function LoadItemsDB(): Integer;

  public
    Query: TQuery;

    constructor Create();
    destructor Destroy; override;
    function LoadDB(): Integer;

    function GetStdItem(nIdx: Integer): pTStdItem_; overload;
    function GetStdItem(sItemName: string): pTStdItem_; overload;
    function GetStdItemName(nItemIdx: Integer): string;
    function GetStdItemIdx(sItemName: string): Integer;

    function FindMagic(sMagicName: string): pTMagic; overload;
    function FindMagic(nMagIdx: Integer): pTMagic; overload;

    function FindHeroMagic(sMagicName: string): pTMagic; overload;
    function FindHeroMagic(nMagIdx: Integer): pTMagic; overload;

    procedure GetStdItemList(nStdMode: Integer; ItemList: TStrings);
    procedure GetItemAddValue(UserItem: pTUserItem; var StdItem: TStdItem_);
  end;
implementation
uses Share;
constructor TLocalDB.Create();
begin
  CoInitialize(nil);
  Query := TQuery.Create(nil);

  m_StdItemList := TList.Create;
  m_MagicList := TList.Create;
  m_MonsterList := TList.Create;
  Query.DatabaseName := g_sHeroDBName;
end;

destructor TLocalDB.Destroy;
var
  I: Integer;
begin
  for I := 0 to m_StdItemList.Count - 1 do begin
    Dispose(pTStdItem_(m_StdItemList.Items[I]));
  end;
  m_StdItemList.Free;

  for I := 0 to m_MagicList.Count - 1 do begin
    Dispose(pTMagic(m_MagicList.Items[I]));
  end;
  m_MagicList.Free;

  for I := 0 to m_MonsterList.Count - 1 do begin
    Dispose(pTMonInfo(m_MonsterList.Items[I]));
  end;
  m_MonsterList.Free;

  Query.Free;
  CoUnInitialize;
  inherited;
end;

function TLocalDB.LoadDB(): Integer;
begin
  LoadMonsterDB();
  LoadMagicDB();
  LoadItemsDB();
end;

procedure TLocalDB.GetItemAddValue(UserItem: pTUserItem; var StdItem: TStdItem_);
begin
  if StdItem.Reserved >= 15 then StdItem.Reserved := 0;
  case StdItem.StdMode of
    5, 6: begin
        StdItem.DC := MakeLong(LoWord(StdItem.DC) + UserItem.AddValue[7], HiWord(StdItem.DC) + UserItem.btValue[0]);
        StdItem.MC := MakeLong(LoWord(StdItem.MC) + UserItem.AddValue[8], HiWord(StdItem.MC) + UserItem.btValue[1]);
        StdItem.SC := MakeLong(LoWord(StdItem.SC) + UserItem.AddValue[9], HiWord(StdItem.SC) + UserItem.btValue[2]);

        StdItem.AC := MakeLong(LoWord(StdItem.AC) + UserItem.btValue[3], HiWord(StdItem.AC) + UserItem.btValue[5]);
        StdItem.MAC := MakeLong(LoWord(StdItem.MAC) + UserItem.btValue[4], HiWord(StdItem.MAC) + UserItem.btValue[6]);
        if Byte(UserItem.btValue[7] - 1) < 10 then begin //神圣
          StdItem.Source := UserItem.btValue[7];
        end;
        if UserItem.btValue[10] <> 0 then
          StdItem.Reserved := StdItem.Reserved or 1;
      end;
    10, 11: begin
        StdItem.AC := MakeLong(LoWord(StdItem.AC) + UserItem.AddValue[7], HiWord(StdItem.AC) + UserItem.btValue[0]);
        StdItem.MAC := MakeLong(LoWord(StdItem.MAC) + UserItem.AddValue[8], HiWord(StdItem.MAC) + UserItem.btValue[1]);
        StdItem.DC := MakeLong(LoWord(StdItem.DC) + UserItem.AddValue[9], HiWord(StdItem.DC) + UserItem.btValue[2]);
        StdItem.MC := MakeLong(LoWord(StdItem.MC) + UserItem.AddValue[10], HiWord(StdItem.MC) + UserItem.btValue[3]);
        StdItem.SC := MakeLong(LoWord(StdItem.SC) + UserItem.AddValue[11], HiWord(StdItem.SC) + UserItem.btValue[4]);
      end;
    15, 19, 20, 21, 22, 23, 24, 26, 51, 52, 53, 54, 62, 63, 64: begin
        StdItem.AC := MakeLong(LoWord(StdItem.AC) + UserItem.AddValue[7], HiWord(StdItem.AC) + UserItem.btValue[0]);
        StdItem.MAC := MakeLong(LoWord(StdItem.MAC) + UserItem.AddValue[8], HiWord(StdItem.MAC) + UserItem.btValue[1]);
        StdItem.DC := MakeLong(LoWord(StdItem.DC) + UserItem.AddValue[9], HiWord(StdItem.DC) + UserItem.btValue[2]);
        StdItem.MC := MakeLong(LoWord(StdItem.MC) + UserItem.AddValue[10], HiWord(StdItem.MC) + UserItem.btValue[3]);
        StdItem.SC := MakeLong(LoWord(StdItem.SC) + UserItem.AddValue[11], HiWord(StdItem.SC) + UserItem.btValue[4]);
        if UserItem.btValue[5] > 0 then begin
          StdItem.Need := UserItem.btValue[5];
        end;
        if UserItem.btValue[6] > 0 then begin
          StdItem.NeedLevel := UserItem.btValue[6];
        end;
      end;
  end;

end;

function TLocalDB.LoadMonsterDB(): Integer;
var
  I: Integer;
  Monster: pTMonInfo;
resourcestring
  sSQLString = 'select * from Monster';
begin
  Result := 0;

  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.Open;
  finally
    Result := -1;
  end;
  for I := 0 to Query.RecordCount - 1 do begin
    New(Monster);
      //Monster.ItemList := TList.Create;
    Monster.sName := Trim(Query.FieldByName('NAME').AsString);
    Monster.btRace := Query.FieldByName('Race').AsInteger;
    Monster.btRaceImg := Query.FieldByName('RaceImg').AsInteger;
    Monster.wAppr := Query.FieldByName('Appr').AsInteger;
    Monster.wLevel := Query.FieldByName('Lvl').AsInteger;
    Monster.btLifeAttrib := Query.FieldByName('Undead').AsInteger;
    Monster.wCoolEye := Query.FieldByName('CoolEye').AsInteger;
    Monster.dwExp := Query.FieldByName('Exp').AsInteger;

      //城门或城墙的状态跟HP值有关，如果HP异常，将导致城墙显示不了
    if Monster.btRace in [110, 111] then begin //如果为城墙或城门由HP不加倍
      Monster.wHP := Query.FieldByName('HP').AsInteger;
    end else begin
      Monster.wHP := Round(Query.FieldByName('HP').AsInteger * (g_Config.nMonsterPowerRate / 10));
    end;

    Monster.wMP := Round(Query.FieldByName('MP').AsInteger * (g_Config.nMonsterPowerRate / 10));
    Monster.wAC := Round(Query.FieldByName('AC').AsInteger * (g_Config.nMonsterPowerRate / 10));
    Monster.wMAC := Round(Query.FieldByName('MAC').AsInteger * (g_Config.nMonsterPowerRate / 10));
    Monster.wDC := Round(Query.FieldByName('DC').AsInteger * (g_Config.nMonsterPowerRate / 10));
    Monster.wMaxDC := Round(Query.FieldByName('DCMAX').AsInteger * (g_Config.nMonsterPowerRate / 10));
    Monster.wMC := Round(Query.FieldByName('MC').AsInteger * (g_Config.nMonsterPowerRate / 10));
    Monster.wSC := Round(Query.FieldByName('SC').AsInteger * (g_Config.nMonsterPowerRate / 10));
    Monster.wSpeed := Query.FieldByName('SPEED').AsInteger;
    Monster.wHitPoint := Query.FieldByName('HIT').AsInteger;
    Monster.wWalkSpeed := _MAX(200, Query.FieldByName('WALK_SPD').AsInteger);
    Monster.wWalkStep := _MAX(1, Query.FieldByName('WalkStep').AsInteger);
    Monster.wWalkWait := Query.FieldByName('WalkWait').AsInteger;
    Monster.wAttackSpeed := Query.FieldByName('ATTACK_SPD').AsInteger;

    if Monster.wWalkSpeed < 200 then Monster.wWalkSpeed := 200;
    if Monster.wAttackSpeed < 200 then Monster.wAttackSpeed := 200;
    Monster.ItemList := nil;
    m_MonsterList.Add(Monster);
    Result := 1;
    Query.Next;
  end;
  Query.Close;
end;

function TLocalDB.LoadMagicDB(): Integer;
var
  I: Integer;
  Magic, OldMagic: pTMagic;
  OldMagicList: TList;
resourcestring
  sSQLString = 'select * from Magic';
begin
  Result := -1;
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.Open;
  finally
    Result := -2;
  end;
  for I := 0 to Query.RecordCount - 1 do begin
    New(Magic);
    Magic.wMagicId := Query.FieldByName('MagId').AsInteger;
    Magic.sMagicName := Query.FieldByName('MagName').AsString;
    Magic.btEffectType := Query.FieldByName('EffectType').AsInteger;
    Magic.btEffect := Query.FieldByName('Effect').AsInteger;
    Magic.wSpell := Query.FieldByName('Spell').AsInteger;
    Magic.wPower := Query.FieldByName('Power').AsInteger;
    Magic.wMaxPower := Query.FieldByName('MaxPower').AsInteger;
    Magic.btJob := Query.FieldByName('Job').AsInteger;
    Magic.TrainLevel[0] := Query.FieldByName('NeedL1').AsInteger;
    Magic.TrainLevel[1] := Query.FieldByName('NeedL2').AsInteger;
    Magic.TrainLevel[2] := Query.FieldByName('NeedL3').AsInteger;
    Magic.TrainLevel[3] := Magic.TrainLevel[2];
    Magic.MaxTrain[0] := Query.FieldByName('L1Train').AsInteger;
    Magic.MaxTrain[1] := Query.FieldByName('L2Train').AsInteger;
    Magic.MaxTrain[2] := Query.FieldByName('L3Train').AsInteger;
    Magic.MaxTrain[3] := Magic.MaxTrain[2];
    Magic.btTrainLv := 3;
    Magic.dwDelayTime := Query.FieldByName('Delay').AsInteger;
    Magic.btDefSpell := Query.FieldByName('DefSpell').AsInteger;
    Magic.btDefPower := Query.FieldByName('DefPower').AsInteger;
    Magic.btDefMaxPower := Query.FieldByName('DefMaxPower').AsInteger;
    Magic.sDescr := Query.FieldByName('Descr').AsString;
    if Magic.wMagicId > 0 then begin
      m_MagicList.Add(Magic);
    end else begin
      Dispose(Magic);
    end;
    Result := 1;
    Query.Next;
  end;
  Query.Close;
end;

function TLocalDB.LoadItemsDB(): Integer;
var
  I, Idx: Integer;
  StdItem: pTStdItem_;
resourcestring
  sSQLString = 'select * from StdItems';
begin
  try
    Result := -1;
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    finally
      Result := -2;
    end;
    for I := 0 to Query.RecordCount - 1 do begin
      New(StdItem);
      Idx := Query.FieldByName('Idx').AsInteger;
      StdItem.Name := Query.FieldByName('Name').AsString;
      StdItem.StdMode := Query.FieldByName('StdMode').AsInteger;
      StdItem.Shape := Query.FieldByName('Shape').AsInteger;
      StdItem.Weight := Query.FieldByName('Weight').AsInteger;
      StdItem.AniCount := Query.FieldByName('AniCount').AsInteger;
      StdItem.Source := Query.FieldByName('Source').AsInteger;
      StdItem.Reserved := Query.FieldByName('Reserved').AsInteger;
      StdItem.Looks := Query.FieldByName('Looks').AsInteger;
      StdItem.DuraMax := Word(Query.FieldByName('DuraMax').AsInteger);
      StdItem.AC := MakeLong(Round(Query.FieldByName('Ac').AsInteger * (g_Config.nItemsACPowerRate / 10)), Round(Query.FieldByName('Ac2').AsInteger * (g_Config.nItemsACPowerRate / 10)));
      StdItem.MAC := MakeLong(Round(Query.FieldByName('Mac').AsInteger * (g_Config.nItemsACPowerRate / 10)), Round(Query.FieldByName('MAc2').AsInteger * (g_Config.nItemsACPowerRate / 10)));
      StdItem.DC := MakeLong(Round(Query.FieldByName('Dc').AsInteger * (g_Config.nItemsPowerRate / 10)), Round(Query.FieldByName('Dc2').AsInteger * (g_Config.nItemsPowerRate / 10)));
      StdItem.MC := MakeLong(Round(Query.FieldByName('Mc').AsInteger * (g_Config.nItemsPowerRate / 10)), Round(Query.FieldByName('Mc2').AsInteger * (g_Config.nItemsPowerRate / 10)));
      StdItem.SC := MakeLong(Round(Query.FieldByName('Sc').AsInteger * (g_Config.nItemsPowerRate / 10)), Round(Query.FieldByName('Sc2').AsInteger * (g_Config.nItemsPowerRate / 10)));
      StdItem.Need := Query.FieldByName('Need').AsInteger;
      StdItem.NeedLevel := Query.FieldByName('NeedLevel').AsInteger;
      StdItem.Price := Query.FieldByName('Price').AsInteger;

      //StdItem.sDescr := Query.FieldByName('Descr').AsString;

      StdItem.NeedIdentify := GetGameLogItemNameList(StdItem.Name);
      //StdItem.Index := Idx+1;
      if m_StdItemList.Count = Idx then begin
        m_StdItemList.Add(StdItem);
        StdItem.Index := m_StdItemList.Count - 1;
        Result := 1;
      end else begin
        Dispose(StdItem);
        ShowMessage(Format('加载物品(Idx:%d Name:%s)数据失败！！！', [Idx, StdItem.Name]));
        //Memo.Lines.Add(Format('加载物品(Idx:%d Name:%s)数据失败！！！', [Idx, StdItem.Name]));
        Result := -100;
        Exit;
      end;
      Query.Next;
    end;
    {g_boGameLogGold := GetGameLogItemNameList(sSTRING_GOLDNAME) = 1;
    g_boGameLogHumanDie := GetGameLogItemNameList(g_sHumanDieEvent) = 1;
    g_boGameLogGameGold := GetGameLogItemNameList(g_Config.sGameGoldName) = 1;
    g_boGameLogGamePoint := GetGameLogItemNameList(g_Config.sGamePointName) = 1;  }
  finally
    Query.Close;
  end;
end;

procedure TLocalDB.GetStdItemList(nStdMode: Integer; ItemList: TStrings);
var
  I: Integer;
  StdItem: pTStdItem_;
begin
  ItemList.Clear;
  for I := 0 to m_StdItemList.Count - 1 do begin
    StdItem := m_StdItemList.Items[I];
    if StdItem.StdMode = nStdMode then
      ItemList.AddObject('(' + IntToStr(I) + ')' + StdItem.Name, TObject(StdItem));
  end;
end;

function TLocalDB.GetStdItem(nIdx: Integer): pTStdItem_;
var
  nItemIdx: Integer;
begin
  Result := nil;
  nItemIdx := nIdx;
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (m_StdItemList.Count > nItemIdx) then begin
    Result := m_StdItemList.Items[nItemIdx];
    if Result.Name = '' then Result := nil;
  end;
end;

function TLocalDB.GetStdItem(sItemName: string): pTStdItem_;
var
  I: Integer;
  StdItem: pTStdItem_;
begin
  Result := nil;
  if sItemName = '' then Exit;
  for I := 0 to m_StdItemList.Count - 1 do begin
    StdItem := m_StdItemList.Items[I];
    if CompareText(StdItem.Name, sItemName) = 0 then begin
      Result := StdItem;
      Break;
    end;
  end;
end;

function TLocalDB.GetStdItemName(nItemIdx: Integer): string;
begin
  Result := '';
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (m_StdItemList.Count > nItemIdx) then begin
    Result := pTStdItem_(m_StdItemList.Items[nItemIdx]).Name;
  end else Result := '';
end;

function TLocalDB.GetStdItemIdx(sItemName: string): Integer;
var
  I: Integer;
  StdItem: pTStdItem_;
begin
  Result := -1;
  if sItemName = '' then Exit;
  for I := 0 to m_StdItemList.Count - 1 do begin
    StdItem := m_StdItemList.Items[I];
    if StdItem <> nil then begin
      if CompareText(StdItem.Name, sItemName) = 0 then begin
        Result := I + 1;
        Break;
      end;
    end;
  end;
end;

function TLocalDB.FindMagic(nMagIdx: Integer): pTMagic;
var
  I: Integer;
  Magic: pTMagic;
begin
  Result := nil;
  for I := 0 to m_MagicList.Count - 1 do begin
    Magic := m_MagicList.Items[I];
    if (Magic <> nil) and (Magic.sDescr = '') then begin
      if Magic.wMagicId = nMagIdx then begin
        Result := Magic;
        Break;
      end;
    end;
  end;
end;

function TLocalDB.FindHeroMagic(nMagIdx: Integer): pTMagic;
var
  I: Integer;
  Magic: pTMagic;
begin
  Result := nil;
  for I := 0 to m_MagicList.Count - 1 do begin
    Magic := m_MagicList.Items[I];
    if (Magic <> nil) and (Magic.sDescr = '英雄') then begin
      if Magic.wMagicId = nMagIdx then begin
        Result := Magic;
        Break;
      end;
    end;
  end;
end;

function TLocalDB.FindHeroMagic(sMagicName: string): pTMagic;
var
  I: Integer;
  Magic: pTMagic;
begin
  Result := nil;
  for I := 0 to m_MagicList.Count - 1 do begin
    Magic := m_MagicList.Items[I];
    if (Magic <> nil) and (Magic.sDescr = '英雄') then begin
      if CompareText(Magic.sMagicName, sMagicName) = 0 then begin
        Result := Magic;
        Break;
      end;
    end;
  end;
end;

function TLocalDB.FindMagic(sMagicName: string): pTMagic;
var
  I: Integer;
  Magic: pTMagic;
begin
  Result := nil;
  for I := 0 to m_MagicList.Count - 1 do begin
    Magic := m_MagicList.Items[I];
    if (Magic <> nil) and (Magic.sDescr = '') then begin
      if CompareText(Magic.sMagicName, sMagicName) = 0 then begin
        Result := Magic;
        Break;
      end;
    end;
  end;
end;

end.

