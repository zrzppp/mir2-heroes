{===============================================================================
  RzForms Unit

  Raize Components - Component Source Unit

  Copyright © 1995-2007 by Raize Software, Inc.  All Rights Reserved.


  Components
  ------------------------------------------------------------------------------
  TRzFormState
    Automatically stores the position, size, and state (maximized or normal) of
    a form.

  TRzFormShape
    Custom image component that removes transparent areas of the image from the
    form itself.


  Modification History
  ------------------------------------------------------------------------------
  4.1    (15 Dec 2006)
    * Restoring a maximized MDI Child form no longer results in a maximize-
      restore-maximize sequence when using the TRzFormState on the MDI Child.
  ------------------------------------------------------------------------------
  4.0.3  (05 Apr 2006)
    * Fixed problem where TRzFromShape would not honor the Transparent property
      setting.
    * Added Enabled property to TRzFormState. Set this property to False, to
      stop the component from restoring or saving the current state of the form.
  ------------------------------------------------------------------------------
  3.0.10 (26 Dec 2003)
    * Added the TRzFormShape.RecreateRegion method that can be called after
      assigning a new image to the control so that a new region is created to
      shape the form.
  ------------------------------------------------------------------------------
  3.0.8  (29 Aug 2003)
    * Fixed problem where form position was not restored correctly when Task Bar
      was positioned at top of screen.
    * TRzFormState now verifies that a saved form is restored to a valid
      monitor.
    * Added TRzFormState.ValidMonitorAtPoint method in order to support
      differences between Delphi 5 and later versions of Delphi.
  ------------------------------------------------------------------------------
  3.0.6  (11 Apr 2003)
    * TRzFormState now only stores the Width and Height of a form if the form is
      resizable.
  ------------------------------------------------------------------------------
  3.0.4  (04 Mar 2003)
    * Fixed problem with transparency in TRzFormShape when using JPEG and GIF
      images.
    * Fixed problem where TRzFormState would prevent app from exiting if
      associated INI file was read-only or if Registry entry could not be
      created.
  ------------------------------------------------------------------------------
  3.0    (20 Dec 2002)
    << TRzFormState >>
    * Initial release.

    << TRzFormShape >>
    * Initial release.
===============================================================================}

//{$I RzComps.inc}

unit RzForms;

interface

uses
  //{$IFDEF USE_CS}
  //CodeSiteLogging,
  //{$ENDIF}
  Messages,
  Windows,
  SysUtils,
  Classes,
  Controls,
  Forms,
  StdCtrls,
  ExtCtrls,
  Registry,
  Graphics,
  RzCommon;

type
  TRzFormState = class(TComponent)
  private
    FAboutInfo: TRzAboutInfo;
    FEnabled: Boolean;
    FRegIniFile: TRzRegIniFile;
    FSection: string;

    FOrigCreateHandler: TNotifyEvent;
    FOrigShowHandler: TNotifyEvent;
    FOrigCloseHandler: TCloseEvent;

    FOnSaveState: TNotifyEvent;
    FOnRestoreState: TNotifyEvent;

    { Internal Event Handlers }
    procedure FormCreateHandler(Sender: TObject);
    procedure FormShowHandler(Sender: TObject);
    procedure FormCloseHandler(Sender: TObject; var Action: TCloseAction);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function GetSection: string;

    function ValidMonitorAtPoint(X, Y: Integer): Boolean;

    { Property Access Methods }
    procedure SetRegIniFile(Value: TRzRegIniFile); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ChainEvents; virtual;
    procedure UnchainEvents; virtual;

    procedure SaveState; virtual;
    procedure RestoreState; virtual;
  published
    property About: TRzAboutInfo
      read FAboutInfo
      write FAboutInfo
      stored False;

    property Enabled: Boolean
      read FEnabled
      write FEnabled
      default True;

    property Section: string
      read FSection
      write FSection;

    property RegIniFile: TRzRegIniFile
      read FRegIniFile
      write SetRegIniFile;

    property OnSaveState: TNotifyEvent
      read FOnSaveState
      write FOnSaveState;

    property OnRestoreState: TNotifyEvent
      read FOnRestoreState
      write FOnRestoreState;
  end;


  TRzFormShape = class(TImage)
  private
    FAboutInfo: TRzAboutInfo;
    FAllowFormDrag: Boolean;
    FInitializedRegion: Boolean;

    FOnFormShow: TNotifyEvent;

    { Internal Event Handlers }
    procedure FormShowHandler(Sender: TObject);
  protected
    procedure InitRegion;
    function GetRegionFromBitmap(B: TBitmap): HRgn; virtual;

    { Event Dispatch Methods }
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;

    procedure RecreateRegion;
  published
    property About: TRzAboutInfo
      read FAboutInfo
      write FAboutInfo
      stored False;

    property AllowFormDrag: Boolean
      read FAllowFormDrag
      write FAllowFormDrag
      default True;

    property OnFormShow: TNotifyEvent
      read FOnFormShow
      write FOnFormShow;

    { Inherited Properties & Events }
    property Align default alClient;
    property Transparent default True;
  end;


