unit LoginEngn;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JSocket, HUtil32, GateShare, EDcode, Grobal2;
type
  TUserObject = class
    m_boDisconnect: Boolean;
    m_boSendConnect: Boolean;
    m_sRemoteIPaddr: string;
    m_Socket: TCustomWinSocket;
    m_dwConnctCheckTick: LongWord;
    m_dwReviceMsgTick: LongWord;

    m_dwSendServerTick: LongWord;
    m_nReviceMsgLen: Integer;
    m_nSendMsgLen: Integer;

    m_btAttackType: Byte;
    m_boReviceMsg: Boolean;

    m_CS: TRTLCriticalSection;
    m_SendMsgList: TStringList;
    m_ReviceMsgList: TStringList;

    m_dwLastTick: LongWord;
    m_boCheckAttack: Boolean;
  private
    procedure SendServerMsg(Socket: TCustomWinSocket); //发送到账号服务器
    procedure SendClientMsg(); //发送到用户
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
    procedure Run;
  end;

  TUserEngine = class
    m_CS: TRTLCriticalSection;
    ClientSocket: TClientSocket;
    ServerSocket: TServerSocket;
    m_nHandle: Integer;
    m_nRunFlag: Integer;
    m_dwRunTick: LongWord;
    m_nRunTime: Integer;
    m_nMaxRunTime: Integer;
    m_dwCheckTime: LongWord;

    m_nProcIDx: Integer;
    m_sReceiveText: string;
    m_sBufferText: string;
    m_boTimerMainBusy: Boolean;

    m_boDBConnected: Boolean;
    m_boMsgConnected: Boolean;

    m_dwSendKeepAliveTick: LongWord;
    m_dwKeepAliveTick: LongWord;
    m_boKeepAliveTimcOut: Boolean;
    m_QuickUserList: TQuickUserList;
    m_UserList: TQuickUserList;
    m_FreeList: TGStringList;

    m_BlockIPList: TGStringList;
    m_nNewAccountCount: Integer;
    m_dwNewAccountTick: LongWord;
    m_dwClearBlockIPListTick: LongWord;
    m_dwStartServiceTick: LongWord;
    m_boStartService: Boolean;
    m_boCheckAttack: Boolean;
    m_boOldCheckAttack: Boolean;
    m_dwSendMsgSrverTick: LongWord;
    m_sMsgServerReceiveText: string;
    m_nAttackCount: Integer;
    m_dwLastAttackTick: LongWord;

    m_CCAttackIPList: TGStringList;
    procedure ServerSocketClientConnect(Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Socket: TCustomWinSocket);
    procedure ServerSocketClientError(Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ServerSocketClientRead(Socket: TCustomWinSocket);
  private
    { Private declarations }
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketConnecting(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);

    procedure SendServerText(sMsg: string);
    procedure ProcessServerData();
    procedure ProcessUserData();
    procedure ProcessNewAccount;
    procedure ClearBlockIPList;
    procedure Run;
    procedure Clear;
    function GetUserDataType(Msg: string): Integer;
    function CheckAttack(Msg: string; UserObject: TUserObject): Integer;
    function UpdateBlockIPList(UserObject: TUserObject): TObject; overload;
    function UpdateBlockIPList(sUserIpAddr: string): TObject; overload;

    function FoundCCAttackIP(AObject: TObject): TObject; overload;
    function FoundCCAttackIP(sUserIpAddr: string): TObject; overload;
    function UpdateCCAttackIPList(UserObject: TUserObject): TObject; overload;
    function UpdateCCAttackIPList(sUserIpAddr: string): TObject; overload;
  protected

  public
    constructor Create();
    destructor Destroy; override;
    procedure Execute;
    procedure Lock;
    procedure UnLock;

    function Found(UserObject: TUserObject): TUserObject;
    function FoundBlockIP(sUserIpAddr: string): TObject; overload;
    function FoundBlockIP(AObject: TObject): TObject; overload;
    function CloseSocket(nUserObject: Integer): TUserObject; overload;
    function CloseSocket(AObject: TUserObject): string; overload;

    procedure ConnectDBServer();
    procedure DisconnectDBServer();
    function DBConnected: Boolean;

    function UserCount: Integer;
    function FreeCount: Integer;
  end;

implementation
uses Share;

constructor TUserObject.Create;
begin
  inherited;
  InitializeCriticalSection(m_CS);
  m_boSendConnect := False;
  m_boDisconnect := False;
  m_boReviceMsg := False;
  m_Socket := nil;
  m_sRemoteIPaddr := '';
  m_dwConnctCheckTick := GetTickCount;
  m_dwReviceMsgTick := GetTickCount;
  m_dwSendServerTick := GetTickCount;
  m_nReviceMsgLen := 0;
  m_nSendMsgLen := 0;
  m_btAttackType := 0;
  m_SendMsgList := TStringList.Create;
  m_ReviceMsgList := TStringList.Create;
  m_dwLastTick := GetTickCount;
  m_boCheckAttack := True;
end;

destructor TUserObject.Destroy;
begin
  m_SendMsgList.Free;
  m_ReviceMsgList.Free;
  DeleteCriticalSection(m_CS);
  inherited;
end;

procedure TUserObject.Lock;
begin
  EnterCriticalSection(m_CS);
end;

procedure TUserObject.UnLock;
begin
  LeaveCriticalSection(m_CS);
end;

procedure TUserObject.Run;
begin

end;

procedure TUserObject.SendServerMsg(Socket: TCustomWinSocket); //发送到账号服务器
var
  dwSendTick: LongWord;
  sReviceMsg: string;
  s10, s1C: string;
  nPos: Integer;
begin
  if m_boSendConnect then begin
    if (not m_boDisconnect) and (m_Socket <> nil) and (m_Socket.Connected) and (Socket <> nil) and (Socket.Connected) then begin
      dwSendTick := GetTickCount + 5;
      while True do begin
        if GetTickCount > dwSendTick then Break; //超时退出 暂停发送 等待下次发送
        if m_ReviceMsgList.Count <= 0 then Break;
        if m_boDisconnect then Break;
        sReviceMsg := m_ReviceMsgList.Strings[0];
        m_ReviceMsgList.Delete(0);
        nPos := Pos('*', sReviceMsg);
        if nPos > 0 then begin
          s10 := Copy(sReviceMsg, 1, nPos - 1);
          s1C := Copy(sReviceMsg, nPos + 1, Length(sReviceMsg) - nPos);
          sReviceMsg := s10 + s1C;
        end;
        Inc(m_nReviceMsgLen, Length(sReviceMsg));
        if (Socket <> nil) and Socket.Connected then begin
          Socket.SendText('%D' + IntToStr(Integer(Self)) + '/' + sReviceMsg + '$');
        end;
      end;
    end else begin
      m_ReviceMsgList.Clear;
    end;
  end;
end;

procedure TUserObject.SendClientMsg(); //发送到用户
var
  dwSendTick: LongWord;
  sSendMsg: string;
begin
  if m_boSendConnect then begin
    if (not m_boDisconnect) and (m_Socket <> nil) and (m_Socket.Connected) then begin
      dwSendTick := GetTickCount + 5;
      while True do begin
        if GetTickCount > dwSendTick then Break; //超时退出 暂停发送 等待下次发送
        if m_SendMsgList.Count <= 0 then Break;
        if m_boDisconnect then Break;
        sSendMsg := m_SendMsgList.Strings[0];
        m_SendMsgList.Delete(0);
        m_Socket.SendText(sSendMsg);
        Inc(m_nSendMsgLen, Length(sSendMsg));
      end;
    end else begin
      m_SendMsgList.Clear;
    end;
  end;
end;

constructor TUserEngine.Create();
begin
  InitializeCriticalSection(m_CS);
  ClientSocket := TClientSocket.Create(nil);
  ClientSocket.OnConnecting := ClientSocketConnecting;
  ClientSocket.OnConnect := ClientSocketConnect;
  ClientSocket.OnDisconnect := ClientSocketDisconnect;
  ClientSocket.OnRead := ClientSocketRead;
  ClientSocket.OnError := ClientSocketError;

  ServerSocket := nil;
  m_nProcIDx := 0;
  m_sReceiveText := '';
  m_sBufferText := '';
  m_boTimerMainBusy := False;
  m_nRunFlag := 0;
  m_dwRunTick := GetTickCount();
  m_nRunTime := 0;
  m_nMaxRunTime := 20;
  m_dwCheckTime := GetTickCount();
  m_dwSendKeepAliveTick := GetTickCount();
  m_dwKeepAliveTick := GetTickCount();
  m_boKeepAliveTimcOut := False;
  m_boDBConnected := False;
  m_boMsgConnected := False;
  m_QuickUserList := TQuickUserList.Create;
  m_UserList := TQuickUserList.Create;
  m_FreeList := TGStringList.Create;

  m_BlockIPList := TGStringList.Create;
  m_nNewAccountCount := 0;
  m_dwNewAccountTick := GetTickCount();
  m_dwClearBlockIPListTick := GetTickCount();
  m_dwStartServiceTick := GetTickCount();
  m_boStartService := False;
  m_boCheckAttack := False;
  m_boOldCheckAttack := False;
  m_dwSendMsgSrverTick := GetTickCount();
  m_sMsgServerReceiveText := '';
  m_nAttackCount := 0;
  m_dwLastAttackTick := GetTickCount();
  m_nHandle := Integer(Self);
  m_CCAttackIPList := TGStringList.Create;
end;

destructor TUserEngine.Destroy;
var
  I: Integer;
begin
  ClientSocket.Active := False;
  Clear;
  m_QuickUserList.Free;
  m_UserList.Free;
  m_FreeList.Free;

  ClientSocket.Free;
  m_BlockIPList.Free;
  m_CCAttackIPList.Free;
  DeleteCriticalSection(m_CS);
  inherited;
end;

procedure TUserEngine.Lock;
begin
  EnterCriticalSection(m_CS);
end;

procedure TUserEngine.UnLock;
begin
  LeaveCriticalSection(m_CS);
end;

procedure TUserEngine.ConnectDBServer();
begin
  ClientSocket.Active := False;
  ClientSocket.Host := g_Config.ServerAddr;
  ClientSocket.Port := g_Config.ServerPort;
  ClientSocket.Active := True;
end;

function TUserEngine.DBConnected: Boolean;
begin
  Result := m_boDBConnected;
end;

procedure TUserEngine.DisconnectDBServer();
begin
  ClientSocket.Active := False;
end;

function TUserEngine.UserCount: Integer;
begin
  Result := m_UserList.Count;
end;

function TUserEngine.FreeCount: Integer;
begin
  Result := m_FreeList.Count;
end;

procedure TUserEngine.Clear;
var
  I: Integer;
begin
  Lock;
  try
    for I := 0 to m_UserList.Count - 1 do begin
      TUserObject(m_UserList.Objects[I]).Free;
    end;
    for I := 0 to m_FreeList.Count - 1 do begin
      TUserObject(m_FreeList.Objects[I]).Free;
    end;
    for I := 0 to m_QuickUserList.Count - 1 do begin
      TList(m_QuickUserList.Objects[I]).Free;
    end;
    for I := 0 to m_BlockIPList.Count - 1 do begin
      Dispose(pTBlockIP(m_BlockIPList.Objects[I]));
    end;
    for I := 0 to m_CCAttackIPList.Count - 1 do begin
      Dispose(pTBlockIP(m_CCAttackIPList.Objects[I]));
    end;
    m_dwStartServiceTick := GetTickCount();
    m_boStartService := False;
    m_QuickUserList.Clear;
    m_UserList.Clear;
    m_FreeList.Clear;
    m_nProcIDx := 0;
    m_sReceiveText := '';
    m_sBufferText := '';
    m_boTimerMainBusy := False;
    m_BlockIPList.Clear;
    m_CCAttackIPList.Clear;
  finally
    UnLock;
  end;
end;

procedure TUserEngine.Execute;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::Run';
begin
  try
    Run;
  except
    MainOutMessage(sExceptionMsg, nil);
  end;
end;

function TUserEngine.CloseSocket(AObject: TUserObject): string;
var
  UserObject: TUserObject;
begin
  Result := '';
  UserObject := Found(AObject);
  if UserObject <> nil then begin
    Result := UserObject.m_sRemoteIPaddr;
    if (UserObject.m_Socket <> nil) and UserObject.m_Socket.Connected then begin
      UserObject.m_Socket.Close;
    end;
    UserObject.m_boDisconnect := True;
  end;
end;

function TUserEngine.CloseSocket(nUserObject: Integer): TUserObject;
begin
  Result := Found(TUserObject(nUserObject));
  if Result <> nil then begin
    if (Result.m_Socket <> nil) and Result.m_Socket.Connected then begin
      Result.m_Socket.Close;
    end;
    Result.m_boDisconnect := True;
  end;
end;

procedure TUserEngine.SendServerText(sMsg: string);
begin
  if (ClientSocket <> nil) and ClientSocket.Socket.Connected then begin
    ClientSocket.Socket.SendText(sMsg);
  end;
end;

procedure TUserEngine.ProcessServerData();
var
  sSocketMsg: string;
  UserObject: TUserObject;
  sUserObject: string;
  sUserIpAddr: string;
  nUserObject: Integer;
  dwCheckTime: LongWord;
begin
  if m_boTimerMainBusy then Exit;
  m_boTimerMainBusy := True;
  try
    UserObject := nil;
    dwCheckTime := GetTickCount() + 10;
    m_sBufferText := m_sBufferText + m_sReceiveText;
    m_sReceiveText := '';
    while (True) do begin
      if m_sBufferText = '' then Break;
      if GetTickCount > dwCheckTime then Break;
      if Length(m_sBufferText) < 2 then Break;
      if Pos('$', m_sBufferText) <= 0 then Break;
      if GetTickCount > dwCheckTime then Break;
      sSocketMsg := '';
      m_sBufferText := ArrestStringEx(m_sBufferText, '%', '$', sSocketMsg);
      if sSocketMsg = '' then Continue;
      if sSocketMsg[1] = '+' then begin
        case sSocketMsg[2] of
          '-': begin
              sUserObject := Copy(sSocketMsg, 3, Length(sSocketMsg) - 2);
              nUserObject := Str_ToInt(sUserObject, 0);
              CloseSocket(nUserObject);
              Continue;
            end;
          'B': begin
              sUserObject := Copy(sSocketMsg, 3, Length(sSocketMsg) - 2);
              nUserObject := Str_ToInt(sUserObject, 0);
              sUserIpAddr := CloseSocket(TUserObject(nUserObject));
              if sUserIpAddr <> '' then UpdateBlockIPList(sUserIpAddr);
              m_dwKeepAliveTick := GetTickCount();
              m_boKeepAliveTimcOut := False;
              Continue;
            end;
          'T': begin
              sUserObject := Copy(sSocketMsg, 3, Length(sSocketMsg) - 2);
              nUserObject := Str_ToInt(sUserObject, 0);
              sUserIpAddr := CloseSocket(TUserObject(nUserObject));
              if sUserIpAddr <> '' then UpdateBlockIPList(sUserIpAddr);
              m_dwKeepAliveTick := GetTickCount();
              m_boKeepAliveTimcOut := False;
              Continue;
            end;
          'M': begin
              sUserIpAddr := Copy(sSocketMsg, 3, Length(sSocketMsg) - 2);
              AddBlockIP(sUserIpAddr);
            end;
        else begin
            m_dwKeepAliveTick := GetTickCount();
            m_boKeepAliveTimcOut := False;
            dwCheckTime := GetTickCount() + 10;
              //MainOutMessage('m_dwKeepAliveTick := GetTickCount()', nil);
            Continue;
          end;
        end;
      end;

      sSocketMsg := GetValidStr3(sSocketMsg, sUserObject, ['/']);
      nUserObject := Str_ToInt(sUserObject, 0);
      if nUserObject = 0 then Continue;
      //UserObject := Found(TUserObject(nUserObject));
      UserObject := TUserObject(nUserObject);
      if (UserObject <> nil) and (not UserObject.m_boDisconnect) and (UserObject.m_Socket <> nil) and (UserObject.m_Socket.Connected) then begin
        UserObject.m_SendMsgList.Add(sSocketMsg);
      end else begin
        Continue;
      end;
    end; // while (True) do begin

    if (GetTickCount - m_dwSendKeepAliveTick) > 2 * 1000 then begin
      m_dwSendKeepAliveTick := GetTickCount();
      SendServerText('%--$');
    end;

    if (GetTickCount - m_dwKeepAliveTick) > 10 * 1000 then begin
      m_boKeepAliveTimcOut := True;
      if ClientSocket <> nil then ClientSocket.Close;
    end;
  finally
    m_boTimerMainBusy := False;
  end;
end;

procedure TUserEngine.ProcessUserData();
  function GetLastConnected(UserList: TList): TUserObject; //获取同一个IP最后一个连接用户
  var
    UserObject: TUserObject;
    UserObjectA: TUserObject;
    dwConnectTick: LongWord;
    I: Integer;
  begin
    dwConnectTick := 0;
    UserObjectA := nil;
    for I := 0 to UserList.Count - 1 do begin
      UserObject := TUserObject(UserList.Items[I]);
      if UserObject.m_dwConnctCheckTick > dwConnectTick then begin
        dwConnectTick := UserObject.m_dwConnctCheckTick;
        UserObjectA := UserObject;
      end;
    end;
    Result := UserObjectA;
  end;
var
  nIndex, nIdx, nCount: Integer;
  dwCheckTime: LongWord;
  boCheckTimeLimit: Boolean;
  UserObject: TUserObject;
  UserObjectA: TUserObject;
  UserObjectB: TUserObject;
  BlockIP: pTBlockIP;
  AObject: TObject;
  sRemoteIPaddr: string;
  UserList: TList;
  I: Integer;
begin
  UserObject := nil;
  UserObjectA := nil;
  nIndex := 0;
  m_nRunFlag := 7;
  dwCheckTime := GetTickCount();
  try
    while True do begin //释放
      if (nIndex >= m_FreeList.Count) or (nIndex >= 10) then Break;
      UserObject := TUserObject(m_FreeList.Objects[nIndex]);
      UserObject.Lock;
      try
        m_nRunFlag := 70;
        if (UserObject.m_Socket <> nil) and UserObject.m_Socket.Connected then begin
          UserObject.m_Socket.Close;
        end;
        m_nRunFlag := 71;
        if UserObject.m_boSendConnect then begin
          SendServerText('%C' + IntToStr(Integer(UserObject)) + '$');
        end;
        m_nRunFlag := 72;
      finally
        UserObject.UnLock;
      end;
      UserObject.Free;
      m_FreeList.Delete(nIndex);
      Inc(nIndex);
    end;
  except
    MainOutMessage('TUserEngine::ProcessUserData1 ' + IntToStr(m_nRunFlag), nil);
  end;
  m_nRunFlag := 8;

  Lock;
  try
    nIdx := -1;
    UserObject := nil;
    UserObjectA := nil;
    nIndex := m_nProcIDx;
    m_dwCheckTime := GetTickCount();
    boCheckTimeLimit := False;
    try
      while True do begin
        m_nRunFlag := 9;
        if nIndex >= m_UserList.Count then Break;
        {if (GetTickCount - m_dwCheckTime) > m_nMaxRunTime then begin
          boCheckTimeLimit := True;
          m_nProcIDx := nIndex;
          Break;
        end; }
        UserObject := TUserObject(m_UserList.Objects[nIndex]);
        //if not UserObject.m_boCheckAttack then begin
          //UserObject.m_boCheckAttack := True;
        BlockIP := IsBlockIP(UserObject.m_sRemoteIPaddr);
        if BlockIP <> nil then begin
          Inc(BlockIP.nAttackCount);
          if (UserObject.m_Socket <> nil) and UserObject.m_Socket.Connected then begin
            UserObject.m_Socket.Close;
          end;
          UserObject.m_boDisconnect := True;
          nIdx := m_QuickUserList.GetUserList(UserObject.m_sRemoteIPaddr, UserList);
          m_QuickUserList.DelRecord(nIdx, UserObject);
          m_UserList.Delete(nIndex);
          m_FreeList.AddObject(UserObject.m_sRemoteIPaddr, UserObject);
          MainOutMessage('过滤连接: ' + UserObject.m_sRemoteIPaddr, TObject(BlockIP));
          //Inc(nIndex);
          Continue;
        end;

        m_nRunFlag := 10;
        AObject := FoundBlockIP(UserObject.m_sRemoteIPaddr);
        if AObject <> nil then begin
          BlockIP := pTBlockIP(AObject);
          Inc(BlockIP.nAttackCount);
          BlockIP.dwUpDateTick := GetTickCount;
          if (UserObject.m_Socket <> nil) and UserObject.m_Socket.Connected then begin
            UserObject.m_Socket.Close;
          end;
          UserObject.m_boDisconnect := True;
          nIdx := m_QuickUserList.GetUserList(UserObject.m_sRemoteIPaddr, UserList);
          m_QuickUserList.DelRecord(nIdx, UserObject);
          m_UserList.Delete(nIndex);
          m_FreeList.AddObject(UserObject.m_sRemoteIPaddr, UserObject);
          MainOutMessage('过滤连接: ' + UserObject.m_sRemoteIPaddr, TObject(BlockIP));
          //Inc(nIndex);
          Continue;
        end;
        //end;

        m_nRunFlag := 11;
        if not UserObject.m_boDisconnect then begin
          if not UserObject.m_boSendConnect then begin //发送连接信息
            nIdx := m_QuickUserList.GetUserList(UserObject.m_sRemoteIPaddr, UserList);
            if (nIdx >= 0) and (UserList <> nil) then begin
              m_nRunFlag := 12;
              if UserList.Count > g_Config.nMaxConnOfIPaddr then begin //单IP超过限制
                m_nRunFlag := 13;
                UserObject.m_boDisconnect := True;
                m_QuickUserList.DelRecord(nIdx, UserObject);
                m_UserList.Delete(nIndex);
                m_FreeList.AddObject(UserObject.m_sRemoteIPaddr, UserObject);
                //Inc(nIndex);
                Continue;
              end;
              if not UserObject.m_boCheckAttack then begin
                UserObject.m_boCheckAttack := True;
                if m_boCheckAttack then begin
                  m_nRunFlag := 16;
                  AObject := UpdateCCAttackIPList(UserObject); {CC攻击检测}
                  m_nRunFlag := 17;
                  BlockIP := pTBlockIP(AObject);
                  if BlockIP <> nil then begin
                    if (BlockIP.dwUpDateTick <> 0) and (UserObject.m_dwConnctCheckTick > BlockIP.dwUpDateTick) and (UserObject.m_dwConnctCheckTick - BlockIP.dwUpDateTick < g_Config.nConnctCheckTime) then begin //CC攻击
                      BlockIP.dwUpDateTick := UserObject.m_dwConnctCheckTick;
                      Inc(BlockIP.nAttackCount);
                      m_nRunFlag := 18;
                      m_nRunFlag := 19;
                      UserObject.m_boDisconnect := True;
                      if BlockIP.nAttackCount >= 5 then UpdateBlockIPList(UserObject);
                      m_nRunFlag := 20;
                      nIdx := m_QuickUserList.GetUserList(UserObject.m_sRemoteIPaddr, UserList);
                      m_QuickUserList.DelRecord(nIdx, UserObject);
                      m_UserList.Delete(nIndex);
                      m_FreeList.AddObject(UserObject.m_sRemoteIPaddr, UserObject);
                      m_nRunFlag := 21;
                      MainOutMessage('CC攻击: ' + UserObject.m_sRemoteIPaddr, TObject(BlockIP));
                    //Inc(nIndex);
                      Continue;
                    end;
                    BlockIP.dwUpDateTick := UserObject.m_dwConnctCheckTick;
                    m_nRunFlag := 22;
                  end;
                end;
              end;

              if GetTickCount - UserObject.m_dwConnctCheckTick > g_Config.dwKeepConnectTimeOut then begin //空连接
                m_nRunFlag := 23;
                m_nRunFlag := 24;
                UserObject.m_boDisconnect := True;
                UserObject.m_btAttackType := 6;
                m_QuickUserList.DelRecord(nIdx, UserObject);
                m_UserList.Delete(nIndex);
                m_FreeList.AddObject(UserObject.m_sRemoteIPaddr, UserObject);
                //Inc(nIndex);
                m_nRunFlag := 25;
                Continue;
              end;
              m_nRunFlag := 26;
              //if GetTickCount - UserObject.m_dwConnctCheckTick > 1000 then begin
              //if UserObject.m_boReviceMsg then begin
              UserObject.m_boSendConnect := True;
              SendServerText('%N' + IntToStr(Integer(UserObject)) + '/' + UserObject.m_sRemoteIPaddr + '/' + UserObject.m_sRemoteIPaddr + '$');
              Inc(nIndex);
              Continue;
              //end;
            end;
          end else begin //if not UserObject.m_boSendConnect then begin
            m_nRunFlag := 27;
            if GetTickCount - UserObject.m_dwConnctCheckTick > g_Config.dwKeepConnectTimeOut then begin //空连接
              m_nRunFlag := 28;
              UserObject.m_boDisconnect := True;
              UserObject.m_btAttackType := 6;
              m_QuickUserList.DelRecord(nIdx, UserObject);
              m_UserList.Delete(nIndex);
              m_FreeList.AddObject(UserObject.m_sRemoteIPaddr, UserObject);
              //Inc(nIndex);
              m_nRunFlag := 29;
              Continue;
            end;
            UserObject.Lock;
            try
              if UserObject.m_boSendConnect then begin
                m_nRunFlag := 30;
                UserObject.SendServerMsg(ClientSocket.Socket);
                m_nRunFlag := 31;
                UserObject.SendClientMsg;
                m_nRunFlag := 32;
              end;
            finally
              UserObject.UnLock;
            end;
            m_nRunFlag := 33;
          end;
        end else begin //已经断开
          m_nRunFlag := 34;
          nIdx := m_QuickUserList.GetUserList(UserObject.m_sRemoteIPaddr, UserList);
          m_QuickUserList.DelRecord(nIdx, UserObject);
          m_UserList.Delete(nIndex);
          m_nRunFlag := 35;
          m_FreeList.AddObject(UserObject.m_sRemoteIPaddr, UserObject);
        end;
        m_nRunFlag := 36;
        Inc(nIndex);
        if (GetTickCount - m_dwCheckTime) > m_nMaxRunTime then begin
          boCheckTimeLimit := True;
          m_nProcIDx := nIndex;
          Break;
        end;
      end; //while True do begin
    except
      MainOutMessage('TUserEngine::ProcessUserData2 ' + IntToStr(m_nRunFlag), nil);
    end;
    if not boCheckTimeLimit then m_nProcIDx := 0;
  finally
    UnLock;
  end;
end;

function TUserEngine.FoundBlockIP(AObject: TObject): TObject;
var
  I: Integer;
begin
  Result := nil;
  m_BlockIPList.Lock;
  try
    for I := 0 to m_BlockIPList.Count - 1 do begin
      if m_BlockIPList.Objects[I] = AObject then begin
        Result := m_BlockIPList.Objects[I];
        Break;
      end;
    end;
  finally
    m_BlockIPList.UnLock;
  end;
end;

function TUserEngine.FoundBlockIP(sUserIpAddr: string): TObject;
var
  I: Integer;
begin
  Result := nil;
  m_BlockIPList.Lock;
  try
    for I := 0 to m_BlockIPList.Count - 1 do begin
      if m_BlockIPList.Strings[I] = sUserIpAddr then begin
        Result := m_BlockIPList.Objects[I];
        Break;
      end;
    end;
  finally
    m_BlockIPList.UnLock;
  end;
end;

function TUserEngine.UpdateBlockIPList(sUserIpAddr: string): TObject;
var
  I: Integer;
  BlockIP: pTBlockIP;
  boFound: Boolean;
begin
  Result := nil;
  boFound := False;
  m_BlockIPList.Lock;
  try
    for I := 0 to m_BlockIPList.Count - 1 do begin
      if m_BlockIPList.Strings[I] = sUserIpAddr then begin
        Inc(pTBlockIP(m_BlockIPList.Objects[I]).nAttackCount);
        pTBlockIP(m_BlockIPList.Objects[I]).dwUpDateTick := GetTickCount;
        Result := m_BlockIPList.Objects[I];
        boFound := True;
        Break;
      end;
    end;
    MemLock;
    try
      if not boFound then begin
        New(BlockIP);
        BlockIP.sUserIpAddr := sUserIpAddr;
        BlockIP.btAttackType := 5;
        BlockIP.nAttackCount := 1;
        BlockIP.dwAddTick := GetTickCount;
        BlockIP.dwUpDateTick := GetTickCount;
        m_BlockIPList.AddObject(sUserIpAddr, TObject(BlockIP));
        Result := TObject(BlockIP);
      end;
    finally
      MemUnLock;
    end;
  finally
    m_BlockIPList.UnLock;
  end;
end;

function TUserEngine.UpdateBlockIPList(UserObject: TUserObject): TObject;
var
  I: Integer;
  BlockIP: pTBlockIP;
  boFound: Boolean;
begin
  Result := nil;
  boFound := False;
  m_BlockIPList.Lock;
  try
    for I := 0 to m_BlockIPList.Count - 1 do begin
      if m_BlockIPList.Strings[I] = UserObject.m_sRemoteIPaddr then begin
        Inc(pTBlockIP(m_BlockIPList.Objects[I]).nAttackCount);
        pTBlockIP(m_BlockIPList.Objects[I]).dwUpDateTick := GetTickCount;
        Result := m_BlockIPList.Objects[I];
        boFound := True;
        Break;
      end;
    end;
    MemLock;
    try
      if not boFound then begin
        New(BlockIP);
        BlockIP.sUserIpAddr := UserObject.m_sRemoteIPaddr;
        BlockIP.btAttackType := UserObject.m_btAttackType;
        BlockIP.nAttackCount := 5;
        BlockIP.dwAddTick := GetTickCount;
        BlockIP.dwUpDateTick := GetTickCount;
        m_BlockIPList.AddObject(UserObject.m_sRemoteIPaddr, TObject(BlockIP));
        Result := TObject(BlockIP);
      end;
    finally
      MemUnLock;
    end;
  finally
    m_BlockIPList.UnLock;
  end;
end;

function TUserEngine.FoundCCAttackIP(AObject: TObject): TObject;
var
  I: Integer;
begin
  Result := nil;
  m_CCAttackIPList.Lock;
  try
    for I := 0 to m_CCAttackIPList.Count - 1 do begin
      if m_CCAttackIPList.Objects[I] = AObject then begin
        Result := m_CCAttackIPList.Objects[I];
        Break;
      end;
    end;
  finally
    m_CCAttackIPList.UnLock;
  end;
end;

function TUserEngine.FoundCCAttackIP(sUserIpAddr: string): TObject;
var
  I: Integer;
begin
  Result := nil;
  m_CCAttackIPList.Lock;
  try
    for I := 0 to m_CCAttackIPList.Count - 1 do begin
      if m_CCAttackIPList.Strings[I] = sUserIpAddr then begin
        Result := m_CCAttackIPList.Objects[I];
        Break;
      end;
    end;
  finally
    m_CCAttackIPList.UnLock;
  end;
end;

function TUserEngine.UpdateCCAttackIPList(sUserIpAddr: string): TObject;
var
  I: Integer;
  BlockIP: pTBlockIP;
  boFound: Boolean;
begin
  Result := nil;
  boFound := False;
  m_CCAttackIPList.Lock;
  try
    for I := 0 to m_CCAttackIPList.Count - 1 do begin
      if m_CCAttackIPList.Strings[I] = sUserIpAddr then begin
        Result := m_CCAttackIPList.Objects[I];
        boFound := True;
        Break;
      end;
    end;
    MemLock;
    try
      if not boFound then begin
        New(BlockIP);
        BlockIP.sUserIpAddr := sUserIpAddr;
        BlockIP.btAttackType := 5;
        BlockIP.nAttackCount := 0;
        BlockIP.dwAddTick := GetTickCount;
        BlockIP.dwUpDateTick := 0;
        m_CCAttackIPList.AddObject(sUserIpAddr, TObject(BlockIP));
        Result := TObject(BlockIP);
      end;
    finally
      MemUnLock;
    end;
  finally
    m_CCAttackIPList.UnLock;
  end;
end;

function TUserEngine.UpdateCCAttackIPList(UserObject: TUserObject): TObject;
var
  I: Integer;
  BlockIP: pTBlockIP;
  boFound: Boolean;
begin
  Result := nil;
  boFound := False;
  m_CCAttackIPList.Lock;
  try
    for I := 0 to m_CCAttackIPList.Count - 1 do begin
      if m_CCAttackIPList.Strings[I] = UserObject.m_sRemoteIPaddr then begin
        Result := m_CCAttackIPList.Objects[I];
        boFound := True;
        Break;
      end;
    end;
    MemLock;
    try
      if not boFound then begin
        New(BlockIP);
        BlockIP.sUserIpAddr := UserObject.m_sRemoteIPaddr;
        BlockIP.btAttackType := UserObject.m_btAttackType;
        BlockIP.nAttackCount := 0;
        BlockIP.dwAddTick := GetTickCount;
        BlockIP.dwUpDateTick := 0;
        m_CCAttackIPList.AddObject(UserObject.m_sRemoteIPaddr, TObject(BlockIP));
        Result := TObject(BlockIP);
      end;
    finally
      MemUnLock;
    end;
  finally
    m_CCAttackIPList.UnLock;
  end;
end;

procedure TUserEngine.ProcessNewAccount;
begin

end;

procedure TUserEngine.ClearBlockIPList;
var
  nIndex: Integer;
  BlockIP: pTBlockIP;
begin
  if GetTickCount() - m_dwClearBlockIPListTick > 1000 * 3 then begin
    m_dwClearBlockIPListTick := GetTickCount();
    try
      m_BlockIPList.Lock;
      try
        nIndex := 0;
        while True do begin
          if nIndex >= m_BlockIPList.Count then Break;
          BlockIP := pTBlockIP(m_BlockIPList.Objects[nIndex]);
          case BlockIP.btAttackType of
            1, 2, 3: begin
                if BlockIP.nAttackCount >= 20 then begin
                  AddBlockIP(BlockIP.sUserIpAddr);
                  Dispose(BlockIP);
                  m_BlockIPList.Delete(nIndex);
                  Inc(nIndex);
                  Continue;
                end;
              end;
            4: begin
                if BlockIP.nAttackCount > 5 then begin
                  AddBlockIP(BlockIP.sUserIpAddr);
                  Dispose(BlockIP);
                  m_BlockIPList.Delete(nIndex);
                  Inc(nIndex);
                  Continue;
                end;
              end;
            5: begin
                if BlockIP.nAttackCount >= 10 then begin
                  AddBlockIP(BlockIP.sUserIpAddr);
                  Dispose(BlockIP);
                  m_BlockIPList.Delete(nIndex);
                  Inc(nIndex);
                  Continue;
                end;
              end;
          end;
          if GetTickCount() - BlockIP.dwUpDateTick > 1000 * 10 then begin
            m_BlockIPList.Delete(nIndex);
            Dispose(BlockIP);
          end;
          Inc(nIndex);
        end;
      finally
        m_BlockIPList.UnLock;
      end;
    except

    end;

    try
      m_CCAttackIPList.Lock;
      try
        nIndex := 0;
        while True do begin
          if nIndex >= m_CCAttackIPList.Count then Break;
          BlockIP := pTBlockIP(m_CCAttackIPList.Objects[nIndex]);
          if (BlockIP.dwUpDateTick <> 0) and (GetTickCount() - BlockIP.dwUpDateTick > 1000 * 60) then begin
            m_CCAttackIPList.Delete(nIndex);
            Dispose(BlockIP);
          end;
          Inc(nIndex);
        end;
      finally
        m_CCAttackIPList.UnLock;
      end;
    except

    end;
  end;
end;

procedure TUserEngine.Run;
begin
  if DBConnected then begin
    if not m_boStartService then begin
      if GetTickCount - m_dwStartServiceTick > 1000 then begin
        m_boStartService := True;
      end;
    end else begin
      ProcessServerData();
      ProcessUserData();
      ClearBlockIPList;
    end;
  end;
  m_dwRunTick := GetTickCount;
end;

function TUserEngine.Found(UserObject: TUserObject): TUserObject;
var
  I: Integer;
begin
  Result := nil;
  try
    m_UserList.Lock;
    for I := 0 to m_UserList.Count - 1 do begin
      if UserObject = m_UserList.Objects[I] then begin
        Result := TUserObject(m_UserList.Objects[I]);
        Break;
      end;
    end;
  finally
    m_UserList.UnLock;
  end;
end;

procedure TUserEngine.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Clear;
  m_nAttackCount := 0;
  m_dwLastAttackTick := GetTickCount();
  m_dwKeepAliveTick := GetTickCount();
  m_boKeepAliveTimcOut := False;
  m_boDBConnected := True;
  MainOutMessage('账号服务器连接成功...', nil);
end;

procedure TUserEngine.ClientSocketConnecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin

end;

procedure TUserEngine.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Clear;
  if m_boDBConnected then
    MainOutMessage('账号服务器连接断开...', nil);
  m_boDBConnected := False;
end;

procedure TUserEngine.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;

procedure TUserEngine.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  sReceiveText: string;
begin
  if m_boStartService then begin
    sReceiveText := Socket.ReceiveText;
    m_sReceiveText := m_sReceiveText + sReceiveText;
  end;
end;

procedure TUserEngine.ServerSocketClientConnect(Socket: TCustomWinSocket);
var
  sRemoteIPaddr: string;
  UserObject: TUserObject;
begin
  if m_boStartService then begin
    MemLock;
    try
      sRemoteIPaddr := Socket.RemoteAddress;
      UserObject := TUserObject.Create;
      UserObject.m_sRemoteIPaddr := sRemoteIPaddr;
      UserObject.m_Socket := Socket;
      Socket.nIndex := Integer(UserObject);
    finally
      MemUnLock;
    end;

    Lock;
    try
      m_UserList.AddObject(sRemoteIPaddr, UserObject);
      m_QuickUserList.AddRecord(sRemoteIPaddr, UserObject);
    finally
      UnLock;
    end;

  end else begin
    Socket.Close;
  end;
end;

procedure TUserEngine.ServerSocketClientDisconnect(Socket: TCustomWinSocket);
var
  UserObject: TUserObject;
begin
  if m_boStartService then begin
    UserObject := TUserObject(Socket.nIndex);
    if (UserObject <> nil) { and (Found(UserObject) = UserObject) } then begin
      UserObject.Lock;
      try
        UserObject.m_Socket := nil;
        Socket.nIndex := 0;
        UserObject.m_boDisconnect := True;
      finally
        UserObject.UnLock;
      end;
    end;
  end;
end;

procedure TUserEngine.ServerSocketClientError(Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;

procedure TUserEngine.ServerSocketClientRead(Socket: TCustomWinSocket);
var
  UserObject: TUserObject;
  sReviceMsg: string;
  nMsgCount: Integer;
  dwLastReviceTick: LongWord;
  boAddReviceMsg: Boolean;
  AObject: TObject;
  boCloseSocket: Boolean;
begin
  if m_boStartService then begin
    boAddReviceMsg := False;
    boCloseSocket := False;
    UserObject := TUserObject(Socket.nIndex);
    if (UserObject <> nil) {and (Found(UserObject) = UserObject)} and (not UserObject.m_boDisconnect) then begin
      UserObject.Lock;
      try
        sReviceMsg := Socket.ReceiveText;
        if not UserObject.m_boReviceMsg then
          UserObject.m_boReviceMsg := True;
        if m_boCheckAttack then begin
          if Length(sReviceMsg) > 352 then begin
            Socket.Close;
            UserObject.m_boDisconnect := True;
            UserObject.m_btAttackType := 1;
            AObject := UpdateBlockIPList(UserObject);
            MainOutMessage('端口攻击: ' + UserObject.m_sRemoteIPaddr, AObject);
          end else begin
            nMsgCount := TagCount(sReviceMsg, '!');
            if nMsgCount > 1 then begin
              Socket.Close;
              UserObject.m_boDisconnect := True;
              UserObject.m_btAttackType := 2;
              UpdateBlockIPList(UserObject);
            end else begin
              if UserObject.m_ReviceMsgList.Count >= 5 then begin
                dwLastReviceTick := LongWord(UserObject.m_ReviceMsgList.Objects[UserObject.m_ReviceMsgList.Count - 1]);
                if GetTickCount - dwLastReviceTick < 100 then begin
                  Socket.Close;
                  UserObject.m_boDisconnect := True;
                  UserObject.m_btAttackType := 3;
                  AObject := UpdateBlockIPList(UserObject);
                  MainOutMessage('端口攻击: ' + UserObject.m_sRemoteIPaddr, AObject);
                end else begin
                  UserObject.m_ReviceMsgList.AddObject(sReviceMsg, TObject(GetTickCount));
                end;
              end else begin
                UserObject.m_ReviceMsgList.AddObject(sReviceMsg, TObject(GetTickCount));
              end;
            end;
          end;
        end else begin
          UserObject.m_ReviceMsgList.AddObject(sReviceMsg, TObject(GetTickCount));
        end;
        UserObject.m_dwReviceMsgTick := GetTickCount;

      finally
        UserObject.UnLock;
      end;
    end;
  end else begin
    Socket.Close;
  end;
end;

function TUserEngine.CheckAttack(Msg: string; UserObject: TUserObject): Integer;
begin

end;

function TUserEngine.GetUserDataType(Msg: string): Integer;
var
  sDefMsg: string;
  sData: string;
  DefMsg: TDefaultMessage;
  sReceiveMsg: string;
  sMsg: string;
begin
  Result := -1;
  sReceiveMsg := Msg;
  if (Pos('!', sReceiveMsg) > 0) and (Length(sReceiveMsg) >= 2) then begin
    sReceiveMsg := ArrestStringEx(sReceiveMsg, '#', '!', sMsg);
    if sMsg <> '' then begin
      if Length(sMsg) >= DEFBLOCKSIZE + 1 then begin
        sMsg := Copy(sMsg, 2, Length(sMsg) - 1);
        sDefMsg := Copy(sMsg, 1, DEFBLOCKSIZE);
        sData := Copy(sMsg, DEFBLOCKSIZE + 1, Length(sMsg) - DEFBLOCKSIZE);
        DefMsg := DecodeMessage(sDefMsg);
        Result := DefMsg.ident;
      end;
    end;
  end;
end;

end.

