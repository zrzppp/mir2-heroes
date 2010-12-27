unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzLabel, RzButton, Mask, RzEdit, RzBtnEdt, RzRadChk,
  RzStatus, ExtCtrls, RzPanel, ShlObj, ActiveX, HumDB, Share;

type
  TConvertThread = class(TThread) //转换线程
  private
    Datas: array[0..3] of TConvertData;
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
    Timer: TTimer;
    ProgressStatus: TRzProgressStatus;
    RzRadioButton1: TRzRadioButton;
    RzRadioButton2: TRzRadioButton;
    RzRadioButton3: TRzRadioButton;
    procedure EditSaveDirButtonClick(Sender: TObject);
    procedure EditMirButtonClick(Sender: TObject);
    procedure EditUserStorageButtonClick(Sender: TObject);
    procedure EditSellOffButtonClick(Sender: TObject);
    procedure EditGoldOffButtonClick(Sender: TObject);
    procedure ButtonConvertClick(Sender: TObject);
    procedure CheckBoxMirClick(Sender: TObject);
    procedure CheckBoxUserStorageClick(Sender: TObject);
    procedure CheckBoxSellOffClick(Sender: TObject);
    procedure CheckBoxGoldOffClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RzRadioButton1Click(Sender: TObject);
    procedure RzRadioButton2Click(Sender: TObject);
    procedure RzRadioButton3Click(Sender: TObject);
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
  for I := 0 to 3 do begin
    case I of
      0: Datas[I] := TFileDB.Create(g_sSourceFiles[I]);
      1: Datas[I] := TStorage.Create(g_sSourceFiles[I]);
      2: Datas[I] := TSellOff.Create(g_sSourceFiles[I]);
      3: Datas[I] := TSellOff.Create(g_sSourceFiles[I]);
    end;
    Datas[I].m_boConvert := g_boConverts[I];
    Datas[I].m_sSaveToFileName := g_sSaveDir + g_sFileNames[I];
    Datas[I].m_boOldHero := g_boOldHero;
    Datas[I].m_ProgressStatus := frmMain.ProgressStatus;
    Datas[I].m_RzStatusPane := frmMain.RzStatusPane;
  end;
  TSellOff(Datas[3]).m_boGold := True;
end;

destructor TConvertThread.Destroy;
var
  I: Integer;
begin
  for I := 0 to 3 do Datas[I].Free;
  inherited Destroy;
end;

procedure TConvertThread.Execute;
var
  I: Integer;
begin
  for I := 0 to 3 do begin
    Datas[I].Load(); //读取
    Datas[I].Convert; //转换
    Datas[I].SaveToFile(); //保存
  end;
  frmMain.Timer.Enabled := True;
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

  if Count <= 0 then begin   // 结尾没有'\'
    Result := S + '\';
  end else begin
    if Count > 1 then   // 结尾有大于1'\'
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

procedure TfrmMain.EditMirButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'Mir.db|*.db';
  if OpenDialog.Execute then begin
    EditMir.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditUserStorageButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'UserStorage.db|*.db';
  if OpenDialog.Execute then begin
    EditUserStorage.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditSellOffButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'UserSellOff.sell|*.Sell';
  if OpenDialog.Execute then begin
    EditSellOff.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditGoldOffButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'UserSellOff.Gold|*.Gold';
  if OpenDialog.Execute then begin
    EditGoldOff.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.ButtonConvertClick(Sender: TObject);
