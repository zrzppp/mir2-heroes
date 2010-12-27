unit ItmUnit;

interface
uses
  Windows, Classes, SysUtils, SDK, Grobal2;
type
  TItemUnit = class
  private
    function GetRandomRange(nCount, nRate: Integer): Integer;
  public
    m_ItemNameList: TGList;
    constructor Create();
    destructor Destroy; override;
    procedure GetItemAddValue(UserItem: pTUserItem; var StdItem: TStdItem);

    function GetNewValue(nOldValue, nValue: Integer; btMethod: Byte): Byte;

    procedure RandomUpgradeWeapon_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
    procedure RandomUpgradeDress_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
    procedure RandomUpgrade19_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
    procedure RandomUpgrade202124_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
    procedure RandomUpgrade26_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
    procedure RandomUpgrade22_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
    procedure RandomUpgrade23_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
    procedure RandomUpgradeHelMet_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
    procedure UnknowHelmet_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
    procedure UnknowRing_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
    procedure UnknowNecklace_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);

    procedure UpgradeItems_(UserItem: pTUserItem; StdItem: pTStdItem; btMethod: Byte);
    procedure UpgradeItemsX_(UserItem: pTUserItem; StdItem, Value: Byte; btMethod: Byte);

    function _GetItemAddValue(UserItem: pTUserItem; btType: Byte): Integer;

    procedure _RandomUpgradeWeapon(UserItem: pTUserItem);
    procedure _RandomUpgradeDress(UserItem: pTUserItem);
    procedure _RandomUpgrade19(UserItem: pTUserItem);
    procedure _RandomUpgrade202124(UserItem: pTUserItem);
    procedure _RandomUpgrade26(UserItem: pTUserItem);
    procedure _RandomUpgrade22(UserItem: pTUserItem);
    procedure _RandomUpgrade23(UserItem: pTUserItem);
    procedure _RandomUpgradeHelMet(UserItem: pTUserItem);
    procedure _UnknowHelmet(UserItem: pTUserItem);
    procedure _UnknowRing(UserItem: pTUserItem);
    procedure _UnknowNecklace(UserItem: pTUserItem);

    procedure _RandomItemLimitDay(UserItem: pTUserItem; btItemType: Byte; nRate: Integer);

    procedure RandomWeaponAddPoint(UserItem: pTUserItem);
    procedure RandomDressAddPoint(UserItem: pTUserItem);
    procedure RandomNeckLaceAddPoint(UserItem: pTUserItem);
    procedure RandomArmRingAddPoint(UserItem: pTUserItem);
    procedure RandomRingAddPoint(UserItem: pTUserItem);
    procedure RandomHelMetAddPoint(UserItem: pTUserItem);
    procedure RandomShoesAddPoint(UserItem: pTUserItem);
    procedure RandomBeltAddPoint(UserItem: pTUserItem);


    procedure RandomUpgradeWeapon(UserItem: pTUserItem);
    procedure RandomUpgradeDress(UserItem: pTUserItem);
    procedure RandomUpgrade19(UserItem: pTUserItem);
    procedure RandomUpgrade202124(UserItem: pTUserItem);
    procedure RandomUpgrade26(UserItem: pTUserItem);
    procedure RandomUpgrade22(UserItem: pTUserItem);
    procedure RandomUpgrade23(UserItem: pTUserItem);
    procedure RandomUpgradeHelMet(UserItem: pTUserItem);
    procedure UnknowHelmet(UserItem: pTUserItem);
    procedure UnknowRing(UserItem: pTUserItem);
    procedure UnknowNecklace(UserItem: pTUserItem);

    function LoadCustomItemName(): Boolean;
    function SaveCustomItemName(): Boolean;
    function AddCustomItemName(nMakeIndex, nItemIndex: Integer; sItemName: string): Boolean;
    function DelCustomItemName(nMakeIndex, nItemIndex: Integer): Boolean;
    function GetCustomItemName(nMakeIndex, nItemIndex: Integer): string;
    procedure Lock();
    procedure UnLock();
  end;
implementation

uses HUtil32, M2Share;



{ TItemUnit }


constructor TItemUnit.Create;
begin
  m_ItemNameList := TGList.Create;
end;

destructor TItemUnit.Destroy;
var
  I: Integer;
begin
  for I := 0 to m_ItemNameList.Count - 1 do begin
    Dispose(pTItemName(m_ItemNameList.Items[I]));
  end;
  m_ItemNameList.Free;
  inherited;
end;

