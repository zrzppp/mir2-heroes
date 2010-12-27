unit PlayShop;

interface
uses
  Windows, SysUtils, ExtCtrls, Classes, EngineInterface, PlugShare;
const
  //商铺相关
  CM_OPENSHOP = 9000;
  CM_BUYSHOPITEM = 9002;
  SM_BUYSHOPITEM_SUCCESS = 9003;
  SM_BUYSHOPITEM_FAIL = 9004;
  SM_SENGSHOPITEMS = 9001; // SERIES 7 每页的数量    wParam 总页数

  RM_OPENSHOP = 31001;
  RM_BUYSHOPITEM_SUCCESS = 31002;
  RM_BUYSHOPITEM_FAIL = 31003;
  BUFFERSIZE = 10000;

procedure LoadShopItemList();
procedure UnLoadShopItemList(nType: Integer);
procedure InitPlayShop();
procedure UnInitPlayShop();
function GetShopItem(sItemName: string; nType: Integer): pTShopItem;
procedure ClientGetShopItemList(PlayObject: TPlayObject; nPage, nTabPage, nSuperTabPage: Integer; MsgObject: TObject);
function PlayObjectOperateMessage(BaseObject: TObject;
  wIdent: Word;
  wParam: Word;
  nParam1: Integer;
  nParam2: Integer;
  nParam3: Integer;
  MsgObject: TObject;
  dwDeliveryTime: LongWord;
  pszMsg: PChar;
  var boReturn: Boolean): Boolean; stdcall;
implementation
uses HUtil32;
var
  OldObjectOperateMessage: TObjectOperateMessage;

procedure InitPlayShop();
begin
  OldObjectOperateMessage := g_PlugEngine.PlugOfEngine.GetObjectOperateMessage();
  g_PlugEngine.PlugOfEngine.HookObjectOperateMessage(PlayObjectOperateMessage);
end;

procedure UnInitPlayShop();
var
  I: Integer;
begin
  g_PlugEngine.PlugOfEngine.HookObjectOperateMessage(OldObjectOperateMessage);
  for I := 0 to 5 do UnLoadShopItemList(I);
end;

function MakeDefaultMsg(wIdent: Word; nRecog: Integer; wParam, wTag, wSeries: Word): TDefaultMessage;
begin
  Result.Recog := nRecog;
  Result.Ident := wIdent;
  Result.Param := wParam;
  Result.Tag := wTag;
  Result.Series := wSeries;
end;

procedure ClientGetShopItemList(PlayObject: TPlayObject; nPage, nTabPage, nSuperTabPage: Integer; MsgObject: TObject);
  function GetPageCount(): Integer;
  var
    I: Integer;
    nItemListCount, nCount: Integer;
  begin
    Result := 0;
    nItemListCount := 0;
    for I := Low(g_ShopItemList) to High(g_ShopItemList) - 1 do begin
      if g_ShopItemList[I] <> nil then begin
        if nItemListCount < g_ShopItemList[I].Count then nItemListCount := g_ShopItemList[I].Count;
      end;
    end;
    if nItemListCount > 0 then begin
      Result := nItemListCount div 10;
      if (nItemListCount mod 10) > 0 then Inc(Result);
    end;

    if g_ShopItemList[High(g_ShopItemList)] <> nil then begin
      nItemListCount := g_ShopItemList[High(g_ShopItemList)].Count;
      if nItemListCount > 0 then begin
        nCount := nItemListCount div 5;
        if (nItemListCount mod 5) > 0 then Inc(nCount);
        if nCount > Result then Result := nCount;
      end;
    end;
  end;

  function GetItems(nBeginCount: Integer; ItemList: Classes.TList): string;
  var
    I: Integer;
    n01: Integer;
    ClientShopItem: TClientShopItem;
    ShopItem: pTShopItem;
  begin
    Result := '';
    n01 := 0;
    if nBeginCount > ItemList.Count - 1 then Exit;
    for I := nBeginCount to ItemList.Count - 1 do begin
      if n01 > 10 then Break;
      ShopItem := pTShopItem(ItemList.Items[I]);
      if ShopItem.StdItem.Name <> '' then begin
        Move(ShopItem^, ClientShopItem, SizeOf(TClientShopItem));
        if ShopItem.boLimitDay then begin
          ClientShopItem.StdItem.AddValue[0] := 1;
          ClientShopItem.StdItem.MaxDate := Date + ShopItem.nMaxLimitDay + Time;
        end else begin
          ClientShopItem.StdItem.AddValue[0] := 0;
        end;
        Result := Result + EncodeBuffer(@ClientShopItem, SizeOf(TClientShopItem)) + '/';
        Inc(n01);
      end;
    end;
  end;

  function GetSuperItems(nBeginCount: Integer; ItemList: Classes.TList): string;
  var
    I: Integer;
    n01: Integer;
    ClientShopItem: TClientShopItem;
    ShopItem: pTShopItem;
  begin
    Result := '';
    n01 := 0;
    if nBeginCount > ItemList.Count - 1 then Exit;
    for I := nBeginCount to ItemList.Count - 1 do begin
      if n01 > 5 then Break;
      ShopItem := pTShopItem(ItemList.Items[I]);
      if ShopItem.StdItem.Name <> '' then begin
        Move(ShopItem^, ClientShopItem, SizeOf(TClientShopItem));
        if ShopItem.boLimitDay then begin
          ClientShopItem.StdItem.AddValue[0] := 1;
          ClientShopItem.StdItem.MaxDate := Date + ShopItem.nMaxLimitDay + Time;
        end else begin
          ClientShopItem.StdItem.AddValue[0] := 0;
        end;
        Result := Result + EncodeBuffer(@ClientShopItem, SizeOf(TClientShopItem)) + '/';
        //MainOutMessage(Result, 0);
        Inc(n01);
      end;
    end;
    //MainOutMessage('SuperItems Length(Result):' + IntToStr(Length(Result)), 0);
  end;
