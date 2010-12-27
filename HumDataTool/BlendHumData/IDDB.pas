unit IDDB;

interface
uses
  Windows, Classes, SysUtils, Forms, Grobal, Controls, Share;
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

  TFileIDDB = class(TLoadMirData)
    m_IDDBList: TQuickList;
    m_Header: TDBHeader;
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;
    function OpenEx: Boolean;
    function Open: Boolean;
    procedure LoadQuickList();
    procedure UnLoadIDDBList();
    procedure SaveToFile(); overload;
    procedure SaveToFile(sFileName: string); overload;
    procedure Close;
  end;

implementation

uses HUtil32;

{ TFileIDDB }

constructor TFileIDDB.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_IDDBList := TQuickList.Create;
end;

destructor TFileIDDB.Destroy;
begin
  UnLoadIDDBList();
  m_IDDBList.Free;
  inherited;
end;

procedure TFileIDDB.UnLoadIDDBList();
var
  I: Integer;
begin
  for I := 0 to m_IDDBList.Count - 1 do begin
    Dispose(pTAccountDBRecord(m_IDDBList.Objects[I]));
  end;
  m_IDDBList.Clear;
end;

procedure TFileIDDB.Close();
begin
  FileClose(m_nFileHandle);
end;

function TFileIDDB.Open: Boolean;
begin
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

procedure TFileIDDB.LoadQuickList();
var
  DBHeader: TDBHeader;
  DBRecord: pTAccountDBRecord;
  nIndex: Integer;
begin
  m_nCount := 0;
  m_nPercent := 0;
  //try
    try
      if OpenEx then begin
        FileSeek(m_nFileHandle, 0, 0);
        if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then begin
          m_nCount := DBHeader.nIDCount;
          for nIndex := 0 to DBHeader.nIDCount - 1 do begin
            if g_boClose then Break;
            ProcessStatus();
            New(DBRecord);
            FillChar(DBRecord^, SizeOf(TAccountDBRecord), #0);
            if FileRead(m_nFileHandle, DBRecord^, SizeOf(TAccountDBRecord)) <> SizeOf(TAccountDBRecord) then begin
              Dispose(DBRecord);
              Break;
            end;
            if DBRecord.Header.boDeleted or (DBRecord.UserEntry.sAccount = '') then begin
              Dispose(DBRecord);
              Continue;
            end;

            if g_boClearID1 and (GetDayCount(Now, DBRecord.Header.UpdateDate) >= g_nLimitDay2) then begin
              Dispose(DBRecord);
              Continue;
            end;

            m_IDDBList.AddObject(DBRecord.UserEntry.sAccount, TObject(DBRecord));

            Application.ProcessMessages;
            if Application.Terminated then begin
              Close;
              Exit;
            end;
          end;
        end;
      end;
    //except

    //end;
  finally
    Close();
  end;
  ProcessMessage('正在排序，请稍候...');
  m_IDDBList.SortString(0, m_IDDBList.Count - 1);
  //StringList.SaveToFile('ID.txt');
end;

procedure TFileIDDB.SaveToFile(sFileName: string);
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

procedure TFileIDDB.SaveToFile();
var
  DBRecord: pTAccountDBRecord;
  I: Integer;
begin
  m_nCount := 0;
  m_nPercent := 0;
  if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
  try
    if Open then begin
      FileSeek(m_nFileHandle, 0, 0);
      m_nCount := m_IDDBList.Count;
      m_Header.nIDCount := m_IDDBList.Count;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
      for I := 0 to m_IDDBList.Count - 1 do begin
        if g_boClose then Break;
        DBRecord := pTAccountDBRecord(m_IDDBList.Objects[I]);
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
end;

function TFileIDDB.OpenEx: Boolean;
var
  DBHeader: TDBHeader;
begin
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenRead or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := True;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then
      m_Header := DBHeader;
  end else Result := False;
end;

end.

