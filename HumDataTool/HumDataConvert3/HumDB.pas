unit HumDB;

interface
uses
  Windows, Classes, SysUtils, Forms, IniFiles, Share, Grobal2;
resourcestring
  sDBHeaderDesc = '飞尔世界数据库文件 2010/07/01';
  sDBIdxHeaderDesc = '飞尔世界数据库文件 2010/07/01';
type
  TDBHeader = packed record //Size 124
    sDesc: string[$23]; //0x00    36
    n24: Integer; //0x24
    n28: Integer; //0x28
    n2C: Integer; //0x2C
    n30: Integer; //0x30
    n34: Integer; //0x34
    n38: Integer; //0x38
    n3C: Integer; //0x3C
    n40: Integer; //0x40
    n44: Integer; //0x44
    n48: Integer; //0x48
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    nLastIndex: Integer; //0x5C
    dLastDate: TDateTime; //0x60
    nHumCount: Integer; //0x68
    n6C: Integer; //0x6C
    n70: Integer; //0x70
    dUpdateDate: TDateTime; //0x74
  end;
  pTDBHeader = ^TDBHeader;

 { TIdxHeader = packed record //Size 124
    sDesc: string[39]; //0x00
    n2C: Integer; //0x2C
    n30: Integer; //0x30
    n34: Integer; //0x34
    n38: Integer; //0x38
    n3C: Integer; //0x3C
    n40: Integer; //0x40
    n44: Integer; //0x44
    n48: Integer; //0x48
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    n5C: Integer; //0x5C
    n60: Integer; //0x60  95
    n70: Integer; //0x70  99
    nQuickCount: Integer; //0x74  100
    nHumCount: Integer; //0x78
    nDeleteCount: Integer; //0x7C
    nLastIndex: Integer; //0x80
    dUpdateDate: TDateTime; //0x84
  end;
  pTIdxHeader = ^TIdxHeader;

  TIdxRecord = record
    sChrName: string[15];
    nIndex: Integer;
  end;
  pTIdxRecord = ^TIdxRecord;  }


  TFileHumDB = class(TConvertData)
    m_Header: TDBHeader;
    m_QuickList: TQuickList;
    m_NewQuickList: TQuickList;
  private
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;
    procedure Load; override;
    procedure UnLoad; override;
    procedure Convert(); override;
    procedure SaveToFile(sFileName: string); override;
  end;

  TFileDB = class(TConvertData)
    m_Header: TDBHeader;
    m_MirCharNameList: TQuickList;
    m_NewMirCharNameList: TQuickList;
  private
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;
    procedure Load; override;
    procedure UnLoad; override;
    procedure Convert(); override;
    procedure SaveToFile(sFileName: string); override;
  end;

  TSellOff = class(TConvertData)
    m_Header: TItemCount;
    m_SellOffList: TQuickIDList;
    m_NewSellOffList: TQuickIDList;
    m_boGold: Boolean;
  private
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;
    procedure Load; override;
    procedure UnLoad; override;
    procedure Convert(); override;
    procedure SaveToFile(sFileName: string); override;
  end;

  TStorage = class(TConvertData)
    m_Header: TItemCount;
    m_BigStorageList: TQuickIDList;
    m_NewBigStorageList: TQuickIDList;
  private
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;
    procedure Load; override;
    procedure UnLoad; override;
    procedure Convert(); override;
    procedure SaveToFile(sFileName: string); override;
  end;


  TFileDuelItem = class(TConvertData)
    m_Header: TItemCount;
    m_QuickList: TQuickList;
    m_NewQuickList: TQuickList;
  private
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;
    procedure Load; override;
    procedure UnLoad; override;
    procedure Convert(); override;
    procedure SaveToFile(sFileName: string); override;
  end;
implementation

uses HUtil32, Main;

{ TFileDB }

constructor TFileDB.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_MirCharNameList := TQuickList.Create;
  m_NewMirCharNameList := TQuickList.Create;
end;

destructor TFileDB.Destroy;
begin
  UnLoad();
  m_MirCharNameList.Free;
  m_NewMirCharNameList.Free;
  inherited;
end;

procedure TFileDB.UnLoad();
var
  I: Integer;
begin
  for I := 0 to m_MirCharNameList.Count - 1 do begin
    Dispose(pTOHumDataInfo(m_MirCharNameList.Objects[I]));
  end;
  m_MirCharNameList.Clear;

  for I := 0 to m_NewMirCharNameList.Count - 1 do begin
    Dispose(pTHumDataInfo(m_NewMirCharNameList.Objects[I]));
  end;
  m_NewMirCharNameList.Clear;
end;

procedure TFileDB.Load();
var
  nIndex, nIdx: Integer;
  DBHeader: TDBHeader;
  RecordHeader: TRecordHeader;
  PHumanRCD: pTOHumDataInfo;
  HumanRCD: TOHumDataInfo;

