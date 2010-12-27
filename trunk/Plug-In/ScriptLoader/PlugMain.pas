unit PlugMain;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, EngineInterface, ExtCtrls, ShellApi, HUtil32, Share, SDK;

function InitPlug(): PChar;
procedure UnInitPlug();
function GetSerialNumber(nUserNumber, nVersion: Integer): string;
procedure TF00004;
procedure TF00005;
function DeCodeText(sText: string): string;
var
  g_PlugConfig: pTPlugConfig;
implementation
uses EncryptUnit, Common, MSI_CPU, MSI_Storage, MSI_Machine, MD5EncodeStr, Registry;
const
  R_MyRootKey = HKEY_CURRENT_USER; //注册表根键
  R_MySubKey = '\Software\MirScript\'; //注册表子键
  R_Key = 'Key';

  s00 = 'yBNnxNUXwzJE'; //0
  s01 = 'OvA2FqLK1ipA'; //1
  s02 = 'NdBKFYqYD6cf'; //2
var
  StartPlugOK: PBoolean;


function DeCodeText(sText: string): string;
begin
  try
    if sText <> '' then
      Result := DecryStrHex3(sText, DecryptString(g_PlugConfig.sPassWord))
    else Result := '';
  except
    Result := '';
  end;
end;

//______________________________________________________________________________

function ReadRegKey(const iMode: Integer; const sPath,
  sKeyName: string; var sResult: string): Boolean;
var
  rRegObject: TRegistry;
begin
  rRegObject := TRegistry.Create;
  Result := False;
  try
    with rRegObject do begin
      RootKey := R_MyRootKey;
      if OpenKey(sPath, True) then begin
        case iMode of
          1: sResult := Trim(ReadString(sKeyName));
          2: sResult := IntToStr(ReadInteger(sKeyName));
          //3: sResult := ReadBinaryData(sKeyName, Buffer, BufSize);
        end;
        if sResult = '' then Result := False else Result := True;
      end
      else
        Result := False;
      CloseKey;
    end;
  finally
    rRegObject.Free;
  end;
end;
//_____________________________________________________________________//

function WriteRegKey(const iMode: Integer; const sPath, sKeyName,
  sKeyValue: string): Boolean;
var
  rRegObject: TRegistry;
  bData: Byte;
begin
  rRegObject := TRegistry.Create;
  try
    with rRegObject do begin
      RootKey := R_MyRootKey;
      if OpenKey(sPath, True) then begin
        case iMode of
          1: WriteString(sKeyName, sKeyValue);
          2: WriteInteger(sKeyName, StrToInt(sKeyValue));
          3: WriteBinaryData(sKeyName, bData, 1);
        end;
        Result := True;
      end
      else
        Result := False;
      CloseKey;
    end;
  finally
    rRegObject.Free;
  end;
end;
//_____________________________________________________________________//

function RegClear(): Boolean;
var
  RegObject: TRegistry;
begin
  RegObject := TRegistry.Create;
  try
    RegObject.RootKey := R_MyRootKey;
    if RegObject.OpenKey(R_MySubKey, False) then begin
      if RegObject.DeleteKey(R_MySubKey) then Result := True else Result := False;
    end else Result := True;
  finally
    RegObject.Free;
  end;
end;

//_____________________________________________________________________//
type
  TObject00001 = class(TComponent)
  private
    Edits: array[0..1] of TEdit;
    procedure TObject00002(Sender: TObject);
    procedure TObject00003(Sender: TObject);
  end;

procedure TObject00001.TObject00002(Sender: TObject);
var
  sText1, sText2: string;

  Count: Integer;
  MemoryStream: TMemoryStream;
  ScriptConfig: TScriptConfig;
  Buffer: Pointer;
  sOption: string;
  nCRC: Cardinal;

  sSerialNumber: string;
  sKey: string;
  ScriptOption: TScriptOption;
