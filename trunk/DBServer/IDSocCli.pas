unit IDSocCli;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, JSocket, Common, Grobal2, DBShare, IniFiles;
type
  TFrmIDSoc = class(TForm)
    IDSocket: TClientSocket;
    Timer1: TTimer;
    KeepAliveTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure IDSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure IDSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure KeepAliveTimerTimer(Sender: TObject);
    procedure IDSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure IDSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
  private
    GlobaSessionList: TList; //0x2D8
    m_sSockMsg: string; //0x2E4
    //sIDAddr: string;
    //nIDPort: Integer;
    procedure ProcessSocketMsg;
    procedure ProcessAddSession(sData: string);
    procedure ProcessDelSession(sData: string);
    procedure ProcessGetOnlineCount(sData: string);

    procedure SendKeepAlivePacket();
    { Private declarations }
  public
    m_Module: Pointer;
    m_dwCheckServerTimeMin: LongWord;
    m_dwCheckServerTimeMax: LongWord;
    m_dwCheckRecviceTick: LongWord;
    procedure SendSocketMsg(wIdent: Word; sMsg: string);
    function CheckSession(sAccount, sIPaddr: string;
      nSessionID: Integer): Boolean;
    function CheckSessionLoadRcd(sAccount, sIPaddr: string; nSessionID: Integer; var boFoundSession: boolean): Boolean;
    function CheckSessionHeroLoadRcd(sAccount, sIPaddr: string; nSessionID: Integer; var boFoundSession: boolean): Boolean;
    function SetSessionSaveRcd(sAccount: string): Boolean;
    procedure SetGlobaSessionNoPlay(nSessionID: Integer);
    procedure SetGlobaSessionPlay(nSessionID: Integer);
    function GetGlobaSessionStatus(nSessionID: Integer): Boolean;
    procedure CloseSession(sAccount: string; nSessionID: Integer); //关闭全局会话
    procedure OpenConnect();
    procedure CloseConnect();
    function GetSession(sAccount, sIPaddr: string): Boolean;

    function GetSessionRandomCodeOK(sAccount, sIPaddr: string; nSessionID: Integer): Boolean;
    procedure SetSessionRandomCodeOK(sAccount, sIPaddr: string; nSessionID: Integer; boOK: Boolean);
    { Public declarations }
  end;

var
  FrmIDSoc: TFrmIDSoc;

implementation

uses HUtil32, Main;

{$R *.DFM}

procedure TFrmIDSoc.FormCreate(Sender: TObject);
begin
  Timer1.Enabled := False;
  KeepAliveTimer.Enabled := False;
  GlobaSessionList := TList.Create;
  m_sSockMsg := '';
  m_Module := nil;
  m_dwCheckServerTimeMin := GetTickCount;
  m_dwCheckServerTimeMax := 0; //GetTickCount;
  m_dwCheckRecviceTick := GetTickCount;
end;

procedure TFrmIDSoc.FormDestroy(Sender: TObject);
var
  I: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  for I := 0 to GlobaSessionList.Count - 1 do begin
    GlobaSessionInfo := GlobaSessionList.Items[I];
    Dispose(GlobaSessionInfo);
  end;
  GlobaSessionList.Free;
end;

procedure TFrmIDSoc.Timer1Timer(Sender: TObject);
begin
  if (not IDSocket.Active) then begin
    IDSocket.Address := g_sIDServerAddr;
    IDSocket.Port := g_nIDServerPort;
    IDSocket.Active := True;
  end;
end;

procedure TFrmIDSoc.IDSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  m_sSockMsg := m_sSockMsg + Socket.ReceiveText;
  if Pos(')', m_sSockMsg) > 0 then begin
    ProcessSocketMsg();
  end;
end;

procedure TFrmIDSoc.ProcessSocketMsg();
var
  sScoketText: string;
  sData: string;
  sCode: string;
  sBody: string;
  nIdent: Integer;
  nC: Integer;
