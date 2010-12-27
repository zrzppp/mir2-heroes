unit HumDB;

interface
uses
  Windows, Classes, SysUtils, Forms, IniFiles, Share, Grobal;
resourcestring
  sDBHeaderDesc = '飞尔世界数据库文件 2010/07/01';
  sDBIdxHeaderDesc = '飞尔世界数据库文件 2010/07/01';

type
  TDBHeader = packed record //Size 124
    sDesc: string[$23]; //0x00    36
    n24: Integer; //0x24
    n28: Integer; //0x28
    n2C: Integer; //0x2C
    n30: Integer; //0x30
    n34: Integer; //0x34
    n38: Integer; //0x38
    n3C: Integer; //0x3C
    n40: Integer; //0x40
    n44: Integer; //0x44
    n48: Integer; //0x48
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    nLastIndex: Integer; //0x5C
    dLastDate: TDateTime; //0x60
    nHumCount: Integer; //0x68
    n6C: Integer; //0x6C
    n70: Integer; //0x70
    dUpdateDate: TDateTime; //0x74
  end;
  pTDBHeader = ^TDBHeader;

  TIdxHeader = packed record //Size 124
    sDesc: string[39]; //0x00
    n2C: Integer; //0x2C
    n30: Integer; //0x30
    n34: Integer; //0x34
    n38: Integer; //0x38
    n3C: Integer; //0x3C
    n40: Integer; //0x40
    n44: Integer; //0x44
    n48: Integer; //0x48
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    n5C: Integer; //0x5C
    n60: Integer; //0x60  95
    n70: Integer; //0x70  99
    nQuickCount: Integer; //0x74  100
    nHumCount: Integer; //0x78
    nDeleteCount: Integer; //0x7C
    nLastIndex: Integer; //0x80
    dUpdateDate: TDateTime; //0x84
  end;
  pTIdxHeader = ^TIdxHeader;

  TIdxRecord = record
    sChrName: string[15];
    nIndex: Integer;
  end;
  pTIdxRecord = ^TIdxRecord;

  TFileHumDB = class(TLoadMirData)
    m_Header: TDBHeader;
    m_HumDBList: TQuickIDList;
    m_HumCharNameList: TQuickList;
    m_IDDBList: TQuickList;
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure LoadQuickList();
    procedure UnLoadQuickList();
    procedure SaveToFile(); overload;
    procedure SaveToFile(sFileName: string); overload;
    procedure Close();
    procedure Delete(HumInfo: pTHumInfo);
  end;

  TFileDB = class(TLoadMirData)
    m_Header: TDBHeader;

    m_IDDBList: TQuickList;
    m_MasterList: TQuickList;
    m_DearList: TQuickList;
    m_HeroList: TQuickList;
    m_HeroNameList: TQuickList;
    m_MirCharNameList: TQuickList;
    m_HumCharNameList: TQuickList;
    m_MirDBList: TQuickIDList;
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
    procedure LoadQuickList();
    procedure UnLoadQuickList();
    procedure SaveToFile(); overload;
    procedure SaveToFile(sFileName: string); overload;
  end;

  TSellOff = class(TLoadMirData)
    m_Header: TItemCount;
    m_SellOffList: TQuickIDList;
    m_HumCharNameList: TQuickList;
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
    procedure LoadQuickList();
    procedure UnLoadSellOffList();
    procedure SaveToFile(); overload;
    procedure SaveToFile(sFileName: string); overload;
  end;

  TStorage = class(TLoadMirData)
    m_Header: TItemCount;
    m_BigStorageList: TQuickIDList;
    m_HumCharNameList: TQuickList;
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
    procedure LoadQuickList();
    procedure UnLoadQuickList();
    procedure SaveToFile(); overload;
    procedure SaveToFile(sFileName: string); overload;
  end;

  TGuildBase = class(TLoadMirData)
    m_GuildBaseList: TQuickList;
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;
    procedure LoadQuickList(nType: Integer);
    procedure UnLoadQuickList();
    procedure SaveToFile(sSaveFileName: string);
  end;

  TDuelItemDB = class(TLoadMirData)
    m_Header: TItemCount;
    m_HumCharNameList: TQuickList;
    m_ItemList: TQuickIDList;
    m_DuelItemList: TQuickIDList;
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
    procedure LoadQuickList();
    procedure UnLoadQuickList();
    procedure SaveToFile(); overload;
    procedure SaveToFile(sFileName: string); overload;
  end;

  TDuelInfoDB = class(TLoadMirData)
    m_Header: TItemCount;
    m_HumCharNameList: TQuickList;
    m_OwnerList: TQuickIDList;
    m_DuelList: TQuickIDList;
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
    procedure LoadQuickList();
    procedure UnLoadQuickList();
    procedure SaveToFile(); overload;
    procedure SaveToFile(sFileName: string); overload;
  end;
implementation

uses HUtil32;

constructor TGuildBase.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_GuildBaseList := TQuickList.Create;
end;

destructor TGuildBase.Destroy;
begin
  UnLoadQuickList();
  m_GuildBaseList.Free;
  inherited;
end;

