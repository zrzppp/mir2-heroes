unit StorageEngn;

interface
uses
  Windows, Classes, SysUtils, Grobal2, SDK, Forms;
type
  TStorageEngine = class;

  TStorageList = class(TList)
    m_sCharName: string;
    m_StorageEngine: TStorageEngine;
  public
    constructor Create();
    destructor Destroy; override;
    function AddRecord(UserItem: pTUserItem): Boolean;
    function DelRecord(nMakeIndex: Integer; sItemName: string): Boolean; overload;
    function DelRecord(Storage: pTBigStorage): Boolean; overload;

    function DeleteA(nIndex: Integer): Boolean;
    function GetItem(nMakeIndex: Integer; sItemName: string; var UserItem: TUserItem): Integer;
  end;

  TSQuickList = class(TStringList)
    m_StorageEngine: TStorageEngine;
  public
    function AddRecord(sCharName: string; BigStorage: pTBigStorage): TStorageList;
    procedure DelRecord(nIndex, nMakeIndex: Integer); overload;
    procedure DelRecord(sCharName: string; nMakeIndex: Integer); overload;
    function GetItemList(sCharName: string; var ItemList: TStorageList): Integer;
  end;

  TStorageEngine = class
    m_UserCriticalSection: TRTLCriticalSection;
    m_Header: TItemCount;
    m_nFileHandle: Integer;
    m_sFileName: string;
    m_sDBFileName: string;
    m_StorageList: TSQuickList;
    m_DeletedList: TList; //已被删除的记录号
    m_nRecordCount: Integer;
  private
    function GetRecordCount: Integer;
    function GetHumManCount: Integer;
    procedure SaveToFile();
  public
    constructor Create();
    destructor Destroy; override;
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Lock();
    procedure UnLock();
    procedure Close();
    procedure LoadStorageList();
    procedure UnLoadStorageList();
    procedure UpDateStorageList;
    function UpDate(BigStorage: pTBigStorage; boNew: Boolean): Boolean;
    function Add(sChrName: string; UserItem: pTUserItem): Boolean;
    function Delete(sChrName: string; nMakeIndex: Integer; sItemName: string): Boolean; overload;
    procedure Delete(nIndex: Integer); overload;
    function Delete(sChrName: string; UserItem: pTUserItem): Boolean; overload;
    function Delete(sChrName: string; Storage: pTBigStorage): Boolean; overload;
    function GetStorageList(sChrName: string; var StorageList: TStorageList): Integer;
    function GetItem(sChrName: string; nMakeIndex: Integer; sItemName: string; var UserItem: TUserItem): Integer;
    procedure Rebuild;
    property RecordCount: Integer read GetRecordCount;
    property HumManCount: Integer read GetHumManCount;
  end;
implementation
uses
  M2Share, RunDB, ObjBase, HUtil32;

constructor TStorageEngine.Create;
begin
  inherited;
  InitializeCriticalSection(m_UserCriticalSection);
  m_Header := 0;
  m_nFileHandle := 0;
  m_nRecordCount := 0;
  if g_Config.sEnvirDir[Length(g_Config.sEnvirDir)] = '\' then
    m_sFileName := g_Config.sEnvirDir + 'Market_Storage\'
  else
    m_sFileName := g_Config.sEnvirDir + '\Market_Storage\';

  if not DirectoryExists(m_sFileName) then begin
    ForceDirectories(m_sFileName);
  end;
  m_sDBFileName := m_sFileName + 'UserStorage.db';
  m_StorageList := TSQuickList.Create;
  m_DeletedList := TList.Create;
  m_StorageList.m_StorageEngine := Self;
end;

destructor TStorageEngine.Destroy;
begin
  UnLoadStorageList();
  m_DeletedList.Free;
  m_StorageList.Free;
  DeleteCriticalSection(m_UserCriticalSection);
  inherited;
end;

procedure TStorageEngine.Lock();
begin
  EnterCriticalSection(m_UserCriticalSection);
end;

procedure TStorageEngine.UnLock();
begin
  LeaveCriticalSection(m_UserCriticalSection);
end;

procedure TStorageEngine.UnLoadStorageList();
var
  I, II: Integer;
  ItemList: TStorageList;
  BigStorage: pTBigStorage;
begin
  for I := 0 to m_StorageList.Count - 1 do begin
    ItemList := TStorageList(m_StorageList.Objects[I]);
    for II := 0 to ItemList.Count - 1 do begin
      BigStorage := ItemList.Items[II];
      Dispose(BigStorage);
    end;
    ItemList.Free;
  end;
  m_StorageList.Clear;
