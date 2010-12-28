unit Common;

interface
uses Grobal2, Controls;
const
  CHECKCRACK = 1; // Disables/Enables .DLL Checking
  g_nUpDateVersion = 20100901;   //712

  //服务器模块之间
  SG_CHECKCODEADDR = 1006;
  GS_QUIT = 2000; //关闭
  SG_FORMHANDLE = 1000; //服务器HANLD
  SG_STARTNOW = 1001; //正在启动服务器...
  SG_STARTOK = 1002; //服务器启动完成...
  SS_LOGINCOST = 103;

  SS_OPENSESSION = 1000;
  SS_CLOSESESSION = 1010;
  SS_SOFTOUTSESSION = 1020;
  SS_SERVERINFO = 1030;
  SS_KEEPALIVE = 1040;
  SS_KICKUSER = 1110;
  SS_SERVERLOAD = 1130;
  SS_ADDIPTOGATE = 1131;


  SM_CERTIFICATION_SUCCESS = 502;
  GS_USERACCOUNT = 2001;
  GS_CHANGEACCOUNTINFO = 2002;

  SG_USERACCOUNT = 1003;
  SG_USERACCOUNTNOTFOUND = 1004; //没有找到账号
  SG_USERACCOUNTCHANGESTATUS = 1005; //账号更新成功

  GS_GETM2SERVERVERSION = 2100;
  SG_GETM2SERVERVERSION = 2200;


  WM_SENDPROCMSG = 11111;
  CM_GETGAMELIST = 2000;
  SM_SENDGAMELIST = 5000;


  UNKNOWMSG = 1007;
//----------------------------------------------
  DB_LOADHUMANRCD = 1000;
  DB_SAVEHUMANRCD = 1001;
  DBR_LOADHUMANRCD = 1100;
  DBR_SAVEHUMANRCD = 1101;

  //DB_SAVEHUMANRCDEX = 1020;
//-----------------------------------------------
  DB_LOADHERORCD = 1002;
  DB_SAVEHERORCD = 1003;
  DB_NEWHERORCD = 1004; //新建英雄
  DB_DELHERORCD = 1005; //删除英雄


  DBR_LOADHERORCD = 1102;
  DBR_SAVEHERORCD = 1103;
  DBR_NEWHERORCD = 1104; //新建英雄
  DBR_DELHERORCD = 1105; //删除英雄
  DBR_NOTCREATEHERO = 1106; //


  DB_LOADRANKING = 1007; //读取排行榜
  DBR_LOADRANKING = 1107; //读取排行榜


  DB_SAVEMAGICLIST = 1108; //读取魔法列表
  DBR_SAVEMAGICLIST = 1109; //读取魔法列表

  DB_SAVESTDITEMLIST = 1110; //读取物品列表
  DBR_SAVESTDITEMLIST = 1111; //读取物品列表

  DB_SENDKEEPALIVE = 1112;
  DBR_SENDKEEPALIVE = 1113;

  DB_CLOSESOCKET = 5555;
  DBR_CLOSESOCKET = DB_CLOSESOCKET;

  DBR_FAIL = 8888;





  // For Game Gate
  GM_OPEN = 1;
  GM_CLOSE = 2;
  GM_CHECKSERVER = 3; // Send check signal to Server
  GM_CHECKCLIENT = 4; // Send check signal to Client
  GM_DATA = 5;
  GM_SERVERUSERINDEX = 6;
  GM_RECEIVE_OK = 7;
  GM_CLOSEOUTCONNECT = 8;
  GM_TEST = 20;

