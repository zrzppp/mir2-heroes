unit PlayListBox;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ImgList, RzButton;
type
  TCustomPlayListBox = class;

  TPlayItem = class
  private
    FButton: TRzToolButton;
    FListBox: TCustomPlayListBox;
    FData: Pointer;
    FFont: TFont;
  protected

  public
    constructor Create(ListBox: TCustomPlayListBox);
    destructor Destroy; override;
    property Data: Pointer read FData write FData;
  end;

  TCustomPlayListBox = class(TCustomMultiSelectListControl)
  private
    FAutoComplete: Boolean;
    FCount: Integer;
    FItems: TStrings;
    FFilter: string;
    FLastTime: Cardinal;
    FBorderStyle: TBorderStyle;
    FCanvas: TCanvas;
    FColumns: Integer;
    FItemHeight: Integer;
    FOldCount: Integer;
    FStyle: TListBoxStyle;
    FIntegralHeight: Boolean;
    FSorted: Boolean;
    FExtendedSelect: Boolean;
    FTabWidth: Integer;
    FSaveItems: TStringList;
    FSaveTopIndex: Integer;
    FSaveItemIndex: Integer;
    FOnDrawItem: TDrawItemEvent;
    FOnMeasureItem: TMeasureItemEvent;
    FOnData: TLBGetDataEvent;
    FOnDataFind: TLBFindDataEvent;
    FOnDataObject: TLBGetDataObjectEvent;
    FMoveItemIndex: Integer;
    function GetItemHeight: Integer;
    function GetTopIndex: Integer;
    procedure LBGetText(var Message: TMessage); message LB_GETTEXT;
    procedure LBGetTextLen(var Message: TMessage); message LB_GETTEXTLEN;
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetColumnWidth;
    procedure SetColumns(Value: Integer);
    procedure SetCount(const Value: Integer);
    procedure SetExtendedSelect(Value: Boolean);
    procedure SetIntegralHeight(Value: Boolean);
    procedure SetItemHeight(Value: Integer);
    procedure SetItems(Value: TStrings);
    procedure SetSelected(Index: Integer; Value: Boolean);
    procedure SetSorted(Value: Boolean);
    procedure SetStyle(Value: TListBoxStyle);
    procedure SetTabWidth(Value: Integer);
    procedure SetTopIndex(Value: Integer);
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CNMeasureItem(var Message: TWMMeasureItem); message CN_MEASUREITEM;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    function GetScrollWidth: Integer;
    procedure SetScrollWidth(const Value: Integer);
  protected
    FMoving: Boolean;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    function DoGetData(const Index: Integer): string;
    function DoGetDataObject(const Index: Integer): TObject;
    function DoFindData(const Data: string): Integer;
    procedure WndProc(var Message: TMessage); override;
    procedure DragCanceled; override;
    procedure DrawItem(Index: Integer; Rect: TRect;
      State: TOwnerDrawState); virtual;
    function GetCount: Integer; override;
    function GetSelCount: Integer; override;
    procedure MeasureItem(Index: Integer; var Height: Integer); virtual;
    function InternalGetItemData(Index: Integer): Longint; dynamic;
    procedure InternalSetItemData(Index: Integer; AData: Longint); dynamic;
    function GetItemData(Index: Integer): LongInt; dynamic;
    function GetItemIndex: Integer; override;
    function GetSelected(Index: Integer): Boolean;
    procedure KeyPress(var Key: Char); override;
    procedure SetItemData(Index: Integer; AData: LongInt); dynamic;
    procedure ResetContent; dynamic;
    procedure DeleteString(Index: Integer); dynamic;
    procedure SetMultiSelect(Value: Boolean); override;
    procedure SetItemIndex(const Value: Integer); override;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Columns: Integer read FColumns write SetColumns default 0;
    property ExtendedSelect: Boolean read FExtendedSelect write SetExtendedSelect default True;
    property IntegralHeight: Boolean read FIntegralHeight write SetIntegralHeight default False;
    property ItemHeight: Integer read GetItemHeight write SetItemHeight;
    property ParentColor default False;
    property Sorted: Boolean read FSorted write SetSorted default False;
    property Style: TListBoxStyle read FStyle write SetStyle default lbStandard;
    property TabWidth: Integer read FTabWidth write SetTabWidth default 0;
    property OnDrawItem: TDrawItemEvent read FOnDrawItem write FOnDrawItem;
    property OnMeasureItem: TMeasureItemEvent read FOnMeasureItem write FOnMeasureItem;
    property OnData: TLBGetDataEvent read FOnData write FOnData;
    property OnDataObject: TLBGetDataObjectEvent read FOnDataObject write FOnDataObject;
    property OnDataFind: TLBFindDataEvent read FOnDataFind write FOnDataFind;
    property Items: TStrings read FItems write SetItems;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddItem(Item: string; AObject: TObject); override;
    procedure Clear; override;
    procedure ClearSelection; override;
    procedure CopySelection(Destination: TCustomListControl); override;
    procedure DeleteSelected; override;
    function ItemAtPos(Pos: TPoint; Existing: Boolean): Integer;
    function ItemRect(Index: Integer): TRect;
    procedure SelectAll; override;
    procedure Add(const S: string; AObject: TObject);

    property AutoComplete: Boolean read FAutoComplete write FAutoComplete default True;
    property Canvas: TCanvas read FCanvas;
    property Count: Integer read GetCount write SetCount;
    property Selected[Index: Integer]: Boolean read GetSelected write SetSelected;
    property ScrollWidth: Integer read GetScrollWidth write SetScrollWidth default 0;
    property TopIndex: Integer read GetTopIndex write SetTopIndex;
  published
    property TabStop default True;
  end;


  TPlayListBox = class(TCustomPlayListBox)
  published
    property Style;
    property AutoComplete;
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Columns;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ExtendedSelect;
    property Font;
    property ImeMode;
    property ImeName;
    property IntegralHeight;
    property ItemHeight;
    //property Items;
    property MultiSelect;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ScrollWidth;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property TabWidth;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnData;
    property OnDataFind;
    property OnDataObject;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation
