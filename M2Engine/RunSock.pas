unit RunSock;

interface
uses
  Windows, Classes, SysUtils, StrUtils, SyncObjs, JSocket, ObjBase, ObjActor, ObjHero, Grobal2,
  FrnEngn, UsrEngn, Common;
type
  TGateUserInfo = record
    sAccount: string;
    sCharName: string;
    sIPaddr: string;
    nSocket: Integer;
    nGSocketIdx: Integer;
    nSessionID: Integer;
    nClientVersion: Integer;
    UserEngine: TUserEngine;
    FrontEngine: TFrontEngine;
    PlayObject: TPlayObject;
    SessInfo: pTSessInfo;
    dwNewUserTick: LongWord;
    boCertification: Boolean;
    boHeroVersion: Boolean;
  end;
  pTGateUserInfo = ^TGateUserInfo;

  TRunSocket = class
    m_RunSocketSection: TRTLCriticalSection;
    m_RunAddrList: TStringList;
    n8: Integer;
    m_IPaddrArr: array[0..19] of TIPaddr;
    n4F8: Integer;
    dwSendTestMsgTick: LongWord;
    m_nErrorCount: Integer;
  private
    procedure LoadRunAddr;
    procedure ExecGateBuffers(nGateIndex: Integer; Gate: pTGateInfo; Buffer: PChar; nMsgLen: Integer);
    procedure DoClientCertification(GateIdx: Integer; GateUser: pTGateUserInfo; nSocket: Integer; sMsg: string);
    procedure ExecGateMsg(GateIdx: Integer; Gate: pTGateInfo; MsgHeader: pTMsgHeader; MsgBuff: PChar; nMsgLen: Integer);
    procedure SendCheck(Socket: TCustomWinSocket; nIdent: Integer);
    function OpenNewUser(nSocket: Integer; nGSocketIdx: Integer; sIPaddr: string; UserList: TList): Integer;
    procedure SendNewUserMsg(Socket: TCustomWinSocket; nSocket: Integer; nSocketIndex, nUserIdex: Integer);
    procedure SendGateTestMsg(nIndex: Integer);
    function SendGateBuffers(GateIdx: Integer; Gate: pTGateInfo; MsgList: TList): Boolean;
    function GetGateAddr(sIPaddr: string): string;
    procedure SendScanMsg(DefMsg: pTDefaultMessage; sMsg: string; nGateIdx, nSocket, nGsIdx: Integer);
    procedure ProcessUserPacket(GateIdx: Integer; Gate: pTGateInfo);
  public
    constructor Create();
    destructor Destroy; override;
    procedure Run();
    procedure Execute;
    procedure AddGate(Socket: TCustomWinSocket);
    procedure SocketRead(Socket: TCustomWinSocket);
    procedure CloseGate(Socket: TCustomWinSocket);
    procedure CloseErrGate(Socket: TCustomWinSocket; var ErrorCode: Integer);
    procedure CloseAllGate();
    procedure CloseUser(GateIdx, nSocket: Integer);
    function AddGateBuffer(GateIdx: Integer; Buffer: PChar): Boolean;
    procedure SendOutConnectMsg(nGateIdx, nSocket, nGsIdx: Integer);
    procedure SendCloseOutConnectMsg(nGateIdx, nSocket, nGsIdx: Integer);
    procedure SetGateUserList(nGateIdx, nSocket: Integer; PlayObject: TPlayObject);
    procedure KickUser(sAccount: string; nSessionID: Integer);
  end;
var
  g_GateArr: array[0..19] of TGateInfo;
  g_nGateRecvMsgLenMin: Integer;
  g_nGateRecvMsgLenMax: Integer;
implementation

uses M2Share, IdSrvClient, HUtil32, EncryptUnit, PlugIn, SDK;
var
  nRunSocketRun: Integer = -1;
  nExecGateBuffers: Integer = -1;
  { TRunSocket }

procedure TRunSocket.AddGate(Socket: TCustomWinSocket);
var
  I: Integer;
  sIPaddr: string;
  Gate: pTGateInfo;
resourcestring
  sGateOpen = 'Rungate [%d](%s:%d)opened...';
  sKickGate = 'Server not ready: %s';
begin
  sIPaddr := Socket.RemoteAddress;
  if boStartReady then begin
    for I := Low(g_GateArr) to High(g_GateArr) do begin
      Gate := @g_GateArr[I];
      if Gate.boUsed then Continue;
      Gate.boUsed := True;
      Gate.Socket := Socket;
      Gate.sAddr := GetGateAddr(sIPaddr);
      Gate.nPort := Socket.RemotePort;
      Gate.n520 := 1;
      Gate.UserList := TList.Create;
      Gate.nUserCount := 0;
      Gate.Buffer := nil;
      Gate.nBuffLen := 0;
      Gate.BufferList := TList.Create;
      Gate.boSendKeepAlive := False;
      Gate.dwSendKeepAliveTick := GetTickCount;
      Gate.nSendChecked := 0;
      Gate.nSendBlockCount := 0;
      Gate.dwTime544 := GetTickCount;
      MainOutMessage(Format(sGateOpen, [I, Socket.RemoteAddress, Socket.RemotePort]));
      Break;
    end;
  end else begin
    MainOutMessage(Format(sKickGate, [sIPaddr]));
    Socket.Close;
  end;
end;

procedure TRunSocket.CloseAllGate;
var
  GateIdx: Integer;
  Gate: pTGateInfo;
begin
  for GateIdx := Low(g_GateArr) to High(g_GateArr) do begin
    Gate := @g_GateArr[GateIdx];
    if Gate.Socket <> nil then begin
      Gate.Socket.Close;
    end;
  end;
end;

procedure TRunSocket.CloseErrGate(Socket: TCustomWinSocket;
  var ErrorCode: Integer);
begin
  if Socket.Connected then Socket.Close;
  ErrorCode := 0;
end;

procedure TRunSocket.CloseGate(Socket: TCustomWinSocket);
var
  I, GateIdx: Integer;
  GateUser: pTGateUserInfo;
  UserList: TList;
  Gate: pTGateInfo;
resourcestring
  sGateClose = 'Rungate [%d](%s:%d)closed...';
begin
  EnterCriticalSection(m_RunSocketSection);
  try
    for GateIdx := Low(g_GateArr) to High(g_GateArr) do begin
      Gate := @g_GateArr[GateIdx];
      if Gate.Socket = Socket then begin
        UserList := Gate.UserList;
        for I := 0 to UserList.Count - 1 do begin
          GateUser := UserList.Items[I];
          if GateUser <> nil then begin
            if GateUser.PlayObject <> nil then begin
              TPlayObject(GateUser.PlayObject).m_boEmergencyClose := True;
              TPlayObject(GateUser.PlayObject).m_boPlayOffLine := False;
              if not TPlayObject(GateUser.PlayObject).m_boReconnection then begin
                FrmIDSoc.SendHumanLogOutMsg(GateUser.sAccount, GateUser.nSessionID);
              end;
            end;
            Dispose(GateUser);
            UserList.Items[I] := nil;
          end;
        end;
        Gate.UserList.Free;
        Gate.UserList := nil;
        if Gate.Buffer <> nil then
          FreeMem(Gate.Buffer);
        Gate.Buffer := nil;
        Gate.nBuffLen := 0;
        for I := 0 to Gate.BufferList.Count - 1 do begin
          FreeMem(Gate.BufferList.Items[I]);
        end;
        Gate.BufferList.Free;
        Gate.BufferList := nil;
        Gate.boUsed := False;
        Gate.Socket := nil;
        MainOutMessage(Format(sGateClose, [GateIdx, Socket.RemoteAddress, Socket.RemotePort]));
        Break;
      end;
    end;
  finally
    LeaveCriticalSection(m_RunSocketSection);
  end;
