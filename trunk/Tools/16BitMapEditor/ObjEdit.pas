unit ObjEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ExtCtrls, Buttons, StdCtrls, Spin, HUtil32;

type
  TPieceInfo = packed record
    rx: integer;
    ry: integer;
    BkImg: integer; //-1:none
    Img: integer; //-1:none
    AniFrame: byte; //0이상이면 에니메이션 됨
    AniTick: byte; //
    Blend: Boolean;
    light: byte; //빛의 밝기
    DoorIndex: byte; //문을 식별하기위함 0보다 크면 문.  $80이면 문을 열수 있는 곳
    DoorOffset: byte; //닫혀진 그림을 식별하기 위함
    mark: byte; //0: none, 1:Bk, 2:Fr, 3:Bk & Fr
  end;
  PTPieceInfo = ^TPieceInfo;

  TFrmObjEdit = class(TForm)
    DetailGrid: TDrawGrid;
    Panel1: TPanel;
    BtnView: TSpeedButton;
    Panel2: TPanel;
    BtnOk: TBitBtn;
    BtnClear: TBitBtn;
    BitBtn1: TBitBtn;
    BtnMark1: TSpeedButton;
    BtnMark2: TSpeedButton;
    BtnTile: TSpeedButton;
    BObj: TSpeedButton;
    BTile: TSpeedButton;
    Panel3: TPanel;
    Label2: TLabel;
    SeAniFrame: TSpinEdit;
    Label3: TLabel;
    SeAniTick: TSpinEdit;
    CkAlpha: TCheckBox;
    Panel4: TPanel;
    BtnLeft: TSpeedButton;
    BtnUp: TSpeedButton;
    BtnDown: TSpeedButton;
    BtnRight: TSpeedButton;
    CkViewMark: TCheckBox;
    BDoor: TSpeedButton;
    BLight: TSpeedButton;
    Label4: TLabel;
    SeLight: TSpinEdit;
    Label5: TLabel;
    SeDoor: TSpinEdit;
    Label1: TLabel;
    Label6: TLabel;
    SeDoorOffset: TSpinEdit;
    CkViewLineNumber: TCheckBox;
    BDoorCore: TSpeedButton;
    BtnDoorTest: TSpeedButton;
    CbWilIndexList: TComboBox;
    Label7: TLabel;
    LabelIndex: TLabel;
    Pbox: TPaintBox;
    procedure DetailGridDrawCell(Sender: TObject; col, row: Longint;
      Rect: TRect; State: TGridDrawState);
    procedure PboxPaint(Sender: TObject);
    procedure PboxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure PboxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: integer);
    procedure PboxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure BtnClearClick(Sender: TObject);
    procedure BtnLeftClick(Sender: TObject);
    procedure BtnUpClick(Sender: TObject);
    procedure BtnDownClick(Sender: TObject);
    procedure BtnRightClick(Sender: TObject);
    procedure BtnTileClick(Sender: TObject);
    procedure DetailGridClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CkViewMarkClick(Sender: TObject);
    procedure BtnDoorTestClick(Sender: TObject);
    procedure CbWilIndexListChange(Sender: TObject);
  private
    BoxVisible: Boolean;
    BoxX, BoxY, BoxWidth, BoxHeight: integer;
    PieceList: TList;
    starttime: integer;
    ObjWilIndex: integer;
    PieceInfo: PTPieceInfo;
    PieceTempList: TList;
    CriticalSection: TRTLCriticalSection;
    procedure AddPiece(X, Y, BkImg, Img, mark: integer);
    procedure AddLight(X, Y, light: integer);
    procedure AddDoor(X, Y, DoorIndex, DoorOffset: integer; core: Boolean);
    function GetPiece(X, Y: integer): PTPieceInfo;
    procedure DelPiece(X, Y: integer);
    procedure ShiftPieces(dir: integer);
    procedure ClearPiece;
    procedure DrawPiece(paper: TCanvas; X, Y: integer);
    procedure GetRelPos(X, Y: integer; var rx, ry: integer);
    procedure DrawCursor(xx, yy: integer);
    function GetCurrentIndex: integer;
    procedure InitAniFrame;
    procedure AddAnimationUtitily;
    procedure Undo;
    procedure DeleteTempPiece(P: PTPieceInfo);
  public
    function Execute: Boolean;
    procedure SetPieceList(plist: TList);
    procedure DuplicatePieceList(plist: TList);
  end;

