unit ServerClient;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, WinSock,
  JSocket, Grobal2, Common, IDSocCli;

type
  TServerClient = class{$IF DBSUSETHREAD = 1}(TServerClientThread){$ELSE}(TServerClientWinSocket){$IFEND}
    m_dwKeepAliveTick: LongWord;
    m_sReceiveText: string;
    m_Module: Pointer;
    m_dwCheckServerTimeMin: LongWord;
    m_dwCheckServerTimeMax: LongWord;
    m_dwCheckRecviceTick: LongWord;
  private
    m_sQueryID: string;
    m_DefMsg: TDefaultMessage;

    procedure ProcessServerMsg(sMsg: string; nLen: Integer);
    procedure SendSocket(sMsg: string);
    procedure SaveMagicList(nMagicCount: Integer; sMsg: string);
    procedure SaveStdItemList(nItemCount: Integer; sMsg: string);

    procedure LoadHumanRcd(sMsg: string);
    procedure SaveHumanRcd(nRecog: Integer; sMsg: string);

    procedure LoadHeroRcd(sMsg: string);
    procedure SaveHeroRcd(nRecog: Integer; sMsg: string);

    procedure NewHeroRcd(sMsg: string);
    procedure DeleteHeroRcd(sMsg: string);

    procedure SaveHumanRcdEx(sMsg: string; nRecog: Integer);

    procedure LoadRanking(sMsg: string; Msg: pTDefaultMessage);
  public
{$IF DBSUSETHREAD = 1}
    constructor Create(ASocket: TServerClientWinSocket);
    procedure ClientExecute; override;
    procedure Close;
{$ELSE}
    constructor Create(Socket: TSocket; ServerWinSocket: TServerWinSocket);
{$IFEND}
    destructor Destroy; override;
    procedure ProcessServerPacket(Buffer: PChar; BufLen: Integer);
    procedure SendKeepAlivePacket();
  end;
implementation
uses EncryptUnit, HUtil32, MudUtil, DBShare;

{$IF DBSUSETHREAD = 1}

constructor TServerClient.Create(ASocket: TServerClientWinSocket);
begin
  m_dwKeepAliveTick := GetTickCount;
  m_sReceiveText := '';
  m_sQueryID := '';
  m_Module := nil;
  m_dwCheckServerTimeMin := GetTickCount;
  m_dwCheckServerTimeMax := 0; //GetTickCount;
  m_dwCheckRecviceTick := GetTickCount;
  inherited Create(False, ASocket);
end;

{$ELSE}

constructor TServerClient.Create(Socket: TSocket; ServerWinSocket: TServerWinSocket);
begin
  inherited Create(Socket, ServerWinSocket);
  m_dwKeepAliveTick := GetTickCount;
  m_sReceiveText := '';
  m_sQueryID := '';
  m_Module := nil;
  m_dwCheckServerTimeMin := GetTickCount;
  m_dwCheckServerTimeMax := 0; //GetTickCount;
  m_dwCheckRecviceTick := GetTickCount;
end;
{$IFEND}

destructor TServerClient.Destroy;
begin
  inherited Destroy;
end;

{$IF DBSUSETHREAD = 1}

procedure TServerClient.Close;
begin
  m_sReceiveText := '';
  m_sQueryID := '';
  if (ClientSocket <> nil) and ClientSocket.Connected then
    ClientSocket.Close;
  Terminate;
end;

procedure TServerClient.ClientExecute;
var
  nMsgLen: Integer;
  RecvBuffer: array[0..DATA_BUFSIZE - 1] of Char;
  SocketStream: TWinSocketStream;
begin
  while (not Terminated) and ClientSocket.Connected and (not Application.Terminated) do begin
    SocketStream := TWinSocketStream.Create(ClientSocket, 20000);
    try
      if SocketStream.WaitForData(20000) then begin
        repeat
          if (not ClientSocket.Connected) or Terminated or Application.Terminated then break;
          try
            nMsgLen := SocketStream.Read(RecvBuffer, SizeOf(RecvBuffer));
            if nMsgLen > 0 then begin
              ProcessServerPacket(@RecvBuffer, nMsgLen)
            end else begin
              Close;
              break;
            end;
          except
            Close;
            break;
          end;
        until (not SocketStream.WaitForData(20000));
      end;
    finally
      SocketStream.Free;
    end;
  end;
end;
{$IFEND}

procedure TServerClient.SendKeepAlivePacket();
begin
  m_dwKeepAliveTick := GetTickCount;
end;

procedure TServerClient.ProcessServerPacket(Buffer: PChar; BufLen: Integer);
var
  bo25: Boolean;
  nC: Integer;
  sReceiveText: string;
  sC, s1C, s20, s24: string;
  n14, n18: Integer;
  wE, w10: Word;
  DefMsg: TDefaultMessage;
