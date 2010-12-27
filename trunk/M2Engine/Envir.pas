unit Envir;

interface

uses
  Windows, SysUtils, Classes, ObjBase, ItemEvent, SDK, Grobal2;
type
  TMapHeader = packed record
    wWidth: Word;
    wHeight: Word;
    sTitle: string[16];
    UpdateDate: TDateTime;
    Reserved: array[0..22] of Char;
  end;
  TMapUnitInfo = packed record
    wBkImg: Word; //32768 $8000 为禁止移动区域
    wMidImg: Word;
    wFrImg: Word;
    btDoorIndex: Byte; //$80
    btDoorOffset: Byte; //
    btAniFrame: Byte; //
    btAniTick: Byte;
    btArea: Byte;
    btLight: Byte; //0..1..4
  end;
  pTMapUnitInfo = ^TMapUnitInfo;
  TMap = array[0..1000 * 1000 - 1] of TMapUnitInfo;
  pTMap = ^TMap;

  TMapCellinfo = record
    chFlag: Byte;
    ObjList: TList;
  end;
  pTMapCellinfo = ^TMapCellinfo;

  PTEnvirnoment = ^TEnvirnoment;

  TEnvirnoment = class
    sMapName: string; //0x4
    sMapDesc: string;
    sMainMapName: string; //0x4
    sSubMapName: string; //0x4
    m_boMainMap: Boolean; //0x25
    MapCellArray: array of TMapCellinfo; //0x0C

    nMinMap: Integer; //0x10
    nServerIndex: Integer; //0x14
    nRequestLevel: Integer; //0x18 进入本地图所需等级
    m_nWidth: Integer;
    m_nHeight: Integer;

    m_boDARK: Boolean;
    m_boDAY: Boolean; //0x25
    m_boDarkness: Boolean;
    m_boDayLight: Boolean;
    m_DoorList: TList; //0x28
    bo2C: Boolean;
    m_boSAFE: Boolean; //0x2D
    m_boFightZone: Boolean; //0x2E
    m_boFight3Zone: Boolean; //0x2F  //行会战争地图
    m_boQUIZ: Boolean; //0x30
    m_boNORECONNECT: Boolean; //0x31
    m_boNEEDHOLE: Boolean; //0x32
    m_boNORECALL: Boolean; //0x33
    m_boNOGUILDRECALL: Boolean;
    m_boNODEARRECALL: Boolean;
    m_boNOMASTERRECALL: Boolean;
    m_boNORANDOMMOVE: Boolean; //0x34
    m_boNODRUG: Boolean; //0x35
    m_boMINE: Boolean; //0x36
    m_boNOPOSITIONMOVE: Boolean; //0x37
    sNoReconnectMap: string; //0x38
    QuestNPC: TObject; //0x3C
    nNEEDSETONFlag: Integer; //0x40
    nNeedONOFF: Integer; //0x44
    m_QuestList: TList; //0x48
    m_boRUNHUMAN: Boolean; //可以穿人
    m_boRUNMON: Boolean; //可以穿怪
    m_boINCHP: Boolean; //自动加HP值
    m_boIncGameGold: Boolean; //自动减游戏币
    m_boINCGAMEPOINT: Boolean; //自动加点
    m_boDECHP: Boolean; //自动减HP值
    m_boDecGameGold: Boolean; //自动减游戏币
    m_boDECGAMEPOINT: Boolean; //自动减点
    m_boMUSIC: Boolean; //音乐
    m_boEXPRATE: Boolean; //杀怪经验倍数
    m_boPKWINLEVEL: Boolean; //PK得等级
    m_boPKWINEXP: Boolean; //PK得经验
    m_boPKLOSTLEVEL: Boolean; //PK丢等级
    m_boPKLOSTEXP: Boolean; //PK丢经验
    m_nPKWINLEVEL: Integer; //PK得等级数
    m_nPKLOSTLEVEL: Integer; //PK丢等级
    m_nPKWINEXP: Integer; //PK得经验数
    m_nPKLOSTEXP: Integer; //PK丢经验
    m_nDECHPTIME: Integer; //减HP间隔时间
    m_nDECHPPOINT: Integer; //一次减点数
    m_nINCHPTIME: Integer; //加HP间隔时间
    m_nINCHPPOINT: Integer; //一次加点数
    m_nDECGAMEGOLDTIME: Integer; //减游戏币间隔时间
    m_nDecGameGold: Integer; //一次减数量
    m_nDECGAMEPOINTTIME: Integer; //减游戏点间隔时间
    m_nDECGAMEPOINT: Integer; //一次减数量
    m_nINCGAMEGOLDTIME: Integer; //加游戏币间隔时间
    m_nIncGameGold: Integer; //一次加数量
    m_nINCGAMEPOINTTIME: Integer; //加游戏币间隔时间
    m_nINCGAMEPOINT: Integer; //一次加数量
    m_nMUSICID: Integer; //音乐ID
    m_sMUSICName: string; //音乐ID
    m_nEXPRATE: Integer; //经验倍率
    m_boNoRecallHero: Boolean;

    m_boSNOW: Boolean;
    m_nSNOWLEVEL: Integer;

    m_boDuel: Boolean; //决斗比赛场地
    m_boDueling: Boolean; //正在决斗
    m_PlayObject: TBaseObject;
    m_dwDuelTick: LongWord;
    m_boClearDuel: Boolean;


    m_boOpenStore: Boolean;

    m_nMonCount: Integer;
    m_nNpcCount: Integer;
    m_nHumCount: Integer;
    m_nHeroCount: Integer;
    m_nItemCount: Integer;
    m_nGateCount: Integer;
    m_nEventCount: Integer;

    m_nMonGenCount: Integer;

    m_boUnAllowStdItems: Boolean; //是否不允许使用物品
    m_UnAllowStdItemsList: TGStringList; //不允许使用物品列表

    m_boUnAllowMagics: Boolean; //是否不允许使用魔法
    m_UnAllowMagicList: TGStringList; //不允许使用魔法列表

    m_boFIGHTPK: Boolean; //PK可以爆装备不红名
    m_boHorse: Boolean; //是否可以骑马

    m_boMonGen: Boolean; //是否刷怪物
    //m_ItemList: TList;
    //m_FreeItemList: TGList;
    //m_MonGenList: TList;
    m_nCurrMonGen: Integer;

    m_PointList: TList;
    //m_Path: TPath;
  private
    procedure Initialize(nWidth, nHeight: Integer);
  public
    constructor Create();
    destructor Destroy; override;
    procedure Run;
    function AddToMap(nX, nY: Integer; pRemoveObject: TBaseObject): TBaseObject;
    function CanWalk(nX, nY: Integer; boFlag: Boolean): Boolean;
    function CanWalkOfItem(nX, nY: Integer; boFlag, boItem: Boolean): Boolean;
    function CanWalkEx(nX, nY: Integer; boFlag: Boolean): Boolean;
    function CanFly(nSX, nSY, nDX, nDY: Integer): Boolean; overload;
    function CanFly(Owner: TBaseObject; nSX, nSY, nDX, nDY: Integer): Boolean; overload;
    function MoveToMovingObject(nCX, nCY: Integer; Cert: TBaseObject; nX, nY: Integer; boFlag: Boolean): Integer;
    function GetItem(nX, nY: Integer): TItemObject; overload;
    function GetItem(nX, nY: Integer; ItemObject: TItemObject): TItemObject; overload;
    function GetItemList(nX, nY: Integer; ItemList: TList): Integer;
    function DeleteFromMap(nX, nY: Integer; pRemoveObject: TBaseObject): Integer;
    function IsCheapStuff(): Boolean;
    procedure AddDoorToMap;
    function AddToMapMineEvent(nX, nY: Integer; Event: TBaseObject): TBaseObject;
    function LoadMapData(sMapFile: string): Boolean;
    function CreateQuest(nFlag, nValue: Integer; s24, s28, s2C: string; boGrouped: Boolean): Boolean;
    function GetMapCellInfo(nX, nY: Integer; var MapCellInfo: pTMapCellinfo): Boolean;
    function GetXYObjCount(nX, nY: Integer): Integer;
    function GetNextPosition(sX, sY, nDir, nFlag: Integer; var snx: Integer; var sny: Integer): Boolean;
    function sub_4B5FC8(nX, nY: Integer): Boolean;
    procedure VerifyMapTime(nX, nY: Integer; ActorObject: TBaseObject);
    function CanSafeWalk(nX, nY: Integer): Boolean;
    function ArroundDoorOpened(nX, nY: Integer): Boolean;
    function GetMovingObject(nX, nY: Integer; boFlag: Boolean): TBaseObject; overload;
    function GetMovingObject(nX, nY: Integer; AObject: TBaseObject; boFlag: Boolean): TBaseObject; overload;
    function GetQuestNPC(ActorObject: TObject; sCharName, sStr: string; boFlag: Boolean): TObject;
    function GetItemEx(nX, nY: Integer; var nCount: Integer): TBaseObject;
    function GetDoor(nX, nY: Integer): TDoorObject;
    function IsValidObject(nX, nY: Integer; nRage: Integer; ActorObject: TBaseObject): Boolean;
    function GetPalyObject(nX, nY, nRage: Integer): TBaseObject;
    function GetRangeActorObject(nX, nY: Integer; nRage: Integer; boFlag: Boolean; ActorObjectList: TList): Integer;
    function GetRangePalyObject(nX, nY, nRage: Integer; boFlag: Boolean; ActorObjectList: TList): Integer;
    function GeTActorObjects(nX, nY: Integer; boFlag: Boolean; ActorObjectList: TList): Integer;
    function GetEvent(nX, nY: Integer): TBaseObject;
    function GetEvents(nX, nY, nType: Integer; EventList: TList): Integer;
    function GetRangeEvents(nX, nY, nRage, nType: Integer; EventList: TList): Integer;


    procedure SetMapXYFlag(nX, nY: Integer; boFlag: Boolean);
    function GetXYHuman(nMapX, nMapY: Integer): Boolean;
    function GetXYObject(nMapX, nMapY: Integer): Boolean;
    function CanWalkOfEvent(Owner: TBaseObject; nX, nY: Integer): Boolean;
    function GetEnvirInfo(): string;
    function AllowStdItems(sItemName: string): Boolean; overload;
    function AllowStdItems(nItemIdx: Integer): Boolean; overload;
    function AllowMagics(sMagName: string): Boolean; overload;
    function AllowMagics(nMagIdx: Integer): Boolean; overload;

    procedure AddObject(ActorObject: TBaseObject);
    procedure DelObject(ActorObject: TBaseObject);
    function GetMainMap(): string;

   { property MonCount: Integer read m_nMonCount;
    property NpcCount: Integer read m_nNpcCount;
    property HumCount: Integer read m_nHumCount;
    property HeroCount: Integer read m_nHeroCount;
    property ItemCount: Integer read m_nItemCount;
    property EventCount: Integer read m_nEventCount;
    property GateCount: Integer read m_nGateCount;
    property MonGenCount: Integer read m_nMonGenCount; }
    property MapName: string read GetMainMap;
  end;
  TMapManager = class(TGList)
    m_nMonCount: Integer;
    m_nNpcCount: Integer;
    m_nHumCount: Integer;
    m_nHeroCount: Integer;
    m_nItemCount: Integer;
    m_nGateCount: Integer;
    m_nEventCount: Integer;
    m_nMonGenCount: Integer;
    m_dwRunTick: LongWord;
    m_GateList: TGList;
    m_DuelMaps: TList;
  private
  public
    constructor Create();
    destructor Destroy; override;
    procedure LoadMapDoor();
    function GetGate(sName: string; nSMapX, nSMapY, nDMapX, nDMapY: Integer): TGateObject;
    procedure GetMapGateXY(sName, sSMapNO: string; var nSMapX, nSMapY, nDMapX, nDMapY: Integer);
    function AddMapInfo(sMapName, sMainMapName, sMapDesc: string; nServerNumber: Integer; MapFlag: pTMapFlag; QuestNPC: TObject): TEnvirnoment;
    function GetMapInfo(nServerIdx: Integer; sMapName: string): TEnvirnoment;
    function AddMapRoute(sSMapNO: string; nSMapX, nSMapY: Integer; sDMapNO: string; nDMapX, nDMapY: Integer): Boolean; overload;
    function AddMapRoute(sName, sSMapNO: string; nSMapX, nSMapY: Integer; sDMapNO: string; nDMapX, nDMapY: Integer): Boolean; overload;
    procedure DelMapRoute(sName, sSMapNO: string);
    function GetMapOfServerIndex(sMapName: string): Integer;
    function FindMap(sMapName: string): TEnvirnoment;
    procedure ReSetMinMap();
    procedure Run;
    procedure ProcessMapDoor();
    procedure MakeSafePkZone();
    function GetMonGenCount: Integer;
    function GetDuelMap(): TEnvirnoment;

    {property MonCount: Integer read m_nMonCount;
    property NpcCount: Integer read m_nNpcCount;
    property HumCount: Integer read m_nHumCount;
    property HeroCount: Integer read m_nHeroCount;
    property ItemCount: Integer read m_nItemCount;
    property EventCount: Integer read m_nEventCount;
    property GateCount: Integer read m_nGateCount;  }
    property MonGenCount: Integer read GetMonGenCount;
  end;