end;

procedure TRunSocket.ExecGateBuffers(nGateIndex: Integer; Gate: pTGateInfo; Buffer: PChar; nMsgLen: Integer);
var
  nLen: Integer;
  Buff: PChar;
  MsgBuff: PChar;
  MsgHeader: pTMsgHeader; {Size 20}
  nCheckMsgLen: Integer;
  TempBuff: PChar;
resourcestring
  sExceptionMsg1 = '[Exception] TRunSocket::ExecGateBuffers -> pBuffer';
  sExceptionMsg2 = '[Exception] TRunSocket::ExecGateBuffers -> @pwork,ExecGateMsg ';
  sExceptionMsg3 = '[Exception] TRunSocket::ExecGateBuffers -> FreeMem';
begin
  nLen := 0;
  Buff := nil;
  try
    if Buffer <> nil then begin
      ReAllocMem(Gate.Buffer, Gate.nBuffLen + nMsgLen);
      Move(Buffer^, Gate.Buffer[Gate.nBuffLen], nMsgLen);
    end;
  except
    MainOutMessage(sExceptionMsg1);
  end;
  try
    nLen := Gate.nBuffLen + nMsgLen;
    Buff := Gate.Buffer;
    if nLen >= SizeOf(TMsgHeader) then begin
      while (True) do begin
        {
        pMsg:=pTMsgHeader(Buff);
        if pMsg.dwCode = RUNGATECODE then begin
          if nLen < (pMsg.nLength + SizeOf(TMsgHeader)) then break;
          MsgBuff:=@Buff[SizeOf(TMsgHeader)];
        }
        MsgHeader := pTMsgHeader(Buff);
        nCheckMsgLen := abs(MsgHeader.nLength) + SizeOf(TMsgHeader);
        if (MsgHeader.dwCode = RUNGATECODE) and (nCheckMsgLen < $8000) then begin
          if nLen < nCheckMsgLen then Break;
          MsgBuff := Buff + SizeOf(TMsgHeader); //Jacky 1009 换上
          //MsgBuff:=@Buff[SizeOf(TMsgHeader)];
          ExecGateMsg(nGateIndex, Gate, MsgHeader, MsgBuff, MsgHeader.nLength);
          Buff := Buff + SizeOf(TMsgHeader) + MsgHeader.nLength; //Jacky 1009 换上
          //Buff:=@Buff[SizeOf(TMsgHeader) + pMsg.nLength];
          nLen := nLen - (MsgHeader.nLength + SizeOf(TMsgHeader));
        end else begin
          Inc(Buff);
          Dec(nLen);
        end;
        if nLen < SizeOf(TMsgHeader) then Break;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg2);
  end;
  try
    if nLen > 0 then begin
      GetMem(TempBuff, nLen);
      Move(Buff^, TempBuff^, nLen);
      FreeMem(Gate.Buffer);
      Gate.Buffer := TempBuff;
      Gate.nBuffLen := nLen;
    end else begin
      FreeMem(Gate.Buffer);
      Gate.Buffer := nil;
      Gate.nBuffLen := 0;
    end;
  except
    MainOutMessage(sExceptionMsg3);
  end;
end;

procedure TRunSocket.SocketRead(Socket: TCustomWinSocket);
var
  nMsgLen, GateIdx: Integer;
  Gate: pTGateInfo;
{$IF SOCKETTYPE = 0}
  RecvBuffer: array[0..DATA_BUFSIZE * 2 - 1] of Char;
{$ELSE}
  RecvBuffer: PChar;
{$IFEND}
  nLoopCheck: Integer;
resourcestring
  sExceptionMsg1 = '[Exception] TRunSocket::SocketRead';
begin
  for GateIdx := Low(g_GateArr) to High(g_GateArr) do begin
    Gate := @g_GateArr[GateIdx];
    if Gate.Socket = Socket then begin
      try
{$IF SOCKETTYPE = 0}
        while (True) do begin
          nMsgLen := Socket.ReceiveBuf(RecvBuffer, SizeOf(RecvBuffer));
          if nMsgLen <= 0 then Break;
          ExecGateBuffers(GateIdx, Gate, @RecvBuffer, nMsgLen);
        end;
{$ELSE}
        nMsgLen := Socket.ReceiveLength;
        GetMem(RecvBuffer, nMsgLen);
        Socket.ReceiveBuf(RecvBuffer^, nMsgLen);
        ExecGateBuffers(GateIdx, Gate, RecvBuffer, nMsgLen);
        FreeMem(RecvBuffer);
{$IFEND}
        Break;
      except
{$IF SOCKETTYPE = 1}
        if RecvBuffer <> nil then begin
          FreeMem(RecvBuffer);
        end;
{$IFEND}
        MainOutMessage(sExceptionMsg1);
      end;
    end;
  end;
end;

procedure TRunSocket.ProcessUserPacket(GateIdx: Integer; Gate: pTGateInfo);
begin

end;

procedure TRunSocket.Run;
var
  dwRunTick: LongWord;
  I, II, nG: Integer;
  Gate: pTGateInfo;
  GateUser: pTGateUserInfo;
resourcestring
  sExceptionMsg = '[Exception] TRunSocket::Run';
begin
  dwRunTick := GetTickCount();
  if boStartReady then begin
    try
      if g_Config.nGateLoad > 0 then begin
        {if (GetTickCount - dwSendTestMsgTick) >= 100 then begin
          dwSendTestMsgTick := GetTickCount();
          for I := Low(g_GateArr) to High(g_GateArr) do begin
            Gate := @g_GateArr[I];
            if Gate.BufferList <> nil then begin
              for nG := 0 to g_Config.nGateLoad - 1 do begin
                SendGateTestMsg(I);
              end;
            end;
          end;
        end;}
      end;

      for I := Low(g_GateArr) to High(g_GateArr) do begin //2007-01-21增加20秒内没登陆成功用户踢下线
        Gate := @g_GateArr[I];
        if Gate.UserList <> nil then begin
          EnterCriticalSection(m_RunSocketSection);
          try
            for II := Gate.UserList.Count - 1 downto 0 do begin
              if Gate.UserList.Items[II] <> nil then begin
                GateUser := Gate.UserList.Items[II];
                if GateUser <> nil then begin
                  if (GetTickCount - GateUser.dwNewUserTick > 1000 * 10) and not GateUser.boCertification then begin
                    CloseUser(I, GateUser.nSocket);
                    SendOutConnectMsg(I, GateUser.nSocket, GateUser.nGSocketIdx);
                    SendCloseOutConnectMsg(I, GateUser.nSocket, GateUser.nGSocketIdx);
                  end;
                end;
              end;
            end;
          finally
            LeaveCriticalSection(m_RunSocketSection);
          end;
        end;
      end;

      for I := Low(g_GateArr) to High(g_GateArr) do begin
        Gate := @g_GateArr[I];
        if Gate.BufferList <> nil then begin
          EnterCriticalSection(m_RunSocketSection);
          try
            Gate.nSendMsgCount := Gate.BufferList.Count;
            if SendGateBuffers(I, Gate, Gate.BufferList) then begin
              Gate.nSendRemainCount := Gate.BufferList.Count;
            end else begin
              Gate.nSendRemainCount := Gate.BufferList.Count;
            end;
          finally
            LeaveCriticalSection(m_RunSocketSection);
          end;
        end;
      end;

      for I := Low(g_GateArr) to High(g_GateArr) do begin
        if g_GateArr[I].Socket <> nil then begin
          Gate := @g_GateArr[I];
          if (GetTickCount - Gate.dwSendTick) >= 1000 then begin
            Gate.dwSendTick := GetTickCount();
            Gate.nSendMsgBytes := Gate.nSendBytesCount;
            Gate.nSendedMsgCount := Gate.nSendCount;
            Gate.nSendBytesCount := 0;
            Gate.nSendCount := 0;
          end;
          if Gate.boSendKeepAlive then begin
            Gate.boSendKeepAlive := False;
            SendCheck(Gate.Socket, GM_CHECKSERVER);
          end;
        end;
      end;
    except
      on E: Exception do begin
        MainOutMessage(sExceptionMsg);
        MainOutMessage(E.Message);
      end;
    end;
  end;
  g_nSockCountMin := GetTickCount - dwRunTick;
  if g_nSockCountMin > g_nSockCountMax then g_nSockCountMax := g_nSockCountMin;
