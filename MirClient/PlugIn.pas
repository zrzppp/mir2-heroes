unit PlugIn;

interface
uses
  Windows, Classes, SysUtils, Graphics, Controls, Dialogs, Forms, Grids, Textures, Actor, {DrawScrn, }
  FState, Grobal2, GameImages, DWinCtl, IntroScn, SoundUtil, Share, MShare;

type
  PTObject = ^TObject;

  TShortString = packed record
    btLen: Byte;
    Strings: array[0..High(Byte) - 1] of Char;
  end;
  PTShortString = ^TShortString;


  TList_Create = function: TList; stdcall;
  TList_Free = procedure(List: TList); stdcall;
  TList_Count = function(List: TList): Integer; stdcall;
  TList_Add = function(List: TList; Item: Pointer): Integer; stdcall;
  TList_Insert = procedure(List: TList; nIndex: Integer; Item: Pointer); stdcall;

  TList_Get = function(List: TList; nIndex: Integer): Pointer; stdcall;
  TList_Put = procedure(List: TList; nIndex: Integer; Item: Pointer); stdcall;
  TList_Delete = procedure(List: TList; nIndex: Integer); stdcall;
  TList_Clear = procedure(List: TList); stdcall;
  TList_Exchange = procedure(List: TList; nIndex1, nIndex2: Integer); stdcall;

  TStringList_Create = function: TStringList; stdcall;
  TStringList_Free = procedure(List: TStringList); stdcall;
  TStringList_Count = function(List: TStringList): Integer; stdcall;
  TStringList_Add = function(List: TStringList; S: PChar): Integer; stdcall;
  TStringList_AddObject = function(List: TStringList; S: PChar; AObject: TObject): Integer; stdcall;
  TStringList_Insert = procedure(List: TStringList; nIndex: Integer; S: PChar); stdcall;
  TStringList_Get = function(List: TStringList; nIndex: Integer): PChar; stdcall;
  TStringList_GetObject = function(List: TStringList; nIndex: Integer): TObject; stdcall;
  TStringList_Put = procedure(List: TStringList; nIndex: Integer; S: PChar); stdcall;
  TStringList_PutObject = procedure(List: TStringList; nIndex: Integer; AObject: TObject); stdcall;
  TStringList_Delete = procedure(List: TStringList; nIndex: Integer); stdcall;
  TStringList_Clear = procedure(List: TStringList); stdcall;
  TStringList_Exchange = procedure(List: TStringList; nIndex1, nIndex2: Integer); stdcall;
  TStringList_LoadFormFile = procedure(List: TStringList; pszFileName: PChar); stdcall;
  TStringList_SaveToFile = procedure(List: TStringList; pszFileName: PChar); stdcall;








  TGetRGB = function(btColor: Byte): TColor;
  TDraw = procedure(Dest: TTexture; X, Y: Integer; Source: TTexture; Transparent: Boolean); stdcall;
  TDrawRect = procedure(Dest: TTexture; X, Y: Integer; SrcRect: TRect; Source: TTexture; Transparent: Boolean); stdcall;
  TDrawAlpha = procedure(Dest: TTexture; const DestRect, SrcRect: TRect; Source: TTexture; Transparent: Boolean; Alpha: Integer); stdcall;
  TStretchDraw = procedure(Dest: TTexture; const DestRect, SrcRect: TRect; Source: TTexture; Transparent: Boolean); stdcall;
  TDrawBlend = procedure(Dest: TTexture; X, Y: Integer; Source: TTexture); stdcall;

  TFill = procedure(Dest: TTexture; DevColor: Longint); stdcall;
  TFillRect = procedure(Dest: TTexture; const Rect: TRect; DevColor: Longint); stdcall;
  TFillRectAlpha = procedure(Dest: TTexture; const DestRect: TRect; Color: TColor; Alpha: Integer); stdcall;



  TServerName = procedure(ShortString: PTShortString); stdcall;
  TSetName = procedure(SelChrName: PChar); stdcall;

  TOpenHomePage = procedure(HomePage: PChar); stdcall;




  TSetActiveControl = procedure(Control: TWinControl); stdcall;

  TDecodeMessagePacket = function(DefMsg: pTDefaultMessage; InData, OutData: PChar; var Len: Integer): Boolean; stdcall;
  TInitialize = procedure; stdcall;
  TKeyDown = function(Key: Word; Shift: TShiftState): Boolean; stdcall;
  TKeyPress = function(Key: Char): Boolean; stdcall;

  TFlip = procedure(Surface: TTexture); stdcall;

  TScene = function(Surface: TTexture): Boolean; stdcall;

  TChangeScene = procedure(SceneType: TSceneType); stdcall;

  TOpenLoginDoor = function: Boolean; stdcall;


  TShowMonName = function(Name: PChar): Boolean; stdcall;
  TShowItemName = function(Name: PChar; var btColor: Byte): Boolean; stdcall;

  TSocketConnect = procedure; stdcall;
  TSocketRead = function(Data: PChar; Len: Integer): Boolean; stdcall;
  TSendSocket = function(Data: PChar; Len: Integer): Boolean; stdcall;
  TClientGetMessage = function(Data: PChar; Len: Integer; FColor, BColor: Integer): Boolean; stdcall;
  TClientObjStruck = function(DefMsg: pTDefaultMessage; Data: PChar; Len: Integer): Boolean; stdcall;
  TLogout = function: Boolean; stdcall;
  TMessageDlg = function(Msg: PChar; DlgButtons: TMsgDlgButtons): TModalResult; stdcall;
  TAddSysMsg = procedure(Data: PChar; X, Y: Integer; Color: Integer); stdcall;
  TAddChatBoardString = procedure(Data: PChar; FColor, BColor: Integer); stdcall;
  TShowHint = procedure(X, Y: Integer; Text: PChar; Color: TColor; drawup: Boolean); stdcall;

  TTextOut = procedure(Surface: TTexture; X, Y, FColor, BColor: Integer; Text: PChar); stdcall;
  TTextRect = procedure(Surface: TTexture; Rect: TRect; X, Y, FColor, BColor: Integer; Text: PChar); stdcall;
  TPomiTextOut = procedure(dsurface: TTexture; X, Y: Integer; Str: PChar); stdcall;
  TTextWidth = function(const Text: PChar): Integer; stdcall;
  TTextHeight = function(const Text: PChar): Integer; stdcall;

  TGetFontName = function: PChar; stdcall;
  TGetFontSize = function: Integer; stdcall;
  TGetFontStyle = function: TFontStyles; stdcall;

  TSetFontName = procedure(Name: PChar); stdcall;
  TSetFontSize = procedure(Size: Integer); stdcall;
  TSetFontStyle = procedure(Style: TFontStyles); stdcall;


  TUseMagic = procedure(X, Y: Integer; Magic: pTClientMagic); stdcall;

  TGetMouseItemInfo = procedure(Actor: TActor; MouseItem: pTClientItem; PName, PLine1, PLine2, PLine3: PTShortString; var useable: Boolean); stdcall;

  TScreenXYfromMCXY = procedure(cx, cy: Integer; var sx, sY: Integer); stdcall;
  TCXYfromMouseXY = procedure(mx, my: Integer; var ccx, ccy: Integer); stdcall;

  TIsSelectMyself = function(X, Y: Integer): Boolean; stdcall;
  TGetXYDropItems = function(nX, nY: Integer): pTDropItem; stdcall;

  TCanRun = function(sx, sY, ex, ey: Integer): Boolean; stdcall;
  TCanWalk = function(mx, my: Integer): Boolean; stdcall;
  TCanWalkEx = function(mx, my: Integer): Boolean; stdcall;
  TCrashMan = function(mx, my: Integer): Boolean; stdcall;
  TCanFly = function(mx, my: Integer): Boolean; stdcall;

  TPlaySoundEx = procedure(Idx: Integer); stdcall;


  TActor_nRecogId = function(Actor: TActor): PInteger; stdcall; //角色标识 0x4
  TActor_nCurrX = function(Actor: TActor): PInteger; stdcall; //当前所在地图座标X 0x08
  TActor_nCurrY = function(Actor: TActor): PInteger; stdcall; //当前所在地图座标Y 0x0A
  TActor_btDir = function(Actor: TActor): PByte; stdcall; //当前站立方向 0x0C
  TActor_btSex = function(Actor: TActor): PByte; stdcall; //性别 0x0D
  TActor_btRace = function(Actor: TActor): PByte; stdcall; //0x0E
  TActor_btHair = function(Actor: TActor): PByte; stdcall; //头发类型 0x0F
  TActor_btDress = function(Actor: TActor): PByte; stdcall; //衣服类型 0x10
  TActor_btWeapon = function(Actor: TActor): PByte; stdcall; //武器类型
  TActor_btHorse = function(Actor: TActor): PByte; stdcall; //马类型
  TActor_btJob = function(Actor: TActor): PByte; stdcall;
  TActor_wAppearance = function(Actor: TActor): PWord; stdcall; //0x14
  TActor_btDeathState = function(Actor: TActor): PByte; stdcall;
  TActor_nFeature = function(Actor: TActor): PInteger; stdcall; //0x18
  TActor_nFeatureEx = function(Actor: TActor): PInteger; stdcall; //0x18
  TActor_nState = function(Actor: TActor): PInteger; stdcall; //0x1C
  TActor_boDeath = function(Actor: TActor): PBoolean; stdcall; //0x20
  TActor_boDelActor = function(Actor: TActor): PBoolean; stdcall; //0x22
  TActor_boDelActionAfterFinished = function(Actor: TActor): PBoolean; stdcall; //0x23
  TActor_sDescUserName = function(Actor: TActor): PChar; stdcall; //人物名称，后缀
  TActor_sUserName = function(Actor: TActor): PChar; stdcall; //0x28
  TActor_nNameColor = function(Actor: TActor): PInteger; stdcall; //0x2C
  TActor_Abil = function(Actor: TActor): PTAbility; stdcall; //0x30
  TActor_nGold = function(Actor: TActor): PInteger; stdcall; //金币数量0x58
  TActor_nGameGold = function(Actor: TActor): PInteger; stdcall; //游戏币数量
  TActor_nGamePoint = function(Actor: TActor): PInteger; stdcall; //游戏点数量

  TDeleteActor = procedure(RecogId: Integer); stdcall;

  TDataType = (t_Wil, t_Wis, t_Uib, t_Data);

  TCreateImage = function: TGameImages; stdcall;

  TDoImage = procedure(Image: TGameImages); stdcall;

  TGetImageIndexList = function(Image: TGameImages): TList; stdcall;

  TImageConfig = record
    FileName: PChar;
    Image: TDataType;
  end;
  pTImageConfig = ^TImageConfig;

  TSeTImageConfig = procedure(Image: TGameImages; Config: pTImageConfig); stdcall;

  TImageInfo = record
    Surface: TTexture;
    X: Integer;
    Y: Integer;
    Width: Integer;
    Height: Integer;
  end;
  pTImageInfo = ^TImageInfo;

  TGetImageInfo = procedure(Image: TGameImages; Index: Integer; ImageInfo: pTImageInfo); stdcall;

  TImageManage = record
    Create: TCreateImage;
    Free: TDoImage;
    Initialize: TDoImage;
    Finalize: TDoImage;

    SetConfig: TSeTImageConfig;
    GetImageInfo: TGetImageInfo;
    GetImageIndexList: TGetImageIndexList;

    WEffectImg: TGameImages;
    WDragonImg: TGameImages;

    WMainImages: TGameImages;
    WMain2Images: TGameImages;
    WMain3Images: TGameImages;
    WChrSelImages: TGameImages;
    WMMapImages: TGameImages;
    WTilesImages: TGameImages;
    WSmTilesImages: TGameImages;
    WHumWingImages: TGameImages;
    WHum1WingImages: TGameImages;
    WHum2WingImages: TGameImages;
    WBagItemImages: TGameImages;
    WStateItemImages: TGameImages;
    WDnItemImages: TGameImages;
    WHumImgImages: TGameImages;
    WHairImgImages: TGameImages;
    WHair2ImgImages: TGameImages;
    WWeaponImages: TGameImages;
    WMagIconImages: TGameImages;
    WNpcImgImages: TGameImages;
    WMagicImages: TGameImages;
    WMagic2Images: TGameImages;
    WMagic3Images: TGameImages;
    WMagic4Images: TGameImages;
    WMagic5Images: TGameImages;
    WMagic6Images: TGameImages;
    WMagic7Images: TGameImages;
    WMagic8Images: TGameImages;

    WUIBImages: TGameImages;
    WBookImages: TGameImages;
    WMiniMapImages: TGameImages;
    WCqFirImages: TGameImages;
    WKInterfaceImages: TGameImages;
    WHorseImages: TGameImages;
    WHumHorseImages: TGameImages;
    WHairHorseImages: TGameImages;
  end;
  pTImageManage = ^TImageManage;


  TGuiType = (g_Button, g_Window, g_Edit, g_Label, g_Grid);

  TCreateGui = function(Gui: TGuiType): TDControl; stdcall;

  TDoGui = procedure(Gui: TDControl); stdcall;

  TSetImgIndex = procedure(Gui: TDControl; Lib: TGameImages; Index: Integer); stdcall;

  TGetGuiMouseMoved = function(Gui: TDControl): Boolean; stdcall;
  TGetGuiDowned = function(Gui: TDControl): Boolean; stdcall;

  TGetGuiVisible = function(Gui: TDControl): PBoolean; stdcall;
  TGetGuiEnableFocus = function(Gui: TDControl): PBoolean; stdcall;
  TGetGuiImage = function(Gui: TDControl): TGameImages; stdcall;
  TGetGuiFaceIndex = function(Gui: TDControl): PInteger; stdcall;
  TGetGuiLeft = function(Gui: TDControl): PInteger; stdcall;
  TGetGuiTop = function(Gui: TDControl): PInteger; stdcall;
  TGetGuiWidth = function(Gui: TDControl): PInteger; stdcall;
  TGetGuiHeight = function(Gui: TDControl): PInteger; stdcall;

  TGetWindowFloating = function(Gui: TDWindow): PBoolean; stdcall;

  TGetGridColCount = function(Gui: TDGrid): PInteger; stdcall;
  TGetGridRowCount = function(Gui: TDGrid): PInteger; stdcall;
  TGetGridColWidth = function(Gui: TDGrid): PInteger; stdcall;
  TGetGridRowHeight = function(Gui: TDGrid): PInteger; stdcall;

  TGetEditPaste = function(Gui: TDEdit): PBoolean; stdcall;
  TGetEditDrawBkgrnd = function(Gui: TDEdit): PBoolean; stdcall;
  TGetEditDrawBorder = function(Gui: TDEdit): PBoolean; stdcall;
  TGetEditPasswordChar = function(Gui: TDEdit): PChar; stdcall;
  TGetEditAllowSelectText = function(Gui: TDEdit): PBoolean; stdcall;
  TSetGuiImage = procedure(Gui: TDControl; Image: TGameImages); stdcall;
  TSetFocus = procedure(Gui: TDControl); stdcall;

  TSetLabelCaption = procedure(Gui: TDLabel; Caption: PChar); stdcall;
  TSetEditText = procedure(Gui: TDEdit; Text: PChar); stdcall;
  TGetLabelCaption = procedure(Gui: TDLabel; Caption: PTShortString); stdcall;
  TGetEditText = procedure(Gui: TDEdit; Text: PTShortString); stdcall;

  TSetGuiFontSize = procedure(Gui: TDControl; Size: Integer); stdcall;
  TSetGuiFontName = procedure(Gui: TDControl; Name: PChar); stdcall;
  TSetGuiFontStyle = procedure(Gui: TDControl; Style: TFontStyles); stdcall;
  TSetGuiFontColor = procedure(Gui: TDControl; Color: TColor); stdcall;

  TSetLabelHotColor = procedure(Gui: TDControl; Color: TColor); stdcall;
  TSetLabelDownColor = procedure(Gui: TDControl; Color: TColor); stdcall;



  TOn_DirectPaint = procedure(Sender: TObject; dsurface: TTexture); stdcall;
  TOn_KeyPress = procedure(Sender: TObject; var Key: Char); stdcall;
  TOn_KeyDown = procedure(Sender: TObject; var Key: Word; Shift: TShiftState); stdcall;
  TOn_MouseMove = procedure(Sender: TObject; Shift: TShiftState; X, Y: Integer); stdcall;
  TOn_MouseDown = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); stdcall;
  TOn_MouseUp = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); stdcall;
  TOn_Click = procedure(Sender: TObject); stdcall;
  TOn_ClickEx = procedure(Sender: TObject; X, Y: Integer); stdcall;
  TOn_ButtonClick = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); stdcall;
  TOn_InRealArea = procedure(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean); stdcall;
  TOn_GridSelect = procedure(Sender: TObject; ACol, ARow: Integer; Shift: TShiftState); stdcall;
  TOn_GridMouseMove = procedure(Sender: TObject; ACol, ARow: Integer; Shift: TShiftState); stdcall;
  TOn_GridPaint = procedure(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState; dsurface: TTexture); stdcall;
  TOn_ClickSound = procedure(Sender: TObject; Clicksound: TClickSound); stdcall;
  TOn_ItemClick = procedure(Sender: TObject; Itemindex: Integer); stdcall;

  TSetOnDirectPaint = procedure(Gui: TDControl; OnDirectPaint: TOn_DirectPaint); stdcall;
  TSetOnKeyPress = procedure(Gui: TDControl; OnKeyPress: TOn_KeyPress); stdcall;
  TSetOnKeyDown = procedure(Gui: TDControl; OnKeyDown: TOn_KeyDown); stdcall;
  TSetOnMouseMove = procedure(Gui: TDControl; OnMouseMove: TOn_MouseMove); stdcall;
  TSetOnMouseDown = procedure(Gui: TDControl; OnMouseDown: TOn_MouseDown); stdcall;
  TSetOnMouseUp = procedure(Gui: TDControl; OnMouseUp: TOn_MouseUp); stdcall;

  TSetOnDblClick = procedure(Gui: TDControl; OnDblClick: TOn_Click); stdcall;
  TSetOnClick = procedure(Gui: TDControl; OnClick: TOn_ClickEx); stdcall;
  TSetOnButtonClick = procedure(Gui: TDControl; OnButtonClick: TOn_ButtonClick); stdcall;
  TSetOnInRealArea = procedure(Gui: TDControl; OnInRealArea: TOn_InRealArea); stdcall;
  TSetOnClickSound = procedure(Gui: TDControl; OnClickSound: TOn_ClickSound); stdcall;

  TSetOnGridSelect = procedure(Gui: TDGrid; OnGridSelect: TOn_GridSelect); stdcall;
  TSetOnGridMouseMove = procedure(Gui: TDGrid; OnGridMouseMove: TOn_GridMouseMove); stdcall;
  TSetOnGridPaint = procedure(Gui: TDGrid; OnGridPaint: TOn_GridPaint); stdcall;

  TSetOnItemClick = procedure(Gui: TDLabel; OnItemClick: TOn_ItemClick); stdcall;

  TSurfaceX = function(Gui: TDControl): Integer; stdcall;
  TSurfaceY = function(Gui: TDControl): Integer; stdcall;

  TGuiConfig = record
    Visible: Boolean;
    EnableFocus: Boolean;
    Left, Top, FaceIndex: Integer;

    Image: TGameImages;
    DParent: TDControl;
    OnDirectPaint: TOn_DirectPaint;
    OnKeyPress: TOn_KeyPress;
    OnKeyDown: TOn_KeyDown;
    OnMouseMove: TOn_MouseMove;
    OnMouseDown: TOn_MouseDown;
    OnMouseUp: TOn_MouseUp;
    OnDblClick: TOn_Click;
    OnClick: TOn_ClickEx;
    OnInRealArea: TOn_InRealArea;
    OnBackgroundClick: TOn_Click;
    OnButtonClick: TOn_ButtonClick;
    OnGridSelect: TOn_GridSelect;
    OnGridMouseMove: TOn_GridMouseMove;
    OnGridPaint: TOn_GridPaint;
    OnClickSound: TOn_ClickSound;
  end;
  pTGuiConfig = ^TGuiConfig;

  TSetGuiConfig = procedure(Gui: TDControl; Config: pTGuiConfig); stdcall;

  TGetDParent = function(Gui: TDControl): TDControl; stdcall;
  TSetDParent = procedure(Gui: TDControl; DParent: TDControl); stdcall;

  TGuiInfo = record
    Image: TGameImages;
    DParent: TDControl;
    Name: PChar;
    Visible: Boolean;
    EnableFocus: Boolean;
    Left, Top, Width, Height, FaceIndex: Integer;
    ClientRect: TRect;
    DControls: TList;
  end;
  pTGuiInfo = ^TGuiInfo;

  TGetGuiInfo = procedure(Gui: TDControl; GuiInfo: pTGuiInfo); stdcall;
  TSetEditMainMenu = procedure(GuiDEdit: TDEdit; GuiMenu: TDControl); stdcall;

  TGuiManage = record
    DWinList: TList;

    Create: TCreateGui;
    Free: TDoGui;
    SetConfig: TSetGuiConfig;
    GetGuiInfo: TGetGuiInfo;
    SetEditMainMenu: TSetEditMainMenu;
    GetGuiImage: TGetGuiImage;
    SetGuiImage: TSetGuiImage;
    GetDParent: TGetDParent;
    SetDParent: TSetDParent;
    SurfaceX: TSurfaceX;
    SurfaceY: TSurfaceY;
    SetImgIndex: TSetImgIndex;

    SetFocus: TSetFocus;

    SetOnDirectPaint: TSetOnDirectPaint;
    SetOnKeyPress: TSetOnKeyPress;
    SetOnKeyDown: TSetOnKeyDown;
    SetOnMouseMove: TSetOnMouseMove;
    SetOnMouseDown: TSetOnMouseDown;
    SetOnMouseUp: TSetOnMouseUp;

    SetOnDblClick: TSetOnDblClick;
    SetOnClick: TSetOnClick;
    SetOnButtonClick: TSetOnButtonClick;
    SetOnInRealArea: TSetOnInRealArea;
    SetOnClickSound: TSetOnClickSound;

    SetOnGridSelect: TSetOnGridSelect;
    SetOnGridMouseMove: TSetOnGridMouseMove;
    SetOnGridPaint: TSetOnGridPaint;
    SetOnItemClick: TSetOnItemClick;


    GetGuiMouseMoved: TGetGuiMouseMoved;
    GetGuiDowned: TGetGuiDowned;

    GetGuiVisible: TGetGuiVisible;
    GetGuiEnableFocus: TGetGuiEnableFocus;

    GetGuiFaceIndex: TGetGuiFaceIndex;
    GetGuiLeft: TGetGuiLeft;
    GetGuiTop: TGetGuiTop;
    GetGuiWidth: TGetGuiWidth;
    GetGuiHeight: TGetGuiHeight;

    GetWindowFloating: TGetWindowFloating;

    GetGridColCount: TGetGridColCount;
    GetGridRowCount: TGetGridRowCount;
    GetGridColWidth: TGetGridColWidth;
    GetGridRowHeight: TGetGridRowHeight;

    GetEditPaste: TGetEditPaste;
    GetEditDrawBkgrnd: TGetEditDrawBkgrnd;
    GetEditDrawBorder: TGetEditDrawBorder;
    GetEditPasswordChar: TGetEditPasswordChar;
    GetEditAllowSelectText: TGetEditAllowSelectText;

    SetLabelCaption: TSetLabelCaption;
    SetEditText: TSetEditText;
    GetLabelCaption: TGetLabelCaption;
    GetEditText: TGetEditText;

    SetGuiFontSize: TSetGuiFontSize;
    SetGuiFontName: TSetGuiFontName;
    SetGuiFontStyle: TSetGuiFontStyle;
    SetGuiFontColor: TSetGuiFontColor;

    SetLabelHotColor: TSetLabelHotColor;
    SetLabelDownColor: TSetLabelDownColor;
  end;
  pTGuiManage = ^TGuiManage;

  TPlayer = procedure(FileName: PChar; boShow, boPlay: Boolean); stdcall;
  TPlayerVisible = function: PBoolean; stdcall;

  TPlayerString = function: PChar; stdcall;
  TPlayerState = function: Integer; stdcall;

  TSetPlayerAlign = procedure(Align: TAlign); stdcall;
  TSetPlayerParent = procedure(Parent: TWinControl); stdcall;
  TSetPlayerUrl = procedure(AUrl: PChar); stdcall;

  TGetPlayerVolume = function: Integer; stdcall;
  TGetPlayerMute = function: Boolean; stdcall;
  TGetPlayerPosition = function: Double; stdcall;

  TSetPlayerVolume = procedure(Value: Integer); stdcall;
  TSetPlayerMute = procedure(Value: Boolean); stdcall;
  TSetPlayerPosition = procedure(Value: Double); stdcall;


  TPlayerMouseMove = procedure(nButton: Smallint; nShiftState: Smallint; fX: Integer; fY: Integer); stdcall;
  TPlayerStateChange = procedure(NewState: Integer); stdcall;

  {TSetPlayerMouseMove = procedure(OnMouseMove: TPlayerMouseMove); stdcall;
  TSetPlayerMediaError = procedure(OnMediaError: TInitialize); stdcall;
  TSetPlayerStateChange = procedure(OnPlayStateChange: TPlayerStateChange); stdcall;
  TSetPlayerError = procedure(OnError: TInitialize); stdcall;  }

  TStopPlay = procedure(FileName: PChar); stdcall;
  TMediaPlayer = record
    WindowsMediaPlayer: TWinControl;

    SetPlayerAlign: TSetPlayerAlign;
    SetPlayerParent: TSetPlayerParent;

    Player: TPlayer;
    Visible: TPlayerVisible;
    Play: TInitialize;
    Stop: TInitialize;
    Pause: TInitialize;
    StopPlay: TStopPlay;
    Url: TSetPlayerUrl;

    Mute: TGetPlayerMute;
    Volume: TGetPlayerVolume;
    Position: TGetPlayerPosition;
    Duration: TGetPlayerPosition;

    SetMute: TSetPlayerMute;
    SetVolume: TSetPlayerVolume;
    SetPosition: TSetPlayerPosition;
    SetDuration: TSetPlayerPosition;

    PositionString: TPlayerString;
    DurationString: TPlayerString;
    PlayState: TPlayerState;


    PlayerMouseMove: TPlayerMouseMove;
    PlayerMediaError: TInitialize;
    PlayerStateChange: TPlayerStateChange;
    PlayerError: TInitialize;
  end;

  TPlugInfo = record
    AppHandle: THandle;

    List_Create: TList_Create;
    List_Free: TList_Free;
    List_Count: TList_Count;
    List_Add: TList_Add;
    List_Insert: TList_Insert;

    List_Get: TList_Get;
    List_Put: TList_Put;
    List_Delete: TList_Delete;
    List_Clear: TList_Clear;
    List_Exchange: TList_Exchange;

    StringList_Create: TStringList_Create;
    StringList_Free: TStringList_Free;
    StringList_Count: TStringList_Count;
    StringList_Add: TStringList_Add;
    StringList_AddObject: TStringList_AddObject;
    StringList_Insert: TStringList_Insert;
    StringList_Get: TStringList_Get;
    StringList_GetObject: TStringList_GetObject;
    StringList_Put: TStringList_Put;
    StringList_PutObject: TStringList_PutObject;
    StringList_Delete: TStringList_Delete;
    StringList_Clear: TStringList_Clear;
    StringList_Exchange: TStringList_Exchange;
    StringList_LoadFormFile: TStringList_LoadFormFile;
    StringList_SaveToFile: TStringList_SaveToFile;

    HookInitialize: TInitialize;
    HookInitializeEnd: TInitialize;
    HookFinalize: TInitialize;
    HookKeyDown: TKeyDown;
    HookKeyPress: TKeyPress;
    HookSocketConnect: TSocketConnect;
    HookSocketRead: TSocketRead;
    HookSendSocket: TSendSocket;
    HookDecodeMessagePacket: TDecodeMessagePacket;
    HookClientGetMessage: TClientGetMessage;
    HookClientObjStruck: TClientObjStruck;
    HookFlip: TFlip;
    HookOpenLoginDoor: TOpenLoginDoor;
    HookLoginScene: TScene;
    HookSelectChrScene: TScene;
    HookPlayScene: TScene;
    HookGuiInitializeBegin: TInitialize;
    HookGuiInitializeEnd: TInitialize;

    HookShowMonName: TShowMonName;
    HookShowItemName: TShowItemName;

    Account: TServerName;
    PassWord: TServerName;

    ChangeScene: TChangeScene;
    GetRGB: TGetRGB;
    OpenHomePage: TOpenHomePage;
    MediaPlayer: TMediaPlayer;

    LogOut: TInitialize;
    Close: TInitialize;


    KeyDown: TKeyDown;
    KeyPress: TKeyPress;
    SendSocket: TSendSocket;
    MessageDlg: TMessageDlg;
    AddSysMsg: TAddSysMsg;
    AddChatBoardString: TAddChatBoardString;
    ShowHint: TShowHint;
    ClearHint: TInitialize;
    BoldTextOut: TTextOut;
    BoldTextRect: TTextRect;
    TextOut: TTextOut;
    TextRect: TTextRect;
    PomiTextOut: TPomiTextOut;
    TextWidth: TTextWidth;
    TextHeight: TTextHeight;

    GetFontName: TGetFontName;
    GetFontSize: TGetFontSize;
    GetFontStyle: TGetFontStyle;

    SetFontName: TSetFontName;
    SetFontSize: TSetFontSize;
    SetFontStyle: TSetFontStyle;

    UseMagic: TUseMagic;
    GetMouseItemInfo: TGetMouseItemInfo;

    ScreenXYfromMCXY: TScreenXYfromMCXY;
    CXYfromMouseXY: TCXYfromMouseXY;

    IsSelectMyself: TIsSelectMyself;
    GetXYDropItems: TGetXYDropItems;

    CanRun: TCanRun;
    CanWalk: TCanWalk;
    CanWalkEx: TCanWalkEx;
    CrashMan: TCrashMan;
    CanFly: TCanFly;

    ConnectionStep: pTConnectionStep;
    Config: pTConfig;
    ServerName: TServerName;
    SelChrName: TServerName;
    SetSelChrName: TSetName;


    BufCode: PByte;
    SoftClosed: PBoolean;

    ServerList: TStringList; //服务器列表

    MagicList: TList; //技能列表
    HeroMagicList: TList; //英雄技能列表

    MouseCurrX: PInteger; //鼠标所在地图位置座标X
    MouseCurrY: PInteger; //鼠标所在地图位置座标Y
    MouseX: PInteger; //鼠标所在屏幕位置座标X
    MouseY: PInteger; //鼠标所在屏幕位置座标Y

    TargetX: PInteger; //目标座标
    TargetY: PInteger; //目标座标
    TargetCret: PTObject;
    FocusCret: PTObject;
    MagicTarget: PTObject;

    MySelf: PTObject;
    MyHero: PTObject; //我的英雄

    UseItems: pTUseItems;
    ItemArr: pTItemArr;
    HeroUseItems: pTUseItems;
    HeroItemArr: pTHeroItemArr;

    MouseItem: pTClientItem;
    MouseStateItem: pTClientItem;
    MouseUserStateItem: pTClientItem;

    MouseHeroItem: pTClientItem;
    MouseHeroStateItem: pTClientItem;
    MouseHeroUserStateItem: pTClientItem;

    btItemMoving: PByte; //物品移动状态
    boItemMoving: PBoolean; //正在移动物品
    MovingItem: pTMovingItem;
    WaitingUseItem: pTMovingItem;
    WaitingHeroUseItem: pTMovingItem;
    FocusItem: pTDropItem;

    EatingItem: pTClientItem;
    dwEatTime: PLongWord;

    HeroEatingItem: pTClientItem;
    dwHeroEatTime: PLongWord;

    SoundList: TStringList;
    DropedItemList: TList;
    ActorList: TList;

    FullScreen: PBoolean;

    PlaySound: TPlaySoundEx;

    Actor_nRecogId: TActor_nRecogId; //角色标识 0x4
    Actor_nCurrX: TActor_nCurrX; //当前所在地图座标X 0x08
    Actor_nCurrY: TActor_nCurrY; //当前所在地图座标Y 0x0A
    Actor_btDir: TActor_btDir; //当前站立方向 0x0C
    Actor_btSex: TActor_btSex; //性别 0x0D
    Actor_btRace: TActor_btRace; //0x0E
    Actor_btHair: TActor_btHair; //头发类型 0x0F
    Actor_btDress: TActor_btDress; //衣服类型 0x10
    Actor_btWeapon: TActor_btWeapon; //武器类型
    Actor_btHorse: TActor_btHorse; //马类型
    Actor_btJob: TActor_btJob;
    Actor_wAppearance: TActor_wAppearance; //0x14
    Actor_btDeathState: TActor_btDeathState;
    Actor_nFeature: TActor_nFeature; //0x18
    Actor_nFeatureEx: TActor_nFeatureEx; //0x18
    Actor_nState: TActor_nState; //0x1C
    Actor_boDeath: TActor_boDeath; //0x20
    Actor_boDelActor: TActor_boDelActor; //0x22
    Actor_boDelActionAfterFinished: TActor_boDelActionAfterFinished; //0x23
    Actor_sDescUserName: TActor_sDescUserName; //人物名称，后缀
    Actor_sUserName: TActor_sUserName; //0x28
    Actor_nNameColor: TActor_nNameColor; //0x2C
    Actor_Abil: TActor_Abil; //0x30
    Actor_nGold: TActor_nGold; //金币数量0x58
    Actor_nGameGold: TActor_nGameGold; //游戏币数量
    Actor_nGamePoint: TActor_nGamePoint; //游戏点数量
    DeleteActor: TDeleteActor;

    Draw: TDraw;
    DrawRect: TDrawRect;
    DrawAlpha: TDrawAlpha;
    StretchDraw: TStretchDraw;
    DrawBlend: TDrawBlend;

    Fill: TFill;
    FillRect: TFillRect;
    FillRectAlpha: TFillRectAlpha;

    ImageManage: TImageManage;
    GuiManage: TGuiManage;
    ServerConfig: pTServerConfig;
  end;
  pTPlugInfo = ^TPlugInfo;

  TInit = procedure(PlugInfo: pTPlugInfo); stdcall;

  TPlugGuiNotifyEvent = class
    Gui: TDControl;
  private
    FOnDirectPaint: TOn_DirectPaint;
    FOnKeyPress: TOn_KeyPress;
    FOnKeyDown: TOn_KeyDown;
    FOnMouseMove: TOn_MouseMove;
    FOnMouseDown: TOn_MouseDown;
    FOnMouseUp: TOn_MouseUp;
    FOnDblClick: TOn_Click;
    FOnClick: TOn_ClickEx;
    FOnInRealArea: TOn_InRealArea;
    FOnBackgroundClick: TOn_Click;
    FOnButtonClick: TOn_ButtonClick;
    FOnGridSelect: TOn_GridSelect;
    FOnGridMouseMove: TOn_GridMouseMove;
    FOnGridPaint: TOn_GridPaint;
    FOnClickSound: TOn_ClickSound;
  public
    constructor Create();
    destructor Destroy; override;

    procedure OnDirectPaint(Sender: TObject; dsurface: TTexture);
    procedure OnKeyPress(Sender: TObject; var Key: Char);
    procedure OnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OnDblClick(Sender: TObject);
    procedure OnClick(Sender: TObject; X, Y: Integer);
    procedure OnButtonClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OnInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
    procedure OnGridSelect(Sender: TObject; ACol, ARow: Integer; Shift: TShiftState);
    procedure OnGridMouseMove(Sender: TObject; ACol, ARow: Integer; Shift: TShiftState);
    procedure OnGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState; dsurface: TTexture);
    procedure OnClickSound(Sender: TObject; Clicksound: TClickSound);
    procedure OnItemClick(Sender: TObject; Itemindex: Integer);
  end;

  TPlugGuiManage = class
  private
    PlugGuiList: TStringList;
  public
    constructor Create();
    destructor Destroy; override;
    procedure Add(Gui: TDControl; Config: pTGuiConfig); overload;
    procedure Add(Gui: TDControl; OnDirectPaint: TOn_DirectPaint); overload;
    procedure Add(Gui: TDControl; OnKeyPress: TOn_KeyPress); overload;
    procedure Add(Gui: TDControl; OnKeyDown: TOn_KeyDown); overload;
    procedure AddMouseMove(Gui: TDControl; OnMouseMove: TOn_MouseMove);
    procedure AddMouseDown(Gui: TDControl; OnMouseDown: TOn_MouseDown);
    procedure AddMouseUp(Gui: TDControl; OnMouseUp: TOn_MouseUp);

    procedure Add(Gui: TDControl; OnClick: TOn_ClickEx); overload;
    procedure Add(Gui: TDControl; OnDblClick: TOn_Click); overload;
    procedure AddButtonClick(Gui: TDControl; OnButtonClick: TOn_ButtonClick);
    procedure Add(Gui: TDControl; OnInRealArea: TOn_InRealArea); overload;
    procedure Add(Gui: TDControl; OnClickSound: TOn_ClickSound); overload;

    procedure Add(Gui: TDGrid; OnGridSelect: TOn_GridSelect); overload;
    procedure Add(Gui: TDGrid; OnGridMouseMove: TOn_GridMouseMove); overload;
    procedure Add(Gui: TDGrid; OnGridPaint: TOn_GridPaint); overload;

    procedure Add(Gui: TDLabel; OnItemClick: TOn_ItemClick); overload;


    procedure Delete(Gui: TDControl);
  end;


  TPlugFileInfo = record
    Module: THandle;
    DllName: string;
    sDesc: string;
  end;
  pTPlugFileInfo = ^TPlugFileInfo;

  TPlugInManage = class
    PlugList: TStringList;
    PlugFileList: TStringList;
  private
    function GetPlug(Module: THandle; sPlugLibFileName: string): Boolean;
  public
    constructor Create();
    destructor Destroy; override;
    procedure LoadPlugIn();
    procedure UnLoadPlugIn();
  end;

  TClientData = record
    PreviousHandle: THandle;
    RunCounter: Integer;
    RunConnt: Integer;
    Handle: array[0..4] of THandle;
    Hooked: array[0..4] of Boolean;
    PlugInfo: array[0..4] of pTPlugInfo;
  end;
  pTClientData = ^TClientData;