uses Consts, RTLConsts, Unit1;

constructor TPlayItem.Create(ListBox: TCustomPlayListBox);
begin
  FListBox := ListBox;
  FButton := TRzToolButton.Create(ListBox);
  FButton.Parent := FListBox;
  FButton.Visible := False;
  FFont := TFont.Create;
  FFont.Assign(FListBox.Font);
  FData := nil;
end;

destructor TPlayItem.Destroy;
begin
  FButton.Free;
  FFont.Free;
end;


type
  TListBoxStrings = class(TStrings)
  private
    ListBox: TCustomPlayListBox;
  protected
    procedure Put(Index: Integer; const S: string); override;
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    function Add(const S: string): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Exchange(Index1, Index2: Integer); override;
    function IndexOf(const S: string): Integer; override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure Move(CurIndex, NewIndex: Integer); override;
  end;

const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
{ TListBoxStrings }

function TListBoxStrings.GetCount: Integer;
begin
  Result := SendMessage(ListBox.Handle, LB_GETCOUNT, 0, 0);
end;

function TListBoxStrings.Get(Index: Integer): string;
var
  Len: Integer;
begin
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
    Result := ListBox.DoGetData(Index)
  else
  begin
    Len := SendMessage(ListBox.Handle, LB_GETTEXTLEN, Index, 0);
    if Len = LB_ERR then Error(SListIndexError, Index);
    SetLength(Result, Len);
    if Len <> 0 then
    begin
      Len := SendMessage(ListBox.Handle, LB_GETTEXT, Index, Longint(PChar(Result)));
      SetLength(Result, Len); // LB_GETTEXTLEN isn't guaranteed to be accurate
    end;
  end;
end;

function TListBoxStrings.GetObject(Index: Integer): TObject;
begin
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
    Result := ListBox.DoGetDataObject(Index)
  else
  begin
    Result := TObject(ListBox.GetItemData(Index));
    if Longint(Result) = LB_ERR then Error(SListIndexError, Index);
  end;
end;

procedure TListBoxStrings.Put(Index: Integer; const S: string);
var
  I: Integer;
  TempData: Longint;
begin
  I := ListBox.ItemIndex;
  TempData := ListBox.InternalGetItemData(Index);
  // Set the Item to 0 in case it is an object that gets freed during Delete
  ListBox.InternalSetItemData(Index, 0);
  Delete(Index);
  InsertObject(Index, S, nil);
  ListBox.InternalSetItemData(Index, TempData);
  ListBox.ItemIndex := I;
end;

procedure TListBoxStrings.PutObject(Index: Integer; AObject: TObject);
begin
  if (Index <> -1) and not (ListBox.Style in [lbVirtual, lbVirtualOwnerDraw]) then
    ListBox.SetItemData(Index, LongInt(AObject));
end;

function TListBoxStrings.Add(const S: string): Integer;
begin
  Result := -1;
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then exit;
  Result := SendMessage(ListBox.Handle, LB_ADDSTRING, 0, Longint(PChar(S)));
  if Result < 0 then raise EOutOfResources.Create(SInsertLineError);
