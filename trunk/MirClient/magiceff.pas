unit magiceff;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Grobal2, Textures, ClFunc, HUtil32, GameImages, Share;


const
  MG_READY = 10;
  MG_FLY = 6;
  MG_EXPLOSION = 10;
  READYTIME = 120;
  EXPLOSIONTIME = 100;
  FLYBASE = 10;
  EXPLOSIONBASE = 170;
  //EFFECTFRAME = 260;
  MAXMAGIC = 10;
  FLYOMAAXEBASE = 447;
  THORNBASE = 2967;
  ARCHERBASE = 2607;
  ARCHERBASE2 = 272; //2609;
  TDBBASE = 210;
  FLYFORSEC = 500;
  FIREGUNFRAME = 6;

  MAXEFFECT = 200;

  EffectBase: array[0..MAXEFFECT - 1] of Integer = (
    0, {1}
    200, {2}
    400, {3}
    600, {4}
    0, {5}
    900, {6}
    920, {7}
    940, {8}
    20, {9}
    940, {10}
    940, {11}
    940, {12}
    0, {13}
    1380, {14}
    1500, {15}
    1520, {16}
    940, {17}
    1560, {18}
    1590, {19}
    1620, {20}
    1650, {21}
    1680, {22}
    0, {23}
    0, {24}
    0, {25}
    3960, {26}
    1790, {27}
    0, {28}
    3880, {29}
    3920, {30}
    3840, {31}
    0, {32}
    40, {33}
    130, {34}
    160, {35}
    190, {36}
    0, {37}
    210, {38}
    400, {39}
    600, {40}
    1500, {41}
    650, {42}
    710, {43}
    740, {44}
    910, {45}
    940, {46}
    990, {47}
    1040, {48}
    0, {49}
    10, {50} //·ÖÉíÊõ
    640, {51} //Á÷ÐÇ»ðÓê
    1040, {52}

    110, {53}
    110, {54}
    110, {55}
    110, {56}
    110, {57}
    110, {58}
    10, {59}

    0, {60} //ÆÆ»êÕ¶
    460, {61} //ÅüÐÇÕ¶
    290, {62} //À×öªÒ»»÷
    610, {63} //ÊÉ»êÕÓÔó
    190, {64} //Ä©ÈÕÉóÅÐ
    540, {65} //»ðÁúÆøÑæ
    80, {66} //4¼¶ÃðÌì»ð
    120, {67} //4¼¶Áé»ê»ð·û
    0, {68}
    0, {69}
    0, {70}
    0, {71}
    0, {72}
    0, {73}
    0, {74}
    0, {75}
    0, {76}
    0, {77}
    0, {78}
    0, {79}
    0, {80}
    0, {81}
    0, {82}
    0, {83}
    0, {84}
    0, {85}
    0, {86}
    0, {87}
    0, {88}
    0, {89}
    0, {90}
    0, {91}
    0, {92}
    0, {93}
    0, {94}
    0, {95}
    0, {96}
    0, {97}
    0, {98}
    0, {99}
    0, {100}
    0, {101}
    0, {102}
    0, {103}
    1040, {104} //Ë«ÁúÆÆ
    640, {105} //·ïÎè¼À
    4210, {106} //¾ªÀ×±¬
    800, {107} //±ùÌìÑ©µØ
    1200, {108} //»¢Ð¥¾÷
    1440, {109} //°ËØÔÕÆ
    1600, {110} //ÈýÑæÖä
    1760, {111} // Íò½£¹é×Ú
    0, {112}
    0, {113}
    0, {114}
    0, {115}
    0, {116}
    0, {117}
    0, {118}
    0, {119}
    0, {120}
    0, {121}

    0, {122}
    0, {123}
    0, {124}
    0, {125}
    0, {126}
    0, {127}
    0, {128}
    0, {129}
    0, {130}
    0, {131}
    0, {132}
    0, {133}
    0, {134}
    0, {135}
    0, {136}
    0, {137}
    0, {138}
    0, {139}
    0, {140}
    0, {141}
    0, {142}
    0, {143}
    0, {144}
    0, {145}
    0, {146}
    0, {147}
    0, {148}
    0, {149}
    0, {150}
    0, {151}
    0, {152}
    0, {153}
    0, {154}
    0, {155}
    0, {156}
    0, {157}
    0, {158}
    0, {159}
    0, {160}
    0, {161}
    0, {162}
    0, {163}
    0, {164}
    0, {165}
    0, {166}
    0, {167}
    0, {168}
    0, {169}
    0, {170}
    0, {171}
    0, {172}
    0, {173}
    0, {174}
    0, {175}
    0, {176}
    0, {177}
    0, {178}
    0, {179}
    0, {180}
    0, {181}
    0, {182}
    0, {183}
    0, {184}
    0, {185}
    0, {186}
    0, {187}
    0, {188}
    0, {189}
    0, {190}
    0, {191}
    0, {192}
    0, {193}
    0, {194}
    0, {195}
    0, {196}
    0, {197}
    0, {198}
    100, {199} //ÔÂÁéÄ§·¨
    280 {200} //ÔÂÁéÄ§·¨

    );
  MAXHITEFFECT = 24 {11};
  {
  HitEffectBase: array[0..MAXHITEFFECT-1] of integer = (
     800,           //0, ¾î°Ë¼ú
     1410,          //1 ¾î°Ë¼ú
     1700,          //2 ¹Ý¿ù°Ë¹ý
     3480,          //3 ¿°È­°á, ½ÃÀÛ
     3390,          //4 ¿°È­°á ¹ÝÂ¦ÀÓ
     1,2,3
  );
  }
  HitEffectBase: array[0..MAXHITEFFECT - 1] of Integer = (
    800, {1}
    1410, {2}
    1700, {3}
    3480, {4} //ÁÒ»ð
    3390, {5}
    40, {6}
    220, {7}
    740, {8} //ÆÆ¿Õ½£
    10, {9} //ÆÆ»êÕ¶
    495, {10} //ÅüÐÇÕ¶
    310, {11} //À×öªÒ»»÷
    470, {12} //¿ªÌìÕ¶
    1, {13} //4¼¶ÁÒ»ð
    510, {14} //ÖðÈÕ½£·¨
    0, {15}
    0, {16}
    0, {17}
    0, {18}
    0, {19}
    160, {20} //Èý¾øÉ±
    80, {21} //×·ÐÄ´Ì
    1920, {22} //¶ÏÔÀÕ¶
    560, {23} //ºáÉ¨Ç§¾ü
    0 {24}
    );
  MAXMAGICTYPE = 16;

