unit HumDB;

interface
uses
  Windows, Classes, SysUtils, Forms, IniFiles, Share, Grobal2;
resourcestring
  sDBHeaderDesc = '飞尔世界数据库文件 2008/02/16';
  sDBIdxHeaderDesc = '飞尔世界数据库文件 2008/02/16';
const
  MAX_STATUS_ATTRIBUTE = 12;
  MAXPATHLEN = 255;
  DIRPATHLEN = 80;
  MapNameLen = 16;
  ActorNameLen = 14;
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

  TIdxHeader = packed record //Size 124
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

  THumInfo = packed record //Size 72
    Header: TRecordHeader;
    sChrName: string[14]; //0x14  //角色名称   44
    sAccount: string[10]; //账号
    boDeleted: Boolean; //是否删除
    boIsHero: Boolean;
    dModDate: TDateTime;
    btCount: Byte; //操作计次
    boSelected: Boolean; //是否选择
    n6: array[0..5] of Byte;
  end;
  pTHumInfo = ^THumInfo;

  TIdxRecord = record
    sChrName: string[15];
    nIndex: Integer;
  end;
  pTIdxRecord = ^TIdxRecord;

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
    if m_boOldHero then begin
      Dispose(pTOHeroHumDataInfo(m_MirCharNameList.Objects[I]));
    end else begin
      Dispose(pTOHumDataInfo(m_MirCharNameList.Objects[I]));
    end;
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

  OHeroPHumanRCD: pTOHeroHumDataInfo;
  OHeroHumanRCD: TOHeroHumDataInfo;
  //DeleteList: TStringList;
