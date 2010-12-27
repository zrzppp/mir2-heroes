unit ObjRobot;

interface
uses
  Windows, Classes, SysUtils, DateUtils, ObjBase, ObjActor, Grobal2, SDK, Envir;
type
  TRobotObject = class(TPlayObject)
    m_sScriptFileName: string;
    m_AutoRunList: TList;
  private
    m_boRunOnWeek: Boolean; //是否已执行操作；
    procedure LoadScript();
    procedure ClearScript();
    procedure ProcessAutoRun();
    procedure AutoRun(AutoRunInfo: pTAutoRunInfo);
    procedure AutoRunOfOnWeek(AutoRunInfo: pTAutoRunInfo);
    procedure AutoRunOfOnDay(AutoRunInfo: pTAutoRunInfo);
    procedure AutoRunOfOnHour(AutoRunInfo: pTAutoRunInfo);
    procedure AutoRunOfOnMin(AutoRunInfo: pTAutoRunInfo);
    procedure AutoRunOfOnSec(AutoRunInfo: pTAutoRunInfo);

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure SendSocket(DefMsg: pTDefaultMessage; sMsg: string); override;
    procedure ReloadScript();
    procedure Run(); override;
    procedure SendRefMsg(Envir: TEnvirnoment; nX, nY, wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; sMsg: string);
    function IsProperTarget(BaseObject: TActorObject): Boolean; override;
  end;
  TRobotManage = class
    RobotHumanList: TStringList;
  private
    procedure LoadRobot();
    procedure UnLoadRobot();
  public
    constructor Create();
    destructor Destroy; override;
    procedure RELOADROBOT();
    procedure Run;
  end;
implementation

uses M2Share, HUtil32;

{ TRobotObject }

procedure TRobotObject.AutoRun(AutoRunInfo: pTAutoRunInfo);
begin
  if (g_RobotNPC = nil) or (AutoRunInfo = nil) then begin
    Exit;
  end;
  //try
  if GetTickCount - AutoRunInfo.dwRunTick > AutoRunInfo.dwRunTimeLen then begin
    case AutoRunInfo.nRunCmd of //
      nRONPCLABLEJMP: begin
          case AutoRunInfo.nMoethod of //
            nRODAY: begin
                if GetTickCount - AutoRunInfo.dwRunTick > 24 * 60 * 60 * 1000 * LongWord(AutoRunInfo.nParam1) then begin
                  AutoRunInfo.dwRunTick := GetTickCount();
                  m_nScriptGotoCount := 0;
                  g_RobotNPC.GotoLable(Self, AutoRunInfo.sParam2, False);
                end;
              end;
            nROHOUR: begin
                if GetTickCount - AutoRunInfo.dwRunTick > 60 * 60 * 1000 * LongWord(AutoRunInfo.nParam1) then begin
                  AutoRunInfo.dwRunTick := GetTickCount();
                  m_nScriptGotoCount := 0;
                  g_RobotNPC.GotoLable(Self, AutoRunInfo.sParam2, False);
                end;
              end;
            nROMIN: begin
                if GetTickCount - AutoRunInfo.dwRunTick > 60 * 1000 * LongWord(AutoRunInfo.nParam1) then begin
                  AutoRunInfo.dwRunTick := GetTickCount();
                  m_nScriptGotoCount := 0;
                  g_RobotNPC.GotoLable(Self, AutoRunInfo.sParam2, False);
                end;
              end;
            nROSEC: begin
                if GetTickCount - AutoRunInfo.dwRunTick > 1000 * LongWord(AutoRunInfo.nParam1) then begin
                  AutoRunInfo.dwRunTick := GetTickCount();
                  m_nScriptGotoCount := 0;
                  g_RobotNPC.GotoLable(Self, AutoRunInfo.sParam2, False);
                end;
              end;
            nRUNONWEEK: AutoRunOfOnWeek(AutoRunInfo);
            nRUNONDAY: AutoRunOfOnDay(AutoRunInfo);
            nRUNONHOUR: AutoRunOfOnHour(AutoRunInfo);
            nRUNONMIN: AutoRunOfOnMin(AutoRunInfo);
            nRUNONSEC: AutoRunOfOnSec(AutoRunInfo);

          end; // case
        end;
      1: ;
      2: ;
      3: ;
    end; // case
  end;
  {except
     MainOutMessage('TRobotObject.AutoRun:'+AutoRunInfo.sParam2);
  end;}
