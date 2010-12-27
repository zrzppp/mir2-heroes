unit Option;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Main, Menus, JSocket, Spin, IniFiles, Mask, RzEdit,
  RzBtnEdt;

type
  TfrmOption = class(TForm)
    GroupBoxActive: TGroupBox;
    LabelActive: TLabel;
    ListBoxActiveList: TListBox;
    GroupBox1: TGroupBox;
    LabelBlock: TLabel;
    ListBoxBlockList: TListBox;
    ActiveListPopupMenu: TPopupMenu;
    APOPMENU_REFLIST: TMenuItem;
    APOPMENU_BLOCKLIST: TMenuItem;
    APOPMENU_KICK: TMenuItem;
    BlockListPopupMenu: TPopupMenu;
    BPOPMENU_REFLIST: TMenuItem;
    BPOPMENU_ADD: TMenuItem;
    BPOPMENU_DELETE: TMenuItem;
    APOPMENU_ALLADDLIST: TMenuItem;
    BPOPMENU_CLEAR: TMenuItem;
    Label2: TLabel;
    EditMaxConnect: TSpinEdit;
    Label3: TLabel;
    ButtonOK: TButton;
    Label5: TLabel;
    EditKeepConnectTimeOut: TSpinEdit;
    Label11: TLabel;
    EditConnctCheckTime: TSpinEdit;
    GroupBox2: TGroupBox;
    LabelIPArray: TLabel;
    ListBoxIPArrayList: TListBox;
    ArrayPopupMenu: TPopupMenu;
    AYPOPMENU_REFLIST: TMenuItem;
    AYPOPMENU_ADD: TMenuItem;
    AYPOPMENU_CLEAR: TMenuItem;
    AYPOPMENU_DELETE: TMenuItem;
    Label1: TLabel;
    EditMaxOnlineCount: TSpinEdit;
    Label4: TLabel;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    ButtonLoadIpList: TButton;
    OpenDialog: TOpenDialog;
    Label7: TLabel;
    EditRefLoadIpListTime: TSpinEdit;
    Label8: TLabel;
    EditIpList: TEdit;
    procedure APOPMENU_KICKClick(Sender: TObject);
    procedure APOPMENU_BLOCKLISTClick(Sender: TObject);
    procedure APOPMENU_REFLISTClick(Sender: TObject);
    procedure BPOPMENU_REFLISTClick(Sender: TObject);
    procedure BPOPMENU_ADDClick(Sender: TObject);
    procedure BPOPMENU_DELETEClick(Sender: TObject);
    procedure BPOPMENU_CLEARClick(Sender: TObject);
    procedure APOPMENU_ALLADDLISTClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure EditMaxConnectChange(Sender: TObject);
    procedure EditKeepConnectTimeOutChange(Sender: TObject);
    procedure EditConnctCheckTimeChange(Sender: TObject);
    procedure AYPOPMENU_ADDClick(Sender: TObject);
    procedure AYPOPMENU_REFLISTClick(Sender: TObject);
    procedure AYPOPMENU_CLEARClick(Sender: TObject);
    procedure AYPOPMENU_DELETEClick(Sender: TObject);
    procedure EditMaxOnlineCountChange(Sender: TObject);
    procedure ListBoxActiveListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBoxBlockListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonLoadIpListClick(Sender: TObject);
    procedure EditRefLoadIpListTimeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open();
  end;

var
  frmOption: TfrmOption;

implementation
uses GateShare, HUtil32, Share;
{$R *.dfm}

procedure TfrmOption.APOPMENU_BLOCKLISTClick(Sender: TObject);
var
  sIPaddr: string;
  I: Integer;
begin
  if Application.MessageBox(PChar('是否确认将此IP加入永久过滤列表中？加入过滤列表后，此IP建立的所有连接将被强行中断。'),
    PChar('确认信息'),
    MB_OKCANCEL + MB_ICONQUESTION) <> IDOK then Exit;
  for I := 0 to ListBoxActiveList.Items.Count - 1 do begin
    if ListBoxActiveList.Selected[I] then begin
      sIPaddr := ListBoxActiveList.Items.Strings[I];
      AddBlockIP(sIPaddr);
      frmMain.CloseConnect(sIPaddr);
    end;
  end;
  BPOPMENU_REFLISTClick(Self);
  APOPMENU_REFLISTClick(Self);
