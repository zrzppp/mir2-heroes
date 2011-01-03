unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JSocket, ExtCtrls, StdCtrls, Menus, Grids, WinSock, Common;

type
  TRankingThread = class(TThread)
  private
    procedure RefRanking;
    procedure Run();
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
  end;

  TFrmMain = class(TForm)
    TimerStart: TTimer;
    MemoLog: TMemo;
    Panel: TPanel;
    TimerMain: TTimer;
    MainMenu: TMainMenu;
    MENU_CONTROL: TMenuItem;
    MENU_CONTROL_START: TMenuItem;
    MENU_CONTROL_STOP: TMenuItem;
    N1: TMenuItem;
    G1: TMenuItem;
    C1: TMenuItem;
    MENU_CONTROL_EXIT: TMenuItem;
    MENU_OPTION: TMenuItem;
    MENU_OPTION_GENERAL: TMenuItem;
    MENU_OPTION_GAMEGATE: TMenuItem;
    MENU_MANAGE: TMenuItem;
    MENU_MANAGE_DATA: TMenuItem;
    MENU_RANKING: TMenuItem;
    MENU_TEST: TMenuItem;
    MENU_TEST_SELGATE: TMenuItem;
    MENU_HELP: TMenuItem;
    MENU_HELP_VERSION: TMenuItem;
    ModuleGrid: TStringGrid;
    CheckBoxShowMainLogMsg: TCheckBox;
    LabelLoadHumRcd: TLabel;
    LabelSaveHumRcd: TLabel;
    LabelLoadHeroRcd: TLabel;
    LabelSaveHeroRcd: TLabel;
    LabelCreateHero: TLabel;
    LabelCreateHum: TLabel;
    LabelDeleteHum: TLabel;
    LabelDeleteHero: TLabel;
    LabelWorkStatus: TLabel;
    TimerClose: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimerMainTimer(Sender: TObject);
    procedure TimerStartTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MENU_OPTION_GAMEGATEClick(Sender: TObject);
    procedure MENU_MANAGE_DATAClick(Sender: TObject);
    procedure MENU_RANKINGClick(Sender: TObject);
    procedure MENU_TEST_SELGATEClick(Sender: TObject);
    procedure CheckBoxShowMainLogMsgClick(Sender: TObject);
    procedure MENU_CONTROL_STARTClick(Sender: TObject);
    procedure MENU_CONTROL_STOPClick(Sender: TObject);
    procedure MENU_CONTROL_EXITClick(Sender: TObject);
    procedure TimerCloseTimer(Sender: TObject);
    procedure MENU_HELP_VERSIONClick(Sender: TObject);
    procedure G1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure MemoLogChange(Sender: TObject);
    procedure MemoLogDblClick(Sender: TObject);
    procedure MENU_OPTION_GENERALClick(Sender: TObject);
  private
    ServerSocket: TServerSocket;
    SelectSocket: TServerSocket;
    procedure StartService();
    procedure StopService();
    procedure ShowMainLogMsg;
    procedure ShowModule;
    procedure ShowWorkStatus;


{$IF DBSUSETHREAD = 1}
    procedure ServerSocketClientGetThreadEvent(Sender: TObject; ClientSocket: TServerClientWinSocket;
      var SocketThread: TServerClientThread);
    procedure ServerSocketThreadStart(Sender: TObject;
      Thread: TServerClientThread);
    procedure ServerSocketThreadEnd(Sender: TObject;
      Thread: TServerClientThread);

    procedure SelectSocketClientGetThreadEvent(Sender: TObject; ClientSocket: TServerClientWinSocket;
      var SocketThread: TServerClientThread);
    procedure SelectSocketThreadStart(Sender: TObject;
      Thread: TServerClientThread);
    procedure SelectSocketThreadEnd(Sender: TObject;
      Thread: TServerClientThread);
{$ELSE}
    procedure ServerSocketGetSocket(Sender: TObject; Socket: Integer; var ClientSocket: TServerClientWinSocket);
    procedure ServerSocketClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);

    procedure SelectSocketGetSocket(Sender: TObject; Socket: Integer; var ClientSocket: TServerClientWinSocket);
    procedure SelectSocketClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure SelectSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure SelectSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
{$IFEND}
    procedure SocketClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
  public
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA;
    function GetSelectCharCount: Integer;
  end;

var
  FrmMain: TFrmMain;

implementation
uses
  DBShare, HumDB, SelectClient, ServerClient, HUtil32, SDK, Grobal2,
  IDSocCli, RouteManage, FIDHum, Ranking, TestSelGate, Setting;
var
  RankingThread: TRankingThread;
{$R *.dfm}

{$IF DBSUSETHREAD = 1}

procedure TFrmMain.ServerSocketClientGetThreadEvent(Sender: TObject; ClientSocket: TServerClientWinSocket;
  var SocketThread: TServerClientThread);
begin
  SocketThread := TServerClient.Create(ClientSocket);
end;

procedure TFrmMain.ServerSocketThreadStart(Sender: TObject;
  Thread: TServerClientThread);
