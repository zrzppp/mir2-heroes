unit PlugIn;

interface
uses
  Windows, Classes, SysUtils, Forms, ObjBase, Grobal2, SDK, HUtil32;
type
  TPlugInEngine = class
  public
    procedure HookDeCodeString(Value: TDeCryptString); virtual; abstract;
    procedure HookChangeCaptionText(Value: TChangeCaptionText); virtual; abstract;
    procedure HookChangeGateSocket(Value: TChangeGateSocket); virtual; abstract;
    procedure HookIPLocal(Value: TIPLocal); virtual; abstract;
    procedure HookGetMaxPlayObjectCount(Value: TGetMaxPlayObjectCount); virtual; abstract;
    procedure HookSetMaxPlayObjectCount(Value: TSetMaxPlayObjectCount); virtual; abstract;

    procedure HookGetFeature(Value: TObjectActionFeature); virtual; abstract;
    procedure HookObjectEnterAnotherMap(Value: TObjectActionEnterMap); virtual; abstract;
    procedure HookObjectDie(Value: TObjectActionEx); virtual; abstract;
    procedure HookObjectOffLine(Value: TObjectAction); virtual; abstract;
    procedure HookChangeCurrMap(Value: TObjectActionEx); virtual; abstract;
    procedure HookClientQueryBagItems(Value: TObjectAction); virtual; abstract;
    procedure HookClientQueryUserState(Value: TObjectActionXY); virtual; abstract;
    procedure HookSendActionGood(Value: TObjectAction); virtual; abstract;
    procedure HookSendActionFail(Value: TObjectAction); virtual; abstract;
    procedure HookSendWalkMsg(Value: TObjectActionXYD); virtual; abstract;
    procedure HookSendHorseRunMsg(Value: TObjectActionXYD); virtual; abstract;
    procedure HookSendRunMsg(Value: TObjectActionXYD); virtual; abstract;
    procedure HookSendDeathMsg(Value: TObjectActionXYDM); virtual; abstract;
    procedure HookSendSkeletonMsg(Value: TObjectActionXYD); virtual; abstract;
    procedure HookSendAliveMsg(Value: TObjectActionXYD); virtual; abstract;
    procedure HookSendSpaceMoveMsg(Value: TObjectActionXYDWS); virtual; abstract;
    procedure HookSendChangeFaceMsg(Value: TObjectActionObject); virtual; abstract;
    procedure HookSendUseitemsMsg(Value: TObjectAction); virtual; abstract;
    procedure HookSendUseMagicMsg(Value: TObjectAction); virtual; abstract;
    procedure HookSendUserLevelUpMsg(Value: TObjectAction); virtual; abstract;
    procedure HookSendUserAbilieyMsg(Value: TObjectAction); virtual; abstract;
    procedure HookSendUserStruckMsg(Value: TObjectActionObject); virtual; abstract;
    procedure HookSendSocket(Value: TPlaySendSocket); virtual; abstract;
    procedure HookSendGoodsList(Value: TObjectActionSendGoods); virtual; abstract;
    procedure HookSendUserStatusMsg(Value: TObjectActionXYDWS); virtual; abstract;
    procedure HookCheckCanDropItem(Value: TObjectActionItem); virtual; abstract;
    procedure HookCheckCanDealItem(Value: TObjectActionItem); virtual; abstract;
    procedure HookCheckCanStorageItem(Value: TObjectActionItem); virtual; abstract;
    procedure HookCheckCanRepairItem(Value: TObjectActionItem); virtual; abstract;
    procedure HookCheckUserItems(Value: TObjectActionCheckUserItem); virtual; abstract;
    procedure HookPlayObjectRun(Value: TObjectAction); virtual; abstract;
    procedure HookPlayObjectFilterMsg(Value: TObjectFilterMsg); virtual; abstract;
    procedure HookMerchantClientGetDetailGoodsList(Value: TObjectActionDetailGoods); virtual; abstract;
    procedure HookUserEngineRun(Value: TObjectAction); virtual; abstract;
    procedure HookObjectClientMsg(Value: TObjectClientMsg); virtual; abstract;
    procedure HookSetHookDoSpell(Value: TDoSpell); virtual; abstract;
    procedure HookPlayObjectUserLogin1(Value: TObjectAction); virtual; abstract;
    procedure HookPlayObjectUserLogin2(Value: TObjectAction); virtual; abstract;
    procedure HookPlayObjectUserLogin3(Value: TObjectAction); virtual; abstract;
    procedure HookPlayObjectUserLogin4(Value: TObjectAction); virtual; abstract;
    procedure HookPlayObjectCreate(Value: TObjectAction); virtual; abstract;
    procedure HookPlayObjectDestroy(Value: TObjectAction); virtual; abstract;
    procedure HookPlayObjectUserCmd(Value: TObjectUserCmd); virtual; abstract;
    procedure HookObjectOperateMessage(Value: TObjectOperateMessage); virtual; abstract;
    procedure HookQuestActionScriptCmd(Value: TScriptCmd); virtual; abstract;
    procedure HookQuestConditionScriptCmd(Value: TScriptCmd); virtual; abstract;
    procedure HookActionScriptProcess(Value: TScriptAction); virtual; abstract;
    procedure HookConditionScriptProcess(Value: TScriptCondition); virtual; abstract;
    procedure HookPlayObjectUserSelect(Value: TObjectActionUserSelect); virtual; abstract;
    procedure HookCheckCanUpgradeItem(Value: TObjectActionItem); virtual; abstract;
    procedure HookCheckCanSellItem(Value: TObjectActionItem); virtual; abstract;
    procedure HookCheckNotCanScatterItem(Value: TObjectActionItem); virtual; abstract;
    procedure HookCheckCanDieScatterItem(Value: TObjectActionItem); virtual; abstract;

    procedure HookProcessHumans(Value: PChar; Len: Integer); virtual; abstract;


    procedure GetDeCodeString(Buffer: PChar; var Len: Integer); virtual; abstract;
    procedure GetChangeCaptionText(Buffer: PChar; var Len: Integer); virtual; abstract;
    procedure GetChangeGateSocket(Buffer: PChar; var Len: Integer); virtual; abstract;
    procedure GetIPLocal(Buffer: PChar; var Len: Integer); virtual; abstract;
    procedure GetGetMaxPlayObjectCount(Buffer: PChar; var Len: Integer); virtual; abstract;
    procedure GetSetMaxPlayObjectCount(Buffer: PChar; var Len: Integer); virtual; abstract;


    function GetGetFeature: TObjectActionFeature; virtual; abstract;
    function GetObjectEnterAnotherMap: TObjectActionEnterMap; virtual; abstract;
    function GetObjectDie: TObjectActionEx; virtual; abstract;
    function GetObjectOffLine: TObjectAction; virtual; abstract;
    function GetChangeCurrMap: TObjectActionEx; virtual; abstract;
    function GetClientQueryBagItems: TObjectAction; virtual; abstract;
    function GetClientQueryUserState: TObjectActionXY; virtual; abstract;
    function GetSendActionGood: TObjectAction; virtual; abstract;
    function GetSendActionFail: TObjectAction; virtual; abstract;
    function GetSendWalkMsg: TObjectActionXYD; virtual; abstract;
    function GetSendHorseRunMsg: TObjectActionXYD; virtual; abstract;
    function GetSendRunMsg: TObjectActionXYD; virtual; abstract;
    function GetSendDeathMsg: TObjectActionXYDM; virtual; abstract;
    function GetSendSkeletonMsg: TObjectActionXYD; virtual; abstract;
    function GetSendAliveMsg: TObjectActionXYD; virtual; abstract;
    function GetSendSpaceMoveMsg: TObjectActionXYDWS; virtual; abstract;
    function GetSendChangeFaceMsg: TObjectActionObject; virtual; abstract;
    function GetSendUseitemsMsg: TObjectAction; virtual; abstract;
    function GetSendUseMagicMsg: TObjectAction; virtual; abstract;
    function GetSendUserLevelUpMsg: TObjectAction; virtual; abstract;
    function GetSendUserAbilieyMsg: TObjectAction; virtual; abstract;
    function GetSendUserStruckMsg: TObjectActionObject; virtual; abstract;
    function GetSendSocket: TPlaySendSocket; virtual; abstract;
    function GetSendGoodsList: TObjectActionSendGoods; virtual; abstract;
    function GetSendUserStatusMsg: TObjectActionXYDWS; virtual; abstract;
    function GetCheckCanDropItem: TObjectActionItem; virtual; abstract;
    function GetCheckCanDealItem: TObjectActionItem; virtual; abstract;
    function GetCheckCanStorageItem: TObjectActionItem; virtual; abstract;
    function GetCheckCanRepairItem: TObjectActionItem; virtual; abstract;
    function GetCheckUserItems: TObjectActionCheckUserItem; virtual; abstract;
    function GetPlayObjectRun: TObjectAction; virtual; abstract;
    function GetPlayObjectFilterMsg: TObjectFilterMsg; virtual; abstract;
    function GetMerchantClientGetDetailGoodsList: TObjectActionDetailGoods; virtual; abstract;
    function GetUserEngineRun: TObjectAction; virtual; abstract;
    function GetObjectClientMsg: TObjectClientMsg; virtual; abstract;
    function GetSetHookDoSpell: TDoSpell; virtual; abstract;
    function GetPlayObjectUserLogin1: TObjectAction; virtual; abstract;
    function GetPlayObjectUserLogin2: TObjectAction; virtual; abstract;
    function GetPlayObjectUserLogin3: TObjectAction; virtual; abstract;
    function GetPlayObjectUserLogin4: TObjectAction; virtual; abstract;
    function GetPlayObjectCreate: TObjectAction; virtual; abstract;
    function GetPlayObjectDestroy: TObjectAction; virtual; abstract;
    function GetPlayObjectUserCmd: TObjectUserCmd; virtual; abstract;
    function GetObjectOperateMessage: TObjectOperateMessage; virtual; abstract;
    function GetQuestActionScriptCmd: TScriptCmd; virtual; abstract;
    function GetQuestConditionScriptCmd: TScriptCmd; virtual; abstract;
    function GetActionScriptProcess: TScriptAction; virtual; abstract;
    function GetConditionScriptProcess: TScriptCondition; virtual; abstract;
    function GetPlayObjectUserSelect: TObjectActionUserSelect; virtual; abstract;
    function GetCheckCanUpgradeItem: TObjectActionItem; virtual; abstract;
    function GetCheckCanSellItem: TObjectActionItem; virtual; abstract;
    function GetCheckNotCanScatterItem: TObjectActionItem; virtual; abstract;
    function GetCheckCanDieScatterItem: TObjectActionItem; virtual; abstract;
  end;

  TPlugInManage = class(TPlugInEngine)
    PlugList: TStringList;
    Run: TMethod;
    ScriptDeCryptString: TDeCryptString;
    IPLocal: TIPLocal;
    ChangeCaptionText: TChangeCaptionText;
    ChangeGateSocket: TChangeGateSocket;
    GetMaxPlayObjectCount: TGetMaxPlayObjectCount;
    SetMaxPlayObjectCount: TSetMaxPlayObjectCount;

    GetFeature: TObjectActionFeature;
    ObjectEnterAnotherMap: TObjectActionEnterMap;
    ObjectDie: TObjectActionEx;
    ObjectOffLine: TObjectAction;

    ChangeCurrMap: TObjectActionEx;
    ClientQueryBagItems: TObjectAction;
    ClientQueryUserState: TObjectActionXY;
    SendActionGood: TObjectAction;
    SendActionFail: TObjectAction;
    SendWalkMsg: TObjectActionXYD;
    SendHorseRunMsg: TObjectActionXYD;
    SendRunMsg: TObjectActionXYD;
    SendDeathMsg: TObjectActionXYDM;
    SendSkeletonMsg: TObjectActionXYD;
    SendAliveMsg: TObjectActionXYD;
    SendSpaceMoveMsg: TObjectActionXYDWS;
    SendChangeFaceMsg: TObjectActionObject;
    SendUseitemsMsg: TObjectAction;
    SendUseMagicMsg: TObjectAction;
    SendUserLevelUpMsg: TObjectAction;
    SendUserAbilieyMsg: TObjectAction;
    SendUserStruckMsg: TObjectActionObject;
    SendSocket: TPlaySendSocket;
    SendGoodsList: TObjectActionSendGoods;
    SendUserStatusMsg: TObjectActionXYDWS;
    CheckCanDropItem: TObjectActionItem;
    CheckCanDealItem: TObjectActionItem;
    CheckCanStorageItem: TObjectActionItem;
    CheckCanRepairItem: TObjectActionItem;
    CheckUserItems: TObjectActionCheckUserItem;
    PlayObjectRun: TObjectAction;
    PlayObjectFilterMsg: TObjectFilterMsg;
    MerchantClientGetDetailGoodsList: TObjectActionDetailGoods;
    UserEngineRun: TObjectAction;
    ObjectClientMsg: TObjectClientMsg;
    SetHookDoSpell: TDoSpell;
    PlayObjectUserLogin1: TObjectAction;
    PlayObjectUserLogin2: TObjectAction;
    PlayObjectUserLogin3: TObjectAction;
    PlayObjectUserLogin4: TObjectAction;
    PlayObjectCreate: TObjectAction;
    PlayObjectDestroy: TObjectAction;
    PlayObjectUserCmd: TObjectUserCmd;
    ObjectOperateMessage: TObjectOperateMessage;
    QuestActionScriptCmd: TScriptCmd;
    QuestConditionScriptCmd: TScriptCmd;
    ActionScriptProcess: TScriptAction;
    ConditionScriptProcess: TScriptCondition;
    PlayObjectUserSelect: TObjectActionUserSelect;

    CheckCanUpgradeItem: TObjectActionItem;
    CheckCanSellItem: TObjectActionItem;
    CheckNotCanScatterItem: TObjectActionItem;
    CheckCanDieScatterItem: TObjectActionItem;

    ProcessHumans: TStartProc;
  private
    procedure Initialize;
    function GetPlug(Module: THandle; sPlugLibFileName: string): Boolean;
  public
    constructor Create();
    destructor Destroy; override;
