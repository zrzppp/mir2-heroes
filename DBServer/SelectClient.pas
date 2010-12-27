unit SelectClient;

interface
uses
  Windows, Classes, SysUtils, StrUtils, SyncObjs, Forms, WinSock, JSocket, IDSocCli, Grobal2, Common;
type
  TDisabledChar = record
    sChrName: string[14];
    wLevel: LongInt;
    btJob: Byte;
    btSex: Byte;
  end;
  pTDisabledChar = ^TDisabledChar;

  TUserInfo = record
    nIndex: Integer;
    sAccount: string;
    sUserIPaddr: string;
    sGateIPaddr: string;
    sConnID: string;
    nSessionID: Integer;
    Socket: TCustomWinSocket;
    sReceiveText: string;
    boChrSelected: Boolean;
    boChrQueryed: Boolean;
    dwTick34: LongWord;
    dwChrTick: LongWord;
    nSelGateID: ShortInt; //角色网关ID

    boRandomNumber: Boolean; //0x31
    sRandomNumber: string;
    dwRandomTick: LongWord; //0x38
    dwQueryDelChrTick: LongWord; //0x38
    dwRestoreChr: LongWord; //0x38
  end;
  pTUserInfo = ^TUserInfo;

  TUserArray = array[0..5000 - 1] of TUserInfo;

  TSelectChar = class
  private
    UserArray: TUserArray;
    OnLineList: TList;
    DeleteList: TList;
    function GetItem(Index: Integer): pTUserInfo;
    function GetCount: Integer;

    function GetOnLineItem(Index: Integer): pTUserInfo;
    function GetOnLineCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Initialize; overload;
    procedure Finalize; overload;
    procedure Initialize(Index: Integer); overload;
    procedure Finalize(Index: Integer); overload;
    function Add: Integer;

    property Items[Index: Integer]: pTUserInfo read GetItem;
    property Count: Integer read GetCount;
    property OnLineItems[Index: Integer]: pTUserInfo read GetOnLineItem;
    property OnLineCount: Integer read GetOnLineCount;
  end;

  TSelectClient = class{$IF DBSUSETHREAD = 1}(TServerClientThread){$ELSE}(TServerClientWinSocket){$IFEND}
    m_dwKeepAliveTick: LongWord;
    m_sReceiveText: string;
    m_sGateaddr: string; //0x04
    m_dwTick10: LongWord; //0x10
    m_nGateID: Integer; //网关ID

    m_Module: Pointer;
    m_dwCheckServerTimeMin: LongWord;
    m_dwCheckServerTimeMax: LongWord;
    m_dwCheckRecviceTick: LongWord;
    SelectCharList: TSelectChar;
  private
    procedure OpenUser(sID, sIP: string);
    procedure CloseUser(sID: string);
    procedure ProcessUserMsg(UserInfo: pTUserInfo);
    procedure DeCodeUserMsg(sData: string; UserInfo: pTUserInfo);

    function NewChrData(sChrName: string; nSex, nJob, nHair: Integer): Boolean;
    function QueryChr(sData: string; UserInfo: pTUserInfo): Boolean;
    procedure DelChr(sData: string; UserInfo: pTUserInfo);
    procedure NewChr(sData: string; UserInfo: pTUserInfo);
    function SelectChr(sData: string; UserInfo: pTUserInfo): Boolean;

    function QueryDisabledChr(sData: string; UserInfo: pTUserInfo): Boolean;
    procedure RestoreChr(sData: string; UserInfo: pTUserInfo);

    procedure SendRandomCodeMap(UserInfo: pTUserInfo; BitCount: Integer);
  public
    destructor Destroy; override;
{$IF DBSUSETHREAD = 1}
    constructor Create(ASocket: TServerClientWinSocket);
    procedure ClientExecute; override;
    procedure Close;
{$ELSE}
    constructor Create(Socket: TSocket; ServerWinSocket: TServerWinSocket);
{$IFEND}
    procedure ExecGateBuffers(Buffer: PChar; BufLen: Integer);
    procedure SendKeepAlivePacket();
    procedure SendKickUser(SocketHandle: string; nKickType: Integer);
    procedure OutOfConnect(sSessionID: string);
    procedure SendUserSocket(sSessionID, sSendMsg: string);
  end;
implementation
uses EncryptUnit, HUtil32, MudUtil, DBShare;
{------------------------------------------------------------------------------}

constructor TSelectChar.Create;
begin
  OnLineList := TList.Create;
  DeleteList := TList.Create;
  Initialize;
end;

destructor TSelectChar.Destroy;
begin
  Finalize;
  DeleteList.Free;
  OnLineList.Free;
end;

function TSelectChar.GetItem(Index: Integer): pTUserInfo;
begin
  if (Index >= 0) and (Index < Length(UserArray)) then
    Result := @UserArray[Index]
  else
    Result := nil;
end;

function TSelectChar.GetCount: Integer;
begin
  Result := Length(UserArray);
end;

function TSelectChar.GetOnLineItem(Index: Integer): pTUserInfo;
begin
  if (Index >= 0) and (Index < OnLineList.Count) then
    Result := GetItem(Integer(OnLineList[Index]))
  else
    Result := nil;
end;

function TSelectChar.GetOnLineCount: Integer;
begin
  Result := OnLineList.Count;
end;

function TSelectChar.Add: Integer;
var
  I, nIndex: Integer;
  tUserInfo: pTUserInfo;
begin
  Result := -1;
  if DeleteList.Count > 0 then begin
    nIndex := Integer(DeleteList[0]);
    OnLineList.Add(Pointer(nIndex));
    Result := nIndex;
    DeleteList.Delete(0);
  end else begin
    for I := 0 to Count - 1 do begin
      tUserInfo := Items[I];
      if tUserInfo.Socket = nil then begin
        OnLineList.Add(Pointer(I));
        Result := I;
        break;
      end;
    end;
  end;
end;

procedure TSelectChar.Initialize;
var
  I: Integer;
  UserInfo: pTUserInfo;