implementation

uses
  IniFiles,
  Dialogs,
  MultiMon;


{&RT}
{==========================}
{== TRzFormState Methods ==}
{==========================}

constructor TRzFormState.Create(AOwner: TComponent);
begin
  inherited;
  FEnabled := True;
  {&RCI}
end;


destructor TRzFormState.Destroy;
begin
  if not (csDesigning in ComponentState) then
    UnchainEvents;

  inherited;
end;


procedure TRzFormState.Loaded;
var
  Loading: Boolean;
begin
  Loading := csLoading in ComponentState;
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    if Loading then
      ChainEvents;
  end;
  {&RV}
end;


procedure TRzFormState.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;

  if (Operation = opRemove) and (AComponent = FRegIniFile) then
    FRegIniFile := nil;
end;


procedure TRzFormState.ChainEvents;
var
  F: TForm;
begin
  if (Owner <> nil) and (Owner is TCustomForm) then
  begin
    F := TForm(Owner);

    FOrigCreateHandler := F.OnCreate;
    F.OnCreate := FormCreateHandler;

    FOrigShowHandler := F.OnShow;
    F.OnShow := FormShowHandler;

    FOrigCloseHandler := F.OnClose;
    F.OnClose := FormCloseHandler;
  end;
end;


procedure TRzFormState.UnchainEvents;
var
  F: TForm;
begin
  if (Owner <> nil) and (Owner is TCustomForm) then
  begin
    F := TForm(Owner);

    F.OnCreate := FOrigCreateHandler;
    F.OnShow := FOrigShowHandler;
    F.OnClose := FOrigCloseHandler;
  end;
end;


procedure TRzFormState.FormCreateHandler(Sender: TObject);
var
  F: TForm;
  S: string;
begin
  if FRegIniFile = nil then
  begin
    MessageDlg(sRzCannotRestoreFormState, mtError, [mbOK], 0);
    Exit;
  end;

  S := GetSection;
  F := TForm(Owner);

  if FRegIniFile.ReadBool(S, 'Saved', False) then
  begin
    // If the form's state has already been saved, then we want to reset the
    // form's Position property to poDesigned.
    // This way the form will be positioned according to the values stored in
    // the persistent store and not by the initial value of the Position property.
    F.Position := poDesigned;
  end;
  if Assigned(FOrigCreateHandler) then
    FOrigCreateHandler(Sender);
end;


procedure TRzFormState.FormShowHandler(Sender: TObject);
begin
  RestoreState;
  if Assigned(FOrigShowHandler) then
    FOrigShowHandler(Sender);
end;


procedure TRzFormState.FormCloseHandler(Sender: TObject; var Action: TCloseAction);
begin
  SaveState;
  if Assigned(FOrigCloseHandler) then
    FOrigCloseHandler(Sender, Action);
end;


