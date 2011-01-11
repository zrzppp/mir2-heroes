unit Actor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Grobal2, Textures,
  magiceff, GameImages, Share;

const
  MAXACTORSOUND = 3;
  CMMX = 150;
  CMMY = 200;

  HUMANFRAME = 600;
  MONFRAME = 280;
  EXPMONFRAME = 360;
  SCULMONFRAME = 440;
  ZOMBIFRAME = 430;
  MERCHANTFRAME = 60;
  MAXSAY = 5;
  //   MON1_FRAME =
  //   MON2_FRAME =

  RUN_MINHEALTH = 10;
  DEFSPELLFRAME = 10;
  FIREHIT_READYFRAME = 6;
  MAGBUBBLEBASE = 3890; //魔法盾效果图位置
  MAGBUBBLESTRUCKBASE = 3900; //被攻击时魔法盾效果图位置
  MAXWPEFFECTFRAME = 5;
  WPEFFECTBASE = 3750;
  EffectBase = 0;

type
  {
  TNameSurface = record
    Surface: TTexture;
    Color: Integer;
    Name: string;
  end;
  pTNameSurface = ^TNameSurface;
  }
  THealthStatus = record
    btStatus: Byte; //0=MISS 1=ADD 2=DEC
    nValue: Integer;
    //Text: TTexture;
    dwFrameTime: LongWord;
    nCurrentFrame: Integer;
  end;
  pTHealthStatus = ^THealthStatus;

  TActionInfo = packed record
    start: Word;
    frame: Word;
    skip: Word; //0x18
    ftime: Word; //0x1A
    usetick: Word; //0x1C
  end;
  pTActionInfo = ^TActionInfo;

  THumanAction = packed record
    ActStand: TActionInfo; //1
    ActWalk: TActionInfo; //8
    ActRun: TActionInfo; //8
    ActRushLeft: TActionInfo;
    ActRushRight: TActionInfo;
    ActWarMode: TActionInfo; //1
    ActHit: TActionInfo; //6
    ActHeavyHit: TActionInfo; //6
    ActBigHit: TActionInfo; //6
    ActFireHitReady: TActionInfo; //6
    ActSpell: TActionInfo; //6
    ActSitdown: TActionInfo; //1
    ActStruck: TActionInfo; //3
    ActDie: TActionInfo; //4
    ActSerieHit: array[0..18 - 1] of TActionInfo;
  end;
  pTHumanAction = ^THumanAction;



  TMonsterAction = packed record
    ActStand: TActionInfo; //1
    ActWalk: TActionInfo; //8
    ActAttack: TActionInfo; //6 0x14 - 0x1C
    ActCritical: TActionInfo; //6 0x20 -
    ActStruck: TActionInfo; //3
    ActDie: TActionInfo; //4
    ActDeath: TActionInfo;
  end;
  pTMonsterAction = ^TMonsterAction;
