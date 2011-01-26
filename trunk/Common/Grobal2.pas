unit Grobal2;

interface
uses
  Windows, Classes, JSocket, Controls;
const
  HEROVERSION = 1; //编译开关 0=企业版 1=英雄版
  //ALLFUNCTION = 1;
  CLIENT_VERSION_NUMBER = 120090701; //版本号
//==============================================================================

  ACCOUNTLEN = 30;
  MAXPATHLEN = 255;
  DIRPATHLEN = 80;
  MAPNAMELEN = 16;
  ACTORNAMELEN = 14;
  DEFBLOCKSIZE = 16;
  BUFFERSIZE = 12000;
  DATA_BUFSIZE2 = 16348; //8192;
  DATA_BUFSIZE = 8192; //8192;
  GROUPMAX = 11;
  BAGGOLD = 5000000;
  BODYLUCKUNIT = 10;
  MAX_STATUS_ATTRIBUTE = 12;

  DR_UP = 0;
  DR_UPRIGHT = 1;
  DR_RIGHT = 2;
  DR_DOWNRIGHT = 3;
  DR_DOWN = 4;
  DR_DOWNLEFT = 5;
  DR_LEFT = 6;
  DR_UPLEFT = 7;

  AT_FIRE = 1; //火
  AT_ICE = 2; //冰
  AT_LIGHT = 3; //电
  AT_WIND = 4; //风
  AT_HOLY = 5; //神圣
  AT_DARK = 6; //暗黑
  AT_PHANTOM = 7; //幻影

  U_DRESS = 0;
  U_WEAPON = 1;
  U_RIGHTHAND = 2;
  U_NECKLACE = 3;
  U_HELMET = 4; //头盔
  U_ARMRINGL = 5;
  U_ARMRINGR = 6;
  U_RINGL = 7;
  U_RINGR = 8;
  U_BUJUK = 9; //符
  U_BELT = 10; //腰带
  U_BOOTS = 11; //鞋
  U_CHARM = 12;

  POISON_DECHEALTH = 0;
  POISON_DAMAGEARMOR = 1;
  POISON_LOCKSPELL = 2;
  POISON_DONTMOVE = 4;
  POISON_STONE = 5;
  STATE_TRANSPARENT = 8;
  STATE_DEFENCEUP = 9;
  STATE_MAGDEFENCEUP = 10;
  STATE_BUBBLEDEFENCEUP = 11;

  USERMODE_PLAYGAME = 1;
  USERMODE_LOGIN = 2;
  USERMODE_LOGOFF = 3;
  USERMODE_NOTICE = 4;

  RUNGATEMAX = 20;

  RUNGATECODE = $AA55AA55;
  //RUNGATECODE = $AA9AAA9A; BLUE

  OS_MOVINGOBJECT = 1;
  OS_ITEMOBJECT = 2;
  OS_EVENTOBJECT = 3;
  OS_GATEOBJECT = 4;
  OS_SWITCHOBJECT = 5;
  OS_MAPEVENT = 6;
  OS_DOOR = 7;
  OS_ROON = 8;
  OS_OBJECTGATE = 9;


  RC_PLAYOBJECT = 0;
  RC_DUMMOBJECT = 1; //假人

  RC_MOONOBJECT = 60; //月灵
  RC_HEROOBJECT = 66; //英雄
  RC_GUARD = 11; //大刀守卫
  RC_PEACENPC = 15;
  RC_ANIMAL = 50;
  RC_MONSTER = 80;
  RC_NPC = 10;
  RC_ARCHERGUARD = 112;
  RC_PLAYMOSTER = 150; //人形怪物




  RCC_USERHUMAN = RC_PLAYOBJECT;
  RCC_GUARD = RC_GUARD;
  RCC_MERCHANT = RC_ANIMAL;

  ISM_WHISPER = 1234;

  CM_QUERYCHR = 100;
  CM_NEWCHR = 101;
  CM_DELCHR = 102;
  CM_SELCHR = 103;
  CM_SELECTSERVER = 104;
  CM_QUERYDELCHR = 105;
  CM_RESTORECHR = 106;

  CM_QUERYSERVERNAME = 107; //查询服务器列表
  CM_QUERYRANDOMCODE = 108; //查询验证码
  CM_SENDRANDOMCODE = 109; //验证验证码





  SM_RUSH = 6;
  SM_RUSHKUNG = 7; //
  SM_FIREHIT = 8; //烈火

  SM_BACKSTEP = 9;
  SM_TURN = 10; //转向
  SM_WALK = 11; //走
  SM_SITDOWN = 12;
  SM_RUN = 13; //跑
  SM_HIT = 14; //砍
  SM_HEAVYHIT = 15; //
  SM_BIGHIT = 16; //
  SM_SPELL = 17; //使用魔法
  SM_POWERHIT = 18;
  SM_LONGHIT = 19; //刺杀
  SM_DIGUP = 20;
  SM_DIGDOWN = 21;
  SM_FLYAXE = 22;
  SM_LIGHTING = 23;
  SM_WIDEHIT = 24;
  SM_CRSHIT = 25;
  SM_TWINHIT = 26;


 { SM_27 = 27;
  SM_28 = 28;
  SM_29 = 29;
  SM_30 = 30;
  SM_31 = 31;
  SM_32 = 32;

  SM_40 = 40;
  SM_41 = 41;
  SM_42 = 42;
  SM_43 = 43;
  SM_44 = 44;
  SM_45 = 45; }

  SM_40 = 35;
  SM_41 = 36;
  SM_42 = 37;
  SM_43 = 38;
  SM_44 = 39;

  SM_60HIT = 60;
  SM_61HIT = 61;
  SM_62HIT = 62;
  SM_63HIT = 63;
  SM_64HIT = 64;
  SM_65HIT = 65;

  SM_66HIT = 66;
  SM_67HIT = 67;
  SM_68HIT = 68;
  SM_69HIT = 69;
  SM_70HIT = 70;

  SM_PKHIT = SM_66HIT;
  SM_KTHIT = SM_67HIT;
  SM_ZRJFHIT = SM_68HIT; //逐日剑法

  SM_SUPERFIREHIT = SM_70HIT; //4级烈火


  SM_100HIT = 300; //三绝杀
  SM_101HIT = 301; //追心刺
  SM_102HIT = 302; //断岳斩
  SM_103HIT = 303; //横扫千军



  SM_ALIVE = 27; //
  SM_MOVEFAIL = 28; //
  SM_HIDE = 29; //
  SM_DISAPPEAR = 30;
  SM_STRUCK = 31; //弯腰
  SM_DEATH = 32;
  SM_SKELETON = 33;
  SM_NOWDEATH = 34;

  SM_ACTION_MIN = SM_RUSH;
  SM_ACTION_MAX = SM_WIDEHIT;
  SM_ACTION2_MIN = 65072;
  SM_ACTION2_MAX = 65073;

  SM_HEAR = 40;
  SM_FEATURECHANGED = 41;
  SM_USERNAME = 42;
  SM_WINEXP = 44;
  SM_LEVELUP = 45;
  SM_DAYCHANGING = 46;

  SM_LOGON = 50;
  SM_NEWMAP = 51;
  SM_ABILITY = 52;
  SM_HEALTHSPELLCHANGED = 53;
  SM_MAPDESCRIPTION = 54;
  SM_SPELL2 = 117;

  SM_SYSMESSAGE = 100;
  SM_GROUPMESSAGE = 101;
  SM_CRY = 102;
  SM_WHISPER = 103;
  SM_GUILDMESSAGE = 104;
  SM_MOVEMESSAGE = 105;

  SM_ADDITEM = 200;
  SM_BAGITEMS = 201;
  SM_DELITEM = 202;
  SM_UPDATEITEM = 203;
  SM_UPDATEITEM2 = 204;
  SM_ADDMAGIC = 210;
  SM_SENDMYMAGIC = 211;
  SM_DELMAGIC = 212;

  SM_CERTIFICATION_FAIL = 501;
  SM_ID_NOTFOUND = 502;
  SM_PASSWD_FAIL = 503;
  SM_NEWID_SUCCESS = 504;
  SM_NEWID_FAIL = 505;
  SM_CHGPASSWD_SUCCESS = 506;
  SM_CHGPASSWD_FAIL = 507;
  SM_GETBACKPASSWD_SUCCESS = 508; //密码找回成功
  SM_GETBACKPASSWD_FAIL = 509; //密码找回失败

  SM_QUERYCHR = 520;
  SM_NEWCHR_SUCCESS = 521;
  SM_NEWCHR_FAIL = 522;
  SM_DELCHR_SUCCESS = 523;
  SM_DELCHR_FAIL = 524;
  SM_STARTPLAY = 525;
  SM_STARTFAIL = 526; //SM_USERFULL
  SM_QUERYCHR_FAIL = 527;
  SM_OUTOFCONNECTION = 528; //?
  SM_PASSOK_SELECTSERVER = 529;
  SM_SELECTSERVER_OK = 530;
  SM_NEEDUPDATE_ACCOUNT = 531;
  SM_UPDATEID_SUCCESS = 532;
  SM_UPDATEID_FAIL = 533;

  SM_FINDDELCHR = 534;
  SM_FINDDELCHR_SUCCESS = 535;
  SM_FINDDELCHR_FAIL = 536;

  SM_SERVERNAME = 537; //服务器列表
  SM_SENDRANDOMCODE = 538; //发送验证码


  SM_DROPITEM_SUCCESS = 600;
  SM_DROPITEM_FAIL = 601;

  SM_ITEMSHOW = 610;
  SM_ITEMHIDE = 611;
  //  SM_DOOROPEN           = 612;
  SM_OPENDOOR_OK = 612; //
  SM_OPENDOOR_LOCK = 613;
  SM_CLOSEDOOR = 614;
  SM_TAKEON_OK = 615;
  SM_TAKEON_FAIL = 616;
  SM_TAKEOFF_OK = 619;
  SM_TAKEOFF_FAIL = 620;
  SM_SENDUSEITEMS = 621;
  SM_WEIGHTCHANGED = 622;
  SM_CLEAROBJECTS = 633;
  SM_CHANGEMAP = 634;
  SM_EAT_OK = 635;
  SM_EAT_FAIL = 636;
  SM_BUTCH = 637;
  SM_MAGICFIRE = 638;
  SM_MAGICFIRE_FAIL = 639;
  SM_MAGIC_LVEXP = 640;
  SM_DURACHANGE = 642;
  SM_MERCHANTSAY = 643;
  SM_MERCHANTDLGCLOSE = 644;
  SM_SENDGOODSLIST = 645;
  SM_SENDUSERSELL = 646;
  SM_SENDBUYPRICE = 647;
  SM_USERSELLITEM_OK = 648;
  SM_USERSELLITEM_FAIL = 649;
  SM_BUYITEM_SUCCESS = 650; //?
  SM_BUYITEM_FAIL = 651; //?
  SM_SENDDETAILGOODSLIST = 652;
  SM_GOLDCHANGED = 653;
  SM_CHANGELIGHT = 654;
  SM_LAMPCHANGEDURA = 655;
  SM_CHANGENAMECOLOR = 656;
  SM_CHARSTATUSCHANGED = 657;
  SM_SENDNOTICE = 658;
  SM_GROUPMODECHANGED = 659; //
  SM_CREATEGROUP_OK = 660;
  SM_CREATEGROUP_FAIL = 661;
  SM_GROUPADDMEM_OK = 662;
  SM_GROUPDELMEM_OK = 663;
  SM_GROUPADDMEM_FAIL = 664;
  SM_GROUPDELMEM_FAIL = 665;
  SM_GROUPCANCEL = 666;
  SM_GROUPMEMBERS = 667;
  SM_SENDUSERREPAIR = 668;
  SM_USERREPAIRITEM_OK = 669;
  SM_USERREPAIRITEM_FAIL = 670;
  SM_SENDREPAIRCOST = 671;
  SM_DEALMENU = 673;
  SM_DEALTRY_FAIL = 674;
  SM_DEALADDITEM_OK = 675;
  SM_DEALADDITEM_FAIL = 676;
  SM_DEALDELITEM_OK = 677;
  SM_DEALDELITEM_FAIL = 678;
  SM_DEALCANCEL = 681;
  SM_DEALREMOTEADDITEM = 682;
  SM_DEALREMOTEDELITEM = 683;
  SM_DEALCHGGOLD_OK = 684;
  SM_DEALCHGGOLD_FAIL = 685;
  SM_DEALREMOTECHGGOLD = 686;
  SM_DEALSUCCESS = 687;
  SM_SENDUSERSTORAGEITEM = 700;
  SM_STORAGE_OK = 701;
  SM_STORAGE_FULL = 702;
  SM_STORAGE_FAIL = 703;
  SM_SAVEITEMLIST = 704;
  SM_TAKEBACKSTORAGEITEM_OK = 705;
  SM_TAKEBACKSTORAGEITEM_FAIL = 706;
  SM_TAKEBACKSTORAGEITEM_FULLBAG = 707;

  SM_AREASTATE = 708;
  SM_MYSTATUS = 766;

  SM_DELITEMS = 709;
  SM_READMINIMAP_OK = 710;
  SM_READMINIMAP_FAIL = 711;
  SM_SENDUSERMAKEDRUGITEMLIST = 712;
  SM_MAKEDRUG_SUCCESS = 713;
  //  714
  //  716
  SM_MAKEDRUG_FAIL = 65036;

  SM_CHANGEGUILDNAME = 750;
  SM_SENDUSERSTATE = 751; //
  SM_SUBABILITY = 752;
  SM_OPENGUILDDLG = 753; //
  SM_OPENGUILDDLG_FAIL = 754; //
  SM_SENDGUILDMEMBERLIST = 756; //
  SM_GUILDADDMEMBER_OK = 757; //
  SM_GUILDADDMEMBER_FAIL = 758;
  SM_GUILDDELMEMBER_OK = 759;
  SM_GUILDDELMEMBER_FAIL = 760;
  SM_GUILDRANKUPDATE_FAIL = 761;
  SM_BUILDGUILD_OK = 762;
  SM_BUILDGUILD_FAIL = 763;
  SM_DONATE_OK = 764;
  SM_DONATE_FAIL = 765;

  SM_MENU_OK = 767; //?
  SM_GUILDMAKEALLY_OK = 768;
  SM_GUILDMAKEALLY_FAIL = 769;
  SM_GUILDBREAKALLY_OK = 770; //?
  SM_GUILDBREAKALLY_FAIL = 771; //?
  SM_DLGMSG = 772; //Jacky
  SM_SPACEMOVE_HIDE = 800;
  SM_SPACEMOVE_SHOW = 801;
  SM_RECONNECT = 802; //
  SM_GHOST = 803;
  SM_SHOWEVENT = 804;
  SM_HIDEEVENT = 805;
  SM_SPACEMOVE_HIDE2 = 806;
  SM_SPACEMOVE_SHOW2 = 807;
  SM_TIMECHECK_MSG = 810;
  SM_ADJUST_BONUS = 811; //?

  SM_OPENHEALTH = 1100;
  SM_CLOSEHEALTH = 1101;

  SM_BREAKWEAPON = 1102;
  SM_INSTANCEHEALGUAGE = 1103; //??
  SM_CHANGEFACE = 1104;
  SM_VERSION_FAIL = 1106;

  SM_ITEMUPDATE = 1500;
  SM_MONSTERSAY = 1501;

  SM_EXCHGTAKEON_OK = 65023;
  SM_EXCHGTAKEON_FAIL = 65024;

  SM_TEST = 65037;
  SM_TESTHERO = 65038;
  SM_THROW = 65069;

  RM_DELITEMS = 9000; //Jacky
  RM_TURN = 10001;
  RM_WALK = 10002;
  RM_RUN = 10003;
  RM_HIT = 10004;
  RM_SPELL = 10007;
  RM_SPELL2 = 10008;
  RM_POWERHIT = 10009;
  RM_LONGHIT = 10011;
  RM_WIDEHIT = 10012;
  RM_PUSH = 10013;
  RM_FIREHIT = 10014;
  RM_RUSH = 10015;
  RM_STRUCK = 10020;
  RM_DEATH = 10021;
  RM_DISAPPEAR = 10022;
  RM_MAGSTRUCK = 10025;
  RM_MAGHEALING = 10026;
  RM_STRUCK_MAG = 10027;
  RM_MAGSTRUCK_MINE = 10028;
  RM_INSTANCEHEALGUAGE = 10029; //jacky
  RM_HEAR = 10030;
  RM_WHISPER = 10031;
  RM_CRY = 10032;
  RM_RIDE = 10033;
  RM_WINEXP = 10044;
  RM_USERNAME = 10043;
  RM_LEVELUP = 10045;
  RM_CHANGENAMECOLOR = 10046;

  RM_LOGON = 10050;
  RM_ABILITY = 10051;
  RM_HEALTHSPELLCHANGED = 10052;
  RM_DAYCHANGING = 10053;

  RM_SYSMESSAGE = 10100;
  RM_GROUPMESSAGE = 10102;
  RM_SYSMESSAGE2 = 10103;
  RM_GUILDMESSAGE = 10104;
  RM_SYSMESSAGE3 = 10105; //Jacky
  RM_DELAYMESSAGE = 10106;
  RM_DELETEDELAYMESSAGE = 10107;
  RM_CENTERMESSAGE = 10108;

  RM_ITEMSHOW = 10110;
  RM_ITEMHIDE = 10111;
  RM_DOOROPEN = 10112;
  RM_DOORCLOSE = 10113;
  RM_SENDUSEITEMS = 10114;
  RM_WEIGHTCHANGED = 10115;

  RM_MOVEMESSAGE = 10240;

  RM_FEATURECHANGED = 10116;
  RM_CLEAROBJECTS = 10117;
  RM_CHANGEMAP = 10118;
  RM_BUTCH = 10119;
  RM_MAGICFIRE = 10120;
  RM_SENDMYMAGIC = 10122;
  RM_MAGIC_LVEXP = 10123;
  RM_SKELETON = 10024;
  RM_DURACHANGE = 10125;
  RM_MERCHANTSAY = 10126;
  RM_GOLDCHANGED = 10136;
  RM_CHANGELIGHT = 10137;
  RM_CHARSTATUSCHANGED = 10139;
  RM_DELAYMAGIC = 10154;

  RM_DIGUP = 10200;
  RM_DIGDOWN = 10201;
  RM_FLYAXE = 10202;
  RM_LIGHTING = 10204;

  RM_SUBABILITY = 10302;
  RM_TRANSPARENT = 10308;

  RM_SPACEMOVE_SHOW = 10331;
  RM_RECONNECTION = 11332;
  RM_SPACEMOVE_SHOW2 = 10332; //?
  RM_HIDEEVENT = 10333;
  RM_SHOWEVENT = 10334;
  RM_ZEN_BEE = 10337;

  RM_OPENHEALTH = 10410;
  RM_CLOSEHEALTH = 10411;
  RM_DOOPENHEALTH = 10412;
  RM_CHANGEFACE = 10415;

  RM_ITEMUPDATE = 11000;
  RM_MONSTERSAY = 11001;
  RM_MAKESLAVE = 11002;

  RM_SUPERFIREHIT = 11003;









  RM_MONMOVE = 21004;
  SS_200 = 200;
  SS_201 = 201;
  SS_202 = 202;
  SS_WHISPER = 203;
  SS_204 = 204;
  SS_205 = 205;
  SS_206 = 206;
  SS_207 = 207;
  SS_208 = 208;
  SS_209 = 219;
  SS_210 = 210;
  SS_211 = 211;
  SS_212 = 212;
  SS_213 = 213;
  SS_214 = 214;
  SS_215 = 215;
  SS_216 = 216;

  RM_10205 = 10205;
  RM_10206 = 10206;
  RM_10101 = 10101;
  RM_ALIVE = 10153;
  RM_CHANGEGUILDNAME = 10301;
  RM_10414 = 10414;
  RM_POISON = 10300;
  LA_UNDEAD = 1; //未知;

  RM_DELAYPUSHED = 10555;

  CM_GETBACKPASSWORD = 2010; //密码找回
  CM_SPELL = 3017;
  CM_QUERYUSERNAME = 80;

  CM_DROPITEM = 1000;
  CM_PICKUP = 1001;
  CM_TAKEONITEM = 1003;
  CM_TAKEOFFITEM = 1004;
  CM_EAT = 1006;
  CM_BUTCH = 1007;
  CM_MAGICKEYCHANGE = 1008;
  CM_1005 = 1005;

  CM_CLICKNPC = 1010;
  CM_MERCHANTDLGSELECT = 1011;
  CM_MERCHANTQUERYSELLPRICE = 1012;
  CM_USERSELLITEM = 1013;
  CM_USERBUYITEM = 1014;
  CM_USERGETDETAILITEM = 1015;
  CM_DROPGOLD = 1016;
  CM_LOGINNOTICEOK = 1018;
  CM_GROUPMODE = 1019;
  CM_CREATEGROUP = 1020;
  CM_ADDGROUPMEMBER = 1021;
  CM_DELGROUPMEMBER = 1022;
  CM_USERREPAIRITEM = 1023;
  CM_MERCHANTQUERYREPAIRCOST = 1024;
  CM_DEALTRY = 1025;
  CM_DEALADDITEM = 1026;
  CM_DEALDELITEM = 1027;
  CM_DEALCANCEL = 1028;
  CM_DEALCHGGOLD = 1029;
  CM_DEALEND = 1030;
  CM_USERSTORAGEITEM = 1031;
  CM_USERTAKEBACKSTORAGEITEM = 1032;
  CM_WANTMINIMAP = 1033;
  CM_USERMAKEDRUGITEM = 1034;
  CM_OPENGUILDDLG = 1035;
  CM_GUILDHOME = 1036;
  CM_GUILDMEMBERLIST = 1037;
  CM_GUILDADDMEMBER = 1038;
  CM_GUILDDELMEMBER = 1039;
  CM_GUILDUPDATENOTICE = 1040;
  CM_GUILDUPDATERANKINFO = 1041;
  CM_ADJUST_BONUS = 1043;
  CM_SPEEDHACKUSER = 10430; //??

  CM_PASSWORD = 1105;
  CM_CHGPASSWORD = 1221; //?
  CM_SETPASSWORD = 1222; //?

  CM_HORSERUN = 3009;

  CM_THROW = 3005;

  CM_TURN = 3010;
  CM_WALK = 3011;
  CM_SITDOWN = 3012;
  CM_RUN = 3013;
  CM_HIT = 3014;
  CM_HEAVYHIT = 3015;
  CM_BIGHIT = 3016;

  CM_POWERHIT = 3018;
  CM_LONGHIT = 3019;

  CM_WIDEHIT = 3024; //半月
  CM_FIREHIT = 3025; //烈火
  CM_CRSHIT = 3036; //抱月刀
  CM_TWNHIT = 3037; //狂风斩
  CM_TWINHIT = CM_TWNHIT;
  CM_PHHIT = 3038; //破魂斩

  CM_26HIT = 3026;
  CM_27HIT = 3027;
  CM_28HIT = 3028;
  CM_29HIT = 3029;

  CM_40HIT = 3040;
  CM_41HIT = 3041;
  CM_42HIT = 3042;
  CM_43HIT = 3043;



  CM_60HIT = 3060;
  CM_61HIT = 3061;
  CM_62HIT = 3062;
  CM_63HIT = 3063;
  CM_64HIT = 3064;
  CM_65HIT = 3065;


  CM_PKHIT = 3066;
  CM_KTHIT = 3067;
  CM_ZRJFHIT = 3068; //逐日剑法




  CM_100HIT = 3300; //三绝杀
  CM_101HIT = 3301; //追心刺
  CM_102HIT = 3302; //断岳斩
  CM_103HIT = 3303; //横扫千军







  CM_SAY = 3030;

  RM_10401 = 10401;

  STATE_STONE_MODE = 1;
  RM_MENU_OK = 10309;
  RM_MERCHANTDLGCLOSE = 10127;
  RM_SENDDELITEMLIST = 10148;
  RM_SENDUSERSREPAIR = 10141;
  RM_SENDGOODSLIST = 10128;
  RM_SENDUSERSELL = 10129;
  RM_SENDUSERREPAIR = 11139;
  RM_USERMAKEDRUGITEMLIST = 10149;
  RM_USERSTORAGEITEM = 10146;
  RM_USERGETBACKITEM = 10147;

  RM_USERBIGSTORAGEITEM = 20146;
  RM_USERBIGGETBACKITEM = 20147;
  RM_USERLEVELORDER = 20148;

  RM_SPACEMOVE_FIRE2 = 11330;
  RM_SPACEMOVE_FIRE = 11331;

  RM_BUYITEM_SUCCESS = 10133;
  RM_BUYITEM_FAIL = 10134;
  RM_SENDDETAILGOODSLIST = 10135;
  RM_SENDBUYPRICE = 10130;
  RM_USERSELLITEM_OK = 10131;
  RM_USERSELLITEM_FAIL = 10132;
  RM_MAKEDRUG_SUCCESS = 10150;
  RM_MAKEDRUG_FAIL = 10151;
  RM_SENDREPAIRCOST = 10142;
  RM_USERREPAIRITEM_OK = 10143;
  RM_USERREPAIRITEM_FAIL = 10144;

  MAXBAGITEM = 46;
  MAXHEROBAGITEM = 40; //英雄包裹
  RM_10155 = 10155;
  RM_PLAYDICE = 10500;
  RM_ADJUST_BONUS = 10400;

  RM_BUILDGUILD_OK = 10303;
  RM_BUILDGUILD_FAIL = 10304;
  RM_DONATE_OK = 10305;

  RM_GAMEGOLDCHANGED = 10666;

  STATE_OPENHEATH = 1;
  POISON_68 = 68;

  RM_MYSTATUS = 10777;

  CM_QUERYUSERSTATE = 82;

  CM_QUERYBAGITEMS = 81;

  CM_QUERYUSERSET = 49999;

  CM_OPENDOOR = 1002;
  CM_SOFTCLOSE = 1009;
  CM_1017 = 1017;
  CM_1042 = 1042;
  CM_GUILDALLY = 1044;
  CM_GUILDBREAKALLY = 1045;

  RM_HORSERUN = 11000;
  RM_HEAVYHIT = 10005;
  RM_BIGHIT = 10006;
  RM_MOVEFAIL = 10010;
  RM_CRSHIT = 11014;
  RM_RUSHKUNG = 11015;

  RM_41 = 41;
  RM_42 = 42;
  RM_43 = 43;
  RM_44 = 44;

  RM_60 = 60;
  RM_61 = 61;
  RM_62 = 62;
  RM_ZRJF = 77;

  RM_100HIT = 20100;
  RM_101HIT = 20101;
  RM_102HIT = 20102;
  RM_103HIT = 20103;
