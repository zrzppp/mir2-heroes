{===============================================================================
  RzBmpBtn Unit

  Raize Components - Component Source Unit

  Copyright © 1995-2007 by Raize Software, Inc.  All Rights Reserved.


  Components
  ------------------------------------------------------------------------------
  TRzBmpButton
    Button states represented by bitmaps


  Modification History
  ------------------------------------------------------------------------------
  4.2    (29 May 2007)
    * Surfaced Align property in TRzBmpButton.
  ------------------------------------------------------------------------------
  4.1.1  (12 Jan 2007)
    * Fixed issue in TRzBmpButton where disabling a button in the Down state
      would cause the Up image to be displayed.
  ------------------------------------------------------------------------------
  4.1    (15 Dec 2006)
    * Fixed flicker issue with TRzBmpButton.
  ------------------------------------------------------------------------------
  4.0    (23 Dec 2005)
    * Redesigned OnMouseEnter and OnMouseLeave events in TRzBmpButton to
      account for changes introduced in Borland Developer Studio 2006.
  ------------------------------------------------------------------------------
  3.0.8  (29 Aug 2003)
    * Added OnMouseEnter and OnMouseLeave events.
    * Added Hot property to TRzBmpButton.Bitmaps property. The Hot property is
      used to specify a bitmap image to be displayed when the mouse is
      positioned over the button.
  ------------------------------------------------------------------------------
  3.0    (20 Dec 2002)
    * Fixed problem where clicking on a Down button in a Group and then changing
      focus caused the button to change to the Up state even though AllowAllUp
      was False.
    * Fixed display problems of the focus rectangle.
    * Added the CaptionDownOffset property, which controls how far down and to
      the right the caption is displayed when the button is pressed.
===============================================================================}

//{$I RzComps.inc}

unit BmpBtn;

interface

uses
(*{$IFDEF USE_CS}
  CodeSiteLogging,
{$ENDIF}  *)
  SysUtils,
  Windows,
  Messages,
  Classes,
  Controls,
  Forms,
  Graphics,
  StdCtrls,
  ExtCtrls,
  Buttons,
  ComCtrls,
  Menus;
  //RzCommon;

const
  cm_BmpButtonPressed = wm_User + $2020;

