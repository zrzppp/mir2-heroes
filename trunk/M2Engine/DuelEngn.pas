unit DuelEngn;

interface
uses
  Windows, Classes, SysUtils, Grobal2, SDK, Forms;

type
  TQuickStringList = class(TStringList)
  public
    procedure AddRecord(const s: string; Item: Pointer);
    procedure DelRecord(nIndex: Integer);
    function GetList(s: string; var List: TList): Integer;
  end;

  TDuelData = class
    m_UserCriticalSection: TRTLCriticalSection;
    m_Header: TItemCount;
    m_nFileHandle: Integer;
    m_sFileName: string;
    m_sDBFileName: string;
    m_DeletedList: TList; //已被删除的记录号
    m_nRecordCount: Integer;
  private
    procedure Lock();
    procedure UnLock();
    function WriteRecord(Index: Integer; const Buffer: Pointer; Count: Integer): Boolean;
    function DeleteRecord(Index: Integer; const Buffer: Pointer; Count: Integer): Boolean;
    function AddRecord(const Buffer: Pointer; Count: Integer): Boolean;
    procedure SetIndex(Buffer: Pointer; Index: Integer); virtual; abstract;
  public
    constructor Create(); virtual;
    destructor Destroy; override;
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
    procedure Load; virtual; abstract;
    procedure UnLoad; virtual; abstract;
  end;

  TDuelItemDB = class(TDuelData)
    m_ItemList: TQuickStringList;
  private
    procedure SetIndex(Buffer: Pointer; Index: Integer); override;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Load; override;
    procedure UnLoad; override;
  end;

  TDuelInfoDB = class(TDuelData)
    m_OwnerList: TQuickStringList;
    m_DuelList: TQuickStringList;
  private
    procedure SetIndex(Buffer: Pointer; Index: Integer); override;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Load; override;
    procedure UnLoad; override;
  end;

  TDuelEngine = class
    m_DuelInfo: TDuelInfoDB;
    m_DuelItem: TDuelItemDB;
  private

  public
    constructor Create();
    destructor Destroy; override;
    procedure Initialize();
    function GetDuel(const btDuel: Byte; var sCharName1, sCharName2: string; var nIndex1, nIndex2: Integer): Boolean;
    function AddDuel(const btDuel: Byte; const sCharName1, sCharName2: string; const nDuelGold1, nDuelGold2: Integer): Boolean;
    function AddItem(const sCharName1, sCharName2: string; UserItem: pTUserItem): Boolean;
    procedure Defeat(const sCharName1, sCharName2: string); //失败
    function GetItems(const sCharName: string; List: TList; var nGold: Integer): Boolean;
  end;
implementation
uses
  M2Share, RunDB, ObjBase, HUtil32;

{TDuelEngine}

constructor TDuelEngine.Create();
begin
  inherited;
  m_DuelInfo := TDuelInfoDB.Create;
  m_DuelItem := TDuelItemDB.Create;
end;

destructor TDuelEngine.Destroy;
begin
  m_DuelInfo.Free;
  m_DuelItem.Free;
  inherited;
end;

procedure TDuelEngine.Initialize();
begin
  m_DuelInfo.Load;
  m_DuelItem.Load;
end;

function TDuelEngine.GetDuel(const btDuel: Byte; var sCharName1, sCharName2: string; var nIndex1, nIndex2: Integer): Boolean;
var
  I: Integer;
  List: TList;
  sCharName: string;
  DuelInfo: pTDuelInfo;
begin
  Result := False;
  nIndex1 := m_DuelInfo.m_OwnerList.GetList(sCharName1, List);
  nIndex2 := m_DuelInfo.m_DuelList.GetList(sCharName2, List);
  if (nIndex1 >= 0) and (nIndex2 >= 0) then begin
    List := TList(m_DuelInfo.m_OwnerList.Objects[nIndex1]);
    for I := 0 to List.Count - 1 do begin
      DuelInfo := pTDuelInfo(List.Items[I]);
      if (DuelInfo.Owner.sCharName = sCharName1) and (DuelInfo.Duel.sCharName = sCharName2) then begin
        if not DuelInfo.boFinish then begin
          Result := True;
          Exit;
        end;
      end;
    end;
    //Exit;
  end;

  nIndex1 := m_DuelInfo.m_OwnerList.GetList(sCharName2, List);
  nIndex2 := m_DuelInfo.m_DuelList.GetList(sCharName1, List);
  if (nIndex1 >= 0) and (nIndex2 >= 0) then begin
    sCharName := sCharName1;
    sCharName1 := sCharName2;
    sCharName2 := sCharName;

    List := TList(m_DuelInfo.m_OwnerList.Objects[nIndex1]);
    for I := 0 to List.Count - 1 do begin
      DuelInfo := pTDuelInfo(List.Items[I]);
      if (DuelInfo.Owner.sCharName = sCharName1) and (DuelInfo.Duel.sCharName = sCharName2) then begin
        if not DuelInfo.boFinish then begin
          Result := True;
          Exit;
        end;
      end;
    end;
    //Exit;
  end;
  //Result := False;