end;

procedure TRunSocket.DoClientCertification(GateIdx: Integer; GateUser: pTGateUserInfo; nSocket: Integer; sMsg: string);
  {function ScanCertification(sAccount: string; sChrName: string; nSessionID, nClientVersion: Integer): Boolean;
  var
    DefMsg: TDefaultMessage;
  resourcestring
    sInfoMsg = '%s/%s/%s/%d/%d/%d/%d-%d';
  begin
    Result := False;
    //**00/88/200000/200000/0
    if (sAccount = '00') and (sChrName = '88') and (nSessionID = 200000) and (nClientVersion = 200000) then begin
      sMsg := Format(sInfoMsg, [g_Config.sServerName,
        g_Config.sRegKey,
          g_Config.sRegServerAddr,
          g_Config.nRegServerPort,
          UserEngine.OnlinePlayObject,
          g_dwStartTick,
          GetTickCount,
          VEROWNER]);
      //sMsg := Base64EncodeStr(sMsg, IntToStr(nSessionID xor (nClientVersion div 3)));
      SendScanMsg(nil, EncodeString(sMsg), GateIdx, nSocket, GateUser.nGSocketIdx);
      Result := True;
    end;
  end;}
  function GetCertification(sMsg: string; var sAccount: string; var sChrName: string; var nSessionID: Integer; var nClientVersion: Integer; var boFlag: Boolean; var boHeroVersion: Boolean): Boolean; //004E0DE0
  var
    sData: string;
    sCodeStr, sXor, sClientVersion: string;
    sIdx: string;
    nXor1, nXor2: Int64;
  resourcestring
    sExceptionMsg = '[Exception] TRunSocket::DoClientCertification -> GetCertification';
  begin
    Result := False;
    try
      sData := DeCodeString(sMsg);
      if (Length(sData) > 2) and (sData[1] = '*') and (sData[2] = '*') then begin
        sData := Copy(sData, 3, Length(sData) - 2);
        sData := GetValidStr3(sData, sAccount, ['/']);
        sData := GetValidStr3(sData, sChrName, ['/']);
        sData := GetValidStr3(sData, sCodeStr, ['/']);
        sData := GetValidStr3(sData, sXor, ['/']);
        sData := GetValidStr3(sData, sClientVersion, ['/']);
        sIdx := sData;
        nXor1 := Str_ToInt(sCodeStr, 0);
        nXor2 := Str_ToInt(sXor, 0);
        if nXor1 xor $3EB2C5CC = nXor2 xor $54B163FD then begin //英雄登陆器
          boHeroVersion := True;
          nSessionID := nXor1 xor $3EB2C5CC;
          if sIdx = '0' then begin
            boFlag := True;
          end else begin
            boFlag := False;
          end;
          if (sAccount <> '') and (sChrName <> '') and (nSessionID >= 2) then begin
            nClientVersion := Str_ToInt(sClientVersion, 0); {CLIENT_VERSION_NUMBER};
            Result := True;
          end;
        end else begin //普通登陆器
          boHeroVersion := False;
          nSessionID := Str_ToInt(sCodeStr, 0);
          if sIdx = '0' then begin
            boFlag := True;
          end else begin
            boFlag := False;
          end;
          if (sAccount <> '') and (sChrName <> '') and (nSessionID >= 2) then begin
            nClientVersion := Str_ToInt(sXor, 0);
            Result := True;
          end;
        end;
      end;
    except
      MainOutMessage(sExceptionMsg);
    end;
  end;
var
  nCheckCode: Integer;
  sData: string;
  sAccount, sChrName: string;
  nSessionID: Integer;
  boFlag: Boolean;
  nClientVersion: Integer;
  nPayMent, nPayMode: Integer;
  boHeroVersion: Boolean;
  SessInfo: pTSessInfo;
  PlayObject: TPlayObject;
  I: Integer;
resourcestring
  sExceptionMsg = '[Exception] TRunSocket::DoClientCertification CheckCode: ';
  sRobotAttackMsg = '[超速登陆] IP:%s 账号:%s 名称:%s 速度:%d';
  sDisable = '*disable*';
