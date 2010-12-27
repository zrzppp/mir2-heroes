unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ComCtrls, EngineInterface, ShlObj, ActiveX, Mask,
  RzEdit, RzBtnEdt, EncryptUnit, Clipbrd, Common;

type
  TDeCodeScript = record
    sFileName: string;
    FileList: TStringList;
  end;
  pTDeCodeScript = ^TDeCodeScript;

  TDeCryptString = procedure(Src, Dest: PChar; nSrc: Integer); stdcall;
  TStart = procedure();

  TFrmMain = class(TForm)
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ButtonSelEncodeFile: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    ButtonSelDecodeFile: TButton;
    Label1: TLabel;
    ButtonDecode: TButton;
    ButtonEncode: TButton;
    EditPassWord: TEdit;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    EditMirserver: TRzButtonEdit;
    Label3: TLabel;
    EditPassWord1: TEdit;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    GroupBox2: TGroupBox;
    ListBoxFile: TListBox;
    TabSheet4: TTabSheet;
    ButtonEncode1: TButton;
    ButtonSearch: TButton;
    GroupBox4: TGroupBox;
    ListBoxEncodeList: TListBox;
    PopupMenu3: TPopupMenu;
    MenuItem1: TMenuItem;
    PopupMenu4: TPopupMenu;
    MenuItem2: TMenuItem;
    LabeMsg: TLabel;
    ButtonSearchEncodeFile: TButton;
    EditSave: TRzButtonEdit;

    Label4: TLabel;
    MemoLog: TMemo;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    procedure ButtonSelEncodeFileClick(Sender: TObject);
    procedure ButtonSelDecodeFileClick(Sender: TObject);
    procedure ButtonEncodeClick(Sender: TObject);
    procedure ButtonDecodeClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EditMirserverButtonClick(Sender: TObject);
    procedure ButtonSearchClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure ButtonEncode1Click(Sender: TObject);
    procedure ButtonSearchEncodeFileClick(Sender: TObject);
    procedure EditSaveButtonClick(Sender: TObject);

    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure ListBoxFileDblClick(Sender: TObject);
    procedure ListBoxEncodeListDblClick(Sender: TObject);
  private
    { Private declarations }

    ButtonScriptPlug: TButton;
    procedure ButtonScriptPlugClick(Sender: TObject);
  public

    { Public declarations }
  end;
var
  FrmMain: TFrmMain;
  QuitFlag: Boolean;

  SearchFileList: TStringList;
  DirectoryList: TStringList;
  sMirServer: string;
  boWork: Boolean;
const
  SHAREVERSION = 0;
  BASEVERSION = 1;
  SUPERVERSION = 2;
  USERMODE = SUPERVERSION;
procedure MainMessage(Msg: PChar; nMsgLen: Integer; nMode: Integer); stdcall;
implementation
{$R *.dfm}

procedure MainMessage(Msg: PChar; nMsgLen: Integer; nMode: Integer);
var
  MsgBuff: string;
begin
  if (Msg <> nil) and (nMsgLen > 0) then begin
    SetLength(MsgBuff, nMsgLen);
    Move(Msg^, MsgBuff[1], nMsgLen);
    FrmMain.Memo1.Lines.Add(MsgBuff);
  end;
end;

function SelectDirCB(Wnd: HWnd; uMsg: UINT; lParam, lpData: lParam): Integer stdcall;
begin
  if (uMsg = BFFM_INITIALIZED) and (lpData <> 0) then
    SendMessage(Wnd, BFFM_SETSELECTION, Integer(True), lpData);
  Result := 0;
end;

function SelectDirectory(const Caption: string; const Root: WideString;
  var Directory: string; Owner: THandle): Boolean;
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