end;

procedure TfrmOption.APOPMENU_KICKClick(Sender: TObject);
var
  I: Integer;
begin
  if Application.MessageBox(PChar('是否确认将此连接断开？'),
    PChar('确认信息'), MB_OKCANCEL + MB_ICONQUESTION) <> IDOK then Exit;
  for I := 0 to ListBoxActiveList.Items.Count - 1 do begin
    if ListBoxActiveList.Selected[I] then begin
      TCustomWinSocket(ListBoxActiveList.Items.Objects[I]).Close;
    end;
  end;
  APOPMENU_REFLISTClick(Self);
end;

procedure TfrmOption.APOPMENU_REFLISTClick(Sender: TObject);
var
  I: Integer;
  sIPaddr: string;
begin
  ListBoxActiveList.Clear;
  if frmMain.ServerSocket.Active then
    for I := 0 to frmMain.ServerSocket.Socket.ActiveConnections - 1 do begin
      sIPaddr := frmMain.ServerSocket.Socket.Connections[I].RemoteAddress;
      if sIPaddr <> '' then
        ListBoxActiveList.Items.AddObject(sIPaddr, TObject(frmMain.ServerSocket.Socket.Connections[I]));
    end;
  LabelActive.Caption := '连接列表:' + IntToStr(ListBoxActiveList.Items.Count);
end;

procedure TfrmOption.Open();
var
  I: Integer;
  sIPaddr: string;
begin
  ListBoxActiveList.Clear;
  ListBoxBlockList.Clear;
  ListBoxIPArrayList.Clear;
  if frmMain.ServerSocket.Active then
    for I := 0 to frmMain.ServerSocket.Socket.ActiveConnections - 1 do begin
      sIPaddr := frmMain.ServerSocket.Socket.Connections[I].RemoteAddress;
      if sIPaddr <> '' then
        ListBoxActiveList.Items.AddObject(sIPaddr, TObject(frmMain.ServerSocket.Socket.Connections[I]));
    end;
  ListBoxBlockList.Items.AddStrings(g_BlockIPList);
  ListBoxIPArrayList.Items.AddStrings(g_BlockIPArray);
  EditMaxConnect.Value := g_Config.nMaxConnOfIPaddr;
  EditKeepConnectTimeOut.Value := g_Config.dwKeepConnectTimeOut;
  EditConnctCheckTime.Value := g_Config.nConnctCheckTime;
  EditMaxOnlineCount.Value := g_Config.nMaxOnlineCount;
  LabelActive.Caption := '连接列表:' + IntToStr(ListBoxActiveList.Items.Count);
  LabelBlock.Caption := '永久过滤:' + IntToStr(ListBoxBlockList.Items.Count);
  LabelIPArray.Caption := 'IP段过滤:' + IntToStr(ListBoxIPArrayList.Items.Count);
  EditRefLoadIpListTime.Value := g_Config.nRefLoadIpListTime;
  EditIpList.Text := g_sIpListUrl;
  ShowModal;
end;

procedure TfrmOption.BPOPMENU_REFLISTClick(Sender: TObject);
begin
  ListBoxBlockList.Clear;
  ListBoxBlockList.Items.AddStrings(g_BlockIPList);
  LabelBlock.Caption := '永久过滤:' + IntToStr(ListBoxBlockList.Items.Count);
end;

procedure TfrmOption.BPOPMENU_ADDClick(Sender: TObject);
var
  sIPaddress: string;
