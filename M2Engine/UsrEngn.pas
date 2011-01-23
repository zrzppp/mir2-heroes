unit UsrEngn;

interface
uses
  Windows, Classes, SysUtils, StrUtils, Controls, Forms, ObjBase, ObjActor, ObjHero, ObjNpc, Envir, Grobal2, SDK;
type
  TMonGenInfo = record
    sMapName: string[14];
    nRace: Integer;
    nRange: Integer;
    nMissionGenRate: Integer;
    dwStartTick: LongWord;
    nX: Integer;
    nY: Integer;
    sMonName: string[14];
    nAreaX: Integer;
    nAreaY: Integer;
    nCount: Integer;
    dwZenTime: LongWord;
    dwStartTime: LongWord;
    nChangeColorType: Integer; //2007-02- 01 增加  0自动变色 >0改变颜色 -1不改变
    CertList: TList;
    Envir: TEnvirnoment;
    //TList_3C: TList;
  end;
  pTMonGenInfo = ^TMonGenInfo;

  TMapMonGenCount = record
    sMapName: string[14];
    nMonGenCount: Integer;
    dwNotHumTimeTick: LongWord;
    nClearCount: Integer;
    boNotHum: Boolean;
    dwMakeMonGenTimeTick: LongWord;
    nMonGenRate: Integer; //刷怪倍数  10
    dwRegenMonstersTime: LongWord; //刷怪速度    200
  end;
  pTMapMonGenCount = ^TMapMonGenCount;

  TAILogon = record
    sCharName: string[14];
    sMapName: string[14];
    sConfigFileName: string;
    sHeroConfigFileName: string;
    sFilePath: string;
    sConfigListFileName: string;
    nX: Integer;
    nY: Integer;
  end;
  pTAILogon = ^TAILogon;

  TObjectItem = record
    FString: string[ACTORNAMELEN];
    FObject: TPlayObject;
  end;
  pTObjectItem = ^TObjectItem;

  TPlayObjectList = class(TStringList)

  private
    FMaxCount: Integer;

    function GetMaxCount: Integer;
    procedure SetMaxCount(Value: Integer);
  public
    function AddObject(const S: string; AObject: TObject): Integer; override;
    property MaxCount: Integer read GetMaxCount write SetMaxCount;
  end;

  {TPlayObjectList = class
  private
    FList: array of TObjectItem;
    FCount: Integer;
    function GetPlayObject(Index: Integer): TPlayObject;
    procedure SetPlayObject(Index: Integer; Value: TPlayObject);
    function GetString(Index: Integer): string;
    procedure SetString(Index: Integer; Value: string);

    function Get(Index: Integer): string;
    function GetCount: Integer;
    function GetMaxCount: Integer;
    procedure SetMaxCount(Value: Integer);
  public
    constructor Create();
    destructor Destroy; override;
    function Add(const S: string): Integer;
    function AddObject(const S: string; PlayObject: TPlayObject): Integer;
    function Insert(Index: Integer; const S: string): Integer;
    function InsertObject(Index: Integer; const S: string; PlayObject: TPlayObject): Integer;
    function IndexOf(const S: string): Integer;
    procedure Delete(Index: Integer);
    procedure Clear;
    property Objects[Index: Integer]: TPlayObject read GetPlayObject write SetPlayObject;
    property Strings[Index: Integer]: string read GetString write SetString;
    property MaxCount: Integer read GetMaxCount write SetMaxCount;
    property Count: Integer read GetCount;
  end;}

  TUserEngine = class
    m_LoadPlaySection: TRTLCriticalSection;
    m_LoadHeroSection: TRTLCriticalSection;
    m_LoadPlayList: TStringList; //从DB读取人物数据
    m_PlayObjectList: TStringList; //TPlayObjectList; //TStringList; //0x8
    m_UserLogonList: TGStringList;
    m_StringList_0C: TStringList;
    m_PlayObjectFreeList: TList; //0x10
    m_ChangeHumanDBGoldList: TList; //0x14
    dwShowOnlineTick: LongWord; //0x18
    dwSendOnlineHumTime: LongWord; //0x1C
    dwProcessMapDoorTick: LongWord; //0x20
    dwProcessMissionsTime: LongWord; //0x24
    dwRegenMonstersTick: LongWord; //0x28
    CalceTime: LongWord; //0x2C
    m_dwProcessLoadPlayTick: LongWord; //0x30
    dwTime_34: LongWord; //0x34
    m_nCurrMonGen: Integer; //0x38
    m_nMapCurrMonGen: Integer; //0x38
    m_nMonGenListPosition: Integer; //0x3C
    m_nMapListPosition: Integer; //0x3C
    m_nMonGenCertListPosition: Integer; //0x40
    m_nProcHumIDx: Integer; //0x44 处理人物开始索引（每次处理人物数限制）
    m_nProcHeroIDx: Integer;
    nProcessHumanLoopTime: Integer;
    nMerchantPosition: Integer; //0x4C
    nNpcPosition: Integer; //0x50
    StdItemList: TList; //List_54
    MonsterList: TList; //List_58
    m_MonGenList: TList; //List_5C
    m_MonFreeList: TList;
    m_MagicList: TList; //List_60

    m_AdminList: TGList; //List_64
    m_MerchantList: TGList; //List_68
    QuestNPCList: TList; //0x6C
    List_70: TList;
    m_ChangeServerList: TList;
    m_MagicEventList: TList;

    nMonsterCount: Integer; //怪物总数
    nMonsterProcessPostion: Integer; //0x80处理怪物总数位置，用于计算怪物总数
    n84: Integer;
    nMonsterProcessCount: Integer; //0x88处理怪物数，用于统计处理怪物个数
    boItemEvent: Boolean; //ItemEvent
    n90: Integer;
    dwProcessMonstersTick: LongWord;
    dwProcessMerchantTimeMin: Integer;
    dwProcessMerchantTimeMax: Integer;
    dwProcessNpcTimeMin: LongWord;
    dwProcessNpcTimeMax: LongWord;

    m_NewHumanList: TList;
    m_ListOfGateIdx: TList;
    m_ListOfSocket: TList;
    OldMagicList: TList;

    m_boStartLoadMagic: Boolean;
    m_dwSearchTick: LongWord;

    m_TodayDate: TDate;

    m_dwSayMyInfoTick: LongWord;
    m_dwCheckTick: LongWord;

    m_HeroObjectList: TGStringList; //英雄LIST
    m_LoadHeroList: TStringList; //从DB读取人物数据
    m_HeroObjectFreeList: TList; //0x10

    m_dwProcessLoadHeroTick: LongWord;
    nHeroPosition: Integer;
    dwProcessHeroTimeMin: Integer;
    dwProcessHeroTimeMax: Integer;

    m_dwAILogonTick: LongWord;
  private
    procedure ProcessHumans();
    procedure ProcessHeros();
    procedure ProcessMonsters();
    procedure ProcessMerchants();
    procedure ProcessNpcs();

    procedure ProcessEvents();
    procedure ProcessMapDoor();
    procedure NPCinitialize;
    procedure MerchantInitialize;
    function MonGetRandomItems(mon: TActorObject): Integer;
    function RegenMonsters(MonGen: pTMonGenInfo; nCount: Integer): Boolean;
    function AddBaseObject(BaseObject: TActorObject; sMapName: string; nX, nY: Integer; nMonRace: Integer; sMonName: string): TActorObject;
    function AddAIPlayObject(AI: pTAILogon): TAIPlayObject;
    function GetGenMonCount(MonGen: pTMonGenInfo): Integer;

    procedure KickOnlineUser(sChrName: string);

    procedure AddToHumanFreeList(PlayObject: TPlayObject);
    procedure AddToHeroFreeList(HeroObject: THeroObject);
    procedure GetHumData(PlayObject: TPlayObject; var HumanRcd: THumDataInfo);
    procedure GetHeroData(HeroObject: THeroObject; var HumanRcd: THumDataInfo);

    function GetHomeInfo(var nX: Integer; var nY: Integer): string;
    function GetRandHomeX(PlayObject: TPlayObject): Integer;
    function GetRandHomeY(PlayObject: TPlayObject): Integer;

    procedure MonInitialize(BaseObject: TActorObject; sMonName: string);
    function MapRageHuman(sMapName: string; nMapX, nMapY, nRage: Integer): Boolean;
    function GetOnlineHumCount(): Integer;
    function GetUserCount(): Integer;
    function GetLoadPlayCount(): Integer;
    function GetAutoAddExpPlayCount: Integer;
  public
    constructor Create();
    destructor Destroy; override;

    procedure Run();
    procedure Execute;

    procedure Initialize();
    procedure ClearItemList(); virtual;
    procedure SwitchMagicList();
    procedure PrcocessData();

    function FindAILogon(sCharName: string): Boolean;
    //procedure AddAILogon(sMapName, sCharName: string; nX, nY: Integer); overload;
    procedure AddAILogon(aAI: pTAILogon); overload;
    procedure DelAILogon(sCharName: string);
    //function RegenAIObject(sCharName: string): Boolean; overload;
    //function RegenAIObject(sMapName, sCharName: string; nX, nY: Integer): Boolean; overload;
    function RegenAIObject(AI: pTAILogon): Boolean; //overload;


    function RegenMonsterByName(PlayObject: TActorObject; sMAP: string; nX, nY: Integer; sMonName: string): TActorObject; overload;
    function RegenMonsterByName(PlayObject: TActorObject; sMAP: string; nX, nY: Integer; nMonRace: Integer; sMonName: string): TActorObject; overload;

    procedure SaveHumanRcd(PlayObject: TPlayObject);
    procedure SaveHeroRcd(HeroObject: THeroObject);

    function GetStdItem(nIdx: Integer): pTStdItem; overload;
    function GetStdItem(sItemName: string): pTStdItem; overload;
    function GetStdItemWeight(nItemIdx: Integer): Integer;
    function GetStdItemName(nItemIdx: Integer): string;
    function GetStdItemIdx(sItemName: string): Integer;

    procedure CryCry(wIdent: Word; pMap: TEnvirnoment; nX, nY, nWide: Integer; btFColor, btBColor: Byte; sMsg: string); overload;
    procedure CryCry(wIdent: Word; pMap: TEnvirnoment; nX, nY, nWide: Integer; btFColor, btBColor: Byte; sMsg: string; boSend: Boolean); overload;
    function GetSayCount(pMap: TEnvirnoment; nX, nY, nWide: Integer): Integer;

    procedure ProcessUserMessage(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; Buff: PChar);
    //procedure SendServerGroupMsg(nCode, nServerIdx: Integer; sMsg: string);
    function GetMonRace(sMonName: string): Integer;

    function GetHeroObject(sName: string): THeroObject;

    function GetPlayObject(sName: string): TPlayObject; overload;
    function GetPlayObject(PlayObject: TActorObject): TPlayObject; overload;
    function GetPlayObjectEx(sAccount, sName: string): TPlayObject;
    function GetPlayObjectExOfAutoGetExp(sAccount: string): TPlayObject;
    procedure KickPlayObjectEx(sAccount, sName: string);
    function FindMerchant(Merchant: TObject): TMerchant;
    function FindNPC(GuildOfficial: TObject): TGuildOfficial;
    function CopyToUserItemFromName(sItemName: string; Item: pTUserItem): Boolean;
    function GetMapOfRangeHumanCount(Envir: TEnvirnoment; nX, nY, nRange: Integer): Integer;
    function GetHumPermission(sUserName: string; var sIPaddr: string; var btPermission: Byte): Boolean;
    procedure AddUserOpenInfo(UserOpenInfo: pTUserOpenInfo);
    procedure AddHeroOpenInfo(UserOpenInfo: pTUserOpenInfo);
    function FindHeroOpenInfo(sChrName: string): Boolean;

    procedure RandomUpgradeItem(Item: pTUserItem);
    procedure GetUnknowItemValue(Item: pTUserItem);

    procedure _RandomItemLimitDay(Item: pTUserItem; nRate: Integer);
    function _AllowUpgradeItem(Item: pTUserItem): Boolean;
    procedure _RandomUpgradeItem(Item: pTUserItem);
    procedure _GetUnknowItemValue(Item: pTUserItem);

    procedure RandomUpgradeItem_(Item: pTUserItem; nValue: Integer; btMethod: Byte);
    procedure GetUnknowItemValue_(Item: pTUserItem; nValue: Integer; btMethod: Byte);

    procedure RandomItemAddPoint(Item: pTUserItem);

    function OpenDoor(Envir: TEnvirnoment; nX, nY: Integer): Boolean;
    function CloseDoor(Envir: TEnvirnoment; Door: TDoorObject): Boolean;
    procedure SendDoorStatus(Envir: TEnvirnoment; nX, nY: Integer; wIdent, wX: Word; nDoorX, nDoorY, nA: Integer; sStr: string);
    function FindMagic(sMagicName: string): pTMagic; overload;
    function FindMagic(nMagIdx: Integer): pTMagic; overload;

    function FindHeroMagic(sMagicName: string): pTMagic; overload;
    function FindHeroMagic(nMagIdx: Integer): pTMagic; overload;

    function GetMagicName(nMagIdx: Integer): string;
    function AddMagic(Magic: pTMagic): Boolean;
    function DelMagic(wMagicId: Word): Boolean;
    procedure AddMerchant(Merchant: TMerchant);
    function GetMerchantList(Envir: TEnvirnoment; nX, nY, nRange: Integer; TmpList: TList): Integer;
    function GetNpcList(Envir: TEnvirnoment; nX, nY, nRange: Integer; TmpList: TList): Integer;
    procedure ReloadMerchantList();
    procedure ReloadNpcList();
    procedure HumanExpire(sAccount: string);
    function GetMapMonster(Envir: TEnvirnoment; List: TList): Integer;
    function GetMonsterByName(sMonName: string; List: TList): Integer;
    function GetMapRangeMonster(Envir: TEnvirnoment; nX, nY, nRange: Integer; List: TList): Integer;
    function GetMapHuman(sMapName: string): Integer; overload;
    function GetMapHuman(Envir: TEnvirnoment): Integer; overload;
    function GetMapRageHuman(Envir: TEnvirnoment; nRageX, nRageY, nRage: Integer; List: TList): Integer;
    procedure SendBroadCastMsg(sMsg: string; MsgType: TMsgType); overload;
    procedure SendBroadCastMsg(sMsg: string; btFColor, btBColor: Byte; MsgType: TMsgType); overload;
    procedure SendBroadCastMsgExt(sMsg: string; MsgType: TMsgType);
    procedure SendMoveMsg(sMsg: string; btFColor, btBColor: Byte; nMoveCount: Integer);
    procedure SendCenterMsg(sMsg: string; btFColor, btBColor: Byte; nTime: Integer);
    procedure sub_4AE514(GoldChangeInfo: pTGoldChangeInfo);
    procedure ClearMonSayMsg();
    procedure SendQuestMsg(sQuestName: string);
    procedure ClearMerchantData();

    function GetOnlineCount: string;
    procedure AddIPToGateBlockList(sUserIpddr: string);
    procedure RefServerConfig();

    property MonsterCount: Integer read nMonsterCount;
    property OnlinePlayObject: Integer read GetOnlineHumCount;
    property PlayObjectCount: Integer read GetUserCount;
    property AutoAddExpPlayCount: Integer read GetAutoAddExpPlayCount;
    property LoadPlayCount: Integer read GetLoadPlayCount;
  end;
var
  g_dwEngineTick: LongWord;
  g_dwEngineRunTime: LongWord;

implementation

uses IdSrvClient, Guild, ObjMon, EncryptUnit, ObjGuard, ObjAxeMon, M2Share,
  ObjMon2, Event, ObjRobot, HUtil32, svMain,
  Castle, PlugIn, Common;
//var
  //nUserEngineRun: Integer = -1;

function TPlayObjectList.GetMaxCount: Integer;
begin
  Result := FMaxCount;
end;

procedure TPlayObjectList.SetMaxCount(Value: Integer);
begin
  FMaxCount := Value;
end;

function TPlayObjectList.AddObject(const S: string; AObject: TObject): Integer;
begin
  if Count >= FMaxCount then Exit;
  if not Sorted then
    Result := Count
  else
    if Find(S, Result) then
    case Duplicates of
      dupIgnore: Exit;
      dupError: Exit; // Error(@SDuplicateString, 0);
    end;
  InsertItem(Result, S, AObject);
end;

(*constructor TPlayObjectList.Create();
begin
   // FList: array of TUserItem;
  FCount := 0;
  //SetLength(FList, 0);
end;

destructor TPlayObjectList.Destroy;
begin
  FCount := 0;
  //SetLength(FList, 0);
  FList := nil;
  inherited;
end;

function TPlayObjectList.Add(const S: string): Integer;
begin
  Result := AddObject(S, nil);
end;

function TPlayObjectList.AddObject(const S: string; PlayObject: TPlayObject): Integer;
var
  Index: Integer;
begin
 { if FCount < Length(FList) then begin
    FList[FCount].FString := S;
    FList[FCount].FObject := PlayObject;
    Result := FCount;
    Inc(FCount);
  end;  }
  //Result := InsertObject(FCount, S, PlayObject);
  {if FCount <= 0 then
    Result := InsertObject(0, S, PlayObject)
  else
    Result := InsertObject(FCount - 1, S, PlayObject);}
  Result := InsertObject(FCount, S, PlayObject);
end;

function TPlayObjectList.Insert(Index: Integer; const S: string): Integer;
begin
  //Result := InsertObject(Index, S, nil);
end;

function TPlayObjectList.InsertObject(Index: Integer;
  const S: string; PlayObject: TPlayObject): Integer;
var
  I: Integer;
begin
  Result := -1;
  if (Index < FCount) and (FCount < Length(FList) - 1) then begin
    for I := FCount - 1 downto Index do begin
      FList[I + 1] := FList[I];
    end;
      {if Index < FCount then
        System.Move(FList[Index], FList[Index + 1],
          (FCount - Index) * SizeOf(TStringItem));  }
  end;
  FList[Index].FString := S;
  FList[Index].FObject := PlayObject;
  Result := FCount;
  Inc(FCount);
end;

function TPlayObjectList.IndexOf(const S: string): Integer;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    if ComPareText(FList[I].FString, S) = 0 then begin
      Result := I;
      Exit;
    end;
  Result := -1;
end;

procedure TPlayObjectList.Delete(Index: Integer);
{
begin
  if (Index < 0) or (Index >= FCount) then Exit;
  FList[Index].FString := '';
  FList[Index].FObject := nil;
  //Finalize(FList[Index]);
  Dec(FCount);
  if Index < FCount then
    System.Move(FList[Index + 1], FList[Index],
      (FCount - Index) * SizeOf(TObjectItem));
end;
}
var
  I: Integer;
begin
  if (FCount > 0) and (Index >= 0) and (Index < FCount) then begin
    FList[Index].FString := '';
    FList[Index].FObject := nil;
    Dec(FCount);
    if Index < FCount then
      for I := Index to FCount - 1 do
        FList[I] := FList[I + 1];
  end;
end;

procedure TPlayObjectList.Clear;
var
  I: Integer;
begin
  if (FCount > 0) then begin
    for I := 0 to FCount - 1 do begin
      FList[I].FString := '';
      FList[I].FObject := nil;
    end;
  end;
  FCount := 0;
end;

function TPlayObjectList.GetPlayObject(Index: Integer): TPlayObject;
begin
  if (Index >= 0) and (Index < FCount) then
    Result := FList[Index].FObject else Result := nil;
end;

procedure TPlayObjectList.SetPlayObject(Index: Integer; Value: TPlayObject);
begin
  if (Index >= 0) and (Index < FCount) then FList[Index].FObject := Value;
end;

function TPlayObjectList.GetString(Index: Integer): string;
begin
  if (Index >= 0) and (Index < FCount) then
    Result := FList[Index].FString else Result := '';
end;

procedure TPlayObjectList.SetString(Index: Integer; Value: string);
begin
  if (Index >= 0) and (Index < FCount) then FList[Index].FString := Value;
end;

function TPlayObjectList.Get(Index: Integer): string;
begin

end;

function TPlayObjectList.GetCount: Integer;
begin
  Result := FCount;
end;

function TPlayObjectList.GetMaxCount: Integer;
begin
  Result := Length(FList);
end;

procedure TPlayObjectList.SetMaxCount(Value: Integer);
begin
  if Value <> Length(FList) then begin
    SetLength(FList, Value);
    if Value < FCount then FCount := Value;
  end;
end;  *)

{===================================TUserEngine================================}

constructor TUserEngine.Create();
begin
  InitializeCriticalSection(m_LoadHeroSection);
  InitializeCriticalSection(m_LoadPlaySection);
  m_LoadPlayList := TStringList.Create;
  m_PlayObjectList := TStringList.Create; //TStringList.Create;
  m_StringList_0C := TStringList.Create;
  m_UserLogonList := TGStringList.Create;
  m_PlayObjectFreeList := TList.Create;
  m_ChangeHumanDBGoldList := TList.Create;
  dwShowOnlineTick := GetTickCount;
  dwSendOnlineHumTime := GetTickCount;
  dwProcessMapDoorTick := GetTickCount;
  dwProcessMissionsTime := GetTickCount;
  dwProcessMonstersTick := GetTickCount;
  dwRegenMonstersTick := GetTickCount;
  m_dwProcessLoadPlayTick := GetTickCount;
  dwTime_34 := GetTickCount;

  nMonsterProcessPostion := 0;
  m_nCurrMonGen := 0;
  m_nMapCurrMonGen := 0;
  m_nMonGenListPosition := 0;
  m_nMapListPosition := 0;
  m_nMonGenCertListPosition := 0;
  m_nProcHumIDx := 0;
  m_nProcHeroIDx := 0;
  nProcessHumanLoopTime := 0;
  nMerchantPosition := 0;
  nNpcPosition := 0;
  nMonsterCount := 0;
  StdItemList := TList.Create; //List_54
  MonsterList := TList.Create;
  m_MonGenList := TList.Create;
  //m_MonFreeList := TList.Create;
  m_MagicList := TList.Create;
  m_AdminList := TGList.Create;
  m_MerchantList := TGList.Create;
  QuestNPCList := TList.Create;
  List_70 := TList.Create;
  m_ChangeServerList := TList.Create;
  m_MagicEventList := TList.Create;

  boItemEvent := False;
  n90 := 1800000;
  dwProcessMerchantTimeMin := 0;
  dwProcessMerchantTimeMax := 0;
  dwProcessNpcTimeMin := 0;
  dwProcessNpcTimeMax := 0;
  m_NewHumanList := TList.Create;
  m_ListOfGateIdx := TList.Create;
  m_ListOfSocket := TList.Create;
  OldMagicList := TList.Create;
  m_boStartLoadMagic := False;
  m_dwSearchTick := GetTickCount;

  m_TodayDate := Date;
  m_dwSayMyInfoTick := GetTickCount;


  m_dwCheckTick := GetTickCount;

  m_dwAILogonTick := GetTickCount;

  nHeroPosition := 0;
  dwProcessHeroTimeMin := 0;
  dwProcessHeroTimeMax := 0;
  m_HeroObjectList := TGStringList.Create;
  m_LoadHeroList := TStringList.Create; //从DB读取人物数据
  m_HeroObjectFreeList := TList.Create;
end;

destructor TUserEngine.Destroy;
var
  I: Integer;
  II: Integer;
  MonInfo: pTMonInfo;
  MonGenInfo: pTMonGenInfo;
  MagicEvent: pTMagicEvent;
  TmpList: TList;