function CompareLStr(Src, targ: string; compn: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if compn <= 0 then Exit;
  if Length(Src) < compn then Exit;
  if Length(targ) < compn then Exit;
  Result := True;
  for I := 1 to compn do
    if UpCase(Src[I]) <> UpCase(targ[I]) then begin
      Result := False;
      Break;
    end;
end;

function IsEnCodeStringList(List: TStringList): Boolean;
var
  sLine: string;
const
  sENCYPTSCRIPTFLAG = ';+++++++----------------';
begin
  Result := False;
  if List.Count > 0 then begin
    sLine := List.Strings[0];
    Result := CompareLStr(sLine, sENCYPTSCRIPTFLAG, Length(sENCYPTSCRIPTFLAG));
  end;
end;

function IsDirectory(sDirectory: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to DirectoryList.Count - 1 do begin
    if Pos(DirectoryList.Strings[I], sDirectory) > 0 then begin
      Result := True;
      Break;
    end;
  end;
end;

function GetDirectory(sDirectory: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to DirectoryList.Count - 1 do begin
    if Pos(DirectoryList.Strings[I], sDirectory) > 0 then begin
      Result := DirectoryList.Strings[I];
      Break;
    end;
  end;
end;

function GetDir(sAddr: string): string;
var
  H, S, D: string;
  j: Integer;
begin
  S := sAddr;
  D := sAddr;
  j := Pos('\', D);
  while Pos('\', D) <> 0 do begin
    D := Copy(D, Pos('\', D) + 1, Length(D));
    j := j + Pos('\', D);
  end;
  Result := Copy(S, 1, j); //得到目录
end;

procedure AddSearchFile(FileDir, FileName: string);
var
  sFileDir: string;
  List: TStringList;
  I: Integer;
  boFound: Boolean;
begin
  sFileDir := GetDirectory(FileDir);
  if sFileDir <> '' then begin
    boFound := False;
    List := nil;
    for I := 0 to SearchFileList.Count - 1 do begin
      if CompareText(SearchFileList.Strings[I], sFileDir) = 0 then begin
        List := TStringList(SearchFileList.Objects[I]);
        boFound := True;
        Break;
      end;
    end;
    if not boFound then begin
      List := TStringList.Create;
      SearchFileList.AddObject(sFileDir, List);
    end;
    if List <> nil then begin
      if sMirServer = '' then begin
        sMirServer := Copy(FileDir, 1, Pos(sFileDir, FileDir) - 1 {- Length(sFileDir)});
      end;
      sFileDir := Copy(FileDir, Pos(sFileDir, FileDir), Length(FileDir) - Pos(sFileDir, FileDir));
      List.Add(sFileDir + '\' + FileName);
    end;
  end;
end;

procedure UnSearchFileList();
var
  I: Integer;
begin
  for I := 0 to SearchFileList.Count - 1 do begin
    TStringList(SearchFileList.Objects[I]).Free;
  end;
  SearchFileList.Clear;
end;

procedure DoSearchFile(Path: string);
var
  Info: TsearchRec;
  ssMask: string;
  function IsFileExtractName(sMask: string): Boolean;
  var
    sFileExt: string;
  begin
    sFileExt := ExtractFileExt(Info.Name);
    Result := CompareText(sFileExt, sMask) = 0;
  end;

  procedure ProcessAFile(FileDir, FileName: string);
  var
    S, s01: string;
  begin
    s01 := '.txt';
    if IsFileExtractName(s01) then begin
      S := FileDir + FileName;
      FrmMain.LabeMsg.Caption := '正在搜索：' + S;
      AddSearchFile(FileDir, FileName);
    end;
  end;

  function IsDir: Boolean;
  begin
    with Info do
      Result := (Name <> '.') and (Name <> '..') and ((Attr and faDirectory) = faDirectory);
  end;

  function IsFile: Boolean;
  var
    sDirectoryName: string;
  begin
    Result := False;
    if IsDirectory(Path) then
      Result := not ((Info.Attr and faDirectory) = faDirectory);
  end;

begin
  Path := IncludeTrailingBackslash(Path);
  try
    if FindFirst(Path + '*.*', faAnyFile, Info) = 0 then
      if IsFile then
        ProcessAFile(Path, Info.Name)
      else if IsDir then DoSearchFile(Path + Info.Name);
    while FindNext(Info) = 0 do begin
      if IsDir then
        DoSearchFile(Path + Info.Name)
      else if IsFile then
        ProcessAFile(Path, Info.Name);
      Application.ProcessMessages;
      if QuitFlag then Break;
      //Sleep(10);
    end;
  finally
    FindClose(Info);
  end;
end;

procedure TFrmMain.ButtonSelEncodeFileClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    Memo2.Lines.Clear;
    Memo2.Lines.LoadFromFile(OpenDialog1.FileName);
  end;
end;

procedure TFrmMain.ButtonSelDecodeFileClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    Memo1.Lines.Clear;
    Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
  end;
end;

procedure TFrmMain.ButtonEncodeClick(Sender: TObject);
const
  sFirstStr = ';+++++++----------------';
var
  I: Integer;
  sLineText, sKey: string;
  List: TStringList;
begin
  sKey := EditPassWord.Text;
  if sKey = '' then begin
    Application.MessageBox('请输入密码！！！', '提示信息', MB_ICONASTERISK);
    Exit;
  end;
  //Memo2.Lines.Add(sFirstStr);
  ButtonEncode.Enabled := False;
  List := TStringList.Create;
  List.Add(sFirstStr);
  for I := 0 to Memo1.Lines.Count - 1 do begin
    Application.ProcessMessages;
    sLineText := Memo1.Lines.Strings[I];
    if sLineText <> '' then begin
      try
        sLineText := EncryStrHex3(sLineText, sKey);
      except
        sLineText := Memo1.Lines.Strings[I];
      end;
    end;
    List.Add(sLineText);
  end;
  Memo2.Lines.Clear;
  Memo2.Lines.AddStrings(List);
  List.Free;
  ButtonEncode.Enabled := True;
end;

procedure TFrmMain.ButtonDecodeClick(Sender: TObject);
var
  I: Integer;
  sLineText, Str: string;
  sKey: string;
  List: TStringList;
begin
{$IF USERMODE = SHAREVERSION}
  Application.MessageBox('免费版没有解密功能！！！', '提示信息', MB_ICONASTERISK);
{$ELSE}
  sKey := EditPassWord.Text;
  if sKey = '' then begin
    Application.MessageBox('请输入密码！！！', '提示信息', MB_ICONASTERISK);
    Exit
  end;
  if (Memo2.Lines.Count = 0) or ((Memo2.Lines.Count > 0) and (Memo2.Lines.Strings[0] <> ';+++++++----------------')) then begin
    Application.MessageBox('请选择加密脚本！！！', '提示信息', MB_ICONASTERISK);
    Exit
  end;
  ButtonDecode.Enabled := False;
  List := TStringList.Create;
  try
    for I := 1 to Memo2.Lines.Count - 1 do begin
      Application.ProcessMessages;
      sLineText := Trim(Memo2.Lines.Strings[I]);
      if sLineText <> '' then begin
        try
          sLineText := DecryStrHex3(sLineText, sKey);
        except
          sLineText := Memo2.Lines.Strings[I];
        end;
      end;
      List.Add(sLineText);
    end;
    Memo1.Lines.Clear;
    Memo1.Lines.AddStrings(List);

  except
    Application.MessageBox('解密失败！   ', '提示信息', MB_ICONHAND);
  end;
  List.Free;
  ButtonDecode.Enabled := True;
{$IFEND}
end;

procedure TFrmMain.N2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Memo1.Lines.SaveToFile(OpenDialog1.FileName);
end;

procedure TFrmMain.N10Click(Sender: TObject);
begin
  Memo1.SelectAll;
end;

procedure TFrmMain.N1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TFrmMain.N4Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Memo2.Lines.SaveToFile(OpenDialog1.FileName);
end;

procedure TFrmMain.N6Click(Sender: TObject);
begin
  Memo1.CutToClipboard;
end;

procedure TFrmMain.N7Click(Sender: TObject);
begin
  Memo1.CopyToClipboard;
end;

procedure TFrmMain.N8Click(Sender: TObject);
begin
  Memo1.PasteFromClipboard;
end;

procedure TFrmMain.N9Click(Sender: TObject);
begin
  Memo1.ClearSelection;
end;

procedure TFrmMain.PopupMenu1Popup(Sender: TObject);
var
  Clipboard: TClipboard;
begin
  N6.Enabled := Memo1.SelText <> '';
  N7.Enabled := Memo1.SelText <> '';
  N9.Enabled := Memo1.SelText <> '';
  N10.Enabled := (Memo1.Lines.Text <> '') and (Memo1.SelText <> Memo1.Lines.Text);
  Clipboard := TClipboard.Create;
  N8.Enabled := Clipboard.AsText <> '';
  Clipboard.Free;
end;

procedure TFrmMain.PopupMenu2Popup(Sender: TObject);
var
  Clipboard: TClipboard;
begin
  MenuItem3.Enabled := Memo2.SelText <> '';
  MenuItem4.Enabled := Memo2.SelText <> '';
  MenuItem6.Enabled := Memo2.SelText <> '';
  MenuItem8.Enabled := (Memo2.Lines.Text <> '') and (Memo2.SelLength < Length(Memo2.Lines.Text));
  Clipboard := TClipboard.Create;
  MenuItem5.Enabled := Clipboard.AsText <> '';
  Clipboard.Free;
end;

procedure TFrmMain.N3Click(Sender: TObject);
begin
  Memo2.Lines.Clear;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 0;
  sMirServer := '';
  boWork := False;
  QuitFlag := False;
  SearchFileList := TStringList.Create;
  DirectoryList := TStringList.Create;
  DirectoryList.Add('MapQuest_def');
  DirectoryList.Add('Market_def');
  DirectoryList.Add('Npc_def');
  DirectoryList.Add('QuestDiary');
  DirectoryList.Add('Robot_def');
{$IF USERMODE = SUPERVERSION}
  ButtonScriptPlug := TButton.Create(Owner);
  ButtonScriptPlug.Parent := TabSheet1;
  ButtonScriptPlug.Left := 319;
  ButtonScriptPlug.Top := 212;
  ButtonScriptPlug.Width := 100;
  ButtonScriptPlug.Caption := '打开加脚本插件';
  ButtonScriptPlug.OnClick := ButtonScriptPlugClick;
{$IFEND}
end;

procedure TFrmMain.ListBoxEncodeListDblClick(Sender: TObject);
begin
  WinExec(PChar('Notepad.exe ' + sMirServer + ListBoxEncodeList.Items.Strings[ListBoxEncodeList.ItemIndex]), SW_SHOW);
end;

procedure TFrmMain.ListBoxFileDblClick(Sender: TObject);
begin
  WinExec(PChar('Notepad.exe ' + sMirServer + ListBoxFile.Items.Strings[ListBoxFile.ItemIndex]), SW_SHOW);
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  QuitFlag := True;
  UnSearchFileList();
  DirectoryList.Free;
  SearchFileList.Free; 
end;

procedure TFrmMain.EditMirserverButtonClick(Sender: TObject);
var
  sNewDir: string;
begin
  sNewDir := EditMirserver.Text;
  if SelectDirectory('浏览文件夹', '', sNewDir, Handle) then begin
    //if sNewDir[Length(sNewDir)] <> '\' then sNewDir := sNewDir + '\';
    EditMirserver.Text := sNewDir;
  end;
end;

procedure TFrmMain.ButtonSearchClick(Sender: TObject);
var
  sNewDir: string;
  List: TStringList;
  I, II: Integer;
begin
  if boWork then Exit;
  boWork := True;
  ButtonSearch.Enabled := False;
  ListBoxFile.Enabled := False;
  ButtonEncode1.Enabled := False;
  ListBoxEncodeList.Enabled := False;
  sNewDir := EditMirserver.Text;
  sMirServer := '';
  UnSearchFileList();
  if sNewDir[Length(sNewDir)] <> '\' then sNewDir := sNewDir + '\';
  DoSearchFile(sNewDir);
  ListBoxFile.Items.Clear;
  ListBoxEncodeList.Items.Clear;
  try
    for I := 0 to SearchFileList.Count - 1 do begin
      List := TStringList(SearchFileList.Objects[I]);
      for II := 0 to List.Count - 1 do begin
        ListBoxFile.Items.Add(List.Strings[II]);
      end;
    end;
  except
  end;
  ButtonSearch.Enabled := True;
  ListBoxFile.Enabled := True;
  ButtonEncode1.Enabled := True;
  ListBoxEncodeList.Enabled := True;
  boWork := False;
  //ShowMessage(sMirServer);
end;

procedure TFrmMain.MenuItem1Click(Sender: TObject);
var
  I: Integer;
begin
  for I := ListBoxFile.Items.Count - 1 downto 0 do begin
    if ListBoxFile.Selected[I] then begin
      ListBoxEncodeList.Items.Add(ListBoxFile.Items[I]);
      ListBoxFile.Items.Delete(I);
    end;
  end;
end;

procedure TFrmMain.MenuItem2Click(Sender: TObject);
var
  I: Integer;
begin
  for I := ListBoxEncodeList.Items.Count - 1 downto 0 do begin
    if ListBoxEncodeList.Selected[I] then begin
      ListBoxFile.Items.Add(ListBoxFile.Items[I]);
      ListBoxEncodeList.Items.Delete(I);
    end;
  end;
end;

procedure TFrmMain.MenuItem3Click(Sender: TObject);
begin
  Memo2.CutToClipboard;
end;

procedure TFrmMain.MenuItem4Click(Sender: TObject);
begin
  Memo2.CopyToClipboard;
end;

procedure TFrmMain.MenuItem5Click(Sender: TObject);
begin
  Memo2.PasteFromClipboard;
end;

procedure TFrmMain.MenuItem6Click(Sender: TObject);
begin
  Memo2.ClearSelection;
end;

procedure TFrmMain.MenuItem8Click(Sender: TObject);
begin
  Memo2.SelectAll;
end;

procedure TFrmMain.ButtonEncode1Click(Sender: TObject);
var
  sKey, sFileName: string;
  I, II: Integer;
  LoadList: TStringList;
  FileList: TStringList;
  sLineText: string;
  sFirstStr: string;
begin
  sFirstStr := ';+++++++----------------';
  sKey := EditPassWord1.Text;
  if sKey = '' then begin
    Application.MessageBox('请输入密码！！！', '提示信息', MB_ICONASTERISK);
    Exit;
  end;
  if ListBoxEncodeList.Items.Count <= 0 then begin
    Application.MessageBox('加密文件列表中没有需要加密的文件！！！', '提示信息', MB_ICONASTERISK);
    Exit;
  end;
  if boWork then Exit;
  boWork := True;
  ButtonSearch.Enabled := False;
  ListBoxFile.Enabled := False;
  ButtonEncode1.Enabled := False;
  ListBoxEncodeList.Enabled := False;
  FileList := TStringList.Create;
  for I := 0 to ListBoxEncodeList.Items.Count - 1 do begin
    if QuitFlag then Break;
    Application.ProcessMessages;
    sFileName := sMirServer + ListBoxEncodeList.Items.Strings[I];
    LabeMsg.Caption := '正在加载：' + sFileName;
    try
      LoadList := TStringList.Create;
      LoadList.LoadFromFile(sFileName);
      FileList.AddObject(sFileName, LoadList);
    except

    end;
  end;
  for I := 0 to FileList.Count - 1 do begin
    if QuitFlag then Break;
    Application.ProcessMessages;
    sFileName := FileList.Strings[I];
    LabeMsg.Caption := '正在加密：' + sFileName;
    LoadList := TStringList(FileList.Objects[I]);
    if not IsEnCodeStringList(LoadList) then begin
      for II := 0 to LoadList.Count - 1 do begin
        Application.ProcessMessages;
        sLineText := LoadList.Strings[II];
        if sLineText <> '' then begin
          try
            LoadList.Strings[II] := EncryStrHex3(sLineText, sKey);
          except
            LoadList.Strings[II] := sLineText;
          end;
        end;
      end;
      LoadList.Insert(0, sFirstStr);
      LabeMsg.Caption := '保存文件：' + sFileName;
      try
        LoadList.SaveToFile(sFileName);
        LoadList.Free;
      except
        LoadList.Free;
      end;
    end;
  end;
  FileList.Free;
  ButtonSearch.Enabled := True;
  ListBoxFile.Enabled := True;
  ButtonEncode1.Enabled := True;
  ListBoxEncodeList.Enabled := True;
  LabeMsg.Caption := '加密完成';
  boWork := False;
end;

procedure TFrmMain.ButtonSearchEncodeFileClick(Sender: TObject);
  function GetSaveDir(sFileName: string): string;
  var
    I: Integer;
    nIdx: Integer;
  begin
    Result := sFileName;
    nIdx := 0;
    if Length(sFileName) > 0 then begin
      for I := Length(sFileName) downto 1 do begin
        Inc(nIdx);
        if sFileName[I] = '\' then begin
          Break;
        end;
      end;
      Result := Copy(sFileName, 1, Length(sFileName) - nIdx);
    end;
  end;
var
  sNewDir, sLineText, sSaveDir: string;
  sKey, sFileName: string;
  List: TStringList;
  I, II: Integer;
  FileList, LoadList: TStringList;
  DeCodeScript: pTDeCodeScript;
begin
{$IF USERMODE = SHAREVERSION}
  Application.MessageBox('免费版没有解密功能！！！', '提示信息', MB_ICONASTERISK);
{$ELSE}
  sKey := EditPassWord1.Text;
  if sKey = '' then begin
    Application.MessageBox('请输入密码！！！', '提示信息', MB_ICONASTERISK);
    Exit;
  end;
  if boWork then Exit;
  boWork := True;
  ButtonSearchEncodeFile.Enabled := False;
  sNewDir := EditMirserver.Text;
  sMirServer := '';
  UnSearchFileList();
  if sNewDir[Length(sNewDir)] <> '\' then sNewDir := sNewDir + '\';
  sSaveDir := EditSave.Text;
  if sSaveDir[Length(sSaveDir)] <> '\' then sSaveDir := sSaveDir + '\';
  DoSearchFile(sNewDir);
  MemoLog.Lines.Clear;
  FileList := TStringList.Create;
  try
    for I := 0 to SearchFileList.Count - 1 do begin
      Application.ProcessMessages;
      List := TStringList(SearchFileList.Objects[I]);
      if QuitFlag then Break;
      for II := 0 to List.Count - 1 do begin
        if QuitFlag then Break;
        Application.ProcessMessages;
        sFileName := sMirServer + List.Strings[II];
        LabeMsg.Caption := '正在加载：' + sFileName;
        MemoLog.Lines.Add('正在加载：' + sFileName);

        New(DeCodeScript);
        DeCodeScript.sFileName := List.Strings[II];
        DeCodeScript.FileList := TStringList.Create;
        try
          DeCodeScript.FileList.LoadFromFile(sFileName);
        except
          DeCodeScript.FileList.Clear;
        end;
        if IsEnCodeStringList(DeCodeScript.FileList) then begin
          FileList.AddObject(sFileName, TObject(DeCodeScript));
        end else begin
          FreeAndNil(DeCodeScript.FileList);
          Dispose(DeCodeScript);
        end;
      end;
    end;
  except

  end;
  sMirServer := sSaveDir;
  for I := 0 to FileList.Count - 1 do begin
    if QuitFlag then Break;
    Application.ProcessMessages;
    sFileName := FileList.Strings[I];
    LabeMsg.Caption := '正在解密：' + sFileName;
    MemoLog.Lines.Add('正在解密：' + sFileName);
    DeCodeScript := pTDeCodeScript(FileList.Objects[I]);
    for II := 0 to DeCodeScript.FileList.Count - 1 do begin
      if QuitFlag then Break;
      Application.ProcessMessages;
      sLineText := DeCodeScript.FileList.Strings[II];
      if sLineText <> '' then begin
        try
          DeCodeScript.FileList.Strings[II] := DecryStrHex3(sLineText, sKey);
        except
          DeCodeScript.FileList.Strings[II] := sLineText;
        end;
      end;
    end;
    if DeCodeScript.FileList.Count > 0 then DeCodeScript.FileList.Delete(0);
    sFileName := sMirServer + DeCodeScript.sFileName;
    sSaveDir := GetSaveDir(sFileName);
    if not DirectoryExists(sSaveDir) then ForceDirectories(sSaveDir); //创建目录
    LabeMsg.Caption := '保存文件：' + sFileName;
    MemoLog.Lines.Add('保存文件：' + sFileName);
    try
      DeCodeScript.FileList.SaveToFile(sFileName);
    except
    end;
    DeCodeScript.FileList.Free;
    Dispose(DeCodeScript);
  end;
  FileList.Free;
  LabeMsg.Caption := '解密完成';
  ButtonSearchEncodeFile.Enabled := True;
  boWork := False;
{$IFEND}
end;

procedure TFrmMain.EditSaveButtonClick(Sender: TObject);
var
  sNewDir: string;
begin
  sNewDir := EditSave.Text;
  if SelectDirectory('浏览文件夹', '', sNewDir, Handle) then begin
    EditSave.Text := sNewDir;
  end;
end;

procedure TFrmMain.ButtonScriptPlugClick(Sender: TObject);
var
  OpenScriptPlug: TOpenDialog;
  OptionSize: PInteger;
  Count: PInteger;
  MemoryStream: TMemoryStream;
  ScriptConfig: TScriptConfig;
  Buffer: Pointer;
  sOption: string;
  nCRC: PInteger;
begin
  OpenScriptPlug := TOpenDialog.Create(Owner);
  OpenScriptPlug.Filter := '脚本插件|*.DLL';
  if OpenScriptPlug.Execute then begin
    New(OptionSize);
    New(Count);
    New(nCRC);
    MemoryStream := TMemoryStream.Create;
    try
      OptionSize^ := Length(EncryptBuffer(@ScriptConfig, SizeOf(TScriptConfig)));
      MemoryStream.LoadFromFile(OpenScriptPlug.FileName);

      MemoryStream.Seek(-(SizeOf(Integer) + OptionSize^), soFromEnd);
      MemoryStream.Read(Count^, SizeOf(Integer));

      GetMem(Buffer, OptionSize^);
      try
        MemoryStream.Read(Buffer^, OptionSize^);
        SetLength(sOption, OptionSize^);
        Move(Buffer^, sOption[1], OptionSize^);
      finally
        FreeMem(Buffer);
      end;

      GetMem(Buffer, Count^);
      try
        MemoryStream.Seek(0, soFromBeginning);
        MemoryStream.Read(Buffer^, Count^);
        nCRC^ := CalcBufferCRC(Buffer, Count^);
      finally
        FreeMem(Buffer);
      end;

      DecryptBuffer(sOption, @ScriptConfig, SizeOf(TScriptConfig));
      if (Count^ = ScriptConfig.nSize) and (nCRC^ = ScriptConfig.nCrc) then begin
        EditPassWord.Text := DecryptString(ScriptConfig.sPassWord);
        EditPassWord1.Text := DecryptString(ScriptConfig.sPassWord);
        Application.MessageBox('密码获取成功！！！', '提示信息', MB_ICONASTERISK);
      end;
    except
      Application.MessageBox('密码获取失败！！！', '提示信息', MB_ICONASTERISK);
    end;
    Dispose(OptionSize);
    Dispose(Count);
    Dispose(nCRC);
    MemoryStream.Free;
  end;
  OpenScriptPlug.Free;
end;

end.