procedure PlugInitialize(PlugInfo: pTPlugInfo);
var
  g_PlugInfo: TPlugInfo;
  PlugInManage: TPlugInManage;
  g_ClientData: pTClientData;
implementation
uses ClMain;
var
  PlugGuiManage: TPlugGuiManage;

constructor TPlugInManage.Create();
begin
  PlugList := TStringList.Create();
  PlugFileList := TStringList.Create();
end;

destructor TPlugInManage.Destroy;
begin
  UnLoadPlugIn();
  PlugList.Free;
  PlugFileList.Free;
  inherited;
end;

function TPlugInManage.GetPlug(Module: THandle; sPlugLibFileName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to PlugList.Count - 1 do begin
    if (Module = pTPlugFileInfo(PlugList.Objects[I]).Module) or (Comparetext(pTPlugFileInfo(PlugList.Objects[I]).DllName, sPlugLibFileName) = 0) then begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TPlugInManage.LoadPlugIn();
  function DoSearchFile(Path, FType: string; var Files: tstringlist): Boolean;
  var
    Info: TSearchRec;
    s01: string;
    procedure ProcessAFile(FileName: string);
    begin
   {if Assigned(PnlPanel) then
     PnlPanel.Caption := FileName;
   Label2.Caption := FileName;}
    end;
    function IsDir: Boolean;
    begin
      with Info do
        Result := (Name <> '.') and (Name <> '..') and ((Attr and faDirectory) = faDirectory);
    end;
    function IsFile: Boolean;
    begin
      Result := (not ((Info.Attr and faDirectory) = faDirectory)) and ((ExtractFileExt(Info.Name) = '.*') or (CompareText(ExtractFileExt(Info.Name), FType) = 0));
    end;
  begin
    try
    //Files.Clear;
      Result := False;
      if FindFirst(Path + '*.*', faAnyFile, Info) = 0 then begin
     { if IsFile then begin
        s01 := Path + Info.Name;
        Files.Add(s01);
      end; }
        while True do begin
          if IsFile then begin
            s01 := Path + Info.Name;
            Files.Add(s01);
          end;
          Application.ProcessMessages;
          if FindNext(Info) <> 0 then Break;
        end;
      end;
      Result := True;
    finally
      FindClose(Info);
    end;
  end;
var
  I: Integer;
  Init: TInit;
  sPath: string;
  sPlugListFileName: string;
  sPlugLibFileName: string;
  Module: THandle;
  StringList: TStringlist;
  PlugFileInfo: pTPlugFileInfo;
begin
  PlugInitialize(@g_PlugInfo);
  {sPath := ExtractFilePath(Application.ExeName) + 'PlugIn\';
  StringList := TStringlist.Create;
  DoSearchFile(sPath, '.*', StringList); }
  sPlugListFileName := '.\PlugList.txt';

  //Showmessage(PlugFileList.Text);
  if FileExists(sPlugListFileName) then begin
    StringList := TStringlist.Create;
    StringList.LoadFromFile(sPlugListFileName);

    for I := 0 to StringList.Count - 1 do
      PlugFileList.Add(StringList.Strings[I]);

    StringList.Free;
  end;
  //Showmessage(PlugFileList.Text);
  // Showmessage(PlugFileList.Text);
  for I := 0 to PlugFileList.Count - 1 do begin
    sPlugLibFileName := ExtractFilePath(Application.ExeName) + PlugFileList.Strings[I];
    if FileExists(sPlugLibFileName) then begin
      Module := LoadLibrary(PChar(sPlugLibFileName));
      if Module > 32 then begin
        if GetPlug(Module, sPlugLibFileName) then begin
          FreeLibrary(Module);
          Continue;
        end;
        New(PlugFileInfo);
        PlugFileInfo.Module := Module;
        PlugFileInfo.DllName := sPlugLibFileName;
        Init := GetProcAddress(Module, 'Init');
        if Assigned(@Init) then begin

          Init(@g_PlugInfo);
          PlugList.AddObject('', TObject(PlugFileInfo));
        end else FreeLibrary(Module);
      end else FreeLibrary(Module);
    end;
  end;
end;

procedure TPlugInManage.UnLoadPlugIn();
var
  I: Integer;
  PlugFileInfo: pTPlugFileInfo;
  UnInit: procedure(); stdcall;
begin
  for I := 0 to PlugList.Count - 1 do begin
    PlugFileInfo := pTPlugFileInfo(PlugList.Objects[I]);
    UnInit := GetProcAddress(PlugFileInfo.Module, 'UnInit');
    if @UnInit <> nil then begin
      UnInit();
    end;
    FreeLibrary(PlugFileInfo.Module);
    Dispose(PlugFileInfo);
  end;
  PlugList.Clear;
end;

procedure _LogOut; stdcall;
begin
  frmMain.LogOut;
end;

function _KeyDown(Key: Word; Shift: TShiftState): Boolean; stdcall;
var
  nKey: Word;
  KeyDown: TKeyDown;
begin
  nKey := Key;
  //KeyDown := g_PlugInfo.HookKeyDown;
  try
    //g_PlugInfo.HookKeyDown := nil;
    frmMain.FormKeyDown(nil, nKey, Shift);
  finally
    //g_PlugInfo.HookKeyDown := KeyDown;
  end;
end;

function _KeyPress(Key: Char): Boolean; stdcall;
var
  nKey: Char;
  KeyPress: TKeyPress;
begin
  nKey := Key;
  //KeyPress := g_PlugInfo.HookKeyPress;
  try
    //g_PlugInfo.HookKeyPress := nil;
    frmMain.FormKeyPress(nil, nKey);
  finally
    //g_PlugInfo.HookKeyPress := KeyPress;
  end;
end;

function _SendSocket(Data: PChar; Len: Integer): Boolean; stdcall;
var
  sSendText: string;
begin
  with frmMain do begin
    if CSocket.Socket.Connected then begin
      sSendText := StrPas(Data);
      CSocket.Socket.SendText('#' + IntToStr(Code) + sSendText + '!');
      Inc(Code);
      if Code >= 10 then Code := 1;
    end;
  end;
end;

procedure _ChangeScene(SceneType: TSceneType); stdcall;
begin
  DScreen.ChangeScene(SceneType);
end;

function _MessageDlg(Msg: PChar; DlgButtons: TMsgDlgButtons): TModalResult; stdcall;
begin
  Result := FrmDlg.DMessageDlg(StrPas(Msg), DlgButtons);
end;

procedure _GetMouseItemInfo(Actor: TActor; MouseItem: pTClientItem; PName, PLine1, PLine2, PLine3: PTShortString; var useable: Boolean); stdcall;
var
  iname, line1, line2, line3: string;
begin
  FrmDlg.GetMouseItemInfo(Actor, MouseItem, iname, line1, line2, line3, useable);
  PName.btLen := Length(iname);
  if PName.btLen > 0 then Move(iname[1], PName.Strings, PName.btLen);

  PLine1.btLen := Length(line1);
  if PLine1.btLen > 0 then Move(line1[1], PLine1.Strings, PLine1.btLen);

  PLine2.btLen := Length(line2);
  if PLine2.btLen > 0 then Move(line2[1], PLine2.Strings, PLine2.btLen);

  PLine3.btLen := Length(line3);
  if PLine3.btLen > 0 then Move(line3[1], PLine3.Strings, PLine3.btLen);
end;

procedure _AddSysMsg(Data: PChar; X, Y: Integer; Color: Integer); stdcall;
begin
  DScreen.AddSysMsg(StrPas(Data), X, Y, Color);
end;

procedure _AddChatBoardString(Data: PChar; FColor, BColor: Integer); stdcall;
begin
  DScreen.AddChatBoardString(StrPas(Data), FColor, BColor);
end;

procedure _ShowHint(X, Y: Integer; Text: PChar; Color: TColor; drawup: Boolean); stdcall;
begin
  DScreen.ShowHint(X, Y, StrPas(Text), Color, drawup);
end;

procedure _ClearHint; stdcall;
begin
  DScreen.ClearHint;
end;

procedure _TextOut(Surface: TTexture; X, Y, FColor, BColor: Integer; Text: PChar); stdcall;
begin
  Surface.TextOut(X, Y, StrPas(Text), FColor, BColor);
end;

procedure _TextRect(Surface: TTexture; Rect: TRect; X, Y, FColor, BColor: Integer; Text: PChar); stdcall;
begin
  Surface.TextRect(Rect, X, Y, StrPas(Text), FColor, BColor);
end;

procedure _BoldTextOut(Surface: TTexture; X, Y, FColor, BColor: Integer; Text: PChar); stdcall;
begin
  Surface.BoldTextOut(X, Y, StrPas(Text), FColor, BColor);
end;

procedure _BoldTextRect(Surface: TTexture; Rect: TRect; X, Y, FColor, BColor: Integer; Text: PChar); stdcall;
begin
  //Surface.BoldTextRect(Rect, X, Y, StrPas(Text), FColor, BColor);
end;


procedure _UseMagic(X, Y: Integer; Magic: pTClientMagic); stdcall;
begin
  frmMain.UseMagic(X, Y, Magic);
end;

procedure _ScreenXYfromMCXY(cx, cy: Integer; var sx, sY: Integer); stdcall;
begin
  PlayScene.ScreenXYfromMCXY(cx, cy, sx, sY);
end;

procedure _CXYfromMouseXY(mx, my: Integer; var ccx, ccy: Integer); stdcall;
begin
  PlayScene.CXYfromMouseXY(mx, my, ccx, ccy);
end;

function _IsSelectMyself(X, Y: Integer): Boolean; stdcall;
begin
  Result := PlayScene.IsSelectMyself(X, Y);
end;

function _GetXYDropItems(nX, nY: Integer): pTDropItem; stdcall;
begin
  Result := PlayScene.GetXYDropItems(nX, nY);
end;

function _CanRun(sx, sY, ex, ey: Integer): Boolean; stdcall;
begin
  Result := PlayScene.CanRun(sx, sY, ex, ey);
end;

function _CanWalk(mx, my: Integer): Boolean; stdcall;
begin
  Result := PlayScene.CanWalk(mx, my);
end;

function _CanWalkEx(mx, my: Integer): Boolean; stdcall;
begin
  Result := PlayScene.CanWalkEx(mx, my);
end;

function _CrashMan(mx, my: Integer): Boolean; stdcall;
begin
  Result := PlayScene.CrashMan(mx, my);
end;

function _CanFly(mx, my: Integer): Boolean; stdcall;
begin
  Result := PlayScene.CanFly(mx, my);
end;

function _Actor_nRecogId(Actor: TActor): PInteger; stdcall; //角色标识 0x4
begin
  Result := @Actor.m_nRecogId;
end;

function _Actor_nCurrX(Actor: TActor): PInteger; stdcall; //当前所在地图座标X 0x08
begin
  Result := @Actor.m_nCurrX;
end;

function _Actor_nCurrY(Actor: TActor): PInteger; stdcall; //当前所在地图座标Y 0x0A
begin
  Result := @Actor.m_nCurrY;
end;

function _Actor_btDir(Actor: TActor): PByte; stdcall; //当前站立方向 0x0C
begin
  Result := @Actor.m_btDir;
end;

function _Actor_btSex(Actor: TActor): PByte; stdcall; //性别 0x0D
begin
  Result := @Actor.m_btSex;
end;

function _Actor_btRace(Actor: TActor): PByte; stdcall; //0x0E
begin
  Result := @Actor.m_btRace;
end;

function _Actor_btHair(Actor: TActor): PByte; stdcall; //头发类型 0x0F
begin
  Result := @Actor.m_btHair;
end;

function _Actor_btDress(Actor: TActor): PByte; stdcall; //衣服类型 0x10
begin
  Result := @Actor.m_btDress;
end;

function _Actor_btWeapon(Actor: TActor): PByte; stdcall; //武器类型
begin
  Result := @Actor.m_btWeapon;
end;

function _Actor_btHorse(Actor: TActor): PByte; stdcall; //马类型
begin
  Result := @Actor.m_btHorse;
end;

function _Actor_btJob(Actor: TActor): PByte; stdcall;
begin
  Result := @Actor.m_btJob;
end;

function _Actor_wAppearance(Actor: TActor): PWord; stdcall; //0x14
begin
  Result := @Actor.m_wAppearance;
end;

function _Actor_btDeathState(Actor: TActor): PByte; stdcall;
begin
  Result := @Actor.m_btDeathState;
end;

function _Actor_nFeature(Actor: TActor): PInteger; stdcall; //0x18
begin
  Result := @Actor.m_nFeature;
end;

function _Actor_nFeatureEx(Actor: TActor): PInteger; stdcall; //0x18
begin
  Result := @Actor.m_nFeatureEx;
end;

function _Actor_nState(Actor: TActor): PInteger; stdcall; //0x1C
begin
  Result := @Actor.m_nState;
end;

function _Actor_boDeath(Actor: TActor): PBoolean; stdcall; //0x20
begin
  Result := @Actor.m_boDeath;
end;

function _Actor_boDelActor(Actor: TActor): PBoolean; stdcall; //0x22
begin
  Result := @Actor.m_boDelActor;
end;

function _Actor_boDelActionAfterFinished(Actor: TActor): PBoolean; stdcall; //0x23
begin
  Result := @Actor.m_boDelActionAfterFinished;
end;

function _Actor_sDescUserName(Actor: TActor): PChar; stdcall; //人物名称，后缀
begin
  Result := PChar(Actor.m_sDescUserName);
end;

function _Actor_sUserName(Actor: TActor): PChar; stdcall; //0x28
begin
  Result := PChar(Actor.m_sUserName);
end;

function _Actor_nNameColor(Actor: TActor): PInteger; stdcall; //0x2C
begin
  Result := @Actor.m_nNameColor;
end;

function _Actor_Abil(Actor: TActor): PTAbility; stdcall; //0x30
begin
  Result := @Actor.m_Abil;
end;

function _Actor_nGold(Actor: TActor): PInteger; stdcall; //金币数量0x58
begin
  Result := @Actor.m_nGold;
end;

function _Actor_nGameGold(Actor: TActor): PInteger; stdcall; //游戏币数量
begin
  Result := @Actor.m_nGameGold;
end;

function _Actor_nGamePoint(Actor: TActor): PInteger; stdcall; //游戏点数量
begin
  Result := @Actor.m_nGamePoint;
end;

procedure _DeleteActor(RecogId: Integer); stdcall;
begin
  PlayScene.DeleteActor(RecogId);
end;

procedure _ServerName(ShortString: PTShortString); stdcall;
begin
  ShortString.btLen := Length(g_sServerName);
  Move(g_sServerName[1], ShortString.Strings, ShortString.btLen);
end;

procedure _SelChrName(ShortString: PTShortString); stdcall;
begin
  ShortString.btLen := Length(g_sSelChrName);
  Move(g_sServerName[1], ShortString.Strings, ShortString.btLen);
end;

procedure _SetSelChrName(Name: PChar); stdcall;
begin
  g_sSelChrName := Name;
end;


procedure _Account(ShortString: PTShortString); stdcall;
begin
  ShortString.btLen := Length(frmMain.LoginID);
  if frmMain.LoginID <> '' then
    Move(frmMain.LoginID[1], ShortString.Strings, ShortString.btLen);
end;

procedure _PassWord(ShortString: PTShortString); stdcall;
begin
  ShortString.btLen := Length(frmMain.LoginPasswd);
  if frmMain.LoginPasswd <> '' then
    Move(frmMain.LoginPasswd[1], ShortString.Strings, ShortString.btLen);
end;

//==============================================================================

function _CreateImage: TGameImages; stdcall;
begin
  Result := TGameImages.Create;
end;

procedure _FreeImage(Image: TGameImages); stdcall;
begin
  Image.Free;
end;

procedure _InitializeImage(Image: TGameImages); stdcall;
begin
  Image.Initialize;
end;

procedure _FinalizeImage(Image: TGameImages); stdcall;
begin
  Image.Finalize;
end;

procedure _SeTImageConfig(Image: TGameImages; Config: pTImageConfig); stdcall;
begin
  Image.FileName := Config.FileName;
end;

procedure _GetImageInfo(Image: TGameImages; Index: Integer; ImageInfo: pTImageInfo); stdcall;
begin
  ImageInfo.Surface := Image.GetCachedImage(Index, ImageInfo.X, ImageInfo.Y);
  if ImageInfo.Surface <> nil then begin
    ImageInfo.Width := ImageInfo.Surface.Width;
    ImageInfo.Height := ImageInfo.Surface.Height;
  end else begin
    ImageInfo.Width := 0;
    ImageInfo.Height := 0;
  end;
end;

function _GetImageIndexList(Image: TGameImages): TList; stdcall;
begin
  //Result := Image.m_IndexList;
end;
//=============================================================================

function _CreateGui(Gui: TGuiType): TDControl; stdcall;
begin
  Result := nil;
  case Gui of
    g_Button: Result := TDButton.Create(nil);
    g_Window: Result := TDWindow.Create(nil);
    g_Edit: Result := TDEdit.Create(nil);
    g_Label: Result := TDLabel.Create(nil);
    g_Grid: Result := TDGrid.Create(nil);
  end;
  if (Result <> nil) and (Result is TDLabel) then begin
    TDLabel(Result).Font.Assign(frmMain.Font);
    TDLabel(Result).UpColor := clyellow;
    TDLabel(Result).HotColor := GetRGB(69);
    TDLabel(Result).DownColor := clLime;
  end;
end;

procedure _GuiFree(Gui: TDControl); stdcall;
begin
  PlugGuiManage.Delete(Gui);
  Gui.Free;
end;

procedure _SetGuiConfig(Gui: TDControl; Config: pTGuiConfig); stdcall;
begin
  Gui.SetImgIndex(Config.Image, Config.FaceIndex);
  Gui.DParent := Config.DParent;
  Gui.EnableFocus := Config.EnableFocus;
  Gui.Left := Config.Left;
  Gui.Top := Config.Top;
  PlugGuiManage.Add(Gui, Config);
end;

procedure _GetGuiInfo(Gui: TDControl; GuiInfo: pTGuiInfo); stdcall;
begin
  GuiInfo.Image := Gui.WLib;
  GuiInfo.DParent := Gui.DParent;
  GuiInfo.Name := PChar(Gui.Name);
  GuiInfo.Visible := Gui.Visible;
  GuiInfo.EnableFocus := Gui.EnableFocus;
  GuiInfo.Left := Gui.Left;
  GuiInfo.Top := Gui.Top;
  GuiInfo.Width := Gui.Width;
  GuiInfo.Height := Gui.Height;
  GuiInfo.FaceIndex := Gui.FaceIndex;
  GuiInfo.ClientRect := Gui.ClientRect;
  GuiInfo.DControls := Gui.DControls;
end;

function _SurfaceX(Gui: TDControl): Integer; stdcall;
begin
  Result := Gui.SurfaceX(Gui.Left);
end;

function _SurfaceY(Gui: TDControl): Integer; stdcall;
begin
  Result := Gui.SurfaceY(Gui.Top);
end;

procedure _SetImgIndex(Gui: TDControl; Lib: TGameImages; Index: Integer); stdcall;
begin
  Gui.SetImgIndex(Lib, Index);
end;

procedure _SetFocus(Gui: TDControl); stdcall;
begin
  Gui.SetFocus;
end;

procedure _SetOnDirectPaint(Gui: TDControl; OnDirectPaint: TOn_DirectPaint); stdcall;
begin
  PlugGuiManage.Add(Gui, OnDirectPaint);
end;

procedure _SetOnKeyPress(Gui: TDControl; OnKeyPress: TOn_KeyPress); stdcall;
begin
  PlugGuiManage.Add(Gui, OnKeyPress);
end;

procedure _SetOnKeyDown(Gui: TDControl; OnKeyDown: TOn_KeyDown); stdcall;
begin
  PlugGuiManage.Add(Gui, OnKeyDown);
end;

procedure _SetOnMouseMove(Gui: TDControl; OnMouseMove: TOn_MouseMove); stdcall;
begin
  PlugGuiManage.AddMouseMove(Gui, OnMouseMove);
end;

procedure _SetOnMouseDown(Gui: TDControl; OnMouseDown: TOn_MouseDown); stdcall;
begin
  PlugGuiManage.AddMouseDown(Gui, OnMouseDown);
end;

procedure _SetOnMouseUp(Gui: TDControl; OnMouseUp: TOn_MouseUp); stdcall;
begin
  PlugGuiManage.AddMouseUp(Gui, OnMouseUp);
end;

procedure _SetOnClick(Gui: TDControl; OnClick: TOn_ClickEx); stdcall;
begin
  PlugGuiManage.Add(Gui, OnClick);
end;

procedure _SetOnDblClick(Gui: TDControl; OnDblClick: TOn_Click); stdcall;
begin
  PlugGuiManage.Add(Gui, OnDblClick);
end;

procedure _SetOnButtonClick(Gui: TDControl; OnButtonClick: TOn_ButtonClick); stdcall;
begin
  PlugGuiManage.AddButtonClick(Gui, OnButtonClick);
end;

procedure _SetOnInRealArea(Gui: TDControl; OnInRealArea: TOn_InRealArea); stdcall;
begin
  PlugGuiManage.Add(Gui, OnInRealArea);
end;

procedure _SetOnClickSound(Gui: TDControl; OnClickSound: TOn_ClickSound); stdcall;
begin
  PlugGuiManage.Add(Gui, OnClickSound);
end;

procedure _SetOnGridSelect(Gui: TDGrid; OnGridSelect: TOn_GridSelect); stdcall;
begin
  //PlugGuiManage.Add(Gui, OnGridSelect);
end;

procedure _SetOnGridMouseMove(Gui: TDGrid; OnGridMouseMove: TOn_GridMouseMove); stdcall;
begin
  //PlugGuiManage.Add(Gui, OnGridMouseMove);
end;

procedure _SetOnGridPaint(Gui: TDGrid; OnGridPaint: TOn_GridPaint); stdcall;
begin
  PlugGuiManage.Add(Gui, OnGridPaint);
end;

procedure _SetOnItemClick(Gui: TDLabel; OnItemClick: TOn_ItemClick); stdcall;
begin
  PlugGuiManage.Add(Gui, OnItemClick);
end;


function _GetGuiMouseMoved(Gui: TDControl): Boolean; stdcall;
begin
  Result := Gui.MouseMoveing;
end;

function _GetGuiDowned(Gui: TDControl): Boolean; stdcall;
begin
  Result := Gui.Downed;
end;


function _GetGuiVisible(Gui: TDControl): PBoolean; stdcall;
begin
  Result := @Gui.Visible;
end;

function _GetGuiEnableFocus(Gui: TDControl): PBoolean; stdcall;
begin
  Result := @Gui.EnableFocus;
end;

function _GetGuiFaceIndex(Gui: TDControl): PInteger; stdcall;
begin
  Result := @Gui.FaceIndex;
end;

function _GetGuiLeft(Gui: TDControl): PInteger; stdcall;
begin
  Result := @Gui.Left;
end;

function _GetGuiTop(Gui: TDControl): PInteger; stdcall;
begin
  Result := @Gui.Top;
end;

function _GetGuiWidth(Gui: TDControl): PInteger; stdcall;
begin
  Result := @Gui.Width;
end;

function _GetGuiHeight(Gui: TDControl): PInteger; stdcall;
begin
  Result := @Gui.Height;
end;

function _GetWindowFloating(Gui: TDWindow): PBoolean; stdcall;
begin
  Result := @Gui.Floating;
end;

function _GetGridColCount(Gui: TDGrid): PInteger; stdcall;
begin
  Result := @Gui.ColCount;
end;

function _GetGridRowCount(Gui: TDGrid): PInteger; stdcall;
begin
  Result := @Gui.RowCount;
end;

function _GetGridColWidth(Gui: TDGrid): PInteger; stdcall;
begin
  Result := @Gui.ColWidth;
end;

function _GetGridRowHeight(Gui: TDGrid): PInteger; stdcall;
begin
  Result := @Gui.RowHeight;
end;

function _GetEditPaste(Gui: TDEdit): PBoolean; stdcall;
begin
  Result := @Gui.Paste;
end;

function _GetEditDrawBkgrnd(Gui: TDEdit): PBoolean; stdcall;
begin
  Result := @Gui.DrawBackground;
end;

function _GetEditDrawBorder(Gui: TDEdit): PBoolean; stdcall;
begin
  Result := @Gui.DrawBorder;
end;

function _GetEditPasswordChar(Gui: TDEdit): PChar; stdcall;
begin
  Result := @Gui.PasswordChar;
end;

function _GetEditAllowSelectText(Gui: TDEdit): PBoolean; stdcall;
begin
  Result := @Gui.AllowSelectText;
end;

procedure _SetEditMainMenu(GuiDEdit: TDEdit; GuiMenu: TDControl); stdcall;
begin
  GuiDEdit.MainMenu := TDPopupMenu(GuiMenu);
end;

function _GetGuiImage(Gui: TDControl): TGameImages; stdcall;
begin
  Result := Gui.WLib;
end;

procedure _SetGuiImage(Gui: TDControl; Image: TGameImages); stdcall;
begin
  Gui.WLib := Image;
end;

function _GetDParent(Gui: TDControl): TDControl; stdcall;
begin
  Result := Gui.DParent;
end;

procedure _SetDParent(Gui: TDControl; DParent: TDControl); stdcall;
begin
  Gui.DParent := DParent;
end;

procedure _SetLabelCaption(Gui: TDLabel; Caption: PChar); stdcall;
begin
  Gui.Caption := Caption;
end;

procedure _SetEditText(Gui: TDEdit; Text: PChar); stdcall;
begin
  Gui.Text := Text;
end;

procedure _GetLabelCaption(Gui: TDLabel; Caption: PTShortString); stdcall;
begin
  Caption.btLen := Length(Gui.Caption);
  if Caption.btLen > 0 then
    Move(Gui.Caption[1], Caption.Strings, Caption.btLen);
end;

procedure _GetEditText(Gui: TDEdit; Text: PTShortString); stdcall;
var
  sText: string;
begin
  sText := Gui.Text;
  Text.btLen := Length(sText);
  if Text.btLen > 0 then
    Move(sText[1], Text.Strings, Text.btLen);
end;

//==============================================================================

procedure _Draw(Dest: TTexture; X, Y: Integer; Source: TTexture; Transparent: Boolean); stdcall;
begin
  Dest.Draw(X, Y, Source, Transparent);
end;

procedure _DrawRect(Dest: TTexture; X, Y: Integer; SrcRect: TRect; Source: TTexture; Transparent: Boolean); stdcall;
begin
  Dest.Draw(X, Y, SrcRect, Source, Transparent);
end;

procedure _DrawAlpha(Dest: TTexture; const DestRect, SrcRect: TRect; Source: TTexture; Transparent: Boolean; Alpha: Integer); stdcall;
begin
  Dest.DrawAlpha(DestRect, SrcRect, Source, Transparent, Alpha);
end;

procedure _StretchDraw(Dest: TTexture; const DestRect, SrcRect: TRect; Source: TTexture; Transparent: Boolean); stdcall;
begin
  Dest.StretchDraw(DestRect, SrcRect, Source, Transparent);
end;

procedure _DrawBlend(Dest: TTexture; X, Y: Integer; Source: TTexture); stdcall;
begin
  DrawBlend(Dest, X, Y, Source);
end;

procedure _Fill(Dest: TTexture; DevColor: Longint); stdcall;
begin
  Dest.Fill(DevColor);
end;

procedure _FillRect(Dest: TTexture; const Rect: TRect; DevColor: Longint); stdcall;
begin
  Dest.FillRect(Rect, DevColor);
end;

procedure _FillRectAlpha(Dest: TTexture; const DestRect: TRect; Color: TColor; Alpha: Integer); stdcall;
begin
  Dest.FillRectAlpha(DestRect, Color, Alpha);
end;

function _GetRGB(btColor: Byte): TColor;
begin
  Result := GetRGB(btColor);
end;


function _TList_Create: TList; stdcall;
begin
  Result := TList.Create;
end;

procedure _TList_Free(List: TList); stdcall;
begin
  List.Free;
end;

function _TList_Count(List: TList): Integer; stdcall;
begin
  Result := List.Count;
end;

function _TList_Add(List: TList; Item: Pointer): Integer; stdcall;
begin
  Result := List.Add(Item);
end;

procedure _TList_Insert(List: TList; nIndex: Integer; Item: Pointer); stdcall;
begin
  List.Insert(nIndex, Item);
end;

function _TList_Get(List: TList; nIndex: Integer): Pointer; stdcall;
begin
  Result := List.Items[nIndex];
end;

procedure _TList_Put(List: TList; nIndex: Integer; Item: Pointer); stdcall;
begin
  List.Items[nIndex] := Item;
end;

procedure _TList_Delete(List: TList; nIndex: Integer); stdcall;
begin
  List.Delete(nIndex);
end;

procedure _TList_Clear(List: TList); stdcall;
begin
  List.Clear;
end;

procedure _TList_Exchange(List: TList; nIndex1, nIndex2: Integer); stdcall;
begin
  List.Exchange(nIndex1, nIndex2);
end;

function _TStringList_Create(): TStringList; stdcall;
begin
  Result := TStringList.Create;
end;

procedure _TStringList_Free(List: TStringList); stdcall;
begin
  List.Free;
end;

function _TStringList_Count(List: TStringList): Integer; stdcall;
begin
  Result := List.Count;
end;

function _TStringList_Add(List: TStringList; s: PChar): Integer; stdcall;
begin
  List.Add(s);
end;

function _TStringList_AddObject(List: TStringList; s: PChar; AObject: TObject): Integer; stdcall;
begin
  List.AddObject(s, AObject);
end;

procedure _TStringList_Insert(List: TStringList; nIndex: Integer; s: PChar); stdcall;
begin
  List.Insert(nIndex, s);
end;

function _TStringList_Get(List: TStringList; nIndex: Integer): PChar; stdcall;
begin
  Result := PChar(List.Strings[nIndex]);
end;

function _TStringList_GetObject(List: TStringList; nIndex: Integer): TObject; stdcall;
begin
  Result := List.Objects[nIndex];
end;

procedure _TStringList_Put(List: TStringList; nIndex: Integer; s: PChar); stdcall;
begin
  List.Strings[nIndex] := s;
end;

procedure _TStringList_PutObject(List: TStringList; nIndex: Integer; AObject: TObject); stdcall;
begin
  List.Objects[nIndex] := AObject;
end;

procedure _TStringList_Delete(List: TStringList; nIndex: Integer); stdcall;
begin
  List.Delete(nIndex);
end;

procedure _TStringList_Clear(List: TStringList); stdcall;
begin
  List.Clear;
end;

procedure _TStringList_Exchange(List: TStringList; nIndex1, nIndex2: Integer); stdcall;
begin
  List.Exchange(nIndex1, nIndex2);
end;

procedure _TStringList_LoadFormFile(List: TStringList; pszFileName: PChar); stdcall;
begin
  List.LoadFromFile(StrPas(pszFileName));
end;

procedure _TStringList_SaveToFile(List: TStringList; pszFileName: PChar); stdcall;
begin
  List.SaveToFile(StrPas(pszFileName));
end;

//==============================================================================

function _TextWidth(const Text: PChar): Integer; stdcall;
begin
  Result := ImageCanvas.TextWidth(Text);
end;

function _TextHeight(const Text: PChar): Integer; stdcall;
begin
  Result := ImageCanvas.TextHeight(Text);
end;

function _GetFontName: PChar; stdcall;
begin
  Result := PChar(MainForm.Canvas.Font.Name);
end;

function _GetFontSize: Integer; stdcall;
begin
  Result := MainForm.Canvas.Font.Size;
end;

function _GetFontStyle: TFontStyles; stdcall;
begin
  Result := MainForm.Canvas.Font.Style;
end;

procedure _SetFontName(Name: PChar); stdcall;
begin
  MainForm.Canvas.Font.Name := Name;
end;

procedure _SetFontSize(Size: Integer); stdcall;
begin
  MainForm.Canvas.Font.Size := Size;
end;

procedure _SetFontStyle(Style: TFontStyles); stdcall;
begin
  MainForm.Canvas.Font.Style := Style;
end;

procedure _PlaySound(Idx: Integer); stdcall;
begin
  PlaySound(Idx);
end;

procedure _Close; stdcall;
begin
  frmMain.Close;
end;

procedure _PomiTextOut(dsurface: TTexture; X, Y: Integer; Str: PChar); stdcall;
begin
  PomiTextOut(dsurface, X, Y, Str);
end;


procedure _SetGuiFontSize(Gui: TDControl; Size: Integer); stdcall;
begin
  Gui.Font.Size := Size;
end;

procedure _SetGuiFontName(Gui: TDControl; Name: PChar); stdcall;
begin
  Gui.Font.Name := Name;
end;

procedure _SetGuiFontStyle(Gui: TDControl; Style: TFontStyles); stdcall;
begin
  MainForm.Canvas.Font.Style := MainForm.Canvas.Font.Style + Style;
end;

procedure _SetGuiFontColor(Gui: TDControl; Color: TColor); stdcall;
begin
  //Gui.Font.Color := Color;
  if Gui is TDLabel then TDLabel(Gui).UpColor := Color;
end;

procedure _SetLabelHotColor(Gui: TDControl; Color: TColor); stdcall;
begin
  if Gui is TDLabel then TDLabel(Gui).HotColor := Color;
end;

procedure _SetLabelDownColor(Gui: TDControl; Color: TColor); stdcall;
begin
  if Gui is TDLabel then TDLabel(Gui).DownColor := Color;
end;

procedure _SetActiveControl(Control: TWinControl); stdcall;
begin
  frmMain.ActiveControl := Control;
end;


function _PlayerVisible: PBoolean; stdcall;
begin
 // Result := @frmMain.Panel.Visible;
end;

procedure _Play; stdcall;
begin
 // frmMain.WindowsMediaPlayer.controls.Play;
end;

procedure _Stop; stdcall;
begin
 // frmMain.WindowsMediaPlayer.controls.Stop;
end;

procedure _Pause; stdcall;
begin
 // frmMain.WindowsMediaPlayer.controls.Pause;
end;

procedure _SetPlayerUrl(AUrl: PChar); stdcall;
begin
 // frmMain.WindowsMediaPlayer.URL := AUrl;
end;

function _PlayerVolume: Integer; stdcall;
begin
 // Result := frmMain.WindowsMediaPlayer.settings.volume;
end;

procedure _SetPlayerVolume(Value: Integer); stdcall;
begin
 // frmMain.WindowsMediaPlayer.settings.volume := Value;
end;

function _PlayerPosition: Double; stdcall;
begin
//  Result := frmMain.WindowsMediaPlayer.Controls.currentPosition;
end;

function _PlayerDuration: Double; stdcall;
begin
  //Result := frmMain.WindowsMediaPlayer.currentMedia.duration;
end;

procedure _SetPlayerPosition(Value: Double); stdcall;
begin
 // frmMain.WindowsMediaPlayer.Controls.currentPosition := Value;
end;

procedure _SetPlayerDuration(Value: Double); stdcall;
begin
  //frmMain.WindowsMediaPlayer.currentMedia.duration := Value;
end;

function _PlayerPositionString: PChar; stdcall;
begin
 // Result := PChar(frmMain.WindowsMediaPlayer.Controls.currentPositionString);
end;

function _PlayerDurationString: PChar; stdcall;
begin
  //Result := PChar(frmMain.WindowsMediaPlayer.currentMedia.durationString);
end;

function _PlayerState: Integer; stdcall;
begin
 // Result := frmMain.WindowsMediaPlayer.playState;
end;

function _PlayerMute: Boolean; stdcall;
begin
 // Result := frmMain.WindowsMediaPlayer.settings.Mute;
end;

procedure _SetPlayerMute(Value: Boolean); stdcall;
begin
  //frmMain.WindowsMediaPlayer.settings.Mute := Value
end;

procedure _SetPlayerAlign(Value: TAlign); stdcall;
begin
 // frmMain.Panel.Align := Value;
end;

procedure _SetPlayerParent(Value: TWinControl); stdcall;
begin
 { if Value <> nil then begin
    frmMain.Panel.Parent := Value;
  end else begin
    frmMain.Panel.Visible := False;
    frmMain.Panel.Parent := frmMain;
  end; }
end;

procedure PlugInitialize(PlugInfo: pTPlugInfo);
begin
  PlugInfo.Draw := _Draw;
  PlugInfo.DrawRect := _DrawRect;
  PlugInfo.DrawAlpha := _DrawAlpha;
  PlugInfo.StretchDraw := _StretchDraw;
  PlugInfo.DrawBlend := _DrawBlend;

  PlugInfo.Fill := _Fill;
  PlugInfo.FillRect := _FillRect;
  PlugInfo.FillRectAlpha := _FillRectAlpha;

  PlugInfo.GuiManage.DWinList := DWinMan.DWinList;
  PlugInfo.GuiManage.Create := _CreateGui;
  PlugInfo.GuiManage.Free := _GuiFree;
  PlugInfo.GuiManage.SetConfig := _SetGuiConfig;
  PlugInfo.GuiManage.GetGuiInfo := _GetGuiInfo;
  PlugInfo.GuiManage.SetEditMainMenu := _SetEditMainMenu;
  PlugInfo.GuiManage.GetGuiImage := _GetGuiImage;
  PlugInfo.GuiManage.SetGuiImage := _SetGuiImage;
  PlugInfo.GuiManage.GetDParent := _GetDParent;
  PlugInfo.GuiManage.SetDParent := _SetDParent;
  PlugInfo.GuiManage.SetImgIndex := _SetImgIndex;
  PlugInfo.GuiManage.SetFocus := _SetFocus;

  PlugInfo.GuiManage.SurfaceX := _SurfaceX;
  PlugInfo.GuiManage.SurfaceY := _SurfaceY;

  PlugInfo.GuiManage.SetOnDirectPaint := _SetOnDirectPaint;
  PlugInfo.GuiManage.SetOnKeyPress := _SetOnKeyPress;
  PlugInfo.GuiManage.SetOnKeyDown := _SetOnKeyDown;
  PlugInfo.GuiManage.SetOnMouseMove := _SetOnMouseMove;
  PlugInfo.GuiManage.SetOnMouseDown := _SetOnMouseDown;
  PlugInfo.GuiManage.SetOnMouseUp := _SetOnMouseUp;

  PlugInfo.GuiManage.SetOnDblClick := _SetOnDblClick;
  PlugInfo.GuiManage.SetOnClick := _SetOnClick;
  PlugInfo.GuiManage.SetOnButtonClick := _SetOnButtonClick;
  PlugInfo.GuiManage.SetOnInRealArea := _SetOnInRealArea;
  PlugInfo.GuiManage.SetOnClickSound := _SetOnClickSound;

  PlugInfo.GuiManage.SetOnGridSelect := _SetOnGridSelect;
  PlugInfo.GuiManage.SetOnGridMouseMove := _SetOnGridMouseMove;
  PlugInfo.GuiManage.SetOnGridPaint := _SetOnGridPaint;
  PlugInfo.GuiManage.SetOnItemClick := _SetOnItemClick;

  PlugInfo.GuiManage.GetGuiMouseMoved := _GetGuiMouseMoved;
  PlugInfo.GuiManage.GetGuiDowned := _GetGuiDowned;

  PlugInfo.GuiManage.GetGuiVisible := _GetGuiVisible;
  PlugInfo.GuiManage.GetGuiEnableFocus := _GetGuiEnableFocus;

  PlugInfo.GuiManage.GetGuiFaceIndex := _GetGuiFaceIndex;
  PlugInfo.GuiManage.GetGuiLeft := _GetGuiLeft;
  PlugInfo.GuiManage.GetGuiTop := _GetGuiTop;
  PlugInfo.GuiManage.GetGuiWidth := _GetGuiWidth;
  PlugInfo.GuiManage.GetGuiHeight := _GetGuiHeight;

  PlugInfo.GuiManage.GetWindowFloating := _GetWindowFloating;

  PlugInfo.GuiManage.GetGridColCount := _GetGridColCount;
  PlugInfo.GuiManage.GetGridRowCount := _GetGridRowCount;
  PlugInfo.GuiManage.GetGridColWidth := _GetGridColWidth;
  PlugInfo.GuiManage.GetGridRowHeight := _GetGridRowHeight;

  PlugInfo.GuiManage.GetEditPaste := _GetEditPaste;
  PlugInfo.GuiManage.GetEditDrawBkgrnd := _GetEditDrawBkgrnd;
  PlugInfo.GuiManage.GetEditDrawBorder := _GetEditDrawBorder;
  PlugInfo.GuiManage.GetEditPasswordChar := _GetEditPasswordChar;
  PlugInfo.GuiManage.GetEditAllowSelectText := _GetEditAllowSelectText;

  PlugInfo.GuiManage.SetLabelCaption := _SetLabelCaption;
  PlugInfo.GuiManage.SetEditText := _SetEditText;
  PlugInfo.GuiManage.GetLabelCaption := _GetLabelCaption;
  PlugInfo.GuiManage.GetEditText := _GetEditText;


  PlugInfo.GuiManage.SetGuiFontSize := _SetGuiFontSize;
  PlugInfo.GuiManage.SetGuiFontName := _SetGuiFontName;
  PlugInfo.GuiManage.SetGuiFontStyle := _SetGuiFontStyle;
  PlugInfo.GuiManage.SetGuiFontColor := _SetGuiFontColor;

  PlugInfo.GuiManage.SetLabelHotColor := _SetLabelHotColor;
  PlugInfo.GuiManage.SetLabelDownColor := _SetLabelDownColor;






  PlugInfo.ImageManage.Create := _CreateImage;
  PlugInfo.ImageManage.Free := _FreeImage;
  PlugInfo.ImageManage.Initialize := _InitializeImage;
  PlugInfo.ImageManage.Finalize := _FinalizeImage;
  PlugInfo.ImageManage.SetConfig := _SeTImageConfig;
  PlugInfo.ImageManage.GetImageInfo := _GetImageInfo;
  PlugInfo.ImageManage.GetImageIndexList := _GetImageIndexList;

  PlugInfo.ImageManage.WEffectImg := g_WEffectImg;
  PlugInfo.ImageManage.WDragonImg := g_WDragonImg;

  PlugInfo.ImageManage.WMainImages := g_WMainImages;
  PlugInfo.ImageManage.WMain2Images := g_WMain2Images;
  PlugInfo.ImageManage.WMain3Images := g_WMain3Images;
  PlugInfo.ImageManage.WChrSelImages := g_WChrSelImages;
  PlugInfo.ImageManage.WMMapImages := g_WMMapImages;
  PlugInfo.ImageManage.WTilesImages := g_WTilesImages;
  PlugInfo.ImageManage.WSmTilesImages := g_WSmTilesImages;
  PlugInfo.ImageManage.WHumWingImages := g_WHumWingImages;
  PlugInfo.ImageManage.WHum1WingImages := g_WHum1WingImages;
  PlugInfo.ImageManage.WHum2WingImages := g_WHum2WingImages;
  PlugInfo.ImageManage.WBagItemImages := g_WBagItemImages;
  PlugInfo.ImageManage.WStateItemImages := g_WStateItemImages;
  PlugInfo.ImageManage.WDnItemImages := g_WDnItemImages;
  PlugInfo.ImageManage.WHumImgImages := g_WHumImgImages;
  PlugInfo.ImageManage.WHairImgImages := g_WHairImgImages;
  PlugInfo.ImageManage.WHair2ImgImages := g_WHair2ImgImages;
  PlugInfo.ImageManage.WWeaponImages := g_WWeaponImages;
  PlugInfo.ImageManage.WMagIconImages := g_WMagIconImages;
  PlugInfo.ImageManage.WNpcImgImages := g_WNpcImgImages;
  PlugInfo.ImageManage.WMagicImages := g_WMagicImages;
  PlugInfo.ImageManage.WMagic2Images := g_WMagic2Images;
  PlugInfo.ImageManage.WMagic3Images := g_WMagic3Images;
  PlugInfo.ImageManage.WMagic4Images := g_WMagic4Images;
  PlugInfo.ImageManage.WMagic5Images := g_WMagic5Images;
  PlugInfo.ImageManage.WMagic6Images := g_WMagic6Images;
  PlugInfo.ImageManage.WMagic7Images := g_WMagic7Images;
  PlugInfo.ImageManage.WMagic8Images := g_WMagic8Images;

  PlugInfo.ImageManage.WUIBImages := g_WUIBImages;
  PlugInfo.ImageManage.WBookImages := g_WBookImages;
  PlugInfo.ImageManage.WMiniMapImages := g_WMiniMapImages;
  PlugInfo.ImageManage.WCqFirImages := g_WCqFirImages;
  PlugInfo.ImageManage.WKInterfaceImages := g_WKInterfaceImages;
  PlugInfo.ImageManage.WHorseImages := g_WHorseImages;
  PlugInfo.ImageManage.WHumHorseImages := g_WHumHorseImages;
  PlugInfo.ImageManage.WHairHorseImages := g_WHairHorseImages;


  PlugInfo.List_Create := _TList_Create;
  PlugInfo.List_Free := _TList_Free;
  PlugInfo.List_Count := _TList_Count;
  PlugInfo.List_Add := _TList_Add;
  PlugInfo.List_Insert := _TList_Insert;

  PlugInfo.List_Get := _TList_Get;
  PlugInfo.List_Put := _TList_Put;
  PlugInfo.List_Delete := _TList_Delete;
  PlugInfo.List_Clear := _TList_Clear;
  PlugInfo.List_Exchange := _TList_Exchange;

  PlugInfo.StringList_Create := _TStringList_Create;
  PlugInfo.StringList_Free := _TStringList_Free;
  PlugInfo.StringList_Count := _TStringList_Count;
  PlugInfo.StringList_Add := _TStringList_Add;
  PlugInfo.StringList_AddObject := _TStringList_AddObject;
  PlugInfo.StringList_Insert := _TStringList_Insert;
  PlugInfo.StringList_Get := _TStringList_Get;
  PlugInfo.StringList_GetObject := _TStringList_GetObject;
  PlugInfo.StringList_Put := _TStringList_Put;
  PlugInfo.StringList_PutObject := _TStringList_PutObject;
  PlugInfo.StringList_Delete := _TStringList_Delete;
  PlugInfo.StringList_Clear := _TStringList_Clear;
  PlugInfo.StringList_Exchange := _TStringList_Exchange;
  PlugInfo.StringList_LoadFormFile := _TStringList_LoadFormFile;
  PlugInfo.StringList_SaveToFile := _TStringList_SaveToFile;


  PlugInfo.HookInitialize := nil;
  PlugInfo.HookInitializeEnd := nil;
  PlugInfo.HookFinalize := nil;
  PlugInfo.HookKeyDown := nil;
  PlugInfo.HookKeyPress := nil;
  PlugInfo.HookSocketConnect := nil;
  PlugInfo.HookSocketRead := nil;
  PlugInfo.HookSendSocket := nil;
  PlugInfo.HookDecodeMessagePacket := nil;
  PlugInfo.HookClientGetMessage := nil;
  PlugInfo.HookFlip := nil;
  PlugInfo.HookOpenLoginDoor := nil;
  PlugInfo.HookLoginScene := nil;
  PlugInfo.HookSelectChrScene := nil;
  PlugInfo.HookPlayScene := nil;
  PlugInfo.HookGuiInitializeBegin := nil;
  PlugInfo.HookGuiInitializeEnd := nil;

  PlugInfo.HookShowMonName := nil;
  PlugInfo.HookShowItemName := nil;


  PlugInfo.Account := _Account;
  PlugInfo.PassWord := _PassWord;

  PlugInfo.ChangeScene := _ChangeScene;
  PlugInfo.GetRGB := _GetRGB;

  PlugInfo.OpenHomePage := nil;
  with PlugInfo.MediaPlayer do begin
    //WindowsMediaPlayer := frmMain.WindowsMediaPlayer;
    SetPlayerAlign := nil;
    SetPlayerParent := nil;

    Player := nil;
    Visible := nil;
    Play := nil;
    Stop := nil;
    Pause := nil;
    StopPlay := nil;
    Url := nil;

    PositionString := nil;
    DurationString := nil;
    PlayState := nil;

    Volume := nil;
    Position := nil;
    Duration := nil;
    Mute := nil;

    SetVolume := nil;
    SetPosition := nil;
    SetDuration := nil;
    SetMute := nil;

    PlayerMouseMove := nil;
    PlayerMediaError := nil;
    PlayerStateChange := nil;
    PlayerError := nil;
  end;

  PlugInfo.LogOut := _LogOut;
  PlugInfo.Close := _Close;
  PlugInfo.KeyDown := _KeyDown;
  PlugInfo.KeyPress := _KeyPress;

  PlugInfo.SendSocket := _SendSocket;
  PlugInfo.MessageDlg := _MessageDlg;
  PlugInfo.AddSysMsg := _AddSysMsg;
  PlugInfo.AddChatBoardString := _AddChatBoardString;
  PlugInfo.ShowHint := _ShowHint;
  PlugInfo.ClearHint := _ClearHint;
  PlugInfo.TextOut := _TextOut;
  PlugInfo.TextRect := _TextRect;

  PlugInfo.BoldTextOut := _BoldTextOut;
  PlugInfo.BoldTextRect := _BoldTextRect;
  PlugInfo.PomiTextOut := _PomiTextOut;

  PlugInfo.TextWidth := _TextWidth;
  PlugInfo.TextHeight := _TextHeight;
  PlugInfo.GetFontName := _GetFontName;
  PlugInfo.GetFontSize := _GetFontSize;
  PlugInfo.GetFontStyle := _GetFontStyle;
  PlugInfo.SetFontName := _SetFontName;
  PlugInfo.SetFontSize := _SetFontSize;
  PlugInfo.SetFontStyle := _SetFontStyle;


  PlugInfo.UseMagic := _UseMagic;
  PlugInfo.GetMouseItemInfo := _GetMouseItemInfo;

  PlugInfo.ScreenXYfromMCXY := _ScreenXYfromMCXY;
  PlugInfo.CXYfromMouseXY := _CXYfromMouseXY;

  PlugInfo.IsSelectMyself := _IsSelectMyself;
  PlugInfo.GetXYDropItems := _GetXYDropItems;

  PlugInfo.CanRun := _CanRun;
  PlugInfo.CanWalk := _CanWalk;
  PlugInfo.CanWalkEx := _CanWalkEx;
  PlugInfo.CrashMan := _CrashMan;
  PlugInfo.CanFly := _CanFly;

  PlugInfo.PlaySound := _PlaySound;


  PlugInfo.ConnectionStep := @g_ConnectionStep;
  PlugInfo.Config := @g_Config;
  PlugInfo.ServerName := _ServerName;
  PlugInfo.SelChrName := _SelChrName;
  PlugInfo.SetSelChrName := _SetSelChrName;

  PlugInfo.BufCode := @Code;
  PlugInfo.SoftClosed := @g_SoftClosed;

  PlugInfo.ServerList := g_ServerList;

  PlugInfo.MagicList := g_MagicList; //技能列表
  PlugInfo.HeroMagicList := g_HeroMagicList; //英雄技能列表

  PlugInfo.MouseCurrX := @g_nMouseCurrX; //鼠标所在地图位置座标X
  PlugInfo.MouseCurrY := @g_nMouseCurry; //鼠标所在地图位置座标Y
  PlugInfo.MouseX := @g_nMouseX; //鼠标所在屏幕位置座标X
  PlugInfo.MouseY := @g_nMouseY; //鼠标所在屏幕位置座标Y

  PlugInfo.TargetX := @g_nTargetX; //目标座标
  PlugInfo.TargetY := @g_nTargetY; //目标座标
  PlugInfo.TargetCret := @g_TargetCret;
  PlugInfo.FocusCret := @g_FocusCret;
  PlugInfo.MagicTarget := @g_MagicTarget;

  PlugInfo.MySelf := @g_MySelf;
  PlugInfo.MyHero := @g_MyHero; //我的英雄

  PlugInfo.UseItems := @g_UseItems;
  PlugInfo.ItemArr := @g_ItemArr;
  PlugInfo.HeroUseItems := @g_HeroUseItems;
  PlugInfo.HeroItemArr := @g_HeroItemArr;

  PlugInfo.MouseItem := @g_MouseItem;
  PlugInfo.MouseStateItem := @g_MouseStateItem;
  PlugInfo.MouseUserStateItem := @g_MouseUserStateItem;

  PlugInfo.MouseHeroItem := @g_MouseHeroItem;
  PlugInfo.MouseHeroStateItem := @g_MouseHeroStateItem;
  PlugInfo.MouseHeroUserStateItem := @g_MouseHeroUserStateItem;

  PlugInfo.btItemMoving := @g_btItemMoving; //物品移动状态
  PlugInfo.boItemMoving := @g_boItemMoving; //正在移动物品
  PlugInfo.MovingItem := @g_MovingItem;
  PlugInfo.WaitingUseItem := @g_WaitingUseItem;
  PlugInfo.WaitingHeroUseItem := @g_WaitingHeroUseItem;
  PlugInfo.FocusItem := @g_FocusItem;

  PlugInfo.EatingItem := @g_EatingItem;
  PlugInfo.dwEatTime := @g_dwEatTime;

  PlugInfo.HeroEatingItem := @g_HeroEatingItem;
  PlugInfo.dwHeroEatTime := @g_dwHeroEatTime;

  PlugInfo.SoundList := g_SoundList;
  PlugInfo.ActorList := PlayScene.m_ActorList;
  PlugInfo.DropedItemList := g_DropedItemList;
  PlugInfo.FullScreen := @g_boFullScreen;

  PlugInfo.Actor_nRecogId := _Actor_nRecogId; //角色标识 0x4
  PlugInfo.Actor_nCurrX := _Actor_nCurrX; //当前所在地图座标X 0x08
  PlugInfo.Actor_nCurrY := _Actor_nCurrY; //当前所在地图座标Y 0x0A
  PlugInfo.Actor_btDir := _Actor_btDir; //当前站立方向 0x0C
  PlugInfo.Actor_btSex := _Actor_btSex; //性别 0x0D
  PlugInfo.Actor_btRace := _Actor_btRace; //0x0E
  PlugInfo.Actor_btHair := _Actor_btHair; //头发类型 0x0F
  PlugInfo.Actor_btDress := _Actor_btDress; //衣服类型 0x10
  PlugInfo.Actor_btWeapon := _Actor_btWeapon; //武器类型
  PlugInfo.Actor_btHorse := _Actor_btHorse; //马类型
  PlugInfo.Actor_btJob := _Actor_btJob;
  PlugInfo.Actor_wAppearance := _Actor_wAppearance; //0x14
  PlugInfo.Actor_btDeathState := _Actor_btDeathState;
  PlugInfo.Actor_nFeature := _Actor_nFeature; //0x18
  PlugInfo.Actor_nFeatureEx := _Actor_nFeatureEx; //0x18
  PlugInfo.Actor_nState := _Actor_nState; //0x1C
  PlugInfo.Actor_boDeath := _Actor_boDeath; //0x20
  PlugInfo.Actor_boDelActor := _Actor_boDelActor; //0x22
  PlugInfo.Actor_boDelActionAfterFinished := _Actor_boDelActionAfterFinished; //0x23
  PlugInfo.Actor_sDescUserName := _Actor_sDescUserName; //人物名称，后缀
  PlugInfo.Actor_sUserName := _Actor_sUserName; //0x28
  PlugInfo.Actor_nNameColor := _Actor_nNameColor; //0x2C
  PlugInfo.Actor_Abil := _Actor_Abil; //0x30
  PlugInfo.Actor_nGold := _Actor_nGold; //金币数量0x58
  PlugInfo.Actor_nGameGold := _Actor_nGameGold; //游戏币数量
  PlugInfo.Actor_nGamePoint := _Actor_nGamePoint; //游戏点数量
  PlugInfo.DeleteActor := _DeleteActor;

  PlugInfo.ServerConfig := @g_ServerConfig;
end;


//==============================================================================

constructor TPlugGuiNotifyEvent.Create();
begin
  Gui := nil;
  FOnDirectPaint := nil;
  FOnKeyPress := nil;
  FOnKeyDown := nil;
  FOnMouseMove := nil;
  FOnMouseDown := nil;
  FOnMouseUp := nil;
  FOnDblClick := nil;
  FOnClick := nil;
  FOnInRealArea := nil;
  FOnBackgroundClick := nil;
  FOnButtonClick := nil;
  FOnGridSelect := nil;
  FOnGridMouseMove := nil;
  FOnGridPaint := nil;
  FOnClickSound := nil;
end;

procedure TPlugGuiNotifyEvent.OnDirectPaint(Sender: TObject; dsurface: TTexture);
begin
  if Assigned(FOnDirectPaint) then FOnDirectPaint(Sender, dsurface);
end;

procedure TPlugGuiNotifyEvent.OnKeyPress(Sender: TObject; var Key: Char);
begin
  if Assigned(FOnKeyPress) then FOnKeyPress(Sender, Key);
end;

procedure TPlugGuiNotifyEvent.OnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Assigned(FOnKeyDown) then FOnKeyDown(Sender, Key, Shift);
end;

procedure TPlugGuiNotifyEvent.OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseMove) then FOnMouseMove(Sender, Shift, X, Y);
end;

