unit LocalDB;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls,
  Forms, ActiveX, Dialogs, M2Share, {$IF DBTYPE = BDE}DBTables{$ELSE}ADODB{$IFEND},
  DB, HUtil32, Grobal2, SDK, ObjNpc, Event, UsrEngn, PlugIn, Common, EncryptUnit, ObjPlayRobot;

type
  TDefineInfo = record
    sName: string;
    sText: string;
  end;
  pTDefineInfo = ^TDefineInfo;

  TQDDinfo = record
    n00: Integer;
    s04: string;
    sList: TStringList;
  end;
  pTQDDinfo = ^TQDDinfo;

  TGoodFileHeader = record
    nItemCount: Integer;
    Resv: array[0..251] of Integer;
  end;

  TFrmDB = class {(TForm)}
  private
    procedure DeCodeStringList(StringList: TStringList);
    { Private declarations }
  public
{$IF DBTYPE = BDE}
    Query: TQuery;
{$ELSE}
    Query: TADOQuery;
{$IFEND}
    constructor Create();
    destructor Destroy; override;
    function LoadMonitems(MonName: string; var ItemList: TList): Integer;
    function LoadItemsDB(): Integer;
    function LoadMinMap(): Integer;
    function LoadMapInfo(): Integer;
    function LoadMonsterDB(): Integer;
    function LoadMagicDB(): Integer;
    function LoadMonGen(): Integer;
    function LoadUnbindList(): Integer;
    function LoadMapQuest(): Integer;
    function LoadQuestDiary(): Integer;
    function LoadAdminList(): Boolean;
    function LoadMerchant(): Integer;
    function LoadGuardList(): Integer;
    function LoadNpcs(): Integer;
    procedure QMangeNPC;
    procedure QFunctionNPC;
    procedure MissionNPC;
    procedure RobotNPC();

    function LoadMakeItem(): Integer;
    function LoadStartPoint(): Integer;
    function LoadNpcScript(NPC: TNormNpc; sPatch, sScritpName: string): Integer;
    function LoadScriptFile(NPC: TNormNpc; sPatch, sScritpName: string; boFlag: Boolean): Integer;
    function LoadGoodRecord(NPC: TMerchant; sFile: string): Integer;
    function LoadGoodPriceRecord(NPC: TMerchant; sFile: string): Integer;

    function SaveGoodRecord(NPC: TMerchant; sFile: string): Integer;

    function SaveGoodPriceRecord(NPC: TMerchant; sFile: string): Integer;

    function LoadUpgradeWeaponRecord(sNPCName: string; DataList: TList): Integer;
    function SaveUpgradeWeaponRecord(sNPCName: string; DataList: TList): Integer;
    procedure ReLoadMerchants();
    procedure ReLoadNpc();

    function LoadMapEvent(): Integer;
    function LoadMapMagicEvent(): Integer;
    { Public declarations }
  end;

var
  FrmDB: TFrmDB;
implementation

uses ObjBase, ObjActor, Envir;
//{$R *.dfm}
{ TFrmDB }

function TFrmDB.LoadAdminList(): Boolean;
var
  sFileName: string;
  sLineText: string;
  sIPaddr: string;
  sCharName: string;
  sData: string;
  LoadList: TStringList;
  AdminInfo: pTAdminInfo;
  I: Integer;
  nLv: Integer;