function TItemUnit.GetRandomRange(nCount, nRate: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to nCount - 1 do
    if Random(nRate) = 0 then Inc(Result);
end;

procedure TItemUnit.RandomUpgradeWeapon(UserItem: pTUserItem);
var
  nC, n10, n14: Integer;
begin
  nC := GetRandomRange(g_Config.nWeaponDCAddValueMaxLimit {12}, g_Config.nWeaponDCAddValueRate {15});
  if Random(15) = 0 then UserItem.btValue[0] := nC + 1;

  nC := GetRandomRange(12, 15);
  if Random(20) = 0 then begin
    n14 := (nC + 1) div 3;
    if n14 > 0 then begin
      if Random(3) <> 0 then begin
        UserItem.btValue[6] := n14;
      end else begin
        UserItem.btValue[6] := n14 + 10;
      end;
    end;
  end;

  nC := GetRandomRange(12, 15);
  if Random(15) = 0 then UserItem.btValue[1] := nC + 1;
  nC := GetRandomRange(12, 15);
  if Random(15) = 0 then UserItem.btValue[2] := nC + 1;
  nC := GetRandomRange(12, 15);
  if Random(24) = 0 then begin
    UserItem.btValue[5] := nC div 2 + 1;
  end;
  nC := GetRandomRange(12, 12);
  if Random(3) < 2 then begin
    n10 := (nC + 1) * 2000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
  nC := GetRandomRange(12, 15);
  if Random(10) = 0 then begin
    UserItem.btValue[7] := nC div 2 + 1;
  end;
end;

procedure TItemUnit.RandomUpgradeDress(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(6, 15);
  if Random(30) = 0 then UserItem.btValue[0] := nC + 1;
  nC := GetRandomRange(6, 15);
  if Random(30) = 0 then UserItem.btValue[1] := nC + 1;

  nC := GetRandomRange(g_Config.nDressDCAddValueMaxLimit {6}, g_Config.nDressDCAddValueRate {20});
  if Random(g_Config.nDressDCAddRate {40}) = 0 then UserItem.btValue[2] := nC + 1;
  nC := GetRandomRange(g_Config.nDressMCAddValueMaxLimit {6}, g_Config.nDressMCAddValueRate {20});
  if Random(g_Config.nDressMCAddRate {40}) = 0 then UserItem.btValue[3] := nC + 1;
  nC := GetRandomRange(g_Config.nDressSCAddValueMaxLimit {6}, g_Config.nDressSCAddValueRate {20});
  if Random(g_Config.nDressSCAddRate {40}) = 0 then UserItem.btValue[4] := nC + 1;

  nC := GetRandomRange(6, 10);
  if Random(8) < 6 then begin
    n10 := (nC + 1) * 2000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.RandomUpgrade202124(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(6, 30);
  if Random(60) = 0 then UserItem.btValue[0] := nC + 1;
  nC := GetRandomRange(6, 30);
  if Random(60) = 0 then UserItem.btValue[1] := nC + 1;
  nC := GetRandomRange(g_Config.nNeckLace202124DCAddValueMaxLimit {6}, g_Config.nNeckLace202124DCAddValueRate {20});
  if Random(g_Config.nNeckLace202124DCAddRate {30}) = 0 then UserItem.btValue[2] := nC + 1;
  nC := GetRandomRange(g_Config.nNeckLace202124MCAddValueMaxLimit {6}, g_Config.nNeckLace202124MCAddValueRate {20});
  if Random(g_Config.nNeckLace202124MCAddRate {30}) = 0 then UserItem.btValue[3] := nC + 1;
  nC := GetRandomRange(g_Config.nNeckLace202124SCAddValueMaxLimit {6}, g_Config.nNeckLace202124SCAddValueRate {20});
  if Random(g_Config.nNeckLace202124SCAddRate {30}) = 0 then UserItem.btValue[4] := nC + 1;
  nC := GetRandomRange(6, 12);
  if Random(20) < 15 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.RandomUpgrade26(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(6, 20);
  if Random(20) = 0 then UserItem.btValue[0] := nC + 1;
  nC := GetRandomRange(6, 20);
  if Random(20) = 0 then UserItem.btValue[1] := nC + 1;
  nC := GetRandomRange(g_Config.nArmRing26DCAddValueMaxLimit {6}, g_Config.nArmRing26DCAddValueRate {20});
  if Random(g_Config.nArmRing26DCAddRate {30}) = 0 then UserItem.btValue[2] := nC + 1;
  nC := GetRandomRange(g_Config.nArmRing26MCAddValueMaxLimit {6}, g_Config.nArmRing26MCAddValueRate {20});
  if Random(g_Config.nArmRing26MCAddRate {30}) = 0 then UserItem.btValue[3] := nC + 1;
  nC := GetRandomRange(g_Config.nArmRing26SCAddValueMaxLimit {6}, g_Config.nArmRing26SCAddValueRate {20});
  if Random(g_Config.nArmRing26SCAddRate {30}) = 0 then UserItem.btValue[4] := nC + 1;
  nC := GetRandomRange(6, 12);
  if Random(20) < 15 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.RandomUpgrade19(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(6, 20);
  if Random(40) = 0 then UserItem.btValue[0] := nC + 1;
  nC := GetRandomRange(6, 20);
  if Random(40) = 0 then UserItem.btValue[1] := nC + 1;

  nC := GetRandomRange(g_Config.nNeckLace19DCAddValueMaxLimit {6}, g_Config.nNeckLace19DCAddValueRate {20});
  if Random(g_Config.nNeckLace19DCAddRate {30}) = 0 then UserItem.btValue[2] := nC + 1;
  nC := GetRandomRange(g_Config.nNeckLace19MCAddValueMaxLimit {6}, g_Config.nNeckLace19MCAddValueRate {20});
  if Random(g_Config.nNeckLace19MCAddRate {30}) = 0 then UserItem.btValue[3] := nC + 1;
  nC := GetRandomRange(g_Config.nNeckLace19SCAddValueMaxLimit {6}, g_Config.nNeckLace19SCAddValueRate {20});
  if Random(g_Config.nNeckLace19SCAddRate {30}) = 0 then UserItem.btValue[4] := nC + 1;
  nC := GetRandomRange(6, 10);
  if Random(4) < 3 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.RandomUpgrade22(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nRing22DCAddValueMaxLimit {6}, g_Config.nRing22DCAddValueRate {20});
  if Random(g_Config.nRing22DCAddRate {30}) = 0 then UserItem.btValue[2] := nC + 1;
  nC := GetRandomRange(g_Config.nRing22MCAddValueMaxLimit {6}, g_Config.nRing22MCAddValueRate {20});
  if Random(g_Config.nRing22MCAddRate {30}) = 0 then UserItem.btValue[3] := nC + 1;
  nC := GetRandomRange(g_Config.nRing22SCAddValueMaxLimit {6}, g_Config.nRing22SCAddValueRate {20});
  if Random(g_Config.nRing22SCAddRate {30}) = 0 then UserItem.btValue[4] := nC + 1;
  nC := GetRandomRange(6, 12);
  if Random(4) < 3 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.RandomUpgrade23(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(6, 20);
  if Random(40) = 0 then UserItem.btValue[0] := nC + 1;
  nC := GetRandomRange(6, 20);
  if Random(40) = 0 then UserItem.btValue[1] := nC + 1;
  nC := GetRandomRange(g_Config.nRing23DCAddValueMaxLimit {6}, g_Config.nRing23DCAddValueRate {20});
  if Random(g_Config.nRing23DCAddRate {30}) = 0 then UserItem.btValue[2] := nC + 1;
  nC := GetRandomRange(g_Config.nRing23MCAddValueMaxLimit {6}, g_Config.nRing23MCAddValueRate {20});
  if Random(g_Config.nRing23MCAddRate {30}) = 0 then UserItem.btValue[3] := nC + 1;
  nC := GetRandomRange(g_Config.nRing23SCAddValueMaxLimit {6}, g_Config.nRing23SCAddValueRate {20});
  if Random(g_Config.nRing23SCAddRate {30}) = 0 then UserItem.btValue[4] := nC + 1;
  nC := GetRandomRange(6, 12);
  if Random(4) < 3 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.RandomUpgradeHelMet(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(6, 20);
  if Random(40) = 0 then UserItem.btValue[0] := nC + 1;
  nC := GetRandomRange(6, 20);
  if Random(30) = 0 then UserItem.btValue[1] := nC + 1;
  nC := GetRandomRange(g_Config.nHelMetDCAddValueMaxLimit {6}, g_Config.nHelMetDCAddValueRate {20});
  if Random(g_Config.nHelMetDCAddRate {30}) = 0 then UserItem.btValue[2] := nC + 1;
  nC := GetRandomRange(g_Config.nHelMetMCAddValueMaxLimit {6}, g_Config.nHelMetMCAddValueRate {20});
  if Random(g_Config.nHelMetMCAddRate {30}) = 0 then UserItem.btValue[3] := nC + 1;
  nC := GetRandomRange(g_Config.nHelMetSCAddValueMaxLimit {6}, g_Config.nHelMetSCAddValueRate {20});
  if Random(g_Config.nHelMetSCAddRate {30}) = 0 then UserItem.btValue[4] := nC + 1;
  nC := GetRandomRange(6, 12);
  if Random(4) < 3 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.UnknowHelmet(UserItem: pTUserItem); //神秘头盔
var
  nC, nRandPoint, n14: Integer;
begin
  nRandPoint := {GetRandomRange(4,3) + GetRandomRange(4,8) + } GetRandomRange(g_Config.nUnknowHelMetACAddValueMaxLimit {4}, g_Config.nUnknowHelMetACAddRate {20});
  if nRandPoint > 0 then UserItem.btValue[0] := nRandPoint;
  n14 := nRandPoint;
  nRandPoint := {GetRandomRange(4,3) + GetRandomRange(4,8) + } GetRandomRange(g_Config.nUnknowHelMetMACAddValueMaxLimit {4}, g_Config.nUnknowHelMetMACAddRate {20});
  if nRandPoint > 0 then UserItem.btValue[1] := nRandPoint;
  Inc(n14, nRandPoint);
  nRandPoint := {GetRandomRange(3,15) + } GetRandomRange(g_Config.nUnknowHelMetDCAddValueMaxLimit {3}, g_Config.nUnknowHelMetDCAddRate {30});
  if nRandPoint > 0 then UserItem.btValue[2] := nRandPoint;
  Inc(n14, nRandPoint);
  nRandPoint := {GetRandomRange(3,15) + } GetRandomRange(g_Config.nUnknowHelMetMCAddValueMaxLimit {3}, g_Config.nUnknowHelMetMCAddRate {30});
  if nRandPoint > 0 then UserItem.btValue[3] := nRandPoint;
  Inc(n14, nRandPoint);
  nRandPoint := {GetRandomRange(3,15) + } GetRandomRange(g_Config.nUnknowHelMetSCAddValueMaxLimit {3}, g_Config.nUnknowHelMetSCAddRate {30});
  if nRandPoint > 0 then UserItem.btValue[4] := nRandPoint;
  Inc(n14, nRandPoint);
  nRandPoint := GetRandomRange(6, 30);
  if nRandPoint > 0 then begin
    nC := (nRandPoint + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nC);
    UserItem.Dura := _MIN(65000, UserItem.Dura + nC);
  end;
  if Random(30) = 0 then UserItem.btValue[7] := 1;
  UserItem.btValue[8] := 1;
  if n14 >= 3 then begin
    if UserItem.btValue[0] >= 5 then begin
      UserItem.btValue[5] := 1;
      UserItem.btValue[6] := UserItem.btValue[0] * 3 + 25;
      Exit;
    end;
    if UserItem.btValue[2] >= 2 then begin
      UserItem.btValue[5] := 1;
      UserItem.btValue[6] := UserItem.btValue[2] * 4 + 35;
      Exit;
    end;
    if UserItem.btValue[3] >= 2 then begin
      UserItem.btValue[5] := 2;
      UserItem.btValue[6] := UserItem.btValue[3] * 2 + 18;
      Exit;
    end;
    if UserItem.btValue[4] >= 2 then begin
      UserItem.btValue[5] := 3;
      UserItem.btValue[6] := UserItem.btValue[4] * 2 + 18;
      Exit;
    end;
    UserItem.btValue[6] := n14 * 2 + 18;
  end;
end;

procedure TItemUnit.UnknowRing(UserItem: pTUserItem); //神秘戒指
var
  nC, n10, n14: Integer;
begin
  n10 := {GetRandomRange(4,3) + GetRandomRange(4,8) + } GetRandomRange(g_Config.nUnknowRingACAddValueMaxLimit {6}, g_Config.nUnknowRingACAddRate {20});
  if n10 > 0 then UserItem.btValue[0] := n10;
  n14 := n10;
  n10 := {GetRandomRange(4,3) + GetRandomRange(4,8) + } GetRandomRange(g_Config.nUnknowRingMACAddValueMaxLimit {6}, g_Config.nUnknowRingMACAddRate {20});
  if n10 > 0 then UserItem.btValue[1] := n10;
  Inc(n14, n10);
  // 以上二项为增加项，增加防，及魔防

  n10 := {GetRandomRange(4,3) + GetRandomRange(4,8) + } GetRandomRange(g_Config.nUnknowRingDCAddValueMaxLimit {6}, g_Config.nUnknowRingDCAddRate {20});
  if n10 > 0 then UserItem.btValue[2] := n10;
  Inc(n14, n10);
  n10 := {GetRandomRange(4,3) + GetRandomRange(4,8) + } GetRandomRange(g_Config.nUnknowRingMCAddValueMaxLimit {6}, g_Config.nUnknowRingMCAddRate {20});
  if n10 > 0 then UserItem.btValue[3] := n10;
  Inc(n14, n10);
  n10 := {GetRandomRange(4,3) + GetRandomRange(4,8) + } GetRandomRange(g_Config.nUnknowRingSCAddValueMaxLimit {6}, g_Config.nUnknowRingSCAddRate {20});
  if n10 > 0 then UserItem.btValue[4] := n10;
  Inc(n14, n10);
  n10 := GetRandomRange(6, 30);
  if n10 > 0 then begin
    nC := (n10 + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nC);
    UserItem.Dura := _MIN(65000, UserItem.Dura + nC);
  end;
  if Random(30) = 0 then UserItem.btValue[7] := 1;
  UserItem.btValue[8] := 1;
  if n14 >= 3 then begin
    if UserItem.btValue[2] >= 3 then begin
      UserItem.btValue[5] := 1;
      UserItem.btValue[6] := UserItem.btValue[2] * 3 + 25;
      Exit;
    end;
    if UserItem.btValue[3] >= 3 then begin
      UserItem.btValue[5] := 2;
      UserItem.btValue[6] := UserItem.btValue[3] * 2 + 18;
      Exit;
    end;
    if UserItem.btValue[4] >= 3 then begin
      UserItem.btValue[5] := 3;
      UserItem.btValue[6] := UserItem.btValue[4] * 2 + 18;
      Exit;
    end;
    UserItem.btValue[6] := n14 * 2 + 18;
  end;
end;

procedure TItemUnit.UnknowNecklace(UserItem: pTUserItem); //神秘腰带
var
  nC, n10, n14: Integer;
begin
  n10 := {GetRandomRange(3,5) + } GetRandomRange(g_Config.nUnknowNecklaceACAddValueMaxLimit {5}, g_Config.nUnknowNecklaceACAddRate {20});
  if n10 > 0 then UserItem.btValue[0] := n10;
  n14 := n10;
  n10 := {GetRandomRange(3,5) + } GetRandomRange(g_Config.nUnknowNecklaceMACAddValueMaxLimit {5}, g_Config.nUnknowNecklaceMACAddRate {20});
  if n10 > 0 then UserItem.btValue[1] := n10;
  Inc(n14, n10);
  n10 := {GetRandomRange(3,15) + } GetRandomRange(g_Config.nUnknowNecklaceDCAddValueMaxLimit {5}, g_Config.nUnknowNecklaceDCAddRate {30});
  if n10 > 0 then UserItem.btValue[2] := n10;
  Inc(n14, n10);
  n10 := {GetRandomRange(3,15) + } GetRandomRange(g_Config.nUnknowNecklaceMCAddValueMaxLimit {5}, g_Config.nUnknowNecklaceMCAddRate {30});
  if n10 > 0 then UserItem.btValue[3] := n10;
  Inc(n14, n10);
  n10 := {GetRandomRange(3,15) + } GetRandomRange(g_Config.nUnknowNecklaceSCAddValueMaxLimit {5}, g_Config.nUnknowNecklaceSCAddRate {30});
  if n10 > 0 then UserItem.btValue[4] := n10;
  Inc(n14, n10);
  n10 := GetRandomRange(6, 30);
  if n10 > 0 then begin
    nC := (n10 + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nC);
    UserItem.Dura := _MIN(65000, UserItem.Dura + nC);
  end;
  if Random(30) = 0 then UserItem.btValue[7] := 1;
  UserItem.btValue[8] := 1;
  if n14 >= 2 then begin
    if UserItem.btValue[0] >= 3 then begin
      UserItem.btValue[5] := 1;
      UserItem.btValue[6] := UserItem.btValue[0] * 3 + 25;
      Exit;
    end;
    if UserItem.btValue[2] >= 2 then begin
      UserItem.btValue[5] := 1;
      UserItem.btValue[6] := UserItem.btValue[2] * 3 + 30;
      Exit;
    end;
    if UserItem.btValue[3] >= 2 then begin
      UserItem.btValue[5] := 2;
      UserItem.btValue[6] := UserItem.btValue[3] * 2 + 20;
      Exit;
    end;
    if UserItem.btValue[4] >= 2 then begin
      UserItem.btValue[5] := 3;
      UserItem.btValue[6] := UserItem.btValue[4] * 2 + 20;
      Exit;
    end;
    UserItem.btValue[6] := n14 * 2 + 18;
  end;
end;

{
=============================增加装备新属性===================================
}


//1=新属性类型(1=物理伤害减少 2=魔法伤害减少 3=忽视目标防御 4=所有伤害反射 5=增加攻击伤害) 2=新属性值
//3=物理防御增强 4=魔法防御增强 5=物理攻击增强 6=魔法攻击增强 7=道术攻击增强 8=增加进入失明状态 9=增加进入混乱状态 10=减少进入失明状态 11=减少进入混乱状态 12=移动加速 13=攻击加速

procedure TItemUnit.RandomWeaponAddPoint(UserItem: pTUserItem);
var
  I, nC, n1C, n2C: Integer;
begin
  nC := GetRandomRange(g_Config.nWeaponPointAddValueMaxLimit {10}, g_Config.nWeaponPointAddValueRate {50});
  if Random(g_Config.nWeaponPointAddRate {60}) = 0 then begin
    if g_Config.nWeaponPointType > 4 then begin
      UserItem.AddPoint[1] := _MIN(Random(5) + 1, 5);
    end else begin
      UserItem.AddPoint[1] := g_Config.nWeaponPointType + 1;
    end;
    UserItem.AddPoint[2] := _MIN(nC + 1, g_Config.nWeaponPointAddValueMaxLimit);
  end;

  n2C := 0;
  while Random(g_Config.nWeaponPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 5 then break;
    n1C := Random(5);
    if (n1C in [0..4]) and g_Config.WeaponNewAbil[n1C] then begin
      nC := GetRandomRange(g_Config.nWeaponPointAddValueMaxLimit {10}, g_Config.nWeaponPointAddValueRate {50});
      UserItem.AddPoint[n1C + 3] := _MIN(nC + 1, g_Config.nWeaponPointAddValueMaxLimit);
    end;
  end;

  n2C := 0;
  while Random(g_Config.nWeaponPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 4 then break;
    n1C := Random(4);
    if (n1C in [0..3]) and g_Config.WeaponNewAbil[n1C + 5] then begin
      nC := GetRandomRange(g_Config.nWeaponPointAddValueMaxLimit {10}, g_Config.nWeaponPointAddValueRate {50});
      UserItem.AddPoint[n1C + 5 + 3] := _MIN(nC + 1, g_Config.nWeaponPointAddValueMaxLimit);
    end;
  end;

  n2C := 0;
  while Random(g_Config.nWeaponPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 2 then break;
    //n1C := Random(1);
    if Random(2) = 0 then begin
      n1C := 0;
    end else begin
      n1C := 1;
    end;
    if g_Config.WeaponNewAbil[n1C + 9] then begin
      nC := GetRandomRange(g_Config.nWeaponPointAddValueMaxLimit {10}, g_Config.nWeaponPointAddValueRate {50});
      UserItem.AddPoint[n1C + 12] := _MIN(nC + 1, g_Config.nWeaponPointAddValueMaxLimit);
    end;
  end;

  {if UserItem.AddPoint[2] > 0 then begin
    case UserItem.AddValue[12] of
      0: UserItem.AddValue[12] := 2;
      1: UserItem.AddValue[12] := 3;
    end;
  end;}
end;

procedure TItemUnit.RandomDressAddPoint(UserItem: pTUserItem);
var
  I, nC, n1C, n2C: Integer;
begin
  nC := GetRandomRange(g_Config.nDressPointAddValueMaxLimit {10}, g_Config.nDressPointAddValueRate {50});
  if Random(g_Config.nDressPointAddRate {60}) = 0 then begin
    if g_Config.nDressPointType > 4 then begin
      UserItem.AddPoint[1] := _MIN(Random(5) + 1, 5);
    end else begin
      UserItem.AddPoint[1] := g_Config.nDressPointType + 1;
    end;
    UserItem.AddPoint[2] := _MIN(nC + 1, g_Config.nDressPointAddValueMaxLimit);
  end;

  n2C := 0;
  while Random(g_Config.nDressPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 5 then break;
    n1C := Random(5);
    if (n1C in [0..4]) and g_Config.DressNewAbil[n1C] then begin
      nC := GetRandomRange(g_Config.nDressPointAddValueMaxLimit {10}, g_Config.nDressPointAddValueRate {50});
      UserItem.AddPoint[n1C + 3] := _MIN(nC + 1, g_Config.nDressPointAddValueMaxLimit);
    end;
  end;

  n2C := 0;
  while Random(g_Config.nDressPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 4 then break;
    n1C := Random(4);
    if (n1C in [0..3]) and g_Config.DressNewAbil[n1C + 5] then begin
      nC := GetRandomRange(g_Config.nDressPointAddValueMaxLimit {10}, g_Config.nDressPointAddValueRate {50});
      UserItem.AddPoint[n1C + 5 + 3] := _MIN(nC + 1, g_Config.nDressPointAddValueMaxLimit);
    end;
  end;

  n2C := 0;
  while Random(g_Config.nDressPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 2 then break;
    //n1C := Random(1);
    if Random(2) = 0 then begin
      n1C := 0;
    end else begin
      n1C := 1;
    end;
    if g_Config.DressNewAbil[n1C + 9] then begin
      nC := GetRandomRange(g_Config.nDressPointAddValueMaxLimit {10}, g_Config.nDressPointAddValueRate {50});
      UserItem.AddPoint[n1C + 12] := _MIN(nC + 1, g_Config.nDressPointAddValueMaxLimit);
    end;
  end;

  {if UserItem.AddPoint[2] > 0 then begin
    case UserItem.AddValue[12] of
      0: UserItem.AddValue[12] := 2;
      1: UserItem.AddValue[12] := 3;
    end;
  end;}
end;

procedure TItemUnit.RandomNeckLaceAddPoint(UserItem: pTUserItem);
var
  I, nC, n1C, n2C: Integer;
begin
  nC := GetRandomRange(g_Config.nNeckLacePointAddValueMaxLimit {10}, g_Config.nNeckLacePointAddValueRate {50});
  if Random(g_Config.nNeckLacePointAddRate {60}) = 0 then begin
    if g_Config.nNeckLacePointType > 4 then begin
      UserItem.AddPoint[1] := _MIN(Random(5) + 1, 5);
    end else begin
      UserItem.AddPoint[1] := g_Config.nNeckLacePointType + 1;
    end;
    UserItem.AddPoint[2] := _MIN(nC + 1, g_Config.nNeckLacePointAddValueMaxLimit);
  end;
  n2C := 0;
  while Random(g_Config.nNeckLacePointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 5 then break;
    n1C := Random(5);
    if (n1C in [0..4]) and g_Config.NeckLaceNewAbil[n1C] then begin
      nC := GetRandomRange(g_Config.nNeckLacePointAddValueMaxLimit {10}, g_Config.nNeckLacePointAddValueRate {50});
      UserItem.AddPoint[n1C + 3] := _MIN(nC + 1, g_Config.nNeckLacePointAddValueMaxLimit);
    end;
  end;

  n2C := 0;
  while Random(g_Config.nNeckLacePointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 4 then break;
    n1C := Random(4);
    if (n1C in [0..3]) and g_Config.NeckLaceNewAbil[n1C + 5] then begin
      nC := GetRandomRange(g_Config.nNeckLacePointAddValueMaxLimit {10}, g_Config.nNeckLacePointAddValueRate {50});
      UserItem.AddPoint[n1C + 5 + 3] := _MIN(nC + 1, g_Config.nNeckLacePointAddValueMaxLimit);
    end;
  end;

  n2C := 0;
  while Random(g_Config.nNeckLacePointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 2 then break;
    //n1C := Random(1);
    if Random(2) = 0 then begin
      n1C := 0;
    end else begin
      n1C := 1;
    end;
    if g_Config.NeckLaceNewAbil[n1C + 9] then begin
      nC := GetRandomRange(g_Config.nNeckLacePointAddValueMaxLimit {10}, g_Config.nNeckLacePointAddValueRate {50});
      UserItem.AddPoint[n1C + 12] := _MIN(nC + 1, g_Config.nNeckLacePointAddValueMaxLimit);
    end;
  end;

 { if UserItem.AddPoint[2] > 0 then begin
    case UserItem.AddValue[12] of
      0: UserItem.AddValue[12] := 2;
      1: UserItem.AddValue[12] := 3;
    end;
  end; }
  //UserItem.AddValue[12] := _MIN(UserItem.AddValue[12], 3);
end;

procedure TItemUnit.RandomArmRingAddPoint(UserItem: pTUserItem);
var
  I, nC, n1C, n2C: Integer;
begin
  nC := GetRandomRange(g_Config.nArmRingPointAddValueMaxLimit {10}, g_Config.nArmRingPointAddValueRate {50});
  if Random(g_Config.nArmRingPointAddRate {60}) = 0 then begin
    if g_Config.nArmRingPointType > 4 then begin
      UserItem.AddPoint[1] := _MIN(Random(5) + 1, 5);
    end else begin
      UserItem.AddPoint[1] := g_Config.nArmRingPointType + 1;
    end;
    UserItem.AddPoint[2] := _MIN(nC + 1, g_Config.nArmRingPointAddValueMaxLimit);

  end;

  n2C := 0;
  while Random(g_Config.nArmRingPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 5 then break;
    n1C := Random(5);
    if (n1C in [0..4]) and g_Config.ArmRingNewAbil[n1C] then begin
      nC := GetRandomRange(g_Config.nArmRingPointAddValueMaxLimit {10}, g_Config.nArmRingPointAddValueRate {50});
      UserItem.AddPoint[n1C + 3] := _MIN(nC + 1, g_Config.nArmRingPointAddValueMaxLimit);
    end;
  end;

  n2C := 0;
  while Random(g_Config.nArmRingPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 4 then break;
    n1C := Random(4);
    if (n1C in [0..3]) and g_Config.ArmRingNewAbil[n1C + 5] then begin
      nC := GetRandomRange(g_Config.nArmRingPointAddValueMaxLimit {10}, g_Config.nArmRingPointAddValueRate {50});
      UserItem.AddPoint[n1C + 5 + 3] := _MIN(nC + 1, g_Config.nArmRingPointAddValueMaxLimit);
    end;
  end;

  n2C := 0;
  while Random(g_Config.nArmRingPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 2 then break;
    //n1C := Random(1);
    if Random(2) = 0 then begin
      n1C := 0;
    end else begin
      n1C := 1;
    end;
    if g_Config.ArmRingNewAbil[n1C + 9] then begin
      nC := GetRandomRange(g_Config.nArmRingPointAddValueMaxLimit {10}, g_Config.nArmRingPointAddValueRate {50});
      UserItem.AddPoint[n1C + 12] := _MIN(nC + 1, g_Config.nArmRingPointAddValueMaxLimit);
    end;
  end;

  {if UserItem.AddPoint[2] > 0 then begin
    case UserItem.AddValue[12] of
      0: UserItem.AddValue[12] := 2;
      1: UserItem.AddValue[12] := 3;
    end;
  end;}
  //UserItem.AddValue[12] := _MIN(UserItem.AddValue[12], 3);
end;

procedure TItemUnit.RandomRingAddPoint(UserItem: pTUserItem);
var
  I, nC, n1C, n2C: Integer;
begin
  nC := GetRandomRange(g_Config.nRingPointAddValueMaxLimit {10}, g_Config.nRingPointAddValueRate {50});
  if Random(g_Config.nRingPointAddRate {60}) = 0 then begin
    if g_Config.nRingPointType > 4 then begin
      UserItem.AddPoint[1] := _MIN(Random(5) + 1, 5);
    end else begin
      UserItem.AddPoint[1] := g_Config.nRingPointType + 1;
    end;
    UserItem.AddPoint[2] := _MIN(nC + 1, g_Config.nRingPointAddValueMaxLimit);
  end;

  n2C := 0;
  while Random(g_Config.nRingPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 5 then break;
    n1C := Random(5);
    if (n1C in [0..4]) and g_Config.RingNewAbil[n1C] then begin
      nC := GetRandomRange(g_Config.nRingPointAddValueMaxLimit {10}, g_Config.nRingPointAddValueRate {50});
      UserItem.AddPoint[n1C + 3] := _MIN(nC + 1, g_Config.nRingPointAddValueMaxLimit);
    end;
  end;

  n2C := 0;
  while Random(g_Config.nRingPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 4 then break;
    n1C := Random(4);
    if (n1C in [0..3]) and g_Config.RingNewAbil[n1C + 5] then begin
      nC := GetRandomRange(g_Config.nRingPointAddValueMaxLimit {10}, g_Config.nRingPointAddValueRate {50});
      UserItem.AddPoint[n1C + 5 + 3] := _MIN(nC + 1, g_Config.nRingPointAddValueMaxLimit);
    end;
  end;

  n2C := 0;
  while Random(g_Config.nRingPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 2 then break;
    //n1C := Random(1);
    if Random(2) = 0 then begin
      n1C := 0;
    end else begin
      n1C := 1;
    end;
    if g_Config.RingNewAbil[n1C + 9] then begin
      nC := GetRandomRange(g_Config.nRingPointAddValueMaxLimit {10}, g_Config.nRingPointAddValueRate {50});
      UserItem.AddPoint[n1C + 12] := _MIN(nC + 1, g_Config.nRingPointAddValueMaxLimit);
    end;
  end;

  {if UserItem.AddPoint[2] > 0 then begin
    case UserItem.AddValue[12] of
      0: UserItem.AddValue[12] := 2;
      1: UserItem.AddValue[12] := 3;
    end;
  end; }
  //UserItem.AddValue[12] := _MIN(UserItem.AddValue[12], 3);
end;

procedure TItemUnit.RandomHelMetAddPoint(UserItem: pTUserItem);
var
  I, nC, n1C, n2C: Integer;
begin
  nC := GetRandomRange(g_Config.nHelMetPointAddValueMaxLimit {10}, g_Config.nHelMetPointAddValueRate {50});
  if Random(g_Config.nHelMetPointAddRate {60}) = 0 then begin
    if g_Config.nHelMetPointType > 4 then begin
      UserItem.AddPoint[1] := _MIN(Random(5) + 1, 5);
    end else begin
      UserItem.AddPoint[1] := g_Config.nHelMetPointType + 1;
    end;
    UserItem.AddPoint[2] := _MIN(nC + 1, g_Config.nHelMetPointAddValueMaxLimit);
  end;

  n2C := 0;
  while Random(g_Config.nHelMetPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 5 then break;
    n1C := Random(5);
    if (n1C in [0..4]) and g_Config.HelMetNewAbil[n1C] then begin
      nC := GetRandomRange(g_Config.nHelMetPointAddValueMaxLimit {10}, g_Config.nHelMetPointAddValueRate {50});
      UserItem.AddPoint[n1C + 3] := _MIN(nC + 1, g_Config.nHelMetPointAddValueMaxLimit);
    end;
  end;

  n2C := 0;
  while Random(g_Config.nHelMetPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 4 then break;
    n1C := Random(4);
    if (n1C in [0..3]) and g_Config.HelMetNewAbil[n1C + 5] then begin
      nC := GetRandomRange(g_Config.nHelMetPointAddValueMaxLimit {10}, g_Config.nHelMetPointAddValueRate {50});
      UserItem.AddPoint[n1C + 5 + 3] := _MIN(nC + 1, g_Config.nHelMetPointAddValueMaxLimit);
    end;
  end;

  n2C := 0;
  while Random(g_Config.nHelMetPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 2 then break;
    //n1C := Random(1);
    if Random(2) = 0 then begin
      n1C := 0;
    end else begin
      n1C := 1;
    end;
    if g_Config.HelMetNewAbil[n1C + 9] then begin
      nC := GetRandomRange(g_Config.nHelMetPointAddValueMaxLimit {10}, g_Config.nHelMetPointAddValueRate {50});
      UserItem.AddPoint[n1C + 12] := _MIN(nC + 1, g_Config.nHelMetPointAddValueMaxLimit);
    end;
  end;

  {if UserItem.AddPoint[2] > 0 then begin
    case UserItem.AddValue[12] of
      0: UserItem.AddValue[12] := 2;
      1: UserItem.AddValue[12] := 3;
    end;
  end;}
  //UserItem.AddValue[12] := _MIN(UserItem.AddValue[12], 3);
end;

procedure TItemUnit.RandomShoesAddPoint(UserItem: pTUserItem);
var
  I, nC, n1C, n2C: Integer;
begin
  nC := GetRandomRange(g_Config.nShoesPointAddValueMaxLimit {10}, g_Config.nShoesPointAddValueRate {50});
  if Random(g_Config.nShoesPointAddRate {60}) = 0 then begin
    if g_Config.nShoesPointType > 4 then begin
      UserItem.AddPoint[1] := _MIN(Random(5) + 1, 5);
    end else begin
      UserItem.AddPoint[1] := g_Config.nShoesPointType + 1;
    end;
    UserItem.AddPoint[2] := _MIN(nC + 1, g_Config.nShoesPointAddValueMaxLimit);
  end;

  n2C := 0;
  while Random(g_Config.nShoesPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 5 then break;
    n1C := Random(5);
    if (n1C in [0..4]) and g_Config.ShoesNewAbil[n1C] then begin
      nC := GetRandomRange(g_Config.nShoesPointAddValueMaxLimit {10}, g_Config.nShoesPointAddValueRate {50});
      UserItem.AddPoint[n1C + 3] := _MIN(nC + 1, g_Config.nShoesPointAddValueMaxLimit);
    end;
  end;

  n2C := 0;
  while Random(g_Config.nShoesPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 4 then break;
    n1C := Random(4);
    if (n1C in [0..3]) and g_Config.ShoesNewAbil[n1C + 5] then begin
      nC := GetRandomRange(g_Config.nShoesPointAddValueMaxLimit {10}, g_Config.nShoesPointAddValueRate {50});
      UserItem.AddPoint[n1C + 5 + 3] := _MIN(nC + 1, g_Config.nShoesPointAddValueMaxLimit);
    end;
  end;

  n2C := 0;
  while Random(g_Config.nShoesPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 2 then break;
    //n1C := Random(1);
    if Random(2) = 0 then begin
      n1C := 0;
    end else begin
      n1C := 1;
    end;
    if g_Config.ShoesNewAbil[n1C + 9] then begin
      nC := GetRandomRange(g_Config.nShoesPointAddValueMaxLimit {10}, g_Config.nShoesPointAddValueRate {50});
      UserItem.AddPoint[n1C + 12] := _MIN(nC + 1, g_Config.nShoesPointAddValueMaxLimit);
    end;
  end;

  {if UserItem.AddPoint[2] > 0 then begin
    case UserItem.AddValue[12] of
      0: UserItem.AddValue[12] := 2;
      1: UserItem.AddValue[12] := 3;
    end;
  end;}
  //UserItem.AddValue[12] := _MIN(UserItem.AddValue[12], 3);
end;

procedure TItemUnit.RandomBeltAddPoint(UserItem: pTUserItem);
var
  I, nC, n1C, n2C: Integer;
begin
  nC := GetRandomRange(g_Config.nBeltPointAddValueMaxLimit {10}, g_Config.nBeltPointAddValueRate {50});
  if Random(g_Config.nBeltPointAddRate {60}) = 0 then begin
    if g_Config.nBeltPointType > 4 then begin
      UserItem.AddPoint[1] := _MIN(Random(5) + 1, 5);
    end else begin
      UserItem.AddPoint[1] := g_Config.nBeltPointType + 1;
    end;
    UserItem.AddPoint[2] := _MIN(nC + 1, g_Config.nBeltPointAddValueMaxLimit);
  end;

  n2C := 0;
  while Random(g_Config.nBeltPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 5 then break;
    n1C := Random(5);
    if (n1C in [0..4]) and g_Config.BeltNewAbil[n1C] then begin
      nC := GetRandomRange(g_Config.nBeltPointAddValueMaxLimit {10}, g_Config.nBeltPointAddValueRate {50});
      UserItem.AddPoint[n1C + 3] := _MIN(nC + 1, g_Config.nBeltPointAddValueMaxLimit);
    end;
  end;

  n2C := 0;
  while Random(g_Config.nBeltPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 4 then break;
    n1C := Random(4);
    if (n1C in [0..3]) and g_Config.BeltNewAbil[n1C + 5] then begin
      nC := GetRandomRange(g_Config.nBeltPointAddValueMaxLimit {10}, g_Config.nBeltPointAddValueRate {50});
      UserItem.AddPoint[n1C + 5 + 3] := _MIN(nC + 1, g_Config.nBeltPointAddValueMaxLimit);
    end;
  end;

  n2C := 0;
  while Random(g_Config.nBeltPointAddRate) = 0 do begin
    Inc(n2C);
    if n2C >= 2 then break;
    //n1C := Random(1);
    if Random(2) = 0 then begin
      n1C := 0;
    end else begin
      n1C := 1;
    end;
    if g_Config.BeltNewAbil[n1C + 9] then begin
      nC := GetRandomRange(g_Config.nBeltPointAddValueMaxLimit {10}, g_Config.nBeltPointAddValueRate {50});
      UserItem.AddPoint[n1C + 12] := _MIN(nC + 1, g_Config.nBeltPointAddValueMaxLimit);
    end;
  end;

  {if UserItem.AddPoint[2] > 0 then begin
    case UserItem.AddValue[12] of
      0: UserItem.AddValue[12] := 2;
      1: UserItem.AddValue[12] := 3;
    end;
  end;}
  //UserItem.AddValue[12] := _MIN(UserItem.AddValue[12], 3);
end;

{------------------------------------------------------------------------------}

function TItemUnit.GetNewValue(nOldValue, nValue: Integer; btMethod: Byte): Byte;
begin
  case btMethod of
    0: Result := _MIN(nOldValue + nValue, 255);
    1: Result := _MAX(nOldValue - nValue, 0);
    2: Result := _MIN(_MAX(nValue, 0), 255);
  end;
end;

procedure TItemUnit.RandomUpgradeWeapon_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
var
  n10: Integer;
begin
  UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], nValue, btMethod);
  UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], nValue, btMethod);
  UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], nValue, btMethod);

  {UserItem.btValue[5] := GetNewValue(UserItem.btValue[5], nValue, btMethod);
  UserItem.btValue[6] := GetNewValue(UserItem.btValue[6], nValue, btMethod);}

  {if UserItem.AddValue[13] > 5 then UserItem.AddValue[12] := 1;
  if UserItem.AddValue[12] > 0 then begin
    UserItem.AddValue[12] := 0;
    n10 := nValue * 2000;
    if boAdd then begin
      UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
      UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
    end else begin
      UserItem.DuraMax := _MAX(1000, UserItem.DuraMax - n10);
      UserItem.Dura := _MAX(1000, UserItem.Dura - n10);
    end;
  end;}
end;

procedure TItemUnit.RandomUpgradeDress_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
var
  n10: Integer;
begin
  UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], nValue, btMethod);
  UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], nValue, btMethod);
  UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], nValue, btMethod);
  UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], nValue, btMethod);
  UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], nValue, btMethod);
  {if UserItem.AddValue[13] > 5 then UserItem.AddValue[12] := 1;
  if UserItem.AddValue[12] > 0 then begin
    UserItem.AddValue[12] := 0;
    n10 := nValue * 2000;
    if boAdd then begin
      UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
      UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
    end else begin
      UserItem.DuraMax := _MAX(1000, UserItem.DuraMax - n10);
      UserItem.Dura := _MAX(1000, UserItem.Dura - n10);
    end;
  end;}
end;

procedure TItemUnit.RandomUpgrade202124_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
var
  n10: Integer;
begin
  UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], nValue, btMethod);
  UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], nValue, btMethod);
  UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], nValue, btMethod);
  UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], nValue, btMethod);
  UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], nValue, btMethod);
  {if UserItem.AddValue[13] > 5 then UserItem.AddValue[12] := 1;
  if UserItem.AddValue[12] > 0 then begin
    UserItem.AddValue[12] := 0;
    n10 := nValue * 1000;
    if boAdd then begin
      UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
      UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
    end else begin
      UserItem.DuraMax := _MAX(1000, UserItem.DuraMax - n10);
      UserItem.Dura := _MAX(1000, UserItem.Dura - n10);
    end;
  end;}
end;

procedure TItemUnit.RandomUpgrade26_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
var
  n10: Integer;
begin
  UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], nValue, btMethod);
  UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], nValue, btMethod);
  UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], nValue, btMethod);
  UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], nValue, btMethod);
  UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], nValue, btMethod);
  {if UserItem.AddValue[13] > 5 then UserItem.AddValue[12] := 1;
  if UserItem.AddValue[12] > 0 then begin
    UserItem.AddValue[12] := 0;
    n10 := nValue * 1000;
    if boAdd then begin
      UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
      UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
    end else begin
      UserItem.DuraMax := _MAX(1000, UserItem.DuraMax - n10);
      UserItem.Dura := _MAX(1000, UserItem.Dura - n10);
    end;
  end;}
