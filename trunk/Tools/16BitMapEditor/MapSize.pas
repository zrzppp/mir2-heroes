unit MapSize;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, HUtil32;

type
  TFrmMapSize = class(TForm)
    EdWidth: TEdit;
    EdHeight: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
  public
    MapX, MapY: integer;
    function Execute: Boolean;
  end;

var
  FrmMapSize: TFrmMapSize;

implementation

{$R *.DFM}

function TFrmMapSize.Execute: Boolean;
begin
  MapX := 20;
  MapY := 20;
  EdWidth.Text := IntToStr(MapX);
  EdHeight.Text := IntToStr(MapY);
  if mrOk = ShowModal then begin
    MapX := Str_ToInt(EdWidth.Text, 1);
    MapY := Str_ToInt(EdHeight.Text, 1);
    Result := True;
  end else
    Result := False;
end;

procedure TFrmMapSize.FormShow(Sender: TObject);
begin
  EdWidth.SetFocus;
end;

end.