var
  I: Integer;
  n01: Integer;
  sSendStr: string;
  s01: string;
  pShopItem: pTShopItem;
  ShopItem: TShopItem;
  nPageCount: Integer;
  pszDest: array[0..BUFFERSIZE - 1] of Char;
  DefMsg: TDefaultMessage;
begin
  g_CharObject.BaseObject := PlayObject;
  sSendStr := '';
  nPageCount := GetPageCount();
  if nPage > 0 then begin
    if nTabPage in [Low(g_ShopItemList)..High(g_ShopItemList)] then begin
      if nTabPage = High(g_ShopItemList) then begin
        if g_ShopItemList[nTabPage].Count >= nPage * 5 then begin
          sSendStr := sSendStr + GetSuperItems(nPage * 5, g_ShopItemList[nTabPage]);
        end;
      end else begin
        if g_ShopItemList[nTabPage].Count >= nPage * 10 then begin
          sSendStr := sSendStr + GetItems(nPage * 10, g_ShopItemList[nTabPage]);
        end;
        if nSuperTabPage = High(g_ShopItemList) then begin
          if g_ShopItemList[nSuperTabPage].Count >= 0 then begin
            sSendStr := sSendStr + GetSuperItems(0, g_ShopItemList[nSuperTabPage]);
          end;
        end;
      end;
    end;
  end else begin
    if nTabPage in [Low(g_ShopItemList)..High(g_ShopItemList)] then begin
      if nTabPage = High(g_ShopItemList) then begin
        sSendStr := sSendStr + GetSuperItems(0, g_ShopItemList[nTabPage]);
      end else begin
        sSendStr := sSendStr + GetItems(0, g_ShopItemList[nTabPage]);
        if nSuperTabPage = High(g_ShopItemList) then begin
          if g_ShopItemList[nSuperTabPage].Count >= 0 then begin
            sSendStr := sSendStr + GetSuperItems(0, g_ShopItemList[nSuperTabPage]);
          end;
        end;
      end;
    end;
  end;
  if sSendStr <> '' then begin
    {MainOutMessage(PChar('sSendStr Length = ' + IntToStr(Length(sSendStr))));
    MainOutMessage(PChar('nTabPage = ' + IntToStr(nTabPage)));}
    //MainOutMessage('Length(sSendStr):' + IntToStr(Length(sSendStr)), 0);
    if Length(sSendStr) > 8000 then begin
      g_CharObject.SendMsg(MsgObject, RM_OPENSHOP, 0, nPageCount, nPage, nTabPage, Copy(sSendStr, 1, 4000));
      g_CharObject.SendDelayMsg(MsgObject, RM_OPENSHOP, 0, nPageCount, nPage, nTabPage, Copy(sSendStr, 4000 + 1, Length(sSendStr)), 200);
    end else begin
      DefMsg := MakeDefaultMsg(SM_SENGSHOPITEMS, 0, nPageCount, nPage, nTabPage);
      g_CharObject.SendSocket(@DefMsg, sSendStr);
      //g_CharObject.SendMsg(MsgObject, RM_OPENSHOP, 0, nPageCount, nPage, nTabPage, sSendStr);
    end;
  end;
