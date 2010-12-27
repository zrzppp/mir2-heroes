unit RunDB;

interface
uses
  Windows, Classes, SysUtils, Grobal2, JSocket, WinSock, Common, M2Share;
function DBSocketWorking(): Boolean;
function DBSocketConnected(): Boolean;
function GetDBSockMsg(nQueryID: Integer; var nIdent: Integer; var nRecog: Integer; var sDefMsg, sStr: string; dwTimeOut: LongWord; SockData: TSockData): Boolean;
function MakeHumRcdFromLocal(var HumanRcd: THumDataInfo): Boolean;
function LoadHumRcdFromDB(sAccount, sCharName, sStr: string; var HumanRcd: THumDataInfo; nCertCode: Integer): Boolean;
function SaveHumRcdToDB(sAccount, sCharName: string; nSessionID: Integer; var HumanRcd: THumDataInfo): Boolean;

function LoadHeroRcdFromDB(sAccount, sCharName, sStr: string; var HumanRcd: THumDataInfo; nCertCode: Integer): Boolean;
function SaveHeroRcdToDB(sAccount, sCharName: string; nSessionID: Integer; var HumanRcd: THumDataInfo): Boolean;
function SaveHeroRcd(sAccount, sCharName: string; nSessionID: Integer; var HumanRcd: THumDataInfo): Boolean;
function LoadHeroRcd(sAccount, sCharName, sStr: string; nCertCode: Integer; var HumanRcd: THumDataInfo): Boolean;

function DeleteHeroRcd(sAccount, sCharName: string; nSessionID: Integer; var nStatus: Integer): Boolean;
function CreateHeroRcd(sAccount, sCharName, sHeroName, sMsg: string; nSessionID: Integer; var nStatus: Integer): Boolean;

function SaveRcd(sAccount, sCharName: string; nSessionID: Integer; var HumanRcd: THumDataInfo): Boolean;
function LoadRcd(sAccount, sCharName, sStr: string; nCertCode: Integer; var HumanRcd: THumDataInfo): Boolean;
procedure SendDBSockMsg(nQueryID: Integer; sMsg: string);
function GetQueryID(Config: pTConfig): Integer;

function LoadRanking(nTabelPage, nTabelType, nPage: Integer; sHumanName: string; Msg: pTDefaultMessage; var sRankingStr: string): Boolean;
function SaveMagicList(sMsg: string): Boolean;
function SaveStdItemList(sMsg: string): Boolean;


implementation

uses svMain, HUtil32, EncryptUnit;

function DBSocketConnected(): Boolean;
begin
{$IF DBSOCKETMODE = TIMERENGINE}
  Result := FrmMain.DBSocket.Socket.Connected;
{$ELSE}
  Result := DataEngine.Connected;
{$IFEND}
end;

function DBSocketWorking(): Boolean;
begin
  Result := DataEngine.Working;
end;

function GetDBSockMsg(nQueryID: Integer; var nIdent: Integer; var nRecog: Integer; var sDefMsg, sStr: string; dwTimeOut: LongWord; SockData: TSockData): Boolean;
var
  boLoadDBOK: Boolean;
  dwTimeOutTick: LongWord;
  s24, s28, s2C, sCheckFlag, s38: string;
  nLen: Integer;
  nCheckCode: Integer;
  DefMsg: TDefaultMessage;
resourcestring
  sLoadDBTimeOut = '[RunDB] 读取人物数据超时...';
  sSaveDBTimeOut = '[RunDB] 保存人物数据超时...';
  sLoadHeroDBTimeOut = '[RunDB] 读取英雄数据超时...';
  sSaveHeroDBTimeOut = '[RunDB] 保存英雄数据超时...';
  sLoadRankingDBTimeOut = '[RunDB] 读取排行榜数据超时...';
