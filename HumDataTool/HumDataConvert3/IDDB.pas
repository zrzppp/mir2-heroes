unit IDDB;

interface
uses
  Windows, Classes, SysUtils, Forms, IniFiles, Share, Grobal2;
resourcestring
  sDBHeaderDesc = '飞尔世界数据库文件 2010/07/01';
  sDBIdxHeaderDesc = '飞尔世界数据库文件 2010/07/01';
type
  TDBHeader = packed record
    sDesc: string[34]; //0x00
    n23: Integer; //0x23
    n28: Integer; //0x27
    n2C: Integer; //0x2B
    n30: Integer; //0x2F
    n34: Integer; //0x33
    n38: Integer; //0x37
    n3C: Integer; //0x3B
    n40: Integer; //0x3F
    n44: Integer; //0x43
    n48: Integer; //0x47
    n4B: Byte; //0x4B
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    nLastIndex: Integer; //0x5C
    dLastDate: TDateTime; //0x60
    nIDCount: Integer; //0x68
    n6C: Integer; //0x6C
    nDeletedIdx: Integer; //0x70
    dUpdateDate: TDateTime; //0x74
  end;
  pTDBHeader = ^TDBHeader;

  TIdxHeader = packed record
    sDesc: string[43]; //0x00
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
    n60: Integer; //0x60
    nQuickCount: Integer; //0x64
    nIDCount: Integer; //0x68
    nLastIndex: Integer; //0x6C
    dUpdateDate: TDateTime; //0x70
  end;

  TIdxRecord = packed record
    sName: string[11];
    nIndex: Integer;
  end;
  pTIdxRecord = ^TIdxRecord;

  TFileIDDB = class(TConvertData)
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
implementation
{TFileIDDB}

constructor TFileIDDB.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_QuickList := TQuickList.Create;
  m_NewQuickList := TQuickList.Create;
end;

destructor TFileIDDB.Destroy;
begin
  UnLoad();
  m_QuickList.Free;
  m_NewQuickList.Free;
  inherited;
end;

procedure TFileIDDB.UnLoad();
var
  I: Integer;
begin
  for I := 0 to m_QuickList.Count - 1 do begin
    Dispose(pTOAccountDBRecord(m_QuickList.Objects[I]));
  end;
  m_QuickList.Clear;

  for I := 0 to m_NewQuickList.Count - 1 do begin
    Dispose(pTAccountDBRecord(m_NewQuickList.Objects[I]));
  end;
  m_NewQuickList.Clear;
end;

procedure TFileIDDB.Load();
var
  nIndex, nIdx: Integer;
  DBHeader: TDBHeader;
  PDBRecord: pTOAccountDBRecord;
  DBRecord: TOAccountDBRecord;
