unit DWinCtl;

interface

uses
  Windows, Messages, Classes, Graphics, SysUtils, Controls, Forms, Textures, Grids,
  Menus, Clipbrd, HUtil32, GameImages, Share, Math;

var
  WINLEFT: Integer = 60;
  WINTOP: Integer = 60;

type
  TClickSound = (csNone, csStone, csGlass, csNorm);

  TDControl = class;
  TDScroll = class;
  TDPageControl = class;
  TDPopupMenu = class;
  TImageIndex = type Integer;

  TOnDirectPaint = procedure(Sender: TObject; dsurface: TTexture) of object;
  TOnKeyPress = procedure(Sender: TObject; var Key: Char) of object;
  TOnKeyDown = procedure(Sender: TObject; var Key: Word; Shift: TShiftState) of object;
  TOnMouseMove = procedure(Sender: TObject; Shift: TShiftState; X, Y: Integer) of object;
  TOnMouseDown = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer) of object;
  TOnMouseUp = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer) of object;
  TOnClick = procedure(Sender: TObject) of object;
  TOnClickEx = procedure(Sender: TObject; X, Y: Integer) of object;
  TOnInRealArea = procedure(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean) of object;
  TOnGridSelect = procedure(Sender: TObject; ACol, ARow: Integer; Shift: TShiftState) of object;
  TOnGridPaint = procedure(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState; dsurface: TTexture) of object;
  TOnClickSound = procedure(Sender: TObject; Clicksound: TClickSound) of object;
  TOnScroll = procedure(Sender: TObject; Increment: Integer) of object;


  TButtonStyle = (bsBase, bsRadio, bsLock);
  TInValue = (vInteger, vString);
  TMenuStyle = (sXP, sVista);

  TColors = class(TGraphicsObject)
  private
    FDisabled: TColor;
    FBkgrnd: TColor;
    FSelected: TColor;
    FBorder: TColor;
    FFont: TColor;
    FHot: TColor;
    FDown: TColor;
    FLine: TColor;
    FUp: TColor;
  public
    constructor Create();
  published
    property Disabled: TColor read FDisabled write FDisabled;
    property Background: TColor read FBkgrnd write FBkgrnd;
    property Selected: TColor read FSelected write FSelected;
    property Border: TColor read FBorder write FBorder;
    property Font: TColor read FFont write FFont;
    property Up: TColor read FUp write FUp;
    property Hot: TColor read FHot write FHot;
    property Down: TColor read FDown write FDown;
    property Line: TColor read FLine write FLine;
  end;

  TDCustomControl = class(TCustomControl)
  private
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure WMSize(var Message: TMessage); message WM_SIZE;
  protected
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TDControl = class(TDCustomControl)
  private
    FIdx: Integer;
    FCaption: string; //0x1F0
    FDParent: TDControl; //0x1F4
    FEnableFocus: Boolean; //0x1F8
    FOnDirectPaint: TOnDirectPaint; //0x1FC
    FOnKeyPress: TOnKeyPress; //0x200
    FOnKeyDown: TOnKeyDown; //0x204
    FOnMouseMove: TOnMouseMove; //0x208
    FOnMouseDown: TOnMouseDown; //0x20C
    FOnMouseUp: TOnMouseUp; //0x210
    FOnDblClick: TNotifyEvent; //0x214
    FOnClick: TOnClickEx; //0x218
    FOnInRealArea: TOnInRealArea; //0x21C
    FOnBackgroundClick: TOnClick; //0x220
    FDowned: Boolean;
    FOnProcess: TNotifyEvent;
    FDScroll: TDScroll;
    FParentNotify: Boolean;
    FX, FY: Integer;
    FString: string;
    FIndex: Integer;
    FData: Pointer;
    FKeyPreview: Boolean;
    FFade: Boolean;
    FFadeAlpha: Integer;
    FFadeTick: Integer;
    procedure SetCaption(Str: string); //dynamic;
    procedure SetDParent(Value: TDControl);
    function GetMouseMove: Boolean;
    function GetClientRect: TRect;
    procedure CaptionChaged; dynamic;
    procedure SetDowned(Value: Boolean);
    procedure SetDScroll(Value: TDScroll);
    function GetFirstDParent: TDControl;
    procedure SetVisible(Value: Boolean);

  protected
    FVisible: Boolean;
    procedure OnScroll(Sender: TObject; Increment: Integer); dynamic;
    procedure ReleaseFocus; dynamic;
    procedure DoShow; dynamic;
  public
    Background: Boolean; //0x24D
    DControls: TList; //0x250
      //FaceSurface: TTexture;
    WLib: TGameImages; //0x254
    FaceIndex: Integer; //0x258
    WantReturn: Boolean; //Background老锭, Click狼 荤侩 咯何..

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Loaded; override;
    procedure UnLoaded;


    function SurfaceX(X: Integer): Integer;
    function SurfaceY(Y: Integer): Integer;
    function LocalX(X: Integer): Integer;
    function LocalY(Y: Integer): Integer;
    procedure AddChild(dcon: TDControl);
    procedure ChangeChildOrder(dcon: TDControl);
    function InRange(X, Y: Integer): Boolean; dynamic;
    function KeyPress(var Key: Char): Boolean; dynamic;
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean; dynamic;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; dynamic;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; dynamic;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; dynamic;
    function DblClick(X, Y: Integer): Boolean; dynamic;
    function Click(X, Y: Integer): Boolean; dynamic;
    function MouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; dynamic;
    function MouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; dynamic;


    function CanFocusMsg: Boolean;

    procedure SetImgIndex(Lib: TGameImages; Index: Integer); dynamic;
    procedure DirectPaint(dsurface: TTexture); dynamic;
    procedure Process; dynamic;
    procedure BringToFront;
    procedure SetFocus; override;

    property MouseMoveing: Boolean read GetMouseMove;

    property Idx: Integer read FIdx write FIdx;
    property TData: string read FString write FString;
    property Data: Pointer read FData write FData;
    property FirstDParent: TDControl read GetFirstDParent;
  published
    property OnProcess: TNotifyEvent read FOnProcess write FOnProcess;
    property OnDirectPaint: TOnDirectPaint read FOnDirectPaint write FOnDirectPaint;
    property OnKeyPress: TOnKeyPress read FOnKeyPress write FOnKeyPress;
    property OnKeyDown: TOnKeyDown read FOnKeyDown write FOnKeyDown;
    property OnMouseMove: TOnMouseMove read FOnMouseMove write FOnMouseMove;
    property OnMouseDown: TOnMouseDown read FOnMouseDown write FOnMouseDown;
    property OnMouseUp: TOnMouseUp read FOnMouseUp write FOnMouseUp;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnClick: TOnClickEx read FOnClick write FOnClick;
    property OnInRealArea: TOnInRealArea read FOnInRealArea write FOnInRealArea;
    property OnBackgroundClick: TOnClick read FOnBackgroundClick write FOnBackgroundClick;
    property Caption: string read FCaption write SetCaption;
    property DParent: TDControl read FDParent write SetDParent;
    property DScroll: TDScroll read FDScroll write SetDScroll;
    property Visible: Boolean read FVisible write SetVisible;
    property Fade: Boolean read FFade write FFade;
    property EnableFocus: Boolean read FEnableFocus write FEnableFocus;
    property Downed: Boolean read FDowned write SetDowned;
    property ParentNotify: Boolean read FParentNotify write FParentNotify;
    property KeyPreview: Boolean read FKeyPreview write FKeyPreview;
    property ClientRect: TRect read GetClientRect;
    property PosX: Integer read FX write FX;
    property PosY: Integer read FY write FY;
    property Color;
    property Font;
    property Hint;
    property ShowHint;
    property Align;
  end;

  TDButton = class(TDControl)
  private
    FClickSound: TClickSound;
    FOnClick: TOnClickEx;
    FOnClickSound: TOnClickSound;
    FButtonStyle: TButtonStyle;
    FAlignment: TAlignment;
    FShowCaption: Boolean;
    FColors: TColors;
    procedure SetAlignment(Value: TAlignment);
  protected

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DirectPaint(dsurface: TTexture); override;
    procedure Process; override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment;
    property ShowCaption: Boolean read FShowCaption write FShowCaption;
    property Colors: TColors read FColors write FColors;
    property ClickCount: TClickSound read FClickSound write FClickSound;
    property OnClick: TOnClickEx read FOnClick write FOnClick;
    property OnClickSound: TOnClickSound read FOnClickSound write FOnClickSound;
    property Style: TButtonStyle read FButtonStyle write FButtonStyle;
  end;

  TDGrid = class(TDControl)
  private
    FColCount, FRowCount: Integer;
    FColWidth, FRowHeight: Integer;
    FViewTopLine: Integer;
    SelectCell: TPoint;
    DownPos: TPoint;
    FOnGridSelect: TOnGridSelect;
    FOnGridMouseMove: TOnGridSelect;
    FOnGridPaint: TOnGridPaint;
    function GetColRow(X, Y: Integer; var ACol, ARow: Integer): Boolean;
  public
    cx, cy: Integer;
    Col, row: Integer;
    constructor Create(AOwner: TComponent); override;
    function InRange(X, Y: Integer): Boolean; override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function Click(X, Y: Integer): Boolean; override;
    procedure DirectPaint(dsurface: TTexture); override;
    procedure ClearSelect;
  published
    property ColCount: Integer read FColCount write FColCount;
    property RowCount: Integer read FRowCount write FRowCount;
    property ColWidth: Integer read FColWidth write FColWidth;
    property RowHeight: Integer read FRowHeight write FRowHeight;
    property ViewTopLine: Integer read FViewTopLine write FViewTopLine;
    property OnGridSelect: TOnGridSelect read FOnGridSelect write FOnGridSelect;
    property OnGridMouseMove: TOnGridSelect read FOnGridMouseMove write FOnGridMouseMove;
    property OnGridPaint: TOnGridPaint read FOnGridPaint write FOnGridPaint;
  end;

  TDWindow = class(TDButton)
  private
    FFloating: Boolean;
    SpotX, SpotY: Integer;
    FDPageControl: TDPageControl;

    procedure SetDPageControl(Value: TDPageControl);
  protected
    procedure DoShow; override;
    //procedure SetVisible(flag: Boolean);
  public
    DialogResult: TModalResult;
    constructor Create(AOwner: TComponent); override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    procedure Show;
    function ShowModal: Integer;
    //procedure SetFocus; override;
  published
    //property Visible: Boolean read FVisible write SetVisible;
    property Floating: Boolean read FFloating write FFloating;
    property DPageControl: TDPageControl read FDPageControl write SetDPageControl;
  end;


  TDMenuItem = class(TObject)
  private
    FVisible: Boolean;
    FEnabled: Boolean;
    FCaption: string;
    FMenu: TDPopupMenu;
    FChecked: Boolean;
  public
    constructor Create();
    destructor Destroy; override;
    property Visible: Boolean read FVisible write FVisible;
    property Enabled: Boolean read FEnabled write FEnabled;
    property Caption: string read FCaption write FCaption;
    property Checked: Boolean read FChecked write FChecked;
    property Menu: TDPopupMenu read FMenu write FMenu;
  end;
  //TDMenuItems = array of TDMenuItem;

  TDPopupMenu = class(TDControl)
  private
    FItems: TStrings;
    FColors: TColors;
    FMoveItemIndex: Integer;
    FItemSize: Integer;
    FMouseMove: Boolean;
    FMouseDown: Boolean;

    FOwnerMenu: TDPopupMenu;
    FItemIndex: Integer;
    FOwnerItemIndex: TImageIndex;
    FActiveMenu: TDPopupMenu;
    FDControl: TDControl;

    FStyle: TMenuStyle;

    function GetMenu(Index: Integer): TDPopupMenu;
    procedure SetMenu(Index: Integer; Value: TDPopupMenu);
    function GetItem(Index: Integer): TDMenuItem;
    function GetCount: Integer;
    procedure SetOwnerItemIndex(Value: TImageIndex);
    procedure SetOwnerMenu(Value: TDPopupMenu);
    procedure SetItems(Value: TStrings);
    function GetItems: TStrings;
    procedure SetColors(Value: TColors);

    procedure SetItemIndex(Value: Integer);
  protected
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Process; override;
    function InRange(X, Y: Integer): Boolean; override;
    procedure DirectPaint(dsurface: TTexture); override;
    function KeyPress(var Key: Char): Boolean; override;
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean; override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function Click(X, Y: Integer): Boolean; override;
    procedure Show; overload;
    procedure Show(d: TDControl); overload;
    procedure Hide;
    procedure Insert(Index: Integer; ACaption: string; Item: TDPopupMenu);
    procedure Delete(Index: Integer);
    procedure Clear;
    function Find(ACaption: string): TDPopupMenu;
    function IndexOf(Item: TDPopupMenu): Integer;
    procedure Add(ACaption: string; Item: TDPopupMenu);
    procedure Remove(Item: TDPopupMenu);
    property Count: Integer read GetCount;
    property Menus[Index: Integer]: TDPopupMenu read GetMenu write SetMenu;
    property Items[Index: Integer]: TDMenuItem read GetItem;
    property DControl: TDControl read FDControl write FDControl;
  published
    property OwnerMenu: TDPopupMenu read FOwnerMenu write SetOwnerMenu;
    property OwnerItemIndex: TImageIndex read FOwnerItemIndex write SetOwnerItemIndex default -1;
    property MenuItems: TStrings read GetItems write SetItems;
    property Colors: TColors read FColors write SetColors;
    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
    property Style: TMenuStyle read FStyle write FStyle;
  end;

  //显示控件
  TDLabel = class(TDControl)
  private

    FClickSound: TClickSound;
    FOnClick: TOnClickEx;
    FOnClickSound: TOnClickSound;
    FAutoSize: Boolean;

    FCurrColor: TColor;
    FUpColor: TColor;
    FHotColor: TColor;
    FDownColor: TColor;

    FColor: TColor;

    FShadowSize: Integer;
    FShadowColor: Integer;
    FUseTick: longword;
    FBold: Boolean;

    FBackground: Boolean;
    FBackgroundColor: TColor;
    FBoldColor: TColor;
    FBorder: Boolean;
    FBorderColor: TColor;
    FHotBorder: TColor;
    FDownBorder: TColor;

    FButtonStyle: TButtonStyle;
    FClickTime: LongWord;

    FBorderCurrColor: TColor;

    FAlignment: TAlignment;
    procedure SetUpColor(Value: TColor);
    procedure CaptionChaged; override;
    procedure SetAlignment(Value: TAlignment);
    procedure SetAutoSize(Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    function InRange(X, Y: Integer): Boolean; override;

    procedure DirectPaint(dsurface: TTexture); override;
    procedure Process; override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    //property Style: TButtonStyle read FButtonStyle write FButtonStyle;
    property ClickTime: LongWord read FClickTime write FClickTime;
    property Canvas;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment;


    property AutoSize: Boolean read FAutoSize write SetAutoSize;
    property Color: TColor read FColor write FColor;
    property UpColor: TColor read FUpColor write SetUpColor;
    property HotColor: TColor read FHotColor write FHotColor;
    property DownColor: TColor read FDownColor write FDownColor;
    property BackgroundColor: TColor read FBackgroundColor write FBackgroundColor;
    property BorderColor: TColor read FBorderColor write FBorderColor;

    property HotBorderColor: TColor read FHotBorder write FHotBorder;
    property DownBorderColor: TColor read FDownBorder write FDownBorder;
    property BoldColor: TColor read FBoldColor write FBoldColor;

    property UseTick: longword read FUseTick write FUseTick;
    property BoldFont: Boolean read FBold write FBold;
    property DrawBackground: Boolean read FBackground write FBackground;
    property Border: Boolean read FBorder write FBorder;

    property ClickCount: TClickSound read FClickSound write FClickSound;
    property OnClick: TOnClickEx read FOnClick write FOnClick;
    property OnClickSound: TOnClickSound read FOnClickSound write FOnClickSound;
    property Style: TButtonStyle read FButtonStyle write FButtonStyle;

  end;


  //输入控件
  TDEdit = class(TDControl)
  private
    Ticks: Integer;
    FText: WideString;
    FViewPos: Integer;
    FTextAdjust: Integer;
    FSelIndex: Integer;
    FBlinkTicks: Integer;
    FReadOnly: Boolean;
    FMaxLength: Integer;
    FTabOrder: Integer;
    bDoubleByte: Boolean;
    InputStr: string;
    KeyByteCount: Integer;

    FSelText: WideString;

    FBeginIndex: Integer;
    FEndIndex: Integer;
    FOnChange: TNotifyEvent;
    FClickSound: TClickSound;
    FOnClick: TOnClickEx;
    FOnClickSound: TOnClickSound;
    FMainMenu: TDPopupMenu;
    FDisabledColor: TColor;
    FBkgrndColor: TColor;
    FSelectedColor: TColor;
    FBorderColor: TColor;
    FSelTextColor: TColor;
    FFontColor: TColor;
    FSelTextFontColor: TColor;

    FHotBorder: TColor;
    FDownBorder: TColor;

    FPasswordText: string;
    FShowPasswordText: Boolean;
    FSelectText: Boolean;
    FPaste: Boolean;
    FDrawBkgrnd: Boolean;
    FDrawBorder: Boolean;
    FPasswordChar: Char;
    FInValue: TInValue;

    FBorderCurrColor: TColor;

    FAlignment: TAlignment;
    function GetText: WideString;
    function GetSelText: WideString;
    procedure SetViewPos(const Value: Integer);
    procedure SetText(const Value: WideString);
    procedure SetSelText(const Value: WideString);
    procedure SetSelIndex(const Value: Integer);
    procedure DrawText(dsurface: TTexture; const vRect: TRect);
    procedure DrawSelector(dsurface: TTexture; const vRect: TRect);


    function CharRect(Index: Integer): TRect;
    function NeedToScroll(): Boolean;
    procedure ScrollToRight(Index: Integer);
    procedure ScrollToLeft(Index: Integer);
    procedure SelectChar(const MousePos: TPoint);
    procedure StripWrong(var Text: string);
    procedure SetMaxLength(const Value: Integer);

    procedure SetSelLength(const Value: Integer);
    function GetSelLength: Integer;

    procedure EnterKey(var Key: Word);
  protected

  public
    constructor Create(AOwner: TComponent); override;
    function InRange(X, Y: Integer): Boolean; override;
    procedure DirectPaint(dsurface: TTexture); override;
    procedure Process; override;

    procedure Paint; override;

    function KeyPress(var Key: Char): Boolean; override;
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean; override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    procedure SelectAll;
    procedure DeleteText;
    procedure CopyText;
    procedure CutText;
    procedure PasteText;
    property ViewPos: Integer read FViewPos write SetViewPos;
    property SelStart: Integer read FSelIndex write SetSelIndex;
    property SelLength: Integer read GetSelLength write SetSelLength;
  published
    property Text: WideString read FText write SetText;
    property SelText: WideString read FSelText write SetSelText;

    property TextAdjust: Integer read FTextAdjust write FTextAdjust;
    property SelIndex: Integer read FSelIndex write SetSelIndex;

    property BlinkTicks: Integer read FBlinkTicks write FBlinkTicks;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property MaxLength: Integer read FMaxLength write SetMaxLength;
    property DisabledColor: TColor read FDisabledColor write FDisabledColor;
    property BkgrndColor: TColor read FBkgrndColor write FBkgrndColor;
    property SelectedColor: TColor read FSelectedColor write FSelectedColor;
    property BorderColor: TColor read FBorderColor write FBorderColor;
    property SelTextColor: TColor read FSelTextColor write FSelTextColor;
    property FontColor: TColor read FFontColor write FFontColor;
    property SelTextFontColor: TColor read FSelTextFontColor write FSelTextFontColor;
    property HotBorderColor: TColor read FHotBorder write FHotBorder;
    property DownBorderColor: TColor read FDownBorder write FDownBorder;

    property PasswordChar: Char read FPasswordChar write FPasswordChar;
    property DrawBackground: Boolean read FDrawBkgrnd write FDrawBkgrnd;
    property DrawBorder: Boolean read FDrawBorder write FDrawBorder;
    property AllowSelectText: Boolean read FSelectText write FSelectText;
    property Paste: Boolean read FPaste write FPaste;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property MainMenu: TDPopupMenu read FMainMenu write FMainMenu;
    property InValue: TInValue read FInValue write FInValue;
  end;

  TDCombobox = class(TDControl)
  private
    FItems: TStrings;
    FClickSound: TClickSound;
    FOnClick: TOnClickEx;
    FOnClickSound: TOnClickSound;
    FOnChange: TNotifyEvent;
    FOnPopup: TNotifyEvent;
    FAutoSize: Boolean;

    FCurrColor: TColor;
    FUpColor: TColor;
    FHotColor: TColor;
    FDownColor: TColor;

    FButtonColor: TColor;

    FBackground: Boolean;
    FBackgroundColor: TColor;
    FBorder: Boolean;
    FBorderColor: TColor;
    FHotBorder: TColor;
    FDownBorder: TColor;
    FMainMenu: TDPopupMenu;

    FBorderCurrColor: TColor;

    FAlignment: TAlignment;

    procedure CaptionChaged; override;
    procedure SetUpColor(Value: TColor);
    procedure SetItems(Value: TStrings);
    function GetItems: TStrings;

    procedure SetItemIndex(Value: Integer);
    function GetItemIndex: Integer;
    procedure MainMenuClick(Sender: TObject; X, Y: Integer);
    procedure SetAlignment(Value: TAlignment);
    procedure ItemChanged(Sender: TObject);
  protected
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function InRange(X, Y: Integer): Boolean; override;
    procedure DirectPaint(dsurface: TTexture); override;
    procedure Process; override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment;
    property Items: TStrings read GetItems write SetItems;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;

    property AutoSize: Boolean read FAutoSize write FAutoSize;
    property UpColor: TColor read FUpColor write SetUpColor;
    property HotColor: TColor read FHotColor write FHotColor;
    property DownColor: TColor read FDownColor write FDownColor;
    property BackgroundColor: TColor read FBackgroundColor write FBackgroundColor;
    property BorderColor: TColor read FBorderColor write FBorderColor;

    property HotBorderColor: TColor read FHotBorder write FHotBorder;
    property DownBorderColor: TColor read FDownBorder write FDownBorder;

    property DrawBackground: Boolean read FBackground write FBackground;
    property Border: Boolean read FBorder write FBorder;
    property ButtonColor: TColor read FButtonColor write FButtonColor;

    property ClickCount: TClickSound read FClickSound write FClickSound;
    property OnClick: TOnClickEx read FOnClick write FOnClick;
    property OnClickSound: TOnClickSound read FOnClickSound write FOnClickSound;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnPopup: TNotifyEvent read FOnPopup write FOnPopup;
    property MainMenu: TDPopupMenu read FMainMenu write FMainMenu;
    property Text: string read FCaption write FCaption;
  end;

  TDCheckBox = class(TDButton)
  private
    FUpColor: TColor;
    FHotColor: TColor;
    FDownColor: TColor;
    procedure SetAlignment(Value: TAlignment);
    procedure CaptionChaged; override;
  public
    constructor Create(AOwner: TComponent); override;
    function InRange(X, Y: Integer): Boolean; override;
    procedure SetImgIndex(Lib: TGameImages; Index: Integer); override;
    procedure DirectPaint(dsurface: TTexture); override;
    procedure Process; override;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment;
    property Checked: Boolean read FDowned write FDowned;
    property UpColor: TColor read FUpColor write FUpColor;
    property HotColor: TColor read FHotColor write FHotColor;
    property DownColor: TColor read FDownColor write FDownColor;
  end;

  TLines = class(TStringList)
  private
    FTop: Integer;
    FLeft: Integer;
    FWidth: Integer;
    FHeight: Integer;
    FItemSize: Integer;
    FData: Pointer;
    FVisible: Boolean;
    function GetText: string;

  public
    constructor Create;
    destructor Destroy; override;
    function Add(const S: string): Integer; override;
    function AddObject(const S: string; AObject: TObject): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    function GetHeight: Integer;
    property Left: Integer read FLeft write FLeft;
    property Top: Integer read FTop write FTop;
    property Width: Integer read FWidth {write FWidth};
    property Height: Integer read FHeight write FHeight;
    property ItemSize: Integer read FItemSize;
    property Text: string read GetText;
    property Data: Pointer read FData write FData;
    property Visible: Boolean read FVisible write FVisible;
  end;

  TDPageControl = class(TDWindow)
  private

    FActivePage: Integer;
    FTabRect: TRect;

    procedure SetActivePage(Value: Integer);

    procedure SetTabLeft(Value: Integer);
    function GetTabLeft: Integer;

    function GetTabTop: Integer;
    procedure SetTabTop(Value: Integer);

    function GetTabWidth: Integer;
    procedure SetTabWidth(Value: Integer);

    function GetTabHeight: Integer;
    procedure SetTabHeight(Value: Integer);
  protected

  public
    Tabs: TList;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Add(D: TDControl);
    procedure Delete(D: TDControl);
  published
    property ActivePage: Integer read FActivePage write SetActivePage;
    property TabLeft: Integer read GetTabLeft write SetTabLeft;
    property TabTop: Integer read GetTabTop write SetTabTop;
    property TabWidth: Integer read GetTabWidth write SetTabWidth;
    property TabHeight: Integer read GetTabHeight write SetTabHeight;
  end;

  TDScroll = class(TDControl)
  private
    FLeft: TDButton;
    FRight: TDButton;
    FCenter: TDButton;
    FAutoScroll: Boolean;
    FDControl: TDControl;

    FColors: TColors;
    FIncrement: Integer;
    FMax: Integer;
    FMin: Integer;
    FPosition: Integer;
    FScrollValue: Integer;

     
    FBorder: Boolean;
    FBackground: Boolean;
    FScroll: Boolean;

    FOnScroll: TOnScroll;
    function GetLeftButton: TDButton;
    function GetRightButton: TDButton;
    function GetCenterButton: TDButton;
    procedure LeftOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure RightOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure CenterOnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure CenterOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CenterOnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LeftOnClickEx(Sender: TObject; X, Y: Integer);
    procedure RightOnClickEx(Sender: TObject; X, Y: Integer);
    procedure SetDControl(D: TDControl);
    procedure SetColors(Value: TColors);
    procedure SetPosition(Value: Integer);
    procedure SetMax(Value: Integer);
    procedure SetMin(Value: Integer);
  protected

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function MouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean; override;
    function InRange(X, Y: Integer): Boolean; override;
    procedure Process; override;
    procedure DirectPaint(dsurface: TTexture); override;
    procedure Next;
    procedure Previous;
    procedure First;
    procedure Last;
    property LeftButton: TDButton read GetLeftButton;
    property RightButton: TDButton read GetRightButton;
    property CenterButton: TDButton read GetCenterButton;

  published
    property VisibleScroll: Boolean read FScroll write FScroll;
    property DrawBackground: Boolean read FBackground write FBackground;
    property Border: Boolean read FBorder write FBorder;
    property DControl: TDControl read FDControl write SetDControl;
    property Colors: TColors read FColors write SetColors;
    property Increment: Integer read FIncrement write FIncrement;
    property Position: Integer read FPosition write SetPosition;
    property Max: Integer read FMax write SetMax;
    property Min: Integer read FMin write SetMin;
    property OnScroll: TOnScroll read FOnScroll write FOnScroll;
  end;




  TDMemo = class(TDControl)
  private
    FLines: TList;
    FBackSurface: TTexture;
    FClickSound: TClickSound;
    FOnClick: TOnClickEx;
    FOnClickSound: TOnClickSound;

    FBackground: Boolean;
    FBorder: Boolean;

    FMainMenu: TDPopupMenu;

    FCenterY: Integer;
    FItemIndex: Integer;
    FDrawItemIndex: Integer;


    FColors: TColors;
    FRowSelect: Boolean;

    FMaxHeight: Integer;
    FMaxWidth: Integer;
    FItemSize: Integer;
    FSpareSize: Integer;
    function GetCount: Integer;
    function GetItems(Index: Integer): TStringList;
    procedure SetItemIndex(Value: Integer);
    procedure SetColors(Value: TColors);

    function GetText: string;
    procedure SetText(Value: string);
    function GetStrings(Index: Integer): string;
    function GetMaxLineHeight: Integer;
    procedure SetMaxLineHeight(Value: Integer);
    procedure OnScroll(Sender: TObject; Increment: Integer); override;
    procedure GetItemIndex(Y: Integer);

    procedure RefPostion(ALeft, ATop: Integer);
    procedure RefSize(AWidth, AHeight: Integer);
  protected

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    function InRange(X, Y: Integer): Boolean; override;
    procedure Process; override;
    procedure DirectPaint(dsurface: TTexture); override;

    function KeyDown(var Key: Word; Shift: TShiftState): Boolean;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;

    function Add: TStringList;

    function AddSuItem(SubItems: TStringList; DControl: TDControl): TDControl; //overload;

    procedure Delete(Index: Integer);
    procedure Clear;
    procedure RefreshPos;
    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);

    property Items[Index: Integer]: TStringList read GetItems;
    property Strings[Index: Integer]: string read GetStrings;


    property Count: Integer read GetCount;

    property Text: string read GetText write SetText;
    property MaxHeight: Integer read GetMaxLineHeight write SetMaxLineHeight;
    property MaxWidth: Integer read FMaxWidth write FMaxWidth;
    property ItemSize: Integer read FItemSize write FItemSize;
    property SpareSize: Integer read FSpareSize write FSpareSize;
  published
    property RowSelect: Boolean read FRowSelect write FRowSelect;
    property Colors: TColors read FColors write SetColors;
    property ItemIndex: Integer read FItemIndex write FItemIndex;

    property DrawBackground: Boolean read FBackground write FBackground;
    property Border: Boolean read FBorder write FBorder;

    property ClickCount: TClickSound read FClickSound write FClickSound;
    property OnClick: TOnClickEx read FOnClick write FOnClick;
    property OnClickSound: TOnClickSound read FOnClickSound write FOnClickSound;
    property MainMenu: TDPopupMenu read FMainMenu write FMainMenu;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
  end;

  TViewItem = record
    Caption: string;
    Data: Pointer;
    Style: TButtonStyle;
    Checked: Boolean;
    //Color: TDxCaptionColor;
    //ImageIndex: TDxImageIndex;
    Down, Move: Boolean;
    Transparent: Boolean;
    Image: TGameImages;
    TimeTick: LongWord;
  end;
  pTViewItem = ^TViewItem;

  TDCharMemo = class(TDControl)

  end;

  TDWinManager = class
  private
  public
    DWinList: TList; //list of TDControl;
    constructor Create;
    destructor Destroy; override;
    procedure AddDControl(dcon: TDControl; Visible: Boolean);
    procedure DelDControl(dcon: TDControl);
    procedure ClearAll;
    procedure Process;
    function KeyPress(var Key: Char): Boolean;
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
    function MouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
    function MouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;


    function DblClick(X, Y: Integer): Boolean;
    function Click(X, Y: Integer): Boolean;
    procedure DirectPaint(dsurface: TTexture);
  end;