begin
  boLoadDBOK := False;
  Result := False;
  dwTimeOutTick := GetTickCount();
  while (True) do begin
    if (GetTickCount - dwTimeOutTick) > dwTimeOut then begin
      n4EBB6C := n4EBB68;
      Break;
    end;
    s24 := '';
    EnterCriticalSection(UserDBSection);
    try
      if Pos('!', g_Config.sDBSocketRecvText) > 0 then begin
        s24 := g_Config.sDBSocketRecvText;
        g_Config.sDBSocketRecvText := '';
      end;
    finally
      LeaveCriticalSection(UserDBSection);
    end;
    if s24 <> '' then begin
      s28 := '';
      s24 := ArrestStringEx(s24, '#', '!', s28);
      if s28 <> '' then begin
        s28 := GetValidStr3(s28, s2C, ['/']);
        nLen := Length(s28);
        if (nLen >= SizeOf(TDefaultMessage)) and (Str_ToInt(s2C, 0) = nQueryID) then begin
          nCheckCode := MakeLong(Str_ToInt(s2C, 0) xor 170, nLen);
          sCheckFlag := EncodeBuffer(@nCheckCode, SizeOf(Integer));
          if CompareBackLStr(s28, sCheckFlag, Length(sCheckFlag)) then begin
            if nLen = DEFBLOCKSIZE then begin
              sDefMsg := s28;
              s38 := ''; // -> 004B3F56
            end else begin //004B3F1F
              sDefMsg := Copy(s28, 1, DEFBLOCKSIZE);
              s38 := Copy(s28, DEFBLOCKSIZE + 1, Length(s28) - DEFBLOCKSIZE - 6);
            end; //004B3F56
            DefMsg := DecodeMessage(sDefMsg);
            nIdent := DefMsg.Ident;
            nRecog := DefMsg.Recog;
            sStr := s38;
            boLoadDBOK := True;
            Result := True;
            Break;
          end;
        end else begin //004B3F87
          Inc(g_Config.nLoadDBErrorCount); // -> 004B3FA5
          Break;
        end;
      end else begin //004B3F90
        Inc(g_Config.nLoadDBErrorCount); // -> 004B3FA5
        Break;
      end;
      //end;//004B3FA5
    end else begin //004B3F99
      Sleep(1);
    end;
  end;

  if not boLoadDBOK then begin
    case SockData of
      d_LoadHumData: MainOutMessage(sLoadDBTimeOut);
      d_SaveHumData: MainOutMessage(sSaveDBTimeOut);
      d_LoadHeroData: MainOutMessage(sLoadHeroDBTimeOut);
      d_SaveHeroData: MainOutMessage(sSaveHeroDBTimeOut);
      d_LoadRankingData: MainOutMessage(sLoadRankingDBTimeOut);
    end
  end;

  if (GetTickCount - dwTimeOutTick) > dwRunDBTimeMax then begin
    dwRunDBTimeMax := GetTickCount - dwTimeOutTick;
  end;
  g_Config.boDBSocketWorking := False;
end;

function SaveMagicList(sMsg: string): Boolean;
var
  nQueryID: Integer;
  nIdent: Integer;
  nRecog: Integer;
  sStr: string;
  sDefMsg: string;
  sSendText: string;
  DefMsg: TDefaultMessage;
begin
  Result := False;
  nQueryID := GetQueryID(@g_Config);
  DefMsg := MakeDefaultMsg(DB_SAVEMAGICLIST, 0, 0, 0, 0);
  sSendText := EncodeMessage(DefMsg) + sMsg;
  SendDBSockMsg(nQueryID, sSendText);
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sDefMsg, sStr, g_Config.dwGetDBSockMsgTime {5000}, d_SaveData) then begin
    if (nIdent = DBR_SAVEMAGICLIST) and (nRecog = 1) then
      Result := True;
  end;
end;

function SaveStdItemList(sMsg: string): Boolean;
var
  nQueryID: Integer;
  nIdent: Integer;
  nRecog: Integer;
  sStr: string;
  sDefMsg: string;
  sSendText: string;
  DefMsg: TDefaultMessage;
begin
  Result := False;
  nQueryID := GetQueryID(@g_Config);
  DefMsg := MakeDefaultMsg(DB_SAVESTDITEMLIST, 0, 0, 0, 0);
  sSendText := EncodeMessage(DefMsg) + sMsg;
  SendDBSockMsg(nQueryID, sSendText);
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sDefMsg, sStr, g_Config.dwGetDBSockMsgTime {5000}, d_SaveData) then begin
    if (nIdent = DBR_SAVESTDITEMLIST) and (nRecog = 1) then
      Result := True;
  end;
end;