end;

function GetShopItem(sItemName: string; nType: Integer): pTShopItem;
var
  I: Integer;
  ShopItem: pTShopItem;
  ItemList: Classes.TList;
begin
  Result := nil;
  if sItemName = '' then Exit;
  if nType in [Low(g_ShopItemList)..High(g_ShopItemList)] then begin
    if g_ShopItemList[nType] = nil then Exit;
    for I := 0 to g_ShopItemList[nType].Count - 1 do begin
      ShopItem := g_ShopItemList[nType].Items[I];
      if CompareText(ShopItem.StdItem.Name, sItemName) = 0 then begin
        Result := ShopItem;
        Break;
      end;
    end;
  end;
end;

procedure ClientBuyShopItem(PlayObject: TPlayObject; MsgObject: TObject; nType: Integer; pszMsg: PChar);
var
  sItemName: string;
  sLog: string;
  ShopItem: pTShopItem;
  StdItem: TStdItem;
  nGameGold: Integer;
  UserItem: pTUserItem;
  nPrice: Integer;
  pszDest: array[0..BUFFERSIZE - 1] of Char;
  sMapName: string;
  sCharName: string;
  nCurrX: Integer;
  nCurrY: Integer;
begin
  g_CharObject.BaseObject := PlayObject;
  sItemName := StrPas(pszMsg);
  ShopItem := GetShopItem(sItemName, nType);
  if ShopItem <> nil then begin
    nPrice := ShopItem.StdItem.Price;
    if (g_CharObject.m_nGameGold >= nPrice) and (nPrice >= 0) then begin
      if g_CharObject.IsEnoughBag then begin
        New(UserItem);
        g_UserManage.CopyToUserItemFromName(sItemName, UserItem);
        if ShopItem.boRandomUpgrade then begin
          if Random(ShopItem.nAddValueRate) = 0 then begin
            g_UserManage.RandomUpgradeItem(UserItem);
            g_UserManage.RandomUpgradeItem_(UserItem);
          end;
        end;
        if ShopItem.boLimitDay then begin
          UserItem.AddValue[0] := 1;
          UserItem.MaxDate := Date + ShopItem.nMaxLimitDay + Time;
        end;
        //MainOutMessage(PChar('UserItem.AddValue1: ' + Format('%d/%d/%d', [UserItem.AddValue[4], UserItem.AddValue[5], UserItem.AddValue[6]])));

        if g_CharObject.AddItemToBag(UserItem) then begin

          g_CharObject.DecGameGold(nPrice);

          g_CharObject.SendAddItem(UserItem);

          g_CharObject.GameGoldChanged;
          //StdItem := ShopItem.StdItem;
          //MainOutMessage('g_PlugEngine.EngineOut.AddGameDataLogAPI1', 0);
          //g_CharObject.SendMsg(MsgObject, RM_BUYSHOPITEM_SUCCESS, 0, 0, 0, 0, sItemName);

          {if StdItem.NeedIdentify = 1 then
            sLog := '30' + #9 +
              g_CharObject.m_sMapName + #9 +
              IntToStr(g_CharObject.m_nCurrX) + #9 +
              IntToStr(g_CharObject.m_nCurrY) + #9 +
              g_CharObject.m_sCharName + #9 +
              //UserEngine.GetStdItemName(m_UseItems[I].wIndex) + #9 +
            sItemName + #9 +
              IntToStr(UserItem.MakeIndex) + #9 +
              '1' + #9 +
              '0'; }

          sLog := Format(sGameLogMsg, [LOG_BUYSHOPITEM,
            g_CharObject.m_sMapName,
              g_CharObject.m_nCurrX,
              g_CharObject.m_nCurrY,
              g_CharObject.m_sCharName,
              sItemName,           //g_CharObject.m_sGameGoldName
              UserItem.MakeIndex,
              '1',
              '0']);

          g_PlugEngine.EngineOut.AddGameDataLogAPI(PChar(sLog));

          sLog := Format(sGameLogMsg, [LOG_GAMEGOLD,
            g_CharObject.m_sMapName,
              g_CharObject.m_nCurrX,
              g_CharObject.m_nCurrY,
              g_CharObject.m_sCharName,
              g_CharObject.m_sGameGoldName,
              nPrice,
              '-',
              '0']);
          g_PlugEngine.EngineOut.AddGameDataLogAPI(PChar(sLog));

        end;
        Dispose(UserItem);
      end else begin
        g_CharObject.SendMsg(MsgObject, RM_BUYSHOPITEM_FAIL, 0, -2, 0, 0, ''); //包裹满
      end;
    end else begin
      g_CharObject.SendMsg(MsgObject, RM_BUYSHOPITEM_FAIL, 0, -1, 0, 0, '');
    end;
  end else begin
    g_CharObject.SendMsg(MsgObject, RM_BUYSHOPITEM_FAIL, 0, -3, 0, 0, '');
  end;