end;

procedure TItemUnit.RandomUpgrade19_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
var
  n10: Integer;
begin
  UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], nValue, btMethod);
  UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], nValue, btMethod);
  UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], nValue, btMethod);
  UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], nValue, btMethod);
  UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], nValue, btMethod);
  {if UserItem.AddValue[13] > 5 then UserItem.AddValue[12] := 1;
  if UserItem.AddValue[12] > 0 then begin
    UserItem.AddValue[12] := 0;
    n10 := nValue * 1000;
    if boAdd then begin
      UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
      UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
    end else begin
      UserItem.DuraMax := _MAX(1000, UserItem.DuraMax - n10);
      UserItem.Dura := _MAX(1000, UserItem.Dura - n10);
    end;
  end;}
end;

procedure TItemUnit.RandomUpgrade22_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
var
  n10: Integer;
begin
  UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], nValue, btMethod);
  UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], nValue, btMethod);
  UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], nValue, btMethod);
  {if UserItem.AddValue[13] > 5 then UserItem.AddValue[12] := 1;
  if UserItem.AddValue[12] > 0 then begin
    UserItem.AddValue[12] := 0;
    n10 := nValue * 1000;
    if boAdd then begin
      UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
      UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
    end else begin
      UserItem.DuraMax := _MAX(1000, UserItem.DuraMax - n10);
      UserItem.Dura := _MAX(1000, UserItem.Dura - n10);
    end;
  end;}
