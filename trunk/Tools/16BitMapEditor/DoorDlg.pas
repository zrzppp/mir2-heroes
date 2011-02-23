unit DoorDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, HUtil32;

type
  TFrmDoorDlg = class(TForm)
    CkDoor: TCheckBox;
    EdIndex: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EdOffset: TEdit;
    BitBtn1: TBitBtn;
  private
  public
    function Update(var nDoorIndex, nDoorOffset: integer): Boolean;
  end;

var
  FrmDoorDlg: TFrmDoorDlg;

implementation

{$R *.DFM}

function TFrmDoorDlg.Update(var nDoorIndex, nDoorOffset: integer): Boolean;
begin
  if (nDoorIndex and $80) <> 0 then CkDoor.Checked := True
  else CkDoor.Checked := False;

  EdIndex.Text := IntToStr((nDoorIndex and $7F));
  EdOffset.Text := IntToStr(nDoorOffset);
  if mrOk = ShowModal then begin
    if CkDoor.Checked then nDoorIndex := Str_ToInt(EdIndex.Text, 0) or $80
    else nDoorIndex := Str_ToInt(EdIndex.Text, 0);
    nDoorOffset := Str_ToInt(EdOffset.Text, 0);
    Result := True;
  end else begin
    Result := False;
  end;
end;

end.