begin
  for I := 0 to m_LoadPlayList.Count - 1 do begin
    Dispose(pTUserOpenInfo(m_LoadPlayList.Objects[I]));
  end;
  m_LoadPlayList.Free;

  for I := 0 to m_PlayObjectList.Count - 1 do begin
    TPlayObject(m_PlayObjectList.Objects[I]).Free;
  end;
  m_PlayObjectList.Free;
  m_StringList_0C.Free;


  for I := 0 to m_PlayObjectFreeList.Count - 1 do begin
    TPlayObject(m_PlayObjectFreeList.Items[I]).Free;
  end;
  m_PlayObjectFreeList.Free;

  for I := 0 to m_UserLogonList.Count - 1 do begin
    Dispose(pTAILogon(m_UserLogonList.Objects[I]));
  end;
  m_UserLogonList.Free;

  for I := 0 to m_LoadHeroList.Count - 1 do begin
    Dispose(pTUserOpenInfo(m_LoadHeroList.Objects[I]));
  end;
  m_LoadHeroList.Free;
  for I := 0 to m_HeroObjectFreeList.Count - 1 do begin
    THeroObject(m_HeroObjectFreeList.Items[I]).Free;
  end;
  m_HeroObjectFreeList.Free;

  for I := 0 to m_HeroObjectList.Count - 1 do begin
    THeroObject(m_HeroObjectList.Objects[I]).Free;
  end;
  m_HeroObjectList.Free;

  for I := 0 to m_ChangeHumanDBGoldList.Count - 1 do begin
    Dispose(pTGoldChangeInfo(m_ChangeHumanDBGoldList.Items[I]));
  end;
  m_ChangeHumanDBGoldList.Free;

  for I := 0 to StdItemList.Count - 1 do begin
    Dispose(pTStdItem(StdItemList.Items[I]));
  end;
  StdItemList.Free;

  for I := 0 to MonsterList.Count - 1 do begin
    MonInfo := MonsterList.Items[I];
    if MonInfo.ItemList <> nil then begin
      for II := 0 to MonInfo.ItemList.Count - 1 do begin
        Dispose(pTMonItem(MonInfo.ItemList.Items[II]));
      end;
      MonInfo.ItemList.Free;
    end;
    Dispose(MonInfo);
  end;
  MonsterList.Free;

 { for I := 0 to m_MonFreeList.Count - 1 do begin
    TActorObject(m_MonFreeList.Items[I]).Free;
  end;
  m_MonFreeList.Free;   }

  for I := 0 to m_MagicList.Count - 1 do begin
    Dispose(pTMagic(m_MagicList.Items[I]));
  end;
  m_MagicList.Free;

  for I := 0 to m_AdminList.Count - 1 do begin
    Dispose(pTAdminInfo(m_AdminList.Items[I]));
  end;
  m_AdminList.Free;

  for I := 0 to m_MerchantList.Count - 1 do begin
    TMerchant(m_MerchantList.Items[I]).Free;
  end;
  m_MerchantList.Free;

  for I := 0 to QuestNPCList.Count - 1 do begin
    TNormNpc(QuestNPCList.Items[I]).Free;
  end;
  QuestNPCList.Free;
  List_70.Free;
  for I := 0 to m_ChangeServerList.Count - 1 do begin
    Dispose(pTSwitchDataInfo(m_ChangeServerList.Items[I]));
  end;
  m_ChangeServerList.Free;
  for I := 0 to m_MagicEventList.Count - 1 do begin
    MagicEvent := m_MagicEventList.Items[I];
    if MagicEvent.BaseObjectList <> nil then MagicEvent.BaseObjectList.Free;

    Dispose(MagicEvent);
  end;
  m_MagicEventList.Free;
  m_NewHumanList.Free;
  m_ListOfGateIdx.Free;
  m_ListOfSocket.Free;
  for I := 0 to OldMagicList.Count - 1 do begin
    TmpList := TList(OldMagicList.Items[I]);
    for II := 0 to TmpList.Count - 1 do begin
      Dispose(pTMagic(TmpList.Items[II]));
    end;
    TmpList.Free;
  end;

  for I := 0 to m_MonGenList.Count - 1 do begin
    MonGenInfo := m_MonGenList.Items[I];
    for II := 0 to MonGenInfo.CertList.Count - 1 do begin
      TActorObject(MonGenInfo.CertList.Items[II]).Free;
    end;
    MonGenInfo.CertList.Free;
    Dispose(pTMonGenInfo(m_MonGenList.Items[I]));
  end;
  m_MonGenList.Free;


  OldMagicList.Free;


  DeleteCriticalSection(m_LoadPlaySection);
  DeleteCriticalSection(m_LoadHeroSection);
  inherited;
end;

procedure TUserEngine.Initialize;
var
  I: Integer;
  MonGen: pTMonGenInfo;
begin
  MerchantInitialize();
  NPCinitialize();
  for I := 0 to m_MonGenList.Count - 1 do begin
    MonGen := m_MonGenList.Items[I];
    if MonGen <> nil then begin
      MonGen.nRace := GetMonRace(MonGen.sMonName);
    end;
  end;
end;

function TUserEngine.GetMonRace(sMonName: string): Integer;
var
  I: Integer;
  MonInfo: pTMonInfo;
begin
  Result := -1;
  for I := 0 to MonsterList.Count - 1 do begin
    MonInfo := MonsterList.Items[I];
    if MonInfo <> nil then begin
      if CompareText(MonInfo.sName, sMonName) = 0 then begin
        Result := MonInfo.btRace;
        Break;
      end;
    end;
  end;
end;

procedure TUserEngine.MerchantInitialize;
var
  I: Integer;
  Merchant: TMerchant;
  sCaption: string;
begin
  sCaption := FrmMain.Caption;
  m_MerchantList.Lock;
  try
    for I := m_MerchantList.Count - 1 downto 0 do begin
      Merchant := TMerchant(m_MerchantList.Items[I]);
      Merchant.m_PEnvir := g_MapManager.FindMap(Merchant.m_sMapName);
      if Merchant.m_PEnvir <> nil then begin
        Merchant.Initialize; //FFFE
        if Merchant.m_boAddtoMapSuccess and (not Merchant.m_boIsHide) then begin
          MainOutMessage('Merchant Initalize fail...' + Merchant.m_sCharName + ' ' + Merchant.m_sMapName + '(' + IntToStr(Merchant.m_nCurrX) + ':' + IntToStr(Merchant.m_nCurrY) + ')');
          m_MerchantList.Delete(I);
          Merchant.Free;
        end else begin
          Merchant.AddMapCount;
          Merchant.LoadNpcScript();
          Merchant.LoadNPCData();
        end;
      end else begin
        MainOutMessage(Merchant.m_sCharName + 'Merchant Initalize fail... (m.PEnvir=nil)');
        m_MerchantList.Delete(I);
        Merchant.Free;
      end;
      FrmMain.Caption := sCaption + ' [正在初始交易NPC(' + IntToStr(m_MerchantList.Count) + '/' + IntToStr(m_MerchantList.Count - I) + ')]';
        //Application.ProcessMessages;
    end;
  finally
    m_MerchantList.UnLock;
  end;
end;

procedure TUserEngine.NPCinitialize;
var
  I: Integer;
  NormNpc: TNormNpc;
begin
  for I := QuestNPCList.Count - 1 downto 0 do begin
    NormNpc := TNormNpc(QuestNPCList.Items[I]);
    NormNpc.m_PEnvir := g_MapManager.FindMap(NormNpc.m_sMapName);
    if NormNpc.m_PEnvir <> nil then begin
      NormNpc.Initialize;
      if NormNpc.m_boAddtoMapSuccess and (not NormNpc.m_boIsHide) then begin
        MainOutMessage(NormNpc.m_sCharName + ' Npc Initalize fail... ');
        QuestNPCList.Delete(I);
        NormNpc.Free;
      end else begin
        NormNpc.AddMapCount;
        NormNpc.LoadNpcScript();
      end;
    end else begin
      MainOutMessage(NormNpc.m_sCharName + ' Npc Initalize fail... (npc.PEnvir=nil) ');
      QuestNPCList.Delete(I);
      NormNpc.Free;
    end;
  end;
end;

function TUserEngine.GetLoadPlayCount: Integer;
begin
  Result := m_LoadPlayList.Count;
end;

function TUserEngine.GetOnlineHumCount: Integer;
begin
  Result := m_PlayObjectList.Count;
end;

function TUserEngine.GetUserCount: Integer;
begin
  Result := m_PlayObjectList.Count + m_StringList_0C.Count;
end;

function TUserEngine.GetAutoAddExpPlayCount: Integer;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  Result := 0;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if PlayObject.m_boNotOnlineAddExp {and (not PlayObject.m_boAI)} then Inc(Result);
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function CompareMemory(X1, X2: PByteArray; Size: Longint): boolean;
var
  I: longint;
begin
  Result := True;
  for I := 1 to Size do
    if X1^[I - 1] <> X2^[I - 1] then begin
      Result := False;
      Exit;
    end;
end;

procedure TUserEngine.ProcessHeros();
  function MakeNewHero(PlayObject: TPlayObject; UserOpenInfo: pTUserOpenInfo): THeroObject;
    function GetNextDirectionForDirection(btDirection: Byte): Byte;
    begin
      case btDirection of
        DR_UP: Result := DR_UPRIGHT;
        DR_DOWN: Result := DR_DOWNLEFT;
        DR_LEFT: Result := DR_UPLEFT;
        DR_RIGHT: Result := DR_DOWNRIGHT;
        DR_UPLEFT: Result := DR_UP;
        DR_UPRIGHT: Result := DR_RIGHT;
        DR_DOWNLEFT: Result := DR_LEFT;
        DR_DOWNRIGHT: Result := DR_DOWN;
      end;
    end;
  var
    HeroObject: THeroObject;
    p28: TBaseObject;
    Abil: pTAbility;
    n20, n24, n1C: Integer;
    I: Integer;
    bo10: Boolean;
    btDirection: Byte;
  begin
    Result := nil;
    HeroObject := nil;
    if PlayObject.m_MyHero <> nil then Exit;
    HeroObject := THeroObject.Create;
    HeroObject.m_boAI := PlayObject.m_boAI;
    HeroObject.m_nSessionID := PlayObject.m_nSessionID;

    if not HeroObject.m_boAI then begin
      GetHeroData(HeroObject, UserOpenInfo.HumanRcd);
    end else begin
      HeroObject.m_sCharName := PlayObject.m_sHeroCharName;
    end;

    if HeroObject.m_sMapName = '' then begin
      HeroObject.m_sHomeMap := PlayObject.m_sHomeMap;
      HeroObject.m_sMapName := PlayObject.m_sMapName;
      HeroObject.m_PEnvir := PlayObject.m_PEnvir;
      HeroObject.m_btStatus := 0;
      bo10 := False;
      n20 := 0;
      n24 := 0;
      PlayObject.GetBackPosition(n20, n24);
      if PlayObject.m_PEnvir.CanWalk(n20, n24, True) then begin
        bo10 := True;
        HeroObject.m_nCurrX := n20;
        HeroObject.m_nCurrY := n24;
      end;

      if not bo10 then begin
        btDirection := GetNextDirectionForDirection(PlayObject.m_btDirection);
        for I := 0 to 7 do begin
          PlayObject.GetBackPosition(btDirection, n20, n24);
          if PlayObject.m_PEnvir.CanWalk(n20, n24, True) then begin
            bo10 := True;
            HeroObject.m_nCurrX := n20;
            HeroObject.m_nCurrY := n24;
            Break;
          end;
          btDirection := GetNextDirectionForDirection(btDirection);
        end;

        if not bo10 then begin
          n1C := 0;
          while (True) do begin
            if PlayObject.m_PEnvir.CanWalk(HeroObject.m_nCurrX, HeroObject.m_nCurrY, True) then Break;
            HeroObject.m_nCurrX := HeroObject.m_nCurrX - 2 + Random(4);
            HeroObject.m_nCurrY := HeroObject.m_nCurrY - 2 + Random(4);
            Inc(n1C);
            if n1C >= 5 then Break;
          end;
        end;
      end;

      HeroObject.m_btDirection := Random(8);
      //if HeroObject.m_Abil.Level >= 0 then begin

      Abil := @HeroObject.m_Abil;
      Abil.Level := g_Config.nHeroStartLevel;
      Abil.AC := 0;
      Abil.MAC := 0;
      Abil.DC := MakeLong(1, 2);
      Abil.MC := MakeLong(1, 2);
      Abil.SC := MakeLong(1, 2);
      Abil.MP := 15;
      Abil.HP := 15;
      Abil.MaxHP := 15;
      Abil.MaxMP := 15;
      Abil.Exp := 10;
      Abil.MaxExp := 100;
      Abil.Weight := 100;
      Abil.MaxWeight := 100;

      HeroObject.m_boNewHuman := not HeroObject.m_boAI;
    end;

    if HeroObject.m_Abil.HP <= 0 then begin
      HeroObject.m_Abil.HP := 14;
      FillChar(HeroObject.m_wStatusTimeArr, SizeOf(TStatusTime), #0);
    end;

    if HeroObject.m_PEnvir = nil then begin
      //HeroObject.m_PEnvir := g_MapManager.FindMap(HeroObject.m_sMapName);
      //if HeroObject.m_PEnvir = nil then begin
      HeroObject.m_sHomeMap := PlayObject.m_sHomeMap;
      HeroObject.m_sMapName := PlayObject.m_sMapName;
      //end;
    end;
    HeroObject.m_PEnvir := PlayObject.m_PEnvir;


    bo10 := False;
    n20 := 0;
    n24 := 0;
    PlayObject.GetBackPosition(n20, n24);
    if PlayObject.m_PEnvir.CanWalk(n20, n24, True) then begin
      bo10 := True;
      HeroObject.m_nCurrX := n20;
      HeroObject.m_nCurrY := n24;
    end;

    if not bo10 then begin
      btDirection := GetNextDirectionForDirection(PlayObject.m_btDirection);
      for I := 0 to 7 do begin
        PlayObject.GetBackPosition(btDirection, n20, n24);
        if PlayObject.m_PEnvir.CanWalk(n20, n24, True) then begin
          bo10 := True;
          HeroObject.m_nCurrX := n20;
          HeroObject.m_nCurrY := n24;
          Break;
        end;
        btDirection := GetNextDirectionForDirection(btDirection);
      end;

      if not bo10 then begin
        n1C := 0;
        while (True) do begin
          if PlayObject.m_PEnvir.CanWalk(HeroObject.m_nCurrX, HeroObject.m_nCurrY, True) then Break;
          HeroObject.m_nCurrX := HeroObject.m_nCurrX - 2 + Random(4);
          HeroObject.m_nCurrY := HeroObject.m_nCurrY - 2 + Random(4);
          Inc(n1C);
          if n1C >= 5 then Break;
        end;
      end;
    end;

    HeroObject.m_WAbil := HeroObject.m_Abil;

    if PlayObject is TAIPlayObject then
      HeroObject.m_Master := PlayObject;

    HeroObject.Initialize();

    if HeroObject.m_boAddtoMapSuccess then begin
      p28 := nil;
      if HeroObject.m_PEnvir.m_nWidth < 50 then n20 := 2
      else n20 := 3;
      if (HeroObject.m_PEnvir.m_nHeight < 250) then begin
        if (HeroObject.m_PEnvir.m_nHeight < 30) then n24 := 2
        else n24 := 20;
      end else n24 := 50;

      n1C := 0;
      while (True) do begin
        if not HeroObject.m_PEnvir.CanWalk(HeroObject.m_nCurrX, HeroObject.m_nCurrY, False) then begin
          if (HeroObject.m_PEnvir.m_nWidth - n24 - 1) > HeroObject.m_nCurrX then begin
            Inc(HeroObject.m_nCurrX, n20);
          end else begin
            HeroObject.m_nCurrX := Random(HeroObject.m_PEnvir.m_nWidth div 2) + n24;
            if HeroObject.m_PEnvir.m_nHeight - n24 - 1 > HeroObject.m_nCurrY then begin
              Inc(HeroObject.m_nCurrY, n20);
            end else begin
              HeroObject.m_nCurrY := Random(HeroObject.m_PEnvir.m_nHeight div 2) + n24;
            end;
          end;
        end else begin
          p28 := HeroObject.m_PEnvir.AddToMap(HeroObject.m_nCurrX, HeroObject.m_nCurrY, HeroObject);
          Break;
        end;
        Inc(n1C);
        if n1C >= 31 then Break;
      end;
      if p28 = nil then begin
        FreeAndNil(HeroObject);
      end;
    end;

    Result := HeroObject;
  end;

  function IsLogined(sAccount, sChrName: string): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if FrontEngine.InSaveRcdList(sAccount, sChrName) then begin
      Result := True;
    end else begin
      for I := 0 to m_HeroObjectList.Count - 1 do begin
        if (CompareText(THeroObject(m_HeroObjectList.Objects[I]).m_sUserID, sAccount) = 0) and
          (CompareText(m_HeroObjectList.Strings[I], sChrName) = 0) then begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;
var
  dwRunTick, dwCurrTick: LongWord;
  nIdx, I: Integer;
  HeroObject: THeroObject;
  boProcessLimit: Boolean;
  UserOpenInfo: pTUserOpenInfo;
  PlayObject: TPlayObject;
resourcestring
  sExceptionMsg1 = '[Exception] TUserEngine::ProcessHeros -> Ready, Save, Load... Code:=%d';
  sExceptionMsg2 = '[Exception] TUserEngine::ProcessHeros';
begin
  if (GetTickCount - m_dwProcessLoadHeroTick) > 200 then begin
    m_dwProcessLoadHeroTick := GetTickCount();
    try
      EnterCriticalSection(m_LoadHeroSection);
      try
        for I := 0 to m_LoadHeroList.Count - 1 do begin
          UserOpenInfo := pTUserOpenInfo(m_LoadHeroList.Objects[I]);
          if not IsLogined(UserOpenInfo.sAccount, m_LoadHeroList.Strings[I]) then begin
            PlayObject := GetPlayObject(TActorObject(UserOpenInfo.LoadUser.PlayObject));
            if (PlayObject <> nil) and (not PlayObject.m_boGhost) then begin
              PlayObject.m_boWaitHeroDate := False;
              case UserOpenInfo.LoadUser.HeroData of
                l_Create: begin
                    case UserOpenInfo.nResult of
                      0: begin
                          PlayObject.m_sTempHeroName := '';
                          if g_FunctionNPC <> nil then begin
                            PlayObject.m_nScriptGotoCount := 0;
                            g_FunctionNPC.GotoLable(PlayObject, '@HeroNameFilter', False);
                          end;
                        end;
                      1: begin
                          PlayObject.m_sHeroCharName := PlayObject.m_sTempHeroName;
                          PlayObject.m_sTempHeroName := '';
                          if g_FunctionNPC <> nil then begin
                            PlayObject.m_nScriptGotoCount := 0;
                            g_FunctionNPC.GotoLable(PlayObject, '@CreateHeroOK', False);
                          end;
                        end;

                      2: begin
                          PlayObject.m_sTempHeroName := '';
                          if g_FunctionNPC <> nil then begin
                            PlayObject.m_nScriptGotoCount := 0;
                            g_FunctionNPC.GotoLable(PlayObject, '@HeroNameExists', False);
                          end;
                        end;

                      3: begin
                          PlayObject.m_sTempHeroName := '';
                          if g_FunctionNPC <> nil then begin
                            PlayObject.m_nScriptGotoCount := 0;
                            g_FunctionNPC.GotoLable(PlayObject, '@HeroOverChrCount', False);
                          end;
                        end;
                      4: begin
                          PlayObject.m_sTempHeroName := '';
                          if g_FunctionNPC <> nil then begin
                            PlayObject.m_nScriptGotoCount := 0;
                            g_FunctionNPC.GotoLable(PlayObject, '@CreateHeroFail', False);
                          end;
                        end;
                    else begin
                        PlayObject.m_sTempHeroName := '';
                        if g_FunctionNPC <> nil then begin
                          PlayObject.m_nScriptGotoCount := 0;
                          g_FunctionNPC.GotoLable(PlayObject, '@CreateHeroFailEx', False);
                        end;
                      end;
                    end;
                  end;
                l_Delete: begin
                    case UserOpenInfo.nResult of
                      0: begin
                          if UserOpenInfo.NPC <> nil then begin
                            PlayObject.m_nScriptGotoCount := 0;
                            TMerchant(UserOpenInfo.NPC).GotoLable(PlayObject, '@DeleteHeroFail', False);
                          end;
                        end;
                      1: begin
                          PlayObject.m_sHeroCharName := '';
                          if UserOpenInfo.NPC <> nil then begin
                            PlayObject.m_nScriptGotoCount := 0;
                            TMerchant(UserOpenInfo.NPC).GotoLable(PlayObject, '@DeleteHeroOK', False);
                          end;
                          if g_FunctionNPC <> nil then begin
                            PlayObject.m_nScriptGotoCount := 0;
                            g_FunctionNPC.GotoLable(PlayObject, '@DeleteHeroOK', False);
                          end;
                        end;
                    end;
                  end;
                l_Load: begin
                    case UserOpenInfo.nResult of
                      0: begin
                          {if g_FunctionNPC <> nil then begin
                            g_FunctionNPC.GotoLable(PlayObject, '@NotHaveHero', False);
                          end;  }
                        end;
                      1: begin //读取成功
                          HeroObject := MakeNewHero(PlayObject, UserOpenInfo);
                          if HeroObject <> nil then begin
                            PlayObject.m_MyHero := HeroObject;
                            HeroObject.m_Master := PlayObject;
                            HeroObject.m_sUserID := PlayObject.m_sUserID;
                            HeroObject.m_sMasterName := PlayObject.m_sCharName;
                            HeroObject.AddMapCount;
                            //MainOutMessage(HeroObject.m_sCharName + ' HeroObject.m_WAbil.Level0:' + IntToStr(HeroObject.m_WAbil.Level));
                            HeroObject.LogOn;
                            //MainOutMessage(HeroObject.m_sCharName + ' HeroObject.m_WAbil.Level1:' + IntToStr(HeroObject.m_WAbil.Level));
                            m_HeroObjectList.AddObject(m_LoadHeroList.Strings[I], HeroObject);
                          end;
                        end;
                    end;
                  end;
              end;
            end;
          end;
          Dispose(UserOpenInfo);
        end;
        m_LoadHeroList.Clear;
      finally
        LeaveCriticalSection(m_LoadHeroSection);
      end;
    except
      on E: Exception do begin
        MainOutMessage(Format(sExceptionMsg1, [0]));
        MainOutMessage(E.Message);
      end;
    end;
  end;

  try
    for I := 0 to m_HeroObjectFreeList.Count - 1 do begin
      HeroObject := THeroObject(m_HeroObjectFreeList.Items[I]);
      if (GetTickCount - HeroObject.m_dwGhostTick) > g_Config.dwHumanFreeDelayTime {5 * 60 * 1000} then begin
        try
          THeroObject(m_HeroObjectFreeList.Items[I]).Free;
        except
          on E: Exception do begin
            MainOutMessage(Format(sExceptionMsg1, [1]));
            MainOutMessage(E.Message);
          end;
        end;
        m_HeroObjectFreeList.Delete(I);
        Break;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format(sExceptionMsg1, [2]));
      MainOutMessage(E.Message);
    end;
  end;

  dwRunTick := GetTickCount();
  boProcessLimit := False;
  try
    dwCurrTick := GetTickCount();
    m_HeroObjectList.Lock;
    try
      nIdx := nHeroPosition;
      while True do begin
        if m_HeroObjectList.Count <= nIdx then Break;
        HeroObject := THeroObject(m_HeroObjectList.Objects[nIdx]);
        if not HeroObject.m_boGhost then begin
          if Integer(dwCurrTick - HeroObject.m_dwRunTick) > HeroObject.m_nRunTime then begin
            if (GetTickCount - HeroObject.m_dwSearchTick) > HeroObject.m_dwSearchTime then begin
              HeroObject.m_dwSearchTick := GetTickCount();
              HeroObject.SearchViewRange();
            end;
            if Integer(dwCurrTick - HeroObject.m_dwRunTick) > HeroObject.m_nRunTime then begin
              HeroObject.m_dwRunTick := dwCurrTick;
              HeroObject.Run;

              if not FrontEngine.IsFull and ((GetTickCount() - HeroObject.m_dwSaveRcdTick) > g_Config.dwSaveHumanRcdTime) then begin
                HeroObject.m_dwSaveRcdTick := GetTickCount();
                SaveHeroRcd(HeroObject);
              end;
            end;
          end;
        end else begin
          m_HeroObjectList.Delete(nIdx);
          AddToHeroFreeList(HeroObject);
          SaveHeroRcd(HeroObject);
          try
            if HeroObject.m_Master <> nil then begin
              if TPlayObject(HeroObject.m_Master).m_MyHero = HeroObject then
                TPlayObject(HeroObject.m_Master).m_MyHero := nil;
            end;
          except
            MainOutMessage(sExceptionMsg2 + ' Free');
          end;
          Continue;
        end;
        Inc(nIdx);
        if (GetTickCount - dwRunTick) > g_dwHeroLimit then begin
          nHeroPosition := nIdx;
          boProcessLimit := True;
          Break;
        end;
      end;
    finally
      m_HeroObjectList.UnLock;
    end;
    if not boProcessLimit then begin
      nHeroPosition := 0;
    end;
  except
    MainOutMessage(sExceptionMsg2);
  end;
  dwProcessHeroTimeMin := GetTickCount - dwRunTick;
  if dwProcessHeroTimeMin > dwProcessHeroTimeMax then dwProcessHeroTimeMax := dwProcessHeroTimeMin;