var
  FrmObjEdit: TFrmObjEdit;

implementation

uses EdMain, SmTile, Tile;

{$R *.DFM}

procedure TFrmObjEdit.FormCreate(Sender: TObject);
var
  I: integer;
  sFileName: string;
begin
  InitializeCriticalSection(CriticalSection);
  PieceInfo := nil;
  starttime := GetCurrentTime;
  BoxVisible := False;
  BoxX := 0;
  BoxY := 0;
  PieceList := TList.Create;
  PieceTempList := TList.Create;
  CbWilIndexList.ItemIndex := 0;
  ObjWilIndex := 0;
  CbWilIndexList.Items.Clear;
  {
  for I := 0 to WilCount - 1 do begin
    if WilBitCount = 16 then begin
      CbWilIndexList.Items.Add(Format('objects%d.data', [I + 9]));
    end else begin
      CbWilIndexList.Items.Add(Format('objects%d.wil', [I + 9]));
    end;
  end;
  }
  for I := Low(WilArr) to High(WilArr) do begin
    if (WilArr[I] <> nil) and (WilArr[I].Initialized) then begin
      if WilBitCount = 16 then begin
        if I = 0 then sFileName := 'Objects.data'
        else sFileName := 'Objects' + IntToStr(I + 1) + '.data';
      end else begin
        if I = 0 then sFileName := 'Objects.wil'
        else sFileName := 'Objects' + IntToStr(I + 1) + '.wil';
      end;
      CbWilIndexList.Items.Add(sFileName);
    end;
  end;
end;

procedure TFrmObjEdit.FormDestroy(Sender: TObject);
begin
  PieceList.Free;
  PieceTempList.Free;
  DeleteCriticalSection(CriticalSection);
end;

procedure TFrmObjEdit.DeleteTempPiece(P: PTPieceInfo);
var
  I: integer;
begin
  for I := PieceTempList.Count - 1 downto 0 do begin
    if PieceTempList.Items[I] = P then begin
      PieceTempList.Delete(I);
      Break;
    end;
  end;
end;

procedure TFrmObjEdit.FormShow(Sender: TObject);
var
  n: integer;
begin
  n := _MIN(65535, FrmMain.ObjWil(ObjWilIndex * 65535).ImageCount);
//   n := FrmMain.ObjWil(ObjWilIndex*65535).ImageCount;
  if n >= 1 then DetailGrid.ColCount := n
  else DetailGrid.ColCount := 1;
  FrmTile.Show;
  FrmTile.Parent := self;
  FrmTile.Left := 80;
  FrmTile.Top := 30;
end;

procedure TFrmObjEdit.CbWilIndexListChange(Sender: TObject);
var
  n: integer;
begin
  n := CbWilIndexList.ItemIndex;
  if n in [0..MAXWIL - 1] then
  begin
    ObjWilIndex := n;
    FormShow(self);
  end;
end;

function TFrmObjEdit.Execute: Boolean;
begin
  starttime := GetCurrentTime;
  InitAniFrame;
  if mrOk = ShowModal then begin
    AddAnimationUtitily;
    Result := True;
  end else Result := False;
end;

procedure TFrmObjEdit.SetPieceList(plist: TList);
var
  I: integer;
  P: PTPieceInfo;
begin
  ClearPiece;
  if plist <> nil then begin
    EnterCriticalSection(CriticalSection);
    try
      for I := 0 to plist.Count - 1 do begin
        New(P);
        P^ := PTPieceInfo(plist[I])^;
        PieceList.Add(P);
      end;
    finally
      LeaveCriticalSection(CriticalSection);
    end;
  end;
end;

procedure TFrmObjEdit.InitAniFrame;
var
  AniFrame, AniTick: integer;
  Blend: Boolean;