end;

procedure TItemUnit.RandomUpgrade23_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
var
  n10: Integer;
begin
  UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], nValue, btMethod);
  UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], nValue, btMethod);
  UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], nValue, btMethod);
  UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], nValue, btMethod);
  UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], nValue, btMethod);
  {if UserItem.AddValue[13] > 5 then UserItem.AddValue[12] := 1;
  if UserItem.AddValue[12] > 0 then begin
    UserItem.AddValue[12] := 0;
    n10 := nValue * 1000;
    if boAdd then begin
      UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
      UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
    end else begin
      UserItem.DuraMax := _MAX(1000, UserItem.DuraMax - n10);
      UserItem.Dura := _MAX(1000, UserItem.Dura - n10);
    end;
  end;}
end;

procedure TItemUnit.RandomUpgradeHelMet_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte);
var
  n10: Integer;
begin
  UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], nValue, btMethod);
  UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], nValue, btMethod);
  UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], nValue, btMethod);
  UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], nValue, btMethod);
  UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], nValue, btMethod);
  {if UserItem.AddValue[13] > 5 then UserItem.AddValue[12] := 1;
  if UserItem.AddValue[12] > 0 then begin
    UserItem.AddValue[12] := 0;
    n10 := nValue * 1000;
    if boAdd then begin
      UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
      UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
    end else begin
      UserItem.DuraMax := _MAX(1000, UserItem.DuraMax - n10);
      UserItem.Dura := _MAX(1000, UserItem.Dura - n10);
    end;
  end;}