procedure Register;
procedure SetDFocus(dcon: TDControl);
procedure ReleaseDFocus;
procedure SetDCapture(dcon: TDControl);
procedure ReleaseDCapture;


function ShortRect(const Rect1, Rect2: TRect): TRect;
function MoveRect(const Rect: TRect; const Point: TPoint): TRect;
//---------------------------------------------------------------------------
function PointInRect(const Point: TPoint; const Rect: TRect): Boolean;
//---------------------------------------------------------------------------
function RectInRect(const Rect1, Rect2: TRect): Boolean;
function ShrinkRect(const Rect: TRect; const hIn, vIn: Integer): TRect;
procedure ChgNumber(var No1, No2: Integer);


var
  LabelClickTimeTick: LongWord;
  MouseCaptureControl: TDControl; //mouse message
  FocusedControl: TDControl; //Key message
  MainWinHandle: Integer;
  ModalDWindow: TDControl;
  MouseMoveControl: TDControl;
  MouseDownControl: TDControl;
  ActiveMenu: TDPopupMenu;

  DWinMan: TDWinManager;
implementation

const
  TextChars = [#32..#255];
  BorderStyles: array[TBorderStyle] of Dword = (0, WS_BORDER);

procedure Register;
begin
  RegisterComponents('MirGame', [TDControl, TDButton, TDGrid,
    TDWindow, TDPopupMenu, TDLabel, TDEdit, TDCheckBox, TDCombobox,
      TDMemo, TDScroll, TDPageControl]);
end;

procedure ChgNumber(var No1, No2: Integer);
var
  NO3: Integer;
begin
  if No1 > No2 then begin
    NO3 := No2;
    No2 := No1;
    No1 := NO3;
  end;
end;
//---------------------------------------------------------------------------

function ShrinkRect(const Rect: TRect; const hIn, vIn: Integer): TRect;
begin
  Result.Left := Rect.Left + hIn;
  Result.Top := Rect.Top + vIn;
  Result.Right := Rect.Right - hIn;
  Result.Bottom := Rect.Bottom - vIn;
end;
//---------------------------------------------------------------------------

function PointInRect(const Point: TPoint; const Rect: TRect): Boolean;
begin
  Result := (Point.X >= Rect.Left) and (Point.X <= Rect.Right) and
    (Point.Y >= Rect.Top) and (Point.Y <= Rect.Bottom);
end;

//---------------------------------------------------------------------------

function RectInRect(const Rect1, Rect2: TRect): Boolean;
begin
  Result := (Rect1.Left >= Rect2.Left) and (Rect1.Right <= Rect2.Right) and
    (Rect1.Top >= Rect2.Top) and (Rect1.Bottom <= Rect2.Bottom);
end;
//---------------------------------------------------------------------------

function ShortRect(const Rect1, Rect2: TRect): TRect;
begin
  Result.Left := Max(Rect1.Left, Rect2.Left);
  Result.Top := Max(Rect1.Top, Rect2.Top);
  Result.Right := Min(Rect1.Right, Rect2.Right);
  Result.Bottom := Min(Rect1.Bottom, Rect2.Bottom);
end;

//---------------------------------------------------------------------------

function MoveRect(const Rect: TRect; const Point: TPoint): TRect;
begin
  Result.Left := Rect.Left + Point.X;
  Result.Top := Rect.Top + Point.Y;
  Result.Right := Rect.Right + Point.X;
  Result.Bottom := Rect.Bottom + Point.Y;
end;

procedure SetDFocus(dcon: TDControl);
begin
  FocusedControl := dcon;
end;

procedure ReleaseDFocus;
begin
  FocusedControl := nil;
end;

procedure SetDCapture(dcon: TDControl);
begin
  SetCapture(MainWinHandle);
  MouseCaptureControl := dcon;
end;

procedure ReleaseDCapture;
begin
  ReleaseCapture;
  MouseCaptureControl := nil;
end;


constructor TDCustomControl.Create(AOwner: TComponent);
begin
  inherited Create(aowner);
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csDoubleClicks, csReplicatable, csParentBackground];
  Width := 60;
  Height := 30;
end;

procedure TDCustomControl.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
  Canvas.Font := Font;
  Inc(Rect.Top, Canvas.TextHeight('0'));
  InflateRect(Rect, -1, -1);
  if Ctl3D then InflateRect(Rect, -1, -1);
end;

procedure TDCustomControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params.WindowClass do
    Style := Style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TDCustomControl.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus then
    begin
      SelectFirst;
      Result := 1;
    end else
      inherited;
end;

procedure TDCustomControl.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
  Realign;
end;

procedure TDCustomControl.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
  Realign;
end;

