unit clEvent;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Textures, Grobal2, ExtCtrls, Share;

const
{$IF CUSTOMLIBFILE = 1}
  ZOMBIDIGUPDUSTBASE = 420;
  STONEFRAGMENTBASE = 10;
  HOLYCURTAINBASE = 20;
  FIREBURNBASE = 40;
  SCULPTUREFRAGMENT = 59;
{$ELSE}
  ZOMBIDIGUPDUSTBASE = 420;
  STONEFRAGMENTBASE = 64;
  HOLYCURTAINBASE = 1390;
  FIREBURNBASE = 1630;
  SCULPTUREFRAGMENT = 1349;
{$IFEND}
type
  TEvent = class
    m_nX: Integer;
    m_nY: Integer;
    m_nDir: Integer;
    m_nPx: Integer;
    m_nPy: Integer;
    m_nEventType: Integer;
    m_nEventParam: Integer;
    m_nServerId: Integer;
    m_Dsurface: TTexture;
    m_boBlend: Boolean;
    m_dwFrameTime: LongWord;
    m_dwCurframe: LongWord;
    m_nLight: Integer;
    m_nRunTime: Integer;
    m_nIndex: Integer;
  private
    
  public
    constructor Create(svid, ax, ay, evtype, RunTime: Integer);
    destructor Destroy; override;
    procedure DrawEvent(backsurface: TTexture; ax, ay: Integer); dynamic;
    procedure UnLoadSurface; dynamic;
    procedure Run; dynamic;
  end;


  TClEvent = class(TEvent)
  private
  public
    constructor Create(svid, ax, ay, evtype: Integer);
    destructor Destroy; override;
    procedure Run; override;
  end;

  TFlowerEvent = class(TEvent)
    m_nExplosionSound: Integer;
  public
    constructor Create(svid, ax, ay, evtype: Integer);
    destructor Destroy; override;
    procedure Run; override;
  end;

  TSpaceDoorEvent = class(TEvent)
  public
    constructor Create(svid, ax, ay, evtype: Integer);
    procedure Run; override;
  end;

  TClEventManager = class
  private
  public
    EventList: TList;
    constructor Create;
    destructor Destroy; override;
    procedure ClearEvents;
    function AddEvent(evn: TEvent): TEvent;
    procedure DelEvent(evn: TEvent);
    procedure DelEventById(svid: Integer);
    function GetEvent(ax, ay, etype: Integer): TEvent;
    procedure Execute;
  end;

implementation

uses
  SoundUtil, MShare;

constructor TEvent.Create(svid, ax, ay, evtype, RunTime: Integer);
begin
  m_nServerId := svid;
  m_nX := ax;
  m_nY := ay;
  m_nEventType := evtype;
  m_nEventParam := 0;
  m_boBlend := False;
  m_dwFrameTime := GetTickCount;
  m_dwCurframe := 0;
  m_nLight := 0;
  m_nRunTime := RunTime;
  m_nIndex := -1;
end;

destructor TEvent.Destroy;
begin
  inherited Destroy;
end;

procedure TEvent.UnLoadSurface;
begin
  m_Dsurface := nil;
end;

procedure TEvent.DrawEvent(backsurface: TTexture; ax, ay: Integer);
begin
  if not CanDraw then Exit;
  if m_Dsurface <> nil then
    if m_boBlend then DrawBlend(backsurface, ax + m_nPx, ay + m_nPy, m_Dsurface)
    else backsurface.Draw(ax + m_nPx, ay + m_nPy, m_Dsurface.ClientRect, m_Dsurface, True);
end;

procedure TEvent.Run;
begin
  if GetTickCount - m_dwFrameTime > m_nRunTime then begin
    m_dwFrameTime := GetTickCount;
    Inc(m_dwCurframe);
  end;
end;

constructor TClEvent.Create(svid, ax, ay, evtype: Integer);
begin
  inherited Create(svid, ax, ay, evtype, 20);
end;

destructor TClEvent.Destroy;
begin
  inherited Destroy;
end;

