unit LogManage;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, RzEdit, ExtCtrls, CheckLst, Menus, LDShare, Clipbrd;

type
  TLogDataManage = class

  private
    {procedure Initialize();
    procedure Finalize();}
  public

  end;

  TFrmLogManage = class(TForm)
    Panel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    DateTimeEditBegin: TRzDateTimeEdit;
    DateTimeEditEnd: TRzDateTimeEdit;
    Label3: TLabel;
    ComboBoxCondition: TComboBox;
    EditSearch: TEdit;
    ButtonStart: TButton;
    Panel1: TPanel;
    ListView: TListView;
    CheckListBox: TCheckListBox;
    PopupMenu: TPopupMenu;
    PopupMenu_COPY: TMenuItem;
    PopupMenu_SELECTALL: TMenuItem;
    StatusBar: TStatusBar;
    Timer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure CheckListBoxClickCheck(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DateTimeEditBeginDateTimeChange(Sender: TObject;
      DateTime: TDateTime);
    procedure DateTimeEditEndDateTimeChange(Sender: TObject;
      DateTime: TDateTime);
    procedure TimerTimer(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure PopupMenu_COPYClick(Sender: TObject);
    procedure PopupMenu_SELECTALLClick(Sender: TObject);
  private
    { Private declarations }
    procedure AddSearchFile(FileDir, FileName: string);
    procedure DoSearchFile(Path: string);
    procedure UnLoadLogDataList;
    procedure UnLoadLogFileList;
  public
    { Public declarations }
  end;

var
  FrmLogManage: TFrmLogManage;
  LogDataList: TStringList;
  LogFileList: TStringList;
  QuitFlag: Boolean = False;
  SearchStatus: Boolean = False;
  CmdArray: array[0..35 - 1] of TCmd = (
    (Cmd: - 1; Check: True; Text: '全部动作'),
    (Cmd: 0; Check: True; Text: '取回物品'),
    (Cmd: 1; Check: True; Text: '存放物品'),
    (Cmd: 2; Check: True; Text: '炼制物品'),
    (Cmd: 3; Check: True; Text: '持久消失'),
    (Cmd: 4; Check: True; Text: '捡取物品'),
    (Cmd: 5; Check: True; Text: '制造物品'),
    (Cmd: 6; Check: True; Text: '销毁物品'),
    (Cmd: 7; Check: True; Text: '扔掉物品'),
    (Cmd: 8; Check: True; Text: '交易物品'),
    (Cmd: 9; Check: True; Text: '购买物品'),
    (Cmd: 10; Check: True; Text: '出售物品'),
    (Cmd: 11; Check: True; Text: '使用物品'),
    (Cmd: 12; Check: True; Text: '人物升级'),
    (Cmd: 13; Check: True; Text: '减少金币'),
    (Cmd: 14; Check: True; Text: '增加金币'),
    (Cmd: 15; Check: True; Text: '死亡掉落'),
    (Cmd: 16; Check: True; Text: '掉落物品'),
    (Cmd: 19; Check: True; Text: '人物死亡'),
    (Cmd: 20; Check: True; Text: '升级成功'),
    (Cmd: 21; Check: True; Text: '升级失败'),
    (Cmd: 22; Check: True; Text: '城堡取钱'),
    (Cmd: 23; Check: True; Text: '城堡存钱'),
    (Cmd: 24; Check: True; Text: '升级取回'),
    (Cmd: 25; Check: True; Text: '武器升级'),
    (Cmd: 26; Check: True; Text: '背包减少'),
    (Cmd: 27; Check: True; Text: '改变城主'),
    (Cmd: 111; Check: True; Text: '元宝改变'),
    (Cmd: 112; Check: True; Text: '能量改变'),
    (Cmd: 30; Check: True; Text: '商铺购买'),
    (Cmd: 31; Check: True; Text: '装备升级'),
    (Cmd: 32; Check: True; Text: '寄售物品'),
    (Cmd: 33; Check: True; Text: '寄售购买'),
    (Cmd: 34; Check: True; Text: '挑战物品'),
    (Cmd: 35; Check: True; Text: '摆摊物品')
    ); //26 测试武器升级

implementation
uses HUtil32;
{$R *.dfm}

function GetActString(nAct: Integer): string;
var
  I: Integer;
begin
  Result := '无法分析';
  if nAct >= 0 then begin
    for I := 0 to Length(CmdArray) - 1 do
      if CmdArray[I].Cmd = nAct then begin
        Result := CmdArray[I].Text;
        Exit;
      end;
  end;
end;

function GetActChecked(nAct: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if nAct >= 0 then begin
    for I := 0 to Length(CmdArray) - 1 do
      if (CmdArray[I].Cmd = nAct) and CmdArray[I].Check then begin
        Result := True;
        Exit;
      end;
  end;
end;

function GetSearch(ItemIndex: Integer; sSearch: string; LogData: pTLogData): Boolean;
var
  I: Integer;
begin
  Result := True;
  if ItemIndex <= 0 then Exit;
  case ItemIndex of
    1: Result := AnsiContainsText(LogData.sObjectName, sSearch);
    2: Result := AnsiContainsText(LogData.sItemName, sSearch);
    3: Result := LogData.nCount = Str_ToInt(sSearch, -1);
    4: Result := AnsiContainsText(LogData.sActObjectName, sSearch);
  end;
end;

function LastDirectoryName(Directory: string): string;
var
  I: Integer;
begin
  Result := '';
  if Directory[Length(Directory)] = '\' then
    Directory := Copy(Directory, 1, Length(Directory) - 1);
  for I := Length(Directory) downto 1 do
    if Directory[I] = '\' then begin
      Result := Copy(Directory, I + 1, Length(Directory) - I + 1);
      break;
    end;
end;

procedure TFrmLogManage.UnLoadLogFileList;
var
  I: Integer;
begin
  for I := 0 to LogFileList.Count - 1 do begin
    TStringList(LogFileList.Objects[I]).Free;
  end;
  LogFileList.Clear;
end;

procedure TFrmLogManage.UnLoadLogDataList;
var
  I, II: Integer;
  List: TList;
begin
  for I := 0 to LogDataList.Count - 1 do begin
    List := TList(LogDataList.Objects[I]);
    for II := 0 to List.Count - 1 do begin
      Dispose(pTLogData(List.Items[II]));
    end;
    List.Free;
  end;
  LogDataList.Clear;
end;

procedure TFrmLogManage.AddSearchFile(FileDir, FileName: string);
var
  sFileDir: string;
  List: TStringList;
  I: Integer;
  boFound: Boolean;
begin
  sFileDir := LastDirectoryName(FileDir);
  if sFileDir <> '' then begin
    boFound := False;
    List := nil;
    for I := 0 to LogFileList.Count - 1 do begin
      if CompareText(LogFileList.Strings[I], sFileDir) = 0 then begin
        List := TStringList(LogFileList.Objects[I]);
        boFound := True;
        Break;
      end;
    end;
    if not boFound then begin
      List := TStringList.Create;
      LogFileList.AddObject(sFileDir, List);
    end;
    if List <> nil then begin
      List.Add(FileDir + FileName);
    end;
  end;
end;

procedure TFrmLogManage.DateTimeEditBeginDateTimeChange(Sender: TObject;
  DateTime: TDateTime);
begin
  if DateTime > DateTimeEditEnd.Date then DateTimeEditEnd.Date := DateTime;
end;

procedure TFrmLogManage.DateTimeEditEndDateTimeChange(Sender: TObject;
  DateTime: TDateTime);
begin
  if DateTime < DateTimeEditBegin.Date then DateTimeEditEnd.Date := DateTimeEditBegin.Date;
end;

procedure TFrmLogManage.DoSearchFile(Path: string);
var
  Info: TSearchRec;
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
      StatusBar.Panels[2].Text := '正在搜索：' + S;
      AddSearchFile(FileDir, FileName);
    end;
  end;

  function IsDir: Boolean;
  begin
    with Info do
      Result := (Name <> '.') and (Name <> '..') and ((Attr and faDirectory) = faDirectory);
  end;

  function IsFile: Boolean;
  begin
    Result := (not ((Info.Attr and faDirectory) = faDirectory));
  end;

  function IsLogFile: Boolean;
  begin
    Result := Pos('Log-', Info.Name) > 0;
  end;

begin
  Path := IncludeTrailingBackslash(Path);
  try
    if FindFirst(Path + '*.*', faAnyFile, Info) = 0 then
      if IsFile and IsLogFile then
        ProcessAFile(Path, Info.Name);
      //else if IsDir then DoSearchFile(Path + Info.Name);
    while FindNext(Info) = 0 do begin
      if IsFile and IsLogFile then
        ProcessAFile(Path, Info.Name);
      Application.ProcessMessages;
      if QuitFlag then Break;
    end;
  finally
    FindClose(Info);
  end;
end;

procedure TFrmLogManage.ButtonStartClick(Sender: TObject);
var
  I, II, III, IIII, nDay, nIdx: Integer;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  SearchDay: TDate;
  sLogDir, sLogFile: string;
  FileList: TStringList;
  LoadList: TStringList;
  DataList: TList;
  sText, s01, s02, s03, s04, s05, s06, s07, s08, s09, s10, s11, s12, s13: string;
  LogData: pTLogData;
  ListItem: TListItem;
  ItemIndex: Integer;
  sSearch: string;
  boCheck: Boolean;
begin
  if not SearchStatus then begin
    sSearch := Trim(EditSearch.Text);
    ItemIndex := ComboBoxCondition.ItemIndex;
    if (ItemIndex > 0) and (sSearch = '') then begin
      case ItemIndex of
        1: Application.MessageBox('请输入查询的人物名称 ！！！', '提示信息', MB_ICONQUESTION);
        2: Application.MessageBox('请输入查询的物品名称 ！！！', '提示信息', MB_ICONQUESTION);
        3: Application.MessageBox('请输入查询的物品ID ！！！', '提示信息', MB_ICONQUESTION);
        4: Application.MessageBox('请输入查询的交易对象 ！！！', '提示信息', MB_ICONQUESTION);
      else Application.MessageBox('请输入查询条件 ！！！', '提示信息', MB_ICONQUESTION);
      end;
      EditSearch.SetFocus;
      Exit;
    end;

    for I := 0 to Length(CmdArray) - 1 do begin
      CmdArray[I].Check := CheckListBox.Checked[I];
    end;

    if not CmdArray[0].Check then begin
      boCheck := False;
      for I := 1 to Length(CmdArray) - 1 do begin
        if CmdArray[I].Check then begin
          boCheck := True;
          break;
        end;
      end;

      if not boCheck then begin
        Application.MessageBox('请选择查询动作 ！！！', '提示信息', MB_ICONQUESTION);
        CheckListBox.SetFocus;
        Exit;
      end;
    end;
    QuitFlag := False;
    SearchStatus := True;

    ButtonStart.Caption := '停止查询';
    StatusBar.Panels[3].Text := '';
    //ButtonStart.Enabled := False;
    ListView.Clear;
    UnLoadLogDataList;
    LoadList := TStringList.Create;
    nDay := GetDayCount(DateTimeEditEnd.Date, DateTimeEditBegin.Date);
    for I := 0 to nDay do begin
      if QuitFlag then Break;
      Application.ProcessMessages;
      SearchDay := DateTimeEditBegin.Date + I;
      DecodeDate(SearchDay, Year, Month, Day);
      sLogDir := {ExtractFilePath(ParamStr(0)) + } IncludeTrailingBackslash(sBaseDir) + IntToStr(Year) + '-' + IntToString(Month) + '-' + IntToString(Day);
      if DirectoryExists(sLogDir) then begin
        UnLoadLogFileList;
        DoSearchFile(sLogDir);
        StatusBar.Panels[2].Text := '搜索完成';
        for II := 0 to LogFileList.Count - 1 do begin
          Application.ProcessMessages;
          if QuitFlag then Break;
          sLogDir := LogFileList.Strings[II];
          FileList := TStringList(LogFileList.Objects[II]);

          for III := 0 to FileList.Count - 1 do begin
            if QuitFlag then Break;
            Application.ProcessMessages;
            sLogFile := FileList.Strings[III];
            if FileExists(sLogFile) then begin
              LoadList.Clear;
              DataList := TList.Create;
              LogDataList.AddObject(sLogDir, DataList);
              StatusBar.Panels[2].Text := '正在查询:' + sLogFile;
              LoadList.LoadFromFile(sLogFile);
              for IIII := 0 to LoadList.Count - 1 do begin
                if QuitFlag then Break;
                Application.ProcessMessages;
                sText := Trim(LoadList.Strings[IIII]);
                sText := GetValidStr3(sText, s01, [#9]);
                sText := GetValidStr3(sText, s02, [#9]);
                sText := GetValidStr3(sText, s03, [#9]);
                sText := GetValidStr3(sText, s04, [#9]);
                sText := GetValidStr3(sText, s05, [#9]);
                sText := GetValidStr3(sText, s06, [#9]);
                sText := GetValidStr3(sText, s07, [#9]);
                sText := GetValidStr3(sText, s08, [#9]);
                sText := GetValidStr3(sText, s09, [#9]);
                sText := GetValidStr3(sText, s10, [#9]);
                sText := GetValidStr3(sText, s11, [#9]);
                sText := GetValidStr3(sText, s12, [#9]);
                sText := GetValidStr3(sText, s13, [#9]);
                if IsStringNumber(s04) then begin
                  New(LogData);
                  DataList.Add(LogData);
                  LogData.nAct := Str_ToInt(s04, 0);
                  LogData.sMapName := s05;
                  LogData.nX := Str_ToInt(s06, -1);
                  LogData.nY := Str_ToInt(s07, -1);
                  LogData.sObjectName := s08;
                  LogData.sItemName := s09;
                  LogData.nCount := Str_ToInt(s10, 0);
                  LogData.boPalyObject := s11 = '1';
                  LogData.sActObjectName := s12;
                  LogData.sDate := s13;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
    LoadList.Free;
    nIdx := 0;
    for I := 0 to LogDataList.Count - 1 do begin
      if QuitFlag then Break;
      Application.ProcessMessages;
      DataList := TList(LogDataList.Objects[I]);
      //StatusBar.Panels[2].Text := '正在增加:' + LogDataList.Strings[I];
      for II := 0 to DataList.Count - 1 do begin
        if QuitFlag then Break;
        Application.ProcessMessages;
        LogData := DataList.Items[II];
        if CmdArray[0].Check or GetActChecked(LogData.nAct) then begin
          if GetSearch(ItemIndex, sSearch, LogData) then begin

            Inc(nIdx);
            ListItem := ListView.Items.Add;
            ListItem.Caption := IntToStr(nIdx);
            ListItem.SubItems.AddObject(GetActString(LogData.nAct), TObject(LogData));
            ListItem.SubItems.Add(LogData.sMapName);
            ListItem.SubItems.Add(IntToStr(LogData.nX));
            ListItem.SubItems.Add(IntToStr(LogData.nY));
            ListItem.SubItems.Add(LogData.sObjectName);
            ListItem.SubItems.Add(LogData.sItemName);
            ListItem.SubItems.Add(IntToStr(LogData.nCount));
            ListItem.SubItems.Add(LogData.sActObjectName);
            ListItem.SubItems.Add(LogData.sDate);
            StatusBar.Panels[2].Text := '正在增加:' + LogDataList.Strings[I] + ' ' + LogData.sObjectName + ' ' + LogData.sItemName;
          end;
        end;
      end;
    end;
    StatusBar.Panels[3].Text := '';
    StatusBar.Panels[2].Text := '查询已完成';
    //ButtonStart.Enabled := True;
    SearchStatus := False;
    ButtonStart.Caption := '开始查询';
  end else begin
    QuitFlag := True;
    SearchStatus := False;
    //ButtonStart.Caption:='停止查询';
  end;
end;

procedure TFrmLogManage.CheckListBoxClickCheck(Sender: TObject);
var
  I: Integer;
begin
  if CheckListBox.Selected[0] { and CheckListBox.Checked[0] } then begin
    for I := 1 to CheckListBox.Count - 1 do
      CheckListBox.Checked[I] := CheckListBox.Checked[0];
  end;
end;

procedure TFrmLogManage.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  LogDataList := TStringList.Create;
  LogFileList := TStringList.Create;
  DateTimeEditBegin.Date := Date;
  DateTimeEditEnd.Date := Date;
  ComboBoxCondition.ItemIndex := 0;
  CheckListBox.Clear;
  for I := 0 to Length(CmdArray) - 1 do
    CheckListBox.Items.Add(CmdArray[I].Text);

  CheckListBox.Selected[0] := True;
  CheckListBox.Checked[0] := True;
  CheckListBoxClickCheck(CheckListBox);
  Timer.Enabled := True;
end;

procedure TFrmLogManage.FormDestroy(Sender: TObject);
begin
  UnLoadLogFileList;
  UnLoadLogDataList;
  LogFileList.Free;
  LogDataList.Free;
end;

procedure TFrmLogManage.PopupMenu_COPYClick(Sender: TObject);
var
  I, II: Integer;
  ListItem: TListItem;
  Clipboard: TClipboard;
  sText: string;
begin
  sText := '';
  for I := 0 to ListView.Items.Count - 1 do begin
    ListItem := ListView.Items.Item[I];
    if ListItem.Selected then begin
      for II := 0 to ListItem.SubItems.Count - 1 do begin
        sText := sText + ListItem.SubItems.Strings[II] + #9;
      end;
      sText := Trim(sText) + #13#10;
    end;
  end;
  Clipboard := TClipboard.Create();
  Clipboard.AsText := sText;
  Clipboard.Free();
end;

procedure TFrmLogManage.PopupMenu_SELECTALLClick(Sender: TObject);
begin
  ListView.SelectAll;
end;

procedure TFrmLogManage.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;

end;

end.