procedure TDCustomControl.WMSize(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

{----------------------------- TDControl -------------------------------}

constructor TDControl.Create(AOwner: TComponent);
begin
  inherited Create(aowner);
  DParent := nil;
  inherited Visible := False;
  FEnableFocus := False;
  Background := False;

  FOnDirectPaint := nil;
  FOnKeyPress := nil;
  FOnKeyDown := nil;
  FOnMouseMove := nil;
  FOnMouseDown := nil;
  FOnMouseUp := nil;
  FOnInRealArea := nil;
  DControls := TList.Create;
  FDParent := nil;
  FOnProcess := nil;
  Width := 80;
  Height := 24;
  FCaption := '';
  FVisible := True;
   //FaceSurface := nil;
  WLib := nil;
  FaceIndex := 0;
  FDScroll := nil;
  FParentNotify := False;
  FX := 0;
  FY := 0;
  FIdx := -1;
  FString := '';
  FData := nil;
  FKeyPreview := False;
  FFade := False;
  FFadeAlpha := 255;
  FFadeTick := GetTickCount;
end;

destructor TDControl.Destroy;
var
  I: Integer;
  dcon: TDControl;
begin
  if Self = FocusedControl then ReleaseDFocus;
  if Self = MouseCaptureControl then ReleaseDCapture;
  if Self = ModalDWindow then ModalDWindow := nil;
  if Self = MouseMoveControl then MouseMoveControl := nil;
  if Self = MouseDownControl then MouseDownControl := nil;
  if DParent <> nil then
    for I := DParent.DControls.Count - 1 downto 0 do begin
      dcon := TDControl(DParent.DControls.Items[I]);
      if dcon = Self then begin
        DParent.DControls.Delete(I);
        Break;
      end;
    end;
  DControls.Free;
  inherited Destroy;
end;

function TDControl.GetMouseMove: Boolean;
begin
  Result := MouseMoveControl = Self;
end;

function TDControl.GetClientRect: TRect;
begin
  Result.Left := SurfaceX(Left);
  Result.Top := SurfaceY(Top);
  Result.Right := Result.Left + Width;
  Result.Bottom := Result.Top + Height;
end;

function TDControl.GetFirstDParent: TDControl;
var
  d: TDControl;
begin
  Result := nil;
  d := Self;
  while True do begin
    if (d <> nil) and (d.DParent <> nil) and (not d.DParent.Background) then begin
      d := d.DParent;
    end else break;
  end;
  Result := d;
end;

procedure TDControl.SetCaption(Str: string);
begin
  FCaption := Str;
  if csDesigning in ComponentState then begin
    Refresh;
  end else CaptionChaged;
end;

procedure TDControl.CaptionChaged;
begin

end;

procedure TDControl.Paint;
begin
  if csDesigning in ComponentState then begin
    if Self is TDWindow then begin
      if TDWindow(Self).DPageControl = nil then begin
        with Canvas do begin
          Pen.Color := clBlack;
          MoveTo(0, 0);
          LineTo(Width - 1, 0);
          LineTo(Width - 1, Height - 1);
          LineTo(0, Height - 1);
          LineTo(0, 0);
          LineTo(Width - 1, Height - 1);
          MoveTo(Width - 1, 0);
          LineTo(0, Height - 1);
          TextOut((Width - TextWidth(Caption)) div 2, (Height - TextHeight(Caption)) div 2, Caption);
        end;
      end else begin
        if Visible then begin
          with Canvas do begin
            Pen.Color := clBlack;
            MoveTo(0, 0);
            LineTo(Width - 1, 0);
            LineTo(Width - 1, Height - 1);
            LineTo(0, Height - 1);
            LineTo(0, 0);
            LineTo(Width - 1, Height - 1);
            MoveTo(Width - 1, 0);
            LineTo(0, Height - 1);
            TextOut((Width - TextWidth(Caption)) div 2, (Height - TextHeight(Caption)) div 2, Caption);
          end;
        end;
      end;
    end else begin
      with Canvas do begin
        Pen.Color := clBlack;
        MoveTo(0, 0);
        LineTo(Width - 1, 0);
        LineTo(Width - 1, Height - 1);
        LineTo(0, Height - 1);
        LineTo(0, 0);
        TextOut((Width - TextWidth(Caption)) div 2, (Height - TextHeight(Caption)) div 2, Caption);
      end;
    end;
  end;
end;

procedure TDControl.Loaded;
var
  I: Integer;
  dcon: TDControl;
begin
  if not (csDesigning in ComponentState) then begin
    if Parent <> nil then
      for I := 0 to TControl(Parent).ComponentCount - 1 do begin
        if TControl(Parent).Components[I] is TDControl then begin
          dcon := TDControl(TControl(Parent).Components[I]);
          if dcon.DParent = Self then begin
            AddChild(dcon);
          end;
        end;
      end;
  end;
end;

function TDControl.SurfaceX(X: Integer): Integer;
var
  d: TDControl;
begin
  d := Self;
  while True do begin
    if d.DParent = nil then Break;
    X := X + d.DParent.Left;
    d := d.DParent;
  end;
  Result := X;
end;

function TDControl.SurfaceY(Y: Integer): Integer;
var
  d: TDControl;
begin
  d := Self;
  while True do begin
    if d.DParent = nil then Break;
    Y := Y + d.DParent.Top;
    d := d.DParent;
  end;
  Result := Y;
end;


function TDControl.LocalX(X: Integer): Integer;
var
  d: TDControl;
begin
  d := Self;
  while True do begin
    if d.DParent = nil then Break;
    X := X - d.DParent.Left;
    d := d.DParent;
  end;
  Result := X;
end;

function TDControl.LocalY(Y: Integer): Integer;
var
  d: TDControl;
begin
  d := Self;
  while True do begin
    if d.DParent = nil then Break;
    Y := Y - d.DParent.Top;
    d := d.DParent;
  end;
  Result := Y;
end;

procedure TDControl.UnLoaded;
var
  I: Integer;
  dcon: TDControl;
begin
  if DParent <> nil then
    for I := DParent.DControls.Count - 1 downto 0 do begin
      dcon := TDControl(DParent.DControls.Items[I]);
      if dcon = Self then begin
        DParent.DControls.Delete(I);
      end;
    end;
 { if Parent <> nil then
    Parent.RemoveControl(Self);
  Parent := nil;    }
end;

procedure TDControl.OnScroll(Sender: TObject; Increment: Integer);
begin

end;

procedure TDControl.SetDScroll(Value: TDScroll);
begin
  if FDScroll <> Value then FDScroll := Value;
  if FDScroll <> nil then FDScroll.OnScroll := OnScroll;
end;

procedure TDControl.DoShow;
begin

end;

procedure TDControl.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then begin
    FVisible := Value;
    if FVisible then begin
      SetFocus;
    end else begin
      ReleaseFocus;
    end;
    DoShow;
  end;
end;

procedure TDControl.ReleaseFocus;
var
  I: Integer;
begin
  if Self = FocusedControl then ReleaseDFocus;
  if Self = MouseCaptureControl then ReleaseDCapture;
  if Self = ModalDWindow then ModalDWindow := nil;
  if Self = MouseMoveControl then MouseMoveControl := nil;
  if Self = MouseDownControl then MouseDownControl := nil;
  for I := 0 to DControls.Count - 1 do begin
    TDControl(DControls[I]).ReleaseFocus;
  end;
end;

procedure TDControl.SetDParent(Value: TDControl);
var
  I: Integer;
begin
  Parent := Value;
  if Value <> FDParent then begin
    if FDParent <> nil then UnLoaded;
    FDParent := Value;
    if FDParent <> nil then begin
      //SetCanvas(FDParent.Canvas);
      for I := 0 to FDParent.DControls.Count - 1 do
        if Self = FDParent.DControls[I] then Exit;
      FDParent.DControls.Add(Self);

    end;
  end;
end;

procedure TDControl.SetDowned(Value: Boolean);
var
  I: Integer;
  d: TDControl;
begin
  if not (csDesigning in ComponentState) then begin
    if Self is TDButton then begin
      case TDButton(Self).Style of
        bsBase: begin
            FDowned := Value;
          end;
        bsRadio: begin
            if Value and not FDowned then begin
              if (FDParent <> nil) then begin
                for I := 0 to FDParent.DControls.Count - 1 do begin
                  d := TDControl(FDParent.DControls[I]);
                  if (d <> Self) and (d is TDButton) and (TDButton(d).Style = bsRadio) then begin
                    TDButton(d).Downed := False;
                  end;
                end;
              end;
            end;
            FDowned := Value;
          end;
        bsLock: begin
            FDowned := Value;
          end;
      end;
    end else
      if Self is TDLabel then begin
      case TDLabel(Self).Style of
        bsBase: begin
            FDowned := Value;
          end;
        bsRadio: begin
            if Value and not FDowned then begin
              if (FDParent <> nil) then begin
                for I := 0 to FDParent.DControls.Count - 1 do begin
                  d := TDControl(FDParent.DControls[I]);
                  if (d <> Self) and (d is TDLabel) and (TDLabel(d).Style = bsRadio) then begin
                    TDLabel(d).Downed := False;
                  end;
                end;
              end;
            end;
            FDowned := Value;
          end;
        bsLock: begin
            FDowned := Value;
          end;
      end;
    end else begin
      FDowned := Value;
    end;
  end else FDowned := Value;
end;

procedure TDControl.SetFocus;
var
  I: Integer;
begin
  if EnableFocus and Visible then SetDFocus(Self);
  if (FocusedControl = nil) and Visible then begin
    for I := 0 to DControls.Count - 1 do begin
      if (FocusedControl = nil) then
        TDControl(DControls[I]).SetFocus
      else break;
    end;
  end;
end;

procedure TDControl.AddChild(dcon: TDControl);
var
  I: Integer;
begin
  for I := 0 to DControls.Count - 1 do
    if TDControl(DControls[I]) = dcon then Exit;
  DControls.Add(Pointer(dcon));
end;

procedure TDControl.ChangeChildOrder(dcon: TDControl);
var
  I: Integer;
begin
  if not ((Self is TDWindow) or (Self is TDPageControl)) then Exit;
  if TDWindow(dcon).Floating then begin
    for I := 0 to DControls.Count - 1 do begin
      if dcon = DControls[I] then begin
        DControls.Delete(I);
        Break;
      end;
    end;
    DControls.Add(dcon);
  end;
end;

procedure TDControl.BringToFront;
var
  I: Integer;
begin
  if not ((Self is TDWindow) or (Self is TDPageControl)) then Exit;
  if DParent <> nil then begin
    for I := 0 to DParent.DControls.Count - 1 do begin
      if Self = DParent.DControls[I] then begin
        DParent.DControls.Delete(I);
        Break;
      end;
    end;
    DParent.DControls.Add(Self);
  end;
end;

procedure DebugOutStr(Msg: string);
var
  flname: string;
  fhandle: TextFile;
begin
//DScreen.AddChatBoardString(msg,clWhite, clBlack);
  //exit;
  flname := '.\DebugOutStr.txt';
  if FileExists(flname) then begin
    AssignFile(fhandle, flname);
    Append(fhandle);
  end else begin
    AssignFile(fhandle, flname);
    Rewrite(fhandle);
  end;
  Writeln(fhandle, TimeToStr(Time) + ' ' + Msg);
  CloseFile(fhandle);
end;

function TDControl.InRange(X, Y: Integer): Boolean;
var
  boInrange: Boolean;
  d: TTexture;
begin
  if (X >= Left) and (X < Left + Width) and (Y >= Top) and (Y < Top + Height) then begin
    boInrange := True;

    if Assigned(FOnInRealArea) then begin
      FOnInRealArea(Self, X - Left, Y - Top, boInrange);
    end else begin
      if WLib <> nil then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then begin
          if d.Pixels[X - Left, Y - Top] = 0 then
            boInrange := False;
        end;
      end;
    end;
    Result := boInrange;
  end else Result := False;
end;

function TDControl.KeyPress(var Key: Char): Boolean;
var
  I: Integer;
  d: TDControl;
begin
  Result := False;
  if Background then Exit;
  for I := DControls.Count - 1 downto 0 do
    if TDControl(DControls[I]).Visible and TDControl(DControls[I]).Enabled then
      if TDControl(DControls[I]).KeyPress(Key) then begin
        Result := True;
        Exit;
      end;
  if (FocusedControl = Self) then begin
    if Assigned(FOnKeyPress) then FOnKeyPress(Self, Key);
    Result := True;
  end;
  d := FirstDParent;
  if (d <> nil) and (d <> Self) and (FocusedControl <> d) and d.KeyPreview then
    if Assigned(d.OnKeyPress) then d.OnKeyPress(d, Key);
end;

function TDControl.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
var
  I: Integer;
  d: TDControl;
begin
  Result := False;
  if Background then Exit;

  for I := DControls.Count - 1 downto 0 do
    if TDControl(DControls[I]).Visible and TDControl(DControls[I]).Enabled then
      if TDControl(DControls[I]).KeyDown(Key, Shift) then begin
        Result := True;
        Exit;
      end;

  if (FocusedControl = Self) then begin
    if Assigned(FOnKeyDown) then FOnKeyDown(Self, Key, Shift);
    Result := True;
  end;

  d := FirstDParent;
  if (d <> nil) and (d <> Self) and (FocusedControl <> d) and d.KeyPreview then
    if Assigned(d.OnKeyDown) then d.OnKeyDown(d, Key, Shift);
end;

function TDControl.CanFocusMsg: Boolean;
begin
  if (MouseCaptureControl = nil) or ((MouseCaptureControl <> nil) and ((MouseCaptureControl = Self) {or (MouseCaptureControl = DParent){ or (MouseCaptureControl.ParentNotify)})) then
    Result := True
  else
    Result := False;
end;

function TDControl.MouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
var
  I: Integer;
  Handled: Boolean;
begin
  Result := False;
  for I := DControls.Count - 1 downto 0 do
    if TDControl(DControls[I]).Visible and TDControl(DControls[I]).Enabled then
      if TDControl(DControls[I]).MouseWheelDown(Shift, MousePos) then begin
        Result := True;
        Exit;
      end;

  if (MouseCaptureControl <> nil) then begin
    if (MouseCaptureControl = Self) then begin
      if Assigned(OnMouseWheelDown) then
        OnMouseWheelDown(Self, Shift, MousePos, Handled);
      Result := True;
    end;
    Exit;
  end;
end;

function TDControl.MouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
var
  I: Integer;
  Handled: Boolean;
begin
  Result := False;
  for I := DControls.Count - 1 downto 0 do
    if TDControl(DControls[I]).Visible and TDControl(DControls[I]).Enabled then
      if TDControl(DControls[I]).MouseWheelUp(Shift, MousePos) then begin
        Result := True;
        Exit;
      end;

  if (MouseCaptureControl <> nil) then begin
    if (MouseCaptureControl = Self) then begin
      if Assigned(OnMouseWheelUp) then
        OnMouseWheelUp(Self, Shift, MousePos, Handled);
      Result := True;
    end;
    Exit;
  end;
end;


function TDControl.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := DControls.Count - 1 downto 0 do
    if TDControl(DControls[I]).Visible and TDControl(DControls[I]).Enabled then
      if TDControl(DControls[I]).MouseMove(Shift, X - Left, Y - Top) then begin
        Result := True;
        Exit;
      end;

  if (MouseCaptureControl <> nil) then begin
    if (MouseCaptureControl = Self) then begin
      if Assigned(FOnMouseMove) then
        FOnMouseMove(Self, Shift, X, Y);
      Result := True;
    end;
    Exit;
  end;

  if Background then Exit;

  if InRange(X, Y) then begin
    MouseMoveControl := Self;
    if Assigned(FOnMouseMove) then
      FOnMouseMove(Self, Shift, X, Y);
    Result := True;
  end;
end;

function TDControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := DControls.Count - 1 downto 0 do
    if TDControl(DControls[I]).Visible and TDControl(DControls[I]).Enabled then
      if TDControl(DControls[I]).MouseDown(Button, Shift, X - Left, Y - Top) then begin
        Result := True;
        Exit;
      end;
  if Background then begin
    if Assigned(FOnBackgroundClick) then begin
      WantReturn := False;
      FOnBackgroundClick(Self);
      if WantReturn then Result := True;
    end;
    ReleaseDFocus;
    Exit;
  end;
  if CanFocusMsg then begin
    if InRange(X, Y) or (MouseCaptureControl = Self) then begin
      //DebugOutStr(Name+' TDControl.MouseDown '+Caption);
      MouseMoveControl := nil;
      MouseDownControl := Self;
      if Assigned(FOnMouseDown) then
        FOnMouseDown(Self, Button, Shift, X, Y);
      if EnableFocus then SetDFocus(Self);
         //else ReleaseDFocus;
      Result := True;
    end;
  end;
end;

function TDControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := DControls.Count - 1 downto 0 do
    if TDControl(DControls[I]).Visible and TDControl(DControls[I]).Enabled then
      if TDControl(DControls[I]).MouseUp(Button, Shift, X - Left, Y - Top) then begin
        Result := True;
        Exit;
      end;

  if (MouseCaptureControl <> nil) then begin
    if (MouseCaptureControl = Self) then begin
      if Assigned(FOnMouseUp) then
        FOnMouseUp(Self, Button, Shift, X, Y);
      Result := True;
    end;
    Exit;
  end;

  if Background then Exit;
  if InRange(X, Y) then begin
    if Assigned(FOnMouseUp) then
      FOnMouseUp(Self, Button, Shift, X, Y);
    Result := True;
  end;
end;

function TDControl.DblClick(X, Y: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if (MouseCaptureControl <> nil) then begin
    if (MouseCaptureControl = Self) then begin
      if Assigned(FOnDblClick) then
        FOnDblClick(Self);
      Result := True;
    end;
    Exit;
  end;
  for I := DControls.Count - 1 downto 0 do
    if TDControl(DControls[I]).Visible and TDControl(DControls[I]).Enabled then
      if TDControl(DControls[I]).DblClick(X - Left, Y - Top) then begin
        Result := True;
        Exit;
      end;
  if Background then Exit;
  if InRange(X, Y) then begin
    if Assigned(FOnDblClick) then
      FOnDblClick(Self);
    Result := True;
  end;
end;

function TDControl.Click(X, Y: Integer): Boolean;
var
  I, nY: Integer;
begin
  Result := False;
  nY := 0;
  if FDScroll <> nil then nY := FDScroll.Position;
  if (MouseCaptureControl <> nil) then begin
    if (MouseCaptureControl = Self) then begin
      if Assigned(FOnClick) then
        FOnClick(Self, X, Y);
      Result := True;
    end;
    Exit;
  end;
  for I := DControls.Count - 1 downto 0 do
    if TDControl(DControls[I]).Visible and TDControl(DControls[I]).Enabled then
      if TDControl(DControls[I]).Click(X - Left, Y - Top + nY) then begin
        Result := True;
        Exit;
      end;
  if Background then Exit;
  if InRange(X, Y) then begin
    if Assigned(FOnClick) then
      FOnClick(Self, X, Y);
    Result := True;
  end;
end;

procedure TDControl.SetImgIndex(Lib: TGameImages; Index: Integer);
var
  d: TTexture;
begin
   //FaceSurface := dsurface;
  if Lib <> nil then begin
    d := Lib.Images[Index];
    WLib := Lib;
    FaceIndex := Index;
    if d <> nil then begin
      Width := d.Width;
      Height := d.Height;
    end;
  end;
end;

procedure TDControl.Process;
var
  I: Integer;
begin
  if Assigned(FOnProcess) then FOnProcess(Self);
  for I := 0 to DControls.Count - 1 do
    if TDControl(DControls[I]).Visible then
      TDControl(DControls[I]).Process;
end;

procedure TDControl.DirectPaint(dsurface: TTexture);
var
  I: Integer;
  d: TTexture;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(Self, dsurface)
  else
    if WLib <> nil then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
  end;
  for I := 0 to DControls.Count - 1 do
    if TDControl(DControls[I]).Visible then
      TDControl(DControls[I]).DirectPaint(dsurface);
end;


{--------------------- TDButton --------------------------}


constructor TDButton.Create(AOwner: TComponent);
begin
  inherited Create(aowner);
  FDowned := False;
  FOnClick := nil;
  FEnableFocus := False;
  FClickSound := csNone;
  FButtonStyle := bsBase;
  FAlignment := taCenter;
  FShowCaption := False;
  FColors := TColors.Create;
end;

destructor TDButton.Destroy;
begin
  FColors.Free;
  inherited Destroy;
end;

procedure TDButton.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then begin
    FAlignment := Value;
  end;
end;

function TDButton.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if (not Background) and (not Result) then begin
    //Result := inherited MouseMove(Shift, X, Y);
    case FButtonStyle of
      bsBase: begin
          if MouseCaptureControl = Self then
            if InRange(X, Y) then Downed := True
            else Downed := False;
        end;
      bsRadio: begin

        end;
      bsLock: begin

        end;
    end;

  end;
end;

function TDButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := False;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl = nil) { or ((MouseCaptureControl <> nil) and MouseCaptureControl.ParentNotify))} then begin
      case FButtonStyle of
        bsBase: begin
            Downed := True;
          end;
        bsRadio: begin

          end;
        bsLock: begin

          end;
      end;
      SetDCapture(Self);
    end;
    Result := True;
  end;
end;

function TDButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  I: Integer;
  d: TDControl;
  boDown: Boolean;
begin
  Result := False;
  ReleaseDCapture;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    if not Background then begin
      if InRange(X, Y) then begin
        case FButtonStyle of
          bsBase: begin
              Downed := False;
              if Assigned(FOnClickSound) then FOnClickSound(Self, FClickSound);
              if Assigned(FOnClick) then FOnClick(Self, X, Y);
            end;
          bsRadio: begin
              boDown := Downed;
              if (FDParent <> nil) then begin
                for I := 0 to FDParent.DControls.Count - 1 do begin
                  d := TDControl(FDParent.DControls[I]);
                  if (d <> Self) and (d is TDButton) and (TDButton(d).Style = bsRadio) then begin
                    TDButton(d).Downed := False;
                  end;
                end;
              end;

              Downed := True;

              if not boDown then begin
                if Assigned(FOnClickSound) then FOnClickSound(Self, FClickSound);
                if Assigned(FOnClick) then FOnClick(Self, X, Y);
              end;

            end;
          bsLock: begin
              Downed := not Downed;
              if Assigned(FOnClickSound) then FOnClickSound(Self, FClickSound);
              if Assigned(FOnClick) then FOnClick(Self, X, Y);
            end;
        end;
      end;
    end;
    case FButtonStyle of
      bsBase: begin
          Downed := False;
        end;
      bsRadio: begin

        end;
      bsLock: begin

        end;
    end;
    Result := True;
    Exit;
  end else begin
    //ReleaseDCapture;
    case FButtonStyle of
      bsBase: begin
          Downed := False;
        end;
      bsRadio: begin

        end;
      bsLock: begin

        end;
    end;
  end;
end;

procedure TDButton.DirectPaint(dsurface: TTexture);
var
  I, nX: Integer;
  d: TTexture;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(Self, dsurface)
  else
    if WLib <> nil then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
  end;

  if FShowCaption then begin
    if FCaption <> '' then begin
      case FAlignment of
        taLeftJustify: nX := SurfaceX(Left);
        taRightJustify: nX := Max(SurfaceX(Left), SurfaceX(Left + (Width - dsurface.TextWidth(FCaption))));
        taCenter: nX := SurfaceX(Left) + (Width - dsurface.TextWidth(FCaption)) div 2;
      end;
      if Downed then
        dsurface.TextOut(nX,
          SurfaceY(Top) + (Height - dsurface.TextHeight('0')) div 2 + 1, FCaption, Font.Color)
      else
        dsurface.TextOut(nX,
          SurfaceY(Top) + (Height - dsurface.TextHeight('0')) div 2, FCaption, Font.Color);
    end;
  end;

  if Self.FDScroll = nil then begin
    for I := 0 to DControls.Count - 1 do
      if TDControl(DControls[I]).Visible then
        TDControl(DControls[I]).DirectPaint(dsurface);
  end;
end;

procedure TDButton.Process;
var
  I: Integer;
begin
  if Assigned(FOnProcess) then FOnProcess(Self);
  if Downed then begin
    Font.Color := FColors.Down;
  end else
    if MouseMoveing then begin
    Font.Color := FColors.Hot;
  end else begin
    Font.Color := FColors.Up;
  end;
  {if CompareStr(FOldCaption, FCaption) <> 0 then begin
    FOldCaption := FCaption;
    CaptionChaged;
  end; }
  for I := 0 to DControls.Count - 1 do
    if TDControl(DControls[I]).Visible then
      TDControl(DControls[I]).Process;
end;

{------------------------- TDGrid --------------------------}

constructor TDGrid.Create(AOwner: TComponent);
begin
  inherited Create(aowner);
  FColCount := 8;
  FRowCount := 5;
  FColWidth := 36;
  FRowHeight := 32;
  FOnGridSelect := nil;
  FOnGridMouseMove := nil;
  FOnGridPaint := nil;
end;

function TDGrid.InRange(X, Y: Integer): Boolean;
var
  boInrange: Boolean;
  d: TTexture;
begin
  if (X >= Left) and (X < Left + Width) and (Y >= Top) and (Y < Top + Height) then begin
    boInrange := True;
    if Assigned(FOnInRealArea) then
      FOnInRealArea(Self, X - Left, Y - Top, boInrange);
    Result := boInrange;
  end else
    Result := False;
end;

function TDGrid.GetColRow(X, Y: Integer; var ACol, ARow: Integer): Boolean;
begin
  Result := False;
  if InRange(X, Y) then begin
    ACol := (X - Left) div FColWidth;
    ARow := (Y - Top) div FRowHeight;
    Result := True;
  end;
end;

procedure TDGrid.ClearSelect;
begin
  SelectCell.X := -1;
  SelectCell.Y := -1;
end;

function TDGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  ACol, ARow: Integer;
begin
  Result := False;
  if mbLeft = Button then begin
    if GetColRow(X, Y, ACol, ARow) then begin
      SelectCell.X := ACol;
      SelectCell.Y := ARow;
      DownPos.X := X;
      DownPos.Y := Y;
      SetDCapture(Self);
      Result := True;
    end;
  end;
end;

function TDGrid.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
var
  ACol, ARow: Integer;
begin
  Result := False;
  if InRange(X, Y) then begin
    if GetColRow(X, Y, ACol, ARow) then begin
      if Assigned(FOnGridMouseMove) then
        FOnGridMouseMove(Self, ACol, ARow, Shift);
    end;
    Result := True;
  end;
end;

function TDGrid.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  ACol, ARow: Integer;
begin
  Result := False;
  if mbLeft = Button then begin
    if GetColRow(X, Y, ACol, ARow) then begin
      if (SelectCell.X = ACol) and (SelectCell.Y = ARow) then begin
        Col := ACol;
        row := ARow;
        if Assigned(FOnGridSelect) then
          FOnGridSelect(Self, ACol, ARow, Shift);
      end;
      Result := True;
    end;
    ReleaseDCapture;
  end;
end;

function TDGrid.Click(X, Y: Integer): Boolean;
var
  ACol, ARow: Integer;
begin
  Result := False;
  { if GetColRow (X, Y, acol, arow) then begin
      if Assigned (FOnGridSelect) then
         FOnGridSelect (self, acol, arow, []);
      Result := TRUE;
   end; }
end;

procedure TDGrid.DirectPaint(dsurface: TTexture);
var
  I, j: Integer;
  rc: TRect;
begin
  if Assigned(FOnGridPaint) then
    for I := 0 to FRowCount - 1 do
      for j := 0 to FColCount - 1 do begin
        rc := Rect(Left + j * FColWidth, Top + I * FRowHeight, Left + j * (FColWidth + 1) - 1, Top + I * (FRowHeight + 1) - 1);
        if (SelectCell.Y = I) and (SelectCell.X = j) then
          FOnGridPaint(Self, j, I, rc, [gdSelected], dsurface)
        else FOnGridPaint(Self, j, I, rc, [], dsurface);
      end;
end;


{--------------------- TDWindown --------------------------}


constructor TDWindow.Create(AOwner: TComponent);
begin
  inherited Create(aowner);
  FFloating := False;
  FEnableFocus := True;
  Width := 120;
  Height := 120;
  FDPageControl := nil;
end;

procedure TDWindow.DoShow;
begin
  if Visible and Floating and (DParent <> nil) then
    DParent.ChangeChildOrder(Self);
end;

 {
procedure TDWindow.SetVisible(flag: Boolean);
begin
  FVisible := flag;
  if FVisible then begin
    if Floating then begin
      if DParent <> nil then
        DParent.ChangeChildOrder(Self);
    end;
    SetFocus;
  end else begin
    ReleaseFocus;
  end;
end;   }

{procedure TDWindow.SetFocus;
var
  I: Integer;
begin
  if (FocusedControl = nil) and EnableFocus then SetFocus;
  if (FocusedControl = nil) then begin
    for I := 0 to DControls.Count - 1 do begin
      TDControl(DControls[I]).SetFocus;
    end;
  end;
end; }

procedure TDWindow.SetDPageControl(Value: TDPageControl);
begin
  if FDPageControl <> Value then begin
    if FDPageControl <> nil then
      FDPageControl.Delete(Self);
    FDPageControl := Value;
    FDPageControl.Add(Self);
    FDPageControl.ActivePage := FDPageControl.Tabs.Count - 1;
  end;
end;

function TDWindow.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
var
  al, at: Integer;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if Result and FFloating and ((MouseCaptureControl = Self) or ((MouseCaptureControl <> nil) and MouseCaptureControl.ParentNotify)) then begin
    if (SpotX <> X) or (SpotY <> Y) then begin
      al := Left + (X - SpotX);
      at := Top + (Y - SpotY);
      if al + Width < WINLEFT then al := WINLEFT - Width;
      if al > WINRIGHT then al := WINRIGHT;
      if at + Height < WINTOP then at := WINTOP - Height;
      if at + Height > BOTTOMEDGE then at := BOTTOMEDGE - Height;
      Left := al;
      Top := at;
      SpotX := X;
      SpotY := Y;
    end;
  end;
end;

function TDWindow.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := False;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    SpotX := X;
    SpotY := Y;
    BringToFront;
    Result := True;
  end;
end;

{            and ((MouseCaptureControl = nil){ or (MouseCaptureControl.ParentNotify))
begin
  Result := inherited MouseDown(Button, Shift, X, Y);
  if Result then begin
    BringToFront;
    SpotX := X;
    SpotY := Y;
  end;
end;}

function TDWindow.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseUp(Button, Shift, X, Y);
end;

procedure TDWindow.Show;
begin
  Visible := True;
  if Floating then begin
    if DParent <> nil then
      DParent.ChangeChildOrder(Self);
  end;
  //if EnableFocus then SetDFocus(Self);
end;

function TDWindow.ShowModal: Integer;
begin
  Result := 0; //Jacky
  Visible := True;
  ModalDWindow := Self;
  if EnableFocus then SetDFocus(Self);
end;

constructor TDLabel.Create(AOwner: TComponent);
begin
  inherited Create(aowner);
  FAutoSize := True;
  Downed := False;
  FOnClick := nil;
  FEnableFocus := False;
  FClickSound := csNone;
  Caption := Name;

  FBackgroundColor := clWhite;
  FIdx := -1;
  FShadowSize := 4;
  FShadowColor := $40000000;

  FBorderColor := $00608490;

  FHotBorder := $005894B8;
  FDownBorder := $005894B8;

  FBoldColor := $00040404;
  FCurrColor := FUpColor;
  FBold := False;
  FBackground := False;
  FBorder := False;
  FButtonStyle := bsBase;
  if Assigned(MainForm) then begin
    Canvas.Font.Assign(MainForm.Canvas.Font);
    Canvas.Brush.Assign(MainForm.Canvas.Brush);
    Font.Assign(MainForm.Canvas.Font);
  end;
  FUpColor := Canvas.Font.Color;
  FHotColor := Canvas.Font.Color;
  FDownColor := Canvas.Font.Color;
  FClickTime := 0;
  FAlignment := taLeftJustify;
end;

procedure TDLabel.SetAutoSize(Value: Boolean);
begin
  FAutoSize := Value;
  if not (csDesigning in ComponentState) then begin
    if Assigned(ImageCanvas) then begin

      if FAutoSize then begin
        Width := ImageCanvas.TextWidth(Caption);
        Height := ImageCanvas.TextHeight('0');
      //DebugOutStr(Format('TDLabel.SetCaption Caption:%s  Width:%d  Height:%d', [Caption, Width, Height]));
      end;
    end;
  end;
end;

procedure TDLabel.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then begin
    FAlignment := Value;
  end;
end;

function TDLabel.InRange(X, Y: Integer): Boolean;
var
  boInrange: Boolean;
  d: TTexture;
begin
  if (X >= Left) and (X < Left + Width) and (Y >= Top) and (Y < Top + Height) then begin
    boInrange := True;
    if Assigned(FOnInRealArea) then
      FOnInRealArea(Self, X - Left, Y - Top, boInrange);
    Result := boInrange;
  end else
    Result := False;
end;

procedure TDLabel.SetUpColor(Value: TColor);
begin
  if FUpColor <> Value then begin
    FUpColor := Value;
    FCurrColor := Value;
  end;
end;

procedure TDLabel.CaptionChaged;
begin
  if Assigned(ImageCanvas) then begin
  //if not (csDesigning in ComponentState) then begin
    if FAutoSize then begin
      Width := ImageCanvas.TextWidth(Caption);
      Height := ImageCanvas.TextHeight('0');
      //DebugOutStr(Format('TDLabel.SetCaption Caption:%s  Width:%d  Height:%d', [Caption, Width, Height]));
    end;
  end;
end;

function TDLabel.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if (not Background) and (not Result) and Enabled then begin
    Result := inherited MouseMove(Shift, X, Y);
    case FButtonStyle of
      bsBase: begin
          if MouseCaptureControl = Self then
            if InRange(X, Y) then Downed := True
            else Downed := False;
        end;
      bsRadio: begin

        end;
      bsLock: begin

        end;
    end;

  end;
end;

function TDLabel.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := False;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl = nil) then begin
      case FButtonStyle of
        bsBase: begin
            Downed := True;
          end;
        bsRadio: begin

          end;
        bsLock: begin

          end;
      end;
      SetDCapture(Self);
    end;
    Result := True;
  end;
end;

function TDLabel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  I: Integer;
  d: TDControl;
  boDown: Boolean;
begin
  Result := False;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    ReleaseDCapture;
    if not Background then begin
      if InRange(X, Y) then begin
        case FButtonStyle of
          bsBase: begin
              Downed := False;
              if GetTickCount - LabelClickTimeTick > FClickTime then begin
                LabelClickTimeTick := GetTickCount;
                if Assigned(FOnClickSound) then FOnClickSound(Self, FClickSound);
                if Assigned(FOnClick) then FOnClick(Self, X, Y);
              end;
            end;
          bsRadio: begin
              if GetTickCount - LabelClickTimeTick > FClickTime then begin
                LabelClickTimeTick := GetTickCount;
                //showmessage(IntToStr(FClickTime));
                boDown := Downed;
                if (FDParent <> nil) then begin
                  for I := 0 to FDParent.DControls.Count - 1 do begin
                    d := TDControl(FDParent.DControls[I]);
                    if (d <> Self) and (d is TDLabel) and (TDLabel(d).Style = bsRadio) then begin
                      TDLabel(d).Downed := False;
                    end;
                  end;
                end;
                Downed := True;
                if (not boDown) then begin
                  if Assigned(FOnClickSound) then FOnClickSound(Self, FClickSound);
                  if Assigned(FOnClick) then FOnClick(Self, X, Y);
                end;
              end;
            end;
          bsLock: begin
              if GetTickCount - LabelClickTimeTick > FClickTime then begin
                LabelClickTimeTick := GetTickCount;
                Downed := not Downed;
                if Assigned(FOnClickSound) then FOnClickSound(Self, FClickSound);
                if Assigned(FOnClick) then FOnClick(Self, X, Y);
              end;
            end;
        end;
      end;
    end;
    case FButtonStyle of
      bsBase: begin
          Downed := False;
        end;
      bsRadio: begin

        end;
      bsLock: begin

        end;
    end;
    Result := True;
    Exit;
  end else begin
    ReleaseDCapture;
    case FButtonStyle of
      bsBase: begin
          Downed := False;
        end;
      bsRadio: begin

        end;
      bsLock: begin

        end;
    end;
  end;
end;

procedure TDLabel.Process;
var
  OldSize: Integer;
  OldFontStyle: TFontStyles;
begin
  if Assigned(FOnProcess) then FOnProcess(Self);

  if Downed then begin
    FCurrColor := FDownColor;
  end else
    if MouseMoveing then begin
    FCurrColor := FHotColor;
  end else begin
    FCurrColor := FUpColor;
  end;

  FBorderCurrColor := FBorderColor;
  if Enabled then begin
    if MouseDownControl = Self then FBorderCurrColor := FDownBorder;
    if MouseMoveControl = Self then FBorderCurrColor := FHotBorder;
  end;

end;

procedure TDLabel.DirectPaint(dsurface: TTexture);
var
  I, nX: Integer;
  nAlpha: Integer;
  d: TTexture;
  OldSize: Integer;
  OldFontStyle: TFontStyles;
  ARect: TRect;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(Self, dsurface)
  else
    if WLib <> nil then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;

  if FBackground then
    dsurface.FillRect(Bounds(SurfaceX(Left), SurfaceY(Top), Width, Height), FBackgroundColor);
  if FBorder then
    dsurface.FrameRect(Bounds(SurfaceX(Left), SurfaceY(Top), Width, Height), FBorderCurrColor);

  OldSize := MainForm.Canvas.Font.Size;
  OldFontStyle := MainForm.Canvas.Font.Style;

  MainForm.Canvas.Font.Size := Font.Size;
  MainForm.Canvas.Font.Style := Font.Style;
  if Caption <> '' then begin
    if Caption = '-' then begin
      dsurface.FillRect(Bounds(SurfaceX(Left), SurfaceY(Top) + dsurface.TextHeight('0') div 2, Width, 1), FCurrColor);
    end else begin
      case FAlignment of
        taLeftJustify: nX := SurfaceX(Left);
        taRightJustify: nX := Max(SurfaceX(Left), SurfaceX(Left) + (Width - dsurface.TextWidth(Caption)));
        taCenter: nX := SurfaceX(Left) + (Width - dsurface.TextWidth(Caption)) div 2;
      end;
      if FBold then begin
        dsurface.BoldTextOut(nX,
          SurfaceY(Top) + (Height - dsurface.TextHeight('0')) div 2, Caption, FCurrColor, FBoldColor);
      end else begin
        dsurface.TextOut(nX,
          SurfaceY(Top) + (Height - dsurface.TextHeight('0')) div 2, Caption, FCurrColor);
      end;
    end;
  end;

  MainForm.Canvas.Font.Style := OldFontStyle;
  MainForm.Canvas.Font.Size := OldSize;

  for I := 0 to DControls.Count - 1 do
    if TDControl(DControls[I]).Visible then
      TDControl(DControls[I]).DirectPaint(dsurface);
end;

constructor TColors.Create();
begin
  inherited Create;
  FDisabled := clBtnFace;
  FBkgrnd := clWhite;
  FBorder := clGray;
  FFont := clBlack;
  FUp := $00F1EFAB;
  FHot := $00F1EFAB;
  FDown := $00F1EFAB;
  FLine := clBtnFace;
end;

constructor TDMenuItem.Create();
begin
  inherited;
  FVisible := True;
  FEnabled := True;
  FChecked := False;
  FCaption := '';
  FMenu := nil;
end;

destructor TDMenuItem.Destroy;
begin
  //if FMenu <> nil then FMenu.Free;
  inherited;
end;

constructor TDPopupMenu.Create(AOwner: TComponent);
begin
  inherited Create(aowner);
  FItems := TStringList.Create();
  FColors := TColors.Create;
  FActiveMenu := nil;
  FOwnerMenu := nil;
  FOwnerItemIndex := 0;
  FMoveItemIndex := -1;
  FItemIndex := -1;
  Width := 150;
  Height := 100;
  FStyle := sXP;
  Add('Item1', nil);
  Add('Item2', nil);
  Add('Item3', nil);
  Add('Item4', nil);
end;

destructor TDPopupMenu.Destroy;
begin
  while Count > 0 do begin
    Items[0].Free;
    Delete(0);
  end;
  FItems.Free;
  FColors.Free;
  inherited Destroy;
end;

procedure TDPopupMenu.Paint;
var
  I: Integer;
begin
  if csDesigning in ComponentState then begin
    with Canvas do begin
      Brush.Color := clMenu;
      FillRect(ClipRect);
      Pen.Color := clInactiveBorder;

      for I := 0 to Count - 1 do begin
        MoveTo(5, Height div Count * I);
        LineTo(Width - 5, Height div Count * I);
        TextOut((Width - TextWidth(FItems[I])) div 2, Height div Count * I + (Height div Count - TextHeight(FItems[I])) div 2, FItems[I]);
      end;

      MoveTo(0, 0);
      LineTo(Width - 1, 0);
      LineTo(Width - 1, Height - 1);
      LineTo(0, Height - 1);
      LineTo(0, 0);
    end;
  end;
end;

procedure TDPopupMenu.CreateWnd;
begin
  inherited;
  if FItems = nil then FItems := TStringList.Create();
end;

procedure TDPopupMenu.SetOwnerMenu(Value: TDPopupMenu);
var
  Index: Integer;
begin
  if FOwnerMenu <> Value then begin
    if (FOwnerMenu <> nil) then begin
      Index := FOwnerMenu.IndexOf(Self);
      if Index >= 0 then begin
        FOwnerMenu.Menus[Index] := nil;
      end;
    end;
    FOwnerMenu := Value;
  end;
end;

procedure TDPopupMenu.SetOwnerItemIndex(Value: TImageIndex);
var
  Index: Integer;
begin
  if FOwnerMenu <> nil then begin
    if (FOwnerItemIndex >= 0) and (FOwnerItemIndex < FOwnerMenu.Count) then FOwnerMenu.Menus[FOwnerItemIndex] := nil;
    if (Value >= 0) and (Value < FOwnerMenu.Count) then begin
      for Index := Value to FOwnerMenu.Count - 1 do begin
        if FOwnerMenu.Menus[Index] = nil then begin
          FOwnerMenu.Menus[Index] := Self;
          FOwnerItemIndex := Index;
          Break;
        end;
      end;
    end else FOwnerItemIndex := -1;
  end else FOwnerItemIndex := -1;
end;

function TDPopupMenu.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TDPopupMenu.GetItems: TStrings;
begin
  if csDesigning in ComponentState then Refresh;
  Result := FItems;
end;

procedure TDPopupMenu.SetColors(Value: TColors);
begin
  FColors.Assign(Value);
end;

procedure TDPopupMenu.SetItems(Value: TStrings);
var
  I: Integer;
begin
  Clear;
  FItems.Assign(Value);
  for I := 0 to FItems.Count - 1 do begin
    FItems.Objects[I] := nil;
    FItems.Objects[I] := TDMenuItem.Create;
  end;
end;

procedure TDPopupMenu.SetItemIndex(Value: Integer);
begin
  FItemIndex := Value;
  if FItemIndex >= FItems.Count then FItemIndex := -1;
  {if FItemIndex <> Value then begin

  end;}
end;

function TDPopupMenu.GetItem(Index: Integer): TDMenuItem;
begin
  if (Index >= 0) and (Index < FItems.Count) then begin
    if FItems.Objects[Index] = nil then begin
      FItems.Objects[Index] := TDMenuItem.Create;
    end;
    Result := TDMenuItem(FItems.Objects[Index]);
  end else Result := nil;
end;

function TDPopupMenu.GetMenu(Index: Integer): TDPopupMenu;
begin
  if (Index >= 0) and (Index < FItems.Count) then begin
    if FItems.Objects[Index] = nil then begin
      FItems.Objects[Index] := TDMenuItem.Create;
    end;
    Result := TDPopupMenu(TDMenuItem(FItems.Objects[Index]).Menu);
  end else Result := nil;
end;

procedure TDPopupMenu.SetMenu(Index: Integer; Value: TDPopupMenu);
begin
  if FItems.Objects[Index] = nil then begin
    FItems.Objects[Index] := TDMenuItem.Create;
  end;
  TDMenuItem(FItems.Objects[Index]).Menu := Value;
end;

procedure TDPopupMenu.Insert(Index: Integer; ACaption: string; Item: TDPopupMenu);
var
  MenuItem: TDMenuItem;
begin
  MenuItem := TDMenuItem.Create();
  MenuItem.Menu := Item;
  FItems.InsertObject(Index, ACaption, MenuItem);
  //if csDesigning in ComponentState then Refresh;
end;

function TDPopupMenu.IndexOf(Item: TDPopupMenu): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FItems.Count - 1 do begin
    if FItems.Objects[I] = nil then begin
      FItems.Objects[I] := TDMenuItem.Create();
    end;
    if TDMenuItem(FItems.Objects[I]).Menu = Item then begin
      Result := I;
      Exit;
    end;
  end;
end;

procedure TDPopupMenu.Add(ACaption: string; Item: TDPopupMenu);
begin
  Insert(GetCount, ACaption, Item);
end;

procedure TDPopupMenu.Remove(Item: TDPopupMenu);
var
  I: Integer;
begin
  I := IndexOf(Item); if I >= 0 then Delete(I);
end;

procedure TDPopupMenu.Delete(Index: Integer);
begin
  FItems.Delete(Index);
end;

procedure TDPopupMenu.Clear;
begin
  FItemIndex := -1;
  while Count > 0 do begin
    Items[0].Free;
    Delete(0);
  end;
end;

function TDPopupMenu.Find(ACaption: string): TDPopupMenu;
var
  I: Integer;
begin
  Result := nil;
  ACaption := StripHotkey(ACaption);
  for I := 0 to Count - 1 do
    if AnsiSameText(ACaption, StripHotkey(Items[I].Caption)) then
    begin
      Result := Menus[I];
      System.Break;
    end;
end;

procedure TDPopupMenu.Show;
begin
  Visible := True;
  {if Floating then begin
    if DParent <> nil then
      DParent.ChangeChildOrder(Self);
  end;
  if EnableFocus then SetDFocus(Self); }
  ActiveMenu := Self;
end;

procedure TDPopupMenu.Show(d: TDControl);
begin
  //if Count = 0 then Exit;
  Visible := True;
  DControl := d;
 { if Floating then begin
    if DParent <> nil then
      DParent.ChangeChildOrder(Self);
  end;  }
  //if EnableFocus then SetDFocus(Self);
  ActiveMenu := Self;
end;

procedure TDPopupMenu.Hide;
var
  I: Integer;
begin
  //inherited;
  Visible := False;

  if ActiveMenu = Self then ActiveMenu := nil;
  if OwnerMenu <> nil then ActiveMenu := OwnerMenu;
  for I := 0 to Count - 1 do begin
    if (Menus[I] <> nil) { and (not Items[I].Visible)} then begin
      Menus[I].Hide;
    end;
  end;
end;

function TDPopupMenu.InRange(X, Y: Integer): Boolean;
var
  boInrange: Boolean;
  d: TTexture;
begin
  if (X >= Left) and (X < Left + Width) and (Y >= Top) and (Y < Top + Height) then begin
    boInrange := True;
    if Assigned(FOnInRealArea) then
      FOnInRealArea(Self, X - Left, Y - Top, boInrange);
    Result := boInrange;
  end else
    Result := False;
end;

procedure TDPopupMenu.Process;
var
  d: TTexture;
  I, n1C, n2C: Integer;
  rc: TRect;
  nX, nY: Integer;
  oldColor: TColor;
  OldSize: Integer;
  OldFontStyle: TFontStyles;
begin
  if Assigned(FOnProcess) then FOnProcess(Self);
  if not Assigned(ImageCanvas) then Exit;
  if not Assigned(MainForm) then Exit;
  OldSize := MainForm.Canvas.Font.Size;

  MainForm.Canvas.Font.Size := 9;

  FItemSize := Round(ImageCanvas.TextHeight('0') * 1.5);

  n1C := 0;

  if FStyle = sVista then begin
    for I := 0 to FItems.Count - 1 do begin
      if n1C < ImageCanvas.TextWidth(FItems.Strings[I]) then
        n1C := ImageCanvas.TextWidth(FItems.Strings[I]);
    end;

    n1C := n1C + ImageCanvas.TextHeight('0') * 4;
    if n1C <> Width then Width := n1C;
  end;

  if FStyle = sVista then begin
    n2C := FItemSize * FItems.Count + ImageCanvas.TextHeight('0') * 2;
    if n2C <> Height then Height := n2C;
  end else begin
    n2C := FItemSize * FItems.Count + ImageCanvas.TextHeight('0');
    if n2C <> Height then Height := n2C;
  end;

  MainForm.Canvas.Font.Size := OldSize;

  for I := 0 to DControls.Count - 1 do
    if TDControl(DControls[I]).Visible then
      TDControl(DControls[I]).Process;
end;

procedure TDPopupMenu.DirectPaint(dsurface: TTexture);
var
  d: TTexture;
  I, n1C, n2C: Integer;
  rc: TRect;
  nX, nY: Integer;
  oldColor: TColor;
  OldSize: Integer;
  OldFontStyle: TFontStyles;
  OldFColor: TColor;
  OldBColor: TColor;
  CColor: TColor;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(Self, dsurface)
  else
    if WLib <> nil then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;

  OldSize := MainForm.Canvas.Font.Size;
  {OldColor := MainForm.Canvas.Font.Color;
  OldFontStyle := MainForm.Canvas.Font.Style;

  MainForm.Canvas.Font.Size := Canvas.Font.Size;
  MainForm.Canvas.Font.Style := Canvas.Font.Style;
  }
  MainForm.Canvas.Font.Size := 9;

{------------------------------------------------------------------------------}
  rc := ClientRect;
  rc.Left := rc.Left + 1;
  rc.Right := rc.Right - 1;
  rc.Top := rc.Top + 1;
  rc.Bottom := rc.Bottom - 1;
  dsurface.FillRect(rc, FColors.Background);

  rc := ClientRect;
  dsurface.FrameRect(rc, FColors.Border);
{------------------------------------------------------------------------------}
  rc.Left := rc.Left + dsurface.TextHeight('0') + 3;
  rc.Right := rc.Right - dsurface.TextHeight('0') - 3;

{------------------------------------------------------------------------------}
  if FItems.Count > 0 then begin
    if FStyle = sVista then begin

    end else begin
      if FMouseMove then begin
        if (FMoveItemIndex >= 0) and (FMoveItemIndex < FItems.Count) then begin
          if FItems.Strings[FMoveItemIndex] <> '-' then begin
            rc := ClientRect;
            rc.Left := rc.Left + 2;
            rc.Right := rc.Right - 2;
            rc.Top := rc.Top + dsurface.TextHeight('0') div 2 + FMoveItemIndex * FItemSize;
            rc.Bottom := rc.Top + FItemSize;
            dsurface.FillRect(rc, FColors.Hot);
          end;
        end;
      end else
        if FMouseDown then begin
        if (FItemIndex >= 0) and (FItemIndex < FItems.Count) then begin
          if FItems.Strings[FItemIndex] <> '-' then begin
            rc := ClientRect;
            rc.Left := rc.Left + 2;
            rc.Right := rc.Right - 2;
            rc.Top := rc.Top + dsurface.TextHeight('0') div 2 + FItemIndex * FItemSize;
            rc.Bottom := rc.Top + FItemSize;
            dsurface.FillRect(rc, FColors.Hot);
          end;
        end;
      end;
    end;
{------------------------------------------------------------------------------}
    nY := 0;
    rc := ClientRect;
    rc.Left := rc.Left + 4;
    rc.Right := rc.Right - 4;
    rc.Top := rc.Top + 4;
    rc.Bottom := rc.Bottom - 4;
    //rc.Left := rc.Left + dsurface.TextHeight('0') div 2;
    //rc.Right := rc.Right - dsurface.TextHeight('0') div 2;

    for I := 0 to FItems.Count - 1 do begin
      if FItems[I] = '-' then begin
        nY := (dsurface.TextHeight('0') div 2 + I * FItemSize) + FItemSize div 2;
        rc.Top := SurfaceY(Top) + nY;
        rc.Bottom := rc.Top + 1;
        dsurface.FrameRect(rc, FColors.Line);
      end;
    end;
{------------------------------------------------------------------------------}
    rc := ClientRect;
    if FStyle = sVista then begin
      nX := dsurface.TextHeight('0') * 2 + rc.Left;
    end else begin
      nX := rc.Left + 2;
    end;
{------------------------------------------------------------------------------}
    for I := 0 to FItems.Count - 1 do begin
      if FItems[I] <> '-' then begin
        CColor := FColors.Font;
        if Items[I].Enabled then begin
          if FMoveItemIndex = I then CColor := FColors.Selected
          else CColor := FColors.Font;
        end else begin
          CColor := FColors.Disabled;
        end;
        if FStyle = sVista then begin
          nY := (dsurface.TextHeight('0') + I * FItemSize) + (FItemSize - dsurface.TextHeight('0')) div 2;
        end else begin
          nY := (dsurface.TextHeight('0') div 2 + I * FItemSize) + (FItemSize - dsurface.TextHeight('0')) div 2;
        end;
        nY := SurfaceY(Top) + nY;
        dsurface.TextOut(nX, nY, FItems[I], CColor);
      end;
    end;
{------------------------------------------------------------------------------}
    if FStyle = sVista then begin
      if FMouseMove then begin
        if (FMoveItemIndex >= 0) and (FMoveItemIndex < FItems.Count) then begin
          if FItems.Strings[FMoveItemIndex] <> '-' then begin
            rc := ClientRect;
            rc.Left := rc.Left + 3;
            rc.Right := rc.Right - 3;
            rc.Top := rc.Top + dsurface.TextHeight('0') + FMoveItemIndex * FItemSize;
            rc.Bottom := rc.Top + FItemSize;
            dsurface.FillRectAlpha(Rect(rc.Left, rc.Top, rc.Right, rc.Top + FItemSize div 3), FColors.Hot, 60);
            dsurface.FillRectAlpha(Rect(rc.Left, rc.Top + FItemSize div 3, rc.Right, rc.Top + FItemSize), FColors.Hot, 100);
            dsurface.FrameRect(rc, FColors.Hot);
          end;
        end;
      end else
        if FMouseDown then begin
        if (FItemIndex >= 0) and (FItemIndex < FItems.Count) then begin
          if FItems.Strings[FItemIndex] <> '-' then begin
            rc := ClientRect;
            rc.Left := rc.Left + 3;
            rc.Right := rc.Right - 3;
            rc.Top := rc.Top + dsurface.TextHeight('0') + FItemIndex * FItemSize;
            rc.Bottom := rc.Top + FItemSize;

            dsurface.FillRectAlpha(Rect(rc.Left, rc.Top, rc.Right, rc.Top + FItemSize div 3), FColors.Hot, 100);
            dsurface.FillRectAlpha(Rect(rc.Left, rc.Top + FItemSize div 3, rc.Right, rc.Top + FItemSize), FColors.Down, 200);
            dsurface.FrameRect(rc, FColors.Hot);
          end;
        end;
      end;
    end;
  end;
  MainForm.Canvas.Font.Size := OldSize;

  for I := 0 to DControls.Count - 1 do
    if TDControl(DControls[I]).Visible then
      TDControl(DControls[I]).DirectPaint(dsurface);
end;

function TDPopupMenu.KeyPress(var Key: Char): Boolean;
begin

end;

function TDPopupMenu.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
begin

end;

function TDPopupMenu.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if (not Background) and (not Result) then begin
    Result := inherited MouseMove(Shift, X, Y);
    if MouseCaptureControl = Self then
      if InRange(X, Y) then Downed := True
      else Downed := False;
  end;
  FMouseMove := Result;
  if (FItemSize <> 0) and FMouseMove and (Count > 0) then begin
    FMoveItemIndex := (Y - ImageCanvas.TextHeight('0') - Top) div FItemSize;
    if (FMoveItemIndex >= 0) and (FMoveItemIndex < FItems.Count) then begin
      if Menus[FMoveItemIndex] <> FActiveMenu then begin
        if FActiveMenu <> nil then FActiveMenu.Hide;
        FActiveMenu := nil;
        if Items[FMoveItemIndex].Enabled then begin
          FActiveMenu := Menus[FMoveItemIndex];
          if (FActiveMenu <> nil) and (not FActiveMenu.Visible) then FActiveMenu.Show(Self);
        end;
      end;
    end else begin
      if FActiveMenu <> nil then FActiveMenu.Hide;
      FActiveMenu := nil;
      FMoveItemIndex := -1;
    end;
  end else FMoveItemIndex := -1;
end;

function TDPopupMenu.Click(X, Y: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
 { if (ActiveMenu <> nil) then begin
    if (ActiveMenu = Self) then begin

      if Assigned(FOnClick) then
        FOnClick(Self, X, Y);

      Result := True;
    end;
    Exit;
  end; }
  for I := DControls.Count - 1 downto 0 do
    if TDControl(DControls[I]).Visible then
      if TDControl(DControls[I]).Click(X - Left, Y - Top) then begin
        Result := True;
        Exit;
      end;
  if InRange(X, Y) then begin
    if Assigned(FOnClick) then
      FOnClick(Self, X, Y);
    Result := True;
  end;
end;

function TDPopupMenu.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := False;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    //if (not Background) and (MouseCaptureControl = nil) then begin
    Downed := True;
      //SetDCapture(Self);
   // end;
    Result := True;
  end;
  FMouseDown := Result;
  FMouseMove := Result;
  if (FItemSize <> 0) and FMouseDown and (Count > 0) then begin
    FItemIndex := (Y - ImageCanvas.TextHeight('0') - Top) div FItemSize;
  end;
end;

function TDPopupMenu.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := False;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    Result := True;
    Downed := False;
    FMouseDown := not Result;
    if InRange(X, Y) then begin
      if (FItemIndex >= 0) and (FItemIndex < Count) and Items[FItemIndex].Enabled then begin
        if (FActiveMenu <> nil) then begin
          if (not FActiveMenu.Visible) then FActiveMenu.Show(Self);
        end else Hide;
      end else if (Count <= 0) then Hide;
    end;
  end else begin
    ReleaseCapture;
    Downed := False;
  end;
end;

  //输入控件
{--------------------- TDEdit --------------------------}

constructor TDEdit.Create(AOwner: TComponent);
begin
  inherited Create(aowner);
  Downed := False;
  FOnClick := nil;
  FOnChange := nil;
  FMainMenu := nil;
  FEnableFocus := True;
  FClickSound := csNone;
  FInValue := vString;
  Width := 100;
  Height := 20;

  FText := 'DEdit'; //Some text
  Ticks := 0;

  FBlinkTicks := 1000;
  FReadOnly := False;
  FMaxLength := 0;

  bDoubleByte := False;
  KeyByteCount := 0;

  FPasswordText := '';
  FShowPasswordText := False;

  FBkgrndColor := clBlack;
  FSelectedColor := clWhite;
  FBorderColor := clWhite;
  FSelTextColor := $00DC802C;
  FFontColor := clWhite;
  FSelTextFontColor := clWhite;
  FDisabledColor := clBtnFace;

  Ticks := 0;
  FBlinkTicks := 4;
  //FPosTextWidth := 0;
  FSelectText := False;
  FPaste := False;
  FDrawBkgrnd := False;
  FDrawBorder := True;
  FPasswordChar := #0;
  FTextAdjust := 0;
  FSelIndex := 0;
  FSelText := '';
  FEndIndex := -1;
  FBeginIndex := -1;

  FBorderColor := $00608490;

  FHotBorder := $005894B8;
  FDownBorder := $005894B8;
end;

procedure TDEdit.Paint;
begin
  if csDesigning in ComponentState then begin
    with Canvas do begin
      Brush.Color := clWhite;
      FillRect(ClipRect);
      Pen.Color := cl3DDkShadow;
      MoveTo(0, 0);
      LineTo(Width - 1, 0);
      LineTo(Width - 1, Height - 1);
      LineTo(0, Height - 1);
      LineTo(0, 0);

      {Pen.Color := cl3DDkShadow;
      MoveTo(0, 0);
      LineTo(Width - 1, 0);

      MoveTo(Width - 1, Height - 1);
      Pen.Color := clCream;
      LineTo(Width - 1, 0);
      LineTo(0, Height - 1);

      Pen.Color := cl3DDkShadow;
      LineTo(0, Height - 1);
      LineTo(0, 0);   }
      TextOut(2 {(Width - TextWidth(Text)) div 2}, (Height - TextHeight(Text)) div 2, Text);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TDEdit.SetViewPos(const Value: Integer);
var
  mSize: Integer;
begin
  FViewPos := Value;
  //if csDesigning in ComponentState then Exit;
  if Assigned(ImageCanvas) then begin
    mSize := 4 + ImageCanvas.TextWidth(Text) + (Height div 2);
  end else begin
    mSize := 4 + Canvas.TextWidth(Text) + (Height div 2);
  end;
  if (FViewPos > mSize - Width) then FViewPos := mSize - Width;
  if (FViewPos < 0) then FViewPos := 0;
end;


//------------------------------------------------------------------------------

procedure TDEdit.SetMaxLength(const Value: Integer);
begin
  FMaxLength := Value;
  if (FMaxLength > 0) and (Length(FText) > FMaxLength) then
  begin
    FText := Copy(FText, 1, FMaxLength);
    if (FSelIndex > Length(FText)) then FSelIndex := Length(FText);
    if FSelIndex < 0 then FSelIndex := 0;
  end;
end;

//---------------------------------------------------------------------------

procedure TDEdit.StripWrong(var Text: string);
var
  I: Integer;
begin
  Text := Trim(Text);
  for I := Length(Text) downto 1 do
    if (not (Text[I] in TextChars)) then
      Delete(Text, I, 1);
end;

//---------------------------------------------------------------------------

function TDEdit.GetSelText: WideString;
var
  I, Len: Integer;
  sText: string;
  P: PChar;
begin
  if FPasswordChar <> #0 then begin
    //for I := 1 to Length(FSelText) do Result := Result + FPasswordChar;
    //Result := '';
    Len := Length(FSelText);
    if Len > 0 then begin
      SetLength(sText, Len);
      P := PChar(sText);
      for I := 1 to Len do begin
        P^ := FPasswordChar;
        Inc(P);
      end;
      Result := sText;
    end else Result := '';
  end else begin
    Result := FSelText;
  end;
end;

//---------------------------------------------------------------------------

function TDEdit.GetText: WideString;
var
  I, Len: Integer;
  sText: string;
  P: PChar;
begin
  //Result := '';
  if FPasswordChar <> #0 then begin
    Len := Length(FText);
    if Len > 0 then begin
      SetLength(sText, Len);
      P := PChar(sText);
      for I := 1 to Len do begin
        P^ := FPasswordChar;
        Inc(P);
      end;
      Result := sText;
    end else Result := '';
  end else begin
    Result := FText;
  end;
end;

//---------------------------------------------------------------------------

function TDEdit.CharRect(Index: Integer): TRect;
var
  sText: WideString;
  TextBefore: WideString;
  TextAfter: WideString;
  sLeft, sRight: Integer;
  aCanvas: TCanvas;
begin
   //-------modi by huasoft-------------------------------------
   // (2) Extract part of text prior to selector
  sText := GetText;
  TextBefore := '';
  TextAfter := '';
  if (Index > 0) then TextBefore := Copy(sText, 1, Index);
  if (Index >= 0) then TextAfter := Copy(sText, 1, Index + 1);

   // (3) Determine selected position
  if Assigned(ImageCanvas) then begin

    sLeft := 0 + ImageCanvas.TextWidth(TextBefore);

    if (TextAfter <> '') and (Index < Length(sText)) then
      sRight := 0 + ImageCanvas.TextWidth(TextAfter)
    else sRight := sLeft + (Height div 2);
  end else begin
    sLeft := 0 + Canvas.TextWidth(TextBefore);

    if (TextAfter <> '') and (Index < Length(sText)) then
      sRight := 0 + Canvas.TextWidth(TextAfter)
    else sRight := sLeft + (Height div 2);
  end;
  //--------------------------------------------------------------------

   // (4) Determine selected rectangle
  Result.Left := sLeft;
  Result.Right := sRight;
  Result.Top := 2;
  Result.Bottom := Height - 2;
end;

//------------------------------------------------------------------------------

procedure TDEdit.ScrollToRight(Index: Integer);
var
  ChRect: TRect;
begin
  ChRect := CharRect(Index);
  if (ChRect.Right <= ChRect.Left) and (ChRect.Right = 0) then Exit;

  ViewPos := ChRect.Right - Width + 2;
end;

//---------------------------------------------------------------------------

procedure TDEdit.ScrollToLeft(Index: Integer);
var
  ChRect: TRect;
begin
  ChRect := CharRect(Index);
  if (ChRect.Right <= ChRect.Left) and (ChRect.Right = 0) then Exit;

  ViewPos := ChRect.Left - 2;
end;

//---------------------------------------------------------------------------

function TDEdit.NeedToScroll(): Boolean;
var
  ChRect, PaintRect, CutRect: TRect;
begin
  ChRect := CharRect(FSelIndex);
  if (ChRect.Right <= ChRect.Left) and (ChRect.Right = 0) then begin
    Result := False;
    Exit;
  end;

  PaintRect := ClientRect;
  CutRect := ShortRect(MoveRect(ChRect, Point(PaintRect.Left - FViewPos, 0)),
    PaintRect);
  Result := (CutRect.Right - CutRect.Left) < (ChRect.Right - ChRect.Left);
end;

//---------------------------------------------------------------------------

procedure TDEdit.SelectChar(const MousePos: TPoint);
var
  I, Search: Integer;
  ChRect, vRect, PaintRect: TRect;
  RelPoint: TPoint;
  sText: WideString;
begin
  RelPoint.X := MousePos.X - Left;
  RelPoint.Y := MousePos.Y - Top;
  sText := GetText;
  if RelPoint.X <= 0 then begin
    Search := 0;
  end else begin
    Search := Length(sText);
  end;
  for I := 0 to Length(sText) do begin
    ChRect := CharRect(I);
    if (ChRect.Right <= ChRect.Left) {and (ChRect.Right = 0) } then Exit;

    vRect := MoveRect(ChRect, Point(-FViewPos, 0));
    if (PointInRect(RelPoint, vRect)) then begin
      Search := I;
      Break;
    end;
  end;

  if sText <> '' then begin
    if (FBeginIndex = FEndIndex) and (FBeginIndex <> FSelIndex) then begin
      FBeginIndex := Search;
      FEndIndex := Search;
    end else begin
      FEndIndex := Search;
      if FBeginIndex < FEndIndex then begin
        FSelText := Copy(FText, FBeginIndex + 1, FEndIndex - FBeginIndex);
      end else begin
        FSelText := Copy(FText, FEndIndex + 1, FBeginIndex - FEndIndex);
      end;
    end;
    FSelIndex := Search;
  end else begin
    FBeginIndex := -1;
    FEndIndex := -1;
    FSelText := '';
    FSelIndex := 0;
  end;

  if (NeedToScroll()) then begin
    if (MousePos.X >= Width div 2) then ScrollToRight(FSelIndex)
    else ScrollToLeft(FSelIndex);
  end;
end;

//==============================================================================

procedure TDEdit.SetSelText(const Value: WideString);
begin

end;

//==============================================================================

procedure TDEdit.SetSelIndex(const Value: Integer);
begin
  if FSelIndex <> Value then begin
    FSelIndex := Value;

    if (FSelIndex > Length(FText)) then FSelIndex := Length(Text);
    if (FSelIndex < 0) then FSelIndex := 0;
    FSelText := '';
    FEndIndex := -1;
    FBeginIndex := -1;
  end;
end;

//==============================================================================

procedure TDEdit.SetSelLength(const Value: Integer);
begin
  if abs(FBeginIndex - FEndIndex) <> Value then begin
    if (FSelIndex >= Length(FText)) then begin
      FSelText := '';
      FEndIndex := -1;
      FBeginIndex := -1;
    end else begin
      FBeginIndex := FSelIndex;
      FEndIndex := Min(Length(FText), Value);
      FSelText := Copy(FText, FBeginIndex + 1, FEndIndex - FBeginIndex);
    end;
  end;
end;

//==============================================================================

function TDEdit.GetSelLength: Integer;
begin
  Result := abs(abs(FBeginIndex) - abs(FEndIndex));
end;

//==============================================================================

function TDEdit.KeyPress(var Key: Char): Boolean;
var
  Ch: Char;
  wCh: WideChar;
  AddTx: string;
  nBeginIndex: Integer;
  nEndIndex: Integer;
begin
  Result := False;
  if inherited KeyPress(Key) then begin
    if (FReadOnly) or (not Enabled) then Exit;
    Result := True;
    Ch := Key;

    if (IsDBCSLeadByte(Ord(Key)) or bDoubleByte) then begin
      if FInValue = vString then begin
        bDoubleByte := True;
        Inc(KeyByteCount);
        InputStr := InputStr + Ch;
      end else begin
        InputStr := '';
        Ch := #0;
        Exit;
      end;
    end;
    
    if FInValue = vInteger then begin
      if not (Ch in ['0'..'9']) then Exit;
    end;

    if (Ch in TextChars) then begin
      if (FSelText <> '') then begin
        nBeginIndex := FBeginIndex;
        nEndIndex := FEndIndex;
        ChgNumber(nBeginIndex, nEndIndex);
        if (nEndIndex = FSelIndex) and (nEndIndex <= Length(FText)) then Dec(FSelIndex, Length(FSelText));
        Delete(FText, nBeginIndex + 1, Length(FSelText));
        FSelText := '';
        FEndIndex := -1;
        FBeginIndex := -1;
        if (FSelIndex < 0) then FSelIndex := 0;
        if (FSelIndex > Length(FText)) then FSelIndex := Length(FText);
        if (NeedToScroll()) then ScrollToLeft(FSelIndex);
      end;
      if (FMaxLength < 1) or (Length(FText) < FMaxLength) then begin
        if not bDoubleByte then begin
          if FInValue = vInteger then begin
            if not IsStringNumber(Ch) then begin
              Ch := #0;
              Exit;
            end;
          end;
          if (FText = '') or (FSelIndex >= Length(FText)) then FText := FText + Ch
          else Insert(Ch, FText, FSelIndex + 1);
          Inc(FSelIndex);
        end else
          if (KeyByteCount >= 2) then begin
          if (FText = '') or (FSelIndex >= Length(FText)) then FText := FText + InputStr
          else Insert(InputStr, FText, FSelIndex + 1);
          bDoubleByte := False;
          KeyByteCount := 0;
          InputStr := '';
          Inc(FSelIndex);
        end;

        if (FSelIndex < 0) then FSelIndex := 0;
        if (FSelIndex > Length(FText)) then FSelIndex := Length(FText);
        if (NeedToScroll()) then ScrollToRight(FSelIndex);
        if (Assigned(FOnChange)) then FOnChange(Self);
      end;
    end;
  end;
end;

procedure TDEdit.EnterKey(var Key: Word);
begin
  case Key of
    VK_BACK,
      byte('D'): DeleteText;
    byte('C'): CopyText;
    byte('X'): CutText;
    byte('Z'): ;
    byte('V'): PasteText;
    byte('A'): SelectAll;
  end;
end;

function TDEdit.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := False;
  if inherited KeyDown(Key, Shift) and Enabled then begin
    Result := True;
    case Key of
      VK_RIGHT:
        begin
          if (FSelIndex < Length(Text)) then Inc(FSelIndex);
          if (NeedToScroll()) then ScrollToRight(FSelIndex);
        end;
      VK_LEFT:
        begin
          if (FSelIndex > 0) then Dec(FSelIndex);
          if (NeedToScroll()) then ScrollToLeft(FSelIndex);
        end;
      VK_BACK: EnterKey(Key);

      VK_DELETE:
        if (not FReadOnly) then begin
          Delete(FText, FSelIndex, 1);
         { if (FInValue = vInteger) and (FText = '') then begin
            FText := '0';
          end; }
          if (FSelIndex < 0) then FSelIndex := 0;
          if (FSelIndex > Length(FText)) then FSelIndex := Length(FText);
          if (Assigned(FOnChange)) then FOnChange(Self);
        end;

      VK_HOME: begin
          FSelIndex := 0;
          if (NeedToScroll()) then ScrollToLeft(FSelIndex);
        end;

      VK_END: begin
          FSelIndex := Length(Text);
          if (NeedToScroll()) then ScrollToRight(FSelIndex);
        end;
      VK_RETURN: ; //if (Owner <> nil) and (not Owner.CallNextKeyEvent) then Exit;
    end;
  end;
  if (ssCtrl in Shift) and Enabled then EnterKey(Key);
end;

procedure TDEdit.DeleteText;
var
  nBeginIndex: Integer;
  nEndIndex: Integer;
begin
  if not FReadOnly then begin
    //Showmessage('TDEdit.DeleteText');
    if (FSelText <> '') then begin
      nBeginIndex := FBeginIndex;
      nEndIndex := FEndIndex;
      ChgNumber(nBeginIndex, nEndIndex);
      if (nEndIndex = FSelIndex) and (nEndIndex <= Length(FText)) then
        Dec(FSelIndex, Length(FSelText));
      Delete(FText, nBeginIndex + 1, Length(FSelText));
      FSelText := '';
      FEndIndex := -1;
      FBeginIndex := -1;
     { if (FInValue = vInteger) and (FText = '') then begin
        FText := '0';
      end; }
      if (FSelIndex < 0) then FSelIndex := 0;
      if (FSelIndex > Length(FText)) then FSelIndex := Length(FText);
      if (NeedToScroll()) then ScrollToLeft(FSelIndex);
    end else begin
      //Showmessage('TDEdit.DeleteText: FText:'+IntToStr(Length(FText))+' FSelIndex:'+IntToStr(FSelIndex));
      Delete(FText, FSelIndex, 1);
      {if (FInValue = vInteger) and (FText = '') then begin
        FText := '0';
      end;    }
      if (FSelIndex > 0) then Dec(FSelIndex);
      if (FSelIndex < 0) then FSelIndex := 0;
      if (FSelIndex > Length(FText)) then FSelIndex := Length(FText);
      if (NeedToScroll()) then ScrollToRight(FSelIndex);
    end;
    if (Assigned(FOnChange)) then FOnChange(Self);
  end;
end;

procedure TDEdit.CopyText;
var
  Clipboard: TClipboard;
begin
  if (FSelText <> '') then begin
    Clipboard := TClipboard.Create();
    Clipboard.AsText := string(FSelText);
    Clipboard.Free();
  end;
end;

procedure TDEdit.CutText;
var
  Clipboard: TClipboard;
  nBeginIndex: Integer;
  nEndIndex: Integer;
begin
  if FReadOnly then Exit;
  if (FSelText <> '') then begin
    nBeginIndex := FBeginIndex;
    nEndIndex := FEndIndex;
    ChgNumber(nBeginIndex, nEndIndex);
    if (nEndIndex = FSelIndex) and (nEndIndex < Length(FText)) then
      Dec(FSelIndex, Length(FSelText));
    Delete(FText, nBeginIndex + 1, Length(FSelText));
    if (FSelIndex < 0) then FSelIndex := 0;
    Clipboard := TClipboard.Create();
    Clipboard.AsText := string(FSelText);
    Clipboard.Free();

    FSelText := '';
    FEndIndex := -1;
    FBeginIndex := -1;

    if (NeedToScroll()) then ScrollToLeft(FSelIndex);
    if (Assigned(FOnChange)) then FOnChange(Self);
  end;
end;

procedure TDEdit.PasteText;
var
  Clipboard: TClipboard;
  AddTx: string;
  TextBefore: WideString;
  TextAfter: WideString;
  I: Integer;
  nBeginIndex: Integer;
  nEndIndex: Integer;
begin
  if FReadOnly or (not FPaste) then Exit;
  nBeginIndex := FBeginIndex;
  nEndIndex := FEndIndex;
  ChgNumber(nBeginIndex, nEndIndex);

  if (FSelText <> '') then begin
    if (nEndIndex = FSelIndex) and (nEndIndex <= Length(FText)) then
      Dec(FSelIndex, Length(FSelText));
    Delete(FText, nBeginIndex + 1, Length(FSelText));
    if (FSelIndex < 0) then FSelIndex := 0;
    FSelText := '';
    FEndIndex := -1;
    FBeginIndex := -1;
    if (NeedToScroll()) then ScrollToLeft(FSelIndex);
  end;
  Clipboard := TClipboard.Create();

  AddTx := Clipboard.AsText;
  StripWrong(AddTx);
  if FInValue = vInteger then begin
    if not IsStringNumber(AddTx) then AddTx := '0';
  end;
  Insert(AddTx, FText, FSelIndex + 1);
  Inc(FSelIndex, Length(AddTx));

  if (FMaxLength > 0) and (Length(FText) > FMaxLength) then
  begin
    FText := Copy(FText, 1, FMaxLength);
    if (FSelIndex > Length(FText)) then FSelIndex := Length(FText);
  end;

  if (NeedToScroll()) then ScrollToRight(FSelIndex);

  Clipboard.Free();

  if (Assigned(FOnChange)) then FOnChange(Self);
end;

function TDEdit.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if (not Background) and (not Result) then begin
    Result := inherited MouseMove(Shift, X, Y);
    if MouseCaptureControl = Self then
      if InRange(X, Y) then Downed := True
      else Downed := False;
  end;

  if Result and Downed and (ssLeft in Shift) then begin
    if FSelectText then begin
      SelectChar(Point(X, Y));
    end else begin
      FBeginIndex := -1;
      FEndIndex := -1;
      FSelText := '';
      SelectChar(Point(X, Y));
    end;
  end;
end;

function TDEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  I: Integer;
  d: TDControl;
begin
  Result := False;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (MouseCaptureControl = nil) then begin
      Downed := True;
      SetDCapture(Self);
    end;
    if (Button = mbLeft) and Enabled then begin
      FSelText := '';
      FBeginIndex := -1;
      FEndIndex := -1;
      SelectChar(Point(X, Y));
    end;
    Result := True;
  end;
end;

function TDEdit.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  Clipboard: TClipboard;
begin
  Result := False;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    ReleaseDCapture;
    if not Background then begin
      if InRange(X, Y) and Enabled then begin
        if Assigned(FOnClickSound) then FOnClickSound(Self, FClickSound);
        if Assigned(FOnClick) then FOnClick(Self, X, Y);
        if Assigned(MainMenu) and (Button = mbRight) then begin
          if SelText = '' then begin
            MainMenu.Items[0].Enabled := False;
            MainMenu.Items[1].Enabled := False;
            MainMenu.Items[3].Enabled := False;
          end else begin
            MainMenu.Items[0].Enabled := True;
            MainMenu.Items[1].Enabled := True;
            MainMenu.Items[3].Enabled := True;
          end;
          MainMenu.Items[5].Enabled := Text <> '';

          Clipboard := TClipboard.Create;
          if Clipboard.AsText <> '' then MainMenu.Items[2].Enabled := True else
            MainMenu.Items[2].Enabled := False;
          Clipboard.Free;

          if SurfaceX(X) + MainMenu.Width > SCREENWIDTH then MainMenu.Left := SurfaceX(X) - MainMenu.Width
          else MainMenu.Left := SurfaceX(X);
          if SurfaceY(Y) + MainMenu.Height > SCREENHEIGHT then MainMenu.Top := SurfaceY(Y) - MainMenu.Height
          else MainMenu.Top := SurfaceY(Y);
          MainMenu.Show(Self);
        end;
      end;
    end;
    Downed := False;
    Result := True;
    Exit;
  end else begin
    ReleaseDCapture;
    Downed := False;
  end;
end;

procedure TDEdit.SetText(const Value: WideString);
var
  X, nSelCount: Integer;
  sText: string;
  Changed: Boolean;
begin
  Changed := (Value <> FText);
  FText := Value;
  if (FMaxLength > 0) and (Length(FText) > FMaxLength) then
    FText := Copy(FText, 1, FMaxLength);
  //sText := Value;
  //StripWrong(sText);

  FText := Value;
  if FInValue = vInteger then begin
    if not IsStringNumber(FText) then FText := '0';
  end;

  FSelIndex := Length(FText);
  FSelText := '';
  FBeginIndex := -1;
  FEndIndex := -1;
  FViewPos := 0;
  if csDesigning in ComponentState then Refresh;
  if (Assigned(FOnChange)) and Changed then FOnChange(Self);
end;

procedure TDEdit.SelectAll;
begin
  if not FSelectText then Exit;
  if FSelText <> FText then begin
    FBeginIndex := 0;
    FEndIndex := Length(FText);
    FSelText := FText;
  end;
end;

procedure TDEdit.DrawText(dsurface: TTexture; const vRect: TRect);
var
  PaintRect: TRect;
  RectText: TRect;
  TextTop: Integer;
  sText: Widestring;
  nTextWidth: Integer;
  nTextHeight: Integer;
  ARect, BRect, CRect: TRect;
  AText, BText, CText: string;
begin
  AText := '';
  BText := '';
  CText := '';
  FillChar(ARect, SizeOf(TRect), 0);
  FillChar(BRect, SizeOf(TRect), 0);
  FillChar(CRect, SizeOf(TRect), 0);

  sText := GetText;
  if sText <> '' then begin
    PaintRect := vRect;
    RectText := ShortRect(ShrinkRect(PaintRect, 2, 0), PaintRect);
    if (RectText.Right > RectText.Left) and (RectText.Bottom > RectText.Top) then begin
      PaintRect := vRect;
      TextTop := dsurface.TextHeight(sText);
      if (TextTop > 0) then
        TextTop := ((PaintRect.Bottom - PaintRect.Top) - TextTop) div 2;

      if FBeginIndex <> FEndIndex then begin
        if FBeginIndex < FEndIndex then begin
          BText := Copy(sText, FBeginIndex + 1, FEndIndex - FBeginIndex);
          AText := Copy(sText, 1, FBeginIndex);
          CText := Copy(sText, FEndIndex + 1, Length(sText) - FEndIndex);
        end else begin
          BText := Copy(sText, FEndIndex + 1, FBeginIndex - FEndIndex);
          AText := Copy(sText, 1, FEndIndex);
          CText := Copy(sText, FBeginIndex + 1, Length(sText) - FBeginIndex);
        end;

        nTextHeight := dsurface.TextHeight('pP');
        nTextWidth := dsurface.TextWidth(AText);

        if nTextWidth > FViewPos then begin
          ARect.Left := FViewPos;
          ARect.Top := 0;
          ARect.Right := ARect.Left + Min(nTextWidth - FViewPos, RectText.Right - RectText.Left);
          ARect.Bottom := nTextHeight;
        end;

        if ARect.Right - ARect.Left < RectText.Right - RectText.Left then begin
          if nTextWidth < FViewPos then
            BRect.Left := FViewPos - nTextWidth
          else
            BRect.Left := 0;

          BRect.Top := 0;
          BRect.Right := BRect.Left + Min((RectText.Right - RectText.Left) - (ARect.Right - ARect.Left), dsurface.TextWidth(BText));
          BRect.Bottom := nTextHeight;
        end;

        CRect.Left := 0;
        CRect.Top := 0;
        CRect.Right := CRect.Left + Min((RectText.Right - RectText.Left) - (ARect.Right - ARect.Left) - (BRect.Right - BRect.Left), dsurface.TextWidth(CText));
        CRect.Bottom := nTextHeight;
      end else begin
        AText := sText;
        ARect.Left := FViewPos;
        ARect.Top := 0;
        ARect.Right := ARect.Left + Min(RectText.Right - RectText.Left, dsurface.TextWidth(AText));
        ARect.Bottom := dsurface.TextHeight(sText);
      end;

      ImageFont.DrawEditText(dsurface, PaintRect.Left + 2, PaintRect.Top + TextTop + FTextAdjust,
        ARect, BRect, CRect, AText, BText, CText,
        FontColor, SelTextFontColor, SelTextColor);
    end;
  end;
end;
(*procedure TDEdit.DrawText(dsurface: TTexture; const vRect: TRect);
var
  ChRect: TRect;
  PaintRect: TRect;
  RectText: TRect;
  SelRect: TRect;
  TextTop: Integer;
  PrevRect: TRect;
  sText: WideString;
  nIndex, nBeginIndex, nEndIndex: Integer;
begin
  PaintRect := vRect;
  sText := GetText;
  RectText := ShortRect(ShrinkRect(PaintRect, 2, 0), ClientRect);
  if (RectText.Right > RectText.Left) and (RectText.Bottom > RectText.Top) then begin
    TextTop := dsurface.TextHeight(sText);
    if (TextTop > 0) then
      TextTop := ((PaintRect.Bottom - PaintRect.Top) - TextTop) div 2;

    if (FBeginIndex <> FEndIndex) then begin //画选择的TEXT
      nBeginIndex := FBeginIndex;
      nEndIndex := FEndIndex;

      if FBeginIndex > FEndIndex then begin
        nBeginIndex := FEndIndex;
        nEndIndex := FBeginIndex;
      end;

      SelRect := RectText;

      {if nBeginIndex < nEndIndex then begin
        ChRect := CharRect(nBeginIndex);
        SelRect.Left := PaintRect.Left + Max((ChRect.Left - FViewPos), 0) + 1;
        ChRect := Bounds(PaintRect.Left, RectText.Top, SelRect.Left - PaintRect.Left, SelRect.Bottom - SelRect.Top);
        dsurface.TextRect(ChRect, PaintRect.Left + 2 - FViewPos, PaintRect.Top + TextTop + FTextAdjust, sText, FontColor);


        ChRect := CharRect(nEndIndex);
        SelRect.Right := PaintRect.Left + Min((ChRect.Left - FViewPos), Width) + 2;
        ChRect := Bounds(SelRect.Right, PaintRect.Top, RectText.Right - SelRect.Right, SelRect.Bottom - SelRect.Top);
        dsurface.TextRect(ChRect, PaintRect.Left + 2 - FViewPos, PaintRect.Top + TextTop + FTextAdjust, sText, FontColor);
      end;
      //SelRect := ShrinkRect(SelRect, 1, 1);
      dsurface.TextOut(SelRect.Left + 1, SelRect.Top + TextTop + FTextAdjust, GetSelText, SelTextFontColor, SelTextColor);
      //dsurface.FillRect(SelRect, SelTextColor);
    end else
      dsurface.TextRect(RectText, PaintRect.Left + 2 - FViewPos, PaintRect.Top + TextTop + FTextAdjust, sText, FontColor);   }


      if nBeginIndex < nEndIndex then begin
        ChRect := CharRect(nBeginIndex);
        SelRect.Left := PaintRect.Left + Max((ChRect.Left - FViewPos), 0) + 1;

        ChRect := CharRect(nEndIndex);
        SelRect.Right := PaintRect.Left + Min((ChRect.Left - FViewPos), Width) + 2;
      end;
      SelRect := ShrinkRect(SelRect, 1, 1);
      //dsurface.TextOut(SelRect.Left + 1, SelRect.Top + TextTop + FTextAdjust, GetSelText, SelTextFontColor, SelTextColor);
      dsurface.FillRect(SelRect, SelTextColor);
    end;
    dsurface.TextRect(RectText, PaintRect.Left + 2 - FViewPos, PaintRect.Top + TextTop + FTextAdjust, sText, FontColor);
  end;
end;

*)

procedure TDEdit.DrawSelector(dsurface: TTexture; const vRect: TRect);
var
  sLeft, sRight: Integer;
  TextBefore: Widestring;
  TextAfter: Widestring;
  SelRect: TRect;
  sText: Widestring;
begin
 // (1) Extract part of text prior to selector
  TextBefore := '';
  TextAfter := '';
  sText := GetText;
//  if (FSelIndex > 0) then TextBefore := Copy(FText, 1, FSelIndex);
//  if (FSelIndex >= 0) then TextAfter := Copy(FText, 1, FSelIndex + 1);
  if (FSelIndex >= 0) then TextBefore := Copy(sText, FSelIndex + 1, Length(sText));
  if (FSelIndex >= 0) then TextAfter := Copy(sText, FSelIndex + 2, Length(sText));

 // (2) Determine selector position
  if Assigned(ImageCanvas) then begin
    sLeft := 2 + ImageCanvas.TextWidth(sText) - ImageCanvas.TextWidth(TextBefore) - FViewPos;
    if (TextAfter <> '') and (FSelIndex < Length(sText)) then
      sRight := 2 + ImageCanvas.TextWidth(sText) - ImageCanvas.TextWidth(TextAfter) - FViewPos
    else sRight := sLeft + (Height div 2);
  end;

  SelRect.Left := sLeft + vRect.Left;

  SelRect.Right := SelRect.Left + 2;

  SelRect.Top := FTextAdjust + vRect.Top + 2;
  SelRect.Bottom := FTextAdjust + vRect.Bottom - 2;

  SelRect := ShortRect(SelRect, vRect);

  if (SelRect.Right > SelRect.Left) and (SelRect.Bottom > SelRect.Top) then
    dsurface.FillRect(SelRect, SelectedColor);
end;
{
procedure TDEdit.DrawSelector(dsurface: TTexture; const vRect: TRect);
var
  sLeft, sRight: Integer;
  TextBefore: WideString;
  TextAfter: WideString;
  SelRect: TRect;
  sText: WideString;
  D: TTexture;
begin
 // (1) Extract part of text prior to selector
  TextBefore := '';
  TextAfter := '';
  sText := GetText;
//  if (FSelIndex > 0) then TextBefore := Copy(FText, 1, FSelIndex);
//  if (FSelIndex >= 0) then TextAfter := Copy(FText, 1, FSelIndex + 1);
  if (FSelIndex >= 0) then TextBefore := Copy(sText, FSelIndex + 1, Length(sText));
  if (FSelIndex >= 0) then TextAfter := Copy(sText, FSelIndex + 2, Length(sText));

  if Assigned(ImageCanvas) then begin
 // (2) Determine selector position
    sLeft := 2 + ImageCanvas.TextWidth(sText) - ImageCanvas.TextWidth(TextBefore) - FViewPos;
    if (TextAfter <> '') and (FSelIndex < Length(sText)) then
      sRight := 2 + ImageCanvas.TextWidth(sText) - ImageCanvas.TextWidth(TextAfter) - FViewPos
    else sRight := sLeft + (Height div 2);
  end else begin
    sLeft := 2 + Canvas.TextWidth(sText) - Canvas.TextWidth(TextBefore) - FViewPos;
    if (TextAfter <> '') and (FSelIndex < Length(sText)) then
      sRight := 2 + Canvas.TextWidth(sText) - Canvas.TextWidth(TextAfter) - FViewPos
    else sRight := sLeft + (Height div 2);
  end;
 // (3) Determine selector rectangle
  SelRect.Left := sLeft + vRect.Left;

  SelRect.Right := SelRect.Left + 2;

  SelRect.Top := FTextAdjust + vRect.Top + 2;
  SelRect.Bottom := FTextAdjust + vRect.Bottom - 2;

 // (4) Cut selector rectangle with visible rectangle
  SelRect := ShortRect(SelRect, vRect);

 // (5) Draw selector, if it is visible
  if (SelRect.Right > SelRect.Left) and (SelRect.Bottom > SelRect.Top) then
  begin
    dsurface.FillRect(SelRect, SelectedColor);
  end;
end;
}


//---------------------------------------------------------------------------

function TDEdit.InRange(X, Y: Integer): Boolean;
var
  boInrange: Boolean;
  d: TTexture;
begin
  if (X >= Left) and (X < Left + Width) and (Y >= Top) and (Y < Top + Height) then begin
    boInrange := True;
    if Assigned(FOnInRealArea) then
      FOnInRealArea(Self, X - Left, Y - Top, boInrange);
    Result := boInrange;
  end else
    Result := False;
end;

procedure TDEdit.Process;
begin
  if Assigned(FOnProcess) then FOnProcess(Self);
  FBorderCurrColor := FBorderColor;
  if Enabled then begin
    if MouseDownControl = Self then FBorderCurrColor := FDownBorder;
    if MouseMoveControl = Self then FBorderCurrColor := FHotBorder;
  end;
end;

procedure TDEdit.DirectPaint(dsurface: TTexture);
var
  I: Integer;
  d: TTexture;
  PaintRect: TRect;
  TextRect: TRect;
  PrevRect: TRect;
  BorderCurrColor: TColor;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(Self, dsurface)
  else
    if WLib <> nil then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;

  //PaintRect := ClientRect;

  D := TTexture.Create;
  D.SetSize(Width, Height);
  PaintRect := Bounds(0, 0, Width, Height);
  if FDrawBkgrnd then
    D.FillRect(PaintRect, FBkgrndColor);

  //if FDrawBkgrnd then
    //dsurface.FillRect(PaintRect, FBkgrndColor);

  if FDrawBorder then
    D.FrameRect(PaintRect, FBorderCurrColor);
    //dsurface.FrameRect(PaintRect, FBorderCurrColor);

  DrawText(D, PaintRect);
  //DrawText(dsurface, PaintRect);

  if (FocusedControl = Self) and Enabled then begin
    Inc(Ticks);
    if (FBlinkTicks = 0) or ((Ticks div FBlinkTicks) and $01 = 0) then begin
      DrawSelector(D, PaintRect);
      //DrawSelector(dsurface, PaintRect);
    end;
  end else begin
    FBeginIndex := -1;
    FEndIndex := -1;
    FSelText := '';
  end;

  dsurface.Draw(SurfaceX(Left), SurfaceY(Top), D.ClientRect, D, True);

  D.Free;

 { for I := 0 to DControls.Count - 1 do
    if TDControl(DControls[I]).Visible then
      TDControl(DControls[I]).DirectPaint(dsurface);  }
end;


constructor TDCombobox.Create(AOwner: TComponent);
begin
  inherited Create(aowner);
  FItems := TStringList.Create();
  TStringList(FItems).OnChange := ItemChanged;
  FAutoSize := False;
  Downed := False;
  FOnClick := nil;
  FEnableFocus := True;
  FClickSound := csNone;
  Caption := Name;
  FUpColor := Canvas.Font.Color;
  FHotColor := Canvas.Font.Color;
  FDownColor := Canvas.Font.Color;
  FBackgroundColor := clWhite;

  FBorderColor := $00608490;

  FHotBorder := $005894B8;
  FDownBorder := $005894B8;
  FButtonColor := $00488184;
  FCurrColor := FUpColor;

  FBackground := False;
  FBorder := True;
  FMainMenu := nil;
  FOnChange := nil;
  FOnPopup := nil;
  FAlignment := taCenter;
end;

procedure TDCombobox.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then begin
    FAlignment := Value;
  end;
end;

destructor TDCombobox.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

function TDCombobox.InRange(X, Y: Integer): Boolean;
var
  boInrange: Boolean;
  d: TTexture;
begin
  if (X >= Left) and (X < Left + Width) and (Y >= Top) and (Y < Top + Height) then begin
    boInrange := True;
    if Assigned(FOnInRealArea) then
      FOnInRealArea(Self, X - Left, Y - Top, boInrange);
    Result := boInrange;
  end else
    Result := False;
end;

procedure TDCombobox.SetUpColor(Value: TColor);
begin
  if FUpColor <> Value then begin
    FUpColor := Value;
    FCurrColor := Value;
  end;
end;

function TDCombobox.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if (not Background) and (not Result) then begin
    Result := inherited MouseMove(Shift, X, Y);
    if MouseCaptureControl = Self then
      if InRange(X, Y) then Downed := True
      else Downed := False;
    if Result and (not Downed) then FCurrColor := FHotColor;
  end;
end;

function TDCombobox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  I: Integer;
  d: TDControl;
begin
  Result := False;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl = nil) then begin
      Downed := True;
      SetDCapture(Self);
      if Assigned(FMainMenu) then begin
      //if {Downed and }(FMainMenu <> ActiveMenu) then begin

     { if SurfaceX(Left) + FMainMenu.Width > SCREENWIDTH then FMainMenu.Left := SCREENWIDTH - FMainMenu.Width
      else FMainMenu.Left := SurfaceX(Left);
      }
        FMainMenu.Left := SurfaceX(Left);
        if SurfaceY(Top + Height) + FMainMenu.Height > SCREENHEIGHT then FMainMenu.Top := SurfaceY(Top - FMainMenu.Height)
        else FMainMenu.Top := SurfaceY(Top + Height);

        if Assigned(FOnPopup) then FOnPopup(Self);

        FMainMenu.OnClick := MainMenuClick;
        FMainMenu.MenuItems := Items;
        FMainMenu.Show(Self);
      end;
     // end;
    end;
    Result := True;
  end;
end;

function TDCombobox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := False;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    ReleaseDCapture;
    if not Background then begin
      if InRange(X, Y) and Enabled then begin
        if Assigned(FOnClickSound) then FOnClickSound(Self, FClickSound);
        if Assigned(FOnClick) then FOnClick(Self, X, Y);
      end;
    end;
    Downed := False;
    Result := True;
    Exit;
  end else begin
    ReleaseDCapture;
    Downed := False;
  end;
end;

procedure TDCombobox.CreateWnd;
begin
  inherited;
  if FItems = nil then FItems := TStringList.Create();
  TStringList(FItems).OnChange := ItemChanged;
end;

function TDCombobox.GetItems: TStrings;
begin
  if csDesigning in ComponentState then Refresh;
  Result := FItems;
end;

procedure TDCombobox.SetItems(Value: TStrings);
begin
  FItems.Clear;
  FItems.Assign(Value);
end;

procedure TDCombobox.SetItemIndex(Value: Integer);
begin
  if (FMainMenu <> nil) {and (Value >= 0) and (Value < FItems.Count)} then begin
    FMainMenu.MenuItems := Items;
    FMainMenu.ItemIndex := Value;
    if (FMainMenu.ItemIndex >= 0) and (FMainMenu.ItemIndex < FMainMenu.Count) and (FMainMenu.MenuItems[FMainMenu.ItemIndex] <> '-') then
      Caption := FMainMenu.MenuItems[FMainMenu.ItemIndex];
  end;
end;

function TDCombobox.GetItemIndex: Integer;
begin
  if (FMainMenu <> nil) then
    Result := FMainMenu.ItemIndex
  else Result := -1;
end;

procedure TDCombobox.MainMenuClick(Sender: TObject; X, Y: Integer);
begin
  if (FMainMenu.ItemIndex >= 0) and (FMainMenu.MenuItems[FMainMenu.ItemIndex] <> '-') then
    Caption := FMainMenu.MenuItems[FMainMenu.ItemIndex];
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TDCombobox.ItemChanged(Sender: TObject);
begin
  //Caption := '';
  ItemIndex := GetItemIndex;
end;

procedure TDCombobox.CaptionChaged;
var
  OldSize: Integer;
  OldFontStyle: TFontStyles;
begin
  if Assigned(ImageCanvas) and Assigned(MainForm) then begin
  //if not (csDesigning in ComponentState) then begin
    OldSize := MainForm.Canvas.Font.Size;
    OldFontStyle := MainForm.Canvas.Font.Style;

    MainForm.Canvas.Font.Size := Font.Size;
    MainForm.Canvas.Font.Style := Font.Style;

    if FAutoSize then begin
      Width := ImageCanvas.TextWidth(Caption);
      Height := ImageCanvas.TextHeight('0');
    end;
    Width := Max(Width, 6);
    Height := Max(Height, 20);

    MainForm.Canvas.Font.Style := OldFontStyle;
    MainForm.Canvas.Font.Size := OldSize;
  end;
end;

procedure TDCombobox.Process;
var
  I: Integer;
begin
  if Assigned(FOnProcess) then FOnProcess(Self);
  if Downed then begin
    FCurrColor := FDownColor;
  end else
    if MouseMoveing then begin
    FCurrColor := FHotColor;
  end else begin
    FCurrColor := FUpColor;
  end;

  FBorderCurrColor := FBorderColor;
  if Enabled then begin
    if MouseDownControl = Self then FBorderCurrColor := FDownBorder;
    if MouseMoveControl = Self then FBorderCurrColor := FHotBorder;
  end;

  for I := 0 to DControls.Count - 1 do
    if TDControl(DControls[I]).Visible then
      TDControl(DControls[I]).Process;
end;

procedure TDCombobox.DirectPaint(dsurface: TTexture);
var
  I, nX, X1, Y1, X2, Y2: Integer;
  nAlpha: Integer;
  d: TTexture;
  oldColor: TColor;
  OldSize: Integer;
  OldFontStyle: TFontStyles;
  ARect: TRect;
  BorderCurrColor: TColor;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(Self, dsurface)
  else
    if WLib <> nil then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;

 {
  if Downed then begin
    FCurrColor := FDownColor;
  end else
    if MouseMoveing then begin
    FCurrColor := FHotColor;
  end else begin
    FCurrColor := FUpColor;
  end;

  BorderCurrColor := FBorderColor;
  if Enabled then begin
    if MouseDownControl = Self then BorderCurrColor := FDownBorder;
    if MouseMoveControl = Self then BorderCurrColor := FHotBorder;
  end;
  }
{  OldSize := MainForm.Canvas.Font.Size;
  OldFontStyle := MainForm.Canvas.Font.Style;

  MainForm.Canvas.Font.Size := Font.Size;
  MainForm.Canvas.Font.Style := Font.Style;

  if FAutoSize then begin
    Width := dsurface.TextWidth(Caption);
    Height := dsurface.TextHeight('0');
  end;
  Width := Max(Width, 6);
  Height := Max(Height, 20);  }

  OldSize := MainForm.Canvas.Font.Size;
  OldFontStyle := MainForm.Canvas.Font.Style;

  if FBackground then
    dsurface.FillRect(Bounds(SurfaceX(Left), SurfaceY(Top), Width, Height), FBackgroundColor);
  if FBorder then
    dsurface.FrameRect(Bounds(SurfaceX(Left), SurfaceY(Top), Width, Height), FBorderCurrColor);

  if FCaption <> '' then begin
    case FAlignment of
      taLeftJustify: nX := SurfaceX(Left);
      taRightJustify: nX := Max(SurfaceX(Left), SurfaceX(Left + (Width - 16 - dsurface.TextWidth(FCaption))));
      taCenter: nX := SurfaceX(Left) + (Width - 16 - dsurface.TextWidth(FCaption)) div 2;
    end;
    dsurface.TextOut(nX,
      SurfaceY(Top) + (Height - dsurface.TextHeight('0')) div 2, FCaption, FCurrColor);
  end;

  MainForm.Canvas.Font.Style := OldFontStyle;
  MainForm.Canvas.Font.Size := OldSize;

//画三角形
{-------------------------------------------------------------------------------}
  X1 := SurfaceX(Left) + (Width - 16) + 5;
  Y1 := SurfaceY(Top) + (Height - 5) div 2;

  if Downed then Y1 := Y1 + 1;
  X2 := X1 + 3;
  Y2 := Y1 + 4;

  for I := X1 to X1 + 6 do begin
    dsurface.Line(I, Y1, X2, Y2, FButtonColor);
  end;
{-------------------------------------------------------------------------------}

  for I := 0 to DControls.Count - 1 do
    if TDControl(DControls[I]).Visible then
      TDControl(DControls[I]).DirectPaint(dsurface);
end;

constructor TDCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(aowner);
  FButtonStyle := bsLock;
  EnableFocus := False;
  FUpColor := clSilver;
  FHotColor := clWhite;
  FDownColor := clWhite;
  FAlignment := taRightJustify;
end;

procedure TDCheckBox.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then begin
    FAlignment := Value;
  end;
end;

function TDCheckBox.InRange(X, Y: Integer): Boolean;
var
  boInrange: Boolean;
  d: TTexture;
begin
  if (X >= Left) and (X < Left + Width) and (Y >= Top) and (Y < Top + Height) then begin
    boInrange := True;
    if Assigned(FOnInRealArea) then
      FOnInRealArea(Self, X - Left, Y - Top, boInrange);
    Result := boInrange;
  end else
    Result := False;
end;

procedure TDCheckBox.SetImgIndex(Lib: TGameImages; Index: Integer);
var
  d: TTexture;
begin
  if Lib <> nil then begin
    d := Lib.Images[Index];
    WLib := Lib;
    FaceIndex := Index;
    if d <> nil then begin
      if Assigned(ImageCanvas) then
        Width := d.Width + ImageCanvas.TextWidth(Caption)
      else
        Width := d.Width;
      Height := d.Height;
    end;
  end;
end;

procedure TDCheckBox.CaptionChaged;
begin
  if Assigned(ImageCanvas) then begin
    Width := Max(Width, Width + ImageCanvas.TextWidth(Caption));
    Height := Max(Height, Height + ImageCanvas.TextHeight('0'));
  end;
end;

procedure TDCheckBox.Process;
begin
  if Assigned(FOnProcess) then FOnProcess(Self);
  Font.Color := FUpColor;

  if Enabled then begin
    if MouseDownControl = Self then Font.Color := FDownColor;
    if MouseMoveControl = Self then Font.Color := FHotColor;
  end;
end;

procedure TDCheckBox.DirectPaint(dsurface: TTexture);
var
  I: Integer;
  d: TTexture;
  X: Integer;
begin
  d := nil;
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(Self, dsurface);

  X := SurfaceX(Left);
  if (WLib <> nil) and (Caption <> '') then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      Width := d.Width + dsurface.TextWidth(Caption);
      case FAlignment of
        taLeftJustify: ;
        taRightJustify: X := X + d.Width;
      end;
    end;
  end;

  dsurface.TextOut(X, SurfaceY(Top) + (Height - dsurface.TextHeight('0')) div 2, FCaption, Font.Color);

  for I := 0 to DControls.Count - 1 do
    if TDControl(DControls[I]).Visible then
      TDControl(DControls[I]).DirectPaint(dsurface);
end;

{-------------------------------------------------------------------------------}

constructor TDScroll.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLeft := nil;
  FRight := nil;
  FCenter := nil;
  Width := 20;
  Height := 60;

  FIncrement := 16;
  FAutoScroll := False;
  FDControl := nil;
  FOnScroll := nil;
  FMax := 0;
  FMin := 0;
  FPosition := 0;
  FScrollValue := 0;
  FBorder := False;
  FBackground := False;
  FScroll := True;
  FEnableFocus := False;
end;

destructor TDScroll.Destroy;
begin
  if FLeft <> nil then FLeft.Free;
  if FRight <> nil then FRight.Free;
  if FCenter <> nil then FCenter.Free;
  inherited Destroy;
end;

procedure TDScroll.SetColors(Value: TColors);
begin
  FColors.AssignTo(Value);
end;

function TDScroll.GetLeftButton: TDButton;
begin
  if FLeft = nil then begin
    FLeft := TDButton.Create(Self);
    FLeft.DParent := Self;
    FLeft.Width := 0;
    FLeft.Height := 0;

    //FLeft.OnClick := LeftOnClickEx;
    FLeft.OnMouseDown := LeftOnMouseDown;
    FLeft.Left := Width - FLeft.Width - 1;
    FLeft.Top := 1;
    FLeft.Visible := FScroll;
  end;

  Result := FLeft;
end;

function TDScroll.GetRightButton: TDButton;
begin
  if FRight = nil then begin
    FRight := TDButton.Create(Self);
    FRight.DParent := Self;
    FRight.Width := 0;
    FRight.Height := 0;
    FRight.OnMouseDown := RightOnMouseDown;
    //FRight.OnClick := RightOnClickEx;
    FRight.Left := Width - FRight.Width - 1;
    FRight.Top := Height - FRight.Height - 1;
    FRight.Visible := FScroll;
  end;

  Result := FRight;
end;

function TDScroll.GetCenterButton: TDButton;
begin
  if FCenter = nil then begin
    FCenter := TDButton.Create(Self);
    FCenter.DParent := Self;
    FCenter.Width := 0;
    FCenter.Height := 0;
    FCenter.Left := Width - FCenter.Width - 1;
    FCenter.Top := LeftButton.Top + LeftButton.Height;
    FCenter.OnMouseMove := CenterOnMouseMove;
    FCenter.OnMouseDown := CenterOnMouseDown;
    FCenter.OnMouseUp := CenterOnMouseUp;
    FCenter.Visible := FScroll;
  end;

  Result := FCenter;
end;

procedure TDScroll.CenterOnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  at, nScrollPos, nScrollSize, OldPosition: Integer;
begin
  if FDControl = nil then Exit;
  if (FScrollValue <> Y) and (ssLeft in Shift) and FCenter.Downed and (FMax > FDControl.Height) then begin
    at := FCenter.Top + (Y - FScrollValue);
    if (at < FLeft.Top + FLeft.Height) then at := FLeft.Top + FLeft.Height;
    if (at + FCenter.Height > FRight.Top) then at := FRight.Top - FCenter.Height;
    FCenter.Top := at;
    nScrollPos := FCenter.Top - FLeft.Top - FLeft.Height;
    nScrollSize := FRight.Top - FLeft.Top - FLeft.Height - FCenter.Height;
    if nScrollSize <> 0 then begin
      if FMax > FDControl.Height then begin
        OldPosition := FPosition;
        FPosition := Round((FMax - FDControl.Height) * nScrollPos / nScrollSize);
      end else FCenter.Top := FLeft.Top + FLeft.Height;
      if Assigned(FOnScroll) then FOnScroll(Self, FPosition - OldPosition);
    end else FCenter.Top := FLeft.Top + FLeft.Height;
    FScrollValue := Y;
  end;
end;

procedure TDScroll.LeftOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Previous;
end;

procedure TDScroll.RightOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Next;
end;

procedure TDScroll.CenterOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FScrollValue := Y;
end;

procedure TDScroll.CenterOnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TDScroll.LeftOnClickEx(Sender: TObject; X, Y: Integer);
begin

end;

procedure TDScroll.RightOnClickEx(Sender: TObject; X, Y: Integer);
begin

end;

procedure TDScroll.SetDControl(D: TDControl);
begin
  if FDControl <> D then begin
    FDControl := D;
    {if FDControl <> nil then begin
      FBackSurface.SetSize(FDControl.SurfaceX(FDControl.Left) + FDControl.Width, FDControl.SurfaceY(FDControl.Top) + FDControl.Height);
    end;}
  end;
end;

function TDScroll.InRange(X, Y: Integer): Boolean;
var
  boInrange: Boolean;
begin
  if (X >= Left) and (X < Left + Width) and (Y >= Top) and (Y < Top + Height) then begin
    boInrange := True;
    if Assigned(FOnInRealArea) then
      FOnInRealArea(Self, X - Left, Y - Top, boInrange);
    Result := boInrange;
  end else
    Result := False;
end;

procedure TDScroll.SetPosition(Value: Integer);
var
  nScroll, OldPosition: Integer;
begin
  if FDControl = nil then Exit;
  //Showmessage(Format('FPosition:%d Value:%d',[FPosition , Value]));
  if (FPosition <> Value) and (Value > 0) and (FMax > FDControl.Height) and (FIncrement > 0) then begin
    //Showmessage('TDScroll.SetPosition1');
    OldPosition := FPosition;
    FPosition := Math.Min(Value div FIncrement * FIncrement, Math.Max(FMax - FDControl.Height, 0));
    if FMax > FDControl.Height then begin
      //Showmessage('TDScroll.SetPosition2');
      nScroll := FRight.Top - FLeft.Top - FLeft.Height - FCenter.Height;
      FCenter.Top := FLeft.Top + FLeft.Height + Round(FPosition * nScroll / (FMax - FDControl.Height));

      if FPosition >= FMax - FDControl.Height then
        FCenter.Top := FRight.Top - FCenter.Height;

      if FCenter.Top < FLeft.Top + FLeft.Height then
        FCenter.Top := FLeft.Top + FLeft.Height;

      if FPosition <= 0 then
        FCenter.Top := FLeft.Top + FLeft.Height;
    end else FCenter.Top := FLeft.Top + FLeft.Height;
    if Assigned(FOnScroll) then FOnScroll(Self, FPosition - OldPosition);
  end;
end;

procedure TDScroll.SetMin(Value: Integer);
begin

end;

procedure TDScroll.SetMax(Value: Integer);
var
  nScroll, OldPosition: Integer;
begin
  if FDControl = nil then Exit;
  if FMax <> Value then begin
    FMax := Value;
      //DebugOutStr(Name+' FMax:'+IntToStr(FMax)+' FDControl.Height:'+IntToStr(FDControl.Height));
    //FBackSurface.SetSize(FDControl.SurfaceX(FDControl.Left) + FDControl.Width, FDControl.SurfaceY(FDControl.Top) + FDControl.Height + FMax);
    OldPosition := FPosition;
    if (FMax > FDControl.Height) and (FPosition > FMax - FDControl.Height) then FPosition := FMax - FDControl.Height;

    if FMax <= FDControl.Height then FPosition := 0;
    if (FMax > FDControl.Height) and (FPosition > 0) then begin
      nScroll := FRight.Top - FLeft.Top - FLeft.Height - FCenter.Height;
      FCenter.Top := FLeft.Top + FLeft.Height + Round(FPosition * nScroll / (FMax - FDControl.Height));

      if FPosition >= FMax - FDControl.Height then
        FCenter.Top := FRight.Top - FCenter.Height;

      if FCenter.Top < FLeft.Top + FLeft.Height then
        FCenter.Top := FLeft.Top + FLeft.Height;
      if FPosition <= 0 then
        FCenter.Top := FLeft.Top + FLeft.Height;
    end else FCenter.Top := FLeft.Top + FLeft.Height;
    if Assigned(FOnScroll) then FOnScroll(Self, FPosition - OldPosition);
  end;
end;

procedure TDScroll.First;
var
  OldPosition: Integer;
begin
  FCenter.Top := FLeft.Top + FLeft.Height;
  OldPosition := FPosition;
  FPosition := 0;
  if OldPosition <> FPosition then
    if Assigned(FOnScroll) then FOnScroll(Self, FPosition - OldPosition);
end;

procedure TDScroll.Last;
var
  OldPosition: Integer;
begin
  if FDControl = nil then Exit;
  if (FMax > FDControl.Height) and (FPosition < FMax - FDControl.Height) then begin
    FCenter.Top := FRight.Top - FCenter.Height;
    OldPosition := FPosition;
    FPosition := FMax - FDControl.Height;
    if OldPosition <> FPosition then
      if Assigned(FOnScroll) then FOnScroll(Self, FPosition - OldPosition);
  end else FCenter.Top := FLeft.Top + FLeft.Height;
end;

procedure TDScroll.Next;
var
  I, nScroll, OldPosition: Integer;
begin
  if FDControl = nil then Exit;

  if (FIncrement > 0) and (FMax > FDControl.Height) and (FPosition < FMax - FDControl.Height) then begin
    OldPosition := FPosition;
    if FIncrement + FPosition < FMax - FDControl.Height then begin
      Inc(FPosition, FIncrement);
    end else begin
      FPosition := FMax - FDControl.Height;
    end;

    if FMax > FDControl.Height then begin
      nScroll := FRight.Top - FLeft.Top - FLeft.Height - FCenter.Height;
      FCenter.Top := FLeft.Top + FLeft.Height + Round(FPosition * nScroll / (FMax - FDControl.Height));

      if FPosition >= FMax - FDControl.Height then
        FCenter.Top := FRight.Top - FCenter.Height;

      if FCenter.Top < FLeft.Top + FLeft.Height then
        FCenter.Top := FLeft.Top + FLeft.Height;
      if FPosition <= 0 then
        FCenter.Top := FLeft.Top + FLeft.Height;
    end else FCenter.Top := FLeft.Top + FLeft.Height;

    if Assigned(FOnScroll) then FOnScroll(Self, FPosition - OldPosition);
  end;
end;

procedure TDScroll.Previous;
var
  I, nScroll, OldPosition: Integer;
  nValue: Integer;
begin
  if FDControl = nil then Exit;
  if (FIncrement > 0) and (FPosition > 0) then begin
    OldPosition := FPosition;
    if FPosition >= FIncrement then begin
      nValue := FIncrement;
      Dec(FPosition, FIncrement);
    end else begin
      nValue := FIncrement - FPosition;
      FPosition := 0;
    end;
    if FMax <= FDControl.Height then FPosition := 0;

    if FMax > FDControl.Height then begin
      nScroll := FRight.Top - FLeft.Top - FLeft.Height - FCenter.Height;
      FCenter.Top := FLeft.Top + FLeft.Height + Round(FPosition * nScroll / (FMax - FDControl.Height));

      if FPosition >= FMax - FDControl.Height then
        FCenter.Top := FRight.Top - FCenter.Height;

      if FCenter.Top < FLeft.Top + FLeft.Height then
        FCenter.Top := FLeft.Top + FLeft.Height;
      if FPosition <= 0 then
        FCenter.Top := FLeft.Top + FLeft.Height;
    end else FCenter.Top := FLeft.Top + FLeft.Height;
    if Assigned(FOnScroll) then FOnScroll(Self, FPosition - OldPosition);
  end;
end;

function TDScroll.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  if Enabled then begin
    Result := inherited MouseMove(Shift, X, Y);
    if (not Background) and (not Result) then begin
      if MouseCaptureControl = Self then
        if InRange(X, Y) then Downed := True
        else Downed := False;
    end;
  end;
end;

function TDScroll.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  at, nScrollPos, nScrollSize, nY, OldPosition: Integer;
begin
  Result := False;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl = nil) then begin
      Downed := True;
      SetDCapture(Self);
      nY := SurfaceY(Y);
      if (nY > FLeft.SurfaceY(FLeft.Top)) and (nY < FRight.SurfaceY(FRight.Top)) and (ssLeft in Shift) and (FMax > FDControl.Height) then begin
        at := FCenter.LocalY(nY);
        if (at < FLeft.Top + FLeft.Height) then at := FLeft.Top + FLeft.Height;
        if (at + FCenter.Height > FRight.Top) then at := FRight.Top - FCenter.Height;
        FCenter.Top := at;
        nScrollPos := FCenter.Top - FLeft.Top - FLeft.Height;
        nScrollSize := FRight.Top - FLeft.Top - FLeft.Height - FCenter.Height;
        if nScrollSize <> 0 then begin
          if FMax > FDControl.Height then begin
            OldPosition := FPosition;
            FPosition := Round((FMax - FDControl.Height) * nScrollPos / nScrollSize);
          end else FCenter.Top := FLeft.Top + FLeft.Height;
          if Assigned(FOnScroll) then FOnScroll(Self, FPosition - OldPosition);
        end else FCenter.Top := FLeft.Top + FLeft.Height;
      end;
    end;
    Result := True;
  end;