var
  HA: THumanAction = (
    ActStand: (start: 0; frame: 4; skip: 4; ftime: 200; usetick: 0);
    ActWalk: (start: 64; frame: 6; skip: 2; ftime: 90; usetick: 2);
    ActRun: (start: 128; frame: 6; skip: 2; ftime: 120; usetick: 3);
    ActRushLeft: (start: 128; frame: 3; skip: 5; ftime: 120; usetick: 3);
    ActRushRight: (start: 131; frame: 3; skip: 5; ftime: 120; usetick: 3);
    ActWarMode: (start: 192; frame: 1; skip: 0; ftime: 200; usetick: 0);
    //ActHit:    (start: 200;    frame: 5;  skip: 3;  ftime: 140;  usetick: 0);
    ActHit: (start: 200; frame: 6; skip: 2; ftime: 85; usetick: 0);
    ActHeavyHit: (start: 264; frame: 6; skip: 2; ftime: 90; usetick: 0);
    ActBigHit: (start: 328; frame: 8; skip: 0; ftime: 70; usetick: 0);
    ActFireHitReady: (start: 192; frame: 6; skip: 4; ftime: 70; usetick: 0);
    ActSpell: (start: 392; frame: 6; skip: 2; ftime: 60; usetick: 0);
    ActSitdown: (start: 456; frame: 2; skip: 0; ftime: 300; usetick: 0);
    ActStruck: (start: 472; frame: 3; skip: 5; ftime: 70; usetick: 0);
    ActDie: (start: 536; frame: 4; skip: 4; ftime: 120; usetick: 0);

    ActSerieHit:
    (
    (start: 0; frame: 6; skip: 4; ftime: 60; usetick: 0), //0
    (start: 80; frame: 8; skip: 2; ftime: 60; usetick: 0), //1
    (start: 160; frame: 15; skip: 5; ftime: 60; usetick: 0), //2
    (start: 320; frame: 6; skip: 4; ftime: 60; usetick: 0), //3
    (start: 400; frame: 13; skip: 7; ftime: 60; usetick: 0), //4
    (start: 560; frame: 10; skip: 0; ftime: 60; usetick: 0), //5
    (start: 640; frame: 6; skip: 4; ftime: 60; usetick: 0), //6
    (start: 720; frame: 6; skip: 4; ftime: 60; usetick: 0), //7
    (start: 800; frame: 8; skip: 2; ftime: 60; usetick: 0), //8
    (start: 880; frame: 10; skip: 0; ftime: 60; usetick: 0), //9
    (start: 960; frame: 10; skip: 0; ftime: 60; usetick: 0), //10
    (start: 1040; frame: 13; skip: 7; ftime: 60; usetick: 0), //11
    (start: 1200; frame: 6; skip: 4; ftime: 60; usetick: 0), //12
    (start: 1280; frame: 6; skip: 4; ftime: 60; usetick: 0), //13
    (start: 1360; frame: 9; skip: 1; ftime: 60; usetick: 0), //14
    (start: 1440; frame: 12; skip: 8; ftime: 60; usetick: 0), //15
    (start: 1600; frame: 12; skip: 8; ftime: 60; usetick: 0), //16
    (start: 1760; frame: 14; skip: 6; ftime: 60; usetick: 0) //17
    )
    );
  MA9: TMonsterAction = (//4C03D4
    ActStand: (start: 0; frame: 1; skip: 7; ftime: 200; usetick: 0);
    ActWalk: (start: 64; frame: 6; skip: 2; ftime: 120; usetick: 3);
    ActAttack: (start: 64; frame: 6; skip: 2; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 64; frame: 6; skip: 2; ftime: 100; usetick: 0);
    ActDie: (start: 0; frame: 1; skip: 7; ftime: 140; usetick: 0);
    ActDeath: (start: 0; frame: 1; skip: 7; ftime: 0; usetick: 0);
    );
  MA10: TMonsterAction = (//(8Frame) 带刀卫士
    ActStand: (start: 0; frame: 4; skip: 4; ftime: 200; usetick: 0);
    ActWalk: (start: 64; frame: 6; skip: 2; ftime: 120; usetick: 3);
    ActAttack: (start: 128; frame: 4; skip: 4; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 192; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 208; frame: 4; skip: 4; ftime: 140; usetick: 0);
    ActDeath: (start: 272; frame: 1; skip: 0; ftime: 0; usetick: 0);
    );
  MA11: TMonsterAction = (//荤娇(10Frame楼府)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 120; usetick: 3);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 0; usetick: 0);
    );
  MA12: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 4; ftime: 200; usetick: 0);
    ActWalk: (start: 64; frame: 6; skip: 2; ftime: 120; usetick: 3);
    ActAttack: (start: 128; frame: 6; skip: 2; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 192; frame: 2; skip: 0; ftime: 150; usetick: 0);
    ActDie: (start: 208; frame: 4; skip: 4; ftime: 160; usetick: 0);
    ActDeath: (start: 272; frame: 1; skip: 0; ftime: 0; usetick: 0);
    );
  MA13: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 10; frame: 8; skip: 2; ftime: 160; usetick: 0);
    ActAttack: (start: 30; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 110; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 130; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 20; frame: 9; skip: 0; ftime: 150; usetick: 0);
    );
  MA14: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 340; frame: 10; skip: 0; ftime: 100; usetick: 0);
    );
  MA15: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 1; frame: 1; skip: 0; ftime: 100; usetick: 0);
    );
  MA16: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 160; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 4; skip: 6; ftime: 160; usetick: 0);
    ActDeath: (start: 0; frame: 1; skip: 0; ftime: 160; usetick: 0);
    );
  MA17: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 60; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 100; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    );
  MA19: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    );

  MA20: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 100; usetick: 0);
    ActDeath: (start: 340; frame: 10; skip: 0; ftime: 170; usetick: 0);
    );
  MA21: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0); //
    ActAttack: (start: 10; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 20; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 30; frame: 10; skip: 0; ftime: 160; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0); //
    );
  MA22: TMonsterAction = (
    ActStand: (start: 80; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 160; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 240; frame: 6; skip: 4; ftime: 100; usetick: 0); //
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 320; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 340; frame: 10; skip: 0; ftime: 160; usetick: 0);
    ActDeath: (start: 0; frame: 6; skip: 4; ftime: 170; usetick: 0);
    );
  MA23: TMonsterAction = (
    ActStand: (start: 20; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 100; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 180; frame: 6; skip: 4; ftime: 100; usetick: 0); //
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 260; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 280; frame: 10; skip: 0; ftime: 160; usetick: 0);
    ActDeath: (start: 0; frame: 20; skip: 0; ftime: 100; usetick: 0);
    );
  MA24: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 240; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 320; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 340; frame: 10; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 420; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    );

  {
MA25: TMonsterAction = (  //瘤匙空
    ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
    ActWalk:   (start: 70;     frame: 10; skip: 0;  ftime: 200;  usetick: 3); //殿厘
    ActAttack: (start: 20;     frame: 6;  skip: 4;  ftime: 120;  usetick: 0); //流立傍拜
    ActCritical:(start: 10;    frame: 6;  skip: 4;  ftime: 120;  usetick: 0); //刀魔傍拜(盔芭府)
    ActStruck: (start: 50;     frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
    ActDie:    (start: 60;     frame: 10; skip: 0;  ftime: 200;  usetick: 0);
    ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 140;  usetick: 0); //
  );
  }
  MA25: TMonsterAction = (//4C080C
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 70; frame: 10; skip: 0; ftime: 200; usetick: 3);
    ActAttack: (start: 20; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 10; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 50; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 60; frame: 10; skip: 0; ftime: 200; usetick: 0);
    ActDeath: (start: 80; frame: 10; skip: 0; ftime: 200; usetick: 3);
    );

  MA26: TMonsterAction = (//己巩,
    ActStand: (start: 0; frame: 1; skip: 7; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 160; usetick: 0); //殿厘...
    ActAttack: (start: 56; frame: 6; skip: 2; ftime: 500; usetick: 0); //凯扁
    ActCritical: (start: 64; frame: 6; skip: 2; ftime: 500; usetick: 0); //摧扁
    ActStruck: (start: 0; frame: 4; skip: 4; ftime: 100; usetick: 0);
    ActDie: (start: 24; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 150; usetick: 0); //见澜..
    );
  MA27: TMonsterAction = (//己寒
    ActStand: (start: 0; frame: 1; skip: 7; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 160; usetick: 0); //殿厘...
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 250; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 250; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 0; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 150; usetick: 0); //见澜..
    );
  MA28: TMonsterAction = (//脚荐 (函脚 傈)
    ActStand: (start: 80; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 160; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 0; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 0; frame: 10; skip: 0; ftime: 100; usetick: 0); //殿厘..
    );
  MA29: TMonsterAction = (//脚荐 (函脚 饶)
    ActStand: (start: 80; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 160; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 240; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 10; skip: 0; ftime: 100; usetick: 0);
    ActStruck: (start: 320; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 340; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 0; frame: 10; skip: 0; ftime: 100; usetick: 0); //殿厘..
    );
  MA30: TMonsterAction = (//4C0974
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 10; skip: 0; ftime: 200; usetick: 3);
    ActAttack: (start: 10; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 10; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 20; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 30; frame: 20; skip: 0; ftime: 150; usetick: 0);
    ActDeath: (start: 0; frame: 10; skip: 0; ftime: 200; usetick: 3);
    );
  MA31: TMonsterAction = (//4C09BC
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 10; skip: 0; ftime: 200; usetick: 3);
    ActAttack: (start: 10; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 0; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 0; frame: 2; skip: 8; ftime: 100; usetick: 0);
    ActDie: (start: 20; frame: 10; skip: 0; ftime: 200; usetick: 0);
    ActDeath: (start: 0; frame: 10; skip: 0; ftime: 200; usetick: 3);
    );

  MA32: TMonsterAction = (//4C0A04
    ActStand: (start: 0; frame: 1; skip: 9; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 6; skip: 4; ftime: 200; usetick: 3);
    ActAttack: (start: 0; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 0; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 0; frame: 2; skip: 8; ftime: 100; usetick: 0);
    ActDie: (start: 80; frame: 10; skip: 0; ftime: 80; usetick: 0);
    ActDeath: (start: 80; frame: 10; skip: 0; ftime: 200; usetick: 3);
    );

  MA33: TMonsterAction = (//4C0A4C
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 200; usetick: 3);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 200; usetick: 0);
    ActDeath: (start: 260; frame: 10; skip: 0; ftime: 200; usetick: 0);
    );

  MA34: TMonsterAction = (//4C0A94
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 200; usetick: 3);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 320; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 400; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 420; frame: 20; skip: 0; ftime: 200; usetick: 0);
    ActDeath: (start: 420; frame: 20; skip: 0; ftime: 200; usetick: 0);
    );

  MA35: TMonsterAction = (//4C0ADC
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 30; frame: 10; skip: 0; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 1; skip: 9; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA36: TMonsterAction = (//4C0B24
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 30; frame: 20; skip: 0; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 1; skip: 9; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA37: TMonsterAction = (//4C0B6C
    ActStand: (start: 30; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 30; frame: 4; skip: 6; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 1; skip: 9; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA38: TMonsterAction = (//4C0BB4
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 80; frame: 6; skip: 4; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA39: TMonsterAction = (//4C0BFC
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 300; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 10; frame: 6; skip: 4; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 20; frame: 2; skip: 0; ftime: 150; usetick: 0);
    ActDie: (start: 30; frame: 10; skip: 0; ftime: 80; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA40: TMonsterAction = (//4C0C44
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 250; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 210; usetick: 3);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 110; usetick: 0);
    ActCritical: (start: 580; frame: 20; skip: 0; ftime: 135; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 120; usetick: 0);
    ActDie: (start: 260; frame: 20; skip: 0; ftime: 130; usetick: 0);
    ActDeath: (start: 260; frame: 20; skip: 0; ftime: 130; usetick: 0);
    );

  MA41: TMonsterAction = (//4C0C8C
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA42: TMonsterAction = (//4C0CD4
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 10; frame: 8; skip: 2; ftime: 160; usetick: 0);
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 30; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 30; frame: 10; skip: 0; ftime: 150; usetick: 0);
    );

  MA43: TMonsterAction = (//4C0D1C
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 0);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 160; usetick: 0);
    ActCritical: (start: 160; frame: 6; skip: 4; ftime: 160; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 150; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 340; frame: 10; skip: 0; ftime: 100; usetick: 0);
    );

  MA44: TMonsterAction = (//4C0D64
    ActStand: (start: 0; frame: 10; skip: 0; ftime: 300; usetick: 0);
    ActWalk: (start: 10; frame: 6; skip: 4; ftime: 150; usetick: 0);
    ActAttack: (start: 20; frame: 6; skip: 4; ftime: 150; usetick: 0);
    ActCritical: (start: 40; frame: 10; skip: 0; ftime: 150; usetick: 0);
    ActStruck: (start: 40; frame: 2; skip: 8; ftime: 150; usetick: 0);
    ActDie: (start: 30; frame: 6; skip: 4; ftime: 150; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA45: TMonsterAction = (//4C0DAC
    ActStand: (start: 0; frame: 10; skip: 0; ftime: 300; usetick: 0);
    ActWalk: (start: 0; frame: 10; skip: 0; ftime: 300; usetick: 0);
    ActAttack: (start: 10; frame: 10; skip: 0; ftime: 300; usetick: 0);
    ActCritical: (start: 10; frame: 10; skip: 0; ftime: 100; usetick: 0);
    ActStruck: (start: 0; frame: 1; skip: 9; ftime: 300; usetick: 0);
    ActDie: (start: 0; frame: 1; skip: 9; ftime: 300; usetick: 0);
    ActDeath: (start: 0; frame: 1; skip: 9; ftime: 300; usetick: 0);
    );

  MA46: TMonsterAction = (//4C0DF4
    ActStand: (start: 0; frame: 20; skip: 0; ftime: 100; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );
  MA47: TMonsterAction = (//4C0A4C 嗜血教主
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 200; usetick: 3);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 260; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 524; frame: 6; skip: 0; ftime: 200; usetick: 0);
    ActDeath: (start: 524; frame: 6; skip: 0; ftime: 200; usetick: 0);
    );

  MA48: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 50; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 30; frame: 4; skip: 6; ftime: 50; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 1; skip: 9; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA49: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 250; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 10; frame: 10; skip: 0; ftime: 250; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA50: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 0; ftime: 250; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 5; frame: 7; skip: 11; ftime: 250; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA51: TMonsterAction = (//Mon23 第2 3 个怪
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 420; frame: 6; skip: 4; ftime: 140; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    );

  MA52: TMonsterAction = (//Mon23 第4 个怪
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0); //
    );

  MA53: TMonsterAction = (//Mon27
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0); //
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActDie: (start: 80; frame: 10; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 80; frame: 10; skip: 0; ftime: 140; usetick: 0); //
    );

  MA54: TMonsterAction = (//Mon27
    ActStand: (start: 0; frame: 2; skip: 8; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0); //
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 10; frame: 2; skip: 0; ftime: 200; usetick: 0);
    ActDie: (start: 20; frame: 8; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 20; frame: 8; skip: 0; ftime: 140; usetick: 0); //
    );

  MA101: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 260; frame: 10; skip: 0; ftime: 140; usetick: 0); //
    );

  MA102: TMonsterAction = (
    ActStand: (start: 0; frame: 10; skip: 0; ftime: 100; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 0; frame: 10; skip: 0; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 10; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA103: TMonsterAction = (
    ActStand: (start: 0; frame: 1; skip: 0; ftime: 100; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 0; frame: 1; skip: 0; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 1; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA104: TMonsterAction = (
    ActStand: (start: 0; frame: 20; skip: 0; ftime: 100; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 0; frame: 20; skip: 0; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 20; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA105: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 1; skip: 9; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  WORDER: array[0..1, 0..599] of Byte = (//1: 漠捞 菊栏肺,  0: 漠捞 第肺
    (//巢磊
    //沥瘤
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1,
    0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1,
    //叭扁
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1,
    //顿扁
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1,
    0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1,
    //war葛靛
    0, 1, 1, 1, 0, 0, 0, 0,
    //傍拜
    1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1,
    //傍拜 2
    0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
    1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1,
    //傍拜3
    1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0,
    1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0,
    //付过
    0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1,
    1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1,
    //澵扁
    0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0,
    //嘎扁
    0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
    0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
    //静矾咙
    0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
    0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1
    ),

    (
    //沥瘤
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1,
    0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1,
    //叭扁
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1,
    //顿扁
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1,
    0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1,
    //war葛靛
    1, 1, 1, 1, 0, 0, 0, 0,
    //傍拜
    1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1,
    //傍拜 2
    0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
    1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1,
    //傍拜3
    1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0,
    1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0,
    //付过
    0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1,
    1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1,
    //澵扁
    0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0,
    //嘎扁
    0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
    0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
    //静矾咙
    0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
    0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1
    )
    );

  EffDir: array[0..7] of Byte = (0, 0, 1, 1, 1, 1, 1, 0);


type
  TActor = class //Size 0x240
    m_nRecogId: Integer; //角色标识 0x4
    m_nCurrX: Integer; //当前所在地图座标X 0x08
    m_nCurrY: Integer; //当前所在地图座标Y 0x0A
    m_btDir: Byte; //当前站立方向 0x0C
    m_btSex: Byte; //性别 0x0D
    m_btRace: Byte; //0x0E
    m_btHair: Byte; //头发类型 0x0F
    m_btDress: Byte; //衣服类型 0x10
    m_btWeapon: Byte; //武器类型
    m_btHorse: Byte; //马类型
    m_btEffect: Byte; //天使类型
    m_btWeaponEffect: Byte; //武器效果
    m_btJob: Byte; //职业 0:武士  1:法师  2:道士
    m_wAppearance: Word; //0x14
    m_btDeathState: Byte;
    m_nFeature: Integer; //0x18
    m_nFeatureEx: Integer; //0x18
    m_nState: Integer; //0x1C
    m_boDeath: Boolean; //0x20
    m_boSkeleton: Boolean; //0x21
    m_boDelActor: Boolean; //0x22
    m_boDelActionAfterFinished: Boolean; //0x23
    m_sDescUserName: string; //人物名称，后缀
    m_sUserName: string; //0x28
    m_nNameColor: Integer; //0x2C
    m_Abil: TAbility; //0x30
    m_nGold: Integer; //金币数量0x58
    m_nGameGold: Integer; //游戏币数量
    m_nGamePoint: Integer; //游戏点数量
    m_nHitSpeed: shortint; //攻击速度 0: 扁夯, (-)蠢覆 (+)狐抚
    m_boVisible: Boolean; //0x5D
    m_boHoldPlace: Boolean; //0x5E

    m_SayingArr: array[0..MAXSAY - 1] of string;
    m_SayWidthsArr: array[0..MAXSAY - 1] of Integer;


    m_dwSayTime: LongWord;
    m_nSayX: Integer;
    m_nSayY: Integer;
    m_nSayLineCount: Integer;


    m_nShiftX: Integer; //0x98
    m_nShiftY: Integer; //0x9C

    m_nPx: Integer; //0xA0
    m_nHpx: Integer; //0xA4
    m_nWpx: Integer; //0xA8
    m_nSpx: Integer; //0xAC

    m_nPy: Integer;
    m_nHpy: Integer;
    m_nWpy: Integer;
    m_nSpy: Integer; //0xB0 0xB4 0xB8 0xBC

    m_nRx: Integer;
    m_nRy: Integer; //0xC0 0xC4

    m_nWGpx: Integer;
    m_nWGpy: Integer;


    m_nStoreX: Integer;
    m_nStoreY: Integer;

    m_nDownDrawLevel: Integer; //0xC8
    m_nTargetX: Integer;
    m_nTargetY: Integer; //0xCC 0xD0
    m_nTargetRecog: Integer; //0xD4
    m_nHiterCode: Integer; //0xD8
    m_nMagicNum: Integer; //0xDC
    m_nCurrentEvent: Integer;
    m_boDigFragment: Boolean;
    m_boThrow: Boolean;

    m_nBodyOffset: Integer; //0x0E8   //0x0D0
    m_nHairOffset: Integer; //0x0EC
    m_nHumWinOffset: Integer; //0x0F0
    m_nWeaponOffset: Integer; //0x0F4
    m_boUseMagic: Boolean; //0x0F8   //0xE0
    m_boHitEffect: Boolean; //0x0F9    //0xE1

    m_boUseEffect: Boolean; //0x0FA    //0xE2
    m_nHitEffectNumber: Integer; //0xE4
    m_dwWaitMagicRequest: LongWord;
    m_nWaitForRecogId: Integer;
    m_nWaitForFeature: Integer;
    m_nWaitForStatus: Integer;


    m_nCurEffFrame: Integer; //0x110
    m_nSpellFrame: Integer; //0x114
    m_nSpellFrameSkip: Integer;
    m_CurMagic: TUseMagicInfo; //0x118  //m_CurMagic.EffectNumber 0x110
    m_CurMagicList: TGList;
    //GlimmingMode: Boolean;
    //CurGlimmer: integer;
    //MaxGlimmer: integer;
    //GlimmerTime: longword;
    m_nGenAniCount: Integer; //0x124
    m_boOpenHealth: Boolean; //0x140
    m_noInstanceOpenHealth: Boolean; //0x141
    m_dwOpenHealthStart: LongWord;
    m_dwOpenHealthTime: LongWord; //Integer;jacky

    m_BodySurface: TTexture; //0x14C   //0x134
    m_WeaponGlimmerSurface: TTexture;



    m_boGrouped: Boolean; //0x150 是否组队
    m_nCurrentAction: Integer; //0x154         //0x13C
    m_boReverseFrame: Boolean; //0x158
    m_boWarMode: Boolean; //0x159
    m_dwWarModeTime: LongWord; //0x15C
    m_nChrLight: Integer; //0x160
    m_nMagLight: Integer; //0x164
    m_nRushDir: Integer; //0, 1  //0x168
    m_nXxI: Integer; //0x16C
    m_boLockEndFrame: Boolean; //0x170
    m_dwLastStruckTime: LongWord; //0x174
    m_dwSendQueryUserNameTime: LongWord; //0x178
    m_dwDeleteTime: LongWord; //0x17C

    m_nMagicStruckSound: Integer; //0x180 被魔法攻击弯腰发出的声音
    m_boRunSound: Boolean; //0x184 跑步发出的声音
    m_nFootStepSound: Integer; //CM_WALK, CM_RUN //0x188  走步声
    m_nStruckSound: Integer; //SM_STRUCK         //0x18C  弯腰声音
    m_nStruckWeaponSound: Integer; //0x190  被指定武器攻击弯腰声音

    m_nAppearSound: Integer;
    m_nNormalSound: Integer;
    m_nAttackSound: Integer;
    m_nWeaponSound: Integer;
    m_nScreamSound: Integer;
    m_nDieSound: Integer;
    m_nDie2Sound: Integer;

    m_dwLoadSurfaceTime: LongWord; //0x210  //0x200
    m_dwLoadSurfaceTick: LongWord;


    m_nMagicStartSound: Integer; //0x1B0
    m_nMagicFireSound: Integer; //0x1B4
    m_nMagicExplosionSound: Integer; //0x1B8
    m_Action: pTMonsterAction;
    m_HealthList: TGList;

//护体神盾
    m_nStateStartFrame: Integer;
    m_nStateEndFrame: Integer;
    m_dwStateFrameTime: LongWord;
    m_btState: Byte;
    m_boSuperShield: Boolean;
    m_boCreateMagic: Boolean;
//摆摊
    m_StoreSurface: TTexture; //摊位
    m_boStartStore: Boolean;

    m_nIndex: Integer;
    m_nMoveStepCount: Integer;
    m_dwMoveTime: LongWord;

  private
    function GetMessage(ChrMsg: pTChrMsg): Boolean;
  protected
    m_nStartFrame: Integer; //0x1BC        //0x1A8
    m_nEndFrame: Integer; //0x1C0      //0x1AC
    m_nCurrentFrame: Integer; //0x1C4          //0x1B0

    m_nStartFrame1: Integer; //0x1BC        //0x1A8
    m_nEndFrame1: Integer; //0x1C0      //0x1AC
    m_nCurrentFrame1: Integer; //0x1C4          //0x1B0


    m_nEffectStart: Integer; //0x1C8         //0x1B4
    m_nEffectFrame: Integer; //0x1CC         //0x1B8
    m_nEffectEnd: Integer; //0x1D0       //0x1BC
    m_dwEffectStartTime: LongWord; //0x1D4             //0x1C0
    m_dwEffectFrameTime: LongWord; //0x1D8             //0x1C4
    m_dwFrameTime: LongWord; //0x1DC       //0x1C8
    m_dwStartTime: LongWord; //0x1E0       //0x1CC
    m_dwStartTime1: LongWord; //0x1E0

    m_nMaxTick: Integer; //0x1E4
    m_nCurTick: Integer; //0x1E8
    m_nMoveStep: Integer; //0x1EC
    m_boMsgMuch: Boolean; //0x1F0
    m_dwStruckFrameTime: LongWord; //0x1F4
    m_nCurrentDefFrame: Integer; //0x1F8          //0x1E4
    m_dwDefFrameTime: LongWord; //0x1FC       //0x1E8
    m_nDefFrameCount: Integer; //0x200        //0x1EC
    m_nSkipTick: Integer; //0x204
    m_dwSmoothMoveTime: LongWord; //0x208
    m_dwGenAnicountTime: LongWord; //0x20C

    m_nOldx: Integer;
    m_nOldy: Integer;
    m_nOldDir: Integer; //0x214 0x218 0x21C
    m_nActBeforeX: Integer;
    m_nActBeforeY: Integer; //0x220 0x224
    m_nWpord: Integer; //0x228       virtual;




    m_boHitEndEffect: Boolean;
    m_nHitEndX: Integer;
    m_nHitEndY: Integer;
    m_nHitEndDX: Integer;
    m_nHitEndDY: Integer;
    m_nStartPosHitFrame: Integer;
    m_nStartHitFrame: Integer; //0x1BC        //0x1A8
    m_nEndHitFrame: Integer; //0x1C0      //0x1AC
    m_nCurrentHitFrame: Integer;
    m_dwStartHitTime: longword;
    m_btHitDir: Byte;

    m_dwHitFrameTick: longword;
    m_dwHitFrameTime: longword;

    procedure CalcActorFrame; dynamic;
    procedure DefaultMotion; dynamic;
    function GetDefaultFrame(wmode: Boolean): Integer; dynamic;
    procedure DrawEffSurface(dsurface, source: TTexture; ddx, ddy: Integer; blend: Boolean; ceff: TColorEffect);
    procedure DrawWeaponGlimmer(dsurface: TTexture; ddx, ddy: Integer);
  public
    m_MsgList: TGList; //list of PTChrMsg 0x22C  //0x21C
    RealActionMsg: TChrMsg; //FrmMain    0x230

    constructor Create; dynamic;
    destructor Destroy; override;
    procedure SendMsg(wIdent: Word; nX, nY, ndir, nFeature, nState: Integer; sStr: string; nSound: Integer);
    procedure UpdateMsg(wIdent: Word; nX, nY, ndir, nFeature, nState: Integer; sStr: string; nSound: Integer);
    procedure SendUpdateMsg(wIdent: Word; nX, nY, ndir, nFeature, nState: Integer; sStr: string; nSound: Integer);
    procedure CleanUserMsgs;
    procedure ProcMsg;
    procedure ProcHurryMsg;
    function IsIdle: Boolean;
    function ActionFinished: Boolean;
    function CanWalk: Integer;
    function CanRun: Integer;
    function Strucked: Boolean;
    procedure Shift(dir, step, cur, Max: Integer);
    procedure ReadyAction(Msg: TChrMsg);
    function CharWidth: Integer;
    function CharHeight: Integer;
    function CheckSelect(dx, dy: Integer): Boolean;
    procedure CleanCharMapSetting(X, Y: Integer);
    procedure Say(Str: string);
    procedure SetSound; dynamic;
    procedure Run; dynamic;
    procedure RunSound; dynamic;
    procedure RunActSound(frame: Integer); dynamic;
    procedure RunFrameAction(frame: Integer); dynamic;
    procedure ActionEnded; dynamic;
    function CanMove: Boolean;
    function Move(step: Integer): Boolean;
    procedure MoveFail;
    function CanCancelAction: Boolean;
    procedure CancelAction;
    procedure FeatureChanged; dynamic;
    function light: Integer; dynamic;
    procedure LoadSurface; dynamic;
    procedure UnLoadSurface; dynamic;
    function GetDrawEffectValue: TColorEffect;
    procedure FreeNameSurface;
    procedure NameTextOut(dsurface: TTexture; sName: string; X, Y: Integer; FColor: TColor = clWhite; BColor: TColor = $00050505);
    procedure DrawChr(dsurface: TTexture; dx, dy: Integer; blend: Boolean; boFlag: Boolean); dynamic;
    procedure DrawEff(dsurface: TTexture; dx, dy: Integer); dynamic;
    procedure ShowHealthStatus(MSurface: TTexture);
    procedure AddHealthStatus(btStatus: Byte; nValue: Integer);
    procedure ShowActorLable(MSurface: TTexture);
    procedure ShowSayMsg(MSurface: TTexture);
  end;

  TNpcActor = class(TActor)
  private
    m_nEffX: Integer; //0x240
    m_nEffY: Integer; //0x244
    m_bo248: Boolean; //0x248
    m_dwUseEffectTick: LongWord; //0x24C
    m_EffSurface: TTexture; //0x250
  public
    constructor Create; override;
    procedure Run; override;
    procedure CalcActorFrame; override;
    function GetDefaultFrame(wmode: Boolean): Integer; override;
    procedure LoadSurface; override;
    procedure UnLoadSurface; override;
    procedure DrawChr(dsurface: TTexture; dx, dy: Integer; blend: Boolean; boFlag: Boolean); override;
    procedure DrawEff(dsurface: TTexture; dx, dy: Integer); override;
  end;

  THumActor = class(TActor) //Size: 0x27C Address: 0x00475BB8
    m_nBagCount: Integer;
    m_nAngryValue: Integer; //愤怒值
    m_nMaxAngryValue: Integer; //最大愤怒值
    m_btCastle: Byte; //沙成员 1=行会掌门
  private
    m_HairSurface: TTexture;
    m_WeaponSurface: TTexture;
    m_HumWinSurface: TTexture;
    m_WeaponEffectSurface: TTexture;

    m_HumHoserSurface: TTexture;
    m_HoserSurface: TTexture;
    m_HairHoserSurface: TTexture;

    m_boWeaponEffect: Boolean; //0x25C  //0x24C
    m_nCurWeaponEffect: Integer; //0x260  //0x250
    m_nCurBubbleStruck: Integer; //0x264  //0x254
    m_dwWeaponpEffectTime: LongWord; //0x268
    m_boHideWeapon: Boolean; //0x26C
    m_nFrame: Integer;
    m_dwFrameTick: LongWord;
    m_dwFrameTime: LongWord;
    m_dwFrameTick1: LongWord;
    m_dwFrameTime1: LongWord;
    m_dwHitFrameTimeTime: LongWord;
    m_bo2D0: Boolean;
  protected
    procedure CalcActorFrame; override;
    procedure DefaultMotion; override;
    function GetDefaultFrame(wmode: Boolean): Integer; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Run; override;
    procedure RunFrameAction(frame: Integer); override;
    procedure ShowActorCastleLable(MSurface: TTexture);
    function light: Integer; override;
    procedure LoadSurface; override;
    procedure UnLoadSurface; override;
    procedure DoWeaponBreakEffect;
    procedure DrawChr(dsurface: TTexture; dx, dy: Integer; blend: Boolean; boFlag: Boolean); override;

    function GetGroupMagicId: Integer;
    function FindGroupMagic: pTClientMagic;
    procedure Rest;
    procedure Target;
    procedure Protect;
    procedure GroupAttack;
  end;

function GetRaceByPM(race: Integer; Appr: Word): pTMonsterAction;
function GetOffset(Appr: Integer): Integer;
function GetNpcOffset(nAppr: Integer): Integer;

implementation

uses
  ClMain, HUtil32, SoundUtil, clEvent, ClFunc, MShare, PlugIn;

function GetRaceByPM(race: Integer; Appr: Word): pTMonsterAction;
begin
  Result := nil;
  case race of //RaceImg
    9 {01}: Result := @MA9; //475D70
    10 {02}: Result := @MA10; //475D7C
    11 {03}: Result := @MA11; //475D88
    12 {04}: Result := @MA12; //475D94
    13 {05}: Result := @MA14; //475DA0
    14 {06}: Result := @MA14; //475DAC
    15 {07}: Result := @MA15; //475DB8
    16 {08}: Result := @MA16; //475DC4
    17 {06}: Result := @MA14; //475DAC
    18 {06}: Result := @MA14; //475DAC
    19 {0A}: Result := @MA19; //475DDC
    20 {0A}: Result := @MA19; //475DDC
    21 {0A}: Result := @MA19; //475DDC
    22 {07}: Result := @MA15; //475DB8
    23 {06}: Result := @MA14; //475DAC
    24 {04}: Result := @MA12; //475D94
    30 {09}: Result := @MA17; //475DD0
    31 {09}: Result := @MA17; //475DD0
    32 {0F}: Result := @MA24; //475E18
    33 {10}: Result := @MA25; //475E24
    34 {11}: Result := @MA30; //475E30  赤月恶魔
    35 {12}: Result := @MA31; //475E3C
    36 {13}: Result := @MA32; //475E48
    37 {0A}: Result := @MA19; //475DDC
    40 {0A}: Result := @MA19; //475DDC
    41 {0B}: Result := @MA20; //475DE8
    42 {0B}: Result := @MA20; //475DE8
    43 {0C}: Result := @MA21; //475DF4
    45 {0A}: Result := @MA19; //475DDC
    47 {0D}: Result := @MA22; //475E00
    48 {0E}: Result := @MA23; //475E0C
    49 {0E}: Result := @MA23; //475E0C
    50 {27}: begin //475F32
        case Appr of
          23 {01}: Result := @MA36; //475F77
          24 {02}: Result := @MA37; //475F80
          25 {02}: Result := @MA37; //475F80
          26 {00}: Result := @MA35; //475F9B
          27 {02}: Result := @MA37; //475F80
          28 {00}: Result := @MA35; //475F9B
          29 {00}: Result := @MA35; //475F9B
          30 {00}: Result := @MA35; //475F9B
          31 {00}: Result := @MA35; //475F9B
          32 {02}: Result := @MA37; //475F80
          33 {00}: Result := @MA35; //475F9B
          34 {00}: Result := @MA35; //475F9B
          35 {03}: Result := @MA41; //475F89
          36 {03}: Result := @MA41; //475F89
          37 {03}: Result := @MA41; //475F89
          38 {03}: Result := @MA41; //475F89
          39 {03}: Result := @MA41; //475F89
          40 {03}: Result := @MA41; //475F89
          41 {03}: Result := @MA41; //475F89
          42 {04}: Result := @MA46; //475F92
          43 {04}: Result := @MA46; //475F92
          44 {04}: Result := @MA46; //475F92
          45 {04}: Result := @MA46; //475F92
          46 {04}: Result := @MA46; //475F92
          47 {04}: Result := @MA46; //475F92
          48 {03}: Result := @MA41; //4777B3
          49 {03}: Result := @MA41; //4777B3
          50 {03}: Result := @MA41; //4777B3
          51 {00}: Result := @MA35; //4777C5
          52 {03}: Result := @MA41; //4777B3
          53..70 {03}: Result := @MA48; //4777B3
          71..72: Result := @MA35;
          73..75: Result := @MA49;
          76: Result := @MA50;
          77..79: Result := @MA35;
          80..84: Result := @MA102;
          85..86: Result := @MA103;
          87: Result := @MA104;
          88: Result := @MA105;
        else Result := @MA35;
        end;
      end;
    52 {0A}: Result := @MA19; //475DDC
    53 {0A}: Result := @MA19; //475DDC
    54 {14}: Result := @MA28; //475E54
    55 {15}: Result := @MA29; //475E60
    60 {16}: Result := @MA33; //475E6C
    61 {16}: Result := @MA33; //475E6C
    62 {16}: Result := @MA33; //475E6C
    63 {17}: Result := @MA34; //475E78
    64 {18}: Result := @MA19; //475E84
    65 {18}: Result := @MA19; //475E84
    66 {18}: Result := @MA19; //475E84
    67 {18}: Result := @MA19; //475E84
    68 {18}: Result := @MA19; //475E84
    69 {18}: Result := @MA19; //475E84
    70 {19}: Result := @MA33; //475E90
    71 {19}: Result := @MA33; //475E90
    72 {19}: Result := @MA33; //475E90
    73 {1A}: Result := @MA19; //475E9C
    74 {1B}: Result := @MA19; //475EA8
    75 {1C}: Result := @MA39; //475EB4
    76 {1D}: Result := @MA38; //475EC0
    77 {1E}: Result := @MA39; //475ECC
    78 {1F}: Result := @MA40; //475ED8
    79 {20}: Result := @MA19; //475EE4
    80 {21}: Result := @MA42; //475EF0
    81 {22}: Result := @MA43; //475EFC
    83 {23}: Result := @MA44; //475F08
    84 {24}: Result := @MA45; //475F14
    85 {24}: Result := @MA45; //475F14
    86 {24}: Result := @MA45; //475F14
    87 {24}: Result := @MA45; //475F14
    88 {24}: Result := @MA45; //475F14
    89 {24}: Result := @MA45; //475F14
    90 {11}: Result := @MA30; //475E30
    98 {25}: Result := @MA27; //475F20
    99 {26}: Result := @MA26; //475F29
    100 {0A}: Result := @MA19; //@MA33; //475DDC 月灵
    101: Result := @MA101;

    102: Result := @MA51;
    103: Result := @MA51; //白老虎
    104: Result := @MA51; //Mon24 魔法蜘蛛
    105: Result := @MA52; // Mon24 蛇
    106: Result := @MA52; // Mon24 雷炎蛛王
    107: Result := @MA52; // Mon25 异型骷髅精灵
    108: Result := @MA52; // Mon25 异型爬地粪虫
    109: Result := @MA52; // Mon26
    110: Result := @MA51; // Mon26
    111: Result := @MA52; // Mon26
    112: Result := @MA52; // Mon26
    113: Result := @MA51; // Mon27
    114: Result := @MA51; // Mon27
    115: Result := @MA53; // Mon27
    116: Result := @MA19; // Mon27
    117: Result := @MA54; // Mon27
  end
end;

function GetOffset(Appr: Integer): Integer;
var
  nrace, npos: Integer;
begin
  Result := 0;
  nrace := Appr div 10;
  npos := Appr mod 10;
  case nrace of
    0: Result := npos * 280;
    1: Result := npos * 230;
    2, 3, 7..12: Result := npos * 360;
    4: begin
        Result := npos * 360; //
        if npos = 1 then Result := 600;
      end;
    5: Result := npos * 430; //
    6: Result := npos * 440; //
    //      13:   Result := npos * 360;
    13: case npos of
        0: Result := 0;
        1: Result := 360;
        2: Result := 440;
        3: Result := 550;
      else Result := npos * 360;
      end;
    14: Result := npos * 360;
    15: Result := npos * 360;
    16: Result := npos * 360;
    17: case npos of
        2: Result := 920;
        3: Result := 1280;
      else Result := npos * 350;
      end;
    18: case npos of
        0: Result := 0;
        1: Result := 520;
        2: Result := 950;
        3: Result := 1574;
        4: Result := 1934;
        5: Result := 2294;
        6: Result := 2654;
        7: Result := 3014;
      end;
    19: case npos of
        0: Result := 0;
        1: Result := 370;
        2: Result := 810;
        3: Result := 1250;
        4: Result := 1630;
        5: Result := 2010;
        6: Result := 2390;
      end;
    20: case npos of
        0: Result := 0;
        1: Result := 360;
        2: Result := 720;
        3: Result := 1080;
        4: Result := 1440;
        5: Result := 1800;
        6: Result := 2350;
        7: Result := 3060;
      end;
    21: case npos of
        0: Result := 0;
        1: Result := 460;
        2: Result := 820;
        3: Result := 1180;
        4: Result := 1540;
        5: Result := 1900;
        //               6: Result := 2260;
        6: Result := 2440;
        7: Result := 2570;
        8: Result := 2700;
      end;

    22: case npos of
        0: Result := 0;
        1: Result := 430;
        2: Result := 1290;
        3: Result := 1810;
        4: Result := 2320;
        5: Result := 2920;
        6: Result := 3270;
        7: Result := 3620;
      end;

    23: case npos of
        0: Result := 0;
        1: Result := 340;
        2: Result := 680;
        3: Result := 1180;
        4: Result := 1770;
        5: Result := 2610;
        6: Result := 2950;
        7: Result := 3290;
        8: Result := 3750;
        9: Result := 4100;
      end;
    {23: case npos of
        0: Result := 0;
        1: Result := 440;
        2: Result := 820;
        3: Result := 1360;
        4: Result := 1420;
        5: Result := 1450;
        6: Result := 1560;
        7: Result := 1670;
        8: Result := 2270;
        9: Result := 2700;
      end; }
    {24: case npos of
        0: Result := 0;
        1: Result := 350;
        2: Result := 700;
        3: Result := 1050;
        4: Result := 1650;
        5: Result := 3100;
        6: Result := 3450;
        7: Result := 3880;
        8: Result := 4230;
        9: Result := 4580;
      end;}
    24: case npos of
        0: Result := 0;
        1: Result := 510;
      end;
    25: case npos of
        0: Result := 0;
        1: Result := 510;
        2: Result := 1020;
        3: Result := 1370;
        4: Result := 1720;
        5: Result := 2070;
        6: Result := 2740;

        8: Result := 3820;
        9: Result := 4170;
      end;
    26: case npos of
        0: Result := 0;
        1: Result := 340;
        2: Result := 680;
        3: Result := 1190;
        4: Result := 1930;
        5: Result := 2100;
        6: Result := 2440;
      end;
    27: case npos of
        0: Result := 0;
        1: Result := 350;
        2: Result := 780;
        3: Result := 1130;
        4: Result := 1560;
        5: Result := 1910;
      end;
    28: Result := 0;

    29: case npos of
        0: Result := 0;
        1: Result := 360;
        2: Result := 720;
      end;

    80: case npos of
        0: Result := 0;
        1: Result := 80;
        2: Result := 300;
        3: Result := 301;
        4: Result := 302;
        5: Result := 320;
        6: Result := 321;
        7: Result := 322;
        8: Result := 321;
      end;
    90: case npos of
        0: Result := 80;
        1: Result := 168;
        2: Result := 184;
        3: Result := 200;
      end;
  else Result := npos * 360;
  end;
end;

function GetNpcOffset(nAppr: Integer): Integer;
begin
  Result := 0;
  if nAppr < 300 then begin
    case nAppr of
    {
    0..34: Result:=nAppr * 60;
    35: Result:=2040;
    36: Result:=2100;
    37..42: Result:=(nAppr - 37) * 60 + 2160;
    43: Result:=2520;
    44: Result:=2580;
    45: Result:=2640;
    46: Result:=2700;
    47: Result:=2760;
    48: Result:=2820;
    49: Result:=2880;
    50: Result:=2940;
    51: Result:=2960;
    }
      24, 25: Result := (nAppr - 24) * 60 + 1470;
      0..22: Result := nAppr * 60;
      23: Result := 1380;
      27, 32: Result := (nAppr - 26) * 60 + 1620 - 30;
      26, 28, 29, 30, 31, 33..41: Result := (nAppr - 26) * 60 + 1620;
      42, 43: Result := 2580;
      44..47: Result := 2640;
      48..50: Result := (nAppr - 48) * 60 + 2700;
      51: Result := 2880;
      52: Result := 2960;
      53..60: Result := (nAppr - 53) * 60 + 3060;
      61: Result := 3600;
      62..70: Result := (nAppr - 62) * 10 + 3750;
      71..72: Result := (nAppr - 71) * 60 + 3840;
      73..75: Result := (nAppr - 73) * 20 + 3960;
      76: Result := 4030;
      77..79: Result := (nAppr - 77) * 60 + 4060;
      80..84: Result := (nAppr - 80) * 10 + 4490;
      85..86: Result := (nAppr - 85) * 20 + 4540;
      87: Result := 4770;
      88: Result := 4810;
    end;
  end else Result := (nAppr - 300) * 60;
end;

constructor TActor.Create;
begin
  //inherited Create;
  FillChar(m_Abil, SizeOf(TAbility), 0);
  FillChar(m_Action, SizeOf(m_Action), 0);
  m_WeaponGlimmerSurface := nil;
  m_MsgList := TGList.Create;
  m_nRecogId := 0;
  m_BodySurface := nil;
  m_nGold := 0;
  m_boVisible := True;
  m_boHoldPlace := True;
  m_nCurrentAction := 0;
  m_boReverseFrame := False;
  m_nShiftX := 0;
  m_nShiftY := 0;
  m_nDownDrawLevel := 0;
  m_nCurrentFrame := -1;

  m_nEffectFrame := -1;
  RealActionMsg.ident := 0;
  m_sUserName := '';
  m_nNameColor := clWhite;
  m_dwSendQueryUserNameTime := 0; //GetTickCount;
  m_boWarMode := False;
  m_dwWarModeTime := 0; //War mode
  m_boDeath := False;
  m_boSkeleton := False;
  m_boDelActor := False;
  m_boDelActionAfterFinished := False;

  m_nChrLight := 0;
  m_nMagLight := 0;
  m_boLockEndFrame := False;
  m_dwSmoothMoveTime := 0; //GetTickCount;
  m_dwGenAnicountTime := 0;
  m_dwDefFrameTime := 0;
  m_dwLoadSurfaceTime := 60 * 1000;
  m_dwLoadSurfaceTick := GetTickCount { - m_dwLoadSurfaceTime};
  m_boGrouped := False;
  m_boOpenHealth := False;
  m_noInstanceOpenHealth := False;
  m_CurMagic.ServerMagicCode := 0;
  m_CurMagic.MagicFire := False;
  //CurMagic.MagicSerial := 0;

  m_CurMagicList := TGList.Create; //群体魔法列表

  m_nSpellFrame := DEFSPELLFRAME;

  m_nNormalSound := -1;
  m_nFootStepSound := -1;
  m_nAttackSound := -1;
  m_nWeaponSound := -1;
  m_nStruckSound := s_struck_body_longstick;
  m_nStruckWeaponSound := -1;
  m_nScreamSound := -1;
  m_nDieSound := -1;
  m_nDie2Sound := -1;
  m_dwOpenHealthTime := 1000 * 2;
  m_HealthList := TGList.Create;

  m_nStateEndFrame := 0;
  m_nStateStartFrame := m_nStateEndFrame + 1;

  m_dwStateFrameTime := GetTickCount;
  m_btState := 0;
  m_boSuperShield := False; //4级魔法盾
  m_boCreateMagic := False;
  m_boStartStore := False; //摆摊
  m_StoreSurface := nil;

  m_nIndex := -1;
  m_nMoveStepCount := 0;
  m_dwMoveTime := GetTickCount;
end;

destructor TActor.Destroy;
var
  I: Integer;
  Msg: pTChrMsg;
  HealthStatus: pTHealthStatus;
  UseMagicInfo: pTUseMagicInfo;
begin
  for I := 0 to m_MsgList.Count - 1 do begin
    Msg := m_MsgList.Items[I];
    Dispose(Msg);
  end;
  m_MsgList.Free;
  for I := 0 to m_HealthList.Count - 1 do begin
    HealthStatus := m_HealthList.Items[I];
    Dispose(HealthStatus);
  end;
  m_HealthList.Free;

  for I := 0 to m_CurMagicList.Count - 1 do begin
    UseMagicInfo := m_CurMagicList.Items[I];
    Dispose(UseMagicInfo);
  end;
  m_CurMagicList.Free;
  inherited;
end;

procedure TActor.SendMsg(wIdent: Word; nX, nY, ndir, nFeature, nState: Integer; sStr: string; nSound: Integer);
var
  Msg: pTChrMsg;
begin
  if not CanDraw then begin
    case wIdent of
      CM_SPELL,
        SM_SPELL,
        SM_MAGICFIRE,
        SM_MAGICFIRE_FAIL,
        SM_HEROLOGOUT,
        SM_SPACEMOVE_HIDE,
        SM_SPACEMOVE_HIDE2,
        SM_SPACEMOVE_SHOW,
        SM_SPACEMOVE_SHOW2,
        SM_LEVELUP:
        Exit;
    else SendUpdateMsg(wIdent, nX, nY, ndir, nFeature, nState, sStr, nSound);
    end;
    Exit;
  end;
  New(Msg);
  Msg.ident := wIdent;
  Msg.X := nX;
  Msg.Y := nY;
  Msg.dir := ndir;
  Msg.feature := nFeature;
  Msg.State := nState;
  Msg.saying := sStr;
  Msg.sound := nSound;
  m_MsgList.Lock;
  try
    m_MsgList.Add(Msg);
  finally
    m_MsgList.UnLock;
  end;
end;

procedure TActor.SendUpdateMsg(wIdent: Word; nX, nY, ndir, nFeature, nState: Integer; sStr: string; nSound: Integer);
var
  I: Integer;
  Msg: pTChrMsg;
begin
  m_MsgList.Lock;
  try
    I := 0;
    while True do begin
      if I >= m_MsgList.Count then Break;
      Msg := m_MsgList.Items[I];
      if ((Self = g_MySelf) and (Msg.ident >= 3000) and (Msg.ident <= 3099)) or (Msg.ident = wIdent) then begin
        Dispose(Msg);
        m_MsgList.Delete(I);
        Continue;
      end;
      Inc(I);
    end;
  finally
    m_MsgList.UnLock;
  end;
  New(Msg);
  Msg.ident := wIdent;
  Msg.X := nX;
  Msg.Y := nY;
  Msg.dir := ndir;
  Msg.feature := nFeature;
  Msg.State := nState;
  Msg.saying := sStr;
  Msg.sound := nSound;
  m_MsgList.Lock;
  try
    m_MsgList.Add(Msg);
  finally
    m_MsgList.UnLock;
  end;
end;

procedure TActor.UpdateMsg(wIdent: Word; nX, nY, ndir, nFeature, nState: Integer; sStr: string; nSound: Integer);
var
  I: Integer;
  Msg: pTChrMsg;
begin
  m_MsgList.Lock;
  try
    I := 0;
    while True do begin
      if I >= m_MsgList.Count then Break;
      Msg := m_MsgList.Items[I];
      if ((Self = g_MySelf) and (Msg.ident >= 3000) and (Msg.ident <= 3099)) or (Msg.ident = wIdent) then begin
        Dispose(Msg);
        m_MsgList.Delete(I);
        Continue;
      end;
      Inc(I);
    end;
  finally
    m_MsgList.UnLock;
  end;
  SendMsg(wIdent, nX, nY, ndir, nFeature, nState, sStr, nSound);
end;

procedure TActor.CleanUserMsgs;
var
  I: Integer;
  Msg: pTChrMsg;
begin
  m_MsgList.Lock;
  try
    I := 0;
    while True do begin
      if I >= m_MsgList.Count then Break;
      Msg := m_MsgList.Items[I];
      if (Msg.ident >= 3000) and
        (Msg.ident <= 3099) then begin
        Dispose(Msg);
        m_MsgList.Delete(I);
        Continue;
      end;
      Inc(I);
    end;
  finally
    m_MsgList.UnLock;
  end;
end;

procedure TActor.CalcActorFrame;
var
  haircount: Integer;
begin
  m_boUseMagic := False;
  m_nCurrentFrame := -1;
  m_nBodyOffset := GetOffset(m_wAppearance);
  m_Action := GetRaceByPM(m_btRace, m_wAppearance);
  if m_Action = nil then Exit;
  case m_nCurrentAction of
    SM_TURN: begin
        m_nStartFrame := m_Action.ActStand.start + m_btDir * (m_Action.ActStand.frame + m_Action.ActStand.skip);
        m_nEndFrame := m_nStartFrame + m_Action.ActStand.frame - 1;
        m_dwFrameTime := m_Action.ActStand.ftime;
        m_dwStartTime := GetTickCount;
        m_nDefFrameCount := m_Action.ActStand.frame;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_WALK, SM_RUSH, SM_RUSHKUNG, SM_BACKSTEP: begin
        m_nStartFrame := m_Action.ActWalk.start + m_btDir * (m_Action.ActWalk.frame + m_Action.ActWalk.skip);
        m_nEndFrame := m_nStartFrame + m_Action.ActWalk.frame - 1;
        m_dwFrameTime := m_Action.ActWalk.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := m_Action.ActWalk.usetick;
        m_nCurTick := 0;
        m_nMoveStep := 1;

        if m_nCurrentAction = SM_BACKSTEP then
          Shift(GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1)
        else
          Shift(m_btDir, m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1);
      end;
    {SM_BACKSTEP:
       begin
          startframe := pm.ActWalk.start + (pm.ActWalk.frame - 1) + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
          m_nEndFrame := startframe - (pm.ActWalk.frame - 1);
          m_dwFrameTime := pm.ActWalk.ftime;
          m_dwStartTime := GetTickCount;
          m_nMaxTick := pm.ActWalk.UseTick;
          m_nCurTick := 0;
          m_nMoveStep := 1;
          Shift (GetBack(Dir), m_nMoveStep, 0, m_nEndFrame-startframe+1);
       end;}
    SM_HIT: begin
        m_nStartFrame := m_Action.ActAttack.start + m_btDir * (m_Action.ActAttack.frame + m_Action.ActAttack.skip);
        m_nEndFrame := m_nStartFrame + m_Action.ActAttack.frame - 1;
        m_dwFrameTime := m_Action.ActAttack.ftime;
        m_dwStartTime := GetTickCount;
        //WarMode := TRUE;
        m_dwWarModeTime := GetTickCount;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_STRUCK: begin
        m_nStartFrame := m_Action.ActStruck.start + m_btDir * (m_Action.ActStruck.frame + m_Action.ActStruck.skip);
        m_nEndFrame := m_nStartFrame + m_Action.ActStruck.frame - 1;
        m_dwFrameTime := m_dwStruckFrameTime; //pm.ActStruck.ftime;
        m_dwStartTime := GetTickCount;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_DEATH: begin
        m_nStartFrame := m_Action.ActDie.start + m_btDir * (m_Action.ActDie.frame + m_Action.ActDie.skip);
        m_nEndFrame := m_nStartFrame + m_Action.ActDie.frame - 1;
        m_nStartFrame := m_nEndFrame;
        m_dwFrameTime := m_Action.ActDie.ftime;
        m_dwStartTime := GetTickCount;
      end;
    SM_NOWDEATH: begin
        m_nStartFrame := m_Action.ActDie.start + m_btDir * (m_Action.ActDie.frame + m_Action.ActDie.skip);
        m_nEndFrame := m_nStartFrame + m_Action.ActDie.frame - 1;
        m_dwFrameTime := m_Action.ActDie.ftime;
        m_dwStartTime := GetTickCount;
      end;
    SM_SKELETON: begin
        m_nStartFrame := m_Action.ActDeath.start + m_btDir;
        m_nEndFrame := m_nStartFrame + m_Action.ActDeath.frame - 1;
        m_dwFrameTime := m_Action.ActDeath.ftime;
        m_dwStartTime := GetTickCount;
      end;
  end;
end;

procedure TActor.ReadyAction(Msg: TChrMsg);
var
  n: Integer;
  UseMagic: pTUseMagicInfo;
begin
  m_nActBeforeX := m_nCurrX;
  m_nActBeforeY := m_nCurrY;

  if Msg.ident = SM_ALIVE then begin
    m_boDeath := False;
    m_boSkeleton := False;
  end;

  if not m_boDeath then begin
    case Msg.ident of
      SM_TURN, SM_WALK, SM_BACKSTEP, SM_RUSH, SM_RUSHKUNG, SM_RUN, SM_HORSERUN, SM_DIGUP, SM_ALIVE: begin
          m_nFeature := Msg.feature;
          m_nState := Msg.State;
          if m_nState and STATE_OPENHEATH <> 0 then m_boOpenHealth := True
          else m_boOpenHealth := False;
         
          if (GetTickCount - m_dwOpenHealthStart > m_dwOpenHealthTime) then m_noInstanceOpenHealth := False
          else m_noInstanceOpenHealth := True;
        end;
    end;

    if Msg.ident = SM_LIGHTING then
      n := 0;
    if g_MySelf = Self then begin
      if (Msg.ident = CM_WALK) then
        if not PlayScene.CanWalk(Msg.X, Msg.Y) then
          Exit;
      if (Msg.ident = CM_RUN) then
        if not PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, Msg.X, Msg.Y) then
          Exit;
      if (Msg.ident = CM_HORSERUN) then
        if not PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, Msg.X, Msg.Y) then
          Exit;

      case Msg.ident of
        CM_TURN,
          CM_WALK,
          CM_SITDOWN,
          CM_RUN,
          CM_HIT,
          CM_HEAVYHIT,
          CM_BIGHIT,
          CM_POWERHIT,
          CM_LONGHIT,
          CM_WIDEHIT,
          CM_KTHIT, //开天斩
          CM_PKHIT, //破空剑
          CM_ZRJFHIT, //逐日剑法
          CM_100HIT, //三绝杀
          CM_101HIT, //追心刺
          CM_102HIT, //断岳斩
          CM_103HIT //横扫千军
          : begin
            RealActionMsg := Msg;
            Msg.ident := Msg.ident - 3000;
          end;
        CM_HORSERUN: begin
            RealActionMsg := Msg;
            Msg.ident := SM_HORSERUN;
          end;
        CM_THROW: begin
            if m_nFeature <> 0 then begin
              m_nTargetX := TActor(Msg.feature).m_nCurrX;
              m_nTargetY := TActor(Msg.feature).m_nCurrY;
              m_nTargetRecog := TActor(Msg.feature).m_nRecogId;
            end;
            RealActionMsg := Msg;
            Msg.ident := SM_THROW;
          end;
        CM_FIREHIT: begin
            RealActionMsg := Msg;
            Msg.ident := SM_FIREHIT;
          end;
        CM_CRSHIT: begin
            RealActionMsg := Msg;
            Msg.ident := SM_CRSHIT;
          end;
        CM_TWINHIT: begin
            RealActionMsg := Msg;
            Msg.ident := SM_TWINHIT;
          end;

        CM_SPELL: begin
            RealActionMsg := Msg;
            UseMagic := pTUseMagicInfo(Msg.feature);
            RealActionMsg.dir := UseMagic.MagicSerial;
            Msg.ident := Msg.ident - 3000;
          end;
      end;

      m_nOldx := m_nCurrX;
      m_nOldy := m_nCurrY;
      m_nOldDir := m_btDir;
    end;
    case Msg.ident of
      SM_STRUCK: begin
          m_nMagicStruckSound := Msg.X;
          n := Round(200 - m_Abil.Level * 5);
          if n > 80 then m_dwStruckFrameTime := n
          else m_dwStruckFrameTime := 80;
          m_dwLastStruckTime := GetTickCount;
        end;
      SM_SPELL: begin
          m_btDir := Msg.dir;
          UseMagic := pTUseMagicInfo(Msg.feature);
          if UseMagic <> nil then begin
            m_CurMagic := UseMagic^;
            m_CurMagic.ServerMagicCode := -1; //FIRE
            //CurMagic.MagicSerial := 0;
            m_CurMagic.targx := Msg.X;
            m_CurMagic.targy := Msg.Y;
            Dispose(UseMagic);
          end;
        end;
    else begin
        {if Self = g_MySelf then begin
          DScreen.AddChatBoardString('Msg.ident ' + IntToStr(Msg.ident), clWhite, clPurple);
          DScreen.AddChatBoardString('Msg.X ' + IntToStr(Msg.X), clWhite, clPurple);
          DScreen.AddChatBoardString('Msg.Y ' + IntToStr(Msg.Y), clWhite, clPurple);
        end; }
        if (Msg.ident <> SM_MAGICFIRE) and (Msg.ident <> SM_MAGICFIRE_FAIL) then begin //可能产生黑屏
          m_nCurrX := Msg.X;
          m_nCurrY := Msg.Y;
          m_btDir := Msg.dir;
        end;
        {if Self = g_MySelf then begin
          if Msg.ident <> SM_MAGICFIRE then begin
            m_nCurrX := Msg.X;
            m_nCurrY := Msg.Y;
            m_btDir := Msg.dir;
          end;
        end else begin
          m_nCurrX := Msg.X;
          m_nCurrY := Msg.Y;
          m_btDir := Msg.dir;
        end; }
      end;
    end;

    m_nCurrentAction := Msg.ident;
    CalcActorFrame;
  end else begin
    if Msg.ident = SM_SKELETON then begin
      m_nCurrentAction := Msg.ident;
      CalcActorFrame;
      m_boSkeleton := True;
    end;
  end;
  if (Msg.ident = SM_DEATH) or (Msg.ident = SM_NOWDEATH) then begin
    m_boDeath := True;
    PlayScene.ActorDied(Self);
  end;
  RunSound;
end;

function TActor.GetMessage(ChrMsg: pTChrMsg): Boolean;
var
  Msg: pTChrMsg;
begin
  Result := False;
  m_MsgList.Lock;
  try
    if m_MsgList.Count > 0 then begin
      Msg := m_MsgList.Items[0];
      ChrMsg.ident := Msg.ident;
      ChrMsg.X := Msg.X;
      ChrMsg.Y := Msg.Y;
      ChrMsg.dir := Msg.dir;
      ChrMsg.State := Msg.State;
      ChrMsg.feature := Msg.feature;
      ChrMsg.saying := Msg.saying;
      ChrMsg.sound := Msg.sound;
      m_MsgList.Delete(0);
      Dispose(Msg);
      Result := True;
    end;
  finally
    m_MsgList.UnLock;
  end;
end;

procedure TActor.ProcMsg;
var
  Msg: TChrMsg;
  meff: TMagicEff;
begin
  while (m_nCurrentAction = 0) and GetMessage(@Msg) do begin
    case Msg.ident of
      SM_STRUCK: begin
          m_nHiterCode := Msg.sound;
          ReadyAction(Msg);
        end;
      SM_DEATH, //27
        SM_NOWDEATH,
        SM_SKELETON,
        SM_ALIVE,
        SM_ACTION_MIN..SM_ACTION_MAX, //26
        SM_ACTION2_MIN..SM_ACTION2_MAX, //35   2293    293
        3000..3099: ReadyAction(Msg);

      SM_HEROLOGON: begin //创建召唤英雄魔法效果
          meff := THeroShowEffect.Create(800, 10, Self);
          PlayScene.m_EffectList.Add(meff);
          PlaySound(s_HeroLogIn);
        end;

      SM_HEROLOGOUT: begin //创建退出英雄魔法效果
          meff := THeroShowEffect.Create(810, 10, Self);
          PlayScene.m_EffectList.Add(meff);
          PlaySound(s_HeroLogOut);
        end;
      SM_LEVELUP: begin //升级效果
          meff := TLevelShowEffect.Create(110, 15, Self);
          PlayScene.m_EffectList.Add(meff);
          PlaySound(s_powerup);
        end;
      SM_BLASTHHIT: begin //爆击效果
          meff := TBlasthitEffect.Create(4190, 4, Self);
          PlayScene.m_EffectList.Add(meff);
          //PlaySound(s_powerup);
        end;
      SM_SPACEMOVE_HIDE: begin
          meff := TScrollHideEffect.Create(250, 10, m_nCurrX, m_nCurrY, Self);
          PlayScene.m_EffectList.Add(meff);
          PlaySound(s_spacemove_out);
        end;
      SM_SPACEMOVE_HIDE2: begin
          meff := TScrollHideEffect.Create(1590, 10, m_nCurrX, m_nCurrY, Self);
          PlayScene.m_EffectList.Add(meff);
          PlaySound(s_spacemove_out);
        end;
      SM_SPACEMOVE_SHOW: begin
          meff := TCharEffect.Create(260, 10, Self);
          PlayScene.m_EffectList.Add(meff);
          Msg.ident := SM_TURN;
          ReadyAction(Msg);
          PlaySound(s_spacemove_in);
        end;
      SM_SPACEMOVE_SHOW2: begin
          meff := TCharEffect.Create(1600, 10, Self);
          PlayScene.m_EffectList.Add(meff);
          Msg.ident := SM_TURN;
          ReadyAction(Msg);
          PlaySound(s_spacemove_in);
        end;
    else begin
        ReadyAction(Msg); //Damian
      end;
    end;
  end;
end;

procedure TActor.ProcHurryMsg;
var
  n: Integer;
  Msg: TChrMsg;
  fin, bofly: Boolean;
  CurMagic: pTUseMagicInfo;
begin
  n := 0;
  while True do begin
    if m_MsgList.Count <= n then Break;
    Msg := pTChrMsg(m_MsgList[n])^;
    fin := False;
    case Msg.ident of
      SM_MAGICFIRE:
        if m_CurMagic.ServerMagicCode <> 0 then begin
          m_CurMagic.ServerMagicCode := 111;
          m_CurMagic.target := Msg.X;
          if Msg.Y in [0..MAXMAGICTYPE - 1] then
            m_CurMagic.EffectType := TMagicType(Msg.Y); //EffectType
          m_CurMagic.EffectNumber := Msg.dir; //Effect
          m_CurMagic.targx := Msg.feature;
          m_CurMagic.targy := Msg.State;
          m_CurMagic.Recusion := True;
          fin := True;

         { if (m_btJob <> 0) then
            DScreen.AddChatBoardString(m_sUserName + ' SM_MAGICFIRE ' + IntToStr(m_CurMagic.EffectNumber) + ' ServerMagicCode ' + IntToStr(m_CurMagic.ServerMagicCode), clWhite, clPurple);
          }
        end;
      SM_MAGICFIRE_FAIL:
        if m_CurMagic.ServerMagicCode <> 0 then begin
          m_CurMagic.ServerMagicCode := 0;
          fin := True;
        end;
    end;
    if fin then begin
      Dispose(pTChrMsg(m_MsgList[n]));
      m_MsgList.Delete(n);
    end else Inc(n);
  end;
end;

function TActor.IsIdle: Boolean;
begin
  Result := False;
  if (m_nCurrentAction = 0) and (m_MsgList.Count = 0) then begin
    Result := True
  end;
end;

function TActor.ActionFinished: Boolean;
begin
  if (m_nCurrentAction = 0) or (m_nCurrentFrame >= m_nEndFrame) then
    Result := True
  else Result := False;
end;

function TActor.CanWalk: Integer;
begin
  if {(GetTickCount - LastStruckTime < 1300) or}(GetTickCount - g_dwLatestSpellTick < g_dwMagicPKDelayTime) then
    Result := -1
  else
    Result := 1;
end;

function TActor.CanRun: Integer;
begin
  Result := 1;
  //检查人物的HP值是否低于指定值，低于指定值将不允许跑
  if m_Abil.HP < RUN_MINHEALTH then begin
    Result := -1;
  end else
    //检查人物是否被攻击，如果被攻击将不允许跑，取消检测将可以跑步逃跑

    if (GetTickCount - m_dwLastStruckTime < 3 * 1000) {or (GetTickCount - LatestSpellTime < MagicPKDelayTime)} then
       Result := -2;
end;

function TActor.Strucked: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to m_MsgList.Count - 1 do begin
    if pTChrMsg(m_MsgList[I]).ident = SM_STRUCK then begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TActor.Shift(dir, step, cur, Max: Integer);
var
  unx, uny, ss, v: Integer;
begin
  unx := UNITX * step;
  uny := UNITY * step;
  if cur > Max then cur := Max;
  m_nRx := m_nCurrX;
  m_nRy := m_nCurrY;
  ss := Round((Max - cur - 1) / Max) * step;
  case dir of
    DR_UP: begin
        ss := Round((Max - cur) / Max) * step;
        m_nShiftX := 0;
        m_nRy := m_nCurrY + ss;
        if ss = step then m_nShiftY := -Round(uny / Max * cur)
        else m_nShiftY := Round(uny / Max * (Max - cur));
      end;
    DR_UPRIGHT: begin
        if Max >= 6 then v := 2
        else v := 0;
        ss := Round((Max - cur + v) / Max) * step;
        m_nRx := m_nCurrX - ss;
        m_nRy := m_nCurrY + ss;
        if ss = step then begin
          m_nShiftX := Round(unx / Max * cur);
          m_nShiftY := -Round(uny / Max * cur);
        end else begin
          m_nShiftX := -Round(unx / Max * (Max - cur));
          m_nShiftY := Round(uny / Max * (Max - cur));
        end;
      end;
    DR_RIGHT: begin
        ss := Round((Max - cur) / Max) * step;
        m_nRx := m_nCurrX - ss;
        if ss = step then m_nShiftX := Round(unx / Max * cur)
        else m_nShiftX := -Round(unx / Max * (Max - cur));
        m_nShiftY := 0;
      end;
    DR_DOWNRIGHT: begin
        if Max >= 6 then v := 2
        else v := 0;
        ss := Round((Max - cur - v) / Max) * step;
        m_nRx := m_nCurrX - ss;
        m_nRy := m_nCurrY - ss;
        if ss = step then begin
          m_nShiftX := Round(unx / Max * cur);
          m_nShiftY := Round(uny / Max * cur);
        end else begin
          m_nShiftX := -Round(unx / Max * (Max - cur));
          m_nShiftY := -Round(uny / Max * (Max - cur));
        end;
      end;
    DR_DOWN: begin
        if Max >= 6 then v := 1
        else v := 0;
        ss := Round((Max - cur - v) / Max) * step;
        m_nShiftX := 0;
        m_nRy := m_nCurrY - ss;
        if ss = step then m_nShiftY := Round(uny / Max * cur)
        else m_nShiftY := -Round(uny / Max * (Max - cur));
      end;
    DR_DOWNLEFT: begin
        if Max >= 6 then v := 2
        else v := 0;
        ss := Round((Max - cur - v) / Max) * step;
        m_nRx := m_nCurrX + ss;
        m_nRy := m_nCurrY - ss;
        if ss = step then begin
          m_nShiftX := -Round(unx / Max * cur);
          m_nShiftY := Round(uny / Max * cur);
        end else begin
          m_nShiftX := Round(unx / Max * (Max - cur));
          m_nShiftY := -Round(uny / Max * (Max - cur));
        end;
      end;
    DR_LEFT: begin
        ss := Round((Max - cur) / Max) * step;
        m_nRx := m_nCurrX + ss;
        if ss = step then m_nShiftX := -Round(unx / Max * cur)
        else m_nShiftX := Round(unx / Max * (Max - cur));
        m_nShiftY := 0;
      end;
    DR_UPLEFT: begin
        if Max >= 6 then v := 2
        else v := 0;
        ss := Round((Max - cur + v) / Max) * step;
        m_nRx := m_nCurrX + ss;
        m_nRy := m_nCurrY + ss;
        if ss = step then begin
          m_nShiftX := -Round(unx / Max * cur);
          m_nShiftY := -Round(uny / Max * cur);
        end else begin
          m_nShiftX := Round(unx / Max * (Max - cur));
          m_nShiftY := Round(uny / Max * (Max - cur));
        end;
      end;
  end;
end;

procedure TActor.FeatureChanged;
var
  haircount: Integer;
  btHorseDress: Integer;
  btHorse: Byte;
  boLoadSurface: Boolean;
begin
  boLoadSurface := False;
  case m_btRace of
    0: begin
        m_btHair := HAIRfeature(m_nFeature);
        m_btDress := DRESSfeature(m_nFeature);
        m_btWeapon := WEAPONfeature(m_nFeature);
        btHorse := Horsefeature(m_nFeatureEx);
        m_btEffect := Effectfeature(m_nFeatureEx);
        if btHorse <> m_btHorse then begin
          if (m_btHorse = 0) or (btHorse = 0) then begin
            boLoadSurface := True;
          end;
          m_btHorse := btHorse;
        end;
        if m_btHorse = 0 then begin
          m_nBodyOffset := HUMANFRAME * m_btDress;
        end else begin
          btHorseDress := (g_WHumHorseImages.ImageCount div HUMANFRAME) - 1; //计算人物数
          if g_WHumHorseImages.ImageCount mod HUMANFRAME > 0 then Inc(btHorseDress);
          if m_btDress <= btHorseDress then begin
            m_nBodyOffset := HUMANFRAME * m_btDress;
          end else begin
            m_nBodyOffset := HUMANFRAME * btHorseDress;
          end;
          g_TargetCret := nil;
        end;

        m_btHair := (m_btHair - m_btDress mod 2) div 2;
        if (m_btHair < 4) or (m_btHorse > 0) then begin
          haircount := -1;
          case m_btDress mod 2 of
            0: haircount := m_btHair * 2;
            1: haircount := m_btHair + 2;
          end;
          if haircount > 0 then
            m_nHairOffset := HUMANFRAME * haircount
          else m_nHairOffset := -1;
        end else begin
          case m_btHair of
            4: m_nHairOffset := 3600;
            5: m_nHairOffset := 4800;
          end;
        end;

        m_nWeaponOffset := HUMANFRAME * m_btWeapon; //(weapon*2 + m_btSex);

        if m_btEffect <> 0 then begin
          if m_btEffect = 50 then begin
            m_nHumWinOffset := 352;

          end else begin
            if m_btEffect > 100 then begin
              m_nHumWinOffset := (m_btEffect - 101) * HUMANFRAME;
            end else begin
              m_nHumWinOffset := (m_btEffect - 1) * HUMANFRAME;
            end;
          end;
        end;
      end;
    50: ; //npc
  else begin
      m_wAppearance := APPRfeature(m_nFeature);
      m_nBodyOffset := GetOffset(m_wAppearance);
      //BodyOffset := MONFRAME * (Appearance mod 10);
    end;
  end;
  if boLoadSurface then begin
    m_dwLoadSurfaceTick := GetTickCount();
    LoadSurface;
  end;
end;

function TActor.light: Integer;
begin
  Result := m_nChrLight;
end;

procedure TActor.UnLoadSurface;
var
  I: Integer;
begin
  m_BodySurface := nil;
  m_WeaponGlimmerSurface := nil;
  m_dwLoadSurfaceTick := GetTickCount - m_dwLoadSurfaceTime;
end;

procedure TActor.LoadSurface;
var
  mimg: TGameImages;
begin
  mimg := g_WMonImages.Images[m_wAppearance];
  if mimg <> nil then begin
    if (not m_boReverseFrame) then begin
      m_BodySurface := mimg.GetCachedImage(GetOffset(m_wAppearance) + m_nCurrentFrame, m_nPx, m_nPy);
    end else begin
      m_BodySurface := mimg.GetCachedImage(
        GetOffset(m_wAppearance) + m_nEndFrame - (m_nCurrentFrame - m_nStartFrame),
        m_nPx, m_nPy);
    end;
  end;
end;

procedure TActor.AddHealthStatus(btStatus: Byte; nValue: Integer);
var
  //I, II, nWidth: Integer;
  //d: TTexture;
  HealthStatus: pTHealthStatus;
begin
  if not CanDraw then Exit;
  if not g_Config.boShowMoveLable then Exit;
  if g_NewStatus = sBlind then Exit;

  New(HealthStatus);
  HealthStatus.btStatus := btStatus;
  HealthStatus.nValue := nValue;
  HealthStatus.dwFrameTime := GetTickCount;
  HealthStatus.nCurrentFrame := 0;

  {case HealthStatus.btStatus of
    0: begin
        d := g_WCqFirImages.Images[42]; //MISS
        if d <> nil then begin
          HealthStatus.Text := TTexture.Create;
          HealthStatus.Text.Assign(d);
        end;
      end;
    1: begin //红 ADD
        nWidth := 0;
        d := g_WCqFirImages.Images[17];
        if d <> nil then begin
          MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
          nWidth := d.Width;
        end;
        sValue := IntToStr(HealthStatus.nValue);
        for II := 1 to Length(sValue) do begin
          d := g_WCqFirImages.Images[6 + StrToInt(sValue[II])];
          if d <> nil then begin
            MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame + nWidth, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
            Inc(nWidth, d.Width);
          end;
        end;
      end;
    2: begin
        nWidth := 0;
        d := g_WCqFirImages.Images[16];
        if d <> nil then begin
          MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame, m_nSayY - 10 - HealthStatus.nCurrentFrame + 4, d.ClientRect, d, True);
          nWidth := d.Width;
        end;
        sValue := IntToStr(HealthStatus.nValue);
        for II := 1 to Length(sValue) do begin
          d := g_WCqFirImages.Images[6 + StrToInt(sValue[II])];
          if d <> nil then begin
            MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame + nWidth, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
            Inc(nWidth, d.Width);
          end;
        end;
      end;
    3: begin //蓝
        nWidth := 0;
        d := g_WCqFirImages.Images[29];
        if d <> nil then begin
          MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
          nWidth := d.Width;
        end;
        sValue := IntToStr(HealthStatus.nValue);
        for II := 1 to Length(sValue) do begin
          d := g_WCqFirImages.Images[18 + StrToInt(sValue[II])];
          if d <> nil then begin
            MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame + nWidth, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
            Inc(nWidth, d.Width);
          end;
        end;
      end;
    4: begin
        nWidth := 0;
        d := g_WCqFirImages.Images[28];
        if d <> nil then begin
          MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame, m_nSayY - 10 - HealthStatus.nCurrentFrame + 4, d.ClientRect, d, True);
          nWidth := d.Width;
        end;
        sValue := IntToStr(HealthStatus.nValue);
        for II := 1 to Length(sValue) do begin
          d := g_WCqFirImages.Images[18 + StrToInt(sValue[II])];
          if d <> nil then begin
            MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame + nWidth, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
            Inc(nWidth, d.Width);
          end;
        end;
      end;

    5: begin //绿
        nWidth := 0;
        d := g_WCqFirImages.Images[41];
        if d <> nil then begin
          MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
          nWidth := d.Width;
        end;
        sValue := IntToStr(HealthStatus.nValue);
        for II := 1 to Length(sValue) do begin
          d := g_WCqFirImages.Images[30 + StrToInt(sValue[II])];
          if d <> nil then begin
            MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame + nWidth, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
            Inc(nWidth, d.Width);
          end;
        end;
      end;
    6: begin
        nWidth := 0;
        d := g_WCqFirImages.Images[40];
        if d <> nil then begin
          MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame, m_nSayY - 10 - HealthStatus.nCurrentFrame + 4, d.ClientRect, d, True);
          nWidth := d.Width;
        end;
        sValue := IntToStr(HealthStatus.nValue);
        for II := 1 to Length(sValue) do begin
          d := g_WCqFirImages.Images[30 + StrToInt(sValue[II])];
          if d <> nil then begin
            MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame + nWidth, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
            Inc(nWidth, d.Width);
          end;
        end;
      end;
  end;}

  m_HealthList.Lock;
  try
    m_HealthList.Add(HealthStatus);
  finally
    m_HealthList.UnLock;
  end;
end;

procedure TActor.ShowHealthStatus(MSurface: TTexture);
var
  I, II, nWidth: Integer;
  HealthStatus: pTHealthStatus;
  d: TTexture;
  sValue: string;
begin
  m_HealthList.Lock;
  try
    I := 0;
    while True do begin
      if I >= m_HealthList.Count then Break;
      HealthStatus := m_HealthList.Items[I];
      if HealthStatus.nCurrentFrame >= 40 then begin
        m_HealthList.Delete(I);
        Dispose(HealthStatus);
        Inc(I);
        Continue;
      end;
      case HealthStatus.btStatus of
        0: begin
            d := g_WCqFirImages.Images[42]; //MISS
            if d <> nil then
              MSurface.Draw(m_nSayX - HealthStatus.nCurrentFrame, m_nSayY - 25 - HealthStatus.nCurrentFrame, d.ClientRect, d, True); //
          end;
        1: begin //红 ADD
            nWidth := 0;
            d := g_WCqFirImages.Images[17];
            if d <> nil then begin
              MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
              nWidth := d.Width;
            end;
            sValue := IntToStr(HealthStatus.nValue);
            for II := 1 to Length(sValue) do begin
              d := g_WCqFirImages.Images[6 + StrToInt(sValue[II])];
              if d <> nil then begin
                MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame + nWidth, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
                Inc(nWidth, d.Width);
              end;
            end;
          end;
        2: begin
            nWidth := 0;
            d := g_WCqFirImages.Images[16];
            if d <> nil then begin
              MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame, m_nSayY - 10 - HealthStatus.nCurrentFrame + 4, d.ClientRect, d, True);
              nWidth := d.Width;
            end;
            sValue := IntToStr(HealthStatus.nValue);
            for II := 1 to Length(sValue) do begin
              d := g_WCqFirImages.Images[6 + StrToInt(sValue[II])];
              if d <> nil then begin
                MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame + nWidth, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
                Inc(nWidth, d.Width);
              end;
            end;
          end;
        3: begin //蓝
            nWidth := 0;
            d := g_WCqFirImages.Images[29];
            if d <> nil then begin
              MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
              nWidth := d.Width;
            end;
            sValue := IntToStr(HealthStatus.nValue);
            for II := 1 to Length(sValue) do begin
              d := g_WCqFirImages.Images[18 + StrToInt(sValue[II])];
              if d <> nil then begin
                MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame + nWidth, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
                Inc(nWidth, d.Width);
              end;
            end;
          end;
        4: begin
            nWidth := 0;
            d := g_WCqFirImages.Images[28];
            if d <> nil then begin
              MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame, m_nSayY - 10 - HealthStatus.nCurrentFrame + 4, d.ClientRect, d, True);
              nWidth := d.Width;
            end;
            sValue := IntToStr(HealthStatus.nValue);
            for II := 1 to Length(sValue) do begin
              d := g_WCqFirImages.Images[18 + StrToInt(sValue[II])];
              if d <> nil then begin
                MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame + nWidth, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
                Inc(nWidth, d.Width);
              end;
            end;
          end;

        5: begin //绿
            nWidth := 0;
            d := g_WCqFirImages.Images[41];
            if d <> nil then begin
              MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
              nWidth := d.Width;
            end;
            sValue := IntToStr(HealthStatus.nValue);
            for II := 1 to Length(sValue) do begin
              d := g_WCqFirImages.Images[30 + StrToInt(sValue[II])];
              if d <> nil then begin
                MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame + nWidth, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
                Inc(nWidth, d.Width);
              end;
            end;
          end;
        6: begin
            nWidth := 0;
            d := g_WCqFirImages.Images[40];
            if d <> nil then begin
              MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame, m_nSayY - 10 - HealthStatus.nCurrentFrame + 4, d.ClientRect, d, True);
              nWidth := d.Width;
            end;
            sValue := IntToStr(HealthStatus.nValue);
            for II := 1 to Length(sValue) do begin
              d := g_WCqFirImages.Images[30 + StrToInt(sValue[II])];
              if d <> nil then begin
                MSurface.Draw(m_nSayX + HealthStatus.nCurrentFrame + nWidth, m_nSayY - 10 - HealthStatus.nCurrentFrame, d.ClientRect, d, True);
                Inc(nWidth, d.Width);
              end;
            end;
          end;
      end;
      if GetTickCount - HealthStatus.dwFrameTime > 10 then begin
        HealthStatus.dwFrameTime := GetTickCount;

        Inc(HealthStatus.nCurrentFrame);
      end;
      Inc(I);
    end;
  finally
    m_HealthList.UnLock;
  end;