function TRzFormState.ValidMonitorAtPoint(X, Y: Integer): Boolean;
{$IFNDEF VCL60_OR_HIGHER}
var
  MonHandle: HMonitor;
  M: TMonitor;
  I: Integer;
{$ENDIF}
begin
{$IFDEF VCL60_OR_HIGHER}

  Result := Screen.MonitorFromPoint(Point(X, Y), mdNull) <> nil;

{$ELSE}

  MonHandle := MultiMon.MonitorFromPoint(Point(X, Y), MONITOR_DEFAULTTONULL);
  M := nil;
  for I := 0 to Screen.MonitorCount - 1 do
  begin
    if Screen.Monitors[I].Handle = MonHandle then
    begin
      M := Screen.Monitors[I];
      Break;
    end;
  end;
  Result := M <> nil;

{$ENDIF}
end;


procedure TRzFormState.RestoreState;
var
  L, T, R, B: Integer;
  F: TCustomForm;
  S: string;
  WP: TWindowPlacement;
  WS: PInteger;
begin
  if not FEnabled then
    Exit;

  if FRegIniFile = nil then
  begin
    MessageDlg(sRzCannotRestoreFormState, mtError, [mbOK], 0);
    Exit;
  end;

  S := GetSection;

  if (Owner <> nil) and (Owner is TCustomForm) then
  begin
    F := TCustomForm(Owner);

    L := FRegIniFile.ReadInteger(S, 'Left', F.Left);
    T := FRegIniFile.ReadInteger(S, 'Top', F.Top);

    if F.BorderStyle in [bsSizeable, bsSizeToolWin] then
    begin
      R := FRegIniFile.ReadInteger(S, 'Right', L + F.Width);
      B := FRegIniFile.ReadInteger(S, 'Bottom', T + F.Height);
    end
    else
    begin
      R := L + F.Width;
      B := T + F.Height;
    end;

    WP.Length := SizeOf(TWindowPlacement);
    GetWindowPlacement(F.Handle, @WP);
    WP.rcNormalPosition := Rect(L, T, R, B);
    if not ValidMonitorAtPoint(L, T) then
    begin
      // The saved location of the form is no longer on a valid monitor, move to (0,0)
      OffsetRect(WP.rcNormalPosition, -L, -T);
    end;
    SetWindowPlacement(F.Handle, @WP);

    if FRegIniFile.ReadBool(S, 'Maximized', False) then
    begin
      if (F is TForm) and (TForm(F).FormStyle = fsMDIChild) then
      begin
        // The TCustomForm.CMShowingChanged method forces the MDI Child window
        // to restore/maximize itself if it is maximized.  This means that if we
        // set the WindowState property here to wsMaximized, then the form will
        // get maximized twiced.  Therefore, we access the address of the
        // WindowState property for the form. This will NOT work for VCL.NET.
        WS := @F.WindowState;
        WS^ := Ord(wsMaximized);
      end
      else
        F.WindowState := wsMaximized;
    end;

    if Assigned(FOnRestoreState) then
      FOnRestoreState(Self);
  end;
end;


procedure TRzFormState.SaveState;
var
  F: TCustomForm;
  WP: TWindowPlacement;
  S: string;
begin
  if not FEnabled then
    Exit;

  if FRegIniFile = nil then
  begin
    MessageDlg(sRzCannotSaveFormState, mtError, [mbOK], 0);
    Exit;
  end;

  S := GetSection;

  if (Owner <> nil) and (Owner is TCustomForm) then
  begin
    F := TCustomForm(Owner);

    WP.Length := SizeOf(TWindowPlacement);
    GetWindowPlacement(F.Handle, @WP);

    try
      FRegIniFile.WriteBool(S, 'Maximized', IsZoomed(F.Handle));
      FRegIniFile.WriteInteger(S, 'Left', WP.rcNormalPosition.Left);
      FRegIniFile.WriteInteger(S, 'Top', WP.rcNormalPosition.Top);
      if F.BorderStyle in [bsSizeable, bsSizeToolWin] then
      begin
        FRegIniFile.WriteInteger(S, 'Right', WP.rcNormalPosition.Right);
        FRegIniFile.WriteInteger(S, 'Bottom', WP.rcNormalPosition.Bottom);
      end;
      FRegIniFile.WriteBool(S, 'Saved', True);
    except
      on E: ERegistryException do
        MessageDlg(E.Message, mtError, [mbOK], 0);