end;

procedure TStorageEngine.UpDateStorageList;
var
  I: Integer;
  nCount: Integer;
  ItemList: TStorageList;
begin
  Lock();
  try
    nCount := 0;
    for I := m_StorageList.Count - 1 downto 0 do begin
      ItemList := TStorageList(m_StorageList.Objects[I]);
      if ItemList.Count <= 0 then begin
        ItemList.Free;
        m_StorageList.Delete(I);
      end else begin
        Inc(nCount, ItemList.Count);
      end;
    end;
    if nCount < m_Header div 2 then begin
      //SaveToFile();
    end;
  finally
    UnLock();
  end;
end;

procedure TStorageEngine.LoadStorageList();
var
  nIndex: Integer;
  DBHeader: TItemCount;
  DBRecord: pTBigStorage;
begin
  UnLoadStorageList();
  m_DeletedList.Clear;
  try
    if Open then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        for nIndex := 0 to DBHeader - 1 do begin
          New(DBRecord);
          FillChar(DBRecord^, SizeOf(TBigStorage), #0);
          if FileRead(m_nFileHandle, DBRecord^, SizeOf(TBigStorage)) <> SizeOf(TBigStorage) then begin
            Dispose(DBRecord);
            Break;
          end;

          if (DBRecord.UserItem.AddValue[0] = 1) and (GetDayCount(DBRecord.UserItem.MaxDate, Now) <= 0) then begin //删除到期装备
            DBRecord.boDelete := True;
          end;

          if not DBRecord.boDelete then begin
            Inc(m_nRecordCount);
            DBRecord.nIndex := nIndex;
            m_StorageList.AddRecord(DBRecord.sCharName, DBRecord);
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

procedure TStorageEngine.Rebuild;
var
  sTempFileName: string;
  nHandle, n10: Integer;
  DBRecord: TBigStorage;
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
          if FileRead(m_nFileHandle, DBRecord, SizeOf(TBigStorage)) = SizeOf(TBigStorage) then begin
            if DBRecord.boDelete then Continue;
            FileWrite(nHandle, DBRecord, SizeOf(TBigStorage));
            Inc(n10);
          end else Break;
        end;
        DBHeader := n10;
        FileSeek(nHandle, 0, 0);
        FileWrite(nHandle, DBHeader, SizeOf(TBigStorage));
      end;
    end;
  finally
    Close;
  end;
  FileClose(nHandle);
  FileCopy(sTempFileName, m_sDBFileName);
  DeleteFile(sTempFileName);
end;

procedure TStorageEngine.SaveToFile();
var
  DBRecord: pTBigStorage;
  DBHeader: TItemCount;
  List: TStorageList;
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
    for I := 0 to m_StorageList.Count - 1 do begin
      List := TStorageList(m_StorageList.Objects[I]);
      Inc(DBHeader, List.Count);
    end;
    FileSeek(nHandle, 0, 0);
    FileWrite(nHandle, DBHeader, SizeOf(TItemCount));
    for I := 0 to m_StorageList.Count - 1 do begin
      List := TStorageList(m_StorageList.Objects[I]);
      for II := 0 to List.Count - 1 do begin
        DBRecord := pTBigStorage(List.Items[II]);
        FileWrite(nHandle, DBRecord^, SizeOf(TBigStorage));
        if Application.Terminated then begin
          Close;
          Exit;
        end;
      end;
    end;
    FileClose(nHandle);
    FileCopy(sTempFileName, m_sDBFileName);
    DeleteFile(sTempFileName);
    LoadStorageList();
  finally
    UnLock; ;
  end;
end;

function TStorageEngine.GetStorageList(sChrName: string; var StorageList: TStorageList): Integer;
begin
  Lock();
  try
    Result := m_StorageList.GetItemList(sChrName, StorageList);
  finally
    UnLock();
  end;
end;

function TStorageEngine.GetRecordCount: Integer;
begin
  Result := m_nRecordCount;
end;

function TStorageEngine.GetHumManCount: Integer;
begin
  Result := m_StorageList.Count;
end;

procedure TStorageEngine.Close;
begin
  FileClose(m_nFileHandle);
  UnLock();
end;

function TStorageEngine.Open: Boolean;
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

function TStorageEngine.OpenEx: Boolean;
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

function TStorageEngine.UpDate(BigStorage: pTBigStorage; boNew: Boolean): Boolean;
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
        BigStorage.nIndex := nIndex;
        nPosion := nIndex * SizeOf(TBigStorage) + SizeOf(TItemCount);
        if FileSeek(m_nFileHandle, nPosion, 0) = nPosion then begin
          n10 := FileSeek(m_nFileHandle, 0, 1);
          FileSeek(m_nFileHandle, 0, 0);
          FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
          FileSeek(m_nFileHandle, n10, 0);
          FileWrite(m_nFileHandle, BigStorage^, SizeOf(TBigStorage));
          FileSeek(m_nFileHandle, -SizeOf(TBigStorage), 1);
          Result := True;
        end else Result := False;
      end else begin
        if FileSeek(m_nFileHandle, BigStorage.nIndex * SizeOf(TBigStorage) + SizeOf(TItemCount), 0) <> -1 then begin
          BigStorage.boDelete := True;
          FileWrite(m_nFileHandle, BigStorage^, SizeOf(TBigStorage));
          m_DeletedList.Add(Pointer(BigStorage.nIndex));
          Result := True;
        end else Result := False;
      end;
    end;
  finally
    Close();
  end;
end;

function TStorageEngine.Add(sChrName: string; UserItem: pTUserItem): Boolean;
var
  BigStorage: pTBigStorage;
begin
  Lock();
  try
    New(BigStorage);
    BigStorage.boDelete := False;
    BigStorage.sCharName := sChrName;
    BigStorage.SaveDateTime := Now;
    BigStorage.UserItem := UserItem^;
    BigStorage.nIndex := -1;
    if UpDate(BigStorage, True) then begin
      m_StorageList.AddRecord(sChrName, BigStorage);
      Result := True;
    end else begin
      Dispose(BigStorage);
      Result := False;
    end;
  finally
    UnLock();
  end;
end;

function TStorageEngine.Delete(sChrName: string; nMakeIndex: Integer; sItemName: string): Boolean;
var
  StorageList: TStorageList;
begin
  Lock();
  try
    Result := False;
    if m_StorageList.GetItemList(sChrName, StorageList) >= 0 then begin
      Result := StorageList.DelRecord(nMakeIndex, sItemName);
    end;
  finally
    UnLock();
  end;
end;

function TStorageEngine.Delete(sChrName: string; UserItem: pTUserItem): Boolean;
var
  StorageList: TStorageList;
begin
  Lock();
  try
    Result := False;
    if m_StorageList.GetItemList(sChrName, StorageList) >= 0 then begin
      Result := StorageList.DelRecord(UserItem.MakeIndex, UserEngine.GetStdItemName(UserItem.wIndex));
    end;
  finally
    UnLock();
  end;
end;

function TStorageEngine.Delete(sChrName: string; Storage: pTBigStorage): Boolean;
var
  nIndex: Integer;
  StorageList: TStorageList;
begin
  Lock();
  try
    Result := False;
    nIndex := m_StorageList.GetItemList(sChrName, StorageList);
    if (nIndex >= 0) and (StorageList <> nil) then begin
      Result := StorageList.DelRecord(Storage);
      if StorageList.Count <= 0 then begin
        StorageList.Free;
        m_StorageList.Delete(nIndex);
      end;
    end;

  finally
    UnLock();
  end;
end;

procedure TStorageEngine.Delete(nIndex: Integer);
begin
  Lock();
  try
    if (nIndex >= 0) and (nIndex < m_StorageList.Count) then begin
      m_StorageList.Delete(nIndex);
    end;
  finally
    UnLock();
  end;
end;

function TStorageEngine.GetItem(sChrName: string; nMakeIndex: Integer; sItemName: string; var UserItem: TUserItem): Integer;
var
  StorageList: TStorageList;
begin
  Lock();
  try
    Result := -1;
    if m_StorageList.GetItemList(sChrName, StorageList) >= 0 then begin
      Result := StorageList.GetItem(nMakeIndex, sItemName, UserItem);
    end;
  finally
    UnLock();
  end;
end;

{TStorageList}

constructor TStorageList.Create();
begin
  m_StorageEngine := nil;
  m_sCharName := '';
end;

destructor TStorageList.Destroy;
begin

end;

function TStorageList.AddRecord(UserItem: pTUserItem): Boolean;
var
  BigStorage: pTBigStorage;
begin
  New(BigStorage);
  BigStorage.boDelete := False;
  BigStorage.sCharName := m_sCharName;
  BigStorage.SaveDateTime := Now;
  BigStorage.UserItem := UserItem^;
  BigStorage.nIndex := -1;
  if m_StorageEngine.UpDate(BigStorage, True) then begin
    Result := True;
  end else begin
    Dispose(BigStorage);
    Result := False;
  end;
end;

function TStorageList.DeleteA(nIndex: Integer): Boolean;
var
  BigStorage: pTBigStorage;
begin
  Result := False;
  if (nIndex >= 0) and (nIndex < Self.Count) then begin
    BigStorage := pTBigStorage(Self.Items[nIndex]);
    if m_StorageEngine.UpDate(BigStorage, False) then begin
      Self.Delete(nIndex);
      Dispose(BigStorage);
      Result := True;
    end;
  end;
end;

function TStorageList.DelRecord(nMakeIndex: Integer; sItemName: string): Boolean;
var
  I: Integer;
  BigStorage: pTBigStorage;
  sUserItemName: string;
begin
  Result := False;
  for I := Self.Count - 1 downto 0 do begin
    BigStorage := pTBigStorage(Self.Items[I]);
    if (BigStorage.UserItem.MakeIndex = nMakeIndex) and (not BigStorage.boDelete) then begin
     { sUserItemName := '';
      if BigStorage.UseItems.btValue[13] = 1 then
        sUserItemName := ItemUnit.GetCustomItemName(BigStorage.UseItems.MakeIndex, BigStorage.UseItems.wIndex);
      if sUserItemName = '' then  }
      sUserItemName := UserEngine.GetStdItemName(BigStorage.UserItem.wIndex);
      if CompareText(sUserItemName, sItemName) = 0 then begin
        if m_StorageEngine.UpDate(BigStorage, False) then begin
          Self.Delete(I);
          Dispose(BigStorage);
          Result := True;
        end else Result := False;
      end;
      Break;
    end;
  end;
end;

function TStorageList.DelRecord(Storage: pTBigStorage): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Self.Count - 1 downto 0 do begin
    if (pTBigStorage(Self.Items[I]) = Storage) then begin
      if m_StorageEngine.UpDate(Storage, False) then begin
        Self.Delete(I);
        Dispose(Storage);
        Result := True;
      end else Result := False;
      Break;
    end;
  end;
end;

function TStorageList.GetItem(nMakeIndex: Integer; sItemName: string; var UserItem: TUserItem): Integer;
var
  I: Integer;
  BigStorage: pTBigStorage;
begin
  Result := -1;
  for I := 0 to Self.Count - 1 do begin
    BigStorage := pTBigStorage(Self.Items[I]);
    if (BigStorage.UserItem.MakeIndex = nMakeIndex) and (not BigStorage.boDelete) then begin
      {sUserItemName := '';
      if BigStorage.UseItems.btValue[13] = 1 then
        sUserItemName := ItemUnit.GetCustomItemName(BigStorage.UseItems.MakeIndex, BigStorage.UseItems.wIndex);
      if sUserItemName = '' then
        sUserItemName := UserEngine.GetStdItemName(BigStorage.UseItems.wIndex);
      if CompareText(sUserItemName, sItemName) = 0 then begin    }
      UserItem := BigStorage.UserItem;
      Result := I;
     // end;
      Break;
    end;
  end;
end;

{TSQuickList}

function TSQuickList.AddRecord(sCharName: string; BigStorage: pTBigStorage): TStorageList;
var
  ChrList: TStorageList;
  nLow, nHigh, nMed, n1C, n20: Integer;
begin
  ChrList := nil;
  if Count = 0 then begin
    ChrList := TStorageList.Create;
    ChrList.m_sCharName := sCharName;
    ChrList.m_StorageEngine := m_StorageEngine;
    ChrList.Add(BigStorage);
    AddObject(sCharName, ChrList);
  end else begin
    if Count = 1 then begin
      nMed := CompareStr(sCharName, Self.Strings[0]);
      if nMed > 0 then begin
        ChrList := TStorageList.Create;
        ChrList.m_sCharName := sCharName;
        ChrList.m_StorageEngine := m_StorageEngine;
        ChrList.Add(BigStorage);
        AddObject(sCharName, ChrList);
        Result := ChrList;
      end else begin
        if nMed < 0 then begin
          ChrList := TStorageList.Create;
          ChrList.m_sCharName := sCharName;
          ChrList.m_StorageEngine := m_StorageEngine;
          ChrList.Add(BigStorage);
          InsertObject(0, sCharName, ChrList);
        end else begin
          ChrList := TStorageList(Self.Objects[0]);
          ChrList.Add(BigStorage);
        end;
      end;
    end else begin
      nLow := 0;
      nHigh := Self.Count - 1;
      nMed := (nHigh - nLow) div 2 + nLow;
      while (True) do begin
        if (nHigh - nLow) = 1 then begin
          n20 := CompareStr(sCharName, Self.Strings[nHigh]);
          if n20 > 0 then begin
            ChrList := TStorageList.Create;
            ChrList.m_sCharName := sCharName;
            ChrList.m_StorageEngine := m_StorageEngine;
            ChrList.Add(BigStorage);
            InsertObject(nHigh + 1, sCharName, ChrList);
            Break;
          end else begin
            if CompareStr(sCharName, Self.Strings[nHigh]) = 0 then begin
              ChrList := TStorageList(Self.Objects[nHigh]);
              ChrList.Add(BigStorage);
              Break;
            end else begin
              n20 := CompareStr(sCharName, Self.Strings[nLow]);
              if n20 > 0 then begin
                ChrList := TStorageList.Create;
                ChrList.m_sCharName := sCharName;
                ChrList.m_StorageEngine := m_StorageEngine;
                ChrList.Add(BigStorage);
                InsertObject(nLow + 1, sCharName, ChrList);
                Break;
              end else begin
                if n20 < 0 then begin
                  ChrList := TStorageList.Create;
                  ChrList.m_sCharName := sCharName;
                  ChrList.m_StorageEngine := m_StorageEngine;
                  ChrList.Add(BigStorage);
                  InsertObject(nLow, sCharName, ChrList);
                  Break;
                end else begin
                  ChrList := TStorageList(Self.Objects[n20]);
                  ChrList.Add(BigStorage);
                  Break;
                end;
              end;
            end;
          end;
        end else begin
          n1C := CompareStr(sCharName, Self.Strings[nMed]);
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
          ChrList := TStorageList(Self.Objects[nMed]);
          ChrList.m_sCharName := sCharName;
          ChrList.m_StorageEngine := m_StorageEngine;
          ChrList.Add(BigStorage);
          Break;
        end;
      end;
    end;
  end;
  Result := ChrList;
end;

procedure TSQuickList.DelRecord(sCharName: string; nMakeIndex: Integer);
var
  BigStorage: pTBigStorage;
  ItemList: TStorageList;
  I, nIndex: Integer;
begin
  nIndex := GetItemList(sCharName, ItemList);
  if (nIndex >= 0) and (ItemList <> nil) then begin
    for I := ItemList.Count - 1 downto 0 do begin
      BigStorage := ItemList.Items[I];
      if BigStorage.UserItem.MakeIndex = nMakeIndex then begin
        Dispose(BigStorage);
        ItemList.Delete(I);
        Break;
      end;
    end;
    if ItemList.Count <= 0 then begin
      ItemList.Free;
      Self.Delete(nIndex);
    end;
  end;
end;

procedure TSQuickList.DelRecord(nIndex, nMakeIndex: Integer);
var
  BigStorage: pTBigStorage;
  ItemList: TList;
  I: Integer;
begin
  if (Self.Count - 1) < nIndex then Exit;
  ItemList := TStorageList(Self.Objects[nIndex]);
  for I := ItemList.Count - 1 downto 0 do begin
    BigStorage := ItemList.Items[I];
    if BigStorage.UserItem.MakeIndex = nMakeIndex then begin
      Dispose(BigStorage);
      ItemList.Delete(I);
      Break;
    end;
  end;
  if ItemList.Count <= 0 then begin
    ItemList.Free;
    Self.Delete(nIndex);
  end;
end;

function TSQuickList.GetItemList(sCharName: string;
  var ItemList: TStorageList): Integer;
var
  nHigh, nLow, nMed, n20, n24: Integer;
begin
  Result := -1;
  if Self.Count = 0 then Exit;
  if Self.Count = 1 then begin
    if CompareStr(sCharName, Self.Strings[0]) = 0 then begin
      ItemList := TStorageList(Self.Objects[0]);
      Result := 0;
    end;
  end else begin
    nLow := 0;
    nHigh := Self.Count - 1;
    nMed := (nHigh - nLow) div 2 + nLow;
    n24 := -1;
    while (True) do begin
      if (nHigh - nLow) = 1 then begin
        if CompareStr(sCharName, Self.Strings[nHigh]) = 0 then n24 := nHigh;
        if CompareStr(sCharName, Self.Strings[nLow]) = 0 then n24 := nLow;
        Break;
      end else begin
        n20 := CompareStr(sCharName, Self.Strings[nMed]);
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
    if n24 <> -1 then ItemList := TStorageList(Self.Objects[n24]);
    Result := n24;
  end;
end;

end.