end;
 //画人物血条

procedure TActor.ShowActorLable(MSurface: TTexture);
var
  d: TTexture;
  rc: TRect;
  nHPY, nMPY: Integer;
begin
  if (m_boOpenHealth or m_noInstanceOpenHealth) and not m_boDeath then begin
  if m_sUserName = '' then Exit;
  if m_btHorse = 0 then begin
    nHPY := 10;
    nMPY := 6;
  end else begin //骑马状态修正坐标
    case m_btDir of
      DR_UP,
        DR_UPRIGHT,
        DR_UPLEFT: begin
          nHPY := 22 + 8;
          nMPY := 18 + 8;
        end;
      DR_DOWN,
        DR_DOWNRIGHT,
        DR_DOWNLEFT: begin
          nHPY := 22;
          nMPY := 18;
        end;
      DR_LEFT,
        DR_RIGHT: begin
          nHPY := 22 + 4;
          nMPY := 18 + 4;
        end;
    end;
  end;
  d := g_WMain3Images.Images[0];
  if d <> nil then
    MSurface.Draw(m_nSayX - d.Width div 2, m_nSayY - nHPY, d.ClientRect, d, True);

  d := g_WMain3Images.Images[1];
  if d <> nil then begin
    rc := d.ClientRect;
    if m_Abil.MaxHP > 0 then
      rc.Right := Round((rc.Right - rc.Left) / m_Abil.MaxHP * m_Abil.HP);
    MSurface.Draw(m_nSayX - d.Width div 2, m_nSayY - nHPY, rc, d, True);
  end;

  if m_btRace = RCC_USERHUMAN then begin
    d := g_WMain3Images.Images[1];
    if d <> nil then begin
      rc := d.ClientRect;
      if m_Abil.MaxHP > 0 then
        rc.Right := Round((rc.Right - rc.Left) / m_Abil.MaxHP * m_Abil.HP);
      MSurface.Draw(m_nSayX - d.Width div 2, m_nSayY - nHPY, rc, d, True);
    end;
    if not g_Config.boHideBlueLable then begin
      d := g_WMain3Images.Images[0]; //魔血
      if d <> nil then
        MSurface.Draw(m_nSayX - d.Width div 2, m_nSayY - nMPY, d.ClientRect, d, True);
      d := g_WCqFirImages.Images[1]; //魔血
      if d <> nil then begin
        rc := d.ClientRect;
        if m_Abil.MaxMP > 0 then
          rc.Right := Round((rc.Right - rc.Left) / m_Abil.MaxMP * m_Abil.MP);
        MSurface.Draw(m_nSayX - d.Width div 2, m_nSayY - nMPY, rc, d, True);
      end;
    end;
  end else
    if m_btRace = RCC_MERCHANT then begin
    d := g_WCqFirImages.Images[4];
    if d <> nil then begin
      rc := d.ClientRect;
      if m_Abil.MaxHP > 0 then
        rc.Right := Round((rc.Right - rc.Left) / m_Abil.MaxHP * m_Abil.HP);
      MSurface.Draw(m_nSayX - d.Width div 2, m_nSayY - nHPY, rc, d, True);
    end;
  end else begin
    d := g_WCqFirImages.Images[5];
    if d <> nil then begin
      rc := d.ClientRect;
      if m_Abil.MaxHP > 0 then
        rc.Right := Round((rc.Right - rc.Left) / m_Abil.MaxHP * m_Abil.HP);
      MSurface.Draw(m_nSayX - d.Width div 2, m_nSayY - nHPY, rc, d, True);
    end;
  end;
  end;