//=============================================================================
    procedure HookDeCodeString(Value: TDeCryptString); override;
    procedure HookChangeCaptionText(Value: TChangeCaptionText); override;
    procedure HookChangeGateSocket(Value: TChangeGateSocket); override;
    procedure HookIPLocal(Value: TIPLocal); override;
    procedure HookGetMaxPlayObjectCount(Value: TGetMaxPlayObjectCount); override;
    procedure HookSetMaxPlayObjectCount(Value: TSetMaxPlayObjectCount); override;


    procedure HookGetFeature(Value: TObjectActionFeature); override;
    procedure HookObjectEnterAnotherMap(Value: TObjectActionEnterMap); override;
    procedure HookObjectDie(Value: TObjectActionEx); override;
    procedure HookObjectOffLine(Value: TObjectAction); override;
    procedure HookChangeCurrMap(Value: TObjectActionEx); override;
    procedure HookClientQueryBagItems(Value: TObjectAction); override;
    procedure HookClientQueryUserState(Value: TObjectActionXY); override;
    procedure HookSendActionGood(Value: TObjectAction); override;
    procedure HookSendActionFail(Value: TObjectAction); override;
    procedure HookSendWalkMsg(Value: TObjectActionXYD); override;
    procedure HookSendHorseRunMsg(Value: TObjectActionXYD); override;
    procedure HookSendRunMsg(Value: TObjectActionXYD); override;
    procedure HookSendDeathMsg(Value: TObjectActionXYDM); override;
    procedure HookSendSkeletonMsg(Value: TObjectActionXYD); override;
    procedure HookSendAliveMsg(Value: TObjectActionXYD); override;
    procedure HookSendSpaceMoveMsg(Value: TObjectActionXYDWS); override;
    procedure HookSendChangeFaceMsg(Value: TObjectActionObject); override;
    procedure HookSendUseitemsMsg(Value: TObjectAction); override;
    procedure HookSendUseMagicMsg(Value: TObjectAction); override;
    procedure HookSendUserLevelUpMsg(Value: TObjectAction); override;
    procedure HookSendUserAbilieyMsg(Value: TObjectAction); override;
    procedure HookSendUserStruckMsg(Value: TObjectActionObject); override;
    procedure HookSendSocket(Value: TPlaySendSocket); override;
    procedure HookSendGoodsList(Value: TObjectActionSendGoods); override;
    procedure HookSendUserStatusMsg(Value: TObjectActionXYDWS); override;
    procedure HookCheckCanDropItem(Value: TObjectActionItem); override;
    procedure HookCheckCanDealItem(Value: TObjectActionItem); override;
    procedure HookCheckCanStorageItem(Value: TObjectActionItem); override;
    procedure HookCheckCanRepairItem(Value: TObjectActionItem); override;
    procedure HookCheckUserItems(Value: TObjectActionCheckUserItem); override;
    procedure HookPlayObjectRun(Value: TObjectAction); override;
    procedure HookPlayObjectFilterMsg(Value: TObjectFilterMsg); override;
    procedure HookMerchantClientGetDetailGoodsList(Value: TObjectActionDetailGoods); override;
    procedure HookUserEngineRun(Value: TObjectAction); override;
    procedure HookObjectClientMsg(Value: TObjectClientMsg); override;
    procedure HookSetHookDoSpell(Value: TDoSpell); override;
    procedure HookPlayObjectUserLogin1(Value: TObjectAction); override;
    procedure HookPlayObjectUserLogin2(Value: TObjectAction); override;
    procedure HookPlayObjectUserLogin3(Value: TObjectAction); override;
    procedure HookPlayObjectUserLogin4(Value: TObjectAction); override;
    procedure HookPlayObjectCreate(Value: TObjectAction); override;
    procedure HookPlayObjectDestroy(Value: TObjectAction); override;
    procedure HookPlayObjectUserCmd(Value: TObjectUserCmd); override;
    procedure HookObjectOperateMessage(Value: TObjectOperateMessage); override;
    procedure HookQuestActionScriptCmd(Value: TScriptCmd); override;
    procedure HookQuestConditionScriptCmd(Value: TScriptCmd); override;
    procedure HookActionScriptProcess(Value: TScriptAction); override;
    procedure HookConditionScriptProcess(Value: TScriptCondition); override;
    procedure HookPlayObjectUserSelect(Value: TObjectActionUserSelect); override;
    procedure HookCheckCanUpgradeItem(Value: TObjectActionItem); override;
    procedure HookCheckCanSellItem(Value: TObjectActionItem); override;
    procedure HookCheckNotCanScatterItem(Value: TObjectActionItem); override;
    procedure HookCheckCanDieScatterItem(Value: TObjectActionItem); override;

    procedure HookProcessHumans(Value: PChar; Len: Integer); override;

    procedure GetDeCodeString(Buffer: PChar; var Len: Integer); override;
    procedure GetChangeCaptionText(Buffer: PChar; var Len: Integer); override;
    procedure GetChangeGateSocket(Buffer: PChar; var Len: Integer); override;
    procedure GetIPLocal(Buffer: PChar; var Len: Integer); override;
    procedure GetGetMaxPlayObjectCount(Buffer: PChar; var Len: Integer); override;
    procedure GetSetMaxPlayObjectCount(Buffer: PChar; var Len: Integer); override;


    function GetGetFeature: TObjectActionFeature; override;
    function GetObjectEnterAnotherMap: TObjectActionEnterMap; override;
    function GetObjectDie: TObjectActionEx; override;
    function GetObjectOffLine: TObjectAction; override;
    function GetChangeCurrMap: TObjectActionEx; override;
    function GetClientQueryBagItems: TObjectAction; override;
    function GetClientQueryUserState: TObjectActionXY; override;
    function GetSendActionGood: TObjectAction; override;
    function GetSendActionFail: TObjectAction; override;
    function GetSendWalkMsg: TObjectActionXYD; override;
    function GetSendHorseRunMsg: TObjectActionXYD; override;
    function GetSendRunMsg: TObjectActionXYD; override;
    function GetSendDeathMsg: TObjectActionXYDM; override;
    function GetSendSkeletonMsg: TObjectActionXYD; override;
    function GetSendAliveMsg: TObjectActionXYD; override;
    function GetSendSpaceMoveMsg: TObjectActionXYDWS; override;
    function GetSendChangeFaceMsg: TObjectActionObject; override;
    function GetSendUseitemsMsg: TObjectAction; override;
    function GetSendUseMagicMsg: TObjectAction; override;
    function GetSendUserLevelUpMsg: TObjectAction; override;
    function GetSendUserAbilieyMsg: TObjectAction; override;
    function GetSendUserStruckMsg: TObjectActionObject; override;
    function GetSendSocket: TPlaySendSocket; override;
    function GetSendGoodsList: TObjectActionSendGoods; override;
    function GetSendUserStatusMsg: TObjectActionXYDWS; override;
    function GetCheckCanDropItem: TObjectActionItem; override;
    function GetCheckCanDealItem: TObjectActionItem; override;
    function GetCheckCanStorageItem: TObjectActionItem; override;
    function GetCheckCanRepairItem: TObjectActionItem; override;
    function GetCheckUserItems: TObjectActionCheckUserItem; override;
    function GetPlayObjectRun: TObjectAction; override;
    function GetPlayObjectFilterMsg: TObjectFilterMsg; override;
    function GetMerchantClientGetDetailGoodsList: TObjectActionDetailGoods; override;
    function GetUserEngineRun: TObjectAction; override;
    function GetObjectClientMsg: TObjectClientMsg; override;
    function GetSetHookDoSpell: TDoSpell; override;
    function GetPlayObjectUserLogin1: TObjectAction; override;
    function GetPlayObjectUserLogin2: TObjectAction; override;
    function GetPlayObjectUserLogin3: TObjectAction; override;
    function GetPlayObjectUserLogin4: TObjectAction; override;
    function GetPlayObjectCreate: TObjectAction; override;
    function GetPlayObjectDestroy: TObjectAction; override;
    function GetPlayObjectUserCmd: TObjectUserCmd; override;
    function GetObjectOperateMessage: TObjectOperateMessage; override;
    function GetQuestActionScriptCmd: TScriptCmd; override;
    function GetQuestConditionScriptCmd: TScriptCmd; override;
    function GetActionScriptProcess: TScriptAction; override;
    function GetConditionScriptProcess: TScriptCondition; override;
    function GetPlayObjectUserSelect: TObjectActionUserSelect; override;
    function GetCheckCanUpgradeItem: TObjectActionItem; override;
    function GetCheckCanSellItem: TObjectActionItem; override;
    function GetCheckNotCanScatterItem: TObjectActionItem; override;
    function GetCheckCanDieScatterItem: TObjectActionItem; override;

    procedure StartPlugMoudle();
    procedure LoadPlugIn();
    procedure UnLoadPlugIn();
  end;
