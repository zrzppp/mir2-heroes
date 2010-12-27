unit uDragFromShell;
{  单元名称：uDragFromShell
   单元说明：让TwinControl控件能接收外来的文件拖放
   其它声明：senfore收集修改,盒子首发：www.2ccc.com}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ShellAPI;

type

  TShellDragEvent = procedure(Sender: Tobject; Filename: string) of object;
  TDragFromShell = class(Tcomponent)
  private
    FOwnerHandle: Thandle;
    FOldAownerWindowProc: Pointer;
    FOnShellDragDrop: TShellDragEvent;
    procedure AownerWindowProc(var Message: TMessage);
    procedure SetOnShellDragDrop(const Value: TShellDragEvent);
  protected
    procedure DoShellDragDrop(filename: string);
  public
    constructor Create(Aowner: Tcomponent); override;
    destructor Destroy; override;
  published
    property OnShellDragDrop: TShellDragEvent read FOnShellDragDrop write SetOnShellDragDrop;
  end;
const
  FCP_FILEOPEN = 10000000;
procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Arn:o)', [TDragFromShell]);
end;

{ TDragFromShell }

procedure TDragFromShell.AownerWindowProc(var Message: TMessage);
var
  count, index, hdrop: integer;
  Pfilename: pchar;
begin
  if Message.MSG <> WM_DROPFILES then
    Message.Result := CallWindowProc(FOldAownerWindowProc, FOwnerHandle, Message.Msg, Message.WPARAM, Message.LPARAM) else
  begin
    Hdrop := message.WParam;
    Getmem(pfilename, Max_path);
    Count := DragQueryfile(hdrop, maxdword, Pfilename, max_path - 1);
    for index := 0 to count - 1 do
    begin
      DragQueryfile(Hdrop, index, Pfilename, maxbyte);
      DoShellDragDrop(StrPas(Pfilename));
    end;
    Freemem(Pfilename);
    Dragfinish(Hdrop);
  end;
end;

constructor TDragFromShell.Create(Aowner: Tcomponent);
begin
  FOldAownerWindowProc := nil;
  if not (Aowner is Twincontrol) then
  begin
    raise Exception.Create('The DragFromShell''s Owner must be a TWinControl');
  end;
  inherited;
  FOwnerHandle := Twincontrol(Aowner).handle;
  DragAcceptFiles(FOwnerHandle, true);
  FOldAownerWindowProc := Pointer(GetWindowLong(FOwnerHandle, GWL_WNDPROC));
  SetWindowLong(FOwnerHandle, GWL_WNDPROC, integer(MakeObjectInstance(AownerWindowProc)));
end;

destructor TDragFromShell.Destroy;
begin
  DragAcceptFiles(FOwnerHandle, false);
  SetWindowLong(FOwnerHandle, GWL_WNDPROC, Integer(FOldAownerWindowProc));
  inherited;
end;

procedure TDragFromShell.DoShellDragDrop(filename: string);
begin
  if Assigned(fonshellDragDrop) then
    fonshellDragDrop(Self, Filename);
end;

procedure TDragFromShell.SetOnShellDragDrop(const Value: TShellDragEvent);
begin
  FOnShellDragDrop := Value;
end;

end.

