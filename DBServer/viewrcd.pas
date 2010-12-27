unit viewrcd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, TabNotBk, Grids, ExtCtrls, Buttons,
  ComCtrls, HumDB, Grobal2, DBShare, HUtil32;
type
  TFrmFDBViewer = class(TForm)
    TabbedNotebook1: TTabbedNotebook;
    HumanGrid: TStringGrid;
    UseMagicGrid: TStringGrid;
    BagItemGrid: TStringGrid;
    SaveItemGrid: TStringGrid;
    UserItemGrid: TStringGrid;
    procedure FormCreate(Sender: TObject);
  private
    procedure sub_49A0C0();
    procedure sub_49A9DC();
    procedure sub_49AA84();
    procedure sub_49AB10();
    procedure InitUserItemGrid;
    procedure ShowUserItem(nIndex: Integer; sName: string; Item: TUserItem);
    procedure ShowBagItem(nIndex: Integer; sName: string; Item: TUserItem);
    procedure ShowUserItems();
    procedure ShowBagItems();
    procedure ShowUseMagic();
    procedure ShowSaveItem();
    procedure ShowHumanInfo();
    { Private declarations }
  public
    n2F8: Integer;
    s2FC: string;
    ChrRecord: THumDataInfo;
    procedure ShowHumData();
    { Public declarations }
  end;

var
  FrmFDBViewer: TFrmFDBViewer;

implementation
{$R *.DFM}

procedure TFrmFDBViewer.FormCreate(Sender: TObject);
begin
  sub_49A0C0();
  sub_49A9DC();
  sub_49AA84();
  sub_49AB10();
  InitUserItemGrid;
end;

procedure TFrmFDBViewer.ShowHumData();
begin
  if HumanGrid.Visible then ShowHumanInfo();
  if UserItemGrid.Visible then ShowUserItems();
  if BagItemGrid.Visible then ShowBagItems();
  if UseMagicGrid.Visible then ShowUseMagic();
  if SaveItemGrid.Visible then ShowSaveItem();
  TabbedNotebook1.PageIndex := 0;
end;

procedure TFrmFDBViewer.sub_49A0C0();
begin
  HumanGrid.Cells[0, 1] := '索引号';
  HumanGrid.Cells[1, 1] := '名称';
  HumanGrid.Cells[2, 1] := '地图';
  HumanGrid.Cells[3, 1] := 'CX';
  HumanGrid.Cells[4, 1] := 'CY';
  HumanGrid.Cells[5, 1] := '方向';
  HumanGrid.Cells[6, 1] := '职业';
  HumanGrid.Cells[7, 1] := '性别';
  HumanGrid.Cells[8, 1] := '头发';
  HumanGrid.Cells[9, 1] := '金币数';
  HumanGrid.Cells[10, 1] := '别名';
  HumanGrid.Cells[11, 1] := 'Home';

  HumanGrid.Cells[0, 3] := 'HomeX';
  HumanGrid.Cells[1, 3] := 'HomeY';
  HumanGrid.Cells[2, 3] := '等级';
  HumanGrid.Cells[3, 3] := 'AC';
  HumanGrid.Cells[4, 3] := 'MAC';
  HumanGrid.Cells[5, 3] := 'Reserved1';
  HumanGrid.Cells[6, 3] := 'DC/1';
  HumanGrid.Cells[7, 3] := 'DC/2';
  HumanGrid.Cells[8, 3] := 'MC/1';
  HumanGrid.Cells[9, 3] := 'MC/2';
  HumanGrid.Cells[10, 3] := 'SC/1';
  HumanGrid.Cells[11, 3] := 'SC/2';

  HumanGrid.Cells[0, 5] := 'Reserved2';
  HumanGrid.Cells[1, 5] := 'HP';
  HumanGrid.Cells[2, 5] := 'MaxHP';
  HumanGrid.Cells[3, 5] := 'MP';
  HumanGrid.Cells[4, 5] := 'MaxMP';
  HumanGrid.Cells[5, 5] := 'Reserved2';
  HumanGrid.Cells[6, 5] := '当前经验';
  HumanGrid.Cells[7, 5] := '升级经验';
  HumanGrid.Cells[8, 5] := 'PK点数';
  HumanGrid.Cells[9, 5] := '';
  HumanGrid.Cells[10, 5] := '登录帐号';
  HumanGrid.Cells[11, 5] := '最后登录时间';

  HumanGrid.Cells[0, 7] := '配偶';
  HumanGrid.Cells[1, 7] := '师徒';
  HumanGrid.Cells[2, 7] := '仓库密码';
  HumanGrid.Cells[3, 7] := '声望点';
  HumanGrid.Cells[4, 7] := '是否是英雄';
  HumanGrid.Cells[5, 7] := '';
  HumanGrid.Cells[6, 7] := '';
  HumanGrid.Cells[7, 7] := '';
  HumanGrid.Cells[8, 7] := '';
  HumanGrid.Cells[9, 7] := '';
  HumanGrid.Cells[10, 7] := '';
  HumanGrid.Cells[11, 7] := '';