type
  TButtonBorder = (bbNone, bbSingle, bbButton);
  TBtnSize = (bszNeither, bszButtonToBitmap, bszStretchToButton, bszTileToButton);

  {========================================}
  {== TRzButtonBitmaps Class Declaration ==}
  {========================================}
  TPaintBackGround = procedure(Sender: TObject; Bitmap: TBitmap) of object;
  TPaintProgress = procedure(Sender: TObject; Bitmap: TBitmap) of object;
  //TPaintBackGround procedure

  TButtonBitmaps = class(TPersistent)
  private
    FColCount, FRowCount: Integer;
    FColWidth, FRowHeight: Integer;
    FBitmap: TBitmap;
    FBitmaps: array of TBitmap;

    FUp: Integer;
    FDisabled: Integer;
    FDown: Integer;
    FHot: Integer;

    FTransparentColor: TColor;
    FOnChange: TNotifyEvent;

    { Internal Event Handlers }
    function GetBitmap(Index: Integer): TBitmap;
    procedure SetBitmaps;
    procedure BitmapsChanged(Sender: TObject);
    procedure SetColCount(Value: Integer);
    procedure SetRowCount(Value: Integer);
    procedure SetColWidth(Value: Integer);
    procedure SetRowHeight(Value: Integer);


  protected
    { Property Access Methods }
    procedure SetBitmap(Value: TBitmap); virtual;


    procedure SetDisabled(Value: Integer); virtual;
    procedure SetDown(Value: Integer); virtual;
    procedure SetHot(Value: Integer); virtual;
    procedure SetUp(Value: Integer); virtual;
    procedure SetTransparentColor(Value: TColor); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    property Bitmaps[Index: Integer]: TBitmap read GetBitmap;
  published
    { Property Declarations }
    property ColCount: Integer read FColCount write SetColCount;
    property RowCount: Integer read FRowCount write SetRowCount;
    property ColWidth: Integer read FColWidth write SetColWidth;
    property RowHeight: Integer read FRowHeight write SetRowHeight;

    property Up: Integer
      read FUp
      write SetUp;

    property Hot: Integer
      read FHot
      write SetHot;

    property Down: Integer
      read FDown
      write SetDown;

    property Disabled: Integer
      read FDisabled
      write SetDisabled;


    property TransparentColor: TColor
      read FTransparentColor
      write SetTransparentColor;

    property Bitmap: TBitmap
      read FBitmap
      write SetBitmap;

    property OnChange: TNotifyEvent
      read FOnChange
      write FOnChange;
  end;


  {====================================}
  {== TRzBmpButton Class Declaration ==}
  {====================================}

  TBmpButton = class(TCustomControl)
  private
    FGroupIndex: Integer;
    FBitmaps: TButtonBitmaps;
    FDown: Boolean;
    FCaptionDownOffset: Integer;
    FDragging: Boolean;
    FAllowAllUp: Boolean;
    FLayout: TButtonLayout;
    FSpacing: Integer;
    FMargin: Integer;
    FButtonStyle: TButtonStyle;
    FButtonBorder: TButtonBorder;
    FButtonSize: TBtnSize;
    FShowFocus: Boolean;
    FShowDownPattern: Boolean;
    FColor: TColor;
    IsFocused: Boolean;
    FModalResult: TModalResult;

    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;


    { Internal Event Handlers }
    procedure BitmapChanged(Sender: TObject);

    { Message Handling Methods }
    procedure WMLButtonDblClk(var Msg: TWMLButtonDown); message wm_LButtonDblClk;
    procedure WMSetFocus(var msg: TWMSetFocus); message wm_SetFocus;
    procedure WMKillFocus(var msg: TWMKillFocus); message wm_KillFocus;
    procedure WMSize(var msg: TWMSize); message wm_Size;
    procedure CMEnabledChanged(var Msg: TMessage); message cm_EnabledChanged;
    procedure CMButtonExtPressed(var Msg: TMessage); message cm_BmpButtonPressed;
    procedure CMDialogChar(var Msg: TCMDialogChar); message cm_DialogChar;
    procedure CMFontChanged(var Msg: TMessage); message cm_FontChanged;
    procedure CMTextChanged(var Msg: TMessage); message cm_TextChanged;
    procedure CMSysColorChange(var Msg: TMessage); message cm_SysColorChange;
    procedure CMMouseEnter(var Msg: TMessage); message cm_MouseEnter;
    procedure CMMouseLeave(var Msg: TMessage); message cm_MouseLeave;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message wm_EraseBkgnd;
  protected
    FState: TButtonState;
    FMouseOverButton: Boolean;

    procedure Loaded; override;
    function GetPalette: HPALETTE; override;
    procedure Paint; override;
    procedure UpdateExclusive;
    procedure CalcLayout(var TextBounds: TRect; var PaintRect: TRect; Bitmap: TBitmap);

    { Event Dispatch Methods }
    procedure ClickButton(DoClick: Boolean);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

    { Property Access Methods }
    procedure SetAllowAllUp(Value: Boolean); virtual;
    procedure SetButtonBorder(Value: TButtonBorder); virtual;
    procedure SetButtonSize(Value: TBtnSize); virtual;
    procedure SetButtonStyle(Value: TButtonStyle); virtual;
    procedure SetColor(Value: TColor); virtual;
    procedure SetDown(Value: Boolean); virtual;
    procedure SetCaptionDownOffset(Value: Integer); virtual;
    procedure SetGroupIndex(Value: Integer); virtual;
    procedure SetLayout(Value: TButtonLayout); virtual;
    procedure SetMargin(Value: Integer); virtual;
    procedure SetShowDownPattern(Value: Boolean); virtual;
    procedure SetShowFocus(Value: Boolean); virtual;
    procedure SetSpacing(Value: Integer); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
  published
    property AllowAllUp: Boolean
      read FAllowAllUp
      write SetAllowAllUp
      default False;

    property CaptionDownOffset: Integer
      read FCaptionDownOffset
      write SetCaptionDownOffset
      default 1;

    property ModalResult: TModalResult
      read FModalResult
      write FModalResult
      default mrNone;

    property GroupIndex: Integer
      read FGroupIndex
      write SetGroupIndex
      default 0;

    { Ensure group index is declared before Down }
    property Down: Boolean
      read FDown
      write SetDown
      default False;

    property Bitmaps: TButtonBitmaps
      read FBitmaps
      write FBitmaps;

    property Color: TColor
      read FColor
      write SetColor;

    property ButtonBorder: TButtonBorder
      read FButtonBorder
      write SetButtonBorder
      default bbNone;

    property ShowDownPattern: Boolean
      read FShowDownPattern
      write SetShowDownPattern
      default True;

    property ShowFocus: Boolean
      read FShowFocus
      write SetShowFocus
      default True;

    property ButtonSize: TBtnSize
      read FButtonSize
      write SetButtonSize
      default bszButtonToBitmap;

    property ButtonStyle: TButtonStyle
      read FButtonStyle
      write SetButtonStyle
      default bsAutoDetect;

    property Layout: TButtonLayout
      read FLayout
      write SetLayout
      default blGlyphLeft;

    property Margin: Integer
      read FMargin
      write SetMargin
      default -1;

    property Spacing: Integer
      read FSpacing
      write SetSpacing
      default 4;


    property OnMouseEnter: TNotifyEvent
      read FOnMouseEnter
      write FOnMouseEnter;

    property OnMouseLeave: TNotifyEvent
      read FOnMouseLeave
      write FOnMouseLeave;

    { Inherited Properties & Events }
    property Action;
    property Align;
    property Anchors;
    property Caption;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Height default 30;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property Width default 80;

    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;

    property OnMouseDown;

    {property OnMouseEnter;
    property OnMouseLeave;}

    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  //TProgressRange = Integer; // for backward compatibility

  //TProgressBarOrientation = (pbHorizontal, pbVertical);

  TBmpProgressBar = class(TCustomControl)
  private
    FBackGround: TBitmap;
    FProgress: TBitmap;
    FBar: TButtonBitmaps;

    FMax: Double;
    FPosition: Double;
    FShowBar: Boolean;

    FOrientation: TProgressBarOrientation;

    //FShowPercentHint: Boolean;
    FX, FY: Integer;

    FDown: Boolean;

    FOnChange: TNotifyEvent;

    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;

    FOnPaintBackGround: TPaintBackGround;
    FOnPaintProgress: TPaintProgress;

    procedure SetMax(Value: Double);
    procedure SetPosition(Value: Double);
    procedure SetOrientation(Value: TProgressBarOrientation);


    procedure BitmapChanged(Sender: TObject);

    procedure WMSize(var msg: TWMSize); message wm_Size;
    procedure CMMouseEnter(var Msg: TMessage); message cm_MouseEnter;
    procedure CMMouseLeave(var Msg: TMessage); message cm_MouseLeave;
  protected
    FState: TButtonState;
    FMouseOverButton: Boolean;
    procedure Paint; override;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;


    procedure SetProgress(Value: TBitmap); virtual;
    procedure SetBackGround(Value: TBitmap); virtual;
    procedure SetShowBar(Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Anchors;
    property BorderWidth;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Hint;
    property Constraints;

    property ShowBar: Boolean read FShowBar write SetShowBar;

    property BackGround: TBitmap read FBackGround write SetBackGround;
    property Progress: TBitmap read FProgress write SetProgress;
    property Bar: TButtonBitmaps read FBar write FBar;


    property Max: Double read FMax write SetMax;
    property Orientation: TProgressBarOrientation read FOrientation
      write SetOrientation default pbHorizontal;
    property ParentShowHint;
    property PopupMenu;
    property Position: Double read FPosition write SetPosition;

    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;

    property OnPaintBackGround: TPaintBackGround read FOnPaintBackGround write FOnPaintBackGround;
    property OnPaintProgress: TPaintProgress read FOnPaintProgress write FOnPaintProgress;

  end;


procedure Register;
implementation

uses
  Math, RzGrafx;


var
  Pattern: TBitmap;
  BmpButtonCount: Integer;


procedure Register;
begin
  RegisterComponents('Standard', [TBmpButton, TBmpProgressBar]);
end;

procedure CreateBrushPattern;
var
  X: Integer;
  Y: Integer;
begin
  Pattern := TBitmap.Create;
  Pattern.Width := 8;
  Pattern.Height := 8;
  with Pattern.Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := clBtnFace;
    FillRect(Rect(0, 0, Pattern.Width, Pattern.Height));
    for Y := 0 to 7 do
      for X := 0 to 7 do
        if (Y mod 2) = (X mod 2) then
          Pixels[X, Y] := clWhite;
  end;
end;


{&RT}
{==============================}
{== TButtonBitmaps Methods ==}
{==============================}

constructor TButtonBitmaps.Create;
begin
  FBitmaps := nil;
  FBitmap := TBitmap.Create;
  FBitmap.OnChange := BitmapsChanged;
  FColCount := 5;
  FRowCount := 1;
  FColWidth := 19;
  FRowHeight := 17;

  FUp := 0;
  FHot := 1;
  FDown := 2;
  FDisabled := 3;

  FTransparentColor := clOlive;
end;

destructor TButtonBitmaps.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FBitmaps) - 1 do
    FBitmaps[I].Free;
  FBitmaps := nil;
  FBitmap.Free;
  inherited;
