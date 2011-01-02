unit Share;

interface
uses
  Windows, Messages, Classes, SysUtils, JSocket, Mudutil, IniFiles, HUtil32, Forms,
  Grobal2, GateShare, HttpGet;
resourcestring
  g_sUpDateTime = 'Build: 02/01/2011';
  g_sProductName = 'LOMCN - Mir Heroes';
  g_sProgram = 'Program: CQFir';
  g_sWebSite = 'Website: www.lomcn.co.uk';
  g_sNowStartGate = 'Starting Gate...';
  g_sNowStartOK = 'Gate Started...';
const
  TESTMODE = 0;
type
  pTPointers = ^TPointers;
  TPointers = array of Pointer;

  pTBytes = ^TBytes;
  TBytes = array of Byte;

  TClientThread = class(TThread)
    ClientSocket: TClientSocket;
    m_UserCriticalSection: TRTLCriticalSection;
    m_dwConnTick: LongWord;
    m_boConnected: Boolean;
    m_sReviceText: string;
    m_dwKeepAliveTick: LongWord;
    m_boKeepAliveTimcOut: Boolean;
    m_dwSendKeepAliveTick: LongWord;
  private
    { Private declarations }
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);

    procedure Run;
    procedure ProcessPacket(sData: string);
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    function Connect(): Boolean;
    procedure Close();
    procedure Lock();
    procedure UnLock();
    procedure SendText(const Text: string);
  end;

  TSession = record
    Socket: TCustomWinSocket;
    sRemoteIPaddr: string;
    dwConnctCheckTick: LongWord;
    dwReviceMsgTick: LongWord;
    sReviceMsg: string;
    dwSendServerTick: LongWord;
    nReviceMsgLen: Integer;
    nSendMsgLen: Integer;
    nNewAccountCount: Integer;
    btAttackType: Byte;
    boReviceMsg: Boolean;
    SendMsgList: TStringList;
    dwLastTick: LongWord;
    boCheckAttacked: Boolean;
    dwUserTimeOutTick: LongWord;

    boIsNewAccount: Boolean;
    dwGetRandomTick: LongWord;
    dwSelectServerTick: LongWord;
    dwPassWordTick: LongWord;
    dwGetBakPassWordTick: LongWord;
    dwChgPassWordTick: LongWord;
  end;
  pTSession = ^TSession;

  TSessions = array of TSession;
  pTSessions = ^TSessions;


  TSessionList = class(TObject)

  private
    FUserCriticalSection: TRTLCriticalSection;
    FList: TSessions;
    FMaxCount: Integer;
    FCount: Integer;
    FIndexList: TList;
    function Get(Index: Integer): pTSession;
    procedure Put(Index: Integer; Item: pTSession);
    procedure SetMaxCount(Value: Integer);
    procedure Initialize();
    procedure Finalize;
  public
    constructor Create();
    destructor Destroy; override;
    function Add(out Item: pTSession): Integer;
    function Delete(Index: Integer): Boolean;
    function Clear(): Boolean;
    procedure Lock();
    procedure UnLock();
    property MaxCount: Integer read FMaxCount write SetMaxCount;
    property Count: Integer read FCount;
    property Items[Index: Integer]: pTSession read Get; default;
  end;


  TSList = class(TObject)

  private
    FUserCriticalSection: TRTLCriticalSection;
    FList: TBytes;
    FMaxCount: Integer;
    FCount: Integer;
    FIndexList: TList;
    FItemSize: Integer;
    function Get(Index: Integer): Pointer;
    procedure Put(Index: Integer; Item: Pointer);
    procedure SetMaxCount(Value: Integer);
    procedure SetItemSize(Value: Integer);
  public
    constructor Create();
    destructor Destroy; override;
    function Add(Item: Pointer): Integer;
    function Delete(Index: Integer): Boolean;
    function Clear(): Boolean;
    procedure Lock();
    procedure UnLock();
    property MaxCount: Integer read FMaxCount write SetMaxCount;
    property Count: Integer read FCount;
    property Items[Index: Integer]: Pointer read Get write Put; default;
    property ItemSize: Integer read FItemSize write SetItemSize;
  end;

  TConfig = record
    GateName: string;
    TitleName: string;
    ServerPort: Integer;
    ServerAddr: string;
    GatePort: Integer;
    GateAddr: string;
    nMaxConnOfIPaddr: Integer;
    dwKeepConnectTimeOut: LongWord;
    nConnctCheckTime: Integer;
    nCCAttackTickTime: Integer;
    boMinimize: Boolean;
    boStarted: Boolean;
    nMaxCount: Integer;
    nMaxOnlineCount: Integer;
    nRefLoadIpListTime: Integer;
  end;

  TMsgLog = record
    btMsgType: Byte;
    dAddTime: TDateTime;
    boAdd: Boolean;
    boUpDate: Boolean;
    APointer: Pointer;
  end;
  pTMsgLog = ^TMsgLog;

  TBlockIP = record
    sUserIPaddr: string;
    btAttackType: Byte;
    nAttackCount: Integer;
    dwAddTick: LongWord;
    dwUpDateTick: LongWord;
  end;
  pTBlockIP = ^TBlockIP;
