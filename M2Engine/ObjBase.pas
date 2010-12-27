unit ObjBase;

interface
uses
  Windows, Classes, SysUtils, StrUtils, StdCtrls, Graphics, Grobal2, HUtil32;
type
  pTBaseObject = ^TBaseObject;
  TBaseObject = class
    m_ObjType: TObjType;
    m_dwAddTime: LongWord;
    m_nMapX: Integer;
    m_nMapY: Integer;
  public
    constructor Create(); virtual;
    destructor Destroy; override;
  end;

  TGateObject = class(TBaseObject)
    m_nSMapX: Integer;
    m_nSMapY: Integer;
    m_boFlag: Boolean;
    m_sName: string;
    m_DEnvir: TObject;
    m_sSMapNO: string;
    m_sDMapNO: string;
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;

  TDoorObject = class(TBaseObject)
    m_n08: Integer;
    m_Status: pTDoorStatus;
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
implementation
//uses M2Share;

constructor TBaseObject.Create();
begin
  m_ObjType := t_Actor;
  m_dwAddTime := GetTickCount;
  m_nMapX := 0;
  m_nMapY := 0;
end;

destructor TBaseObject.Destroy;
begin
  //g_BaseObjectList.Add('Handle:'+IntToStr(Integer(Self))+' TBaseObject.Destroy');
  inherited;
end;

//------------------------------------------------------------------------------

constructor TGateObject.Create();
begin
  inherited;
  m_ObjType := t_Gate;
  m_boFlag := False;
  m_nSMapX := -1;
  m_nSMapY := -1;
  m_sSMapNO := '';
  m_sDMapNO := '';
  m_DEnvir := nil;
  m_sName := IntToStr(Integer(Self));
end;

destructor TGateObject.Destroy;
begin
  inherited;
end;

constructor TDoorObject.Create();
begin
  inherited;
  m_ObjType := t_Door;
  m_n08 := 0;
  m_Status := nil;
end;

destructor TDoorObject.Destroy;
begin
  inherited;
end;

end.