end;

function TButtonBitmaps.GetBitmap(Index: Integer): TBitmap;
begin
  Result := nil;
  if (Index >= 0) and (Index < Length(FBitmaps)) then
    Result := FBitmaps[Index];
end;

procedure TButtonBitmaps.SetBitmaps;
var
  X, Y, nLen: Integer;
begin
  for Y := 0 to Length(FBitmaps) - 1 do
    FBitmaps[Y].Free;
  FBitmaps := nil;

  SetLength(FBitmaps, FColCount * FRowCount);
  for Y := 0 to FRowCount - 1 do begin
    for X := 0 to FColCount - 1 do begin
      nLen := X * FRowCount + Y;
      FBitmaps[nLen] := TBitmap.Create;
      FBitmaps[nLen].Assign(FBitmap);
      FBitmaps[nLen].PixelFormat := FBitmap.PixelFormat;
      FBitmaps[nLen].Width := FColWidth;
      FBitmaps[nLen].Height := FRowHeight;
      FBitmaps[nLen].Canvas.CopyRect(FBitmaps[nLen].Canvas.ClipRect, FBitmap.Canvas, Bounds(X * FColWidth, Y * FRowHeight, FColWidth, FRowHeight));
    end;
  end;
end;

procedure TButtonBitmaps.SetColCount(Value: Integer);
begin
  if FColCount <> Value then begin
    FColCount := Value;
    SetBitmaps;
  end;
end;

procedure TButtonBitmaps.SetRowCount(Value: Integer);
begin
  if FRowCount <> Value then begin
    FRowCount := Value;
    SetBitmaps;
  end;
end;

procedure TButtonBitmaps.SetColWidth(Value: Integer);
begin
  if FColWidth <> Value then begin
    FColWidth := Value;
    SetBitmaps;
  end;
end;

procedure TButtonBitmaps.SetRowHeight(Value: Integer);
begin
  if FRowHeight <> Value then begin
    FRowHeight := Value;
    SetBitmaps;
  end;
end;

procedure TButtonBitmaps.SetDisabled(Value: Integer);
begin
  FDisabled := Value;
  if FDisabled > FColCount * FRowCount then
    FDisabled := FColCount * FRowCount - 1;
end;

procedure TButtonBitmaps.SetUp(Value: Integer);
begin
  FUp := Value;
  if FUp > FColCount * FRowCount then
    FUp := FColCount * FRowCount - 1;
end;

procedure TButtonBitmaps.SetDown(Value: Integer);
begin
  FDown := Value;
  if FDown > FColCount * FRowCount then
    FDown := FColCount * FRowCount - 1;
end;

procedure TButtonBitmaps.SetHot(Value: Integer);
begin
  FHot := Value;
  if FHot > FColCount * FRowCount then
    FHot := FColCount * FRowCount - 1;
end;

procedure TButtonBitmaps.SetBitmap(Value: TBitmap);
begin
  FBitmap.Assign(Value);
end;

procedure TButtonBitmaps.BitmapsChanged(Sender: TObject);
begin
  SetBitmaps;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TButtonBitmaps.SetTransparentColor(Value: TColor);
begin
  if FTransparentColor <> Value then
  begin
    FTransparentColor := Value;
    BitmapsChanged(Self);
  end;
end;


{==========================}
{== TBmpButton Methods ==}
{==========================}

constructor TBmpButton.Create(AOwner: TComponent);
begin
  inherited;
  Width := 80;
  Height := 30;
  ControlStyle := [csCaptureMouse, csOpaque, csDoubleClicks];

  FBitmaps := TButtonBitmaps.Create;
  FBitmaps.OnChange := BitmapChanged;

  FColor := clBtnFace;
  FButtonBorder := bbNone;
  ParentFont := True;
  FSpacing := 4;
  FMargin := -1;
  FLayout := blGlyphLeft;
  FShowFocus := True;
  FShowDownPattern := True;
  FButtonSize := bszButtonToBitmap;
  TabStop := True;
  IsFocused := False;
  Inc(BmpButtonCount);
  FCaptionDownOffset := 1;
  FMouseOverButton := False;
  {&RCI}
end;


destructor TBmpButton.Destroy;
begin
  FBitmaps.Free;
  Dec(BmpButtonCount);
  if BmpButtonCount = 0 then
  begin
    Pattern.Free;
    Pattern := nil;
  end;
  inherited;
end;


procedure TBmpButton.Loaded;
var
  Msg: TWMSize;
begin
  inherited;
  WMSize(Msg);
end;


procedure TBmpButton.BitmapChanged(Sender: TObject);
var
  Msg: TWMSize;
begin
  {&RV}
  if FButtonSize = bszButtonToBitmap then
    WMSize(Msg);
  Invalidate;
end;

procedure TBmpButton.WMSize(var msg: TWMSize);
var
  Bevel: Integer;
  UpBmp: TBitmap;
begin
  if csLoading in ComponentState then
    Exit;

  Bevel := 0;
  UpBmp := FBitmaps.Bitmaps[FBitmaps.Up];
  if (FButtonSize <> bszNeither) and ((UpBmp <> nil) and (UpBmp.handle <> 0)) then
  begin
    if FButtonSize = bszButtonToBitmap then
    begin
      case FButtonBorder of
        bbNone:
          Bevel := 0;

        bbSingle:
          Bevel := 1;

        bbButton:
          if ((FButtonStyle = bsAutoDetect) and NewStyleControls) or (FButtonStyle = bsNew) then
            Bevel := 2
          else
            Bevel := 3;
      end;
      Width := UpBmp.Width + (Bevel shl 1);
      Height := UpBmp.Height + (Bevel shl 1);
    end;
    Invalidate;
  end;
end; {= TBmpProgressBar.WMSize =}


procedure TBmpButton.WMSetFocus(var msg: TWMSetFocus);
begin
  inherited;
  IsFocused := True;
  Invalidate;
end;

procedure TBmpButton.WMKillFocus(var msg: TWMKillFocus);
begin
  inherited;
  IsFocused := False;
  Invalidate;
end;



procedure TBmpButton.Paint;
var
  TempBmp, MemImage, DisabledBmp, MonoBmp, UpBmp, DownBmp, HotBmp, DisBmp: TBitmap;
  PaintRect, OrigRect, TextRect, Src, DRect: TRect;
  NewStyle: Boolean;
  Bevel: Integer;