end;

function TDScroll.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  I: Integer;
  d: TDControl;
  boDown: Boolean;
begin
  Result := False;
  ReleaseDCapture;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    if not Background then begin
      if InRange(X, Y) then begin
        Downed := False;
        //if Assigned(FOnClickSound) then FOnClickSound(Self, FClickSound);
        if Assigned(FOnClick) then FOnClick(Self, X, Y);
      end;
    end;
    Downed := False;
    Result := True;
    Exit;
  end else begin
    //ReleaseDCapture;
    Downed := False;
  end;
end;

procedure TDScroll.Process;
begin
  if Assigned(FOnProcess) then FOnProcess(Self);

end;

function TDScroll.MouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Next;
  Result := inherited MouseWheelDown(Shift, MousePos);

  Result := True;
 { Result := False;
  if inherited MouseWheelDown(Shift, MousePos) then begin

  end; }
end;

function TDScroll.MouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Previous;
  Result := inherited MouseWheelUp(Shift, MousePos);
  Result := True;
  {Result := False;
  if inherited MouseWheelUp(Shift, MousePos) then begin
    if FCenter.Visible then Previous;
    Result := True;
  end; }
end;

function TDScroll.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := inherited KeyDown(Key, Shift);
 { if inherited KeyDown(Key, Shift) then begin
    Result := True;
    case Key of
      VK_UP: Position := 0;
      VK_DOWN: Position := Max;
      VK_PRIOR: Previous;
      VK_NEXT: Next;
    else Result := False;
    end;
    //showmessage('TDScroll.KeyDown');
  end;  }
