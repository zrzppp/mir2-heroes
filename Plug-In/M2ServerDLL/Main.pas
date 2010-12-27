unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, EngineInterface, ExtCtrls, ShellApi;

type
  TFrmMain = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Label1: TLabel;


  private
    { Private declarations }
    Timer: TTimer;
    ButtonOK: TButton;
    GroupBox: TGroupBox;
    Img: TImage;
    Labels: array[0..4] of TLabel;
    Edits: array[0..1] of TEdit;
    procedure TimerTimer(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
  public
    { Public declarations }
    procedure Open();
  end;

var
  FrmMain: TFrmMain;

implementation
uses PlugShare, HUtil32, EDcode, Common;
{$R *.dfm}

procedure TFrmMain.ButtonOKClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.Open();
var
  I: Integer;
begin
  ButtonOK := TButton.Create(Owner);
  ButtonOK.Parent := FrmMain;
  ButtonOK.Left := 286;
  ButtonOK.Top := 280;
  ButtonOK.Caption := '确定';
  ButtonOK.OnClick := ButtonOKClick;
  Timer := TTimer.Create(Owner);
  Timer.Enabled := False;
  Timer.OnTimer := TimerTimer;
  GroupBox := TGroupBox.Create(Owner);
  GroupBox.Parent := FrmMain;
  GroupBox.Left := 8;
  GroupBox.Top := 8;
  GroupBox.Width := 353;
  GroupBox.Height := 266;

  Img := TImage.Create(Owner);
  //Img.Visible := False;
  Img.Parent := GroupBox;
  Img.Left := 24;
  Img.Top := 24;
  Img.Picture.Icon.Handle := ExtractIcon(hInstance, PChar(Application.ExeName), 0);

  for I := 0 to Length(Labels) - 1 do begin
    Labels[I] := TLabel.Create(Owner);
    Labels[I].Parent := GroupBox;
    Labels[I].Left := 88;
    Labels[I].Top := 32 + I * 40;
    Labels[I].Caption := 'Label' + IntToStr(I);
    //Labels[I].Visible := False;
  end;
  
  Labels[0].Caption := '引擎版本: ' + IntToStr(I);
  Labels[1].Caption := '机器码: ' + IntToStr(I);
  Labels[2].Caption := '最大同时在线人数: ' + IntToStr(I);
  Labels[3].Caption := '使用期限: ' + IntToStr(I);
  Labels[4].Caption := '注册码: ' + IntToStr(I);

  for I := 0 to Length(Edits) - 1 do begin
    Edits[I] := TEdit.Create(Owner);
    Edits[I].Parent := GroupBox;
    Edits[I].Left := 136;
    //Edits[I].Visible := False;
    Edits[I].Text := '';
    Edits[I].Width := 172;
  end;
  Edits[0].Top := 70;
  Edits[0].ReadOnly := True;
  Edits[1].Top := 190;

  Timer.Interval := 3000;
  Timer.Enabled := True;

  ShowModal;
end;

procedure TFrmMain.TimerTimer(Sender: TObject);
var
  OptionSize: Integer;
  Count: Integer;
  MemoryStream: TMemoryStream;
  ConfigOption: TConfigOption;
  Buffer: Pointer;
  sOption: string;
  nCRC: Integer;
  boVersion: Boolean;
  VersionArray: array[0..1] of string;
const
  sVersion = '引擎版本: %s';
  sSerialNumber = '机器码: ';
  sMaxOnlineCount = '最大同时在线人数: %d';
  sDateLimit = '使用期限: %s';
  sKey = '注册码: %s';
begin
  Timer.Enabled := False;
  OptionSize := Length(EncryptBuffer(@ConfigOption, SizeOf(TConfigOption)));
  MemoryStream := TMemoryStream.Create;
  MemoryStream.LoadFromFile(Application.ExeName);

  MemoryStream.Seek(-(SizeOf(Integer) + OptionSize), soFromEnd);
  MemoryStream.Read(Count, SizeOf(Integer));

  GetMem(Buffer, OptionSize);
  try
    MemoryStream.Read(Buffer^, OptionSize);
    SetLength(sOption, OptionSize);
    Move(Buffer^, sOption[1], OptionSize);
  finally
    FreeMem(Buffer);
  end;

  GetMem(Buffer, Count);
  try
    MemoryStream.Seek(0, soFromBeginning);
    MemoryStream.Read(Buffer^, Count);
    nCRC := CalcBufferCRC(Buffer, Count);
  finally
    FreeMem(Buffer);
  end;

  MemoryStream.Free;

  if DecryptBuffer(sOption, @ConfigOption, SizeOf(TConfigOption)) then begin
    if Count = ConfigOption.nSize then begin
      if nCRC = ConfigOption.nCrc then begin
        Labels[0].Visible := True;
        VersionArray[0] := '分身';
        VersionArray[1] := '英雄';
        boVersion := Boolean((abs(ConfigOption.nOwnerNumber - ConfigOption.nUserNumber)));
        if boVersion then begin
          Labels[0].Caption := Format(sVersion, [VersionArray[ConfigOption.nVersion] + '零售版']);
        end else begin
          Labels[0].Caption := Format(sVersion, [VersionArray[ConfigOption.nVersion] + '企业版']);
        end;
      end;
    end;
  end;
end;

end.

