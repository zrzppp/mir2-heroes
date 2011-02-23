unit SmTile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids;

type
  TFrmSmTile = class(TForm)
    TileGrid: TDrawGrid;
    procedure FormShow(Sender: TObject);
    procedure TileGridDrawCell(Sender: TObject; col, row: Longint;
      Rect: TRect; State: TGridDrawState);
    procedure TileGridClick(Sender: TObject);
  private
    UnitMax: integer;
  public
    function GetCurrentIndex: integer;
    procedure SetImageUnitCount(ucount: integer);
  end;

var
  FrmSmTile: TFrmSmTile;

implementation

uses EdMain, ObjEdit;

{$R *.DFM}

procedure TFrmSmTile.FormShow(Sender: TObject);
var
  n: integer;
begin
  n := WilSmTiles.ImageCount div MIDDLEBLOCK;
  n := n div 3;
  if n >= 1 then TileGrid.RowCount := n
  else TileGrid.RowCount := 1;
end;

procedure TFrmSmTile.SetImageUnitCount(ucount: integer);
var
  I: integer;
begin
  UnitMax := ucount;
  TileGrid.ColCount := 3;
  TileGrid.RowCount := ucount + 1;
end;

function TFrmSmTile.GetCurrentIndex: integer;
var
  Max, idx: integer;
begin
  Max := WilSmTiles.ImageCount div MIDDLEBLOCK;
  idx := TileGrid.row * TileGrid.ColCount + TileGrid.col;
  if Max > idx then Result := idx
  else Result := -1;
end;

procedure TFrmSmTile.TileGridDrawCell(Sender: TObject; col, row: Longint;
  Rect: TRect; State: TGridDrawState);
var
  idx: integer;
begin
  idx := row; //Col + Row * MainPalGrid.ColCount;
  if (idx >= 0) and (idx < WilSmTiles.ImageCount) then begin
    with WilSmTiles do begin
      if col = 0 then begin
        DrawZoom(TileGrid.Canvas, Rect.Left, Rect.Top, idx * MIDDLEBLOCK + 7 * 4 + 4 + 1, 1);
      end;
      if col = 1 then
        DrawZoom(TileGrid.Canvas, Rect.Left, Rect.Top, idx * MIDDLEBLOCK, 1);
      if col = 2 then
        DrawZoom(TileGrid.Canvas, Rect.Left, Rect.Top, idx * MIDDLEBLOCK + 3 * 4 + 4 + 1, 1);
    end;
  end;
end;

procedure TFrmSmTile.TileGridClick(Sender: TObject);
var
  idx: integer;
begin
  FrmMain.DrawMode := mdMiddle;

  idx := TileGrid.row; //Col + Row * MainPalGrid.ColCount;
  if (idx >= 0) and (idx < UnitMax) then begin
    FrmMain.MiddleIndex := idx;
  end;
end;

end.