begin
  try
    m_sQueryID := '';
    m_dwKeepAliveTick := GetTickCount;
    SetLength(sReceiveText, BufLen);
    Move(Buffer^, sReceiveText[1], BufLen);
    m_sReceiveText := m_sReceiveText + sReceiveText;

  //MainOutMessage('m_sReceiveText:'+m_sReceiveText);
    nC := 0;
    bo25 := False;
    while (True) do begin
      if Pos('!', m_sReceiveText) <= 0 then Break;
      m_sReceiveText := ArrestStringEx(m_sReceiveText, '#', '!', s20);
      if s20 <> '' then begin
        if Length(s20) > 2 then begin
          s20 := GetValidStr3(s20, s24, ['/']);
          n14 := Length(s20);
          if (n14 >= DEFBLOCKSIZE) and (s24 <> '') then begin
            m_sQueryID := s24;
            wE := Str_ToInt(s24, 0) xor 170;
            w10 := n14;
            n18 := MakeLong(wE, w10);
            sC := EncodeBuffer(@n18, SizeOf(Integer));
            if CompareBackLStr(s20, sC, Length(sC)) then begin
              ProcessServerMsg(s20, n14);
              bo25 := True;
              m_sReceiveText := '';
              Break;
            end else begin
              m_DefMsg := MakeDefaultMsg(DBR_FAIL, 0, 0, 0, 0);
              SendSocket(EncodeMessage(m_DefMsg));
              m_sReceiveText := '';
              Break;
            end;
          end;
        end else begin
          m_sReceiveText := '';
          Break;
        end;
      end else begin //防止DBS溢出攻击
        if nC >= 1 then begin
          m_sReceiveText := '';
          Break;
        end;
        Inc(nC);
      end;
    end;
    m_dwCheckServerTimeMin := GetTickCount - m_dwCheckRecviceTick;
    if m_dwCheckServerTimeMin > m_dwCheckServerTimeMax then m_dwCheckServerTimeMax := m_dwCheckServerTimeMin;
    m_dwCheckRecviceTick := GetTickCount();
    if m_Module <> nil then
      pTModuleInfo(m_Module).Buffer := Format('%d/%d', [m_dwCheckServerTimeMin, m_dwCheckServerTimeMax]);
  except
    MainOutMessage('[Exception] TDBSERVER::ProcessServerPacket');
  end;
end;

procedure TServerClient.SendSocket(sMsg: string);
var
  n10: Integer;
  s18: string;
begin
{$IF DBSUSETHREAD = 1}
  //Inc(n4ADBFC);
  if ClientSocket.Connected then begin
   { if not g_boStartService then begin
      m_DefMsg := MakeDefaultMsg(DBR_CLOSESOCKET, 0, 0, 0, 0);
      sMsg := EncodeMessage(m_DefMsg);
    end; }
    n10 := MakeLong(Str_ToInt(m_sQueryID, 0) xor 170, Length(sMsg) + 6);
    s18 := EncodeBuffer(@n10, SizeOf(Integer));
    try
      ClientSocket.SendText('#' + m_sQueryID + '/' + sMsg + s18 + '!');
    except
      Close;
    end;
  end;
{$ELSE}
  //Inc(n4ADBFC);
  //if Connected then begin
   { if not g_boStartService then begin
      m_DefMsg := MakeDefaultMsg(DBR_CLOSESOCKET, 0, 0, 0, 0);
      sMsg := EncodeMessage(m_DefMsg);
    end; }
  n10 := MakeLong(Str_ToInt(m_sQueryID, 0) xor 170, Length(sMsg) + 6);
  s18 := EncodeBuffer(@n10, SizeOf(Integer));
    //try
  SendText('#' + m_sQueryID + '/' + sMsg + s18 + '!');
    //except
     // Close;
    //end;
  //end;
{$IFEND}
end;

procedure TServerClient.ProcessServerMsg(sMsg: string; nLen: Integer);
var
  sDefMsg, sData: string;
  DefMsg: TDefaultMessage;
begin
  if nLen = DEFBLOCKSIZE then begin
    sDefMsg := sMsg;
    sData := '';
  end else begin
    sDefMsg := Copy(sMsg, 1, DEFBLOCKSIZE);
    sData := Copy(sMsg, DEFBLOCKSIZE + 1, Length(sMsg) - DEFBLOCKSIZE - 6);
  end;
  DefMsg := DecodeMessage(sDefMsg);
  g_nWorkStatus := DefMsg.Ident;
  //try
  case DefMsg.Ident of
    DB_LOADHUMANRCD: begin
        LoadHumanRcd(sData);
      end;
    DB_SAVEHUMANRCD: begin
        SaveHumanRcd(DefMsg.Recog, sData);
      end;
    {DB_SAVEHUMANRCDEX: begin
        SaveHumanRcdEx(sData, DefMsg.Recog, Socket);
      end; }
    DB_LOADHERORCD: begin //读取英雄数据
        LoadHeroRcd(sData);
      end;
    DB_NEWHERORCD: begin //新建英雄
        NewHeroRcd(sData);
      end;
    DB_DELHERORCD: begin //删除英雄
        DeleteHeroRcd(sData);
      end;
    DB_SAVEHERORCD: begin //保存英雄数据
        SaveHeroRcd(DefMsg.Recog, sData);
      end;
    DB_LOADRANKING: begin //排行榜
        LoadRanking(sData, @DefMsg);
      end;
    DB_SAVEMAGICLIST: begin
        SaveMagicList(DefMsg.Recog, sData);
      end;
    DB_SAVESTDITEMLIST: begin
        SaveStdItemList(DefMsg.Recog, sData);
      end;
    DB_CLOSESOCKET: begin
        //Close;
      end;
    DB_SENDKEEPALIVE: ;
  else begin
      m_DefMsg := MakeDefaultMsg(DBR_FAIL, 0, 0, 0, 0);
      SendSocket(EncodeMessage(m_DefMsg));
      //Inc(n4ADC04);
      //MemoLog.Lines.Add('Fail ' + IntToStr(n4ADC04));
    end;
  end;
  {
  except
    MainOutMessage('[Exception] TServerClient::ProcessServerMsg:' + IntToStr(DefMsg.Ident));
  end;
  }
  //g_nWorkStatus := 0;