begin
  nC := 0;
  sScoketText := m_sSockMsg;
  while (Pos(')', sScoketText) > 0) do begin
    sScoketText := ArrestStringEx(sScoketText, '(', ')', sData);
    if sData = '' then Break;
    sBody := GetValidStr3(sData, sCode, ['/']);
    nIdent := Str_ToInt(sCode, 0);
    case nIdent of
      SS_OPENSESSION {100}: ProcessAddSession(sBody);
      SS_CLOSESESSION {101}: ProcessDelSession(sBody);
      SS_KEEPALIVE {104}: ProcessGetOnlineCount(sBody);
    else begin
        if nC > 0 then begin
          sScoketText := '';
          Break;
        end;
        Inc(nC);
      end;
    end;
  end;
  m_sSockMsg := sScoketText;
  //MainOutMessage('服务器已启动...');
end;


{procedure TFrmIDSoc.ProcessSocketMsg();
var
  sScoketText: string;
  sData: string;
  sCode: string;
  sBody: string;
  nIdent: Integer;
begin
  sScoketText := m_sSockMsg;
  while (Pos(')', sScoketText) > 0) do begin
    sScoketText := ArrestStringEx(sScoketText, '(', ')', sData);
    if sData = '' then Break;
    sBody := GetValidStr3(sData, sCode, ['/']);
    nIdent := Str_ToInt(sCode, 0);
    case nIdent of
      SS_OPENSESSION : ProcessAddSession(sBody);
      SS_CLOSESESSION : ProcessDelSession(sBody);
      SS_KEEPALIVE: ProcessGetOnlineCount(sBody);
    end;
  end;
  m_sSockMsg := sScoketText;
end;  }

procedure TFrmIDSoc.SendSocketMsg(wIdent: Word; sMsg: string);
var
  sSendText: string;
resourcestring
  sFormatMsg = '(%d/%s)';
begin
  sSendText := Format(sFormatMsg, [wIdent, sMsg]);
  if IDSocket.Socket.Connected then
    IDSocket.Socket.SendText(sSendText);
end;

function TFrmIDSoc.CheckSession(sAccount, sIPaddr: string;
  nSessionID: Integer): Boolean;
var
  I: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  Result := False;
  for I := 0 to GlobaSessionList.Count - 1 do begin
    GlobaSessionInfo := GlobaSessionList.Items[I];
    if GlobaSessionInfo <> nil then begin
      if (GlobaSessionInfo.sAccount = sAccount) and (GlobaSessionInfo.nSessionID = nSessionID) then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

function TFrmIDSoc.CheckSessionLoadRcd(sAccount, sIPaddr: string; nSessionID: Integer; var boFoundSession: boolean): Boolean;
var
  I: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  Result := False;
  boFoundSession := False;
  for I := 0 to GlobaSessionList.Count - 1 do begin
    GlobaSessionInfo := GlobaSessionList.Items[I];
    if GlobaSessionInfo <> nil then begin
      if (GlobaSessionInfo.sAccount = sAccount) and (GlobaSessionInfo.nSessionID = nSessionID) then begin
        boFoundSession := True;
        if not GlobaSessionInfo.boLoadRcd then begin
          GlobaSessionInfo.boLoadRcd := True;
          Result := True;
        end;
        Break;
      end;
    end;
  end;
end;

function TFrmIDSoc.CheckSessionHeroLoadRcd(sAccount, sIPaddr: string; nSessionID: Integer; var boFoundSession: boolean): Boolean;
var
  I: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  Result := False;
  boFoundSession := False;
  for I := 0 to GlobaSessionList.Count - 1 do begin
    GlobaSessionInfo := GlobaSessionList.Items[I];
    if GlobaSessionInfo <> nil then begin
      if (GlobaSessionInfo.sAccount = sAccount) and (GlobaSessionInfo.nSessionID = nSessionID) then begin
        boFoundSession := True;
        if not GlobaSessionInfo.boHeroLoadRcd then begin
          GlobaSessionInfo.boHeroLoadRcd := True;
          Result := True;
        end;
        Break;
      end;
    end;
  end;
end;