end;

procedure TListBoxStrings.Insert(Index: Integer; const S: string);
begin
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then exit;
  if SendMessage(ListBox.Handle, LB_INSERTSTRING, Index,
    Longint(PChar(S))) < 0 then
    raise EOutOfResources.Create(SInsertLineError);
end;

procedure TListBoxStrings.Delete(Index: Integer);
begin
  ListBox.DeleteString(Index);
end;

procedure TListBoxStrings.Exchange(Index1, Index2: Integer);
var
  TempData: Longint;
  TempString: string;
begin
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then exit;
  BeginUpdate;
  try
    TempString := Strings[Index1];
    TempData := ListBox.InternalGetItemData(Index1);
    Strings[Index1] := Strings[Index2];
    ListBox.InternalSetItemData(Index1, ListBox.InternalGetItemData(Index2));
    Strings[Index2] := TempString;
    ListBox.InternalSetItemData(Index2, TempData);
    if ListBox.ItemIndex = Index1 then
      ListBox.ItemIndex := Index2
    else if ListBox.ItemIndex = Index2 then
      ListBox.ItemIndex := Index1;
  finally
    EndUpdate;
  end;
end;

procedure TListBoxStrings.Clear;
begin
  ListBox.ResetContent;
end;

procedure TListBoxStrings.SetUpdateState(Updating: Boolean);
begin
  SendMessage(ListBox.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then ListBox.Refresh;
end;

function TListBoxStrings.IndexOf(const S: string): Integer;
begin
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
    Result := ListBox.DoFindData(S)
  else
    Result := SendMessage(ListBox.Handle, LB_FINDSTRINGEXACT, -1, LongInt(PChar(S)));
end;

procedure TListBoxStrings.Move(CurIndex, NewIndex: Integer);
var
  TempData: Longint;
  TempString: string;
begin
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then exit;
  BeginUpdate;
  ListBox.FMoving := True;
  try
    if CurIndex <> NewIndex then
    begin
      TempString := Get(CurIndex);
      TempData := ListBox.InternalGetItemData(CurIndex);
      ListBox.InternalSetItemData(CurIndex, 0);
      Delete(CurIndex);
      Insert(NewIndex, TempString);
      ListBox.InternalSetItemData(NewIndex, TempData);
    end;
  finally
    ListBox.FMoving := False;
    EndUpdate;
  end;
end;
{ TCustomPlayListBox }

constructor TCustomPlayListBox.Create(AOwner: TComponent);
const
  ListBoxStyle = [csSetCaption, csDoubleClicks, csOpaque];
begin
  inherited Create(AOwner);
  if NewStyleControls then
    ControlStyle := ListBoxStyle else
    ControlStyle := ListBoxStyle + [csFramed];
  Width := 121;
  Height := 97;
  TabStop := True;
  ParentColor := False;
  FAutoComplete := True;
  FItems := TListBoxStrings.Create;
  TListBoxStrings(FItems).ListBox := Self;
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  FItemHeight := 16;
  FBorderStyle := bsSingle;
  FExtendedSelect := True;
  FOldCount := -1;
end;

destructor TCustomPlayListBox.Destroy;
begin
  inherited Destroy;
  FCanvas.Free;
  FItems.Free;
  FSaveItems.Free;
end;

procedure TCustomPlayListBox.Add(const S: string; AObject: TObject);
var
  Item: TPlayItem;
begin
  Item := TPlayItem.Create(Self);
  Item.Data := AObject;
  Items.AddObject(S, Item);
end;

procedure TCustomPlayListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  FMoveItemIndex := TopIndex + Y div ItemHeight;
  if FMoveItemIndex > Count - 1 then
    FMoveItemIndex := Count - 1;
end;

procedure TCustomPlayListBox.AddItem(Item: string; AObject: TObject);
var
  S: string;
begin
  SetString(S, PChar(Item), StrLen(PChar(Item)));
  FItems.AddObject(S, AObject);
end;

function TCustomPlayListBox.GetItemData(Index: Integer): LongInt;
begin
  Result := SendMessage(Handle, LB_GETITEMDATA, Index, 0);
end;

procedure TCustomPlayListBox.SetItemData(Index: Integer; AData: LongInt);
begin
  SendMessage(Handle, LB_SETITEMDATA, Index, AData);
end;

function TCustomPlayListBox.InternalGetItemData(Index: Integer): LongInt;
begin
  Result := GetItemData(Index);
end;

procedure TCustomPlayListBox.InternalSetItemData(Index: Integer; AData: LongInt);
begin
  SetItemData(Index, AData);
end;

procedure TCustomPlayListBox.DeleteString(Index: Integer);
begin
  SendMessage(Handle, LB_DELETESTRING, Index, 0);
end;

procedure TCustomPlayListBox.ResetContent;
begin
  if Style in [lbVirtual, lbVirtualOwnerDraw] then exit;
  SendMessage(Handle, LB_RESETCONTENT, 0, 0);
end;

procedure TCustomPlayListBox.Clear;
begin
  Items.Clear;
end;

procedure TCustomPlayListBox.ClearSelection;
var
  I: Integer;
begin
  if MultiSelect then
    for I := 0 to Items.Count - 1 do
      Selected[I] := False
  else
    ItemIndex := -1;
end;

procedure TCustomPlayListBox.CopySelection(Destination: TCustomListControl);
var
  I: Integer;
begin
  if MultiSelect then
  begin
    for I := 0 to Items.Count - 1 do
      if Selected[I] then
        Destination.AddItem(PChar(Items[I]), Items.Objects[I]);
  end
  else
    if ItemIndex <> -1 then
    Destination.AddItem(PChar(Items[ItemIndex]), Items.Objects[ItemIndex]);
end;

procedure TCustomPlayListBox.DeleteSelected;
var
  I: Integer;
begin
  if MultiSelect then
  begin
    for I := FItems.Count - 1 downto 0 do
      if Selected[I] then
        Items.Delete(I);
  end
  else
    if ItemIndex <> -1 then
    Items.Delete(ItemIndex);
end;

procedure TCustomPlayListBox.SetColumnWidth;
var
  ColWidth: Integer;
begin
  if (FColumns > 0) and (Width > 0) then
  begin
    ColWidth := Trunc(ClientWidth / FColumns);
    if ColWidth < 1 then ColWidth := 1;
    SendMessage(Handle, LB_SETCOLUMNWIDTH, ColWidth, 0);
  end;
end;

procedure TCustomPlayListBox.SetColumns(Value: Integer);
begin
  if FColumns <> Value then
    if (FColumns = 0) or (Value = 0) then
    begin
      FColumns := Value;
      RecreateWnd;
    end else
    begin
      FColumns := Value;
      if HandleAllocated then SetColumnWidth;
    end;
end;

function TCustomPlayListBox.GetItemIndex: Integer;
begin
  if MultiSelect then
    Result := SendMessage(Handle, LB_GETCARETINDEX, 0, 0)
  else
    Result := SendMessage(Handle, LB_GETCURSEL, 0, 0);
end;

function TCustomPlayListBox.GetCount: Integer;
begin
  if Style in [lbVirtual, lbVirtualOwnerDraw] then
    Result := FCount
  else
    Result := Items.Count;
end;

function TCustomPlayListBox.GetSelCount: Integer;
begin
  Result := SendMessage(Handle, LB_GETSELCOUNT, 0, 0);
end;

procedure TCustomPlayListBox.SetItemIndex(const Value: Integer);
begin
  if GetItemIndex <> Value then
    if MultiSelect then SendMessage(Handle, LB_SETCARETINDEX, Value, 0)
    else SendMessage(Handle, LB_SETCURSEL, Value, 0);
end;

procedure TCustomPlayListBox.SetExtendedSelect(Value: Boolean);
begin
  if Value <> FExtendedSelect then
  begin
    FExtendedSelect := Value;
    RecreateWnd;
  end;
end;

procedure TCustomPlayListBox.SetIntegralHeight(Value: Boolean);
begin
  if Value <> FIntegralHeight then
  begin
    FIntegralHeight := Value;
    RecreateWnd;
    RequestAlign;
  end;
end;

function TCustomPlayListBox.GetItemHeight: Integer;
var
  R: TRect;
begin
  Result := FItemHeight;
  if HandleAllocated and (FStyle = lbStandard) then
  begin
    Perform(LB_GETITEMRECT, 0, Longint(@R));
    Result := R.Bottom - R.Top;
  end;
end;

procedure TCustomPlayListBox.SetItemHeight(Value: Integer);
begin
  if (FItemHeight <> Value) and (Value > 0) then
  begin
    FItemHeight := Value;
    RecreateWnd;
  end;
end;

procedure TCustomPlayListBox.SetTabWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FTabWidth <> Value then
  begin
    FTabWidth := Value;
    RecreateWnd;
  end;
end;

procedure TCustomPlayListBox.SetMultiSelect(Value: Boolean);
begin
  if FMultiSelect <> Value then
  begin
    FMultiSelect := Value;
    RecreateWnd;
  end;
end;

function TCustomPlayListBox.GetSelected(Index: Integer): Boolean;
var
  R: Longint;
begin
  R := SendMessage(Handle, LB_GETSEL, Index, 0);
  if R = LB_ERR then
    raise EListError.CreateResFmt(@SListIndexError, [Index]);
  Result := LongBool(R);
end;

procedure TCustomPlayListBox.SetSelected(Index: Integer; Value: Boolean);
begin
  if FMultiSelect then
  begin
    if SendMessage(Handle, LB_SETSEL, Longint(Value), Index) = LB_ERR then
      raise EListError.CreateResFmt(@SListIndexError, [Index]);
  end
  else
    if Value then
  begin
    if SendMessage(Handle, LB_SETCURSEL, Index, 0) = LB_ERR then
      raise EListError.CreateResFmt(@SListIndexError, [Index])
  end
  else
    SendMessage(Handle, LB_SETCURSEL, -1, 0);
end;

procedure TCustomPlayListBox.SetSorted(Value: Boolean);
begin
  if Style in [lbVirtual, lbVirtualOwnerDraw] then exit;
  if FSorted <> Value then
  begin
    FSorted := Value;
    RecreateWnd;
  end;
end;

procedure TCustomPlayListBox.SetStyle(Value: TListBoxStyle);
begin
  if FStyle <> Value then
  begin
    if Value in [lbVirtual, lbVirtualOwnerDraw] then
    begin
      Items.Clear;
      Sorted := False;
    end;
    FStyle := Value;
    RecreateWnd;
  end;
end;

function TCustomPlayListBox.GetTopIndex: Integer;
begin
  Result := SendMessage(Handle, LB_GETTOPINDEX, 0, 0);
end;

procedure TCustomPlayListBox.LBGetText(var Message: TMessage);
var
  S: string;
begin
  if Style in [lbVirtual, lbVirtualOwnerDraw] then
  begin
    if Assigned(FOnData) and (Message.WParam > -1) and (Message.WParam < Count) then
    begin
      S := '';
      OnData(Self, Message.wParam, S);
      StrCopy(PChar(Message.lParam), PChar(S));
      Message.Result := Length(S);
    end
    else
      Message.Result := LB_ERR;
  end
  else
    inherited;
end;

procedure TCustomPlayListBox.LBGetTextLen(var Message: TMessage);
var
  S: string;
begin
  if Style in [lbVirtual, lbVirtualOwnerDraw] then
  begin
    if Assigned(FOnData) and (Message.WParam > -1) and (Message.WParam < Count) then
    begin
      S := '';
      OnData(Self, Message.wParam, S);
      Message.Result := Length(S);
    end
    else
      Message.Result := LB_ERR;
  end
  else
    inherited;
end;

procedure TCustomPlayListBox.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCustomPlayListBox.SetTopIndex(Value: Integer);
begin
  if GetTopIndex <> Value then
    SendMessage(Handle, LB_SETTOPINDEX, Value, 0);
end;

procedure TCustomPlayListBox.SetItems(Value: TStrings);
begin
  if Style in [lbVirtual, lbVirtualOwnerDraw] then
    case Style of
      lbVirtual: Style := lbStandard;
      lbVirtualOwnerDraw: Style := lbOwnerDrawFixed;
    end;
  Items.Assign(Value);
end;

function TCustomPlayListBox.ItemAtPos(Pos: TPoint; Existing: Boolean): Integer;
var
  Count: Integer;
  ItemRect: TRect;
begin
  if PtInRect(ClientRect, Pos) then
  begin
    Result := TopIndex;
    Count := Items.Count;
    while Result < Count do
    begin
      Perform(LB_GETITEMRECT, Result, Longint(@ItemRect));
      if PtInRect(ItemRect, Pos) then Exit;
      Inc(Result);
    end;
    if not Existing then Exit;
  end;
  Result := -1;
end;

function TCustomPlayListBox.ItemRect(Index: Integer): TRect;
var
  Count: Integer;
begin
  Count := Items.Count;
  if (Index = 0) or (Index < Count) then
    Perform(LB_GETITEMRECT, Index, Longint(@Result))
  else if Index = Count then
  begin
    Perform(LB_GETITEMRECT, Index - 1, Longint(@Result));
    OffsetRect(Result, 0, Result.Bottom - Result.Top);
  end else FillChar(Result, SizeOf(Result), 0);
end;

procedure TCustomPlayListBox.CreateParams(var Params: TCreateParams);
type
  PSelects = ^TSelects;
  TSelects = array[Boolean] of DWORD;
const
  Styles: array[TListBoxStyle] of DWORD =
  (0, LBS_OWNERDRAWFIXED, LBS_OWNERDRAWVARIABLE, LBS_OWNERDRAWFIXED,
    LBS_OWNERDRAWFIXED);
  Sorteds: array[Boolean] of DWORD = (0, LBS_SORT);
  MultiSelects: array[Boolean] of DWORD = (0, LBS_MULTIPLESEL);
  ExtendSelects: array[Boolean] of DWORD = (0, LBS_EXTENDEDSEL);
  IntegralHeights: array[Boolean] of DWORD = (LBS_NOINTEGRALHEIGHT, 0);
  MultiColumns: array[Boolean] of DWORD = (0, LBS_MULTICOLUMN);
  TabStops: array[Boolean] of DWORD = (0, LBS_USETABSTOPS);
  CSHREDRAW: array[Boolean] of DWORD = (CS_HREDRAW, 0);
  Data: array[Boolean] of DWORD = (LBS_HASSTRINGS, LBS_NODATA);
var
  Selects: PSelects;
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'LISTBOX');
  with Params do
  begin
    Selects := @MultiSelects;
    if FExtendedSelect then Selects := @ExtendSelects;
    Style := Style or (WS_HSCROLL or WS_VSCROLL or
      Data[Self.Style in [lbVirtual, lbVirtualOwnerDraw]] or
      LBS_NOTIFY) or Styles[FStyle] or Sorteds[FSorted] or
      Selects^[FMultiSelect] or IntegralHeights[FIntegralHeight] or
      MultiColumns[FColumns <> 0] or BorderStyles[FBorderStyle] or
      TabStops[FTabWidth <> 0];
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
    WindowClass.style := WindowClass.style and not (CSHREDRAW[UseRightToLeftAlignment] or CS_VREDRAW);
  end;