procedure MainMessage(Msg: PChar; nMsgLen: Integer; nMode: Integer); stdcall;
procedure SendBroadCastMsg(Msg: PChar; MsgType: TMsgType); stdcall;
function FindEngnProc(ProcName: PChar; nNameLen: Integer; nProcCode: Integer): Pointer; stdcall;
function FindPlugProc(ProcName: PChar; nNameLen: Integer; nProcCode: Integer): Pointer; stdcall;
function SetProcTable(ProcAddr: Pointer; ProcName: PChar; nNameLen: Integer; nProcCode: Integer): Boolean; stdcall;
function FindOBjTable(ObjName: PChar; nNameLen: Integer; nObjcCode: Integer): TObject; stdcall;

implementation

uses svMain, PlugOfEngine, M2Share, EncryptUnit, Common;

procedure MainMessage(Msg: PChar; nMsgLen: Integer; nMode: Integer);
var
  MsgBuff: string;
begin
  if (Msg <> nil) and (nMsgLen > 0) then begin
    SetLength(MsgBuff, nMsgLen);
    Move(Msg^, MsgBuff[1], nMsgLen);
    case nMode of
      0: if Memo <> nil then Memo.Lines.Add(MsgBuff);
    else MainOutMessage(MsgBuff);
    end;
  end;
