unit MediaPlayerMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPanel, ExtCtrls, RzSplit, RzButton, RzBmpBtn, MediaPlayerShare,
  StdCtrls, RzLstBox, Buttons, Menus, PlugCommon, RzLabel, OleCtrls, WMPLib_TLB,
  BmpBtn, ComCtrls, ImgList;

type
  TfrmCqFirMediaPlayer = class(TForm)
    RzPanelBottom: TRzPanel;
    ImageLeftBottom: TImage;
    ImageRightBottom: TImage;
    PopupMenuPalyMode: TPopupMenu;
    Menu_Mode1: TMenuItem;
    Menu_Mode2: TMenuItem;
    Menu_Mode3: TMenuItem;
    Menu_Mode4: TMenuItem;
    Menu_Mode5: TMenuItem;
    RzPanelPlay: TRzPanel;
    Timer: TTimer;
    PanelPalyMsg: TRzPanel;
    TimerStart: TTimer;
    PopupMenu_Add: TPopupMenu;
    Menu_AddLocalFile: TMenuItem;
    Menu_AddRemoteFile: TMenuItem;
    RzShapeButton: TRzShapeButton;
    WindowsMediaPlayer: TWindowsMediaPlayer;
    ImageBottom: TImage;
    RzPanelTop: TRzPanel;
    ImageTop: TImage;
    ImageRightTop: TImage;
    RzPanelLeft: TRzPanel;
    RzPanelRight: TRzPanel;
    ImageLeft: TImage;
    ImageRight: TImage;
    BmpButtonClose: TBmpButton;
    BmpButtonMax: TBmpButton;
    BmpButtonMin: TBmpButton;
    RzPanelPlayList: TRzPanel;
    RzBmpButtonPause: TBmpButton;
    RzBmpButtonPlay: TBmpButton;
    RzBmpButtonPrev: TBmpButton;
    RzBmpButtonNext: TBmpButton;
    BmpButtonVoice: TBmpButton;
    BmpButtonSilent: TBmpButton;
    RzBmpButtonStop: TBmpButton;
    RzPanel1: TRzPanel;
    RzListBoxPlayList: TRzListBox;
    ImageMain: TImage;
    BmpProgressBarSound: TBmpProgressBar;
    BmpProgressBar: TBmpProgressBar;
    RzLabelPlayState: TRzLabel;
    RzLabelPlayPosition: TRzLabel;
    RzBmpButton1: TRzBmpButton;
    LabelFormCaption: TRzLabel;
    LabelCaption: TRzLabel;
    BmpButtonRestore: TBmpButton;
    BmpButtonSizeRight: TBmpButton;
    BmpButtonSizeLeft: TBmpButton;
    BmpButtonOpen: TBmpButton;
    BmpButtonFullScreen: TBmpButton;
    BmpButtonShowPlayList: TBmpButton;
    BmpButtonOpenA: TBmpButton;
    RzBmpButton2: TRzBmpButton;
    BmpButtonClear: TBmpButton;
    BmpButtonMod: TBmpButton;
    ImageList: TImageList;
    ImageLeftTop: TImage;
    procedure FormCreate(Sender: TObject);
    procedure RzSizePanelConstrainedResize(Sender: TObject; var MinWidth,
      MinHeight, MaxWidth, MaxHeight: Integer);
    procedure FormConstrainedResize(Sender: TObject; var MinWidth,
      MinHeight, MaxWidth, MaxHeight: Integer);
    procedure RzBmpButtonPlayClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ImageLeftBottomMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure WindowsMediaPlayerPlayStateChange(ASender: TObject;
      NewState: Integer);
    procedure RzBmpButtonStopClick(Sender: TObject);
    procedure WindowsMediaPlayerMediaError(ASender: TObject;
      const pMediaObject: IDispatch);
    procedure TimerTimer(Sender: TObject);
    procedure BmpButtonVoiceClick(Sender: TObject);
    procedure TimerStartTimer(Sender: TObject);
    procedure RzListBoxPlayListClick(Sender: TObject);
    procedure RzListBoxPlayListDblClick(Sender: TObject);
    procedure RzBmpButtonNextClick(Sender: TObject);
    procedure RzBmpButtonPrevClick(Sender: TObject);
    procedure Menu_Mode1Click(Sender: TObject);
    procedure Menu_AddLocalFileClick(Sender: TObject);
    procedure RzShapeButtonMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure RzShapeButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RzMenuToolbarButtonPalyModeMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BmpProgressBarChange(Sender: TObject);
    procedure BmpProgressBarSoundChange(Sender: TObject);
    procedure BmpProgressBarMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BmpProgressBarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BmpButtonMinClick(Sender: TObject);
    procedure BmpButtonMaxClick(Sender: TObject);
    procedure BmpButtonCloseClick(Sender: TObject);
    procedure BmpButtonSizeRightClick(Sender: TObject);
    procedure BmpButtonOpenClick(Sender: TObject);
    procedure BmpButtonFullScreenClick(Sender: TObject);
    procedure WindowsMediaPlayerKeyDown(ASender: TObject; nKeyCode,
      nShiftState: Smallint);
    procedure WindowsMediaPlayerDoubleClick(ASender: TObject; nButton,
      nShiftState: Smallint; fX, fY: Integer);
    procedure BmpProgressBarSoundPaintBackGround(Sender: TObject;
      Bitmap: TBitmap);
    procedure BmpProgressBarSoundPaintProgress(Sender: TObject;
      Bitmap: TBitmap);
    procedure BmpProgressBarPaintBackGround(Sender: TObject;
      Bitmap: TBitmap);
    procedure BmpProgressBarPaintProgress(Sender: TObject;
      Bitmap: TBitmap);
    procedure BmpButtonClearClick(Sender: TObject);
    procedure BmpButtonModMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RzListBoxPlayListDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure RzListBoxPlayListMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure RzListBoxPlayListMouseLeave(Sender: TObject);
    procedure RzListBoxPlayListMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure RzListBoxPlayListMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FMinimized: Boolean;
    procedure ChangeButtonState();

    procedure ButtonResize;

  public

    { Public declarations }
//    procedure WMSize(var msg: TWMSize); message wm_Size;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WmNCHitTest(var Msg: TWMNCHitTest); message wm_NcHitTest;

    procedure StopPlay(const FileName: string);
    procedure Play(); overload;
    procedure Play(FileName: string; boShow: Boolean); overload;
    procedure Play(FileName: string; boShow, boPlay: Boolean); overload;
    procedure RefListBoxPlayList();
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;
    property Minimized: Boolean read FMinimized write FMinimized;

  end;

function GetPlayInfo: string;
var
  frmCqFirMediaPlayer: TfrmCqFirMediaPlayer;
  nOldX, nOldY: Integer;
  HTMSG: Integer;
  //WindowsMediaPlayer: TWindowsMediaPlayer;
implementation

uses OpenDialogNew;
{$R Res\Processbar\Processbar.res}
{$R Res\Sound\Sound.res}
{$R *.dfm}

function GetCaption: string;
begin
  Result := '飞尔世界影音播放器 [ALT + P键打开影音播放器]';
  if (g_nCurrentIndex >= 0) and (g_nCurrentIndex < g_PlayList.Count) then begin
    Result := '[ALT + P键打开影音播放器] ' + g_PlayList.m_PlayList.Strings[g_nCurrentIndex];
  end;
end;

