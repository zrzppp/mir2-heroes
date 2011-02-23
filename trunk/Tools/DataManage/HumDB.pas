unit HumDB;

interface
uses
  Windows, Classes, SysUtils, Forms, IniFiles, ObjBase, Grobal2;
resourcestring
  sDBHeaderDesc = '飞尔世界数据库文件 2008/08/21';
  sDBIdxHeaderDesc = '飞尔世界数据库文件 2008/08/21';
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

  {THumInfo = packed record //Size 72
    Header: TRecordHeader;
    sChrName: string[14]; //0x14  //角色名称   44
    sAccount: string[10]; //账号
    boDeleted: Boolean; //是否删除
    boIsHero: Boolean;
    dModDate: TDateTime;
    btCount: Byte; //操作计次
    boSelected: Boolean; //是否选择
    N6: array[0..5] of Byte;
  end;
  pTHumInfo = ^THumInfo;}

  TIdxRecord = record
    sChrName: string[15];
    nIndex: Integer;
  end;
  pTIdxRecord = ^TIdxRecord;

  TFileHumDB = class(TDataManage)
    m_Header: TDBHeader;
    m_HumDBList: TQuickIDList;
    m_HumCharNameList: TQuickList;
  private
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;

    procedure Load; override;
    procedure UnLoad; override;
    procedure SaveToFile(sFileName: string); overload;
    procedure SaveToFile(); overload; override;

    procedure GetCharNameList(sAccount: string; List: TStrings);
    function Get(Name: string): pTHumInfo;
    procedure Delete(Name: string); overload;
    procedure Delete(HumInfo: pTHumInfo); overload;
  end;

  TFileDB = class(TDataManage)
    m_Header: TDBHeader;

    m_MirCharNameList: TQuickList;
    m_MirDBList: TQuickIDList;
  private
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;

    procedure Load; override;
    procedure UnLoad; override;
    procedure SaveToFile(sFileName: string); overload;
    procedure SaveToFile(); overload; override;

    procedure GetCharNameList(sAccount: string; List: TStrings);
    function Get(Name: string): pTHumDataInfo;
    //property LoadPlayCount: Integer read GetLoadPlayCount;
    procedure Delete(HumanRCD: pTHumDataInfo; boDispose: Boolean = False);
  end;

  TSellOff = class(TDataManage)
    m_Header: TItemCount;
    m_SellOffList: TQuickIDList;
    m_ItemList: TQuickList;
  private
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;

    procedure Load; override;
    procedure UnLoad; override;
    procedure SaveToFile(sFileName: string); overload;
    procedure SaveToFile(); overload; override;
    procedure Delete(Name: string);
  end;

  TStorage = class(TDataManage)
    m_Header: TItemCount;
    m_BigStorageList: TQuickIDList;
    m_ItemList: TQuickList;
  private
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;
    procedure Load; override;
    procedure UnLoad; override;
    procedure SaveToFile(sFileName: string); overload;
    procedure SaveToFile(); overload; override;

    procedure Delete(Name: string);
  end;

implementation

uses HUtil32, Share;


{ TFileHumDB }

constructor TFileHumDB.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_HumDBList := TQuickIDList.Create;
  m_HumCharNameList := TQuickList.Create;
end;

destructor TFileHumDB.Destroy;
begin
  UnLoad();
  m_HumDBList.Free;
  m_HumCharNameList.Free;
  inherited;
end;

procedure TFileHumDB.UnLoad();
var
  I: Integer;
begin
  for I := 0 to m_HumDBList.Count - 1 do begin
    TList(m_HumDBList.Objects[I]).Free;
  end;
  m_HumDBList.Clear;

  for I := 0 to m_HumCharNameList.Count - 1 do begin
    Dispose(pTHumInfo(m_HumCharNameList.Objects[I]));
  end;
  m_HumCharNameList.Clear;
end;

procedure TFileHumDB.Delete(Name: string);
var
  I, II: Integer;
  List: TList;
  HumInfo: pTHumInfo;
  boFind: Boolean;
