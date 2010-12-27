unit FrnEngn;

interface

uses
  Windows, Classes, SysUtils, Grobal2, SDK;
type
  TFrontEngine = class(TThread)
    m_UserCriticalSection: TRTLCriticalSection;
    m_HeroCriticalSection: TRTLCriticalSection;
    m_LoadRcdList: TList; //0x30
    m_SaveRcdList: TList; //0x34
    m_ChangeGoldList: TList; //0x38

    m_LoadHeroRcdList: TList; //0x30
    m_SaveHeroRcdList: TList; //0x34
  private
    m_LoadRcdTempList: TList;
    m_SaveRcdTempList: TList;

    m_LoadHeroRcdTempList: TList;
    m_SaveHeroRcdTempList: TList;
    procedure GetGameTime();
    procedure ProcessHumData();
    procedure ProcessHeroData();
    function LoadHumFromDB(LoadUser: pTLoadDBInfo; var boReTry: Boolean): Boolean;
    function LoadHeroFromDB(LoadUser: pTLoadDBInfo; var boReTry: Boolean): Boolean;
    function ChangeUserGoldInDB(GoldChangeInfo: pTGoldChangeInfo): Boolean;
    procedure Run();
    { Private declarations }
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    function SaveListCount(): Integer;
    function IsIdle(): Boolean;
    function IsFull(): Boolean;
    procedure DeleteHuman(nGateIndex, nSocket: Integer);
    function InSaveRcdList(sAccount, sChrName: string): Boolean;
    procedure AddChangeGoldList(ChangeType: TChangeType; sGameMasterName, sGetGoldUserName: string; nGold: Integer);
    procedure AddToLoadRcdList(sAccount, sChrName, sIPaddr: string; boFlag: Boolean; nSessionID: Integer; nPayMent, nPayMode, nSoftVersionDate, nSocket, nGSocketIdx, nGateIdx: Integer; boHeroVersion: Boolean);
    procedure AddToSaveRcdList(SaveRcd: pTSaveRcd);

    function InSaveHeroRcdList(sAccount, sChrName: string): Boolean;
    procedure AddToLoadHeroRcdList(PlayObject, NPC: TObject; DataType: THeroDataType; sMsg: string = '');
    procedure AddToSaveHeroRcdList(SaveRcd: pTSaveRcd);
  end;

implementation
uses
  M2Share, RunDB, ObjActor, ObjHero;
{ TFrontEngine }

constructor TFrontEngine.Create(CreateSuspended: Boolean);
begin
  inherited;
  InitializeCriticalSection(m_UserCriticalSection);
  InitializeCriticalSection(m_HeroCriticalSection);
  m_LoadRcdList := TList.Create;
  m_SaveRcdList := TList.Create;
  m_ChangeGoldList := TList.Create;
  m_LoadRcdTempList := TList.Create;
  m_SaveRcdTempList := TList.Create;

  m_LoadHeroRcdList := TList.Create;
  m_SaveHeroRcdList := TList.Create;
  m_LoadHeroRcdTempList := TList.Create;
  m_SaveHeroRcdTempList := TList.Create;
  //  FreeOnTerminate:=True;
  //AddToProcTable(@TFrontEngine.ProcessGameDate, 'TFrontEngine.ProcessGameDatea');
end;

destructor TFrontEngine.Destroy;
begin
  m_LoadRcdList.Free;
  m_SaveRcdList.Free;
  m_ChangeGoldList.Free;
  m_LoadRcdTempList.Free;
  m_SaveRcdTempList.Free;

  m_LoadHeroRcdList.Free;
  m_SaveHeroRcdList.Free;
  m_LoadHeroRcdTempList.Free;
  m_SaveHeroRcdTempList.Free;
  DeleteCriticalSection(m_UserCriticalSection);
  DeleteCriticalSection(m_HeroCriticalSection);
  inherited;
end;

procedure TFrontEngine.Execute;
resourcestring
  sExceptionMsg = '[Exception] TFrontEngine::Execute';
begin
  while not Terminated do begin
    try
      Run();
    except
      MainOutMessage(sExceptionMsg);
    end;
    Sleep(1);
  end;
end;

procedure TFrontEngine.GetGameTime;
var
  Hour, Min, Sec, MSec: Word;