var
  g_SessionList: TSessionList;
  g_ClientThread: TClientThread;

  GateClass: string = 'LoginGate';

  g_Config: TConfig = (
    GateName: 'Login Gate';
    TitleName: 'LOMCN';
    ServerPort: 5500;
    ServerAddr: '127.0.0.1';
    GatePort: 7000;
    GateAddr: '0.0.0.0';
    nMaxConnOfIPaddr: 200;
    dwKeepConnectTimeOut: 120 * 1000;
    nConnctCheckTime: 300;
    boMinimize: False;
    boStarted: False;
    nMaxCount: 2000;
    nMaxOnlineCount: 500;
    nRefLoadIpListTime: 5000;
    );

  g_CS: TRTLCriticalSection;
  g_UserCriticalSection: TRTLCriticalSection;
  g_boClose: Boolean;
  g_dwConnectDBTick: LongWord;
  g_SysLogList: TGStringList;

  g_IPList: TGStringList;
  g_BlockIPList: TGStringList;
  g_BlockIPArray: TStringList;
  g_dwUpdateListViewTick: LongWord;
  MainLogMsgList: TGStringList;
  UpdateLogMsgList: TGStringList;
  g_boShowLog: Boolean;
  g_sBlockIP: string;
  g_TestList: TStringList;
  g_Sessions: TSessions;

  g_dwDecodeMsgTime: LongWord;
  g_boServerReady: Boolean;
  g_boGateReady: Boolean;
  g_boServiceStart: Boolean;

  g_QuickList: TQuickList;

  g_nNewAccountCount: Integer;
  g_dwNewAccountTick: LongWord;
  g_dwClearBlockIPListTick: LongWord;
  g_dwStartServiceTick: LongWord;
  g_boStartService: Boolean;
  g_boCheckAttack: Boolean;
  g_boOldCheckAttack: Boolean;
  g_dwSendMsgSrverTick: LongWord;
  g_sMsgServerReceiveText: string;
  g_nAttackCount: Integer;
  g_dwLastAttackTick: LongWord;

  g_CCAttackIPList: TGStringList;

  g_nSessionCount: Integer;
  g_nProcessCount: Integer;

  g_boHttpWork: Boolean = False;
  g_sIpListUrl: string = 'http://www.cqfir.net/IpList.txt';
  g_dwRefLoadIpListTime: LongWord;

procedure LoadConfig;
procedure LoadBlockIPFile();
procedure UnLoadBlockIPFile();
procedure SaveBlockIPFile;
procedure AddBlockIP(sUserIPaddr: string);
procedure MainOutMessage(Msg: string; AObject: TObject);
function IsBlockIP(sUserIPaddr: string): pTBlockIP; overload;
function IsBlockIP(AObject: TObject): pTBlockIP; overload;
function FindMsg(AObject: TObject): pTMsgLog;
function IndexMsg(nIndex: Integer): pTMsgLog;
procedure ClearMessage;

function _IsIPaddr(Ip: string): Boolean;
procedure LoadBlockIPArrayFile;
procedure UnLoadBlockIPArrayFile;
procedure SaveBlockIPArrayFile;
procedure AddIPArray(sUserIPaddr: string);
function IsIPArray(sUserIPaddr: string): Boolean;

function IsArrayIP(sUserIPaddr: string): Boolean;

procedure Initialize();
function FoundCCAttackIP(AObject: TObject): TObject; overload;
function FoundCCAttackIP(sUserIPaddr: string): TObject; overload;
function UpdateCCAttackIPList(Session: pTSession): TObject; overload;
function UpdateCCAttackIPList(sUserIPaddr: string): TObject; overload;
procedure ClearSession;

function IsUserIPList(sUserIPaddr: string): Boolean;
procedure LoadIPListFile();
procedure GetIPListFile();

implementation

constructor TSessionList.Create();
begin
  inherited;
  InitializeCriticalSection(FUserCriticalSection);
  FCount := 0;
  FMaxCount := 2000;
  SetLength(FList, FMaxCount);
  FIndexList := TList.Create;
  Initialize();
end;

destructor TSessionList.Destroy;
begin
  Finalize;
  FIndexList.Free;
  SetLength(FList, 0);
  DeleteCriticalSection(FUserCriticalSection);
  inherited;
end;

procedure TSessionList.Initialize();
var
  Index: Integer;
begin
  for Index := 0 to FMaxCount - 1 do begin
    FList[Index].Socket := nil;
    FList[Index].sRemoteIPaddr := '';
    FList[Index].sReviceMsg := '';
    FList[Index].SendMsgList := TStringList.Create;
  end;
end;

procedure TSessionList.Finalize;
var
  Index: Integer;
begin
  for Index := 0 to FMaxCount - 1 do begin
    FList[Index].Socket := nil;
    FList[Index].sRemoteIPaddr := '';
    FList[Index].sReviceMsg := '';
    FList[Index].SendMsgList.Free;
    FList[Index].SendMsgList := nil;
  end;
end;

procedure TSessionList.SetMaxCount(Value: Integer);
begin
  if FMaxCount <> Value then begin
    Finalize;
    SetLength(FList, FMaxCount);
    Initialize();
  end;
end;

function TSessionList.Get(Index: Integer): pTSession;
begin
  if (Index >= 0) and (Index < FMaxCount) then begin
    Result := @FList[Index];
  end else Result := nil;
end;

procedure TSessionList.Put(Index: Integer; Item: pTSession);
begin
  if (Index >= 0) and (Index < FMaxCount) then begin
    if Item <> nil then
      Move(Item^, FList[Index], SizeOf(TSession))
    else
      FillChar(FList[Index], SizeOf(TSession), 0);
  end;
end;

function TSessionList.Add(out Item: pTSession): Integer;
var
  Index: Integer;
begin
  Result := -1;
  if FIndexList.Count > 0 then begin
    Index := Integer(FIndexList.Items[0]);
    FIndexList.Delete(0);
    if (Index >= 0) and (Index < FMaxCount) then begin
      Item := @FList[Index];
      Result := Index;
    end;
  end else begin
    Index := FCount;
    if (Index >= 0) and (Index < FMaxCount) then begin
      Item := @FList[Index];
      Inc(FCount);
      Result := Index;
    end;
  end;
