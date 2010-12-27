unit PlugMain;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, IniFiles, PlugCommon, PlugShare;
type
  TGameConfig = class
    Config: TConfig;
    m_SayMsgList: TStringList;
    m_ShowItemList: TFileItemDB;
    m_ShowBossList: TFileBossDB;
    m_UnbindItemList: TList;
  private
    Timer: TTimer;
    m_MySelf: TActor;
    m_MyHero: TActor;

    m_boUseRandomItem: Boolean;
    m_boUseMoveHomeItem: Boolean;
    m_boExitClient: Boolean;


    m_dwUseRandomItemTick: LongWord;
    m_dwUseMoveHomeItemTick: LongWord;
    m_dwExitClientTick: LongWord;


    m_boRecallBackHero: Boolean;

    m_dwHumEatHPTick: LongWord;
    m_dwHumEatMPTick: LongWord;
    m_dwHeroEatHPTick: LongWord;
    m_dwHeroEatMPTick: LongWord;

    m_dwHumEatHPTick1: LongWord;
    m_dwHumEatMPTick1: LongWord;
    m_dwHeroEatHPTick1: LongWord;
    m_dwHeroEatMPTick1: LongWord;

    m_dwRecallBackHero: LongWord;
    m_dwHintRecallBackHero: LongWord;

    m_nMaxBagCount: Integer;

    m_btSelAutoEatItem: Integer;
    m_UseItemEvent: array[0..4] of TNotifyEvent;

    m_dwHintMonTick: LongWord;
    m_dwHintItemTick: LongWord;
    m_dwPickItemTick: LongWord;
    m_dwAutoUseMagicTick: LongWord;

    m_nNextChgItem: Integer;
    m_OldItemArr: array[0..6 - 1] of TClientItem;

    m_dwHintItemDuraTick: LongWord;
    m_dwClearDeathTick: LongWord;
    procedure OnTime(Sender: TObject);
    procedure ShowConfig;
    procedure CloseConfig;
    function GetMagicByKey(Key: Char): PTClientMagic;
    procedure TakeOnItem(nType, nCount: Integer);
    procedure SendTakeOnItem(where: Byte; itmindex: Integer; itmname: string);
    procedure SendTakeOffItem(where: Byte; itmindex: Integer; itmname: string);

    procedure SendPickup;
    procedure SendReCallHero();


    function FindHumItemIndex(Index: Integer): Integer;
    function FindHeroItemIndex(Index: Integer): Integer;


    function GetHumLevel: Integer;
    function GetHeroLevel: Integer;

    function GetHumHP: Integer;
    function GetHeroHP: Integer;

    function GetHumMaxHP: Integer;
    function GetHeroMaxHP: Integer;

    function GetHumMP: Integer;
    function GetHeroMP: Integer;

    function GetHumMaxMP: Integer;
    function GetHeroMaxMP: Integer;

    function GetEating: Boolean;
    function GetHeroEating: Boolean;

    function BagItemCount: Integer;
    function HeroBagItemCount: Integer;

    function FindItemArrItemName(btType: Byte): Integer; overload;
    function FindItemArrItemName(sItemName: string): Integer; overload;

    function FindItemArrBindItemName(btType: Byte): Integer; overload;
    function FindItemArrBindItemName(sItemName: string): Integer; overload;

    function FindHeroItemArrItemName(btType: Byte): Integer; overload;
    function FindHeroItemArrItemName(sItemName: string): Integer; overload;

    function FindHeroItemArrBindItemName(btType: Byte): Integer; overload;
    function FindHeroItemArrBindItemName(sItemName: string): Integer; overload;


    function AutoEatItem(idx: Integer): Boolean;
    function AutoHeroEatItem(idx: Integer): Boolean;


    procedure AutoUseItem(Sender: TObject);
    procedure AutoEatHPItem(Sender: TObject);
    procedure AutoEatMPItem(Sender: TObject);
    procedure AutoHeroEatHPItem(Sender: TObject);
    procedure AutoHeroEatMPItem(Sender: TObject);
    procedure UseRandomItem(Sender: TObject);
    procedure MoveToHome(Sender: TObject);
    procedure ExitClient(Sender: TObject); //退出游戏


    procedure AutoRecallBackHero; //召回英雄
    procedure RecallHero; //召回英雄

    procedure HintSuperItem; //极品提示
    procedure HintBossMon; //BOSS提示
    procedure AutoUseMagic;
    procedure AutoOrderItem; //自动放药
    procedure ClearDeath; //清除尸体
    procedure HintItemDura();
    procedure ShowItemDura(Surface: TDirectDrawSurface);
  public
    constructor Create();
    destructor Destroy; override;
    procedure Flip(Surface: TDirectDrawSurface);
    procedure Initialize;
    function KeyDown(Key: Word; Shift: TShiftState): Boolean;
    function KeyPress(Key: Char): Boolean;
    function CreateUserDirectory: string;
    procedure AddChatBoardString(const Text: string; FColor, BColor: Integer);
    procedure SendSay(const Text: string);
    procedure SendSocket(const Text: string);
    procedure SendClientMessage(Msg, Recog, param, tag, series: Integer);
    procedure LoadConfig();
    procedure SaveConfig();
    procedure LoadShowItemList;
    procedure LoadShowBossList;
    procedure SaveShowItemList;
    procedure SaveShowBossList;

    procedure LoadBindItemList;
    procedure UnLoadBindItemList;
    procedure SaveBindItemList;
    function FindBindItemName(sItemName: string): string; overload;
    function FindBindItemName(btType: Integer): string; overload;
    function FindBindItemName(btType: Integer; sItemName: string): string; overload;
    function FindUnBindItemName(sItemName: string): string; overload;
    function FindUnBindItemName(btType: Integer): string; overload;
    function FindUnBindItemName(btType: Integer; sItemName: string): string; overload;
    procedure DeleteBindItem(BindItem: pTBindClientItem);

    function RecogId(Actor: TActor): Integer;
    function Death(Actor: TActor): Boolean;
    function CurrX(Actor: TActor): Integer;
    function CurrY(Actor: TActor): Integer;
    function Job(Actor: TActor): Integer;
    function UserName(Actor: TActor): string;
    function State(Actor: TActor): Integer;


    property HumLevel: Integer read GetHumLevel;
    property HeroLevel: Integer read GetHeroLevel;
    property HumHP: Integer read GetHumHP;
    property HeroHP: Integer read GetHeroHP;
    property HumMaxHP: Integer read GetHumMaxHP;
    property HeroMaxHP: Integer read GetHeroMaxHP;
    property HumMP: Integer read GetHumMP;
    property HeroMP: Integer read GetHeroMP;
    property HumMaxMP: Integer read GetHumMaxMP;
    property HeroMaxMP: Integer read GetHeroMaxMP;
  end;
var
  GameConfig: TGameConfig;
implementation
uses HUtil32, FrmConfig, WelCome;

constructor TGameConfig.Create();
begin
  //inherited;
  Timer := TTimer.Create(nil);
  m_UnbindItemList := nil;
  m_MySelf := nil;
  m_MyHero := nil;
  m_btSelAutoEatItem := 0;
  m_SayMsgList := TStringList.Create;
  m_ShowItemList := TFileItemDB.Create();
  m_ShowBossList := TFileBossDB.Create();
  m_UseItemEvent[0] := AutoEatHPItem;
  m_UseItemEvent[1] := AutoEatMPItem;
  m_UseItemEvent[2] := UseRandomItem;
  m_UseItemEvent[3] := MoveToHome;
  m_UseItemEvent[4] := ExitClient;
  m_nNextChgItem := 0;
  Timer.Interval := 10;
  Timer.OnTimer := OnTime;
end;

destructor TGameConfig.Destroy;
begin
  Timer.Enabled := False;
  Timer.Free;
  UnLoadBindItemList;
  m_SayMsgList.Free;
  m_ShowItemList.Free;
  m_ShowBossList.Free;
  inherited;
end;

procedure TGameConfig.Flip(Surface: TDirectDrawSurface);
var
  Text: string;
  Abil: pTAbility;
begin
  if Config.boShowGreenHint then begin
    if g_PlugInfo.MySelf^ <> nil then begin
      Abil := g_PlugInfo.Actor_Abil(g_PlugInfo.MySelf^);
      Text := ' 负重: ' + IntToStr(Abil.Weight) + '/' + IntToStr(Abil.MaxWeight) +
        ' ' + '金币' + ': ' + IntToStr(g_PlugInfo.Actor_nGold(m_MySelf)^) +

      ' 鼠标: ' + IntToStr(g_PlugInfo.MouseCurrX^) + ':' + IntToStr(g_PlugInfo.MouseCurrY^) + '(' + IntToStr(g_PlugInfo.MouseX^) + ':' + IntToStr(g_PlugInfo.MouseY^) + ')';

       //Text :=  ' 鼠标: ' + IntToStr(g_PlugInfo.MouseCurrX^) + ':' + IntToStr(g_PlugInfo.MouseCurrY^) + '(' + IntToStr(g_PlugInfo.MouseX^) + ':' + IntToStr(g_PlugInfo.MouseY^) + ')';
      if g_PlugInfo.FocusCret^ <> nil then begin
        Abil := g_PlugInfo.Actor_Abil(g_PlugInfo.FocusCret^);
        Text := Text + ' 目标: ' + UserName(g_PlugInfo.FocusCret^) + '(' + IntToStr(Abil.HP) + '/' + IntToStr(Abil.MaxHP) + ')';
      end else begin
        Text := Text + ' 目标: -/-';
      end;
      if g_PlugInfo.MyHero^ <> nil then begin
        Text := Text + Format('  我的英雄: %s(%d/%d)', [UserName(g_PlugInfo.MyHero^), CurrX(g_PlugInfo.MyHero^), CurrY(g_PlugInfo.MyHero^)]);
      end;
      g_PlugInfo.BoldTextOut(Surface, 10, 0, clLime, $00200000, PChar(Text));
    end;
  end;
end;

procedure TGameConfig.Initialize;
var
  I: Integer;
begin
  if g_PlugInfo.MySelf^ <> m_MySelf then begin
    if (g_PlugInfo.MySelf^ <> nil) and (UserName(g_PlugInfo.MySelf^) <> '') then begin
      m_MySelf := g_PlugInfo.MySelf^;
      m_boUseRandomItem := False;
      m_boUseMoveHomeItem := False;
      m_boExitClient := False;
      m_dwUseRandomItemTick := GetTickCount;
      m_dwUseMoveHomeItemTick := GetTickCount;
      m_dwExitClientTick := GetTickCount;
      for I := Low(m_OldItemArr) to High(m_OldItemArr) do begin
        m_OldItemArr[I].s.Name := '';
      end;
      with Config do begin
        boHumUseHP := False;
        boHumUseMP := False;
        boHeroUseHP := False;
        boHeroUseMP := False;
        nHumMinHP := 0;
        nHumMinMP := 0;
        nHeroMinHP := 0;
        nHeroMinMP := 0;
        nHumHPTime := 1000;
        nHumMPTime := 1000;
        nHeroHPTime := 1000;
        nHeroMPTime := 1000;

        boHumUseHP1 := False;
        boHumUseMP1 := False;
        boHeroUseHP1 := False;
        boHeroUseMP1 := False;
        nHumMinHP1 := 0;
        nHumMinMP1 := 0;
        nHeroMinHP1 := 0;
        nHeroMinMP1 := 0;
        nHumHPTime1 := 1000;
        nHumMPTime1 := 1000;
        nHeroHPTime1 := 1000;
        nHeroMPTime1 := 1000;

        nHumEatHPItem := 2;
        nHumEatMPItem := 3;
        nHumEatHPItem1 := 4;
        nHumEatMPItem1 := 5;

        nHeroEatHPItem := 2;
        nHeroEatMPItem := 3;
        nHeroEatHPItem1 := 4;
        nHeroEatMPItem1 := 5;

        boUseRandomItem := False;
        boUseMoveHomeItem := False;

        boExitClient := False;


        nRandomItemMinHP := 0;
        nExitClientMinHP := 0;
        nMoveHomeItemMinHP := 0;

        sRandomItemName := '随机传送卷';
        sMoveHomeItemName := '回城卷';


        Config.boAutoClearDeath := True;
        Config.nAutoClearDeathTime := 30;


        boHeroTakeback := False;
        nTakeBackHeroMinHP := 0;

        {boCreateGroupKey: Boolean;
        boHumStateKey: Boolean;
        boGetHumBagItems: Boolean;
        boRecallHeroKey: Boolean;
        boHeroGroupKey: Boolean;
        boHeroTargetKey: Boolean;
        boHeroGuardKey: Boolean;
        boHeroStateKey: Boolean;
        boHumGetBagItemsKey: Boolean;

        nCreateGroupKey: Integer;
        nHumStateKey: Integer;
        nGetHumBagItems: Integer;
        nRecallHeroKey: Integer;
        nHeroGroupKey: Integer;
        nHeroTargetKey: Integer;
        nHeroGuardKey: Integer;
        nHeroStateKey: Integer;
        nHumGetBagItemsKey: Integer;

        nShowOptionKey: Integer;

        sMoveCmd: string;
        dwMoveTime: Integer;

        boHumUseMagic: Boolean;
        boHeroUseMagic: Boolean;
        nHumMagicIndex: Integer;
        nHeroMagicIndex: Integer;
        nHumUseMagicTime: Integer;
        nHeroUseMagicTime: Integer;  }

        boHeroStateChange := False;
        nHeroStateChangeIndex := 0;

        boAutoAnswer := False;
        sAnswerMsg := '';
        boAutoSay := False;
        nAutoSayTime := 20;

        boAutoQueryBagItem := False;
        //nAutoQueryBagItemTime: Integer;

        boShowGreenHint := True;
        boAutoChgItem := True; //自动换药


        boAutoChgItemReplace := True; //绿毒红毒交替
        nChgItemIndex := 0; //绿毒红毒

        boHintBoss := True; //BOSS提示
        boItemHint := True; ; //极品提示
        boOrderItem := True; //自动放药
        boItemDuraHint := True; ; //持久警告
        boCloseGroup := True; //自动关组
        boUseSpellOffHoser := True; //用法术下马
        boHeroDieAutoReCall := True; //英雄死亡自动召唤

        boAutoUseSpell := False;
        nAutoUseSpellTime := 10;
        nMagicItemIndex := -1;
      end;
      LoadConfig();
    end else m_MySelf := nil;
  end;
  if m_MySelf = nil then begin
    CloseConfig;
    if (frmWelCome <> nil) and (frmWelCome.Visible) then begin
      frmWelCome.Close;
    //FreeAndnil(frmWelCome);
    end;
  end;
