unit InPutDlgMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzRadGrp, StdCtrls, Mask, RzEdit, RzLabel, ExtCtrls,
  RzPanel, Buttons;

type
  TfrmInPutDlg = class(TForm)
    RzGroupBox1: TRzGroupBox;
    EditX: TRzNumericEdit;
    EditY: TRzNumericEdit;
    RadioGroup: TRadioGroup;
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
  frmInPutDlg: TfrmInPutDlg;

implementation

{$R *.dfm}

procedure TfrmInPutDlg.BitBtnOKClick(Sender: TObject);
begin
  Close;
  ModalResult := 10;
end;

procedure TfrmInPutDlg.BitBtnCloseClick(Sender: TObject);
begin
  ModalResult := 0;
  Close;
end;

end.