var
  sRemoteAddress: string;
  ModuleInfo: TModuleInfo;
begin
  sRemoteAddress := Thread.ClientSocket.RemoteAddress;
  if (not CheckServerIP(sRemoteAddress)) then begin
    MainOutMessage('非法服务器连接: ' + sRemoteAddress);
    Thread.ClientSocket.Close;
    Exit;
  end;
  if not (boDataDBReady and boHumDBReady and g_boStartService) then
    Thread.ClientSocket.Close else
  begin
    ModuleInfo.Module := Thread;
    ModuleInfo.ModuleName := '游戏中心';
    ModuleInfo.Address := Format('%s:%d → %s:%d', [sRemoteAddress, Thread.ClientSocket.RemotePort, sRemoteAddress, ServerSocket.Port]);
    ModuleInfo.Buffer := '0/0';
    TServerClient(Thread).m_Module := AddModule(@ModuleInfo);
  end;
end;

procedure TFrmMain.ServerSocketThreadEnd(Sender: TObject;
  Thread: TServerClientThread);
begin
  RemoveModule(Thread);
end;

{------------------------------------------------------------------------------}

procedure TFrmMain.SelectSocketClientGetThreadEvent(Sender: TObject; ClientSocket: TServerClientWinSocket;
  var SocketThread: TServerClientThread);
begin
  SocketThread := TSelectClient.Create(ClientSocket);
end;

procedure TFrmMain.SelectSocketThreadStart(Sender: TObject;
  Thread: TServerClientThread);
var
  sRemoteAddress: string;
  ModuleInfo: TModuleInfo;
begin
  sRemoteAddress := Thread.ClientSocket.RemoteAddress;
  if (not CheckServerIP(sRemoteAddress)) then begin
    MainOutMessage('非法服务器连接: ' + sRemoteAddress);
    Thread.ClientSocket.Close;
    Exit;
  end;
  if not (boDataDBReady and boHumDBReady and g_boStartService) then
    Thread.ClientSocket.Close else
  begin
    ModuleInfo.Module := Thread;
    ModuleInfo.ModuleName := '角色网关';
    ModuleInfo.Address := Format('%s:%d → %s:%d', [sRemoteAddress, Thread.ClientSocket.RemotePort, sRemoteAddress, SelectSocket.Port]);
    ModuleInfo.Buffer := '0/0';
    TSelectClient(Thread).m_Module := AddModule(@ModuleInfo);
  end;
end;

procedure TFrmMain.SelectSocketThreadEnd(Sender: TObject;
  Thread: TServerClientThread);
begin
  RemoveModule(Thread);
end;

{$ELSE}

procedure TFrmMain.ServerSocketGetSocket(Sender: TObject; Socket: Integer; var ClientSocket: TServerClientWinSocket);
begin
  ClientSocket := TServerClient.Create(Socket, ServerSocket.Socket);
end;

procedure TFrmMain.ServerSocketClientConnect(Sender: TObject; Socket: TCustomWinSocket);
var
  sRemoteAddress: string;
  ModuleInfo: TModuleInfo;
begin
  sRemoteAddress := Socket.RemoteAddress;
  if (not CheckServerIP(sRemoteAddress)) then begin
    MainOutMessage('非法服务器连接: ' + sRemoteAddress);
    Socket.Close;
    Exit;
  end;
  if not (boDataDBReady and boHumDBReady and g_boStartService) then
    Socket.Close else
  begin

    ModuleInfo.Module := Socket;
    ModuleInfo.ModuleName := '游戏中心';
    ModuleInfo.Address := Format('%s:%d → %s:%d', [sRemoteAddress, Socket.RemotePort, sRemoteAddress, ServerSocket.Port]);
    ModuleInfo.Buffer := '0/0';
    TServerClient(Socket).m_Module := AddModule(@ModuleInfo);
  end;
end;

procedure TFrmMain.ServerSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  RemoveModule(Socket);
end;

procedure TFrmMain.ServerSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  nMsgLen: Integer;
  RecvBuffer: array[0..DATA_BUFSIZE * 2 - 1] of Char;
begin
  while (True) do begin
    nMsgLen := Socket.ReceiveBuf(RecvBuffer, SizeOf(RecvBuffer));
    if nMsgLen <= 0 then Break;
    with Socket as TServerClient do
      ProcessServerPacket(@RecvBuffer, nMsgLen);
  end;
end;

{------------------------------------------------------------------------------}

procedure TFrmMain.SelectSocketGetSocket(Sender: TObject; Socket: Integer; var ClientSocket: TServerClientWinSocket);
begin
  ClientSocket := TSelectClient.Create(Socket, SelectSocket.Socket);
end;

procedure TFrmMain.SelectSocketClientConnect(Sender: TObject; Socket: TCustomWinSocket);
var
  sRemoteAddress: string;
  ModuleInfo: TModuleInfo;
