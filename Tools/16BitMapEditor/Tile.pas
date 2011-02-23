unit Tile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids;

type
  TFrmTile = class(TForm)
    TileGrid: TDrawGrid;
    procedure FormShow(Sender: TObject);
    procedure TileGridDrawCell(Sender: TObject; col, row: Longint;
      Rect: TRect; State: TGridDrawState);
    procedure TileGridClick(Sender: TObject);
  private
  public
    function GetCurrentIndex: integer;
  end;

var
  FrmTile: TFrmTile;

implementation

uses EdMain, ObjEdit;

{$R *.DFM}

procedure TFrmTile.FormShow(Sender: TObject);
var
  n: integer;
begin
  n := WILTiles.ImageCount;
  n := n div 5;
  if n >= 1 then TileGrid.RowCount := n
  else TileGrid.RowCount := 1;
end;

function TFrmTile.GetCurrentIndex: integer;
var
  Max, idx: integer;
begin
  Max := WILTiles.ImageCount;
  idx := TileGrid.row * TileGrid.ColCount + TileGrid.col;
  if Max > idx then Result := idx
  else Result := -1;
end;

procedure TFrmTile.TileGridDrawCell(Sender: TObject; col, row: Longint;
  Rect: TRect; State: TGridDrawState);
var
  idx, Max: integer;
begin
  idx := col + row * TileGrid.ColCount;
  Max := WILTiles.ImageCount;
  if (idx >= 0) and (idx < Max) then begin
    with WILTiles do
      DrawZoom(TileGrid.Canvas, Rect.Left, Rect.Top, idx, 0.5);
  end;
end;

procedure TFrmTile.TileGridClick(Sender: TObject);
begin
  FrmMain.DrawMode := mdTile;
  FrmMain.MainBrush := mbNormal;
  FrmMain.SpeedButton2.Down := True;
  FrmObjEdit.BTile.Down := True;
end;


end.