end;

procedure SendBroadCastMsg(Msg: PChar; MsgType: TMsgType); stdcall;
begin
  if UserEngine <> nil then
    UserEngine.SendBroadCastMsgExt(Msg, MsgType);
end;

//=================================
//由DLL调用按名字查找函数地址

function FindPlugProc(ProcName: PChar; nNameLen: Integer; nProcCode: Integer): Pointer;
var
  I: Integer;
  sProcName: string;
begin
  Result := nil;
  SetLength(sProcName, nNameLen);
  Move(ProcName^, sProcName[1], nNameLen);
  for I := Low(PlugProcArray) to High(PlugProcArray) do begin
    if {(PlugProcArray[I].nProcAddr = nil) and }(CompareText(sProcName, PlugProcArray[I].sProcName) = 0) and (PlugProcArray[I].nProcCode = nProcCode) then begin
      Result := PlugProcArray[I].nProcAddr;
      Break;
    end;
  end;
end;

function FindEngnProc(ProcName: PChar; nNameLen: Integer; nProcCode: Integer): Pointer;
var
  I: Integer;
  sProcName: string;
begin
  Result := nil;
  SetLength(sProcName, nNameLen);
  Move(ProcName^, sProcName[1], nNameLen);
  for I := Low(ProcArray) to High(ProcArray) do begin
    if (ProcArray[I].nProcAddr <> nil) and (CompareText(sProcName, ProcArray[I].sProcName) = 0) and (ProcArray[I].nProcCode = nProcCode) then begin
      Result := ProcArray[I].nProcAddr;
      Break;
    end;
  end;
end;
//=================================
//由DLL调用按名字设置插件中的函数地址

function SetProcTable(ProcAddr: Pointer; ProcName: PChar; nNameLen: Integer; nProcCode: Integer): Boolean;
var
  I: Integer;
  sProcName: string;
begin
  Result := False;
  SetLength(sProcName, nNameLen);
  Move(ProcName^, sProcName[1], nNameLen);
  for I := Low(PlugProcArray) to High(PlugProcArray) do begin
    if (PlugProcArray[I].nProcAddr = nil) and (CompareText(sProcName, PlugProcArray[I].sProcName) = 0) and (PlugProcArray[I].nProcCode = nProcCode) then begin
      PlugProcArray[I].nProcAddr := ProcAddr;
      Result := True;
      Break;
    end;
  end;
end;

//=================================
//由DLL调用按名字查找全局对象地址

function FindOBjTable(ObjName: PChar; nNameLen: Integer; nObjcCode: Integer): TObject;
var
  I: Integer;
  sObjName: string;
