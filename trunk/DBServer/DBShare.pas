unit DBShare;

interface
uses
  Windows, Messages, Classes, SysUtils, JSocket, IniFiles, Controls, Grobal2, Common, HumDB, MudUtil, SDK;
resourcestring
  g_sVersion = '程序版本: 1.00 Build 20100901';
  g_sUpDateTime = '更新日期: 2010/09/01';
  g_sProgram = '程序制作: MakeGM QQ:1037527564';
  g_sWebSite = '程序网站: http://www.MakeGM.com';

type
  TRouteInfo = record
    nGateCount: Integer;
    sSelGateIP: string[15];
    sGameGateIP: array[0..7] of string[15];
    nGameGatePort: array[0..7] of Integer;
  end;
  pTRouteInfo = ^TRouteInfo;

  TModuleInfo = record
    Module: TObject;
    ModuleName: string;
    Address: string;
    Buffer: string;
  end;
  pTModuleInfo = ^TModuleInfo;

procedure LoadConfig();
procedure LoadIPTable();
procedure LoadGateID();
procedure LoadServerInfo();
function LoadChrNameList(sFileName: string): Boolean;
function LoadClearMakeIndexList(sFileName: string): Boolean;
function LoadAICharNameList(sFileName: string): Boolean;

function CheckServerIP(sIP: string): Boolean;
function GetGateID(sIPaddr: string): Integer;
function GetCodeMsgSize(X: Double): Integer;
function CheckChrName(sChrName: string): Boolean;
function InClearMakeIndexList(nIndex: Integer): Boolean;
procedure MainOutMessage(sMsg: string);
procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
function CheckDenyChrName(sChrName: string): Boolean;
function GetRankingList(nTablePage, nPageType: Integer): TStringList;

function GetMapIndex(sMap: string): Integer;
function GateRouteIP(sGateIP: string; var nPort: Integer): string;

function AddModule(ModuleInfo: pTModuleInfo): pTModuleInfo;
procedure RemoveModule(Module: TObject);
procedure UpdateModule(ModuleInfo: pTModuleInfo);

procedure UnLoadMagicList;
procedure UnLoadStdItemList;
function GetMagicName(wMagicId: Word): string;
function GetStdItemName(nPosition: Integer): string;
function CheckAIChrName(sChrName: string): Boolean;

