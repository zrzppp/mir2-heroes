unit U_WMP;

{这个单元有一个类: TWMP
   该类封装了 Windows Media Player 控件的一些基本功能.
   使用这个单元来开发 Windows Media Player 控件将倍感
   更加轻松.
   详细注释请看  public 内容.

   注意:   public 提供了控件的接口 WMP,如果你不是高手:),
           请不要使用这个接口.
 
            关于 OnMediaEnded 事件的缺陷, OnMediaEnded 事件指
            一个剪辑被播放完毕,但是你不能在该事件中增加控件
            的动作代码,比如 Play 等,或者指定一个新的剪辑,都是不
            行的.
            也许你可以使用一个 Timer,当这个事件被触发之后启动 Timer,
            然后在 Timer 一秒钟之后触发的事件中写你的动作代码.
}


interface

uses
  Windows, Messages, SysUtils,
  Variants, Classes, Graphics, Menus,
  Controls, StdCtrls, Forms, ExtCtrls,
  OleCtrls, WMPLib_TLB;
type
  TWMPVolume = 0..100;
  TWMPBalance = -100..100;

  TWMStatusChangeEvent = procedure(const State: WideString) of object;

  TWMP = class(TObject)
  private
    FDisplayControl: TWincontrol;
    FTimer: TTimer;
    FWMP: TWindowsMediaPlayer;
    FOnTimeChange: TNotifyEvent;
    FOnMediaChange: TNotifyEvent;
    FOnMediaEnded: TNotifyEvent;
    FOnStatusChange: TWMStatusChangeEvent;
    function GetBufferTime: Longword;
    procedure SetBufferTime(const Value: Longword);
    procedure SetSource(const Value: Widestring);
    function GetSource: Widestring;
    function GetVolume: TWMPVolume;
    procedure SetVolume(const Value: TWMPVolume);
    function GetBalance: TWMPBalance;
    procedure SetBalance(const Value: TWMPBalance);
    function GetAutoStart: boolean;
    procedure SetAutoStart(const Value: boolean);
    function GetCurrentTimeStr: string;
    procedure OnTimer(Sender: TObject);
    function GetMute: boolean;
    procedure SetMute(const Value: boolean);
    function GetIsOnLine: Boolean;
    function GetCurrentMediaDuration: Double;
    function GetCurrentMediaDurationString: string;
    function GetCurrentPosition: Double;
    procedure setCurrentPosition(const Value: Double);
    procedure OnOpenStateChange(ASender: TObject; NewState: Integer);
    function GetStretchToFit: Boolean;
    procedure SetStretchToFit(const Value: Boolean);
    function GetFullScreen: boolean;
    procedure SetFullScreen(const Value: boolean);
    procedure StatusChange(Sender: TObject);
    procedure PlayStatusChange(ASender: TObject; NewState: Integer);
    procedure MediaChange(ASender: TObject; const Item: IDispatch);
    procedure setDisplayControl(const Value: TWinControl);
    function GetEnableContextMenu: boolean;
    procedure SetEnableContextMenu(const Value: boolean);
    function GetPopupMenu: TPopupMenu;
    procedure SetPopupMenu(const Value: TPopupMenu);
  protected
    procedure StartTime;
    procedure CloseTime;

  public
    //即时状态信息
    property OnStatusChange: TWMStatusChangeEvent read FOnStatusChange write FOnStatusChange;
    // PopupMenu
    property DisplayControlPopupMenu: TPopupMenu read GetPopupMenu write SetPopupMenu;
    //是否显示控件菜单,缺省 false:
    property EnableContextMenu: boolean read GetEnableContextMenu write SetEnableContextMenu;
    //指定显示窗口
    property DisplayControl: TWinControl read FDisplayControl write setDisplayControl;
    //剪辑播放完毕
    property OnMediaEnded: TNotifyEvent read FOnMediaEnded write FOnMediaEnded;
    //全屏幕
    property FullScreen: boolean read GetFullScreen write SetFullScreen;
    //显示到窗口大小
    property StretchToFit: Boolean read GetStretchToFit write SetStretchToFit;
    //播放新剪辑的时候触发
    property OnMediaChange: TNotifyEvent read FOnMediaChange write FOnMediaChange;
    //当前剪辑的全部时间长度的文本
    property CurrentMediaDurationString: string read GetCurrentMediaDurationString;
    //当前剪辑的全部时间长度,单位是秒
    property CurrentMediaDuration: Double read GetCurrentMediaDuration;
    //是否联网了
    property IsOnLine: Boolean read GetIsOnLine;
    //静音
    property Mute: boolean read GetMute write SetMute;
    property OnPlayTimeChange: TNotifyEvent read FOnTimeChange write FOnTimeChange;
    //当前播放位置,单位是秒
    property CurrentPosition: Double read GetCurrentPosition write setCurrentPosition;
    //当前播放时间文本
    property CurrentTimeStr: string read GetCurrentTimeStr;
    //自动开始播放
    property AutoStart: boolean read GetAutoStart write SetAutoStart;
    //左右声道控制,调整方法看 TWMPBalance
    property Balance: TWMPBalance read GetBalance write SetBalance default 0;
    //控件接口,没什么事情不要使用这个
    property WMP: TWindowsMediaPlayer read FWMP write FWMP;
    //音量控制,看 TWMPVolume
    property Volume: TWMPVolume read GetVolume write SetVolume default 50;
    //剪辑资源,可以是 RUL 也可以是 FileName
    property Source: Widestring read GetSource write SetSource;
    //缓冲量设置,单位是秒
    property BufferTime: Longword read GetBufferTime write SetBufferTime default 2000;
    constructor Create(var OK: boolean);
    destructor Destroy; override;

    procedure OpenPlay(const FileName: WideString);
    procedure Close;
    procedure Play;
    procedure Pause;
    procedure Stop;
    procedure FastForward;
    procedure FastReverse;

  end;