{$IFDEF VCL60_OR_HIGHER}
      on E: EIniFileException do
        MessageDlg(E.Message, mtError, [mbOK], 0);
{$ELSE}
      // VCL 50 does not define the EIniFileException, so we have to trap all exceptions here.
      on E: Exception do
        MessageDlg(E.Message, mtError, [mbOK], 0);
{$ENDIF}

    else
      raise;
    end;
    if Assigned(FOnSaveState) then
      FOnSaveState(Self);
  end;
end;


function TRzFormState.GetSection: string;
var
  F: TCustomForm;
begin
  if FSection <> '' then
    Result := FSection
  else
  begin
    if (Owner <> nil) and (Owner is TCustomForm) then
    begin
      F := TCustomForm(Owner);
      if F.Name <> '' then
        Result := F.Name + 'FormState'
      else
        Result := F.ClassName + 'FormState';
    end
    else
      Result := 'FormState';
  end;
end;


procedure TRzFormState.SetRegIniFile(Value: TRzRegIniFile);
begin
  if FRegIniFile <> Value then
  begin
    FRegIniFile := Value;
    if Value <> nil then
      Value.FreeNotification(Self);
  end;
end;


{==========================}
{== TRzFormShape Methods ==}
{==========================}

constructor TRzFormShape.Create(AOwner: TComponent);
var
  F: TForm;
begin
  inherited;

  FInitializedRegion := False;
  FAllowFormDrag := True;
  Align := alClient;
  Transparent := True;
  {&RCI}

  if not (csDesigning in ComponentState) then
  begin
    F := AOwner as TForm; // Raise an exception if not dropped on a form

    F.BorderStyle := bsNone;
    F.OnShow := FormShowHandler;
  end;
end;

const
  BitMask: array[0..7] of byte = (128, 64, 32, 16, 8, 4, 2, 1);

function fcThisThat(const Clause: Boolean; TrueVal, FalseVal: Integer): Integer;
begin
  if Clause then result := TrueVal else Result := FalseVal;
end;

function fcIsTrueColorBitmap(Bitmap: TBitmap): boolean;
begin
  result := Bitmap.PixelFormat = Graphics.pf24bit;
end;

function fcBytesPerScanline(PixelsPerScanline, BitsPerPixel, Alignment: Longint): Longint;
begin
  Dec(Alignment);
  Result := ((PixelsPerScanline * BitsPerPixel) + Alignment) and not Alignment;
  Result := Result div 8;
end;

// This function creates a HBitmap that must be deleted using DeleteObject by the caller

function fcGetDIBBitsFromBitmap(aBitmap: TBITMAP; var BitmapInfo: TBitmapInfo; var pixbuf: Pointer; var bytespscanline: Integer; var Hb: HBitmap): Boolean;
begin
  FillChar(BitmapInfo, SizeOf(TBitmapInfo), 0);
  with BitmapInfo.bmiheader do
  begin
    biSize := sizeof(TBitmapInfoHeader);
    biWidth := ABitmap.Width;
    biHeight := -ABitmap.Height; //DIBs are Bottom up
    biPlanes := 1;
    biBitCount := 24;
    biCompression := BI_RGB;
    bytespscanline := fcBytesPerScanline(LongInt(biwidth), biBitCount, 32);
  end;

  hb := CreateDIBSection(ABitmap.Canvas.Handle, BitmapInfo, DIB_RGB_COLORS, pixbuf, 0, 0);

  if (pixbuf = nil) or (hb = 0) then
  begin
    raise EInvalidOperation.Create('Could Not Create DIB Section');
    Exit;
  end;

  GetDIBits(ABitmap.Canvas.Handle, aBitmap.handle, 0, ABitmap.height, pixbuf, BitmapInfo, DIB_RGB_COLORS);
  result := True;