type
  TMagicType = (mtReady, mtFly, mtExplosion,
    mtFlyAxe, mtFireWind, mtFireGun,
    mtLightingThunder, mtThunder, mtExploBujauk,
    mtBujaukGroundEffect, mtKyulKai, mtFlyArrow,
    mt12, mt13, mt14,
    mt15, mt16, mHeroMagic
    );

  TUseMagicInfo = record
    ServerMagicCode: Integer;
    MagicSerial: Integer;
    target: Integer; //recogcode
    EffectType: TMagicType;
    EffectNumber: Integer;
    targx: Integer;
    targy: Integer;
    Recusion: Boolean;
    anitime: Integer;
    MagicFire: Boolean;
  end;
  PTUseMagicInfo = ^TUseMagicInfo;

  TMagicEff = class //Size 0xC8
    m_boActive: Boolean; //0x04
    EffectNumber: Integer;
    ServerMagicId: Integer; //0x08
    MagOwner: TObject; //0x0C
    TargetActor: TObject; //0x10
    ImgLib: TGameImages; //0x14
    EffectBase: Integer; //0x18
    MagExplosionBase, OldMagExplosionBase: Integer; //0x1C
    px, py: Integer; //0x20 0x24
    rx, ry: Integer; //0x28 0x2C
    Dir16, OldDir16: Byte; //0x30  0x31
    targetx, targety: Integer; //0x34 0x38
    TargetRx, TargetRy: Integer; //0x3C 0x40
    FlyX, FlyY, OldFlyX, OldFlyY: Integer; //0x44 0x48 0x4C 0x50
    FlyXf, FlyYf: Real; //0x54 0x5C
    Repetition: Boolean; //0x64
    FixedEffect: Boolean; //0x65
    MagicType: Integer; //0x68
    NextEffect: TMagicEff; //0x6C
    ExplosionFrame: Integer; //0x70
    NextFrameTime: Integer; //0x74
    light: Integer; //0x78
    n7C: Integer;
    bt80: Byte;
    bt81: Byte;
    start: Integer; //0x84
    curframe: Integer; //0x88
    frame: Integer; //0x8C
  private

    m_dwFrameTime: LongWord; //0x90
    m_dwStartTime: LongWord; //0x94
    repeattime: LongWord; //0x98 ¹Ýº¹ ¾Ö´Ï¸ÞÀÌ¼Ç ½Ã°£ (-1: °è¼Ó)
    steptime: LongWord; //0x9C
    fireX, fireY: Integer; //0xA0 0xA4
    firedisX, firedisY: Integer; //0xA8 0xAC
    newfiredisX, newfiredisY: Integer; //0xB0 0xB4
    FireMyselfX, FireMyselfY: Integer; //0xB8 0xBC
    prevdisx, prevdisy: Integer; //0xC0 0xC4
  protected
    procedure GetFlyXY(ms: Integer; var fx, fy: Integer);
  public
    constructor Create(id, effnum, sx, sY, tx, ty: Integer; mtype: TMagicType; Recusion: Boolean; anitime: Integer);
    destructor Destroy; override;
    function Run: Boolean; dynamic; //false:³¡³µÀ½.
    function Shift: Boolean; dynamic;
    procedure DrawEff(Surface: TTexture); dynamic;
  end;

  TFlyingAxe = class(TMagicEff)
    FlyImageBase: Integer;
    ReadyFrame: Integer;
  public
    constructor Create(id, effnum, sx, sY, tx, ty: Integer; mtype: TMagicType; Recusion: Boolean; anitime: Integer);
    procedure DrawEff(Surface: TTexture); override;
  end;

  TFlyingBug = class(TMagicEff) //Size 0xD0
    FlyImageBase: Integer; //0xC8
    ReadyFrame: Integer; //0xCC
  public
    constructor Create(id, effnum, sx, sY, tx, ty: Integer; mtype: TMagicType; Recusion: Boolean; anitime: Integer);
    procedure DrawEff(Surface: TTexture); override;
  end;

  TFlyingArrow = class(TFlyingAxe)
  public
    procedure DrawEff(Surface: TTexture); override;
  end;
  TFlyingFireBall = class(TFlyingAxe) //0xD0
  public
    procedure DrawEff(Surface: TTexture); override;
  end;
  TCharEffect = class(TMagicEff)
  public
    constructor Create(effbase, effframe: Integer; target: TObject);
    function Run: Boolean; override; //false:³¡³µÀ½.
    procedure DrawEff(Surface: TTexture); override;
  end;

  TMapEffect = class(TMagicEff)
  public
    RepeatCount: Integer;
    constructor Create(effbase, effframe: Integer; X, Y: Integer);
    function Run: Boolean; override; //false:³¡³µÀ½.
    procedure DrawEff(Surface: TTexture); override;
  end;

  TScrollHideEffect = class(TMapEffect)
  public
    constructor Create(effbase, effframe: Integer; X, Y: Integer; target: TObject);
    function Run: Boolean; override;
  end;

  TLightingEffect = class(TMagicEff)
  public
    constructor Create(effbase, effframe: Integer; X, Y: Integer);
    function Run: Boolean; override;
  end;

  TFireNode = record
    X: Integer;
    Y: Integer;
    firenumber: Integer;
  end;

  TFireGunEffect = class(TMagicEff)
  public
    OutofOil: Boolean;
    firetime: LongWord;
    FireNodes: array[0..FIREGUNFRAME - 1] of TFireNode;
    constructor Create(effbase, sx, sY, tx, ty: Integer);
    function Run: Boolean; override;
    procedure DrawEff(Surface: TTexture); override;
  end;

  TThuderEffect = class(TMagicEff)
  public
    constructor Create(effbase, tx, ty: Integer; target: TObject);
    procedure DrawEff(Surface: TTexture); override;
  end;


  TMapMagicEffect = class(TMagicEff)
  public
    constructor Create(effbase, tx, ty: Integer; target: TObject);
    procedure DrawEff(Surface: TTexture); override;
  end;


  TLightingThunder = class(TMagicEff)
  public
    constructor Create(effbase, sx, sY, tx, ty: Integer; target: TObject);
    procedure DrawEff(Surface: TTexture); override;
  end;

  TExploBujaukEffect = class(TMagicEff)
  public
    constructor Create(effbase, sx, sY, tx, ty: Integer; target: TObject);
    procedure DrawEff(Surface: TTexture); override;
  end;

  TBujaukGroundEffect = class(TMagicEff) //Size  0xD0
  public
    MagicNumber: Integer; //0xC8
    BoGroundEffect: Boolean; //0xCC
    constructor Create(effbase, magicnumb, sx, sY, tx, ty: Integer);
    function Run: Boolean; override;
    procedure DrawEff(Surface: TTexture); override;
  end;
  TNormalDrawEffect = class(TMagicEff) //Size 0xCC
    boC8: Boolean;
  public
    constructor Create(xx, yy: Integer; WMImage: TGameImages; effbase, nX: Integer; frmTime: LongWord; boFlag: Boolean);
    function Run: Boolean; override;
    procedure DrawEff(Surface: TTexture); override;
  end;

  THeroShowEffect = class(TMagicEff)
  public
    constructor Create(effbase, effframe: Integer; target: TObject);
    function Run: Boolean; override;
    procedure DrawEff(Surface: TTexture); override;
  end;

  TLevelShowEffect = class(TMagicEff)
  public
    constructor Create(effbase, effframe: Integer; target: TObject);
    function Run: Boolean; override;
    procedure DrawEff(Surface: TTexture); override;
  end;

  TBlasthitEffect = class(TMagicEff)
  public
    constructor Create(effbase, effframe: Integer; target: TObject);
    function Run: Boolean; override;
    procedure DrawEff(Surface: TTexture); override;
  end;

  TExploSanYanZhouEffect = class(TMagicEff) //ÈýÑæÖä
  public
    constructor Create(effbase, sx, sY, tx, ty: Integer; target: TObject);
    procedure DrawEff(Surface: TTexture); override;
  end;

  TExploHuXiaoJueZhouEffect = class(TMagicEff) //»¢Ð¥¾÷
  public
    constructor Create(effbase, sx, sY, tx, ty: Integer; target: TObject);
    procedure DrawEff(Surface: TTexture); override;
  end;
procedure GetEffectBase(mag, mtype: Integer; var wimg: TGameImages; var idx: Integer);


implementation

uses
  Actor, SoundUtil, MShare;

//È¡µÃÄ§·¨Ð§¹ûËùÔÚÍ¼¿â

procedure GetEffectBase(mag, mtype: Integer; var wimg: TGameImages; var idx: Integer); //idx Ä§·¨µÄµÚÒ»ÕÅÍ¼µÄÎ»ÖÃ  mag = Effect
var
  nMag: Integer;