end;

procedure TUserEngine.ProcessHumans;
  function IsLogined(sAccount, sChrName: string): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if FrontEngine.InSaveRcdList(sAccount, sChrName) then begin
      Result := True;
    end else begin
      Result := GetPlayObjectEx(sAccount, sChrName) <> nil;
      {for I := 0 to m_PlayObjectList.Count - 1 do begin
        if (CompareText(TPlayObject(m_PlayObjectList.Objects[I]).m_sUserID, sAccount) = 0) and
          (CompareText(m_PlayObjectList.Strings[I], sChrName) = 0) then begin
          Result := True;
          Break;
        end;
      end;}
    end;
  end;

  function MakeNewHuman(UserOpenInfo: pTUserOpenInfo): TPlayObject;
  var
    PlayObject: TPlayObject;
    Abil: pTAbility;
    Envir: TEnvirnoment;
    nC: Integer;
    //SwitchDataInfo: pTSwitchDataInfo;
    Castle: TUserCastle;
  resourcestring
    sExceptionMsg = '[Exception] TUserEngine::MakeNewHuman';
    sChangeServerFail1 = 'chg-server-fail-1 [%d] -> [%d] [%s]';
    sChangeServerFail2 = 'chg-server-fail-2 [%d] -> [%d] [%s]';
    sChangeServerFail3 = 'chg-server-fail-3 [%d] -> [%d] [%s]';
    sChangeServerFail4 = 'chg-server-fail-4 [%d] -> [%d] [%s]';
    sErrorEnvirIsNil = '[Error] PlayObject.PEnvir = nil';
  label
    ReGetMap;
  begin
    Result := nil;
    try
      PlayObject := TPlayObject.Create;
      if not g_Config.boVentureServer then begin
        UserOpenInfo.sChrName := '';
        UserOpenInfo.LoadUser.nSessionID := 0;
        //SwitchDataInfo := GetSwitchData(UserOpenInfo.sChrName, UserOpenInfo.LoadUser.nSessionID);
      end; // else SwitchDataInfo := nil;

      //SwitchDataInfo := nil;

      //if SwitchDataInfo = nil then begin
      GetHumData(PlayObject, UserOpenInfo.HumanRcd);
      PlayObject.m_btRaceServer := RC_PLAYOBJECT;
      if PlayObject.m_sHomeMap = '' then begin
        ReGetMap:
        PlayObject.m_sHomeMap := GetHomeInfo(PlayObject.m_nHomeX, PlayObject.m_nHomeY);
        PlayObject.m_sMapName := PlayObject.m_sHomeMap;
        PlayObject.m_nCurrX := GetRandHomeX(PlayObject);
        PlayObject.m_nCurrY := GetRandHomeY(PlayObject);
        if PlayObject.m_Abil.Level >= 0 then begin
          Abil := @PlayObject.m_Abil;
          //if (not PlayObject.m_boAI) or (PlayObject.m_Abil.Level <= 1) then begin
          Abil.Level := 1;
          Abil.AC := 0;
          Abil.MAC := 0;
          Abil.DC := MakeLong(1, 2);
          Abil.MC := MakeLong(1, 2);
          Abil.SC := MakeLong(1, 2);
          Abil.MP := 15;
          Abil.HP := 15;
          Abil.MaxHP := 15;
          Abil.MaxMP := 15;
          Abil.Exp := 10;
          Abil.MaxExp := 100;
          Abil.Weight := 100;
          Abil.MaxWeight := 100;
          //end;
          PlayObject.m_boNewHuman := True;
        end;
      end;
      Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
      if Envir <> nil then begin
        if Envir.m_boFight3Zone then begin //是否在行会战争地图死亡
          if (PlayObject.m_Abil.HP <= 0) and (PlayObject.m_nFightZoneDieCount < 3) then begin
            PlayObject.m_Abil.HP := PlayObject.m_Abil.MaxHP;
            PlayObject.m_Abil.MP := PlayObject.m_Abil.MaxMP;
            PlayObject.m_boDieInFight3Zone := True;
          end else PlayObject.m_nFightZoneDieCount := 0;
        end;
      end;

      PlayObject.m_MyGuild := g_GuildManager.MemberOfGuild(PlayObject.m_sCharName);
      Castle := g_CastleManager.InCastleWarArea(Envir, PlayObject.m_nCurrX, PlayObject.m_nCurrY);
        {
        if (Envir <> nil) and ((UserCastle.m_MapPalace = Envir) or
          (UserCastle.m_boUnderWar and UserCastle.InCastleWarArea(PlayObject.m_PEnvir,PlayObject.m_nCurrX,PlayObject.m_nCurrY))) then begin
        }
      if (Envir <> nil) and (Castle <> nil) and ((Castle.m_MapPalace = Envir) or Castle.m_boUnderWar) then begin
        Castle := g_CastleManager.IsCastleMember(PlayObject);
          //if not UserCastle.IsMember(PlayObject) then begin
        if Castle = nil then begin
          PlayObject.m_sMapName := PlayObject.m_sHomeMap;
          PlayObject.m_nCurrX := PlayObject.m_nHomeX - 2 + Random(5);
          PlayObject.m_nCurrY := PlayObject.m_nHomeY - 2 + Random(5);
        end else begin
            {
            if UserCastle.m_MapPalace = Envir then begin
              PlayObject.m_sMapName:=UserCastle.GetMapName();
              PlayObject.m_nCurrX:=UserCastle.GetHomeX;
              PlayObject.m_nCurrY:=UserCastle.GetHomeY;
            end;
            }
          if Castle.m_MapPalace = Envir then begin
            PlayObject.m_sMapName := Castle.GetMapName();
            PlayObject.m_nCurrX := Castle.GetHomeX;
            PlayObject.m_nCurrY := Castle.GetHomeY;
          end;
        end;
      end;

      if (PlayObject.nC4 <= 1) and (PlayObject.m_Abil.Level >= 1) then
        PlayObject.nC4 := 2;
      if g_MapManager.FindMap(PlayObject.m_sMapName) = nil then
        PlayObject.m_Abil.HP := 0;
      if PlayObject.m_Abil.HP <= 0 then begin
        PlayObject.ClearStatusTime();
        if PlayObject.PKLevel < 2 then begin
          Castle := g_CastleManager.IsCastleMember(PlayObject);
            //            if UserCastle.m_boUnderWar and (UserCastle.IsMember(PlayObject)) then begin
          if (Castle <> nil) and Castle.m_boUnderWar then begin
            PlayObject.m_sMapName := Castle.m_sHomeMap;
            PlayObject.m_nCurrX := Castle.GetHomeX;
            PlayObject.m_nCurrY := Castle.GetHomeY;
          end else begin
            PlayObject.m_sMapName := PlayObject.m_sHomeMap;
            PlayObject.m_nCurrX := PlayObject.m_nHomeX - 2 + Random(5);
            PlayObject.m_nCurrY := PlayObject.m_nHomeY - 2 + Random(5);
          end;
        end else begin
          PlayObject.m_sMapName := g_Config.sRedDieHomeMap {'3'};
          PlayObject.m_nCurrX := Random(13) + g_Config.nRedDieHomeX {839};
          PlayObject.m_nCurrY := Random(13) + g_Config.nRedDieHomeY {668};
        end;
        PlayObject.m_Abil.HP := 14;
      end;

      PlayObject.AbilCopyToWAbil();
      Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
      if Envir = nil then begin
        PlayObject.m_nSessionID := UserOpenInfo.LoadUser.nSessionID;
        PlayObject.m_nSocket := UserOpenInfo.LoadUser.nSocket;
        PlayObject.m_nGateIdx := UserOpenInfo.LoadUser.nGateIdx;
        PlayObject.m_nGSocketIdx := UserOpenInfo.LoadUser.nGSocketIdx;
        PlayObject.m_WAbil := PlayObject.m_Abil;
        PlayObject.m_nServerIndex := g_MapManager.GetMapOfServerIndex(PlayObject.m_sMapName);
        if PlayObject.m_Abil.HP <> 14 then begin
          MainOutMessage(Format(sChangeServerFail1, [nServerIndex, PlayObject.m_nServerIndex, PlayObject.m_sMapName]));
            {MainOutMessage('chg-server-fail-1 [' +
                           IntToStr(nServerIndex) +
                           '] -> [' +
                           IntToStr(PlayObject.m_nServerIndex) +
                           '] [' +
                           PlayObject.m_sMapName +
                           ']');}
        end;
          //SendSwitchData(PlayObject, PlayObject.m_nServerIndex);
          //SendChangeServer(PlayObject, PlayObject.m_nServerIndex);
        FreeAndNil(PlayObject);
        Exit;
      end;
      nC := 0;
      while (True) do begin
        if Envir.CanWalk(PlayObject.m_nCurrX, PlayObject.m_nCurrY, True) and Envir.CanWalkOfEvent(PlayObject, PlayObject.m_nCurrX, PlayObject.m_nCurrY) then Break;
        PlayObject.m_nCurrX := PlayObject.m_nCurrX - 3 + Random(6);
        PlayObject.m_nCurrY := PlayObject.m_nCurrY - 3 + Random(6);
        Inc(nC);
        if nC >= 5 then Break;
      end;

      if (not Envir.CanWalk(PlayObject.m_nCurrX, PlayObject.m_nCurrY, True)) or (not Envir.CanWalkOfEvent(PlayObject, PlayObject.m_nCurrX, PlayObject.m_nCurrY)) then begin
        MainOutMessage(Format(sChangeServerFail2, [nServerIndex, PlayObject.m_nServerIndex, PlayObject.m_sMapName]));
          {  MainOutMessage('chg-server-fail-2 [' +
                           IntToStr(nServerIndex) +
                           '] -> [' +
                           IntToStr(PlayObject.m_nServerIndex) +
                           '] [' +
                           PlayObject.m_sMapName +
                           ']');}
        PlayObject.m_sMapName := g_Config.sHomeMap;
        Envir := g_MapManager.FindMap(g_Config.sHomeMap);
        PlayObject.m_nCurrX := g_Config.nHomeX;
        PlayObject.m_nCurrY := g_Config.nHomeY;
      end;

      PlayObject.m_PEnvir := Envir;
      if PlayObject.m_PEnvir = nil then begin
        MainOutMessage(sErrorEnvirIsNil);
        goto ReGetMap;
      end else begin
        PlayObject.m_boReadyRun := False;
      end;
      (*end else begin
        GetHumData(PlayObject, UserOpenInfo.HumanRcd);
        PlayObject.m_sMapName := SwitchDataInfo.sMAP;
        PlayObject.m_nCurrX := SwitchDataInfo.wX;
        PlayObject.m_nCurrY := SwitchDataInfo.wY;
        PlayObject.m_Abil := SwitchDataInfo.Abil;
        PlayObject.m_WAbil := SwitchDataInfo.Abil;
        LoadSwitchData(SwitchDataInfo, PlayObject);
        DelSwitchData(SwitchDataInfo);
        Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
        if Envir <> nil then begin
          MainOutMessage(Format(sChangeServerFail3, [nServerIndex, PlayObject.m_nServerIndex, PlayObject.m_sMapName]));
          {MainOutMessage('chg-server-fail-3 [' +
                         IntToStr(nServerIndex) +
                         '] -> [' +
                         IntToStr(PlayObject.m_nServerIndex) +
                         '] [' +
                         PlayObject.m_sMapName +
                         ']');}
          PlayObject.m_sMapName := g_Config.sHomeMap;
          Envir := g_MapManager.FindMap(g_Config.sHomeMap);
          PlayObject.m_nCurrX := g_Config.nHomeX;
          PlayObject.m_nCurrY := g_Config.nHomeY;
        end else begin
          if not Envir.CanWalk(PlayObject.m_nCurrX, PlayObject.m_nCurrY, True) or not Envir.CanWalkOfEvent(PlayObject, PlayObject.m_nCurrX, PlayObject.m_nCurrY) then begin
            MainOutMessage(Format(sChangeServerFail4, [nServerIndex, PlayObject.m_nServerIndex, PlayObject.m_sMapName]));
            {MainOutMessage('chg-server-fail-4 [' +
                           IntToStr(nServerIndex) +
                           '] -> [' +
                           IntToStr(PlayObject.m_nServerIndex) +
                           '] [' +
                           PlayObject.m_sMapName +
                           ']');}
            PlayObject.m_sMapName := g_Config.sHomeMap;
            Envir := g_MapManager.FindMap(g_Config.sHomeMap);
            PlayObject.m_nCurrX := g_Config.nHomeX;
            PlayObject.m_nCurrY := g_Config.nHomeY;
          end;
          PlayObject.AbilCopyToWAbil();
          PlayObject.m_PEnvir := Envir;
          if PlayObject.m_PEnvir = nil then begin
            MainOutMessage(sErrorEnvirIsNil);
            goto ReGetMap;
          end else begin
            PlayObject.m_boReadyRun := False;
            PlayObject.m_boLoginNoticeOK := True;
            PlayObject.bo6AB := True;
          end;
        end;
      end; *)
      PlayObject.m_sUserID := UserOpenInfo.LoadUser.sAccount;
      PlayObject.m_sIPaddr := UserOpenInfo.LoadUser.sIPaddr;
      PlayObject.m_sIPLocal := GetIPLocal(PlayObject.m_sIPaddr);
      PlayObject.m_nSocket := UserOpenInfo.LoadUser.nSocket;
      PlayObject.m_nGSocketIdx := UserOpenInfo.LoadUser.nGSocketIdx;
      PlayObject.m_nGateIdx := UserOpenInfo.LoadUser.nGateIdx;
      PlayObject.m_nSessionID := UserOpenInfo.LoadUser.nSessionID;
      PlayObject.m_nPayMent := UserOpenInfo.LoadUser.nPayMent;
      PlayObject.m_nPayMode := UserOpenInfo.LoadUser.nPayMode;
      PlayObject.m_dwLoadTick := UserOpenInfo.LoadUser.dwNewUserTick;
      PlayObject.m_nSoftVersionDateEx := GetExVersionNO(UserOpenInfo.LoadUser.nSoftVersionDate, PlayObject.m_nSoftVersionDate);
      PlayObject.m_boHeroVersion := UserOpenInfo.LoadUser.boHeroVersion; //20070720英雄客户端
      //MainOutMessage('m_nSoftVersionDateEx '+IntToStr(PlayObject.m_nSoftVersionDateEx));
      Result := PlayObject;
    except
      MainOutMessage(sExceptionMsg);
    end;
  end;
var
  dwUsrRotTime: LongWord;
  dwCheckTime: LongWord;
  dwCurTick: LongWord;
  nCheck30: Integer;
  boCheckTimeLimit: Boolean;
  nIdx: Integer;
  PlayObject: TPlayObject;
  I: Integer;
  UserOpenInfo: pTUserOpenInfo;
  GoldChangeInfo: pTGoldChangeInfo;
  LineNoticeMsg: string;
  sLineNoticeMsg: string;
  //nM2Crc: Integer;
  m_nUserLicense: Integer;
  m_nCheckServerCode: Integer;
  m_nErrorCode: Word;
  m_nProVersion: Integer;
  sUserKey: string;
  sCheckCode: string;
  nFColor, nBColor: Integer;
  nPos: Integer;
  sFColor, sBColor: string;
  boLineNoticeColor: Boolean;
  boMoveLineNotice: Boolean;
  AI: pTAILogon;
resourcestring
  sExceptionMsg1 = '[Exception] TUserEngine::ProcessHumans -> Ready, Save, Load... Code:=%d';
  sExceptionMsg2 = '[Exception] TUserEngine::ProcessHumans ClosePlayer.Delete - Free';
  sExceptionMsg3 = '[Exception] TUserEngine::ProcessHumans ClosePlayer.Delete';
  sExceptionMsg4 = '[Exception] TUserEngine::ProcessHumans RunNotice';
  sExceptionMsg5 = '[Exception] TUserEngine::ProcessHumans Human.Operate Code: %d';
  sExceptionMsg6 = '[Exception] TUserEngine::ProcessHumans Human.Finalize Code: %d';
  sExceptionMsg7 = '[Exception] TUserEngine::ProcessHumans RunSocket.CloseUser Code: %d';
  sExceptionMsg8 = '[Exception] TUserEngine::ProcessHumans';
