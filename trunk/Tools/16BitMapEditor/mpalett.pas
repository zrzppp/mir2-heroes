unit mpalett;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids;

type
  TFrmMainPal = class(TForm)
    MainPalGrid: TDrawGrid;
    procedure MainPalGridDrawCell(Sender: TObject; col, row: Longint;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure MainPalGridClick(Sender: TObject);
    procedure MainPalGridKeyDown(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    procedure LoadAttribs;
    procedure SaveAttribs;
  public
    UnitMax: integer;
    MainIndex: integer; // main image unit index
    AttrList: TList;
    procedure SetImageUnitCount(ucount: integer);
    function GetAttrib(idx: integer): integer;
  end;

var
  FrmMainPal: TFrmMainPal;

implementation

uses
  EdMain;

{$R *.DFM}


procedure TFrmMainPal.FormCreate(Sender: TObject);
begin
  UnitMax := 0;
  AttrList := TList.Create;
  LoadAttribs;
end;

procedure TFrmMainPal.FormDestroy(Sender: TObject);
begin
  AttrList.Free;
end;

function TFrmMainPal.GetAttrib(idx: integer): integer;
begin
  Result := 0;
  if idx < AttrList.Count then
    Result := integer(AttrList[idx]);
end;

procedure TFrmMainPal.LoadAttribs;
var
  I: integer;
  strlist: TStringList;
begin
  if FileExists('Tile.atr') then begin
    strlist := TStringList.Create;
    strlist.LoadFromFile('Tile.Atr');
    AttrList.Clear;
    for I := 0 to strlist.Count - 1 do
      if strlist[I] = '1' then AttrList.Add(pointer(1))
      else AttrList.Add(nil);
    strlist.Free;
  end;
end;

procedure TFrmMainPal.SaveAttribs;
var
  I: integer;
  strlist: TStringList;
begin
  strlist := TStringList.Create;
  for I := 0 to AttrList.Count - 1 do
    if integer(AttrList[I]) = 1 then strlist.Add('1')
    else strlist.Add('0');
  strlist.SaveToFile(BaseDir + '\Tile.Atr');
  strlist.Free;
end;

procedure TFrmMainPal.SetImageUnitCount(ucount: integer);
var
  I: integer;
begin
  UnitMax := ucount;
  MainPalGrid.ColCount := 3;
  MainPalGrid.RowCount := ucount + 1;
  if AttrList.Count < ucount then
    for I := AttrList.Count to ucount do
      AttrList.Add(nil);
end;

procedure TFrmMainPal.MainPalGridDrawCell(Sender: TObject; col, row: Longint;
  Rect: TRect; State: TGridDrawState);
var
  idx: integer;
begin
  idx := row; //Col + Row * MainPalGrid.ColCount;
  if (idx >= 0) and (idx < UnitMax) then begin
    with WILTiles do begin
      if col = 0 then begin
        DrawZoom(MainPalGrid.Canvas, Rect.Left, Rect.Top, idx * UNITBLOCK + 22, 0.5);
        if idx <= AttrList.Count then
          if integer(AttrList[idx]) = 1 then
            MainPalGrid.Canvas.TextOut(Rect.Left, Rect.Top + 4, '#');
      end;
      if col = 1 then
        DrawZoom(MainPalGrid.Canvas, Rect.Left, Rect.Top, idx * UNITBLOCK, 0.5);
      if col = 2 then
        DrawZoom(MainPalGrid.Canvas, Rect.Left, Rect.Top, idx * UNITBLOCK + 21, 0.5);
    end;
  end;
end;

procedure TFrmMainPal.MainPalGridClick(Sender: TObject);
var
  idx: integer;
begin
  FrmMain.DrawMode := mdTile;
  idx := MainPalGrid.row; //MainPalGrid.Col + MainPalGrid.Row * MainPalGrid.ColCount;
  if (idx >= 0) and (idx < UnitMax) then begin
    FrmMain.ImageIndex := idx;
    FrmMain.TileAttrib := GetAttrib(idx);
  end;
end;

procedure TFrmMainPal.MainPalGridKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
var
  idx: integer;
begin
  if Key = VK_F5 then FrmMain.MapPaint.Refresh;
  if Key = VK_F1 then begin
    idx := MainPalGrid.row;
    if idx < AttrList.Count then begin
      if integer(AttrList[idx]) = 1 then AttrList[idx] := nil
      else AttrList[idx] := pointer(1);
      SaveAttribs;
      MainPalGrid.Refresh;
    end;
  end;
end;

end.
