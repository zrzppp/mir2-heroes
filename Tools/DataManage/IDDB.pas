unit IDDB;

interface
uses
  Windows, Classes, SysUtils, Forms, Grobal2, Controls, ObjBase;
resourcestring
  sDBHeaderDesc = '飞尔世界数据库文件 2008/02/16';
  sDBIdxHeaderDesc = '飞尔世界数据库索引文件 2008/02/16';
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

  TFileIDDB = class(TDataManage)
    m_IDDBList: TQuickList;
    m_Header: TDBHeader;
  private
    function OpenEx: Boolean;
    function Open: Boolean;
    procedure Close;
  public
    constructor Create(sFileName: string); override;
    destructor Destroy; override;

    procedure Load; override;
    procedure UnLoad; override;
    procedure SaveToFile(sFileName: string); overload;
    procedure SaveToFile(); overload; override;
    procedure GetAccountList(sAccount: string; List: TStrings);
  end;

implementation

uses HUtil32, Share;

{ TFileIDDB }

constructor TFileIDDB.Create(sFileName: string);
begin
  inherited Create(sFileName);
  m_IDDBList := TQuickList.Create;
end;

destructor TFileIDDB.Destroy;
begin
  UnLoad();
  m_IDDBList.Free;
  inherited;
end;

procedure TFileIDDB.UnLoad();
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

procedure TFileIDDB.Load();
var
  DBHeader: TDBHeader;
  DBRecord: pTAccountDBRecord;
  nIndex: Integer;
begin
  try
    if OpenEx then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then begin
        if Assigned(OnStart) then OnStart(Self, DBHeader.nIDCount, Format(sLondData,[g_sFileNames[m_nType]]));
        for nIndex := 0 to DBHeader.nIDCount - 1 do begin
          if g_boClose then Break;
          if Assigned(OnProgress) then OnProgress(Self, nIndex + 1, '');
          New(DBRecord);
          FillChar(DBRecord^, SizeOf(TAccountDBRecord), #0);
          if FileRead(m_nFileHandle, DBRecord^, SizeOf(TAccountDBRecord)) <> SizeOf(TAccountDBRecord) then begin
            Dispose(DBRecord);
            Break;
          end;
          if (DBRecord.UserEntry.sAccount = '') or DBRecord.Header.boDeleted then begin
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
  finally
    Close();
  end;
  if Assigned(OnStop) then OnStop(Self, 0, sSortString);
  m_IDDBList.SortString(0, m_IDDBList.Count - 1);
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
  if FileExists(m_sDBFileName) then DeleteFile(m_sDBFileName);
  try
    if Open then begin
      FileSeek(m_nFileHandle, 0, 0);
      if Assigned(OnStart) then OnStart(Self, m_IDDBList.Count, Format(sSaveToFile,[g_sFileNames[m_nType]]));
      m_Header.nIDCount := m_IDDBList.Count;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
      for I := 0 to m_IDDBList.Count - 1 do begin
        if g_boClose then Break;
        if Assigned(OnProgress) then OnProgress(Self, I + 1, '');
        DBRecord := pTAccountDBRecord(m_IDDBList.Objects[I]);
        FileWrite(m_nFileHandle, DBRecord^, SizeOf(TAccountDBRecord));
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

procedure TFileIDDB.GetAccountList(sAccount: string; List: TStrings);
begin

end;

end.