end;

type TNewImageList = class(TImageList);

function fcCreateRegionFromBitmap(ABitmap: TBitmap; TransColor: TColor): HRgn;
var
  TempBitmap: TBitmap;
  Rgn1, Rgn2: HRgn;
  Col, StartCol, Row: integer;
  Line: PByteArray;

  function ColToColor(Col: integer): TColor;
  begin
    if fcIsTrueColorBitmap(TempBitmap) then
      result := Line[Col * 3] * 256 * 256 + Line[Col * 3 + 1] * 256 + Line[Col * 3 + 2]
    else result := TColor(fcThisThat((Line[Col div 8] and BitMask[Col mod 8]) <> 0, clBlack, clWhite));
  end;
begin
  result := 0;
  if (ABitmap <> nil) and (ABitmap.Width = 0) or (ABitmap.Height = 0) then Exit;
  Rgn1 := 0;

  TempBitmap := TBitmap.Create;

  TempBitmap.Assign(ABitmap);
  if not fcIsTrueColorBitmap(TempBitmap) then
  begin
    TempBitmap.Mask(TransColor);
    TransColor := clBlack;
  end;

  with TempBitmap do
  begin
    for Row := 0 to TempBitmap.height - 1 do
    begin
      Line := scanLine[row];

      Col := 0;
      while Col < TempBitmap.Width do
      begin
        while (Col < TempBitmap.Width) and (ColToColor(Col) = TransColor) do inc(Col);
        if Col >= TempBitmap.Width then Continue;

        StartCol := Col;
        while (Col < TempBitmap.Width) and (ColToColor(Col) <> TransColor) do inc(Col);
        if Col >= TempBitmap.Width then Col := TempBitmap.Width;

        if Rgn1 = 0 then Rgn1 := CreateRectRgn(StartCol, Row, Col, Row + 1)
        else begin
          Rgn2 := CreateRectRgn(StartCol, Row, Col, Row + 1);
          if (Rgn2 <> 0) then CombineRgn(Rgn1, Rgn1, Rgn2, RGN_OR);
          Deleteobject(Rgn2);
        end;
      end;
    end;
  end;
  result := Rgn1;
  TempBitmap.Free;
end;
{
function fcRegionFromBitmap(ABitmap: TfcBitmap; TransColor: TColor): HRgn;
type PCOLORREF = ^COLORREF;
var
  Rgn1, Rgn2: HRgn;
  Col, StartCol, Row: integer;
begin
  result := 0;
  if (ABitmap <> nil) and (ABitmap.Width = 0) or (ABitmap.Height = 0) then Exit;
  Rgn1 := 0;

  if TransColor = -1 then TransColor := fcGetStdColor(ABitmap.Pixels[0, 0]);

  with ABitmap do
  begin
    for Row := 0 to Height - 1 do
    begin
      Col := 0;
      while Col < Width do
      begin
        while (Col < Width) and (fcGetStdColor(Pixels[Row, Col]) = TransColor) do
          inc(Col);
        if Col >= Width then Continue;

        StartCol := Col;
        while (Col < Width) and (fcGetStdColor(Pixels[Row, Col]) <> TransColor) do inc(Col);
        if Col >= Width then Col := Width;

        if Rgn1 = 0 then Rgn1 := CreateRectRgn(StartCol, Row, Col, Row + 1)
        else begin
          Rgn2 := CreateRectRgn(StartCol, Row, Col, Row + 1);
          if (Rgn2 <> 0) then CombineRgn(Rgn1,Rgn1,Rgn2,RGN_OR);
            Deleteobject(Rgn2);
        end;
      end;
    end;
  end;
  result := Rgn1;
end;  }