begin
  DecodeTime(Time, Hour, Min, Sec, MSec);
  case Hour of
    5, 6, 7, 8, 9, 10, 16, 17, 18, 19, 20, 21, 22: g_nGameTime := 1;
    11, 23: g_nGameTime := 2;
    4, 15: g_nGameTime := 0;
    0, 1, 2, 3, 12, 13, 14: g_nGameTime := 3;
  end;
end;

function TFrontEngine.IsIdle: Boolean;
begin
  Result := False;
  EnterCriticalSection(m_UserCriticalSection);
  try
    if m_SaveRcdList.Count = 0 then Result := True;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

function TFrontEngine.SaveListCount: Integer;
begin
  Result := 0;
  EnterCriticalSection(m_UserCriticalSection);
  try
    Result := m_SaveRcdList.Count;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

procedure TFrontEngine.ProcessHeroData();
var
  I: Integer;
  II: Integer;
  TempList: TList;
  LoadDBInfo: pTLoadDBInfo;
  SaveRcd: pTSaveRcd;
  GoldChangeInfo: pTGoldChangeInfo;
  boReTryLoadDB: Boolean;
  nCode: Integer;
  boSaveRcd: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TFrontEngine::ProcessHeroData Code:%d';
begin
  try
    EnterCriticalSection(m_HeroCriticalSection);
    try
      for I := 0 to m_SaveHeroRcdList.Count - 1 do begin
        m_SaveHeroRcdTempList.Add(m_SaveHeroRcdList.Items[I]);
      end;
      nCode := 1;
      TempList := m_LoadHeroRcdTempList;
      nCode := 2;
      m_LoadHeroRcdTempList := m_LoadHeroRcdList;
      nCode := 3;
      m_LoadHeroRcdList := TempList;
      nCode := 4;
    finally
      LeaveCriticalSection(m_HeroCriticalSection);
    end;

    for I := 0 to m_SaveHeroRcdTempList.Count - 1 do begin
      SaveRcd := m_SaveHeroRcdTempList.Items[I];
      if (not DBSocketConnected) and (not DBSocketWorking){ or (g_nSaveRcdErrorCount >= 10)} then begin //DBS关闭 不保存
        if (SaveRcd.PlayObject <> nil) then begin
          THeroObject(SaveRcd.PlayObject).m_boRcdSaved := True;
        end;
        EnterCriticalSection(m_HeroCriticalSection);
        try
          for II := m_SaveHeroRcdList.Count - 1 downto 0 do begin
            if m_SaveHeroRcdList.Items[II] = SaveRcd then begin
              m_SaveHeroRcdList.Delete(II);
              nCode := 5;
              Dispose(SaveRcd);
              SaveRcd := nil;
              nCode := 6;
              Break;
            end;
          end;
        finally
          LeaveCriticalSection(m_HeroCriticalSection);
        end;
      end else begin
        boSaveRcd := False;
        if SaveRcd.nReTryCount = 0 then begin
          boSaveRcd := True;
        end else
          if (SaveRcd.nReTryCount < 50) and (GetTickCount - SaveRcd.dwSaveTick > 5000) then begin //保存错误等待5秒后在保存
          boSaveRcd := True;
        end else
          if SaveRcd.nReTryCount >= 50 then begin //失败50次后不在保存
          if (SaveRcd.PlayObject <> nil) then begin
            THeroObject(SaveRcd.PlayObject).m_boRcdSaved := True;
          end;
          EnterCriticalSection(m_HeroCriticalSection);
          try
            for II := m_SaveHeroRcdList.Count - 1 downto 0 do begin
              if m_SaveHeroRcdList.Items[II] = SaveRcd then begin
                m_SaveHeroRcdList.Delete(II);
                nCode := 7;
                Dispose(SaveRcd);
                SaveRcd := nil;
                nCode := 8;

                Break;
              end;
            end;
          finally
            LeaveCriticalSection(m_HeroCriticalSection);
          end;
        end;

        if boSaveRcd then begin
          if SaveHeroRcdToDB(SaveRcd.sAccount, SaveRcd.sChrName, SaveRcd.nSessionID, SaveRcd.HumanRcd) then begin
            if (SaveRcd.PlayObject <> nil) then begin
              THeroObject(SaveRcd.PlayObject).m_boRcdSaved := True;
            end;
            EnterCriticalSection(m_HeroCriticalSection);
            try
              for II := m_SaveHeroRcdList.Count - 1 downto 0 do begin
                if m_SaveHeroRcdList.Items[II] = SaveRcd then begin
                  m_SaveHeroRcdList.Delete(II);
                  nCode := 9;
                  Dispose(SaveRcd);
                  SaveRcd := nil;
                  nCode := 10;
                  Break;
                end;
              end;
            finally
              LeaveCriticalSection(m_HeroCriticalSection);
            end;
          end else begin //保存失败
            Inc(SaveRcd.nReTryCount);
            SaveRcd.dwSaveTick := GetTickCount;
            Break;
          end;
        end;
      end;
    end;
    m_SaveHeroRcdTempList.Clear;

    nCode := 11;
    for I := 0 to m_LoadHeroRcdTempList.Count - 1 do begin
      LoadDBInfo := m_LoadHeroRcdTempList.Items[I];
      if (not LoadHeroFromDB(LoadDBInfo, boReTryLoadDB)) then
        //RunSocket.CloseUser(LoadDBInfo.nGateIdx, LoadDBInfo.nSocket);
        if not boReTryLoadDB then begin
          Dispose(LoadDBInfo);
          LoadDBInfo := nil;
        end else begin //如果读取人物数据失败(数据还没有保存),则重新加入队列
          EnterCriticalSection(m_HeroCriticalSection);
          try
            m_LoadHeroRcdList.Add(LoadDBInfo);
          finally
            LeaveCriticalSection(m_HeroCriticalSection);
          end;
        end;
    end;
    m_LoadHeroRcdTempList.Clear;
  except
    MainOutMessage(Format(sExceptionMsg, [nCode]));
  end;