end;

procedure TServerClient.SaveMagicList(nMagicCount: Integer; sMsg: string);
var
  sIdx: string;
  sData: string;
  sName: string;
  nIdx: Integer;
begin
  UnLoadMagicList;
  sData := DecodeString(sMsg);
  while True do begin
    if sData = '' then Break;
    sData := GetValidStr3(sData, sIdx, ['/']);
    sData := GetValidStr3(sData, sName, ['/']);
    nIdx := Str_ToInt(sIdx, -1);
    if (nIdx > 0) and (sName <> '') then begin
      g_MagicList.AddObject(sName, TObject(nIdx));
      //MainOutMessage(sName);
    end else break;
  end;
  m_DefMsg := MakeDefaultMsg(DBR_SAVEMAGICLIST, 1, 0, 0, 0);
  SendSocket(EncodeMessage(m_DefMsg));
  MainOutMessage(Format('技能数据库加载完成(%d)...', [g_MagicList.Count]));
end;

procedure TServerClient.SaveStdItemList(nItemCount: Integer; sMsg: string);
var
  sData: string;
  sName: string;
begin
  UnLoadStdItemList;
  sData := DecodeString(sMsg);
  while True do begin
    if sData = '' then Break;
    sData := GetValidStr3(sData, sName, ['/']);
    if sName <> '' then begin
      g_StdItemList.Add(sName);
      //MainOutMessage(sName);
    end else break;
  end;
  m_DefMsg := MakeDefaultMsg(DBR_SAVESTDITEMLIST, 1, 0, 0, 0);
  SendSocket(EncodeMessage(m_DefMsg));
  MainOutMessage(Format('物品数据库加载完成(%d)...', [g_StdItemList.Count]));
end;

procedure TServerClient.LoadHumanRcd(sMsg: string);
var
  sHumName: string;
  sAccount: string;
  sIPaddr: string;
  nIndex: Integer;
  nSessionID: Integer;
  nCheckCode: Integer;
  DefMsg: TDefaultMessage;
  HumanRCD: THumDataInfo;
  LoadHuman: TLoadHuman;
  boFoundSession: Boolean;
begin
  DecodeBuffer(sMsg, @LoadHuman, SizeOf(TLoadHuman));
  sAccount := LoadHuman.sAccount;
  sHumName := LoadHuman.sChrName;
  sIPaddr := LoadHuman.sUserAddr;
  nSessionID := LoadHuman.nSessionID;

  //MainOutMessage('TServerClient.LoadHumanRcd: ' + sAccount + ' IP: ' + sIPaddr + ' 标识: ' + IntToStr(nSessionID));
  nCheckCode := -1;
  if (sAccount <> '') and (sHumName <> '') then begin
    if (FrmIDSoc.CheckSessionLoadRcd(sAccount, sIPaddr, nSessionID, boFoundSession)) then begin
      nCheckCode := 1;
    end else begin
      if boFoundSession then begin
        MainOutMessage('[非法重复请求] ' + '帐号: ' + sAccount + ' IP: ' + sIPaddr + ' 标识: ' + IntToStr(nSessionID));
      end else begin
        MainOutMessage('[非法请求] ' + '帐号: ' + sAccount + ' IP: ' + sIPaddr + ' 标识: ' + IntToStr(nSessionID));
      end;
      //nCheckCode:= 1; //测试用，正常去掉
    end;
  end;
  if nCheckCode = 1 then begin
    try
      if g_HumDataDB.Open then begin
        nIndex := g_HumDataDB.Index(sHumName);
        if nIndex >= 0 then begin
          if g_HumDataDB.Get(nIndex, @HumanRCD) < 0 then nCheckCode := -2;
        end else nCheckCode := -3;
      end else nCheckCode := -4;
    finally
      g_HumDataDB.Close();
    end;
  end;

  if nCheckCode = 1 then begin
    Inc(g_nLoadHumCount);
    m_DefMsg := MakeDefaultMsg(DBR_LOADHUMANRCD, 1, 0, 0, 1);
    SendSocket(EncodeMessage(m_DefMsg) + EncodeString(sHumName) + '/' + EncodeBuffer(@HumanRCD, SizeOf(THumDataInfo)));
  end else begin
    m_DefMsg := MakeDefaultMsg(DBR_LOADHUMANRCD, nCheckCode, 0, 0, 0);
    SendSocket(EncodeMessage(m_DefMsg));
  end;
