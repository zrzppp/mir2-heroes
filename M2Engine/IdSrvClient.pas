unit IdSrvClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, IniFiles, JSocket, WinSock, Grobal2, Common, SDK, M2Share;

type
  TFrmIDSoc = class(TForm)
    IDSocket: TClientSocket;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IDSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure IDSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure IDSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure IDSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
  private

    TList_2DC: TList;
    IDSrvAddr: string; //0x2E0
    IDSrvPort: Integer; //0x2E4
    //    sIDSckStr :String; //0x2E8
    //    boConnected:Boolean;
    dwClearEmptySessionTick: LongWord;
    procedure GetPasswdSuccess(sData: string);
    procedure GetCancelAdmission(sData: string);
    procedure GetCancelAdmissionA(sData: string);
    procedure SetTotalHumanCount(sData: string);
    procedure GetServerLoad(sData: string);
    procedure DelSession(nSessionID: Integer);
    procedure NewSession(sAccount, sIPaddr: string; nSessionID, nPayMent, nPayMode, nMakeAccount: Integer);
    procedure ClearSession();
    procedure ClearEmptySession();
    procedure SendSocket(sSENDMSG: string);
    { Private declarations }
  public
    m_SessionList: TGList; //0x2D8
    procedure Initialize();
    procedure Run();
    procedure SendOnlineHumCountMsg(nCount: Integer);
    procedure SendHumanLogOutMsg(sUserID: string; nID: Integer);
    procedure SendAddIP(sUserIpddr: string);
    function GetAdmissionOfAccountCount(sAccount: string): Integer;
    function GetAdmission(sAccount, sIPaddr: string; nSessionID: Integer; var nPayMode: Integer; var nPayMent: Integer): pTSessInfo;
    function GetSessionCount(): Integer;
    procedure GetSessionList(List: TList);
    procedure SendLogonCostMsg(sAccount: string; nTime: Integer);
    procedure Close();
    { Public declarations }
  end;
var
  FrmIDSoc: TFrmIDSoc;

implementation

uses HUtil32;

{$R *.dfm}

{ TFrmIDSoc }



procedure TFrmIDSoc.FormCreate(Sender: TObject);
var
  Conf: TIniFile;
begin
  IDSocket.Host := '';
  if FileExists(sConfigFileName) then begin
    Conf := TIniFile.Create(sConfigFileName);
    if Conf <> nil then begin
      IDSrvAddr := Conf.ReadString('Server', 'IDSAddr', '127.0.0.1');
      IDSrvPort := Conf.ReadInteger('Server', 'IDSPort', 5600);
    end;
    Conf.Free;
  end else
    Application.MessageBox(PChar('配置文件' + sConfigFileName + '未找到！！！'), '错误信息', MB_ICONERROR); //MB_ICONQUESTION
  //ShowMessage('配置文件' + sConfigFileName + '未找到！！！');
  m_SessionList := TGList.Create;
  TList_2DC := TList.Create;
  g_Config.boIDSocketConnected := False;
end;

procedure TFrmIDSoc.FormDestroy(Sender: TObject);
begin
  ClearSession();
  m_SessionList.Free;
  TList_2DC.Free;
end;

procedure TFrmIDSoc.Timer1Timer(Sender: TObject);
begin
  if not IDSocket.Active then begin
    IDSocket.Active := True;
  end;
end;

procedure TFrmIDSoc.IDSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;

procedure TFrmIDSoc.IDSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  EnterCriticalSection(g_Config.UserIDSection);
  try
    g_Config.sIDSocketRecvText := g_Config.sIDSocketRecvText + Socket.ReceiveText;
  finally
    LeaveCriticalSection(g_Config.UserIDSection);
  end;
end;

procedure TFrmIDSoc.Initialize;
begin
  IDSocket.Active := False;
  IDSocket.Address := IDSrvAddr;
  IDSocket.Port := IDSrvPort;
  IDSocket.Active := True;
  Timer1.Enabled := True;
end;

procedure TFrmIDSoc.SendSocket(sSENDMSG: string);
begin
  if IDSocket.Socket.Connected then begin
    IDSocket.Socket.SendText(sSENDMSG);
  end;
end;


procedure TFrmIDSoc.SendHumanLogOutMsg(sUserID: string; nID: Integer);
var
  I: Integer;
  SessInfo: pTSessInfo;