end;

procedure TFrontEngine.ProcessHumData;
var
  I: Integer;
  II: Integer;
  TempList: TList;
  ChangeGoldList: TList;
  LoadDBInfo: pTLoadDBInfo;
  SaveRcd: pTSaveRcd;
  GoldChangeInfo: pTGoldChangeInfo;
  boReTryLoadDB: Boolean;
  nCode: Integer;
  boSaveRcd: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TFrontEngine::ProcessHumData Code:%d';
begin
  ChangeGoldList := nil;
  try
    EnterCriticalSection(m_UserCriticalSection);
    try
      for I := 0 to m_SaveRcdList.Count - 1 do begin
        m_SaveRcdTempList.Add(m_SaveRcdList.Items[I]);
      end;
      nCode := 1;
      TempList := m_LoadRcdTempList;
      nCode := 2;
      m_LoadRcdTempList := m_LoadRcdList;
      nCode := 3;
      m_LoadRcdList := TempList;
      nCode := 4;
      if m_ChangeGoldList.Count > 0 then begin
        ChangeGoldList := TList.Create;
        for I := 0 to m_ChangeGoldList.Count - 1 do begin
          ChangeGoldList.Add(m_ChangeGoldList.Items[I]);
        end;
      end;
      m_ChangeGoldList.Clear;
    finally
      LeaveCriticalSection(m_UserCriticalSection);
    end;

    for I := 0 to m_SaveRcdTempList.Count - 1 do begin
      SaveRcd := m_SaveRcdTempList.Items[I];
      if (not DBSocketConnected) and (not DBSocketWorking){ or (g_nSaveRcdErrorCount >= 10)} then begin //DBS关闭 不保存
        if (SaveRcd.PlayObject <> nil) then begin
          TPlayObject(SaveRcd.PlayObject).m_boRcdSaved := True;
        end;
        EnterCriticalSection(m_UserCriticalSection);
        try
          for II := m_SaveRcdList.Count - 1 downto 0 do begin
            if m_SaveRcdList.Items[II] = SaveRcd then begin
              m_SaveRcdList.Delete(II);
              nCode := 5;
              Dispose(SaveRcd);
              SaveRcd := nil;
              nCode := 6;
              Break;
            end;
          end;
        finally
          LeaveCriticalSection(m_UserCriticalSection);
        end;
      end else begin
        boSaveRcd := False;
        if SaveRcd.nReTryCount = 0 then begin
          boSaveRcd := True;
        end else
          if (SaveRcd.nReTryCount < 50) and (GetTickCount - SaveRcd.dwSaveTick > 5000) then begin //保存错误等待5秒后在保存
          boSaveRcd := True;
        end else
          if SaveRcd.nReTryCount >= 50 then begin //失败50次后不在保存
          if (SaveRcd.PlayObject <> nil) then begin
            TPlayObject(SaveRcd.PlayObject).m_boRcdSaved := True;
          end;
          EnterCriticalSection(m_UserCriticalSection);
          try
            for II := m_SaveRcdList.Count - 1 downto 0 do begin
              if m_SaveRcdList.Items[II] = SaveRcd then begin
                m_SaveRcdList.Delete(II);
                nCode := 7;
                Dispose(SaveRcd);
                SaveRcd := nil;
                nCode := 8;

                Break;
              end;
            end;
          finally
            LeaveCriticalSection(m_UserCriticalSection);
          end;
        end;

        if boSaveRcd then begin
          if SaveHumRcdToDB(SaveRcd.sAccount, SaveRcd.sChrName, SaveRcd.nSessionID, SaveRcd.HumanRcd) then begin
            if (SaveRcd.PlayObject <> nil) then begin
              TPlayObject(SaveRcd.PlayObject).m_boRcdSaved := True;
            end;
            EnterCriticalSection(m_UserCriticalSection);
            try
              for II := m_SaveRcdList.Count - 1 downto 0 do begin
                if m_SaveRcdList.Items[II] = SaveRcd then begin
                  m_SaveRcdList.Delete(II);
                  nCode := 9;
                  Dispose(SaveRcd);
                  SaveRcd := nil;
                  nCode := 10;
                  Break;
                end;
              end;
            finally
              LeaveCriticalSection(m_UserCriticalSection);
            end;
          end else begin //保存失败
            Inc(SaveRcd.nReTryCount);
            SaveRcd.dwSaveTick := GetTickCount;
            Break;
          end;
        end;
      end;
    end;
    m_SaveRcdTempList.Clear;
    nCode := 11;
    for I := 0 to m_LoadRcdTempList.Count - 1 do begin
      LoadDBInfo := m_LoadRcdTempList.Items[I];
      if (not LoadHumFromDB(LoadDBInfo, boReTryLoadDB)) then
        RunSocket.CloseUser(LoadDBInfo.nGateIdx, LoadDBInfo.nSocket);
      if not boReTryLoadDB then begin
        Dispose(LoadDBInfo);
        LoadDBInfo := nil;
      end else begin //如果读取人物数据失败(数据还没有保存),则重新加入队列
        EnterCriticalSection(m_UserCriticalSection);
        try
          m_LoadRcdList.Add(LoadDBInfo);
        finally
          LeaveCriticalSection(m_UserCriticalSection);
        end;
      end;
    end;
    m_LoadRcdTempList.Clear;
    nCode := 12;
    if ChangeGoldList <> nil then begin
      for I := 0 to ChangeGoldList.Count - 1 do begin
        GoldChangeInfo := ChangeGoldList.Items[I];
        ChangeUserGoldInDB(GoldChangeInfo);
        nCode := 13;
        Dispose(GoldChangeInfo);
        nCode := 14;
      end;
      nCode := 15;
      ChangeGoldList.Free;
      nCode := 16;
    end;
  except
    MainOutMessage(Format(sExceptionMsg, [nCode]));
  end;