begin
  sIPaddress := '';
  if not InputQuery('永久IP过滤', '请输入一个新的IP地址: ', sIPaddress) then Exit;
  if not IsIPaddr(sIPaddress) then begin
    Application.MessageBox('输入的地址格式错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    Exit;
  end;
  AddBlockIP(sIPaddress);
  BPOPMENU_REFLISTClick(Self);
end;

procedure TfrmOption.BPOPMENU_DELETEClick(Sender: TObject);
var
  BlockIP: pTBlockIP;
  I, II: Integer;
begin
  for I := 0 to ListBoxBlockList.Items.Count - 1 do begin
    if ListBoxBlockList.Selected[I] then begin
      g_BlockIPList.Lock;
      try
        for II := g_BlockIPList.Count - 1 downto 0 do begin
          if g_BlockIPList.Strings[II] = ListBoxBlockList.Items.Strings[I] then begin
            BlockIP := pTBlockIP(g_BlockIPList.Objects[II]);
            Dispose(BlockIP);
            g_BlockIPList.Delete(II);
            Break;
          end;
        end;
      finally
        g_BlockIPList.UnLock;
      end;
    end;
  end;
  BPOPMENU_REFLISTClick(Self);
  SaveBlockIPFile;
end;

procedure TfrmOption.BPOPMENU_CLEARClick(Sender: TObject);
var
  BlockIP: pTBlockIP;
  I: Integer;
begin
  g_BlockIPList.Lock;
  try
    for I := 0 to g_BlockIPList.Count - 1 do begin
      BlockIP := pTBlockIP(g_BlockIPList.Objects[I]);
      Dispose(BlockIP);
    end;
    g_BlockIPList.Clear;
  finally
    g_BlockIPList.UnLock;
  end;
  ListBoxBlockList.Items.Clear;
  SaveBlockIPFile;
end;

procedure TfrmOption.APOPMENU_ALLADDLISTClick(Sender: TObject);
var
  sIPaddr: string;
  I: Integer;
begin
  if Application.MessageBox(PChar('是否确认将所有连接加入永久过滤列表中？加入过滤列表后，所有IP建立的连接将被强行中断。'),
    PChar('确认信息'),
    MB_OKCANCEL + MB_ICONQUESTION) <> IDOK then Exit;
  for I := 0 to ListBoxActiveList.Items.Count - 1 do begin
    sIPaddr := ListBoxActiveList.Items.Strings[I];
    AddBlockIP(sIPaddr);
    frmMain.CloseConnect(sIPaddr);
  end;
  BPOPMENU_REFLISTClick(Self);
  APOPMENU_REFLISTClick(Self);
end;

procedure TfrmOption.ButtonLoadIpListClick(Sender: TObject);
var
  Conf: TIniFile;
  sFileName: string;
begin
  sFileName := Trim(EditIpList.Text);
  g_sIpListUrl := sFileName;

  g_dwRefLoadIpListTime := GetTickCount;
  //LoadIPListFile();

  frmMain.HTTPGetIpList();

  sFileName := '.\Config.ini';
  Conf := TIniFile.Create(sFileName);
  Conf.WriteString(GateClass, 'IpListUrl', g_sIpListUrl);
  Conf.Free;
  {Application.MessageBox('绿色通道IP加载成功',
    '提示信息',
    MB_ICONQUESTION);}
end;

procedure TfrmOption.ButtonOKClick(Sender: TObject);
var
  Conf: TIniFile;
  sFileName: string;
begin
  sFileName := '.\Config.ini';
  Conf := TIniFile.Create(sFileName);
  Conf.WriteInteger(GateClass, 'KeepConnectTimeOut', g_Config.dwKeepConnectTimeOut);
  Conf.WriteInteger(GateClass, 'MaxConnOfIPaddr', g_Config.nMaxConnOfIPaddr);
  Conf.WriteInteger(GateClass, 'ConnctCheckTime', g_Config.nConnctCheckTime);
  Conf.WriteInteger(GateClass, 'MaxOnlineCount', g_Config.nMaxOnlineCount);
  Conf.WriteInteger(GateClass, 'RefLoadIpListTime', g_Config.nRefLoadIpListTime);
  Conf.WriteString(GateClass, 'IpListUrl', g_sIpListUrl);
  Conf.Free;
  Close;
end;

procedure TfrmOption.EditMaxConnectChange(Sender: TObject);
begin
  g_Config.nMaxConnOfIPaddr := EditMaxConnect.Value;
end;

procedure TfrmOption.EditKeepConnectTimeOutChange(Sender: TObject);
begin
  g_Config.dwKeepConnectTimeOut := EditKeepConnectTimeOut.Value;
end;

procedure TfrmOption.EditConnctCheckTimeChange(Sender: TObject);
begin
  g_Config.nConnctCheckTime := EditConnctCheckTime.Value;
end;

procedure TfrmOption.AYPOPMENU_REFLISTClick(Sender: TObject);
begin
  ListBoxIPArrayList.Clear;
  ListBoxIPArrayList.Items.AddStrings(g_BlockIPArray);
  LabelIPArray.Caption := 'IP段过滤:' + IntToStr(ListBoxIPArrayList.Items.Count);
end;

procedure TfrmOption.AYPOPMENU_ADDClick(Sender: TObject);
var
  sIPaddress: string;
begin
  sIPaddress := '';
  if not InputQuery('IP段过滤', '请输入一个新的IP地址: ', sIPaddress) then Exit;
  if not _IsIPaddr(sIPaddress) then begin
    Application.MessageBox('输入的地址格式错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    Exit;
  end;
  AddIPArray(sIPaddress);
  AYPOPMENU_REFLISTClick(Self);
end;

procedure TfrmOption.AYPOPMENU_CLEARClick(Sender: TObject);
begin
  g_BlockIPArray.Clear;
  AYPOPMENU_REFLISTClick(Self);
  SaveBlockIPArrayFile;
end;

procedure TfrmOption.AYPOPMENU_DELETEClick(Sender: TObject);
var
  I, II: Integer;
begin
  for I := 0 to ListBoxIPArrayList.Items.Count - 1 do begin
    if ListBoxIPArrayList.Selected[I] then begin
      for II := g_BlockIPArray.Count - 1 downto 0 do begin
        if g_BlockIPArray.Strings[II] = ListBoxIPArrayList.Items.Strings[I] then begin
          g_BlockIPArray.Delete(II);
          Break;
        end;
      end;
    end;
  end;
  AYPOPMENU_REFLISTClick(Self);
  SaveBlockIPArrayFile;
end;

procedure TfrmOption.EditMaxOnlineCountChange(Sender: TObject);
begin
  g_Config.nMaxOnlineCount := EditMaxOnlineCount.Value;
end;

procedure TfrmOption.EditRefLoadIpListTimeChange(Sender: TObject);
begin
  g_Config.nRefLoadIpListTime := EditRefLoadIpListTime.Value;
end;

procedure TfrmOption.ListBoxActiveListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  I: Integer;
  sIPaddr: string;
begin
  case Key of
    Word('F'): begin
        if ssCtrl in Shift then begin
          Key := 0;
          sIPaddr := '';
          if not InputQuery('IP查询', '输入IP地址:', sIPaddr) then Exit;
          if not IsIPaddr(sIPaddr) then begin
            Application.MessageBox('输入的IP地址格式不正确！！！', '错误信息', MB_OK + MB_ICONERROR);
            Exit;
          end;
          for I := 0 to ListBoxActiveList.Items.Count - 1 do begin
            if ListBoxActiveList.Items.Strings[I] = sIPaddr then begin
              ListBoxActiveList.ItemIndex := I;
              break;
            end;
          end;
        end;
      end;
  end;
end;

procedure TfrmOption.ListBoxBlockListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  I: Integer;
  sIPaddr: string;
begin
  case Key of
    Word('F'): begin
        if ssCtrl in Shift then begin
          Key := 0;
          sIPaddr := '';
          if not InputQuery('IP查询', '输入IP地址:', sIPaddr) then Exit;
          if not IsIPaddr(sIPaddr) then begin
            Application.MessageBox('输入的IP地址格式不正确！！！', '错误信息', MB_OK + MB_ICONERROR);
            Exit;
          end;
          for I := 0 to ListBoxBlockList.Items.Count - 1 do begin
            if ListBoxBlockList.Items.Strings[I] = sIPaddr then begin
              ListBoxBlockList.ItemIndex := I;
              break;
            end;
          end;
        end;
      end;
  end;
end;

end.