begin
  nCheck30 := 0;
  dwCheckTime := GetTickCount();
  if (GetTickCount - m_dwProcessLoadPlayTick) > 200 then begin
    m_dwProcessLoadPlayTick := GetTickCount();
    try
      EnterCriticalSection(m_LoadPlaySection);
      try
        for I := 0 to m_LoadPlayList.Count - 1 do begin
          UserOpenInfo := pTUserOpenInfo(m_LoadPlayList.Objects[I]);
          if (not FrontEngine.IsFull) and (not IsLogined(UserOpenInfo.sAccount, m_LoadPlayList.Strings[I])) then begin
            PlayObject := MakeNewHuman(UserOpenInfo);
            if PlayObject <> nil then begin
              PlayObject.AddMapCount;
              PlayObject.m_boClientFlag := UserOpenInfo.LoadUser.boClinetFlag; //将客户端标志传到人物数据中
              m_PlayObjectList.AddObject(m_LoadPlayList.Strings[I], PlayObject);
              m_NewHumanList.Add(PlayObject);
            end;
          end else begin
            KickOnlineUser(m_LoadPlayList.Strings[I]);
            m_ListOfGateIdx.Add(Pointer(UserOpenInfo.LoadUser.nGateIdx));
            m_ListOfSocket.Add(Pointer(UserOpenInfo.LoadUser.nSocket));
          end;
          nCheck30 := 15;
          try
            Dispose(UserOpenInfo);
          except
            UserOpenInfo := nil;
            MainOutMessage('Error Dispose(UserOpenInfo)');
          end;
          nCheck30 := 16;
        end;
        nCheck30 := 17;
        m_LoadPlayList.Clear;
        for I := 0 to m_ChangeHumanDBGoldList.Count - 1 do begin
          GoldChangeInfo := m_ChangeHumanDBGoldList.Items[I];
          PlayObject := GetPlayObject(GoldChangeInfo.sGameMasterName);
          if PlayObject <> nil then begin
            PlayObject.GoldChange(GoldChangeInfo.sGetGoldUser, GoldChangeInfo.nGold);
          end;
          Dispose(GoldChangeInfo);
        end;
        m_ChangeHumanDBGoldList.Clear;
      finally
        LeaveCriticalSection(m_LoadPlaySection);
      end;

      for I := 0 to m_NewHumanList.Count - 1 do begin
        PlayObject := TPlayObject(m_NewHumanList.Items[I]);
        RunSocket.SetGateUserList(PlayObject.m_nGateIdx, PlayObject.m_nSocket, PlayObject);
      end;
      m_NewHumanList.Clear;

      for I := 0 to m_ListOfGateIdx.Count - 1 do begin
        RunSocket.CloseUser(Integer(m_ListOfGateIdx.Items[I]), Integer(m_ListOfSocket.Items[I])); //GateIdx,nSocket
      end;
      m_ListOfGateIdx.Clear;
      m_ListOfSocket.Clear;

      if not g_boExitServer then begin
        if GetTickCount - m_dwAILogonTick > 1000 * 3 then begin
          m_dwAILogonTick := GetTickCount;
          m_UserLogonList.Lock;
          try
            if m_UserLogonList.Count > 0 then begin
              AI := pTAILogon(m_UserLogonList.Objects[0]);
              RegenAIObject(AI);
              m_UserLogonList.Delete(0);
              Dispose(AI);
            end;
          finally
            m_UserLogonList.UnLock;
          end;

        end;
      end;
    except
      on E: Exception do begin
        MainOutMessage(Format(sExceptionMsg1, [nCheck30]));
        MainOutMessage(E.Message);
      end;
    end;
  end;

  try
    for I := 0 to m_PlayObjectFreeList.Count - 1 do begin //for i := 0 to m_PlayObjectFreeList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectFreeList.Items[I]);
      if (GetTickCount - PlayObject.m_dwGhostTick) > g_Config.dwHumanFreeDelayTime {5 * 60 * 1000} then begin
        try
          TPlayObject(m_PlayObjectFreeList.Items[I]).Free;
        except
          MainOutMessage(sExceptionMsg2);
        end;
        m_PlayObjectFreeList.Delete(I);
        Break;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg3);
  end;

  boCheckTimeLimit := False;
  try
    dwCurTick := GetTickCount();
    nIdx := m_nProcHumIDx;
    while True do begin
      if m_PlayObjectList.Count <= nIdx then Break;
      PlayObject := TPlayObject(m_PlayObjectList.Objects[nIdx]);
      if Integer(dwCurTick - PlayObject.m_dwRunTick) > PlayObject.m_nRunTime then begin
        PlayObject.m_dwRunTick := dwCurTick;
        if not PlayObject.m_boGhost then begin
          if not PlayObject.m_boLoginNoticeOK then begin
            try
              PlayObject.m_boNotOnlineAddExp := False; //是否是离线挂机人物
              PlayObject.RunNotice();
            except
              MainOutMessage(sExceptionMsg4);
            end;
          end else begin
            try
              if not PlayObject.m_boReadyRun then begin
                PlayObject.m_boNotOnlineAddExp := False; //是否是离线挂机人物
                PlayObject.m_boReadyRun := True;
                PlayObject.UserLogon;
              end else begin
                if (GetTickCount() - PlayObject.m_dwSearchTick) > PlayObject.m_dwSearchTime then begin
                  PlayObject.m_dwSearchTick := GetTickCount();
                  nCheck30 := 10;

                  PlayObject.SearchViewRange;
                  nCheck30 := 11;
                  PlayObject.GameTimeChanged;
                  nCheck30 := 12;
                end;
              end;
              if (GetTickCount() - PlayObject.m_dwShowLineNoticeTick) > g_Config.dwShowLineNoticeTime then begin
                PlayObject.m_dwShowLineNoticeTick := GetTickCount();
                if LineNoticeList.Count > PlayObject.m_nShowLineNoticeIdx then begin
                  if (not PlayObject.m_boNotOnlineAddExp) and (not PlayObject.m_boAI) then begin
                            LineNoticeMsg := g_ManageNPC.GetLineVariableText(PlayObject, LineNoticeList.Strings[PlayObject.m_nShowLineNoticeIdx]);
                    nCheck30 := 13;
                    boLineNoticeColor := False;
                    boMoveLineNotice := False;
                    //SendNoticeMsg:
                    case LineNoticeMsg[1] of
                      'R': PlayObject.SysMsg(Copy(LineNoticeMsg, 2, Length(LineNoticeMsg) - 1), c_Red, t_Notice);
                      'G': PlayObject.SysMsg(Copy(LineNoticeMsg, 2, Length(LineNoticeMsg) - 1), c_Green, t_Notice);
                      'B': PlayObject.SysMsg(Copy(LineNoticeMsg, 2, Length(LineNoticeMsg) - 1), c_Blue, t_Notice);
                      'C': begin
                          if LineNoticeMsg[2] = '(' then begin
                            nPos := Pos(')', LineNoticeMsg);
                            if nPos > 0 then begin
                              sFColor := Trim(Copy(LineNoticeMsg, 3, nPos - 3));
                              sBColor := Trim(Copy(sFColor, Pos(',', sFColor) + 1, Length(sFColor) - Pos(',', sFColor)));
                              sFColor := Trim(Copy(sFColor, 1, Pos(',', sFColor) - 1));
                              nFColor := Str_ToInt(sFColor, -1);
                              nBColor := Str_ToInt(sBColor, -1);
                              if (nFColor > 0) and (nFColor <= 255) and (nBColor >= 0) and (nBColor <= 255) then begin
                                LineNoticeMsg := Copy(LineNoticeMsg, nPos + 1, Length(LineNoticeMsg) - nPos);
                                PlayObject.SysMsg(LineNoticeMsg, nFColor, nBColor, t_Notice);
                                boLineNoticeColor := True;
                                //goto SendNoticeMsg;
                              end;
                            end;
                          end;
                        end;
                      'M': begin
                          if LineNoticeMsg[2] = '(' then begin
                            nPos := Pos(')', LineNoticeMsg);
                            if nPos > 0 then begin
                              sFColor := Trim(Copy(LineNoticeMsg, 3, nPos - 3));
                              sBColor := Trim(Copy(sFColor, Pos(',', sFColor) + 1, Length(sFColor) - Pos(',', sFColor)));
                              sFColor := Trim(Copy(sFColor, 1, Pos(',', sFColor) - 1));
                              nFColor := Str_ToInt(sFColor, -1);
                              nBColor := Str_ToInt(sBColor, -1);
                              if (nFColor > 0) and (nFColor <= 255) and (nBColor >= 0) and (nBColor <= 255) then begin
                                LineNoticeMsg := Copy(LineNoticeMsg, nPos + 1, Length(LineNoticeMsg) - nPos);
                                PlayObject.MoveMsg(LineNoticeMsg, nFColor, nBColor, 0, 40, 1);
                                boLineNoticeColor := True;
                                //goto SendNoticeMsg;
                              end;
                            end;
                          end;
                        end;
                    else begin
                        if not boLineNoticeColor then
                          PlayObject.SysMsg(LineNoticeMsg, TMsgColor(g_Config.nLineNoticeColor) {c_Blue}, t_Notice);
                      end;
                    end;
                    //if boMoveLineNotice then
                  end;
                end;

                Inc(PlayObject.m_nShowLineNoticeIdx);
                if (LineNoticeList.Count <= PlayObject.m_nShowLineNoticeIdx) then
                  PlayObject.m_nShowLineNoticeIdx := 0;
              end;

              nCheck30 := 14;
              PlayObject.Run();
              nCheck30 := 15;
              if not FrontEngine.IsFull and ((GetTickCount() - PlayObject.m_dwSaveRcdTick) > g_Config.dwSaveHumanRcdTime) then begin
                nCheck30 := 16;
                PlayObject.m_dwSaveRcdTick := GetTickCount();
                nCheck30 := 17;
                PlayObject.DealCancelA();
                PlayObject.DuelCancelA();

                nCheck30 := 18;

                SaveHumanRcd(PlayObject);

                nCheck30 := 19;
              end;
            except
              on E: Exception do begin
                PlayObject.KickException;
                MainOutMessage(Format(sExceptionMsg5, [nCheck30]) + ' Address:' + IntToHex(Integer(@PlayObject), 8) + ' Ghost:' + BooleanToStr(PlayObject.m_boGhost));
                MainOutMessage(E.Message);
              end;
            end;
          end;
        end else begin //if not PlayObject.boIsGhost then begin
          try
            m_PlayObjectList.Delete(nIdx);
            nCheck30 := 2;
            PlayObject.Disappear();
            nCheck30 := 3;
          except
            on E: Exception do begin
              PlayObject.KickException;
              MainOutMessage(Format(sExceptionMsg6, [nCheck30]));
              MainOutMessage(E.Message);
            end;
          end;
          try
            AddToHumanFreeList(PlayObject);
            nCheck30 := 4;
            PlayObject.DealCancelA();

            PlayObject.DuelCancelA();
            PlayObject.StoreCancel;

            SaveHumanRcd(PlayObject);
            if PlayObject.m_boAI then begin
              PlayObject.m_boSoftClose := True;
            end else begin
              RunSocket.CloseUser(PlayObject.m_nGateIdx, PlayObject.m_nSocket);
            end;
          except
            PlayObject.KickException;
            MainOutMessage(Format(sExceptionMsg7, [nCheck30]));
          end;

          Continue;
        end;
      end; //if (dwTime14 - PlayObject.dw368) > PlayObject.dw36C then begin
      Inc(nIdx);
      if (GetTickCount - dwCheckTime) > g_dwHumLimit then begin
        boCheckTimeLimit := True;
        m_nProcHumIDx := nIdx;
        Break;
      end;
    end; //while True do begin
    if not boCheckTimeLimit then m_nProcHumIDx := 0;
  except
    MainOutMessage(sExceptionMsg8);
  end;
  Inc(nProcessHumanLoopTime);
  g_nProcessHumanLoopTime := nProcessHumanLoopTime;
  if m_nProcHumIDx = 0 then begin
    nProcessHumanLoopTime := 0;
    g_nProcessHumanLoopTime := nProcessHumanLoopTime;
    dwUsrRotTime := GetTickCount - g_dwUsrRotCountTick;
    dwUsrRotCountMin := dwUsrRotTime;
    g_dwUsrRotCountTick := GetTickCount();
    if dwUsrRotCountMax < dwUsrRotTime then dwUsrRotCountMax := dwUsrRotTime;
  end;
  g_nHumCountMin := GetTickCount - dwCheckTime;
  if g_nHumCountMax < g_nHumCountMin then g_nHumCountMax := g_nHumCountMin;
end;

procedure TUserEngine.ProcessMerchants;
var
  dwRunTick, dwCurrTick: LongWord;
  I: Integer;
  MerchantNPC: TMerchant;
  boProcessLimit: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::ProcessMerchants';
begin
  dwRunTick := GetTickCount();
  boProcessLimit := False;
  try
    dwCurrTick := GetTickCount();
    m_MerchantList.Lock;
    try
      for I := nMerchantPosition to m_MerchantList.Count - 1 do begin
        MerchantNPC := m_MerchantList.Items[I];
        if not MerchantNPC.m_boGhost then begin
          if Integer(dwCurrTick - MerchantNPC.m_dwRunTick) > MerchantNPC.m_nRunTime then begin
            if (GetTickCount - MerchantNPC.m_dwSearchTick) > MerchantNPC.m_dwSearchTime then begin
              MerchantNPC.m_dwSearchTick := GetTickCount();
              MerchantNPC.SearchViewRange();
            end;
            if Integer(dwCurrTick - MerchantNPC.m_dwRunTick) > MerchantNPC.m_nRunTime then begin
              MerchantNPC.m_dwRunTick := dwCurrTick;
              MerchantNPC.Run;
            end;
          end;
        end else begin
          if (GetTickCount - MerchantNPC.m_dwGhostTick) > 60 * 1000 then begin
            MerchantNPC.Free;
            m_MerchantList.Delete(I);
            Break;
          end;
        end;
        if (GetTickCount - dwRunTick) > g_dwNpcLimit then begin
          nMerchantPosition := I;
          boProcessLimit := True;
          Break;
        end;
      end;
    finally
      m_MerchantList.UnLock;
    end;
    if not boProcessLimit then begin
      nMerchantPosition := 0;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
  dwProcessMerchantTimeMin := GetTickCount - dwRunTick;
  if dwProcessMerchantTimeMin > dwProcessMerchantTimeMax then dwProcessMerchantTimeMax := dwProcessMerchantTimeMin;
  if dwProcessNpcTimeMin > dwProcessNpcTimeMax then dwProcessNpcTimeMax := dwProcessNpcTimeMin;
end;

procedure TUserEngine.ProcessMonsters;
  function GetZenTime(dwTime: LongWord): LongWord;
  var
    d10: Double;
  begin
    if dwTime < 30 * 60 * 1000 then begin
      if g_Config.nZenFastStep = 0 then g_Config.nZenFastStep := 300;
      d10 := (GetUserCount - g_Config.nUserFull {1000}) / g_Config.nZenFastStep {300};
      if d10 > 0 then begin
        if d10 > 6 then d10 := 6;
        Result := dwTime - Round((dwTime / 10) * d10)
      end else begin
        Result := dwTime;
      end;
    end else begin
      Result := dwTime;
    end;
  end;
var
  dwCurrentTick: LongWord;
  dwRunTick: LongWord;
  dwMonProcTick: LongWord;
  Envir: TEnvirnoment;
  MonGen: pTMonGenInfo;
  nGenCount: Integer;
  nGenModCount: Integer;
  boProcessLimit: Boolean;
  boRegened: Boolean;
  I, II, III: Integer;
  nProcessPosition: Integer;
  Monster: TActorObject;
  tCode: Integer;
  nMakeMonsterCount: Integer;
  nActiveMonsterCount: Integer;
  nActiveHumCount: Integer;
  nNeedMakeMonsterCount: Integer;
  //MapMonGenCount: pTMapMonGenCount;
  //m_MonGenList: TList;
  n10: Integer;
  nLoopCount: Integer;
//label GetMapMonGen;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::ProcessMonsters %d %s';
begin
  tCode := 0;
  dwRunTick := GetTickCount();
  try
    tCode := 0;
    nLoopCount := 0;
    boProcessLimit := False;
    dwCurrentTick := GetTickCount();
    MonGen := nil;
    Envir := nil;
    //刷新怪物开始
    if ((GetTickCount - dwRegenMonstersTick) > g_Config.dwRegenMonstersTime) then begin
      dwRegenMonstersTick := GetTickCount();
      if m_nCurrMonGen < m_MonGenList.Count then begin
        MonGen := m_MonGenList.Items[m_nCurrMonGen];
      end;
      if m_nCurrMonGen < m_MonGenList.Count - 1 then begin
        Inc(m_nCurrMonGen);
      end else begin
        m_nCurrMonGen := 0;
      end;
      if (MonGen <> nil) and (MonGen.sMonName <> '') and not g_Config.boVentureServer then begin
        if (MonGen.dwStartTick = 0) or ((GetTickCount - MonGen.dwStartTick) > GetZenTime(MonGen.dwZenTime)) then begin
          nGenCount := GetGenMonCount(MonGen);
          boRegened := True;
          nGenModCount := _MAX(1, ROUND(_MAX(1, MonGen.nCount) / (g_Config.nMonGenRate / 10)));
          if nGenModCount > nGenCount then begin //0806 增加 控制刷怪数量比例
            boRegened := RegenMonsters(MonGen, nGenModCount - nGenCount);
          end;
          if boRegened then begin
            MonGen.dwStartTick := GetTickCount();
          end;
        end;
        g_sMonGenInfo1 := MonGen.sMonName + ',' + IntToStr(m_nCurrMonGen) + '/' + IntToStr(m_MonGenList.Count);
      end;
    end;

    g_nMonGenTime := GetTickCount - dwCurrentTick;
    if g_nMonGenTime > g_nMonGenTimeMin then g_nMonGenTimeMin := g_nMonGenTime;
    if g_nMonGenTime > g_nMonGenTimeMax then g_nMonGenTimeMax := g_nMonGenTime;
    //刷新怪物结束

    dwMonProcTick := GetTickCount();
    nMonsterProcessCount := 0;
    tCode := 1;
    for I := m_nMonGenListPosition to m_MonGenList.Count - 1 do begin
      MonGen := m_MonGenList.Items[I];
      tCode := 11;
      if m_nMonGenCertListPosition < MonGen.CertList.Count then begin
        nProcessPosition := m_nMonGenCertListPosition;
      end else begin
        nProcessPosition := 0;
      end;
      m_nMonGenCertListPosition := 0;
      while (True) do begin
        if nProcessPosition >= MonGen.CertList.Count then Break;
        Monster := MonGen.CertList.Items[nProcessPosition];
        tCode := 12;
        if Monster <> nil then begin
          if not Monster.m_boGhost then begin
            if Integer(dwCurrentTick - Monster.m_dwRunTick) > Monster.m_nRunTime then begin
              Monster.m_dwRunTick := dwRunTick;
              if (dwCurrentTick - Monster.m_dwSearchTick) > Monster.m_dwSearchTime then begin
                Monster.m_dwSearchTick := GetTickCount();
                tCode := 13;
                Monster.SearchViewRange();
              end;
              tCode := 14;
              if not Monster.m_boIsVisibleActive and (Monster.m_nProcessRunCount < g_Config.nProcessMonsterInterval) then begin
                Inc(Monster.m_nProcessRunCount);
              end else begin
                Monster.m_nProcessRunCount := 0;
                tCode := 15;
                Monster.Run;
                tCode := 16;
              end;
              Inc(nMonsterProcessCount);
            end;
            Inc(nMonsterProcessPostion);
          end else begin
            if (GetTickCount - Monster.m_dwGhostTick) > 5 * 60 * 1000 then begin
              tCode := 17;
              MonGen.CertList.Delete(nProcessPosition);
              //FreeAndNil(Monster);
              tCode := 18;
              Monster.Free;
              tCode := 19;
              Continue;
            end;
          end;
        end;
        Inc(nProcessPosition);
        if (GetTickCount - dwMonProcTick) > g_dwMonLimit then begin
          g_sMonGenInfo2 := Monster.m_sCharName + '/' + IntToStr(I) + '/' + IntToStr(nProcessPosition);
          boProcessLimit := True;
          m_nMonGenCertListPosition := nProcessPosition;
          Break;
        end;
      end; //while (True) do begin
      if boProcessLimit then Break;
    end; //for I:= m_nMonGenListPosition to MonGenList.Count -1 do begin
    tCode := 2;
    if m_MonGenList.Count <= I then begin
      m_nMonGenListPosition := 0;
      nMonsterCount := nMonsterProcessPostion;
      nMonsterProcessPostion := 0;
      n84 := (n84 + nMonsterProcessCount) div 2;
    end;
    if not boProcessLimit then begin
      m_nMonGenListPosition := 0;
    end else begin
      m_nMonGenListPosition := I;
    end;
    g_nMonProcTime := GetTickCount - dwMonProcTick;
    if g_nMonProcTime > g_nMonProcTimeMin then g_nMonProcTimeMin := g_nMonProcTime;
    if g_nMonProcTime > g_nMonProcTimeMax then g_nMonProcTimeMax := g_nMonProcTime;
  except
    on E: Exception do begin
      if Monster <> nil then begin
        Monster.KickException;
        MainOutMessage(Format(sExceptionMsg, [tCode, Monster.m_sCharName]) + ' Address:' + IntToHex(Integer(@Monster), 8) + ' Ghost:' + BooleanToStr(Monster.m_boGhost));
        MainOutMessage(E.Message);
      end else begin
        MainOutMessage(Format(sExceptionMsg, [tCode, '']));
        MainOutMessage(E.Message);
      end;
    end;
  end;
  g_nMonTimeMin := GetTickCount - dwRunTick;
  if g_nMonTimeMax < g_nMonTimeMin then g_nMonTimeMax := g_nMonTimeMin;
end;

function TUserEngine.GetGenMonCount(MonGen: pTMonGenInfo): Integer;
var
  I: Integer;
  nCount: Integer;
  BaseObject: TActorObject;
begin
  nCount := 0;
  for I := 0 to MonGen.CertList.Count - 1 do begin
    BaseObject := TActorObject(MonGen.CertList.Items[I]);
    if BaseObject <> nil then begin
      if (not BaseObject.m_boDeath) and (not BaseObject.m_boGhost) then Inc(nCount);
    end;
  end;
  Result := nCount;
end;

procedure TUserEngine.ProcessNpcs;
var
  dwRunTick, dwCurrTick: LongWord;
  I: Integer;
  NPC: TNormNpc;
  boProcessLimit: Boolean;
begin
  dwRunTick := GetTickCount();
  boProcessLimit := False;
  try
    dwCurrTick := GetTickCount();
    for I := nNpcPosition to QuestNPCList.Count - 1 do begin
      NPC := QuestNPCList.Items[I];
      if not NPC.m_boGhost then begin
        if Integer(dwCurrTick - NPC.m_dwRunTick) > NPC.m_nRunTime then begin
          if (GetTickCount - NPC.m_dwSearchTick) > NPC.m_dwSearchTime then begin
            NPC.m_dwSearchTick := GetTickCount();
            NPC.SearchViewRange();
          end;
          if Integer(dwCurrTick - NPC.m_dwRunTick) > NPC.m_nRunTime then begin
            NPC.m_dwRunTick := dwCurrTick;
            NPC.Run;
          end;
        end;
      end else begin
        if (GetTickCount - NPC.m_dwGhostTick) > 60 * 1000 then begin
          NPC.Free;
          QuestNPCList.Delete(I);
          Break;
        end;
      end;
      if (GetTickCount - dwRunTick) > g_dwNpcLimit then begin
        nNpcPosition := I;
        boProcessLimit := True;
        Break;
      end;
    end;
    if not boProcessLimit then begin
      nNpcPosition := 0;
    end;
  except
    MainOutMessage('[Exceptioin] TUserEngine.ProcessNpcs');
  end;
  dwProcessNpcTimeMin := GetTickCount - dwRunTick;
  if dwProcessNpcTimeMin > dwProcessNpcTimeMax then dwProcessNpcTimeMax := dwProcessNpcTimeMin;
end;

function TUserEngine.RegenMonsterByName(PlayObject: TActorObject; sMAP: string;
  nX, nY: Integer; sMonName: string): TActorObject;
var
  nRace: Integer;
  BaseObject: TActorObject;
  n18: Integer;
  MonGen: pTMonGenInfo;
begin
  nRace := GetMonRace(sMonName);
  BaseObject := AddBaseObject(PlayObject, sMAP, nX, nY, nRace, sMonName);
  if BaseObject <> nil then begin
    n18 := m_MonGenList.Count - 1;
    if n18 < 0 then n18 := 0;
    MonGen := m_MonGenList.Items[n18];
    if MonGen <> nil then begin
      MonGen.CertList.Add(BaseObject);
      BaseObject.AddMapCount;
    end else begin
      BaseObject.m_PEnvir.DeleteFromMap(BaseObject.m_nCurrX, BaseObject.m_nCurrY, BaseObject);
      FreeAndNil(BaseObject);
    end;
  end;
  Result := BaseObject;
end;

function TUserEngine.RegenMonsterByName(PlayObject: TActorObject; sMAP: string;
  nX, nY: Integer; nMonRace: Integer; sMonName: string): TActorObject;
var
  BaseObject: TActorObject;
  n18: Integer;
  MonGen: pTMonGenInfo;
begin
  BaseObject := AddBaseObject(PlayObject, sMAP, nX, nY, nMonRace, sMonName);
  if BaseObject <> nil then begin
    n18 := m_MonGenList.Count - 1;
    if n18 < 0 then n18 := 0;
    MonGen := m_MonGenList.Items[n18];
    if MonGen <> nil then begin
      MonGen.CertList.Add(BaseObject);
      BaseObject.AddMapCount;
    end else begin
      BaseObject.m_PEnvir.DeleteFromMap(BaseObject.m_nCurrX, BaseObject.m_nCurrY, BaseObject);
      FreeAndNil(BaseObject);
    end;
  end;
  Result := BaseObject;
end;

function TUserEngine.GetOnlineCount: string;
var
  nOnlineCount: Integer;
  nOnlineCount2: Integer;
  nAutoAddExpPlayCount: Integer;
begin
  nOnlineCount := GetUserCount;
  nAutoAddExpPlayCount := GetAutoAddExpPlayCount;
  nOnlineCount2 := nOnlineCount - nAutoAddExpPlayCount;
  Result := Format('%d(%d/%d)', [nOnlineCount, nOnlineCount2, nAutoAddExpPlayCount]);
end;

procedure TUserEngine.Run;
//var
//  i:integer;
//  dwProcessTick:LongWord;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::Run';
begin
  CalceTime := GetTickCount;
  try
    if (GetTickCount() - dwShowOnlineTick) > g_Config.dwConsoleShowUserCountTime then begin
      dwShowOnlineTick := GetTickCount();
      NoticeManager.LoadingNotice;
      MainOutMessage('Players Online: ' + GetOnlineCount);
      g_CastleManager.Save;
    end;
    if (GetTickCount() - dwSendOnlineHumTime) > 10000 then begin
      dwSendOnlineHumTime := GetTickCount();
      FrmIDSoc.SendOnlineHumCountMsg(GetOnlineHumCount);
    end;
    if Assigned(PlugInEngine.UserEngineRun) then begin
      PlugInEngine.UserEngineRun(Self);
    end;
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
end;

function TUserEngine.GetStdItem(nIdx: Integer): pTStdItem;
var
  nItemIdx: Integer;
begin
  Result := nil;
  nItemIdx := nIdx;
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then begin
    Result := StdItemList.Items[nItemIdx];
    if Result.Name = '' then Result := nil;
  end;
end;

function TUserEngine.GetStdItem(sItemName: string): pTStdItem;
var
  I: Integer;
  StdItem: pTStdItem;
begin
  Result := nil;
  if sItemName = '' then Exit;
  for I := 0 to StdItemList.Count - 1 do begin
    StdItem := StdItemList.Items[I];
    if CompareText(StdItem.Name, sItemName) = 0 then begin
      Result := StdItem;
      Break;
    end;
  end;
end;

function TUserEngine.GetStdItemWeight(nItemIdx: Integer): Integer;
var
  StdItem: pTStdItem;
begin
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then begin
    StdItem := StdItemList.Items[nItemIdx];
    Result := StdItem.Weight;
  end else begin
    Result := 0;
  end;
end;

function TUserEngine.GetStdItemName(nItemIdx: Integer): string;
begin
  Result := '';
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then begin
    Result := pTStdItem(StdItemList.Items[nItemIdx]).Name;
  end else Result := '';
end;