end;

procedure TActor.ShowSayMsg(MSurface: TTexture);
var
  I: Integer;
  sStoreName: string;
  Y: Integer;
begin
  with MSurface do begin
    if m_SayingArr[0] <> '' then begin
      if GetTickCount - m_dwSayTime < 4 * 1000 then begin
        for I := 0 to m_nSayLineCount - 1 do begin

          if m_boDeath then begin
            BoldTextOut(
              m_nSayX - (m_SayWidthsArr[I] div 2),
              m_nSayY - 20 - (m_nSayLineCount * 16) + I * 14,
              m_SayingArr[I],
              clGray)
          end else begin
            if m_btRace = RCC_USERHUMAN then begin
              BoldTextOut(
                m_nSayX - (m_SayWidthsArr[I] div 2),
                m_nSayY - 20 - (m_nSayLineCount * 16) + I * 14,
                m_SayingArr[I], GetRGB(g_Config.btHearMsgFColor));

            end else begin
              BoldTextOut(
                m_nSayX - (m_SayWidthsArr[I] div 2),
                m_nSayY - 20 - (m_nSayLineCount * 16) + I * 14,
                m_SayingArr[I], clWhite);
            end;
          end;
        end;
      end else m_SayingArr[0] := ''
    end;

    if m_boStartStore then begin
      if m_btHorse = 0 then begin
        Y := 6 + 14 * 3;
      end else begin //骑马状态修正坐标
        case m_btDir of
          DR_UP,
            DR_UPRIGHT,
            DR_UPLEFT: begin
              Y := 18 + 8 + 14 * 3;
            end;
          DR_DOWN,
            DR_DOWNRIGHT,
            DR_DOWNLEFT: begin
              Y := 18 + 14 * 3;
            end;
          DR_LEFT,
            DR_RIGHT: begin
              Y := 18 + 4 + 14 * 3;
            end;
        end;
      end;
      sStoreName := '【' + m_sUserName + '的摊位】';
      BoldTextOut(
        m_nSayX - TextWidth(sStoreName) div 2,
        m_nSayY + Y, sStoreName, clLime);
    end;
  end;
end;

function TActor.CharWidth: Integer;
begin
  if m_BodySurface <> nil then
    Result := m_BodySurface.Width
  else Result := 48;
end;

function TActor.CharHeight: Integer;
begin
  if m_BodySurface <> nil then
    Result := m_BodySurface.Height
  else Result := 70;
end;

function TActor.CheckSelect(dx, dy: Integer): Boolean;
var
  c: Integer;
begin
  Result := False;
  if m_BodySurface <> nil then begin
    c := m_BodySurface.Pixels[dx, dy];
    if (c <> 0) and
      ((m_BodySurface.Pixels[dx - 1, dy] <> 0) and
      (m_BodySurface.Pixels[dx + 1, dy] <> 0) and
      (m_BodySurface.Pixels[dx, dy - 1] <> 0) and
      (m_BodySurface.Pixels[dx, dy + 1] <> 0)) then
      Result := True;
  end;
end;

procedure TActor.DrawEffSurface(dsurface, source: TTexture; ddx, ddy: Integer; blend: Boolean; ceff: TColorEffect);
begin
  if m_nState and $00800000 <> 0 then begin
    blend := True;
  end;

 { if source.Height > 350 then begin
    DrawEx(dsurface, ddx, ddy, source, 0, 0, source.Width, source.Height, 0);
    Exit; ////thedeath
  end;  }

  if not blend then begin
    if ceff = ceNone then begin
      if source <> nil then
        dsurface.Draw(ddx, ddy, source.ClientRect, source, True);
         {try
            dsurface.Draw (ddx, ddy, source.ClientRect, source, TRUE);
         except
           DebugOutStr ('image to big');
         end;}

    end else begin
      if source <> nil then begin
        {if (source.Width > g_ImgMixSurface.Width) or (source.Height > g_ImgMixSurface.Height) then begin
          g_ImgMixSurface.SetSize(source.Width, source.Height);
        end;}
        g_ImgMixSurface.SetSize(source.Width, source.Height);
        g_ImgMixSurface.Fill(0);
        g_ImgMixSurface.Draw(0, 0, source.ClientRect, source, False);
        DrawEffect(0, 0, g_ImgMixSurface, source, ceff);
        dsurface.Draw(ddx, ddy, source.ClientRect, g_ImgMixSurface, True);
      end;
    end;
  end else begin
    if ceff = ceNone then begin
      if Source <> nil then
        dsurface.FastDrawAlpha(Bounds(ddx, ddy, Source.Width, Source.Height), Source.ClientRect, Source);
    end else begin
      if source <> nil then begin
        g_ImgMixSurface.SetSize(source.Width, source.Height);
        g_ImgMixSurface.Fill(0);
        g_ImgMixSurface.Draw(0, 0, source.ClientRect, source, False);
        DrawEffect(0, 0, g_ImgMixSurface, source, ceff);
        dsurface.FastDrawAlpha(Bounds(ddx, ddy, g_ImgMixSurface.Width, g_ImgMixSurface.Height), g_ImgMixSurface.ClientRect, g_ImgMixSurface);
      end;
    end;
  end;
end;

procedure TActor.DrawWeaponGlimmer(dsurface: TTexture; ddx, ddy: Integer); //武器发光效果
var
  idx, ax, ay: Integer;
  d: TTexture;
begin
//Weapon Glow
  if ((m_btWeapon - m_btSex = 38 * 2) or (m_btWeapon - m_btSex = 56 * 2) or (m_btWeapon - m_btSex = 105 * 2) or (m_btWeapon - m_btSex = 106 * 2) or (m_btWeapon - m_btSex = 107 * 2) or (m_btWeapon - m_btSex = 103 * 2)) and (m_WeaponGlimmerSurface <> nil) then begin
    DrawBlend(dsurface, ddx + m_nWGpx, ddy + m_nWGpy, m_WeaponGlimmerSurface); //武器发光效果
  end;
end;

//人物显示颜色，中毒

function TActor.GetDrawEffectValue: TColorEffect;
var
  ceff: TColorEffect;
begin
  ceff := ceNone;
  if (g_FocusCret = Self) or (g_MagicTarget = Self) then begin
    ceff := ceBright;
  end;
  if m_nState and $80000000 <> 0 then begin
    ceff := ceGreen;
  end;
  if m_nState and $40000000 <> 0 then begin
    ceff := ceRed;
  end;
  if m_nState and $20000000 <> 0 then begin
    ceff := ceBlue;
  end;
  if m_nState and $10000000 <> 0 then begin
    ceff := ceYellow;
  end;
  if m_nState and $08000000 <> 0 then begin
    ceff := ceFuchsia;
  end;
  if m_nState and $04000000 <> 0 then begin
    ceff := ceGrayScale;
  end;
  Result := ceff;
end;

procedure TActor.FreeNameSurface;
var
  I: Integer;
begin
  {for I := 0 to Length(m_NameArr) - 1 do begin
    if m_NameArr[I].Surface <> nil then
      FreeAndNil(m_NameArr[I].Surface);
  end;  }
end;

procedure TActor.NameTextOut(dsurface: TTexture; sName: string; X, Y: Integer; FColor: TColor; BColor: TColor);
var
  I, row: Integer;
  nstr: string;
begin
  row := 0;
  for I := 0 to 10 do begin
    if sName = '' then Break;
    sName := GetValidStr3(sName, nstr, ['\']);
    dsurface.BoldTextOut(
      X - dsurface.TextWidth(nstr) div 2,
      Y + row * 12, nstr, FColor, BColor);
    Inc(row);
  end;
end;

procedure TActor.DrawChr(dsurface: TTexture; dx, dy: Integer; blend: Boolean; boFlag: Boolean);
var
  idx, ax, ay: Integer;
  d: TTexture;
  ceff: TColorEffect;
  wimg: TGameImages;
begin
  d := nil; //jacky
  if not CanDraw then Exit;
  if not (m_btDir in [0..7]) then Exit;
  if GetTickCount - m_dwLoadSurfaceTick > m_dwLoadSurfaceTime then begin
    m_dwLoadSurfaceTick := GetTickCount;
    LoadSurface;
  end;

  ceff := GetDrawEffectValue;

  if m_BodySurface <> nil then begin
    DrawEffSurface(dsurface,
      m_BodySurface,
      dx + m_nPx + m_nShiftX,
      dy + m_nPy + m_nShiftY,
      blend,
      ceff);
  end;

  if m_boUseMagic and (m_CurMagic.EffectNumber > 0) then begin
    if m_nCurEffFrame in [0..m_nSpellFrame - 1] then begin
      GetEffectBase(m_CurMagic.EffectNumber - 1, 0, wimg, idx);
      idx := idx + m_nCurEffFrame;
      if wimg <> nil then
        d := wimg.GetCachedImage(idx, ax, ay);
      if d <> nil then
        DrawBlend(dsurface,
          dx + ax + m_nShiftX,
          dy + ay + m_nShiftY,
          d);
    end;
  end;
end;

procedure TActor.DrawEff(dsurface: TTexture; dx, dy: Integer);
begin

end;

function TActor.GetDefaultFrame(wmode: Boolean): Integer;
var
  cf, dr: Integer;
  pm: pTMonsterAction;
begin
  Result := 0;
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then Exit;
  if m_boDeath then begin
    if m_boSkeleton then
      Result := pm.ActDeath.start
    else Result := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip) + (pm.ActDie.frame - 1);
  end else begin
    m_nDefFrameCount := pm.ActStand.frame;
    if m_nCurrentDefFrame < 0 then cf := 0
    else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
    else cf := m_nCurrentDefFrame;
    Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
  end;
end;

procedure TActor.DefaultMotion;
begin
  m_boReverseFrame := False;
  if m_boWarMode then begin
    if (GetTickCount - m_dwWarModeTime > 4 * 1000) then //and not BoNextTimeFireHit then
      m_boWarMode := False;
  end;
  m_nCurrentFrame := GetDefaultFrame(m_boWarMode);
  Shift(m_btDir, 0, 1, 1);
end;

//人物动作声音(脚步声、武器攻击声)

procedure TActor.SetSound;
var
  cx, cy, bidx, wunit, attackweapon, nIndex: Integer;
  hiter: TActor;
begin
  if m_btRace = 0 then begin
    if (Self = g_MySelf) and
      ((m_nCurrentAction = SM_WALK) or
      (m_nCurrentAction = SM_BACKSTEP) or
      (m_nCurrentAction = SM_RUN) or
      (m_nCurrentAction = SM_HORSERUN) or
      (m_nCurrentAction = SM_RUSH) or
      (m_nCurrentAction = SM_RUSHKUNG)
      )
      then begin
      cx := g_MySelf.m_nCurrX - Map.m_nBlockLeft;
      cy := g_MySelf.m_nCurrY - Map.m_nBlockTop;
      cx := cx div 2 * 2;
      cy := cy div 2 * 2;
      bidx := Map.m_MArr[cx, cy].wBkImg and $7FFF;
      wunit := Map.m_MArr[cx, cy].btArea;
      bidx := wunit * 10000 + bidx - 1;
      case bidx of
        330..349, 450..454, 550..554, 750..754,
          950..954, 1250..1254, 1400..1424, 1455..1474,
          1500..1524, 1550..1574:
          m_nFootStepSound := s_walk_lawn_l;

        250..254, 1005..1009, 1050..1054, 1060..1064, 1450..1454,
          1650..1654:
          m_nFootStepSound := s_walk_rough_l;

        605..609, 650..654, 660..664, 2000..2049,
          3025..3049, 2400..2424, 4625..4649, 4675..4678:
          m_nFootStepSound := s_walk_stone_l;

        1825..1924, 2150..2174, 3075..3099, 3325..3349,
          3375..3399:
          m_nFootStepSound := s_walk_cave_l;

        3230, 3231, 3246, 3277:
          m_nFootStepSound := s_walk_wood_l;

        3780..3799:
          m_nFootStepSound := s_walk_wood_l;

        3825..4434:
          if (bidx - 3825) mod 25 = 0 then m_nFootStepSound := s_walk_wood_l
          else m_nFootStepSound := s_walk_ground_l;

        2075..2099, 2125..2149:
          m_nFootStepSound := s_walk_room_l;

        1800..1824:
          m_nFootStepSound := s_walk_water_l;

      else
        m_nFootStepSound := s_walk_ground_l;
      end;

      if (bidx >= 825) and (bidx <= 1349) then begin
        if ((bidx - 825) div 25) mod 2 = 0 then
          m_nFootStepSound := s_walk_stone_l;
      end;

      if (bidx >= 1375) and (bidx <= 1799) then begin
        if ((bidx - 1375) div 25) mod 2 = 0 then
          m_nFootStepSound := s_walk_cave_l;
      end;
      case bidx of
        1385, 1386, 1391, 1392:
          m_nFootStepSound := s_walk_wood_l;
      end;

      bidx := Map.m_MArr[cx, cy].wMidImg and $7FFF;
      bidx := bidx - 1;
      case bidx of
        0..115:
          m_nFootStepSound := s_walk_ground_l;
        120..124:
          m_nFootStepSound := s_walk_lawn_l;
      end;

      bidx := Map.m_MArr[cx, cy].wFrImg and $7FFF;
      bidx := bidx - 1;
      case bidx of
        221..289, 583..658, 1183..1206, 7163..7295,
          7404..7414:
          m_nFootStepSound := s_walk_stone_l;

        3125..3267, {3319..3345, 3376..3433,} 3757..3948,
          6030..6999:
          m_nFootStepSound := s_walk_wood_l;

        3316..3589:
          m_nFootStepSound := s_walk_room_l;
      end;
      if (m_nCurrentAction = SM_RUN) or (m_nCurrentAction = SM_HORSERUN) then
        m_nFootStepSound := m_nFootStepSound + 2;
    end;

    if m_btSex = 0 then begin
      m_nScreamSound := s_man_struck;
      m_nDieSound := s_man_die;
    end else begin
      m_nScreamSound := s_wom_struck;
      m_nDieSound := s_wom_die;
    end;

    case m_nCurrentAction of
      SM_THROW, SM_HIT, SM_HIT + 1, SM_HIT + 2, SM_POWERHIT, SM_LONGHIT, SM_WIDEHIT, SM_FIREHIT, SM_CRSHIT, SM_TWINHIT, SM_SUPERFIREHIT: begin
          case (m_btWeapon div 2) of
            6, 20: m_nWeaponSound := s_hit_short;
            1: m_nWeaponSound := s_hit_wooden;
            2, 13, 9, 5, 14, 22: m_nWeaponSound := s_hit_sword;
            4, 17, 10, 15, 16, 23: m_nWeaponSound := s_hit_do;
            3, 7, 11: m_nWeaponSound := s_hit_axe;
            24: m_nWeaponSound := s_hit_club;
            8, 12, 18, 21: m_nWeaponSound := s_hit_long;
          else m_nWeaponSound := s_hit_fist;
          end;
        end;
      SM_PKHIT: m_nWeaponSound := 10475;
      SM_KTHIT: m_nWeaponSound := 11002;
      SM_60HIT: m_nWeaponSound := 10510;
      SM_61HIT: m_nWeaponSound := 10510;
      SM_62HIT: m_nWeaponSound := 10511;
      SM_ZRJFHIT: begin
          case m_btSex of
            0: m_nWeaponSound := s_hit_ZRJF_M;
            1: m_nWeaponSound := s_hit_ZRJF_W;
          end;
        end;
      SM_100HIT: begin
          case m_btSex of
            0: m_nWeaponSound := s_cboZs1_start_m;
            1: m_nWeaponSound := s_cboZs1_start_w;
          end;
        end;
      SM_101HIT: m_nWeaponSound := s_cboZs2_start;
      SM_102HIT: begin
          case m_btSex of
            0: m_nWeaponSound := s_cboZs3_start_m;
            1: m_nWeaponSound := s_cboZs3_start_w;
          end;
        end;
      SM_103HIT: m_nWeaponSound := s_cboZs4_start;

      SM_STRUCK: begin
          if m_nMagicStruckSound >= 1 then begin
            //strucksound := s_struck_magic;
          end else begin
            hiter := PlayScene.FindActor(m_nHiterCode);
            attackweapon := 0;
            if hiter <> nil then begin
              attackweapon := hiter.m_btWeapon div 2;
              if hiter.m_btRace = 0 then
                case (m_btDress div 2) of
                  3: case attackweapon of
                      6: m_nStruckSound := s_struck_armor_sword;
                      1, 2, 4, 5, 9, 10, 13, 14, 15, 16, 17: m_nStruckSound := s_struck_armor_sword;
                      3, 7, 11: m_nStruckSound := s_struck_armor_axe;
                      8, 12, 18: m_nStruckSound := s_struck_armor_longstick;
                    else m_nStruckSound := s_struck_armor_fist;
                    end;
                else
                  case attackweapon of
                    6: m_nStruckSound := s_struck_body_sword;
                    1, 2, 4, 5, 9, 10, 13, 14, 15, 16, 17: m_nStruckSound := s_struck_body_sword;
                    3, 7, 11: m_nStruckSound := s_struck_body_axe;
                    8, 12, 18: m_nStruckSound := s_struck_body_longstick;
                  else m_nStruckSound := s_struck_body_fist;
                  end;
                end;
            end;
          end;
        end;
    end;

    if m_boUseMagic and (m_CurMagic.MagicSerial > 0) then begin
      if m_CurMagic.MagicSerial = 41 then begin
        m_nMagicStartSound := 10000 + 43 * 10;
        m_nMagicFireSound := 10000 + 43 * 10 + 1;
        m_nMagicExplosionSound := 10000 + 43 * 10 + 2;
      end else
        if m_CurMagic.MagicSerial = 50 then begin
        m_nMagicStartSound := 10000 + 36 * 10;
        m_nMagicFireSound := 10000 + 36 * 10 + 1;
        m_nMagicExplosionSound := 10000 + 36 * 10 + 2;
      end else
       { if m_CurMagic.MagicSerial in [60, 61] then begin
        m_nMagicStartSound := 10510;
        m_nMagicFireSound := 10511;
        m_nMagicExplosionSound := 10512;
      end else  }
        if m_CurMagic.MagicSerial = 61 then begin
        m_nMagicStartSound := 10510;
        m_nMagicFireSound := 10511;
        m_nMagicExplosionSound := 10512;
      end else
        if m_CurMagic.MagicSerial = 62 then begin
        m_nMagicStartSound := 10520;
        m_nMagicFireSound := 10521;
        m_nMagicExplosionSound := 10522;
      end else
        if m_CurMagic.MagicSerial = 63 then begin
        m_nMagicStartSound := 10530;
        m_nMagicFireSound := 10531;
        m_nMagicExplosionSound := 10532;
      end else
        if m_CurMagic.MagicSerial = 64 then begin
        m_nMagicStartSound := 10540;
        m_nMagicFireSound := 10541;
        m_nMagicExplosionSound := 10542;
      end else
        if m_CurMagic.MagicSerial = 65 then begin
        m_nMagicStartSound := 10550;
        m_nMagicFireSound := 10551;
        m_nMagicExplosionSound := 10552;
      end else
        if m_CurMagic.MagicSerial = 46 then begin
        m_nMagicStartSound := 10461;
        m_nMagicFireSound := 0;
        m_nMagicExplosionSound := 0;
      end else
       { if m_CurMagic.MagicSerial = 66 then begin
        m_nMagicStartSound := 11000;
        m_nMagicFireSound := 0;
        m_nMagicExplosionSound := 11002;
      end else
        if m_CurMagic.MagicSerial = 67 then begin
        m_nMagicStartSound := 11010;
        m_nMagicFireSound := 0;
        m_nMagicExplosionSound := 11012;
      end else }
        if m_CurMagic.MagicSerial = 70 then begin //群体火球
        m_nMagicStartSound := 10000 + 1 * 10;
        m_nMagicFireSound := 10000 + 1 * 10 + 1;
        m_nMagicExplosionSound := 10000 + 1 * 10 + 2;
      end else
        if m_CurMagic.MagicSerial = 71 then begin //群体大火球
        m_nMagicStartSound := 10000 + 5 * 10;
        m_nMagicFireSound := 10000 + 5 * 10 + 1;
        m_nMagicExplosionSound := 10000 + 5 * 10 + 2;
      end else
        if m_CurMagic.MagicSerial = 72 then begin //群体火符术
        m_nMagicStartSound := 10000 + 13 * 10;
        m_nMagicFireSound := 10000 + 13 * 10 + 1;
        m_nMagicExplosionSound := 10000 + 13 * 10 + 2;
      end else
        if m_CurMagic.MagicSerial = 73 then begin //护体神盾
        m_nMagicStartSound := 10000 + 100 * 10;
        m_nMagicFireSound := 10000 + 100 * 10 + 1;
        m_nMagicExplosionSound := 10000 + 100 * 10 + 2;
      end else
        if m_CurMagic.MagicSerial = 74 then begin //空间锁定 困魔咒声音效果
        m_nMagicStartSound := 10000 + 10 * 16;
        m_nMagicFireSound := 10000 + 10 * 16 + 1;
        m_nMagicExplosionSound := 10000 + 10 * 16 + 2;
      end else
        if m_CurMagic.MagicSerial = 75 then begin //流星火雨
        m_nMagicStartSound := 10000 + 10 * 54;
        m_nMagicFireSound := 10000 + 10 * 54 + 1;
        m_nMagicExplosionSound := 10000 + 10 * 54 + 2;
      end else
        if m_CurMagic.MagicSerial = 76 then begin //噬血术
        m_nMagicStartSound := 10000 + 10 * 53;
        m_nMagicFireSound := 10000 + 10 * 53 + 1;
        m_nMagicExplosionSound := 10000 + 10 * 53 + 2;

      end else
        if m_CurMagic.MagicSerial = 104 then begin //双龙破
        m_nMagicStartSound := s_cboFs1_start;
        m_nMagicExplosionSound := s_cboFs1_target;
      end else
        if m_CurMagic.MagicSerial = 105 then begin //凤舞祭
        m_nMagicStartSound := s_cboFs2_start;
        m_nMagicExplosionSound := s_cboFs2_target;
      end else
        if m_CurMagic.MagicSerial = 106 then begin //惊雷爆
        m_nMagicStartSound := s_cboFs3_start;
        m_nMagicExplosionSound := s_cboFs3_target;
      end else
        if m_CurMagic.MagicSerial = 107 then begin //冰天雪地
        m_nMagicStartSound := s_cboFs4_start;
        m_nMagicExplosionSound := s_cboFs4_target;

      end else
        if m_CurMagic.MagicSerial = 108 then begin //虎啸诀
        m_nMagicStartSound := s_cboDs1_start;
        m_nMagicExplosionSound := s_cboDs1_target;
      end else
        if m_CurMagic.MagicSerial = 109 then begin //八卦掌
        m_nMagicStartSound := s_cboDs2_start;
        m_nMagicExplosionSound := s_cboDs2_target;
      end else
        if m_CurMagic.MagicSerial = 110 then begin //三焰咒
        m_nMagicStartSound := s_cboDs3_start;
        m_nMagicExplosionSound := s_cboDs3_target;
      end else
        if m_CurMagic.MagicSerial = 111 then begin //万剑归宗
        m_nMagicStartSound := s_cboDs4_start;
        m_nMagicExplosionSound := s_cboDs4_target;
      end else begin
        m_nMagicStartSound := 10000 + m_CurMagic.MagicSerial * 10;
        m_nMagicFireSound := 10000 + m_CurMagic.MagicSerial * 10 + 1;
        m_nMagicExplosionSound := 10000 + m_CurMagic.MagicSerial * 10 + 2;
      end;
      //DScreen.AddChatBoardString('m_CurMagic.MagicSerial ' + IntToStr(m_CurMagic.MagicSerial), clyellow, clRed);
    end;
  end else begin //怪物声音
    if m_nCurrentAction = SM_STRUCK then begin
      if m_nMagicStruckSound >= 1 then begin
        //strucksound := s_struck_magic;
      end else begin
        hiter := PlayScene.FindActor(m_nHiterCode);
        if hiter <> nil then begin
          attackweapon := hiter.m_btWeapon div 2;
          case attackweapon of
            6: m_nStruckSound := s_struck_body_sword;
            1, 2, 4, 5, 9, 10, 13, 14, 15, 16, 17: m_nStruckSound := s_struck_body_sword;
            3, 11: m_nStruckSound := s_struck_body_axe;
            8, 12, 18: m_nStruckSound := s_struck_body_longstick;
          else m_nStruckSound := s_struck_body_fist;
          end;
        end;
      end;
    end;
    if m_boUseMagic and (m_CurMagic.MagicSerial > 0) then begin
      if m_CurMagic.MagicSerial = 199 then begin //66
        m_nMagicStartSound := 11000;
        m_nMagicFireSound := 0;
        m_nMagicExplosionSound := 11002;
      end else
        if m_CurMagic.MagicSerial = 200 then begin //67
        m_nMagicStartSound := 11010;
        m_nMagicFireSound := 0;
        m_nMagicExplosionSound := 11012;
      end else begin
        m_nMagicStartSound := 10000 + m_CurMagic.MagicSerial * 10;
        m_nMagicFireSound := 10000 + m_CurMagic.MagicSerial * 10 + 1;
        m_nMagicExplosionSound := 10000 + m_CurMagic.MagicSerial * 10 + 2;
      end;
      //DScreen.AddChatBoardString('m_CurMagic.MagicSerial ' + IntToStr(m_CurMagic.MagicSerial), clyellow, clRed);
    end;
    if m_btRace = 50 then begin

    end else begin
      if m_wAppearance = 173 then begin
        m_nAppearSound := 200 + (m_wAppearance - 1) * 10;
        m_nNormalSound := 200 + (m_wAppearance - 1) * 10 + 1;
        m_nAttackSound := 200 + (m_wAppearance - 1) * 10 + 2;
        m_nWeaponSound := 200 + (m_wAppearance - 1) * 10 + 3;
        m_nScreamSound := 200 + (m_wAppearance - 1) * 10 + 4;
        m_nDieSound := 200 + (m_wAppearance - 1) * 10 + 5;
        m_nDie2Sound := 200 + (m_wAppearance - 1) * 10 + 6;
      end else
        if (m_wAppearance >= 270) and (m_wAppearance <= 275) then begin
        case m_wAppearance of
          270, 272, 274: nIndex := 800; //170;
          271, 273, 275: nIndex := 800; //171;
        end;
        m_nAppearSound := 200 + nIndex * 10;
        m_nNormalSound := 200 + nIndex * 10 + 1;
        m_nAttackSound := 200 + nIndex * 10 + 2;
        m_nWeaponSound := 200 + nIndex * 10 + 3;
        m_nScreamSound := 200 + nIndex * 10 + 4;
        m_nDieSound := 200 + nIndex * 10 + 5;
        m_nDie2Sound := 200 + nIndex * 10 + 6;
      end else
        if (m_wAppearance = 280) then begin
        nIndex := 810;
        m_nAppearSound := 200 + nIndex * 10;
        m_nNormalSound := 200 + nIndex * 10 + 1;
        m_nAttackSound := 200 + nIndex * 10 + 2;
        m_nWeaponSound := 200 + nIndex * 10 + 3;
        m_nScreamSound := 200 + nIndex * 10 + 4;
        m_nDieSound := 200 + nIndex * 10 + 5;
        m_nDie2Sound := 200 + nIndex * 10 + 6;
      end else
        if (m_wAppearance >= 290) and (m_wAppearance <= 292) then begin
        {case m_wAppearance of
          290: nIndex := 901;
          291: nIndex := 901;
          292: nIndex := 901;
        end;}
        nIndex := 901;
        m_nAppearSound := 200 + nIndex * 10;
        m_nNormalSound := 200 + nIndex * 10;
        m_nAttackSound := 200 + nIndex * 10;
        m_nWeaponSound := 200 + nIndex * 10;
        m_nScreamSound := 200 + nIndex * 10 + 4;
        m_nDieSound := 200 + nIndex * 10 + 5;
        m_nDie2Sound := 200 + nIndex * 10 + 6;
        m_nFootStepSound := 9210;
      end else begin
        m_nAppearSound := 200 + (m_wAppearance) * 10;
        m_nNormalSound := 200 + (m_wAppearance) * 10 + 1;
        m_nAttackSound := 200 + (m_wAppearance) * 10 + 2;
        m_nWeaponSound := 200 + (m_wAppearance) * 10 + 3;
        m_nScreamSound := 200 + (m_wAppearance) * 10 + 4;
        m_nDieSound := 200 + (m_wAppearance) * 10 + 5;
        m_nDie2Sound := 200 + (m_wAppearance) * 10 + 6;
      end;
    end;
  end;
  if m_nCurrentAction = SM_STRUCK then begin
    hiter := PlayScene.FindActor(m_nHiterCode);
    attackweapon := 0;
    if hiter <> nil then begin
      attackweapon := hiter.m_btWeapon div 2;
      if hiter.m_btRace = 0 then
        case (attackweapon div 2) of
          6, 20: m_nStruckWeaponSound := s_struck_short;
          1: m_nStruckWeaponSound := s_struck_wooden;
          2, 13, 9, 5, 14, 22: m_nStruckWeaponSound := s_struck_sword;
          4, 17, 10, 15, 16, 23: m_nStruckWeaponSound := s_struck_do;
          3, 7, 11: m_nStruckWeaponSound := s_struck_axe;
          24: m_nStruckWeaponSound := s_struck_club;
          8, 12, 18, 21: m_nStruckWeaponSound := s_struck_wooden; //long;
          //else struckweaponsound := s_struck_fist;
        end;
    end;
  end;
end;

procedure TActor.RunSound;
begin
  m_boRunSound := True;
  SetSound;
  case m_nCurrentAction of
    SM_STRUCK: begin
        if (m_nStruckWeaponSound >= 0) then PlaySound(m_nStruckWeaponSound);
        if (m_nStruckSound >= 0) then PlaySound(m_nStruckSound);
        if (m_nScreamSound >= 0) then PlaySound(m_nScreamSound);
      end;
    SM_NOWDEATH: begin
        if (m_nDieSound >= 0) then begin
          PlaySound(m_nDieSound);
          //              if Self.m_btRace = RC_USERHUMAN then
          if Self = g_MySelf then
            PlayBGM(bmg_gameover);
        end;
      end;
    SM_THROW, SM_HIT, SM_FLYAXE, SM_LIGHTING, SM_DIGDOWN: begin
        if m_nAttackSound >= 0 then PlaySound(m_nAttackSound);
      end;
    SM_ALIVE, SM_DIGUP: begin
        SilenceSound;
        PlaySound(m_nAppearSound);
      end;
    SM_SPELL: begin
        PlaySound(m_nMagicStartSound);
      end;
  end;
end;

procedure TActor.RunActSound(frame: Integer);
begin
  if m_boRunSound then begin
    if m_btRace = 0 then begin
      case m_nCurrentAction of
        SM_THROW, SM_HIT, SM_HIT + 1, SM_HIT + 2:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            m_boRunSound := False;
          end;
        SM_POWERHIT:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            if m_btSex = 0 then PlaySound(s_yedo_man)
            else PlaySound(s_yedo_woman);
            m_boRunSound := False;
          end;
        SM_LONGHIT:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            PlaySound(s_longhit);
            m_boRunSound := False;
          end;
        SM_WIDEHIT:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            PlaySound(s_widehit);
            m_boRunSound := False;
          end;
        SM_SUPERFIREHIT, SM_FIREHIT:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            PlaySound(s_firehit);
            m_boRunSound := False;
          end;
        SM_CRSHIT:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            PlaySound(s_firehit); //Damian
            m_boRunSound := False;
          end;
        SM_TWINHIT:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            PlaySound(s_firehit); //Damian
            m_boRunSound := False;
          end;
        SM_KTHIT:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            PlaySound(s_firehit); //Damian
            m_boRunSound := False;
          end;
        SM_PKHIT:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            PlaySound(s_firehit);
            m_boRunSound := False;
          end;
        SM_60HIT, SM_61HIT: begin
            if frame = 2 then begin
              PlaySound(m_nWeaponSound);
              m_boRunSound := FALSE;
            end;
          end;
        SM_ZRJFHIT:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            PlaySound(s_firehit);
            m_boRunSound := False;
          end;
        SM_100HIT..SM_103HIT:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            PlaySound(s_firehit);
            m_boRunSound := False;
          end;
      end;
    end else begin
      if m_btRace = 50 then begin
      end else begin
        if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_TURN) then begin
          if (frame = 1) and (Random(8) = 1) then begin
            PlaySound(m_nNormalSound);
            m_boRunSound := False;
          end;
        end;
        if m_nCurrentAction = SM_HIT then begin
          if (frame = 3) and (m_nAttackSound >= 0) then begin
            PlaySound(m_nWeaponSound);
            m_boRunSound := False;
          end;
        end;
        case m_wAppearance of
          80: begin
              if m_nCurrentAction = SM_NOWDEATH then begin
                if (frame = 2) then begin
                  PlaySound(m_nDie2Sound);
                  m_boRunSound := False;
                end;
              end;
            end;
        end;
      end;
    end;
  end;