procedure TGuildBase.LoadQuickList(nType: Integer);
  function LoadGuildConfig(Guild: pTGUild): Boolean;
  var
    Config: TIniFile;
  begin
    if FileExists(Guild.sGuildDir + 'Guilds\' + Guild.sGuildName + '.ini') then begin
      Config := TIniFile.Create(g_sGuildBase1 + Guild.sGuildName + '.ini');
      Guild.nBuildPoint := Config.ReadInteger('Guild', 'BuildPoint', 0);
      Guild.nAurae := Config.ReadInteger('Guild', 'Aurae', 0);
      Guild.nStability := Config.ReadInteger('Guild', 'Stability', 0);
      Guild.nFlourishing := Config.ReadInteger('Guild', 'Flourishing', 0);
      Guild.nChiefItemCount := Config.ReadInteger('Guild', 'ChiefItemCount', 0);
      Guild.nMemberMaxLimit := Config.ReadInteger('Guild', 'MemberMaxLimit', 100);
      Result := True;
    end;
  end;
  function LoadGuildFile(Guild: pTGUild): Boolean;
  var
    I: Integer;
    LoadList: TStringList;
    s18, s1C, s20, s24, sFileName: string;
    n28, n2C: Integer;
    GuildWar: pTWarGuild;
    GuildRank: pTGuildRank;
  begin
    Result := False;
    GuildRank := nil;
    sFileName := Guild.sGuildDir + 'Guilds\' + Guild.sGuildName + '.txt';
    if not FileExists(sFileName) then Exit;
    n28 := 0;
    n2C := 0;
    s24 := '';
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      s18 := LoadList.Strings[I];
      if (s18 = '') or (s18[1] = ';') then Continue;
      if s18[1] <> '+' then begin
        if s18 = Guild.sGuildNotice then n28 := 1;
        if s18 = Guild.sGuildWar then n28 := 2;
        if s18 = Guild.sGuildAll then n28 := 3;
        if s18 = Guild.sGuildMember then n28 := 4;
        if s18[1] = '#' then begin
          s18 := Copy(s18, 2, Length(s18) - 1);
          s18 := GetValidStr3(s18, s1C, [' ', ',']);
          n2C := Str_ToInt(s1C, 0);
          s24 := Trim(s18);
          GuildRank := nil;
        end;
        Continue;
      end;
      s18 := Copy(s18, 2, Length(s18) - 1);
      case n28 of
        1: Guild.NoticeList.Add(s18);
        2: begin
            while (s18 <> '') do begin
              s18 := GetValidStr3(s18, s1C, [' ', ',']);
              if s1C = '' then Break;
              New(GuildWar);
              GuildWar.dwWarTick := GetTickCount();
              GuildWar.dwWarTime := Str_ToInt(Trim(s20), 0);
              Guild.GuildWarList.AddObject(s1C, TObject(GuildWar));
            end;
          end;
        3: begin
            while (s18 <> '') do begin
              s18 := GetValidStr3(s18, s1C, [' ', ',']);
              s18 := GetValidStr3(s18, s20, [' ', ',']);
              if s1C = '' then Break;
              Guild.GuildAllList.Add(s1C);
            end;
          end;
        4: begin
            if (n2C > 0) and (s24 <> '') then begin
              if Length(s24) > 30 then //限制职倍的长度
                s24 := Copy(s24, 1, 30);
              if GuildRank = nil then begin
                New(GuildRank);
                GuildRank.nRankNo := n2C;
                GuildRank.sRankName := s24;
                GuildRank.MemberList := TStringList.Create;
                Guild.RankList.Add(GuildRank);
              end;
              while (s18 <> '') do begin
                s18 := GetValidStr3(s18, s1C, [' ', ',']);
                if s1C = '' then Break;
                GuildRank.MemberList.Add(s1C);
              end;
            end;
          end;
      end; // case
    end;
    LoadList.Free;
    Result := True;
  end;
  procedure LoadConfig1(sSetup: string);
  var
    StringConf: TIniFile;
  begin
    StringConf := TIniFile.Create(sSetup);
    if StringConf <> nil then begin
      g_sGuildNotice1 := StringConf.ReadString('Guild', 'GuildNotice', g_sGuildNotice1);
      g_sGuildWar1 := StringConf.ReadString('Guild', 'GuildWar', g_sGuildWar1);
      g_sGuildAll1 := StringConf.ReadString('Guild', 'GuildAll', g_sGuildAll1);
      g_sGuildMember1 := StringConf.ReadString('Guild', 'GuildMember', g_sGuildMember1);
      g_sGuildMemberRank1 := StringConf.ReadString('Guild', 'GuildMemberRank', g_sGuildMemberRank1);
      g_sGuildChief1 := StringConf.ReadString('Guild', 'GuildChief', g_sGuildChief1);
      StringConf.Free;
    end;
  end;

  procedure LoadConfig2(sSetup: string);
  var
    StringConf: TIniFile;
  begin
    StringConf := TIniFile.Create(sSetup);
    if StringConf <> nil then begin
      g_sGuildNotice2 := StringConf.ReadString('Guild', 'GuildNotice', g_sGuildNotice2);
      g_sGuildWar2 := StringConf.ReadString('Guild', 'GuildWar', g_sGuildWar2);
      g_sGuildAll2 := StringConf.ReadString('Guild', 'GuildAll', g_sGuildAll2);
      g_sGuildMember2 := StringConf.ReadString('Guild', 'GuildMember', g_sGuildMember2);
      g_sGuildMemberRank2 := StringConf.ReadString('Guild', 'GuildMemberRank', g_sGuildMemberRank2);
      g_sGuildChief2 := StringConf.ReadString('Guild', 'GuildChief', g_sGuildChief2);
      StringConf.Free;
    end;
  end;
var
  I: Integer;
  LoadList: TStringList;
  sFileName: string;
  sGuildName: string;
  Guild: pTGUild;
  boStart: Boolean;
begin
  boStart := False;
  if nType = 1 then begin
    if FileExists(g_sSetup1) then LoadConfig1(g_sSetup1);
    sFileName := g_sGuildBase1 + 'GuildList.txt';
    if FileExists(sFileName) then begin
      ProcessMessage('正在读取主库GuildBase中的数据，请稍候...');
      boStart := True;
    end;
  end else begin
    if FileExists(g_sSetup2) then LoadConfig2(g_sSetup2);
    sFileName := g_sGuildBase2 + 'GuildList.txt';
    if FileExists(sFileName) then begin
      ProcessMessage('正在读取从库GuildBase中的数据，请稍候...');
      boStart := True;
    end;
  end;

  if boStart then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    m_nPercent := 0;
    m_nCount := LoadList.Count;
    for I := 0 to LoadList.Count - 1 do begin
      sGuildName := Trim(LoadList.Strings[I]);
      if sGuildName <> '' then begin
        New(Guild);
        if nType = 1 then begin
          Guild.sGuildDir := g_sGuildBase1;
          Guild.sGuildName := sGuildName;
          Guild.sGuildNotice := g_sGuildNotice1;
          Guild.sGuildWar := g_sGuildWar1;
          Guild.sGuildAll := g_sGuildAll1;
          Guild.sGuildMember := g_sGuildMember1;
          Guild.sGuildMemberRank := g_sGuildMemberRank1;
          Guild.sGuildChief := g_sGuildChief1;
        end else begin
          Guild.sGuildDir := g_sGuildBase2;
          Guild.sGuildName := sGuildName;
          Guild.sGuildNotice := g_sGuildNotice2;
          Guild.sGuildWar := g_sGuildWar2;
          Guild.sGuildAll := g_sGuildAll2;
          Guild.sGuildMember := g_sGuildMember2;
          Guild.sGuildMemberRank := g_sGuildMemberRank2;
          Guild.sGuildChief := g_sGuildChief2;
        end;
        Guild.NoticeList := TStringList.Create;
        Guild.GuildWarList := TStringList.Create;
        Guild.GuildAllList := TStringList.Create;
        Guild.RankList := TList.Create;
        Guild.nBuildPoint := 0;
        Guild.nAurae := 0;
        Guild.nStability := 0;
        Guild.nFlourishing := 0;
        Guild.nChiefItemCount := 0;
        Guild.nMemberMaxLimit := 0;
        m_GuildBaseList.AddObject(sGuildName, TObject(Guild));
        LoadGuildConfig(Guild);
        LoadGuildFile(Guild);
      end;
      ProcessStatus();
    end;
    LoadList.Free;
  end;
  ProcessMessage('正在排序，请稍候...');
  m_GuildBaseList.SortString(0, m_GuildBaseList.Count - 1);
end;

procedure TGuildBase.UnLoadQuickList();
var
  I, II: Integer;
  Guild: pTGUild;
  GuildWar: pTWarGuild;
  GuildRank: pTGuildRank;
begin
  for I := 0 to m_GuildBaseList.Count - 1 do begin
    Guild := pTGUild(m_GuildBaseList.Objects[I]);
    for II := 0 to Guild.GuildWarList.Count - 1 do begin
      Dispose(pTWarGuild(Guild.GuildWarList.Objects[II]));
    end;
    Guild.GuildWarList.Free;
    Guild.NoticeList.Free;
    Guild.GuildAllList.Free;
    for II := 0 to Guild.RankList.Count - 1 do begin
      GuildRank := pTGuildRank(Guild.RankList.Items[II]);
      GuildRank.MemberList.Free;
      Dispose(GuildRank);
    end;
    Guild.RankList.Free;
    Dispose(Guild);
  end;
  m_GuildBaseList.Clear;
end;

procedure TGuildBase.SaveToFile(sSaveFileName: string);
  procedure SaveGuildConfig(sFileName: string; Guild: pTGUild);
  var
    Config: TIniFile;
  begin
    Config := TIniFile.Create(sFileName + Guild.sGuildName + '.ini');
    Config.WriteString('Guild', 'GuildName', Guild.sGuildName);
    Config.WriteInteger('Guild', 'BuildPoint', Guild.nBuildPoint);
    Config.WriteInteger('Guild', 'Aurae', Guild.nAurae);
    Config.WriteInteger('Guild', 'Stability', Guild.nStability);
    Config.WriteInteger('Guild', 'Flourishing', Guild.nFlourishing);
    Config.WriteInteger('Guild', 'ChiefItemCount', Guild.nChiefItemCount);
    Config.WriteInteger('Guild', 'MemberMaxLimit', Guild.nMemberMaxLimit);

    Config.Free;
  end;

  procedure SaveGuildFile(sFileName: string; Guild: pTGUild);
  var
    SaveList: TStringList;
    I, II: Integer;
    WarGuild: pTWarGuild;
    GuildRank: pTGuildRank;
    n14: Integer;
  begin
    SaveList := TStringList.Create;
    SaveList.Add(Guild.sGuildNotice);
    for I := 0 to Guild.NoticeList.Count - 1 do begin
      SaveList.Add('+' + Guild.NoticeList.Strings[I]);
    end;
    SaveList.Add(' ');
    SaveList.Add(Guild.sGuildWar);
    for I := 0 to Guild.GuildWarList.Count - 1 do begin
      WarGuild := pTWarGuild(Guild.GuildWarList.Objects[I]);
      n14 := WarGuild.dwWarTime - (GetTickCount - WarGuild.dwWarTick);
      if n14 <= 0 then Continue;
      SaveList.Add('+' + Guild.GuildWarList.Strings[I] + ' ' + IntToStr(n14));
    end;
    SaveList.Add(' ');
    SaveList.Add(Guild.sGuildAll);
    for I := 0 to Guild.GuildAllList.Count - 1 do begin
      SaveList.Add('+' + Guild.GuildAllList.Strings[I]);
    end;
    SaveList.Add(' ');
    SaveList.Add(Guild.sGuildMember);
    for I := 0 to Guild.RankList.Count - 1 do begin
      GuildRank := Guild.RankList.Items[I];
      SaveList.Add('#' + IntToStr(GuildRank.nRankNo) + ' ' + GuildRank.sRankName);
      for II := 0 to GuildRank.MemberList.Count - 1 do begin
        SaveList.Add('+' + GuildRank.MemberList.Strings[II]);
      end;
    end;
    try
      SaveList.SaveToFile(sFileName + Guild.sGuildName + '.txt');
    except
    end;
    SaveList.Free;
  end;
var
  sFileName: string;
  Guild: pTGUild;
  I: Integer;
begin
  m_nPercent := 0;
  if not DirectoryExists(g_sSaveDir + 'GuildBase') then begin
    CreateDir(g_sSaveDir + 'GuildBase');
  end;
  if not DirectoryExists(g_sSaveDir + 'GuildBase\Guilds') then begin
    CreateDir(g_sSaveDir + 'GuildBase\Guilds');
  end;
  g_nGuildBaseCount := m_GuildBaseList.Count;
  try
    m_GuildBaseList.SaveToFile(g_sSaveDir + 'GuildBase\GuildList.txt');
  except
  end;
  sFileName := g_sSaveDir + 'GuildBase\Guilds\';
  m_nCount := m_GuildBaseList.Count;
  for I := 0 to m_GuildBaseList.Count - 1 do begin
    if g_boClose then Break;
    Guild := pTGUild(m_GuildBaseList.Objects[I]);
    ProcessMessage('正在创建行会：' + Guild.sGuildName);
    SaveGuildConfig(sFileName, Guild);
    SaveGuildFile(sFileName, Guild);
    ProcessStatus();
  end;
end;

{ TFileHumDB }

constructor TFileHumDB.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_HumDBList := TQuickIDList.Create;
  m_HumCharNameList := TQuickList.Create;
  m_IDDBList := nil;
end;

destructor TFileHumDB.Destroy;
begin
  UnLoadQuickList();
  m_HumDBList.Free;
  m_HumCharNameList.Free;
  inherited;
end;

procedure TFileHumDB.UnLoadQuickList();
var
  I: Integer;
begin
  for I := 0 to m_HumDBList.Count - 1 do begin
    TList(m_HumDBList.Objects[I]).Free;
  end;
  m_HumDBList.Clear;

  for I := 0 to m_HumCharNameList.Count - 1 do begin
    Dispose(pTHumInfo(m_HumCharNameList.Objects[I]));
  end;
  m_HumCharNameList.Clear;
end;

procedure TFileHumDB.Delete(HumInfo: pTHumInfo);
begin

end;

procedure TFileHumDB.LoadQuickList();
var
  nIndex: Integer;
  DBHeader: TDBHeader;
  DBRecord: pTHumInfo;
begin
  m_nCount := 0;
  m_nPercent := 0;
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then begin
        m_nCount := DBHeader.nHumCount;
        for nIndex := 0 to DBHeader.nHumCount - 1 do begin
          if g_boClose then Break;
          ProcessStatus();

          New(DBRecord);
          FillChar(DBRecord^, SizeOf(THumInfo), #0);

          if FileRead(m_nFileHandle, DBRecord^, SizeOf(THumInfo)) <> SizeOf(THumInfo) then begin
            Dispose(DBRecord);
            Break;
          end;

          if (DBRecord.sAccount = '') or (DBRecord.Header.sName = '') or DBRecord.boDeleted then begin
            Dispose(DBRecord);
            Continue;
          end;

        {  if DBRecord.boDeleted then begin
            //if g_boClearHum2 then begin
              Dispose(DBRecord);
              Continue;
            //end;
          end;   }

         { if m_IDDBList <> nil then begin
            if m_IDDBList.GetIndexA(DBRecord.sAccount) < 0 then begin
              Dispose(DBRecord);
              Continue;
            end;
          end;  }

          m_HumCharNameList.AddObject(DBRecord.sChrName, TObject(DBRecord));
          m_HumDBList.AddRecord(DBRecord.sAccount, TObject(DBRecord));

          Application.ProcessMessages;
          if Application.Terminated then begin
            Close;
            Exit;
          end;
        end;
      end;
    end;
  finally
    Close();
  end;
  ProcessMessage('正在排序，请稍候...');
  m_HumDBList.SortString(0, m_HumDBList.Count - 1);
  m_HumCharNameList.SortString(0, m_HumCharNameList.Count - 1);
  //HumCharNameList.SaveToFile('Hum.txt');
end;

procedure TFileHumDB.Close;
begin
  FileClose(m_nFileHandle);
end;

function TFileHumDB.Open: Boolean;
begin
  if FileExists(m_sDBFileName) then begin
    m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then
      FileRead(m_nFileHandle, m_Header, SizeOf(TDBHeader));
  end else begin
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      m_Header.sDesc := sDBHeaderDesc;
      m_Header.nHumCount := 0;
      m_Header.n6C := 0;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
    end;
  end;
  if m_nFileHandle > 0 then Result := True
  else Result := False;
end;

function TFileHumDB.OpenEx: Boolean;
var
  DBHeader: TDBHeader;
begin
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := True;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then
      m_Header := DBHeader;
  end else Result := False;
end;

procedure TFileHumDB.SaveToFile(sFileName: string);
var
  sOldDBFileName: string;
begin
  sOldDBFileName := m_sDBFileName;
  try
    m_sDBFileName := sFileName;
    SaveToFile();
  finally
    m_sDBFileName := sOldDBFileName;
  end;
end;

procedure TFileHumDB.SaveToFile();
var
  DBRecord: pTHumInfo;
  List: TList;
  I, II: Integer;
begin
  m_nCount := 0;
  m_nPercent := 0;
  if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
  try
    if Open then begin
      m_nCount := m_HumCharNameList.Count;
      m_Header.nHumCount := m_HumCharNameList.Count;
      FileSeek(m_nFileHandle, 0, 0);
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
      for I := 0 to m_HumCharNameList.Count - 1 do begin
        if g_boClose then Break;
        DBRecord := pTHumInfo(m_HumCharNameList.Objects[I]);
        FileWrite(m_nFileHandle, DBRecord^, SizeOf(THumInfo));
        if Application.Terminated then begin
          Close;
          Exit;
        end;
        ProcessStatus();
      end;
    end;
  finally
    Close();
  end;
end;

{ TFileDB }

constructor TFileDB.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_IDDBList := nil;
  m_HumCharNameList := nil;
  m_MasterList := TQuickList.Create;
  m_DearList := TQuickList.Create;
  m_HeroList := TQuickList.Create;
  m_MirCharNameList := TQuickList.Create;
  m_HeroNameList := TQuickList.Create;
  m_MirDBList := TQuickIDList.Create;
end;

destructor TFileDB.Destroy;
begin
  UnLoadQuickList();
  m_MasterList.Free;
  m_DearList.Free;
  m_HeroList.Free;
  m_MirCharNameList.Free;
  m_MirDBList.Free;
  m_HeroNameList.Free;
  inherited
end;

procedure TFileDB.UnLoadQuickList();
var
  I: Integer;
begin
  for I := 0 to m_MirDBList.Count - 1 do begin
    TList(m_MirDBList.Objects[I]).Free;
  end;
  m_MirDBList.Clear;

  for I := 0 to m_MirCharNameList.Count - 1 do begin
    Dispose(pTHumDataInfo(m_MirCharNameList.Objects[I]));
  end;
  m_MirCharNameList.Clear;
end;

procedure TFileDB.LoadQuickList();
var
  nIndex, nIdx: Integer;
  DBHeader: TDBHeader;
  RecordHeader: TRecordHeader;
  HumanRCD: pTHumDataInfo;
  HumInfo: pTHumInfo;
begin
  m_nCount := 0;
  m_nPercent := 0;
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then begin
        m_nCount := DBHeader.nHumCount;
        for nIndex := 0 to DBHeader.nHumCount - 1 do begin
          if g_boClose then Break;
          ProcessStatus();

          if FileSeek(m_nFileHandle, nIndex * SizeOf(THumDataInfo) + SizeOf(TDBHeader), 0) = -1 then Break;

          New(HumanRCD);
          FillChar(HumanRCD^, SizeOf(THumDataInfo), #0);

          if FileRead(m_nFileHandle, HumanRCD^, SizeOf(THumDataInfo)) <> SizeOf(THumDataInfo) then begin
            Dispose(HumanRCD);
            Break;
          end;

          if (HumanRCD.Header.sName = '') or HumanRCD.Header.boDeleted then begin
            Dispose(HumanRCD);
            Continue;
          end;

         { if HumanRCD.Data.boIsHero then begin
            if (HumanRCD.Data.sAccount = '') and (m_HumCharNameList <> nil) then begin
              nIdx := m_HumCharNameList.GetIndex(HumanRCD.Data.sChrName);
              if nIdx >= 0 then begin
                HumInfo := pTHumInfo(m_HumCharNameList.Objects[nIdx]);
                HumanRCD.Data.sAccount := HumInfo.sAccount;
              end;
            end;
          end; }

          {if m_IDDBList <> nil then begin
            if m_IDDBList.GetIndexA(HumanRCD.Data.sAccount) < 0 then begin
              Dispose(HumanRCD);
              Continue;
            end;
          end;  }

        {  if m_HumCharNameList <> nil then begin
            if m_HumCharNameList.GetIndex(HumanRCD.Data.sChrName) < 0 then begin
              Dispose(HumanRCD);
              Continue;
            end;
          end; }

          m_MirCharNameList.AddObject(HumanRCD.Data.sChrName, TObject(HumanRCD));

          m_MirDBList.AddRecord(HumanRCD.Data.sAccount, TObject(HumanRCD));

          if HumanRCD.Data.sMasterName <> '' then begin
            m_MasterList.AddObject(HumanRCD.Data.sMasterName, TObject(HumanRCD));
          end;

          if HumanRCD.Data.sDearName <> '' then begin
            m_DearList.AddObject(HumanRCD.Data.sDearName, TObject(HumanRCD));
          end;

          if HumanRCD.Data.boIsHero then begin
            m_HeroList.AddObject(HumanRCD.Data.sChrName, TObject(HumanRCD));
          end;

          if (HumanRCD.Data.sHeroChrName <> '') {and (HumanRCD.Data.boHasHero)} then begin
            m_HeroNameList.AddObject(HumanRCD.Data.sHeroChrName, TObject(HumanRCD));
          end;

          Application.ProcessMessages;
          if Application.Terminated then begin
            Close;
            Exit;
          end;
        end;
      end;
    end;
  finally
    Close();
  end;
  ProcessMessage('正在排序，请稍候...');
  m_MirDBList.SortString(0, m_MirDBList.Count - 1);
  m_DearList.SortString(0, m_DearList.Count - 1);
  m_MasterList.SortString(0, m_MasterList.Count - 1);
  m_HeroList.SortString(0, m_HeroList.Count - 1);
  m_HeroNameList.SortString(0, m_HeroNameList.Count - 1);
  m_MirCharNameList.SortString(0, m_MirCharNameList.Count - 1);
  //MirCharNameList.SaveToFile('Mir.txt');
end;

function TFileDB.Open: Boolean;
begin
  if FileExists(m_sDBFileName) then begin
    m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then
      FileRead(m_nFileHandle, m_Header, SizeOf(TDBHeader));
  end else begin
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      m_Header.sDesc := sDBHeaderDesc;
      m_Header.nHumCount := 0;
      m_Header.n6C := 0;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
    end;
  end;
  if m_nFileHandle > 0 then Result := True
  else Result := False;
end;

procedure TFileDB.Close;
begin
  FileClose(m_nFileHandle);
end;

function TFileDB.OpenEx: Boolean;
var
  DBHeader: TDBHeader;
begin
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := True;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then
      m_Header := DBHeader;
  end else Result := False;
end;

procedure TFileDB.SaveToFile(sFileName: string);
var
  sOldDBFileName: string;
begin
  sOldDBFileName := m_sDBFileName;
  try
    m_sDBFileName := sFileName;
    SaveToFile();
  finally
    m_sDBFileName := sOldDBFileName;
  end;
end;

procedure TFileDB.SaveToFile();
var
  HumanRCD: pTHumDataInfo;
  I: Integer;
begin
  m_nPercent := 0;
  m_nCount := 0;
  if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
  try
    if Open then begin
      m_nCount := m_MirCharNameList.Count;
      m_Header.nHumCount := m_MirCharNameList.Count;
      FileSeek(m_nFileHandle, 0, 0);
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
      for I := 0 to m_MirCharNameList.Count - 1 do begin
        if g_boClose then Break;
        HumanRCD := pTHumDataInfo(m_MirCharNameList.Objects[I]);
        FileWrite(m_nFileHandle, HumanRCD^, SizeOf(THumDataInfo));
        if Application.Terminated then begin
          Close;
          Exit;
        end;
        ProcessStatus();
      end;
    end;
  finally
    Close();
  end;
end;

{ TSellOff }

constructor TSellOff.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_SellOffList := TQuickIDList.Create;
  m_HumCharNameList := nil;
end;

destructor TSellOff.Destroy;
begin
  UnLoadSellOffList();
  m_SellOffList.Free;
  inherited;
end;

procedure TSellOff.UnLoadSellOffList();
var
  I, II: Integer;
  ChrList: TList;
begin
  for I := 0 to m_SellOffList.Count - 1 do begin
    ChrList := TList(m_SellOffList.Objects[I]);
    for II := 0 to ChrList.Count - 1 do begin
      Dispose(pTSellOffInfo(ChrList.Items[II]));
    end;
    ChrList.Free;
  end;
  m_SellOffList.Clear;
end;

procedure TSellOff.LoadQuickList();
var
  nIndex: Integer;
  DBHeader: TItemCount;
  DBRecord: pTSellOffInfo;
begin
  m_nCount := 0;
  m_nPercent := 0;

  {if LoadList = nil then Exit;}
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        m_nCount := DBHeader;
        for nIndex := 0 to DBHeader - 1 do begin
          if g_boClose then Break;
          ProcessStatus();

          New(DBRecord);

          FillChar(DBRecord^, SizeOf(TSellOffInfo), #0);
          if FileRead(m_nFileHandle, DBRecord^, SizeOf(TSellOffInfo)) <> SizeOf(TSellOffInfo) then begin
            Dispose(DBRecord);
            Break;
          end;
         {
          if m_HumCharNameList <> nil then begin
            if m_HumCharNameList.GetIndex(DBRecord.sCharName) < 0 then begin
              Dispose(DBRecord);
              Continue;
            end;
          end; }

          if (DBRecord.sCharName <> '') and (DBRecord.UseItems.wIndex > 0) then begin
            m_SellOffList.AddRecord(DBRecord.sCharName, TObject(DBRecord));
          end else begin
            Dispose(DBRecord);
            Continue;
          end;

          Application.ProcessMessages;
          if Application.Terminated then begin
            Close;
            Exit;
          end;
        end;
      end;
    end;
  finally
    Close();
  end;
  ProcessMessage('正在排序，请稍候...');
  m_SellOffList.SortString(0, m_SellOffList.Count - 1);
end;

procedure TSellOff.Close;
begin
  FileClose(m_nFileHandle);
end;

function TSellOff.Open: Boolean;
begin
  if FileExists(m_sDBFileName) then begin
    m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then
      FileRead(m_nFileHandle, m_Header, SizeOf(TItemCount));
  end else begin
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      m_Header := 0;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
    end;
  end;
  if m_nFileHandle > 0 then Result := True
  else Result := False;
end;

function TSellOff.OpenEx: Boolean;
var
  DBHeader: TItemCount;
begin
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := True;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then
      m_Header := DBHeader;
  end else Result := False;
end;

procedure TSellOff.SaveToFile(sFileName: string);
var
  sOldDBFileName: string;
begin
  sOldDBFileName := m_sDBFileName;
  try
    m_sDBFileName := sFileName;
    SaveToFile();
  finally
    m_sDBFileName := sOldDBFileName;
  end;
end;

procedure TSellOff.SaveToFile();
var
  DBRecord: pTSellOffInfo;
  List: TList;
  I, II: Integer;
begin
  m_nCount := 0;
  m_nPercent := 0;
  if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
  try
    if Open then begin
      m_nCount := m_SellOffList.Count;
      m_Header := 0;
      for I := 0 to m_SellOffList.Count - 1 do begin
        List := TList(m_SellOffList.Objects[I]);
        Inc(m_Header, List.Count);
      end;
      FileSeek(m_nFileHandle, 0, 0);
      FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
      for I := 0 to m_SellOffList.Count - 1 do begin
        if g_boClose then Break;
        List := TList(m_SellOffList.Objects[I]);
        for II := 0 to List.Count - 1 do begin
          DBRecord := pTSellOffInfo(List.Items[II]);
          FileWrite(m_nFileHandle, DBRecord^, SizeOf(TSellOffInfo));
          if Application.Terminated then begin
            Close;
            Exit;
          end;
        end;
        ProcessStatus();
      end;
    end;
  finally
    Close();
  end;
end;

{ TStorage }

constructor TStorage.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_BigStorageList := TQuickIDList.Create;
  m_HumCharNameList := nil;
end;

destructor TStorage.Destroy;
begin
  UnLoadQuickList();
  m_BigStorageList.Free;
  inherited;
end;

procedure TStorage.UnLoadQuickList();
var
  I, II: Integer;
  ChrList: TList;
begin
  for I := 0 to m_BigStorageList.Count - 1 do begin
    ChrList := TList(m_BigStorageList.Objects[I]);
    for II := 0 to ChrList.Count - 1 do begin
      Dispose(pTBigStorage(ChrList.Items[II]));
    end;
    ChrList.Free;
  end;
  m_BigStorageList.Clear;
end;

procedure TStorage.LoadQuickList();
var
  nIndex: Integer;
  DBHeader: TItemCount;
  DBRecord: pTBigStorage;
begin
  m_nCount := 0;
  m_nPercent := 0;
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        m_nCount := DBHeader;
        for nIndex := 0 to DBHeader - 1 do begin
          if g_boClose then Break;

          ProcessStatus();

          New(DBRecord);

          FillChar(DBRecord^, SizeOf(TBigStorage), #0);
          if FileRead(m_nFileHandle, DBRecord^, SizeOf(TBigStorage)) <> SizeOf(TBigStorage) then begin
            Dispose(DBRecord);
            Break;
          end;

         { if m_HumCharNameList <> nil then begin
            if m_HumCharNameList.GetIndex(DBRecord.sCharName) < 0 then begin
              Dispose(DBRecord);
              Continue;
            end;
          end;}

          if DBRecord.boDelete then begin
            Dispose(DBRecord);
            Continue;
          end;

          if (DBRecord.sCharName <> '') and (DBRecord.UseItems.wIndex > 0) then begin
            m_BigStorageList.AddRecord(DBRecord.sCharName, TObject(DBRecord));
          end else begin
            Dispose(DBRecord);
            Continue;
          end;

          Application.ProcessMessages;
          if Application.Terminated then begin
            Close;
            Exit;
          end;
        end;
      end;
    end;
  finally
    Close();
  end;
  ProcessMessage('正在排序，请稍候...');
  m_BigStorageList.SortString(0, m_BigStorageList.Count - 1);
end;

procedure TStorage.Close;
begin
  FileClose(m_nFileHandle);
end;

function TStorage.Open: Boolean;
begin
  if FileExists(m_sDBFileName) then begin
    m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then
      FileRead(m_nFileHandle, m_Header, SizeOf(TItemCount));
  end else begin
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      m_Header := 0;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
    end;
  end;
  if m_nFileHandle > 0 then Result := True
  else Result := False;
end;

function TStorage.OpenEx: Boolean;
var
  DBHeader: TItemCount;
begin
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := True;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then
      m_Header := DBHeader;
  end else Result := False;
end;

procedure TStorage.SaveToFile(sFileName: string);
var
  sOldDBFileName: string;
begin
  sOldDBFileName := m_sDBFileName;
  try
    m_sDBFileName := sFileName;
    SaveToFile();
  finally
    m_sDBFileName := sOldDBFileName;
  end;
end;

procedure TStorage.SaveToFile();
var
  DBRecord: pTBigStorage;
  List: TList;
  I, II: Integer;
begin
  m_nCount := 0;
  m_nPercent := 0;
  if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
  try
    if Open then begin
      m_nCount := m_BigStorageList.Count;
      m_Header := 0;
      for I := 0 to m_BigStorageList.Count - 1 do begin
        List := TList(m_BigStorageList.Objects[I]);
        Inc(m_Header, List.Count);
      end;
      FileSeek(m_nFileHandle, 0, 0);
      FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
      for I := 0 to m_BigStorageList.Count - 1 do begin
        if g_boClose then Break;
        List := TList(m_BigStorageList.Objects[I]);
        for II := 0 to List.Count - 1 do begin
          DBRecord := pTBigStorage(List.Items[II]);
          FileWrite(m_nFileHandle, DBRecord^, SizeOf(TBigStorage));
          if Application.Terminated then begin
            Close;
            Exit;
          end;
        end;
        ProcessStatus();
      end;
    end;
  finally
    Close();
  end;
end;


{ TDuelItemDB }

constructor TDuelItemDB.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_ItemList := TQuickIDList.Create;
  m_DuelItemList := TQuickIDList.Create;
  m_HumCharNameList := nil;
end;

destructor TDuelItemDB.Destroy;
begin
  UnLoadQuickList();
  m_ItemList.Free;
  m_DuelItemList.Free;
  inherited;
end;

procedure TDuelItemDB.UnLoadQuickList();
var
  I, II: Integer;
  List: TList;
begin
  for I := 0 to m_ItemList.Count - 1 do begin
    List := TList(m_ItemList.Objects[I]);
    for II := 0 to List.Count - 1 do begin
      Dispose(List.Items[II]);
    end;
    List.Free;
  end;
  m_ItemList.Clear;
  m_DuelItemList.Clear;
end;

procedure TDuelItemDB.LoadQuickList();
var
  nIndex: Integer;
  DBHeader: TItemCount;
  DBRecord: pTDuelItem;
begin
  m_nCount := 0;
  m_nPercent := 0;
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        m_nCount := DBHeader;
        for nIndex := 0 to DBHeader - 1 do begin
          if g_boClose then Break;

          ProcessStatus();

          New(DBRecord);
          FillChar(DBRecord^, SizeOf(TDuelItem) - SizeOf(Integer), #0);
          if FileRead(m_nFileHandle, DBRecord^, SizeOf(TDuelItem) - SizeOf(Integer)) <> (SizeOf(TDuelItem) - SizeOf(Integer)) then begin
            Dispose(DBRecord);
            Break;
          end;

          if DBRecord.boDelete then begin
            Dispose(DBRecord);
            Continue;
          end;

          {if m_HumCharNameList <> nil then begin
            if m_HumCharNameList.GetIndex(DBRecord.sOwnerName) < 0 then begin
              Dispose(DBRecord);
              Continue;
            end;
            if m_HumCharNameList.GetIndex(DBRecord.sDuelName) < 0 then begin
              Dispose(DBRecord);
              Continue;
            end;
          end;}

          DBRecord.nIndex := nIndex;
          m_ItemList.AddRecord(DBRecord.sOwnerName, DBRecord);
          m_DuelItemList.AddRecord(DBRecord.sDuelName, DBRecord);
          Application.ProcessMessages;
          if Application.Terminated then begin
            Close;
            Exit;
          end;
        end;
      end;
    end;
  finally
    Close();
  end;
  ProcessMessage('正在排序，请稍候...');
  m_DuelItemList.SortString(0, m_DuelItemList.Count - 1);
  m_ItemList.SortString(0, m_ItemList.Count - 1);
end;

procedure TDuelItemDB.Close;
begin
  FileClose(m_nFileHandle);
end;

function TDuelItemDB.Open: Boolean;
begin
  if FileExists(m_sDBFileName) then begin
    m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then
      FileRead(m_nFileHandle, m_Header, SizeOf(TItemCount));
  end else begin
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      m_Header := 0;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
    end;
  end;
  if m_nFileHandle > 0 then Result := True
  else Result := False;
end;

function TDuelItemDB.OpenEx: Boolean;
var
  DBHeader: TItemCount;
begin
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := True;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then
      m_Header := DBHeader;
  end else Result := False;
end;

procedure TDuelItemDB.SaveToFile(sFileName: string);
var
  sOldDBFileName: string;
begin
  sOldDBFileName := m_sDBFileName;
  try
    m_sDBFileName := sFileName;
    SaveToFile();
  finally
    m_sDBFileName := sOldDBFileName;
  end;
end;

procedure TDuelItemDB.SaveToFile();
var
  DBRecord: pTDuelItem;
  List: TList;
  I, II: Integer;
begin
  m_nCount := 0;
  m_nPercent := 0;
  if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
  try
    if Open then begin
      m_nCount := m_ItemList.Count;
      m_Header := 0;
      for I := 0 to m_ItemList.Count - 1 do begin
        List := TList(m_ItemList.Objects[I]);
        Inc(m_Header, List.Count);
      end;
      FileSeek(m_nFileHandle, 0, 0);
      FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
      for I := 0 to m_ItemList.Count - 1 do begin
        if g_boClose then Break;
        List := TList(m_ItemList.Objects[I]);
        for II := 0 to List.Count - 1 do begin
          DBRecord := pTDuelItem(List.Items[II]);
          FileWrite(m_nFileHandle, DBRecord^, SizeOf(TDuelItem));
          if Application.Terminated then begin
            Close;
            Exit;
          end;
        end;
        ProcessStatus();
      end;
    end;
  finally
    Close();
  end;
end;

{ TDuelInfoDB }

constructor TDuelInfoDB.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_OwnerList := TQuickIDList.Create;
  m_DuelList := TQuickIDList.Create;
  m_HumCharNameList := nil;
end;

destructor TDuelInfoDB.Destroy;
begin
  UnLoadQuickList();
  m_OwnerList.Free;
  m_DuelList.Free;
  inherited;
end;

procedure TDuelInfoDB.UnLoadQuickList();
var
  I, II: Integer;
  List: TList;
begin
  for I := 0 to m_OwnerList.Count - 1 do begin
    List := TList(m_OwnerList.Objects[I]);
    for II := 0 to List.Count - 1 do begin
      Dispose(List.Items[II]);
    end;
    List.Free;
  end;
  m_OwnerList.Clear;
  m_DuelList.Clear;
end;

procedure TDuelInfoDB.LoadQuickList();
var
  nIndex: Integer;
  DBHeader: TItemCount;
  DBRecord: pTDuelInfo;
begin
  m_nCount := 0;
  m_nPercent := 0;
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        m_nCount := DBHeader;
        for nIndex := 0 to DBHeader - 1 do begin
          if g_boClose then Break;

          ProcessStatus();

          New(DBRecord);
          FillChar(DBRecord^, SizeOf(TDuelInfo) - SizeOf(Integer), #0);
          if FileRead(m_nFileHandle, DBRecord^, SizeOf(TDuelInfo) - SizeOf(Integer)) <> (SizeOf(TDuelInfo) - SizeOf(Integer)) then begin
            Dispose(DBRecord);
            Break;
          end;

          if DBRecord.boDelete then begin
            Dispose(DBRecord);
            Continue;
          end;

         { if m_HumCharNameList <> nil then begin
            if m_HumCharNameList.GetIndex(DBRecord.Owner.sCharName) < 0 then begin
              Dispose(DBRecord);
              Continue;
            end;
            if m_HumCharNameList.GetIndex(DBRecord.Duel.sCharName) < 0 then begin
              Dispose(DBRecord);
              Continue;
            end;
          end;  }

          DBRecord.nIndex := nIndex;
          m_OwnerList.AddRecord(DBRecord.Owner.sCharName, DBRecord);
          m_DuelList.AddRecord(DBRecord.Duel.sCharName, DBRecord);

          Application.ProcessMessages;
          if Application.Terminated then begin
            Close;
            Exit;
          end;
        end;
      end;
    end;
  finally
    Close();
  end;
  ProcessMessage('正在排序，请稍候...');
  m_OwnerList.SortString(0, m_OwnerList.Count - 1);
  m_DuelList.SortString(0, m_DuelList.Count - 1);
end;

procedure TDuelInfoDB.Close;
begin
  FileClose(m_nFileHandle);
end;

function TDuelInfoDB.Open: Boolean;
begin
  if FileExists(m_sDBFileName) then begin
    m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then
      FileRead(m_nFileHandle, m_Header, SizeOf(TItemCount));
  end else begin
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      m_Header := 0;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
    end;
  end;
  if m_nFileHandle > 0 then Result := True
  else Result := False;
end;

function TDuelInfoDB.OpenEx: Boolean;
var
  DBHeader: TItemCount;
begin
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := True;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then
      m_Header := DBHeader;
  end else Result := False;
end;

procedure TDuelInfoDB.SaveToFile(sFileName: string);
var
  sOldDBFileName: string;
begin
  sOldDBFileName := m_sDBFileName;
  try
    m_sDBFileName := sFileName;
    SaveToFile();
  finally
    m_sDBFileName := sOldDBFileName;
  end;
end;

procedure TDuelInfoDB.SaveToFile();
var
  DBRecord: pTDuelInfo;
  List: TList;
  I, II: Integer;
begin
  m_nCount := 0;
  m_nPercent := 0;
  if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
  try
    if Open then begin
      m_nCount := m_OwnerList.Count;
      m_Header := 0;
      for I := 0 to m_OwnerList.Count - 1 do begin
        List := TList(m_OwnerList.Objects[I]);
        Inc(m_Header, List.Count);
      end;
      FileSeek(m_nFileHandle, 0, 0);
      FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
      for I := 0 to m_OwnerList.Count - 1 do begin
        if g_boClose then Break;
        List := TList(m_OwnerList.Objects[I]);
        for II := 0 to List.Count - 1 do begin
          DBRecord := pTDuelInfo(List.Items[II]);
          FileWrite(m_nFileHandle, DBRecord^, SizeOf(TDuelInfo));
          if Application.Terminated then begin
            Close;
            Exit;
          end;
        end;
        ProcessStatus();
      end;
    end;
  finally
    Close();
  end;
end;

end.

