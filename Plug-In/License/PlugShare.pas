unit PlugShare;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls;
type
  TStartProc = procedure(); stdcall;
  TRegistryStatus = (r_Share, r_Number, r_Date, r_Forever);
  TRegistryConfig = packed record
    nCRC: Integer;
    nOwnerNumber: Integer;
    nUserNumber: Integer;
    nVersion: Integer;
    SerialNumber: array[0..32 - 1] of Char;
    RegistryStatus: TRegistryStatus;
    RegistryDate: TDate;
    RegistryCount: Integer;
    RegistrySuccess: TStartProc;
  end;
  pTRegistryConfig = ^TRegistryConfig;

{  TRegistryInfo = packed record
    nOwnerNumber: Integer;
    nUserNumber: Integer;
    nVersion: Integer;
    SerialNumber: array[0..32 - 1] of Char;
    RegistryStatus: TRegistryStatus;
    RegistryDate: TDate;
    RegistryCount: Integer;
  end;
  pTRegistryInfo = ^TRegistryInfo; }


  //TRegistryInfo = function: pTRegistryConfig; stdcall;

  TSystemConfig = packed record
    nOwner, nUserNumber, nVersion, nMyRootKey: Integer;
    boShareAllow: Boolean; //允许试用
    ShareStatus: TRegistryStatus; //试用模式
    nShareNumber: Integer; //试用次数
    cMySubKey: array[0..50 - 1] of Char;
    cKey: array[0..50 - 1] of Char;

    RegistryControl: TStartProc;
    RegistryInfo: TStartProc;
    RegistrySuccess: TStartProc;
    RegistryFail: TStartProc;
  end;
  pTSystemConfig = ^TSystemConfig;
implementation

end.

