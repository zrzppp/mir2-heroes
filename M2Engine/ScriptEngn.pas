unit ScriptEngn;

interface
uses
  Windows, Classes, SysUtils, Grobal2, SDK, Forms, ObjBase, ObjActor;
const
  CMD_RACE_0 = 0; //self
  CMD_RACE_1 = 1; //hero
  CMD_RACE_2 = 2; //Master
  CMD_RACE_3 = 3; //mon
  CMD_RACE_4 = 4; //obj
  CMD_RACE_5 = 5;
  CMD_RACE_6 = 6;
  CMD_RACE_7 = 7;
  CMD_RACE_8 = 8;
  CMD_RACE_9 = 9;
type
  TScriptEngine = record
  private
    ScriptList: array of string;
    ScriptCmd: array of Integer;
  public
    {constructor Create();
    destructor Destroy; override; }
    function Cmd(sCmd: string): string;
    function GetActorObject(NPC: TActorObject; PlayObject: TPlayObject): TActorObject;
  end;

implementation
uses M2Share, ObjNpc;

{constructor TScriptEngine.Create();
begin
  inherited;
end;  }
{
destructor TScriptEngine.Destroy;
begin
  SetLength(m_ScriptCmd, 0);
  SetLength(m_ScriptList, 0);
  m_ScriptCmd := nil;
  m_ScriptList := nil;
  inherited;
end; }

function TScriptEngine.GetActorObject(NPC: TActorObject; PlayObject: TPlayObject): TActorObject;
var
  I: Integer;
  sCharName: string;
  OnlineUser: TPlayObject;
  ActorObject: TActorObject;
begin
  ActorObject := PlayObject;
  for I := 0 to Length(ScriptCmd) - 1 do begin
    case ScriptCmd[I] of
      CMD_RACE_0: begin //self
          ActorObject := PlayObject;
        end;
      CMD_RACE_1: begin //hero
          if (ActorObject <> nil) and (ActorObject.m_btRaceServer = RC_PLAYOBJECT) then begin
            ActorObject := TPlayObject(ActorObject).m_MyHero;
          end else begin
            ActorObject := nil;
            Break;
          end;
        end;
      CMD_RACE_2: begin //Master
          if (ActorObject <> nil) then begin
            ActorObject := ActorObject.m_Master;
          end else begin
            ActorObject := nil;
            Break;
          end;
        end;
      CMD_RACE_3: begin //mon
          if (ActorObject <> nil) then begin
            ActorObject := ActorObject.m_KillTargetCret;
          end else begin
            ActorObject := nil;
            Break;
          end;
        end;
      CMD_RACE_4: begin //obj
          if (ActorObject <> nil) then begin
            if not TNormNpc(NPC).GetValValue(ActorObject, ScriptList[I], sCharName) then sCharName := ScriptList[I];
            ActorObject := UserEngine.GetPlayObject(sCharName);
          end else begin
            ActorObject := nil;
            Break;
          end;
        end;
    end;
  end;
  Result := ActorObject;
end;

procedure TScriptEngine.LoadScript(var sCmd: string);
var
  TempList: TStringList;
  sCheckType: string;
  I: Integer;
begin
  if Pos('.', sCmd) > 0 then begin
    TempList := TStringList.Create;
    ExtractStrings(['.'], [], PChar(sCmd), TempList);
    sCmd := UpperCase(Trim(TempList.Strings[TempList.Count - 1]));
    TempList.Delete(TempList.Count - 1);
    TempList.Strings[0] := UpperCase(Trim(TempList.Strings[0]));
    if TempList.Strings[0] <> 'SELF' then TempList.Insert(0, 'SELF');
    SetLength(m_ScriptCmd, TempList.Count);
    SetLength(m_ScriptList, TempList.Count);
    for I := 0 to TempList.Count - 1 do begin
      if UpperCase(Trim(TempList.Strings[I])) = 'SELF' then begin
        m_ScriptCmd[I] := CMD_RACE_0;
      end else
        if UpperCase(Trim(TempList.Strings[I])) = 'HERO' then begin
        m_ScriptCmd[I] := CMD_RACE_1;
      end else
        if UpperCase(Trim(TempList.Strings[I])) = 'MASTER' then begin
        m_ScriptCmd[I] := CMD_RACE_2;
      end else
        if UpperCase(Trim(TempList.Strings[I])) = 'MON' then begin
        m_ScriptCmd[I] := CMD_RACE_3;
      end else begin
        m_ScriptCmd[I] := CMD_RACE_4;
      end;
      m_ScriptList[I] := UpperCase(Trim(TempList.Strings[I]));
    end;
    TempList.Free;
  end else begin
    SetLength(m_ScriptCmd, 1);
    m_ScriptCmd[0] := CMD_RACE_0;
  end;
end;

end.

