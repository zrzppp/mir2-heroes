unit XYDlgMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, Mask, RzEdit, RzLabel, ExtCtrls, RzPanel, Buttons;

type
  TfrmXYDlg = class(TForm)
    RzGroupBox1: TRzGroupBox;
    EditX: TRzNumericEdit;
    EditY: TRzNumericEdit;
    RzLabel1: TLabel;
    RzLabel2: TLabel;
    BitBtnOK: TBitBtn;
    BitBtnClose: TBitBtn;
    procedure BitBtnOKClick(Sender: TObject);
    procedure BitBtnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmXYDlg: TfrmXYDlg;

implementation

{$R *.dfm}

procedure TfrmXYDlg.BitBtnOKClick(Sender: TObject);
begin
  Close;
  ModalResult := 10;
end;

procedure TfrmXYDlg.BitBtnCloseClick(Sender: TObject);
begin
  ModalResult := 0;
  Close;
end;

end.