function GetPlayInfo: string;
begin
  Result := '飞尔世界影音播放器 [ALT + P键打开影音播放器]';
  if (g_PlayList <> nil) and (g_nCurrentIndex >= 0) and (g_nCurrentIndex < g_PlayList.Count) then begin
    Result := '正在播放 ' + g_PlayList.m_PlayList.Strings[g_nCurrentIndex] + ' ' +
      frmCqFirMediaPlayer.WindowsMediaPlayer.Controls.currentPositionString + ' / ' + frmCqFirMediaPlayer.WindowsMediaPlayer.currentMedia.durationString;
  end;
end;

function FormatWidthString(Canvas: TCanvas; const Str: string; const Len: Integer): string;
var
  I, nTextLen: Integer;
  sText: string;
  S: WideString;
begin
  Result := Str;
  if Canvas.TextWidth(Str) > Len then begin
    sText := '';
    S := Str;
    for I := 1 to Length(S) do begin
      nTextLen := Canvas.TextWidth(sText + S[I] + '...');
      if nTextLen = Len then begin
        Result := sText + S[I] + '...';
        Exit;
      end else
        if nTextLen > Len then begin
        Result := sText + '...';
        Exit;
      end;
      sText := sText + S[I];
    end;
  end;
end;

procedure TfrmCqFirMediaPlayer.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  //Params.Style := Params.Style xor ws_caption xor ws_popup;
  //Params.Style := WS_THICKFRAME or WS_TILEDWINDOW { or WS_POPUP or WS_BORDER};
end;

procedure TfrmCqFirMediaPlayer.WmNCHitTest(var Msg: TWMNCHitTest);
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

procedure TfrmCqFirMediaPlayer.WMSysCommand(var Msg: TMessage);
begin
  case Msg.WParam of
    SC_MINIMIZE: Minimized := True;
    SC_MAXIMIZE: Minimized := False;
    SC_RESTORE: Minimized := False;
  end;
{  case Msg.WParam of
    SC_MINIMIZE,
      SC_MAXIMIZE,
      SC_RESTORE: begin
        RzPanelBotton.Height := 65;
        g_dwMouseMoveTick := GetTickCount;
      end;
  end;  }
  inherited;
end;

procedure TfrmCqFirMediaPlayer.StopPlay(const FileName: string);
begin
  if WindowsMediaPlayer.playState = wmppsPlaying then begin
    if CompareText(g_sCurrentSource, FileName) = 0 then begin
      g_boHandicraft := True;
      WindowsMediaPlayer.Controls.stop;
    end;
  end;
  RzListBoxPlayList.Repaint;
end;

procedure TfrmCqFirMediaPlayer.Play();
begin
  RzListBoxPlayList.Repaint;
  if (g_nCurrentIndex >= 0) and (g_nCurrentIndex < g_PlayList.Count) then begin
    WindowsMediaPlayer.Controls.stop;
    ChangeButtonState();
    LabelFormCaption.Caption := FormatWidthString(LabelFormCaption.Canvas, GetCaption, ClientWidth - (LabelCaption.Left + LabelCaption.Width + ImageRightTop.Width + 12));
    if g_sCurrentSource <> '' then begin
      WindowsMediaPlayer.URL := g_sCurrentSource;
      try
        WindowsMediaPlayer.Controls.Play;
      except
        WindowsMediaPlayer.Controls.stop;
      end;

    end;
  end;
end;

procedure TfrmCqFirMediaPlayer.Play(FileName: string; boShow: Boolean);
var
  nItemIndex: Integer;