begin
  { Create Memory Bitmap }
  MemImage := TBitmap.Create;
  try
    { Make memory Bitmap same size as client rect }
    MemImage.Height := Height;
    MemImage.Width := Width;

    if (not Enabled) and (not (csDesigning in ComponentState)) then
    begin
      FState := bsDisabled;
      FDragging := False;
    end
    else if FState = bsDisabled then
    begin
      if Down then
        FState := bsDown
      else
        FState := bsUp;
    end;

    NewStyle := ((FButtonStyle = bsAutoDetect) and NewStyleControls) or (FButtonStyle = bsNew);

    if NewStyle then
      Bevel := 1
    else
      Bevel := 2;

    PaintRect := ClientRect;
    MemImage.Canvas.Brush.Color := FColor;

    case FButtonBorder of
      bbNone:
        begin
        { Fill background of MemImage with contents of background }
          DrawParentImage(Self, MemImage.Canvas);
          Sleep(10); { Need to allow short time to get image }

          if csDesigning in ComponentState then
          begin
            with MemImage.Canvas do
            begin
              Pen.Style := psDot;
              Brush.Style := bsClear;
              with ClientRect do
                Rectangle(Left, Top, Right, Bottom);
            end;
          end;
        end;

      bbSingle:
        begin
          MemImage.Canvas.FillRect(PaintRect);
          MemImage.Canvas.Brush.Color := clBlack;
          MemImage.Canvas.FrameRect(PaintRect);
          InflateRect(PaintRect, -1, -1);
        end;

      bbButton:
        begin
          PaintRect := DrawButtonFace(MemImage.Canvas, ClientRect, Bevel, FButtonStyle,
            not NewStyle, FState in [bsDown, bsExclusive],
            (IsFocused and FShowFocus));
          InflateRect(PaintRect, -1, -1);
        end;
    end; { case FButtonBorder }

    OrigRect := PaintRect;
    { Is the button going to stay down }
    if FState = bsExclusive then
    begin
      if FShowDownPattern then
      begin
        if Pattern = nil then
          CreateBrushPattern;
        MemImage.Canvas.Brush.Bitmap := Pattern;
      end;

      Dec(PaintRect.Right);
      Dec(PaintRect.Bottom);
      if NewStyle then
      begin
        Dec(PaintRect.Right);
        Dec(PaintRect.Bottom);
      end;
      InflateRect(PaintRect, Bevel, Bevel);
      if FButtonBorder <> bbNone then
        MemImage.Canvas.FillRect(PaintRect);
      InflateRect(PaintRect, -Bevel, -Bevel);

      if NewStyle then
      begin
        Inc(PaintRect.Right);
        Inc(PaintRect.Bottom);
      end;
      Inc(PaintRect.Right);
      Inc(PaintRect.Bottom);
    end;

    { Process any Bitmaps }

    UpBmp := FBitmaps.Bitmaps[FBitmaps.Up];
    DownBmp := FBitmaps.Bitmaps[FBitmaps.Down];
    HotBmp := FBitmaps.Bitmaps[FBitmaps.Hot];
    DisBmp := FBitmaps.Bitmaps[FBitmaps.Disabled];
    if ((UpBmp <> nil) and (UpBmp.Handle <> 0)) or
      (((DisBmp <> nil) and (DisBmp.Handle <> 0)) and (FState = bsDisabled)) then
    begin
      DisabledBmp := TBitmap.Create;
      try
        { Choose/Create the correct Bitmap to display }
        case FState of
          bsUp:
            begin
              if FMouseOverButton and ((HotBmp <> nil) and (HotBmp.Handle <> 0)) then
                TempBmp := HotBmp
             { else if IsFocused and FShowFocus and (FBitmaps.UpAndFocused.Handle <> 0) then
                TempBmp := FBitmaps.UpAndFocused }
              else
                TempBmp := UpBmp;
            end;

          bsDisabled:
            begin
              if (DisBmp = nil) or (DisBmp.Handle = 0) then
              begin
              { Create a DisabledBmp version of Bitmap }
                DisabledBmp.Width := UpBmp.Width;
                DisabledBmp.Height := UpBmp.Height;
                MonoBmp := TBitmap.Create;
                try
                  with MonoBmp do
                  begin
                    Assign(UpBmp);
                    Canvas.Brush.Color := clBlack;
                    if Monochrome then
                    begin
                      Canvas.Font.Color := clWhite;
                      Monochrome := False;
                      Canvas.Brush.Color := clWhite;
                    end;
                    Monochrome := True;
                  end;
                  with DisabledBmp.Canvas do
                  begin
                    Brush.Color := clBtnFace;
                    DRect := Bounds(0, 0, DisabledBmp.width, DisabledBmp.height);
                    FillRect(DRect);
                    Brush.Color := clBlack;
                    Font.Color := clWhite;
                    CopyMode := MergePaint;
                    Draw(DRect.Left + 1, DRect.Top + 1, MonoBmp);
                    CopyMode := SrcAnd;
                    Draw(DRect.Left, DRect.Top, MonoBmp);
                    Brush.Color := clBtnShadow;
                    Font.Color := clBlack;
                    CopyMode := SrcPaint;
                    Draw(DRect.Left, DRect.Top, MonoBmp);
                    CopyMode := SrcCopy;
                  end;
                finally
                  MonoBmp.Free;
                end;
                TempBmp := DisabledBmp;
              end
              else
                TempBmp := DisBmp;
            end; { bsDisabled }

          bsDown:
            begin
              if (DownBmp = nil) or (DownBmp.Handle = 0) then
                TempBmp := UpBmp
              else
                TempBmp := DownBmp;
            end;

          bsExclusive:
            begin
              TempBmp := UpBmp;
             { if FBitmaps.StayDown.Handle = 0 then
              begin
                if FBitmaps.Down.Handle = 0 then
                  TempBmp := FBitmaps.Up
                else
                  TempBmp := FBitmaps.Down;
              end
              else
                TempBmp := FBitmaps.StayDown;   }
            end;

        else
          TempBmp := DisBmp;
        end; { case FState }

        CalcLayout(TextRect, PaintRect, TempBmp);

        { Draw Bitmap }
        case FButtonSize of
          bszNeither:
            begin
              Src := Bounds(0, 0, TempBmp.Width, TempBmp.Height);
              DrawTransparentBitmap(MemImage.Canvas, TempBmp, PaintRect, Src, FBitmaps.TransparentColor);
            end;

          bszButtonToBitmap:
            begin
              Src := Bounds(0, 0, TempBmp.Width, TempBmp.Height);
              DrawFullTransparentBitmap(MemImage.Canvas, TempBmp, PaintRect, Src, FBitmaps.TransparentColor);

            (*
            // In future, may want to introduce a Transparent Property to increase performance
            if FTransparent then
              DrawFullTransparentBitmap( MemImage.Canvas, TempBmp, PaintRect, Src, FBitmaps.TransparentColor )
            else
              MemImage.Canvas.Draw( 0, 0, TempBmp );
            *)
            end;

          bszStretchToButton:
            StretchTransparentBitmap(MemImage.Canvas, TempBmp, PaintRect, FBitmaps.TransparentColor);

          bszTileToButton:
            TileTransparentBitmap(MemImage.Canvas, TempBmp, PaintRect, FBitmaps.TransparentColor);

        end; { case FButtonSize }

      finally
        DisabledBmp.Free;
      end;
    end
    else
      CalcLayout(TextRect, PaintRect, nil);

    MemImage.Canvas.Font := Self.Font;

    { Put Caption on Button }
    if Caption <> '' then
    begin
      MemImage.Canvas.Brush.Style := bsClear;
      if FState = bsDisabled then
      begin
        OffsetRect(TextRect, 1, 1);
        MemImage.Canvas.Font.Color := clWhite;
        DrawText(MemImage.Canvas.Handle, PChar(Caption), Length(Caption), TextRect,
          DT_CENTER or DT_VCENTER or DT_SINGLELINE);
        OffsetRect(TextRect, -1, -1);
        MemImage.Canvas.Font.Color := clDkGray;
        DrawText(MemImage.Canvas.Handle, PChar(Caption), Length(Caption), TextRect,
          DT_CENTER or DT_VCENTER or DT_SINGLELINE);
      end
      else
      begin
        if (FState = bsDown) or (FState = bsExclusive) then
          OffsetRect(TextRect, FCaptionDownOffset, FCaptionDownOffset);
        DrawText(MemImage.Canvas.Handle, PChar(Caption), -1, TextRect, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
        MemImage.Canvas.Font.Color := clWindowText;
      end;

      if IsFocused and FShowFocus then
      begin
        MemImage.Canvas.Brush.Color := clBtnFace;
        InflateRect(TextRect, 2, 2);
        DrawFocusRect(MemImage.Canvas.Handle, TextRect);
      end;
    end;

    Canvas.CopyMode := cmSrcCopy;
    Canvas.Draw(0, 0, MemImage);
  finally
    MemImage.Free;
  end;
end; {= TBmpButton.Paint =}


procedure TBmpButton.CalcLayout(var TextBounds: TRect; var PaintRect: TRect;
  Bitmap: TBitmap);
var
  TextPos: TPoint;
  ClientSize: TPoint;
  BitmapSize: TPoint;
  TextSize: TPoint;
  TotalSize: TPoint;
  Pos: TPoint;
  Spacing: Integer;
  Margin: Integer;
begin
  Canvas.Font := Self.Font;
  { Calculate the item sizes }
  ClientSize := Point(PaintRect.Right - PaintRect.Left, PaintRect.Bottom - PaintRect.Top);

  if (Bitmap <> nil) and (Bitmap.Handle <> 0) and (FButtonSize = bszNeither) then
    BitmapSize := Point(Bitmap.Width, Bitmap.Height)
  else
    BitmapSize := Point(0, 0);

  if Length(Caption) > 0 then
  begin
    TextBounds := Rect(0, 0, ClientSize.x, 0);
    DrawText(Canvas.Handle, PChar(Caption), -1, TextBounds, DT_CALCRECT);
  end
  else
    TextBounds := Rect(0, 0, 0, 0);

  TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom - TextBounds.Top);

  if Layout in [blGlyphLeft, blGlyphRight] then
  begin
    Pos.Y := (ClientSize.Y div 2) - (BitmapSize.Y div 2);
    TextPos.Y := (ClientSize.Y div 2) - (TextSize.Y div 2);
  end
  else
  begin
    Pos.X := (ClientSize.X div 2) - (BitmapSize.X div 2);
    TextPos.X := (ClientSize.X div 2) - (TextSize.X div 2);
  end;

  Spacing := FSpacing;
  Margin := FMargin;

  { If there is no text or no Bitmap, then Spacing is irrelevant }

  if (TextSize.X = 0) or (BitmapSize.X = 0) then
    Spacing := 0;

  { Adjust Margin and Spacing }

  if Margin = -1 then
  begin
    if Spacing = -1 then
    begin
      TotalSize := Point(BitmapSize.X + TextSize.X, BitmapSize.Y + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.X - TotalSize.X) div 3
      else
        Margin := (ClientSize.Y - TotalSize.Y) div 3;

      Spacing := Margin;
    end
    else
    begin
      TotalSize := Point(BitmapSize.X + Spacing + TextSize.X, BitmapSize.Y + Spacing + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.X div 2) - (TotalSize.X div 2)
      else
        Margin := (ClientSize.Y div 2) - (TotalSize.Y div 2);
    end;
  end
  else
  begin
    if Spacing = -1 then
    begin
      TotalSize := Point(ClientSize.X - (Margin + BitmapSize.X), ClientSize.Y - (Margin + BitmapSize.Y));
      if Layout in [blGlyphLeft, blGlyphRight] then
        Spacing := (TotalSize.X div 2) - (TextSize.X div 2)
      else
        Spacing := (TotalSize.Y div 2) - (TextSize.Y div 2);
    end;
  end;

  case FLayout of
    blGlyphLeft:
      begin
        Pos.X := Margin;
        TextPos.X := Pos.X + BitmapSize.X + Spacing;
      end;

    blGlyphRight:
      begin
        Pos.X := ClientSize.X - Margin - BitmapSize.X;
        TextPos.X := Pos.X - Spacing - TextSize.X;
      end;

    blGlyphTop:
      begin
        Pos.Y := Margin;
        TextPos.Y := Pos.Y + BitmapSize.Y + Spacing;
      end;

    blGlyphBottom:
      begin
        Pos.Y := ClientSize.Y - Margin - BitmapSize.Y;
        TextPos.Y := Pos.Y - Spacing - TextSize.Y;
      end;
  end; { case Layout }

  OffsetRect(TextBounds, TextPos.X + PaintRect.Left, TextPos.Y + PaintRect.Top);

  if (BitmapSize.x <> 0) and (BitmapSize.y <> 0) then
  begin
    Inc(Pos.X, PaintRect.Left);
    Inc(Pos.Y, PaintRect.Top);
    PaintRect := Rect(Pos.X, Pos.Y, Pos.X + BitmapSize.X, Pos.Y + BitmapSize.Y);
  end;

