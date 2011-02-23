unit CreateData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, RzPanel, RzRadGrp;

type
  TFrmCreateData = class(TForm)
    BitBtnOK: TBitBtn;
    BitBtnClose: TBitBtn;
    RadioGroup: TRzRadioGroup;
    RadioGroupBitCount: TRzRadioGroup;
    procedure BitBtnOKClick(Sender: TObject);
    procedure BitBtnCloseClick(Sender: TObject);
    procedure RadioGroupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCreateData: TFrmCreateData;

implementation

{$R *.dfm}

procedure TFrmCreateData.BitBtnCloseClick(Sender: TObject);
begin
  ModalResult := 0;
  Close;
end;

procedure TFrmCreateData.BitBtnOKClick(Sender: TObject);
begin
  ModalResult := 10;
  Close;
  ModalResult := 10;
end;

procedure TFrmCreateData.RadioGroupClick(Sender: TObject);
begin
  RadioGroupBitCount.Enabled := RadioGroup.ItemIndex = 0;
  if RadioGroup.ItemIndex = 1 then begin
    RadioGroupBitCount.ItemIndex := 0;
  end else
  if RadioGroup.ItemIndex = 2 then begin
    RadioGroupBitCount.ItemIndex := 1;
  end;
end;

end.