end;

procedure TCustomPlayListBox.CreateWnd;
var
  W, H: Integer;
begin
  W := Width;
  H := Height;
  inherited CreateWnd;
  SetWindowPos(Handle, 0, Left, Top, W, H, SWP_NOZORDER or SWP_NOACTIVATE);
  if FTabWidth <> 0 then
    SendMessage(Handle, LB_SETTABSTOPS, 1, Longint(@FTabWidth));
  SetColumnWidth;
  if (FOldCount <> -1) or Assigned(FSaveItems) then
  begin
    if (Style in [lbVirtual, lbVirtualOwnerDraw]) then
      Count := FOldCount;
    if FSaveItems <> nil then
    begin
      FItems.Assign(FSaveItems);
      FreeAndNil(FSaveItems);
    end;
    SetTopIndex(FSaveTopIndex);
    SetItemIndex(FSaveItemIndex);
    FOldCount := -1;
  end;
end;

procedure TCustomPlayListBox.DestroyWnd;
begin
  if (FItems.Count > 0) then
  begin
    if (Style in [lbVirtual, lbVirtualOwnerDraw]) then
      FOldCount := FItems.Count
    else
    begin
      FSaveItems := TStringList.Create;
      FSaveItems.Assign(FItems);
    end;
    FSaveTopIndex := GetTopIndex;
    FSaveItemIndex := GetItemIndex;
  end;
  inherited DestroyWnd;