//  RM_101HITA = 20104;

  RM_MAGICFIREFAIL = 10121;
  RM_LAMPCHANGEDURA = 10138;
  RM_GROUPCANCEL = 10140;

  RM_DONATE_FAIL = 10306;

  RM_BREAKWEAPON = 10413;

  RM_PASSWORD = 10416;

  RM_PASSWORDSTATUS = 10601;

  SM_HORSERUN = 5;
  SM_716 = 716;
  SM_717 = 717;

  SM_PASSWORD = 3030;
  SM_PLAYDICE = 1200;

  SM_PASSWORDSTATUS = 20001;

  SM_GAMEGOLDNAME = 55; //游戏币名称

  SM_SERVERCONFIG = 20002;
  SM_GETREGINFO = 20003;

  ET_DIGOUTZOMBI = 1;
  ET_PILESTONES = 3;
  ET_HOLYCURTAIN = 4;
  ET_FIRE = 5;
  ET_SCULPEICE = 6;
{6种烟花}
  ET_FIREFLOWER_1 = 7;
  ET_FIREFLOWER_2 = 8;
  ET_FIREFLOWER_3 = 9;
  ET_FIREFLOWER_4 = 10;
  ET_FIREFLOWER_5 = 11;
  ET_FIREFLOWER_6 = 12;
  ET_FIREFLOWER_7 = 13;
  ET_FIREFLOWER_8 = 14;

  ET_MAGICLOCK = 15;
  ET_MAPMAGIC = 16;