end;

procedure TServerClient.SaveHumanRcd(nRecog: Integer; sMsg: string);
var
  sChrName: string;
  sUserID: string;
  sHumanRCD: string;
  I: Integer;
  nIndex: Integer;
  bo21: Boolean;
  DefMsg: TDefaultMessage;
  HumanRCD: THumDataInfo;
  HumDataInfo: THumDataInfo;
begin
  sHumanRCD := GetValidStr3(sMsg, sUserID, ['/']);
  sHumanRCD := GetValidStr3(sHumanRCD, sChrName, ['/']);
  sUserID := DecodeString(sUserID);
  sChrName := DecodeString(sChrName);
  bo21 := False;
  FillChar(HumanRCD.Data, SizeOf(THumData), #0);
  if Length(sHumanRCD) = GetCodeMsgSize(SizeOf(THumDataInfo) * 4 / 3) then
    DecodeBuffer(sHumanRCD, @HumanRCD, SizeOf(THumDataInfo))
  else bo21 := True;
  if not bo21 then begin
    bo21 := True;
    try
      if g_HumDataDB.Open then begin
        nIndex := g_HumDataDB.Index(sChrName);
        if nIndex < 0 then begin
          HumanRCD.Header.boDeleted := False;
          HumanRCD.Header.dCreateDate := Now;
          HumanRCD.Header.sName := sChrName;
          HumanRCD.Header.boIsHero := False;
          g_HumDataDB.Add(@HumanRCD);
          nIndex := g_HumDataDB.Index(sChrName);
        end;

        if (nIndex >= 0) and (g_HumDataDB.Get(nIndex, @HumDataInfo) >= 0) then begin
          HumanRCD.Header := HumDataInfo.Header;
          g_HumDataDB.Update(nIndex, @HumanRCD);
          bo21 := False;
          Inc(g_nSaveHumCount);
        end;
      end;
    finally
      g_HumDataDB.Close;
    end;
    FrmIDSoc.SetSessionSaveRcd(sUserID);
  end;
  if not bo21 then begin
    m_DefMsg := MakeDefaultMsg(DBR_SAVEHUMANRCD, 1, 0, 0, 0);
    SendSocket(EncodeMessage(m_DefMsg));
  end else begin
    m_DefMsg := MakeDefaultMsg(DBR_LOADHUMANRCD, 0, 0, 0, 0);
    SendSocket(EncodeMessage(m_DefMsg));
    //0MainOutMessage('SaveHumanRcd Fail');
  end;
end;

procedure TServerClient.DeleteHeroRcd(sMsg: string);
var
  sData, sAccount, sChrName: string;
  boCheck: Boolean;
  n10, n12: Integer;
  HumRecord: THumInfo;
  HumanRCD: THumDataInfo;
begin
  n12 := 0;
  sData := DecodeString(sMsg);
  sData := GetValidStr3(sData, sAccount, ['/']);
  sData := GetValidStr3(sData, sChrName, ['/']);
  boCheck := False;
  try
    if g_HumCharDB.Open then begin
      n10 := g_HumCharDB.Index(sChrName);
      if n10 >= 0 then begin
        if (g_HumCharDB.Get(n10, @HumRecord) >= 0) and HumRecord.boIsHero then begin
          if g_HumCharDB.Delete(sChrName) then n12 := 1;
          Inc(g_nDeleteHeroCount);
        end;
      end;
    end;
  finally
    g_HumCharDB.Close;
  end;

  if n12 = 1 then begin
    try
      if g_HumDataDB.Open then begin
        n10 := g_HumDataDB.Index(sChrName);
        if n10 >= 0 then begin
          if (g_HumDataDB.Get(n10, @HumanRCD) >= 0) and HumanRCD.Header.boIsHero then begin
            if g_HumDataDB.Delete(sChrName) then n12 := 1;
          end;
        end;
      end;
    finally
      g_HumDataDB.Close;
    end;
  end;

  m_DefMsg := MakeDefaultMsg(DBR_DELHERORCD, n12, 0, 0, 0);
  SendSocket(EncodeMessage(m_DefMsg));
end;

procedure TServerClient.NewHeroRcd(sMsg: string);
  function NewHeroData(sAccount, sChrName: string; nSex, nJob, nHair: Integer): Boolean;
  var
    ChrRecord: THumDataInfo;
  begin
    Result := False;
    try
      if g_HumDataDB.Open and (g_HumDataDB.Index(sChrName) = -1) then begin
        FillChar(ChrRecord, SizeOf(THumDataInfo), #0);
        ChrRecord.Header.dCreateDate := Now;
        ChrRecord.Header.boIsHero := True;
        ChrRecord.Header.sName := sChrName;
        ChrRecord.Header.boDeleted := False;
        ChrRecord.Data.sChrName := sChrName;
        ChrRecord.Data.sAccount := sAccount;
        ChrRecord.Data.btSex := nSex;
        ChrRecord.Data.btJob := nJob;
        ChrRecord.Data.btHair := nHair;
        ChrRecord.Data.boHasHero := False;
        ChrRecord.Data.boIsHero := True;
        Result := g_HumDataDB.Add(@ChrRecord);
        Inc(g_nCreateHeroCount);
      end;
    finally
      g_HumDataDB.Close;
    end;
  end;
var
  sData, sAccount, sCharName, sHeroName, sHair, sJob, sSex: string;
  nCode: Integer;
  HumRecord: THumInfo;
  HumanRCD: THumDataInfo;
  nIndex, I, nError: Integer;
begin
  nCode := -1;
  nError := 0;
  try
    sData := DecodeString(sMsg);
    sData := GetValidStr3(sData, sAccount, ['/']);
    sData := GetValidStr3(sData, sCharName, ['/']);
    sData := GetValidStr3(sData, sHeroName, ['/']);
    sData := GetValidStr3(sData, sHair, ['/']);
    sData := GetValidStr3(sData, sJob, ['/']);
    sData := GetValidStr3(sData, sSex, ['/']);
    nError := 1;
    if (sAccount <> '') and (sCharName <> '') and (sHeroName <> '') and (sHair <> '') and (sJob <> '') and (sSex <> '') then begin
     { try
        nError := 2;
        if g_HumCharDB.Open then begin
          nError := 22;
          nIndex := g_HumCharDB.Index(sCharName);
          nError := 23;
          if (nIndex >= 0) and (g_HumCharDB.Get(nIndex, @HumRecord) >= 0) then begin
            nError := 3;
            try
              if g_HumDataDB.Open then begin
                nError := 4;
                nIndex := g_HumDataDB.Index(sCharName);
                if nIndex >= 0 then begin
                  nError := 5;
                  if g_HumDataDB.Get(nIndex, @HumanRCD) < 0 then nCode := -10
                  else if HumanRCD.Data.sHeroChrName = '' then nCode := 0;
                end else nCode := -11;
              end else nCode := -12;
            finally
              g_HumDataDB.Close();
            end;
            nError := 6;
          end else nCode := -11;
        end else nCode := -12;
      finally
        g_HumCharDB.Close;
      end;

      nError := 7;
      if nCode = 0 then nCode := -1;
      }

      if nCode = -1 then begin
        if Trim(sData) <> '' then nCode := 0;
        sHeroName := Trim(sHeroName);
        if Length(sHeroName) < 3 then nCode := 0;
        nError := 8;
        if not CheckDenyChrName(sHeroName) then nCode := 0;
        nError := 9;
        if not CheckAIChrName(sHeroName) then nCode := 0;
        nError := 10;
        if not CheckChrName(sHeroName) then nCode := 0;
        nError := 11;
        if not g_boDenyChrName then begin
          for I := 1 to Length(sHeroName) do begin
            if (sHeroName[I] = #$A1) or
              (sHeroName[I] = ' ') or
              (sHeroName[I] = '/') or
              (sHeroName[I] = '@') or
              (sHeroName[I] = '?') or
              (sHeroName[I] = '''') or
              (sHeroName[I] = '"') or
              (sHeroName[I] = '\') or
              (sHeroName[I] = '.') or
              (sHeroName[I] = ',') or
              (sHeroName[I] = ':') or
              (sHeroName[I] = ';') or
              (sHeroName[I] = '`') or
              (sHeroName[I] = '~') or
              (sHeroName[I] = '!') or
              (sHeroName[I] = '#') or
              (sHeroName[I] = '$') or
              (sHeroName[I] = '%') or
              (sHeroName[I] = '^') or
              (sHeroName[I] = '&') or
              (sHeroName[I] = '*') or
              (sHeroName[I] = '(') or
              (sHeroName[I] = ')') or
              (sHeroName[I] = '-') or
              (sHeroName[I] = '_') or
              (sHeroName[I] = '+') or
              (sHeroName[I] = '=') or
              (sHeroName[I] = '|') or
              (sHeroName[I] = '[') or
              (sHeroName[I] = '{') or
              (sHeroName[I] = ']') or
              (sHeroName[I] = '}') then nCode := 0;
          end;
        end;
      end;

      nError := 12;
      if nCode = -1 then begin

        try
          g_HumCharDB.Lock;
          if g_HumCharDB.Index(sHeroName) >= 0 then nCode := 2;
        finally
          g_HumCharDB.UnLock;
        end;

        if nCode = -1 then begin
          try
            g_HumDataDB.Lock;
            if g_HumDataDB.Index(sHeroName) >= 0 then nCode := 2;
          finally
            g_HumDataDB.UnLock;
          end;
        end;

        nError := 13;
        if nCode = -1 then begin
          nError := 14;
          FillChar(HumRecord, SizeOf(THumInfo), #0);

          try
            if g_HumCharDB.Open then begin
              HumRecord.Header.boDeleted := False;
              HumRecord.Header.boIsHero := True;
              HumRecord.Header.dCreateDate := Now;
              HumRecord.Header.sName := sHeroName;
              HumRecord.Header.nSelectID := 0;
              HumRecord.sChrName := sHeroName;
              HumRecord.sAccount := sAccount;
              HumRecord.boDeleted := False;
              HumRecord.btCount := 0;
              HumRecord.sChrName := sHeroName;
              HumRecord.boSelected := True;
              HumRecord.boIsHero := True;
              if HumRecord.sChrName <> '' then
                if not g_HumCharDB.Add(@HumRecord) then nCode := 4;
            end;
          finally
            g_HumCharDB.Close;
          end;
        end;

        nError := 15;
        if nCode = -1 then begin
          nError := 16;
          if NewHeroData(sAccount, sHeroName, Str_ToInt(sSex, 0), Str_ToInt(sJob, 0), Str_ToInt(sHair, 0)) then
            nCode := 1;
          nError := 17;
        end else begin
          nError := 18;
          try
            if g_HumCharDB.Open then begin
              g_HumCharDB.Delete(sHeroName);
            end;
          finally
            g_HumCharDB.Close;
          end;
          nError := 19;
          nCode := 4;
        end;
      end;

    end;
  except
    MainOutMessage('[Exception] TDBSERVER::NewHeroRcd:' + IntToStr(nError));
  end;
  m_DefMsg := MakeDefaultMsg(DBR_NEWHERORCD, nCode, 0, 0, 0);
  SendSocket(EncodeMessage(m_DefMsg));
end;

procedure TServerClient.LoadHeroRcd(sMsg: string);
var
  sHumName: string;
  sAccount: string;
  sIPaddr: string;
  nIndex: Integer;
  nSessionID: Integer;
  nCheckCode: Integer;
  DefMsg: TDefaultMessage;
  HumRecord: THumInfo;
  HumanRCD: THumDataInfo;
  LoadHuman: TLoadHuman;
  boFoundSession: Boolean;
begin
  DecodeBuffer(sMsg, @LoadHuman, SizeOf(TLoadHuman));
  sAccount := LoadHuman.sAccount;
  sHumName := LoadHuman.sChrName;
  sIPaddr := LoadHuman.sUserAddr;
  nSessionID := LoadHuman.nSessionID;

  //MainOutMessage(Format('LoadHeroRcd1 %s %s %s', [sAccount, sHumName, sIPaddr]));
  //MainOutMessage('TServerClient.LoadHumanRcd: ' + sAccount + ' IP: ' + sIPaddr + ' 标识: ' + IntToStr(nSessionID));
  nCheckCode := -1;
  {if (sAccount <> '') and (sHumName <> '') then begin
    nCheckCode := 1;
    if (FrmIDSoc.CheckSessionHeroLoadRcd(sAccount, sIPaddr, nSessionID, boFoundSession)) then begin
      nCheckCode := 1;
    end else begin
      if boFoundSession then begin
        MainOutMessage('[非法重复请求] ' + '帐号: ' + sAccount + ' IP: ' + sIPaddr + ' 标识: ' + IntToStr(nSessionID));
      end else begin
        MainOutMessage('[非法请求] ' + '帐号: ' + sAccount + ' IP: ' + sIPaddr + ' 标识: ' + IntToStr(nSessionID));
      end;
      //nCheckCode:= 1; //测试用，正常去掉
    end;
  end;}
  if (sAccount <> '') and (sHumName <> '') then begin
    nCheckCode := 1;
  end;

{  if nCheckCode = 1 then begin
    try
      if g_HumCharDB.Open then begin
        nIndex := g_HumCharDB.Index(sHumName);
        if nIndex >= 0 then begin
          //MainOutMessage(Format('LoadHeroRcd2 %s %s %s', [sAccount, sHumName, sIPaddr]));
          if (g_HumCharDB.Get(nIndex, @HumRecord) < 0) or (HumRecord.sAccount <> sAccount) then
            nCheckCode := -2;
        end else nCheckCode := -2;
      end;
    finally
      g_HumCharDB.Close;
    end;
  end; }

  if nCheckCode = 1 then begin
    //MainOutMessage(Format('LoadHeroRcd3 %s %s %s', [sAccount, sHumName, sIPaddr]));
    try
      if g_HumDataDB.Open then begin
        nIndex := g_HumDataDB.Index(sHumName);
        //MainOutMessage(Format('LoadHeroRcd4 %s %s %s', [sAccount, sHumName, sIPaddr]));
        if nIndex >= 0 then begin
          //MainOutMessage(Format('LoadHeroRcd5 %s %s %s', [sAccount, sHumName, sIPaddr]));
          if g_HumDataDB.Get(nIndex, @HumanRCD) < 0 then nCheckCode := -2;
        end else nCheckCode := -3;
      end else nCheckCode := -4;
    finally
      g_HumDataDB.Close();
    end;
  end;
  //MainOutMessage(Format('LoadHeroRcd1 %s %s %s %d', [sAccount, sHumName, sIPaddr, nCheckCode]));
  if nCheckCode = 1 then begin
    //MainOutMessage('TServerClient.LoadHumanRcd: HumanRCD.Data.Abil.Level: ' + IntToStr(HumanRCD.Data.Abil.Level));
    //MainOutMessage('TServerClient.LoadHumanRcd: HumanRCD.Data.sHomeMap: ' + HumanRCD.Data.sHomeMap + ' ChrName' + HumanRCD.Data.sChrName + ' Account:' + HumanRCD.Data.sAccount + ' HumName:' + sHumName);
    Inc(g_nLoadHeroCount);
    m_DefMsg := MakeDefaultMsg(DBR_LOADHERORCD, 1, 0, 0, 1);
    SendSocket(EncodeMessage(m_DefMsg) + EncodeString(sHumName) + '/' + EncodeBuffer(@HumanRCD, SizeOf(THumDataInfo)));
  end else begin
    if (nCheckCode = -2) or (nCheckCode = -3) then begin
      m_DefMsg := MakeDefaultMsg(DBR_NOTCREATEHERO, nCheckCode, 0, 0, 0);
    end else begin
      m_DefMsg := MakeDefaultMsg(DBR_LOADHERORCD, nCheckCode, 0, 0, 0);
    end;
    SendSocket(EncodeMessage(m_DefMsg));
  end;
end;

procedure TServerClient.SaveHeroRcd(nRecog: Integer; sMsg: string);
var
  sChrName: string;
  sUserID: string;
  sHumanRCD: string;
  I: Integer;
  nIndex: Integer;
  bo21: Boolean;
  DefMsg: TDefaultMessage;
  HumanRCD, HumDataInfo: THumDataInfo;
begin
  sHumanRCD := GetValidStr3(sMsg, sUserID, ['/']);
  sHumanRCD := GetValidStr3(sHumanRCD, sChrName, ['/']);
  sUserID := DecodeString(sUserID);
  sChrName := DecodeString(sChrName);
  bo21 := False;
  FillChar(HumanRCD.Data, SizeOf(THumData), #0);
  if Length(sHumanRCD) = GetCodeMsgSize(SizeOf(THumDataInfo) * 4 / 3) then
    DecodeBuffer(sHumanRCD, @HumanRCD, SizeOf(THumDataInfo))
  else bo21 := True;
  if not bo21 then begin
    bo21 := True;
    try
      if g_HumDataDB.Open then begin
        nIndex := g_HumDataDB.Index(sChrName);
        if nIndex < 0 then begin
          HumanRCD.Header.boDeleted := False;
          HumanRCD.Header.boIsHero := True;
          HumanRCD.Header.sName := sChrName;
          HumanRCD.Header.dCreateDate := Now;
          g_HumDataDB.Add(@HumanRCD);
          nIndex := g_HumDataDB.Index(sChrName);
        end;

        if (nIndex >= 0) and (g_HumDataDB.Get(nIndex, @HumDataInfo) >= 0) then begin
          HumanRCD.Header := HumDataInfo.Header;
          g_HumDataDB.Update(nIndex, @HumanRCD);
          bo21 := False;
          Inc(g_nSaveHeroCount);
        end;

      end;
    finally
      g_HumDataDB.Close;
    end;
    //FrmIDSoc.SetSessionSaveRcd(sUserID);
  end;
  if not bo21 then begin
    m_DefMsg := MakeDefaultMsg(DBR_SAVEHERORCD, 1, 0, 0, 0);
    SendSocket(EncodeMessage(m_DefMsg));
  end else begin
    m_DefMsg := MakeDefaultMsg(DBR_SAVEHERORCD, 0, 0, 0, 0);
    SendSocket(EncodeMessage(m_DefMsg));
  end;
end;

procedure TServerClient.SaveHumanRcdEx(sMsg: string; nRecog: Integer);
var
  sChrName: string;
  sUserID: string;
  sHumanRCD: string;
  I: Integer;
  bo21: Boolean;
  DefMsg: TDefaultMessage;
  HumanRCD: THumDataInfo;
  //HumSession: pTHumSession;
begin
  sHumanRCD := GetValidStr3(sMsg, sUserID, ['/']);
  sHumanRCD := GetValidStr3(sHumanRCD, sChrName, ['/']);
  sUserID := DecodeString(sUserID);
  sChrName := DecodeString(sChrName);
  {for I := 0 to HumSessionList.Count - 1 do begin
    HumSession := HumSessionList.Items[I];
    if (HumSession.sChrName = sChrName) and (HumSession.nIndex = nRecog) then begin
      HumSession.bo24 := False;
      HumSession.Socket := Socket;
      HumSession.bo2C := True;
      HumSession.dwTick30 := GetTickCount();
      Break;
    end;
  end; }
  SaveHumanRcd(nRecog, sMsg);
end;

procedure TServerClient.LoadRanking(sMsg: string; Msg: pTDefaultMessage);
var
  I, nIndex, nCount: Integer;
  sHumName: string;
  sSendText: string;
  //S: string;
  nCheckCode: Integer;
  DefMsg: TDefaultMessage;
  RankingList: TStringList;
  HumRanking: pTUserLevelRanking;
  HeroRanking: pTHeroLevelRanking;
  MasterRanking: pTUserMasterRanking;

  UserLevelRanking: TUserLevelRanking;
  HeroLevelRanking: THeroLevelRanking;
  UserMasterRanking: TUserMasterRanking;
begin
  EnterCriticalSection(g_Ranking_CS);
  try
    nCheckCode := -1;
    sSendText := '';
    nIndex := 0;
    nCount := 0;
    RankingList := nil;
    //S := '';
    sHumName := DecodeString(sMsg);
    if Msg.Param in [0..2] then begin
      if Msg.Param < 2 then begin
        if Msg.Tag in [0..4] then begin
          nCheckCode := 0;
          RankingList := GetRankingList(Msg.Param, Msg.Tag);
          if RankingList.Count > 0 then begin
            if sHumName = '' then begin //为空不是查找自己
              nIndex := _MAX(_MIN(RankingList.Count - 1, Msg.Recog), 0);
{$IF HEROVERSION = 1}
              nCount := _MIN(RankingList.Count - 1, nIndex + 9);
{$ELSE}
              nCount := _MIN(RankingList.Count - 1, nIndex + 7);
{$IFEND}
              if Msg.Param = 0 then begin
                for I := nIndex to nCount do begin
                  HumRanking := pTUserLevelRanking(RankingList.Objects[I]);
                  UserLevelRanking := HumRanking^;
                  UserLevelRanking.nIndex := I + 1;
                  //S:=S+HumRanking.sChrName+'/';
                  sSendText := sSendText + EncodeBuffer(@UserLevelRanking, SizeOf(TUserLevelRanking)) + '/';
                end;
              end else begin
                for I := nIndex to nCount do begin
                  HeroRanking := pTHeroLevelRanking(RankingList.Objects[I]);
                  HeroLevelRanking := HeroRanking^;
                  HeroLevelRanking.nIndex := I + 1;
                  sSendText := sSendText + EncodeBuffer(@HeroLevelRanking, SizeOf(THeroLevelRanking)) + '/';
                end;
              end;
            end else begin
              if Msg.Param = 0 then begin
                for I := 0 to RankingList.Count - 1 do begin
                  HumRanking := pTUserLevelRanking(RankingList.Objects[I]);
                  if HumRanking.sChrName = sHumName then begin
                    UserLevelRanking := HumRanking^;
                    UserLevelRanking.nIndex := I + 1;
                    sSendText := EncodeBuffer(@UserLevelRanking, SizeOf(TUserLevelRanking));
                    //S:=S+HumRanking.sChrName+'/';
                    Break;
                  end;
                end;
              end else begin
                for I := 0 to RankingList.Count - 1 do begin
                  HeroRanking := pTHeroLevelRanking(RankingList.Objects[I]);
                  if HeroRanking.sChrName = sHumName then begin
                    HeroLevelRanking := HeroRanking^;
                    HeroLevelRanking.nIndex := I + 1;
                    sSendText := EncodeBuffer(@HeroLevelRanking, SizeOf(THeroLevelRanking));
                    Break;
                  end;
                end;
              end;
            end;
          end;
        end;
      end else begin
        nCheckCode := 0;
        RankingList := GetRankingList(Msg.Param, Msg.Tag);
        if RankingList.Count > 0 then begin
          if sHumName = '' then begin //为空不是查找自己
            nIndex := _MAX(_MIN(RankingList.Count - 1, Msg.Recog), 0);
{$IF HEROVERSION = 1}
            nCount := _MIN(RankingList.Count - 1, nIndex + 9);
{$ELSE}
            nCount := _MIN(RankingList.Count - 1, nIndex + 7);
{$IFEND}
            for I := nIndex to nCount do begin
              MasterRanking := pTUserMasterRanking(RankingList.Objects[I]);
              UserMasterRanking := MasterRanking^;
              UserMasterRanking.nIndex := I + 1;
              sSendText := sSendText + EncodeBuffer(@UserMasterRanking, SizeOf(TUserMasterRanking)) + '/';
            end;
          end else begin
            for I := 0 to RankingList.Count - 1 do begin
              MasterRanking := pTUserMasterRanking(RankingList.Objects[I]);
              if MasterRanking.sChrName = sHumName then begin
                UserMasterRanking := MasterRanking^;
                UserMasterRanking.nIndex := I + 1;
                sSendText := EncodeBuffer(@UserMasterRanking, SizeOf(TUserMasterRanking));
                Break;
              end;
            end;
          end;
        end;
      end;
    end;
    if nCheckCode = 0 then begin
      DefMsg := MakeDefaultMsg(DBR_LOADRANKING, Msg.Tag, Msg.Param, nIndex, RankingList.Count);
      SendSocket(EncodeMessage(DefMsg) + sSendText);
    end else begin
      DefMsg := MakeDefaultMsg(DBR_LOADRANKING, Msg.Tag, Msg.Param, nIndex, 0);
      SendSocket(EncodeMessage(DefMsg) + sSendText);
    end;
  finally
    LeaveCriticalSection(g_Ranking_CS);
  end;
end;

end.