end;

procedure TCustomPlayListBox.WndProc(var Message: TMessage);
begin
  {for auto drag mode, let listbox handle itself, instead of TControl}
  if not (csDesigning in ComponentState) and ((Message.Msg = WM_LBUTTONDOWN) or
    (Message.Msg = WM_LBUTTONDBLCLK)) and not Dragging then
  begin
    if DragMode = dmAutomatic then
    begin
      if IsControlMouseMsg(TWMMouse(Message)) then
        Exit;
      ControlState := ControlState + [csLButtonDown];
      Dispatch(Message); {overrides TControl's BeginDrag}
      Exit;
    end;
  end;
  inherited WndProc(Message);
end;

procedure TCustomPlayListBox.WMLButtonDown(var Message: TWMLButtonDown);
var
  ItemNo: Integer;
  ShiftState: TShiftState;
begin
  ShiftState := KeysToShiftState(Message.Keys);
  if (DragMode = dmAutomatic) and FMultiSelect then
  begin
    if not (ssShift in ShiftState) or (ssCtrl in ShiftState) then
    begin
      ItemNo := ItemAtPos(SmallPointToPoint(Message.Pos), True);
      if (ItemNo >= 0) and (Selected[ItemNo]) then
      begin
        BeginDrag(False);
        Exit;
      end;
    end;
  end;
  inherited;
  if (DragMode = dmAutomatic) and not (FMultiSelect and
    ((ssCtrl in ShiftState) or (ssShift in ShiftState))) then
    BeginDrag(False);
end;

procedure TCustomPlayListBox.CNCommand(var Message: TWMCommand);
begin
  case Message.NotifyCode of
    LBN_SELCHANGE:
      begin
        inherited Changed;
        Click;
      end;
    LBN_DBLCLK: DblClick;
  end;
end;

procedure TCustomPlayListBox.WMPaint(var Message: TWMPaint);

  procedure PaintListBox;
  var
    DrawItemMsg: TWMDrawItem;
    MeasureItemMsg: TWMMeasureItem;
    DrawItemStruct: TDrawItemStruct;
    MeasureItemStruct: TMeasureItemStruct;
    R: TRect;
    Y, I, H, W: Integer;
  begin
    { Initialize drawing records }
    DrawItemMsg.Msg := CN_DRAWITEM;
    DrawItemMsg.DrawItemStruct := @DrawItemStruct;
    DrawItemMsg.Ctl := Handle;
    DrawItemStruct.CtlType := ODT_LISTBOX;
    DrawItemStruct.itemAction := ODA_DRAWENTIRE;
    DrawItemStruct.itemState := 0;
    DrawItemStruct.hDC := Message.DC;
    DrawItemStruct.CtlID := Handle;
    DrawItemStruct.hwndItem := Handle;

    { Intialize measure records }
    MeasureItemMsg.Msg := CN_MEASUREITEM;
    MeasureItemMsg.IDCtl := Handle;
    MeasureItemMsg.MeasureItemStruct := @MeasureItemStruct;
    MeasureItemStruct.CtlType := ODT_LISTBOX;
    MeasureItemStruct.CtlID := Handle;

    { Draw the listbox }
    Y := 0;
    I := TopIndex;
    GetClipBox(Message.DC, R);
    H := Height;
    W := Width;
    while Y < H do
    begin
      MeasureItemStruct.itemID := I;
      if I < Items.Count then
        MeasureItemStruct.itemData := Longint(Pointer(Items.Objects[I]));
      MeasureItemStruct.itemWidth := W;
      MeasureItemStruct.itemHeight := FItemHeight;
      DrawItemStruct.itemData := MeasureItemStruct.itemData;
      DrawItemStruct.itemID := I;
      Dispatch(MeasureItemMsg);
      DrawItemStruct.rcItem := Rect(0, Y, MeasureItemStruct.itemWidth,
        Y + Integer(MeasureItemStruct.itemHeight));
      Dispatch(DrawItemMsg);
      Inc(Y, MeasureItemStruct.itemHeight);
      Inc(I);
      if I >= Items.Count then break;
    end;
  end;

begin
  if Message.DC <> 0 then
    { Listboxes don't allow paint "sub-classing" like the other windows controls
      so we have to do it ourselves. }
    PaintListBox
  else inherited;
end;

procedure TCustomPlayListBox.WMSize(var Message: TWMSize);
begin
  inherited;
  SetColumnWidth;
end;

procedure TCustomPlayListBox.DragCanceled;
var
  M: TWMMouse;
  MousePos: TPoint;
begin
  with M do
  begin
    Msg := WM_LBUTTONDOWN;
    GetCursorPos(MousePos);
    Pos := PointToSmallPoint(ScreenToClient(MousePos));
    Keys := 0;
    Result := 0;
  end;
  DefaultHandler(M);
  M.Msg := WM_LBUTTONUP;
  DefaultHandler(M);
end;

procedure TCustomPlayListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  Flags: Longint;
  Data: string;
begin
  if Assigned(FOnDrawItem) then FOnDrawItem(Self, Index, Rect, State) else
  begin

    FCanvas.FillRect(Rect);
    if Index < Count then
    begin
      Flags := DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);
      if not UseRightToLeftAlignment then
        Inc(Rect.Left, 2)
      else
        Dec(Rect.Right, 2);
      Data := '';
      if (Style in [lbVirtual, lbVirtualOwnerDraw]) then
        Data := DoGetData(Index)
      else
        Data := Items[Index];
      DrawText(FCanvas.Handle, PChar(Data), Length(Data), Rect, Flags);
    end;
  end;
    //if odSelected in State then
  Form1.Memo1.Lines.Add('ODS_HOTLIGHT Index:' + IntToStr(Integer(Index)));
