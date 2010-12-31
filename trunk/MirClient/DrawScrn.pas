unit DrawScrn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Share,
  Textures, IntroScn, DWinCtl, MPlayer, GameImages;

const
  MAXSYSLINE = 8;
  BOTTOMBOARD = 1;
  VIEWCHATLINE = 9;
  AREASTATEICONBASE = 150;
  HEALTHBAR_BLACK = 0;
  HEALTHBAR_RED = 1;

type
  TDelayMsg = record
    RecogId: Integer;
    Msg: string;
    Time: Integer;
    Color: TColor;
  end;
  pTDelayMsg = ^TDelayMsg;

  THintInfo = record
    Hint: string;
    Color: TColor;
    Image: TGameImages;
    FaceIndex: Integer;
    Index: Integer;
    Time: Integer;
    Tick: LongWord;
  end;
  pTHintInfo = ^THintInfo;

  THintStyle = (s_Windows, s_Legend, s_Item);

  TDrawScreenHintLines = class;
  TDrawScreenHintList = class;
  TDrawScreenHintManage = class;

  TDrawScreenHint = class
  private
    FOwner: TDrawScreenHintLines;
    FHint: string;
    FColor: TColor;
    FImage: TGameImages;
    FFaceIndex: Integer;
    FImageCount: Integer;
    FDrawIndex: Integer;
    FDrawTime: Integer;
    FDrawTick: LongWord;
    FClientRect: TRect;
    FDrawImageCount: Integer;
    function GetPosition(const Index: Integer): Integer;
    procedure SetPosition(const Index, Value: Integer);
  public
    constructor Create(AOwner: TDrawScreenHintLines);
    destructor Destroy; override;
    function Add(X, Y: Integer; AHint: string = '';
      AColor: TColor = clWhite;
      AImage: TGameImages = nil;
      AFaceIndex: Integer = -1;
      AImageCount: Integer = 0;
      ATime: Integer = 0): TRect;
    procedure Draw(Surface: TTexture);
    property Owner: TDrawScreenHintLines read FOwner write FOwner;
    property Hint: string read FHint write FHint;
    property Color: TColor read FColor write FColor;
    property Image: TGameImages read FImage write FImage;
    property FaceIndex: Integer read FFaceIndex write FFaceIndex;
    property ImageCount: Integer read FImageCount write FImageCount;
    property DrawIndex: Integer read FDrawIndex write FDrawIndex;
    property DrawTime: Integer read FDrawTime write FDrawTime;
    property DrawTick: LongWord read FDrawTick write FDrawTick;

    property Left: Integer index 0 read FClientRect.Left write SetPosition;
    property Top: Integer index 1 read FClientRect.Top write SetPosition;
    property Width: Integer index 2 read GetPosition write SetPosition;
    property Height: Integer index 3 read GetPosition write SetPosition;

  end;

  TDrawScreenHintLines = class
  private
    FOwner: TDrawScreenHintList;
    FList: TList;
    function GetLeft: Integer;
    function GetTop: Integer;
    function GetWidth: Integer;
    function GetHeight: Integer;
    function GetCount: Integer;
    function Get(Index: Integer): TDrawScreenHint;
  public
    constructor Create(AOwner: TDrawScreenHintList);
    destructor Destroy; override;

    function Add: TDrawScreenHint;
    procedure Draw(Surface: TTexture);
    property Owner: TDrawScreenHintList read FOwner write FOwner;
    property Left: Integer read GetLeft;
    property Top: Integer read GetTop;
    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TDrawScreenHint read Get;
  end;

  TDrawScreenHintList = class
  private
    FOwner: TDrawScreenHintManage;
    FList: TList;
    FHintStyle: THintStyle;
    function GetLeft: Integer;
    function GetTop: Integer;
    function GetWidth: Integer;
    function GetHeight: Integer;
    function GetCount: Integer;
    function Get(Index: Integer): TDrawScreenHintLines;
  public
    constructor Create(AOwner: TDrawScreenHintManage);
    destructor Destroy; override;
    procedure Draw(Surface: TTexture);
    procedure Add(Lines: TDrawScreenHintLines);
    property Style: THintStyle read FHintStyle write FHintStyle;
    property Owner: TDrawScreenHintManage read FOwner write FOwner;
    property Left: Integer read GetLeft;
    property Top: Integer read GetTop;
    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TDrawScreenHintLines read Get;
  end;

  TDrawScreenHintManage = class
  private
    FList: TList;
    function Get(Index: Integer): TDrawScreenHintList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(List: TDrawScreenHintList);
    procedure Draw(Surface: TTexture);
    procedure Clear;
    property Items[Index: Integer]: TDrawScreenHintList read Get;
  end;


  TDrawScreenCenterMsg = class
    //m_nCurrCenterMsg: pTMoveMsg;

    m_TextList: TStringList;
    m_FColor: Byte;
    m_BColor: Byte;
  private
    m_dwShowTime: LongWord;
    m_dwShowTick: LongWord;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(sMsg: string; FColor, BColor: Byte; nTime: Integer);
    procedure Draw(MSurface: TTexture);
    procedure Clear;
  end;

  TDrawDelayMsg = class
  private
    m_dwDrawFrameCount: longword;
    m_MsgList: TGList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(RecogId: Integer; sMsg: string; nTime: Integer; cColor: TColor);
    procedure Draw(Surface: TTexture);
    procedure Clear;
    procedure Delete(RecogId: Integer);
  end;

  TDrawScreenMoveMsg = class
    m_MsgList: TList;
    m_nCurrMoveMsg: pTMoveMsg;
    m_dwMoveTick: LongWord;
  private
    FLen, FLeft, FX, FY, FOffSetX: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(sMsg: string; FColor, BColor: Byte; nX, nY, nCount: Integer);
    procedure Draw(MSurface: TTexture);
    property Y: Integer read FY;
  end;

  TDrawScreenXY = class
    m_SysMsgList: TList;
  private
    procedure DeleteSysMsg(nMaxCount: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddSysMsg(Msg: string; nX, nY: Integer; Color: TColor);
    procedure Draw(MSurface: TTexture);
  end;

  TDrawScreenXYManage = class
    m_DrawScreenXYManageList: TList;
  private
    function GetDrawScreenXY(nX, nY: Integer): TDrawScreenXY;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddSysMsg(Msg: string; nX, nY: Integer; Color: TColor);
    procedure Draw(MSurface: TTexture);
  end;

  TDrawScreen = class

  private
    m_dwFrameTime: LongWord;
    m_dwFrameCount: LongWord;
    m_dwDrawFrameCount: LongWord;
    m_DrawScreenXYManage: TDrawScreenXYManage;
    m_MoveMsgList: TList;
    //m_DrawScreenMoveMsg: TDrawScreenMoveMsg;
  public
    CurrentScene: TScene;
    ChatStrs: TStringList;
    ChatBks: TList;
    ChatBoardTop: Integer;

    HintList: TStringList;
    HintX, HintY, HintWidth, HintHeight: Integer;
    HintUp: Boolean;
    HintColor: TColor;
    HintMode: Boolean;
    DrawHintMode: Boolean;
    DrawDelayMsg: TDrawDelayMsg;
    DrawScreenCenterMsg: TDrawScreenCenterMsg;

    DrawScreenHintManage: TDrawScreenHintManage;
    constructor Create;
    destructor Destroy; override;
    procedure KeyPress(var Key: Char);
    procedure KeyDown(var Key: Word; Shift: TShiftState);
    procedure MouseMove(Shift: TShiftState; X, Y: Integer);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Initialize;
    procedure Finalize;
    procedure ChangeScene(scenetype: TSceneType);
    procedure DrawScreen(MSurface: TTexture);
    procedure DrawScreenTop(MSurface: TTexture);
    procedure AddSysMsg(Msg: string; nX, nY: Integer; Color: TColor);
    procedure AddMoveMsg(sMsg: string; FColor, BColor: Byte; nX, nY, nCount: Integer);
    function AddChatBoardString(Str: string; FColor, BColor: Integer): string;
    procedure ClearChatBoard;
    procedure ShowHint(X, Y: Integer; HintStringList1, HintStringList2: TStringList; drawup: Boolean); overload;
    procedure ShowHint(X, Y: Integer; HintStringList: TStringList; drawup: Boolean); overload;
    procedure ShowHint(X, Y: Integer; Str: string; Color: TColor; drawup: Boolean); overload;
    procedure ShowHintA(X, Y: Integer; Str: string; Color: TColor; drawup: Boolean); overload;
    procedure ShowHintA(X, Y: Integer; HintStringList: TStringList; drawup: Boolean); overload;
    procedure ClearHint;
    procedure DrawHint(MSurface: TTexture);
    procedure Draw(MSurface: TTexture);
    procedure DrawMsg(MSurface: TTexture);

    procedure DrawQuad(MSurface: TTexture; ARect: TRect; Color: Integer);
  end;


implementation

uses
  ClMain, MShare, Actor, FState, ClFunc, HUtil32, Grobal2, PlugIn;
{-------------------------------------------------------------------------------}


constructor TDrawScreenHintLines.Create(AOwner: TDrawScreenHintList);
begin
  FOwner := AOwner;
  FOwner.Add(Self);
  FList := TList.Create;
end;

destructor TDrawScreenHintLines.Destroy;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do begin
    TDrawScreenHint(FList.Items[I]).Free;
  end;
  FList.Free;
  inherited;
end;

function TDrawScreenHintLines.Add: TDrawScreenHint;
var
  Hint: TDrawScreenHint;
begin
  Hint := TDrawScreenHint.Create(Self);
  FList.Add(Hint);
  Result := Hint;
end;

function TDrawScreenHintLines.GetLeft: Integer;
begin
  if Count > 0 then Result := Items[0].Left
  else Result := 0;
end;

function TDrawScreenHintLines.GetTop: Integer;
begin
  if Count > 0 then Result := Items[0].Top
  else Result := 0;
end;

function TDrawScreenHintLines.GetWidth: Integer;
var
  I: Integer;
begin
  //nW := 0;
  Result := 0;
  for I := 0 to Count - 1 do begin
    //if nW < Items[I].Width then
    Result := Result + Items[I].Width;
  end;
  //Result := nW;
end;

function TDrawScreenHintLines.GetHeight: Integer;
var
  I, nH: Integer;
begin
  nH := 0;
  for I := 0 to Count - 1 do begin
    if nH < Items[I].Height then
      nH := Items[I].Height;
  end;
  Result := nH;
end;

procedure TDrawScreenHintLines.Draw(Surface: TTexture);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do begin
    Items[I].Draw(Surface);
  end;
end;

function TDrawScreenHintLines.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TDrawScreenHintLines.Get(Index: Integer): TDrawScreenHint;
begin
  Result := FList.Items[Index];
end;
{-------------------------------------------------------------------------------}

constructor TDrawScreenHintList.Create(AOwner: TDrawScreenHintManage);
begin
  FOwner := AOwner;
  FOwner.Add(Self);
  FList := TList.Create;
end;

destructor TDrawScreenHintList.Destroy;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do begin
    TDrawScreenHintLines(FList.Items[I]).Free;
  end;
  FList.Free;
  inherited;
end;

procedure TDrawScreenHintList.Add(Lines: TDrawScreenHintLines);
begin
  FList.Add(Lines);
end;

function TDrawScreenHintList.GetLeft: Integer;
begin
  if Style = s_Item then begin
    if Count > 0 then Result := Items[0].Left - 8
    else Result := 0;
  end else begin
    if Count > 0 then Result := Items[0].Left - 6
    else Result := 0;
  end;
end;

function TDrawScreenHintList.GetTop: Integer;
begin
  if Style = s_Item then begin
    if Count > 0 then Result := Items[0].Top - 8
    else Result := 0;
  end else begin
    if Count > 0 then Result := Items[0].Top - 4
    else Result := 0;
  end;
end;

function TDrawScreenHintList.GetWidth: Integer;
var
  I, nW: Integer;
begin
  nW := 0;
  for I := 0 to Count - 1 do begin
    if nW < Items[I].Width then
      nW := Items[I].Width;
  end;
  if Style = s_Item then
    Result := nW + 16
  else
    Result := nW + 12;
end;

function TDrawScreenHintList.GetHeight: Integer;
begin
  if Count > 0 then
    if Style = s_Item then
      Result := Items[Count - 1].Top - Items[0].Top + Items[Count - 1].Height + 16
    else
      Result := Items[Count - 1].Top - Items[0].Top + Items[Count - 1].Height + 8
  else Result := 0;
end;

procedure TDrawScreenHintList.Draw(Surface: TTexture);
var
  I: Integer;
  rc: TRect;
  nAlpha: Integer;
  d: TTexture;
  HintBack: TTexture;
  nW, nH: Integer;
begin
  case Style of
    s_Item: begin
        d := g_WCqFirImages.Images[44];
        if (d = nil) or (d.Width * d.Height < 10) then begin
          rc := Bounds(Left, Top, Width, Height);
          Surface.FillRectAlpha(rc, GetRGB(g_btBColor), g_btAlpha);
          Surface.FrameRect(rc, GetRGB(g_btFColor));
        end else begin
          HintBack := TTexture.Create;
          HintBack.SetSize(Width, Height);
          HintBack.Fill(0);
          d := g_WCqFirImages.Images[44];
          if d <> nil then
            HintBack.Draw(0, 0, d, False);

          d := g_WCqFirImages.Images[46];
          if d <> nil then
            HintBack.Draw(HintBack.Width - d.Width, 0, d, False);

          d := g_WCqFirImages.Images[49];
          if d <> nil then
            HintBack.Draw(0, HintBack.Height - d.Height, d, False);

          d := g_WCqFirImages.Images[51];
          if d <> nil then
            HintBack.Draw(HintBack.Width - d.Width, HintBack.Height - d.Height, d, False);

          nW := Width - 80;
          nH := Height - 80;

          if nW > 0 then begin
            d := g_WCqFirImages.Images[45];
            if d <> nil then
              HintBack.StretchDraw(Bounds(40, 0, nW, d.Height), d, False);

            d := g_WCqFirImages.Images[50];
            if d <> nil then
              HintBack.StretchDraw(Bounds(40, HintBack.Height - d.Height, nW, d.Height), d, False);
          end;

          if nH > 0 then begin
            d := g_WCqFirImages.Images[47];
            if d <> nil then
              HintBack.StretchDraw(Bounds(0, 40, d.Width, nH), d, False);

            d := g_WCqFirImages.Images[48];
            if d <> nil then
              HintBack.StretchDraw(Bounds(HintBack.Width - d.Width, 40, d.Width, nH), d, False);
          end;
          rc := Bounds(Left + 4, Top + 4, Width - 4, Height - 4);
          Surface.FillRectAlpha(rc, GetRGB(g_btBColor), g_btAlpha);

          Surface.Draw(Left, Top, HintBack);
          HintBack.Free;
        end;
      end;
    s_Windows: begin
        rc := Bounds(Left, Top, Width, Height);
        Surface.FillRect(rc, $00E1FFFE); //$00E1FFFE

        nAlpha := 180;
        for I := 1 to 4 do begin
          Dec(nAlpha, 20);
          Surface.FillRectAlpha(Rect(rc.Right, rc.Top + 4, rc.Right + I, rc.Bottom), clblack, nAlpha);
        end;

        nAlpha := 180;
        for I := 1 to 4 do begin
          Dec(nAlpha, 20);
          Surface.FillRectAlpha(Rect(rc.Left + 4, rc.Bottom, rc.Right + 4, rc.Bottom + I), clblack, nAlpha);
        end;
      end;
    s_Legend: begin
        rc := Bounds(Left, Top, Width, Height);
        Surface.FillRectAlpha(rc, $00005E5E, 150);
      end;
  end;
  for I := 0 to Count - 1 do begin
    Items[I].Draw(Surface);
  end;
end;

function TDrawScreenHintList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TDrawScreenHintList.Get(Index: Integer): TDrawScreenHintLines;
begin
  Result := FList.Items[Index];
end;

{-------------------------------------------------------------------------------}

constructor TDrawScreenHintManage.Create;
begin
  FList := TList.Create;
end;

destructor TDrawScreenHintManage.Destroy;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do begin
    TDrawScreenHintList(FList.Items[I]).Free;
  end;
  FList.Free;
  inherited;
end;

function TDrawScreenHintManage.Get(Index: Integer): TDrawScreenHintList;
begin
  Result := FList.Items[Index];
end;

procedure TDrawScreenHintManage.Draw(Surface: TTexture);
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do begin
    TDrawScreenHintList(FList.Items[I]).Draw(Surface);
  end;
end;

procedure TDrawScreenHintManage.Add(List: TDrawScreenHintList);
begin
  FList.Add(List);
end;

procedure TDrawScreenHintManage.Clear;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do begin
    TDrawScreenHintList(FList.Items[I]).Free;
  end;
  FList.Clear;
end;
{-------------------------------------------------------------------------------}

constructor TDrawScreenHint.Create(AOwner: TDrawScreenHintLines);
begin
  FOwner := AOwner;
  FClientRect := Bounds(0, 0, 0, 0);
end;

destructor TDrawScreenHint.Destroy;
begin
  inherited;
end;

function TDrawScreenHint.GetPosition(const Index: Integer): Integer;
begin
  case Index of
    2: Result := FClientRect.Right - FClientRect.Left;
    3: Result := FClientRect.Bottom - FClientRect.Top;
  else Result := 0;
  end;
end;

procedure TDrawScreenHint.SetPosition(const Index, Value: Integer);
var
  Aux: Integer;
  NewRect: TRect;
begin
  NewRect := FClientRect;
  case Index of
    0: begin
        Aux := NewRect.Right - NewRect.Left;
        NewRect.Left := Value;
        NewRect.Right := Value + Aux;
      end;
    1: begin
        Aux := NewRect.Bottom - NewRect.Top;
        NewRect.Top := Value;
        NewRect.Bottom := Value + Aux;
      end;
    2: NewRect.Right := NewRect.Left + Value;
    3: NewRect.Bottom := NewRect.Top + Value;
  end;
  FClientRect := NewRect;
end;

function TDrawScreenHint.Add(X, Y: Integer; AHint: string = '';
  AColor: TColor = clWhite;
  AImage: TGameImages = nil;
  AFaceIndex: Integer = -1;
  AImageCount: Integer = 0;
  ATime: Integer = 0): TRect;
var
  d: TTexture;
begin
  FHint := AHint;
  FColor := AColor;
  FImage := AImage;
  FFaceIndex := AFaceIndex;
  FImageCount := AImageCount;
  FDrawTime := ATime;
  FDrawIndex := g_nDrawIndex;
  FDrawTick := GetTickCount;
  FDrawImageCount := 0;

  if FImage <> nil then Inc(g_nDrawIndex);

  Left := X;
  Top := Y;

  if Hint <> '' then begin
    Width := Width + frmMain.Canvas.TextWidth(Hint);
    Height := _MAX(Height, frmMain.Canvas.TextHeight(Hint) + 1);
  end;
  if (FFaceIndex >= 0) and (FImage <> nil) then begin
    d := FImage.Images[FFaceIndex];
    if d <> nil then begin
      Width := Width + d.Width + 2;
      Height := _MAX(Height, d.Height);
    end;
  end;

  //if Width > 0 then
    //Width := Width + 4 * 2;
  Result := Bounds(Left, Top, Width, Height);
end;

procedure TDrawScreenHint.Draw(Surface: TTexture);
var
  nIndex: Integer;
  d: TTexture;
begin
  if (Owner <> nil) and (Owner.Owner <> nil) then begin
    if Hint <> '' then
      if Owner.Owner.Style = s_Windows then
        Surface.TextOut(Left, Top, Hint, Color)
      else
        Surface.BoldTextOut(Left, Top, Hint, Color);

    if (FFaceIndex >= 0) and (FImage <> nil) then begin
      //DScreen.AddChatBoardString('GetTickCount - FDrawTick:'+IntToStr(GetTickCount - FDrawTick), clyellow, clRed);
      if GetTickCount - g_DrawStarsTick[FDrawIndex].dwDrawTick > FDrawTime then begin
        g_DrawStarsTick[FDrawIndex].dwDrawTick := GetTickCount;
        if g_DrawStarsTick[FDrawIndex].nCount > FImageCount - 1 then g_DrawStarsTick[FDrawIndex].nCount := 0;
        nIndex := FFaceIndex + g_DrawStarsTick[FDrawIndex].nCount;
        Inc(g_DrawStarsTick[FDrawIndex].nCount);
        if g_DrawStarsTick[FDrawIndex].nCount > FImageCount - 1 then g_DrawStarsTick[FDrawIndex].nCount := 0;
        //DScreen.AddChatBoardString('FDrawImageCount:'+IntToStr(FDrawImageCount)+' FImageCount:'+IntToStr(FImageCount), clyellow, clRed);
      end else begin
        nIndex := FFaceIndex + g_DrawStarsTick[FDrawIndex].nCount;
      end;

      //DScreen.AddChatBoardString('FDrawImageCount:'+IntToStr(FDrawImageCount)+' FImageCount:'+IntToStr(FImageCount)+' FDrawTime:'+IntToStr(FDrawTime), clyellow, clRed);
      d := FImage.Images[nIndex];
      if d <> nil then
        Surface.Draw(Left, Top, d.ClientRect, d);
    end;
  end;
end;

{-------------------------------------------------------------------------------}

constructor TDrawScreenCenterMsg.Create;
begin
 // New(m_nCurrCenterMsg);
  //m_nCurrCenterMsg.sMsg := '';
  m_TextList := TStringList.Create;
  m_FColor := 255;
  m_BColor := 0;
end;

destructor TDrawScreenCenterMsg.Destroy;
begin
  //Dispose(m_nCurrCenterMsg);
  m_TextList.Free;
  inherited;
end;

procedure TDrawScreenCenterMsg.Clear;
begin
  m_TextList.Clear;
end;

procedure TDrawScreenCenterMsg.Add(sMsg: string; FColor, BColor: Byte; nTime: Integer);
var
  wText: WideString;
  sText: string;
  FontName: string;
  FontSize: Integer;
  I, nTextWidth: Integer;
  FontCharset: TFontCharset;
begin
  m_dwShowTime := GetTickCount + nTime * 1000;
  m_FColor := FColor;
  m_BColor := BColor;
  m_TextList.Clear;
  with ImageCanvas do begin
    FontName := MainForm.Canvas.Font.Name;
    FontSize := MainForm.Canvas.Font.Size;
    FontCharset := MainForm.Canvas.Font.Charset;
    MainForm.Canvas.Font.Charset := GB2312_CHARSET;
    MainForm.Canvas.Font.Name := g_sFontName;
    MainForm.Canvas.Font.Size := 30;
    MainForm.Canvas.Font.Style := [fsBold];
    nTextWidth := TextWidth(sMsg);

    wText := sMsg;
    if nTextWidth > SCREENWIDTH then begin
      sText := '';
      I := 1;
      while True do begin
      //for I := 1 to Length(wText) do begin
        if TextWidth(sText + wText[I]) <= SCREENWIDTH then begin
          sText := sText + wText[I];
        end else begin
          m_TextList.Add(sText);
          sText := '';
          Continue;
        end;
        Inc(I);
        if I > Length(wText) then break;
      end;
      if sText <> '' then m_TextList.Add(sText);
    end else begin
      m_TextList.Add(sMsg);
    end;

    MainForm.Canvas.Font.Name := FontName;
    MainForm.Canvas.Font.Size := FontSize;
    MainForm.Canvas.Font.Style := [];
    MainForm.Canvas.Font.Charset := FontCharset;
  end;
end;

procedure TDrawScreenCenterMsg.Draw(MSurface: TTexture);
var
  sText: WideString;
  FontName: string;
  FontSize: Integer;
  I, nY, nTextHeight: Integer;
  FontCharset: TFontCharset;
begin
  if m_TextList.Count > 0 then begin
    if GetTickCount < m_dwShowTime then begin
      with MSurface do begin
        FontName := MainForm.Canvas.Font.Name;
        FontSize := MainForm.Canvas.Font.Size;
        FontCharset := MainForm.Canvas.Font.Charset;
        MainForm.Canvas.Font.Charset := GB2312_CHARSET;
        MainForm.Canvas.Font.Name := g_sFontName;
        MainForm.Canvas.Font.Size := 30;
        MainForm.Canvas.Font.Style := [fsBold];

        nTextHeight := TextHeight('Pp');

        nY := (SCREENHEIGHT - m_TextList.Count * nTextHeight) div 2;

        for I := 0 to m_TextList.Count - 1 do begin
          BoldTextOut((SCREENWIDTH - TextWidth(m_TextList.Strings[I])) div 2, nY, m_TextList.Strings[I],
            GetRGB(m_FColor), GetRGB(m_BColor));
          Inc(nY, nTextHeight);
        end;

        MainForm.Canvas.Font.Name := FontName;
        MainForm.Canvas.Font.Size := FontSize;
        MainForm.Canvas.Font.Style := [];
        MainForm.Canvas.Font.Charset := FontCharset;
      end;
    end else m_TextList.Clear;
  end;
end;

{------------------------------------------------------------------------------}

constructor TDrawDelayMsg.Create;
begin
  m_dwDrawFrameCount := GetTickCount;
  m_MsgList := TGList.Create;
end;

destructor TDrawDelayMsg.Destroy;
begin
  Clear;
  m_MsgList.Free;
  inherited Destroy;
end;

procedure TDrawDelayMsg.Clear;
var
  I: Integer;
  DelayMsg: pTDelayMsg;
begin
  for I := 0 to m_MsgList.Count - 1 do begin
    DelayMsg := pTDelayMsg(m_MsgList.Items[I]);
    Dispose(DelayMsg);
  end;
  m_MsgList.Clear;
end;

procedure TDrawDelayMsg.Delete(RecogId: Integer);
var
  I: Integer;
  DelayMsg: pTDelayMsg;
begin
  for I := m_MsgList.Count - 1 downto 0 do begin
    DelayMsg := pTDelayMsg(m_MsgList.Items[I]);
    if DelayMsg.RecogId = RecogId then begin
      m_MsgList.Delete(I);
      Dispose(DelayMsg);
    end;
  end;
end;

procedure TDrawDelayMsg.Add(RecogId: Integer; sMsg: string; nTime: Integer; cColor: TColor);
var
  DelayMsg: pTDelayMsg;
begin
  New(DelayMsg);
  DelayMsg.RecogId := RecogId;
  DelayMsg.Msg := sMsg;
  DelayMsg.Time := GetTickCount + nTime * 1000;
  DelayMsg.Color := cColor;
  m_MsgList.Add(DelayMsg);
end;

procedure TDrawDelayMsg.Draw(Surface: TTexture);
  function GetTimeStr(nTime: Integer): string;
  var
    nMin: Integer;
    nSec: Integer;
  begin
    nSec := nTime div 1000;
    nMin := nSec div 60;
    if nMin > 0 then begin
      nSec := nSec mod 60;
      Result := IntToStr(nMin) + '分' + IntToStr(nSec) + '秒';
    end else begin
      Result := IntToStr(nSec) + '秒';
    end;
  end;
var
  I, Y: Integer;
  sMsg: string;
  DelayMsg: pTDelayMsg;
begin
  Y := 380;
  for I := m_MsgList.Count - 1 downto 0 do begin
    DelayMsg := pTDelayMsg(m_MsgList.Items[I]);
    if GetTickCount > DelayMsg.Time then begin
      m_MsgList.Delete(I);
      Dispose(DelayMsg);
    end;
  end;
  for I := 0 to m_MsgList.Count - 1 do begin
    DelayMsg := pTDelayMsg(m_MsgList.Items[I]);
    sMsg := DelayMsg.Msg;
    if Pos('%s', sMsg) > 0 then
      sMsg := Format(sMsg, [GetTimeStr(DelayMsg.Time - GetTickCount)]);
    Surface.BoldTextOut(250, Y, sMsg, DelayMsg.Color);
    Dec(Y, 16);
  end;
end;

{------------------------------------------------------------------------------}

constructor TDrawScreenMoveMsg.Create;
begin
  m_MsgList := TList.Create;
  m_nCurrMoveMsg := nil;
end;

destructor TDrawScreenMoveMsg.Destroy;
var
  I: Integer;
  MoveMsg: pTMoveMsg;
begin
  for I := 0 to m_MsgList.Count - 1 do begin
    MoveMsg := m_MsgList.Items[I];
    MoveMsg.Texture.Free;
    Dispose(MoveMsg);
  end;
  m_MsgList.Free;
  inherited;
end;

procedure TDrawScreenMoveMsg.Add(sMsg: string; FColor, BColor: Byte; nX, nY, nCount: Integer);
var
  FontSize: Integer;
  MoveMsg: pTMoveMsg;
  Index: Integer;
begin
  New(MoveMsg);
  MoveMsg.Count := nCount;
  MoveMsg.X := nX;
  MoveMsg.Y := nY;
  MoveMsg.Texture := TTexture.Create;
  MoveMsg.BColor := BColor;
  FontSize := MainForm.Canvas.Font.Size;
  MainForm.Canvas.Font.Size := 9;
  MainForm.Canvas.Font.Style := [fsBold];
  MoveMsg.Texture.SetSize(ImageCanvas.TextWidth(sMsg), ImageCanvas.TextHeight(sMsg));
  MoveMsg.Texture.TextOut(0, 0, sMsg, GetRGB(FColor)); //, GetRGB(BColor)
  MainForm.Canvas.Font.Size := FontSize;
  MainForm.Canvas.Font.Style := [];

  FY := nY;

  if m_nCurrMoveMsg = nil then begin
    m_MsgList.Insert(0, MoveMsg);
  end else begin
    Index := m_MsgList.IndexOf(m_nCurrMoveMsg);
    if Index >= 0 then begin
      if Index = m_MsgList.Count - 1 then begin
        m_MsgList.Add(MoveMsg);
      end else begin
        m_MsgList.Insert(Index + 1, MoveMsg);
      end;
    end else begin
      m_MsgList.Insert(0, MoveMsg);
    end;
  end;
end;

procedure TDrawScreenMoveMsg.Draw(MSurface: TTexture);
var
  nX, nWidth: Integer;
begin
  if (m_nCurrMoveMsg <> nil) and (m_nCurrMoveMsg.Count <= 0) then begin
    m_MsgList.Remove(m_nCurrMoveMsg);
    try
      m_nCurrMoveMsg.Texture.Free;
    except
      m_nCurrMoveMsg.Texture := nil;
    end;

    try
      Dispose(m_nCurrMoveMsg);
    except
      m_nCurrMoveMsg := nil;
    end;
    m_nCurrMoveMsg := nil;
  end;

  if (m_nCurrMoveMsg = nil) and (m_MsgList.Count > 0) then begin
    m_nCurrMoveMsg := m_MsgList[0];

    FLen := 0;
    FLeft := 0;
    FOffSetX := 0;
  end;

  if (m_nCurrMoveMsg <> nil) then begin

    if FrmDlg.DMerchantDlg.Visible or FrmDlg.DMerchantBigDlg.Visible or FrmDlg.DHeroHealthStateWin.Visible then begin
      if FrmDlg.DMerchantBigDlg.Visible and (FY <= FrmDlg.DMerchantBigDlg.Height) then
        FX := FrmDlg.DMerchantBigDlg.Width else
        if FrmDlg.DMerchantDlg.Visible and (FY <= FrmDlg.DMerchantDlg.Height) then
        FX := FrmDlg.DMerchantDlg.Width  else

        if FrmDlg.DHeroHealthStateWin.Visible and (FY <= FrmDlg.DHeroHealthStateWin.Height) then
        FX := FrmDlg.DHeroHealthStateWin.Width + 10

        else FX := 50;
    end else FX := 50;

    nWidth := SCREENWIDTH - FX - 50;

    if FOffSetX < nWidth then begin
      if FLeft > 0 then begin
        Inc(FOffSetX, FLeft);
        FLeft := 0;
      end;
    end else begin
      if FOffSetX > nWidth then begin
        Inc(FLeft, FOffSetX - nWidth);
        FOffSetX := nWidth;
      end;
    end;

    MSurface.FillRectAlpha(Bounds(FX, FY - m_nCurrMoveMsg.Texture.Height div 2, nWidth, m_nCurrMoveMsg.Texture.Height * 2), GetRGB(m_nCurrMoveMsg.BColor), 150);  //GetRGB(g_btBColor)

    MSurface.Draw(FX + nWidth - FOffSetX, FY, Bounds(FLeft, 0, FLen - FLeft, m_nCurrMoveMsg.Texture.Height), m_nCurrMoveMsg.Texture);

    if GetTickCount - m_dwMoveTick > 5 then begin
      m_dwMoveTick := GetTickCount;

      if FOffSetX < nWidth then begin
        if FLeft > 0 then begin
          Inc(FOffSetX, FLeft + 1);
          FLeft := 0;
        end else Inc(FOffSetX);
      end else begin
        if FOffSetX > nWidth then begin
          Inc(FLeft, FOffSetX - nWidth + 1);
          FOffSetX := nWidth;
        end else Inc(FLeft);
      end;

      if FLen < m_nCurrMoveMsg.Texture.Width then Inc(FLen);

      if FOffSetX + FLeft >= FLen + nWidth then begin
        Dec(m_nCurrMoveMsg.Count);
        FLen := 0;
        FLeft := 0;
        FOffSetX := 0;

      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}

