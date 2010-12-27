unit Main;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ExtCtrls, Spin, Buttons, IniFiles, Common, RzEdit,
  RzBtnEdt;

type
  TUserInfo = record
    Version: Integer;
    SerialNumber: string;
    Key: string; //机器码
  end;
  pTUserInfo = ^TUserInfo;

 { TMakeInfo = record //232
    nOwnerNumber: Integer; //QQ号码
    nUserNumber: Integer; //QQ号码
    nSerialNumber: Integer; //机器码
    nSize: Integer;
    nCrc: Integer;
    nVersion: Integer;
    dDate: TDate;
    Param: array[0..10] of Integer;
  end;
  pTMakeInfo = ^TMakeInfo;

  TMakeRegInfo = record //920
    sSerialNumber: string[32];
    sBuffer: string[255];
    nBuffer: Integer;
    Param: array[0..10] of Integer;
  end;
  pTMakeRegInfo = ^TMakeRegInfo;
  }
  TfrmMain = class(TForm)
    GroupBox1: TGroupBox;
    RzLabel1: TLabel;
    RzLabel2: TLabel;
    RzLabel3: TLabel;
    RzLabel4: TLabel;
    RzLabel5: TLabel;
    EditName: TEdit;
    EditLoadPlugSucced: TEdit;
    EditLoadPlugFail: TEdit;
    EditUnLoadPlug: TEdit;
    EditPassWord: TEdit;
    RzLabel6: TLabel;
    EditVersion: TSpinEdit;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    LabelDate: TLabel;
    EditVersion1: TSpinEdit;
    EditDays: TSpinEdit;
    ComboBoxSerialNumber: TComboBox;
    RadioGroupLicDay: TRadioGroup;
    MemoKey: TMemo;
    RadioGroupUserMode: TRadioGroup;
    ButtonOK: TButton;
    ButtonSave: TButton;
    ButtonDel: TButton;
    MemoMsg: TMemo;
    ButtonExit: TButton;
    ButtonCreatePlug: TButton;
    Button2: TButton;
    Timer: TTimer;
    ButtonSavePlug: TButton;
    CheckBoxShareMode: TCheckBox;
    Label4: TLabel;
    EditShareDay: TSpinEdit;
    procedure RadioGroupUserModeClick(Sender: TObject);
    procedure RadioGroupLicDayClick(Sender: TObject);

    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonDelClick(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
    procedure EditDaysChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EditVersionChange(Sender: TObject);
    procedure ButtonCreatePlugClick(Sender: TObject);
    procedure ButtonSavePlugClick(Sender: TObject);
  private
    { Private declarations }
    procedure AddToMemo(sMsg: string);
    procedure ButtonOKClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure ComboBoxSerialNumberChange(Sender: TObject);
    procedure LoadConfig(nVersion: Integer; ScriptConfig: pTScriptConfig);
    procedure SaveConfig(nVersion: Integer; ScriptConfig: pTScriptConfig);
    procedure LoadList;
    procedure UnLoadList;
    procedure SaveToFile;
    procedure Delete(SerialNumber: string);
    procedure Add(nVersion: Integer; SerialNumber, Key: string);
    function Find(SerialNumber: string): pTUserInfo; overload;
    function Find(nVersion: Integer): pTUserInfo; overload;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  g_UserList: TStringList;
implementation
uses EncryptUnit, HUtil32, MSI_CPU, MSI_Storage, MSI_Machine, MD5EncodeStr;
{$R *.dfm}
const
  g_sPlugName = 'MakeGM脚本扩展插件';
  g_sStartLoadPlugSucced = '加载MakeGM脚本扩展插件成功...';
  g_sStartLoadPlugFail = '加载MakeGM脚本扩展插件失败...';
  g_sUnLoadPlug = '卸载MakeGM扩展扩展插件成功...';
  g_sPassWord = '0123456789';

  g_sMsg: array[0..4] of string = ('请把机器码复制后发送给客服处，获取注册码！注册后才',
    '能正常使用！', //48
    '客服ＱＱ：1037527564',
    '程序网址：http://www.MakeGM.com',
    '更新日期：2010-09-01');

  s00 = 'kIuDNV23Wrkg';
  s03 = 'oNrVMvBIuEAT';
  s32 = 'PmMxe+GkeZGBVw==';
{$R Res\ScriptLoader.RES}
var
  g_StartOK: PBoolean;
  g_MemoryStream: TMemoryStream = nil;
//_____________________________________________________________________//

function GetSerialNumber(nUserNumber, nVersion: Integer): string;
  function GetBIOS: string;
  var
    BIOS: TBIOS;
  begin
    BIOS := TBIOS.Create;
    try
      BIOS.GetInfo;
      Result := Trim(BIOS.Copyright + #13 + BIOS.Date + #13 + BIOS.Name + #13 + BIOS.ExtendedInfo);
    except
      Result := '';
    end;
    BIOS.Free;
  end;

  function GetDiskSerialNumber: string;
  var
    Storage: TStorage;
  begin
    Storage := TStorage.Create;
    try
      Storage.GetInfo;
      if Storage.DeviceCount > 0 then begin
        Result := Trim(Storage.Devices[0].SerialNumber);
      end;
    except
      Result := '';
    end;
    Storage.Free;
  end;

  function GetCPUSerialNumber: string;
  var
    CurrProc: THandle;
    ProcessAffinityOld: Cardinal;
    ProcessAffinity: Cardinal;
    SystemAffinity: Cardinal;
    CPU: TCPU;
  begin
    CurrProc := GetCurrentProcess;
    try
      if GetProcessAffinityMask(CurrProc, ProcessAffinityOld, SystemAffinity) then begin
        ProcessAffinity := $1 shr 0; //this sets the process to only run on CPU 0  //第一个cpu的第一个
                              //for CPU 1 only use 2 and for CPUs 1 & 2 use 3
        SetProcessAffinityMask(CurrProc, ProcessAffinity);

        CPU := TCPU.Create;
        try
          CPU.GetInfo();
          Result := Trim(CPU.SerialNumber);
        except
          Result := '';
        end;
        CPU.Free;
      end;
    finally
    //恢复默认
      SetProcessAffinityMask(CurrProc, ProcessAffinityOld);
    end;
  end;
begin
  Result := RivestStr(IntToStr(StringCrc(RivestStr(GetBIOS) +
    RivestStr(GetCPUSerialNumber) +
    RivestStr(GetDiskSerialNumber)) +
    nUserNumber + nVersion + (nUserNumber * nVersion)));
end;

//_____________________________________________________________________//

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

procedure TfrmMain.LoadConfig(nVersion: Integer; ScriptConfig: pTScriptConfig);
var
  Conf: TIniFile;
begin
  Conf := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ScriptConfig.ini');
  ScriptConfig.sPlugName := Conf.ReadString(IntToStr(nVersion), 'PlugName', '');
  ScriptConfig.sLoadPlugSucced := Conf.ReadString(IntToStr(nVersion), 'LoadPlugSucced', '');
  ScriptConfig.sLoadPlugFail := Conf.ReadString(IntToStr(nVersion), 'LoadPlugFail', '');
  ScriptConfig.sUnLoadPlug := Conf.ReadString(IntToStr(nVersion), 'UnLoadPlug', '');
  ScriptConfig.sLabelMsg := Conf.ReadString(IntToStr(nVersion), 'LabelMsg', '');
  ScriptConfig.sPassWord := Conf.ReadString(IntToStr(nVersion), 'PassWord', '');
  Conf.Free;
end;

procedure TfrmMain.SaveConfig(nVersion: Integer; ScriptConfig: pTScriptConfig);
var
  Conf: TIniFile;
begin
  Conf := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ScriptConfig.ini');
  Conf.WriteString(IntToStr(nVersion), 'PlugName', ScriptConfig.sPlugName);
  Conf.WriteString(IntToStr(nVersion), 'LoadPlugSucced', ScriptConfig.sLoadPlugSucced);
  Conf.WriteString(IntToStr(nVersion), 'LoadPlugFail', ScriptConfig.sLoadPlugFail);
  Conf.WriteString(IntToStr(nVersion), 'UnLoadPlug', ScriptConfig.sUnLoadPlug);
  Conf.WriteString(IntToStr(nVersion), 'LabelMsg', ScriptConfig.sLabelMsg);
  Conf.WriteString(IntToStr(nVersion), 'PassWord', ScriptConfig.sPassWord);
  Conf.Free;
end;

procedure TFrmMain.LoadList;
var
  I: Integer;
  LoadList: TStringList;
  sFileName: string;
  UserInfo: pTUserInfo;
  sLineText: string;
  sVersion: string;
  sSerialNumber: string;
  sKey: string; //机器码
begin
  if g_UserList <> nil then begin
    UnLoadList;
  end;
  g_UserList := TStringList.Create;

  sFileName := ExtractFilePath(Application.ExeName) + 'ScriptKey.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      if (sLineText = '') or (sLineText[1] = ';') then Continue;
      sLineText := GetValidStr3(sLineText, sVersion, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sSerialNumber, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sKey, [' ', #9]);
      sSerialNumber := Trim(sSerialNumber);
      sKey := Trim(sKey);
      New(UserInfo);
      UserInfo.Version := Str_ToInt(sVersion, -1);
      UserInfo.SerialNumber := Trim(sSerialNumber);
      UserInfo.Key := Trim(sKey);
      g_UserList.AddObject(sSerialNumber, TObject(UserInfo));
    end;
    LoadList.Free;
    ComboBoxSerialNumber.Clear;
    ComboBoxSerialNumber.Items.AddStrings(g_UserList);
  end;
end;

procedure TFrmMain.UnLoadList;
var
  I: Integer;
begin
  if g_UserList <> nil then begin
    for I := 0 to g_UserList.Count - 1 do begin
      Dispose(pTUserInfo(g_UserList.Objects[I]));
    end;
    FreeAndNil(g_UserList);
  end;
end;

procedure TFrmMain.SaveToFile;
var
  I: Integer;
  SaveList: TStringList;
  sFileName: string;
  sLineText: string;
  UserInfo: pTUserInfo;
begin
  if g_UserList <> nil then begin
    SaveList := TStringList.Create;
    for I := 0 to g_UserList.Count - 1 do begin
      UserInfo := pTUserInfo(g_UserList.Objects[I]);
      sLineText := IntToStr(UserInfo.Version) + #9 + UserInfo.SerialNumber + #9 + UserInfo.Key;
      SaveList.Add(sLineText);
    end;
    sFileName := ExtractFilePath(Application.ExeName) + 'ScriptKey.txt';
    try
      SaveList.SaveToFile(sFileName);
    except

    end;
    SaveList.Free;
  end;
end;

procedure TFrmMain.TimerTimer(Sender: TObject);
begin
  if not g_StartOK^ then Exit;
  Timer.Enabled := False;
  LoadList;
end;

procedure TfrmMain.ButtonCreatePlugClick(Sender: TObject);
var
  sTempPlugName: string;
  sTempStartLoadPlugSucced: string;
  sTempStartLoadPlugFail: string;
  sTempUnLoadPlug: string;
  sTempPassWord: string;
  sTempSerialName: string;
  sTempMsg: string;
  sTempVersion: string;

  sSrcPassWord: string;

  I: Integer;

  dwWaitTick: Longword;
  OptionSize: PInteger;
  Count: PInteger;
  MemoryStream: TMemoryStream;
  MakeRegInfo: pTMakeRegInfo;
  MakeInfo: pTMakeInfo;
  Buffer: PChar;
  sOption: string;
  sBuffer: string;
  nCRC: PCardinal;
  boVersion: PBoolean;
  sSerialNumber: string;
  sInPutSerialNumber: string;

  nVersion: Word;
  ScriptConfig: pTScriptConfig;

  nDllCRC: PCardinal;
  nDllSize: PInteger;
  nSize: Integer;
begin
  if not g_StartOK^ then Exit;
  sTempPlugName := Trim(EditName.Text);
  sTempStartLoadPlugSucced := Trim(EditLoadPlugSucced.Text);
  sTempStartLoadPlugFail := Trim(EditLoadPlugFail.Text);
  sTempUnLoadPlug := Trim(EditUnLoadPlug.Text);
  sSrcPassWord := EncryptString(EditPassWord.Text);
  //sTempPassWord := EncryPassWord(PChar(sSrcPassWord));
  sTempMsg := '';
  for I := 0 to MemoMsg.Lines.Count - 1 do begin
    if I > 4 then Break;
    sTempMsg := sTempMsg + Trim(MemoMsg.Lines.Strings[I]) + #10#13;
  end;
  nVersion := EditVersion.Value;

  if sTempPlugName = '' then begin
    Application.MessageBox('请输入插件名称！！！', '提示信息', MB_ICONQUESTION);
    EditName.SetFocus;
    Exit;
  end;
  if sTempStartLoadPlugSucced = '' then begin
    Application.MessageBox('请输入加载成功信息！！！', '提示信息', MB_ICONQUESTION);
    EditLoadPlugSucced.SetFocus;
    Exit;
  end;
  if sTempStartLoadPlugFail = '' then begin
    Application.MessageBox('请输入加载失败信息！！！', '提示信息', MB_ICONQUESTION);
    EditLoadPlugFail.SetFocus;
    Exit;
  end;
  if sTempUnLoadPlug = '' then begin
    Application.MessageBox('请输入插件卸载信息！！！', '提示信息', MB_ICONQUESTION);
    EditUnLoadPlug.SetFocus;
    Exit;
  end;
  if sSrcPassWord = '' then begin
    Application.MessageBox('请输入插件密码！！！', '提示信息', MB_ICONQUESTION);
    EditPassWord.SetFocus;
    Exit;
  end;

  ButtonCreatePlug.Enabled := False;

  dwWaitTick := GetTickCount;
  while True do begin
    Application.ProcessMessages;
    if GetTickCount - dwWaitTick > 500 then break;
  end;

  New(OptionSize);
  New(Count);
  New(nCRC);
  New(MakeInfo);
  New(MakeRegInfo);
  MemoryStream := TMemoryStream.Create;
  try
    OptionSize^ := Length(EncryptBuffer(@MakeRegInfo^, SizeOf(TMakeRegInfo)));
    MemoryStream.LoadFromFile(Application.ExeName);

    MemoryStream.Seek(-(SizeOf(Integer) + OptionSize^), soFromEnd);
    MemoryStream.Read(Count^, SizeOf(Integer));

    GetMem(Buffer, OptionSize^);
    try
      MemoryStream.Read(Buffer^, OptionSize^);
      SetLength(sOption, OptionSize^);
      Move(Buffer^, sOption[1], OptionSize^);
    finally
      FreeMem(Buffer);
    end;

    GetMem(Buffer, Count^);
    try
      MemoryStream.Seek(0, soFromBeginning);
      MemoryStream.Read(Buffer^, Count^);
      nCRC^ := BufferCRC(Buffer, Count^);
    finally
      FreeMem(Buffer);
    end;

    DecryptBuffer(sOption, @MakeRegInfo^, SizeOf(TMakeRegInfo));
    DecryptBuffer(MakeRegInfo.sBuffer, @MakeInfo^, SizeOf(TMakeInfo));
    sSerialNumber := GetSerialNumber(MakeInfo.nUserNumber, MakeInfo.nVersion);
    if (Count^ = MakeInfo.nSize) and
      (nCRC^ = MakeInfo.nCrc) and
      (StringCrc(MakeRegInfo.sBuffer) = MakeRegInfo.nBuffer) and
      (MakeInfo.nSerialNumber = StringCrc(MakeRegInfo.sSerialNumber)) and
      (MakeInfo.nSerialNumber = StringCrc(sSerialNumber))
      then begin
      New(ScriptConfig);

      ScriptConfig.nOwnerNumber := MakeInfo.nOwnerNumber +
        (LoWord(MakeInfo.nVersion) - SOFTWARE_SCRIPT_MAKEKEY) +
        (Count^ - MakeInfo.nSize) +
        (nCRC^ - MakeInfo.nCrc) +
        (StringCrc(MakeRegInfo.sBuffer) - MakeRegInfo.nBuffer) +
        (MakeInfo.nSerialNumber - StringCrc(MakeRegInfo.sSerialNumber)) +
        (MakeInfo.nSerialNumber - StringCrc(sSerialNumber));

      ScriptConfig.nUserNumber := MakeInfo.nUserNumber +
        (LoWord(MakeInfo.nVersion) - SOFTWARE_SCRIPT_MAKEKEY) +
        (Count^ - MakeInfo.nSize) +
        (nCRC^ - MakeInfo.nCrc) +
        (StringCrc(MakeRegInfo.sBuffer) - MakeRegInfo.nBuffer) +
        (MakeInfo.nSerialNumber - StringCrc(MakeRegInfo.sSerialNumber)) +
        (MakeInfo.nSerialNumber - StringCrc(sSerialNumber));

      ScriptConfig.nVersion := MakeLong(SOFTWARE_SCRIPT, nVersion) +
        (LoWord(MakeInfo.nVersion) - SOFTWARE_SCRIPT_MAKEKEY) +
        (Count^ - MakeInfo.nSize) +
        (nCRC^ - MakeInfo.nCrc) +
        (StringCrc(MakeRegInfo.sBuffer) - MakeRegInfo.nBuffer) +
        (MakeInfo.nSerialNumber - StringCrc(MakeRegInfo.sSerialNumber)) +
        (MakeInfo.nSerialNumber - StringCrc(sSerialNumber));

      ScriptConfig.sSerialNumber := sSerialNumber;
      MemoryStream.Clear;
      g_MemoryStream.SaveToStream(MemoryStream);

      New(nDllCRC);
      New(nDllSize);

      nDllSize^ := MemoryStream.Size;
      GetMem(Buffer, nDllSize^);
      try
        MemoryStream.Seek(0, soFromBeginning);
        MemoryStream.Read(Buffer^, nDllSize^);
        nDllCRC^ := BufferCRC(Buffer, nDllSize^);
      finally
        FreeMem(Buffer);
      end;

      ScriptConfig.nSize := nDllSize^;
      ScriptConfig.nCrc := nDllCRC^;
      ScriptConfig.sPlugName := sTempPlugName;
      ScriptConfig.sLoadPlugSucced := sTempStartLoadPlugSucced;
      ScriptConfig.sLoadPlugFail := sTempStartLoadPlugFail;
      ScriptConfig.sUnLoadPlug := sTempUnLoadPlug;
      ScriptConfig.sLabelMsg := sTempMsg;
      ScriptConfig.sPassWord := sSrcPassWord;

      ScriptConfig.boShareMode := CheckBoxShareMode.Checked;
      ScriptConfig.nBeginDate := Date;
      ScriptConfig.nEndDate := Date + EditShareDay.Value;

      sOption := EncryptBuffer(@ScriptConfig^, SizeOf(TScriptConfig));
      MemoryStream.Seek(0, soFromEnd);
      MemoryStream.Write(nDllSize^, SizeOf(Integer));
      MemoryStream.Write(sOption[1], Length(sOption));
      MemoryStream.SaveToFile('.\ScriptLoader.dll');

      Dispose(nDllSize);
      Dispose(nDllCRC);

      Dispose(ScriptConfig);

      Dispose(OptionSize);
      Dispose(Count);
      Dispose(nCRC);
      Dispose(MakeInfo);
      Dispose(MakeRegInfo);
      MemoryStream.Free;
      Application.MessageBox('创建成功 ！！！', '提示信息', MB_ICONQUESTION);
      ButtonCreatePlug.Enabled := True;
      Exit;
    end;
  except

  end;
  Dispose(OptionSize);
  Dispose(Count);
  Dispose(nCRC);
  Dispose(MakeInfo);
  Dispose(MakeRegInfo);
  MemoryStream.Free;
  Application.Terminate;
end;

procedure TFrmMain.ButtonDelClick(Sender: TObject);
var
  sSerialNumber: string;
begin
  if not g_StartOK^ then Exit;
  sSerialNumber := Trim(ComboBoxSerialNumber.Text);
  Delete(sSerialNumber);
end;

procedure TFrmMain.ButtonExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.ButtonOKClick(Sender: TObject);
var
  dwWaitTick: Longword;
  OptionSize: PInteger;
  Count: PInteger;
  MemoryStream: TMemoryStream;
  MakeRegInfo: pTMakeRegInfo;
  MakeInfo: pTMakeInfo;
  Buffer: PChar;
  sOption: string;
  sBuffer: string;
  nCRC: PCardinal;
  boVersion: PBoolean;
  sSerialNumber: string;
  sInPutSerialNumber: string;

  nMode: Integer;
  nDays: Integer;
  nVersion: Word;
  ScriptOption: pTScriptOption;
begin
  if not g_StartOK^ then Exit;
  nMode := RadioGroupUserMode.ItemIndex + 1;
  nDays := EditDays.Value;
  nVersion := EditVersion1.Value;
  sInPutSerialNumber := Trim(ComboBoxSerialNumber.Text);
  if Length(sInPutSerialNumber) <> StrToInt(DecryptString(s32)) then begin
    Application.MessageBox('请输入正确的机器码！！！', '提示信息', MB_ICONQUESTION);
    ComboBoxSerialNumber.SetFocus;
    Exit;
  end;

  if nMode = StrToInt(DecryptString(s03)) then begin
    nDays := High(Word);
  end;

  if (nDays <= StrToInt(DecryptString(s00))) then begin
    Application.MessageBox('请输入注册天数！！！', '提示信息', MB_ICONQUESTION);
    EditDays.SetFocus;
    Exit;
  end;

  ButtonOK.Enabled := False;

  dwWaitTick := GetTickCount;
  while True do begin
    Application.ProcessMessages;
    if GetTickCount - dwWaitTick > 500 then break;
  end;

  New(OptionSize);
  New(Count);
  New(nCRC);
  New(MakeInfo);
  New(MakeRegInfo);
  MemoryStream := TMemoryStream.Create;
  try
    OptionSize^ := Length(EncryptBuffer(@MakeRegInfo^, SizeOf(TMakeRegInfo)));
    MemoryStream.LoadFromFile(Application.ExeName);

    MemoryStream.Seek(-(SizeOf(Integer) + OptionSize^), soFromEnd);
    MemoryStream.Read(Count^, SizeOf(Integer));

    GetMem(Buffer, OptionSize^);
    try
      MemoryStream.Read(Buffer^, OptionSize^);
      SetLength(sOption, OptionSize^);
      Move(Buffer^, sOption[1], OptionSize^);
    finally
      FreeMem(Buffer);
    end;

    GetMem(Buffer, Count^);
    try
      MemoryStream.Seek(0, soFromBeginning);
      MemoryStream.Read(Buffer^, Count^);
      nCRC^ := BufferCRC(Buffer, Count^);
    finally
      FreeMem(Buffer);
    end;

    DecryptBuffer(sOption, @MakeRegInfo^, SizeOf(TMakeRegInfo));
    DecryptBuffer(MakeRegInfo.sBuffer, @MakeInfo^, SizeOf(TMakeInfo));
    sSerialNumber := GetSerialNumber(MakeInfo.nUserNumber, MakeInfo.nVersion);
    if (Count^ = MakeInfo.nSize) and
      (nCRC^ = MakeInfo.nCrc) and
      (StringCrc(MakeRegInfo.sBuffer) = MakeRegInfo.nBuffer) and
      (MakeInfo.nSerialNumber = StringCrc(MakeRegInfo.sSerialNumber)) and
      (MakeInfo.nSerialNumber = StringCrc(sSerialNumber))
      then begin
      New(ScriptOption);

      ScriptOption.OwnerNumber := MakeInfo.nOwnerNumber +
        (LoWord(MakeInfo.nVersion) - SOFTWARE_SCRIPT_MAKEKEY) +
        (Count^ - MakeInfo.nSize) +
        (nCRC^ - MakeInfo.nCrc) +
        (StringCrc(MakeRegInfo.sBuffer) - MakeRegInfo.nBuffer) +
        (MakeInfo.nSerialNumber - StringCrc(MakeRegInfo.sSerialNumber)) +
        (MakeInfo.nSerialNumber - StringCrc(sSerialNumber));

      ScriptOption.UserNumber := MakeInfo.nUserNumber +
        (LoWord(MakeInfo.nVersion) - SOFTWARE_SCRIPT_MAKEKEY) +
        (Count^ - MakeInfo.nSize) +
        (nCRC^ - MakeInfo.nCrc) +
        (StringCrc(MakeRegInfo.sBuffer) - MakeRegInfo.nBuffer) +
        (MakeInfo.nSerialNumber - StringCrc(MakeRegInfo.sSerialNumber)) +
        (MakeInfo.nSerialNumber - StringCrc(sSerialNumber));

      ScriptOption.SerialNumber := StringCrc(sInPutSerialNumber) +
        (LoWord(MakeInfo.nVersion) - SOFTWARE_SCRIPT_MAKEKEY) +
        (Count^ - MakeInfo.nSize) +
        (nCRC^ - MakeInfo.nCrc) +
        (StringCrc(MakeRegInfo.sBuffer) - MakeRegInfo.nBuffer) +
        (MakeInfo.nSerialNumber - StringCrc(MakeRegInfo.sSerialNumber)) +
        (MakeInfo.nSerialNumber - StringCrc(sSerialNumber));

      ScriptOption.MakeKey := MakeInfo.nSerialNumber +
        (LoWord(MakeInfo.nVersion) - SOFTWARE_SCRIPT_MAKEKEY) +
        (Count^ - MakeInfo.nSize) +
        (nCRC^ - MakeInfo.nCrc) +
        (StringCrc(MakeRegInfo.sBuffer) - MakeRegInfo.nBuffer) +
        (MakeInfo.nSerialNumber - StringCrc(MakeRegInfo.sSerialNumber)) +
        (MakeInfo.nSerialNumber - StringCrc(sSerialNumber));

      ScriptOption.Mode := nMode;
      ScriptOption.BeginDate := Date;
      ScriptOption.EndDate := Date + nDays;

      ScriptOption.Version := MakeLong(SOFTWARE_SCRIPT, nVersion) +
        (LoWord(MakeInfo.nVersion) - SOFTWARE_SCRIPT_MAKEKEY) +
        (Count^ - MakeInfo.nSize) +
        (nCRC^ - MakeInfo.nCrc) +
        (StringCrc(MakeRegInfo.sBuffer) - MakeRegInfo.nBuffer) +
        (MakeInfo.nSerialNumber - StringCrc(MakeRegInfo.sSerialNumber)) +
        (MakeInfo.nSerialNumber - StringCrc(sSerialNumber));

      ScriptOption.LicDay := nDays;
      ScriptOption.SerialBuffer := sInPutSerialNumber;
      MemoKey.Lines.Text := EncryptBuffer(@ScriptOption^, SizeOf(TScriptOption));

      Dispose(ScriptOption);

      Dispose(OptionSize);
      Dispose(Count);
      Dispose(nCRC);
      Dispose(MakeInfo);
      Dispose(MakeRegInfo);
      MemoryStream.Free;

      ButtonOK.Enabled := True;
      Exit;
    end;
  except

  end;
  Dispose(OptionSize);
  Dispose(Count);
  Dispose(nCRC);
  Dispose(MakeInfo);
  Dispose(MakeRegInfo);
  MemoryStream.Free;
  Application.Terminate;
end;

procedure TFrmMain.ButtonSaveClick(Sender: TObject);
var
  I, nVersion: Integer;
  sSerialNumber, sKey: string;
begin
  if not g_StartOK^ then Exit;
  nVersion := EditVersion.Value;
  sSerialNumber := Trim(ComboBoxSerialNumber.Text);
  sKey := '';
  for I := 0 to MemoKey.Lines.Count - 1 do
    sKey := sKey + Trim(MemoKey.Lines.Strings[I]);
  //sKey := Trim(MemoKey.Lines.Text);
  if Length(sSerialNumber) <> 32 then begin
    Application.MessageBox('请输入正确的机器码！！！', '提示信息', MB_ICONQUESTION);
    ComboBoxSerialNumber.SetFocus;
    Exit;
  end;
  //Showmessage(IntToStr(Length(sKey)));
  if sKey = '' then begin
    Application.MessageBox('请输入正确的注册码！！！', '提示信息', MB_ICONQUESTION);
    MemoKey.SetFocus;
    Exit;
  end;
  Add(nVersion, sSerialNumber, sKey);
end;

procedure TfrmMain.ButtonSavePlugClick(Sender: TObject);
var
  I: Integer;
  ScriptConfig: TScriptConfig;
begin
  ScriptConfig.sPlugName := Trim(EditName.Text);
  ScriptConfig.sLoadPlugSucced := Trim(EditLoadPlugSucced.Text);
  ScriptConfig.sLoadPlugFail := Trim(EditLoadPlugFail.Text);
  ScriptConfig.sUnLoadPlug := Trim(EditUnLoadPlug.Text);

  ScriptConfig.sLabelMsg := '';
  for I := 0 to MemoMsg.Lines.Count - 1 do begin
    ScriptConfig.sLabelMsg := ScriptConfig.sLabelMsg + Trim(MemoMsg.Lines.Strings[I]) + '|';
    if I >= 4 then break;
  end;

  if Length(ScriptConfig.sLabelMsg) > 0 then begin
    if ScriptConfig.sLabelMsg[Length(ScriptConfig.sLabelMsg)] = '|' then begin
      ScriptConfig.sLabelMsg := Copy(ScriptConfig.sLabelMsg, 1, Length(ScriptConfig.sLabelMsg));
    end;
  end;

  //ScriptConfig.sLabelMsg := Trim(MemoMsg.Text);
  ScriptConfig.sPassWord := Trim(EditPassWord.Text);
  SaveConfig(EditVersion.Value, @ScriptConfig);
  Application.MessageBox('保存成功！！！', '提示信息', MB_ICONQUESTION);
end;

procedure TFrmMain.ComboBoxSerialNumberChange(Sender: TObject);
var
  sSerialNumber: string;
  UserInfo: pTUserInfo;
  ScriptOption: pTScriptOption;
  ScriptConfig: TScriptConfig;
begin
  if not g_StartOK^ then Exit;
  sSerialNumber := Trim(ComboBoxSerialNumber.Text);
  UserInfo := Find(sSerialNumber);
  if UserInfo <> nil then begin
    New(ScriptOption);
    DecryptBuffer(UserInfo.Key, @ScriptOption^, SizeOf(TScriptOption));
    if (ScriptOption.SerialNumber = StringCrc(sSerialNumber)) and
      (ScriptOption.SerialNumber = StringCrc(ScriptOption.SerialBuffer)) and (ScriptOption.Mode > 0) then begin
      RadioGroupUserMode.ItemIndex := ScriptOption.Mode - 1;
      EditDays.Value := GetDayCount(ScriptOption.EndDate, ScriptOption.BeginDate);
      EditVersion.Value := HIWord(ScriptOption.Version);
      EditVersion1.Value := HIWord(ScriptOption.Version);
      MemoKey.Lines.Text := UserInfo.Key;
      LoadConfig(HIWord(ScriptOption.Version), @ScriptConfig);
      EditName.Text := ScriptConfig.sPlugName;
      EditLoadPlugSucced.Text := ScriptConfig.sLoadPlugSucced;
      EditLoadPlugFail.Text := ScriptConfig.sLoadPlugFail;
      EditUnLoadPlug.Text := ScriptConfig.sUnLoadPlug;
      EditPassWord.Text := ScriptConfig.sPassWord;
      AddToMemo(ScriptConfig.sLabelMsg);
      //MemoMsg.Text := ScriptConfig.sLabelMsg;
      LabelDate.Caption := '注册日期: ' + GetDate(ScriptOption.BeginDate) + '至' + GetDate(ScriptOption.EndDate);
    end;
    Dispose(ScriptOption);
  end;
end;

procedure TFrmMain.Add(nVersion: Integer; SerialNumber, Key: string);
var
  I, ItemIndex: Integer;
  UserInfo: pTUserInfo;
begin
  ItemIndex := ComboBoxSerialNumber.ItemIndex;
  if g_UserList <> nil then begin
    for I := 0 to g_UserList.Count - 1 do begin
      if CompareText(SerialNumber, g_UserList.Strings[I]) = 0 then begin
        Application.MessageBox('该机器码已经存在！！！', '提示信息', MB_ICONQUESTION);
        Exit;
      end;
    end;
    New(UserInfo);
    UserInfo.SerialNumber := SerialNumber;
    UserInfo.Key := Key;

    g_UserList.AddObject(SerialNumber, TObject(UserInfo));
    ComboBoxSerialNumber.Items.AddObject(SerialNumber, TObject(UserInfo));

    SaveToFile;
    Application.MessageBox('保存成功！！！', '提示信息', MB_ICONQUESTION);
    {ComboBoxSerialNumber.Clear;
    ComboBoxSerialNumber.Items.AddStrings(g_UserList);
    if (ItemIndex >= 0) and (ItemIndex < ComboBoxSerialNumber.Items.Count) then begin
      ComboBoxSerialNumber.ItemIndex := ItemIndex;
    end; }
  end;
end;

procedure TFrmMain.Delete(SerialNumber: string);
var
  I, II: Integer;
begin
  if g_UserList <> nil then begin
    for I := 0 to g_UserList.Count - 1 do begin
      if CompareText(SerialNumber, g_UserList.Strings[I]) = 0 then begin
        for II := 0 to ComboBoxSerialNumber.Items.Count - 1 do begin
          if ComboBoxSerialNumber.Items.Objects[II] = g_UserList.Objects[I] then begin
            ComboBoxSerialNumber.Items.Delete(II);
            break;
          end;
        end;
        Dispose(pTUserInfo(g_UserList.Objects[I]));
        g_UserList.Delete(I);
        SaveToFile;
        Application.MessageBox('删除完成！！！', '提示信息', MB_ICONQUESTION);
        break;
      end;
    end;
  end;
end;

procedure TFrmMain.EditDaysChange(Sender: TObject);
begin
  {case RadioGroupUserMode.ItemIndex of
    //0: LabelDate.Caption := '注册日期: ' + GetDate(Date) + '至' + GetDate(Date + EditDays.Value);
    1: LabelDate.Caption := '注册日期: 无限期';
  else LabelDate.Caption := '注册日期: ' + GetDate(Date) + '至' + GetDate(Date + EditDays.Value);
  end;}

  case RadioGroupUserMode.ItemIndex of
    0: begin
        LabelDate.Caption := '注册日期: ' + GetDate(Date) + '至' + GetDate(Date + EditDays.Value);
        //RadioGroupLicDay.Enabled := True;
      end;
    1: begin
        LabelDate.Caption := '注册日期: 无限期';
        //RadioGroupLicDay.Enabled := False;
      end;
    2: begin
        LabelDate.Caption := '试用日期: ' + GetDate(Date) + '至' + GetDate(Date + EditDays.Value);
        //RadioGroupLicDay.Enabled := True;
      end;
  end;
end;

procedure TFrmMain.AddToMemo(sMsg: string);
var
  I: Integer;
  nPos: Integer;
  sAdd: string;
  sText: string;
begin
  sText := Trim(sMsg);
  MemoMsg.Lines.Clear;
  while Pos('|', sText) > 0 do begin
    nPos := Pos('|', sText);
    sAdd := Copy(sText, 1, nPos - 1);
    sText := Copy(sText, nPos + 1, Length(sText));
    MemoMsg.Lines.Add(sAdd);
  end;
end;

procedure TfrmMain.EditVersionChange(Sender: TObject);
var
  UserInfo: pTUserInfo;
  ScriptOption: pTScriptOption;
  ScriptConfig: TScriptConfig;
begin
  if not g_StartOK^ then Exit;
  UserInfo := Find(TSpinEdit(Sender).Value);
  if UserInfo <> nil then begin
    New(ScriptOption);
    DecryptBuffer(UserInfo.Key, @ScriptOption^, SizeOf(TScriptOption));
    if (ScriptOption.SerialNumber = StringCrc(ScriptOption.SerialBuffer)) and (ScriptOption.Mode > 0) then begin
      RadioGroupUserMode.ItemIndex := ScriptOption.Mode - 1;
      EditDays.Value := GetDayCount(ScriptOption.EndDate, ScriptOption.BeginDate);
      EditVersion.Value := HIWord(ScriptOption.Version);
      EditVersion1.Value := HIWord(ScriptOption.Version);
      MemoKey.Lines.Text := UserInfo.Key;
      LabelDate.Caption := '注册日期: ' + GetDate(ScriptOption.BeginDate) + '至' + GetDate(ScriptOption.EndDate);
    end;
    Dispose(ScriptOption);
  end else begin
    if Sender = EditVersion then EditVersion1.Value := EditVersion.Value;
    if Sender = EditVersion1 then EditVersion.Value := EditVersion1.Value;
  end;
  LoadConfig(EditVersion.Value, @ScriptConfig);
  EditName.Text := ScriptConfig.sPlugName;
  EditLoadPlugSucced.Text := ScriptConfig.sLoadPlugSucced;
  EditLoadPlugFail.Text := ScriptConfig.sLoadPlugFail;
  EditUnLoadPlug.Text := ScriptConfig.sUnLoadPlug;
  EditPassWord.Text := ScriptConfig.sPassWord;
  AddToMemo(ScriptConfig.sLabelMsg);
end;

function TFrmMain.Find(nVersion: Integer): pTUserInfo;
var
  I: Integer;
begin
  Result := nil;
  if g_UserList <> nil then begin
    for I := 0 to g_UserList.Count - 1 do begin
      if pTUserInfo(g_UserList.Objects[I]).Version = nVersion then begin
        Result := pTUserInfo(g_UserList.Objects[I]);
        break;
      end;
    end;
  end;
end;

function TFrmMain.Find(SerialNumber: string): pTUserInfo;
var
  I: Integer;
begin
  Result := nil;
  if g_UserList <> nil then begin
    for I := 0 to g_UserList.Count - 1 do begin
      if CompareText(SerialNumber, g_UserList.Strings[I]) = 0 then begin
        Result := pTUserInfo(g_UserList.Objects[I]);
        break;
      end;
    end;
  end;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Dispose(g_StartOK);
  g_MemoryStream.Free;
  UnLoadList;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  I: Integer;
  OptionSize: PInteger;
  Count: PInteger;
  MemoryStream: TMemoryStream;
  MakeRegInfo: pTMakeRegInfo;
  MakeInfo: pTMakeInfo;
  Buffer: Pointer;
  sOption: string;
  nCRC: PCardinal;
  boVersion: PBoolean;
  sSerialNumber: string;
  List: TStringList;

  ResourceStream: TResourceStream;
begin
  Application.ShowMainForm := False;
  New(OptionSize);
  New(Count);
  New(nCRC);
  New(MakeInfo);
  New(MakeRegInfo);
  MemoryStream := TMemoryStream.Create;
  try
    OptionSize^ := Length(EncryptBuffer(@MakeRegInfo^, SizeOf(TMakeRegInfo)));
    MemoryStream.LoadFromFile(Application.ExeName);

    MemoryStream.Seek(-(SizeOf(Integer) + OptionSize^), soFromEnd);
    MemoryStream.Read(Count^, SizeOf(Integer));

    GetMem(Buffer, OptionSize^);
    try
      MemoryStream.Seek(-OptionSize^, soFromEnd);
      MemoryStream.Read(Buffer^, OptionSize^);
      SetLength(sOption, OptionSize^);
      Move(Buffer^, sOption[1], OptionSize^);
    finally
      FreeMem(Buffer);
    end;

    GetMem(Buffer, Count^);
    try
      MemoryStream.Seek(0, soFromBeginning);
      MemoryStream.Read(Buffer^, Count^);
      nCRC^ := BufferCRC(Buffer, Count^);
    finally
      FreeMem(Buffer);
    end;

    DecryptBuffer(sOption, @MakeRegInfo^, SizeOf(TMakeRegInfo));
    DecryptBuffer(MakeRegInfo.sBuffer, @MakeInfo^, SizeOf(TMakeInfo));
    sSerialNumber := GetSerialNumber(MakeInfo.nUserNumber, MakeInfo.nVersion);

     { List:=TStringList.Create;
      List.Add('MakeInfo.nVersion:'+IntToStr(MakeInfo.nVersion));
      List.Add('MakeInfo.nOwnerNumber:'+IntToStr(MakeInfo.nOwnerNumber));
      List.Add('MakeInfo.nUserNumber:'+IntToStr(MakeInfo.nUserNumber));
      List.Add('MakeInfo.nSerialNumber:'+IntToStr(MakeInfo.nSerialNumber));
      List.SaveToFile('List.txt');}

    if (Count^ = MakeInfo.nSize) and
      (nCRC^ = MakeInfo.nCrc) and
      (StringCrc(MakeRegInfo.sBuffer) = MakeRegInfo.nBuffer) and
      (MakeInfo.nSerialNumber = StringCrc(MakeRegInfo.sSerialNumber)) and
      (MakeInfo.nSerialNumber = StringCrc(sSerialNumber)) and
      (LoWord(MakeInfo.nVersion) = SOFTWARE_SCRIPT_MAKEKEY)
      then begin
      Application.ShowMainForm := True;
      Dispose(MakeRegInfo);
      Dispose(MakeInfo);
      Dispose(OptionSize);
      Dispose(Count);
      Dispose(nCRC);

      New(g_StartOK);
      g_StartOK^ := True;
      MemoryStream.Free;

      EditName.Text := g_sPlugName; // '飞尔世界脚本扩展插件';
      EditLoadPlugSucced.Text := g_sStartLoadPlugSucced; // '加载飞尔世界脚本扩展插件成功...';
      EditLoadPlugFail.Text := g_sStartLoadPlugFail; // '加载飞尔世界脚本扩展插件失败...';
      EditUnLoadPlug.Text := g_sUnLoadPlug; // '卸载飞尔世界扩展扩展插件成功...';
      EditPassWord.Text := g_sPassWord; // '0123456789';

      MemoMsg.Lines.Clear;
      for I := 0 to Length(g_sMsg) - 1 do
        MemoMsg.Lines.Add(g_sMsg[I]);

      g_MemoryStream := TMemoryStream.Create;
      ResourceStream := TResourceStream.Create(HInstance, 'ScriptLoader', PChar('dll'));
      ResourceStream.SaveToStream(g_MemoryStream);
      ResourceStream.Free;

      Timer.OnTimer := TimerTimer;
      ButtonOK.OnClick := ButtonOKClick;
      ButtonCreatePlug.OnClick := ButtonCreatePlugClick;
      ComboBoxSerialNumber.OnChange := ComboBoxSerialNumberChange;
      EditVersion.OnChange := EditVersionChange;
      EditVersion1.OnChange := EditVersionChange;
      RadioGroupUserMode.ItemIndex := -1;
      RadioGroupLicDay.ItemIndex := -1;
      RadioGroupUserMode.ItemIndex := 0;
      RadioGroupLicDay.ItemIndex := 0;

      Timer.Enabled := True;
      Exit;
    end;
  except
    {Dispose(OptionSize);
    Dispose(Count);
    Dispose(nCRC);
    MemoryStream.Free;
    Application.Terminate;
    Exit;   }
  end;
  Dispose(MakeRegInfo);
  Dispose(MakeInfo);
  Dispose(OptionSize);
  Dispose(Count);
  Dispose(nCRC);
  MemoryStream.Free;
  Application.Terminate;
end;

procedure TFrmMain.RadioGroupLicDayClick(Sender: TObject);
var
  nDay: Integer;
begin
  case RadioGroupLicDay.ItemIndex of
    0: nDay := 30;
    1: nDay := 365 div 2;
    2: nDay := 365;
  end;
  EditDays.Value := GetDayCount(Date + nDay, Now);
end;

procedure TFrmMain.RadioGroupUserModeClick(Sender: TObject);
begin
  case RadioGroupUserMode.ItemIndex of
    0: begin
        LabelDate.Caption := '注册日期: ' + GetDate(Date) + '至' + GetDate(Date + EditDays.Value);
        RadioGroupLicDay.Enabled := True;
      end;
    1: begin
        LabelDate.Caption := '注册日期: 无限期';
        RadioGroupLicDay.Enabled := False;
      end;
    2: begin
        LabelDate.Caption := '试用日期: ' + GetDate(Date) + '至' + GetDate(Date + EditDays.Value);
        RadioGroupLicDay.Enabled := True;
      end;
  end;
end;

end.

