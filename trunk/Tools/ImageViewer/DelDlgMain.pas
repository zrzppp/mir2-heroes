unit DelDlgMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzRadGrp, StdCtrls, Mask, RzEdit, RzLabel, ExtCtrls,
  RzPanel, Buttons, ComCtrls;

type
  TfrmDelDlg = class(TForm)
    GroupBox1: TRzGroupBox;
    EditX: TRzNumericEdit;
    EditY: TRzNumericEdit;
    RadioGroup: TRadioGroup;
    RzLabel1: TLabel;
    RzLabel2: TLabel;
    BitBtnOK: TBitBtn;
    BitBtnClose: TBitBtn;
    ProgressBar: TProgressBar;
    procedure BitBtnOKClick(Sender: TObject);
    procedure BitBtnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    procedure Open(nIndex: Integer);
  end;

var
  frmDelDlg: TfrmDelDlg;

implementation
uses MirShare;
{$R *.dfm}

procedure TfrmDelDlg.Open(nIndex: Integer);
begin
  ProgressBar.Position := 0;
  ProgressBar.Max := 100;
  EditX.IntValue := nIndex;
  EditY.IntValue := nIndex;
  ShowModal;
end;

procedure TfrmDelDlg.BitBtnOKClick(Sender: TObject);
var
  nBIndex, nEIndex: Integer;
begin
  if not Assigned(CurrImageFile) then Exit;
  if g_boWalking then Exit;
  g_boWalking := True;
  BitBtnOK.Enabled := False;
  BitBtnClose.Enabled := False;
  try
    nBIndex := EditX.IntValue;
    nEIndex := EditY.IntValue;

    if nBIndex < 0 then nBIndex := 0;
    if nEIndex > CurrImageFile.ImageCount - 1 then nEIndex := CurrImageFile.ImageCount - 1;
    if nBIndex > CurrImageFile.ImageCount - 1 then nBIndex := CurrImageFile.ImageCount - 1;
    if nBIndex > nEIndex then nBIndex := nEIndex;

    if RadioGroup.ItemIndex = 0 then begin
      if (nEIndex >= nBIndex) and (nBIndex >= 0) and (nEIndex < CurrImageFile.ImageCount) then begin
        if CurrImageFile.Delete(nBIndex, nEIndex) then
          Application.MessageBox('图片删除成功 ！！！', '提示信息', MB_ICONQUESTION)
        else
          Application.MessageBox('图片删除失败 ！！！', '提示信息', MB_ICONQUESTION);
      end;
    end else begin
      if (nEIndex >= nBIndex) and (nBIndex >= 0) and (nEIndex < CurrImageFile.ImageCount) then begin
        if CurrImageFile.Fill(nBIndex, nEIndex) then
          Application.MessageBox('图片删除成功 ！！！', '提示信息', MB_ICONQUESTION)
        else
          Application.MessageBox('图片删除失败 ！！！', '提示信息', MB_ICONQUESTION);
      end;
    end;
  finally
    BitBtnOK.Enabled := True;
    BitBtnClose.Enabled := True;
    g_boWalking := False;
  end;
  Close;
end;

procedure TfrmDelDlg.BitBtnCloseClick(Sender: TObject);
begin
  ModalResult := 0;
  Close;
end;

procedure TfrmDelDlg.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := not g_boWalking;
end;

end.

