unit segunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, HUtil32;

type
  TFrmSegment = class(TForm)
    SegGrid: TStringGrid;
    BtnNew: TButton;
    BtnSave: TButton;
    BtnOpen: TButton;
    EdIdent: TEdit;
    Label1: TLabel;
    EdCol: TEdit;
    EdRow: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    BtnEdit: TButton;
    BtnCancel: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    BtnSaveSegs: TButton;
    procedure BtnNewClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnOpenClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnSaveSegsClick(Sender: TObject);
  private
    procedure ClearSegGrid;
    procedure InitSegment(Ident: string; col, row: integer);
    function SaveToFile(flname: string): Boolean;
    function LoadFromFile(flname: string): Boolean;
    procedure GetCurrentSegment;
  public
    SegPath: string;
    CurSegs: array[0..2, 0..2] of string;
    Offsx, OffsY: integer;
    procedure ShiftLeftSegment;
    procedure ShiftRightSegment;
    procedure ShiftUpSegment;
    procedure ShiftDownSegment;
  end;

var
  FrmSegment: TFrmSegment;

implementation

uses
  EdMain;

{$R *.DFM}


procedure TFrmSegment.ClearSegGrid;
var
  I, j: integer;
begin
  for I := 0 to SegGrid.col - 1 do
    for j := 0 to SegGrid.row - 1 do begin
      SegGrid.Cells[I, j] := '';
    end;
end;

procedure TFrmSegment.InitSegment(Ident: string; col, row: integer);
var
  I, j: integer;
begin
  SegGrid.ColCount := col;
  SegGrid.RowCount := row;
  for I := 0 to col - 1 do
    for j := 0 to row - 1 do begin
      SegGrid.Cells[I, j] := Ident + IntToStr(100 + j) + IntToStr(100 + I);
    end;
end;

procedure TFrmSegment.BtnNewClick(Sender: TObject);
var
  ColCount, RowCount: integer;
begin
  ColCount := Str_ToInt(EdCol.Text, 0);
  RowCount := Str_ToInt(EdRow.Text, 0);
  if (ColCount > 0) and (RowCount > 0) then begin
    SegGrid.ColCount := ColCount;
    SegGrid.RowCount := RowCount;
    SegPath := '';
    ClearSegGrid;
    InitSegment(Trim(EdIdent.Text), ColCount, RowCount);
  end;
end;

function TFrmSegment.SaveToFile(flname: string): Boolean;
var
  mapprj: TMapPrjInfo;
  fhandle: integer;
begin
  Result := False;
  mapprj.Ident := Trim(EdIdent.Text);
  mapprj.ColCount := Str_ToInt(EdCol.Text, 0);
  mapprj.RowCount := Str_ToInt(EdRow.Text, 0);
  if FileExists(flname) then
    fhandle := FileOpen(flname, fmOpenWrite)
  else fhandle := FileCreate(flname);
  if fhandle > 0 then begin
    FileWrite(fhandle, mapprj, SizeOf(TMapPrjInfo));
    FileClose(fhandle);
    Result := True;
  end;
end;

function TFrmSegment.LoadFromFile(flname: string): Boolean;
var
  mapprj: TMapPrjInfo;
  fhandle: integer;
begin
  Result := False;
  if FileExists(flname) then begin
    fhandle := FileOpen(flname, fmOpenRead or fmShareDenyNone);
    if handle > 0 then begin
      FileRead(fhandle, mapprj, SizeOf(TMapPrjInfo));
      FileClose(fhandle);
      EdIdent.Text := mapprj.Ident;
      EdCol.Text := IntToStr(mapprj.ColCount);
      EdRow.Text := IntToStr(mapprj.RowCount);
      Result := True;
    end;
  end;
end;

procedure TFrmSegment.BtnSaveClick(Sender: TObject);
begin
  with SaveDialog1 do begin
    if Execute then begin
      SegPath := ExtractFilePath(FileName);
      SaveToFile(FileName);
    end;
  end;
end;

procedure TFrmSegment.BtnOpenClick(Sender: TObject);
var
  ColCount, RowCount: integer;
begin
  with OpenDialog1 do begin
    if Execute then begin
      LoadFromFile(FileName);
      SegPath := ExtractFilePath(FileName);
      ColCount := Str_ToInt(EdCol.Text, 0);
      RowCount := Str_ToInt(EdRow.Text, 0);
      InitSegment(Trim(EdIdent.Text), ColCount, RowCount);
    end;
  end;
end;

procedure TFrmSegment.GetCurrentSegment;
var
  I, j: integer;
begin
  for I := 0 to 2 do
    for j := 0 to 2 do
      CurSegs[I, j] := '';
  with SegGrid do begin
    for I := 0 to 2 do begin
      if (I + TopRow) >= RowCount then Break;
      for j := 0 to 2 do begin
        if (j + LeftCol) >= ColCount then Break;
        CurSegs[j, I] := Cells[j + LeftCol, I + TopRow];
      end;
    end;
  end;
end;

procedure TFrmSegment.BtnEditClick(Sender: TObject);
var
  r: integer;
begin
  Offsx := SegGrid.LeftCol * SEGX;
  OffsY := SegGrid.TopRow * SEGY;
  if FrmMain.Edited then begin
    r := MessageDlg('작업중인 맵을 저장하시겠습니까?',
      mtWarning,
      mbYesNoCancel,
      0);
    if r = mrYes then
      FrmMain.DoSaveSegments;
  end;
  GetCurrentSegment;
  FrmMain.DoEditSegment;
  if SegPath <> '' then
    Close;
end;

procedure TFrmSegment.BtnCancelClick(Sender: TObject);
begin
  FrmMain.SegmentMode := False;
  Close;
end;

procedure TFrmSegment.BtnSaveSegsClick(Sender: TObject);
begin
  if SegPath <> '' then FrmMain.DoSaveSegments
  else ShowMessage('취소 되었습니다');
end;

procedure TFrmSegment.ShiftLeftSegment;
begin
  if SegGrid.LeftCol > 0 then SegGrid.LeftCol := SegGrid.LeftCol - 1;
  BtnEditClick(self);
end;

procedure TFrmSegment.ShiftRightSegment;
begin
  with SegGrid do
    if LeftCol + 2 < ColCount - 1 then
      LeftCol := LeftCol + 1;
  BtnEditClick(self);
end;

procedure TFrmSegment.ShiftUpSegment;
begin
  with SegGrid do
    if TopRow > 0 then
      TopRow := TopRow - 1;
  BtnEditClick(self);
end;

procedure TFrmSegment.ShiftDownSegment;
begin
  with SegGrid do
    if TopRow + 2 < RowCount - 1 then
      TopRow := TopRow + 1;
  BtnEditClick(self);
end;



end.