end;

procedure TFrmFDBViewer.InitUserItemGrid;
begin
  UserItemGrid.Cells[0, 0] := '物品位置';
  UserItemGrid.Cells[1, 0] := '物品ID';
  UserItemGrid.Cells[2, 0] := '物品号';
  UserItemGrid.Cells[3, 0] := '持久';
  UserItemGrid.Cells[4, 0] := '物品名称';

  UserItemGrid.Cells[0, 1] := '衣服';
  UserItemGrid.Cells[0, 2] := '武器';
  UserItemGrid.Cells[0, 3] := '照明物';
  UserItemGrid.Cells[0, 4] := '项链';
  UserItemGrid.Cells[0, 5] := '头盔';
  UserItemGrid.Cells[0, 6] := '左手镯';
  UserItemGrid.Cells[0, 7] := '右手镯';
  UserItemGrid.Cells[0, 8] := '左戒指';
  UserItemGrid.Cells[0, 9] := '右戒指';
  UserItemGrid.Cells[0, 10] := '物品';
  UserItemGrid.Cells[0, 11] := '腰带';
  UserItemGrid.Cells[0, 12] := '鞋子';
  UserItemGrid.Cells[0, 13] := '宝石';
end;

procedure TFrmFDBViewer.sub_49A9DC();
begin
  BagItemGrid.Cells[0, 0] := '物品号';
  BagItemGrid.Cells[1, 0] := '物品ID';
  BagItemGrid.Cells[2, 0] := '物品号';
  BagItemGrid.Cells[3, 0] := '持久';
  BagItemGrid.Cells[4, 0] := '物品名称';
end;

procedure TFrmFDBViewer.sub_49AA84();
begin
  SaveItemGrid.Cells[0, 0] := '序号';
  SaveItemGrid.Cells[1, 0] := '物品系列号';
  SaveItemGrid.Cells[2, 0] := '物品号';
  SaveItemGrid.Cells[3, 0] := '持久';
  SaveItemGrid.Cells[4, 0] := '物品名称';
end;

procedure TFrmFDBViewer.sub_49AB10();
begin
  UseMagicGrid.Cells[0, 0] := '技能ID';
  UseMagicGrid.Cells[1, 0] := '快捷键';
  UseMagicGrid.Cells[2, 0] := '修练状态';
  UseMagicGrid.Cells[3, 0] := '技能名称';
end;

procedure TFrmFDBViewer.ShowBagItem(nIndex: Integer; sName: string; Item: TUserItem);
begin
  if Item.wIndex > 0 then begin
    BagItemGrid.Cells[0, nIndex] := sName;
    BagItemGrid.Cells[1, nIndex] := IntToStr(Item.MakeIndex);
    BagItemGrid.Cells[2, nIndex] := IntToStr(Item.wIndex);
    BagItemGrid.Cells[3, nIndex] := IntToStr(Item.Dura) + '/' + IntToStr(Item.DuraMax);
    BagItemGrid.Cells[4, nIndex] := GetStdItemName(Item.wIndex);
  end else begin
    BagItemGrid.Cells[0, nIndex] := sName;
    BagItemGrid.Cells[1, nIndex] := '';
    BagItemGrid.Cells[2, nIndex] := '';
    BagItemGrid.Cells[3, nIndex] := '';
    BagItemGrid.Cells[4, nIndex] := '';
  end;
end;

procedure TFrmFDBViewer.ShowUserItem(nIndex: Integer; sName: string; Item: TUserItem);
begin
  if Item.wIndex > 0 then begin
    UserItemGrid.Cells[1, nIndex] := IntToStr(Item.MakeIndex);
    UserItemGrid.Cells[2, nIndex] := IntToStr(Item.wIndex);
    UserItemGrid.Cells[3, nIndex] := IntToStr(Item.Dura) + '/' + IntToStr(Item.DuraMax);
    UserItemGrid.Cells[4, nIndex] := GetStdItemName(Item.wIndex);
  end else begin
    UserItemGrid.Cells[1, nIndex] := '';
    UserItemGrid.Cells[2, nIndex] := '';
    UserItemGrid.Cells[3, nIndex] := '';
    UserItemGrid.Cells[4, nIndex] := '';
  end;