implementation

uses ObjActor, ObjNpc, M2Share, UsrEngn, Event, ObjMon, HUtil32, Castle, PathFind;

//安全区光圈

procedure TMapManager.MakeSafePkZone();
var
  nX, nY: Integer;
  SafeEvent: TSafeEvent;
  nMinX, nMaxX, nMinY, nMaxY: Integer;
  I: Integer;
  StartPoint: pTStartPoint;
  Envir: TEnvirnoment;
begin
  for I := 0 to g_StartPointList.Count - 1 do begin
    StartPoint := pTStartPoint(g_StartPointList.Objects[I]);
    if (StartPoint.nType > 0) then begin
      Envir := FindMap(StartPoint.sMapName);
      if Envir <> nil then begin
        nMinX := StartPoint.nCurrX - StartPoint.nRange;
        nMaxX := StartPoint.nCurrX + StartPoint.nRange;
        nMinY := StartPoint.nCurrY - StartPoint.nRange;
        nMaxY := StartPoint.nCurrY + StartPoint.nRange;
        for nX := nMinX to nMaxX do begin
          for nY := nMinY to nMaxY do begin
            if ((nX < nMaxX) and (nY = nMinY)) or
              ((nY < nMaxY) and (nX = nMinX)) or
              (nX = nMaxX) or (nY = nMaxY) then begin
              SafeEvent := TSafeEvent.Create(Envir, nX, nY, StartPoint.nType);
              g_EventManager.AddEvent(SafeEvent);
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TMapManager.AddMapInfo(sMapName, sMainMapName, sMapDesc: string; nServerNumber: Integer; MapFlag: pTMapFlag; QuestNPC: TObject): TEnvirnoment;
var
  Envir: TEnvirnoment;
  I: Integer;
  nStd: Integer;

  TempList: TStringList;
  sTemp: string;