var
  g_HumCharDB: TFileHumDB;
  g_HumDataDB: TFileDB;

  g_sHumDBFilePath: string = '.\FDB\';
  g_sDataDBFilePath: string = '.\FDB\';
  g_sFeedPath: string = '.\FDB\';
  g_sBackupPath: string = '.\FDB\';
  g_sConnectPath: string = '.\Connects\';
  g_sLogPath: string = '.\Log\';

  g_nServerPort: Integer = 6000;
  g_sServerAddr: string = '0.0.0.0';
  g_nGatePort: Integer = 5100;
  g_sGateAddr: string = '0.0.0.0';
  g_nIDServerPort: Integer = 5600;
  g_sIDServerAddr: string = '127.0.0.1';

  g_sServerName: string = 'Lite';
  g_sConfFileName: string = '.\Dbsrc.ini';
  g_sGateConfFileName: string = '.\!ServerInfo.txt';
  g_sServerIPConfFileNmae: string = '.\!AddrTable.txt';
  g_sGateIDConfFileName: string = '.\SelectID.txt';

  g_boStartService: Boolean = False;
  g_boRemoteClose: Boolean = False;
  g_boSoftClose: Boolean = False;

  g_HumDB_CS: TRTLCriticalSection;
  g_Ranking_CS: TRTLCriticalSection;
  g_sMapFile: string;
  g_DenyChrNameList: TStringList;
  g_ServerIPList: TStringList;
  g_GateIDList: TStringList;
  g_MapList: TStringList;

  g_RouteInfo: array[0..19] of TRouteInfo;

  g_ClearMakeIndex: TStringList;
  g_boDynamicIPMode: Boolean = False;


  g_ModuleList: TSortStringList;
  g_dwShowModuleTick: LongWord;


  g_HumRanking: TSortStringList;
  g_WarriorRanking: TSortStringList;
  g_WizzardRanking: TSortStringList;
  g_MonkRanking: TSortStringList;

  g_HeroRanking: TSortStringList;
  g_HeroWarriorRanking: TSortStringList;
  g_HeroWizzardRanking: TSortStringList;
  g_HeroMonkRanking: TSortStringList;

  g_MasterRanking: TSortStringList;

  g_DenyRankingChrList: TStringList;

  g_MainLogMsgList: TGStringList;
  g_boShowLogMsg: Boolean = True;
  g_dwShowMainLogTick: LongWord;



  g_nRankingMinLevel: Integer = 20;
  g_nRankingMaxLevel: Integer = 500;

  g_boAutoRefRanking: Boolean = True;
  g_nAutoRefRankingType: Integer = 0;
  g_dwAutoRefRankingTick: LongWord;

  g_nRefRankingHour1: Integer = 0;
  g_nRefRankingHour2: Integer = 0;

  g_nRefRankingMinute1: Integer = 5;
  g_nRefRankingMinute2: Integer = 5;
  g_TodayDate: TDate = 0;

  g_boAllowAddChar: Boolean = True;
  g_boAllowDelChar: Boolean = True;
  g_boAllowGetBackChar: Boolean = True;
  g_nStoreDeleteCharDay: Integer = 7;
  g_nAllowDelCharCount: Integer = 1;

  g_RefDate: TDate = 0;

  g_MagicList: TStringList;
  g_StdItemList: TStringList;

  g_dwGameCenterHandle: THandle;
  g_sNowStartServer: string = 'Gate Starting...';
  g_sNowStartServerOK: string = 'Gate Started...';

  g_nWorkStatus: Integer = 0;
  g_dwWorkStatusTick: LongWord;

  g_nCreateHumCount: Integer = 0;
  g_nDeleteHumCount: Integer = 0;
  g_nLoadHumCount: Integer = 0;
  g_nSaveHumCount: Integer = 0;
  g_nCreateHeroCount: Integer = 0;
  g_nDeleteHeroCount: Integer = 0;
  g_nLoadHeroCount: Integer = 0;
  g_nSaveHeroCount: Integer = 0;


  g_boDenyChrName: Boolean = False;
  g_boMinimize: Boolean = False;
  g_boDeleteChrName: Boolean = False;
  g_boRandomNumber: Boolean = False;

  g_boCanRanking: Boolean = True;

  g_AICharNameList: TStringList;


implementation
uses HUtil32;

procedure UnLoadMagicList;
var
  I: Integer;
begin
  {for I := 0 to g_MagicList.Count - 1 do begin
    Dispose(pTMagic(g_MagicList.Items[I]));
  end;  }
  g_MagicList.Clear;
end;

procedure UnLoadStdItemList;
var
  I: Integer;
begin
 { for I := 0 to g_StdItemList.Count - 1 do begin
    Dispose(pTStdItem(g_StdItemList.Items[I]));
  end; }
  g_StdItemList.Clear;
end;

function GetStdItemName(nPosition: Integer): string;
var
  i: Integer;
  StdItem: pTStdItem;
begin
  Result := '';
  if (nPosition - 1 >= 0) and (nPosition < g_StdItemList.Count) then begin
    Result := g_StdItemList[nPosition - 1];
    {StdItem := g_StdItemList.Items[nPosition - 1];
    if StdItem <> nil then begin
      Result := StdItem.Name;
    end;}
  end;
end;

function GetMagicName(wMagicId: Word): string;
var
  I: Integer;
  Magic: pTMagic;