begin
  nCheckCode := 0;
  try
    if GateUser.sAccount = '' then begin
      if Pos('!', sMsg) > 0 then begin //if TagCount(sMsg, '!') > 0 then begin
        sData := ArrestStringEx(sMsg, '#', '!', sMsg);
        sMsg := Copy(sMsg, 2, Length(sMsg) - 1);
        if GetCertification(sMsg, sAccount, sChrName, nSessionID, nClientVersion, boFlag, boHeroVersion) then begin
          //if ScanCertification(sAccount, sChrName, nSessionID, nClientVersion) then exit;
          SessInfo := FrmIDSoc.GetAdmission(sAccount, GateUser.sIPaddr, nSessionID, nPayMode, nPayMent);
          if (SessInfo <> nil) and (nPayMent > 0) then begin
            PlayObject := UserEngine.GetPlayObjectExOfAutoGetExp(Trim(sAccount));
            if PlayObject <> nil then begin //离线挂机人物直接登陆游戏
              if CompareText(PlayObject.m_sCharName, Trim(sChrName)) = 0 then begin
                PlayObject.m_boGhost := False;
                PlayObject.m_boDeath := False;
                PlayObject.m_boEmergencyClose := False;
                PlayObject.m_boSwitchData := False;
                PlayObject.m_boReconnection := False;
                PlayObject.m_boKickFlag := False;
                PlayObject.m_boSoftClose := False;

                PlayObject.m_dwSaveRcdTick := GetTickCount();
                PlayObject.m_boWantRefMsg := True;
                PlayObject.m_boDieInFight3Zone := False;
                PlayObject.m_Script := nil;
                PlayObject.m_boTimeRecall := False;

                PlayObject.m_boLoginNoticeOK := False;
                PlayObject.m_boSendNotice := False;

                PlayObject.m_sOldSayMsg := '';
                PlayObject.m_dwSayMsgTick := GetTickCount();
                PlayObject.m_boDisableSayMsg := False;
                PlayObject.m_dwDisableSayMsgTick := GetTickCount();
                PlayObject.m_dLogonTime := Now();
                PlayObject.m_dwLogonTick := GetTickCount();

                PlayObject.m_boSwitchData := False;
                PlayObject.m_boSwitchDataSended := False;
                PlayObject.m_nWriteChgDataErrCount := 0;
                PlayObject.m_dwShowLineNoticeTick := GetTickCount();
                PlayObject.m_nShowLineNoticeIdx := 0;
                PlayObject.m_nShowLineNoticeIdx1 := 0;

                PlayObject.m_boReConfigPwd := False;
                PlayObject.m_boCheckOldPwd := False;
                PlayObject.m_boUnLockPwd := False;
                PlayObject.m_boUnLockStoragePwd := False;
                PlayObject.m_boPasswordLocked := False; //锁仓库
                PlayObject.m_btPwdFailCount := 0;

                PlayObject.m_boFilterSendMsg := False;

                PlayObject.m_boCanDeal := True;
                PlayObject.m_boCanDrop := True;
                PlayObject.m_boCanGetBackItem := True;
                PlayObject.m_boCanWalk := True;
                PlayObject.m_boCanRun := True;
                PlayObject.m_boCanHit := True;
                PlayObject.m_boCanSpell := True;
                PlayObject.m_boCanUseItem := True;
                PlayObject.m_nMemberType := 0;
                PlayObject.m_nMemberLevel := 0;

                PlayObject.m_boAllowDeal := True; //禁止交易
                PlayObject.m_boAllowGuild := False; //禁止加入行会
                PlayObject.m_boAllowGroup := False; //禁止组队
                PlayObject.m_boCanMasterRecall := False; //禁止师徒传送
                PlayObject.m_boCanDearRecall := False; //禁止夫妻传送
                  //PlayObject.m_boAllowGuildReCall := True; //禁止行会合一
                PlayObject.m_boAllowGroupReCall := False; //禁止天地合一

                PlayObject.m_boDecGameGold := False;
                PlayObject.m_nDecGameGold := 1;
                PlayObject.m_dwDecGameGoldTick := GetTickCount();
                PlayObject.m_dwDecGameGoldTime := 60 * 1000;

                PlayObject.m_boIncGameGold := False;
                PlayObject.m_nIncGameGold := 1;
                PlayObject.m_dwIncGameGoldTick := GetTickCount();
                PlayObject.m_dwIncGameGoldTime := 60 * 1000;

                PlayObject.m_dwIncGamePointTick := GetTickCount();

                PlayObject.m_nPayMentPoint := 0;

               {
                PlayObject.m_DearHuman := nil;
                PlayObject.m_MasterHuman := nil;
                PlayObject.m_MasterList := TList.Create;
                PlayObject.m_boSendMsgFlag := False;
                PlayObject.m_boChangeItemNameFlag := False;  }

                PlayObject.m_boCanMasterRecall := False;
                PlayObject.m_boCanDearRecall := False;
                PlayObject.m_dwDearRecallTick := GetTickCount();
                PlayObject.m_dwMasterRecallTick := GetTickCount();
                PlayObject.m_btReColorIdx := 0;
                PlayObject.m_GetWhisperHuman := nil;

                PlayObject.m_wContribution := 0;
                PlayObject.m_sRankLevelName := g_sRankLevelName;
                PlayObject.m_boFixedHideMode := True;
                PlayObject.m_nStep := 0;

                PlayObject.m_nClientFlagMode := -1;
                PlayObject.m_dwAutoGetExpTick := GetTickCount;
                PlayObject.m_nAutoGetExpPoint := 0;
                PlayObject.m_AutoGetExpEnvir := nil;

                {PlayObject.m_dwHitIntervalTime := g_Config.dwHitIntervalTime; //攻击间隔
                PlayObject.m_dwMagicHitIntervalTime := g_Config.dwMagicHitIntervalTime; //魔法间隔
                PlayObject.m_dwRunIntervalTime := g_Config.dwRunIntervalTime; //走路间隔
                PlayObject.m_dwWalkIntervalTime := g_Config.dwWalkIntervalTime; //走路间隔
                PlayObject.m_dwTurnIntervalTime := g_Config.dwTurnIntervalTime; //换方向间隔
                PlayObject.m_dwActionIntervalTime := g_Config.dwActionIntervalTime; //组合操作间隔
                PlayObject.m_dwRunLongHitIntervalTime := g_Config.dwRunLongHitIntervalTime; //组合操作间隔
                PlayObject.m_dwRunHitIntervalTime := g_Config.dwRunHitIntervalTime; //组合操作间隔
                PlayObject.m_dwWalkHitIntervalTime := g_Config.dwWalkHitIntervalTime; //组合操作间隔
                PlayObject.m_dwRunMagicIntervalTime := g_Config.dwRunMagicIntervalTime; //跑位魔法间隔}

                PlayObject.m_SessInfo := nil;
                PlayObject.m_boTestSpeedMode := False;
                PlayObject.m_boLockLogon := True;
                PlayObject.m_boLockLogoned := False;

                {PlayObject.m_boTimeGoto := False;
                PlayObject.m_dwTimeGotoTick := GetTickCount;
                PlayObject.m_sTimeGotoLable := '';
                PlayObject.m_TimeGotoNPC := nil;  }

                PlayObject.m_nDealGoldPose := 0;
                PlayObject.m_nScriptGotoCount := 0; //2006-11-12 叶随风飘 修正离线挂机在上线会有脚本死循环的错误
                PlayObject.m_MyGuild := g_GuildManager.MemberOfGuild(PlayObject.m_sCharName); //2006-12-10  增加脱机人物重新读取行会

                PlayObject.m_sIPaddr := GateUser.sIPaddr;
                PlayObject.m_nGSocketIdx := GateUser.nGSocketIdx;
                PlayObject.m_nGateIdx := GateIdx;
                PlayObject.m_nSocket := nSocket;
                PlayObject.m_nSessionID := nSessionID;
                PlayObject.m_nPayMent := nPayMent;
                PlayObject.m_nPayMode := nPayMode;
                PlayObject.m_boReadyRun := False;
                PlayObject.m_boHeroVersion := boHeroVersion;
                PlayObject.m_nSoftVersionDate := nClientVersion;

                PlayObject.m_sIPLocal := GetIPLocal(PlayObject.m_sIPaddr);
                PlayObject.m_nSoftVersionDateEx := GetExVersionNO(nClientVersion, PlayObject.m_nSoftVersionDate);

                GateUser.boCertification := True;
                GateUser.sAccount := Trim(sAccount);
                GateUser.sCharName := Trim(sChrName);
                GateUser.nSessionID := nSessionID;
                GateUser.nClientVersion := nClientVersion;
                GateUser.boHeroVersion := boHeroVersion;
                GateUser.SessInfo := SessInfo;

                SetGateUserList(PlayObject.m_nGateIdx, PlayObject.m_nSocket, PlayObject);
                //UserEngine.SendServerGroupMsg(SS_201, nServerIndex, PlayObject.m_sCharName);

                if Assigned(PlugInEngine.PlayObjectCreate) then begin
                  PlugInEngine.PlayObjectCreate(Self);
                end;
              end else begin //同一个账号不同人物
                PlayObject.m_boPlayOffLine := False;
                PlayObject.m_boNotOnlineAddExp := False;
                PlayObject.MakeGhost;

                //PlayObject.m_boReconnection := False;
                //PlayObject.m_boSoftClose := True;
                GateUser.boCertification := True;
                GateUser.sAccount := Trim(sAccount);
                GateUser.sCharName := Trim(sChrName);
                GateUser.nSessionID := nSessionID;
                GateUser.nClientVersion := nClientVersion;
                GateUser.boHeroVersion := boHeroVersion;
                GateUser.SessInfo := SessInfo;
                try
                  FrontEngine.AddToLoadRcdList(sAccount,
                    sChrName,
                    GateUser.sIPaddr,
                    boFlag,
                    nSessionID,
                    nPayMent,
                    nPayMode,
                    nClientVersion,
                    nSocket,
                    GateUser.nGSocketIdx,
                    GateIdx,
                    boHeroVersion);
                except
                  MainOutMessage(Format(sExceptionMsg, [nCheckCode]));
                end;
              end;
            end else begin
              //MainOutMessage('GetTickCount - SessInfo.dwMakeAccountTick:' + IntToStr(GetTickCount - SessInfo.dwMakeAccountTick));
              {MainOutMessage('GetTickCount:' + IntToStr(GetTickCount));
              MainOutMessage('SessInfo.dwMakeAccountTick:' + IntToStr(SessInfo.dwMakeAccountTick));}

              GateUser.boCertification := True;
              GateUser.sAccount := Trim(sAccount);
              GateUser.sCharName := Trim(sChrName);
              GateUser.nSessionID := nSessionID;
              GateUser.nClientVersion := nClientVersion;
              GateUser.boHeroVersion := boHeroVersion;
              GateUser.SessInfo := SessInfo;
              if GetTickCount - SessInfo.dwMakeAccountTick < g_Config.nLimitLoginTime * 1000 then begin
                MainOutMessage(Format(sRobotAttackMsg, [GateUser.sIPaddr, sAccount, sChrName, GetTickCount - SessInfo.dwMakeAccountTick]));
                UserEngine.AddIPToGateBlockList(GateUser.sIPaddr);
                GateUser.sAccount := sDisable;
                GateUser.boCertification := False;
                FrmIDSoc.SendHumanLogOutMsg(GateUser.sAccount, GateUser.nSessionID);
                CloseUser(GateIdx, nSocket);
                SendCloseOutConnectMsg(GateIdx, nSocket, GateUser.nGSocketIdx);
              end else begin
                try
                  FrontEngine.AddToLoadRcdList(sAccount,
                    sChrName,
                    GateUser.sIPaddr,
                    boFlag,
                    nSessionID,
                    nPayMent,
                    nPayMode,
                    nClientVersion,
                    nSocket,
                    GateUser.nGSocketIdx,
                    GateIdx,
                    boHeroVersion);
                except
                  MainOutMessage(Format(sExceptionMsg, [nCheckCode]));
                end;
              end;
            end;
          end else begin
            nCheckCode := 2;
            GateUser.sAccount := sDisable;
            GateUser.boCertification := False;
            CloseUser(GateIdx, nSocket);
            SendCloseOutConnectMsg(GateIdx, nSocket, GateUser.nGSocketIdx);
            nCheckCode := 3;
          end;
        end else begin
          nCheckCode := 4;
          GateUser.sAccount := sDisable;
          GateUser.boCertification := False;
          CloseUser(GateIdx, nSocket);
          SendCloseOutConnectMsg(GateIdx, nSocket, GateUser.nGSocketIdx);
        end;
      end;
    end;
  except
    MainOutMessage(Format(sExceptionMsg, [nCheckCode]));
  end;
end;

function TRunSocket.SendGateBuffers(GateIdx: Integer; Gate: pTGateInfo; MsgList: TList): Boolean;
var
  dwRunTick: LongWord;
  BufferA: PChar;
  BufferB: PChar;
  BufferC: PChar;
  I: Integer;
  nBuffALen: Integer;
  nBuffBLen: Integer;
  nBuffCLen: Integer;
  nSendBuffLen: Integer;
resourcestring
  sExceptionMsg1 = '[Exception] TRunSocket::SendGateBuffers -> ProcessBuff';
  sExceptionMsg2 = '[Exception] TRunSocket::SendGateBuffers -> SendBuff';
  sExceptionMsg3 = '游戏网关出现异常！';
begin
  Result := True;
  if MsgList.Count = 0 then Exit;
  dwRunTick := GetTickCount();
  //如果网关未回复状态消息，则不再发送数据
  {if GetTickCount - Gate.dwSendKeepAliveTick >= 1000 * 10 then begin
    Gate.dwSendKeepAliveTick := GetTickCount;
    for I := 0 to MsgList.Count - 1 do begin
      BufferA := MsgList.Items[I];
      FreeMem(BufferA);
    end;
    MsgList.Clear;
    MainOutMessage(sExceptionMsg3);
    Exit;
  end;}
  if Gate.nSendChecked > 0 then begin
    if (GetTickCount - Gate.dwSendCheckTick) > g_dwSocCheckTimeOut {2 * 1000} then begin
      Gate.nSendChecked := 0;
      Gate.nSendBlockCount := 0;
    end;
    Exit;
  end;

  //将小数据合并为一个指定大小的数据
{$IF CATEXCEPTION = TRYEXCEPTION}
  try
{$IFEND}
    I := 0;
    BufferA := MsgList.Items[I];
    while (True) do begin
      if (I + 1) >= MsgList.Count then Break;
      BufferB := MsgList.Items[I + 1];
      Move(BufferA^, nBuffALen, SizeOf(Integer));
      Move(BufferB^, nBuffBLen, SizeOf(Integer));
      if (nBuffALen + nBuffBLen) < g_Config.nSendBlock then begin
        MsgList.Delete(I + 1);
        GetMem(BufferC, nBuffALen + SizeOf(Integer) + nBuffBLen);
        nBuffCLen := nBuffALen + nBuffBLen;
        Move(nBuffCLen, BufferC^, SizeOf(Integer));
        Move(BufferA[SizeOf(Integer)], PChar(BufferC + SizeOf(Integer))^, nBuffALen);
        Move(BufferB[SizeOf(Integer)], PChar(BufferC + nBuffALen + SizeOf(Integer))^, nBuffBLen);
        FreeMem(BufferA);
        FreeMem(BufferB);
        BufferA := BufferC;
        MsgList.Items[I] := BufferA;
        Continue;
      end;
      Inc(I);
      BufferA := BufferB;
    end;
{$IF CATEXCEPTION = TRYEXCEPTION}
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg1);
      MainOutMessage(E.Message);
    end;
  end;
{$IFEND}