end;

function TGameConfig.CreateUserDirectory: string;
var
  sUserDirectory: string;
  sServerName, sUserName: string;
  ShortString: TShortString;
begin
  Result := '';
  if g_PlugInfo.MySelf^ <> nil then begin
    sUserName := StrPas(g_PlugInfo.Actor_sUserName(g_PlugInfo.MySelf^));
    sUserDirectory := ExtractFilePath(ParamStr(0)) + 'Config\';
    if not DirectoryExists(sUserDirectory) then begin
      CreateDir(sUserDirectory);
    end;
    g_PlugInfo.ServerName(@ShortString);
    if ShortString.btLen > 0 then begin
      SetLength(sServerName, ShortString.btLen);
      ShortStringToPChar(@ShortString, @sServerName[1]);
      sUserDirectory := sUserDirectory + sServerName + '-' + sUserName + '\';
      if not DirectoryExists(sUserDirectory) then begin
        CreateDir(sUserDirectory);
      end;
      Result := sUserDirectory;
    end;
  end;
end;

procedure TGameConfig.LoadConfig();
var
  ConInI: TIniFile;
  sFileName: string;
  sClasses: string;
  sUserDirectory: string;
begin
  if (m_MySelf <> nil) then begin
    sUserDirectory := CreateUserDirectory;
    if sUserDirectory <> '' then begin

      LoadBindItemList;
      LoadShowItemList;
      LoadShowBossList;

      try
        m_SayMsgList.LoadFromFile(sUserDirectory + 'SayMsgList.txt');
      except

      end;

      sFileName := sUserDirectory + 'Config.INI';
      sClasses := 'Hum';

      ConInI := TIniFile.Create(sFileName);

    //Config.nShowOptionKey := ConInI.ReadInteger(sClasses, 'ShowOptionKey', 63);

      Config.boHumUseHP := ConInI.ReadBool(sClasses, 'GetUseHP', False);
      Config.boHumUseMP := ConInI.ReadBool(sClasses, 'GetUseMP', False);
      Config.nHumMinHP := ConInI.ReadInteger(sClasses, 'MinHP', Config.nHumMinHP);
      Config.nHumMinMP := ConInI.ReadInteger(sClasses, 'MinMP', Config.nHumMinMP);
      Config.nHumHPTime := ConInI.ReadInteger(sClasses, 'UseHPTime', 1000);
      Config.nHumMPTime := ConInI.ReadInteger(sClasses, 'UseMPTime', 1000);

      Config.boHumUseHP1 := ConInI.ReadBool(sClasses, 'GetUseHP1', False);
      Config.boHumUseMP1 := ConInI.ReadBool(sClasses, 'GetUseMP1', False);
      Config.nHumMinHP1 := ConInI.ReadInteger(sClasses, 'MinHP1', Config.nHumMinHP1);
      Config.nHumMinMP1 := ConInI.ReadInteger(sClasses, 'MinMP1', Config.nHumMinMP1);
      Config.nHumHPTime1 := ConInI.ReadInteger(sClasses, 'UseHPTime1', 1000);
      Config.nHumMPTime1 := ConInI.ReadInteger(sClasses, 'UseMPTime1', 1000);

      Config.nHumEatHPItem := ConInI.ReadInteger(sClasses, 'EatHPItem', 2);
      Config.nHumEatMPItem := ConInI.ReadInteger(sClasses, 'EatMPItem', 3);
      Config.nHumEatHPItem1 := ConInI.ReadInteger(sClasses, 'EatHPItem1', 4);
      Config.nHumEatMPItem1 := ConInI.ReadInteger(sClasses, 'EatMPItem1', 5);


      Config.boUseRandomItem := ConInI.ReadBool(sClasses, 'GetUseRandomItem', Config.boUseRandomItem);
      Config.boUseMoveHomeItem := ConInI.ReadBool(sClasses, 'GetUseMoveHomeItem', Config.boUseMoveHomeItem);

      Config.nRandomItemMinHP := ConInI.ReadInteger(sClasses, 'RandomItemMinHP', Config.nRandomItemMinHP);
      Config.nMoveHomeItemMinHP := ConInI.ReadInteger(sClasses, 'MoveHomeItemMinMP', Config.nMoveHomeItemMinHP);

      Config.sRandomItemName := ConInI.ReadString(sClasses, 'RandomItemName', Config.sRandomItemName);
      Config.sMoveHomeItemName := ConInI.ReadString(sClasses, 'MoveHomeItemName', Config.sMoveHomeItemName);

      Config.boExitClient := ConInI.ReadBool(sClasses, 'GetExitClient', Config.boExitClient);
      Config.nExitClientMinHP := ConInI.ReadInteger(sClasses, 'ExitClientMinHP', Config.nExitClientMinHP);

      Config.boAutoClearDeath := ConInI.ReadBool(sClasses, 'GetAutoClearDeath', Config.boAutoClearDeath);
      Config.nAutoClearDeathTime := ConInI.ReadInteger(sClasses, 'AutoClearDeathTime', Config.nAutoClearDeathTime);


   {   Config.nCreateGroupKey := ConInI.ReadInteger(sClasses, 'CreateGroupKey', 0);
      Config.boCreateGroupKey := ConInI.ReadBool(sClasses, 'GetCreateGroupKey', False);

      Config.boHumStateKey := ConInI.ReadBool(sClasses, 'GetHumStateKey', False);
      Config.nHumStateKey := ConInI.ReadInteger(sClasses, 'HumStateKey', 0);

      Config.boGetHumBagItems := ConInI.ReadBool(sClasses, 'GetHumGetBagItems', False);
      Config.nGetHumBagItems := ConInI.ReadInteger(sClasses, 'HumGetBagItems', 0);


      Config.sMoveCmd := ConInI.ReadString(sClasses, 'MoveCmd', '@Move');
      Config.dwMoveTime := ConInI.ReadInteger(sClasses, 'MoveTime', 5); }


      Config.boHeroStateChange := ConInI.ReadBool(sClasses, 'GetHeroStateChange', False);
      Config.nHeroStateChangeIndex := ConInI.ReadInteger(sClasses, 'HeroStateChangeIndex', 0);


      Config.boAutoQueryBagItem := ConInI.ReadBool(sClasses, 'GetAutoQueryBagItem', False);
      Config.nAutoQueryBagItemTime := ConInI.ReadInteger(sClasses, 'AutoQueryBagItemTime', 1);



    {sClasses := 'Hero';
    Config.boHeroUseHP := ConInI.ReadBool(sClasses, 'GetUseHP', False);
    Config.boHeroUseMP := ConInI.ReadBool(sClasses, 'GetUseMP', False);
    Config.nHeroMinHP := ConInI.ReadInteger(sClasses, 'MinHP', 0);
    Config.nHeroMinMP := ConInI.ReadInteger(sClasses, 'MinMP', 0);
    Config.nHeroHPTime := ConInI.ReadInteger(sClasses, 'UseHPTime', 1000);
    Config.nHeroMPTime := ConInI.ReadInteger(sClasses, 'UseMPTime', 1000);

    Config.boHeroUseHP1 := ConInI.ReadBool(sClasses, 'GetUseHP1', False);
    Config.boHeroUseMP1 := ConInI.ReadBool(sClasses, 'GetUseMP1', False);
    Config.nHeroMinHP1 := ConInI.ReadInteger(sClasses, 'MinHP1', 0);
    Config.nHeroMinMP1 := ConInI.ReadInteger(sClasses, 'MinMP1', 0);
    Config.nHeroHPTime1 := ConInI.ReadInteger(sClasses, 'UseHPTime1', 1000);
    Config.nHeroMPTime1 := ConInI.ReadInteger(sClasses, 'UseMPTime1', 1000);


    Config.nHeroEatHPItem := ConInI.ReadInteger(sClasses, 'EatHPItem', 2);
    Config.nHeroEatMPItem := ConInI.ReadInteger(sClasses, 'EatMPItem', 3);
    Config.nHeroEatHPItem1 := ConInI.ReadInteger(sClasses, 'EatHPItem1', 4);
    Config.nHeroEatMPItem1 := ConInI.ReadInteger(sClasses, 'EatMPItem1', 5);


    Config.boHeroTakeback := ConInI.ReadBool(sClasses, 'GetTakeback', False);
    Config.nTakeBackHeroMinHP := ConInI.ReadInteger(sClasses, 'TakebackMinHP', 0);

    Config.boRecallHeroKey := ConInI.ReadBool(sClasses, 'GetRecallHeroKey', False);
    Config.boHeroGroupKey := ConInI.ReadBool(sClasses, 'GetHeroGroupKey', False);
    Config.boHeroTargetKey := ConInI.ReadBool(sClasses, 'GetHeroTargetKey', False);
    Config.boHeroGuardKey := ConInI.ReadBool(sClasses, 'GetHeroGuardKe', False);
    Config.boHeroStateKey := ConInI.ReadBool(sClasses, 'GetHeroStateKey', False);


    Config.nRecallHeroKey := ConInI.ReadInteger(sClasses, 'RecallHeroKey', 0);
    Config.nHeroGroupKey := ConInI.ReadInteger(sClasses, 'HeroGroupKey', 0);
    Config.nHeroTargetKey := ConInI.ReadInteger(sClasses, 'HeroTargetKey', 0);
    Config.nHeroGuardKey := ConInI.ReadInteger(sClasses, 'HeroGuardKey', 0);
    Config.nHeroStateKey := ConInI.ReadInteger(sClasses, 'HeroStateKey', 0);}


      Config.boShowGreenHint := ConInI.ReadBool(sClasses, 'GetShowGreenHint', Config.boShowGreenHint);
      Config.boAutoChgItem := ConInI.ReadBool(sClasses, 'GetAutoChgItem', Config.boAutoChgItem);
      Config.boAutoChgItemReplace := ConInI.ReadBool(sClasses, 'GetAutoChgItemReplace', Config.boAutoChgItemReplace);
      Config.nChgItemIndex := ConInI.ReadInteger(sClasses, 'ChgItemIndex', Config.nChgItemIndex);

      Config.boHintBoss := ConInI.ReadBool(sClasses, 'GetHintBoss', Config.boHintBoss);
      Config.boItemHint := ConInI.ReadBool(sClasses, 'GetItemHint', Config.boItemHint);
      Config.boOrderItem := ConInI.ReadBool(sClasses, 'GetOrderItem', Config.boOrderItem);
      Config.boItemDuraHint := ConInI.ReadBool(sClasses, 'GetItemDuraHint', Config.boItemDuraHint);
      Config.boUseSpellOffHoser := ConInI.ReadBool(sClasses, 'GetUseSpellOffHoser', Config.boUseSpellOffHoser);
      Config.boHeroDieAutoReCall := ConInI.ReadBool(sClasses, 'GetHeroDieAutoReCall', Config.boHeroDieAutoReCall);


      g_PlugInfo.Config.boMagicLock := ConInI.ReadBool(sClasses, 'GetMagicLock', g_PlugInfo.Config.boMagicLock);
      g_PlugInfo.Config.boAutoPickItem := ConInI.ReadBool(sClasses, 'GetAutoPickItem', g_PlugInfo.Config.boAutoPickItem);

      //g_PlugInfo.Config.boChangeSpeed := ConInI.ReadBool(sClasses, 'GetChangeSpeed', g_PlugInfo.Config.boChangeSpeed);
      g_PlugInfo.Config.boBGSound := ConInI.ReadBool(sClasses, 'GetBGSound', g_PlugInfo.Config.boBGSound);
      g_PlugInfo.Config.boCanRunHuman := ConInI.ReadBool(sClasses, 'GetCanRunHuman', g_PlugInfo.Config.boCanRunHuman);
      g_PlugInfo.Config.boCanRunMon := ConInI.ReadBool(sClasses, 'GetCanRunMon', g_PlugInfo.Config.boCanRunMon);
      g_PlugInfo.Config.boCanRunNpc := ConInI.ReadBool(sClasses, 'GetCanRunNpc', g_PlugInfo.Config.boCanRunNpc);
      g_PlugInfo.Config.boMoveSlow := ConInI.ReadBool(sClasses, 'GetMoveSlow', g_PlugInfo.Config.boMoveSlow);
      g_PlugInfo.Config.boAttackSlow := ConInI.ReadBool(sClasses, 'GetAttackSlow', g_PlugInfo.Config.boAttackSlow);

      g_PlugInfo.Config.boStable := ConInI.ReadBool(sClasses, 'GetStable', g_PlugInfo.Config.boStable);
      g_PlugInfo.Config.boCanFirHit := ConInI.ReadBool(sClasses, 'GetCanFirHit', g_PlugInfo.Config.boCanFirHit);
      g_PlugInfo.Config.boCanLongHit := ConInI.ReadBool(sClasses, 'GetCanLongHit', g_PlugInfo.Config.boCanLongHit);
      g_PlugInfo.Config.boCanWideHit := ConInI.ReadBool(sClasses, 'GetCanWideHit', g_PlugInfo.Config.boCanWideHit);
      g_PlugInfo.Config.boCanCrsHit := ConInI.ReadBool(sClasses, 'GetCanCrsHit', g_PlugInfo.Config.boCanCrsHit);



      g_PlugInfo.Config.boCanKTZHit := ConInI.ReadBool(sClasses, 'GetCanKTZHit', g_PlugInfo.Config.boCanKTZHit);
      g_PlugInfo.Config.boCanPKJHit := ConInI.ReadBool(sClasses, 'GetCanPKJHit', g_PlugInfo.Config.boCanPKJHit);
      g_PlugInfo.Config.boCanZRJFHit := ConInI.ReadBool(sClasses, 'GetCanZRJFHit', g_PlugInfo.Config.boCanZRJFHit);
      g_PlugInfo.Config.boChgPosLongHit := ConInI.ReadBool(sClasses, 'GetChgPosLongHit', g_PlugInfo.Config.boChgPosLongHit);
      g_PlugInfo.Config.boWalkLongHit := ConInI.ReadBool(sClasses, 'GetWalkLongHit', g_PlugInfo.Config.boWalkLongHit);

      g_PlugInfo.Config.boAutoShield := ConInI.ReadBool(sClasses, 'GetAutoShield', g_PlugInfo.Config.boAutoShield);
      g_PlugInfo.Config.boPKShield := ConInI.ReadBool(sClasses, 'GetPKShield', g_PlugInfo.Config.boPKShield);

      g_PlugInfo.Config.boAutoSkill50 := ConInI.ReadBool(sClasses, 'GetAutoSkill50', g_PlugInfo.Config.boAutoSkill50);
      g_PlugInfo.Config.boStruckChgColor := ConInI.ReadBool(sClasses, 'GetStruckChgColor', g_PlugInfo.Config.boStruckChgColor);
      g_PlugInfo.Config.boShowActorLable := ConInI.ReadBool(sClasses, 'GetShowActorLable', g_PlugInfo.Config.boShowActorLable);

      g_PlugInfo.Config.boHideBlueLable := ConInI.ReadBool(sClasses, 'GetHideBlueLable', g_PlugInfo.Config.boHideBlueLable);
      g_PlugInfo.Config.boShowMoveLable := ConInI.ReadBool(sClasses, 'GetShowMoveLable', g_PlugInfo.Config.boShowMoveLable);
      g_PlugInfo.Config.boShowUserName := ConInI.ReadBool(sClasses, 'GetShowUserName', g_PlugInfo.Config.boShowUserName);
      g_PlugInfo.Config.boShowMonName := ConInI.ReadBool(sClasses, 'GetShowMonNam', g_PlugInfo.Config.boShowMonName);
      g_PlugInfo.Config.boShowNumberLable := ConInI.ReadBool(sClasses, 'GetShowNumberLable', g_PlugInfo.Config.boShowNumberLable);
      g_PlugInfo.Config.boShowJobAndLevel := ConInI.ReadBool(sClasses, 'GetShowJobAndLevel', g_PlugInfo.Config.boShowJobAndLevel);

      g_PlugInfo.Config.btActorLableColor := ConInI.ReadInteger(sClasses, 'ActorLableColor', g_PlugInfo.Config.btActorLableColor);
      g_PlugInfo.Config.nStruckChgColor := ConInI.ReadInteger(sClasses, 'StruckChgColor', g_PlugInfo.Config.nStruckChgColor);

      g_PlugInfo.Config.boNeedShift := ConInI.ReadBool(sClasses, 'GetNeedShift', g_PlugInfo.Config.boNeedShift);
      g_PlugInfo.Config.boShowItemName := ConInI.ReadBool(sClasses, 'GetShowItemName', g_PlugInfo.Config.boShowItemName);


      g_PlugInfo.Config.dwMoveTime := ConInI.ReadInteger(sClasses, 'MoveTime', g_PlugInfo.Config.dwMoveTime);
      if g_PlugInfo.Config.dwMoveTime < 600 then g_PlugInfo.Config.dwMoveTime := 600;

      g_PlugInfo.Config.dwMagicPKDelayTime := ConInI.ReadInteger(sClasses, 'MagicPKDelayTime', g_PlugInfo.Config.dwMagicPKDelayTime);
      g_PlugInfo.Config.dwSpellTime := ConInI.ReadInteger(sClasses, 'SpellTime', g_PlugInfo.Config.dwSpellTime);
      g_PlugInfo.Config.dwHitTime := ConInI.ReadInteger(sClasses, 'HitTime', g_PlugInfo.Config.dwHitTime);
      g_PlugInfo.Config.dwStepMoveTime := ConInI.ReadInteger(sClasses, 'StepMoveTime', g_PlugInfo.Config.dwStepMoveTime);

      if g_PlugInfo.Config.dwStepMoveTime < 60 then g_PlugInfo.Config.dwStepMoveTime := 60;
      g_PlugInfo.Config.btHearMsgFColor := ConInI.ReadInteger(sClasses, 'HearMsgFColor', g_PlugInfo.Config.btHearMsgFColor);

      ConInI.Free;


    end;
  end;
