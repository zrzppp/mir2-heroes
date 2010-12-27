unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, RzButton, StdCtrls, Mask, RzEdit, RzBtnEdt, HumDB, ShareRecord;

type
  TFrmMain = class(TForm)
    EditMir: TRzButtonEdit;
    Label1: TLabel;
    ButtonConvert: TRzButton;
    ProgressBar: TProgressBar;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure ButtonConvertClick(Sender: TObject);
    procedure EditMirButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation
uses HUtil32;
{$R *.dfm}

procedure TFrmMain.ButtonConvertClick(Sender: TObject);
var
  FileDB: TFileDB;
  sSourceFiles: string;
begin
  sSourceFiles := Trim(EditMir.Text);
  if not FileExists(sSourceFiles) then begin
    Application.MessageBox('没有发现: Mir.DB ！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  ButtonConvert.Enabled := False;
  FileDB := TFileDB.Create(sSourceFiles);
  FileDB.m_boConvert := True;
  FileDB.m_ProgressBar := ProgressBar;
  FileDB.Load;
  FileDB.Convert;
  with SaveDialog do begin
    Filter := 'Mir|*.DB';
    {if FileName = '' then }FileName := 'Mir.DB';
    //FileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.exe';
    if Execute and (FileName <> '') then begin
      if ExtractFileExt(FileName) <> '.DB' then
        FileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.DB';
      try
        FileDB.SaveToFile(FileName);
        //MemoryStream.SaveToFile(FileName);
        Application.MessageBox('转换成功 ！！！', '提示信息', MB_ICONQUESTION);
      except
        on e: Exception do begin
          Application.MessageBox(PChar(e.Message), '错误信息', MB_ICONERROR);
        end;
      end;
    end;
  end;
  FileDB.Free;
  ButtonConvert.Enabled := True;
  {Showmessage('TOAbility:'+IntToStr(SizeOf(TOAbility)));
  Showmessage('TAbility:'+IntToStr(SizeOf(TAbility))); }
end;

procedure TFrmMain.EditMirButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'Mir.db|*.db';
  if OpenDialog.Execute then begin
    EditMir.Text := OpenDialog.FileName;
  end;
end;

end.