begin
  boFind := False;
  for I := m_HumDBList.Count - 1 downto 0 do begin
    List := TList(m_HumDBList.Objects[I]);
    for II := List.Count - 1 downto 0 do begin
      HumInfo := pTHumInfo(List.Items[II]);
      if CompareStr(HumInfo.sChrName, Name) = 0 then begin
        List.Delete(II);
        boFind := True;
        Break;
      end;
    end;
    if List.Count <= 0 then begin
      List.Free;
      m_HumDBList.Delete(I);
    end;
    if boFind then Break;
  end;

  for I := m_HumCharNameList.Count - 1 downto 0 do begin
    HumInfo := pTHumInfo(m_HumCharNameList.Objects[I]);
    if CompareStr(HumInfo.sChrName, Name) = 0 then begin
      m_HumCharNameList.Delete(I);
      Break;
    end;
  end;
end;

procedure TFileHumDB.Delete(HumInfo: pTHumInfo);
var
  I, II: Integer;
  List: TList;
  boFind: Boolean;
begin
  boFind := False;
  for I := m_HumDBList.Count - 1 downto 0 do begin
    List := TList(m_HumDBList.Objects[I]);
    for II := List.Count - 1 downto 0 do begin
      if pTHumInfo(List.Items[II]) = HumInfo then begin
        List.Delete(II);
        boFind := True;
        Break;
      end;
    end;
    if List.Count <= 0 then begin
      List.Free;
      m_HumDBList.Delete(I);
    end;
    if boFind then Break;
  end;

  for I := m_HumCharNameList.Count - 1 downto 0 do begin
    if pTHumInfo(m_HumCharNameList.Objects[I]) = HumInfo then begin
      m_HumCharNameList.Delete(I);
      Break;
    end;
  end;
end;

function TFileHumDB.Get(Name: string): pTHumInfo;
var
  I, II: Integer;
  List: TList;
  HumInfo: pTHumInfo;
begin
  Result := nil;
  for I := 0 to m_HumDBList.Count - 1 do begin
    List := TList(m_HumDBList.Objects[I]);
    for II := 0 to List.Count - 1 do begin
      HumInfo := List.Items[II];
      if CompareStr(HumInfo.sChrName, Name) = 0 then begin
        Result := HumInfo;
        Exit;
      end;
    end;
  end;

  {for I := 0 to m_HumCharNameList.Count - 1 do begin
    HumInfo := pTHumInfo(m_HumCharNameList.Objects[I]);
    if CompareStr(HumInfo.sChrName, Name) = 0 then begin
      Result := HumInfo;
      Break;
    end;
  end;}
end;

procedure TFileHumDB.GetCharNameList(sAccount: string; List: TStrings);
var
  I: Integer;
  ChrList: TList;
  DBRecord: pTHumInfo;
begin
  List.Clear;
  if (m_HumDBList.GetList(sAccount, ChrList) >= 0) and (ChrList <> nil) then begin
    for I := 0 to ChrList.Count - 1 do begin
      DBRecord := ChrList.Items[I];
      List.AddObject(DBRecord.sChrName, TObject(DBRecord));
    end;
  end;
end;

procedure TFileHumDB.Load();
var
  nIndex: Integer;
  DBHeader: TDBHeader;
  DBRecord: pTHumInfo;
