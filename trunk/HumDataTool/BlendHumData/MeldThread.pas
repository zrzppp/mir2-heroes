unit MeldThread;

interface
uses
  Windows, Classes, SysUtils, Forms, Grobal2, MudUtil, Controls, IDDB, HumDB, GuildDB, Share;
type
  TMeldThread = class(TThread)
    AccountDB_M: TFileIDDB;
    HumCharDB_M: TFileHumDB;
    HumDataDB_M: TFileDB;
    GuildBase_M: TGuildBase;

    AccountDB_S: TFileIDDB;
    HumCharDB_S: TFileHumDB;
    HumDataDB_S: TFileDB;
    GuildBase_S: TGuildBase;
  private
    procedure UpDateAccount(const sOldAccount, sNewAccount: string);
    procedure UpDateChrName(const sOldChrName, sNewChrName: string);
    procedure LoadFromFile;
    procedure MeldData;
    procedure MeldAccountDB;
    procedure MeldHumCharDB;
    procedure MeldHumDataDB;
    procedure MeldGuildBase;
    procedure SaveToFile;
  public
    constructor Create;
    destructor Destroy; override;
  protected
    procedure Execute; override;

    procedure Load; virtual; abstract;
    procedure UnLoad; virtual; abstract;
    procedure Delete(const sName: string); virtual; abstract;


  end;
implementation

constructor TMeldThread.Create;
begin
  inherited Create(True);
  AccountDB_M := TFileIDDB.Create(t_Master);
  HumCharDB_M := TFileHumDB.Create(t_Master);
  HumDataDB_M := TFileDB.Create(t_Master);
  GuildBase_M := TGuildBase.Create(t_Master);

  AccountDB_S := TFileIDDB.Create(t_Slave);
  HumCharDB_S := TFileHumDB.Create(t_Slave);
  HumDataDB_S := TFileDB.Create(t_Slave);
  GuildBase_S := TGuildBase.Create(t_Slave);
end;

destructor TMeldThread.Destroy;
begin
  AccountDB_M.Free;
  HumCharDB_M.Free;
  HumDataDB_M.Free;
  GuildBase_M.Free;

  AccountDB_S.Free;
  HumCharDB_S.Free;
  HumDataDB_S.Free;
  GuildBase_S.Free;
  inherited Destroy;
end;

procedure TMeldThread.Execute;
begin
  LoadFromFile;
  MeldData;
  SaveToFile;
end;

procedure TMeldThread.UpDateAccount(const sOldAccount, sNewAccount: string);
begin

end;

procedure TMeldThread.UpDateChrName(const sOldChrName, sNewChrName: string);
begin

end;

procedure TMeldThread.LoadFromFile; //读取数据
begin
  AccountDB_M.LoadFromFile(g_sMasterIDFileName);
  HumCharDB_M.LoadFromFile(g_sMasterHumFileName);
  HumDataDB_M.LoadFromFile(g_sMasterMirFileName);
  GuildBase_M.LoadFromFile(g_sMasterGuildFileName);

  AccountDB_S.LoadFromFile(g_sSlaveIDFileName);
  HumCharDB_S.LoadFromFile(g_sSlaveHumFileName);
  HumDataDB_S.LoadFromFile(g_sSlaveMirFileName);
  GuildBase_S.LoadFromFile(g_sSlaveGuildFileName);
end;

procedure TMeldThread.MeldData; //合并数据
begin
  MeldAccountDB;
  MeldHumCharDB;
  MeldHumDataDB;
  MeldGuildBase;
end;

procedure TMeldThread.MeldAccountDB; //合并帐号
  function GetNewAccount(const sAccount: string; var sNewAccount: string): Boolean;
  var
    I, II, III, IIII, IIIII, IIIIII: Integer;
    sOldAccount: string;
  begin
    Result := True;
    sNewAccount := sAccount;
    if AccountDB_M.m_QuickList.GetIndex(sAccount) >= 0 then begin
      Result := False;
      for I := 0 to 9 do begin

      end;
    end;
  end;
var
  sAccount: string;
  sOldAccount: string;
  sNewAccount: string;
  AccountDBRecord: pTAccountDBRecord;
begin
  while AccountDB_S.m_QuickList.Count > 0 do begin
    sAccount := AccountDB_S.m_QuickList.Strings[0];
    AccountDBRecord := pTAccountDBRecord(AccountDB_S.m_QuickList.Objects[0]);
    sNewAccount := sAccount;
    if AccountDB_M.m_QuickList.GetIndex(sAccount) >= 0 then begin

    end;
    AccountDB_S.m_QuickList.Delete(0);
    AccountDB_M.m_QuickList.AddRecord(AccountDBRecord.UserEntry.sAccount, Integer(AccountDBRecord));
  end;
end;

procedure TMeldThread.MeldHumCharDB; //合并Hum.db
begin

end;

procedure TMeldThread.MeldHumDataDB; //合并Mir.db
begin

end;

procedure TMeldThread.MeldGuildBase; //合并行会数据
begin

end;

procedure TMeldThread.SaveToFile; //保存数据
begin

end;

end.