end;

procedure TDScroll.DirectPaint(dsurface: TTexture);
var
  I: Integer;
  rc: TRect;
  nX, nY, nWidth, nHeight: Integer;
  d: TTexture;
  DControl: TDControl;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(Self, dsurface)
  else
    if (WLib <> nil) and FScroll then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;

  {if FDControl <> nil then begin
    FBackSurface.SetSize(FDControl.SurfaceX(FDControl.Left) + FDControl.Width, FDControl.SurfaceY(FDControl.Top) + FMax);
    FBackSurface.Fill(0);

    for I := 0 to FDControl.DControls.Count - 1 do begin
      DControl := TDControl(FDControl.DControls[I]);
      if DControl.Visible then begin
        DControl.DirectPaint(FBackSurface);
      end;
    end;
    //FBackSurface.FrameRect(Bounds(5,5,FBackSurface.Width-5,FBackSurface.Height-5),clGreen);
    dsurface.Draw(FDControl.SurfaceX(FDControl.Left),
      FDControl.SurfaceY(FDControl.Top),
      Bounds(FDControl.SurfaceX(FDControl.Left), FDControl.SurfaceY(FDControl.Top) , FDControl.Width, Math.Min(FDControl.Height, FMax)),
      FBackSurface);
  end; }

  //if FScroll then begin
    {if Assigned(FLeft) then FLeft.DirectPaint(dsurface);
    if Assigned(FRight) then FRight.DirectPaint(dsurface);
    if Assigned(FCenter) then FCenter.DirectPaint(dsurface); }
    //if Assigned(FLeft) then
      //dsurface.FrameRect(Bounds(SurfaceX(Left + Width - FLeft.Width - 1), SurfaceY(Top), FLeft.Width, Height), FColors.Border);
  //end;
  if FScroll then
    for I := 0 to DControls.Count - 1 do
      if TDControl(DControls[I]).Visible then
        TDControl(DControls[I]).DirectPaint(dsurface);
{  if FBorder then
    dsurface.FrameRect(Bounds(SurfaceX(Left), SurfaceY(Top), Width, Height), FColors.Up);
  if FBackground then
    dsurface.FillRect(Bounds(SurfaceX(Left), SurfaceY(Top), Width, Height), FColors.Background);  }