begin
  sRemoteAddress := Socket.RemoteAddress;
  if (not CheckServerIP(sRemoteAddress)) then begin
    MainOutMessage('非法服务器连接: ' + sRemoteAddress);
    Socket.Close;
    Exit;
  end;
  if not (boDataDBReady and boHumDBReady and g_boStartService) then
    Socket.Close else
  begin
    ModuleInfo.Module := Socket;
    ModuleInfo.ModuleName := '角色网关';
    ModuleInfo.Address := Format('%s:%d → %s:%d', [sRemoteAddress, Socket.RemotePort, sRemoteAddress, SelectSocket.Port]);
    ModuleInfo.Buffer := '0/0';
    TSelectClient(Socket).m_Module := AddModule(@ModuleInfo);
  end;
end;

procedure TFrmMain.SelectSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  RemoveModule(Socket);
end;

procedure TFrmMain.SelectSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  nMsgLen: Integer;
  RecvBuffer: array[0..DATA_BUFSIZE * 2 - 1] of Char;
begin
  while (True) do begin
    nMsgLen := Socket.ReceiveBuf(RecvBuffer, SizeOf(RecvBuffer));
    if nMsgLen <= 0 then Break;
    with Socket as TSelectClient do
      ExecGateBuffers(@RecvBuffer, nMsgLen);
  end;
end;
{$IFEND}

procedure TFrmMain.SocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;

function TFrmMain.GetSelectCharCount: Integer;
{$IF DBSUSETHREAD = 1}
var
  I: Integer;
  SelectClient: TSelectClient;
{$IFEND}
begin
{$IF DBSUSETHREAD = 1}
  Result := 0;
  for I := 0 to SelectSocket.Socket.ActiveConnections - 1 do begin
    SelectClient := SelectSocket.Socket.GetClientThread(SelectSocket.Socket.Connections[I] as TServerClientWinSocket) as TSelectClient;
    if SelectClient <> nil then begin
      Result := Result + SelectClient.SelectCharList.OnLineCount;
    end;
  end;
{$ELSE}
  Result := SelectSocket.Socket.ActiveConnections;
{$IFEND}
end;
{------------------------------------------------------------------------------}

procedure TFrmMain.FormCreate(Sender: TObject);
var
  nX, nY: Integer;
begin
  g_dwGameCenterHandle := Str_ToInt(ParamStr(1), 0);
  nX := Str_ToInt(ParamStr(2), -1);
  nY := Str_ToInt(ParamStr(3), -1);
  if (nX >= 0) or (nY >= 0) then begin
    Left := nX;
    Top := nY;
  end;
  SendGameCenterMsg(SG_FORMHANDLE, IntToStr(Self.Handle));
  MainOutMessage('Gate Starting...');

  ModuleGrid.RowCount := 5;
  ModuleGrid.ColWidths[0] := 80;
  ModuleGrid.ColWidths[1] := 480 - 80 * 2;
  ModuleGrid.ColWidths[2] := 80;
  ModuleGrid.Cells[0, 0] := 'Srv Name';
  ModuleGrid.Cells[1, 0] := 'IP and Ports';
  ModuleGrid.Cells[2, 0] := 'Connection';

  ServerSocket := TServerSocket.Create(Self);
  SelectSocket := TServerSocket.Create(Self);