end;

function TDuelEngine.AddItem(const sCharName1, sCharName2: string; UserItem: pTUserItem): Boolean;
var
  DuelItem: pTDuelItem;
begin
  Result := False;
  New(DuelItem);
  DuelItem.boDelete := False;
  DuelItem.sOwnerName := sCharName1;
  DuelItem.sDuelName := sCharName2;
  DuelItem.UserItem := UserItem^;
  if m_DuelItem.AddRecord(DuelItem, SizeOf(TDuelItem) - SizeOf(Integer)) then begin
    m_DuelItem.m_ItemList.AddRecord(sCharName1, DuelItem);
    Result := True;
  end else Dispose(DuelItem);
end;

function TDuelEngine.AddDuel(const btDuel: Byte; const sCharName1, sCharName2: string; const nDuelGold1, nDuelGold2: Integer): Boolean;
var
  sChrName1, sChrName2: string;
  nIndex1, nIndex2: Integer;
  DuelInfo: pTDuelInfo;
begin
  Result := False;
  sChrName1 := sCharName1;
  sChrName2 := sCharName2;
  if not GetDuel(btDuel, sChrName1, sChrName2, nIndex1, nIndex2) then begin
    New(DuelInfo);
    DuelInfo.boDelete := False;
    DuelInfo.SaveDateTime := Now;
    DuelInfo.Owner.boDelete := False;
    DuelInfo.Owner.boVictory := True;
    DuelInfo.Owner.sCharName := sCharName1;
    DuelInfo.Owner.nDuelGold := nDuelGold1;

    DuelInfo.Duel.boDelete := False;
    DuelInfo.Duel.boVictory := True;
    DuelInfo.Duel.sCharName := sCharName2;
    DuelInfo.Duel.nDuelGold := nDuelGold2;

    DuelInfo.boFinish := False;

    if m_DuelInfo.AddRecord(DuelInfo, SizeOf(TDuelInfo) - SizeOf(Integer)) then begin
      m_DuelInfo.m_OwnerList.AddRecord(sCharName1, DuelInfo);
      m_DuelInfo.m_DuelList.AddRecord(sCharName2, DuelInfo);
      Result := True;
    end else Dispose(DuelInfo);
  end;
end;

procedure TDuelEngine.Defeat(const sCharName1, sCharName2: string);
var
  I, II, nIndex1, nIndex2: Integer;
  List1, List2, ItemList: TList;
  sCharName: string;
  DuelInfo: pTDuelInfo;
  DuelItem: pTDuelItem;