begin
  Result := nil;
  SetLength(sObjName, nNameLen);
  Move(ObjName^, sObjName[1], nNameLen);
  for I := Low(ProcArray) to High(ProcArray) do begin
    if (ObjectArray[I].Obj <> nil) and (CompareText(sObjName, ObjectArray[I].sObjcName) = 0) and (ObjectArray[I].nObjcCode = nObjcCode) then begin
      Result := @ObjectArray[I];
      Break;
    end;
  end;
end;
{ TPlugIn }

constructor TPlugInManage.Create;
begin
  Initialize;
  PlugList := TStringList.Create;
end;

destructor TPlugInManage.Destroy;
begin
  UnLoadPlugIn();
  PlugList.Free;
  inherited;
end;


procedure TPlugInManage.HookChangeCaptionText(Value: TChangeCaptionText);
begin
  ChangeCaptionText := Value;
end;

procedure TPlugInManage.HookChangeGateSocket(Value: TChangeGateSocket);
begin
  ChangeGateSocket := Value;
end;

procedure TPlugInManage.HookDeCodeString(Value: TDeCryptString);
begin
  ScriptDeCryptString := Value;
end;

procedure TPlugInManage.HookIPLocal(Value: TIPLocal);
begin
  IPLocal := Value;
end;

procedure TPlugInManage.HookGetMaxPlayObjectCount(Value: TGetMaxPlayObjectCount);
begin
  GetMaxPlayObjectCount := Value;
end;

procedure TPlugInManage.HookSetMaxPlayObjectCount(Value: TSetMaxPlayObjectCount);
begin
  SetMaxPlayObjectCount := Value;
end;

//==============================================================================

procedure TPlugInManage.HookGetFeature(Value: TObjectActionFeature);
begin
  GetFeature := Value;
end;

procedure TPlugInManage.HookObjectEnterAnotherMap(Value: TObjectActionEnterMap);
begin
  ObjectEnterAnotherMap := Value;
end;

procedure TPlugInManage.HookObjectDie(Value: TObjectActionEx);
begin
  ObjectDie := Value;
end;

procedure TPlugInManage.HookObjectOffLine(Value: TObjectAction);
begin
  ObjectOffLine := Value;
end;

procedure TPlugInManage.HookChangeCurrMap(Value: TObjectActionEx);
begin
  ChangeCurrMap := Value;
end;

procedure TPlugInManage.HookClientQueryBagItems(Value: TObjectAction);
begin
  ClientQueryBagItems := Value;
end;

procedure TPlugInManage.HookClientQueryUserState(Value: TObjectActionXY);
begin
  ClientQueryUserState := Value;
end;

procedure TPlugInManage.HookSendActionGood(Value: TObjectAction);
begin
  SendActionGood := Value;
end;

procedure TPlugInManage.HookSendActionFail(Value: TObjectAction);
begin
  SendActionFail := Value;
end;

procedure TPlugInManage.HookSendWalkMsg(Value: TObjectActionXYD);
begin
  SendWalkMsg := Value;
end;

procedure TPlugInManage.HookSendHorseRunMsg(Value: TObjectActionXYD);
begin
  SendHorseRunMsg := Value;
end;

procedure TPlugInManage.HookSendRunMsg(Value: TObjectActionXYD);
begin
  SendRunMsg := Value;
end;

procedure TPlugInManage.HookSendDeathMsg(Value: TObjectActionXYDM);
begin
  SendDeathMsg := Value;
end;

procedure TPlugInManage.HookSendSkeletonMsg(Value: TObjectActionXYD);
begin
  SendSkeletonMsg := Value;
end;

procedure TPlugInManage.HookSendAliveMsg(Value: TObjectActionXYD);
begin
  SendAliveMsg := Value;
end;

procedure TPlugInManage.HookSendSpaceMoveMsg(Value: TObjectActionXYDWS);
begin
  SendSpaceMoveMsg := Value;
end;

procedure TPlugInManage.HookSendChangeFaceMsg(Value: TObjectActionObject);
begin
  SendChangeFaceMsg := Value;
end;

procedure TPlugInManage.HookSendUseitemsMsg(Value: TObjectAction);
begin
  SendUseitemsMsg := Value;
end;

procedure TPlugInManage.HookSendUseMagicMsg(Value: TObjectAction);
begin
  SendUseMagicMsg := Value;
end;

procedure TPlugInManage.HookSendUserLevelUpMsg(Value: TObjectAction);
begin
  SendUserLevelUpMsg := Value;
end;

procedure TPlugInManage.HookSendUserAbilieyMsg(Value: TObjectAction);
begin
  SendUserAbilieyMsg := Value;
end;

procedure TPlugInManage.HookSendUserStruckMsg(Value: TObjectActionObject);
begin
  SendUserStruckMsg := Value;
end;

procedure TPlugInManage.HookSendSocket(Value: TPlaySendSocket);
begin
  SendSocket := Value;
end;

procedure TPlugInManage.HookSendGoodsList(Value: TObjectActionSendGoods);
begin
  SendGoodsList := Value;
end;

procedure TPlugInManage.HookSendUserStatusMsg(Value: TObjectActionXYDWS);
begin
  SendUserStatusMsg := Value;
end;

procedure TPlugInManage.HookCheckCanDropItem(Value: TObjectActionItem);
begin
  CheckCanDropItem := Value;
end;

procedure TPlugInManage.HookCheckCanDealItem(Value: TObjectActionItem);
begin
  CheckCanDealItem := Value;
end;

procedure TPlugInManage.HookCheckCanStorageItem(Value: TObjectActionItem);
begin
  CheckCanStorageItem := Value;
end;

procedure TPlugInManage.HookCheckCanRepairItem(Value: TObjectActionItem);
begin
  CheckCanRepairItem := Value;
end;

procedure TPlugInManage.HookCheckUserItems(Value: TObjectActionCheckUserItem);
begin
  CheckUserItems := Value;
end;

procedure TPlugInManage.HookPlayObjectRun(Value: TObjectAction);
begin
  PlayObjectRun := Value;
end;

procedure TPlugInManage.HookPlayObjectFilterMsg(Value: TObjectFilterMsg);
begin
  PlayObjectFilterMsg := Value;
end;

procedure TPlugInManage.HookMerchantClientGetDetailGoodsList(Value: TObjectActionDetailGoods);
begin
  MerchantClientGetDetailGoodsList := Value;
end;

procedure TPlugInManage.HookUserEngineRun(Value: TObjectAction);
begin
  UserEngineRun := Value;
end;

procedure TPlugInManage.HookObjectClientMsg(Value: TObjectClientMsg);
begin
  ObjectClientMsg := Value;
end;

procedure TPlugInManage.HookSetHookDoSpell(Value: TDoSpell);
begin
  SetHookDoSpell := Value;
end;

procedure TPlugInManage.HookPlayObjectUserLogin1(Value: TObjectAction);
begin
  PlayObjectUserLogin1 := Value;
end;

procedure TPlugInManage.HookPlayObjectUserLogin2(Value: TObjectAction);
begin
  PlayObjectUserLogin2 := Value;