begin
  m_nCount := 0;
  m_nPercent := 0;
  if not m_boConvert then Exit;
  ProcessMessage(Format(sLondData, [g_sFileNames[2]]));
  //DeleteList := TStringList.Create;
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then begin
        m_nCount := DBHeader.nHumCount;
        for nIndex := 0 to DBHeader.nHumCount - 1 do begin
          if g_boClose then Break;
          ProcessStatus();

          FillChar(HumanRCD, SizeOf(TOHumDataInfo), #0);

          if FileSeek(m_nFileHandle, nIndex * SizeOf(TOHumDataInfo) + SizeOf(TDBHeader), 0) = -1 then begin
            Break;
          end;

          if FileRead(m_nFileHandle, HumanRCD, SizeOf(TOHumDataInfo)) <> SizeOf(TOHumDataInfo) then begin
            Break;
          end;

          if (HumanRCD.Header.sName = '') or HumanRCD.Header.boDeleted then begin
              //DeleteList.Add('Account:' + HumanRCD.Data.sAccount + ' Name:' + HumanRCD.Header.sName + ' ChrName:' + HumanRCD.Data.sChrName);
            Continue;
          end;
            //DeleteList.Add('Account:' + HumanRCD.Data.sAccount + ' Name:' + HumanRCD.Header.sName + ' ChrName:' + HumanRCD.Data.sChrName);
          New(PHumanRCD);
          PHumanRCD^ := HumanRCD;
          m_MirCharNameList.AddObject(PHumanRCD.Data.sChrName, TObject(PHumanRCD));

          Application.ProcessMessages;
          if Application.Terminated then begin
            Close;
            Exit;
          end;
        end;
      end;
    end;
  finally
    Close();
  end;
  ProcessMessage('正在排序，请稍候...');
  m_MirCharNameList.SortString(0, m_MirCharNameList.Count - 1);
end;

function TFileDB.Open: Boolean;
begin
  if FileExists(m_sDBFileName) then begin
    m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then
      FileRead(m_nFileHandle, m_Header, SizeOf(TDBHeader));
  end else begin
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      m_Header.sDesc := sDBHeaderDesc;
      m_Header.nHumCount := 0;
      m_Header.n6C := 0;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
    end;
  end;
  if m_nFileHandle > 0 then Result := True
  else Result := False;
end;

procedure TFileDB.Close;
begin
  FileClose(m_nFileHandle);
end;

function TFileDB.OpenEx: Boolean;
var
  DBHeader: TDBHeader;
begin
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := True;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then
      m_Header := DBHeader;
  end else Result := False;
end;

procedure TFileDB.Convert();
var
  I, II: Integer;
  HumanRCD: pTHumDataInfo;
  OHumanRCD: pTOHumDataInfo;

  HumItems: pTHumItems;
  BagItems: pTBagItems;
  StorageItems: pTStorageItems;
  HumAddItems: pTHumAddItems;
  HumMagics: pTHumMagics;

  OHumItems: pTOHumItems;
  OBagItems: pTOBagItems;
  OStorageItems: pTOStorageItems;
  OHumAddItems: pTOHumAddItems;
  OHumMagics: pTOHumMagics;
begin
  if not m_boConvert then Exit;
  ProcessMessage(Format(sConvertData, [g_sFileNames[2]]));

  m_nPercent := 0;
  m_nCount := m_MirCharNameList.Count;

  for I := 0 to m_MirCharNameList.Count - 1 do begin

    OHumanRCD := pTOHumDataInfo(m_MirCharNameList.Objects[I]);
    New(HumanRCD);
    FillChar(HumanRCD^, SizeOf(THumDataInfo), #0);
    HumanRCD.Header := OHumanRCD.Header;
    HumanRCD.Data.sChrName := OHumanRCD.Data.sChrName;
    HumanRCD.Data.sCurMap := OHumanRCD.Data.sCurMap;
    HumanRCD.Data.wCurX := OHumanRCD.Data.wCurX;
    HumanRCD.Data.wCurY := OHumanRCD.Data.wCurY;
    HumanRCD.Data.btDir := OHumanRCD.Data.btDir;
    HumanRCD.Data.btHair := OHumanRCD.Data.btHair;
    HumanRCD.Data.btSex := OHumanRCD.Data.btSex;
    HumanRCD.Data.btJob := OHumanRCD.Data.btJob;
    HumanRCD.Data.nGold := OHumanRCD.Data.nGold;
    HumanRCD.Data.Abil := OHumanRCD.Data.Abil;
    HumanRCD.Data.wStatusTimeArr := OHumanRCD.Data.wStatusTimeArr;
    HumanRCD.Data.sHomeMap := OHumanRCD.Data.sHomeMap;
    HumanRCD.Data.wHomeX := OHumanRCD.Data.wHomeX;
    HumanRCD.Data.wHomeY := OHumanRCD.Data.wHomeY;
    HumanRCD.Data.sDearName := OHumanRCD.Data.sDearName;
    HumanRCD.Data.sMasterName := OHumanRCD.Data.sMasterName;
    HumanRCD.Data.boMaster := OHumanRCD.Data.boMaster;
    HumanRCD.Data.btCreditPoint := OHumanRCD.Data.btCreditPoint;
    HumanRCD.Data.btDivorce := OHumanRCD.Data.btDivorce;
    HumanRCD.Data.btMarryCount := OHumanRCD.Data.btMarryCount;
    HumanRCD.Data.sStoragePwd := OHumanRCD.Data.sStoragePwd;
    HumanRCD.Data.btReLevel := OHumanRCD.Data.btReLevel;
    HumanRCD.Data.boOnHorse := OHumanRCD.Data.boOnHorse;
    HumanRCD.Data.BonusAbil := OHumanRCD.Data.BonusAbil;
    HumanRCD.Data.nBonusPoint := OHumanRCD.Data.nBonusPoint;
    HumanRCD.Data.nGameGold := OHumanRCD.Data.nGameGold;
    HumanRCD.Data.nGamePoint := OHumanRCD.Data.nGamePoint;
    HumanRCD.Data.nGameDiamond := 0; //金刚石
    HumanRCD.Data.nGameGird := 0; //灵符
    HumanRCD.Data.nGameGlory := 0; //荣誉
    HumanRCD.Data.nPayMentPoint := OHumanRCD.Data.nPayMentPoint;
    HumanRCD.Data.nPKPOINT := OHumanRCD.Data.nPKPOINT;
    HumanRCD.Data.btAllowGroup := OHumanRCD.Data.btAllowGroup;
    HumanRCD.Data.btF9 := OHumanRCD.Data.btF9;
    HumanRCD.Data.btAttatckMode := OHumanRCD.Data.btAttatckMode;
    HumanRCD.Data.btIncHealth := OHumanRCD.Data.btIncHealth;
    HumanRCD.Data.btIncSpell := OHumanRCD.Data.btIncSpell;
    HumanRCD.Data.btIncHealing := OHumanRCD.Data.btIncHealing;
    HumanRCD.Data.btFightZoneDieCount := OHumanRCD.Data.btFightZoneDieCount;
    HumanRCD.Data.sAccount := OHumanRCD.Data.sAccount;
    HumanRCD.Data.btEE := OHumanRCD.Data.btEE;
    HumanRCD.Data.btEF := OHumanRCD.Data.btEF;
    HumanRCD.Data.boLockLogon := OHumanRCD.Data.boLockLogon;
    HumanRCD.Data.wContribution := OHumanRCD.Data.wContribution;
    HumanRCD.Data.nHungerStatus := OHumanRCD.Data.nHungerStatus;
    HumanRCD.Data.boAllowGuildReCall := OHumanRCD.Data.boAllowGuildReCall; //  是否允许行会合一
    HumanRCD.Data.wGroupRcallTime := OHumanRCD.Data.wGroupRcallTime; //队传送时间
    HumanRCD.Data.dBodyLuck := OHumanRCD.Data.dBodyLuck; //幸运度  8
    HumanRCD.Data.boAllowGroupReCall := OHumanRCD.Data.boAllowGroupReCall; // 是否允许天地合一
    HumanRCD.Data.nEXPRATE := OHumanRCD.Data.nEXPRATE; //经验倍数
    HumanRCD.Data.nExpTime := OHumanRCD.Data.nExpTime; //经验倍数时间
    HumanRCD.Data.btLastOutStatus := OHumanRCD.Data.btLastOutStatus; //2006-01-12增加 退出状态 1为死亡退出
    HumanRCD.Data.wMasterCount := OHumanRCD.Data.wMasterCount; //出师徒弟数
    HumanRCD.Data.boHasHero := OHumanRCD.Data.boHasHero; //是否有英雄
    HumanRCD.Data.boIsHero := OHumanRCD.Data.boIsHero; //是否是英雄
    HumanRCD.Data.btStatus := OHumanRCD.Data.btStatus; //状态
    HumanRCD.Data.sHeroChrName := OHumanRCD.Data.sHeroChrName;
    HumanRCD.Data.nGrudge := OHumanRCD.Data.nGrudge;
    HumanRCD.Data.QuestFlag := OHumanRCD.Data.QuestFlag; //脚本变量
    FillChar(HumanRCD.Data.AddByte, SizeOf(TAddByte), 0);

    OHumItems := @OHumanRCD.Data.HumItems;
    HumItems := @HumanRCD.Data.HumItems;
    FillChar(HumItems^, SizeOf(THumItems), 0);
    for II := Low(TOHumItems) to High(TOHumItems) do begin
      if OHumItems[II].wIndex > 0 then begin
        HumItems[II].MakeIndex := OHumItems[II].MakeIndex;
        HumItems[II].wIndex := OHumItems[II].wIndex; //物品id
        HumItems[II].Dura := OHumItems[II].Dura; //当前持久值
        HumItems[II].DuraMax := OHumItems[II].DuraMax; //最大持久值
        HumItems[II].btValue := OHumItems[II].btValue; //array[0..13] of Byte;

        HumItems[II].AddValue := OHumItems[II].AddValue;
        HumItems[II].AddPoint := OHumItems[II].AddPoint;
        //HumItems[II].btValue2 := OHumItems[II].btValue2;
        HumItems[II].MaxDate := OHumItems[II].MaxDate;
      end;
    end;

    OBagItems := @OHumanRCD.Data.BagItems;
    BagItems := @HumanRCD.Data.BagItems;
    FillChar(BagItems^, SizeOf(TBagItems), 0);
    for II := Low(TOBagItems) to High(TOBagItems) do begin
      if OBagItems[II].wIndex > 0 then begin
        BagItems[II].MakeIndex := OBagItems[II].MakeIndex;
        BagItems[II].wIndex := OBagItems[II].wIndex; //物品id
        BagItems[II].Dura := OBagItems[II].Dura; //当前持久值
        BagItems[II].DuraMax := OBagItems[II].DuraMax; //最大持久值
        BagItems[II].btValue := OBagItems[II].btValue; //array[0..13] of Byte;

        BagItems[II].AddValue := OBagItems[II].AddValue;
        BagItems[II].AddPoint := OBagItems[II].AddPoint;
        //BagItems[II].btValue2 := OBagItems[II].btValue2;
        BagItems[II].MaxDate := OBagItems[II].MaxDate;
      end;
    end;

    OStorageItems := @OHumanRCD.Data.StorageItems;
    StorageItems := @HumanRCD.Data.StorageItems;
    FillChar(StorageItems^, SizeOf(TStorageItems), 0);
    for II := Low(TOStorageItems) to High(TOStorageItems) do begin
      if OStorageItems[II].wIndex > 0 then begin
        StorageItems[II].MakeIndex := OStorageItems[II].MakeIndex;
        StorageItems[II].wIndex := OStorageItems[II].wIndex; //物品id
        StorageItems[II].Dura := OStorageItems[II].Dura; //当前持久值
        StorageItems[II].DuraMax := OStorageItems[II].DuraMax; //最大持久值
        StorageItems[II].btValue := OStorageItems[II].btValue; //array[0..13] of Byte;

        StorageItems[II].AddValue := OStorageItems[II].AddValue;
        StorageItems[II].AddPoint := OStorageItems[II].AddPoint;
        //StorageItems[II].btValue2 := OStorageItems[II].btValue2;
        StorageItems[II].MaxDate := OStorageItems[II].MaxDate;
      end;
    end;

    OHumAddItems := @OHumanRCD.Data.HumAddItems;
    HumAddItems := @HumanRCD.Data.HumAddItems;
    FillChar(HumAddItems^, SizeOf(THumAddItems), 0);
    for II := Low(TOHumAddItems) to High(TOHumAddItems) do begin
      if OHumAddItems[II].wIndex > 0 then begin
        HumAddItems[II].MakeIndex := OHumAddItems[II].MakeIndex;
        HumAddItems[II].wIndex := OHumAddItems[II].wIndex; //物品id
        HumAddItems[II].Dura := OHumAddItems[II].Dura; //当前持久值
        HumAddItems[II].DuraMax := OHumAddItems[II].DuraMax; //最大持久值
        HumAddItems[II].btValue := OHumAddItems[II].btValue; //array[0..13] of Byte;

        HumAddItems[II].AddValue := OHumAddItems[II].AddValue;
        HumAddItems[II].AddPoint := OHumAddItems[II].AddPoint;
        //HumAddItems[II].btValue2 := OHumAddItems[II].btValue2;
        HumAddItems[II].MaxDate := OHumAddItems[II].MaxDate;
      end;
    end;

    OHumMagics := @OHumanRCD.Data.HumMagics;
    HumMagics := @HumanRCD.Data.HumMagics;
    FillChar(HumMagics^, SizeOf(THumMagics), 0);
    for II := Low(TOHumMagics) to High(TOHumMagics) do begin
      HumMagics[II] := OHumMagics[II];
    end;

    m_NewMirCharNameList.AddObject(m_MirCharNameList.Strings[I], TObject(HumanRCD));

    ProcessStatus();
  end;
end;

procedure TFileDB.SaveToFile(sFileName: string);
var
  I: Integer;
  HumanRCD: pTHumDataInfo;
  sOldDBFileName: string;
begin
  if not m_boConvert then Exit;
  //m_NewMirCharNameList.SaveToFile('NewMir.txt');
  ProcessMessage(Format(sSaveToFile, [g_sFileNames[2]]));
  sOldDBFileName := m_sDBFileName;
  try
    m_sDBFileName := sFileName;

    m_nPercent := 0;
    m_nCount := 0;
    if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
    try
      if Open then begin
        m_nCount := m_NewMirCharNameList.Count;
        m_Header.nHumCount := m_NewMirCharNameList.Count;
        FileSeek(m_nFileHandle, 0, 0);
        FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
        for I := 0 to m_NewMirCharNameList.Count - 1 do begin
          if g_boClose then Break;
          HumanRCD := pTHumDataInfo(m_NewMirCharNameList.Objects[I]);
          FileWrite(m_nFileHandle, HumanRCD^, SizeOf(THumDataInfo));
          if Application.Terminated then begin
            Close;
            Exit;
          end;
          ProcessStatus();
        end;
      end;
    finally
      Close();
    end;

  finally
    m_sDBFileName := sOldDBFileName;
  end;
end;

{TFileHumDB}

constructor TFileHumDB.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_QuickList := TQuickList.Create;
  m_NewQuickList := TQuickList.Create;
end;

destructor TFileHumDB.Destroy;
begin
  UnLoad();
  m_QuickList.Free;
  m_NewQuickList.Free;
  inherited;
end;

procedure TFileHumDB.UnLoad();
var
  I: Integer;
begin
  for I := 0 to m_QuickList.Count - 1 do begin
    Dispose(pTOHumInfo(m_QuickList.Objects[I]));
  end;
  m_QuickList.Clear;

  for I := 0 to m_NewQuickList.Count - 1 do begin
    Dispose(pTHumInfo(m_NewQuickList.Objects[I]));
  end;
  m_NewQuickList.Clear;
end;

procedure TFileHumDB.Load();
var
  nIndex, nIdx: Integer;
  DBHeader: TDBHeader;
  PHumanRCD: pTOHumInfo;
  HumanRCD: TOHumInfo;
begin
  m_nCount := 0;
  m_nPercent := 0;
  if not m_boConvert then Exit;
  ProcessMessage(Format(sLondData, [g_sFileNames[1]]));
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then begin
        m_nCount := DBHeader.nHumCount;
        for nIndex := 0 to DBHeader.nHumCount - 1 do begin
          if g_boClose then Break;
          ProcessStatus();

          FillChar(HumanRCD, SizeOf(TOHumInfo), #0);

          if FileSeek(m_nFileHandle, nIndex * SizeOf(TOHumInfo) + SizeOf(TDBHeader), 0) = -1 then begin
            Break;
          end;

          if FileRead(m_nFileHandle, HumanRCD, SizeOf(TOHumInfo)) <> SizeOf(TOHumInfo) then begin
            Break;
          end;

          if (HumanRCD.Header.sName = '') or HumanRCD.Header.boDeleted then begin
              //DeleteList.Add('Account:' + HumanRCD.Data.sAccount + ' Name:' + HumanRCD.Header.sName + ' ChrName:' + HumanRCD.Data.sChrName);
            Continue;
          end;
            //DeleteList.Add('Account:' + HumanRCD.Data.sAccount + ' Name:' + HumanRCD.Header.sName + ' ChrName:' + HumanRCD.Data.sChrName);
          New(PHumanRCD);
          PHumanRCD^ := HumanRCD;
          m_QuickList.AddObject(PHumanRCD.sChrName, TObject(PHumanRCD));

          Application.ProcessMessages;
          if Application.Terminated then begin
            Close;
            Exit;
          end;
        end;
      end;
    end;
  finally
    Close();
  end;
  ProcessMessage('正在排序，请稍候...');
  m_QuickList.SortString(0, m_QuickList.Count - 1);
  //DeleteList.SaveToFile('Mir.txt');
  //DeleteList.Free;
  //m_QuickList.SaveToFile('Mir.txt');
end;

function TFileHumDB.Open: Boolean;
begin
  if FileExists(m_sDBFileName) then begin
    m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then
      FileRead(m_nFileHandle, m_Header, SizeOf(TDBHeader));
  end else begin
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      m_Header.sDesc := sDBHeaderDesc;
      m_Header.nHumCount := 0;
      m_Header.n6C := 0;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
    end;
  end;
  if m_nFileHandle > 0 then Result := True
  else Result := False;
end;

procedure TFileHumDB.Close;
begin
  FileClose(m_nFileHandle);
end;

function TFileHumDB.OpenEx: Boolean;
var
  DBHeader: TDBHeader;
begin
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := True;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then
      m_Header := DBHeader;
  end else Result := False;
end;

procedure TFileHumDB.Convert();
var
  I: Integer;
  HumInfo: pTHumInfo;
  OHumInfo: pTOHumInfo;
begin
  if not m_boConvert then Exit;
  ProcessMessage(Format(sConvertData, [g_sFileNames[1]]));

  m_nPercent := 0;
  m_nCount := m_QuickList.Count;

  for I := 0 to m_QuickList.Count - 1 do begin

    OHumInfo := pTOHumInfo(m_QuickList.Objects[I]);
    New(HumInfo);
    FillChar(HumInfo^, SizeOf(THumInfo), #0);
    HumInfo.Header := OHumInfo.Header;
    HumInfo.sChrName := OHumInfo.sChrName;
    HumInfo.sAccount := OHumInfo.sAccount;
    HumInfo.boDeleted := OHumInfo.boDeleted;
    HumInfo.boIsHero := OHumInfo.boIsHero;
    HumInfo.dModDate := OHumInfo.dModDate;
    HumInfo.btCount := OHumInfo.btCount; //操作计次
    HumInfo.boSelected := OHumInfo.boSelected; //是否选择
    Move(OHumInfo.n6, HumInfo.n6, SizeOf(HumInfo.n6));

    m_NewQuickList.AddObject(m_QuickList.Strings[I], TObject(HumInfo));

    ProcessStatus();
  end;
end;

procedure TFileHumDB.SaveToFile(sFileName: string);
var
  I: Integer;
  HumInfo: pTHumInfo;
  sOldDBFileName: string;
begin
  if not m_boConvert then Exit;

  ProcessMessage(Format(sSaveToFile, [g_sFileNames[1]]));
  sOldDBFileName := m_sDBFileName;
  try
    m_sDBFileName := sFileName;

    m_nPercent := 0;
    m_nCount := 0;
    if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
    try
      if Open then begin
        m_nCount := m_NewQuickList.Count;
        m_Header.nHumCount := m_NewQuickList.Count;
        FileSeek(m_nFileHandle, 0, 0);
        FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
        for I := 0 to m_NewQuickList.Count - 1 do begin
          if g_boClose then Break;
          HumInfo := pTHumInfo(m_NewQuickList.Objects[I]);
          FileWrite(m_nFileHandle, HumInfo^, SizeOf(THumInfo));
          if Application.Terminated then begin
            Close;
            Exit;
          end;
          ProcessStatus();
        end;
      end;
    finally
      Close();
    end;

  finally
    m_sDBFileName := sOldDBFileName;
  end;
end;

{ TSellOff }

constructor TSellOff.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_SellOffList := TQuickIDList.Create;
  m_NewSellOffList := TQuickIDList.Create;
  m_boGold := False;
end;

destructor TSellOff.Destroy;
begin
  UnLoad();
  m_SellOffList.Free;
  m_NewSellOffList.Free;
  inherited;
end;

procedure TSellOff.UnLoad();
var
  I, II: Integer;
  ChrList: TList;
begin
  for I := 0 to m_SellOffList.Count - 1 do begin
    ChrList := TList(m_SellOffList.Objects[I]);
    for II := 0 to ChrList.Count - 1 do begin
      Dispose(pTOSellOffInfo(ChrList.Items[II]));
    end;
    ChrList.Free;
  end;
  m_SellOffList.Clear;

  for I := 0 to m_NewSellOffList.Count - 1 do begin
    ChrList := TList(m_NewSellOffList.Objects[I]);
    for II := 0 to ChrList.Count - 1 do begin
      Dispose(pTSellOffInfo(ChrList.Items[II]));
    end;
    ChrList.Free;
  end;
  m_NewSellOffList.Clear;
end;

procedure TSellOff.Load();
var
  nIndex: Integer;
  DBHeader: TItemCount;
  DBRecord: TOSellOffInfo;
  PDBRecord: pTOSellOffInfo;

begin
  m_nPercent := 0;
  if not m_boConvert then Exit;
  if m_boGold then begin
    ProcessMessage(Format(sLondData, [g_sFileNames[5]]));
  end else begin
    ProcessMessage(Format(sLondData, [g_sFileNames[4]]));
  end;
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        m_nCount := DBHeader;
        for nIndex := 0 to DBHeader - 1 do begin
          if g_boClose then Break;
          ProcessStatus();

          if FileSeek(m_nFileHandle, nIndex * SizeOf(TOSellOffInfo) + SizeOf(TItemCount), 0) = -1 then begin
            Break;
          end;
          if FileRead(m_nFileHandle, DBRecord, SizeOf(TOSellOffInfo)) <> SizeOf(TOSellOffInfo) then begin
            //Dispose(DBRecord);
            Break;
          end;
          New(PDBRecord);
          PDBRecord^ := DBRecord;
          m_SellOffList.AddRecord(PDBRecord.sCharName, TObject(PDBRecord));
        end;

        Application.ProcessMessages;
        if Application.Terminated then begin
          Close;
          Exit;
        end;
      end;
    end;
  finally
    Close();
  end;
  ProcessMessage('正在排序，请稍候...');
  m_SellOffList.SortString(0, m_SellOffList.Count - 1);
end;

procedure TSellOff.Close;
begin
  FileClose(m_nFileHandle);
end;

function TSellOff.Open: Boolean;
begin
  if FileExists(m_sDBFileName) then begin
    m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then
      FileRead(m_nFileHandle, m_Header, SizeOf(TItemCount));
  end else begin
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      m_Header := 0;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
    end;
  end;
  if m_nFileHandle > 0 then Result := True
  else Result := False;
end;

function TSellOff.OpenEx: Boolean;
var
  DBHeader: TItemCount;
begin
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := True;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then
      m_Header := DBHeader;
  end else Result := False;
end;

procedure TSellOff.Convert();
var
  ODBRecord: pTOSellOffInfo;

  DBRecord: pTSellOffInfo;
  OUserItem: TOUserItem;

  UserItem: TUserItem;
  List: TList;
  NewList: TList;
  I, II: Integer;
begin
  if not m_boConvert then Exit;
  if m_boGold then begin
    ProcessMessage(Format(sConvertData, [g_sFileNames[5]]));
  end else begin
    ProcessMessage(Format(sConvertData, [g_sFileNames[4]]));
  end;
  m_nPercent := 0;
  m_nCount := m_SellOffList.Count;
  for I := 0 to m_SellOffList.Count - 1 do begin
    List := TList(m_SellOffList.Objects[I]);
    if List.Count > 0 then begin
      NewList := TList.Create;
      m_NewSellOffList.AddObject(m_SellOffList.Strings[I], NewList);
      for II := 0 to List.Count - 1 do begin
        ODBRecord := pTOSellOffInfo(List.Items[II]);
        New(DBRecord);
        DBRecord.sCharName := ODBRecord.sCharName;
        DBRecord.dSellDateTime := ODBRecord.dSellDateTime;
        DBRecord.nSellGold := ODBRecord.nSellGold;
        DBRecord.n := ODBRecord.n;

        FillChar(DBRecord.UserItem, SizeOf(TUserItem), 0);

        DBRecord.UserItem.MakeIndex := ODBRecord.UserItem.MakeIndex;
        DBRecord.UserItem.wIndex := ODBRecord.UserItem.wIndex; //物品id
        DBRecord.UserItem.Dura := ODBRecord.UserItem.Dura; //当前持久值
        DBRecord.UserItem.DuraMax := ODBRecord.UserItem.DuraMax; //最大持久值
        DBRecord.UserItem.btValue := ODBRecord.UserItem.btValue; //array[0..13] of Byte;

        DBRecord.UserItem.AddValue := ODBRecord.UserItem.AddValue;
        DBRecord.UserItem.AddPoint := ODBRecord.UserItem.AddPoint;
        //DBRecord.UserItem.btValue2 := ODBRecord.UserItem.btValue2;
        DBRecord.UserItem.MaxDate := ODBRecord.UserItem.MaxDate;


        DBRecord.nIndex := ODBRecord.nIndex;
        NewList.Add(DBRecord);
      end;
    end;
    ProcessStatus();
  end;
end;

procedure TSellOff.SaveToFile(sFileName: string);
var
  DBRecord: pTSellOffInfo;
  List: TList;
  I, II: Integer;
  sOldDBFileName: string;
begin
  if not m_boConvert then Exit;
  if m_boGold then begin
    ProcessMessage(Format(sSaveToFile, [g_sFileNames[5]]));
  end else begin
    ProcessMessage(Format(sSaveToFile, [g_sFileNames[4]]));
  end;
  sOldDBFileName := m_sDBFileName;
  try
    m_sDBFileName := sFileName;
    m_nCount := 0;
    m_nPercent := 0;
    if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
    try
      if Open then begin
        m_nCount := m_NewSellOffList.Count;
        m_Header := 0;
        for I := 0 to m_NewSellOffList.Count - 1 do begin
          List := TList(m_NewSellOffList.Objects[I]);
          Inc(m_Header, List.Count);
        end;
        FileSeek(m_nFileHandle, 0, 0);
        FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
        for I := 0 to m_NewSellOffList.Count - 1 do begin
          if g_boClose then Break;
          List := TList(m_NewSellOffList.Objects[I]);
          for II := 0 to List.Count - 1 do begin
            DBRecord := pTSellOffInfo(List.Items[II]);
            FileWrite(m_nFileHandle, DBRecord^, SizeOf(TSellOffInfo));
            if Application.Terminated then begin
              Close;
              Exit;
            end;
          end;
          ProcessStatus();
        end;
      end;
    finally
      Close();
    end;
  finally
    m_sDBFileName := sOldDBFileName;
  end;
end;

{ TStorage }

constructor TStorage.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_BigStorageList := TQuickIDList.Create;
  m_NewBigStorageList := TQuickIDList.Create;
end;

destructor TStorage.Destroy;
begin
  UnLoad();
  m_BigStorageList.Free;
  m_NewBigStorageList.Free;
  inherited;
end;

procedure TStorage.UnLoad();
var
  I, II: Integer;
  ChrList: TList;
begin
  for I := 0 to m_BigStorageList.Count - 1 do begin
    ChrList := TList(m_BigStorageList.Objects[I]);
    for II := 0 to ChrList.Count - 1 do begin
      Dispose(pTOBigStorage(ChrList.Items[II]));
    end;
    ChrList.Free;
  end;
  m_BigStorageList.Clear;

  for I := 0 to m_NewBigStorageList.Count - 1 do begin
    ChrList := TList(m_NewBigStorageList.Objects[I]);
    for II := 0 to ChrList.Count - 1 do begin
      Dispose(pTBigStorage(ChrList.Items[II]));
    end;
    ChrList.Free;
  end;
  m_NewBigStorageList.Clear;
end;

procedure TStorage.Load();
var
  nIndex: Integer;
  DBHeader: TItemCount;
  DBRecord: TOBigStorage;
  PDBRecord: pTOBigStorage;

begin
  if not m_boConvert then Exit;
  ProcessMessage(Format(sLondData, [g_sFileNames[3]]));
  m_nCount := 0;
  m_nPercent := 0;
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        m_nCount := DBHeader;
        for nIndex := 0 to DBHeader - 1 do begin
          if g_boClose then Break;
          ProcessStatus();

          if FileSeek(m_nFileHandle, nIndex * SizeOf(TOBigStorage) + SizeOf(TItemCount), 0) = -1 then begin
            Break;
          end;
          if FileRead(m_nFileHandle, DBRecord, SizeOf(TOBigStorage)) <> SizeOf(TOBigStorage) then begin
            Break;
          end;
          New(PDBRecord);
          PDBRecord^ := DBRecord;
          m_BigStorageList.AddRecord(PDBRecord.sCharName, TObject(PDBRecord));

          Application.ProcessMessages;
          if Application.Terminated then begin
            Close;
            Exit;
          end;
        end;
      end;
    end;
  finally
    Close();
  end;
  ProcessMessage('正在排序，请稍候...');
  m_BigStorageList.SortString(0, m_BigStorageList.Count - 1);
end;

procedure TStorage.Close;
begin
  FileClose(m_nFileHandle);
end;

function TStorage.Open: Boolean;
begin
  if FileExists(m_sDBFileName) then begin
    m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then
      FileRead(m_nFileHandle, m_Header, SizeOf(TItemCount));
  end else begin
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      m_Header := 0;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
    end;
  end;
  if m_nFileHandle > 0 then Result := True
  else Result := False;
end;

function TStorage.OpenEx: Boolean;
var
  DBHeader: TItemCount;
begin
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := True;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then
      m_Header := DBHeader;
  end else Result := False;
end;

procedure TStorage.Convert();
var
  ODBRecord: pTOBigStorage;

  DBRecord: pTBigStorage;
  OUserItem: TOUserItem;

  UserItem: TUserItem;
  List: TList;
  NewList: TList;
  I, II: Integer;
begin
  if not m_boConvert then Exit;
  ProcessMessage(Format(sConvertData, [g_sFileNames[3]]));
  m_nPercent := 0;
  m_nCount := m_BigStorageList.Count;
  for I := 0 to m_BigStorageList.Count - 1 do begin
    List := TList(m_BigStorageList.Objects[I]);
    if List.Count > 0 then begin
      NewList := TList.Create;
      m_NewBigStorageList.AddObject(m_BigStorageList.Strings[I], NewList);
      for II := 0 to List.Count - 1 do begin

        ODBRecord := pTOBigStorage(List.Items[II]);
        New(DBRecord);
        DBRecord.boDelete := ODBRecord.boDelete;
        DBRecord.sCharName := ODBRecord.sCharName;
        DBRecord.SaveDateTime := ODBRecord.SaveDateTime;


        FillChar(DBRecord.UserItem, SizeOf(TUserItem), 0);

        DBRecord.UserItem.MakeIndex := ODBRecord.UserItem.MakeIndex;
        DBRecord.UserItem.wIndex := ODBRecord.UserItem.wIndex; //物品id
        DBRecord.UserItem.Dura := ODBRecord.UserItem.Dura; //当前持久值
        DBRecord.UserItem.DuraMax := ODBRecord.UserItem.DuraMax; //最大持久值
        DBRecord.UserItem.btValue := ODBRecord.UserItem.btValue; //array[0..13] of Byte;

        DBRecord.UserItem.AddValue := ODBRecord.UserItem.AddValue;
        DBRecord.UserItem.AddPoint := ODBRecord.UserItem.AddPoint;
        //DBRecord.UserItem.btValue2 := ODBRecord.UserItem.btValue2;
        DBRecord.UserItem.MaxDate := ODBRecord.UserItem.MaxDate;



        DBRecord.nIndex := ODBRecord.nIndex;
        NewList.Add(DBRecord);
      end;
    end;
    ProcessStatus();
  end;
end;

procedure TStorage.SaveToFile(sFileName: string);
var
  DBRecord: pTBigStorage;
  List: TList;
  I, II: Integer;
  sOldDBFileName: string;
begin
  if not m_boConvert then Exit;
  ProcessMessage(Format(sSaveToFile, [g_sFileNames[3]]));
  sOldDBFileName := m_sDBFileName;
  try
    m_sDBFileName := sFileName;
    m_nCount := 0;
    m_nPercent := 0;
    if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
    try
      if Open then begin
        m_nCount := m_NewBigStorageList.Count;
        m_Header := 0;
        for I := 0 to m_NewBigStorageList.Count - 1 do begin
          List := TList(m_NewBigStorageList.Objects[I]);
          Inc(m_Header, List.Count);
        end;
        FileSeek(m_nFileHandle, 0, 0);
        FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
        for I := 0 to m_NewBigStorageList.Count - 1 do begin
          if g_boClose then Break;
          List := TList(m_NewBigStorageList.Objects[I]);
          for II := 0 to List.Count - 1 do begin
            DBRecord := pTBigStorage(List.Items[II]);
            FileWrite(m_nFileHandle, DBRecord^, SizeOf(TBigStorage));
            if Application.Terminated then begin
              Close;
              Exit;
            end;
          end;
          ProcessStatus();
        end;
      end;
    finally
      Close();
    end;
  finally
    m_sDBFileName := sOldDBFileName;
  end;
end;


{TDuelItem}

constructor TFileDuelItem.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_QuickList := TQuickList.Create;
  m_NewQuickList := TQuickList.Create;
end;

destructor TFileDuelItem.Destroy;
begin
  UnLoad();
  m_QuickList.Free;
  m_NewQuickList.Free;
  inherited;
end;

procedure TFileDuelItem.UnLoad();
var
  I: Integer;
begin
  for I := 0 to m_QuickList.Count - 1 do begin
    Dispose(pTODuelItem(m_QuickList.Objects[I]));
  end;
  m_QuickList.Clear;

  for I := 0 to m_NewQuickList.Count - 1 do begin
    Dispose(pTDuelItem(m_NewQuickList.Objects[I]));
  end;
  m_NewQuickList.Clear;
end;

procedure TFileDuelItem.Load();
var
  nIndex, nIdx: Integer;
  DBHeader: TItemCount;
  DuelItem: pTODuelItem;
  DBRecord: TODuelItem;
begin
  m_nCount := 0;
  m_nPercent := 0;
  if not m_boConvert then Exit;
  ProcessMessage(Format(sLondData, [g_sFileNames[6]]));

  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        m_nCount := DBHeader;
        for nIndex := 0 to DBHeader - 1 do begin
          if g_boClose then Break;
          ProcessStatus();

          FillChar(DBRecord, SizeOf(TODuelItem) - SizeOf(Integer), #0);
          if FileRead(m_nFileHandle, DBRecord, SizeOf(TODuelItem) - SizeOf(Integer)) <> (SizeOf(TODuelItem) - SizeOf(Integer)) then begin
            Break;
          end;
          
          if (not DBRecord.boDelete) then begin
            DBRecord.nIndex := nIndex;
            New(DuelItem);
            DuelItem^ := DBRecord;
            m_QuickList.AddObject(DuelItem.sOwnerName, TObject(DuelItem));
          end;

          Application.ProcessMessages;
          if Application.Terminated then begin
            Close;
            Exit;
          end;
        end;
      end;
    end;
  finally
    Close();
  end;
  ProcessMessage('正在排序，请稍候...');
  m_QuickList.SortString(0, m_QuickList.Count - 1);
end;

function TFileDuelItem.Open: Boolean;
begin
  if FileExists(m_sDBFileName) then begin
    m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then
      FileRead(m_nFileHandle, m_Header, SizeOf(TItemCount));
  end else begin
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      m_Header := 0;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
    end;
  end;
  if m_nFileHandle > 0 then Result := True
  else Result := False;
end;

procedure TFileDuelItem.Close;
begin
  FileClose(m_nFileHandle);
end;

function TFileDuelItem.OpenEx: Boolean;
var
  DBHeader: TItemCount;
begin
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := True;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then
      m_Header := DBHeader;
  end else Result := False;
end;

procedure TFileDuelItem.Convert();
var
  I: Integer;
  DuelItem: pTDuelItem;
  ODuelItem: pTODuelItem;
begin
  if not m_boConvert then Exit;

  ProcessMessage(Format(sConvertData, [g_sFileNames[6]]));

  m_nPercent := 0;
  m_nCount := m_QuickList.Count;

  for I := 0 to m_QuickList.Count - 1 do begin

    ODuelItem := pTODuelItem(m_QuickList.Objects[I]);
    New(DuelItem);
    FillChar(DuelItem^, SizeOf(TDuelItem), #0);

    DuelItem.boFinish := ODuelItem.boFinish; //挑战完成
    DuelItem.boDelete := ODuelItem.boDelete;
    DuelItem.btDuel := ODuelItem.btDuel;
    DuelItem.sOwnerName := ODuelItem.sOwnerName;
    DuelItem.sDuelName := ODuelItem.sDuelName;

    FillChar(DuelItem.UserItem, SizeOf(TUserItem), 0);

    DuelItem.UserItem.MakeIndex := ODuelItem.UserItem.MakeIndex;
    DuelItem.UserItem.wIndex := ODuelItem.UserItem.wIndex; //物品id
    DuelItem.UserItem.Dura := ODuelItem.UserItem.Dura; //当前持久值
    DuelItem.UserItem.DuraMax := ODuelItem.UserItem.DuraMax; //最大持久值
    DuelItem.UserItem.btValue := ODuelItem.UserItem.btValue; //array[0..13] of Byte;

    DuelItem.UserItem.AddValue := ODuelItem.UserItem.AddValue;
    DuelItem.UserItem.AddPoint := ODuelItem.UserItem.AddPoint;
        //DuelItem.UserItem.btValue2 := ODuelItem.UserItem.btValue2;
    DuelItem.UserItem.MaxDate := ODuelItem.UserItem.MaxDate;

    DuelItem.n01 := ODuelItem.n01;
    DuelItem.n02 := ODuelItem.n02;
    DuelItem.nIndex := ODuelItem.nIndex;

    m_NewQuickList.AddObject(m_QuickList.Strings[I], TObject(DuelItem));

    ProcessStatus();
  end;
end;

procedure TFileDuelItem.SaveToFile(sFileName: string);
var
  I: Integer;
  DuelItem: pTDuelItem;
  sOldDBFileName: string;
begin
  if not m_boConvert then Exit;

  ProcessMessage(Format(sSaveToFile, [g_sFileNames[6]]));
  
  sOldDBFileName := m_sDBFileName;
  try
    m_sDBFileName := sFileName;

    m_nPercent := 0;
    m_nCount := 0;
    if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
    try
      if Open then begin
        m_nCount := m_NewQuickList.Count;
        m_Header := m_NewQuickList.Count;
        FileSeek(m_nFileHandle, 0, 0);
        FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
        for I := 0 to m_NewQuickList.Count - 1 do begin
          if g_boClose then Break;
          DuelItem := pTDuelItem(m_NewQuickList.Objects[I]);
          FileWrite(m_nFileHandle, DuelItem^, SizeOf(TDuelItem) - SizeOf(Integer));
          if Application.Terminated then begin
            Close;
            Exit;
          end;
          ProcessStatus();
        end;
      end;
    finally
      Close();
    end;

  finally
    m_sDBFileName := sOldDBFileName;
  end;
end;


end.