begin
  nIndex1 := m_DuelInfo.m_OwnerList.GetList(sCharName1, List1);
  nIndex2 := m_DuelInfo.m_DuelList.GetList(sCharName2, List2);
  if (nIndex1 >= 0) and (nIndex2 >= 0) then begin
    for I := 0 to List1.Count - 1 do begin
      DuelInfo := List1.Items[I];
      if (DuelInfo.Owner.sCharName = sCharName1) and (DuelInfo.Duel.sCharName = sCharName2) then begin
        DuelInfo.boFinish := True; //写入挑战完成
        DuelInfo.Owner.boVictory := False;
        m_DuelInfo.WriteRecord(DuelInfo.nIndex, DuelInfo, SizeOf(TDuelInfo) - SizeOf(Integer));
        if m_DuelItem.m_ItemList.GetList(sCharName1, ItemList) >= 0 then begin //自己的物品
          for II := 0 to ItemList.Count - 1 do begin
            DuelItem := ItemList.Items[II];
            if (not DuelItem.boDelete) and (DuelItem.sOwnerName = sCharName1) and
              (DuelItem.sDuelName = sCharName2) and (not DuelItem.boFinish) then begin
              DuelItem.boFinish := True; //写入挑战完成
              m_DuelItem.WriteRecord(DuelItem.nIndex, DuelItem, SizeOf(Boolean));
            end;
          end;
        end;
        if m_DuelItem.m_ItemList.GetList(sCharName2, ItemList) >= 0 then begin //对方的物品
          for II := 0 to ItemList.Count - 1 do begin
            DuelItem := ItemList.Items[II];
            if (not DuelItem.boDelete) and (DuelItem.sOwnerName = sCharName1) and
              (DuelItem.sDuelName = sCharName2) and (not DuelItem.boFinish) then begin
              DuelItem.boFinish := True; //写入挑战完成
              m_DuelItem.WriteRecord(DuelItem.nIndex, DuelItem, SizeOf(Boolean));
            end;
          end;
        end;
        Exit;
      end;
    end;
    Exit;
  end;
  nIndex1 := m_DuelInfo.m_OwnerList.GetList(sCharName2, List2);
  nIndex2 := m_DuelInfo.m_DuelList.GetList(sCharName1, List1);
  if (nIndex1 >= 0) and (nIndex2 >= 0) then begin
    for I := 0 to List2.Count - 1 do begin
      DuelInfo := List2.Items[I];
      if (DuelInfo.Owner.sCharName = sCharName2) and (DuelInfo.Duel.sCharName = sCharName1) then begin
        DuelInfo.boFinish := True; //写入挑战完成
        DuelInfo.Duel.boVictory := False;
        m_DuelInfo.WriteRecord(DuelInfo.nIndex, DuelInfo, SizeOf(TDuelInfo) - SizeOf(Integer));

        if m_DuelItem.m_ItemList.GetList(sCharName2, ItemList) >= 0 then begin //对方的物品
          for II := 0 to ItemList.Count - 1 do begin
            DuelItem := ItemList.Items[II];
            if (not DuelItem.boDelete) and (DuelItem.sOwnerName = sCharName2) and
              (DuelItem.sDuelName = sCharName1) and (not DuelItem.boFinish) then begin
              DuelItem.boFinish := True; //写入挑战完成
              m_DuelItem.WriteRecord(DuelItem.nIndex, DuelItem, SizeOf(Boolean));
            end;
          end;
        end;
        if m_DuelItem.m_ItemList.GetList(sCharName1, ItemList) >= 0 then begin //自己的物品
          for II := 0 to ItemList.Count - 1 do begin
            DuelItem := ItemList.Items[II];
            if (not DuelItem.boDelete) and (DuelItem.sOwnerName = sCharName2) and
              (DuelItem.sDuelName = sCharName1) and (not DuelItem.boFinish) then begin
              DuelItem.boFinish := True; //写入挑战完成
              m_DuelItem.WriteRecord(DuelItem.nIndex, DuelItem, SizeOf(Boolean));
            end;
          end;
        end;

        Exit;
      end;
    end;
    Exit;
  end;
end;

function TDuelEngine.GetItems(const sCharName: string; List: TList; var nGold: Integer): Boolean;
  procedure DeleteDuelList(List: TStringList; DuelInfo: pTDuelInfo);
  var
    I, II: Integer;
    DuelList: TList;
    boFind: Boolean;
  begin
    boFind := False;
    for I := List.Count - 1 downto 0 do begin
      DuelList := TList(List.Objects[I]);
      for II := DuelList.Count - 1 downto 0 do begin
        if DuelList.Items[II] = DuelInfo then begin
          DuelList.Delete(II);
          boFind := True;
          Break;
        end;
      end;
      if DuelList.Count <= 0 then begin
        List.Delete(I);
        DuelList.Free;
      end;
      if boFind then Break;
    end;
  end;
var
  Index, I, II, III, nIndex: Integer;
  OwnerList, DuelList, ItemList: TList;
  UserItem: pTUserItem;
  DuelInfo: pTDuelInfo;
  DuelItem: pTDuelItem;
