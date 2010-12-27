unit PlugMain;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellApi, HUtil32, PlugShare;
procedure SystemInitialize(Config: pTSystemConfig); stdcall;
procedure GetRegistryInfo(RegistryInfo: pTRegistryConfig); stdcall;
procedure GetRegistryKey(RegistryConfig: pTRegistryConfig; Key: PChar); stdcall;
procedure RegistryControl(); stdcall;
function GetSerialNumber(nUserNumber, nVersion: Integer): string;
function ReadRegKey(const iMode: Integer; const sPath,
  sKeyName: string; var sResult: string): Boolean;
function WriteRegKey(const iMode: Integer; const sPath, sKeyName,
  sKeyValue: string): Boolean;
implementation
uses EncryptUnit, { Common,} MSI_CPU, MSI_Storage, MSI_Machine, MD5EncodeStr, Registry, Share, RegistryFrm;
{const
  R_MyRootKey = HKEY_CURRENT_USER; //注册表根键
  R_MySubKey = '\Software\MirScript\'; //注册表子键
  R_Key = 'Key';

  s00 = 'yBNnxNUXwzJE'; //0
  s01 = 'OvA2FqLK1ipA'; //1
  s02 = 'NdBKFYqYD6cf'; //2   }

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
  Result := RivestStr(IntToStr(HashPJW(RivestStr(GetBIOS) +
    RivestStr(GetCPUSerialNumber) +
    RivestStr(GetDiskSerialNumber)) +
    nUserNumber + nVersion + (nUserNumber * nVersion)));
end;

function CompareMemory(X1, X2: PByteArray; Size: Longint): boolean;
var
  I: longint;
begin
  Result := True;
  for I := 1 to Size do
    if X1^[I - 1] <> X2^[I - 1] then begin
      Result := False;
      Exit;
    end;
end;

procedure GetRegistryKey(RegistryConfig: pTRegistryConfig; Key: PChar);
var
  sKey: string;
begin
  if (R_SystemInitialize^) and (RegistryConfig.nUserNumber = R_nUserNumber^) and (RegistryConfig.nVersion = R_nVersion^) and (R_nVersion^ <> 0) and (R_nUserNumber^ <> 0) then begin
    sKey := EncryptBuffer(@(RegistryConfig^), SizeOf(TRegistryConfig) - 4);
    Move(sKey[1], Key^, Length(sKey));
    //Showmessage('GetRegistryKey:' + IntToStr(Length(sKey)));
  end;
end;

procedure SystemInitialize(Config: pTSystemConfig);
begin
  if (Config.nOwner = R_nOwner^) and (Config.nOwner <> 0) and (not R_SystemInitialize^) then begin
    //Showmessage('SystemInitialize');
    R_SystemInitialize^ := True;
    R_SystemConfig := Config^;
    R_nUserNumber^ := Config.nUserNumber;
    R_nVersion^ := Config.nVersion;
    R_MyRootKey := Config.nMyRootKey; //注册表根键
    R_MySubKey := Config.cMySubKey; //注册表子键
    R_Key := Config.cKey;
  end;
end;

procedure GetRegistryInfo(RegistryInfo: pTRegistryConfig);
var
  RegistryConfig: TRegistryConfig;
  sSerialNumber: string;
  sKey: string;
  boUpdate: Boolean;
  boOpenDlg: Boolean;
  InData, OutData: Pointer;
label
  ReRegistry;
begin
  try
    ReRegistry:
    if R_SystemInitialize^ {and (RegistryInfo.nOwnerNumber = R_nOwner^) and (R_nOwner^ <> 0) } and (R_nRegistryCount <= 1) then begin
      //Showmessage('GetRegistryInfo');
      boUpdate := False;
      boOpenDlg := False;
      sKey := '';
      if ReadRegKey(1, R_MySubKey, R_Key, sKey) then begin
        DecryptBuffer(sKey, @RegistryConfig, SizeOf(TRegistryConfig) - 4);
        sSerialNumber := RegistryConfig.SerialNumber;
        if (RegistryConfig.nUserNumber = R_nUserNumber^) and (sSerialNumber = GetSerialNumber(R_nUserNumber^, R_nVersion^)) then begin
          {RegistryInfo.nUserNumber := RegistryConfig.nUserNumber;
          RegistryInfo.nVersion := RegistryConfig.nVersion;
          RegistryInfo.RegistryStatus := RegistryConfig.RegistryStatus;}
          case RegistryConfig.RegistryStatus of
            r_Share: ;
            r_Number: if RegistryConfig.RegistryCount > 0 then begin
                Dec(RegistryConfig.RegistryCount);
                boUpdate := True;
              end else begin
                boOpenDlg := True;
              end;
            r_Date: begin
                if Date > RegistryConfig.RegistryDate then begin
                  boOpenDlg := True;
                end else RegistryInfo.RegistrySuccess := RegistryControl;
              end;
            r_Forever: RegistryInfo.RegistrySuccess := RegistryControl;
          end;
          {RegistryInfo.RegistryDate := RegistryConfig.RegistryDate;
          RegistryInfo.RegistryCount := RegistryConfig.RegistryCount;
          InData := @RegistryConfig.SerialNumber;
          OutData := @RegistryInfo.SerialNumber;
          Move(InData^, OutData^, 32); }

          Move(RegistryConfig, RegistryInfo^, SizeOf(TRegistryConfig) - 4);
            //RegistryInfo^ := RegistryConfig;
          InData := Pointer(Integer(RegistryInfo) + 4);
          RegistryInfo^.nCRC := CalcBufferCRC(InData, SizeOf(TRegistryConfig) - 4);
            //RegistryInfo^.RegistrySuccess := nil;

          if boUpdate then begin
            sKey := EncryptBuffer(@RegistryConfig, SizeOf(TRegistryConfig) - 4);
            if WriteRegKey(1, R_MySubKey, R_Key, sKey) then begin
              boUpdate := False;
              RegistryInfo.RegistrySuccess := RegistryControl;
              if (not boOpenDlg) and Assigned(R_SystemConfig.RegistryInfo) then begin
                R_SystemConfig.RegistryInfo;
                Exit;
              end;
            end else begin
              boOpenDlg := True;
            end;
          end;

          if (not boUpdate) and (not boOpenDlg) then begin
            if Assigned(R_SystemConfig.RegistryInfo) then begin
              R_SystemConfig.RegistryInfo;
              Exit;
            end;
          end;

          if (not boUpdate) and boOpenDlg and (R_nRegistryCount <= 0) then begin
            FrmRegistryDlg := TFrmRegistryDlg.Create(nil);
            FrmRegistryDlg.ShowModal;
            FrmRegistryDlg.Free;
            Inc(R_nRegistryCount);
            goto ReRegistry;
            Exit;
          end;
        end;
      end else begin
        if sKey = '' then begin

        end;
        if R_nRegistryCount <= 0 then begin
          FrmRegistryDlg := TFrmRegistryDlg.Create(nil);
          FrmRegistryDlg.ShowModal;
          FrmRegistryDlg.Free;
          Inc(R_nRegistryCount);
          goto ReRegistry;
          Exit;
        end;
      end;
    end;
  except

  end;
end;

procedure RegistryControl();
var
  RegistryConfig: TRegistryConfig;
  sSerialNumber: string;
  sKey: string;
begin
  try
    if R_SystemInitialize^ then begin
      sKey := '';
      if ReadRegKey(1, R_MySubKey, R_Key, sKey) then begin
        DecryptBuffer(sKey, @RegistryConfig, SizeOf(TRegistryConfig) - 4);
        sSerialNumber := RegistryConfig.SerialNumber;
        if (RegistryConfig.nUserNumber = R_nUserNumber^) and (sSerialNumber = GetSerialNumber(R_nUserNumber^, R_nVersion^)) then begin
          case RegistryConfig.RegistryStatus of
            r_Share: ;
            r_Number: if (RegistryConfig.RegistryCount > 0) and Assigned(R_SystemConfig.RegistryControl) then R_SystemConfig.RegistryControl();
            r_Date: if (Date <= RegistryConfig.RegistryDate) and Assigned(R_SystemConfig.RegistryControl) then R_SystemConfig.RegistryControl();
            r_Forever: if Assigned(R_SystemConfig.RegistryControl) then R_SystemConfig.RegistryControl();
          end;
        end;
      end;
    end;
  except

  end;
end;

procedure UnInit(); stdcall;
begin

end;

end.