{5种空间门}
  ET_SPACEDOOR_1 = 17;
  ET_SPACEDOOR_2 = 18;
  ET_SPACEDOOR_3 = 19;
  ET_SPACEDOOR_4 = 20;
  ET_SPACEDOOR_5 = 21;
  ET_SPACEDOOR_6 = 22;


  CM_PROTOCOL = 2000;
  CM_IDPASSWORD = 2001;
  CM_ADDNEWUSER = 2002;
  CM_CHANGEPASSWORD = 2003;
  CM_UPDATEUSER = 2004;
  CM_RANDOMCODE = 2006;
  SM_RANDOMCODE = 2007;


  CM_3037 = 3037;

  SM_NEEDPASSWORD = 8003;
  CM_POWERBLOCK = 0;

  //商铺相关
  CM_OPENSHOP = 9000;
  CM_BUYSHOPITEM = 9002;
  SM_BUYSHOPITEM_SUCCESS = 9003;
  SM_BUYSHOPITEM_FAIL = 9004;
  SM_SENGSHOPITEMS = 9001; // SERIES 7 每页的数量    wParam 总页数
  //==============================================================================
  CM_QUERYUSERLEVELSORT = 3500; //用户等级排行
  RM_QUERYUSERLEVELSORT = 35000;
  SM_QUERYUSERLEVELSORT = 2500;
  //==============================新增物品寄售系统==============================
  CM_SENDSELLOFFGOODSLIST = 20008; //查询寄售物品
  CM_SENDSEARCHSELLITEM = 20012; //指定物品名查询寄售物品
  CM_SENDGETSELLITEMGOLD = 20013; //指定物品名查询寄售物品
  RM_SENDSELLOFFGOODSLIST = 21008;
  SM_SENDSELLOFFGOODSLIST = 20008;
  RM_SENDUSERSELLOFFITEM = 21005;
  SM_SENDUSERSELLOFFITEM = 20005; //寄售物品
  RM_SENDSELLOFFITEMLIST = 22009; //查询得到的寄售物品
  CM_SENDSELLOFFITEMLIST = 20009; //查询得到的寄售物品
  RM_SENDBUYSELLOFFITEM_OK = 21010; //购买寄售物品成功
  SM_SENDBUYSELLOFFITEM_OK = 20010; //购买寄售物品成功
  RM_SENDBUYSELLOFFITEM_FAIL = 21011; //购买寄售物品失败
  SM_SENDBUYSELLOFFITEM_FAIL = 20011; //购买寄售物品失败
  RM_SENDBUYSELLOFFITEM = 41005; //购买选择寄售物品
  CM_SENDBUYSELLOFFITEM = 4005; //购买选择寄售物品
  RM_SENDQUERYSELLOFFITEM = 41006; //查询选择寄售物品
  CM_SENDQUERYSELLOFFITEM = 4006; //查询选择寄售物品
  RM_SENDSELLOFFITEM = 41004; //接受寄售物品
  CM_SENDSELLOFFITEM = 4004; //接受寄售物品
  RM_SENDUSERSELLOFFITEM_FAIL = 2007; //R = -3  寄售物品失败
  RM_SENDUSERSELLOFFITEM_OK = 2006; //寄售物品成功
  SM_SENDUSERSELLOFFITEM_FAIL = 20007; //R = -3  寄售物品失败
  SM_SENDUSERSELLOFFITEM_OK = 20006; //寄售物品成功




  RM_SENDSERVERCONFIG = 30011;

  RM_GETSELBOXITEMNUM = 30012;













  SM_USERCASTLE = 5100; //沙行会信息

  CM_ONHORSE = 5059;

  SM_SHOWITEMBOX = 5061;
  CM_OPENITEMBOX = 5062;
  SM_OPENITEMBOX_OK = 5063;
  SM_OPENITEMBOX_FAIL = 5064;
  CM_GETSELBOXITEMNUM = 5065;
  SM_GETSELBOXITEMNUM = 5066;
  CM_GETSELBOXITEM = 5067;

  RM_OPENBOOK = 30013;
  SM_OPENBOOK = 5068;
  RM_OPENITEMBOX = 30014;

  CM_SENDCHANGEITEM = 5069;
  SM_SENDCHANGEITEM_FAIL = 5070;
  SM_SENDCHANGEITEM_OK = 5071;
  SM_SENDCHANGEITEM = 5072;
  RM_SENDCHANGEITEM = 30015;
  RM_SENDCHANGEITEM_OK = 30016;
  RM_SENDCHANGEITEM_FAIL = 30017;




  CM_SENDUPGRADEITEM = 5073;
  SM_SENDUPGRADEITEM_FAIL = 5074;
  SM_SENDUPGRADEITEM_OK = 5075;

  CM_DUELTRY = 4078;
  CM_DUELADDITEM = 4079;
  CM_DUELDELITEM = 4080;
  CM_DUELCANCEL = 4081;
  CM_DUELCHGGOLD = 4082;
  CM_DUELEND = 4083;

  SM_DUELTRY_FAIL = 4084;
  SM_DUELMENU = 4085;
  SM_DUELCANCEL = 4086;
  SM_DUELADDITEM_OK = 4087;
  SM_DUELADDITEM_FAIL = 4088;
  SM_DUELDELITEM_OK = 4089;
  SM_DUELDELITEM_FAIL = 4090;
  SM_DUELREMOTEADDITEM = 4091;
  SM_DUELREMOTEDELITEM = 4092;
  SM_DUELCHGGOLD_OK = 4093;
  SM_DUELCHGGOLD_FAIL = 4094;
  SM_DUELREMOTECHGGOLD = 4095;
  SM_DUELSUCCESS = 4096;
  CM_GETREGINFO_OK = 4097;

  CM_HEROATTACK = 5097; //英雄挂机
  CM_GETBACKITEMBOX = 5098; //取回宝箱
  SM_GETBACKITEMBOX_OK = 5099; //取回宝箱成功
  SM_GETBACKITEMBOX_FAIL = 5100; //取回宝箱失败


  RM_QUERYBAGITEMS = 5101;
  RM_QUERYHEROBAGITEMS = 5102;

  RM_SAVEITEMLIST = 5103;

  SM_STATE_BUBBLEDEFENCEUP = 5104; //护体神盾
  RM_STATE_BUBBLEDEFENCEUP = 5105; //护体神盾

  CM_GETREGINFO = 5106;
  RM_SENDREGINFO = 5107;

  SM_SENDOPENHOMEPAGE = 5108;
  RM_SENDOPENHOMEPAGE = 5109;

  CM_SENDFINDITEMINFO = 5110;
  SM_SENDFINDITEMINFO_OK = 5111;
  SM_SENDFINDITEMINFO_FAIL = 5112;

  SM_SENDSNOW = 5113;

  SM_SENDSTORE = 5114; //摆摊状态
  CM_STARTSTORE = 5115; //开始摆摊
  CM_STOPSTORE = 5116; //停止摆摊
  CM_QUERYSTORE = 5117; //查询摆摊
  SM_DELSTOREITEM = 5118; //删除摆摊物品
  SM_USERSENDSTOREMSG = 5119; //用户输入的信息
  SM_USERSTOREITEMS = 5120; //用户摆摊物品
  CM_BUYSTOREITEM = 5121; //购买摆摊物品
  SM_SENDBUYSTOREITEM_OK = 5122; //购买成功
  SM_SENDBUYSTOREITEM_FAIL = 5123; //购买失败
  SM_SENDSTARTSTORE_OK = 5124; //摆摊成功
  SM_SENDSTOPSTORE_OK = 5125; //停止摆摊成功

  SM_SENDSTARTSTORE_FAIL = 5126; //摆摊失败

  RM_SENDSTORE = 5126; //摆摊状态

  SM_NEWSTATUS = 5127;

  SM_AUTOGOTOXY = 5128;
  SM_DELAYMESSAGE = 5129;
  SM_DELETEDELAYMESSAGE = 5130;




  //排行榜
  CM_GETRANKING = 5131;
  CM_GETMYRANKING = 5132;
  SM_SENGRANKING = 5133;
  SM_SENGMYRANKING_FAIL = 5134;

  ////////////////////////////////////////////////////////////////////////////////
  CM_HEROLOGON = 5135; //召唤英雄
  CM_HEROLOGOUT = 5136; //英雄退出


  CM_MASTERBAGTOHEROBAG = 5137; //主人包裹物品放到英雄包裹
  CM_HEROBAGTOMASTERBAG = 5138; //英雄包裹物品放到主人包裹



  CM_HEROTAKEONITEM = 5139; //英雄穿装备
  CM_HEROTAKEOFFITEM = 5140; //英雄脱装备

  CM_HEROTAKEONITEMFROMMASTER = 5141; //英雄穿装备从主人
  CM_HEROTAKEOFFITEMTOMASTER = 5142; //英雄脱装备到主人

  CM_TAKEONITEMFROMHERO = 5143; //主人穿装备从英雄包裹
  CM_TAKEOFFITEMTOHERO = 5144; //主人脱装备到英雄包裹


  CM_HEROEAT = 5145; //英雄吃药

  CM_HEROTARGET = 5146; //锁定//Ident: 1105 Recog: 260806992 Param: 0 Tag: 32 Series: 0   Recog= 锁定对象   Param=X  Tag=Y
  CM_HERODROPITEM = 5147; //英雄扔物品
  CM_HEROGROUPATTACK = 5148; //合击

  CM_HEROMAGICKEYCHANGE = 5149;


  //BLUE_READ_656 = 656;
  //BLUE_READ_657 = 657; //Ident: 657 Recog: 759418336 Param: 0 Tag: 32 Series: 0

  SM_MASTERBAGTOHEROBAG_OK = 5150; //主人包裹物品放到英雄包裹成功
  SM_MASTERBAGTOHEROBAG_FAIL = 5151; //主人包裹物品放到英雄包裹失败

  SM_HEROBAGTOMASTERBAG_OK = 5152; //英雄包裹物品放到主人包裹成功
  SM_HEROBAGTOMASTERBAG_FAIL = 5153; //英雄包裹物品放到主人包裹失败

  SM_HEROTAKEONITEMFROMMASTER_OK = 5154; //英雄穿装备从主人  成功
  SM_HEROTAKEONITEMFROMMASTER_FAIL = 5155; //英雄穿装备从主人 失败
  SM_HEROTAKEOFFITEMTOMASTER_OK = 5156; //英雄脱装备到主人   成功
  SM_HEROTAKEOFFITEMTOMASTER_FAIL = 5157; //英雄脱装备到主人  失败

  SM_TAKEONITEMFROMHERO_OK = 5158; //主人穿装备从英雄包裹   成功
  SM_TAKEONITEMFROMHERO_FAIL = 5159; //主人穿装备从英雄包裹 失败
  SM_TAKEOFFITEMTOHERO_OK = 5160; //主人脱装备到英雄包裹    成功
  SM_TAKEOFFITEMTOHERO_FAIL = 5161; //主人脱装备到英雄包裹  失败

  SM_HEROBAGCOUNT = 5162; //英雄包裹数量

  SM_HEROLOGOUT = 5163; //获取英雄 TMessageBodyWL 产生英雄退出效果
  SM_HEROLOGON = 5164; //获取英雄 TMessageBodyWL 产生英雄登陆效果