begin
  OnLineList.Clear;
  DeleteList.Clear;
  for I := 0 to Count - 1 do begin
    UserInfo := Items[I];
    UserInfo.nIndex := -1;
    UserInfo.sAccount := '';
    UserInfo.sUserIPaddr := '';
    UserInfo.sGateIPaddr := '';
    UserInfo.sConnID := '';
    UserInfo.nSessionID := 0;
    UserInfo.Socket := nil;
    UserInfo.sReceiveText := '';
    UserInfo.dwTick34 := GetTickCount();
    UserInfo.dwChrTick := GetTickCount();
    UserInfo.boChrSelected := False;
    UserInfo.boChrQueryed := False;
    UserInfo.nSelGateID := 0;

    UserInfo.dwQueryDelChrTick := GetTickCount();
    UserInfo.dwRestoreChr := GetTickCount();
    UserInfo.dwRandomTick := 0;
    UserInfo.boRandomNumber := False;
    UserInfo.sRandomNumber := '';
  end;
end;

procedure TSelectChar.Finalize;
var
  I: Integer;
  UserInfo: pTUserInfo;
begin
  for I := 0 to Count - 1 do begin
    UserInfo := Items[I];
    UserInfo.nIndex := -1;
    UserInfo.Socket := nil;
    UserInfo.sAccount := '';
    UserInfo.sUserIPaddr := '';
    UserInfo.sGateIPaddr := '';
    UserInfo.sConnID := '';
    UserInfo.sReceiveText := '';
  end;
end;

procedure TSelectChar.Initialize(Index: Integer);
var
  UserInfo: pTUserInfo;
begin
  UserInfo := Items[Index];
  if UserInfo <> nil then begin
    UserInfo.nIndex := -1;
    UserInfo.sAccount := '';
    UserInfo.sUserIPaddr := '';
    UserInfo.sGateIPaddr := '';
    UserInfo.sConnID := '';
    UserInfo.nSessionID := 0;
    UserInfo.Socket := nil;
    UserInfo.sReceiveText := '';
    UserInfo.dwTick34 := GetTickCount();
    UserInfo.dwChrTick := GetTickCount();
    UserInfo.boChrSelected := False;
    UserInfo.boChrQueryed := False;
    UserInfo.nSelGateID := 0;

    UserInfo.dwQueryDelChrTick := GetTickCount();
    UserInfo.dwRestoreChr := GetTickCount();
    UserInfo.dwRandomTick := 0;
    UserInfo.boRandomNumber := False;
    UserInfo.sRandomNumber := '';
  end;
end;

procedure TSelectChar.Finalize(Index: Integer);
var
  UserInfo: pTUserInfo;
begin
  UserInfo := Items[Index];
  if UserInfo <> nil then begin
    OnLineList.Remove(Pointer(Index));
    DeleteList.Add(Pointer(Index));
    UserInfo.nIndex := -1;
    UserInfo.Socket := nil;
    UserInfo.sAccount := '';
    UserInfo.sUserIPaddr := '';
    UserInfo.sGateIPaddr := '';
    UserInfo.sConnID := '';
    UserInfo.sReceiveText := '';
  end;
end;

{------------------------------------------------------------------------------}
{$IF DBSUSETHREAD = 1}

constructor TSelectClient.Create(ASocket: TServerClientWinSocket);
begin
  m_dwKeepAliveTick := GetTickCount;
  m_sReceiveText := '';
  m_sGateaddr := '';
  m_dwTick10 := GetTickCount;
  m_nGateID := 0;
  m_Module := nil;
  m_dwCheckServerTimeMin := GetTickCount;
  m_dwCheckServerTimeMax := 0; //GetTickCount;
  m_dwCheckRecviceTick := GetTickCount;
  SelectCharList := TSelectChar.Create;
  inherited Create(False, ASocket);
end;
{$ELSE}

constructor TSelectClient.Create(Socket: TSocket; ServerWinSocket: TServerWinSocket);
begin
  m_dwKeepAliveTick := GetTickCount;
  m_sReceiveText := '';
  m_sGateaddr := '';
  m_dwTick10 := GetTickCount;
  m_nGateID := 0;
  m_Module := nil;
  m_dwCheckServerTimeMin := GetTickCount;
  m_dwCheckServerTimeMax := 0; //GetTickCount;
  m_dwCheckRecviceTick := GetTickCount;
  SelectCharList := TSelectChar.Create;
  inherited Create(Socket, ServerWinSocket);
end;
{$IFEND}

destructor TSelectClient.Destroy;
begin
  SelectCharList.Free;
  inherited;
end;

{$IF DBSUSETHREAD = 1}

procedure TSelectClient.Close;
begin
  if ClientSocket <> nil then
    ClientSocket.Close;
  Terminate;
end;

procedure TSelectClient.ClientExecute;
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
              ExecGateBuffers(@RecvBuffer, nMsgLen)
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

procedure TSelectClient.SendKeepAlivePacket();
begin
{$IF DBSUSETHREAD = 1}
  if ClientSocket.Connected then begin
    try
      ClientSocket.SendText('%++$');
    except
      Close;
    end;
    {m_dwKeepAliveTick := GetTickCount();
    m_dwCheckServerTimeMin := GetTickCount - m_dwCheckRecviceTick;
    if m_dwCheckServerTimeMin > m_dwCheckServerTimeMax then m_dwCheckServerTimeMax := m_dwCheckServerTimeMin;
    m_dwCheckRecviceTick := GetTickCount();
    if m_Module <> nil then
      pTModuleInfo(m_Module).Buffer := Format('%d/%d', [m_dwCheckServerTimeMin, m_dwCheckServerTimeMax]);}
  end;
{$ELSE}
  //if Connected then begin
    //try
  SendText('%++$');
    //except
      //Close;
    //end;
  //end;
{$IFEND}
  m_dwKeepAliveTick := GetTickCount();
  m_dwCheckServerTimeMin := GetTickCount - m_dwCheckRecviceTick;
  if m_dwCheckServerTimeMin > m_dwCheckServerTimeMax then m_dwCheckServerTimeMax := m_dwCheckServerTimeMin;
  m_dwCheckRecviceTick := GetTickCount();
  if m_Module <> nil then
    pTModuleInfo(m_Module).Buffer := Format('%d/%d', [m_dwCheckServerTimeMin, m_dwCheckServerTimeMax]);