procedure TClEvent.Run;
begin
  inherited;
  m_Dsurface := nil;
  case m_nEventType of
{$IF CUSTOMLIBFILE = 1}
    ET_DIGOUTZOMBI: m_Dsurface := g_WEventEffectImages.GetCachedImage(m_nDir, m_nPx, m_nPy);
{$ELSE}
    ET_DIGOUTZOMBI: m_Dsurface := g_WMonImages.Indexs[6].GetCachedImage(ZOMBIDIGUPDUSTBASE + m_nDir, m_nPx, m_nPy);
{$IFEND}
    ET_PILESTONES: begin
        if m_nEventParam <= 0 then m_nEventParam := 1;
        if m_nEventParam > 5 then m_nEventParam := 5;
{$IF CUSTOMLIBFILE = 1}
        m_Dsurface := g_WEventEffectImages.GetCachedImage(STONEFRAGMENTBASE + (m_nEventParam - 1), m_nPx, m_nPy);
{$ELSE}
        m_Dsurface := g_WEffectImg.GetCachedImage(STONEFRAGMENTBASE + (m_nEventParam - 1), m_nPx, m_nPy);
{$IFEND}
      end;
    ET_HOLYCURTAIN: begin
{$IF CUSTOMLIBFILE = 1}
        m_Dsurface := g_WEventEffectImages.GetCachedImage(HOLYCURTAINBASE + (m_dwCurframe mod 10), m_nPx, m_nPy);
{$ELSE}
        m_Dsurface := g_WMagicImages.GetCachedImage(HOLYCURTAINBASE + (m_dwCurframe mod 10), m_nPx, m_nPy);
{$IFEND}
        m_boBlend := True;
        m_nLight := 1;
      end;
    ET_FIRE: begin
{$IF CUSTOMLIBFILE = 1}
        m_Dsurface := g_WEventEffectImages.GetCachedImage(FIREBURNBASE + ((m_dwCurframe div 2) mod 6), m_nPx, m_nPy);
{$ELSE}
        m_Dsurface := g_WMagicImages.GetCachedImage(FIREBURNBASE + ((m_dwCurframe div 2) mod 6), m_nPx, m_nPy);
{$IFEND}
        m_boBlend := True;
        m_nLight := 1;
      end;
    ET_SCULPEICE: begin
{$IF CUSTOMLIBFILE = 1}
        m_Dsurface := g_WEventEffectImages.GetCachedImage(SCULPTUREFRAGMENT, m_nPx, m_nPy);
{$ELSE}
        m_Dsurface := g_WMonImages.Indexs[7].GetCachedImage(SCULPTUREFRAGMENT, m_nPx, m_nPy);
{$IFEND}
      end;
   { ET_MAGICLOCK: begin

      end;    }
  end;
end;

constructor TSpaceDoorEvent.Create(svid, ax, ay, evtype: Integer);
begin
  inherited Create(svid, ax, ay, evtype, 50);
end;

procedure TSpaceDoorEvent.Run;
begin
  m_Dsurface := g_WNpcImgImages.GetCachedImage(4490 + m_nEventType * 10 + ((m_dwCurframe div 2) mod 10), m_nPx, m_nPy);
  m_boBlend := True;
  m_nLight := 1;
  inherited;
end;


constructor TFlowerEvent.Create(svid, ax, ay, evtype: Integer);
begin
  inherited Create(svid, ax, ay, evtype, 50);
  m_nExplosionSound := -1;
end;

destructor TFlowerEvent.Destroy;
begin
  inherited;
end;

