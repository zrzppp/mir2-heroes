unit PlugMain;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, EngineInterface, ExtCtrls, ShellApi, HUtil32, PlugShare;

procedure InitPlug();
procedure UnInitPlug();
function StartPlug(): Boolean;

procedure ProcessHumans; stdcall;
implementation
uses EncryptUnit, Common;
const
  www_941SF_com = 'vLBsDpXLsQzjzTQgc0EmI0H1Ezbx';
var
  StartPluging: PBoolean;
  StartPlugOK: PBoolean;
  StartPlugFail: PBoolean;

  TodyDate: TDate;
  dwRunTick: Longword;
//______________________________________________________________________________
//_____________________________________________________________________//

function StartPlug(): Boolean;
var
  dwWaitTick: Longword;
  ChangeCaptionText: TChangeCaptionText;
  ChangeGateSocket: TChangeGateSocket;
  SetMaxPlayObjectCount: TSetMaxPlayObjectCount;
  GetMaxPlayObjectCount: TGetMaxPlayObjectCount;

  CharArr: array[0..254] of Char;
  sOption, sBuffer: string;
  nLen: Integer;
  nPro: Integer;

  Count: Integer;
  MemoryStream: TMemoryStream;
  ConfigOption: TConfigOption;
  Buffer: Pointer;
  nCRC: Cardinal;


  UserReg: TUserReg;

  //sCaption: string;
  //dwTickTime: LongWord;
  I: Integer;
  DomainNameList: TStringList;
  DomainNameFile: TDomainNameFile;
begin
  if StartPlugOK^ then Exit;

  StartPlugOK^ := True;
  StartPlugFail^ := True;

  g_PlugEngine.PlugOfEngine.GetChangeCaptionText(@CharArr, nLen);
  sBuffer := CharArr;
  sBuffer := DecryptString(sBuffer);
  nPro := StrToInt(sBuffer);

  ChangeCaptionText := TChangeCaptionText(nPro);
  //ChangeCaptionText(PChar(DecryptString(sStart)), Length(DecryptString(sStart)));

 { dwWaitTick := GetTickCount;
  while True do begin
    Application.ProcessMessages;
    if GetTickCount - dwWaitTick > 1000 * 3 then break;
  end;}

  nLen := 0;

  FillChar(DomainNameFile, SizeOf(TDomainNameFile), 0);
  FillChar(UserReg, SizeOf(TUserReg), 0);

  MemoryStream := TMemoryStream.Create;
  try
    MemoryStream.LoadFromFile(Application.ExeName);

    MemoryStream.Seek(-(SizeOf(Integer) + ConfigOptionSize), soFromEnd);
    MemoryStream.Read(Count, SizeOf(Integer));

    SetLength(sOption, ConfigOptionSize);
    MemoryStream.Read(sOption[1], ConfigOptionSize);

    //MainOutMessage('OptionSize^:'+IntToStr(OptionSize^), 0);

    GetMem(Buffer, Count);
    try
      MemoryStream.Seek(0, soFromBeginning);
      MemoryStream.Read(Buffer^, Count);
      nCRC := BufferCRC(Buffer, Count);
    finally
      FreeMem(Buffer);
    end;

    DecryptBuffer(sOption, @ConfigOption, SizeOf(TConfigOption));
    //MainOutMessage('StartPlug1',0);
    //boVersion^ := Boolean((abs(ConfigOption.nOwnerNumber - ConfigOption.nUserNumber)));
    if (Count = ConfigOption.nSize) and (nCRC = ConfigOption.nCrc) and (LoWord(ConfigOption.nVersion) = SOFTWARE_M2SERVER) then begin
      //MainOutMessage('StartPlug2',0);
      UserReg.nOwnerNumber := ConfigOption.nOwnerNumber;
      UserReg.nUserNumber := ConfigOption.nUserNumber;
      UserReg.nVersion := ConfigOption.nVersion;
      if FileExists(g_sDomainNameFileName) then begin
        sBuffer := '';
        DomainNameList := TStringList.Create;
        try
          DomainNameList.LoadFromFile(g_sDomainNameFileName);
        except

        end;
        for I := 0 to DomainNameList.Count - 1 do begin
          sBuffer := sBuffer + Trim(DomainNameList[I]);
        end;
        DomainNameList.Free;

        DecryptBuffer(sBuffer, @DomainNameFile, SizeOf(TDomainNameFile));

        if (ConfigOption.nOwnerNumber = DomainNameFile.nOwnerNumber) and
          (ConfigOption.nUserNumber = DomainNameFile.nUserNumber) and
          (ConfigOption.nVersion = DomainNameFile.nVersion) and
          (DomainNameFile.sDomainName <> '') and (StringCrc(DomainNameFile.sDomainName) = DomainNameFile.nDomainName) and
          (DomainNameFile.boUnlimited or ((Date <= DomainNameFile.MaxDate) and (Date >= DomainNameFile.MinDate))) then begin
          UserReg.BeginDate := DomainNameFile.MinDate;
          UserReg.EndDate := DomainNameFile.MaxDate;
          UserReg.nCount := GetDayCount(UserReg.EndDate, UserReg.BeginDate);
          UserReg.boUnlimited := DomainNameFile.boUnlimited;
          UserReg.sDomainName := DomainNameFile.sDomainName;
          UserReg.nDomainName := DomainNameFile.nDomainName;
        end;
      end;
      //MainOutMessage('StartPlug3',0);
      g_PlugEngine.PlugOfEngine.GetSetMaxPlayObjectCount(@CharArr, nLen);
      sBuffer := CharArr;
      sBuffer := DecryptString(sBuffer);
      nPro := StrToInt(sBuffer);
      SetMaxPlayObjectCount := TSetMaxPlayObjectCount(nPro);

      sBuffer := EncryptBuffer(@UserReg, SizeOf(TUserReg));
      nLen := Length(sBuffer);
      Move(nLen, PlugBuffer^, SizeOf(Integer));
      Move(sBuffer[1], PlugBuffer[SizeOf(Integer)], nLen);

      SetMaxPlayObjectCount(PlugBuffer, nLen);

      //MainOutMessage('StartPlug4',0);
      g_PlugEngine.PlugOfEngine.GetChangeGateSocket(@CharArr, nLen);
      sBuffer := CharArr;
      sBuffer := DecryptString(sBuffer);
      nPro := StrToInt(sBuffer);
      ChangeGateSocket := TChangeGateSocket(nPro);
      ChangeGateSocket(True);
      //MainOutMessage('StartPlug5',0);
      if (UserReg.sDomainName <> '') and (UserReg.nDomainName <> 0) and (StringCrc(UserReg.sDomainName) = UserReg.nDomainName) then begin
        ChangeCaptionText(PChar(string(UserReg.sDomainName)), Length(UserReg.sDomainName));
      end else begin
        ChangeCaptionText(PChar(DecryptString(www_941SF_com)), Length(DecryptString(www_941SF_com)));
      end;
      sBuffer := EncryptString(IntToStr(Integer(@ProcessHumans)));
      g_PlugEngine.PlugOfEngine.HookProcessHumans(PChar(sBuffer), Length(sBuffer));
    end;

    StartPluging^ := False;
    StartPlugFail^ := False;
    Result := True;
  except

  end;
  MemoryStream.Free;
