unit Share;

interface
uses
  Windows, Classes, SysUtils, Controls, ExtCtrls, RzLabel, RzRadChk, RzStatus, ComCtrls, ObjBase, HumDB, IDDB, LocalDB;
var
  g_boClose: Boolean;
  g_boSoftClose: Boolean;
  g_nMaxItemMakeIndex: Integer;
  g_nMaxItemMakeIndexEx: Integer;








  g_boLoginOK: Boolean = False;
  g_boLoadOK: Boolean = False;

  g_sHeroDBName: string;
  g_sIDDBFileName: string;
  g_sHumDBFileName: string;
  g_sMirDBFileName: string;

  g_sBigStorageFileName: string;
  g_sSellOffSellFileName: string;
  g_sSellOffGoldFileName: string;
  g_sSetupFileName: string;


  g_boHeroDBName: Boolean;

  g_boIDDBFileName: Boolean;
  g_boHumDBFileName: Boolean;
  g_boMirDBFileName: Boolean;

  g_boBigStorageFileName: Boolean;
  g_boSellOffSellFileName: Boolean;
  g_boSellOffGoldFileName: Boolean;


  g_Config: TConfig = (
    nItemsACPowerRate: 10;
    nItemsPowerRate: 10;
    nMonsterPowerRate: 10;
    );

  g_StatusPane1: TRzStatusPane;
  g_StatusPane2: TRzStatusPane;
  g_StatusPane3: TRzStatusPane;

  g_PanelProgressStatus: TPanel;
  g_ProgressStatus: TProgressBar;
  g_ProgressStatusSub: TProgressBar;
  g_nPercent: Integer;
  g_nCount: Integer;

  g_nPercentSub: Integer;
  g_nCountSub: Integer;


  g_LocalDB: TLocalDB = nil;
  g_FileIDDB: TFileIDDB = nil;
  g_FileHumDB: TFileHumDB = nil;
  g_FileDB: TFileDB = nil;
  g_Storage: TStorage = nil;
  g_SellOff: TSellOff = nil;
  g_SellGold: TSellOff = nil;

  g_DataManage:array [0..5] of TDataManage;

  g_SearchList: TList;

  g_StartProc: array of TStartProc;
function GetGameLogItemNameList(sItemName: string): Byte;
function GetItemNumber(): Integer;
function GetItemNumberEx(): Integer;

procedure ProcessMessage(sMsg: string; Mode: Integer);

procedure ProcessStatus();
procedure StartProcess(nCount: Integer);
procedure EndProcess();

procedure ProcessStatusSub();
procedure StartProcessSub(nCount: Integer);
procedure EndProcessSub();
implementation
procedure ProcessMessage(sMsg: string; Mode: Integer);
begin
  case Mode of
    0: g_StatusPane1.Caption := sMsg;
    1: g_StatusPane2.Caption := sMsg;
    2: g_StatusPane3.Caption := sMsg;
  end;
end;

procedure StartProcess(nCount: Integer);
begin
  g_nPercent := 0;
  g_nCount := nCount;
  g_ProgressStatus.Max:=nCount;
  g_ProgressStatus.Position := g_nPercent;
  //g_ProgressStatus.Percent := g_nPercent;
  g_PanelProgressStatus.Visible := True;
end;

procedure EndProcess();
begin
  g_PanelProgressStatus.Visible := False;
  g_ProgressStatus.Position :=  0;
end;

procedure ProcessStatus();
begin
  Inc(g_nPercent);
  g_ProgressStatus.Position :=  g_nPercent;
 { try
    Inc(g_nPercent);
    g_ProgressStatus.Percent := Trunc(g_nPercent / (g_nCount / 100));
  except
  end; }
end;








procedure StartProcessSub(nCount: Integer);
begin
  g_nPercentSub := 0;
  g_nCountSub := nCount;
  g_ProgressStatusSub.Max:= nCount;
  g_ProgressStatusSub.Position := g_nPercentSub;
  g_ProgressStatusSub.Visible := True;
end;

procedure EndProcessSub();
begin
  g_ProgressStatusSub.Visible := False;
  g_ProgressStatusSub.Position := 0;
end;

procedure ProcessStatusSub();
begin
  Inc(g_nPercentSub);
  g_ProgressStatusSub.Position := g_nPercentSub;
  {try
    Inc(g_nPercentSub);
    g_ProgressStatusSub.Percent := Trunc(g_nPercentSub / (g_nCountSub / 100));
  except
  end; }
end;






function GetGameLogItemNameList(sItemName: string): Byte;
var
  I: Integer;
begin
  Result := 0;
 { g_GameLogItemNameList.Lock;
  try
    for I := 0 to g_GameLogItemNameList.Count - 1 do begin
      if CompareText(sItemName, g_GameLogItemNameList.Strings[I]) = 0 then begin
        Result := 1;
        Break;
      end;
    end;
  finally
    g_GameLogItemNameList.UnLock;
  end; }
end;

function GetItemNumber(): Integer;
begin
  Inc(g_nMaxItemMakeIndex);
  if g_nMaxItemMakeIndex > (High(Integer) div 2 - 1) then begin
    g_nMaxItemMakeIndex := 1;
  end;
  Result := g_nMaxItemMakeIndex;
end;
function GetItemNumberEx(): Integer;
begin
  Inc(g_nMaxItemMakeIndexEx);
  if g_nMaxItemMakeIndexEx < High(Integer) div 2 then g_nMaxItemMakeIndexEx := High(Integer) div 2;

  if g_nMaxItemMakeIndexEx > (High(Integer) - 1) then begin
    g_nMaxItemMakeIndexEx := High(Integer) div 2;
  end;
  Result := g_nMaxItemMakeIndexEx;
end;


end.