end;
{-------------------------------------------------------------------------------}

constructor TDPageControl.Create(AOwner: TComponent);
begin
  inherited Create(Aowner);
  Tabs := TList.Create;
  FActivePage := 0;
  Width := 120;
  Height := 120;
  FTabRect := Bounds(Left, Top, Width, Height);
end;

destructor TDPageControl.Destroy;
begin
  Tabs.Free;
  inherited Destroy;
end;

procedure TDPageControl.SetActivePage(Value: Integer);
var
  I: Integer;
begin
  if (FActivePage <> Value) and (Value >= 0) and (Value < DControls.Count) then begin
    FActivePage := Value;
    for I := 0 to Tabs.Count - 1 do begin
      TDControl(Tabs[I]).Visible := False;
      if csDesigning in ComponentState then begin
        TDControl(Tabs[I]).Width := 0;
        TDControl(Tabs[I]).Height := 0;
      end;
    end;
    TDControl(Tabs[FActivePage]).Visible := True;
    TDControl(Tabs[FActivePage]).Left := FTabRect.Left;
    TDControl(Tabs[FActivePage]).Top := FTabRect.Top;
    TDControl(Tabs[FActivePage]).Width := FTabRect.Right;
    TDControl(Tabs[FActivePage]).Height := FTabRect.Bottom;
    TDControl(Tabs[FActivePage]).BringToFront;
  end;