function TFrmIDSoc.SetSessionSaveRcd(sAccount: string): Boolean;
var
  I: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  Result := False;
  for I := 0 to GlobaSessionList.Count - 1 do begin
    GlobaSessionInfo := GlobaSessionList.Items[I];
    if GlobaSessionInfo <> nil then begin
      if (GlobaSessionInfo.sAccount = sAccount) then begin
        GlobaSessionInfo.boLoadRcd := False;
        Result := True;
      end;
    end;
  end;
end;

procedure TFrmIDSoc.SetGlobaSessionNoPlay(nSessionID: Integer);
var
  I: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  for I := 0 to GlobaSessionList.Count - 1 do begin
    GlobaSessionInfo := GlobaSessionList.Items[I];
    if GlobaSessionInfo <> nil then begin
      if (GlobaSessionInfo.nSessionID = nSessionID) then begin
        GlobaSessionInfo.boStartPlay := False;
        Break;
      end;
    end;
  end;
end;

procedure TFrmIDSoc.SetGlobaSessionPlay(nSessionID: Integer);
var
  I: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  for I := 0 to GlobaSessionList.Count - 1 do begin
    GlobaSessionInfo := GlobaSessionList.Items[I];
    if GlobaSessionInfo <> nil then begin
      if (GlobaSessionInfo.nSessionID = nSessionID) then begin
        GlobaSessionInfo.boStartPlay := True;
        Break;
      end;
    end;
  end;
end;

function TFrmIDSoc.GetGlobaSessionStatus(nSessionID: Integer): Boolean;
var
  I: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  Result := False;
  for I := 0 to GlobaSessionList.Count - 1 do begin
    GlobaSessionInfo := GlobaSessionList.Items[I];
    if GlobaSessionInfo <> nil then begin
      if (GlobaSessionInfo.nSessionID = nSessionID) then begin
        Result := GlobaSessionInfo.boStartPlay;
        Break;
      end;
    end;
  end;
end;

procedure TFrmIDSoc.CloseSession(sAccount: string; nSessionID: Integer);
var
  I: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  for I := 0 to GlobaSessionList.Count - 1 do begin
    GlobaSessionInfo := GlobaSessionList.Items[I];
    if GlobaSessionInfo <> nil then begin
      if (GlobaSessionInfo.nSessionID = nSessionID) then begin
        if GlobaSessionInfo.sAccount = sAccount then begin
          Dispose(GlobaSessionInfo);
          GlobaSessionList.Delete(I);
          Break;
        end;
      end;
    end;
  end;
end;

procedure TFrmIDSoc.IDSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;

procedure TFrmIDSoc.ProcessAddSession(sData: string);
var
  sAccount, s10, s14, s18, sIPaddr: string;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  sData := GetValidStr3(sData, sAccount, ['/']);
  sData := GetValidStr3(sData, s10, ['/']);
  sData := GetValidStr3(sData, s14, ['/']);
  sData := GetValidStr3(sData, s18, ['/']);
  sData := GetValidStr3(sData, sIPaddr, ['/']);
  New(GlobaSessionInfo);
  GlobaSessionInfo.sAccount := sAccount;
  GlobaSessionInfo.sIPaddr := sIPaddr;
  GlobaSessionInfo.nSessionID := Str_ToInt(s10, 0);
  GlobaSessionInfo.n24 := Str_ToInt(s14, 0);
  GlobaSessionInfo.boStartPlay := False;
  GlobaSessionInfo.boLoadRcd := False;
  GlobaSessionInfo.boHeroLoadRcd := False;
  GlobaSessionInfo.dwAddTick := GetTickCount();
  GlobaSessionInfo.dAddDate := Now();
  GlobaSessionInfo.boRandomCode := False;
  GlobaSessionList.Add(GlobaSessionInfo);
end;

procedure TFrmIDSoc.ProcessDelSession(sData: string);
var
  sAccount: string;
  I, nSessionID: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  sData := GetValidStr3(sData, sAccount, ['/']);
  nSessionID := Str_ToInt(sData, 0);
  for I := 0 to GlobaSessionList.Count - 1 do begin
    GlobaSessionInfo := GlobaSessionList.Items[I];
    if GlobaSessionInfo <> nil then begin
      if (GlobaSessionInfo.nSessionID = nSessionID) and (GlobaSessionInfo.sAccount = sAccount) then begin
        GlobaSessionList.Delete(I);
        Dispose(GlobaSessionInfo);
        Break;
      end;
    end;
  end;