constructor TDrawScreenXYManage.Create;
begin
  m_DrawScreenXYManageList := TList.Create;
end;

destructor TDrawScreenXYManage.Destroy;
var
  I: Integer;
begin
  for I := 0 to m_DrawScreenXYManageList.Count - 1 do begin
    TDrawScreenXY(m_DrawScreenXYManageList.Items[I]).Free;
  end;
  m_DrawScreenXYManageList.Free;
end;

function TDrawScreenXYManage.GetDrawScreenXY(nX, nY: Integer): TDrawScreenXY;
var
  I, II: Integer;
  DrawScreenXY: TDrawScreenXY;
  boFound: Boolean;
  SysMsg: pTSysMsg;
begin
  Result := nil;
  boFound := False;
  for I := 0 to m_DrawScreenXYManageList.Count - 1 do begin
    DrawScreenXY := TDrawScreenXY(m_DrawScreenXYManageList.Items[I]);
    for II := 0 to DrawScreenXY.m_SysMsgList.Count - 1 do begin
      SysMsg := pTSysMsg(DrawScreenXY.m_SysMsgList.Items[II]);
      if (SysMsg.nX <> nX) or (SysMsg.nY <> nY) then begin
        Break;
      end else begin
        boFound := True;
        Result := DrawScreenXY;
        Break;
      end;
    end;
    if boFound then Break;
  end;