end;

function PlayObjectOperateMessage(BaseObject: TObject;
  wIdent: Word;
  wParam: Word;
  nParam1: Integer;
  nParam2: Integer;
  nParam3: Integer;
  MsgObject: TObject;
  dwDeliveryTime: LongWord;
  pszMsg: PChar;
  var boReturn: Boolean): Boolean; stdcall;
var
  m_DefMsg: TDefaultMessage;
begin
  Result := True;
  case wIdent of
    CM_OPENSHOP: begin
        {MainOutMessage('CM_BUYSHOPITEM:wParam ' + IntToStr(wParam), 0);
        MainOutMessage('CM_BUYSHOPITEM:nParam1 ' + IntToStr(nParam1), 0);
        MainOutMessage('CM_BUYSHOPITEM:nParam2 ' + IntToStr(nParam2), 0);
        MainOutMessage('CM_BUYSHOPITEM:nParam3 ' + IntToStr(nParam3), 0); }
        ClientGetShopItemList(TPlayObject(BaseObject), nParam2, nParam3, wParam, MsgObject);
      end;
    CM_BUYSHOPITEM: begin
        {MainOutMessage(PChar('CM_BUYSHOPITEM:wParam ' + IntToStr(wParam)));
        MainOutMessage(PChar('CM_BUYSHOPITEM:nParam1 ' + IntToStr(nParam1)));
        MainOutMessage(PChar('CM_BUYSHOPITEM:nParam2 ' + IntToStr(nParam2)));
        MainOutMessage(PChar('CM_BUYSHOPITEM:nParam3 ' + IntToStr(nParam3))); }
        ClientBuyShopItem(BaseObject, MsgObject, wParam, pszMsg);
      end;
    RM_BUYSHOPITEM_SUCCESS: begin
        g_CharObject.BaseObject := BaseObject;
        g_CharObject.GameGoldChanged;
      end;
    RM_BUYSHOPITEM_FAIL: begin
        g_CharObject.BaseObject := BaseObject;
        m_DefMsg := MakeDefaultMsg(SM_BUYSHOPITEM_FAIL, nParam1, wParam, nParam2, nParam3);
        g_CharObject.SendSocket(@m_DefMsg, '');
      end;
    RM_OPENSHOP: begin
        {MainOutMessage(PChar('wParam '+IntToStr(wParam)));
        MainOutMessage(PChar('nParam1 '+IntToStr(nParam1)));
        MainOutMessage(PChar('nParam2 '+IntToStr(nParam2)));
        MainOutMessage(PChar('nParam3 '+IntToStr(nParam3)));  }
        g_CharObject.BaseObject := BaseObject;
        m_DefMsg := MakeDefaultMsg(SM_SENGSHOPITEMS, wParam, nParam1, nParam2, nParam3);
        g_CharObject.SendSocket(@m_DefMsg, pszMsg);
        //MainOutMessage(PChar('pszMsg '+pszMsg));
      end;
  else begin
      if Assigned(OldObjectOperateMessage) then begin
        Result := OldObjectOperateMessage(BaseObject,
          wIdent,
          wParam,
          nParam1,
          nParam2,
          nParam3,
          MsgObject,
          dwDeliveryTime,
          pszMsg,
          boReturn);
        if not Result then boReturn := True;
      end else begin
        boReturn := True;
        Result := False;
      end;
    end;
  end;
end;

procedure LoadShopItemList();
var
  I: Integer;
  sFileName: string;
  LoadList: Classes.TStringList;
  sLineText: string;
  sItemName: string;
  sPrice: string;
  sIntroduce: string;
  nPrice: Integer;
  StdItem: pTStdItem;
  ShopItem: pTShopItem;
  sName: string;
  sItemType: string;
  byItemType: Integer;
  sPicture: string;
  sMemo1, sMemo2: string;
  sBeginIdx: string;
  sEndIdx: string;
  nBeginIdx: Integer;
  nEndIdx: Integer;

  sRandomUpgrade: string;
  sAddValueRate: string;
  sLimitDay: string;
  sMaxLimitDay: string;

  boRandomUpgrade: Boolean;
  nAddValueRate: Integer;
  boLimitDay: Boolean;
  nMaxLimitDay: Integer;
