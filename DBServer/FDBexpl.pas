unit FDBexpl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, Grobal2, HumDB;
type
  TFrmFDBExplore = class(TForm)
    ListBox1: TListBox;
    EdFind: TEdit;
    Label1: TLabel;
    BtnAdd: TButton;
    BtnDel: TButton;
    ListBox2: TListBox;
    BtnRebuild: TButton;
    BtnBlankCount: TButton;
    GroupBox1: TGroupBox;
    BtnAutoClean: TButton;
    Timer1: TTimer;
    BtnCopyRcd: TButton;
    BtnCopyNew: TButton;
    CkLv1: TCheckBox;
    CkLv7: TCheckBox;
    CkLv14: TCheckBox;

    procedure BtnDelClick(Sender: TObject);
    procedure BtnRebuildClick(Sender: TObject);
    procedure BtnBlankCountClick(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnAddFromFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnAutoCleanClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BtnCopyRcdClick(Sender: TObject);
    procedure BtnCopyNewClick(Sender: TObject);
    procedure EdFindKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    SList_320: TStringList;
    function ClearHumanItem(var ChrRecord: THumDataInfo): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFDBExplore: TFrmFDBExplore;


implementation

uses NewChr, frmcpyrcd, Main, DBShare;

{$R *.DFM}

procedure TFrmFDBExplore.EdFindKeyPress(Sender: TObject; var Key: Char);
var
  i: Integer;
  sChrName: string;
begin
  if Key <> #13 then Exit;
  sChrName := Trim(EdFind.Text);
  if sChrName = '' then Exit;
  ListBox1.Clear;
  ListBox2.Clear;

  try
    if g_HumDataDB.OpenEx then begin
      g_HumDataDB.Find(sChrName, ListBox1.Items);
      for i := 0 to ListBox1.Items.Count - 1 do begin
        ListBox2.Items.Add(IntToStr(Integer(ListBox1.Items.Objects[i])));
      end;
    end;
  finally
    g_HumDataDB.Close;
  end;
end;

procedure TFrmFDBExplore.BtnDelClick(Sender: TObject);
var
  nIndex: Integer;
begin
  if ListBox1.ItemIndex <= -1 then Exit;
  nIndex := Integer(ListBox1.Items.Objects[ListBox1.ItemIndex]);
  if MessageDlg('是否确认删除人物数据 ' + IntToStr(nIndex) + ' ？', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    try
      if g_HumDataDB.Open then begin
        g_HumDataDB.Delete(nIndex);
      end;
    finally
      g_HumDataDB.Close;
    end;
  end;
end;

procedure TFrmFDBExplore.BtnRebuildClick(Sender: TObject); //0x004A5B64
begin
  if MessageDlg('在重建数据库过程中，数据库服务器将停止工作，是否确认继续？', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    //boAutoClearDB := False;
    g_HumDataDB.Rebuild();
    MessageDlg('数据库重建完成！！！', mtInformation, [mbOK], 0);
  end;
end;

procedure TFrmFDBExplore.BtnBlankCountClick(Sender: TObject);
begin
  ListBox1.Clear;
  ListBox2.Clear;
end;

procedure TFrmFDBExplore.BtnAddClick(Sender: TObject);
var
  sChrName: string;
begin
  FrmNewChr.sub_49BD60(sChrName);
  //FrmUserSoc.NewChrData(sChrName, 0, 0, 0, False);
end;

procedure TFrmFDBExplore.BtnAddFromFileClick(Sender: TObject);
begin
  (*
  004A5D30   55                     push    ebp
  004A5D31   8BEC                   mov     ebp, esp
  004A5D33   83C4F8                 add     esp, -$08
  004A5D36   8955F8                 mov     [ebp-$08], edx
  004A5D39   8945FC                 mov     [ebp-$04], eax
  004A5D3C   59                     pop     ecx
  004A5D3D   59                     pop     ecx
  004A5D3E   5D                     pop     ebp
  004A5D3F   C3                     ret

  *)
end;

procedure TFrmFDBExplore.FormCreate(Sender: TObject);
begin
  Timer1.Interval := dwInterval;
  Timer1.Enabled := True;
  SList_320 := TStringList.Create;
  g_nClearIndex := 0;
  g_nClearCount := 0;
  g_nClearItemIndexCount := 0;
end;

procedure TFrmFDBExplore.BtnAutoCleanClick(Sender: TObject);
begin
  boAutoClearDB := not boAutoClearDB;
  if boAutoClearDB then BtnAutoClean.Caption := '自动清理'
  else BtnAutoClean.Caption := '已停止清理';
end;

procedure TFrmFDBExplore.Timer1Timer(Sender: TObject);
//0x004A5EDC
  function GetDateTime(wM, wD: Word): TDateTime;
  var
    Year, Month, Day: Word;
    i: Integer;
  begin
    DecodeDate(Now, Year, Month, Day);
    for i := 0 to wM - 1 do begin
      if Month > 1 then Dec(Month)
      else begin
        Month := 12;
        Dec(Year);
      end;
    end;
    for i := 0 to wD - 1 do begin
      if Day > 1 then Dec(Day)
      else begin
        Day := 28;
        if Month > 1 then Dec(Month)
        else begin
          Month := 12;
          Dec(Year);
        end;
      end;
    end;
    Result := EncodeDate(Year, Month, Day);
  end;
var
  w32, wDayCount1, wLevel1, w38, wDayCount7, wLevel7, w3E, wDayCount14, wLevel14: Word;
  dt20, dt28, dt30: TDateTime;
  n8, n10: Integer;

  sHumName: string;
  ChrRecord: THumDataInfo;
begin
  if not boAutoClearDB then Exit;
  w32 := 0;
  w38 := 0;
  w3E := 0;
  wDayCount1 := 0;
  wDayCount7 := 0;
  wDayCount14 := 0;
  wLevel1 := 0;
  wLevel7 := 0;
  wLevel14 := 0;
  if CkLv1.Checked then begin
    w32 := nMonth1;
    wDayCount1 := nDay1;
    wLevel1 := nLevel1;
  end;
  if CkLv7.Checked then begin
    w38 := nMonth2;
    wDayCount7 := nDay2;
    wLevel7 := nLevel2;
  end;
  if CkLv14.Checked then begin
    w3E := nMonth3;
    wDayCount14 := nDay3;
    wLevel14 := nLevel3;
  end;
  dt20 := GetDateTime(w32, wDayCount1);
  dt28 := GetDateTime(w38, wDayCount7);
  dt30 := GetDateTime(w3E, wDayCount14);
  g_nClearRecordCount := 0;
  sHumName := '';
  try
    if g_HumDataDB.Open then begin
      g_nClearRecordCount := g_HumDataDB.Count;
      if g_nClearIndex < g_nClearRecordCount then begin
        n8 := g_HumDataDB.Get(g_nClearIndex, ChrRecord);
        if n8 >= 0 then begin
          if ((ChrRecord.Header.dCreateDate < dt20) and (ChrRecord.Data.Abil.Level <= wLevel1)) or
            ((ChrRecord.Header.dCreateDate < dt28) and (ChrRecord.Data.Abil.Level <= wLevel7)) or
            ((ChrRecord.Header.dCreateDate < dt30) and (ChrRecord.Data.Abil.Level <= wLevel14)) then begin
            n10 := n8;
            sHumName := ChrRecord.Header.sName;
            g_HumDataDB.Delete(n10);
            Inc(g_nClearCount);
          end else begin
            if ClearHumanItem(ChrRecord) then begin
              g_HumDataDB.Update(g_nClearIndex, ChrRecord);
            end;
          end;
          Inc(g_nClearIndex);
        end;
      end else g_nClearIndex := 0;
    end;
  finally
    g_HumDataDB.Close;
  end;
  if sHumName <> '' then begin
    FrmDBSrv.DelHum(sHumName);
  end;
  //  FrmDBSrv.LbAutoClean.Caption:=IntToStr(g_nClearIndex) + '/' + IntToStr(g_nClearCount) + '/' + IntToStr(g_nClearRecordCount);
end;

function TFrmFDBExplore.ClearHumanItem(var ChrRecord: THumDataInfo): Boolean;
var
  i: Integer;
  HumItems: array of THumItems;
  HumAddItems: array of THumItems;
  UserItem: pTUserItem;
  Item: pTUserItem;
  SaveList: TStringList;
  ClearList: TList;
  sFileName: string;
  sMsg: string;
begin
  Result := False;
  ClearList := nil;
  //ChrRecord.Data.HumItems
  //HumItems:=@ChrRecord.Data.HumItems;
  for i := Low(ChrRecord.Data.HumItems) to High(ChrRecord.Data.HumItems) do begin
    UserItem := @ChrRecord.Data.HumItems[i];
    if UserItem.wIndex <= 0 then Continue;
    if InClearMakeIndexList(UserItem.MakeIndex) then begin
      if ClearList = nil then ClearList := TList.Create;
      New(Item);
      Item^ := UserItem^;
      ClearList.Add(Item);
      UserItem.wIndex := 0;
      Result := True;
    end;
  end;
  //HumAddItems:=@ChrRecord.Data.
  for i := Low(ChrRecord.Data.HumAddItems) to High(ChrRecord.Data.HumAddItems) do begin
    UserItem := @ChrRecord.Data.HumAddItems[i];
    if UserItem.wIndex <= 0 then Continue;
    if InClearMakeIndexList(UserItem.MakeIndex) then begin
      if ClearList = nil then ClearList := TList.Create;
      New(Item);
      Item^ := UserItem^;
      ClearList.Add(Item);

      UserItem.wIndex := 0;
      Result := True;
    end;
  end;
  for i := Low(ChrRecord.Data.BagItems) to High(ChrRecord.Data.BagItems) do begin
    UserItem := @ChrRecord.Data.BagItems[i];
    if UserItem.wIndex <= 0 then Continue;
    if InClearMakeIndexList(UserItem.MakeIndex) then begin
      if ClearList = nil then ClearList := TList.Create;
      New(Item);
      Item^ := UserItem^;
      ClearList.Add(Item);
      UserItem.wIndex := 0;
      Result := True;
    end;
  end;
  for i := Low(ChrRecord.Data.StorageItems) to High(ChrRecord.Data.StorageItems) do begin
    UserItem := @ChrRecord.Data.StorageItems[i];
    if UserItem.wIndex <= 0 then Continue;
    if InClearMakeIndexList(UserItem.MakeIndex) then begin
      if ClearList = nil then ClearList := TList.Create;
      New(Item);
      Item^ := UserItem^;
      ClearList.Add(Item);

      UserItem.wIndex := 0;
      Result := True;
    end;
  end;
  if Result then begin
    Inc(g_nClearItemIndexCount, ClearList.Count);

    SaveList := TStringList.Create;
    sFileName := 'ClearItemLog.txt';
    if FileExists(sFileName) then begin
      SaveList.LoadFromFile(sFileName);
    end;
    for i := 0 to ClearList.Count - 1 do begin
      UserItem := ClearList.Items[i];
      sMsg := ChrRecord.Data.sChrName + #9 + IntToStr(UserItem.wIndex) + #9 + IntToStr(UserItem.MakeIndex);
      SaveList.Insert(0, sMsg);
      Dispose(UserItem);
    end;
    SaveList.SaveToFile(sFileName);
    SaveList.Free;
  end;
  if ClearList <> nil then ClearList.Free;
end;
procedure TFrmFDBExplore.BtnCopyRcdClick(Sender: TObject);
//0x004A6220
var
  sSrcChrName, sDestChrName, sUserId: string;
begin
  if not FrmCopyRcd.sub_49C09C then Exit;
  sSrcChrName := FrmCopyRcd.s2F0;
  sDestChrName := FrmCopyRcd.s2F4;
  sUserId := FrmCopyRcd.s2F8;
  if FrmDBSrv.CopyHumData(sSrcChrName, sDestChrName, sUserId) then
    ShowMessage(sSrcChrName + ' -> ' + sDestChrName + ' 复制成功！！！');
end;

procedure TFrmFDBExplore.BtnCopyNewClick(Sender: TObject);
//0x004A631C
var
  sSrcChrName, sDestChrName, sUserId: string;
begin
  if not FrmCopyRcd.sub_49C09C then Exit;
  sSrcChrName := FrmCopyRcd.s2F0;
  sDestChrName := FrmCopyRcd.s2F4;
  sUserId := FrmCopyRcd.s2F8;
  if FrmUserSoc.NewChrData(sDestChrName, 0, 0, 0, False) and
    FrmDBSrv.CopyHumData(sSrcChrName, sDestChrName, sUserId) then
    ShowMessage(sSrcChrName + ' -> ' + sDestChrName + ' 复制成功！！！');
end;


procedure TFrmFDBExplore.FormDestroy(Sender: TObject);
begin
  SList_320.Free;
end;

end.