procedure TPlugGuiNotifyEvent.OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseDown) then FOnMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TPlugGuiNotifyEvent.OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseUp) then FOnMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TPlugGuiNotifyEvent.OnDblClick(Sender: TObject);
begin
  if Assigned(FOnDblClick) then FOnDblClick(Sender);
end;

procedure TPlugGuiNotifyEvent.OnClick(Sender: TObject; X, Y: Integer);
begin
  if Assigned(FOnClick) then FOnClick(Sender, X, Y);
end;

procedure TPlugGuiNotifyEvent.OnButtonClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnButtonClick) then FOnButtonClick(Sender, Button, Shift, X, Y);
end;

procedure TPlugGuiNotifyEvent.OnInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
begin
  if Assigned(FOnInRealArea) then FOnInRealArea(Sender, X, Y, IsRealArea);
end;

procedure TPlugGuiNotifyEvent.OnGridSelect(Sender: TObject; ACol, ARow: Integer; Shift: TShiftState);
begin
  if Assigned(FOnGridSelect) then FOnGridSelect(Sender, ACol, ARow, Shift);
end;

procedure TPlugGuiNotifyEvent.OnGridMouseMove(Sender: TObject; ACol, ARow: Integer; Shift: TShiftState);
begin
  if Assigned(FOnGridMouseMove) then FOnGridMouseMove(Sender, ACol, ARow, Shift);