begin
  for I := Low(g_ShopItemList) to High(g_ShopItemList) do begin
    if g_ShopItemList[I] <> nil then begin
      UnLoadShopItemList(I);
    end;
    g_ShopItemList[I] := Classes.TList.Create();
  end;
  sFileName := '.\BuyItemList.txt';
  if not FileExists(sFileName) then begin
    LoadList := Classes.TStringList.Create();
    LoadList.Add(';引擎插件商铺配置文件');
    LoadList.Add(';物品类型'#9'物品名称'#9'出售价格'#9'图片介绍'#9'介绍'#9'描述');
    LoadList.SaveToFile(sFileName);
    LoadList.Free;
    Exit;
  end;
  LoadList := Classes.TStringList.Create();
  LoadList.LoadFromFile(sFileName);
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then begin
      sLineText := GetValidStr3(sLineText, sItemType, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sItemName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sPrice, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sPicture, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sMemo1, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sRandomUpgrade, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sAddValueRate, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sLimitDay, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sMaxLimitDay, [' ', #9]);

      sLineText := GetValidStr3(sLineText, sMemo2, [' ', #9]);

      byItemType := Str_ToInt(sItemType, -1);
      nPrice := Str_ToInt(sPrice, -1);

      boRandomUpgrade := Boolean(Str_ToInt(sRandomUpgrade, 0));
      nAddValueRate := Str_ToInt(sAddValueRate, 100);
      boLimitDay := Boolean(Str_ToInt(sLimitDay, 0));
      nMaxLimitDay := Str_ToInt(sMaxLimitDay, 100);
      if (byItemType in [0..5]) and (sItemName <> '') and (nPrice >= 0) and (sPicture <> '') and (sMemo1 <> '') then begin
        StdItem := g_UserManage.GetStdItem(sItemName);
        sPicture := GetValidStr3(sPicture, sBeginIdx, ['-', #9]);
        sPicture := GetValidStr3(sPicture, sEndIdx, ['-', #9]);
        if StdItem <> nil then begin
          New(ShopItem);
          nBeginIdx := Str_ToInt(sBeginIdx, -1);
          nEndIdx := Str_ToInt(sEndIdx, -1);
          ShopItem.StdItem := StdItem^;
          ShopItem.StdItem.Price := nPrice;
          ShopItem.nBeginIdx := nBeginIdx;
          ShopItem.nEndIdx := nEndIdx;
          ShopItem.btItemType := byItemType;
          ShopItem.sMemo1 := sMemo1;
          ChgString(sMemo2, '\', #13);
          ShopItem.sMemo2 := sMemo2;
          ShopItem.boRandomUpgrade := boRandomUpgrade;
          ShopItem.nAddValueRate := nAddValueRate;
          ShopItem.boLimitDay := boLimitDay;
          ShopItem.nMaxLimitDay := nMaxLimitDay;
          FillChar(ShopItem.StdItem.AddValue, SizeOf(ShopItem.StdItem.AddValue), #0);
          FillChar(ShopItem.StdItem.AddPoint, SizeOf(ShopItem.StdItem.AddPoint), #0);
         { FillChar(ShopItem.sMemo1, SizeOf(ShopItem.sMemo1), 0);
          if Length(sMemo1) > 0 then
            Move(sMemo1[1], ShopItem.sMemo1, SizeOf(ShopItem.sMemo1));
          FillChar(ShopItem.sMemo2, SizeOf(ShopItem.sMemo2), 0);
          if Length(sMemo2) > 0 then
            Move(sMemo2[1], ShopItem.sMemo2, SizeOf(ShopItem.sMemo2)); }
          if byItemType in [Low(g_ShopItemList)..High(g_ShopItemList)] then begin
            if g_ShopItemList[byItemType] <> nil then begin
              g_ShopItemList[byItemType].Add(ShopItem);
            end else begin
              Dispose(ShopItem);
            end;
          end else begin
            Dispose(ShopItem);
          end;
        end;
      end;
    end;
  end;
  LoadList.Free;
end;

procedure UnLoadShopItemList(nType: Integer);
var
  I: Integer;
  ShopItem: pTShopItem;
begin
  if g_ShopItemList[nType] <> nil then begin
    for I := 0 to g_ShopItemList[nType].Count - 1 do begin
      ShopItem := pTShopItem(g_ShopItemList[nType].Items[I]);
      Dispose(ShopItem);
    end;
    FreeAndNil(g_ShopItemList[nType]);
  end;
end;

end.