function MakeHumRcdFromLocal(var HumanRcd: THumDataInfo): Boolean;
begin
  FillChar(HumanRcd, SizeOf(THumDataInfo), #0);
  HumanRcd.Data.Abil.Level := 30;
  Result := True;
end;

function LoadHumRcdFromDB(sAccount, sCharName, sStr: string; var HumanRcd: THumDataInfo; nCertCode: Integer): Boolean; //004B3A68
begin
  Result := False;
  FillChar(HumanRcd, SizeOf(THumDataInfo), #0);
  if LoadRcd(sAccount, sCharName, sStr, nCertCode, HumanRcd) then begin
    if (HumanRcd.Data.sChrName = sCharName) and ((HumanRcd.Data.sAccount = '') or (HumanRcd.Data.sAccount = sAccount)) then
      Result := True;
  end;
  Inc(g_Config.nLoadDBCount);
end;

function SaveHumRcdToDB(sAccount, sCharName: string; nSessionID: Integer; var HumanRcd: THumDataInfo): Boolean; //004B3B5C
begin
  Result := SaveRcd(sAccount, sCharName, nSessionID, HumanRcd);
  Inc(g_Config.nSaveDBCount);
end;

function LoadHeroRcdFromDB(sAccount, sCharName, sStr: string; var HumanRcd: THumDataInfo; nCertCode: Integer): Boolean; //004B3A68
begin
  Result := False;
  FillChar(HumanRcd, SizeOf(THumDataInfo), #0);
  if LoadHeroRcd(sAccount, sCharName, sStr, nCertCode, HumanRcd) then begin
    if (HumanRcd.Data.sChrName = sCharName) and ((HumanRcd.Data.sAccount = '') or (HumanRcd.Data.sAccount = sAccount)) then
      Result := True;
  end;
  Inc(g_Config.nLoadDBCount);
end;

function SaveHeroRcdToDB(sAccount, sCharName: string; nSessionID: Integer; var HumanRcd: THumDataInfo): Boolean; //004B3B5C
begin
  Result := SaveHeroRcd(sAccount, sCharName, nSessionID, HumanRcd);
  Inc(g_Config.nSaveDBCount);
end;

function DeleteHeroRcd(sAccount, sCharName: string; nSessionID: Integer; var nStatus: Integer): Boolean;
var
  DefMsg: TDefaultMessage;
  nQueryID: Integer;
  nIdent: Integer;
  nRecog: Integer;
  sStr: string;
  sDefMsg: string;
begin
  nQueryID := GetQueryID(@g_Config);
  Result := False;
  n4EBB68 := 101;
  nStatus := 0;
  SendDBSockMsg(nQueryID, EncodeMessage(MakeDefaultMsg(DB_DELHERORCD, nSessionID, 0, 0, 0)) + EncodeString(sAccount + '/' + sCharName));
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sDefMsg, sStr, g_Config.dwGetDBSockMsgTime, d_LoadHeroData) then begin
    //MainOutMessage('DeleteHeroRcd nRecog:'+IntToStr(nRecog));
    nStatus := nRecog;
    if (nIdent = DBR_DELHERORCD) and (nRecog = 1) then begin
      Result := True;
    end;
  end;
  Inc(g_Config.nSaveDBCount);
end;

function CreateHeroRcd(sAccount, sCharName, sHeroName, sMsg: string; nSessionID: Integer; var nStatus: Integer): Boolean;
var
  DefMsg: TDefaultMessage;
  nQueryID: Integer;
  nIdent: Integer;
  nRecog: Integer;
  sHumanRcdStr: string;
  sDBMsg: string;
  sDefMsg: string;
begin
  nQueryID := GetQueryID(@g_Config);
  DefMsg := MakeDefaultMsg(DB_NEWHERORCD, 0, 0, 0, 0);
  n4EBB68 := 100;
  nStatus := 0;
  SendDBSockMsg(nQueryID, EncodeMessage(MakeDefaultMsg(DB_NEWHERORCD, nSessionID, 0, 0, 0)) + EncodeString(sAccount + '/' + sCharName + '/' + sHeroName + sMsg));
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sDefMsg, sHumanRcdStr, g_Config.dwGetDBSockMsgTime {5000}, d_LoadHeroData) then begin
    //MainOutMessage('CreateHeroRcd nRecog:'+IntToStr(nRecog));
    Result := False;
    nStatus := nRecog;
    if nIdent = DBR_NEWHERORCD then begin
      if nRecog = 1 then begin
        Result := True;
      end else Result := False;
    end else Result := False;
  end else Result := False;
end;

function SaveHeroRcd(sAccount, sCharName: string; nSessionID: Integer; var HumanRcd: THumDataInfo): Boolean;
var
  nQueryID: Integer;
  nIdent: Integer;
  nRecog: Integer;
  sStr: string;
  sDefMsg: string;
begin
  nQueryID := GetQueryID(@g_Config);
  Result := False;
  n4EBB68 := 101;
  SendDBSockMsg(nQueryID, EncodeMessage(MakeDefaultMsg(DB_SAVEHERORCD, nSessionID, 0, 0, 0)) + EncodeString(sAccount) + '/' + EncodeString(sCharName) + '/' + EncodeBuffer(@HumanRcd, SizeOf(THumDataInfo)));
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sDefMsg, sStr, g_Config.dwGetDBSockMsgTime {5000}, d_SaveHeroData) then begin
    if (nIdent = DBR_SAVEHERORCD) and (nRecog = 1) then
      Result := True;
  end;
