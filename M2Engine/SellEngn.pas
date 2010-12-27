unit SellEngn;

interface
uses
  Windows, Classes, SysUtils, Grobal2, SDK, Forms;
type
  TUserSellManage = class
    m_UserCriticalSection: TRTLCriticalSection;
    m_Header: TItemCount;
    m_nFileHandle: Integer;
    m_sFileName: string;
    m_sDBFileName: string;
    m_DeletedList: TList; //已被删除的记录号
    m_nRecordCount: Integer;
  private

  public
    constructor Create(); virtual;
    destructor Destroy; override;
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Lock();
    procedure UnLock();
    procedure Close();
    function UpDate(SellOffInfo: pTSellOffInfo; boNew: Boolean): Boolean;
  end;

  TSellList = class(TGStringList)
    m_SellEngine: TUserSellManage;
  public
    m_sName: string;
    constructor Create();
    destructor Destroy; override;
    function GetIndex(sName: string): Integer;
    function AddRecord(UserItem: pTUserItem; nSellGold: Integer): Boolean;
    function DelRecord(nMakeIndex: Integer; sItemName: string; boFree: Boolean): Boolean;
    procedure DeleteA(nIndex: Integer);
    function GetItem(nMakeIndex: Integer; sItemName: string; var UserItem: TUserItem; var nSellGold: Integer): Integer; overload;
    function GetItem(nMakeIndex: Integer; sItemName: string; var SellOffInfo: pTSellOffInfo): Integer; overload;
    procedure SortString(nMIN, nMax: Integer);
  end;

  TSellManageList = class(TGStringList)
    m_SellEngine: TUserSellManage;
  public
    function AddRecord(sName: string; SellOffInfo: pTSellOffInfo): TSellList;
    procedure DelRecord(nIndex, nMakeIndex: Integer); overload;
    procedure DelRecord(sName: string; nMakeIndex: Integer); overload;
    function GetSellList(sName: string; var SellList: TSellList): Integer;
  end;

  TSellEngine = class(TUserSellManage)
    m_CharSellList: TSellManageList;

    m_ItemSellList: TSellManageList;
    m_SellList: TSellList;

    m_DressList: TSellList;
    m_WeaponList: TSellList;
    m_JewelryList: TSellList;
    m_CharmList: TSellList;
    m_OtherList: TSellList;
  private
    procedure SaveToFile();
    function GetRecordCount: Integer;
    function GetHumManCount: Integer;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure LoadSellList();
    procedure UnLoadSellList();
    procedure UpDateSellList;
    procedure AddItem(SellOffInfo: pTSellOffInfo);
    procedure DelItem(SellOffInfo: pTSellOffInfo);
    function GetItemTypeA(StdItem: pTStdItem): Byte;
    function GetTypeItemList(wIndex: Word): TSellList;
    function GetTypeItemListA(wIndex: Word): TSellList;
    function Add(sChrName: string; UserItem: pTUserItem; nSellGold: Integer): Boolean; overload;
    function Add(SellOffInfo: pTSellOffInfo): Boolean; overload;
    function Delete(sChrName: string; nMakeIndex: Integer; sItemName: string; boFree: Boolean): Boolean; overload;
    function Delete(SellOffInfo: pTSellOffInfo; boFree: Boolean): Boolean; overload;
    procedure Delete(nIndex: Integer); overload;
    procedure GetSellList(var SellList: TStringList);
    function GetSellListByCharName(sCharName: string; var SellList: TSellList): Integer;
    function GetSellListByItemName(sItemName: string; var SellList: TSellList): Integer;
    function GetItem(sChrName: string; nMakeIndex: Integer; sItemName: string; var UserItem: TUserItem; var nSellGold: Integer): Integer; overload;
    function GetItem(sChrName: string; nMakeIndex: Integer; sItemName: string; var SellOffInfo: pTSellOffInfo): Integer; overload;
    function GetItem(nMakeIndex: Integer; sItemName: string; var SellOffInfo: pTSellOffInfo): Integer; overload;
    procedure Rebuild;
    property RecordCount: Integer read GetRecordCount;
    property HumManCount: Integer read GetHumManCount;
  end;

  TGoldEngine = class(TUserSellManage)
    m_CharGoldList: TSellManageList;
  private
    procedure SaveToFile();
    function GetRecordCount: Integer;
    function GetHumManCount: Integer;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure LoadGoldList();
    procedure UnLoadGoldList();
    procedure UpDateGoldList;
    function Add(sChrName: string; UserItem: pTUserItem; nSellGold: Integer): Boolean; overload;
    function Add(SellOffInfo: pTSellOffInfo): Boolean; overload;
    function Delete(sChrName: string; nMakeIndex: Integer; sItemName: string): Boolean; overload;
    procedure Delete(nIndex: Integer); overload;
    function GetGoldListByCharName(sCharName: string; var GoldList: TSellList): Integer;
    function GetItem(sChrName: string; nMakeIndex: Integer; sItemName: string; var UserItem: TUserItem; var nSellGold: Integer): Integer;
    procedure Rebuild;
    property RecordCount: Integer read GetRecordCount;
    property HumManCount: Integer read GetHumManCount;
  end;

implementation
uses
  M2Share, RunDB, ObjBase, HUtil32;

constructor TGoldEngine.Create;
begin
  inherited Create;
  if g_Config.sEnvirDir[Length(g_Config.sEnvirDir)] = '\' then
    m_sFileName := g_Config.sEnvirDir + 'Market_SellOff\'
  else
    m_sFileName := g_Config.sEnvirDir + '\Market_SellOff\';
  if not DirectoryExists(m_sFileName) then begin
    ForceDirectories(m_sFileName);
  end;
  m_sDBFileName := m_sFileName + 'UserSellOff.Gold';
  m_CharGoldList := TSellManageList.Create;
  m_CharGoldList.m_SellEngine := Self;