end;

procedure TPlugGuiNotifyEvent.OnGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState; dsurface: TTexture);
begin
  if Assigned(FOnGridPaint) then FOnGridPaint(Sender, ACol, ARow, Rect, State, dsurface);
end;

procedure TPlugGuiNotifyEvent.OnClickSound(Sender: TObject; Clicksound: TClickSound);
begin
  if Assigned(FOnClickSound) then FOnClickSound(Sender, Clicksound);
end;

procedure TPlugGuiNotifyEvent.OnItemClick(Sender: TObject; Itemindex: Integer);
begin

end;

destructor TPlugGuiNotifyEvent.Destroy;
begin
  inherited;
end;


constructor TPlugGuiManage.Create();
begin
  PlugGuiList := TStringList.Create;
end;

destructor TPlugGuiManage.Destroy;
var
  I: Integer;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Free;
  end;
  PlugGuiList.Free;
  inherited;
end;

procedure TPlugGuiManage.Delete(Gui: TDControl);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
      TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Free;
      PlugGuiList.Delete(I);
      break;
    end;
  end;
end;

procedure TPlugGuiManage.Add(Gui: TDControl; Config: pTGuiConfig);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  if Assigned(Config.OnDirectPaint) or
    Assigned(Config.OnKeyPress) or
    Assigned(Config.OnKeyDown) or
    Assigned(Config.OnMouseMove) or
    Assigned(Config.OnMouseDown) or
    Assigned(Config.OnMouseUp) or
    Assigned(Config.OnDblClick) or
    Assigned(Config.OnClick) or
    Assigned(Config.OnInRealArea) or
    Assigned(Config.OnBackgroundClick) or
    Assigned(Config.OnButtonClick) or
    Assigned(Config.OnGridSelect) or
    Assigned(Config.OnGridMouseMove) or
    Assigned(Config.OnGridPaint) or
    Assigned(Config.OnClickSound) then begin
    for I := 0 to PlugGuiList.Count - 1 do begin
      if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
        PlugGuiNotifyEvent := TPlugGuiNotifyEvent(PlugGuiList.Objects[I]);
        PlugGuiNotifyEvent.Gui := Gui;
        PlugGuiNotifyEvent.FOnDirectPaint := Config.OnDirectPaint;
        PlugGuiNotifyEvent.FOnKeyPress := Config.OnKeyPress;
        PlugGuiNotifyEvent.FOnKeyDown := Config.OnKeyDown;
        PlugGuiNotifyEvent.FOnMouseMove := Config.OnMouseMove;
        PlugGuiNotifyEvent.FOnMouseDown := Config.OnMouseDown;
        PlugGuiNotifyEvent.FOnMouseUp := Config.OnMouseUp;
        PlugGuiNotifyEvent.FOnDblClick := Config.OnDblClick;
        PlugGuiNotifyEvent.FOnClick := Config.OnClick;
        PlugGuiNotifyEvent.FOnInRealArea := Config.OnInRealArea;
        PlugGuiNotifyEvent.FOnBackgroundClick := Config.OnBackgroundClick;
        PlugGuiNotifyEvent.FOnButtonClick := Config.OnButtonClick;
        PlugGuiNotifyEvent.FOnGridSelect := Config.OnGridSelect;
        PlugGuiNotifyEvent.FOnGridMouseMove := Config.OnGridMouseMove;
        PlugGuiNotifyEvent.FOnGridPaint := Config.OnGridPaint;
        PlugGuiNotifyEvent.FOnClickSound := Config.OnClickSound;
        if Gui is TDGrid then begin
          TDGrid(Gui).OnGridSelect := PlugGuiNotifyEvent.OnGridSelect;
          TDGrid(Gui).OnGridPaint := PlugGuiNotifyEvent.OnGridPaint;
          TDGrid(Gui).OnGridMouseMove := PlugGuiNotifyEvent.OnGridMouseMove;
        end;
        Gui.OnDirectPaint := PlugGuiNotifyEvent.OnDirectPaint;
        Gui.OnKeyPress := PlugGuiNotifyEvent.OnKeyPress;
        Gui.OnKeyDown := PlugGuiNotifyEvent.OnKeyDown;
        Gui.OnMouseMove := PlugGuiNotifyEvent.OnMouseMove;
        Gui.OnMouseDown := PlugGuiNotifyEvent.OnMouseDown;
        Gui.OnMouseUp := PlugGuiNotifyEvent.OnMouseUp;
        Gui.OnDblClick := PlugGuiNotifyEvent.OnDblClick;
        Gui.OnClick := PlugGuiNotifyEvent.OnClick;
        //Gui.OnButtonClick := PlugGuiNotifyEvent.OnButtonClick;
        Gui.OnInRealArea := PlugGuiNotifyEvent.OnInRealArea;
      //Gui.OnBackgroundClick := PlugGuiNotifyEvent.OnBackgroundClick;
        Exit;
      end;
    end;
    PlugGuiNotifyEvent := TPlugGuiNotifyEvent.Create;
    PlugGuiNotifyEvent.Gui := Gui;
    PlugGuiNotifyEvent.FOnDirectPaint := Config.OnDirectPaint;
    PlugGuiNotifyEvent.FOnKeyPress := Config.OnKeyPress;
    PlugGuiNotifyEvent.FOnKeyDown := Config.OnKeyDown;
    PlugGuiNotifyEvent.FOnMouseMove := Config.OnMouseMove;
    PlugGuiNotifyEvent.FOnMouseDown := Config.OnMouseDown;
    PlugGuiNotifyEvent.FOnMouseUp := Config.OnMouseUp;
    PlugGuiNotifyEvent.FOnDblClick := Config.OnDblClick;
    PlugGuiNotifyEvent.FOnClick := Config.OnClick;
    PlugGuiNotifyEvent.FOnInRealArea := Config.OnInRealArea;
    PlugGuiNotifyEvent.FOnBackgroundClick := Config.OnBackgroundClick;
    PlugGuiNotifyEvent.FOnButtonClick := Config.OnButtonClick;
    PlugGuiNotifyEvent.FOnGridSelect := Config.OnGridSelect;
    PlugGuiNotifyEvent.FOnGridMouseMove := Config.OnGridMouseMove;
    PlugGuiNotifyEvent.FOnGridPaint := Config.OnGridPaint;
    PlugGuiNotifyEvent.FOnClickSound := Config.OnClickSound;
    if Gui is TDGrid then begin
      TDGrid(Gui).OnGridSelect := PlugGuiNotifyEvent.OnGridSelect;
      TDGrid(Gui).OnGridPaint := PlugGuiNotifyEvent.OnGridPaint;
      TDGrid(Gui).OnGridMouseMove := PlugGuiNotifyEvent.OnGridMouseMove;
    end;
    Gui.OnDirectPaint := PlugGuiNotifyEvent.OnDirectPaint;
    Gui.OnKeyPress := PlugGuiNotifyEvent.OnKeyPress;
    Gui.OnKeyDown := PlugGuiNotifyEvent.OnKeyDown;
    Gui.OnMouseMove := PlugGuiNotifyEvent.OnMouseMove;
    Gui.OnMouseDown := PlugGuiNotifyEvent.OnMouseDown;
    Gui.OnMouseUp := PlugGuiNotifyEvent.OnMouseUp;
    Gui.OnDblClick := PlugGuiNotifyEvent.OnDblClick;
    Gui.OnClick := PlugGuiNotifyEvent.OnClick;
    //Gui.OnButtonClick := PlugGuiNotifyEvent.OnButtonClick;
    Gui.OnInRealArea := PlugGuiNotifyEvent.OnInRealArea;
    PlugGuiList.AddObject('', PlugGuiNotifyEvent);
  end;
