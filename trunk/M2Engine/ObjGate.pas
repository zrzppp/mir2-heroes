unit ObjGate;

interface
uses
  Windows, Classes, SysUtils, StrUtils, StdCtrls, Graphics, ObjBase, Grobal2;
type
  TGateObject = class(TActorObject)
    m_boFlag: Boolean;
    m_DEnvir: TObject;
    m_nDMapX: Integer;
    m_nDMapY: Integer;
  private
  public
    constructor Create(DEnvir: TObject; nDMapX, nDMapY: Integer);
    destructor Destroy; override;
  end;
implementation

constructor TGateObject.Create(DEnvir: TObject; nDMapX, nDMapY: Integer);
begin
  m_ObjType := t_Gate;
  m_boFlag := False;
  m_DEnvir := DEnvir;
  m_nDMapX := nDMapX;
  m_nDMapY := nDMapY;
end;

destructor TGateObject.Destroy;
begin

end;

end.