end;

procedure TFrmIDSoc.SendKeepAlivePacket;
begin
  if IDSocket.Socket.Connected then begin
    IDSocket.Socket.SendText('(' + IntToStr(SS_SERVERINFO) + '/' + g_sServerName + '/' + '99' + '/' + IntToStr(FrmMain.GetSelectCharCount) + ')');
  end;
  //(103/翎风世界/0/0)
end;

procedure TFrmIDSoc.CloseConnect;
begin
  Timer1.Enabled := False;
  IDSocket.Active := False;
  m_Module := nil;
end;

function TFrmIDSoc.GetSession(sAccount, sIPaddr: string): Boolean;
var
  I: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  Result := False;
  for I := 0 to GlobaSessionList.Count - 1 do begin
    GlobaSessionInfo := GlobaSessionList.Items[I];
    if GlobaSessionInfo <> nil then begin
      if (GlobaSessionInfo.sAccount = sAccount) and (GlobaSessionInfo.sIPaddr = sIPaddr) then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

function TFrmIDSoc.GetSessionRandomCodeOK(sAccount, sIPaddr: string; nSessionID: Integer): Boolean;
var
  I: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  Result := False;
  for I := 0 to GlobaSessionList.Count - 1 do begin
    GlobaSessionInfo := GlobaSessionList.Items[I];
    if (GlobaSessionInfo.sAccount = sAccount) and (GlobaSessionInfo.nSessionID = nSessionID) and GlobaSessionInfo.boRandomCode then begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TFrmIDSoc.SetSessionRandomCodeOK(sAccount, sIPaddr: string; nSessionID: Integer; boOK: Boolean);
var
  I: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  for I := 0 to GlobaSessionList.Count - 1 do begin
    GlobaSessionInfo := GlobaSessionList.Items[I];
    if (GlobaSessionInfo.sAccount = sAccount) and (GlobaSessionInfo.nSessionID = nSessionID) then begin
      GlobaSessionInfo.boRandomCode := boOK;
      Break;
    end;
  end;
end;

procedure TFrmIDSoc.OpenConnect;
begin
  Timer1.Enabled := True;
  IDSocket.Active := False;
  IDSocket.Address := g_sIDServerAddr;
  IDSocket.Port := g_nIDServerPort;
  IDSocket.Active := True;
end;

procedure TFrmIDSoc.KeepAliveTimerTimer(Sender: TObject);
begin
  SendKeepAlivePacket();
end;

procedure TFrmIDSoc.ProcessGetOnlineCount(sData: string);
begin
  m_dwCheckServerTimeMin := GetTickCount - m_dwCheckRecviceTick;
  if m_dwCheckServerTimeMin > m_dwCheckServerTimeMax then m_dwCheckServerTimeMax := m_dwCheckServerTimeMin;
  m_dwCheckRecviceTick := GetTickCount();
  if m_Module <> nil then
    pTModuleInfo(m_Module).Buffer := Format('%d/%d', [m_dwCheckServerTimeMin, m_dwCheckServerTimeMax]);
end;

procedure TFrmIDSoc.IDSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  sRemoteAddress: string;
  ModuleInfo: TModuleInfo;
begin
  m_dwCheckServerTimeMin := GetTickCount;
  m_dwCheckServerTimeMax := 0; //GetTickCount;
  m_dwCheckRecviceTick := GetTickCount;
  sRemoteAddress := Socket.RemoteAddress;
  KeepAliveTimer.Enabled := True;
  ModuleInfo.Module := Self;
  ModuleInfo.ModuleName := g_sServerName;
  ModuleInfo.Address := Format('%s:%d → %s:%d', [sRemoteAddress, Socket.LocalPort, sRemoteAddress, Socket.RemotePort]);
  ModuleInfo.Buffer := '0/0';
  m_Module := AddModule(@ModuleInfo);
end;

procedure TFrmIDSoc.IDSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  m_Module := nil;
  KeepAliveTimer.Enabled := False;
  RemoveModule(Self);
end;

end.