{$IF CATEXCEPTION = TRYEXCEPTION}
  try
{$IFEND}
    while MsgList.Count > 0 do begin
      BufferA := MsgList.Items[0];
      if BufferA = nil then begin
        MsgList.Delete(0);
        Continue;
      end;
      Move(BufferA^, nSendBuffLen, SizeOf(Integer));
      if (Gate.nSendChecked = 0) and ((Gate.nSendBlockCount + nSendBuffLen) >= g_Config.nCheckBlock) then begin
        if (Gate.nSendBlockCount = 0) and (g_Config.nCheckBlock <= nSendBuffLen) then begin
          MsgList.Delete(0); //如果数据大小超过指定大小则扔掉(编辑数据比较大，与此有点关系)
          FreeMem(BufferA);
        end else begin
          SendCheck(Gate.Socket, GM_RECEIVE_OK);
          Gate.nSendChecked := 1;
          Gate.dwSendCheckTick := GetTickCount();
        end;
        Break;
      end;
      MsgList.Delete(0);
      BufferB := BufferA + SizeOf(Integer);
      if nSendBuffLen > 0 then begin
        while (True) do begin
          if g_Config.nSendBlock <= nSendBuffLen then begin
            if Gate.Socket <> nil then begin
              if Gate.Socket.Connected then begin
                Gate.Socket.SendBuf(BufferB^, g_Config.nSendBlock);
              end;
              Inc(Gate.nSendCount);
              Inc(Gate.nSendBytesCount, g_Config.nSendBlock);
            end;
            Inc(Gate.nSendBlockCount, g_Config.nSendBlock);
            BufferB := @BufferB[g_Config.nSendBlock];
            Dec(nSendBuffLen, g_Config.nSendBlock);
            Continue;
          end;
          if Gate.Socket <> nil then begin
            if Gate.Socket.Connected then begin
              Gate.Socket.SendBuf(BufferB^, nSendBuffLen);
            end;
            Inc(Gate.nSendCount);
            Inc(Gate.nSendBytesCount, nSendBuffLen);
            Inc(Gate.nSendBlockCount, nSendBuffLen);
          end;
          nSendBuffLen := 0;
          Break;
        end;
      end;
      FreeMem(BufferA);
      if (GetTickCount - dwRunTick) > g_dwSocLimit then begin
        Result := False;
        Break;
      end;
    end;
{$IF CATEXCEPTION = TRYEXCEPTION}
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg2);
      MainOutMessage(E.Message);
    end;
  end;
{$IFEND}
end;