begin
  wimg := nil;
  idx := 0;
  case mtype of
    0: begin
        case mag of
          8, 27, 33..35, 37..39, 41..42, 43, 44, 45 {46}..48: begin
              wimg := g_WMagic2Images;
              if mag in [0..MAXEFFECT - 1] then
                idx := EffectBase[mag];
            end;
          31: begin
              wimg := g_WMonImages.Indexs[21]; //21
              if mag in [0..MAXEFFECT - 1] then
                idx := EffectBase[mag];
            end;
          36: begin
              wimg := g_WMonImages.Indexs[22]; //22
              if mag in [0..MAXEFFECT - 1] then
                idx := EffectBase[mag];
            end;
          49: begin
              wimg := g_WMagic5Images; //·ÖÉíÊõ
              if mag in [0..MAXEFFECT - 1] then
                idx := EffectBase[mag];
            end;

          59..64: begin
              wimg := g_WMagic4Images; //ºÏ»÷Ä§·¨
              if mag in [0..MAXEFFECT - 1] then
                idx := EffectBase[mag];
            end;
          50, 65: begin
              wimg := g_WMagic6Images; //Á÷ÐÇ»ðÓê 4¼¶ÃðÌì»ð
              if mag in [0..MAXEFFECT - 1] then
                idx := EffectBase[mag];
            end;
          66: begin
              wimg := g_WMagic6Images; //4¼¶Áé»ê»ð·û
              if mag in [0..MAXEFFECT - 1] then
                idx := EffectBase[mag];
            end;
          80..82: begin
              wimg := g_WDragonImg;
              if mag = 80 then begin
                if g_MySelf.m_nCurrX >= 84 then begin
                  idx := 130;
                end else begin
                  idx := 140;
                end;
              end;
              if mag = 81 then begin
                if (g_MySelf.m_nCurrX >= 78) and (g_MySelf.m_nCurrY >= 48) then begin
                  idx := 150;
                end else begin
                  idx := 160;
                end;
              end;
              if mag = 82 then begin
                idx := 180;
              end;
            end;
          89: begin
              wimg := g_WDragonImg;
              idx := 350;
            end;
          103..110: begin
              wimg := g_cboEffectImg;
              if mag in [0..MAXEFFECT - 1] then
                idx := EffectBase[mag];
            end;
          198, 199: begin
              wimg := g_WMagic5Images; //ÔÂÁéÄ§·¨
              if mag in [0..MAXEFFECT - 1] then
                idx := EffectBase[mag];
            end;
        else begin
            wimg := g_WMagicImages;
            nMag := mag;
            if nMag = 70 - 1 then nMag := 1 - 1;
            if nMag = 71 - 1 then nMag := 3 - 1;
            if nMag = 72 - 1 then nMag := 10 - 1;
            if nMag in [0..MAXEFFECT - 1] then
              idx := EffectBase[nMag];
          end;
        end;
      end;
    1: begin
        case mag of
          0..4: begin
              wimg := g_WMagicImages;
              if mag in [0..MAXHITEFFECT - 1] then begin
                idx := HitEffectBase[mag];
              end;
            end;
          5..7: begin
              wimg := g_WMagic2Images;
              if mag in [0..MAXHITEFFECT - 1] then begin
                idx := HitEffectBase[mag];
              end;
            end;
          8..10: begin //ºÏ»÷Ä§·¨
              wimg := g_WMagic4Images;
              if mag in [0..MAXHITEFFECT - 1] then begin
                idx := HitEffectBase[mag];
              end;
            end;
          11: begin
              wimg := g_WMagic5Images;
              if mag in [0..MAXHITEFFECT - 1] then begin
                idx := HitEffectBase[mag];
              end;
            end;
          12, 13: begin //   4¼¶ÁÒ»ð  ÖðÈÕ½£·¨
              wimg := g_WMagic6Images;
              if mag in [0..MAXHITEFFECT - 1] then begin
                idx := HitEffectBase[mag];
              end;
            end;
          19..23: begin //Èý¾øÉ± ×·ÐÄ´Ì ¶ÏÔÀÕ¶ ºáÉ¨Ç§¾ü
              wimg := g_cboEffectImg;
              if mag in [0..MAXHITEFFECT - 1] then begin
                idx := HitEffectBase[mag];
              end;
            end;
        end;
      end;
       //DScreen.AddChatBoardString('if mag = 10 then wimg := g_WMagic5Images; '+IntToStr(mag), clyellow, clRed);
  end;
end;

constructor TMagicEff.Create(id, effnum, sx, sY, tx, ty: Integer; mtype: TMagicType; Recusion: Boolean; anitime: Integer);
var
  tax, tay: Integer;
begin
  ImgLib := g_WMagicImages;
  OldMagExplosionBase := -1;
  case mtype of
    mtFly, mtBujaukGroundEffect, mtExploBujauk: begin
        start := 0;
        frame := 6;
        curframe := start;
        FixedEffect := False;
        Repetition := Recusion;
        ExplosionFrame := 10;
        //if id = 38 then frame := 5;
        //ExplosionFrame := 20;
        if id = 39 then begin
          frame := 4;
          ExplosionFrame := 8;
        end;
        if (id - 81 - 3) < 0 then begin
          bt80 := 1;
          Repetition := True;
          if id = 81 then begin
            if g_MySelf.m_nCurrX >= 84 then begin
              EffectBase := 130;
            end else begin
              EffectBase := 140;
            end;
            bt81 := 1;
          end;
          if id = 82 then begin
            if (g_MySelf.m_nCurrX >= 78) and (g_MySelf.m_nCurrY >= 48) then begin
              EffectBase := 150;
            end else begin
              EffectBase := 160;
            end;
            bt81 := 2;
          end;
          if id = 83 then begin
            EffectBase := 180;
            bt81 := 3;
          end;
          start := 0;
          frame := 10;
          MagExplosionBase := 190;
          ExplosionFrame := 10;
        end;
      end;
    mt12: begin
        start := 0;
        frame := 6;
        curframe := start;
        FixedEffect := False;
        Repetition := Recusion;
        ExplosionFrame := 1;
      end;
    mt13: begin
        start := 0;
        frame := 20;
        curframe := start;
        FixedEffect := True;
        Repetition := False;
        ExplosionFrame := 20;
        ImgLib := g_WMonImages.Indexs[20]; //20
      end;
    mtExplosion, mtThunder, mtLightingThunder: begin
        start := 0;
        frame := -1;
        ExplosionFrame := 10;
        curframe := start;
        FixedEffect := True;
        Repetition := False;
        if id = 80 then begin
          bt80 := 2;
          case Random(6) of
            0: begin
                EffectBase := 230;
              end;
            1: begin
                EffectBase := 240;
              end;
            2: begin
                EffectBase := 250;
              end;
            3: begin
                EffectBase := 230;
              end;
            4: begin
                EffectBase := 240;
              end;
            5: begin
                EffectBase := 250;
              end;
          end;
          light := 4;
          ExplosionFrame := 5;
        end;
        if id = 70 then begin
          bt80 := 3;
          case Random(3) of
            0: begin
                EffectBase := 400;
              end;
            1: begin
                EffectBase := 410;
              end;
            2: begin
                EffectBase := 420;
              end;
          end;
          light := 4;
          ExplosionFrame := 5;
        end;
        if id = 71 then begin
          bt80 := 3;
          ExplosionFrame := 20;
        end;
        if id = 72 then begin
          bt80 := 3;
          light := 3;
          ExplosionFrame := 10;
        end;
        if id = 73 then begin
          bt80 := 3;
          light := 5;
          ExplosionFrame := 20;
        end;
        if id = 74 then begin
          bt80 := 3;
          light := 4;
          ExplosionFrame := 35;
        end;
        if id = 90 then begin
          EffectBase := 350;
          MagExplosionBase := 350;
          ExplosionFrame := 30;
        end;
      end;
    mt14: begin
        start := 0;
        frame := -1;
        curframe := start;
        FixedEffect := True;
        Repetition := False;
        ImgLib := g_WMagic2Images;
      end;
    mtFlyAxe: begin
        start := 0;
        frame := 3;
        curframe := start;
        FixedEffect := False;
        Repetition := Recusion;
        ExplosionFrame := 3;
      end;
    mtFlyArrow: begin
        start := 0;
        frame := 1;
        curframe := start;
        FixedEffect := False;
        Repetition := Recusion;
        ExplosionFrame := 1;
      end;
    mt15: begin
        start := 0;
        frame := 6;
        curframe := start;
        FixedEffect := False;
        Repetition := Recusion;
        ExplosionFrame := 2;
      end;
    mt16: begin
        start := 0;
        frame := 1;
        curframe := start;
        FixedEffect := False;
        Repetition := Recusion;
        ExplosionFrame := 1;
      end;
  end;
  n7C := 0;
  {
  case mtype of
     mtReady:
        begin
        end;
     mtFly,             ;
     mtBujaukGroundEffect,
     mtExploBujauk:
        begin
           start := 0;
           frame := 6;
           curframe := start;
           FixedEffect := FALSE;
           Repetition := Recusion;
           ExplosionFrame := 10;
        end;
     mtExplosion,
     mtThunder,
     mtLightingThunder:
        begin
           start := 0;
           frame := -1;
           ExplosionFrame := 10;
           curframe := start;
           FixedEffect := TRUE;
           Repetition := FALSE;
        end;
     mtFlyAxe:
        begin
           start := 0;
           frame := 3;
           curframe := start;
           FixedEffect := FALSE;
           Repetition := Recusion;
           ExplosionFrame := 3;
        end;
     mtFlyArrow:
        begin
           start := 0;
           frame := 1;
           curframe := start;
           FixedEffect := FALSE;
           Repetition := Recusion;
           ExplosionFrame := 1;
        end;
  end;
  }
  EffectNumber := -1;
  ServerMagicId := id;
  EffectBase := effnum; //MagicDB - Effect
  targetx := tx; // "   target x
  targety := ty; // "   target y

  if bt80 = 1 then begin
    if id = 81 then begin
      Dec(sx, 14);
      Inc(sY, 20);
    end;
    if id = 81 then begin
      Dec(sx, 70);
      Dec(sY, 10);
    end;
    if id = 83 then begin
      Dec(sx, 60);
      Dec(sY, 70);
    end;
    PlaySound(8208);
  end;
  fireX := sx; //
  fireY := sY; //
  FlyX := sx; //
  FlyY := sY;
  OldFlyX := sx;
  OldFlyY := sY;
  FlyXf := sx;
  FlyYf := sY;
  FireMyselfX := g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX;
  FireMyselfY := g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY;
  if bt80 = 0 then begin
    MagExplosionBase := EffectBase + EXPLOSIONBASE;
  end;

  light := 1;

  if fireX <> targetx then tax := abs(targetx - fireX)
  else tax := 1;
  if fireY <> targety then tay := abs(targety - fireY)
  else tay := 1;
  if abs(fireX - targetx) > abs(fireY - targety) then begin
    firedisX := Round((targetx - fireX) * (500 / tax));
    firedisY := Round((targety - fireY) * (500 / tax));
  end else begin
    firedisX := Round((targetx - fireX) * (500 / tay));
    firedisY := Round((targety - fireY) * (500 / tay));
  end;

  NextFrameTime := 50;
  m_dwFrameTime := GetTickCount;
  m_dwStartTime := GetTickCount;
  steptime := GetTickCount;
  repeattime := anitime;
  Dir16 := GetFlyDirection16(sx, sY, tx, ty);
  OldDir16 := Dir16;
  NextEffect := nil;
  m_boActive := True;
  prevdisx := 99999;
  prevdisy := 99999;