end;

procedure ProcessHumans;
var
  ChangeCaptionText: TChangeCaptionText;
  UserReg: TUserReg;
  sBuffer: string;
  nLen, nPro: Integer;
  CharArr: array[0..254] of Char;
begin
  if (TodyDate <> Date) then begin
    dwRunTick := GetTickCount;
    TodyDate := Date;
    Move(PlugBuffer^, nLen, SizeOf(Integer));
    SetLength(sBuffer, nLen);
    Move(PlugBuffer[SizeOf(Integer)], sBuffer[1], nLen);
    DecryptBuffer(sBuffer, @UserReg, SizeOf(TUserReg));
    if (UserReg.sDomainName <> '') and (StringCrc(UserReg.sDomainName) = UserReg.nDomainName) then begin
      if not UserReg.boUnlimited then begin
        if UserReg.nCount > 0 then Dec(UserReg.nCount);
      end;
      sBuffer := EncryptBuffer(@UserReg, SizeOf(TUserReg));
      nLen := Length(sBuffer);
      Move(nLen, PlugBuffer^, SizeOf(Integer));
      Move(sBuffer[1], PlugBuffer[SizeOf(Integer)], nLen);
    end;
    g_PlugEngine.PlugOfEngine.GetChangeCaptionText(@CharArr, nLen);
    sBuffer := CharArr;
    sBuffer := DecryptString(sBuffer);
    nPro := StrToInt(sBuffer);
    ChangeCaptionText := TChangeCaptionText(nPro);

    if (UserReg.sDomainName <> '') and (StringCrc(UserReg.sDomainName) = UserReg.nDomainName) then begin
      ChangeCaptionText(PChar(string(UserReg.sDomainName)), Length(UserReg.sDomainName));
    end else begin
      ChangeCaptionText(PChar(DecryptString(www_941SF_com)), Length(DecryptString(www_941SF_com)));
    end;
  end;
end;

procedure InitPlug();
begin
  g_sDomainNameFileName := ExtractFilePath(Application.ExeName) + 'DomainName.key';
  New(StartPlugOK);
  New(StartPluging);
  New(StartPlugFail);
  StartPlugFail^ := True;
  StartPluging^ := True;
  StartPlugOK^ := False;
  GetMem(PlugBuffer, 1024);
  FillChar(PlugBuffer^, 1024, #0);
  TodyDate := Date;
  dwRunTick := GetTickCount;
end;

procedure UnInitPlug();
begin
  FreeMem(PlugBuffer);
  Dispose(StartPlugOK);
  Dispose(StartPluging);
  Dispose(StartPlugFail);
end;

end.

