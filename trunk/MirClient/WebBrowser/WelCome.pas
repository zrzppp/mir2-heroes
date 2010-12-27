unit WelCome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, IEAddress, ComCtrls, ToolWin,
  ImgList, Menus, ExtCtrls, RzButton;

type
  TfrmWelCome = class(TForm)
    imgToolBar: TImageList;
    imgPageControl: TImageList;
    imgFavorite: TImageList;
    ImageList1: TImageList;
    ImageList2: TImageList;
    CoolBar: TCoolBar;
    tblMainToolBar: TToolBar;
    btnBack: TToolButton;
    btnForward: TToolButton;
    ToolButton7: TToolButton;
    ToolButton5: TToolButton;
    ToolButton9: TToolButton;
    pmnBack: TPopupMenu;
    pmnForward: TPopupMenu;
    lblAddress: TLabel;
    cobAddress: TIEAddress;
    btnAddress: TToolButton;
    Timer: TTimer;
    WebBrowser1: TWebBrowser;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAddressClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure btnForwardClick(Sender: TObject);
    procedure cobAddressKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cobAddressUrlSelected(Sender: TObject; Url: string);
    procedure WebBrowserDocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var Url: OleVariant);
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    nOldX: Integer;
    nOldY: Integer;

  public
    { Public declarations }
    procedure Open(); overload;
    procedure Open(sHomePage: string); overload;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WmNCHitTest(var Msg: TWMNCHitTest); message wm_NcHitTest;
  end;


var
  frmWelCome: TfrmWelCome;
  g_sUrl: string;
implementation
uses PlugCommon;
{$R *.dfm}
var
  WebBrowser: TWebBrowser = nil;

procedure TfrmWelCome.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  //Params.Style := Params.Style xor ws_caption xor ws_popup;
  Params.Style := WS_THICKFRAME or WS_TILEDWINDOW { or WS_POPUP or WS_BORDER};
end;

procedure TfrmWelCome.WmNCHitTest(var Msg: TWMNCHitTest);
const v = 10; //border width
var p: TPoint;
begin
  inherited;
  p := Point(Msg.XPos, Msg.YPos);
  p := ScreenToClient(p);
  if PtInRect(Rect(0, 0, v, v), p) then
    Msg.Result := HTTOPLEFT
  else if PtInRect(Rect(Width - v, Height - v, Width, Height), p) then
    Msg.Result := HTBOTTOMRIGHT
  else if PtInRect(Rect(Width - v, 0, Width, v), p) then
    Msg.Result := HTTOPRIGHT
  else if PtInRect(Rect(0, Height - v, v, Height), p) then
    Msg.Result := HTBOTTOMLEFT
  else if PtInRect(Rect(v, 0, Width - v, v), p) then
    Msg.Result := HTTOP
  else if PtInRect(Rect(0, v, v, Height - v), p) then
    Msg.Result := HTLEFT
  else if PtInRect(Rect(Width - v, v, Width, Height - v), p) then
    Msg.Result := HTRIGHT
  else if PtInRect(Rect(v, Height - v, Width - v, Height), p) then
    Msg.Result := HTBOTTOM;
end;

procedure TfrmWelCome.Open();
begin
  g_sUrl := 'http://Www.51pao.com';
  Show;
end;

procedure TfrmWelCome.Open(sHomePage: string);
begin
  g_sUrl := sHomePage;
  Show;
end;

procedure TfrmWelCome.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  g_PlugInfo.KeyDown(Key, Shift);
end;

procedure TfrmWelCome.FormKeyPress(Sender: TObject; var Key: Char);
begin
  g_PlugInfo.KeyPress(Key);
end;

procedure TfrmWelCome.btnAddressClick(Sender: TObject);
begin
  WebBrowser.Navigate(cobAddress.Text);
end;

procedure TfrmWelCome.btnBackClick(Sender: TObject);
begin
  WebBrowser.GoBack;
end;

procedure TfrmWelCome.ToolButton5Click(Sender: TObject);
begin
  WebBrowser.Refresh;
end;

procedure TfrmWelCome.btnForwardClick(Sender: TObject);
begin
  WebBrowser.GoForward;
end;

procedure TfrmWelCome.cobAddressKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then btnAddressClick(nil);
end;

procedure TfrmWelCome.cobAddressUrlSelected(Sender: TObject; Url: string);
begin
  WebBrowser.Navigate(Url);
end;

procedure TfrmWelCome.WebBrowserDocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var Url: OleVariant);
begin
  Caption := WebBrowser.LocationName;
end;

procedure TfrmWelCome.FormCreate(Sender: TObject);
begin
  cobAddress.Items.Clear;
 { cobAddress.Items.Add(DecryptString(g_sOpenHomePage));
  cobAddress.Items.Add(DecryptString(g_sOpenHomePage1));  }
  cobAddress.ItemIndex := 0;
end;

procedure TfrmWelCome.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;
  WebBrowser.Navigate(g_sUrl);
end;

procedure TfrmWelCome.FormShow(Sender: TObject);
begin
  if WebBrowser = nil then begin
    WebBrowser := TWebBrowser.Create(Self);
    WebBrowser.ParentWindow := Self.Handle;
    WebBrowser.OnDocumentComplete := WebBrowserDocumentComplete;
    with WebBrowser do begin
      Left := 0;
      Top := 26;
      Width := 644;
      Height := 390;
      //SetBounds(Left, Top, Width, Height);
    end;
    WebBrowser.Align := alClient;
    cobAddress.Webbrowser := Webbrowser;
  end;
  Timer.Enabled := True;
end;

procedure TfrmWelCome.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
  if WebBrowser <> nil then begin
    WebBrowser.Stop;
    FreeAndNil(WebBrowser);
  end;
end;

procedure TfrmWelCome.FormResize(Sender: TObject);
begin
   // with WebBrowser do begin
  if WebBrowser <> nil then begin
    WebBrowser.Left := 0;
    WebBrowser.Top := 26;
    WebBrowser.Width := ClientWidth;
    WebBrowser.Height := ClientHeight - 26;
    with WebBrowser do
      SetBounds(Left, Top, Width, Height);
  end;
   // end;
end;

end.