end;

procedure TActor.RunFrameAction(frame: Integer);
begin
end;

procedure TActor.ActionEnded;
begin
end;

procedure TActor.Run;
  function MagicTimeOut: Boolean;
  begin
    if Self = g_MySelf then begin
      Result := GetTickCount - m_dwWaitMagicRequest > 3000;
    end else
      Result := GetTickCount - m_dwWaitMagicRequest > 2000;
    if Result then
      m_CurMagic.ServerMagicCode := 0;
  end;
var
  prv: Integer;
  m_dwFrameTimetime: LongWord;
  bofly: Boolean;
begin
  if (m_nCurrentAction = SM_WALK) or
    (m_nCurrentAction = SM_BACKSTEP) or
    (m_nCurrentAction = SM_RUN) or
    (m_nCurrentAction = SM_HORSERUN) or
    (m_nCurrentAction = SM_RUSH) or
    (m_nCurrentAction = SM_RUSHKUNG) or
    (m_nCurrentAction = SM_101HIT)
    then Exit;
  m_boMsgMuch := False;
  if Self <> g_MySelf then begin
    if m_MsgList.Count >= 2 then m_boMsgMuch := True;
  end;
  RunActSound(m_nCurrentFrame - m_nStartFrame);
  RunFrameAction(m_nCurrentFrame - m_nStartFrame);
  prv := m_nCurrentFrame;
  if m_nCurrentAction <> 0 then begin
    if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then
      m_nCurrentFrame := m_nStartFrame;
    if (Self <> g_MySelf) and (m_boUseMagic) then begin
      m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3); //Round(m_dwFrameTime / 1.8);
    end else begin
      if m_boMsgMuch then m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
      else m_dwFrameTimetime := m_dwFrameTime;
    end;
    if GetTickCount - m_dwStartTime > m_dwFrameTimetime then begin
      if m_nCurrentFrame < m_nEndFrame then begin

        if m_boUseMagic then begin
          if (m_nCurEffFrame = m_nSpellFrame - 2) or (MagicTimeOut) then begin
            if (m_CurMagic.ServerMagicCode >= 0) or (MagicTimeOut) then begin
              Inc(m_nCurrentFrame);
              Inc(m_nCurEffFrame);
              m_dwStartTime := GetTickCount;
            end;
          end else begin
            if m_nCurrentFrame < m_nEndFrame - 1 then Inc(m_nCurrentFrame);
            Inc(m_nCurEffFrame);
            m_dwStartTime := GetTickCount;
          end;
        end else begin
          Inc(m_nCurrentFrame);
          m_dwStartTime := GetTickCount;
        end;
      end else begin
        if m_boDelActionAfterFinished then begin

          m_boDelActor := True;
        end;

        if Self = g_MySelf then begin
          if frmMain.ServerAcceptNextAction then begin
            ActionEnded;
            m_nCurrentAction := 0;
            m_boUseMagic := False;
          end;
        end else begin
          ActionEnded;
          m_nCurrentAction := 0;
          m_boUseMagic := False;
        end;
      end;
      if m_boUseMagic then begin
        if m_nCurEffFrame = m_nSpellFrame - 1 then begin
          if m_CurMagic.ServerMagicCode > 0 then begin
            with m_CurMagic do
              PlayScene.NewMagic(Self,
                ServerMagicCode,
                EffectNumber, //Effect
                m_nCurrX,
                m_nCurrY,
                targx,
                targy,
                target,
                EffectType, //EffectType
                Recusion,
                anitime,
                bofly);
            if bofly then
              PlaySound(m_nMagicFireSound)
            else
              PlaySound(m_nMagicExplosionSound);
          end;
          //LatestSpellTime := GetTickCount;
          m_CurMagic.ServerMagicCode := 0;
          m_CurMagic.MagicFire := True;
        end;
      end;
    end;
    if m_wAppearance in [0, 1, 43] then m_nCurrentDefFrame := -10
    else m_nCurrentDefFrame := 0;
    m_dwDefFrameTime := GetTickCount;
  end else begin
    if GetTickCount - m_dwSmoothMoveTime > 200 then begin
      if GetTickCount - m_dwDefFrameTime > 500 then begin
        m_dwDefFrameTime := GetTickCount;
        Inc(m_nCurrentDefFrame);
        if m_nCurrentDefFrame >= m_nDefFrameCount then
          m_nCurrentDefFrame := 0;
      end;
      DefaultMotion;
    end;
  end;
  if prv <> m_nCurrentFrame then begin
    m_dwLoadSurfaceTick := GetTickCount;
    LoadSurface;
  end;
end;

function TActor.CanMove: Boolean;
var
  dwStepMoveTime: LongWord;
begin
  Result := False;
  dwStepMoveTime := 100;
  if Self = g_MySelf then begin
    if g_ServerConfig.boChgSpeed then begin
      dwStepMoveTime := _MAX(100 - Trunc((m_Abil.MoveSpeed * 100) / 100), 5);
    end;
  end;
  if GetTickCount - m_dwMoveTime >= dwStepMoveTime then begin
    m_dwMoveTime := GetTickCount;
    Inc(m_nMoveStepCount);
    if m_nMoveStepCount > 1 then
      m_nMoveStepCount := 0;
    Result := True;
  end;
end;

function TActor.Move(step: Integer): Boolean;
var
  prv, curstep, maxstep: Integer;
  fastmove, normmove: Boolean;
begin
  Result := False;
  fastmove := False;
  normmove := False;
  if (m_nCurrentAction = SM_BACKSTEP) then //or (CurrentAction = SM_RUSH) or (CurrentAction = SM_RUSHKUNG) then
    fastmove := True;
  if (m_nCurrentAction = SM_RUSH) or (m_nCurrentAction = SM_RUSHKUNG) or (m_nCurrentAction = SM_101HIT) then
    normmove := True;
  if (Self = g_MySelf) and (not fastmove) and (not normmove) then begin
    g_boMoveSlow := False;
    g_boAttackSlow := False;
    g_nMoveSlowLevel := 0;
    if m_Abil.Weight > m_Abil.MaxWeight then begin
      g_nMoveSlowLevel := m_Abil.Weight div m_Abil.MaxWeight;
      g_boMoveSlow := True;
    end;
    if m_Abil.WearWeight > m_Abil.MaxWearWeight then begin
      g_nMoveSlowLevel := g_nMoveSlowLevel + m_Abil.WearWeight div m_Abil.MaxWearWeight;
      g_boMoveSlow := True;
    end;
    if m_Abil.HandWeight > m_Abil.MaxHandWeight then begin
      g_boAttackSlow := True;
    end;
    if g_boMoveSlow and (not g_Config.boMoveSlow) and (m_nSkipTick < g_nMoveSlowLevel) then begin
      Inc(m_nSkipTick);
      Exit;
    end else begin
      m_nSkipTick := 0;
    end;
    if (m_nCurrentAction = SM_WALK) or
      (m_nCurrentAction = SM_BACKSTEP) or
      (m_nCurrentAction = SM_RUN) or
      (m_nCurrentAction = SM_HORSERUN) or
      (m_nCurrentAction = SM_RUSH) or
      (m_nCurrentAction = SM_RUSHKUNG)
      then begin
      case (m_nCurrentFrame - m_nStartFrame) of
        1: PlaySound(m_nFootStepSound);
        4: PlaySound(m_nFootStepSound + 1);
      end;
    end;
  end;

  Result := False;
  m_boMsgMuch := False;
  if Self <> g_MySelf then begin
    if m_MsgList.Count >= 2 then m_boMsgMuch := True;
  end;
  prv := m_nCurrentFrame;

  if (m_nCurrentAction = SM_WALK) or
    (m_nCurrentAction = SM_RUN) or
    (m_nCurrentAction = SM_HORSERUN) or
    (m_nCurrentAction = SM_RUSH) or
    (m_nCurrentAction = SM_RUSHKUNG) or
    (m_nCurrentAction = SM_101HIT) then begin

    if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then
      m_nCurrentFrame := m_nStartFrame - 1;

    if m_nCurrentFrame < m_nEndFrame then begin
      Inc(m_nCurrentFrame);

      if (m_nCurrentAction = SM_101HIT) then
        RunActSound(m_nCurrentFrame - m_nStartFrame);

      if m_boMsgMuch and not normmove then //or fastmove then
        if m_nCurrentFrame < m_nEndFrame then
          Inc(m_nCurrentFrame);

      curstep := m_nCurrentFrame - m_nStartFrame + 1;
      maxstep := m_nEndFrame - m_nStartFrame + 1;

      Shift(m_btDir, m_nMoveStep, curstep, maxstep);
      //end;
    end;

    if m_nCurrentFrame >= m_nEndFrame then begin
      if (m_nCurrentAction = SM_101HIT) then begin
        m_boHitEffect := False;
        if Self = g_MySelf then begin
          if frmMain.ServerAcceptNextAction then begin
            if g_boSerieMagicing and (m_nCurrentAction = SM_101HIT) then begin
              frmMain.SendDelayMsg(Self, SM_STARTSERIESPELL_OK, 0, 0, 0, 0, '', 200);
              //frmMain.SendMsg(Self, SM_STARTSERIESPELL_OK, 0, 0, 0, 0, '');
            end;
          end;
        end;
      end;

      if Self = g_MySelf then begin
        if frmMain.ServerAcceptNextAction then begin
          m_nCurrentAction := 0;
          m_boLockEndFrame := True;
          m_dwSmoothMoveTime := GetTickCount;
        end;
      end else begin
        m_nCurrentAction := 0;
        m_boLockEndFrame := True;
        m_dwSmoothMoveTime := GetTickCount;
      end;

      Result := True;
    end;
    if (m_nCurrentAction = SM_RUSH) or (m_nCurrentAction = SM_101HIT) then begin
      if Self = g_MySelf then begin
        g_dwDizzyDelayStart := GetTickCount;
        if g_ServerConfig.boChgSpeed then begin
          {
          case g_Config.dwHitTime of
            1400: g_dwDizzyDelayTime := 300;
            1000: g_dwDizzyDelayTime := 250;
            800: g_dwDizzyDelayTime := 200;
            600: g_dwDizzyDelayTime := 150;
            200: g_dwDizzyDelayTime := 100;
            100: g_dwDizzyDelayTime := 50;
          end;
          }
          g_dwDizzyDelayTime := 300 - Trunc((g_MySelf.m_Abil.AttackSpeed * 300) / 100);
        end else begin
          g_dwDizzyDelayTime := 300;
        end;
      end;
    end;
    if (m_nCurrentAction = SM_RUSHKUNG) then begin
      if m_nCurrentFrame >= m_nEndFrame - 3 then begin
        m_nCurrX := m_nActBeforeX;
        m_nCurrY := m_nActBeforeY;
        m_nRx := m_nCurrX;
        m_nRy := m_nCurrY;
        m_nCurrentAction := 0;
        m_boLockEndFrame := True;
        //m_dwSmoothMoveTime := GetTickCount;
      end;
    end;
    Result := True;
  end;

  if (m_nCurrentAction = SM_BACKSTEP) then begin
    if (m_nCurrentFrame > m_nEndFrame) or (m_nCurrentFrame < m_nStartFrame) then begin
      m_nCurrentFrame := m_nEndFrame + 1;
    end;
    if m_nCurrentFrame > m_nStartFrame then begin
      Dec(m_nCurrentFrame);
      if m_boMsgMuch or fastmove then
        if m_nCurrentFrame > m_nStartFrame then Dec(m_nCurrentFrame);

      curstep := m_nEndFrame - m_nCurrentFrame + 1;
      maxstep := m_nEndFrame - m_nStartFrame + 1;
      Shift(GetBack(m_btDir), m_nMoveStep, curstep, maxstep);
    end;
    if m_nCurrentFrame <= m_nStartFrame then begin
      if Self = g_MySelf then begin
        //if FrmMain.ServerAcceptNextAction then begin
        m_nCurrentAction := 0;
        m_boLockEndFrame := True;
        m_dwSmoothMoveTime := GetTickCount;

        g_dwDizzyDelayStart := GetTickCount;

        g_dwDizzyDelayTime := 1000 - Trunc((g_MySelf.m_Abil.AttackSpeed * 1000) / 100);
        {
        case g_Config.dwHitTime of
          1400: g_dwDizzyDelayTime := 1000;
          1000: g_dwDizzyDelayTime := 800;
          800: g_dwDizzyDelayTime := 600;
          600: g_dwDizzyDelayTime := 400;
          200: g_dwDizzyDelayTime := 200;
          100: g_dwDizzyDelayTime := 100;
        end;
        }
      end else begin
        m_nCurrentAction := 0;
        m_boLockEndFrame := True;
        m_dwSmoothMoveTime := GetTickCount;
      end;
      Result := True;
    end;
    Result := True;
  end;
  if prv <> m_nCurrentFrame then begin
    m_dwLoadSurfaceTick := GetTickCount;
    LoadSurface;
  end;
end;

procedure TActor.MoveFail;
begin
  m_nCurrentAction := 0;
  m_boLockEndFrame := True;
  g_MySelf.m_nCurrX := m_nOldx;
  g_MySelf.m_nCurrY := m_nOldy;
  g_MySelf.m_btDir := m_nOldDir;
  CleanUserMsgs;
end;

function TActor.CanCancelAction: Boolean;
begin
  Result := False;
  if m_nCurrentAction = SM_HIT then
    if not m_boUseEffect then
      Result := True;
end;

procedure TActor.CancelAction;
begin
  m_nCurrentAction := 0;
  m_boLockEndFrame := True;
end;

procedure TActor.CleanCharMapSetting(X, Y: Integer);
begin
  g_MySelf.m_nCurrX := X;
  g_MySelf.m_nCurrY := Y;
  g_MySelf.m_nRx := X;
  g_MySelf.m_nRy := Y;
  m_nOldx := X;
  m_nOldy := Y;
  m_nCurrentAction := 0;
  m_nCurrentFrame := -1;
  CleanUserMsgs;
end;

procedure TActor.Say(Str: string);
var
  I, len, aline, n: Integer;
  dline, temp: string;
  loop: Boolean;
const
  MAXWIDTH = 150;
begin

  m_dwSayTime := GetTickCount;
  m_nSayLineCount := 0;
  n := 0;
  loop := True;
  while loop do begin
    temp := '';
    I := 1;
    len := Length(Str);
    while True do begin
      if I > len then begin
        loop := False;
        Break;
      end;
      if Byte(Str[I]) >= 128 then begin
        temp := temp + Str[I];
        Inc(I);
        if I <= len then temp := temp + Str[I]
        else begin
          loop := False;
          Break;
        end;
      end else
        temp := temp + Str[I];
      aline := frmMain.Canvas.TextWidth(temp);
      if aline > MAXWIDTH then begin
        m_SayingArr[n] := temp;
        m_SayWidthsArr[n] := aline;
        Inc(m_nSayLineCount);
        Inc(n);
        if n >= MAXSAY then begin
          loop := False;
          Break;
        end;
        Str := Copy(Str, I + 1, len - I);
        temp := '';
        Break;
      end;
      Inc(I);
    end;
    if temp <> '' then begin
      if n < MAXWIDTH then begin
        m_SayingArr[n] := temp;
        m_SayWidthsArr[n] := frmMain.Canvas.TextWidth(temp);
        Inc(m_nSayLineCount);
      end;
    end;
  end;
end;

{============================== NPCActor =============================}

procedure TNpcActor.CalcActorFrame;
var
  pm: pTMonsterAction;
  haircount: Integer;