end;

procedure TRobotObject.AutoRunOfOnDay(AutoRunInfo: pTAutoRunInfo);
var
  nMIN, nHOUR, nWeek: Integer;
  wWeek, wHour, wMin, wSec, wMSec: Word;
  sMIN, sHOUR, sWeek: string;
  sLineText, sLabel: string;
begin
  sLineText := AutoRunInfo.sParam1;
  sLineText := GetValidStr3(sLineText, sHOUR, [':']);
  sLineText := GetValidStr3(sLineText, sMIN, [':']);
  nHOUR := Str_ToInt(sHOUR, -1);
  nMIN := Str_ToInt(sMIN, -1);
  sLabel := AutoRunInfo.sParam2;
  DecodeTime(Time, wHour, wMin, wSec, wMSec);
  if (nHOUR in [0..24]) and (nMIN in [0..60]) then begin
    if (wHour = nHOUR) then begin
      if (wMin = nMIN) then begin
        if not AutoRunInfo.boStatus then begin
          m_nScriptGotoCount := 0;
          g_RobotNPC.GotoLable(Self, AutoRunInfo.sParam2, False);
          //          MainOutMessage('RUNONWEEK Test ' + AutoRunInfo.sParam1);
          AutoRunInfo.boStatus := True;
        end;
      end else begin
        AutoRunInfo.boStatus := False;
      end;
    end;
  end;
end;

procedure TRobotObject.AutoRunOfOnHour(AutoRunInfo: pTAutoRunInfo);
begin

end;

procedure TRobotObject.AutoRunOfOnMin(AutoRunInfo: pTAutoRunInfo);
begin

end;

procedure TRobotObject.AutoRunOfOnSec(AutoRunInfo: pTAutoRunInfo);
begin

end;

procedure TRobotObject.AutoRunOfOnWeek(AutoRunInfo: pTAutoRunInfo);
var
  nMIN, nHOUR, nWeek: Integer;
  wWeek, wHour, wMin, wSec, wMSec: Word;
  sMIN, sHOUR, sWeek: string;
  sLineText, sLabel: string;
begin
  sLineText := AutoRunInfo.sParam1;
  sLineText := GetValidStr3(sLineText, sWeek, [':']);
  sLineText := GetValidStr3(sLineText, sHOUR, [':']);
  sLineText := GetValidStr3(sLineText, sMIN, [':']);
  nWeek := Str_ToInt(sWeek, -1);
  nHOUR := Str_ToInt(sHOUR, -1);
  nMIN := Str_ToInt(sMIN, -1);
  sLabel := AutoRunInfo.sParam2;
  DecodeTime(Time, wHour, wMin, wSec, wMSec);
  wWeek := DayOfTheWeek(Now);
  if (nWeek in [1..7]) and (nHOUR in [0..24]) and (nMIN in [0..60]) then begin
    if (wWeek = nWeek) and (wHour = nHOUR) then begin
      if (wMin = nMIN) then begin
        if not AutoRunInfo.boStatus then begin
          m_nScriptGotoCount := 0;
          g_RobotNPC.GotoLable(Self, AutoRunInfo.sParam2, False);
          //          MainOutMessage('RUNONWEEK Test ' + AutoRunInfo.sParam1);
          AutoRunInfo.boStatus := True;
        end;
      end else begin
        AutoRunInfo.boStatus := False;
      end;
    end;
  end;
end;

procedure TRobotObject.ClearScript;
var
  I: Integer;
begin
  for I := 0 to m_AutoRunList.Count - 1 do begin
    Dispose(pTAutoRunInfo(m_AutoRunList.Items[I]));
  end;
  m_AutoRunList.Clear;
end;

constructor TRobotObject.Create;
begin
  inherited;
  m_AutoRunList := TList.Create;
  m_boSuperMan := True;
  m_boRunOnWeek := False;
  m_boRunPlayRobotManage := False; //关闭个人机器人
end;

destructor TRobotObject.Destroy;
begin
  ClearScript();
  m_AutoRunList.Free;
  inherited;
end;

procedure TRobotObject.LoadScript;
var
  I: Integer;
  LoadList: TStringList;
  sFileName: string;
  sLineText: string;
  sActionType: string;
  sRunCmd: string;
  sMoethod: string;
  sParam1: string;
  sParam2: string;
  sParam3: string;
  sParam4: string;
  AutoRunInfo: pTAutoRunInfo;