end;

procedure TItemUnit.UnknowHelmet_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte); //神秘头盔
var
  n10: Integer;
begin
  UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], nValue, btMethod);
  UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], nValue, btMethod);
  UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], nValue, btMethod);
  UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], nValue, btMethod);
  UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], nValue, btMethod);

  {if UserItem.AddValue[13] > 5 then UserItem.AddValue[12] := 1;
  if UserItem.AddValue[12] > 0 then begin
    UserItem.AddValue[12] := 0;
    n10 := nValue * 1000;
    if boAdd then begin
      UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
      UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
    end else begin
      UserItem.DuraMax := _MAX(1000, UserItem.DuraMax - n10);
      UserItem.Dura := _MAX(1000, UserItem.Dura - n10);
    end;
  end;}
end;

procedure TItemUnit.UnknowRing_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte); //神秘戒指
var
  n10: Integer;
begin
  UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], nValue, btMethod);
  UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], nValue, btMethod);
  UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], nValue, btMethod);
  UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], nValue, btMethod);
  UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], nValue, btMethod);
  {if UserItem.AddValue[13] > 5 then UserItem.AddValue[12] := 1;
  if UserItem.AddValue[12] > 0 then begin
    UserItem.AddValue[12] := 0;
    n10 := nValue * 1000;
    if boAdd then begin
      UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
      UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
    end else begin
      UserItem.DuraMax := _MAX(1000, UserItem.DuraMax - n10);
      UserItem.Dura := _MAX(1000, UserItem.Dura - n10);
    end;
  end;}
end;

procedure TItemUnit.UnknowNecklace_(UserItem: pTUserItem; nValue: Integer; btMethod: Byte); //神秘腰带
var
  n10: Integer;
begin
  UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], nValue, btMethod);
  UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], nValue, btMethod);
  UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], nValue, btMethod);
  UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], nValue, btMethod);
  UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], nValue, btMethod);
 { if UserItem.AddValue[13] > 5 then UserItem.AddValue[12] := 1;
  if UserItem.AddValue[12] > 0 then begin
    UserItem.AddValue[12] := 0;
    n10 := nValue * 1000;
    if boAdd then begin
      UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
      UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
    end else begin
      UserItem.DuraMax := _MAX(1000, UserItem.DuraMax - n10);
      UserItem.Dura := _MAX(1000, UserItem.Dura - n10);
    end;
  end; }
end;


//===============================================================================

procedure TItemUnit.UpgradeItems_(UserItem: pTUserItem; StdItem: pTStdItem; btMethod: Byte);
var
  n10: Integer;
  Item: pTStdItem;
begin
  Item := UserEngine.GetStdItem(UserItem.wIndex);
  if Item = nil then Exit;
  case Item.StdMode of
    5, 6: begin
        UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], HiWord(StdItem.DC), btMethod);
        UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], HiWord(StdItem.MC), btMethod);
        UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], HiWord(StdItem.SC), btMethod);

        {UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], LoWord(StdItem.AC), btMethod);
        UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], LoWord(StdItem.MAC), btMethod);
        UserItem.btValue[5] := GetNewValue(UserItem.btValue[5], HiWord(StdItem.AC), btMethod);
        UserItem.btValue[6] := GetNewValue(UserItem.btValue[6], HiWord(StdItem.MAC), btMethod);}

        UserItem.AddValue[7] := GetNewValue(UserItem.AddValue[7], LoWord(StdItem.DC), btMethod);
        UserItem.AddValue[8] := GetNewValue(UserItem.AddValue[8], LoWord(StdItem.MC), btMethod);
        UserItem.AddValue[9] := GetNewValue(UserItem.AddValue[9], LoWord(StdItem.SC), btMethod);
      end;
    10, 11: begin
        UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], HiWord(StdItem.AC), btMethod);
        UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], HiWord(StdItem.MAC), btMethod);
        UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], HiWord(StdItem.DC), btMethod);
        UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], HiWord(StdItem.MC), btMethod);
        UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], HiWord(StdItem.SC), btMethod);

        UserItem.AddValue[7] := GetNewValue(UserItem.AddValue[7], LoWord(StdItem.AC), btMethod);
        UserItem.AddValue[8] := GetNewValue(UserItem.AddValue[8], LoWord(StdItem.MAC), btMethod);
        UserItem.AddValue[9] := GetNewValue(UserItem.AddValue[9], LoWord(StdItem.DC), btMethod);
        UserItem.AddValue[10] := GetNewValue(UserItem.AddValue[10], LoWord(StdItem.MC), btMethod);
        UserItem.AddValue[11] := GetNewValue(UserItem.AddValue[11], LoWord(StdItem.SC), btMethod);
      end;
    15, 19, 20, 21, 22, 23, 24, 26, 51, 52, 53, 54, 62, 63, 64: begin
        if (Item.StdMode in [15, 22, 26, 51, 52, 53, 54, 62, 63, 64]) then begin
          UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], HiWord(StdItem.AC), btMethod);
          UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], HiWord(StdItem.MAC), btMethod);

          UserItem.AddValue[7] := GetNewValue(UserItem.AddValue[7], LoWord(StdItem.AC), btMethod);
          UserItem.AddValue[8] := GetNewValue(UserItem.AddValue[8], LoWord(StdItem.MAC), btMethod);
        end;

        UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], HiWord(StdItem.DC), btMethod);
        UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], HiWord(StdItem.MC), btMethod);
        UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], HiWord(StdItem.SC), btMethod);

        UserItem.AddValue[9] := GetNewValue(UserItem.AddValue[9], LoWord(StdItem.DC), btMethod);
        UserItem.AddValue[10] := GetNewValue(UserItem.AddValue[10], LoWord(StdItem.MC), btMethod);
        UserItem.AddValue[11] := GetNewValue(UserItem.AddValue[11], LoWord(StdItem.SC), btMethod);
      end;
  end;