implementation

{ TWMP }

procedure TWMP.Close;
begin
  FWMP.close;
end;

procedure TWMP.CloseTime;
begin
  FTimer.Enabled := false;
end;

constructor TWMP.Create(var OK: boolean);
begin
  try
    FWMP := TWindowsMediaPlayer.Create(application);
    ok := true;
  except
    Ok := false;
    FWMP := nil;
  end;
  if ok then
  begin
    FWMP.network.bufferingTime := 2000;
    FWMP.uiMode := 'None';
    FWMP.Align := alClient;
    FWMP.OnOpenStateChange := OnOpenStateChange;
    FWMP.OnMediaChange := MediaChange;
    FWMP.OnPlayStateChange := PlayStatusChange;
    FWMP.OnStatusChange := StatusChange;
    FWMP.enableContextMenu := false;
    FTimer := TTimer.Create(FWMP);
    FTimer.Enabled := false;
    FTimer.Interval := 100;
    FTimer.OnTimer := OnTimer;
  end;
end;

destructor TWMP.Destroy;
begin
  FOnMediaChange := nil;
  FOnTimeChange := nil;
  FOnStatusChange := nil;
  FreeAndNil(FTimer);
  if FWMP <> nil then
  begin
    FWMP.OnOpenStateChange := nil;
    FWMP.OnMediaChange := nil;
    FWMP.OnStatusChange := nil;
    FWMP.OnPlayStateChange := nil;
    if FWMP.playState = 3 then // 正在播放中
      FWMP.controls.pause;
    FreeAndNil(FWMP);
  end;
  inherited;
end;

procedure TWMP.OnOpenStateChange(ASender: TObject; NewState: Integer);
begin

end;

procedure TWMP.FastForward;
begin
  FWMP.controls.fastForward;
end;

procedure TWMP.FastReverse;
begin
  FWMP.controls.fastReverse;
end;

function TWMP.GetAutoStart: boolean;
begin
  result := FWMP.settings.autoStart;
end;

function TWMP.GetBalance: TWMPBalance;
begin
  result := FWMP.settings.balance;
end;

function TWMP.GetBufferTime: Longword;
begin
  result := FWMP.network.bufferingTime;
end;

function TWMP.GetCurrentMediaDuration: Double;
begin
  Result := FWMP.currentMedia.duration;
end;

function TWMP.GetCurrentMediaDurationString: string;
begin
  result := FWMP.currentMedia.durationString;