end; {= TBmpButton.CalcLayout =}



procedure TBmpButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Return then
    Click;

  if (Key = vk_Space) and Enabled then
  begin
    if not FDown then
    begin
      FState := bsDown;
      Repaint;
    end;
    FDragging := True;
  end;
end;

procedure TBmpButton.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;

  if FDragging then
  begin
    FDragging := False;
    FState := bsUp;
    ClickButton(True);
  end;
end;


procedure TBmpButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  if Enabled and {not FDown and} not IsFocused and IsWindowVisible(Handle) then
    Windows.SetFocus(Handle);

  if (Button = mbLeft) and Enabled and Focused then
  begin
    if not FDown then
    begin
      FState := bsDown;
      Repaint;
    end;
    FDragging := True;
  end;
end;


procedure TBmpButton.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewState: TButtonState;
begin
  inherited;

  if FDragging then
  begin
    if not FDown then
      NewState := bsUp
    else
      NewState := bsExclusive;

    if (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight) then
      if FDown then
        NewState := bsExclusive
      else
        NewState := bsDown;

    if NewState <> FState then
    begin
      FState := NewState;
      Repaint;
    end;
  end;
end; {= TBmpButton.MouseMove =}


procedure TBmpButton.ClickButton(DoClick: Boolean);
begin
  if FGroupIndex = 0 then
    Repaint
  else if DoClick then
    SetDown(not FDown)
  else
  begin
    if FDown then
    begin
      FState := bsExclusive;
    end;
    Repaint;
  end;

  if DoClick then
    Click;
