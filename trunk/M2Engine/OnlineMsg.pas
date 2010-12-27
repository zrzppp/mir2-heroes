unit OnlineMsg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

type
  TfrmOnlineMsg = class(TForm)
    MemoMsg: TMemo;
    Label1: TLabel;
    StringGrid: TStringGrid;
    ButtonAdd: TButton;
    ButtonDelete: TButton;
    ButtonSend: TButton;
    EditMsg: TEdit;
    procedure StringGridClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure StringGridDblClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure MemoMsgChange(Sender: TObject);
    procedure ButtonSendClick(Sender: TObject);
    procedure EditMsgKeyPress(Sender: TObject; var Key: Char);
    procedure EditMsgChange(Sender: TObject);
  private
    StrList: TStringList;
    StrListFile: string;
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmOnlineMsg: TfrmOnlineMsg;
implementation

uses UsrEngn, M2Share, Grobal2;


{$R *.dfm}

procedure TfrmOnlineMsg.EditMsgChange(Sender: TObject);
begin
  try
    if Trim(EditMsg.Text) <> '' then
      ButtonAdd.Enabled := True
    else
      ButtonAdd.Enabled := False;
  finally

  end;
end;

procedure TfrmOnlineMsg.EditMsgKeyPress(Sender: TObject; var Key: Char);
var
  Msg: string;
begin
  try
    case Ord(Key) of
      13: begin
          Msg := EditMsg.Text;
          if Trim(Msg) <> '' then begin
            UserEngine.SendBroadCastMsgExt(Msg, t_System);
            MemoMsg.Lines.Add(g_Config.sSysMsgPreFix + Msg);
          end;
          EditMsg.Text := '';
          ButtonAdd.Enabled := False;
        end;
    end;
  finally
  end;
end;

procedure TfrmOnlineMsg.StringGridClick(Sender: TObject);
begin
  try
    if StringGrid.Col >= 0 then
      ButtonDelete.Enabled := True;
  finally
  end;
end;

procedure TfrmOnlineMsg.FormCreate(Sender: TObject);
begin
  StrListFile := '.\MsgList.txt';
  StrList := TStringList.Create;
  if FileExists(StrListFile) then begin
    StrList.LoadFromFile(StrListFile);
    StringGrid.RowCount := StrList.Count;
    StringGrid.Cols[0] := StrList;
  end else begin
    StrList.SaveToFile(StrListFile);
  end;
  MemoMsg.Clear;
end;

procedure TfrmOnlineMsg.ButtonAddClick(Sender: TObject);
var
  Msg: string;
begin
  try
    Msg := Trim(EditMsg.Text);
    if Msg <> '' then begin
      StrList.Add(Msg);
    end;
    StringGrid.RowCount := StrList.Count;
    StringGrid.Cols[0] := StrList;
    ButtonAdd.Enabled := False;
    StrList.SaveToFile(StrListFile);
  finally
  end;
end;

procedure TfrmOnlineMsg.StringGridDblClick(Sender: TObject);
begin
  try
    EditMsg.Text := StrList.Strings[StringGrid.Row];
    EditMsg.SetFocus;
  finally
  end;
end;

procedure TfrmOnlineMsg.ButtonDeleteClick(Sender: TObject);
begin
  try
    if StringGrid.RowCount = 1 then begin
      ButtonDelete.Enabled := False;
      Exit;
    end;
    StrList.Delete(StringGrid.Row);
    StringGrid.RowCount := StrList.Count;
    StringGrid.Cols[0] := StrList;
    StrList.SaveToFile(StrListFile);
  finally
  end;
end;

procedure TfrmOnlineMsg.MemoMsgChange(Sender: TObject);
begin
  try
    if MemoMsg.Lines.Count > 80 then begin
      MemoMsg.Lines.Clear;
    end;
  finally
  end;
end;

procedure TfrmOnlineMsg.ButtonSendClick(Sender: TObject);
var
  Msg: string;
begin
  Msg := EditMsg.Text;
  if Trim(Msg) <> '' then begin
    UserEngine.SendBroadCastMsgExt(Msg, t_System);
    MemoMsg.Lines.Add(g_Config.sSysMsgPreFix + Msg);
  end;
  EditMsg.Text := '';
end;

procedure TfrmOnlineMsg.Open;
begin
  ShowModal;
end;

end.