end;

procedure TDrawScreenXYManage.AddSysMsg(Msg: string; nX, nY: Integer; Color: TColor);
var
  DrawScreenXY: TDrawScreenXY;
begin
  DrawScreenXY := GetDrawScreenXY(nX, nY);
  if DrawScreenXY = nil then begin
    DrawScreenXY := TDrawScreenXY.Create;
    m_DrawScreenXYManageList.Add(DrawScreenXY);
  end;
  DrawScreenXY.AddSysMsg(Msg, nX, nY, Color);
end;

procedure TDrawScreenXYManage.Draw(MSurface: TTexture);
var
  I: Integer;
begin
  for I := 0 to m_DrawScreenXYManageList.Count - 1 do begin
    TDrawScreenXY(m_DrawScreenXYManageList.Items[I]).Draw(MSurface);
  end;
end;

constructor TDrawScreenXY.Create;
begin
  m_SysMsgList := TList.Create;
end;

destructor TDrawScreenXY.Destroy;
var
  I: Integer;
begin
  for I := 0 to m_SysMsgList.Count - 1 do begin
    Dispose(m_SysMsgList.Items[I]);
  end;
  m_SysMsgList.Free;
end;

procedure TDrawScreenXY.DeleteSysMsg(nMaxCount: Integer);
var
  SysMsg: pTSysMsg;