begin
  Result := nil;
  Envir := TEnvirnoment.Create;
  Envir.sMapName := sMapName;
  Envir.sMainMapName := sMainMapName;
  Envir.sSubMapName := sMapName;
  Envir.sMapDesc := sMapDesc;
  if sMainMapName <> '' then Envir.m_boMainMap := True;
  Envir.nServerIndex := nServerNumber;
  Envir.m_boSAFE := MapFlag.boSAFE;
  Envir.m_boFightZone := MapFlag.boFIGHT;
  Envir.m_boFight3Zone := MapFlag.boFIGHT3;
  Envir.m_boDARK := MapFlag.boDARK;
  Envir.m_boDAY := MapFlag.boDAY;
  Envir.m_boQUIZ := MapFlag.boQUIZ;
  Envir.m_boNORECONNECT := MapFlag.boNORECONNECT;
  Envir.m_boNEEDHOLE := MapFlag.boNEEDHOLE;
  Envir.m_boNORECALL := MapFlag.boNORECALL;
  Envir.m_boNOGUILDRECALL := MapFlag.boNOGUILDRECALL;
  Envir.m_boNODEARRECALL := MapFlag.boNODEARRECALL;
  Envir.m_boNOMASTERRECALL := MapFlag.boNOMASTERRECALL;
  Envir.m_boNORANDOMMOVE := MapFlag.boNORANDOMMOVE;
  Envir.m_boNODRUG := MapFlag.boNODRUG;
  Envir.m_boMINE := MapFlag.boMINE;
  Envir.m_boNOPOSITIONMOVE := MapFlag.boNOPOSITIONMOVE;

  Envir.m_boRUNHUMAN := MapFlag.boRUNHUMAN; //可以穿人
  Envir.m_boRUNMON := MapFlag.boRUNMON; //可以穿怪
  Envir.m_boDECHP := MapFlag.boDECHP; //自动减HP值
  Envir.m_boINCHP := MapFlag.boINCHP; //自动加HP值
  Envir.m_boDecGameGold := MapFlag.boDECGAMEGOLD; //自动减游戏币
  Envir.m_boDECGAMEPOINT := MapFlag.boDECGAMEPOINT; //自动减游戏币
  Envir.m_boIncGameGold := MapFlag.boINCGAMEGOLD; //自动加游戏币
  Envir.m_boINCGAMEPOINT := MapFlag.boINCGAMEPOINT; //自动加游戏点
  Envir.m_boMUSIC := MapFlag.boMUSIC; //音乐
  Envir.m_boEXPRATE := MapFlag.boEXPRATE; //杀怪经验倍数
  Envir.m_boPKWINLEVEL := MapFlag.boPKWINLEVEL; //PK得等级
  Envir.m_boPKWINEXP := MapFlag.boPKWINEXP; //PK得经验
  Envir.m_boPKLOSTLEVEL := MapFlag.boPKLOSTLEVEL;
  Envir.m_boPKLOSTEXP := MapFlag.boPKLOSTEXP;
  Envir.m_nPKWINLEVEL := MapFlag.nPKWINLEVEL; //PK得等级数
  Envir.m_nPKWINEXP := MapFlag.nPKWINEXP; //PK得经验数
  Envir.m_nPKLOSTLEVEL := MapFlag.nPKLOSTLEVEL;
  Envir.m_nPKLOSTEXP := MapFlag.nPKLOSTEXP;
  Envir.m_nPKWINEXP := MapFlag.nPKWINEXP; //PK得经验数
  Envir.m_nDECHPTIME := MapFlag.nDECHPTIME; //减HP间隔时间
  Envir.m_nDECHPPOINT := MapFlag.nDECHPPOINT; //一次减点数
  Envir.m_nINCHPTIME := MapFlag.nINCHPTIME; //加HP间隔时间
  Envir.m_nINCHPPOINT := MapFlag.nINCHPPOINT; //一次加点数
  Envir.m_nDECGAMEGOLDTIME := MapFlag.nDECGAMEGOLDTIME; //减游戏币间隔时间
  Envir.m_nDecGameGold := MapFlag.nDECGAMEGOLD; //一次减数量
  Envir.m_nINCGAMEGOLDTIME := MapFlag.nINCGAMEGOLDTIME; //减游戏币间隔时间
  Envir.m_nIncGameGold := MapFlag.nINCGAMEGOLD; //一次减数量
  Envir.m_nINCGAMEPOINTTIME := MapFlag.nINCGAMEPOINTTIME; //减游戏币间隔时间
  Envir.m_nINCGAMEPOINT := MapFlag.nINCGAMEPOINT; //一次减数量
  Envir.m_nMUSICID := MapFlag.nMUSICID; //音乐ID
  Envir.m_nEXPRATE := MapFlag.nEXPRATE; //经验倍率
  Envir.m_sMUSICName := MapFlag.sMUSICName;

  Envir.sNoReconnectMap := MapFlag.sReConnectMap;
  Envir.QuestNPC := QuestNPC;
  Envir.nNEEDSETONFlag := MapFlag.nNEEDSETONFlag;
  Envir.nNeedONOFF := MapFlag.nNeedONOFF;

  Envir.m_boUnAllowStdItems := MapFlag.boUnAllowStdItems;
  Envir.m_boUnAllowMagics := MapFlag.boNOTALLOWUSEMAGIC;

  Envir.m_boFIGHTPK := MapFlag.boFIGHTPK; //PK可以爆装备不红名
  Envir.m_boHorse := MapFlag.boHorse; //是否可以骑马
  Envir.m_boNoRecallHero := MapFlag.boNoRecallHero;
  Envir.m_boSNOW := MapFlag.boSNOW;
  Envir.m_nSNOWLEVEL := MapFlag.nSNOWLEVEL;
  Envir.m_boDuel := MapFlag.boDuel;
  Envir.m_boOpenStore := MapFlag.boOpenStore;
  if (Envir.m_boUnAllowStdItems) and (MapFlag.sUnAllowStdItemsText <> '') then begin
    TempList := TStringList.Create;
    ExtractStrings(['|', '\', '/'], [], PChar(Trim(MapFlag.sUnAllowStdItemsText)), TempList);
    for I := 0 to TempList.Count - 1 do begin
      nStd := UserEngine.GetStdItemIdx(Trim(TempList.Strings[I]));
      if nStd >= 0 then
        Envir.m_UnAllowStdItemsList.AddObject(Trim(TempList.Strings[I]), TObject(nStd));
    end;
    TempList.Free;
  end;

  if (Envir.m_boUnAllowMagics) and (MapFlag.sUnAllowMagicText <> '') then begin
    TempList := TStringList.Create;
    ExtractStrings(['|', '\', '/'], [], PChar(Trim(MapFlag.sUnAllowMagicText)), TempList);
    for I := 0 to TempList.Count - 1 do begin
      sTemp := Trim(TempList.Strings[I]);
      if sTemp <> '' then Envir.m_UnAllowMagicList.Add(sTemp);
    end;
    TempList.Free;
  end;

  for I := 0 to MiniMapList.Count - 1 do begin
    if CompareText(MiniMapList.Strings[I], Envir.sMapName) = 0 then begin
      Envir.nMinMap := Integer(MiniMapList.Objects[I]);
      Break;
    end;
  end;
  if sMainMapName <> '' then begin
    if Envir.LoadMapData(g_Config.sMapDir + sMainMapName + '.map') then begin
      Result := Envir;
      Self.Add(Envir);
      if Envir.m_boDuel then Self.m_DuelMaps.Add(Envir);
    end else begin
      MainOutMessage('地图文件 ' + g_Config.sMapDir + sMainMapName + '.map' + ' 未找到！！！');
      Envir.Free;
    end;
  end else begin
    if Envir.LoadMapData(g_Config.sMapDir + sMapName + '.map') then begin
      Result := Envir;
      Self.Add(Envir);
      if Envir.m_boDuel then Self.m_DuelMaps.Add(Envir);
    end else begin
      MainOutMessage('地图文件 ' + g_Config.sMapDir + sMapName + '.map' + ' 未找到！！！');
      Envir.Free;
    end;
  end;
end;

function TMapManager.GetGate(sName: string; nSMapX, nSMapY, nDMapX, nDMapY: Integer): TGateObject;
var
  I: Integer;
  GateObject: TGateObject;
begin
  Result := nil;
  for I := 0 to m_GateList.Count - 1 do begin
    GateObject := TGateObject(m_GateList.Items[I]);
    if GateObject.m_sName = sName then begin
      if nSMapX <> -1 then begin
        if (GateObject.m_nSMapX = nSMapX) and (GateObject.m_nSMapY = nSMapY) then begin
          Result := GateObject;
          Break;
        end;
      end else begin
        if (GateObject.m_nMapX = nDMapX) and (GateObject.m_nMapY = nDMapY) then begin
          Result := GateObject;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TMapManager.GetMapGateXY(sName, sSMapNO: string; var nSMapX, nSMapY, nDMapX, nDMapY: Integer);
var
  I: Integer;
  GateObject: TGateObject;
begin
  nSMapX := -1;
  nSMapY := -1;
  nDMapX := -1;
  nDMapY := -1;
  for I := 0 to m_GateList.Count - 1 do begin
    GateObject := TGateObject(m_GateList.Items[I]);
    if (GateObject.m_sName = sName) and (GateObject.m_sSMapNO = sSMapNO) then begin
      nSMapX := GateObject.m_nSMapX;
      nSMapY := GateObject.m_nSMapY;
      nDMapX := GateObject.m_nMapX;
      nDMapY := GateObject.m_nMapY;
      Break;
    end;
  end;
end;

procedure TMapManager.DelMapRoute(sName, sSMapNO: string);
var
  I: Integer;
  GateObject: TGateObject;
  SEnvir: TEnvirnoment;
begin
  SEnvir := FindMap(sSMapNO);
  if SEnvir <> nil then begin
    for I := m_GateList.Count - 1 downto 0 do begin
      GateObject := TGateObject(m_GateList.Items[I]);
      if (GateObject.m_sName = sName) and (GateObject.m_sSMapNO = sSMapNO) then begin
        if SEnvir.DeleteFromMap(GateObject.m_nSMapX, GateObject.m_nSMapY, GateObject) = 1 then begin
          m_GateList.Delete(I);
          GateObject.Free;
        end;
        Break;
      end;
    end;
  end;
end;

function TMapManager.AddMapRoute(sSMapNO: string; nSMapX, nSMapY: Integer; sDMapNO: string; nDMapX, nDMapY: Integer): Boolean;
var
  GateObject: TGateObject;
  SEnvir: TEnvirnoment;
  DEnvir: TEnvirnoment;
begin
  Result := False;
  SEnvir := FindMap(sSMapNO);
  DEnvir := FindMap(sDMapNO);
  if (SEnvir <> nil) and (DEnvir <> nil) then begin
    GateObject := TGateObject.Create();
    GateObject.m_DEnvir := DEnvir;
    GateObject.m_nSMapX := nSMapX;
    GateObject.m_nSMapY := nSMapY;
    GateObject.m_nMapX := nDMapX;
    GateObject.m_nMapY := nDMapY;
    GateObject.m_sSMapNO := sSMapNO;
    GateObject.m_sDMapNO := sDMapNO;
    if SEnvir.AddToMap(nSMapX, nSMapY, GateObject) = GateObject then begin
      Result := True;
    end else begin
      GateObject.Free;
    end;
  end;
end;

function TMapManager.AddMapRoute(sName, sSMapNO: string; nSMapX, nSMapY: Integer; sDMapNO: string; nDMapX, nDMapY: Integer): Boolean;
  function GetRandXY(Envir: TEnvirnoment; var nX: Integer; var nY: Integer): Boolean;
  var
    n14, n18, n1C: Integer;
  begin
    Result := False;
    if Envir.m_nWidth < 80 then n18 := 3
    else n18 := 10;
    if Envir.m_nHeight < 150 then begin
      if Envir.m_nHeight < 50 then n1C := 2
      else n1C := 15;
    end else n1C := 50;
    n14 := 0;
    while (True) do begin
      if Envir.CanWalk(nX, nY, True) then begin
        Result := True;
        Break;
      end;
      if nX < (Envir.m_nWidth - n1C - 1) then Inc(nX, n18)
      else begin
        nX := Random(Envir.m_nWidth);
        if nY < (Envir.m_nHeight - n1C - 1) then Inc(nY, n18)
        else nY := Random(Envir.m_nHeight);
      end;
      Inc(n14);
      if n14 >= 201 then Break;
    end;
  end;
  procedure DeleteMapGate(GateObject: TGateObject);
  var
    I: Integer;
  begin
    for I := m_GateList.Count - 1 downto 0 do begin
      if TGateObject(m_GateList.Items[I]) = GateObject then begin
        m_GateList.Delete(I);
        GateObject.Free;
        Break;
      end;
    end;
  end;
var
  GateObject: TGateObject;
  SEnvir: TEnvirnoment;
  DEnvir: TEnvirnoment;
  nX, nY: Integer;
begin
  Result := False;
  SEnvir := FindMap(sSMapNO);
  DEnvir := FindMap(sDMapNO);
  if (SEnvir <> nil) and (DEnvir <> nil) then begin
    GateObject := GetGate(sName, nSMapX, nSMapY, nDMapX, nDMapY);
    if GateObject = nil then begin
      GateObject := TGateObject.Create();
      GateObject.m_boFlag := True;
      GateObject.m_sName := sName;
      GateObject.m_DEnvir := DEnvir;
      GateObject.m_sSMapNO := sSMapNO;
      GateObject.m_sDMapNO := sDMapNO;
      if nSMapX = -1 then begin
        nX := Random(SEnvir.m_nWidth);
        nY := Random(SEnvir.m_nHeight);
        if GetRandXY(SEnvir, nX, nY) then begin
          GateObject.m_nSMapX := nX;
          GateObject.m_nSMapY := nY;
          GateObject.m_nMapX := nDMapX;
          GateObject.m_nMapY := nDMapY;
          if SEnvir.AddToMap(nX, nY, GateObject) = GateObject then begin
            m_GateList.Add(GateObject);
            Result := True;
          end else begin
            GateObject.Free;
          end;
        end;
      end else begin
        nX := Random(DEnvir.m_nWidth);
        nY := Random(DEnvir.m_nHeight);
        if GetRandXY(DEnvir, nX, nY) then begin
          GateObject.m_nSMapX := nSMapX;
          GateObject.m_nSMapY := nSMapY;
          GateObject.m_nMapX := nX;
          GateObject.m_nMapY := nY;
          if SEnvir.AddToMap(nSMapX, nSMapY, GateObject) = GateObject then begin
            m_GateList.Add(GateObject);
            Result := True;
          end else begin
            GateObject.Free;
          end;
        end;
      end;
    end else begin
      if nSMapX = -1 then begin
        if SEnvir.DeleteFromMap(GateObject.m_nSMapX, GateObject.m_nSMapY, GateObject) = 1 then begin
          nX := Random(SEnvir.m_nWidth);
          nY := Random(SEnvir.m_nHeight);
          if GetRandXY(SEnvir, nX, nY) then begin
            GateObject.m_nSMapX := nX;
            GateObject.m_nSMapY := nY;
            GateObject.m_nMapX := nDMapX;
            GateObject.m_nMapY := nDMapY;
            if SEnvir.AddToMap(nX, nY, GateObject) = GateObject then begin
              Result := True;
            end else begin
              DeleteMapGate(GateObject);
            end;
          end;
        end;
      end else begin
        nX := Random(DEnvir.m_nWidth);
        nY := Random(DEnvir.m_nHeight);
        if GetRandXY(DEnvir, nX, nY) then begin
          GateObject.m_nMapX := nX;
          GateObject.m_nMapY := nY;
          Result := True;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetMainMap(): string;
begin
  if m_boMainMap then Result := sMainMapName
  else Result := sMapName;
end;

function TEnvirnoment.AllowStdItems(sItemName: string): Boolean; //是否允许使用物品
var
  I: Integer;
begin
  Result := True;
  if not m_boUnAllowStdItems then Exit;
  for I := 0 to m_UnAllowStdItemsList.Count - 1 do begin
    if CompareText(m_UnAllowStdItemsList.Strings[I], sItemName) = 0 then begin
      Result := False;
      Break;
    end;
  end;
end;

function TEnvirnoment.AllowStdItems(nItemIdx: Integer): Boolean; //是否允许使用物品
var
  I: Integer;
begin
  Result := True;
  if not m_boUnAllowStdItems then Exit;
  for I := 0 to m_UnAllowStdItemsList.Count - 1 do begin
    if Integer(m_UnAllowStdItemsList.Objects[I]) = nItemIdx then begin
      Result := False;
      Break;
    end;
  end;
end;

function TEnvirnoment.AllowMagics(sMagName: string): Boolean; //是否允许使用魔法
var
  I: Integer;
begin
  Result := True;
  if not m_boUnAllowMagics then Exit;
  for I := 0 to m_UnAllowMagicList.Count - 1 do begin
    if CompareText(m_UnAllowMagicList.Strings[I], sMagName) = 0 then begin
      Result := False;
      Break;
    end;
  end;
end;

function TEnvirnoment.AllowMagics(nMagIdx: Integer): Boolean; //是否允许使用魔法
var
  I: Integer;
begin
  Result := True;
  if not m_boUnAllowMagics then Exit;
  for I := 0 to m_UnAllowMagicList.Count - 1 do begin
    if Integer(m_UnAllowMagicList.Objects[I]) = nMagIdx then begin
      Result := False;
      Break;
    end;
  end;
end;

procedure TEnvirnoment.AddDoorToMap();
var
  I: Integer;
  DoorObject: TDoorObject;
begin
  for I := 0 to m_DoorList.Count - 1 do begin
    DoorObject := TDoorObject(m_DoorList.Items[I]);
    AddToMap(DoorObject.m_nMapX, DoorObject.m_nMapY, DoorObject);
  end;
end;

function TEnvirnoment.GetMapCellInfo(nX, nY: Integer; var MapCellInfo: pTMapCellinfo): Boolean;
begin
  if (nX >= 0) and (nX < m_nWidth) and (nY >= 0) and (nY < m_nHeight) then begin
    MapCellInfo := @MapCellArray[nX * m_nHeight + nY];
    Result := True;
  end else begin
    Result := False;
  end;
end;


//======================================================================
//检查地图指定座标是否可以移动
//boFlag  如果为TRUE 则忽略座标上是否有角色
//返回值 True 为可以移动，False 为不可以移动
//======================================================================

function TEnvirnoment.CanWalk(nX, nY: Integer; boFlag: Boolean): Boolean;
var
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  ActorObject: TActorObject;
  I: Integer;
begin
  Result := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    Result := True;
    if not boFlag and (MapCellInfo.ObjList <> nil) then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
        if (BaseObject <> nil) and (BaseObject.m_ObjType = t_Actor) then begin
          ActorObject := TActorObject(BaseObject);
          if ActorObject <> nil then begin
            if not ActorObject.m_boGhost
              and ActorObject.bo2B9
              and not ActorObject.m_boDeath
              and not ActorObject.m_boFixedHideMode
              and not ActorObject.m_boObMode then begin
              Result := False;
              Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

//======================================================================
//检查地图指定座标是否可以移动
//boFlag  如果为TRUE 则忽略座标上是否有角色
//返回值 True 为可以移动，False 为不可以移动
//======================================================================

function TEnvirnoment.CanWalkOfEvent(Owner: TBaseObject; nX, nY: Integer): Boolean;
var
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  MasterObject: TActorObject;
  Event: TEvent;
  I: Integer;
begin
  Result := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    Result := True;
    if (MapCellInfo.ObjList <> nil) then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
        if (BaseObject <> nil) and (BaseObject.m_ObjType = t_Event) then begin
          Event := TEvent(BaseObject);
          if (Event <> nil) and (Event.m_OwnActorObject <> nil) then begin
            if (Event.m_nServerEventType = ET_MAGICLOCK) then begin
              MasterObject := TActorObject(Owner).Master;
              if MasterObject = nil then begin
                if (Event.m_OwnActorObject <> Owner) then begin
                  Result := False;
                  Break;
                end;
              end else begin
                if (Event.m_OwnActorObject <> MasterObject) then begin
                  if MasterObject.m_boSpaceLock and (TActorObject(Owner).InRect(MasterObject.m_nCurrX, MasterObject.m_nCurrY, MasterObject.m_SpaceRect)) then begin
                    Result := False;
                    Break;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;


function TEnvirnoment.CanWalkOfItem(nX, nY: Integer; boFlag, boItem: Boolean): Boolean;
var
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  ActorObject: TActorObject;
  I: Integer;
begin
  Result := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    Result := True;
    if (MapCellInfo.ObjList <> nil) then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
        if (not boFlag) and (BaseObject <> nil) and (BaseObject.m_ObjType = t_Actor) then begin
          ActorObject := TActorObject(BaseObject);
          if ActorObject <> nil then begin
            if not ActorObject.m_boGhost
              and ActorObject.bo2B9
              and not ActorObject.m_boDeath
              and not ActorObject.m_boFixedHideMode
              and not ActorObject.m_boObMode then begin
              Result := False;
              Break;
            end;
          end;
        end;
        if not boItem and (BaseObject.m_ObjType = t_Item) then begin
          Result := False;
          Break;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.CanWalkEx(nX, nY: Integer; boFlag: Boolean): Boolean;
var
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  ActorObject: TActorObject;
  I: Integer;
  Castle: TUserCastle;
begin
  Result := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    Result := True;
    if not boFlag and (MapCellInfo.ObjList <> nil) then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
        if BaseObject <> nil then begin
          if BaseObject.m_ObjType = t_Actor then begin
            ActorObject := TActorObject(BaseObject);
            if ActorObject <> nil then begin
              {//01/25 多城堡 控制
              if g_Config.boWarDisHumRun and UserCastle.m_boUnderWar and
                UserCastle.InCastleWarArea(ActorObject.m_PEnvir,ActorObject.m_nCurrX,ActorObject.m_nCurrY) then begin
              }
              Castle := g_CastleManager.InCastleWarArea(ActorObject);
              if g_Config.boWarDisHumRun and (Castle <> nil) and (Castle.m_boUnderWar) then begin
              end else begin
                if ActorObject.m_btRaceServer in [RC_PLAYOBJECT, RC_HEROOBJECT, RC_PLAYMOSTER] then begin
                  if g_Config.boRUNHUMAN or m_boRUNHUMAN then Continue;
                end else begin
                  if ActorObject.m_btRaceServer = RC_NPC then begin
                    if g_Config.boRunNpc then Continue;
                  end else begin
                    if ActorObject.m_btRaceServer in [RC_GUARD, RC_ARCHERGUARD] then begin
                      if g_Config.boRunGuard then Continue;
                    end else begin
                      if ActorObject.m_btRaceServer <> 55 then begin //不允许穿过练功师
                        if g_Config.boRUNMON or m_boRUNMON then Continue;
                      end;
                    end;
                  end;
                end;
              end;
              if not ActorObject.m_boGhost
                and ActorObject.bo2B9
                and not ActorObject.m_boDeath
                and not ActorObject.m_boFixedHideMode
                and not ActorObject.m_boObMode then begin
                Result := False;
                Break;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

constructor TMapManager.Create;
begin
  inherited Create;
  m_GateList := TGList.Create;
  m_DuelMaps := TList.Create;
  m_nMonCount := 0;
  m_nHumCount := 0;
  m_nNpcCount := 0;
  m_nItemCount := 0;
  m_nGateCount := 0;
  m_nEventCount := 0;
  m_nMonGenCount := 0;
end;

destructor TMapManager.Destroy;
var
  I: Integer;
begin
  m_GateList.Free;
  m_DuelMaps.Free;
  for I := 0 to Count - 1 do begin
    TEnvirnoment(Items[I]).Free;
  end;

  inherited Destroy;
end;

function TMapManager.FindMap(sMapName: string): TEnvirnoment;
var
  Map: TEnvirnoment;
  I: Integer;
begin
  Result := nil;
  Lock;
  try
    for I := 0 to Count - 1 do begin
      Map := TEnvirnoment(Items[I]);
      if CompareText(Map.sMapName, sMapName) = 0 then begin
        Result := Map;
        Break;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TMapManager.GetMapInfo(nServerIdx: Integer; sMapName: string): TEnvirnoment;
var
  I: Integer;
  Envir: TEnvirnoment;
begin
  Result := nil;
  Lock;
  try
    for I := 0 to Count - 1 do begin
      Envir := Items[I];
      if (Envir.nServerIndex = nServerIdx) and (CompareText(Envir.sMapName, sMapName) = 0) then begin
        Result := Envir;
        Break;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TMapManager.GetDuelMap(): TEnvirnoment;
var
  I: Integer;
  Envir: TEnvirnoment;
begin
  Result := nil;
  for I := 0 to m_DuelMaps.Count - 1 do begin
    Envir := m_DuelMaps.Items[I];
    if Envir.m_boDuel and (not Envir.m_boDueling) and (GetTickCount - Envir.m_dwDuelTick > 1000 * 60 * 6) then begin
      Result := Envir;
      Break;
    end;
  end;
end;

function TEnvirnoment.AddToMap(nX, nY: Integer;
  pRemoveObject: TBaseObject): TBaseObject;
var
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  I: Integer;
  nGoldCount: Integer;
  bo1E: Boolean;
  btRaceServer: Byte;
resourcestring
  sExceptionMsg = '[Exception] TEnvirnoment::AddToMap';
begin
  Result := nil;
  try
    bo1E := False;
    if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
      if MapCellInfo.ObjList = nil then begin
        MapCellInfo.ObjList := TList.Create;
      end else begin
        if pRemoveObject.m_ObjType = t_Item then begin
          if TItemObject(pRemoveObject).m_sName = sSTRING_GOLDNAME then begin
            for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
              BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
              if (BaseObject.m_ObjType = t_Item) and (CompareText(TItemObject(BaseObject).m_sName, sSTRING_GOLDNAME) = 0) then begin
                nGoldCount := TItemObject(BaseObject).m_nCount + TItemObject(pRemoveObject).m_nCount;
                if nGoldCount <= 2000 then begin
                  TItemObject(BaseObject).m_nMapX := nX;
                  TItemObject(BaseObject).m_nMapY := nY;
                  TItemObject(BaseObject).m_nCount := nGoldCount;
                  TItemObject(BaseObject).m_wLooks := GetGoldShape(nGoldCount);
                  TItemObject(BaseObject).m_btAniCount := 0;
                  TItemObject(BaseObject).m_btReserved := 0;
                  TItemObject(BaseObject).m_dwAddTime := GetTickCount();
                  //TItemObject(BaseObject).m_PEnvir := TItemObject(pRemoveObject).m_PEnvir;
                  //TItemObject(BaseObject).m_boGhost := False;
                  Result := BaseObject;
                  bo1E := True;
                  Exit;
                end;
              end;
            end;
          end;
          if not bo1E and (MapCellInfo.ObjList.Count >= 5) then begin
            Result := nil;
            bo1E := True;
          end;
        end;
      end;

      if not bo1E then begin
        pRemoveObject.m_dwAddTime := GetTickCount();
        {if pRemoveObject.m_ObjType = t_Actor then
          TActorObject(pRemoveObject).m_dwVerifyTick := GetTickCount(); }

        if (pRemoveObject.m_ObjType <> t_Gate) then begin
          pRemoveObject.m_nMapX := nX;
          pRemoveObject.m_nMapY := nY;
        end;

        for I := MapCellInfo.ObjList.Count - 1 downto 0 do begin
          BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
          if pRemoveObject = BaseObject then begin
            MapCellInfo.ObjList.Delete(I);
          end;
        end;

        MapCellInfo.ObjList.Add(pRemoveObject);

        if pRemoveObject.m_ObjType <> t_Actor then
          AddObject(pRemoveObject);

        Result := pRemoveObject;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

function TEnvirnoment.DeleteFromMap(nX, nY: Integer;
  pRemoveObject: TBaseObject): Integer;
var
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  n18: Integer;
  nDeleteCount: Integer;
  btRaceServer: Byte;
resourcestring
  sExceptionMsg1 = '[Exception] TEnvirnoment::DeleteFromMap -> Except 1 ** %d';
  sExceptionMsg2 = '[Exception] TEnvirnoment::DeleteFromMap -> Except 2 ** %d';
begin
  Result := -1;
  try
    if GetMapCellInfo(nX, nY, MapCellInfo) then begin
      if MapCellInfo <> nil then begin
        try
          if MapCellInfo.ObjList <> nil then begin
            n18 := 0;
            nDeleteCount := 0;
            while (True) do begin
              if MapCellInfo.ObjList.Count <= 0 then begin
                FreeAndNil(MapCellInfo.ObjList);
                Break;
              end;
              if MapCellInfo.ObjList.Count <= n18 then Break;
              BaseObject := TBaseObject(MapCellInfo.ObjList.Items[n18]);
              if (BaseObject = pRemoveObject) then begin
                Result := 1;
                MapCellInfo.ObjList.Delete(n18);

                if (BaseObject.m_ObjType <> t_Actor) then begin
                  if (nDeleteCount = 0) then
                    DelObject(BaseObject);
                end else
                  TActorObject(BaseObject).DelMapCount;

                nDeleteCount := nDeleteCount + 1;

                if MapCellInfo.ObjList.Count <= 0 then begin
                  FreeAndNil(MapCellInfo.ObjList);
                  Break;
                end;
                Continue;
              end;
              Inc(n18);
            end;
          end else begin
            Result := -2;
          end;
        except
          MainOutMessage(Format(sExceptionMsg1, [Byte(pRemoveObject.m_ObjType)]));
        end;
      end else Result := -3;
    end else Result := 0;
  except
    MainOutMessage(Format(sExceptionMsg2, [Byte(pRemoveObject.m_ObjType)]));
  end;
end;

function TEnvirnoment.MoveToMovingObject(nCX, nCY: Integer; Cert: TBaseObject; nX, nY: Integer; boFlag: Boolean): Integer;
var
  MapCellInfo: pTMapCellinfo;
  ActorObject: TActorObject;
  BaseObject: TBaseObject;
  I: Integer;
  bo1A: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TEnvirnoment::MoveToMovingObject';
label
  Loop, Over;
begin
  Result := 0;
  try
    bo1A := True;
    if not boFlag and GetMapCellInfo(nX, nY, MapCellInfo) then begin
      if MapCellInfo.chFlag = 0 then begin
        if MapCellInfo.ObjList <> nil then begin
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
            if BaseObject.m_ObjType = t_Actor then begin
              ActorObject := TActorObject(BaseObject);
              if not ActorObject.m_boGhost //检测移动地点是否有人物
                and ActorObject.bo2B9
                and not ActorObject.m_boDeath
                and not ActorObject.m_boFixedHideMode
                and not ActorObject.m_boObMode then begin
                bo1A := False;
                Break;
              end;
            end;
          end;
        end;
      end else begin //if MapCellInfo.chFlag = 0 then begin
        Result := -1;
        bo1A := False;
      end;
    end;
    if bo1A then begin
      if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag <> 0) then begin
        Result := -1;
      end else begin
        if GetMapCellInfo(nCX, nCY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          I := 0;
          while (True) do begin
            if MapCellInfo.ObjList.Count <= I then Break;
            BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
            if BaseObject.m_ObjType = t_Actor then begin
              if BaseObject = Cert then begin
                MapCellInfo.ObjList.Delete(I);
                if MapCellInfo.ObjList.Count <= 0 then begin
                  FreeAndNil(MapCellInfo.ObjList);
                  Break;
                end;
                Continue;
              end;
            end;
            Inc(I);
          end;
        end;

        if GetMapCellInfo(nX, nY, MapCellInfo) then begin
          if (MapCellInfo.ObjList = nil) then begin
            MapCellInfo.ObjList := TList.Create;
          end;

          Cert.m_dwAddTime := GetTickCount;
          {if Cert.m_ObjType = t_Actor then
            TActorObject(Cert).m_dwVerifyTick := GetTickCount();}

          MapCellInfo.ObjList.Add(Cert);
          Result := 1;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
end;

function TEnvirnoment.GetItem(nX, nY: Integer): TItemObject;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  ActorObject: TActorObject;
begin
  Result := nil;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    bo2C := True;
    if MapCellInfo.ObjList <> nil then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
        if BaseObject <> nil then begin
          if (BaseObject.m_ObjType = t_Item) and (not TItemObject(BaseObject).m_boGhost) then begin
            Result := TItemObject(BaseObject);
            Exit;
          end;
          if BaseObject.m_ObjType = t_Gate then
            bo2C := False;
          if BaseObject.m_ObjType = t_Actor then begin
            ActorObject := TActorObject(BaseObject);
            if not ActorObject.m_boDeath then
              bo2C := False;
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetItem(nX, nY: Integer; ItemObject: TItemObject): TItemObject;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  ActorObject: TActorObject;
begin
  Result := nil;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    bo2C := True;
    if MapCellInfo.ObjList <> nil then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
        if BaseObject <> nil then begin
          if BaseObject.m_ObjType = t_Item then begin
            if ItemObject = BaseObject then begin
              Result := ItemObject;
              Break;
            end;
          end;
          if BaseObject.m_ObjType = t_Gate then
            bo2C := False;
          if BaseObject.m_ObjType = t_Actor then begin
            ActorObject := TActorObject(BaseObject);
            if not ActorObject.m_boDeath then
              bo2C := False;
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetItemList(nX, nY: Integer; ItemList: TList): Integer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  ActorObject: TActorObject;
begin
  Result := 0;
  if ItemList = nil then Exit;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    bo2C := True;
    if MapCellInfo.ObjList <> nil then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
        if BaseObject <> nil then begin
          if (BaseObject.m_ObjType = t_Item) and (not TItemObject(BaseObject).m_boGhost) then begin
            ItemList.Add(BaseObject);
          end;
          if BaseObject.m_ObjType = t_Gate then
            bo2C := False;
          if BaseObject.m_ObjType = t_Actor then begin
            ActorObject := TActorObject(BaseObject);
            if not ActorObject.m_boDeath then
              bo2C := False;
          end;
        end;
      end;
    end;
  end;
  Result := ItemList.Count;
end;

function TMapManager.GetMapOfServerIndex(sMapName: string): Integer;
var
  I: Integer;
  Envir: TEnvirnoment;
begin
  Result := 0;
  Lock;
  try
    for I := 0 to Count - 1 do begin
      Envir := Items[I];
      if (CompareText(Envir.sMapName, sMapName) = 0) then begin
        Result := Envir.nServerIndex;
        Break;
      end;
    end;
  finally
    UnLock;
  end;
end;

procedure TMapManager.LoadMapDoor;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do begin
    TEnvirnoment(Items[I]).AddDoorToMap;
  end;
end;

procedure TMapManager.ProcessMapDoor;
begin

end;

procedure TMapManager.Run;
var
  I, II: Integer;
  Envir: TEnvirnoment;
  SpaceLockEvent: TSpaceLockEvent;
  ActorObject: TActorObject;
  PlayObject: TPlayObject;
  BaseObjectList: TList;
begin
  if GetTickCount - m_dwRunTick > 1000 * 10 then begin
    m_dwRunTick := GetTickCount;
    for I := 0 to m_DuelMaps.Count - 1 do begin
      Envir := m_DuelMaps.Items[I];
      if (not Envir.m_boDueling) and (not Envir.m_boClearDuel) and (GetTickCount - Envir.m_dwDuelTick >= 1000 * 60 * 5) then begin
        Envir.m_boClearDuel := True;

        PlayObject := TPlayObject(Envir.m_PlayObject);
        if PlayObject.m_boSpaceLock then begin //解除锁定   删除挑战地图的锁定魔法
          BaseObjectList := TList.Create;
          if g_EventManager.GetLockEvent(Envir, BaseObjectList) > 0 then begin
            for II := 0 to BaseObjectList.Count - 1 do begin
              SpaceLockEvent := TSpaceLockEvent(BaseObjectList.Items[II]);
              SpaceLockEvent.m_boClosed := True;
              SpaceLockEvent.Close;
            end;
          end;
          BaseObjectList.Free;
        end;

        BaseObjectList := TList.Create; //清除挑战地图的人物
        Envir.GetRangeActorObject(Envir.m_nWidth div 2, Envir.m_nHeight div 2, _MAX(Envir.m_nWidth div 2, Envir.m_nHeight div 2), True, BaseObjectList);
        for II := 0 to BaseObjectList.Count - 1 do begin
          ActorObject := TActorObject(BaseObjectList.Items[II]);
          if (ActorObject.m_btRaceServer = RC_PLAYOBJECT) {and (not PlayObject.m_boStartDuel)} then begin
            PlayObject := TPlayObject(ActorObject);
            PlayObject.m_boStartDuel := False;
            PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
            if PlayObject.PKLevel < 2 then begin
              PlayObject.MoveToHome;
              //PlayObject.BaseObjectMove(PlayObject.m_sHomeMap, IntToStr(PlayObject.m_nHomeX), IntToStr(PlayObject.m_nHomeY));
            end else begin
              PlayObject.BaseObjectMove(g_Config.sRedHomeMap, IntToStr(g_Config.nRedHomeX), IntToStr(g_Config.nRedHomeY));
            end;
          end;
        end;
        BaseObjectList.Free;
      end;
    end;
  end;
end;

procedure TMapManager.ReSetMinMap;
var
  I, II: Integer;
  Envirnoment: TEnvirnoment;
begin
  for I := 0 to Count - 1 do begin
    Envirnoment := TEnvirnoment(Items[I]);
    for II := 0 to MiniMapList.Count - 1 do begin
      if CompareText(MiniMapList.Strings[II], Envirnoment.sMapName) = 0 then begin
        Envirnoment.nMinMap := Integer(MiniMapList.Objects[II]);
        Break;
      end;
    end;
  end;
end;

function TEnvirnoment.IsCheapStuff: Boolean;
begin
  if m_QuestList.Count > 0 then Result := True
  else Result := False;
end;

function TEnvirnoment.AddToMapMineEvent(nX, nY: Integer; Event: TBaseObject): TBaseObject;
var
  MapCellInfo: pTMapCellinfo;
  bo19: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TEnvirnoment::AddToMapMineEvent ';
begin
  Result := nil;
  try
    bo19 := GetMapCellInfo(nX, nY, MapCellInfo);
    if bo19 and (MapCellInfo.chFlag <> 0) then begin
      if MapCellInfo.ObjList = nil then MapCellInfo.ObjList := TList.Create;
      Event.m_dwAddTime := GetTickCount();
      MapCellInfo.ObjList.Add(Event);
      Result := Event;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TEnvirnoment.VerifyMapTime(nX, nY: Integer; ActorObject: TBaseObject);
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  boVerify: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TEnvirnoment::VerifyMapTime';
begin
  try
    boVerify := False;
    if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo <> nil) and (MapCellInfo.ObjList <> nil) then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
        if (BaseObject.m_ObjType = t_Actor) and (BaseObject = ActorObject) then begin
          BaseObject.m_dwAddTime := GetTickCount();
          boVerify := True;
          Break;
        end;
      end;
    end;
    if not boVerify then
      AddToMap(nX, nY, ActorObject);
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

constructor TEnvirnoment.Create;
begin
  Pointer(MapCellArray) := nil;
  sMapName := '';
  sSubMapName := '';
  sMainMapName := '';
  m_boMainMap := False;
  nServerIndex := 0;
  nMinMap := 0;
  m_nWidth := 0;
  m_nHeight := 0;
  m_boDARK := False;
  m_boDAY := False;

  m_nMonCount := 0;
  m_nHumCount := 0;
  m_nNpcCount := 0;
  m_nItemCount := 0;
  m_nGateCount := 0;
  m_nEventCount := 0;
  m_nMonGenCount := 0;

  m_boMonGen := True;

  m_DoorList := TList.Create;
  m_QuestList := TList.Create;
  m_UnAllowStdItemsList := TGStringList.Create;
  m_UnAllowMagicList := TGStringList.Create;
  //m_ItemList := TList.Create;
  //m_FreeItemList := TGList.Create;

  m_nCurrMonGen := 0;
  m_boDuel := False; //决斗比赛场地
  m_boDueling := False; //正在决斗
  m_boClearDuel := True;

  m_boOpenStore := False;
  m_PointList := TList.Create;


  m_PlayObject := TPlayObject.Create;
  TPlayObject(m_PlayObject).m_boSuperMan := True;
  TPlayObject(m_PlayObject).m_PEnvir := Self;
  TPlayObject(m_PlayObject).m_sMapName := sMapName;
end;

destructor TEnvirnoment.Destroy;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  nX, nY: Integer;
  DoorObject: TDoorObject;
begin
  if Pointer(MapCellArray) <> nil then begin
    for nX := 0 to m_nWidth - 1 do begin
      for nY := 0 to m_nHeight - 1 do begin
        if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
            if {(BaseObject.m_ObjType = t_Item) or }(BaseObject.m_ObjType = t_Gate) then
              BaseObject.Free;
          end;
          MapCellInfo.ObjList.Free;
        end;
      end;
    end;
    FreeMem(Pointer(MapCellArray));
  end;

  Pointer(MapCellArray) := nil;

  for I := 0 to m_DoorList.Count - 1 do begin
    DoorObject := TDoorObject(m_DoorList.Items[I]);
    Dec(DoorObject.m_Status.nRefCount);
    if DoorObject.m_Status.nRefCount <= 0 then
      Dispose(DoorObject.m_Status);
    DoorObject.Free;
  end;
  m_DoorList.Free;

  for I := 0 to m_QuestList.Count - 1 do begin
    Dispose(pTMapQuestInfo(m_QuestList.Items[I]));
  end;
  m_QuestList.Free;


  m_PointList.Free;


  m_UnAllowStdItemsList.Free;
  m_UnAllowMagicList.Free;
  TPlayObject(m_PlayObject).Free;
  m_PlayObject := nil;
  inherited;
end;

function TEnvirnoment.LoadMapData(sMapFile: string): Boolean;
var
  fHandle: Integer;
  Header: TMapHeader;
  nMapSize: Integer;
  n24, nW, nH: Integer;
  MapBuffer: pTMap;
  Point: Integer;
  DoorObject: TDoorObject;
  Status: pTDoorStatus;
  I: Integer;
  MapCellInfo: pTMapCellinfo;

  sFileName: string;
  sLineText, sX, sY: string;
  LoadList: TStringList;
  nX, nY: Integer;
begin
  Result := False;
  if FileExists(sMapFile) then begin
    fHandle := FileOpen(sMapFile, fmOpenRead or fmShareExclusive);
    if fHandle > 0 then begin
      FileRead(fHandle, Header, SizeOf(TMapHeader));
      m_nWidth := Header.wWidth;
      m_nHeight := Header.wHeight;
      Initialize(m_nWidth, m_nHeight);
      nMapSize := m_nWidth * SizeOf(TMapUnitInfo) * m_nHeight;

      MapBuffer := AllocMem(nMapSize);
      FileRead(fHandle, MapBuffer^, nMapSize);

      for nW := 0 to m_nWidth - 1 do begin
        n24 := nW * m_nHeight;
        for nH := 0 to m_nHeight - 1 do begin
          if (MapBuffer[n24 + nH].wBkImg) and $8000 <> 0 then begin
            MapCellInfo := @MapCellArray[n24 + nH];
            MapCellInfo.chFlag := 1;
          end;
          if MapBuffer[n24 + nH].wFrImg and $8000 <> 0 then begin
            MapCellInfo := @MapCellArray[n24 + nH];
            MapCellInfo.chFlag := 2;
          end;
          if MapBuffer[n24 + nH].btDoorIndex and $80 <> 0 then begin
            Point := (MapBuffer[n24 + nH].btDoorIndex and $7F);
            if Point > 0 then begin
              DoorObject := TDoorObject.Create();
              DoorObject.m_n08 := Point;
              DoorObject.m_nMapX := nW;
              DoorObject.m_nMapY := nH;
              for I := 0 to m_DoorList.Count - 1 do begin
                if abs(TDoorObject(m_DoorList.Items[I]).m_nMapX - DoorObject.m_nMapX) <= 10 then begin
                  if abs(TDoorObject(m_DoorList.Items[I]).m_nMapY - DoorObject.m_nMapY) <= 10 then begin
                    if TDoorObject(m_DoorList.Items[I]).m_n08 = Point then begin
                      DoorObject.m_Status := TDoorObject(m_DoorList.Items[I]).m_Status;
                      Inc(DoorObject.m_Status.nRefCount);
                      Break;
                    end;
                  end;
                end;
              end;
              if DoorObject.m_Status = nil then begin
                New(Status);
                Status.boOpened := False;
                Status.bo01 := False;
                Status.n04 := 0;
                Status.dwOpenTick := 0;
                Status.nRefCount := 1;
                DoorObject.m_Status := Status;
              end;
              m_DoorList.Add(DoorObject);
            end;
          end;
        end;
      end;
      //Dispose(MapBuffer);
      FreeMem(MapBuffer);
      FileClose(fHandle);
      Result := True;
    end;
{--------------------------------加载挂机点-------------------------------------}
    //m_Path := nil;
    sFileName := g_Config.sEnvirDir + 'Point\' + MapName + '.txt';
    if FileExists(sFileName) then begin
      LoadList := TStringList.Create;
      try
        LoadList.LoadFromFile(sFileName);
      except

      end;
      //PointList := TList.Create;
      for I := 0 to LoadList.Count - 1 do begin
        sLineText := Trim(LoadList.Strings[I]);
        if (sLineText = '') or (sLineText[1] = ';') then Continue;
        sLineText := GetValidStr3(sLineText, sX, [',', #9]);
        sLineText := GetValidStr3(sLineText, sY, [',', #9]);
        nX := Str_ToInt(sX, -1);
        nY := Str_ToInt(sY, -1);
        if (nX >= 0) and (nY >= 0) and (nX < m_nWidth) and (nY < m_nHeight) then begin
          m_PointList.Add(Pointer(MakeLong(nX, nY)));
        end;
      end;
      LoadList.Free;

      {FindPath := TFindPath.Create(m_PlayObject);
      for I := 0 to PointList.Count - 2 do begin
        nPt := Integer(PointList.Items[I]);
        StartX := LoWord(nPt);
        StartY := HiWord(nPt);
        nPt := Integer(PointList.Items[I + 1]);
        StopX := LoWord(nPt);
        StopY := HiWord(nPt);
        Path := FindPath.FindPath(Self, StartX, StartY, StopX, StopY, False, True);
        if Length(Path) > 1 then begin
          for II := 0 to Length(Path) - 2 do begin
            New(Pt);
            Pt^ := Path[II];
            m_PointList.Add(Pt);
          end;
        end;
      end;
      FindPath.Free;}

      {for I := 0 PointList.Count - 2 do begin
        nPt := Integer(PointList.Items[I]);
        StartX := LoWord(nPt);
        StartY := HiWord(nPt);
        nPt := Integer(PointList.Items[I + 1]);
        StopX := LoWord(nPt);
        StopY := HiWord(nPt);

        nX := StartX;
        nY := StartY;

        New(Pt);
        Pt.X := nX;
        Pt.Y := nY;
        m_PointList.Add(Pt);
        btDir := GetNextDirection(StartX, StartY, StopX, StopY);
        while True do begin
          if GetNextPosition(nX, nY, btDir, 1, nX, nY) then begin
            if (StopX = nX) and (StopY = nY) then begin
              break;
            end;
            New(Pt);
            Pt.X := nX;
            Pt.Y := nY;
            m_PointList.Add(Pt);
            btDir := GetNextDirection(nX, nY, StopX, StopY);
          end else begin
            break;
          end;
        end;
      end; }
      //PointList.Free;
    end;
  end;
end;

procedure TEnvirnoment.Initialize(nWidth, nHeight: Integer);
var
  I, nW, nH: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
begin
  if (nWidth > 1) and (nHeight > 1) then begin
    if MapCellArray <> nil then begin
      for nW := 0 to m_nWidth - 1 do begin
        for nH := 0 to m_nHeight - 1 do begin
          MapCellInfo := @MapCellArray[nW * m_nHeight + nH];
          if MapCellInfo.ObjList <> nil then begin
            for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
              BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
              if {(BaseObject.m_ObjType = t_Item) or}(BaseObject.m_ObjType = t_Gate) then
                BaseObject.Free;
            end;
            MapCellInfo.ObjList.Free;
          end;
        end;
      end;
      FreeMem(Pointer(MapCellArray));
      Pointer(MapCellArray) := nil;
    end;
    m_nWidth := nWidth;
    m_nHeight := nHeight;
    Pointer(MapCellArray) := AllocMem((m_nWidth * m_nHeight) * SizeOf(TMapCellinfo));
  end;
  m_PointList.Clear;
end;

//nFlag,boFlag,Monster,Item,Quest,boGrouped

function TEnvirnoment.CreateQuest(nFlag, nValue: Integer; s24, s28, s2C: string;
  boGrouped: Boolean): Boolean;
var
  MapQuest: pTMapQuestInfo;
  MapMerchant: TMerchant;
begin
  Result := False;
  if nFlag < 0 then Exit;
  New(MapQuest);
  MapQuest.nFlag := nFlag;
  if nValue > 1 then nValue := 1;
  MapQuest.nValue := nValue;
  if s24 = '*' then s24 := '';
  MapQuest.s08 := s24;
  if s28 = '*' then s28 := '';
  MapQuest.s0C := s28;
  if s2C = '*' then s2C := '';

  MapQuest.bo10 := boGrouped;
  MapMerchant := TMerchant.Create;
  MapMerchant.m_NpcType := n_Norm;
  MapMerchant.m_PEnvir := Self;
  MapMerchant.m_sMapName := '0';
  MapMerchant.m_nCurrX := 0;
  MapMerchant.m_nCurrY := 0;
  MapMerchant.m_sCharName := s2C;
  MapMerchant.m_nFlag := 0;
  MapMerchant.m_wAppr := 0;
  MapMerchant.m_sFilePath := 'MapQuest_def\';
  MapMerchant.m_boIsHide := True;
  MapMerchant.m_boIsQuest := False;

  UserEngine.QuestNPCList.Add(MapMerchant);
  MapQuest.NPC := MapMerchant;
  m_QuestList.Add(MapQuest);
  Result := True;
end;

function TEnvirnoment.GetXYObjCount(nX, nY: Integer): Integer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  ActorObject: TActorObject;
begin
  Result := 0;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
      BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
      if BaseObject.m_ObjType = t_Actor then begin
        ActorObject := TActorObject(BaseObject);
        if ActorObject <> nil then begin
          if not ActorObject.m_boGhost and
            ActorObject.bo2B9 and
            (not ActorObject.m_boFixedHideMode) and
            not ActorObject.m_boDeath and
            not ActorObject.m_boFixedHideMode and
            not ActorObject.m_boObMode then begin
            Inc(Result);
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetNextPosition(sX, sY, nDir, nFlag: Integer; var snx: Integer; var sny: Integer): Boolean;
begin
  snx := sX;
  sny := sY;
  case nDir of
    DR_UP: if sny > nFlag - 1 then Dec(sny, nFlag);
    DR_DOWN: if sny < (m_nHeight - nFlag) then Inc(sny, nFlag);
    DR_LEFT: if snx > nFlag - 1 then Dec(snx, nFlag);
    DR_RIGHT: if snx < (m_nWidth - nFlag) then Inc(snx, nFlag);
    DR_UPLEFT: begin
        if (snx > nFlag - 1) and (sny > nFlag - 1) then begin
          Dec(snx, nFlag);
          Dec(sny, nFlag);
        end;
      end;
    DR_UPRIGHT: begin
        if (snx > nFlag - 1) and (sny < (m_nHeight - nFlag)) then begin
          Inc(snx, nFlag);
          Dec(sny, nFlag);
        end;
      end;
    DR_DOWNLEFT: begin
        if (snx < (m_nWidth - nFlag)) and (sny > nFlag - 1) then begin
          Dec(snx, nFlag);
          Inc(sny, nFlag);
        end;
      end;
    DR_DOWNRIGHT: begin
        if (snx < (m_nWidth - nFlag)) and (sny < (m_nHeight - nFlag)) then begin
          Inc(snx, nFlag);
          Inc(sny, nFlag);
        end;
      end;
  end;
  if (snx = sX) and (sny = sY) then Result := False
  else Result := True;
end;

function TEnvirnoment.CanSafeWalk(nX, nY: Integer): Boolean;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
begin
  Result := True;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    for I := MapCellInfo.ObjList.Count - 1 downto 0 do begin
      BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
      if BaseObject.m_ObjType = t_Event then begin
        if TEvent(BaseObject).m_nDamage > 0 then Result := False;
      end;
    end;
  end;
end;

function TEnvirnoment.ArroundDoorOpened(nX, nY: Integer): Boolean;
var
  I: Integer;
  DoorObject: TDoorObject;
resourcestring
  sExceptionMsg = '[Exception] TEnvirnoment::ArroundDoorOpened ';
begin
  Result := True;
  try
    for I := 0 to m_DoorList.Count - 1 do begin
      DoorObject := TDoorObject(m_DoorList.Items[I]);
      if (abs(DoorObject.m_nMapX - nX) <= 1) and ((abs(DoorObject.m_nMapY - nY) <= 1)) then begin
        if not DoorObject.m_Status.boOpened then begin
          Result := False;
          Break;
        end;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

function TEnvirnoment.GetMovingObject(nX, nY: Integer; boFlag: Boolean): TBaseObject;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  ActorObject: TActorObject;
begin
  Result := nil;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
      BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
      if BaseObject.m_ObjType = t_Actor then begin
        ActorObject := TActorObject(BaseObject);
        if ((not ActorObject.m_boGhost) and
          (not ActorObject.m_boFixedHideMode) and
          (ActorObject.bo2B9)) and
          ((not boFlag) or (not ActorObject.m_boDeath)) then begin
          Result := ActorObject;
          Break;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetMovingObject(nX, nY: Integer; AObject: TBaseObject; boFlag: Boolean): TBaseObject;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  ActorObject: TActorObject;
begin
  Result := nil;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
      BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
      if BaseObject.m_ObjType = t_Actor then begin
        ActorObject := TActorObject(BaseObject);
        if ((not ActorObject.m_boGhost) and (ActorObject.bo2B9) and (not ActorObject.m_boFixedHideMode)) and
          ((not boFlag) or (not ActorObject.m_boDeath)) and (ActorObject = AObject) then begin
          Result := ActorObject;
          Break;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetQuestNPC(ActorObject: TObject; sCharName, sStr: string; boFlag: Boolean): TObject;
var
  I: Integer;
  MapQuestFlag: pTMapQuestInfo;
  nFlagValue: Integer;
  bo1D: Boolean;
begin
  Result := nil;
  for I := 0 to m_QuestList.Count - 1 do begin
    MapQuestFlag := m_QuestList.Items[I];
    nFlagValue := TActorObject(ActorObject).GetQuestFalgStatus(MapQuestFlag.nFlag);
    if nFlagValue = MapQuestFlag.nValue then begin
      if (boFlag = MapQuestFlag.bo10) or (not boFlag) then begin
        bo1D := False;
        if (MapQuestFlag.s08 <> '') and (MapQuestFlag.s0C <> '') then begin
          if (MapQuestFlag.s08 = sCharName) and (MapQuestFlag.s0C = sStr) then
            bo1D := True;
        end;
        if (MapQuestFlag.s08 <> '') and (MapQuestFlag.s0C = '') then begin
          if (MapQuestFlag.s08 = sCharName) and (sStr = '') then
            bo1D := True;
        end;
        if (MapQuestFlag.s08 = '') and (MapQuestFlag.s0C <> '') then begin
          if (MapQuestFlag.s0C = sStr) then
            bo1D := True;
        end;
        if bo1D then begin
          Result := MapQuestFlag.NPC;
          Break;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetItemEx(nX, nY: Integer;
  var nCount: Integer): TBaseObject;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  ActorObject: TActorObject;
begin
  Result := nil;
  nCount := 0;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    bo2C := True;
    if MapCellInfo.ObjList <> nil then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
        if BaseObject <> nil then begin
          if (BaseObject.m_ObjType = t_Item) and (not TItemObject(BaseObject).m_boGhost) then begin
            Result := TItemObject(BaseObject);
            Inc(nCount);
          end;
          if BaseObject.m_ObjType = t_Gate then begin
            bo2C := False;
          end;
          if BaseObject.m_ObjType = t_Actor then begin
            ActorObject := TActorObject(BaseObject);
            if not ActorObject.m_boDeath then
              bo2C := False;
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetDoor(nX, nY: Integer): TDoorObject;
var
  I: Integer;
  DoorObject: TDoorObject;
begin
  Result := nil;
  for I := 0 to m_DoorList.Count - 1 do begin
    DoorObject := TDoorObject(m_DoorList.Items[I]);
    if (DoorObject.m_nMapX = nX) and (DoorObject.m_nMapY = nY) then begin
      Result := DoorObject;
      Exit;
    end;
  end;
end;

function TEnvirnoment.IsValidObject(nX, nY, nRage: Integer; ActorObject: TBaseObject): Boolean;
var
  nXX, nYY, I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
begin
  Result := False;
  for nXX := nX - nRage to nX + nRage do begin
    for nYY := nY - nRage to nY + nRage do begin
      if GetMapCellInfo(nXX, nYY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
          //if (BaseObject.m_ObjType = t_Actor) then MainOutMessage('TEnvirnoment.IsValidObject '+TActorObject(BaseObject).m_sCharName);
          if (BaseObject.m_ObjType = t_Actor) and (BaseObject = ActorObject) then begin
            Result := True;
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetPalyObject(nX, nY, nRage: Integer): TBaseObject;
var
  nXX, nYY, I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
begin
  Result := nil;
  for nXX := nX - nRage to nX + nRage do begin
    for nYY := nY - nRage to nY + nRage do begin
      if GetMapCellInfo(nXX, nYY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
          //if (BaseObject.m_ObjType = t_Actor) then MainOutMessage('TEnvirnoment.IsValidObject '+TActorObject(BaseObject).m_sCharName);
          if (BaseObject.m_ObjType = t_Actor) and (TActorObject(BaseObject).m_btRaceServer = RC_PLAYOBJECT) then begin
            Result := BaseObject;
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetRangePalyObject(nX, nY, nRage: Integer; boFlag: Boolean;
  ActorObjectList: TList): Integer;
var
  nXX, nYY, I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  ActorObject: TActorObject;
begin
  Result := 0;
  for nXX := nX - nRage to nX + nRage do begin
    for nYY := nY - nRage to nY + nRage do begin
      if GetMapCellInfo(nXX, nYY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
          if BaseObject.m_ObjType = t_Actor then begin
            ActorObject := TActorObject(BaseObject);
            if ActorObject.m_btRaceServer = RC_PLAYOBJECT then begin
              if not ActorObject.m_boGhost and ActorObject.bo2B9 then begin
                if not boFlag or not ActorObject.m_boDeath then
                  ActorObjectList.Add(ActorObject);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  Result := ActorObjectList.Count;
end;

function TEnvirnoment.GetRangeActorObject(nX, nY, nRage: Integer; boFlag: Boolean;
  ActorObjectList: TList): Integer;
var
  nXX, nYY: Integer;
begin
  for nXX := nX - nRage to nX + nRage do begin
    for nYY := nY - nRage to nY + nRage do begin
      GeTActorObjects(nXX, nYY, boFlag, ActorObjectList);
    end;
  end;
  Result := ActorObjectList.Count;
end;
//boFlag 是否包括死亡对象
//FALSE 包括死亡对象
//TRUE  不包括死亡对象

function TEnvirnoment.GeTActorObjects(nX, nY: Integer; boFlag: Boolean;
  ActorObjectList: TList): Integer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  ActorObject: TActorObject;
begin
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
      BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
      if BaseObject.m_ObjType = t_Actor then begin
        ActorObject := TActorObject(BaseObject);
        if ActorObject <> nil then begin
          if not ActorObject.m_boGhost and ActorObject.bo2B9 then begin
            if (not ActorObject.m_boFixedHideMode) then begin
              if not boFlag or not ActorObject.m_boDeath then
                ActorObjectList.Add(ActorObject);
            end;
          end;
        end;
      end;
    end;
  end;
  Result := ActorObjectList.Count;
end;

function TEnvirnoment.GetEvent(nX, nY: Integer): TBaseObject;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
begin
  Result := nil;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
      BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
      if BaseObject.m_ObjType = t_Event then begin
        Result := BaseObject;
        Break;
      end;
    end;
  end;
end;

function TEnvirnoment.GetEvents(nX, nY, nType: Integer; EventList: TList): Integer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
begin
  Result := 0;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
      BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
      if (BaseObject.m_ObjType = t_Event) and (TEvent(BaseObject).m_nEventType = nType) then begin
        EventList.Add(BaseObject);
      end;
    end;
    Result := EventList.Count;
  end;
end;

function TEnvirnoment.GetRangeEvents(nX, nY, nRage, nType: Integer;
  EventList: TList): Integer;
var
  nXX, nYY: Integer;
begin
  for nXX := nX - nRage to nX + nRage do begin
    for nYY := nY - nRage to nY + nRage do begin
      GetEvents(nXX, nYY, nType, EventList);
    end;
  end;
  Result := EventList.Count;
end;

procedure TEnvirnoment.SetMapXYFlag(nX, nY: Integer; boFlag: Boolean);
var
  MapCellInfo: pTMapCellinfo;
begin
  if GetMapCellInfo(nX, nY, MapCellInfo) then begin
    if boFlag then MapCellInfo.chFlag := 0
    else MapCellInfo.chFlag := 2;
  end;
end;

function TEnvirnoment.CanFly(nSX, nSY, nDX, nDY: Integer): Boolean;
var
  r28, r30: real;
  n14, n18, n1C: Integer;
begin
  Result := True;
  r28 := (nDX - nSX) / 1.0E1;
  r30 := (nDY - nDX) / 1.0E1;
  n14 := 0;
  while (True) do begin
    n18 := Round(nSX + r28);
    n1C := Round(nSY + r30);
    if not CanWalk(n18, n1C, True) then begin
      Result := False;
      Break;
    end;
    Inc(n14);
    if n14 >= 10 then Break;
  end;
end;

function TEnvirnoment.CanFly(Owner: TBaseObject; nSX, nSY, nDX, nDY: Integer): Boolean;
var
  r28, r30: real;
  n14, n18, n1C: Integer;
begin
  Result := True;
  r28 := (nDX - nSX) / 1.0E1;
  r30 := (nDY - nDX) / 1.0E1;
  n14 := 0;
  while (True) do begin
    n18 := Round(nSX + r28);
    n1C := Round(nSY + r30);
    if not CanWalk(n18, n1C, True) { or not CanWalkOfEvent(Owner, n18, n1C)} then begin
      Result := False;
      Break;
    end;
    Inc(n14);
    if n14 >= 10 then Break;
  end;
end;

function TEnvirnoment.GetXYHuman(nMapX, nMapY: Integer): Boolean;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  ActorObject: TActorObject;
begin
  Result := False;
  if GetMapCellInfo(nMapX, nMapY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
      BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
      if BaseObject.m_ObjType = t_Actor then begin
        ActorObject := TActorObject(MapCellInfo.ObjList.Items[I]);
        if ActorObject.m_btRaceServer = RC_PLAYOBJECT then begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetXYObject(nMapX, nMapY: Integer): Boolean;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
begin
  Result := False;
  if GetMapCellInfo(nMapX, nMapY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
      BaseObject := TBaseObject(MapCellInfo.ObjList.Items[I]);
      if BaseObject.m_ObjType = t_Actor then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

function TEnvirnoment.sub_4B5FC8(nX, nY: Integer): Boolean;
var
  MapCellInfo: pTMapCellinfo;
begin
  Result := True;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 2) then
    Result := False;
end;

function TEnvirnoment.GetEnvirInfo: string;
var
  sMsg: string;
begin
  sMsg := '地图名:%s(%s) DAY:%s DARK:%s SAFE:%s FIGHT:%s FIGHT3:%s QUIZ:%s NORECONNECT:%s(%s) MUSIC:%s(%d) EXPRATE:%s(%f) PKWINLEVEL:%s(%d) PKLOSTLEVEL:%s(%d) PKWINEXP:%s(%d) PKLOSTEXP:%s(%d) DECHP:%s(%d/%d) INCHP:%s(%d/%d)';
  sMsg := sMsg + ' DECGAMEGOLD:%s(%d/%d) INCGAMEGOLD:%s(%d/%d) INCGAMEPOINT:%s(%d/%d) RUNHUMAN:%s RUNMON:%s NEEDHOLE:%s NORECALL:%s NOGUILDRECALL:%s NODEARRECALL:%s NOMASTERRECALL:%s NODRUG:%s MINE:%s NOPOSITIONMOVE:%s';
  Result := Format(sMsg, [sMapName,
    sMapDesc,
      BoolToCStr(m_boDAY),
      BoolToCStr(m_boDARK),
      BoolToCStr(m_boSAFE),
      BoolToCStr(m_boFightZone),
      BoolToCStr(m_boFight3Zone),
      BoolToCStr(m_boQUIZ),
      BoolToCStr(m_boNORECONNECT), sNoReconnectMap,
      BoolToCStr(m_boMUSIC), m_nMUSICID,
      BoolToCStr(m_boEXPRATE), m_nEXPRATE / 100,
      BoolToCStr(m_boPKWINLEVEL), m_nPKWINLEVEL,
      BoolToCStr(m_boPKLOSTLEVEL), m_nPKLOSTLEVEL,
      BoolToCStr(m_boPKWINEXP), m_nPKWINEXP,
      BoolToCStr(m_boPKLOSTEXP), m_nPKLOSTEXP,
      BoolToCStr(m_boDECHP), m_nDECHPTIME, m_nDECHPPOINT,
      BoolToCStr(m_boINCHP), m_nINCHPTIME, m_nINCHPPOINT,
      BoolToCStr(m_boDecGameGold), m_nDECGAMEGOLDTIME, m_nDecGameGold,
      BoolToCStr(m_boIncGameGold), m_nINCGAMEGOLDTIME, m_nIncGameGold,
      BoolToCStr(m_boINCGAMEPOINT), m_nINCGAMEPOINTTIME, m_nINCGAMEPOINT,
      BoolToCStr(m_boRUNHUMAN),
      BoolToCStr(m_boRUNMON),
      BoolToCStr(m_boNEEDHOLE),
      BoolToCStr(m_boNORECALL),
      BoolToCStr(m_boNOGUILDRECALL),
      BoolToCStr(m_boNODEARRECALL),
      BoolToCStr(m_boNOMASTERRECALL),
      BoolToCStr(m_boNODRUG),
      BoolToCStr(m_boMINE),
      BoolToCStr(m_boNOPOSITIONMOVE)
      ]);
end;

procedure TEnvirnoment.AddObject(ActorObject: TBaseObject);
var
  btRaceServer: Byte;
begin
  try
    case ActorObject.m_ObjType of
      t_Event: begin
          Inc(m_nEventCount);
          Inc(g_MapManager.m_nEventCount);
        end;
      t_Gate: begin
          Inc(m_nGateCount);
          Inc(g_MapManager.m_nGateCount);
        end;
      t_Item: begin
          Inc(m_nItemCount);
          Inc(g_MapManager.m_nItemCount);
        end;
      t_Actor: begin
          btRaceServer := TActorObject(ActorObject).m_btRaceServer;
          if btRaceServer = RC_PLAYOBJECT then begin
            Inc(m_nHumCount);
            Inc(g_MapManager.m_nHumCount);
          //MainOutMessage('m_PEnvir.AddObject(Self):' + TActorObject(ActorObject).m_sCharName + ' ' + IntToStr(g_MapManager.m_nHumCount));
          end else
            if btRaceServer = RC_HEROOBJECT then begin
            Inc(m_nHeroCount);
            Inc(g_MapManager.m_nHeroCount);
          end else
            if (btRaceServer in [RC_NPC, RC_PEACENPC]) then begin
            Inc(m_nNpcCount);
            Inc(g_MapManager.m_nNpcCount);
          end else begin
            Inc(m_nMonCount);
            Inc(g_MapManager.m_nMonCount);
          end;
        end;
    end;
  except
    MainOutMessage('[Exception] TEnvirnoment::AddObject');
  end;
end;

procedure TEnvirnoment.DelObject(ActorObject: TBaseObject);
var
  btRaceServer: Byte;
begin
  try
    case ActorObject.m_ObjType of
      t_Event: begin
          Dec(m_nEventCount);
          Dec(g_MapManager.m_nEventCount);
        end;
      t_Gate: begin
          Dec(m_nGateCount);
          Dec(g_MapManager.m_nGateCount);
        end;
      t_Item: begin
          Dec(m_nItemCount);
          Dec(g_MapManager.m_nItemCount);
        end;
      t_Actor: begin
          btRaceServer := TActorObject(ActorObject).m_btRaceServer;
          if btRaceServer = RC_PLAYOBJECT then begin
            Dec(m_nHumCount);
            Dec(g_MapManager.m_nHumCount);
          end else
            if btRaceServer = RC_HEROOBJECT then begin
            Dec(m_nHeroCount);
            Dec(g_MapManager.m_nHeroCount);
          end else
            if (btRaceServer in [RC_NPC, RC_PEACENPC]) then begin
            Dec(m_nNpcCount);
            Dec(g_MapManager.m_nNpcCount);
          end else begin
            Dec(m_nMonCount);
            Dec(g_MapManager.m_nMonCount);
          end;
        end;
    end;
  except
    MainOutMessage('[Exception] TEnvirnoment::DelObject');
  end;
end;

procedure TEnvirnoment.Run;
begin

end;

function TMapManager.GetMonGenCount: Integer;
begin

end;

end.

