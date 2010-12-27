unit DataEngn;

interface
uses
  Windows, Classes, SysUtils, Grobal2, SDK, JSocket, Forms;
type
  TDataEngine = class(TThread)
  private
    FKeepAliveTick: LongWord;
    FConnectTick: LongWord;
    FConnected: Boolean;
    FActive: Boolean;
    FOnConnect: TSocketNotifyEvent;
    FOnDisconnect: TSocketNotifyEvent;
    ClientSocket: TClientSocket;
    //FWorking: Boolean;
    procedure DoConnect;
    procedure DoDisconnect;

    procedure SetActive(Value: Boolean);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);

    function GetWorking: Boolean;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Close;
    procedure SendDBSockMsg(nQueryID: Integer; sMsg: string);
    function SendBuf(var Buf; Count: Integer): Integer;
    function SendText(const S: string): Integer;
    property OnConnect: TSocketNotifyEvent read FOnConnect write FOnConnect;
    property OnDisconnect: TSocketNotifyEvent read FOnDisconnect write FOnDisconnect;
    property Active: Boolean read FActive write SetActive;
    property Connected: Boolean read FConnected;
    property Working: Boolean read GetWorking;
  end;

  TSendListThread = class(TThread)
  protected
    procedure Execute; override;
  public
    constructor Create;
  end;
implementation
uses M2Share, HUtil32, EncryptUnit, RunDB, Common;
{ TDataEngine }

{------------------------------------------------------------------------------}

procedure TSendListThread.Execute;
var
  I: Integer;
  sSendText: string;
  Magic: pTMagic;
  StdItem: pTStdItem;
begin
  sSendText := '';
  for I := 0 to UserEngine.m_MagicList.Count - 1 do begin
    Magic := UserEngine.m_MagicList[I];
    sSendText := sSendText + IntToStr(Magic.wMagicId) + '/' + Magic.sMagicName + '/';
  end;

  if SaveMagicList(EncodeString(sSendText)) then begin
    sSendText := '';
    for I := 0 to UserEngine.StdItemList.Count - 1 do begin
      StdItem := UserEngine.StdItemList[I];
      sSendText := sSendText + StdItem.Name + '/';
    end;
    SaveStdItemList(EncodeString(sSendText));
  end;
end;

constructor TSendListThread.Create;
begin
  FreeOnTerminate := True;
  inherited Create(True);
  Resume;
end;

constructor TDataEngine.Create;
begin
  inherited Create(True);
  FreeOnTerminate := False;
  ClientSocket := TClientSocket.Create(nil);
  ClientSocket.ClientType := ctBlocking;
  ClientSocket.OnError := ClientSocketError;
  ClientSocket.OnConnect := ClientSocketConnect;
  ClientSocket.OnDisconnect := ClientSocketDisconnect;

  FConnectTick := GetTickCount;
  FKeepAliveTick := GetTickCount;
  FConnected := False;
  FActive := False;
  Resume;
end;

destructor TDataEngine.Destroy;
begin
  Active := False;
  ClientSocket.Active := False;
  ClientSocket.Free;
  inherited Destroy;
end;

function TDataEngine.GetWorking: Boolean;
begin
  Result := (GetTickCount - FConnectTick > 6000);
end;

procedure TDataEngine.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin

end;

procedure TDataEngine.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  ClientSocket.Active := False;
end;

procedure TDataEngine.Close;
begin
  DoDisconnect;
end;

procedure TDataEngine.DoDisconnect;
begin
  if FConnected then begin
    FConnected := False;
    ClientSocket.Active := False;
    FConnectTick := GetTickCount;
    MainOutMessage('数据库服务器连接断开...');
  end;
end;

procedure TDataEngine.DoConnect;
begin
  if not FConnected then begin
    FConnected := True;
    FKeepAliveTick := GetTickCount;
    FConnectTick := GetTickCount;
    g_Config.sDBSocketRecvText := '';
    g_Config.boDBSocketWorking := False;
    TSendListThread.Create;

    MainOutMessage('数据库服务器(' + ClientSocket.Socket.RemoteAddress + ':' + IntToStr(ClientSocket.Socket.RemotePort) + ')连接成功...');
  end;