end;

procedure TPlugInManage.HookPlayObjectUserLogin3(Value: TObjectAction);
begin
  PlayObjectUserLogin3 := Value;
end;

procedure TPlugInManage.HookPlayObjectUserLogin4(Value: TObjectAction);
begin
  PlayObjectUserLogin4 := Value;
end;

procedure TPlugInManage.HookPlayObjectCreate(Value: TObjectAction);
begin
  PlayObjectCreate := Value;
end;

procedure TPlugInManage.HookPlayObjectDestroy(Value: TObjectAction);
begin
  PlayObjectDestroy := Value;
end;

procedure TPlugInManage.HookPlayObjectUserCmd(Value: TObjectUserCmd);
begin
  PlayObjectUserCmd := Value;
end;

procedure TPlugInManage.HookObjectOperateMessage(Value: TObjectOperateMessage);
begin
  ObjectOperateMessage := Value;
end;

procedure TPlugInManage.HookQuestActionScriptCmd(Value: TScriptCmd);
begin
  QuestActionScriptCmd := Value;
end;

procedure TPlugInManage.HookQuestConditionScriptCmd(Value: TScriptCmd);
begin
  QuestConditionScriptCmd := Value;
end;

procedure TPlugInManage.HookActionScriptProcess(Value: TScriptAction);
begin
  ActionScriptProcess := Value;
end;

procedure TPlugInManage.HookConditionScriptProcess(Value: TScriptCondition);
begin
  ConditionScriptProcess := Value;
end;

procedure TPlugInManage.HookPlayObjectUserSelect(Value: TObjectActionUserSelect);
begin
  PlayObjectUserSelect := Value;
end;

procedure TPlugInManage.HookCheckCanUpgradeItem(Value: TObjectActionItem);
begin
  CheckCanUpgradeItem := Value;
end;

procedure TPlugInManage.HookCheckCanSellItem(Value: TObjectActionItem);
begin
  CheckCanSellItem := Value;
end;

procedure TPlugInManage.HookCheckNotCanScatterItem(Value: TObjectActionItem);
begin
  CheckNotCanScatterItem := Value;
end;

procedure TPlugInManage.HookCheckCanDieScatterItem(Value: TObjectActionItem);
begin
  CheckCanDieScatterItem := Value;
end;

procedure TPlugInManage.HookProcessHumans(Value: PChar; Len: Integer);
begin
end;
//==============================================================================

procedure TPlugInManage.GetDeCodeString(Buffer: PChar; var Len: Integer);
var
  nDeCodeString: Integer;
  sBuffer: string;
begin
  nDeCodeString := Integer(@ScriptDeCryptString);
  sBuffer := EncryptString(IntToStr(nDeCodeString));
  Len := Length(sBuffer);
  Move(sBuffer[1], Buffer^, Len);
end;

procedure TPlugInManage.GetIPLocal(Buffer: PChar; var Len: Integer);
var
  nIPLocal: Integer;
  sBuffer: string;
begin
  nIPLocal := Integer(@IPLocal);
  sBuffer := EncryptString(IntToStr(nIPLocal));
  Len := Length(sBuffer);
  Move(sBuffer[1], Buffer^, Len);
end;

procedure TPlugInManage.GetChangeCaptionText(Buffer: PChar; var Len: Integer);
var
  nChangeCaptionText: Integer;
  sBuffer: string;
begin
  nChangeCaptionText := Integer(@ChangeCaptionText);
  sBuffer := EncryptString(IntToStr(nChangeCaptionText));
  Len := Length(sBuffer);
  Move(sBuffer[1], Buffer^, Len);
end;

procedure TPlugInManage.GetChangeGateSocket(Buffer: PChar; var Len: Integer);
var
  nChangeGateSocket: Integer;
  sBuffer: string;
begin
  nChangeGateSocket := Integer(@ChangeGateSocket);
  sBuffer := EncryptString(IntToStr(nChangeGateSocket));
  Len := Length(sBuffer);
  Move(sBuffer[1], Buffer^, Len);
  //MainOutMessage('nChangeGateSocket:'+IntToStr(nChangeGateSocket));
  //Result := _EncryptString(IntToStr(nChangeGateSocket));
end;

procedure TPlugInManage.GetGetMaxPlayObjectCount(Buffer: PChar; var Len: Integer);
var
  nGetMaxPlayObjectCount: Integer;
  sBuffer: string;
begin
  nGetMaxPlayObjectCount := Integer(@GetMaxPlayObjectCount);
  sBuffer := EncryptString(IntToStr(nGetMaxPlayObjectCount));
  Len := Length(sBuffer);
  Move(sBuffer[1], Buffer^, Len);
end;

procedure TPlugInManage.GetSetMaxPlayObjectCount(Buffer: PChar; var Len: Integer);
var
  nSetMaxPlayObjectCount: Integer;
  sBuffer: string;
begin
  nSetMaxPlayObjectCount := Integer(@SetMaxPlayObjectCount);
  sBuffer := EncryptString(IntToStr(nSetMaxPlayObjectCount));
  Len := Length(sBuffer);
  Move(sBuffer[1], Buffer^, Len);
end;
//==============================================================================

function TPlugInManage.GetGetFeature: TObjectActionFeature;
begin
  Result := GetFeature;
end;

function TPlugInManage.GetObjectEnterAnotherMap: TObjectActionEnterMap;
begin
  Result := ObjectEnterAnotherMap;
end;

function TPlugInManage.GetObjectDie: TObjectActionEx;
begin
  Result := ObjectDie;
end;

function TPlugInManage.GetObjectOffLine: TObjectAction;
begin
  Result := ObjectOffLine;
end;

function TPlugInManage.GetChangeCurrMap: TObjectActionEx;
begin
  Result := ChangeCurrMap;
end;

function TPlugInManage.GetClientQueryBagItems: TObjectAction;
begin
  Result := ClientQueryBagItems;
end;

function TPlugInManage.GetClientQueryUserState: TObjectActionXY;
begin
  Result := ClientQueryUserState;
end;

function TPlugInManage.GetSendActionGood: TObjectAction;
begin
  Result := SendActionGood;
end;

function TPlugInManage.GetSendActionFail: TObjectAction;
begin
  Result := SendActionFail;
end;

function TPlugInManage.GetSendWalkMsg: TObjectActionXYD;
begin
  Result := SendWalkMsg;
end;

function TPlugInManage.GetSendHorseRunMsg: TObjectActionXYD;
begin
  Result := SendHorseRunMsg;
end;

function TPlugInManage.GetSendRunMsg: TObjectActionXYD;
begin
  Result := SendRunMsg;
end;

function TPlugInManage.GetSendDeathMsg: TObjectActionXYDM;
begin
  Result := SendDeathMsg;
end;