end;

function TSessionList.Delete(Index: Integer): Boolean;
begin
  Result := False;
  if (Index >= 0) and (Index < FMaxCount) then begin
    FList[Index].Socket := nil;
    FList[Index].sRemoteIPaddr := '';
    FList[Index].sReviceMsg := '';
    FList[Index].SendMsgList.Clear;
    FIndexList.Add(Pointer(Index));
    Result := True;
  end;
end;

function TSessionList.Clear(): Boolean;
var
  Index: Integer;
begin
  FCount := 0;
  FIndexList.Clear;
  for Index := 0 to FMaxCount - 1 do begin
    FList[Index].Socket := nil;
    FList[Index].sRemoteIPaddr := '';
    FList[Index].sReviceMsg := '';
    FList[Index].SendMsgList.Clear;
  end;
end;

procedure TSessionList.Lock();
begin
  EnterCriticalSection(FUserCriticalSection);
end;

procedure TSessionList.UnLock();
begin
  LeaveCriticalSection(FUserCriticalSection);
end;


constructor TSList.Create();
begin
  inherited;
  InitializeCriticalSection(FUserCriticalSection);
  FCount := 0;
  FItemSize := 1;
  FMaxCount := 2000;
  SetLength(FList, FMaxCount * FItemSize);
  FIndexList := TList.Create;
end;

destructor TSList.Destroy;
begin
  FIndexList.Free;
  SetLength(FList, 0);
  DeleteCriticalSection(FUserCriticalSection);
  inherited;
end;

procedure TSList.SetMaxCount(Value: Integer);
begin
  if FMaxCount <> Value then begin
    FMaxCount := Value;
    SetLength(FList, FMaxCount * ItemSize);
  end;
end;

procedure TSList.SetItemSize(Value: Integer);
begin
  if FItemSize <> Value then begin
    FItemSize := Value;
    SetLength(FList, FMaxCount * ItemSize);
  end;
end;

function TSList.Get(Index: Integer): Pointer;
begin
  if (Index >= 0) and (Index < FMaxCount) then begin
    Result := @FList[Index * ItemSize];
  end else Result := nil;
end;

procedure TSList.Put(Index: Integer; Item: Pointer);
begin
  if (Index >= 0) and (Index < FMaxCount) then begin
    if Item <> nil then
      Move(Item^, FList[Index * ItemSize], ItemSize)
    else
      FillChar(FList[Index * ItemSize], ItemSize, 0);
  end;
end;

function TSList.Add(Item: Pointer): Integer;
var
  Index: Integer;
begin
  Result := -1;
  if FIndexList.Count > 0 then begin
    Index := Integer(FIndexList.Items[0]);
    FIndexList.Delete(0);
    if (Index >= 0) and (Index < FMaxCount) then begin
      if Item <> nil then
        Move(Item^, FList[Index * ItemSize], ItemSize)
      else
        FillChar(FList[Index * ItemSize], ItemSize, 0);
      Result := Index;
    end;
  end else begin
    Index := FCount;
    if (Index >= 0) and (Index < FMaxCount) then begin
      if Item <> nil then
        Move(Item^, FList[Index * ItemSize], ItemSize)
      else
        FillChar(FList[Index * ItemSize], ItemSize, 0);
      Inc(FCount);
      Result := Index;
    end;
  end;
end;

function TSList.Delete(Index: Integer): Boolean;
begin
  Result := False;
  if (Index >= 0) and (Index < FMaxCount) then begin
    FillChar(FList[Index * ItemSize], ItemSize, 0);
    FIndexList.Add(Pointer(Index));
    Result := True;
  end;
end;

function TSList.Clear(): Boolean;
var
  I: Integer;
begin
  FCount := 0;
  FIndexList.Clear;
  for I := 0 to FMaxCount - 1 do
    FillChar(FList[I * ItemSize], ItemSize, 0);
end;

procedure TSList.Lock();
begin
  EnterCriticalSection(FUserCriticalSection);
end;

procedure TSList.UnLock();
begin
  LeaveCriticalSection(FUserCriticalSection);
end;


constructor TClientThread.Create(CreateSuspended: Boolean);
begin
  inherited;
  InitializeCriticalSection(m_UserCriticalSection);
  ClientSocket := TClientSocket.Create(nil);
  ClientSocket.ClientType := ctBlocking;
  ClientSocket.OnConnect := ClientSocketConnect;
  ClientSocket.OnDisconnect := ClientSocketDisconnect;
  ClientSocket.OnError := ClientSocketError;
  m_boConnected := False;
  m_sReviceText := '';
  m_dwKeepAliveTick := GetTickCount;
  m_dwSendKeepAliveTick := GetTickCount();
  m_boKeepAliveTimcOut := False;
end;

destructor TClientThread.Destroy;
begin
  Close();
  ClientSocket.Free;
  DeleteCriticalSection(m_UserCriticalSection);
  inherited;
end;

procedure TClientThread.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin

end;

procedure TClientThread.ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
  g_boGateReady := False;
end;

procedure TClientThread.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin

end;

procedure TClientThread.SendText(const Text: string);
begin
  ClientSocket.Socket.SendText(Text);
end;

procedure TClientThread.Run;
resourcestring
  sExceptionMsg = '[Exception] TClientThread::Run %d';
var
  nIndex: Integer;
  nCheckCode: Integer;
  Session: pTSession;
  sSendMsg: string;
