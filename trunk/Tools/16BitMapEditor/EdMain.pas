unit EdMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, mpalett, Menus, ExtCtrls, HUtil32, GameImages, Wil, Wis, Fir;

const
  MAXX = 1000;
  MAXY = 1000;
  UNITX = 48;
  UNITY = 32;
  HALFX = 24;
  HALFY = 16;
  UNITBLOCK = 50;
  MIDDLEBLOCK = 60;
  SEGX = 40;
  SEGY = 40;

  LIGHTSPOT = 57;
  BKMASK = 58;
  FRMASK = 59;

  MAXSET = 300;
  MAXWIL = 50;

  TITLEHEADER = 'Legend of mir';


type
  TMapPrjInfo = packed record
    Ident: string[15];
    ColCount: integer;
    RowCount: integer;
  end;

  TMapDrawMode = (mdTile, mdMiddle, mdTileDetail, mdObj, mdObjSet, mdLight, mdDoor);
  TMapBrush = (mbAuto, mbNormal, mbFill, mbFillAttrib, mbAttrib, mbEraser);
  TMapInfo = record
    BkImg: word;
    MidImg: word;
    FrImg: word;
    DoorIndex: byte; //$80 (¹®Â¦), ¹®ÀÇ ½Äº° ÀÎµ¦½º
    DoorOffset: byte; //´ÝÈù ¹®ÀÇ ±×¸²ÀÇ »ó´ë À§Ä¡, $80 (¿­¸²/´ÝÈû(±âº»))
    AniFrame: byte; //$80(Åõ¸í)  ÇÁ·¡ÀÓ ¼ö
    AniTick: byte; //¸î¹ø¿¡ Æ½¸¶´Ù ÇÑ ÇÁ·¡ÀÓ¾¿ ¿òÁ÷ÀÌ´Â°¡
    Area: byte; //Object.WIL ¹øÈ£
    light: byte; //0..1..4 ±¤¿ø È¿°ú
  end;
  PTMapInfo = ^TMapInfo;

  TMapHeader = packed record
    Width: word;
    Height: word;
    Title: string[16];
    UpdateDate: TDateTime;
    BitCount: byte;
    Reserved: array[0..21] of char;
  end;
  TMapArray = array[0..MAXX + 10, 0..MAXY + 10] of TMapInfo;
  pTMapArray = ^TMapArray;

  TFrmMain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Open1: TMenuItem;
    Palette1: TMenuItem;
    Tile1: TMenuItem;
    Object1: TMenuItem;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label1: TLabel;
    ZoomIn: TSpeedButton;
    ZoomOut: TSpeedButton;
    LbXY: TLabel;
    ObjEdit1: TMenuItem;
    RunObjEditer1: TMenuItem;
    ObjectSet1: TMenuItem;
    LbMapName: TLabel;
    TileDetail1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Timer1: TTimer;
    NewSegmentMap1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ClearEditSegments1: TMenuItem;
    BtnLeftSeg: TSpeedButton;
    BtnUpSeg: TSpeedButton;
    BtnDownSeg: TSpeedButton;
    BtnRightSeg: TSpeedButton;
    SpeedButton4: TSpeedButton;
    MainScroll: TScrollBox;
    MapPaint: TPaintBox;
    Option1: TMenuItem;
    ObjectViewNormalSize1: TMenuItem;
    SpeedButton5: TSpeedButton;
    SmallTile1: TMenuItem;
    View1: TMenuItem;
    ShowBackgroundTile1: TMenuItem;
    ShowMiddleTile1: TMenuItem;
    ShowObject1: TMenuItem;
    ShowAttribMarks1: TMenuItem;
    N4: TMenuItem;
    MiddleTransparent1: TMenuItem;
    Tool1: TMenuItem;
    DrawBigTile1: TMenuItem;
    DrawObject1: TMenuItem;
    DrawObjectTileSet1: TMenuItem;
    DrawSmTile1: TMenuItem;
    SetLightEffect1: TMenuItem;
    UpdateDoor1: TMenuItem;
    Resize1: TMenuItem;
    N5: TMenuItem;
    SaveToBitmap1: TMenuItem;
    N6: TMenuItem;
    MapScroll1: TMenuItem;
    SpeedButton6: TSpeedButton;
    N7: TMenuItem;
    CellMove1: TMenuItem;
    OpenOldFormatFile1: TMenuItem;
    N8: TMenuItem;
    OldFromatBatchConvert1: TMenuItem;
    Label2: TLabel;
    Help: TMenuItem;
    Version: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Tile1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MapPaintMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure MapPaintMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure MapPaintMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: integer);
    procedure MapPaintPaint(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure ZoomInClick(Sender: TObject);
    procedure ZoomOutClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure Object1Click(Sender: TObject);
    procedure RunObjEditer1Click(Sender: TObject);
    procedure ObjectSet1Click(Sender: TObject);
    procedure TileDetail1Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnMarkClick(Sender: TObject);
    procedure NewSegmentMap1Click(Sender: TObject);
    procedure ClearEditSegments1Click(Sender: TObject);
    procedure BtnLeftSegClick(Sender: TObject);
    procedure BtnRightSegClick(Sender: TObject);
    procedure BtnUpSegClick(Sender: TObject);
    procedure BtnDownSegClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure ObjectViewNormalSize1Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SmallTile1Click(Sender: TObject);
    procedure ShowBackgroundTile1Click(Sender: TObject);
    procedure DrawObject1Click(Sender: TObject);
    procedure Resize1Click(Sender: TObject);
    procedure SaveToBitmap1Click(Sender: TObject);
    procedure MapScroll1Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure CellMove1Click(Sender: TObject);
    procedure OpenOldFormatFile1Click(Sender: TObject);
    procedure OldFromatBatchConvert1Click(Sender: TObject);
    procedure VersionClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    RecusionCount: integer;
    FillIndex: integer;
    MapArrTempList: TList;
    MArrUndo: array[0..MAXX + 10, 0..MAXY + 10] of TMapInfo;
    SetArr: array[0..MAXSET - 1] of TRect;
    procedure ClearSetCursor;
    function DrawSetCursor(xx, yy: integer): Boolean;
    procedure DrawCursor(xx, yy: integer);
    function GetBk(X, Y: integer): integer;
    function GetFrMask(X, Y: integer): integer;
    function GetLightAddDoor(X, Y: integer; var light, door, DoorOffset: integer): Boolean;
    function GetAni(X, Y: integer): integer;
    procedure SetLight(X, Y, value: integer);
    function GetBkImg(X, Y: integer): integer;
    function GetMidImg(X, Y: integer): integer;
    function GetFrImg(X, Y: integer): integer;
    procedure PutTileXY(X, Y, idx: integer);
    procedure PutMiddleXY(X, Y, idx: integer);
    function GetBkImgUnit(X, Y: integer): integer;
    function GetBkUnit(X, Y: integer): integer;
    procedure PutBigTileXY(X, Y, idx: integer);
    procedure PutObjXY(X, Y, idx: integer);
    function DrawFill(xx, yy: integer; Shift: TShiftState): Boolean;
    function DrawFillAttrib(xx, yy: integer; Shift: TShiftState): Boolean;
    procedure DrawTileDetail(X, Y: integer; Shift: TShiftState);
    procedure DrawNormalTile(X, Y: integer; Shift: TShiftState);
    procedure DrawAutoTile(X, Y: integer; Shift: TShiftState);
    procedure DrawAutoMiddleTile(X, Y: integer; Shift: TShiftState);
    procedure DrawEraser(xx, yy: integer; Shift: TShiftState);
    function CheckCollision(xx, yy: integer): Boolean;
    procedure DrawObject(xx, yy: integer; Shift: TShiftState);
    procedure DrawObjectSet(xx, yy: integer; Shift: TShiftState);
    procedure AddLight(X, Y: integer);
    procedure UpdateLight(X, Y: integer);
    procedure UpdateDoor(X, Y: integer);
    procedure DrawCellBk(X, Y, w, h: integer);
    procedure DrawCellFr(X, Y, w, h: integer);
    procedure DrawXorAttrib(X, Y: integer; Button: TMouseButton; Shift: TShiftState);
    function IsMyUnit(X, Y, munit, newidx: integer): Boolean;
    procedure DrawOne(X, Y, munit, idx: integer);
    procedure DrawOneDr(X, Y, munit, idx: integer);
    procedure DrawObjDr(X, Y, idx: integer);
    procedure DrawOrAttr(X, Y, mark: integer);
    function GetPoint(idx: integer): integer;
    function VerifyWork: Boolean;
    procedure LoadSegment(col, row: integer; flname: string);
    procedure SaveSegment(col, row: integer; flname: string);
  public
    MArr: TMapArray; //array[0..MAXX + 10, 0..MAXY + 10] of TMapInfo;
    MapWidth, MapHeight: integer;
    CurX, CurY: integer;
    MainBrush: TMapBrush;
    ImageIndex, ImageDetail: integer;
    MiddleIndex: integer;
    TileAttrib: integer;
    DrawMode: TMapDrawMode;
    Zoom: Real;
    BoxVisible: Boolean;
    BoxX, BoxY, BoxWidth, BoxHeight: integer;
    CurrentMapName: string;
    Edited: Boolean;
    SegmentMode: Boolean;
    function ObjWil(Idx: Integer): TGameImages;
    procedure CopyTemp;
    procedure Undo;
    procedure NewMap;
    function LoadFromFile(flname: string): Boolean;
    function SaveToFile(flname: string): Boolean;
    procedure MakeSetCursor(plist: TList);
    procedure DoEditSegment;
    procedure DoSaveSegments;
  end;

var
  FrmMain: TFrmMain;
  BaseDir: string;
  WilArr: array[0..20 - 1] of TGameImages;
  WilCount: Integer;
  WILTiles: TGameImages;
  WilSmTiles: TGameImages;
  WilBitCount: Byte = 0;
implementation

uses FObj, ObjEdit, ObjSet, Tile, MapSize, segunit, SmTile, glight, DoorDlg,
  FScrlXY, MoveObj, about, SelBitCount;

{$R *.DFM}

procedure TFrmMain.FormCreate(Sender: TObject);
var
  I: integer;
  sFileName: string;
begin
  frmBitCount := TfrmBitCount.Create(Owner);
  frmBitCount.ShowModal;
  frmBitCount.Free;

  if WilBitCount = 0 then begin
    Caption := Caption + ' (Ê¢´óµØÍ¼)';
  end else begin
    Caption := Caption + ' (·É¶ûÕæ²ÊµØÍ¼)';
  end;

  MapArrTempList := TList.Create;
  Zoom := 0.4;
  Label1.Caption := '100:' + IntToStr(Round(100 * Zoom));
  ImageIndex := 0;
  ImageDetail := 0;
  BoxVisible := False;
  BoxX := 0;
  BoxY := 0;
  BoxWidth := 1;
  BoxHeight := 1;
  DrawMode := mdTile;
  CurrentMapName := '';
  Edited := False;
  SegmentMode := False;
  MapWidth := 200;
  MapHeight := 200;
  BaseDir := GetCurrentDir;

  ShowBackgroundTile1.Checked := True;
  ShowMiddleTile1.Checked := True;
  ShowObject1.Checked := True;
  ShowAttribMarks1.Checked := False;
  MiddleTransparent1.Checked := True;

  if WilBitCount = 16 then begin
    WILTiles := TFirImages.Create();
    WILTiles.FileName := 'Tiles.Data';
  end else begin
    WILTiles := TWilImages.Create();
    WILTiles.FileName := 'Tiles.wil';
  end;
  WILTiles.LibType := ltLoadBmp;
  WILTiles.Initialize;

  if WilBitCount = 16 then begin
    WilSmTiles := TFirImages.Create();
    WilSmTiles.FileName := 'SmTiles.Data';
  end else begin
    WilSmTiles := TWilImages.Create();
    WilSmTiles.FileName := 'SmTiles.wil';
  end;
  WilSmTiles.LibType := ltLoadBmp;
  WilSmTiles.Initialize;

  WilCount := 0;
  FillChar(WilArr, SizeOf(WilArr), #0);
  for I := Low(WilArr) to High(WilArr) do begin
    if WilBitCount = 16 then begin
      if I = 0 then sFileName := 'Objects.Data'
      else sFileName := 'Objects' + IntToStr(I + 1) + '.Data';
    end else begin
      if I = 0 then sFileName := 'Objects.wil'
      else sFileName := 'Objects' + IntToStr(I + 1) + '.wil';
    end;
    if WilBitCount = 16 then begin
      WilArr[I] := TFirImages.Create();
    end else begin
      WilArr[I] := TWilImages.Create();
    end;
    WilArr[I].FileName := sFileName;
    WilArr[I].LibType := ltLoadBmp;
    WilArr[I].Initialize;
    Inc(WilCount);
  end;
  NewMap;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  SpeedButton2Click(self);
  FrmMainPal.SetImageUnitCount((WILTiles.ImageCount + UNITBLOCK - 1) div UNITBLOCK);
  FrmSmTile.SetImageUnitCount((WilSmTiles.ImageCount + MIDDLEBLOCK - 1) div MIDDLEBLOCK);
  FrmObjSet.InitializeObjSet;
//   FrmMainPal.Show;
//   FrmObjSet.Execute;
end;

procedure TFrmMain.NewMap;
begin
  LbMapName.Caption := 'Untitled.map';
  if MapWidth < 0 then MapWidth := 1;
  if MapHeight < 0 then MapHeight := 1;
  FillChar(MArr, SizeOf(MArr), #0);
  FillChar(MArrUndo, SizeOf(MArrUndo), #0);
  MapPaint.Width := Round(MapWidth * UNITX * Zoom) + 1;
  MapPaint.Height := Round(MapHeight * UNITY * Zoom) + 1;
  CurX := 0;
  CurY := 0;
end;

function TFrmMain.LoadFromFile(flname: string): Boolean;
var
  I, fhandle: integer;
  header: TMapHeader;
  Str: string;
  MapArray: pTMapArray;
begin
  Result := False;
  if not FileExists(flname) then Exit;
  fhandle := FileOpen(flname, fmOpenRead or fmShareDenyNone);
  if fhandle > 0 then begin
    FillChar(MArr, SizeOf(MArr), #0);
    FillChar(MArrUndo, SizeOf(MArrUndo), #0);
    FileRead(fhandle, header, SizeOf(TMapHeader));
    //Showmessage('BitCount:'+IntToStr(header.BitCount));
    Str := DateTimeToStr(header.UpdateDate);
      //if header.Title = TITLEHEADER then begin
    for I := 0 to MapArrTempList.Count - 1 do begin
      MapArray := pTMapArray(MapArrTempList.Items[I]);
      Dispose(MapArray);
    end;
    MapArrTempList.Clear;

    if (header.Width > 0) and (header.Height > 0) then begin
      MapWidth := header.Width;
      MapHeight := header.Height;
      for I := 0 to header.Width - 1 do
        FileRead(fhandle, MArr[I, 0], SizeOf(TMapInfo) * MapHeight);

      Result := True;
    end;
      //end;
    FileClose(fhandle);
  end;
end;

function TFrmMain.ObjWil(Idx: integer): TGameImages;
var
  nUnit: integer;
  sFileName: string;
begin
  Result := nil;
  nUnit := Idx div 65535;
  if not (nUnit in [Low(WilArr)..High(WilArr)]) then nUnit := 0;
  if WilArr[nUnit] = nil then begin
    if WilBitCount = 16 then begin
      if nUnit = 0 then sFileName := 'Objects.Data'
      else sFileName := 'Objects' + IntToStr(nUnit + 1) + '.Data';
    end else begin
      if nUnit = 0 then sFileName := 'Objects.wil'
      else sFileName := 'Objects' + IntToStr(nUnit + 1) + '.wil';
    end;
    if WilBitCount = 16 then begin
      WilArr[nUnit] := TFirImages.Create();
    end else begin
      WilArr[nUnit] := TWilImages.Create();
    end;
    WilArr[nUnit].FileName := sFileName;
    WilArr[nUnit].LibType := ltLoadBmp;
    WilArr[nUnit].Initialize;
  end;
  Result := WilArr[nUnit];
end;

procedure TFrmMain.CopyTemp;
var
  MapArray: pTMapArray;
begin
  if MapArrTempList.Count >= 10 then begin
    Dispose(pTMapArray(MapArrTempList.Items[0]));
    MapArrTempList.Delete(0);
  end;

  New(MapArray);
  MapArray^ := MArr;
  MapArrTempList.Add(MapArray);

  //Move(MArr, MArrUndo, SizeOf(MArr));
end;

procedure TFrmMain.Undo;
var
  MapArray: pTMapArray;
begin
  //Move(MArrUndo, MArr, SizeOf(MArr));
  if MapArrTempList.Count > 0 then begin
    MapArray := pTMapArray(MapArrTempList.Items[MapArrTempList.Count - 1]);
    MArr := MapArray^;
    MapArrTempList.Delete(MapArrTempList.Count - 1);
    Dispose(MapArray);
    MapPaint.Refresh;
  end;
end;

function TFrmMain.SaveToFile(flname: string): Boolean;
var
  I, j, fhandle: integer;
  header: TMapHeader;
begin
  header.BitCount := WilBitCount;
  header.Width := MapWidth;
  header.Height := MapHeight;
  header.Title := TITLEHEADER;
  if FileExists(flname) then
    fhandle := FileOpen(flname, fmOpenWrite or fmShareDenyNone)
  else fhandle := FileCreate(flname);
  if fhandle > 0 then begin
    FileWrite(fhandle, header, SizeOf(TMapHeader));
    for I := 0 to MapWidth - 1 do begin
      for j := 0 to MapHeight - 1 do begin
        if MArr[I, j].Area = 7 then begin
          MArr[I, j].Area := 6;
          MArr[I, j].FrImg := (MArr[I, j].FrImg and $7FFF) + 9999;
        end;
      end;
      FileWrite(fhandle, MArr[I, 0], SizeOf(TMapInfo) * MapHeight);
    end;
    Result := True;
    FileClose(fhandle);
  end;
end;

procedure TFrmMain.ClearSetCursor;
var
  I: integer;
begin
  for I := 0 to MAXSET - 1 do begin
    SetArr[I].Left := 0;
    SetArr[I].Top := 0;
    SetArr[I].Right := 0;
    SetArr[I].Bottom := 0;
  end;
end;

procedure TFrmMain.MakeSetCursor(plist: TList);
var
  I, n: integer;
  p: PTPieceInfo;
begin
  ClearSetCursor;
  if plist <> nil then begin
    n := 0;
    for I := 0 to plist.Count - 1 do begin
      p := PTPieceInfo(plist[I]);
      if p.Img >= 0 then begin
        SetArr[n].Left := p.rx;
        SetArr[n].Top := p.ry;
        SetArr[n].Right := p.rx + 1;
        SetArr[n].Bottom := p.ry + 1;
        inc(n);
      end;
    end;
  end;
end;

function TFrmMain.DrawSetCursor(xx, yy: integer): Boolean;
var
  I: integer;
begin
  if SetArr[0].Left <> SetArr[0].Right then begin
    for I := 0 to MAXSET - 1 do begin
      if SetArr[I].Left <> SetArr[I].Right then
      begin
        MapPaint.Canvas.DrawFocusRect(
          Rect(xx + SetArr[I].Left * Round(UNITX * Zoom),
          yy + SetArr[I].Top * Round(UNITY * Zoom),
          xx + SetArr[I].Left * Round(UNITX * Zoom) + Round(BoxWidth * UNITX * Zoom),
          yy + SetArr[I].Top * Round(UNITY * Zoom) + Round(BoxHeight * UNITY * Zoom)));
      end else
        Break;
    end;
    Result := True;
  end else
    Result := False;
end;

procedure TFrmMain.DrawCursor(xx, yy: integer);
begin
  xx := Trunc(xx * UNITX * Zoom);
  yy := Trunc(yy * UNITY * Zoom);
  if MainBrush <> mbEraser then begin
    if DrawMode = mdObjSet then begin
      if DrawSetCursor(xx, yy) then
        Exit;
    end;
  end;
  MapPaint.Canvas.DrawFocusRect(
    Rect(xx,
    yy,
    xx + Round(UNITX * Zoom),
    yy + Round(UNITY * Zoom)));
end;

procedure TFrmMain.MapPaintMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  xx, yy, n: integer;
begin
  if BoxVisible then
  begin
    DrawCursor(BoxX, BoxY);
    BoxVisible := False;
  end;
  xx := Trunc(word(X) / UNITX / Zoom);
  yy := Trunc(word(Y) / UNITY / Zoom);
  if MainBrush = mbEraser then
  begin
    DrawEraser(xx, yy, Shift);
    Exit;
  end;
  if MainBrush = mbAttrib then
  begin
    DrawXorAttrib(xx, yy, Button, Shift);
    Exit;
  end;
  if (DrawMode = mdTile) and (MainBrush = mbFillAttrib) then begin
    RecusionCount := 0;
    CopyTemp;
    DrawFillAttrib(xx, yy, Shift);
    Edited := True;
  end;
  if mbLeft = Button then begin
    case DrawMode of
      mdTile:
        case MainBrush of
          mbAuto:
            begin
              xx := xx div 4 * 4;
              yy := yy div 4 * 4;
              CopyTemp;
              DrawAutoTile(xx, yy, Shift);
              Edited := True;
            end;
          mbNormal:
            begin
              CopyTemp;
              DrawTileDetail(xx, yy, Shift);
                     //DrawNormalTile (xx, yy, Shift);
              Edited := True;
            end;
          mbFill:
            begin
              xx := xx div 2 * 2;
              yy := yy div 2 * 2;
              RecusionCount := 0;
              n := GetBkImg(xx, yy);
              if n >= 0 then FillIndex := n div UNITBLOCK
              else FillIndex := -1;
              CopyTemp;
              DrawFill(xx, yy, Shift);
              Edited := True;
            end;
        end;
      mdMiddle:
        case MainBrush of
          mbAuto:
            begin
              CopyTemp;
              DrawAutoMiddleTile(xx, yy, Shift);
              Edited := True;
            end;
        end;
      mdTileDetail:
        begin
               //CopyTemp;
               //DrawTileDetail (xx, yy, Shift);
               //Edited := TRUE;
        end;
      mdObj:
        begin
          CopyTemp;
          DrawObject(xx, yy, Shift);
          Edited := True;
        end;
      mdObjSet:
        begin
          CopyTemp;
          DrawObjectSet(xx, yy, Shift);
          Edited := True;
        end;
      mdLight:
        begin
          CopyTemp;
          if ssAlt in Shift then
            UpdateLight(xx, yy)
          else AddLight(xx, yy);
          Edited := True;
        end;
      mdDoor:
        begin
          CopyTemp;
          UpdateDoor(xx, yy);
          Edited := True;
        end;
    end;
  end;
end;

procedure TFrmMain.MapPaintMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  ;
end;

procedure TFrmMain.MapPaintMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: integer);
var
  xx, yy: integer;
  Button: TMouseButton;
begin
  if BoxVisible then begin
    DrawCursor(BoxX, BoxY);
    BoxVisible := False;
  end;
  xx := Trunc(word(X) / UNITX / Zoom);
  yy := Trunc(word(Y) / UNITY / Zoom);

  if MainBrush = mbAttrib then begin
    Button := mbMiddle;
    if ssLeft in Shift then Button := mbLeft;
    if ssRight in Shift then Button := mbRight;
    DrawXorAttrib(xx, yy, Button, Shift);
    Exit;
  end;
  if MainBrush = mbEraser then begin
    if ssLeft in Shift then
      DrawEraser(xx, yy, Shift);
  end else begin
    case DrawMode of
      mdTile:
        case MainBrush of
          mbAuto:
            begin
              xx := xx div 4 * 4;
              yy := yy div 4 * 4;
              if (ssLeft in Shift) and (ssCtrl in Shift) then
                MapPaintMouseDown(self, mbLeft, Shift, X, Y);
            end;
          mbNormal:
            begin
              if (ssLeft in Shift) and ((ssCtrl in Shift) or (ssAlt in Shift)) then
                MapPaintMouseDown(self, mbLeft, Shift, X, Y);
            end;
          mbFill:
            begin

            end;
        end;
      mdMiddle:
        case MainBrush of
          mbAuto:
            begin
              if (ssLeft in Shift) and (ssCtrl in Shift) then begin
                CopyTemp;
                DrawAutoMiddleTile(xx, yy, Shift);
                Edited := True;
              end;
            end;
        end;
      mdTileDetail:
        ;
      mdObjSet:
        ;
      mdObj:
        ;
    end;
  end;

  if SegmentMode then
  begin
    LbXY.Caption := IntToStr(xx + FrmSegment.Offsx) + ' : ' + IntToStr(yy + FrmSegment.OffsY);
  //    Label3.Caption:=inttostr(MArr[xx + FrmSegment.Offsx,yy + FrmSegment.OffsY].Area)+'('+inttostr(MArr[xx + FrmSegment.Offsx,yy + FrmSegment.OffsY].FrImg mod $7fff)+')';
  end
  else
  begin
    LbXY.Caption := IntToStr(xx) + ' : ' + IntToStr(yy);
 //    Label3.Caption:=inttostr(MArr[xx ,yy ].Area)+'('+inttostr(MArr[xx,yy ].FrImg mod $7fff)+')'+inttostr(MArr[xx ,yy ].Area)+'('+inttostr(MArr[xx,yy ].BkImg mod $7fff)+')'+inttostr(MArr[xx ,yy ].Area)+'('+inttostr(MArr[xx,yy ].MidImg )+')'+'Light:('+Inttostr(MArr[xx,yy ].light)+')'+'AniFrame:('+Inttostr(MArr[xx,yy ].AniFrame)+')'+'AniTick:('+Inttostr(MArr[xx,yy ].AniTick)+')';

  end;
  if not BoxVisible then begin
    BoxX := xx;
    BoxY := yy;
    DrawCursor(BoxX, BoxY);
    BoxVisible := True;
  end;
end;

function TFrmMain.GetFrMask(X, Y: integer): integer;
begin
  Result := 0;
  if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then begin
    Result := (MArr[X, Y].FrImg and $8000);
  end;
end;

function TFrmMain.GetLightAddDoor(X, Y: integer; var light, door, DoorOffset: integer): Boolean;
begin
  Result := False;
  if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then begin
    light := MArr[X, Y].light;
    door := MArr[X, Y].DoorIndex;
    DoorOffset := MArr[X, Y].DoorOffset;
    Result := True;
  end;
end;

function TFrmMain.GetAni(X, Y: integer): integer;
begin
  if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then begin
    Result := ($7F and MArr[X, Y].AniFrame);
  end;
end;

procedure TFrmMain.SetLight(X, Y, value: integer);
begin
  if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then begin
    MArr[X, Y].light := value;
  end;
end;

function TFrmMain.GetBk(X, Y: integer): integer;
begin
  if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then begin
    Result := MArr[X, Y].BkImg;
  end;
end;

function TFrmMain.GetFrImg(X, Y: integer): integer;
begin
  if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then
  begin
    if MArr[X, Y].Area = 8 then
      Result := MArr[X, Y].Area * 65535 + (MArr[X, Y].FrImg and $7FFF) - 1
    else
      Result := MArr[X, Y].Area * 65535 + (MArr[X, Y].FrImg and $7FFF) - 1;

  end;
end;

function TFrmMain.GetBkImg(X, Y: integer): integer;
begin
  if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then begin
    Result := (MArr[X, Y].BkImg and $7FFF) - 1;
  end;
end;

function TFrmMain.GetMidImg(X, Y: integer): integer;
begin
  if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then begin
    Result := MArr[X, Y].MidImg - 1;
  end;
end;

procedure TFrmMain.PutTileXY(X, Y, idx: integer);
var
  bimg: integer;
begin
  if (X >= 0) and (X < MAXX) and (Y >= 0) and (Y < MAXY) then begin
      //if TileAttrib = 0 then bimg := idx
      //else bimg := $8000 or idx;
    bimg := (MArr[X, Y].BkImg and $8000) + idx;
    MArr[X, Y].BkImg := bimg;
  end;
end;

procedure TFrmMain.PutMiddleXY(X, Y, idx: integer);
begin
  if (X >= 0) and (X < MAXX) and (Y >= 0) and (Y < MAXY) then begin
    MArr[X, Y].MidImg := idx;
  end;
end;

function TFrmMain.GetBkImgUnit(X, Y: integer): integer;
begin
  if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then begin
    Result := ((MArr[X, Y].BkImg and $7FFF) - 1) mod UNITBLOCK;
  end;
end;

function TFrmMain.GetBkUnit(X, Y: integer): integer;
begin
  if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then begin
    Result := ((MArr[X, Y].BkImg and $7FFF) - 1) div UNITBLOCK;
  end;
end;

procedure TFrmMain.PutBigTileXY(X, Y, idx: integer);
var
  bimg: integer;
begin
  if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then begin
      //if TileAttrib = 0 then bimg := idx
      //else bimg := $8000 or idx;
    bimg := (MArr[X, Y].BkImg and $8000) + idx;
    MArr[X, Y].BkImg := bimg;
    bimg := (MArr[X + 1, Y].BkImg and $8000) + idx;
    MArr[X + 1, Y].BkImg := bimg;
    bimg := (MArr[X, Y + 1].BkImg and $8000) + idx;
    MArr[X, Y + 1].BkImg := bimg;
    bimg := (MArr[X + 1, Y + 1].BkImg and $8000) + idx;
    MArr[X + 1, Y + 1].BkImg := bimg;
  end;
end;

procedure TFrmMain.PutObjXY(X, Y, idx: integer);
var
  bimg: integer;
begin
  if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then begin
    bimg := (MArr[X, Y].FrImg and $8000) + idx mod 65535;
    MArr[X, Y].FrImg := bimg;
    MArr[X, Y].Area := idx div 65535;
  end;
end;

function TFrmMain.DrawFill(xx, yy: integer; Shift: TShiftState): Boolean;
var
  Img, idx, un, drimg: integer;
begin
  if {(RecusionCount < 200000) and }(xx >= 0) and (yy >= 0) and (xx < MapWidth) and (yy < MapHeight) then begin
    inc(RecusionCount);
    Img := GetBkImg(xx, yy);
    idx := Img mod UNITBLOCK;
    if Img >= 0 then un := Img div UNITBLOCK
    else un := -1;
    if (un = FillIndex) and (((idx >= 0) and (idx < 5)) or (idx = 99) or (idx = -1)) then begin
      if un <> ImageIndex then begin
        DrawOneDr(xx, yy, ImageIndex, Random(5));
        DrawFill(xx - 2, yy, Shift);
        DrawFill(xx, yy - 2, Shift);
        DrawFill(xx + 2, yy, Shift);
        DrawFill(xx, yy + 2, Shift);
      end else begin
        Dec(RecusionCount);
        Exit;
      end;
    end;
  end else begin
    Dec(RecusionCount);
    Exit;
  end;
end;

function TFrmMain.DrawFillAttrib(xx, yy: integer; Shift: TShiftState): Boolean;
var
  Img, idx, un, drimg, attr: integer;
begin
  if (RecusionCount < 65535) and (xx >= 0) and (yy >= 0) and (xx < MapWidth) and (yy < MapHeight) then begin
    inc(RecusionCount);
    if ssLeft in Shift then attr := MArr[xx, yy].BkImg and $8000;
    if ssRight in Shift then attr := MArr[xx, yy].FrImg and $8000;
    if (attr = 0) then begin
      if ssLeft in Shift then MArr[xx, yy].BkImg := MArr[xx, yy].BkImg or $8000;
      if ssRight in Shift then MArr[xx, yy].FrImg := MArr[xx, yy].FrImg or $8000;
      DrawFillAttrib(xx - 1, yy, Shift);
      DrawFillAttrib(xx, yy - 1, Shift);
      DrawFillAttrib(xx + 1, yy, Shift);
      DrawFillAttrib(xx, yy + 1, Shift);
    end else begin
      Dec(RecusionCount);
      Exit;
    end;
  end else begin
    Dec(RecusionCount);
    Exit;
  end;
end;

procedure TFrmMain.DrawEraser(xx, yy: integer; Shift: TShiftState);
var
  I, j, n: integer;
begin
  n := 0;
  if ssCtrl in Shift then n := 1;
  if ssShift in Shift then n := 10;
  if n > 0 then begin
    for I := xx - n to xx + n do
      for j := yy - n to yy + n do begin
            //MArr[i, j].BkImg := 0; //MArr[i, j].BkImg and $7FFF;
        if ssAlt in Shift then MArr[I, j].MidImg := 0
        else MArr[I, j].FrImg := 0;
        if ssCtrl in Shift then MArr[I, j].BkImg := MArr[I, j].BkImg and $7FFF;
        MArr[I, j].AniFrame := 0;
        MArr[I, j].AniTick := 0;
        MArr[I, j].DoorIndex := 0;
        MArr[I, j].DoorOffset := 0;
      end;
  end else begin
      //MArr[xx, yy].BkImg := 0; //MArr[xx, yy].BkImg and $7FFF;
    if ssAlt in Shift then MArr[xx, yy].MidImg := 0
    else MArr[xx, yy].FrImg := 0;
    MArr[xx, yy].AniFrame := 0;
    MArr[xx, yy].AniTick := 0;
    MArr[xx, yy].DoorIndex := 0;
    MArr[xx, yy].DoorOffset := 0;
  end;
end;

procedure TFrmMain.DrawObject(xx, yy: integer; Shift: TShiftState);
var
  idx: integer;
begin
  if ssAlt in Shift then begin
    DrawObjDr(xx, yy, -1);
  end else begin
    idx := FrmObj.GetCurrentIndex;
    if idx >= 0 then begin
      if ssCtrl in Shift then begin
        DrawObjDr(xx, yy, idx xor $8000);
      end else begin
        DrawObjDr(xx, yy, idx);
      end;
    end;
  end;
end;

function TFrmMain.CheckCollision(xx, yy: integer): Boolean;
var
  n: integer;
begin
  if (xx >= 0) and (xx < MAXX - 1) and (yy >= 0) and (yy < MAXY - 1) then begin
    n := MArr[xx, yy].FrImg and $7FFF;
    if n > 0 then Result := True
    else Result := False;
  end else
    Result := False;
end;

procedure TFrmMain.DrawObjectSet(xx, yy: integer; Shift: TShiftState);
var
  I, ix, iy: integer;
  plist: TList;
  p: PTPieceInfo;
  flag: Boolean;
begin
  flag := True;
  plist := FrmObjSet.GetCurrentSet;
  if plist <> nil then begin
    for I := 0 to plist.Count - 1 do begin
      p := PTPieceInfo(plist[I]);
      if p.Img >= 0 then
        if CheckCollision(xx + p.rx, yy + p.ry) then begin
          flag := False;
          Break;
        end;
    end;
    if flag then begin
      for I := 0 to plist.Count - 1 do begin
        p := PTPieceInfo(plist[I]);
        if (p.rx + xx >= 0) and (p.ry + yy >= 0) then begin
          if p.BkImg >= 0 then begin
            ix := xx div 2 * 2;
            iy := yy div 2 * 2;
            MArr[p.rx + ix, p.ry + iy].BkImg := p.BkImg + 1;
            DrawCellBk(p.rx + ix, p.ry + iy, 1, 1);
          end;
          if p.Img >= 0 then
            DrawObjDr(xx + p.rx, yy + p.ry, p.Img);
          if p.mark > 0 then
            DrawOrAttr(xx + p.rx, yy + p.ry, p.mark);
          if p.Blend then MArr[xx + p.rx, yy + p.ry].AniFrame := $80 or p.AniFrame
          else MArr[xx + p.rx, yy + p.ry].AniFrame := p.AniFrame;
          MArr[xx + p.rx, yy + p.ry].AniTick := p.AniTick;
          if p.light > 0 then
            MArr[xx + p.rx, yy + p.ry].light := p.light;
          if p.DoorIndex > 0 then begin
            MArr[xx + p.rx, yy + p.ry].DoorIndex := p.DoorIndex;
            MArr[xx + p.rx, yy + p.ry].DoorOffset := p.DoorOffset;
          end;
        end;
      end;
    end else
      Beep;
  end;
end;

procedure TFrmMain.AddLight(X, Y: integer);
var
  n: integer;
begin
  if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then begin
    n := MArr[X, Y].light;
    n := FrmGetLight.GetValue(n);
    SetLight(X, Y, n);
    DrawCellBk(X - 1, Y - 1, 1, 1);
  end;
end;

procedure TFrmMain.UpdateLight(X, Y: integer);
var
  n: integer;
begin
  if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then begin
    n := MArr[X, Y].light;
    if n > 0 then begin
      n := FrmGetLight.GetValue(n);
      MArr[X, Y].light := n;
      DrawCellBk(X - 1, Y - 1, 1, 1);
    end else
      Beep;
  end;
end;

procedure TFrmMain.UpdateDoor(X, Y: integer);
var
  idx, offs: integer;
begin
  if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then begin
    idx := MArr[X, Y].DoorIndex;
    offs := MArr[X, Y].DoorOffset;
    if FrmDoorDlg.Update(idx, offs) then begin
      MArr[X, Y].DoorIndex := idx;
      MArr[X, Y].DoorOffset := offs;
    end;
  end;
end;

function TFrmMain.GetPoint(idx: integer): integer;
begin
  Result := 0;
  if idx < 0 then Exit;
  if idx <= 4 then begin Result := 6; Exit; end;
  if idx <= 8 then begin Result := 1; Exit; end;
  if idx <= 13 then begin Result := 5; Exit; end;
  if idx <= 23 then begin Result := 4; Exit; end;
  if idx <= 28 then Result := 2;
end;

function TFrmMain.IsMyUnit(X, Y, munit, newidx: integer): Boolean;
var
  idx, uidx: integer;
begin
  Result := False;
  idx := GetBkImg(X, Y);
  if (idx <> 99) and (idx <> -1) then begin
    if munit = idx div UNITBLOCK then begin
      if GetPoint(idx mod UNITBLOCK) >= GetPoint(newidx) then
        Result := True;
    end;
  end;
end;

procedure TFrmMain.DrawOne(X, Y, munit, idx: integer);
begin
  if not IsMyUnit(X, Y, munit, idx) then begin
    PutTileXY(X, Y, munit * UNITBLOCK + idx + 1);
    DrawCellBk(X, Y, 1, 1);
  end;
end;

procedure TFrmMain.DrawOneDr(X, Y, munit, idx: integer);
begin
  PutTileXY(X, Y, munit * UNITBLOCK + idx + 1);
  DrawCellBk(X, Y, 1, 1);
end;

procedure TFrmMain.DrawObjDr(X, Y, idx: integer);
begin
  PutObjXY(X, Y, idx + 1);
  DrawCellFr(X, Y, 0, 0);
end;

procedure TFrmMain.DrawOrAttr(X, Y, mark: integer);
begin
  if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then begin
    if (mark and $01) > 0 then
      MArr[X, Y].BkImg := MArr[X, Y].BkImg or $8000;
    if (mark and $02) > 0 then
      MArr[X, Y].FrImg := MArr[X, Y].FrImg or $8000;
  end;
end;

procedure TFrmMain.DrawXorAttrib(X, Y: integer; Button: TMouseButton; Shift: TShiftState);
var
  I, j, N1, N2, xx, yy: integer;
begin
  xx := X;
  yy := Y;
  if ssShift in Shift then begin N1 := -2; N2 := 2 end
  else begin N1 := 0; N2 := 0; end;
  for I := N1 to N2 do begin
    for j := N1 to N2 do begin
      X := xx + I;
      Y := yy + j;
      if (X >= 0) and (X < MAXX - 1) and (Y >= 0) and (Y < MAXY - 1) then begin
        if Button = mbLeft then begin //Bk Attrib
          if ssCtrl in Shift then begin
            MArr[X, Y].BkImg := MArr[X, Y].BkImg and $7FFF;
          end else
            MArr[X, Y].BkImg := MArr[X, Y].BkImg or $8000;
        end;
        if Button = mbRight then begin // Fr Attrib
          if ssCtrl in Shift then begin
            MArr[X, Y].FrImg := MArr[X, Y].FrImg and $7FFF;
          end else
            MArr[X, Y].FrImg := MArr[X, Y].FrImg or $8000;
        end;
      end;
    end;
  end;
end;

procedure TFrmMain.DrawTileDetail(X, Y: integer; Shift: TShiftState);
var
  bimg: integer;
begin
  X := X div 2 * 2;
  Y := Y div 2 * 2;
  ImageDetail := FrmTile.GetCurrentIndex;
  if ssAlt in Shift then begin
    PutTileXY(X, Y, 0);
    DrawCellBk(X, Y, 1, 1);
  end else begin
    if ImageDetail >= 0 then begin
      if not (ssCtrl in Shift) then begin
        PutTileXY(X, Y, ImageDetail + 1);
        DrawCellBk(X, Y, 1, 1);
      end else begin
        PutTileXY(X, Y, (ImageDetail + 1)); // xor $8000);
        DrawCellBk(X, Y, 1, 1);
      end;
    end;
  end;
end;

procedure TFrmMain.DrawNormalTile(X, Y: integer; Shift: TShiftState);
var
  bimg: integer;
begin
  X := X div 2 * 2;
  Y := Y div 2 * 2;
  if (ssLeft in Shift) and not (ssAlt in Shift) then begin
    PutTileXY(X, Y, ImageIndex * UNITBLOCK + Random(5) + 1);
    DrawCellBk(X, Y, 1, 1);
  end;
  if ssAlt in Shift then begin
    PutTileXY(X, Y, 0);
    DrawCellBk(X, Y, 1, 1);
  end;
end;

procedure TFrmMain.DrawAutoTile(X, Y: integer; Shift: TShiftState);
  procedure DrawSide(X, Y: integer);
  var
    idx, myunit: integer;
  begin
      //idx := GetBkImg (x, y);
    myunit := ImageIndex; //idx div UNITBLOCK;
    DrawOne(X - 2, Y, myunit, 10);
    DrawOne(X, Y - 2, myunit, 10);
    DrawOne(X + 2, Y - 2, myunit, 11);
    DrawOne(X + 4, Y, myunit, 11);
    DrawOne(X - 2, Y + 2, myunit, 12);
    DrawOne(X, Y + 4, myunit, 12);
    DrawOne(X + 4, Y + 2, myunit, 13);
    DrawOne(X + 2, Y + 4, myunit, 13);
  end;

  procedure DrawWing(X, Y: integer);
  var
    I, j, xx, yy, idx, myunit: integer;
  begin
    for I := 0 to 3 do begin
      for j := 0 to 3 do begin
        xx := X - 2 + I * 2;
        yy := Y - 2 + j * 2;
        idx := GetBkImg(xx, yy);
        myunit := ImageIndex; //idx div UNITBLOCK;
        idx := idx mod UNITBLOCK;
        case idx of
          10: //up '/'
            begin
              DrawOne(xx, yy - 2, myunit, 5);
              DrawOne(xx - 2, yy, myunit, 5);
            end;
          11: //up '\'
            begin
              DrawOne(xx, yy - 2, myunit, 6);
              DrawOne(xx + 2, yy, myunit, 6);
            end;
          12: //dn '\'
            begin
              DrawOne(xx, yy + 2, myunit, 7);
              DrawOne(xx - 2, yy, myunit, 7);
            end;
          13: //dn '/'
            begin
              DrawOne(xx, yy + 2, myunit, 8);
              DrawOne(xx + 2, yy, myunit, 8);
            end;
        end;
      end;
    end;
  end;

  procedure SolidBlock(xx, yy, myunit, idx: integer);
  var
    p, p1, p2, p3, p4, p12, p23, p34, p14: integer;
  begin
    p := GetPoint(idx);
    if GetBkUnit(xx - 2, yy) = myunit then p1 := GetPoint(GetBkImgUnit(xx - 2, yy))
    else p1 := 0;
    if GetBkUnit(xx, yy - 2) = myunit then p2 := GetPoint(GetBkImgUnit(xx, yy - 2))
    else p2 := 0;
    if GetBkUnit(xx + 2, yy) = myunit then p3 := GetPoint(GetBkImgUnit(xx + 2, yy))
    else p3 := 0;
    if GetBkUnit(xx, yy + 2) = myunit then p4 := GetPoint(GetBkImgUnit(xx, yy + 2))
    else p4 := 0;
      {p12 := GetPoint (GetBkImgUnit (xx-2, yy-2));
      p23 := GetPoint (GetBkImgUnit (xx+2, yy-2));
      p34 := GetPoint (GetBkImgUnit (xx+2, yy+2));
      p14 := GetPoint (GetBkImgUnit (xx-2, yy+2));}
    if (p1 >= 4) and (p2 >= 4) and (p3 >= 4) and (p4 >= 4) then begin
      DrawOneDr(xx, yy, myunit, Random(5));
    end;
  end;

  procedure AssemblePuzzle(xx, yy, myunit, idx: integer);
  var
    d1, d2, d3, d4: integer;
  begin
    if (idx = 10) then begin
      d1 := GetBkImgUnit(xx, yy + 2);
      if (d1 = 12) or (d1 = 22) then DrawOneDr(xx, yy, myunit, 20);
      d2 := GetBkImgUnit(xx + 2, yy);
      if (d2 = 11) or (d2 = 16) then DrawOneDr(xx, yy, myunit, 15);
    end;
    if (idx = 12) then begin
      d1 := GetBkImgUnit(xx, yy - 2);
      if (d1 = 10) or (d1 = 20) then DrawOneDr(xx, yy, myunit, 22);
      d2 := GetBkImgUnit(xx + 2, yy);
      if (d2 = 13) or (d2 = 18) then DrawOneDr(xx, yy, myunit, 17);
    end;
    if (idx = 11) then begin
      d1 := GetBkImgUnit(xx, yy + 2);
      if (d1 = 13) or (d1 = 23) then DrawOneDr(xx, yy, myunit, 21);
      d2 := GetBkImgUnit(xx - 2, yy);
      if (d2 = 10) or (d2 = 15) then DrawOneDr(xx, yy, myunit, 16);
    end;
    if (idx = 13) then begin
      d1 := GetBkImgUnit(xx, yy - 2);
      if (d1 = 11) or (d1 = 21) then DrawOneDr(xx, yy, myunit, 23);
      d2 := GetBkImgUnit(xx - 2, yy);
      if (d2 = 12) or (d2 = 17) then DrawOneDr(xx, yy, myunit, 18);
    end;

    if (idx = 15) then begin
      d1 := GetBkImgUnit(xx + 2, yy);
      if (d1 <> 16) and (d1 <> 11) then DrawOneDr(xx, yy, myunit, 10);
    end;
    if (idx = 16) then begin
      d1 := GetBkImgUnit(xx - 2, yy);
      if (d1 <> 15) and (d1 <> 10) then DrawOneDr(xx, yy, myunit, 11);
    end;
    if (idx = 17) then begin
      d1 := GetBkImgUnit(xx + 2, yy);
      if (d1 <> 18) and (d1 <> 13) then DrawOneDr(xx, yy, myunit, 12);
    end;
    if (idx = 18) then begin
      d1 := GetBkImgUnit(xx - 2, yy);
      if (d1 <> 17) and (d1 <> 12) then DrawOneDr(xx, yy, myunit, 13);
    end;
    if (idx = 20) then begin
      d1 := GetBkImgUnit(xx, yy + 2);
      if (d1 <> 22) and (d1 <> 12) then DrawOneDr(xx, yy, myunit, 10);
    end;
    if (idx = 21) then begin
      d1 := GetBkImgUnit(xx, yy + 2);
      if (d1 <> 23) and (d1 <> 13) then DrawOneDr(xx, yy, myunit, 11);
    end;
    if (idx = 22) then begin
      d1 := GetBkImgUnit(xx, yy - 2);
      if (d1 <> 20) and (d1 <> 10) then DrawOneDr(xx, yy, myunit, 12);
    end;
    if (idx = 23) then begin
      d1 := GetBkImgUnit(xx, yy - 2);
      if (d1 <> 21) and (d1 <> 11) then DrawOneDr(xx, yy, myunit, 13);
    end;

    if (idx >= 0) and (idx <= 4) then begin
      d1 := GetBkImgUnit(xx - 2, yy);
      d2 := GetBkImgUnit(xx, yy - 2);
      d3 := GetBkImgUnit(xx + 2, yy);
      d4 := GetBkImgUnit(xx, yy + 2);
      if ((d1 = 11) or (d1 = 16)) and ((d2 = 12) or (d2 = 22)) then
        DrawOneDr(xx, yy, myunit, 10);
      if ((d2 = 13) or (d2 = 23)) and ((d3 = 10) or (d3 = 15)) then
        DrawOneDr(xx, yy, myunit, 11);
      if ((d3 = 12) or (d3 = 17)) and ((d4 = 11) or (d4 = 21)) then
        DrawOneDr(xx, yy, myunit, 13);
      if ((d1 = 13) or (d1 = 18)) and ((d4 = 10) or (d4 = 20)) then
        DrawOneDr(xx, yy, myunit, 12);
    end;
    if (GetBkUnit(xx, yy) <> myunit) or (idx = -1) or (idx = 99) then begin
      d1 := GetBkImgUnit(xx - 2, yy);
      d2 := GetBkImgUnit(xx, yy - 2);
      d3 := GetBkImgUnit(xx + 2, yy);
      d4 := GetBkImgUnit(xx, yy + 2);
      if (d4 = 20) and (d3 = 15) then DrawOneDr(xx, yy, myunit, 5);
      if (d1 = 16) and (d4 = 21) then DrawOneDr(xx, yy, myunit, 6);
      if (d2 = 23) and (d1 = 18) then DrawOneDr(xx, yy, myunit, 8);
      if (d3 = 17) and (d2 = 22) then DrawOneDr(xx, yy, myunit, 7);
    end;
  end;

  procedure DrawRemainBlock(X, Y: integer);
  var
    I, j, xx, yy, idx, myunit: integer;
  begin
    for I := 0 to 6 do begin
      for j := 0 to 6 do begin
        xx := X - 3 * 2 + I * 2;
        yy := Y - 3 * 2 + j * 2;
        idx := GetBkImg(xx, yy);
        myunit := ImageIndex; //idx div UNITBLOCK;
        idx := idx mod UNITBLOCK;
        SolidBlock(xx, yy, myunit, idx);
      end;
    end;
    for I := 0 to 6 do begin
      for j := 0 to 6 do begin
        xx := X - 3 * 2 + I * 2;
        yy := Y - 3 * 2 + j * 2;
        idx := GetBkImg(xx, yy);
        myunit := ImageIndex; //idx div UNITBLOCK;
        idx := idx mod UNITBLOCK;
        AssemblePuzzle(xx, yy, myunit, idx);
      end;
    end;
  end;

var
  I, j: integer;
begin
  X := X div 2 * 2;
  Y := Y div 2 * 2;

  for I := 0 to 1 do
    for j := 0 to 1 do begin
      PutBigTileXY(X + I * 2, Y + j * 2, ImageIndex * UNITBLOCK + Random(5) + 1);
      DrawCellBk(X + I * 2, Y + j * 2, 1, 1);
    end;

  DrawSide(X, Y);
  DrawRemainBlock(X, Y);
  DrawRemainBlock(X, Y);
  DrawWing(X, Y);
end;

procedure TFrmMain.DrawAutoMiddleTile(X, Y: integer; Shift: TShiftState);
var
  diu, di, changecount, WW, HH: integer;
  rlist: TList;

  function Img(idx: integer): integer;
  begin
    if idx >= 1 then
      Result := MiddleIndex * MIDDLEBLOCK + idx * 4 + Random(4) + 4 + 1
    else Result := MiddleIndex * MIDDLEBLOCK + Random(8) + 1;
  end;
  procedure PutTile(X, Y, idx: integer);
  var
    I: integer;
    p: Pointer;
  begin
    inc(changecount);
    PutMiddleXY(X, Y, idx);
    p := Pointer(MakeLong(word(X), word(Y)));
    for I := 0 to rlist.Count - 1 do
      if rlist[I] = p then
        Exit;
    rlist.Add(p);
  end;
  function un(X, Y: integer): integer;
  var
    idx: integer;
  begin
    idx := GetMidImg(X, Y);
    if (idx >= MiddleIndex * MIDDLEBLOCK) and (idx < (MiddleIndex + 1) * MIDDLEBLOCK) then begin
      idx := idx - MiddleIndex * MIDDLEBLOCK;
      if idx < 8 then Result := 0
      else Result := (idx - 8) div 4 + 1;
    end else
      Result := -1;
  end;

  procedure DrawSide(X, Y: integer);
  var
    idx: integer;
  begin
    if un(X, Y - 1) < 0 then PutTile(X, Y - 1, Img(1));
    if un(X + 1, Y - 1) < 0 then PutTile(X + 1, Y - 1, Img(2));
    if un(X + 1, Y) < 0 then PutTile(X + 1, Y, Img(3));
    if un(X + 1, Y + 1) < 0 then PutTile(X + 1, Y + 1, Img(4));
    if un(X, Y + 1) < 0 then PutTile(X, Y + 1, Img(5));
    if un(X - 1, Y + 1) < 0 then PutTile(X - 1, Y + 1, Img(6));
    if un(X - 1, Y) < 0 then PutTile(X - 1, Y, Img(7));
    if un(X - 1, Y - 1) < 0 then PutTile(X - 1, Y - 1, Img(8));
  end;
  procedure DrawAutoPattern(X, Y: integer);
  var
    I, j, c, N1, N2: integer;
  begin
    for I := X - WW to X + WW do
      for j := Y - HH to Y + HH do begin
        if (I > 0) and (j > 0) then begin
          if un(I, j) > 0 then begin
                  // (¤¡)
            N1 := un(I, j - 1);
            N2 := un(I + 1, j);
            if un(I, j) <> 11 then
              if ((N1 = 2) or (N1 = 3) or (N1 = 12)) and ((N2 = 2) or (N2 = 1) or (N2 = 10)) then begin
                PutTile(I, j, Img(11));
              end;
            N1 := un(I + 1, j);
            N2 := un(I, j + 1);
            if un(I, j) <> 12 then
              if ((N1 = 4) or (N1 = 5) or (N1 = 9)) and ((N2 = 4) or (N2 = 3) or (N2 = 11)) then begin
                PutTile(I, j, Img(12));
              end;
            N1 := un(I - 1, j);
            N2 := un(I, j + 1);
            if un(I, j) <> 9 then
              if ((N1 = 6) or (N1 = 5) or (N1 = 12)) and ((N2 = 6) or (N2 = 7) or (N2 = 10)) then begin
                PutTile(I, j, Img(9));
              end;
            N1 := un(I, j - 1);
            N2 := un(I - 1, j);
            if un(I, j) <> 10 then
              if ((N1 = 8) or (N1 = 7) or (N1 = 9)) and ((N2 = 8) or (N2 = 1) or (N2 = 11)) then begin
                PutTile(I, j, Img(10));
              end;
                  // (¤¤)
            N1 := un(I - 1, j);
            N2 := un(I + 1, j);
            if un(I, j) <> 1 then
              if ((N1 = 1) or (N1 = 8) or (N1 = 11)) and ((N2 = 2) or (N2 = 1) or (N2 = 10)) and (un(I, j - 1) < 0) then begin
                PutTile(I, j, Img(1));
              end;
            N1 := un(I, j - 1);
            N2 := un(I, j + 1);
            if un(I, j) <> 3 then
              if ((N1 = 3) or (N1 = 2) or (N1 = 12)) and ((N2 = 3) or (N2 = 4) or (N2 = 11)) and (un(I + 1, j) < 0) then begin
                PutTile(I, j, Img(3));
              end;
            N1 := un(I - 1, j);
            N2 := un(I + 1, j);
            if un(I, j) <> 5 then
              if ((N1 = 6) or (N1 = 5) or (N1 = 12)) and ((N2 = 5) or (N2 = 4) or (N2 = 9)) and (un(I, j + 1) < 0) then begin
                PutTile(I, j, Img(5));
              end;
            N1 := un(I, j - 1);
            N2 := un(I, j + 1);
            if un(I, j) <> 7 then
              if ((N1 = 7) or (N1 = 8) or (N1 = 9)) and ((N2 = 7) or (N2 = 6) or (N2 = 10)) and (un(I - 1, j) < 0) then begin
                PutTile(I, j, Img(7));
              end;
                  // (¤§)
            if un(I, j) <> 1 then
              if {(UN(i,j-1)=-1) and (UN(i+1,j-1)=-1) and}(un(I, j + 1) = 0) and (un(I + 1, j + 1) = 0) then
                if (un(I, j) = 2) and ((un(I + 1, j) = 8) or (un(I + 1, j) = 7)) then
                  PutTile(I, j, Img(1));
            if un(I, j) <> 3 then
              if {(UN(i+1,j)=-1) and (UN(i+1,j+1)=-1) and}(un(I - 1, j) = 0) and (un(I - 1, j + 1) = 0) then
                if (un(I, j) = 4) and ((un(I, j + 1) = 2) or (un(I, j + 1) = 1)) then
                  PutTile(I, j, Img(3));
            if un(I, j) <> 5 then
              if {(UN(i,j+1)=-1) and (UN(i+1,j+1)=-1) and}(un(I, j - 1) = 0) and (un(I + 1, j - 1) = 0) then
                if (un(I, j) = 4) and ((un(I + 1, j) = 6) or (un(I + 1, j) = 7)) then
                  PutTile(I, j, Img(5));
            if un(I, j) <> 7 then
              if {(UN(i-1,j)=-1) and (UN(i-1,j+1)=-1) and}(un(I + 1, j) = 0) and (un(I + 1, j + 1) = 0) then
                if (un(I, j) = 6) and ((un(I, j + 1) = 8) or (un(I, j + 1) = 7)) then
                  PutTile(I, j, Img(7));
                  // (¤©)
            if (un(I - 1, j) = 5) and (un(I, j - 1) = 3) and (un(I + 1, j) = 1) and (un(I, j + 1) = 7) or
              (un(I - 1, j) = 1) and (un(I, j + 1) = 3) and (un(I, j - 1) = 7) and (un(I + 1, j) = 5) then begin
              PutTile(I, j, Img(0));
              DrawSide(I, j);
            end;
                  // (¤±)
            if un(I, j) = 2 then begin
              if (un(I + 1, j) > -1) and (un(I, j + 1) = 0) and (un(I + 1, j + 1) >= 0) then
                PutTile(I, j, Img(1));
              if (un(I, j - 1) > -1) and (un(I - 1, j) = 0) and (un(I - 1, j - 1) >= 0) then
                PutTile(I, j, Img(3));
            end;
            if un(I, j) = 4 then begin
              if (un(I + 1, j) > -1) and (un(I, j - 1) = 0) and (un(I + 1, j - 1) >= 0) then
                PutTile(I, j, Img(5));
              if (un(I, j + 1) > -1) and (un(I - 1, j) = 0) and (un(I - 1, j + 1) >= 0) then
                PutTile(I, j, Img(3));
            end;
            if un(I, j) = 6 then begin
              if (un(I, j + 1) > -1) and (un(I + 1, j) = 0) and (un(I + 1, j + 1) >= 0) then
                PutTile(I, j, Img(7));
              if (un(I - 1, j) > -1) and (un(I - 1, j - 1) = 0) and (un(I, j - 1) >= 0) then
                PutTile(I, j, Img(5));
            end;
            if un(I, j) = 8 then begin
              if (un(I, j - 1) > -1) and (un(I + 1, j) = 0) and (un(I + 1, j - 1) >= 0) then
                PutTile(I, j, Img(7));
              if (un(I - 1, j) > -1) and (un(I, j + 1) = 0) and (un(I - 1, j + 1) >= 0) then
                PutTile(I, j, Img(1));
            end;
                  // else
            c := 0;
            if un(I, j - 1) >= 0 then inc(c);
            if un(I + 1, j - 1) >= 0 then inc(c);
            if un(I + 1, j) >= 0 then inc(c);
            if un(I + 1, j + 1) >= 0 then inc(c);
            if un(I, j + 1) >= 0 then inc(c);
            if un(I - 1, j + 1) >= 0 then inc(c);
            if un(I - 1, j) >= 0 then inc(c);
            if un(I - 1, j - 1) >= 0 then inc(c);
            if c >= 8 then
              PutTile(I, j, Img(0));

          end;
        end;
      end;
  end;
var
  I, k, n, rx, ry: integer;
begin
  rlist := TList.Create;
  PutTile(X, Y, Img(0));

  DrawSide(X, Y);
  WW := 1;
  HH := 1;
  for k := 0 to 30 do begin
    changecount := 0;
    DrawAutoPattern(X, Y);
    if changecount = 0 then Break;
    inc(WW);
    inc(HH);
  end;

  for I := 0 to rlist.Count - 1 do begin
    n := integer(rlist[I]);
    DrawCellBk(Loword(n), Hiword(n), 0, 0);
  end;
  rlist.Free;
end;

procedure TFrmMain.DrawCellBk(X, Y, w, h: integer);
var
  I, j, dx, dy, xx, yy, lcorner, tcorner, idx, light, door, dooroffs: integer;
begin
  lcorner := Trunc(MainScroll.HorzScrollBar.Position div UNITX / Zoom);
  tcorner := Trunc(MainScroll.VertScrollBar.Position div UNITY / Zoom);

  if ShowBackgroundTile1.Checked then
    for j := Y to Y + h do
      for I := X to X + w do begin
        xx := I;
        yy := j;
        if (xx >= 0) and (xx < MAXX) and (yy >= 0) and (yy < MAXY) then begin
          if (xx >= lcorner - 1) and (yy >= tcorner - 1) and
            (xx <= lcorner + Round(Width div UNITX / Zoom)) and
            (yy <= tcorner + Round(Height div UNITY / Zoom)) then begin
            idx := GetBkImg(xx, yy);
            dx := Trunc(xx * UNITX * Zoom);
            dy := Trunc(yy * UNITY * Zoom);
            if (xx mod 2 = 0) and (yy mod 2 = 0) then begin
              WILTiles.DrawZoom(MapPaint.Canvas, dx, dy, idx, Zoom);
            end else
              WILTiles.DrawZoom(MapPaint.Canvas, dx, dy, 99, Zoom);
          end;
        end;
      end;
  if ShowMiddleTile1.Checked then
    for j := Y to Y + h do
      for I := X to X + w do begin
        xx := I;
        yy := j;
        if (xx >= 0) and (xx < MAXX) and (yy >= 0) and (yy < MAXY) then begin
          if (xx >= lcorner - 1) and (yy >= tcorner - 1) and
            (xx <= lcorner + Round(Width div UNITX / Zoom)) and
            (yy <= tcorner + Round(Height div UNITY / Zoom)) then begin
            idx := GetMidImg(xx, yy);
            dx := Trunc(xx * UNITX * Zoom);
            dy := Trunc(yy * UNITY * Zoom);
            if idx >= 0 then
              if MiddleTransparent1.Checked then
                WilSmTiles.DrawZoomEx(MapPaint.Canvas, dx, dy, idx, Zoom, True)
              else
                WilSmTiles.DrawZoom(MapPaint.Canvas, dx, dy, idx, Zoom)
          end;
        end;
      end;
  for j := Y to Y + h do
    for I := X to X + w do begin
      xx := I; yy := j;
      if (xx >= 0) and (xx < MAXX) and (yy >= 0) and (yy < MAXY) then begin
        if (xx >= lcorner - 1) and (yy >= tcorner - 1) and
          (xx <= lcorner + Round(Width div UNITX / Zoom)) and
          (yy <= tcorner + Round(Height div UNITY / Zoom)) then begin
          dx := Trunc(xx * UNITX * Zoom);
          dy := Trunc(yy * UNITY * Zoom);
          light := 0;
          door := 0;
          dooroffs := 0;
          if GetLightAddDoor(xx, yy, light, door, dooroffs) then begin
            if light > 0 then
              WilSmTiles.DrawZoomEx(MapPaint.Canvas, dx, dy, LIGHTSPOT, Zoom, True);
            if (Zoom >= 0.8) and (door > 0) then begin
              if (door and $80) > 0 then
                MapPaint.Canvas.TextOut(dx + 16, dy - 26, 'Dx')
              else MapPaint.Canvas.TextOut(dx + 16, dy - 26, 'D');
            end;
          end;
        end;
      end;
    end;
end;

procedure TFrmMain.DrawCellFr(X, Y, w, h: integer);
var
  I, j, dx, dy, lcorner, tcorner, idx: integer;
begin
  lcorner := Trunc(MainScroll.HorzScrollBar.Position div UNITX / Zoom);
  tcorner := Trunc(MainScroll.VertScrollBar.Position div UNITY / Zoom);

  if ShowObject1.Checked then
    if (X >= 0) and (X < MAXX) and (Y >= 0) and (Y < MAXY) then begin
      if (X >= lcorner - 1) and (Y >= tcorner - 1) and
        (X <= lcorner + Round(Width div UNITX / Zoom)) and
        (Y <= tcorner + Round(Height div UNITY / Zoom)) then begin
        idx := GetFrImg(X, Y);
        dx := Trunc(X * UNITX * Zoom);
        dy := Trunc((Y + 1) * UNITY * Zoom);
        if (idx >= 0) then
          ObjWil(idx).DrawZoomEx(MapPaint.Canvas, dx, dy, idx mod 65535, Zoom, False);
      end;
    end;
  if ShowAttribMarks1.Checked then
    if (X >= lcorner - 1) and (Y >= tcorner - 1) and
      (X <= lcorner + Round(Width div UNITX / Zoom)) and
      (Y <= tcorner + Round(Height div UNITY / Zoom)) then begin
      if (X >= 0) and (X < MAXX) and (Y >= 0) and (Y < MAXY) then begin
        dx := Trunc(X * UNITX * Zoom);
        dy := Trunc(Y * UNITY * Zoom);
        idx := GetBk(X, Y);
        if idx >= 0 then
          if (idx and $8000) > 0 then WilSmTiles.DrawZoomEx(MapPaint.Canvas, dx, dy, BKMASK, Zoom, True);
        idx := GetFrMask(X, Y);
        if idx > 0 then
          WilSmTiles.DrawZoomEx(MapPaint.Canvas, dx, dy, FRMASK, Zoom, True);
      end;
    end;
end;

procedure TFrmMain.MapPaintPaint(Sender: TObject);
var
  I, j, xx, yy, dx, dy, lcorner, tcorner, idx, light, door, dooroffs: integer;
begin
  lcorner := Trunc(MainScroll.HorzScrollBar.Position div UNITX / Zoom);
  tcorner := Trunc(MainScroll.VertScrollBar.Position div UNITY / Zoom);

  if ShowBackgroundTile1.Checked then
    for j := 0 to (Trunc(MapPaint.Height div UNITY / Zoom) + 2) do
      for I := 0 to (Trunc(MapPaint.Width div UNITX / Zoom) + 2) do begin
        xx := I;
        yy := j;
        if (xx >= lcorner - 1) and (yy >= tcorner - 1) and
          (xx <= lcorner + Round(Width div UNITX / Zoom)) and
          (yy <= tcorner + Round(Height div UNITY / Zoom)) then begin
          if (xx >= 0) and (xx < MAXX) and (yy >= 0) and (yy < MAXY) then begin
            idx := GetBkImg(xx, yy);
            if (xx mod 2 = 0) and (yy mod 2 = 0) then begin
              xx := Trunc(xx * UNITX * Zoom);
              yy := Trunc(yy * UNITY * Zoom);
              if idx >= 0 then begin
                WILTiles.DrawZoom(MapPaint.Canvas, xx, yy, idx, Zoom);
              end;
            end;
          end;
        end;
      end;

  if ShowMiddleTile1.Checked then
    for j := 0 to (Trunc(MapPaint.Height div UNITY / Zoom) + 2) do
      for I := 0 to (Trunc(MapPaint.Width div UNITX / Zoom) + 2) do begin
        xx := I;
        yy := j;
        if (xx >= lcorner - 1) and (yy >= tcorner - 1) and
          (xx <= lcorner + Round(Width div UNITX / Zoom)) and
          (yy <= tcorner + Round(Height div UNITY / Zoom)) then begin
          if (xx >= 0) and (xx < MAXX) and (yy >= 0) and (yy < MAXY) then begin
            idx := GetMidImg(xx, yy);
            xx := Trunc(xx * UNITX * Zoom);
            yy := Trunc(yy * UNITY * Zoom);
            if idx >= 0 then begin
              if MiddleTransparent1.Checked then
                WilSmTiles.DrawZoomEx(MapPaint.Canvas, xx, yy, idx, Zoom, True)
              else WilSmTiles.DrawZoom(MapPaint.Canvas, xx, yy, idx, Zoom);
            end;
          end;
        end;
      end;

  if ShowObject1.Checked then
    for j := 0 to (Trunc(MapPaint.Height div UNITY / Zoom) + 10) do
      for I := 0 to (Trunc(MapPaint.Width div UNITX / Zoom) + 2) do begin
        xx := I;
        yy := j;
        if (xx >= lcorner - 1) and (yy >= tcorner - 1) and
          (xx <= lcorner + Round(Width div UNITX / Zoom)) and
          (yy <= tcorner + Round(Height div UNITY / Zoom)) then begin
          if (xx >= 0) and (xx < MAXX) and (yy >= 0) and (yy < MAXY) then
          begin

            if (MArr[xx, yy].Area = 5) and (MArr[xx, yy].FrImg = 12048) then
              idx := GetFrImg(xx, yy)
            else
              idx := GetFrImg(xx, yy);
            xx := Trunc(xx * UNITX * Zoom);
            yy := Trunc((yy + 1) * UNITY * Zoom);
            if (idx >= 0) then
              ObjWil(idx).DrawZoomEx(MapPaint.Canvas, xx, yy, idx mod 65535, Zoom, False);

          end;
        end;
      end;

  for j := 0 to (Trunc(MapPaint.Height div UNITY / Zoom) + 2) do
    for I := 0 to (Trunc(MapPaint.Width div UNITX / Zoom) + 2) do begin
      xx := I;
      yy := j;
      if (xx >= lcorner - 1) and (yy >= tcorner - 1) and
        (xx <= lcorner + Round(Width div UNITX / Zoom)) and
        (yy <= tcorner + Round(Height div UNITY / Zoom)) then begin
        if (xx >= 0) and (xx < MAXX) and (yy >= 0) and (yy < MAXY) then begin
          dx := Trunc(xx * UNITX * Zoom);
          dy := Trunc(yy * UNITY * Zoom);
          if ShowAttribMarks1.Checked then begin
            idx := GetBk(xx, yy);
            if idx >= 0 then
              if (idx and $8000) > 0 then
                WilSmTiles.DrawZoomEx(MapPaint.Canvas, dx, dy, BKMASK, Zoom, True);
            idx := GetFrMask(xx, yy);
            if idx > 0 then
              WilSmTiles.DrawZoomEx(MapPaint.Canvas, dx, dy, FRMASK, Zoom, True);
            idx := GetAni(xx, yy);
            if idx > 0 then
              MapPaint.Canvas.TextOut(dx, dy, '*');
          end;
          light := 0;
          door := 0;
          dooroffs := 0;
          if GetLightAddDoor(xx, yy, light, door, dooroffs) then begin
            if light > 0 then
              WilSmTiles.DrawZoomEx(MapPaint.Canvas, dx, dy, LIGHTSPOT, Zoom, True);
            if (Zoom >= 0.9) and (door > 0) then begin
              if (door and $80) > 0 then
                MapPaint.Canvas.TextOut(dx, dy, 'Dx' + IntToStr(door and $7F) + '/' + IntToStr(dooroffs))
              else MapPaint.Canvas.TextOut(dx, dy, 'D' + IntToStr(door and $7F) + '/' + IntToStr(dooroffs));
            end;
          end;
        end;
      end;
    end;

  with MapPaint.Canvas do begin
    Pen.Color := clBlack;
    MoveTo(0, MapPaint.Height - 1);
    LineTo(MapPaint.Width - 1, MapPaint.Height - 1);
    LineTo(MapPaint.Width - 1, 0);
  end;
  if BoxVisible then begin
    BoxVisible := False;
  end;
end;

procedure TFrmMain.SpeedButton1Click(Sender: TObject);
begin
  MainBrush := mbAuto;
end;

procedure TFrmMain.SpeedButton2Click(Sender: TObject);
begin
  MainBrush := mbNormal;
end;

procedure TFrmMain.SpeedButton3Click(Sender: TObject);
begin
  MainBrush := mbFill;
end;

procedure TFrmMain.SpeedButton6Click(Sender: TObject);
begin
  MainBrush := mbFillAttrib;
end;

procedure TFrmMain.SpeedButton4Click(Sender: TObject);
begin
  MainBrush := mbAttrib;
end;

procedure TFrmMain.SpeedButton5Click(Sender: TObject);
begin
  MainBrush := mbEraser;
end;


procedure TFrmMain.ZoomInClick(Sender: TObject);
begin
  if Zoom <= 0.21 then begin
    Zoom := Zoom - 0.05;
    if Zoom < 0.05 then Zoom := 0.05;
  end else begin
    Zoom := Zoom - 0.2;
    if Zoom < 0.2 then Zoom := 0.2;
  end;
  Label1.Caption := '100:' + IntToStr(Round(100 * Zoom));
  MapPaint.Width := Round(MapWidth * UNITX * Zoom) + 1;
  MapPaint.Height := Round(MapHeight * UNITY * Zoom) + 1;
  MainScroll.HorzScrollBar.Increment := Round(UNITX * 4 * Zoom);
  MainScroll.VertScrollBar.Increment := Round(UNITY * 4 * Zoom);
  MapPaint.Update; //Refresh;
end;

procedure TFrmMain.ZoomOutClick(Sender: TObject);
begin
  if Zoom < 0.2 then begin
    Zoom := Zoom + 0.05;
  end else begin
    Zoom := Zoom + 0.2;
    if (Zoom > 1.0) and (Zoom < 1.2) then Zoom := 1.0;
    if Zoom > 2.0 then Zoom := 2.0;
  end;
  Label1.Caption := '100:' + IntToStr(Round(100 * Zoom));
  MapPaint.Width := Round(MapWidth * UNITX * Zoom) + 1;
  MapPaint.Height := Round(MapHeight * UNITY * Zoom) + 1;
  MainScroll.HorzScrollBar.Increment := Round(UNITX * 4 * Zoom);
  MainScroll.VertScrollBar.Increment := Round(UNITY * 4 * Zoom);
  MapPaint.Refresh;
end;

procedure TFrmMain.FormKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  case Key of
    VK_F5: MapPaint.Refresh;
    word('z'),
      word('Z'):
      if ssCtrl in Shift then begin
        Undo;
      end;
  end;
end;

procedure TFrmMain.Tile1Click(Sender: TObject);
begin
  FrmMainPal.Show;
end;

procedure TFrmMain.Object1Click(Sender: TObject);
begin
  FrmObj.Show;
end;

procedure TFrmMain.RunObjEditer1Click(Sender: TObject);
begin
  FrmObjEdit.Execute;
end;

procedure TFrmMain.ObjectSet1Click(Sender: TObject);
begin
  FrmObjSet.Execute;
end;

procedure TFrmMain.TileDetail1Click(Sender: TObject);
begin
  FrmTile.Show;
end;

function TFrmMain.VerifyWork: Boolean;
var
  r: integer;
begin
  Result := True;
  if Edited then begin
    r := MessageDlg('ÎÄ¼þÒÔ±»¸üÐÂ£¬ÊÇ·ñ±£´æ?',
      mtWarning,
      mbYesNoCancel,
      0);
    if r = mrYes then
      if not SegmentMode then
        SaveAs1Click(self)
      else
        DoSaveSegments;
    if r = mrCancel then
      Result := False;
  end;
end;

procedure TFrmMain.New1Click(Sender: TObject);
begin
  if not VerifyWork then Exit;
  if SegmentMode then begin
    ShowMessage('Use Segment Tool');
    Exit;
  end;
  if FrmMapSize.Execute then begin
    MapWidth := FrmMapSize.MapX;
    MapHeight := FrmMapSize.MapY;
    NewMap;
    MapPaint.Refresh;
  end;
end;

procedure TFrmMain.Open1Click(Sender: TObject);
var
  I, j, n: integer;
begin
  if not VerifyWork then Exit;
  if SegmentMode then begin
    ShowMessage('Use Segment Tool');
    Exit;
  end;
  with OpenDialog1 do begin
    if Execute then begin
      if LoadFromFile(FileName) then begin
        CurrentMapName := FileName;
        LbMapName.Caption := ExtractFileNameOnly(FileName);
        MapPaint.Width := Round(MapWidth * UNITX * Zoom) + 1;
        MapPaint.Height := Round(MapHeight * UNITY * Zoom) + 1;
        CurX := 0;
        CurY := 0;

        for j := 0 to MapHeight - 1 do
          for I := 0 to MapWidth - 1 do begin
            n := (MArr[I, j].FrImg and $7FFF);
                  ///MArr[i, j].Area := n div 65535;
            MArr[I, j].FrImg := (MArr[I, j].FrImg and $8000) or (n mod 65535);
          end;

        MapPaint.Refresh;
      end;
    end;
  end;
end;

procedure TFrmMain.OpenOldFormatFile1Click(Sender: TObject);
var
  I, j, n: integer;
begin
  if not VerifyWork then Exit;
  if SegmentMode then begin
    ShowMessage('Use Segment Tool');
    Exit;
  end;
  with OpenDialog1 do begin
    if Execute then begin
      if LoadFromFile(FileName) then begin
        CurrentMapName := FileName;
        LbMapName.Caption := ExtractFileNameOnly(FileName);
        MapPaint.Width := Round(MapWidth * UNITX * Zoom) + 1;
        MapPaint.Height := Round(MapHeight * UNITY * Zoom) + 1;
        CurX := 0;
        CurY := 0;

        for j := 0 to MapHeight - 1 do
          for I := 0 to MapWidth - 1 do begin
            n := (MArr[I, j].FrImg and $7FFF);
            MArr[I, j].Area := n div 65535;
            MArr[I, j].FrImg := n mod 65535;
          end;

        MapPaint.Refresh;
      end;
    end;
  end;
end;

procedure TFrmMain.OldFromatBatchConvert1Click(Sender: TObject);
var
  I, j, k, n: integer;
  flname: string;
begin
  with OpenDialog1 do begin
    if Execute then begin
      for k := 0 to Files.Count - 1 do begin
        flname := Files[k];
        if LoadFromFile(flname) then begin
          for j := 0 to MapHeight - 1 do
            for I := 0 to MapWidth - 1 do begin
              n := (MArr[I, j].FrImg and $7FFF);
              MArr[I, j].Area := n div 65535;
              MArr[I, j].FrImg := n mod 65535;
            end;
          SaveToFile(flname);
        end;
      end;
      ShowMessage('×ª»»Íê³É!!');
    end;
  end;
end;

procedure TFrmMain.SaveAs1Click(Sender: TObject);
begin
  with SaveDialog1 do begin
    if Execute then begin
      if SaveToFile(FileName) then begin
        CurrentMapName := FileName;
        LbMapName.Caption := ExtractFileNameOnly(FileName);
        Edited := False;
      end;
    end;
  end;
end;

procedure TFrmMain.Save1Click(Sender: TObject);
begin
  if SegmentMode then begin
    ShowMessage('Use Segment Tool');
    Exit;
  end;
   //if CurrentMapName <> '' then begin
   //   SaveToFile (CurrentMapName);
   //   Edited := FALSE;
   //end else
  SaveAs1Click(self);
end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
begin
  if not SegmentMode then begin
    if Edited then
      LbMapName.Caption := 'Î´±£´æ' + ExtractFileNameOnly(CurrentMapName)
    else begin
      if CurrentMapName = '' then LbMapName.Caption := 'Î´ÃüÃû'
      else LbMapName.Caption := ExtractFileNameOnly(CurrentMapName);
    end;
  end else begin
    if Edited then
      LbMapName.Caption := 'Î´±£´æ' + FrmSegment.CurSegs[0, 0]
    else
      LbMapName.Caption := FrmSegment.CurSegs[0, 0];
  end;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  r: integer;
begin
  if VerifyWork then begin
    CanClose := True
  end else
    CanClose := False;
end;

procedure TFrmMain.BtnMarkClick(Sender: TObject);
begin
  MapPaint.Refresh;
end;

procedure TFrmMain.NewSegmentMap1Click(Sender: TObject);
begin
  FrmSegment.Show;
end;


// ---------------------------------------

//  Segment Editing

// ---------------------------------------


procedure TFrmMain.LoadSegment(col, row: integer; flname: string);
var
  I, fhandle: integer;
  header: TMapHeader;
begin
  if not FileExists(flname) then Exit;
  fhandle := FileOpen(flname, fmOpenRead or fmShareDenyNone);
  if fhandle > 0 then begin
    FileRead(fhandle, header, SizeOf(TMapHeader));
      //if header.Title = TITLEHEADER then begin
    if (header.Width > 0) and (header.Height > 0) then begin
      for I := 0 to header.Width - 1 do begin
        FileRead(fhandle, MArr[col + I, row], SizeOf(TMapInfo) * SEGY);
      end;
    end;
      //end;
    FileClose(fhandle);
  end;
end;

procedure TFrmMain.SaveSegment(col, row: integer; flname: string);
var
  I, fhandle: integer;
  header: TMapHeader;
begin
  header.Width := SEGX;
  header.Height := SEGY;
  header.Title := TITLEHEADER;
  if FileExists(flname) then
    fhandle := FileOpen(flname, fmOpenWrite or fmShareDenyNone)
  else fhandle := FileCreate(flname);
  if fhandle > 0 then begin
    FileWrite(fhandle, header, SizeOf(TMapHeader));
    for I := col to col + SEGX - 1 do begin
      FileWrite(fhandle, MArr[I, row], SizeOf(TMapInfo) * SEGY);
    end;
    FileClose(fhandle);
  end;
end;

procedure TFrmMain.DoEditSegment;
var
  I, j: integer;
  map: string;
begin
  if FrmSegment.SegPath = '' then begin
    ShowMessage('¸ÕÀú Segment Project¸¦ ÀúÀåÇÏ½Ê½Ã¿À');
      //FrmSegment.BtnSaveClick (self);
    if FrmSegment.SegPath = '' then Exit;
  end;
  SegmentMode := True;
  FillChar(MArr, SizeOf(MArr), #0);
   //FillChar (MArrUndo, sizeof(MArrUndo), #0);
  CurX := 0;
  CurY := 0;
  for I := 0 to 2 do
    for j := 0 to 2 do begin
      map := FrmSegment.CurSegs[I, j];
      if map <> '' then
        LoadSegment(I * SEGX, j * SEGY, FrmSegment.SegPath + '\' + map + '.sem');
    end;
  MapWidth := SEGX * 3;
  MapHeight := SEGY * 3;
  MapPaint.Width := Round(MapWidth * UNITX * Zoom) + 1;
  MapPaint.Height := Round(MapHeight * UNITY * Zoom) + 1;
  Edited := False;
  MapPaint.Refresh;
end;

procedure TFrmMain.DoSaveSegments;
var
  I, j: integer;
  map: string;
begin
  for I := 0 to 2 do
    for j := 0 to 2 do begin
      map := FrmSegment.CurSegs[I, j];
      if map <> '' then
        SaveSegment(I * SEGX, j * SEGY, FrmSegment.SegPath + '\' + map + '.sem');
    end;
  Edited := False;
end;

procedure TFrmMain.ClearEditSegments1Click(Sender: TObject);
begin
  FillChar(MArr, SizeOf(MArr), #0);
  MapPaint.Refresh;
end;

procedure TFrmMain.BtnLeftSegClick(Sender: TObject);
begin
  if SegmentMode then
    FrmSegment.ShiftLeftSegment;
end;

procedure TFrmMain.BtnRightSegClick(Sender: TObject);
begin
  if SegmentMode then
    FrmSegment.ShiftRightSegment;
end;

procedure TFrmMain.BtnUpSegClick(Sender: TObject);
begin
  if SegmentMode then
    FrmSegment.ShiftUpSegment;
end;

procedure TFrmMain.BtnDownSegClick(Sender: TObject);
begin
  if SegmentMode then
    FrmSegment.ShiftDownSegment;
end;

procedure TFrmMain.ObjectViewNormalSize1Click(Sender: TObject);
begin
  ObjectViewNormalSize1.Checked := not ObjectViewNormalSize1.Checked;
  if ObjectViewNormalSize1.Checked then
    FrmObj.ViewNormal := True
  else
    FrmObj.ViewNormal := False;
end;

procedure TFrmMain.SmallTile1Click(Sender: TObject);
begin
  FrmSmTile.Show;
end;

procedure TFrmMain.ShowBackgroundTile1Click(Sender: TObject);
begin
  if Sender is TMenuItem then begin
    TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
    MapPaint.Refresh;
  end;
end;

procedure TFrmMain.DrawObject1Click(Sender: TObject);
begin
  if Sender is TMenuItem then begin
    TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
    if Sender = DrawBigTile1 then DrawMode := mdTile;
    if Sender = DrawObject1 then DrawMode := mdObj;
    if Sender = DrawObjectTileSet1 then DrawMode := mdObjSet;
    if Sender = DrawSmTile1 then DrawMode := mdMiddle;
    if Sender = SetLightEffect1 then DrawMode := mdLight;
    if Sender = UpdateDoor1 then DrawMode := mdDoor;
  end;
end;

procedure TFrmMain.Resize1Click(Sender: TObject);
begin
  if FrmMapSize.Execute then begin
    MapWidth := FrmMapSize.MapX;
    MapHeight := FrmMapSize.MapY;
    if MapWidth < 0 then MapWidth := 1;
    if MapHeight < 0 then MapHeight := 1;
    MapPaint.Width := Round(MapWidth * UNITX * Zoom) + 1;
    MapPaint.Height := Round(MapHeight * UNITY * Zoom) + 1;
    CurX := 0;
    CurY := 0;
    MapPaint.Refresh;
  end;
end;

procedure TFrmMain.SaveToBitmap1Click(Sender: TObject);
var
  I, j, xx, yy, idx, m: integer;
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  m := 8;
  bmp.Width := MapWidth * UNITX div m;
  bmp.Height := MapHeight * UNITY div m;

  for j := 0 to MapHeight - 1 do
    for I := 0 to MapWidth - 1 do begin
      idx := GetBkImg(I, j);
      if (I mod 2 = 0) and (j mod 2 = 0) then begin
        xx := I * UNITX div m;
        yy := j * UNITY div m;
        if idx >= 0 then begin
          WILTiles.DrawZoom(bmp.Canvas, xx, yy, idx, 1 / m);
        end;
      end;
    end;
  for j := 0 to MapHeight - 1 do
    for I := 0 to MapWidth - 1 do begin
      idx := GetMidImg(I, j);
      xx := I * UNITX div m;
      yy := j * UNITY div m;
      if idx >= 0 then begin
        WilSmTiles.DrawZoomEx(bmp.Canvas, xx, yy, idx, 1 / m, True);
      end;
    end;
  for j := 0 to MapHeight - 1 do
    for I := 0 to MapWidth - 1 do begin
      idx := GetFrImg(I, j);
      xx := I * UNITX div m;
      yy := (j + 1) * UNITY div m;
      if idx >= 0 then begin
        ObjWil(idx).DrawZoomEx(bmp.Canvas, xx, yy, idx mod 65535, 1 / m, False);
      end;
    end;

  bmp.SaveToFile('map.bmp');
  bmp.Free;
end;

procedure TFrmMain.MapScroll1Click(Sender: TObject);
var
  xs, ys, I, k: integer;
  nilmap: TMapInfo;
begin
  CopyTemp;
  FrmScrollMap.Execute(xs, ys);
  FillChar(nilmap, SizeOf(TMapInfo), #0);
  if (xs > 0) and (xs < MAXX) then begin
    for I := MAXX downto 0 do
      for k := 0 to MAXY - 1 do begin
        if I - xs > 0 then
          MArr[I, k] := MArr[I - xs, k]
        else MArr[I, k] := nilmap;
      end;
  end else begin
    for I := 0 to MAXX - 1 do
      for k := 0 to MAXY - 1 do begin
        if I - xs < MAXX - 1 then
          MArr[I, k] := MArr[I - xs, k]
        else MArr[I, k] := nilmap;
      end;
  end;
  if (ys > 0) and (ys < MAXY) then begin
    for I := MAXY downto 0 do
      for k := 0 to MAXX - 1 do begin
        if I - ys > 0 then
          MArr[k, I] := MArr[k, I - ys]
        else MArr[k, I] := nilmap;
      end;
  end else begin
    for I := 0 to MAXY - 1 do
      for k := 0 to MAXX - 1 do begin
        if I - ys < MAXY - 1 then
          MArr[k, I] := MArr[k, I - ys]
        else MArr[k, I] := nilmap;
      end;
  end;

  MapPaint.Refresh;
end;

procedure TFrmMain.CellMove1Click(Sender: TObject);
begin
  FrmMoveObj.Execute;
end;

procedure TFrmMain.VersionClick(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TFrmMain.Exit1Click(Sender: TObject);
begin
  Close();
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
var
  I: integer;
begin
  WILTiles.Finalize;
  WILTiles.Free;
  WilSmTiles.Finalize;
  WilSmTiles.Free;
  for I := Low(WilArr) to High(WilArr) do begin
    if WilArr[I] <> nil then begin
      WilArr[I].Finalize;
      WilArr[I].Free;
    end;
  end;
  for I := 0 to MapArrTempList.Count - 1 do begin
    Dispose(pTMapArray(MapArrTempList.Items[I]));
  end;
  MapArrTempList.Free;
end;

end.