end;

function TFrontEngine.IsFull: Boolean;
begin
  Result := False;
  EnterCriticalSection(m_UserCriticalSection);
  try
    if m_SaveRcdList.Count >= 1000 then begin
      Result := True;
    end;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

procedure TFrontEngine.AddToLoadRcdList(sAccount, sChrName, sIPaddr: string;
  boFlag: Boolean; nSessionID, nPayMent, nPayMode, nSoftVersionDate, nSocket, nGSocketIdx, nGateIdx: Integer;
  boHeroVersion: Boolean);
var
  LoadRcdInfo: pTLoadDBInfo;
begin
  New(LoadRcdInfo);
  LoadRcdInfo.sAccount := sAccount;
  LoadRcdInfo.sCharName := sChrName;
  LoadRcdInfo.sIPaddr := sIPaddr;
  //LoadRcdInfo.boClinetFlag     := boFlag;
  LoadRcdInfo.nSessionID := nSessionID;
  LoadRcdInfo.nSoftVersionDate := nSoftVersionDate;
  LoadRcdInfo.nPayMent := nPayMent;
  LoadRcdInfo.nPayMode := nPayMode;
  LoadRcdInfo.nSocket := nSocket;
  LoadRcdInfo.nGSocketIdx := nGSocketIdx;
  LoadRcdInfo.nGateIdx := nGateIdx;
  LoadRcdInfo.dwNewUserTick := GetTickCount();
  LoadRcdInfo.PlayObject := nil;
  LoadRcdInfo.nReLoadCount := 0;
  LoadRcdInfo.boHeroVersion := boHeroVersion;
  EnterCriticalSection(m_UserCriticalSection);
  try
    m_LoadRcdList.Add(LoadRcdInfo);
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