end;

procedure TFrmFDBViewer.ShowHumanInfo();
var
  HumData: pTHumData;
begin
  HumData := @ChrRecord.Data;
  HumanGrid.Cells[0, 2] := IntToStr(n2F8);
  HumanGrid.Cells[1, 2] := HumData.sChrName;
  HumanGrid.Cells[2, 2] := HumData.sCurMap;
  HumanGrid.Cells[3, 2] := IntToStr(HumData.wCurX);
  HumanGrid.Cells[4, 2] := IntToStr(HumData.wCurY);
  HumanGrid.Cells[5, 2] := IntToStr(HumData.btDir);
  HumanGrid.Cells[6, 2] := IntToStr(HumData.btJob);
  HumanGrid.Cells[7, 2] := IntToStr(HumData.btSex);
  HumanGrid.Cells[8, 2] := IntToStr(HumData.btHair);
  HumanGrid.Cells[9, 2] := IntToStr(HumData.nGold);
  HumanGrid.Cells[10, 2] := HumData.sDearName;
  HumanGrid.Cells[11, 2] := HumData.sHomeMap;

  HumanGrid.Cells[0, 4] := IntToStr(HumData.wHomeX);
  HumanGrid.Cells[1, 4] := IntToStr(HumData.wHomeY);
  HumanGrid.Cells[2, 4] := IntToStr(HumData.Abil.Level);
  HumanGrid.Cells[3, 4] := IntToStr(HumData.Abil.AC);
  HumanGrid.Cells[4, 4] := IntToStr(HumData.Abil.MAC);
  //  HumanGrid.Cells[5,4]:=IntToStr(HumData.Abil.bt49);
  HumanGrid.Cells[6, 4] := IntToStr(LoByte(HumData.Abil.DC));
  HumanGrid.Cells[7, 4] := IntToStr(HiByte(HumData.Abil.DC));
  HumanGrid.Cells[8, 4] := IntToStr(LoByte(HumData.Abil.MC));
  HumanGrid.Cells[9, 4] := IntToStr(HiByte(HumData.Abil.MC));
  HumanGrid.Cells[10, 4] := IntToStr(LoByte(HumData.Abil.SC));
  HumanGrid.Cells[11, 4] := IntToStr(HiByte(HumData.Abil.SC));
  //  HumanGrid.Cells[0,6]:=IntToStr(HumData.Abil.bt48);
  HumanGrid.Cells[1, 6] := IntToStr(HumData.Abil.HP);
  HumanGrid.Cells[2, 6] := IntToStr(HumData.Abil.HP);
  HumanGrid.Cells[3, 6] := IntToStr(HumData.Abil.MaxMP);
  HumanGrid.Cells[4, 6] := IntToStr(HumData.Abil.MaxMP);
  //  HumanGrid.Cells[5,6]:=IntToStr(HumData.Abil.bt48);
  HumanGrid.Cells[6, 6] := IntToStr(HumData.Abil.Exp);
  HumanGrid.Cells[7, 6] := IntToStr(HumData.Abil.MaxExp);
  HumanGrid.Cells[8, 6] := IntToStr(HumData.nPKPoint);
  HumanGrid.Cells[9, 6] := '';
  HumanGrid.Cells[10, 6] := HumData.sAccount;
  HumanGrid.Cells[11, 6] := DateTimeToStr(ChrRecord.Header.dCreateDate);
  HumanGrid.Cells[0, 8] := HumData.sDearName;
  HumanGrid.Cells[1, 8] := HumData.sMasterName;
  HumanGrid.Cells[2, 8] := HumData.sStoragePwd;
  HumanGrid.Cells[3, 8] := IntToStr(HumData.btCreditPoint);
  HumanGrid.Cells[4, 8] := BooleanToStr(HumData.boIsHero);
  if not HumData.boIsHero then begin
    HumanGrid.Cells[1, 7] := '师徒';
    HumanGrid.Cells[5, 7] := '是否有英雄';
    HumanGrid.Cells[6, 7] := '英雄名称';
    HumanGrid.Cells[5, 8] := BooleanToStr(HumData.boHasHero);
    HumanGrid.Cells[6, 8] := HumData.sHeroChrName;
  end else begin
    HumanGrid.Cells[1, 7] := '主人名称';
    HumanGrid.Cells[5, 7] := '';
    HumanGrid.Cells[6, 7] := '';
    HumanGrid.Cells[5, 8] := '';
    HumanGrid.Cells[6, 8] := '';
  end;