begin
  Result := '';
  for I := 0 to g_MagicList.Count - 1 do begin
    if Integer(g_MagicList.Objects[I]) = wMagicId then begin
      Result := g_MagicList[I];
      break;
    end;
    {Magic := g_MagicList.Items[I];
    if Magic <> nil then begin
      if Magic.wMagicId = wMagicId then begin
        Result := Magic.sMagicName;
        break;
      end;
    end;}
  end;
end;

function AddModule(ModuleInfo: pTModuleInfo): pTModuleInfo;
var
  I: Integer;
  Module: pTModuleInfo;
begin
  Result := nil;
  for I := 0 to g_ModuleList.Count - 1 do begin
    if pTModuleInfo(g_ModuleList.Objects[I]).Module = ModuleInfo.Module then begin
      pTModuleInfo(g_ModuleList.Objects[I])^ := ModuleInfo^;
      Result := pTModuleInfo(g_ModuleList.Objects[I]);
      Exit;
    end;
  end;
  New(Module);
  Module^ := ModuleInfo^;
  g_ModuleList.AddObject(Module.ModuleName, TObject(Module));
  Result := Module;
end;

procedure RemoveModule(Module: TObject);
var
  I: Integer;
begin
  for I := 0 to g_ModuleList.Count - 1 do begin
    if pTModuleInfo(g_ModuleList.Objects[I]).Module = Module then begin
      Dispose(pTModuleInfo(g_ModuleList.Objects[I]));
      g_ModuleList.Delete(I);
      Break;
    end;
  end;
end;

procedure UpdateModule(ModuleInfo: pTModuleInfo);
var
  I: Integer;
  Module: pTModuleInfo;
begin
  for I := 0 to g_ModuleList.Count - 1 do begin
    if pTModuleInfo(g_ModuleList.Objects[I]).Module = ModuleInfo.Module then begin
      pTModuleInfo(g_ModuleList.Objects[I])^ := ModuleInfo^;
      Exit;
    end;
  end;
  New(Module);
  Module^ := ModuleInfo^;
  g_ModuleList.AddObject(Module.ModuleName, TObject(Module));
end;

function GetRankingList(nTablePage, nPageType: Integer): TStringList;
begin
  Result := nil;
  case nTablePage of
    0: begin
        case nPageType of
          0: Result := g_HumRanking;
          1: Result := g_WarriorRanking;
          2: Result := g_WizzardRanking;
          3: Result := g_MonkRanking;
        end;
      end;
    1: begin
        case nPageType of
          0: Result := g_HeroRanking;
          1: Result := g_HeroWarriorRanking;
          2: Result := g_HeroWizzardRanking;
          3: Result := g_HeroMonkRanking;
        end;
      end;
    2: Result := g_MasterRanking;
  end;
end;