procedure TFrontEngine.AddToLoadHeroRcdList(PlayObject, NPC: TObject; DataType: THeroDataType; sMsg: string);
var
  LoadRcdInfo: pTLoadDBInfo;
begin
  New(LoadRcdInfo);
  TPlayObject(PlayObject).m_boWaitHeroDate := True;
  LoadRcdInfo.sAccount := TPlayObject(PlayObject).m_sUserID;
  if DataType = l_Create then begin
    LoadRcdInfo.sCharName := TPlayObject(PlayObject).m_sTempHeroName;
  end else begin
    LoadRcdInfo.sCharName := TPlayObject(PlayObject).m_sHeroCharName;
  end;
  LoadRcdInfo.sIPaddr := TPlayObject(PlayObject).m_sIPaddr;
  LoadRcdInfo.nSessionID := TPlayObject(PlayObject).m_nSessionID;
  LoadRcdInfo.nSoftVersionDate := TPlayObject(PlayObject).m_nSoftVersionDate;
  LoadRcdInfo.nPayMent := TPlayObject(PlayObject).m_nPayMent;
  LoadRcdInfo.nPayMode := TPlayObject(PlayObject).m_nPayMode;
  LoadRcdInfo.nSocket := TPlayObject(PlayObject).m_nSocket;
  LoadRcdInfo.nGSocketIdx := TPlayObject(PlayObject).m_nGSocketIdx;
  LoadRcdInfo.nGateIdx := TPlayObject(PlayObject).m_nGateIdx;
  LoadRcdInfo.dwNewUserTick := GetTickCount();
  LoadRcdInfo.PlayObject := PlayObject;
  LoadRcdInfo.nReLoadCount := 0;
  LoadRcdInfo.HeroData := DataType;
  LoadRcdInfo.sMsg := sMsg;
  LoadRcdInfo.NPC := NPC;
  //MainOutMessage('LoadRcdInfo.sCharName:'+LoadRcdInfo.sCharName+' sMsg:'+sMsg);
  EnterCriticalSection(m_HeroCriticalSection);
  try
    m_LoadHeroRcdList.Add(LoadRcdInfo);
  finally
    LeaveCriticalSection(m_HeroCriticalSection);
  end;
end;

function TFrontEngine.LoadHeroFromDB(LoadUser: pTLoadDBInfo; var boReTry: Boolean): Boolean;
var
  HumanRcd: THumDataInfo;
  UserOpenInfo: pTUserOpenInfo;
  PlayObject: TPlayObject;
  boLoad: Boolean;
  nResult: Integer;
