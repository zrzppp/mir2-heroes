unit AboutUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellApi, Common, PlugShare, EncryptUnit,
  Mask, RzEdit, RzBtnEdt;

type
  TFrmAbout = class(TForm)
    GroupBox1: TGroupBox;
    ButtonOK: TButton;
    Image: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EditDomainName: TRzButtonEdit;
    OpenDialog: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure EditDomainNameButtonClick(Sender: TObject);
  private
    { Private declarations }

    procedure RefDomainName(Buffer: PChar);
  public
    { Public declarations }
  end;

var
  FrmAbout: TFrmAbout;

implementation

{$R *.dfm}

function GetDate(D: TDate): string;
var
  Year, Mon, Day: Word;
  sMon: string;
  sDay: string;
begin
  DecodeDate(D, Year, Mon, Day);
  if Mon < 10 then sMon := '0' + IntToStr(Mon)
  else sMon := IntToStr(Mon);
  if Day < 10 then sDay := '0' + IntToStr(Day)
  else sDay := IntToStr(Day);
  Result := IntToStr(Year) + '年' + sMon + '月' + sDay + '日';
end;

procedure TFrmAbout.RefDomainName(Buffer: PChar);
const
  sVersion = '引擎版本: %s'; //引擎版本: %s
  sDomainName = '绑定域名: %s'; //绑定域名: %s
  VersionArray: array[0..1] of string = ('分身', '英雄'); // ('分身', '英雄');
  sLabels0_1 = '零售版'; //零售版
  sLabels0_2 = '企业版'; //企业版
  sLabels3 = '使用期限: %s'; //使用期限: %s
  sNotLimitVersion = '无限期'; //无限期
var
  Count: PInteger;
  MemoryStream: TMemoryStream;
  ConfigOption: TConfigOption;
  //Buffer: Pointer;
  sOption: string;
  nCRC: Cardinal;
  boVersion: Boolean;


  UserReg: TUserReg;
  sBuffer: string;
  nLen: Integer;

begin
  Move(Buffer^, nLen, SizeOf(Integer));
  SetLength(sBuffer, nLen);
  Move(PlugBuffer[SizeOf(Integer)], sBuffer[1], nLen);
  DecryptBuffer(sBuffer, @UserReg, SizeOf(TUserReg));

  boVersion := Boolean((abs(UserReg.nOwnerNumber - UserReg.nUserNumber)));
  if not boVersion then begin
    Label1.Caption := Format(sVersion, [VersionArray[HiWord(UserReg.nVersion)] + sLabels0_1]);
  end else begin
    Label1.Caption := Format(sVersion, [VersionArray[HiWord(UserReg.nVersion)] + sLabels0_2]);
  end;
  Label2.Caption := Format(sDomainName, [UserReg.sDomainName]);

  if UserReg.boUnlimited then begin
    Label3.Caption := Format(sLabels3, [sNotLimitVersion]);
  end else begin
    if (UserReg.sDomainName <> '') and (StringCrc(UserReg.sDomainName) = UserReg.nDomainName) then begin
      Label3.Caption := Format(sLabels3, [GetDate(UserReg.BeginDate) + '至' + GetDate(UserReg.EndDate)]);
    end else begin
      Label3.Caption := Format(sLabels3, ['']);
    end;
  end;
end;

procedure TFrmAbout.FormCreate(Sender: TObject);
begin
  Image.Picture.Icon.Handle := ExtractIcon(hInstance, PChar(Application.ExeName), 0);
  RefDomainName(PlugBuffer);
end;

procedure TFrmAbout.ButtonOKClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmAbout.EditDomainNameButtonClick(Sender: TObject);
var
  CharArr: array[0..254] of Char;
  sOption, sBuffer: string;
  nLen: Integer;
  nPro: Integer;

  Count: Integer;
  MemoryStream: TMemoryStream;
  ConfigOption: TConfigOption;
  Buffer: Pointer;
  nCRC: Cardinal;


  UserReg: TUserReg;

  //sCaption: string;
  //dwTickTime: LongWord;
  I: Integer;
  DomainNameList: TStringList;
  DomainNameFile: TDomainNameFile;
begin
  {nLen := 0;

  FillChar(DomainNameFile, SizeOf(TDomainNameFile), 0);
  FillChar(UserReg, SizeOf(TUserReg), 0);
  UserReg.nOwnerNumber := ConfigOption.nOwnerNumber;
  UserReg.nUserNumber := ConfigOption.nUserNumber;
  UserReg.nVersion := ConfigOption.nVersion;
  if FileExists(g_sDomainNameFileName) then begin
    sBuffer := '';
    DomainNameList := TStringList.Create;
    try
      DomainNameList.LoadFromFile(g_sDomainNameFileName);
    except

    end;
    for I := 0 to DomainNameList.Count - 1 do begin
      sBuffer := sBuffer + Trim(DomainNameList[I]);
    end;
    DomainNameList.Free;

    DecryptBuffer(sBuffer, @DomainNameFile, SizeOf(TDomainNameFile));

    if (ConfigOption.nOwnerNumber = DomainNameFile.nOwnerNumber) and
      (ConfigOption.nUserNumber = DomainNameFile.nUserNumber) and
      (ConfigOption.nVersion = DomainNameFile.nVersion) and
      (DomainNameFile.sDomainName <> '') and (HashPJW(DomainNameFile.sDomainName) = DomainNameFile.nDomainName) and
      (DomainNameFile.boUnlimited or ((Date <= DomainNameFile.MaxDate) and (Date >= DomainNameFile.MinDate))) then begin
      UserReg.BeginDate := DomainNameFile.MinDate;
      UserReg.EndDate := DomainNameFile.MaxDate;
      UserReg.nCount := GetDayCount(UserReg.EndDate, UserReg.BeginDate);
      UserReg.boUnlimited := DomainNameFile.boUnlimited;
      UserReg.sDomainName := DomainNameFile.sDomainName;
      UserReg.nDomainName := DomainNameFile.nDomainName;
    end;
  end;}
end;

end.

