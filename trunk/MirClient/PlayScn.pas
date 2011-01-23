unit PlayScn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Textures, IntroScn, Grobal2, HUtil32,
  Actor, HerbActor, AxeMon, SoundUtil, clEvent, GameImages,
  StdCtrls, ClFunc, magiceff, ExtCtrls, Share;
const

  LightFiles: array[0..MAXLIGHT] of string = (
    'Data\lig0a.dat',
    'Data\lig0b.dat',
    'Data\lig0c.dat',
    'Data\lig0d.dat',
    'Data\lig0e.dat',
    'Data\lig0f.dat'
    );

  LightMask0: array[0..2, 0..2] of shortint = (
    (0, 1, 0),
    (1, 3, 1),
    (0, 1, 0)
    );
  LightMask1: array[0..4, 0..4] of shortint = (
    (0, 1, 1, 1, 0),
    (1, 1, 3, 1, 1),
    (1, 3, 4, 3, 1),
    (1, 1, 3, 1, 1),
    (0, 1, 2, 1, 0)
    );
  LightMask2: array[0..8, 0..8] of shortint = (
    (0, 0, 0, 1, 1, 1, 0, 0, 0),
    (0, 0, 1, 2, 3, 2, 1, 0, 0),
    (0, 1, 2, 3, 4, 3, 2, 1, 0),
    (1, 2, 3, 4, 4, 4, 3, 2, 1),
    (1, 3, 4, 4, 4, 4, 4, 3, 1),
    (1, 2, 3, 4, 4, 4, 3, 2, 1),
    (0, 1, 2, 3, 4, 3, 2, 1, 0),
    (0, 0, 1, 2, 3, 2, 1, 0, 0),
    (0, 0, 0, 1, 1, 1, 0, 0, 0)
    );
  LightMask3: array[0..10, 0..10] of shortint = (
    (0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0),
    (0, 0, 0, 1, 2, 2, 2, 1, 0, 0, 0),
    (0, 0, 1, 2, 3, 3, 3, 2, 1, 0, 0),
    (0, 1, 2, 3, 4, 4, 4, 3, 2, 1, 0),
    (1, 2, 3, 4, 4, 4, 4, 4, 3, 2, 1),
    (2, 3, 4, 4, 4, 4, 4, 4, 4, 3, 2),
    (1, 2, 3, 4, 4, 4, 4, 4, 3, 2, 1),
    (0, 1, 2, 3, 4, 4, 4, 3, 2, 1, 0),
    (0, 0, 1, 2, 3, 3, 3, 2, 1, 0, 0),
    (0, 0, 0, 1, 2, 2, 2, 1, 0, 0, 0),
    (0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0)
    );

  LightMask4: array[0..14, 0..14] of shortint = (
    (0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 1, 1, 2, 2, 2, 1, 1, 0, 0, 0, 0),
    (0, 0, 0, 1, 1, 2, 3, 3, 3, 2, 1, 1, 0, 0, 0),
    (0, 0, 1, 1, 2, 3, 4, 4, 4, 3, 2, 1, 1, 0, 0),
    (0, 1, 1, 2, 3, 4, 4, 4, 4, 4, 3, 2, 1, 1, 0),
    (1, 1, 2, 3, 4, 4, 4, 4, 4, 4, 4, 3, 2, 1, 1),
    (1, 2, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 2, 1),
    (1, 1, 2, 3, 4, 4, 4, 4, 4, 4, 4, 3, 2, 1, 1),
    (0, 1, 1, 2, 3, 4, 4, 4, 4, 4, 3, 2, 1, 1, 0),
    (0, 0, 1, 1, 2, 3, 4, 4, 4, 3, 2, 1, 1, 0, 0),
    (0, 0, 0, 1, 1, 2, 3, 3, 3, 2, 1, 1, 0, 0, 0),
    (0, 0, 0, 0, 1, 1, 2, 2, 2, 1, 1, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0)
    );

  LightMask5: array[0..16, 0..16] of shortint = (
    (0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 1, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 1, 2, 4, 4, 4, 2, 1, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 1, 2, 4, 4, 4, 4, 4, 2, 1, 0, 0, 0, 0),
    (0, 0, 0, 1, 2, 4, 4, 4, 4, 4, 4, 4, 2, 1, 0, 0, 0),
    (0, 0, 1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 1, 0, 0),
    (0, 1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 1, 0),
    (1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 1),
    (1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 1),
    (1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 1),
    (0, 1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 1, 0),
    (0, 0, 1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 1, 0, 0),
    (0, 0, 0, 1, 2, 4, 4, 4, 4, 4, 4, 4, 2, 1, 0, 0, 0),
    (0, 0, 0, 0, 1, 2, 4, 4, 4, 4, 4, 2, 1, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 1, 2, 4, 4, 4, 2, 1, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 1, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0)
    { (0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0),
     (0,0,0,0,0,0,0,1,2,2,2,1,0,0,0,0,0,0,0),
     (0,0,0,0,0,0,1,2,4,4,4,2,1,0,0,0,0,0,0),
     (0,0,0,0,0,1,2,4,4,4,4,4,2,1,0,0,0,0,0),
     (0,0,0,0,1,2,4,4,4,4,4,4,4,2,1,0,0,0,0),
     (0,0,0,1,2,4,4,4,4,4,4,4,4,4,2,1,0,0,0),
     (0,0,1,2,4,4,4,4,4,4,4,4,4,4,4,2,1,0,0),
     (0,1,2,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1,0),
     (1,2,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1),
     (1,2,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1),
     (1,2,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1),
     (0,1,2,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1,0),
     (0,0,1,2,4,4,4,4,4,4,4,4,4,4,4,2,1,0,0),
     (0,0,0,1,2,4,4,4,4,4,4,4,4,4,2,1,0,0,0),
     (0,0,0,0,1,2,4,4,4,4,4,4,4,2,1,0,0,0,0),
     (0,0,0,0,0,1,2,4,4,4,4,4,2,1,0,0,0,0,0),
     (0,0,0,0,0,0,1,2,4,4,4,2,1,0,0,0,0,0,0),
     (0,0,0,0,0,0,0,1,2,2,2,1,0,0,0,0,0,0,0),
     (0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0) }
    );
  AREASTATEICONBASE = 150;
type
  PShoftInt = ^shortint;
  TLightEffect = record
    Width: Integer;
    Height: Integer;
    PFog: PByte;
  end;
  TLightMapInfo = record
    ShiftX: Integer;
    ShiftY: Integer;
    light: Integer;
    bright: Integer;
  end;
  TPlayScene = class(TScene)
    m_MapSurface: TTexture;
    m_TileSurface: TTexture;
    //m_SmTileSurface: TTexture;
    m_ObjSurface: TTexture;
    m_SnowSurface: TTexture;
    m_nCurrX: Integer;
    m_nCurrY: Integer;

    m_nOldCurrX: Integer;
    m_nOldCurrY: Integer;
  private
    m_nProcHumIDx: Integer;
    m_nProcEffectIDx: Integer;
    m_nProcGroundEffectIDx: Integer;

    m_nProcDrawChrIDx: Integer;
    m_nProcDrawEffectIDx: Integer;


    m_nProcX: Integer;
    m_nProcY: Integer;

    m_dwRunTimeTick: LongWord;

    //m_FogScreen: array[0..MAPSURFACEHEIGHT, 0..MAPSURFACEWIDTH] of Byte;
    //m_PFogScreen: PByte;
    //m_nFogWidth: Integer;
    //m_nFogHeight: Integer;
    //m_Lights: array[0..MAXLIGHT] of TLightEffect;
    m_dwMoveTime: LongWord;
    m_nMoveStepCount: Integer;
    m_dwAniTime: LongWord;
    m_nAniCount: Integer;
    m_nDefXX: Integer;
    m_nDefYY: Integer;
    m_MainSoundTimer: TTimer;
    m_MsgList: TList;
    m_LightMap: array[0..LMX, 0..LMY] of TLightMapInfo;

    m_nOldTop: Integer;
    m_nOldBottom: Integer;
    m_nOldLeft: Integer;
    m_nOldRight: Integer;

    m_dwPlaySceneTick: LongWord;
    function DrawTileMap: Boolean;

    procedure EdChatKeyPress(Sender: TObject; var Key: Char);
    procedure SoundOnTimer(Sender: TObject);

    procedure ClearDropItem();
    procedure DrawItemName(dsurface: TTexture; DropItem: pTDropItem; X, Y: Integer);
    function GetShowItemName(DropItem: pTDropItem): Boolean;
  public
    MemoLog: TMemo;
    EdAccountt: TEdit; //2004/05/17
    EdChrNamet: TEdit; //2004/05/17
    {
    EdChgChrName: TEdit;
    EdChgCurPwd: TEdit;
    EdChgNewPwd: TEdit;
    EdChgRePwd: TEdit;
    }
    m_ActorList: TList;
    m_TempList: TList;
    m_GroundEffectList: TList;
    m_EffectList: TList;
    m_FlyList: TList;
    m_dwBlinkTime: LongWord;
    m_boViewBlink: Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure Initialize; override;
    procedure Finalize; override;
    procedure OpenScene; override;
    procedure CloseScene; override;
    procedure OpeningScene; override;
    procedure DrawMiniMap(Surface: TTexture);
    procedure PlayScene(MSurface: TTexture); override;
    function ButchAnimal(X, Y: Integer): TActor;
    function FindActor(id: Integer): TActor; overload;
    function FindActor(sName: string): TActor; overload;
    function FindActorXY(X, Y: Integer): TActor;
    function IsValidActor(Actor: TActor): Boolean;
    function FindTargetXYCount(nX, nY, nRange: Integer): Integer;
    function NewActor(chrid: Integer; cx, cy, cdir: Word; cfeature, cstate: Integer): TActor;
    procedure ActorDied(Actor: TObject); //磷篮 actor绰 盖 困肺
    procedure SetActorDrawLevel(Actor: TObject; Level: Integer);
    procedure ClearActors;
    function DeleteActor(id: Integer): TActor;
    procedure DelActor(Actor: TObject);
    procedure ClearActorMsg(Actor: TActor);
    procedure SendMsg(ident, chrid, X, Y, cdir, feature, State: Integer; Str: string);

    procedure NewMagic(aowner: TActor;
      magid, magnumb, cx, cy, tx, ty, targetcode: Integer;
      mtype: TMagicType;
      Recusion: Boolean;
      anitime: Integer;
      var bofly: Boolean);
    procedure DelMagic(magid: Integer);
    function NewFlyObject(aowner: TActor; cx, cy, tx, ty, targetcode: Integer; mtype: TMagicType): TMagicEff;
    //function  NewStaticMagic (aowner: TActor; tx, ty, targetcode, effnum: integer);

    function GetCharacter(X, Y, wantsel: Integer; var nowsel: Integer; liveonly: Boolean): TActor;
    function GetAttackFocusCharacter(X, Y, wantsel: Integer; var nowsel: Integer; liveonly: Boolean): TActor;
    function GetAttackFocusCharacterA(X, Y, wantsel: Integer; var nowsel: Integer; liveonly: Boolean): TActor;
    procedure GetXYDropItemsList(nX, nY: Integer; var ItemList: TList);

    procedure ScreenXYfromMCXY(cx, cy: Integer; var sx, sY: Integer);
    procedure CXYfromMouseXY(mx, my: Integer; var ccx, ccy: Integer);

    function IsSelectMyself(X, Y: Integer): Boolean;
    function GetDropItems(X, Y: Integer; var inames: string): pTDropItem;
    function GetXYDropItems(nX, nY: Integer): pTDropItem;
    function CrashManEx(mx, my: Integer): Boolean;
    function CanRun(sx, sY, ex, ey: Integer): Boolean;
    function CanWalk(mx, my: Integer): Boolean;
    function CanWalkEx(mx, my: Integer): Boolean;
    function CrashMan(mx, my: Integer): Boolean; //荤恩尝府 般摹绰啊?
    function CanFly(mx, my: Integer): Boolean;

    function NewCanRun(sx, sy, ex, ey: Integer): Boolean;
    function NewCanWalkEx(mx, my: Integer): Boolean;

    procedure RefreshScene;
    procedure CleanObjects;
    procedure UnLoadSurface;
    procedure Run(RunSelf: Boolean);
  end;

implementation

uses
  ClMain, FState, MShare, EncryptUnit, PlugIn;

constructor TPlayScene.Create;
var
  nX, nY: Integer;
begin
  m_nProcHumIDx := 0;
  m_nProcEffectIDx := 0;
  m_nProcGroundEffectIDx := 0;

  m_nProcDrawChrIDx := 0;
  m_nProcDrawEffectIDx := 0;

  m_nProcX := 0;
  m_nProcY := 0;

  m_MapSurface := nil;
  m_TileSurface := nil;
  m_ObjSurface := nil;
  m_MsgList := TList.Create;
  m_ActorList := TList.Create;
  m_TempList := TList.Create;
  m_GroundEffectList := TList.Create;
  m_EffectList := TList.Create;
  m_FlyList := TList.Create;
  m_dwBlinkTime := GetTickCount;
  m_boViewBlink := False;

 { EdChat := TEdit.Create(frmMain.Owner);
  with EdChat do begin
    Parent := frmMain;
    BorderStyle := bsNone;
    OnKeyPress := EdChatKeyPress;
    Visible := False;
    MaxLength := 100; //70;
    Ctl3D := False;
    if g_ConfigClient.btMainInterface in [0, 2] then begin
      Left := 208;
      Top := SCREENHEIGHT - 19;
      Height := 12;
      Width := (SCREENWIDTH div 2 - 207) * 2
    end else begin
      Left := 10 + 17 - 6;
      Top := 539;
      Height := 14;
      Width := (SCREENWIDTH div 2 - 207) * 2 - 20 - 17;
    end;
    Color := clSilver;
  end;  }

  MemoLog := TMemo.Create(frmMain.Owner);
  with MemoLog do begin
    Parent := frmMain;
    BorderStyle := bsNone;
    Visible := False;
    // Visible := True;
    Ctl3D := True;
    Left := 0;
    Top := 250;
    Width := 300;
    Height := 150;
  end;
  //2004/05/17
  EdAccountt := TEdit.Create(frmMain.Owner);
  with EdAccountt do begin
    Parent := frmMain;
    BorderStyle := bsSingle;
    Visible := False;
    MaxLength := 70;
    Ctl3D := True;
    Left := (SCREENWIDTH - 194) div 2;
    Top := SCREENHEIGHT - 200;
    Height := 12;
    Width := 194;
  end;
  //2004/05/17
  //2004/05/17
  EdChrNamet := TEdit.Create(frmMain.Owner);
  with EdChrNamet do begin
    Parent := frmMain;
    BorderStyle := bsSingle;
    Visible := False;
    MaxLength := 70;
    Ctl3D := True;
    Left := (SCREENWIDTH - 194) div 2;
    Top := SCREENHEIGHT - 176;
    Height := 12;
    Width := 194;
  end;
  //2004/05/17
  m_dwMoveTime := GetTickCount;
  m_dwAniTime := GetTickCount;
  m_nAniCount := 0;
  m_nMoveStepCount := 0;
  m_MainSoundTimer := TTimer.Create(frmMain.Owner);
  with m_MainSoundTimer do begin
    OnTimer := SoundOnTimer;
    Interval := 1;
    Enabled := False;
  end;
  {
  nx:=192;
  ny:=150;
  }
  nX := SCREENWIDTH div 2 - 210 {192} {192};
  nY := SCREENHEIGHT div 2 - 150 {146} {150};
  {
  EdChgChrName := TEdit.Create (FrmMain.Owner);
  with EdChgChrName do begin
     Parent:=FrmMain;
     Height:=16;
     Width:=137;
     Left:=nx + 239;
     Top:=ny + 117;
     BorderStyle:=bsNone;
     Color:=clBlack;
     Font.Color:=clWhite;
     MaxLength:=10;
     Visible:=FALSE;
     //OnKeyPress:=EdNewIdKeyPress;
     //OnEnter:=EdNewOnEnter;
     Tag:=12;
  end;

  EdChgCurPwd := TEdit.Create (FrmMain.Owner);
  with EdChgCurPwd do begin
     Parent:=FrmMain;
     Height:=16;
     Width:=137;
     Left:=nx+239;
     Top:=ny+149;
     BorderStyle:=bsNone;
     Color:=clBlack;
     Font.Color:=clWhite;
     MaxLength:=10;
     PasswordChar:='*';
     Visible:=FALSE;
     //OnKeyPress:=EdNewIdKeyPress;
     //OnEnter:=EdNewOnEnter;
     Tag := 12;
  end;
  EdChgNewPwd := TEdit.Create (FrmMain.Owner);
  with EdChgNewPwd do begin
     Parent:=FrmMain;
     Height:=16;
     Width:=137;
     Left:=nx+239;
     Top:=ny+176;
     BorderStyle:=bsNone;
     Color:=clBlack;
     Font.Color:=clWhite;
     MaxLength:=10;
     PasswordChar:='*';
     Visible:=FALSE;
     //OnKeyPress:=EdNewIdKeyPress;
     //OnEnter:=EdNewOnEnter;
     Tag:=12;
  end;
  EdChgRePwd := TEdit.Create (FrmMain.Owner);
  with EdChgRePwd do begin
     Parent := FrmMain;
     Height := 16;
     Width  := 137;
     Left := nx+239;
     Top  := ny+208;
     BorderStyle := bsNone;
     Color := clBlack;
     Font.Color := clWhite;
     MaxLength := 10;
     PasswordChar := '*';
     Visible := FALSE;
     //OnKeyPress := EdNewIdKeyPress;
     //OnEnter := EdNewOnEnter;
     Tag := 12;
  end;
  }