end;

procedure TCustomPlayListBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  if Assigned(FOnMeasureItem) then FOnMeasureItem(Self, Index, Height)
end;

procedure TCustomPlayListBox.CNDrawItem(var Message: TWMDrawItem);
var
  State: TOwnerDrawState;
begin
  with Message.DrawItemStruct^ do
  begin

    State := TOwnerDrawState(LongRec(itemState).Lo);

    FCanvas.Handle := hDC;
    FCanvas.Font := Font;
    FCanvas.Brush := Brush;
    if (Integer(itemID) >= 0) and (odSelected in State) then
    begin
      FCanvas.Brush.Color := clHighlight;
      FCanvas.Font.Color := clHighlightText
    end;
    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, State) else
      FCanvas.FillRect(rcItem);
    if odFocused in State then DrawFocusRect(hDC, rcItem);
    FCanvas.Handle := 0;
  end;
end;

procedure TCustomPlayListBox.CNMeasureItem(var Message: TWMMeasureItem);
begin
  with Message.MeasureItemStruct^ do
  begin
    itemHeight := FItemHeight;
    if FStyle = lbOwnerDrawVariable then
      MeasureItem(itemID, Integer(itemHeight));
  end;
end;

procedure TCustomPlayListBox.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBorderStyle = bsSingle) then RecreateWnd;
  inherited;