procedure TRunSocket.CloseUser(GateIdx, nSocket: Integer);
var
  I: Integer;
  GateUser: pTGateUserInfo;
  tStr: string;
  Gate: pTGateInfo;
resourcestring
  sExceptionMsg0 = '[Exception] TRunSocket::CloseUser 0';
  sExceptionMsg1 = '[Exception] TRunSocket::CloseUser 1';
  sExceptionMsg2 = '[Exception] TRunSocket::CloseUser 2';
  sExceptionMsg3 = '[Exception] TRunSocket::CloseUser 3';
  sExceptionMsg4 = '[Exception] TRunSocket::CloseUser 4';
begin
  if GateIdx <= High(g_GateArr) then begin
    Gate := @g_GateArr[GateIdx];
    if Gate.UserList <> nil then begin
      EnterCriticalSection(m_RunSocketSection);
      try
        try
          for I := 0 to Gate.UserList.Count - 1 do begin
            if Gate.UserList.Items[I] <> nil then begin
              GateUser := Gate.UserList.Items[I];
              if GateUser.nSocket = nSocket then begin
                try
                  if GateUser.FrontEngine <> nil then begin
                    TFrontEngine(GateUser.FrontEngine).DeleteHuman(I, GateUser.nSocket);
                  end;
                except
                  MainOutMessage(sExceptionMsg1);
                end;

                try
                  if TPlayObject(GateUser.PlayObject) <> nil then begin
                    TPlayObject(GateUser.PlayObject).m_boSoftClose := True;
                  end;
                except
                  MainOutMessage(sExceptionMsg2);
                end;

                try
                  if (GateUser.PlayObject <> nil) and (TPlayObject(GateUser.PlayObject).m_boGhost) and (not TPlayObject(GateUser.PlayObject).m_boReconnection) then begin
                    FrmIDSoc.SendHumanLogOutMsg(GateUser.sAccount, GateUser.nSessionID);
                  end;
                except
                  MainOutMessage(sExceptionMsg3);
                end;

                try
                  Dispose(GateUser);
                  Gate.UserList.Items[I] := nil;
                  Dec(Gate.nUserCount);
                except
                  MainOutMessage(sExceptionMsg4);
                end;
                Break;
              end;
            end;
          end;
        except
          MainOutMessage(sExceptionMsg0);
        end;
      finally
        LeaveCriticalSection(m_RunSocketSection);
      end;
    end;
  end;
end;

function TRunSocket.OpenNewUser(nSocket: Integer; nGSocketIdx: Integer; sIPaddr: string; UserList: TList): Integer; //004E0364
var
  GateUser: pTGateUserInfo;
  I: Integer;
begin
  New(GateUser);
  GateUser.sAccount := '';
  GateUser.sCharName := '';
  GateUser.sIPaddr := sIPaddr;
  GateUser.nSocket := nSocket;
  GateUser.nGSocketIdx := nGSocketIdx;
  GateUser.nSessionID := 0;
  GateUser.UserEngine := nil;
  GateUser.FrontEngine := nil;
  GateUser.PlayObject := nil;
  GateUser.dwNewUserTick := GetTickCount();
  GateUser.boCertification := False;
  for I := 0 to UserList.Count - 1 do begin
    if UserList.Items[I] = nil then begin
      UserList.Items[I] := GateUser;
      Result := I;
      Exit;
    end;
  end;
  //MainOutMessage('连接用户: ' + IntToStr(nSocket));
  UserList.Add(GateUser);
  Result := UserList.Count - 1;
end;

procedure TRunSocket.SendNewUserMsg(Socket: TCustomWinSocket; nSocket: Integer; nSocketIndex, nUserIdex: Integer);
var
  MsgHeader: TMsgHeader;
begin
  if not Socket.Connected then Exit;
  MsgHeader.dwCode := RUNGATECODE;
  MsgHeader.nSocket := nSocket;
  MsgHeader.wGSocketIdx := nSocketIndex;
  MsgHeader.wIdent := GM_SERVERUSERINDEX;
  MsgHeader.wUserListIndex := nUserIdex;
  MsgHeader.nLength := 0;
  if (Socket <> nil) and Socket.Connected then Socket.SendBuf(MsgHeader, SizeOf(TMsgHeader));
end;

procedure TRunSocket.ExecGateMsg(GateIdx: Integer; Gate: pTGateInfo; MsgHeader: pTMsgHeader; MsgBuff: PChar; nMsgLen: Integer);
var
  nCheckCode: Integer;
  nUserIdx: Integer;
  sIPaddr: string;
  GateUser: pTGateUserInfo;
  I: Integer;
resourcestring
  sExceptionMsg = '[Exception] TRunSocket::ExecGateMsg %d';