end;

procedure TSelectClient.SendKickUser(SocketHandle: string; nKickType: Integer);
begin
{$IF DBSUSETHREAD = 1}
  if ClientSocket.Connected then begin
    try
      case nKickType of
        0: ClientSocket.SendText('%+-' + SocketHandle + '$');
        1: ClientSocket.SendText('%+T' + SocketHandle + '$');
        2: ClientSocket.SendText('%+B' + SocketHandle + '$');
      end;
    except
      Close;
    end;
  end;
{$ELSE}
  //if Connected then begin
    //try
  case nKickType of
    0: SendText('%+-' + SocketHandle + '$');
    1: SendText('%+T' + SocketHandle + '$');
    2: SendText('%+B' + SocketHandle + '$');
  end;
    //except
    //  Close;
    //end;
  //end;
{$IFEND}
end;

procedure TSelectClient.SendUserSocket(sSessionID, sSendMsg: string);
begin
{$IF DBSUSETHREAD = 1}
  if ClientSocket.Connected then begin
    try
      ClientSocket.SendText('%' + sSessionID + '/#' + sSendMsg + '!$');
    except
      Close;
    end;
  end;
{$ELSE}
  //if Connected then begin
  //  try
  SendText('%' + sSessionID + '/#' + sSendMsg + '!$');
  //  except
  //    Close;
  //  end;
  //end;
{$IFEND}
end;