begin
  sText1 := Trim(Edits[0].Text);
  sText2 := Trim(Edits[1].Text);

  if (Length(sText1) = 32) and (sText2 <> '') {and (Length(sText2) = StrToInt(DecryptString(s153)))} then begin
    sSerialNumber := '';
    sKey := '';


    MemoryStream := TMemoryStream.Create;
    try
      MemoryStream.LoadFromFile(GetModuleName(HInstance));

      MemoryStream.Seek(-(SizeOf(Integer) + ScriptConfigSize), soFromEnd);
      MemoryStream.Read(Count, SizeOf(Integer));

      GetMem(Buffer, ScriptConfigSize);
      try
        MemoryStream.Read(Buffer^, ScriptConfigSize);
        SetLength(sOption, ScriptConfigSize);
        Move(Buffer^, sOption[1], ScriptConfigSize);
      finally
        FreeMem(Buffer);
      end;

      GetMem(Buffer, Count);
      try
        MemoryStream.Seek(0, soFromBeginning);
        MemoryStream.Read(Buffer^, Count);
        nCRC := BufferCRC(Buffer, Count);
      finally
        FreeMem(Buffer);
      end;

      DecryptBuffer(sOption, @ScriptConfig, SizeOf(TScriptConfig));

      if (Count = ScriptConfig.nSize) and (nCRC = ScriptConfig.nCrc) and (LoWord(ScriptConfig.nVersion) = SOFTWARE_SCRIPT) then begin
        sSerialNumber := GetSerialNumber(ScriptConfig.nUserNumber, ScriptConfig.nVersion);
        FillChar(ScriptOption, SizeOf(TScriptOption), #0);
        DecryptBuffer(sText2, @ScriptOption, SizeOf(TScriptOption));
         { MainOutMessage('EngineOption.OwnerNumber:' + IntToStr(EngineOption.OwnerNumber), 0);
          MainOutMessage('EngineOption.UserNumber:' + IntToStr(EngineOption.UserNumber), 0);
          MainOutMessage('EngineOption.Version:' + IntToStr(EngineOption.Version), 0);
          MainOutMessage('EngineOption.SerialNumber:' + IntToStr(EngineOption.SerialNumber), 0);
          MainOutMessage('EngineOption.Mode:' + IntToStr(EngineOption.Mode), 0);

          MainOutMessage('ConfigOption.nOwnerNumber:' + IntToStr(ConfigOption.nOwnerNumber), 0);
          MainOutMessage('ConfigOption.nUserNumber:' + IntToStr(ConfigOption.nUserNumber), 0);
          MainOutMessage('StringCrc(sSerialNumber):' + IntToStr(StringCrc(sSerialNumber)), 0);
          MainOutMessage('StringCrc(sText1):' + IntToStr(StringCrc(sText1)), 0); }
        if (ScriptOption.OwnerNumber = ScriptConfig.nOwnerNumber) and
          (ScriptOption.UserNumber = ScriptConfig.nUserNumber) and
          (ScriptOption.Version = ScriptConfig.nVersion) and
          (LoWord(ScriptOption.Version) = SOFTWARE_SCRIPT) and
          ((StringCrc(sSerialNumber) = ScriptOption.SerialNumber)) and
          ((StringCrc(sText1) = ScriptOption.SerialNumber)) and
          (ScriptOption.EndDate > ScriptOption.BeginDate) and
          (((ScriptOption.Mode <> StrToInt(DecryptString(s02))) and (ScriptOption.EndDate > Date)) or (ScriptOption.Mode = StrToInt(DecryptString(s02)))) then begin
          if WriteRegKey(1, R_MySubKey + sSerialNumber + '\', R_Key, sText2) then begin
            if ReadRegKey(1, R_MySubKey + sSerialNumber + '\', R_Key, sKey) then begin
              DecryptBuffer(sKey, @ScriptOption, SizeOf(TScriptOption));
              if (ScriptOption.OwnerNumber = ScriptConfig.nOwnerNumber) and
                (ScriptOption.UserNumber = ScriptConfig.nUserNumber) and
                (ScriptOption.Version = ScriptConfig.nVersion) and
                (LoWord(ScriptOption.Version) = SOFTWARE_SCRIPT) and
                ((StringCrc(sSerialNumber) = ScriptOption.SerialNumber)) and
                (ScriptOption.EndDate > ScriptOption.BeginDate) and
                (((ScriptOption.Mode <> StrToInt(DecryptString(s02))) and (ScriptOption.EndDate > Date)) or (ScriptOption.Mode = StrToInt(DecryptString(s02)))) then begin
                if (ScriptOption.Mode = StrToInt(DecryptString(s02))) then begin
                  ScriptOption.LicDay := GetDayCount(ScriptOption.EndDate, ScriptOption.BeginDate);
                end else begin
                  ScriptOption.LicDay := GetDayCount(ScriptOption.EndDate, Date);
                end;
                Move(ScriptConfig, g_PlugConfig^, SizeOf(TPlugConfig));
                StartPlugOK^ := True;
              end;
            end;
          end;
        end;
      end;
    except
        //MainOutMessage('TObject00001.TObject00002:Fail', 0);
    end;
    MemoryStream.Free;
  end;
  TForm(Owner).Close;
end;

procedure TObject00001.TObject00003(Sender: TObject);
begin
  TForm(Owner).Close;
end;
//_____________________________________________________________________//

procedure TF00003(ScriptConfig: pTScriptConfig; boShare: Boolean);
var
  I: Integer;
  Object00001: TObject00001;
  FrmMain: TForm;
  ButtonOK: TButton;
  ButtonClose: TButton;
  GroupBox: TGroupBox;
  Labels: array[0..2] of TLabel;
  Edits: array[0..1] of TEdit;
begin
  FrmMain := TForm.Create(nil);
  FrmMain.BorderStyle := bsDialog;
  FrmMain.Position := poOwnerFormCenter;
  if boShare then begin
    FrmMain.Caption := '用户注册 [试用天数：' + IntToStr(GetDayCount(ScriptConfig.nEndDate, Date)) + ']';
  end else begin
    FrmMain.Caption := '用户注册';
  end;
  FrmMain.Width := 345;
  FrmMain.Height := 243;
  FrmMain.Font.Name := '宋体';
  FrmMain.Font.Charset := GB2312_CHARSET;
  FrmMain.Font.Size := 9;

  GroupBox := TGroupBox.Create(FrmMain);
  GroupBox.Parent := FrmMain;
  GroupBox.Left := 8;
  GroupBox.Top := 8;
  GroupBox.Width := 321;
  GroupBox.Height := 193;
  //GroupBox.Color := clWhite;
  GroupBox.Caption := '注册信息';
  Object00001 := TObject00001.Create(FrmMain);

  ButtonOK := TButton.Create(FrmMain);
  ButtonOK.Parent := GroupBox;
  ButtonOK.Left := 232;
  ButtonOK.Top := 160;
  ButtonOK.Caption := '确定(&R)';
  ButtonOK.OnClick := Object00001.TObject00002;

  ButtonClose := TButton.Create(FrmMain);
  ButtonClose.Parent := GroupBox;
  ButtonClose.Left := 8;
  ButtonClose.Top := 160;
  if boShare then begin
    ButtonClose.Caption := '试用(&E)';
  end else begin
    ButtonClose.Caption := '取消(&E)';
  end;
  ButtonClose.OnClick := Object00001.TObject00003;

  for I := 0 to Length(Labels) - 1 do begin
    Labels[I] := TLabel.Create(FrmMain);
    Labels[I].Parent := GroupBox;
  end;

  Labels[0].Left := 10;
  Labels[0].Top := 17;

  Labels[1].Left := 12;
  Labels[1].Top := 105;

  Labels[2].Left := 12;
  Labels[2].Top := 131;

  Labels[0].Caption := ScriptConfig.sLabelMsg;
  Labels[1].Caption := '机器码: ';
  Labels[2].Caption := '注册码: ';

  for I := 0 to Length(Edits) - 1 do begin
    Edits[I] := TEdit.Create(FrmMain);
    Edits[I].Parent := GroupBox;
    Edits[I].Left := 66;
    Edits[I].Text := '';
    Edits[I].Width := 223;
    Edits[I].AutoSelect := False;
  end;

  Edits[0].Top := 102;
  Edits[0].ReadOnly := True;
  Edits[0].Tag := 0;
  Edits[0].Text := GetSerialNumber(ScriptConfig.nUserNumber, ScriptConfig.nVersion);

  Edits[1].Top := 128;
  Edits[1].Tag := 1;
  Edits[1].Visible := True;

  Object00001.Edits[0] := Edits[0];
  Object00001.Edits[1] := Edits[1];
  FrmMain.ShowModal;

  for I := 0 to Length(Labels) - 1 do begin
    Labels[I].Free;
  end;
  for I := 0 to Length(Edits) - 1 do begin
    Edits[I].Free;
  end;
  GroupBox.Free;

  Object00001.Free;
  FrmMain.Free;
end;

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


procedure TF00004;
var
  Count: Integer;
  MemoryStream: TMemoryStream;
  ScriptConfig: TScriptConfig;
  Buffer: Pointer;
  sOption: string;
  nCRC: Cardinal;
  boVersion: Boolean;

  sSerialNumber: string;
  sKey: string;
  ScriptOption: TScriptOption;
begin
  StartPlugOK^ := False;

  sSerialNumber := '';
  sKey := '';

  MemoryStream := TMemoryStream.Create;
  try

    MemoryStream.LoadFromFile(GetModuleName(HInstance));

    MemoryStream.Seek(-(SizeOf(Integer) + ScriptConfigSize), soFromEnd);
    MemoryStream.Read(Count, SizeOf(Integer));

    GetMem(Buffer, ScriptConfigSize);
    try
      MemoryStream.Read(Buffer^, ScriptConfigSize);
      SetLength(sOption, ScriptConfigSize);
      Move(Buffer^, sOption[1], ScriptConfigSize);
    finally
      FreeMem(Buffer);
    end;

    GetMem(Buffer, Count);
    try
      MemoryStream.Seek(0, soFromBeginning);
      MemoryStream.Read(Buffer^, Count);
      nCRC := BufferCRC(Buffer, Count);
    finally
      FreeMem(Buffer);
    end;

    DecryptBuffer(sOption, @ScriptConfig, SizeOf(TScriptConfig));
    {
    MainOutMessage('nCRC^:' + IntToStr(nCRC^), 0);
    MainOutMessage('ScriptConfig.nCrc:' + IntToStr(ScriptConfig.nCrc), 0);
    MainOutMessage('LoWord(ScriptConfig.nVersion):' + IntToStr(LoWord(ScriptConfig.nVersion)), 0);
    }
    if (Count = ScriptConfig.nSize) and (nCRC = ScriptConfig.nCrc) and (LoWord(ScriptConfig.nVersion) = SOFTWARE_SCRIPT) then begin
      Move(ScriptConfig, g_PlugConfig^, SizeOf(TPlugConfig) - 100);
      sSerialNumber := GetSerialNumber(ScriptConfig.nUserNumber, ScriptConfig.nVersion);
      //MainOutMessage('sSerialNumberTF400:' + sSerialNumber, 0);
      FillChar(ScriptOption, SizeOf(TScriptOption), #0);
      if ReadRegKey(1, R_MySubKey + sSerialNumber + '\', R_Key, sKey) then begin
        DecryptBuffer(sKey, @ScriptOption, SizeOf(TScriptOption));
        if (not (ScriptOption.Mode in [StrToInt(DecryptString(s00))..StrToInt(DecryptString(s02))])) or
        (StringCrc(sSerialNumber) <> ScriptOption.SerialNumber) or
          (ScriptOption.OwnerNumber <> ScriptConfig.nOwnerNumber) or
          (ScriptOption.UserNumber <> ScriptConfig.nUserNumber) or
          ((ScriptOption.Mode <> StrToInt(DecryptString(s02))) and (ScriptOption.EndDate < Date)) or
          (ScriptOption.BeginDate > ScriptOption.EndDate) or
          (LoWord(ScriptOption.Version) <> SOFTWARE_SCRIPT) or
          (ScriptOption.Version <> ScriptConfig.nVersion) then begin
          //MainOutMessage('OPEN1', 0);
          if ScriptConfig.boShareMode and (Date >= ScriptConfig.nBeginDate) and (Date <= ScriptConfig.nEndDate) then begin
            TF00003(@ScriptConfig, True);
            if not StartPlugOK^ then begin
              Move(ScriptConfig, g_PlugConfig^, SizeOf(TPlugConfig));
              StartPlugOK^ := True;
            end;
          end else begin
            TF00003(@ScriptConfig, False);
          end
        end else begin
          g_PlugConfig.sPassWord := ScriptConfig.sPassWord;
          StartPlugOK^ := True;
        end;
      end else begin
        //MainOutMessage('OPEN2', 0);
        if ScriptConfig.boShareMode and (Date >= ScriptConfig.nBeginDate) and (Date <= ScriptConfig.nEndDate) then begin
          TF00003(@ScriptConfig, True);
          if not StartPlugOK^ then begin
            Move(ScriptConfig, g_PlugConfig^, SizeOf(TPlugConfig));
            StartPlugOK^ := True;
          end;
        end else begin
          TF00003(@ScriptConfig, False);
        end
      end;
    end;
  except
    //MainOutMessage('Init Error', 0);
  end;
  MemoryStream.Free;
end;

procedure TF00005;
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
var
  Count: Integer;
  MemoryStream: TMemoryStream;
  ScriptConfig: TScriptConfig;
  Buffer: Pointer;
  sOption: string;
  nCRC: Cardinal;
  boVersion: Boolean;

  sSerialNumber: string;
  sKey: string;
  ScriptOption: TScriptOption;

  Img: TImage;
  FrmMain: TForm;
  ButtonOK: TButton;
  ButtonClose: TButton;
  GroupBox: TGroupBox;
  //Labels: array[0..2] of TLabel;
  Labels: TLabel;
  Object00001: TObject00001;
begin
  sSerialNumber := '';
  sKey := '';

  MemoryStream := TMemoryStream.Create;
  try

    MemoryStream.LoadFromFile(GetModuleName(HInstance));

    MemoryStream.Seek(-(SizeOf(Integer) + ScriptConfigSize), soFromEnd);
    MemoryStream.Read(Count, SizeOf(Integer));

    GetMem(Buffer, ScriptConfigSize);
    try
      MemoryStream.Read(Buffer^, ScriptConfigSize);
      SetLength(sOption, ScriptConfigSize);
      Move(Buffer^, sOption[1], ScriptConfigSize);
    finally
      FreeMem(Buffer);
    end;

    GetMem(Buffer, Count);
    try
      MemoryStream.Seek(0, soFromBeginning);
      MemoryStream.Read(Buffer^, Count);
      nCRC := BufferCRC(Buffer, Count);
    finally
      FreeMem(Buffer);
    end;

    DecryptBuffer(sOption, @ScriptConfig, SizeOf(TScriptConfig));

    {MainOutMessage('nCRC:' + IntToStr(nCRC), 0);
    MainOutMessage('ScriptConfig.nCrc:' + IntToStr(ScriptConfig.nCrc), 0);
    MainOutMessage('LoWord(ScriptConfig.nVersion):' + IntToStr(LoWord(ScriptConfig.nVersion)), 0);}

    if (Count = ScriptConfig.nSize) and (nCRC = ScriptConfig.nCrc) and (LoWord(ScriptConfig.nVersion) = SOFTWARE_SCRIPT) then begin
      //Move(ScriptConfig, g_PlugConfig^, SizeOf(ScriptConfig.sPlugName) * 4 + 255);
      sSerialNumber := GetSerialNumber(ScriptConfig.nUserNumber, ScriptConfig.nVersion);
      //New(ScriptOption);
      FillChar(ScriptOption, SizeOf(TScriptOption), #0);
      //MainOutMessage('sSerialNumber0:' + sSerialNumber, 0);
      if ReadRegKey(1, R_MySubKey + sSerialNumber + '\', R_Key, sKey) then begin
        DecryptBuffer(sKey, @ScriptOption, SizeOf(TScriptOption));
        //MainOutMessage('sSerialNumber1:' + sSerialNumber, 0);
        if (ScriptOption.Mode in [StrToInt(DecryptString(s01))..StrToInt(DecryptString(s02))]) and
        (StringCrc(sSerialNumber) = ScriptOption.SerialNumber) and
          (ScriptOption.OwnerNumber = ScriptConfig.nOwnerNumber) and
          (ScriptOption.UserNumber = ScriptConfig.nUserNumber) and
          ((ScriptOption.Mode = StrToInt(DecryptString(s02))) or (ScriptOption.EndDate > Date)) and
          (ScriptOption.BeginDate < ScriptOption.EndDate) and
          (LoWord(ScriptOption.Version) = SOFTWARE_SCRIPT) and
          (ScriptOption.Version = ScriptConfig.nVersion) then begin

          //MainOutMessage('OPEN1', 0);

          FrmMain := TForm.Create(nil);
          FrmMain.BorderStyle := bsDialog;
          FrmMain.Position := poOwnerFormCenter;
          FrmMain.Caption := '注册信息';
          FrmMain.Width := 380;
          FrmMain.Height := 187;
          FrmMain.Font.Name := '宋体';
          FrmMain.Font.Charset := GB2312_CHARSET;
          FrmMain.Font.Size := 9;

          GroupBox := TGroupBox.Create(FrmMain);
          GroupBox.Parent := FrmMain;
          GroupBox.Left := 8;
          GroupBox.Top := 8;
          GroupBox.Width := 356;
          GroupBox.Height := 137;
          //GroupBox.Color := clWhite;
          GroupBox.Caption := '';
          Object00001 := TObject00001.Create(FrmMain);

          Img := TImage.Create(GroupBox);
          Img.Parent := GroupBox;
          Img.Left := 20;
          Img.Top := 24;
          Img.Picture.Icon.Handle := ExtractIcon(hInstance, PChar(Application.ExeName), 0);

          Labels := TLabel.Create(GroupBox);
          Labels.Parent := GroupBox;
          Labels.Left := 24 + 32 + 10;
          Labels.Top := 40;
          //Labels.Font.Color := clRed;
          Labels.Font.Style := Labels.Font.Style + [fsBold];
          //Labels.Color := clWhite;
          case ScriptOption.Mode of
            1: Labels.Caption := '使用日期: 从' + GetDate(ScriptOption.BeginDate) + '到' + GetDate(ScriptOption.EndDate);
            2: Labels.Caption := '无限使用';
          end;
          ButtonOK := TButton.Create(FrmMain);
          ButtonOK.Parent := GroupBox;
          ButtonOK.Left := 264;
          ButtonOK.Top := 96;
          ButtonOK.Caption := '确定(&R)';
          ButtonOK.OnClick := Object00001.TObject00003;

          FrmMain.ShowModal;
          Img.Free;
          ButtonOK.Free;
          Labels.Free;
          GroupBox.Free;
          FrmMain.Free;
          Object00001.Free;
        end;
      end;
    end;
  except

  end;
  MemoryStream.Free;
end;
//_____________________________________________________________________//

function InitPlug(): PChar;
var
  sPlugName: string;
begin
  New(StartPlugOK);
  New(g_PlugConfig);
  TF00004;
  if StartPlugOK^ then begin
    g_PlugEngine.PlugOfEngine.HookDeCodeString(DeCryptScript);
    MainOutMessage(Trim(g_PlugConfig.sLoadPlugSucced), 0);
  end else begin
    MainOutMessage(Trim(g_PlugConfig.sLoadPlugFail), 0);
  end;
  sPlugName := Trim(g_PlugConfig.sPlugName);
  //MainOutMessage(sPlugName, 0);
  Result := PChar(sPlugName);
end;

procedure UnInitPlug();
begin
  MainOutMessage(Trim(g_PlugConfig.sUnLoadPlug), 0);
  Dispose(StartPlugOK);
  Dispose(g_PlugConfig);
end;

end.

