unit Share;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, PlugShare;
  //    cRegistryKey: array[0..300 - 1] of Char;
var
  R_SystemInitialize: PBoolean;
  R_nOwner, R_nUserNumber, R_nVersion: PInteger;
  R_boShareAllow: Boolean; //允许试用
  R_ShareStatus: TRegistryStatus; //试用模式
  R_nShareNumber: Integer; //试用次数
  R_ShareDate: TDate; //试用日期

  R_MyRootKey: Integer = HKEY_CURRENT_USER; //注册表根键
  R_MySubKey: string = '\Software\Registry\'; //注册表子键
  R_Key: string = 'Key';
  R_nRegistryCount:Integer=0;
  R_SystemConfig: TSystemConfig;
implementation

end.

