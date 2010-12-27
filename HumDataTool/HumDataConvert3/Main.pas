unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzLabel, RzButton, Mask, RzEdit, RzBtnEdt, RzRadChk,
  RzStatus, ExtCtrls, RzPanel, ShlObj, ActiveX, HumDB, IDDB, Share, zLibEx, EncryptUnit;

type
  TConvertThread = class(TThread) //转换线程
  private
    Datas: array[0..6] of TConvertData;
    procedure UpdateStatus;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
  protected
    procedure Execute; override;
  end;

  TfrmMain = class(TForm)
    CheckBoxMir: TRzCheckBox;
    EditMir: TRzButtonEdit;
    CheckBoxUserStorage: TRzCheckBox;
    CheckBoxGoldOff: TRzCheckBox;
    EditUserStorage: TRzButtonEdit;
    EditSellOff: TRzButtonEdit;
    CheckBoxSellOff: TRzCheckBox;
    EditGoldOff: TRzButtonEdit;
    ButtonConvert: TRzButton;
    RzLabel1: TRzLabel;
    EditSaveDir: TRzButtonEdit;
    StatusBar: TRzStatusBar;
    RzStatusPane: TRzStatusPane;
    OpenDialog: TOpenDialog;
    ProgressStatus: TRzProgressStatus;
    CheckBoxHum: TRzCheckBox;
    EditHum: TRzButtonEdit;
    EditID: TRzButtonEdit;
    CheckBoxID: TRzCheckBox;
    CheckBoxDuel: TRzCheckBox;
    EditDuel: TRzButtonEdit;
    procedure EditSaveDirButtonClick(Sender: TObject);
    procedure ButtonConvertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CheckBoxIDClick(Sender: TObject);
    procedure EditIDButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  ConvertThread: TConvertThread = nil;
  m_nPercent: Integer;
  m_nCount: Integer;
implementation
uses Grobal2;
{$R *.dfm}

procedure ProcessStatus();
begin
  try
    Inc(m_nPercent);
    frmMain.ProgressStatus.Percent := Trunc(m_nPercent / (m_nCount / 100));
  except
  end;
end;

procedure ProcessMessage(sMsg: string);
begin
  frmMain.RzStatusPane.Caption := sMsg;
end;

constructor TConvertThread.Create(CreateSuspended: Boolean); //转换线程
var
  I: Integer;
begin
  inherited Create(CreateSuspended);

  Datas[0] := TFileIDDB.Create(g_sSourceFiles[0]);
  Datas[1] := TFileHumDB.Create(g_sSourceFiles[1]);
  Datas[2] := TFileDB.Create(g_sSourceFiles[2]);
  Datas[3] := TStorage.Create(g_sSourceFiles[3]);
  Datas[4] := TSellOff.Create(g_sSourceFiles[4]);
  Datas[5] := TSellOff.Create(g_sSourceFiles[5]);
  Datas[6] := TFileDuelItem.Create(g_sSourceFiles[6]);

  for I := 0 to Length(Datas) - 1 do begin
    Datas[I].m_boConvert := g_boConverts[I];
    Datas[I].m_sSaveToFileName := g_sSaveDir + g_sFileNames[I];
    Datas[I].m_ProgressStatus := frmMain.ProgressStatus;
    Datas[I].m_RzStatusPane := frmMain.RzStatusPane;
  end;

  TSellOff(Datas[5]).m_boGold := True;
end;

destructor TConvertThread.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Datas) - 1 do Datas[I].Free;
  inherited Destroy;
end;

procedure TConvertThread.UpdateStatus;
begin
  g_boStart := False;

  frmMain.ButtonConvert.Enabled := True;
  frmMain.RzStatusPane.Caption := '转换完成！！！';
  Application.MessageBox('转换完成！！！', '提示信息', MB_ICONQUESTION);
end;

procedure TConvertThread.Execute;
var
  I: Integer;
begin
  for I := 0 to Length(Datas) - 1 do begin
    Datas[I].Load(); //读取
    Datas[I].Convert; //转换
    Datas[I].SaveToFile(); //保存
  end;

  Synchronize(UpdateStatus);
end;

function SelectDirCB(Wnd: HWND; uMsg: UINT; lParam, lpData: lParam): Integer stdcall;
begin
  if (uMsg = BFFM_INITIALIZED) and (lpData <> 0) then
    SendMessage(Wnd, BFFM_SETSELECTION, Integer(True), lpData);
  Result := 0;
end;

function SelectDirectory(const Caption: string; const Root: WideString;
  var Directory: string; Owner: Thandle): Boolean;
var
  WindowList: Pointer;
  BrowseInfo: TBrowseInfo;
  Buffer: PChar;
  RootItemIDList, ItemIDList: PItemIDList;
  ShellMalloc: IMalloc;
  IDesktopFolder: IShellFolder;
  Eaten, Flags: LongWord;
begin
  Result := False;
  if not DirectoryExists(Directory) then
    Directory := '';
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then begin
    Buffer := ShellMalloc.Alloc(MAX_PATH);
    try
      RootItemIDList := nil;
      if Root <> '' then begin
        SHGetDesktopFolder(IDesktopFolder);
        IDesktopFolder.ParseDisplayName(Application.Handle, nil,
          POleStr(Root), Eaten, RootItemIDList, Flags);
      end;
      with BrowseInfo do begin
        hwndOwner := Owner;
        pidlRoot := RootItemIDList;
        pszDisplayName := Buffer;
        lpszTitle := PChar(Caption);
        ulFlags := BIF_RETURNONLYFSDIRS;
        if Directory <> '' then begin
          lpfn := SelectDirCB;
          lParam := Integer(PChar(Directory));
        end;
      end;
      WindowList := DisableTaskWindows(0);
      try
        ItemIDList := ShBrowseForFolder(BrowseInfo);
      finally
        EnableTaskWindows(WindowList);
      end;
      Result := ItemIDList <> nil;
      if Result then begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
        Directory := Buffer;
      end;
    finally
      ShellMalloc.Free(Buffer);
    end;
  end;