end;

procedure TPlugGuiManage.Add(Gui: TDControl; OnDirectPaint: TOn_DirectPaint);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
      PlugGuiNotifyEvent := TPlugGuiNotifyEvent(PlugGuiList.Objects[I]);
      PlugGuiNotifyEvent.FOnDirectPaint := OnDirectPaint;
      Gui.OnDirectPaint := PlugGuiNotifyEvent.OnDirectPaint;
      Exit;
    end;
  end;
  PlugGuiNotifyEvent := TPlugGuiNotifyEvent.Create;
  PlugGuiNotifyEvent.Gui := Gui;
  PlugGuiNotifyEvent.FOnDirectPaint := OnDirectPaint;
  Gui.OnDirectPaint := PlugGuiNotifyEvent.OnDirectPaint;
  PlugGuiList.AddObject('', PlugGuiNotifyEvent);
end;

procedure TPlugGuiManage.Add(Gui: TDControl; OnKeyPress: TOn_KeyPress);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
      PlugGuiNotifyEvent := TPlugGuiNotifyEvent(PlugGuiList.Objects[I]);
      PlugGuiNotifyEvent.FOnKeyPress := OnKeyPress;
      Gui.OnKeyPress := PlugGuiNotifyEvent.OnKeyPress;
      Exit;
    end;
  end;
  PlugGuiNotifyEvent := TPlugGuiNotifyEvent.Create;
  PlugGuiNotifyEvent.Gui := Gui;
  PlugGuiNotifyEvent.FOnKeyPress := OnKeyPress;
  Gui.OnKeyPress := PlugGuiNotifyEvent.OnKeyPress;
  PlugGuiList.AddObject('', PlugGuiNotifyEvent);