begin
  sFileName := g_Config.sEnvirDir + 'Robot_def\' + m_sScriptFileName + '.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[I];
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        sLineText := GetValidStr3(sLineText, sActionType, [' ', '/', #9]);
        sLineText := GetValidStr3(sLineText, sRunCmd, [' ', '/', #9]);
        sLineText := GetValidStr3(sLineText, sMoethod, [' ', '/', #9]);
        sLineText := GetValidStr3(sLineText, sParam1, [' ', '/', #9]);
        sLineText := GetValidStr3(sLineText, sParam2, [' ', '/', #9]);
        sLineText := GetValidStr3(sLineText, sParam3, [' ', '/', #9]);
        sLineText := GetValidStr3(sLineText, sParam4, [' ', '/', #9]);
        if CompareText(sActionType, sROAUTORUN) = 0 then begin
          if CompareText(sRunCmd, sRONPCLABLEJMP) = 0 then begin
            New(AutoRunInfo);
            AutoRunInfo.dwRunTick := GetTickCount;
            AutoRunInfo.dwRunTimeLen := 0;
            AutoRunInfo.boStatus := False;
            AutoRunInfo.nRunCmd := nRONPCLABLEJMP;
            if CompareText(sMoethod, sRODAY) = 0 then
              AutoRunInfo.nMoethod := nRODAY;
            if CompareText(sMoethod, sROHOUR) = 0 then
              AutoRunInfo.nMoethod := nROHOUR;
            if CompareText(sMoethod, sROMIN) = 0 then
              AutoRunInfo.nMoethod := nROMIN;
            if CompareText(sMoethod, sROSEC) = 0 then
              AutoRunInfo.nMoethod := nROSEC;
            if CompareText(sMoethod, sRUNONWEEK) = 0 then
              AutoRunInfo.nMoethod := nRUNONWEEK;
            if CompareText(sMoethod, sRUNONDAY) = 0 then
              AutoRunInfo.nMoethod := nRUNONDAY;
            if CompareText(sMoethod, sRUNONHOUR) = 0 then
              AutoRunInfo.nMoethod := nRUNONHOUR;
            if CompareText(sMoethod, sRUNONMIN) = 0 then
              AutoRunInfo.nMoethod := nRUNONMIN;
            if CompareText(sMoethod, sRUNONSEC) = 0 then
              AutoRunInfo.nMoethod := nRUNONSEC;

            AutoRunInfo.sParam1 := sParam1;
            AutoRunInfo.sParam2 := sParam2;
            AutoRunInfo.sParam3 := sParam3;
            AutoRunInfo.sParam4 := sParam4;
            AutoRunInfo.nParam1 := Str_ToInt(sParam1, 1);
            m_AutoRunList.Add(AutoRunInfo);
          end;
        end;

      end;
    end;
    LoadList.Free;
  end;
end;

procedure TRobotObject.ProcessAutoRun;
var
  I: Integer;
  AutoRunInfo: pTAutoRunInfo;
begin
  for I := 0 to m_AutoRunList.Count - 1 do begin
    AutoRunInfo := pTAutoRunInfo(m_AutoRunList.Items[I]);
    if AutoRunInfo <> nil then AutoRun(AutoRunInfo);
  end;
end;

procedure TRobotObject.ReloadScript;
begin
  ClearScript();
  LoadScript();
end;

procedure TRobotObject.Run;
begin
  ProcessAutoRun();
  //  inherited;
end;

procedure TRobotObject.SendSocket(DefMsg: pTDefaultMessage; sMsg: string);
begin

end;

function TRobotObject.IsProperTarget(BaseObject: TActorObject): Boolean;
begin
  Result := False;
  if BaseObject <> nil then begin
    Result := (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or ((BaseObject.m_Master <> nil) and (BaseObject.Master.m_btRaceServer = RC_PLAYOBJECT));
  end;
end;

procedure TRobotObject.SendRefMsg(Envir: TEnvirnoment; nX, nY, wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; sMsg: string);
  function AddVisibleHuman(ActorObject: TActorObject): Boolean;
  var
    I: Integer;
  begin
    Result := True;
    for I := 0 to m_VisibleHumanList.Count - 1 do begin
      if TActorObject(m_VisibleHumanList.Items[I]) = ActorObject then begin
        Result := False;
        Exit;
      end;
    end;
    m_VisibleHumanList.Add(ActorObject);
  end;
var
  II, III, nC, nListCount: Integer;
  nCX, nCY, nLX, nLY, nHX, nHY, nNX, nNY: Integer;
  MapCellInfo, MapCellInfoA: pTMapCellinfo;
  BaseObject: TBaseObject;
  ActorObject: TActorObject;
  btType: Byte;
  nErrorCode: Integer;

resourcestring
  sExceptionMsg = '[Exception] TRobotObject::SendRefMsg Name = %s';
begin
  if Envir = nil then begin
    MainOutMessage(m_sCharName + ' SendRefMsg nil Envir ');
    Exit;
  end;

  EnterCriticalSection(ProcessMsgCriticalSection);
  try
    m_SendRefMsgTick := GetTickCount();
    m_VisibleHumanList.Clear;
    nLX := nX - g_Config.nSendRefMsgRange {12};
    nHX := nX + g_Config.nSendRefMsgRange {12};
    nLY := nY - g_Config.nSendRefMsgRange {12};
    nHY := nY + g_Config.nSendRefMsgRange {12};
    for nCX := nLX to nHX do begin
      for nCY := nLY to nHY do begin
        if Envir.GetMapCellInfo(nCX, nCY, MapCellInfo) then begin
          if MapCellInfo.ObjList <> nil then begin
            for II := MapCellInfo.ObjList.Count - 1 downto 0 do begin
              BaseObject := TBaseObject(MapCellInfo.ObjList.Items[II]);
              if (BaseObject <> nil) and (BaseObject.m_ObjType = t_Actor) and (BaseObject <> Self) then begin
                if (GetTickCount - BaseObject.m_dwAddTime) >= 60 * 1000 then begin
                  MapCellInfo.ObjList.Delete(II);
                  if MapCellInfo.ObjList.Count <= 0 then begin
                    nErrorCode := 3;
                    FreeAndNil(MapCellInfo.ObjList);
                    Break;
                  end;
                end else begin
                  try
                    ActorObject := TActorObject(BaseObject);
                    if (ActorObject <> nil) and (ActorObject.m_PEnvir = Envir) and (not ActorObject.m_boGhost) then begin
                      if ActorObject.m_btRaceServer = RC_PLAYOBJECT then begin
                        if AddVisibleHuman(ActorObject) then begin
                          ActorObject.SendMsg({Self} ActorObject, wIdent, wParam, nParam1, nParam2, nParam3, sMsg);
                        end else begin
                            //2008-3-20增加 删除地图中出现重复的人物
                        {  if (ActorObject.m_nCurrX <> nCX) or (ActorObject.m_nCurrY <> nCY) then begin
                            MapCellInfo.ObjList.Delete(II);
                            if MapCellInfo.ObjList.Count <= 0 then begin
                              FreeAndNil(MapCellInfo.ObjList);
                              Break;
                            end;
                          end else begin
                              //2008-3-20增加 删除地图中出现重复的人物
                            for nNX := nLX to nCX do begin
                              for nNY := nLY to nCY do begin
                                if Envir.GetMapCellInfo(nNX, nNY, MapCellInfoA) then begin
                                  if MapCellInfoA.ObjList <> nil then begin
                                    for III := MapCellInfoA.ObjList.Count - 1 downto 0 do begin
                                      BaseObject := TBaseObject(MapCellInfoA.ObjList.Items[III]);
                                      if (BaseObject <> nil) and (BaseObject = ActorObject) and ((ActorObject.m_nCurrX <> nNX) or (ActorObject.m_nCurrY <> nNY) or (III <> II)) then begin
                                        MapCellInfoA.ObjList.Delete(III);
                                        if MapCellInfoA.ObjList.Count <= 0 then begin
                                          FreeAndNil(MapCellInfoA.ObjList);
                                          Break;
                                        end;
                                      end;
                                    end;
                                  end;
                                end;
                              end;
                            end;

                          end;}
                        end;
                      end else
                        if ActorObject.m_boWantRefMsg then begin
                        if (wIdent = RM_STRUCK) or (wIdent = RM_HEAR) or (wIdent = RM_DEATH) or (wIdent = RM_CHARSTATUSCHANGED) or (wIdent = RM_RUSH) then begin {增加分身的魔法盾效果}
                          if AddVisibleHuman(ActorObject) then begin
                            ActorObject.SendMsg({Self} ActorObject, wIdent, wParam, nParam1, nParam2, nParam3, sMsg)
                          end else begin
                              //2008-3-20增加 删除地图中出现重复的人物
                         {   if (ActorObject.m_nCurrX <> nCX) or (ActorObject.m_nCurrY <> nCY) then begin
                              MapCellInfo.ObjList.Delete(II);
                              if MapCellInfo.ObjList.Count <= 0 then begin
                                nErrorCode := 3;
                                FreeAndNil(MapCellInfo.ObjList);
                                Break;
                              end;
                            end else begin
                                //2008-3-20增加 删除地图中出现重复的人物
                              for nNX := nLX to nCX do begin
                                for nNY := nLY to nCY do begin
                                  if Envir.GetMapCellInfo(nNX, nNY, MapCellInfo) then begin
                                    if MapCellInfo.ObjList <> nil then begin
                                      for III := MapCellInfo.ObjList.Count - 1 downto 0 do begin
                                        BaseObject := TBaseObject(MapCellInfo.ObjList.Items[III]);
                                        if (BaseObject <> nil) and (BaseObject = ActorObject) and ((ActorObject.m_nCurrX <> nNX) or (ActorObject.m_nCurrY <> nNY) or (III <> II)) then begin
                                          MapCellInfo.ObjList.Delete(III);
                                          if MapCellInfo.ObjList.Count <= 0 then begin
                                            FreeAndNil(MapCellInfo.ObjList);
                                            Break;
                                          end;
                                        end;
                                      end;
                                    end;
                                  end;
                                end;
                              end;
                            end; }
                          end;
                        end;
                      end;
                    end;
                  except
                    on E: Exception do begin
                      {if (MapCellInfo.ObjList <> nil) then begin
                        if MapCellInfo.ObjList.Count <= 0 then begin
                          FreeAndNil(MapCellInfo.ObjList);
                        end;
                      end;}
                      MainOutMessage(Format(sExceptionMsg, [m_sCharName]));
                      MainOutMessage(E.Message);
                    end;
                  end;
                end;
              end;
            end; //for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          end; //if MapCellInfo.ObjList <> nil then begin
        end; //if PEnvir.GetMapCellInfo(nC,n10,MapCellInfo) then begin
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;


{ TRobotManage }

constructor TRobotManage.Create;
begin
  inherited;
  RobotHumanList := TStringList.Create;
  LoadRobot();
end;

destructor TRobotManage.Destroy;
begin
  UnLoadRobot();
  RobotHumanList.Free;
  inherited;
end;

procedure TRobotManage.LoadRobot;
var
  I: Integer;
  LoadList: TStringList;
  sFileName: string;
  sLineText: string;
  sRobotName: string;
  sScriptFileName: string;
  sRobotType: string;
  RobotHuman: TRobotObject;
begin
  sFileName := g_Config.sEnvirDir + 'Robot.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[I];
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        sLineText := GetValidStr3(sLineText, sRobotName, [' ', '/', #9]);
        sLineText := GetValidStr3(sLineText, sScriptFileName, [' ', '/', #9]);
        sLineText := GetValidStr3(sLineText, sRobotType, [' ', '/', #9]);
        if (sRobotName <> '') and (sScriptFileName <> '') and (sRobotType <> '1') then begin
          RobotHuman := TRobotObject.Create;
          RobotHuman.m_sCharName := sRobotName;
          RobotHuman.m_sScriptFileName := sScriptFileName;
          RobotHuman.LoadScript;
          RobotHumanList.AddObject(RobotHuman.m_sCharName, RobotHuman);
        end;
      end;
    end;
    LoadList.Free;
  end;
end;

procedure TRobotManage.RELOADROBOT;
begin
  UnLoadRobot();
  LoadRobot();
end;

procedure TRobotManage.Run;
var
  I: Integer;
resourcestring
  sExceptionMsg = '[Exception] TRobotManage::Run';
begin
  try
    for I := 0 to RobotHumanList.Count - 1 do begin
      TRobotObject(RobotHumanList.Objects[I]).Run;
    end;
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TRobotManage.UnLoadRobot;
var
  I: Integer;
begin
  for I := 0 to RobotHumanList.Count - 1 do begin
    TRobotObject(RobotHumanList.Objects[I]).Free;
  end;
  RobotHumanList.Clear;
end;

end.