begin
  m_boUseMagic := False;
  m_nCurrentFrame := -1;
  m_nBodyOffset := GetNpcOffset(m_wAppearance);

  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then Exit;
  if m_wAppearance in [73..76] then m_btDir := 0;
  if m_wAppearance in [80..87] then m_btDir := 0;

  m_btDir := m_btDir mod 3;

  if (m_wAppearance = 88) and (not (m_btDir in [0..2])) then m_btDir := 0;

  case m_nCurrentAction of
    SM_TURN: begin
        m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
        m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
        m_dwFrameTime := pm.ActStand.ftime;
        m_dwStartTime := GetTickCount;
        m_nDefFrameCount := pm.ActStand.frame;
        Shift(m_btDir, 0, 0, 1);
        if ((m_wAppearance = 33) or (m_wAppearance = 34)) and not m_boUseEffect then begin
          m_boUseEffect := True;
          m_nEffectFrame := m_nEffectStart;
          m_nEffectEnd := m_nEffectStart + 9;
          m_dwEffectStartTime := GetTickCount();
          m_dwEffectFrameTime := 300;
        end else
          if m_wAppearance in [42..47] then begin
          m_nStartFrame := 20;
          m_nEndFrame := 10;
          m_boUseEffect := True;
          m_nEffectStart := 0;
          m_nEffectFrame := 0;
          m_nEffectEnd := 19;
          m_dwEffectStartTime := GetTickCount();
          m_dwEffectFrameTime := 100;
        end else
          if m_wAppearance = 51 then begin
          m_boUseEffect := True;
          m_nEffectStart := 60;
          m_nEffectFrame := m_nEffectStart;
          m_nEffectEnd := m_nEffectStart + 7;
          m_dwEffectStartTime := GetTickCount();
          m_dwEffectFrameTime := 500;
        end else
          if m_wAppearance = 86 then begin
          m_boUseEffect := True;
          m_nEffectStart := 10;
          m_nEffectFrame := 0;
          m_nEffectEnd := m_nEffectStart + 12;
          m_dwEffectStartTime := GetTickCount();
          m_dwEffectFrameTime := 200;
        end else
          if m_wAppearance = 87 then begin
          m_boUseEffect := True;
          m_nEffectStart := 20;
          m_nEffectFrame := 0;
          m_nEffectEnd := m_nEffectStart + 20;
          m_dwEffectStartTime := GetTickCount();
          m_dwEffectFrameTime := 200;
        end else
          if (m_wAppearance in [57..61]) and (not m_boUseEffect) then begin
          m_boUseEffect := True;
          if m_wAppearance in [57..60] then begin
            m_nEffectStart := m_nStartFrame + abs(60 - m_wAppearance + 1) * 60;
            m_nEffectFrame := m_nEffectStart;
            m_nEffectEnd := m_nEffectStart + abs(60 - m_wAppearance + 1) * 60;
          end else begin
            m_nEffectStart := m_nStartFrame + 60;
            m_nEffectFrame := m_nEffectStart;
            m_nEffectEnd := m_nEffectStart + 60;
          end;
          m_dwEffectStartTime := GetTickCount();
          m_dwEffectFrameTime := m_dwFrameTime;
        end else
          if (m_wAppearance in [62..70]) and (not m_boUseEffect) then begin
          if m_wAppearance <> 64 then m_boUseEffect := True;
          m_nEffectStart := m_nStartFrame + 4;
          m_nEffectFrame := m_nEffectStart;
          m_nEffectEnd := m_nEffectStart + 4;
          m_dwEffectStartTime := GetTickCount();
          m_dwEffectFrameTime := m_dwFrameTime;
        end;
        if not m_boUseEffect then begin //NPC魔法效果
          case m_btWeapon of
            1: begin
                m_boUseEffect := True;
                m_nEffectStart := 110;
                m_nEffectFrame := m_nEffectStart;
                m_nEffectEnd := m_nEffectStart + 16;
                m_dwEffectFrameTime := 100;
              end;
            2: begin
                m_boUseEffect := True;
                m_nEffectStart := 540;
                m_nEffectFrame := m_nEffectStart;
                m_nEffectEnd := m_nEffectStart + 10;
                m_dwEffectFrameTime := 100;
              end;
            3: begin
                m_boUseEffect := True;
                m_nEffectStart := 910;
                m_nEffectFrame := m_nEffectStart;
                m_nEffectEnd := m_nEffectStart + 35;
                m_dwEffectFrameTime := 100;
              end;
          end;
          m_dwEffectStartTime := GetTickCount();
        end;
      end;
    SM_HIT: begin
        case m_wAppearance of
          33, 34, 52: begin
              m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
              m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
              m_dwStartTime := GetTickCount;
              m_nDefFrameCount := pm.ActStand.frame;
            end;
        else begin
            m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
            m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
            m_dwFrameTime := pm.ActAttack.ftime;
            m_dwStartTime := GetTickCount;
            if m_wAppearance = 51 then begin
              m_boUseEffect := True;
              m_nEffectStart := 60;
              m_nEffectFrame := m_nEffectStart;
              m_nEffectEnd := m_nEffectStart + 7;
              m_dwEffectStartTime := GetTickCount();
              m_dwEffectFrameTime := 500;
            end;
          end;
        end;
      end;
    SM_DIGUP: begin
        if m_wAppearance = 52 then begin
          m_bo248 := True;
          m_dwUseEffectTick := GetTickCount + 23000;
          Randomize;
          PlaySound(Random(7) + 146);
          m_boUseEffect := True;
          m_nEffectStart := 60;
          m_nEffectFrame := m_nEffectStart;
          m_nEffectEnd := m_nEffectStart + 11;
          m_dwEffectStartTime := GetTickCount();
          m_dwEffectFrameTime := 100;
        end;
      end;
  end;
end;

constructor TNpcActor.Create;
begin
  inherited;
  m_EffSurface := nil;
  m_boHitEffect := False;
  m_boHitEndEffect := False;
  m_bo248 := False;
end;

procedure TNpcActor.DrawChr(dsurface: TTexture; dx, dy: Integer;
  blend, boFlag: Boolean);
var
  ceff: TColorEffect;
begin
  if not CanDraw then Exit;
  //0 1 2
  m_btDir := m_btDir mod 3;
  if GetTickCount - m_dwLoadSurfaceTick > m_dwLoadSurfaceTime then begin
    m_dwLoadSurfaceTick := GetTickCount;
    LoadSurface;
  end;
  ceff := GetDrawEffectValue;

  if m_BodySurface <> nil then begin
    if m_wAppearance = 51 then begin
      DrawEffSurface(dsurface,
        m_BodySurface,
        dx + m_nPx + m_nShiftX,
        dy + m_nPy + m_nShiftY,
        True,
        ceff);
    end else
      if m_wAppearance in [80..84] then begin
      DrawBlend(dsurface,
        dx + m_nPx + m_nShiftX,
        dy + m_nPy + m_nShiftY,
        m_BodySurface);
    end else begin
      DrawEffSurface(dsurface,
        m_BodySurface,
        dx + m_nPx + m_nShiftX,
        dy + m_nPy + m_nShiftY,
        blend,
        ceff);
    end;
  end;
end;

procedure TNpcActor.DrawEff(dsurface: TTexture; dx, dy: Integer);
begin
  //  inherited;
  if not CanDraw then Exit;
  if m_boUseEffect and (m_EffSurface <> nil) then begin
    DrawBlend(dsurface,
      dx + m_nEffX + m_nShiftX,
      dy + m_nEffY + m_nShiftY,
      m_EffSurface);
  end;
end;

function TNpcActor.GetDefaultFrame(wmode: Boolean): Integer;
var
  cf, dr: Integer;
  pm: pTMonsterAction;
begin
  Result := 0;
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then Exit;
  m_btDir := m_btDir mod 3;
  if m_nCurrentDefFrame < 0 then cf := 0
  else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
  else cf := m_nCurrentDefFrame;
  Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
  //DebugOutStr(IntToStr(Result));
end;

procedure TNpcActor.UnLoadSurface;
begin
  inherited UnLoadSurface;
  m_EffSurface := nil;
end;

procedure TNpcActor.LoadSurface;
var
  NpcImages: TGameImages;
begin
  if m_wAppearance < 300 then NpcImages := g_WNpcImgImages else NpcImages := g_WFirNpcImgImages;

  if m_btRace = 50 then begin
    m_BodySurface := NpcImages.GetCachedImage(m_nBodyOffset + m_nCurrentFrame, m_nPx, m_nPy);
  end;
  if m_wAppearance in [42..47] then
    m_BodySurface := nil;
  if m_boUseEffect then begin
    if m_wAppearance in [33..34] then begin
      m_EffSurface := NpcImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end else if m_wAppearance = 42 then begin
      m_EffSurface := NpcImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX := m_nEffX + 71;
      m_nEffY := m_nEffY + 5;
    end else if m_wAppearance = 43 then begin
      m_EffSurface := NpcImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX := m_nEffX + 71;
      m_nEffY := m_nEffY + 37;
    end else if m_wAppearance = 44 then begin
      m_EffSurface := NpcImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX := m_nEffX + 7;
      m_nEffY := m_nEffY + 12;
    end else if m_wAppearance = 45 then begin
      m_EffSurface := NpcImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX := m_nEffX + 6;
      m_nEffY := m_nEffY + 12;
    end else if m_wAppearance = 46 then begin
      m_EffSurface := NpcImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX := m_nEffX + 7;
      m_nEffY := m_nEffY + 12;
    end else if m_wAppearance = 47 then begin
      m_EffSurface := NpcImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX := m_nEffX + 8;
      m_nEffY := m_nEffY + 12;
    end else if m_wAppearance = 51 then begin
      m_EffSurface := NpcImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end else if m_wAppearance = 52 then begin
      m_EffSurface := NpcImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end else if m_wAppearance = 86 then begin
      m_EffSurface := NpcImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end else if m_wAppearance = 87 then begin
      m_EffSurface := NpcImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end else begin
      if m_btWeapon = 0 then begin
        m_EffSurface := NpcImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY); //增加
      end else begin
        case m_btWeapon of
          1: m_EffSurface := g_WMain2Images.GetCachedImage(m_nEffectFrame, m_nEffX, m_nEffY); //增加NPC魔法效果
          2: m_EffSurface := g_WMagic4Images.GetCachedImage(m_nEffectFrame, m_nEffX, m_nEffY); //增加NPC魔法效果
          3: m_EffSurface := g_WMagic2Images.GetCachedImage(m_nEffectFrame, m_nEffX, m_nEffY); //增加NPC魔法效果
        else m_EffSurface := NpcImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
        end;
      end;
    end;
  end;
end;

procedure TNpcActor.Run;
var
  nEffectFrame: Integer;
  dwEffectFrameTime: LongWord;
begin
  inherited Run;
  nEffectFrame := m_nEffectFrame;
  if (m_wAppearance in [57..70, 87]) then begin
    case m_wAppearance of
      57..61: begin
          m_nEffectFrame := m_nCurrentFrame + 60;
        end;
      62, 63, 65..70: begin
          m_nEffectFrame := m_nCurrentFrame + 4;
        end;
      87: m_nEffectFrame := m_nCurrentFrame + 20;
    end;
  end else begin
    if m_boUseEffect then begin
      if m_boUseMagic then begin
        dwEffectFrameTime := Round(m_dwEffectFrameTime / 3);
      end else dwEffectFrameTime := m_dwEffectFrameTime;
      if GetTickCount - m_dwEffectStartTime > dwEffectFrameTime then begin
        m_dwEffectStartTime := GetTickCount();
        if m_nEffectFrame < m_nEffectEnd then begin
          Inc(m_nEffectFrame);
        end else begin
          if m_bo248 then begin
            if GetTickCount > m_dwUseEffectTick then begin
              m_boUseEffect := False;
              m_bo248 := False;
              m_dwUseEffectTick := GetTickCount();
            end;
            m_nEffectFrame := m_nEffectStart;
          end else m_nEffectFrame := m_nEffectStart;
          m_dwEffectStartTime := GetTickCount();
        end;
      end;
    end;
  end;
  if nEffectFrame <> m_nEffectFrame then begin
    m_dwLoadSurfaceTick := GetTickCount();
    LoadSurface();
  end;
end;

{============================== HUMActor =============================}

constructor THumActor.Create;
begin
  inherited Create;
  m_HairSurface := nil;
  m_WeaponSurface := nil;
  m_HumWinSurface := nil;
  m_WeaponEffectSurface := nil;
  m_HoserSurface := nil;
  m_HumHoserSurface := nil;
  m_HairHoserSurface := nil;
  m_boWeaponEffect := False;
  m_dwFrameTime := 150;
  m_dwFrameTick := GetTickCount();
  m_nFrame := 0;
  m_nHumWinOffset := 0;
  m_nBagCount := 10;
  m_btCastle := 0;
  m_nAngryValue := 0; //愤怒值
  m_nMaxAngryValue := 0; //最大愤怒值
end;

destructor THumActor.Destroy;
begin
  inherited Destroy;
end;

procedure THumActor.ShowActorCastleLable(MSurface: TTexture); //显示沙行会
var
  d: TTexture;
  nY: Integer;
begin
  if (not m_boDeath) and (m_btCastle > 0) then begin
    d := g_WMain3Images.Images[m_btCastle + 294];
    if d <> nil then begin
      if m_btHorse = 0 then begin
        MSurface.Draw(m_nSayX - d.Width div 2, m_nSayY - 24 - 10, d.ClientRect, d, True);
      end else begin
        case m_btDir of
          DR_UP,
            DR_UPRIGHT,
            DR_UPLEFT: begin
              nY := 36 + 8 + 10;
            end;
          DR_DOWN,
            DR_DOWNRIGHT,
            DR_DOWNLEFT: begin
              nY := 36 + 10;
            end;
          DR_LEFT,
            DR_RIGHT: begin
              nY := 36 + 4 + 10;
            end;
        end;
        MSurface.Draw(m_nSayX - d.Width div 2, m_nSayY - nY, d.ClientRect, d, True);
      end;
    end;
  end;
end;

procedure THumActor.CalcActorFrame;
var
  haircount: Integer;
  btHorseDress: Integer;
  btHorse: Byte;
  boLoadSurface: Boolean;
begin
  boLoadSurface := False;
  m_boUseMagic := False;
  m_boHitEndEffect := False;
  m_boHitEffect := False;
  m_nCurrentFrame := -1;

  m_btHair := HAIRfeature(m_nFeature);
  m_btDress := DRESSfeature(m_nFeature);
  m_btWeapon := WEAPONfeature(m_nFeature);
  btHorse := Horsefeature(m_nFeatureEx);
  m_btEffect := Effectfeature(m_nFeatureEx);

  if btHorse <> m_btHorse then begin
    if (m_btHorse = 0) or (btHorse = 0) then begin
      boLoadSurface := True;
    end;
    m_btHorse := btHorse;
  end;

  if m_btHorse = 0 then begin
    m_nBodyOffset := HUMANFRAME * m_btDress;
  end else begin
    btHorseDress := (g_WHumHorseImages.ImageCount div HUMANFRAME) - 1; //计算人物数
    if g_WHumHorseImages.ImageCount mod HUMANFRAME > 0 then Inc(btHorseDress);
    if m_btDress <= btHorseDress then begin
      m_nBodyOffset := HUMANFRAME * m_btDress;
    end else begin
      if m_btSex = 0 then begin
        m_nBodyOffset := HUMANFRAME * (btHorseDress - 1);
      end else begin
        m_nBodyOffset := HUMANFRAME * btHorseDress;
      end;
    end;
    g_TargetCret := nil;
  end;

  m_btHair := (m_btHair - m_btDress mod 2) div 2;

  if m_btHair < 4 then begin
    haircount := -1;
    case m_btDress mod 2 of
      0: haircount := m_btHair * 2;
      1: haircount := m_btHair + 2;
    end;
    if haircount > 0 then
      m_nHairOffset := HUMANFRAME * haircount
    else m_nHairOffset := -1;
  end else begin
    case m_btHair of
      4: m_nHairOffset := 3600;
      5: m_nHairOffset := 4800;
    end;
  end;

  m_nWeaponOffset := HUMANFRAME * m_btWeapon; //(weapon*2 + m_btSex);
  if (m_btEffect = 50) then begin
    m_nHumWinOffset := 352;
  end else
    if m_btEffect <> 0 then begin
    if m_btEffect > 100 then begin
      m_nHumWinOffset := (m_btEffect - 101) * HUMANFRAME;
    end else begin
      m_nHumWinOffset := (m_btEffect - 1) * HUMANFRAME;
    end;
  end;
  case m_nCurrentAction of
    SM_TURN: begin
        m_nStartFrame := HA.ActStand.start + m_btDir * (HA.ActStand.frame + HA.ActStand.skip);
        m_nEndFrame := m_nStartFrame + HA.ActStand.frame - 1;
        m_dwFrameTime := HA.ActStand.ftime;
        m_dwStartTime := GetTickCount;
        m_nDefFrameCount := HA.ActStand.frame;
        Shift(m_btDir, 0, 0, m_nEndFrame - m_nStartFrame + 1);
      end;
    SM_WALK,
      SM_BACKSTEP: begin
        m_nStartFrame := HA.ActWalk.start + m_btDir * (HA.ActWalk.frame + HA.ActWalk.skip);
        m_nEndFrame := m_nStartFrame + HA.ActWalk.frame - 1;
        m_dwFrameTime := HA.ActWalk.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := HA.ActWalk.usetick;
        m_nCurTick := 0;
        //WarMode := FALSE;
        m_nMoveStep := 1;

        if m_nCurrentAction = SM_BACKSTEP then
          Shift(GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1)
        else
          Shift(m_btDir, m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1);
      end;
    SM_RUSH: begin
        if m_nRushDir = 0 then begin
          m_nRushDir := 1;
          m_nStartFrame := HA.ActRushLeft.start + m_btDir * (HA.ActRushLeft.frame + HA.ActRushLeft.skip);
          m_nEndFrame := m_nStartFrame + HA.ActRushLeft.frame - 1;
          m_dwFrameTime := HA.ActRushLeft.ftime;
          m_dwStartTime := GetTickCount;
          m_nMaxTick := HA.ActRushLeft.usetick;
          m_nCurTick := 0;
          m_nMoveStep := 1;
          Shift(m_btDir, 1, 0, m_nEndFrame - m_nStartFrame + 1);
        end else begin
          m_nRushDir := 0;
          m_nStartFrame := HA.ActRushRight.start + m_btDir * (HA.ActRushRight.frame + HA.ActRushRight.skip);
          m_nEndFrame := m_nStartFrame + HA.ActRushRight.frame - 1;
          m_dwFrameTime := HA.ActRushRight.ftime;
          m_dwStartTime := GetTickCount;
          m_nMaxTick := HA.ActRushRight.usetick;
          m_nCurTick := 0;
          m_nMoveStep := 1;
          Shift(m_btDir, 1, 0, m_nEndFrame - m_nStartFrame + 1);
        end;
      end;
    SM_RUSHKUNG: begin
        m_nStartFrame := HA.ActRun.start + m_btDir * (HA.ActRun.frame + HA.ActRun.skip);
        m_nEndFrame := m_nStartFrame + HA.ActRun.frame - 1;
        m_dwFrameTime := HA.ActRun.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := HA.ActRun.usetick;
        m_nCurTick := 0;
        m_nMoveStep := 1;
        Shift(m_btDir, m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1);
      end;
    {SM_BACKSTEP:
       begin
          startframe := pm.ActWalk.start + (pm.ActWalk.frame - 1) + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
          m_nEndFrame := startframe - (pm.ActWalk.frame - 1);
          m_dwFrameTime := pm.ActWalk.ftime;
          m_dwStartTime := GetTickCount;
          m_nMaxTick := pm.ActWalk.UseTick;
          m_nCurTick := 0;
          m_nMoveStep := 1;
          Shift (GetBack(Dir), m_nMoveStep, 0, m_nEndFrame-startframe+1);
       end;  }
    SM_SITDOWN: begin
        m_nStartFrame := HA.ActSitdown.start + m_btDir * (HA.ActSitdown.frame + HA.ActSitdown.skip);
        m_nEndFrame := m_nStartFrame + HA.ActSitdown.frame - 1;
        m_dwFrameTime := HA.ActSitdown.ftime;
        m_dwStartTime := GetTickCount;
      end;
    SM_RUN: begin
        m_nStartFrame := HA.ActRun.start + m_btDir * (HA.ActRun.frame + HA.ActRun.skip);
        m_nEndFrame := m_nStartFrame + HA.ActRun.frame - 1;
        m_dwFrameTime := HA.ActRun.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := HA.ActRun.usetick;
        m_nCurTick := 0;
        m_nMoveStep := 2;
        Shift(m_btDir, m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1);
      end;
    SM_HORSERUN: begin
        m_nStartFrame := HA.ActRun.start + m_btDir * (HA.ActRun.frame + HA.ActRun.skip);
        m_nEndFrame := m_nStartFrame + HA.ActRun.frame - 1;
        m_dwFrameTime := HA.ActRun.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := HA.ActRun.usetick;
        m_nCurTick := 0;
        m_nMoveStep := 3;
        Shift(m_btDir, m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1);
      end;
    SM_THROW: begin
        m_nStartFrame := HA.ActHit.start + m_btDir * (HA.ActHit.frame + HA.ActHit.skip);
        m_nEndFrame := m_nStartFrame + HA.ActHit.frame - 1;
        m_dwFrameTime := HA.ActHit.ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := True;
        m_dwWarModeTime := GetTickCount;
        m_boThrow := True;
        Shift(m_btDir, 0, 0, 1);
      end;

    SM_HIT, SM_POWERHIT, SM_LONGHIT, SM_WIDEHIT, SM_FIREHIT, SM_CRSHIT, SM_TWINHIT, SM_KTHIT, SM_PKHIT, SM_60HIT, SM_61HIT, SM_62HIT, SM_SUPERFIREHIT, SM_ZRJFHIT: begin
        //DScreen.AddChatBoardString( m_sUserName+' m_nCurrentAction:' + IntToStr(m_nCurrentAction), clyellow, clRed);
        m_nStartFrame := HA.ActHit.start + m_btDir * (HA.ActHit.frame + HA.ActHit.skip);
        m_nEndFrame := m_nStartFrame + HA.ActHit.frame - 1;
        m_dwFrameTime := HA.ActHit.ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := True;
        m_dwWarModeTime := GetTickCount;
        if (m_nCurrentAction = SM_POWERHIT) then begin
          m_boHitEffect := True;
          m_nMagLight := 2;
          m_nHitEffectNumber := 1;
        end;
        if (m_nCurrentAction = SM_LONGHIT) then begin
          m_boHitEffect := True;
          m_nMagLight := 2;
          m_nHitEffectNumber := 2;
        end;
        if (m_nCurrentAction = SM_WIDEHIT) then begin
          m_boHitEffect := True;
          m_nMagLight := 2;
          m_nHitEffectNumber := 3;
        end;
        if (m_nCurrentAction = SM_FIREHIT) then begin
          m_boHitEffect := True;
          m_nMagLight := 2;
          m_nHitEffectNumber := 4;
        end;
        if (m_nCurrentAction = SM_CRSHIT) then begin
          m_boHitEffect := True;
          m_nMagLight := 2;
          m_nHitEffectNumber := 6;
        end;
        if (m_nCurrentAction = SM_TWINHIT) then begin
          m_boHitEffect := True;
          m_nMagLight := 2;
          m_nHitEffectNumber := 7;
        end;
        if (m_nCurrentAction = SM_PKHIT) then begin //破空剑
          m_boHitEffect := True;
          m_nMagLight := 2;
          m_nHitEffectNumber := 8;
        end;
        if (m_nCurrentAction = SM_60HIT) then begin //破魂斩
          m_boHitEffect := True;
          m_nMagLight := 2;
          m_nHitEffectNumber := 9;
        end;
        if (m_nCurrentAction = SM_61HIT) then begin //劈星斩
          //m_boHitEffect := True;
          m_nHitEffectNumber := 10;
          m_nCurEffFrame := 0;

          m_CurMagic.ServerMagicCode := -1;
          m_CurMagic.MagicSerial := 61;
          m_CurMagic.EffectNumber := 61;
          m_CurMagic.targx := Self.m_nTargetX;
          m_CurMagic.targy := Self.m_nTargetY;

          m_boUseMagic := True;
          m_nSpellFrame := 10;
          m_nCurEffFrame := 0;
          m_nSpellFrameSkip := 0;
          m_nMagLight := 2;
        end;

        if (m_nCurrentAction = SM_62HIT) then begin //雷霆一击
          m_boHitEffect := True;
          m_nMagLight := 2;
          m_nHitEffectNumber := 11;

          m_CurMagic.ServerMagicCode := -1;
          m_CurMagic.MagicSerial := 62;
          m_CurMagic.EffectNumber := 62;
          m_CurMagic.targx := Self.m_nTargetX;
          m_CurMagic.targy := Self.m_nTargetY;

          m_boUseMagic := True;
          m_nCurEffFrame := 0;
          m_nSpellFrame := 10;
          m_nSpellFrameSkip := 0;
          m_nMagLight := 2;

          //DScreen.AddChatBoardString('m_nCurrentAction = SM_62HIT 雷霆一击:' + IntToStr(m_CurMagic.EffectNumber), clyellow, clRed);
        end;

        if (m_nCurrentAction = SM_KTHIT) then begin //开天斩
          m_boHitEffect := True;
          m_nMagLight := 2;
          m_nHitEffectNumber := 12;
        end;

        if (m_nCurrentAction = SM_SUPERFIREHIT) then begin //4级烈火
          m_boHitEffect := True;
          m_nMagLight := 2;
          m_nHitEffectNumber := 13;
        end;
        if (m_nCurrentAction = SM_ZRJFHIT) then begin //逐日剑法
          m_boHitEffect := True;
          m_nMagLight := 2;
          m_nHitEffectNumber := 14;
        end;
        Shift(m_btDir, 0, 0, 1);
      end;

    SM_100HIT: begin //三绝杀
        m_nStartFrame := HA.ActSerieHit[2].start + m_btDir * (HA.ActSerieHit[2].frame + HA.ActSerieHit[2].skip);
        m_nEndFrame := m_nStartFrame + HA.ActSerieHit[2].frame - 1;
        m_dwFrameTime := HA.ActSerieHit[2].ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := True;
        m_dwWarModeTime := GetTickCount;

        m_nMagLight := 2;
        m_nHitEffectNumber := 20;
        m_boHitEffect := True;
      end;

    SM_101HIT: begin //追心刺
        m_nStartFrame := HA.ActSerieHit[1].start + m_btDir * (HA.ActSerieHit[1].frame + HA.ActSerieHit[1].skip);
        m_nEndFrame := m_nStartFrame + HA.ActSerieHit[1].frame - 1;
        m_dwFrameTime := HA.ActSerieHit[1].ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := True;
        m_dwWarModeTime := GetTickCount;
        m_nMagLight := 2;
        m_nHitEffectNumber := 21;
        m_boHitEffect := True;
        //Shift(m_btDir, 0, 0, 1);
        Shift(m_btDir, 1, 0, m_nEndFrame - m_nStartFrame + 1);
      end;

    SM_102HIT: begin //断岳斩
        m_nStartFrame := HA.ActSerieHit[3].start + m_btDir * (HA.ActSerieHit[3].frame + HA.ActSerieHit[3].skip);
        m_nEndFrame := m_nStartFrame + HA.ActSerieHit[3].frame - 1;
        m_dwFrameTime := HA.ActSerieHit[3].ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := True;
        m_dwWarModeTime := GetTickCount;
        m_nMagLight := 2;
        m_nHitEffectNumber := 22;
        m_boHitEffect := True;
      end;

    SM_103HIT: begin //横扫千军
        m_nStartFrame := HA.ActSerieHit[5].start + m_btDir * (HA.ActSerieHit[5].frame + HA.ActSerieHit[5].skip);
        m_nEndFrame := m_nStartFrame + HA.ActSerieHit[5].frame - 1;
        m_dwFrameTime := HA.ActSerieHit[5].ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := True;
        m_dwWarModeTime := GetTickCount;
        m_nMagLight := 2;
        m_nHitEffectNumber := 23;
        m_boHitEffect := True;
      end;

    SM_HEAVYHIT: begin
        m_nStartFrame := HA.ActHeavyHit.start + m_btDir * (HA.ActHeavyHit.frame + HA.ActHeavyHit.skip);
        m_nEndFrame := m_nStartFrame + HA.ActHeavyHit.frame - 1;
        m_dwFrameTime := HA.ActHeavyHit.ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := True;
        m_dwWarModeTime := GetTickCount;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_BIGHIT: begin
        m_nStartFrame := HA.ActBigHit.start + m_btDir * (HA.ActBigHit.frame + HA.ActBigHit.skip);
        m_nEndFrame := m_nStartFrame + HA.ActBigHit.frame - 1;
        m_dwFrameTime := HA.ActBigHit.ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := True;
        m_dwWarModeTime := GetTickCount;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_SPELL: begin
        m_boUseMagic := True;
        m_dwStartTime := GetTickCount;
        m_nCurEffFrame := 0;
        if m_CurMagic.EffectNumber in [104..111] then begin
          case m_CurMagic.EffectNumber of
            104: begin //双龙破
                m_nStartFrame := HA.ActSerieHit[11].start + m_btDir * (HA.ActSerieHit[11].frame + HA.ActSerieHit[11].skip);
                m_nEndFrame := m_nStartFrame + HA.ActSerieHit[11].frame - 1;
                m_dwFrameTime := HA.ActSerieHit[11].ftime;
                m_nMagLight := 4;
                m_nSpellFrame := 11;
                m_nSpellFrameSkip := 9;
              end;

            105: begin //凤舞祭
                m_nStartFrame := HA.ActSerieHit[5].start + m_btDir * (HA.ActSerieHit[5].frame + HA.ActSerieHit[5].skip);
                m_nEndFrame := m_nStartFrame + HA.ActSerieHit[5].frame - 1;
                m_dwFrameTime := HA.ActSerieHit[5].ftime;
                m_nMagLight := 4;
                m_nSpellFrame := 10;
                m_nSpellFrameSkip := 0;
              end;
            106: begin //惊雷爆
                m_nStartFrame := HA.ActSerieHit[14].start + m_btDir * (HA.ActSerieHit[14].frame + HA.ActSerieHit[14].skip);
                m_nEndFrame := m_nStartFrame + HA.ActSerieHit[14].frame - 1;
                m_dwFrameTime := HA.ActSerieHit[14].ftime;
                m_nMagLight := 4;
                m_nSpellFrame := 10;
                m_nSpellFrameSkip := 0;
              end;

            107: begin //冰天雪地
                m_nStartFrame := HA.ActSerieHit[8].start + m_btDir * (HA.ActSerieHit[8].frame + HA.ActSerieHit[8].skip);
                m_nEndFrame := m_nStartFrame + HA.ActSerieHit[8].frame - 1;
                m_dwFrameTime := HA.ActSerieHit[8].ftime;
                m_nMagLight := 4;
                m_nSpellFrame := 10;
                m_nSpellFrameSkip := 0;
              end;

            108: begin //虎啸诀
                m_nStartFrame := HA.ActSerieHit[12].start + m_btDir * (HA.ActSerieHit[12].frame + HA.ActSerieHit[12].skip);
                m_nEndFrame := m_nStartFrame + HA.ActSerieHit[12].frame - 1;
                m_dwFrameTime := HA.ActSerieHit[12].ftime;
                m_nMagLight := 4;
                m_nSpellFrame := 10;
                m_nSpellFrameSkip := 0;
              end;
            109: begin //八卦掌
                m_nStartFrame := HA.ActSerieHit[15].start + m_btDir * (HA.ActSerieHit[15].frame + HA.ActSerieHit[15].skip);
                m_nEndFrame := m_nStartFrame + HA.ActSerieHit[15].frame - 1;
                m_dwFrameTime := HA.ActSerieHit[15].ftime;
                m_nMagLight := 4;
                m_nSpellFrame := 12;
                m_nSpellFrameSkip := 8;
              end;
            110: begin //三焰咒
                m_nStartFrame := HA.ActSerieHit[16].start + m_btDir * (HA.ActSerieHit[16].frame + HA.ActSerieHit[16].skip);
                m_nEndFrame := m_nStartFrame + HA.ActSerieHit[16].frame - 1;
                m_dwFrameTime := HA.ActSerieHit[16].ftime;
                m_nMagLight := 4;
                m_nSpellFrame := 12;
                m_nSpellFrameSkip := 8;
              end;
            111: begin //万剑归宗
                m_nStartFrame := HA.ActSerieHit[17].start + m_btDir * (HA.ActSerieHit[17].frame + HA.ActSerieHit[17].skip);
                m_nEndFrame := m_nStartFrame + HA.ActSerieHit[17].frame - 1;
                m_dwFrameTime := HA.ActSerieHit[17].ftime;
                m_nMagLight := 4;
                m_nSpellFrame := 14;
                m_nSpellFrameSkip := 6;
              end;
          end;

        end else begin
          m_nStartFrame := HA.ActSpell.start + m_btDir * (HA.ActSpell.frame + HA.ActSpell.skip);
          m_nEndFrame := m_nStartFrame + HA.ActSpell.frame - 1;
          m_dwFrameTime := HA.ActSpell.ftime;

          if m_CurMagic.EffectNumber = 50 then begin //分身术
            m_nStartFrame := HA.ActStand.start + m_btDir * (HA.ActStand.frame + HA.ActStand.skip);
            m_nEndFrame := m_nStartFrame + HA.ActStand.frame - 1;
            m_dwFrameTime := HA.ActSpell.ftime;
            m_dwStartTime := GetTickCount;
            m_nDefFrameCount := HA.ActStand.frame;
            Shift(m_btDir, 0, 0, m_nEndFrame - m_nStartFrame + 1);
          end;
          case m_CurMagic.EffectNumber of
            22: begin //?火墙 地狱雷光
                m_nMagLight := 4;
                m_nSpellFrame := 10;
                m_nSpellFrameSkip := 0;
              end;
            26: begin //心灵启示
                m_nMagLight := 2;
                m_nSpellFrame := 20;
                m_nSpellFrameSkip := 0;
                m_dwFrameTime := m_dwFrameTime div 2;
              end;
            31: begin //魔法盾
                m_nMagLight := 2;
                m_nSpellFrame := DEFSPELLFRAME;
                m_nSpellFrameSkip := 0;
              end;
            35: begin //无极真气
                m_nMagLight := 2;

                m_nSpellFrame := 15;
                m_nSpellFrameSkip := 0;
              end;
            43: begin //狮子吼
                m_nMagLight := 2;
                m_nSpellFrame := 20;
                m_nSpellFrameSkip := 0;
              end;
            51: begin //流星火雨
                m_nMagLight := 2;
                m_nSpellFrame := 10;
                m_nSpellFrameSkip := 0;
              //m_dwFrameTime := m_dwFrameTime div 60;
              end;
          else begin
              m_nMagLight := 2;
              m_nSpellFrame := DEFSPELLFRAME;
              m_nSpellFrameSkip := 0;
            end;
          end;
        end;
        m_dwWaitMagicRequest := GetTickCount;
        m_boWarMode := True;
        m_dwWarModeTime := GetTickCount;
        Shift(m_btDir, 0, 0, 1);
      end;
    (*SM_READYFIREHIT:
       begin
          startframe := HA.ActFireHitReady.start + Dir * (HA.ActFireHitReady.frame + HA.ActFireHitReady.skip);
          m_nEndFrame := startframe + HA.ActFireHitReady.frame - 1;
          m_dwFrameTime := HA.ActFireHitReady.ftime;
          m_dwStartTime := GetTickCount;

          BoHitEffect := TRUE;
          HitEffectNumber := 4;
          MagLight := 2;

          CurGlimmer := 0;
          MaxGlimmer := 6;

          WarMode := TRUE;
          WarModeTime := GetTickCount;
          Shift (Dir, 0, 0, 1);
       end; *)
    SM_STRUCK: begin
        m_nStartFrame := HA.ActStruck.start + m_btDir * (HA.ActStruck.frame + HA.ActStruck.skip);
        m_nEndFrame := m_nStartFrame + HA.ActStruck.frame - 1;
        m_dwFrameTime := m_dwStruckFrameTime; //HA.ActStruck.ftime;
        m_dwStartTime := GetTickCount;
        Shift(m_btDir, 0, 0, 1);
        m_dwGenAnicountTime := GetTickCount;
        m_nCurBubbleStruck := 0;
      end;
    SM_NOWDEATH: begin
        m_nStartFrame := HA.ActDie.start + m_btDir * (HA.ActDie.frame + HA.ActDie.skip);
        m_nEndFrame := m_nStartFrame + HA.ActDie.frame - 1;
        m_dwFrameTime := HA.ActDie.ftime;
        m_dwStartTime := GetTickCount;
      end;
  end;
  if boLoadSurface then begin
    m_dwLoadSurfaceTick := GetTickCount();
    LoadSurface;
  end;