end;

procedure TPlugGuiManage.Add(Gui: TDControl; OnKeyDown: TOn_KeyDown);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
      PlugGuiNotifyEvent := TPlugGuiNotifyEvent(PlugGuiList.Objects[I]);
      PlugGuiNotifyEvent.FOnKeyDown := OnKeyDown;
      Gui.OnKeyDown := PlugGuiNotifyEvent.OnKeyDown;
      Exit;
    end;
  end;
  PlugGuiNotifyEvent := TPlugGuiNotifyEvent.Create;
  PlugGuiNotifyEvent.Gui := Gui;
  PlugGuiNotifyEvent.FOnKeyDown := OnKeyDown;
  Gui.OnKeyDown := PlugGuiNotifyEvent.OnKeyDown;
  PlugGuiList.AddObject('', PlugGuiNotifyEvent);
end;

procedure TPlugGuiManage.AddMouseMove(Gui: TDControl; OnMouseMove: TOn_MouseMove);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
      PlugGuiNotifyEvent := TPlugGuiNotifyEvent(PlugGuiList.Objects[I]);
      PlugGuiNotifyEvent.FOnMouseMove := OnMouseMove;
      Gui.OnMouseMove := PlugGuiNotifyEvent.OnMouseMove;
      Exit;
    end;
  end;
  PlugGuiNotifyEvent := TPlugGuiNotifyEvent.Create;
  PlugGuiNotifyEvent.Gui := Gui;
  PlugGuiNotifyEvent.FOnMouseMove := OnMouseMove;
  Gui.OnMouseMove := PlugGuiNotifyEvent.OnMouseMove;
  PlugGuiList.AddObject('', PlugGuiNotifyEvent);