end;

procedure TDPageControl.Add(D: TDControl);
begin
  Tabs.Add(D);
end;

procedure TDPageControl.Delete(D: TDControl);
begin
  Tabs.Remove(D);
end;

procedure TDPageControl.SetTabLeft(Value: Integer);
begin
  FTabRect.Left := Min(Value, Width);
end;

function TDPageControl.GetTabLeft: Integer;
begin
  Result := FTabRect.Left;
end;

function TDPageControl.GetTabTop: Integer;
begin
  Result := FTabRect.Top;
end;

procedure TDPageControl.SetTabTop(Value: Integer);
begin
  FTabRect.Top := Min(Value, Height);
end;

function TDPageControl.GetTabWidth: Integer;
begin
  Result := FTabRect.Right;
end;

procedure TDPageControl.SetTabWidth(Value: Integer);
begin
  FTabRect.Right := Min(Value, Width);
end;

function TDPageControl.GetTabHeight: Integer;
begin
  Result := FTabRect.Bottom;
end;

procedure TDPageControl.SetTabHeight(Value: Integer);
begin
  FTabRect.Bottom := Min(Value, Height);
end;

{-------------------------------------------------------------------------------}

constructor TLines.Create;
begin
  inherited;
  FTop := High(Integer);
  FLeft := 0;
  FWidth := 0;
  FHeight := 0;
  FItemSize := 0;
  FData := nil;
  FVisible := True;
end;

destructor TLines.Destroy;
begin
  inherited;
end;

function TLines.Add(const S: string): Integer;
begin
  Result := inherited Add(S);
end;

function TLines.AddObject(const S: string; AObject: TObject): Integer;
var
  D: TDControl;
begin
  Result := inherited AddObject(S, AObject);
  if Result >= 0 then begin
    if AObject <> nil then begin
      D := TDControl(AObject);
      FWidth := FWidth + D.Width;

      if FTop >= D.SurfaceY(D.Top) then
        FTop := D.SurfaceY(D.Top);

      if FHeight < D.SurfaceY(D.Top) + D.Height then
        FHeight := D.SurfaceY(D.Top) + D.Height;

      if FItemSize < D.Height then
        FItemSize := D.Height;
      {DebugOutStr(TDControl(AObject).Name+' D.SurfaceY(D.Top) + D.Height + D.PosY:'+IntToStr(D.SurfaceY(D.Top) + D.Height + D.PosY)
      +' FHeight:'+IntToStr(FHeight));}
    end;
  end;
end;

procedure TLines.Clear;
begin
  inherited;
  FTop := High(Integer);
  FLeft := 0;
  FWidth := 0;
  FHeight := 0;
  FItemSize := 0;
end;

function TLines.GetHeight: Integer;
var
  I: Integer;
  D: TDControl;
begin
  FTop := High(Integer);
  FLeft := 0;
  FWidth := 0;
  FHeight := 0;
  FItemSize := 0;
  for I := 0 to Count - 1 do begin
    D := TDControl(Objects[I]);
    if D <> nil then begin
      FWidth := FWidth + D.Width;

      if FTop >= D.SurfaceY(D.Top) then
        FTop := D.SurfaceY(D.Top);

      if FHeight < D.SurfaceY(D.Top) + D.Height then
        FHeight := D.SurfaceY(D.Top) + D.Height;

      if FItemSize < D.Height then
        FItemSize := D.Height;
      {DebugOutStr(TDControl(AObject).Name+' TDControl(AObject).Height:'+IntToStr(TDControl(AObject).Height)
      +' FHeight:'+IntToStr(FHeight));}
    end;
  end;
  Result := FHeight;
end;

procedure TLines.Delete(Index: Integer);
var
  I: Integer;
  D: TDControl;
begin
  inherited Delete(Index);
  FWidth := 0;
  FHeight := 0;
  FTop := High(Integer);
  FItemSize := 0;
  for I := 0 to Count - 1 do begin
    D := TDControl(Objects[I]);
    if D <> nil then begin
      FWidth := FWidth + D.Width;

      if FTop >= D.SurfaceY(D.Top) then
        FTop := D.SurfaceY(D.Top);

      if FHeight < D.SurfaceY(D.Top) + D.Height then
        FHeight := D.SurfaceY(D.Top) + D.Height;

      if FItemSize < D.Height then
        FItemSize := D.Height;
      {DebugOutStr(TDControl(AObject).Name+' TDControl(AObject).Height:'+IntToStr(TDControl(AObject).Height)
      +' FHeight:'+IntToStr(FHeight));}
    end;
  end;
end;

function TLines.GetText: string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Count - 1 do
    Result := Result + Strings[I];
end;

constructor TDMemo.Create(AOwner: TComponent);
begin
  inherited Create(aowner);
  FLines := TList.Create;
  FBackSurface := TTexture.Create;
  FBackSurface.SetSize(Width, Height);

  Downed := False;
  FOnClick := nil;
  FEnableFocus := False;
  FClickSound := csNone;
  Caption := Name;
  Width := 100;
  Height := 100;

  FColors := TColors.Create;
  FColors.Background := clWhite;
  FColors.Border := $00488184;
  FColors.Hot := $0078B3B6;
  //FColors.Down := $0078B3B6;
  FColors.Selected := clNavy;
  FColors.Down := clBtnFace;

  FBackground := False;
  FBorder := False;
  FMainMenu := nil;


  FDrawItemIndex := 0;

  FItemIndex := -1;
  FRowSelect := False;
  FMaxHeight := 0;
  FMaxWidth := 0;
  FItemSize := 12; //Edited By Lyncus 2/02/2011(Old Value:  16;)
  FSpareSize := 0;
  {if not (csDesigning in ComponentState) then begin

  end;}
end;

destructor TDMemo.Destroy;
var
  I: Integer;
begin
  for I := 0 to FLines.Count - 1 do begin
    TStringList(FLines.Items[I]).Free;
  end;
  FLines.Free;
  FColors.Free;
  FBackSurface.Free;
  inherited Destroy;
end;

procedure TDMemo.Clear;
var
  I, II: Integer;
  ItemList: TStringList;
begin
  FDrawItemIndex := -1;
  FMaxHeight := 0;
  FMaxWidth := 0;
  for I := 0 to FLines.Count - 1 do begin
    ItemList := TStringList(FLines.Items[I]);
    for II := 0 to ItemList.Count - 1 do begin
      TDControl(ItemList.Objects[II]).Free;
    end;
    ItemList.Free;
  end;
  FLines.Clear;
  if FDScroll <> nil then begin
    FDScroll.Position := 0;
    FDScroll.Max := 0;
  end;
end;

procedure TDMemo.RefPostion(ALeft, ATop: Integer);
{var
  I, II, nTop, Increment: Integer;
  ItemList: TLines;
  D: TDControl; }

begin
  {Increment := Top - ATop;

  nTop := SurfaceY(Top);
  FDrawItemIndex := -1;
  for I := 0 to FLines.Count - 1 do begin
    ItemList := TLines(FLines.Items[I]);
    if ItemList.Visible then begin
      ItemList.GetHeight;
      ItemList.Top := ItemList.Top - Increment;
      ItemList.Height := ItemList.Height - Increment;
      if (ItemList.Height > nTop) and (ItemList.Top < nTop + Height) then begin
        if FDrawItemIndex = -1 then FDrawItemIndex := I;
        for II := 0 to ItemList.Count - 1 do begin
          D := TDControl(ItemList.Objects[II]);
          D.Top := D.Top - Increment;
          D.Visible := True;
        end;
      end else begin
        for II := 0 to ItemList.Count - 1 do begin
          D := TDControl(ItemList.Objects[II]);
          D.Top := D.Top - Increment;
          D.Visible := False;
        end;
      end;
    end;
  end;}
end;

procedure TDMemo.RefSize(AWidth, AHeight: Integer);

begin

end;

procedure TDMemo.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  OLeft, OTop, OWidth, OHeight: Integer;
begin
  OLeft := Left;
  OTop := Top;
  OWidth := Width;
  OHeight := Height;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  if (OLeft <> Left) or (OTop <> Top) then RefPostion(OLeft, OTop);
  if (OWidth <> Width) or (OHeight <> Height) then RefSize(OWidth, OHeight);
end;

function TDMemo.GetCount: Integer;
begin
  Result := FLines.Count;
end;

function TDMemo.GetItems(Index: Integer): TStringList;
begin
  Result := TStringList(FLines.Items[Index]);
end;

procedure TDMemo.SetMaxLineHeight(Value: Integer);
begin
  if FMaxHeight <> Value then begin
    FMaxHeight := Value;
    if FDScroll <> nil then
      FDScroll.Max := GetMaxLineHeight + FSpareSize;
    OnScroll(Self, 0);
  end;
end;

function TDMemo.GetMaxLineHeight: Integer;
var
  I, II, nPosition: Integer;
  nHeight: Integer;
  ItemList: TLines;
begin
  Result := 0;
  nHeight := 0;
  nPosition := 0;

  if FDScroll <> nil then
    nPosition := FDScroll.Position;

  for I := 0 to FLines.Count - 1 do begin
    ItemList := TLines(FLines.Items[I]);
    if ItemList.Visible then
      nHeight := Math.Max(ItemList.Height + nPosition, nHeight);
    //DebugOutStr(Name+' GetMaxHeight ItemList.Height:'+IntToStr(ItemList.Height));
  end;
  Result := Math.Max(Math.Max(nHeight - Self.SurfaceY(Top), 0), FMaxHeight);
end;

procedure TDMemo.Delete(Index: Integer);
var
  I, II, nTop, nItemSize: Integer;
  ItemList: TLines;
  D: TDControl;
begin
  if (Index >= 0) and (Index < Count) then begin
    ItemList := FLines.Items[Index];
    nItemSize := ItemList.ItemSize;
    FLines.Delete(Index);

    if (FDScroll <> nil) then begin
      FDScroll.Position := FDScroll.Position - nItemSize;
      FDScroll.Max := FDScroll.Max - nItemSize;
      //DebugOutStr('2 DScroll.Max:'+IntToStr(FDScroll.Max)+' DScroll.Position:'+IntToStr(FDScroll.Position)+' nItemSize:'+IntToStr(nItemSize));
    end;

    nTop := SurfaceY(Top);
    FDrawItemIndex := -1;
    for I := Index to FLines.Count - 1 do begin
      ItemList := TLines(FLines.Items[I]);
      if ItemList.Visible then begin
        ItemList.GetHeight;
        ItemList.Top := ItemList.Top - nItemSize;
        ItemList.Height := ItemList.Height - nItemSize;
        if (ItemList.Height > nTop) and (ItemList.Top < nTop + Height) then begin
          if FDrawItemIndex = -1 then FDrawItemIndex := I;
          for II := 0 to ItemList.Count - 1 do begin
            D := TDControl(ItemList.Objects[II]);
            D.Top := D.Top - nItemSize;
            D.Visible := True;
          end;
        end else begin
          for II := 0 to ItemList.Count - 1 do begin
            D := TDControl(ItemList.Objects[II]);
            D.Top := D.Top - nItemSize;
            D.Visible := False;
          end;
        end;
      end;
    end;
  end;
end;


{var
  I, II: Integer;
  nHeight: Integer;
  ItemList: TLines;
begin
  if (Index >= 0) and (Index < Count) then begin
    FLines.Delete(Index);

    if FDScroll <> nil then
      FDScroll.Max := GetMaxLineHeight + FSpareSize;
    OnScroll(Self, 0);
  end;
end; }

procedure TDMemo.GetItemIndex(Y: Integer);
var
  I, nHeight, nTop: Integer;
  ItemList: TLines;
