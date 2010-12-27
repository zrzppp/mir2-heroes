unit QueryIP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, PlugMain;

type
  TFrmQueryIP = class(TForm)
    EditIP: TEdit;
    ButtonOK: TButton;
    MemoIP: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQueryIP: TFrmQueryIP;

implementation

{$R *.dfm}

procedure TFrmQueryIP.ButtonOKClick(Sender: TObject);
var
  sIPAddr: string;
begin
  sIPAddr := Trim(EditIP.Text);
  SearchIPLocalA(sIPAddr, MemoIP.Lines);
end;

procedure TFrmQueryIP.FormCreate(Sender: TObject);
begin
  MemoIP.Lines.Clear;
end;

end.