begin
  while True do begin
    if m_SysMsgList.Count <= 0 then Break;
    SysMsg := pTSysMsg(m_SysMsgList.Items[0]);
    if (GetTickCount - SysMsg.dwSpellTime < 3000) and (m_SysMsgList.Count <= nMaxCount) then Break;
    m_SysMsgList.Delete(0);
    Dispose(SysMsg);
  end;
end;

procedure TDrawScreenXY.AddSysMsg(Msg: string; nX, nY: Integer; Color: TColor);
var
  SysMsg: pTSysMsg;
  sY: Integer;
begin
  DeleteSysMsg(20 - 1);
  New(SysMsg);
  SysMsg.sSysMsg := Msg;
  SysMsg.Color := Color;
  SysMsg.nX := nX;
  SysMsg.nY := nY;
  SysMsg.dwSpellTime := GetTickCount;
  m_SysMsgList.Add(SysMsg);
end;

procedure TDrawScreenXY.Draw(MSurface: TTexture);
var
  I, nPosition: Integer;
  SysMsg: pTSysMsg;
begin
  with MSurface do begin
    nPosition := 0;
    for I := 0 to m_SysMsgList.Count - 1 do begin
      SysMsg := pTSysMsg(m_SysMsgList.Items[I]);
      if nPosition = 0 then nPosition := SysMsg.nY;
      BoldTextOut(SysMsg.nX, nPosition, SysMsg.sSysMsg, SysMsg.Color); //clGreen
      Inc(nPosition, 16);
    end;
  end;
  DeleteSysMsg(20);
end;

{------------------------------------------------------------------------------}

constructor TDrawScreen.Create;
var
  I: Integer;
begin
  CurrentScene := nil;
  m_dwFrameTime := GetTickCount;
  m_dwFrameCount := 0;
  ChatStrs := TStringList.Create;
  ChatBks := TList.Create;
  ChatBoardTop := 0;
  HintList := TStringList.Create;
  m_DrawScreenXYManage := TDrawScreenXYManage.Create;
  DrawScreenCenterMsg := TDrawScreenCenterMsg.Create;
  DrawScreenHintManage := TDrawScreenHintManage.Create;
  DrawDelayMsg := TDrawDelayMsg.Create;
  m_MoveMsgList := TList.Create;
  HintMode := False;
end;

destructor TDrawScreen.Destroy;
var
  I: Integer;
begin
  ChatStrs.Free;
  ChatBks.Free;
  HintList.Free;
  m_DrawScreenXYManage.Free;
  for I := 0 to m_MoveMsgList.Count - 1 do begin
    TDrawScreenMoveMsg(m_MoveMsgList.Items[I]).Free;
  end;
  m_MoveMsgList.Free;
  DrawScreenCenterMsg.Free;
  DrawDelayMsg.Free;
  DrawScreenHintManage.Free;
  inherited Destroy;
end;

procedure TDrawScreen.Initialize;
begin

end;

procedure TDrawScreen.Finalize;
begin
end;

procedure TDrawScreen.KeyPress(var Key: Char);
begin
  if CurrentScene <> nil then
    CurrentScene.KeyPress(Key);
end;

procedure TDrawScreen.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if CurrentScene <> nil then
    CurrentScene.KeyDown(Key, Shift);
end;

procedure TDrawScreen.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if CurrentScene <> nil then
    CurrentScene.MouseMove(Shift, X, Y);
end;

procedure TDrawScreen.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if CurrentScene <> nil then
    CurrentScene.MouseDown(Button, Shift, X, Y);
end;

procedure TDrawScreen.ChangeScene(scenetype: TSceneType);
begin
  if CurrentScene <> nil then
    CurrentScene.CloseScene;
  case scenetype of
    stIntro: CurrentScene := IntroScene;
    stLogin: CurrentScene := LoginScene;
    stSelectCountry: ;
    stSelectChr: CurrentScene := SelectChrScene;
    stNewChr: ;
    stLoading: ;
    stLoginNotice: CurrentScene := LoginNoticeScene;
    stPlayGame: CurrentScene := PlayScene;
  end;
  if CurrentScene <> nil then
    CurrentScene.OpenScene;
end;

procedure TDrawScreen.AddSysMsg(Msg: string; nX, nY: Integer; Color: TColor);
begin
  m_DrawScreenXYManage.AddSysMsg(Msg, nX, nY, Color);

end;

procedure TDrawScreen.AddMoveMsg(sMsg: string; FColor, BColor: Byte; nX, nY, nCount: Integer);
var
  I: Integer;
  DrawScreenMoveMsg: TDrawScreenMoveMsg;
begin
  for I := 0 to m_MoveMsgList.Count - 1 do begin
    DrawScreenMoveMsg := TDrawScreenMoveMsg(m_MoveMsgList.Items[I]);
    if DrawScreenMoveMsg.Y = nY then begin
      DrawScreenMoveMsg.Add(sMsg, FColor, BColor, nX, nY, nCount);
      Exit;
    end;
  end;
  DrawScreenMoveMsg := TDrawScreenMoveMsg.Create;
  DrawScreenMoveMsg.Add(sMsg, FColor, BColor, nX, nY, nCount);
  m_MoveMsgList.Add(DrawScreenMoveMsg);
end;

function TDrawScreen.AddChatBoardString(Str: string; FColor, BColor: Integer): string;
begin
  Result := FrmDlg.AddMemoChat(Str, FColor, BColor);
end;