end;
procedure TItemUnit.UpgradeItemsX_(UserItem: pTUserItem; StdItem, Value: Byte; btMethod: Byte);
var
  n10, nWhere: Integer;
  Item: pTStdItem;
begin
  Item := UserEngine.GetStdItem(UserItem.wIndex);
  if Item = nil then Exit;
  case Item.StdMode of
    5, 6: begin
        nWhere := -1;
        case StdItem of
          0: nWhere := 3;
          1: nWhere := 4;
          2: nWhere := 7;
          3: nWhere := 8;
          4: nWhere := 9;

          5: nWhere := 5;
          6: nWhere := 6;
          7: nWhere := 0;
          8: nWhere := 1;
          9: nWhere := 2;
        end;
        if nWhere >= 0 then begin
          if nWhere <= 6 then begin
            UserItem.btValue[nWhere] := GetNewValue(UserItem.btValue[nWhere], Value, btMethod);
          end else begin
            UserItem.AddValue[nWhere] := GetNewValue(UserItem.AddValue[nWhere], Value, btMethod);
          end;
        end;

       { UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], LoWord(StdItem.AC), btMethod);
        UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], LoWord(StdItem.MAC), btMethod);
        UserItem.AddValue[7] := GetNewValue(UserItem.AddValue[7], LoWord(StdItem.DC), btMethod);
        UserItem.AddValue[8] := GetNewValue(UserItem.AddValue[8], LoWord(StdItem.MC), btMethod);
        UserItem.AddValue[9] := GetNewValue(UserItem.AddValue[9], LoWord(StdItem.SC), btMethod);


        UserItem.btValue[5] := GetNewValue(UserItem.btValue[5], HiWord(StdItem.AC), btMethod);
        UserItem.btValue[6] := GetNewValue(UserItem.btValue[6], HiWord(StdItem.MAC), btMethod);
        UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], HiWord(StdItem.DC), btMethod);
        UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], HiWord(StdItem.MC), btMethod);
        UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], HiWord(StdItem.SC), btMethod);   }
      end;
    10, 11: begin
        nWhere := -1;
        case StdItem of
          0: nWhere := 7;
          1: nWhere := 8;
          2: nWhere := 9;
          3: nWhere := 10;
          4: nWhere := 11;

          5: nWhere := 0;
          6: nWhere := 1;
          7: nWhere := 2;
          8: nWhere := 3;
          9: nWhere := 4;
        end;
        if nWhere >= 0 then begin
          if nWhere <= 4 then begin
            UserItem.btValue[nWhere] := GetNewValue(UserItem.btValue[nWhere], Value, btMethod);
          end else begin
            UserItem.AddValue[nWhere] := GetNewValue(UserItem.AddValue[nWhere], Value, btMethod);
          end;
        end;
        {
        UserItem.AddValue[7] := GetNewValue(UserItem.AddValue[7], LoWord(StdItem.AC), btMethod);
        UserItem.AddValue[8] := GetNewValue(UserItem.AddValue[8], LoWord(StdItem.MAC), btMethod);
        UserItem.AddValue[9] := GetNewValue(UserItem.AddValue[9], LoWord(StdItem.DC), btMethod);
        UserItem.AddValue[10] := GetNewValue(UserItem.AddValue[10], LoWord(StdItem.MC), btMethod);
        UserItem.AddValue[11] := GetNewValue(UserItem.AddValue[11], LoWord(StdItem.SC), btMethod);

        UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], HiWord(StdItem.AC), btMethod);
        UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], HiWord(StdItem.MAC), btMethod);
        UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], HiWord(StdItem.DC), btMethod);
        UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], HiWord(StdItem.MC), btMethod);
        UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], HiWord(StdItem.SC), btMethod); }
      end;
    15, 19, 20, 21, 22, 23, 24, 26, 51, 52, 53, 54, 62, 63, 64: begin
        nWhere := -1;
        case StdItem of
          0: nWhere := 7;
          1: nWhere := 8;
          2: nWhere := 9;
          3: nWhere := 10;
          4: nWhere := 11;

          5: nWhere := 0;
          6: nWhere := 1;
          7: nWhere := 2;
          8: nWhere := 3;
          9: nWhere := 4;
        end;
        if nWhere >= 0 then begin
          if nWhere <= 4 then begin
            UserItem.btValue[nWhere] := GetNewValue(UserItem.btValue[nWhere], Value, btMethod);
          end else begin
            UserItem.AddValue[nWhere] := GetNewValue(UserItem.AddValue[nWhere], Value, btMethod);
          end;
        end;
        {UserItem.AddValue[7] := GetNewValue(UserItem.AddValue[7], LoWord(StdItem.AC), btMethod);
        UserItem.AddValue[8] := GetNewValue(UserItem.AddValue[8], LoWord(StdItem.MAC), btMethod);
        UserItem.AddValue[9] := GetNewValue(UserItem.AddValue[9], LoWord(StdItem.DC), btMethod);
        UserItem.AddValue[10] := GetNewValue(UserItem.AddValue[10], LoWord(StdItem.MC), btMethod);
        UserItem.AddValue[11] := GetNewValue(UserItem.AddValue[11], LoWord(StdItem.SC), btMethod);

        UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], HiWord(StdItem.AC), btMethod);
        UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], HiWord(StdItem.MAC), btMethod);
        UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], HiWord(StdItem.DC), btMethod);
        UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], HiWord(StdItem.MC), btMethod);
        UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], HiWord(StdItem.SC), btMethod);}
      end;
  end;
end;

(*
procedure TItemUnit.UpgradeItemsX_(UserItem: pTUserItem; StdItem, Value: Byte; btMethod: Byte);
var
  n10, nWhere: Integer;
  Item: pTStdItem;
begin
  Item := UserEngine.GetStdItem(UserItem.wIndex);
  if Item = nil then Exit;
  case Item.StdMode of
    5, 6: begin
        nWhere := -1;
        case StdItem of
          0: nWhere := 3;
          1: nWhere := 4;
          2: nWhere := 7;
          3: nWhere := 8;
          4: nWhere := 9;

          5: nWhere := 5;
          6: nWhere := 6;
          7: nWhere := 0;
          8: nWhere := 1;
          9: nWhere := 2;
        end;
        if nWhere >= 0 then begin
          if nWhere <= 6 then begin
            if not (nWhere in [3..6]) then
              UserItem.btValue[nWhere] := GetNewValue(UserItem.btValue[nWhere], Value, btMethod);
          end else begin
            UserItem.AddValue[nWhere] := GetNewValue(UserItem.AddValue[nWhere], Value, btMethod);
          end;
        end;

       { UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], LoWord(StdItem.AC), btMethod);
        UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], LoWord(StdItem.MAC), btMethod);
        UserItem.AddValue[7] := GetNewValue(UserItem.AddValue[7], LoWord(StdItem.DC), btMethod);
        UserItem.AddValue[8] := GetNewValue(UserItem.AddValue[8], LoWord(StdItem.MC), btMethod);
        UserItem.AddValue[9] := GetNewValue(UserItem.AddValue[9], LoWord(StdItem.SC), btMethod);


        UserItem.btValue[5] := GetNewValue(UserItem.btValue[5], HiWord(StdItem.AC), btMethod);
        UserItem.btValue[6] := GetNewValue(UserItem.btValue[6], HiWord(StdItem.MAC), btMethod);
        UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], HiWord(StdItem.DC), btMethod);
        UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], HiWord(StdItem.MC), btMethod);
        UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], HiWord(StdItem.SC), btMethod);   }
      end;
    10, 11: begin
        nWhere := -1;
        case StdItem of
          0: nWhere := 7;
          1: nWhere := 8;
          2: nWhere := 9;
          3: nWhere := 10;
          4: nWhere := 11;

          5: nWhere := 0;
          6: nWhere := 1;
          7: nWhere := 2;
          8: nWhere := 3;
          9: nWhere := 4;
        end;
        if nWhere >= 0 then begin
          if nWhere <= 4 then begin
            UserItem.btValue[nWhere] := GetNewValue(UserItem.btValue[nWhere], Value, btMethod);
          end else begin
            UserItem.AddValue[nWhere] := GetNewValue(UserItem.AddValue[nWhere], Value, btMethod);
          end;
        end;
        {
        UserItem.AddValue[7] := GetNewValue(UserItem.AddValue[7], LoWord(StdItem.AC), btMethod);
        UserItem.AddValue[8] := GetNewValue(UserItem.AddValue[8], LoWord(StdItem.MAC), btMethod);
        UserItem.AddValue[9] := GetNewValue(UserItem.AddValue[9], LoWord(StdItem.DC), btMethod);
        UserItem.AddValue[10] := GetNewValue(UserItem.AddValue[10], LoWord(StdItem.MC), btMethod);
        UserItem.AddValue[11] := GetNewValue(UserItem.AddValue[11], LoWord(StdItem.SC), btMethod);

        UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], HiWord(StdItem.AC), btMethod);
        UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], HiWord(StdItem.MAC), btMethod);
        UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], HiWord(StdItem.DC), btMethod);
        UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], HiWord(StdItem.MC), btMethod);
        UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], HiWord(StdItem.SC), btMethod); }
      end;
    15, 19, 20, 21, 22, 23, 24, 26, 51, 52, 53, 54, 62, 63, 64: begin
        nWhere := -1;
        case StdItem of
          0: nWhere := 7;
          1: nWhere := 8;
          2: nWhere := 9;
          3: nWhere := 10;
          4: nWhere := 11;

          5: nWhere := 0;
          6: nWhere := 1;
          7: nWhere := 2;
          8: nWhere := 3;
          9: nWhere := 4;
        end;
        if nWhere >= 0 then begin
          if nWhere <= 4 then begin
            if (Item.StdMode in [15, 22, 26, 51, 52, 53, 54, 62, 63, 64]) then
            {if (StdItem in [19, 20, 21, 23, 24]) and ((nWhere in [0..1]) or (nWhere in [7..8])) then begin

            end else }
              UserItem.btValue[nWhere] := GetNewValue(UserItem.btValue[nWhere], Value, btMethod);
          end else begin
            UserItem.AddValue[nWhere] := GetNewValue(UserItem.AddValue[nWhere], Value, btMethod);
          end;
        end;
        {UserItem.AddValue[7] := GetNewValue(UserItem.AddValue[7], LoWord(StdItem.AC), btMethod);
        UserItem.AddValue[8] := GetNewValue(UserItem.AddValue[8], LoWord(StdItem.MAC), btMethod);
        UserItem.AddValue[9] := GetNewValue(UserItem.AddValue[9], LoWord(StdItem.DC), btMethod);
        UserItem.AddValue[10] := GetNewValue(UserItem.AddValue[10], LoWord(StdItem.MC), btMethod);
        UserItem.AddValue[11] := GetNewValue(UserItem.AddValue[11], LoWord(StdItem.SC), btMethod);

        UserItem.btValue[0] := GetNewValue(UserItem.btValue[0], HiWord(StdItem.AC), btMethod);
        UserItem.btValue[1] := GetNewValue(UserItem.btValue[1], HiWord(StdItem.MAC), btMethod);
        UserItem.btValue[2] := GetNewValue(UserItem.btValue[2], HiWord(StdItem.DC), btMethod);
        UserItem.btValue[3] := GetNewValue(UserItem.btValue[3], HiWord(StdItem.MC), btMethod);
        UserItem.btValue[4] := GetNewValue(UserItem.btValue[4], HiWord(StdItem.SC), btMethod);}
      end;
  end;