end;

procedure TBmpButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  DoClick: Boolean;
begin
  inherited;
  if FDragging then
  begin
    FDragging := False;
    DoClick := (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);
    UpdateExclusive;

    ClickButton(DoClick);
  end;
end; {= TBmpButton.MouseUp =}


procedure TBmpButton.Click;
var
  Form: TCustomForm;
begin
  {&RV}
  Form := GetParentForm(Self);
  if Form <> nil then
    Form.ModalResult := ModalResult;
  inherited;
end;


function TBmpButton.GetPalette: HPALETTE;
begin
  Result := FBitmaps.Bitmap.Palette;
end;


procedure TBmpButton.UpdateExclusive;
var
  Msg: TMessage;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin
    Msg.Msg := cm_BmpButtonPressed;
    Msg.WParam := FGroupIndex;
    Msg.LParam := Longint(Self);
    Msg.Result := 0;
    Parent.Broadcast(Msg);
  end
  else
    FState := bsUp;
end;


procedure TBmpButton.SetCaptionDownOffset(Value: Integer);
begin
  if FCaptionDownOffset <> Value then
  begin
    FCaptionDownOffset := Value;
    Invalidate;
  end;
end;


procedure TBmpButton.SetDown(Value: Boolean);
begin
  if FGroupIndex = 0 then
    Value := False;

  if Value <> FDown then
  begin
    if FDown and (not FAllowAllUp) then
      Exit;

    FDown := Value;
    if Value then
    begin
      FState := bsExclusive;
    end
    else
    begin
      FState := bsUp;
    end;

    Invalidate;

    if Value then
      UpdateExclusive;
  end;
end; {= TBmpButton.SetDown =}