end;

procedure TDataEngine.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  Socket.Close;
  ErrorCode := 0;
end;

procedure TDataEngine.SetActive(Value: Boolean);
begin
  if FActive <> Value then begin
    FActive := Value;
    if (not FActive) then
      Close;
  end;
end;

function TDataEngine.SendBuf(var Buf; Count: Integer): Integer;
begin
  if FConnected then begin
    try
      Result := ClientSocket.Socket.SendBuf(Buf, Count);
    except
      Result := 0;
      Close;
    end;
  end;
end;

function TDataEngine.SendText(const S: string): Integer;
begin
  if FConnected then begin
    try
      Result := ClientSocket.Socket.SendText(S);
    except
      Result := 0;
      Close;
    end;
  end;
end;

procedure TDataEngine.Execute;
var
  nMsgLen: Integer;
  //tBuffer: PChar;
  sReviceBuff: string;
  ReceiveBuffer: array[0..DATA_BUFSIZE - 1] of Char;
  //ReceiveBuffer: array[0..4095] of Char;
  SocketStream: TWinSocketStream;
  //DefMsg: TDefaultMessage;
begin
  while (not Terminated) and (not Application.Terminated) do begin
    if FActive then begin
      if not ClientSocket.Socket.Connected then begin
        DoDisconnect;
        if (GetTickCount - FConnectTick > 5000) and (not g_boExitServer) then begin
          FConnectTick := GetTickCount;
          ClientSocket.Address := g_Config.sDBAddr;
          ClientSocket.Port := g_Config.nDBPort;
          ClientSocket.Active := False;
          try
            ClientSocket.Active := True;
          except
            DoDisconnect;
          end;
          Sleep(100);
          Continue;
        end;
        Sleep(100);
        Continue;
      end else begin
        DoConnect;
        SocketStream := TWinSocketStream.Create(ClientSocket.Socket, 10000);
        try
          if SocketStream.WaitForData(10000) then begin
            repeat
              if (not ClientSocket.Socket.Connected) or Terminated or Application.Terminated then break;
              try
                nMsgLen := SocketStream.Read(ReceiveBuffer, SizeOf(ReceiveBuffer));
                if nMsgLen > 0 then begin
                  if g_Config.boDBSocketWorking then begin
                    FKeepAliveTick := GetTickCount;
                    SetLength(sReviceBuff, nMsgLen);
                    Move(ReceiveBuffer, sReviceBuff[1], nMsgLen);
                    EnterCriticalSection(UserDBSection);
                    try
                      g_Config.sDBSocketRecvText := g_Config.sDBSocketRecvText + sReviceBuff;
                    finally
                      LeaveCriticalSection(UserDBSection);
                    end;
                  end else begin
                    EnterCriticalSection(UserDBSection);
                    try
                      g_Config.sDBSocketRecvText := '';
                    finally
                      LeaveCriticalSection(UserDBSection);
                    end;
                  end;
                end else begin
                  Close;
                  break;
                end;
              except
                Close;
                break;
              end;
            until (not SocketStream.WaitForData(10000));
          end;
        finally
          SocketStream.Free;
        end;
      end;
    end else Sleep(1);
  end;
end;

procedure TDataEngine.SendDBSockMsg(nQueryID: Integer; sMsg: string);
var
  sSENDMSG: string;
  nCheckCode: Integer;
  nSendText: Integer;
  sCheckStr: string;
begin
  if ClientSocket.Socket.Connected then begin
    try
      EnterCriticalSection(UserDBSection);
      try
        g_Config.sDBSocketRecvText := '';
      finally
        LeaveCriticalSection(UserDBSection);
      end;
      FKeepAliveTick := GetTickCount;
      nCheckCode := MakeLong(nQueryID xor 170, Length(sMsg) + 6);
      sCheckStr := EncodeBuffer(@nCheckCode, SizeOf(Integer));
      sSENDMSG := '#' + IntToStr(nQueryID) + '/' + sMsg + sCheckStr + '!';
      g_Config.boDBSocketWorking := True;
      ClientSocket.Socket.SendText(sSENDMSG);
    except
      DoDisconnect;
    end;
  end;
end;

end.