end;

destructor TGoldEngine.Destroy;
begin
  UnLoadGoldList();
  m_CharGoldList.Free;
  inherited Destroy;
end;

procedure TGoldEngine.UnLoadGoldList();
var
  I, II: Integer;
  GoldList: TSellList;
  SellOffInfo: pTSellOffInfo;
begin
  for I := 0 to m_CharGoldList.Count - 1 do begin
    GoldList := TSellList(m_CharGoldList.Objects[I]);
    for II := 0 to GoldList.Count - 1 do begin
      SellOffInfo := pTSellOffInfo(GoldList.Objects[II]);
      Dispose(SellOffInfo);
    end;
    GoldList.Free;
  end;
  m_CharGoldList.Clear;
end;

procedure TGoldEngine.UpDateGoldList;
var
  I: Integer;
  nCount: Integer;
  GoldList: TSellList;
begin
  Lock();
  try
    nCount := 0;
    for I := m_CharGoldList.Count - 1 downto 0 do begin
      GoldList := TSellList(m_CharGoldList.Objects[I]);
      if GoldList.Count <= 0 then begin
        GoldList.Free;
        m_CharGoldList.Delete(I);
      end else begin
        Inc(nCount, GoldList.Count);
      end;
    end;
    if nCount < m_Header div 2 then begin
      //SaveToFile();
    end;
  finally
    UnLock();
  end;
end;

procedure TGoldEngine.LoadGoldList();
var
  nIndex: Integer;
  DBHeader: TItemCount;
  DBRecord: pTSellOffInfo;