end;

destructor TPlayScene.Destroy;
var
  I: Integer;
begin
  for I := m_ActorList.Count - 1 downto 0 do begin
    if (TActor(m_ActorList[I]) = g_MySelf) then g_MySelf := nil;
    if (TActor(m_ActorList[I]) = g_MyHero) then g_MyHero := nil;
    TActor(m_ActorList[I]).Free;
  end;

  if g_MySelf <> nil then
    g_MySelf.Free;

  if g_MyHero <> nil then
    g_MyHero.Free;


  for I := 0 to m_GroundEffectList.Count - 1 do
    TMagicEff(m_GroundEffectList[I]).Free;

  for I := 0 to m_EffectList.Count - 1 do
    TMagicEff(m_EffectList[I]).Free;

  for I := 0 to m_FlyList.Count - 1 do
    TMagicEff(m_FlyList[I]).Free;

  m_MsgList.Free;
  m_ActorList.Free;
  m_TempList.Free;
  m_GroundEffectList.Free;
  m_EffectList.Free;
  m_FlyList.Free;
  inherited Destroy;
end;

procedure TPlayScene.SoundOnTimer(Sender: TObject);
begin
  PlaySound(s_main_theme);
  m_MainSoundTimer.Interval := 46 * 1000;
end;

procedure TPlayScene.EdChatKeyPress(Sender: TObject; var Key: Char);
begin

end;

procedure TPlayScene.Initialize;
var
  I: Integer;
begin
  m_nCurrX := -1;
  m_nCurrY := -1;
  m_nOldCurrX := -1;
  m_nOldCurrY := -1;

  m_MapSurface := TTexture.Create();
  m_TileSurface := TTexture.Create();
  m_ObjSurface := TTexture.Create();
  m_SnowSurface := TTexture.Create();

  if g_ConfigClient.btMainInterface in [0, 2] then begin
    m_MapSurface.SetSize(MAPSURFACEWIDTH + UNITX * 8 + 30, MAPSURFACEHEIGHT + UNITY * 8 {iamwghtemp 4});
    m_TileSurface.SetSize(MAPSURFACEWIDTH + UNITX * 8 + 30, MAPSURFACEHEIGHT + UNITY * 8 {iamwghtemp 4});
  end else begin
    m_MapSurface.SetSize(SCREENWIDTH + UNITX * 8 + 30, SCREENHEIGHT + UNITY * 8 {iamwghtemp 4});
    m_TileSurface.SetSize(SCREENWIDTH + UNITX * 8 + 30, SCREENHEIGHT + UNITY * 8 {iamwghtemp 4});
  end;

  if g_ConfigClient.btMainInterface in [0, 2] then begin
    m_ObjSurface.SetSize(MAPSURFACEWIDTH + 20, MAPSURFACEHEIGHT + 20);
  end else begin
    m_ObjSurface.SetSize(SCREENWIDTH + 20, SCREENHEIGHT + 20);
  end;


  if g_ConfigClient.btMainInterface in [0, 2] then begin
    m_SnowSurface.SetSize(MAPSURFACEWIDTH + UNITX * 4 + 30, MAPSURFACEHEIGHT + UNITY * 8 {iamwghtemp 4});
  end else begin
    m_SnowSurface.SetSize(SCREENWIDTH + UNITX * 8 + 30, SCREENHEIGHT + UNITY * 8 {iamwghtemp 4});
  end;

  g_boViewFog := False;
end;

procedure TPlayScene.Finalize;
begin
  if m_MapSurface <> nil then
    m_MapSurface.Free;
  if m_TileSurface <> nil then
    m_TileSurface.Free;
  if m_ObjSurface <> nil then
    m_ObjSurface.Free;

  if m_SnowSurface <> nil then
    m_SnowSurface.Free;

  m_MapSurface := nil;
  m_TileSurface := nil;
  m_ObjSurface := nil;
  m_SnowSurface := nil;
end;

procedure TPlayScene.OpenScene;
begin
  g_WMainImages.ClearCache;
  FrmDlg.ViewBottomBox(True);
  //EdChat.Visible := TRUE;
  //EdChat.SetFocus;
  SetImeMode(frmMain.Handle, LocalLanguage);
  //MainSoundTimer.Interval := 1000;
  //MainSoundTimer.Enabled := TRUE;
end;

procedure TPlayScene.CloseScene;
begin
  //MainSoundTimer.Enabled := FALSE;
  SilenceSound;

  FrmDlg.EdChat.Visible := False;
  FrmDlg.ViewBottomBox(False);
end;

procedure TPlayScene.OpeningScene;
begin

end;

procedure TPlayScene.RefreshScene;
var
  I: Integer;
begin
  //Map.m_OldClientRect.Left := -1;
  for I := 0 to m_ActorList.Count - 1 do
    TActor(m_ActorList[I]).LoadSurface;
end;

procedure TPlayScene.CleanObjects;
var
  I: Integer;
begin
  {for I := m_ActorList.Count - 1 downto 0 do begin
    if TActor(m_ActorList[I]) <> g_MySelf then begin
      if (g_MyHero <> nil) and (g_MyHero = TActor(m_ActorList[I])) then begin
        m_ActorList.Delete(I);
        ClearActorMsg(g_MyHero);
      end else begin
        TActor(m_ActorList[I]).Free;
        m_ActorList.Delete(I);
      end;
    end;
  end;  }

  for I := m_ActorList.Count - 1 downto 0 do begin
    if (TActor(m_ActorList[I]) <> g_MySelf) then begin
      if (TActor(m_ActorList[I]) <> g_MyHero) then
        TActor(m_ActorList[I]).Free;
      m_ActorList.Delete(I);
    end;
  end;

  m_MsgList.Clear;

  g_TargetCret := nil;
  g_FocusCret := nil;
  g_MagicTarget := nil;

  if g_MySelf <> nil then
    g_MySelf.m_dwLoadSurfaceTick := 0;
  if g_MyHero <> nil then
    g_MyHero.m_dwLoadSurfaceTick := 0;

  for I := 0 to m_GroundEffectList.Count - 1 do begin
    TMagicEff(m_GroundEffectList[I]).Free;
  end;
  m_GroundEffectList.Clear;

  for I := 0 to m_EffectList.Count - 1 do begin
    TMagicEff(m_EffectList[I]).Free;
  end;
  m_EffectList.Clear;
end;

procedure TPlayScene.UnLoadSurface;
var
  I: Integer;
begin
  for I := 0 to m_ActorList.Count - 1 do begin
    TActor(m_ActorList.Items[I]).UnLoadSurface;
  end;
  for I := 0 to EventMan.EventList.Count - 1 do begin
    TEvent(EventMan.EventList.Items[I]).UnLoadSurface;
  end;
  FillChar(Map.m_OldClientRect, SizeOf(TRect), 0);
end;


{---------------------- Draw Map -----------------------}
(*function TPlayScene.DrawTileMap: Boolean;
var
  I, j, nY, nX, nImgNumber: Integer;
  dsurface: TTexture;
begin
 //Result := True;
  Result := g_MySelf.m_btHorse = 0;
  with Map do
    if (m_ClientRect.Left = m_OldClientRect.Left) and (m_ClientRect.Top = m_OldClientRect.Top) then Exit;

  if g_MySelf.m_btHorse > 0 then begin
    if (abs(Map.m_ClientRect.Left - Map.m_OldClientRect.Left) <> 3) or (abs(Map.m_ClientRect.Top - Map.m_OldClientRect.Top) <> 3) then begin
      Result := True;
    end else Result := False;
  end;

  if Result then m_MapSurface.Fill(0);

  Map.m_OldClientRect := Map.m_ClientRect;
  //地图背景
  //if not g_boDrawTileMap then Exit;
  with Map.m_ClientRect do begin
    nY := -UNITY * 2;
    for j := (Top - Map.m_nBlockTop - 1) to (Bottom - Map.m_nBlockTop + 1) do begin
      nX := AAX + 14 - UNITX;
      for I := (Left - Map.m_nBlockLeft - 2) to (Right - Map.m_nBlockLeft + 2) do begin
        if (I >= 0) and (I < LOGICALMAPUNIT * 3) and (j >= 0) and (j < LOGICALMAPUNIT * 3) then begin
          nImgNumber := (Map.m_MArr[I, j].wBkImg and $7FFF);
          if nImgNumber > 0 then begin
            if (I mod 2 = 0) and (j mod 2 = 0) then begin
              nImgNumber := nImgNumber - 1;
              if Map.m_btBitCount = 16 then begin //2008-3-7增加读取真彩地图素材
                dsurface := g_WTilesImages16.Images[nImgNumber];
              end else begin
                dsurface := g_WTilesImages.Images[nImgNumber];
              end;
              if dsurface <> nil then begin
                //Jacky 显示地图内容
//                DrawLine(DSurface);
                m_MapSurface.Draw(nX, nY, dsurface.ClientRect, dsurface, False);
              end;
            end;
          end;
        end;
        Inc(nX, UNITX);
      end;
      Inc(nY, UNITY);
    end;
  end;

  //地图中间层
  with Map.m_ClientRect do begin
    nY := -UNITY;
    for j := (Top - Map.m_nBlockTop - 1) to (Bottom - Map.m_nBlockTop + 1) do begin
      nX := AAX + 14 - UNITX;
      for I := (Left - Map.m_nBlockLeft - 2) to (Right - Map.m_nBlockLeft + 2) do begin
        if (I >= 0) and (I < LOGICALMAPUNIT * 3) and (j >= 0) and (j < LOGICALMAPUNIT * 3) then begin
          nImgNumber := Map.m_MArr[I, j].wMidImg;
          if nImgNumber > 0 then begin
            nImgNumber := nImgNumber - 1;
            if Map.m_btBitCount = 16 then begin //2008-3-7增加读取真彩地图素材
              dsurface := g_WSmTilesImages16.Images[nImgNumber];
            end else begin
              dsurface := g_WSmTilesImages.Images[nImgNumber];
            end;
            if dsurface <> nil then
              m_MapSurface.Draw(nX, nY, dsurface.ClientRect, dsurface, True);
          end;
        end;
        Inc(nX, UNITX);
      end;
      Inc(nY, UNITY);
    end;
  end;

end;
*)

function TPlayScene.DrawTileMap: Boolean;
var
  I, j, nY, nX, nImgNumber: Integer;
  dsurface: TTexture;
  nStepX, nStepY: Integer;
  nLeft, nTop, nRight, nBottom: Integer;
  nOldLeft, nOldTop, nOldRight, nOldBottom: Integer;
  nNewLeft, nNewTop, nNewRight, nNewBottom: Integer;
begin
  Result := g_MySelf.m_btHorse = 0;
  with Map do
    if (m_ClientRect.Left = m_OldClientRect.Left) and (m_ClientRect.Top = m_OldClientRect.Top) then begin
      Exit;
    end;
  if g_MySelf.m_btHorse > 0 then begin
    if (abs(Map.m_ClientRect.Left - Map.m_OldClientRect.Left) <> 3) or (abs(Map.m_ClientRect.Top - Map.m_OldClientRect.Top) <> 3) then begin
      Result := True;
    end else Result := False;
  end;

  with Map do
    m_OldClientRect := m_ClientRect;

  if Result then m_MapSurface.Fill(0);
  //地图背景
  with Map.m_ClientRect do begin
    nY := -UNITY * 2;
    for j := (Top - Map.m_nBlockTop - 1) to (Bottom - Map.m_nBlockTop + 1) do begin
      nX := AAX + 14 - UNITX;
      for I := (Left - Map.m_nBlockLeft - 2) to (Right - Map.m_nBlockLeft + 1) do begin
        if (I >= 0) and (I < LOGICALMAPUNIT * 3) and (j >= 0) and (j < LOGICALMAPUNIT * 3) then begin
          nImgNumber := (Map.m_MArr[I, j].wBkImg and $7FFF);
          if nImgNumber > 0 then begin
            if (I mod 2 = 0) and (j mod 2 = 0) then begin
              nImgNumber := nImgNumber - 1;

              if Map.m_btBitCount = 16 then begin //2008-3-7增加读取真彩地图素材
                dsurface := g_WTilesImages16.Images[nImgNumber];
              end else begin
                dsurface := g_WTilesImages.Images[nImgNumber];
              end;

              if dsurface <> nil then begin
                //Jacky 显示地图内容
//                DrawLine(DSurface);
                m_MapSurface.Draw(nX, nY, dsurface.ClientRect, dsurface, False);
              end;
            end;
          end;
        end;
        Inc(nX, UNITX);
      end;
      Inc(nY, UNITY);
    end;
  end;

  //地图补充背景
  with Map.m_ClientRect do begin
    nY := -UNITY;
    for j := (Top - Map.m_nBlockTop - 1) to (Bottom - Map.m_nBlockTop + 1) do begin
      nX := AAX + 14 - UNITX;
      for I := (Left - Map.m_nBlockLeft - 2) to (Right - Map.m_nBlockLeft + 1) do begin
        if (I >= 0) and (I < LOGICALMAPUNIT * 3) and (j >= 0) and (j < LOGICALMAPUNIT * 3) then begin
          nImgNumber := Map.m_MArr[I, j].wMidImg;
          if nImgNumber > 0 then begin
            nImgNumber := nImgNumber - 1;

            if Map.m_btBitCount = 16 then begin //2008-3-7增加读取真彩地图素材
              dsurface := g_WSmTilesImages16.Images[nImgNumber];
            end else begin
              dsurface := g_WSmTilesImages.Images[nImgNumber];
            end;

            if dsurface <> nil then
              m_MapSurface.Draw(nX, nY, dsurface.ClientRect, dsurface, True);
          end;
        end;
        Inc(nX, UNITX);
      end;
      Inc(nY, UNITY);
    end;
  end;
end;


