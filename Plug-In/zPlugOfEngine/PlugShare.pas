unit PlugShare;

interface
uses
  Windows, Classes, EngineInterface;
type
  TCheckItem = record
    szItemName: string[14];
    boCanDrop: Boolean;
    boCanDeal: Boolean;
    boCanStorage: Boolean;
    boCanRepair: Boolean;
    boCanUpgrade: Boolean;
    boCanSell: Boolean;
    boCanNotScatter: Boolean;
    boCanDieScatter: Boolean;
    boCanOffLineTake: Boolean;
  end;
  pTCheckItem = ^TCheckItem;

  TUserCommand = record
    nIndex: Integer;
    sCommandName: string[100];
  end;
  pTUserCommand = ^TUserCommand;

  TFilterMsg = record
    sFilterMsg: string;
    sNewMsg: string;
    boGotoLabel: Boolean;
  end;
  pTFilterMsg = ^TFilterMsg;

var
  g_PlugEngine: TPlugEngine;
  g_UserManage: TUserManage;
  g_CharObject: TCharObject;

  g_CheckItemList: Classes.TList;
  g_UserCmdList: Classes.TStringList;
  g_MsgFilterList: Classes.TList;
  nStartHPRock: Integer = 10;
  nStartMPRock: Integer = 10;

  nHPRockSpell: Integer = 3;
  nMPRockSpell: Integer = 3;
  nHPMPRockSpell: Integer = 3;
  nRockAddHP: Integer = 10;
  nRockAddMP: Integer = 10;
  nRockAddHPMP: Integer = 10;

  boStartHPRockMsg: Boolean = True;
  boStartMPRockMsg: Boolean = True;
  boStartHPMPRockMsg: Boolean = True;

  sStartHPRockMsg: string = 'ÆøÑªÊ¯Æô¶¯£¡£¡£¡';
  sStartMPRockMsg: string = '»ÃÄ§Ê¯Æô¶¯£¡£¡£¡';
  sStartHPMPRockMsg: string = 'Ä§ÑªÊ¯Æô¶¯£¡£¡£¡';
  PlugClass: string = 'Config';
procedure MainOutMessage(Msg: string; nMode: Integer); overload;
procedure MainOutMessage(Msg: string); overload;
function GetCanStr(boCan: Boolean): string;
implementation

procedure MainOutMessage(Msg: string);
begin
  if Assigned(g_PlugEngine.MsgProc) then begin
    g_PlugEngine.MsgProc(PChar(Msg), Length(Msg), 1);
  end;
end;

procedure MainOutMessage(Msg: string; nMode: Integer);
begin
  if Assigned(g_PlugEngine.MsgProc) then begin
    g_PlugEngine.MsgProc(PChar(Msg), Length(Msg), nMode);
  end;
end;

function GetCanStr(boCan: Boolean): string;
begin
  if boCan then
    Result := '¡Ì'
  else Result := '';
end;

end.