end;

destructor TMagicEff.Destroy;
begin
  inherited Destroy;
end;

function TMagicEff.Shift: Boolean;
  function OverThrough(olddir, newdir: Integer): Boolean;
  begin
    Result := FALSE;
    if abs(olddir - newdir) >= 2 then begin
      Result := True;
      if ((olddir = 0) and (newdir = 15)) or ((olddir = 15) and (newdir = 0)) then
        Result := FALSE;
    end;
  end;
var
  I, rrx, rry, ms, stepx, stepy, newstepx, newstepy, nn: Integer;
  tax, tay, shx, shy, passdir16: Integer;
  crash: Boolean;
  stepxf, stepyf: Real;
begin
  Result := True;
  if Repetition then begin
    if GetTickCount - steptime > longword(NextFrameTime) then begin
      steptime := GetTickCount;
      Inc(curframe);
      if curframe > start + frame - 1 then
        curframe := start;
    end;
  end else begin
    if (frame > 0) and (GetTickCount - steptime > longword(NextFrameTime)) then begin
      steptime := GetTickCount;
      Inc(curframe);
      if curframe > start + frame - 1 then begin
        curframe := start + frame - 1;
        Result := FALSE;
      end;
    end;
  end;
  if (not FixedEffect) then begin
    //DebugOutStr('(not FixedEffect)');
    crash := FALSE;
    if TargetActor <> nil then begin
      ms := GetTickCount - m_dwFrameTime; //ÀÌÀü È¿°ú¸¦ ±×¸°ÈÄ ¾ó¸¶³ª ½Ã°£ÀÌ Èê·¶´ÂÁö?
      m_dwFrameTime := GetTickCount;
         //TargetX, TargetY Àç¼³Á¤
      PlayScene.ScreenXYfromMCXY(TActor(TargetActor).m_nRx,
        TActor(TargetActor).m_nRy,
        targetx,
        targety);
      shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
      shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;
      targetx := targetx + shx;
      targety := targety + shy;

         //»õ·Î¿î Å¸°ÙÀ» ÁÂÇ¥¸¦ »õ·Î ¼³Á¤ÇÑ´Ù.
      if FlyX <> targetx then tax := abs(targetx - FlyX)
      else tax := 1;
      if FlyY <> targety then tay := abs(targety - FlyY)
      else tay := 1;
      if abs(FlyX - targetx) > abs(FlyY - targety) then begin
        newfiredisX := Round((targetx - FlyX) * (500 / tax));
        newfiredisY := Round((targety - FlyY) * (500 / tax));
      end else begin
        newfiredisX := Round((targetx - FlyX) * (500 / tay));
        newfiredisY := Round((targety - FlyY) * (500 / tay));
      end;

      if firedisX < newfiredisX then firedisX := firedisX + _MAX(1, (newfiredisX - firedisX) div 10);
      if firedisX > newfiredisX then firedisX := firedisX - _MAX(1, (firedisX - newfiredisX) div 10);
      if firedisY < newfiredisY then firedisY := firedisY + _MAX(1, (newfiredisY - firedisY) div 10);
      if firedisY > newfiredisY then firedisY := firedisY - _MAX(1, (firedisY - newfiredisY) div 10);

      stepxf := (firedisX / 700) * ms;
      stepyf := (firedisY / 700) * ms;
      FlyXf := FlyXf + stepxf;
      FlyYf := FlyYf + stepyf;
      FlyX := Round(FlyXf);
      FlyY := Round(FlyYf);

         //¹æÇâ Àç¼³Á¤
       //  Dir16 := GetFlyDirection16 (OldFlyX, OldFlyY, FlyX, FlyY);
      OldFlyX := FlyX;
      OldFlyY := FlyY;
         //Åë°ú¿©ºÎ¸¦ È®ÀÎÇÏ±â À§ÇÏ¿©
      passdir16 := GetFlyDirection16(FlyX, FlyY, targetx, targety);
      {
      DebugOutStr(IntToStr(prevdisx) + ' ' + IntToStr(prevdisy) + ' / ' + IntToStr(abs(targetx - FlyX)) + ' ' + IntToStr(abs(targety - FlyY)) + '   ' +
        IntToStr(firedisX) + '.' + IntToStr(firedisY) + ' ' +
        IntToStr(FlyX) + '.' + IntToStr(FlyY) + ' ' +
        IntToStr(targetx) + '.' + IntToStr(targety));
        }
      if ((abs(targetx - FlyX) <= 15) and (abs(targety - FlyY) <= 15)) or
        ((abs(targetx - FlyX) >= prevdisx) and (abs(targety - FlyY) >= prevdisy)) or
        OverThrough(OldDir16, passdir16) then begin
        crash := True;
      end else begin
        prevdisx := abs(targetx - FlyX);
        prevdisy := abs(targety - FlyY);
            //if (prevdisx <= 5) and (prevdisy <= 5) then crash := TRUE;
      end;
      OldDir16 := passdir16;

    end else begin
      ms := GetTickCount - m_dwFrameTime; //È¿°úÀÇ ½ÃÀÛÈÄ ¾ó¸¶³ª ½Ã°£ÀÌ Èê·¶´ÂÁö?

      rrx := targetx - fireX;
      rry := targety - fireY;

      stepx := Round((firedisX / 900) * ms);
      stepy := Round((firedisY / 900) * ms);
      FlyX := fireX + stepx;
      FlyY := fireY + stepy;
    end;

    PlayScene.CXYfromMouseXY(FlyX, FlyY, rx, ry);

    if crash and (TargetActor <> nil) then begin
      FixedEffect := True;
      start := 0;
      frame := ExplosionFrame;
      curframe := start;
      Repetition := False;

      PlaySound(TActor(MagOwner).m_nMagicExplosionSound);

    end;
      //if not Map.CanFly (Rx, Ry) then
      //   Result := FALSE;
  end;
  if FixedEffect then begin
    if frame = -1 then frame := ExplosionFrame;
    if TargetActor = nil then begin
      FlyX := targetx - ((g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX);
      FlyY := targety - ((g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY);
      PlayScene.CXYfromMouseXY(FlyX, FlyY, rx, ry);
    end else begin
      rx := TActor(TargetActor).m_nRx;
      ry := TActor(TargetActor).m_nRy;
      PlayScene.ScreenXYfromMCXY(rx, ry, FlyX, FlyY);
      FlyX := FlyX + TActor(TargetActor).m_nShiftX;
      FlyY := FlyY + TActor(TargetActor).m_nShiftY;
    end;
  end;
end;

procedure TMagicEff.GetFlyXY(ms: Integer; var fx, fy: Integer);
var
  rrx, rry, stepx, stepy: Integer;
begin
  rrx := targetx - fireX;
  rry := targety - fireY;

  stepx := Round((firedisX / 900) * ms);
  stepy := Round((firedisY / 900) * ms);
  fx := fireX + stepx;
  fy := fireY + stepy;
end;

function TMagicEff.Run: Boolean;
begin
  Result := Shift;
  if Result then
    if GetTickCount - m_dwStartTime > 10000 then //2000 then
      Result := False
    else Result := True;
end;

procedure TMagicEff.DrawEff(Surface: TTexture);
var
  img: Integer;
  d: TTexture;
  shx, shy: Integer;
begin
  if not CanDraw then Exit;
  if m_boActive and ((abs(FlyX - fireX) > 15) or (abs(FlyY - fireY) > 15) or FixedEffect) then begin

    shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
    shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;

    if not FixedEffect then begin
      if EffectNumber = 106 then //¾ªÀ×±¬
        img := EffectBase + FLYBASE + curframe
      else
        img := EffectBase + FLYBASE + Dir16 * 10 + curframe;
      //DebugOutStr('TMagicEff.DrawEff not FixedEffect:' + IntToStr(img)+ ' EffectBase:'+IntToStr(EffectBase));
      d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        DrawBlend(Surface,
          FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy,
          d);
      end;
    end else begin
      if EffectNumber = 107 then begin //±ùÌìÑ©µØ
        img := MagExplosionBase + curframe + Dir16 * 10;
      end else
        if EffectNumber = 109 then begin //°ËØÔÕÆ
        img := MagExplosionBase + curframe + Dir16 * 10;
      end else
        if EffectNumber = 111 then begin //Íò½£¹é×Ú
        img := MagExplosionBase + curframe + Dir16 * 10;
      end else
        img := MagExplosionBase + curframe; //EXPLOSIONBASE;
      //DebugOutStr('TMagicEff.DrawEff FixedEffect:' + IntToStr(img));
      d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        DrawBlend(Surface,
          FlyX + px - UNITX div 2,
          FlyY + py - UNITY div 2,
          d);
      end;
    end;
  end;
end;

{------------------------------------------------------------}

//      TFlyingAxe : ³¯¾Æ°¡´Â µµ³¢

{------------------------------------------------------------}


constructor TFlyingAxe.Create(id, effnum, sx, sY, tx, ty: Integer; mtype: TMagicType; Recusion: Boolean; anitime: Integer);
begin
  inherited Create(id, effnum, sx, sY, tx, ty, mtype, Recusion, anitime);
  FlyImageBase := FLYOMAAXEBASE;
  ReadyFrame := 65;
end;

procedure TFlyingAxe.DrawEff(Surface: TTexture);
var
  img: Integer;
  d: TTexture;
  shx, shy: Integer;
begin
  if not CanDraw then Exit;
  if m_boActive and ((abs(FlyX - fireX) > ReadyFrame) or (abs(FlyY - fireY) > ReadyFrame)) then begin

    shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
    shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;

    if not FixedEffect then begin
      //
      img := FlyImageBase + Dir16 * 10;
      d := ImgLib.GetCachedImage(img + curframe, px, py);
      if d <> nil then begin
        //¾ËÆÄºí·©µùÇÏÁö ¾ÊÀ½
        Surface.Draw(FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy,
          d.ClientRect, d, True);
      end;
    end else begin
      {//Á¤Áö, µµ³¢¿¡ ÂïÈù ¸ð½À.
      img := FlyImageBase + Dir16 * 10;
      d := ImgLib.GetCachedImage (img, px, py);
      if d <> nil then begin
         //¾ËÆÄºí·©µùÇÏÁö ¾ÊÀ½
         surface.Draw (FlyX + px - UNITX div 2,
                       FlyY + py - UNITY div 2,
                       d.ClientRect, d, TRUE);
      end;  }
    end;
  end;
end;


{------------------------------------------------------------}

//      TFlyingArrow : ³¯¾Æ°¡´Â È­»ì

{------------------------------------------------------------}


procedure TFlyingArrow.DrawEff(Surface: TTexture);
var
  img: Integer;
  d: TTexture;
  shx, shy: Integer;
begin
  if not CanDraw then Exit;
  if m_boActive and ((abs(FlyX - fireX) > 40) or (abs(FlyY - fireY) > 40)) then begin
    //*)
    (**ÀÌÀü
       if Active then begin //and ((Abs(FlyX-fireX) > 65) or (Abs(FlyY-fireY) > 65)) then begin
    //*)
    shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
    shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;

    if not FixedEffect then begin
      //³¯¾Æ°¡´Â°Å
      img := FlyImageBase + Dir16; // * 10;
      d := ImgLib.GetCachedImage(img + curframe, px, py);
      //(**6¿ùÆÐÄ¡
      if d <> nil then begin
        //¾ËÆÄºí·©µùÇÏÁö ¾ÊÀ½
        Surface.Draw(FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy - 46,
          d.ClientRect, d, True);
      end;
      //**)
      (***ÀÌÀü
               if d <> nil then begin
                  //¾ËÆÄºí·©µùÇÏÁö ¾ÊÀ½
                  surface.Draw (FlyX + px - UNITX div 2 - shx,
                                FlyY + py - UNITY div 2 - shy,
                                d.ClientRect, d, TRUE);
               end;
      //**)
    end;
  end;
end;


{--------------------------------------------------------}

constructor TCharEffect.Create(effbase, effframe: Integer; target: TObject);
begin
  inherited Create(111, effbase,
    TActor(target).m_nCurrX, TActor(target).m_nCurrY,
    TActor(target).m_nCurrX, TActor(target).m_nCurrY,
    mtExplosion,
    False,
    0);
  TargetActor := target;
  frame := effframe;
  NextFrameTime := 30;
end;

function TCharEffect.Run: Boolean;
begin
  Result := True;
  if GetTickCount - steptime > LongWord(NextFrameTime) then begin
    steptime := GetTickCount;
    Inc(curframe);
    if curframe > start + frame - 1 then begin
      curframe := start + frame - 1;
      Result := False;
    end;
  end;
end;

procedure TCharEffect.DrawEff(Surface: TTexture);
var
  d: TTexture;
begin
  if not CanDraw then Exit;
  if TargetActor <> nil then begin
    rx := TActor(TargetActor).m_nRx;
    ry := TActor(TargetActor).m_nRy;
    PlayScene.ScreenXYfromMCXY(rx, ry, FlyX, FlyY);
    FlyX := FlyX + TActor(TargetActor).m_nShiftX;
    FlyY := FlyY + TActor(TargetActor).m_nShiftY;
    d := ImgLib.GetCachedImage(EffectBase + curframe, px, py);
    if d <> nil then begin
      DrawBlend(Surface,
        FlyX + px - UNITX div 2,
        FlyY + py - UNITY div 2,
        d);
    end;
  end;
end;


{--------------------------------------------------------}

constructor TMapEffect.Create(effbase, effframe: Integer; X, Y: Integer);
begin
  inherited Create(111, effbase,
    X, Y,
    X, Y,
    mtExplosion,
    False,
    0);
  TargetActor := nil;
  frame := effframe;
  NextFrameTime := 30;
  RepeatCount := 0;
end;

function TMapEffect.Run: Boolean;
begin
  Result := True;
  if GetTickCount - steptime > LongWord(NextFrameTime) then begin
    steptime := GetTickCount;
    Inc(curframe);
    if curframe > start + frame - 1 then begin
      curframe := start + frame - 1;
      if RepeatCount > 0 then begin
        Dec(RepeatCount);
        curframe := start;
      end else
        Result := False;
    end;
  end;
end;

procedure TMapEffect.DrawEff(Surface: TTexture);
var
  d: TTexture;
begin
  if not CanDraw then Exit;
  rx := targetx;
  ry := targety;
  PlayScene.ScreenXYfromMCXY(rx, ry, FlyX, FlyY);
  d := ImgLib.GetCachedImage(EffectBase + curframe, px, py);
  if d <> nil then begin
    DrawBlend(Surface,
      FlyX + px - UNITX div 2,
      FlyY + py - UNITY div 2,
      d);
  end;
end;


{--------------------------------------------------------}

constructor TScrollHideEffect.Create(effbase, effframe: Integer; X, Y: Integer; target: TObject);
begin
  inherited Create(effbase, effframe, X, Y);
  //TargetCret := TActor(target);//ÔÚ³öÏÖÓÐÈËÓÃËæ»úÖ®ÀàÊ±£¬½«ÉèÖÃÄ¿±ê
end;

function TScrollHideEffect.Run: Boolean;
begin
  Result := inherited Run;
  if frame = 7 then
    if g_TargetCret <> nil then
      PlayScene.DeleteActor(g_TargetCret.m_nRecogId);
end;


{--------------------------------------------------------}
{--------------------------------------------------------}

constructor THeroShowEffect.Create(effbase, effframe: Integer; target: TObject);
begin
  inherited Create(111, effbase,
    TActor(target).m_nCurrX, TActor(target).m_nCurrY,
    TActor(target).m_nCurrX, TActor(target).m_nCurrY,
    mtExplosion,
    False,
    0);
  TargetActor := target;
  frame := effframe;
  NextFrameTime := 60;
end;

function THeroShowEffect.Run: Boolean;
begin
  Result := True;
  if GetTickCount - steptime > LongWord(NextFrameTime) then begin
    steptime := GetTickCount;
    Inc(curframe);
    if curframe > start + frame - 1 then begin
      curframe := start + frame - 1;
      Result := False;
    end;
  end;
end;

procedure THeroShowEffect.DrawEff(Surface: TTexture);
var
  d: TTexture;
begin
  if not CanDraw then Exit;
  rx := targetx;
  ry := targety;
  PlayScene.ScreenXYfromMCXY(rx, ry, FlyX, FlyY);
  //d := ImgLib.GetCachedImage(EffectBase + curframe, px, py);
  d := g_WEffectImg.GetCachedImage(EffectBase + curframe, px, py);
  if d <> nil then begin
    DrawBlend(Surface,
      FlyX + px - UNITX div 2,
      FlyY + py - UNITY div 2,
      d);
  end;
end;

constructor TLevelShowEffect.Create(effbase, effframe: Integer; target: TObject);
begin
  inherited Create(111, effbase,
    TActor(target).m_nCurrX, TActor(target).m_nCurrY,
    TActor(target).m_nCurrX, TActor(target).m_nCurrY,
    mtExplosion,
    False,
    0);
  TargetActor := target;
  frame := effframe;
  NextFrameTime := 60;
end;

function TLevelShowEffect.Run: Boolean;
begin
  Result := True;
  if GetTickCount - steptime > LongWord(NextFrameTime) then begin
    steptime := GetTickCount;
    Inc(curframe);
    if curframe > start + frame - 1 then begin
      curframe := start + frame - 1;
      Result := False;
    end;
  end;
end;

procedure TLevelShowEffect.DrawEff(Surface: TTexture);
var
  d: TTexture;
begin
  if not CanDraw then Exit;
  rx := targetx;
  ry := targety;
  PlayScene.ScreenXYfromMCXY(rx, ry, FlyX, FlyY);
  //d := ImgLib.GetCachedImage(EffectBase + curframe, px, py);
  d := g_WMain2Images.GetCachedImage(EffectBase + curframe, px, py);
  if d <> nil then begin
    DrawBlend(Surface,
      FlyX + px - UNITX div 2,
      FlyY + py - UNITY div 2,
      d);
  end;
end;
{--------------------------------------------------------}




constructor TBlasthitEffect.Create(effbase, effframe: Integer; target: TObject);
begin
  inherited Create(111, effbase,
    TActor(target).m_nCurrX, TActor(target).m_nCurrY,
    TActor(target).m_nCurrX, TActor(target).m_nCurrY,
    mtExplosion,
    False,
    0);
  TargetActor := target;
  frame := effframe;
  NextFrameTime := 150;
end;

function TBlasthitEffect.Run: Boolean;
begin
  Result := True;
  if GetTickCount - steptime > LongWord(NextFrameTime) then begin
    steptime := GetTickCount;
    Inc(curframe);
    if curframe > start + frame - 1 then begin
      curframe := start + frame - 1;
      Result := False;
    end;
  end;
end;

procedure TBlasthitEffect.DrawEff(Surface: TTexture);
var
  d: TTexture;
begin
  if not CanDraw then Exit;
  rx := targetx;
  ry := targety;
  PlayScene.ScreenXYfromMCXY(rx, ry, FlyX, FlyY);
  //d := ImgLib.GetCachedImage(EffectBase + curframe, px, py);
  d := g_cboEffectImg.GetCachedImage(EffectBase + curframe, px, py);
  if d <> nil then begin
    DrawBlend(Surface,
      FlyX + px - UNITX div 2,
      FlyY + py - UNITY div 2,
      d);
  end;
end;
{--------------------------------------------------------}

constructor TLightingEffect.Create(effbase, effframe: Integer; X, Y: Integer);
begin

end;

function TLightingEffect.Run: Boolean;
begin
  Result := False; //Jacky
end;


{--------------------------------------------------------}


constructor TFireGunEffect.Create(effbase, sx, sY, tx, ty: Integer);
begin
  inherited Create(111, effbase,
    sx, sY,
    tx, ty, //TActor(target).XX, TActor(target).m_nCurrY,
    mtFireGun,
    True,
    0);
  NextFrameTime := 50;
  FillChar(FireNodes, SizeOf(TFireNode) * FIREGUNFRAME, #0);
  OutofOil := False;
  firetime := GetTickCount;
end;

function TFireGunEffect.Run: Boolean;
var
  I, fx, fy: Integer;
  allgone: Boolean;
begin
  Result := True;
  if GetTickCount - steptime > LongWord(NextFrameTime) then begin
    Shift;
    steptime := GetTickCount;
    //if not FixedEffect then begin  //¸ñÇ¥¿¡ ¸ÂÁö ¾Ê¾ÒÀ¸¸é
    if not OutofOil then begin
      if (abs(rx - TActor(MagOwner).m_nRx) >= 5) or (abs(ry - TActor(MagOwner).m_nRy) >= 5) or (GetTickCount - firetime > 800) then
        OutofOil := True;
      for I := FIREGUNFRAME - 2 downto 0 do begin
        FireNodes[I].firenumber := FireNodes[I].firenumber + 1;
        FireNodes[I + 1] := FireNodes[I];
      end;
      FireNodes[0].firenumber := 1;
      FireNodes[0].X := FlyX;
      FireNodes[0].Y := FlyY;
    end else begin
      allgone := True;
      for I := FIREGUNFRAME - 2 downto 0 do begin
        if FireNodes[I].firenumber <= FIREGUNFRAME then begin
          FireNodes[I].firenumber := FireNodes[I].firenumber + 1;
          FireNodes[I + 1] := FireNodes[I];
          allgone := False;
        end;
      end;
      if allgone then Result := False;
    end;
  end;
end;

procedure TFireGunEffect.DrawEff(Surface: TTexture);
var
  I, num, shx, shy, fireX, fireY, prx, pry, img: Integer;
  d: TTexture;
begin
  if not CanDraw then Exit;
  prx := -1;
  pry := -1;
  for I := 0 to FIREGUNFRAME - 1 do begin
    if (FireNodes[I].firenumber <= FIREGUNFRAME) and (FireNodes[I].firenumber > 0) then begin
      shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
      shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;

      img := EffectBase + (FireNodes[I].firenumber - 1);
      d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        fireX := FireNodes[I].X + px - UNITX div 2 - shx;
        fireY := FireNodes[I].Y + py - UNITY div 2 - shy;
        if (fireX <> prx) or (fireY <> pry) then begin
          prx := fireX;
          pry := fireY;
          DrawBlend(Surface, fireX, fireY, d);
        end;
      end;
    end;
  end;
end;

{--------------------------------------------------------}

constructor TThuderEffect.Create(effbase, tx, ty: Integer; target: TObject);
begin
  inherited Create(111, effbase,
    tx, ty,
    tx, ty, //TActor(target).XX, TActor(target).m_nCurrY,
    mtThunder,
    False,
    0);
  TargetActor := target;
end;

procedure TThuderEffect.DrawEff(Surface: TTexture);
var
  img, px, py: Integer;
  d: TTexture;
begin
  if not CanDraw then Exit;
  img := EffectBase;
  d := ImgLib.GetCachedImage(img + curframe, px, py);
  if d <> nil then begin
    DrawBlend(Surface,
      FlyX + px - UNITX div 2,
      FlyY + py - UNITY div 2,
      d);
  end;
end;


constructor TMapMagicEffect.Create(effbase, tx, ty: Integer; target: TObject);
var
  I, scx, scy, sctx, scty: Integer;
begin
  PlayScene.ScreenXYfromMCXY(70, 70, scx, scy);
  PlayScene.ScreenXYfromMCXY(tx, ty, sctx, scty);
  {if magnumb > 0 then GetEffectBase(magnumb - 1, 0, wimg, effnum)
  else effnum := -magnumb;
  target := FindActor(targetcode);
  }
  inherited Create(111, effbase,
    scx, scy,
    sctx, scty, //TActor(target).XX, TActor(target).m_nCurrY,
    mtThunder,
    False,
    0);
  TargetActor := target;
end;

procedure TMapMagicEffect.DrawEff(Surface: TTexture);
var
  img, px, py: Integer;
  d: TTexture;
begin
  if not CanDraw then Exit;
  img := EffectBase;
  d := ImgLib.GetCachedImage(img + curframe, px, py);
  if d <> nil then begin
    DrawBlend(Surface,
      FlyX + px - UNITX div 2,
      FlyY + py - UNITY div 2,
      d);
  end;
end;

{--------------------------------------------------------}

constructor TLightingThunder.Create(effbase, sx, sY, tx, ty: Integer; target: TObject);
begin
  inherited Create(111, effbase,
    sx, sY,
    tx, ty, //TActor(target).XX, TActor(target).m_nCurrY,
    mtLightingThunder,
    False,
    0);
  TargetActor := target;
end;

procedure TLightingThunder.DrawEff(Surface: TTexture);
var
  img, sx, sY, px, py, shx, shy: Integer;
  d: TTexture;
begin
  if not CanDraw then Exit;
  img := EffectBase + Dir16 * 10;
  if curframe < 6 then begin
    shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
    shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;
    d := ImgLib.GetCachedImage(img + curframe, px, py);
    if d <> nil then begin
      PlayScene.ScreenXYfromMCXY(TActor(MagOwner).m_nRx,
        TActor(MagOwner).m_nRy,
        sx,
        sY);
      DrawBlend(Surface,
        sx + px - UNITX div 2,
        sY + py - UNITY div 2,
        d);
    end;
  end;
  {if (curframe < 10) and (TargetActor <> nil) then begin
     d := ImgLib.GetCachedImage (EffectBase + 17*10 + curframe, px, py);
     if d <> nil then begin
        PlayScene.ScreenXYfromMCXY (TActor(TargetActor).RX,
                                    TActor(TargetActor).RY,
                                    sx,
                                    sy);
        DrawBlend (surface,
                   sx + px - UNITX div 2,
                   sy + py - UNITY div 2,
                   d);
     end;
  end;}
end;


{--------------------------------------------------------}

constructor TExploBujaukEffect.Create(effbase, sx, sY, tx, ty: Integer; target: TObject);
begin
  inherited Create(111, effbase,
    sx, sY,
    tx, ty,
    mtExploBujauk,
    True,
    0);
  frame := 3;
  TargetActor := target;
  NextFrameTime := 50;
end;

procedure TExploBujaukEffect.DrawEff(Surface: TTexture);
var
  img: Integer;
  d: TTexture;
  shx, shy: Integer;
  meff: TMapEffect;
begin
  if not CanDraw then Exit;
  if m_boActive and ((abs(FlyX - fireX) > 30) or (abs(FlyY - fireY) > 30) or FixedEffect) then begin
    shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
    shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;
    if not FixedEffect then begin
      img := EffectBase + Dir16 * 10;
      d := ImgLib.GetCachedImage(img + curframe, px, py);
      if d <> nil then begin
        Surface.Draw(FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy,
          d.ClientRect, d, True);
      end;
    end else begin
      img := MagExplosionBase + curframe;
      d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        DrawBlend(Surface,
          FlyX + px - UNITX div 2,
          FlyY + py - UNITY div 2,
          d);
      end;
    end;
  end;
end;


{--------------------------------------------------------}

constructor TExploSanYanZhouEffect.Create(effbase, sx, sY, tx, ty: Integer; target: TObject);
begin
  inherited Create(111, effbase,
    sx, sY,
    tx, ty,
    mtExploBujauk,
    True,
    0);
  frame := 5;
  TargetActor := target;
  NextFrameTime := 50;
end;

procedure TExploSanYanZhouEffect.DrawEff(Surface: TTexture);
var
  img: Integer;
  d: TTexture;
  shx, shy: Integer;
  meff: TMapEffect;
begin
  if not CanDraw then Exit;
  if m_boActive and ((abs(FlyX - fireX) > 30) or (abs(FlyY - fireY) > 30) or FixedEffect) then begin
    shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
    shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;
    if not FixedEffect then begin
      img := EffectBase + Dir16 * 10;

      d := ImgLib.GetCachedImage(img + curframe + 160, px, py);
      if d <> nil then begin
        Surface.Draw(FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy,
          d.ClientRect, d, True);
      end;

      d := ImgLib.GetCachedImage(img + curframe, px, py);
      if d <> nil then begin
        DrawBlend(Surface,
          FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy,
          d);
      end;

    end else begin
      img := MagExplosionBase + curframe;
      d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        DrawBlend(Surface,
          FlyX + px - UNITX div 2,
          FlyY + py - UNITY div 2,
          d);
      end;
    end;
  end;
end;
{--------------------------------------------------------}//»¢Ð¥¾÷

constructor TExploHuXiaoJueZhouEffect.Create(effbase, sx, sY, tx, ty: Integer; target: TObject);
begin
  inherited Create(111, effbase,
    sx, sY,
    tx, ty,
    mtExploBujauk,
    True,
    0);
  frame := 5;
  TargetActor := target;
  NextFrameTime := 80;
end;

procedure TExploHuXiaoJueZhouEffect.DrawEff(Surface: TTexture);
var
  img: Integer;
  d: TTexture;
  shx, shy: Integer;
  meff: TMapEffect;
begin
  if not CanDraw then Exit;
  if m_boActive and ((abs(FlyX - fireX) > 30) or (abs(FlyY - fireY) > 30) or FixedEffect) then begin
    shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
    shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;
    if not FixedEffect then begin
      img := EffectBase + Dir16 * 5 + curframe;
      d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        Surface.Draw(FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy,
          d.ClientRect, d, True);
      end;

      d := ImgLib.GetCachedImage(img + 80, px, py);
      if d <> nil then begin
        DrawBlend(Surface,
          FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy,
          d);
      end;
    end else begin
      img := 3740 + Dir16 * 5 + curframe;
      d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        Surface.Draw(FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy,
          d.ClientRect, d, True);
      end;

      img := 3820 + Dir16 * 5 + curframe;
      if d <> nil then begin
        DrawBlend(Surface,
          FlyX + px - UNITX div 2,
          FlyY + py - UNITY div 2,
          d);
      end;

      img := MagExplosionBase + Dir16 * 5 + curframe;
      d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        DrawBlend(Surface,
          FlyX + px - UNITX div 2,
          FlyY + py - UNITY div 2,
          d);
      end;

    end;
  end;
end;

{--------------------------------------------------------}

constructor TBujaukGroundEffect.Create(effbase, magicnumb, sx, sY, tx, ty: Integer);
begin
  inherited Create(111, effbase,
    sx, sY,
    tx, ty,
    mtBujaukGroundEffect,
    True,
    0);
  frame := 3;
  MagicNumber := magicnumb;
  BoGroundEffect := False;
  NextFrameTime := 50;
end;

function TBujaukGroundEffect.Run: Boolean;
begin
  Result := inherited Run;
  if not FixedEffect then begin
    if ((abs(targetx - FlyX) <= 15) and (abs(targety - FlyY) <= 15)) or
      ((abs(targetx - FlyX) >= prevdisx) and (abs(targety - FlyY) >= prevdisy)) then begin
      FixedEffect := True;
      start := 0;
      frame := ExplosionFrame;
      curframe := start;
      Repetition := False;
      PlaySound(TActor(MagOwner).m_nMagicExplosionSound);
      Result := True;
    end else begin
      prevdisx := abs(targetx - FlyX);
      prevdisy := abs(targety - FlyY);
    end;
  end;
end;

procedure TBujaukGroundEffect.DrawEff(Surface: TTexture);
var
  img: Integer;
  d: TTexture;
  shx, shy: Integer;
  meff: TMapEffect;
begin
  if not CanDraw then Exit;
  if m_boActive and ((abs(FlyX - fireX) > 30) or (abs(FlyY - fireY) > 30) or FixedEffect) then begin
    shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
    shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;

    if not FixedEffect then begin
      img := EffectBase + Dir16 * 10;
      d := ImgLib.GetCachedImage(img + curframe, px, py);
      if d <> nil then begin
        Surface.Draw(FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy,
          d.ClientRect, d, True);
      end;
    end else begin
      if MagicNumber = 11 then //¸¶
        img := EffectBase + 16 * 10 + curframe
      else //¹æ
        img := EffectBase + 18 * 10 + curframe;
      if MagicNumber = 46 then begin
        GetEffectBase(MagicNumber - 1, 0, ImgLib, img);
        img := img + 10 + curframe;
      end;
      d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        DrawBlend(Surface,
          FlyX + px - UNITX div 2, // - shx,
          FlyY + py - UNITY div 2, // - shy,
          d);
      end;
      {if not BoGroundEffect and (curframe = 8) then begin
         BoGroundEffect := TRUE;
         meff := TMapEffect.Create (img+2, 6, TargetRx, TargetRy);
         meff.NextFrameTime := 100;
         //meff.RepeatCount := 1;
         PlayScene.GroundEffectList.Add (meff);
      end; }
    end;
  end;
end;


{ TNormalDrawEffect }

constructor TNormalDrawEffect.Create(xx, yy: Integer; WMImage: TGameImages; effbase, nX: Integer; frmTime: LongWord; boFlag: Boolean);
begin
  inherited Create(111, effbase, xx, yy, xx, yy, mtReady, True, 0);
  ImgLib := WMImage;
  EffectBase := effbase;
  start := 0;
  curframe := 0;
  frame := nX;
  NextFrameTime := frmTime;
  boC8 := boFlag;
end;

procedure TNormalDrawEffect.DrawEff(Surface: TTexture);
var
  d: TTexture;
  nRx, nRy, nPx, nPy: Integer;
begin
  if not CanDraw then Exit;
  d := ImgLib.GetCachedImage(EffectBase + curframe, nPx, nPy);
  if d <> nil then begin
    PlayScene.ScreenXYfromMCXY(FlyX, FlyY, nRx, nRy);
    if boC8 then begin
      DrawBlend(Surface, nRx + nPx - UNITX div 2, nRy + nPy - UNITY div 2, d);
    end else begin
      Surface.Draw(nRx + nPx - UNITX div 2, nRy + nPy - UNITY div 2, d.ClientRect, d, True);
    end;
  end;
end;

function TNormalDrawEffect.Run: Boolean;
begin
  Result := True;
  if m_boActive and (GetTickCount - steptime > LongWord(NextFrameTime)) then begin
    steptime := GetTickCount;
    Inc(curframe);
    if curframe > start + frame - 1 then begin
      curframe := start;
      Result := False;
    end;
  end;
end;

{ TFlyingBug }

constructor TFlyingBug.Create(id, effnum, sx, sY, tx, ty: Integer;
  mtype: TMagicType; Recusion: Boolean; anitime: Integer);
begin
  inherited Create(id, effnum, sx, sY, tx, ty, mtype, Recusion, anitime);
  FlyImageBase := FLYOMAAXEBASE;
  ReadyFrame := 65;
end;

procedure TFlyingBug.DrawEff(Surface: TTexture);
var
  img: Integer;
  d: TTexture;
  shx, shy: Integer;
begin
  if not CanDraw then Exit;
  if m_boActive and ((abs(FlyX - fireX) > ReadyFrame) or (abs(FlyY - fireY) > ReadyFrame)) then begin
    shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
    shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;

    if not FixedEffect then begin
      img := FlyImageBase + (Dir16 div 2) * 10;
      d := ImgLib.GetCachedImage(img + curframe, px, py);
      if d <> nil then begin
        Surface.Draw(FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy,
          d.ClientRect, d, True);
      end;
    end else begin
      img := curframe + MagExplosionBase;
      d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        Surface.Draw(FlyX + px - UNITX div 2,
          FlyY + py - UNITY div 2,
          d.ClientRect, d, True);
      end;
    end;
  end;
end;

{ TFlyingFireBall }

procedure TFlyingFireBall.DrawEff(Surface: TTexture);
var
  d: TTexture;
begin
  if not CanDraw then Exit;
  if m_boActive and ((abs(FlyX - fireX) > ReadyFrame) or (abs(FlyY - fireY) > ReadyFrame)) then begin
    d := ImgLib.GetCachedImage(FlyImageBase + (GetFlyDirection(FlyX, FlyY, targetx, targety) * 10) + curframe, px, py);
    if d <> nil then
      DrawBlend(Surface,
        FlyX + px - UNITX div 2,
        FlyY + py - UNITY div 2,
        d);
  end;
end;

end.