begin
  nCheckCode := 0;
  try
    case MsgHeader.wIdent of
      GM_OPEN {1}: begin
          nCheckCode := 1;
          sIPaddr := StrPas(MsgBuff);
          nUserIdx := OpenNewUser(MsgHeader.nSocket, MsgHeader.wGSocketIdx, sIPaddr, Gate.UserList);
          SendNewUserMsg(Gate.Socket, MsgHeader.nSocket, MsgHeader.wGSocketIdx, nUserIdx + 1);
          Inc(Gate.nUserCount);
        end;
      GM_CLOSE {2}: begin
          nCheckCode := 2;
          CloseUser(GateIdx, MsgHeader.nSocket);
        end;
      GM_CHECKCLIENT {4}: begin
          nCheckCode := 3;
          Gate.boSendKeepAlive := True;
          Gate.dwSendKeepAliveTick := GetTickCount;
        end;
      GM_RECEIVE_OK {7}: begin
          nCheckCode := 4;
          Gate.nSendChecked := 0;
          Gate.nSendBlockCount := 0;
        end;
      GM_DATA {5}: begin
          nCheckCode := 5;
          GateUser := nil;
          if MsgHeader.wUserListIndex >= 1 then begin
            nUserIdx := MsgHeader.wUserListIndex - 1;
            if Gate.UserList.Count > nUserIdx then begin
              GateUser := Gate.UserList.Items[nUserIdx];
              if (GateUser <> nil) and (GateUser.nSocket <> MsgHeader.nSocket) then begin
                GateUser := nil;
              end;
            end;
          end;
          if GateUser = nil then begin
            for I := 0 to Gate.UserList.Count - 1 do begin
              if Gate.UserList.Items[I] = nil then Continue;
              if pTGateUserInfo(Gate.UserList.Items[I]).nSocket = MsgHeader.nSocket then begin
                GateUser := Gate.UserList.Items[I];
                Break;
              end;
            end;
          end;

          nCheckCode := 6;
          if GateUser <> nil then begin
            if (GateUser.PlayObject <> nil) and (GateUser.UserEngine <> nil) then begin
              if GateUser.boCertification and (nMsgLen >= SizeOf(TDefaultMessage)) then begin
                if nMsgLen = SizeOf(TDefaultMessage) then begin
                  UserEngine.ProcessUserMessage(TPlayObject(GateUser.PlayObject), pTDefaultMessage(MsgBuff), nil)
                end else begin
                  UserEngine.ProcessUserMessage(TPlayObject(GateUser.PlayObject), pTDefaultMessage(MsgBuff), @MsgBuff[SizeOf(TDefaultMessage)]);
                end;
              end;
            end else begin
              if GetTickCount - GateUser.dwNewUserTick < 1000 * 20 then begin
                DoClientCertification(GateIdx, GateUser, MsgHeader.nSocket, StrPas(MsgBuff));
              end else begin //2007-01-21增加 20秒内没登陆成功踢下线
                CloseUser(GateIdx, MsgHeader.nSocket);
                SendOutConnectMsg(GateIdx, MsgHeader.nSocket, GateUser.nGSocketIdx);
                SendCloseOutConnectMsg(GateIdx, MsgHeader.nSocket, GateUser.nGSocketIdx);
              end;
            end;
          end;
        end;
    end;
  except
    MainOutMessage(Format(sExceptionMsg, [nCheckCode]));
  end;
end;

procedure TRunSocket.SendCheck(Socket: TCustomWinSocket; nIdent: Integer);
var
  MsgHeader: TMsgHeader;
begin
  if not Socket.Connected then Exit;
  MsgHeader.dwCode := RUNGATECODE;
  MsgHeader.nSocket := 0;
  MsgHeader.wIdent := nIdent;
  MsgHeader.nLength := 0;
  if Socket <> nil then
    Socket.SendBuf(MsgHeader, SizeOf(TMsgHeader));
end;

procedure TRunSocket.LoadRunAddr();
var
  sFileName: string;
begin
  sFileName := '.\RunAddr.txt';
  if FileExists(sFileName) then begin
    m_RunAddrList.LoadFromFile(sFileName);
    TrimStringList(m_RunAddrList);
  end;
end;

constructor TRunSocket.Create();
var
  I: Integer;
  Gate: pTGateInfo;
begin
  InitializeCriticalSection(m_RunSocketSection);
  m_RunAddrList := TStringList.Create;
  for I := Low(g_GateArr) to High(g_GateArr) do begin
    Gate := @g_GateArr[I];
    Gate.boUsed := False;
    Gate.Socket := nil;
    Gate.boSendKeepAlive := False;
    Gate.dwSendKeepAliveTick := GetTickCount;
    Gate.nSendMsgCount := 0;
    Gate.nSendRemainCount := 0;
    Gate.dwSendTick := GetTickCount();
    Gate.nSendMsgBytes := 0;
    Gate.nSendedMsgCount := 0;
  end;
  m_nErrorCount := 0;
  LoadRunAddr();
  n4F8 := 0;
end;

destructor TRunSocket.Destroy;
begin
  m_RunAddrList.Free;
  DeleteCriticalSection(m_RunSocketSection);
  inherited;
end;

function TRunSocket.AddGateBuffer(GateIdx: Integer; Buffer: PChar): Boolean;
var
  Gate: pTGateInfo;
begin
  Result := False;
  EnterCriticalSection(m_RunSocketSection);
  try
    if GateIdx < RUNGATEMAX then begin
      Gate := @g_GateArr[GateIdx];
      if (Gate.BufferList <> nil) and (Buffer <> nil) then begin
        if Gate.boUsed and (Gate.Socket <> nil) then begin
          Gate.BufferList.Add(Buffer);
          Result := True;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(m_RunSocketSection);
  end;
end;

procedure TRunSocket.SendOutConnectMsg(nGateIdx, nSocket, nGsIdx: Integer);
var
  DefMsg: TDefaultMessage;
  MsgHeader: TMsgHeader;
  nLen: Integer;
  Buff: PChar;
begin
  DefMsg := MakeDefaultMsg(SM_OUTOFCONNECTION, 0, 0, 0, 0);
  MsgHeader.dwCode := RUNGATECODE;
  MsgHeader.nSocket := nSocket;
  MsgHeader.wGSocketIdx := nGsIdx;
  MsgHeader.wIdent := GM_DATA;
  MsgHeader.nLength := SizeOf(TDefaultMessage);

  nLen := MsgHeader.nLength + SizeOf(TMsgHeader);
  GetMem(Buff, nLen + SizeOf(Integer));
  Move(nLen, Buff^, SizeOf(Integer));
  Move(MsgHeader, Buff[SizeOf(Integer)], SizeOf(TMsgHeader));
  Move(DefMsg, Buff[SizeOf(Integer) + SizeOf(TMsgHeader)], SizeOf(TDefaultMessage));
  if not AddGateBuffer(nGateIdx, Buff) then begin
    FreeMem(Buff);
  end;
end;

procedure TRunSocket.SendCloseOutConnectMsg(nGateIdx, nSocket, nGsIdx: Integer);
var
  MsgHeader: TMsgHeader;
  nLen: Integer;
  Buff: PChar;
begin
  MsgHeader.dwCode := RUNGATECODE;
  MsgHeader.nSocket := nSocket;
  MsgHeader.wGSocketIdx := nGsIdx;
  MsgHeader.wIdent := GM_CLOSEOUTCONNECT;
  MsgHeader.nLength := 0;
  nLen := SizeOf(TMsgHeader);
  GetMem(Buff, nLen + SizeOf(Integer));
  Move(nLen, Buff^, SizeOf(Integer));
  Move(MsgHeader, Buff[SizeOf(Integer)], SizeOf(TMsgHeader));
  if not AddGateBuffer(nGateIdx, Buff) then begin
    FreeMem(Buff);
  end;
end;

procedure TRunSocket.SendScanMsg(DefMsg: pTDefaultMessage; sMsg: string; nGateIdx, nSocket, nGsIdx: Integer);
var
  MsgHdr: TMsgHeader;
  nLen: Integer;
  Buff: PChar;
  nSendBytes: Integer;