procedure TUserEngine.CryCry(wIdent: Word; pMap: TEnvirnoment; nX, nY,
  nWide: Integer; btFColor, btBColor: Byte; sMsg: string); //黄字喊话
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  for I := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if not PlayObject.m_boGhost and
      (PlayObject.m_PEnvir = pMap) and
      (PlayObject.m_boBanShout) and
      (abs(PlayObject.m_nCurrX - nX) < nWide) and
      (abs(PlayObject.m_nCurrY - nY) < nWide) {and (not PlayObject.m_boNotOnlineAddExp) and (not PlayObject.m_boAI)} then begin
      //PlayObject.SendMsg(nil,wIdent,0,0,$FFFF,0,sMsg);
      PlayObject.SendMsg(nil, wIdent, 0, btFColor, btBColor, 0, sMsg);
    end;
  end;
end;

procedure TUserEngine.CryCry(wIdent: Word; pMap: TEnvirnoment; nX, nY,
  nWide: Integer; btFColor, btBColor: Byte; sMsg: string; boSend: Boolean); //黄字喊话
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  for I := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if (not PlayObject.m_boGhost) and
      (not PlayObject.m_boSayAdvertise) and
      (PlayObject.m_PEnvir = pMap) and
      (PlayObject.m_boBanShout) and
      (abs(PlayObject.m_nCurrX - nX) < nWide) and
      (abs(PlayObject.m_nCurrY - nY) < nWide) {and (not PlayObject.m_boNotOnlineAddExp) and (not PlayObject.m_boAI)} then begin
      //PlayObject.SendMsg(nil,wIdent,0,0,$FFFF,0,sMsg);
      PlayObject.SendMsg(nil, wIdent, 0, btFColor, btBColor, 0, sMsg);
      PlayObject.m_boSayAdvertise := boSend;
      PlayObject.m_dwSayAdvertiseTick := GetTickCount;
    end;
  end;
end;

function TUserEngine.GetSayCount(pMap: TEnvirnoment; nX, nY, nWide: Integer): Integer;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  Result := 0;
  for I := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if not PlayObject.m_boGhost and
      (PlayObject.m_PEnvir = pMap) and
      (PlayObject.m_boBanShout) and
      (abs(PlayObject.m_nCurrX - nX) < nWide) and
      (abs(PlayObject.m_nCurrY - nY) < nWide) and (not PlayObject.m_boNotOnlineAddExp) and (not PlayObject.m_boAI) then begin
      if PlayObject.m_boSayAdvertise then Inc(Result);
    end;
  end;
end;

procedure TUserEngine.RefServerConfig(); //刷新客户端设置
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  for I := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if (not PlayObject.m_boGhost) and
      (not PlayObject.m_boDeath) and
      (PlayObject.m_boHeroVersion) and
      (not PlayObject.m_boNotOnlineAddExp) and
      (not PlayObject.m_boAI) then begin
      PlayObject.SendMsg(PlayObject, RM_SENDSERVERCONFIG, 0, 0, 0, 0, '');
      //PlayObject.SendMsg(PlayObject, RM_SENDREGINFO, 0, 0, 0, 0, '');
    end;
  end;
end;

function TUserEngine.MonGetRandomItems(mon: TActorObject): Integer; //获取怪物爆物品
var
  I: Integer;
  ItemList: TList;
  iname: string;
  MonItem: pTMonItemInfo;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  Monster: pTMonInfo;
begin
  ItemList := nil;
  for I := 0 to MonsterList.Count - 1 do begin
    Monster := MonsterList.Items[I];
    if CompareText(Monster.sName, mon.m_sCharName) = 0 then begin
      ItemList := Monster.ItemList;
      Break;
    end;
  end;

  if ItemList <> nil then begin
    for I := 0 to ItemList.Count - 1 do begin
      MonItem := pTMonItemInfo(ItemList[I]);
      if Random(MonItem.MaxPoint) <= MonItem.SelPoint then begin
        if CompareText(MonItem.ItemName, sSTRING_GOLDNAME) = 0 then begin
          mon.m_nGold := mon.m_nGold + (MonItem.Count div 2) + Random(MonItem.Count);
        end else begin
          //蜡聪农 酒捞袍 捞亥飘....
          iname := '';
          ////if (BoUniqueItemEvent) and (not mon.BoAnimal) then begin
          ////   if GetUniqueEvnetItemName (iname, numb) then begin
                //numb; //iname
          ////   end;
          ////end;
          if iname = '' then
            iname := MonItem.ItemName;

          New(UserItem);
          if CopyToUserItemFromName(iname, UserItem) then begin
            UserItem.Dura := Round((UserItem.DuraMax / 100) * (20 + Random(80)));

            StdItem := GetStdItem(UserItem.wIndex);
            ////if pstd <> nil then
            ////   if pstd.StdMode = 50 then begin  //惑前鼻
            ////      pu.Dura := numb;
            ////   end;
            if Random(g_Config.nMonRandomAddValue {10}) = 0 then
              RandomUpgradeItem(UserItem);

            if Random(g_Config.nMonRandomNewAddValue {10}) = 0 then //元素
              _RandomUpgradeItem(UserItem);

            if Random(g_Config.nMonRandomAddPoint) = 0 then //新增5属性
              RandomItemAddPoint(UserItem);

            if StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26] then begin
              if (StdItem.Shape = 130) or (StdItem.Shape = 131) or (StdItem.Shape = 132) then begin
                GetUnknowItemValue(UserItem);

                _GetUnknowItemValue(UserItem);

              end;
            end;
            mon.m_ItemList.Add(UserItem)
          end else Dispose(UserItem);
        end;
      end;
    end;
  end;
  Result := 1;
end;

procedure TUserEngine.RandomUpgradeItem(Item: pTUserItem);
var
  StdItem: pTStdItem;
begin
  StdItem := GetStdItem(Item.wIndex);
  if StdItem = nil then Exit;
  case StdItem.StdMode of
    5, 6: ItemUnit.RandomUpgradeWeapon(Item);
    10, 11: ItemUnit.RandomUpgradeDress(Item);
    19: ItemUnit.RandomUpgrade19(Item);
    20, 21, 24: ItemUnit.RandomUpgrade202124(Item);
    26: ItemUnit.RandomUpgrade26(Item);
    22: ItemUnit.RandomUpgrade22(Item);
    23: ItemUnit.RandomUpgrade23(Item);
    15, 30: ItemUnit.RandomUpgradeHelMet(Item);
  end;
end;

procedure TUserEngine.GetUnknowItemValue(Item: pTUserItem);
var
  StdItem: pTStdItem;
begin
  StdItem := GetStdItem(Item.wIndex);
  if StdItem = nil then Exit;
  case StdItem.StdMode of
    15, 30: ItemUnit.UnknowHelmet(Item);
    22, 23: ItemUnit.UnknowRing(Item);
    24, 26: ItemUnit.UnknowNecklace(Item);
  end;
end;

procedure TUserEngine.RandomItemAddPoint(Item: pTUserItem);
var
  StdItem: pTStdItem;
begin
  if not g_Config.boAllowItemAddPoint then Exit;
  StdItem := GetStdItem(Item.wIndex);
  if StdItem = nil then Exit;
  case StdItem.StdMode of
    5, 6: ItemUnit.RandomWeaponAddPoint(Item);
    10, 11: ItemUnit.RandomDressAddPoint(Item);
    19, 20, 21: ItemUnit.RandomNeckLaceAddPoint(Item);
    24, 25, 26: ItemUnit.RandomArmRingAddPoint(Item);
    22, 23: ItemUnit.RandomRingAddPoint(Item);
    15, 30: ItemUnit.RandomHelMetAddPoint(Item); //增加勋章可以升级
    54, 64: ItemUnit.RandomBeltAddPoint(Item);
    52, 62: ItemUnit.RandomShoesAddPoint(Item);
  end;
end;

procedure TUserEngine.RandomUpgradeItem_(Item: pTUserItem; nValue: Integer; btMethod: Byte);
var
  StdItem: pTStdItem;
begin
  StdItem := GetStdItem(Item.wIndex);
  if StdItem = nil then Exit;
  case StdItem.StdMode of
    5, 6: ItemUnit.RandomUpgradeWeapon_(Item, nValue, btMethod);
    10, 11: ItemUnit.RandomUpgradeDress_(Item, nValue, btMethod);
    19: ItemUnit.RandomUpgrade19_(Item, nValue, btMethod);
    20, 21, 24: ItemUnit.RandomUpgrade202124_(Item, nValue, btMethod);
    26: ItemUnit.RandomUpgrade26_(Item, nValue, btMethod);
    22: ItemUnit.RandomUpgrade22_(Item, nValue, btMethod);
    23: ItemUnit.RandomUpgrade23_(Item, nValue, btMethod);
    15, 54, 64, 52, 62, 30: ItemUnit.RandomUpgradeHelMet_(Item, nValue, btMethod); //增加勋章可以升级
  end;
end;

procedure TUserEngine.GetUnknowItemValue_(Item: pTUserItem; nValue: Integer; btMethod: Byte);
var
  StdItem: pTStdItem;
begin
  if not g_Config.boAllowItemAddValue then Exit;
  StdItem := GetStdItem(Item.wIndex);
  if StdItem = nil then Exit;
  case StdItem.StdMode of
    15, 30: ItemUnit.UnknowHelmet_(Item, nValue, btMethod);
    22, 23: ItemUnit.UnknowRing_(Item, nValue, btMethod);
    24, 26: ItemUnit.UnknowNecklace_(Item, nValue, btMethod);
  end;
end;

procedure TUserEngine._RandomUpgradeItem(Item: pTUserItem);
var
  StdItem: pTStdItem;
begin
  if not g_Config.boAllowItemAddValue then Exit;
  StdItem := GetStdItem(Item.wIndex);
  if StdItem = nil then Exit;
  case StdItem.StdMode of
    5, 6: ItemUnit._RandomUpgradeWeapon(Item);
    10, 11: ItemUnit._RandomUpgradeDress(Item);
    19: ItemUnit._RandomUpgrade19(Item);
    20, 21, 24: ItemUnit._RandomUpgrade202124(Item);
    26: ItemUnit._RandomUpgrade26(Item);
    22: ItemUnit._RandomUpgrade22(Item);
    23: ItemUnit._RandomUpgrade23(Item);
    15, 54, 64, 52, 62, 30: ItemUnit._RandomUpgradeHelMet(Item); //增加勋章可以升级
  end;
end;

procedure TUserEngine._GetUnknowItemValue(Item: pTUserItem);
var
  StdItem: pTStdItem;
begin
  StdItem := GetStdItem(Item.wIndex);
  if StdItem = nil then Exit;
  case StdItem.StdMode of
    15, 30: ItemUnit._UnknowHelmet(Item);
    22, 23: ItemUnit._UnknowRing(Item);
    24, 26: ItemUnit._UnknowNecklace(Item);
  end;
end;

procedure TUserEngine._RandomItemLimitDay(Item: pTUserItem; nRate: Integer);
var
  StdItem: pTStdItem;
  btItemType: Byte;
begin
  if not g_Config.boAllowItemTime then Exit;
  StdItem := GetStdItem(Item.wIndex);
  if StdItem = nil then Exit;
  case StdItem.StdMode of
    10, 11: btItemType := 0; //衣服
    5, 6: btItemType := 1; //武器
    28, 29, 30: btItemType := 2; //照明物
    19, 20, 21: btItemType := 3; //项链
    15: btItemType := 4; //头盔
    24, 26: btItemType := 5; //手镯
    22, 23: btItemType := 6; //戒指
    25, 51: btItemType := 7; //物品
    54, 64: btItemType := 8; //腰带
    52, 62: btItemType := 9; //鞋子
    53, 63: btItemType := 10; //宝石
  else btItemType := 7; //物品
  end;
  ItemUnit._RandomItemLimitDay(Item, btItemType, nRate);
end;

function TUserEngine._AllowUpgradeItem(Item: pTUserItem): Boolean;
var
  StdItem: pTStdItem;
begin
  Result := False;
  StdItem := GetStdItem(Item.wIndex);
  if StdItem = nil then Exit;
  case StdItem.StdMode of
    5, 6, 10, 11, 19, 20, 21, 24, 26, 22, 23, 15, 54, 64, 52, 62, 30: Result := True; //增加勋章可以升级
  end;
end;

function TUserEngine.CopyToUserItemFromName(sItemName: string; Item: pTUserItem): Boolean;
var
  I: Integer;
  StdItem: pTStdItem;
begin
  Result := False;
  if sItemName <> '' then begin
    for I := 0 to StdItemList.Count - 1 do begin
      StdItem := StdItemList.Items[I];
      if CompareText(StdItem.Name, sItemName) = 0 then begin
        FillChar(Item^, SizeOf(TUserItem), #0);
        Item.wIndex := I + 1;
        Item.MakeIndex := GetItemNumber();
        Item.Dura := StdItem.DuraMax;
        Item.DuraMax := StdItem.DuraMax;
        if StdItem.StdMode = 49 then Item.Dura := 0;
        Result := True;
        Break;
      end;
    end;
  end;
end;

procedure TUserEngine.ProcessUserMessage(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; Buff: PChar);
var
  sMsg: string;
  NewBuff: array[0..DATA_BUFSIZE2 - 1] of Char;
  sDefMsg: string;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::ProcessUserMessage..';
begin
  if (DefMsg = nil) or (PlayObject = nil) { or (PlayObject.m_boNotOnlineAddExp) or (PlayObject.m_boAI)} then Exit; //2008-6-1增加 离线挂机人物不接受数据包
  try
    if Buff = nil then sMsg := ''
    else sMsg := StrPas(Buff);
    case DefMsg.Ident of
      CM_SPELL: begin //3017
          //MainOutMessage('TUserEngine.CM_SPELL');
          //if PlayObject.GetSpellMsgCount <=2 then  //如果队排里有超过二个魔法操作，则不加入队排
          if g_Config.boSpellSendUpdateMsg then begin //使用UpdateMsg 可以防止消息队列里有多个操作
            PlayObject.SendUpdateMsg(PlayObject,
              DefMsg.Ident,
              DefMsg.Tag,
              LoWord(DefMsg.Recog),
              HiWord(DefMsg.Recog),
              MakeLong(DefMsg.Param,
              DefMsg.Series),
              '');
          end else begin
            PlayObject.SendMsg(PlayObject,
              DefMsg.Ident,
              DefMsg.Tag,
              LoWord(DefMsg.Recog),
              HiWord(DefMsg.Recog),
              MakeLong(DefMsg.Param,
              DefMsg.Series),
              '');
          end;
        end;
      CM_STOPSERIESPELL, //开始连击
        CM_QUERYUSERNAME,
        CM_HEROPROTECT, //守护
        CM_HEROTARGET, ////锁定
        CM_HEROGROUPATTACK: begin //80
          PlayObject.SendMsg(PlayObject, DefMsg.Ident, 0, DefMsg.Recog, DefMsg.Param {x}, DefMsg.Tag {y}, '');
        end;

      CM_DROPITEM,
        CM_TAKEONITEM,
        CM_TAKEOFFITEM,
        CM_1005,

      CM_MERCHANTDLGSELECT,
        CM_MERCHANTQUERYSELLPRICE,
        CM_USERSELLITEM,
        CM_USERBUYITEM,
        CM_USERGETDETAILITEM,

      CM_SENDCHANGEITEM,

      CM_SENDSELLOFFITEM,
        CM_SENDSELLOFFITEMLIST, //拍卖
        CM_SENDQUERYSELLOFFITEM, //拍卖
        CM_SENDBUYSELLOFFITEM, //拍卖
        CM_SENDGETSELLITEMGOLD,


      CM_MASTERBAGTOHEROBAG, //主人包裹物品放到英雄包裹
        CM_HEROBAGTOMASTERBAG, //英雄包裹物品放到主人包裹

      CM_HEROTAKEONITEMFROMMASTER, //英雄穿装备从主人
        CM_HEROTAKEOFFITEMTOMASTER, //英雄脱装备到主人

      CM_TAKEONITEMFROMHERO, //主人穿装备从英雄包裹
        CM_TAKEOFFITEMTOHERO, //主人脱装备到英雄包裹


      CM_OPENITEMBOX,

      CM_SENDFINDITEMINFO,

      CM_CREATEGROUP,
        CM_ADDGROUPMEMBER,
        CM_DELGROUPMEMBER,
        CM_USERREPAIRITEM,
        CM_MERCHANTQUERYREPAIRCOST,
        CM_DEALTRY,
        CM_DEALADDITEM,
        CM_DEALDELITEM,

      CM_DUELTRY,
        CM_DUELADDITEM,
        CM_DUELDELITEM,

      CM_BUYSTOREITEM,

      CM_USERSTORAGEITEM,
        CM_USERTAKEBACKSTORAGEITEM,
        //      CM_WANTMINIMAP,
      CM_USERMAKEDRUGITEM,

      //      CM_GUILDHOME,
      CM_GUILDADDMEMBER,
        CM_GUILDDELMEMBER,
        CM_GUILDUPDATENOTICE,
        CM_GUILDUPDATERANKINFO: begin
          PlayObject.SendMsg(PlayObject,
            DefMsg.Ident,
            DefMsg.Series,
            DefMsg.Recog,
            DefMsg.Param,
            DefMsg.Tag,
            DeCodeString(sMsg));
        end;
      CM_PASSWORD,
        CM_CHGPASSWORD,
        CM_SETPASSWORD: begin
          PlayObject.SendMsg(PlayObject,
            DefMsg.Ident,
            DefMsg.Param,
            DefMsg.Recog,
            DefMsg.Series,
            DefMsg.Tag,
            DeCodeString(sMsg));
        end;
      CM_ADJUST_BONUS: begin //1043
          PlayObject.SendMsg(PlayObject,
            DefMsg.Ident,
            DefMsg.Series,
            DefMsg.Recog,
            DefMsg.Param,
            DefMsg.Tag,
            sMsg);
        end;
      CM_HORSERUN,
        CM_TURN,
        CM_WALK,
        CM_SITDOWN,
        CM_RUN,
        CM_HIT,
        CM_HEAVYHIT,
        CM_BIGHIT,

      CM_POWERHIT,
        CM_LONGHIT,
        CM_CRSHIT,
        CM_TWNHIT,
        CM_WIDEHIT,
        CM_PHHIT,
        CM_PKHIT,
        CM_KTHIT,
        CM_FIREHIT,
        CM_60HIT,
        CM_ZRJFHIT,
        CM_100HIT,
        CM_101HIT,
        CM_102HIT,
        CM_103HIT: begin
          if g_Config.boActionSendActionMsg then begin //使用UpdateMsg 可以防止消息队列里有多个操作
            PlayObject.SendActionMsg(PlayObject, //PlayObject.SendActionMsg PlayObject.SendUpdateMsgA
              DefMsg.Ident,
              DefMsg.Tag,
              LoWord(DefMsg.Recog), {x}
              HiWord(DefMsg.Recog), {y}
              0,
              DeCodeString(sMsg));
          end else begin
            PlayObject.SendMsg(PlayObject,
              DefMsg.Ident,
              DefMsg.Tag,
              LoWord(DefMsg.Recog), {x}
              HiWord(DefMsg.Recog), {y}
              0,
              DeCodeString(sMsg));
          end;
        end;
      CM_SAY: begin
          if DefMsg.Recog > 0 then begin
            PlayObject.m_btHearMsgFColor := LoByte(DefMsg.Param);
            PlayObject.m_btWhisperMsgFColor := HiByte(DefMsg.Param);
          end else begin
            PlayObject.m_btHearMsgFColor := g_Config.btHearMsgFColor;
            PlayObject.m_btWhisperMsgFColor := g_Config.btWhisperMsgFColor;
          end;
          PlayObject.SendMsg(PlayObject, CM_SAY, 0, 0, 0, 0, DeCodeString(sMsg));
        end;



     { CM_QUERYUSERLEVELSORT: begin
          PlayObject.SendUpdateMsg(PlayObject, DefMsg.Ident, 0, DefMsg.Param, DefMsg.Tag, DefMsg.Recog, '');
        end;
      CM_USEGROUPSPELL: begin
          PlayObject.SendUpdateMsg(PlayObject, DefMsg.Ident, 0, 0, 0, 0, '');
        end; }
      CM_OPENSHOP: begin
          PlayObject.SendMsg(PlayObject,
            DefMsg.Ident,
            DefMsg.Series,
            DefMsg.Recog,
            DefMsg.Param,
            DefMsg.Tag,
            '');
        end;
      CM_BUYSHOPITEM: begin
          PlayObject.SendUpdateMsg(PlayObject,
            DefMsg.Ident,
            DefMsg.Series,
            DefMsg.Recog,
            DefMsg.Param,
            DefMsg.Tag,
            DeCodeString(sMsg));
        end;
      CM_SENDSELLOFFGOODSLIST: begin
          PlayObject.SendUpdateMsg(PlayObject, DefMsg.Ident, 0, DefMsg.Recog, DefMsg.Param, 0, DeCodeString(sMsg));
        end;
      CM_SENDSEARCHSELLITEM: begin
          PlayObject.SendUpdateMsg(PlayObject, DefMsg.Ident, 0, DefMsg.Recog, 0, 0, DeCodeString(sMsg));
        end;

      CM_GETRANKING,
        CM_GETMYRANKING: PlayObject.SendUpdateMsg(PlayObject, DefMsg.Ident, DefMsg.Recog, DefMsg.Param, DefMsg.Tag, DefMsg.Series, '');

      CM_QUERYHEROBAGITEMS, //查询英雄包裹
        CM_HEROMAGICKEYCHANGE, //魔法键
        CM_HEROTAKEONITEM, //英雄穿装备
        CM_HEROTAKEOFFITEM, //英雄脱装备
        CM_HEROEAT: begin
          if PlayObject.m_MyHero <> nil then
            PlayObject.m_MyHero.SendMsg(PlayObject.m_MyHero, DefMsg.Ident, DefMsg.Series, DefMsg.Recog, DefMsg.Param, DefMsg.Tag, DeCodeString(sMsg)); //英雄吃药
        end;
      CM_REPAIRFIRDRAGON: begin
          if PlayObject.m_MyHero <> nil then
            PlayObject.m_MyHero.SendMsg(PlayObject.m_MyHero,
              DefMsg.Ident,
              DefMsg.Tag,
              LoWord(DefMsg.Recog), {x}
              HiWord(DefMsg.Recog), {y}
              0,
              DeCodeString(sMsg));
        end;

      CM_HERODROPITEM: begin
          if PlayObject.m_MyHero <> nil then
            PlayObject.m_MyHero.SendMsg(PlayObject.m_MyHero,
              DefMsg.Ident,
              DefMsg.Series,
              DefMsg.Recog,
              DefMsg.Param,
              DefMsg.Tag,
              DeCodeString(sMsg));
        end; //英雄扔物品
      CM_HEROLOGON_OK: begin
          if PlayObject.m_MyHero <> nil then
            PlayObject.m_MyHero.SendMsg(PlayObject.m_MyHero,
              DefMsg.Ident,
              DefMsg.Series,
              DefMsg.Recog,
              DefMsg.Param,
              DefMsg.Tag,
              '');
        end;
    else begin
        if Assigned(PlugInEngine.ObjectClientMsg) then begin
          PlugInEngine.ObjectClientMsg(PlayObject, DefMsg, Buff, @NewBuff);
          if @NewBuff = nil then sMsg := ''
          else sMsg := StrPas(@NewBuff);
        end;
        PlayObject.SendMsg(PlayObject,
          DefMsg.Ident,
          DefMsg.Series,
          DefMsg.Recog,
          DefMsg.Param,
          DefMsg.Tag,
          sMsg);
      end;
    end;
    if PlayObject.m_boReadyRun then begin
      case DefMsg.Ident of
        CM_TURN, CM_WALK, CM_SITDOWN, CM_RUN, CM_HIT, CM_HEAVYHIT, CM_BIGHIT,
          CM_POWERHIT, CM_LONGHIT,
          CM_WIDEHIT, CM_FIREHIT, CM_CRSHIT, CM_PHHIT, CM_TWNHIT, CM_KTHIT, CM_PKHIT, CM_60HIT, CM_ZRJFHIT, CM_100HIT, CM_101HIT, CM_102HIT, CM_103HIT: begin
            Dec(PlayObject.m_dwRunTick, 100);
          end;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TUserEngine.AddIPToGateBlockList(sUserIpddr: string);
begin
  FrmIDSoc.SendAddIP(sUserIpddr);
end;

function TUserEngine.AddBaseObject(BaseObject: TActorObject; sMapName: string; nX, nY: Integer; nMonRace: Integer; sMonName: string): TActorObject;
var
  Map: TEnvirnoment;
  Cert: TActorObject;
  n1C, n20, n24: Integer;
  p28: Pointer;
begin
  Result := nil;
  Cert := nil;

  Map := g_MapManager.FindMap(sMapName);

  if Map = nil then Exit;
  case nMonRace of
    0: Cert := TAIPlayObject.Create;
    11: Cert := TSuperGuard.Create;
    20: Cert := TArcherPolice.Create;
    51: begin
        Cert := TMonster.Create;
        Cert.m_boAnimal := True;
        Cert.m_nMeatQuality := Random(3500) + 3000;
        Cert.m_nBodyLeathery := 50;
      end;
    52: begin
        if Random(30) = 0 then begin
          Cert := TChickenDeer.Create;
          Cert.m_boAnimal := True;
          Cert.m_nMeatQuality := Random(20000) + 10000;
          Cert.m_nBodyLeathery := 150;
        end else begin
          Cert := TMonster.Create;
          Cert.m_boAnimal := True;
          Cert.m_nMeatQuality := Random(8000) + 8000;
          Cert.m_nBodyLeathery := 150;
        end;
      end;
    53: begin
        Cert := TATMonster.Create;
        Cert.m_boAnimal := True;
        Cert.m_nMeatQuality := Random(8000) + 8000;
        Cert.m_nBodyLeathery := 150;
      end;
    55: begin
        Cert := TTrainer.Create;
        Cert.m_btRaceServer := 55;
      end;
    60: Cert := TMoonObject.Create;
    80: Cert := TMonster.Create;
    81: Cert := TATMonster.Create;
    82: Cert := TSpitSpider.Create;
    83: Cert := TSlowATMonster.Create;
    84: Cert := TScorpion.Create;
    85: Cert := TStickMonster.Create;
    86: Cert := TATMonster.Create;
    87: Cert := TDualAxeMonster.Create;
    88: Cert := TATMonster.Create;
    89: Cert := TATMonster.Create;
    90: Cert := TGasAttackMonster.Create;
    91: Cert := TMagCowMonster.Create;
    92: Cert := TCowKingMonster.Create;
    93: Cert := TThornDarkMonster.Create;
    94: Cert := TLightingZombi.Create;
    95: begin
        Cert := TDigOutZombi.Create;
        if Random(2) = 0 then Cert.bo2BA := True;
      end;
    96: begin
        Cert := TZilKinZombi.Create;
        if Random(4) = 0 then Cert.bo2BA := True;
      end;
    97: begin
        Cert := TCowMonster.Create;
        if Random(2) = 0 then Cert.bo2BA := True;
      end;

    100: Cert := TWhiteSkeleton.Create;
    101: begin
        Cert := TScultureMonster.Create;
        Cert.bo2BA := True;
      end;
    102: Cert := TScultureKingMonster.Create;
    103: Cert := TBeeQueen.Create;
    104: Cert := TArcherMonster.Create;
    105: Cert := TGasMothMonster.Create; //楔蛾
    106: Cert := TGasDungMonster.Create;
    107: Cert := TCentipedeKingMonster.Create;
    110: Cert := TCastleDoor.Create;
    111: Cert := TWallStructure.Create;
    112: Cert := TArcherGuard.Create;
    113: Cert := TElfMonster.Create;
    114: Cert := TElfWarriorMonster.Create;
    115: Cert := TBigHeartMonster.Create;
    116: Cert := TSpiderHouseMonster.Create;
    117: Cert := TExplosionSpider.Create;
    118: Cert := THighRiskSpider.Create;
    119: Cert := TBigPoisionSpider.Create;
    120: Cert := TSoccerBall.Create;
    121: Cert := TAnimalObject.Create;
    122: Cert := TCartMonster.Create;
    200: Cert := TElectronicScolpionMon.Create;
    150: begin
        Cert := TCopyObject.Create;
        Cert.m_nMeatQuality := Random(20000) + 10000;
      //Cert.m_nBodyLeathery := 150;
      end;
  end;

  if Cert <> nil then begin
    if not (Cert.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT]) then
      MonInitialize(Cert, sMonName);
    Cert.m_PEnvir := Map;
    Cert.m_sMapName := sMapName;
    Cert.m_nCurrX := nX;
    Cert.m_nCurrY := nY;
    Cert.m_btDirection := Random(8);
    Cert.m_sCharName := sMonName;
    Cert.m_WAbil := Cert.m_Abil;
    if Random(100) < Cert.m_btCoolEye then Cert.m_boCoolEye := True;
    if not (Cert.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT]) then
      MonGetRandomItems(Cert); //取得怪物爆物品内容

    if Cert.m_btRaceServer = RC_PLAYOBJECT then begin
      TPlayObject(Cert).m_sIPaddr := GetIPAddr;
      TPlayObject(Cert).m_sIPLocal := GetIPLocal(TPlayObject(Cert).m_sIPaddr);
    end;

    if BaseObject <> nil then begin
      if nMonRace = 150 then begin //分身
        TCopyObject(Cert).Copy(BaseObject);
      end;
      if nMonRace = 60 then begin //月灵
      end;
    end else begin
      if nMonRace = 150 then begin //人型怪
        TCopyObject(Cert).m_nCopyHumanLevel := 0;
        Cert.m_Abil.HP := Cert.m_Abil.MaxHP;
        Cert.m_Abil.MP := Cert.m_Abil.MaxMP;
      end;
      if nMonRace = 60 then begin //月灵
        Cert.m_Abil.HP := Cert.m_Abil.MaxHP;
        Cert.m_Abil.MP := Cert.m_Abil.MaxMP;
      end;
    end;

    Cert.Initialize;

   { if nMonRace = 150 then begin //分身
      TCopyObject(Cert).Initialize;
    end else
      if nMonRace = 60 then begin //月灵
      TMoonObject(Cert).Initialize;
    end else begin
      Cert.Initialize;
    end; }

    if Cert.m_boAddtoMapSuccess then begin
      p28 := nil;
      if Cert.m_PEnvir.m_nWidth < 50 then n20 := 2
      else n20 := 3;
      if (Cert.m_PEnvir.m_nHeight < 250) then begin
        if (Cert.m_PEnvir.m_nHeight < 30) then n24 := 2
        else n24 := 20;
      end else n24 := 50;
      n1C := 0;
      while (True) do begin
        if not Cert.m_PEnvir.CanWalk(Cert.m_nCurrX, Cert.m_nCurrY, False) or not Cert.m_PEnvir.CanWalkOfEvent(Cert, Cert.m_nCurrX, Cert.m_nCurrY) then begin
          if (Cert.m_PEnvir.m_nWidth - n24 - 1) > Cert.m_nCurrX then begin
            Inc(Cert.m_nCurrX, n20);
          end else begin
            Cert.m_nCurrX := Random(Cert.m_PEnvir.m_nWidth div 2) + n24;
            if Cert.m_PEnvir.m_nHeight - n24 - 1 > Cert.m_nCurrY then begin
              Inc(Cert.m_nCurrY, n20);
            end else begin
              Cert.m_nCurrY := Random(Cert.m_PEnvir.m_nHeight div 2) + n24;
            end;
          end;
        end else begin
          p28 := Cert.m_PEnvir.AddToMap(Cert.m_nCurrX, Cert.m_nCurrY, Cert);
          Break;
        end;
        Inc(n1C);
        if n1C >= 31 then Break;
      end;
      if p28 = nil then begin
        FreeAndNil(Cert);
      end else begin
        Inc(Cert.m_nViewRange, 2); //2006-12-30 怪物视觉+2
      end;
    end;
  end;
  Result := Cert;