end;

procedure TCustomPlayListBox.SelectAll;
var
  I: Integer;
begin
  if FMultiSelect then
    for I := 0 to Items.Count - 1 do
      Selected[I] := True;
end;

procedure TCustomPlayListBox.KeyPress(var Key: Char);

  procedure FindString;
  var
    Idx: Integer;
  begin
    if Style in [lbVirtual, lbVirtualOwnerDraw] then
      Idx := DoFindData(FFilter)
    else
      Idx := SendMessage(Handle, LB_FINDSTRING, -1, LongInt(PChar(FFilter)));
    if Idx <> LB_ERR then
    begin
      if MultiSelect then
      begin
        ClearSelection;
        SendMessage(Handle, LB_SELITEMRANGE, 1, MakeLParam(Idx, Idx))
      end;
      ItemIndex := Idx;
      Click;
    end;
    if not (Ord(Key) in [VK_RETURN, VK_BACK, VK_ESCAPE]) then
      Key := #0; // Clear so that the listbox's default search mechanism is disabled
  end;

var
  Msg: TMsg;
begin
  inherited KeyPress(Key);
  if not FAutoComplete then exit;
  if GetTickCount - FLastTime >= 500 then
    FFilter := '';
  FLastTime := GetTickCount;

  if Ord(Key) <> VK_BACK then
  begin
    if Key in LeadBytes then
    begin
      if PeekMessage(Msg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE) then
      begin
        FFilter := FFilter + Key + Chr(Msg.wParam);
        Key := #0;
      end;
    end
    else
      FFilter := FFilter + Key;
  end
  else
  begin
    while ByteType(FFilter, Length(FFilter)) = mbTrailByte do
      Delete(FFilter, Length(FFilter), 1);
    Delete(FFilter, Length(FFilter), 1);
  end;

  if Length(FFilter) > 0 then
    FindString
  else
  begin
    ItemIndex := 0;
    Click;
  end;