{  BLUE_READ_898 = 5165; //获取英雄忠诚  10001(忠00.00%)
  BLUE_READ_899 = 5166; //获取英雄信息  }

  SM_HEROABILITY = 5167; //获取英雄Abil
  SM_HEROSUBABILITY = 5168; //英雄SUBABILITY
  SM_HEROBAGITEMS = 5169; //获取英雄包裹     Tag:包裹物品数量 2 Series: 包裹总数量10
  SM_SENDHEROUSEITEMS = 5170; //获取英雄身上装备
  SM_SENDMYHEROMAGIC = 5171; //获取英雄魔法
  SM_HEROADDITEM = 5172; //英雄 Ident: 905 Recog: 738569296 Param: 0 Tag: 0 Series: 1   AddItem
  SM_HERODELITEM = 5173; //英雄 Ident: 906 Recog: 738569296 Param: 0 Tag: 0 Series: 1   delItem

  SM_HEROTAKEON_OK = 5174; //英雄穿装备OK Ident: 907 Recog: 742933632 Param: 0 Tag: 0 Series: 0
  SM_HEROTAKEON_FAIL = 5175; //英雄穿装备FAIL
  SM_HEROTAKEOFF_OK = 5176; //英雄脱装备OK
  SM_HEROTAKEOFF_FAIL = 5177; //英雄脱装备FAIL

  SM_HEROEAT_OK = 5178; //英雄吃药OK
  SM_HEROEAT_FAIL = 5179; //英雄吃药FAIL
  SM_HEROADDMAGIC = 5180; //英雄增加魔法
  SM_HERODELMAGIC = 5181; //英雄删除魔法

  SM_HEROANGERVALUE = 5182; //英雄怒值改变 Ident: 916 Recog: 5 Param: 2 Tag: 102 Series: 0
  SM_HEROLOGON_OK = 5183; // 英雄登陆OK
  SM_HEROLOGOUT_OK = 5184; // 英雄退出OK

  SM_HERODURACHANGE = 5185; //英雄物品持久改变
  SM_HERODROPITEM_SUCCESS = 5186; //英雄扔物品OK
  SM_HERODROPITEM_FAIL = 5187; //英雄扔物品FAIL

  SM_HEROLEVELUP = 5188; //英雄升级
  SM_HEROWINEXP = 5189; //英雄获取经验
  SM_HEROWEIGHTCHANGED = 5190;
  SM_HEROMAGIC_LVEXP = 5191; //英雄魔法经验
  SM_HEROCHANGEFACE = 5192;

  SM_HEROUPDATEITEM = 5193;
  SM_HERODELITEMS = 5194;
  SM_HEROCHANGEITEM = 5195;


  CM_REPAIRFIRDRAGON = 5196; //修理火龙之心
  SM_REPAIRFIRDRAGON_OK = 5197; //修理火龙之心 成功
  SM_REPAIRFIRDRAGON_FAIL = 5198; //修理火龙之心  失败

  SM_TAKEONITEM = 5199;
  SM_TAKEOFFITEM = 5200;
  SM_HEROTAKEONITEM = 5201;
  SM_HEROTAKEOFFITEM = 5202;

  CM_HEROLOGON_OK = 5203;

  CM_HEROPROTECT = 5204; //英雄守护

  CM_DOMAINNAME = 5205; //注册域名信息


  SM_CENTERMESSAGE = 5206;
  SM_PLAYSOUND = 5207;
  SM_VIBRATION = 5208;
  SM_OPENBIGDIALOGBOX = 5209;
  SM_CLOSEBIGDIALOGBOX = 5210;

  CM_STARTSERIESPELL = 5211; //开始连击
  CM_STOPSERIESPELL = 5212; //开始连击
  SM_STARTSERIESPELL_OK = 5213; //开始连击
  SM_STARTSERIESPELL_FAIL = 5214; //开始连击
  SM_BLASTHHIT = 5215; //爆击
  CM_QUERYHEROBAGITEMS = 5216; //查询英雄包裹
  SM_SENDCARTINFO = 5217;
  SM_DELCARTINFO = 5218;




  RM_HEROANGERVALUE = 30018;
  RM_MAKEGHOST = 30019;
  RM_CHANGETURN = 30020;
  RM_USERCASTLE = 30021;
  RM_SPELL3 = 30022;
  RM_HEROLOGOUT = 30023; //获取英雄 TMessageBodyWL 产生英雄退出效果
  RM_HEROLOGON = 30024; //获取英雄 TMessageBodyWL 产生英雄登陆效果
  RM_HEROLOGON_OK = 30025;
  RM_REFHEROLOGON = 30026;

  RM_TAKEONITEM = 30027;
  RM_TAKEOFFITEM = 30028;
  RM_HEROTAKEONITEM = 30029;
  RM_HEROTAKEOFFITEM = 30030;

  RM_HEROGROUP = 30031;
  RM_UNHEROGROUP = 30032;
  RM_PLAYSOUND = 30033;
  RM_VIBRATION = 30034;
  RM_OPENBIGDIALOGBOX = 30035;
  RM_CLOSEBIGDIALOGBOX = 30036;
  RM_BLASTHHIT = 30037; //爆击
  RM_SENDCARTINFO = 30038;
  RM_DELCARTINFO = 30039;
  RM_HEAR2 = 30040;
  ////////////////////////////////////////////////////////////////////////////////
  UNITX = 48;
  UNITY = 32;
  HALFX = 24;
  HALFY = 16;
  //MAXBAGITEM = 46; //用户背包最大数量
  MAXMAGIC = 30; //原来54;
  MAXSTORAGEITEM = 50;
  LOGICALMAPUNIT = 40;
////////////////////////////////////////////////////////////////////////////////
  LM_GETBLOCKIPLIST = 1000;
  LM_ADDBLOCKIPLIST = 1001;
  SM_BLOCKIPLIST = 1000;

type
  TNpcType = (n_Norm, n_Merchant);
  TObjType = (t_None, t_Actor, t_Item, t_Event, t_Gate, t_Switch, t_MapEvent, t_Door, t_Roon, t_MapMagicEvent);
  TClientAction = (cHit, cMagHit, crun, cWalk, cDigUp, cTurn);
  TGender = (gMan, gWoMan);
  TJob = (jWarr, jWizard, jTaos);
  TMonStatus = (s_KillHuman, s_UnderFire, s_Die, s_MonGen);
  TMsgColor = (c_Red, c_Green, c_Blue, c_White);
  TMsgType = (t_Notice, t_Hint, t_System, t_Say, t_Mon, t_GM, t_Cust, t_Castle);
  TVarType = (vNone, vInteger, vString);
  TVarAttr = (aNone, aFixStr, aDynamic, aConst);
  TOpenBoxStatus = (b_None, b_ShowBox, b_OpenBox, b_BoxIndex, b_ShowItem, b_GiveItem);
  TObjectType = (ty_None, ty_Object, ty_VarName, ty_Human, ty_MonGen, ty_Hero, ty_Master);

  TNewStatus = (sNone, sBlind, sConfusion); //失明 混乱 状态
  TSockData = (d_LoadHumData, d_SaveHumData, d_LoadHeroData, d_SaveHeroData, d_LoadRankingData, d_SaveData);
  THeroDataType = (l_Create, l_Delete, l_Load, l_Save);

  TCartInfo = record
    sCharName: string[ACTORNAMELEN];
    nRecogId, nX, nY: Integer;
  end;
  pTCartInfo = ^TCartInfo;
  TCartInfoArray = array of TCartInfo;

  TVarInfo = record
    VarType: TVarType;
    VarAttr: TVarAttr;
  end;
  pTVarInfo = ^TVarInfo;

  TDefaultMessage = record
    Recog: Integer;
    Ident: Word;
    Param: Word;
    Tag: Word;
    Series: Word;
  end;
  pTDefaultMessage = ^TDefaultMessage;

  TSendMessage = record
    wIdent: Word;
    wParam: Integer; //Word;
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
    BaseObject: TObject;
    dwAddTime: LongWord;
    dwDeliveryTime: LongWord;
    boLateDelivery: Boolean;
    Buff: PChar;
  end;
  pTSendMessage = ^TSendMessage;

  TProcessMessage = record
    wIdent: Word;
    wParam: Integer; //Word;
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
    BaseObject: TObject;
    boLateDelivery: Boolean;
    dwDeliveryTime: LongWord;
    sMsg: string;
  end;
  pTProcessMessage = ^TProcessMessage;

  TOLoadHuman = record
    sAccount: string[12];
    sChrName: string[ACTORNAMELEN];
    sUserAddr: string[15];
    nSessionID: Integer;
  end;

  TLoadHuman = record
    sAccount: string[ACCOUNTLEN];
    sChrName: string[ACTORNAMELEN];
    sUserAddr: string[15];
    nSessionID: Integer;
  end;

  TShortMessage = record
    Ident: Word;
    wMsg: Word;
  end;

  TMessageBodyW = record
    Param1: Word;
    Param2: Word;
    Tag1: Word;
    Tag2: Word;
  end;

  TMessageBodyWL = record
    lParam1: Integer;
    lParam2: Integer;
    lTag1: Integer;
    lTag2: Integer;
  end;

  TCharDesc = record
    feature: Integer;
    Status: Integer;
{$IF HEROVERSION = 1}
    Level: LongInt;
    HP: LongInt;
    MaxHP: LongInt;
    AddStatus: Integer;
{$IFEND}
  end;

  THealth = record
    HP: LongInt;
    MP: LongInt;
    MaxHP: LongInt;
  end;

  TVisibleMapItem = record
    btVisibleFlag: Byte;
    BaseObject: TObject;
    nX: Integer;
    nY: Integer;
    sName: string;
    wLooks: Word;
  end;
  pTVisibleMapItem = ^TVisibleMapItem;

  TVisibleMapEvent = record
    btVisibleFlag: Byte;
    BaseObject: TObject;
    nX: Integer;
    nY: Integer;
  end;
  pTVisibleMapEvent = ^TVisibleMapEvent;

  TVisibleBaseObject = record
    btVisibleFlag: Byte;
    BaseObject: TObject;
  end;
  pTVisibleBaseObject = ^TVisibleBaseObject;

  TOSessInfo = record //全局会话
    sAccount: string[12];
    sIPaddr: string[15];
    nSessionID: Integer;
    nPayMent: Integer;
    nPayMode: Integer;
    nSessionStatus: Integer;
    dwStartTick: LongWord;
    dwActiveTick: LongWord;
    dwMakeAccountTick: LongWord;
    nRefCount: Integer;
  end;
  pTOSessInfo = ^TOSessInfo;

  TSessInfo = record //全局会话
    //sAccount: string[ACCOUNTLEN];
    sAccount: string;
    sIPaddr: string[15];
    nSessionID: Integer;
    nPayMent: Integer;
    nPayMode: Integer;
    nSessionStatus: Integer;
    dwStartTick: LongWord;
    dwActiveTick: LongWord;
    dwMakeAccountTick: LongWord;
    nRefCount: Integer;
  end;
  pTSessInfo = ^TSessInfo;

  TQuestInfo = record
    wFlag: Word;
    btValue: Byte;
    nRandRage: Integer;
  end;
  pTQuestInfo = ^TQuestInfo;

  TScript = record
    boQuest: Boolean;
    QuestInfo: array[0..9] of TQuestInfo;
    nQuest: Integer;
    RecordList: TList;
  end;
  pTScript = ^TScript;

  TMonItem = record
    n00: Integer;
    n04: Integer;
    sMonName: string;
    n18: Integer;
  end;
  pTMonItem = ^TMonItem;

  TItemName = record
    nItemIndex: Integer;
    nMakeIndex: Integer;
    sItemName: string;
  end;
  pTItemName = ^TItemName;

  TDynamicVar = record
    sName: string;
    sFileName: string;
    VarType: TVarType;
    nInternet: Integer;
    sString: string;
  end;
  pTDynamicVar = ^TDynamicVar;

  TRecallMigic = record
    nHumLevel: Integer;
    sMonName: string;
    nCount: Integer;
    nLevel: Integer;
  end;

  TMonSayMsg = record
    nRate: Integer;
    sSayMsg: string;
    State: TMonStatus;
    Color: TMsgColor;
  end;
  pTMonSayMsg = ^TMonSayMsg;

  TMonDrop = record
    sItemName: string;
    nDropCount: Integer;
    nNoDropCount: Integer;
    nCountLimit: Integer;
  end;
  pTMonDrop = ^TMonDrop;

  TGameCmd = record
    sCmd: string[25];
    nPermissionMin: Integer;
    nPermissionMax: Integer;
  end;
  pTGameCmd = ^TGameCmd;

  TIPaddr = record
    dIPaddr: string[15];
    sIPaddr: string[15];
  end;
  pTIPAddr = ^TIPaddr;

  TSrvNetInfo = record
    sIPaddr: string[15];
    nPort: Integer;
  end;
  pTSrvNetInfo = ^TSrvNetInfo;

  TCheckCode = record
  end;

  TValue = array[0..13] of Byte;
  TValueA = array[0..1] of Byte;

  TStdItem = packed record
{$IF HEROVERSION = 1}
    Name: string[30];
{$ELSE}
    Name: string[14];
{$IFEND}
    StdMode: Byte;
    Shape: Byte;
    Weight: Byte;
    AniCount: Byte;
    Source: ShortInt;
    Reserved: Byte;
    NeedIdentify: Byte;
    Looks: Word;
    DuraMax: Word;
    Reserved1: Word;
    AC: Integer;
    MAC: Integer;
    DC: Integer;
    MC: Integer;
    SC: Integer;
    Need: Integer;
    NeedLevel: Integer;
    Price: Integer;
{$IF HEROVERSION = 1}
    AddValue: TValue;
    AddPoint: TValue;
    MaxDate: TDateTime;
    sDescr: string[40];
{$IFEND}
  end;
  pTStdItem = ^TStdItem;

  TOStdItem = packed record //OK
    Name: string[14];
    StdMode: Byte;
    Shape: Byte;
    Weight: Byte;
    AniCount: Byte;
    Source: ShortInt;
    Reserved: Byte;
    NeedIdentify: Byte;
    Looks: Word;
    DuraMax: Word;
    AC: Word;
    MAC: Word;
    DC: Word;
    MC: Word;
    SC: Word;
    Need: Byte;
    NeedLevel: Byte;
    w26: Word;
    Price: Integer;
  end;
  pTOStdItem = ^TOStdItem;

  TOClientItem = record //OK
    s: TOStdItem;
    MakeIndex: Integer;
    Dura: Word;
    DuraMax: Word;
  end;
  pTOClientItem = ^TOClientItem;

  TClientItem = record //OK
    s: TStdItem;
    MakeIndex: Integer;
    Dura: Word;
    DuraMax: Word;
  end;
  pTClientItem = ^TClientItem;

  TMonInfo = record
    sName: string[14];
    btRace: Byte;
    btRaceImg: Byte;
    wAppr: Word;
{$IF HEROVERSION = 1}
    wLevel: LongInt;
{$ELSE}
    wLevel: Word;
{$IFEND}
    btLifeAttrib: Byte;
    boUndead: Boolean;
    wCoolEye: Word;
    dwExp: LongWord;
{$IF HEROVERSION = 1}
    wMP: LongInt;
    wHP: LongInt;
{$ELSE}
    wMP: Word;
    wHP: Word;
{$IFEND}
    wAC: Word;
    wMAC: Word;
    wDC: Word;
    wMaxDC: Word;
    wMC: Word;
    wSC: Word;
    wSpeed: Word;
    wHitPoint: Word;
    wWalkSpeed: Word;
    wWalkStep: Word;
    wWalkWait: Word;
    wAttackSpeed: Word;
    ItemList: TList;
  end;
  pTMonInfo = ^TMonInfo;

  TMagic = record
    wMagicId: Word;
    sMagicName: string[30];
    btEffectType: Byte;
    btEffect: Byte;
    bt11: Byte;
    wSpell: Word;
    wPower: Word;
    TrainLevel: array[0..3] of Byte;
    w02: Word;
    MaxTrain: array[0..3] of Integer;
    btTrainLv: Byte;
    btJob: Byte;
    wMagicIdx: Word;
    dwDelayTime: LongWord;
    btDefSpell: Byte;
    btDefPower: Byte;
    wMaxPower: Word;
    btDefMaxPower: Byte;
    sDescr: string[18];
  end;
  pTMagic = ^TMagic;

  TClientMagic = record //84
    Key: Char;
    Level: Byte;
    CurTrain: Integer;
    Def: TMagic;
  end;
  PTClientMagic = ^TClientMagic;

  TUserMagic = record
    MagicInfo: pTMagic;
    wMagIdx: Word;
    btLevel: Byte;
    btKey: Byte;
    nTranPoint: Integer;
  end;
  pTUserMagic = ^TUserMagic;

  TMinMap = record
    sName: string;
    nID: Integer;
  end;
  pTMinMap = ^TMinMap;

  TMapRoute = record
    sSMapNO: string;
    nDMapX: Integer;
    nSMapY: Integer;
    sDMapNO: string;
    nSMapX: Integer;
    nDMapY: Integer;
  end;
  pTMapRoute = ^TMapRoute;

  TMapInfo = record
    sName: string;
    sMapNO: string;
    nL: Integer; //0x10
    nServerIndex: Integer; //0x24
    nNEEDONOFFFlag: Integer; //0x28
    boNEEDONOFFFlag: Boolean; //0x2C
    sShowName: string; //0x4C
    sReConnectMap: string; //0x50
    boSAFE: Boolean; //0x51
    boDARK: Boolean; //0x52
    boFIGHT: Boolean; //0x53
    boFIGHT3: Boolean; //0x54
    boDAY: Boolean; //0x55
    boQUIZ: Boolean; //0x56
    boNORECONNECT: Boolean; //0x57
    boNEEDHOLE: Boolean; //0x58
    boNORECALL: Boolean; //0x59
    boNORANDOMMOVE: Boolean; //0x5A
    boNODRUG: Boolean; //0x5B
    boMINE: Boolean; //0x5C
    boNOPOSITIONMOVE: Boolean; //0x5D
  end;
  pTMapInfo = ^TMapInfo;

  TUnbindInfo = record
    nUnbindCode: Integer;
    sItemName: string[14];
  end;
  pTUnbindInfo = ^TUnbindInfo;

  TQuestDiaryInfo = record
    QDDinfoList: TList;
  end;
  pTQuestDiaryInfo = ^TQuestDiaryInfo;

  TAdminInfo = record
    nLv: Integer;
    sChrName: string[ACTORNAMELEN];
    sIPaddr: string[15];
  end;
  pTAdminInfo = ^TAdminInfo;

  THumMagic = record
    wMagIdx: Word;
    btLevel: Byte;
    btKey: Byte;
    nTranPoint: Integer; //当前持久值
  end;
  pTHumMagic = ^THumMagic;

  TNakedAbility = packed record //Size 20
    DC: Word;
    MC: Word;
    SC: Word;
    AC: Word;
    MAC: Word;
    HP: Word;
    MP: Word;
    Hit: Word;
    Speed: Word;
    X2: Word;
  end;
  pTNakedAbility = ^TNakedAbility;

  {TNakedAbility = packed record //Size 20
    DC: Integer;
    MC: Integer;
    SC: Integer;
    AC: Integer;
    MAC: Integer;
    HP: Integer;
    MP: Integer;
    Hit: Integer;
    Speed: Integer;
    X2: Integer;
  end;
  pTNakedAbility = ^TNakedAbility; }

  {
  TAbility = packed record //OK    //Size 40
    Level: Word; //0x198  //0x34  0x00
    AC: Integer; //0x19A  //0x36  0x02
    MAC: Integer; //0x19C  //0x38  0x04
    DC: Integer; //0x19E  //0x3A  0x06
    MC: Integer; //0x1A0  //0x3C  0x08
    SC: Integer; //0x1A2  //0x3E  0x0A
    HP: Word; //0x1A4  //0x40  0x0C
    MP: Word; //0x1A6  //0x42  0x0E
    MaxHP: Word; //0x1A8  //0x44  0x10
    MaxMP: Word; //0x1AA  //0x46  0x12
    Exp: LongWord; //0x1B0  //0x4C 0x18
    MaxExp: LongWord; //0x1B4  //0x50 0x1C
    Weight: Word; //0x1B8   //0x54 0x20
    MaxWeight: Word; //0x1BA   //0x56 0x22  背包
    WearWeight: Word; //0x1BC   //0x58 0x24
    MaxWearWeight: Word; //0x1BD   //0x59 0x25  负重
    HandWeight: Word; //0x1BE   //0x5A 0x26
    MaxHandWeight: Word; //0x1BF   //0x5B 0x27  腕力
    ATOM_DC: array[1..7] of Word;
    ATOM_MC: array[1..7] of Word;
    ATOM_MAC: array[1..7] of Word;
  end;
  pTAbility = ^TAbility;
  }

  TAbility = packed record //OK    //Size 40
{$IF HEROVERSION = 1}
    Level: LongInt; //0x198  //0x34  0x00
{$ELSE}
    Level: Word; //0x198  //0x34  0x00
{$IFEND}
    AC: Integer; //0x19A  //0x36  0x02
    MAC: Integer; //0x19C  //0x38  0x04
    DC: Integer; //0x19E  //0x3A  0x06
    MC: Integer; //0x1A0  //0x3C  0x08
    SC: Integer; //0x1A2  //0x3E  0x0A
{$IF HEROVERSION = 1}
    HP: LongInt; //0x1A4  //0x40  0x0C
    MP: LongInt; //0x1A6  //0x42  0x0E
    MaxHP: LongInt; //0x1A8  //0x44  0x10
    MaxMP: LongInt; //0x1AA  //0x46  0x12
{$ELSE}
    HP: Word; //0x1A4  //0x40  0x0C
    MP: Word; //0x1A6  //0x42  0x0E
    MaxHP: Word; //0x1A8  //0x44  0x10
    MaxMP: Word; //0x1AA  //0x46  0x12
{$IFEND}
    Exp: LongWord; //0x1B0  //0x4C 0x18
    MaxExp: LongWord; //0x1B4  //0x50 0x1C
    Weight: Word; //0x1B8   //0x54 0x20
    MaxWeight: Word; //0x1BA   //0x56 0x22  背包
    WearWeight: Word; //0x1BC   //0x58 0x24
    MaxWearWeight: Word; //0x1BD   //0x59 0x25  负重
    HandWeight: Word; //0x1BE   //0x5A 0x26
    MaxHandWeight: Word; //0x1BF   //0x5B 0x27  腕力
    ATOM_DC: array[1..7] of Word;
    ATOM_MC: array[1..7] of Word;
    ATOM_MAC: array[1..7] of Word;
    MoveSpeed: Byte;
    AttackSpeed: Byte;
    AddPoint: array[0..13] of Byte;
  end;
  pTAbility = ^TAbility;

  TOAbility = packed record
{$IF HEROVERSION = 1}
    Level: LongInt; //0x198  //0x34  0x00
{$ELSE}
    Level: Word; //0x198  //0x34  0x00
{$IFEND}
    AC: Word;
    MAC: Word;
    DC: Word;
    MC: Word;
    SC: Word;
{$IF HEROVERSION = 1}
    HP: LongInt; //0x1A4  //0x40  0x0C
    MP: LongInt; //0x1A6  //0x42  0x0E
    MaxHP: LongInt; //0x1A8  //0x44  0x10
    MaxMP: LongInt; //0x1AA  //0x46  0x12
{$ELSE}
    HP: Word; //0x1A4  //0x40  0x0C
    MP: Word; //0x1A6  //0x42  0x0E
    MaxHP: Word; //0x1A8  //0x44  0x10
    MaxMP: Word; //0x1AA  //0x46  0x12
{$IFEND}
    btReserved1: Byte;
    btReserved2: Byte;
    btReserved3: Byte;
    btReserved4: Byte;
    Exp: LongWord;
    MaxExp: LongWord;
    Weight: Word;
    MaxWeight: Word; //背包
    WearWeight: Byte;
    MaxWearWeight: Byte; //负重
    HandWeight: Byte;
    MaxHandWeight: Byte; //腕力
  end;
  pTOAbility = ^TOAbility;

  THAbility = packed record
    Level: LongInt;
    AC: Word;
    MAC: Word;
    DC: Word;
    MC: Word;
    SC: Word;
    HP: LongInt;
    MP: LongInt;
    MaxHP: LongInt;
    MaxMP: LongInt;
    btReserved1: Byte;
    btReserved2: Byte;
    btReserved3: Byte;
    btReserved4: Byte;
    Exp: LongWord;
    MaxExp: LongWord;
    Weight: Word;
    MaxWeight: Word; //背包
    WearWeight: Byte;
    MaxWearWeight: Byte; //负重
    HandWeight: Byte;
    MaxHandWeight: Byte; //腕力
  end;
  pTHAbility = ^THAbility;

  TAddAbility = record //OK    //Size 40
{$IF HEROVERSION = 1}
    WHP: LongInt; //0x1A4  //0x40  0x0C
    WMP: LongInt; //0x1A6  //0x42  0x0E
{$ELSE}
    WHP: Word; //0x1A4  //0x40  0x0C
    WMP: Word; //0x1A6  //0x42  0x0E
{$IFEND}
    wHitPoint: Word;
    wSpeedPoint: Word;
    wAC: Integer;
    wMAC: Integer;
    wDC: Integer;
    wMC: Integer;
    wSC: Integer;
    bt1DF: Byte; //神圣
    bt035: Byte;
    wAntiPoison: Word;
    wPoisonRecover: Word;
    wHealthRecover: Word;
    wSpellRecover: Word;
    wAntiMagic: Word;
    btLuck: Byte;
    btUnLuck: Byte;
    nHitSpeed: Integer;
    btWeaponStrong: Byte;
    ATOM_DC: array[1..7] of Word;
    ATOM_MC: array[1..7] of Word;
    ATOM_MAC: array[1..7] of Word;
    MoveSpeed: Byte;
    AttackSpeed: Byte;
    AddPoint: array[0..13] of Byte;
  end;
  pTAddAbility = ^TAddAbility;

  TWAbility = record
    dwExp: LongWord; //怪物经验值(Dword)
    wHP: LongInt;
    wMP: LongInt;
    wMaxHP: LongInt;
    wMaxMP: LongInt;
  end;

  TMerchantInfo = record
    sScript: string[14];
    sMapName: string[14];
    nX: Integer;
    nY: Integer;
    sNPCName: string[40];
    nFace: Integer;
    nBody: Integer;
    boCastle: Boolean;
  end;
  pTMerchantInfo = ^TMerchantInfo;

  TSocketBuff = record
    Buffer: PChar;
    nLen: Integer;
  end;
  pTSocketBuff = ^TSocketBuff;

  TSendBuff = record
    nLen: Integer;
    Buffer: array[0..DATA_BUFSIZE - 1] of Char;
  end;
  pTSendBuff = ^TSendBuff;

  TOUserItem = packed record
    MakeIndex: Integer;
    wIndex: Word; //物品id
    Dura: Word; //当前持久值
    DuraMax: Word; //最大持久值
    btValue: TValue; //array[0..13] of Byte;
{$IF HEROVERSION = 1}
    AddValue: TValue; //12=装备发光(1,2,3)
    AddPoint: TValue; //1=新属性类型(1=物理伤害减少 2=魔法伤害减少 3=忽视目标防御 4=所有伤害反射 5=增加攻击伤害) 2=新属性值
    MaxDate: TDateTime; //3=物理防御增强 4=魔法防御增强 5=物理攻击增强 6=魔法攻击增强 7=道术攻击增强 8=增加进入失明状态 9=增加进入混乱状态 10=减少进入失明状态 11=减少进入混乱状态 12=移动加速 13=攻击加速
{$IFEND}
  end;
  pTOUserItem = ^TOUserItem;

 { TOHeroUserItem = packed record
    MakeIndex: Integer;
    wIndex: Word; //物品id
    Dura: Word; //当前持久值
    DuraMax: Word; //最大持久值
    btValue: TValue; //array[0..13] of Byte;
    AddValue: TValue;
    MaxDate: TDateTime;
  end;
  pTOHeroUserItem = ^TOHeroUserItem;}

  TUserItem = packed record
    MakeIndex: Integer;
    wIndex: Word; //物品id
    Dura: Word; //当前持久值
    DuraMax: Word; //最大持久值
    btValue: TValue; //array[0..13] of Byte;
{$IF HEROVERSION = 1}
    AddValue: TValue; //12=装备发光(1,2,3)
    AddPoint: TValue; //1=新属性类型(1=物理伤害减少 2=魔法伤害减少 3=忽视目标防御 4=所有伤害反射 5=增加攻击伤害) 2=新属性值
    btValue2: TValue; //3=物理防御增强 4=魔法防御增强 5=物理攻击增强 6=魔法攻击增强 7=道术攻击增强 8=增加进入失明状态 9=增加进入混乱状态 10=减少进入失明状态 11=减少进入混乱状态 12=移动加速 13=攻击加速
    MaxDate: TDateTime;
{$IFEND}
  end;
  pTUserItem = ^TUserItem;

  TOBigStorage = packed record //无限仓库数据结构
    boDelete: Boolean;
    sCharName: string[ACTORNAMELEN];
    SaveDateTime: TDateTime;
    UserItem: TOUserItem;
    nIndex: Integer;
  end;
  pTOBigStorage = ^TOBigStorage;

  TOSellOffInfo = packed record //Size 59    拍卖数据结构
    sCharName: string[ACTORNAMELEN];
    dSellDateTime: TDateTime;
    nSellGold: Integer;
    n: Integer;
    UserItem: TOUserItem;
    nIndex: Integer;
  end;
  pTOSellOffInfo = ^TOSellOffInfo;

   {
  TOHeroBigStorage = packed record //无限仓库数据结构
    boDelete: Boolean;
    sCharName: string[ACTORNAMELEN];
    SaveDateTime: TDateTime;
    UseItems: TOHeroUserItem;
    nIndex: Integer;
  end;
  pTOHeroBigStorage = ^TOHeroBigStorage;

  TOHeroSellOffInfo = packed record //Size 59    拍卖数据结构
    sCharName: string[ACTORNAMELEN];
    dSellDateTime: TDateTime;
    nSellGold: Integer;
    n: Integer;
    UseItems: TOHeroUserItem;
    nIndex: Integer;
  end;
  pTOHeroSellOffInfo = ^TOHeroSellOffInfo;  }

  TMonItemInfo = record
    SelPoint: Integer;
    MaxPoint: Integer;
    ItemName: string;
    Count: Integer;
  end;
  pTMonItemInfo = ^TMonItemInfo;

  TMonsterInfo = record
    Name: string;
    ItemList: TList;
  end;
  PTMonsterInfo = ^TMonsterInfo;

  TOHumanRcd = record
    sUserID: string[10];
    sCharName: string[14];
    btJob: Byte;
    btGender: Byte;
    btLevel: Byte;
    btHair: Byte;
    sMapName: string[16];
    btAttackMode: Byte;
    btIsAdmin: Byte;
    nX: Integer;
    nY: Integer;
    nGold: Integer;
    dwExp: LongWord;
  end;
  pTOHumanRcd = ^TOHumanRcd;


  THumanRcd = record
    sUserID: string[ACCOUNTLEN];
    sCharName: string[14];
    btJob: Byte;
    btGender: Byte;
    btLevel: Byte;
    btHair: Byte;
    sMapName: string[16];
    btAttackMode: Byte;
    btIsAdmin: Byte;
    nX: Integer;
    nY: Integer;
    nGold: Integer;
    dwExp: LongWord;
  end;
  pTHumanRcd = ^THumanRcd;

  TObjectFeature = record
    btGender: Byte;
    btWear: Byte;
    btHair: Byte;
    btWeapon: Byte;
  end;
  pTObjectFeature = ^TObjectFeature;

  TStatusInfo = record
    nStatus: Integer;
    dwStatusTime: LongWord;
    sm218: SmallInt;
    dwTime220: LongWord;
  end;

  TMsgHeader = record
    dwCode: LongWord;
    nSocket: Integer;
    wGSocketIdx: Word;
    wIdent: Word;
    wUserListIndex: Integer;
    nLength: Integer;
  end;
  pTMsgHeader = ^TMsgHeader;

  TUserInfo = record
    bo00: Boolean; //0x00
    bo01: Boolean; //0x01 ?
    bo02: Boolean; //0x02 ?
    bo03: Boolean; //0x03 ?
    n04: Integer; //0x0A ?
    n08: Integer; //0x0B ?
    bo0C: Boolean; //0x0C ?
    bo0D: Boolean; //0x0D
    bo0E: Boolean; //0x0E ?
    bo0F: Boolean; //0x0F ?
    n10: Integer; //0x10 ?
    n14: Integer; //0x14 ?
    n18: Integer; //0x18 ?
    sStr: string[20]; //0x1C
    nSocket: Integer; //0x34
    nGateIndex: Integer; //0x38
    n3C: Integer; //0x3C
    n40: Integer; //0x40 ?
    n44: Integer; //0x44
    List48: TList; //0x48
    Cert: TObject; //0x4C
    dwTime50: LongWord; //0x50
    bo54: Boolean; //0x54
  end;
  pTUserInfo = ^TUserInfo;

  TGlobaSessionInfo = record
    sAccount: string;
    sIPaddr: string;
    nSessionID: Integer;
    n24: Integer;
    bo28: Boolean;
    boLoadRcd: Boolean;
    boHeroLoadRcd: Boolean;
    boStartPlay: Boolean;
    dwAddTick: LongWord;
    dAddDate: TDateTime;
    boRandomCode: Boolean; //验证码是否通过
  end;
  pTGlobaSessionInfo = ^TGlobaSessionInfo;

  TUserStateInfo = record
    Feature: Integer;
    UserName: string[ACTORNAMELEN];
    NAMECOLOR: Integer;
    GuildName: string[ACTORNAMELEN];
    GuildRankName: string[16];
    UseItems: array[0..12] of TClientItem;
  end;
  pTUserStateInfo = ^TUserStateInfo;

  TSellOffHeader = record
    nItemCount: Integer;
  end;

  TSellOffInfo = packed record //Size 59    拍卖数据结构
    sCharName: string[ACTORNAMELEN];
    dSellDateTime: TDateTime;
    nSellGold: Integer;
    n: Integer;
    UserItem: TUserItem;
    nIndex: Integer;
  end;
  pTSellOffInfo = ^TSellOffInfo;

  TClientSellItem = packed record
    //boSelled: Boolean;
    sCharName: string[ACTORNAMELEN];
    dSellDateTime: TDateTime;
    SellItem: TClientItem;
  end;
  pTClientSellItem = ^TClientSellItem;

  TItemCount = Integer;

  TBigStorage = packed record //无限仓库数据结构
    boDelete: Boolean;
    sCharName: string[ACTORNAMELEN];
    SaveDateTime: TDateTime;
    UserItem: TUserItem;
    nIndex: Integer;
  end;
  pTBigStorage = ^TBigStorage;

  TODuelItem = packed record //挑战
    boFinish: Boolean; //挑战完成
    boDelete: Boolean;
    btDuel: Byte;
    sOwnerName: string[ACTORNAMELEN];
    sDuelName: string[ACTORNAMELEN];
    UserItem: TOUserItem;
    n01: Integer;
    n02: Integer;
    nIndex: Integer;
  end;
  pTODuelItem = ^TODuelItem;


  TDuelItem = packed record //挑战
    boFinish: Boolean; //挑战完成
    boDelete: Boolean;
    btDuel: Byte;
    sOwnerName: string[ACTORNAMELEN];
    sDuelName: string[ACTORNAMELEN];
    UserItem: TUserItem;
    n01: Integer;
    n02: Integer;
    nIndex: Integer;
  end;
  pTDuelItem = ^TDuelItem;

  TDuel = packed record //挑战
    boDelete: Boolean;
    boVictory: Boolean; //胜利
    sCharName: string[ACTORNAMELEN];
    nDuelGold: Integer;
    nItemCount: Integer;
    n01: Integer;
    n02: Integer;
  end;
  pTDuel = ^TDuel;

  TDuelInfo = packed record //挑战
    boDelete: Boolean;
    btDuel: Byte;
    SaveDateTime: TDateTime;
    Owner: TDuel; //主动挑战人
    Duel: TDuel; //被动挑战人
    boFinish: Boolean; //挑战完成
    n03: Integer;
    n04: Integer;
    nIndex: Integer;
  end;
  pTDuelInfo = ^TDuelInfo;

  //摆摊
  TItemIndex = record
    btSellType: Byte; //0金币 1元宝 2声望 3能量
    ItemName: string[30];
    MakeIndex: Integer;
    Price: Integer;
  end;
  pTItemIndex = ^TItemIndex;

  TItemIndexs = array[0..14] of TItemIndex;
  pTItemIndexs = ^TItemIndexs;


  TOStoreServerItem = record
    btSellType: Byte; //0金币 1元宝 2声望 3能量
    Price: Integer;
    UserItem: TOUserItem;
  end;
  pTOStoreServerItem = ^TOStoreServerItem;

  TOStoreItem = record
    btSellType: Byte; //0金币 1元宝 2声望 3能量
    Item: TClientItem;
  end;
  pTOStoreItem = ^TOStoreItem;

  TOUserStoreStateInfo = record
    RecogId: Integer;
    UserName: string[30];
    NAMECOLOR: Integer;
    SellMsg: string[30];
    UseItems: array[0..14] of TOStoreItem;
  end;
  pTOUserStoreStateInfo = ^TOUserStoreStateInfo;


  TStoreServerItem = record
    btSellType: Byte; //0金币 1元宝 2声望 3能量
    Price: Integer;
    UserItem: TUserItem;
  end;
  pTStoreServerItem = ^TStoreServerItem;

  TStoreItem = record
    btSellType: Byte; //0金币 1元宝 2声望 3能量
    Item: TClientItem;
  end;
  pTStoreItem = ^TStoreItem;

  TUserStoreStateInfo = record
    RecogId: Integer;
    UserName: string[30];
    NAMECOLOR: Integer;
    SellMsg: string[30];
    UseItems: array[0..14] of TStoreItem;
  end;
  pTUserStoreStateInfo = ^TUserStoreStateInfo;


  TBindItemFile = record
    btItemType: Byte;
    sItemName: string;
    sBindItemName: string;
  end;
  pTBindItemFile = ^TBindItemFile;

  TBindItem = record
    sUnbindItemName: string[ACTORNAMELEN];
    nStdMode: Integer;
    nShape: Integer;
    btItemType: Byte;
  end;
  pTBindItem = ^TBindItem;

  TOUserStateInfo = packed record //OK
    feature: Integer;
    UserName: string[15]; // 15
    GuildName: string[14]; //14
    GuildRankName: string[16]; //15
    NAMECOLOR: Word;
    UseItems: array[0..8] of TOClientItem;
  end;

  TOIDRecordHeader = packed record
    boDeleted: Boolean;
    bt1: Byte;
    bt2: Byte;
    bt3: Byte;
    CreateDate: TDateTime;
    UpdateDate: TDateTime;
    sAccount: string[11];
  end;
  pTOIDRecordHeader = ^TOIDRecordHeader;

  TIDRecordHeader = packed record
    boDeleted: Boolean;
    bt1: Byte;
    bt2: Byte;
    bt3: Byte;
    CreateDate: TDateTime;
    UpdateDate: TDateTime;
    sAccount: string[ACCOUNTLEN];
  end;
  pTIDRecordHeader = ^TIDRecordHeader;

  TRecordHeader = packed record //Size 12
    boDeleted: Boolean;
    nSelectID: Byte;
    boIsHero: Boolean;
    bt2: Byte;
    dCreateDate: TDateTime; //创建时间
    sName: string[15]; //0x15  //角色名称   28
  end;
  pTRecordHeader = ^TRecordHeader;


  TOHumInfo = packed record //Size 72
    Header: TRecordHeader;
    sChrName: string[14]; //0x14  //角色名称   44
    sAccount: string[10]; //账号
    boDeleted: Boolean; //是否删除
    boIsHero: Boolean;
    dModDate: TDateTime;
    btCount: Byte; //操作计次
    boSelected: Boolean; //是否选择
    n6: array[0..5] of Byte;
  end;
  pTOHumInfo = ^TOHumInfo;

  THumInfo = packed record //Size 72
    Header: TRecordHeader;
    sChrName: string[14]; //0x14  //角色名称   44
    sAccount: string[ACCOUNTLEN]; //账号
    boDeleted: Boolean; //是否删除
    boIsHero: Boolean;
    dModDate: TDateTime;
    btCount: Byte; //操作计次
    boSelected: Boolean; //是否选择
    n6: array[0..5] of Byte;
  end;
  pTHumInfo = ^THumInfo;



  TIdxRecord = record
    sChrName: string[15];
    nIndex: Integer;
  end;
  pTIdxRecord = ^TIdxRecord;

  TBagItemNames = array[0..46 - 1] of string[16];
  pBagTItemNames = ^TBagItemNames;


  TUseItemNames = array[0..12] of string[16];
  pTUseItemNames = ^TUseItemNames;

  TUnKnow = array[0..35] of Byte;

  TAddByte = array[0..16] of Byte;

  TQuestUnit = array[0..127] of Byte;
  TQuestFlag = array[0..127] of Byte;
  TStatusTime = array[0..MAX_STATUS_ATTRIBUTE - 1] of Word;

  TOHumItems = array[0..8] of TOUserItem;
  TOHumAddItems = array[9..12] of TOUserItem;
  TOBagItems = array[0..45] of TOUserItem;
  TOStorageItems = array[0..45] of TOUserItem;
  TOHumanUseItems = array[0..12] of TOUserItem;
  TOHumMagics = array[0..19] of THumMagic;


  {TOHeroHumItems = array[0..8] of TOHeroUserItem;
  TOHeroHumAddItems = array[9..12] of TOHeroUserItem;
  TOHeroBagItems = array[0..45] of TOHeroUserItem;
  TOHeroStorageItems = array[0..45] of TOHeroUserItem;
  TOHeroHumanUseItems = array[0..12] of TOHeroUserItem; }

  THumItems = array[0..8] of TUserItem;
  THumAddItems = array[9..12] of TUserItem;
  TBagItems = array[0..45] of TUserItem;
  TStorageItems = array[0..45] of TUserItem;
  THumMagics = array[0..29] of THumMagic;
  THumanUseItems = array[0..12] of TUserItem;
  THeroItems = array[0..12] of TUserItem;
  THeroBagItems = array[0..40 - 1] of TUserItem;
  pTHumanUseItems = ^THumanUseItems;

  pTHeroItems = ^THeroItems;
  pTHumItems = ^THumItems;
  pTBagItems = ^TBagItems;
  pTStorageItems = ^TStorageItems;
  pTHumAddItems = ^THumAddItems;
  pTHumMagics = ^THumMagics;
  pTHeroBagItems = ^THeroBagItems;

  pTOHumItems = ^TOHumItems;
  pTOBagItems = ^TOBagItems;
  pTOStorageItems = ^TOStorageItems;
  pTOHumAddItems = ^TOHumAddItems;

  pTOHumMagics = ^TOHumMagics;

  {
  pTOHeroHumItems = ^TOHeroHumItems;
  pTOHeroBagItems = ^TOHeroBagItems;
  pTOHeroStorageItems = ^TOHeroStorageItems;
  pTOHeroHumAddItems = ^TOHeroHumAddItems;}

   {
  TData = packed record //Size = 3164
    sChrName: string[ACTORNAMELEN];
    sCurMap: string[MAPNAMELEN];
    wCurX: Word;
    wCurY: Word;
    btDir: Byte;
    btHair: Byte;
    btSex: Byte;
    btJob: Byte;
    nGold: Integer;
    Abil: TOAbility; //+40
    wStatusTimeArr: TStatusTime; //+24
    sHomeMap: string[MAPNAMELEN];
    btUnKnow1: Byte;
    wHomeX: Word;
    wHomeY: Word;
    sDearName: string[ACTORNAMELEN];
    sMasterName: string[ACTORNAMELEN];
    boMaster: Boolean;
    btCreditPoint: Byte;
    btDivorce: Byte; //是否结婚
    btMarryCount: Byte; //结婚次数
    sStoragePwd: string[7];
    btReLevel: Byte;
    boOnHorse: Boolean;
    btUnKnow2: array[0..1] of Byte;
    BonusAbil: TNakedAbility; //+20
    nBonusPoint: Integer;
    nGameGold: Integer;
    nGamePoint: Integer;
    nPayMentPoint: Integer; //充值点
    n: Integer;
    nPKPOINT: Integer;
    btAllowGroup: Byte;
    btF9: Byte;
    btAttatckMode: Byte;
    btIncHealth: Byte;
    btIncSpell: Byte;
    btIncHealing: Byte;
    btFightZoneDieCount: Byte;
    sAccount: string[10];
    btEE: Byte;
    btEF: Byte;
    boLockLogon: Boolean;
    wContribution: Word;
    nHungerStatus: Integer;
    boAllowGuildReCall: Boolean; //  是否允许行会合一
    wGroupRcallTime: Word; //队传送时间
    dBodyLuck: Double; //幸运度  8
    boAllowGroupReCall: Boolean; // 是否允许天地合一
    nEXPRATE: Integer; //经验倍数
    nExpTime: Integer; //经验倍数时间
    btLastOutStatus: Byte; //2006-01-12增加 退出状态 1为死亡退出
    wMasterCount: Word; //出师徒弟数
    boHasHero: Boolean; //是否有英雄
    boIsHero: Boolean; //是否是英雄
    btStatus: Byte; //状态
    sHeroChrName: string[ACTORNAMELEN];
    nGrudge: Integer;

    UnKnow: TUnKnow;
    QuestFlag: TQuestFlag; //脚本变量
  end;
  pTData = ^TData;  }

{$IF HEROVERSION = 1}
  THumData = packed record //Size = 3164
    sChrName: string[ACTORNAMELEN];
    sCurMap: string[MAPNAMELEN];
    wCurX: Word;
    wCurY: Word;
    btDir: Byte;
    btHair: Byte;
    btSex: Byte;
    btJob: Byte;
    nGold: Integer;
    Abil: TOAbility; //+40
    wStatusTimeArr: TStatusTime; //+24
    sHomeMap: string[MAPNAMELEN];
    wHomeX: Word;
    wHomeY: Word;
    sDearName: string[ACTORNAMELEN];
    sMasterName: string[ACTORNAMELEN];
    boMaster: Boolean;
    btCreditPoint: Integer;
    btDivorce: Byte; //是否结婚
    btMarryCount: Byte; //结婚次数
    sStoragePwd: string[7];
    btReLevel: Byte;
    boOnHorse: Boolean;
    BonusAbil: TNakedAbility; //+20
    nBonusPoint: Integer;
    nGameGold: Integer;
    nGamePoint: Integer;
    nGameDiamond: Integer; //金刚石
    nGameGird: Integer; //灵符
    nGameGlory: Integer; //荣誉
    nPayMentPoint: Integer; //充值点
    nPKPOINT: Integer;
    btAllowGroup: Byte;
    btF9: Byte;
    btAttatckMode: Byte;
    btIncHealth: Byte;
    btIncSpell: Byte;
    btIncHealing: Byte;
    btFightZoneDieCount: Byte;
    sAccount: string[ACCOUNTLEN];
    btEE: Byte;
    btEF: Byte;
    boLockLogon: Boolean;
    wContribution: Word;
    nHungerStatus: Integer;
    boAllowGuildReCall: Boolean; //  是否允许行会合一
    wGroupRcallTime: Word; //队传送时间
    dBodyLuck: Double; //幸运度  8
    boAllowGroupReCall: Boolean; // 是否允许天地合一
    nEXPRATE: Integer; //经验倍数
    nExpTime: Integer; //经验倍数时间
    btLastOutStatus: Byte; //2006-01-12增加 退出状态 1为死亡退出
    wMasterCount: Word; //出师徒弟数
    boHasHero: Boolean; //是否有英雄
    boIsHero: Boolean; //是否是英雄
    btStatus: Byte; //状态
    sHeroChrName: string[ACTORNAMELEN];
    nGrudge: Integer;
    QuestFlag: TQuestFlag; //脚本变量
    NewStatus: TNewStatus; //1失明 2混乱 状态
    wStatusDelayTime: Word; //失明混乱时间
    AddByte: TAddByte;
    HumItems: THumItems; //9格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
    BagItems: TBagItems; //包裹装备
    HumMagics: THumMagics; //魔法
    StorageItems: TStorageItems; //仓库物品
    HumAddItems: THumAddItems; //新增4格 护身符 腰带 鞋子 宝石
  end;
  pTHumData = ^THumData;
{$ELSE}
  THumData = packed record //Size = 3164
    sChrName: string[ACTORNAMELEN];
    sCurMap: string[MAPNAMELEN];
    wCurX: Word;
    wCurY: Word;
    btDir: Byte;
    btHair: Byte;
    btSex: Byte;
    btJob: Byte;
    nGold: Integer;
    Abil: TOAbility; //+40
    wStatusTimeArr: TStatusTime; //+24
    sHomeMap: string[MAPNAMELEN];
    //btUnKnow1: Byte;
    wHomeX: Word;
    wHomeY: Word;
    sDearName: string[ACTORNAMELEN];
    sMasterName: string[ACTORNAMELEN];
    boMaster: Boolean;
    btCreditPoint: Byte;
    btDivorce: Byte; //是否结婚
    btMarryCount: Byte; //结婚次数
    sStoragePwd: string[7];
    btReLevel: Byte;
    boOnHorse: Boolean;
    //btUnKnow2: array[0..1] of Byte;
    BonusAbil: TNakedAbility; //+20
    nBonusPoint: Integer;
    nGameGold: Integer;
    nGamePoint: Integer;
    nPayMentPoint: Integer; //充值点
    n: Integer;
    nPKPOINT: Integer;
    btAllowGroup: Byte;
    btF9: Byte;
    btAttatckMode: Byte;
    btIncHealth: Byte;
    btIncSpell: Byte;
    btIncHealing: Byte;
    btFightZoneDieCount: Byte;
    sAccount: string[10];
    btEE: Byte;
    btEF: Byte;
    boLockLogon: Boolean;
    wContribution: Word;
    nHungerStatus: Integer;
    boAllowGuildReCall: Boolean; //  是否允许行会合一
    wGroupRcallTime: Word; //队传送时间
    dBodyLuck: Double; //幸运度  8
    boAllowGroupReCall: Boolean; // 是否允许天地合一
    nEXPRATE: Integer; //经验倍数
    nExpTime: Integer; //经验倍数时间
    btLastOutStatus: Byte; //2006-01-12增加 退出状态 1为死亡退出
    wMasterCount: Word; //出师徒弟数
    boHasHero: Boolean; //是否有英雄
    boIsHero: Boolean; //是否是英雄
    btStatus: Byte; //状态
    sHeroChrName: string[ACTORNAMELEN];
    nGrudge: Integer;
    //UnKnow: TUnKnow;
    QuestFlag: TQuestFlag; //脚本变量

    HumItems: THumItems; //9格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
    BagItems: TBagItems; //包裹装备
    HumMagics: THumMagics; //魔法
    StorageItems: TStorageItems; //仓库物品
    HumAddItems: THumAddItems; //新增4格 护身符 腰带 鞋子 宝石
  end;
  pTHumData = ^THumData;
{$IFEND}

 { TOHeroHumData = packed record //Size = 3164
    sChrName: string[ACTORNAMELEN];
    sCurMap: string[MAPNAMELEN];
    wCurX: Word;
    wCurY: Word;
    btDir: Byte;
    btHair: Byte;
    btSex: Byte;
    btJob: Byte;
    nGold: Integer;
    Abil: TOAbility; //+40
    wStatusTimeArr: TStatusTime; //+24
    sHomeMap: string[MAPNAMELEN];
    btUnKnow1: Byte;
    wHomeX: Word;
    wHomeY: Word;
    sDearName: string[ACTORNAMELEN];
    sMasterName: string[ACTORNAMELEN];
    boMaster: Boolean;
    btCreditPoint: Byte;
    btDivorce: Byte; //是否结婚
    btMarryCount: Byte; //结婚次数
    sStoragePwd: string[7];
    btReLevel: Byte;
    boOnHorse: Boolean;
    btUnKnow2: array[0..1] of Byte;
    BonusAbil: TNakedAbility; //+20
    nBonusPoint: Integer;
    nGameGold: Integer;
    nGamePoint: Integer;
    nPayMentPoint: Integer; //充值点
    n: Integer;
    nPKPOINT: Integer;
    btAllowGroup: Byte;
    btF9: Byte;
    btAttatckMode: Byte;
    btIncHealth: Byte;
    btIncSpell: Byte;
    btIncHealing: Byte;
    btFightZoneDieCount: Byte;
    sAccount: string[10];
    btEE: Byte;
    btEF: Byte;
    boLockLogon: Boolean;
    wContribution: Word;
    nHungerStatus: Integer;
    boAllowGuildReCall: Boolean; //  是否允许行会合一
    wGroupRcallTime: Word; //队传送时间
    dBodyLuck: Double; //幸运度  8
    boAllowGroupReCall: Boolean; // 是否允许天地合一
    nEXPRATE: Integer; //经验倍数
    nExpTime: Integer; //经验倍数时间
    btLastOutStatus: Byte; //2006-01-12增加 退出状态 1为死亡退出
    wMasterCount: Word; //出师徒弟数
    boHasHero: Boolean; //是否有英雄
    boIsHero: Boolean; //是否是英雄
    btStatus: Byte; //状态
    sHeroChrName: string[ACTORNAMELEN];
    nGrudge: Integer;
    UnKnow: TUnKnow;
    QuestFlag: TQuestFlag; //脚本变量

    HumItems: TOHeroHumItems; //9格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
    BagItems: TOHeroBagItems; //包裹装备
    HumMagics: THumMagics; //魔法
    StorageItems: TOHeroStorageItems; //仓库物品
    HumAddItems: TOHeroHumAddItems; //新增4格 护身符 腰带 鞋子 宝石
  end;
  pTOHeroHumData = ^TOHeroHumData; }


  TOHumData = packed record //Size = 3164
    sChrName: string[ACTORNAMELEN];
    sCurMap: string[MAPNAMELEN];
    wCurX: Word;
    wCurY: Word;
    btDir: Byte;
    btHair: Byte;
    btSex: Byte;
    btJob: Byte;
    nGold: Integer;
    Abil: TOAbility; //+40
    wStatusTimeArr: TStatusTime; //+24
    sHomeMap: string[MAPNAMELEN];
    wHomeX: Word;
    wHomeY: Word;
    sDearName: string[ACTORNAMELEN];
    sMasterName: string[ACTORNAMELEN];
    boMaster: Boolean;
    btCreditPoint: Integer;
    btDivorce: Byte; //是否结婚
    btMarryCount: Byte; //结婚次数
    sStoragePwd: string[7];
    btReLevel: Byte;
    boOnHorse: Boolean;
    BonusAbil: TNakedAbility; //+20
    nBonusPoint: Integer;
    nGameGold: Integer;
    nGamePoint: Integer;
    nPayMentPoint: Integer; //充值点
    nPKPOINT: Integer;
    btAllowGroup: Byte;
    btF9: Byte;
    btAttatckMode: Byte;
    btIncHealth: Byte;
    btIncSpell: Byte;
    btIncHealing: Byte;
    btFightZoneDieCount: Byte;
    sAccount: string[10];
    btEE: Byte;
    btEF: Byte;
    boLockLogon: Boolean;
    wContribution: Word;
    nHungerStatus: Integer;
    boAllowGuildReCall: Boolean; //  是否允许行会合一
    wGroupRcallTime: Word; //队传送时间
    dBodyLuck: Double; //幸运度  8
    boAllowGroupReCall: Boolean; // 是否允许天地合一
    nEXPRATE: Integer; //经验倍数
    nExpTime: Integer; //经验倍数时间
    btLastOutStatus: Byte; //2006-01-12增加 退出状态 1为死亡退出
    wMasterCount: Word; //出师徒弟数
    boHasHero: Boolean; //是否有英雄
    boIsHero: Boolean; //是否是英雄
    btStatus: Byte; //状态
    sHeroChrName: string[ACTORNAMELEN];
    nGrudge: Integer;
    QuestFlag: TQuestFlag; //脚本变量
    NewStatus: TNewStatus; //1失明 2混乱 状态
    wStatusDelayTime: Word; //失明混乱时间
    AddByte: TAddByte;
    HumItems: TOHumItems; //9格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
    BagItems: TOBagItems; //包裹装备
    HumMagics: TOHumMagics; //魔法
    StorageItems: TOStorageItems; //仓库物品
    HumAddItems: TOHumAddItems; //新增4格 护身符 腰带 鞋子 宝石
  end;
  pTOHumData = ^TOHumData;


  THumDataInfo = packed record //Size 3164
    Header: TRecordHeader;
    Data: THumData;
  end;
  pTHumDataInfo = ^THumDataInfo;

  TOHumDataInfo = packed record //Size 3164
    Header: TRecordHeader;
    Data: TOHumData;
  end;
  pTOHumDataInfo = ^TOHumDataInfo;

  {TOHeroHumDataInfo = packed record //Size 3164
    Header: TRecordHeader;
    Data: TOHeroHumData;
  end;
  pTOHeroHumDataInfo = ^TOHeroHumDataInfo;    }


  TSaveRcd = record
    sAccount: string[ACCOUNTLEN];
    sChrName: string[ACTORNAMELEN];
    nSessionID: Integer;
    nReTryCount: Integer;
    dwSaveTick: LongWord; //2006-11-12 增加 保存错误下次保存TICK
    PlayObject: TObject;
    HumanRcd: THumDataInfo;
  end;
  pTSaveRcd = ^TSaveRcd;

  TLoadDBInfo = record
    sAccount: string[ACCOUNTLEN];
    sCharName: string[ACTORNAMELEN];
    sIPaddr: string[15];
    sMsg: string;
    nSessionID: Integer;
    nSoftVersionDate: Integer;
    nPayMent: Integer;
    nPayMode: Integer;
    nSocket: Integer;
    nGSocketIdx: Integer;
    nGateIdx: Integer;
    boClinetFlag: Boolean;
    dwNewUserTick: LongWord;
    PlayObject: TObject;
    nReLoadCount: Integer;
    boHeroVersion: Boolean;
    HeroData: THeroDataType;
    NPC: TObject;
  end;
  pTLoadDBInfo = ^TLoadDBInfo;
  {
  TLoadDBInfo = record
    sAccount: string[12];
    sCharName: string[ACTORNAMELEN];
    sIPaddr: string[15];
    sMsg: string;
    nSessionID: Integer;
    nSoftVersionDate: Integer;
    nPayMent: Integer;
    nPayMode: Integer;
    nSocket: Integer;
    nGSocketIdx: Integer;
    nGateIdx: Integer;
    boClinetFlag: Boolean;
    dwNewUserTick: LongWord;
    PlayObject: TObject;
    nReLoadCount: Integer;
    boIsHero: Boolean;
    btLoadDBType: Byte;
    boHeroVersion: Boolean;
  end;
  pTLoadDBInfo = ^TLoadDBInfo;
  }

  {TUserOpenInfo = record
    sAccount: string[12];
    sChrName: string[ACTORNAMELEN];
    LoadUser: TLoadDBInfo;
    HumanRcd: THumDataInfo;
    nOpenStatus: Integer;
  end;
  pTUserOpenInfo = ^TUserOpenInfo; }

  TUserOpenInfo = record
    sAccount: string[ACCOUNTLEN];
    sChrName: string[ACTORNAMELEN];
    LoadUser: TLoadDBInfo;
    HumanRcd: THumDataInfo;
    nResult: Integer;
    NPC: TObject;
  end;
  pTUserOpenInfo = ^TUserOpenInfo;

  TLoadUser = record
    sAccount: string[ACCOUNTLEN];
    sChrName: string[ACTORNAMELEN];
    sIPaddr: string[15];
    nSessionID: Integer;
    nSocket: Integer;
    nGateIdx: Integer;
    nGSocketIdx: Integer;
    nPayMent: Integer;
    nPayMode: Integer;
    dwNewUserTick: LongWord;
    nSoftVersionDate: Integer;
  end;
  pTLoadUser = ^TLoadUser;

  TDoorStatus = record
    bo01: Boolean;
    boOpened: Boolean;
    dwOpenTick: LongWord;
    nRefCount: Integer;
    n04: Integer;
  end;
  pTDoorStatus = ^TDoorStatus;

 {
  TDoorInfo = record
    nX: Integer;
    nY: Integer;
    n08: Integer;
    Status: pTDoorStatus;
  end;
  pTDoorInfo = ^TDoorInfo;
 }

  TSlaveInfo = record
    sSalveName: string;
    btSalveLevel: Byte;
    btSlaveExpLevel: Byte;
    dwRoyaltySec: LongWord;
    nKillCount: Integer;
    nHP: Integer;
    nMP: Integer;
  end;
  pTSlaveInfo = ^TSlaveInfo;

  TSwitchDataInfo = record
    sChrName: string[ACTORNAMELEN];
    sMAP: string[MAPNAMELEN];
    wX: Word;
    wY: Word;
    Abil: TAbility;
    nCode: Integer;
    boC70: Boolean;
    boBanShout: Boolean;
    boHearWhisper: Boolean;
    boBanGuildChat: Boolean;
    boAdminMode: Boolean;
    boObMode: Boolean;
    BlockWhisperArr: array[0..5] of string;
    SlaveArr: array[0..10] of TSlaveInfo;
    StatusValue: array[0..5] of Word;
    StatusTimeOut: array[0..5] of LongWord;
  end;
  pTSwitchDataInfo = ^TSwitchDataInfo;

  TChangeType = (t_Gold, t_GameGold, t_GamePoint, t_GameDiamond);
  TGoldChangeInfo = record
    ChangeType: TChangeType;
    sGameMasterName: string;
    sGetGoldUser: string;
    nGold: Integer;
  end;
  pTGoldChangeInfo = ^TGoldChangeInfo;

  TGateInfo = record
    Socket: TCustomWinSocket;
    boUsed: Boolean;
    sAddr: string[15];
    nPort: Integer;
    n520: Integer;
    UserList: TList;
    nUserCount: Integer;
    Buffer: PChar;
    nBuffLen: Integer;
    BufferList: TList;
    boSendKeepAlive: Boolean;
    dwSendKeepAliveTick: LongWord;
    nSendChecked: Integer;
    nSendBlockCount: Integer;
    dwTime544: LongWord;
    nSendMsgCount: Integer;
    nSendRemainCount: Integer;
    dwSendTick: LongWord;
    nSendMsgBytes: Integer;
    nSendBytesCount: Integer;
    nSendedMsgCount: Integer;
    nSendCount: Integer;
    dwSendCheckTick: LongWord;
  end;
  pTGateInfo = ^TGateInfo;

  TStartPoint = record //安全区回城点 增加光环效果
    sMapName: string[MAPNAMELEN];
    nCurrX: Integer; //  人物所在座标X(4字节)
    nCurrY: Integer;
    boNotAllowSay: Boolean;
    nRange: Integer;
    nType: Integer;
    nPkZone: Integer;
    nPkFire: Integer;
    btShape: Byte;
  end;
  pTStartPoint = ^TStartPoint;

  //地图事件数据配置详解

  TQuestUnitStatus = record
    nQuestUnit: Integer;
    boOpen: Boolean;
  end;
  pTQuestUnitStatus = ^TQuestUnitStatus;

  TMapCondition = record
    nHumStatus: Integer;
    sItemName: string[14];
    boNeedGroup: Boolean;
  end;
  pTMapCondition = ^TMapCondition;

  TStartScript = record
    nLable: Integer;
    sLable: string[100];
  end;

  TMapEvent = record
    m_sMapName: string[MAPNAMELEN];
    m_nCurrX: Integer;
    m_nCurrY: Integer;
    m_nRange: Integer;
    m_MapFlag: TQuestUnitStatus;
    m_nRandomCount: Integer; //; 范围:(0 - 999999) 0 的机率为100% ; 数字越大，机率越低
    m_Condition: TMapCondition; //触发条件
    m_StartScript: TStartScript;
  end;
  pTMapEvent = ^TMapEvent;

  TRememberItem = record
    sMapName: string[MAPNAMELEN];
    nCurrX: Integer;
    nCurrY: Integer;
  end;
  pTRememberItem = ^TRememberItem;

  TItemEvent = record
    sItemName: string[ACTORNAMELEN];
    nMakeIndex: Integer;
    RememberItem: array[0..5] of TRememberItem;
  end;
  pTItemEvent = ^TItemEvent;

  TSendUserData = record
    nSocketIndx: Integer;
    nSocketHandle: Integer;
    sMsg: string;
  end;
  pTSendUserData = ^TSendUserData;

  TCheckVersion = record
  end;
  pTCheckVersion = ^TCheckVersion;

  TRecordDeletedHeader = packed record
    boDeleted: Boolean;
    bt1: Byte;
    bt2: Byte;
    bt3: Byte;
    CreateDate: TDateTime;
    LastLoginDate: TDateTime;
    n14: Integer;
    nNextDeletedIdx: Integer;
    //    sAccount   :String[11];//0x14
  end;

  TOUserEntry = packed record
    sAccount: string[10];
    sPassword: string[10];
    sUserName: string[20];
    sSSNo: string[14];
    sPhone: string[14];
    sQuiz: string[20];
    sAnswer: string[12];
    sEMail: string[40];
  end;

  TUserEntry = packed record
    sAccount: string[ACCOUNTLEN];
    sPassword: string[16];
    sUserName: string[20];
    sSSNo: string[14];
    sPhone: string[14];
    sQuiz: string[20];
    sAnswer: string[12];
    sEMail: string[40];
  end;

  TUserEntryAdd = packed record
    sQuiz2: string[20];
    sAnswer2: string[12];
    sBirthDay: string[10];
    sMobilePhone: string[13];
    sMemo: string[20];
    sMemo2: string[20];
  end;

  TOAccountDBRecord = packed record
    Header: TOIDRecordHeader;
    UserEntry: TOUserEntry;
    UserEntryAdd: TUserEntryAdd;
    nErrorCount: Integer;
    dwActionTick: LongWord;
    dwCreateTick: LongWord;
    n: array[0..34] of Byte;
  end;
  pTOAccountDBRecord = ^TOAccountDBRecord;


  TAccountDBRecord = packed record
    Header: TIDRecordHeader;
    UserEntry: TUserEntry;
    UserEntryAdd: TUserEntryAdd;
    nErrorCount: Integer;
    dwActionTick: LongWord;
    dwCreateTick: LongWord;
    n: array[0..34] of Byte;
  end;
  pTAccountDBRecord = ^TAccountDBRecord;


  TMapFlag = record
    boSAFE: Boolean;
    boDARK: Boolean;
    boFIGHT: Boolean;
    boFIGHT3: Boolean;
    boDAY: Boolean;
    boQUIZ: Boolean;
    boNORECONNECT: Boolean;
    boMUSIC: Boolean;
    boEXPRATE: Boolean;
    boPKWINLEVEL: Boolean;
    boPKWINEXP: Boolean;
    boPKLOSTLEVEL: Boolean;
    boPKLOSTEXP: Boolean;
    boDECHP: Boolean;
    boINCHP: Boolean;
    boDECGAMEGOLD: Boolean;
    boDECGAMEPOINT: Boolean;
    boINCGAMEGOLD: Boolean;
    boINCGAMEPOINT: Boolean;
    boRUNHUMAN: Boolean;
    boRUNMON: Boolean;
    boNEEDHOLE: Boolean;
    boNORECALL: Boolean;
    boNOGUILDRECALL: Boolean;
    boNODEARRECALL: Boolean;
    boNOMASTERRECALL: Boolean;
    boNORANDOMMOVE: Boolean;
    boNODRUG: Boolean;
    boMINE: Boolean;
    boNOPOSITIONMOVE: Boolean;
    boNoManNoMon: Boolean;

    nL: Integer;
    nNEEDSETONFlag: Integer;
    nNeedONOFF: Integer;
    nMUSICID: Integer;

    nPKWINLEVEL: Integer;
    nEXPRATE: Integer;
    nPKWINEXP: Integer;
    nPKLOSTLEVEL: Integer;
    nPKLOSTEXP: Integer;
    nDECHPPOINT: Integer;
    nDECHPTIME: Integer;
    nINCHPPOINT: Integer;
    nINCHPTIME: Integer;
    nDECGAMEGOLD: Integer;
    nDECGAMEGOLDTIME: Integer;
    nDECGAMEPOINT: Integer;
    nDECGAMEPOINTTIME: Integer;
    nINCGAMEGOLD: Integer;
    nINCGAMEGOLDTIME: Integer;
    nINCGAMEPOINT: Integer;
    nINCGAMEPOINTTIME: Integer;
    sReConnectMap: string;
    sMUSICName: string;
    boUnAllowStdItems: Boolean;
    sUnAllowStdItemsText: string;
    sUnAllowMagicText: string; //不允许魔法
    boNOTALLOWUSEMAGIC: Boolean; //不允许魔法
    boAutoMakeMonster: Boolean;
    boFIGHTPK: Boolean; //PK可以爆装备不红名
    boHorse: Boolean; //是否可以骑马
    boNoRecallHero: Boolean;

    boSNOW: Boolean;
    nSNOWLEVEL: Integer;

    boDuel: Boolean; //决斗比赛场地
    boOpenStore: Boolean; //摆摊
  end;
  pTMapFlag = ^TMapFlag;


  TUserLevelRanking = record //人物等级排行
    nIndex: Integer;
    nLevel: LongInt;
    sChrName: string[ACTORNAMELEN];
  end;
  pTUserLevelRanking = ^TUserLevelRanking;

  THeroLevelRanking = record //英雄等级排行
    nIndex: Integer;
    nLevel: LongInt;
    sChrName: string[ACTORNAMELEN];
    sHeroName: string[ACTORNAMELEN];
  end;
  pTHeroLevelRanking = ^THeroLevelRanking;

  TUserMasterRanking = record //徒弟数量排行
    nIndex: Integer;
    nMasterCount: Integer;
    sChrName: string[ACTORNAMELEN];
  end;
  pTUserMasterRanking = ^TUserMasterRanking;

 { TUserLevelSort = record //人物等级排行
    nIndex: Integer;
    nLevel: LongInt;
    sChrName: string[ACTORNAMELEN];
  end;
  pTUserLevelSort = ^TUserLevelSort;

  THeroLevelSort = record //英雄等级排行
    nIndex: Integer;
    nLevel: LongInt;
    sChrName: string[ACTORNAMELEN];
    sHeroName: string[ACTORNAMELEN];
  end;
  pTHeroLevelSort = ^THeroLevelSort;

  TUserMasterSort = record //徒弟数量排行
    nIndex: Integer;
    nMasterCount: Integer;
    sChrName: string[ACTORNAMELEN];
  end;
  pTUserMasterSort = ^TUserMasterSort;  }

  TCharName = string[ACTORNAMELEN + 1];
  pTCharName = ^TCharName;

  THeroName = string[ACTORNAMELEN * 2 + 2];
  pTHeroName = ^THeroName;

  TChrMsg = record
    Ident: Integer;
    x: Integer;
    y: Integer;
    dir: Integer;
    State: Integer;
    feature: Integer;
    saying: string;
    sound: Integer;
  end;
  pTChrMsg = ^TChrMsg;

  {TRegInfo = record
    sKey: string;
    sServerName: string;
    sRegSrvIP: string[15];
    nRegPort: Integer;
  end;  }

  TDropItem = record
    x: Integer;
    y: Integer;
    id: Integer;
    Looks: Integer;
    Name: string;
    FlashTime: DWord;
    FlashStepTime: DWord;
    FlashStep: Integer;
    BoFlash: Boolean;
  end;
  pTDropItem = ^TDropItem;

  TUserCharacterInfo = record
    Name: string[19];
    job: Byte;
    HAIR: Byte;
    Level: LongInt;
    sex: Byte;
  end;

  TClientGoods = record
    Name: string;
    SubMenu: Integer;
    Price: Integer;
    Stock: Integer;
    Grade: Integer;
  end;
  PTClientGoods = ^TClientGoods;

  TClientBoxItem = record
    boGive: Boolean;
    boCenter: Boolean;
    StdItem: TStdItem;
  end;
  pTClientBoxItem = ^TClientBoxItem;

  TSuperItemBox = record
    BoxStatus: TOpenBoxStatus;
    UserItem: TUserItem;
    btBoxType: Byte;
    btGiveBoxIndex: Byte;
    sOpenBoxName: string;
    sItemName: string;
    BoxItemArray: array[0..8] of TClientBoxItem;
  end;
  pTSuperItemBox = ^TSuperItemBox;

  TOpenEx = procedure;

  TRegInfo = record
    boShare: Boolean;
    nSSocket: Integer;
    nCSocket: Integer;
    nParam1: Cardinal;
    nParam2: Cardinal;
    nProcedure: array[0..20 - 1] of Integer;
  end;
  pTRegInfo = ^TRegInfo;

  TServerConfig = record
    btShowClientItemStyle: Byte;
    boAllowItemAddValue: Boolean;
    boAllowItemTime: Boolean;
    boAllowItemAddPoint: Boolean;
    boCheckSpeedHack: Boolean;
    nGreenNumber: Integer;
    boRUNHUMAN: Boolean;
    boRUNMON: Boolean;
    boRunNpc: Boolean;
    boChgSpeed: Boolean;
    nFireDelayTime: Integer;
    nKTZDelayTime: Integer;
    nPKJDelayTime: Integer;
    nSkill50DelayTime: Integer;
    nZRJFDelayTime: Integer;
    nMaxLevel: LongInt;

  end;
  pTServerConfig = ^TServerConfig;

  pTPowerBlock = ^TPowerBlock;
  TPowerBlock = array[0..100 - 1] of Word;

  {TShowRemoteMessage = record
    btMessageType: Byte;
    boShow: Boolean;
    BeginDateTime: TDateTime;
    EndDateTime: TDateTime;
    dwShowTime: LongWord;
    dwShowTick: LongWord;
    boSuperUserShow: Boolean;
    sMsg: string;
  end;
  pTShowRemoteMessage = ^TShowRemoteMessage;  }

  {TUserLicense = record
    sServerName: string[100];
    sVersion: string[100];
    sUpDateTime: string[100];
    sProductName: string[100];
    sProgram: string[100];
    sWebSite: string[100];
    sBbsSite: string[100];
    sProductInfo: string[100];
    sSellInfo1: string[100];
    nUserLicense: Integer;
    sUserLicense: string[32];
    nProductVersion: Integer;
    sProductVersion: string[32];
  end; }

  {TUsrEngnLicense = record
    nOwnerQQ: Integer;
    Handle1: Integer;
    sOwnerQQ: PChar;
    Handle2: Integer;
    nQQCode: Integer;
    Handle3: Integer;
    sSerialNumber: array[0..32 - 1] of Char;
    Handle4: Integer;
    btMode: Byte;
    Handle5: Integer;
    btSoftType: Byte;
    Handle6: Integer;
    nDLLVersion: Integer;
    Handle7: Integer;
    nSerialNumber: Int64;
    Handle8: Integer;
    nUniCode1: Integer;
    Handle9: Integer;
    nUniCode2: Integer;
    Handle10: Integer;
    nUniCode3: Integer;
    Handle11: Integer;
    nEXEVersion: Integer;
    Handle12: Integer;
  end;
  pTUsrEngnLicense = ^TUsrEngnLicense;

  {
  TM2License = record
    ProVersion: Int64;
    UserVersion: Int64;
    ErrorCode: Word;
    Result: Integer;
    UsrEngnLicense: TUsrEngnLicense;
  end;
  pTM2License = ^TM2License;
  }


  TUseItems = array[0..12] of TClientItem;
  TItemArr = array[0..46 - 1] of TClientItem;
  THeroItemArr = array[0..40 - 1] of TClientItem;
  TUpgradeItemArr = array[0..2] of TClientItem;

  pTUseItems = ^TUseItems;
  pTItemArr = ^TItemArr;
  pTHeroItemArr = ^THeroItemArr;

  TTempRecord = packed record
    btValue: array[0..1] of Byte;
    nX: Integer;
    nY: Integer;
  end;

  TUpgradeItem = record
    sName: string[30];
    nMakeIndex: Integer;
  end;

  TClientUpgradeItem = array[0..2] of TUpgradeItem;

  TUpgradeItemIndexs = array[0..2] of Integer;
  TUpgradeItemNames = array[0..2] of string[20];
  pTUpgradeItemIndexs = ^TUpgradeItemIndexs;

  TUpgradeClientItem = record
    UpgradeItemIndexs: TUpgradeItemIndexs;
    UpgradeItemNames: TUpgradeItemNames;
  end;
  pTUpgradeClientItem = ^TUpgradeClientItem;

  TItemType = (t_UseItem, t_BagItem, t_StorageItem, t_BigStorageItem, t_SellOffItem);
  TCopyItem = record
    ItemType: TItemType;
    OwnerObj: TObject;
    OwnerAddr: Pointer;
    UserItem: TUserItem;
  end;
  pTCopyItem = ^TCopyItem;

function TouLong(x: pchar): LongWord;
function APPRfeature(cfeature: Integer): Word;
function RACEfeature(cfeature: Integer): Byte;
function HAIRfeature(cfeature: Integer): Byte;
function DRESSfeature(cfeature: Integer): Byte;
function WEAPONfeature(cfeature: Integer): Byte;
function Horsefeature(cfeature: Integer): Byte;
function Effectfeature(cfeature: Integer): Byte;
function MakeHumanFeature(btRaceImg, btDress, btWeapon, btHair: Byte): Integer;
function MakeMonsterFeature(btRaceImg, btWeapon: Byte; wAppr: Word): Integer;
function GetAtomTypeStr(btAtom: Byte): string;
var
  g_ServerConfig: TServerConfig = (
    btShowClientItemStyle: 0;
    boAllowItemAddValue: False;
    boAllowItemTime: False;
    boAllowItemAddPoint: False;
    boCheckSpeedHack: True;
    nGreenNumber: 100;
    boRUNHUMAN: False;
    boRUNMON: False;
    boRunNpc: False;
    boChgSpeed: False;
    nFireDelayTime: 10000;
    nKTZDelayTime: 10000;
    nPKJDelayTime: 10000;
    nSkill50DelayTime: 30000;
    nZRJFDelayTime: 10000;
    nMaxLevel: 65535;
    );

implementation

function WEAPONfeature(cfeature: Integer): Byte;
begin
  Result := HiByte(cfeature);
end;

function DRESSfeature(cfeature: Integer): Byte;
begin
  Result := HiByte(HiWord(cfeature));
end;

function APPRfeature(cfeature: Integer): Word;
begin
  Result := HiWord(cfeature);
end;

function HAIRfeature(cfeature: Integer): Byte;
begin
  Result := HiWord(cfeature);
end;

function RACEfeature(cfeature: Integer): Byte;
begin
  Result := cfeature;
end;

function Horsefeature(cfeature: Integer): Byte;
begin
  Result := LoByte(LoWord(cfeature));
end;

function Effectfeature(cfeature: Integer): Byte;
begin
  Result := HiByte(LoWord(cfeature));
end;

function MakeHumanFeature(btRaceImg, btDress, btWeapon, btHair: Byte): Integer;
begin
  Result := MakeLong(MakeWord(btRaceImg, btWeapon), MakeWord(btHair, btDress));
end;

function MakeMonsterFeature(btRaceImg, btWeapon: Byte; wAppr: Word): Integer;
begin
  Result := MakeLong(MakeWord(btRaceImg, btWeapon), wAppr);
end;

function GetAtomTypeStr(btAtom: Byte): string;
begin
  case btAtom of
    AT_FIRE: Result := 'Fire';
    AT_ICE: Result := 'Ice';
    AT_LIGHT: Result := 'Light';
    AT_WIND: Result := 'Wind';
    AT_HOLY: Result := 'Holy';
    AT_DARK: Result := 'Dark';
    AT_PHANTOM: Result := 'Phantom';
  end;
end;

function TouLong(x: PChar): LongWord;
asm
  mov esi,eax
  mov ax,[esi]

  xchg ah,al
  shl eax,16

  mov ax,[esi+2]
  xchg ah,al
end;

end.