end;

procedure TGameConfig.SaveConfig();
var
  ConInI: TIniFile;
  sFileName: string;
  sClasses: string;
  sUserDirectory: string;
begin
  if (m_MySelf <> nil) {and (m_sServerName <> '')} then begin
    sUserDirectory := CreateUserDirectory;
    if sUserDirectory <> '' then begin
    {try
      m_MapFilterList.SaveToFile(sUserDirectory + 'MapFilterList.txt');
    except

    end; }
      try
        m_SayMsgList.SaveToFile(sUserDirectory + 'SayMsgList.txt');
      except

      end;

      sFileName := sUserDirectory + 'Config.INI';
      ConInI := TIniFile.Create(sFileName);
      sClasses := 'Hum';

      ConInI.WriteBool(sClasses, 'GetUseHP', Config.boHumUseHP);
      ConInI.WriteBool(sClasses, 'GetUseMP', Config.boHumUseMP);
      ConInI.WriteInteger(sClasses, 'MinHP', Config.nHumMinHP);
      ConInI.WriteInteger(sClasses, 'MinMP', Config.nHumMinMP);
      ConInI.WriteInteger(sClasses, 'UseHPTime', Config.nHumHPTime);
      ConInI.WriteInteger(sClasses, 'UseMPTime', Config.nHumMPTime);

      ConInI.WriteBool(sClasses, 'GetUseHP1', Config.boHumUseHP1);
      ConInI.WriteBool(sClasses, 'GetUseMP1', Config.boHumUseMP1);
      ConInI.WriteInteger(sClasses, 'MinHP1', Config.nHumMinHP1);
      ConInI.WriteInteger(sClasses, 'MinMP1', Config.nHumMinMP1);
      ConInI.WriteInteger(sClasses, 'UseHPTime1', Config.nHumHPTime1);
      ConInI.WriteInteger(sClasses, 'UseMPTime1', Config.nHumMPTime1);

      ConInI.WriteInteger(sClasses, 'EatHPItem', Config.nHumEatHPItem);
      ConInI.WriteInteger(sClasses, 'EatMPItem', Config.nHumEatMPItem);
      ConInI.WriteInteger(sClasses, 'EatHPItem1', Config.nHumEatHPItem1);
      ConInI.WriteInteger(sClasses, 'EatMPItem1', Config.nHumEatMPItem1);

      ConInI.WriteBool(sClasses, 'GetUseRandomItem', Config.boUseRandomItem);
      ConInI.WriteBool(sClasses, 'GetUseMoveHomeItem', Config.boUseMoveHomeItem);

      ConInI.WriteInteger(sClasses, 'RandomItemMinHP', Config.nRandomItemMinHP);
      ConInI.WriteInteger(sClasses, 'MoveHomeItemMinMP', Config.nMoveHomeItemMinHP);

      ConInI.WriteString(sClasses, 'RandomItemName', Config.sRandomItemName);
      ConInI.WriteString(sClasses, 'MoveHomeItemName', Config.sMoveHomeItemName);

      ConInI.WriteBool(sClasses, 'GetExitClient', Config.boExitClient);
      ConInI.WriteInteger(sClasses, 'ExitClientMinHP', Config.nExitClientMinHP);



      ConInI.WriteBool(sClasses, 'GetHumStateKey', Config.boHumStateKey);
      ConInI.WriteInteger(sClasses, 'HumStateKey', Config.nHumStateKey);

      {ConInI.WriteBool(sClasses, 'GetHumGetBagItems', Config.boGetHumBagItems);
      ConInI.WriteInteger(sClasses, 'HumGetBagItems', Config.nGetHumBagItems);

      ConInI.WriteBool(sClasses, 'GetCreateGroupKey', Config.boCreateGroupKey);
      ConInI.WriteInteger(sClasses, 'CreateGroupKey', Config.nCreateGroupKey);

      ConInI.Writestring(sClasses, 'MoveCmd', Config.sMoveCmd);
      ConInI.WriteInteger(sClasses, 'MoveTime', Config.dwMoveTime); }

      ConInI.WriteBool(sClasses, 'GetHeroStateChange', Config.boHeroStateChange);
      ConInI.WriteInteger(sClasses, 'HeroStateChangeIndex', Config.nHeroStateChangeIndex);

      ConInI.WriteBool(sClasses, 'GetAutoQueryBagItem', Config.boAutoQueryBagItem);
      ConInI.WriteInteger(sClasses, 'AutoQueryBagItemTime', Config.nAutoQueryBagItemTime);

    {sClasses := 'Hero';
    ConInI.WriteBool(sClasses, 'GetUseHP', Config.boHeroUseHP);
    ConInI.WriteBool(sClasses, 'GetUseMP', Config.boHeroUseMP);
    ConInI.WriteInteger(sClasses, 'MinHP', Config.nHeroMinHP);
    ConInI.WriteInteger(sClasses, 'MinMP', Config.nHeroMinMP);
    ConInI.WriteInteger(sClasses, 'UseHPTime', Config.nHeroHPTime);
    ConInI.WriteInteger(sClasses, 'UseMPTime', Config.nHeroMPTime);

    ConInI.WriteBool(sClasses, 'GetUseHP1', Config.boHeroUseHP1);
    ConInI.WriteBool(sClasses, 'GetUseMP1', Config.boHeroUseMP1);
    ConInI.WriteInteger(sClasses, 'MinHP1', Config.nHeroMinHP1);
    ConInI.WriteInteger(sClasses, 'MinMP1', Config.nHeroMinMP1);
    ConInI.WriteInteger(sClasses, 'UseHPTime1', Config.nHeroHPTime1);
    ConInI.WriteInteger(sClasses, 'UseMPTime1', Config.nHeroMPTime1);


    ConInI.WriteInteger(sClasses, 'EatHPItem', Config.nHeroEatHPItem);
    ConInI.WriteInteger(sClasses, 'EatMPItem', Config.nHeroEatMPItem);
    ConInI.WriteInteger(sClasses, 'EatHPItem1', Config.nHeroEatHPItem1);
    ConInI.WriteInteger(sClasses, 'EatMPItem1', Config.nHeroEatMPItem1);


    ConInI.WriteBool(sClasses, 'GetTakeback', Config.boHeroTakeback);
    ConInI.WriteInteger(sClasses, 'TakebackMinHP', Config.nTakeBackHeroMinHP);

    ConInI.WriteBool(sClasses, 'GetRecallHeroKey', Config.boRecallHeroKey);
    ConInI.WriteBool(sClasses, 'GetHeroGroupKey', Config.boHeroGroupKey);
    ConInI.WriteBool(sClasses, 'GetHeroTargetKey', Config.boHeroTargetKey);
    ConInI.WriteBool(sClasses, 'GetHeroGuardKe', Config.boHeroGuardKey);
    ConInI.WriteBool(sClasses, 'GetHeroStateKey', Config.boHeroStateKey);

    ConInI.WriteInteger(sClasses, 'RecallHeroKey', Config.nRecallHeroKey);
    ConInI.WriteInteger(sClasses, 'HeroGroupKey', Config.nHeroGroupKey);
    ConInI.WriteInteger(sClasses, 'HeroTargetKey', Config.nHeroTargetKey);
    ConInI.WriteInteger(sClasses, 'HeroGuardKey', Config.nHeroGuardKey);
    ConInI.WriteInteger(sClasses, 'HeroStateKey', Config.nHeroStateKey);}


      ConInI.WriteBool(sClasses, 'GetShowGreenHint', Config.boShowGreenHint);
      ConInI.WriteBool(sClasses, 'GetAutoChgItem', Config.boAutoChgItem);


      ConInI.WriteBool(sClasses, 'GetAutoChgItemReplace', Config.boAutoChgItemReplace);
      ConInI.WriteInteger(sClasses, 'ChgItemIndex', Config.nChgItemIndex);

      ConInI.WriteBool(sClasses, 'GetHintBoss', Config.boHintBoss);
      ConInI.WriteBool(sClasses, 'GetItemHint', Config.boItemHint);
      ConInI.WriteBool(sClasses, 'GetOrderItem', Config.boOrderItem);
      ConInI.WriteBool(sClasses, 'GetItemDuraHint', Config.boItemDuraHint);
      ConInI.WriteBool(sClasses, 'GetUseSpellOffHoser', Config.boUseSpellOffHoser);
      ConInI.WriteBool(sClasses, 'GetHeroDieAutoReCall', Config.boHeroDieAutoReCall);
      ConInI.WriteBool(sClasses, 'GetAutoClearDeath', Config.boAutoClearDeath);
      ConInI.WriteInteger(sClasses, 'AutoClearDeathTime', Config.nAutoClearDeathTime);