resourcestring
  sFormatMsg = '(%d/%s/%d)';
begin
  m_SessionList.Lock;
  try
    for I := 0 to m_SessionList.Count - 1 do begin
      SessInfo := m_SessionList.Items[I];
      if (SessInfo.nSessionID = nID) and (SessInfo.sAccount = sUserID) then begin
        //SessInfo.dwCloseTick:=GetTickCount();
        //SessInfo.boClosed:=True;
        Break;
      end;
    end;
  finally
    m_SessionList.UnLock;
  end;
  SendSocket(Format(sFormatMsg, [SS_SOFTOUTSESSION, sUserID, nID]));
end;

procedure TFrmIDSoc.SendLogonCostMsg(sAccount: string; nTime: Integer);
resourcestring
  sFormatMsg = '(%d/%s/%d)';
begin
  SendSocket(Format(sFormatMsg, [SS_LOGINCOST, sAccount, nTime]));
end;

procedure TFrmIDSoc.SendOnlineHumCountMsg(nCount: Integer);
resourcestring
  sFormatMsg = '(%d/%s/%d/%d)';
begin
  SendSocket(Format(sFormatMsg, [SS_SERVERINFO, g_Config.sServerName, nServerIndex, nCount]));
end;

procedure TFrmIDSoc.SendAddIP(sUserIpddr: string);
resourcestring
  sFormatMsg = '(%d/%s)';
begin
  SendSocket(Format(sFormatMsg, [SS_ADDIPTOGATE, sUserIpddr]));
end;

procedure TFrmIDSoc.Run;
var
  sSocketText: string;
  sData: string;
  sBody: string;
  sCode: string;
  nLen: Integer;
  Config: pTConfig;
resourcestring
  sExceptionMsg = '[Exception] TFrmIdSoc::DecodeSocStr';
begin
  Config := @g_Config;
  EnterCriticalSection(Config.UserIDSection);
  if Config.sIDSocketRecvText <> '' then try
    if Pos(')', Config.sIDSocketRecvText) <= 0 then Exit;
    sSocketText := Config.sIDSocketRecvText;
    Config.sIDSocketRecvText := '';
  finally
    LeaveCriticalSection(Config.UserIDSection);
  end;
  try
    while (True) do begin
      sSocketText := ArrestStringEx(sSocketText, '(', ')', sData);
      if sData = '' then Break;
      sBody := GetValidStr3(sData, sCode, ['/']);
      case Str_ToInt(sCode, 0) of
        SS_OPENSESSION {100}: GetPasswdSuccess(sBody);
        SS_CLOSESESSION {101}: GetCancelAdmission(sBody);
        SS_KEEPALIVE {104}: SetTotalHumanCount(sBody);
        UNKNOWMSG: ;
        SS_KICKUSER {111}: GetCancelAdmissionA(sBody);
        SS_SERVERLOAD {113}: GetServerLoad(sBody);
      end;
      if Pos(')', sSocketText) <= 0 then Break;
    end;
    EnterCriticalSection(Config.UserIDSection);
    try
      Config.sIDSocketRecvText := sSocketText + Config.sIDSocketRecvText;
    finally
      LeaveCriticalSection(Config.UserIDSection);
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
  if GetTickCount - dwClearEmptySessionTick > 10000 then begin
    dwClearEmptySessionTick := GetTickCount();
    //ClearEmptySession();
  end;

  if IsDebuggerPresent then Application.Terminate;
end;

procedure TFrmIDSoc.GetPasswdSuccess(sData: string);
var
  sAccount: string;
  sSessionID: string;
  sPayCost: string;
  sIPaddr: string;
  sPayMode: string;
  sMakeAccount: string;
resourcestring
  sExceptionMsg = '[Exception] TFrmIdSoc::GetPasswdSuccess';
begin
  try
    sData := GetValidStr3(sData, sAccount, ['/']);
    sData := GetValidStr3(sData, sSessionID, ['/']);
    sData := GetValidStr3(sData, sPayCost, ['/']); //boPayCost
    sData := GetValidStr3(sData, sPayMode, ['/']); //nPayMode
    sData := GetValidStr3(sData, sIPaddr, ['/']); //sIPaddr
    sData := GetValidStr3(sData, sMakeAccount, ['/']); //sIPaddr
    NewSession(sAccount, sIPaddr, Str_ToInt(sSessionID, 0), Str_ToInt(sPayCost, 0), Str_ToInt(sPayMode, 0), Str_ToInt(sMakeAccount, GetTickCount - 1000 * 60 * 60));
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TFrmIDSoc.GetCancelAdmission(sData: string);
var
  SC, sSessionID: string;