begin
  m_nCount := 0;
  m_nPercent := 0;
  if not m_boConvert then Exit;
  ProcessMessage(Format(sLondData, [g_sFileNames[0]]));
  //DeleteList := TStringList.Create;
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then begin
        m_nCount := DBHeader.nHumCount;
        for nIndex := 0 to DBHeader.nHumCount - 1 do begin
          if g_boClose then Break;
          ProcessStatus();

          if m_boOldHero then begin
            FillChar(OHeroHumanRCD, SizeOf(TOHeroHumDataInfo), #0);

            if FileSeek(m_nFileHandle, nIndex * SizeOf(TOHeroHumDataInfo) + SizeOf(TDBHeader), 0) = -1 then begin
              Break;
            end;

            if FileRead(m_nFileHandle, OHeroHumanRCD, SizeOf(TOHeroHumDataInfo)) <> SizeOf(TOHeroHumDataInfo) then begin
              Break;
            end;

            if (OHeroHumanRCD.Header.sName = '') or OHeroHumanRCD.Header.boDeleted then begin
              //DeleteList.Add('Account:' + OHeroHumanRCD.Data.sAccount + ' Name:' + OHeroHumanRCD.Header.sName + ' ChrName:' + OHeroHumanRCD.Data.sChrName);
              Continue;
            end;
            //DeleteList.Add('Account:' + HumanRCD.Data.sAccount + ' Name:' + HumanRCD.Header.sName + ' ChrName:' + HumanRCD.Data.sChrName);
            New(OHeroPHumanRCD);
            OHeroPHumanRCD^ := OHeroHumanRCD;
            m_MirCharNameList.AddObject(OHeroPHumanRCD.Data.sChrName, TObject(OHeroPHumanRCD));
          end else begin
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
  m_MirCharNameList.SortString(0, m_MirCharNameList.Count - 1);
  //DeleteList.SaveToFile('Mir.txt');
  //DeleteList.Free;
  //m_MirCharNameList.SaveToFile('Mir.txt');
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
  OHeroHumanRCD: pTOHeroHumDataInfo;

  HumItems: pTHumItems;
  BagItems: pTBagItems;
  StorageItems: pTStorageItems;
  HumAddItems: pTHumAddItems;
  HumMagics: pTHumMagics;

  OHumItems: pTOHumItems;
  OBagItems: pTOBagItems;
  OStorageItems: pTOStorageItems;
  OHumAddItems: pTOHumAddItems;

  OHeroHumItems: pTOHeroHumItems;
  OHeroBagItems: pTOHeroBagItems;
  OHeroStorageItems: pTOHeroStorageItems;
  OHeroHumAddItems: pTOHeroHumAddItems;
begin
  if not m_boConvert then Exit;
  ProcessMessage(Format(sConvertData, [g_sFileNames[0]]));

  m_nPercent := 0;
  m_nCount := m_MirCharNameList.Count;

  for I := 0 to m_MirCharNameList.Count - 1 do begin
    if m_boOldHero then begin
      OHeroHumanRCD := pTOHeroHumDataInfo(m_MirCharNameList.Objects[I]);
      New(HumanRCD);
      FillChar(HumanRCD^, SizeOf(THumDataInfo), #0);
      HumanRCD.Header := OHeroHumanRCD.Header;
      HumanRCD.Data.sChrName := OHeroHumanRCD.Data.sChrName;
      HumanRCD.Data.sCurMap := OHeroHumanRCD.Data.sCurMap;
      HumanRCD.Data.wCurX := OHeroHumanRCD.Data.wCurX;
      HumanRCD.Data.wCurY := OHeroHumanRCD.Data.wCurY;
      HumanRCD.Data.btDir := OHeroHumanRCD.Data.btDir;
      HumanRCD.Data.btHair := OHeroHumanRCD.Data.btHair;
      HumanRCD.Data.btSex := OHeroHumanRCD.Data.btSex;
      HumanRCD.Data.btJob := OHeroHumanRCD.Data.btJob;
      HumanRCD.Data.nGold := OHeroHumanRCD.Data.nGold;
      HumanRCD.Data.Abil := OHeroHumanRCD.Data.Abil;
      HumanRCD.Data.wStatusTimeArr := OHeroHumanRCD.Data.wStatusTimeArr;
      HumanRCD.Data.sHomeMap := OHeroHumanRCD.Data.sHomeMap;
      HumanRCD.Data.wHomeX := OHeroHumanRCD.Data.wHomeX;
      HumanRCD.Data.wHomeY := OHeroHumanRCD.Data.wHomeY;
      HumanRCD.Data.sDearName := OHeroHumanRCD.Data.sDearName;
      HumanRCD.Data.sMasterName := OHeroHumanRCD.Data.sMasterName;
      HumanRCD.Data.boMaster := OHeroHumanRCD.Data.boMaster;
      HumanRCD.Data.btCreditPoint := OHeroHumanRCD.Data.btCreditPoint;
      HumanRCD.Data.btDivorce := OHeroHumanRCD.Data.btDivorce;
      HumanRCD.Data.btMarryCount := OHeroHumanRCD.Data.btMarryCount;
      HumanRCD.Data.sStoragePwd := OHeroHumanRCD.Data.sStoragePwd;
      HumanRCD.Data.btReLevel := OHeroHumanRCD.Data.btReLevel;
      HumanRCD.Data.boOnHorse := OHeroHumanRCD.Data.boOnHorse;
      HumanRCD.Data.BonusAbil := OHeroHumanRCD.Data.BonusAbil;
      HumanRCD.Data.nBonusPoint := OHeroHumanRCD.Data.nBonusPoint;
      HumanRCD.Data.nGameGold := OHeroHumanRCD.Data.nGameGold;
      HumanRCD.Data.nGamePoint := OHeroHumanRCD.Data.nGamePoint;
      HumanRCD.Data.nPayMentPoint := OHeroHumanRCD.Data.nPayMentPoint;
      HumanRCD.Data.nPKPOINT := OHeroHumanRCD.Data.nPKPOINT;
      HumanRCD.Data.btAllowGroup := OHeroHumanRCD.Data.btAllowGroup;
      HumanRCD.Data.btF9 := OHeroHumanRCD.Data.btF9;
      HumanRCD.Data.btAttatckMode := OHeroHumanRCD.Data.btAttatckMode;
      HumanRCD.Data.btIncHealth := OHeroHumanRCD.Data.btIncHealth;
      HumanRCD.Data.btIncSpell := OHeroHumanRCD.Data.btIncSpell;
      HumanRCD.Data.btIncHealing := OHeroHumanRCD.Data.btIncHealing;
      HumanRCD.Data.btFightZoneDieCount := OHeroHumanRCD.Data.btFightZoneDieCount;
      HumanRCD.Data.sAccount := OHeroHumanRCD.Data.sAccount;
      HumanRCD.Data.btEE := OHeroHumanRCD.Data.btEE;
      HumanRCD.Data.btEF := OHeroHumanRCD.Data.btEF;
      HumanRCD.Data.boLockLogon := OHeroHumanRCD.Data.boLockLogon;
      HumanRCD.Data.wContribution := OHeroHumanRCD.Data.wContribution;
      HumanRCD.Data.nHungerStatus := OHeroHumanRCD.Data.nHungerStatus;
      HumanRCD.Data.boAllowGuildReCall := OHeroHumanRCD.Data.boAllowGuildReCall; //  是否允许行会合一
      HumanRCD.Data.wGroupRcallTime := OHeroHumanRCD.Data.wGroupRcallTime; //队传送时间
      HumanRCD.Data.dBodyLuck := OHeroHumanRCD.Data.dBodyLuck; //幸运度  8
      HumanRCD.Data.boAllowGroupReCall := OHeroHumanRCD.Data.boAllowGroupReCall; // 是否允许天地合一
      HumanRCD.Data.nEXPRATE := OHeroHumanRCD.Data.nEXPRATE; //经验倍数
      HumanRCD.Data.nExpTime := OHeroHumanRCD.Data.nExpTime; //经验倍数时间
      HumanRCD.Data.btLastOutStatus := OHeroHumanRCD.Data.btLastOutStatus; //2006-01-12增加 退出状态 1为死亡退出
      HumanRCD.Data.wMasterCount := OHeroHumanRCD.Data.wMasterCount; //出师徒弟数
      HumanRCD.Data.boHasHero := OHeroHumanRCD.Data.boHasHero; //是否有英雄
      HumanRCD.Data.boIsHero := OHeroHumanRCD.Data.boIsHero; //是否是英雄
      HumanRCD.Data.btStatus := OHeroHumanRCD.Data.btStatus; //状态
      HumanRCD.Data.sHeroChrName := OHeroHumanRCD.Data.sHeroChrName;
      HumanRCD.Data.nGrudge := OHeroHumanRCD.Data.nGrudge;
      HumanRCD.Data.QuestFlag := OHeroHumanRCD.Data.QuestFlag; //脚本变量
      FillChar(HumanRCD.Data.AddByte, SizeOf(TAddByte), 0);

      OHeroHumItems := @OHeroHumanRCD.Data.HumItems;
      HumItems := @HumanRCD.Data.HumItems;
      for II := Low(TOHeroHumItems) to High(TOHeroHumItems) do begin
        if OHeroHumItems[II].wIndex > 0 then begin
          HumItems[II].MakeIndex := OHeroHumItems[II].MakeIndex;
          HumItems[II].wIndex := OHeroHumItems[II].wIndex;
          HumItems[II].Dura := OHeroHumItems[II].Dura;
          HumItems[II].DuraMax := OHeroHumItems[II].DuraMax;
          HumItems[II].btValue := OHeroHumItems[II].btValue;
          HumItems[II].AddValue := OHeroHumItems[II].AddValue;
          HumItems[II].MaxDate := OHeroHumItems[II].MaxDate;
          FillChar(HumItems[II].AddPoint, SizeOf(TValue), 0);
        end;
      end;

      OHeroBagItems := @OHeroHumanRCD.Data.BagItems;
      BagItems := @HumanRCD.Data.BagItems;
      for II := Low(TOHeroBagItems) to High(TOHeroBagItems) do begin
        if OHeroBagItems[II].wIndex > 0 then begin
          BagItems[II].MakeIndex := OHeroBagItems[II].MakeIndex;
          BagItems[II].wIndex := OHeroBagItems[II].wIndex;
          BagItems[II].Dura := OHeroBagItems[II].Dura;
          BagItems[II].DuraMax := OHeroBagItems[II].DuraMax;
          BagItems[II].btValue := OHeroBagItems[II].btValue;
          BagItems[II].AddValue := OHeroBagItems[II].AddValue;
          BagItems[II].MaxDate := OHeroBagItems[II].MaxDate;
          FillChar(BagItems[II].AddPoint, SizeOf(TValue), 0);
        end;
      end;

      OHeroStorageItems := @OHeroHumanRCD.Data.StorageItems;
      StorageItems := @HumanRCD.Data.StorageItems;
      for II := Low(TOHeroStorageItems) to High(TOHeroStorageItems) do begin
        if OHeroStorageItems[II].wIndex > 0 then begin
          StorageItems[II].MakeIndex := OHeroStorageItems[II].MakeIndex;
          StorageItems[II].wIndex := OHeroStorageItems[II].wIndex;
          StorageItems[II].Dura := OHeroStorageItems[II].Dura;
          StorageItems[II].DuraMax := OHeroStorageItems[II].DuraMax;
          StorageItems[II].btValue := OHeroStorageItems[II].btValue;
          StorageItems[II].AddValue := OHeroStorageItems[II].AddValue;
          StorageItems[II].MaxDate := OHeroStorageItems[II].MaxDate;
          FillChar(StorageItems[II].AddPoint, SizeOf(TValue), 0);
        end;
      end;

      OHeroHumAddItems := @OHeroHumanRCD.Data.HumAddItems;
      HumAddItems := @HumanRCD.Data.HumAddItems;
      for II := Low(TOHeroHumAddItems) to High(TOHeroHumAddItems) do begin
        if OHeroHumAddItems[II].wIndex > 0 then begin
          HumAddItems[II].MakeIndex := OHeroHumAddItems[II].MakeIndex;
          HumAddItems[II].wIndex := OHeroHumAddItems[II].wIndex;
          HumAddItems[II].Dura := OHeroHumAddItems[II].Dura;
          HumAddItems[II].DuraMax := OHeroHumAddItems[II].DuraMax;
          HumAddItems[II].btValue := OHeroHumAddItems[II].btValue;
          HumAddItems[II].AddValue := OHeroHumAddItems[II].AddValue;
          HumAddItems[II].MaxDate := OHeroHumAddItems[II].MaxDate;
          FillChar(HumAddItems[II].AddPoint, SizeOf(TValue), 0);
        end;
      end;
      Move(OHeroHumanRCD^.Data.HumMagics, HumanRCD^.Data.HumMagics, SizeOf(THumMagics));
    end else begin
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
      for II := Low(TOHumItems) to High(TOHumItems) do begin
        FillChar(HumItems[II].AddValue, SizeOf(TValue), 0);
        FillChar(HumItems[II].AddPoint, SizeOf(TValue), 0);
        if OHumItems[II].wIndex > 0 then begin
          Move(OHumItems[II], HumItems[II], SizeOf(TOUserItem));
          HumItems[II].MaxDate := Now;
        end;
      end;

      OBagItems := @OHumanRCD.Data.BagItems;
      BagItems := @HumanRCD.Data.BagItems;
      for II := Low(TOBagItems) to High(TOBagItems) do begin
        FillChar(BagItems[II].AddValue, SizeOf(TValue), 0);
        FillChar(BagItems[II].AddPoint, SizeOf(TValue), 0);
        if OBagItems[II].wIndex > 0 then begin
          Move(OBagItems[II], BagItems[II], SizeOf(TOUserItem));
          BagItems[II].MaxDate := Now;
        end;
      end;

      OStorageItems := @OHumanRCD.Data.StorageItems;
      StorageItems := @HumanRCD.Data.StorageItems;
      for II := Low(TOStorageItems) to High(TOStorageItems) do begin
        FillChar(StorageItems[II].AddValue, SizeOf(TValue), 0);
        FillChar(StorageItems[II].AddPoint, SizeOf(TValue), 0);
        if OStorageItems[II].wIndex > 0 then begin
          Move(OStorageItems[II], StorageItems[II], SizeOf(TOUserItem));
          StorageItems[II].MaxDate := Now;
        end;
      end;

      OHumAddItems := @OHumanRCD.Data.HumAddItems;
      HumAddItems := @HumanRCD.Data.HumAddItems;
      for II := Low(TOHumAddItems) to High(TOHumAddItems) do begin
        FillChar(HumAddItems[II].AddValue, SizeOf(TValue), 0);
        FillChar(HumAddItems[II].AddPoint, SizeOf(TValue), 0);
        if OHumAddItems[II].wIndex > 0 then begin
          Move(OHumAddItems[II], HumAddItems[II], SizeOf(TOUserItem));
          HumAddItems[II].MaxDate := Now;
        end;
      end;
      Move(OHumanRCD^.Data.HumMagics, HumanRCD^.Data.HumMagics, SizeOf(THumMagics));
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
  ProcessMessage(Format(sSaveToFile, [g_sFileNames[0]]));
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
      if m_boOldHero then begin
        Dispose(pTOHeroSellOffInfo(ChrList.Items[II]));
      end else begin
        Dispose(pTOSellOffInfo(ChrList.Items[II]));
      end;
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

  OHeroDBRecord: TOHeroSellOffInfo;
  OHeroPDBRecord: pTOHeroSellOffInfo;
begin
  m_nPercent := 0;
  if not m_boConvert then Exit;
  if m_boGold then begin
    ProcessMessage(Format(sLondData, [g_sFileNames[3]]));
  end else begin
    ProcessMessage(Format(sLondData, [g_sFileNames[2]]));
  end;
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        m_nCount := DBHeader;
        for nIndex := 0 to DBHeader - 1 do begin
          if g_boClose then Break;
          ProcessStatus();
          if m_boOldHero then begin
            if FileSeek(m_nFileHandle, nIndex * SizeOf(TOHeroSellOffInfo) + SizeOf(TItemCount), 0) = -1 then begin
              Break;
            end;
            if FileRead(m_nFileHandle, OHeroDBRecord, SizeOf(TOHeroSellOffInfo)) <> SizeOf(TOHeroSellOffInfo) then begin
            //Dispose(DBRecord);
              Break;
            end;
            New(OHeroPDBRecord);
            OHeroPDBRecord^ := OHeroDBRecord;
            m_SellOffList.AddRecord(OHeroPDBRecord.sCharName, TObject(OHeroPDBRecord));
          end else begin
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
  OHeroDBRecord: pTOHeroSellOffInfo;
  DBRecord: pTSellOffInfo;
  OUserItem: TOUserItem;
  OHeroUserItem: TOHeroUserItem;
  UserItem: TUserItem;
  List: TList;
  NewList: TList;
  I, II: Integer;
begin
  if not m_boConvert then Exit;
  if m_boGold then begin
    ProcessMessage(Format(sConvertData, [g_sFileNames[3]]));
  end else begin
    ProcessMessage(Format(sConvertData, [g_sFileNames[2]]));
  end;
  m_nPercent := 0;
  m_nCount := m_SellOffList.Count;
  for I := 0 to m_SellOffList.Count - 1 do begin
    List := TList(m_SellOffList.Objects[I]);
    if List.Count > 0 then begin
      NewList := TList.Create;
      m_NewSellOffList.AddObject(m_SellOffList.Strings[I], NewList);
      for II := 0 to List.Count - 1 do begin
        if m_boOldHero then begin
          OHeroDBRecord := pTOHeroSellOffInfo(List.Items[II]);
          New(DBRecord);
          DBRecord.sCharName := OHeroDBRecord.sCharName;
          DBRecord.dSellDateTime := OHeroDBRecord.dSellDateTime;
          DBRecord.nSellGold := OHeroDBRecord.nSellGold;
          DBRecord.n := OHeroDBRecord.n;

          DBRecord.UseItems.MakeIndex := OHeroDBRecord.UseItems.MakeIndex;
          DBRecord.UseItems.wIndex := OHeroDBRecord.UseItems.wIndex;
          DBRecord.UseItems.Dura := OHeroDBRecord.UseItems.Dura;
          DBRecord.UseItems.DuraMax := OHeroDBRecord.UseItems.DuraMax;
          DBRecord.UseItems.btValue := OHeroDBRecord.UseItems.btValue;
          DBRecord.UseItems.AddValue := OHeroDBRecord.UseItems.AddValue;
          DBRecord.UseItems.MaxDate := OHeroDBRecord.UseItems.MaxDate;
          FillChar(DBRecord.UseItems.AddPoint, SizeOf(TValue), 0);

          DBRecord.nIndex := OHeroDBRecord.nIndex;
          NewList.Add(DBRecord);
        end else begin
          ODBRecord := pTOSellOffInfo(List.Items[II]);
          New(DBRecord);
          DBRecord.sCharName := ODBRecord.sCharName;
          DBRecord.dSellDateTime := ODBRecord.dSellDateTime;
          DBRecord.nSellGold := ODBRecord.nSellGold;
          DBRecord.n := ODBRecord.n;
          Move(ODBRecord.UseItems, DBRecord.UseItems, SizeOf(TOUserItem));
          FillChar(DBRecord.UseItems.AddValue, SizeOf(TValue), 0);
          FillChar(DBRecord.UseItems.AddPoint, SizeOf(TValue), 0);
          DBRecord.UseItems.MaxDate := Now;
          DBRecord.nIndex := ODBRecord.nIndex;
          NewList.Add(DBRecord);
        end;
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
    ProcessMessage(Format(sSaveToFile, [g_sFileNames[3]]));
  end else begin
    ProcessMessage(Format(sSaveToFile, [g_sFileNames[2]]));
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
      if m_boOldHero then begin
        Dispose(pTOHeroBigStorage(ChrList.Items[II]));
      end else begin
        Dispose(pTOBigStorage(ChrList.Items[II]));
      end;
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

  OHeroDBRecord: TOHeroBigStorage;
  OHeroPDBRecord: pTOHeroBigStorage;
begin
  if not m_boConvert then Exit;
  ProcessMessage(Format(sLondData, [g_sFileNames[1]]));
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
          if m_boOldHero then begin
            if FileSeek(m_nFileHandle, nIndex * SizeOf(TOHeroBigStorage) + SizeOf(TItemCount), 0) = -1 then begin
              Break;
            end;
            if FileRead(m_nFileHandle, OHeroDBRecord, SizeOf(TOHeroBigStorage)) <> SizeOf(TOHeroBigStorage) then begin
              Break;
            end;
            New(OHeroPDBRecord);
            OHeroPDBRecord^ := OHeroDBRecord;
            m_BigStorageList.AddRecord(OHeroPDBRecord.sCharName, TObject(OHeroPDBRecord));
          end else begin
            if FileSeek(m_nFileHandle, nIndex * SizeOf(TOBigStorage) + SizeOf(TItemCount), 0) = -1 then begin
              Break;
            end;
            if FileRead(m_nFileHandle, DBRecord, SizeOf(TOBigStorage)) <> SizeOf(TOBigStorage) then begin
              Break;
            end;
            New(PDBRecord);
            PDBRecord^ := DBRecord;
            m_BigStorageList.AddRecord(PDBRecord.sCharName, TObject(PDBRecord));
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
  OHeroDBRecord: pTOHeroBigStorage;
  DBRecord: pTBigStorage;
  OUserItem: TOUserItem;
  OHeroUserItem: TOHeroUserItem;
  UserItem: TUserItem;
  List: TList;
  NewList: TList;
  I, II: Integer;
begin
  if not m_boConvert then Exit;
  ProcessMessage(Format(sConvertData, [g_sFileNames[1]]));
  m_nPercent := 0;
  m_nCount := m_BigStorageList.Count;
  for I := 0 to m_BigStorageList.Count - 1 do begin
    List := TList(m_BigStorageList.Objects[I]);
    if List.Count > 0 then begin
      NewList := TList.Create;
      m_NewBigStorageList.AddObject(m_BigStorageList.Strings[I], NewList);
      for II := 0 to List.Count - 1 do begin
        if m_boOldHero then begin
          OHeroDBRecord := pTOHeroBigStorage(List.Items[II]);
          New(DBRecord);
          DBRecord.boDelete := OHeroDBRecord.boDelete;
          DBRecord.sCharName := OHeroDBRecord.sCharName;
          DBRecord.SaveDateTime := OHeroDBRecord.SaveDateTime;

          DBRecord.UseItems.MakeIndex := OHeroDBRecord.UseItems.MakeIndex;
          DBRecord.UseItems.wIndex := OHeroDBRecord.UseItems.wIndex;
          DBRecord.UseItems.Dura := OHeroDBRecord.UseItems.Dura;
          DBRecord.UseItems.DuraMax := OHeroDBRecord.UseItems.DuraMax;
          DBRecord.UseItems.btValue := OHeroDBRecord.UseItems.btValue;
          DBRecord.UseItems.AddValue := OHeroDBRecord.UseItems.AddValue;
          DBRecord.UseItems.MaxDate := OHeroDBRecord.UseItems.MaxDate;
          FillChar(DBRecord.UseItems.AddPoint, SizeOf(TValue), 0);

          DBRecord.nIndex := OHeroDBRecord.nIndex;
          NewList.Add(DBRecord);
        end else begin
          ODBRecord := pTOBigStorage(List.Items[II]);
          New(DBRecord);
          DBRecord.boDelete := ODBRecord.boDelete;
          DBRecord.sCharName := ODBRecord.sCharName;
          DBRecord.SaveDateTime := ODBRecord.SaveDateTime;
          Move(ODBRecord.UseItems, DBRecord.UseItems, SizeOf(TOUserItem));
          FillChar(DBRecord.UseItems.AddValue, SizeOf(TValue), 0);
          FillChar(DBRecord.UseItems.AddPoint, SizeOf(TValue), 0);
          DBRecord.UseItems.MaxDate := Now;
          DBRecord.nIndex := ODBRecord.nIndex;
          NewList.Add(DBRecord);
        end;
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
  ProcessMessage(Format(sSaveToFile, [g_sFileNames[1]]));
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

end.

