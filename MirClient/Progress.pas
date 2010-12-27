unit Progress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls;

type
  TFrmProgress = class(TForm)
    ProgressBar: TProgressBar;
    Timer: TTimer;
    Image: TImage;
    Label1: TLabel;
    LabelMsg: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmProgress: TFrmProgress;

implementation

{$R *.dfm}

procedure TFrmProgress.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  ModalResult := mrOk;
end;

procedure TFrmProgress.TimerTimer(Sender: TObject);
begin
  ProgressBar.Position := ProgressBar.Position + 1;
  if ProgressBar.Position >= ProgressBar.Max then Close;
end;

procedure TFrmProgress.FormCreate(Sender: TObject);
var
  nIndex: Integer;
  sFileName: string;
  LoadList: TStringList;
begin
  sFileName := ExtractFilePath(Application.ExeName) + 'Data\progress.bmp';
  if FileExists(sFileName) then begin
    try
      Image.Picture.LoadFromFile(sFileName);
      ClientWidth := Image.Picture.Width;
      ClientHeight := Image.Picture.Height;
    except

    end;
  end;
  sFileName := ExtractFilePath(Application.ExeName) + 'Data\Tips.dat';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sFileName);
      for nIndex := LoadList.Count - 1 downto 0 do begin
        if Trim(LoadList[nIndex]) = '' then LoadList.Delete(nIndex);
      end;
    except

    end;
    Randomize;
    nIndex := Random(LoadList.Count - 1);
    if (nIndex >= 0) and (nIndex < LoadList.Count) then begin
      LabelMsg.Caption := LoadList[nIndex];
    end;
    LabelMsg.Left := (Width - LabelMsg.Width) div 2;
    LoadList.Free;
  end;

end;

end.