procedure TDrawScreen.ShowHint(X, Y: Integer; HintStringList1, HintStringList2: TStringList; drawup: Boolean);
  function GetStarsRow(Level: Byte): Integer;
  begin
    if Level >= 10 then begin
      Result := Level div 10;
      if Level mod 10 > 0 then Inc(Result);
    end else
      if Level > 0 then begin
      Result := 1;
    end else Result := 0;
  end;
var
  I, II, nX, nY, nRow, nW, nH: Integer;

  Level: Byte;
  nLevel: Integer;
  rc: TRect;
  DrawScreenHint: TDrawScreenHint;
  DrawScreenHintList1: TDrawScreenHintList;
  DrawScreenHintList2: TDrawScreenHintList;
  DrawScreenHintLines: TDrawScreenHintLines;
begin
  ClearHint;
  DrawScreenHintList1 := nil;
  DrawScreenHintList2 := nil;
  if HintStringList1.Count > 0 then begin
    DrawScreenHintList1 := TDrawScreenHintList.Create(DrawScreenHintManage);
    DrawScreenHintList1.Style := s_Item;
    DrawScreenHintLines := TDrawScreenHintLines.Create(DrawScreenHintList1);
    DrawScreenHint := DrawScreenHintLines.Add;
    DrawScreenHint.Add(X, Y, HintStringList1.Strings[0], clyellow);

    Level := Byte(HintStringList1.Objects[0]);
    nY := DrawScreenHintList1.Items[DrawScreenHintList1.Count - 1].Top + DrawScreenHintList1.Items[DrawScreenHintList1.Count - 1].Height + 1;
    //rc := Bounds(X, nY, 0, 0);
    nX := X;
    if Level > 6 then begin
      nRow := GetStarsRow(Level);
      for I := 0 to nRow - 1 do begin
        nX := X;
        nY := DrawScreenHintList1.Items[DrawScreenHintList1.Count - 1].Top + DrawScreenHintList1.Items[DrawScreenHintList1.Count - 1].Height + 1;
        DrawScreenHintLines := TDrawScreenHintLines.Create(DrawScreenHintList1);
        nLevel := _MIN(Level, 10);
        if Level > 0 then begin
          for II := 0 to nLevel - 1 do begin
            DrawScreenHint := DrawScreenHintLines.Add;
            DrawScreenHint.Add(nX, nY, '', clyellow, g_WCqFirImages, 60, 4, 100);
            nX := nX + DrawScreenHint.Width;
            //rc := DrawScreenHint.Add(rc.Right, nY, '', clyellow, g_WCqFirImages, 60, 4, 100);
            //rc.Right := rc.Right + 2;
          end;
        end;
        Dec(Level, nLevel);
      end;
    end;

    for I := 1 to HintStringList1.Count - 1 do begin
      nY := DrawScreenHintList1.Items[DrawScreenHintList1.Count - 1].Top + DrawScreenHintList1.Items[DrawScreenHintList1.Count - 1].Height + 1;
      DrawScreenHintLines := TDrawScreenHintLines.Create(DrawScreenHintList1);
      DrawScreenHint := DrawScreenHintLines.Add;
      DrawScreenHint.Add(X, nY, HintStringList1.Strings[I], TColor(HintStringList1.Objects[I]));
    end;

    {if drawup then begin
      HintHeight := DrawScreenHintList.Height;
      for I := 0 to DrawScreenHintList.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Top := DrawScreenHint.Top - HintHeight;
        end;
      end;
    end;
}
    X := DrawScreenHintList1.Left + DrawScreenHintList1.Width + 6;
    //Y := DrawScreenHintList.Top + 4;
  end;

  if HintStringList2.Count > 0 then begin
    DrawScreenHintList2 := TDrawScreenHintList.Create(DrawScreenHintManage);
    DrawScreenHintList2.Style := s_Item;
    DrawScreenHintLines := TDrawScreenHintLines.Create(DrawScreenHintList2);
    DrawScreenHint := DrawScreenHintLines.Add;
    DrawScreenHint.Add(X, Y, HintStringList2.Strings[0], clyellow);

    Level := Byte(HintStringList2.Objects[0]);
    nY := DrawScreenHintList2.Items[DrawScreenHintList2.Count - 1].Top + DrawScreenHintList2.Items[DrawScreenHintList2.Count - 1].Height + 1;
    //rc := Bounds(X, nY, 0, 0);
    nX := X;
    if Level > 6 then begin
      nRow := GetStarsRow(Level);
      for I := 0 to nRow - 1 do begin
        nX := X;
        nY := DrawScreenHintList2.Items[DrawScreenHintList2.Count - 1].Top + DrawScreenHintList2.Items[DrawScreenHintList2.Count - 1].Height + 1;
        DrawScreenHintLines := TDrawScreenHintLines.Create(DrawScreenHintList2);
        nLevel := _MIN(Level, 10);
        if Level > 0 then begin
          for II := 0 to nLevel - 1 do begin
            DrawScreenHint := DrawScreenHintLines.Add;
            DrawScreenHint.Add(nX, nY, '', clyellow, g_WCqFirImages, 60, 4, 100);
            nX := nX + DrawScreenHint.Width;
            //rc := DrawScreenHint.Add(rc.Right, nY, '', clyellow, g_WCqFirImages, 60, 4, 100);
            //rc.Right := rc.Right + 2;
          end;
        end;
        Dec(Level, nLevel);
      end;
    end;

    for I := 1 to HintStringList2.Count - 1 do begin
      nY := DrawScreenHintList2.Items[DrawScreenHintList2.Count - 1].Top + DrawScreenHintList2.Items[DrawScreenHintList2.Count - 1].Height + 1;
      DrawScreenHintLines := TDrawScreenHintLines.Create(DrawScreenHintList2);
      DrawScreenHint := DrawScreenHintLines.Add;
      DrawScreenHint.Add(X, nY, HintStringList2.Strings[I], TColor(HintStringList2.Objects[I]));
    end;

    {if drawup then begin
      HintHeight := DrawScreenHintList.Height;
      for I := 0 to DrawScreenHintList.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Top := DrawScreenHint.Top - HintHeight;
        end;
      end;
    end;}
  end;

  if (DrawScreenHintList1 <> nil) and (DrawScreenHintList2 <> nil) then begin
    nX := _MIN(DrawScreenHintList1.Left, DrawScreenHintList2.Left);
    if nX < 0 then begin
      nW := Abs(nX);
      for I := 0 to DrawScreenHintList1.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList1.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Left := DrawScreenHint.Left + nW;
        end;
      end;
      for I := 0 to DrawScreenHintList2.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList2.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Left := DrawScreenHint.Left + nW;
        end;
      end;
    end;

    nY := _MIN(DrawScreenHintList1.Top, DrawScreenHintList2.Top);
    if nY < 0 then begin
      nH := Abs(nY);
      for I := 0 to DrawScreenHintList1.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList1.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Top := DrawScreenHint.Top + nH;
        end;
      end;
      for I := 0 to DrawScreenHintList2.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList2.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Top := DrawScreenHint.Top + nH;
        end;
      end;
    end;

    if DrawScreenHintList2.Left + DrawScreenHintList2.Width > SCREENWIDTH then begin
      nW := SCREENWIDTH - DrawScreenHintList2.Width;
      nW := DrawScreenHintList2.Left - nW;
      for I := 0 to DrawScreenHintList2.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList2.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Left := DrawScreenHint.Left - nW;
        end;
      end;

      for I := 0 to DrawScreenHintList1.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList1.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Left := DrawScreenHint.Left - nW;
        end;
      end;
    end;

    nY := _MIN(DrawScreenHintList1.Top, DrawScreenHintList2.Top);
    nH := _MAX(DrawScreenHintList1.Height, DrawScreenHintList2.Height);
    if nY + nH > SCREENHEIGHT then begin
      nH := nY - (SCREENHEIGHT - nH);

      for I := 0 to DrawScreenHintList1.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList1.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Top := DrawScreenHint.Top - nH;
        end;
      end;
      for I := 0 to DrawScreenHintList2.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList2.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Top := DrawScreenHint.Top - nH;
        end;
      end;
    end;
  end;
end;

procedure TDrawScreen.ShowHint(X, Y: Integer; HintStringList: TStringList; drawup: Boolean);
  function GetStarsRow(Level: Byte): Integer;
  begin
    if Level >= 10 then begin
      Result := Level div 10;
      if Level mod 10 > 0 then Inc(Result);
    end else
      if Level > 0 then begin
      Result := 1;
    end else Result := 0;
  end;

var
  I, II, nX, nY, nRow, nH, nW: Integer;

  Level: Byte;
  nLevel: Integer;

  rc: TRect;
  DrawScreenHint: TDrawScreenHint;
  DrawScreenHintList: TDrawScreenHintList;
  DrawScreenHintLines: TDrawScreenHintLines;
