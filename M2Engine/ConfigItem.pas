unit ConfigItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ObjBase, Envir, Menus, ExtCtrls, ComCtrls, Grobal2, ItemEvent;

type
  TfrmConfigItem = class(TForm)
    PanelStatus: TPanel;
    ListView: TListView;
    Timer: TTimer;
    PopupMenu: TPopupMenu;
    PopupMenu_Ref: TMenuItem;
    PopupMenu_AutoRef: TMenuItem;
    PopupMenu_: TMenuItem;
    PopupMenu_Clear: TMenuItem;
    PopupMenu_ClearAll: TMenuItem;
    procedure PopupMenu_ClearClick(Sender: TObject);
    procedure PopupMenu_ClearAllClick(Sender: TObject);
    procedure PopupMenu_RefClick(Sender: TObject);
  private
    { Private declarations }
    procedure RefListViewSession;
  public
    { Public declarations }
    procedure Open(Envir: TEnvirnoment);
  end;

var
  frmConfigItem: TfrmConfigItem;
  SelEnvirnoment: TEnvirnoment;
implementation
uses UsrEngn, M2Share;
{$R *.dfm}

function FindItemList(ItemObject: TObject): Boolean;
var
  I: Integer;
begin
  {Result := False;
  SelEnvirnoment.m_ItemList.Lock;
  try
    for I := 0 to SelEnvirnoment.m_ItemList.Count - 1 do begin
      if SelEnvirnoment.m_ItemList.Items[I] = ItemObject then begin
        Result := True;
        Break;
      end;
    end;
  finally
    SelEnvirnoment.m_ItemList.UnLock;
  end; }
end;

procedure TfrmConfigItem.RefListViewSession;
var
  I, II, n01: Integer;
  ItemObject: TItemObject;
  Item: pTStdItem;
  UserItem: pTUserItem;
  ListItem: TListItem;
begin
  PanelStatus.Caption := '正在取得数据...';

  ListView.Visible := True;
end;

procedure TfrmConfigItem.Open(Envir: TEnvirnoment);
begin
  SelEnvirnoment := Envir;
  RefListViewSession;
  ShowModal;
end;

procedure TfrmConfigItem.PopupMenu_ClearClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  ItemObject: TItemObject;
begin
  for I := ListView.Items.Count - 1 downto 0 do begin
    ListItem := ListView.Items.Item[I];
    if ListItem.Selected then begin
      ItemObject := TItemObject(ListItem.SubItems.Objects[0]);
      if FindItemList(ItemObject) then begin
        if SelEnvirnoment.DeleteFromMap(ItemObject.m_nMapX, ItemObject.m_nMapY, ItemObject) = 1 then begin
          ListView.Items.Delete(I);
          ItemObject.MakeGhost; //释放物品内存
        end;
      end else ListView.Items.Delete(I);
    end;
  end;
  Caption := SelEnvirnoment.sMapDesc + ' ' + '物品数:' + IntToStr(ListView.Items.Count);
end;

procedure TfrmConfigItem.PopupMenu_ClearAllClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  ItemObject: TItemObject;
begin
  {SelEnvirnoment.m_ItemList.Lock;
  try
    while SelEnvirnoment.m_ItemList.Count > 0 do begin
      ItemObject := TItemObject(SelEnvirnoment.m_ItemList.Items[0]);
      if SelEnvirnoment.DeleteFromMap(ItemObject.m_nMapX, ItemObject.m_nMapY, ItemObject) = 1 then begin
        ItemObject.Visible := False; //释放物品内存
        SelEnvirnoment.AddFreeItemObject(ItemObject);
      end;
    end;
  finally
    SelEnvirnoment.m_ItemList.UnLock;
  end;
  ListView.Items.Clear;
  Caption := SelEnvirnoment.sMapDesc + ' ' + '物品数:' + IntToStr(ListView.Items.Count);}
end;

procedure TfrmConfigItem.PopupMenu_RefClick(Sender: TObject);
begin
  RefListViewSession;
end;

end.