begin
  Result := False;
  nGold := 0;
  if List = nil then Exit;
  Index := m_DuelInfo.m_OwnerList.GetList(sCharName, OwnerList);
  if Index >= 0 then begin
    for I := OwnerList.Count - 1 downto 0 do begin
      DuelInfo := OwnerList.Items[I];
      if DuelInfo.boFinish and (DuelInfo.Owner.sCharName = sCharName) and (DuelInfo.Owner.boVictory) and (not DuelInfo.Duel.boVictory) then begin
        DuelInfo.boDelete := True;
        if m_DuelInfo.DeleteRecord(DuelInfo.nIndex, DuelInfo, SizeOf(Boolean)) then begin
          Inc(nGold, DuelInfo.Owner.nDuelGold);
          Inc(nGold, DuelInfo.Duel.nDuelGold);
          nIndex := m_DuelItem.m_ItemList.GetList(DuelInfo.Owner.sCharName, ItemList); //取回自己的物品
          if nIndex >= 0 then begin
            for II := ItemList.Count - 1 downto 0 do begin
              DuelItem := ItemList.Items[II];
              if (not DuelItem.boDelete) and DuelItem.boFinish and (DuelItem.sDuelName = DuelInfo.Duel.sCharName) then begin
                DuelItem.boDelete := True;
                if m_DuelItem.DeleteRecord(DuelItem.nIndex, DuelItem, SizeOf(Word)) then begin
                  New(UserItem);
                  UserItem^ := DuelItem.UserItem;
                  Dispose(DuelItem);
                  List.Add(UserItem);
                  ItemList.Delete(II);
                end;
              end;
            end;
            if ItemList.Count <= 0 then begin
              ItemList.Free;
              m_DuelItem.m_ItemList.Delete(nIndex);
            end;
          end;

          nIndex := m_DuelItem.m_ItemList.GetList(DuelInfo.Duel.sCharName, ItemList); //取回对方的物品
          if nIndex >= 0 then begin
            for II := ItemList.Count - 1 downto 0 do begin
              DuelItem := ItemList.Items[II];
              if (not DuelItem.boDelete) and DuelItem.boFinish and (DuelItem.sOwnerName = DuelInfo.Owner.sCharName) then begin
                DuelItem.boDelete := True;
                if m_DuelItem.DeleteRecord(DuelItem.nIndex, DuelItem, SizeOf(Word)) then begin
                  New(UserItem);
                  UserItem^ := DuelItem.UserItem;
                  Dispose(DuelItem);
                  List.Add(UserItem);
                  ItemList.Delete(II);
                end;
              end;
            end;
            if ItemList.Count <= 0 then begin
              ItemList.Free;
              m_DuelItem.m_ItemList.Delete(nIndex);
            end;
          end;

          {for II := m_DuelInfo.m_DuelList.Count - 1 downto 0 do begin
            DuelList := TList(m_DuelInfo.m_DuelList.Objects[II]);
            for III := DuelList.Count - 1 downto 0 do begin
              if DuelList.Items[III] = DuelInfo then DuelList.Delete(III);
            end;
            if DuelList.Count <= 0 then begin
              m_DuelInfo.m_DuelList.Delete(II);
              DuelList.Free;
            end;
          end;}

          DeleteDuelList(m_DuelInfo.m_DuelList, DuelInfo);

          Dispose(DuelInfo);
          OwnerList.Delete(I);

          if OwnerList.Count <= 0 then begin
            OwnerList.Free;
            m_DuelInfo.m_OwnerList.Delete(Index);
          end;

          Result := True;
          Exit;
        end;
      end;
    end;
  end;

  Index := m_DuelInfo.m_DuelList.GetList(sCharName, DuelList);
  if Index >= 0 then begin
    for I := DuelList.Count - 1 downto 0 do begin
      DuelInfo := DuelList.Items[I];
      if DuelInfo.boFinish and (DuelInfo.Duel.sCharName = sCharName) and (DuelInfo.Duel.boVictory) and (not DuelInfo.Owner.boVictory) then begin
        DuelInfo.boDelete := True;
        if m_DuelInfo.DeleteRecord(DuelInfo.nIndex, DuelInfo, SizeOf(Boolean)) then begin
          Inc(nGold, DuelInfo.Owner.nDuelGold);
          Inc(nGold, DuelInfo.Duel.nDuelGold);
          nIndex := m_DuelItem.m_ItemList.GetList(DuelInfo.Duel.sCharName, ItemList); //取回自己的物品
          if nIndex >= 0 then begin
            for II := ItemList.Count - 1 downto 0 do begin
              DuelItem := ItemList.Items[II];
              if (not DuelItem.boDelete) and DuelItem.boFinish and (DuelItem.sOwnerName = DuelInfo.Owner.sCharName) then begin
                DuelItem.boDelete := True;
                if m_DuelItem.DeleteRecord(DuelItem.nIndex, DuelItem, SizeOf(Word)) then begin
                  New(UserItem);
                  UserItem^ := DuelItem.UserItem;
                  Dispose(DuelItem);
                  List.Add(UserItem);
                  ItemList.Delete(II);
                end;
              end;
            end;
            if ItemList.Count <= 0 then begin
              ItemList.Free;
              m_DuelItem.m_ItemList.Delete(nIndex);
            end;
          end;

          nIndex := m_DuelItem.m_ItemList.GetList(DuelInfo.Owner.sCharName, ItemList); //取回对方的物品
          if nIndex >= 0 then begin
            for II := ItemList.Count - 1 downto 0 do begin
              DuelItem := ItemList.Items[II];
              if (not DuelItem.boDelete) and DuelItem.boFinish and (DuelItem.sDuelName = DuelInfo.Duel.sCharName) then begin
                DuelItem.boDelete := True;
                if m_DuelItem.DeleteRecord(DuelItem.nIndex, DuelItem, SizeOf(Word)) then begin
                  New(UserItem);
                  UserItem^ := DuelItem.UserItem;
                  Dispose(DuelItem);
                  List.Add(UserItem);
                  ItemList.Delete(II);
                end;
              end;
            end;
            if ItemList.Count <= 0 then begin
              ItemList.Free;
              m_DuelItem.m_ItemList.Delete(nIndex);
            end;
          end;

          {for II := m_DuelInfo.m_OwnerList.Count - 1 downto 0 do begin
            OwnerList := TList(m_DuelInfo.m_OwnerList.Objects[II]);
            for III := OwnerList.Count - 1 downto 0 do begin
              if OwnerList.Items[III] = DuelInfo then begin
                OwnerList.Delete(III);
              end;
            end;
            if OwnerList.Count <= 0 then begin
              m_DuelInfo.m_OwnerList.Delete(II);
              OwnerList.Free;
            end;
          end;}
          DeleteDuelList(m_DuelInfo.m_OwnerList, DuelInfo);

          Dispose(DuelInfo);
          DuelList.Delete(I);

          if DuelList.Count <= 0 then begin
            DuelList.Free;
            m_DuelInfo.m_DuelList.Delete(Index);
          end;

          Result := True;
          Exit;
        end;
      end;
    end;
  end;