function TRzFormShape.GetRegionFromBitmap(B: TBitmap): HRgn;
var
  Col, Row, MarkCol: Integer;
  RowRgn: HRgn;
  InShape, OnShapePixel: Boolean;
  TransColor: TColor;
begin
  Result := 0;

  if not Transparent then
    Exit;

  TransColor := B.TransparentColor and $FFFFFF; // Ignore Alpha Channel
  MarkCol := 0;

  for Row := 0 to B.Height - 1 do
  begin
    InShape := False;
    for Col := 0 to B.Width - 1 do
    begin
      OnShapePixel := B.Canvas.Pixels[Col, Row] and $FFFFFF <> TransColor;

      if OnShapePixel <> InShape then
      begin
        // If OnShapePixel <> InShape, then we have a state change...

        if InShape then
        begin
          // If currently InShape, then we are at the end of the current block of pixels.
          // Therefore, add the block to the region...

          RowRgn := CreateRectRgn(MarkCol, Row, Col, Row + 1);

          if Result <> 0 then
          begin
            // First region has already been assigned, therefore just add this one to existing region
            CombineRgn(Result, Result, RowRgn, RGN_OR);
            DeleteObject(RowRgn);
          end
          else
            Result := RowRgn;
        end
        else
        begin
          // No currently in the shape, so mark this column
          MarkCol := Col;
        end;

        // change mode, looking for the first or last real pixel?
        InShape := not InShape;
      end;
    end; { for Col }

    // was the last pixel in this row a real pixel?
    if InShape then
    begin
      // If still InShape then last pixel is not transparent--add block to the region
      RowRgn := CreateRectRgn(MarkCol, Row, B.Width - 1, Row + 1);

      if Result <> 0 then
      begin
        // First region has already been assigned, therefore just add this one to existing region
        CombineRgn(Result, Result, RowRgn, RGN_OR);
        DeleteObject(RowRgn);
      end
      else
        Result := RowRgn;
    end;
  end; { for Row }
end; {= TRzFormShape.GetRegionFromBitmap =}


procedure TRzFormShape.FormShowHandler(Sender: TObject);
begin
  InitRegion;

  if Assigned(FOnFormShow) then
    FOnFormShow(Self);
  {&RV}
end;


procedure TRzFormShape.InitRegion;
var
  Region: HRgn;
  Bmp: TBitmap;
  //cColor:TColor;
  //dwTick:LongWord;
begin
  if not FInitializedRegion then
  begin
    FInitializedRegion := True;

    Bmp := TBitmap.Create;

    Bmp.Width := Picture.Width;
    Bmp.Height := Picture.Height;
    if Picture.Graphic is TBitmap then
    begin
      Bmp.Canvas.Brush.Color := Picture.Bitmap.TransparentColor;
      Bmp.Canvas.FillRect(Rect(0, 0, Bmp.Width, Bmp.Height));
    end;
    Bmp.Canvas.Draw(0, 0, Picture.Graphic);
    //dwTick:=GetTickCount;
    //Region := GetRegionFromBitmap( Bmp );
    Region := fcCreateRegionFromBitmap(Bmp, Picture.Bitmap.TransparentColor);
    //Region := fcCreateRegionFromBitmap(Bmp, Bmp.Canvas.Pixels[0,0]);
    //Showmessage(IntToStr(GetTickCount-dwTick));
    //Region := GetRegionFromBitmap( Bmp );
    try
      // This should only be called if the Owner is indeed a TForm
      // i.e. constructor takes care of making sure this is true

      SetWindowRgn(TForm(Owner).Handle, Region, True);
    finally
      DeleteObject(Region);
      Bmp.Free;
    end;
  end;
end;


procedure TRzFormShape.RecreateRegion;
begin
  FInitializedRegion := False;
  InitRegion;
end;


procedure TRzFormShape.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  sc_DragMove = $F012;
begin
  inherited;

  if FAllowFormDrag then
  begin
    ReleaseCapture;
    TForm(Owner).Perform(wm_SysCommand, sc_DragMove, 0);
  end;
end;

{&RUIF}
end.