begin
  FItemIndex := -1;
  if FDrawItemIndex >= 0 then begin
    nTop := SurfaceY(Top);
    for I := FDrawItemIndex to FLines.Count - 1 do begin
      ItemList := TLines(FLines.Items[I]);
      //ItemList.GetHeight;
      if ItemList.Visible then
        if (Y >= ItemList.Top - nTop) and (Y <= (ItemList.Top - nTop) + (ItemList.Height - ItemList.Top)) then begin
          FItemIndex := I;
       { DebugOutStr(Name+' OnScroll nIndex1:'+IntToStr(nIndex)+
        ' FDScroll.Position:'+IntToStr(FDScroll.Position)+' nTop:'+IntToStr(nTop)+
        ' nBottom:'+IntToStr(nBottom)+
        ' ItemList.MinTop:'+IntToStr(ItemList.MinTop));}
          break;
        end;
    end;
  end;
end;

procedure TDMemo.OnScroll(Sender: TObject; Increment: Integer);
var
  I, II, nTop: Integer;
  ItemList: TLines;
  D: TDControl;
begin
  nTop := SurfaceY(Top);
  FDrawItemIndex := -1;
  for I := 0 to FLines.Count - 1 do begin
    ItemList := TLines(FLines.Items[I]);
    if ItemList.Visible then begin
      ItemList.GetHeight;
      ItemList.Top := ItemList.Top - Increment;
      ItemList.Height := ItemList.Height - Increment;
      if (ItemList.Height > nTop) and (ItemList.Top < nTop + Height) then begin
        if FDrawItemIndex = -1 then FDrawItemIndex := I;
        for II := 0 to ItemList.Count - 1 do begin
          D := TDControl(ItemList.Objects[II]);
          D.Top := D.Top - Increment;
          D.Visible := True;
        end;
      end else begin
        for II := 0 to ItemList.Count - 1 do begin
          D := TDControl(ItemList.Objects[II]);
          D.Top := D.Top - Increment;
          D.Visible := False;
        end;
      end;
    end;
  end;
end;

procedure TDMemo.RefreshPos;
var
  I, II, nTop, nHeight: Integer;
  ItemList: TLines;
  D: TDControl;
begin
  nTop := SurfaceY(Top);
  nHeight := 0;
  for I := 0 to FLines.Count - 1 do begin
    ItemList := TLines(FLines.Items[I]);
    ItemList.Top := 0;
    ItemList.Height := 0;
    if ItemList.Visible then begin
      for II := 0 to ItemList.Count - 1 do begin
        D := TDControl(ItemList.Objects[II]);
        D.Top := nHeight;
        D.Visible := True;
      end;
      nHeight := ItemList.GetHeight - nTop;
    end;
  end;
  if (FDScroll <> nil) and (FDScroll.Position > 0) then
    OnScroll(Self, FDScroll.Position);
end;

procedure TDMemo.SetColors(Value: TColors);
begin
  FColors.AssignTo(Value);
end;

procedure TDMemo.SetItemIndex(Value: Integer);
begin
  FItemIndex := Value;
end;

function TDMemo.InRange(X, Y: Integer): Boolean;
var
  boInrange: Boolean;
begin
  if (X >= Left) and (X < Left + Width) and (Y >= Top) and (Y < Top + Height) then begin
    boInrange := True;
    if Assigned(FOnInRealArea) then
      FOnInRealArea(Self, X - Left, Y - Top, boInrange);
    Result := boInrange;
  end else
    Result := False;
end;



function TDMemo.Add: TStringList;
begin
  Result := TLines.Create;
  FLines.Add(Result);
end;

function TDMemo.AddSuItem(SubItems: TStringList; DControl: TDControl): TDControl;
begin
  SubItems.AddObject(DControl.Caption, DControl);
  if FDScroll <> nil then begin
    FDScroll.Max := GetMaxLineHeight + FSpareSize;
  end;
  OnScroll(Self, 0);
  Result := DControl;
end;

function TDMemo.GetStrings(Index: Integer): string;
var
  ItemList: TLines;
begin
  ItemList := TLines(Items[Index]);
  Result := ItemList.Text;
end;

function TDMemo.GetText: string;
var
  I: Integer;
  ItemList: TLines;
  SaveList: TStringList;
begin
  SaveList := TStringList.Create;
  try
    for I := 0 to Count - 1 do begin
      ItemList := TLines(Items[I]);
      SaveList.Add(ItemList.Text);
    end;
    Result := SaveList.Text;
  finally
    SaveList.Free;
  end;
end;

procedure TDMemo.SetText(Value: string);
var
  I, II, nTop, nPosition: Integer;
  DLabel: TDLabel;
  ItemList: TStringList;
  LoadList: TStringList;
  D: TDControl;
begin
  for I := 0 to FLines.Count - 1 do begin
    ItemList := TLines(FLines.Items[I]);
    for II := 0 to ItemList.Count - 1 do begin
      D := TDControl(ItemList.Objects[II]);
      D.Free;
    end;
    ItemList.Free;
  end;
  FLines.Clear;

  nPosition := 0;
  if FDScroll <> nil then nPosition := FDScroll.Position;

  LoadList := TStringList.Create;
  try
    Clear;
    LoadList.Text := Value;
    for I := 0 to LoadList.Count - 1 do begin
      nTop := MaxHeight - nPosition;
      ItemList := Add;
      DLabel := TDLabel.Create(Self);
      DLabel.Caption := LoadList.Strings[I];
      DLabel.DParent := Self;
      DLabel.Left := TLines(ItemList).Width;
      DLabel.Top := nTop;
      AddSuItem(ItemList, DLabel);
    end;
  finally
    LoadList.Free;
  end;
end;

procedure TDMemo.LoadFromFile(const FileName: string);
var
  I, II, nTop, nOldTop, nPosition, nHeight: Integer;
  DLabel: TDLabel;
  ItemList: TStringList;
  LoadList: TStringList;
  D: TDControl;
begin
  for I := 0 to FLines.Count - 1 do begin
    ItemList := TLines(FLines.Items[I]);
    for II := 0 to ItemList.Count - 1 do begin
      D := TDControl(ItemList.Objects[II]);
      D.Free;
    end;
    ItemList.Free;
  end;
  FLines.Clear;

 { nPosition := 0;
  if FDScroll <> nil then nPosition := FDScroll.Position;
      }
  LoadList := TStringList.Create;
  try
    LoadList.LoadFromFile(FileName);
    nTop := 0;
    for I := 0 to LoadList.Count - 1 do begin
      ItemList := Add;
      DLabel := TDLabel.Create(Self);
      DLabel.Caption := LoadList.Strings[I];
      //DLabel.Font.Assign(MainForm.Canvas.Font);
      DLabel.DParent := Self;
      DLabel.Left := TLines(ItemList).Width;
      DLabel.Top := nTop;
      Inc(nTop, Math.Max(DLabel.Height, FItemSize));
      AddSuItem(ItemList, DLabel);
    end;
  finally
    LoadList.Free;
  end;
end;

procedure TDMemo.SaveToFile(const FileName: string);
var
  I: Integer;
  ItemList: TLines;
  SaveList: TStringList;
begin
  SaveList := TStringList.Create;
  try
    for I := 0 to Count - 1 do begin
      ItemList := TLines(Items[I]);
      SaveList.Add(ItemList.Text);
    end;
    SaveList.SaveToFile(FileName);
  finally
    SaveList.Free;
  end;
end;

procedure TDMemo.Process;
var
  I: Integer;
begin
  if Assigned(FOnProcess) then FOnProcess(Self);

  for I := 0 to DControls.Count - 1 do
    if TDControl(DControls[I]).Visible then
      TDControl(DControls[I]).Process;
end;

procedure TDMemo.DirectPaint(dsurface: TTexture);
var
  I: Integer;
  rc: TRect;
  nX, nY, nWidth, nHeight: Integer;
  ItemList: TLines;
  d: TTexture;
  DControl: TDControl;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(Self, dsurface)
  else
    if WLib <> nil then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;

  if FBackground then
    dsurface.FillRect(Bounds(SurfaceX(Left), SurfaceY(Top), Width, Height), FColors.Background);

  {if FRowSelect and (FItemIndex >= 0) and (FItemIndex < FLines.Count) and
    (FLines.Count > 0) and (FItemIndex - FDrawItemIndex >= 0) and (FItemIndex < FDrawItemIndex + FVisibleItemCount) then begin
    ItemList := TLines(Items[FItemIndex]);
    nY := (FItemIndex - FDrawItemIndex) * FItemSize + FY;
    nWidth := Width;
    nHeight := Min(FItemSize, ItemList.Height);
    //if LeftButton.Visible then nWidth := nWidth - FScrollButtonWidth;
    if FItemSize > ItemList.Height then begin
      nY := nY - (FItemSize - ItemList.Height) div 2;
      nHeight := FItemSize;
    end;
    dsurface.FillRect(Bounds(SurfaceX(Left), SurfaceY(Top + nY), nWidth, nHeight), FColors.Selected);
  end;
  }

  //if FDScroll <> nil then begin

  nWidth := SurfaceX(Left) + Width;
  nHeight := SurfaceY(Top) + Height;
  if (nWidth <> FBackSurface.Width) or (nHeight <> FBackSurface.Height) then begin
    FBackSurface.SetSize(nWidth, nHeight);
  end else begin
    FBackSurface.Fill(0);
  end;
  for I := 0 to DControls.Count - 1 do begin
    DControl := TDControl(DControls[I]);
    if DControl.Visible then
      DControl.DirectPaint(FBackSurface);
  end;
  dsurface.Draw(SurfaceX(Left), SurfaceY(Top), Bounds(SurfaceX(Left), SurfaceY(Top) - 1, Width, Height), FBackSurface);

  {end else begin
    for I := 0 to DControls.Count - 1 do begin
      DControl := TDControl(DControls[I]);
      if DControl.Visible then begin
        DControl.DirectPaint(dsurface);
      end;
    end;
  end; }
end;

function TDMemo.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := inherited KeyDown(Key, Shift);
  {if FDScroll <> nil then begin
    if inherited KeyDown(Key, Shift) then begin
      with FDScroll do begin
        Result := True;
        case Key of
          VK_UP: Position := 0;
          VK_DOWN: Position := Max;
          VK_PRIOR: Previous;
          VK_NEXT: Next;
        else Result := False;
        end;
      end;
    end;
  end else Result := False;}
end;

function TDMemo.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);

    {if MouseCaptureControl = Self then
      if InRange(X, Y) then Downed := True
      else Downed := False;}
end;

function TDMemo.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := False;
  if InRange(X, Y) then GetItemIndex(Y);
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) then begin
      if (MouseCaptureControl = nil) then begin
        SetDCapture(Self);
        //Showmessage('SetDCapture(Self)');
      end;
    end;
    if InRange(X, Y) and (MouseCaptureControl <> Self) then begin
      if Assigned(FOnMouseDown) then
        FOnMouseDown(Self, Button, Shift, X, Y);
        //if EnableFocus then SetDFocus(Self);
         //else ReleaseDFocus;
    end;
    Result := True;
  end;
end;

function TDMemo.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  I: Integer;
  d: TDControl;
  boDown: Boolean;
begin
  Result := False;
  ReleaseDCapture;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    if not Background then begin
      if InRange(X, Y) then begin
        //Downed := False;
        if Assigned(FOnClickSound) then FOnClickSound(Self, FClickSound);
        if Assigned(FOnClick) then FOnClick(Self, X, Y);
      end;
    end;
    //Downed := False;
    Result := True;
    Exit;
  end else begin
    ReleaseDCapture;
    Downed := False;
  end;
end;
{--------------------- TDWinManager --------------------------}


constructor TDWinManager.Create;
begin
  DWinList := TList.Create;
  MouseCaptureControl := nil;
  FocusedControl := nil;
end;

destructor TDWinManager.Destroy;
begin
  inherited Destroy;
end;

procedure TDWinManager.ClearAll;
begin
  DWinList.Clear;
end;

procedure TDWinManager.AddDControl(dcon: TDControl; Visible: Boolean);
begin
  dcon.Visible := Visible;
  DWinList.Add(dcon);
end;

procedure TDWinManager.DelDControl(dcon: TDControl);
var
  I: Integer;
begin
  for I := 0 to DWinList.Count - 1 do
    if DWinList[I] = dcon then begin
      DWinList.Delete(I);
      Break;
    end;
end;

function TDWinManager.KeyPress(var Key: Char): Boolean;
var
  I: Integer;
begin
  Result := False;

  if (ActiveMenu <> nil) and ActiveMenu.Visible and (not ActiveMenu.Enabled) then
    ActiveMenu := nil;

  if (ModalDWindow <> nil) and ModalDWindow.Visible and (not ModalDWindow.Enabled) then
    ModalDWindow := nil;

  if (FocusedControl <> nil) and FocusedControl.Visible and (not FocusedControl.Enabled) then
    ReleaseDFocus;

  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then begin
      with ActiveMenu do
        Result := KeyPress(Key);
      Exit;
    end else
      ActiveMenu := nil;
    Key := #0;
  end;

  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        Result := KeyPress(Key);
      Exit;
    end else
      ModalDWindow := nil;
    Key := #0;

  end;

  if FocusedControl <> nil then begin
    if FocusedControl.Visible then begin
      Result := FocusedControl.KeyPress(Key);
    end else
      ReleaseDFocus;
  end;
   {for i:=0 to DWinList.Count-1 do begin
      if TDControl(DWinList[i]).Visible then begin
         if TDControl(DWinList[i]).KeyPress (Key) then begin
            Result := TRUE;
            break;
         end;
      end;
   end; }
end;

function TDWinManager.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
var
  I: Integer;
begin
  Result := False;

  if (ActiveMenu <> nil) and ActiveMenu.Visible and (not ActiveMenu.Enabled) then
    ActiveMenu := nil;

  if (ModalDWindow <> nil) and ModalDWindow.Visible and (not ModalDWindow.Enabled) then
    ModalDWindow := nil;

  if (FocusedControl <> nil) and FocusedControl.Visible and (not FocusedControl.Enabled) then
    ReleaseDFocus;

  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then begin
      with ActiveMenu do
        Result := KeyDown(Key, Shift);
      Exit;
    end else ActiveMenu := nil;
  end;

  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        Result := KeyDown(Key, Shift);
      Exit;
    end else ModalDWindow := nil;
  end;
  if FocusedControl <> nil then begin
     //DebugOutStr(FocusedControl.Name);
    if FocusedControl.Visible then
      Result := FocusedControl.KeyDown(Key, Shift)
    else
      ReleaseDFocus;
  end;
   {for i:=0 to DWinList.Count-1 do begin
      if TDControl(DWinList[i]).Visible then begin
         if TDControl(DWinList[i]).KeyDown (Key, Shift) then begin
            Result := TRUE;
            break;
         end;
      end;
   end; }
end;

function TDWinManager.MouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
var
  I: Integer;
begin
  Result := False;

  if (ActiveMenu <> nil) and ActiveMenu.Visible and (not ActiveMenu.Enabled) then
    ActiveMenu := nil;

  if (ModalDWindow <> nil) and ModalDWindow.Visible and (not ModalDWindow.Enabled) then
    ModalDWindow := nil;


  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then begin
      with ActiveMenu do
        MouseWheelDown(Shift, MousePos);
      Result := True;
      Exit;
    end else ActiveMenu := nil;
  end;

  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        MouseWheelDown(Shift, MousePos);
      Result := True;
      Exit;
    end;
  end;

  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := MouseWheelDown(Shift, MousePos);
  end else
    for I := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[I]).Visible and TDControl(DWinList[I]).Enabled then begin
        if TDControl(DWinList[I]).MouseWheelDown(Shift, MousePos) then begin
          Result := True;
          Break;
        end;
      end;
    end;
end;

function TDWinManager.MouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
var
  I: Integer;
begin
  Result := False;

  if (ActiveMenu <> nil) and ActiveMenu.Visible and (not ActiveMenu.Enabled) then
    ActiveMenu := nil;

  if (ModalDWindow <> nil) and ModalDWindow.Visible and (not ModalDWindow.Enabled) then
    ModalDWindow := nil;


  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then begin
      with ActiveMenu do
        MouseWheelUp(Shift, MousePos);
      Result := True;
      Exit;
    end else ActiveMenu := nil;
  end;

  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        MouseWheelUp(Shift, MousePos);
      Result := True;
      Exit;
    end else ModalDWindow := nil;
  end;
  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := MouseWheelUp(Shift, MousePos);
  end else
    for I := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[I]).Visible and TDControl(DWinList[I]).Enabled then begin
        if TDControl(DWinList[I]).MouseWheelUp(Shift, MousePos) then begin
          Result := True;
          Break;
        end;
      end;
    end;
end;

function TDWinManager.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;

  if (ActiveMenu <> nil) and ActiveMenu.Visible and (not ActiveMenu.Enabled) then begin
    ActiveMenu.Hide;
    ActiveMenu := nil;
  end;

  if (ModalDWindow <> nil) and ModalDWindow.Visible and (not ModalDWindow.Enabled) then begin
    ModalDWindow := nil;
  end;

  if (MouseCaptureControl <> nil) and MouseCaptureControl.Visible and (not MouseCaptureControl.Enabled) then
    MouseCaptureControl := nil;

  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then begin
      with ActiveMenu do
        Result := MouseMove(Shift, LocalX(X), LocalY(Y));
      //Result := True;
      //Exit;
      if Result then Exit else begin
       { ActiveMenu.Hide;
        ActiveMenu := nil;  }
      end;
    end else begin
      ActiveMenu.Hide;
      ActiveMenu := nil;
    end;
  end;

  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        MouseMove(Shift, LocalX(X), LocalY(Y));
      Result := True;
      Exit;
    end else ModalDWindow := nil;
  end;
  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := MouseMove(Shift, LocalX(X), LocalY(Y));
  end else
    for I := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[I]).Visible and TDControl(DWinList[I]).Enabled then begin
        if TDControl(DWinList[I]).MouseMove(Shift, X, Y) then begin
          Result := True;
          Break;
        end;
      end;
    end;
end;

function TDWinManager.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;

  if (ActiveMenu <> nil) and ActiveMenu.Visible and (not ActiveMenu.Enabled) then begin
    ActiveMenu.Hide;
    ActiveMenu := nil;
  end;

  if (ModalDWindow <> nil) and ModalDWindow.Visible and (not ModalDWindow.Enabled) then begin
    ModalDWindow := nil;
  end;

  if (MouseCaptureControl <> nil) and MouseCaptureControl.Visible and (not MouseCaptureControl.Enabled) then
    MouseCaptureControl := nil;

  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then begin
      with ActiveMenu do
        Result := MouseDown(Button, Shift, LocalX(X), LocalY(Y));
      if Result then Exit else begin
        ActiveMenu.Hide;
        ActiveMenu := nil;
      end;
    end else begin
      ActiveMenu.Hide;
      ActiveMenu := nil;
    end;
  end;

  if ModalDWindow <> nil then begin

    if ModalDWindow.Visible then begin
      with ModalDWindow do
        MouseDown(Button, Shift, LocalX(X), LocalY(Y));

      Result := True;
      Exit;
    end else ModalDWindow := nil;
  end;
  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := MouseDown(Button, Shift, LocalX(X), LocalY(Y));
  end else
    for I := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[I]).Visible and TDControl(DWinList[I]).Enabled then begin
        if TDControl(DWinList[I]).MouseDown(Button, Shift, X, Y) then begin
          Result := True;
          Break;
        end;
      end;
    end;
end;

function TDWinManager.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  I: Integer;
begin
  Result := True;

  if (ActiveMenu <> nil) and ActiveMenu.Visible and (not ActiveMenu.Enabled) then begin
    ActiveMenu.Hide;
    ActiveMenu := nil;
  end;

  if (ModalDWindow <> nil) and ModalDWindow.Visible and (not ModalDWindow.Enabled) then begin
    ModalDWindow := nil;
  end;

  if (MouseCaptureControl <> nil) and MouseCaptureControl.Visible and (not MouseCaptureControl.Enabled) then
    MouseCaptureControl := nil;

  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then begin
      with ActiveMenu do
        Result := MouseUp(Button, Shift, LocalX(X), LocalY(Y));
      if Result then Exit else begin
        {ActiveMenu.Hide;
        ActiveMenu := nil;  }
      end;
    end else begin
      ActiveMenu.Hide;
      ActiveMenu := nil;
    end;
  end;

  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        Result := MouseUp(Button, Shift, LocalX(X), LocalY(Y));
      Exit;
    end else ModalDWindow := nil;
  end;
  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := MouseUp(Button, Shift, LocalX(X), LocalY(Y));
  end else
    for I := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[I]).Visible and TDControl(DWinList[I]).Enabled then begin
        if TDControl(DWinList[I]).MouseUp(Button, Shift, X, Y) then begin
          Result := True;
          Break;
        end;
      end;
    end;
end;

function TDWinManager.DblClick(X, Y: Integer): Boolean;
var
  I: Integer;
begin
  Result := True;
  if (ActiveMenu <> nil) and ActiveMenu.Visible and (not ActiveMenu.Enabled) then begin
    ActiveMenu.Hide;
    ActiveMenu := nil;
  end;

  if (ModalDWindow <> nil) and ModalDWindow.Visible and (not ModalDWindow.Enabled) then begin
    ModalDWindow := nil;
  end;

  if (MouseCaptureControl <> nil) and MouseCaptureControl.Visible and (not MouseCaptureControl.Enabled) then
    MouseCaptureControl := nil;

  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then begin
      with ActiveMenu do
        Result := DblClick(LocalX(X), LocalY(Y));
      Result := True;
      if Result then Exit else begin
        ActiveMenu.Hide;
        ActiveMenu := nil;
      end;
    end else begin
      ActiveMenu.Hide;
      ActiveMenu := nil;
    end;
  end;

  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        Result := DblClick(LocalX(X), LocalY(Y));
      Exit;
    end else ModalDWindow := nil;
  end;
  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := DblClick(LocalX(X), LocalY(Y));
  end else
    for I := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[I]).Visible and TDControl(DWinList[I]).Enabled then begin
        if TDControl(DWinList[I]).DblClick(X, Y) then begin
          Result := True;
          Break;
        end;
      end;
    end;
end;

function TDWinManager.Click(X, Y: Integer): Boolean;
var
  I: Integer;
begin
  Result := True;
  if (ActiveMenu <> nil) and ActiveMenu.Visible and (not ActiveMenu.Enabled) then begin
    ActiveMenu.Hide;
    ActiveMenu := nil;
  end;

  if (ModalDWindow <> nil) and ModalDWindow.Visible and (not ModalDWindow.Enabled) then begin
    ModalDWindow := nil;
  end;

  if (MouseCaptureControl <> nil) and MouseCaptureControl.Visible and (not MouseCaptureControl.Enabled) then
    MouseCaptureControl := nil;

  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then begin
      with ActiveMenu do
        Result := Click(LocalX(X), LocalY(Y));
      if Result then Exit else begin
        if MouseCaptureControl <> ActiveMenu.DControl then begin
          ActiveMenu.Hide;
          ActiveMenu := nil;
        end;
      end;
    end else begin
      ActiveMenu.Hide;
      ActiveMenu := nil;
    end;
  end;

  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        Result := Click(LocalX(X), LocalY(Y));
      Exit;
    end else ModalDWindow := nil;
  end;
  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := Click(LocalX(X), LocalY(Y));
  end else
    for I := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[I]).Visible and TDControl(DWinList[I]).Enabled then begin
        if TDControl(DWinList[I]).Click(X, Y) then begin
          Result := True;
          Break;
        end;
      end;
    end;
end;

procedure TDWinManager.Process;
var
  I: Integer;
begin
  for I := 0 to DWinList.Count - 1 do begin
    if TDControl(DWinList[I]).Visible then begin
      TDControl(DWinList[I]).Process;
    end;
  end;
  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then
      with ModalDWindow do
        Process;
  end;
  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then
      with ActiveMenu do begin
        Process;
      end;
  end;
end;

procedure TDWinManager.DirectPaint(dsurface: TTexture);
var
  I: Integer;
begin
  for I := 0 to DWinList.Count - 1 do begin
    if TDControl(DWinList[I]).Visible then begin
      TDControl(DWinList[I]).DirectPaint(dsurface);
    end;
  end;
  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then
      with ModalDWindow do
        DirectPaint(dsurface);
  end;
  if ActiveMenu <> nil then begin
    if ActiveMenu.Visible then
      with ActiveMenu do begin
        DirectPaint(dsurface);
      end;
  end;
end;

initialization
  begin
    DWinMan := TDWinManager.Create;
    MouseCaptureControl := nil; //mouse message
    FocusedControl := nil; //Key message
    MainWinHandle := 0;
    ModalDWindow := nil;
    MouseMoveControl := nil;
    MouseDownControl := nil;
    ActiveMenu := nil;
    LabelClickTimeTick := GetTickCount;
  end;

end.