begin
  EnterCriticalSection(CriticalSection);
  try
    if PieceList.Count > 0 then begin
      AniFrame := PTPieceInfo(PieceList[0]).AniFrame;
      AniTick := PTPieceInfo(PieceList[0]).AniTick;
      Blend := PTPieceInfo(PieceList[0]).Blend;
    end else begin
      AniFrame := 0;
      AniTick := 0;
      Blend := False;
    end;
    SeAniFrame.value := AniFrame;
    SeAniTick.value := AniTick;
    CkAlpha.Checked := Blend;
  finally
    LeaveCriticalSection(CriticalSection);
  end;
end;

procedure TFrmObjEdit.AddAnimationUtitily;
var
  I, AniFrame, AniTick: integer;
  Blend: Boolean;
  P: PTPieceInfo;
begin
  try
    AniFrame := SeAniFrame.value;
    AniTick := SeAniTick.value;
    if AniFrame > 0 then Blend := CkAlpha.Checked
    else Blend := False;
  except
    AniFrame := 0;
    AniTick := 0;
    Blend := False;
  end;
  if AniFrame >= 0 then begin
    EnterCriticalSection(CriticalSection);
    try
      for I := 0 to PieceList.Count - 1 do begin
        P := PTPieceInfo(PieceList[I]);
        P.AniFrame := AniFrame;
        P.AniTick := AniTick;
        P.Blend := Blend;
      end;
    finally
      LeaveCriticalSection(CriticalSection);
    end;
  end;
end;

procedure TFrmObjEdit.DuplicatePieceList(plist: TList);
var
  I: integer;
  P: PTPieceInfo;
begin
  EnterCriticalSection(CriticalSection);
  try
    for I := 0 to PieceList.Count - 1 do begin
      New(P);
      P^ := PTPieceInfo(PieceList[I])^;
      plist.Add(P);
    end;
  finally
    LeaveCriticalSection(CriticalSection);
  end;
end;


{ PieceList }

{img : -2 (not apply), mark -2 (not apply)}
procedure TFrmObjEdit.AddPiece(X, Y, BkImg, Img, mark: integer);
var
  I, n, m: integer;
  P: PTPieceInfo;
  boFind: Boolean;
begin
  if (Img = -1) or (BkImg = -1) then Exit;
  n := -1;
  boFind := False;
  EnterCriticalSection(CriticalSection);
  try
    for I := 0 to PieceList.Count - 1 do begin
      P := PTPieceInfo(PieceList[I]);
      if (P.rx = X) and (P.ry = Y) then begin
        if Img <> -2 then P.Img := Img;
        if BkImg <> -2 then P.BkImg := BkImg;
        if mark <> -2 then P.mark := P.mark xor mark;
        boFind := True;
        Break;
      end;
      if P.ry > Y then begin
        n := I;
        Break;
      end;
    end;
    if not boFind then begin
      New(P);
      FillChar(P^, SizeOf(TPieceInfo), 0);
      P.BkImg := -1;
      P.Img := -1;
      P.rx := X;
      P.ry := Y;
      if BkImg <> -2 then P.BkImg := BkImg
      else P.BkImg := -1;
      if Img <> -2 then P.Img := Img
      else P.Img := -1;
      if mark <> -2 then P.mark := mark
      else P.mark := 0;
      if n = -1 then PieceList.Add(P)
      else PieceList.Insert(n, P);

      if PieceTempList.Count >= 10 then PieceTempList.Delete(0);
      PieceTempList.Add(P);
      //PieceInfo := P;
    end;
  finally
    LeaveCriticalSection(CriticalSection);
  end;
end;

procedure TFrmObjEdit.AddLight(X, Y, light: integer);
var
  I, n, m: integer;
  P: PTPieceInfo;
  boFind: Boolean;
begin
  if (light = -1) then Exit;
  n := -1;
  boFind := False;
  EnterCriticalSection(CriticalSection);
  try
    for I := 0 to PieceList.Count - 1 do begin
      P := PTPieceInfo(PieceList[I]);
      if (P.rx = X) and (P.ry = Y) then begin
        P.light := light;
        boFind := True;
        Break;
      end;
      if P.ry > Y then begin
        n := I;
        Break;
      end;
    end;
    if not boFind then begin
      New(P);
      FillChar(P^, SizeOf(TPieceInfo), 0);
      P.BkImg := -1;
      P.Img := -1;
      P.rx := X;
      P.ry := Y;
      P.light := light;
      if n = -1 then PieceList.Add(P)
      else PieceList.Insert(n, P);
      if PieceTempList.Count >= 10 then PieceTempList.Delete(0);
      PieceTempList.Add(P);
      //PieceInfo := P;
    end;
  finally
    LeaveCriticalSection(CriticalSection);
  end;