end;

function TWMP.GetCurrentPosition: Double;
begin
  result := FWMP.controls.currentPosition;
end;

function TWMP.GetCurrentTimeStr: string;
begin
  result := FWMP.controls.currentPositionString;
end;

function TWMP.GetIsOnLine: Boolean;
begin
  result := FWMP.isOnline;
end;

function TWMP.GetMute: boolean;
begin
  result := FWMP.settings.mute;
end;

function TWMP.GetSource: Widestring;
begin
  result := FWMP.URL;
end;

function TWMP.GetVolume: TWMPVolume;
begin
  result := FWMP.settings.volume;
end;

procedure TWMP.OnTimer(Sender: TObject);
begin
  if Assigned(FOnTimeChange) then FOnTimeChange(Self);
end;

procedure TWMP.OpenPlay(const FileName: WideString);
begin
  FWMP.openPlayer(FileName);
end;

procedure TWMP.Pause;
begin
  FWMP.controls.pause;
end;

procedure TWMP.Play;
begin
  FWMP.controls.play;
end;

procedure TWMP.SetAutoStart(const Value: boolean);
begin
  FWMP.settings.autoStart := Value;
end;

procedure TWMP.SetBalance(const Value: TWMPBalance);
begin
  FWMP.settings.balance := Value;
end;

procedure TWMP.SetBufferTime(const Value: Longword);
begin
  FWMP.network.bufferingTime := Value;
end;

procedure TWMP.setCurrentPosition(const Value: Double);
begin
  FWMP.controls.currentPosition := Value;
end;

procedure TWMP.SetMute(const Value: boolean);
begin
  FWMP.settings.mute := Value;
end;

procedure TWMP.SetSource(const Value: Widestring);
begin
  if FWMP.playState = 3 then // 正在播放中
    FWMP.controls.pause; // Pause 能优化速度
  FWMP.URL := Value;
end;

procedure TWMP.SetVolume(const Value: TWMPVolume);
begin
  FWMP.settings.volume := Value;
end;

procedure TWMP.StartTime;
begin
  FTimer.Enabled := true;
end;

procedure TWMP.Stop;
begin
  FWMP.controls.stop;
end;

function TWMP.GetStretchToFit: Boolean;
begin
  result := FWMP.stretchToFit;
end;

procedure TWMP.SetStretchToFit(const Value: Boolean);
begin
  FWMP.stretchToFit := value;
end;

function TWMP.GetFullScreen: boolean;
begin
  result := FWMP.fullScreen;
end;

procedure TWMP.SetFullScreen(const Value: boolean);
begin
  FWMP.fullScreen := Value;
end;

procedure TWMP.StatusChange(Sender: TObject);
begin
  if Assigned(FOnStatusChange) then
    FOnStatusChange(FWMP.status);
end;

procedure TWMP.PlayStatusChange(ASender: TObject; NewState: Integer);
begin
  if NewState = 3 then //Playing
    StartTime
  else CloseTime;

  if NewState = 8 then // MadiaEnded
  begin
    if Assigned(FOnMediaEnded) then FOnMediaEnded(self);
  end;

end;

procedure TWMP.MediaChange(ASender: TObject; const Item: IDispatch);
begin
  if Assigned(FOnMediaChange) then FOnMediaChange(Self);
end;

procedure TWMP.setDisplayControl(const Value: TWinControl);
begin
  if Value <> FDisplayControl then
  begin
    try
      if Value.Handle = 0 then ;
    except raise Exception.Create('指定显示播放内容的窗口不可用.'); end;
    FDisplayControl := Value;
    FWMP.Parent := Value;
    FWMP.Realign;
  end;
end;

function TWMP.GetEnableContextMenu: boolean;
begin
  result := FWMP.enableContextMenu;
end;

procedure TWMP.SetEnableContextMenu(const Value: boolean);
begin
  FWMP.enableContextMenu := value;
end;

function TWMP.GetPopupMenu: TPopupMenu;
begin
  result := FWMP.PopupMenu;
end;

procedure TWMP.SetPopupMenu(const Value: TPopupMenu);
begin
  FWMP.PopupMenu := Value;
end;

end.