begin
  ClearHint;
  if HintStringList.Count > 0 then begin
    DrawScreenHintList := TDrawScreenHintList.Create(DrawScreenHintManage);
    DrawScreenHintList.Style := s_Item;
    DrawScreenHintLines := TDrawScreenHintLines.Create(DrawScreenHintList);
    DrawScreenHint := DrawScreenHintLines.Add;
    DrawScreenHint.Add(X, Y, HintStringList.Strings[0], clyellow);

    Level := Byte(HintStringList.Objects[0]);
    nY := DrawScreenHintList.Items[DrawScreenHintList.Count - 1].Top + DrawScreenHintList.Items[DrawScreenHintList.Count - 1].Height + 1;

    nX := X;
    if Level > 6 then begin
      nRow := GetStarsRow(Level);
      //AddChatBoardString('nRow:'+IntToStr(nRow)+' Level:'+IntToStr(Level), clyellow, clRed);
      for I := 0 to nRow - 1 do begin
        if Level > 0 then begin
          nX := X;
          nY := DrawScreenHintList.Items[DrawScreenHintList.Count - 1].Top + DrawScreenHintList.Items[DrawScreenHintList.Count - 1].Height + 1;
          DrawScreenHintLines := TDrawScreenHintLines.Create(DrawScreenHintList);
          nLevel := _MIN(Level, 10);
          //AddChatBoardString('nLevel:'+IntToStr(nLevel), clyellow, clRed);
          for II := 0 to nLevel - 1 do begin
            DrawScreenHint := DrawScreenHintLines.Add;
            DrawScreenHint.Add(nX, nY, '', clyellow, g_WCqFirImages, 60, 4, 100);
            nX := nX + DrawScreenHint.Width;
            //rc := DrawScreenHint.Add(rc.Right, nY, '', clyellow, g_WCqFirImages, 60, 4, 100);
            //AddChatBoardString('rc.Right:'+IntToStr(rc.Right), clyellow, clRed);
            //rc.Right := rc.Right + 2;
          end;
        end;
        Dec(Level, nLevel);
      end;
    end;

    for I := 1 to HintStringList.Count - 1 do begin
      nY := DrawScreenHintList.Items[DrawScreenHintList.Count - 1].Top + DrawScreenHintList.Items[DrawScreenHintList.Count - 1].Height + 1;
      DrawScreenHintLines := TDrawScreenHintLines.Create(DrawScreenHintList);
      DrawScreenHint := DrawScreenHintLines.Add;
      DrawScreenHint.Add(X, nY, HintStringList.Strings[I], TColor(HintStringList.Objects[I]));
    end;

    if drawup then begin
      HintHeight := DrawScreenHintList.Height;
      for I := 0 to DrawScreenHintList.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Top := DrawScreenHint.Top - HintHeight;
        end;
      end;
    end;

    if DrawScreenHintList.Left < 0 then begin
      nW := Abs(DrawScreenHintList.Left);
      for I := 0 to DrawScreenHintList.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Left := DrawScreenHint.Left + nW;
        end;
      end;
    end;

    if DrawScreenHintList.Top < 0 then begin
      nH := Abs(DrawScreenHintList.Top);
      for I := 0 to DrawScreenHintList.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Top := DrawScreenHint.Top + nH;
        end;
      end;
    end;

    if DrawScreenHintList.Left + DrawScreenHintList.Width > SCREENWIDTH then begin
      nW := SCREENWIDTH - DrawScreenHintList.Width;
      nW := DrawScreenHintList.Left - nW;
      for I := 0 to DrawScreenHintList.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Left := DrawScreenHint.Left - nW;
        end;
      end;
    end;

    if DrawScreenHintList.Top + DrawScreenHintList.Height > SCREENHEIGHT then begin
      nH := SCREENHEIGHT - DrawScreenHintList.Height;
      nH := DrawScreenHintList.Top - nH;
      for I := 0 to DrawScreenHintList.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Top := DrawScreenHint.Top - nH;
        end;
      end;
    end;
  end;
end;

procedure TDrawScreen.ShowHint(X, Y: Integer; Str: string; Color: TColor; drawup: Boolean);
var
  data: string;
  I, II, nY, nW, nH: Integer;

  rc: TRect;
  DrawScreenHint: TDrawScreenHint;
  DrawScreenHintList: TDrawScreenHintList;
  DrawScreenHintLines: TDrawScreenHintLines;