end;

procedure TFrmObjEdit.AddDoor(X, Y, DoorIndex, DoorOffset: integer; core: Boolean);
var
  I, n, m: integer;
  P: PTPieceInfo;
  boFind: Boolean;
begin
  if (DoorIndex = -1) or (DoorOffset = -1) then Exit;
  n := -1;
  boFind := False;
  EnterCriticalSection(CriticalSection);
  try
    for I := 0 to PieceList.Count - 1 do begin
      P := PTPieceInfo(PieceList[I]);
      if (P.rx = X) and (P.ry = Y) then begin
        if core then
          P.DoorIndex := $80 or P.DoorIndex
        else P.DoorIndex := (P.DoorIndex and $80) or DoorIndex;
        P.DoorOffset := DoorOffset;
        boFind := True;
        Break;
      end;
      if P.ry > Y then begin
        n := I;
        Break;
      end;
    end;
    if not boFind then begin
      New(P);
      FillChar(P^, SizeOf(TPieceInfo), 0);
      P.BkImg := -1;
      P.Img := -1;
      P.rx := X;
      P.ry := Y;
      if core then
        P.DoorIndex := $80 or DoorIndex
      else P.DoorIndex := DoorIndex;
      P.DoorOffset := DoorOffset;
      if n = -1 then PieceList.Add(P)
      else PieceList.Insert(n, P);
      if PieceTempList.Count >= 10 then PieceTempList.Delete(0);
      PieceTempList.Add(P);
      //PieceInfo := P;
    end;
  finally
    LeaveCriticalSection(CriticalSection);
  end;
end;

function TFrmObjEdit.GetPiece(X, Y: integer): PTPieceInfo;
var
  I: integer;
  P: PTPieceInfo;
begin
  Result := nil;
  EnterCriticalSection(CriticalSection);
  try
    for I := 0 to PieceList.Count - 1 do begin
      P := PTPieceInfo(PieceList[I]);
      if (P.rx = X) and (P.ry = Y) then begin
        Result := P;
      end;
    end;
  finally
    LeaveCriticalSection(CriticalSection);
  end;
end;

procedure TFrmObjEdit.DelPiece(X, Y: integer);
var
  I: integer;
  P: PTPieceInfo;
begin
  I := 0;
  EnterCriticalSection(CriticalSection);
  try
    while True do begin
      if I > PieceList.Count - 1 then Break;
      P := PTPieceInfo(PieceList[I]);
      if (P.rx = X) and (P.ry = Y) then begin
        //if P = PieceInfo then PieceInfo := nil;
        DeleteTempPiece(P);
        Dispose(P);
        PieceList.Delete(I);
      end else
        inc(I);
    end;
  finally
    LeaveCriticalSection(CriticalSection);
  end;
end;

procedure TFrmObjEdit.ShiftPieces(dir: integer);
var
  I: integer;
  P: PTPieceInfo;
begin
  EnterCriticalSection(CriticalSection);
  try
    for I := 0 to PieceList.Count - 1 do begin
      P := PTPieceInfo(PieceList[I]);
      if P.BkImg = -1 then
        case dir of
          0: //left
            begin
              P.rx := P.rx - 1;
            end;
          1: //right
            begin
              P.rx := P.rx + 1;
            end;
          2: //up
            begin
              P.ry := P.ry - 1;
            end;
          3: //down
            begin
              P.ry := P.ry + 1;
            end;
        end;
    end;
  finally
    LeaveCriticalSection(CriticalSection);
  end;
end;

procedure TFrmObjEdit.ClearPiece;
var
  I: integer;
  P: PTPieceInfo;
begin
  EnterCriticalSection(CriticalSection);
  try
    for I := 0 to PieceList.Count - 1 do
      Dispose(PTPieceInfo(PieceList[I]));
    PieceList.Clear;
    PieceInfo := nil;
    PieceTempList.Clear;
  finally
    LeaveCriticalSection(CriticalSection);
  end;