begin
  nCheckCode := 0;
  if Terminated then Exit;
  if (GetTickCount - m_dwSendKeepAliveTick) > 1000 * 2 then begin
    m_dwSendKeepAliveTick := GetTickCount();
    try
      nCheckCode := 1;
      ClientSocket.Socket.SendText('%--$');
      nCheckCode := 2;
    except
      nCheckCode := 3;
      Close();
      Exit;
      nCheckCode := 4;
    end;
  end;

  if (GetTickCount - m_dwKeepAliveTick) > 10 * 1000 then begin
    m_boKeepAliveTimcOut := True;
    nCheckCode := 5;
    Close();
    Exit;
    nCheckCode := 6;
  end;

  try
    if g_boGateReady then begin
     { g_SessionList.Lock;
      try }
      for nIndex := 0 to g_SessionList.MaxCount - 1 do begin
        if Terminated then Break;
        if not ClientSocket.Socket.Connected then Break;
        nCheckCode := 7;
        Session := g_SessionList.Items[nIndex];
        nCheckCode := 8;
        if (Session.Socket <> nil) and (Session.Socket.Connected) then begin
          if GetTickCount - Session.dwConnctCheckTick > g_Config.dwKeepConnectTimeOut then begin
            nCheckCode := 9;
            Session.Socket.Close; //空连接
            nCheckCode := 10;
            Continue;
          end;
          nCheckCode := 11;

          if Session.SendMsgList.Count > 0 then begin
            sSendMsg := Session.SendMsgList.Strings[0];
            Session.SendMsgList.Delete(0);
            Session.Socket.SendText(sSendMsg);
            Inc(Session.nSendMsgLen, Length(sSendMsg));
          end;
          nCheckCode := 12;
        end;
      end;
      {finally
        g_SessionList.UnLock;
      end;}
    end;
  except
    MainOutMessage(Format(sExceptionMsg, [nCheckCode]), nil);
  end;
end;

procedure TClientThread.Close();
begin
  g_boGateReady := False;
  ClientSocket.Active := False;
  m_dwKeepAliveTick := GetTickCount();
  Initialize();
  MainOutMessage('Gate Disconnected From Server...', nil);
end;

procedure TClientThread.Execute;
resourcestring
  sExceptionMsg = '[Exception] TClientThread::Execute %d';
var
  nMsgLen: Integer;
  nCheckCode: Integer;
  ReceiveBuffer: array[0..DATA_BUFSIZE * 2 - 1] of Char; //array[0..4095] of Char;
  sReviceBuff: string;
  sSocketMsg: string;
  SocketStream: TWinSocketStream;
begin
  while not Terminated do begin
    //try
    nCheckCode := 0;
    if g_boServiceStart then begin
      if not ClientSocket.Socket.Connected then begin
        m_boConnected := False;
        if GetTickCount - m_dwConnTick > 1000 then begin
          m_dwConnTick := GetTickCount;
          nCheckCode := 1;
          ClientSocket.Active := False;
          ClientSocket.Address := g_Config.ServerAddr;
          ClientSocket.Port := g_Config.ServerPort;
          try
            ClientSocket.Active := True;
          except
            Sleep(1000);
            Continue;
          end;
          nCheckCode := 2;
        end;
        Sleep(1000);
        Continue;
      end;
      if not ClientSocket.Socket.Connected then begin
        Sleep(100);
        Continue;
      end;
      nCheckCode := 3;
      Connect();
      nCheckCode := 4;
      SocketStream := TWinSocketStream.Create(ClientSocket.Socket, 5000);
      try
        if SocketStream.WaitForData(5000) then begin
          repeat
            if (not ClientSocket.Socket.Connected) or (not g_boServiceStart) or Terminated then Break;
            try
              nCheckCode := 5;
              nMsgLen := SocketStream.Read(ReceiveBuffer, SizeOf(ReceiveBuffer));
              nCheckCode := 6;
            except
              Close();
              Break;
            end;
            if nMsgLen <> 0 then begin
              nCheckCode := 7;
              SetLength(sReviceBuff, nMsgLen);
              Move(ReceiveBuffer, sReviceBuff[1], nMsgLen);
              m_sReviceText := m_sReviceText + sReviceBuff;
              nCheckCode := 8;
              while (True) do begin
                if m_sReviceText = '' then Break;
                if Length(m_sReviceText) < 2 then Break;
                if Pos('$', m_sReviceText) <= 0 then Break;
                sSocketMsg := '';
                m_sReviceText := ArrestStringEx(m_sReviceText, '%', '$', sSocketMsg);
                if sSocketMsg = '' then Continue;
                if Terminated then Break;
                nCheckCode := 9;
                ProcessPacket(sSocketMsg);
                nCheckCode := 10;
              end;
            end else begin
              Break;
            end;
          until not SocketStream.WaitForData(5000);
        end;
      finally
        SocketStream.Free;
      end;
      nCheckCode := 11;
      Run;
      nCheckCode := 12;
    end;
    //except
     // MainOutMessage(Format(sExceptionMsg, [nCheckCode]), nil);
    //end;
    Sleep(1);
  end;
end;

procedure TClientThread.ProcessPacket(sData: string);
resourcestring
  sExceptionMsg = '[Exception] TClientThread::ProcessPacket %d';
var
  sSocketMsg: string;
  nIndex: Integer;
  Session: pTSession;
  sUserSession: string;
  sUserIPaddr: string;
  nUserSession: Integer;
  dwCheckTime: LongWord;
  dwDecodeTick: LongWord;
  dwDecodeTime: LongWord;
  nCheckCode: Integer;