begin
  m_nCount := 0;
  m_nPercent := 0;
  if not m_boConvert then Exit;
  ProcessMessage(Format(sLondData, [g_sFileNames[0]]));
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then begin
        m_nCount := DBHeader.nIDCount;
        for nIndex := 0 to DBHeader.nIDCount - 1 do begin
          if g_boClose then Break;
          ProcessStatus();

          FillChar(DBRecord, SizeOf(TOAccountDBRecord), #0);

          if FileSeek(m_nFileHandle, nIndex * SizeOf(TOAccountDBRecord) + SizeOf(TDBHeader), 0) = -1 then begin
            Break;
          end;

          if FileRead(m_nFileHandle, DBRecord, SizeOf(TOAccountDBRecord)) <> SizeOf(TOAccountDBRecord) then begin
            Break;
          end;

          if (DBRecord.UserEntry.sAccount = '') or DBRecord.Header.boDeleted then begin
            Continue;
          end;

          New(PDBRecord);
          PDBRecord^ := DBRecord;
          m_QuickList.AddObject(PDBRecord.Header.sAccount, TObject(PDBRecord));

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

function TFileIDDB.Open: Boolean;
begin
  //m_nLastReadIdx := 0;
  if FileExists(m_sDBFileName) then begin
    m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then
      FileRead(m_nFileHandle, m_Header, SizeOf(TDBHeader));
  end else begin
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      m_Header.sDesc := sDBHeaderDesc;
      m_Header.nIDCount := 0;
      m_Header.n6C := 0;
      m_Header.nDeletedIdx := -1;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
    end;
  end;
  if m_nFileHandle > 0 then begin
    Result := True;
  end else Result := False;
end;

procedure TFileIDDB.Close();
begin
  FileClose(m_nFileHandle);
end;

function TFileIDDB.OpenEx: Boolean;
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

procedure TFileIDDB.Convert();
var
  I: Integer;
  DBRecord: pTAccountDBRecord;
  ODBRecord: pTOAccountDBRecord;
begin
  if not m_boConvert then Exit;
  ProcessMessage(Format(sConvertData, [g_sFileNames[0]]));

  m_nPercent := 0;
  m_nCount := m_QuickList.Count;

  for I := 0 to m_QuickList.Count - 1 do begin
    ODBRecord := pTOAccountDBRecord(m_QuickList.Objects[I]);
    New(DBRecord);
    FillChar(DBRecord^, SizeOf(TAccountDBRecord), #0);

    DBRecord.Header.boDeleted := ODBRecord.Header.boDeleted;
    DBRecord.Header.bt1 := ODBRecord.Header.bt1;
    DBRecord.Header.bt2 := ODBRecord.Header.bt2;
    DBRecord.Header.bt3 := ODBRecord.Header.bt3;
    DBRecord.Header.CreateDate := ODBRecord.Header.CreateDate;
    DBRecord.Header.UpdateDate := ODBRecord.Header.UpdateDate;
    DBRecord.Header.sAccount := ODBRecord.Header.sAccount;

    DBRecord.UserEntry.sAccount := ODBRecord.UserEntry.sAccount;
    DBRecord.UserEntry.sPassword := ODBRecord.UserEntry.sPassword;
    DBRecord.UserEntry.sUserName := ODBRecord.UserEntry.sUserName;
    DBRecord.UserEntry.sSSNo := ODBRecord.UserEntry.sSSNo;
    DBRecord.UserEntry.sPhone := ODBRecord.UserEntry.sPhone;
    DBRecord.UserEntry.sQuiz := ODBRecord.UserEntry.sQuiz;
    DBRecord.UserEntry.sAnswer := ODBRecord.UserEntry.sAnswer;
    DBRecord.UserEntry.sEMail := ODBRecord.UserEntry.sEMail;

    DBRecord.UserEntryAdd := ODBRecord.UserEntryAdd;
    DBRecord.nErrorCount := ODBRecord.nErrorCount;
    DBRecord.dwActionTick := ODBRecord.dwActionTick;
    DBRecord.dwCreateTick := ODBRecord.dwCreateTick;

    m_NewQuickList.AddObject(m_QuickList.Strings[I], TObject(DBRecord));

    ProcessStatus();
  end;
end;

procedure TFileIDDB.SaveToFile(sFileName: string);
var
  I: Integer;
  DBRecord: pTAccountDBRecord;
  sOldDBFileName: string;
begin
  if not m_boConvert then Exit;
  //m_NewQuickList.SaveToFile('NewMir.txt');
  ProcessMessage(Format(sSaveToFile, [g_sFileNames[0]]));
  sOldDBFileName := m_sDBFileName;
  try
    m_sDBFileName := sFileName;

    m_nPercent := 0;
    m_nCount := 0;
    if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
    try
      if Open then begin
        m_nCount := m_NewQuickList.Count;
        m_Header.nIDCount := m_NewQuickList.Count;
        FileSeek(m_nFileHandle, 0, 0);
        FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
        for I := 0 to m_NewQuickList.Count - 1 do begin
          if g_boClose then Break;
          DBRecord := pTAccountDBRecord(m_NewQuickList.Objects[I]);
          FileWrite(m_nFileHandle, DBRecord^, SizeOf(TAccountDBRecord));
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