end;

procedure TFrmObjEdit.DrawPiece(paper: TCanvas; X, Y: integer);
var
  nx, ny, nby, Img, mode, mark: integer;
  P: PTPieceInfo;
begin
  nx := Pbox.Width div 2 - UNITX;
  ny := Pbox.Height div 2 + UNITY;
  nby := ny + Y * UNITY - UNITY;
  nx := nx + X * UNITX;
  ny := ny + Y * UNITY;
  P := GetPiece(X, Y);
  if P <> nil then begin
    with WILTiles do begin
      if P.BkImg >= 0 then
        DrawZoom(paper, nx, nby, P.BkImg, 1);
    end;
    with FrmMain.ObjWil(P.Img) do begin
      if P.Img >= 0 then
        DrawZoomEx(paper, nx, ny, P.Img mod 65535, 1, False);
    end;
    with WilSmTiles do begin
      if (P.mark and $01) > 0 then DrawZoomEx(paper, nx, ny, BKMASK, 1, False);
      if (P.mark and $02) > 0 then DrawZoomEx(paper, nx, ny, FRMASK, 1, False);
    end;
  end;
end;

{}

procedure TFrmObjEdit.GetRelPos(X, Y: integer; var rx, ry: integer);
var
  nx, ny: integer;
begin
  nx := Pbox.Width div 2 - UNITX;
  ny := Pbox.Height div 2;
  if X - nx < 0 then X := X - (UNITX - 1);
  if Y - ny < 0 then Y := Y - (UNITY - 1);
  rx := (X - nx) div UNITX;
  ry := (Y - ny) div UNITY;
end;

procedure TFrmObjEdit.DrawCursor(xx, yy: integer);
var
  cx, cy, nx, ny: integer;
begin
  GetRelPos(xx, yy, nx, ny);
  Label1.Caption := IntToStr(nx) + ' : ' + IntToStr(ny);

  cx := Pbox.Width div 2 - UNITX;
  cy := Pbox.Height div 2;

  xx := cx + nx * UNITX;
  yy := cy + ny * UNITY;
  Pbox.Canvas.DrawFocusRect(Rect(xx, yy, xx + UNITX, yy + UNITY));
end;

procedure TFrmObjEdit.DetailGridDrawCell(Sender: TObject; col,
  row: Longint; Rect: TRect; State: TGridDrawState);
var
  idx, Max, wid: integer;
begin
  idx := col;
  Max := FrmMain.ObjWil(ObjWilIndex * 65535).ImageCount;
  if (idx >= 0) and (idx < Max) then begin
    with FrmMain.ObjWil(ObjWilIndex * 65535) do
      DrawZoom(DetailGrid.Canvas, Rect.Left, Rect.Top, idx, 0.5);
    if CkViewLineNumber.Checked or (State <> []) then
    begin
      LabelIndex.Caption := IntToStr(idx);
      wid := DetailGrid.Canvas.TextWidth(IntToStr(idx));
      if wid > DetailGrid.DefaultColWidth then
        DetailGrid.Canvas.TextOut(Rect.Left - (wid - DetailGrid.DefaultColWidth), Rect.Bottom - 16, IntToStr(idx))
      else
        DetailGrid.Canvas.TextOut(Rect.Left, Rect.Bottom - 16, IntToStr(idx));
    end;
  end;
end;

procedure TFrmObjEdit.PboxPaint(Sender: TObject);
var
  I, k, idx: integer;
  nx, ny, nbx, nby, dx, dy: integer;
  P, p2: PTPieceInfo;