{$IF DBSUSETHREAD = 1}
  ServerSocket.OnGetThread := ServerSocketClientGetThreadEvent;
  ServerSocket.OnThreadStart := ServerSocketThreadStart;
  ServerSocket.OnThreadEnd := ServerSocketThreadEnd;
  ServerSocket.ServerType := stThreadBlocking;
  ServerSocket.ThreadCacheSize := 0;

  SelectSocket.OnGetThread := SelectSocketClientGetThreadEvent;
  SelectSocket.OnThreadStart := SelectSocketThreadStart;
  SelectSocket.OnThreadEnd := SelectSocketThreadEnd;
  SelectSocket.ServerType := stThreadBlocking;
  SelectSocket.ThreadCacheSize := 0;
{$ELSE}
  //ServerSocket.ServerType := stNonBlocking;
  ServerSocket.OnGetSocket := ServerSocketGetSocket;
  ServerSocket.OnClientConnect := ServerSocketClientConnect;
  ServerSocket.OnClientDisconnect := ServerSocketClientDisconnect;
  ServerSocket.OnClientRead := ServerSocketClientRead;

  //SelectSocket.ServerType := stNonBlocking;
  SelectSocket.OnGetSocket := SelectSocketGetSocket;
  SelectSocket.OnClientConnect := SelectSocketClientConnect;
  SelectSocket.OnClientDisconnect := SelectSocketClientDisconnect;
  SelectSocket.OnClientRead := SelectSocketClientRead;
{$IFEND}
  ServerSocket.OnClientError := SocketClientError;
  SelectSocket.OnClientError := SocketClientError;

  ServerSocket.Address := '0.0.0.0';
  SelectSocket.Address := '0.0.0.0';

  g_HumRanking := TSortStringList.Create;
  g_WarriorRanking := TSortStringList.Create;
  g_WizzardRanking := TSortStringList.Create;
  g_MonkRanking := TSortStringList.Create;

  g_HeroRanking := TSortStringList.Create;
  g_HeroWarriorRanking := TSortStringList.Create;
  g_HeroWizzardRanking := TSortStringList.Create;
  g_HeroMonkRanking := TSortStringList.Create;

  g_MasterRanking := TSortStringList.Create;

  g_HumCharDB := TFileHumDB.Create;
  g_HumDataDB := TFileDB.Create;

  g_MagicList := TStringList.Create;
  g_StdItemList := TStringList.Create;

  g_ModuleList := TSortStringList.Create;
  CheckBoxShowMainLogMsg.Checked := g_boShowLogMsg;

  RankingThread := TRankingThread.Create(True);
  RankingThread.Resume;

  SendGameCenterMsg(SG_STARTNOW, 'Game Center Message...');
  TimerStart.Enabled := True;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  RankingThread.Terminate;
  RankingThread.Free;

  for I := 0 to g_HumRanking.Count - 1 do begin
    Dispose(pTUserLevelRanking(g_HumRanking.Objects[I]));
  end;
  for I := 0 to g_HeroRanking.Count - 1 do begin
    Dispose(pTHeroLevelRanking(g_HeroRanking.Objects[I]));
  end;
  for I := 0 to g_MasterRanking.Count - 1 do begin
    Dispose(pTUserMasterRanking(g_MasterRanking.Objects[I]));
  end;

  for I := 0 to g_ModuleList.Count - 1 do begin
    Dispose(pTModuleInfo(g_ModuleList.Objects[I]));
  end;

  UnLoadMagicList;
  UnLoadStdItemList;

  ServerSocket.Free;
  SelectSocket.Free;

  g_HumCharDB.Free;
  g_HumDataDB.Free;

  g_HumRanking.Free;
  g_WarriorRanking.Free;
  g_WizzardRanking.Free;
  g_MonkRanking.Free;
  g_HeroRanking.Free;
  g_HeroWarriorRanking.Free;
  g_HeroWizzardRanking.Free;
  g_HeroMonkRanking.Free;
  g_MasterRanking.Free;

  g_ModuleList.Free;
  g_MagicList.Free;
  g_StdItemList.Free;
end;

procedure TFrmMain.ShowMainLogMsg;
var
  I: Integer;
  TempLogList: TStringList;
begin
  if (GetTickCount - g_dwShowMainLogTick) > 20 then begin
    g_dwShowMainLogTick := GetTickCount();
    TempLogList := TStringList.Create;
    try
      g_MainLogMsgList.Lock;
      try
        for I := 0 to g_MainLogMsgList.Count - 1 do begin
          TempLogList.Add(g_MainLogMsgList.Strings[I]);
        end;
        g_MainLogMsgList.Clear;
      finally
        g_MainLogMsgList.UnLock;
      end;
      for I := 0 to TempLogList.Count - 1 do begin
        MemoLog.Lines.Add(TempLogList.Strings[I]);
      end;
    finally
      TempLogList.Free;
    end;
  end;
end;

procedure TFrmMain.ShowModule;
var
  I: Integer;
  ModuleInfo: pTModuleInfo;
begin
  try
    if (GetTickCount - g_dwShowModuleTick) > 2000 then begin
      g_dwShowModuleTick := GetTickCount();
      ModuleGrid.RowCount := _MAX(g_ModuleList.Count + 1, 5);
      for I := 0 to ModuleGrid.RowCount - 1 do begin
        if I < g_ModuleList.Count then begin
          ModuleInfo := pTModuleInfo(g_ModuleList.Objects[I]);
          ModuleGrid.Cells[0, I + 1] := ModuleInfo.ModuleName;
          ModuleGrid.Cells[1, I + 1] := ModuleInfo.Address;
          ModuleGrid.Cells[2, I + 1] := ModuleInfo.Buffer;
        end else begin
          ModuleGrid.Cells[0, I + 1] := '';
          ModuleGrid.Cells[1, I + 1] := '';
          ModuleGrid.Cells[2, I + 1] := '';
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] ShowModule');
  end;
end;