resourcestring
  sExceptionMsg = '[Exception] TFrmIdSoc::GetCancelAdmission';
begin
  try
    sSessionID := GetValidStr3(sData, SC, ['/']);
    DelSession(Str_ToInt(sSessionID, 0));
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TFrmIDSoc.NewSession(sAccount, sIPaddr: string; nSessionID, nPayMent, nPayMode, nMakeAccount: Integer);
var
  SessInfo: pTSessInfo;
begin
  New(SessInfo);
  SessInfo.sAccount := sAccount;
  SessInfo.sIPaddr := sIPaddr;
  SessInfo.nSessionID := nSessionID;
  SessInfo.nPayMent := nPayMent;
  SessInfo.nPayMode := nPayMode;
  SessInfo.nSessionStatus := 0;
  SessInfo.dwStartTick := GetTickCount();
  SessInfo.dwActiveTick := GetTickCount();
  if g_Config.boRobotAttack then begin
    SessInfo.dwMakeAccountTick := LongWord(nMakeAccount);
  end else begin
    SessInfo.dwMakeAccountTick := GetTickCount() - 1000 * 60 * 60;
  end;
  SessInfo.nRefCount := 1;
  m_SessionList.Lock;
  try
    m_SessionList.Add(SessInfo);
  finally
    m_SessionList.UnLock;
  end;
end;

procedure TFrmIDSoc.DelSession(nSessionID: Integer);
var
  I: Integer;
  sAccount: string;
  SessInfo: pTSessInfo;
resourcestring
  sExceptionMsg = '[Exception] FrmIdSoc::DelSession %d';
begin
  try
    sAccount := '';
    m_SessionList.Lock;
    try
      for I := m_SessionList.Count - 1 downto 0 do begin //for i := 0 to m_SessionList.Count - 1 do begin
        SessInfo := m_SessionList.Items[I];
        if SessInfo.nSessionID = nSessionID then begin
          sAccount := SessInfo.sAccount;
          m_SessionList.Delete(I);
          Dispose(SessInfo);
          Break;
        end;
      end;
    finally
      m_SessionList.UnLock;
    end;
    if sAccount <> '' then begin
      RunSocket.KickUser(sAccount, nSessionID);
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format(sExceptionMsg, [0]));
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TFrmIDSoc.ClearEmptySession;
var
  I: Integer;
  SessInfo: pTSessInfo;
begin
  m_SessionList.Lock;
  try
    for I := m_SessionList.Count - 1 downto 0 do begin
      SessInfo := m_SessionList.Items[I];
      if SessInfo.nRefCount <= 0 then begin
        m_SessionList.Delete(I);
        Dispose(SessInfo);
        Continue;
      end;
      {
      if GetTickCount - SessInfo.dwActiveTick > 10 * 60 * 1000 then begin
        Dispose(SessInfo);
        m_SessionList.Delete(I);
        Continue;
      end;
      }
    end;
  finally
    m_SessionList.UnLock;
  end;
end;

procedure TFrmIDSoc.ClearSession;
var
  I: Integer;
begin
  m_SessionList.Lock;
  try
    for I := 0 to m_SessionList.Count - 1 do begin
      Dispose(pTSessInfo(m_SessionList.Items[I]));
    end;
    m_SessionList.Clear;
  finally
    m_SessionList.UnLock;
  end;
end;

function TFrmIDSoc.GetAdmissionOfAccountCount(sAccount: string): Integer;
var
  I: Integer;
  SessInfo: pTSessInfo;
begin
  Result := 0;
  m_SessionList.Lock;
  try
    for I := 0 to m_SessionList.Count - 1 do begin
      SessInfo := m_SessionList.Items[I];
      if (SessInfo.sAccount = sAccount) then begin
        Inc(Result);
      end;
    end;
  finally
    m_SessionList.UnLock;
  end;
end;