begin
  g_sSourceFiles[0] := Trim(EditMir.Text);
  g_sSourceFiles[1] := Trim(EditUserStorage.Text);
  g_sSourceFiles[2] := Trim(EditSellOff.Text);
  g_sSourceFiles[3] := Trim(EditGoldOff.Text);
  g_sSaveDir := ExtractDirectory(EditSaveDir.Text);
  if g_boConverts[0] then begin
    if not FileExists(g_sSourceFiles[0]) then begin
      Application.MessageBox('没有发现: Mir.DB ！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
  end;
  if g_boConverts[1] then begin
    if not FileExists(g_sSourceFiles[1]) then begin
      Application.MessageBox('没有发现: UserStorage.DB ！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
  end;
  if g_boConverts[2] then begin
    if not FileExists(g_sSourceFiles[2]) then begin
      Application.MessageBox('没有发现: UserSellOff.sell ！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
  end;

  if g_boConverts[3] then begin
    if not FileExists(g_sSourceFiles[3]) then begin
      Application.MessageBox('没有发现: UserSellOff.Gold ！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
  end;

  if g_sSaveDir = '' then begin
    Application.MessageBox('请设置数据库保存目录 ！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;

  if not DirectoryExists(g_sSaveDir) then CreateDir(g_sSaveDir);
  g_boStart := True;
  g_boClose := False;

  ConvertThread := TConvertThread.Create(False);
  ButtonConvert.Enabled := False;
end;

procedure TfrmMain.CheckBoxMirClick(Sender: TObject);
begin
  if not g_boStart then begin
    g_boConverts[0] := CheckBoxMir.Checked;
  end else begin
    CheckBoxMir.Checked := g_boConverts[0];
  end;
  EditMir.Enabled := CheckBoxMir.Checked;
end;

procedure TfrmMain.CheckBoxUserStorageClick(Sender: TObject);
begin
  if not g_boStart then begin
    g_boConverts[1] := CheckBoxUserStorage.Checked;
  end else begin
    CheckBoxUserStorage.Checked := g_boConverts[1];
  end;
  EditUserStorage.Enabled := CheckBoxUserStorage.Checked;
end;

procedure TfrmMain.CheckBoxSellOffClick(Sender: TObject);
begin
  if not g_boStart then begin
    g_boConverts[2] := CheckBoxSellOff.Checked;
  end else begin
    CheckBoxSellOff.Checked := g_boConverts[2];
  end;
  EditSellOff.Enabled := CheckBoxSellOff.Checked;
end;

procedure TfrmMain.CheckBoxGoldOffClick(Sender: TObject);
begin
  if not g_boStart then begin
    g_boConverts[3] := CheckBoxGoldOff.Checked;
  end else begin
    CheckBoxGoldOff.Checked := g_boConverts[3];
  end;
  EditGoldOff.Enabled := CheckBoxGoldOff.Checked;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  g_boStart := False;
  g_boClose := False;
  EditSaveDir.Text := ExtractFilePath(Application.ExeName);
end;

procedure TfrmMain.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;
  g_boStart := False;
  ButtonConvert.Enabled := True;
  Application.MessageBox('转换完成！！！', '提示信息', MB_ICONQUESTION);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not g_boStart;
end;
{
  showmessage(IntToStr(SizeOf(TOHumDataInfo)));

  showmessage(IntToStr(SizeOf(THumDataInfo)));
}
procedure TfrmMain.RzRadioButton1Click(Sender: TObject);
begin
  if not g_boStart then begin
    g_boOldHero := not RzRadioButton1.Checked;
  end else begin
    RzRadioButton1.Checked := not g_boOldHero;
  end;
end;

procedure TfrmMain.RzRadioButton2Click(Sender: TObject);
begin
  if not g_boStart then begin
    g_boOldHero := RzRadioButton2.Checked;
  end else begin
    RzRadioButton2.Checked := g_boOldHero;
  end;
end;

procedure TfrmMain.RzRadioButton3Click(Sender: TObject);
begin
  if not g_boStart then begin
    g_boNewHero := RzRadioButton3.Checked;
  end else begin
    RzRadioButton3.Checked := g_boNewHero;
  end;
end;

{

  Showmessage(IntToStr(SizeOf(TOOHumDataInfo)));
  Showmessage(IntToStr(SizeOf(TOHumDataInfo)));
}
end.