////////////////////////////////////////////////////////////////////////////////
  SP_GM_LOGIN = 102;

  SP_GM_GETUSER = 103;
  SP_SM_GETUSER_SUCCESS = 104;
  SP_SM_GETUSER_FAIL = 105;

  SP_GM_ADDUSER = 106;
  SP_SM_ADDUSER_SUCCESS = 107;
  SP_SM_ADDUSER_FAIL = 108;

  SP_GM_DELUSER = 109;
  SP_SM_DELUSER_SUCCESS = 110;
  SP_SM_DELUSER_FAIL = 111;

  SP_GM_CHGUSER = 112;
  SP_SM_CHGUSER_SUCCESS = 113;
  SP_SM_CHGUSER_FAIL = 114;

  SP_GM_SEARCHUSER = 115;
  SP_SM_SEARCHUSER_SUCCESS = 116;
  SP_SM_SEARCHUSER_FAIL = 117;

  GM_LOGIN = 118;
  SM_LOGIN_SUCCESS = 119;
  SM_LOGIN_FAIL = 120;

  GM_GETUSER = 121;
  SM_GETUSER_SUCCESS = 122;
  SM_GETUSER_FAIL = 123;

  GM_ADDUSER = 124;
  SM_ADDUSER_SUCCESS = 125;
  SM_ADDUSER_FAIL = 126;

  GM_DELUSER = 127;
  SM_DELUSER_SUCCESS = 128;
  SM_DELUSER_FAIL = 129;

  GM_CHGUSER = 130;
  SM_CHGUSER_SUCCESS = 131;
  SM_CHGUSER_FAIL = 132;

  GM_SEARCHUSER = 133;
  SM_SEARCHUSER_SUCCESS = 134;
  SM_SEARCHUSER_FAIL = 135;




  SOFTWARE_M2SERVER_MAKEKEY = 0;
  SOFTWARE_SCRIPT_MAKEKEY = 1;

  SOFTWARE_M2SERVER = 2;
  SOFTWARE_SCRIPT = 3;
  {VERSION_M2SERVER = 0;
  VERSION_SCRIPT = 1; }

  DBSUSETHREAD = 0;
////////////////////////////////////////////////////////////////////////////////