function TFrmIDSoc.GetAdmission(sAccount, sIPaddr: string; nSessionID: Integer; var nPayMode: Integer; var nPayMent: Integer): pTSessInfo;
var
  I: Integer;
  nCount: Integer;
  SessInfo: pTSessInfo;
  boFound: Boolean;
resourcestring
  sGetFailMsg = '[非法登录] 全局会话验证失败(%s/%s/%d)';
begin
  //  Result:=3;
  //  exit;
  boFound := False;
  Result := nil;
  nPayMent := 0;
  nPayMode := 0;

  if GetAdmissionOfAccountCount(sAccount) = 1 then begin
    m_SessionList.Lock;
    try
      for I := 0 to m_SessionList.Count - 1 do begin
        SessInfo := m_SessionList.Items[I];
        if (SessInfo.nSessionID = nSessionID) and
          (SessInfo.sAccount = sAccount) {and (SessInfo.sIPaddr = sIPaddr)} then begin
        //if SessInfo.nSessionStatus <> 0 then break;
        //SessInfo.nSessionStatus:=1;
          case SessInfo.nPayMent of
            2: nPayMent := 3;
            1: nPayMent := 2;
            0: nPayMent := 1;
          end;
          Result := SessInfo;
          nPayMode := SessInfo.nPayMode;
          boFound := True;
          Break;
        end;
      end;
    finally
      m_SessionList.UnLock;
    end;
  end;
  if g_Config.boViewAdmissionFailure and not boFound then begin
    MainOutMessage(Format(sGetFailMsg, [sAccount, sIPaddr, nSessionID]));
  end;
end;

procedure TFrmIDSoc.SetTotalHumanCount(sData: string);
begin
  g_nTotalHumCount := Str_ToInt(sData, 0)
end;

procedure TFrmIDSoc.GetCancelAdmissionA(sData: string);
var
  nSessionID: Integer;
  sSessionID: string;
  sAccount: string;
resourcestring
  sExceptionMsg = '[Exception] FrmIdSoc::GetCancelAdmissionA';
begin
  try
    sSessionID := GetValidStr3(sData, sAccount, ['/']);
    nSessionID := Str_ToInt(sSessionID, 0);
    if not g_Config.boTestServer then begin
      UserEngine.HumanExpire(sAccount);
      DelSession(nSessionID);
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TFrmIDSoc.GetServerLoad(sData: string); //0048E174
var
  SC, s10, s14, s18, s1C: string;
begin
  sData := GetValidStr3(sData, SC, ['/']);
  sData := GetValidStr3(sData, s10, ['/']);
  sData := GetValidStr3(sData, s14, ['/']);
  sData := GetValidStr3(sData, s18, ['/']);
  sData := GetValidStr3(sData, s1C, ['/']);
  nCurrentMonthly := Str_ToInt(SC, 0);
  nLastMonthlyTotalUsage := Str_ToInt(s10, 0);
  nTotalTimeUsage := Str_ToInt(s14, 0);
  nGrossTotalCnt := Str_ToInt(s18, 0);
  nGrossResetCnt := Str_ToInt(s1C, 0);
end;

procedure TFrmIDSoc.IDSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  g_Config.boIDSocketConnected := True;
  MainOutMessage('LoginSrv(' + Socket.RemoteAddress + ':' + IntToStr(Socket.RemotePort) + ')connected...');
end;

procedure TFrmIDSoc.IDSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  if g_Config.boIDSocketConnected then begin
    ClearSession();
    g_Config.boIDSocketConnected := False;
    MainOutMessage('LoginSrv(' + Socket.RemoteAddress + ':' + IntToStr(Socket.RemotePort) + ')disconnected...');
  end;
end;

procedure TFrmIDSoc.Close;
begin
  Timer1.Enabled := False;
  IDSocket.Active := False;
end;

function TFrmIDSoc.GetSessionCount: Integer;
begin
  Result := 0;
  m_SessionList.Lock;
  try
    Result := m_SessionList.Count;
  finally
    m_SessionList.UnLock;
  end;
end;

procedure TFrmIDSoc.GetSessionList(List: TList);
var
  I: Integer;
begin
  m_SessionList.Lock;
  try
    for I := 0 to m_SessionList.Count - 1 do begin
      List.Add(m_SessionList.Items[I]);
    end;
  finally
    m_SessionList.UnLock;
  end;
end;

end.