procedure TFrmMain.ShowWorkStatus;
begin
  //if GetTickCount - g_dwWorkStatusTick > 100 then begin
    //g_dwWorkStatusTick := GetTickCount;
  case g_nWorkStatus of
    DB_LOADHUMANRCD: begin
        LabelWorkStatus.Font.Color := clGreen;
        LabelWorkStatus.Caption := '读取人物数据';
      end;
    DB_SAVEHUMANRCD: begin
        LabelWorkStatus.Font.Color := clGreen;
        LabelWorkStatus.Caption := '保存人物数据';
      end;
    {DB_SAVEHUMANRCDEX: begin
        SaveHumanRcdEx(sData, DefMsg.Recog, Socket);
      end; }
    DB_LOADHERORCD: begin //读取英雄数据
        LabelWorkStatus.Font.Color := clGreen;
        LabelWorkStatus.Caption := '读取英雄数据';
      end;
    DB_NEWHERORCD: begin //新建英雄
        LabelWorkStatus.Font.Color := clGreen;
        LabelWorkStatus.Caption := '创建英雄';
      end;
    DB_DELHERORCD: begin //删除英雄
        LabelWorkStatus.Font.Color := clGreen;
        LabelWorkStatus.Caption := '删除英雄';
      end;
    DB_SAVEHERORCD: begin //保存英雄数据
        LabelWorkStatus.Font.Color := clGreen;
        LabelWorkStatus.Caption := '保存英雄数据';
      end;
    DB_LOADRANKING: begin //排行榜
        LabelWorkStatus.Font.Color := clGreen;
        LabelWorkStatus.Caption := '读取排行榜数据';
      end;
  else LabelWorkStatus.Font.Color := clBlue;
      {DB_SAVEMAGICLIST: begin

        end;
      DB_SAVESTDITEMLIST: begin

        end;
      DB_SENDKEEPALIVE: ;}
  end;
  if GetTickCount - g_dwWorkStatusTick > 1000 then begin
    g_dwWorkStatusTick := GetTickCount;
    LabelCreateHum.Caption := Format('创建人物:%d', [g_nCreateHumCount]);
    LabelDeleteHum.Caption := Format('删除人物:%d', [g_nDeleteHumCount]);
    LabelLoadHumRcd.Caption := Format('读取人物数据:%d', [g_nLoadHumCount]);
    LabelSaveHumRcd.Caption := Format('保存人物数据:%d', [g_nSaveHumCount]);

    LabelCreateHero.Caption := Format('创建英雄:%d', [g_nCreateHeroCount]);
    LabelDeleteHero.Caption := Format('删除英雄:%d', [g_nDeleteHeroCount]);
    LabelLoadHeroRcd.Caption := Format('读取英雄数据:%d', [g_nLoadHeroCount]);
    LabelSaveHeroRcd.Caption := Format('保存英雄数据:%d', [g_nSaveHeroCount]);
  end;
end;

procedure TFrmMain.TimerMainTimer(Sender: TObject);
begin
  ShowMainLogMsg;
  ShowModule;
  ShowWorkStatus;
end;

procedure TFrmMain.MyMessage(var MsgData: TWmCopyData);
var
  sData: string;
  ProgramType: TProgamType;
  wIdent: Word;
begin
  wIdent := HiWord(MsgData.From);
  sData := StrPas(MsgData.CopyDataStruct^.lpData);
  case wIdent of
    GS_QUIT: begin
        //StopService();
        g_boRemoteClose := True;
        Close();
      end;
    1: ;
    2: ;
    3: ;
  end;
end;

procedure TFrmMain.StartService();
begin
  try
    MainOutMessage('Loading Character and Data DB...');
    LoadConfig();
    g_HumCharDB.LoadFormFile(g_sHumDBFilePath + 'Hum.DB');
    g_HumDataDB.LoadFormFile(g_sDataDBFilePath + 'Mir.DB');

    SelectSocket.Port := g_nGatePort;
    ServerSocket.Port := g_nServerPort;

    SelectSocket.Active := True;
    ServerSocket.Active := True;

    g_boStartService := True;

    FrmIDSoc.OpenConnect;

    MENU_CONTROL_START.Enabled := False;
    MENU_CONTROL_STOP.Enabled := True;

    MainOutMessage('Gate Started...');
    //MainOutMessage('SelectSocket.Port:' + IntToStr(SelectSocket.Port));
    //MainOutMessage('ServerSocket.Port:' + IntToStr(ServerSocket.Port));
    SendGameCenterMsg(SG_STARTOK, 'Gate Stopped...');
  except
    on E: Exception do begin
      g_boStartService := False;
      MENU_CONTROL_START.Enabled := True;
      MENU_CONTROL_STOP.Enabled := False;
      FrmIDSoc.CloseConnect;
      SelectSocket.Active := False;
      ServerSocket.Active := False;
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TFrmMain.StopService();
var
  ServerClient: TServerClient;
  SelectClient: TSelectClient;
begin
  g_boStartService := False;
  MainOutMessage('Gate Stopped...');
  MENU_CONTROL_START.Enabled := True;
  MENU_CONTROL_STOP.Enabled := False;

  FrmIDSoc.CloseConnect;

{$IF DBSUSETHREAD = 1}
  while ServerSocket.Socket.ActiveConnections > 0 do begin
    Application.ProcessMessages;
    ServerClient := ServerSocket.Socket.GetClientThread(ServerSocket.Socket.Connections[0] as TServerClientWinSocket) as TServerClient;
    if ServerClient <> nil then
      ServerClient.Close;
  end;

  while SelectSocket.Socket.ActiveConnections > 0 do begin
    Application.ProcessMessages;
    SelectClient := SelectSocket.Socket.GetClientThread(SelectSocket.Socket.Connections[0] as TServerClientWinSocket) as TSelectClient;
    if SelectClient <> nil then
      SelectClient.Close;
  end;
{$ELSE}
  while ServerSocket.Socket.ActiveConnections > 0 do begin
    Application.ProcessMessages;
    ServerSocket.Socket.Connections[0].Close;
  end;

  while SelectSocket.Socket.ActiveConnections > 0 do begin
    Application.ProcessMessages;
    SelectSocket.Socket.Connections[0].Close;
  end;
{$IFEND}

  SelectSocket.Active := False;
  ServerSocket.Active := False;
  MainOutMessage('服务器已停止...');
