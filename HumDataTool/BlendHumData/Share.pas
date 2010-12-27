unit Share;

interface
uses
  Windows, Classes, SysUtils, Controls, RzLabel, RzPanel, RzRadChk, RzStatus;
const
  TESTMODE = 0;
type
  TItemBind = record
    nMakeIdex: Integer;
    nItemIdx: Integer;
    //boAddLight: Boolean;
    sBindName: string[20];
  end;
  pTItemBind = ^TItemBind;


  TLoadMirData = class
    m_nFileHandle: Integer;
    m_sDBFileName: string;
    m_nType: Integer;
    m_ProgressStatus: TRzProgressStatus;
    m_RzStatusPane: TRzStatusPane;
    m_nPercent: Integer;
    m_nCount: Integer;
  private

  public
    constructor Create(sFileName: string); virtual;
    destructor Destroy; virtual;
    procedure ProcessStatus();
    procedure ProcessMessage(sMsg: string);
  end;

  TQuickList = class(TStringList)
  private
    CriticalSection: TRTLCriticalSection;
    function GetCaseSensitive: Boolean;
    procedure SetCaseSensitive(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    procedure SortString(nMIN, nMax: Integer);
    function GetIndex(sName: string): Integer;
    function GetIndexA(sName: string): Integer;
    function AddRecord(sName: string; Obj: TObject): Boolean;
    procedure Lock;
    procedure UnLock;
    procedure DelRecord(Obj: TObject);
  published
    property boCaseSensitive: Boolean read GetCaseSensitive write SetCaseSensitive;
  end;

  TQuickIDList = class(TStringList)
  public
    procedure AddRecord(sAccount: string; PRecord: Pointer);
    procedure DelRecord(nIndex: Integer; sChrName: string); overload;
    procedure DelRecord(P: Pointer); overload;
    function GetList(sAccount: string; var List: TList): Integer;
    procedure SortString(nMIN, nMax: Integer);
  end;

  TGuildRank = record
    nRankNo: Integer;
    sRankName: string;
    MemberList: TStringList;
  end;
  pTGuildRank = ^TGuildRank;
  TWarGuild = record
    Guild: TObject;
    dwWarTick: LongWord;
    dwWarTime: LongWord;
  end;
  pTWarGuild = ^TWarGuild;
  TGuild = record
    sGuildDir: string;
    sGuildName: string;
    sGuildNotice: string;
    sGuildWar: string;
    sGuildAll: string;
    sGuildMember: string;
    sGuildMemberRank: string;
    sGuildChief: string;

    nBuildPoint: Integer;
    nAurae: Integer;
    nStability: Integer;
    nFlourishing: Integer;
    nChiefItemCount: Integer;
    nMemberMaxLimit: Integer;
    NoticeList: TStringList;
    GuildWarList: TStringList;
    GuildAllList: TStringList;
    RankList: TList; // 职位列表
  end;
  pTGuild = ^TGuild;
var
  g_boClose: Boolean;
  g_boClearHum1: Boolean;
  g_boClearHum2: Boolean;
  g_boClearHum3: Boolean;
  g_boClearID1: Boolean;
  g_boClearID2: Boolean;
  g_nLimitDay1: Integer;
  g_nLimitDay2: Integer;
  g_nLimitLevel1: Integer;
  g_nLimitLevel2: Integer;
  g_LastDate: TDate;
  g_boCheckCopyItems: Boolean;
  g_boBigStorage: Boolean = False;
  g_boSellOff: Boolean = False;
  g_boItemBind: Boolean = False;
  g_boItemDblClick: Boolean = False;
  g_boDuel: Boolean = False;
  g_boDeleteLowLevel: Boolean = True;


  g_boHero: Boolean;
  g_boStart: Boolean;
  g_boSetItemMakeIndex: Boolean;
  g_nMaxItemMakeIndex: Integer;
  g_nMaxItemMakeIndexEx: Integer;




  g_nIDDBCount: Integer;
  g_nHumDBCount: Integer;
  g_nMirDBCount: Integer;
  g_nGuildBaseCount: Integer;
  g_nBigStorageCount: Integer;
  g_nSellOffSellCount: Integer;
  g_nSellOffGoldCount: Integer;

  g_dwStartTick: LongWord;

  g_boRepairHeroData: Boolean;

  g_sSaveDir: string;
  g_sIDDB1: string;
  g_sHumDB1: string;
  g_sMirDB1: string;
  g_sGuildBase1: string;
  g_sBigStorage1: string;
  g_sSellOffSell1: string;
  g_sSellOffGold1: string;

  g_sDuelItem1: string;
  g_sDuelInfo1: string;

  g_sSetup1: string;

  g_sRememberItemList1: string;
  g_sItemBindIPaddr1: string;
  g_sItemBindAccount1: string;
  g_sItemBindChrName1: string;

  g_sIDDB2: string;
  g_sHumDB2: string;
  g_sMirDB2: string;
  g_sGuildBase2: string;
  g_sBigStorage2: string;
  g_sSellOffSell2: string;
  g_sSellOffGold2: string;
  g_sDuelItem2: string;
  g_sDuelInfo2: string;

  g_sSetup2: string;

  g_sRememberItemList2: string;
  g_sItemBindIPaddr2: string;
  g_sItemBindAccount2: string;
  g_sItemBindChrName2: string;


  g_sGuildNotice1: string = '公告';
  g_sGuildWar1: string = '敌对行会';
  g_sGuildAll1: string = '联盟行会';
  g_sGuildMember1: string = '行会成员';
  g_sGuildMemberRank1: string = '行会成员';
  g_sGuildChief1: string = '掌门人';

  g_sGuildNotice2: string = '公告';
  g_sGuildWar2: string = '敌对行会';
  g_sGuildAll2: string = '联盟行会';
  g_sGuildMember2: string = '行会成员';
  g_sGuildMemberRank2: string = '行会成员';
  g_sGuildChief2: string = '掌门人';

  g_LogIDList, g_LogHumList, g_LogGuildList, g_SysLog, g_TestList: TStringList;

  g_DynamicVarListA: TStringList;
  g_DynamicVarListB: TStringList;

  g_CharNameListA: TStringList;
  g_CharNameListB: TStringList;

function GetItemNumber(): Integer;
function GetItemNumberEx(): Integer;
implementation

function GetItemNumber(): Integer;
begin
  Inc(g_nMaxItemMakeIndex);
  if g_nMaxItemMakeIndex > (High(Integer) div 2 - 1) then begin
    g_nMaxItemMakeIndex := 1;
  end;
  Result := g_nMaxItemMakeIndex;
end;

function GetItemNumberEx(): Integer;
begin
  Inc(g_nMaxItemMakeIndexEx);
  if g_nMaxItemMakeIndexEx < High(Integer) div 2 then g_nMaxItemMakeIndexEx := High(Integer) div 2;

  if g_nMaxItemMakeIndexEx > (High(Integer) - 1) then begin
    g_nMaxItemMakeIndexEx := High(Integer) div 2;
  end;
  Result := g_nMaxItemMakeIndexEx;
end;

constructor TLoadMirData.Create(sFileName: string);
begin
  m_sDBFileName := sFileName;
  m_nType := 0;
  m_ProgressStatus := nil;
  m_RzStatusPane := nil;
  m_nFileHandle := 0;
  m_nPercent := 0;
  m_nCount := 0;
end;

destructor TLoadMirData.Destroy;
begin
  inherited;
end;

procedure TLoadMirData.ProcessStatus();
begin
  try
    if m_ProgressStatus <> nil then begin
      Inc(m_nPercent);
      m_ProgressStatus.Percent := Trunc(m_nPercent / (m_nCount / 100));
    end;
  except
  end;
end;

procedure TLoadMirData.ProcessMessage(sMsg: string);
begin
  try
    if m_RzStatusPane <> nil then begin
      m_RzStatusPane.Caption := sMsg;
    end;
  except
  end;
end;

{ TQuickIDList }

procedure TQuickIDList.AddRecord(sAccount: string; PRecord: Pointer);
var
  ChrList: TList;
  nLow, nHigh, nMed, n1C, n20: Integer;
begin
  ChrList := nil;
  {if (GetList(sAccount, ChrList) >= 0) and (ChrList <> nil) then begin
    ChrList.Add(PRecord);
  end else begin
    ChrList := TList.Create;
    ChrList.Add(PRecord);
    AddObject(sAccount, ChrList);
  end; }
  if Count = 0 then begin
    ChrList := TList.Create;
    ChrList.Add(PRecord);
    AddObject(sAccount, ChrList);
  end else begin
    if Count = 1 then begin
      nMed := CompareStr(sAccount, Self.Strings[0]);
      if nMed > 0 then begin
        ChrList := TList.Create;
        ChrList.Add(PRecord);
        AddObject(sAccount, ChrList);
      end else begin
        if nMed < 0 then begin
          ChrList := TList.Create;
          ChrList.Add(PRecord);
          InsertObject(0, sAccount, ChrList);
        end else begin
          ChrList := TList(Self.Objects[0]);
          ChrList.Add(PRecord);
        end;
      end;
    end else begin
      nLow := 0;
      nHigh := Self.Count - 1;
      nMed := (nHigh - nLow) div 2 + nLow;
      while (True) do begin
        if (nHigh - nLow) = 1 then begin
          n20 := CompareStr(sAccount, Self.Strings[nHigh]);
          if n20 > 0 then begin
            ChrList := TList.Create;
            ChrList.Add(PRecord);
            InsertObject(nHigh + 1, sAccount, ChrList);
            Break;
          end else begin
            if CompareStr(sAccount, Self.Strings[nHigh]) = 0 then begin
              ChrList := TList(Self.Objects[nHigh]);
              ChrList.Add(PRecord);
              Break;
            end else begin
              n20 := CompareStr(sAccount, Self.Strings[nLow]);
              if n20 > 0 then begin
                ChrList := TList.Create;
                ChrList.Add(PRecord);
                InsertObject(nLow + 1, sAccount, ChrList);
                Break;
              end else begin
                if n20 < 0 then begin
                  ChrList := TList.Create;
                  ChrList.Add(PRecord);
                  InsertObject(nLow, sAccount, ChrList);
                  Break;
                end else begin
                  ChrList := TList(Self.Objects[n20]);
                  ChrList.Add(PRecord);
                  Break;
                end;
              end;
            end;
          end;

        end else begin
          n1C := CompareStr(sAccount, Self.Strings[nMed]);
          if n1C > 0 then begin
            nLow := nMed;
            nMed := (nHigh - nLow) div 2 + nLow;
            Continue;
          end;
          if n1C < 0 then begin
            nHigh := nMed;
            nMed := (nHigh - nLow) div 2 + nLow;
            Continue;
          end;
          ChrList := TList(Self.Objects[nMed]);
          ChrList.Add(PRecord);
          Break;
        end;
      end;
    end;
  end;
end;

procedure TQuickIDList.DelRecord(P: Pointer);
var
  ChrList: TList;
  nIndex, I: Integer;
  boFind: Boolean;
begin
  for nIndex := 0 to Count - 1 do begin
    ChrList := TList(Self.Objects[nIndex]);
    boFind := False;
    for I := 0 to ChrList.Count - 1 do begin
      if ChrList.Items[I] = P then begin
        ChrList.Delete(I);
        boFind := True;
        Break;
      end;
    end;
    if boFind then begin
      if ChrList.Count <= 0 then begin
        ChrList.Free;
        Self.Delete(nIndex);
      end;
      break;
    end;
  end;
end;

procedure TQuickIDList.DelRecord(nIndex: Integer; sChrName: string);
var
  ChrList: TList;
  I: Integer;
begin
  {if (Self.Count - 1) < nIndex then Exit;
  ChrList := TList(Self.Objects[nIndex]);
  for I := 0 to ChrList.Count - 1 do begin
    QuickID := ChrList.Items[I];
    if QuickID.sChrName = sChrName then begin
      Dispose(QuickID);
      ChrList.Delete(I);
      Break;
    end;
  end;
  if ChrList.Count <= 0 then begin
    ChrList.Free;
    Self.Delete(nIndex);
  end;}
end;

function TQuickIDList.GetList(sAccount: string;
  var List: TList): Integer;
var
  I, nHigh, nLow, nMed, n20, n24: Integer;
begin
  Result := -1;
 { for I := 0 to Self.Count - 1 do begin
    if CompareText(sAccount, Self.Strings[I]) = 0 then begin
      List := TList(Self.Objects[I]);
      Result := I;
      Break;
    end;
  end;  }
  if Self.Count = 0 then Exit;
  if Self.Count = 1 then begin
    if CompareStr(sAccount, Self.Strings[0]) = 0 then begin
      List := TList(Self.Objects[0]);
      Result := 0;
    end;
  end else begin
    nLow := 0;
    nHigh := Self.Count - 1;
    nMed := (nHigh - nLow) div 2 + nLow;
    n24 := -1;
    while (True) do begin
      if (nHigh - nLow) = 1 then begin
        if CompareStr(sAccount, Self.Strings[nHigh]) = 0 then n24 := nHigh;
        if CompareStr(sAccount, Self.Strings[nLow]) = 0 then n24 := nLow;
        Break;
      end else begin
        n20 := CompareStr(sAccount, Self.Strings[nMed]);
        if n20 > 0 then begin
          nLow := nMed;
          nMed := (nHigh - nLow) div 2 + nLow;
          Continue;
        end;
        if n20 < 0 then begin
          nHigh := nMed;
          nMed := (nHigh - nLow) div 2 + nLow;
          Continue;
        end;
        n24 := nMed;
        Break;
      end;
    end;
    if n24 <> -1 then List := TList(Self.Objects[n24]);
    Result := n24;
  end;
end;

procedure TQuickIDList.SortString(nMIN, nMax: Integer);
var
  ntMin, ntMax: Integer;
  s18: string;
begin
  if Self.Count > 0 then
    while (True) do begin
      ntMin := nMIN;
      ntMax := nMax;
      s18 := Self.Strings[(nMIN + nMax) shr 1];
      while (True) do begin
        while (CompareText(Self.Strings[ntMin], s18) < 0) do Inc(ntMin);
        while (CompareText(Self.Strings[ntMax], s18) > 0) do Dec(ntMax);
        if ntMin <= ntMax then begin
          Self.Exchange(ntMin, ntMax);
          Inc(ntMin);
          Dec(ntMax);
        end;
        if ntMin > ntMax then Break
      end;
      if nMIN < ntMax then SortString(nMIN, ntMax);
      nMIN := ntMin;
      if ntMin >= nMax then Break;
    end;
end;

{ TQuickList }

function TQuickList.GetIndex(sName: string): Integer;
var
  I, nLow, nHigh, nMed, nCompareVal: Integer;
  s: string;
begin
  Result := -1;
  {for I := 0 to Self.Count - 1 do begin
    if CompareText(sName, Self.Strings[I]) = 0 then begin
      Result := I;
      Break;
    end;
  end;   }

  if Self.Count <> 0 then begin
    if Self.Sorted then begin
      if Self.Count = 1 then begin
        if CompareStr(sName, Self.Strings[0]) = 0 then Result := 0;
      end else begin
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            if CompareStr(sName, Self.Strings[nHigh]) = 0 then Result := nHigh;
            if CompareStr(sName, Self.Strings[nLow]) = 0 then Result := nLow;
            Break;
          end else begin
            nCompareVal := CompareStr(sName, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := nMed;
            Break;
          end;
        end;
      end;
    end else begin
      if Self.Count = 1 then begin
        if CompareText(sName, Self.Strings[0]) = 0 then Result := 0;
      end else begin
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            if CompareText(sName, Self.Strings[nHigh]) = 0 then Result := nHigh;
            if CompareText(sName, Self.Strings[nLow]) = 0 then Result := nLow;
            Break;
          end else begin
            nCompareVal := CompareText(sName, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := nMed;
            Break;
          end;
        end;
      end;
    end;
  end;
end;

function TQuickList.GetIndexA(sName: string): Integer;
var
  I, nLow, nHigh, nMed, nCompareVal: Integer;
  s: string;
begin
  Result := -1;
  for I := 0 to Self.Count - 1 do begin
    if CompareText(sName, Self.Strings[I]) = 0 then begin
      Result := I;
      Break;
    end;
  end;

  {if Self.Count <> 0 then begin
    if Self.Sorted then begin
      if Self.Count = 1 then begin
        if CompareStr(sName, Self.Strings[0]) = 0 then Result := 0;
      end else begin
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            if CompareStr(sName, Self.Strings[nHigh]) = 0 then Result := nHigh;
            if CompareStr(sName, Self.Strings[nLow]) = 0 then Result := nLow;
            Break;
          end else begin
            nCompareVal := CompareStr(sName, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := nMed;
            Break;
          end;
        end;
      end;
    end else begin
      if Self.Count = 1 then begin
        if CompareText(sName, Self.Strings[0]) = 0 then Result := 0;
      end else begin
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            if CompareText(sName, Self.Strings[nHigh]) = 0 then Result := nHigh;
            if CompareText(sName, Self.Strings[nLow]) = 0 then Result := nLow;
            Break;
          end else begin
            nCompareVal := CompareText(sName, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := nMed;
            Break;
          end;
        end;
      end;
    end;
  end; }
end;

procedure TQuickList.SortString(nMIN, nMax: Integer);
var
  ntMin, ntMax: Integer;
  s18: string;
begin
  if Self.Count > 0 then
    while (True) do begin
      ntMin := nMIN;
      ntMax := nMax;
      s18 := Self.Strings[(nMIN + nMax) shr 1];
      while (True) do begin
        while (CompareText(Self.Strings[ntMin], s18) < 0) do Inc(ntMin);
        while (CompareText(Self.Strings[ntMax], s18) > 0) do Dec(ntMax);
        if ntMin <= ntMax then begin
          Self.Exchange(ntMin, ntMax);
          Inc(ntMin);
          Dec(ntMax);
        end;
        if ntMin > ntMax then Break
      end;
      if nMIN < ntMax then SortString(nMIN, ntMax);
      nMIN := ntMin;
      if ntMin >= nMax then Break;
    end;
end;

function TQuickList.AddRecord(sName: string; Obj: TObject): Boolean;
var
  nLow, nHigh, nMed, nCompareVal: Integer;
begin
  Result := True;
 { if GetIndex(sName) >= 0 then Exit;
  Self.AddObject(sName, Obj);
  Result := True; }
  if Self.Count = 0 then begin
    Self.AddObject(sName, Obj);
  end else begin
    if Self.Sorted then begin
      if Self.Count = 1 then begin
        nMed := CompareStr(sName, Self.Strings[0]);
        if nMed > 0 then
          Self.AddObject(sName, Obj)
        else begin
          if nMed < 0 then Self.InsertObject(0, sName, Obj);
        end;
      end else begin
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            nMed := CompareStr(sName, Self.Strings[nHigh]);
            if nMed > 0 then begin
              Self.InsertObject(nHigh + 1, sName, Obj);
              Break;
            end else begin
              nMed := CompareStr(sName, Self.Strings[nLow]);
              if nMed > 0 then begin
                Self.InsertObject(nLow + 1, sName, Obj);
                Break;
              end else begin
                if nMed < 0 then begin
                  Self.InsertObject(nLow, sName, Obj);
                  Break; ;
                end else begin
                  Result := False;
                  Break;
                end;
              end;
            end;
          end else begin
            nCompareVal := CompareStr(sName, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := False;
            Break;
          end;
        end;
      end;
    end else begin
      if Self.Count = 1 then begin
        nMed := CompareText(sName, Self.Strings[0]);
        if nMed > 0 then
          Self.AddObject(sName, Obj)
        else begin
          if nMed < 0 then Self.InsertObject(0, sName, Obj);
        end;
      end else begin
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            nMed := CompareText(sName, Self.Strings[nHigh]);
            if nMed > 0 then begin
              Self.InsertObject(nHigh + 1, sName, Obj);
              Break;
            end else begin
              nMed := CompareText(sName, Self.Strings[nLow]);
              if nMed > 0 then begin
                Self.InsertObject(nLow + 1, sName, Obj);
                Break;
              end else begin
                if nMed < 0 then begin
                  Self.InsertObject(nLow, sName, Obj);
                  Break;
                end else begin
                  Result := False;
                  Break;
                end;
              end;
            end;
          end else begin
            nCompareVal := CompareText(sName, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := False;
            Break;
          end;
        end;
      end;
    end;
  end;
end;

procedure TQuickList.DelRecord(Obj: TObject);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do begin
    if Objects[I] = Obj then begin
      Delete(I);
      break;
    end;
  end;
end;

function TQuickList.GetCaseSensitive: Boolean;
begin
  Result := CaseSensitive;
end;

procedure TQuickList.SetCaseSensitive(const Value: Boolean);
begin
  CaseSensitive := Value;
end;

procedure TQuickList.Lock;
begin
  EnterCriticalSection(CriticalSection);
end;

procedure TQuickList.UnLock;
begin
  LeaveCriticalSection(CriticalSection);
end;

constructor TQuickList.Create;
begin
  inherited;
  InitializeCriticalSection(CriticalSection);
end;

destructor TQuickList.Destroy;
begin
  DeleteCriticalSection(CriticalSection);
  inherited;
end;

initialization

finalization
end.

