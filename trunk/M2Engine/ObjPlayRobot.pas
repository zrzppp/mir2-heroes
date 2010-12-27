unit ObjPlayRobot;

interface
uses
  Windows, Classes, SysUtils, DateUtils, SDK, Grobal2, ObjActor;
type
  TPlayRobotObject = class
    m_sCharName: string;
    m_sScriptFileName: string;
    m_AutoRunList: TList;
  private
    m_boRunOnWeek: Boolean; //是否已执行操作；
    procedure LoadScript();
    procedure ClearScript();
    procedure ProcessAutoRun();
    procedure AutoRun(Index: Integer; AutoRunInfo: pTAutoRunInfo; PlayObject: TPlayObject);
    procedure AutoRunOfOnWeek(AutoRunInfo: pTAutoRunInfo; PlayObject: TPlayObject);
    procedure AutoRunOfOnDay(AutoRunInfo: pTAutoRunInfo; PlayObject: TPlayObject);
    procedure AutoRunOfOnHour(AutoRunInfo: pTAutoRunInfo; PlayObject: TPlayObject);
    procedure AutoRunOfOnMin(AutoRunInfo: pTAutoRunInfo; PlayObject: TPlayObject);
    procedure AutoRunOfOnSec(AutoRunInfo: pTAutoRunInfo; PlayObject: TPlayObject);
  public
    constructor Create();
    destructor Destroy; override;
    procedure ReloadScript();
    procedure Run(PlayObject: TPlayObject);
  end;

  TPlayRobotManage = class
  private
    RobotList: TStringList;
    procedure LoadRobot();
    procedure UnLoadRobot();
  public
    constructor Create();
    destructor Destroy; override;
    procedure RELOADROBOT();
    procedure Run(PlayObject: TPlayObject);
  end;
implementation
uses M2Share, HUtil32;
//===========================人物个人机器人=====================================
{ TPlayRobotObject }

procedure TPlayRobotObject.AutoRun(Index: Integer; AutoRunInfo: pTAutoRunInfo; PlayObject: TPlayObject);
begin
  if GetTickCount - AutoRunInfo.dwRunTick > AutoRunInfo.dwRunTimeLen then begin
    {while Index > Length(PlayObject.m_RobotRunTicks) - 1 do begin
      SetLength(PlayObject.m_RobotRunTicks, Length(PlayObject.m_RobotRunTicks) + 1);
    end;
    if PlayObject.m_RobotRunTicks[Index] = 0 then PlayObject.m_RobotRunTicks[Index] := GetTickCount();
    }
    case AutoRunInfo.nRunCmd of
      nRONPCLABLEJMP: begin
          case AutoRunInfo.nMoethod of
            nRODAY: begin
                if GetTickCount - PlayObject.m_RobotRunTicks[Index] > 24 * 60 * 60 * 1000 * LongWord(AutoRunInfo.nParam1) then begin
                  PlayObject.m_RobotRunTicks[Index] := GetTickCount();
                  PlayObject.m_nScriptGotoCount := 0;
                  g_RobotNPC.GotoLable(PlayObject, AutoRunInfo.sParam2, False);
                end;
              end;
            nROHOUR: begin
                if GetTickCount - PlayObject.m_RobotRunTicks[Index] > 60 * 60 * 1000 * LongWord(AutoRunInfo.nParam1) then begin
                  PlayObject.m_RobotRunTicks[Index] := GetTickCount();
                  PlayObject.m_nScriptGotoCount := 0;
                  g_RobotNPC.GotoLable(PlayObject, AutoRunInfo.sParam2, False);
                end;
              end;
            nROMIN: begin
                if GetTickCount - PlayObject.m_RobotRunTicks[Index] > 60 * 1000 * LongWord(AutoRunInfo.nParam1) then begin
                  PlayObject.m_RobotRunTicks[Index] := GetTickCount();
                  PlayObject.m_nScriptGotoCount := 0;
                  g_RobotNPC.GotoLable(PlayObject, AutoRunInfo.sParam2, False);
                end;
              end;
            nROSEC: begin
                if GetTickCount - PlayObject.m_RobotRunTicks[Index] > 1000 * LongWord(AutoRunInfo.nParam1) then begin
                  PlayObject.m_RobotRunTicks[Index] := GetTickCount();
                  PlayObject.m_nScriptGotoCount := 0;
                  g_RobotNPC.GotoLable(PlayObject, AutoRunInfo.sParam2, False);
                end;
              end;
            nRUNONWEEK: AutoRunOfOnWeek(AutoRunInfo, PlayObject);
            nRUNONDAY: AutoRunOfOnDay(AutoRunInfo, PlayObject);
            nRUNONHOUR: AutoRunOfOnHour(AutoRunInfo, PlayObject);
            nRUNONMIN: AutoRunOfOnMin(AutoRunInfo, PlayObject);
            nRUNONSEC: AutoRunOfOnSec(AutoRunInfo, PlayObject);
          end; // case
        end;
      1: ;
      2: ;
      3: ;
    end; // case
  end;
end;