end;

procedure THumActor.DefaultMotion;
begin
  inherited DefaultMotion;
  if m_btHorse = 0 then begin
    if (m_btEffect = 50) then begin
      if (m_nCurrentFrame <= 536) then begin
        if (GetTickCount - m_dwFrameTick) > 100 then begin
          if m_nFrame < 19 then Inc(m_nFrame)
          else begin
            if not m_bo2D0 then m_bo2D0 := True
            else m_bo2D0 := False;
            m_nFrame := 0;
          end;
          m_dwFrameTick := GetTickCount();
        end;
        m_HumWinSurface := g_WEffectImg.GetCachedImage(m_nHumWinOffset + m_nFrame, m_nSpx, m_nSpy);
      end;
    end else
      if (m_btEffect <> 0) then begin
      if m_nCurrentFrame < 64 then begin
        if (GetTickCount - m_dwFrameTick) > m_dwFrameTime then begin
          if m_nFrame < 7 then Inc(m_nFrame)
          else m_nFrame := 0;
          m_dwFrameTick := GetTickCount();
        end;
        if ((m_nCurrentAction >= SM_100HIT) and (m_nCurrentAction <= SM_103HIT)) or ((m_nCurrentAction = SM_SPELL) and (m_CurMagic.EffectNumber in [104..111])) then begin
          m_HumWinSurface := g_cboHumWingImages.GetCachedImage(m_nHumWinOffset + (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
        end else begin
          if ((m_btEffect >= 100) and (m_btEffect <= 149)) then begin
            m_HumWinSurface := g_WHum2WingImages.GetCachedImage(m_nHumWinOffset + (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
            //DScreen.AddChatBoardString ('HumEffect1: ' + IntToStr(m_btEffect), clBlue, clWhite);

         end else begin
          {if m_btEffect >= 150 then begin
            m_HumWinSurface := g_WHum2WingImages.GetCachedImage(m_nHumWinOffset + (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
            //DScreen.AddChatBoardString ('HumEffect2: ' + IntToStr(m_btEffect), clBlue, clWhite);
            end else begin  }

            m_HumWinSurface := g_WHumWingImages.GetCachedImage(m_nHumWinOffset + (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
            //DScreen.AddChatBoardString ('HumEffect: ' + IntToStr(m_btEffect), clBlue, clWhite);

          //end;
        end;
      end;
      end else begin
        if ((m_nCurrentAction >= SM_100HIT) and (m_nCurrentAction <= SM_103HIT)) or ((m_nCurrentAction = SM_SPELL) and (m_CurMagic.EffectNumber in [104..111])) then begin
          m_HumWinSurface := g_cboHumWingImages.GetCachedImage(m_nHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy);
        end else begin
           if ((m_btEffect >= 100) and (m_btEffect <= 149)) then begin
            m_HumWinSurface := g_WHum2WingImages.GetCachedImage(m_nHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy);
           //DScreen.AddChatBoardString ('HumEffect1: ' + IntToStr(m_btEffect), clBlue, clWhite);

          end else begin
          {if m_btEffect >= 150 then begin
            m_HumWinSurface := g_WHum2WingImages.GetCachedImage(m_nHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy);
          //DScreen.AddChatBoardString ('HumEffect2: ' + IntToStr(m_btEffect), clBlue, clWhite);
          end else begin  }

            m_HumWinSurface := g_WHumWingImages.GetCachedImage(m_nHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy);
          // DScreen.AddChatBoardString ('HumEffect: ' + IntToStr(m_btEffect), clBlue, clWhite);

          //end;
          end;
        end;
      end;
    end;
  end;
end;

function THumActor.GetDefaultFrame(wmode: Boolean): Integer;
var
  cf, dr: Integer;
  pm: pTMonsterAction;
begin
  //GlimmingMode := FALSE;
  //dr := Dress div 2;            //HUMANFRAME * (dr)
  if m_boDeath then
    Result := HA.ActDie.start + m_btDir * (HA.ActDie.frame + HA.ActDie.skip) + (HA.ActDie.frame - 1)
  else
    if wmode then begin
    //GlimmingMode := TRUE;
    Result := HA.ActWarMode.start + m_btDir * (HA.ActWarMode.frame + HA.ActWarMode.skip);
  end else begin
    m_nDefFrameCount := HA.ActStand.frame;
    if m_nCurrentDefFrame < 0 then cf := 0
    else if m_nCurrentDefFrame >= HA.ActStand.frame then cf := 0 //HA.ActStand.frame-1
    else cf := m_nCurrentDefFrame;
    Result := HA.ActStand.start + m_btDir * (HA.ActStand.frame + HA.ActStand.skip) + cf;
  end;
end;

procedure THumActor.RunFrameAction(frame: Integer);
var
  meff: TMapEffect;
  Event: TEvent;
  mfly: TFlyingAxe;
begin
  m_boHideWeapon := False;
  if m_nCurrentAction = SM_HEAVYHIT then begin
    if (frame = 5) and (m_boDigFragment) then begin
      m_boDigFragment := False;
      meff := TMapEffect.Create(8 * m_btDir, 3, m_nCurrX, m_nCurrY);
      meff.ImgLib := g_WEffectImg;
      meff.NextFrameTime := 80;
      PlaySound(s_strike_stone);
      //PlaySound (s_drop_stonepiece);
      PlayScene.m_EffectList.Add(meff);
      Event := EventMan.GetEvent(m_nCurrX, m_nCurrY, ET_PILESTONES);
      if Event <> nil then
        Event.m_nEventParam := Event.m_nEventParam + 1;
    end;
  end;
  if m_nCurrentAction = SM_THROW then begin
    if (frame = 3) and (m_boThrow) then begin
      m_boThrow := False;
      mfly := TFlyingAxe(PlayScene.NewFlyObject(Self,
        m_nCurrX,
        m_nCurrY,
        m_nTargetX,
        m_nTargetY,
        m_nTargetRecog,
        mtFlyAxe));
      if mfly <> nil then begin
        TFlyingAxe(mfly).ReadyFrame := 40;
        mfly.ImgLib := g_WMonImages.Indexs[3]; //3
        mfly.FlyImageBase := FLYOMAAXEBASE;
      end;
    end;
    if frame >= 3 then
      m_boHideWeapon := True;
  end;
end;

procedure THumActor.DoWeaponBreakEffect;
begin
  m_boWeaponEffect := True;
  m_nCurWeaponEffect := 0;
end;

procedure THumActor.Run;
  function MagicTimeOut: Boolean;
  begin
    if Self = g_MySelf then begin
      Result := (GetTickCount - m_dwWaitMagicRequest > 3000);
    end else
      Result := (GetTickCount - m_dwWaitMagicRequest > 2000);
    if Result then begin
      m_CurMagic.ServerMagicCode := 0;
    end;
  end;
var
  I, prv: Integer;
  m_dwFrameTimetime: LongWord;
  bofly: Boolean;
begin
  if GetTickCount - m_dwGenAnicountTime > 120 then begin
    m_dwGenAnicountTime := GetTickCount;
    Inc(m_nGenAniCount);
    if m_nGenAniCount > 100000 then m_nGenAniCount := 0;
    Inc(m_nCurBubbleStruck);
  end;
  if m_boWeaponEffect then begin
    if GetTickCount - m_dwWeaponpEffectTime > 120 then begin
      m_dwWeaponpEffectTime := GetTickCount;
      Inc(m_nCurWeaponEffect);
      if m_nCurWeaponEffect >= MAXWPEFFECTFRAME then
        m_boWeaponEffect := False;
    end;
  end;
  if (m_nCurrentAction = SM_WALK) or
    (m_nCurrentAction = SM_BACKSTEP) or
    (m_nCurrentAction = SM_RUN) or
    (m_nCurrentAction = SM_HORSERUN) or
    (m_nCurrentAction = SM_RUSH) or
    (m_nCurrentAction = SM_RUSHKUNG) or
    (m_nCurrentAction = SM_101HIT)
    then Exit;
  m_boMsgMuch := False;
  if Self <> g_MySelf then begin
    if m_MsgList.Count >= 2 then m_boMsgMuch := True;
  end;
  RunActSound(m_nCurrentFrame - m_nStartFrame);
  RunFrameAction(m_nCurrentFrame - m_nStartFrame);

//新增加攻击效果
  if m_boHitEndEffect then begin
    if (m_nCurrentHitFrame < m_nStartHitFrame) or (m_nCurrentHitFrame > m_nEndHitFrame) then
      m_nCurrentHitFrame := m_nStartHitFrame;

    if GetTickCount - m_dwStartHitTime > m_dwHitFrameTime then begin
      m_dwStartHitTime := GetTickCount;
      if m_nCurrentHitFrame < m_nEndHitFrame then begin
        Inc(m_nCurrentHitFrame);
      end else begin
        m_boHitEndEffect := False;
      end;
    end;
  end;

  prv := m_nCurrentFrame;

  if m_nCurrentAction <> 0 then begin
    if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then
      m_nCurrentFrame := m_nStartFrame;

    if (Self <> g_MySelf) and (m_boUseMagic) then begin
      m_dwFrameTimetime := Round(m_dwFrameTime / 1.8);
    end else begin
      if m_boMsgMuch then m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
      else m_dwFrameTimetime := m_dwFrameTime;
    end;
    if GetTickCount - m_dwStartTime > m_dwFrameTimetime then begin
      if m_nCurrentFrame < m_nEndFrame then begin
        if m_boUseMagic then begin
          if (m_nCurEffFrame = m_nSpellFrame - 2) or (MagicTimeOut) then begin
            if (m_CurMagic.ServerMagicCode >= 0) or (MagicTimeOut) then begin
              Inc(m_nCurrentFrame);
              Inc(m_nCurEffFrame);
              m_dwStartTime := GetTickCount;
            end;
          end else begin
            if (m_nCurrentFrame < m_nEndFrame - 1) or m_CurMagic.MagicFire then
              Inc(m_nCurrentFrame);
            Inc(m_nCurEffFrame);
            m_dwStartTime := GetTickCount;
          end;
        end else begin

          Inc(m_nCurrentFrame);
          m_dwStartTime := GetTickCount;
        end;
      end else begin
        if Self = g_MySelf then begin
          if frmMain.ServerAcceptNextAction then begin
            if g_boSerieMagicing and (((m_nCurrentAction >= SM_100HIT) and (m_nCurrentAction <= SM_103HIT)) or ((m_nCurrentAction = SM_SPELL) and (m_CurMagic.EffectNumber in [104..111]))) then begin
              frmMain.SendDelayMsg(Self, SM_STARTSERIESPELL_OK, 0, 0, 0, 0, '', 200);
              //frmMain.SendMsg(Self, SM_STARTSERIESPELL_OK, 0, 0, 0, 0, '');
            end;
            m_nCurrentAction := 0;
            m_boUseMagic := False;
          end;
        end else begin
          m_nCurrentAction := 0;
          m_boUseMagic := False;
        end;

        if m_boHitEffect and not m_boHitEndEffect then begin //新增加攻击效果
          if m_nHitEffectNumber = 8 then begin //破空剑
            m_btHitDir := m_btDir;
            m_nStartPosHitFrame := 8;
            m_nHitEndX := m_nShiftX;
            m_nHitEndY := m_nShiftY;
            m_nStartHitFrame := 0;
            m_nEndHitFrame := m_nStartHitFrame + 10;
            m_nCurrentHitFrame := m_nStartHitFrame;
            m_dwHitFrameTime := Round(m_dwFrameTime * 2 / 3);
            m_boHitEndEffect := True;
            //DScreen.AddChatBoardString('破空剑', clGreen, clWhite);
          end else
            if m_nHitEffectNumber = 9 then begin //破魂斩
            m_btHitDir := m_btDir;
            m_nStartPosHitFrame := 8;
            m_nHitEndX := m_nShiftX;
            m_nHitEndY := m_nShiftY;
            m_nStartHitFrame := 0;
            m_nEndHitFrame := m_nStartHitFrame + 10;
            m_nCurrentHitFrame := m_nStartHitFrame;
            m_dwHitFrameTime := Round(m_dwFrameTime * 2 / 3);
            m_boHitEndEffect := True;
          end else
            if m_nHitEffectNumber = 12 then begin //开天斩
            m_btHitDir := m_btDir;
            m_nStartPosHitFrame := 85;
            m_nHitEndX := m_nShiftX;
            m_nHitEndY := m_nShiftY;
            m_nStartHitFrame := 0;
            m_nEndHitFrame := m_nStartHitFrame + 9;
            m_nCurrentHitFrame := m_nStartHitFrame;
            m_dwHitFrameTime := Round(m_dwFrameTime * 2 / 3);
            m_boHitEndEffect := True;
          end;
        end;
        m_boHitEffect := False;
      end;

      if m_boUseMagic then begin
        if (m_CurMagic.EffectNumber = 110) and (m_nCurEffFrame <> m_nSpellFrame - 1) then begin //三焰咒
          if (m_nCurEffFrame >= 5) and (m_nCurEffFrame <= 9) and (m_nCurEffFrame mod 2 <> 0) then begin
            if m_CurMagic.ServerMagicCode > 0 then begin
              with m_CurMagic do
                PlayScene.NewMagic(Self,
                  ServerMagicCode,
                  EffectNumber,
                  m_nCurrX,
                  m_nCurrY,
                  targx,
                  targy,
                  target,
                  EffectType,
                  Recusion,
                  anitime,
                  bofly);
              if bofly then
                PlaySound(m_nMagicFireSound)
              else
                PlaySound(m_nMagicExplosionSound);
            end;
            if Self = g_MySelf then
              g_dwLatestSpellTick := GetTickCount;
          end;
        end;

        if (m_nCurEffFrame = m_nSpellFrame - 1) then begin
          if (m_CurMagic.EffectNumber = 110) then begin //三焰咒
            m_CurMagic.ServerMagicCode := 0;
            m_CurMagic.MagicFire := True;
          end;
          if m_CurMagic.ServerMagicCode > 0 then begin
            with m_CurMagic do
              PlayScene.NewMagic(Self,
                ServerMagicCode,
                EffectNumber,
                m_nCurrX,
                m_nCurrY,
                targx,
                targy,
                target,
                EffectType,
                Recusion,
                anitime,
                bofly);
            if bofly then
              PlaySound(m_nMagicFireSound)
            else
              PlaySound(m_nMagicExplosionSound);
          end;
          if Self = g_MySelf then
            g_dwLatestSpellTick := GetTickCount;
          m_CurMagic.ServerMagicCode := 0;
          m_CurMagic.MagicFire := True;
        end;

      end;
    end;
    if m_btRace = 0 then m_nCurrentDefFrame := 0
    else m_nCurrentDefFrame := -10;
    m_dwDefFrameTime := GetTickCount;
  end else begin
    if GetTickCount - m_dwSmoothMoveTime > 200 then begin
      if GetTickCount - m_dwDefFrameTime > 500 then begin
        m_dwDefFrameTime := GetTickCount;
        Inc(m_nCurrentDefFrame);
        if m_nCurrentDefFrame >= m_nDefFrameCount then
          m_nCurrentDefFrame := 0;
      end;
      DefaultMotion;
    end;
  end;
  if prv <> m_nCurrentFrame then begin
    m_dwLoadSurfaceTick := GetTickCount;
    LoadSurface;
  end;
end;

function THumActor.light: Integer;
var
  L: Integer;
begin
  L := m_nChrLight;
  if L < m_nMagLight then begin
    if m_boUseMagic or m_boHitEffect then
      L := m_nMagLight;
  end;
  Result := L;
end;

procedure THumActor.UnLoadSurface;
begin
  inherited UnLoadSurface;
  m_HairSurface := nil;
  m_WeaponSurface := nil;
  m_HumWinSurface := nil;
  m_WeaponEffectSurface := nil;

  m_HumHoserSurface := nil;
  m_HoserSurface := nil;
  m_HairHoserSurface := nil;
end;

procedure THumActor.LoadSurface;
var
  nCurrentFrame, btHorseDress: Integer;
begin
  if m_btHorse = 0 then begin
    if (m_nCurrentAction >= SM_100HIT) and (m_nCurrentAction <= SM_103HIT) or ((m_nCurrentAction = SM_SPELL) and (m_CurMagic.EffectNumber in [104..111])) then begin
      m_BodySurface := g_cboHumImgImages.GetCachedImage(2000 * m_btDress + m_nCurrentFrame, m_nPx, m_nPy);
    end else begin
      m_BodySurface := GetWHumImg(m_btDress, m_btSex, m_nCurrentFrame, m_nPx, m_nPy);
    end;
    if m_BodySurface = nil then begin
      if (m_nCurrentAction >= SM_100HIT) and (m_nCurrentAction <= SM_103HIT) or ((m_nCurrentAction = SM_SPELL) and (m_CurMagic.EffectNumber in [104..111])) then begin
        m_BodySurface := g_cboHumImgImages.GetCachedImage(2000 * m_btDress + m_nCurrentFrame, m_nPx, m_nPy);
      end else begin
        m_BodySurface := GetWHumImg(0, m_btSex, m_nCurrentFrame, m_nPx, m_nPy);
      end;
    end;
  end else begin //骑马
    btHorseDress := g_WHumHorseImages.ImageCount div HUMANFRAME - 1;
    if g_WHumHorseImages.ImageCount mod HUMANFRAME > 0 then Inc(btHorseDress);
    if m_btDress <= btHorseDress then begin
      m_HumHoserSurface := g_WHumHorseImages.GetCachedImage(HUMANFRAME * m_btDress + m_nCurrentFrame, m_nPx, m_nPy);
    end else begin
      if m_btSex = 0 then begin
        m_HumHoserSurface := g_WHumHorseImages.GetCachedImage(HUMANFRAME * (btHorseDress - 1) + m_nCurrentFrame, m_nPx, m_nPy);
      end else begin
        m_HumHoserSurface := g_WHumHorseImages.GetCachedImage(HUMANFRAME * btHorseDress + m_nCurrentFrame, m_nPx, m_nPy);
      end;
    end;
    if m_HumHoserSurface = nil then
      m_HumHoserSurface := g_WHumHorseImages.GetCachedImage(m_nCurrentFrame, m_nPx, m_nPy);
  end;

  if m_nHairOffset >= 0 then begin
    if m_btHorse = 0 then begin
      if (m_nCurrentAction >= SM_100HIT) and (m_nCurrentAction <= SM_103HIT) or ((m_nCurrentAction = SM_SPELL) and (m_CurMagic.EffectNumber in [104..111])) then begin
        m_HairSurface := g_cboHairImgImages.GetCachedImage(2000 * m_btHair + m_nCurrentFrame, m_nHpx, m_nHpy);
      end else begin
        if m_btHair < 4 then begin
          m_HairSurface := g_WHairImgImages.GetCachedImage(m_nHairOffset + m_nCurrentFrame, m_nHpx, m_nHpy);
        end else begin
          m_HairSurface := g_WHair2ImgImages.GetCachedImage(m_nHairOffset + m_nCurrentFrame, m_nHpx, m_nHpy);
        end;
      end;
    end else begin
      if m_btHair < 4 then begin
        m_HairHoserSurface := g_WHairHorseImages.GetCachedImage(m_nHairOffset + m_nCurrentFrame, m_nHpx, m_nHpy);
      end else begin
        m_HairHoserSurface := nil;
      end;
    end;
  end else begin
    m_HairSurface := nil;
    m_HairHoserSurface := nil;
  end;

  if m_btHorse = 0 then begin
    m_HoserSurface := nil;
    m_HairHoserSurface := nil;

    if (m_btEffect = 50) then begin
      if (m_nCurrentFrame <= 536) then begin
        if (GetTickCount - m_dwFrameTick) > 100 then begin
          if m_nFrame < 19 then Inc(m_nFrame)
          else begin
            if not m_bo2D0 then m_bo2D0 := True
            else m_bo2D0 := False;
            m_nFrame := 0;
          end;
          m_dwFrameTick := GetTickCount();
        end;
        m_HumWinSurface := g_WEffectImg.GetCachedImage(m_nHumWinOffset + m_nFrame, m_nSpx, m_nSpy);
      //m_HumWinSurface := g_WMain2Images.GetCachedImage(m_nHumWinOffset + m_nFrame, m_nSpx, m_nSpy);
      end;
    end else begin
      if (m_btEffect <> 0) then begin
        if m_nCurrentFrame < 64 then begin
          if (GetTickCount - m_dwFrameTick) > m_dwFrameTime then begin
            if m_nFrame < 7 then Inc(m_nFrame)
            else m_nFrame := 0;
            m_dwFrameTick := GetTickCount();
          end;
          if (m_nCurrentAction >= SM_100HIT) and (m_nCurrentAction <= SM_103HIT) or ((m_nCurrentAction = SM_SPELL) and (m_CurMagic.EffectNumber in [104..111])) then begin
            m_HumWinSurface := g_cboHumWingImages.GetCachedImage(m_nHumWinOffset + (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
          end else begin
            if ((m_btEffect >= 100) and (m_btEffect <= 149)) then begin
              m_HumWinSurface := g_WHum2WingImages.GetCachedImage(m_nHumWinOffset + (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
            //  DScreen.AddChatBoardString ('HumEffect1: ' + IntToStr(m_btEffect), clBlue, clWhite);

            end else begin
            {if m_btEffect >= 150 then begin
            m_HumWinSurface := g_WHum2WingImages.GetCachedImage(m_nHumWinOffset + (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
           // DScreen.AddChatBoardString ('HumEffect2: ' + IntToStr(m_btEffect), clBlue, clWhite);
          end else begin  }

              m_HumWinSurface := g_WHumWingImages.GetCachedImage(m_nHumWinOffset + (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
           //   DScreen.AddChatBoardString ('HumEffect: ' + IntToStr(m_btEffect), clBlue, clWhite);

            //end;
          end;
          end;
        end else begin
          if (m_nCurrentAction >= SM_100HIT) and (m_nCurrentAction <= SM_103HIT) or ((m_nCurrentAction = SM_SPELL) and (m_CurMagic.EffectNumber in [104..111])) then begin
            m_HumWinSurface := g_cboHumWingImages.GetCachedImage(m_nHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy);
          end else begin
             if ((m_btEffect >= 100) and (m_btEffect <= 149)) then begin
              m_HumWinSurface := g_WHum2WingImages.GetCachedImage(m_nHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy);
            //  DScreen.AddChatBoardString ('HumEffect1: ' + IntToStr(m_btEffect), clBlue, clWhite);

            end else begin
            {if m_btEffect >= 150 then begin
            m_HumWinSurface := g_WHum2WingImages.GetCachedImage(m_nHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy);
          //  DScreen.AddChatBoardString ('HumEffect2: ' + IntToStr(m_btEffect), clBlue, clWhite);
          end else begin  }

              m_HumWinSurface := g_WHumWingImages.GetCachedImage(m_nHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy);
         //    DScreen.AddChatBoardString ('HumEffect: ' + IntToStr(m_btEffect), clBlue, clWhite);

            //end;
            end;
          end;
        end;
      end;
    end;
  end else begin //骑马
    m_WeaponSurface := nil;
    m_WeaponGlimmerSurface := nil;

    m_HoserSurface := g_WHorseImages.GetCachedImage(HUMANFRAME * m_btHorse + m_nCurrentFrame, m_nSpx, m_nSpy);
    if m_HoserSurface = nil then
      m_HoserSurface := g_WHorseImages.GetCachedImage(m_nCurrentFrame, m_nSpx, m_nSpy);
  end;

  if m_btHorse = 0 then begin
    if (m_nCurrentAction >= SM_100HIT) and (m_nCurrentAction <= SM_103HIT) or ((m_nCurrentAction = SM_SPELL) and (m_CurMagic.EffectNumber in [104..111])) then begin
      m_WeaponSurface := g_cboWeaponImages.GetCachedImage(2000 * m_btWeapon + m_nCurrentFrame, m_nWpx, m_nWpy);
      m_WeaponGlimmerSurface := nil;
    end else begin
    //Weapon Glows
      m_WeaponSurface := GetWWeaponImg(m_btWeapon, m_btSex, m_nCurrentFrame, m_nWpx, m_nWpy);
      if (m_btWeapon - m_btSex = 38 * 2) then
        m_WeaponGlimmerSurface := g_WHum2WingImages.GetCachedImage(HUMANFRAME * m_btSex + m_nCurrentFrame, m_nWGpx, m_nWGpy);
      if (m_btWeapon - m_btSex = 56 * 2) then
        m_WeaponGlimmerSurface := g_WHum2WingImages.GetCachedImage(1200 + HUMANFRAME * m_btSex + m_nCurrentFrame, m_nWGpx, m_nWGpy);
      if (m_btWeapon - m_btSex = 105 * 2) then
        m_WeaponGlimmerSurface := g_WHum2WingImages.GetCachedImage(8400 + HUMANFRAME * m_btSex + m_nCurrentFrame, m_nWGpx, m_nWGpy);
      if (m_btWeapon - m_btSex = 106 * 2) then
        m_WeaponGlimmerSurface := g_WHum2WingImages.GetCachedImage(9600 + HUMANFRAME * m_btSex + m_nCurrentFrame, m_nWGpx, m_nWGpy);
      if (m_btWeapon - m_btSex = 107 * 2) then
        m_WeaponGlimmerSurface := g_WHum2WingImages.GetCachedImage(10800 + HUMANFRAME * m_btSex + m_nCurrentFrame, m_nWGpx, m_nWGpy);
      if (m_btWeapon - m_btSex = 103 * 2) then
        m_WeaponGlimmerSurface := g_WHum2WingImages.GetCachedImage(6000 + HUMANFRAME * m_btSex + m_nCurrentFrame, m_nWGpx, m_nWGpy);
    end;

    if m_WeaponSurface = nil then
      if (m_nCurrentAction >= SM_100HIT) and (m_nCurrentAction <= SM_103HIT) or ((m_nCurrentAction = SM_SPELL) and (m_CurMagic.EffectNumber in [104..111])) then begin
        m_WeaponSurface := g_cboWeaponImages.GetCachedImage(2000 * m_btWeapon + m_nCurrentFrame, m_nWpx, m_nWpy);
      end else begin
        m_WeaponSurface := GetWWeaponImg(0, m_btSex, m_nCurrentFrame, m_nWpx, m_nWpy);
      end;
  end;
  if m_boStartStore then begin
    nCurrentFrame := m_nCurrentFrame div 8;
    nCurrentFrame := nCurrentFrame * 8 + 1;
    if m_btHorse = 0 then begin
      GetWHumImg(m_btDress, m_btSex, nCurrentFrame, m_nStoreX, m_nStoreY);
    end else begin
      if m_btDress <= btHorseDress then begin
        g_WHumHorseImages.GetCachedImage(HUMANFRAME * m_btDress + nCurrentFrame, m_nStoreX, m_nStoreY);
      end else begin
        if m_btSex = 0 then begin
          g_WHumHorseImages.GetCachedImage(HUMANFRAME * (btHorseDress - 1) + nCurrentFrame, m_nStoreX, m_nStoreY);
        end else begin
          g_WHumHorseImages.GetCachedImage(HUMANFRAME * btHorseDress + nCurrentFrame, m_nStoreX, m_nStoreY);
        end;
      end;
    end;
    case m_btDir of
      1: m_StoreSurface := g_WCqFirImages.Images[182];
      3: m_StoreSurface := g_WCqFirImages.Images[179];
      5: m_StoreSurface := g_WCqFirImages.Images[181];
      7: m_StoreSurface := g_WCqFirImages.Images[180];
    else m_StoreSurface := g_WCqFirImages.Images[182];
    end;
  end else m_StoreSurface := nil;
end;

procedure THumActor.DrawChr(dsurface: TTexture; dx, dy: Integer; blend: Boolean; boFlag: Boolean);
var
  idx, ax, ay: Integer;
  ax1, ay1: Integer;
  d, d1: TTexture;
  ceff: TColorEffect;
  wimg: TGameImages;
  nHpx, nHPY: Integer;
  nCode: Integer;
  Actor: TActor;
  nDir: Integer;
begin
  nCode := 0;
  d := nil; //Jacky
  if not CanDraw then Exit;
  if not (m_btDir in [0..7]) then Exit;
  if GetTickCount - m_dwLoadSurfaceTick > m_dwLoadSurfaceTime then begin
    m_dwLoadSurfaceTick := GetTickCount;
    nCode := 1;
    LoadSurface; //bodysurface loadsurface
    nCode := 2;
  end;
  nCode := 3;
  ceff := GetDrawEffectValue;
  nCode := 4;
  if m_btRace = 0 then begin

    if m_btHorse > 0 then begin
      if m_boStartStore and (m_StoreSurface <> nil) then begin //画摆摊位置
        case m_btDir of
          1: dsurface.Draw(dx + m_nStoreX + m_nShiftX - 10, dy + m_nStoreY + m_nShiftY + 20, m_StoreSurface.ClientRect, m_StoreSurface, True);
          3: dsurface.Draw(dx + m_nStoreX + m_nShiftX - 30, dy + m_nStoreY + m_nShiftY + 60, m_StoreSurface.ClientRect, m_StoreSurface, True);
          5: dsurface.Draw(dx + m_nStoreX + m_nShiftX - 60, dy + m_nStoreY + m_nShiftY + 50, m_StoreSurface.ClientRect, m_StoreSurface, True);
          7: dsurface.Draw(dx + m_nStoreX + m_nShiftX - 70, dy + m_nStoreY + m_nShiftY + 10, m_StoreSurface.ClientRect, m_StoreSurface, True);
        end;
      end;
    end else begin
      if m_boStartStore and (m_StoreSurface <> nil) then begin //画摆摊位置
        case Self.m_btDir of
          1: dsurface.Draw(dx + m_nStoreX + m_nShiftX - 10, dy + m_nStoreY + m_nShiftY + 20, m_StoreSurface.ClientRect, m_StoreSurface, True);
          3: dsurface.Draw(dx + m_nStoreX + m_nShiftX - 30, dy + m_nStoreY + m_nShiftY + 60, m_StoreSurface.ClientRect, m_StoreSurface, True);
          5: dsurface.Draw(dx + m_nStoreX + m_nShiftX - 60, dy + m_nStoreY + m_nShiftY + 50, m_StoreSurface.ClientRect, m_StoreSurface, True);
          7: dsurface.Draw(dx + m_nStoreX + m_nShiftX - 70, dy + m_nStoreY + m_nShiftY + 10, m_StoreSurface.ClientRect, m_StoreSurface, True);
        end;
      end;
    end;

    nCode := -4;
    if m_btCastle in [1..2] then begin
      nCode := 5;
      ShowActorCastleLable(dsurface);
      nCode := 6;
    end;
    if (m_nCurrentFrame >= 0) and (m_nCurrentFrame <= 599) then
      m_nWpord := WORDER[m_btSex, m_nCurrentFrame];
    if m_btHorse = 0 then begin
      if m_btEffect <> 0 then begin
        if g_MySelf = Self then begin
          if blend then begin
            if ((m_btDir = 3) or (m_btDir = 4) or (m_btDir = 5)) and
              (m_HumWinSurface <> nil) and not boFlag then begin
              nCode := 7;
              DrawBlend(dsurface,
                dx + m_nSpx + m_nShiftX,
                dy + m_nSpy + m_nShiftY,
                m_HumWinSurface);
              nCode := 8;
            end else begin
              if ((m_btDir = 3) or (m_btDir = 4) or (m_btDir = 5)) and
                (m_HumWinSurface <> nil) and boFlag then begin
                nCode := 9;
                DrawBlend(dsurface,
                  dx + m_nSpx + m_nShiftX,
                  dy + m_nSpy + m_nShiftY,
                  m_HumWinSurface);
                nCode := 10;
              end;
            end;
          end;
        end else begin
          if ((g_FocusCret <> nil) or (g_MagicTarget <> nil)) and
            blend and ((m_btDir = 3) or (m_btDir = 4) or (m_btDir = 5)) and
            (m_HumWinSurface <> nil) and not boFlag then begin
            nCode := 11;
            DrawBlend(dsurface,
              dx + m_nSpx + m_nShiftX,
              dy + m_nSpy + m_nShiftY,
              m_HumWinSurface);
            nCode := 12;
          end else begin
            if ((m_btDir = 3) or (m_btDir = 4) or (m_btDir = 5)) and
              (m_HumWinSurface <> nil) and boFlag then begin
              nCode := 13;
              DrawBlend(dsurface,
                dx + m_nSpx + m_nShiftX,
                dy + m_nSpy + m_nShiftY,
                m_HumWinSurface);
              nCode := 14;
            end;
          end;
        end;
      end;

      if (m_nWpord = 0) and (not blend) and (m_btWeapon >= 2) and (m_WeaponSurface <> nil) and (not m_boHideWeapon) then begin
        DrawWeaponGlimmer(dsurface, dx + m_nShiftX, dy + m_nShiftY);
        nCode := 15;
        DrawEffSurface(dsurface, m_WeaponSurface, dx + m_nWpx + m_nShiftX, dy + m_nWpy + m_nShiftY, blend, ceNone);
        nCode := 16;

        nCode := 17;
        //DrawEffSurface(dsurface, m_WeaponGlimmerSurface, dx + m_nWGpx + m_nShiftX, dy + m_nWGpy + m_nShiftY, blend, ceNone); //武器发光效果
      //dsurface.Draw (dx + wpx + ShiftX, dy + wpy + ShiftY, WeaponSurface.ClientRect, WeaponSurface, TRUE);
      end;
    end;

    if m_btHorse > 0 then begin
      if m_HoserSurface <> nil then //马
        DrawEffSurface(dsurface, m_HoserSurface, dx + m_nSpx + m_nShiftX, dy + m_nSpy + m_nShiftY, blend, ceff);
      nCode := 18;
      if m_HumHoserSurface <> nil then //人物
        DrawEffSurface(dsurface, m_HumHoserSurface, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, blend, ceff);
      nCode := 19;
    end else begin
      if m_BodySurface <> nil then
        DrawEffSurface(dsurface, m_BodySurface, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, blend, ceff);
      nCode := 20;
    end;

    if m_btHorse = 0 then begin
      if m_HairSurface <> nil then //画发型
        DrawEffSurface(dsurface, m_HairSurface, dx + m_nHpx + m_nShiftX, dy + m_nHpy + m_nShiftY, blend, ceff);
      nCode := 21;
    end else begin
      if m_HairHoserSurface <> nil then
        DrawEffSurface(dsurface, m_HairHoserSurface, dx + m_nHpx + m_nShiftX, dy + m_nHpy + m_nShiftY, blend, ceff);
      nCode := 22;
    end;

    if (m_nWpord = 1) and (m_btWeapon >= 2) and (m_WeaponSurface <> nil) and (not m_boHideWeapon) and (m_btHorse = 0) then begin
      DrawWeaponGlimmer(dsurface, dx + m_nShiftX, dy + m_nShiftY);
      nCode := 23;
      DrawEffSurface(dsurface, m_WeaponSurface, dx + m_nWpx + m_nShiftX, dy + m_nWpy + m_nShiftY, blend, ceNone);
      nCode := 24;
      nCode := 25;
      //DrawEffSurface(dsurface, m_WeaponGlimmerSurface, dx + m_nWGpx + m_nShiftX, dy + m_nWGpy + m_nShiftY, blend, ceNone); //武器发光效果
    end;

    {if (m_WeaponEffectSurface <> nil) and (not m_boHideWeapon) and boFlag then begin
      DrawBlend(dsurface, dx + m_nWpx + m_nShiftX, dy + m_nWpy + m_nShiftY, m_WeaponEffectSurface, 1); //武器发光效果
    end;   }

    if m_btHorse = 0 then begin
      if (m_btEffect = 50) then begin
        if (m_HumWinSurface <> nil) then
          nCode := 26;
        DrawBlend(dsurface,
          dx + m_nSpx + m_nShiftX,
          dy + m_nSpy + m_nShiftY,
          m_HumWinSurface);
        nCode := 27;
      end else
        if m_btEffect <> 0 then begin
        if g_MySelf = Self then begin
          if blend then begin
            if ((m_btDir = 0) or (m_btDir = 7) or (m_btDir = 1) or (m_btDir = 6) or (m_btDir = 2)) and
              (m_HumWinSurface <> nil) and not boFlag then begin
              nCode := 28;
              DrawBlend(dsurface,
                dx + m_nSpx + m_nShiftX,
                dy + m_nSpy + m_nShiftY,
                m_HumWinSurface);
              nCode := 29;
            end else begin
              if ((m_btDir = 0) or (m_btDir = 7) or (m_btDir = 1) or (m_btDir = 6) or (m_btDir = 2)) and
                (m_HumWinSurface <> nil) and boFlag then begin
                nCode := 30;
                DrawBlend(dsurface,
                  dx + m_nSpx + m_nShiftX,
                  dy + m_nSpy + m_nShiftY,
                  m_HumWinSurface);
                nCode := 31;
              end;
            end;
          end;
        end else begin
          if ((g_FocusCret <> nil) or (g_MagicTarget <> nil)) and
            ((m_btDir = 0) or (m_btDir = 7) or (m_btDir = 1) or (m_btDir = 6) or (m_btDir = 2)) and
            (m_HumWinSurface <> nil) and not boFlag then begin
            nCode := 32;
            DrawBlend(dsurface,
              dx + m_nSpx + m_nShiftX,
              dy + m_nSpy + m_nShiftY,
              m_HumWinSurface);
            nCode := 33;
          end else begin
            if ((m_btDir = 0) or (m_btDir = 7) or (m_btDir = 1) or (m_btDir = 6) or (m_btDir = 2)) and
              (m_HumWinSurface <> nil) and boFlag then begin
              nCode := 34;
              DrawBlend(dsurface,
                dx + m_nSpx + m_nShiftX,
                dy + m_nSpy + m_nShiftY,
                m_HumWinSurface);
              nCode := 35;
            end;
          end;
        end;
      end;
    end;

    //显示魔法盾时效果
    if not m_boDeath then begin
      if m_nState and $00100000 <> 0 then begin
        if (m_nCurrentAction = SM_STRUCK) and (m_nCurBubbleStruck < 3) then
          idx := MAGBUBBLESTRUCKBASE + m_nCurBubbleStruck
        else
          idx := MAGBUBBLEBASE + (m_nGenAniCount mod 3);

        d := g_WMagicImages.GetCachedImage(idx, ax, ay);
        if d <> nil then
          DrawBlend(dsurface,
            dx + ax + m_nShiftX,
            dy + ay + m_nShiftY,
            d);

        if m_boSuperShield and (g_WMagic6Images.Images[723] <> nil) then begin //4级魔法盾
          if (m_nCurrentAction = SM_STRUCK) and (m_nCurBubbleStruck < 3) then
            idx := 723 + m_nCurBubbleStruck
          else
            idx := 720 + (m_nGenAniCount mod 3);

          d := g_WMagic6Images.GetCachedImage(idx, ax, ay);
          if d <> nil then
            DrawBlend(dsurface,
              dx + ax + m_nShiftX,
              dy + ay + m_nShiftY,
              d);
        end;
      end;

    //显示护体神盾效果
      if m_nStateStartFrame <= m_nStateEndFrame then begin
        if m_btState = 0 then begin
          d := g_WMagic5Images.GetCachedImage(m_nStateStartFrame, ax, ay);
          nCode := 36;
          if d <> nil then
            DrawBlend(dsurface,
              dx + ax + m_nShiftX,
              dy + ay + m_nShiftY,
              d);
        end else begin
          d := g_WMagic6Images.GetCachedImage(m_nStateStartFrame, ax, ay);
          nCode := 36;
          if d <> nil then
            DrawBlend(dsurface,
              dx + ax + m_nShiftX,
              dy + ay + m_nShiftY,
              d);
        end;
        if GetTickCount - m_dwStateFrameTime > 100 then begin
          Inc(m_nStateStartFrame);
          m_dwStateFrameTime := GetTickCount;
        end;
      end;
    end;
  end;

  //显示开始魔法效果
  if m_boUseMagic and (m_CurMagic.EffectNumber > 0) then begin
    if m_nCurEffFrame in [0..m_nSpellFrame - 1] then begin
      GetEffectBase(m_CurMagic.EffectNumber - 1, 0, wimg, idx);
      case m_CurMagic.EffectNumber of
        50: idx := idx + m_btDir * 10; //分身术
        61: if m_btJob = 2 then idx := idx - 20;
        62: idx := idx - m_btJob * 20;
        64: if m_btJob = 1 then idx := idx + 20;
        104: idx := idx + m_btJob * (m_nSpellFrame + m_nSpellFrameSkip); //双龙破
        105: idx := idx + m_btJob * (m_nSpellFrame + m_nSpellFrameSkip); //凤舞祭
        106: idx := idx + m_btJob * (m_nSpellFrame + m_nSpellFrameSkip); //冰天雪地

        108: idx := idx + m_btJob * (m_nSpellFrame + m_nSpellFrameSkip); //虎啸诀
        109: idx := idx + m_btJob * (m_nSpellFrame + m_nSpellFrameSkip); //八卦掌
        110: idx := idx + m_btJob * (m_nSpellFrame + m_nSpellFrameSkip); //三焰咒
        111: idx := idx + m_btJob * (m_nSpellFrame + m_nSpellFrameSkip); //万剑归宗
      end;
      {if m_CurMagic.EffectNumber = 10 then
      DScreen.AddChatBoardString('m_CurMagic.EffectNumber=10', clGreen, clWhite);
      }
      if m_CurMagic.EffectNumber = 50 then begin //分身术
        idx := idx + m_nCurEffFrame;
        if wimg <> nil then
          d := wimg.GetCachedImage(idx, ax, ay);
        if d <> nil then begin
          GetPixelFrontPosition(dx + ax + m_nShiftX, dy + ay + m_nShiftY, m_btDir, 4, ax, ay);
          DrawBlend(dsurface, ax, ay, d);
        end;
        idx := m_nCurEffFrame;
        if wimg <> nil then
          d := wimg.GetCachedImage(idx, ax, ay);
        if d <> nil then
          DrawBlend(dsurface,
            dx + ax + m_nShiftX,
            dy + ay + m_nShiftY,
            d);
      end else begin
        idx := idx + m_nCurEffFrame;
        if wimg <> nil then
          d := wimg.GetCachedImage(idx, ax, ay);
        if d <> nil then
          DrawBlend(dsurface,
            dx + ax + m_nShiftX,
            dy + ay + m_nShiftY,
            d);
       { if m_CurMagic.EffectNumber = 118 then begin //虎啸诀
          d := ImgLib.GetCachedImage(3580 + m_btJob * 10 + m_nCurEffFrame, ax, ay);
          if d <> nil then
            dsurface.Draw(dx + ax + m_nShiftX, dy + ay + m_nShiftY, d);

          d := ImgLib.GetCachedImage(3660 + m_btJob * 10 + m_nCurEffFrame, ax, ay);
          if d <> nil then
            DrawBlend(dsurface,
              dx + ax + m_nShiftX,
              dy + ay + m_nShiftY,
              d);
        end;  }
      end;
    end;
  end;

   //显示攻击效果
  if m_boHitEffect and (m_nHitEffectNumber > 0) then begin
    GetEffectBase(m_nHitEffectNumber - 1, 1, wimg, idx);
    if m_nHitEffectNumber = 8 then begin //破空剑
      idx := idx + m_btDir * 20 + (m_nCurrentFrame - m_nStartFrame);
      m_nHitEndDX := dx;
      m_nHitEndDY := dy;
    end else
      if m_nHitEffectNumber = 9 then begin //破魂斩
      idx := idx + m_btDir * 20 + (m_nCurrentFrame - m_nStartFrame);
      m_nHitEndDX := dx;
      m_nHitEndDY := dy;
    end else
      if m_nHitEffectNumber = 10 then begin //劈星斩
      idx := idx + (m_nCurrentFrame - m_nStartFrame);
    end else
      if m_nHitEffectNumber = 12 then begin //开天斩
      idx := idx + m_btDir * 10 + (m_nCurrentFrame - m_nStartFrame);
      m_nHitEndDX := dx;
      m_nHitEndDY := dy;
    end else
      if m_nHitEffectNumber = 20 then begin //三绝杀
      idx := idx + m_btDir * 20 + (m_nCurrentFrame - m_nStartFrame);
    end else begin
      idx := idx + m_btDir * 10 + (m_nCurrentFrame - m_nStartFrame);
    end;
    if wimg <> nil then
      d := wimg.GetCachedImage(idx, ax, ay);
    if d <> nil then
      DrawBlend(dsurface,
        dx + ax + m_nShiftX,
        dy + ay + m_nShiftY,
        d);
    if (m_nHitEffectNumber = 22) then begin //断岳斩
      idx := 2001;
      idx := idx + m_btDir * 10 + (m_nCurrentFrame - m_nStartFrame);
      d := g_cboEffectImg.GetCachedImage(idx, ax, ay);
      if d <> nil then
        DrawBlend(dsurface,
          dx + ax + m_nShiftX,
          dy + ay + m_nShiftY,
          d);
    end;
  end;

  if m_boHitEndEffect and (m_nHitEffectNumber > 0) then begin
    GetEffectBase(m_nHitEffectNumber - 1, 1, wimg, idx);
    if m_nHitEffectNumber = 8 then //破空剑
      idx := idx + m_btHitDir * 20 + (m_nCurrentHitFrame - m_nStartHitFrame + m_nStartPosHitFrame);
    if m_nHitEffectNumber = 9 then //破魂斩
      idx := idx + m_btHitDir * 20 + (m_nCurrentHitFrame - m_nStartHitFrame + m_nStartPosHitFrame);
    if m_nHitEffectNumber = 12 then //开天斩
      idx := idx + m_btHitDir * 10 + (m_nCurrentHitFrame - m_nStartHitFrame + m_nStartPosHitFrame);

    if wimg <> nil then
      d := wimg.GetCachedImage(idx, ax, ay);
    if d <> nil then
      DrawBlend(dsurface,
        m_nHitEndDX + ax + m_nHitEndX,
        m_nHitEndDY + ay + m_nHitEndY,
        d);
  end;

  //显示武器破碎效果
  if m_boWeaponEffect then begin
    idx := WPEFFECTBASE + m_btDir * 10 + m_nCurWeaponEffect;
    d := g_WMagicImages.GetCachedImage(idx, ax, ay);
    if d <> nil then
      DrawBlend(dsurface,
        dx + ax + m_nShiftX,
        dy + ay + m_nShiftY,
        d);
    nCode := 43;
  end;

  {except
    DebugOutStr('THumActor.DrawChr:' + IntToStr(nCode));
  end;   }
end;

function THumActor.FindGroupMagic: pTClientMagic;
var
  I: Integer;
  pm: PTClientMagic;
begin
  Result := nil;
  for I := 0 to g_HeroMagicList.Count - 1 do begin
    pm := PTClientMagic(g_HeroMagicList[I]);
    if pm.Def.wMagicId = GetGroupMagicId then begin
      Result := pm;
      Break;
    end;
  end;
end;

function THumActor.GetGroupMagicId: Integer;
begin
  Result := 0;
  case g_MySelf.m_btJob of
    0: begin
        case m_btJob of
          0: Result := 60;
          1: Result := 62;
          2: Result := 61;
        end;
      end;
    1: begin
        case m_btJob of
          0: Result := 62;
          1: Result := 65;
          2: Result := 64;
        end;
      end;
    2: begin
        case m_btJob of
          0: Result := 61;
          1: Result := 64;
          2: Result := 63;
        end;
      end;
  end;
end;

procedure THumActor.GroupAttack;
begin
  if (m_nMaxAngryValue > 0) and (m_nAngryValue >= m_nMaxAngryValue) then begin
    if (g_TargetCret = nil) or g_TargetCret.m_boDeath then begin
      if (g_FocusCret <> nil) and not g_FocusCret.m_boDeath then begin
        frmMain.SendClientMessage(CM_HEROGROUPATTACK, g_FocusCret.m_nRecogId, g_FocusCret.m_nCurrX, g_FocusCret.m_nCurrY, 0);
      end else begin
        frmMain.SendClientMessage(CM_HEROGROUPATTACK, 0, g_nMouseCurrX, g_nMouseCurrY, 0);
      end;
    end else begin
      frmMain.SendClientMessage(CM_HEROGROUPATTACK, g_TargetCret.m_nRecogId, g_TargetCret.m_nCurrX, g_TargetCret.m_nCurrY, 0);
    end;
    //frmMain.SendClientMessage(CM_HEROGROUPATTACK, 0, 0, 0, 0);
  end;
end;

procedure THumActor.Rest;
begin
  frmMain.SendSay('@RestHero');
end;

procedure THumActor.Protect;
begin
  frmMain.SendClientMessage(CM_HEROPROTECT, 0, g_nMouseCurrX, g_nMouseCurrY, 0);
end;

procedure THumActor.Target;
begin
  if (g_TargetCret = nil) or g_TargetCret.m_boDeath then begin
    if (g_FocusCret <> nil) and not g_FocusCret.m_boDeath then begin
      frmMain.SendClientMessage(CM_HEROTARGET, g_FocusCret.m_nRecogId, g_FocusCret.m_nCurrX, g_FocusCret.m_nCurrY, 0);
    end else begin
      frmMain.SendClientMessage(CM_HEROTARGET, 0, g_nMouseCurrX, g_nMouseCurrY, 0);
    end;
  end else begin
    frmMain.SendClientMessage(CM_HEROTARGET, g_TargetCret.m_nRecogId, g_TargetCret.m_nCurrX, g_TargetCret.m_nCurrY, 0);
  end;
end;


end.