end;

//'\'结尾

function ExtractDirectory(const sDirectory: string): string;
var
  I, Count, Len: Integer;
  S: string;
begin
  Result := sDirectory;
  S := sDirectory;
  Count := 0;
  Len := Length(S);

  for I := Len downto 1 do begin
    if S[I] = '\' then Inc(Count) else Break;
  end;

  if Count <= 0 then begin // 结尾没有'\'
    Result := S + '\';
  end else begin
    if Count > 1 then // 结尾有大于1'\'
      Result := Copy(S, 1, Len - Count + 1);
  end;
end;

procedure TfrmMain.EditSaveDirButtonClick(Sender: TObject);
var
  sDir: string;
begin
  sDir := EditSaveDir.Text;
  if SelectDirectory('浏览文件夹', '', sDir, Handle) then begin
    EditSaveDir.Text := ExtractDirectory(sDir);
  end;
end;

procedure TfrmMain.ButtonConvertClick(Sender: TObject);
var
  I: Integer;
begin
  if g_boStart then begin
    Application.MessageBox('正在转换 ！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;

  for I := 0 to Length(g_ButtonEdit) - 1 do begin
    g_sSourceFiles[I] := Trim(g_ButtonEdit[I].Text);
  end;

  {g_sSourceFiles[0] := Trim(EditID.Text);
  g_sSourceFiles[1] := Trim(EditHum.Text);
  g_sSourceFiles[2] := Trim(EditMir.Text);
  g_sSourceFiles[3] := Trim(EditUserStorage.Text);
  g_sSourceFiles[4] := Trim(EditSellOff.Text);
  g_sSourceFiles[5] := Trim(EditGoldOff.Text);
  g_sSourceFiles[6] := Trim(EditDuel.Text);    }
  g_sSaveDir := ExtractDirectory(EditSaveDir.Text);

  for I := 0 to Length(g_boConverts) - 1 do begin
    if g_boConverts[I] then begin
      if not FileExists(g_sSourceFiles[I]) then begin
        Application.MessageBox(PChar(Format('没有发现: %s ！！！', [g_sFileNames[I]])), '提示信息', MB_ICONQUESTION);
        Exit;
      end;
    end;
  end;

  if g_sSaveDir = '' then begin
    Application.MessageBox('请设置数据库保存目录 ！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;

  if not DirectoryExists(g_sSaveDir) then
    if not CreateDir(g_sSaveDir) then begin
      Application.MessageBox(PChar(Format('无法创建保存目录:%s ！！！', [g_sSaveDir])), '提示信息', MB_ICONQUESTION);
      Exit;
    end;
  g_boStart := True;
  g_boClose := False;

  ButtonConvert.Enabled := False;
  ConvertThread := TConvertThread.Create(False);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  g_boStart := False;
  g_boClose := False;
  EditSaveDir.Text := ExtractFilePath(Application.ExeName);
  g_ButtonEdit[0] := EditID;
  g_ButtonEdit[1] := EditHum;
  g_ButtonEdit[2] := EditMir;
  g_ButtonEdit[3] := EditUserStorage;
  g_ButtonEdit[4] := EditSellOff;
  g_ButtonEdit[5] := EditGoldOff;
  g_ButtonEdit[6] := EditDuel;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not g_boStart;
end;

procedure TfrmMain.CheckBoxIDClick(Sender: TObject);
var
  CheckBox: TRzCheckBox;
begin
  CheckBox := TRzCheckBox(Sender);
  if not g_boStart then begin
    g_boConverts[CheckBox.Tag] := CheckBox.Checked;
  end else begin
    CheckBox.Checked := g_boConverts[CheckBox.Tag];
  end;
  g_ButtonEdit[CheckBox.Tag].Enabled := CheckBox.Checked;
end;

procedure TfrmMain.EditIDButtonClick(Sender: TObject);
var
  Edit: TRzButtonEdit;
begin
  Edit := TRzButtonEdit(Sender);
  OpenDialog.Filter := g_sFilters[Edit.Tag];
  if OpenDialog.Execute then begin
    g_ButtonEdit[Edit.Tag].Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  HumanRCD: THumDataInfo;

  Buffer, OutBuf: Pointer;
  I, OutBytes: Integer;
  S: string;
  dwTick: LongWord;
begin
  //FillChar(HumanRCD, SizeOf(THumDataInfo), #0);
  dwTick := GetTickCount;
  for I := 0 to 1000 do begin
    CompressBuf(@HumanRCD, SizeOf(THumDataInfo), OutBuf, OutBytes);
    S := EncodeBuffer(@(OutBuf)^, OutBytes);

  //Showmessage(IntToStr(Length(S)) + ' dwTick:' + IntToStr(GetTickCount - dwTick));

    FreeMem(OutBuf);
    OutBuf := nil;
  end;
  Showmessage(IntToStr(Length(S)) + ' dwTick:' + IntToStr(GetTickCount - dwTick));
  Exit;

  GetMem(Buffer, OutBytes);
  FillChar(Buffer^, OutBytes, 0);

  dwTick := GetTickCount;
  DecodeBuffer(S, @(Buffer^), OutBytes);
  OutBytes := 0;
  DecompressBuf(@(Buffer^), OutBytes, 0, OutBuf, OutBytes);

  //Showmessage(IntToStr(OutBytes) + ' dwTick:' + IntToStr(GetTickCount - dwTick));

  FreeMem(OutBuf);
  OutBuf := nil;
end;

end.