end;


function TUserEngine.AddAIPlayObject(AI: pTAILogon): TAIPlayObject;
var
  Map: TEnvirnoment;
  Cert: TAIPlayObject;
  n1C, n20, n24: Integer;
  p28: Pointer;
begin
  Result := nil;
  Cert := nil;

  Map := g_MapManager.FindMap(AI.sMapName);

  if Map = nil then Exit;

  Cert := TAIPlayObject.Create;

  if Cert <> nil then begin

    Cert.m_PEnvir := Map;
    Cert.m_sMapName := AI.sMapName;
    Cert.m_nCurrX := AI.nX;
    Cert.m_nCurrY := AI.nY;
    Cert.m_btDirection := Random(8);
    Cert.m_sCharName := AI.sCharName;
    Cert.m_WAbil := Cert.m_Abil;
    if Random(100) < Cert.m_btCoolEye then Cert.m_boCoolEye := True;

    Cert.m_sIPaddr := GetIPAddr;
    Cert.m_sIPLocal := GetIPLocal(Cert.m_sIPaddr);

    Cert.m_sConfigFileName := AI.sConfigFileName;
    Cert.m_sHeroConfigFileName := AI.sHeroConfigFileName;
    Cert.m_sFilePath := AI.sFilePath;
    Cert.m_sConfigListFileName := AI.sConfigListFileName;
    Cert.Initialize;

    if Cert.m_boAddtoMapSuccess then begin
      p28 := nil;
      if Cert.m_PEnvir.m_nWidth < 50 then n20 := 2
      else n20 := 3;
      if (Cert.m_PEnvir.m_nHeight < 250) then begin
        if (Cert.m_PEnvir.m_nHeight < 30) then n24 := 2
        else n24 := 20;
      end else n24 := 50;
      n1C := 0;
      while (True) do begin
        if not Cert.m_PEnvir.CanWalk(Cert.m_nCurrX, Cert.m_nCurrY, False) or not Cert.m_PEnvir.CanWalkOfEvent(Cert, Cert.m_nCurrX, Cert.m_nCurrY) then begin
          if (Cert.m_PEnvir.m_nWidth - n24 - 1) > Cert.m_nCurrX then begin
            Inc(Cert.m_nCurrX, n20);
          end else begin
            Cert.m_nCurrX := Random(Cert.m_PEnvir.m_nWidth div 2) + n24;
            if Cert.m_PEnvir.m_nHeight - n24 - 1 > Cert.m_nCurrY then begin
              Inc(Cert.m_nCurrY, n20);
            end else begin
              Cert.m_nCurrY := Random(Cert.m_PEnvir.m_nHeight div 2) + n24;
            end;
          end;
        end else begin
          p28 := Cert.m_PEnvir.AddToMap(Cert.m_nCurrX, Cert.m_nCurrY, Cert);
          Break;
        end;
        Inc(n1C);
        if n1C >= 31 then Break;
      end;
      if p28 = nil then begin
        FreeAndNil(Cert);
      end else begin
        Inc(Cert.m_nViewRange, 2); //2006-12-30 怪物视觉+2
      end;
    end;
  end;
  Result := Cert;
end;