end;
*)

function TItemUnit._GetItemAddValue(UserItem: pTUserItem; btType: Byte): Integer;
var
  I: Integer;
  btATOM_DC, btATOM_MC, btATOM_MAC: Byte;
begin
  btATOM_DC := 0;
  btATOM_MC := 0;
  btATOM_MAC := 0;
  for I := 1 to 3 do begin
    if UserItem.AddValue[I] = btType then begin
      case I of
        1: btATOM_DC := btATOM_DC + UserItem.AddValue[I + 3];
        2: btATOM_MC := btATOM_MC + UserItem.AddValue[I + 3];
        3: btATOM_MAC := btATOM_MAC + UserItem.AddValue[I + 3];
      end;
    end;
  end;
  Result := MakeLong(MakeWord(btATOM_DC, btATOM_MC), btATOM_MAC);
end;

procedure TItemUnit._RandomItemLimitDay(UserItem: pTUserItem; btItemType: Byte; nRate: Integer);
var
  nC: Integer;
  nItemNotLimit: Integer;
  nItemMaxLimitDay: Integer;
  nItemLimitDayRate: Integer;
begin
  case btItemType of
    0: begin
        nItemNotLimit := g_Config.nDressNotLimitRate;
        nItemMaxLimitDay := g_Config.nDressMaxLimitDay;
        nItemLimitDayRate := g_Config.nDressLimitDayRate;
      end;
    1: begin
        nItemNotLimit := g_Config.nWeaponNotLimitRate;
        nItemMaxLimitDay := g_Config.nWeaponMaxLimitDay;
        nItemLimitDayRate := g_Config.nWeaponLimitDayRate;
      end;
    2: begin
        nItemNotLimit := g_Config.nOtherNotLimitRate;
        nItemMaxLimitDay := g_Config.nOtherMaxLimitDay;
        nItemLimitDayRate := g_Config.nOtherLimitDayRate;
      end;
    3: begin
        nItemNotLimit := g_Config.nNeckLaceNotLimitRate;
        nItemMaxLimitDay := g_Config.nNeckLaceMaxLimitDay;
        nItemLimitDayRate := g_Config.nNeckLaceLimitDayRate;
      end;
    4, 7, 8, 9, 10: begin
        nItemNotLimit := g_Config.nHelMetNotLimitRate;
        nItemMaxLimitDay := g_Config.nHelMetMaxLimitDay;
        nItemLimitDayRate := g_Config.nHelMetLimitDayRate;
      end;
    5: begin
        nItemNotLimit := g_Config.nArmRingNotLimitRate;
        nItemMaxLimitDay := g_Config.nArmRingMaxLimitDay;
        nItemLimitDayRate := g_Config.nArmRingLimitDayRate;
      end;
    6: begin
        nItemNotLimit := g_Config.nRingNotLimitRate;
        nItemMaxLimitDay := g_Config.nRingMaxLimitDay;
        nItemLimitDayRate := g_Config.nRingLimitDayRate;
      end;
  end;

  if (Random(nItemNotLimit) <> 0) and (Random(nRate) <> 0) then begin //限制使用天数
    UserItem.AddValue[0] := 1;
    nC := _MAX(GetRandomRange(nItemMaxLimitDay {10}, nItemLimitDayRate {15}), 1);
    UserItem.MaxDate := nC + Date + Time;
  end else begin
    UserItem.AddValue[0] := 0;
  end;
end;

procedure TItemUnit._RandomUpgradeWeapon(UserItem: pTUserItem);
var
  nC, n10, n14: Integer;
begin
//1攻击元素 2强元素 3弱元素
  for n14 := 1 to 3 do begin
    nC := GetRandomRange(g_Config.nWeaponNewAddValueMaxLimit {12}, g_Config.nWeaponNewAddValueRate {15});
    if nC > 0 then begin
      n10 := _MIN(Random(6) + 1, 6);
      if (n14 = 3) and (UserItem.AddValue[n14 - 1] > 0) and (UserItem.AddValue[n14 - 1] = n10) then begin
        while True do begin
          n10 := _MIN(Random(6) + 1, 6);
          if UserItem.AddValue[n14 - 1] <> n10 then Break;
        end;
      end;
      UserItem.AddValue[n14] := n10;
      UserItem.AddValue[n14 + 3] := nC;
    end;
  end;
end;

procedure TItemUnit._RandomUpgradeDress(UserItem: pTUserItem);
var
  nC, n10, n14: Integer;
begin
//1攻击元素 2强元素 3弱元素
  for n14 := 1 to 3 do begin
    if Random(g_Config.nDressNewAddRate {40}) = 0 then begin
      nC := GetRandomRange(g_Config.nDressNewAddValueMaxLimit {6}, g_Config.nDressNewAddValueRate {20});
      if nC > 0 then begin
        n10 := _MIN(Random(6) + 1, 6);
        if (n14 = 3) and (UserItem.AddValue[n14 - 1] > 0) and (UserItem.AddValue[n14 - 1] = n10) then begin
          while True do begin
            n10 := _MIN(Random(6) + 1, 6);
            if UserItem.AddValue[n14 - 1] <> n10 then Break;
          end;
        end;
        UserItem.AddValue[n14] := n10;
        UserItem.AddValue[n14 + 3] := nC;
      end;
    end;
  end;
end;

procedure TItemUnit._RandomUpgrade202124(UserItem: pTUserItem);
var
  nC, n10, n14: Integer;
begin
//1攻击元素 2强元素 3弱元素
  for n14 := 1 to 3 do begin
    if Random(g_Config.nNeckLace202124NewAddRate {40}) = 0 then begin
      nC := GetRandomRange(g_Config.nNeckLace202124NewAddValueMaxLimit {6}, g_Config.nNeckLace202124NewAddValueRate {20});
      if nC > 0 then begin
        n10 := _MIN(Random(6) + 1, 6);
        if (n14 = 3) and (UserItem.AddValue[n14 - 1] > 0) and (UserItem.AddValue[n14 - 1] = n10) then begin
          while True do begin
            n10 := _MIN(Random(6) + 1, 6);
            if UserItem.AddValue[n14 - 1] <> n10 then Break;
          end;
        end;
        UserItem.AddValue[n14] := n10;
        UserItem.AddValue[n14 + 3] := nC;
      end;
    end;
  end;
end;

procedure TItemUnit._RandomUpgrade26(UserItem: pTUserItem);
var
  nC, n10, n14: Integer;
begin
//1攻击元素 2强元素 3弱元素
  for n14 := 1 to 3 do begin
    if Random(g_Config.nArmRing26NewAddRate {40}) = 0 then begin
      nC := GetRandomRange(g_Config.nArmRing26NewAddValueMaxLimit {6}, g_Config.nArmRing26NewAddValueRate {20});
      if nC > 0 then begin
        n10 := _MIN(Random(6) + 1, 6);
        if (n14 = 3) and (UserItem.AddValue[n14 - 1] > 0) and (UserItem.AddValue[n14 - 1] = n10) then begin
          while True do begin
            n10 := _MIN(Random(6) + 1, 6);
            if UserItem.AddValue[n14 - 1] <> n10 then Break;
          end;
        end;
        UserItem.AddValue[n14] := n10;
        UserItem.AddValue[n14 + 3] := nC;
      end;
    end;
  end;
end;

procedure TItemUnit._RandomUpgrade19(UserItem: pTUserItem);
var
  nC, n10, n14: Integer;
begin
//1攻击元素 2强元素 3弱元素
  for n14 := 1 to 3 do begin
    if Random(g_Config.nNeckLace19NewAddRate {40}) = 0 then begin
      nC := GetRandomRange(g_Config.nNeckLace19NewAddValueMaxLimit {6}, g_Config.nNeckLace19NewAddValueRate {20});
      if nC > 0 then begin
        n10 := _MIN(Random(6) + 1, 6);
        if (n14 = 3) and (UserItem.AddValue[n14 - 1] > 0) and (UserItem.AddValue[n14 - 1] = n10) then begin
          while True do begin
            n10 := _MIN(Random(6) + 1, 6);
            if UserItem.AddValue[n14 - 1] <> n10 then Break;
          end;
        end;
        UserItem.AddValue[n14] := n10;
        UserItem.AddValue[n14 + 3] := nC;
      end;
    end;
  end;
end;

procedure TItemUnit._RandomUpgrade22(UserItem: pTUserItem);
var
  nC, n10, n14: Integer;
begin
//1攻击元素 2强元素 3弱元素
  for n14 := 1 to 3 do begin
    if Random(g_Config.nRing22NewAddRate {40}) = 0 then begin
      nC := GetRandomRange(g_Config.nRing22NewAddValueMaxLimit {6}, g_Config.nRing22NewAddValueRate {20});
      if nC > 0 then begin
        n10 := _MIN(Random(6) + 1, 6);
        if (n14 = 3) and (UserItem.AddValue[n14 - 1] > 0) and (UserItem.AddValue[n14 - 1] = n10) then begin
          while True do begin
            n10 := _MIN(Random(6) + 1, 6);
            if UserItem.AddValue[n14 - 1] <> n10 then Break;
          end;
        end;
        UserItem.AddValue[n14] := n10;
        UserItem.AddValue[n14 + 3] := nC;
      end;
    end;
  end;
end;

procedure TItemUnit._RandomUpgrade23(UserItem: pTUserItem);
var
  nC, n10, n14: Integer;
begin
//1攻击元素 2强元素 3弱元素
  for n14 := 1 to 3 do begin
    if Random(g_Config.nRing23NewAddRate {40}) = 0 then begin
      nC := GetRandomRange(g_Config.nRing23NewAddValueMaxLimit {6}, g_Config.nRing23NewAddValueRate {20});
      if nC > 0 then begin
        n10 := _MIN(Random(6) + 1, 6);
        if (n14 = 3) and (UserItem.AddValue[n14 - 1] > 0) and (UserItem.AddValue[n14 - 1] = n10) then begin
          while True do begin
            n10 := _MIN(Random(6) + 1, 6);
            if UserItem.AddValue[n14 - 1] <> n10 then Break;
          end;
        end;
        UserItem.AddValue[n14] := n10;
        UserItem.AddValue[n14 + 3] := nC;
      end;
    end;
  end;
end;

procedure TItemUnit._RandomUpgradeHelMet(UserItem: pTUserItem);
var
  nC, n10, n14: Integer;
begin
//1攻击元素 2强元素 3弱元素
  for n14 := 1 to 3 do begin
    if Random(g_Config.nHelMetNewAddRate {40}) = 0 then begin
      nC := GetRandomRange(g_Config.nHelMetNewAddValueMaxLimit {6}, g_Config.nHelMetNewAddValueRate {20});
      if nC > 0 then begin
        n10 := _MIN(Random(6) + 1, 6);
        if (n14 = 3) and (UserItem.AddValue[n14 - 1] > 0) and (UserItem.AddValue[n14 - 1] = n10) then begin
          while True do begin
            n10 := _MIN(Random(6) + 1, 6);
            if UserItem.AddValue[n14 - 1] <> n10 then Break;
          end;
        end;
        UserItem.AddValue[n14] := n10;
        UserItem.AddValue[n14 + 3] := nC;
      end;
    end;
  end;
