unit LogMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, StdCtrls, RzEdit, RzStatus;

type
  TfrmLog = class(TForm)
    PanelLeft: TRzPanel;
    PanelRight: TRzPanel;
    PanelClient: TRzPanel;
    RzStatusBar1: TRzStatusBar;
    RzGroupBox1: TRzGroupBox;
    RzGroupBox2: TRzGroupBox;
    RzGroupBox3: TRzGroupBox;
    MemoIDLog: TRzMemo;
    MemoHumLog: TRzMemo;
    MemoGuildLog: TRzMemo;
    StatusPaneID: TRzStatusPane;
    StatusPaneGuild: TRzStatusPane;
    StatusPaneHum: TRzStatusPane;
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open();
  end;

var
  frmLog: TfrmLog;

implementation
uses Share;
{$R *.dfm}

procedure TfrmLog.Open();
begin
  if FileExists(g_sSaveDir + 'LogID.txt') then
    MemoIDLog.Lines.LoadFromFile(g_sSaveDir + 'LogID.txt');
  if FileExists(g_sSaveDir + 'LogHum.txt') then
    MemoHumLog.Lines.LoadFromFile(g_sSaveDir + 'LogHum.txt');
  if FileExists(g_sSaveDir + 'LogGuild.txt') then
    MemoGuildLog.Lines.LoadFromFile(g_sSaveDir + 'LogGuild.txt');
  StatusPaneID.Caption := '账号变更记录数:' + IntToStr(MemoIDLog.Lines.Count);
  StatusPaneHum.Caption := '角色名变更记录数:' + IntToStr(MemoHumLog.Lines.Count);
  StatusPaneGuild.Caption := '行会名变更记录数:' + IntToStr(MemoGuildLog.Lines.Count);
  ShowModal;
end;

procedure TfrmLog.FormResize(Sender: TObject);
begin
  PanelLeft.Width := Width div 3;
    //PanelLeft.Width:=  Width div 3;
  PanelRight.Width := Width div 3;
  StatusPaneID.Width := Width div 3;
  StatusPaneGuild.Width := Width div 3;
end;

end.