procedure TFlowerEvent.Run;
begin
  m_Dsurface := nil;
  case m_nEventType of
{7种烟花效果}
    ET_FIREFLOWER_1: begin
        if m_dwCurframe <= 20 then begin
          if m_nExplosionSound = -1 then m_nExplosionSound := s_FireFlower_1;
        end else begin
          if m_dwCurframe mod 20 = 0 then begin
            if m_nExplosionSound < 0 then m_nExplosionSound := s_FireFlower_1;
          end else begin
            m_nExplosionSound := -1;
          end;
        end;
        m_Dsurface := g_WMagic3Images.GetCachedImage(60 + ((m_dwCurframe div 2) mod 20), m_nPx, m_nPy);
        m_boBlend := True;
        m_nLight := 1;
      end;
    ET_FIREFLOWER_2: begin
        if m_dwCurframe <= 20 then begin
          if m_nExplosionSound = -1 then m_nExplosionSound := s_FireFlower_2;
        end else begin
          if m_dwCurframe mod 20 = 0 then begin
            if m_nExplosionSound < 0 then m_nExplosionSound := s_FireFlower_2;
          end else begin
            m_nExplosionSound := -1;
          end;
        end;
        m_Dsurface := g_WMagic3Images.GetCachedImage(80 + ((m_dwCurframe div 2) mod 20), m_nPx, m_nPy);
        m_boBlend := True;
        m_nLight := 1;
      end;
    ET_FIREFLOWER_3: begin
        if m_dwCurframe <= 16 then begin
          if m_nExplosionSound = -1 then m_nExplosionSound := s_FireFlower_3;
        end else begin
          if m_dwCurframe mod 16 = 0 then begin
            if m_nExplosionSound < 0 then m_nExplosionSound := s_FireFlower_3;
          end else begin
            m_nExplosionSound := -1;
          end;
        end;
        m_Dsurface := g_WMagic3Images.GetCachedImage(100 + ((m_dwCurframe div 2) mod 16), m_nPx, m_nPy);
        m_boBlend := True;
        m_nLight := 1;
      end;
    ET_FIREFLOWER_4: begin
        if m_dwCurframe <= 16 then begin
          if m_nExplosionSound = -1 then m_nExplosionSound := s_FireFlower_3;
        end else begin
          if m_dwCurframe mod 16 = 0 then begin
            if m_nExplosionSound < 0 then m_nExplosionSound := s_FireFlower_3;
          end else begin
            m_nExplosionSound := -1;
          end;
        end;
        m_Dsurface := g_WMagic3Images.GetCachedImage(120 + ((m_dwCurframe div 2) mod 16), m_nPx, m_nPy);
        m_boBlend := True;
        m_nLight := 1;
      end;
    ET_FIREFLOWER_5: begin
        if m_dwCurframe <= 16 then begin
          if m_nExplosionSound = -1 then m_nExplosionSound := s_FireFlower_3;
        end else begin
          if m_dwCurframe mod 16 = 0 then begin
            if m_nExplosionSound < 0 then m_nExplosionSound := s_FireFlower_3;
          end else begin
            m_nExplosionSound := -1;
          end;
        end;
        m_Dsurface := g_WMagic3Images.GetCachedImage(140 + ((m_dwCurframe div 2) mod 16), m_nPx, m_nPy);
        m_boBlend := True;
        m_nLight := 1;
      end;
    ET_FIREFLOWER_6: begin
        if m_dwCurframe <= 16 then begin
          if m_nExplosionSound = -1 then m_nExplosionSound := s_FireFlower_3;
        end else begin
          if m_dwCurframe mod 16 = 0 then begin
            if m_nExplosionSound < 0 then m_nExplosionSound := s_FireFlower_3;
          end else begin
            m_nExplosionSound := -1;
          end;
        end;
        m_Dsurface := g_WMagic3Images.GetCachedImage(160 + ((m_dwCurframe div 2) mod 16), m_nPx, m_nPy);
        m_boBlend := True;
        m_nLight := 1;
      end;
    ET_FIREFLOWER_7: begin
        if m_dwCurframe <= 16 then begin
          if m_nExplosionSound = -1 then m_nExplosionSound := s_FireFlower_3;
        end else begin
          if m_dwCurframe mod 16 = 0 then begin
            if m_nExplosionSound < 0 then m_nExplosionSound := s_FireFlower_3;
          end else begin
            m_nExplosionSound := -1;
          end;
        end;
        m_Dsurface := g_WMagic3Images.GetCachedImage(180 + ((m_dwCurframe div 2) mod 16), m_nPx, m_nPy);
        m_boBlend := True;
        m_nLight := 1;
      end;
    ET_FIREFLOWER_8: begin
        m_nExplosionSound := -1;
        m_Dsurface := g_WEffectImg.GetCachedImage(830 + ((m_dwCurframe div 2) mod 41), m_nPx, m_nPy);
        m_boBlend := True;
        m_nLight := 1;
      end;
  end;
  inherited;
end;
{-----------------------------------------------------------------------------}



{-----------------------------------------------------------------------------}

constructor TClEventManager.Create;
begin
  EventList := TList.Create;
end;

destructor TClEventManager.Destroy;
var
  I: Integer;
begin
  for I := 0 to EventList.Count - 1 do
    TEvent(EventList[I]).Free;
  EventList.Free;
  inherited Destroy;
end;

procedure TClEventManager.ClearEvents;
var
  I: Integer;
begin
  for I := 0 to EventList.Count - 1 do
    TEvent(EventList[I]).Free;
  EventList.Clear;
end;

function TClEventManager.AddEvent(evn: TEvent): TEvent;
var
  I: Integer;
  Event: TEvent;
begin
  for I := 0 to EventList.Count - 1 do
    if (EventList[I] = evn) or (TEvent(EventList[I]).m_nServerId = evn.m_nServerId) then begin
      evn.Free;
      Result := nil;
      Exit;
    end;
  EventList.Add(evn);
  Result := evn;
end;

procedure TClEventManager.DelEvent(evn: TEvent);
var
  I: Integer;
begin
  for I := 0 to EventList.Count - 1 do
    if EventList[I] = evn then begin
      TEvent(EventList[I]).Free;
      EventList.Delete(I);
      Break;
    end;
end;

procedure TClEventManager.DelEventById(svid: Integer);
var
  I: Integer;
begin
  for I := 0 to EventList.Count - 1 do
    if TEvent(EventList[I]).m_nServerId = svid then begin
      TEvent(EventList[I]).Free;
      EventList.Delete(I);
      Break;
    end;
end;

function TClEventManager.GetEvent(ax, ay, etype: Integer): TEvent;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to EventList.Count - 1 do
    if (TEvent(EventList[I]).m_nX = ax) and (TEvent(EventList[I]).m_nY = ay) and
      (TEvent(EventList[I]).m_nEventType = etype) then begin
      Result := TEvent(EventList[I]);
      Break;
    end;
end;

procedure TClEventManager.Execute;
var
  I: Integer;
begin
  for I := 0 to EventList.Count - 1 do
    TEvent(EventList[I]).Run;
end;

end.