begin
  if BoxVisible then begin
    DrawCursor(BoxX, BoxY);
    BoxVisible := False;
  end;

  nx := Pbox.Width div 2 - UNITX;
  ny := Pbox.Height div 2 + UNITY;

  EnterCriticalSection(CriticalSection);
  try
    for I := 0 to PieceList.Count - 1 do begin
      P := PTPieceInfo(PieceList[I]);
      dx := nx + P.rx * UNITX;
      dy := ny + (P.ry - 1) * UNITY;
      with WILTiles do
        if P.BkImg >= 0 then
          DrawZoom(Pbox.Canvas, dx, dy, P.BkImg, 1);
    end;
  finally
    LeaveCriticalSection(CriticalSection);
  end;

  EnterCriticalSection(CriticalSection);
  try
    for I := 0 to PieceList.Count - 1 do begin
      P := PTPieceInfo(PieceList[I]);
      dx := nx + P.rx * UNITX;
      dy := ny + P.ry * UNITY;
      idx := P.Img;
      if BtnDoorTest.Down then begin
        for k := 0 to PieceList.Count - 1 do begin
          p2 := PTPieceInfo(PieceList[k]);
          if (P.rx = p2.rx) and (P.ry = p2.ry) and (p2.DoorIndex > 0) then begin
            if (p2.DoorIndex and $7F) > 0 then
              idx := idx + p2.DoorOffset;
          end;
        end;
      end;
      with FrmMain.ObjWil(idx) do
        if idx >= 0 then
          DrawZoomEx(Pbox.Canvas, dx, dy, idx mod 65535, 1, False);
    end;
  finally
    LeaveCriticalSection(CriticalSection);
  end;


  if CkViewMark.Checked then begin
    EnterCriticalSection(CriticalSection);
    try
      for I := 0 to PieceList.Count - 1 do begin
        P := PTPieceInfo(PieceList[I]);
        dx := nx + P.rx * UNITX;
        dy := ny + P.ry * UNITY;
        if P.mark > 0 then begin
          with WilSmTiles do begin
            if (P.mark and $02) > 0 then DrawZoomEx(Pbox.Canvas, dx, dy, FRMASK, 1, False);
            if (P.mark and $01) > 0 then DrawZoomEx(Pbox.Canvas, dx, dy, BKMASK, 1, False);
          end;
        end;
        if P.light > 0 then
          with WilSmTiles do
            DrawZoomEx(Pbox.Canvas, dx, dy, LIGHTSPOT, 1, False);

        if P.DoorIndex > 0 then begin
          if P.DoorIndex and $80 = 0 then
            Pbox.Canvas.TextOut(dx + 10, dy - 28, 'D' + IntToStr(P.DoorIndex and $7F) + '/' + IntToStr(P.DoorOffset))
          else Pbox.Canvas.TextOut(dx + 10, dy - 28, 'Dx' + IntToStr(P.DoorIndex and $7F) + '/' + IntToStr(P.DoorOffset));
        end;
      end;
    finally
      LeaveCriticalSection(CriticalSection);
    end;
  end;

  with Pbox.Canvas do begin
    Pen.Color := clGray;
    MoveTo(0, Pbox.Height div 2);
    LineTo(Pbox.Width, Pbox.Height div 2);
    MoveTo(Pbox.Width div 2, 0);
    LineTo(Pbox.Width div 2, Height);
  end;
end;

procedure TFrmObjEdit.PboxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  xx, yy, l, offs: integer;
begin
  if GetCurrentTime - starttime < 1000 then Exit;
  if BoxVisible then begin
    DrawCursor(BoxX, BoxY);
    BoxVisible := False;
  end;
  GetRelPos(X, Y, xx, yy);
  if ssCtrl in Shift then begin
    DelPiece(xx, yy);
    Pbox.Refresh;
  end else begin
    if (BtnMark1.Down) and (BtnMark2.Down) then begin //
      AddPiece(xx, yy, -2, -2, 3);
      DrawPiece(Pbox.Canvas, xx, yy);
      Exit;
    end;
    if BtnMark1.Down then begin //
      AddPiece(xx, yy, -2, -2, 2);
      DrawPiece(Pbox.Canvas, xx, yy);
      Exit;
    end;
    if BtnMark2.Down then begin //
      AddPiece(xx, yy, -2, -2, 1);
      DrawPiece(Pbox.Canvas, xx, yy);
      Exit;
    end;
    if BTile.Down then begin //Tile
      if (xx mod 2 = 0) and (yy mod 2 = 0) then begin
        AddPiece(xx, yy, FrmTile.GetCurrentIndex, -2, -2);
        DrawPiece(Pbox.Canvas, xx, yy);
      end else
        Beep;
      Exit;
    end;
    if BObj.Down then
    begin //Object
      AddPiece(xx, yy, -2, GetCurrentIndex, -2);
      DrawPiece(Pbox.Canvas, xx, yy);
      Exit;
    end;
    if BLight.Down then begin
      try
        l := SeLight.value;
      except
        l := 0;
      end;
      AddLight(xx, yy, l);
    end;
    if BDoor.Down then begin
      try
        l := SeDoor.value;
        offs := SeDoorOffset.value;
      except
        l := 0;
        offs := 0;
      end;
      AddDoor(xx, yy, l, offs, False);
    end;
    if BDoorCore.Down then begin
      try
        l := SeDoor.value;
        offs := SeDoorOffset.value;
      except
        l := 0;
        offs := 0;
      end;
      AddDoor(xx, yy, l, offs, True);
    end;
  end;