begin
  m_nCount := 0;
  m_nPercent := 0;
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then begin
        if Assigned(OnStart) then OnStart(Self, DBHeader.nHumCount, Format(
            sLondData, [g_sFileNames[m_nType]]));
        for nIndex := 0 to DBHeader.nHumCount - 1 do begin
          if g_boClose then Break;
          if Assigned(OnProgress) then OnProgress(Self, nIndex + 1, '');

          New(DBRecord);
          FillChar(DBRecord^, SizeOf(THumInfo), #0);

          if FileRead(m_nFileHandle, DBRecord^, SizeOf(THumInfo)) <> SizeOf(THumInfo) then begin
            Dispose(DBRecord);
            Break;
          end;

          if (DBRecord.sAccount = '') or (DBRecord.sChrName = '') or (DBRecord.Header.sName = '') or DBRecord.Header.boDeleted then begin
            Dispose(DBRecord);
            Continue;
          end;

          m_HumCharNameList.AddObject(DBRecord.sChrName, TObject(DBRecord));
          m_HumDBList.AddRecord(DBRecord.sAccount, TObject(DBRecord));

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
  if Assigned(OnStop) then OnStop(Self, 0, sSortString);
  m_HumDBList.SortString(0, m_HumDBList.Count - 1);
  m_HumCharNameList.SortString(0, m_HumCharNameList.Count - 1);
end;

procedure TFileHumDB.Close;
begin
  FileClose(m_nFileHandle);
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

procedure TFileHumDB.SaveToFile(sFileName: string);
var
  sOldDBFileName: string;
begin
  sOldDBFileName := m_sDBFileName;
  try
    m_sDBFileName := sFileName;
    SaveToFile();
  finally
    m_sDBFileName := sOldDBFileName;
  end;
end;

procedure TFileHumDB.SaveToFile();
var
  DBRecord: pTHumInfo;
  List: TList;
  I, II: Integer;
begin
  if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
  try
    if Open then begin
      if Assigned(OnStart) then OnStart(Self, m_HumCharNameList.Count, Format(
          sSaveToFile, [g_sFileNames[m_nType]]));
      m_Header.nHumCount := m_HumCharNameList.Count;
      FileSeek(m_nFileHandle, 0, 0);
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
      for I := 0 to m_HumCharNameList.Count - 1 do begin
        if g_boClose then Break;
        if Assigned(OnProgress) then OnProgress(Self, I + 1, '');
        DBRecord := pTHumInfo(m_HumCharNameList.Objects[I]);
        FileWrite(m_nFileHandle, DBRecord^, SizeOf(THumInfo));
        if Application.Terminated then begin
          Close;
          Exit;
        end;
      end;
    end;
  finally
    Close();
  end;
  if Assigned(OnStop) then OnStop(Self, 0, '');
end;

{ TFileDB }

constructor TFileDB.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_MirCharNameList := TQuickList.Create;
  m_MirDBList := TQuickIDList.Create;
end;

destructor TFileDB.Destroy;
begin
  UnLoad();

  m_MirCharNameList.Free;
  m_MirDBList.Free;
  inherited
end;

procedure TFileDB.UnLoad();
var
  I: Integer;
begin
  for I := 0 to m_MirDBList.Count - 1 do begin
    TList(m_MirDBList.Objects[I]).Free;
  end;
  m_MirDBList.Clear;

  for I := 0 to m_MirCharNameList.Count - 1 do begin
    Dispose(pTHumDataInfo(m_MirCharNameList.Objects[I]));
  end;
  m_MirCharNameList.Clear;
end;

procedure TFileDB.Delete(HumanRCD: pTHumDataInfo; boDispose: Boolean);
var
  I, II: Integer;
  List: TList;
  boFind: Boolean;
  DeleteRCD: pTHumDataInfo;
begin
  boFind := False;
  for I := m_MirDBList.Count - 1 downto 0 do begin
    List := TList(m_MirDBList.Objects[I]);
    for II := List.Count - 1 downto 0 do begin
      if pTHumDataInfo(List.Items[II]) = HumanRCD then begin
        List.Delete(II);
        boFind := True;
        Break;
      end;
    end;
    if List.Count <= 0 then begin
      List.Free;
      m_MirDBList.Delete(I);
    end;
    if boFind then Break;
  end;

  for I := m_MirCharNameList.Count - 1 downto 0 do begin
    if pTHumDataInfo(m_MirCharNameList.Objects[I]) = HumanRCD then begin
      if boDispose then Dispose(pTHumDataInfo(m_MirCharNameList.Objects[I]));
      m_MirCharNameList.Delete(I);
      Break;
    end;
  end;
  {if HumanRCD.Data.boIsHero then begin
    DeleteRCD := Get(HumanRCD.Data.sMasterName);
    if DeleteRCD <> nil then begin
      DeleteRCD.Data.sHeroChrName := '';
      DeleteRCD.Data.boHasHero := False;
    end;
  end else begin
    if HumanRCD.Data.sHeroChrName <> '' then begin
      DeleteRCD := Get(HumanRCD.Data.sHeroChrName);
      if DeleteRCD <> nil then begin
        Delete(DeleteRCD, True);
      end;
    end;
  end;}
end;

procedure TFileDB.GetCharNameList(sAccount: string; List: TStrings);
var
  I: Integer;
  ChrList: TList;
  HumanRCD: pTHumDataInfo;
begin
  List.Clear;
  if (m_MirDBList.GetList(sAccount, ChrList) >= 0) and (ChrList <> nil) then begin
    for I := 0 to ChrList.Count - 1 do begin
      HumanRCD := ChrList.Items[I];
      List.AddObject(HumanRCD.Header.sName, TObject(HumanRCD));
    end;
  end;
end;

procedure TFileDB.Load();
var
  nIndex, nIdx: Integer;
  DBHeader: TDBHeader;
  RecordHeader: TRecordHeader;
  HumanRCD: pTHumDataInfo;
  HumInfo: pTHumInfo;
begin
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then begin
        m_nCount := DBHeader.nHumCount;
        if Assigned(OnStart) then OnStart(Self, DBHeader.nHumCount, Format(
            sLondData, [g_sFileNames[m_nType]]));
        for nIndex := 0 to DBHeader.nHumCount - 1 do begin
          if g_boClose then Break;
          if Assigned(OnProgress) then OnProgress(Self, nIndex + 1, '');

          if FileSeek(m_nFileHandle, nIndex * SizeOf(THumDataInfo) + SizeOf(TDBHeader), 0) = -1 then Break;

          New(HumanRCD);
          FillChar(HumanRCD^, SizeOf(THumDataInfo), #0);

          if FileRead(m_nFileHandle, HumanRCD^, SizeOf(THumDataInfo)) <> SizeOf(THumDataInfo) then begin
            Dispose(HumanRCD);
            Break;
          end;

          if (HumanRCD.Header.sName = '') or HumanRCD.Header.boDeleted then begin
            Dispose(HumanRCD);
            Continue;
          end;

          m_MirCharNameList.AddObject(HumanRCD.Data.sChrName, TObject(HumanRCD));

          m_MirDBList.AddRecord(HumanRCD.Data.sAccount, TObject(HumanRCD));

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
  if Assigned(OnStop) then OnStop(Self, 0, sSortString);
  m_MirDBList.SortString(0, m_MirDBList.Count - 1);
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

procedure TFileDB.SaveToFile(sFileName: string);
var
  sOldDBFileName: string;
begin
  sOldDBFileName := m_sDBFileName;
  try
    m_sDBFileName := sFileName;
    SaveToFile();
  finally
    m_sDBFileName := sOldDBFileName;
  end;
end;

procedure TFileDB.SaveToFile();
var
  HumanRCD: pTHumDataInfo;
  I: Integer;
begin
  if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
  try
    if Open then begin
      m_Header.nHumCount := m_MirCharNameList.Count;
      if Assigned(OnStart) then OnStart(Self, m_MirCharNameList.Count, Format(
          sSaveToFile, [g_sFileNames[m_nType]]));
      FileSeek(m_nFileHandle, 0, 0);
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
      for I := 0 to m_MirCharNameList.Count - 1 do begin
        if g_boClose then Break;
        if Assigned(OnProgress) then OnProgress(Self, I + 1, '');
        HumanRCD := pTHumDataInfo(m_MirCharNameList.Objects[I]);
        FileWrite(m_nFileHandle, HumanRCD^, SizeOf(THumDataInfo));
        if Application.Terminated then begin
          Close;
          Exit;
        end;
      end;
    end;
  finally
    Close();
  end;
  if Assigned(OnStop) then OnStop(Self, 0, '');
end;

function TFileDB.Get(Name: string): pTHumDataInfo;
var
  I, II: Integer;
  List: TList;
  Index: Integer;
  HumDataInfo: pTHumDataInfo;
begin
  Result := nil;

  for I := 0 to m_MirDBList.Count - 1 do begin
    List := TList(m_MirDBList.Objects[I]);
    for II := 0 to List.Count - 1 do begin
      HumDataInfo := List.Items[II];
      if CompareStr(HumDataInfo.Data.sChrName, Name) = 0 then begin
        Result := HumDataInfo;
        Exit;
      end;
    end;
  end;

  {Index := m_MirCharNameList.GetIndex(Name);
  if Index >= 0 then Result := pTHumDataInfo(m_MirCharNameList.Objects[Index]);   }
end;

{ TSellOff }

constructor TSellOff.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_SellOffList := TQuickIDList.Create;
  m_ItemList := TQuickList.Create;
end;

destructor TSellOff.Destroy;
begin
  UnLoad();
  m_SellOffList.Free;
  m_ItemList.Free;
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
      Dispose(pTSellOffInfo(ChrList.Items[II]));
    end;
    ChrList.Free;
  end;
  m_SellOffList.Clear;
end;

procedure TSellOff.Delete(Name: string);
var
  I, II: Integer;
  List: TList;
  SellOffInfo: pTSellOffInfo;
  boFind: Boolean;
begin
  boFind := False;
  for I := m_SellOffList.Count - 1 downto 0 do begin
    List := TList(m_SellOffList.Objects[I]);
    SellOffInfo := List.Items[0];
    if CompareStr(SellOffInfo.sCharName, Name) = 0 then begin
      for II := 0 to List.Count - 1 do begin
        Dispose(pTSellOffInfo(List.Items[II]));
      end;
      boFind := True;
      List.Free;
      m_SellOffList.Delete(I);
    end;
    if boFind then Break;
  end;

  for I := m_ItemList.Count - 1 downto 0 do begin
    SellOffInfo := pTSellOffInfo(m_ItemList.Objects[I]);
    if CompareStr(SellOffInfo.sCharName, Name) = 0 then begin
      m_ItemList.Delete(I);
    end;
  end;
end;

procedure TSellOff.Load();
var
  nIndex: Integer;
  DBHeader: TItemCount;
  DBRecord: pTSellOffInfo;
begin
  m_nCount := 0;
  m_nPercent := 0;
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        m_nCount := DBHeader;
        if Assigned(OnStart) then OnStart(Self, DBHeader, Format(sLondData, [
            g_sFileNames[m_nType]]));
        for nIndex := 0 to DBHeader - 1 do begin
          if g_boClose then Break;
          if Assigned(OnProgress) then OnProgress(Self, nIndex + 1, '');

          New(DBRecord);

          FillChar(DBRecord^, SizeOf(TSellOffInfo), #0);
          if FileRead(m_nFileHandle, DBRecord^, SizeOf(TSellOffInfo)) <> SizeOf(TSellOffInfo) then begin
            Dispose(DBRecord);
            Break;
          end;

          if (DBRecord.sCharName <> '') and (DBRecord.UserItem.wIndex > 0) then begin
            m_SellOffList.AddRecord(DBRecord.sCharName, TObject(DBRecord));
            m_ItemList.AddObject(DBRecord.sCharName, TObject(DBRecord));
          end else begin
            Dispose(DBRecord);
            Continue;
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
  if Assigned(OnStop) then OnStop(Self, 0, sSortString);
  m_SellOffList.SortString(0, m_SellOffList.Count - 1);
  m_ItemList.SortString(0, m_ItemList.Count - 1);
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

procedure TSellOff.SaveToFile(sFileName: string);
var
  sOldDBFileName: string;
begin
  sOldDBFileName := m_sDBFileName;
  try
    m_sDBFileName := sFileName;
    SaveToFile();
  finally
    m_sDBFileName := sOldDBFileName;
  end;
end;

procedure TSellOff.SaveToFile();
var
  DBRecord: pTSellOffInfo;
  List: TList;
  I, II: Integer;
begin
  m_nCount := 0;
  m_nPercent := 0;
  if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
  try
    if Open then begin
      m_nCount := m_SellOffList.Count;
      m_Header := 0;
      for I := 0 to m_SellOffList.Count - 1 do begin
        List := TList(m_SellOffList.Objects[I]);
        Inc(m_Header, List.Count);
        for II := 0 to List.Count - 1 do begin
          DBRecord := pTSellOffInfo(List.Items[II]);
          if DBRecord.UserItem.wIndex <= 0 then Dec(m_Header);
        end;
      end;
      if Assigned(OnStart) then OnStart(Self, m_Header, Format(sSaveToFile, [
          g_sFileNames[m_nType]]));
      FileSeek(m_nFileHandle, 0, 0);
      FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
      for I := 0 to m_SellOffList.Count - 1 do begin
        if g_boClose then Break;
        if Assigned(OnProgress) then OnProgress(Self, I + 1, '');
        List := TList(m_SellOffList.Objects[I]);
        for II := 0 to List.Count - 1 do begin
          DBRecord := pTSellOffInfo(List.Items[II]);
          if DBRecord.UserItem.wIndex <= 0 then Continue;
          FileWrite(m_nFileHandle, DBRecord^, SizeOf(TSellOffInfo));
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
  if Assigned(OnStop) then OnStop(Self, 0, '');
end;

{ TStorage }

constructor TStorage.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_BigStorageList := TQuickIDList.Create;
  m_ItemList := TQuickList.Create;
end;

destructor TStorage.Destroy;
begin
  UnLoad();
  m_BigStorageList.Free;
  m_ItemList.Free;
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
      Dispose(pTBigStorage(ChrList.Items[II]));
    end;
    ChrList.Free;
  end;
  m_BigStorageList.Clear;
end;

procedure TStorage.Delete(Name: string);
var
  I, II: Integer;
  List: TList;
  BigStorage: pTBigStorage;
  boFind: Boolean;
begin
  boFind := False;
  for I := m_BigStorageList.Count - 1 downto 0 do begin
    List := TList(m_BigStorageList.Objects[I]);
    BigStorage := List.Items[0];
    if CompareStr(BigStorage.sCharName, Name) = 0 then begin
      for II := 0 to List.Count - 1 do begin
        Dispose(pTBigStorage(List.Items[II]));
      end;
      boFind := True;
      List.Free;
      m_BigStorageList.Delete(I);
    end;
    if boFind then Break;
  end;

  for I := m_ItemList.Count - 1 downto 0 do begin
    BigStorage := pTBigStorage(m_ItemList.Objects[I]);
    if CompareStr(BigStorage.sCharName, Name) = 0 then begin
      m_ItemList.Delete(I);
    end;
  end;
end;

procedure TStorage.Load();
var
  nIndex: Integer;
  DBHeader: TItemCount;
  DBRecord: pTBigStorage;
begin
  m_nCount := 0;
  m_nPercent := 0;
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        m_nCount := DBHeader;
        if Assigned(OnStart) then OnStart(Self, DBHeader, Format(sLondData, [
            g_sFileNames[m_nType]]));
        for nIndex := 0 to DBHeader - 1 do begin
          if g_boClose then Break;

          if Assigned(OnProgress) then OnProgress(Self, nIndex + 1, '');

          New(DBRecord);

          FillChar(DBRecord^, SizeOf(TBigStorage), #0);
          if FileRead(m_nFileHandle, DBRecord^, SizeOf(TBigStorage)) <> SizeOf(TBigStorage) then begin
            Dispose(DBRecord);
            Break;
          end;

          if DBRecord.boDelete then begin
            Dispose(DBRecord);
            Continue;
          end;

          if (DBRecord.sCharName <> '') and (DBRecord.UserItem.wIndex > 0) then begin
            m_BigStorageList.AddRecord(DBRecord.sCharName, TObject(DBRecord));
            m_ItemList.AddObject(DBRecord.sCharName, TObject(DBRecord));
          end else begin
            Dispose(DBRecord);
            Continue;
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
  if Assigned(OnStop) then OnStop(Self, 0, sSortString);
  m_BigStorageList.SortString(0, m_BigStorageList.Count - 1);
  m_ItemList.SortString(0, m_ItemList.Count - 1);
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

procedure TStorage.SaveToFile(sFileName: string);
var
  sOldDBFileName: string;
begin
  sOldDBFileName := m_sDBFileName;
  try
    m_sDBFileName := sFileName;
    SaveToFile();
  finally
    m_sDBFileName := sOldDBFileName;
  end;
end;

procedure TStorage.SaveToFile();
var
  DBRecord: pTBigStorage;
  List: TList;
  I, II: Integer;
begin
  m_nCount := 0;
  m_nPercent := 0;
  if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
  try
    if Open then begin
      m_nCount := m_BigStorageList.Count;
      m_Header := 0;
      for I := 0 to m_BigStorageList.Count - 1 do begin
        List := TList(m_BigStorageList.Objects[I]);
        Inc(m_Header, List.Count);
        for II := 0 to List.Count - 1 do begin
          DBRecord := pTBigStorage(List.Items[II]);
          if DBRecord.UserItem.wIndex <= 0 then Dec(m_Header);
        end;
      end;
      if Assigned(OnStart) then OnStart(Self, m_Header, Format(sSaveToFile, [
          g_sFileNames[m_nType]]));
      FileSeek(m_nFileHandle, 0, 0);
      FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
      for I := 0 to m_BigStorageList.Count - 1 do begin
        if g_boClose then Break;
        if Assigned(OnProgress) then OnProgress(Self, I + 1, '');
        List := TList(m_BigStorageList.Objects[I]);
        for II := 0 to List.Count - 1 do begin
          DBRecord := pTBigStorage(List.Items[II]);
          if DBRecord.UserItem.wIndex <= 0 then Continue;
          FileWrite(m_nFileHandle, DBRecord^, SizeOf(TBigStorage));
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
  if Assigned(OnStop) then OnStop(Self, 0, '');
end;

end.