end;

procedure TFrmFDBViewer.ShowBagItems();
var
  I, II: Integer;
begin
  for I := 1 to BagItemGrid.RowCount - 1 do begin
    for II := 0 to BagItemGrid.ColCount - 1 do begin
      BagItemGrid.Cells[II, I] := '';
    end;
  end;
  for I := Low(ChrRecord.Data.BagItems) to High(ChrRecord.Data.BagItems) do begin
    ShowBagItem(I + 1, IntToStr(I + 1), ChrRecord.Data.BagItems[I]);
  end;
end;

procedure TFrmFDBViewer.ShowUserItems();
var
  I, II: Integer;
begin
  for I := 1 to UserItemGrid.RowCount - 1 do begin
    for II := 1 to UserItemGrid.ColCount - 1 do begin
      UserItemGrid.Cells[II, I] := '';
    end;
  end;
  ShowUserItem(1, '衣服', ChrRecord.Data.HumItems[0]);
  ShowUserItem(2, '武器', ChrRecord.Data.HumItems[1]);
  ShowUserItem(3, '照明物', ChrRecord.Data.HumItems[2]);
  ShowUserItem(4, '项链', ChrRecord.Data.HumItems[3]);
  ShowUserItem(5, '头盔', ChrRecord.Data.HumItems[4]);
  ShowUserItem(6, '左手镯', ChrRecord.Data.HumItems[5]);
  ShowUserItem(7, '右手镯', ChrRecord.Data.HumItems[6]);
  ShowUserItem(8, '左戒指', ChrRecord.Data.HumItems[7]);
  ShowUserItem(9, '右戒指', ChrRecord.Data.HumItems[8]);
  ShowUserItem(10, '物品', ChrRecord.Data.HumAddItems[9]);
  ShowUserItem(11, '腰带', ChrRecord.Data.HumAddItems[10]);
  ShowUserItem(12, '鞋子', ChrRecord.Data.HumAddItems[11]);
  ShowUserItem(13, '宝石', ChrRecord.Data.HumAddItems[12]);
end;

procedure TFrmFDBViewer.ShowUseMagic();
var
  I, ii: Integer;
begin
  for I := 1 to UseMagicGrid.RowCount - 1 do begin
    for ii := 0 to UseMagicGrid.ColCount - 1 do begin
      UseMagicGrid.Cells[ii, I] := '';
    end;
  end;
  for I := Low(ChrRecord.Data.HumMagics) to High(ChrRecord.Data.HumMagics) do begin
    if ChrRecord.Data.HumMagics[I].wMagIdx <= 0 then Break;
    UseMagicGrid.Cells[0, I + 1] := IntToStr(ChrRecord.Data.HumMagics[I].wMagIdx);
    UseMagicGrid.Cells[1, I + 1] := IntToStr(ChrRecord.Data.HumMagics[I].btKey);
    UseMagicGrid.Cells[2, I + 1] := IntToStr(ChrRecord.Data.HumMagics[I].nTranPoint);
    UseMagicGrid.Cells[3, I + 1] := GetMagicName(ChrRecord.Data.HumMagics[I].wMagIdx);
  end;
end;

procedure TFrmFDBViewer.ShowSaveItem();
var
  I, ii: Integer;
  nCount: Integer;
begin
  for I := 1 to SaveItemGrid.RowCount - 1 do begin
    for ii := 0 to SaveItemGrid.ColCount - 1 do begin
      SaveItemGrid.Cells[ii, I] := '';
    end;
  end;
  nCount := 0;
  for I := Low(ChrRecord.Data.StorageItems) to High(ChrRecord.Data.StorageItems) do begin
    if ChrRecord.Data.StorageItems[I].wIndex <= 0 then Continue;
    SaveItemGrid.Cells[0, I + 1] := IntToStr(nCount);
    SaveItemGrid.Cells[1, I + 1] := IntToStr(ChrRecord.Data.StorageItems[I].MakeIndex);
    SaveItemGrid.Cells[2, I + 1] := IntToStr(ChrRecord.Data.StorageItems[I].wIndex);
    SaveItemGrid.Cells[3, I + 1] := IntToStr(ChrRecord.Data.StorageItems[I].Dura) + '/' +
      IntToStr(ChrRecord.Data.StorageItems[I].DuraMax);
    SaveItemGrid.Cells[4, I + 1] := GetStdItemName(ChrRecord.Data.StorageItems[I].wIndex);
    Inc(nCount);
  end;
end;

end.
