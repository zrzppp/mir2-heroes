unit OutPutDlgMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzEdit, ExtCtrls, RzPanel, StdCtrls, Mask, RzBtnEdt,
  RzLabel, SelectPath, Buttons, ComCtrls;

type
  TfrmOutPutDlg = class(TForm)
    EditFileDir: TRzButtonEdit;
    GroupBox1: TRzGroupBox;
    EditX: TRzNumericEdit;
    EditY: TRzNumericEdit;
    RzLabel: TLabel;
    RzLabel1: TLabel;
    RzLabel2: TLabel;
    BitBtnOK: TBitBtn;
    BitBtnClose: TBitBtn;
    ProgressBar: TProgressBar;
    procedure BitBtnOKClick(Sender: TObject);
    procedure BitBtnCloseClick(Sender: TObject);
    procedure EditFileDirButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    procedure Open(nStart, nStop: Integer);
  end;

var
  frmOutPutDlg: TfrmOutPutDlg;

implementation
uses DIB,MirShare;

{$R *.dfm}

procedure TfrmOutPutDlg.Open(nStart, nStop: Integer);
begin
  EditX.IntValue := nStart;
  EditY.IntValue := nStop;
  ProgressBar.Position := 0;
  ProgressBar.Max := 100;
  ShowModal;
end;

procedure TfrmOutPutDlg.BitBtnOKClick(Sender: TObject);
var
  nStart, nStop: Integer;
  nBIndex, nEIndex, nIndex, nCount: Integer;
  sFileName: string;
  sPath: string;
  Pt: TPoint;
  Bitmap: TDIB;
begin
  if not Assigned(CurrImageFile) then Exit;
  if g_boWalking then Exit;
  BitBtnOK.Enabled := False;
  BitBtnClose.Enabled := False;
  g_boWalking := True;
  try
    nStart := EditX.IntValue;
    nStop := EditY.IntValue;

    sPath := Trim(EditFileDir.Text);
    if (sPath[Length(sPath)] <> '\') then sPath := sPath + '\';
    if (nStop >= nStart) and (nStart >= 0) and (nStop < CurrImageFile.ImageCount) then begin
      ProgressBar.Position := 0;
      ProgressBar.Max := nStop - nStart + 1;

      for nIndex := nStart to nStop do begin
        Bitmap := CurrImageFile.Bitmaps[nIndex];
        //if nIndex mod 10 = 0 then
        Application.ProcessMessages;
        ProgressBar.Position := ProgressBar.Position + 1;
        if Bitmap <> nil then begin
          sFileName := sPath + Format('%.5d', [nIndex]) + '.BMP';
          Pt := CurrImageFile.ImagePoint[nIndex];
          SetPoint(sFileName, Pt);
          try
            Bitmap.SaveToFile(sFileName);
          except
          end;
        end;
      end;
      Application.MessageBox('图片导出成功 ！！！', '提示信息', MB_ICONQUESTION);
    end;
  finally
    g_boWalking := False;
    BitBtnOK.Enabled := True;
    BitBtnClose.Enabled := True;
  end;
end;

procedure TfrmOutPutDlg.BitBtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmOutPutDlg.EditFileDirButtonClick(Sender: TObject);
var
  Directory: string;
begin
  if SelectDirectory('浏览文件夹', '', Directory, Handle) then begin
    EditFileDir.Text := Directory;
  end;
end;

procedure TfrmOutPutDlg.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := not g_boWalking;
end;

end.

