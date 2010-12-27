unit MapUnit;

interface

uses
  Windows, Classes, SysUtils, Graphics, Grobal2, HUtil32, LoadMapThread, {DXDraws, } Share;

type
// -------------------------------------------------------------------------------
// Map
// -------------------------------------------------------------------------------

  TMapPrjInfo = record
    ident: string[16];
    ColCount: Integer;
    RowCount: Integer;
  end;

  TMapHeader = packed record
    wWidth: Word;
    wHeight: Word;
    sTitle: string[16];
    UpdateDate: TDateTime;
    BitCount: Byte;
    Reserved: array[0..21] of Char;
  end;

  TMapInfo = packed record
    wBkImg: Word;
    wMidImg: Word;
    wFrImg: Word;
    btDoorIndex: byte; //$80 (¹®Â¦), ¹®ÀÇ ½Äº° ÀÎµ¦½º
    btDoorOffset: byte; //´ÝÈù ¹®ÀÇ ±×¸²ÀÇ »ó´ë À§Ä¡, $80 (¿­¸²/´ÝÈû(±âº»))
    btAniFrame: byte; //$80(Draw Alpha) +  ÇÁ·¡ÀÓ ¼ö
    btAniTick: byte;
    btArea: byte; //Áö¿ª Á¤º¸
    btLight: byte; //0..1..4 ±¤¿ø È¿°ú
  end;
  pTMapInfo = ^TMapInfo;

  TMapInfoArr = array[0..MaxListSize] of TMapInfo;
  pTMapInfoArr = ^TMapInfoArr;
  TMapInfoArray = array of array of TMapInfo;
  TMap = class
  private

    function LoadMapInfo(sMapFile: string): Boolean;
    procedure UpdateMapSeg(cx, cy: Integer); //, maxsegx, maxsegy: integer);
    procedure LoadMapArr(nCurrX, nCurrY: Integer);
    procedure SaveMapArr(nCurrX, nCurrY: Integer);
  public
    LoadMapThread: TLoadMapThread;
    m_nHandle: Integer;

    m_sMapBase: string;

    //m_MArr: array[0..MAXX * 3 * 2, 0..MAXY * 3 * 2] of TMapInfo;
    //m_MArr: array of array of TMapInfo;
    m_MArr: array[0..52 * 3 * 2, 0..52 * 3 * 2] of TMapInfo;

    m_MapBuf: TMapInfoArray;

    MapCellArray: array of Byte;

    m_boChange: Boolean;
    m_ClientRect: TRect;
    m_OldClientRect: TRect;
    m_nBlockLeft: Integer;
    m_nBlockTop: Integer;

    m_nNewBlockLeft: Integer;
    m_nNewBlockTop: Integer;

    m_nOldLeft: Integer;
    m_nOldTop: Integer;
    m_sOldMap: string;
    m_nCurUnitX: Integer;
    m_nCurUnitY: Integer;
    m_sCurrentMap: string;
    m_sOldCurrentMap: string;
    m_boSegmented: Boolean;
    m_nSegXCount: Integer;
    m_nSegYCount: Integer;

    m_nWidth: Integer;
    m_nHeight: Integer;
    m_btBitCount: Byte;

    m_boStartLoad: Boolean;
    m_boLoadOk: Boolean;

    m_boStartLoadAll: Boolean;
    m_boLoadAllOk: Boolean;
    constructor Create;
    destructor Destroy; override; //Jacky

    procedure UpdateMapSquare(cx, cy: Integer);
    procedure UpdateMapPos(mx, my: Integer);
    procedure ReadyReload;
    procedure LoadMap(sMapName: string; nMx, nMy: Integer);
    procedure MarkCanWalk(mx, my: Integer; bowalk: Boolean);
    function CanMove(mx, my: Integer): Boolean;
    function NewCanMove(mx, my: Integer): Boolean;
    function CanFly(mx, my: Integer): Boolean;
    function GetDoor(mx, my: Integer): Integer;
    function IsDoorOpen(mx, my: Integer): Boolean;
    function OpenDoor(mx, my: Integer): Boolean;
    function CloseDoor(mx, my: Integer): Boolean;
    procedure LoadAllMap;
    function GetMapCellInfo(nX, nY: Integer): Integer;
  end;