begin
  try
    nCheckCode := 0;
    sSocketMsg := sData;
    dwDecodeTick := GetTickCount();
    if (sSocketMsg[1] = '+') then begin
      if (Length(sSocketMsg) >= 2) then begin
        case sSocketMsg[2] of
          '-', 'B', 'T': begin
              nCheckCode := 1;
              sUserSession := Copy(sSocketMsg, 3, Length(sSocketMsg) - 2);
              nUserSession := Str_ToInt(sUserSession, -1);
              Session := g_SessionList.Items[nUserSession];
              if (Session <> nil) then begin
                nCheckCode := 2;
                if (Session.Socket <> nil) and Session.Socket.Connected then begin
                  nCheckCode := 3;
                  Session.Socket.Close;
                  nCheckCode := 4;
                end;
                m_dwKeepAliveTick := GetTickCount();
                m_boKeepAliveTimcOut := False;
              end;
            end;
          'M': begin
              sUserIPaddr := Copy(sSocketMsg, 3, Length(sSocketMsg) - 2);
              AddBlockIP(sUserIPaddr);
            end;
        else begin
            m_dwKeepAliveTick := GetTickCount();
            m_boKeepAliveTimcOut := False;
          end;
        end;
      end;
    end else begin
      sSocketMsg := GetValidStr3(sSocketMsg, sUserSession, ['/']);
      nUserSession := Str_ToInt(sUserSession, -1);
      g_SessionList.Lock;
      try
        Session := g_SessionList.Items[nUserSession];
        if (Session <> nil) then begin
          nCheckCode := 11;
          if (Session.Socket <> nil) and Session.Socket.Connected then begin
            Session.SendMsgList.Add(sSocketMsg);
          end;
          nCheckCode := 12;
        end;
      finally
        g_SessionList.UnLock;
      end;
    end;

    nCheckCode := 13;
    Run();
    nCheckCode := 14;
  except
    MainOutMessage(Format(sExceptionMsg, [nCheckCode]), nil);
  end;
  dwDecodeTime := GetTickCount - dwDecodeTick;
  if g_dwDecodeMsgTime < dwDecodeTime then g_dwDecodeMsgTime := dwDecodeTime;
  if g_dwDecodeMsgTime > 50 then Dec(g_dwDecodeMsgTime, 50);
end;

function TClientThread.Connect(): Boolean;
begin
  if ClientSocket.Socket.Connected and (not m_boConnected) then begin
    m_sReviceText := '';
    m_boConnected := True;
    g_boGateReady := True;
    m_dwKeepAliveTick := GetTickCount;
    m_dwSendKeepAliveTick := GetTickCount();
    m_boKeepAliveTimcOut := False;
    Initialize();
    MainOutMessage('Connected to (' + ClientSocket.Socket.RemoteAddress + ':' + IntToStr(ClientSocket.Socket.RemotePort) + ')Ok...', nil);
  end;
end;

procedure TClientThread.Lock();
begin
  EnterCriticalSection(m_UserCriticalSection);
end;

procedure TClientThread.UnLock();
begin
  LeaveCriticalSection(m_UserCriticalSection);
end;

procedure ClearSession;
var
  I: Integer;
  Session: pTSession;
begin
  for I := 0 to g_SessionList.MaxCount - 1 do begin
    Session := g_SessionList.Items[I];
    if (Session.Socket <> nil) then
      Session.Socket.Close;

    Session.Socket := nil;
    Session.sRemoteIPaddr := '';
    Session.sReviceMsg := '';
    Session.SendMsgList.Clear;
  end;
end;

procedure Initialize();
var
  I: Integer;
begin
  ClearSession;

  g_dwStartServiceTick := GetTickCount();
  g_boStartService := False;

  g_nProcessCount := 0;
  g_nSessionCount := 0;
  g_nNewAccountCount := 0;

  {for I := 0 to g_QuickUserList.Count - 1 do begin
    TList(g_QuickUserList.Objects[I]).Free;
  end;
  g_QuickUserList.Clear;}

  g_QuickList.Clear;

  for I := 0 to g_CCAttackIPList.Count - 1 do begin
    Dispose(pTBlockIP(g_CCAttackIPList.Objects[I]));
  end;
  g_CCAttackIPList.Clear;
end;

function FoundCCAttackIP(AObject: TObject): TObject;
var
  I: Integer;
begin
  Result := nil;
  g_CCAttackIPList.Lock;
  try
    for I := 0 to g_CCAttackIPList.Count - 1 do begin
      if g_CCAttackIPList.Objects[I] = AObject then begin
        Result := g_CCAttackIPList.Objects[I];
        Break;
      end;
    end;
  finally
    g_CCAttackIPList.UnLock;
  end;
end;

function FoundCCAttackIP(sUserIPaddr: string): TObject;
var
  I: Integer;
begin
  Result := nil;
  g_CCAttackIPList.Lock;
  try
    for I := 0 to g_CCAttackIPList.Count - 1 do begin
      if g_CCAttackIPList.Strings[I] = sUserIPaddr then begin
        Result := g_CCAttackIPList.Objects[I];
        Break;
      end;
    end;
  finally
    g_CCAttackIPList.UnLock;
  end;
end;

function UpdateCCAttackIPList(sUserIPaddr: string): TObject;
var
  I: Integer;
  BlockIP: pTBlockIP;
  boFound: Boolean;