begin
  Result := False;
  boReTry := False;
  boLoad := False;
  nResult := 0;
  if InSaveHeroRcdList(LoadUser.sAccount, LoadUser.sCharName) then begin
    boReTry := True; //反回TRUE,则重新加入队列
    Result := True;
    Exit;
  end;

  case LoadUser.HeroData of
    l_Create: boLoad := CreateHeroRcd(LoadUser.sAccount, TPlayObject(LoadUser.PlayObject).m_sCharName, LoadUser.sCharName, LoadUser.sMsg, LoadUser.nSessionID, nResult);
    l_Delete: boLoad := DeleteHeroRcd(LoadUser.sAccount, LoadUser.sCharName, LoadUser.nSessionID, nResult);
    l_Load: boLoad := LoadHeroRcdFromDB(LoadUser.sAccount, LoadUser.sCharName, LoadUser.sIPaddr, HumanRcd, LoadUser.nSessionID);
  end;
  New(UserOpenInfo);
  UserOpenInfo.sAccount := LoadUser.sAccount;
  UserOpenInfo.sChrName := LoadUser.sCharName;
  UserOpenInfo.LoadUser := LoadUser^;
  UserOpenInfo.HumanRcd := HumanRcd;
  UserOpenInfo.nResult := nResult;
  UserOpenInfo.NPC := LoadUser.NPC;
  if UserOpenInfo.NPC = nil then
    UserOpenInfo.NPC := g_FunctionNPC;

  if LoadUser.HeroData = l_Load then begin
    if HumanRcd.Data.sChrName = '' then begin
      UserOpenInfo.nResult := 0;
    end else begin
      UserOpenInfo.nResult := 1;
    end;
  end;
  UserEngine.AddHeroOpenInfo(UserOpenInfo);
  Result := True;
end;

function TFrontEngine.LoadHumFromDB(LoadUser: pTLoadDBInfo; var boReTry: Boolean): Boolean; //004B4B10
var
  HumanRcd: THumDataInfo;
  UserOpenInfo: pTUserOpenInfo;
  PlayObject: TPlayObject;
resourcestring
  sReLoginFailMsg = '[非法登录] 全局会话验证失败(%s/%s/%s/%d)';
begin
  Result := False;
  boReTry := False;
  if InSaveRcdList(LoadUser.sAccount, LoadUser.sCharName) then begin
    boReTry := True; //反回TRUE,则重新加入队列
    Exit;
  end;
  if (UserEngine.GetPlayObjectEx(LoadUser.sAccount, LoadUser.sCharName) <> nil) then begin
    UserEngine.KickPlayObjectEx(LoadUser.sAccount, LoadUser.sCharName);
    boReTry := True; //反回TRUE,则重新加入队列
    Exit;
  end;
  if not LoadHumRcdFromDB(LoadUser.sAccount, LoadUser.sCharName, LoadUser.sIPaddr, HumanRcd, LoadUser.nSessionID) then begin
    RunSocket.SendOutConnectMsg(LoadUser.nGateIdx, LoadUser.nSocket, LoadUser.nGSocketIdx);
  end else begin
    New(UserOpenInfo);
    UserOpenInfo.sAccount := LoadUser.sAccount;
    UserOpenInfo.sChrName := LoadUser.sCharName;
    UserOpenInfo.LoadUser := LoadUser^;
    UserOpenInfo.HumanRcd := HumanRcd;
    UserEngine.AddUserOpenInfo(UserOpenInfo);
    Result := True;
  end;
end;