implementation
uses
  MShare;

constructor TMap.Create;
begin
  inherited Create;
   //GetMem (MInfoArr, sizeof(TMapInfo) * LOGICALMAPUNIT * 3 * LOGICALMAPUNIT * 3);
  m_ClientRect := Rect(0, 0, 0, 0);
  m_boChange := FALSE;
  m_sMapBase := '.\Map\';
  m_sCurrentMap := '';
  m_sOldCurrentMap := '';
  m_boSegmented := FALSE;
  m_nSegXCount := 0;
  m_nSegYCount := 0;
  m_nCurUnitX := -1;
  m_nCurUnitY := -1;
  m_nBlockLeft := -1;
  m_nBlockTop := -1;
  m_sOldMap := '';

  m_btBitCount := 8;
  //SetLength(m_MArr, MAXX * 3 * 2, MAXX * 3 * 2);
    //m_MArr: array[0..MAXX * 3 * 2, 0..MAXY * 3 * 2] of TMapInfo;
    //m_MArr: array of array of TMapInfo;

  m_boStartLoad := False;
  m_boStartLoadAll := False;
  m_boLoadOk := False;
  m_boLoadAllOk := False;

  Pointer(MapCellArray) := nil;

  LoadMapThread := TLoadMapThread.Create(nil);
end;

destructor TMap.Destroy;
begin
  if Pointer(MapCellArray) <> nil then begin
    FreeMem(Pointer(MapCellArray));
    Pointer(MapCellArray) := nil;
  end;
  LoadMapThread.Terminate;
  LoadMapThread.Free;
  inherited Destroy;
end;

function TMap.LoadMapInfo(sMapFile: string): Boolean;
var
  sFileName: string;
  Header: TMapHeader;
begin
  Result := False;
  sFileName := m_sMapBase + m_sCurrentMap + '.map';
  if FileExists(sFileName) then begin
    m_nHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if m_nHandle > 0 then begin
      FileRead(m_nHandle, Header, SizeOf(TMapHeader));
      m_nWidth := Header.wWidth;
      m_nHeight := Header.wHeight;
      m_btBitCount := Header.BitCount;
    end;
    FileClose(m_nHandle);
  end;
  m_nHandle := 0;
end;

procedure TMap.UpdateMapSeg(cx, cy: Integer); //, maxsegx, maxsegy: integer);
begin

end;

//¼ÓÔØµØÍ¼¶ÎÊý¾Ý
//ÒÔµ±Ç°×ù±êÎª×¼

procedure TMap.LoadMapArr(nCurrX, nCurrY: Integer);
var
  I: Integer;
  k: Integer;
  nAline: Integer;
  nLx: Integer;
  nRx: Integer;
  nTy: Integer;
  nBy: Integer;
  sFileName: string;
  nHandle: Integer;
  Header: TMapHeader;