type
  TProgamType = (tDBServer, tLoginSrv, tLogServer, tM2Server, tLoginGate,
    tLoginGate1, tSelGate, tSelGate1, tRunGate, tRunGate1, tRunGate2,
    tRunGate3, tRunGate4, tRunGate5, tRunGate6, tRunGate7);

  TDomainNameArray = array[0..5 - 1] of string[50];
  TDomainNameFile = record
    nArr1: array[0..1] of Integer;
    nOwnerNumber: Integer; //QQ号码
    nArr2: array[0..1] of Integer;
    nUserNumber: Integer; //QQ号码
    nArr3: array[0..1] of Integer;
    sDomainName: string[50];
    nArr4: array[0..1] of Integer;
    nDomainName: Cardinal;
    nArr5: array[0..1] of Integer;
    DomainNameArray: TDomainNameArray;
    nArr6: array[0..1] of Integer;
    MinDate: TDateTime;
    nArr7: array[0..1] of Integer;
    MaxDate: TDateTime;
    nArr8: array[0..1] of Integer;
    boUnlimited: Boolean;
    nArr9: array[0..1] of Integer;
    nVersion: Integer;
  end;
  pTDomainNameFile = ^TDomainNameFile;

  TUserReg = record
    nOwnerNumber: Integer; //QQ号码
    nUserNumber: Integer; //QQ号码
    BeginDate: TDate;
    EndDate: TDate;
    nVersion: Integer;
    nCount: Integer;
    boUnlimited: Boolean;
    sDomainName: string[50];
    nDomainName: Cardinal;
  end;
  pTUserReg = ^TUserReg;

  {TEngineOption = record
    OwnerNumber: Integer; //QQ号码
    UserNumber: Integer; //QQ号码
    BeginDate: TDate;
    EndDate: TDate;
    Version: Integer;
    Count: Integer;
    boUnlimited: Boolean;
    sDomainName: string[50];
    nDomainName: Integer;
  end;
  pTEngineOption = ^TEngineOption;

  TEngineRegInfo = record //776
    sSerialNumber: string[32];
    sBuffer: array[0..280 - 1] of Char;
    nBuffer: Integer;
    //Param: array[0..10] of Integer;
  end;
  pTEngineRegInfo = ^TEngineRegInfo;   }


  TEngineConfig = record
    nOwnerNumber: Integer; //QQ号码
    nUserNumber: Integer; //QQ号码
    nMakeKey: Integer;
    nVersion: Integer;
    nSize: Integer;
    nCrc: Cardinal;
    nDllSize: Integer;
    nDllCrc: Cardinal;
    //boShareAllow: Boolean; //允许试用
    nNoticeTime1: Integer;
    nNoticeTime2: Integer;
  end;
  pTEngineConfig = ^TEngineConfig;


  TConfigOption = record
    nOwnerNumber: Integer; //QQ号码
    nUserNumber: Integer; //QQ号码
    nMakeKey: Integer;
    nVersion: Integer;
    nSize: Integer;
    nCrc: Cardinal;
    nDllSize: Integer;
    nDllCrc: Cardinal;
    //boShareAllow: Boolean; //允许试用
    nNoticeTime1: Integer;
    nNoticeTime2: Integer;
    {
    sUserCount: string[40];
    sUseDay: string[40];
    }
    //sKey: array[0..300 - 1] of Char;
    sSerialNumber: string[32];
    sVersion: string[100]; //引擎版本: 2.00 Build 200701010%d
    sUpDateTime: string[100]; //更新日期: 2007/01/01
    sProductName: string[100]; //MakeGM反外挂防攻击数据引擎(商业版) 13677866
    sProgram: string[100]; //MakeGM QQ：13677866
    sWebSite: string[100]; //http://www.MakeGM.com
    sBbsSite: string[100]; //http://www.MakeGM.com
    sProductInfo: string[100]; //欢迎使用MakeGM系列软件:
    sSellInfo1: string[100]; //销售联系: QQ:623131686 电话:023-58541052
    sNoticeInfo1: string[100]; //MakeGM最权威最专业的传奇服务.轻松做GM!
    sNoticeInfo2: string[100]; //Www.51pao.Com.就是要舒服.寻找新开游戏.还有MM陪你游戏!
    sNoticeInfo3: string[100]; //MakeGM最权威最专业的传奇服务.轻松做GM!
    sNoticeInfo4: string[100]; //Www.51pao.Com.就是要舒服.寻找新开游戏.还有MM陪你游戏!
    //sMark: string[100];
  end;
  pTConfigOption = ^TConfigOption;


  TScriptConfig = record
    sPlugName: string[50]; // 'MakeGM脚本扩展插件';
    sLoadPlugSucced: string[50]; // '加载MakeGM脚本扩展插件成功...';
    sLoadPlugFail: string[50]; // '加载MakeGM脚本扩展插件失败...';
    sUnLoadPlug: string[50]; // '卸载MakeGM扩展扩展插件成功...';
    sLabelMsg: string[255];
    sPassWord: string[100];
    nOwnerNumber: Integer; //QQ号码
    nUserNumber: Integer; //QQ号码
    nVersion: Integer;
    nSize: Integer;
    nCrc: Cardinal;
    boShareMode: Boolean;
    nBeginDate: TDate;
    nEndDate: TDate;
    sSerialNumber: string[32];
  end;
  pTScriptConfig = ^TScriptConfig;

  TScriptOption = record //280
    SerialBuffer: string[32];
    OwnerNumber: Integer;
    UserNumber: Integer;
    SerialNumber: Cardinal;
    Version: Integer;
    MakeKey: Integer;
    Mode: Integer;
    BeginDate: TDate;
    EndDate: TDate;
    LicDay: Integer;
    Param: array[0..10 - 1] of Integer;
  end;
  pTScriptOption = ^TScriptOption;

  {TPScriptOption = record //280
    SerialBuffer: PChar;
    OwnerNumber: PInteger;
    UserNumber: PInteger;
    SerialNumber: PInteger;
    Version: PInteger;
    MakeKey: PInteger;
    Mode: PInteger;
    BeginDate: PDouble;
    EndDate: PDouble;
    LicDay: PInteger;
    Param: array[0..10 - 1] of PInteger;
  end;
  pTPScriptOption = ^TPScriptOption;}

  TMakeInfo = record //232
    nOwnerNumber: Integer; //QQ号码
    nUserNumber: Integer; //QQ号码
    nSerialNumber: Cardinal; //机器码
    nSize: Integer;
    nCrc: Cardinal;
    nVersion: Integer;
    dDate: TDate;
    Param: array[0..10] of Integer;
  end;
  pTMakeInfo = ^TMakeInfo;

  TMakeRegInfo = record //920
    sSerialNumber: string[32];
    sBuffer: string[255];
    nBuffer: Cardinal;
    Param: array[0..10] of Integer;
  end;
  pTMakeRegInfo = ^TMakeRegInfo;

var
  g_nUserLicense: Integer;
  g_sUserQQKey: string;
  g_nSerialNumber: Int64;

  ConfigOptionSize: Integer; // 2004;
  ScriptConfigSize: Integer; // 852;
  //EngineOptionSize: Integer; // 196 + SizeOf(Integer);
implementation
uses EncryptUnit;

procedure Initialize();
var
  ConfigOption: TConfigOption;
  ScriptConfig: TScriptConfig;
begin
  ConfigOptionSize := Length(EncryptBuffer(@ConfigOption, SizeOf(TConfigOption)));
  ScriptConfigSize := Length(EncryptBuffer(@ScriptConfig, SizeOf(TScriptConfig)));
end;

initialization
  begin
    Initialize();
  end;
end.