function CheckServerIP(sIP: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to g_ServerIPList.Count - 1 do begin
    if CompareText(sIP, g_ServerIPList.Strings[I]) = 0 then begin
      Result := True;
      Break;
    end;
  end;
end;

function LoadChrNameList(sFileName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  if FileExists(sFileName) then begin
    g_DenyChrNameList.Clear;
    g_DenyChrNameList.LoadFromFile(sFileName);
    I := 0;
    while (True) do begin
      if g_DenyChrNameList.Count <= I then Break;
      if Trim(g_DenyChrNameList.Strings[I]) = '' then begin
        g_DenyChrNameList.Delete(I);
        Continue;
      end;
      Inc(I);
    end;
    Result := True;
  end;
end;

function LoadAICharNameList(sFileName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  if FileExists(sFileName) then begin
    g_AICharNameList.Clear;
    g_AICharNameList.LoadFromFile(sFileName);
    I := 0;
    while (True) do begin
      if g_AICharNameList.Count <= I then Break;
      if Trim(g_AICharNameList.Strings[I]) = '' then begin
        g_AICharNameList.Delete(I);
        Continue;
      end;
      Inc(I);
    end;
    Result := True;
  end;
end;

function LoadClearMakeIndexList(sFileName: string): Boolean;
var
  I: Integer;
  nIndex: Integer;
  sLineText: string;
begin
  Result := False;
  if FileExists(sFileName) then begin
    g_ClearMakeIndex.LoadFromFile(sFileName);
    I := 0;
    while (True) do begin
      if g_ClearMakeIndex.Count <= I then Break;
      sLineText := g_ClearMakeIndex.Strings[I];
      nIndex := Str_ToInt(sLineText, -1);
      if nIndex < 0 then begin
        g_ClearMakeIndex.Delete(I);
        Continue;
      end;
      g_ClearMakeIndex.Objects[I] := TObject(nIndex);
      Inc(I);
    end;
    Result := True;
  end;
end;

procedure LoadServerInfo();
var
  I: Integer;
  LoadList: TStringList;
  nRouteIdx, nGateIdx, nServerIndex: Integer;
  sLineText, sSelGateIPaddr, sGameGateIPaddr, sGameGate, sGameGatePort, sMapName, sMapInfo, sServerIndex: string;
  Conf: TIniFile;
begin
  FillChar(g_RouteInfo, SizeOf(g_RouteInfo), #0);
  if not FileExists(g_sGateConfFileName) then begin
    LoadList := TStringList.Create;
    LoadList.Add('127.0.0.1 127.0.0.1 7200');
    try
      LoadList.SaveToFile(g_sGateConfFileName);
    except
    end;
    LoadList.Free;
  end;
  if FileExists(g_sGateConfFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(g_sGateConfFileName);
    except
    end;
    nRouteIdx := 0;
    nGateIdx := 0;
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        sGameGate := GetValidStr3(sLineText, sSelGateIPaddr, [' ', #9]);
        if (sGameGate = '') or (sSelGateIPaddr = '') then Continue;
        g_RouteInfo[nRouteIdx].sSelGateIP := Trim(sSelGateIPaddr);
        g_RouteInfo[nRouteIdx].nGateCount := 0;
        nGateIdx := 0;
        while (sGameGate <> '') do begin
          sGameGate := GetValidStr3(sGameGate, sGameGateIPaddr, [' ', #9]);
          sGameGate := GetValidStr3(sGameGate, sGameGatePort, [' ', #9]);
          g_RouteInfo[nRouteIdx].sGameGateIP[nGateIdx] := Trim(sGameGateIPaddr);
          g_RouteInfo[nRouteIdx].nGameGatePort[nGateIdx] := Str_ToInt(sGameGatePort, 0);
          Inc(nGateIdx);
        end;
        g_RouteInfo[nRouteIdx].nGateCount := nGateIdx;
        Inc(nRouteIdx);
      end;
    end;
    LoadList.Free;
  end;

  Conf := TIniFile.Create(g_sConfFileName);
  g_sMapFile := Conf.ReadString('Setup', 'MapFile', g_sMapFile);
  Conf.Free;

  g_MapList.Clear;
  if FileExists(g_sMapFile) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(g_sMapFile);
    except
    end;
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[I];
      if (sLineText <> '') and (sLineText[1] = '[') then begin
        sLineText := ArrestStringEx(sLineText, '[', ']', sMapName);
        sMapInfo := GetValidStr3(sMapName, sMapName, [#32, #9]);
        sServerIndex := Trim(GetValidStr3(sMapInfo, sMapInfo, [#32, #9]));
        nServerIndex := Str_ToInt(sServerIndex, 0);
        g_MapList.AddObject(sMapName, TObject(nServerIndex));
      end;
    end;
    LoadList.Free;
  end;
end;

procedure LoadGateID();
var
  I: Integer;
  LoadList: TStringList;
  sLineText: string;
  sID: string;
  sIPaddr: string;
  nID: Integer;
begin
  g_GateIDList.Clear;
  if FileExists(g_sGateIDConfFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(g_sGateIDConfFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[I];
      if (sLineText = '') or (sLineText[1] = ';') then Continue;
      sLineText := GetValidStr3(sLineText, sID, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sIPaddr, [' ', #9]);
      nID := Str_ToInt(sID, -1);
      if nID < 0 then Continue;
      g_GateIDList.AddObject(sIPaddr, TObject(nID))
    end;
    LoadList.Free;
  end;
end;

function GetGateID(sIPaddr: string): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to g_GateIDList.Count - 1 do begin
    if g_GateIDList.Strings[I] = sIPaddr then begin
      Result := Integer(g_GateIDList.Objects[I]);
      Break;
    end;
  end;
end;

procedure LoadIPTable();
begin
  if not FileExists(g_sServerIPConfFileNmae) then begin
    g_ServerIPList.Add('127.0.0.1');
    try
      g_ServerIPList.SaveToFile(g_sServerIPConfFileNmae);
    except
    end;
  end else begin
    g_ServerIPList.Clear;
    try
      g_ServerIPList.LoadFromFile(g_sServerIPConfFileNmae);
    except
      MainOutMessage('加载IP列表文件 ' + g_sServerIPConfFileNmae + ' 出错！！！');
    end;
  end;
end;

function GateRouteIP(sGateIP: string; var nPort: Integer): string;
  function GetRoute(RouteInfo: pTRouteInfo; var nGatePort: Integer): string;
  var
    nGateIndex: Integer;
  begin
    nGateIndex := Random(RouteInfo.nGateCount);
    Result := RouteInfo.sGameGateIP[nGateIndex];
    nGatePort := RouteInfo.nGameGatePort[nGateIndex];
  end;
var
  I: Integer;
  RouteInfo: pTRouteInfo;
begin
  nPort := 0;
  Result := '';
  for I := Low(g_RouteInfo) to High(g_RouteInfo) do begin
    RouteInfo := @g_RouteInfo[I];
    if RouteInfo.sSelGateIP = sGateIP then begin
      Result := GetRoute(RouteInfo, nPort);
      Break;
    end;
  end;
end;

function GetMapIndex(sMap: string): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to g_MapList.Count - 1 do begin
    if g_MapList.Strings[I] = sMap then begin
      Result := Integer(g_MapList.Objects[I]);
      Break;
    end;
  end;
end;

procedure LoadConfig();
var
  Conf: TIniFile;
  LoadInteger: Integer;
begin
  Conf := TIniFile.Create(g_sConfFileName);
  if Conf <> nil then begin
    g_sDataDBFilePath := Conf.ReadString('DB', 'Dir', g_sDataDBFilePath);
    g_sHumDBFilePath := Conf.ReadString('DB', 'HumDir', g_sHumDBFilePath);
    g_sFeedPath := Conf.ReadString('DB', 'FeeDir', g_sFeedPath);
    g_sBackupPath := Conf.ReadString('DB', 'Backup', g_sBackupPath);
    g_sConnectPath := Conf.ReadString('DB', 'ConnectDir', g_sConnectPath);
    g_sLogPath := Conf.ReadString('DB', 'LogDir', g_sLogPath);

    g_nServerPort := Conf.ReadInteger('Setup', 'ServerPort', g_nServerPort);
    g_sServerAddr := Conf.ReadString('Setup', 'ServerAddr', g_sServerAddr);

    g_nGatePort := Conf.ReadInteger('Setup', 'GatePort', g_nGatePort);
    g_sGateAddr := Conf.ReadString('Setup', 'GateAddr', g_sGateAddr);

    g_sIDServerAddr := Conf.ReadString('Server', 'IDSAddr', g_sIDServerAddr);
    g_nIDServerPort := Conf.ReadInteger('Server', 'IDSPort', g_nIDServerPort);

    g_sServerName := Conf.ReadString('Setup', 'ServerName', g_sServerName);

    g_boDenyChrName := Conf.ReadBool('Setup', 'DenyChrName', g_boDenyChrName);
    g_boMinimize := Conf.ReadBool('Setup', 'Minimize', g_boMinimize);
    g_boDeleteChrName := Conf.ReadBool('Setup', 'DeleteChrName', g_boDeleteChrName);
    g_boRandomNumber := Conf.ReadBool('Setup', 'RandomNumber', g_boRandomNumber);

    {boViewHackMsg := Conf.ReadBool('Setup', 'ViewHackMsg', boViewHackMsg);

    boClearLevel1:=Conf.ReadBool('DBClear','ClearLevel1',boClearLevel1);
    boClearLevel2:=Conf.ReadBool('DBClear','ClearLevel2',boClearLevel2);
    boClearLevel3:=Conf.ReadBool('DBClear','ClearLevel3',boClearLevel3);

    dwInterval := Conf.ReadInteger('DBClear', 'Interval', dwInterval);
    nLevel1 := Conf.ReadInteger('DBClear', 'Level1', nLevel1);
    nLevel2 := Conf.ReadInteger('DBClear', 'Level2', nLevel2);
    nLevel3 := Conf.ReadInteger('DBClear', 'Level3', nLevel3);
    nDay1 := Conf.ReadInteger('DBClear', 'Day1', nDay1);
    nDay2 := Conf.ReadInteger('DBClear', 'Day2', nDay2);
    nDay3 := Conf.ReadInteger('DBClear', 'Day3', nDay3);
    nMonth1 := Conf.ReadInteger('DBClear', 'Month1', nMonth1);
    nMonth2 := Conf.ReadInteger('DBClear', 'Month2', nMonth2);
    nMonth3 := Conf.ReadInteger('DBClear', 'Month3', nMonth3);  }

    LoadInteger := Conf.ReadInteger('Setup', 'DynamicIPMode', -1);
    if LoadInteger < 0 then begin
      Conf.WriteBool('Setup', 'DynamicIPMode', g_boDynamicIPMode);
    end else g_boDynamicIPMode := LoadInteger = 1;

    g_boAutoRefRanking := Conf.ReadBool('Setup', 'AutoRefRanking', g_boAutoRefRanking);
    g_nRankingMinLevel := Conf.ReadInteger('Setup', 'RankingMinLevel', g_nRankingMinLevel);
    g_nRankingMaxLevel := Conf.ReadInteger('Setup', 'RankingMaxLevel', g_nRankingMaxLevel);
    g_nRefRankingHour1 := Conf.ReadInteger('Setup', 'RefRankingHour1', g_nRefRankingHour1);
    g_nRefRankingHour2 := Conf.ReadInteger('Setup', 'RefRankingHour2', g_nRefRankingHour2);

    g_nRefRankingMinute1 := Conf.ReadInteger('Setup', 'RefRankingMinute1', g_nRefRankingMinute1);
    g_nRefRankingMinute2 := Conf.ReadInteger('Setup', 'RefRankingMinute2', g_nRefRankingMinute2);

    g_nAutoRefRankingType := Conf.ReadInteger('Setup', 'AutoRefRankingType', g_nAutoRefRankingType);

    g_boAllowAddChar := Conf.ReadBool('Setup', 'AllowAddChar', g_boAllowAddChar);
    g_boAllowDelChar := Conf.ReadBool('Setup', 'AllowDelChar', g_boAllowDelChar);
    g_boAllowGetBackChar := Conf.ReadBool('Setup', 'AllowGetBackChar', g_boAllowGetBackChar);

    g_nStoreDeleteCharDay := Conf.ReadInteger('Setup', 'StoreDeleteCharDay', g_nStoreDeleteCharDay);
    g_nAllowDelCharCount := Conf.ReadInteger('Setup', 'AllowDelCharCount', g_nAllowDelCharCount);
    Conf.Free;
  end;
  LoadIPTable();
  LoadGateID();
  LoadServerInfo();
  LoadChrNameList('DenyChrName.txt');
  LoadAICharNameList('AICharName.txt');
  LoadClearMakeIndexList('ClearMakeIndex.txt');
end;

function GetCodeMsgSize(X: Double): Integer;
begin
  if Int(X) < X then Result := Trunc(X) + 1
  else Result := Trunc(X)
end;

function CheckAIChrName(sChrName: string): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to g_AICharNameList.Count - 1 do begin
    if CompareText(sChrName, g_AICharNameList.Strings[I]) = 0 then begin
      Result := False;
      Break;
    end;
  end;
end;

function CheckDenyChrName(sChrName: string): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to g_DenyChrNameList.Count - 1 do begin
    if CompareText(sChrName, g_DenyChrNameList.Strings[I]) = 0 then begin
      Result := False;
      Break;
    end;
  end;
end;

function CheckChrName(sChrName: string): Boolean;
var
  I: Integer;
  Chr: Char;
  boIsTwoByte: Boolean;
  FirstChr: Char;
begin
  Result := True;
  boIsTwoByte := False;
  FirstChr := #0;
  for I := 1 to Length(sChrName) do begin
    Chr := (sChrName[I]);
    if boIsTwoByte then begin
      //if Chr < #$A1 then Result:=False; //如果小于就是非法字符
//      if Chr < #$81 then Result:=False; //如果小于就是非法字符

      if not ((FirstChr <= #$F7) and (Chr >= #$40) and (Chr <= #$FE)) then
        if not ((FirstChr > #$F7) and (Chr >= #$40) and (Chr <= #$A0)) then Result := False;
      boIsTwoByte := False;
    end else begin //0045BEC0
      //if (Chr >= #$B0) and (Chr <= #$C8) then begin
      if (Chr >= #$81) and (Chr <= #$FE) then begin
        boIsTwoByte := True;
        FirstChr := Chr;
      end else begin //0x0045BED2
        if not ((Chr >= '0' {#30}) and (Chr <= '9' {#39})) and
          not ((Chr >= 'a' {#61}) and (Chr <= 'z') {#7A}) and
          not ((Chr >= 'A' {#41}) and (Chr <= 'Z' {#5A})) then
          Result := False;
      end;
    end;
    if not Result then Break;
  end;
end;

function InClearMakeIndexList(nIndex: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to g_ClearMakeIndex.Count - 1 do begin
    if nIndex = Integer(g_ClearMakeIndex.Objects[I]) then begin
      Result := True;
      Break;
    end;
  end;
end;

procedure MainOutMessage(sMsg: string);
var
  tMsg: string;
begin
  if not g_boShowLogMsg then Exit;
  g_MainLogMsgList.Lock;
  try
    tMsg := '[' + DateTimeToStr(Now) + '] ' + sMsg;
    g_MainLogMsgList.Add(tMsg);
  finally
    g_MainLogMsgList.UnLock;
  end;
end;

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
var
  SendData: TCopyDataStruct;
  nParam: Integer;
begin
  nParam := MakeLong(Word(tDBServer), wIdent);
  SendData.cbData := Length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle, WM_COPYDATA, nParam, Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

initialization
  begin
    InitializeCriticalSection(g_HumDB_CS);
    InitializeCriticalSection(g_Ranking_CS);
    g_MainLogMsgList := TGStringList.Create;
    g_DenyChrNameList := TStringList.Create;
    g_ServerIPList := TStringList.Create;
    g_GateIDList := TStringList.Create;
    g_MapList := TStringList.Create;
    g_ClearMakeIndex := TStringList.Create;
    g_DenyRankingChrList := TStringList.Create;
    g_AICharNameList := TStringList.Create;
  end;

finalization
  begin
    DeleteCriticalSection(g_HumDB_CS);
    DeleteCriticalSection(g_Ranking_CS);
    g_AICharNameList.Free;
    g_DenyChrNameList.Free;
    g_ServerIPList.Free;
    g_GateIDList.Free;
    g_MapList.Free;
    g_ClearMakeIndex.Free;
    g_DenyRankingChrList.Free;
    g_MainLogMsgList.Free;

  end;

end.