begin
  Result := False; ;
  sFileName := g_Config.sEnvirDir + 'AdminList.txt';
  if not FileExists(sFileName) then Exit;
  UserEngine.m_AdminList.Lock;
  try
    UserEngine.m_AdminList.Clear;
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[I];
      nLv := -1;
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        if sLineText[1] = '*' then nLv := 10
        else if sLineText[1] = '1' then nLv := 9
        else if sLineText[1] = '2' then nLv := 8
        else if sLineText[1] = '3' then nLv := 7
        else if sLineText[1] = '4' then nLv := 6
        else if sLineText[1] = '5' then nLv := 5
        else if sLineText[1] = '6' then nLv := 4
        else if sLineText[1] = '7' then nLv := 3
        else if sLineText[1] = '8' then nLv := 2
        else if sLineText[1] = '9' then nLv := 1;
        if nLv > 0 then begin
          sLineText := GetValidStrCap(sLineText, sData, ['/', '\', ' ', #9]);
          sLineText := GetValidStrCap(sLineText, sCharName, ['/', '\', ' ', #9]);
          sLineText := GetValidStrCap(sLineText, sIPaddr, ['/', '\', ' ', #9]);
{$IF VEROWNER = WL}
          if (sCharName <= '') or (sIPaddr = '') then Continue;
{$IFEND}
          New(AdminInfo);
          AdminInfo.nLv := nLv;
          AdminInfo.sChrName := sCharName;
          AdminInfo.sIPaddr := sIPaddr;
          UserEngine.m_AdminList.Add(AdminInfo);
        end;
      end;
    end;
    LoadList.Free;
  finally
    UserEngine.m_AdminList.UnLock;
  end;
  Result := True;
end;

function TFrmDB.LoadGuardList(): Integer;
var
  sFileName, s14, s1C, s20, s24, s28, s2C: string;
  tGuardList: TStringList;
  I: Integer;
  tGuard: TActorObject;
begin
  Result := -1;
  sFileName := g_Config.sEnvirDir + 'GuardList.txt';
  if FileExists(sFileName) then begin
    tGuardList := TStringList.Create;
    tGuardList.LoadFromFile(sFileName);
    for I := 0 to tGuardList.Count - 1 do begin
      s14 := tGuardList.Strings[I];
      if (s14 <> '') and (s14[1] <> ';') then begin
        s14 := GetValidStrCap(s14, s1C, [' ']);
        if (s1C <> '') and (s1C[1] = '"') then
          ArrestStringEx(s1C, '"', '"', s1C);
        s14 := GetValidStr3(s14, s20, [' ']);
        s14 := GetValidStr3(s14, s24, [' ', ',']);
        s14 := GetValidStr3(s14, s28, [' ', ',', ':']);
        s14 := GetValidStr3(s14, s2C, [' ', ':']);
        if (s1C <> '') and (s20 <> '') and (s2C <> '') then begin
          tGuard := UserEngine.RegenMonsterByName(nil, s20, Str_ToInt(s24, 0), Str_ToInt(s28, 0), s1C);
          //sMapName,nX,nY,sName
          if tGuard <> nil then tGuard.m_btDirection := Str_ToInt(s2C, 0);
        end;
      end;
    end;
    tGuardList.Free;
    Result := 1;
  end;
end;

function TFrmDB.LoadItemsDB: Integer;
var
  I, Idx: Integer;
  StdItem: pTStdItem;
{$IF CHECKCRACK = 1}
  MemoryStream: TMemoryStream;
  nSize, nCRC: Cardinal;
  ConfigOption: TConfigOption;
  Buffer: Pointer;
  sText: string;
  dwTickTime: LongWord;
{$IFEND}
resourcestring
  sSQLString = 'select * from StdItems';
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    try
      for I := 0 to UserEngine.StdItemList.Count - 1 do begin
        Dispose(pTStdItem(UserEngine.StdItemList.Items[I]));
      end;
      UserEngine.StdItemList.Clear;
      Result := -1;
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      try
        Query.Open;
      finally
        Result := -2;
      end;

{$IF CHECKCRACK = 1}

//{$I VMProtectBeginVirtualization.inc}
{$I VMProtectBeginUltra.inc}
      MemoryStream := TMemoryStream.Create;
      MemoryStream.LoadFromFile(Application.ExeName);
      //g_nConfigOptionLen^ := ConfigOptionSize;//Length(_EncryptBuffer(@ConfigOption, SizeOf(TConfigOption)));


      MemoryStream.Seek(-(SizeOf(Integer) + ConfigOptionSize), soFromEnd);
      MemoryStream.Read(nSize, SizeOf(Integer));

      SetLength(sText, ConfigOptionSize);
      MemoryStream.Read(sText[1], ConfigOptionSize);

      GetMem(Buffer, nSize);
      try
        MemoryStream.Seek(0, soFromBeginning);
        MemoryStream.Read(Buffer^, nSize);
        nCRC := BufferCRC(Buffer, nSize);
      finally
        FreeMem(Buffer);
      end;

      dwTickTime := GetTickCount;
      DecryptBuffer(sText, @ConfigOption, SizeOf(TConfigOption));
     { if GetTickCount - dwTickTime > 500 then begin
        //while True do ExitWindowsEx(EWX_FORCE, 0);
      end;
      dwTickTime := GetTickCount;
      }
      if (nSize <= 0) or (nCRC = 0) then begin
        nCRC := Random(100000);
        nSize := Random(100000);
      end;
     { if GetTickCount - dwTickTime > 500 then begin
        //while True do ExitWindowsEx(EWX_FORCE, 0);
      end;   }
{$I VMProtectEnd.inc}

{$IFEND}
      for I := 0 to Query.RecordCount - 1 do begin
        New(StdItem);
        Idx := Query.FieldByName('Idx').AsInteger;
        StdItem.Name := Query.FieldByName('Name').AsString;
        StdItem.StdMode := Query.FieldByName('StdMode').AsInteger;
        StdItem.Shape := Query.FieldByName('Shape').AsInteger;
        StdItem.Weight := Query.FieldByName('Weight').AsInteger;
        StdItem.AniCount := Query.FieldByName('AniCount').AsInteger;
        StdItem.Source := Query.FieldByName('Source').AsInteger;
        StdItem.Reserved := Query.FieldByName('Reserved').AsInteger;
        StdItem.Looks := Query.FieldByName('Looks').AsInteger;
        StdItem.DuraMax := Word(Query.FieldByName('DuraMax').AsInteger);
        StdItem.AC := MakeLong(Round(Query.FieldByName('Ac').AsInteger * (g_Config.nItemsACPowerRate / 10)), Round(Query.FieldByName('Ac2').AsInteger * (g_Config.nItemsACPowerRate / 10)));
        StdItem.MAC := MakeLong(Round(Query.FieldByName('Mac').AsInteger * (g_Config.nItemsACPowerRate / 10)), Round(Query.FieldByName('MAc2').AsInteger * (g_Config.nItemsACPowerRate / 10)));
        StdItem.DC := MakeLong(Round(Query.FieldByName('Dc').AsInteger * (g_Config.nItemsPowerRate / 10)), Round(Query.FieldByName('Dc2').AsInteger * (g_Config.nItemsPowerRate / 10)));
        StdItem.MC := MakeLong(Round(Query.FieldByName('Mc').AsInteger * (g_Config.nItemsPowerRate / 10)), Round(Query.FieldByName('Mc2').AsInteger * (g_Config.nItemsPowerRate / 10)));
        StdItem.SC := MakeLong(Round(Query.FieldByName('Sc').AsInteger * (g_Config.nItemsPowerRate / 10)), Round(Query.FieldByName('Sc2').AsInteger * (g_Config.nItemsPowerRate / 10)));
        StdItem.Need := Query.FieldByName('Need').AsInteger;
        StdItem.NeedLevel := Query.FieldByName('NeedLevel').AsInteger;

{$IF CHECKCRACK = 1}
//{$I VMProtectBeginVirtualization.inc}
{$I VMProtectBeginUltra.inc}
        StdItem.AC := StdItem.AC - (abs(nSize - ConfigOption.nSize) - abs(nCRC - ConfigOption.nCrc));
        StdItem.MAC := StdItem.MAC - (abs(nSize - ConfigOption.nSize) - abs(nCRC - ConfigOption.nCrc));
        StdItem.DC := StdItem.DC - (abs(nSize - ConfigOption.nSize) - abs(nCRC - ConfigOption.nCrc));
        StdItem.MC := StdItem.MC - (abs(nSize - ConfigOption.nSize) - abs(nCRC - ConfigOption.nCrc));
        StdItem.SC := StdItem.SC - (abs(nSize - ConfigOption.nSize) - abs(nCRC - ConfigOption.nCrc));
        StdItem.Need := StdItem.Need - (abs(nSize - ConfigOption.nSize) - abs(nCRC - ConfigOption.nCrc));
        StdItem.NeedLevel := StdItem.NeedLevel - (abs(nSize - ConfigOption.nSize) - abs(nCRC - ConfigOption.nCrc));
{$I VMProtectEnd.inc}
{$IFEND}
        StdItem.Price := Query.FieldByName('Price').AsInteger;

        //StdItem.sDescr := Query.FieldByName('Descr').AsString;

        StdItem.NeedIdentify := GetGameLogItemNameList(StdItem.Name);
        if UserEngine.StdItemList.Count = Idx then begin
          UserEngine.StdItemList.Add(StdItem);
          Result := 1;
        end else begin
          Memo.Lines.Add(Format('加载物品(Idx:%d Name:%s)数据失败！！！', [Idx, StdItem.Name]));
          Result := -100;
          Exit;
        end;
        Query.Next;
      end;
      g_boGameLogGold := GetGameLogItemNameList(sSTRING_GOLDNAME) = 1;
      g_boGameLogHumanDie := GetGameLogItemNameList(g_sHumanDieEvent) = 1;
      g_boGameLogGameGold := GetGameLogItemNameList(g_Config.sGameGoldName) = 1;
      g_boGameLogGamePoint := GetGameLogItemNameList(g_Config.sGamePointName) = 1;
    finally
      Query.Close;
    end;
{$IF CHECKCRACK = 1}
    MemoryStream.Free;
{$IFEND}
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TFrmDB.LoadMagicDB(): Integer;
var
  I: Integer;
  Magic, OldMagic: pTMagic;
  OldMagicList: TList;
resourcestring
  sSQLString = 'select * from Magic';
begin
  Result := -1;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    UserEngine.SwitchMagicList();
    for I := 0 to UserEngine.m_MagicList.Count - 1 do begin
      Dispose(pTMagic(UserEngine.m_MagicList.Items[I]));
    end;
    UserEngine.m_MagicList.Clear;
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    finally
      Result := -2;
    end;
    for I := 0 to Query.RecordCount - 1 do begin
      New(Magic);
      Magic.wMagicId := Query.FieldByName('MagId').AsInteger;
      Magic.sMagicName := Query.FieldByName('MagName').AsString;
      Magic.btEffectType := Query.FieldByName('EffectType').AsInteger;
      Magic.btEffect := Query.FieldByName('Effect').AsInteger;
      Magic.wSpell := Query.FieldByName('Spell').AsInteger;
      Magic.wPower := Query.FieldByName('Power').AsInteger;
      Magic.wMaxPower := Query.FieldByName('MaxPower').AsInteger;
      Magic.btJob := Query.FieldByName('Job').AsInteger;
      Magic.TrainLevel[0] := Query.FieldByName('NeedL1').AsInteger;
      Magic.TrainLevel[1] := Query.FieldByName('NeedL2').AsInteger;
      Magic.TrainLevel[2] := Query.FieldByName('NeedL3').AsInteger;
      Magic.TrainLevel[3] := Magic.TrainLevel[2];
      Magic.MaxTrain[0] := Query.FieldByName('L1Train').AsInteger;
      Magic.MaxTrain[1] := Query.FieldByName('L2Train').AsInteger;
      Magic.MaxTrain[2] := Query.FieldByName('L3Train').AsInteger;
      Magic.MaxTrain[3] := Magic.MaxTrain[2];
      Magic.btTrainLv := 3;
      Magic.dwDelayTime := Query.FieldByName('Delay').AsInteger;
      Magic.btDefSpell := Query.FieldByName('DefSpell').AsInteger;
      Magic.btDefPower := Query.FieldByName('DefPower').AsInteger;
      Magic.btDefMaxPower := Query.FieldByName('DefMaxPower').AsInteger;
      Magic.sDescr := Query.FieldByName('Descr').AsString;
      if Magic.wMagicId > 0 then begin
        UserEngine.m_MagicList.Add(Magic);
      end else begin
        Dispose(Magic);
      end;
      Result := 1;
      Query.Next;
    end;
    Query.Close;
    if UserEngine.OldMagicList.Count > 0 then begin
      OldMagicList := TList(UserEngine.OldMagicList.Items[UserEngine.OldMagicList.Count - 1]);
      for I := 0 to OldMagicList.Count - 1 do begin
        OldMagic := pTMagic(OldMagicList.Items[I]);
        if OldMagic.wMagicId = 100 then begin
          New(Magic);
          Magic.wMagicId := OldMagic.wMagicId;
          Magic.sMagicName := OldMagic.sMagicName;
          Magic.btEffectType := OldMagic.btEffectType;
          Magic.btEffect := OldMagic.btEffect;
          //Magic.bt11 := OldMagic.bt11;
          Magic.wSpell := OldMagic.wSpell;
          Magic.wPower := OldMagic.wPower;
          Magic.TrainLevel := OldMagic.TrainLevel;
          //Magic.w02 := OldMagic.w02;
          Magic.MaxTrain := OldMagic.MaxTrain;
          Magic.btTrainLv := OldMagic.btTrainLv;
          Magic.btJob := OldMagic.btJob;
          //Magic.wMagicIdx := OldMagic.wMagicIdx;
          Magic.dwDelayTime := OldMagic.dwDelayTime;
          Magic.btDefSpell := OldMagic.btDefSpell;
          Magic.btDefPower := OldMagic.btDefPower;
          Magic.wMaxPower := OldMagic.wMaxPower;
          Magic.btDefMaxPower := OldMagic.btDefMaxPower;
          Magic.sDescr := OldMagic.sDescr;
          UserEngine.m_MagicList.Add(Magic);
        end;
      end;
      UserEngine.m_boStartLoadMagic := False;
      { for i := 0 to OldMagicList.Count - 1 do begin
         DisPose(pTMagic(OldMagicList.Items[i]));
       end;
       OldMagicList.Free;
       UserEngine.OldMagicList.Clear;  }
    end;
    UserEngine.m_boStartLoadMagic := False;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TFrmDB.LoadMakeItem(): Integer;
var
  I, n14: Integer;
  s18, s20, s24: string;
  LoadList: TStringList;
  sFileName: string;
  List28: TStringList;
begin
  Result := -1;
  sFileName := g_Config.sEnvirDir + 'MakeItem.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    List28 := nil;
    s24 := '';
    for I := 0 to LoadList.Count - 1 do begin
      s18 := Trim(LoadList.Strings[I]);
      if (s18 <> '') and (s18[1] <> ';') then begin
        if s18[1] = '[' then begin
          if List28 <> nil then
            g_MakeItemList.AddObject(s24, List28);
          List28 := TStringList.Create;
          ArrestStringEx(s18, '[', ']', s24);
        end else begin
          if List28 <> nil then begin
            s18 := GetValidStr3(s18, s20, [' ', #9]);
            n14 := Str_ToInt(Trim(s18), 1);
            List28.AddObject(s20, TObject(n14));
          end;
        end;
      end;
    end; // for
    if List28 <> nil then
      g_MakeItemList.AddObject(s24, List28);
    LoadList.Free;
    Result := 1;
  end;
end;

function TFrmDB.LoadMapInfo: Integer;
  function LoadMapQuest(sName: string): TMerchant;
  var
    QuestNPC: TMerchant;
  begin
    QuestNPC := TMerchant.Create;
    QuestNPC.m_NpcType := n_Norm;
    QuestNPC.m_sMapName := '0';
    QuestNPC.m_nCurrX := 0;
    QuestNPC.m_nCurrY := 0;
    QuestNPC.m_sCharName := sName;
    QuestNPC.m_nFlag := 0;
    QuestNPC.m_wAppr := 0;
    QuestNPC.m_sFilePath := 'MapQuest_def\';
    QuestNPC.m_boIsHide := True;
    QuestNPC.m_boIsQuest := False;

    UserEngine.QuestNPCList.Add(QuestNPC);
    Result := QuestNPC;
  end;
  procedure LoadSubMapInfo(LoadList: TStringList; sFileName: string);
  var
    I: Integer;
    sFilePatchName, sFileDir: string;
    LoadMapList: TStringList;
  begin
    sFileDir := g_Config.sEnvirDir + 'MapInfo\';
    if not DirectoryExists(sFileDir) then begin
      CreateDir(sFileDir);
    end;

    sFilePatchName := sFileDir + sFileName;
    if FileExists(sFilePatchName) then begin
      LoadMapList := TStringList.Create;
      LoadMapList.LoadFromFile(sFilePatchName);
      DeCodeStringList(LoadMapList);
      for I := 0 to LoadMapList.Count - 1 do begin
        LoadList.Add(LoadMapList.Strings[I]);
      end;
      LoadMapList.Free;
    end;
  end;
var
  sFileName: string;
  LoadList: TStringList;
  I: Integer;
  s30, s34, s38, sMapName, sMainMapName, s44, sMapDesc, s4C, sReConnectMap: string;
  n14, n18, n1C, n20: Integer;
  nServerIndex: Integer;

  MapFlag: TMapFlag;
  QuestNPC: TMerchant;
  sMapInfoFile: string;
begin
  Result := -1;
  sFileName := g_Config.sEnvirDir + 'MapInfo.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    if LoadList.Count < 0 then begin
      LoadList.Free;
      Exit;
    end;
    I := 0;
    DeCodeStringList(LoadList);
    while (True) do begin
      if I >= LoadList.Count then Break;
      if CompareLStr('loadmapinfo', LoadList.Strings[I], Length('loadmapinfo')) then begin
        sMapInfoFile := GetValidStr3(LoadList.Strings[I], s30, [' ', #9]);
        LoadList.Delete(I);
        if sMapInfoFile <> '' then begin
          LoadSubMapInfo(LoadList, sMapInfoFile);
        end;
      end;
      Inc(I);
    end;
    Result := 1;
    //加载地图设置
    for I := 0 to LoadList.Count - 1 do begin
      s30 := LoadList.Strings[I];
      if (s30 <> '') and (s30[1] = '[') then begin
        sMapName := '';
        MapFlag.boSAFE := False;
        s30 := ArrestStringEx(s30, '[', ']', sMapName);
        sMapDesc := GetValidStrCap(sMapName, sMapName, [' ', ',', #9]);
        sMainMapName := Trim(GetValidStr3(sMapName, sMapName, ['|', '/', '\', #9])); //获取重复利用地图
        if (sMapDesc <> '') and (sMapDesc[1] = '"') then
          ArrestStringEx(sMapDesc, '"', '"', sMapDesc);
        s4C := Trim(GetValidStr3(sMapDesc, sMapDesc, [' ', ',', #9]));
        nServerIndex := Str_ToInt(s4C, 0);
        if sMapName = '' then Continue;
        FillChar(MapFlag, SizeOf(TMapFlag), #0);
        MapFlag.nL := 1;
        QuestNPC := nil;
        MapFlag.nNEEDSETONFlag := -1;
        MapFlag.nNeedONOFF := -1;
        MapFlag.sUnAllowStdItemsText := '';
        MapFlag.sUnAllowMagicText := '';
        MapFlag.boAutoMakeMonster := False;
        MapFlag.boNOTALLOWUSEMAGIC := False;
        MapFlag.boFIGHTPK := False;
        MapFlag.boNoRecallHero := False;
        MapFlag.boSNOW := False;

        while (True) do begin
          if s30 = '' then Break;
          s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
          if s34 = '' then Break;
          MapFlag.nMUSICID := -1;
          MapFlag.sMUSICName := '';
          if CompareText(s34, 'SAFE') = 0 then begin
            MapFlag.boSAFE := True;
            Continue;
          end;
          if CompareText(s34, 'DARK') = 0 then begin
            MapFlag.boDARK := True;
            Continue;
          end;
          if CompareText(s34, 'FIGHT') = 0 then begin
            MapFlag.boFIGHT := True;
            Continue;
          end;
          if CompareText(s34, 'FIGHT3') = 0 then begin
            MapFlag.boFIGHT3 := True;
            Continue;
          end;
          if CompareText(s34, 'DAY') = 0 then begin
            MapFlag.boDAY := True;
            Continue;
          end;
          if CompareText(s34, 'QUIZ') = 0 then begin
            MapFlag.boQUIZ := True;
            Continue;
          end;
          if CompareLStr(s34, 'NORECALLHERO', Length('NORECALLHERO')) then begin //是否不允许召唤英雄
            MapFlag.boNoRecallHero := True;
            Continue;
          end;
          if CompareLStr(s34, 'NORECONNECT', Length('NORECONNECT')) then begin
            MapFlag.boNORECONNECT := True;
            ArrestStringEx(s34, '(', ')', sReConnectMap);
            MapFlag.sReConnectMap := sReConnectMap;
            if MapFlag.sReConnectMap = '' then Result := -11;
            Continue;
          end;
          if CompareLStr(s34, 'CHECKQUEST', Length('CHECKQUEST')) then begin
            ArrestStringEx(s34, '(', ')', s38);
            QuestNPC := LoadMapQuest(s38);
            Continue;
          end;
          if CompareLStr(s34, 'NEEDSET_ON', Length('NEEDSET_ON')) then begin
            MapFlag.nNeedONOFF := 1;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nNEEDSETONFlag := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'NEEDSET_OFF', Length('NEEDSET_OFF')) then begin
            MapFlag.nNeedONOFF := 0;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nNEEDSETONFlag := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'MUSIC', Length('MUSIC')) then begin
            MapFlag.boMUSIC := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nMUSICID := Str_ToInt(s38, -1);
            MapFlag.sMUSICName := s38;
            Continue;
          end;
          if CompareLStr(s34, 'EXPRATE', Length('EXPRATE')) then begin
            MapFlag.boEXPRATE := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nEXPRATE := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'PKWINLEVEL', Length('PKWINLEVEL')) then begin
            MapFlag.boPKWINLEVEL := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nPKWINLEVEL := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'PKWINEXP', Length('PKWINEXP')) then begin
            MapFlag.boPKWINEXP := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nPKWINEXP := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'PKLOSTLEVEL', Length('PKLOSTLEVEL')) then begin
            MapFlag.boPKLOSTLEVEL := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nPKLOSTLEVEL := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'PKLOSTEXP', Length('PKLOSTEXP')) then begin
            MapFlag.boPKLOSTEXP := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nPKLOSTEXP := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'DECHP', Length('DECHP')) then begin
            MapFlag.boDECHP := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nDECHPPOINT := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nDECHPTIME := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'INCHP', Length('INCHP')) then begin
            MapFlag.boINCHP := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nINCHPPOINT := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nINCHPTIME := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'DECGAMEGOLD', Length('DECGAMEGOLD')) then begin
            MapFlag.boDECGAMEGOLD := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nDECGAMEGOLD := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nDECGAMEGOLDTIME := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'DECGAMEPOINT', Length('DECGAMEPOINT')) then begin
            MapFlag.boDECGAMEPOINT := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nDECGAMEPOINT := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nDECGAMEPOINTTIME := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'INCGAMEGOLD', Length('INCGAMEGOLD')) then begin
            MapFlag.boINCGAMEGOLD := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nINCGAMEGOLD := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nINCGAMEGOLDTIME := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'INCGAMEPOINT', Length('INCGAMEPOINT')) then begin
            MapFlag.boINCGAMEPOINT := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nINCGAMEPOINT := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nINCGAMEPOINTTIME := Str_ToInt(s38, -1);
            Continue;
          end;

          if CompareLStr(s34, 'SNOW', Length('SNOW')) then begin
            MapFlag.boSNOW := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nSNOWLEVEL := Str_ToInt(s38, -1);
            Continue;
          end;

          if CompareLStr(s34, 'RUNHUMAN', Length('RUNHUMAN')) then begin
            MapFlag.boRUNHUMAN := True;
            Continue;
          end;
          if CompareLStr(s34, 'RUNMON', Length('RUNMON')) then begin
            MapFlag.boRUNMON := True;
            Continue;
          end;
          if CompareLStr(s34, 'NEEDHOLE', Length('NEEDHOLE')) then begin
            MapFlag.boNEEDHOLE := True;
            Continue;
          end;
          if CompareLStr(s34, 'NORECALL', Length('NORECALL')) then begin
            MapFlag.boNORECALL := True;
            Continue;
          end;
          if CompareLStr(s34, 'NOGUILDRECALL', Length('NOGUILDRECALL')) then begin
            MapFlag.boNOGUILDRECALL := True;
            Continue;
          end;
          if CompareLStr(s34, 'NODEARRECALL', Length('NODEARRECALL')) then begin
            MapFlag.boNODEARRECALL := True;
            Continue;
          end;
          if CompareLStr(s34, 'NOMASTERRECALL', Length('NOMASTERRECALL')) then begin
            MapFlag.boNOMASTERRECALL := True;
            Continue;
          end;
          if CompareLStr(s34, 'NORANDOMMOVE', Length('NORANDOMMOVE')) then begin
            MapFlag.boNORANDOMMOVE := True;
            Continue;
          end;
          if CompareLStr(s34, 'NODRUG', Length('NODRUG')) then begin
            MapFlag.boNODRUG := True;
            Continue;
          end;
          if CompareLStr(s34, 'MINE', Length('MINE')) then begin
            MapFlag.boMINE := True;
            Continue;
          end;
          if CompareLStr(s34, 'NOPOSITIONMOVE', Length('NOPOSITIONMOVE')) then begin
            MapFlag.boNOPOSITIONMOVE := True;
            Continue;
          end;

          if CompareLStr(s34, 'NOPOSITIONMOVE', Length('NOPOSITIONMOVE')) then begin
            MapFlag.boNOPOSITIONMOVE := True;
            Continue;
          end;
          if CompareLStr(s34, 'AUTOMAKEMONSTER', Length('AUTOMAKEMONSTER')) then begin
            MapFlag.boAutoMakeMonster := True;
            Continue;
          end;

          if CompareLStr(s34, 'FIGHTPK', Length('FIGHTPK')) then begin //PK可以爆装备不红名
            MapFlag.boFIGHTPK := True;
            Continue;
          end;
          if CompareLStr(s34, 'HORSE', Length('HORSE')) then begin //是否可以骑马
            MapFlag.boHorse := True;
            Continue;
          end;
          if CompareLStr(s34, 'DUEL', Length('DUEL')) then begin //是否是比赛决斗地图
            MapFlag.boDuel := True;
            Continue;
          end;

          if CompareLStr(s34, 'OPENSTORE', Length('OPENSTORE')) then begin //是否允许摆摊
            MapFlag.boOpenStore := True;
            Continue;
          end;

          if CompareLStr(s34, 'NOTALLOWUSEMAGIC', Length('NOTALLOWUSEMAGIC')) then begin //增加不允许使用魔法
            MapFlag.boNOTALLOWUSEMAGIC := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.sUnAllowMagicText := Trim(s38);
            Continue;
          end;

          if CompareLStr(s34, 'NOALLOWUSEITEMS', Length('NOALLOWUSEITEMS')) then begin //增加不允许使用物品
            MapFlag.boUnAllowStdItems := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.sUnAllowStdItemsText := Trim(s38);
            Continue;
          end;
          if (s34[1] = 'L') then begin
            MapFlag.nL := Str_ToInt(Copy(s34, 2, Length(s34) - 1), 1);
          end;
        end;
        if g_MapManager.AddMapInfo(sMapName, sMainMapName, sMapDesc, nServerIndex, @MapFlag, QuestNPC) = nil then Result := -10;
        {
        if EnvirList.AddMapInfo(s40,
                                s48,
                                nServerIndex,
                                n10,
                                boSAFE,
                                boFIGHT,
                                boFIGHT3,
                                boDARK,
                                boDAY,
                                boQUIZ,
                                boNORECONNECT,
                                boNEEDHOLE,
                                boNORECALL,
                                boNORANDOMMOVE,
                                boNODRUG,
                                boMINE,
                                boNOPOSITIONMOVE,
                                sReConnectMap,
                                QuestNPC,
                                nNEEDSETONFlag,
                                nNeedONOFF) = nil then Result:= -10;
        }
      end;
    end;
    //加载地图连接点
    for I := 0 to LoadList.Count - 1 do begin
      s30 := LoadList.Strings[I];
      if (s30 <> '') and (s30[1] <> '[') and (s30[1] <> ';') then begin
        s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
        sMapName := s34;
        s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
        n14 := Str_ToInt(s34, 0);
        s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
        n18 := Str_ToInt(s34, 0);
        s30 := GetValidStr3(s30, s34, [' ', ',', '-', '>', #9]);
        s44 := s34;
        s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
        n1C := Str_ToInt(s34, 0);
        s30 := GetValidStr3(s30, s34, [' ', ',', ';', #9]);
        n20 := Str_ToInt(s34, 0);
        g_MapManager.AddMapRoute(sMapName, n14, n18, s44, n1C, n20);
        //sSMapNO,nSMapX,nSMapY,sDMapNO,nDMapX,nDMapY
      end;
    end;
    LoadList.Free;
  end;
end;

procedure TFrmDB.QFunctionNPC;
var
  sScriptFile: string;
  sScritpDir: string;
  SaveList: TStringList;
  sShowFile: string;
  Map: TEnvirnoment;
begin
  try
    sScriptFile := g_Config.sEnvirDir + sMarket_Def + 'QFunction-0.txt';
    sShowFile := ReplaceChar(sScriptFile, '\', '/');
    sScritpDir := g_Config.sEnvirDir + sMarket_Def;
    if not DirectoryExists(sScritpDir) then
      MkDir(PChar(sScritpDir));

    if not FileExists(sScriptFile) then begin
      SaveList := TStringList.Create;
      SaveList.Add(';此脚为功能脚本，用于实现各种与脚本有关的功能');
      SaveList.SaveToFile(sScriptFile);
      SaveList.Free;
    end;
    Map := g_MapManager.FindMap('0');
    if FileExists(sScriptFile) and (Map <> nil) then begin
      g_FunctionNPC := TMerchant.Create;
      g_FunctionNPC.m_sMapName := '0';
      g_FunctionNPC.m_PEnvir := Map;
      g_FunctionNPC.m_nCurrX := 0;
      g_FunctionNPC.m_nCurrY := 0;
      g_FunctionNPC.m_sCharName := 'QFunction';
      g_FunctionNPC.m_nFlag := 0;
      g_FunctionNPC.m_wAppr := 0;
      g_FunctionNPC.m_sFilePath := sMarket_Def;
      g_FunctionNPC.m_sScript := 'QFunction';
      g_FunctionNPC.m_boIsHide := True;
      g_FunctionNPC.m_boIsQuest := False;
      g_FunctionNPC.m_UnAllowLableList.Add('@StdModeFunc');
      g_FunctionNPC.m_UnAllowLableList.Add('@TakeOnEx');
      g_FunctionNPC.m_UnAllowLableList.Add('@Defeat');
      g_FunctionNPC.m_UnAllowLableList.Add('@Victory');
      g_FunctionNPC.m_UnAllowLableList.Add('@PlayOffLine');
      g_FunctionNPC.m_UnAllowLableList.Add('@PlayReconnection');
      g_FunctionNPC.m_UnAllowLableList.Add('@SayMsgFilter');
      g_FunctionNPC.m_UnAllowLableList.Add('@Member');
      g_FunctionNPC.m_UnAllowLableList.Add('@TakeOff');
      g_FunctionNPC.m_UnAllowLableList.Add('@TakeOn');
      g_FunctionNPC.m_UnAllowLableList.Add('@PlayDie');
      g_FunctionNPC.m_UnAllowLableList.Add('@PlayLevelUp');
      g_FunctionNPC.m_UnAllowLableList.Add('@KillPlay');
      g_FunctionNPC.m_UnAllowLableList.Add('@PlayLevelUp');
      g_FunctionNPC.m_UnAllowLableList.Add('@KillMon');
      g_FunctionNPC.m_UnAllowLableList.Add('@MasterOK');
      g_FunctionNPC.m_UnAllowLableList.Add('@Magic');
      g_FunctionNPC.m_UnAllowLableList.Add('@GotoDuelMap');
      g_FunctionNPC.m_UnAllowLableList.Add('@ButchItem');
      g_FunctionNPC.m_UnAllowLableList.Add('@OnHorse');
      UserEngine.AddMerchant(g_FunctionNPC);
    end else begin
      //g_FunctionNPC.Free;
      g_FunctionNPC := nil;
    end;
  except
    //g_FunctionNPC.Free;
    g_FunctionNPC := nil;
  end;
end;

procedure TFrmDB.MissionNPC;
var
  sScriptFile: string;
  sScritpDir: string;
  SaveList: TStringList;
  sShowFile: string;
begin
  {try
    sScriptFile := g_Config.sEnvirDir + sMarket_Def + 'Mission-0.txt';
    sShowFile := ReplaceChar(sScriptFile, '\', '/');
    sScritpDir := g_Config.sEnvirDir + sMarket_Def;
    if not DirectoryExists(sScritpDir) then
      MkDir(PChar(sScritpDir));

    if not FileExists(sScriptFile) then begin
      SaveList := TStringList.Create;
      SaveList.Add(';此脚为任务脚本，用于实现各种与任务有关的功能');
      SaveList.SaveToFile(sScriptFile);
      SaveList.Free;
    end;
    if FileExists(sScriptFile) then begin
      g_MissionNPC := TMerchant.Create;
      g_MissionNPC.m_sMapName := '0';
      g_MissionNPC.m_nCurrX := 0;
      g_MissionNPC.m_nCurrY := 0;
      g_MissionNPC.m_sCharName := 'Mission';
      g_MissionNPC.m_nFlag := 0;
      g_MissionNPC.m_wAppr := 0;
      g_MissionNPC.m_sFilePath := sMarket_Def;
      g_MissionNPC.m_sScript := 'Mission';
      g_MissionNPC.m_boIsHide := True;
      g_MissionNPC.m_boIsQuest := False;
      UserEngine.AddMerchant(g_MissionNPC);
    end else begin
      g_MissionNPC := nil;
    end;
  except
    g_MissionNPC := nil;
  end; }
end;

procedure TFrmDB.QMangeNPC();
var
  sScriptFile: string;
  sScritpDir: string;
  SaveList: TStringList;
  sShowFile: string;
  Map: TEnvirnoment;
begin
  try
    sScriptFile := g_Config.sEnvirDir + 'MapQuest_def\' + 'QManage.txt';
    sShowFile := ReplaceChar(sScriptFile, '\', '/');
    sScritpDir := g_Config.sEnvirDir + 'MapQuest_def\';
    if not DirectoryExists(sScritpDir) then
      MkDir(PChar(sScritpDir));

    if not FileExists(sScriptFile) then begin
      SaveList := TStringList.Create;
      SaveList.Add(';此脚为登录脚本，人物每次登录时都会执行此脚本，所有人物初始设置都可以放在此脚本中。');
      SaveList.Add(';修改脚本内容，可用@ReloadManage命令重新加载该脚本，不须重启程序。');
      SaveList.Add('[@Login]');
      SaveList.Add('#if');
      SaveList.Add('#act');
      //    tSaveList.Add(';设置10倍杀怪经验');
      //    tSaveList.Add(';CANGETEXP 1 10');
      SaveList.Add('#say');
      SaveList.Add('MakeGM登录脚本运行成功，欢迎进入本游戏！！！\ \');
      SaveList.Add('<关闭/@exit> \ \');
      SaveList.Add('登录脚本文件位于: \');
      SaveList.Add(sShowFile + '\');
      SaveList.Add('脚本内容请自行按自己的要求修改。');
      SaveList.SaveToFile(sScriptFile);
      SaveList.Free;
    end;
    Map := g_MapManager.FindMap('0');
    if FileExists(sScriptFile) and (Map <> nil) then begin
      g_ManageNPC := TMerchant.Create;
      g_ManageNPC.m_NpcType := n_Norm;
      g_ManageNPC.m_PEnvir := Map;
      g_ManageNPC.m_sMapName := '0';
      g_ManageNPC.m_nCurrX := 0;
      g_ManageNPC.m_nCurrY := 0;
      g_ManageNPC.m_sCharName := 'QManage';
      g_ManageNPC.m_nFlag := 0;
      g_ManageNPC.m_wAppr := 0;
      g_ManageNPC.m_sFilePath := 'MapQuest_def\';
      g_ManageNPC.m_boIsHide := True;
      g_ManageNPC.m_boIsQuest := False;
      g_ManageNPC.m_UnAllowLableList.Add('@Login');
      g_ManageNPC.m_UnAllowLableList.Add('@OnTimer');

      UserEngine.QuestNPCList.Add(g_ManageNPC);
    end else begin
      //g_ManageNPC.Free;
      g_ManageNPC := nil;
    end;
  except
    //g_ManageNPC.Free;
    g_ManageNPC := nil;
  end;
end;

procedure TFrmDB.RobotNPC();
var
  sScriptFile: string;
  sScritpDir: string;

  tSaveList: TStringList;
  Map: TEnvirnoment;
begin
  try
    sScriptFile := g_Config.sEnvirDir + 'Robot_def\' + 'RobotManage.txt';
    sScritpDir := g_Config.sEnvirDir + 'Robot_def\';
    if not DirectoryExists(sScritpDir) then
      MkDir(PChar(sScritpDir));

    if not FileExists(sScriptFile) then begin
      tSaveList := TStringList.Create;
      tSaveList.Add(';此脚为机器人专用脚本，用于机器人处理功能用的脚本。');
      tSaveList.SaveToFile(sScriptFile);
      tSaveList.Free;
    end;
    Map := g_MapManager.FindMap('0');
    if FileExists(sScriptFile) and (Map <> nil) then begin
      g_RobotNPC := TMerchant.Create;
      g_RobotNPC.m_NpcType := n_Norm;
      g_RobotNPC.m_PEnvir := Map;
      g_RobotNPC.m_sMapName := '0';
      g_RobotNPC.m_nCurrX := 0;
      g_RobotNPC.m_nCurrY := 0;
      g_RobotNPC.m_sCharName := 'RobotManage';
      g_RobotNPC.m_nFlag := 0;
      g_RobotNPC.m_wAppr := 0;
      g_RobotNPC.m_sFilePath := 'Robot_def\';
      g_RobotNPC.m_boIsHide := True;
      g_RobotNPC.m_boIsQuest := False;
      UserEngine.QuestNPCList.Add(g_RobotNPC);
      if g_PlayRobotNPC = nil then
        g_PlayRobotNPC := TPlayRobotManage.Create
      else
        g_PlayRobotNPC.RELOADROBOT;
    end else begin
      g_RobotNPC := nil;
    end;
  except
    g_RobotNPC := nil;
  end;
end;

function TFrmDB.LoadMapEvent(): Integer;
var
  sFileName, tStr: string;
  tMapEventList: TStringList;
  I: Integer;
  s18, s1C, s20, s24, s28, s2C, s30, s34, s36, s38, s40, s42, s44, s46, sRange: string;
  MapEvent: pTMapEvent;
  Map: TEnvirnoment;
begin
  Result := 1;
  sFileName := g_Config.sEnvirDir + 'MapEvent.txt';
  if FileExists(sFileName) then begin
    tMapEventList := TStringList.Create;
    tMapEventList.LoadFromFile(sFileName);
    for I := 0 to tMapEventList.Count - 1 do begin
      tStr := tMapEventList.Strings[I];
      if (tStr <> '') and (tStr[1] <> ';') then begin
        tStr := GetValidStr3(tStr, s18, [' ', #9]);
        tStr := GetValidStr3(tStr, s1C, [' ', #9]);
        tStr := GetValidStr3(tStr, s20, [' ', #9]);
        tStr := GetValidStr3(tStr, sRange, [' ', #9]);
        tStr := GetValidStr3(tStr, s24, [' ', #9]);
        tStr := GetValidStr3(tStr, s28, [' ', #9]);
        tStr := GetValidStr3(tStr, s2C, [' ', #9]);
        tStr := GetValidStr3(tStr, s30, [' ', #9]);
        if (s18 <> '') and (s1C <> '') and (s20 <> '') and (s30 <> '') then begin
          Map := g_MapManager.FindMap(s18);
          if Map <> nil then begin
            New(MapEvent);
            FillChar(MapEvent.m_MapFlag, SizeOf(TQuestUnitStatus), 0);
            FillChar(MapEvent.m_Condition, SizeOf(TMapCondition), #0);
            FillChar(MapEvent.m_StartScript, SizeOf(TStartScript), #0);
            MapEvent.m_sMapName := Trim(s18);
            MapEvent.m_nCurrX := Str_ToInt(s1C, 0);
            MapEvent.m_nCurrY := Str_ToInt(s20, 0);
            MapEvent.m_nRange := Str_ToInt(sRange, 0);
            s24 := GetValidStr3(s24, s34, [':', #9]);
            s24 := GetValidStr3(s24, s36, [':', #9]);
            MapEvent.m_MapFlag.nQuestUnit := Str_ToInt(s34, 0);
            if Str_ToInt(s36, 0) <> 0 then MapEvent.m_MapFlag.boOpen := True
            else MapEvent.m_MapFlag.boOpen := False;
            s28 := GetValidStr3(s28, s38, [':', #9]);
            s28 := GetValidStr3(s28, s40, [':', #9]);
            s28 := GetValidStr3(s28, s42, [':', #9]);
            MapEvent.m_Condition.nHumStatus := Str_ToInt(s38, 0);
            MapEvent.m_Condition.sItemName := Trim(s40);
            if Str_ToInt(s42, 0) <> 0 then MapEvent.m_Condition.boNeedGroup := True
            else MapEvent.m_Condition.boNeedGroup := False;
            MapEvent.m_nRandomCount := Str_ToInt(s2C, 999999);
            s30 := GetValidStr3(s30, s44, [':', #9]);
            s30 := GetValidStr3(s30, s46, [':', #9]);
            MapEvent.m_StartScript.nLable := Str_ToInt(s44, 0);
            MapEvent.m_StartScript.sLable := Trim(s46);
            case MapEvent.m_Condition.nHumStatus of
              1: g_MapEventListOfDropItem.Add(MapEvent);
              2: g_MapEventListOfPickUpItem.Add(MapEvent);
              3: g_MapEventListOfMine.Add(MapEvent);
              4: g_MapEventListOfWalk.Add(MapEvent);
              5: g_MapEventListOfRun.Add(MapEvent);
            else begin
                Dispose(MapEvent);
              end;
            end;
          end else Result := -I;
        end;
      end;
    end;
    tMapEventList.Free;
  end;
end;

function TFrmDB.LoadMapMagicEvent(): Integer;
var
  sFileName, tStr: string;
  tMapEventList: TStringList;
  I: Integer;
  nX, nY, nRange, nPower, nType: Integer;
  s18, s1C, s20, s24, s28, s30: string;
  Event: TMapMagicEvent;
  Map: TEnvirnoment;
begin
  Result := 1;
  sFileName := g_Config.sEnvirDir + 'MapMagicEvent.txt';
  if FileExists(sFileName) then begin
    tMapEventList := TStringList.Create;
    tMapEventList.LoadFromFile(sFileName);
    for I := 0 to tMapEventList.Count - 1 do begin
      tStr := tMapEventList.Strings[I];
      if (tStr <> '') and (tStr[1] <> ';') then begin
        tStr := GetValidStr3(tStr, s18, [' ', #9]);
        tStr := GetValidStr3(tStr, s1C, [' ', #9]);
        tStr := GetValidStr3(tStr, s20, [' ', #9]);
        tStr := GetValidStr3(tStr, s24, [' ', #9]);
        tStr := GetValidStr3(tStr, s28, [' ', #9]);
        tStr := GetValidStr3(tStr, s30, [' ', #9]);
        nX := Str_ToInt(s1C, -1);
        nY := Str_ToInt(s20, -1);
        nRange := Str_ToInt(s24, -1);
        nType := Str_ToInt(s28, -1);
        nPower := Str_ToInt(s30, -1);

        if (s18 <> '') and (nX >= 0) and (nY >= 0) and (nRange >= 0) and (nType >= 0) then begin
          Map := g_MapManager.FindMap(s18);
          if Map <> nil then begin
            Event := TMapMagicEvent.Create(Map, nX, nY, nType + 100);
            Event.m_nDamage := nPower;
            Event.m_nRange := nRange;
            g_EventManager.AddEvent(Event);
          end else Result := -I;
        end;
      end;
    end;
    tMapEventList.Free;
  end;
end;

function TFrmDB.LoadMapQuest(): Integer;
var
  sFileName, tStr: string;
  tMapQuestList: TStringList;
  I: Integer;
  s18, s1C, s20, s24, s28, s2C, s30, s34: string;
  n38, n3C: Integer;
  boGrouped: Boolean;
  Map: TEnvirnoment;
begin
  Result := 1;
  sFileName := g_Config.sEnvirDir + 'MapQuest.txt';
  if FileExists(sFileName) then begin
    tMapQuestList := TStringList.Create;
    tMapQuestList.LoadFromFile(sFileName);
    DeCodeStringList(tMapQuestList);
    for I := 0 to tMapQuestList.Count - 1 do begin
      tStr := tMapQuestList.Strings[I];
      if (tStr <> '') and (tStr[1] <> ';') then begin
        tStr := GetValidStr3(tStr, s18, [' ', #9]);
        tStr := GetValidStr3(tStr, s1C, [' ', #9]);
        tStr := GetValidStr3(tStr, s20, [' ', #9]);
        tStr := GetValidStr3(tStr, s24, [' ', #9]);
        if (s24 <> '') and (s24[1] = '"') then
          ArrestStringEx(s24, '"', '"', s24);
        tStr := GetValidStr3(tStr, s28, [' ', #9]);
        if (s28 <> '') and (s28[1] = '"') then
          ArrestStringEx(s28, '"', '"', s28);
        tStr := GetValidStr3(tStr, s2C, [' ', #9]);
        tStr := GetValidStr3(tStr, s30, [' ', #9]);
        if (s18 <> '') and (s24 <> '') and (s2C <> '') then begin
          Map := g_MapManager.FindMap(s18);
          if Map <> nil then begin
            ArrestStringEx(s1C, '[', ']', s34);
            n38 := Str_ToInt(s34, 0);
            n3C := Str_ToInt(s20, 0);
            if CompareLStr(s30, 'GROUP', Length('GROUP')) then boGrouped := True
            else boGrouped := False;
            if not Map.CreateQuest(n38, n3C, s24, s28, s2C, boGrouped) then Result := -I;
            //nFlag,boFlag,Monster,Item,Quest,boGrouped
          end else Result := -I;
        end else Result := -I;
      end;
    end;
    tMapQuestList.Free;
  end;
  QMangeNPC();
  QFunctionNPC();
  MissionNPC;
  RobotNPC();
end;

function TFrmDB.LoadMerchant(): Integer;
var
  sFileName, sLineText, sScript, sMapName, sX, sY, sName, sFlag, sAppr, sIsCalste, sCanMove, sMoveTime, sAutoChangeColor,
    sAutoChangeColorTime, sNpcMagic: string;
  tMerchantList: TStringList;
  tMerchantNPC: TMerchant;
  I, n100: Integer;
begin
  sFileName := g_Config.sEnvirDir + 'Merchant.txt';
  if FileExists(sFileName) then begin
    tMerchantList := TStringList.Create;
    tMerchantList.LoadFromFile(sFileName);
    for I := 0 to tMerchantList.Count - 1 do begin
      sLineText := Trim(tMerchantList.Strings[I]);
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        sLineText := GetValidStr3(sLineText, sScript, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sMapName, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sX, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sY, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sName, [' ', #9]);
        if (sName <> '') and (sName[1] = '"') then
          ArrestStringEx(sName, '"', '"', sName);
        sLineText := GetValidStr3(sLineText, sFlag, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sAppr, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sIsCalste, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sCanMove, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sMoveTime, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sAutoChangeColor, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sAutoChangeColorTime, [' ', #9]); //NPC变色
        sLineText := GetValidStr3(sLineText, sNpcMagic, [' ', #9]); //NPC魔法效果

        if (sScript <> '') and (sMapName <> '') and (sAppr <> '') then begin
          tMerchantNPC := TMerchant.Create;
          tMerchantNPC.m_sScript := sScript;
          tMerchantNPC.m_sMapName := sMapName;
          tMerchantNPC.m_nCurrX := Str_ToInt(sX, 0);
          tMerchantNPC.m_nCurrY := Str_ToInt(sY, 0);
          tMerchantNPC.m_sCharName := sName;
          tMerchantNPC.m_nFlag := Str_ToInt(sFlag, 0);
          tMerchantNPC.m_wAppr := Str_ToInt(sAppr, 0);
          tMerchantNPC.m_dwMoveTime := Str_ToInt(sMoveTime, 0);
          tMerchantNPC.m_dwNpcAutoChangeColorTime := Str_ToInt(sAutoChangeColorTime, 0) * 1000;

          n100 := GetValNameNo(sName);
          case n100 of
            0..499: begin
                tMerchantNPC.m_nVarIdx := n100 - 1000;
                tMerchantNPC.m_sCharName := g_Config.GlobalAVal[tMerchantNPC.m_nVarIdx];
              end;
          end;

          if tMerchantNPC.m_wAppr in [53..61] then tMerchantNPC.m_btDirection := Random(4) + 3;
          if tMerchantNPC.m_wAppr in [62..70] then tMerchantNPC.m_btDirection := 0;
          if Str_ToInt(sIsCalste, 0) <> 0 then
            tMerchantNPC.m_boCastle := True;
          if (Str_ToInt(sCanMove, 0) <> 0) and (tMerchantNPC.m_dwMoveTime > 0) then
            tMerchantNPC.m_boCanMove := True;
          if Str_ToInt(sAutoChangeColor, 0) <> 0 then //NPC变色
            tMerchantNPC.m_boNpcAutoChangeColor := True;
          tMerchantNPC.m_nNpcMagicIdx := Str_ToInt(sNpcMagic, 0); //NPC魔法效果

          UserEngine.AddMerchant(tMerchantNPC);
        end;
      end;
    end;
    tMerchantList.Free;
  end;
  Result := 1;
end;

function TFrmDB.LoadMinMap: Integer;
var
  sFileName, tStr, sMapNO, sMapIdx: string;
  tMapList: TStringList;
  I, nIdx: Integer;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + 'MiniMap.txt';
  if FileExists(sFileName) then begin
    MiniMapList.Clear;
    tMapList := TStringList.Create;
    DeCodeStringList(tMapList);
    tMapList.LoadFromFile(sFileName);
    for I := 0 to tMapList.Count - 1 do begin
      tStr := tMapList.Strings[I];
      if (tStr <> '') and (tStr[1] <> ';') then begin
        tStr := GetValidStr3(tStr, sMapNO, [' ', #9]);
        tStr := GetValidStr3(tStr, sMapIdx, [' ', #9]);
        nIdx := Str_ToInt(sMapIdx, 0);
        if nIdx > 0 then
          MiniMapList.AddObject(sMapNO, TObject(nIdx));
      end;
    end;
    tMapList.Free;
  end;
end;

function TFrmDB.LoadMonGen(): Integer;
  procedure LoadMapGen(MonGenList: TStringList; sFileName: string);
  var
    I: Integer;
    sFilePatchName: string;
    sFileDir: string;
    LoadList: TStringList;
  begin
    sFileDir := g_Config.sEnvirDir + 'MonGen\';
    if not DirectoryExists(sFileDir) then begin
      CreateDir(sFileDir);
    end;

    sFilePatchName := sFileDir + sFileName;
    if FileExists(sFilePatchName) then begin
      LoadList := TStringList.Create;
      LoadList.LoadFromFile(sFilePatchName);
      DeCodeStringList(LoadList);
      for I := 0 to LoadList.Count - 1 do begin
        MonGenList.Add(LoadList.Strings[I]);
      end;
      LoadList.Free;
    end;
  end;
var
  sFileName, sLineText, sData: string;
  MonGenInfo: pTMonGenInfo;
  LoadList: TStringList;
  sMapGenFile: string;
  I: Integer;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + 'MonGen.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    I := 0;
    DeCodeStringList(LoadList);
    while (True) do begin
      if I >= LoadList.Count then Break;
      if CompareLStr('loadgen', LoadList.Strings[I], Length('loadgen')) then begin
        sMapGenFile := GetValidStr3(LoadList.Strings[I], sLineText, [' ', #9]);
        LoadList.Delete(I);
        if sMapGenFile <> '' then begin
          LoadMapGen(LoadList, sMapGenFile);
        end;
      end;
      Inc(I);
    end;
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[I];
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        New(MonGenInfo);
        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.sMapName := sData;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nX := Str_ToInt(sData, 0);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nY := Str_ToInt(sData, 0);

        sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
        if (sData <> '') and (sData[1] = '"') then
          ArrestStringEx(sData, '"', '"', sData);

        MonGenInfo.sMonName := sData;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nRange := Str_ToInt(sData, 0);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nCount := Str_ToInt(sData, 0);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.dwZenTime := Str_ToInt(sData, -1) * 60 * 1000;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nMissionGenRate := Str_ToInt(sData, 0); //集中座标刷新机率 1 -100

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nChangeColorType := Str_ToInt(sData, -1); //变色2007-02-01增加

        if (MonGenInfo.sMapName <> '') and
          (MonGenInfo.sMonName <> '') and
          (MonGenInfo.dwZenTime <> 0) and
          (g_MapManager.GetMapInfo(nServerIndex, MonGenInfo.sMapName) <> nil) then begin

          MonGenInfo.CertList := TList.Create;
          MonGenInfo.Envir := g_MapManager.FindMap(MonGenInfo.sMapName);
          if MonGenInfo.Envir <> nil then begin
            UserEngine.m_MonGenList.Add(MonGenInfo);
          end else begin
            MonGenInfo.CertList.Free;
            Dispose(MonGenInfo);
          end;

        end else Dispose(MonGenInfo);
        //tMonGenInfo.nRace:=UserEngine.GetMonRace(tMonGenInfo.sMonName);
      end;
    end;

    New(MonGenInfo);
    MonGenInfo.sMapName := '';
    MonGenInfo.sMonName := '';
    MonGenInfo.CertList := TList.Create;
    MonGenInfo.Envir := nil;
    UserEngine.m_MonGenList.Add(MonGenInfo);

    LoadList.Free;
    Result := 1;
  end;
end;

function TFrmDB.LoadMonsterDB(): Integer;
var
  I: Integer;
  Monster: pTMonInfo;
resourcestring
  sSQLString = 'select * from Monster';
begin
  Result := 0;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    for I := 0 to UserEngine.MonsterList.Count - 1 do begin
      Dispose(pTMonInfo(UserEngine.MonsterList.Items[I]));
    end;
    UserEngine.MonsterList.Clear;

    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    finally
      Result := -1;
    end;
    for I := 0 to Query.RecordCount - 1 do begin
      New(Monster);
      Monster.ItemList := TList.Create;
      Monster.sName := Trim(Query.FieldByName('NAME').AsString);
      Monster.btRace := Query.FieldByName('Race').AsInteger;
      Monster.btRaceImg := Query.FieldByName('RaceImg').AsInteger;
      Monster.wAppr := Query.FieldByName('Appr').AsInteger;
      Monster.wLevel := Query.FieldByName('Lvl').AsInteger;
      Monster.btLifeAttrib := Query.FieldByName('Undead').AsInteger;
      Monster.wCoolEye := Query.FieldByName('CoolEye').AsInteger;
      Monster.dwExp := Query.FieldByName('Exp').AsInteger;

      //城门或城墙的状态跟HP值有关，如果HP异常，将导致城墙显示不了
      if Monster.btRace in [110, 111] then begin //如果为城墙或城门由HP不加倍
        Monster.wHP := Query.FieldByName('HP').AsInteger;
      end else begin
        Monster.wHP := Round(Query.FieldByName('HP').AsInteger * (g_Config.nMonsterPowerRate / 10));
      end;

      Monster.wMP := Round(Query.FieldByName('MP').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wAC := Round(Query.FieldByName('AC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wMAC := Round(Query.FieldByName('MAC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wDC := Round(Query.FieldByName('DC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wMaxDC := Round(Query.FieldByName('DCMAX').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wMC := Round(Query.FieldByName('MC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wSC := Round(Query.FieldByName('SC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wSpeed := Query.FieldByName('SPEED').AsInteger;
      Monster.wHitPoint := Query.FieldByName('HIT').AsInteger;
      Monster.wWalkSpeed := _MAX(200, Query.FieldByName('WALK_SPD').AsInteger);
      Monster.wWalkStep := _MAX(1, Query.FieldByName('WalkStep').AsInteger);
      Monster.wWalkWait := Query.FieldByName('WalkWait').AsInteger;
      Monster.wAttackSpeed := Query.FieldByName('ATTACK_SPD').AsInteger;

      if Monster.wWalkSpeed < 200 then Monster.wWalkSpeed := 200;
      if Monster.wAttackSpeed < 200 then Monster.wAttackSpeed := 200;
      Monster.ItemList := nil;
      LoadMonitems(Monster.sName, Monster.ItemList);
      UserEngine.MonsterList.Add(Monster);
      Result := 1;
      Query.Next;
    end;
    Query.Close;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TFrmDB.LoadMonitems(MonName: string; var ItemList: TList): Integer;
var
  I: Integer;
  s24: string;
  LoadList: TStringList;
  MonItem: pTMonItem;
  s28, s2C, s30: string;
  n18, n1C, n20: Integer;
begin
  Result := 0;
  s24 := g_Config.sEnvirDir + 'MonItems\' + MonName + '.txt';
  if FileExists(s24) then begin
    if ItemList <> nil then begin
      for I := 0 to ItemList.Count - 1 do begin
        Dispose(pTMonItem(ItemList.Items[I]));
      end;
      ItemList.Clear;
    end;
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(s24);
    DeCodeStringList(LoadList);
    for I := 0 to LoadList.Count - 1 do begin
      s28 := LoadList.Strings[I];
      if (s28 <> '') and (s28[1] <> ';') then begin
        s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
        n18 := Str_ToInt(s30, -1);
        s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
        n1C := Str_ToInt(s30, -1);
        s28 := GetValidStr3(s28, s30, [' ', #9]);
        if s30 <> '' then begin
          if s30[1] = '"' then
            ArrestStringEx(s30, '"', '"', s30);
        end;
        s2C := s30;
        s28 := GetValidStr3(s28, s30, [' ', #9]);
        n20 := Str_ToInt(s30, 1);
        if (n18 > 0) and (n1C > 0) and (s2C <> '') then begin
          if ItemList = nil then ItemList := TList.Create;
          New(MonItem);
          MonItem.n00 := n18 - 1;
          MonItem.n04 := n1C;
          MonItem.sMonName := s2C;
          MonItem.n18 := n20;
          ItemList.Add(MonItem);
          Inc(Result);
        end;
      end;
    end;
    LoadList.Free;
  end;
end;

function TFrmDB.LoadNpcs(): Integer;
var
  sFileName, s10, s18, s1C, s20, s24, s28, s2C, s30, s34, s38, s40, s42: string;
  LoadList: TStringList;
  NPC: TNormNpc;
  I: Integer;
begin
  sFileName := g_Config.sEnvirDir + 'Npcs.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      s18 := Trim(LoadList.Strings[I]);
      if (s18 <> '') and (s18[1] <> ';') then begin
        s18 := GetValidStrCap(s18, s20, [' ', #9]);
        if (s20 <> '') and (s20[1] = '"') then
          ArrestStringEx(s20, '"', '"', s20);
        s18 := GetValidStr3(s18, s24, [' ', #9]);
        s18 := GetValidStr3(s18, s28, [' ', #9]);
        s18 := GetValidStr3(s18, s2C, [' ', #9]);
        s18 := GetValidStr3(s18, s30, [' ', #9]);
        s18 := GetValidStr3(s18, s34, [' ', #9]);
        s18 := GetValidStr3(s18, s38, [' ', #9]);
        s18 := GetValidStr3(s18, s40, [' ', #9]);
        s18 := GetValidStr3(s18, s42, [' ', #9]);
        if (s20 <> '') and (s28 <> '') and (s38 <> '') then begin
          NPC := nil;
          case Str_ToInt(s24, 0) of
            0: NPC := TMerchant.Create;
            1: NPC := TGuildOfficial.Create;
            2: NPC := TCastleOfficial.Create;
          end;
          if NPC <> nil then begin
            NPC.m_sMapName := s28;
            NPC.m_nCurrX := Str_ToInt(s2C, 0);
            NPC.m_nCurrY := Str_ToInt(s30, 0);
            NPC.m_sCharName := s20;
            NPC.m_nFlag := Str_ToInt(s34, 0);
            NPC.m_wAppr := Str_ToInt(s38, 0);
            if Str_ToInt(s40, 0) <> 0 then
              NPC.m_boNpcAutoChangeColor := True;
            NPC.m_dwNpcAutoChangeColorTime := Str_ToInt(s42, 0) * 1000;
            NPC.m_NpcType := n_Norm;
            UserEngine.QuestNPCList.Add(NPC);
          end;
        end;
      end;
    end;
    LoadList.Free;
  end;
  Result := 1;
end;

function TFrmDB.LoadQuestDiary(): Integer;
  function sub_48978C(nIndex: Integer): string;
  begin
    if nIndex >= 1000 then begin
      Result := IntToStr(nIndex);
      Exit;
    end;
    if nIndex >= 100 then begin
      Result := IntToStr(nIndex) + '0';
      Exit;
    end;
    Result := IntToStr(nIndex) + '00';
  end;
var
  I, II: Integer;
  QDDinfoList: TList;
  QDDinfo: pTQDDinfo;
  s14, s18, s1C, s20: string;
  bo2D: Boolean;
  nC: Integer;
  LoadList: TStringList;
begin
  Result := 1;
  for I := 0 to QuestDiaryList.Count - 1 do begin
    QDDinfoList := QuestDiaryList.Items[I];
    for II := 0 to QDDinfoList.Count - 1 do begin
      QDDinfo := QDDinfoList.Items[II];
      QDDinfo.sList.Free;
      Dispose(QDDinfo);
    end;
    QDDinfoList.Free;
  end;
  QuestDiaryList.Clear;
  bo2D := False;
  nC := 1;
  while (True) do begin
    QDDinfoList := nil;
    s14 := 'QuestDiary\' + sub_48978C(nC) + '.txt';
    if FileExists(s14) then begin
      s18 := '';
      QDDinfo := nil;
      LoadList := TStringList.Create;
      LoadList.LoadFromFile(s14);
      for I := 0 to LoadList.Count - 1 do begin
        s1C := LoadList.Strings[I];
        if (s1C <> '') and (s1C[1] <> ';') then begin
          if (s1C[1] = '[') and (Length(s1C) > 2) then begin
            if s18 = '' then begin
              ArrestStringEx(s1C, '[', ']', s18);
              QDDinfoList := TList.Create;
              New(QDDinfo);
              QDDinfo.n00 := nC;
              QDDinfo.s04 := s18;
              QDDinfo.sList := TStringList.Create;
              QDDinfoList.Add(QDDinfo);
              bo2D := True;
            end else begin
              if s1C[1] <> '@' then begin
                s1C := GetValidStr3(s1C, s20, [' ', #9]);
                ArrestStringEx(s20, '[', ']', s20);
                New(QDDinfo);
                QDDinfo.n00 := Str_ToInt(s20, 0);
                QDDinfo.s04 := s1C;
                QDDinfo.sList := TStringList.Create;
                QDDinfoList.Add(QDDinfo);
                bo2D := True;
              end else bo2D := False;
            end;
          end else begin
            if bo2D then QDDinfo.sList.Add(s1C);
          end;
        end;
      end;
      LoadList.Free;
    end;
    if QDDinfoList <> nil then QuestDiaryList.Add(QDDinfoList)
    else QuestDiaryList.Add(nil);
    Inc(nC);
    if nC >= 105 then Break;
  end;
end;

function TFrmDB.LoadStartPoint(): Integer;
var
  sFileName, tStr, s18, s1C, s20, s22, s24, s26, s28, s30: string;
  LoadList: TStringList;
  I: Integer;
  StartPoint: pTStartPoint;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + 'StartPoint.txt';
  if FileExists(sFileName) then begin
    for I := 0 to g_StartPointList.Count - 1 do begin
      Dispose(pTStartPoint(g_StartPointList.Objects[I]));
    end;
    g_StartPointList.Clear;

    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      tStr := Trim(LoadList.Strings[I]);
      if (tStr <> '') and (tStr[1] <> ';') then begin
        tStr := GetValidStr3(tStr, s18, [' ', #9]);
        tStr := GetValidStr3(tStr, s1C, [' ', #9]);
        tStr := GetValidStr3(tStr, s20, [' ', #9]);
        tStr := GetValidStr3(tStr, s22, [' ', #9]);
        tStr := GetValidStr3(tStr, s24, [' ', #9]);
        tStr := GetValidStr3(tStr, s26, [' ', #9]);
        tStr := GetValidStr3(tStr, s28, [' ', #9]);
        tStr := GetValidStr3(tStr, s30, [' ', #9]);
        if (s18 <> '') and (s1C <> '') and (s20 <> '') then begin
          New(StartPoint);
          StartPoint.sMapName := s18;
          StartPoint.nCurrX := Str_ToInt(s1C, 0);
          StartPoint.nCurrY := Str_ToInt(s20, 0);
          StartPoint.boNotAllowSay := Boolean(Str_ToInt(s22, 0));
          StartPoint.nRange := Str_ToInt(s24, 0);
          StartPoint.nType := Str_ToInt(s26, 0);
          StartPoint.nPkZone := Str_ToInt(s28, 0);
          StartPoint.nPkFire := Str_ToInt(s30, 0);
          g_StartPointList.AddObject(s18, TObject(StartPoint));
          Result := 1;
        end;
      end;
    end;
    LoadList.Free;
  end;
end;

function TFrmDB.LoadUnbindList(): Integer;
var
  sFileName, tStr, sData, s20: string;
  tUnbind: pTUnbindInfo;
  LoadList: TStringList;
  I: Integer;
  n10: Integer;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + 'UnbindList.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      tStr := LoadList.Strings[I];
      if (tStr <> '') and (tStr[1] <> ';') then begin
        //New(tUnbind);
        tStr := GetValidStr3(tStr, sData, [' ', #9]);
        tStr := GetValidStrCap(tStr, s20, [' ', #9]);
        if (s20 <> '') and (s20[1] = '"') then
          ArrestStringEx(s20, '"', '"', s20);

        n10 := Str_ToInt(sData, 0);
        if n10 > 0 then g_UnbindList.AddObject(s20, TObject(n10))
        else begin
          Result := -I; //需要取负数
          Break;
        end;
      end;
    end;
    LoadList.Free;
  end;
end;

function TFrmDB.LoadNpcScript(NPC: TNormNpc; sPatch,
  sScritpName: string): Integer;
begin
  if sPatch = '' then sPatch := sNpc_def;
  Result := LoadScriptFile(NPC, sPatch, sScritpName, False);
end;

function TFrmDB.LoadScriptFile(NPC: TNormNpc; sPatch, sScritpName: string;
  boFlag: Boolean): Integer;
var
  nQuestIdx, I, n1C, n20, n24, nItemType, nPriceRate: Integer;
  n6C, n70: Integer;
  sScritpFileName, s30, s34, s38, s3C, s40, s44, s48, s4C, s50: string;
  LoadList: TStringList;
  DefineList: TList;
  s54, s58, s5C, s74: string;
  DefineInfo: pTDefineInfo;
  bo8D: Boolean;
  Script: pTScript;
  SayingRecord: pTSayingRecord;
  SayingProcedure: pTSayingProcedure;
  QuestConditionInfo: pTQuestConditionInfo;
  QuestActionInfo: pTQuestActionInfo;
  Goods: pTGoods;
  function LoadCallScript(sFileName, sLabel: string; var List: TStringList): Boolean;
  var
    I: Integer;
    LoadStrList: TStringList;
    bo1D: Boolean;
    s18: string;
  begin
    Result := False;
    if FileExists(sFileName) then begin
      LoadStrList := TStringList.Create;
      LoadStrList.LoadFromFile(sFileName);
      DeCodeStringList(LoadStrList);
      sLabel := '[' + sLabel + ']';
      bo1D := False;
      for I := 0 to LoadStrList.Count - 1 do begin
        s18 := Trim(LoadStrList.Strings[I]);
        if s18 <> '' then begin
          if not bo1D then begin
            if (s18[1] = '[') and (CompareText(s18, sLabel) = 0) then begin
              bo1D := True;
              List.Add(s18);
            end;
          end else begin
            if s18[1] <> '{' then begin
              if s18[1] = '}' then begin
                bo1D := False;
                Result := True;
                Break;
              end else begin
                List.Add(s18);
              end;
            end;
          end;
        end; //00489CE4 if s18 <> '' then begin
      end; // for I := 0 to LoadStrList.Count - 1 do begin
      LoadStrList.Free;
    end;
  end;

  procedure LoadScriptcall(var LoadList: TStringList);
  var
    I: Integer;
    s14, s18, s1C, s20, s34: string;
  begin
    for I := 0 to LoadList.Count - 1 do begin
      s14 := Trim(LoadList.Strings[I]);
      if (s14 <> '') and (s14[1] = '#') and (CompareLStr(s14, '#CALL', Length('#CALL'))) then begin
        s14 := ArrestStringEx(s14, '[', ']', s1C);
        s20 := Trim(s1C);
        s18 := Trim(s14);
        if s20[1] = '\' then s20 := Copy(s20, 2, Length(s20) - 1);
        if s20[2] = '\' then s20 := Copy(s20, 3, Length(s20) - 2);
        s34 := g_Config.sEnvirDir + 'QuestDiary\' + s20;
        if LoadCallScript(s34, s18, LoadList) then begin
          LoadList.Strings[I] := '#ACT';
          LoadList.Insert(I + 1, 'goto ' + s18);
        end else begin
          MainOutMessage('script error, load fail: ' + s20 + s18);
        end;
      end;
    end;
  end;

  function LoadDefineInfo(var LoadList: TStringList; var List: TList): string;
  var
    I: Integer;
    s14, s28, s1C, s20, s24: string;
    DefineInfo: pTDefineInfo;
    LoadStrList: TStringList;
  begin
    for I := 0 to LoadList.Count - 1 do begin
      s14 := Trim(LoadList.Strings[I]);
      if (s14 <> '') and (s14[1] = '#') then begin
        if CompareLStr(s14, '#SETHOME', Length('#SETHOME')) then begin
          Result := Trim(GetValidStr3(s14, s1C, [' ', #9]));
          LoadList.Strings[I] := '';
        end;
        if CompareLStr(s14, '#DEFINE', Length('#DEFINE')) then begin
          s14 := (GetValidStr3(s14, s1C, [' ', #9]));
          s14 := (GetValidStr3(s14, s20, [' ', #9]));
          s14 := (GetValidStr3(s14, s24, [' ', #9]));
          New(DefineInfo);
          DefineInfo.sName := UpperCase(s20);
          DefineInfo.sText := s24;
          List.Add(DefineInfo);
          LoadList.Strings[I] := '';
        end;
        if CompareLStr(s14, '#INCLUDE', Length('#INCLUDE')) then begin
          s28 := Trim(GetValidStr3(s14, s1C, [' ', #9]));
          s28 := g_Config.sEnvirDir + 'Defines\' + s28;
          if FileExists(s28) then begin
            LoadStrList := TStringList.Create;
            LoadStrList.LoadFromFile(s28);
            Result := LoadDefineInfo(LoadStrList, List);
            LoadStrList.Free;
          end else begin
            MainOutMessage('script error, load fail: ' + s28);
          end;
          LoadList.Strings[I] := '';
        end;
      end;
    end;
  end;
  function MakeNewScript(): pTScript;
  var
    ScriptInfo: pTScript;
  begin
    New(ScriptInfo);
    ScriptInfo.boQuest := False;
    FillChar(ScriptInfo.QuestInfo, SizeOf(TQuestInfo) * 10, #0);
    nQuestIdx := 0;
    ScriptInfo.RecordList := TList.Create;
    NPC.m_ScriptList.Add(ScriptInfo);
    Result := ScriptInfo;
  end;
  function QuestCondition(sText: string; var QuestConditionInfo: pTQuestConditionInfo): Boolean;
  var
    sCmd, sParam1, sParam2, sParam3, sParam4, sParam5, sParam6, sParam7, sParam8, sParam9, sParam10: string;
    nCMDCode: Integer;
  label L001;
  begin
    Result := False;
    sText := GetValidStrCap(sText, sCmd, [' ', #9]);
    sText := GetValidStrCap(sText, sParam1, [' ', #9]);
    sText := GetValidStrCap(sText, sParam2, [' ', #9]);
    sText := GetValidStrCap(sText, sParam3, [' ', #9]);
    sText := GetValidStrCap(sText, sParam4, [' ', #9]);
    sText := GetValidStrCap(sText, sParam5, [' ', #9]);
    sText := GetValidStrCap(sText, sParam6, [' ', #9]);

    sText := GetValidStrCap(sText, sParam7, [' ', #9]);
    sText := GetValidStrCap(sText, sParam8, [' ', #9]);
    sText := GetValidStrCap(sText, sParam9, [' ', #9]);
    sText := GetValidStrCap(sText, sParam10, [' ', #9]);
    sCmd := UpperCase(sCmd);
    sCmd := QuestConditionInfo.Script.Cmd(sCmd);
    nCMDCode := 0;
    if sCmd = sCHECK then begin
      nCMDCode := nCHECK;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then nCMDCode := 0;
      if not IsStringNumber(sParam2) then nCMDCode := 0;
      goto L001;
    end;
    if sCmd = sCHECKOPEN then begin
      nCMDCode := nCHECKOPEN;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then nCMDCode := 0;
      if not IsStringNumber(sParam2) then nCMDCode := 0;
      goto L001;
    end;

    if sCmd = sCHECKUNIT then begin
      nCMDCode := nCHECKUNIT;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then nCMDCode := 0;
      if not IsStringNumber(sParam2) then nCMDCode := 0;
      goto L001;
    end;
    if sCmd = sCHECKPKPOINT then begin
      nCMDCode := nCHECKPKPOINT;
      goto L001;
    end;
    if sCmd = sCHECKGOLD then begin
      nCMDCode := nCHECKGOLD;
      goto L001;
    end;
    if sCmd = sCHECKLEVEL then begin
      nCMDCode := nCHECKLEVEL;
      goto L001;
    end;
    if sCmd = sCHECKJOB then begin
      nCMDCode := nCHECKJOB;
      goto L001;
    end;
    if sCmd = sRANDOM then begin
      nCMDCode := nRANDOM;
      goto L001;
    end;
    if sCmd = sCHECKITEM then begin
      nCMDCode := nCHECKITEM;
      goto L001;
    end;
    if sCmd = sGENDER then begin
      nCMDCode := nGENDER;
      goto L001;
    end;
    if sCmd = sCHECKBAGGAGE then begin
      nCMDCode := nCHECKBAGGAGE;
      goto L001;
    end;

    if sCmd = sCHECKNAMELIST then begin
      nCMDCode := nCHECKNAMELIST;
      goto L001;
    end;
    if sCmd = sSC_HASGUILD then begin
      nCMDCode := nSC_HASGUILD;
      goto L001;
    end;

    if sCmd = sSC_ISGUILDMASTER then begin
      nCMDCode := nSC_ISGUILDMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEMASTER then begin
      nCMDCode := nSC_CHECKCASTLEMASTER;
      goto L001;
    end;
    if sCmd = sSC_ISNEWHUMAN then begin
      nCMDCode := nSC_ISNEWHUMAN;
      goto L001;
    end;
    if sCmd = sSC_CHECKMEMBERTYPE then begin
      nCMDCode := nSC_CHECKMEMBERTYPE;
      goto L001;
    end;
    if sCmd = sSC_CHECKMEMBERLEVEL then begin
      nCMDCode := nSC_CHECKMEMBERLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKGAMEGOLD then begin
      nCMDCode := nSC_CHECKGAMEGOLD;
      goto L001;
    end;
    if sCmd = sSC_CHECKGAMEPOINT then begin
      nCMDCode := nSC_CHECKGAMEPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKNAMELISTPOSITION then begin
      nCMDCode := nSC_CHECKNAMELISTPOSITION;
      goto L001;
    end;
    if sCmd = sSC_CHECKGUILDLIST then begin
      nCMDCode := nSC_CHECKGUILDLIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKRENEWLEVEL then begin
      nCMDCode := nSC_CHECKRENEWLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKSLAVELEVEL then begin
      nCMDCode := nSC_CHECKSLAVELEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKSLAVENAME then begin
      nCMDCode := nSC_CHECKSLAVENAME;
      goto L001;
    end;
    if sCmd = sSC_CHECKCREDITPOINT then begin
      nCMDCode := nSC_CHECKCREDITPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKOFGUILD then begin
      nCMDCode := nSC_CHECKOFGUILD;
      goto L001;
    end;
    if sCmd = sSC_CHECKPAYMENT then begin
      nCMDCode := nSC_CHECKPAYMENT;
      goto L001;
    end;
    if sCmd = sSC_CHECKUSEITEM then begin
      nCMDCode := nSC_CHECKUSEITEM;
      goto L001;
    end;
    if sCmd = sSC_CHECKBAGSIZE then begin
      nCMDCode := nSC_CHECKBAGSIZE;
      goto L001;
    end;
    if sCmd = sSC_CHECKLISTCOUNT then begin
      nCMDCode := nSC_CHECKLISTCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKDC then begin
      nCMDCode := nSC_CHECKDC;
      goto L001;
    end;
    if sCmd = sSC_CHECKMC then begin
      nCMDCode := nSC_CHECKMC;
      goto L001;
    end;
    if sCmd = sSC_CHECKSC then begin
      nCMDCode := nSC_CHECKSC;
      goto L001;
    end;
    if sCmd = sSC_CHECKHP then begin
      nCMDCode := nSC_CHECKHP;
      goto L001;
    end;
    if sCmd = sSC_CHECKMP then begin
      nCMDCode := nSC_CHECKMP;
      goto L001;
    end;
    if sCmd = sSC_CHECKITEMTYPE then begin
      nCMDCode := nSC_CHECKITEMTYPE;
      goto L001;
    end;
    if sCmd = sSC_CHECKEXP then begin
      nCMDCode := nSC_CHECKEXP;
      goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEGOLD then begin
      nCMDCode := nSC_CHECKCASTLEGOLD;
      goto L001;
    end;
    if sCmd = sSC_PASSWORDERRORCOUNT then begin
      nCMDCode := nSC_PASSWORDERRORCOUNT;
      goto L001;
    end;
    if sCmd = sSC_ISLOCKPASSWORD then begin
      nCMDCode := nSC_ISLOCKPASSWORD;
      goto L001;
    end;
    if sCmd = sSC_ISLOCKSTORAGE then begin
      nCMDCode := nSC_ISLOCKSTORAGE;
      goto L001;
    end;
    if sCmd = sSC_CHECKBUILDPOINT then begin
      nCMDCode := nSC_CHECKBUILDPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKAURAEPOINT then begin
      nCMDCode := nSC_CHECKAURAEPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKSTABILITYPOINT then begin
      nCMDCode := nSC_CHECKSTABILITYPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKFLOURISHPOINT then begin
      nCMDCode := nSC_CHECKFLOURISHPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKCONTRIBUTION then begin
      nCMDCode := nSC_CHECKCONTRIBUTION;
      goto L001;
    end;
    if sCmd = sSC_CHECKRANGEMONCOUNT then begin
      nCMDCode := nSC_CHECKRANGEMONCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKITEMADDVALUE then begin
      nCMDCode := nSC_CHECKITEMADDVALUE;
      goto L001;
    end;
    if sCmd = sSC_CHECKINMAPRANGE then begin
      nCMDCode := nSC_CHECKINMAPRANGE;
      goto L001;
    end;
    if sCmd = sSC_CASTLECHANGEDAY then begin
      nCMDCode := nSC_CASTLECHANGEDAY;
      goto L001;
    end;
    if sCmd = sSC_CASTLEWARDAY then begin
      nCMDCode := nSC_CASTLEWARDAY;
      goto L001;
    end;
    if sCmd = sSC_ONLINELONGMIN then begin
      nCMDCode := nSC_ONLINELONGMIN;
      goto L001;
    end;
    if sCmd = sSC_CHECKGUILDCHIEFITEMCOUNT then begin
      nCMDCode := nSC_CHECKGUILDCHIEFITEMCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKNAMEDATELIST then begin
      nCMDCode := nSC_CHECKNAMEDATELIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKMAPHUMANCOUNT then begin
      nCMDCode := nSC_CHECKMAPHUMANCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKMAPMONCOUNT then begin
      nCMDCode := nSC_CHECKMAPMONCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKVAR then begin
      nCMDCode := nSC_CHECKVAR;
      goto L001;
    end;
    if sCmd = sSC_CHECKSERVERNAME then begin
      nCMDCode := nSC_CHECKSERVERNAME;
      goto L001;
    end;
    if sCmd = sSC_ISATTACKGUILD then begin
      nCMDCode := nSC_ISATTACKGUILD;
      goto L001;
    end;
    if sCmd = sSC_ISDEFENSEGUILD then begin
      nCMDCode := nSC_ISDEFENSEGUILD;
      goto L001;
    end;
    if sCmd = sSC_ISATTACKALLYGUILD then begin
      nCMDCode := nSC_ISATTACKALLYGUILD;
      goto L001;
    end;
    if sCmd = sSC_ISDEFENSEALLYGUILD then begin
      nCMDCode := nSC_ISDEFENSEALLYGUILD;
      goto L001;
    end;
    if sCmd = sSC_ISCASTLEGUILD then begin
      nCMDCode := nSC_ISCASTLEGUILD;
      goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEDOOR then begin
      nCMDCode := nSC_CHECKCASTLEDOOR;
      goto L001;
    end;
    if sCmd = sSC_ISSYSOP then begin
      nCMDCode := nSC_ISSYSOP;
      goto L001;
    end;
    if sCmd = sSC_ISADMIN then begin
      nCMDCode := nSC_ISADMIN;
      goto L001;
    end;
    if sCmd = sSC_CHECKGROUPCOUNT then begin
      nCMDCode := nSC_CHECKGROUPCOUNT;
      goto L001;
    end;
    if sCmd = sCHECKACCOUNTLIST then begin
      nCMDCode := nCHECKACCOUNTLIST;
      goto L001;
    end;
    if sCmd = sCHECKIPLIST then begin
      nCMDCode := nCHECKIPLIST;
      goto L001;
    end;
    if sCmd = sCHECKBBCOUNT then begin
      nCMDCode := nCHECKBBCOUNT;
      goto L001;
    end;
    if sCmd = sCHECKCREDITPOINT then begin
      nCMDCode := nCHECKCREDITPOINT;
      goto L001;
    end;
    if sCmd = sDAYTIME then begin
      nCMDCode := nDAYTIME;
      goto L001;
    end;
    if sCmd = sCHECKITEMW then begin
      nCMDCode := nCHECKITEMW;
      goto L001;
    end;
    if sCmd = sISTAKEITEM then begin
      nCMDCode := nISTAKEITEM;
      goto L001;
    end;
    if sCmd = sCHECKDURA then begin
      nCMDCode := nCHECKDURA;
      goto L001;
    end;
    if sCmd = sCHECKDURAEVA then begin
      nCMDCode := nCHECKDURAEVA;
      goto L001;
    end;
    if sCmd = sDAYOFWEEK then begin
      nCMDCode := nDAYOFWEEK;
      goto L001;
    end;
    if sCmd = sHOUR then begin
      nCMDCode := nHOUR;
      goto L001;
    end;
    if sCmd = sMIN then begin
      nCMDCode := nMIN;
      goto L001;
    end;
    if sCmd = sCHECKLUCKYPOINT then begin
      nCMDCode := nCHECKLUCKYPOINT;
      goto L001;
    end;
    if sCmd = sCHECKMONMAP then begin
      nCMDCode := nCHECKMONMAP;
      goto L001;
    end;
    if sCmd = sCHECKMONAREA then begin
      nCMDCode := nCHECKMONAREA;
      goto L001;
    end;
    if sCmd = sCHECKHUM then begin
      nCMDCode := nCHECKHUM;
      goto L001;
    end;
    if sCmd = sEQUAL then begin
      nCMDCode := nEQUAL;
      goto L001;
    end;
    if sCmd = sLARGE then begin
      nCMDCode := nLARGE;
      goto L001;
    end;
    if sCmd = sSMALL then begin
      nCMDCode := nSMALL;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEDIR then begin
      nCMDCode := nSC_CHECKPOSEDIR;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSELEVEL then begin
      nCMDCode := nSC_CHECKPOSELEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEGENDER then begin
      nCMDCode := nSC_CHECKPOSEGENDER;
      goto L001;
    end;
    if sCmd = sSC_CHECKLEVELEX then begin
      nCMDCode := nSC_CHECKLEVELEX;
      goto L001;
    end;
    if sCmd = sSC_CHECKBONUSPOINT then begin
      nCMDCode := nSC_CHECKBONUSPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKMARRY then begin
      nCMDCode := nSC_CHECKMARRY;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEMARRY then begin
      nCMDCode := nSC_CHECKPOSEMARRY;
      goto L001;
    end;
    if sCmd = sSC_CHECKMARRYCOUNT then begin
      nCMDCode := nSC_CHECKMARRYCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKMASTER then begin
      nCMDCode := nSC_CHECKMASTER;
      goto L001;
    end;
    if sCmd = sSC_HAVEMASTER then begin
      nCMDCode := nSC_HAVEMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEMASTER then begin
      nCMDCode := nSC_CHECKPOSEMASTER;
      goto L001;
    end;
    if sCmd = sSC_POSEHAVEMASTER then begin
      nCMDCode := nSC_POSEHAVEMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKISMASTER then begin
      nCMDCode := nSC_CHECKISMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEISMASTER then begin
      nCMDCode := nSC_CHECKPOSEISMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKNAMEIPLIST then begin
      nCMDCode := nSC_CHECKNAMEIPLIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKACCOUNTIPLIST then begin
      nCMDCode := nSC_CHECKACCOUNTIPLIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKSLAVECOUNT then begin
      nCMDCode := nSC_CHECKSLAVECOUNT;
      goto L001;
    end;
    if sCmd = sCHECKMAPNAME then begin
      nCMDCode := nCHECKMAPNAME;
      goto L001;
    end;
    if sCmd = sINSAFEZONE then begin
      nCMDCode := nINSAFEZONE;
      goto L001;
    end;
    if sCmd = sCHECKSKILL then begin
      nCMDCode := nCHECKSKILL;
      goto L001;
    end;
    if sCmd = sSC_CHECKUSERDATE then begin
      nCMDCode := nSC_CHECKUSERDATE;
      goto L001;
    end;
    if sCmd = sSC_CHECKCONTAINSTEXT then begin
      nCMDCode := nSC_CHECKCONTAINSTEXT;
      goto L001;
    end;
    if sCmd = sSC_COMPARETEXT then begin
      nCMDCode := nSC_COMPARETEXT;
      goto L001;
    end;
    if sCmd = sSC_CHECKTEXTLIST then begin
      nCMDCode := nSC_CHECKTEXTLIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKCONTAINSTEXTLIST then begin
      nCMDCode := nSC_CHECKCONTAINSTEXTLIST;
      goto L001;
    end;
    if sCmd = sSC_ISGROUPMASTER then begin
      nCMDCode := nSC_ISGROUPMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKONLINE then begin
      nCMDCode := nSC_CHECKONLINE;
      goto L001;
    end;
    if sCmd = sSC_CHECKTEXTLENGTH then begin
      nCMDCode := nSC_CHECKTEXTLENGTH;
      goto L001;
    end;
    if sCmd = sSC_ISDUPMODE then begin
      nCMDCode := nSC_ISDUPMODE;
      goto L001;
    end;
    if sCmd = sSC_ISOFFLINEMODE then begin
      nCMDCode := nSC_ISOFFLINEMODE;
      goto L001;
    end;
    if sCmd = sSC_CHECKSTATIONTIME then begin
      nCMDCode := nSC_CHECKSTATIONTIME;
      goto L001;
    end;
    if sCmd = sSC_CHECKSIGNMAP then begin
      nCMDCode := nSC_CHECKSIGNMAP;
      goto L001;
    end;

    if sCmd = sSC_HAVEHERO then begin
      nCMDCode := nSC_HAVEHERO;
      goto L001;
    end;

    if sCmd = sSC_CHECKGUILDMEMBERMAXLIMIT then begin
      nCMDCode := nSC_CHECKGUILDMEMBERMAXLIMIT;
      goto L001;
    end;

    if sCmd = sSC_CHECKGUILDNAMEDATELIST then begin
      nCMDCode := nSC_CHECKGUILDNAMEDATELIST;
      goto L001;
    end;

    if sCmd = sSC_CHECKRANGEROUPCOUNT then begin
      nCMDCode := nSC_CHECKRANGEROUPCOUNT;
      goto L001;
    end;

    if sCmd = sSC_CHECKONLINEPLAYCOUNT then begin
      nCMDCode := nSC_CHECKONLINEPLAYCOUNT;
      goto L001;
    end;

    if sCmd = sSC_ACTMISSION then begin
      nCMDCode := nSC_ACTMISSION;
      goto L001;
    end;

    if sCmd = sSC_CHECKITEMLIMIT then begin
      nCMDCode := nSC_CHECKITEMLIMIT;
      goto L001;
    end;

    if sCmd = sSC_CHECKITEMLIMITCOUNT then begin
      nCMDCode := nSC_CHECKITEMLIMITCOUNT;
      goto L001;
    end;

    if sCmd = sSC_CHECKMEMORYITEM then begin
      nCMDCode := nSC_CHECKMEMORYITEM;
      goto L001;
    end;

    if sCmd = sSC_CHECKUPGRADEITEMS then begin
      nCMDCode := nSC_CHECKUPGRADEITEMS;
      goto L001;
    end;

    if sCmd = sSC_CHECKIPUTTEM then begin
      nCMDCode := nSC_CHECKIPUTTEM;
      goto L001;
    end;

    if sCmd = sSC_CHECKDEATH then begin
      nCMDCode := nSC_CHECKDEATH;
      goto L001;
    end;

    if sCmd = sSC_ISUNDERWAR then begin
      nCMDCode := nSC_ISUNDERWAR;
      goto L001;
    end;

    if sCmd = sSC_CHECKPKPOINTEX then begin
      nCMDCode := nSC_CHECKPKPOINTEX;
      goto L001;
    end;

    if sCmd = sSC_CHECKUSEITEMBIND then begin
      nCMDCode := nSC_CHECKUSEITEMBIND;
      goto L001;
    end;

    if sCmd = sSC_CHECKITEMBIND then begin
      nCMDCode := nSC_CHECKITEMBIND;
      goto L001;
    end;

    if sCmd = sSC_CHECKITEMNEWADDVALUE then begin
      nCMDCode := nSC_CHECKITEMNEWADDVALUE;
      goto L001;
    end;

    if sCmd = sSC_ISSPACELOCK then begin
      nCMDCode := nSC_ISSPACELOCK;
      goto L001;
    end;

    if sCmd = sSC_CHECKRANGEMAPMAGICEVENTCOUNT then begin
      nCMDCode := nSC_CHECKRANGEMAPMAGICEVENTCOUNT;
      goto L001;
    end;

    if sCmd = sSC_CHECKITEMNEWADDVALUECOUNT then begin
      nCMDCode := nSC_CHECKITEMNEWADDVALUECOUNT;
      goto L001;
    end;
    if sCmd = sSC_GETDUELMAP then begin
      nCMDCode := nSC_GETDUELMAP;
      goto L001;
    end;
    if sCmd = sSC_CHECKMAPDUELING then begin
      nCMDCode := nSC_CHECKMAPDUELING;
      goto L001;
    end;
    if sCmd = sSC_CHECKHUMDUELING then begin
      nCMDCode := nSC_CHECKHUMDUELING;
      goto L001;
    end;
    if sCmd = sSC_CHECKCANUSEITEM then begin
      nCMDCode := nSC_CHECKCANUSEITEM;
      goto L001;
    end;
    if sCmd = sSC_CHECKINCURRRECT then begin
      nCMDCode := nSC_CHECKINCURRRECT;
      goto L001;
    end;
    if sCmd = sSC_CHECKGUILDMEMBER then begin
      nCMDCode := nSC_CHECKGUILDMEMBER;
      goto L001;
    end;
    if sCmd = sSC_INDEXOF then begin
      nCMDCode := nSC_INDEXOF;
      goto L001;
    end;
    if sCmd = sSC_CHECKMASKED then begin
      nCMDCode := nSC_CHECKMASKED;
      goto L001;
    end;
    if sCmd = sSC_CHECKUSEITEMSTARSLEVEL then begin
      nCMDCode := nSC_CHECKUSEITEMSTARSLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKBAGITEMSTARSLEVEL then begin
      nCMDCode := nSC_CHECKBAGITEMSTARSLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKHEROGROUP then begin
      nCMDCode := nSC_CHECKHEROGROUP;
      goto L001;
    end;
    if sCmd = sSC_CHECKPUTITEMTYPE then begin
      nCMDCode := nSC_CHECKPUTITEMTYPE;
      goto L001;
    end;
    if sCmd = sSC_CHECKSLAVERANGE then begin
      nCMDCode := nSC_CHECKSLAVERANGE;
      goto L001;
    end;
    if sCmd = sSC_ISAI then begin
      nCMDCode := nSC_ISAI;
      goto L001;
    end;
    if sCmd = sSC_CHECKBAGITEMINLIST then begin
      nCMDCode := nSC_CHECKBAGITEMINLIST;
      goto L001;
    end;
    if sCmd = sSC_INCASTLEWARAREA then begin
      nCMDCode := nSC_INCASTLEWARAREA;
      goto L001;
    end;
    if nCMDCode <= 0 then begin
      if Assigned(PlugInEngine.QuestConditionScriptCmd) then begin
        nCMDCode := PlugInEngine.QuestConditionScriptCmd(PChar(sCmd));
        if nCMDCode >= 0 then goto L001;
      end;
    end;

    L001:
    if nCMDCode > 0 then begin
      QuestConditionInfo.nCMDCode := nCMDCode;
      if (sParam1 <> '') and (sParam1[1] = '"') then begin
        ArrestStringEx(sParam1, '"', '"', sParam1);
      end;
      if (sParam2 <> '') and (sParam2[1] = '"') then begin
        ArrestStringEx(sParam2, '"', '"', sParam2);
      end;
      if (sParam3 <> '') and (sParam3[1] = '"') then begin
        ArrestStringEx(sParam3, '"', '"', sParam3);
      end;
      if (sParam4 <> '') and (sParam4[1] = '"') then begin
        ArrestStringEx(sParam4, '"', '"', sParam4);
      end;
      if (sParam5 <> '') and (sParam5[1] = '"') then begin
        ArrestStringEx(sParam5, '"', '"', sParam5);
      end;
      if (sParam6 <> '') and (sParam6[1] = '"') then begin
        ArrestStringEx(sParam6, '"', '"', sParam6);
      end;

      if (sParam7 <> '') and (sParam7[1] = '"') then begin
        ArrestStringEx(sParam7, '"', '"', sParam7);
      end;
      if (sParam8 <> '') and (sParam8[1] = '"') then begin
        ArrestStringEx(sParam8, '"', '"', sParam8);
      end;
      if (sParam9 <> '') and (sParam9[1] = '"') then begin
        ArrestStringEx(sParam9, '"', '"', sParam9);
      end;
      if (sParam10 <> '') and (sParam10[1] = '"') then begin
        ArrestStringEx(sParam10, '"', '"', sParam10);
      end;

      QuestConditionInfo.sParam1 := sParam1;
      QuestConditionInfo.sParam2 := sParam2;
      QuestConditionInfo.sParam3 := sParam3;
      QuestConditionInfo.sParam4 := sParam4;
      QuestConditionInfo.sParam5 := sParam5;
      QuestConditionInfo.sParam6 := sParam6;

      QuestConditionInfo.sParam7 := sParam7;
      QuestConditionInfo.sParam8 := sParam8;
      QuestConditionInfo.sParam9 := sParam9;
      QuestConditionInfo.sParam10 := sParam10;

      if IsStringNumber(sParam1) then
        QuestConditionInfo.nParam1 := Str_ToInt(sParam1, 0);
      if IsStringNumber(sParam2) then
        QuestConditionInfo.nParam2 := Str_ToInt(sParam2, 0);
      if IsStringNumber(sParam3) then
        QuestConditionInfo.nParam3 := Str_ToInt(sParam3, 0);
      if IsStringNumber(sParam4) then
        QuestConditionInfo.nParam4 := Str_ToInt(sParam4, 0);
      if IsStringNumber(sParam5) then
        QuestConditionInfo.nParam5 := Str_ToInt(sParam5, 0);
      if IsStringNumber(sParam6) then
        QuestConditionInfo.nParam6 := Str_ToInt(sParam6, 0);

      if IsStringNumber(sParam7) then
        QuestConditionInfo.nParam7 := Str_ToInt(sParam7, 0);
      if IsStringNumber(sParam8) then
        QuestConditionInfo.nParam8 := Str_ToInt(sParam8, 0);
      if IsStringNumber(sParam9) then
        QuestConditionInfo.nParam9 := Str_ToInt(sParam9, 0);
      if IsStringNumber(sParam10) then
        QuestConditionInfo.nParam10 := Str_ToInt(sParam10, 0);
      Result := True;
    end;
  end;

  function QuestAction(sText: string; var QuestActionInfo: pTQuestActionInfo): Boolean;
  var
    sCmd, sParam1, sParam2, sParam3, sParam4, sParam5, sParam6, sParam7, sParam8, sParam9, sParam10: string;
    nCMDCode: Integer;
  label L001;
  begin
    Result := False;
    sText := GetValidStrCap(sText, sCmd, [' ', #9]);
    sText := GetValidStrCap(sText, sParam1, [' ', #9]);
    sText := GetValidStrCap(sText, sParam2, [' ', #9]);
    sText := GetValidStrCap(sText, sParam3, [' ', #9]);
    sText := GetValidStrCap(sText, sParam4, [' ', #9]);
    sText := GetValidStrCap(sText, sParam5, [' ', #9]);
    sText := GetValidStrCap(sText, sParam6, [' ', #9]);

    sText := GetValidStrCap(sText, sParam7, [' ', #9]);
    sText := GetValidStrCap(sText, sParam8, [' ', #9]);
    sText := GetValidStrCap(sText, sParam9, [' ', #9]);
    sText := GetValidStrCap(sText, sParam10, [' ', #9]);
    sCmd := UpperCase(sCmd);
    sCmd := QuestActionInfo.Script.Cmd(sCmd);
    nCMDCode := 0;
    if sCmd = sSET then begin
      nCMDCode := nSET;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then nCMDCode := 0;
      if not IsStringNumber(sParam2) then nCMDCode := 0;
    end;

    if sCmd = sRESET then begin
      nCMDCode := nRESET;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then nCMDCode := 0;
      if not IsStringNumber(sParam2) then nCMDCode := 0;
    end;
    if sCmd = sSETOPEN then begin
      nCMDCode := nSETOPEN;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then nCMDCode := 0;
      if not IsStringNumber(sParam2) then nCMDCode := 0;
    end;
    if sCmd = sSETUNIT then begin
      nCMDCode := nSETUNIT;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then nCMDCode := 0;
      if not IsStringNumber(sParam2) then nCMDCode := 0;
    end;
    if sCmd = sRESETUNIT then begin
      nCMDCode := nRESETUNIT;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then nCMDCode := 0;
      if not IsStringNumber(sParam2) then nCMDCode := 0;
    end;
    if sCmd = sTAKE then begin
      nCMDCode := nTAKE;
      goto L001;
    end;
    if sCmd = sSC_GIVE then begin
      nCMDCode := nSC_GIVE;
      goto L001;
    end;
    if sCmd = sCLOSE then begin
      nCMDCode := nCLOSE;
      goto L001;
    end;
    if sCmd = sBREAK then begin
      nCMDCode := nBREAK;
      goto L001;
    end;
    if sCmd = sGOTO then begin
      nCMDCode := nGOTO;
      goto L001;
    end;
    if sCmd = sADDNAMELIST then begin
      nCMDCode := nADDNAMELIST;
      goto L001;
    end;
    if sCmd = sDELNAMELIST then begin
      nCMDCode := nDELNAMELIST;
      goto L001;
    end;
    if sCmd = sADDGUILDLIST then begin
      nCMDCode := nADDGUILDLIST;
      goto L001;
    end;
    if sCmd = sDELGUILDLIST then begin
      nCMDCode := nDELGUILDLIST;
      goto L001;
    end;
    if sCmd = sSC_MAPTING then begin
      nCMDCode := nSC_MAPTING;
      goto L001;
    end;
    if sCmd = sSC_LINEMSG then begin
      nCMDCode := nSC_LINEMSG;
      goto L001;
    end;

    if sCmd = sADDACCOUNTLIST then begin
      nCMDCode := nADDACCOUNTLIST;
      goto L001;
    end;
    if sCmd = sDELACCOUNTLIST then begin
      nCMDCode := nDELACCOUNTLIST;
      goto L001;
    end;
    if sCmd = sADDIPLIST then begin
      nCMDCode := nADDIPLIST;
      goto L001;
    end;
    if sCmd = sDELIPLIST then begin
      nCMDCode := nDELIPLIST;
      goto L001;
    end;
    if sCmd = sSENDMSG then begin
      nCMDCode := nSENDMSG;
      goto L001;
    end;
    if sCmd = sCHANGEMODE then begin
      nCMDCode := nCHANGEMODE;
      goto L001;
    end;
    if sCmd = sPKPOINT then begin
      nCMDCode := nPKPOINT;
      goto L001;
    end;
    if sCmd = sCHANGEXP then begin
      nCMDCode := nCHANGEXP;
      goto L001;
    end;
    if sCmd = sSC_RECALLMOB then begin
      nCMDCode := nSC_RECALLMOB;
      goto L001;
    end;
    if sCmd = sKICK then begin
      nCMDCode := nKICK;
      goto L001;
    end;
    if sCmd = sTAKEW then begin
      nCMDCode := nTAKEW;
      goto L001;
    end;
    if sCmd = sTIMERECALL then begin
      nCMDCode := nTIMERECALL;
      goto L001;
    end;
    if sCmd = sSC_PARAM1 then begin
      nCMDCode := nSC_PARAM1;
      goto L001;
    end;
    if sCmd = sSC_PARAM2 then begin
      nCMDCode := nSC_PARAM2;
      goto L001;
    end;
    if sCmd = sSC_PARAM3 then begin
      nCMDCode := nSC_PARAM3;
      goto L001;
    end;
    if sCmd = sSC_PARAM4 then begin
      nCMDCode := nSC_PARAM4;
      goto L001;
    end;
    if sCmd = sSC_EXEACTION then begin
      nCMDCode := nSC_EXEACTION;
      goto L001;
    end;
    if sCmd = sMAPMOVE then begin
      nCMDCode := nMAPMOVE;
      goto L001;
    end;
    if sCmd = sMAP then begin
      nCMDCode := nMAP;
      goto L001;
    end;
    if sCmd = sTAKECHECKITEM then begin
      nCMDCode := nTAKECHECKITEM;
      goto L001;
    end;
    if sCmd = sMONGEN then begin
      nCMDCode := nMONGEN;
      goto L001;
    end;
    if sCmd = sMONCLEAR then begin
      nCMDCode := nMONCLEAR;
      goto L001;
    end;
    if sCmd = sMOV then begin
      nCMDCode := nMOV;
      goto L001;
    end;
    if sCmd = sINC then begin
      nCMDCode := nINC;
      goto L001;
    end;
    if sCmd = sDEC then begin
      nCMDCode := nDEC;
      goto L001;
    end;
    if sCmd = sSUM then begin
      nCMDCode := nSUM;
      goto L001;
    end;
    if sCmd = sBREAKTIMERECALL then begin
      nCMDCode := nBREAKTIMERECALL;
      goto L001;
    end;
    if sCmd = sMOVR then begin
      nCMDCode := nMOVR;
      goto L001;
    end;
    if sCmd = sEXCHANGEMAP then begin
      nCMDCode := nEXCHANGEMAP;
      goto L001;
    end;
    if sCmd = sRECALLMAP then begin
      nCMDCode := nRECALLMAP;
      goto L001;
    end;
    if sCmd = sADDBATCH then begin
      nCMDCode := nADDBATCH;
      goto L001;
    end;
    if sCmd = sBATCHDELAY then begin
      nCMDCode := nBATCHDELAY;
      goto L001;
    end;
    if sCmd = sBATCHMOVE then begin
      nCMDCode := nBATCHMOVE;
      goto L001;
    end;
    if sCmd = sPLAYDICE then begin
      nCMDCode := nPLAYDICE;
      goto L001;
    end;
    if sCmd = sGOQUEST then begin
      nCMDCode := nGOQUEST;
      goto L001;
    end;
    if sCmd = sENDQUEST then begin
      nCMDCode := nENDQUEST;
      goto L001;
    end;
    if sCmd = sSC_HAIRCOLOR then begin
      nCMDCode := nSC_HAIRCOLOR;
      goto L001;
    end;
    if sCmd = sSC_WEARCOLOR then begin
      nCMDCode := nSC_WEARCOLOR;
      goto L001;
    end;
    if sCmd = sSC_HAIRSTYLE then begin
      nCMDCode := nSC_HAIRSTYLE;
      goto L001;
    end;
    if sCmd = sSC_MONRECALL then begin
      nCMDCode := nSC_MONRECALL;
      goto L001;
    end;
    if sCmd = sSC_HORSECALL then begin
      nCMDCode := nSC_HORSECALL;
      goto L001;
    end;
    if sCmd = sSC_HAIRRNDCOL then begin
      nCMDCode := nSC_HAIRRNDCOL;
      goto L001;
    end;
    if sCmd = sSC_KILLHORSE then begin
      nCMDCode := nSC_KILLHORSE;
      goto L001;
    end;
    if sCmd = sSC_RANDSETDAILYQUEST then begin
      nCMDCode := nSC_RANDSETDAILYQUEST;
      goto L001;
    end;

    if sCmd = sSC_CHANGELEVEL then begin
      nCMDCode := nSC_CHANGELEVEL;
      goto L001;
    end;
    if sCmd = sSC_MARRY then begin
      nCMDCode := nSC_MARRY;
      goto L001;
    end;
    if sCmd = sSC_UNMARRY then begin
      nCMDCode := nSC_UNMARRY;
      goto L001;
    end;
    if sCmd = sSC_GETMARRY then begin
      nCMDCode := nSC_GETMARRY;
      goto L001;
    end;
    if sCmd = sSC_GETMASTER then begin
      nCMDCode := nSC_GETMASTER;
      goto L001;
    end;
    if sCmd = sSC_CLEARSKILL then begin
      nCMDCode := nSC_CLEARSKILL;
      goto L001;
    end;
    if sCmd = sSC_DELNOJOBSKILL then begin
      nCMDCode := nSC_DELNOJOBSKILL;
      goto L001;
    end;
    if sCmd = sSC_DELSKILL then begin
      nCMDCode := nSC_DELSKILL;
      goto L001;
    end;
    if sCmd = sSC_ADDSKILL then begin
      nCMDCode := nSC_ADDSKILL;
      goto L001;
    end;
    if sCmd = sSC_SKILLLEVEL then begin
      nCMDCode := nSC_SKILLLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHANGEPKPOINT then begin
      nCMDCode := nSC_CHANGEPKPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHANGEEXP then begin
      nCMDCode := nSC_CHANGEEXP;
      goto L001;
    end;
    if sCmd = sSC_CHANGEJOB then begin
      nCMDCode := nSC_CHANGEJOB;
      goto L001;
    end;
    if sCmd = sSC_MISSION then begin
      nCMDCode := nSC_MISSION;
      goto L001;
    end;
    if sCmd = sSC_MOBPLACE then begin
      nCMDCode := nSC_MOBPLACE;
      goto L001;
    end;
    if sCmd = sSC_SETMEMBERTYPE then begin
      nCMDCode := nSC_SETMEMBERTYPE;
      goto L001;
    end;
    if sCmd = sSC_SETMEMBERLEVEL then begin
      nCMDCode := nSC_SETMEMBERLEVEL;
      goto L001;
    end;
    if sCmd = sSC_GAMEGOLD then begin
      nCMDCode := nSC_GAMEGOLD;
      goto L001;
    end;
    if sCmd = sSC_GAMEPOINT then begin
      nCMDCode := nSC_GAMEPOINT;
      goto L001;
    end;
    if sCmd = sSC_PKZONE then begin
      nCMDCode := nSC_PKZONE;
      goto L001;
    end;
    if sCmd = sSC_RESTBONUSPOINT then begin
      nCMDCode := nSC_RESTBONUSPOINT;
      goto L001;
    end;
    if sCmd = sSC_TAKECASTLEGOLD then begin
      nCMDCode := nSC_TAKECASTLEGOLD;
      goto L001;
    end;
    if sCmd = sSC_HUMANHP then begin
      nCMDCode := nSC_HUMANHP;
      goto L001;
    end;
    if sCmd = sSC_HUMANMP then begin
      nCMDCode := nSC_HUMANMP;
      goto L001;
    end;
    if sCmd = sSC_BUILDPOINT then begin
      nCMDCode := nSC_BUILDPOINT;
      goto L001;
    end;
    if sCmd = sSC_AURAEPOINT then begin
      nCMDCode := nSC_AURAEPOINT;
      goto L001;
    end;
    if sCmd = sSC_STABILITYPOINT then begin
      nCMDCode := nSC_STABILITYPOINT;
      goto L001;
    end;
    if sCmd = sSC_FLOURISHPOINT then begin
      nCMDCode := nSC_FLOURISHPOINT;
      goto L001;
    end;
    if sCmd = sSC_OPENMAGICBOX then begin
      nCMDCode := nSC_OPENMAGICBOX;
      goto L001;
    end;
    if sCmd = sSC_SETRANKLEVELNAME then begin
      nCMDCode := nSC_SETRANKLEVELNAME;
      goto L001;
    end;
    if sCmd = sSC_GMEXECUTE then begin
      nCMDCode := nSC_GMEXECUTE;
      goto L001;
    end;
    if sCmd = sSC_GUILDCHIEFITEMCOUNT then begin
      nCMDCode := nSC_GUILDCHIEFITEMCOUNT;
      goto L001;
    end;
    if sCmd = sSC_ADDNAMEDATELIST then begin
      nCMDCode := nSC_ADDNAMEDATELIST;
      goto L001;
    end;
    if sCmd = sSC_DELNAMEDATELIST then begin
      nCMDCode := nSC_DELNAMEDATELIST;
      goto L001;
    end;
    if sCmd = sSC_MOBFIREBURN then begin
      nCMDCode := nSC_MOBFIREBURN;
      goto L001;
    end;
    if sCmd = sSC_MESSAGEBOX then begin
      nCMDCode := nSC_MESSAGEBOX;
      goto L001;
    end;
    if sCmd = sSC_SETSCRIPTFLAG then begin
      nCMDCode := nSC_SETSCRIPTFLAG;
      goto L001;
    end;
    if sCmd = sSC_SETAUTOGETEXP then begin
      nCMDCode := nSC_SETAUTOGETEXP;
      goto L001;
    end;
    if sCmd = sSC_VAR then begin
      nCMDCode := nSC_VAR;
      goto L001;
    end;
    if sCmd = sSC_LOADVAR then begin
      nCMDCode := nSC_LOADVAR;
      goto L001;
    end;
    if sCmd = sSC_SAVEVAR then begin
      nCMDCode := nSC_SAVEVAR;
      goto L001;
    end;
    if sCmd = sSC_CALCVAR then begin
      nCMDCode := nSC_CALCVAR;
      goto L001;
    end;
    if sCmd = sSC_AUTOADDGAMEGOLD then begin
      nCMDCode := nSC_AUTOADDGAMEGOLD;
      goto L001;
    end;
    if sCmd = sSC_AUTOSUBGAMEGOLD then begin
      nCMDCode := nSC_AUTOSUBGAMEGOLD;
      goto L001;
    end;
    if sCmd = sSC_RECALLGROUPMEMBERS then begin
      nCMDCode := nSC_RECALLGROUPMEMBERS;
      goto L001;
    end;
    if sCmd = sSC_CLEARNAMELIST then begin
      nCMDCode := nSC_CLEARNAMELIST;
      goto L001;
    end;
    if sCmd = sSC_CHANGENAMECOLOR then begin
      nCMDCode := nSC_CHANGENAMECOLOR;
      goto L001;
    end;
    if sCmd = sSC_CLEARPASSWORD then begin
      nCMDCode := nSC_CLEARPASSWORD;
      goto L001;
    end;
    if sCmd = sSC_RENEWLEVEL then begin
      nCMDCode := nSC_RENEWLEVEL;
      goto L001;
    end;
    if sCmd = sSC_KILLMONEXPRATE then begin
      nCMDCode := nSC_KILLMONEXPRATE;
      goto L001;
    end;
    if sCmd = sSC_POWERRATE then begin
      nCMDCode := nSC_POWERRATE;
      goto L001;
    end;
    if sCmd = sSC_CHANGEMODE then begin
      nCMDCode := nSC_CHANGEMODE;
      goto L001;
    end;
    if sCmd = sSC_CHANGEPERMISSION then begin
      nCMDCode := nSC_CHANGEPERMISSION;
      goto L001;
    end;
    if sCmd = sSC_KILL then begin
      nCMDCode := nSC_KILL;
      goto L001;
    end;
    if sCmd = sSC_KICK then begin
      nCMDCode := nSC_KICK;
      goto L001;
    end;
    if sCmd = sSC_BONUSPOINT then begin
      nCMDCode := nSC_BONUSPOINT;
      goto L001;
    end;
    if sCmd = sSC_RESTRENEWLEVEL then begin
      nCMDCode := nSC_RESTRENEWLEVEL;
      goto L001;
    end;
    if sCmd = sSC_DELMARRY then begin
      nCMDCode := nSC_DELMARRY;
      goto L001;
    end;
    if sCmd = sSC_DELMASTER then begin
      nCMDCode := nSC_DELMASTER;
      goto L001;
    end;
    if sCmd = sSC_MASTER then begin
      nCMDCode := nSC_MASTER;
      goto L001;
    end;
    if sCmd = sSC_UNMASTER then begin
      nCMDCode := nSC_UNMASTER;
      goto L001;
    end;
    if sCmd = sSC_CREDITPOINT then begin
      nCMDCode := nSC_CREDITPOINT;
      goto L001;
    end;
    if sCmd = sSC_CLEARNEEDITEMS then begin
      nCMDCode := nSC_CLEARNEEDITEMS;
      goto L001;
    end;
    if sCmd = sSC_CLEARMAKEITEMS then begin
      nCMDCode := nSC_CLEARMAEKITEMS;
      goto L001;
    end;
    if sCmd = sSC_SETSENDMSGFLAG then begin
      nCMDCode := nSC_SETSENDMSGFLAG;
      goto L001;
    end;
    if sCmd = sSC_UPGRADEITEMS then begin
      nCMDCode := nSC_UPGRADEITEMS;
      goto L001;
    end;
    if sCmd = sSC_UPGRADEITEMSEX then begin
      nCMDCode := nSC_UPGRADEITEMSEX;
      goto L001;
    end;
    if sCmd = sSC_MONGENEX then begin
      nCMDCode := nSC_MONGENEX;
      goto L001;
    end;
    if sCmd = sSC_CLEARMAPMON then begin
      nCMDCode := nSC_CLEARMAPMON;
      goto L001;
    end;
    if sCmd = sSC_SETMAPMODE then begin
      nCMDCode := nSC_SETMAPMODE;
      goto L001;
    end;
    if sCmd = sSC_KILLSLAVE then begin
      nCMDCode := nSC_KILLSLAVE;
      goto L001;
    end;
    if sCmd = sSC_CHANGEGENDER then begin
      nCMDCode := nSC_CHANGEGENDER;
      goto L001;
    end;
    if sCmd = sSC_MAPTING then begin
      nCMDCode := nSC_MAPTING;
      goto L001;
    end;
    if sCmd = sOFFLINEPLAY then begin
      nCMDCode := nOFFLINEPLAY;
      goto L001;
    end;
    if sCmd = sKICKOFFLINE then begin
      nCMDCode := nKICKOFFLINE;
      goto L001;
    end;
    if sCmd = sSTARTTAKEGOLD then begin
      nCMDCode := nSTARTTAKEGOLD;
      goto L001;
    end;
    if sCmd = sSC_DELAYGOTO then begin
      nCMDCode := nSC_DELAYGOTO;
      goto L001;
    end;
    if sCmd = sCLEARDELAYGOTO then begin
      nCMDCode := nCLEARDELAYGOTO;
      goto L001;
    end;
    if sCmd = sCHANGERECOMMENDGAMEGOLD then begin
      nCMDCode := nCHANGERECOMMENDGAMEGOLD;
      goto L001;
    end;
    if sCmd = sSC_ADDUSERDATE then begin
      nCMDCode := nSC_ADDUSERDATE;
      goto L001;
    end;
    if sCmd = sSC_DELUSERDATE then begin
      nCMDCode := nSC_DELUSERDATE;
      goto L001;
    end;
    if sCmd = sSC_ANSIREPLACETEXT then begin
      nCMDCode := nSC_ANSIREPLACETEXT;
      goto L001;
    end;
    if sCmd = sSC_ENCODETEXT then begin
      nCMDCode := nSC_ENCODETEXT;
      goto L001;
    end;
    if sCmd = sSC_DECODETEXT then begin
      nCMDCode := nSC_DECODETEXT;
      goto L001;
    end;
    if sCmd = sSC_ADDTEXTLIST then begin
      nCMDCode := nSC_ADDTEXTLIST;
      goto L001;
    end;
    if sCmd = sSC_DELTEXTLIST then begin
      nCMDCode := nSC_DELTEXTLIST;
      goto L001;
    end;
    if sCmd = sSC_GROUPMAPMOVE then begin
      nCMDCode := nSC_GROUPMAPMOVE;
      goto L001;
    end;
    if sCmd = sSC_RECALLHUMAN then begin
      nCMDCode := nSC_RECALLHUMAN;
      goto L001;
    end;
    if sCmd = sSC_REGOTO then begin
      nCMDCode := nSC_REGOTO;
      goto L001;
    end;
    if sCmd = sSC_INTTOSTR then begin
      nCMDCode := nSC_INTTOSTR;
      goto L001;
    end;
    if sCmd = sSC_STRTOINT then begin
      nCMDCode := nSC_STRTOINT;
      goto L001;
    end;
    if sCmd = sSC_GUILDMOVE then begin
      nCMDCode := nSC_GUILDMOVE;
      goto L001;
    end;
    if sCmd = sSC_GUILDMAPMOVE then begin
      nCMDCode := nSC_GUILDMAPMOVE;
      goto L001;
    end;
    if sCmd = sSC_RANDOMMOVE then begin
      nCMDCode := nSC_RANDOMMOVE;
      goto L001;
    end;
    if sCmd = sSC_USEBONUSPOINT then begin
      nCMDCode := nSC_USEBONUSPOINT;
      goto L001;
    end;
    if sCmd = sSC_REPAIRITEM then begin
      nCMDCode := nSC_REPAIRITEM;
      goto L001;
    end;
    if sCmd = sSC_TAKEONITEM then begin
      nCMDCode := nSC_TAKEONITEM;
      goto L001;
    end;
    if sCmd = sSC_TAKEOFFITEM then begin
      nCMDCode := nSC_TAKEOFFITEM;
      goto L001;
    end;
    if sCmd = sSC_CREATEHERO then begin
      nCMDCode := nSC_CREATEHERO;
      goto L001;
    end;
    if sCmd = sSC_DELETEHERO then begin
      nCMDCode := nSC_DELETEHERO;
      goto L001;
    end;

    if sCmd = sSC_GIVEEX then begin
      nCMDCode := nSC_GIVEEX;
      goto L001;
    end;
    if sCmd = sSC_TIMEOPEN then begin
      nCMDCode := nSC_TIMEOPEN;
      goto L001;
    end;
    if sCmd = sSC_TIMECLOSE then begin
      nCMDCode := nSC_TIMECLOSE;
      goto L001;
    end;
    if sCmd = sSC_TIMECLOSE then begin
      nCMDCode := nSC_TIMECLOSE;
      goto L001;
    end;

    if sCmd = sSC_GUILDMEMBERMAXLIMIT then begin
      nCMDCode := nSC_GUILDMEMBERMAXLIMIT;
      goto L001;
    end;

    if sCmd = sSC_OPENUSERMARKET then begin
      nCMDCode := nSC_OPENUSERMARKET;
      goto L001;
    end;

    if sCmd = sSC_ADDGUILDNAMEDATELIST then begin
      nCMDCode := nSC_ADDGUILDNAMEDATELIST;
      goto L001;
    end;
    if sCmd = sSC_DELGUILDNAMEDATELIST then begin
      nCMDCode := nSC_DELGUILDNAMEDATELIST;
      goto L001;
    end;
    if sCmd = sSC_GOHOME then begin
      nCMDCode := nSC_GOHOME;
      goto L001;
    end;
    if sCmd = sSC_ADDBLOCKIPLIST then begin
      nCMDCode := nSC_ADDBLOCKIPLIST;
      goto L001;
    end;
    if sCmd = sSC_ACTMISSION then begin
      nCMDCode := nSC_ACTMISSION;
      goto L001;
    end;
    if sCmd = sSC_MOVDATA then begin
      nCMDCode := nSC_MOVDATA;
      goto L001;
    end;
    if sCmd = sSC_SENDCOLORMSG then begin
      nCMDCode := nSC_SENDCOLORMSG;
      goto L001;
    end;
    if sCmd = sSC_ADDRANDOMMAPGATE then begin
      nCMDCode := nSC_ADDRANDOMMAPGATE;
      goto L001;
    end;
    if sCmd = sSC_DELRANDOMMAPGATE then begin
      nCMDCode := nSC_DELRANDOMMAPGATE;
      goto L001;
    end;
    if sCmd = sSC_GETRANDOMMAPGATE then begin
      nCMDCode := nSC_GETRANDOMMAPGATE;
      goto L001;
    end;
    if sCmd = sSC_OPENBOOK then begin
      nCMDCode := nSC_OPENBOOK;
      goto L001;
    end;
    if sCmd = sSC_OPENBOX then begin
      nCMDCode := nSC_OPENBOX;
      goto L001;
    end;
    if sCmd = sSC_CHANGEITEMS then begin
      nCMDCode := nSC_CHANGEITEMS;
      goto L001;
    end;

    if sCmd = sSC_CLEARREMEMBER then begin
      nCMDCode := nSC_CLEARREMEMBER;
      goto L001;
    end;

    if sCmd = sSC_SENDMOVEMSG then begin
      nCMDCode := nSC_SENDMOVEMSG;
      goto L001;
    end;

    if sCmd = sSC_RECALLHERO then begin
      nCMDCode := nSC_RECALLHERO;
      goto L001;
    end;

    if sCmd = sSC_HEROLOGOUT then begin
      nCMDCode := nSC_HEROLOGOUT;
      goto L001;
    end;

    if sCmd = sSC_SETITEMSLIGHT then begin
      nCMDCode := nSC_SETITEMSLIGHT;
      goto L001;
    end;

    if sCmd = sSC_READRANDOMSTR then begin
      nCMDCode := nSC_READRANDOMSTR;
      goto L001;
    end;

    if sCmd = sSC_CHANGERANGEMONPOS then begin
      nCMDCode := nSC_CHANGERANGEMONPOS;
      goto L001;
    end;

    if sCmd = sSC_READ then begin
      nCMDCode := nSC_READ;
      goto L001;
    end;

    if sCmd = sSC_WRITE then begin
      nCMDCode := nSC_WRITE;
      goto L001;
    end;

    if sCmd = sSC_DIV then begin
      nCMDCode := nSC_DIV;
      goto L001;
    end;

    if sCmd = sSC_MUL then begin
      nCMDCode := nSC_MUL;
      goto L001;
    end;

    if sCmd = sSC_PERCENT then begin
      nCMDCode := nSC_PERCENT;
      goto L001;
    end;

    if sCmd = sSC_CHANGEITEMNEWADDVALUE then begin
      nCMDCode := nSC_CHANGEITEMNEWADDVALUE;
      goto L001;
    end;

    if sCmd = sSC_OPENHOMEPAGE then begin
      nCMDCode := nSC_OPENHOMEPAGE;
      goto L001;
    end;

    if sCmd = sSC_PKZONEX then begin
      nCMDCode := nSC_PKZONEX;
      goto L001;
    end;

    if sCmd = sSC_SETITEMSLIGHTEX then begin
      nCMDCode := nSC_SETITEMSLIGHTEX;
      goto L001;
    end;

    if sCmd = sSC_SPELL then begin
      nCMDCode := nSC_SPELL;
      goto L001;
    end;

    if sCmd = sSC_ADDMAPMAGICEVENT then begin
      nCMDCode := nSC_ADDMAPMAGICEVENT;
      goto L001;
    end;

    if sCmd = sSC_RANDOMADDMAPMAGICEVENT then begin
      nCMDCode := nSC_RANDOMADDMAPMAGICEVENT;
      goto L001;
    end;

    if sCmd = sSC_DROPITEMMAP then begin
      nCMDCode := nSC_DROPITEMMAP;
      goto L001;
    end;

    if sCmd = sSC_SNOW then begin
      nCMDCode := nSC_SNOW;
      goto L001;
    end;

    if sCmd = sSC_RANDOMUPGRADEITEM then begin
      nCMDCode := nSC_RANDOMUPGRADEITEM;
      goto L001;
    end;

    if sCmd = sSC_LOCK then begin
      nCMDCode := nSC_LOCK;
      goto L001;
    end;

    if sCmd = sSC_UNLOCK then begin
      nCMDCode := nSC_UNLOCK;
      goto L001;
    end;

    if sCmd = sSC_CLEARDUELMAP then begin
      nCMDCode := nSC_CLEARDUELMAP;
      goto L001;
    end;
    if sCmd = sSC_GETDUELITEMS then begin
      nCMDCode := nSC_GETDUELITEMS;
      goto L001;
    end;
    if sCmd = sSC_APPDUEL then begin
      nCMDCode := nSC_APPDUEL;
      goto L001;
    end;
    if sCmd = sSC_CANUSEITEM then begin
      nCMDCode := nSC_CANUSEITEM;
      goto L001;
    end;
    if sCmd = sSC_AUTOGOTOXY then begin
      nCMDCode := nSC_AUTOGOTOXY;
      goto L001;
    end;
    if sCmd = sSC_CHANGENEWSTATUS then begin
      nCMDCode := nSC_CHANGENEWSTATUS;
      goto L001;
    end;

    if sCmd = sSC_SENDDELAYMSG then begin
      nCMDCode := nSC_SENDDELAYMSG;
      goto L001;
    end;

    if sCmd = sSC_ACTVARLIST then begin
      nCMDCode := nSC_ACTVARLIST;
      goto L001;
    end;

    if sCmd = sSC_SETMASKED then begin
      nCMDCode := nSC_SETMASKED;
      goto L001;
    end;

    if sCmd = sSC_SENDCENTERMSG then begin
      nCMDCode := nSC_SENDCENTERMSG;
      goto L001;
    end;

    if sCmd = sSC_CHANGEUSEITEMSTARSLEVEL then begin
      nCMDCode := nSC_CHANGEUSEITEMSTARSLEVEL;
      goto L001;
    end;

    if sCmd = sSC_CHANGEBAGITEMSTARSLEVEL then begin
      nCMDCode := nSC_CHANGEBAGITEMSTARSLEVEL;
      goto L001;
    end;

    if sCmd = sSC_BINDBAGITEM then begin
      nCMDCode := nSC_BINDBAGITEM;
      goto L001;
    end;

    if sCmd = sSC_HEROGROUP then begin
      nCMDCode := nSC_HEROGROUP;
      goto L001;
    end;
    if sCmd = sSC_UNHEROGROUP then begin
      nCMDCode := nSC_UNHEROGROUP;
      goto L001;
    end;
    if sCmd = sSC_SETSCTIMER then begin
      nCMDCode := nSC_SETSCTIMER;
      goto L001;
    end;
    if sCmd = sSC_KILLSCTIMER then begin
      nCMDCode := nSC_KILLSCTIMER;
      goto L001;
    end;
    if sCmd = sSC_PLAYSOUND then begin
      nCMDCode := nSC_PLAYSOUND;
      goto L001;
    end;
    if sCmd = sSC_SHOWEFFECT then begin
      nCMDCode := nSC_SHOWEFFECT;
      goto L001;
    end;
    if sCmd = sSC_CHANGEITEMVALUE then begin
      nCMDCode := nSC_CHANGEITEMVALUE;
      goto L001;
    end;
    if sCmd = sSC_VIBRATION then begin
      nCMDCode := nSC_VIBRATION;
      goto L001;
    end;
    if sCmd = sSC_OPENBIGDIALOGBOX then begin
      nCMDCode := nSC_OPENBIGDIALOGBOX;
      goto L001;
    end;
    if sCmd = sSC_CLOSEBIGDIALOGBOX then begin
      nCMDCode := nSC_CLOSEBIGDIALOGBOX;
      goto L001;
    end;
    if sCmd = sSC_TAGMAPMOVE then begin
      nCMDCode := nSC_TAGMAPMOVE;
      goto L001;
    end;
    if sCmd = sSC_TAGMAPINFO then begin
      nCMDCode := nSC_TAGMAPINFO;
      goto L001;
    end;
    if sCmd = sSC_AISTART then begin
      nCMDCode := nSC_AISTART;
      goto L001;
    end;
    if sCmd = sSC_AISTOP then begin
      nCMDCode := nSC_AISTOP;
      goto L001;
    end;
    if sCmd = sSC_CHANGEIPADDRESS then begin
      nCMDCode := nSC_CHANGEIPADDRESS;
      goto L001;
    end;
    if sCmd = sSC_CHANGEATTATCKMODE then begin
      nCMDCode := nSC_CHANGEATTATCKMODE;
      goto L001;
    end;
    if sCmd = sSC_AILOGON then begin
      nCMDCode := nSC_AILOGON;
      goto L001;
    end;
    if sCmd = sSC_AILOGONEX then begin
      nCMDCode := nSC_AILOGONEX;
      goto L001;
    end;
    if sCmd = sSC_KICKALL then begin
      nCMDCode := nSC_KICKALL;
      goto L001;
    end;
    if sCmd = sSC_TAKEITEMLIST then begin
      nCMDCode := nSC_TAKEITEMLIST;
      goto L001;
    end;
    if sCmd = sSC_SHOWRANKLEVLNAME then begin
      nCMDCode := nSC_SHOWRANKLEVLNAME;
      goto L001;
    end;
    if sCmd = sSC_LOADROBOTCONFIG then begin
      nCMDCode := nSC_LOADROBOTCONFIG;
      goto L001;
    end;
    if nCMDCode <= 0 then begin
      if Assigned(PlugInEngine.QuestActionScriptCmd) then begin
        nCMDCode := PlugInEngine.QuestActionScriptCmd(PChar(sCmd));
        if nCMDCode >= 0 then goto L001;
      end;
    end;


    L001:
    if nCMDCode > 0 then begin
      QuestActionInfo.nCMDCode := nCMDCode;
      if (sParam1 <> '') and (sParam1[1] = '"') then begin
        ArrestStringEx(sParam1, '"', '"', sParam1);
      end;
      if (sParam2 <> '') and (sParam2[1] = '"') then begin
        ArrestStringEx(sParam2, '"', '"', sParam2);
      end;
      if (sParam3 <> '') and (sParam3[1] = '"') then begin
        ArrestStringEx(sParam3, '"', '"', sParam3);
      end;
      if (sParam4 <> '') and (sParam4[1] = '"') then begin
        ArrestStringEx(sParam4, '"', '"', sParam4);
      end;
      if (sParam5 <> '') and (sParam5[1] = '"') then begin
        ArrestStringEx(sParam5, '"', '"', sParam5);
      end;
      if (sParam6 <> '') and (sParam6[1] = '"') then begin
        ArrestStringEx(sParam6, '"', '"', sParam6);
      end;
      if (sParam7 <> '') and (sParam7[1] = '"') then begin
        ArrestStringEx(sParam7, '"', '"', sParam7);
      end;
      if (sParam8 <> '') and (sParam8[1] = '"') then begin
        ArrestStringEx(sParam8, '"', '"', sParam8);
      end;
      if (sParam9 <> '') and (sParam9[1] = '"') then begin
        ArrestStringEx(sParam9, '"', '"', sParam9);
      end;
      if (sParam10 <> '') and (sParam10[1] = '"') then begin
        ArrestStringEx(sParam10, '"', '"', sParam10);
      end;

      QuestActionInfo.sParam1 := sParam1;
      QuestActionInfo.sParam2 := sParam2;
      QuestActionInfo.sParam3 := sParam3;
      QuestActionInfo.sParam4 := sParam4;
      QuestActionInfo.sParam5 := sParam5;
      QuestActionInfo.sParam6 := sParam6;

      QuestActionInfo.sParam7 := sParam7;
      QuestActionInfo.sParam8 := sParam8;
      QuestActionInfo.sParam9 := sParam9;
      QuestActionInfo.sParam10 := sParam10;

      if IsStringNumber(sParam1) then
        QuestActionInfo.nParam1 := Str_ToInt(sParam1, 0);
      if IsStringNumber(sParam2) then
        QuestActionInfo.nParam2 := Str_ToInt(sParam2, 1);
      if IsStringNumber(sParam3) then
        QuestActionInfo.nParam3 := Str_ToInt(sParam3, 1);
      if IsStringNumber(sParam4) then
        QuestActionInfo.nParam4 := Str_ToInt(sParam4, 0);
      if IsStringNumber(sParam5) then
        QuestActionInfo.nParam5 := Str_ToInt(sParam5, 0);
      if IsStringNumber(sParam6) then
        QuestActionInfo.nParam6 := Str_ToInt(sParam6, 0);

      if IsStringNumber(sParam7) then
        QuestActionInfo.nParam7 := Str_ToInt(sParam7, 0);
      if IsStringNumber(sParam8) then
        QuestActionInfo.nParam8 := Str_ToInt(sParam8, 0);
      if IsStringNumber(sParam9) then
        QuestActionInfo.nParam9 := Str_ToInt(sParam9, 0);
      if IsStringNumber(sParam10) then
        QuestActionInfo.nParam10 := Str_ToInt(sParam10, 0);
      Result := True;
    end;
  end;
begin
  Result := -1;
  n6C := 0;
  n70 := 0;
  sScritpFileName := g_Config.sEnvirDir + sPatch + sScritpName + '.txt';
  if FileExists(sScritpFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sScritpFileName);
      DeCodeStringList(LoadList);
    except
      LoadList.Free;
      Exit;
    end;
    I := 0;

    while (True) do begin
      LoadScriptcall(LoadList);
      Inc(I);
      if I >= 10 then Break;
    end;

    DefineList := TList.Create;

    s54 := LoadDefineInfo(LoadList, DefineList);
    New(DefineInfo);
    DefineInfo.sName := '@HOME';
    if s54 = '' then s54 := '@main';
    DefineInfo.sText := s54;
    DefineList.Add(DefineInfo);
    // 常量处理
    for I := 0 to LoadList.Count - 1 do begin
      s34 := Trim(LoadList.Strings[I]);
      if (s34 <> '') then begin
        if (s34[1] = '[') then begin
          bo8D := False;
        end else begin
          if (s34[1] = '#') and
            (CompareLStr(s34, '#IF', Length('#IF')) or
            CompareLStr(s34, '#ACT', Length('#ACT')) or
            CompareLStr(s34, '#ELSEACT', Length('#ELSEACT'))) then begin
            bo8D := True;
          end else begin
            if bo8D then begin
              // 将Define 好的常量换成指定值
              for n20 := 0 to DefineList.Count - 1 do begin
                DefineInfo := DefineList.Items[n20];
                n1C := 0;
                while (True) do begin
                  n24 := Pos(DefineInfo.sName, UpperCase(s34));
                  if n24 <= 0 then Break;
                  s58 := Copy(s34, 1, n24 - 1);
                  s5C := Copy(s34, Length(DefineInfo.sName) + n24, 256);
                  s34 := s58 + DefineInfo.sText + s5C;
                  LoadList.Strings[I] := s34;
                  Inc(n1C);
                  if n1C >= 10 then Break;
                end;
              end; // 将Define 好的常量换成指定值
            end;
          end;
        end;
      end;
    end;
    // 常量处理

    //释放常量定义内容
    for I := 0 to DefineList.Count - 1 do begin
      Dispose(pTDefineInfo(DefineList.Items[I]));
    end;
    DefineList.Free;
    //释放常量定义内容

    Script := nil;
    SayingRecord := nil;
    nQuestIdx := 0;
    for I := 0 to LoadList.Count - 1 do begin
      s34 := Trim(LoadList.Strings[I]);
      if (s34 = '') or (s34[1] = ';') or (s34[1] = '/') then Continue;
      if (n6C = 0) and (boFlag) then begin
        //物品价格倍率
        if s34[1] = '%' then begin
          s34 := Copy(s34, 2, Length(s34) - 1);
          nPriceRate := Str_ToInt(s34, -1);
          if nPriceRate >= 55 then begin
            TMerchant(NPC).m_nPriceRate := nPriceRate;
          end;
          Continue;
        end;
        //物品交易类型
        if s34[1] = '+' then begin
          s34 := Copy(s34, 2, Length(s34) - 1);
          nItemType := Str_ToInt(s34, -1);
          if nItemType >= 0 then begin
            TMerchant(NPC).m_ItemTypeList.Add(Pointer(nItemType));
          end;
          Continue;
        end;
        //增加处理NPC可执行命令设置
        if s34[1] = '(' then begin
          ArrestStringEx(s34, '(', ')', s34);
          if s34 <> '' then begin
            while (s34 <> '') do begin
              s34 := GetValidStr3(s34, s30, [' ', ',', #9]);
              if CompareText(s30, sBUY) = 0 then begin
                TMerchant(NPC).m_boBuy := True;
                Continue;
              end;
              if CompareText(s30, sSELL) = 0 then begin
                TMerchant(NPC).m_boSell := True;
                Continue;
              end;
              if CompareText(s30, sMAKEDURG) = 0 then begin
                TMerchant(NPC).m_boMakeDrug := True;
                Continue;
              end;
              if CompareText(s30, sPRICES) = 0 then begin
                TMerchant(NPC).m_boPrices := True;
                Continue;
              end;
              if CompareText(s30, sSTORAGE) = 0 then begin
                TMerchant(NPC).m_boStorage := True;
                Continue;
              end;
              if CompareText(s30, sGETBACK) = 0 then begin
                TMerchant(NPC).m_boGetback := True;
                Continue;
              end;
              if CompareText(s30, sUPGRADENOW) = 0 then begin
                TMerchant(NPC).m_boUpgradenow := True;
                Continue;
              end;
              if CompareText(s30, sGETBACKUPGNOW) = 0 then begin
                TMerchant(NPC).m_boGetBackupgnow := True;
                Continue;
              end;
              if CompareText(s30, sREPAIR) = 0 then begin
                TMerchant(NPC).m_boRepair := True;
                Continue;
              end;
              if CompareText(s30, sSUPERREPAIR) = 0 then begin
                TMerchant(NPC).m_boS_repair := True;
                Continue;
              end;
              if CompareText(s30, sSL_SENDMSG) = 0 then begin
                TMerchant(NPC).m_boSendmsg := True;
                Continue;
              end;
              if CompareText(s30, sUSEITEMNAME) = 0 then begin
                TMerchant(NPC).m_boUseItemName := True;
                Continue;
              end;
              if CompareText(s30, sGETSELLGOLD) = 0 then begin
                TMerchant(NPC).m_boGetSellGold := True;
                Continue;
              end;
              if CompareText(s30, sSELLOFF) = 0 then begin
                TMerchant(NPC).m_boSellOff := True;
                Continue;
              end;
              if CompareText(s30, sBUYOFF) = 0 then begin
                TMerchant(NPC).m_boBuyOff := True;
                Continue;
              end;
              if CompareText(s30, sofflinemsg) = 0 then begin
                TMerchant(NPC).m_boofflinemsg := True;
                Continue;
              end;
              if CompareText(s30, sdealgold) = 0 then begin
                TMerchant(NPC).m_boDealGold := True;
                Continue;
              end;
              if CompareText(s30, sBIGSTORAGE) = 0 then begin
                TMerchant(NPC).m_boBigStorage := True;
                Continue;
              end;
              if CompareText(s30, sBIGGETBACK) = 0 then begin
                TMerchant(NPC).m_boBigGetBack := True;
                Continue;
              end;
              if CompareText(s30, sGETPREVIOUSPAGE) = 0 then begin
                TMerchant(NPC).m_boGetPreviousPage := True;
                Continue;
              end;
              if CompareText(s30, sGETNEXTPAGE) = 0 then begin
                TMerchant(NPC).m_boGetNextPage := True;
                Continue;
              end;

              if CompareText(s30, sUserLevelOrder) = 0 then begin
                TMerchant(NPC).m_boUserLevelOrder := True;
                Continue;
              end;
              if CompareText(s30, sWarrorLevelOrder) = 0 then begin
                TMerchant(NPC).m_boWarrorLevelOrder := True;
                Continue;
              end;

              if CompareText(s30, sWizardLevelOrder) = 0 then begin
                TMerchant(NPC).m_boWizardLevelOrder := True;
                Continue;
              end;
              if CompareText(s30, sTaoistLevelOrder) = 0 then begin
                TMerchant(NPC).m_boTaoistLevelOrder := True;
                Continue;
              end;
              if CompareText(s30, sMasterCountOrder) = 0 then begin
                TMerchant(NPC).m_boMasterCountOrder := True;
                Continue;
              end;
              if CompareText(s30, sCqFirHero) = 0 then begin
                TMerchant(NPC).m_boCqFirHero := True;
                Continue;
              end;

              if CompareText(s30, sUPGRADEITEMS) = 0 then begin
                TMerchant(NPC).m_boUpgradeItem := True;
                Continue;
              end;
              if CompareText(s30, sAppDuel) = 0 then begin
                TMerchant(NPC).m_boAppDuel := True;
                Continue;
              end;
            end;
          end;
          Continue;
        end
      end;

      if s34[1] = '{' then begin
        if CompareLStr(s34, '{Quest', Length('{Quest')) then begin
          s38 := GetValidStr3(s34, s3C, [' ', '}', #9]);
          GetValidStr3(s38, s3C, [' ', '}', #9]);
          n70 := Str_ToInt(s3C, 0);
          Script := MakeNewScript();
          Script.nQuest := n70;
          Inc(n70);
        end;
        if CompareLStr(s34, '{~Quest', Length('{~Quest')) then Continue;
      end;

      if (n6C = 1) and (Script <> nil) and (s34[1] = '#') then begin
        s38 := GetValidStr3(s34, s3C, ['=', ' ', #9]);
        Script.boQuest := True;
        if CompareLStr(s34, '#IF', Length('#IF')) then begin
          ArrestStringEx(s34, '[', ']', s40);
          Script.QuestInfo[nQuestIdx].wFlag := Str_ToInt(s40, 0);
          GetValidStr3(s38, s44, ['=', ' ', #9]);
          n24 := Str_ToInt(s44, 0);
          if n24 <> 0 then n24 := 1;
          Script.QuestInfo[nQuestIdx].btValue := n24;
        end;

        if CompareLStr(s34, '#RAND', Length('#RAND')) then begin
          Script.QuestInfo[nQuestIdx].nRandRage := Str_ToInt(s44, 0);
        end;
        Continue;
      end;

      if s34[1] = '[' then begin
        n6C := 10;
        if Script = nil then begin
          Script := MakeNewScript();
          Script.nQuest := n70;
        end;
        if CompareText(s34, '[goods]') = 0 then begin
          n6C := 20;
          Continue;
        end;
        s34 := ArrestStringEx(s34, '[', ']', s74);
        New(SayingRecord);
        SayingRecord.ProcedureList := TList.Create;
        SayingRecord.sLabel := s74;
        s34 := GetValidStrCap(s34, s74, [' ', #9]);
        if CompareText(s74, 'TRUE') = 0 then begin
          SayingRecord.boExtJmp := True;
        end else begin
          SayingRecord.boExtJmp := False;
        end;
        New(SayingProcedure);
        SayingRecord.ProcedureList.Add(SayingProcedure);
        SayingProcedure.ConditionList := TList.Create;
        SayingProcedure.ActionList := TList.Create;
        SayingProcedure.sSayMsg := '';
        SayingProcedure.ElseActionList := TList.Create;
        SayingProcedure.sElseSayMsg := '';
        Script.RecordList.Add(SayingRecord);
        Continue;
      end;
      if (Script <> nil) and (SayingRecord <> nil) then begin
        if (n6C >= 10) and (n6C < 20) and (s34[1] = '#') then begin
          if CompareText(s34, '#IF') = 0 then begin
            if (SayingProcedure.ConditionList.Count > 0) or (SayingProcedure.sSayMsg <> '') then begin //0048BE53
              New(SayingProcedure);
              SayingRecord.ProcedureList.Add(SayingProcedure);
              SayingProcedure.ConditionList := TList.Create;
              SayingProcedure.ActionList := TList.Create;
              SayingProcedure.sSayMsg := '';
              SayingProcedure.ElseActionList := TList.Create;
              SayingProcedure.sElseSayMsg := '';
            end;
            n6C := 11;
          end;
          if CompareText(s34, '#ACT') = 0 then n6C := 12;
          if CompareText(s34, '#SAY') = 0 then n6C := 10;
          if CompareText(s34, '#ELSEACT') = 0 then n6C := 13;
          if CompareText(s34, '#ELSESAY') = 0 then n6C := 14;
          Continue;
        end;
        if (n6C = 10) and (SayingProcedure <> nil) then
          SayingProcedure.sSayMsg := SayingProcedure.sSayMsg + s34;

        if (n6C = 11) then begin
          New(QuestConditionInfo);
          FillChar(QuestConditionInfo^, SizeOf(TQuestConditionInfo), #0);
          QuestConditionInfo.Script := TScriptObject.Create;
          if QuestCondition(Trim(s34), QuestConditionInfo) then begin
            SayingProcedure.ConditionList.Add(QuestConditionInfo);
          end else begin
            QuestConditionInfo.Script.Free;
            Dispose(QuestConditionInfo);
            MainOutMessage('脚本错误: ' + s34 + ' 第:' + IntToStr(I) + ' 行: ' + sScritpFileName);
          end;
        end;
        if (n6C = 12) then begin
          New(QuestActionInfo);
          FillChar(QuestActionInfo^, SizeOf(TQuestActionInfo), #0);
          QuestActionInfo.Script := TScriptObject.Create;
          if QuestAction(Trim(s34), QuestActionInfo) then begin
            SayingProcedure.ActionList.Add(QuestActionInfo);
          end else begin
            QuestActionInfo.Script.Free;
            Dispose(QuestActionInfo);
            MainOutMessage('脚本错误: ' + s34 + ' 第:' + IntToStr(I) + ' 行: ' + sScritpFileName);
          end;
        end;
        if (n6C = 13) then begin
          New(QuestActionInfo);
          FillChar(QuestActionInfo^, SizeOf(TQuestActionInfo), #0);
          QuestActionInfo.Script := TScriptObject.Create;
          if QuestAction(Trim(s34), QuestActionInfo) then begin
            SayingProcedure.ElseActionList.Add(QuestActionInfo);
          end else begin
            QuestActionInfo.Script.Free;
            Dispose(QuestActionInfo);
            MainOutMessage('脚本错误: ' + s34 + ' 第:' + IntToStr(I) + ' 行: ' + sScritpFileName);
          end;
        end;
        if (n6C = 14) then
          SayingProcedure.sElseSayMsg := SayingProcedure.sElseSayMsg + s34;
      end;
      if (n6C = 20) and boFlag then begin
        s34 := GetValidStrCap(s34, s48, [' ', #9]);
        s34 := GetValidStrCap(s34, s4C, [' ', #9]);
        s34 := GetValidStrCap(s34, s50, [' ', #9]);
        if (s48 <> '') and (s50 <> '') then begin
          New(Goods);
          if (s48 <> '') and (s48[1] = '"') then begin
            ArrestStringEx(s48, '"', '"', s48);
          end;
          Goods.sItemName := s48;
          Goods.nCount := Str_ToInt(s4C, 0);
          Goods.dwRefillTime := Str_ToInt(s50, 0);
          Goods.dwRefillTick := 0;
          TMerchant(NPC).m_RefillGoodsList.Add(Goods);
        end;
      end;
    end; // for
    LoadList.Free;
  end else begin
    MainOutMessage('脚本文件未找到: ' + sScritpFileName);
  end;
  Result := 1;
end;

function TFrmDB.SaveGoodRecord(NPC: TMerchant; sFile: string): Integer;
var
  I, II: Integer;
  sFileName: string;
  FileHandle: Integer;
  UserItem: pTUserItem;
  List: TList;
  Header420: TGoodFileHeader;
begin
  Result := -1;
  sFileName := '.\Envir\Market_Saved\' + sFile + '.sav';
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
  end else begin
    FileHandle := FileCreate(sFileName);
  end;
  if FileHandle > 0 then begin
    FillChar(Header420, SizeOf(TGoodFileHeader), #0);
    for I := 0 to NPC.m_GoodsList.Count - 1 do begin
      List := TList(NPC.m_GoodsList.Items[I]);
      Inc(Header420.nItemCount, List.Count);
    end;
    FileWrite(FileHandle, Header420, SizeOf(TGoodFileHeader));
    for I := 0 to NPC.m_GoodsList.Count - 1 do begin
      List := TList(NPC.m_GoodsList.Items[I]);
      for II := 0 to List.Count - 1 do begin
        UserItem := List.Items[II];
        FileWrite(FileHandle, UserItem^, SizeOf(TUserItem));
      end;
    end;
    FileClose(FileHandle);
    Result := 1;
  end;
end;

function TFrmDB.SaveGoodPriceRecord(NPC: TMerchant; sFile: string): Integer;
var
  I: Integer;
  sFileName: string;
  FileHandle: Integer;
  ItemPrice: pTItemPrice;
  Header420: TGoodFileHeader;
begin
  Result := -1;
  sFileName := '.\Envir\Market_Prices\' + sFile + '.prc';
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
  end else begin
    FileHandle := FileCreate(sFileName);
  end;
  if FileHandle > 0 then begin
    FillChar(Header420, SizeOf(TGoodFileHeader), #0);
    Header420.nItemCount := NPC.m_ItemPriceList.Count;
    FileWrite(FileHandle, Header420, SizeOf(TGoodFileHeader));
    for I := 0 to NPC.m_ItemPriceList.Count - 1 do begin
      ItemPrice := NPC.m_ItemPriceList.Items[I];
      FileWrite(FileHandle, ItemPrice^, SizeOf(TItemPrice));
    end;
    FileClose(FileHandle);
    Result := 1;
  end;
end;

procedure TFrmDB.ReLoadNpc;
begin

end;

procedure TFrmDB.ReLoadMerchants;
var
  I, II, nX, nY, n100: Integer;
  sLineText, sFileName, sScript, sMapName, sX, sY, sCharName, sFlag, sAppr, sCastle, sCanMove, sMoveTime, sAutoChangeColor,
    sAutoChangeColorTime, sNpcMagic: string;
  Merchant: TMerchant;
  LoadList: TStringList;
  boNewNpc: Boolean;
begin
  sFileName := g_Config.sEnvirDir + 'Merchant.txt';
  if not FileExists(sFileName) then Exit;
  UserEngine.m_MerchantList.Lock;
  try
    for I := 0 to UserEngine.m_MerchantList.Count - 1 do begin
      Merchant := TMerchant(UserEngine.m_MerchantList.Items[I]);
      if Merchant <> g_FunctionNPC then
        Merchant.m_nFlag := -1;
    end;
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        sLineText := GetValidStr3(sLineText, sScript, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sMapName, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sX, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sY, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sCharName, [' ', #9]);
        if (sCharName <> '') and (sCharName[1] = '"') then
          ArrestStringEx(sCharName, '"', '"', sCharName);
        sLineText := GetValidStr3(sLineText, sFlag, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sAppr, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sCastle, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sCanMove, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sMoveTime, [' ', #9]);

        sLineText := GetValidStr3(sLineText, sAutoChangeColor, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sAutoChangeColorTime, [' ', #9]); //NPC变色
        sLineText := GetValidStr3(sLineText, sNpcMagic, [' ', #9]); //NPC魔法效果


        nX := Str_ToInt(sX, 0);
        nY := Str_ToInt(sY, 0);
        boNewNpc := True;
        for II := 0 to UserEngine.m_MerchantList.Count - 1 do begin
          Merchant := TMerchant(UserEngine.m_MerchantList.Items[II]);
          if (Merchant.m_sMapName = sMapName) and
            (Merchant.m_nCurrX = nX) and
            (Merchant.m_nCurrY = nY) then begin
            boNewNpc := False;
            Merchant.m_sScript := sScript;
            Merchant.m_sCharName := sCharName;
            Merchant.m_nFlag := Str_ToInt(sFlag, 0);
            Merchant.m_wAppr := Str_ToInt(sAppr, 0);
            Merchant.m_dwMoveTime := Str_ToInt(sMoveTime, 0);
            if Str_ToInt(sCastle, 0) <> 1 then Merchant.m_boCastle := True
            else Merchant.m_boCastle := False;

            if (Str_ToInt(sCanMove, 0) <> 0) and (Merchant.m_dwMoveTime > 0) then
              Merchant.m_boCanMove := True;
            Break;
          end;
        end;
        if boNewNpc then begin
          Merchant := TMerchant.Create;
          Merchant.m_NpcType := n_Merchant;
          Merchant.m_sMapName := sMapName;
          Merchant.m_PEnvir := g_MapManager.FindMap(Merchant.m_sMapName);
          if Merchant.m_PEnvir <> nil then begin
            Merchant.m_sScript := sScript;
            Merchant.m_nCurrX := nX;
            Merchant.m_nCurrY := nY;
            Merchant.m_sCharName := sCharName;
            Merchant.m_nFlag := Str_ToInt(sFlag, 0);
            Merchant.m_wAppr := Str_ToInt(sAppr, 0);
            Merchant.m_dwMoveTime := Str_ToInt(sMoveTime, 0);
            if Str_ToInt(sCastle, 0) <> 1 then Merchant.m_boCastle := True
            else Merchant.m_boCastle := False;
            if (Str_ToInt(sCanMove, 0) <> 0) and (Merchant.m_dwMoveTime > 0) then
              Merchant.m_boCanMove := True;

            Merchant.m_dwNpcAutoChangeColorTime := Str_ToInt(sAutoChangeColorTime, 0) * 1000;

            n100 := GetValNameNo(sCharName);
            case n100 of
              0..499: begin
                  Merchant.m_nVarIdx := n100 - 1000;
                  Merchant.m_sCharName := g_Config.GlobalAVal[Merchant.m_nVarIdx];
                end;
            end;

            if Merchant.m_wAppr in [53..61] then Merchant.m_btDirection := Random(4) + 3;
            if Merchant.m_wAppr in [62..70] then Merchant.m_btDirection := 0;

            if Str_ToInt(sAutoChangeColor, 0) <> 0 then //NPC变色
              Merchant.m_boNpcAutoChangeColor := True;
            Merchant.m_nNpcMagicIdx := Str_ToInt(sNpcMagic, 0); //NPC魔法效果

            UserEngine.m_MerchantList.Add(Merchant);
            Merchant.Initialize;
          end else Merchant.Free;
        end;
      end;
    end; // for
    LoadList.Free;
    for I := UserEngine.m_MerchantList.Count - 1 downto 0 do begin
      Merchant := TMerchant(UserEngine.m_MerchantList.Items[I]);
      if Merchant.m_nFlag = -1 then begin
        Merchant.m_boGhost := True;
        Merchant.m_dwGhostTick := GetTickCount();
        //        UserEngine.MerchantList.Delete(I);
      end;
    end;
  finally
    UserEngine.m_MerchantList.UnLock;
  end;
end;

function TFrmDB.LoadUpgradeWeaponRecord(sNPCName: string;
  DataList: TList): Integer;
var
  I: Integer;
  FileHandle: Integer;
  sFileName: string;
  UpgradeInfo: pTUpgradeInfo;
  UpgradeRecord: TUpgradeInfo;
  nRecordCount: Integer;
begin
  Result := -1;
  sFileName := '.\Envir\Market_Upg\' + sNPCName + '.upg';
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if FileHandle > 0 then begin
      FileRead(FileHandle, nRecordCount, SizeOf(Integer));
      for I := 0 to nRecordCount - 1 do begin
        if FileRead(FileHandle, UpgradeRecord, SizeOf(TUpgradeInfo)) = SizeOf(TUpgradeInfo) then begin
          New(UpgradeInfo);
          UpgradeInfo^ := UpgradeRecord;
          UpgradeInfo.dwGetBackTick := 0;
          DataList.Add(UpgradeInfo);
        end;
      end;
      FileClose(FileHandle);
      Result := 1;
    end;
  end;
end;

function TFrmDB.SaveUpgradeWeaponRecord(sNPCName: string; DataList: TList): Integer;
var
  I: Integer;
  FileHandle: Integer;
  sFileName: string;
  UpgradeInfo: pTUpgradeInfo;
begin
  Result := -1;
  sFileName := '.\Envir\Market_Upg\' + sNPCName + '.upg';
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
  end else begin
    FileHandle := FileCreate(sFileName);
  end;
  if FileHandle > 0 then begin
    FileWrite(FileHandle, DataList.Count, SizeOf(Integer));
    for I := 0 to DataList.Count - 1 do begin
      UpgradeInfo := DataList.Items[I];
      FileWrite(FileHandle, UpgradeInfo^, SizeOf(TUpgradeInfo));
    end;
    FileClose(FileHandle);
    Result := 1;
  end;
end;

function TFrmDB.LoadGoodRecord(NPC: TMerchant; sFile: string): Integer;
var
  I: Integer;
  sFileName: string;
  FileHandle: Integer;
  UserItem: pTUserItem;
  List: TList;
  Header420: TGoodFileHeader;
begin
  Result := -1;
  sFileName := '.\Envir\Market_Saved\' + sFile + '.sav';
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    List := nil;
    if FileHandle > 0 then begin
      if FileRead(FileHandle, Header420, SizeOf(TGoodFileHeader)) = SizeOf(TGoodFileHeader) then begin
        for I := 0 to Header420.nItemCount - 1 do begin
          New(UserItem);
          if FileRead(FileHandle, UserItem^, SizeOf(TUserItem)) = SizeOf(TUserItem) then begin
            if List = nil then begin
              List := TList.Create;
              List.Add(UserItem)
            end else begin
              if pTUserItem(List.Items[0]).wIndex = UserItem.wIndex then begin
                List.Add(UserItem);
              end else begin
                NPC.m_GoodsList.Add(List);
                List := TList.Create;
                List.Add(UserItem);
              end;
            end;
          end else begin
            Dispose(UserItem);
            UserItem := nil;
          end;
        end;
        if List <> nil then
          NPC.m_GoodsList.Add(List);
        FileClose(FileHandle);
        Result := 1;
      end;
    end;
  end;
end;

function TFrmDB.LoadGoodPriceRecord(NPC: TMerchant; sFile: string): Integer;
var
  I: Integer;
  sFileName: string;
  FileHandle: Integer;
  ItemPrice: pTItemPrice;
  Header420: TGoodFileHeader;
begin
  Result := -1;
  sFileName := '.\Envir\Market_Prices\' + sFile + '.prc';
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if FileHandle > 0 then begin
      if FileRead(FileHandle, Header420, SizeOf(TGoodFileHeader)) = SizeOf(TGoodFileHeader) then begin
        for I := 0 to Header420.nItemCount - 1 do begin
          New(ItemPrice);
          if FileRead(FileHandle, ItemPrice^, SizeOf(TItemPrice)) = SizeOf(TItemPrice) then begin
            NPC.m_ItemPriceList.Add(ItemPrice);
          end else begin
            Dispose(ItemPrice);
            Break;
          end;
        end;
      end;
      FileClose(FileHandle);
      Result := 1;
    end;
  end;
end;

function DeCodeString(sSrc: string): string;
var
  Dest: array[0..1024 * 2] of Char;
begin
  if sSrc = '' then Exit;
  if Assigned(PlugInEngine.ScriptDeCryptString) then begin
    FillChar(Dest, SizeOf(Dest), 0);
    PlugInEngine.ScriptDeCryptString(@sSrc[1], @Dest, Length(sSrc));
    Result := StrPas(PChar(@Dest));
    Exit;
  end;
  Result := sSrc;
end;

procedure TFrmDB.DeCodeStringList(StringList: TStringList);
var
  I: Integer;
  sLine: string;
begin
  if StringList.Count > 0 then begin
    sLine := StringList.Strings[0];
    if not CompareLStr(sLine, sENCYPTSCRIPTFLAG, Length(sENCYPTSCRIPTFLAG)) then begin
      Exit;
    end;
  end;

  for I := 0 to StringList.Count - 1 do begin
    sLine := StringList.Strings[I];
    sLine := DeCodeString(sLine);
    StringList.Strings[I] := sLine;
  end;
end;

constructor TFrmDB.Create();
begin
  CoInitialize(nil);

{$IF DBTYPE = BDE}
  Query := TQuery.Create(nil);
{$ELSE}
  Query := TADOQuery.Create(nil);
{$IFEND}
end;

destructor TFrmDB.Destroy;
begin
  Query.Free;
  CoUnInitialize;
  inherited;
end;

initialization


finalization


end.