begin
  ClearHint;
  DrawScreenHintList := TDrawScreenHintList.Create(DrawScreenHintManage);
  DrawScreenHintList.Style := s_Legend;
  while True do begin
    if Str = '' then Break;
    Str := GetValidStr3(Str, data, ['\']);
    if data <> '' then begin
      if DrawScreenHintList.Count > 0 then begin
        nY := DrawScreenHintList.Items[DrawScreenHintList.Count - 1].Top + DrawScreenHintList.Items[DrawScreenHintList.Count - 1].Height + 1;
      end else begin
        nY := Y;
      end;
      DrawScreenHintLines := TDrawScreenHintLines.Create(DrawScreenHintList);
      DrawScreenHint := DrawScreenHintLines.Add;
      DrawScreenHint.Add(X, nY, data, Color);
    end;
  end;

  if drawup then begin
    HintHeight := DrawScreenHintList.Height;
    for I := 0 to DrawScreenHintList.Count - 1 do begin
      DrawScreenHintLines := DrawScreenHintList.Items[I];
      for II := 0 to DrawScreenHintLines.Count - 1 do begin
        DrawScreenHint := DrawScreenHintLines.Items[II];
        DrawScreenHint.Top := DrawScreenHint.Top - HintHeight;
      end;
    end;
  end;
  if DrawScreenHintList.Left < 0 then begin
    nW := Abs(DrawScreenHintList.Left);
    for I := 0 to DrawScreenHintList.Count - 1 do begin
      DrawScreenHintLines := DrawScreenHintList.Items[I];
      for II := 0 to DrawScreenHintLines.Count - 1 do begin
        DrawScreenHint := DrawScreenHintLines.Items[II];
        DrawScreenHint.Left := DrawScreenHint.Left + nW;
      end;
    end;
  end;

  if DrawScreenHintList.Top < 0 then begin
    nH := Abs(DrawScreenHintList.Top);
    for I := 0 to DrawScreenHintList.Count - 1 do begin
      DrawScreenHintLines := DrawScreenHintList.Items[I];
      for II := 0 to DrawScreenHintLines.Count - 1 do begin
        DrawScreenHint := DrawScreenHintLines.Items[II];
        DrawScreenHint.Top := DrawScreenHint.Top + nH;
      end;
    end;
  end;

  if DrawScreenHintList.Left + DrawScreenHintList.Width > SCREENWIDTH then begin
    nW := SCREENWIDTH - DrawScreenHintList.Width;
    nW := DrawScreenHintList.Left - nW;
    for I := 0 to DrawScreenHintList.Count - 1 do begin
      DrawScreenHintLines := DrawScreenHintList.Items[I];
      for II := 0 to DrawScreenHintLines.Count - 1 do begin
        DrawScreenHint := DrawScreenHintLines.Items[II];
        DrawScreenHint.Left := DrawScreenHint.Left - nW;
      end;
    end;
  end;

  if DrawScreenHintList.Top + DrawScreenHintList.Height > SCREENHEIGHT then begin
    nH := SCREENHEIGHT - DrawScreenHintList.Height;
    nH := DrawScreenHintList.Top - nH;
    for I := 0 to DrawScreenHintList.Count - 1 do begin
      DrawScreenHintLines := DrawScreenHintList.Items[I];
      for II := 0 to DrawScreenHintLines.Count - 1 do begin
        DrawScreenHint := DrawScreenHintLines.Items[II];
        DrawScreenHint.Top := DrawScreenHint.Top - nH;
      end;
    end;
  end;
end;

procedure TDrawScreen.ShowHintA(X, Y: Integer; HintStringList: TStringList; drawup: Boolean);
  function GetStarsRow(Level: Byte): Integer;
  begin
    if Level >= 10 then begin
      Result := Level div 10;
      if Level mod 10 > 0 then Inc(Result);
    end else
      if Level > 0 then begin
      Result := 1;
    end else Result := 0;
  end;
var
  I, II, nX, nY, nRow, nLevel, nW, nH: Integer;
  Level: Byte;
  rc: TRect;
  DrawScreenHint: TDrawScreenHint;
  DrawScreenHintList: TDrawScreenHintList;
  DrawScreenHintLines: TDrawScreenHintLines;
begin
  ClearHint;
  if HintStringList.Count > 0 then begin
    DrawScreenHintList := TDrawScreenHintList.Create(DrawScreenHintManage);
    DrawScreenHintList.Style := s_Windows;
    DrawScreenHintLines := TDrawScreenHintLines.Create(DrawScreenHintList);
    DrawScreenHint := DrawScreenHintLines.Add;
    DrawScreenHint.Add(X, Y, HintStringList.Strings[0], clyellow);

    Level := Byte(HintStringList.Objects[0]);
    nY := DrawScreenHintList.Items[DrawScreenHintList.Count - 1].Top + DrawScreenHintList.Items[DrawScreenHintList.Count - 1].Height + 1;
    nX := X;
    if Level > 6 then begin
      nRow := GetStarsRow(Level);
      for I := 0 to nRow - 1 do begin
        if Level > 0 then begin
          nX := X;
          nY := DrawScreenHintList.Items[DrawScreenHintList.Count - 1].Top + DrawScreenHintList.Items[DrawScreenHintList.Count - 1].Height + 1;

          nLevel := _MIN(Level, 10);
          DrawScreenHintLines := TDrawScreenHintLines.Create(DrawScreenHintList);
          for II := 0 to nLevel - 1 do begin
            DrawScreenHint := DrawScreenHintLines.Add;
            DrawScreenHint.Add(nX, nY, '', clyellow, g_WCqFirImages, 60, 4, 100);
            nX := nX + DrawScreenHint.Width;
            //rc := DrawScreenHint.Add(rc.Right, nY, '', clyellow, g_WCqFirImages, 60, 4, 100);
            //AddChatBoardString('rc.Right:'+IntToStr(rc.Right), clyellow, clRed);
            //rc.Right := rc.Right + 2;
          end;
        end;
        Dec(Level, nLevel);
      end;
    end;

    for I := 1 to HintStringList.Count - 1 do begin
      nY := DrawScreenHintList.Items[DrawScreenHintList.Count - 1].Top + DrawScreenHintList.Items[DrawScreenHintList.Count - 1].Height + 1;
      DrawScreenHintLines := TDrawScreenHintLines.Create(DrawScreenHintList);
      DrawScreenHint := DrawScreenHintLines.Add;
      DrawScreenHint.Add(X, nY, HintStringList.Strings[I], TColor(HintStringList.Objects[I]));
    end;

    if drawup then begin
      HintHeight := DrawScreenHintList.Height;
      for I := 0 to DrawScreenHintList.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Top := DrawScreenHint.Top - HintHeight;
        end;
      end;
    end;

    if DrawScreenHintList.Left < 0 then begin
      nW := Abs(DrawScreenHintList.Left);
      for I := 0 to DrawScreenHintList.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Left := DrawScreenHint.Left + nW;
        end;
      end;
    end;

    if DrawScreenHintList.Top < 0 then begin
      nH := Abs(DrawScreenHintList.Top);
      for I := 0 to DrawScreenHintList.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Top := DrawScreenHint.Top + nH;
        end;
      end;
    end;

    if DrawScreenHintList.Left + DrawScreenHintList.Width > SCREENWIDTH then begin
      nW := SCREENWIDTH - DrawScreenHintList.Width;
      nW := DrawScreenHintList.Left - nW;
      for I := 0 to DrawScreenHintList.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Left := DrawScreenHint.Left - nW;
        end;
      end;
    end;

    if DrawScreenHintList.Top + DrawScreenHintList.Height > SCREENHEIGHT then begin
      nH := SCREENHEIGHT - DrawScreenHintList.Height;
      nH := DrawScreenHintList.Top - nH;
      for I := 0 to DrawScreenHintList.Count - 1 do begin
        DrawScreenHintLines := DrawScreenHintList.Items[I];
        for II := 0 to DrawScreenHintLines.Count - 1 do begin
          DrawScreenHint := DrawScreenHintLines.Items[II];
          DrawScreenHint.Top := DrawScreenHint.Top - nH;
        end;
      end;
    end;

  end;
end;

procedure TDrawScreen.ShowHintA(X, Y: Integer; Str: string; Color: TColor; drawup: Boolean);
var
  data: string;
  I, II, nY, nW, nH: Integer;

  rc: TRect;
  DrawScreenHint: TDrawScreenHint;
  DrawScreenHintList: TDrawScreenHintList;
  DrawScreenHintLines: TDrawScreenHintLines;
begin
  ClearHint;
  DrawScreenHintList := TDrawScreenHintList.Create(DrawScreenHintManage);
  DrawScreenHintList.Style := s_Windows;
  while True do begin
    if Str = '' then Break;
    Str := GetValidStr3(Str, data, ['\']);
    if data <> '' then begin
      if DrawScreenHintList.Count > 0 then begin
        nY := DrawScreenHintList.Items[DrawScreenHintList.Count - 1].Top + DrawScreenHintList.Items[DrawScreenHintList.Count - 1].Height + 1;
      end else begin
        nY := Y;
      end;
      DrawScreenHintLines := TDrawScreenHintLines.Create(DrawScreenHintList);
      DrawScreenHint := DrawScreenHintLines.Add;
      DrawScreenHint.Add(X, nY, data, Color);
    end;
  end;

  if drawup then begin
    HintHeight := DrawScreenHintList.Height;
    for I := 0 to DrawScreenHintList.Count - 1 do begin
      DrawScreenHintLines := DrawScreenHintList.Items[I];
      for II := 0 to DrawScreenHintLines.Count - 1 do begin
        DrawScreenHint := DrawScreenHintLines.Items[II];
        DrawScreenHint.Top := DrawScreenHint.Top - HintHeight;
      end;
    end;
  end;

  if DrawScreenHintList.Left < 0 then begin
    nW := Abs(DrawScreenHintList.Left);
    for I := 0 to DrawScreenHintList.Count - 1 do begin
      DrawScreenHintLines := DrawScreenHintList.Items[I];
      for II := 0 to DrawScreenHintLines.Count - 1 do begin
        DrawScreenHint := DrawScreenHintLines.Items[II];
        DrawScreenHint.Left := DrawScreenHint.Left + nW;
      end;
    end;
  end;

  if DrawScreenHintList.Top < 0 then begin
    nH := Abs(DrawScreenHintList.Top);
    for I := 0 to DrawScreenHintList.Count - 1 do begin
      DrawScreenHintLines := DrawScreenHintList.Items[I];
      for II := 0 to DrawScreenHintLines.Count - 1 do begin
        DrawScreenHint := DrawScreenHintLines.Items[II];
        DrawScreenHint.Top := DrawScreenHint.Top + nH;
      end;
    end;
  end;

  if DrawScreenHintList.Left + DrawScreenHintList.Width > SCREENWIDTH then begin
    nW := SCREENWIDTH - DrawScreenHintList.Width;
    nW := DrawScreenHintList.Left - nW;
    for I := 0 to DrawScreenHintList.Count - 1 do begin
      DrawScreenHintLines := DrawScreenHintList.Items[I];
      for II := 0 to DrawScreenHintLines.Count - 1 do begin
        DrawScreenHint := DrawScreenHintLines.Items[II];
        DrawScreenHint.Left := DrawScreenHint.Left - nW;
      end;
    end;
  end;

  if DrawScreenHintList.Top + DrawScreenHintList.Height > SCREENHEIGHT then begin
    nH := SCREENHEIGHT - DrawScreenHintList.Height;
    nH := DrawScreenHintList.Top - nH;
    for I := 0 to DrawScreenHintList.Count - 1 do begin
      DrawScreenHintLines := DrawScreenHintList.Items[I];
      for II := 0 to DrawScreenHintLines.Count - 1 do begin
        DrawScreenHint := DrawScreenHintLines.Items[II];
        DrawScreenHint.Top := DrawScreenHint.Top - nH;
      end;
    end;
  end;
end;

procedure TDrawScreen.ClearHint;
begin
  HintList.Clear;
  DrawScreenHintManage.Clear;
  g_nDrawIndex := 0;
end;

procedure TDrawScreen.ClearChatBoard;
var
  I: Integer;
  DrawScreenMoveMsg: TDrawScreenMoveMsg;
begin
  for I := 0 to m_MoveMsgList.Count - 1 do begin
    DrawScreenMoveMsg := TDrawScreenMoveMsg(m_MoveMsgList.Items[I]);
    DrawScreenMoveMsg.Free;
  end;
  m_MoveMsgList.Clear;
  DrawScreenCenterMsg.Clear;
  DrawDelayMsg.Clear;
  FrmDlg.DMemoChat.Clear;
end;

procedure TDrawScreen.DrawScreen(MSurface: TTexture);
var
  I, k, line, sx, sY, FColor, BColor: Integer;
  OldColor: TColor;
  Actor: TActor;
  Str, uname: string;
  dsurface: TTexture;
  d: TTexture;
  rc: TRect;
  infoMsg: string;
  dwRunTime: LongWord;
begin
  if CurrentScene <> nil then
    CurrentScene.PlayScene(MSurface);
  if GetTickCount - m_dwFrameTime > 1000 then begin
    m_dwFrameTime := GetTickCount;
    m_dwDrawFrameCount := m_dwFrameCount;
    m_dwFrameCount := 0;
  end;
  Inc(m_dwFrameCount);
  infoMsg := '';
end;

//显示左上角信息文字

procedure TDrawScreen.DrawScreenTop(MSurface: TTexture);
var
  I: Integer;
begin
  if g_MySelf = nil then Exit;
  if CurrentScene = PlayScene then begin
    m_DrawScreenXYManage.Draw(MSurface);
    for I := 0 to m_MoveMsgList.Count - 1 do begin
      TDrawScreenMoveMsg(m_MoveMsgList.Items[I]).Draw(MSurface);
    end;
    DrawScreenCenterMsg.Draw(MSurface);
  end;
end;

procedure TDrawScreen.DrawQuad(MSurface: TTexture; ARect: TRect; Color: Integer);
var
  DRect: TRect;
  X, Y: Integer;
begin
  DRect := ARect;
  {DRect.Left := DRect.Left - 1;
  DRect.Right := DRect.Right + 1;
  DRect.Top := DRect.Top - 1;
  DRect.Bottom := DRect.Bottom + 1;   }
{  if DRect.Left < 0 then DRect.Left := 0;
  if DRect.Top < 0 then DRect.Top := 0;
  if DRect.Right > SCREENWIDTH then DRect.Right := SCREENWIDTH;
  if DRect.Bottom > SCREENHEIGHT then DRect.Bottom := SCREENHEIGHT;
  if DRect.Right <= DRect.Left then Exit;
  if DRect.Bottom <= DRect.Top then Exit;

  MSurface.FillRectAlpha(Rect(DRect.Left, DRect.Top, DRect.Right, DRect.Top + 1), Color);

  MSurface.FillRectAlpha(Rect(DRect.Left, DRect.Bottom - 1, DRect.Right, DRect.Bottom), Color);

  MSurface.FillRectAlpha(Rect(DRect.Left, DRect.Top, DRect.Left + 1, DRect.Bottom), Color);

  MSurface.FillRectAlpha(Rect(DRect.Right - 1, DRect.Top, DRect.Right, DRect.Bottom), Color);    }

end;

procedure TDrawScreen.DrawHint(MSurface: TTexture);
  function GetStarsWidth(Level: Byte): Integer;
  begin
    if Level < 5 then
      Result := Level * 16
    else Result := 5 * 16;
    Result := Result + Level div 5 * 2;
  end;
  function GetStarsHeight(Level: Byte): Integer;
  var
    nCount: Integer;
  begin
    Result := Level div 5 * 14;
    if Level mod 5 > 0 then Inc(Result, 14);
  end;
var
  d: TTexture;
  I, hx, hy, old, nLook, nSize, nY, nX, nGroup: Integer;
  rc: TRect;
  Str: string;
  FontStyle: TFontStyles;
  Level: Byte;
  nAlpha: Integer;
begin
  DrawScreenHintManage.Draw(MSurface);
  (*if HintMode then begin
    hx := 0;
    hy := 0;
    if HintList.Count > 0 then begin
      if HintX + HintWidth > SCREENWIDTH then hx := SCREENWIDTH - HintWidth
      else hx := HintX;
      if HintY < 0 then hy := 0
      else hy := HintY;
      if hx < 0 then hx := 0;
      rc.Left := hx;
      rc.Top := hy;
      rc.Right := hx + HintWidth;
      rc.Bottom := hy + HintHeight;

      if not DrawHintMode then begin

        MSurface.FillRectAlpha(rc, GetRGB(g_btBColor), g_btAlpha);
        MSurface.FrameRect(rc, GetRGB(g_btFColor));

      end else begin

        MSurface.FillRect(rc, $00E1FFFE); //$00E1FFFE

        nAlpha := 180;
        for I := 1 to 4 do begin
          Dec(nAlpha, 20);
          MSurface.FillRectAlpha(Rect(rc.Right, rc.Top + 4, rc.Right + I, rc.Bottom), clblack, nAlpha);
        end;

        nAlpha := 180;
        for I := 1 to 4 do begin
          Dec(nAlpha, 20);
          MSurface.FillRectAlpha(Rect(rc.Left + 4, rc.Bottom, rc.Right + 4, rc.Bottom + I), clblack, nAlpha);
        end;

      end;
    end;
    with MSurface do begin
      if HintList.Count > 0 then begin
        Level := Integer(HintList.Objects[0]);

        nY := hy + 3 + TextHeight('A') + 1;
        nX := hx + 4;

        BoldTextOut(hx + 4, hy + 3, HintList[0], clyellow);

        if HintList.Count >= 1 then begin
          if Level > 6 then
            hy := hy + 14 + 3;
          for I := 1 to HintList.Count - 1 do begin
            BoldTextOut(hx + 4, hy + 3 + (TextHeight('A') + 1) * I, HintList[I], TColor(HintList.Objects[I]));
          end;
        end;

        if (Level > 6) and (Level < 20) then begin
          for I := 0 to Level - 1 do begin
            if GetTickCount - g_DrawStarsTick[I].dwDrawTick >= 100 then begin
              g_DrawStarsTick[I].dwDrawTick := GetTickCount;
              if not g_DrawStarsTick[I].nIndex in [60..63] then g_DrawStarsTick[I].nIndex := 60 - 1;
              Inc(g_DrawStarsTick[I].nIndex);
              if g_DrawStarsTick[I].nIndex > 63 then g_DrawStarsTick[I].nIndex := 60;
            end;
            d := g_WCqFirImages.Images[g_DrawStarsTick[I].nIndex];
            if d <> nil then begin
              MSurface.Draw(nX, nY, d.ClientRect, d, True);
            end;
            Inc(nX, 16 + 2);
          end;
        end;
      end;
    end;
  end else begin
    hx := 0;
    hy := 0;
    //DScreen.AddChatBoardString('TDrawScreen.DrawHint0', clWhite, clPurple);
    if HintList.Count > 0 then begin
      //DScreen.AddChatBoardString('TDrawScreen.DrawHint1', clWhite, clPurple);
      //d := g_WMainImages.Images[394];
      //if d <> nil then begin
        {
        if HintWidth > d.Width then HintWidth := d.Width;
        if HintHeight > d.Height then HintHeight := d.Height;
        if HintX + HintWidth > SCREENWIDTH then hx := SCREENWIDTH - HintWidth
        else hx := HintX;
        if HintY < 0 then hy := 0
        else hy := HintY;
        if hx < 0 then hx := 0;
         }
        {
        if HintWidth > d.Width then HintWidth := d.Width;
        if HintHeight > d.Height then HintHeight := d.Height;
        }
      if HintX + HintWidth > SCREENWIDTH then hx := SCREENWIDTH - HintWidth
      else hx := HintX;
      if HintY < 0 then hy := 0
      else hy := HintY;
      if hx < 0 then hx := 0;

      if not DrawHintMode then begin
        MSurface.FillRectAlpha(Bounds(hx, hy, HintWidth, HintHeight), $00005E5E, 150);
          //DrawBlendEx(MSurface, hx, hy, d, 0, 0, HintWidth, HintHeight);
      end else begin
        rc.Left := hx;
        rc.Top := hy;
        rc.Right := hx + HintWidth;
        rc.Bottom := hy + HintHeight;

        MSurface.FillRect(rc, $00E1FFFE);

        nAlpha := 180;
        for I := 1 to 4 do begin
          MSurface.FillRectAlpha(Rect(rc.Right, rc.Top + 4, rc.Right + I, rc.Bottom), clblack, nAlpha);
          Dec(nAlpha, 30);
        end;

        nAlpha := 180;
        for I := 1 to 4 do begin
          MSurface.FillRectAlpha(Rect(rc.Left + 4, rc.Bottom, rc.Right + I, rc.Bottom + I), clblack, nAlpha);
          Dec(nAlpha, 30);
        end;

      end;
    end;
    with MSurface do begin
      if HintList.Count > 0 then begin
        for I := 0 to HintList.Count - 1 do begin
          TextOut(hx + 4, hy + 3 + (TextHeight('A') + 1) * I, HintList[I], HintColor);
        end;
      end;
    end;
  end;
  *)
  with MSurface do begin
    if g_MySelf <> nil then begin
      if g_ConfigClient.btMainInterface in [0, 2] then begin

        if g_boShowWhiteHint then begin
          if g_MySelf.m_nGameGold > 10 then begin
            BoldTextOut(FrmDlg.DBottom.Left + 8, SCREENHEIGHT - 42 - 16, g_sGameGoldName + ' ' + IntToStr(g_MySelf.m_nGameGold));
          end else begin
            BoldTextOut(FrmDlg.DBottom.Left + 8, SCREENHEIGHT - 42 - 16, g_sGameGoldName + ' ' + IntToStr(g_MySelf.m_nGameGold), clRed);
          end;
          if g_MySelf.m_nGamePoint > 10 then begin
            BoldTextOut(FrmDlg.DBottom.Left + 8 + 90, SCREENHEIGHT - 58, g_sGamePointName + ' ' + IntToStr(g_MySelf.m_nGamePoint));
          end else begin
            BoldTextOut(FrmDlg.DBottom.Left + 8 + 90, SCREENHEIGHT - 58, g_sGamePointName + ' ' + IntToStr(g_MySelf.m_nGamePoint), clRed);
          end;


        //显示时间
          BoldTextOut(FrmDlg.DBottom.Left + 670, SCREENHEIGHT - 147 + 126, FormatDateTime('hh:mm:ss', Now));
        //显示血和魔
          BoldTextOut(FrmDlg.DBottom.Left + 26, SCREENHEIGHT - 38, Format('%d/%d', [g_MySelf.m_Abil.HP, g_MySelf.m_Abil.MaxHP]));
          BoldTextOut(FrmDlg.DBottom.Left + 88, SCREENHEIGHT - 38, Format('%d/%d', [g_MySelf.m_Abil.MP, g_MySelf.m_Abil.MaxMP]));
        end;
      //显示所在地图
        BoldTextOut(FrmDlg.DBottom.Left + 8, SCREENHEIGHT - 20 + 4, g_sMapTitle + ' ' + IntToStr(g_MySelf.m_nCurrX) + ':' + IntToStr(g_MySelf.m_nCurrY));

      end else begin
        {if g_boShowWhiteHint then begin

          if g_MySelf.m_nGameGold > 10 then begin
            BoldTextOut(FrmDlg.DBottom.Left + 709, SCREENHEIGHT - 36, IntToStr(g_MySelf.m_nGameGold));
          end else begin
            BoldTextOut(FrmDlg.DBottom.Left + 709, SCREENHEIGHT - 36, IntToStr(g_MySelf.m_nGameGold), clRed);
          end;
          if g_MySelf.m_nGamePoint > 10 then begin
            BoldTextOut(FrmDlg.DBottom.Left + 709, SCREENHEIGHT - 20, IntToStr(g_MySelf.m_nGamePoint));
          end else begin
            BoldTextOut(FrmDlg.DBottom.Left + 709, SCREENHEIGHT - 20, IntToStr(g_MySelf.m_nGamePoint), clRed);
          end;

          //显示血
          Str := Format('%d/%d', [g_MySelf.m_Abil.HP, g_MySelf.m_Abil.MaxHP]);
          BoldTextOut(FrmDlg.DBottom.Left + 25 + (137 - TextWidth(Str)) div 2, SCREENHEIGHT - 38, Str);

          //显示魔
          Str := Format('%d/%d', [g_MySelf.m_Abil.MP, g_MySelf.m_Abil.MaxMP]);
          BoldTextOut(FrmDlg.DBottom.Left + 25 + (137 - TextWidth(Str)) div 2, SCREENHEIGHT - 38 + 12, Str);
        end; }
      //显示所在地图
        //BoldTextOut(MSurface, 8, SCREENHEIGHT - 20 + 4, clWhite, clblack, g_sMapTitle + ' ' + IntToStr(g_MySelf.m_nCurrX) + ':' + IntToStr(g_MySelf.m_nCurrY));

      end;

      if g_boStartPlay then begin
      {  case frmMain.MediaPlayer.Mode of
          mpNotReady: ;
          mpStopped: ;
          mpPlaying: begin
              g_nWaiteTime := 0;
              BoldTextOut(FrmDlg.DBottom.Left + 8, SCREENHEIGHT - 42 - 35, Format('正在播放:%s (%d%s)', [g_sSongName, Trunc((frmMain.MediaPlayer.Position / frmMain.MediaPlayer.Length) * 100), '%']), clLime);
            end;
          mpRecording: ;
          mpSeeking: ;
          mpPaused: ;
          mpOpen: begin
              if g_nWaiteTime >= 10 then begin
                g_boStartPlay := False;
                DScreen.AddChatBoardString(g_sSongName + '播放失败', clRed, clBlue);
                BoldTextOut(FrmDlg.DBottom.Left + 8, SCREENHEIGHT - 42 - 35, '加载失败...', clRed);
                frmMain.MediaPlayer.Close;
              end else begin
                BoldTextOut(FrmDlg.DBottom.Left + 8, SCREENHEIGHT - 42 - 35, Format('正在加载中(%d)...', [g_nWaiteTime]), clRed);
                if GetTickCount - g_dwStartPlayTick > 1000 then begin
                  g_dwStartPlayTick := GetTickCount;
                  Inc(g_nWaiteTime);
                end;
              end;
            end;
        end; }
      end;
    end;
  end;
  if g_MySelf <> nil then
    DrawDelayMsg.Draw(MSurface);
end;

procedure TDrawScreen.DrawMsg(MSurface: TTexture);
begin
  if Assigned(g_PlugInfo.HookFlip) then begin
    try
      g_PlugInfo.HookFlip(MSurface);
    except
      DebugOutStr('g_PlugInfo.HookFlip');
    end;
  end;
end;

procedure TDrawScreen.Draw(MSurface: TTexture);
var
  k: Integer;
  sName: string;
  Actor: TActor;
begin
  Exit;
  if (not CanDraw) or (g_MySelf = nil) or (g_ConnectionStep <> cnsPlay) then Exit;
  if g_NewStatus = sBlind then Exit;
  for k := 0 to PlayScene.m_ActorList.Count - 1 do begin
    Actor := TActor(PlayScene.m_ActorList.Items[k]);
    if (not Actor.m_boDeath) and (abs(Actor.m_nCurrX - g_MySelf.m_nCurrX) <= 8) and (abs(Actor.m_nCurrY - g_MySelf.m_nCurrY) <= 7) then begin
    end;
  end;

  if (g_FocusCret <> nil) and PlayScene.IsValidActor(g_FocusCret) then begin
    sName := g_FocusCret.m_sDescUserName + '\' + g_FocusCret.m_sUserName;
    g_FocusCret.NameTextOut(MSurface, sName,
      g_FocusCret.m_nSayX,
      g_FocusCret.m_nSayY + 30,
      g_FocusCret.m_nNameColor);
  end;

  if (g_MySelf <> nil) then begin
    if PlayScene.IsSelectMyself(g_nMouseX, g_nMouseY) then begin
      sName := g_MySelf.m_sDescUserName + '\' + g_MySelf.m_sUserName;
      g_MySelf.NameTextOut(MSurface, sName,
        g_MySelf.m_nSayX,
        g_MySelf.m_nSayY + 30,
        g_MySelf.m_nNameColor);
    end;
  end;
end;

end.

