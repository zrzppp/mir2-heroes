unit ViewKernelInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Grids, M2Share;

type
  TfrmViewKernelInfo = class(TForm)
    Timer: TTimer;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    EditWinLotteryCount: TEdit;
    EditNoWinLotteryCount: TEdit;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    EditWinLotteryLevel1: TEdit;
    EditWinLotteryLevel2: TEdit;
    EditWinLotteryLevel3: TEdit;
    EditWinLotteryLevel4: TEdit;
    Label13: TLabel;
    EditWinLotteryLevel5: TEdit;
    Label14: TLabel;
    EditWinLotteryLevel6: TEdit;
    TabSheet3: TTabSheet;
    GroupBox5: TGroupBox;
    TabSheet4: TTabSheet;
    GroupBox6: TGroupBox;
    Label25: TLabel;
    EditAllocMemCount: TEdit;
    Label26: TLabel;
    EditAllocMemSize: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EditLoadHumanDBCount: TEdit;
    EditLoadHumanDBErrorCoun: TEdit;
    EditSaveHumanDBCount: TEdit;
    EditHumanDBQueryID: TEdit;
    GroupBox4: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    EditItemNumber: TEdit;
    EditItemNumberEx: TEdit;
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet5: TTabSheet;
    ListViewG: TListView;
    ListViewA: TListView;
    ButtonClearG: TButton;
    ButtonRefG: TButton;
    ButtonClearA: TButton;
    ButtonRefA: TButton;
    procedure TimerTimer(Sender: TObject);
    procedure ButtonRefGClick(Sender: TObject);
    procedure ButtonRefAClick(Sender: TObject);
    procedure ButtonClearGClick(Sender: TObject);
    procedure ButtonClearAClick(Sender: TObject);
  private
    procedure RefG;
    procedure RefA;
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmViewKernelInfo: TfrmViewKernelInfo;

implementation

//uses M2Share;

{$R *.dfm}

{ TfrmViewKernelInfo }

procedure TfrmViewKernelInfo.Open;
begin
  Timer.Enabled := True;
  RefG;
  RefA;
  ShowModal;
  Timer.Enabled := False;
end;

procedure TfrmViewKernelInfo.TimerTimer(Sender: TObject);
var
  Config: pTConfig;
  ThreadInfo: pTThreadInfo;
begin
  Config := @g_Config;
  EditLoadHumanDBCount.Text := IntToStr(g_Config.nLoadDBCount);
  EditLoadHumanDBErrorCoun.Text := IntToStr(g_Config.nLoadDBErrorCount);
  EditSaveHumanDBCount.Text := IntToStr(g_Config.nSaveDBCount);
  EditHumanDBQueryID.Text := IntToStr(g_Config.nDBQueryID);

  EditItemNumber.Text := IntToStr(g_Config.nItemNumber);
  EditItemNumberEx.Text := IntToStr(g_Config.nItemNumberEx);

  EditWinLotteryCount.Text := IntToStr(g_Config.nWinLotteryCount);
  EditNoWinLotteryCount.Text := IntToStr(g_Config.nNoWinLotteryCount);
  EditWinLotteryLevel1.Text := IntToStr(g_Config.nWinLotteryLevel1);
  EditWinLotteryLevel2.Text := IntToStr(g_Config.nWinLotteryLevel2);
  EditWinLotteryLevel3.Text := IntToStr(g_Config.nWinLotteryLevel3);
  EditWinLotteryLevel4.Text := IntToStr(g_Config.nWinLotteryLevel4);
  EditWinLotteryLevel5.Text := IntToStr(g_Config.nWinLotteryLevel5);
  EditWinLotteryLevel6.Text := IntToStr(g_Config.nWinLotteryLevel6);

  {EditGlobalVal1.Text := IntToStr(g_Config.GlobalVal[0]);
  EditGlobalVal2.Text := IntToStr(g_Config.GlobalVal[1]);
  EditGlobalVal3.Text := IntToStr(g_Config.GlobalVal[2]);
  EditGlobalVal4.Text := IntToStr(g_Config.GlobalVal[3]);
  EditGlobalVal5.Text := IntToStr(g_Config.GlobalVal[4]);
  EditGlobalVal6.Text := IntToStr(g_Config.GlobalVal[5]);
  EditGlobalVal7.Text := IntToStr(g_Config.GlobalVal[6]);
  EditGlobalVal8.Text := IntToStr(g_Config.GlobalVal[7]);
  EditGlobalVal9.Text := IntToStr(g_Config.GlobalVal[8]);
  EditGlobalVal10.Text := IntToStr(g_Config.GlobalVal[9]);}

  EditAllocMemSize.Text := IntToStr(AllocMemSize);
  EditAllocMemCount.Text := IntToStr(AllocMemCount);
end;

procedure TfrmViewKernelInfo.RefG;
var
  I: Integer;
  ListItem: TListItem;
  Config: pTConfig;
begin
  Config := @g_Config;
  ListViewG.Items.BeginUpdate;
  try
    ListViewG.Items.Clear;
  finally
    ListViewG.Items.EndUpdate;
  end;
  for I := Low(Config.GlobalVal) to High(Config.GlobalVal) do begin
    ListViewG.Items.BeginUpdate;
    try
      ListItem := ListViewG.Items.Add;
      ListItem.Caption := IntToStr(I);
      ListItem.SubItems.Add(IntToStr(Config.GlobalVal[I]));
    finally
      ListViewG.Items.EndUpdate;
    end;
  end;
end;

procedure TfrmViewKernelInfo.RefA;
var
  I: Integer;
  ListItem: TListItem;
  Config: pTConfig;
begin
  Config := @g_Config;
  ListViewA.Items.BeginUpdate;
  try
    ListViewA.Items.Clear;
  finally
    ListViewA.Items.EndUpdate;
  end;
  for I := Low(Config.GlobalAVal) to High(Config.GlobalAVal) do begin
    ListViewA.Items.BeginUpdate;
    try
      ListItem := ListViewA.Items.Add;
      ListItem.Caption := IntToStr(I);
      ListItem.SubItems.Add(Config.GlobalAVal[I]);
    finally
      ListViewA.Items.EndUpdate;
    end;
  end;
end;

procedure TfrmViewKernelInfo.ButtonRefGClick(Sender: TObject);
begin
  ButtonRefG.Enabled := False;
  RefG;
  ButtonRefG.Enabled := True;
end;

procedure TfrmViewKernelInfo.ButtonRefAClick(Sender: TObject);
begin
  ButtonRefA.Enabled := False;
  RefA;
  ButtonRefA.Enabled := True;
end;

procedure TfrmViewKernelInfo.ButtonClearGClick(Sender: TObject);
var
  I: Integer;
  Config: pTConfig;
begin
  ButtonRefG.Enabled := False;
  ButtonClearG.Enabled := False;
  Config := @g_Config;
  for I := Low(Config.GlobalVal) to High(Config.GlobalVal) do begin
    Config.GlobalVal[I] := 0;
  end;
  RefG;
  ButtonRefG.Enabled := True;
  ButtonClearG.Enabled := True;
end;

procedure TfrmViewKernelInfo.ButtonClearAClick(Sender: TObject);
var
  I: Integer;
  Config: pTConfig;
begin
  ButtonRefA.Enabled := False;
  ButtonClearA.Enabled := False;
  Config := @g_Config;
  for I := Low(Config.GlobalAVal) to High(Config.GlobalAVal) do begin
    Config.GlobalAVal[I] := '';
  end;
  RefA;
  ButtonRefA.Enabled := True;
  ButtonClearA.Enabled := True;
end;

end.
