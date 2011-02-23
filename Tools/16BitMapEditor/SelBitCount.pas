unit SelBitCount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, EdMain;

type
  TfrmBitCount = class(TForm)
    GroupBox1: TGroupBox;
    RadioButton8Bit: TRadioButton;
    RadioButton16Bit: TRadioButton;
    ButtonOk: TButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ButtonOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBitCount: TfrmBitCount;

implementation

{$R *.dfm}

procedure TfrmBitCount.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if RadioButton8Bit.Checked then WilBitCount := 0 else WilBitCount := 16;
end;

procedure TfrmBitCount.ButtonOkClick(Sender: TObject);
begin
  Close;
end;

end.

