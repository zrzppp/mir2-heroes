unit CompressMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFrmComparess = class(TForm)
    Label1: TLabel;
    ComboBox: TComboBox;
    BitBtnOK: TBitBtn;
    BitBtnClose: TBitBtn;
    procedure BitBtnOKClick(Sender: TObject);
    procedure BitBtnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmComparess: TFrmComparess;

implementation

{$R *.dfm}

procedure TFrmComparess.BitBtnCloseClick(Sender: TObject);
begin
  ModalResult := 0;
  Close;
end;

procedure TFrmComparess.BitBtnOKClick(Sender: TObject);
begin
  ModalResult := 10;
  Close;
end;

procedure TFrmComparess.FormCreate(Sender: TObject);
begin
  ModalResult := 0;
end;

end.