end;

procedure TPlugGuiManage.AddMouseDown(Gui: TDControl; OnMouseDown: TOn_MouseDown);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
      PlugGuiNotifyEvent := TPlugGuiNotifyEvent(PlugGuiList.Objects[I]);
      PlugGuiNotifyEvent.FOnMouseDown := OnMouseDown;
      Gui.OnMouseDown := PlugGuiNotifyEvent.OnMouseDown;
      Exit;
    end;
  end;
  PlugGuiNotifyEvent := TPlugGuiNotifyEvent.Create;
  PlugGuiNotifyEvent.Gui := Gui;
  PlugGuiNotifyEvent.FOnMouseDown := OnMouseDown;
  Gui.OnMouseDown := PlugGuiNotifyEvent.OnMouseDown;
  PlugGuiList.AddObject('', PlugGuiNotifyEvent);
end;

procedure TPlugGuiManage.AddMouseUp(Gui: TDControl; OnMouseUp: TOn_MouseUp);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
      PlugGuiNotifyEvent := TPlugGuiNotifyEvent(PlugGuiList.Objects[I]);
      PlugGuiNotifyEvent.FOnMouseUp := OnMouseUp;
      Gui.OnMouseUp := PlugGuiNotifyEvent.OnMouseUp;
      Exit;
    end;
  end;
  PlugGuiNotifyEvent := TPlugGuiNotifyEvent.Create;
  PlugGuiNotifyEvent.Gui := Gui;
  PlugGuiNotifyEvent.FOnMouseUp := OnMouseUp;
  Gui.OnMouseUp := PlugGuiNotifyEvent.OnMouseUp;
  PlugGuiList.AddObject('', PlugGuiNotifyEvent);