end;

procedure TCustomPlayListBox.SetCount(const Value: Integer);
var
  Error: Integer;
begin
  if Style in [lbVirtual, lbVirtualOwnerDraw] then
  begin
    // Limited to 32767 on Win95/98 as per Win32 SDK
    Error := SendMessage(Handle, LB_SETCOUNT, Value, 0);
    if (Error <> LB_ERR) and (Error <> LB_ERRSPACE) then
      FCount := Value
    else
      raise Exception.CreateFmt(SErrorSettingCount, [Name]);
  end
  else
    raise Exception.CreateFmt(SListBoxMustBeVirtual, [Name]);
end;

function TCustomPlayListBox.DoGetData(const Index: Integer): string;
begin
  if Assigned(FOnData) then FOnData(Self, Index, Result);
end;

function TCustomPlayListBox.DoGetDataObject(const Index: Integer): TObject;
begin
  if Assigned(FOnDataObject) then FOnDataObject(Self, Index, Result);
end;

function TCustomPlayListBox.DoFindData(const Data: string): Integer;
begin
  if Assigned(FOnDataFind) then
    Result := FOnDataFind(Self, Data)
  else
    Result := -1;
end;

function TCustomPlayListBox.GetScrollWidth: Integer;
begin
  Result := SendMessage(Handle, LB_GETHORIZONTALEXTENT, 0, 0);
end;

procedure TCustomPlayListBox.SetScrollWidth(const Value: Integer);
begin
  if Value <> ScrollWidth then
    SendMessage(Handle, LB_SETHORIZONTALEXTENT, Value, 0);
end;

end.