//==============================================================================

      ConInI.WriteBool(sClasses, 'GetMagicLock', g_PlugInfo.Config.boMagicLock);
      ConInI.WriteBool(sClasses, 'GetAutoPickItem', g_PlugInfo.Config.boAutoPickItem);

      //ConInI.WriteBool(sClasses, 'GetChangeSpeed', g_PlugInfo.Config.boChangeSpeed);
      ConInI.WriteBool(sClasses, 'GetBGSound', g_PlugInfo.Config.boBGSound);
      ConInI.WriteBool(sClasses, 'GetCanRunHuman', g_PlugInfo.Config.boCanRunHuman);
      ConInI.WriteBool(sClasses, 'GetCanRunMon', g_PlugInfo.Config.boCanRunMon);
      ConInI.WriteBool(sClasses, 'GetCanRunNpc', g_PlugInfo.Config.boCanRunNpc);
      ConInI.WriteBool(sClasses, 'GetMoveSlow', g_PlugInfo.Config.boMoveSlow);
      ConInI.WriteBool(sClasses, 'GetAttackSlow', g_PlugInfo.Config.boAttackSlow);

      ConInI.WriteBool(sClasses, 'GetStable', g_PlugInfo.Config.boStable);
      ConInI.WriteBool(sClasses, 'GetCanFirHit', g_PlugInfo.Config.boCanFirHit);
      ConInI.WriteBool(sClasses, 'GetCanLongHit', g_PlugInfo.Config.boCanLongHit);
      ConInI.WriteBool(sClasses, 'GetCanWideHit', g_PlugInfo.Config.boCanWideHit);
      ConInI.WriteBool(sClasses, 'GetCanCrsHit', g_PlugInfo.Config.boCanCrsHit);



      ConInI.WriteBool(sClasses, 'GetCanKTZHit', g_PlugInfo.Config.boCanKTZHit);
      ConInI.WriteBool(sClasses, 'GetCanPKJHit', g_PlugInfo.Config.boCanPKJHit);
      ConInI.WriteBool(sClasses, 'GetCanZRJFHit', g_PlugInfo.Config.boCanZRJFHit);
      ConInI.WriteBool(sClasses, 'GetChgPosLongHit', g_PlugInfo.Config.boChgPosLongHit);
      ConInI.WriteBool(sClasses, 'GetWalkLongHit', g_PlugInfo.Config.boWalkLongHit);

      ConInI.WriteBool(sClasses, 'GetAutoShield', g_PlugInfo.Config.boAutoShield);
      ConInI.WriteBool(sClasses, 'GetPKShield', g_PlugInfo.Config.boPKShield);

      ConInI.WriteBool(sClasses, 'GetAutoSkill50', g_PlugInfo.Config.boAutoSkill50);
      ConInI.WriteBool(sClasses, 'GetStruckChgColor', g_PlugInfo.Config.boStruckChgColor);
      ConInI.WriteBool(sClasses, 'GetShowActorLable', g_PlugInfo.Config.boShowActorLable);


      ConInI.WriteBool(sClasses, 'GetHideBlueLable', g_PlugInfo.Config.boHideBlueLable);
      ConInI.WriteBool(sClasses, 'GetShowMoveLable', g_PlugInfo.Config.boShowMoveLable);
      ConInI.WriteBool(sClasses, 'GetShowUserName', g_PlugInfo.Config.boShowUserName);
      ConInI.WriteBool(sClasses, 'GetShowMonNam', g_PlugInfo.Config.boShowMonName);
      ConInI.WriteBool(sClasses, 'GetShowNumberLable', g_PlugInfo.Config.boShowNumberLable);
      ConInI.WriteBool(sClasses, 'GetShowJobAndLevel', g_PlugInfo.Config.boShowJobAndLevel);

      ConInI.WriteInteger(sClasses, 'ActorLableColor', g_PlugInfo.Config.btActorLableColor);
      ConInI.WriteInteger(sClasses, 'StruckChgColor', g_PlugInfo.Config.nStruckChgColor);

      ConInI.WriteBool(sClasses, 'GetNeedShift', g_PlugInfo.Config.boNeedShift);
      ConInI.WriteBool(sClasses, 'GetShowItemName', g_PlugInfo.Config.boShowItemName);


      ConInI.WriteInteger(sClasses, 'MoveTime', g_PlugInfo.Config.dwMoveTime);
      ConInI.WriteInteger(sClasses, 'MagicPKDelayTime', g_PlugInfo.Config.dwMagicPKDelayTime);
      ConInI.WriteInteger(sClasses, 'SpellTime', g_PlugInfo.Config.dwSpellTime);
      ConInI.WriteInteger(sClasses, 'HitTime', g_PlugInfo.Config.dwHitTime);
      ConInI.WriteInteger(sClasses, 'StepMoveTime', g_PlugInfo.Config.dwStepMoveTime);
      ConInI.WriteInteger(sClasses, 'HearMsgFColor', g_PlugInfo.Config.btHearMsgFColor);
      ConInI.Free;
    end;
  end;
end;

procedure TGameConfig.LoadShowItemList;
begin
  m_ShowItemList.LoadList(CreateUserDirectory + 'ItemList.dat');
end;

procedure TGameConfig.LoadShowBossList;
begin
  m_ShowBossList.LoadList(CreateUserDirectory + 'BossList.dat');
end;

procedure TGameConfig.SaveShowItemList;
begin
  m_ShowItemList.SaveToFile;
end;

procedure TGameConfig.SaveShowBossList;
begin
  m_ShowBossList.SaveToFile;
end;

procedure TGameConfig.LoadBindItemList;
var
  I: Integer;
  LoadList: TStringList;
  sFileName: string;
  BindItem: pTBindClientItem;
  sLineText, sType, sItemName, sBindItemName: string;
  nType: Integer;
