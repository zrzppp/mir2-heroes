unit SelectPaths;

interface

uses Windows, Messages, SysUtils, Classes, Controls, Graphics, Forms,
  Menus, StdCtrls, Buttons, FileCtrl;

function SelectPath(var Directory: string;
  Options: TSelectDirOpts; HelpCtx: Longint): Boolean;

implementation

type
  TPathLabel = class(TCustomLabel)
  protected
    procedure Paint; override;
  public
    constructor Create(AnOwner: TComponent); override;
  published
    property Alignment;
    property Transparent;
  end;

{ TSelectDirDlg }
  TSelectDirDlg = class(TForm)
    DirList: TDirectoryListBox;
    DirEdit: TEdit;
    DriveList: TDriveComboBox;
    DirLabel: TPathLabel;
    OKButton: TButton;
    CancelButton: TButton;
    HelpButton: TButton;
    NetButton: TButton;
    FileList: TFileListBox;
    procedure DirListChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DriveListChange(Sender: TObject);
    procedure NetClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
  private
   { Private declarations }
    FAllowCreate: Boolean;
    FPrompt: Boolean;
    WNetConnectDialog: function(WndParent: HWND; IType: Longint): Longint;
    procedure SetAllowCreate(Value: Boolean);
    procedure SetDirectory(const Value: string);
    function GetDirectory: string;
  public
   { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property Directory: string read GetDirectory write SetDirectory;
    property AllowCreate: Boolean read FAllowCreate write SetAllowCreate default False;
    property Prompt: Boolean read FPrompt write FPrompt default False;
  end;

function SlashSep(const Path, S: string): string;
begin
  if AnsiLastChar(Path)^ <> '\' then
    Result := Path + '\' + S
  else
    Result := Path + S;
end;

function ShowYesNo(const Msg: string): Boolean;
begin
  Result := False;
  if Application.MessageBox(PChar(Msg), PChar(Application.Title),
    MB_YESNO + MB_ICONQUESTION) = IDYES then
    Result := True;
end;

procedure ShowWarning(const Msg: string);
begin
  Application.MessageBox(PChar(Msg), PChar(Application.Title),
    MB_OK + MB_ICONWARNING);
end;
{ TPathLabel }

constructor TPathLabel.Create(AnOwner: TComponent);
begin
  inherited Create(AnOwner);
  WordWrap := False;
  AutoSize := False;
  ShowAccelChar := False;
end;

procedure TPathLabel.Paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  Rect: TRect;
  Temp: string;
begin
  with Canvas do
  begin
    Rect := ClientRect;
    if not Transparent then
    begin
      Brush.Color := Self.Color;
      Brush.Style := bsSolid;
      FillRect(Rect);
    end;
    Brush.Style := bsClear;
    Temp := MinimizeName(Caption, Canvas, Rect.Right - Rect.Left);
    DrawText(Canvas.Handle, PChar(Temp), Length(Temp), Rect,
      DT_NOPREFIX or Alignments[Alignment]);
  end;
end;

{ TSelectDirDlg }
constructor TSelectDirDlg.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  Caption := '选择目录';
  BorderStyle := bsDialog;
  ClientWidth := 424;
  ClientHeight := 255;
  Font.Name := '宋体';
  Font.Size := 9;
  Position := poScreenCenter;

  DirEdit := TEdit.Create(Self);
  with DirEdit do
  begin
    Parent := Self;
    SetBounds(8, 24, 313, 20);
    Visible := False;
    TabOrder := 0;
  end;

  with TLabel.Create(Self) do
  begin
    Parent := Self;
    SetBounds(8, 8, 92, 13);
    FocusControl := DirEdit;
    Caption := '目录名称(&N)';
  end;

  DriveList := TDriveComboBox.Create(Self);
  with DriveList do
  begin
    Parent := Self;
    SetBounds(232, 192, 185, 19);
    TabOrder := 4;
    OnChange := DriveListChange;
  end;

  with TLabel.Create(Self) do
  begin
    Parent := Self;
    SetBounds(232, 176, 41, 13);
    Caption := '驱动器(&R)';
    FocusControl := DriveList;
  end;

  DirLabel := TPathLabel.Create(Self);
  with DirLabel do
  begin
    Parent := Self;
    SetBounds(120, 8, 213, 13);
  end;

  DirList := TDirectoryListBox.Create(Self);
  with DirList do
  begin
    Parent := Self;
    SetBounds(8, 72, 213, 138);
    TabOrder := 1;
    TabStop := True;
    ItemHeight := 17;
    IntegralHeight := True;
    OnChange := DirListChange;
  end;

  with TLabel.Create(Self) do
  begin
    Parent := Self;
    SetBounds(8, 56, 66, 13);
    Caption := '目录(&D)';
    FocusControl := DirList;
  end;

  FileList := TFileListBox.Create(Self);
  with FileList do
  begin
    Parent := Self;
    SetBounds(232, 72, 185, 93);
    TabOrder := 2;
    TabStop := True;
    FileType := [ftNormal];
    Mask := '*.*';
    Font.Color := clGrayText;
    ItemHeight := 13;
  end;

  with TLabel.Create(Self) do
  begin
    Parent := Self;
    SetBounds(232, 56, 57, 13);
    Caption := '文件(&F)';
    FocusControl := FileList;
  end;

  NetButton := TButton.Create(Self);
  with NetButton do
  begin
    Parent := Self;
    SetBounds(8, 224, 77, 27);
    Visible := False;
    TabOrder := 6;
    Caption := '网络(&E)';
    OnClick := NetClick;
  end;

  OKButton := TButton.Create(Self);
  with OKButton do
  begin
    Parent := Self;
    SetBounds(172, 224, 77, 27);
    TabOrder := 4;
    OnClick := OKClick;
    Caption := '确认(&O)';
    ModalResult := 1;
    Default := True;
  end;

  CancelButton := TButton.Create(Self);
  with CancelButton do
  begin
    Parent := Self;
    SetBounds(256, 224, 77, 27);
    TabOrder := 5;
    Cancel := True;
    Caption := '取消(&C)';
    ModalResult := 2;
  end;

  HelpButton := TButton.Create(Self);
  with HelpButton do
  begin
    Parent := Self;
    SetBounds(340, 224, 77, 27);
    TabOrder := 7;
    Caption := '帮助(&H)';
    OnClick := HelpButtonClick;
  end;

  FormCreate(Self);
end;

procedure TSelectDirDlg.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TSelectDirDlg.DirListChange(Sender: TObject);
begin
  DirLabel.Caption := DirList.Directory;
  FileList.Directory := DirList.Directory;
  DirEdit.Text := DirLabel.Caption;
  DirEdit.SelectAll;
end;

procedure TSelectDirDlg.FormCreate(Sender: TObject);
var
  UserHandle: THandle;
  NetDriver: THandle;
  WNetGetCaps: function(Flags: Word): Word;
begin
 { is network access enabled? }
  UserHandle := GetModuleHandle(User32);
  @WNetGetCaps := GetProcAddress(UserHandle, 'WNETGETCAPS');
  if @WNetGetCaps <> nil then
  begin
    NetDriver := WNetGetCaps(Word(-1));
    if NetDriver <> 0 then
    begin
      @WNetConnectDialog := GetProcAddress(NetDriver, 'WNETCONNECTDIALOG');
      NetButton.Visible := @WNetConnectDialog <> nil;
    end;
  end;

  FAllowCreate := False;
  DirLabel.BoundsRect := DirEdit.BoundsRect;
  DirListChange(Self);
end;

procedure TSelectDirDlg.DriveListChange(Sender: TObject);
begin
  try
    DirList.Drive := DriveList.Drive;
  except
    ShowWarning('请检查驱动器是否有盘!');
  end;
end;

procedure TSelectDirDlg.SetAllowCreate(Value: Boolean);
begin
  if Value <> FAllowCreate then
  begin
    FAllowCreate := Value;
    DirLabel.Visible := not FAllowCreate;
    DirEdit.Visible := FAllowCreate;
  end;
end;

procedure TSelectDirDlg.SetDirectory(const Value: string);
var
  Temp: string;
begin
  if Value <> '' then
  begin
    Temp := ExpandFileName(SlashSep(Value, '*.*'));
    if (Length(Temp) >= 3) and (Temp[2] = ':') then
    begin
      DriveList.Drive := Temp[1];
      Temp := ExtractFilePath(Temp);
      try
        DirList.Directory := Copy(Temp, 1, Length(Temp) - 1);
      except
        on EInOutError do
        begin
          GetDir(0, Temp);
          DriveList.Drive := Temp[1];
          DirList.Directory := Temp;
        end;
      end;
    end;
  end;
end;

function TSelectDirDlg.GetDirectory: string;
begin
  if FAllowCreate then
    Result := DirEdit.Text
  else
    Result := DirLabel.Caption;
end;

procedure TSelectDirDlg.NetClick(Sender: TObject);
begin
  if Assigned(WNetConnectDialog) then
    WNetConnectDialog(Handle, WNTYPE_DRIVE);
end;

procedure TSelectDirDlg.OKClick(Sender: TObject);
begin
  if AllowCreate and Prompt and (not DirectoryExists(Directory)) and
    not ShowYesNo('该目录不存在, 创建该目录吗?') then
    ModalResult := 0;
end;

function SelectPath(var Directory: string;
  Options: TSelectDirOpts; HelpCtx: Longint): Boolean;
var
  D: TSelectDirDlg;
begin
  D := TSelectDirDlg.Create(Application);
  try
    D.Directory := Directory;
    D.AllowCreate := sdAllowCreate in Options;
    D.Prompt := sdPrompt in Options;

   { scale to screen res }
    if Screen.PixelsPerInch <> 96 then
    begin
      D.ScaleBy(Screen.PixelsPerInch, 96);
      D.FileList.ParentFont := True;
      D.Left := (Screen.Width div 2) - (D.Width div 2);
      D.Top := (Screen.Height div 2) - (D.Height div 2);
      D.FileList.Font.Color := clGrayText;
    end;

    if HelpCtx = 0 then
    begin
      D.HelpButton.Visible := False;
      D.OKButton.Left := D.CancelButton.Left;
      D.CancelButton.Left := D.HelpButton.Left;
    end
    else D.HelpContext := HelpCtx;

    Result := D.ShowModal = mrOK;
    if Result then
    begin
      Directory := D.Directory;
      if sdPerformCreate in Options then
        ForceDirectories(Directory);
    end;
  finally
    D.Free;
  end;
end;

end.