end;

procedure TItemUnit._UnknowHelmet(UserItem: pTUserItem); //神秘头盔
var
  nC, n10, n14: Integer;
begin
//1攻击元素 2强元素 3弱元素
  for n14 := 1 to 3 do begin
    if Random(g_Config.nUnknowHelMetNewAddRate {40}) = 0 then begin
      nC := GetRandomRange(g_Config.nUnknowHelMetNewAddValueMaxLimit {6}, g_Config.nUnknowHelMetNewAddRate {20});
      if nC > 0 then begin
        n10 := _MIN(Random(6) + 1, 6);
        if (n14 = 3) and (UserItem.AddValue[n14 - 1] > 0) and (UserItem.AddValue[n14 - 1] = n10) then begin
          while True do begin
            n10 := _MIN(Random(6) + 1, 6);
            if UserItem.AddValue[n14 - 1] <> n10 then Break;
          end;
        end;
        UserItem.AddValue[n14] := n10;
        UserItem.AddValue[n14 + 3] := nC;
      end;
    end;
  end;
end;

procedure TItemUnit._UnknowRing(UserItem: pTUserItem); //神秘戒指
var
  nC, n10, n14: Integer;
begin
//1攻击元素 2强元素 3弱元素
  for n14 := 1 to 3 do begin
    if Random(g_Config.nUnknowRingNewAddRate {40}) = 0 then begin
      nC := GetRandomRange(g_Config.nUnknowRingNewAddValueMaxLimit {6}, g_Config.nUnknowRingNewAddRate {20});
      if nC > 0 then begin
        n10 := _MIN(Random(6) + 1, 6);
        if (n14 = 3) and (UserItem.AddValue[n14 - 1] > 0) and (UserItem.AddValue[n14 - 1] = n10) then begin
          while True do begin
            n10 := _MIN(Random(6) + 1, 6);
            if UserItem.AddValue[n14 - 1] <> n10 then Break;
          end;
        end;
        UserItem.AddValue[n14] := n10;
        UserItem.AddValue[n14 + 3] := nC;
      end;
    end;
  end;
end;

procedure TItemUnit._UnknowNecklace(UserItem: pTUserItem); //神秘腰带
var
  nC, n10, n14: Integer;
begin
//1攻击元素 2强元素 3弱元素
  for n14 := 1 to 3 do begin
    if Random(g_Config.nUnknowNecklaceNewAddRate {40}) = 0 then begin
      nC := GetRandomRange(g_Config.nUnknowNecklaceNewAddValueMaxLimit {6}, g_Config.nUnknowNecklaceNewAddRate {20});
      if nC > 0 then begin
        n10 := _MIN(Random(6) + 1, 6);
        if (n14 = 3) and (UserItem.AddValue[n14 - 1] > 0) and (UserItem.AddValue[n14 - 1] = n10) then begin
          while True do begin
            n10 := _MIN(Random(6) + 1, 6);
            if UserItem.AddValue[n14 - 1] <> n10 then Break;
          end;
        end;
        UserItem.AddValue[n14] := n10;
        UserItem.AddValue[n14 + 3] := nC;
      end;
    end;
  end;
end;

procedure TItemUnit.GetItemAddValue(UserItem: pTUserItem; var StdItem: TStdItem);
begin
  case StdItem.StdMode of
    5, 6: begin
        StdItem.DC := MakeLong(LoWord(StdItem.DC) + UserItem.AddValue[7], HiWord(StdItem.DC) + UserItem.btValue[0]);
        StdItem.MC := MakeLong(LoWord(StdItem.MC) + UserItem.AddValue[8], HiWord(StdItem.MC) + UserItem.btValue[1]);
        StdItem.SC := MakeLong(LoWord(StdItem.SC) + UserItem.AddValue[9], HiWord(StdItem.SC) + UserItem.btValue[2]);

        StdItem.AC := MakeLong(LoWord(StdItem.AC) + UserItem.btValue[3], HiWord(StdItem.AC) + UserItem.btValue[5]);
        StdItem.MAC := MakeLong(LoWord(StdItem.MAC) + UserItem.btValue[4], HiWord(StdItem.MAC) + UserItem.btValue[6]);
        if Byte(UserItem.btValue[7] - 1) < 10 then begin //神圣
          StdItem.Source := UserItem.btValue[7];
        end;
        if UserItem.btValue[10] <> 0 then
          StdItem.Reserved := StdItem.Reserved or 1;
      end;
    10, 11: begin
        StdItem.AC := MakeLong(LoWord(StdItem.AC) + UserItem.AddValue[7], HiWord(StdItem.AC) + UserItem.btValue[0]);
        StdItem.MAC := MakeLong(LoWord(StdItem.MAC) + UserItem.AddValue[8], HiWord(StdItem.MAC) + UserItem.btValue[1]);
        StdItem.DC := MakeLong(LoWord(StdItem.DC) + UserItem.AddValue[9], HiWord(StdItem.DC) + UserItem.btValue[2]);
        StdItem.MC := MakeLong(LoWord(StdItem.MC) + UserItem.AddValue[10], HiWord(StdItem.MC) + UserItem.btValue[3]);
        StdItem.SC := MakeLong(LoWord(StdItem.SC) + UserItem.AddValue[11], HiWord(StdItem.SC) + UserItem.btValue[4]);
      end;
    15, 19, 20, 21, 22, 23, 24, 26, 51, 52, 53, 54, 62, 63, 64, 30: begin
        StdItem.AC := MakeLong(LoWord(StdItem.AC) + UserItem.AddValue[7], HiWord(StdItem.AC) + UserItem.btValue[0]);
        StdItem.MAC := MakeLong(LoWord(StdItem.MAC) + UserItem.AddValue[8], HiWord(StdItem.MAC) + UserItem.btValue[1]);
        StdItem.DC := MakeLong(LoWord(StdItem.DC) + UserItem.AddValue[9], HiWord(StdItem.DC) + UserItem.btValue[2]);
        StdItem.MC := MakeLong(LoWord(StdItem.MC) + UserItem.AddValue[10], HiWord(StdItem.MC) + UserItem.btValue[3]);
        StdItem.SC := MakeLong(LoWord(StdItem.SC) + UserItem.AddValue[11], HiWord(StdItem.SC) + UserItem.btValue[4]);
        if UserItem.btValue[5] > 0 then begin
          StdItem.Need := UserItem.btValue[5];
        end;
        if UserItem.btValue[6] > 0 then begin
          StdItem.NeedLevel := UserItem.btValue[6];
        end;
      end;
  end;

end;

function TItemUnit.GetCustomItemName(nMakeIndex,
  nItemIndex: Integer): string;
var
  I: Integer;
  ItemName: pTItemName;
begin
  Result := '';
  m_ItemNameList.Lock;
  try
    for I := 0 to m_ItemNameList.Count - 1 do begin
      ItemName := m_ItemNameList.Items[I];
      if (ItemName.nMakeIndex = nMakeIndex) and (ItemName.nItemIndex = nItemIndex) then begin
        Result := ItemName.sItemName;
        Break;
      end;
    end;
  finally
    m_ItemNameList.UnLock;
  end;
end;

function TItemUnit.AddCustomItemName(nMakeIndex, nItemIndex: Integer;
  sItemName: string): Boolean;
var
  I: Integer;
  boFind: Boolean;
  ItemName: pTItemName;
begin
  Result := False;
  boFind := False;
  m_ItemNameList.Lock;
  try
    for I := 0 to m_ItemNameList.Count - 1 do begin
      ItemName := m_ItemNameList.Items[I];
      if (ItemName.nMakeIndex = nMakeIndex) and (ItemName.nItemIndex = nItemIndex) then begin
        boFind := True;
        Break;
      end;
    end;
    if not boFind then begin
      New(ItemName);
      ItemName.nMakeIndex := nMakeIndex;
      ItemName.nItemIndex := nItemIndex;
      ItemName.sItemName := sItemName;
      m_ItemNameList.Add(ItemName);
      Result := True;
    end;
  finally
    m_ItemNameList.UnLock;
  end;
end;

function TItemUnit.DelCustomItemName(nMakeIndex, nItemIndex: Integer): Boolean;
var
  I: Integer;
  ItemName: pTItemName;
begin
  Result := False;
  m_ItemNameList.Lock;
  try
    for I := 0 to m_ItemNameList.Count - 1 do begin
      ItemName := m_ItemNameList.Items[I];
      if (ItemName.nMakeIndex = nMakeIndex) and (ItemName.nItemIndex = nItemIndex) then begin
        Dispose(ItemName);
        m_ItemNameList.Delete(I);
        Result := True;
        Exit;
      end;
    end;
  finally
    m_ItemNameList.UnLock;
  end;
end;

function TItemUnit.LoadCustomItemName: Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sFileName: string;
  sLineText: string;
  sMakeIndex: string;
  sItemIndex: string;
  nMakeIndex: Integer;
  nItemIndex: Integer;
  sItemName: string;
  ItemName: pTItemName;
begin
  Result := False;
  sFileName := g_Config.sEnvirDir + 'ItemNameList.txt';
  LoadList := TStringList.Create;
  if FileExists(sFileName) then begin
    m_ItemNameList.Lock;
    try
      m_ItemNameList.Clear;
      LoadList.LoadFromFile(sFileName);
      for I := 0 to LoadList.Count - 1 do begin
        sLineText := Trim(LoadList.Strings[I]);
        sLineText := GetValidStr3(sLineText, sMakeIndex, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sItemIndex, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sItemName, [' ', #9]);
        nMakeIndex := Str_ToInt(sMakeIndex, -1);
        nItemIndex := Str_ToInt(sItemIndex, -1);
        if (nMakeIndex >= 0) and (nItemIndex >= 0) then begin
          New(ItemName);
          ItemName.nMakeIndex := nMakeIndex;
          ItemName.nItemIndex := nItemIndex;
          ItemName.sItemName := sItemName;
          m_ItemNameList.Add(ItemName);
        end;
      end;
      Result := True;
    finally
      m_ItemNameList.UnLock;
    end;
  end else begin
    LoadList.SaveToFile(sFileName);
  end;
  LoadList.Free;
end;

function TItemUnit.SaveCustomItemName: Boolean;
var
  I: Integer;
  SaveList: TStringList;
  sFileName: string;
  ItemName: pTItemName;
begin
  sFileName := g_Config.sEnvirDir + 'ItemNameList.txt';
  SaveList := TStringList.Create;
  m_ItemNameList.Lock;
  try
    for I := 0 to m_ItemNameList.Count - 1 do begin
      ItemName := m_ItemNameList.Items[I];
      SaveList.Add(IntToStr(ItemName.nMakeIndex) + #9 + IntToStr(ItemName.nItemIndex) + #9 + ItemName.sItemName);
    end;
  finally
    m_ItemNameList.UnLock;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Result := True;
end;

procedure TItemUnit.Lock;
begin
  m_ItemNameList.Lock;
end;

procedure TItemUnit.UnLock;
begin
  m_ItemNameList.UnLock;
end;

end.