end;

function LoadHeroRcd(sAccount, sCharName, sStr: string; nCertCode: Integer; var HumanRcd: THumDataInfo): Boolean;
var
  DefMsg: TDefaultMessage;
  LoadHuman: TLoadHuman;
  nQueryID: Integer;
  nIdent, nRecog: Integer;
  sHumanRcdStr: string;
  sDBMsg, sDBCharName: string;
  sDefMsg: string;
begin
  nQueryID := GetQueryID(@g_Config);
  DefMsg := MakeDefaultMsg(DB_LOADHERORCD, 0, 0, 0, 0);
  LoadHuman.sAccount := sAccount;
  LoadHuman.sChrName := sCharName;
  LoadHuman.sUserAddr := sStr;
  LoadHuman.nSessionID := nCertCode;
  sDBMsg := EncodeMessage(DefMsg) + EncodeBuffer(@LoadHuman, SizeOf(TLoadHuman));
  n4EBB68 := 100;

  SendDBSockMsg(nQueryID, sDBMsg);

  if GetDBSockMsg(nQueryID, nIdent, nRecog, sDefMsg, sHumanRcdStr, g_Config.dwGetDBSockMsgTime {5000}, d_LoadHeroData) then begin
    Result := False;
    if nIdent = DBR_LOADHERORCD then begin
      if nRecog = 1 then begin
        sHumanRcdStr := GetValidStr3(sHumanRcdStr, sDBMsg, ['/']);
        sDBCharName := DeCodeString(sDBMsg);
        if sDBCharName = sCharName then begin
          if GetCodeMsgSize(SizeOf(THumDataInfo) * 4 / 3) = Length(sHumanRcdStr) then begin
            DecodeBuffer(sHumanRcdStr, @HumanRcd, SizeOf(THumDataInfo));
            Result := HumanRcd.Data.boIsHero;
          end;
        end else Result := False;
      end else Result := False;
    end else
      if nIdent = DBR_NOTCREATEHERO then begin //没有创建英雄
      HumanRcd.Data.sChrName := '';
      Result := True;
    end else Result := False;
  end else Result := False;
end;

function SaveRcd(sAccount, sCharName: string; nSessionID: Integer; var HumanRcd: THumDataInfo): Boolean; //004B42C8
var
  nQueryID: Integer;
  nIdent: Integer;
  nRecog: Integer;
  sStr: string;
  sDefMsg: string;
begin
  nQueryID := GetQueryID(@g_Config);
  Result := False;
  n4EBB68 := 101;
  SendDBSockMsg(nQueryID, EncodeMessage(MakeDefaultMsg(DB_SAVEHUMANRCD, nSessionID, 0, 0, 0)) + EncodeString(sAccount) + '/' + EncodeString(sCharName) + '/' + EncodeBuffer(@HumanRcd, SizeOf(THumDataInfo)));
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sDefMsg, sStr, g_Config.dwGetDBSockMsgTime {5000}, d_SaveHumData) then begin
    if (nIdent = DBR_SAVEHUMANRCD) and (nRecog = 1) then
      Result := True;
  end;
end;