procedure TBmpButton.SetGroupIndex(Value: Integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;


procedure TBmpButton.SetLayout(Value: TButtonLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TBmpButton.SetMargin(Value: Integer);
begin
  if (FMargin <> Value) and (Value >= -1) then
  begin
    FMargin := Value;
    Invalidate;
  end;
end;

procedure TBmpButton.SetSpacing(Value: Integer);
begin
  if FSpacing <> Value then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

procedure TBmpButton.SetAllowAllUp(Value: Boolean);
begin
  if FAllowAllUp <> Value then
  begin
    FAllowAllUp := Value;
    UpdateExclusive;
  end;
end;


procedure TBmpButton.SetShowDownPattern(Value: Boolean);
begin
  if FShowDownPattern <> Value then
  begin
    FShowDownPattern := Value;
    Invalidate;
  end;
end;


procedure TBmpButton.SetShowFocus(Value: Boolean);
begin
  if FShowFocus <> Value then
  begin
    FShowFocus := Value;
    Invalidate;
  end;
end;


procedure TBmpButton.WMLButtonDblClk(var Msg: TWMLButtonDown);
begin
  inherited;
  if FDown then
    DblClick;
end;


procedure TBmpButton.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  Invalidate;
end;


procedure TBmpButton.CMButtonExtPressed(var Msg: TMessage);
var
  Sender: TBmpButton;
begin
  if Msg.WParam = FGroupIndex then
  begin
    Sender := TBmpButton(Msg.LParam);
    if Sender <> Self then
    begin
      if Sender.Down and FDown then
      begin
        FDown := False;
        FState := bsUp;
        Invalidate;
      end;

      FAllowAllUp := Sender.AllowAllUp;
    end;
  end;
end;


procedure TBmpButton.CMDialogChar(var Msg: TCMDialogChar);
begin
  with Msg do
  begin
    if IsAccel(CharCode, Caption) and Enabled then
    begin
      Click;
      Result := 1;
    end
    else
      inherited;
  end;
end;


procedure TBmpButton.CMFontChanged(var Msg: TMessage);
begin
  Invalidate;
end;

procedure TBmpButton.CMTextChanged(var Msg: TMessage);
begin
  Invalidate;
end;

procedure TBmpButton.CMSysColorChange(var Msg: TMessage);
begin
  Invalidate;
end;

procedure TBmpButton.SetButtonStyle(Value: TButtonStyle);
var
  Msg: TWMSize;
begin
  if FButtonStyle <> Value then
  begin
    FButtonStyle := Value;
    WMSize(Msg);
    Invalidate;
  end;
end;

procedure TBmpButton.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Invalidate;
  end;
end;

procedure TBmpButton.SetButtonBorder(Value: TButtonBorder);
var
  Msg: TWMSize;
begin
  if FButtonBorder <> Value then
  begin
    FButtonBorder := Value;
    WMSize(Msg);
    Invalidate;
  end;
end;

procedure TBmpButton.SetButtonSize(Value: TBtnSize);
var
  Msg: TWMSize;
begin
  if FButtonSize <> Value then
  begin
    FButtonSize := Value;
    WMSize(Msg);
    Invalidate;
  end;
end;


procedure TBmpButton.CMMouseEnter(var Msg: TMessage);
var
  HotBmp: TBitmap;
begin
{$IFDEF VCL70_OR_HIGHER}
  if csDesigning in ComponentState then
    Exit;
{$ENDIF}

  FMouseOverButton := True;

  inherited;
{$IFNDEF VCL100_OR_HIGHER}
  // Manually generate OnMouseEnter event for Delphi 2005 and earlier
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
{$ENDIF}
  HotBmp := FBitmaps.Bitmaps[FBitmaps.Hot];
  if (HotBmp <> nil) and (HotBmp.Handle <> 0) then
    Invalidate;
end;


procedure TBmpButton.CMMouseLeave(var Msg: TMessage);
var
  HotBmp: TBitmap;
begin
  FMouseOverButton := False;

  inherited;
{$IFNDEF VCL100_OR_HIGHER}
  // Manually generate OnMouseLeave event for Delphi 2005 and earlier
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
{$ENDIF}

  HotBmp := FBitmaps.Bitmaps[FBitmaps.Hot];
  if (HotBmp <> nil) and (HotBmp.Handle <> 0) then
    Invalidate;
end;


procedure TBmpButton.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
begin
  // Do not call inherited -- prevents TWinControl.WMEraseBkgnd from
  // erasing background. Set Msg.Result to 1 to indicate background is painted
  // by the control.
  Msg.Result := 1;
end;



constructor TBmpProgressBar.Create(AOwner: TComponent);
var
  R: TRect;
  Bitmap: TBitmap;
begin
  inherited;
  ParentShowHint := False;
  Width := 100;
  Height := 16;

  FX := 0;
  FY := 0;

  FMax := 100.00;
  FPosition := 0.0;
  FOrientation := pbHorizontal;
  ControlStyle := [csCaptureMouse, csOpaque, csDoubleClicks];

  FOnPaintBackGround := nil;
  FOnPaintProgress := nil;

  FDown := False;

  FBackGround := TBitmap.Create;
  FBackGround.PixelFormat := pf32bit;
  FBackGround.OnChange := BitmapChanged;
  FBackGround.Width := Width;
  FBackGround.Height := Height;
  if not (csDesigning in ComponentState) then begin
    with FBackGround.Canvas do
    begin
      Brush.Color := clBtnFace;
      R := ClientRect;
      FillRect(R);
    end;
  end;
  FProgress := TBitmap.Create;
  FProgress.PixelFormat := pf32bit;
  FProgress.OnChange := BitmapChanged;
  FProgress.Width := 10;
  FProgress.Height := Height;

  if not (csDesigning in ComponentState) then begin
    with FProgress.Canvas do
    begin
      Brush.Color := clTeal; //clGradientActiveCaption;
      R := ClientRect;
      FillRect(R);
    end;
  end;

  FBar := TButtonBitmaps.Create;
  FBar.OnChange := BitmapChanged;

  Bitmap := TBitmap.Create;
  Bitmap.Width := 12 * 4;
  Bitmap.Height := Height;

  if not (csDesigning in ComponentState) then begin
    with Bitmap.Canvas do
    begin
      Brush.Color := clWhite;
      R := ClientRect;
      FillRect(R);
    end;
  end;

  FBar.Bitmap := Bitmap;
  FBar.ColCount := 4;
  FBar.RowCount := 1;
  FBar.ColWidth := 12;
  FBar.RowHeight := Height;
  FBar.Up := 0;
  FBar.Hot := 1;
  FBar.Down := 2;
  FBar.Disabled := 3;
  Bitmap.Free;

  FShowBar := False;
end;

destructor TBmpProgressBar.Destroy;
begin
  if Assigned(FProgress) then FProgress.Free;
  if Assigned(FBackGround) then FBackGround.Free;
  if Assigned(FBar) then FBar.Free;
  inherited;
end;

procedure TBmpProgressBar.CMMouseEnter(var Msg: TMessage);
begin
  if csDesigning in ComponentState then
    Exit;

  FMouseOverButton := True;

  inherited;

  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);

  Invalidate;
  //Repaint;
end;


procedure TBmpProgressBar.CMMouseLeave(var Msg: TMessage);
begin
  FMouseOverButton := False;

  inherited;

  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);

  Invalidate;
  //Repaint;
end;


procedure TBmpProgressBar.BitmapChanged(Sender: TObject);
begin
  if csLoading in ComponentState then
    Exit;
  Invalidate;
  //Repaint;
end;

procedure TBmpProgressBar.WMSize(var msg: TWMSize);
begin
  if csLoading in ComponentState then
    Exit;
  Invalidate;
  //Repaint;
end; {= TBmpProgressBar.WMSize =}

procedure TBmpProgressBar.Paint;
var
  BarLen, Percent: Integer;
  Buffer, Bitmap, TempBmp, UpBmp, DownBmp, HotBmp, DisBmp: TBitmap;
  PaintRect, ProgressRect, BarRect, R: TRect;
  AParent: Double;
  sPosition: string;