begin
  Result := nil;
  boFound := False;
  g_CCAttackIPList.Lock;
  try
    for I := 0 to g_CCAttackIPList.Count - 1 do begin
      if g_CCAttackIPList.Strings[I] = sUserIPaddr then begin
        Result := g_CCAttackIPList.Objects[I];
        boFound := True;
        Break;
      end;
    end;
    if not boFound then begin
      New(BlockIP);
      BlockIP.sUserIPaddr := sUserIPaddr;
      BlockIP.btAttackType := 5;
      BlockIP.nAttackCount := 0;
      BlockIP.dwAddTick := GetTickCount;
      BlockIP.dwUpDateTick := 0;
      g_CCAttackIPList.AddObject(sUserIPaddr, TObject(BlockIP));
      Result := TObject(BlockIP);
    end;
  finally
    g_CCAttackIPList.UnLock;
  end;
end;

function UpdateCCAttackIPList(Session: pTSession): TObject;
var
  I: Integer;
  BlockIP: pTBlockIP;
  boFound: Boolean;
begin
  Result := nil;
  boFound := False;
  g_CCAttackIPList.Lock;
  try
    for I := 0 to g_CCAttackIPList.Count - 1 do begin
      if g_CCAttackIPList.Strings[I] = Session.sRemoteIPaddr then begin
        Result := g_CCAttackIPList.Objects[I];
        boFound := True;
        Break;
      end;
    end;

    if not boFound then begin
      New(BlockIP);
      BlockIP.sUserIPaddr := Session.sRemoteIPaddr;
      BlockIP.btAttackType := Session.btAttackType;
      BlockIP.nAttackCount := 0;
      BlockIP.dwAddTick := GetTickCount;
      BlockIP.dwUpDateTick := 0;
      g_CCAttackIPList.AddObject(Session.sRemoteIPaddr, TObject(BlockIP));
      Result := TObject(BlockIP);
    end;
  finally
    g_CCAttackIPList.UnLock;
  end;
end;

function FindMsg(AObject: TObject): pTMsgLog;
var
  I: Integer;
begin
  Result := nil;
  MainLogMsgList.Lock;
  try
    for I := 0 to MainLogMsgList.Count - 1 do begin
      if (AObject <> nil) and (pTMsgLog(MainLogMsgList.Objects[I]).APointer = Pointer(AObject)) then begin
        Result := pTMsgLog(MainLogMsgList.Objects[I]);
        Break;
      end;
    end;
  finally
    MainLogMsgList.UnLock;
  end;
end;

function IndexMsg(nIndex: Integer): pTMsgLog;
begin
  Result := nil;
  MainLogMsgList.Lock;
  try
    if (nIndex >= 0) and (nIndex < MainLogMsgList.Count) then begin
      Result := pTMsgLog(MainLogMsgList.Objects[nIndex]);
    end;
  finally
    MainLogMsgList.UnLock;
  end;
end;

procedure ClearMessage;
var
  I: Integer;
begin
  MainLogMsgList.Lock;
  try
    for I := 0 to MainLogMsgList.Count - 1 do begin
      Dispose(pTMsgLog(MainLogMsgList.Objects[I]));
    end;
    MainLogMsgList.Clear;
  finally
    MainLogMsgList.UnLock;
  end;
end;

procedure MainOutMessage(Msg: string; AObject: TObject);
var
  MsgLog: pTMsgLog;
begin
  if g_boShowLog then begin
    MainLogMsgList.Lock;
    try
      if MainLogMsgList.Count >= 200 then ClearMessage;
    finally
      MainLogMsgList.UnLock;
    end;
    MsgLog := FindMsg(AObject);
    if MsgLog = nil then begin
      MainLogMsgList.Lock;
      try
        New(MsgLog);
        MsgLog.dAddTime := Now;
        MsgLog.boAdd := True;
        MsgLog.boUpDate := False;
        MsgLog.APointer := Pointer(AObject);
        MainLogMsgList.AddObject(Msg, TObject(MsgLog));
      finally
        MainLogMsgList.UnLock;
      end;
    end else begin
      MsgLog.dAddTime := Now;
      MsgLog.boUpDate := True;
    end;
  end;
end;

/////////////////////////////////////////////////////////////////////////////////