function LoadRcd(sAccount, sCharName, sStr: string; nCertCode: Integer; var HumanRcd: THumDataInfo): Boolean;
var
  DefMsg: TDefaultMessage;
  LoadHuman: TLoadHuman;
  nQueryID: Integer;
  nIdent, nRecog: Integer;
  sHumanRcdStr: string;
  sDBMsg, sDBCharName: string;
  sDefMsg: string;
begin
  nQueryID := GetQueryID(@g_Config);
  DefMsg := MakeDefaultMsg(DB_LOADHUMANRCD, 0, 0, 0, 0);
  LoadHuman.sAccount := sAccount;
  LoadHuman.sChrName := sCharName;
  LoadHuman.sUserAddr := sStr;
  LoadHuman.nSessionID := nCertCode;
  sDBMsg := EncodeMessage(DefMsg) + EncodeBuffer(@LoadHuman, SizeOf(TLoadHuman));
  n4EBB68 := 100;

  SendDBSockMsg(nQueryID, sDBMsg);

  if GetDBSockMsg(nQueryID, nIdent, nRecog, sDefMsg, sHumanRcdStr, g_Config.dwGetDBSockMsgTime {5000}, d_LoadHumData) then begin
    Result := False;
    if nIdent = DBR_LOADHUMANRCD then begin
      if nRecog = 1 then begin

        sHumanRcdStr := GetValidStr3(sHumanRcdStr, sDBMsg, ['/']);
        sDBCharName := DeCodeString(sDBMsg);
        if sDBCharName = sCharName then begin
          if GetCodeMsgSize(SizeOf(THumDataInfo) * 4 / 3) = Length(sHumanRcdStr) then begin
            DecodeBuffer(sHumanRcdStr, @HumanRcd, SizeOf(THumDataInfo));
            Result := not HumanRcd.Data.boIsHero;
          end;
        end else Result := False;
      end else Result := False;
    end else Result := False;
  end else Result := False;
end;

function LoadRanking(nTabelPage, nTabelType, nPage: Integer; sHumanName: string; Msg: pTDefaultMessage; var sRankingStr: string): Boolean;
var
  DefMsg: TDefaultMessage;
  nQueryID: Integer;
  nIdent, nRecog: Integer;
  sDBMsg, sDBCharName: string;
  sDefMsg: string;
begin
  nQueryID := GetQueryID(@g_Config);
  DefMsg := MakeDefaultMsg(DB_LOADRANKING, nPage, nTabelPage, nTabelType, 0);

  sDBMsg := EncodeMessage(DefMsg) + EncodeString(sHumanName);
  n4EBB68 := 100;

  SendDBSockMsg(nQueryID, sDBMsg);

  if GetDBSockMsg(nQueryID, nIdent, nRecog, sDefMsg, sRankingStr, g_Config.dwGetDBSockMsgTime {5000}, d_LoadRankingData) then begin
    Result := False;
    if nIdent = DBR_LOADRANKING then begin
      DefMsg := DecodeMessage(sDefMsg);
      Msg^ := DefMsg;
      Result := True;

    end else Result := False;
  end else Result := False;
end;

procedure SendDBSockMsg(nQueryID: Integer; sMsg: string);
var
  sSENDMSG: string;
  nCheckCode: Integer;
  sCheckStr: string;
  boSendData: Boolean;
  Config: pTConfig;
begin
{$IF DBSOCKETMODE = TIMERENGINE}
  Config := @g_Config;
  if not DBSocketConnected then Exit;
  EnterCriticalSection(UserDBSection);
  try
    Config.sDBSocketRecvText := '';
  finally
    LeaveCriticalSection(UserDBSection);
  end;
  nCheckCode := MakeLong(nQueryID xor 170, Length(sMsg) + 6);
  sCheckStr := EncodeBuffer(@nCheckCode, SizeOf(Integer));
  sSENDMSG := '#' + IntToStr(nQueryID) + '/' + sMsg + sCheckStr + '!';
  Config.boDBSocketWorking := True;
  FrmMain.DBSocket.Socket.SendText(sSENDMSG);
{$ELSE}
  DataEngine.SendDBSockMsg(nQueryID, sMsg);
{$IFEND}
end;

function GetQueryID(Config: pTConfig): Integer;
begin
  Inc(Config.nDBQueryID);
  if Config.nDBQueryID > High(SmallInt) - 1 then Config.nDBQueryID := 1;
  Result := Config.nDBQueryID;
end;

end.