function TPlugInManage.GetSendSkeletonMsg: TObjectActionXYD;
begin
  Result := SendSkeletonMsg;
end;

function TPlugInManage.GetSendAliveMsg: TObjectActionXYD;
begin
  Result := SendAliveMsg;
end;

function TPlugInManage.GetSendSpaceMoveMsg: TObjectActionXYDWS;
begin
  Result := SendSpaceMoveMsg;
end;

function TPlugInManage.GetSendChangeFaceMsg: TObjectActionObject;
begin
  Result := SendChangeFaceMsg;
end;

function TPlugInManage.GetSendUseitemsMsg: TObjectAction;
begin
  Result := SendUseitemsMsg;
end;

function TPlugInManage.GetSendUseMagicMsg: TObjectAction;
begin
  Result := SendUseMagicMsg;
end;

function TPlugInManage.GetSendUserLevelUpMsg: TObjectAction;
begin
  Result := SendUserLevelUpMsg;
end;

function TPlugInManage.GetSendUserAbilieyMsg: TObjectAction;
begin
  Result := SendUserAbilieyMsg;
end;

function TPlugInManage.GetSendUserStruckMsg: TObjectActionObject;
begin
  Result := SendUserStruckMsg;
end;

function TPlugInManage.GetSendSocket: TPlaySendSocket;
begin
  Result := SendSocket;
end;

function TPlugInManage.GetSendGoodsList: TObjectActionSendGoods;
begin
  Result := SendGoodsList;
end;

function TPlugInManage.GetSendUserStatusMsg: TObjectActionXYDWS;
begin
  Result := SendUserStatusMsg;
end;

function TPlugInManage.GetCheckCanDropItem: TObjectActionItem;
begin
  Result := CheckCanDropItem;
end;

function TPlugInManage.GetCheckCanDealItem: TObjectActionItem;
begin
  Result := CheckCanDealItem;
end;

function TPlugInManage.GetCheckCanStorageItem: TObjectActionItem;
begin
  Result := CheckCanStorageItem;
end;

function TPlugInManage.GetCheckCanRepairItem: TObjectActionItem;
begin
  Result := CheckCanRepairItem;
end;

function TPlugInManage.GetCheckUserItems: TObjectActionCheckUserItem;
begin
  Result := CheckUserItems;
end;

function TPlugInManage.GetPlayObjectRun: TObjectAction;
begin
  Result := PlayObjectRun;
end;

function TPlugInManage.GetPlayObjectFilterMsg: TObjectFilterMsg;
begin
  Result := PlayObjectFilterMsg;
end;

function TPlugInManage.GetMerchantClientGetDetailGoodsList: TObjectActionDetailGoods;
begin
  Result := MerchantClientGetDetailGoodsList;
end;

function TPlugInManage.GetUserEngineRun: TObjectAction;
begin
  Result := UserEngineRun;
end;

function TPlugInManage.GetObjectClientMsg: TObjectClientMsg;
begin
  Result := ObjectClientMsg;
end;

function TPlugInManage.GetSetHookDoSpell: TDoSpell;
begin
  Result := SetHookDoSpell;
end;

function TPlugInManage.GetPlayObjectUserLogin1: TObjectAction;
begin
  Result := PlayObjectUserLogin1;
end;

function TPlugInManage.GetPlayObjectUserLogin2: TObjectAction;
begin
  Result := PlayObjectUserLogin2;
end;

function TPlugInManage.GetPlayObjectUserLogin3: TObjectAction;
begin
  Result := PlayObjectUserLogin3;
end;

function TPlugInManage.GetPlayObjectUserLogin4: TObjectAction;
begin
  Result := PlayObjectUserLogin4;
end;

function TPlugInManage.GetPlayObjectCreate: TObjectAction;
begin
  Result := PlayObjectCreate;
end;

function TPlugInManage.GetPlayObjectDestroy: TObjectAction;
begin
  Result := PlayObjectDestroy;
end;

function TPlugInManage.GetPlayObjectUserCmd: TObjectUserCmd;
begin
  Result := PlayObjectUserCmd;
end;

function TPlugInManage.GetObjectOperateMessage: TObjectOperateMessage;
begin
  Result := ObjectOperateMessage;
end;

function TPlugInManage.GetQuestActionScriptCmd: TScriptCmd;
begin
  Result := QuestActionScriptCmd;
end;

function TPlugInManage.GetQuestConditionScriptCmd: TScriptCmd;
begin
  Result := QuestConditionScriptCmd;
end;

function TPlugInManage.GetActionScriptProcess: TScriptAction;
begin
  Result := ActionScriptProcess;
end;

function TPlugInManage.GetConditionScriptProcess: TScriptCondition;
begin
  Result := ConditionScriptProcess;
end;

function TPlugInManage.GetPlayObjectUserSelect: TObjectActionUserSelect;
begin
  Result := PlayObjectUserSelect;
end;

function TPlugInManage.GetCheckCanUpgradeItem: TObjectActionItem;
begin
  Result := CheckCanUpgradeItem;
end;

function TPlugInManage.GetCheckCanSellItem: TObjectActionItem;
begin
  Result := CheckCanSellItem;
end;

function TPlugInManage.GetCheckNotCanScatterItem: TObjectActionItem;
begin
  Result := CheckNotCanScatterItem;
end;

function TPlugInManage.GetCheckCanDieScatterItem: TObjectActionItem;
begin
  Result := CheckCanDieScatterItem;
end;

procedure TPlugInManage.Initialize;
begin
  ScriptDeCryptString := nil;
  IPLocal := nil;
  ChangeCaptionText := nil;
  ChangeGateSocket := nil;
  GetMaxPlayObjectCount := nil;
  SetMaxPlayObjectCount := nil;

  GetFeature := nil;
  ObjectEnterAnotherMap := nil;
  ObjectDie := nil;
  ChangeCurrMap := nil;
  ClientQueryBagItems := nil;
  ClientQueryUserState := nil;
  SendActionGood := nil;
  SendActionFail := nil;
  SendWalkMsg := nil;
  SendHorseRunMsg := nil;
  SendRunMsg := nil;
  SendDeathMsg := nil;
  SendSkeletonMsg := nil;
  SendAliveMsg := nil;
  SendSpaceMoveMsg := nil;
  SendChangeFaceMsg := nil;
  SendUseitemsMsg := nil;
  SendUseMagicMsg := nil;
  SendUserLevelUpMsg := nil;
  SendUserAbilieyMsg := nil;
  SendUserStruckMsg := nil;
  SendSocket := nil;
  SendGoodsList := nil;
  SendUserStatusMsg := nil;
  CheckCanDropItem := nil;
  CheckCanDealItem := nil;
  CheckCanStorageItem := nil;
  CheckCanRepairItem := nil;
  CheckUserItems := nil;
  PlayObjectRun := nil;
  PlayObjectFilterMsg := nil;
  MerchantClientGetDetailGoodsList := nil;
  UserEngineRun := nil;
  ObjectClientMsg := nil;
  SetHookDoSpell := nil;
  PlayObjectCreate := nil;
  PlayObjectDestroy := nil;
  PlayObjectUserCmd := nil;
  ObjectOperateMessage := nil;
  QuestActionScriptCmd := nil;
  QuestConditionScriptCmd := nil;
  ActionScriptProcess := nil;
  ConditionScriptProcess := nil;
  PlayObjectUserSelect := nil;
  PlayObjectUserLogin1 := nil;
  PlayObjectUserLogin2 := nil;
  PlayObjectUserLogin3 := nil;
  PlayObjectUserLogin4 := nil;
  CheckCanUpgradeItem := nil;
  CheckCanSellItem := nil;
  CheckNotCanScatterItem := nil;
  CheckCanDieScatterItem := nil;
  ObjectOffLine := nil;
  ProcessHumans := nil;
