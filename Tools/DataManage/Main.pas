unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Menus, ComCtrls, ExtCtrls, RzStatus, RzPanel, HUtil32, Grobal2,
  LocalDB, HumDB, IDDB, Share, ObjBase;

type
  TFrmMain = class(TForm)
    StatusBar: TRzStatusBar;
    StatusPane1: TRzStatusPane;
    StatusPane2: TRzStatusPane;
    ProgressBarSub: TProgressBar;
    PanelProgressStatus: TPanel;
    ProgressBar: TProgressBar;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    PopupMenu_Search_CharItem: TPopupMenu;
    Menu_Search_CharItem_ItemInfo: TMenuItem;
    Menu_Search_CharItem_CharInfo: TMenuItem;
    N3: TMenuItem;
    Menu_Search_CharItem_SelectAll: TMenuItem;
    Menu_Search_CharItem_NoSelectAll: TMenuItem;
    N6: TMenuItem;
    Menu_Search_CharItem_Del: TMenuItem;
    PopupMenu_Search_CopyItem: TPopupMenu;
    Menu_Search_CopyItem_ItemInfo: TMenuItem;
    Menu_Search_CopyItem_CharInfo: TMenuItem;
    MenuItem1: TMenuItem;
    Menu_Search_CopyItem_SelectAll: TMenuItem;
    Menu_Search_CopyItem_NoSelectAll: TMenuItem;
    MenuItem2: TMenuItem;
    Menu_Search_CopyItem_Del: TMenuItem;
    imlMain: TImageList;
    LargeImages: TImageList;
    SmallImages: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    procedure OnStart(Sender: TObject; const Number: Integer; const S:
      string);
    procedure OnStop(Sender: TObject; const Number: Integer; const S:
      string);
    procedure OnProgress(Sender: TObject; const Number: Integer; const
      S: string);

    procedure OnSubStart(Sender: TObject; const Number: Integer; const S:
      string);
    procedure OnSubStop(Sender: TObject; const Number: Integer; const S:
      string);
    procedure OnSubProgress(Sender: TObject; const Number: Integer; const
      S: string);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation
uses Login, Progress, DataClear, ItemManage, AccountManage, HumManage,
  Welcome, OtherOption;
{$R *.dfm}

procedure TFrmMain.OnStart(Sender: TObject; const Number: Integer; const S: string);
var
  sMsg: string;
begin
  sMsg := s;
  if sMsg <> '' then StatusPane1.Caption := sMsg;
  ProgressBar.Max := Number;
  ProgressBar.Position := 0;
  //ProgressBar.Visible := True;
  PanelProgressStatus.Visible := True;
end;

procedure TFrmMain.OnStop(Sender: TObject; const Number: Integer; const S: string);
var
  sMsg: string;
begin
  sMsg := s;
  if sMsg <> '' then StatusPane1.Caption := sMsg;
  {ProgressBar.Max:=Number;
  ProgressBar.Position:=0;}
  //ProgressBar.Visible := False;
  PanelProgressStatus.Visible := False;
end;

procedure TFrmMain.OnProgress(Sender: TObject; const Number: Integer; const S: string);
begin
  ProgressBar.Position := ProgressBar.Position + 1;
end;

procedure TFrmMain.OnSubStart(Sender: TObject; const Number: Integer; const S: string);
var
  sMsg: string;
begin
  sMsg := s;
  if sMsg <> '' then StatusPane2.Caption := sMsg;
  ProgressBarSub.Max := Number;
  ProgressBarSub.Position := 0;
end;

procedure TFrmMain.OnSubStop(Sender: TObject; const Number: Integer; const S: string);
var
  sMsg: string;
begin
  sMsg := s;
  if sMsg <> '' then StatusPane2.Caption := sMsg;
  {ProgressBar.Max:=Number;
  ProgressBar.Position:=0;}
end;

procedure TFrmMain.OnSubProgress(Sender: TObject; const Number: Integer; const S: string);
begin
  ProgressBarSub.Position := ProgressBarSub.Position + 1;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  I: INTEGER;
begin
  if g_boLoginOK and g_boLoadOK then begin
    if Application.MessageBox('是否要保存你修改的数据，如果放弃，所做的一切修改都无效 ？',
      '提示信息',
      MB_YESNO + MB_ICONQUESTION) = IDYES then begin
      g_boSoftClose:=True;
      Sleep(100);
      frmProgress := TfrmProgress.Create(Self);
      frmProgress.Open();
      frmProgress.Free;
    end else begin
      g_boSoftClose:=True;
      g_boLoadOK := False;
    end;

    if g_LocalDB <> nil then g_LocalDB.Free;
    for I := 0 to 5 do g_DataManage[I].Free;

    {if g_FileIDDB <> nil then g_FileIDDB.Free;
    if g_FileHumDB <> nil then g_FileHumDB.Free;
    if g_FileDB <> nil then g_FileDB.Free;
    if g_Storage <> nil then g_Storage.Free;
    if g_SellOff <> nil then g_SellOff.Free;
    if g_SellGold <> nil then g_SellGold.Free;}
    if g_SearchList <> nil then g_SearchList.Free;
    Close;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  I: INTEGER;
