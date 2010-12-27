unit ObjItem;

interface
uses
  Windows, Classes, SysUtils, StrUtils, StdCtrls, Graphics, Grobal2, ObjBase;
type
  TItemObject = class(TActorObject)
    m_sName: string;
    m_wLooks: Word;
    m_btAniCount: Byte;
    m_btReserved: Byte;
    m_nCount: Integer;
    m_OfActorObject: TObject;
    m_DropActorObject: TObject;
    m_dwCanPickUpTick: LongWord;
    m_UserItem: TUserItem;
  private
  public
    constructor Create();
    destructor Destroy; override;
  end;
implementation


end.