procedure TPlayScene.ClearDropItem;
var
  I, II: Integer;
  List: TList;
  DropItem: pTDropItem;
  //dsurface: TTexture;
begin
  //if not CanDraw then Exit;
  g_DropedItemList.Lock;
  try
    for I := g_DropedItemList.Count - 1 downto 0 do begin
      List := TList(g_DropedItemList.Items[I]);
      if List.Count > 0 then begin
        DropItem := List.Items[0];
        if (abs(DropItem.X - g_MySelf.m_nCurrX) > 30) and (abs(DropItem.Y - g_MySelf.m_nCurrY) > 30) then begin
          for II := 0 to List.Count - 1 do begin
            DropItem := List.Items[II];
            Dispose(DropItem);
          end;
          List.Free;
          g_DropedItemList.Delete(I);
        end;
      end;
    end;
  finally
    g_DropedItemList.UnLock;
  end;
end;


{-----------------------------------------------------------------------}

procedure TPlayScene.DrawMiniMap(Surface: TTexture);
begin

end;

function TPlayScene.GetShowItemName(DropItem: pTDropItem): Boolean;
var
  ShowItem: pTShowItem;
begin
  Result := False;
  if g_Config.boShowItemName then begin //显示地面物品名称
    ShowItem := g_ShowItemList.Find(DropItem.Name);
    if (ShowItem <> nil) then begin
      Result := True;
    end;
  end;
end;

procedure TPlayScene.DrawItemName(dsurface: TTexture; DropItem: pTDropItem; X, Y: Integer);
  procedure NameTextOut(FColor: Integer);
  var
    sName: string;
    nWidth: Integer;
    nHeight: Integer;
  begin
    sName := DropItem.Name;
    if sName <> '' then begin
      with dsurface do
        BoldTextOut(X + HALFX - TextWidth(sName) div 2, Y + HALFY - TextHeight(sName) div 2, sName, FColor);
    end;
  end;
var
  btColor: Byte;
  sName: string;
  ShowItem: pTShowItem;
begin
  if Assigned(g_PlugInfo.HookShowItemName) then begin
    try
      if g_PlugInfo.HookShowItemName(PChar(DropItem.Name), btColor) then begin
        NameTextOut(GetRGB(btColor));
        Exit;
      end;
    except
      DebugOutStr('g_PlugInfo.HookShowItemName');
    end;
  end else begin
    NameTextOut(GetRGB(g_ConfigClient.btItemColor) {clWhite});
    {if g_Config.boShowItemName then begin //显示地面物品名称
      ShowItem := g_ShowItemList.Find(DropItem.Name);
      if (ShowItem <> nil) and ShowItem.boShowName then begin
        NameTextOut(clWhite);
        Result := True;
      end;
    end;}
  end;
end;

procedure TPlayScene.Run(RunSelf: Boolean);
var
  I, k, drawingbottomline: Integer;
  movetick: Boolean;
  evn: TEvent;
  Actor: TActor;
  meff: TMagicEff;

  dwCheckTime, dwTestCheckTime: LongWord;
  nIdx: Integer;
  boCheckTimeLimit: Boolean;
  nCheckCode: Integer;
  dwStepMoveTime: LongWord;

  dwTickTime: LongWord;
begin
  drawingbottomline := 0;
  if (g_MySelf = nil) then begin
    Exit;
  end;
  //if GetTickCount - m_dwRunTimeTick > 10 then begin
    //m_dwRunTimeTick := GetTickCount;
  g_boDoFastFadeOut := False;

 { movetick := False;

  if g_ServerConfig.boChgSpeed then begin
    //dwStepMoveTime := g_Config.dwStepMoveTime;
    dwStepMoveTime := _MAX(100 - Trunc((g_MySelf.m_Abil.MoveSpeed * 100) / 100), 5);
  end else begin
    dwStepMoveTime := 100;
  end;

  if GetTickCount - m_dwMoveTime >= dwStepMoveTime then begin
    m_dwMoveTime := GetTickCount;
    movetick := True;
    Inc(m_nMoveStepCount);
    if m_nMoveStepCount > 1 then m_nMoveStepCount := 0;
  end; }

  if GetTickCount - m_dwAniTime >= 50 then begin
    m_dwAniTime := GetTickCount;
    Inc(m_nAniCount);
    if m_nAniCount > 100000 then m_nAniCount := 0;
  end;

  try
    //nIdx := m_nProcHumIDx;
    nIdx := 0;
    dwCheckTime := GetTickCount();
    boCheckTimeLimit := False;
    while True do begin
      nCheckCode := 0;
      if nIdx >= m_ActorList.Count then Break;
      Actor := TActor(m_ActorList.Items[nIdx]);
      nCheckCode := 1;
      if (not RunSelf) and (Actor = g_MySelf) then begin
        Inc(nIdx);
        Continue;
      end;
      nCheckCode := 2;
      dwTestCheckTime := GetTickCount();
      movetick := Actor.CanMove;
      nCheckCode := 3;
      if movetick then Actor.m_boLockEndFrame := False;
      if not Actor.m_boLockEndFrame then begin
        nCheckCode := 4;
        Actor.ProcMsg;
        nCheckCode := 5;
        if movetick then begin
          nCheckCode := 6;
          if Actor.Move(Actor.m_nMoveStepCount) then begin
            Inc(nIdx);
            nCheckCode := 7;
            {if (GetTickCount - dwCheckTime) > g_dwHumLimit then begin
              boCheckTimeLimit := True;
              m_nProcHumIDx := nIdx;
              Break;
            end;  }
            Continue;
          end;
        end;
        nCheckCode := 8;
        Actor.Run;
        nCheckCode := 9;
        if Actor <> g_MySelf then Actor.ProcHurryMsg;
        nCheckCode := 10;
      end;
      nCheckCode := 11;
      if Actor = g_MySelf then Actor.ProcHurryMsg;
      nCheckCode := 12;
      if Actor.m_nWaitForRecogId <> 0 then begin
        nCheckCode := 13;
        if Actor.IsIdle then begin
          nCheckCode := 14;
          DelChangeFace(Actor.m_nWaitForRecogId);
          nCheckCode := 15;
          NewActor(Actor.m_nWaitForRecogId, Actor.m_nCurrX, Actor.m_nCurrY, Actor.m_btDir, Actor.m_nWaitForFeature, Actor.m_nWaitForStatus);
          nCheckCode := 16;
          Actor.m_nWaitForRecogId := 0;
          Actor.m_boDelActor := True;
        end;
      end;
      nCheckCode := 17;
      if Actor.m_boDelActor then begin
        nCheckCode := 18;
        m_ActorList.Delete(nIdx);
        nCheckCode := 19;
        UpDataFreeActorList(Actor);
        nCheckCode := 20;
        if g_TargetCret = Actor then g_TargetCret := nil;
        if g_FocusCret = Actor then g_FocusCret := nil;
        if g_MagicTarget = Actor then g_MagicTarget := nil;
        if g_MyHero = Actor then g_MyHero := nil;
        if g_SerieTarget = Actor then g_SerieTarget := nil;
        nCheckCode := 21;
      end else Inc(nIdx);
      {if (GetTickCount - dwCheckTime) > g_dwHumLimit then begin
        boCheckTimeLimit := True;
        m_nProcHumIDx := nIdx;
        Break;
      end;}
    end;
    //if not boCheckTimeLimit then m_nProcHumIDx := 0;
  except
    DebugOutStr('101 Code:' + IntToStr(nCheckCode));
  end;

  try
    nIdx := 0;
    while True do begin
      if nIdx >= m_GroundEffectList.Count then Break;
      meff := m_GroundEffectList[nIdx];
      if meff.m_boActive then begin
        if not meff.Run then begin
          m_GroundEffectList.Delete(nIdx);
          meff.Free;
          Continue;
        end;
      end;
      Inc(nIdx);
    end;

    nIdx := 0;
    while True do begin
      if nIdx >= m_EffectList.Count then Break;
      meff := m_EffectList[nIdx];
      if meff.m_boActive then begin
        if not meff.Run then begin
          meff.Free;
          m_EffectList.Delete(nIdx);
          Continue;
        end;
      end;
      Inc(nIdx);
    end;

    nIdx := 0;
    while True do begin
      if nIdx >= m_FlyList.Count then Break;
      meff := m_FlyList[nIdx];
      if meff.m_boActive then begin
        if not meff.Run then begin
          meff.Free;
          m_FlyList.Delete(nIdx);
          Continue;
        end;
      end;
      Inc(nIdx);
    end;
    EventMan.Execute;
  except
    DebugOutStr('102');
  end;

  try
//清除超过显示范围的物品数据

    ClearDropItem();

//清除超过显示范围的魔法数据
    for k := 0 to EventMan.EventList.Count - 1 do begin
      evn := TEvent(EventMan.EventList[k]);
      if (abs(evn.m_nX - g_MySelf.m_nCurrX) > 30) and (abs(evn.m_nY - g_MySelf.m_nCurrY) > 30) then begin

        evn.Free;
        EventMan.EventList.Delete(k);
        Break;
      end;
    end;

    for k := 0 to EventMan.EventList.Count - 1 do begin //播放烟花声音
      evn := TEvent(EventMan.EventList[k]);
      if (abs(evn.m_nX - g_MySelf.m_nCurrX) <= 15) and (abs(evn.m_nY - g_MySelf.m_nCurrY) <= 15) then begin
        if evn.m_nEventType in [ET_FIREFLOWER_1..ET_FIREFLOWER_7] then begin
          if TFlowerEvent(evn).m_nExplosionSound > 0 then begin
            PlaySound(TFlowerEvent(evn).m_nExplosionSound);
            TFlowerEvent(evn).m_nExplosionSound := -2;
          end;
        end;
      end;
    end;
  except
    DebugOutStr('103');
  end;
  g_dwRefreshMessagesTick := GetTickCount();
  //end;
end;

{-----------------------------------------------------------------------}

procedure TPlayScene.PlayScene(MSurface: TTexture);
var
  I, j, k, n, m, mmm, ix, iy, line, defx, defy, wunit, fridx, ani, anitick, ax, ay, idx, drawingbottomline: Integer;
  dsurface, d: TTexture;
  blend, movetick: Boolean;
  DropItem: pTDropItem;
  evn: TEvent;
  Actor: TActor;
  meff: TMagicEff;
  msgstr: string;
  sName: string;
  nFColor, nBColor: Integer;
  dwCheckTime, dwTestCheckTime: LongWord;
  dwRunTime: LongWord;
  //boDrawChr: Boolean;
  nIdx: Integer;
  boCheckTimeLimit: Boolean;
  nCheckCode: Integer;
  dwStepMoveTime: LongWord;
  nWC, nHC: Integer;
  nSnowX, nSnowY: Integer;
  rc: TRect;
  nOIndex: Integer;
  List: TList;
  sBuffer, sFontName: string;
  ClientOption: TClientOption;
  dwTickTime: LongWord;

  nX, nY: Integer;
  FontSize: Integer;
  boDrawItem: Boolean;

  nIndex: Integer;

  nMouseX, nMouseY: Integer;