end;

function TFrmObjEdit.GetCurrentIndex: integer;
begin
  Result := -1;
  with DetailGrid do
    if (col >= 0) and (col < FrmMain.ObjWil(ObjWilIndex * 65535).ImageCount) then
      Result := ObjWilIndex * 65535 + col;
end;

procedure TFrmObjEdit.PboxMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: integer);
begin
  if BoxVisible then begin
    DrawCursor(BoxX, BoxY);
    BoxVisible := False;
  end;

  if ssLeft in Shift then begin
      //PboxMouseDown (self, mbLeft, Shift, X, Y);
  end;

  if not BoxVisible then begin
    BoxX := X;
    BoxY := Y;
    DrawCursor(BoxX, BoxY);
    BoxVisible := True;
  end;
end;

procedure TFrmObjEdit.PboxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  ;
end;

procedure TFrmObjEdit.Undo;
var
  I: integer;
begin
  if PieceTempList.Count > 0 then begin
    EnterCriticalSection(CriticalSection);
    try
      for I := PieceList.Count - 1 downto 0 do begin
        if PieceList.Items[I] = PieceTempList.Items[0] then begin
          Dispose(PTPieceInfo(PieceList[I]));
          PieceInfo := nil;
          PieceList.Delete(I);
          PieceTempList.Delete(0);
          Break;
        end;
      end;
    finally
      LeaveCriticalSection(CriticalSection);
    end;
    Pbox.Refresh;
  end;
end;

procedure TFrmObjEdit.FormKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  case Key of
    VK_F1: BtnTile.Down := not BTile.Down;
    VK_F2: BObj.Down := not BObj.Down;
    VK_F3: BtnMark1.Down := not BtnMark1.Down;
    VK_F4: BtnMark2.Down := not BtnMark2.Down;
    VK_F7: BtnMark1.Down := not BtnMark1.Down;
    VK_F8: BtnMark2.Down := not BtnMark2.Down;
    VK_F5: Pbox.Refresh;
    word('z'),
      word('Z'): if ssCtrl in Shift then Undo;
  end;
end;

procedure TFrmObjEdit.BtnClearClick(Sender: TObject);
begin
  ClearPiece;
  Pbox.Refresh;
end;

procedure TFrmObjEdit.BtnLeftClick(Sender: TObject);
begin
  ShiftPieces(0);
  Pbox.Refresh;
end;

procedure TFrmObjEdit.BtnRightClick(Sender: TObject);
begin
  ShiftPieces(1);
  Pbox.Refresh;
end;

procedure TFrmObjEdit.BtnUpClick(Sender: TObject);
begin
  ShiftPieces(2);
  Pbox.Refresh;
end;

procedure TFrmObjEdit.BtnDownClick(Sender: TObject);
begin
  ShiftPieces(3);
  Pbox.Refresh;
end;

procedure TFrmObjEdit.BtnTileClick(Sender: TObject);
begin
  FrmTile.Show;
  FrmTile.Parent := self;
end;

procedure TFrmObjEdit.DetailGridClick(Sender: TObject);
begin
  BObj.Down := True;

end;

procedure TFrmObjEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmTile.Parent := FrmMain;
  FrmTile.Close;
end;

procedure TFrmObjEdit.CkViewMarkClick(Sender: TObject);
begin
  Pbox.Refresh;
end;

procedure TFrmObjEdit.BtnDoorTestClick(Sender: TObject);
begin
  Pbox.Refresh;
end;

end.