end;

procedure TPlugGuiManage.Add(Gui: TDControl; OnClick: TOn_ClickEx);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
      PlugGuiNotifyEvent := TPlugGuiNotifyEvent(PlugGuiList.Objects[I]);
      PlugGuiNotifyEvent.FOnClick := OnClick;
      if Gui is TDButton then begin
        TDButton(Gui).OnClick := PlugGuiNotifyEvent.OnClick;
      end else
        if Gui is TDWindow then begin
        TDWindow(Gui).OnClick := PlugGuiNotifyEvent.OnClick;
      end else
        if Gui is TDLabel then begin
        TDLabel(Gui).OnClick := PlugGuiNotifyEvent.OnClick;
      end else begin
        Gui.OnClick := PlugGuiNotifyEvent.OnClick;
      end;
      Exit;
    end;
  end;
  PlugGuiNotifyEvent := TPlugGuiNotifyEvent.Create;
  PlugGuiNotifyEvent.Gui := Gui;
  PlugGuiNotifyEvent.FOnClick := OnClick;
  if Gui is TDButton then begin
    TDButton(Gui).OnClick := PlugGuiNotifyEvent.OnClick;
  end else
    if Gui is TDWindow then begin
    TDWindow(Gui).OnClick := PlugGuiNotifyEvent.OnClick;
  end else
    if Gui is TDLabel then begin
    TDLabel(Gui).OnClick := PlugGuiNotifyEvent.OnClick;
  end else begin
    Gui.OnClick := PlugGuiNotifyEvent.OnClick;
  end;
  PlugGuiList.AddObject('', PlugGuiNotifyEvent);
end;

procedure TPlugGuiManage.Add(Gui: TDControl; OnDblClick: TOn_Click);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
      PlugGuiNotifyEvent := TPlugGuiNotifyEvent(PlugGuiList.Objects[I]);
      PlugGuiNotifyEvent.FOnDblClick := OnDblClick;

      if Gui is TDButton then begin
        TDButton(Gui).OnDblClick := PlugGuiNotifyEvent.OnDblClick;
      end else
        if Gui is TDWindow then begin
        TDWindow(Gui).OnDblClick := PlugGuiNotifyEvent.OnDblClick;
      end else
        if Gui is TDLabel then begin
        TDLabel(Gui).OnDblClick := PlugGuiNotifyEvent.OnDblClick;
      end else begin
        Gui.OnDblClick := PlugGuiNotifyEvent.OnDblClick;
      end;
      Exit;
    end;
  end;
  PlugGuiNotifyEvent := TPlugGuiNotifyEvent.Create;
  PlugGuiNotifyEvent.Gui := Gui;
  PlugGuiNotifyEvent.FOnDblClick := OnDblClick;
  if Gui is TDButton then begin
    TDButton(Gui).OnDblClick := PlugGuiNotifyEvent.OnDblClick;
  end else
    if Gui is TDWindow then begin
    TDWindow(Gui).OnDblClick := PlugGuiNotifyEvent.OnDblClick;
  end else
    if Gui is TDLabel then begin
    TDLabel(Gui).OnDblClick := PlugGuiNotifyEvent.OnDblClick;
  end else begin
    Gui.OnDblClick := PlugGuiNotifyEvent.OnDblClick;
  end;
  PlugGuiList.AddObject('', PlugGuiNotifyEvent);
end;

procedure TPlugGuiManage.AddButtonClick(Gui: TDControl; OnButtonClick: TOn_ButtonClick);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
      PlugGuiNotifyEvent := TPlugGuiNotifyEvent(PlugGuiList.Objects[I]);
      PlugGuiNotifyEvent.FOnButtonClick := OnButtonClick;
      //Gui.OnButtonClick := PlugGuiNotifyEvent.OnButtonClick;
      Exit;
    end;
  end;
  PlugGuiNotifyEvent := TPlugGuiNotifyEvent.Create;
  PlugGuiNotifyEvent.Gui := Gui;
  PlugGuiNotifyEvent.FOnButtonClick := OnButtonClick;
  //Gui.OnButtonClick := PlugGuiNotifyEvent.OnButtonClick;
  PlugGuiList.AddObject('', PlugGuiNotifyEvent);
end;

procedure TPlugGuiManage.Add(Gui: TDControl; OnInRealArea: TOn_InRealArea);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
      PlugGuiNotifyEvent := TPlugGuiNotifyEvent(PlugGuiList.Objects[I]);
      PlugGuiNotifyEvent.FOnInRealArea := OnInRealArea;
      Gui.OnInRealArea := PlugGuiNotifyEvent.OnInRealArea;
      Exit;
    end;
  end;
  PlugGuiNotifyEvent := TPlugGuiNotifyEvent.Create;
  PlugGuiNotifyEvent.Gui := Gui;
  PlugGuiNotifyEvent.FOnInRealArea := OnInRealArea;
  Gui.OnInRealArea := PlugGuiNotifyEvent.OnInRealArea;
  PlugGuiList.AddObject('', PlugGuiNotifyEvent);
end;

procedure TPlugGuiManage.Add(Gui: TDControl; OnClickSound: TOn_ClickSound);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
      PlugGuiNotifyEvent := TPlugGuiNotifyEvent(PlugGuiList.Objects[I]);
      PlugGuiNotifyEvent.FOnClickSound := OnClickSound;
      //Gui.OnClickSound := PlugGuiNotifyEvent.OnClickSound;
      Exit;
    end;
  end;
  PlugGuiNotifyEvent := TPlugGuiNotifyEvent.Create;
  PlugGuiNotifyEvent.Gui := Gui;
  PlugGuiNotifyEvent.FOnClickSound := OnClickSound;
  //Gui.OnClickSound := PlugGuiNotifyEvent.OnClickSound;
  PlugGuiList.AddObject('', PlugGuiNotifyEvent);
end;

procedure TPlugGuiManage.Add(Gui: TDGrid; OnGridSelect: TOn_GridSelect);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
      PlugGuiNotifyEvent := TPlugGuiNotifyEvent(PlugGuiList.Objects[I]);
      PlugGuiNotifyEvent.FOnGridSelect := OnGridSelect;
      Gui.OnGridSelect := PlugGuiNotifyEvent.OnGridSelect;
      Exit;
    end;
  end;
  PlugGuiNotifyEvent := TPlugGuiNotifyEvent.Create;
  PlugGuiNotifyEvent.Gui := Gui;
  PlugGuiNotifyEvent.FOnGridSelect := OnGridSelect;
  Gui.OnGridSelect := PlugGuiNotifyEvent.OnGridSelect;
  PlugGuiList.AddObject('', PlugGuiNotifyEvent);
end;

procedure TPlugGuiManage.Add(Gui: TDGrid; OnGridMouseMove: TOn_GridMouseMove);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
      PlugGuiNotifyEvent := TPlugGuiNotifyEvent(PlugGuiList.Objects[I]);
      PlugGuiNotifyEvent.FOnGridMouseMove := OnGridMouseMove;
      Gui.OnGridMouseMove := PlugGuiNotifyEvent.OnGridMouseMove;
      Exit;
    end;
  end;
  PlugGuiNotifyEvent := TPlugGuiNotifyEvent.Create;
  PlugGuiNotifyEvent.Gui := Gui;
  PlugGuiNotifyEvent.FOnGridMouseMove := OnGridMouseMove;
  Gui.OnGridMouseMove := PlugGuiNotifyEvent.OnGridMouseMove;
  PlugGuiList.AddObject('', PlugGuiNotifyEvent);
end;

procedure TPlugGuiManage.Add(Gui: TDGrid; OnGridPaint: TOn_GridPaint);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
      PlugGuiNotifyEvent := TPlugGuiNotifyEvent(PlugGuiList.Objects[I]);
      PlugGuiNotifyEvent.FOnGridPaint := OnGridPaint;
      Gui.OnGridPaint := PlugGuiNotifyEvent.OnGridPaint;
      Exit;
    end;
  end;
  PlugGuiNotifyEvent := TPlugGuiNotifyEvent.Create;
  PlugGuiNotifyEvent.Gui := Gui;
  PlugGuiNotifyEvent.FOnGridPaint := OnGridPaint;
  Gui.OnGridPaint := PlugGuiNotifyEvent.OnGridPaint;
  PlugGuiList.AddObject('', PlugGuiNotifyEvent);
end;

procedure TPlugGuiManage.Add(Gui: TDLabel; OnItemClick: TOn_ItemClick);
var
  I: Integer;
  PlugGuiNotifyEvent: TPlugGuiNotifyEvent;
begin
  for I := 0 to PlugGuiList.Count - 1 do begin
    if TPlugGuiNotifyEvent(PlugGuiList.Objects[I]).Gui = Gui then begin
      PlugGuiNotifyEvent := TPlugGuiNotifyEvent(PlugGuiList.Objects[I]);
      //PlugGuiNotifyEvent.FOnItemClick := OnItemClick;
      //Gui.OnItemClick := PlugGuiNotifyEvent.OnItemClick;
      Exit;
    end;
  end;
  PlugGuiNotifyEvent := TPlugGuiNotifyEvent.Create;
  PlugGuiNotifyEvent.Gui := Gui;
  //PlugGuiNotifyEvent.FOnItemClick := OnItemClick;
  //Gui.OnItemClick := PlugGuiNotifyEvent.OnItemClick;
  PlugGuiList.AddObject('', PlugGuiNotifyEvent);
end;

initialization
  begin
    PlugGuiManage := TPlugGuiManage.Create;
  end;

finalization
  begin
    PlugGuiManage.Free;
  end;

end.