procedure TSelectClient.OutOfConnect(sSessionID: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(SM_OUTOFCONNECTION, 0, 0, 0, 0);
  SendUserSocket(sSessionID, EncodeMessage(Msg));
end;

procedure TSelectClient.ExecGateBuffers(Buffer: PChar; BufLen: Integer);
var
  sReceiveText: string;
  s0C: string;
  s10: string;
  s19: Char;
  nError: Integer;
  I: Integer;
  UserInfo: pTUserInfo;
  nCount: Integer;
begin
  try
    nCount := 0;
    nError := 0;
    SetLength(sReceiveText, BufLen);
    nError := 1;
    Move(Buffer^, sReceiveText[1], BufLen);
    nError := 2;
    m_sReceiveText := m_sReceiveText + sReceiveText;
    nError := 3;
    while (True) do begin
      if Pos('$', m_sReceiveText) <= 0 then Break;
      nError := 4;
      m_sReceiveText := ArrestStringEx(m_sReceiveText, '%', '$', s10);
      nError := 5;
      if s10 <> '' then begin
        s19 := s10[1];
        nError := 6;
        s10 := Copy(s10, 2, Length(s10) - 1);
        nError := 7;
        case Ord(s19) of
          Ord('-'): begin
              nError := 8;
              SendKeepAlivePacket;
            end;
          Ord('D'): begin
              nError := 9;
              s10 := GetValidStr3(s10, s0C, ['/']);
              for I := 0 to SelectCharList.OnLineCount - 1 do begin
                UserInfo := SelectCharList.OnLineItems[I];
                if UserInfo <> nil then begin
                  if UserInfo.sConnID = s0C then begin
                    UserInfo.sReceiveText := UserInfo.sReceiveText + s10;
                    if Pos('!', s10) < 1 then Continue;
                    nError := 10;
                    ProcessUserMsg(UserInfo);
                    Break;
                  end;
                end;
              end;
            end;
          Ord('N'): begin
              nError := 11;
              s10 := GetValidStr3(s10, s0C, ['/']);
              OpenUser(s0C, s10);
            end;
          Ord('C'): begin
              nError := 12;
              CloseUser(s10);
            end;
        else begin
            if nCount >= 1 then begin //防止DBS溢出攻击
              m_sReceiveText := '';
              Break;
            end;
            Inc(nCount);
          end;
        end;
      end else begin //防止DBS溢出攻击
        m_sReceiveText := '';
        Break;
      end;
    end;
  except
    MainOutMessage('[Exception] TDBSERVER::ExecBuffers:' + IntToStr(nError));
  end;
end;

procedure TSelectClient.ProcessUserMsg(UserInfo: pTUserInfo);
var
  s10: string;
  nC: Integer;
begin
  nC := 0;
  while (True) do begin
    if TagCount(UserInfo.sReceiveText, '!') <= 0 then Break;
    UserInfo.sReceiveText := ArrestStringEx(UserInfo.sReceiveText, '#', '!', s10);
    if s10 <> '' then begin
      s10 := Copy(s10, 2, Length(s10) - 1);
      if Length(s10) >= DEFBLOCKSIZE then begin
        DeCodeUserMsg(s10, UserInfo);
        //MainOutMessage('DeCodeUserMsg');
      end; // else Inc(n4ADC20);
    end else begin
      //Inc(n4ADC1C);
      if nC >= 1 then begin
        UserInfo.sReceiveText := '';
      end;
      Inc(nC);
    end;
  end;
end;

procedure TSelectClient.OpenUser(sID, sIP: string);
var
  I, nIndex: Integer;
  UserInfo: pTUserInfo;
  sUserIPaddr: string;
  sGateIPaddr: string;
begin
  sGateIPaddr := GetValidStr3(sIP, sUserIPaddr, ['/']);
  for I := 0 to SelectCharList.OnLineCount - 1 do begin
    UserInfo := SelectCharList.OnLineItems[I];
    if (UserInfo <> nil) and (UserInfo.sConnID = sID) then begin
      Exit;
    end;
  end;
  nIndex := SelectCharList.Add;
  if nIndex >= 0 then begin
    SelectCharList.Initialize(nIndex);
    UserInfo := SelectCharList.Items[nIndex];
    UserInfo.nIndex := nIndex;
    UserInfo.sUserIPaddr := sUserIPaddr;
    UserInfo.sGateIPaddr := sGateIPaddr;
    UserInfo.sConnID := sID;
{$IF DBSUSETHREAD = 1}
    UserInfo.Socket := ClientSocket;
{$ELSE}
    UserInfo.Socket := Self;
{$IFEND}
    UserInfo.nSelGateID := m_nGateID;
  end;
end;

procedure TSelectClient.CloseUser(sID: string);
var
  I: Integer;
  UserInfo: pTUserInfo;
begin
  for I := 0 to SelectCharList.OnLineCount - 1 do begin
    UserInfo := SelectCharList.OnLineItems[I];
    if (UserInfo <> nil) and (UserInfo.sConnID = sID) then begin
      if not FrmIDSoc.GetGlobaSessionStatus(UserInfo.nSessionID) then begin
        FrmIDSoc.SendSocketMsg(SS_SOFTOUTSESSION, UserInfo.sAccount + '/' + IntToStr(UserInfo.nSessionID));
        FrmIDSoc.CloseSession(UserInfo.sAccount, UserInfo.nSessionID);
      end;
      SelectCharList.Finalize(UserInfo.nIndex);
      Break;
    end;
  end;
end;

procedure TSelectClient.SendRandomCodeMap(UserInfo: pTUserInfo; BitCount: Integer);
const
  B64: array[0..61] of byte = (65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
    81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108,
    109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 48, 49, 50, 51, 52, 53,
    54, 55, 56, 57);
var
  I: Integer;
  Key: string;
  P: PChar;
  nSize: Integer;
  sBuffer: string;
  //DIB: TDIB;
begin
  if g_boRandomNumber then begin
    SetLength(Key, 3);
    P := PChar(Key);
    for I := 1 to 3 do begin
      P^ := Chr(B64[Random(61)]);
      Inc(P);
    end;
    UserInfo.sRandomNumber := Key;
    SendUserSocket(UserInfo.sConnID, EncodeMessage(MakeDefaultMsg(SM_SENDRANDOMCODE, 0, 0, 0, 0)) + EncryptString(Key));
  end else begin
    SendUserSocket(UserInfo.sConnID, EncodeMessage(MakeDefaultMsg(SM_SENDRANDOMCODE, 1, 0, 0, 0)));
  end;
  {
  DIB := TDIB.Create;
  if BitCount = 16 then begin
    DIB.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
    nSize := 36 * 16 * 2;
  end else begin
    nSize := 36 * 16 * 4;
  end;
  DIB.SetSize(36, 16, 16);
  DIB.Canvas.Font.Name := '宋体';
  //DIB.Canvas.Font.Assign(Canvas.Font);
  DIB.Canvas.Font.Size := 12;
  DIB.Canvas.Font.Style := [fsBold];
  DIB.Canvas.Brush.Color := clBtnFace;
  DIB.Canvas.FillRect(Bounds(0, 0, 36, 16));
  DIB.Canvas.TextOut(0, 0, UserInfo.sRandomNumber);
  DIB.DoAddMonoNoise(50);

  SetLength(sBuffer, nSize);
  Move(DIB.PBits^, sBuffer[1], nSize);
  SendUserSocket(UserInfo.Socket,
    UserInfo.sConnID,
    EncodeMessage(MakeDefaultMsg(SM_SENDRANDOMCODE, 0, 0, 0, 0)) + sBuffer);

  DIB.Free;
  }
end;

procedure TSelectClient.DeCodeUserMsg(sData: string; UserInfo: pTUserInfo);
var
  sDefMsg, s18: string;
  Msg: TDefaultMessage;
begin
  sDefMsg := Copy(sData, 1, DEFBLOCKSIZE);
  s18 := Copy(sData, DEFBLOCKSIZE + 1, Length(sData) - DEFBLOCKSIZE);
  Msg := DecodeMessage(sDefMsg);
  try
    case Msg.Ident of
      CM_QUERYRANDOMCODE: begin //发送验证码
          if {not UserInfo.boChrQueryed or }((GetTickCount - UserInfo.dwRandomTick) > 200) then begin
            UserInfo.dwRandomTick := GetTickCount();
            SendRandomCodeMap(UserInfo, Msg.Param);
        {end else begin //DecodeString(sData)
          if boAttack then SendKickUser(UserInfo.Socket, UserInfo.sConnID, 0);
          Inc(g_nQueryChrCount);
          MainOutMessage('[超速操作] 查询验证码 ' + UserInfo.sUserIPaddr);      }
          end else begin
            MainOutMessage('[端口攻击] _QUERYRANDOMCODE ' + UserInfo.sAccount + '/' + UserInfo.sUserIPaddr);
          end;
        end;
      CM_SENDRANDOMCODE: begin //检测验证码
          s18 := DecodeString(s18);
          if (not g_boRandomNumber) or (CompareText(s18, UserInfo.sRandomNumber) = 0) then begin
            UserInfo.boRandomNumber := True;
            FrmIDSoc.SetSessionRandomCodeOK(UserInfo.sAccount, UserInfo.sUserIPaddr, UserInfo.nSessionID, True);
          //MainOutMessage('查询验证码');
          end else begin
            OutOfConnect(UserInfo.sConnID);
          //MainOutMessage('OutOfConnect(UserInfo);');
          //SendUserSocket(UserInfo.Socket, UserInfo.sConnID, EncodeMessage(MakeDefaultMsg(SM_OUTOFCONNECTION, 0, 0, 0, 0)));
          end;
        end;

      CM_QUERYCHR: begin
        //MainOutMessage('CM_QUERYCHR');
          if not UserInfo.boChrQueryed or ((GetTickCount - UserInfo.dwChrTick) > 200) then begin
            UserInfo.dwChrTick := GetTickCount();
            if QueryChr(s18, UserInfo) then begin
              UserInfo.boChrQueryed := True;
            end;
          end else begin
          //Inc(g_nQueryChrCount);
            MainOutMessage('[端口攻击] _QUERYCHR ' + UserInfo.sAccount + '/' + UserInfo.sUserIPaddr);
          end;
        end;
      CM_NEWCHR: begin
        //MainOutMessage('CM_NEWCHR');
          if (GetTickCount - UserInfo.dwChrTick) > 1000 then begin
            UserInfo.dwChrTick := GetTickCount();
            if (UserInfo.sAccount <> '')
              and FrmIDSoc.CheckSession(UserInfo.sAccount, UserInfo.sUserIPaddr, UserInfo.nSessionID) then begin
              NewChr(s18, UserInfo);
              UserInfo.boChrQueryed := False;
            end else begin
              OutOfConnect(UserInfo.sConnID);
            end;
          end else begin
          //Inc(nHackerNewChrCount);
            MainOutMessage('[端口攻击] _NEWCHR ' + UserInfo.sAccount + '/' + UserInfo.sUserIPaddr);
          end;
        end;
      CM_DELCHR: begin
          if (GetTickCount - UserInfo.dwChrTick) > 1000 then begin
            UserInfo.dwChrTick := GetTickCount();
            if (UserInfo.sAccount <> '')
              and FrmIDSoc.CheckSession(UserInfo.sAccount, UserInfo.sUserIPaddr, UserInfo.nSessionID) then begin
              DelChr(s18, UserInfo);
              UserInfo.boChrQueryed := False;
            end else begin
              OutOfConnect(UserInfo.sConnID);
            end;
          end else begin
          //Inc(nHackerDelChrCount);
            MainOutMessage('[端口攻击] _DELCHR ' + UserInfo.sAccount + '/' + UserInfo.sUserIPaddr);
          end;
        end;
      CM_SELCHR: begin
          if not UserInfo.boChrQueryed then begin
            if (UserInfo.sAccount <> '')
              and FrmIDSoc.CheckSession(UserInfo.sAccount, UserInfo.sUserIPaddr, UserInfo.nSessionID)
              and ((not g_boRandomNumber) or FrmIDSoc.GetSessionRandomCodeOK(UserInfo.sAccount, UserInfo.sUserIPaddr, UserInfo.nSessionID)) then begin
              if SelectChr(s18, UserInfo) then begin
                UserInfo.boChrSelected := True;
              end;
            end else begin
              OutOfConnect(UserInfo.sConnID);
            end;
          end else begin
          //Inc(nHackerSelChrCount);
            MainOutMessage('[端口攻击] _SELCHR ' + UserInfo.sAccount + '/' + UserInfo.sUserIPaddr);
          end;
        end;

      CM_QUERYDELCHR: begin //查询删除的人物
          if ((GetTickCount - UserInfo.dwQueryDelChrTick) > 200) then begin
            UserInfo.dwChrTick := GetTickCount();
            if QueryDisabledChr(s18, UserInfo) then begin
            //UserInfo.boChrQueryed := True;
            end;
          end else begin
          //Inc(g_nQueryChrCount);
            MainOutMessage('[端口攻击] _QUERYDELCHR ' + UserInfo.sAccount + '/' + UserInfo.sUserIPaddr);
          end;
        end;

      CM_RESTORECHR: begin //找回人物
          if ((GetTickCount - UserInfo.dwRestoreChr) > 200) then begin
            UserInfo.dwChrTick := GetTickCount();
            RestoreChr(s18, UserInfo);
          end else begin
          //Inc(g_nQueryChrCount);
            MainOutMessage('[端口攻击] _RESTORECHR ' + UserInfo.sAccount + '/' + UserInfo.sUserIPaddr);
          end;
        end;

    else begin
      //Inc(n4ADC24);
      end;
    end;
  except
    MainOutMessage('[Exception] TDBSERVER::DeCodeUserMsg:' + IntToStr(Msg.Ident));
  end;
end;

{-------------------------------------------------------------------------------}

function TSelectClient.QueryDisabledChr(sData: string; UserInfo: pTUserInfo): Boolean;
var
  sAccount: string;
  sChrName: string;
  sSessionID: string;
  nSessionID: Integer;
  nChrCount: Integer;
  ChrList: TList;
  I: Integer;
  nIndex: Integer;
  ChrRecord: THumDataInfo;
  HumRecord: THumInfo;
  QuickID: pTQuickID;
  s40: string;
  DisabledChar: TDisabledChar;
begin
  sAccount := DecodeString(sData);
  nChrCount := 0;
  s40 := '';
  //ChrList := TStringList.Create;
  try
    if g_HumCharDB.Open and (g_HumCharDB.FindByAccount(sAccount, ChrList) >= 0) then begin
      try
        if g_HumDataDB.OpenEx then begin
          for I := 0 to ChrList.Count - 1 do begin
            QuickID := pTQuickID(ChrList.Items[I]);
            if QuickID.boIsHero then Continue;
            if nChrCount >= 10 then Break;
              //FrmDBSrv.MemoLog.Lines.Add('UserInfo.nSelGateID: '+IntToStr(UserInfo.nSelGateID)+' QuickID.nIndex: '+IntToStr(QuickID.nIndex));
              //如果选择ID不对,则跳过
              //if QuickID.nIndex <> UserInfo.nSelGateID then Continue;
            if g_HumCharDB.GetBy(QuickID.nIndex, @HumRecord) and HumRecord.boDeleted then begin
              sChrName := QuickID.sChrName;
              nIndex := g_HumDataDB.Index(sChrName);
              if nIndex < 0 then Continue;
              if g_HumDataDB.Get(nIndex, @ChrRecord) >= 0 then begin
                DisabledChar.sChrName := sChrName;
                DisabledChar.wLevel := ChrRecord.Data.Abil.Level;
                DisabledChar.btJob := ChrRecord.Data.btJob;
                DisabledChar.btSex := ChrRecord.Data.btSex;
                s40 := s40 + EncodeBuffer(@DisabledChar, SizeOf(TDisabledChar)) + '/';
                Inc(nChrCount);
              end;
            end;
          end;
        end;
      finally
        g_HumDataDB.Close;
      end;
    end;
  finally
    g_HumCharDB.Close;
  end;
  //ChrList.Free;
  if s40 <> '' then begin
    SendUserSocket(UserInfo.sConnID, EncodeMessage(MakeDefaultMsg(SM_FINDDELCHR, nChrCount, 0, 1, 0)) + s40);
  end;
end;

procedure TSelectClient.RestoreChr(sData: string; UserInfo: pTUserInfo);
var
  sAccount: string;
  sSessionID: string;
  nSessionID: Integer;
  nChrCount: Integer;
  ChrList: TList;
  I: Integer;
  n10: Integer;
  nIndex: Integer;
  ChrRecord: THumDataInfo;
  HumRecord: THumInfo;
  QuickID: pTQuickID;
  btSex: Byte;
  sChrName: string;
  sJob: string;
  sHair: string;
  sLevel: string;
  s40: string;
  boCheck: Boolean;
begin
  sChrName := GetValidStr3(DecodeString(sData), sAccount, ['/']);
  nChrCount := 0;
  boCheck := False;
  try
    if g_HumCharDB.Open and (g_HumCharDB.FindByAccount(sAccount, ChrList) >= 0) then begin
      try
        if g_HumDataDB.OpenEx then begin
          for I := 0 to ChrList.Count - 1 do begin
            QuickID := pTQuickID(ChrList.Items[I]);
            if QuickID.boIsHero then Continue;
            if g_HumCharDB.GetBy(QuickID.nIndex, @HumRecord) then begin
              if not HumRecord.boDeleted then Inc(nChrCount);
              if nChrCount >= 2 then Break;
            end;
          end;
          if nChrCount < 2 then begin
            for I := 0 to ChrList.Count - 1 do begin
              QuickID := pTQuickID(ChrList.Items[I]);
              if QuickID.boIsHero then Continue;
              if sChrName = QuickID.sChrName then begin
                if g_HumCharDB.GetBy(QuickID.nIndex, @HumRecord) and HumRecord.boDeleted then begin
                  n10 := g_HumCharDB.Index(sChrName);
                  if n10 >= 0 then begin
                    if HumRecord.sAccount = UserInfo.sAccount then begin
                      HumRecord.boDeleted := False;
                      HumRecord.dModDate := Now();
                      g_HumCharDB.Update(n10, @HumRecord);
                      boCheck := True;
                      Break;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      finally
        g_HumDataDB.Close;
      end;
    end;
  finally
    g_HumCharDB.Close;
  end;

  if nChrCount >= 2 then begin
    SendUserSocket(UserInfo.sConnID, EncodeMessage(MakeDefaultMsg(SM_FINDDELCHR_FAIL, 0, 0, 0, 0)));
  end else begin
    if boCheck then begin
      s40 := '';
      nChrCount := 0;
      try
        if g_HumCharDB.Open and (g_HumCharDB.FindByAccount(sAccount, ChrList) >= 0) then begin
          try
            if g_HumDataDB.OpenEx then begin
              for I := 0 to ChrList.Count - 1 do begin
                QuickID := pTQuickID(ChrList.Items[I]);
                if QuickID.boIsHero then Continue;
                if (nChrCount >= 2) then break;
              //FrmDBSrv.MemoLog.Lines.Add('UserInfo.nSelGateID: '+IntToStr(UserInfo.nSelGateID)+' QuickID.nIndex: '+IntToStr(QuickID.nIndex));
              //如果选择ID不对,则跳过
              //if QuickID.nIndex <> UserInfo.nSelGateID then Continue;
                if g_HumCharDB.GetBy(QuickID.nIndex, @HumRecord) and (not HumRecord.boDeleted) then begin
                  sChrName := QuickID.sChrName;
                  nIndex := g_HumDataDB.Index(sChrName);
                  if (nIndex < 0) then Continue;
                  if g_HumDataDB.Get(nIndex, @ChrRecord) >= 0 then begin
                    btSex := ChrRecord.Data.btSex;
                    sJob := IntToStr(ChrRecord.Data.btJob);
                    sHair := IntToStr(ChrRecord.Data.btHair);
                    sLevel := IntToStr(ChrRecord.Data.Abil.Level);
                    if HumRecord.boSelected then s40 := s40 + '*';
                    s40 := s40 + sChrName + '/' + sJob + '/' + sHair + '/' + sLevel + '/' + IntToStr(btSex) + '/';
                    Inc(nChrCount);
                  end;
                end;
              end;
            end;
          finally
            g_HumDataDB.Close;
          end;
        end;
      finally
        g_HumCharDB.Close;
      end;

      SendUserSocket(UserInfo.sConnID, EncodeMessage(MakeDefaultMsg(SM_QUERYCHR, nChrCount, 0, 1, 0)) + EncodeString(s40));
    //*ChrName/sJob/sHair/sLevel/sSex/
    end else begin
      SendUserSocket(UserInfo.sConnID, EncodeMessage(MakeDefaultMsg(SM_QUERYCHR_FAIL, nChrCount, 0, 1, 0)));
      CloseUser(UserInfo.sConnID);
    end;
  end;
end;

function TSelectClient.NewChrData(sChrName: string; nSex, nJob, nHair: Integer): Boolean;
var
  ChrRecord: THumDataInfo;
begin
  Result := False;
  try
    if g_HumDataDB.Open and (g_HumDataDB.Index(sChrName) = -1) then begin
      FillChar(ChrRecord, SizeOf(THumDataInfo), #0);
      //ChrRecord.Header.nSize := SizeOf(THumDataInfo);
      ChrRecord.Header.dCreateDate := Now;
      ChrRecord.Header.boIsHero := False;
      ChrRecord.Header.sName := sChrName;
      ChrRecord.Header.boDeleted := False;
      ChrRecord.Data.sChrName := sChrName;
      ChrRecord.Data.btSex := nSex;
      ChrRecord.Data.btJob := nJob;
      ChrRecord.Data.btHair := nHair;
      ChrRecord.Data.boIsHero := False;
      ChrRecord.Data.boHasHero := False;
      Result := g_HumDataDB.Add(@ChrRecord);
      Inc(g_nCreateHumCount);
    end;
  finally
    g_HumDataDB.Close;
  end;
end;

procedure TSelectClient.NewChr(sData: string; UserInfo: pTUserInfo);
var
  Data, sAccount, sChrName, sHair, sJob, sSex: string;
  nCode: Integer;

  sMsg: string;
  HumRecord: THumInfo;
  I: Integer;
  DefMsg: TDefaultMessage;
begin
  nCode := -1;
  Data := DecodeString(sData);
  Data := GetValidStr3(Data, sAccount, ['/']);
  Data := GetValidStr3(Data, sChrName, ['/']);
  Data := GetValidStr3(Data, sHair, ['/']);
  Data := GetValidStr3(Data, sJob, ['/']);
  Data := GetValidStr3(Data, sSex, ['/']);
  if Trim(Data) <> '' then nCode := 0;
  sChrName := Trim(sChrName);
  if Length(sChrName) < 3 then nCode := 0;
  if not CheckDenyChrName(sChrName) then nCode := 2;
  if not CheckAIChrName(sChrName) then nCode := 2;
  if not CheckChrName(sChrName) then nCode := 0;
  if not g_boDenyChrName then begin
    for I := 1 to Length(sChrName) do begin
      if (sChrName[I] = #$A1) or
        (sChrName[I] = ' ') or
        (sChrName[I] = '/') or
        (sChrName[I] = '@') or
        (sChrName[I] = '?') or
        (sChrName[I] = '''') or
        (sChrName[I] = '"') or
        (sChrName[I] = '\') or
        (sChrName[I] = '.') or
        (sChrName[I] = ',') or
        (sChrName[I] = ':') or
        (sChrName[I] = ';') or
        (sChrName[I] = '`') or
        (sChrName[I] = '~') or
        (sChrName[I] = '!') or
        (sChrName[I] = '#') or
        (sChrName[I] = '$') or
        (sChrName[I] = '%') or
        (sChrName[I] = '^') or
        (sChrName[I] = '&') or
        (sChrName[I] = '*') or
        (sChrName[I] = '(') or
        (sChrName[I] = ')') or
        (sChrName[I] = '-') or
        (sChrName[I] = '_') or
        (sChrName[I] = '+') or
        (sChrName[I] = '=') or
        (sChrName[I] = '|') or
        (sChrName[I] = '[') or
        (sChrName[I] = '{') or
        (sChrName[I] = ']') or
        (sChrName[I] = ']') or
        //ňńǹ
      (sChrName[I] = '}') then nCode := 0;
    end;
  end;

  if nCode = -1 then begin
    try
      g_HumDataDB.Lock;
      if g_HumDataDB.Index(sChrName) >= 0 then nCode := 2;
    finally
      g_HumDataDB.UnLock;
    end;
  end;

  if nCode = -1 then begin
    try
      if g_HumCharDB.Open then begin
        if g_HumCharDB.ChrCountOfAccount(sAccount) < 2 then begin
          FillChar(HumRecord, SizeOf(THumInfo), #0);
          HumRecord.Header.boIsHero := False;
          HumRecord.Header.sName := sChrName;
          HumRecord.Header.nSelectID := 0;
          HumRecord.Header.boDeleted := False;

          HumRecord.sChrName := sChrName;
          HumRecord.sAccount := sAccount;
          HumRecord.boDeleted := False;
          HumRecord.boIsHero := False;
          HumRecord.btCount := 0;

          if HumRecord.Header.sName <> '' then
            if not g_HumCharDB.Add(@HumRecord) then nCode := 2;
        end else nCode := 3;
      end;
    finally
      g_HumCharDB.Close;
    end;
    if nCode = -1 then begin
      if NewChrData(sChrName, Str_ToInt(sSex, 0), Str_ToInt(sJob, 0), Str_ToInt(sHair, 0)) then
        nCode := 1
      else begin
        try
          if g_HumCharDB.Open then begin
            g_HumCharDB.Delete(sChrName);
          end;
        finally
          g_HumCharDB.Close;
        end;
      end;
    end else begin
      try
        if g_HumCharDB.Open then begin
          g_HumCharDB.Delete(sChrName);
        end;
      finally
        g_HumCharDB.Close;
      end;
      nCode := 4;
    end;
  end;

  if nCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_NEWCHR_SUCCESS, 0, 0, 0, 0);
  end else begin
    DefMsg := MakeDefaultMsg(SM_NEWCHR_FAIL, nCode, 0, 0, 0);
  end;
  SendUserSocket(UserInfo.sConnID, EncodeMessage(DefMsg));
end;

procedure TSelectClient.DelChr(sData: string; UserInfo: pTUserInfo);
var
  sChrName: string;
  boCheck: Boolean;
  Msg: TDefaultMessage;
  sHeroChrName, sMsg: string;
  nIndex, n10: Integer;
  HumRecord: THumInfo;
  //ChrRecord: THumDataInfo;
begin
  if g_boDeleteChrName then begin
    sChrName := DecodeString(sData);
    boCheck := False;
    sHeroChrName := '';
    try
      if g_HumCharDB.Open then begin
        n10 := g_HumCharDB.Index(sChrName);
        if n10 >= 0 then begin
          g_HumCharDB.Get(n10, @HumRecord);
          if HumRecord.sAccount = UserInfo.sAccount then begin
            HumRecord.boDeleted := True;
            HumRecord.dModDate := Now();
            g_HumCharDB.Update(n10, @HumRecord);
            Inc(g_nDeleteHumCount);
            boCheck := True;
          end;
        end;
      end;
    finally
      g_HumCharDB.Close;
    end;

    if boCheck then
      Msg := MakeDefaultMsg(SM_DELCHR_SUCCESS, 0, 0, 0, 0)
    else
      Msg := MakeDefaultMsg(SM_DELCHR_FAIL, 0, 0, 0, 0);

    sMsg := EncodeMessage(Msg);
    SendUserSocket(UserInfo.sConnID, sMsg);
  end;
end;

function TSelectClient.SelectChr(sData: string; UserInfo: pTUserInfo): Boolean;
var
  sAccount: string;
  sChrName: string;
  ChrList: TList;
  HumRecord: THumInfo;
  I: Integer;
  nIndex: Integer;
  nMapIndex: Integer;
  QuickID: pTQuickID;
  ChrRecord: THumDataInfo;
  sCurMap: string;
  boDataOK: Boolean;
  sDefMsg: string;
  sRouteMsg: string;
  sRouteIP: string;
  nRoutePort: Integer;
  DefMsg: TDefaultMessage;
begin
  Result := False;
  sChrName := GetValidStr3(DecodeString(sData), sAccount, ['/']);
  boDataOK := False;
  try
    if g_HumCharDB.Open then begin
      if g_HumCharDB.FindByAccount(sAccount, ChrList) >= 0 then begin
        for I := 0 to ChrList.Count - 1 do begin
          QuickID := pTQuickID(ChrList.Items[I]);
          nIndex := QuickID.nIndex;
          if g_HumCharDB.GetBy(nIndex, @HumRecord) then begin
            if HumRecord.sChrName = sChrName then begin
              HumRecord.boSelected := True;
              g_HumCharDB.UpdateBy(nIndex, @HumRecord);
              boDataOK := True;
            end else begin
              if HumRecord.boSelected then begin
                HumRecord.boSelected := False;
                g_HumCharDB.UpdateBy(nIndex, @HumRecord);
              end;
            end;
          end;
        end;
      end;
        //ChrList.Free;
    end;
  finally
    g_HumCharDB.Close;
  end;

   { try
      if g_HumDataDB.OpenEx then begin
        nIndex := g_HumDataDB.Index(PChar(sChrName));
        if nIndex >= 0 then begin
          g_HumDataDB.Get(nIndex, @ChrRecord);
          if not ChrRecord.Header.boIsHero then begin //修正强行登陆英雄
            //sCurMap := ChrRecord.Data.sCurMap;
            boDataOK := True;
          end;
        end;
      end;
    finally
      g_HumDataDB.Close;
    end; }
  //end;

  if boDataOK then begin
    //nMapIndex := GetMapIndex(sCurMap);
    nMapIndex := 0;
    sDefMsg := EncodeMessage(MakeDefaultMsg(SM_STARTPLAY, 0, 0, 0, 0));
{$IF DBSUSETHREAD = 1}
    sRouteIP := GateRouteIP(ClientSocket.RemoteAddress, nRoutePort);
{$ELSE}
    sRouteIP := GateRouteIP(RemoteAddress, nRoutePort);
{$IFEND}
    if g_boDynamicIPMode then sRouteIP := UserInfo.sGateIPaddr; //使用动态IP
    sRouteMsg := EncodeString(sRouteIP + '/' + IntToStr(nRoutePort + nMapIndex));
    SendUserSocket(UserInfo.sConnID, sDefMsg + sRouteMsg);
    FrmIDSoc.SetGlobaSessionPlay(UserInfo.nSessionID);
    Result := True;
  end else begin
    SendUserSocket(UserInfo.sConnID, EncodeMessage(MakeDefaultMsg(SM_STARTFAIL, 0, 0, 0, 0)));
  end;
end;

function TSelectClient.QueryChr(sData: string; UserInfo: pTUserInfo): Boolean;
var
  sAccount: string;
  sSessionID: string;
  nSessionID: Integer;
  nChrCount: Integer;
  ChrList: TList;
  I: Integer;
  nIndex: Integer;
  ChrRecord: THumDataInfo;
  HumRecord: THumInfo;
  QuickID: pTQuickID;
  btSex: Byte;
  sChrName: string;
  sJob: string;
  sHair: string;
  sLevel: string;
  s40: string;
begin
  Result := False;
  sSessionID := GetValidStr3(DecodeString(sData), sAccount, ['/']);
  nSessionID := Str_ToInt(sSessionID, -2);
  UserInfo.nSessionID := nSessionID;
  nChrCount := 0;
  if FrmIDSoc.CheckSession(sAccount, UserInfo.sUserIPaddr, nSessionID) then begin
    FrmIDSoc.SetGlobaSessionNoPlay(nSessionID);
    UserInfo.sAccount := sAccount;
    try
      if g_HumCharDB.Open and (g_HumCharDB.FindByAccount(sAccount, ChrList) >= 0) then begin
        try
          if g_HumDataDB.OpenEx then begin
            for I := 0 to ChrList.Count - 1 do begin
              QuickID := pTQuickID(ChrList.Items[I]);
              if QuickID.boIsHero then Continue;
              if (nChrCount >= 2) then break;
              //如果选择ID不对,则跳过
              //if QuickID.nIndex <> UserInfo.nSelGateID then Continue;
              if g_HumCharDB.GetBy(QuickID.nIndex, @HumRecord) and (not HumRecord.boDeleted) then begin
                sChrName := QuickID.sChrName;
                nIndex := g_HumDataDB.Index(sChrName);
                if (nIndex < 0) then Continue;
                if g_HumDataDB.Get(nIndex, @ChrRecord) >= 0 then begin
                  btSex := ChrRecord.Data.btSex;
                  sJob := IntToStr(ChrRecord.Data.btJob);
                  sHair := IntToStr(ChrRecord.Data.btHair);
                  sLevel := IntToStr(ChrRecord.Data.Abil.Level);
                  if HumRecord.boSelected then s40 := s40 + '*';
                  s40 := s40 + sChrName + '/' + sJob + '/' + sHair + '/' + sLevel + '/' + IntToStr(btSex) + '/';
                  Inc(nChrCount);
                end;
              end;
            end;
          end;
        finally
          g_HumDataDB.Close;
        end;
      end;
    finally
      g_HumCharDB.Close;
    end;
    SendUserSocket(UserInfo.sConnID,
      EncodeMessage(MakeDefaultMsg(SM_QUERYCHR, nChrCount, 0, 1, 0)) + EncodeString(s40));
    //*ChrName/sJob/sHair/sLevel/sSex/
  end else begin
    SendUserSocket(UserInfo.sConnID,
      EncodeMessage(MakeDefaultMsg(SM_QUERYCHR_FAIL, nChrCount, 0, 1, 0)));
    CloseUser(UserInfo.sConnID);
  end;
end;

initialization
  begin

  end;
finalization
  begin

  end;

end.