begin
  MsgHdr.dwCode := RUNGATECODE;
  MsgHdr.nSocket := nSocket;
  MsgHdr.wGSocketIdx := nGsIdx;
  MsgHdr.wIdent := GM_DATA;
  MsgHdr.nLength := SizeOf(TDefaultMessage);

  if DefMsg <> nil then begin
    if sMsg <> '' then begin
      MsgHdr.nLength := Length(sMsg) + SizeOf(TDefaultMessage) + 1;
      nSendBytes := MsgHdr.nLength + SizeOf(TMsgHeader);
      GetMem(Buff, nSendBytes + SizeOf(Integer));
      Move(nSendBytes, Buff^, SizeOf(Integer));
      Move(MsgHdr, Buff[SizeOf(Integer)], SizeOf(TMsgHeader));
      Move(DefMsg^, Buff[SizeOf(TMsgHeader) + SizeOf(Integer)], SizeOf(TDefaultMessage));
      Move(sMsg[1], Buff[SizeOf(TDefaultMessage) + SizeOf(TMsgHeader) + SizeOf(Integer)], Length(sMsg) + 1);
    end else begin
      MsgHdr.nLength := SizeOf(TDefaultMessage);
      nSendBytes := MsgHdr.nLength + SizeOf(TMsgHeader);
      GetMem(Buff, nSendBytes + SizeOf(Integer));
      Move(nSendBytes, Buff^, SizeOf(Integer));
      Move(MsgHdr, Buff[SizeOf(Integer)], SizeOf(TMsgHeader));
      Move(DefMsg^, Buff[SizeOf(TMsgHeader) + SizeOf(Integer)], SizeOf(TDefaultMessage));
    end;
  end else begin
    if sMsg <> '' then begin
      MsgHdr.nLength := -(Length(sMsg) + 1);
      nSendBytes := abs(MsgHdr.nLength) + SizeOf(TMsgHeader);
      GetMem(Buff, nSendBytes + SizeOf(Integer));
      Move(nSendBytes, Buff^, SizeOf(Integer));
      Move(MsgHdr, Buff[SizeOf(Integer)], SizeOf(TMsgHeader));
      Move(sMsg[1], Buff[SizeOf(TMsgHeader) + SizeOf(Integer)], Length(sMsg) + 1);
    end;
  end;
  if not RunSocket.AddGateBuffer(nGateIdx, Buff) then begin
    FreeMem(Buff);
  end;
end;

procedure TRunSocket.SetGateUserList(nGateIdx, nSocket: Integer; PlayObject: TPlayObject);
var
  I: Integer;
  GateUserInfo: pTGateUserInfo;
  Gate: pTGateInfo;
begin
  if nGateIdx > High(g_GateArr) then Exit;
  Gate := @g_GateArr[nGateIdx];
  if Gate.UserList = nil then Exit;
  EnterCriticalSection(m_RunSocketSection);
  try
    for I := 0 to Gate.UserList.Count - 1 do begin
      GateUserInfo := Gate.UserList.Items[I];
      if (GateUserInfo <> nil) and (GateUserInfo.nSocket = nSocket) then begin
        GateUserInfo.FrontEngine := nil;
        GateUserInfo.UserEngine := UserEngine;
        GateUserInfo.PlayObject := PlayObject;
        Break;
      end;
    end;
  finally
    LeaveCriticalSection(m_RunSocketSection);
  end;
end;

procedure TRunSocket.SendGateTestMsg(nIndex: Integer);
var
  MsgHdr: TMsgHeader;
  Buff: PChar;
  nLen: Integer;
  DefMsg: TDefaultMessage;
begin
  MsgHdr.dwCode := RUNGATECODE;
  MsgHdr.nSocket := 0;
  MsgHdr.wIdent := GM_TEST;
  MsgHdr.nLength := 100;
  nLen := MsgHdr.nLength + SizeOf(TMsgHeader);
  GetMem(Buff, nLen + SizeOf(Integer));
  Move(nLen, Buff^, SizeOf(Integer));
  Move(MsgHdr, Buff[SizeOf(Integer)], SizeOf(TMsgHeader));
  Move(DefMsg, Buff[SizeOf(TMsgHeader) + SizeOf(Integer)], SizeOf(TDefaultMessage));
  if not AddGateBuffer(nIndex, Buff) then begin
    FreeMem(Buff);
    //MainOutMessage('SendGateTestMsg Buffer Fail ' + IntToStr(nIndex));
  end;
end;

procedure TRunSocket.KickUser(sAccount: string; nSessionID: Integer);
var
  I: Integer;
  II: Integer;
  GateUserInfo: pTGateUserInfo;
  Gate: pTGateInfo;
  nCheckCode: Integer;
  PlayObject: TPlayObject;
resourcestring
  sExceptionMsg = '[Exception] TRunSocket::KickUser CheckCode: %d';
  sKickUserMsg = '当前登录帐号正在其它位置登录，本机已被强行离线！！！';
begin
  try
    nCheckCode := 0;
    for I := Low(g_GateArr) to High(g_GateArr) do begin
      Gate := @g_GateArr[I];
      nCheckCode := 1;
      if Gate.boUsed and (Gate.Socket <> nil) and (Gate.UserList <> nil) then begin
        nCheckCode := 2;
        EnterCriticalSection(m_RunSocketSection);
        try
          nCheckCode := 3;
          for II := 0 to Gate.UserList.Count - 1 do begin
            nCheckCode := 4;
            GateUserInfo := Gate.UserList.Items[II];
            if GateUserInfo = nil then Continue;
            nCheckCode := 5;
            if (GateUserInfo.sAccount = sAccount) or (GateUserInfo.nSessionID = nSessionID) then begin
              nCheckCode := 6;

              if GateUserInfo.FrontEngine <> nil then begin
                nCheckCode := 7;
                TFrontEngine(GateUserInfo.FrontEngine).DeleteHuman(I, GateUserInfo.nSocket);
              end;
              nCheckCode := 8;
              if GateUserInfo.PlayObject <> nil then begin
                nCheckCode := 9;
                TPlayObject(GateUserInfo.PlayObject).SysMsg(sKickUserMsg, c_Red, t_Hint);
                TPlayObject(GateUserInfo.PlayObject).m_boEmergencyClose := True;
                TPlayObject(GateUserInfo.PlayObject).m_boSoftClose := True;
                TPlayObject(GateUserInfo.PlayObject).m_boPlayOffLine := False;
              end;
              nCheckCode := 10;
              Dispose(GateUserInfo);
              nCheckCode := 11;
              Gate.UserList.Items[II] := nil;
              nCheckCode := 12;
              Dec(Gate.nUserCount);
              Break;
            end;
          end;
          nCheckCode := 13;
        finally
          LeaveCriticalSection(m_RunSocketSection);
        end;
        nCheckCode := 14;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format(sExceptionMsg, [nCheckCode]));
      MainOutMessage(E.Message);
    end;
  end;
end;

function TRunSocket.GetGateAddr(sIPaddr: string): string;
var
  I: Integer;
begin
  Result := sIPaddr;
  for I := 0 to n8 - 1 do begin
    if m_IPaddrArr[I].sIPaddr = sIPaddr then begin
      Result := m_IPaddrArr[I].dIPaddr;
      Break;
    end;
  end;
end;

procedure TRunSocket.Execute;
begin
  Run;
 {if (nRunSocketRun >= 0) and Assigned(PlugProcArray[nRunSocketRun].nProcAddr) then begin
    TClassProc(PlugProcArray[nRunSocketRun].nProcAddr)(Self);
  end;}
end;

initialization
  (*begin
    AddToProcTable(@TRunSocket.Run, DeCodeString('QAEqWaIkTriaY>uNYRt') {'TRunSocket.Run'}, 119);
    nRunSocketRun := AddToPulgProcTable(DeCodeString('QAEqWaIkTriaY>uNYRt') {'TRunSocket.Run'}, 911);
  end; *)
finalization
  begin

  end;

end.