function TUserEngine.FindAILogon(sCharName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  m_UserLogonList.Lock;
  try
    for I := 0 to m_UserLogonList.Count - 1 do begin
      if CompareText(m_UserLogonList.Strings[I], sCharName) = 0 then begin
        Result := True;
        break;
      end;
    end;
  finally
    m_UserLogonList.UnLock;
  end;
end;

procedure TUserEngine.AddAILogon(aAI: pTAILogon);
var
  AI: pTAILogon;
begin
  m_UserLogonList.Lock;
  try
    New(AI);
    AI^ := aAI^;
    m_UserLogonList.AddObject(AI.sCharName, TObject(AI));
  finally
    m_UserLogonList.UnLock;
  end;
end;

procedure TUserEngine.DelAILogon(sCharName: string);
var
  I: Integer;
  AI: pTAILogon;
begin
  m_UserLogonList.Lock;
  try
    for I := 0 to m_UserLogonList.Count - 1 do begin
      if CompareText(m_UserLogonList.Strings[I], sCharName) = 0 then begin
        AI := pTAILogon(m_UserLogonList.Objects[I]);
        m_UserLogonList.Delete(I);
        Dispose(AI);
        break;
      end;
    end;
  finally
    m_UserLogonList.UnLock;
  end;
end;

function TUserEngine.RegenAIObject(AI: pTAILogon): Boolean;
var
  PlayObject: TPlayObject;
begin
  Result := False;
  if GetPlayObject(AI.sCharName) = nil then begin
    PlayObject := AddAIPlayObject(AI);
    if PlayObject <> nil then begin
      PlayObject.AddMapCount;
      PlayObject.m_sHomeMap := GetHomeInfo(PlayObject.m_nHomeX, PlayObject.m_nHomeY);
      m_PlayObjectList.AddObject(PlayObject.m_sCharName, PlayObject);
      Result := True;
    end;
  end;
end;


//====================================================
//功能:创建怪物对象
//返回值：在指定时间内创建完对象，则返加TRUE，如果超过指定时间则返回FALSE
//====================================================

function TUserEngine.RegenMonsters(MonGen: pTMonGenInfo; nCount: Integer): Boolean;
var
  dwStartTick: LongWord;
  nCode: Integer;
  nX: Integer;
  nY: Integer;
  I: Integer;
  Cert: TActorObject;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::RegenMonsters';
begin
  Result := True;
  nCode := 0;
  dwStartTick := GetTickCount();
  try
    nCode := 1;
    if MonGen <> nil then begin
      nCode := 2;
      if MonGen.nRace > 0 then begin
        nCode := 3;
        if Random(100) < MonGen.nMissionGenRate then begin
          nCode := 4;
          nX := (MonGen.nX - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
          nY := (MonGen.nY - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
          nCode := 5;
          for I := 0 to nCount - 1 do begin
            nCode := 6;
            Cert := AddBaseObject(nil, MonGen.sMapName, ((nX - 10) + Random(20)), ((nY - 10) + Random(20)), MonGen.nRace, MonGen.sMonName);
            nCode := 7;
            if Cert <> nil then begin
              nCode := 8;
              Cert.m_nChangeColorType := MonGen.nChangeColorType; //是否变色
              nCode := 9;
              MonGen.CertList.Add(Cert);
              Cert.AddMapCount;
            end;
            nCode := 10;
            if (GetTickCount - dwStartTick) > g_dwZenLimit then begin
              Result := False;
              Break;
            end;
          end;
        end else begin
          for I := 0 to nCount - 1 do begin
            nCode := 11;
            nX := (MonGen.nX - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
            nY := (MonGen.nY - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
            nCode := 12;
            Cert := AddBaseObject(nil, MonGen.sMapName, nX, nY, MonGen.nRace, MonGen.sMonName);
            nCode := 13;
            if Cert <> nil then begin
              nCode := 14;
              Cert.m_nChangeColorType := MonGen.nChangeColorType; //是否变色
              nCode := 15;
              MonGen.CertList.Add(Cert);
              Cert.AddMapCount;
              nCode := 16;
            end;
            if (GetTickCount - dwStartTick) > g_dwZenLimit then begin
              Result := False;
              Break;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg + ' Code:' + IntToStr(nCode));
  end;
end;

function TUserEngine.GetPlayObject(sName: string): TPlayObject;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  Result := nil;
  if sName <> '' then begin
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      if CompareText(m_PlayObjectList.Strings[I], sName) = 0 then begin
        PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
        if (not PlayObject.m_boGhost) then begin
          if not (PlayObject.m_boPasswordLocked and PlayObject.m_boObMode and PlayObject.m_boAdminMode) then
            Result := PlayObject;
        end;
        Break;
      end;
    end;
  end;
end;

function TUserEngine.GetPlayObject(PlayObject: TActorObject): TPlayObject;
var
  I: Integer;
begin
  Result := nil;
  if PlayObject = nil then Exit;
  for I := 0 to m_PlayObjectList.Count - 1 do begin
    if (PlayObject = TPlayObject(m_PlayObjectList.Objects[I])) then begin
      Result := TPlayObject(m_PlayObjectList.Objects[I]);
      Break;
    end;
  end;
end;

function TUserEngine.GetHeroObject(sName: string): THeroObject;
var
  I: Integer;
begin
  Result := nil;
  m_HeroObjectList.Lock;
  try
    for I := 0 to m_HeroObjectList.Count - 1 do begin
      if (CompareText(m_HeroObjectList.Strings[I], sName) = 0) then begin
        Result := THeroObject(m_HeroObjectList.Objects[I]);
        Break;
      end;
    end;
  finally
    m_HeroObjectList.UnLock;
  end;
end;

procedure TUserEngine.KickPlayObjectEx(sAccount, sName: string);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    if (sAccount <> '') and (sName <> '') then begin
      for I := 0 to m_PlayObjectList.Count - 1 do begin
        PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
        if (CompareText(PlayObject.m_sUserID, sAccount) = 0) and
          (CompareText(m_PlayObjectList.Strings[I], sName) = 0) then begin
          PlayObject.m_boEmergencyClose := True;
          PlayObject.m_boPlayOffLine := False;
          Break;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TUserEngine.GetPlayObjectEx(sAccount, sName: string): TPlayObject;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  Result := nil;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    if (sAccount <> '') and (sName <> '') then begin
      for I := 0 to m_PlayObjectList.Count - 1 do begin
        PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
        if //(not PlayObject.m_boAI) and
          (CompareText(PlayObject.m_sUserID, sAccount) = 0) and
          (CompareText(m_PlayObjectList.Strings[I], sName) = 0) then begin
          Result := PlayObject;
          Break;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TUserEngine.GetPlayObjectExOfAutoGetExp(sAccount: string): TPlayObject; //获取离线挂人物
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  Result := nil;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    if (sAccount <> '') then begin
      for I := 0 to m_PlayObjectList.Count - 1 do begin
        PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
        if {(not PlayObject.m_boAI) and}(CompareText(PlayObject.m_sUserID, sAccount) = 0) and PlayObject.m_boNotOnlineAddExp then begin
          Result := PlayObject;
          Break;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TUserEngine.FindMerchant(Merchant: TObject): TMerchant;
var
  I: Integer;
begin
  Result := nil;
  m_MerchantList.Lock;
  try
    for I := 0 to m_MerchantList.Count - 1 do begin
      if (TObject(m_MerchantList.Items[I]) <> nil) and (TObject(m_MerchantList.Items[I]) = Merchant) then begin
        Result := TMerchant(m_MerchantList.Items[I]);
        Break;
      end;
    end;
  finally
    m_MerchantList.UnLock;
  end;
end;

function TUserEngine.FindNPC(GuildOfficial: TObject): TGuildOfficial;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to QuestNPCList.Count - 1 do begin
    if (TObject(QuestNPCList.Items[I]) <> nil) and (TObject(QuestNPCList.Items[I]) = GuildOfficial) then begin
      Result := TGuildOfficial(QuestNPCList.Items[I]);
      Break;
    end;
  end;
end;

function TUserEngine.GetMapOfRangeHumanCount(Envir: TEnvirnoment; nX, nY,
  nRange: Integer): Integer;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  Result := 0;
  for I := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if PlayObject <> nil then begin
      if not PlayObject.m_boGhost and (PlayObject.m_PEnvir = Envir) then begin
        if (abs(PlayObject.m_nCurrX - nX) < nRange) and (abs(PlayObject.m_nCurrY - nY) < nRange) then Inc(Result);
      end;
    end;
  end;
end;

function TUserEngine.GetHumPermission(sUserName: string; var sIPaddr: string; var btPermission: Byte): Boolean; //4AE590
var
  I: Integer;
  AdminInfo: pTAdminInfo;
begin
  Result := False;
  btPermission := g_Config.nStartPermission;
  m_AdminList.Lock;
  try
    for I := 0 to m_AdminList.Count - 1 do begin
      AdminInfo := m_AdminList.Items[I];
      if AdminInfo <> nil then begin
        if CompareText(AdminInfo.sChrName, sUserName) = 0 then begin
          btPermission := AdminInfo.nLv;
          sIPaddr := AdminInfo.sIPaddr;
          Result := True;
          Break;
        end;
      end;
    end;
  finally
    m_AdminList.UnLock;
  end;
end;


function TUserEngine.FindHeroOpenInfo(sChrName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  EnterCriticalSection(m_LoadHeroSection);
  try
    for I := 0 to m_LoadHeroList.Count - 1 do begin
      if CompareText(sChrName, m_LoadHeroList.Strings[I]) = 0 then begin
        Result := True;
        Break;
      end;
    end;
  finally
    LeaveCriticalSection(m_LoadHeroSection);
  end;
end;

procedure TUserEngine.AddHeroOpenInfo(UserOpenInfo: pTUserOpenInfo);
begin
  EnterCriticalSection(m_LoadHeroSection);
  try
    m_LoadHeroList.AddObject(UserOpenInfo.sChrName, TObject(UserOpenInfo));
  finally
    LeaveCriticalSection(m_LoadHeroSection);
  end;
end;

procedure TUserEngine.AddUserOpenInfo(UserOpenInfo: pTUserOpenInfo);
begin
  EnterCriticalSection(m_LoadPlaySection);
  try
    m_LoadPlayList.AddObject(UserOpenInfo.sChrName, TObject(UserOpenInfo));
  finally
    LeaveCriticalSection(m_LoadPlaySection);
  end;
end;

procedure TUserEngine.KickOnlineUser(sChrName: string);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  if (sChrName <> '') then begin
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if PlayObject <> nil then begin
        if CompareText(PlayObject.m_sCharName, sChrName) = 0 then begin
          PlayObject.m_boKickFlag := True;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TUserEngine.SaveHumanRcd(PlayObject: TPlayObject);
var
  SaveRcd: pTSaveRcd;
begin
  if not PlayObject.m_boAI then begin
    New(SaveRcd);
    FillChar(SaveRcd^, SizeOf(TSaveRcd), #0);
    SaveRcd.sAccount := PlayObject.m_sUserID;
    SaveRcd.sChrName := PlayObject.m_sCharName;
    SaveRcd.nSessionID := PlayObject.m_nSessionID;
    SaveRcd.PlayObject := PlayObject;
    SaveRcd.nReTryCount := 0;
    SaveRcd.dwSaveTick := GetTickCount;
    PlayObject.MakeSaveRcd(SaveRcd.HumanRcd);
    FrontEngine.AddToSaveRcdList(SaveRcd);
  end;
end;

procedure TUserEngine.SaveHeroRcd(HeroObject: THeroObject);
var
  SaveRcd: pTSaveRcd;
begin
  if not HeroObject.m_boAI then begin
    New(SaveRcd);
    FillChar(SaveRcd^, SizeOf(TSaveRcd), #0);
    SaveRcd.sAccount := HeroObject.m_sUserID;
    SaveRcd.sChrName := HeroObject.m_sCharName;
    SaveRcd.nSessionID := HeroObject.m_nSessionID;
    SaveRcd.dwSaveTick := GetTickCount;
    SaveRcd.PlayObject := HeroObject;
    HeroObject.MakeSaveRcd(SaveRcd.HumanRcd);
    FrontEngine.AddToSaveHeroRcdList(SaveRcd);
  end;
end;

procedure TUserEngine.AddToHumanFreeList(PlayObject: TPlayObject);
begin
  PlayObject.m_dwGhostTick := GetTickCount();
  m_PlayObjectFreeList.Add(PlayObject);
end;

procedure TUserEngine.AddToHeroFreeList(HeroObject: THeroObject);
begin
  HeroObject.m_dwGhostTick := GetTickCount();
  m_HeroObjectFreeList.Add(HeroObject);
end;

procedure TUserEngine.GetHumData(PlayObject: TPlayObject;
  var HumanRcd: THumDataInfo);
var
  HumData: pTHumData;
  HumItems: pTHumItems;
  HumAddItems: pTHumAddItems;
  BagItems: pTBagItems;
  UserItem: pTUserItem;
  HumMagics: pTHumMagics;
  UserMagic: pTUserMagic;
  MagicInfo: pTMagic;
  StorageItems: pTStorageItems;
  I: Integer;
begin
  HumData := @HumanRcd.Data;
  PlayObject.m_sCharName := HumData.sChrName;
  PlayObject.m_sMapName := HumData.sCurMap;
  PlayObject.m_nCurrX := HumData.wCurX;
  PlayObject.m_nCurrY := HumData.wCurY;
  PlayObject.m_btDirection := HumData.btDir;
  PlayObject.m_btHair := HumData.btHair;
  PlayObject.m_btGender := HumData.btSex;
  PlayObject.m_btJob := HumData.btJob;
  PlayObject.m_nGold := HumData.nGold;

  case PlayObject.m_btGender of
    0: begin
        if not PlayObject.m_btHair in [0, 2] then PlayObject.m_btHair := 2;
      end;
    1: begin
        if not PlayObject.m_btHair in [1, 3] then begin
          case Random(2) of
            0: PlayObject.m_btHair := 1;
            1: PlayObject.m_btHair := 3;
          else PlayObject.m_btHair := 0;
          end;
        end;
      end;
  end;

  PlayObject.m_sLastMapName := PlayObject.m_sMapName; //2006-01-12增加人物上次退出地图
  PlayObject.m_nLastCurrX := PlayObject.m_nCurrX; //2006-01-12增加人物上次退出所在座标X
  PlayObject.m_nLastCurrY := PlayObject.m_nCurrY; //2006-01-12增加人物上次退出所在座标Y

  PlayObject.m_Abil.Level := HumData.Abil.Level;

  PlayObject.m_Abil.HP := HumData.Abil.HP;
  PlayObject.m_Abil.MP := HumData.Abil.MP;
  PlayObject.m_Abil.MaxHP := HumData.Abil.MaxHP;
  PlayObject.m_Abil.MaxMP := HumData.Abil.MaxMP;
  PlayObject.m_Abil.Exp := HumData.Abil.Exp;
  PlayObject.m_Abil.MaxExp := HumData.Abil.MaxExp;
  PlayObject.m_Abil.Weight := HumData.Abil.Weight;
  PlayObject.m_Abil.MaxWeight := HumData.Abil.MaxWeight;
  PlayObject.m_Abil.WearWeight := HumData.Abil.WearWeight;
  PlayObject.m_Abil.MaxWearWeight := HumData.Abil.MaxWearWeight;
  PlayObject.m_Abil.HandWeight := HumData.Abil.HandWeight;
  PlayObject.m_Abil.MaxHandWeight := HumData.Abil.MaxHandWeight;
  if PlayObject.m_Abil.Exp <= 0 then PlayObject.m_Abil.Exp := 1;
  if PlayObject.m_Abil.MaxExp <= 0 then begin
    PlayObject.m_Abil.MaxExp := PlayObject.GetLevelExp(PlayObject.m_Abil.Level);
  end;
  //PlayObject.m_Abil:=HumData.Abil;

  PlayObject.m_wStatusTimeArr := HumData.wStatusTimeArr;
  PlayObject.m_sHomeMap := HumData.sHomeMap;
  PlayObject.m_nHomeX := HumData.wHomeX;
  PlayObject.m_nHomeY := HumData.wHomeY;
  PlayObject.m_BonusAbil := HumData.BonusAbil; // 08/09
  PlayObject.m_nBonusPoint := HumData.nBonusPoint; // 08/09
  PlayObject.m_btCreditPoint := HumData.btCreditPoint;
  PlayObject.m_btReLevel := HumData.btReLevel;
  PlayObject.m_boOnHorse := HumData.boOnHorse;

  PlayObject.m_sMasterName := HumData.sMasterName;
  PlayObject.m_boMaster := HumData.boMaster;
  PlayObject.m_sDearName := HumData.sDearName;

  PlayObject.m_sStoragePwd := HumData.sStoragePwd;
  if PlayObject.m_sStoragePwd <> '' then
    PlayObject.m_boPasswordLocked := True;

  PlayObject.m_nGameGold := HumData.nGameGold;
  PlayObject.m_nGamePoint := HumData.nGamePoint;
  PlayObject.m_nPayMentPoint := HumData.nPayMentPoint;

  PlayObject.m_nPkPoint := HumData.nPKPOINT;
  if HumData.btAllowGroup > 0 then PlayObject.m_boAllowGroup := True
  else PlayObject.m_boAllowGroup := False;
  PlayObject.btB2 := HumData.btF9;
  PlayObject.m_btAttatckMode := HumData.btAttatckMode;
  PlayObject.m_nIncHealth := HumData.btIncHealth;
  PlayObject.m_nIncSpell := HumData.btIncSpell;
  PlayObject.m_nIncHealing := HumData.btIncHealing;
  PlayObject.m_nFightZoneDieCount := HumData.btFightZoneDieCount;
  PlayObject.m_sUserID := HumData.sAccount;
  PlayObject.nC4 := HumData.btEE;
  PlayObject.m_boLockLogon := HumData.boLockLogon;

  PlayObject.m_wContribution := HumData.wContribution;
  //PlayObject.btC8 := HumData.btEF;
  PlayObject.m_nHungerStatus := HumData.nHungerStatus;
  PlayObject.m_boAllowGuildReCall := HumData.boAllowGuildReCall;
  PlayObject.m_wGroupRcallTime := HumData.wGroupRcallTime;
  PlayObject.m_dBodyLuck := HumData.dBodyLuck;
  PlayObject.m_boAllowGroupReCall := HumData.boAllowGroupReCall;
  {PlayObject.m_QuestUnitOpen := HumData.QuestUnitOpen;
  PlayObject.m_QuestUnit := HumData.QuestUnit; }
  PlayObject.m_btLastOutStatus := HumData.btLastOutStatus; //退出状态 1为死亡
  PlayObject.m_wMasterCount := HumData.wMasterCount; //出师徒弟数

  PlayObject.m_QuestFlag := HumData.QuestFlag;
  PlayObject.m_boHasHero := HumData.boHasHero;
  PlayObject.m_sHeroCharName := HumData.sHeroChrName;
  PlayObject.m_nGrudge := HumData.nGrudge;

  PlayObject.m_nStatusDelayTime := HumData.wStatusDelayTime;

  PlayObject.m_NewStatus := HumData.NewStatus; //1失明 2混乱 状态

  HumItems := @HumanRcd.Data.HumItems;
  PlayObject.m_UseItems[U_DRESS] := HumItems[U_DRESS];
  PlayObject.m_UseItems[U_WEAPON] := HumItems[U_WEAPON];
  PlayObject.m_UseItems[U_RIGHTHAND] := HumItems[U_RIGHTHAND];
  PlayObject.m_UseItems[U_NECKLACE] := HumItems[U_HELMET];
  PlayObject.m_UseItems[U_HELMET] := HumItems[U_NECKLACE];
  PlayObject.m_UseItems[U_ARMRINGL] := HumItems[U_ARMRINGL];
  PlayObject.m_UseItems[U_ARMRINGR] := HumItems[U_ARMRINGR];
  PlayObject.m_UseItems[U_RINGL] := HumItems[U_RINGL];
  PlayObject.m_UseItems[U_RINGR] := HumItems[U_RINGR];

  HumAddItems := @HumanRcd.Data.HumAddItems;
  PlayObject.m_UseItems[U_BUJUK] := HumAddItems[U_BUJUK];
  PlayObject.m_UseItems[U_BELT] := HumAddItems[U_BELT];
  PlayObject.m_UseItems[U_BOOTS] := HumAddItems[U_BOOTS];
  PlayObject.m_UseItems[U_CHARM] := HumAddItems[U_CHARM];

  BagItems := @HumanRcd.Data.BagItems;
  for I := Low(TBagItems) to High(TBagItems) do begin
    if BagItems[I].wIndex > 0 then begin
      New(UserItem);
      UserItem^ := BagItems[I];
      PlayObject.m_ItemList.Add(UserItem);
    end;
  end;

  HumMagics := @HumanRcd.Data.HumMagics;
  for I := Low(THumMagics) to High(THumMagics) do begin
    MagicInfo := FindMagic(HumMagics[I].wMagIdx);
    if MagicInfo <> nil then begin
      New(UserMagic);
      UserMagic.MagicInfo := MagicInfo;
      UserMagic.wMagIdx := HumMagics[I].wMagIdx;
      UserMagic.btLevel := HumMagics[I].btLevel;
      UserMagic.btKey := HumMagics[I].btKey;
      UserMagic.nTranPoint := HumMagics[I].nTranPoint;
      PlayObject.m_MagicList.Add(UserMagic);
    end;
  end;

  StorageItems := @HumanRcd.Data.StorageItems;
  for I := Low(TStorageItems) to High(TStorageItems) do begin
    if StorageItems[I].wIndex > 0 then begin
      if (StorageItems[I].AddValue[0] = 1) and (GetDayCount(StorageItems[I].MaxDate, Now) <= 0) then Continue; //删除到期的装备
      New(UserItem);
      UserItem^ := StorageItems[I];
      PlayObject.m_StorageItemList.Add(UserItem);
    end;
  end;
end;

procedure TUserEngine.GetHeroData(HeroObject: THeroObject;
  var HumanRcd: THumDataInfo);
var
  I: Integer;
  HumData: pTHumData;
  HumItems: pTHumItems;
  HumAddItems: pTHumAddItems;
  BagItems: pTBagItems;
  UserItem: pTUserItem;
  HumMagics: pTHumMagics;
  UserMagic: pTUserMagic;
  MagicInfo: pTMagic;
begin
  HumData := @HumanRcd.Data;
  HeroObject.m_sCharName := HumData.sChrName;
  HeroObject.m_sMapName := HumData.sCurMap;
  HeroObject.m_nCurrX := HumData.wCurX;
  HeroObject.m_nCurrY := HumData.wCurY;
  HeroObject.m_btDirection := HumData.btDir;
  HeroObject.m_btHair := HumData.btHair;
  HeroObject.m_btGender := HumData.btSex;
  HeroObject.m_btJob := HumData.btJob;

  case HeroObject.m_btGender of
    0: begin
        if not HeroObject.m_btHair in [0, 2] then HeroObject.m_btHair := 2;
      end;
    1: begin
        if not HeroObject.m_btHair in [0, 1, 3] then begin
          case Random(2) of
            0: HeroObject.m_btHair := 1;
            1: HeroObject.m_btHair := 3;
          else HeroObject.m_btHair := 0;
          end;
        end;
      end;
  end;
  //PlayObject.m_nGold := HumData.nGold;

  //HeroObject.m_sLastMapName := PlayObject.m_sMapName; //2006-01-12增加人物上次退出地图
  //HeroObject.m_nLastCurrX := HeroObject.m_nCurrX; //2006-01-12增加人物上次退出所在座标X
  //HeroObject.m_nLastCurrY := HeroObject.m_nCurrY; //2006-01-12增加人物上次退出所在座标Y

  HeroObject.m_Abil.Level := HumData.Abil.Level;

  HeroObject.m_Abil.HP := HumData.Abil.HP;
  HeroObject.m_Abil.MP := HumData.Abil.MP;
  HeroObject.m_Abil.MaxHP := HumData.Abil.MaxHP;
  HeroObject.m_Abil.MaxMP := HumData.Abil.MaxMP;
  HeroObject.m_Abil.Exp := HumData.Abil.Exp;
  HeroObject.m_Abil.MaxExp := HumData.Abil.MaxExp;
  HeroObject.m_Abil.Weight := HumData.Abil.Weight;
  HeroObject.m_Abil.MaxWeight := HumData.Abil.MaxWeight;
  HeroObject.m_Abil.WearWeight := HumData.Abil.WearWeight;
  HeroObject.m_Abil.MaxWearWeight := HumData.Abil.MaxWearWeight;
  HeroObject.m_Abil.HandWeight := HumData.Abil.HandWeight;
  HeroObject.m_Abil.MaxHandWeight := HumData.Abil.MaxHandWeight;
  {if HeroObject.m_Abil.Exp <= 0 then HeroObject.m_Abil.Exp := 1;
  if HeroObject.m_Abil.MaxExp <= 0 then begin
    HeroObject.m_Abil.MaxExp := HeroObject.GetLevelExp(HeroObject.m_Abil.Level);
  end;}
  //PlayObject.m_Abil:=HumData.Abil;

  HeroObject.m_wStatusTimeArr := HumData.wStatusTimeArr;
  HeroObject.m_sHomeMap := HumData.sHomeMap;
  HeroObject.m_nHomeX := HumData.wHomeX;
  HeroObject.m_nHomeY := HumData.wHomeY;
  //HeroObject.m_BonusAbil := HumData.BonusAbil; // 08/09
  //HeroObject.m_nBonusPoint := HumData.nBonusPoint; // 08/09
  HeroObject.m_btCreditPoint := HumData.btCreditPoint;
  HeroObject.m_btReLevel := HumData.btReLevel;

  //HeroObject.m_sMasterName := m_Master.;
  //HeroObject.m_boMaster := HumData.boMaster;
  //HeroObject.m_sDearName := HumData.sDearName;

  {HeroObject.m_sStoragePwd := HumData.sStoragePwd;
  if PlayObject.m_sStoragePwd <> '' then
    PlayObject.m_boPasswordLocked := True; }

  {PlayObject.m_nGameGold := HumData.nGameGold;
  PlayObject.m_nGamePoint := HumData.nGamePoint;
  PlayObject.m_nPayMentPoint := HumData.nPayMentPoint; }

  HeroObject.m_nPkPoint := HumData.nPKPOINT;
  {if HumData.btAllowGroup > 0 then PlayObject.m_boAllowGroup := True
  else PlayObject.m_boAllowGroup := False; }
  HeroObject.btB2 := HumData.btF9;
  HeroObject.m_btAttatckMode := HumData.btAttatckMode;
  HeroObject.m_nIncHealth := HumData.btIncHealth;
  HeroObject.m_nIncSpell := HumData.btIncSpell;
  HeroObject.m_nIncHealing := HumData.btIncHealing;
  HeroObject.m_nFightZoneDieCount := HumData.btFightZoneDieCount;
  HeroObject.m_sUserID := HumData.sAccount;
  //HeroObject.nC4 := HumData.btEE;
  //HeroObject.m_boLockLogon := HumData.boLockLogon;

  //HeroObject.m_wContribution := HumData.wContribution;
  //HeroObject.btC8 := HumData.btEF;
  //HeroObject.m_nHungerStatus := HumData.nHungerStatus;
  //HeroObject.m_boAllowGuildReCall := HumData.boAllowGuildReCall;
  //HeroObject.m_wGroupRcallTime := HumData.wGroupRcallTime;
  HeroObject.m_dBodyLuck := HumData.dBodyLuck;
  //HeroObject.m_boAllowGroupReCall := HumData.boAllowGroupReCall;

  HeroObject.m_btLastOutStatus := HumData.btLastOutStatus; //退出状态 1为死亡
  //PlayObject.m_wMasterCount := HumData.wMasterCount; //出师徒弟数

  HeroObject.m_QuestFlag := HumData.QuestFlag;
  //HeroObject.m_boHasHero := HumData.boHasHero;
  HeroObject.m_btStatus := HumData.btStatus;

  HeroObject.m_nGrudge := HumData.nGrudge;


  HeroObject.m_nStatusDelayTime := HumData.wStatusDelayTime;

  HeroObject.m_NewStatus := HumData.NewStatus; //失明状态   混乱状态


  HumItems := @HumanRcd.Data.HumItems;

  HeroObject.m_UseItems[U_DRESS] := HumItems[U_DRESS];
  HeroObject.m_UseItems[U_WEAPON] := HumItems[U_WEAPON];
  HeroObject.m_UseItems[U_RIGHTHAND] := HumItems[U_RIGHTHAND];
  HeroObject.m_UseItems[U_NECKLACE] := HumItems[U_HELMET];
  HeroObject.m_UseItems[U_HELMET] := HumItems[U_NECKLACE];
  HeroObject.m_UseItems[U_ARMRINGL] := HumItems[U_ARMRINGL];
  HeroObject.m_UseItems[U_ARMRINGR] := HumItems[U_ARMRINGR];
  HeroObject.m_UseItems[U_RINGL] := HumItems[U_RINGL];
  HeroObject.m_UseItems[U_RINGR] := HumItems[U_RINGR];

  HumAddItems := @HumanRcd.Data.HumAddItems;
  HeroObject.m_UseItems[U_BUJUK] := HumAddItems[U_BUJUK];
  HeroObject.m_UseItems[U_BELT] := HumAddItems[U_BELT];
  HeroObject.m_UseItems[U_BOOTS] := HumAddItems[U_BOOTS];
  HeroObject.m_UseItems[U_CHARM] := HumAddItems[U_CHARM];

  BagItems := @HumanRcd.Data.BagItems;
  for I := Low(TBagItems) to High(TBagItems) do begin
    if BagItems[I].wIndex > 0 then begin
      New(UserItem);
      UserItem^ := BagItems[I];
      HeroObject.m_ItemList.Add(UserItem);
    end;
  end;
  
  HumMagics := @HumanRcd.Data.HumMagics;
  for I := Low(THumMagics) to High(THumMagics) do begin
    MagicInfo := FindHeroMagic(HumMagics[I].wMagIdx);
    if MagicInfo <> nil then begin
      New(UserMagic);
      UserMagic.MagicInfo := MagicInfo;
      UserMagic.wMagIdx := HumMagics[I].wMagIdx;
      UserMagic.btLevel := HumMagics[I].btLevel;
      UserMagic.btKey := HumMagics[I].btKey;
      UserMagic.nTranPoint := HumMagics[I].nTranPoint;
      HeroObject.m_MagicList.Add(UserMagic);
    end;
  end;
end;

function TUserEngine.GetHomeInfo(var nX, nY: Integer): string;
var
  I: Integer;
  nXY: Integer;
begin
  if g_StartPointList.Count > 0 then begin
    if g_StartPointList.Count > g_Config.nStartPointSize {1} then I := Random(g_Config.nStartPointSize {2})
    else I := 0;
    Result := GetStartPointInfo(I, nX, nY); //g_StartPointList.Strings[i];
  end else begin
    Result := g_Config.sHomeMap;
    nX := g_Config.nHomeX;
    nX := g_Config.nHomeY;
  end;
end;

function TUserEngine.GetRandHomeX(PlayObject: TPlayObject): Integer;
begin
  Result := Random(3) + (PlayObject.m_nHomeX - 2);
end;

function TUserEngine.GetRandHomeY(PlayObject: TPlayObject): Integer;
begin
  Result := Random(3) + (PlayObject.m_nHomeY - 2);
end;

function TUserEngine.GetMagicName(nMagIdx: Integer): string;
var
  I: Integer;
  Magic: pTMagic;
  MagicList: TList;
begin
  Result := '';
  if (m_boStartLoadMagic) and (OldMagicList.Count > 0) then begin
    MagicList := TList(OldMagicList.Items[OldMagicList.Count - 1]);
    if MagicList <> nil then begin
      for I := 0 to MagicList.Count - 1 do begin
        Magic := MagicList.Items[I];
        if (Magic <> nil) and (Magic.sDescr = '') then begin
          if Magic.wMagicId = nMagIdx then begin
            Result := Magic.sMagicName;
            Break;
          end;
        end;
      end;
    end;
  end else begin
    for I := 0 to m_MagicList.Count - 1 do begin
      Magic := m_MagicList.Items[I];
      if (Magic <> nil) and (Magic.sDescr = '') then begin
        if Magic.wMagicId = nMagIdx then begin
          Result := Magic.sMagicName;
          Break;
        end;
      end;
    end;
  end;
end;

function TUserEngine.FindMagic(nMagIdx: Integer): pTMagic;
var
  I: Integer;
  Magic: pTMagic;
  MagicList: TList;
begin
  Result := nil;
  if (m_boStartLoadMagic) and (OldMagicList.Count > 0) then begin
    MagicList := TList(OldMagicList.Items[OldMagicList.Count - 1]);
    if MagicList <> nil then begin
      for I := 0 to MagicList.Count - 1 do begin
        Magic := MagicList.Items[I];
        if (Magic <> nil) and (Magic.sDescr = '') then begin
          if Magic.wMagicId = nMagIdx then begin
            Result := Magic;
            Break;
          end;
        end;
      end;
    end;
  end else begin
    for I := 0 to m_MagicList.Count - 1 do begin
      Magic := m_MagicList.Items[I];
      if (Magic <> nil) and (Magic.sDescr = '') then begin
        if Magic.wMagicId = nMagIdx then begin
          Result := Magic;
          Break;
        end;
      end;
    end;
  end;
end;

function TUserEngine.FindHeroMagic(nMagIdx: Integer): pTMagic;
var
  I: Integer;
  Magic: pTMagic;
  MagicList: TList;
begin
  Result := nil;
  if (m_boStartLoadMagic) and (OldMagicList.Count > 0) then begin
    MagicList := TList(OldMagicList.Items[OldMagicList.Count - 1]);
    if MagicList <> nil then begin
      for I := 0 to MagicList.Count - 1 do begin
        Magic := MagicList.Items[I];
        if (Magic <> nil) and (Magic.sDescr = 'HeroOnly') then begin
          if Magic.wMagicId = nMagIdx then begin
            Result := Magic;
            Break;
          end;
        end;
      end;
    end;
  end else begin
    for I := 0 to m_MagicList.Count - 1 do begin
      Magic := m_MagicList.Items[I];
      if (Magic <> nil) and (Magic.sDescr = 'HeroOnly') then begin
        if Magic.wMagicId = nMagIdx then begin
          Result := Magic;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TUserEngine.MonInitialize(BaseObject: TActorObject; sMonName: string);
var
  I: Integer;
  Monster: pTMonInfo;
begin
  for I := 0 to MonsterList.Count - 1 do begin
    Monster := MonsterList.Items[I];
    if Monster <> nil then begin
      if (CompareText(Monster.sName, sMonName) = 0) and (BaseObject <> nil) then begin
        BaseObject.m_btRaceServer := Monster.btRace;
        BaseObject.m_btRaceImg := Monster.btRaceImg;
        BaseObject.m_wAppr := Monster.wAppr;
        BaseObject.m_Abil.Level := Monster.wLevel;
        BaseObject.m_btLifeAttrib := Monster.btLifeAttrib;
        BaseObject.m_btCoolEye := Monster.wCoolEye;
        BaseObject.m_dwFightExp := Monster.dwExp;
        BaseObject.m_Abil.HP := Monster.wHP;
        BaseObject.m_Abil.MaxHP := Monster.wHP;
        BaseObject.m_btMonsterWeapon := LoByte(Monster.wMP);
        //BaseObject.m_Abil.MP:=Monster.wMP;
        BaseObject.m_Abil.MP := 0;
        BaseObject.m_Abil.MaxMP := Monster.wMP;
        BaseObject.m_Abil.AC := MakeLong(Monster.wAC, Monster.wAC);
        BaseObject.m_Abil.MAC := MakeLong(Monster.wMAC, Monster.wMAC);
        BaseObject.m_Abil.DC := MakeLong(Monster.wDC, Monster.wMaxDC);
        BaseObject.m_Abil.MC := MakeLong(Monster.wMC, Monster.wMC);
        BaseObject.m_Abil.SC := MakeLong(Monster.wSC, Monster.wSC);
        BaseObject.m_btSpeedPoint := Monster.wSpeed;
        BaseObject.m_btHitPoint := Monster.wHitPoint;
        BaseObject.m_nWalkSpeed := Monster.wWalkSpeed;
        BaseObject.m_nWalkStep := Monster.wWalkStep;
        BaseObject.m_dwWalkWait := Monster.wWalkWait;
        BaseObject.m_nNextHitTime := Monster.wAttackSpeed;
        Break;
      end;
    end;
  end;
end;

function TUserEngine.OpenDoor(Envir: TEnvirnoment; nX,
  nY: Integer): Boolean;
var
  DoorObject: TDoorObject;
begin
  Result := False;
  DoorObject := Envir.GetDoor(nX, nY);
  if (DoorObject <> nil) and not DoorObject.m_Status.boOpened and not DoorObject.m_Status.bo01 then begin
    DoorObject.m_Status.boOpened := True;
    DoorObject.m_Status.dwOpenTick := GetTickCount();
    SendDoorStatus(Envir, nX, nY, RM_DOOROPEN, 0, nX, nY, 0, '');
    Result := True;
  end;
end;

function TUserEngine.CloseDoor(Envir: TEnvirnoment; Door: TDoorObject): Boolean;
begin
  Result := False;
  if (Door <> nil) and (Door.m_Status.boOpened) then begin
    Door.m_Status.boOpened := False;
    SendDoorStatus(Envir, Door.m_nMapX, Door.m_nMapY, RM_DOORCLOSE, 0, Door.m_nMapX, Door.m_nMapY, 0, '');
    Result := True;
  end;
end;

procedure TUserEngine.SendDoorStatus(Envir: TEnvirnoment; nX, nY: Integer;
  wIdent, wX: Word; nDoorX, nDoorY, nA: Integer; sStr: string);
var
  I: Integer;
  n10, n14: Integer;
  n1C, n20, n24, n28: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  ActorObject: TActorObject;
begin
  n1C := nX - 12;
  n24 := nX + 12;
  n20 := nY - 12;
  n28 := nY + 12;
  if Envir <> nil then begin
    for n10 := n1C to n24 do begin
      for n14 := n20 to n28 do begin
        if Envir.GetMapCellInfo(n10, n14, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
            if BaseObject.m_ObjType = t_Actor then begin
              ActorObject := TActorObject(MapCellInfo.ObjList.Items[I]);
              if (ActorObject <> nil) and
                (not ActorObject.m_boGhost) and
                (ActorObject.m_btRaceServer = RC_PLAYOBJECT) then begin
                ActorObject.SendMsg(ActorObject, wIdent, wX, nDoorX, nDoorY, nA, sStr);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TUserEngine.ProcessMapDoor;
var
  I: Integer;
  II: Integer;
  Envir: TEnvirnoment;
  Door: TDoorObject;
begin
  for I := 0 to g_MapManager.Count - 1 do begin
    Envir := TEnvirnoment(g_MapManager.Items[I]);
    if Envir <> nil then begin
      for II := 0 to Envir.m_DoorList.Count - 1 do begin
        Door := TDoorObject(Envir.m_DoorList.Items[II]);
        if Door <> nil then begin
          if Door.m_Status.boOpened then begin
            if (GetTickCount - Door.m_Status.dwOpenTick) > 5 * 1000 then
              CloseDoor(Envir, Door);
          end;
        end;
      end;
    end;
  end;
end;

procedure TUserEngine.ProcessEvents;
var
  I, II, III: Integer;
  MagicEvent: pTMagicEvent;
  BaseObject: TActorObject;
begin
  for I := m_MagicEventList.Count - 1 downto 0 do begin
    if m_MagicEventList.Count <= 0 then Break;
    MagicEvent := m_MagicEventList.Items[I];
    if (MagicEvent <> nil) and (MagicEvent.BaseObjectList <> nil) then begin
      for II := MagicEvent.BaseObjectList.Count - 1 downto 0 do begin
        BaseObject := TActorObject(MagicEvent.BaseObjectList.Items[II]);
        if BaseObject <> nil then begin
          if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (not BaseObject.m_boHolySeize) then begin
            MagicEvent.BaseObjectList.Delete(II);
          end;
        end;
      end;
      if (MagicEvent.BaseObjectList.Count <= 0) or
        ((GetTickCount - MagicEvent.dwStartTick) > MagicEvent.dwTime) or
        ((GetTickCount - MagicEvent.dwStartTick) > 180000) then begin
        MagicEvent.BaseObjectList.Free;
        III := 0;
        while (True) do begin
          if MagicEvent.Events[III] <> nil then begin
            TEvent(MagicEvent.Events[III]).Close();
          end;
          Inc(III);
          if III >= 8 then Break;
        end;
        m_MagicEventList.Delete(I);
        Dispose(MagicEvent);
      end;
    end;
  end;
end;

function TUserEngine.AddMagic(Magic: pTMagic): Boolean;
var
  UserMagic: pTMagic;
begin
  Result := False;
  New(UserMagic);
  UserMagic.wMagicId := Magic.wMagicId;
  UserMagic.sMagicName := Magic.sMagicName;
  UserMagic.btEffectType := Magic.btEffectType;
  UserMagic.btEffect := Magic.btEffect;
  //UserMagic.bt11 := Magic.bt11;
  UserMagic.wSpell := Magic.wSpell;
  UserMagic.wPower := Magic.wPower;
  UserMagic.TrainLevel := Magic.TrainLevel;
  //UserMagic.w02 := Magic.w02;
  UserMagic.MaxTrain := Magic.MaxTrain;
  UserMagic.btTrainLv := Magic.btTrainLv;
  UserMagic.btJob := Magic.btJob;
  //UserMagic.wMagicIdx := Magic.wMagicIdx;
  UserMagic.dwDelayTime := Magic.dwDelayTime;
  UserMagic.btDefSpell := Magic.btDefSpell;
  UserMagic.btDefPower := Magic.btDefPower;
  UserMagic.wMaxPower := Magic.wMaxPower;
  UserMagic.btDefMaxPower := Magic.btDefMaxPower;
  UserMagic.sDescr := Magic.sDescr;
  m_MagicList.Add(UserMagic);
  Result := True;
end;

function TUserEngine.DelMagic(wMagicId: Word): Boolean;
var
  I: Integer;
  Magic: pTMagic;
begin
  Result := False;
  for I := m_MagicList.Count - 1 downto 0 do begin
    if m_MagicList.Count <= 0 then Break;
    Magic := pTMagic(m_MagicList.Items[I]);
    if Magic <> nil then begin
      if Magic.wMagicId = wMagicId then begin
        Dispose(Magic);
        m_MagicList.Delete(I);
        Result := True;
        Break;
      end;
    end;
  end;
end;

function TUserEngine.FindHeroMagic(sMagicName: string): pTMagic;
var
  I: Integer;
  Magic: pTMagic;
  MagicList: TList;
begin
  Result := nil;
  if (m_boStartLoadMagic) and (OldMagicList.Count > 0) then begin
    MagicList := TList(OldMagicList.Items[OldMagicList.Count - 1]);
    if MagicList <> nil then begin
      for I := 0 to MagicList.Count - 1 do begin
        Magic := MagicList.Items[I];
        if (Magic <> nil) and (Magic.sDescr = 'HeroOnly') then begin
          if CompareText(Magic.sMagicName, sMagicName) = 0 then begin
            Result := Magic;
            Break;
          end;
        end;
      end;
    end;
  end else begin
    for I := 0 to m_MagicList.Count - 1 do begin
      Magic := m_MagicList.Items[I];
      if (Magic <> nil) and (Magic.sDescr = 'HeroOnly') then begin
        if CompareText(Magic.sMagicName, sMagicName) = 0 then begin
          Result := Magic;
          Break;
        end;
      end;
    end;
  end;
end;

function TUserEngine.FindMagic(sMagicName: string): pTMagic;
var
  I: Integer;
  Magic: pTMagic;
  MagicList: TList;
begin
  Result := nil;
  if (m_boStartLoadMagic) and (OldMagicList.Count > 0) then begin
    MagicList := TList(OldMagicList.Items[OldMagicList.Count - 1]);
    if MagicList <> nil then begin
      for I := 0 to MagicList.Count - 1 do begin
        Magic := MagicList.Items[I];
        if (Magic <> nil) and (Magic.sDescr = '') then begin
          if CompareText(Magic.sMagicName, sMagicName) = 0 then begin
            Result := Magic;
            Break;
          end;
        end;
      end;
    end;
  end else begin
    for I := 0 to m_MagicList.Count - 1 do begin
      Magic := m_MagicList.Items[I];
      if (Magic <> nil) and (Magic.sDescr = '') then begin
        if CompareText(Magic.sMagicName, sMagicName) = 0 then begin
          Result := Magic;
          Break;
        end;
      end;
    end;
  end;
end;

function TUserEngine.GetMapRangeMonster(Envir: TEnvirnoment; nX, nY, nRange: Integer; List: TList): Integer;
var
  I, II: Integer;
  MonGen: pTMonGenInfo;
  BaseObject: TActorObject;
begin
  Result := 0;
  if Envir = nil then Exit;
  for I := 0 to m_MonGenList.Count - 1 do begin
    MonGen := m_MonGenList.Items[I];
    if (MonGen.Envir <> nil) and (MonGen.Envir <> Envir) then Continue;
    for II := 0 to MonGen.CertList.Count - 1 do begin
      BaseObject := TActorObject(MonGen.CertList.Items[II]);
      if BaseObject <> nil then begin
        if not BaseObject.m_boDeath and not BaseObject.m_boGhost and (BaseObject.m_PEnvir = Envir) and (abs(BaseObject.m_nCurrX - nX) <= nRange) and (abs(BaseObject.m_nCurrY - nY) <= nRange) then begin
          if List <> nil then List.Add(BaseObject);
          Inc(Result);
        end;
      end;
    end;
  end;
end;

procedure TUserEngine.AddMerchant(Merchant: TMerchant);
begin
  m_MerchantList.Lock;
  try
    Merchant.m_NpcType := n_Merchant;
    m_MerchantList.Add(Merchant);
  finally
    m_MerchantList.UnLock;
  end;
end;

function TUserEngine.GetMerchantList(Envir: TEnvirnoment; nX, nY,
  nRange: Integer; TmpList: TList): Integer;
var
  I: Integer;
  Merchant: TMerchant;
begin
  m_MerchantList.Lock;
  try
    for I := 0 to m_MerchantList.Count - 1 do begin
      Merchant := TMerchant(m_MerchantList.Items[I]);
      if Merchant <> nil then begin
        if (Merchant.m_PEnvir = Envir) and
          (abs(Merchant.m_nCurrX - nX) <= nRange) and
          (abs(Merchant.m_nCurrY - nY) <= nRange) then begin
          TmpList.Add(Merchant);
        end;
      end;
    end; // for
  finally
    m_MerchantList.UnLock;
  end;
  Result := TmpList.Count
end;

function TUserEngine.GetNpcList(Envir: TEnvirnoment; nX, nY,
  nRange: Integer; TmpList: TList): Integer;
var
  I: Integer;
  NPC: TNormNpc;
begin
  for I := 0 to QuestNPCList.Count - 1 do begin
    NPC := TNormNpc(QuestNPCList.Items[I]);
    if NPC <> nil then begin
      if (NPC.m_PEnvir = Envir) and
        (abs(NPC.m_nCurrX - nX) <= nRange) and
        (abs(NPC.m_nCurrY - nY) <= nRange) then begin
        TmpList.Add(NPC);
      end;
    end;
  end; // for
  Result := TmpList.Count
end;

procedure TUserEngine.ReloadMerchantList();
var
  I: Integer;
  Merchant: TMerchant;
begin
  m_MerchantList.Lock;
  try
    for I := 0 to m_MerchantList.Count - 1 do begin
      Merchant := TMerchant(m_MerchantList.Items[I]);
      if Merchant <> nil then begin
        if not Merchant.m_boGhost then begin
          Merchant.ClearScript;
          Merchant.LoadNpcScript;
        end;
      end;
    end; // for
  finally
    m_MerchantList.UnLock;
  end;
end;

procedure TUserEngine.ReloadNpcList();
var
  I: Integer;
  NPC: TNormNpc;
begin
  for I := 0 to QuestNPCList.Count - 1 do begin
    NPC := TNormNpc(QuestNPCList.Items[I]);
    if NPC <> nil then begin
      NPC.ClearScript;
      NPC.LoadNpcScript;
    end;
  end;
end;

function TUserEngine.GetMapMonster(Envir: TEnvirnoment; List: TList): Integer;
var
  I, II: Integer;
  MonGen: pTMonGenInfo;
  BaseObject: TActorObject;
begin
  Result := 0;
  if (Envir = nil) {or (List = nil)} then Exit;
  for I := 0 to m_MonGenList.Count - 1 do begin
    MonGen := m_MonGenList.Items[I];
    for II := 0 to MonGen.CertList.Count - 1 do begin
      BaseObject := TActorObject(MonGen.CertList.Items[II]);
      if BaseObject <> nil then begin
        if not BaseObject.m_boDeath and not BaseObject.m_boGhost and (BaseObject.m_PEnvir = Envir) then begin
          if List <> nil then List.Add(BaseObject);
          Inc(Result);
        end;
      end;
    end;
  end;
end;

function TUserEngine.GetMonsterByName(sMonName: string; List: TList): Integer;
var
  I, II: Integer;
  MonGen: pTMonGenInfo;
  BaseObject: TActorObject;
begin
  Result := 0;
  if (sMonName = '') {or (List = nil)} then Exit;
  for I := 0 to m_MonGenList.Count - 1 do begin
    MonGen := m_MonGenList.Items[I];
    if CompareText(MonGen.sMonName, sMonName) = 0 then begin
      for II := 0 to MonGen.CertList.Count - 1 do begin
        BaseObject := TActorObject(MonGen.CertList.Items[II]);
        if BaseObject <> nil then begin
          if not BaseObject.m_boDeath and not BaseObject.m_boGhost then begin
            if List <> nil then List.Add(BaseObject);
            Inc(Result);
          end;
        end;
      end;
    end;
  end;
end;

procedure TUserEngine.HumanExpire(sAccount: string);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  if not g_Config.boKickExpireHuman then Exit;
  for I := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if PlayObject <> nil then begin
      if CompareText(PlayObject.m_sUserID, sAccount) = 0 then begin
        PlayObject.m_boExpire := True;
        Break;
      end;
    end;
  end;
end;

function TUserEngine.GetMapHuman(sMapName: string): Integer;
var
  I: Integer;
  Envir: TEnvirnoment;
  PlayObject: TPlayObject;
begin
  Result := 0;
  Envir := g_MapManager.FindMap(sMapName);
  if Envir = nil then Exit;
  for I := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if PlayObject <> nil then begin
      if not PlayObject.m_boDeath and not PlayObject.m_boGhost and
        (PlayObject.m_PEnvir = Envir) then
        Inc(Result);
    end;
  end;
end;

function TUserEngine.GetMapHuman(Envir: TEnvirnoment): Integer;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  Result := 0;
  if Envir = nil then Exit;
  for I := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if PlayObject <> nil then begin
      if not PlayObject.m_boDeath and not PlayObject.m_boGhost and
        (PlayObject.m_PEnvir = Envir) then
        Inc(Result);
    end;
  end;
end;

function TUserEngine.GetMapRageHuman(Envir: TEnvirnoment; nRageX,
  nRageY, nRage: Integer; List: TList): Integer;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  Result := 0;
  for I := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if PlayObject <> nil then begin
      if not PlayObject.m_boDeath and
        not PlayObject.m_boGhost and
        (PlayObject.m_PEnvir = Envir) and
        (abs(PlayObject.m_nCurrX - nRageX) <= nRage) and
        (abs(PlayObject.m_nCurrY - nRageY) <= nRage) then begin
        List.Add(PlayObject);
        Inc(Result);
      end;
    end;
  end;
end;

function TUserEngine.GetStdItemIdx(sItemName: string): Integer;
var
  I: Integer;
  StdItem: pTStdItem;
begin
  Result := -1;
  if sItemName = '' then Exit;
  for I := 0 to StdItemList.Count - 1 do begin
    StdItem := StdItemList.Items[I];
    if StdItem <> nil then begin
      if CompareText(StdItem.Name, sItemName) = 0 then begin
        Result := I + 1;
        Break;
      end;
    end;
  end;
end;
//==========================================
//向每个人物发送消息
//线程安全
//==========================================

procedure TUserEngine.SendBroadCastMsgExt(sMsg: string; MsgType: TMsgType);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if (PlayObject <> nil) and (not PlayObject.m_boGhost) and (not PlayObject.m_boNotOnlineAddExp) and (not PlayObject.m_boAI) then begin
        PlayObject.SysMsg(sMsg, c_Red, MsgType);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

procedure TUserEngine.SendBroadCastMsg(sMsg: string; MsgType: TMsgType);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  for I := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if (PlayObject <> nil) and (not PlayObject.m_boGhost) and (not PlayObject.m_boNotOnlineAddExp) and (not PlayObject.m_boAI) then begin
      PlayObject.SysMsg(sMsg, c_Red, MsgType);
    end;
  end;
end;

procedure TUserEngine.SendBroadCastMsg(sMsg: string; btFColor, btBColor: Byte; MsgType: TMsgType);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  for I := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if (PlayObject <> nil) and (not PlayObject.m_boGhost) and (not PlayObject.m_boNotOnlineAddExp) and (not PlayObject.m_boAI) then begin
      PlayObject.SysMsg(sMsg, btFColor, btBColor, MsgType);
    end;
  end;
end;

procedure TUserEngine.SendMoveMsg(sMsg: string; btFColor, btBColor: Byte; nMoveCount: Integer);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  for I := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if (PlayObject <> nil) and (not PlayObject.m_boGhost) and (not PlayObject.m_boNotOnlineAddExp) and (not PlayObject.m_boAI) then begin
      PlayObject.MoveMsg(sMsg, btFColor, btBColor, 0, 330, nMoveCount);
    end;
  end;
end;

procedure TUserEngine.SendCenterMsg(sMsg: string; btFColor, btBColor: Byte; nTime: Integer);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  for I := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if (PlayObject <> nil) and (not PlayObject.m_boGhost) and (not PlayObject.m_boNotOnlineAddExp) and (not PlayObject.m_boAI) then begin
      PlayObject.CenterMsg(sMsg, btFColor, btBColor, nTime);
    end;
  end;
end;

procedure TUserEngine.sub_4AE514(GoldChangeInfo: pTGoldChangeInfo);
var
  GoldChange: pTGoldChangeInfo;
begin
  New(GoldChange);
  GoldChange^ := GoldChangeInfo^;
  EnterCriticalSection(m_LoadPlaySection);
  try
    m_ChangeHumanDBGoldList.Add(GoldChange);
  finally
    LeaveCriticalSection(m_LoadPlaySection);
  end;
end;

procedure TUserEngine.ClearMonSayMsg;
var
  I, II: Integer;
  MonGen: pTMonGenInfo;
  MonBaseObject: TActorObject;
begin
  for I := 0 to m_MonGenList.Count - 1 do begin
    MonGen := m_MonGenList.Items[I];
    if (MonGen <> nil) and (MonGen.CertList <> nil) then begin
      for II := 0 to MonGen.CertList.Count - 1 do begin
        MonBaseObject := TActorObject(MonGen.CertList.Items[II]);
        if MonBaseObject <> nil then
          MonBaseObject.m_SayMsgList := nil;
      end;
    end;
  end;
end;

procedure TUserEngine.PrcocessData;
var
  dwUsrTimeTick: LongWord;
  sMsg: string;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::ProcessData';
begin
  try
    dwUsrTimeTick := GetTickCount();

    ProcessHumans();

    ProcessHeros();

    if g_Config.boSendOnlineCount and (GetTickCount - g_dwSendOnlineTick > g_Config.dwSendOnlineTime) then begin
      g_dwSendOnlineTick := GetTickCount();
      sMsg := AnsiReplaceText(g_sSendOnlineCountMsg, '%c', IntToStr(Round(GetOnlineHumCount * (g_Config.nSendOnlineCountRate / 10))));
      SendBroadCastMsg(sMsg, t_System)
    end;

    ProcessMonsters();

    ProcessMerchants();

    ProcessNpcs();

    if (GetTickCount() - dwProcessMissionsTime) > 1000 then begin
      dwProcessMissionsTime := GetTickCount();
      ProcessEvents();
    end;

    if (GetTickCount() - dwProcessMapDoorTick) > 500 then begin
      dwProcessMapDoorTick := GetTickCount();
      ProcessMapDoor();
    end;

    g_nUsrTimeMin := GetTickCount() - dwUsrTimeTick;
    if g_nUsrTimeMax < g_nUsrTimeMin then g_nUsrTimeMax := g_nUsrTimeMin;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

function TUserEngine.MapRageHuman(sMapName: string; nMapX, nMapY,
  nRage: Integer): Boolean;
var
  nX, nY: Integer;
  Envir: TEnvirnoment;
begin
  Result := False;
  Envir := g_MapManager.FindMap(sMapName);
  if Envir <> nil then begin
    for nX := nMapX - nRage to nMapX + nRage do begin
      for nY := nMapY - nRage to nMapY + nRage do begin
        if Envir.GetXYHuman(nMapX, nMapY) then begin
          Result := True;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TUserEngine.SendQuestMsg(sQuestName: string);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  for I := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if PlayObject <> nil then begin
      if (not PlayObject.m_boDeath) and (not PlayObject.m_boGhost) { and (not PlayObject.m_boNotOnlineAddExp)} then begin
        PlayObject.m_nScriptGotoCount := 0;
        g_ManageNPC.GotoLable(PlayObject, sQuestName, False);
      end;
    end;
  end;
end;

procedure TUserEngine.ClearItemList();
var
  I: Integer;
begin
  I := 0;
  while (True) do begin
    StdItemList.Exchange(Random(StdItemList.Count), StdItemList.Count - 1);
    Inc(I);
    if I >= StdItemList.Count then Break;
  end;
  ClearMerchantData();
end;

procedure TUserEngine.SwitchMagicList();
var
  I: Integer;
  MagicList: TList;
begin
  if m_MagicList.Count > 0 then begin
    OldMagicList.Add(m_MagicList);
    m_MagicList := TList.Create;
  end;
  m_boStartLoadMagic := True;
end;

procedure TUserEngine.ClearMerchantData();
var
  I: Integer;
  Merchant: TMerchant;
begin
  m_MerchantList.Lock;
  try
    for I := 0 to m_MerchantList.Count - 1 do begin
      Merchant := TMerchant(m_MerchantList.Items[I]);
      if Merchant <> nil then
        Merchant.ClearData();
    end;
  finally
    m_MerchantList.UnLock;
  end;
end;

procedure TUserEngine.Execute;
begin
  Run;
end;

initialization

finalization

end.