end;

function TPlugInManage.GetPlug(Module: THandle; sPlugLibFileName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to PlugList.Count - 1 do begin
    if (Module = pTPlugInfo(PlugList.Objects[I]).Module) or (Comparetext(pTPlugInfo(PlugList.Objects[I]).DllName, sPlugLibFileName) = 0) then begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TPlugInManage.StartPlugMoudle();
var
  I: Integer;
  Module: THandle;
  StartPlug: TStartPlug;
begin
  for I := 0 to PlugList.Count - 1 do begin
    Module := pTPlugInfo(PlugList.Objects[I]).Module;
    {Module := Module + abs(g_UsrEngnLicense.nEXEVersion - g_UsrEngnLicense.nDLLVersion)};
    StartPlug := GetProcAddress(Module, 'Start');
    if @StartPlug <> nil then StartPlug();
  end;
end;

procedure TPlugInManage.LoadPlugIn;
var
  I: Integer;
  LoadList: TStringList;
  sPlugFileName: string;
  sPlugLibName: string;
  sPlugLibFileName: string;
  Module: THandle;
  Init: TPlugInit;
  PlugInfo: pTPlugInfo;
  PlugEngine: TPlugEngine;
  InitM2ServerDllOK: Boolean;
  Buffs: array[0..254] of Char;
  Buffer: Pointer;

  nSize, nCrc: PCardinal;
  MemoryStream: TMemoryStream;
  ConfigOption: TConfigOption;
  sText: string;
  dwTickTime: LongWord;
begin
  InitM2ServerDllOK := False;
  sPlugFileName := g_Config.sPlugDir + 'PlugList.txt';
  if not DirectoryExists(g_Config.sPlugDir) then begin
    //CreateDirectory(PChar(g_Config.sConLogDir),nil);
    CreateDir(g_Config.sPlugDir);
  end;
  {
  if not FileExists(sPlugFileName) then begin
    LoadList := TStringList.Create;
    LoadList.Add('M2Server.dll');
    LoadList.SaveToFile(sPlugFileName);
    LoadList.Free;
  end;
  }
  PlugEngine.AppHandle := Application.Handle;
  //PlugEngine.IconHandle := Application.Icon.Handle;
  PlugEngine.Module := 0;
  PlugEngine.MsgProc := MainMessage;
  PlugEngine.PlugInManage := Self;
  PlugEngine.UserEngine := UserEngine;
  PlugEngine.EngineOut := g_EngineOut;

//==============================================================================
  //加载M2Server.dll
//{$I VMProtectBeginUltra.inc}
  sPlugLibFileName := g_Config.sPlugDir + 'M2Server.dll';
  if FileExists(sPlugLibFileName) then begin
    Module := LoadLibrary(PChar(sPlugLibFileName)); //FreeLibrary
    if Module > 32 then begin
      Init := GetProcAddress(Module, 'Init');
      if @Init <> nil then begin
          New(PlugInfo);
          New(PlugInfo.SysPlug);
          PlugInfo.DllName := sPlugLibFileName;
          PlugInfo.Module := Module;
          PlugEngine.Module := Module;
          PlugEngine.Buffer := @Buffs;
          FillChar(PlugEngine.Buffer^, SizeOf(Buffs), #0);
          PlugInfo.sDesc := Init(@PlugEngine);
          PlugInfo.SysPlug^ := Str_ToInt(DecryptString(Buffs), 0) = Module;

          if PlugInfo.SysPlug^ then begin
            PlugList.AddObject(PlugInfo.sDesc, TObject(PlugInfo));
            InitM2ServerDllOK := True;
          end;
      end;

    end;
  end;

  if not InitM2ServerDllOK then begin
    MainOutMessage('Failed to Load M2Server.dll');
    Exit;
  end;
//{$I VMProtectEnd.inc}
//==============================================================================
  if FileExists(sPlugFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sPlugFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sPlugLibName := Trim(LoadList.Strings[I]);
      if (sPlugLibName = '') or (sPlugLibName[1] = ';') then Continue;
      sPlugLibFileName := g_Config.sPlugDir + sPlugLibName;
      if FileExists(sPlugLibFileName) then begin
        Module := LoadLibrary(PChar(sPlugLibFileName)); //FreeLibrary
        if Module > 32 then begin
          if GetPlug(Module, sPlugLibFileName) then begin //2007-01-22 增加 是否重复加载同一个插件
            FreeLibrary(Module);
            Continue;
          end;
          Init := GetProcAddress(Module, 'Init');
          if @Init <> nil then begin
            New(PlugInfo);
            New(PlugInfo.SysPlug);
            PlugInfo.SysPlug^ := False;
            PlugInfo.DllName := sPlugLibFileName;
            PlugInfo.Module := Module;
            PlugEngine.Module := Module;
            //PlugEngine.Buffer := @Buffer;
            //FillChar(PlugEngine.Buffer^, SizeOf(Buffer), #0);
            PlugInfo.sDesc := Init(@PlugEngine);
            //PlugInfo.SysPlug^ := Str_ToInt(_DecryptString(Buffs), 0) = Module;
            PlugList.AddObject(PlugInfo.sDesc, TObject(PlugInfo));
          end;
        end;
      end;

    end;
    LoadList.Free;
  end;
end;

procedure TPlugInManage.UnLoadPlugIn;
var
  I: Integer;
  PlugInfo: pTPlugInfo;
  PFunc: procedure(); stdcall;
begin
  for I := 0 to PlugList.Count - 1 do begin
    PlugInfo := pTPlugInfo(PlugList.Objects[I]);
    PFunc := GetProcAddress(PlugInfo.Module, 'UnInit');
    if @PFunc <> nil then PFunc();
    FreeLibrary(PlugInfo.Module);
    Dispose(PlugInfo.SysPlug);
    Dispose(PlugInfo);
  end;
  PlugList.Clear;
end;

initialization

finalization

end.