function TFrontEngine.InSaveRcdList(sAccount, sChrName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  EnterCriticalSection(m_UserCriticalSection);
  try
    for I := 0 to m_SaveRcdList.Count - 1 do begin
      if (pTSaveRcd(m_SaveRcdList.Items[I]).sAccount = sAccount) and
        (pTSaveRcd(m_SaveRcdList.Items[I]).sChrName = sChrName) then begin
        Result := True;
        Break;
      end;
    end;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

function TFrontEngine.InSaveHeroRcdList(sAccount, sChrName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  EnterCriticalSection(m_HeroCriticalSection);
  try
    for I := 0 to m_SaveHeroRcdList.Count - 1 do begin
      if (pTSaveRcd(m_SaveHeroRcdList.Items[I]).sAccount = sAccount) and
        (pTSaveRcd(m_SaveHeroRcdList.Items[I]).sChrName = sChrName) then begin
        Result := True;
        Break;
      end;
    end;
  finally
    LeaveCriticalSection(m_HeroCriticalSection);
  end;
end;

procedure TFrontEngine.AddChangeGoldList(ChangeType: TChangeType; sGameMasterName, sGetGoldUserName: string;
  nGold: Integer);
var
  GoldInfo: pTGoldChangeInfo;
begin
  New(GoldInfo);
  GoldInfo.sGameMasterName := sGameMasterName;
  GoldInfo.sGetGoldUser := sGetGoldUserName;
  GoldInfo.nGold := nGold;
  GoldInfo.ChangeType := ChangeType;
  m_ChangeGoldList.Add(GoldInfo);
end;

procedure TFrontEngine.AddToSaveRcdList(SaveRcd: pTSaveRcd); //004B49EC
begin
  EnterCriticalSection(m_UserCriticalSection);
  try
    m_SaveRcdList.Add(SaveRcd);
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

procedure TFrontEngine.AddToSaveHeroRcdList(SaveRcd: pTSaveRcd); //004B49EC
begin
  EnterCriticalSection(m_HeroCriticalSection);
  try
    m_SaveHeroRcdList.Add(SaveRcd);
  finally
    LeaveCriticalSection(m_HeroCriticalSection);
  end;
end;

procedure TFrontEngine.DeleteHuman(nGateIndex, nSocket: Integer); //004B45EC
var
  I: Integer;
  LoadRcdInfo: pTLoadDBInfo;
begin
  EnterCriticalSection(m_UserCriticalSection);
  try
    for I := m_LoadRcdList.Count - 1 downto 0 do begin
      if m_LoadRcdList.Count <= 0 then Break;
      LoadRcdInfo := m_LoadRcdList.Items[I];
      if LoadRcdInfo = nil then Continue;
      if (LoadRcdInfo.nGateIdx = nGateIndex) and (LoadRcdInfo.nSocket = nSocket) then begin
        Dispose(LoadRcdInfo);
        m_LoadRcdList.Delete(I);
        Break;
      end;
    end;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

function TFrontEngine.ChangeUserGoldInDB(GoldChangeInfo: pTGoldChangeInfo): Boolean;
var
  HumanRcd: THumDataInfo;
begin
  Result := False;
  if LoadHumRcdFromDB('1', GoldChangeInfo.sGetGoldUser, '1', HumanRcd, 1) then begin
    case GoldChangeInfo.ChangeType of
      t_Gold: begin
          if ((HumanRcd.Data.nGold + GoldChangeInfo.nGold) > 0) and ((HumanRcd.Data.nGold + GoldChangeInfo.nGold) < 2000000000) then begin
            Inc(HumanRcd.Data.nGold, GoldChangeInfo.nGold);
            if SaveHumRcdToDB('1', GoldChangeInfo.sGetGoldUser, 1, HumanRcd) then begin
              UserEngine.sub_4AE514(GoldChangeInfo);
              Result := True;
            end;
          end;
        end;
      t_GameGold: begin
          if ((HumanRcd.Data.nGameGold + GoldChangeInfo.nGold) > 0) then begin
            Inc(HumanRcd.Data.nGameGold, GoldChangeInfo.nGold);
            if SaveHumRcdToDB('1', GoldChangeInfo.sGetGoldUser, 1, HumanRcd) then begin
              UserEngine.sub_4AE514(GoldChangeInfo);
              Result := True;
            end;
          end;
        end;
      t_GamePoint: begin
          if ((HumanRcd.Data.nGamePoint + GoldChangeInfo.nGold) > 0) then begin
            Inc(HumanRcd.Data.nGamePoint, GoldChangeInfo.nGold);
            if SaveHumRcdToDB('1', GoldChangeInfo.sGetGoldUser, 1, HumanRcd) then begin
              UserEngine.sub_4AE514(GoldChangeInfo);
              Result := True;
            end;
          end;
        end;
      t_GameDiamond: begin
          {if ((HumanRcd.Data.nGameDiamond + GoldChangeInfo.nGold) > 0) then begin
            Inc(HumanRcd.Data.nGameDiamond, GoldChangeInfo.nGold);
            if SaveHumRcdToDB('1', GoldChangeInfo.sGetGoldUser, 1, HumanRcd) then begin
              UserEngine.sub_4AE514(GoldChangeInfo);
              Result := True;
            end;
          end;}
        end;
    end;
  end;
end;

procedure TFrontEngine.Run;
begin
  ProcessHumData();
  ProcessHeroData();
  GetGameTime();
end;

end.