begin
  if Assigned(g_PlugInfo.HookPlayScene) then begin
    if g_PlugInfo.HookPlayScene(MSurface) then Exit;
  end;
  drawingbottomline := 0;
  if (g_MySelf = nil) then begin
    msgstr := 'Loading Character Select, please wait.';
    with MSurface do begin
      sFontName := MainForm.Canvas.Font.Name;
      FontSize := MainForm.Canvas.Font.Size;
      MainForm.Canvas.Font.Name := 'Arial';
      MainForm.Canvas.Font.Size := 18;
      BoldTextOut((SCREENWIDTH - TextWidth(msgstr)) div 2, (SCREENHEIGHT - 600) + 200, msgstr);
      MainForm.Canvas.Font.Name := sFontName;
      MainForm.Canvas.Font.Size := FontSize;
    end;
    Exit;
  end;

  if g_MySelf <> nil then begin
    if g_boVibration then begin
      g_nVibrationX := g_nVibrationX + g_VibrationValue[g_nVibrationPos].X;
      g_nVibrationY := g_nVibrationY + g_VibrationValue[g_nVibrationPos].Y;
      Inc(g_nVibrationPos);
      if g_nVibrationPos >= Length(g_VibrationValue) then begin
        g_nVibrationPos := 0;
        Inc(g_nVibrationCount);
      end;
      g_boVibration := g_nVibrationCount < g_nVibrationTotal;
    end;
  end;

  if g_NewStatus = sBlind then begin
    msgstr := Format('Your Character is blinded, will return to normal in %d seconds.', [g_NewStatusDelayTime]);
    with MSurface do begin
      FontSize := MainForm.Canvas.Font.Size;
      MainForm.Canvas.Font.Size := 18;
      BoldTextOut((SCREENWIDTH - TextWidth(msgstr)) div 2, (SCREENHEIGHT - 600) + 200, msgstr);
      MainForm.Canvas.Font.Size := FontSize;
    end;
    Run(TRUE);
    Exit;
  end;
  Run(TRUE);

  with Map.m_ClientRect do begin
    if SCREENWIDTH = 800 then begin
      Left := g_MySelf.m_nRx - 9;
      Right := g_MySelf.m_nRx + 9;
      if g_ConfigClient.btMainInterface in [0, 2] then begin
        Top := g_MySelf.m_nRy - 9;
        Bottom := g_MySelf.m_nRy + 8;
      end else begin
        Top := g_MySelf.m_nRy - 11;
        Bottom := g_MySelf.m_nRy + 12;
      end;
    end else begin
      Left := g_MySelf.m_nRx - 12;
      Right := g_MySelf.m_nRx + 12;

      if g_ConfigClient.btMainInterface in [0, 2] then begin
        Top := g_MySelf.m_nRy - 12;
        Bottom := g_MySelf.m_nRy + 15;
      end else begin
        Top := g_MySelf.m_nRy - 14;
        Bottom := g_MySelf.m_nRy + 18;
      end;
    end;
  end;


    {DebugOutStr('g_MySelf.m_nRx '+IntToStr(g_MySelf.m_nRx));
    DebugOutStr('g_MySelf.m_nRy '+IntToStr(g_MySelf.m_nRy));
    DebugOutStr('g_MySelf.m_nShiftx '+IntToStr(g_MySelf.m_nShiftx));
    DebugOutStr('g_MySelf.m_nShifty '+IntToStr(g_MySelf.m_nShifty));
    DebugOutStr('g_MySelf.m_nCurrX '+IntToStr(g_MySelf.m_nCurrX));
    DebugOutStr('g_MySelf.m_nCurrY '+IntToStr(g_MySelf.m_nCurrY));}

  Map.UpdateMapPos(g_MySelf.m_nRx, g_MySelf.m_nRy);


  if not g_boCanDraw then Exit;
  if (g_ConfigClient.btMainInterface = 1) or (SCREENWIDTH = 1024) then begin
    drawingbottomline := SCREENHEIGHT; // + 20
  end else begin
    drawingbottomline := 450 + 20;
  end;

  //if (GetTickCount - m_dwPlaySceneTick > 50) or (Map.m_ClientRect.Left <> Map.m_OldClientRect.Left) or (Map.m_ClientRect.Top <> Map.m_OldClientRect.Top) then begin
    //m_dwPlaySceneTick := GetTickCount;
  try
    m_nCurrX := UNITX * 3 + g_MySelf.m_nShiftX;
    m_nCurrY := UNITY * 2 + g_MySelf.m_nShiftY;

    if m_nCurrX < 0 then m_nCurrX := 0;
    if m_nCurrY < 0 then m_nCurrY := 0;
    nSnowX := m_nCurrX;
    nSnowY := m_nCurrY;

  {  if m_nOldCurrX < 0 then m_nOldCurrX := m_nCurrX;
    if m_nOldCurrY < 0 then m_nOldCurrY := m_nCurrY;  }

    //if (m_nOldCurrX <> m_nCurrX) or (m_nOldCurrY <> m_nCurrY) or (CompareText(Map.m_sCurrentMap, Map.m_sOldCurrentMap) <> 0) then begin
    m_nOldCurrX := m_nCurrX;
    m_nOldCurrY := m_nCurrY;
    DrawTileMap;
    //end;

    m_ObjSurface.Fill(0);

    if g_ConfigClient.btMainInterface in [0, 2] then begin
      m_ObjSurface.Draw(0, 0,
        Bounds(m_nCurrX, m_nCurrY, MAPSURFACEWIDTH + 20, MAPSURFACEHEIGHT + 20),
        m_MapSurface,
        False);
    end else begin
      m_ObjSurface.Draw(0, 0,
        Bounds(m_nCurrX, m_nCurrY, SCREENWIDTH + 20, SCREENHEIGHT + 20),
        m_MapSurface,
        False);
    end;

  except
    DebugOutStr('104');
  end;

  defx := -UNITX * 2 - g_MySelf.m_nShiftX + AAX + 14;
  defy := -UNITY * 2 - g_MySelf.m_nShiftY;
  m_nDefXX := defx;
  m_nDefYY := defy;

  try
    m := defy - UNITY;
    for j := (Map.m_ClientRect.Top - Map.m_nBlockTop) to (Map.m_ClientRect.Bottom - Map.m_nBlockTop + LONGHEIGHT_IMAGE) do begin
      if j < 0 then begin
        Inc(m, UNITY);
        Continue;
      end;
      n := defx - UNITX * 2;
      for I := (Map.m_ClientRect.Left - Map.m_nBlockLeft - 2) to (Map.m_ClientRect.Right - Map.m_nBlockLeft + 2) do begin
        if (I >= 0) and (I < LOGICALMAPUNIT * 3) and (j >= 0) and (j < LOGICALMAPUNIT * 3) then begin
          fridx := (Map.m_MArr[I, j].wFrImg) and $7FFF;
          if fridx > 0 then begin
            ani := Map.m_MArr[I, j].btAniFrame;
            wunit := Map.m_MArr[I, j].btArea;
            if (ani and $80) > 0 then begin
              blend := True;
              ani := ani and $7F;
            end;
            if ani > 0 then begin
              anitick := Map.m_MArr[I, j].btAniTick;
              fridx := fridx + (m_nAniCount mod (ani + (ani * anitick))) div (1 + anitick);
            end;
            if (Map.m_MArr[I, j].btDoorOffset and $80) > 0 then begin
              if (Map.m_MArr[I, j].btDoorIndex and $7F) > 0 then
                fridx := fridx + (Map.m_MArr[I, j].btDoorOffset and $7F);
            end;
            fridx := fridx - 1;

            if Map.m_btBitCount = 16 then begin //2008-3-7增加读取真彩地图素材
              dsurface := GetObjs16(wunit, fridx);
            end else begin
              dsurface := GetObjs(wunit, fridx);
            end;

            if dsurface <> nil then begin
              if (dsurface.Width = 48) and (dsurface.Height = 32) then begin
                mmm := m + UNITY - dsurface.Height;
                if (n + dsurface.Width > 0) and (n <= SCREENWIDTH) and (mmm + dsurface.Height > 0) and (mmm < drawingbottomline) then begin
                  m_ObjSurface.Draw(n, mmm, dsurface.ClientRect, dsurface, True)
                end else begin
                  if mmm < drawingbottomline then begin
                    m_ObjSurface.Draw(n, mmm, dsurface.ClientRect, dsurface, True)
                  end;
                end;
              end;
            end;
          end;
        end;
        Inc(n, UNITX);
      end;
      Inc(m, UNITY);
    end;
  except
    DebugOutStr('105');
  end;

  for k := 0 to m_GroundEffectList.Count - 1 do begin
    meff := TMagicEff(m_GroundEffectList[k]);
    meff.DrawEff(m_ObjSurface);
  end;

  dwRunTime := GetTickCount();
  dwCheckTime := GetTickCount();
  boCheckTimeLimit := False;
  try
    nCheckCode := 0;
    m := defy - UNITY;
    for j := Map.m_ClientRect.Top - Map.m_nBlockTop to Map.m_ClientRect.Bottom - Map.m_nBlockTop + LONGHEIGHT_IMAGE do begin
      if (j < 0) then begin
        Inc(m, UNITY);
        Continue;
      end;
      nCheckCode := 1;
      n := defx - UNITX * 2;
      for I := (Map.m_ClientRect.Left - Map.m_nBlockLeft - 2) to (Map.m_ClientRect.Right - Map.m_nBlockLeft + 2) do begin
        if (I >= 0) and (I < LOGICALMAPUNIT * 3) and (j >= 0) and (j < LOGICALMAPUNIT * 3) then begin
          fridx := (Map.m_MArr[I, j].wFrImg) and $7FFF;
          if fridx > 0 then begin
            blend := False;
            wunit := Map.m_MArr[I, j].btArea;
            ani := Map.m_MArr[I, j].btAniFrame;
            if (ani and $80) > 0 then begin
              blend := True;
              ani := ani and $7F;
            end;
            if ani > 0 then begin
              anitick := Map.m_MArr[I, j].btAniTick;
              fridx := fridx + (m_nAniCount mod (ani + (ani * anitick))) div (1 + anitick);
            end;
            if (Map.m_MArr[I, j].btDoorOffset and $80) > 0 then begin
              if (Map.m_MArr[I, j].btDoorIndex and $7F) > 0 then
                fridx := fridx + (Map.m_MArr[I, j].btDoorOffset and $7F);
            end;
            fridx := fridx - 1;
            if not blend then begin

              if Map.m_btBitCount = 16 then begin //2008-3-7增加读取真彩地图素材
                dsurface := GetObjs16(wunit, fridx);
              end else begin
                dsurface := GetObjs(wunit, fridx);
              end;

              if dsurface <> nil then begin
                if (dsurface.Width <> 48) or (dsurface.Height <> 32) then begin
                  mmm := m + UNITY - dsurface.Height;
                  if (n + dsurface.Width > 0) and (n <= SCREENWIDTH) and (mmm + dsurface.Height > 0) and (mmm < drawingbottomline) then begin
                    nCheckCode := 2;
                    m_ObjSurface.Draw(n, mmm, dsurface.ClientRect, dsurface, True);
                    nCheckCode := 3;
                  end else begin
                    if mmm < drawingbottomline then begin
                      nCheckCode := 4;
                      m_ObjSurface.Draw(n, mmm, dsurface.ClientRect, dsurface, True);
                      nCheckCode := 5;
                    end;
                  end;
                end;
              end;

            end else begin

              if Map.m_btBitCount = 16 then begin //2008-3-7增加读取真彩地图素材
                dsurface := GetObjsEx16(wunit, fridx, ax, ay);
              end else begin
                dsurface := GetObjsEx(wunit, fridx, ax, ay);
              end;

              if dsurface <> nil then begin
                mmm := m + ay - 68; //UNITY - DSurface.Height;
                if (n > 0) and (mmm + dsurface.Height > 0) and (n + dsurface.Width < SCREENWIDTH) and (mmm < drawingbottomline) then begin
                  nCheckCode := 6;
                  DrawBlend(m_ObjSurface, n + ax - 2, mmm, dsurface);
                  nCheckCode := 7;
                end else begin
                  if mmm < drawingbottomline then begin
                    nCheckCode := 8;
                    DrawBlend(m_ObjSurface, n + ax - 2, mmm, dsurface);
                    nCheckCode := 9;
                  end;
                end;
              end;
            end;
          end;
        end;
        Inc(n, UNITX);
      end;

      if (j <= (Map.m_ClientRect.Bottom - Map.m_nBlockTop)) and (not g_boServerChanging) then begin
        for k := 0 to EventMan.EventList.Count - 1 do begin
          //if GetTickCount - dwCheckTime > 40 then break;
          evn := TEvent(EventMan.EventList.Items[k]);
          if j = (evn.m_nY - Map.m_nBlockTop) then begin
            nCheckCode := 10;
            evn.DrawEvent(m_ObjSurface,
              (evn.m_nX - Map.m_ClientRect.Left) * UNITX + defx,
              m);
            nCheckCode := 11;
          end;
        end;

        if g_boDrawDropItem then begin
          //显示地面物品外形
          g_DropedItemList.Lock;
          try
            for k := 0 to g_DropedItemList.Count - 1 do begin
              List := TList(g_DropedItemList.Items[k]);
              if List.Count > 0 then begin
                if not g_Config.boShowItemName then begin
                  DropItem := pTDropItem(List.Items[0]);
                  if DropItem <> nil then begin
                    if j = (DropItem.Y - Map.m_nBlockTop) then begin
                      d := g_WDnItemImages.Images[DropItem.looks];
                      if d <> nil then begin
                        ix := (DropItem.X - Map.m_ClientRect.Left) * UNITX + defx + SOFFX; // + actor.ShiftX;
                        iy := m; // + actor.ShiftY;
                        if DropItem = g_FocusItem then begin
                          nCheckCode := 12;

                          g_ImgMixSurface.SetSize(d.Width, d.Height);
                        //g_ImgMixSurface.Fill(0);
                          g_ImgMixSurface.Draw(0, 0, d.ClientRect, d, False);
                          nCheckCode := 13;
                          DrawEffect(0, 0, g_ImgMixSurface, d, ceBright);
                      //g_ImgMixSurface.Fill(0);
                      //DrawEffect(0, 0, g_ImgMixSurface, d, ceBright);
                          nCheckCode := 14;
                          m_ObjSurface.Draw(ix + HALFX - (d.Width div 2),
                            iy + HALFY - (d.Height div 2),
                            d.ClientRect,
                            g_ImgMixSurface, True);
                          nCheckCode := 15;
                        end else begin
                          nCheckCode := 16;
                          m_ObjSurface.Draw(ix + HALFX - (d.Width div 2),
                            iy + HALFY - (d.Height div 2),
                            d.ClientRect,
                            d, True);
                          nCheckCode := 17;
                        end;
                      end;
                    end;
                  end;
                end else begin
                  boDrawItem := False;
                  for nIdx := 0 to List.Count - 1 do begin
                    DropItem := pTDropItem(List.Items[nIdx]);
                    if DropItem <> nil then begin
                      if GetShowItemName(DropItem) then begin
                        boDrawItem := True;
                        if j = (DropItem.Y - Map.m_nBlockTop) then begin
                          d := g_WDnItemImages.Images[DropItem.looks];
                          if d <> nil then begin
                            ix := (DropItem.X - Map.m_ClientRect.Left) * UNITX + defx + SOFFX; // + actor.ShiftX;
                            iy := m; // + actor.ShiftY;
                            if DropItem = g_FocusItem then begin
                              nCheckCode := 12;

                              g_ImgMixSurface.SetSize(d.Width, d.Height);
                        //g_ImgMixSurface.Fill(0);
                              g_ImgMixSurface.Draw(0, 0, d.ClientRect, d, False);
                              nCheckCode := 13;
                              DrawEffect(0, 0, g_ImgMixSurface, d, ceBright);
                      //g_ImgMixSurface.Fill(0);
                      //DrawEffect(0, 0, g_ImgMixSurface, d, ceBright);
                              nCheckCode := 14;
                              m_ObjSurface.Draw(ix + HALFX - (d.Width div 2),
                                iy + HALFY - (d.Height div 2),
                                d.ClientRect,
                                g_ImgMixSurface, True);
                              nCheckCode := 15;
                            end else begin
                              nCheckCode := 16;
                              m_ObjSurface.Draw(ix + HALFX - (d.Width div 2),
                                iy + HALFY - (d.Height div 2),
                                d.ClientRect,
                                d, True);
                              nCheckCode := 17;
                            end;
                          end;
                        end;
                        break;
                      end;
                    end;
                  end;

                  if not boDrawItem then begin
                    DropItem := pTDropItem(List.Items[0]);
                    if DropItem <> nil then begin
                      if j = (DropItem.Y - Map.m_nBlockTop) then begin
                        d := g_WDnItemImages.Images[DropItem.looks];
                        if d <> nil then begin
                          ix := (DropItem.X - Map.m_ClientRect.Left) * UNITX + defx + SOFFX; // + actor.ShiftX;
                          iy := m; // + actor.ShiftY;
                          if DropItem = g_FocusItem then begin
                            nCheckCode := 12;

                            g_ImgMixSurface.SetSize(d.Width, d.Height);
                        //g_ImgMixSurface.Fill(0);
                            g_ImgMixSurface.Draw(0, 0, d.ClientRect, d, False);
                            nCheckCode := 13;
                            DrawEffect(0, 0, g_ImgMixSurface, d, ceBright);
                      //g_ImgMixSurface.Fill(0);
                      //DrawEffect(0, 0, g_ImgMixSurface, d, ceBright);
                            nCheckCode := 14;
                            m_ObjSurface.Draw(ix + HALFX - (d.Width div 2),
                              iy + HALFY - (d.Height div 2),
                              d.ClientRect,
                              g_ImgMixSurface, True);
                            nCheckCode := 15;
                          end else begin
                            nCheckCode := 16;
                            m_ObjSurface.Draw(ix + HALFX - (d.Width div 2),
                              iy + HALFY - (d.Height div 2),
                              d.ClientRect,
                              d, True);
                            nCheckCode := 17;
                          end;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          finally
            g_DropedItemList.UnLock;
          end;
        end;

        for k := 0 to m_ActorList.Count - 1 do begin
          Actor := TActor(m_ActorList.Items[k]);

          if (j = Actor.m_nRy - Map.m_nBlockTop - Actor.m_nDownDrawLevel) then begin
            Actor.m_nSayX := (Actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx + Actor.m_nShiftX + 24;
            if Actor.m_boDeath then
              Actor.m_nSayY := m + UNITY + Actor.m_nShiftY + 16 - 60 + (Actor.m_nDownDrawLevel * UNITY)
            else Actor.m_nSayY := m + UNITY + Actor.m_nShiftY + 16 - 95 + (Actor.m_nDownDrawLevel * UNITY);
            nCheckCode := 18;

            Actor.DrawChr(m_ObjSurface, (Actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx,
              m + (Actor.m_nDownDrawLevel * UNITY),
              False, True);

            nCheckCode := 19;
          end;
        end;
        for k := 0 to m_FlyList.Count - 1 do begin
          meff := TMagicEff(m_FlyList.Items[k]);
          if j = (meff.ry - Map.m_nBlockTop) then
            meff.DrawEff(m_ObjSurface);
        end;
      end;
      Inc(m, UNITY);
    end;

  except
    DebugOutStr('106 nCheckCode:' + IntToStr(nCheckCode));
  end;


  if not g_boServerChanging then begin
    try
      if not g_boCheckBadMapMode then
        if (g_MySelf <> nil) and IsValidActor(g_MySelf) and (g_MySelf.m_nState and $00800000 = 0) then
          g_MySelf.DrawChr(m_ObjSurface, (g_MySelf.m_nRx - Map.m_ClientRect.Left) * UNITX + defx, (g_MySelf.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + defy, True, False);

      if (g_FocusCret <> nil) then begin
        if IsValidActor(g_FocusCret) and (g_FocusCret <> g_MySelf) then
          if (g_FocusCret.m_nState and $00800000 = 0) then //Jacky
            g_FocusCret.DrawChr(m_ObjSurface,
              (g_FocusCret.m_nRx - Map.m_ClientRect.Left) * UNITX + defx,
              (g_FocusCret.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + defy, True, False);
      end;

      if (g_MagicTarget <> nil) then begin
        if IsValidActor(g_MagicTarget) and (g_MagicTarget <> g_MySelf) then
          if g_MagicTarget.m_nState and $00800000 = 0 then
            g_MagicTarget.DrawChr(m_ObjSurface,
              (g_MagicTarget.m_nRx - Map.m_ClientRect.Left) * UNITX + defx,
              (g_MagicTarget.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + defy, True, False);
      end;
    except
      DebugOutStr('108');
    end;
  end;

  try
    for k := 0 to m_ActorList.Count - 1 do begin
      Actor := m_ActorList[k];
      Actor.DrawEff(m_ObjSurface,
        (Actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx,
        (Actor.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + defy);
    end;

    for k := 0 to m_EffectList.Count - 1 do begin
      meff := TMagicEff(m_EffectList[k]);
      meff.DrawEff(m_ObjSurface);
    end;
  except
    DebugOutStr('109');
  end;

  //地面物品闪亮
  try
    g_DropedItemList.Lock;
    try
      for k := 0 to g_DropedItemList.Count - 1 do begin
      //RefreshMessages;
       // if GetTickCount - dwCheckTime > 30 then break;
        List := TList(g_DropedItemList.Items[k]);
        if List.Count > 0 then begin
          //for I := 0 to List.Count - 1 do begin
          if not g_Config.boShowItemName then begin
            DropItem := pTDropItem(List.Items[0]);
            if DropItem <> nil then begin
              if GetTickCount - DropItem.FlashTime > g_dwDropItemFlashTime then begin
                DropItem.FlashTime := GetTickCount;
                DropItem.BoFlash := True;
                DropItem.FlashStepTime := GetTickCount;
                DropItem.FlashStep := 0;
              end;
              ix := (DropItem.X - Map.m_ClientRect.Left) * UNITX + defx + SOFFX;
              iy := (DropItem.Y - Map.m_ClientRect.Top - 1) * UNITY + defy + SOFFY;
              if DropItem.BoFlash then begin
                if GetTickCount - DropItem.FlashStepTime >= 20 then begin
                  DropItem.FlashStepTime := GetTickCount;
                  Inc(DropItem.FlashStep);
                end;
                if (DropItem.FlashStep >= 0) and (DropItem.FlashStep < 10) then begin
                  dsurface := g_WMainImages.GetCachedImage(FLASHBASE + DropItem.FlashStep, ax, ay);
                  if dsurface <> nil then
                    DrawBlend(m_ObjSurface, ix + ax, iy + ay, dsurface);
            //DrawBlendAnti16(m_ObjSurface, ix + ax, iy + ay, dsurface, 0, 0, dsurface.Width, dsurface.Height);
                end else DropItem.BoFlash := False;
              end;
            //DrawItemName(m_ObjSurface, DropItem, ix, iy);
            end;
          end else begin
            boDrawItem := False;
            for I := 0 to List.Count - 1 do begin
              DropItem := pTDropItem(List.Items[I]);
              if DropItem <> nil then begin
                if GetShowItemName(DropItem) then begin
                  boDrawItem := True;
                  if GetTickCount - DropItem.FlashTime > g_dwDropItemFlashTime then begin
                    DropItem.FlashTime := GetTickCount;
                    DropItem.BoFlash := True;
                    DropItem.FlashStepTime := GetTickCount;
                    DropItem.FlashStep := 0;
                  end;
                  ix := (DropItem.X - Map.m_ClientRect.Left) * UNITX + defx + SOFFX;
                  iy := (DropItem.Y - Map.m_ClientRect.Top - 1) * UNITY + defy + SOFFY;
                  if DropItem.BoFlash then begin
                    if GetTickCount - DropItem.FlashStepTime >= 20 then begin
                      DropItem.FlashStepTime := GetTickCount;
                      Inc(DropItem.FlashStep);
                    end;
                    if (DropItem.FlashStep >= 0) and (DropItem.FlashStep < 10) then begin
                      dsurface := g_WMainImages.GetCachedImage(FLASHBASE + DropItem.FlashStep, ax, ay);
                      if dsurface <> nil then
                        DrawBlend(m_ObjSurface, ix + ax, iy + ay, dsurface);
            //DrawBlendAnti16(m_ObjSurface, ix + ax, iy + ay, dsurface, 0, 0, dsurface.Width, dsurface.Height);
                    end else DropItem.BoFlash := False;
                  end;
                  DrawItemName(m_ObjSurface, DropItem, ix, iy);
                  break;
                end;
              end;
            end; //for I := 0 to List.Count - 1 do begin
            if not boDrawItem then begin
              DropItem := pTDropItem(List.Items[0]);
              if DropItem <> nil then begin
                if GetTickCount - DropItem.FlashTime > g_dwDropItemFlashTime then begin
                  DropItem.FlashTime := GetTickCount;
                  DropItem.BoFlash := True;
                  DropItem.FlashStepTime := GetTickCount;
                  DropItem.FlashStep := 0;
                end;
                ix := (DropItem.X - Map.m_ClientRect.Left) * UNITX + defx + SOFFX;
                iy := (DropItem.Y - Map.m_ClientRect.Top - 1) * UNITY + defy + SOFFY;
                if DropItem.BoFlash then begin
                  if GetTickCount - DropItem.FlashStepTime >= 20 then begin
                    DropItem.FlashStepTime := GetTickCount;
                    Inc(DropItem.FlashStep);
                  end;
                  if (DropItem.FlashStep >= 0) and (DropItem.FlashStep < 10) then begin
                    dsurface := g_WMainImages.GetCachedImage(FLASHBASE + DropItem.FlashStep, ax, ay);
                    if dsurface <> nil then
                      DrawBlend(m_ObjSurface, ix + ax, iy + ay, dsurface);
            //DrawBlendAnti16(m_ObjSurface, ix + ax, iy + ay, dsurface, 0, 0, dsurface.Width, dsurface.Height);
                  end else DropItem.BoFlash := False;
                end;
                //if GetShowItemName(DropItem) then
                  //DrawItemName(m_ObjSurface, DropItem, ix, iy);
              end;
            end;
          end;
        end; //if List.Count > 0 then begin
      end;
    finally
      g_DropedItemList.UnLock;
    end;
  except
    DebugOutStr('110');
  end;

  if g_boSnow then begin //下雪

    nOIndex := g_DrawSnowTick[0].nIndex;
    if GetTickCount - g_DrawSnowTick[0].dwDrawTick > 100 then begin
      Inc(g_DrawSnowTick[0].nIndex);
      g_DrawSnowTick[0].dwDrawTick := GetTickCount;
    end;
    if not ((g_DrawSnowTick[0].nIndex >= 3020) and (g_DrawSnowTick[0].nIndex <= 3031)) then g_DrawSnowTick[0].nIndex := 3020;

    if nOIndex <> g_DrawSnowTick[0].nIndex then begin
      m_SnowSurface.Fill(0);
      nWC := 0;
      nHC := 0;
      while True do begin
        dsurface := g_WNpcImgImages.Images[g_DrawSnowTick[0].nIndex];
        if dsurface <> nil then begin
          rc := dsurface.ClientRect;
          rc.Left := 30;
          rc.Top := 30;
          rc.Right := rc.Right - 30;
          rc.Bottom := rc.Bottom - 100;
          m_SnowSurface.Draw(nWC, nHC, rc, dsurface, False);
          Inc(nWC, rc.Right - rc.Left);
          if nWC >= m_SnowSurface.Width then begin
            nWC := 0;
            Inc(nHC, rc.Bottom - rc.Top);
          end;
          if nHC >= m_SnowSurface.Height then Break;
        end else Break;
      end;
    end;

    if g_ConfigClient.btMainInterface in [0, 2] then begin
      case g_nSnowLev of
        1: begin
            DrawBlendEx(m_ObjSurface, 0, 0, m_SnowSurface, nSnowX, nSnowY, nSnowX + MAPSURFACEWIDTH, nSnowY + MAPSURFACEHEIGHT);
          end;
        2: begin
            DrawBlendEx(m_ObjSurface, 0, 1, m_SnowSurface, nSnowX, nSnowY, nSnowX + MAPSURFACEWIDTH, nSnowY + MAPSURFACEHEIGHT);
            DrawBlendEx(m_ObjSurface, 1, 0, m_SnowSurface, nSnowX, nSnowY, nSnowX + MAPSURFACEWIDTH, nSnowY + MAPSURFACEHEIGHT);
          end;
        3: begin
            DrawBlendEx(m_ObjSurface, 0, 1, m_SnowSurface, nSnowX, nSnowY, nSnowX + MAPSURFACEWIDTH, nSnowY + MAPSURFACEHEIGHT);
            DrawBlendEx(m_ObjSurface, 1, 0, m_SnowSurface, nSnowX, nSnowY, nSnowX + MAPSURFACEWIDTH, nSnowY + MAPSURFACEHEIGHT);
            DrawBlendEx(m_ObjSurface, 1, 1, m_SnowSurface, nSnowX, nSnowY, nSnowX + MAPSURFACEWIDTH, nSnowY + MAPSURFACEHEIGHT);
            DrawBlendEx(m_ObjSurface, 0, 0, m_SnowSurface, nSnowX, nSnowY, nSnowX + MAPSURFACEWIDTH, nSnowY + MAPSURFACEHEIGHT);
          end;
      else begin
          DrawBlendEx(m_ObjSurface, 0, 0, m_SnowSurface, nSnowX, nSnowY, nSnowX + MAPSURFACEWIDTH, nSnowY + MAPSURFACEHEIGHT);
        end;
      end;
    end else begin
      case g_nSnowLev of
        1: begin
            DrawBlendEx(m_ObjSurface, 0, 0, m_SnowSurface, nSnowX, nSnowY, nSnowX + SCREENWIDTH, nSnowY + SCREENHEIGHT);
          end;
        2: begin
            DrawBlendEx(m_ObjSurface, 0, 1, m_SnowSurface, nSnowX, nSnowY, nSnowX + SCREENWIDTH, nSnowY + SCREENHEIGHT);
            DrawBlendEx(m_ObjSurface, 1, 0, m_SnowSurface, nSnowX, nSnowY, nSnowX + SCREENWIDTH, nSnowY + SCREENHEIGHT);
          end;
        3: begin
            DrawBlendEx(m_ObjSurface, 0, 1, m_SnowSurface, nSnowX, nSnowY, nSnowX + SCREENWIDTH, nSnowY + SCREENHEIGHT);
            DrawBlendEx(m_ObjSurface, 1, 0, m_SnowSurface, nSnowX, nSnowY, nSnowX + SCREENWIDTH, nSnowY + SCREENHEIGHT);
            DrawBlendEx(m_ObjSurface, 1, 1, m_SnowSurface, nSnowX, nSnowY, nSnowX + SCREENWIDTH, nSnowY + SCREENHEIGHT);
            DrawBlendEx(m_ObjSurface, 0, 0, m_SnowSurface, nSnowX, nSnowY, nSnowX + SCREENWIDTH, nSnowY + SCREENHEIGHT);
          end;
      else begin
          DrawBlendEx(m_ObjSurface, 0, 0, m_SnowSurface, nSnowX, nSnowY, nSnowX + SCREENWIDTH, nSnowY + SCREENHEIGHT);
        end;
      end;
    end;
  end;

  try
    if g_NewStatus = sConfusion then begin
      msgstr := Format('Your Character is confused, will return to normal in %d seconds. ', [g_NewStatusDelayTime]);
      with m_ObjSurface do begin
        FontSize := MainForm.Canvas.Font.Size;
        MainForm.Canvas.Font.Size := 18;
        m_ObjSurface.BoldTextOut((SCREENWIDTH - m_ObjSurface.TextWidth(msgstr)) div 2, (SCREENHEIGHT - 600) + 200, msgstr,
          clRed, clWhite);
        MainForm.Canvas.Font.Size := FontSize;
      end;
    end;

    for k := 0 to m_ActorList.Count - 1 do begin
      Actor := TActor(m_ActorList.Items[k]);
      if not Actor.m_boDeath then begin
        if (Actor.m_boOpenHealth or Actor.m_noInstanceOpenHealth) and (g_NewStatus <> sBlind) then begin
          Actor.ShowActorLable(m_ObjSurface);
        end;
        if g_Config.boShowMoveLable and (g_NewStatus <> sBlind) then
          Actor.ShowHealthStatus(m_ObjSurface);
      end;
    end;

      //显示角色说话文字

    if g_NewStatus <> sBlind then begin
      for k := 0 to m_ActorList.Count - 1 do begin
        Actor := m_ActorList[k];
        Actor.ShowSayMsg(m_ObjSurface);
      end;
    end;

    if (g_nAreaStateValue and $04) <> 0 then begin
      m_ObjSurface.BoldTextOut(0, 0, '攻城区域');
    end;

    k := 0;
    for I := 0 to 15 do begin
      if g_nAreaStateValue and ($01 shr I) <> 0 then begin
        d := g_WMainImages.Images[AREASTATEICONBASE + I];
        if d <> nil then begin
          k := k + d.Width;
          m_ObjSurface.Draw(SCREENWIDTH - k, 0, d.ClientRect, d, True);
        end;
      end;
    end;

  //if (not CanDraw) or (g_MySelf = nil) or (g_ConnectionStep <> cnsPlay) then Exit;
    if g_NewStatus <> sBlind then begin
      for k := 0 to m_ActorList.Count - 1 do begin
        Actor := TActor(m_ActorList.Items[k]);
        if (not Actor.m_boDeath) and (abs(Actor.m_nCurrX - g_MySelf.m_nCurrX) <= 8) and (abs(Actor.m_nCurrY - g_MySelf.m_nCurrY) <= 7) then begin
          
        end;
      end;

      if (g_FocusCret <> nil) and IsValidActor(g_FocusCret) then begin
        sName := g_FocusCret.m_sDescUserName + '\' + g_FocusCret.m_sUserName;
        g_FocusCret.NameTextOut(m_ObjSurface, sName,
          g_FocusCret.m_nSayX,
          g_FocusCret.m_nSayY + 30,
          g_FocusCret.m_nNameColor);
      end;

      if (g_MySelf <> nil) then begin
        if IsSelectMyself(g_nMouseX, g_nMouseY) then begin
          sName := g_MySelf.m_sDescUserName + '\' + g_MySelf.m_sUserName;
          g_MySelf.NameTextOut(m_ObjSurface, sName,
            g_MySelf.m_nSayX,
            g_MySelf.m_nSayY + 30,
            g_MySelf.m_nNameColor);
        end;
      end;
    end;
  except
    DebugOutStr('111');
  end;
  //end { else DebugOutStr('<50')};
  try
    g_boViewFog := False; //Jacky 免蜡
    //if g_boViewFog and not g_boForceNotViewFog then begin
    //  MSurface.Draw(SOFFX, SOFFY, m_ObjSurface.ClientRect, m_ObjSurface, False);
    //end else begin
    if g_MySelf.m_boDeath then //人物死亡，显示黑白画面
        //DrawEffect(0, 0, m_ObjSurface.Width, m_ObjSurface.Height, m_ObjSurface, g_DeathColorEffect {ceGrayScale});
      DrawEffect(0, 0, m_ObjSurface, m_ObjSurface, g_DeathColorEffect);
      //MSurface.Draw(SOFFX, SOFFY, m_ObjSurface.ClientRect, m_ObjSurface, False);
    MSurface.Draw(g_nVibrationX, g_nVibrationY, m_ObjSurface.ClientRect, m_ObjSurface, False);

    //end;
  except
    DebugOutStr('112');
  end;
end;

{-------------------------------------------------------}

procedure TPlayScene.NewMagic(aowner: TActor;
  magid, magnumb {Effect}, cx, cy, tx, ty, targetcode: Integer;
  mtype: TMagicType; //EffectType
  Recusion: Boolean;
  anitime: Integer;
  var bofly: Boolean);
var
  I, scx, scy, sctx, scty, effnum, effbase: Integer;
  meff: TMagicEff;
  target: TActor;
  wimg: TGameImages;
begin
  bofly := False;
  if magid <> 111 then begin
    for I := 0 to m_EffectList.Count - 1 do begin
      if TMagicEff(m_EffectList[I]).ServerMagicId = magid then begin
        //DScreen.AddChatBoardString(IntToStr(magid)+' TPlayScene.NewMagic', clWhite, clPurple);
        Exit;
      end;
    end;
  end;
  ScreenXYfromMCXY(cx, cy, scx, scy);
  ScreenXYfromMCXY(tx, ty, sctx, scty);
  if magnumb > 0 then GetEffectBase(magnumb - 1, 0, wimg, effnum) //magnumb{Effect}
  else effnum := -magnumb;

  target := FindActor(targetcode);
  meff := nil;
  case mtype of //EffectType
    mtReady, mtFly, mtFlyAxe: begin
        if magnumb = 39 then begin
          meff := TMagicEff.Create(magid {替为magnumb，击中后的效果改变了}, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
          meff.TargetActor := target;
          meff.frame := 4;
          if wimg <> nil then
            meff.ImgLib := wimg;
        end else
          if magnumb = 63 then begin //噬魂沼泽
          meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
          meff.TargetActor := target;
          meff.ImgLib := g_WMagic4Images;
          meff.MagExplosionBase := 780;
          meff.ExplosionFrame := 50;
          meff.frame := 6;
        end else
          if magnumb = 64 then begin //末日审判
          meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtExplosion, Recusion, anitime);
          meff.MagExplosionBase := 230;
          meff.NextFrameTime := 60;
          meff.ExplosionFrame := 40;
          meff.light := 3;
          meff.ImgLib := g_WMagic4Images;
        end else
          if magnumb = 199 then begin //月灵攻击
          meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
          meff.frame := 3;
          meff.ImgLib := g_WMagic5Images;
          meff.MagExplosionBase := 270;
          meff.NextFrameTime := 60;
          meff.ExplosionFrame := 10;
          meff.light := 3;
          meff.TargetActor := FindActor(aowner.m_nTargetRecog);
        end else
          if magnumb = 200 then begin //月灵重击
          meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
          meff.frame := 6;
          meff.ImgLib := g_WMagic5Images;
          meff.MagExplosionBase := 450;
          meff.NextFrameTime := 60;
          meff.ExplosionFrame := 10;
          meff.light := 3;
          meff.TargetActor := FindActor(aowner.m_nTargetRecog);
        end else
          if magnumb = 104 then begin //双龙破
          meff := TMagicEff.Create(magid, 2610 - 10, scx, scy, sctx, scty, mtype, Recusion, anitime);
          meff.EffectNumber := magnumb;
          meff.ImgLib := g_cboEffectImg;
          meff.TargetActor := target;
          meff.MagExplosionBase := 2770;
          meff.NextFrameTime := 50;
          meff.ExplosionFrame := 25;
          meff.frame := 5;
        end else
          if magnumb = 105 then begin //凤舞祭
          meff := TMagicEff.Create(magid, 2420 - 10, scx, scy, sctx, scty, mtype, Recusion, anitime);
          meff.EffectNumber := magnumb;
          meff.ImgLib := g_cboEffectImg;
          meff.TargetActor := target;
          meff.MagExplosionBase := 2580;
          meff.NextFrameTime := 100;
          meff.ExplosionFrame := 8;
          meff.frame := 3;
        end else
          if magnumb = 106 then begin //惊雷爆
          meff := TMagicEff.Create(magid, 4230 - 10, scx, scy, sctx, scty, mtype, Recusion, anitime);
          meff.EffectNumber := magnumb;
          meff.ImgLib := g_cboEffectImg;
          meff.TargetActor := target;
          meff.MagExplosionBase := 4240;
          meff.NextFrameTime := 100;
          meff.ExplosionFrame := 7;
          meff.frame := 4;
        end else
          if magnumb = 109 then begin //八卦掌
          meff := TMagicEff.Create(magid, 2090 - 10, scx, scy, sctx, scty, mtype, Recusion, anitime);
          meff.EffectNumber := magnumb;
          meff.ImgLib := g_cboEffectImg;
          meff.TargetActor := target;
          meff.MagExplosionBase := 2251;
          meff.NextFrameTime := 100;
          meff.ExplosionFrame := 4;
          meff.frame := 3;
        end else
          if magnumb = 111 then begin //万剑归宗
          meff := TMagicEff.Create(magid, 2820 - 10, scx, scy, sctx, scty, mtype, Recusion, anitime);
          meff.EffectNumber := magnumb;
          meff.ImgLib := g_cboEffectImg;
          meff.TargetActor := target;
          meff.MagExplosionBase := 2980;
          meff.NextFrameTime := 100;
          meff.ExplosionFrame := 10;
          meff.frame := 5;
        end else begin
          meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
          meff.TargetActor := target;
          if wimg <> nil then
            meff.ImgLib := wimg;
        end;
        bofly := True;
      end;
    mtExplosion:
      case magnumb of
        18: begin //诱惑之光
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1570;
            meff.TargetActor := target;
            meff.NextFrameTime := 80;
          end;
        21: begin //爆裂火焰
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1660;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 20;
            meff.light := 3;
          end;
        26: begin //心灵启示
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 3990;
            meff.TargetActor := target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 10;
            meff.light := 2;
          end;
        27: begin //群体治疗术
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1800;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 10;
            meff.light := 3;
          end;
        30: begin //圣言术
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 3930;
            meff.TargetActor := target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 16;
            meff.light := 3;
          end;
        31: begin //冰咆哮
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 3850;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 20;
            meff.light := 3;
          end;
        34: begin //灭天火
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 140;
            meff.TargetActor := target; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 20;
            meff.light := 3;
            if wimg <> nil then
              meff.ImgLib := wimg;
          end;
        40: begin // 净化术
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 620;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 100;
            meff.ExplosionFrame := 20;
            meff.light := 3;
            if wimg <> nil then
              meff.ImgLib := wimg;
          end;
        45: begin //火龙气焰
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 920;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 100;
            meff.ExplosionFrame := 20;
            meff.light := 3;
            if wimg <> nil then
              meff.ImgLib := wimg;
          end;
        47: begin //飓风破
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1010;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 100;
            meff.ExplosionFrame := 20;
            meff.light := 3;
            if wimg <> nil then
              meff.ImgLib := wimg;
          end;
        48: begin //血咒
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1060;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 50;
            meff.ExplosionFrame := 40;
            meff.light := 3;
            if wimg <> nil then
              meff.ImgLib := wimg;
          end;
        49: begin //骷髅咒
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1110;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 100;
            meff.ExplosionFrame := 10;
            meff.light := 3;
            if wimg <> nil then
              meff.ImgLib := wimg;
          end;
        50: begin //分身术
            meff := TMagicEff.Create(magid, effnum + 80, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 90;
            meff.TargetActor := target;
            meff.NextFrameTime := 100;
            meff.ExplosionFrame := 10;
            meff.light := 3;
            meff.ImgLib := g_WMagic5Images;
          end;

        60: begin //
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 170;
            meff.TargetActor := target;
            meff.NextFrameTime := 100;
            meff.ExplosionFrame := 6;
            meff.light := 3;
            meff.ImgLib := g_WMagic4Images;
          end;

        61: begin //
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 495;
            meff.TargetActor := target;
            meff.NextFrameTime := 60;
            meff.ExplosionFrame := 40;
            meff.light := 3;
            meff.ImgLib := g_WMagic4Images;
          end;

        62: begin //
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 390;
            meff.TargetActor := target;
            meff.NextFrameTime := 50;
            meff.ExplosionFrame := 50;
            meff.light := 3;
            meff.ImgLib := g_WMagic4Images;
          end;

        65: begin //
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 560;
            meff.TargetActor := target;
            meff.NextFrameTime := 50;
            meff.ExplosionFrame := 50;
            meff.light := 3;
            meff.ImgLib := g_WMagic4Images;
          end;

        66: begin //4级灭天火
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 100;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 50;
            meff.ExplosionFrame := 15;
            meff.light := 3;
            if wimg <> nil then
              meff.ImgLib := wimg;
          end;
        51: begin //流星火雨
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 650;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 50;
            meff.ExplosionFrame := 30;
            meff.light := 3;
            if wimg <> nil then
              meff.ImgLib := wimg;
          end;
        107: begin //冰天雪地
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 3150;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 50;
            meff.ExplosionFrame := 8;
            meff.light := 3;
            if wimg <> nil then
              meff.ImgLib := wimg;
          end;
      else begin //默认
          meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
          meff.TargetActor := target;
          meff.NextFrameTime := 80;
        end;
      end;
    mtFireWind:
      meff := nil;
    mtFireGun:
      meff := TFireGunEffect.Create(930, scx, scy, sctx, scty);
    mtThunder: begin
        //meff := TThuderEffect.Create (950, sctx, scty, nil); //target);
        meff := TThuderEffect.Create(10, sctx, scty, nil); //target);
        meff.ExplosionFrame := 6;
        meff.ImgLib := g_WMagic2Images;
      end;
    mtLightingThunder:
      meff := TLightingThunder.Create(970, scx, scy, sctx, scty, target);
    mtExploBujauk: begin
        //DScreen.AddChatBoardString('mtExploBujauk magnumb:'+IntToStr(magnumb), clGreen, clWhite);
        case magnumb of
          10, 72: begin //
              meff := TExploBujaukEffect.Create(1160, scx, scy, sctx, scty, target);
              meff.MagExplosionBase := 1360;
            end;
          67: begin
              meff := TExploBujaukEffect.Create(140, scx, scy, sctx, scty, target);
              meff.MagExplosionBase := 300;
              meff.ImgLib := g_WMagic6Images;
            end;
          17: begin //
              meff := TExploBujaukEffect.Create(1160, scx, scy, sctx, scty, target);
              meff.MagExplosionBase := 1540;
            end;
          108: begin //虎啸诀
              meff := TExploHuXiaoJueZhouEffect.Create(3740, scx, scy, sctx, scty, target);
              meff.MagExplosionBase := 3901;
              meff.ExplosionFrame := 5;
              meff.ImgLib := g_cboEffectImg;
            end;
          110: begin //三焰咒
              meff := TExploSanYanZhouEffect.Create(3240, scx, scy, sctx, scty, target);
              meff.MagExplosionBase := 3560;
              meff.ExplosionFrame := 6;
              meff.ImgLib := g_cboEffectImg;
            end;
        end;
        bofly := True;
      end;
    mtBujaukGroundEffect: begin
        //DScreen.AddChatBoardString('mtBujaukGroundEffect magnumb:'+IntToStr(magnumb), clGreen, clWhite);
        meff := TBujaukGroundEffect.Create(1160, magnumb, scx, scy, sctx, scty);
        case magnumb of
          //10: meff.MagExplosionBase := 1360;
          11: meff.ExplosionFrame := 16; //
          12: meff.ExplosionFrame := 16; //
          46: meff.ExplosionFrame := 24;
        end;
        bofly := True;
      end;
    mtKyulKai: begin
        meff := nil; //TKyulKai.Create (1380, scx, scy, sctx, scty);
      end;
    mt12: begin

      end;
    mt13: begin
        meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
        if meff <> nil then begin
          case magnumb of
            32: begin
                meff.ImgLib := g_WMonImages.Indexs[21]; //21
                meff.MagExplosionBase := 3580;
                meff.TargetActor := target;
                meff.light := 3;
                meff.NextFrameTime := 20;
              end;
            37: begin
                meff.ImgLib := g_WMonImages.Indexs[22]; //22
                meff.MagExplosionBase := 3520;
                meff.TargetActor := target;
                meff.light := 5;
                meff.NextFrameTime := 20;
              end;
          end;
        end;
      end;
    mt14: begin
        meff := TThuderEffect.Create(140, sctx, scty, nil); //target);
        meff.ExplosionFrame := 10;
        meff.ImgLib := g_WMagic2Images;
      end;
    mt15: begin
        meff := TFlyingBug.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
        meff.TargetActor := target;
        bofly := True;
      end;
    mt16: begin

      end;
  end;
  if (meff = nil) then Exit;
  meff.TargetRx := tx;
  meff.TargetRy := ty;
  if meff.TargetActor <> nil then begin
    meff.TargetRx := TActor(meff.TargetActor).m_nCurrX;
    meff.TargetRy := TActor(meff.TargetActor).m_nCurrY;
  end;
  meff.MagOwner := aowner;
  m_EffectList.Add(meff);
end;

procedure TPlayScene.ClearActorMsg(Actor: TActor);
var
  I: Integer;
begin
  Actor.m_MsgList.Lock;
  try
    for I := 0 to Actor.m_MsgList.Count - 1 do begin
      Dispose(pTChrMsg(Actor.m_MsgList.Items[I]));
    end;
    Actor.m_MsgList.Clear;
  finally
    Actor.m_MsgList.UnLock;
  end;
end;

procedure TPlayScene.DelMagic(magid: Integer);
var
  I: Integer;
begin
  for I := 0 to m_EffectList.Count - 1 do begin
    if TMagicEff(m_EffectList[I]).ServerMagicId = magid then begin
      TMagicEff(m_EffectList[I]).Free;
      m_EffectList.Delete(I);
      Break;
    end;
  end;
end;

function TPlayScene.NewFlyObject(aowner: TActor; cx, cy, tx, ty, targetcode: Integer; mtype: TMagicType): TMagicEff;
var
  I, scx, scy, sctx, scty: Integer;
  meff: TMagicEff;
begin
  ScreenXYfromMCXY(cx, cy, scx, scy);
  ScreenXYfromMCXY(tx, ty, sctx, scty);
  case mtype of
    mtFlyArrow: meff := TFlyingArrow.Create(1, 1, scx, scy, sctx, scty, mtype, True, 0);
    mt12: meff := TFlyingFireBall.Create(1, 1, scx, scy, sctx, scty, mtype, True, 0);
    mt15: meff := TFlyingBug.Create(1, 1, scx, scy, sctx, scty, mtype, True, 0);
  else meff := TFlyingAxe.Create(1, 1, scx, scy, sctx, scty, mtype, True, 0);
  end;
  meff.TargetRx := tx;
  meff.TargetRy := ty;
  meff.TargetActor := FindActor(targetcode);
  meff.MagOwner := aowner;
  m_FlyList.Add(meff);
  Result := meff;
end;

//cx, cy地图座标转换成幕座标 sx, sY

procedure TPlayScene.ScreenXYfromMCXY(cx, cy: Integer; var sx, sY: Integer);
begin
  if g_MySelf = nil then Exit;
  if SCREENWIDTH = 800 then begin
    sx := (cx - g_MySelf.m_nRx) * UNITX + 364 + UNITX div 2 - g_MySelf.m_nShiftX;
    if g_ConfigClient.btMainInterface in [0, 2] then begin
      sY := (cy - g_MySelf.m_nRy) * UNITY + 192 + UNITY div 2 - g_MySelf.m_nShiftY;
    end else begin
      sY := (cy - g_MySelf.m_nRy) * UNITY + (285 - 31) + UNITY div 2 - g_MySelf.m_nShiftY;
    end;
  end else begin
    if g_ConfigClient.btMainInterface in [0, 2] then begin
      sx := (cx - g_MySelf.m_nRx) * UNITX + 485 + 24 {364} + UNITX div 2 - g_MySelf.m_nShiftX;
      sY := (cy - g_MySelf.m_nRy) * UNITY + 270 + 16 {192} + UNITY div 2 - g_MySelf.m_nShiftY;
    end else begin
      sx := (cx - g_MySelf.m_nRx) * UNITX + 485 + 24 {364} + UNITX div 2 - g_MySelf.m_nShiftX;
      sY := (cy - g_MySelf.m_nRy) * UNITY + 270 + 74 {192} + UNITY div 2 - g_MySelf.m_nShiftY;
    end;
  end;
end;

//屏幕座标 mx, my转换成ccx, ccy地图座标

procedure TPlayScene.CXYfromMouseXY(mx, my: Integer; var ccx, ccy: Integer);
begin
  if g_MySelf = nil then Exit;
  if SCREENWIDTH = 800 then begin
    ccx := Round((mx - 364 + g_MySelf.m_nShiftX - UNITX) / UNITX) + g_MySelf.m_nRx;
    if g_ConfigClient.btMainInterface in [0, 2] then begin
      ccy := Round((my - 192 + g_MySelf.m_nShiftY - UNITY) / UNITY) + g_MySelf.m_nRy;
    end else begin
      ccy := Round((my - (285 - 31) + g_MySelf.m_nShiftY - UNITY) / UNITY) + g_MySelf.m_nRy;
    end;
  end else begin
    if g_ConfigClient.btMainInterface in [0, 2] then begin
      ccx := Round((mx - 485 {364} + g_MySelf.m_nShiftX - UNITX) / UNITX) + g_MySelf.m_nRx;
      ccy := Round((my - 270 {192} + g_MySelf.m_nShiftY - UNITY) / UNITY) + g_MySelf.m_nRy;
    end else begin
      ccx := Round((mx - 485 {364} + g_MySelf.m_nShiftX - UNITX) / UNITX) + g_MySelf.m_nRx;
      ccy := Round((my - 270 - 74 {192} + g_MySelf.m_nShiftY - UNITY) / UNITY) + g_MySelf.m_nRy;
    end;
  end;
end;

function TPlayScene.GetCharacter(X, Y, wantsel: Integer; var nowsel: Integer; liveonly: Boolean): TActor;
var
  k, I, ccx, ccy, dx, dy: Integer;
  a: TActor;
begin
  Result := nil;
  nowsel := -1;
  CXYfromMouseXY(X, Y, ccx, ccy);
  for k := ccy + 8 downto ccy - 1 do begin
    for I := m_ActorList.Count - 1 downto 0 do
      if TActor(m_ActorList[I]) <> g_MySelf then begin
        a := TActor(m_ActorList[I]);
        if (not liveonly or not a.m_boDeath) and (a.m_boHoldPlace) and (a.m_boVisible) then begin
          if a.m_nCurrY = k then begin
            dx := (a.m_nRx - Map.m_ClientRect.Left) * UNITX + m_nDefXX + a.m_nPx + a.m_nShiftX;
            dy := (a.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + m_nDefYY + a.m_nPy + a.m_nShiftY;
            if a.CheckSelect(X - dx, Y - dy) then begin
              Result := a;
              Inc(nowsel);
              if nowsel >= wantsel then
                Exit;
            end;
          end;
        end;
      end;
  end;
end;

//取得鼠标所指坐标的角色

function TPlayScene.GetAttackFocusCharacter(X, Y, wantsel: Integer; var nowsel: Integer; liveonly: Boolean): TActor;
var
  k, I, ccx, ccy, dx, dy, centx, centy: Integer;
  a: TActor;
begin
  Result := GetCharacter(X, Y, wantsel, nowsel, liveonly);
  if Result = nil then begin
    nowsel := -1;
    CXYfromMouseXY(X, Y, ccx, ccy);
    for k := ccy + 8 downto ccy - 1 do begin
      for I := m_ActorList.Count - 1 downto 0 do
        if TActor(m_ActorList[I]) <> g_MySelf then begin
          a := TActor(m_ActorList[I]);
          if (not liveonly or not a.m_boDeath) and (a.m_boHoldPlace) and (a.m_boVisible) then begin
            if a.m_nCurrY = k then begin
              dx := (a.m_nRx - Map.m_ClientRect.Left) * UNITX + m_nDefXX + a.m_nPx + a.m_nShiftX;
              dy := (a.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + m_nDefYY + a.m_nPy + a.m_nShiftY;
              if a.CharWidth > 40 then centx := (a.CharWidth - 40) div 2
              else centx := 0;
              if a.CharHeight > 70 then centy := (a.CharHeight - 70) div 2
              else centy := 0;
              if (X - dx >= centx) and (X - dx <= a.CharWidth - centx) and (Y - dy >= centy) and (Y - dy <= a.CharHeight - centy) then begin
                Result := a;
                Inc(nowsel);
                if nowsel >= wantsel then Exit;
              end;
            end;
          end;
        end;
    end;
  end;
end;

//取得鼠标所指坐标的角色

function TPlayScene.GetAttackFocusCharacterA(X, Y, wantsel: Integer; var nowsel: Integer; liveonly: Boolean): TActor;
var
  k, I, ccx, ccy, dx, dy, centx, centy: Integer;
  a: TActor;
begin
  Result := GetCharacter(X, Y, wantsel, nowsel, liveonly);
  if Result = nil then begin
    nowsel := -1;
    CXYfromMouseXY(X, Y, ccx, ccy);
    for k := ccy + 8 downto ccy - 1 do begin
      for I := m_ActorList.Count - 1 downto 0 do
        //if TActor(m_ActorList[I]) <> g_MySelf then begin
        a := TActor(m_ActorList[I]);
      if (not liveonly or not a.m_boDeath) and (a.m_boHoldPlace) and (a.m_boVisible) then begin
        if a.m_nCurrY = k then begin
          dx := (a.m_nRx - Map.m_ClientRect.Left) * UNITX + m_nDefXX + a.m_nPx + a.m_nShiftX;
          dy := (a.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + m_nDefYY + a.m_nPy + a.m_nShiftY;
          if a.CharWidth > 40 then centx := (a.CharWidth - 40) div 2
          else centx := 0;
          if a.CharHeight > 70 then centy := (a.CharHeight - 70) div 2
          else centy := 0;
          if (X - dx >= centx) and (X - dx <= a.CharWidth - centx) and (Y - dy >= centy) and (Y - dy <= a.CharHeight - centy) then begin
            Result := a;
            Inc(nowsel);
            if nowsel >= wantsel then Exit;
          end;
        end;
      end;
    end;
    //end;
  end;
end;

function TPlayScene.IsSelectMyself(X, Y: Integer): Boolean;
var
  k, I, ccx, ccy, dx, dy: Integer;
begin
  Result := False;
  CXYfromMouseXY(X, Y, ccx, ccy);
  for k := ccy + 2 downto ccy - 1 do begin
    if g_MySelf.m_nCurrY = k then begin
      dx := (g_MySelf.m_nRx - Map.m_ClientRect.Left) * UNITX + m_nDefXX + g_MySelf.m_nPx + g_MySelf.m_nShiftX;
      dy := (g_MySelf.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + m_nDefYY + g_MySelf.m_nPy + g_MySelf.m_nShiftY;
      if g_MySelf.CheckSelect(X - dx, Y - dy) then begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

//取得指定座标地面物品
// x,y 为屏幕座标

function TPlayScene.GetDropItems(X, Y: Integer; var inames: string): pTDropItem;
var
  k, I, ccx, ccy, ssx, ssy, dx, dy: Integer;
  DropItem: pTDropItem;
  S: TTexture;
  c: Byte;
  II: Integer;
  List: TList;
begin
  Result := nil;
  CXYfromMouseXY(X, Y, ccx, ccy);
  ScreenXYfromMCXY(ccx, ccy, ssx, ssy);
  dx := X - ssx;
  dy := Y - ssy;
  inames := '';
  for I := 0 to g_DropedItemList.Count - 1 do begin
    List := TList(g_DropedItemList.Items[I]);
    if List.Count > 0 then begin
      DropItem := pTDropItem(List.Items[0]);
      if (DropItem.X = ccx) and (DropItem.Y = ccy) then begin
        for II := 0 to List.Count - 1 do begin
          DropItem := pTDropItem(List.Items[II]);
          S := g_WDnItemImages.Images[DropItem.looks];
          if S = nil then Continue;
          dx := (X - ssx) + (S.Width div 2) - 3;
          dy := (Y - ssy) + (S.Height div 2);
          c := S.Pixels[dx, dy];
          if c <> 0 then begin

            if Result = nil then Result := DropItem;
            inames := inames + DropItem.Name + '\';
        //break;
          end;
        end;
        Break;
      end;
    end;
  end;
end;

procedure TPlayScene.GetXYDropItemsList(nX, nY: Integer; var ItemList: TList);
var
  I: Integer;
  II: Integer;
  List: TList;
  DropItem: pTDropItem;
begin
  for I := 0 to g_DropedItemList.Count - 1 do begin
    List := TList(g_DropedItemList.Items[I]);
    if List.Count > 0 then begin
      DropItem := pTDropItem(List.Items[0]);
      if (DropItem.X = nX) and (DropItem.Y = nY) then begin
        for II := 0 to List.Count - 1 do begin
          ItemList.Add(List.Items[II]);
        end;
        Break;
      end;
    end;
  end;
end;

function TPlayScene.GetXYDropItems(nX, nY: Integer): pTDropItem;
var
  I: Integer;
  II: Integer;
  List: TList;
  DropItem: pTDropItem;
begin
  Result := nil;
  for I := 0 to g_DropedItemList.Count - 1 do begin
    List := TList(g_DropedItemList.Items[I]);
    if List.Count > 0 then begin
      DropItem := pTDropItem(List.Items[0]);
      if (DropItem.X = nX) and (DropItem.Y = nY) then begin
        Result := DropItem;
        Exit;
      end;
    end;
  end;
end;

function TPlayScene.CanRun(sx, sY, ex, ey: Integer): Boolean;
var
  ndir, rx, ry: Integer;
begin
  ndir := GetNextDirection(sx, sY, ex, ey);
  rx := sx;
  ry := sY;
  GetNextPosXY(ndir, rx, ry);

  if Map.CanMove(rx, ry) and Map.CanMove(ex, ey) then
    Result := True
  else Result := False;

  if CanWalkEx(rx, ry) and CanWalkEx(ex, ey) then
    Result := True
  else Result := False;
end;

function TPlayScene.NewCanRun(sx, sy, ex, ey: Integer): Boolean;
var
  ndir, rx, ry: Integer;
begin
  ndir := GetNextDirection(sx, sy, ex, ey);
  rx := sx;
  ry := sy;
  GetNextPosXY(ndir, rx, ry);

  if Map.NewCanMove(rx, ry) and Map.NewCanMove(ex, ey) then
    Result := True
  else Result := FALSE;

  if NewCanWalkEx(rx, ry) and NewCanWalkEx(ex, ey) then
    Result := True
  else Result := FALSE;
end;

function TPlayScene.CanWalkEx(mx, my: Integer): Boolean;
begin
  Result := False;
  if Map.CanMove(mx, my) then
    Result := not CrashManEx(mx, my);
end;

function TPlayScene.NewCanWalkEx(mx, my: Integer): Boolean;
begin
  Result := FALSE;
  if Map.NewCanMove(mx, my) then //Result := TRUE;
    Result := not CrashMan(mx, my);
end;

//穿人

function TPlayScene.CrashManEx(mx, my: Integer): Boolean;
var
  I: Integer;
  Actor: TActor;
begin
  Result := False;
  for I := 0 to m_ActorList.Count - 1 do begin
    Actor := TActor(m_ActorList[I]);
    if (Actor.m_boVisible) and (Actor.m_boHoldPlace) and (not Actor.m_boDeath) and (Actor.m_nCurrX = mx) and (Actor.m_nCurrY = my) then begin
      //      DScreen.AddChatBoardString ('Actor.m_btRace ' + IntToStr(Actor.m_btRace),clWhite, clRed);
      if (Actor.m_btRace = RCC_USERHUMAN) and {g_Config.boCanRunHuman and }  (g_ServerConfig.boRUNHUMAN = True) then Continue;
      if (Actor.m_btRace = RCC_MERCHANT) and {g_Config.boCanRunNpc and }  (g_ServerConfig.boRunNpc = True) then Continue;
      if ((Actor.m_btRace > RCC_USERHUMAN) and (Actor.m_btRace <> RCC_MERCHANT)) and {g_Config.boCanRunMon and }  (g_ServerConfig.boRUNMON = True) then Continue;
      //m_btRace 大于 0 并不等于 50 则为怪物
      Result := True;
      Break;
    end;
  end;
end;

function TPlayScene.CanWalk(mx, my: Integer): Boolean;
begin
  Result := False;
  if Map.CanMove(mx, my) then
    Result := not CrashMan(mx, my);
end;

function TPlayScene.CrashMan(mx, my: Integer): Boolean;
var
  I: Integer;
  a: TActor;
begin
  Result := False;
  for I := 0 to m_ActorList.Count - 1 do begin
    a := TActor(m_ActorList[I]);
    if (a.m_boVisible) and (a.m_boHoldPlace) and (not a.m_boDeath) and (a.m_nCurrX = mx) and (a.m_nCurrY = my) then begin
      Result := True;
      Break;
    end;
  end;
end;

function TPlayScene.CanFly(mx, my: Integer): Boolean;
begin
  Result := Map.CanFly(mx, my);
end;

{------------------------ Actor ------------------------}

function TPlayScene.FindActor(id: Integer): TActor;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to m_ActorList.Count - 1 do begin
    if TActor(m_ActorList[I]).m_nRecogId = id then begin
      Result := TActor(m_ActorList[I]);
      Break;
    end;
  end;
end;

function TPlayScene.FindActor(sName: string): TActor;
var
  I: Integer;
  Actor: TActor;
begin
  Result := nil;
  for I := 0 to m_ActorList.Count - 1 do begin
    Actor := TActor(m_ActorList[I]);
    if CompareText(Actor.m_sUserName, sName) = 0 then begin
      Result := Actor;
      Break;
    end;
  end;
end;

function TPlayScene.FindActorXY(X, Y: Integer): TActor;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to m_ActorList.Count - 1 do begin
    if (TActor(m_ActorList[I]).m_nCurrX = X) and (TActor(m_ActorList[I]).m_nCurrY = Y) then begin
      Result := TActor(m_ActorList[I]);
      if not Result.m_boDeath and Result.m_boVisible and Result.m_boHoldPlace then
        Break;
    end;
  end;
end;

function TPlayScene.FindTargetXYCount(nX, nY, nRange: Integer): Integer;
var
  Actor: TActor;
  I, nC, n10: Integer;
begin
  Result := 0;
  n10 := nRange;
  for I := 0 to m_ActorList.Count - 1 do begin
    Actor := TActor(m_ActorList[I]);
    if Actor <> nil then begin
     { if (not Actor.m_boDeath) and
        (Actor <> g_MySelf) and
        (Actor <> g_MyHero) and
        (Actor.m_btRace <> RCC_USERHUMAN) and
        (Actor.m_btRace <> RCC_GUARD) and
        (Actor.m_btRace <> RCC_MERCHANT) and
        (Pos('(', Actor.m_sUserName) = 0) then begin  }

      if (not Actor.m_boDeath) and
        (Actor.m_Abil.HP > 0) and
        (Actor <> g_MySelf) and
        (Actor <> g_MyHero) and
        (Actor.m_btRace > RCC_USERHUMAN) and
        (Actor.m_btRace <> RCC_GUARD) and
        (Actor.m_btRace <> RC_ARCHERGUARD) and
        (Actor.m_btRace <> 52) and
        (Actor.m_btRace <> 81) and
        (Actor.m_btRace <> 12) and
        //(Actor.m_btRace <> 19) and
        //(Actor.m_btRace <> 45) and

      (Actor.m_btRace <> RCC_MERCHANT) and
        (Pos('(', Actor.m_sUserName) = 0) then begin

        nC := abs(nX - Actor.m_nCurrX) + abs(nY - Actor.m_nCurrY);
        if nC <= n10 then begin
          Inc(Result);
        end;
      end;
    end;
  end;
end;

function TPlayScene.IsValidActor(Actor: TActor): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to m_ActorList.Count - 1 do begin
    if TActor(m_ActorList[I]) = Actor then begin
      Result := True;
      Break;
    end;
  end;
end;

function TPlayScene.NewActor(chrid: Integer;
  cx: Word; //x
  cy: Word; //y
  cdir: Word;
  cfeature: Integer; //race, hair, dress, weapon
  cstate: Integer): TActor;
var
  I: Integer;
  Actor: TActor;
  Msg: pTChrMsg;
begin
  Result := nil;
  for I := 0 to m_ActorList.Count - 1 do begin
    if TActor(m_ActorList[I]).m_nRecogId = chrid then begin
      Result := TActor(m_ActorList[I]);
      Exit;
    end;
  end;
  if (g_MyHero <> nil) and (g_MyHero.m_nRecogId = chrid) then begin //Mars
    ClearActorMsg(g_MyHero);
    with g_MyHero do begin
      m_nRecogId := chrid;
      m_nCurrX := cx;
      m_nCurrY := cy;
      m_nRx := m_nCurrX;
      m_nRy := m_nCurrY;
      m_btDir := cdir;
      m_nFeature := cfeature;
      m_btRace := RACEfeature(cfeature);
      m_btHair := HAIRfeature(cfeature);
      m_btDress := DRESSfeature(cfeature);
      m_btWeapon := WEAPONfeature(cfeature);
      m_wAppearance := APPRfeature(cfeature);
    //      Horse:=Horsefeature(cfeature);
    //      Effect:=Effectfeature(cfeature);
      //m_Action := GetMonAction(m_wAppearance);
      m_Action := nil;
      if m_btRace = 0 then begin
        m_btSex := m_btDress mod 2;
      end else begin
        m_btSex := 0;
      end;
      m_nState := cstate;
      m_SayingArr[0] := '';
    end;

    m_ActorList.Add(g_MyHero);
    Result := g_MyHero;
    Exit;
  end;
  if IsChangingFace(chrid) then Exit;

  case RACEfeature(cfeature) of //m_btRaceImg
    0: Actor := THumActor.Create; //人物
    9: Actor := TSoccerBall.Create; //足球
    13: Actor := TKillingHerb.Create; //食人花
    14: Actor := TSkeletonOma.Create; //骷髅
    15: Actor := TDualAxeOma.Create; //掷斧骷髅

    16: Actor := TGasKuDeGi.Create; //洞蛆

    17: Actor := TCatMon.Create; //钩爪猫
    18: Actor := THuSuABi.Create; //稻草人
    19: Actor := TCatMon.Create; //沃玛战士

    20: Actor := TFireCowFaceMon.Create; //火焰沃玛
    21: Actor := TCowFaceKing.Create; //沃玛教主
    22: Actor := TDualAxeOma.Create; //黑暗战士
    23: Actor := TWhiteSkeleton.Create; //变异骷髅
    24: Actor := TSuperiorGuard.Create; //带刀卫士
    30: Actor := TCatMon.Create; //朝俺窿
    31: Actor := TCatMon.Create; //角蝇
    32: Actor := TScorpionMon.Create; //蝎子

    33: Actor := TCentipedeKingMon.Create; //触龙神
    34: Actor := TBigHeartMon.Create; //赤月恶魔
    35: Actor := TSpiderHouseMon.Create; //幻影蜘蛛
    36: Actor := TExplosionSpider.Create; //月魔蜘蛛
    37: Actor := TFlyingSpider.Create; //

    40: Actor := TZombiLighting.Create; //僵尸1
    41: Actor := TZombiDigOut.Create; //僵尸2
    42: Actor := TZombiZilkin.Create; //僵尸3

    43: Actor := TBeeQueen.Create; //角蝇巢

    45: Actor := TArcherMon.Create; //弓箭手
    47: Actor := TSculptureMon.Create; //祖玛雕像
    48: Actor := TSculptureMon.Create; //
    49: Actor := TSculptureKingMon.Create; //祖玛教主

    50: Actor := TNpcActor.Create;

    52: Actor := TGasKuDeGi.Create; //楔蛾
    53: Actor := TGasKuDeGi.Create; //粪虫
    54: Actor := TSmallElfMonster.Create; //神兽
    55: Actor := TWarriorElfMonster.Create; //神兽1

    60: Actor := TElectronicScolpionMon.Create;
    61: Actor := TBossPigMon.Create;
    62: Actor := TKingOfSculpureKingMon.Create;
    63: Actor := TSkeletonKingMon.Create;
    64: Actor := TGasKuDeGi.Create;
    65: Actor := TSamuraiMon.Create;
    66: Actor := TSkeletonSoldierMon.Create;
    67: Actor := TSkeletonSoldierMon.Create;
    68: Actor := TSkeletonSoldierMon.Create;
    69: Actor := TSkeletonArcherMon.Create;
    70: Actor := TBanyaGuardMon.Create;
    71: Actor := TBanyaGuardMon.Create;
    72: Actor := TBanyaGuardMon.Create;
    73: Actor := TPBOMA1Mon.Create;
    74: Actor := TCatMon.Create;
    75: Actor := TStoneMonster.Create;
    76: Actor := TSuperiorGuard.Create;
    77: Actor := TStoneMonster.Create;
    78: Actor := TBanyaGuardMon.Create;
    79: Actor := TPBOMA6Mon.Create;
    80: Actor := TMineMon.Create;
    81: Actor := TAngel.Create;
    83: Actor := TFireDragon.Create; //火龙
    84..89: Actor := TDragonStatue.Create;

    90: Actor := TDragonBody.Create; //龙
    98: Actor := TWallStructure.Create; //LeftWall
    99: Actor := TCastleDoor.Create; //MainDoor
    100: Actor := TMoonMon.Create;
    102..114: Actor := TBanyaGuardMon.Create;
    116: Actor := TBanyaGuardMon.Create;
    115, 117: Actor := TSnowMountainMon.Create;
  else Actor := TActor.Create;
  end;

  with Actor do begin
    m_nRecogId := chrid;
    m_nCurrX := cx;
    m_nCurrY := cy;
    m_nRx := m_nCurrX;
    m_nRy := m_nCurrY;
    m_btDir := cdir;
    m_nFeature := cfeature;
    m_btRace := RACEfeature(cfeature); //changefeature啊 乐阑锭父
    m_btHair := HAIRfeature(cfeature); //函版等促.
    m_btDress := DRESSfeature(cfeature);
    m_btWeapon := WEAPONfeature(cfeature);
    m_wAppearance := APPRfeature(cfeature);
    //      Horse:=Horsefeature(cfeature);
    //      Effect:=Effectfeature(cfeature);
    m_Action := GetMonAction(m_wAppearance);
    if m_btRace = 0 then begin
      m_btSex := m_btDress mod 2; //0:巢磊 1:咯磊
      //DScreen.AddChatBoardString ('Actor.m_btHair ' +IntToStr(HAIRfeature(cfeature)), clGreen, clWhite);
    end else begin
      m_btSex := 0;
    end;
    m_nState := cstate;
    m_SayingArr[0] := '';
  end;
  m_ActorList.Add(Actor);
  Result := Actor;
end;

procedure TPlayScene.ActorDied(Actor: TObject);
var
  I: Integer;
  flag: Boolean;
begin
  for I := 0 to m_ActorList.Count - 1 do begin
    if m_ActorList[I] = Actor then begin
      m_ActorList.Delete(I);
      Break;
    end;
  end;
  flag := False;
  for I := 0 to m_ActorList.Count - 1 do begin
    if not TActor(m_ActorList[I]).m_boDeath then begin
      m_ActorList.Insert(I, Actor);
      flag := True;
      Break;
    end;
  end;
  if not flag then m_ActorList.Add(Actor);
end;

procedure TPlayScene.SetActorDrawLevel(Actor: TObject; Level: Integer);
var
  I: Integer;
begin
  if Level = 0 then begin
    for I := 0 to m_ActorList.Count - 1 do
      if m_ActorList[I] = Actor then begin
        m_ActorList.Delete(I);
        m_ActorList.Insert(0, Actor);
        Break;
      end;
  end;
end;

procedure TPlayScene.ClearActors;
var
  I: Integer;
begin
  for I := 0 to m_ActorList.Count - 1 do begin
    if TActor(m_ActorList[I]) = g_MyHero then g_MyHero := nil;
    TActor(m_ActorList[I]).Free;
  end;
  m_ActorList.Clear;

  if g_MyHero <> nil then begin
    FreeAndNil(g_MyHero);
  end;

  g_MySelf := nil;
  g_MyHero := nil;
  g_TargetCret := nil;
  g_FocusCret := nil;
  g_MagicTarget := nil;

  for I := 0 to m_EffectList.Count - 1 do
    TMagicEff(m_EffectList[I]).Free;
  m_EffectList.Clear;
end;

function TPlayScene.DeleteActor(id: Integer): TActor;
var
  I: Integer;
  Actor: TActor;
begin
  Result := nil;
  I := 0;
  while True do begin
    if I >= m_ActorList.Count then Break;
    Actor := TActor(m_ActorList[I]);
    if (Actor.m_nRecogId = id) then begin
      if g_TargetCret = Actor then g_TargetCret := nil;
      if g_FocusCret = Actor then g_FocusCret := nil;
      if g_MagicTarget = Actor then g_MagicTarget := nil;
      if g_SerieTarget = Actor then g_SerieTarget := nil;
      if (g_MyHero <> nil) and (g_MyHero = Actor) then begin
        m_ActorList.Delete(I);
        ClearActorMsg(g_MyHero);
      end else begin
        Actor.m_dwDeleteTime := GetTickCount;
        //Actor.FreeNameSurface;
        m_ActorList.Delete(I);
        UpDataFreeActorList(Actor);
        //g_FreeActorList.Add(Actor);
      end;
      Break;
    end else Inc(I);
  end;
end;

procedure TPlayScene.DelActor(Actor: TObject);
var
  I, II: Integer;
begin
  for I := 0 to m_ActorList.Count - 1 do begin
    if m_ActorList[I] = Actor then begin
      TActor(m_ActorList[I]).m_dwDeleteTime := GetTickCount;
      //TActor(m_ActorList[I]).FreeNameSurface;
      //g_FreeActorList.Add(m_ActorList[I]);
      UpDataFreeActorList(m_ActorList[I]);
      m_ActorList.Delete(I);
      Break;
    end;
  end;
end;

function TPlayScene.ButchAnimal(X, Y: Integer): TActor;
var
  I: Integer;
  a: TActor;
begin
  Result := nil;
  for I := 0 to m_ActorList.Count - 1 do begin
    a := TActor(m_ActorList[I]);
    if a.m_boDeath {and (a.m_btRace <> 0)} then begin
      if (abs(a.m_nCurrX - X) <= 1) and (abs(a.m_nCurrY - Y) <= 1) then begin
        Result := a;
        Break;
      end;
    end;
  end;
end;


{------------------------- Msg -------------------------}

procedure TPlayScene.SendMsg(ident, chrid, X, Y, cdir, feature, State: Integer; Str: string);
var
  Actor: TActor;
begin
  case ident of
    SM_TEST: begin
        Actor := NewActor(111, 254 {x}, 214 {y}, 0, 0, 0);
        g_MySelf := THumActor(Actor);
        Map.LoadMap('0', g_MySelf.m_nCurrX, g_MySelf.m_nCurrY);
      end;
    SM_CHANGEMAP,
      SM_NEWMAP: begin
        Map.LoadMap(Str, X, Y);
        {DarkLevel := cdir;
        if DarkLevel = 0 then g_boViewFog := False
        else g_boViewFog := True;}
        //
        if g_boViewMiniMap then begin
          //              BoViewMiniMap := FALSE;
          g_nMiniMapIndex := -1;
          frmMain.SendWantMiniMap;
        end;
        if (ident = SM_NEWMAP) and (g_MySelf <> nil) then begin
          g_MySelf.m_nCurrX := X;
          g_MySelf.m_nCurrY := Y;
          g_MySelf.m_nRx := X;
          g_MySelf.m_nRy := Y;
          DelActor(g_MySelf);
          EventMan.ClearEvents;
        end;
        if g_MySelf <> nil then begin
          g_nNewStatusX := g_MySelf.m_nCurrX;
          g_nNewStatusY := g_MySelf.m_nCurrY;
        end;
      end;

    SM_LOGON: begin
        Actor := FindActor(chrid);
        if Actor = nil then begin
          Actor := NewActor(chrid, X, Y, LoByte(cdir), feature, State);
          Actor.m_nChrLight := HiByte(cdir);
          cdir := LoByte(cdir);
          Actor.SendMsg(SM_TURN, X, Y, cdir, feature, State, '', 0);
        end;
        if g_MySelf <> nil then begin
          g_MySelf := nil;
        end;
        g_MySelf := THumActor(Actor);
      end;

    SM_HIDE: begin
        Actor := FindActor(chrid);
        if Actor <> nil then begin
          if Actor.m_boDelActionAfterFinished then begin
            Exit;
          end;
          if Actor.m_nWaitForRecogId <> 0 then begin
            Exit;
          end;
        end;
        DeleteActor(chrid);
      end;
    SM_HEROLOGON:
      begin
        Actor := FindActor(chrid);
        if Actor = nil then begin
          Actor := NewActor(chrid, X, Y, Lobyte(cdir), Feature, State);
          Actor.m_btSex := HiByte(cdir);
          cdir := LoByte(cdir);
          Actor.SendMsg(SM_HEROLOGON, chrid, X, Y, Lobyte(cdir), 0, '', 0);
          Actor.SendMsg(SM_TURN, X, Y, cdir, Feature, State, '', 0);
        end;
        //g_MyHero := THumActor(Actor);
      end;
  else begin
      Actor := FindActor(chrid);
      if (ident = SM_TURN) or (ident = SM_RUN) or (ident = SM_HORSERUN) or (ident = SM_WALK) or
        (ident = SM_BACKSTEP) or
        (ident = SM_DEATH) or (ident = SM_SKELETON) or
        (ident = SM_DIGUP) or (ident = SM_ALIVE) then begin
        if Actor = nil then
          Actor := NewActor(chrid, X, Y, LoByte(cdir), feature, State);
        if Actor <> nil then begin
          {if ident = SM_WALK then begin
            Actor.m_btJob := HiByte(cdir);
          end else
            if ident = SM_TURN then begin
            if Actor is THumActor then begin
              THumActor(Actor).m_btCastle := HiByte(cdir);
            end else begin
              Actor.m_nChrLight := HiByte(cdir);
            end;
          end else begin
            Actor.m_nChrLight := HiByte(cdir);
          end;}
          Actor.m_nChrLight := HiByte(cdir);
          cdir := LoByte(cdir);
          if ident = SM_SKELETON then begin
            Actor.m_boDeath := True;
            Actor.m_boSkeleton := True;
          end;
        end;
      end;
      if Actor = nil then Exit;
      case ident of
        SM_FEATURECHANGED: begin
            Actor.m_nFeature := feature;
            Actor.m_nFeatureEx := State;
            Actor.FeatureChanged;
          end;
        SM_CHARSTATUSCHANGED: begin
            Actor.m_nState := feature;
            Actor.m_nHitSpeed := State;
            Actor.m_boSuperShield := Str = '1';
          end;
      else begin
          if ident = SM_TURN then begin
            if Str <> '' then
              Actor.m_sUserName := Str;
          end;
          Actor.SendMsg(ident, X, Y, cdir, feature, State, '', 0);
        end;
      end;
    end;
  end;
end;

end.