end;
{TDuelInfoDB}

constructor TDuelInfoDB.Create;
begin
  inherited;
  m_OwnerList := TQuickStringList.Create;
  m_DuelList := TQuickStringList.Create;
  if g_Config.sEnvirDir[Length(g_Config.sEnvirDir)] = '\' then
    m_sFileName := g_Config.sEnvirDir + 'Market_Duel\'
  else
    m_sFileName := g_Config.sEnvirDir + '\Market_Duel\';

  if not DirectoryExists(m_sFileName) then begin
    ForceDirectories(m_sFileName);
  end;
  m_sDBFileName := m_sFileName + 'Duel.Duel';
end;

destructor TDuelInfoDB.Destroy;
begin
  UnLoad;
  m_OwnerList.Free;
  m_DuelList.Free;
  inherited;
end;

procedure TDuelInfoDB.UnLoad;
var
  I, II: Integer;
  List: TList;
begin
  for I := 0 to m_OwnerList.Count - 1 do begin
    List := TList(m_OwnerList.Objects[I]);
    for II := 0 to List.Count - 1 do begin
      Dispose(List.Items[II]);
    end;
    List.Free;
  end;
  m_OwnerList.Clear;
  m_DuelList.Clear;
end;

procedure TDuelInfoDB.Load;
var
  nIndex: Integer;
  DBHeader: TItemCount;
  DBRecord: pTDuelInfo;
