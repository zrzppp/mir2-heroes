unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Share, StdCtrls, RzLabel, RzTrkBar, Mask, RzEdit;

type
  TfrmMain = class(TForm)
    TrackBarFColor: TRzTrackBar;
    TrackBarBColor: TRzTrackBar;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    LabelColor: TLabel;
    EditFColor: TRzNumericEdit;
    EditBColor: TRzNumericEdit;
    procedure TrackBarFColorChange(Sender: TObject);
    procedure TrackBarBColorChange(Sender: TObject);
    procedure EditFColorChange(Sender: TObject);
    procedure EditBColorChange(Sender: TObject);
  private
    { Private declarations }
    function GetRGB(c256: Byte): TColor;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}
function TfrmMain.GetRGB(c256: Byte): TColor;
begin
  Result := RGB(ColorTable[c256].rgbRed, ColorTable[c256].rgbGreen, ColorTable[c256].rgbBlue);
end;

procedure TfrmMain.TrackBarFColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := TrackBarFColor.Position;
  LabelColor.Font.Color := GetRGB(btColor);
  EditFColor.IntValue := btColor;
end;

procedure TfrmMain.TrackBarBColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := TrackBarBColor.Position;
  LabelColor.Color := GetRGB(btColor);
  EditBColor.IntValue := btColor;
end;

procedure TfrmMain.EditFColorChange(Sender: TObject);
begin
  TrackBarFColor.Position := EditFColor.IntValue;
end;

procedure TfrmMain.EditBColorChange(Sender: TObject);
begin
  TrackBarBColor.Position := EditBColor.IntValue;
end;

end.