begin
  UnLoadBindItemList;
  m_UnbindItemList := TList.Create;
  sFileName := CreateUserDirectory + 'BindItemList.Dat';

  LoadList := TStringList.Create;
  if FileExists(sFileName) then begin
    try
      LoadList.LoadFromFile(sFileName);
    except
      LoadList.Clear;
    end;
  end else begin
    LoadList.Add('0' + #9 + '金创药(中量)' + #9 + '金创药(中)包');
    LoadList.Add('1' + #9 + '魔法药(中量)' + #9 + '魔法药(中)包');
    LoadList.Add('0' + #9 + '强效金创药' + #9 + '超级金创药');
    LoadList.Add('1' + #9 + '强效魔法药' + #9 + '超级魔法药');
    LoadList.Add('2' + #9 + '疗伤药' + #9 + '疗伤药包');
    LoadList.Add('2' + #9 + '万年雪霜' + #9 + '雪霜包');
    LoadList.Add('2' + #9 + '太阳水' + #9 + '太阳水');
    LoadList.Add('2' + #9 + '强效太阳水' + #9 + '强效太阳水');
    LoadList.SaveToFile(sFileName);
  end;
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := Trim(LoadList.Strings[I]);
    if sLineText = '' then Continue;
    if (sLineText <> '') and (sLineText[1] = ';') then Continue;
    sLineText := GetValidStr3(sLineText, sType, [' ', #9]);
    sLineText := GetValidStr3(sLineText, sItemName, [' ', #9]);
    sLineText := GetValidStr3(sLineText, sBindItemName, [' ', #9]);
    nType := Str_ToInt(sType, -1);
    if (nType in [0..3]) and (sItemName <> '') and (sBindItemName <> '') then begin
      New(BindItem);
      BindItem.btItemType := nType;
      BindItem.sItemName := sItemName;
      BindItem.sBindItemName := sBindItemName;
      m_UnbindItemList.Add(BindItem);
    end;
  end;
  LoadList.Free;
end;

procedure TGameConfig.UnLoadBindItemList;
var
  I: Integer;
begin
  if m_UnbindItemList = nil then Exit;
  for I := 0 to m_UnbindItemList.Count - 1 do begin
    Dispose(pTBindClientItem(m_UnbindItemList.Items[I]));
  end;
  FreeAndNil(m_UnbindItemList);
end;

procedure TGameConfig.SaveBindItemList;
var
  I: Integer;
  SaveList: TStringList;
  sFileName: string;
  BindItem: pTBindClientItem;
begin
  if m_UnbindItemList = nil then Exit;
  SaveList := TStringList.Create;
  for I := 0 to m_UnbindItemList.Count - 1 do begin
    BindItem := pTBindClientItem(m_UnbindItemList.Items[I]);
    SaveList.Add(IntToStr(BindItem.btItemType) + #9 + BindItem.sItemName + #9 + BindItem.sBindItemName);
  end;
  sFileName := CreateUserDirectory + 'BindItemList.Dat';
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
end;

procedure TGameConfig.DeleteBindItem(BindItem: pTBindClientItem);
var
  I: Integer;
begin
  if m_UnbindItemList = nil then Exit;
  for I := m_UnbindItemList.Count - 1 downto 0 do begin
    if m_UnbindItemList.Items[I] = BindItem then begin
      Dispose(pTBindClientItem(m_UnbindItemList.Items[I]));
      m_UnbindItemList.Delete(I);
      Break;
    end;
  end;
end;

function TGameConfig.FindBindItemName(btType: Integer): string;
var
  I: Integer;
begin
  Result := '';
  if m_UnbindItemList = nil then Exit;
  for I := 0 to m_UnbindItemList.Count - 1 do begin
    if pTBindClientItem(m_UnbindItemList.Items[I]).btItemType = btType then begin
      Result := pTBindClientItem(m_UnbindItemList.Items[I]).sBindItemName;
      Break;
    end;
  end;
end;

function TGameConfig.FindBindItemName(sItemName: string): string;
var
  I: Integer;
begin
  Result := '';
  if m_UnbindItemList = nil then Exit;
  for I := 0 to m_UnbindItemList.Count - 1 do begin
    if CompareText(pTBindClientItem(m_UnbindItemList.Items[I]).sItemName, sItemName) = 0 then begin
      Result := pTBindClientItem(m_UnbindItemList.Items[I]).sBindItemName;
      Break;
    end;
  end;
end;

function TGameConfig.FindBindItemName(btType: Integer; sItemName: string): string;
var
  I: Integer;
begin
  Result := '';
  if m_UnbindItemList = nil then Exit;
  for I := 0 to m_UnbindItemList.Count - 1 do begin
    if (pTBindClientItem(m_UnbindItemList.Items[I]).btItemType = btType) and
      (CompareText(pTBindClientItem(m_UnbindItemList.Items[I]).sBindItemName, sItemName) = 0) then begin
      Result := pTBindClientItem(m_UnbindItemList.Items[I]).sBindItemName;
      Break;
    end;
  end;
end;

function TGameConfig.FindUnBindItemName(btType: Integer): string;
var
  I: Integer;
begin
  Result := '';
  if m_UnbindItemList = nil then Exit;
  for I := 0 to m_UnbindItemList.Count - 1 do begin
    if pTBindClientItem(m_UnbindItemList.Items[I]).btItemType = btType then begin
      Result := pTBindClientItem(m_UnbindItemList.Items[I]).sItemName;
      Break;
    end;
  end;
end;

function TGameConfig.FindUnBindItemName(btType: Integer; sItemName: string): string;
var
  I: Integer;
begin
  Result := '';
  if m_UnbindItemList = nil then Exit;
  for I := 0 to m_UnbindItemList.Count - 1 do begin
    if (pTBindClientItem(m_UnbindItemList.Items[I]).btItemType = btType) and
      (CompareText(pTBindClientItem(m_UnbindItemList.Items[I]).sItemName, sItemName) = 0) then begin
      Result := pTBindClientItem(m_UnbindItemList.Items[I]).sItemName;
      Break;
    end;
  end;
end;

function TGameConfig.FindUnBindItemName(sItemName: string): string;
var
  I: Integer;
begin
  Result := '';
  if m_UnbindItemList = nil then Exit;
  for I := 0 to m_UnbindItemList.Count - 1 do begin
    if CompareText(pTBindClientItem(m_UnbindItemList.Items[I]).sItemName, sItemName) = 0 then begin
      Result := pTBindClientItem(m_UnbindItemList.Items[I]).sItemName;
      Break;
    end;
  end;
end;

function TGameConfig.FindHumItemIndex(Index: Integer): Integer;
var
  I: Integer;
  BindItem: pTBindClientItem;
begin
  Result := -1;
  if (Index >= 0) and (Index < m_UnbindItemList.Count) then begin
    BindItem := m_UnbindItemList.Items[Index];
    for I := Low(TItemArr) + 6 to High(TItemArr) do begin
      if g_PlugInfo.ItemArr[I].s.Name <> '' then begin
        if CompareText(BindItem.sItemName, g_PlugInfo.ItemArr[I].s.Name) = 0 then begin
          Result := I;
          Exit;
        end;
      end;
    end;
    if BagItemCount <= 40 then begin
      for I := Low(TItemArr) to High(TItemArr) do begin
        if g_PlugInfo.ItemArr[I].s.Name <> '' then begin
          if CompareText(BindItem.sBindItemName, g_PlugInfo.ItemArr[I].s.Name) = 0 then begin
            Result := I;
            Exit;
          end;
        end;
      end;
    end;
    for I := Low(TItemArr) to High(TItemArr) do begin
      if g_PlugInfo.ItemArr[I].s.Name <> '' then begin
        if CompareText(BindItem.sItemName, g_PlugInfo.ItemArr[I].s.Name) = 0 then begin
          Result := I;
          Exit;
        end;
      end;
    end;
  end;
end;

function TGameConfig.FindHeroItemIndex(Index: Integer): Integer;
var
  I: Integer;
  BindItem: pTBindClientItem;
begin
  Result := -1;
  if (Index >= 0) and (Index < m_UnbindItemList.Count) then begin
    BindItem := m_UnbindItemList.Items[Index];
    for I := Low(THeroItemArr) to High(THeroItemArr) do begin
      if g_PlugInfo.HeroItemArr[I].s.Name <> '' then begin
        if CompareText(BindItem.sItemName, g_PlugInfo.HeroItemArr[I].s.Name) = 0 then begin
          Result := I;
          Exit;
        end;
      end;
    end;
    if m_nMaxBagCount - HeroBagItemCount >= 6 then begin
      for I := Low(THeroItemArr) to High(THeroItemArr) do begin
        if g_PlugInfo.HeroItemArr[I].s.Name <> '' then begin
          if CompareText(BindItem.sBindItemName, g_PlugInfo.HeroItemArr[I].s.Name) = 0 then begin
            Result := I;
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

function TGameConfig.RecogId(Actor: TActor): Integer;
begin
  Result := -1;
  if Actor <> nil then Result := g_PlugInfo.Actor_nRecogId(Actor)^;
end;

function TGameConfig.Death(Actor: TActor): Boolean;
begin
  Result := False;
  if Actor <> nil then Result := g_PlugInfo.Actor_boDeath(Actor)^;
end;

function TGameConfig.CurrX(Actor: TActor): Integer;
begin
  Result := -1;
  if Actor <> nil then Result := g_PlugInfo.Actor_nCurrX(Actor)^;
end;

function TGameConfig.CurrY(Actor: TActor): Integer;
begin
  Result := -1;
  if Actor <> nil then Result := g_PlugInfo.Actor_nCurrY(Actor)^;
end;

function TGameConfig.Job(Actor: TActor): Integer;
begin
  Result := -1;
  if Actor <> nil then Result := g_PlugInfo.Actor_btJob(Actor)^;
end;

function TGameConfig.UserName(Actor: TActor): string;
begin
  Result := '';
  if Actor <> nil then Result := g_PlugInfo.Actor_sUserName(Actor);
end;

function TGameConfig.State(Actor: TActor): Integer;
begin
  Result := -1;
  if Actor <> nil then Result := g_PlugInfo.Actor_nState(Actor)^;
end;

function TGameConfig.GetHumLevel: Integer;
begin
  Result := -1;
  if g_PlugInfo.MySelf^ <> nil then begin
    Result := g_PlugInfo.Actor_Abil(g_PlugInfo.MySelf^).Level;
  end;
end;

function TGameConfig.GetHeroLevel: Integer;
begin
  Result := -1;
  if g_PlugInfo.MyHero^ <> nil then begin
    Result := g_PlugInfo.Actor_Abil(g_PlugInfo.MyHero^).Level;
  end;
end;

function TGameConfig.GetHumHP: Integer;
begin
  Result := -1;
  if g_PlugInfo.MySelf^ <> nil then begin
    Result := g_PlugInfo.Actor_Abil(g_PlugInfo.MySelf^).HP;
  end;
end;

function TGameConfig.GetHeroHP: Integer;
begin
  Result := -1;
  if g_PlugInfo.MyHero^ <> nil then begin
    Result := g_PlugInfo.Actor_Abil(g_PlugInfo.MyHero^).HP;
  end;
end;

function TGameConfig.GetHumMaxHP: Integer;
begin
  Result := -1;
  if g_PlugInfo.MySelf^ <> nil then begin
    Result := g_PlugInfo.Actor_Abil(g_PlugInfo.MySelf^).MaxHP;
  end;
end;

function TGameConfig.GetHeroMaxHP: Integer;
begin
  Result := -1;
  if g_PlugInfo.MyHero^ <> nil then begin
    Result := g_PlugInfo.Actor_Abil(g_PlugInfo.MyHero^).MaxHP;
  end;
end;

function TGameConfig.GetHumMP: Integer;
begin
  Result := -1;
  if g_PlugInfo.MySelf^ <> nil then begin
    Result := g_PlugInfo.Actor_Abil(g_PlugInfo.MySelf^).MP;
  end;
end;

function TGameConfig.GetHeroMP: Integer;
begin
  Result := -1;
  if g_PlugInfo.MyHero^ <> nil then begin
    Result := g_PlugInfo.Actor_Abil(g_PlugInfo.MyHero^).MP;
  end;
end;

function TGameConfig.GetHumMaxMP: Integer;
begin
  Result := -1;
  if g_PlugInfo.MySelf^ <> nil then begin
    Result := g_PlugInfo.Actor_Abil(g_PlugInfo.MySelf^).MaxMP;
  end;
end;

function TGameConfig.GetHeroMaxMP: Integer;
begin
  Result := -1;
  if g_PlugInfo.MyHero^ <> nil then begin
    Result := g_PlugInfo.Actor_Abil(g_PlugInfo.MyHero^).MaxMP;
  end;
end;

function TGameConfig.GetEating: Boolean;
begin
  Result := False;
  if (g_PlugInfo.EatingItem.s.Name <> '') and (GetTickCount - g_PlugInfo.dwEatTime^ > 1000 * 5) then begin
    g_PlugInfo.EatingItem.s.Name := '';
  end;
  Result := g_PlugInfo.EatingItem.s.Name = '';
end;

function TGameConfig.GetHeroEating: Boolean;
begin
  Result := False;
  if (g_PlugInfo.HeroEatingItem.s.Name <> '') and (GetTickCount - g_PlugInfo.dwHeroEatTime^ > 1000 * 5) then begin
    g_PlugInfo.HeroEatingItem.s.Name := '';
  end;
  Result := g_PlugInfo.HeroEatingItem.s.Name = '';
end;

procedure TGameConfig.SendClientMessage(Msg, Recog, param, tag, series: Integer);
var
  dmsg: TDefaultMessage;
begin
  dmsg := MakeDefaultMsg(Msg, Recog, param, tag, series);
  SendSocket(EncodeMessage(dmsg));
end;

procedure TGameConfig.SendSocket(const Text: string);
begin
  g_PlugInfo.SendSocket(PChar(Text), Length(Text));
end;
//自动吃药

function TGameConfig.AutoEatItem(idx: Integer): Boolean;
var
  sName: string;
  Msg: TDefaultMessage;
  MakeIndex: Integer;
begin
  Result := False;
  if idx in [0..46 - 1] then begin
    if (g_PlugInfo.EatingItem.s.Name <> '') and (GetTickCount - g_PlugInfo.dwEatTime^ > 5 * 1000) then begin
      g_PlugInfo.EatingItem.s.Name := '';
    end;
    if (g_PlugInfo.EatingItem.s.Name = '') then begin
      if (g_PlugInfo.ItemArr[idx].s.Name <> '') and ((g_PlugInfo.ItemArr[idx].s.StdMode <= 3) or (g_PlugInfo.ItemArr[idx].s.StdMode = 31)) then begin
        g_PlugInfo.dwEatTime^ := GetTickCount;
        g_PlugInfo.EatingItem^ := g_PlugInfo.ItemArr[idx];
        sName := g_PlugInfo.EatingItem.s.Name;
        MakeIndex := g_PlugInfo.EatingItem.MakeIndex;
        g_PlugInfo.ItemArr[idx].s.Name := '';

        Msg := MakeDefaultMsg(CM_EAT, MakeIndex, 0, 0, 0);
        SendSocket(EncodeMessage(Msg) + EncodeString(sName));

        Result := True;
      end;
    end;
  end;
end;
//自动吃药

function TGameConfig.AutoHeroEatItem(idx: Integer): Boolean;
var
  sName: string;
  Msg: TDefaultMessage;
  MakeIndex: Integer;
begin
  Result := False;
  if idx in [0..40 - 1] then begin
    if (g_PlugInfo.HeroEatingItem.s.Name <> '') and (GetTickCount - g_PlugInfo.dwHeroEatTime^ > 5 * 1000) then begin
      g_PlugInfo.HeroEatingItem.s.Name := '';
    end;
    if (g_PlugInfo.HeroEatingItem.s.Name = '') then begin
      if (g_PlugInfo.HeroItemArr[idx].s.Name <> '') and ((g_PlugInfo.HeroItemArr[idx].s.StdMode <= 3) or (g_PlugInfo.HeroItemArr[idx].s.StdMode = 31)) then begin
        g_PlugInfo.dwHeroEatTime^ := GetTickCount;
        g_PlugInfo.HeroEatingItem^ := g_PlugInfo.HeroItemArr[idx];
        sName := g_PlugInfo.HeroEatingItem.s.Name;
        MakeIndex := g_PlugInfo.HeroEatingItem.MakeIndex;
        g_PlugInfo.HeroItemArr[idx].s.Name := '';
        Msg := MakeDefaultMsg(CM_HEROEAT, MakeIndex, 0, 0, 0);
        SendSocket(EncodeMessage(Msg) + EncodeString(sName));
        Result := True;
      end;
    end;
  end;
end;

function TGameConfig.BagItemCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := Low(TItemArr) to High(TItemArr) do begin
    if g_PlugInfo.ItemArr[I].s.Name <> '' then Inc(Result);
  end;
end;

function TGameConfig.HeroBagItemCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := Low(THeroItemArr) to High(THeroItemArr) do begin
    if g_PlugInfo.HeroItemArr[I].s.Name <> '' then Inc(Result);
  end;
end;

function TGameConfig.FindItemArrItemName(btType: Byte): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := Low(TItemArr) to High(TItemArr) do begin
    if g_PlugInfo.ItemArr[I].s.Name <> '' then begin
      if FindUnBindItemName(btType, g_PlugInfo.ItemArr[I].s.Name) <> '' then begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

function TGameConfig.FindItemArrItemName(sItemName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  if FindUnBindItemName(sItemName) <> '' then begin
    for I := Low(TItemArr) to High(TItemArr) do begin
      if g_PlugInfo.ItemArr[I].s.Name <> '' then begin
        if g_PlugInfo.ItemArr[I].s.Name = sItemName then begin
          Result := I;
          Break;
        end;
      end;
    end;
  end;
end;

function TGameConfig.FindItemArrBindItemName(btType: Byte): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := Low(TItemArr) to High(TItemArr) do begin
    if g_PlugInfo.ItemArr[I].s.Name <> '' then begin
      if FindBindItemName(btType, g_PlugInfo.ItemArr[I].s.Name) <> '' then begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

function TGameConfig.FindItemArrBindItemName(sItemName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := Low(TItemArr) + 6 to High(TItemArr) do begin
    if g_PlugInfo.ItemArr[I].s.Name <> '' then begin
      if CompareText(FindBindItemName(sItemName), g_PlugInfo.ItemArr[I].s.Name) = 0 then begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

function TGameConfig.FindHeroItemArrItemName(btType: Byte): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := Low(THeroItemArr) to High(THeroItemArr) do begin
    if g_PlugInfo.HeroItemArr[I].s.Name <> '' then begin
      if FindUnBindItemName(btType, g_PlugInfo.HeroItemArr[I].s.Name) <> '' then begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

function TGameConfig.FindHeroItemArrItemName(sItemName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  if FindUnBindItemName(sItemName) <> '' then begin
    for I := Low(THeroItemArr) to High(THeroItemArr) do begin
      if g_PlugInfo.HeroItemArr[I].s.Name <> '' then begin
        if CompareText(sItemName, g_PlugInfo.HeroItemArr[I].s.Name) = 0 then begin
          Result := I;
          Break;
        end;
      end;
    end;
  end;
end;

function TGameConfig.FindHeroItemArrBindItemName(btType: Byte): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := Low(THeroItemArr) to High(THeroItemArr) do begin
    if g_PlugInfo.HeroItemArr[I].s.Name <> '' then begin
      if (FindBindItemName(btType, g_PlugInfo.HeroItemArr[I].s.Name) <> '') then begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

function TGameConfig.FindHeroItemArrBindItemName(sItemName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := Low(THeroItemArr) to High(THeroItemArr) do begin
    if g_PlugInfo.HeroItemArr[I].s.Name <> '' then begin
      if (CompareText(FindBindItemName(sItemName), g_PlugInfo.HeroItemArr[I].s.Name) = 0) then begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

procedure TGameConfig.AddChatBoardString(const Text: string; FColor, BColor: Integer);
begin
  g_PlugInfo.AddChatBoardString(PChar(Text), FColor, BColor);
end;

procedure TGameConfig.SendSay(const Text: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SAY, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(Text));
end;

procedure TGameConfig.SendPickup;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_PICKUP, 0, CurrX(m_MySelf), CurrY(m_MySelf), 0);
  SendSocket(EncodeMessage(Msg) { + EncodeString(Text)});
end;

procedure TGameConfig.SendReCallHero();
begin

end;

procedure TGameConfig.HintBossMon; //BOSS提示
var
  I: Integer;
  Actor: TActor;
begin
  if Config.boHintBoss then begin
    if GetTickCount - m_dwHintMonTick > 1000 then begin
      m_dwHintMonTick := GetTickCount;
      for I := 0 to g_PlugInfo.ActorList.Count - 1 do begin
        Actor := TActor(g_PlugInfo.ActorList.Items[I]);
        if (Actor <> m_MySelf) and (not Death(Actor)) then begin
          m_ShowBossList.AddHintActor(Actor);
        end;
      end;
      m_ShowBossList.Hint;
    end;
  end;
end;

procedure TGameConfig.HintSuperItem; //极品提示
var
  I, II: Integer;
  List: TList;
  ItemList: TList;
  DropItem: pTDropItem;
  HintItem: pTHintItem;
  ShowItem: pTShowItem;
begin
  if Config.boItemHint then begin
    if GetTickCount - m_dwHintItemTick > 1000 then begin
      m_dwHintItemTick := GetTickCount;
      for I := 0 to g_PlugInfo.DropedItemList.Count - 1 do begin
        List := TList(g_PlugInfo.DropedItemList.Items[I]);
        for II := 0 to List.Count - 1 do begin
          DropItem := pTDropItem(List.Items[II]);
          m_ShowItemList.AddHint(DropItem);
        end;
      end;
      m_ShowItemList.Hint;
    end;
  end;

  if GetTickCount - m_dwPickItemTick > 500 then begin
    m_dwPickItemTick := GetTickCount;
    for I := 0 to g_PlugInfo.DropedItemList.Count - 1 do begin
      List := TList(g_PlugInfo.DropedItemList.Items[I]);
      for II := 0 to List.Count - 1 do begin
        DropItem := pTDropItem(List.Items[II]);
        if (DropItem.x = CurrX(m_MySelf)) and (DropItem.y = CurrY(m_MySelf)) and (BagItemCount < 46) then begin
          ShowItem := m_ShowItemList.Find(DropItem.Name);
          if (ShowItem <> nil) and ShowItem.boPickup then begin
            SendPickup;
          end;
        end;
      end;
    end;
  end;
end;

procedure TGameConfig.AutoUseMagic;
var
  Magic: pTClientMagic;
begin
  if Config.boAutoUseSpell and (Config.nMagicItemIndex >= 0) and (Config.nMagicItemIndex < g_PlugInfo.MagicList.Count) then begin
    if GetTickCount - m_dwAutoUseMagicTick > Config.nAutoUseSpellTime * 1000 then begin
      m_dwAutoUseMagicTick := GetTickCount;
      Magic := g_PlugInfo.MagicList.Items[Config.nMagicItemIndex];
      if Magic <> nil then
        g_PlugInfo.UseMagic(g_PlugInfo.MouseX^, g_PlugInfo.MouseY^, Magic);
    end;
  end;
end;

procedure TGameConfig.AutoUseItem(Sender: TObject);
begin
  if GetEating then begin
    if (m_btSelAutoEatItem < 0) or (m_btSelAutoEatItem > High(m_UseItemEvent)) then
      m_btSelAutoEatItem := 0;
    m_UseItemEvent[m_btSelAutoEatItem](Sender);
    Inc(m_btSelAutoEatItem);
  end;
end;

procedure TGameConfig.AutoEatHPItem(Sender: TObject);
var
  nIndex: Integer;
  function EatHPItem(Flag: Boolean): Boolean;
  begin
    Result := False;
    if Config.boHumUseHP then begin
      if {(GetEating) and }(GetTickCount - m_dwHumEatHPTick > Config.nHumHPTime) and (Flag or (HumHP < Config.nHumMinHP)) then begin
        nIndex := FindHumItemIndex(Config.nHumEatHPItem);
        if nIndex >= 0 then begin
          m_dwHumEatHPTick := GetTickCount;
          Result := AutoEatItem(nIndex);
          //AddChatBoardString('TGameConfig.AutoEatHPItem4 EatHPItem', c_White, c_Fuchsia);
        end;
      end;
    end;
  end;

  function EatHPItem1(Flag: Boolean): Boolean;
  begin
    if Config.boHumUseHP1 then begin
      if {(GetEating) and }(GetTickCount - m_dwHumEatHPTick1 > Config.nHumHPTime1) and (Flag or (HumHP < Config.nHumMinHP1)) then begin
        nIndex := FindHumItemIndex(Config.nHumEatHPItem1);
        if nIndex >= 0 then begin
          m_dwHumEatHPTick1 := GetTickCount;
          Result := AutoEatItem(nIndex);
          //AddChatBoardString('TGameConfig.AutoEatHPItem EatHPItem1', c_White, c_Fuchsia);
        end;
      end;
    end;
  end;
begin
  if GetEatIng and (m_MySelf <> nil) and (not Death(m_MySelf)) and (HumHP > 0) then begin
    if Config.boHumUseHP and Config.boHumUseHP1 then begin
      if Config.nHumMinHP1 < Config.nHumMinHP then begin
        if (HumHP < Config.nHumMinHP1) then begin
          if not EatHPItem1(False) then
            if not EatHPItem(False) then
             { if not EatHPItem1(True) then
                if not EatHPItem(True) then  }
        end else begin
          if not EatHPItem(False) then
            if not EatHPItem1(False) then
             { if not EatHPItem(True) then
                if not EatHPItem1(True) then  }
        end;
      end else begin
        if (HumHP < Config.nHumMinHP) then begin
          if not EatHPItem(False) then
            if not EatHPItem1(False) then
              {if not EatHPItem(True) then
                if not EatHPItem1(True) then  }
        end else begin
          if not EatHPItem1(False) then
            if not EatHPItem(False) then
             { if not EatHPItem1(True) then
                if not EatHPItem(True) then  }
        end;
      end;
    end else
      if Config.boHumUseHP and (not Config.boHumUseHP1) then begin
      EatHPItem(False);
    end else
      if (not Config.boHumUseHP) and Config.boHumUseHP1 then begin
      EatHPItem1(False);
    end;
  end;
end;

procedure TGameConfig.AutoEatMPItem(Sender: TObject);
var
  I: Integer;
  nIndex: Integer;
  function EatMPItem(Flag: Boolean): Boolean;
  begin
    Result := False;
    if Config.boHumUseMP then begin
      if {(GetEating) and }(GetTickCount - m_dwHumEatMPTick > Config.nHumMPTime) and (Flag or (HumMP < Config.nHumMinMP)) then begin
        nIndex := FindHumItemIndex(Config.nHumEatMPItem);
        if nIndex >= 0 then begin
          m_dwHumEatMPTick := GetTickCount;
          Result := AutoEatItem(nIndex);
        end;
      end;
    end;
  end;

  function EatMPItem1(Flag: Boolean): Boolean;
  begin
    Result := False;
    if Config.boHumUseMP1 then begin
      if {(GetEating) and }(GetTickCount - m_dwHumEatMPTick1 > Config.nHumMPTime1) and (Flag or (HumMP < Config.nHumMinMP1)) then begin
        nIndex := FindHumItemIndex(Config.nHumEatMPItem1);
        if nIndex >= 0 then begin
          m_dwHumEatMPTick1 := GetTickCount;
          Result := AutoEatItem(nIndex);
        end;
      end;
    end;
  end;

begin
  if GetEatIng and (m_MySelf <> nil) and (not Death(m_MySelf)) and (HumMP > 0) then begin
    if Config.boHumUseMP and Config.boHumUseMP1 then begin
      if Config.nHumMinMP1 < Config.nHumMinMP then begin
        if (HumMP < Config.nHumMinMP1) then begin
          if not EatMPItem1(False) then
            if not EatMPItem(False) then
             { if not EatMPItem1(True) then
                if not EatMPItem(True) then   }
        end else begin
          if not EatMPItem(False) then
            if not EatMPItem1(False) then
            {  if not EatMPItem(True) then
                if not EatMPItem1(True) then    }
        end;
      end else begin
        if (HumMP < Config.nHumMinMP) then begin
          if not EatMPItem(False) then
            if not EatMPItem1(False) then
            {  if not EatMPItem(True) then
                if not EatMPItem1(True) then  }
        end else begin
          if not EatMPItem1(False) then
            if not EatMPItem(False) then
           {   if not EatMPItem1(True) then
                if not EatMPItem(True) then    }
        end;
      end;
    end else
      if Config.boHumUseMP and (not Config.boHumUseMP1) then begin
      EatMPItem(False);
    end else
      if (not Config.boHumUseMP) and Config.boHumUseMP1 then begin
      EatMPItem1(False);
    end;
  end;
end;

procedure TGameConfig.AutoHeroEatHPItem(Sender: TObject);
var
  nIndex: Integer;

  function EatHPItem: Boolean;
  begin
    Result := False;
    if Config.boHeroUseHP then begin
      if {(GetEating) and }(GetTickCount - m_dwHeroEatHPTick > Config.nHeroHPTime) and (HeroHP < Config.nHeroMinHP) then begin
        nIndex := FindHeroItemIndex(Config.nHeroEatHPItem);
        if nIndex >= 0 then begin
          m_dwHeroEatHPTick := GetTickCount;
          Result := AutoHeroEatItem(nIndex);
        end;
      end;
    end;
  end;

  function EatHPItem1: Boolean;
  begin
    Result := False;
    if Config.boHeroUseHP1 then begin
      if {(GetEating) and }(GetTickCount - m_dwHeroEatHPTick1 > Config.nHeroHPTime1) and (HeroHP < Config.nHeroMinHP1) then begin
        nIndex := FindHeroItemIndex(Config.nHeroEatHPItem1);
        if nIndex >= 0 then begin
          m_dwHeroEatHPTick1 := GetTickCount;
          Result := AutoHeroEatItem(nIndex);
        end;
      end;
    end;
  end;

begin
  if GetHeroEatIng and (m_MyHero <> nil) and (not Death(m_MyHero)) and (HeroHP > 0) then begin
    if Config.boHeroUseHP and Config.boHeroUseHP1 then begin
      if Config.nHeroMinHP1 < Config.nHeroMinHP then begin
        if (HeroHP < Config.nHeroMinHP1) then begin
          if not EatHPItem1 then EatHPItem;
        end else begin
          if not EatHPItem then EatHPItem1;
        end;
      end else begin
        if (HeroHP < Config.nHeroMinHP) then begin
          if not EatHPItem then EatHPItem1;
        end else begin
          if not EatHPItem1 then EatHPItem;
        end;
      end;
    end else
      if Config.boHeroUseHP and (not Config.boHeroUseHP1) then begin
      EatHPItem;
    end else
      if (not Config.boHeroUseHP) and Config.boHeroUseHP1 then begin
      EatHPItem1;
    end;
  end;
end;

procedure TGameConfig.AutoHeroEatMPItem(Sender: TObject);
var
  nIndex: Integer;

  function EatMPItem: Boolean;
  begin
    Result := False;
    if Config.boHeroUseMP then begin
      if {(GetEating) and }(GetTickCount - m_dwHeroEatMPTick > Config.nHeroMPTime) and (HeroMP < Config.nHeroMinMP) then begin
        nIndex := FindHeroItemIndex(Config.nHeroEatMPItem);
        if nIndex >= 0 then begin
          m_dwHeroEatMPTick := GetTickCount;
          Result := AutoHeroEatItem(nIndex);
        end;
      end;
    end;
  end;

  function EatMPItem1: Boolean;
  begin
    Result := False;
    if Config.boHeroUseMP1 then begin
      if {(GetEating) and }(GetTickCount - m_dwHeroEatMPTick1 > Config.nHeroMPTime1) and (HeroMP < Config.nHeroMinMP1) then begin
        nIndex := FindHeroItemIndex(Config.nHeroEatMPItem1);
        //SendOutStr('AutoHeroEatMPItem EatMPItem1');
        if nIndex >= 0 then begin
          m_dwHeroEatMPTick1 := GetTickCount;
          Result := AutoHeroEatItem(nIndex);
        end;
      end;
    end;
  end;
begin
  if GetHeroEatIng and (m_MyHero <> nil) and (not Death(m_MyHero)) and (HeroMP > 0) then begin
    if Config.boHeroUseMP and Config.boHeroUseMP1 then begin
      if Config.nHeroMinMP1 < Config.nHeroMinMP then begin
        if (HeroMP < Config.nHeroMinMP1) then begin
          if not EatMPItem1 then EatMPItem;
        end else begin
          if not EatMPItem then EatMPItem1;
        end;
      end else begin
        if (HeroMP < Config.nHeroMinMP) then begin
          if not EatMPItem then EatMPItem1;
        end else begin
          if not EatMPItem1 then EatMPItem;
        end;
      end;
    end else
      if Config.boHeroUseMP and (not Config.boHeroUseMP1) then begin
      EatMPItem;
    end else
      if (not Config.boHeroUseMP) and Config.boHeroUseMP1 then begin
      EatMPItem1;
    end;
  end;
end;

procedure TGameConfig.UseRandomItem(Sender: TObject);
var
  nIndex: Integer;
  nHumHP: Integer;
begin
  if GetEatIng and Config.boUseRandomItem and (m_MySelf <> nil) and (not Death(m_MySelf)) then begin
    nHumHP := HumHP;
    if (nHumHP > 0) and (nHumHP < Config.nRandomItemMinHP) and (not m_boUseRandomItem) then begin

      for nIndex := Low(TItemArr) to High(TItemArr) do begin
        if g_PlugInfo.ItemArr[nIndex].s.Name <> '' then begin
          if (CompareText(Config.sRandomItemName, g_PlugInfo.ItemArr[nIndex].s.Name) = 0) then begin
            if AutoEatItem(nIndex) then begin
              m_dwUseRandomItemTick := GetTickCount + 1000 * 60 * 3;
              m_boUseRandomItem := True;
              AddChatBoardString('血量过低，自动使用' + Config.sRandomItemName + '。', clYellow, clRed);
            end;
            Break;
          end;
        end;
      end;
    end else begin
      if m_boUseRandomItem and (GetTickCount > m_dwUseRandomItemTick) then begin
        m_dwUseRandomItemTick := GetTickCount;
        m_boUseRandomItem := False;
      end;
    end;
  end;
end;

procedure TGameConfig.MoveToHome(Sender: TObject); //回城
var
  nIndex: Integer;
  nHumHP: Integer;
begin
  if GetEatIng and Config.boUseMoveHomeItem and (m_MySelf <> nil) and (not Death(m_MySelf)) then begin
    nHumHP := HumHP;
    if (nHumHP > 0) and (nHumHP < Config.nMoveHomeItemMinHP) and (not m_boUseMoveHomeItem) then begin
      for nIndex := Low(TItemArr) to High(TItemArr) do begin
        if g_PlugInfo.ItemArr[nIndex].s.Name <> '' then begin
          if (CompareText(Config.sMoveHomeItemName, g_PlugInfo.ItemArr[nIndex].s.Name) = 0) then begin
            if AutoEatItem(nIndex) then begin
              m_dwUseMoveHomeItemTick := GetTickCount + 1000 * 30;
              m_boUseMoveHomeItem := True;
              AddChatBoardString('血量过低，自动使用' + Config.sMoveHomeItemName + '！', clYellow, clRed);
            end;
            Break;
          end;
        end;
      end;
    end else begin
      if m_boUseMoveHomeItem and (GetTickCount > m_dwUseMoveHomeItemTick) then begin
        m_dwUseMoveHomeItemTick := GetTickCount;
        m_boUseMoveHomeItem := False;
      end;
    end;
  end;
end;

procedure TGameConfig.ExitClient(Sender: TObject); //退出游戏
var
  nIndex: Integer;
  nHumHP: Integer;
begin
  if Config.boExitClient and (m_MySelf <> nil) and (not Death(m_MySelf)) then begin
    nHumHP := HumHP;
    if (nHumHP > 0) and (nHumHP < Config.nExitClientMinHP) and (not m_boExitClient) then begin
      m_dwExitClientTick := GetTickCount + 1000 * 30;
      m_boExitClient := True;
      g_PlugInfo.LogOut;
      AddChatBoardString('血量过低，正在退出游戏！', clYellow, clRed);
    end else begin
      if m_boExitClient and (GetTickCount > m_dwExitClientTick) then begin
        m_dwExitClientTick := GetTickCount;
        m_boExitClient := False;
      end;
    end;
  end;
end;


procedure TGameConfig.AutoRecallBackHero; //召回英雄
var
  Msg: TDefaultMessage;
begin
  if Config.boHeroTakeback and (m_MyHero <> nil) and (not Death(m_MyHero)) then begin
    if (HeroHP > 0) and (HeroHP <= Config.nTakeBackHeroMinHP) and (not m_boRecallBackHero) then begin
      m_dwHintRecallBackHero := GetTickCount;
      AddChatBoardString('英雄血量过低,自动召回。', clYellow, clRed);
      m_dwRecallBackHero := GetTickCount + 1000 * 30;
      Msg := MakeDefaultMsg(CM_RECALLHERO, RecogId(m_MyHero), 0, 0, 0);
      SendSocket(EncodeMessage(Msg));
      m_MyHero := nil;
      m_boRecallBackHero := True;

    end else begin
      if m_boRecallBackHero then begin
        if (GetTickCount > m_dwRecallBackHero) then begin
          m_dwRecallBackHero := GetTickCount;
          m_boRecallBackHero := False;
        end else begin
          if (m_MyHero <> nil) and (not Death(m_MyHero)) and (HeroHP > 0) and (HeroHP <= Config.nTakeBackHeroMinHP) and (GetTickCount - m_dwHintRecallBackHero > 1000 * 5) then begin
            m_dwHintRecallBackHero := GetTickCount;
            AddChatBoardString('英雄血量过低 [' + IntToStr((m_dwRecallBackHero - GetTickCount) div 1000) + '] 秒后，自动召回。', clYellow, clRed);
          end;
        end;
      end;
    end;
  end;
end;

procedure TGameConfig.ClearDeath; //清除尸体
var
  I: Integer;
  ActorList: TList;
  Actor: TActor;
begin
  if Config.boAutoClearDeath then begin
    if GetTickCount - m_dwClearDeathTick > Config.nAutoClearDeathTime * 1000 then begin
      m_dwClearDeathTick := GetTickCount;
      g_PlugInfo.List_Count(g_PlugInfo.ActorList);
      for I := g_PlugInfo.List_Count(g_PlugInfo.ActorList) - 1 downto 0 do begin
        Actor := TActor(g_PlugInfo.List_Get(g_PlugInfo.ActorList, I));
        if Death(Actor) then begin
          g_PlugInfo.DeleteActor(RecogId(Actor));
        end;
      end;
    end;
  end;
end;

procedure TGameConfig.AutoOrderItem; //自动放药
var
  I, II, nIndex: Integer;
  StdItem: TStdItem;
  boFind: Boolean;
  btBindItemType: Byte;
  sName: string;
  sBindItemName: string;
begin
  if Config.boOrderItem and (g_PlugInfo.EatingItem.s.Name = '') and
    (g_PlugInfo.WaitingUseItem.Item.s.Name = '') then begin
    if (g_PlugInfo.MovingItem.Item.s.Name <> '') then begin
      for I := Low(m_OldItemArr) to High(m_OldItemArr) do begin
        if (g_PlugInfo.ItemArr[I].S.Name <> m_OldItemArr[I].S.Name) then begin
          m_OldItemArr[I] := g_PlugInfo.ItemArr[I];
        end;
      end;
      Exit;
    end;

    for I := Low(m_OldItemArr) to High(m_OldItemArr) do begin
      if g_PlugInfo.ItemArr[I].S.Name <> '' then begin
        if (g_PlugInfo.ItemArr[I].S.Name <> m_OldItemArr[I].S.Name) then begin
          m_OldItemArr[I] := g_PlugInfo.ItemArr[I];
        end;
      end;
    end;

    for I := Low(m_OldItemArr) to High(m_OldItemArr) do begin
      if (g_PlugInfo.ItemArr[I].S.Name = '') and (m_OldItemArr[I].S.Name <> '') then begin
        boFind := False;
        for II := Low(TItemArr) + 6 to High(TItemArr) do begin
          if g_PlugInfo.ItemArr[II].S.Name <> '' then begin
            if (g_PlugInfo.ItemArr[II].S.Name = m_OldItemArr[I].S.Name) then begin
              g_PlugInfo.ItemArr[I] := g_PlugInfo.ItemArr[II];
              g_PlugInfo.ItemArr[II].S.Name := '';
              boFind := True;
              Break;
            end;
          end;
        end;

        if not boFind then begin //查找解包
          if BagItemCount <= 40 then begin
            nIndex := FindItemArrBindItemName(m_OldItemArr[I].S.Name);
            if nIndex >= 0 then begin
              AutoEatItem(nIndex);
            end else m_OldItemArr[I].S.Name := '';
          end;
        end;
      end;
    end;
  end;
end;

procedure TGameConfig.ShowItemDura(Surface: TDirectDrawSurface);
var
  I, n10: Integer;
  Str: string;
begin
  {if Config.boItemDuraHint then begin
    n10 := 0;
    for I := U_DRESS to U_CHARM do begin
      case I of
        U_DRESS: begin
            Str := '衣  服： ';
          end;
        U_WEAPON: begin
            Str := '武  器： ';
          end;
        U_RIGHTHAND: begin
            Str := '手  持： ';
          end;
        U_NECKLACE: begin
            Str := '项  链： ';
          end;
        U_HELMET: begin
            Str := '头  盔： ';
          end;
        U_ARMRINGL: begin
            Str := '左手镯： ';
          end;
        U_ARMRINGR: begin
            Str := '右手镯： ';
          end;
        U_RINGL: begin
            Str := '左戒指： ';
          end;
        U_RINGR: begin
            Str := '右戒指： ';
          end;
        U_BUJUK: begin
            Str := '消耗品： ';
          end;
        U_BELT: begin
            Str := '腰  带： ';
          end;
        U_BOOTS: begin
            Str := '鞋  子： ';
          end;
        U_CHARM: begin
            Str := '宝  石： ';
          end;
      end;

      if (g_UseItems[I].S.Name <> '') and (g_UseItems[I].Dura <= g_UseItems[I].DuraMax * 10 div 100) then begin
        Str := Str + g_UseItems[I].S.Name + Format('(%d/%d)%d', [g_UseItems[I].Dura, g_UseItems[I].DuraMax, g_UseItems[I].MakeIndex]);
        BoldTextOut(MSurface, 30, 30 + ((Canvas.TextHeight('A') div 3) + Canvas.TextHeight('A')) * n10, clWhite, clblack, Str);
        Inc(n10);
      end;
    end;
  end;}
end;

procedure TGameConfig.HintItemDura();
var
  I: Integer;
  sHint: string;
begin
  if Config.boItemDuraHint then begin
    if GetTickCount - m_dwHintItemDuraTick > 1000 * 2 then begin
      m_dwHintItemDuraTick := GetTickCount;
      for I := U_DRESS to U_CHARM do begin
        if g_PlugInfo.UseItems[I].S.Name <> '' then begin
          if g_PlugInfo.UseItems[I].Dura < Round(g_PlugInfo.UseItems[I].DuraMax * 2 / 100) then begin
            sHint := g_PlugInfo.UseItems[I].S.Name + ' 持久过低';
            AddChatBoardString(sHint, clyellow, clRed);
          end;
        end;
      end;
    end;
  end;
end;

procedure TGameConfig.RecallHero; //召回英雄
var
  Msg: TDefaultMessage;
begin
  if (m_MySelf = nil) or (m_MyHero = nil) then Exit;
  Msg := MakeDefaultMsg(CM_RECALLHERO, RecogId(m_MySelf), 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TGameConfig.ShowConfig;
begin
  if FrmMain = nil then begin
    if g_PlugInfo.FullScreen^ then begin
      FrmMain := TFrmMain.CreateParented(g_PlugInfo.AppHandle);
      //FrmMain.ParentWindow := g_PlugInfo.AppHandle;
      FrmMain.Left := 0;
      FrmMain.Top := 0;
    end else begin
      FrmMain := TFrmMain.Create(nil);
      FrmMain.FormStyle := fsStayOnTop;
    end;
  end;
  FrmMain.Show;
  //FrmMain.Visible:=True;
end;

procedure TGameConfig.CloseConfig;
begin
  if FrmMain <> nil then FrmMain.Close;
end;

procedure TGameConfig.OnTime(Sender: TObject);
begin
  Initialize;
  if m_MySelf <> nil then begin
    AutoOrderItem; //自动放药
    AutoUseItem(Self);
    HintBossMon; //BOSS提示
    HintSuperItem; //极品提示
    AutoUseMagic; //自动使用魔法
    HintItemDura(); //持久警告
    ClearDeath; //清除尸体
  end;
end;

function TGameConfig.GetMagicByKey(Key: Char): PTClientMagic;
var
  I: Integer;
  pm: PTClientMagic;
begin
  Result := nil;
  for I := 0 to g_PlugInfo.List_Count(g_PlugInfo.MagicList) - 1 do begin
    pm := PTClientMagic(g_PlugInfo.List_Get(g_PlugInfo.MagicList, I));
    if pm.Key = Key then begin
      Result := pm;
      Break;
    end;
  end;
end;

procedure TGameConfig.SendTakeOnItem(where: Byte; itmindex: Integer; itmname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_TAKEONITEM, itmindex, where, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itmname));
end;

procedure TGameConfig.SendTakeOffItem(where: Byte; itmindex: Integer; itmname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_TAKEOFFITEM, itmindex, where, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itmname));
end;

procedure TGameConfig.TakeOnItem(nType, nCount: Integer);
var
  I: Integer;
  sName: string;
begin
  if g_PlugInfo.WaitingUseItem.Item.S.Name = '' then begin
    for I := Low(TItemArr) to High(TItemArr) do begin
    {DScreen.AddChatBoardString('g_ItemArr[I].S.StdMode ' + IntTostr(g_ItemArr[I].S.StdMode), clyellow, clRed);
    DScreen.AddChatBoardString('g_ItemArr[I].S.Shape ' + IntTostr(g_ItemArr[I].S.Shape), clyellow, clRed);
    DScreen.AddChatBoardString('Round(g_UseItems[I].Dura / 100) ' + IntTostr(Round(g_UseItems[I].Dura / 100)), clyellow, clRed);}
      if (g_PlugInfo.ItemArr[I].S.Name <> '') and (g_PlugInfo.ItemArr[I].S.StdMode = 25) and (g_PlugInfo.ItemArr[I].S.Shape = nType) and (Round(g_PlugInfo.ItemArr[I].Dura / 100) >= nCount) then begin
        g_PlugInfo.WaitingUseItem.Item := g_PlugInfo.ItemArr[I];
        g_PlugInfo.WaitingUseItem.Index := U_BUJUK;
        g_PlugInfo.ItemArr[I].S.Name := '';
        sName := g_PlugInfo.WaitingUseItem.Item.S.Name;
        SendTakeOnItem(U_BUJUK, g_PlugInfo.WaitingUseItem.Item.MakeIndex, sName);
      //DScreen.AddChatBoardString('TakeOnItem ' + sName, clyellow, clRed);
        Break;
      end;
    end;
  end;
end;

function TGameConfig.KeyDown(Key: Word; Shift: TShiftState): Boolean;
  function IsWarrSkill(wMagIdx: Integer): Boolean; //是否是战士技能
  begin
    Result := False;
    if wMagIdx in [3, 4, 7, 12, 25, 26, 27, 40, 43, 58, 60, 77] then
      Result := True;
  end;
var
  ActionKey: Word;
  Magic: pTClientMagic;
  nCount: Integer;
begin
  Result := False;
  case Key of
    VK_HOME, VK_F12: begin
        if g_PlugInfo.ServerConfig.btGameOptionType = 1 then begin
          Result := True;
          if (FrmMain = nil) or (not FrmMain.Visible) then begin
            ShowConfig; //if g_PlugInfo.MySelf^ <> nil then
          end else begin
            CloseConfig;
          end;
        end;
      end;
    VK_F1, VK_F2, VK_F3, VK_F4,
      VK_F5, VK_F6, VK_F7, VK_F8: begin
        if ssCtrl in Shift then begin
          ActionKey := Key - 100;
        end else begin
          ActionKey := Key;
        end;
        Magic := nil;
        case ActionKey of
          VK_F1, VK_F2, VK_F3, VK_F4, VK_F5, VK_F6, VK_F7, VK_F8: begin
              Magic := GetMagicByKey(Char((ActionKey - VK_F1) + Byte('1')));
            end;
          12..19: begin
              Magic := GetMagicByKey(Char((ActionKey - 12) + Byte('1') + Byte($14)));
            end;
        end;
        if Magic <> nil then begin
          if Config.boUseSpellOffHoser then begin
            if not IsWarrSkill(Magic.Def.wMagicId) then begin
              if g_PlugInfo.Actor_btHorse(m_MySelf)^ > 0 then begin
                SendClientMessage(5059, 0, 0, 0, 0);
              end;
            end;
          end;

          if Config.boAutoChgItem and (g_PlugInfo.WaitingUseItem.Item.S.Name = '') then begin
            case Magic.Def.wMagicId of //自动换毒
              6, 38: begin
                  if Config.boAutoChgItemReplace then begin
                    if m_nNextChgItem < 0 then m_nNextChgItem := Config.nChgItemIndex + 1;
                    if (g_PlugInfo.UseItems[U_BUJUK].S.Name = '') or (g_PlugInfo.UseItems[U_BUJUK].S.StdMode <> 25) or (g_PlugInfo.UseItems[U_BUJUK].S.Shape <> m_nNextChgItem) then begin
                      TakeOnItem(m_nNextChgItem, 1);
                      Inc(m_nNextChgItem);
                      if m_nNextChgItem > 2 then m_nNextChgItem := 1;
                      //g_dwProcessKeyTick := GetTickCount;
              //DScreen.AddChatBoardString('AutoChgItemType3' , clyellow, clRed);
                    end;
                  end else begin
                    m_nNextChgItem := Config.nChgItemIndex + 1;
                    if (g_PlugInfo.UseItems[U_BUJUK].S.Name = '') or (g_PlugInfo.UseItems[U_BUJUK].S.StdMode <> 25) or (g_PlugInfo.UseItems[U_BUJUK].S.Shape <> m_nNextChgItem) then begin
                      TakeOnItem(m_nNextChgItem, 1);
                      //g_dwProcessKeyTick := GetTickCount;
                    end;
                  end;
                end;
              13, 14, 15, 16, 17, 18, 19, 30, 57, 72, 76: begin //自动换符
                  nCount := 1;
                  if (Magic.Def.wMagicId = 30) or (Magic.Def.wMagicId = 72) then nCount := 5;
                  if (g_PlugInfo.UseItems[U_BUJUK].S.Name = '') or (g_PlugInfo.UseItems[U_BUJUK].S.StdMode <> 25) or (g_PlugInfo.UseItems[U_BUJUK].S.Shape <> 5) then begin
                    TakeOnItem(5, nCount);
                    //g_dwProcessKeyTick := GetTickCount;
                  end else begin
                    if (Round(g_PlugInfo.UseItems[U_BUJUK].Dura / 100) < nCount) then begin
                      TakeOnItem(5, nCount);
                      //g_dwProcessKeyTick := GetTickCount;
                    end;
                  end;
                end;
              52: begin //自动换符 诅咒术
                  if (g_PlugInfo.UseItems[U_BUJUK].S.Name = '') or (g_PlugInfo.UseItems[U_BUJUK].S.StdMode <> 25) or (g_PlugInfo.UseItems[U_BUJUK].S.Shape <> 3) then begin
                    TakeOnItem(3, 3);
                    //g_dwProcessKeyTick := GetTickCount;
                  end else begin
                    if (Round(g_PlugInfo.UseItems[U_BUJUK].Dura / 100) < 3) then begin
                      TakeOnItem(3, 3);
                      //g_dwProcessKeyTick := GetTickCount;
                    end;
                  end;
                end;
            end;
          end;

        end;
      end;
  end;
end;

function TGameConfig.KeyPress(Key: Char): Boolean;
begin

end;

end.

