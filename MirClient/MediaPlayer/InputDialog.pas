unit InputDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MediaPlayerShare, RzButton, StdCtrls, Mask, RzEdit, RzLabel,
  Buttons {, Share};

type
  TfrmInputDialog = class(TForm)
    RzLabel1: TRzLabel;
    EditFileAddr: TRzEdit;
    ButtonOK: TRzButton;
    ButtonClose: TRzButton;
    RzLabel2: TRzLabel;
    EditShowName: TRzEdit;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure Open();
  end;

var
  frmInputDialog: TfrmInputDialog;

implementation

uses MediaPlayerMain;

{$R *.dfm}

procedure TfrmInputDialog.Open();
begin
  Show;
  //SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_SHOWWINDOW);
end;


procedure TfrmInputDialog.ButtonOKClick(Sender: TObject);
var
  sShowName, sFileAddr: string;
begin
  sShowName := Trim(EditShowName.Text);
  sFileAddr := Trim(EditFileAddr.Text);
  if sShowName = '' then begin
    EditShowName.SetFocus;
    Exit;
  end;
  if sFileAddr = '' then begin
    EditFileAddr.SetFocus;
    Exit;
  end;
  g_PlayList.Add(sShowName + '|' + sFileAddr);
  frmCqFirMediaPlayer.RefListBoxPlayList();
  Close;
end;

procedure TfrmInputDialog.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmInputDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caHide;
end;

end.