begin
  Application.ShowMainForm := False;

  g_boClose:=False;
  g_boSoftClose:=False;
  PanelProgressStatus.Visible := False;
  g_StatusPane1 := StatusPane1;
  g_StatusPane2 := StatusPane2;
  //g_StatusPane3 := StatusPane3;

  frmLogin := TfrmLogin.Create(Self);
  frmLogin.ShowModal;
  frmLogin.Free;
  if g_boLoginOK then begin
    g_SearchList := TList.Create;
    g_LocalDB := TLocalDB.Create;
    g_FileIDDB := TFileIDDB.Create(g_sIDDBFileName);
    g_FileHumDB := TFileHumDB.Create(g_sHumDBFileName);
    g_FileDB := TFileDB.Create(g_sMirDBFileName);
    g_Storage := TStorage.Create(g_sBigStorageFileName);
    g_SellOff := TSellOff.Create(g_sSellOffSellFileName);
    g_SellGold := TSellOff.Create(g_sSellOffGoldFileName);

    g_FileIDDB.m_boLoad := g_boIDDBFileName;
    g_FileHumDB.m_boLoad := g_boHumDBFileName;
    g_FileDB.m_boLoad := g_boMirDBFileName;
    g_Storage.m_boLoad := g_boBigStorageFileName;
    g_SellOff.m_boLoad := g_boSellOffSellFileName;
    g_SellGold.m_boLoad := g_boSellOffGoldFileName;

    g_DataManage[0] := g_FileIDDB;
    g_DataManage[1] := g_FileHumDB;
    g_DataManage[2] := g_FileDB;
    g_DataManage[3] := g_Storage;
    g_DataManage[4] := g_SellOff;
    g_DataManage[5] := g_SellGold;

    for I := 0 to 5 do g_DataManage[I].m_nType := I;
    frmProgress := TfrmProgress.Create(Self);
    frmProgress.Open();
    frmProgress.Free;
    Application.ShowMainForm := True;
    OnCloseQuery := FormCloseQuery;

    frmWelcome := TfrmWelcome.Create(Application);
    frmWelcome.Parent := TabSheet1;
    frmWelcome.Align := alClient;
    frmWelcome.Init;

    frmDataClear := TfrmDataClear.Create(Application);
    frmDataClear.Parent := TabSheet2;
    frmDataClear.Align := alClient;
    frmDataClear.Init;

  //PageControl.ActivePage := TabSheet2;

    frmItemManage := TfrmItemManage.Create(Application);
    frmItemManage.Parent := TabSheet3;
    frmItemManage.Align := alClient;
    frmItemManage.Init;

  //PageControl.ActivePage := TabSheet3;

    frmAccountManage := TfrmAccountManage.Create(Application);
    frmAccountManage.Parent := TabSheet4;
    frmAccountManage.Align := alClient;
    frmAccountManage.Init;

  //PageControl.ActivePage := TabSheet4;

    frmHumManage := TfrmHumManage.Create(Application);
    frmHumManage.Parent := TabSheet5;
    frmHumManage.Align := alClient;
    frmHumManage.Init;

  //PageControl.ActivePage := TabSheet5;

    frmOtherOption := TfrmOtherOption.Create(Application);
    frmOtherOption.Parent := TabSheet6;
    frmOtherOption.Align := alClient;
    frmOtherOption.Init;

    PageControl.ActivePage := TabSheet1;


    ProcessMessage(Format('ID:%d Hum:%d Mir:%d', [g_FileIDDB.m_IDDBList.Count,
      g_FileHumDB.m_HumCharNameList.Count, g_FileDB.m_MirCharNameList.Count]), 1);
  end else begin
    Application.Terminate;
  end;
end;

procedure TFrmMain.PageControlChange(Sender: TObject);
var
  I: Integer;
begin
  if PageControl.ActivePage = TabSheet1 then frmWelcome.WebBrowser.Refresh;
  {if PageControl.ActivePage = TabSheet2 then frmDataClear.Init;
  if PageControl.ActivePage = TabSheet3 then frmItemManage.Init;
  if PageControl.ActivePage = TabSheet4 then frmAccountManage.Init;
  if PageControl.ActivePage = TabSheet5 then frmHumManage.Init;
  if PageControl.ActivePage = TabSheet6 then frmOtherOption.Init;
   }

  for I := 0 to 5 do begin
    g_DataManage[I].OnStart := OnStart;
    g_DataManage[I].OnStop := OnStop;
    g_DataManage[I].OnProgress := OnProgress;
  end;
  g_DataManage[5].OnStart := OnSubStart;
  g_DataManage[5].OnStop := OnSubStop;
  g_DataManage[5].OnProgress := OnSubProgress;
end;

end.