begin
  if (Width <= 0) or (Height <= 0) then Exit;

  Buffer := TBitmap.Create;
  Buffer.Width := Width;
  Buffer.Height := Height;

 { with Buffer.Canvas do
  begin
    Brush.Color := clWhite;
    //R := ClientRect;
    FillRect(ClipRect);
  end; }

  PaintRect := Buffer.Canvas.ClipRect;

  if Assigned(FOnPaintBackGround) then
    FOnPaintBackGround(Self, Buffer)
  else
    StretchTransparentBitmap(Buffer.Canvas, FBackGround, PaintRect, FBackGround.TransparentColor);

  BarLen := 0;
  Percent := 0;
  if FShowBar then begin
    Bitmap := Bar.Bitmaps[Bar.Up];
    if (Bitmap <> nil) and (Bitmap.Canvas.Handle <> 0) then
      BarLen := Bitmap.Width;
  end;

  ProgressRect := PaintRect;

  if FOrientation = pbHorizontal then begin
    Percent := Trunc((Buffer.Width - BarLen) * FPosition / FMax);
    ProgressRect.Right := ProgressRect.Left + Percent;
  end else begin
    Percent := Trunc((Buffer.Height - BarLen) * FPosition / FMax);
    ProgressRect.Bottom := ProgressRect.Top + Percent;
  end;

  if Assigned(FOnPaintProgress) then
    FOnPaintProgress(Self, Buffer)
  else
    if (FProgress <> nil) and (FProgress.Canvas.Handle <> 0) then
    StretchTransparentBitmap(Buffer.Canvas, FProgress, ProgressRect, FProgress.TransparentColor);

  if FShowBar then begin
    TempBmp := nil;
    UpBmp := FBar.Bitmaps[FBar.Up];
    DownBmp := FBar.Bitmaps[FBar.Down];
    HotBmp := FBar.Bitmaps[FBar.Hot];
    DisBmp := FBar.Bitmaps[FBar.Disabled];
    case FState of
      bsUp: begin
          TempBmp := UpBmp;
        end;
      bsExclusive: begin
          if (not FDown) and FMouseOverButton and ((HotBmp <> nil) and (HotBmp.Handle <> 0)) then
            TempBmp := HotBmp
          else
            TempBmp := UpBmp;
        end;
      bsDisabled: begin
          TempBmp := DisBmp;
        end;
      bsDown: TempBmp := DownBmp;
    else TempBmp := HotBmp;
    end;

    if TempBmp = nil then
      TempBmp := UpBmp;

    R := Bounds(0, 0, TempBmp.Width, TempBmp.Height);
    if FOrientation = pbHorizontal then begin
      BarRect.Left := ProgressRect.Right;
      BarRect.Right := BarRect.Left + TempBmp.Width;
      BarRect.Top := PaintRect.Top + (Buffer.Height - TempBmp.Height) div 2;
      BarRect.Bottom := BarRect.Top + TempBmp.Height;
    end else begin
      BarRect.Top := ProgressRect.Bottom;
      BarRect.Bottom := BarRect.Top + TempBmp.Height;

      BarRect.Left := PaintRect.Left + (Buffer.Width - TempBmp.Width) div 2;
      BarRect.Right := BarRect.Left + TempBmp.Width;
    end;

    if (TempBmp <> nil) and (TempBmp.Canvas.Handle <> 0) then
      DrawTransparentBitmap(Buffer.Canvas, TempBmp, BarRect, R, FBar.TransparentColor);
  end;

  if ParentShowHint then begin
    AParent := FPosition * 100 / FMax;
    sPosition := FormatFloat('0.00', AParent) + '%';
    Buffer.Canvas.Font := Font;
    SetBkMode(Buffer.Canvas.Handle, TRANSPARENT);
    with Buffer.Canvas do begin
      TextOut((Width - TextWidth(sPosition)) div 2, (Height - TextHeight(sPosition)) div 2, sPosition);
    end;
  end;

  Canvas.Draw(0, 0, Buffer);

  Buffer.Free;
end;

procedure TBmpProgressBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  NewState: TButtonState;
  BarLen: Integer;
  BarBmp: TBitmap;
  BarLeft: Integer;
begin
  inherited;

  if Enabled and {not FDown and} {not IsFocused and }  IsWindowVisible(Handle) then
    Windows.SetFocus(Handle);

  if (Button = mbLeft) and Enabled and Focused then begin
    if not FDown then begin
      FX := X;
      FY := Y;
      FDown := True;
      FState := bsDown;


      BarLen := 0;
      if FShowBar then begin
        BarBmp := FBar.Bitmaps[FBar.Up];
        if (BarBmp <> nil) and (BarBmp.Canvas.Handle <> 0) then
          BarLen := BarBmp.Width;


        if FOrientation = pbHorizontal then begin
          BarLeft := Trunc((Width - BarLen) * FPosition / FMax);
          if (X >= BarLeft) and (X <= BarLeft + BarLen) then begin

          end else begin
            if X >= ClientWidth - BarLen div 2 then
              Position := FMax
            else
              if X <= 0 then
              Position := 0.0
            else begin
              Position := FMax * X / ClientWidth;
            end;
          end;
        end else begin
          if (Y >= BarLeft) and (Y <= BarLeft + BarLen) then begin

          end else begin
            if Y >= ClientHeight then
              Position := FMax
            else
              if Y <= 0 then
              Position := 0.0
            else begin
              Position := FMax * Y / ClientHeight;
            end;
          end;
        end;
      end;
      Repaint;
    end;
  end;
end;

procedure TBmpProgressBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewState: TButtonState;
  BarLen, Len, nMin, nMax, nX, nY: Integer;
  BarBmp: TBitmap;
begin
  inherited;
  if Enabled then begin
    if not FDown then
      NewState := bsExclusive //bsUp
    else
      NewState := bsDown;

    if (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight) then
      if FDown then begin
        NewState := bsDown;
        if (FX <> X) or (FY <> Y) then begin
          FX := X;
          FY := Y;

          BarLen := 0;

          if FShowBar then begin
            BarBmp := FBar.Bitmaps[FBar.Up];
            if (BarBmp <> nil) and (BarBmp.Canvas.Handle <> 0) then
              BarLen := BarBmp.Width;


            if FOrientation = pbHorizontal then begin
              if X >= ClientWidth - BarLen div 2 then
                Position := FMax
              else
                if X <= 0 then
                Position := 0.0
              else begin
                Position := FMax * X / ClientWidth;
              end;
            end else begin
              if Y >= ClientHeight then
                Position := FMax
              else
                if Y <= 0 then
                Position := 0.0
              else begin
                Position := FMax * Y / ClientHeight;
              end;
            end;
          end;
        end;
      end else NewState := bsExclusive;

    if NewState <> FState then
    begin
      FState := NewState;
      Repaint;
    end;
  end;
end; {= TBmpProgressBar.MouseMove =}

procedure TBmpProgressBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Enabled then begin
    FDown := False;
    if FState <> bsUp then begin
      FState := bsUp;
      Repaint;
    end;
  end;
end;

procedure TBmpProgressBar.SetShowBar(Value: Boolean);
begin
  if FShowBar <> Value then begin
    FShowBar := Value;
    Repaint;
  end;
end;

procedure TBmpProgressBar.SetProgress(Value: TBitmap);
begin
  FProgress.Assign(Value);
  //Repaint;
end;

procedure TBmpProgressBar.SetBackGround(Value: TBitmap);
begin
  FBackGround.Assign(Value);
  //Repaint;
end;

procedure TBmpProgressBar.SetMax(Value: Double);
begin
  if FMax <> Value then begin
    FMax := Value;
   { if csLoading in ComponentState then
      Exit;}
    Repaint;
  end;
end;

procedure TBmpProgressBar.SetPosition(Value: Double);
begin
  if FPosition <> Value then begin
    FPosition := Value;
    if FPosition > FMax then
      FPosition := FMax;
    if FPosition < 0 then
      FPosition := 0;
   // if not (csLoading in ComponentState) then
    Repaint;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TBmpProgressBar.SetOrientation(Value: TProgressBarOrientation);
var
  nWidth, nHeight: Integer;
begin
  if FOrientation <> Value then begin
    nWidth := Width;
    nHeight := Height;
    Width := nHeight;
    Height := nWidth;
    FOrientation := Value;
    //if not (csLoading in ComponentState) then
    Repaint;
  end;
end;

end.