begin
  if FileName <> '' then begin
    nItemIndex := g_PlayList.Add(FileName);
    if nItemIndex >= 0 then begin
      RzListBoxPlayList.Items.Clear;
      RzListBoxPlayList.Items.AddStrings(g_PlayList.m_PlayList);
      RzListBoxPlayList.ItemIndex := nItemIndex;
      g_boHandicraft := True;
      g_nCurrentIndex := RzListBoxPlayList.ItemIndex;
      Play();
    end;
  end;
  if boShow then begin
    Show;
   // if Minimized then
    SendMessage(Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
  end;
  RzListBoxPlayList.Repaint;
end;

procedure TfrmCqFirMediaPlayer.Play(FileName: string; boShow, boPlay: Boolean);
var
  nItemIndex: Integer;
begin
  if FileName <> '' then begin
    nItemIndex := g_PlayList.Add(FileName);
    if nItemIndex >= 0 then begin
      RzListBoxPlayList.Items.Clear;
      RzListBoxPlayList.Items.AddStrings(g_PlayList.m_PlayList);
      RzListBoxPlayList.ItemIndex := nItemIndex;
      g_boHandicraft := True;
      g_nCurrentIndex := RzListBoxPlayList.ItemIndex;
      if boPlay then Play();
    end;
  end;
  if boShow then begin
    Show;
    //if Minimized then
    SendMessage(Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
  end;
  RzListBoxPlayList.Repaint;
end;

procedure TfrmCqFirMediaPlayer.ChangeButtonState();
begin
  g_sCurrentSource := '';
  if (g_nCurrentIndex >= 0) and (g_nCurrentIndex < g_PlayList.Count) then begin
    g_sCurrentSource := pTPlayFile(g_PlayList.m_PlayList.Objects[g_nCurrentIndex]).sSource;
    case WindowsMediaPlayer.playState of
      wmppsStopped: begin //停止状态
          BmpProgressBar.Position := 0;
          PanelPalyMsg.Visible := False;
          WindowsMediaPlayer.Visible := False;
          BmpButtonFullScreen.Enabled := False;


          RzBmpButtonPlay.Visible := True;
          RzBmpButtonPlay.Enabled := True;
          RzBmpButtonPause.Visible := False;

          BmpButtonOpenA.Visible := True;

          RzLabelPlayState.Caption := '播放停止...';
        end;
      wmppsPaused: begin //暂停状态
          PanelPalyMsg.Visible := True;
          WindowsMediaPlayer.Visible := True;


          BmpButtonFullScreen.Enabled := True;
          RzBmpButtonPlay.Visible := True;
          RzBmpButtonPlay.Enabled := True;
          RzBmpButtonPause.Visible := False;

          BmpButtonOpenA.Visible := False;
          RzLabelPlayState.Caption := '播放暂停...';
        end;
      wmppsPlaying: begin //播放状态
          PanelPalyMsg.Visible := True;
          WindowsMediaPlayer.Visible := True;

          BmpButtonFullScreen.Enabled := True;
          RzBmpButtonPlay.Visible := False;
          RzBmpButtonPause.Visible := True;
          BmpButtonOpenA.Visible := False;
          RzLabelPlayState.Caption := '正在播放...';
        end;
      wmppsBuffering: begin
          PanelPalyMsg.Visible := False;
          WindowsMediaPlayer.Visible := False;

          RzBmpButtonPlay.Visible := True;
          RzBmpButtonPause.Visible := False;
          RzBmpButtonPlay.Enabled := False;

          BmpButtonOpenA.Visible := False;
          RzLabelPlayState.Caption := '正在缓冲...';
        end;
      wmppsWaiting: begin
          PanelPalyMsg.Visible := False;
          WindowsMediaPlayer.Visible := False;

          RzBmpButtonPlay.Visible := True;
          RzBmpButtonPause.Visible := False;
          RzBmpButtonPlay.Enabled := False;

          BmpButtonOpenA.Visible := False;
          RzLabelPlayState.Caption := '正在等待...';
        end;
      wmppsReady: begin
          PanelPalyMsg.Visible := False;
          WindowsMediaPlayer.Visible := False;

          BmpButtonFullScreen.Enabled := False;
          RzBmpButtonPlay.Visible := True;
          RzBmpButtonPause.Visible := False;
          RzBmpButtonPlay.Enabled := False;

          BmpButtonOpenA.Visible := True;
          RzLabelPlayState.Caption := '准备就绪...';
        end;

      wmppsScanForward: RzLabelPlayState.Caption := '向前搜索...';
      wmppsScanReverse: RzLabelPlayState.Caption := '向后搜索...';
      wmppsMediaEnded: RzLabelPlayState.Caption := '播放结束...';
      wmppsTransitioning: RzLabelPlayState.Caption := '准备新媒体...';
      wmppsReconnecting: RzLabelPlayState.Caption := '尝试重新连接...';
      wmppsLast: RzLabelPlayState.Caption := 'wmppsLast';

    else begin
        BmpProgressBar.Position := 0;
        PanelPalyMsg.Visible := False;
        WindowsMediaPlayer.Visible := False;

        BmpButtonFullScreen.Enabled := False;
        RzBmpButtonPlay.Visible := True;
        RzBmpButtonPlay.Enabled := True;
        RzBmpButtonPause.Visible := False;

        BmpButtonOpenA.Visible := True;
        RzLabelPlayState.Caption := '播放停止...';
      end;
    end;
    if g_nCurrentIndex <= 0 then begin
      if g_PlayList.Count > 1 then begin
        RzBmpButtonNext.Enabled := True;
        RzBmpButtonPrev.Enabled := False;
      end else begin
        RzBmpButtonNext.Enabled := False;
        RzBmpButtonPrev.Enabled := False;
      end;
    end else begin
      if g_nCurrentIndex < g_PlayList.Count - 1 then begin
        RzBmpButtonNext.Enabled := True;
        RzBmpButtonPrev.Enabled := True;
      end else begin
        RzBmpButtonNext.Enabled := False;
        RzBmpButtonPrev.Enabled := True;
      end;
    end;
  end;
  RzListBoxPlayList.Repaint;
end;

procedure TfrmCqFirMediaPlayer.FormCreate(Sender: TObject);
var
  Stream: TResourceStream;
begin
  g_SoundBarInnerLeft := TBitmap.Create;
  g_SoundBarInnerRight := TBitmap.Create;
  g_SoundBarLeft := TBitmap.Create;
  g_SoundBarRight := TBitmap.Create;

  g_ProgressBarBGLeft := TBitmap.Create;
  g_ProgressBarFGLeft := TBitmap.Create;
  g_SeekBarBuffered := TBitmap.Create;
  g_SeekBarInnerLeft := TBitmap.Create;
  g_SeekBarInnerRight := TBitmap.Create;
  g_SeekBarLeft := TBitmap.Create;
  g_SeekBarRight := TBitmap.Create;
  g_SeekBarRightBuffered := TBitmap.Create;


  Stream := TResourceStream.Create(HInstance, 'SoundBarInnerLeft', PChar('Bmp'));
  g_SoundBarInnerLeft.LoadFromStream(Stream);
  Stream.Free;

  Stream := TResourceStream.Create(HInstance, 'SoundBarInnerRight', PChar('Bmp'));
  g_SoundBarInnerRight.LoadFromStream(Stream);
  Stream.Free;

  Stream := TResourceStream.Create(HInstance, 'SoundBarLeft', PChar('Bmp'));
  g_SoundBarLeft.LoadFromStream(Stream);
  Stream.Free;


  Stream := TResourceStream.Create(HInstance, 'SoundBarRight', PChar('Bmp'));
  g_SoundBarRight.LoadFromStream(Stream);
  Stream.Free;

  Stream := TResourceStream.Create(HInstance, 'ProgressBarBGLeft', PChar('Bmp'));
  g_ProgressBarBGLeft.LoadFromStream(Stream);
  Stream.Free;

  Stream := TResourceStream.Create(HInstance, 'ProgressBarFGLeft', PChar('Bmp'));
  g_ProgressBarFGLeft.LoadFromStream(Stream);
  Stream.Free;

  Stream := TResourceStream.Create(HInstance, 'SeekBarBuffered', PChar('Bmp'));
  g_SeekBarBuffered.LoadFromStream(Stream);
  Stream.Free;


  Stream := TResourceStream.Create(HInstance, 'SeekBarInnerLeft', PChar('Bmp'));
  g_SeekBarInnerLeft.LoadFromStream(Stream);
  Stream.Free;


  Stream := TResourceStream.Create(HInstance, 'SeekBarInnerRight', PChar('Bmp'));
  g_SeekBarInnerRight.LoadFromStream(Stream);
  Stream.Free;

  Stream := TResourceStream.Create(HInstance, 'SeekBarLeft', PChar('Bmp'));
  g_SeekBarLeft.LoadFromStream(Stream);
  Stream.Free;


  Stream := TResourceStream.Create(HInstance, 'SeekBarRight', PChar('Bmp'));
  g_SeekBarRight.LoadFromStream(Stream);
  Stream.Free;

  Stream := TResourceStream.Create(HInstance, 'SeekBarRightBuffered', PChar('Bmp'));
  g_SeekBarRightBuffered.LoadFromStream(Stream);
  Stream.Free;

  FMinimized := True;


  WindowsMediaPlayer.stretchToFit := True;
  //WindowsMediaPlayer.settings.autoStart := False;
  WindowsMediaPlayer.enableContextMenu := False;
  WindowsMediaPlayer.settings.invokeURLs := False;
  WindowsMediaPlayer.settings.enableErrorDialogs := False;
  //WindowsMediaPlayer.OnMarkerHit := Self.WindowsMediaPlayerMarkerHit;
  {WindowsMediaPlayer.OnMediaError := Self.WindowsMediaPlayerMediaError;
  WindowsMediaPlayer.OnWarning := Self.WindowsMediaPlayerWarning;
  WindowsMediaPlayer.OnPlayStateChange := Self.WindowsMediaPlayerPlayStateChange;
  WindowsMediaPlayer.OnMouseMove := Self.WindowsMediaPlayerMouseMove;}

  WindowsMediaPlayer.Align := alClient;
  WindowsMediaPlayer.Visible := True;

  BmpButtonSizeLeft.Bitmaps.TransparentColor := clFuchsia;
  BmpButtonSizeRight.Bitmaps.TransparentColor := clFuchsia;

  BmpProgressBar.Bar.TransparentColor := clFuchsia;
  BmpProgressBarSound.Bar.TransparentColor := clFuchsia;

  ImageLeftTop.Picture.Bitmap.TransparentColor := clFuchsia;
  ImageRightTop.Picture.Bitmap.TransparentColor := clFuchsia;
  ImageLeftBottom.Picture.Bitmap.TransparentColor := clFuchsia;
  ImageRightBottom.Picture.Bitmap.TransparentColor := clFuchsia;

  ImageLeft.Picture.Bitmap.TransparentColor := clFuchsia;
  ImageRight.Picture.Bitmap.TransparentColor := clFuchsia;


  ClientHeight := 290;
  ClientWidth := 490;

  Menu_Mode1Click(Menu_Mode3);
  TimerStart.Enabled := True;
end;

procedure TfrmCqFirMediaPlayer.RzSizePanelConstrainedResize(
  Sender: TObject; var MinWidth, MinHeight, MaxWidth, MaxHeight: Integer);
begin
  if WindowsMediaPlayer.Visible then begin
    ActiveControl := nil;
    ActiveControl := WindowsMediaPlayer;
  end;
end;

procedure TfrmCqFirMediaPlayer.FormConstrainedResize(Sender: TObject;
  var MinWidth, MinHeight, MaxWidth, MaxHeight: Integer);
begin
  MinWidth := 490;
  MinHeight := 290;
end;

procedure TfrmCqFirMediaPlayer.RzBmpButtonPlayClick(Sender: TObject);
begin
  case WindowsMediaPlayer.playState of
    wmppsPaused: begin
        WindowsMediaPlayer.Controls.Play;
      end;
    wmppsPlaying: begin
        WindowsMediaPlayer.Controls.pause;
      end;
  else begin
      WindowsMediaPlayer.close;
      g_nCurrentIndex := RzListBoxPlayList.ItemIndex;
      Play();
    end;
  end;
end;

procedure TfrmCqFirMediaPlayer.ButtonResize;
var
  nLeft, nTop: Integer;
begin
  if ClientHeight < 290 then ClientHeight := 290;
  if ClientWidth < 490 then ClientWidth := 490;

  LabelFormCaption.Caption := FormatWidthString(LabelFormCaption.Canvas, GetCaption, ClientWidth - (LabelCaption.Left + LabelCaption.Width + ImageRightTop.Width + 12));

  nLeft := (ClientWidth - RzBmpButtonPlay.Width) div 2;

  RzBmpButtonPlay.Left := nLeft;
  RzBmpButtonPause.Left := nLeft;
  RzBmpButtonNext.Left := nLeft + RzBmpButtonPlay.Width;
  BmpButtonVoice.Left := RzBmpButtonNext.Left + RzBmpButtonNext.Width;
  BmpButtonSilent.Left := BmpButtonVoice.Left;
  BmpProgressBarSound.Left := BmpButtonVoice.Left + BmpButtonVoice.Width + 10;


  BmpButtonShowPlayList.Left := ClientWidth - BmpButtonShowPlayList.Width - 24;
  BmpButtonFullScreen.Left := BmpButtonShowPlayList.Left - BmpButtonFullScreen.Width;
  BmpButtonOpen.Left := BmpButtonFullScreen.Left - BmpButtonOpen.Width;


  RzBmpButtonPrev.Left := RzBmpButtonPlay.Left - RzBmpButtonPrev.Width;
  RzBmpButtonStop.Left := RzBmpButtonPrev.Left - RzBmpButtonStop.Width;

  RzBmpButtonPlay.Top := 1;
  RzBmpButtonPause.Top := 1;
  RzBmpButtonNext.Top := 8;
  BmpButtonVoice.Top := 8;
  BmpButtonSilent.Top := 8;
  BmpProgressBarSound.Top := 16;

  BmpButtonOpen.Top := 12;
  BmpButtonFullScreen.Top := 12;
  BmpButtonShowPlayList.Top := 12;


  RzBmpButtonPrev.Top := 8;
  RzBmpButtonStop.Top := 8;


  nTop := (Height - BmpButtonSizeLeft.Height) div 2;
  BmpButtonSizeLeft.Top := nTop;
  BmpButtonSizeRight.Top := nTop;

  BmpButtonSizeLeft.Left := ClientWidth - BmpButtonSizeLeft.Width;
  BmpButtonSizeRight.Left := BmpButtonSizeLeft.Left;

  BmpButtonOpenA.Left := (RzPanelPlay.Width - BmpButtonOpenA.Width) div 2;
  BmpButtonOpenA.Top := (RzPanelPlay.Height - BmpButtonOpenA.Height) div 2;
end;

procedure TfrmCqFirMediaPlayer.FormResize(Sender: TObject);
begin
  ButtonResize;
  if WindowsMediaPlayer.Visible then begin
    ActiveControl := nil;
    ActiveControl := WindowsMediaPlayer;
  end;
end;

procedure TfrmCqFirMediaPlayer.ImageLeftBottomMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure TfrmCqFirMediaPlayer.WindowsMediaPlayerPlayStateChange(
  ASender: TObject; NewState: Integer);
begin
  ChangeButtonState();
end;

procedure TfrmCqFirMediaPlayer.RzBmpButtonStopClick(Sender: TObject);
begin
  WindowsMediaPlayer.Controls.stop;
  g_boHandicraft := True;
end;

procedure TfrmCqFirMediaPlayer.WindowsMediaPlayerMediaError(
  ASender: TObject; const pMediaObject: IDispatch);
begin
  WindowsMediaPlayer.Controls.stop;
end;

procedure TfrmCqFirMediaPlayer.TimerTimer(Sender: TObject);
begin
  if WindowsMediaPlayer.Visible then begin
    if (WindowsMediaPlayer.playState = wmppsPlaying) then begin
      g_boHandicraft := False;
      WindowsMediaPlayer.Visible := True;
      PanelPalyMsg.Visible := True;

      if (WindowsMediaPlayer.currentMedia.duration > 0) and (not g_boChangeProgress) then begin
        BmpProgressBar.Max := WindowsMediaPlayer.currentMedia.duration;
        BmpProgressBar.Position := WindowsMediaPlayer.Controls.currentPosition;
        RzLabelPlayPosition.Caption := WindowsMediaPlayer.Controls.currentPositionString + '/' + WindowsMediaPlayer.currentMedia.durationString;
      end;
     { if WindowsMediaPlayer.Visible then begin
        ActiveControl := nil;
        ActiveControl := WindowsMediaPlayer;
      end;}
    end else
      if (WindowsMediaPlayer.playState = wmppsBuffering) then begin
      RzLabelPlayPosition.Caption := '正在缓冲:' + IntToStr(WindowsMediaPlayer.network.bufferingProgress);

    end else
      if (WindowsMediaPlayer.playState = wmppsWaiting) then begin

    end else begin
      RzLabelPlayPosition.Caption := '';
    end;
  end else begin
    RzLabelPlayPosition.Caption := '';
  end;

  if (WindowsMediaPlayer.playState = wmppsStopped) and not g_boHandicraft then begin
    if Menu_Mode5.Checked then begin
      WindowsMediaPlayer.Controls.stop;
      Play();
    end else
      if Menu_Mode3.Checked then begin
      WindowsMediaPlayer.Controls.stop;
      Inc(g_nCurrentIndex);
      if g_nCurrentIndex < g_PlayList.Count then begin
        RzListBoxPlayList.ItemIndex := g_nCurrentIndex;
        Play();
      end else g_nCurrentIndex := g_PlayList.Count - 1;
    end else
      if Menu_Mode2.Checked then begin
      WindowsMediaPlayer.Controls.stop;
      g_nCurrentIndex := Random(g_PlayList.Count - 1);
      RzListBoxPlayList.ItemIndex := g_nCurrentIndex;
      Play();
    end else
      if Menu_Mode1.Checked then begin
      WindowsMediaPlayer.Controls.stop;
      Inc(g_nCurrentIndex);
      if g_nCurrentIndex >= g_PlayList.Count then g_nCurrentIndex := 0;
      RzListBoxPlayList.ItemIndex := g_nCurrentIndex;
      Play();
    end;

  end else begin

  end;
end;

procedure TfrmCqFirMediaPlayer.BmpButtonVoiceClick(Sender: TObject);
begin
  if BmpButtonVoice.Visible then begin
    BmpButtonVoice.Visible := False;
    BmpButtonSilent.Visible := True;
    WindowsMediaPlayer.settings.mute := True;
  end else begin
    BmpButtonVoice.Visible := True;
    BmpButtonSilent.Visible := False;
    WindowsMediaPlayer.settings.mute := False;
  end;
end;

procedure TfrmCqFirMediaPlayer.TimerStartTimer(Sender: TObject);
begin
  TimerStart.Enabled := False;
  RzListBoxPlayList.Items.Clear;
  RzListBoxPlayList.Items.AddStrings(g_PlayList.m_PlayList);
  RzListBoxPlayList.ItemIndex := g_nCurrentIndex;
  ChangeButtonState();
  ButtonResize;
end;

procedure TfrmCqFirMediaPlayer.RzListBoxPlayListClick(Sender: TObject);
var
  nItemIndex: Integer;
begin
  if g_boMouseDown then begin
    g_boMouseDown := False;
    nItemIndex := RzListBoxPlayList.ItemIndex; // g_nMouseMoveIndex;
    if (nItemIndex >= 0) and (nItemIndex < RzListBoxPlayList.Items.Count) then begin
      if g_nCurrentIndex = nItemIndex then begin
        g_boHandicraft := True;
        WindowsMediaPlayer.Controls.stop;
      end;
      g_PlayList.Delete(pTPlayFile(RzListBoxPlayList.Items.Objects[nItemIndex]));
      RzListBoxPlayList.Items.Clear;
      RzListBoxPlayList.Items.AddStrings(g_PlayList.m_PlayList);
      g_nCurrentIndex := g_PlayList.GetSource(g_sCurrentSource);

      if (nItemIndex >= 0) and (nItemIndex < RzListBoxPlayList.Items.Count) then begin
        RzListBoxPlayList.ItemIndex := nItemIndex;
      end else
        if RzListBoxPlayList.Items.Count > 0 then begin
        RzListBoxPlayList.ItemIndex := RzListBoxPlayList.Items.Count - 1;
      end;

      RzListBoxPlayList.Repaint;
    end;
  end else begin
    g_nSelectIndex := RzListBoxPlayList.ItemIndex;
    if (g_nSelectIndex >= 0) and (g_nSelectIndex < g_PlayList.Count) then begin
    //g_PlugInfo.AddChatBoardString(PChar(Format('WindowsMediaPlayer.playState:%d', [WindowsMediaPlayer.playState])), clWhite, clFuchsia);
    //Showmessage('TfrmCqFirMediaPlayer.RzListBoxPlayListClick');
    //g_sCurrentSource := pTPlayFile(g_PlayList.m_PlayList.Objects[g_nCurrentIndex]).sSource;
      case WindowsMediaPlayer.playState of
        wmppsStopped: begin //停止状态
            BmpProgressBar.Position := 0;
            PanelPalyMsg.Visible := False;
            WindowsMediaPlayer.Visible := False;

            RzBmpButtonPlay.Visible := True;
            RzBmpButtonPlay.Enabled := True;
            RzBmpButtonPause.Visible := False;
            RzLabelPlayState.Caption := '播放停止...';
          end;
        wmppsPaused: begin //暂停状态
            PanelPalyMsg.Visible := True;
            WindowsMediaPlayer.Visible := True;

            RzBmpButtonPlay.Visible := True;
            RzBmpButtonPlay.Enabled := True;
            RzBmpButtonPause.Visible := False;
            RzLabelPlayState.Caption := '播放暂停...';
          end;
        wmppsPlaying: begin //播放状态
            PanelPalyMsg.Visible := True;
            WindowsMediaPlayer.Visible := True;

            RzBmpButtonPlay.Visible := False;
            RzBmpButtonPause.Visible := True;

            RzLabelPlayState.Caption := '正在播放...';
          end;
        wmppsBuffering: begin
          //PanelPalyMsg.Visible := True;
          //WindowsMediaPlayer.Visible := True;

            RzBmpButtonPlay.Visible := True;
            RzBmpButtonPlay.Enabled := True;
            RzBmpButtonPause.Visible := False;
            RzLabelPlayState.Caption := '正在缓冲...';
          end;
        wmppsWaiting: begin
          //PanelPalyMsg.Visible := True;
          //WindowsMediaPlayer.Visible := True;

            RzBmpButtonPlay.Visible := True;
            RzBmpButtonPlay.Enabled := True;
            RzBmpButtonPause.Visible := False;
            RzLabelPlayState.Caption := '正在等待...';
          end;
        wmppsReady: begin
            BmpProgressBar.Position := 0;
            PanelPalyMsg.Visible := False;
            WindowsMediaPlayer.Visible := False;

            RzBmpButtonPlay.Visible := True;
            RzBmpButtonPlay.Enabled := True;
            RzBmpButtonPause.Visible := False;
            RzLabelPlayState.Caption := '准备就绪...';
          end;

        wmppsScanForward: RzLabelPlayState.Caption := '向前搜索...';
        wmppsScanReverse: RzLabelPlayState.Caption := '向后搜索...';
        wmppsMediaEnded: RzLabelPlayState.Caption := '播放结束...';
        wmppsTransitioning: RzLabelPlayState.Caption := '准备新媒体...';
        wmppsReconnecting: RzLabelPlayState.Caption := '尝试重新连接...';
        wmppsLast: RzLabelPlayState.Caption := 'wmppsLast';

      else begin
          BmpProgressBar.Position := 0;
          PanelPalyMsg.Visible := False;
          WindowsMediaPlayer.Visible := False;

          RzBmpButtonPlay.Visible := True;
          RzBmpButtonPlay.Enabled := True;
          RzBmpButtonPause.Visible := False;
          RzLabelPlayState.Caption := '播放停止...';
        end;
      end;
    end;
  end;
end;

procedure TfrmCqFirMediaPlayer.RzListBoxPlayListDblClick(Sender: TObject);
begin
  if (RzListBoxPlayList.ItemIndex >= 0) then begin
    g_boHandicraft := True;
    WindowsMediaPlayer.Controls.stop;
    g_nCurrentIndex := RzListBoxPlayList.ItemIndex;
    if WindowsMediaPlayer.Visible then begin
      ActiveControl := nil;
      ActiveControl := WindowsMediaPlayer;
    end;
    Play();
  end;
end;

procedure TfrmCqFirMediaPlayer.RzBmpButtonNextClick(Sender: TObject);
begin
  g_boHandicraft := True;
  WindowsMediaPlayer.Controls.stop;
  WindowsMediaPlayer.close;
  Inc(g_nCurrentIndex);
  RzListBoxPlayList.ItemIndex := g_nCurrentIndex;
  Play();
end;

procedure TfrmCqFirMediaPlayer.RzBmpButtonPrevClick(Sender: TObject);
begin
  g_boHandicraft := True;
  WindowsMediaPlayer.Controls.stop;
  WindowsMediaPlayer.close;
  Dec(g_nCurrentIndex);
  RzListBoxPlayList.ItemIndex := g_nCurrentIndex;
  Play();
end;

procedure TfrmCqFirMediaPlayer.Menu_Mode1Click(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
end;

procedure TfrmCqFirMediaPlayer.RefListBoxPlayList();
var
  nItemIndex: Integer;
begin
  //nItemIndex := RzListBoxPlayList.ItemIndex;
  RzListBoxPlayList.Items.Clear;
  RzListBoxPlayList.Items.AddStrings(g_PlayList.m_PlayList);
  nItemIndex := g_PlayList.m_PlayList.Count - 1;
  //if (nItemIndex >= 0) and (nItemIndex < RzListBoxPlayList.Items.Count) then begin
  RzListBoxPlayList.ItemIndex := nItemIndex;
  //end else
   // if RzListBoxPlayList.Items.Count > 0 then begin
   // RzListBoxPlayList.ItemIndex := 0;
  //end;
end;

procedure TfrmCqFirMediaPlayer.Menu_AddLocalFileClick(Sender: TObject);
begin
  frmOpenDiaLogNew.Open(True);
end;

procedure TfrmCqFirMediaPlayer.RzShapeButtonMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  nX, nY: Integer;
begin
  if Shift = [ssLeft] then begin
    ReleaseCapture;
    if RzShapeButton.Cursor = crSizeNWSE then begin
      if (X > nOldX) or (Y > nOldY) then begin
        SendMessage(Handle, WM_NCLBUTTONDOWN, HTTOPLEFT, 0);
      end else begin
        SendMessage(Handle, WM_NCLBUTTONDOWN, HTBOTTOMRIGHT, 0);
      end;
    end else
      if RzShapeButton.Cursor = crSizeWE then begin
      if (X > nOldX) then begin
        SendMessage(Handle, WM_NCLBUTTONDOWN, HTLEFT, 0);
      end else begin
        SendMessage(Handle, WM_NCLBUTTONDOWN, HTRIGHT, 0);
      end;
    end else
      if RzShapeButton.Cursor = crSizeNS then begin
      if (Y > nOldY) then begin
        SendMessage(Handle, WM_NCLBUTTONDOWN, HTTOP, 0);
      end else begin
        SendMessage(Handle, WM_NCLBUTTONDOWN, HTBOTTOM, 0);
      end;
    end;

    nOldX := X;
    nOldY := Y;
  end else begin
    nX := RzShapeButton.Width - X;
    nY := RzShapeButton.Height - Y;
    if abs(nX - nY) <= 2 then begin
      RzShapeButton.Cursor := crSizeNWSE;
    end else
      if nX > nY then begin
      RzShapeButton.Cursor := crSizeWE;
    end else begin
      RzShapeButton.Cursor := crSizeNS;
    end;
  end;
end;

procedure TfrmCqFirMediaPlayer.RzShapeButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    nOldX := X;
    nOldY := Y;
  end;
end;

procedure TfrmCqFirMediaPlayer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Timer.Enabled := False;
  Minimized := True;
  g_boHandicraft := True;

  WindowsMediaPlayer.Controls.Pause;
  WindowsMediaPlayer.close;
  ActiveControl := nil;
  WindowsMediaPlayer.OnError := nil;
  WindowsMediaPlayer.OnMarkerHit := nil;
  WindowsMediaPlayer.OnMediaError := nil;
  WindowsMediaPlayer.OnWarning := nil;
  WindowsMediaPlayer.OnPlayStateChange := nil;
  WindowsMediaPlayer.OnMouseMove := nil;
  WindowsMediaPlayer.OnDoubleClick := nil;
  WindowsMediaPlayer.OnKeyDown := nil;
  Action := caHide;
end;

procedure TfrmCqFirMediaPlayer.FormDestroy(Sender: TObject);
begin
  g_SoundBarInnerLeft.Free;
  g_SoundBarInnerRight.Free;
  g_SoundBarLeft.Free;
  g_SoundBarRight.Free;

  g_ProgressBarBGLeft.Free;
  g_ProgressBarFGLeft.Free;
  g_SeekBarBuffered.Free;
  g_SeekBarInnerLeft.Free;
  g_SeekBarInnerRight.Free;
  g_SeekBarLeft.Free;
  g_SeekBarRight.Free;
  g_SeekBarRightBuffered.Free;

  //WindowsMediaPlayer.Controls.pause;
{  WindowsMediaPlayer.Visible := False;
  WindowsMediaPlayer.OnError := nil;
  WindowsMediaPlayer.OnMarkerHit := nil;
  WindowsMediaPlayer.OnMediaError := nil;
  WindowsMediaPlayer.OnWarning := nil;
  WindowsMediaPlayer.OnPlayStateChange := nil;
  WindowsMediaPlayer.OnMouseMove := nil; }
end;

procedure TfrmCqFirMediaPlayer.FormShow(Sender: TObject);
begin
  if WindowsMediaPlayer.Visible then begin
    //WindowsMediaPlayer.Parent := RzPanelPlay;
    ActiveControl := nil;
    ActiveControl := WindowsMediaPlayer;
  end;
  WindowsMediaPlayer.OnMediaError := Self.WindowsMediaPlayerMediaError;
  WindowsMediaPlayer.OnPlayStateChange := Self.WindowsMediaPlayerPlayStateChange;
  WindowsMediaPlayer.OnDoubleClick := Self.WindowsMediaPlayerDoubleClick;
  WindowsMediaPlayer.OnKeyDown := Self.WindowsMediaPlayerKeyDown;
  //WindowsMediaPlayer.OnMouseMove := Self.WindowsMediaPlayerMouseMove;
end;

function GetProcAddr(nAddr: Integer): Pointer;
begin
  Result := Pointer(nAddr + $401000);
end;

procedure TfrmCqFirMediaPlayer.RzMenuToolbarButtonPalyModeMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  //Proc: TMyProcedure;
  Method: TMethod;
  Pro: procedure;
begin
  EXIT;
  //类的过程调用
  //Pro := GetProcAddr($000CA124);
  //Pro();
 { TMethod(Proc).Code := GetProcAddr($000CA124);
  Proc(); }
end;

procedure TfrmCqFirMediaPlayer.BmpProgressBarChange(Sender: TObject);
begin
  if WindowsMediaPlayer.Visible and g_boChangeProgress then
    WindowsMediaPlayer.Controls.currentPosition := BmpProgressBar.Position;
end;

procedure TfrmCqFirMediaPlayer.BmpProgressBarSoundChange(Sender: TObject);
begin
  if WindowsMediaPlayer.Visible then
    WindowsMediaPlayer.settings.volume := Round(BmpProgressBarSound.Position);
end;

procedure TfrmCqFirMediaPlayer.BmpProgressBarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  g_boChangeProgress := True;
end;

procedure TfrmCqFirMediaPlayer.BmpProgressBarMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  g_boChangeProgress := False;
end;

procedure TfrmCqFirMediaPlayer.BmpButtonMinClick(Sender: TObject);
begin
  WindowState := wsMinimized;
end;

procedure TfrmCqFirMediaPlayer.BmpButtonMaxClick(Sender: TObject);
begin
  if WindowState = wsMaximized then begin
    WindowState := wsNormal;
    BmpButtonMax.Visible := True;
    BmpButtonRestore.Visible := False;
  end else begin
    WindowState := wsMaximized;
    BmpButtonMax.Visible := False;
    BmpButtonRestore.Visible := True;
  end;
end;

procedure TfrmCqFirMediaPlayer.BmpButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCqFirMediaPlayer.BmpButtonSizeRightClick(Sender: TObject);
begin
  RzPanelPlayList.Visible := not RzPanelPlayList.Visible;
  if RzPanelPlayList.Visible then begin
    BmpButtonSizeLeft.Visible := True;
    BmpButtonSizeRight.Visible := False;
  end else begin
    BmpButtonSizeLeft.Visible := False;
    BmpButtonSizeRight.Visible := True;
  end;
  BmpButtonOpenA.Left := (RzPanelPlay.Width - BmpButtonOpenA.Width) div 2;
  BmpButtonOpenA.Top := (RzPanelPlay.Height - BmpButtonOpenA.Height) div 2;
  if WindowsMediaPlayer.Visible then begin
    {if WindowsMediaPlayer.playState = wmppsPlaying then begin
      WindowsMediaPlayer.controls.pause;
    end;       }
    //WindowsMediaPlayer.Parent := RzPanelPlay;
    ActiveControl := nil;
    ActiveControl := WindowsMediaPlayer;
  end;
end;

procedure TfrmCqFirMediaPlayer.BmpButtonOpenClick(Sender: TObject);
begin
  frmOpenDiaLogNew.Open(True);
end;

procedure TfrmCqFirMediaPlayer.BmpButtonFullScreenClick(Sender: TObject);
var
  AMedia: IWMPMedia;
begin
  if WindowsMediaPlayer.Visible and
    (not WindowsMediaPlayer.fullScreen) and
    (WindowsMediaPlayer.currentMedia <> nil) and
    (WindowsMediaPlayer.playState in [wmppsPaused, wmppsPlaying]) { and
    g_PlugInfo.FullScreen^}then begin
    WindowsMediaPlayer.fullScreen := True;
    WindowState := wsMinimized;
  end;
end;

procedure TfrmCqFirMediaPlayer.WindowsMediaPlayerKeyDown(ASender: TObject;
  nKeyCode, nShiftState: Smallint);
begin
  if nKeyCode = VK_ESCAPE then
    if WindowsMediaPlayer.fullScreen then begin
      WindowsMediaPlayer.fullScreen := False;
      WindowState := wsNormal;
      SendMessage(Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
    end;
end;

procedure TfrmCqFirMediaPlayer.WindowsMediaPlayerDoubleClick(
  ASender: TObject; nButton, nShiftState: Smallint; fX, fY: Integer);
begin
  if WindowsMediaPlayer.Visible and
    (not WindowsMediaPlayer.fullScreen) and
    (WindowsMediaPlayer.currentMedia <> nil) and
    (WindowsMediaPlayer.playState in [wmppsPaused, wmppsPlaying]) {and
    g_PlugInfo.FullScreen^}then begin
    WindowsMediaPlayer.fullScreen := True;
    WindowState := wsMinimized;
  end else begin
    WindowsMediaPlayer.fullScreen := False;
    WindowState := wsNormal;
    SendMessage(Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
  end;
end;

procedure TfrmCqFirMediaPlayer.BmpProgressBarSoundPaintBackGround(
  Sender: TObject; Bitmap: TBitmap);
var
  PaintRect: TRect;
begin
  PaintRect := Bitmap.Canvas.ClipRect;
  Bitmap.Canvas.StretchDraw(PaintRect, g_SoundBarRight);
  Bitmap.Canvas.StretchDraw(PaintRect, g_SoundBarInnerRight);
  PaintRect.Right := PaintRect.Left + g_SoundBarLeft.Width;
  Bitmap.Canvas.StretchDraw(PaintRect, g_SoundBarInnerLeft);
end;

procedure TfrmCqFirMediaPlayer.BmpProgressBarSoundPaintProgress(
  Sender: TObject; Bitmap: TBitmap);
var
  BarLen, Percent: Integer;
  Buffer: TBitmap;
  PaintRect: TRect;
begin
  PaintRect := Bitmap.Canvas.ClipRect;

  BarLen := 0;
  Percent := 0;
  if BmpProgressBarSound.ShowBar then begin
    Buffer := BmpProgressBarSound.Bar.Bitmaps[BmpProgressBarSound.Bar.Up];
    if (Buffer <> nil) and (Buffer.Canvas.Handle <> 0) then
      BarLen := Buffer.Width;
  end;
  if BmpProgressBarSound.Orientation = pbHorizontal then begin
    PaintRect.Left := PaintRect.Left + g_SoundBarLeft.Width;
    Percent := Trunc((Bitmap.Width - BarLen) * BmpProgressBarSound.Position / BmpProgressBarSound.Max);
    PaintRect.Right := PaintRect.Left + Percent - g_SoundBarLeft.Width;
    if PaintRect.Right - PaintRect.Left > 0 then
      Bitmap.Canvas.StretchDraw(PaintRect, g_SoundBarInnerLeft);
    //g_PlugInfo.AddChatBoardString(PChar(Format('Width:%d', [PaintRect.Right-PaintRect.Left])), clWhite, clFuchsia);
  end else begin
    PaintRect.Top := PaintRect.Top + g_SoundBarLeft.Height;
    Percent := Trunc((Bitmap.Height - BarLen) * BmpProgressBarSound.Position / BmpProgressBarSound.Max);
    PaintRect.Bottom := PaintRect.Top + Percent - g_SoundBarLeft.Height;
    if PaintRect.Bottom - PaintRect.Top > 0 then
      Bitmap.Canvas.StretchDraw(PaintRect, g_SoundBarInnerLeft);
  end;
end;

procedure TfrmCqFirMediaPlayer.BmpProgressBarPaintBackGround(
  Sender: TObject; Bitmap: TBitmap);
var
  PaintRect: TRect;
begin
  PaintRect := Bitmap.Canvas.ClipRect;
  Bitmap.Canvas.StretchDraw(PaintRect, g_SeekBarRight);
  Bitmap.Canvas.StretchDraw(PaintRect, g_SeekBarInnerRight);
  PaintRect.Right := PaintRect.Left + g_SeekBarLeft.Width;
  Bitmap.Canvas.StretchDraw(PaintRect, g_SeekBarInnerLeft);
end;

procedure TfrmCqFirMediaPlayer.BmpProgressBarPaintProgress(Sender: TObject;
  Bitmap: TBitmap);
var
  BarLen, Percent: Integer;
  Buffer: TBitmap;
  PaintRect: TRect;
begin
  PaintRect := Bitmap.Canvas.ClipRect;

  BarLen := 0;
  Percent := 0;
  if BmpProgressBar.ShowBar then begin
    Buffer := BmpProgressBar.Bar.Bitmaps[BmpProgressBar.Bar.Up];
    if (Buffer <> nil) and (Buffer.Canvas.Handle <> 0) then
      BarLen := Buffer.Width;
  end;
  if BmpProgressBar.Orientation = pbHorizontal then begin
    PaintRect.Left := PaintRect.Left + g_SeekBarLeft.Width;
    Percent := Trunc((Bitmap.Width - BarLen) * BmpProgressBar.Position / BmpProgressBar.Max);
    PaintRect.Right := PaintRect.Left + Percent - g_SeekBarLeft.Width;
    if PaintRect.Right - PaintRect.Left > 0 then
      Bitmap.Canvas.StretchDraw(PaintRect, g_SeekBarInnerLeft);
    //g_PlugInfo.AddChatBoardString(PChar(Format('Width:%d', [PaintRect.Right-PaintRect.Left])), clWhite, clFuchsia);
  end else begin
    PaintRect.Top := PaintRect.Top + g_SeekBarLeft.Height;
    Percent := Trunc((Bitmap.Height - BarLen) * BmpProgressBar.Position / BmpProgressBar.Max);
    PaintRect.Bottom := PaintRect.Top + Percent - g_SeekBarLeft.Height;
    if PaintRect.Bottom - PaintRect.Top > 0 then
      Bitmap.Canvas.StretchDraw(PaintRect, g_SeekBarInnerLeft);
  end;
end;

procedure TfrmCqFirMediaPlayer.BmpButtonClearClick(Sender: TObject);
begin
  g_PlayList.Clear;
  RefListBoxPlayList();
end;

procedure TfrmCqFirMediaPlayer.BmpButtonModMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Point: TPoint;
begin
  GetCursorPos(Point);
  //Point := ScreenToClient(Point);
  PopupMenuPalyMode.Popup(Point.X, Point.Y);
end;

procedure TfrmCqFirMediaPlayer.RzListBoxPlayListDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  ListBox: TRzListBox;
  Bitmap: TBitmap;
  S: string;
begin
  ListBox := TRzListBox(Control); //RzListBoxPlayList; //TRzListBox(Control);

  S := FormatWidthString(ListBox.Canvas, ListBox.Items.Strings[Index], ListBox.Width - 32);

  if (g_nCurrentIndex = Index) and WindowsMediaPlayer.Visible and (WindowsMediaPlayer.playState in [wmppsPaused, wmppsPlaying]) then begin
    ListBox.Canvas.Font.Color := clLime;
    ListBox.Canvas.Brush.Color := clWhite;
    ListBox.Canvas.FillRect(Rect);

    if odSelected in State then begin
      Bitmap := TBitmap.Create;
      if ImageList.GetBitmap(6, Bitmap) then begin
        ListBox.Canvas.StretchDraw(Rect, Bitmap);
      end;
      Bitmap.Free;

      ImageList.Draw(ListBox.Canvas, Rect.Left, Rect.Top, 5);

    end else begin
      ImageList.Draw(ListBox.Canvas, Rect.Left, Rect.Top, 4);
    end;

    if g_nMouseMoveIndex = Index then begin
      if g_boMouseDown then begin
        ImageList.Draw(ListBox.Canvas, Rect.Right - 15, Rect.Top + 1, 0);
      end else begin
        ImageList.Draw(ListBox.Canvas, Rect.Right - 16, Rect.Top, 0);
      end;
    end;

    SetBkMode(ListBox.Canvas.Handle, TRANSPARENT);
    ListBox.Canvas.TextOut(Rect.Left + 16, Rect.Top + ((Rect.Bottom - Rect.Top) - ListBox.Canvas.TextHeight('Aa')) div 2, S);
  end else begin
    if odSelected in State then begin
      ListBox.Canvas.Font.Color := clWhite;
      ListBox.Canvas.Brush.Color := clWhite;
      ListBox.Canvas.FillRect(Rect);
      Bitmap := TBitmap.Create;
      if ImageList.GetBitmap(6, Bitmap) then begin
        ListBox.Canvas.StretchDraw(Rect, Bitmap);
      end;
      Bitmap.Free;
    end else begin
      ListBox.Canvas.Font.Color := clBlack;
      ListBox.Canvas.Brush.Color := clWhite;
      ListBox.Canvas.FillRect(Rect);
    end;

    if g_nMouseMoveIndex = Index then begin
      if g_boMouseDown then begin
        ImageList.Draw(ListBox.Canvas, Rect.Right - 15, Rect.Top + 1, 0);
      end else begin
        ImageList.Draw(ListBox.Canvas, Rect.Right - 16, Rect.Top, 0);
      end;
    end;

    SetBkMode(ListBox.Canvas.Handle, TRANSPARENT);
    ListBox.Canvas.TextOut(Rect.Left + 4, Rect.Top + ((Rect.Bottom - Rect.Top) - ListBox.Canvas.TextHeight('Aa')) div 2, IntToStr(Index + 1));
    ListBox.Canvas.TextOut(Rect.Left + 16, Rect.Top + ((Rect.Bottom - Rect.Top) - ListBox.Canvas.TextHeight('Aa')) div 2, S);
  end;

  { if odGrayed in State then
   g_PlugInfo.AddChatBoardString(PChar(Format('Index:%d State:%s', [Index,'odGrayed'])), clWhite, clFuchsia);
   if odDisabled in State then
   g_PlugInfo.AddChatBoardString(PChar(Format('Index:%d State:%s', [Index,'odDisabled'])), clWhite, clFuchsia);

   if odChecked in State then
   g_PlugInfo.AddChatBoardString(PChar(Format('Index:%d State:%s', [Index,'odChecked'])), clWhite, clFuchsia);

   if odFocused in State then
   g_PlugInfo.AddChatBoardString(PChar(Format('Index:%d State:%s', [Index,'odFocused'])), clWhite, clFuchsia);

   if odDefault in State then
   g_PlugInfo.AddChatBoardString(PChar(Format('Index:%d State:%s', [Index,'odDefault'])), clWhite, clFuchsia);

   if odHotLight in State then
   g_PlugInfo.AddChatBoardString(PChar(Format('Index:%d State:%s', [Index,'odHotLight'])), clWhite, clFuchsia);

   if odInactive in State then
   g_PlugInfo.AddChatBoardString(PChar(Format('Index:%d State:%s', [Index,'odInactive'])), clWhite, clFuchsia);

   if odNoAccel in State then
   g_PlugInfo.AddChatBoardString(PChar(Format('Index:%d State:%s', [Index,'odNoAccel'])), clWhite, clFuchsia);

   if odReserved1 in State then
   g_PlugInfo.AddChatBoardString(PChar(Format('Index:%d State:%s', [Index,'odReserved1'])), clWhite, clFuchsia);

   if odReserved2 in State then
   g_PlugInfo.AddChatBoardString(PChar(Format('Index:%d State:%s', [Index,'odReserved2'])), clWhite, clFuchsia); }
end;

procedure TfrmCqFirMediaPlayer.RzListBoxPlayListMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  g_nOldMouseMoveIndex := Y div RzListBoxPlayList.ItemHeight + RzListBoxPlayList.TopIndex;
  if g_nOldMouseMoveIndex >= RzListBoxPlayList.Count then
    g_nOldMouseMoveIndex := RzListBoxPlayList.Count - 1;
  if g_nMouseMoveIndex <> g_nOldMouseMoveIndex then begin
    g_nMouseMoveIndex := g_nOldMouseMoveIndex;
    RzListBoxPlayList.Repaint;
  end;
  //g_PlugInfo.AddChatBoardString(PChar(Format('Y:%d Index:%d', [Y, g_nMouseMoveIndex])), clWhite, clFuchsia);
end;

procedure TfrmCqFirMediaPlayer.RzListBoxPlayListMouseLeave(
  Sender: TObject);
begin
  g_nMouseMoveIndex := -1;
  g_nOldMouseMoveIndex := -1;
  //g_boMouseDown := False;
  RzListBoxPlayList.Repaint;
end;

procedure TfrmCqFirMediaPlayer.RzListBoxPlayListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
begin
  //Showmessage('X:' + IntToStr(X) + '  Y:' + IntToStr(Y) + '  Width:' + IntToStr(RzListBoxPlayList.Width) + '  g_nMouseMoveIndex:' + IntToStr(g_nMouseMoveIndex));
  if (g_nMouseMoveIndex >= 0) then begin
    R := RzListBoxPlayList.ItemRect(g_nMouseMoveIndex);
    if X >= R.Right - r.Left - 16 then begin
      g_boMouseDown := True;
      //Showmessage(IntToStr(g_nMouseMoveIndex));
    end;
    //RzListBoxPlayList.Repaint;
  end;
  //Showmessage(IntToStr(g_nMouseMoveIndex));
end;

procedure TfrmCqFirMediaPlayer.RzListBoxPlayListMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //g_boMouseDown := False;
  //RzListBoxPlayList.Repaint;
end;

procedure TfrmCqFirMediaPlayer.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  g_PlugInfo.KeyDown(Key, Shift);
end;

procedure TfrmCqFirMediaPlayer.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  g_PlugInfo.KeyPress(Key);
end;

end.