procedure TPlayRobotObject.AutoRunOfOnDay(AutoRunInfo: pTAutoRunInfo; PlayObject: TPlayObject);
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
          PlayObject.m_nScriptGotoCount := 0;
          g_RobotNPC.GotoLable(PlayObject, AutoRunInfo.sParam2, False);
          AutoRunInfo.boStatus := True;
        end;
      end else begin
        AutoRunInfo.boStatus := False;
      end;
    end;
  end;
end;

procedure TPlayRobotObject.AutoRunOfOnHour(AutoRunInfo: pTAutoRunInfo; PlayObject: TPlayObject);
begin

end;

procedure TPlayRobotObject.AutoRunOfOnMin(AutoRunInfo: pTAutoRunInfo; PlayObject: TPlayObject);
begin

end;

procedure TPlayRobotObject.AutoRunOfOnSec(AutoRunInfo: pTAutoRunInfo; PlayObject: TPlayObject);
begin

end;

procedure TPlayRobotObject.AutoRunOfOnWeek(AutoRunInfo: pTAutoRunInfo; PlayObject: TPlayObject);
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
          TPlayObject(PlayObject).m_nScriptGotoCount := 0;
          g_RobotNPC.GotoLable(TPlayObject(PlayObject), AutoRunInfo.sParam2, False);
          //          MainOutMessage('RUNONWEEK Test ' + AutoRunInfo.sParam1);
          AutoRunInfo.boStatus := True;
        end;
      end else begin
        AutoRunInfo.boStatus := False;
      end;
    end;
  end;
end;

procedure TPlayRobotObject.ClearScript;
var
  I: Integer;
begin
  for I := 0 to m_AutoRunList.Count - 1 do begin
    Dispose(pTAutoRunInfo(m_AutoRunList.Items[I]));
  end;
  m_AutoRunList.Clear;
end;

constructor TPlayRobotObject.Create;
begin
  inherited;
  m_AutoRunList := TList.Create;
  m_boRunOnWeek := False;
end;

destructor TPlayRobotObject.Destroy;
var
  I: Integer;
begin
  for I := 0 to m_AutoRunList.Count - 1 do begin
    Dispose(pTAutoRunInfo(m_AutoRunList.Items[I]));
  end;
  m_AutoRunList.Free;
  inherited;
end;

procedure TPlayRobotObject.LoadScript;
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

procedure TPlayRobotObject.ProcessAutoRun;
begin

end;

procedure TPlayRobotObject.ReloadScript;
begin
  ClearScript();
  LoadScript();
end;

procedure TPlayRobotObject.Run(PlayObject: TPlayObject);
var
  I: Integer;
  AutoRunInfo: pTAutoRunInfo;
begin
  if Length(PlayObject.m_RobotRunTicks) <> m_AutoRunList.Count then begin
    SetLength(PlayObject.m_RobotRunTicks, m_AutoRunList.Count);
    for I := 0 to Length(PlayObject.m_RobotRunTicks) - 1 do
      PlayObject.m_RobotRunTicks[I] := GetTickCount();
  end;
  {
  while Index > Length(PlayObject.m_RobotRunTicks) - 1 do begin
    SetLength(PlayObject.m_RobotRunTicks, Length(PlayObject.m_RobotRunTicks) + 1);
  end;
  if PlayObject.m_RobotRunTicks[Index] = 0 then PlayObject.m_RobotRunTicks[Index] := GetTickCount();
  }
  for I := 0 to m_AutoRunList.Count - 1 do begin
    AutoRunInfo := pTAutoRunInfo(m_AutoRunList.Items[I]);
    AutoRun(I, AutoRunInfo, PlayObject);
  end;
end;

{ TPlayRobotManage }

constructor TPlayRobotManage.Create;
begin
  inherited;
  RobotList := TStringList.Create;
  LoadRobot();
end;

destructor TPlayRobotManage.Destroy;
begin
  UnLoadRobot();
  RobotList.Free;
  inherited;
end;

procedure TPlayRobotManage.LoadRobot;
var
  I: Integer;
  LoadList: TStringList;
  sFileName: string;
  sLineText: string;
  sRobotName: string;
  sScriptFileName: string;
  sRobotType: string;
  RobotHuman: TPlayRobotObject;
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
        if (sRobotName <> '') and (sScriptFileName <> '') and (sRobotType = '1') then begin
          RobotHuman := TPlayRobotObject.Create;
          RobotHuman.m_sCharName := sRobotName;
          RobotHuman.m_sScriptFileName := sScriptFileName;
          RobotHuman.LoadScript;
          RobotList.AddObject(RobotHuman.m_sCharName, RobotHuman);
        end;
      end;
    end;
    LoadList.Free;
  end;
end;

procedure TPlayRobotManage.RELOADROBOT;
begin
  UnLoadRobot();
  LoadRobot();
end;

procedure TPlayRobotManage.Run(PlayObject: TPlayObject);
var
  I: Integer;
resourcestring
  sExceptionMsg = '[Exception] TPlayRobotManage::Run';
begin
  try
    for I := 0 to RobotList.Count - 1 do begin
      TPlayRobotObject(RobotList.Objects[I]).Run(PlayObject);
    end;
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TPlayRobotManage.UnLoadRobot;
var
  I: Integer;
begin
  for I := 0 to RobotList.Count - 1 do begin
    TPlayRobotObject(RobotList.Objects[I]).Free;
  end;
  RobotList.Clear;
end;

end.