end;

procedure TFrmMain.TimerStartTimer(Sender: TObject);
begin
  TimerStart.Enabled := False;
  StartService();
  if g_boMinimize then SendMessage(Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if g_boRemoteClose or g_boSoftClose then begin
    if (ServerSocket.Socket.ActiveConnections > 0) or (SelectSocket.Socket.ActiveConnections > 0) then begin
      CanClose := False;
      TimerClose.Enabled := True;
    end;
  end else begin
    if (Application.MessageBox('是否确定退出数据库服务器？',
      '确认信息',
      MB_YESNO + MB_ICONQUESTION) = IDYES) then begin
      g_boSoftClose := True;
      if (ServerSocket.Socket.ActiveConnections > 0) or (SelectSocket.Socket.ActiveConnections > 0) then begin
        CanClose := False;
        TimerClose.Enabled := True;
      end;
    end else CanClose := False;
  end;
end;

procedure TFrmMain.MENU_OPTION_GAMEGATEClick(Sender: TObject);
begin
  frmRouteManage.Open;
end;

procedure TFrmMain.MENU_MANAGE_DATAClick(Sender: TObject);
begin
  if boHumDBReady and boDataDBReady then
    FrmIDHum.Show;
end;

procedure TFrmMain.MENU_RANKINGClick(Sender: TObject);
begin
  FrmRankingDlg.Top := Self.Top;
  FrmRankingDlg.Left := Self.Left;
  FrmRankingDlg.Open();
end;

procedure TFrmMain.MENU_TEST_SELGATEClick(Sender: TObject);
begin
  frmTestSelGate := TfrmTestSelGate.Create(Owner);
  frmTestSelGate.ShowModal;
  frmTestSelGate.Free;
end;

procedure TFrmMain.CheckBoxShowMainLogMsgClick(Sender: TObject);
begin
  g_boShowLogMsg := CheckBoxShowMainLogMsg.Checked;
end;

procedure TFrmMain.MENU_CONTROL_STARTClick(Sender: TObject);
begin
  StartService();
end;

procedure TFrmMain.MENU_CONTROL_STOPClick(Sender: TObject);
begin
  StopService();
end;

procedure TFrmMain.MENU_CONTROL_EXITClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.TimerCloseTimer(Sender: TObject);
var
  ServerClient: TServerClient;
  SelectClient: TSelectClient;
begin
  if g_boStartService then begin
    g_boStartService := False;
    MainOutMessage('Gate Stopped...');
    MENU_CONTROL_START.Enabled := True;
    MENU_CONTROL_STOP.Enabled := False;
    FrmIDSoc.CloseConnect;
  end;

{$IF DBSUSETHREAD = 1}
  if ServerSocket.Socket.ActiveConnections > 0 then begin
    ServerClient := ServerSocket.Socket.GetClientThread(ServerSocket.Socket.Connections[0] as TServerClientWinSocket) as TServerClient;
    if ServerClient <> nil then
      ServerClient.Close;
  end else
    if SelectSocket.Socket.ActiveConnections > 0 then begin
    SelectClient := SelectSocket.Socket.GetClientThread(SelectSocket.Socket.Connections[0] as TServerClientWinSocket) as TSelectClient;
    if SelectClient <> nil then
      SelectClient.Close;
{$ELSE}
    if ServerSocket.Socket.ActiveConnections > 0 then begin
      ServerSocket.Socket.Connections[0].Close;
    end else
      if SelectSocket.Socket.ActiveConnections > 0 then begin
      SelectSocket.Socket.Connections[0].Close;
{$IFEND}
    end else begin
      TimerClose.Enabled := False;
      SelectSocket.Active := False;
      ServerSocket.Active := False;
      MainOutMessage('服务器已停止...');
      Close;
    end;
  end;

procedure TFrmMain.MENU_HELP_VERSIONClick(Sender: TObject);
begin
  MainOutMessage(g_sVersion);
  MainOutMessage(g_sUpDateTime);
  MainOutMessage(g_sProgram);
  MainOutMessage(g_sWebSite);
end;

procedure TFrmMain.G1Click(Sender: TObject);
begin
  LoadGateID();
  LoadIPTable();
  MainOutMessage('Reloaded Gate ID/IP Table');
end;

procedure TFrmMain.C1Click(Sender: TObject);
begin
  LoadChrNameList('DenyChrName.txt');
  LoadAICharNameList('AICharName.txt');
  MainOutMessage('Reloaded Character Name List');
end;

procedure TFrmMain.MemoLogChange(Sender: TObject);
begin
  if MemoLog.Lines.Count > 100 then MemoLog.Lines.Clear;
end;

procedure TFrmMain.MemoLogDblClick(Sender: TObject);
begin
  if Application.MessageBox('是否确定清除日志信息！！！', '提示信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    MemoLog.Clear;
  end;
end;

procedure TFrmMain.MENU_OPTION_GENERALClick(Sender: TObject);
begin
  FrmSetting := TFrmSetting.Create(Owner);
  FrmSetting.Open;
  FrmSetting.Free;
end;

{------------------------------------------------------------------------------}

constructor TRankingThread.Create(CreateSuspended: Boolean);
begin
  inherited;
end;

destructor TRankingThread.Destroy;
begin
  inherited;
end;

procedure TRankingThread.Execute;
resourcestring
  sExceptionMsg = '[Exception] TRankingThread::Execute';
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

procedure TRankingThread.RefRanking;
var
  I: Integer;
  nIndex: Integer;
  ChrRecord: THumDataInfo;
  HumRecord: THumInfo;

  HumRanking: pTUserLevelRanking;
  HeroRanking: pTHeroLevelRanking;
  MasterRanking: pTUserMasterRanking;


  HumRankingList: TStringList;
  WarriorRankingList: TStringList;
  WizzardRankingList: TStringList;
  MonkRankingList: TStringList;

  HeroRankingList: TStringList;
  HeroWarriorRankingList: TStringList;
  HeroWizzardRankingList: TStringList;
  HeroMonkRankingList: TStringList;

  MasterRankingList: TStringList;
  QuickList: TStringList;
begin
  if g_boStartService and (not g_boRemoteClose) and (not g_boSoftClose) then begin
    HumRankingList := TStringList.Create;
    WarriorRankingList := TStringList.Create;
    WizzardRankingList := TStringList.Create;
    MonkRankingList := TStringList.Create;

    HeroRankingList := TStringList.Create;
    HeroWarriorRankingList := TStringList.Create;
    HeroWizzardRankingList := TStringList.Create;
    HeroMonkRankingList := TStringList.Create;

    MasterRankingList := TStringList.Create;

    QuickList := TStringList.Create;
    QuickList.AddStrings(g_HumCharDB.m_QuickList);
    try
      try
        if g_HumCharDB.OpenX then begin
          for I := 0 to QuickList.Count - 1 do begin
            if not g_boStartService or g_boRemoteClose or g_boSoftClose then break;
            if (g_HumCharDB.GetX(I, @HumRecord) >= 0) and (not HumRecord.boDeleted) then begin
              try
                if g_HumDataDB.OpenX then begin
                  nIndex := g_HumDataDB.Index(QuickList.Strings[I]);
                  if (nIndex >= 0) and (g_HumDataDB.GetX(nIndex, @ChrRecord) >= 0) and (not ChrRecord.Header.boDeleted) and (ChrRecord.Data.Abil.Level >= g_nRankingMinLevel) and (ChrRecord.Data.Abil.Level <= g_nRankingMaxLevel) then begin
                    if ChrRecord.Header.boIsHero then begin
                      New(HeroRanking);
                      HeroRanking.nLevel := ChrRecord.Data.Abil.Level;
                      HeroRanking.sChrName := ChrRecord.Data.sMasterName;
                      HeroRanking.sHeroName := ChrRecord.Data.sChrName;

                      HeroRankingList.AddObject(IntToStr(HeroRanking.nLevel), TObject(HeroRanking));
                      case ChrRecord.Data.btJob of
                        0: HeroWarriorRankingList.AddObject(IntToStr(HeroRanking.nLevel), TObject(HeroRanking));
                        1: HeroWizzardRankingList.AddObject(IntToStr(HeroRanking.nLevel), TObject(HeroRanking));
                        2: HeroMonkRankingList.AddObject(IntToStr(HeroRanking.nLevel), TObject(HeroRanking));
                      end;
                    end else begin
                      New(HumRanking);
                      HumRanking.nLevel := ChrRecord.Data.Abil.Level;
                      HumRanking.sChrName := ChrRecord.Data.sChrName;
                      HumRankingList.AddObject(IntToStr(HumRanking.nLevel), TObject(HumRanking));
                      case ChrRecord.Data.btJob of
                        0: WarriorRankingList.AddObject(IntToStr(HumRanking.nLevel), TObject(HumRanking));
                        1: WizzardRankingList.AddObject(IntToStr(HumRanking.nLevel), TObject(HumRanking));
                        2: MonkRankingList.AddObject(IntToStr(HumRanking.nLevel), TObject(HumRanking));
                      end;
                      if ChrRecord.Data.wMasterCount > 0 then begin
                        New(MasterRanking);
                        MasterRanking.nMasterCount := ChrRecord.Data.wMasterCount;
                        MasterRanking.sChrName := ChrRecord.Data.sChrName;
                        MasterRankingList.AddObject(IntToStr(MasterRanking.nMasterCount), TObject(MasterRanking));
                      end;
                    end;
                  end;
                end;
              finally
                g_HumDataDB.CloseX;
              end;
            end;
          end;
        end;
      except
        MainOutMessage('[Exception] RefRanking0');
      end;
    finally
      g_HumCharDB.CloseX;
    end;

    EnterCriticalSection(g_Ranking_CS);
    try
      try
        for I := 0 to g_HumRanking.Count - 1 do begin
          Dispose(pTUserLevelRanking(g_HumRanking.Objects[I]));
        end;
      except
        MainOutMessage('[Exception] RefRanking1');
      end;
    {
    for I := 0 to g_WarriorRanking.Count - 1 do begin
      Dispose(pTUserLevelRanking(g_WarriorRanking.Objects[I]));
    end;
    for I := 0 to g_WizzardRanking.Count - 1 do begin
      Dispose(pTUserLevelRanking(g_WizzardRanking.Objects[I]));
    end;
    for I := 0 to g_MonkRanking.Count - 1 do begin
      Dispose(pTUserLevelRanking(g_MonkRanking.Objects[I]));
    end;
    }
      try
        for I := 0 to g_HeroRanking.Count - 1 do begin
          Dispose(pTHeroLevelRanking(g_HeroRanking.Objects[I]));
        end;
      except
        MainOutMessage('[Exception] RefRanking2');
      end;
    {
    for I := 0 to g_HeroWarriorRanking.Count - 1 do begin
      Dispose(pTHeroLevelRanking(g_HeroWarriorRanking.Objects[I]));
    end;
    for I := 0 to g_HeroWizzardRanking.Count - 1 do begin
      Dispose(pTHeroLevelRanking(g_HeroWizzardRanking.Objects[I]));
    end;
    for I := 0 to g_HeroMonkRanking.Count - 1 do begin
      Dispose(pTHeroLevelRanking(g_HeroMonkRanking.Objects[I]));
    end;
    }
      try
        for I := 0 to g_MasterRanking.Count - 1 do begin
          Dispose(pTUserMasterRanking(g_MasterRanking.Objects[I]));
        end;
      except
        MainOutMessage('[Exception] RefRanking3');
      end;
      try
        g_HumRanking.Clear;
        g_WarriorRanking.Clear;
        g_WizzardRanking.Clear;
        g_MonkRanking.Clear;

        g_HeroRanking.Clear;
        g_HeroWarriorRanking.Clear;
        g_HeroWizzardRanking.Clear;
        g_HeroMonkRanking.Clear;

        g_MasterRanking.Clear;

        g_HumRanking.AddStrings(HumRankingList);
        g_WarriorRanking.AddStrings(WarriorRankingList);
        g_WizzardRanking.AddStrings(WizzardRankingList);
        g_MonkRanking.AddStrings(MonkRankingList);

        g_HeroRanking.AddStrings(HeroRankingList);
        g_HeroWarriorRanking.AddStrings(HeroWarriorRankingList);
        g_HeroWizzardRanking.AddStrings(HeroWizzardRankingList);
        g_HeroMonkRanking.AddStrings(HeroMonkRankingList);

        g_MasterRanking.AddStrings(MasterRankingList);

        if g_HumRanking.Count > 0 then g_HumRanking.NumberSort(True);
        if g_WarriorRanking.Count > 0 then g_WarriorRanking.NumberSort(True);
        if g_WizzardRanking.Count > 0 then g_WizzardRanking.NumberSort(True);
        if g_MonkRanking.Count > 0 then g_MonkRanking.NumberSort(True);
        if g_HeroRanking.Count > 0 then g_HeroRanking.NumberSort(True);
        if g_HeroWarriorRanking.Count > 0 then g_HeroWarriorRanking.NumberSort(True);
        if g_HeroWizzardRanking.Count > 0 then g_HeroWizzardRanking.NumberSort(True);
        if g_HeroMonkRanking.Count > 0 then g_HeroMonkRanking.NumberSort(True);
        if g_MasterRanking.Count > 0 then g_MasterRanking.NumberSort(True);
      except
        MainOutMessage('[Exception] RefRanking4');
      end;
    finally
      LeaveCriticalSection(g_Ranking_CS);
    end;

    QuickList.Free;
    HumRankingList.Free;
    WarriorRankingList.Free;
    WizzardRankingList.Free;
    MonkRankingList.Free;
    HeroRankingList.Free;
    HeroWarriorRankingList.Free;
    HeroWizzardRankingList.Free;
    HeroMonkRankingList.Free;
    MasterRankingList.Free;
  end;
end;

procedure TRankingThread.Run();
var
  Hour, Min, Sec, MSec: Word;
  dwTime: Longword;
begin
  if g_boCanRanking and g_boAutoRefRanking and g_boStartService and (not g_boRemoteClose) and (not g_boSoftClose) then begin
    case g_nAutoRefRankingType of
      0: begin
          if g_TodayDate <> Date then begin
            DecodeTime(Now, Hour, Min, Sec, MSec);
            if (Hour = g_nRefRankingHour1) and (Min = g_nRefRankingMinute1) then begin
              g_TodayDate := Date;
              RefRanking;
            end;
          end;
        end;
      1: begin
          dwTime := g_nRefRankingHour2 * 60 * 60 * 1000 + g_nRefRankingMinute2 * 60 * 1000;
          if GetTickCount - g_dwAutoRefRankingTick > dwTime then begin
            g_dwAutoRefRankingTick := GetTickCount;
            RefRanking;
          end;
        end;
    end;
  end;
end;

end.