begin
  SafeFillChar(m_MArr, SizeOf(m_MArr), #0);
  sFileName := m_sMapBase + m_sCurrentMap + '.map';
  if FileExists(sFileName) then begin
    nHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if nHandle > 0 then begin
      FileRead(nHandle, Header, SizeOf(TMapHeader));
      nLx := (nCurrX - 1) * LOGICALMAPUNIT;
      nRx := (nCurrX + 2) * LOGICALMAPUNIT; //rx
      nTy := (nCurrY - 1) * LOGICALMAPUNIT;
      nBy := (nCurrY + 2) * LOGICALMAPUNIT;
      m_nWidth := Header.wWidth;
      m_nHeight := Header.wHeight;
      if nLx < 0 then nLx := 0;
      if nTy < 0 then nTy := 0;
      if nBy >= Header.wHeight then nBy := Header.wHeight;
      nAline := SizeOf(TMapInfo) * Header.wHeight;
      for I := nLx to nRx - 1 do begin
        if (I >= 0) and (I < Header.wWidth) then begin
          FileSeek(nHandle, SizeOf(TMapHeader) + (nAline * I) + (SizeOf(TMapInfo) * nTy), 0);
          FileRead(nHandle, m_MArr[I - nLx, 0], SizeOf(TMapInfo) * (nBy - nTy));
        end;
      end;
      FileClose(nHandle);
    end;
  end;
end;

procedure TMap.SaveMapArr(nCurrX, nCurrY: Integer);
var
  I: Integer;
  k: Integer;
  nAline: Integer;
  nLx: Integer;
  nRx: Integer;
  nTy: Integer;
  nBy: Integer;
  sFileName: string;
  nHandle: Integer;
  Header: TMapHeader;
begin
  FillChar(m_MArr, SizeOf(m_MArr), #0);
  sFileName := m_sMapBase + m_sCurrentMap + '.map';
  if FileExists(sFileName) then begin
    nHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if nHandle > 0 then begin
      FileRead(nHandle, Header, SizeOf(TMapHeader));
      nLx := (nCurrX - 1) * LOGICALMAPUNIT;
      nRx := (nCurrX + 2) * LOGICALMAPUNIT; //rx
      nTy := (nCurrY - 1) * LOGICALMAPUNIT;
      nBy := (nCurrY + 2) * LOGICALMAPUNIT;

      if nLx < 0 then nLx := 0;
      if nTy < 0 then nTy := 0;
      if nBy >= Header.wHeight then nBy := Header.wHeight;
      nAline := SizeOf(TMapInfo) * Header.wHeight;
      for I := nLx to nRx - 1 do begin
        if (I >= 0) and (I < Header.wWidth) then begin
          FileSeek(nHandle, SizeOf(TMapHeader) + (nAline * I) + (SizeOf(TMapInfo) * nTy), 0);
          FileRead(nHandle, m_MArr[I - nLx, 0], SizeOf(TMapInfo) * (nBy - nTy));
        end;
      end;
      FileClose(nHandle);
    end;
  end;
end;

procedure TMap.ReadyReload;
begin
  m_nCurUnitX := -1;
  m_nCurUnitY := -1;
end;

procedure TMap.UpdateMapSquare(cx, cy: Integer);
begin
  if (cx <> m_nCurUnitX) or (cy <> m_nCurUnitY) then begin
    if m_boSegmented then
      UpdateMapSeg(cx, cy)
    else
      LoadMapArr(cx, cy);
    m_nCurUnitX := cx;
    m_nCurUnitY := cy;
  end;
end;

procedure TMap.UpdateMapPos(mx, my: Integer);
var
  cx, cy: Integer;
  procedure Unmark(xx, yy: Integer);
  var
    ax, ay: Integer;
  begin
    if (cx = xx div LOGICALMAPUNIT) and (cy = yy div LOGICALMAPUNIT) then begin
      ax := xx - m_nBlockLeft;
      ay := yy - m_nBlockTop;
      m_MArr[ax, ay].wFrImg := m_MArr[ax, ay].wFrImg and $7FFF;
      m_MArr[ax, ay].wBkImg := m_MArr[ax, ay].wBkImg and $7FFF;
    end;
  end;
begin
  cx := mx div LOGICALMAPUNIT;
  cy := my div LOGICALMAPUNIT;
  m_nBlockLeft := _MAX(0, (cx - 1) * LOGICALMAPUNIT);
  m_nBlockTop := _MAX(0, (cy - 1) * LOGICALMAPUNIT);
  m_nNewBlockLeft := _MAX(0, (cx - 2) * LOGICALMAPUNIT);
  m_nNewBlockTop := _MAX(0, (cy - 2) * LOGICALMAPUNIT);
  UpdateMapSquare(cx, cy);

  if (m_nOldLeft <> m_nBlockLeft) or (m_nOldTop <> m_nBlockTop) or (m_sOldMap <> m_sCurrentMap) then begin

    if m_sCurrentMap = '3' then begin
      Unmark(624, 278);
      Unmark(627, 278);
      Unmark(634, 271);

      Unmark(564, 287);
      Unmark(564, 286);
      Unmark(661, 277);
      Unmark(578, 296);
    end;
  end;
  m_nOldLeft := m_nBlockLeft;
  m_nOldTop := m_nBlockTop;
end;

procedure TMap.LoadMap(sMapName: string; nMx, nMy: Integer);
begin
  m_boStartLoad := True;
  m_boLoadOk := False;

  while m_boStartLoadAll do begin
    Sleep(1);
  end;

  m_nCurUnitX := -1;
  m_nCurUnitY := -1;
  m_sCurrentMap := sMapName;
  m_boSegmented := FALSE;
  UpdateMapPos(nMx, nMy);
  m_sOldMap := m_sCurrentMap;

  m_boStartLoad := False;
  m_boLoadAllOk := False;
  m_boLoadOk := True;

  //DScreen.AddChatBoardString('TMap.LoadMap', clRed, clWhite);
end;

procedure TMap.LoadAllMap;
var
  fHandle: Integer;
  Header: TMapHeader;
  nMapSize: Integer;
  n24, nW, nH: Integer;
  MapBuffer: pTMapInfoArr;
  Point: Integer;
  I: Integer;
  sFileName: string;
begin
  if m_boLoadAllOk or m_boStartLoad or (not m_boLoadOk) then Exit;
  m_boStartLoadAll := True;
  //DScreen.AddChatBoardString('TMap.LoadAllMap1', clRed, clWhite);
  sFileName := m_sMapBase + m_sCurrentMap + '.map';
  if FileExists(sFileName) then begin
    fHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if fHandle > 0 then begin
      FileRead(fHandle, Header, SizeOf(TMapHeader));

      if Pointer(MapCellArray) <> nil then begin
        FreeMem(Pointer(MapCellArray));
        Pointer(MapCellArray) := nil;
      end;
      Pointer(MapCellArray) := AllocMem(Header.wWidth * Header.wHeight);

      nMapSize := Header.wWidth * SizeOf(TMapInfo) * Header.wHeight;

      MapBuffer := AllocMem(nMapSize);
      FileRead(fHandle, MapBuffer^, nMapSize);

      for nW := 0 to Header.wWidth - 1 do begin
        n24 := nW * Header.wHeight;
        if m_boStartLoad then break;
        for nH := 0 to Header.wHeight - 1 do begin
          if m_boStartLoad then break;
          //Sleep(1);
          if (MapBuffer[n24 + nH].wBkImg) and $8000 <> 0 then begin
            MapCellArray[n24 + nH] := 1;
          end;
          if MapBuffer[n24 + nH].wFrImg and $8000 <> 0 then begin
            MapCellArray[n24 + nH] := 2;
          end;
        end;
      end;
      FreeMem(MapBuffer);
      FileClose(fHandle);
      m_boLoadAllOk := not m_boStartLoad;
      if m_boLoadAllOk then begin
        LegendMap.Width := Header.wWidth;
        LegendMap.Height := Header.wHeight;
        LegendMap.PathMapArray := nil;
        //DScreen.AddChatBoardString('TMap.LoadAllMap2', clRed, clWhite);
      end;
    end;
  end;
  //DScreen.AddChatBoardString('TMap.LoadAllMap3', clRed, clWhite);
  m_boStartLoadAll := False;
end;

function TMap.GetMapCellInfo(nX, nY: Integer): Integer;
begin
  if (nX >= 0) and (nX < m_nWidth) and (nY >= 0) and (nY < m_nHeight) then begin
    Result := MapCellArray[nX * m_nHeight + nY];
  end else begin
    Result := -1;
  end;
end;

procedure TMap.MarkCanWalk(mx, my: Integer; bowalk: Boolean);
var
  cx, cy: Integer;
begin
  cx := mx - m_nBlockLeft;
  cy := my - m_nBlockTop;
  if (cx < 0) or (cy < 0) then Exit;
  if bowalk then //°ÉÀ» ¼ö ÀÖÀ½
    m_MArr[cx, cy].wFrImg := m_MArr[cx, cy].wFrImg and $7FFF
  else //¸·ÇûÀ½
    m_MArr[cx, cy].wFrImg := m_MArr[cx, cy].wFrImg or $8000; //¸ø¿òÁ÷ÀÌ°Ô ÇÑ´Ù.
end;

function TMap.CanMove(mx, my: Integer): Boolean;
var
  cx, cy: Integer;
begin
  Result := FALSE; //jacky
  cx := mx - m_nBlockLeft;
  cy := my - m_nBlockTop;
  if (cx < 0) or (cy < 0) then Exit;
  Result := ((m_MArr[cx, cy].wBkImg and $8000) + (m_MArr[cx, cy].wFrImg and $8000)) = 0;
  if Result then begin
    if m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin
      if (m_MArr[cx, cy].btDoorOffset and $80) = 0 then
        Result := FALSE;
    end;
  end;
end;

function TMap.NewCanMove(mx, my: Integer): Boolean;
//var
  //cx, cy: Integer;
begin
  //Result := FALSE; //jacky
  Result := GetMapCellInfo(mx, my) = 0;
 { cx := LegendMap.LoaclX(mx);
  cy := LegendMap.LoaclY(my);
  if (cx < 0) or (cy < 0) then Exit;
  Result := ((m_MapBuf[cx, cy].wBkImg and $8000) + (m_MapBuf[cx, cy].wFrImg and $8000)) = 0;
  if Result then begin
    if m_MapBuf[cx, cy].btDoorIndex and $80 > 0 then begin
      if (m_MapBuf[cx, cy].btDoorOffset and $80) = 0 then
        Result := FALSE;
    end;
  end; }
end;

function TMap.CanFly(mx, my: Integer): Boolean;
var
  cx, cy: Integer;
begin
  Result := FALSE; //jacky
  cx := mx - m_nBlockLeft;
  cy := my - m_nBlockTop;
  if (cx < 0) or (cy < 0) then Exit;
  Result := (m_MArr[cx, cy].wFrImg and $8000) = 0;
  if Result then begin //¹®°Ë»ç
    if m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin //¹®Â¦ÀÌ ÀÖÀ½
      if (m_MArr[cx, cy].btDoorOffset and $80) = 0 then
        Result := FALSE; //¹®ÀÌ ¾È ¿­·ÈÀ½.
    end;
  end;
end;

function TMap.GetDoor(mx, my: Integer): Integer;
var
  cx, cy: Integer;
begin
  Result := 0;
  cx := mx - m_nBlockLeft;
  cy := my - m_nBlockTop;
  if m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin
    Result := m_MArr[cx, cy].btDoorIndex and $7F;
  end;
end;

function TMap.IsDoorOpen(mx, my: Integer): Boolean;
var
  cx, cy: Integer;
begin
  Result := FALSE;
  cx := mx - m_nBlockLeft;
  cy := my - m_nBlockTop;
  if m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin
    Result := (m_MArr[cx, cy].btDoorOffset and $80 <> 0);
  end;
end;

function TMap.OpenDoor(mx, my: Integer): Boolean;
var
  I, j, cx, cy, idx: Integer;
begin
  Result := FALSE;
  cx := mx - m_nBlockLeft;
  cy := my - m_nBlockTop;
  if (cx < 0) or (cy < 0) then Exit;
  if m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin
    idx := m_MArr[cx, cy].btDoorIndex and $7F;
    for I := cx - 10 to cx + 10 do
      for j := cy - 10 to cy + 10 do begin
        if (I > 0) and (j > 0) then
          if (m_MArr[I, j].btDoorIndex and $7F) = idx then
            m_MArr[I, j].btDoorOffset := m_MArr[I, j].btDoorOffset or $80;
      end;
  end;
end;

function TMap.CloseDoor(mx, my: Integer): Boolean;
var
  I, j, cx, cy, idx: Integer;
begin
  Result := FALSE;
  cx := mx - m_nBlockLeft;
  cy := my - m_nBlockTop;
  if (cx < 0) or (cy < 0) then Exit;
  if m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin
    idx := m_MArr[cx, cy].btDoorIndex and $7F;
    for I := cx - 8 to cx + 10 do
      for j := cy - 8 to cy + 10 do begin
        if (m_MArr[I, j].btDoorIndex and $7F) = idx then
          m_MArr[I, j].btDoorOffset := m_MArr[I, j].btDoorOffset and $7F;
      end;
  end;
end;

end.

