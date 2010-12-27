unit OpenDialogNew;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, RzShellCtrls, StdCtrls,
  RzCmboBx, RzListVw, RzLabel,
  RzButton, Mask, RzEdit, MediaPlayerShare {, Share};

type
  TfrmOpenDiaLogNew = class(TForm)
    RzShellCombo: TRzShellCombo;
    RzShellList: TRzShellList;
    EditFileName: TRzEdit;
    ComboBoxFileType: TRzComboBox;
    RzButtonOpen: TRzButton;
    RzButtonClose: TRzButton;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzBitBtnUp: TRzBitBtn;
    RzLabel3: TRzLabel;
    procedure RzShellListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure RzShellListDblClickOpen(Sender: TObject;
      var Handled: Boolean);
    procedure RzBitBtnUpClick(Sender: TObject);
    procedure RzButtonOpenClick(Sender: TObject);
    procedure RzButtonCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FPlay: Boolean;
  public
    { Public declarations }

    procedure Open(boPlay: Boolean);
  end;

var
  frmOpenDiaLogNew: TfrmOpenDiaLogNew;

implementation
uses MediaPlayerMain;
{$R *.dfm}

procedure TfrmOpenDiaLogNew.Open(boPlay: Boolean);
begin
  FPlay := boPlay;
  Show;
  //SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_SHOWWINDOW);
end;

procedure TfrmOpenDiaLogNew.RzShellListSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if RzShellList.SelectedItem <> nil then begin
    if not RzShellList.SelectedItem.IsFolder then begin
      EditFileName.Text := RzShellList.SelectedItem.FileName;
    end;
  end;
end;

procedure TfrmOpenDiaLogNew.RzShellListDblClickOpen(Sender: TObject;
  var Handled: Boolean);
var
  nIndex: Integer;
begin
  Handled := True;
  if RzShellList.SelectedItem <> nil then begin
    if not RzShellList.SelectedItem.IsFolder then begin
      EditFileName.Text := RzShellList.SelectedItem.FileName;
      nIndex := g_PlayList.Add(RzShellList.SelectedItem.PathName);
      frmCqFirMediaPlayer.RefListBoxPlayList();
      if nIndex >= 0 then begin
        frmCqFirMediaPlayer.RefListBoxPlayList();
        if FPlay then
          frmCqFirMediaPlayer.Play(pTPlayFile(g_PlayList.m_PlayList.Objects[nIndex]).sSource, False);
      end;
      Visible := False;
    end;
  end;
end;

procedure TfrmOpenDiaLogNew.RzBitBtnUpClick(Sender: TObject);
begin
  RzShellList.GoUp(1);
end;

procedure TfrmOpenDiaLogNew.RzButtonOpenClick(Sender: TObject);
var
  nIndex: Integer;
begin
  if RzShellList.SelectedItem <> nil then begin
    if not RzShellList.SelectedItem.IsFolder then begin
      nIndex := g_PlayList.Add(RzShellList.SelectedItem.PathName); // + RzShellList.SelectedItem.FileName
      if nIndex >= 0 then begin
        frmCqFirMediaPlayer.RefListBoxPlayList();
        if FPlay then
          frmCqFirMediaPlayer.Play(pTPlayFile(g_PlayList.m_PlayList.Objects[nIndex]).sSource, False);
      end;
      Visible := False;
    end;
  end;
end;

procedure TfrmOpenDiaLogNew.RzButtonCloseClick(Sender: TObject);
begin
  {if FPlay then
    frmCqFirMediaPlayer.Play();}
  Close;
end;

procedure TfrmOpenDiaLogNew.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caHide;
end;

end.