begin
  UnLoad;
  m_DeletedList.Clear;
  try
    if Open then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        for nIndex := 0 to DBHeader - 1 do begin
          New(DBRecord);
          FillChar(DBRecord^, SizeOf(TDuelInfo) - SizeOf(Integer), #0);
          if FileRead(m_nFileHandle, DBRecord^, SizeOf(TDuelInfo) - SizeOf(Integer)) <> (SizeOf(TDuelInfo) - SizeOf(Integer)) then begin
            Dispose(DBRecord);
            Break;
          end;
          if (not DBRecord.boDelete) then begin
            Inc(m_nRecordCount);
            DBRecord.nIndex := nIndex;
            m_OwnerList.AddRecord(DBRecord.Owner.sCharName, DBRecord);
            m_DuelList.AddRecord(DBRecord.Duel.sCharName, DBRecord);
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

procedure TDuelInfoDB.SetIndex(Buffer: Pointer; Index: Integer);
begin
  //inherited;
  pTDuelInfo(Buffer).nIndex := Index;
end;

{TDuelItemDB}

constructor TDuelItemDB.Create;
begin
  inherited;
  m_ItemList := TQuickStringList.Create;
  if g_Config.sEnvirDir[Length(g_Config.sEnvirDir)] = '\' then
    m_sFileName := g_Config.sEnvirDir + 'Market_Duel\'
  else
    m_sFileName := g_Config.sEnvirDir + '\Market_Duel\';

  if not DirectoryExists(m_sFileName) then begin
    ForceDirectories(m_sFileName);
  end;
  m_sDBFileName := m_sFileName + 'Duel.Item';
end;

destructor TDuelItemDB.Destroy;
begin
  UnLoad;
  m_ItemList.Free;
  inherited;
end;

procedure TDuelItemDB.UnLoad;
var
  I, II: Integer;
  List: TList;
begin
  for I := 0 to m_ItemList.Count - 1 do begin
    List := TList(m_ItemList.Objects[I]);
    for II := 0 to List.Count - 1 do begin
      Dispose(List.Items[II]);
    end;
    List.Free;
  end;
  m_ItemList.Clear;
end;

procedure TDuelItemDB.Load;
var
  nIndex: Integer;
  DBHeader: TItemCount;
  DBRecord: pTDuelItem;
begin
  UnLoad;
  m_DeletedList.Clear;
  try
    if Open then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
        for nIndex := 0 to DBHeader - 1 do begin
          New(DBRecord);
          FillChar(DBRecord^, SizeOf(TDuelItem) - SizeOf(Integer), #0);
          if FileRead(m_nFileHandle, DBRecord^, SizeOf(TDuelItem) - SizeOf(Integer)) <> (SizeOf(TDuelItem) - SizeOf(Integer)) then begin
            Dispose(DBRecord);
            Break;
          end;
          if (not DBRecord.boDelete) then begin
            Inc(m_nRecordCount);
            DBRecord.nIndex := nIndex;
            m_ItemList.AddRecord(DBRecord.sOwnerName, DBRecord);
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

procedure TDuelItemDB.SetIndex(Buffer: Pointer; Index: Integer);
begin
  //inherited;
  pTDuelItem(Buffer).nIndex := Index;
end;
{TDuelEngine}

constructor TDuelData.Create;
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

destructor TDuelData.Destroy;
begin
  m_DeletedList.Free;
  DeleteCriticalSection(m_UserCriticalSection);
  inherited;
end;

procedure TDuelData.Lock();
begin
  EnterCriticalSection(m_UserCriticalSection);
end;

procedure TDuelData.UnLock();
begin
  LeaveCriticalSection(m_UserCriticalSection);
end;

procedure TDuelData.Close;
begin
  FileClose(m_nFileHandle);
  UnLock();
end;

function TDuelData.Open: Boolean;
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

function TDuelData.OpenEx: Boolean;
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

function TDuelData.DeleteRecord(Index: Integer; const Buffer: Pointer; Count: Integer): Boolean;
begin
  Result := False;
  if WriteRecord(Index, Buffer, Count) then begin
    m_DeletedList.Add(Pointer(Index));
    try
      if Open then begin
        Dec(m_Header);
        FileSeek(m_nFileHandle, 0, 0);
        FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
        Result := True;
      end;
    finally
      Close();
    end;
  end;
end;

function TDuelData.AddRecord(const Buffer: Pointer; Count: Integer): Boolean;
var
  nIndex: Integer;
  nPosion, n10: Integer;
begin
  Result := False;
  if m_DeletedList.Count > 0 then begin
    nIndex := Integer(m_DeletedList.Items[0]);
    m_DeletedList.Delete(0);
  end else begin
    nIndex := m_Header;
  end;
  if WriteRecord(nIndex, Buffer, Count) then begin
    SetIndex(Buffer, nIndex);
    try
      if Open then begin
        Inc(m_Header);
        FileSeek(m_nFileHandle, 0, 0);
        FileWrite(m_nFileHandle, m_Header, SizeOf(TItemCount));
        Result := True;
      end;
    finally
      Close();
    end;
  end;
end;

function TDuelData.WriteRecord(Index: Integer; const Buffer: Pointer; Count: Integer): Boolean;
var
  nPosion, n10: Integer;
begin
  try
    Result := False;
    if Open then begin
      nPosion := Index * Count + SizeOf(TItemCount);
      if FileSeek(m_nFileHandle, nPosion, 0) = nPosion then begin
        n10 := FileSeek(m_nFileHandle, 0, 1);
        //FileSeek(m_nFileHandle, n10, 0);
        FileWrite(m_nFileHandle, Buffer^, Count);
        //FileSeek(m_nFileHandle, -Count, 1);
        Result := True;
      end;
    end;
  finally
    Close();
  end;
end;

{ TQuickStringList }

procedure TQuickStringList.AddRecord(const s: string; Item: Pointer);
var
  List: TList;
  nLow, nHigh, nMed, n1C, n20: Integer;
begin
  if Count = 0 then begin
    List := TList.Create;
    List.Add(Item);
    AddObject(s, List);
  end else begin
    if Count = 1 then begin
      nMed := CompareStr(s, Self.Strings[0]);
      if nMed > 0 then begin
        List := TList.Create;
        List.Add(Item);
        AddObject(s, List);
      end else begin
        if nMed < 0 then begin
          List := TList.Create;
          List.Add(Item);
          InsertObject(0, s, List);
        end else begin
          List := TList(Self.Objects[0]);
          List.Add(Item);
        end;
      end;
    end else begin
      nLow := 0;
      nHigh := Self.Count - 1;
      nMed := (nHigh - nLow) div 2 + nLow;
      while (True) do begin
        if (nHigh - nLow) = 1 then begin
          n20 := CompareStr(s, Self.Strings[nHigh]);
          if n20 > 0 then begin
            List := TList.Create;
            List.Add(Item);
            InsertObject(nHigh + 1, s, List);
            Break;
          end else begin
            if CompareStr(s, Self.Strings[nHigh]) = 0 then begin
              List := TList(Self.Objects[nHigh]);
              List.Add(Item);
              Break;
            end else begin
              n20 := CompareStr(s, Self.Strings[nLow]);
              if n20 > 0 then begin
                List := TList.Create;
                List.Add(Item);
                InsertObject(nLow + 1, s, List);
                Break;
              end else begin
                if n20 < 0 then begin
                  List := TList.Create;
                  List.Add(Item);
                  InsertObject(nLow, s, List);
                  Break;
                end else begin
                  List := TList(Self.Objects[n20]);
                  List.Add(Item);
                  Break;
                end;
              end;
            end;
          end;
        end else begin
          n1C := CompareStr(s, Self.Strings[nMed]);
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
          List := TList(Self.Objects[nMed]);
          List.Add(Item);
          Break;
        end;
      end;
    end;
  end;
end;

procedure TQuickStringList.DelRecord(nIndex: Integer);
var
  List: TList;
  //I: Integer;
begin
  if (Self.Count - 1) < nIndex then Exit;
  List := TList(Self.Objects[nIndex]);
  {for I := 0 to List.Count - 1 do begin
    Dispose(List.Items[I]);
  end;}
  List.Free;
  Self.Delete(nIndex);
end;

function TQuickStringList.GetList(s: string;
  var List: TList): Integer;
var
  nHigh, nLow, nMed, n20, n24: Integer;
begin
  Result := -1;
  if Self.Count = 0 then Exit;
  if Self.Count = 1 then begin
    if CompareStr(s, Self.Strings[0]) = 0 then begin
      List := TList(Self.Objects[0]);
      Result := 0;
    end;
  end else begin
    nLow := 0;
    nHigh := Self.Count - 1;
    nMed := (nHigh - nLow) div 2 + nLow;
    n24 := -1;
    while (True) do begin
      if (nHigh - nLow) = 1 then begin
        if CompareStr(s, Self.Strings[nHigh]) = 0 then n24 := nHigh;
        if CompareStr(s, Self.Strings[nLow]) = 0 then n24 := nLow;
        Break;
      end else begin
        n20 := CompareStr(s, Self.Strings[nMed]);
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
    if n24 <> -1 then List := TList(Self.Objects[n24]);
    Result := n24;
  end;
end;

end.