function IsIPArray(sUserIPaddr: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to g_BlockIPArray.Count - 1 do begin
    if g_BlockIPArray.Strings[I] = sUserIPaddr then begin
      Result := True;
      Break;
    end;
  end;
end;

function IsArrayIP(sUserIPaddr: string): Boolean;
var
  I, II: Integer;
  UserIPList: TStringList;
  TempList: TStringList;
  boSame: Boolean;
begin
  Result := False;
  UserIPList := TStringList.Create;
  TempList := TStringList.Create;
  ExtractStrings(['.'], [], PChar(sUserIPaddr), UserIPList);
  for I := 0 to g_BlockIPArray.Count - 1 do begin
    TempList.Clear;
    ExtractStrings(['.'], [], PChar(g_BlockIPArray.Strings[I]), TempList);
    boSame := True;
    if UserIPList.Count = TempList.Count then begin
      for II := 0 to TempList.Count - 1 do begin
        if TempList.Strings[II] <> '*' then begin
          if TempList.Strings[II] <> UserIPList.Strings[II] then begin
            boSame := False;
            Break;
          end;
        end;
      end;
    end else boSame := False;
    if boSame then begin
      Result := True;
      Break;
    end;
  end;
  UserIPList.Free;
  TempList.Free;
end;

procedure AddIPArray(sUserIPaddr: string);
begin
  if IsIPArray(sUserIPaddr) then Exit;
  g_BlockIPArray.Add(sUserIPaddr);
  SaveBlockIPArrayFile;
end;

procedure UnLoadBlockIPArrayFile;
begin
  g_BlockIPArray.Clear;
end;

function _IsIPaddr(Ip: string): Boolean;
var
  I: Integer;
  TempList: TStringList;
begin
  Result := False;
  TempList := TStringList.Create;
  ExtractStrings(['.'], [], PChar(Ip), TempList);
  if TempList.Count = 4 then begin
    Result := True;
    for I := 0 to TempList.Count - 1 do begin
      if TempList.Strings[I] <> '*' then begin
        if not (Str_ToInt(TempList.Strings[I], -1) in [0..255]) then begin
          Result := False;
          Break;
        end;
      end;
    end;
  end;
  TempList.Free;
end;

procedure LoadBlockIPArrayFile;
var
  I: Integer;
  sFileName: string;
  LoadList: TStringList;
  sIPaddr: string;
begin
  UnLoadBlockIPArrayFile;
  sFileName := '.\BlockIPArrayList.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sIPaddr := Trim(LoadList.Strings[I]);
      if sIPaddr = '' then Continue;
      if _IsIPaddr(sIPaddr) then AddIPArray(sIPaddr);
    end;
    LoadList.Free;
  end;
end;

procedure SaveBlockIPArrayFile;
var
  sFileName: string;
begin
  sFileName := '.\BlockIPArrayList.txt';
  try
    g_BlockIPArray.SaveToFile(sFileName);
  except

  end;
end;
////////////////////////////////////////////////////////////////////////////////

function IsBlockIP(AObject: TObject): pTBlockIP;
var
  I: Integer;
begin
  Result := nil;
  g_BlockIPList.Lock;
  try
    for I := 0 to g_BlockIPList.Count - 1 do begin
      if g_BlockIPList.Objects[I] = AObject then begin
        Result := pTBlockIP(g_BlockIPList.Objects[I]);
        Break;
      end;
    end;
  finally
    g_BlockIPList.UnLock;
  end;
end;

function IsBlockIP(sUserIPaddr: string): pTBlockIP;
var
  I: Integer;
begin
  Result := nil;
  g_BlockIPList.Lock;
  try
    for I := 0 to g_BlockIPList.Count - 1 do begin
      if g_BlockIPList.Strings[I] = sUserIPaddr then begin
        Result := pTBlockIP(g_BlockIPList.Objects[I]);
        Break;
      end;
    end;
  finally
    g_BlockIPList.UnLock;
  end;
end;

procedure AddBlockIP(sUserIPaddr: string);
var
  BlockIP: pTBlockIP;
begin
  if IsBlockIP(sUserIPaddr) = nil then begin
    g_BlockIPList.Lock;
    try
      New(BlockIP);
      BlockIP.sUserIPaddr := sUserIPaddr;
      BlockIP.btAttackType := 1;
      BlockIP.nAttackCount := 1;
      BlockIP.dwAddTick := GetTickCount;
      BlockIP.dwUpDateTick := GetTickCount;
      g_BlockIPList.AddObject(sUserIPaddr, TObject(BlockIP));
    finally
      g_BlockIPList.UnLock;
    end;
    //SaveBlockIPFile;
  end;
end;

procedure UnLoadBlockIPFile();
var
  I: Integer;
  BlockIP: pTBlockIP;
begin
  g_BlockIPList.Lock;
  try
    for I := 0 to g_BlockIPList.Count - 1 do begin
      Dispose(pTBlockIP(g_BlockIPList.Objects[I]));
    end;
    g_BlockIPList.Clear();
  finally
    g_BlockIPList.UnLock;
  end;
end;

procedure LoadBlockIPFile();
var
  I: Integer;
  sFileName: string;
  LoadList: TStringList;
  sIPaddr: string;
begin
  UnLoadBlockIPFile();
  g_BlockIPList.Lock;
  try
    sFileName := '.\BlockIPList.txt';
    if FileExists(sFileName) then begin
      LoadList := TStringList.Create;
      LoadList.LoadFromFile(sFileName);
      for I := 0 to LoadList.Count - 1 do begin
        sIPaddr := Trim(LoadList.Strings[I]);
        if sIPaddr = '' then Continue;
        AddBlockIP(sIPaddr);
      end;
      LoadList.Free;
    end;
  finally
    g_BlockIPList.UnLock;
  end;
end;

procedure SaveBlockIPFile;
var
  sFileName: string;
begin
  sFileName := '.\BlockIPList.txt';
  try
    g_BlockIPList.SaveToFile(sFileName);
  except

  end;
end;

procedure GetIPListFile();
var
  HttpGet: THTTPGet;
  StringList: TStringList;
begin
  //MainOutMessage('正在获取绿色通道列表', nil);
  StringList := TStringList.Create;
  HttpGet := THTTPGet.Create(nil);
  HttpGet.URL := g_sIpListUrl;
  HttpGet.WaitThread := True;
  try
    StringList.Text := HttpGet.Get;
    //MainOutMessage('绿色通道列表获取成功', nil);
  except
    //MainOutMessage('绿色通道列表获取失败', nil);
  end;
  try
    if StringList.Count > 0 then
      StringList.SaveToFile('.\IpList.txt');
  except

  end;
  StringList.Free;
  HttpGet.Free;
end;

procedure LoadIPListFile();
var
  I, II: Integer;
  sFileName: string;
begin
  //GetIPListFile();
  g_IPList.Lock;
  try
    sFileName := '.\IpList.txt';
    if FileExists(sFileName) then begin
      g_IPList.LoadFromFile(sFileName);

      for I := g_IPList.Count - 1 downto 0 do begin
        if I > 0 then begin
          for II := I - 1 downto 0 do begin
            if g_IPList.Strings[I] = g_IPList.Strings[II] then begin
              g_IPList.Delete(I);
              Break;
            end;
          end;
        end;
      end;

      try
        g_IPList.SaveToFile(sFileName);
      except

      end;
    end;
  finally
    g_IPList.UnLock;
  end;
end;

function IsUserIPList(sUserIPaddr: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  g_IPList.Lock;
  try
    for I := 0 to g_IPList.Count - 1 do begin
      if g_IPList.Strings[I] = sUserIPaddr then begin
        Result := True;
        Break;
      end;
    end;
  finally
    g_IPList.UnLock;
  end;
end;

procedure LoadConfig;
var
  Conf: TIniFile;
  sConfigFileName: string;
  nInteger: Integer;
  sString: string;
begin
  sConfigFileName := '.\Config.ini';
  Conf := TIniFile.Create(sConfigFileName);
  sString := Conf.ReadString(GateClass, 'Title', '');
  if sString = '' then Conf.WriteString(GateClass, 'Title', g_Config.TitleName);
  nInteger := Conf.ReadInteger(GateClass, 'ServerPort', -1);
  if nInteger = -1 then Conf.WriteInteger(GateClass, 'ServerPort', g_Config.ServerPort);
  sString := Conf.ReadString(GateClass, 'ServerAddr', '');
  if sString = '' then Conf.WriteString(GateClass, 'ServerAddr', g_Config.ServerAddr);
  nInteger := Conf.ReadInteger(GateClass, 'GatePort', -1);
  if nInteger = -1 then Conf.WriteInteger(GateClass, 'GatePort', g_Config.GatePort);
  sString := Conf.ReadString(GateClass, 'GateAddr', '');
  if sString = '' then Conf.WriteString(GateClass, 'GateAddr', g_Config.GateAddr);
  nInteger := Conf.ReadInteger(GateClass, 'KeepConnectTimeOut', -1);
  if nInteger = -1 then Conf.WriteInteger(GateClass, 'KeepConnectTimeOut', g_Config.dwKeepConnectTimeOut);
  nInteger := Conf.ReadInteger(GateClass, 'MaxConnOfIPaddr', -1);
  if nInteger = -1 then Conf.WriteInteger(GateClass, 'MaxConnOfIPaddr', g_Config.nMaxConnOfIPaddr);
  nInteger := Conf.ReadInteger(GateClass, 'Minimize', -1);
  if nInteger = -1 then Conf.WriteBool(GateClass, 'Minimize', g_Config.boMinimize);

  nInteger := Conf.ReadInteger(GateClass, 'ConnctCheckTime', -1);
  if nInteger = -1 then Conf.WriteInteger(GateClass, 'ConnctCheckTime', g_Config.nConnctCheckTime);

  nInteger := Conf.ReadInteger(GateClass, 'MaxCount', -1);
  if nInteger = -1 then Conf.WriteInteger(GateClass, 'MaxCount', g_Config.nMaxCount);

  nInteger := Conf.ReadInteger(GateClass, 'MaxOnlineCount', -1);
  if nInteger = -1 then Conf.WriteInteger(GateClass, 'MaxOnlineCount', g_Config.nMaxOnlineCount);

  nInteger := Conf.ReadInteger(GateClass, 'RefLoadIpListTime', -1);
  if nInteger = -1 then Conf.WriteInteger(GateClass, 'RefLoadIpListTime', g_Config.nRefLoadIpListTime);



  g_Config.TitleName := Conf.ReadString(GateClass, 'Title', g_Config.TitleName);
  g_Config.ServerPort := Conf.ReadInteger(GateClass, 'ServerPort', g_Config.ServerPort);
  g_Config.ServerAddr := Conf.ReadString(GateClass, 'ServerAddr', g_Config.ServerAddr);
  g_Config.GatePort := Conf.ReadInteger(GateClass, 'GatePort', g_Config.GatePort);
  g_Config.GateAddr := Conf.ReadString(GateClass, 'GateAddr', g_Config.GateAddr);
  g_Config.dwKeepConnectTimeOut := Conf.ReadInteger(GateClass, 'KeepConnectTimeOut', g_Config.dwKeepConnectTimeOut);
  g_Config.nMaxConnOfIPaddr := Conf.ReadInteger(GateClass, 'MaxConnOfIPaddr', g_Config.nMaxConnOfIPaddr);
  g_Config.nConnctCheckTime := Conf.ReadInteger(GateClass, 'ConnctCheckTime', g_Config.nConnctCheckTime);
  g_boCheckAttack := Conf.ReadBool(GateClass, 'CheckAttack', g_boCheckAttack);
  g_Config.nMaxCount := Conf.ReadInteger(GateClass, 'MaxCount', g_Config.nMaxCount);
  g_Config.nMaxOnlineCount := Conf.ReadInteger(GateClass, 'MaxOnlineCount', g_Config.nMaxOnlineCount);
  g_Config.nRefLoadIpListTime := Conf.ReadInteger(GateClass, 'RefLoadIpListTime', g_Config.nRefLoadIpListTime);
  g_Config.boMinimize := Conf.ReadBool(GateClass, 'Minimize', g_Config.boMinimize);

  g_sIpListUrl := Conf.ReadString(GateClass, 'IpListUrl', g_sIpListUrl);
  Conf.Free;

  LoadIPListFile();
  LoadBlockIPFile();
  LoadBlockIPArrayFile;
end;

initialization
  begin
    InitializeCriticalSection(g_CS);
    InitializeCriticalSection(g_UserCriticalSection);
    MainLogMsgList := TGStringList.Create;
    UpdateLogMsgList := TGStringList.Create;
  end;
finalization
  begin
    UpdateLogMsgList.Free;
    ClearMessage;
    MainLogMsgList.Free;
    DeleteCriticalSection(g_CS);
    DeleteCriticalSection(g_UserCriticalSection);
  end;
end.

