unit ObjBase;

interface
uses
  Windows, Classes, SysUtils, Controls, RzLabel, RzPanel, RzRadChk, RzStatus, ComCtrls;
type
  TOnWork = procedure(Sender: TObject; const Number: Integer; const S: string) of object;
  TStartProc = procedure();
  TValue = array[0..13] of Byte;
  TStdItem_ = packed record
    Index: Integer;
    Name: string[30];
    StdMode: Byte;
    Shape: Byte;
    Weight: Byte;
    AniCount: Byte;
    Source: ShortInt;
    Reserved: Byte;
    NeedIdentify: Byte;
    Looks: Word;
    DuraMax: Word;
    Reserved1: Word;
    AC: Integer;
    MAC: Integer;
    DC: Integer;
    MC: Integer;
    SC: Integer;
    Need: Integer;
    NeedLevel: Integer;
    Price: Integer;
    AddValue: TValue;
    MaxDate: TDateTime;
    sDescr: string[20];
  end;
  pTStdItem_ = ^TStdItem_;


  TItemDataType = record
    btType: Byte;
    Owner: Pointer;
    Item: Pointer;
  end;
  pTItemDataType = ^TItemDataType;

  TDataManage = class
    m_nFileHandle: Integer;
    m_sDBFileName: string;
    m_nType: Integer;
    m_ProgressStatus: TProgressBar;
    m_RzStatusPane: TRzStatusPane;
    m_nPercent: Integer;
    m_nCount: Integer;
    m_boLoad: Boolean;
  private
    FOnStart: TOnWork;
    FOnProgress: TOnWork;
    FOnStop: TOnWork;
  public
    constructor Create(sFileName: string); virtual;
    destructor Destroy; virtual;
    procedure Load; virtual; abstract;
    procedure UnLoad; virtual; abstract;
    procedure SaveToFile(); virtual; abstract;
  published
    property OnStart: TOnWork read FOnStart write FOnStart;
    property OnProgress: TOnWork read FOnProgress write FOnProgress;
    property OnStop: TOnWork read FOnStop write FOnStop;
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
    function AddRecord(sName: string; Obj: TObject): Boolean;
    procedure Lock;
    procedure UnLock;
  published
    property boCaseSensitive: Boolean read GetCaseSensitive write SetCaseSensitive;
  end;

  TQuickIDList = class(TStringList)
  public
    procedure AddRecord(sAccount: string; PRecord: Pointer);
    procedure DelRecord(nIndex: Integer; sChrName: string);
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
    NoticeList: TStringList;
    GuildWarList: TStringList;
    GuildAllList: TStringList;
    RankList: TList; // 职位列表
  end;
  pTGuild = ^TGuild;

  TConfig = record
    nItemsACPowerRate: Integer;
    nItemsPowerRate: Integer;
    nMonsterPowerRate: Integer;
  end;
  pTConfig = ^TConfig;

const
  sSortString = '正在排序，请稍候...';
  sLondData = '正在读取%s中的数据，请稍候...';
  sConvertData = '正在转换%s中的数据，请稍候...';
  sSaveToFile = '正在保存%s的数据，请稍候...';
  g_sFileNames: array[0..5] of string = ('ID.db', 'Hum.DB', 'Mir.db', 'UserStorage.db', 'UserSellOff.sell', 'UserSellOff.Gold');
implementation

constructor TDataManage.Create(sFileName: string);
begin
  inherited Create;
  m_sDBFileName := sFileName;
  m_nType := 0;
  m_nFileHandle := 0;
  FOnStart := nil;
  FOnProgress := nil;
  FOnStop := nil;
  m_boLoad:=True;
end;

destructor TDataManage.Destroy;
begin
  inherited Destroy;
end;

{ TQuickIDList }

procedure TQuickIDList.AddRecord(sAccount: string; PRecord: Pointer);
var
  ChrList: TList;
  nLow, nHigh, nMed, n1C, n20: Integer;
begin
  {ChrList := nil;
  if (GetList(sAccount, ChrList) >= 0) and (ChrList <> nil) then begin
    ChrList.Add(PRecord);
  end else begin
    ChrList := TList.Create;
    ChrList.Add(PRecord);
    AddObject(sAccount, ChrList);
  end;  }
  ChrList := nil;
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
  {if sAccount = '' then Exit;
  for I := 0 to Self.Count - 1 do begin
    if CompareStr(sAccount, Self.Strings[I]) = 0 then begin
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
 { if sName = '' then Exit;
  for I := 0 to Self.Count - 1 do begin
    if CompareStr(sName, Self.Strings[I]) = 0 then begin
      Result := I;
      Break;
    end;
  end; }

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

  {if GetIndex(sName) >= 0 then Exit;
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