begin
  UnLoadGoldList();
  m_DeletedList.Clear;
  try
    if Open then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        for nIndex := 0 to DBHeader - 1 do begin
          New(DBRecord);
          FillChar(DBRecord^, SizeOf(TSellOffInfo), #0);
          if FileRead(m_nFileHandle, DBRecord^, SizeOf(TSellOffInfo)) <> SizeOf(TSellOffInfo) then begin
            Dispose(DBRecord);
            Break;
          end;
          if (DBRecord.UserItem.wIndex > 0) and (DBRecord.sCharName <> '') then begin
            Inc(m_nRecordCount);
            DBRecord.nIndex := nIndex;
            m_CharGoldList.AddRecord(DBRecord.sCharName, DBRecord);
          end else begin
            Dispose(DBRecord);
            m_DeletedList.Add(Pointer(nIndex));
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
end;

function TGoldEngine.GetRecordCount: Integer;
begin
  Result := m_nRecordCount;
end;

function TGoldEngine.GetHumManCount: Integer;
begin
  Result := m_CharGoldList.Count;
end;

procedure TGoldEngine.Rebuild;
var
  sTempFileName: string;
  nHandle, n10: Integer;
  DBRecord: TSellOffInfo;
  DBHeader: TItemCount;
begin
  sTempFileName := m_sFileName + 'UserStorage#$00.db';
  if FileExists(sTempFileName) then
    DeleteFile(sTempFileName);
  nHandle := FileCreate(sTempFileName);
  n10 := 0;
  if nHandle < 0 then Exit;
  try
    if Open then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        FileWrite(nHandle, DBHeader, SizeOf(TItemCount));
        while (True) do begin
          if FileRead(m_nFileHandle, DBRecord, SizeOf(TSellOffInfo)) = SizeOf(TSellOffInfo) then begin
            if (DBRecord.sCharName = '') or (DBRecord.UserItem.wIndex = 0) then Continue;
            FileWrite(nHandle, DBRecord, SizeOf(TSellOffInfo));
            Inc(n10);
          end else Break;
        end;
        DBHeader := n10;
        FileSeek(nHandle, 0, 0);
        FileWrite(nHandle, DBHeader, SizeOf(TSellOffInfo));
      end;
    end;
  finally
    Close;
  end;
  FileClose(nHandle);
  FileCopy(sTempFileName, m_sDBFileName);
  DeleteFile(sTempFileName);
end;

procedure TGoldEngine.SaveToFile();
var
  DBRecord: pTSellOffInfo;
  DBHeader: TItemCount;
  List: TSellList;
  I, II: Integer;
  nHandle: Integer;
  sTempFileName: string;
begin
  Lock;
  try
    sTempFileName := m_sFileName + 'UserStorage#$00.db';
    if FileExists(sTempFileName) then DeleteFile(sTempFileName);
    nHandle := FileCreate(sTempFileName);

    if nHandle < 0 then Exit;
    DBHeader := 0;
    for I := 0 to m_CharGoldList.Count - 1 do begin
      List := TSellList(m_CharGoldList.Objects[I]);
      Inc(DBHeader, List.Count);
    end;
    FileSeek(nHandle, 0, 0);
    FileWrite(nHandle, DBHeader, SizeOf(TItemCount));
    for I := 0 to m_CharGoldList.Count - 1 do begin
      List := TSellList(m_CharGoldList.Objects[I]);
      for II := 0 to List.Count - 1 do begin
        DBRecord := pTSellOffInfo(List.Objects[II]);
        FileWrite(nHandle, DBRecord^, SizeOf(TSellOffInfo));
        if Application.Terminated then begin
          Close;
          Exit;
        end;
      end;
    end;
    FileClose(nHandle);
    FileCopy(sTempFileName, m_sDBFileName);
    DeleteFile(sTempFileName);
    LoadGoldList();
  finally
    UnLock; ;
  end;
end;

function TGoldEngine.GetGoldListByCharName(sCharName: string; var GoldList: TSellList): Integer;
begin
  Lock();
  try
    Result := m_CharGoldList.GetSellList(sCharName, GoldList);
  finally
    UnLock();
  end;
end;

function TGoldEngine.Add(SellOffInfo: pTSellOffInfo): Boolean;
begin
  Lock();
  try
    if UpDate(SellOffInfo, True) then begin
      m_CharGoldList.AddRecord(SellOffInfo.sCharName, SellOffInfo);
      Result := True;
    end else begin
      Dispose(SellOffInfo);
      Result := False;
    end;
  finally
    UnLock();
  end;
end;

function TGoldEngine.Add(sChrName: string; UserItem: pTUserItem; nSellGold: Integer): Boolean;
var
  SellOffInfo: pTSellOffInfo;
begin
  Lock();
  try
    New(SellOffInfo);
    SellOffInfo.sCharName := sChrName;
    SellOffInfo.dSellDateTime := Now;
    SellOffInfo.nSellGold := nSellGold;
    SellOffInfo.UserItem := UserItem^;
    SellOffInfo.nIndex := -1;
    if UpDate(SellOffInfo, True) then begin
      m_CharGoldList.AddRecord(sChrName, SellOffInfo);
      Result := True;
    end else begin
      Dispose(SellOffInfo);
      Result := False;
    end;
  finally
    UnLock();
  end;
end;

function TGoldEngine.Delete(sChrName: string; nMakeIndex: Integer; sItemName: string): Boolean;
var
  GoldList: TSellList;
  nIndex: Integer;
begin
  Lock();
  try
    Result := False;
    nIndex := m_CharGoldList.GetSellList(sChrName, GoldList);
    if (nIndex >= 0) and (GoldList <> nil) then begin
      Result := GoldList.DelRecord(nMakeIndex, sItemName, True);
      if GoldList.Count <= 0 then begin
        GoldList.Free;
        m_CharGoldList.Delete(nIndex);
      end;
    end;
  finally
    UnLock();
  end;
end;

procedure TGoldEngine.Delete(nIndex: Integer);
begin
  Lock();
  try
    if (nIndex >= 0) and (nIndex < m_CharGoldList.Count) then begin
      m_CharGoldList.Delete(nIndex);
    end;
  finally
    UnLock();
  end;
end;

function TGoldEngine.GetItem(sChrName: string; nMakeIndex: Integer; sItemName: string; var UserItem: TUserItem; var nSellGold: Integer): Integer;
var
  GoldList: TSellList;
begin
  Lock();
  try
    Result := -1;
    if m_CharGoldList.GetSellList(sChrName, GoldList) >= 0 then begin
      Result := GoldList.GetItem(nMakeIndex, sItemName, UserItem, nSellGold);
    end;
  finally
    UnLock();
  end;
end;

{TSellEngine}

constructor TSellEngine.Create;
begin
  inherited Create;
  if g_Config.sEnvirDir[Length(g_Config.sEnvirDir)] = '\' then
    m_sFileName := g_Config.sEnvirDir + 'Market_SellOff\'
  else
    m_sFileName := g_Config.sEnvirDir + '\Market_SellOff\';

  if not DirectoryExists(m_sFileName) then begin
    ForceDirectories(m_sFileName);
  end;
  m_sDBFileName := m_sFileName + 'UserSellOff.sell';
  m_CharSellList := TSellManageList.Create;
  m_ItemSellList := TSellManageList.Create;
  m_SellList := TSellList.Create;
  m_DressList := TSellList.Create;
  m_WeaponList := TSellList.Create;
  m_JewelryList := TSellList.Create;
  m_CharmList := TSellList.Create;
  m_OtherList := TSellList.Create;

  m_SellList.m_SellEngine := Self;
  m_DressList.m_SellEngine := Self;
  m_WeaponList.m_SellEngine := Self;
  m_JewelryList.m_SellEngine := Self;
  m_CharmList.m_SellEngine := Self;
  m_OtherList.m_SellEngine := Self;

  m_CharSellList.m_SellEngine := Self;
end;

destructor TSellEngine.Destroy;
begin
  UnLoadSellList();
  m_CharSellList.Free;
  m_ItemSellList.Free;
  m_SellList.Free;
  m_DressList.Free;
  m_WeaponList.Free;
  m_JewelryList.Free;
  m_CharmList.Free;
  m_OtherList.Free;
  inherited Destroy;
end;

procedure TSellEngine.UnLoadSellList();
var
  I, II: Integer;
  SellList: TSellList;
  SellOffInfo: pTSellOffInfo;
begin
  for I := 0 to m_CharSellList.Count - 1 do begin
    SellList := TSellList(m_CharSellList.Objects[I]);
    for II := 0 to SellList.Count - 1 do begin
      SellOffInfo := pTSellOffInfo(SellList.Objects[II]);
      Dispose(SellOffInfo);
    end;
    SellList.Free;
  end;
  m_CharSellList.Clear;

  for I := 0 to m_ItemSellList.Count - 1 do begin
    TSellList(m_ItemSellList.Objects[I]).Free;
  end;
  m_ItemSellList.Clear;
end;

procedure TSellEngine.UpDateSellList;
var
  I: Integer;
  nCount: Integer;
  SellList: TSellList;
begin
  Lock();
  try
    nCount := 0;
    for I := m_CharSellList.Count - 1 downto 0 do begin
      SellList := TSellList(m_CharSellList.Objects[I]);
      if SellList.Count <= 0 then begin
        SellList.Free;
        m_CharSellList.Delete(I);
      end else begin
        Inc(nCount, SellList.Count);
      end;
    end;
    if nCount < m_Header div 2 then begin
      //SaveToFile();
    end;
  finally
    UnLock();
  end;
end;

procedure TSellEngine.LoadSellList();
var
  nIndex: Integer;
  DBHeader: TItemCount;
  DBRecord: pTSellOffInfo;
  sUserItemName: string;
begin
  UnLoadSellList();
  m_DeletedList.Clear;
  try
    if Open then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        for nIndex := 0 to DBHeader - 1 do begin
          New(DBRecord);
          FillChar(DBRecord^, SizeOf(TSellOffInfo), #0);
          if FileRead(m_nFileHandle, DBRecord^, SizeOf(TSellOffInfo)) <> SizeOf(TSellOffInfo) then begin
            Dispose(DBRecord);
            Break;
          end;

          if (DBRecord.UserItem.wIndex > 0) and (DBRecord.sCharName <> '') then begin

            if (DBRecord.UserItem.AddValue[0] = 1) and (GetDayCount(DBRecord.UserItem.MaxDate, Now) <= 0) then begin //删除到期装备
              Dispose(DBRecord);
              m_DeletedList.Add(Pointer(nIndex));
              Continue;
            end;

            Inc(m_nRecordCount);
            DBRecord.nIndex := nIndex;
            m_CharSellList.AddRecord(DBRecord.sCharName, DBRecord);
            sUserItemName := UserEngine.GetStdItemName(DBRecord.UserItem.wIndex);
            m_ItemSellList.AddRecord(sUserItemName, DBRecord);
            AddItem(DBRecord);
          end else begin
            Dispose(DBRecord);
            m_DeletedList.Add(Pointer(nIndex));
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
end;

function TSellEngine.GetItemTypeA(StdItem: pTStdItem): Byte;
begin
  case GetItemType(StdItem) of
    U_DRESS: Result := 1;
    U_WEAPON: Result := 2;
    U_RIGHTHAND,
      U_NECKLACE,
      U_HELMET,
      U_ARMRINGL,
      U_ARMRINGR,
      U_RINGL,
      U_RINGR,
      U_BELT,
      U_BOOTS: Result := 3;
    U_BUJUK: Result := 5;
    U_CHARM: Result := 4;
  end;
end;

procedure TSellEngine.AddItem(SellOffInfo: pTSellOffInfo);
var
  StdItem: pTStdItem;
  sUserItemName: string;
begin
  StdItem := UserEngine.GetStdItem(SellOffInfo.UserItem.wIndex);
  if StdItem <> nil then begin
    sUserItemName := UserEngine.GetStdItemName(SellOffInfo.UserItem.wIndex);
    m_SellList.AddObject(sUserItemName, TObject(SellOffInfo));
    case GetItemTypeA(StdItem) of
      1: m_DressList.AddObject(sUserItemName, TObject(SellOffInfo));
      2: m_WeaponList.AddObject(sUserItemName, TObject(SellOffInfo));
      3: m_JewelryList.AddObject(sUserItemName, TObject(SellOffInfo));
      4: m_CharmList.AddObject(sUserItemName, TObject(SellOffInfo));
      5: m_OtherList.AddObject(sUserItemName, TObject(SellOffInfo));
    end;
  end;
end;

procedure TSellEngine.DelItem(SellOffInfo: pTSellOffInfo);
var
  I: Integer;
  ItemList: TSellList;
begin
  for I := m_SellList.Count - 1 downto 0 do begin
    if pTSellOffInfo(m_SellList.Objects[I]) = SellOffInfo then begin
      m_SellList.Delete(I);
      Break;
    end;
  end;
  ItemList := GetTypeItemList(SellOffInfo.UserItem.wIndex);
  if ItemList <> nil then begin
    for I := ItemList.Count - 1 downto 0 do begin
      if pTSellOffInfo(ItemList.Objects[I]) = SellOffInfo then begin
        ItemList.Delete(I);
        Break;
      end;
    end;
  end;
end;

function TSellEngine.GetTypeItemList(wIndex: Word): TSellList;
var
  StdItem: pTStdItem;
begin
  Result := nil;
  StdItem := UserEngine.GetStdItem(wIndex);
  if StdItem <> nil then begin
    case GetItemTypeA(StdItem) of
      1: Result := m_DressList;
      2: Result := m_WeaponList;
      3: Result := m_JewelryList;
      4: Result := m_CharmList;
      5: Result := m_OtherList;
    end;
  end;
end;

function TSellEngine.GetTypeItemListA(wIndex: Word): TSellList;
begin
  Result := nil;
  case wIndex of
    1: Result := m_DressList;
    2: Result := m_WeaponList;
    3: Result := m_JewelryList;
    4: Result := m_CharmList;
    5: Result := m_OtherList;
  end;
end;

function TSellEngine.GetRecordCount: Integer;
begin
  Result := m_nRecordCount;
end;

function TSellEngine.GetHumManCount: Integer;
begin
  Result := m_CharSellList.Count;
end;

procedure TSellEngine.Rebuild;
var
  sTempFileName: string;
  nHandle, n10: Integer;
  DBRecord: TSellOffInfo;
  DBHeader: TItemCount;
begin
  sTempFileName := m_sFileName + 'UserStorage#$00.db';
  if FileExists(sTempFileName) then
    DeleteFile(sTempFileName);
  nHandle := FileCreate(sTempFileName);
  n10 := 0;
  if nHandle < 0 then Exit;
  try
    if Open then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        FileWrite(nHandle, DBHeader, SizeOf(TItemCount));
        while (True) do begin
          if FileRead(m_nFileHandle, DBRecord, SizeOf(TSellOffInfo)) = SizeOf(TSellOffInfo) then begin
            if (DBRecord.sCharName = '') or (DBRecord.UserItem.wIndex = 0) then Continue;
            FileWrite(nHandle, DBRecord, SizeOf(TSellOffInfo));
            Inc(n10);
          end else Break;
        end;
        DBHeader := n10;
        FileSeek(nHandle, 0, 0);
        FileWrite(nHandle, DBHeader, SizeOf(TSellOffInfo));
      end;
    end;
  finally
    Close;
  end;
  FileClose(nHandle);
  FileCopy(sTempFileName, m_sDBFileName);
  DeleteFile(sTempFileName);
end;

procedure TSellEngine.SaveToFile();
var
  DBRecord: pTSellOffInfo;
  DBHeader: TItemCount;
  List: TSellList;
  I, II: Integer;
  nHandle: Integer;
  sTempFileName: string;
begin
  Lock;
  try
    sTempFileName := m_sFileName + 'UserStorage#$00.db';
    if FileExists(sTempFileName) then DeleteFile(sTempFileName);
    nHandle := FileCreate(sTempFileName);
    if nHandle < 0 then Exit;
    DBHeader := 0;
    for I := 0 to m_CharSellList.Count - 1 do begin
      List := TSellList(m_CharSellList.Objects[I]);
      Inc(DBHeader, List.Count);
    end;
    FileSeek(nHandle, 0, 0);
    FileWrite(nHandle, DBHeader, SizeOf(TItemCount));
    for I := 0 to m_CharSellList.Count - 1 do begin
      List := TSellList(m_CharSellList.Objects[I]);
      for II := 0 to List.Count - 1 do begin
        DBRecord := pTSellOffInfo(List.Objects[II]);
        FileWrite(nHandle, DBRecord^, SizeOf(TSellOffInfo));
        if Application.Terminated then begin
          Close;
          Exit;
        end;
      end;
    end;
    FileClose(nHandle);
    FileCopy(sTempFileName, m_sDBFileName);
    DeleteFile(sTempFileName);
    LoadSellList();
  finally
    UnLock; ;
  end;
end;

procedure TSellEngine.GetSellList(var SellList: TStringList);
var
  I: Integer;
  List: TSellList;
begin
  Lock();
  try
    if SellList <> nil then begin
      SellList.Clear;
      for I := 0 to m_ItemSellList.Count - 1 do begin
        List := TSellList(m_ItemSellList.Objects[I]);
        if List.Count > 0 then begin
          SellList.AddObject(m_ItemSellList.Strings[I], List.Objects[0]);
        end;
      end;
    end;
  finally
    UnLock();
  end;
end;

function TSellEngine.GetSellListByCharName(sCharName: string; var SellList: TSellList): Integer;
begin
  Lock();
  try
    Result := m_CharSellList.GetSellList(sCharName, SellList);
  finally
    UnLock();
  end;
end;

function TSellEngine.GetSellListByItemName(sItemName: string; var SellList: TSellList): Integer;
begin
  Lock();
  try
    Result := m_ItemSellList.GetSellList(sItemName, SellList);
  finally
    UnLock();
  end;
end;

function TSellEngine.Add(SellOffInfo: pTSellOffInfo): Boolean;
var
  sUserItemName: string;
begin
  Lock();
  try
    if UpDate(SellOffInfo, True) then begin
      m_CharSellList.AddRecord(SellOffInfo.sCharName, SellOffInfo);
      sUserItemName := UserEngine.GetStdItemName(SellOffInfo.UserItem.wIndex);
      m_ItemSellList.AddRecord(sUserItemName, SellOffInfo);
      AddItem(SellOffInfo);
      Result := True;
    end else begin
      Dispose(SellOffInfo);
      Result := False;
    end;
  finally
    UnLock();
  end;
end;

function TSellEngine.Add(sChrName: string; UserItem: pTUserItem; nSellGold: Integer): Boolean;
var
  SellOffInfo: pTSellOffInfo;
begin
  New(SellOffInfo);
  FillChar(SellOffInfo^, SizeOf(TSellOffInfo), #0);
  SellOffInfo.sCharName := sChrName;
  SellOffInfo.dSellDateTime := Now;
  SellOffInfo.nSellGold := nSellGold;
  SellOffInfo.UserItem := UserItem^;
  {FillChar(SellOffInfo.UseItems, SizeOf(TUserItem), #0);
  SellOffInfo.UseItems := UserItem^;
  SellOffInfo.UseItems.btValue := UserItem.btValue;
  SellOffInfo.UseItems.AddValue := UserItem.AddValue; }
  //MainOutMessage('UserItem.AddValue ' + Format('%d/%d/%d', [UserItem.AddValue[4], UserItem.AddValue[5], UserItem.AddValue[6]]));
  {Move(UserItem.btValue, SellOffInfo.UseItems.btValue, SizeOf(TValue));
  Move(UserItem.AddValue, SellOffInfo.UseItems.AddValue, SizeOf(TValue)); }
  SellOffInfo.nIndex := -1;
  Result := Add(SellOffInfo);
  if not Result then begin
    Dispose(SellOffInfo);
  end;
   { if UpDate(SellOffInfo, True) then begin
      m_CharSellList.AddRecord(sChrName, SellOffInfo);
      sUserItemName := UserEngine.GetStdItemName(SellOffInfo.UseItems.wIndex);
      m_ItemSellList.AddRecord(sUserItemName, SellOffInfo);
      AddItem(SellOffInfo);
      Result := True;
    end else begin
      Dispose(SellOffInfo);
      Result := False;
    end; }
end;

function TSellEngine.Delete(SellOffInfo: pTSellOffInfo; boFree: Boolean): Boolean;
var
  sUserItemName: string;
begin
  sUserItemName := UserEngine.GetStdItemName(SellOffInfo.UserItem.wIndex);
  Result := Delete(SellOffInfo.sCharName, SellOffInfo.UserItem.MakeIndex, sUserItemName, boFree);
end;

function TSellEngine.Delete(sChrName: string; nMakeIndex: Integer; sItemName: string; boFree: Boolean): Boolean;
var
  SellList: TSellList;
  ItemList: TSellList;
  SellOffInfo: pTSellOffInfo;
  I: Integer;
  nCharIndex, nItemIndex: Integer;
begin
  Lock();
  try
    Result := False;
    nCharIndex := m_CharSellList.GetSellList(sChrName, SellList);
    nItemIndex := m_ItemSellList.GetSellList(sItemName, ItemList);
    if (nCharIndex >= 0) and (nItemIndex >= 0) then begin
      for I := ItemList.Count - 1 downto 0 do begin
        SellOffInfo := pTSellOffInfo(ItemList.Objects[I]);
        if SellOffInfo.UserItem.MakeIndex = nMakeIndex then begin
          ItemList.Delete(I);
          DelItem(SellOffInfo);
          Result := SellList.DelRecord(nMakeIndex, sItemName, boFree);
          Break;
        end;
      end;
      if ItemList.Count <= 0 then begin
        ItemList.Free;
        m_ItemSellList.Delete(nItemIndex);
      end;
      if SellList.Count <= 0 then begin
        SellList.Free;
        m_CharSellList.Delete(nCharIndex);
      end;
    end;
  finally
    UnLock();
  end;
end;

procedure TSellEngine.Delete(nIndex: Integer);
begin
  Lock();
  try
    if (nIndex >= 0) and (nIndex < m_CharSellList.Count) then begin
      m_CharSellList.Delete(nIndex);
    end;
  finally
    UnLock();
  end;
end;

function TSellEngine.GetItem(nMakeIndex: Integer; sItemName: string; var SellOffInfo: pTSellOffInfo): Integer;
var
  SellList: TSellList;
begin
  Lock();
  try
    Result := -1;
    if (m_ItemSellList.GetSellList(sItemName, SellList) >= 0) and (SellList <> nil) then begin
      Result := SellList.GetItem(nMakeIndex, sItemName, SellOffInfo);
    end;
  finally
    UnLock();
  end;
end;

function TSellEngine.GetItem(sChrName: string; nMakeIndex: Integer; sItemName: string; var SellOffInfo: pTSellOffInfo): Integer;
var
  SellList: TSellList;
begin
  Lock();
  try
    Result := -1;
    if (m_CharSellList.GetSellList(sChrName, SellList) >= 0) and (SellList <> nil) then begin
      Result := SellList.GetItem(nMakeIndex, sItemName, SellOffInfo);
    end;
  finally
    UnLock();
  end;
end;

function TSellEngine.GetItem(sChrName: string; nMakeIndex: Integer; sItemName: string; var UserItem: TUserItem; var nSellGold: Integer): Integer;
var
  SellList: TSellList;
begin
  Lock();
  try
    Result := -1;
    if m_CharSellList.GetSellList(sChrName, SellList) >= 0 then begin
      Result := SellList.GetItem(nMakeIndex, sItemName, UserItem, nSellGold);
    end;
  finally
    UnLock();
  end;
end;


{TSellManageList}

function TSellManageList.AddRecord(sName: string; SellOffInfo: pTSellOffInfo): TSellList;
var
  ChrList: TSellList;
  nLow, nHigh, nMed, n1C, n20: Integer;
begin
  ChrList := nil;
  if Count = 0 then begin
    ChrList := TSellList.Create;
    ChrList.m_sName := sName;
    ChrList.m_SellEngine := m_SellEngine;
    ChrList.AddObject(sName, TObject(SellOffInfo));
    AddObject(sName, ChrList);
  end else begin
    if Count = 1 then begin
      nMed := CompareStr(sName, Self.Strings[0]);
      if nMed > 0 then begin
        ChrList := TSellList.Create;
        ChrList.m_sName := sName;
        ChrList.m_SellEngine := m_SellEngine;
        ChrList.AddObject(sName, TObject(SellOffInfo));
        AddObject(sName, ChrList);
        Result := ChrList;
      end else begin
        if nMed < 0 then begin
          ChrList := TSellList.Create;
          ChrList.m_sName := sName;
          ChrList.m_SellEngine := m_SellEngine;
          ChrList.AddObject(sName, TObject(SellOffInfo));
          InsertObject(0, sName, ChrList);
        end else begin
          ChrList := TSellList(Self.Objects[0]);
          ChrList.AddObject(sName, TObject(SellOffInfo));
        end;
      end;
    end else begin
      nLow := 0;
      nHigh := Self.Count - 1;
      nMed := (nHigh - nLow) div 2 + nLow;
      while (True) do begin
        if (nHigh - nLow) = 1 then begin
          n20 := CompareStr(sName, Self.Strings[nHigh]);
          if n20 > 0 then begin
            ChrList := TSellList.Create;
            ChrList.m_sName := sName;
            ChrList.m_SellEngine := m_SellEngine;
            ChrList.AddObject(sName, TObject(SellOffInfo));
            InsertObject(nHigh + 1, sName, ChrList);
            Break;
          end else begin
            if CompareStr(sName, Self.Strings[nHigh]) = 0 then begin
              ChrList := TSellList(Self.Objects[nHigh]);
              ChrList.AddObject(sName, TObject(SellOffInfo));
              Break;
            end else begin
              n20 := CompareStr(sName, Self.Strings[nLow]);
              if n20 > 0 then begin
                ChrList := TSellList.Create;
                ChrList.m_sName := sName;
                ChrList.m_SellEngine := m_SellEngine;
                ChrList.AddObject(sName, TObject(SellOffInfo));
                InsertObject(nLow + 1, sName, ChrList);
                Break;
              end else begin
                if n20 < 0 then begin
                  ChrList := TSellList.Create;
                  ChrList.m_sName := sName;
                  ChrList.m_SellEngine := m_SellEngine;
                  ChrList.AddObject(sName, TObject(SellOffInfo));
                  InsertObject(nLow, sName, ChrList);
                  Break;
                end else begin
                  ChrList := TSellList(Self.Objects[n20]);
                  ChrList.AddObject(sName, TObject(SellOffInfo));
                  Break;
                end;
              end;
            end;
          end;
        end else begin
          n1C := CompareStr(sName, Self.Strings[nMed]);
          if n1C > 0 then begin
            nLow := nMed;
            nMed := (nHigh - nLow) div 2 + nLow;
            Continue;
          end;
          if n1C < 0 then begin
            nHigh := nMed;
            nMed := (nHigh - nLow) div 2 + nLow;
            Continue;
          end;
          ChrList := TSellList(Self.Objects[nMed]);
          ChrList.m_sName := sName;
          ChrList.m_SellEngine := m_SellEngine;
          ChrList.AddObject(sName, TObject(SellOffInfo));
          Break;
        end;
      end;
    end;
  end;
  Result := ChrList;
end;

procedure TSellManageList.DelRecord(sName: string; nMakeIndex: Integer);
var
  SellOffInfo: pTSellOffInfo;
  SellList: TSellList;
  I, nIndex: Integer;
begin
  nIndex := GetSellList(sName, SellList);
  if (nIndex >= 0) and (SellList <> nil) then begin
    for I := SellList.Count - 1 downto 0 do begin
      SellOffInfo := pTSellOffInfo(SellList.Objects[I]);
      if SellOffInfo.UserItem.MakeIndex = nMakeIndex then begin
        Dispose(SellOffInfo);
        SellList.Delete(I);
        Break;
      end;
    end;
    if SellList.Count <= 0 then begin
      SellList.Free;
      Self.Delete(nIndex);
    end;
  end;
end;

procedure TSellManageList.DelRecord(nIndex, nMakeIndex: Integer);
var
  SellOffInfo: pTSellOffInfo;
  SellList: TSellList;
  I: Integer;
begin
  if (Self.Count - 1) < nIndex then Exit;
  SellList := TSellList(Self.Objects[nIndex]);
  for I := SellList.Count - 1 downto 0 do begin
    SellOffInfo := pTSellOffInfo(SellList.Objects[I]);
    if SellOffInfo.UserItem.MakeIndex = nMakeIndex then begin
      SellList.Delete(I);
      Dispose(SellOffInfo);
      Break;
    end;
  end;
  if SellList.Count <= 0 then begin
    SellList.Free;
    Self.Delete(nIndex);
  end;
end;

function TSellManageList.GetSellList(sName: string;
  var SellList: TSellList): Integer;
var
  nHigh, nLow, nMed, n20, n24: Integer;
  sAccount: string;
begin
  Result := -1;
  if Self.Count = 0 then Exit;
  if Self.Count = 1 then begin
    if CompareStr(sName, Self.Strings[0]) = 0 then begin
      SellList := TSellList(Self.Objects[0]);
      Result := 0;
    end;
  end else begin
    nLow := 0;
    nHigh := Self.Count - 1;
    nMed := (nHigh - nLow) div 2 + nLow;
    n24 := -1;
    while (True) do begin
      if (nHigh - nLow) = 1 then begin
        if CompareStr(sName, Self.Strings[nHigh]) = 0 then n24 := nHigh;
        if CompareStr(sName, Self.Strings[nLow]) = 0 then n24 := nLow;
        Break;
      end else begin
        n20 := CompareStr(sName, Self.Strings[nMed]);
        if n20 > 0 then begin
          nLow := nMed;
          nMed := (nHigh - nLow) div 2 + nLow;
          Continue;
        end;
        if n20 < 0 then begin
          nHigh := nMed;
          nMed := (nHigh - nLow) div 2 + nLow;
          Continue;
        end;
        n24 := nMed;
        Break;
      end;
    end;
    if n24 <> -1 then SellList := TSellList(Self.Objects[n24]);
    Result := n24;
  end;
end;

{TSellList}

constructor TSellList.Create();
begin
  m_SellEngine := nil;
  m_sName := '';
end;

destructor TSellList.Destroy;
begin

end;

function TSellList.GetIndex(sName: string): Integer;
var
  nLow, nHigh, nMed, nCompareVal: Integer;
  s: string;
begin
  Result := -1;
  if Self.Count <> 0 then begin
    if Self.Sorted then begin
      if Self.Count = 1 then begin
        if CompareStr(sName, Self.Strings[0]) = 0 then Result := 0;
      end else begin
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            if CompareStr(sName, Self.Strings[nHigh]) = 0 then Result := nHigh;
            if CompareStr(sName, Self.Strings[nLow]) = 0 then Result := nLow;
            Break;
          end else begin
            nCompareVal := CompareStr(sName, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := nMed;
            Break;
          end;
        end;
      end;
    end else begin
      if Self.Count = 1 then begin
        if CompareText(sName, Self.Strings[0]) = 0 then Result := 0;
      end else begin
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            if CompareText(sName, Self.Strings[nHigh]) = 0 then Result := nHigh;
            if CompareText(sName, Self.Strings[nLow]) = 0 then Result := nLow;
            Break;
          end else begin
            nCompareVal := CompareText(sName, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := nMed;
            Break;
          end;
        end;
      end;
    end;
  end;
end;

procedure TSellList.SortString(nMIN, nMax: Integer);
var
  ntMin, ntMax: Integer;
  s18: string;
begin
  if Self.Count > 0 then
    while (True) do begin
      ntMin := nMIN;
      ntMax := nMax;
      s18 := Self.Strings[(nMIN + nMax) shr 1];
      while (True) do begin
        while (CompareText(Self.Strings[ntMin], s18) < 0) do Inc(ntMin);
        while (CompareText(Self.Strings[ntMax], s18) > 0) do Dec(ntMax);
        if ntMin <= ntMax then begin
          Self.Exchange(ntMin, ntMax);
          Inc(ntMin);
          Dec(ntMax);
        end;
        if ntMin > ntMax then Break
      end;
      if nMIN < ntMax then SortString(nMIN, ntMax);
      nMIN := ntMin;
      if ntMin >= nMax then Break;
    end;
end;

function TSellList.AddRecord(UserItem: pTUserItem; nSellGold: Integer): Boolean;
var
  SellOffInfo: pTSellOffInfo;
begin
  New(SellOffInfo);
  SellOffInfo.sCharName := m_sName;
  SellOffInfo.dSellDateTime := Now;
  SellOffInfo.UserItem := UserItem^;
  SellOffInfo.nSellGold := nSellGold;
  SellOffInfo.nIndex := -1;
  if m_SellEngine.UpDate(SellOffInfo, True) then begin
    Result := True;
  end else begin
    Dispose(SellOffInfo);
    Result := False;
  end;
end;

procedure TSellList.DeleteA(nIndex: Integer);
begin
  if (nIndex >= 0) and (nIndex < Self.Count) then begin
    Self.Delete(nIndex);
  end;
end;

function TSellList.DelRecord(nMakeIndex: Integer; sItemName: string; boFree: Boolean): Boolean;
var
  I: Integer;
  SellOffInfo: pTSellOffInfo;
  sUserItemName: string;
begin
  Result := False;
  for I := Self.Count - 1 downto 0 do begin
    SellOffInfo := pTSellOffInfo(Self.Objects[I]);
    if (SellOffInfo.UserItem.MakeIndex = nMakeIndex) and (SellOffInfo.sCharName <> '') and (SellOffInfo.UserItem.wIndex > 0) then begin
      sUserItemName := UserEngine.GetStdItemName(SellOffInfo.UserItem.wIndex);
      if CompareText(sUserItemName, sItemName) = 0 then begin
        if m_SellEngine.UpDate(SellOffInfo, False) then begin
          Self.Delete(I);
          if boFree then Dispose(SellOffInfo);
          Result := True;
        end else Result := False;
      end;
      Break;
    end;
  end;
end;

function TSellList.GetItem(nMakeIndex: Integer; sItemName: string; var SellOffInfo: pTSellOffInfo): Integer;
var
  I: Integer;
  StdItem: pTStdItem;
begin
  Result := -1;
  for I := 0 to Self.Count - 1 do begin
    SellOffInfo := pTSellOffInfo(Self.Objects[I]);
    StdItem := UserEngine.GetStdItem(SellOffInfo.UserItem.wIndex);
    if (StdItem <> nil) and (SellOffInfo.sCharName <> '') and (CompareText(StdItem.Name, sItemName) = 0) and ({(StdItem.StdMode <= 4) or
      (StdItem.StdMode = 42) or
      (StdItem.StdMode = 31) or }(SellOffInfo.UserItem.MakeIndex = nMakeIndex)) then begin
      Result := I;
      Break;
    end;
  end;
  if Result < 0 then SellOffInfo := nil;
end;

function TSellList.GetItem(nMakeIndex: Integer; sItemName: string; var UserItem: TUserItem; var nSellGold: Integer): Integer;
var
  SellOffInfo: pTSellOffInfo;
begin
  Result := GetItem(nMakeIndex, sItemName, SellOffInfo);
  nSellGold := -1;
  if SellOffInfo <> nil then begin
    nSellGold := SellOffInfo.nSellGold;
    UserItem := SellOffInfo.UserItem;
  end;
end;


{TUserSellManage}

constructor TUserSellManage.Create;
begin
  inherited;
  InitializeCriticalSection(m_UserCriticalSection);
  m_Header := 0;
  m_nFileHandle := 0;
  m_nRecordCount := 0;
  m_sFileName := '';
  m_sDBFileName := '';
  m_DeletedList := TList.Create;
end;

destructor TUserSellManage.Destroy;
begin
  m_DeletedList.Free;
  DeleteCriticalSection(m_UserCriticalSection);
  inherited;
end;

procedure TUserSellManage.Lock();
begin
  EnterCriticalSection(m_UserCriticalSection);
end;

procedure TUserSellManage.UnLock();
begin
  LeaveCriticalSection(m_UserCriticalSection);
end;

procedure TUserSellManage.Close;
begin
  FileClose(m_nFileHandle);
  UnLock();
end;

function TUserSellManage.Open: Boolean;
begin
  Lock();
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

function TUserSellManage.OpenEx: Boolean;
var
  DBHeader: TItemCount;
begin
  Lock();
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := True;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then
      m_Header := DBHeader;
  end else Result := False;
end;

function TUserSellManage.UpDate(SellOffInfo: pTSellOffInfo; boNew: Boolean): Boolean;
var
  nIndex: Integer;
  nPosion, n10: Integer;
begin
  try
    Result := False;
    if Open then begin
      if boNew then begin
        if m_DeletedList.Count > 0 then begin
          nIndex := Integer(m_DeletedList.Items[0]);
          m_DeletedList.Delete(0);
        end else begin
          nIndex := m_Header;
          Inc(m_Header);
        end;
        SellOffInfo.nIndex := nIndex;
        nPosion := nIndex * SizeOf(TSellOffInfo) + SizeOf(TItemCount);
        if FileSeek(m_nFileHandle, nPosion, 0) = nPosion then begin
          n10 := FileSeek(m_nFileHandle, 0, 1);
          FileSeek(m_nFileHandle, 0, 0);
          FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
          FileSeek(m_nFileHandle, n10, 0);
          FileWrite(m_nFileHandle, SellOffInfo^, SizeOf(TSellOffInfo));
          FileSeek(m_nFileHandle, -SizeOf(TSellOffInfo), 1);
          Result := True;
        end else Result := False;
      end else begin
        if FileSeek(m_nFileHandle, SellOffInfo.nIndex * SizeOf(TSellOffInfo) + SizeOf(TItemCount), 0) <> -1 then begin
          SellOffInfo.UserItem.wIndex := 0;
          SellOffInfo.sCharName := '';
          FileWrite(m_nFileHandle, SellOffInfo^, SizeOf(TSellOffInfo));
          m_DeletedList.Add(Pointer(SellOffInfo.nIndex));
          Result := True;
        end else Result := False;
      end;
    end;
  finally
    Close();
  end;
end;

end.
