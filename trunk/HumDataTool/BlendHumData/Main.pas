unit Main;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, RzSpnEdt, IniFiles,
  RzBtnEdt, RzLabel, RzPanel, ExtCtrls, RzButton, RzRadChk, RzStatus,
  ShlObj, ActiveX, HUtil32, Grobal, HumDB, IDDB, Share, MemoryIniFiles;
{$DEFINE HEROVERSION}
type
  TBlendThread = class(TThread) //合并线程

  private
    function _Copy(sSrc: string; nLen: Integer): string;
    procedure LoadIDDBList();
    procedure LoadHumDBList();
    procedure LoadMirDBList();
    procedure LoadGuildBaseList();
    procedure LoadBigStorageList();
    procedure LoadSellOffSellList();
    procedure LoadSellOffGoldList();

    procedure LoadDuelInfoList();
    procedure LoadDuelItemList();

    procedure LoadDynamicVarList();
    procedure LoadCharNameList();

    procedure UpdataAccount(sAccount, sNewAccount: string);
    procedure UpdataCharName(sCharName, sNewCharName: string);
    procedure UpdataDynamicVarCharName(sCharName, sNewCharName: string);
    procedure UpdataCharNameList(sCharName, sNewCharName: string);
    procedure _UpdataAccount(sAccount, sNewAccount: string);
    procedure _UpdataCharName(sCharName, sNewCharName: string);
    procedure _UpdataDynamicVarCharName(sCharName, sNewCharName: string);
    procedure _UpdataCharNameList(sCharName, sNewCharName: string);
    procedure UpdataItemNumber();
    procedure BlendIDDBList();
    procedure BlendHumDBList();
    procedure BlendMirDBList();
    procedure BlendGuildBaseList();
    procedure BlendBigStorageList();
    procedure BlendSellOffSellList();
    procedure BlendSellOffGoldList();




    procedure SaveIDDBList();
    procedure SaveHumDBList();
    procedure SaveMirDBList();
    procedure SaveGuildBaseList();
    procedure SaveBigStorageList();
    procedure SaveSellOffSellList();
    procedure SaveSellOffGoldList();

    procedure SaveDuelInfoList();
    procedure SaveDuelItemList();

    procedure SaveDynamicVarList();
    procedure SaveCharNameList();

    function LoadItemBindIPaddr(sFileName: string; List: TList): Boolean;
    function SaveItemBindIPaddr(sFileName: string; List: TList): Boolean;
    function LoadItemBindAccount(sFileName: string; List: TList): Boolean;
    function SaveItemBindAccount(sFileName: string; List: TList): Boolean;
    function LoadItemBindCharName(sFileName: string; List: TList): Boolean;
    function SaveItemBindCharName(sFileName: string; List: TList): Boolean;
    function LoadRememberItemList(sFileName: string; List: TQuickList): Boolean; //加载物品事件触发列表
    function SaveRememberItemList(sFileName: string; List: TQuickList): Boolean; //保存物品事件触发列表

    procedure SetItemBindMakeIdx(List: TList; nOldItemMakeIdx, nNewItemMakeIdx: Integer);
    procedure SetItemBindName(List: TList; sOldName, sNewName: string);
    procedure SetRememberItemList(List: TQuickList; nOldItemMakeIdx, nNewItemMakeIdx: Integer);

    procedure UpdateStatus;
  public
    m_FileIDDBA: TFileIDDB;
    m_FileIDDBB: TFileIDDB;

    m_FileHumDBA: TFileHumDB;
    m_FileHumDBB: TFileHumDB;

    m_FileDBA: TFileDB;
    m_FileDBB: TFileDB;

    m_SellOffA: TSellOff;
    m_SellOffB: TSellOff;

    m_SellGoldA: TSellOff;
    m_SellGoldB: TSellOff;

    m_StorageA: TStorage;
    m_StorageB: TStorage;

    m_GuildBaseA: TGuildBase;
    m_GuildBaseB: TGuildBase;

    m_DuelInfoDBA: TDuelInfoDB;
    m_DuelInfoDBB: TDuelInfoDB;

    m_DuelItemDBA: TDuelItemDB;
    m_DuelItemDBB: TDuelItemDB;


    m_ItemBindIPaddrA: TList;
    m_ItemBindIPaddrB: TList;

    m_ItemBindAccountA: TList;
    m_ItemBindAccountB: TList;

    m_ItemBindCharNameA: TList;
    m_ItemBindCharNameB: TList;

    m_RememberItemListA: TQuickList;
    m_RememberItemListB: TQuickList;


    m_DynamicVarListA: TStringList;
    m_DynamicVarListB: TStringList;

    m_CharNameListA: TStringList;
    m_CharNameListB: TStringList;
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
  protected
    procedure Execute; override;
  end;

  TfrmMain = class(TForm)
    StatusBar: TRzStatusBar;
    Panel: TRzPanel;
    RzPanel1: TRzPanel;
    CheckBoxClearHumLevel: TRzCheckBox;
    CheckBoxClearDeleteHum: TRzCheckBox;
    CheckBoxClearID1: TRzCheckBox;
    CheckBoxClearID2: TRzCheckBox;
    RzLabel11: TRzLabel;
    NumericEditDay: TRzNumericEdit;
    RzLabel12: TRzLabel;
    NumericEditLevel: TRzNumericEdit;
    RzLabel13: TRzLabel;
    RzLabel15: TRzLabel;
    NumericEditDay1: TRzNumericEdit;
    RzLabel16: TRzLabel;
    RzLabel19: TRzLabel;
    ButtonEditSaveDir: TRzButtonEdit;
    ProgressStatus: TRzProgressStatus;
    RzStatusPane: TRzStatusPane;
    OpenDialog: TOpenDialog;
    CheckBoxBigStorage: TRzCheckBox;
    CheckBoxSellOff: TRzCheckBox;
    CheckBoxCheckCopyItems: TRzCheckBox;
    CheckBoxSetItemMakeIndex: TRzCheckBox;
    LabelStatus: TRzLabel;
    CheckBoxClearNotDataHum: TRzCheckBox;
    Panel1: TPanel;
    LabelVersion: TRzLabel;
    RzURLLabel2: TRzURLLabel;
    BitBtnStart: TRzBitBtn;
    BitBtnLog: TRzBitBtn;
    BitBtnCLose: TRzBitBtn;
    RzCheckBoxItemBind: TRzCheckBox;
    RzCheckBoxDuel: TRzCheckBox;
    RzCheckBoxItemDblClick: TRzCheckBox;
    CheckBoxDeleteLowLevel: TCheckBox;
    ScrollBox: TScrollBox;
    RzGroupBox1: TRzGroupBox;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel20: TRzLabel;
    RzLabel21: TRzLabel;
    RzLabel24: TRzLabel;
    ButtonEditIDDB1: TRzButtonEdit;
    ButtonEditHumDB1: TRzButtonEdit;
    ButtonEditMirDB1: TRzButtonEdit;
    ButtonEditGuildBase1: TRzButtonEdit;
    ButtonEditBigStorage1: TRzButtonEdit;
    ButtonEditSellOffSell1: TRzButtonEdit;
    ButtonEditSellOffGold1: TRzButtonEdit;
    ButtonEditSetup1: TRzButtonEdit;
    RzGroupBox2: TRzGroupBox;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel22: TRzLabel;
    RzLabel23: TRzLabel;
    RzLabel25: TRzLabel;
    ButtonEditIDDB2: TRzButtonEdit;
    ButtonEditHumDB2: TRzButtonEdit;
    ButtonEditMirDB2: TRzButtonEdit;
    ButtonEditGuildBase2: TRzButtonEdit;
    ButtonEditBigStorage2: TRzButtonEdit;
    ButtonEditSellOffSell2: TRzButtonEdit;
    ButtonEditSellOffGold2: TRzButtonEdit;
    ButtonEditSetup2: TRzButtonEdit;
    RzGroupBox3: TRzGroupBox;
    RzLabel14: TRzLabel;
    RzLabel17: TRzLabel;
    RzLabel18: TRzLabel;
    EditBindAccountA: TRzButtonEdit;
    EditBindCharNameA: TRzButtonEdit;
    EditBindIPaddrA: TRzButtonEdit;
    RzGroupBox4: TRzGroupBox;
    RzLabel26: TRzLabel;
    RzLabel27: TRzLabel;
    RzLabel28: TRzLabel;
    EditBindAccountB: TRzButtonEdit;
    EditBindCharNameB: TRzButtonEdit;
    EditBindIPaddrB: TRzButtonEdit;
    RzGroupBox6: TRzGroupBox;
    RzLabel30: TRzLabel;
    EditRememberItemListB: TRzButtonEdit;
    RzGroupBox5: TRzGroupBox;
    RzLabel29: TRzLabel;
    EditRememberItemListA: TRzButtonEdit;
    RzGroupBox7: TRzGroupBox;
    RzLabel31: TRzLabel;
    RzLabel33: TRzLabel;
    EditDuelInfoA: TRzButtonEdit;
    EditDuelItemA: TRzButtonEdit;
    RzGroupBox8: TRzGroupBox;
    RzLabel32: TRzLabel;
    RzLabel34: TRzLabel;
    EditDuelInfoB: TRzButtonEdit;
    EditDuelItemB: TRzButtonEdit;
    RzGroupBox9: TRzGroupBox;
    RzGroupBox10: TRzGroupBox;
    ListBoxDynamicVarA: TListBox;
    EditDynamicVarA: TRzButtonEdit;
    RzGroupBox11: TRzGroupBox;
    ListBoxDynamicVarB: TListBox;
    EditDynamicVarB: TRzButtonEdit;
    ButtonDynamicVarAdd: TButton;
    ButtonDynamicVarDel: TButton;
    RzGroupBox12: TRzGroupBox;
    RzGroupBox13: TRzGroupBox;
    ListBoxCharNameA: TListBox;
    EditCharNameA: TRzButtonEdit;
    RzGroupBox14: TRzGroupBox;
    ListBoxCharNameB: TListBox;
    EditCharNameB: TRzButtonEdit;
    ButtonCharNameAdd: TButton;
    ButtonCharNameDel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtnCLoseClick(Sender: TObject);
    procedure BitBtnLogClick(Sender: TObject);
    procedure ButtonEditIDDB1ButtonClick(Sender: TObject);
    procedure ButtonEditHumDB1ButtonClick(Sender: TObject);
    procedure ButtonEditMirDB1ButtonClick(Sender: TObject);
    procedure ButtonEditIDDB2ButtonClick(Sender: TObject);
    procedure ButtonEditHumDB2ButtonClick(Sender: TObject);
    procedure ButtonEditMirDB2ButtonClick(Sender: TObject);
    procedure ButtonEditGuildBase1ButtonClick(Sender: TObject);
    procedure ButtonEditGuildBase2ButtonClick(Sender: TObject);
    procedure ButtonEditBigStorage1ButtonClick(Sender: TObject);
    procedure ButtonEditBigStorage2ButtonClick(Sender: TObject);
    procedure ButtonEditSellOffSell1ButtonClick(Sender: TObject);
    procedure ButtonEditSellOffSell2ButtonClick(Sender: TObject);
    procedure ButtonEditSellOffGold1ButtonClick(Sender: TObject);
    procedure ButtonEditSellOffGold2ButtonClick(Sender: TObject);
    procedure ButtonEditSaveDirButtonClick(Sender: TObject);
    procedure CheckBoxClearHumLevelClick(Sender: TObject);
    procedure CheckBoxClearDeleteHumClick(Sender: TObject);
    procedure CheckBoxClearID1Click(Sender: TObject);
    procedure CheckBoxClearID2Click(Sender: TObject);
    procedure NumericEditDayChange(Sender: TObject);
    procedure NumericEditLevelChange(Sender: TObject);
    procedure NumericEditDay1Change(Sender: TObject);
    procedure BitBtnStartClick(Sender: TObject);
    procedure ButtonEditSetup1ButtonClick(Sender: TObject);
    procedure ButtonEditSetup2ButtonClick(Sender: TObject);
    procedure CheckBoxBigStorageClick(Sender: TObject);
    procedure CheckBoxSellOffClick(Sender: TObject);
    procedure CheckBoxCheckCopyItemsClick(Sender: TObject);
    procedure CheckBoxSetItemMakeIndexClick(Sender: TObject);
    procedure CheckBoxClearNotDataHumClick(Sender: TObject);
    procedure EditBindAccountAButtonClick(Sender: TObject);
    procedure EditBindAccountBButtonClick(Sender: TObject);
    procedure EditBindCharNameAButtonClick(Sender: TObject);
    procedure EditBindCharNameBButtonClick(Sender: TObject);
    procedure EditBindIPaddrAButtonClick(Sender: TObject);
    procedure EditBindIPaddrBButtonClick(Sender: TObject);
    procedure EditRememberItemListAButtonClick(Sender: TObject);
    procedure EditRememberItemListBButtonClick(Sender: TObject);
    procedure EditDuelInfoAButtonClick(Sender: TObject);
    procedure EditDuelInfoBButtonClick(Sender: TObject);
    procedure EditDuelItemAButtonClick(Sender: TObject);
    procedure EditDuelItemBButtonClick(Sender: TObject);
    procedure RzCheckBoxItemBindClick(Sender: TObject);
    procedure RzCheckBoxItemDblClickClick(Sender: TObject);
    procedure RzCheckBoxDuelClick(Sender: TObject);
    procedure CheckBoxDeleteLowLevelClick(Sender: TObject);
    procedure ButtonDynamicVarAddClick(Sender: TObject);
    procedure EditDynamicVarAButtonClick(Sender: TObject);
    procedure EditDynamicVarBButtonClick(Sender: TObject);
    procedure ButtonDynamicVarDelClick(Sender: TObject);
    procedure ListBoxDynamicVarAClick(Sender: TObject);
    procedure ListBoxDynamicVarBClick(Sender: TObject);
    procedure EditCharNameAButtonClick(Sender: TObject);
    procedure EditCharNameBButtonClick(Sender: TObject);
    procedure ButtonCharNameAddClick(Sender: TObject);
    procedure ButtonCharNameDelClick(Sender: TObject);
    procedure ListBoxCharNameAClick(Sender: TObject);
    procedure ListBoxCharNameBClick(Sender: TObject);
    procedure ListBoxDynamicVarBMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ListBoxDynamicVarAMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ListBoxCharNameAMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ListBoxCharNameBMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
//    function LoadSkinPlug(PlugName: string): Boolean;

  public
    { Public declarations }

  end;

procedure ProcessStatus();
procedure ProcessMessage(sMsg: string);
var
  frmMain: TfrmMain;
  BlendThread: TBlendThread;
  m_nPercent: Integer;
  m_nCount: Integer;
implementation
uses LogMain;
{var
  Plughandle: Thandle;
  boLoadOK: Boolean;
  GetSkin: function(nIndex: Integer; var Stream: TMemoryStream): Integer; stdcall;
  Init: procedure; stdcall;
  UnInit: procedure; stdcall;}
{$R *.dfm}

 {TBlendThread}

constructor TBlendThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  m_FileIDDBA := TFileIDDB.Create(g_sIDDB1);
  m_FileIDDBB := TFileIDDB.Create(g_sIDDB2);

  m_FileHumDBA := TFileHumDB.Create(g_sHumDB1);
  m_FileHumDBB := TFileHumDB.Create(g_sHumDB2);

  m_FileDBA := TFileDB.Create(g_sMirDB1);
  m_FileDBB := TFileDB.Create(g_sMirDB2);

  m_SellOffA := TSellOff.Create(g_sSellOffSell1);
  m_SellOffB := TSellOff.Create(g_sSellOffSell2);

  m_SellGoldA := TSellOff.Create(g_sSellOffGold1);
  m_SellGoldB := TSellOff.Create(g_sSellOffGold2);

  m_StorageA := TStorage.Create(g_sBigStorage1);
  m_StorageB := TStorage.Create(g_sBigStorage2);

  m_GuildBaseA := TGuildBase.Create(g_sGuildBase1);
  m_GuildBaseB := TGuildBase.Create(g_sGuildBase2);

  m_DuelInfoDBA := TDuelInfoDB.Create(g_sDuelInfo1);
  m_DuelInfoDBB := TDuelInfoDB.Create(g_sDuelInfo2);

  m_DuelItemDBA := TDuelItemDB.Create(g_sDuelItem1);
  m_DuelItemDBB := TDuelItemDB.Create(g_sDuelItem2);


  m_FileHumDBA.m_IDDBList := m_FileIDDBA.m_IDDBList;
  m_FileHumDBB.m_IDDBList := m_FileIDDBB.m_IDDBList;

  m_FileDBA.m_IDDBList := m_FileIDDBA.m_IDDBList;
  m_FileDBA.m_HumCharNameList := m_FileHumDBA.m_HumCharNameList;
  m_FileDBB.m_IDDBList := m_FileIDDBB.m_IDDBList;
  m_FileDBB.m_HumCharNameList := m_FileHumDBB.m_HumCharNameList;

  m_SellOffA.m_HumCharNameList := m_FileHumDBA.m_HumCharNameList;
  m_SellOffB.m_HumCharNameList := m_FileHumDBB.m_HumCharNameList;

  m_SellGoldA.m_HumCharNameList := m_FileHumDBA.m_HumCharNameList;
  m_SellGoldB.m_HumCharNameList := m_FileHumDBB.m_HumCharNameList;

  m_StorageA.m_HumCharNameList := m_FileHumDBA.m_HumCharNameList;
  m_StorageB.m_HumCharNameList := m_FileHumDBB.m_HumCharNameList;

  m_DuelInfoDBA.m_HumCharNameList := m_FileHumDBA.m_HumCharNameList;
  m_DuelInfoDBB.m_HumCharNameList := m_FileHumDBB.m_HumCharNameList;

  m_DuelItemDBA.m_HumCharNameList := m_FileHumDBA.m_HumCharNameList;
  m_DuelItemDBB.m_HumCharNameList := m_FileHumDBB.m_HumCharNameList;

  m_DuelInfoDBA.m_ProgressStatus := frmMain.ProgressStatus;
  m_DuelInfoDBA.m_RzStatusPane := frmMain.RzStatusPane;
  m_DuelInfoDBB.m_ProgressStatus := frmMain.ProgressStatus;
  m_DuelInfoDBB.m_RzStatusPane := frmMain.RzStatusPane;

  m_DuelItemDBA.m_ProgressStatus := frmMain.ProgressStatus;
  m_DuelItemDBA.m_RzStatusPane := frmMain.RzStatusPane;
  m_DuelItemDBB.m_ProgressStatus := frmMain.ProgressStatus;
  m_DuelItemDBB.m_RzStatusPane := frmMain.RzStatusPane;


  m_FileIDDBA.m_ProgressStatus := frmMain.ProgressStatus;
  m_FileIDDBA.m_RzStatusPane := frmMain.RzStatusPane;
  m_FileIDDBB.m_ProgressStatus := frmMain.ProgressStatus;
  m_FileIDDBB.m_RzStatusPane := frmMain.RzStatusPane;

  m_FileHumDBA.m_ProgressStatus := frmMain.ProgressStatus;
  m_FileHumDBA.m_RzStatusPane := frmMain.RzStatusPane;
  m_FileHumDBB.m_ProgressStatus := frmMain.ProgressStatus;
  m_FileHumDBB.m_RzStatusPane := frmMain.RzStatusPane;

  m_FileDBA.m_ProgressStatus := frmMain.ProgressStatus;
  m_FileDBA.m_RzStatusPane := frmMain.RzStatusPane;
  m_FileDBB.m_ProgressStatus := frmMain.ProgressStatus;
  m_FileDBB.m_RzStatusPane := frmMain.RzStatusPane;

  m_SellOffA.m_ProgressStatus := frmMain.ProgressStatus;
  m_SellOffA.m_RzStatusPane := frmMain.RzStatusPane;
  m_SellOffB.m_ProgressStatus := frmMain.ProgressStatus;
  m_SellOffB.m_RzStatusPane := frmMain.RzStatusPane;

  m_SellGoldA.m_ProgressStatus := frmMain.ProgressStatus;
  m_SellGoldA.m_RzStatusPane := frmMain.RzStatusPane;
  m_SellGoldB.m_ProgressStatus := frmMain.ProgressStatus;
  m_SellGoldB.m_RzStatusPane := frmMain.RzStatusPane;

  m_StorageA.m_ProgressStatus := frmMain.ProgressStatus;
  m_StorageA.m_RzStatusPane := frmMain.RzStatusPane;
  m_StorageB.m_ProgressStatus := frmMain.ProgressStatus;
  m_StorageB.m_RzStatusPane := frmMain.RzStatusPane;

  m_GuildBaseA.m_ProgressStatus := frmMain.ProgressStatus;
  m_GuildBaseA.m_RzStatusPane := frmMain.RzStatusPane;
  m_GuildBaseB.m_ProgressStatus := frmMain.ProgressStatus;
  m_GuildBaseB.m_RzStatusPane := frmMain.RzStatusPane;




  m_ItemBindIPaddrA := TList.Create;
  m_ItemBindIPaddrB := TList.Create;

  m_ItemBindAccountA := TList.Create;
  m_ItemBindAccountB := TList.Create;

  m_ItemBindCharNameA := TList.Create;
  m_ItemBindCharNameB := TList.Create;

  m_RememberItemListA := TQuickList.Create;
  m_RememberItemListB := TQuickList.Create;

  m_DynamicVarListA := TStringList.Create;
  m_DynamicVarListB := TStringList.Create;

  m_CharNameListA := TStringList.Create;
  m_CharNameListB := TStringList.Create;
end;

destructor TBlendThread.Destroy;
var
  I: Integer;
begin
  m_FileIDDBA.Free;
  m_FileIDDBB.Free;

  m_FileHumDBA.Free;
  m_FileHumDBB.Free;

  m_FileDBA.Free;
  m_FileDBB.Free;

  m_SellOffA.Free;
  m_SellOffB.Free;

  m_SellGoldA.Free;
  m_SellGoldB.Free;

  m_StorageA.Free;
  m_StorageB.Free;

  m_GuildBaseA.Free;
  m_GuildBaseB.Free;

  m_DuelInfoDBA.Free;
  m_DuelInfoDBB.Free;

  m_DuelItemDBA.Free;
  m_DuelItemDBB.Free;

  for I := 0 to m_ItemBindIPaddrA.Count - 1 do begin
    Dispose(pTItemBind(m_ItemBindIPaddrA.Items[I]));
  end;
  for I := 0 to m_ItemBindIPaddrB.Count - 1 do begin
    Dispose(pTItemBind(m_ItemBindIPaddrB.Items[I]));
  end;

  for I := 0 to m_ItemBindAccountA.Count - 1 do begin
    Dispose(pTItemBind(m_ItemBindAccountA.Items[I]));
  end;
  for I := 0 to m_ItemBindAccountB.Count - 1 do begin
    Dispose(pTItemBind(m_ItemBindAccountB.Items[I]));
  end;

  for I := 0 to m_ItemBindCharNameA.Count - 1 do begin
    Dispose(pTItemBind(m_ItemBindCharNameA.Items[I]));
  end;
  for I := 0 to m_ItemBindCharNameB.Count - 1 do begin
    Dispose(pTItemBind(m_ItemBindCharNameB.Items[I]));
  end;


  for I := 0 to m_RememberItemListA.Count - 1 do begin
    Dispose(pTItemEvent(m_RememberItemListA.Objects[I]));
  end;
  for I := 0 to m_RememberItemListB.Count - 1 do begin
    Dispose(pTItemEvent(m_RememberItemListB.Objects[I]));
  end;

  m_ItemBindIPaddrA.Free;
  m_ItemBindIPaddrB.Free;

  m_ItemBindAccountA.Free;
  m_ItemBindAccountB.Free;

  m_ItemBindCharNameA.Free;
  m_ItemBindCharNameB.Free;

  m_RememberItemListA.Free;
  m_RememberItemListB.Free;

  for I := 0 to m_DynamicVarListA.Count - 1 do begin
    TMemoryIniFile(m_DynamicVarListA.Objects[I]).Free;
  end;
  for I := 0 to m_DynamicVarListB.Count - 1 do begin
    TMemoryIniFile(m_DynamicVarListB.Objects[I]).Free;
  end;

  m_DynamicVarListA.Free;
  m_DynamicVarListB.Free;


  for I := 0 to m_CharNameListA.Count - 1 do begin
    TStringList(m_CharNameListA.Objects[I]).Free;
  end;
  for I := 0 to m_CharNameListB.Count - 1 do begin
    TStringList(m_CharNameListB.Objects[I]).Free;
  end;

  m_CharNameListA.Free;
  m_CharNameListB.Free;
  inherited;
end;

procedure TBlendThread.UpdateStatus;
  procedure WriteItemNumber(sConfigFileName: string; nItemNumber: Integer);
  var
    Config: TIniFile;
  begin
    Config := TIniFile.Create(sConfigFileName);
    Config.WriteInteger('Setup', 'ItemNumber', nItemNumber);
    Config.Free;
  end;
  procedure WriteItemNumberEx(sConfigFileName: string; nItemNumber: Integer);
  var
    Config: TIniFile;
  begin
    Config := TIniFile.Create(sConfigFileName);
    Config.WriteInteger('Setup', 'ItemNumberEx', nItemNumber);
    Config.Free;
  end;
var
  sMsg: string;
begin
  //Timer.Enabled := False;
  if not g_boClose then begin
    g_boClose := False;
    g_boStart := False;
    frmMain.BitBtnStart.Caption := '开始合并';
    ProcessMessage('合并完成 用时：' + CurrToStr((GetTickCount - g_dwStartTick) / 1000) + '秒');
    WriteItemNumber(g_sSetup1, g_nMaxItemMakeIndex);
    WriteItemNumberEx(g_sSetup1, g_nMaxItemMakeIndexEx);
    sMsg := '新的ID.DB记录数：' + IntToStr(g_nIDDBCount) + #9 + #13;
    sMsg := sMsg + '新的Hum.DB记录数：' + IntToStr(g_nHumDBCount) + #9 + #13;
    sMsg := sMsg + '新的Mir.DB记录数：' + IntToStr(g_nMirDBCount) + #9 + #13;
    sMsg := sMsg + '新的GuildBase记录数：' + IntToStr(g_nGuildBaseCount) + #9 + #13;
    if g_boBigStorage then begin
      sMsg := sMsg + '新的UserStorage.DB记录数：' + IntToStr(g_nBigStorageCount) + #9 + #13;
    end;
    if g_boSellOff then begin
      sMsg := sMsg + '新的UserSellOff.Sell记录数：' + IntToStr(g_nSellOffSellCount) + #9 + #13;
      sMsg := sMsg + '新的UserSellOff.Gold记录数：' + IntToStr(g_nSellOffGoldCount) + #9;
    end;
    try
      g_LogIDList.SaveToFile(g_sSaveDir + 'LogID.txt');
      g_LogHumList.SaveToFile(g_sSaveDir + 'LogHum.txt');
      g_LogGuildList.SaveToFile(g_sSaveDir + 'LogGuild.txt');
    except
    end;
    Application.MessageBox(PChar(sMsg), '合并完成', MB_ICONQUESTION);
  end else begin
    frmMain.BitBtnStart.Caption := '开始合并';
    frmMain.ProgressStatus.Percent := 0;
    ProcessMessage('已经中止数据库合并');
  end;
end;

procedure TBlendThread.Execute;
var
  sMsg: string;
  I: Integer;
begin
  FreeOnTerminate := True;
  g_dwStartTick := GetTickCount;
  frmMain.ProgressStatus.Percent := 0;
  frmMain.BitBtnStart.Caption := '中止合并';

  g_LogIDList.Clear;
  g_LogHumList.Clear;
  g_LogGuildList.Clear;

  LoadIDDBList();
  LoadHumDBList();
  LoadMirDBList();
  LoadGuildBaseList();

  if g_boBigStorage then begin
    LoadBigStorageList();
  end;

  if g_boSellOff then begin
    LoadSellOffSellList();
    LoadSellOffGoldList();
  end;

  if g_boDuel then begin
    LoadDuelInfoList();
    LoadDuelItemList();
  end;

  LoadItemBindIPaddr(g_sItemBindIPaddr1, m_ItemBindIPaddrA);
  LoadItemBindIPaddr(g_sItemBindIPaddr2, m_ItemBindIPaddrB);
  LoadItemBindAccount(g_sItemBindAccount1, m_ItemBindAccountA);
  LoadItemBindAccount(g_sItemBindAccount2, m_ItemBindAccountB);
  LoadItemBindCharName(g_sItemBindChrName1, m_ItemBindCharNameA);
  LoadItemBindCharName(g_sItemBindChrName2, m_ItemBindCharNameB);
  LoadRememberItemList(g_sRememberItemList1, m_RememberItemListA);
  LoadRememberItemList(g_sRememberItemList2, m_RememberItemListB);

  LoadDynamicVarList();
  LoadCharNameList();

  BlendIDDBList();
  BlendHumDBList();
  BlendMirDBList();
  BlendGuildBaseList();

  if g_boBigStorage then begin
    BlendBigStorageList();
  end;

  if g_boSellOff then begin
    BlendSellOffSellList();
    BlendSellOffGoldList();
  end;

  SaveIDDBList();
  SaveHumDBList();
  SaveMirDBList();
  SaveGuildBaseList();

  if g_boBigStorage then begin
    SaveBigStorageList();
  end;

  if g_boSellOff then begin
    SaveSellOffSellList();
    SaveSellOffGoldList();
  end;

  if g_boDuel then begin
    SaveDuelInfoList();
    SaveDuelItemList();
  end;

  SaveItemBindIPaddr(g_sSaveDir + 'ItemBindIPaddr.txt', m_ItemBindIPaddrA);
  SaveItemBindAccount(g_sSaveDir + 'ItemBindAccount.txt', m_ItemBindAccountA);
  SaveItemBindCharName(g_sSaveDir + 'ItemBindChrName.txt', m_ItemBindCharNameA);
  SaveRememberItemList(g_sSaveDir + 'RememberItemList.txt', m_RememberItemListA);

  SaveDynamicVarList();
  SaveCharNameList();

  Synchronize(UpdateStatus);

  inherited;
end;

procedure TBlendThread.LoadDynamicVarList();
var
  I: Integer;
  MemoryIniFile: TMemoryIniFile;
begin
  if g_DynamicVarListA.Count = g_DynamicVarListB.Count then begin
    for I := g_DynamicVarListA.Count - 1 downto 0 do begin
      if (not FileExists(g_DynamicVarListA[I])) or (not FileExists(g_DynamicVarListB[I])) then begin
        g_DynamicVarListA.Delete(I);
        g_DynamicVarListB.Delete(I);
      end;
    end;

    for I := 0 to g_DynamicVarListA.Count - 1 do begin
      if FileExists(g_DynamicVarListA[I]) then begin
        MemoryIniFile := TMemoryIniFile.Create;
        MemoryIniFile.LoadFromFile(g_DynamicVarListA[I]);
        m_DynamicVarListA.AddObject(g_DynamicVarListA[I], MemoryIniFile);
      end;
    end;

    for I := 0 to g_DynamicVarListB.Count - 1 do begin
      if FileExists(g_DynamicVarListB[I]) then begin
        MemoryIniFile := TMemoryIniFile.Create;
        MemoryIniFile.LoadFromFile(g_DynamicVarListB[I]);
        m_DynamicVarListB.AddObject(g_DynamicVarListB[I], MemoryIniFile);
      end;
    end;
  end;
end;

procedure TBlendThread.SaveDynamicVarList();
var
  I: Integer;
  sSaveDir, sFileName: string;
  MemoryIniFile: TMemoryIniFile;
begin
  ProcessMessage('正在保存自定义变量，请稍候...');
  for I := 0 to g_DynamicVarListA.Count - 1 do begin
    MemoryIniFile := TMemoryIniFile(m_DynamicVarListA.Objects[I]);
    //sSaveDir := GetSaveDir(g_DynamicVarListA[I]);
    //sSaveDir :=ExtractFilePath(g_DynamicVarListA[I]);
    sFileName := ExtractFileName(g_DynamicVarListA[I]);
    //if not DirectoryExists(sSaveDir) then ForceDirectories(sSaveDir); //创建目录

    MemoryIniFile.SaveToFile(g_sSaveDir + sFileName);
  end;
end;

procedure TBlendThread.LoadCharNameList();
var
  I: Integer;
  StringList: TStringList;
begin
  if g_CharNameListA.Count = g_CharNameListB.Count then begin
    for I := g_CharNameListA.Count - 1 downto 0 do begin
      if (not FileExists(g_CharNameListA[I])) or (not FileExists(g_CharNameListB[I])) then begin
        g_CharNameListA.Delete(I);
        g_CharNameListB.Delete(I);
      end;
    end;

    for I := 0 to g_CharNameListA.Count - 1 do begin
      if FileExists(g_CharNameListA[I]) then begin
        StringList := TStringList.Create;
        StringList.LoadFromFile(g_CharNameListA[I]);
        m_CharNameListA.AddObject(g_CharNameListA[I], StringList);
      end;
    end;

    for I := 0 to g_CharNameListB.Count - 1 do begin
      if FileExists(g_CharNameListB[I]) then begin
        StringList := TStringList.Create;
        StringList.LoadFromFile(g_CharNameListB[I]);
        m_CharNameListB.AddObject(g_CharNameListB[I], StringList);
      end;
    end;
  end;
end;

procedure TBlendThread.SaveCharNameList();
var
  I: Integer;
  sSaveDir, sFileName: string;
  StringList: TStringList;
begin
  ProcessMessage('正在保存名称列表，请稍候...');
  for I := 0 to g_CharNameListA.Count - 1 do begin
    StringList := TStringList(m_CharNameListA.Objects[I]);
    //sSaveDir := GetSaveDir(g_DynamicVarListA[I]);
    //sSaveDir :=ExtractFilePath(g_DynamicVarListA[I]);
    sFileName := ExtractFileName(g_CharNameListA[I]);
    //if not DirectoryExists(sSaveDir) then ForceDirectories(sSaveDir); //创建目录

    StringList.SaveToFile(g_sSaveDir + sFileName);
  end;
end;

procedure TBlendThread.SetItemBindMakeIdx(List: TList; nOldItemMakeIdx, nNewItemMakeIdx: Integer);
var
  I: Integer;
begin
  for I := 0 to List.Count - 1 do begin
    if pTItemBind(List.Items[I]).nMakeIdex = nOldItemMakeIdx then begin
      pTItemBind(List.Items[I]).nMakeIdex := nNewItemMakeIdx;
    end;
  end;
end;

procedure TBlendThread.SetItemBindName(List: TList; sOldName, sNewName: string);
var
  I: Integer;
begin
  for I := 0 to List.Count - 1 do begin
    if CompareText(pTItemBind(List.Items[I]).sBindName, sOldName) = 0 then begin
      pTItemBind(List.Items[I]).sBindName := sNewName;
    end;
  end;
end;

procedure TBlendThread.SetRememberItemList(List: TQuickList; nOldItemMakeIdx, nNewItemMakeIdx: Integer);
var
  nIndex: Integer;
  ItemEvent: pTItemEvent;
begin
  nIndex := List.GetIndex(IntToStr(nOldItemMakeIdx));
  if nIndex >= 0 then begin
    ItemEvent := pTItemEvent(List.Objects[nIndex]);
    ItemEvent.nMakeIndex := nNewItemMakeIdx;
    List.Strings[nIndex] := IntToStr(nNewItemMakeIdx);
    List.SortString(0, List.Count - 1);
  end;
end;

function TBlendThread.LoadItemBindIPaddr(sFileName: string; List: TList): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sLineText, sMakeIndex, sItemIndex, sBindName: string;
  nMakeIndex, nItemIndex: Integer;
  ItemBind: pTItemBind;
begin
  Result := False;
  LoadList := TStringList.Create;
  if FileExists(sFileName) then begin
    for I := 0 to List.Count - 1 do begin
      Dispose(pTItemBind(List.Items[I]));
    end;
    List.Clear;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      if sLineText[1] = ';' then Continue;
      sLineText := GetValidStr3(sLineText, sItemIndex, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sMakeIndex, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sBindName, [' ', ',', #9]);
      nMakeIndex := Str_ToInt(sMakeIndex, -1);
      nItemIndex := Str_ToInt(sItemIndex, -1);
      if (nMakeIndex > 0) and (nItemIndex > 0) and (sBindName <> '') then begin
        New(ItemBind);
        ItemBind.nMakeIdex := nMakeIndex;
        ItemBind.nItemIdx := nItemIndex;
        ItemBind.sBindName := sBindName;
        List.Add(ItemBind);
      end;
    end;
    Result := True;
  end;
  LoadList.Free;
end;

function TBlendThread.SaveItemBindIPaddr(sFileName: string; List: TList): Boolean;
var
  I: Integer;
  SaveList: TStringList;
  ItemBind: pTItemBind;
begin
  Result := False;
  SaveList := TStringList.Create;
  for I := 0 to List.Count - 1 do begin
    ItemBind := List.Items[I];
    SaveList.Add(IntToStr(ItemBind.nItemIdx) + #9 + IntToStr(ItemBind.nMakeIdex) + #9 + ItemBind.sBindName);
  end;
  if SaveList.Count > 0 then begin
    try
      SaveList.SaveToFile(sFileName);
    except
    end;
  end;
  SaveList.Free;
  Result := True;
end;

function TBlendThread.LoadItemBindAccount(sFileName: string; List: TList): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sLineText, sMakeIndex, sItemIndex, sBindName: string;
  nMakeIndex, nItemIndex: Integer;
  ItemBind: pTItemBind;
begin
  Result := False;
  LoadList := TStringList.Create;
  if FileExists(sFileName) then begin
    for I := 0 to List.Count - 1 do begin
      Dispose(pTItemBind(List.Items[I]));
    end;
    List.Clear;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      if sLineText[1] = ';' then Continue;
      sLineText := GetValidStr3(sLineText, sItemIndex, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sMakeIndex, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sBindName, [' ', ',', #9]);
      nMakeIndex := Str_ToInt(sMakeIndex, -1);
      nItemIndex := Str_ToInt(sItemIndex, -1);
      if (nMakeIndex > 0) and (nItemIndex > 0) and (sBindName <> '') then begin
        New(ItemBind);
        ItemBind.nMakeIdex := nMakeIndex;
        ItemBind.nItemIdx := nItemIndex;
        ItemBind.sBindName := sBindName;
        List.Add(ItemBind);
      end;
    end;
    Result := True;
  end;
  LoadList.Free;
end;

function TBlendThread.SaveItemBindAccount(sFileName: string; List: TList): Boolean;
var
  I: Integer;
  SaveList: TStringList;
  ItemBind: pTItemBind;
begin
  Result := False;
  SaveList := TStringList.Create;
  for I := 0 to List.Count - 1 do begin
    ItemBind := List.Items[I];
    SaveList.Add(IntToStr(ItemBind.nItemIdx) + #9 + IntToStr(ItemBind.nMakeIdex) + #9 + ItemBind.sBindName);
  end;
  if SaveList.Count > 0 then begin
    try
      SaveList.SaveToFile(sFileName);
    except
    end;
  end;
  SaveList.Free;
  Result := True;
end;

function TBlendThread.LoadRememberItemList(sFileName: string; List: TQuickList): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sLineText, sMakeIndex, sItemName, sMapName, sID, sX, sY: string;
  nMakeIndex, nIndex, nID: Integer;
  nCurrX: Integer;
  nCurrY: Integer;
  ItemEvent: pTItemEvent;
begin
  Result := False;
  LoadList := TStringList.Create;

  for I := 0 to List.Count - 1 do begin
    Dispose(pTItemEvent(List.Objects[I]));
  end;
  List.Clear;

  if FileExists(sFileName) then begin
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      if (sLineText = '') or (sLineText[1] = ';') then Continue;
      sLineText := GetValidStr3(sLineText, sItemName, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sMakeIndex, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sID, [',', #9]);
      sLineText := GetValidStr3(sLineText, sMapName, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sX, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sY, [' ', ',', #9]);
      nMakeIndex := Str_ToInt(sMakeIndex, -1);
      nCurrX := Str_ToInt(sX, -1);
      nCurrY := Str_ToInt(sY, -1);
      nID := Str_ToInt(sID, -1);
      if (nMakeIndex > 0) and (sMapName <> '') and (nCurrX >= 0) and (nCurrY >= 0) and (nID in [0..5]) then begin
        nIndex := List.GetIndex(sMakeIndex);
        if nIndex >= 0 then begin
          ItemEvent := pTItemEvent(List.Objects[nIndex]);
          ItemEvent.RememberItem[nID].sMapName := sMapName;
          ItemEvent.RememberItem[nID].nCurrX := nCurrX;
          ItemEvent.RememberItem[nID].nCurrY := nCurrY;
        end else begin
          New(ItemEvent);
          ItemEvent.sItemName := sItemName;
          ItemEvent.nMakeIndex := nMakeIndex;
          FillChar(ItemEvent.RememberItem, SizeOf(TRememberItem) * 6, #0);
          ItemEvent.RememberItem[nID].sMapName := sMapName;
          ItemEvent.RememberItem[nID].nCurrX := nCurrX;
          ItemEvent.RememberItem[nID].nCurrY := nCurrY;
          List.AddRecord(IntToStr(nMakeIndex), TObject(ItemEvent));
        end;
      end;
    end;
    List.SortString(0, List.Count - 1);
    Result := True;
  end;
  LoadList.Free;
end;

function TBlendThread.SaveRememberItemList(sFileName: string; List: TQuickList): Boolean;
var
  I, II: Integer;
  SaveList: TStringList;
  ItemEvent: pTItemEvent;
begin
  Result := False;
  SaveList := TStringList.Create;

  for I := 0 to List.Count - 1 do begin
    ItemEvent := pTItemEvent(List.Objects[I]);
    for II := Low(ItemEvent.RememberItem) to High(ItemEvent.RememberItem) do begin
      if ItemEvent.RememberItem[II].sMapName <> '' then begin
        SaveList.Add(ItemEvent.sItemName + #9 + IntToStr(ItemEvent.nMakeIndex) + #9 + IntToStr(II) + #9 + ItemEvent.RememberItem[II].sMapName + #9 + IntToStr(ItemEvent.RememberItem[II].nCurrX) + #9 + IntToStr(ItemEvent.RememberItem[II].nCurrY));
      end;
    end;
  end;
   {
  for I := 0 to List.Count - 1 do begin
    ItemEvent := pTItemEvent(List.Items[I]);
    SaveList.Add(ItemEvent.m_sItemName + #9 + IntToStr(ItemEvent.m_nMakeIndex) + #9 + ItemEvent.m_sMapName + #9 + IntToStr(ItemEvent.m_nCurrX) + #9 + IntToStr(ItemEvent.m_nCurrY));
  end;}
  if SaveList.Count > 0 then begin
    try
      SaveList.SaveToFile(sFileName);
    except
    end;
  end;
  SaveList.Free;
  Result := True;
end;

function TBlendThread.LoadItemBindCharName(sFileName: string; List: TList): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sLineText, sMakeIndex, sItemIndex, sBindName: string;
  nMakeIndex, nItemIndex: Integer;
  ItemBind: pTItemBind;
begin
  Result := False;
  LoadList := TStringList.Create;
  if FileExists(sFileName) then begin
    for I := 0 to List.Count - 1 do begin
      Dispose(pTItemBind(List.Items[I]));
    end;
    List.Clear;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      if sLineText[1] = ';' then Continue;
      sLineText := GetValidStr3(sLineText, sItemIndex, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sMakeIndex, [' ', ',', #9]);
      sLineText := GetValidStr3(sLineText, sBindName, [' ', ',', #9]);
      nMakeIndex := Str_ToInt(sMakeIndex, -1);
      nItemIndex := Str_ToInt(sItemIndex, -1);
      if (nMakeIndex > 0) and (nItemIndex > 0) and (sBindName <> '') then begin
        New(ItemBind);
        ItemBind.nMakeIdex := nMakeIndex;
        ItemBind.nItemIdx := nItemIndex;
        ItemBind.sBindName := sBindName;
        List.Add(ItemBind);
      end;
    end;
    Result := True;
  end;
  LoadList.Free;
end;

function TBlendThread.SaveItemBindCharName(sFileName: string; List: TList): Boolean;
var
  I: Integer;
  SaveList: TStringList;
  ItemBind: pTItemBind;
begin
  Result := False;
  SaveList := TStringList.Create;
  for I := 0 to List.Count - 1 do begin
    ItemBind := List.Items[I];
    SaveList.Add(IntToStr(ItemBind.nItemIdx) + #9 + IntToStr(ItemBind.nMakeIdex) + #9 + ItemBind.sBindName);
  end;
  if SaveList.Count > 0 then begin
    try
      SaveList.SaveToFile(sFileName);
    except
    end;
  end;
  SaveList.Free;
  Result := True;
end;

procedure TBlendThread.UpdataAccount(sAccount, sNewAccount: string);
var
  I, nIndex: Integer;
  HumRecord: pTHumInfo;
  HumDataInfo: pTHumDataInfo;
  ChrList: TList;
begin
  //if sAccount = sNewAccount then Exit; //账号没有变化退出
  for nIndex := 0 to m_FileHumDBB.m_HumDBList.Count - 1 do begin
    if CompareText(m_FileHumDBB.m_HumDBList.Strings[nIndex], sAccount) = 0 then begin
      m_FileHumDBB.m_HumDBList.Strings[nIndex] := sNewAccount;
      ChrList := TList(m_FileHumDBB.m_HumDBList.Objects[nIndex]);
      for I := 0 to ChrList.Count - 1 do begin
        HumRecord := pTHumInfo(ChrList.Items[I]);
        HumRecord.sAccount := sNewAccount;
      end;
      Break;
    end;
  end;

  for nIndex := 0 to m_FileDBB.m_MirDBList.Count - 1 do begin
    if CompareText(m_FileDBB.m_MirDBList.Strings[nIndex], sAccount) = 0 then begin
      m_FileDBB.m_MirDBList.Strings[nIndex] := sNewAccount;
      ChrList := TList(m_FileDBB.m_MirDBList.Objects[nIndex]);
      for I := 0 to ChrList.Count - 1 do begin
        HumDataInfo := pTHumDataInfo(ChrList.Items[I]);
        HumDataInfo.Data.sAccount := sNewAccount;
      end;
      Break;
    end;
  end;
  m_FileDBB.m_MirDBList.SortString(0, m_FileDBB.m_MirDBList.Count - 1);
  m_FileHumDBB.m_HumDBList.SortString(0, m_FileHumDBB.m_HumDBList.Count - 1);
  SetItemBindName(m_ItemBindAccountB, sAccount, sNewAccount);
end;

procedure TBlendThread.UpdataDynamicVarCharName(sCharName, sNewCharName: string);
var
  I, II: Integer;
  MemoryIniFile: TMemoryIniFile;
begin
  for I := 0 to m_DynamicVarListB.Count - 1 do begin
    MemoryIniFile := TMemoryIniFile(m_DynamicVarListB.Objects[I]);
    for II := 0 to MemoryIniFile.Sections.Count - 1 do begin
      if CompareText(MemoryIniFile.Sections[II], sCharName) = 0 then begin
        MemoryIniFile.Sections[II] := sNewCharName;
        Break;
      end;
    end;
  end;
end;

procedure TBlendThread._UpdataDynamicVarCharName(sCharName, sNewCharName: string);
var
  I, II: Integer;
  MemoryIniFile: TMemoryIniFile;
begin
  for I := 0 to m_DynamicVarListA.Count - 1 do begin
    MemoryIniFile := TMemoryIniFile(m_DynamicVarListA.Objects[I]);
    for II := 0 to MemoryIniFile.Sections.Count - 1 do begin
      if CompareText(MemoryIniFile.Sections[II], sCharName) = 0 then begin
        MemoryIniFile.Sections[II] := sNewCharName;
        Break;
      end;
    end;
  end;
end;

procedure TBlendThread.UpdataCharNameList(sCharName, sNewCharName: string);
var
  I, II: Integer;
  sText: string;
  StringList: TStringList;
begin
  for I := 0 to m_CharNameListB.Count - 1 do begin
    StringList := TStringList(m_CharNameListB.Objects[I]);
    for II := 0 to StringList.Count - 1 do begin
      sText := StringList[II];
      if Pos(sCharName, sText) > 0 then begin
        StringList[II] := AnsiReplaceText(sText, sCharName, sNewCharName);
        Break;
      end;
    end;
  end;
end;

procedure TBlendThread._UpdataCharNameList(sCharName, sNewCharName: string);
var
  I, II: Integer;
  sText: string;
  StringList: TStringList;
begin
  for I := 0 to m_CharNameListA.Count - 1 do begin
    StringList := TStringList(m_CharNameListA.Objects[I]);
    for II := 0 to StringList.Count - 1 do begin
      sText := StringList[II];
      if Pos(sCharName, sText) > 0 then begin
        StringList[II] := AnsiReplaceText(sText, sCharName, sNewCharName);
        Break;
      end;
    end;
  end;
end;

procedure TBlendThread.UpdataCharName(sCharName, sNewCharName: string);
var
  I, II, III: Integer;
  HumDataInfo: pTHumDataInfo;
  //HumRecord: pTHumInfo;
  ChrList: TList;
  Guild: pTGUild;
  GuildRank: pTGuildRank;
  StorageRecord: pTBigStorage;
  SellOffInfo: pTSellOffInfo;
  DuelInfo: pTDuelInfo;
  DuelItem: pTDuelItem;
  nIndex: Integer;
  //MemoryIniFile: TMemoryIniFile;
begin
  //if sCharName = sNewCharName then Exit; //名称没有变化退出
  {for nIndex := 0 to m_FileHumDBB.m_HumCharNameList.Count - 1 do begin
    if CompareText(m_FileHumDBB.m_HumCharNameList.Strings[nIndex], sCharName) = 0 then begin
      m_FileHumDBB.m_HumCharNameList.Strings[nIndex] := sNewCharName;
      HumRecord := pTHumInfo(m_FileHumDBB.m_HumCharNameList.Objects[I]);
      HumRecord.Header.sName := sNewCharName;
      HumRecord.sChrName := sNewCharName;
      Break;
    end;
  end; }

  for nIndex := 0 to m_FileDBB.m_MirCharNameList.Count - 1 do begin
    if CompareText(m_FileDBB.m_MirCharNameList.Strings[nIndex], sCharName) = 0 then begin
      m_FileDBB.m_MirCharNameList.Strings[nIndex] := sNewCharName;
      HumDataInfo := pTHumDataInfo(m_FileDBB.m_MirCharNameList.Objects[nIndex]);
      HumDataInfo.Header.sName := sNewCharName;
      HumDataInfo.Data.sChrName := sNewCharName;
      Break;
    end;
  end;

  for nIndex := 0 to m_FileDBB.m_MasterList.Count - 1 do begin
    if CompareText(m_FileDBB.m_MasterList.Strings[nIndex], sCharName) = 0 then begin
      m_FileDBB.m_MasterList.Strings[nIndex] := sNewCharName;
      HumDataInfo := pTHumDataInfo(m_FileDBB.m_MasterList.Objects[nIndex]);
      HumDataInfo.Data.sMasterName := sNewCharName;
      Break;
    end;
  end;

  for nIndex := 0 to m_FileDBB.m_DearList.Count - 1 do begin
    if CompareText(m_FileDBB.m_DearList.Strings[nIndex], sCharName) = 0 then begin
      m_FileDBB.m_DearList.Strings[nIndex] := sNewCharName;
      HumDataInfo := pTHumDataInfo(m_FileDBB.m_DearList.Objects[nIndex]);
      HumDataInfo.Data.sDearName := sNewCharName;
      Break;
    end;
  end;

  for nIndex := 0 to m_FileDBB.m_HeroList.Count - 1 do begin
    if CompareText(m_FileDBB.m_HeroList.Strings[nIndex], sCharName) = 0 then begin
      m_FileDBB.m_HeroList.Strings[nIndex] := sNewCharName;
      HumDataInfo := pTHumDataInfo(m_FileDBB.m_HeroList.Objects[nIndex]);
      HumDataInfo.Header.sName := sNewCharName;
      HumDataInfo.Data.sChrName := sNewCharName;
      Break;
    end;
  end;

  for nIndex := 0 to m_FileDBB.m_HeroNameList.Count - 1 do begin
    if CompareText(m_FileDBB.m_HeroNameList.Strings[nIndex], sCharName) = 0 then begin
      m_FileDBB.m_HeroNameList.Strings[nIndex] := sNewCharName;
      HumDataInfo := pTHumDataInfo(m_FileDBB.m_HeroNameList.Objects[nIndex]);
      HumDataInfo.Data.sHeroChrName := sNewCharName;
      Break;
    end;
  end;

  for I := 0 to m_GuildBaseB.m_GuildBaseList.Count - 1 do begin
    Guild := pTGUild(m_GuildBaseB.m_GuildBaseList.Objects[I]);
    for II := 0 to Guild.RankList.Count - 1 do begin
      GuildRank := pTGuildRank(Guild.RankList.Items[II]);
      for III := 0 to GuildRank.MemberList.Count - 1 do begin
        if CompareText(GuildRank.MemberList.Strings[III], sCharName) = 0 then begin
          GuildRank.MemberList.Strings[III] := sNewCharName;
          Break;
        end;
      end;
    end;
  end;

  if g_boBigStorage then begin
    for nIndex := 0 to m_StorageB.m_BigStorageList.Count - 1 do begin
      if CompareText(m_StorageB.m_BigStorageList.Strings[nIndex], sCharName) = 0 then begin
        m_StorageB.m_BigStorageList.Strings[nIndex] := sNewCharName;
        ChrList := TList(m_StorageB.m_BigStorageList.Objects[nIndex]);
        for II := 0 to ChrList.Count - 1 do begin
          StorageRecord := pTBigStorage(ChrList.Items[II]);
          StorageRecord.sCharName := sNewCharName;
        end;
        Break;
      end;
    end;
  end;
  if g_boSellOff then begin
    for nIndex := 0 to m_SellOffB.m_SellOffList.Count - 1 do begin
      if CompareText(m_SellOffB.m_SellOffList.Strings[nIndex], sCharName) = 0 then begin
        m_SellOffB.m_SellOffList.Strings[nIndex] := sNewCharName;
        ChrList := TList(m_SellOffB.m_SellOffList.Objects[nIndex]);
        for II := 0 to ChrList.Count - 1 do begin
          SellOffInfo := pTSellOffInfo(ChrList.Items[II]);
          SellOffInfo.sCharName := sNewCharName;
        end;
        Break;
      end;
    end;

    for nIndex := 0 to m_SellGoldB.m_SellOffList.Count - 1 do begin
      if CompareText(m_SellGoldB.m_SellOffList.Strings[nIndex], sCharName) = 0 then begin
        m_SellGoldB.m_SellOffList.Strings[nIndex] := sNewCharName;
        ChrList := TList(m_SellGoldB.m_SellOffList.Objects[nIndex]);
        for II := 0 to ChrList.Count - 1 do begin
          SellOffInfo := pTSellOffInfo(ChrList.Items[II]);
          SellOffInfo.sCharName := sNewCharName;
        end;
        Break;
      end;
    end;
  end;

  if g_boDuel then begin
    for nIndex := 0 to m_DuelInfoDBB.m_OwnerList.Count - 1 do begin
      if CompareText(m_DuelInfoDBB.m_OwnerList.Strings[nIndex], sCharName) = 0 then begin
        m_DuelInfoDBB.m_OwnerList.Strings[nIndex] := sNewCharName;
        ChrList := TList(m_DuelInfoDBB.m_OwnerList.Objects[nIndex]);
        for II := 0 to ChrList.Count - 1 do begin
          DuelInfo := pTDuelInfo(ChrList.Items[II]);
          DuelInfo.Owner.sCharName := sNewCharName;
        end;
        Break;
      end;
    end;

    for nIndex := 0 to m_DuelInfoDBB.m_DuelList.Count - 1 do begin
      if CompareText(m_DuelInfoDBB.m_DuelList.Strings[nIndex], sCharName) = 0 then begin
        m_DuelInfoDBB.m_DuelList.Strings[nIndex] := sNewCharName;
        ChrList := TList(m_DuelInfoDBB.m_DuelList.Objects[nIndex]);
        for II := 0 to ChrList.Count - 1 do begin
          DuelInfo := pTDuelInfo(ChrList.Items[II]);
          DuelInfo.Duel.sCharName := sNewCharName;
        end;
        Break;
      end;
    end;

    for nIndex := 0 to m_DuelItemDBB.m_ItemList.Count - 1 do begin
      if CompareText(m_DuelItemDBB.m_ItemList.Strings[nIndex], sCharName) = 0 then begin
        m_DuelItemDBB.m_ItemList.Strings[nIndex] := sNewCharName;
        ChrList := TList(m_DuelItemDBB.m_ItemList.Objects[nIndex]);
        for II := 0 to ChrList.Count - 1 do begin
          DuelItem := pTDuelItem(ChrList.Items[II]);
          DuelItem.sOwnerName := sNewCharName;
        end;
        Break;
      end;
    end;

    for nIndex := 0 to m_DuelItemDBB.m_DuelItemList.Count - 1 do begin
      if CompareText(m_DuelItemDBB.m_DuelItemList.Strings[nIndex], sCharName) = 0 then begin
        m_DuelItemDBB.m_DuelItemList.Strings[nIndex] := sNewCharName;
        ChrList := TList(m_DuelItemDBB.m_DuelItemList.Objects[nIndex]);
        for II := 0 to ChrList.Count - 1 do begin
          DuelItem := pTDuelItem(ChrList.Items[II]);
          DuelItem.sDuelName := sNewCharName;
        end;
        Break;
      end;
    end;

  end;

  m_FileDBB.m_MirDBList.SortString(0, m_FileDBB.m_MirDBList.Count - 1);
  m_FileDBB.m_DearList.SortString(0, m_FileDBB.m_DearList.Count - 1);
  m_FileDBB.m_MasterList.SortString(0, m_FileDBB.m_MasterList.Count - 1);
  m_FileDBB.m_HeroList.SortString(0, m_FileDBB.m_HeroList.Count - 1);
  m_FileDBB.m_HeroNameList.SortString(0, m_FileDBB.m_HeroNameList.Count - 1);
  m_FileDBB.m_MirCharNameList.SortString(0, m_FileDBB.m_MirCharNameList.Count - 1);
  m_SellOffB.m_SellOffList.SortString(0, m_SellOffB.m_SellOffList.Count - 1);
  m_SellGoldB.m_SellOffList.SortString(0, m_SellGoldB.m_SellOffList.Count - 1);
  m_StorageB.m_BigStorageList.SortString(0, m_StorageB.m_BigStorageList.Count - 1);

  m_DuelItemDBB.m_DuelItemList.SortString(0, m_DuelItemDBB.m_DuelItemList.Count - 1);
  m_DuelItemDBB.m_ItemList.SortString(0, m_DuelItemDBB.m_ItemList.Count - 1);

  m_DuelInfoDBB.m_OwnerList.SortString(0, m_DuelInfoDBB.m_OwnerList.Count - 1);
  m_DuelInfoDBB.m_DuelList.SortString(0, m_DuelInfoDBB.m_DuelList.Count - 1);


  SetItemBindName(m_ItemBindCharNameB, sCharName, sNewCharName);
  UpdataDynamicVarCharName(sCharName, sNewCharName);
  UpdataCharNameList(sCharName, sNewCharName);
end;

procedure TBlendThread._UpdataAccount(sAccount, sNewAccount: string);
var
  I, nIndex: Integer;
  HumRecord: pTHumInfo;
  HumDataInfo: pTHumDataInfo;
  ChrList: TList;
begin
  //if sAccount = sNewAccount then Exit; //账号没有变化退出
  for nIndex := 0 to m_FileHumDBA.m_HumDBList.Count - 1 do begin
    if CompareText(m_FileHumDBA.m_HumDBList.Strings[nIndex], sAccount) = 0 then begin
      m_FileHumDBA.m_HumDBList.Strings[nIndex] := sNewAccount;
      ChrList := TList(m_FileHumDBA.m_HumDBList.Objects[nIndex]);
      for I := 0 to ChrList.Count - 1 do begin
        HumRecord := pTHumInfo(ChrList.Items[I]);
        HumRecord.sAccount := sNewAccount;
      end;
      Break;
    end;
  end;
  for nIndex := 0 to m_FileDBA.m_MirDBList.Count - 1 do begin
    if CompareText(m_FileDBA.m_MirDBList.Strings[nIndex], sAccount) = 0 then begin
      m_FileDBA.m_MirDBList.Strings[nIndex] := sNewAccount;
      ChrList := TList(m_FileDBA.m_MirDBList.Objects[nIndex]);
      for I := 0 to ChrList.Count - 1 do begin
        HumDataInfo := pTHumDataInfo(ChrList.Items[I]);
        HumDataInfo.Data.sAccount := sNewAccount;
      end;
      Break;
    end;
  end;
  m_FileDBA.m_MirDBList.SortString(0, m_FileDBA.m_MirDBList.Count - 1);
  m_FileHumDBA.m_HumDBList.SortString(0, m_FileHumDBA.m_HumDBList.Count - 1);
  SetItemBindName(m_ItemBindAccountA, sAccount, sNewAccount);
end;

procedure TBlendThread._UpdataCharName(sCharName, sNewCharName: string);
var
  I, II, III: Integer;
  HumDataInfo: pTHumDataInfo;
  //HumRecord: pTHumInfo;
  ChrList: TList;
  Guild: pTGUild;
  GuildRank: pTGuildRank;
  StorageRecord: pTBigStorage;
  SellOffInfo: pTSellOffInfo;
  DuelInfo: pTDuelInfo;
  DuelItem: pTDuelItem;
  nIndex: Integer;
begin
  //if sCharName = sNewCharName then Exit; //名称没有变化退出
  for nIndex := 0 to m_FileDBA.m_MirCharNameList.Count - 1 do begin
    if CompareText(m_FileDBA.m_MirCharNameList.Strings[nIndex], sCharName) = 0 then begin
      m_FileDBA.m_MirCharNameList.Strings[nIndex] := sNewCharName;
      HumDataInfo := pTHumDataInfo(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
      HumDataInfo.Header.sName := sNewCharName;
      HumDataInfo.Data.sChrName := sNewCharName;
      Break;
    end;
  end;

  for nIndex := 0 to m_FileDBA.m_MasterList.Count - 1 do begin
    if CompareText(m_FileDBA.m_MasterList.Strings[nIndex], sCharName) = 0 then begin
      m_FileDBA.m_MasterList.Strings[nIndex] := sNewCharName;
      HumDataInfo := pTHumDataInfo(m_FileDBA.m_MasterList.Objects[nIndex]);
      HumDataInfo.Data.sMasterName := sNewCharName;
      Break;
    end;
  end;

  for nIndex := 0 to m_FileDBA.m_DearList.Count - 1 do begin
    if CompareText(m_FileDBA.m_DearList.Strings[nIndex], sCharName) = 0 then begin
      m_FileDBA.m_DearList.Strings[nIndex] := sNewCharName;
      HumDataInfo := pTHumDataInfo(m_FileDBA.m_DearList.Objects[nIndex]);
      HumDataInfo.Data.sDearName := sNewCharName;
      Break;
    end;
  end;

  for nIndex := 0 to m_FileDBA.m_HeroList.Count - 1 do begin
    if CompareText(m_FileDBA.m_HeroList.Strings[nIndex], sCharName) = 0 then begin
      m_FileDBA.m_HeroList.Strings[nIndex] := sNewCharName;
      HumDataInfo := pTHumDataInfo(m_FileDBA.m_HeroList.Objects[nIndex]);
      HumDataInfo.Header.sName := sNewCharName;
      HumDataInfo.Data.sChrName := sNewCharName;
      Break;
    end;
  end;

  for nIndex := 0 to m_FileDBA.m_HeroNameList.Count - 1 do begin
    if CompareText(m_FileDBA.m_HeroNameList.Strings[nIndex], sCharName) = 0 then begin
      m_FileDBA.m_HeroNameList.Strings[nIndex] := sNewCharName;
      HumDataInfo := pTHumDataInfo(m_FileDBA.m_HeroNameList.Objects[nIndex]);
      HumDataInfo.Data.sHeroChrName := sNewCharName;
      Break;
    end;
  end;

  for I := 0 to m_GuildBaseA.m_GuildBaseList.Count - 1 do begin
    Guild := pTGUild(m_GuildBaseA.m_GuildBaseList.Objects[I]);
    for II := 0 to Guild.RankList.Count - 1 do begin
      GuildRank := pTGuildRank(Guild.RankList.Items[II]);
      for III := 0 to GuildRank.MemberList.Count - 1 do begin
        if CompareText(GuildRank.MemberList.Strings[III], sCharName) = 0 then begin
          GuildRank.MemberList.Strings[III] := sNewCharName;
          Break;
        end;
      end;
    end;
  end;

  if g_boBigStorage then begin
    for nIndex := 0 to m_StorageA.m_BigStorageList.Count - 1 do begin
      if CompareText(m_StorageA.m_BigStorageList.Strings[nIndex], sCharName) = 0 then begin
        m_StorageA.m_BigStorageList.Strings[nIndex] := sNewCharName;
        ChrList := TList(m_StorageA.m_BigStorageList.Objects[nIndex]);
        for II := 0 to ChrList.Count - 1 do begin
          StorageRecord := pTBigStorage(ChrList.Items[II]);
          StorageRecord.sCharName := sNewCharName;
        end;
        Break;
      end;
    end;
  end;

  if g_boSellOff then begin
    for nIndex := 0 to m_SellOffA.m_SellOffList.Count - 1 do begin
      if CompareText(m_SellOffA.m_SellOffList.Strings[nIndex], sCharName) = 0 then begin
        m_SellOffA.m_SellOffList.Strings[nIndex] := sNewCharName;
        ChrList := TList(m_SellOffA.m_SellOffList.Objects[nIndex]);
        for II := 0 to ChrList.Count - 1 do begin
          SellOffInfo := pTSellOffInfo(ChrList.Items[II]);
          SellOffInfo.sCharName := sNewCharName;
        end;
        Break;
      end;
    end;

    for nIndex := 0 to m_SellGoldA.m_SellOffList.Count - 1 do begin
      if CompareText(m_SellGoldA.m_SellOffList.Strings[nIndex], sCharName) = 0 then begin
        m_SellGoldA.m_SellOffList.Strings[nIndex] := sNewCharName;
        ChrList := TList(m_SellGoldA.m_SellOffList.Objects[nIndex]);
        for II := 0 to ChrList.Count - 1 do begin
          SellOffInfo := pTSellOffInfo(ChrList.Items[II]);
          SellOffInfo.sCharName := sNewCharName;
        end;
        Break;
      end;
    end;
  end;


  if g_boDuel then begin
    for nIndex := 0 to m_DuelInfoDBA.m_OwnerList.Count - 1 do begin
      if CompareText(m_DuelInfoDBA.m_OwnerList.Strings[nIndex], sCharName) = 0 then begin
        m_DuelInfoDBA.m_OwnerList.Strings[nIndex] := sNewCharName;
        ChrList := TList(m_DuelInfoDBA.m_OwnerList.Objects[nIndex]);
        for II := 0 to ChrList.Count - 1 do begin
          DuelInfo := pTDuelInfo(ChrList.Items[II]);
          DuelInfo.Owner.sCharName := sNewCharName;
        end;
        Break;
      end;
    end;

    for nIndex := 0 to m_DuelInfoDBA.m_DuelList.Count - 1 do begin
      if CompareText(m_DuelInfoDBA.m_DuelList.Strings[nIndex], sCharName) = 0 then begin
        m_DuelInfoDBA.m_DuelList.Strings[nIndex] := sNewCharName;
        ChrList := TList(m_DuelInfoDBA.m_DuelList.Objects[nIndex]);
        for II := 0 to ChrList.Count - 1 do begin
          DuelInfo := pTDuelInfo(ChrList.Items[II]);
          DuelInfo.Duel.sCharName := sNewCharName;
        end;
        Break;
      end;
    end;

    for nIndex := 0 to m_DuelItemDBA.m_ItemList.Count - 1 do begin
      if CompareText(m_DuelItemDBA.m_ItemList.Strings[nIndex], sCharName) = 0 then begin
        m_DuelItemDBA.m_ItemList.Strings[nIndex] := sNewCharName;
        ChrList := TList(m_DuelItemDBA.m_ItemList.Objects[nIndex]);
        for II := 0 to ChrList.Count - 1 do begin
          DuelItem := pTDuelItem(ChrList.Items[II]);
          DuelItem.sOwnerName := sNewCharName;
        end;
        Break;
      end;
    end;

    for nIndex := 0 to m_DuelItemDBA.m_DuelItemList.Count - 1 do begin
      if CompareText(m_DuelItemDBA.m_DuelItemList.Strings[nIndex], sCharName) = 0 then begin
        m_DuelItemDBA.m_DuelItemList.Strings[nIndex] := sNewCharName;
        ChrList := TList(m_DuelItemDBA.m_DuelItemList.Objects[nIndex]);
        for II := 0 to ChrList.Count - 1 do begin
          DuelItem := pTDuelItem(ChrList.Items[II]);
          DuelItem.sDuelName := sNewCharName;
        end;
        Break;
      end;
    end;

  end;

  m_FileDBA.m_MirDBList.SortString(0, m_FileDBA.m_MirDBList.Count - 1);
  m_FileDBA.m_DearList.SortString(0, m_FileDBA.m_DearList.Count - 1);
  m_FileDBA.m_MasterList.SortString(0, m_FileDBA.m_MasterList.Count - 1);
  m_FileDBA.m_HeroList.SortString(0, m_FileDBA.m_HeroList.Count - 1);
  m_FileDBA.m_HeroNameList.SortString(0, m_FileDBA.m_HeroNameList.Count - 1);
  m_FileDBA.m_MirCharNameList.SortString(0, m_FileDBA.m_MirCharNameList.Count - 1);
  m_SellOffA.m_SellOffList.SortString(0, m_SellOffA.m_SellOffList.Count - 1);
  m_SellGoldA.m_SellOffList.SortString(0, m_SellGoldA.m_SellOffList.Count - 1);
  m_StorageA.m_BigStorageList.SortString(0, m_StorageA.m_BigStorageList.Count - 1);

  m_DuelItemDBA.m_DuelItemList.SortString(0, m_DuelItemDBA.m_DuelItemList.Count - 1);
  m_DuelItemDBA.m_ItemList.SortString(0, m_DuelItemDBA.m_ItemList.Count - 1);

  m_DuelInfoDBA.m_OwnerList.SortString(0, m_DuelInfoDBA.m_OwnerList.Count - 1);
  m_DuelInfoDBA.m_DuelList.SortString(0, m_DuelInfoDBA.m_DuelList.Count - 1);

  SetItemBindName(m_ItemBindCharNameA, sCharName, sNewCharName);
  _UpdataDynamicVarCharName(sCharName, sNewCharName);
  _UpdataCharNameList(sCharName, sNewCharName);
end;

procedure TBlendThread.UpdataItemNumber();
  procedure SetMirDBItemNumber(QuickList: TQuickList);
  var
    I, II, nItemMakeIdx: Integer;
    HumDataInfo: pTHumDataInfo;
    HumData: pTHumData;
  begin
    m_nPercent := 0;
    m_nCount := QuickList.Count;
    for I := 0 to QuickList.Count - 1 do begin
      if g_boClose then Break;
      ProcessStatus();
      HumDataInfo := pTHumDataInfo(QuickList.Objects[I]);
      HumData := @HumDataInfo.Data;
      for II := Low(HumData.HumItems) to High(HumData.HumItems) do begin
        if HumData.HumItems[II].wIndex > 0 then begin
          if HumData.HumItems[II].MakeIndex < High(Integer) div 2 then begin
            nItemMakeIdx := GetItemNumber;
          end else begin
            nItemMakeIdx := GetItemNumberEx;
          end;
          if QuickList = m_FileDBA.m_MirCharNameList then begin
            SetItemBindMakeIdx(m_ItemBindIPaddrA, HumData.HumItems[II].MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindAccountA, HumData.HumItems[II].MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindCharNameA, HumData.HumItems[II].MakeIndex, nItemMakeIdx);
            SetRememberItemList(m_RememberItemListA, HumData.HumItems[II].MakeIndex, nItemMakeIdx);
          end else begin
            SetItemBindMakeIdx(m_ItemBindIPaddrB, HumData.HumItems[II].MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindAccountB, HumData.HumItems[II].MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindCharNameB, HumData.HumItems[II].MakeIndex, nItemMakeIdx);
            //SetItemBindMakeIdx(m_RememberItemListB, HumData.HumItems[II].MakeIndex, nItemMakeIdx);
            SetRememberItemList(m_RememberItemListB, HumData.HumItems[II].MakeIndex, nItemMakeIdx);
          end;
          HumData.HumItems[II].MakeIndex := nItemMakeIdx;
        end;
      end;
      for II := Low(HumData.HumAddItems) to High(HumData.HumAddItems) do begin
        if HumData.HumAddItems[II].wIndex > 0 then begin
          if HumData.HumAddItems[II].MakeIndex < High(Integer) div 2 then begin
            nItemMakeIdx := GetItemNumber;
          end else begin
            nItemMakeIdx := GetItemNumberEx;
          end;
          if QuickList = m_FileDBA.m_MirCharNameList then begin
            SetItemBindMakeIdx(m_ItemBindIPaddrA, HumData.HumAddItems[II].MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindAccountA, HumData.HumAddItems[II].MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindCharNameA, HumData.HumAddItems[II].MakeIndex, nItemMakeIdx);
            //SetItemBindMakeIdx(m_RememberItemListA, HumData.HumAddItems[II].MakeIndex, nItemMakeIdx);
            SetRememberItemList(m_RememberItemListA, HumData.HumItems[II].MakeIndex, nItemMakeIdx);
          end else begin
            SetItemBindMakeIdx(m_ItemBindIPaddrB, HumData.HumAddItems[II].MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindAccountB, HumData.HumAddItems[II].MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindCharNameB, HumData.HumAddItems[II].MakeIndex, nItemMakeIdx);
            //SetItemBindMakeIdx(m_RememberItemListB, HumData.HumAddItems[II].MakeIndex, nItemMakeIdx);
            SetRememberItemList(m_RememberItemListB, HumData.HumItems[II].MakeIndex, nItemMakeIdx);
          end;
          HumData.HumAddItems[II].MakeIndex := nItemMakeIdx;
        end;
      end;
      for II := Low(HumData.BagItems) to High(HumData.BagItems) do begin
        if HumData.BagItems[II].wIndex > 0 then begin
          if HumData.BagItems[II].MakeIndex < High(Integer) div 2 then begin
            nItemMakeIdx := GetItemNumber;
          end else begin
            nItemMakeIdx := GetItemNumberEx;
          end;
          if QuickList = m_FileDBA.m_MirCharNameList then begin
            SetItemBindMakeIdx(m_ItemBindIPaddrA, HumData.BagItems[II].MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindAccountA, HumData.BagItems[II].MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindCharNameA, HumData.BagItems[II].MakeIndex, nItemMakeIdx);
            //SetItemBindMakeIdx(m_ItemDblClickListA, HumData.BagItems[II].MakeIndex, nItemMakeIdx);
            SetRememberItemList(m_RememberItemListA, HumData.HumItems[II].MakeIndex, nItemMakeIdx);
          end else begin
            SetItemBindMakeIdx(m_ItemBindIPaddrB, HumData.BagItems[II].MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindAccountB, HumData.BagItems[II].MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindCharNameB, HumData.BagItems[II].MakeIndex, nItemMakeIdx);
            //SetItemBindMakeIdx(m_ItemDblClickListB, HumData.BagItems[II].MakeIndex, nItemMakeIdx);
            SetRememberItemList(m_RememberItemListB, HumData.HumItems[II].MakeIndex, nItemMakeIdx);
          end;
          HumData.BagItems[II].MakeIndex := nItemMakeIdx;
        end;
      end;
      for II := Low(HumData.StorageItems) to High(HumData.StorageItems) do begin
        if HumData.StorageItems[II].wIndex > 0 then begin
          if HumData.StorageItems[II].MakeIndex < High(Integer) div 2 then begin
            nItemMakeIdx := GetItemNumber;
          end else begin
            nItemMakeIdx := GetItemNumberEx;
          end;
          if QuickList = m_FileDBA.m_MirCharNameList then begin
            SetItemBindMakeIdx(m_ItemBindIPaddrA, HumData.StorageItems[II].MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindAccountA, HumData.StorageItems[II].MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindCharNameA, HumData.StorageItems[II].MakeIndex, nItemMakeIdx);
            //SetItemBindMakeIdx(m_ItemDblClickListA, HumData.StorageItems[II].MakeIndex, nItemMakeIdx);
            SetRememberItemList(m_RememberItemListA, HumData.HumItems[II].MakeIndex, nItemMakeIdx);
          end else begin
            SetItemBindMakeIdx(m_ItemBindIPaddrB, HumData.StorageItems[II].MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindAccountB, HumData.StorageItems[II].MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindCharNameB, HumData.StorageItems[II].MakeIndex, nItemMakeIdx);
            //SetItemBindMakeIdx(m_ItemDblClickListB, HumData.StorageItems[II].MakeIndex, nItemMakeIdx);
            SetRememberItemList(m_RememberItemListB, HumData.HumItems[II].MakeIndex, nItemMakeIdx);
          end;
          HumData.StorageItems[II].MakeIndex := nItemMakeIdx;
        end;
      end;
      Application.ProcessMessages;
    end;
  end;

  procedure ClearCopyItems(QuickList: TQuickList);
    procedure ClearCopyHumItems(HumData: pTHumData; nIndex, nMakeIndex: Integer);
    var
      I: Integer;
    begin
      for I := Low(HumData.HumItems) to High(HumData.HumItems) do begin
        if (HumData.HumItems[I].wIndex > 0) and (nIndex <> I) and (HumData.HumItems[I].MakeIndex = nMakeIndex) then begin
          HumData.HumItems[I].wIndex := 0;
        end;
      end;
    end;

    procedure ClearCopyHumAddItems(HumData: pTHumData; nIndex, nMakeIndex: Integer);
    var
      I: Integer;
    begin
      for I := Low(HumData.HumAddItems) to High(HumData.HumAddItems) do begin
        if (HumData.HumAddItems[I].wIndex > 0) and (nIndex <> I) and (HumData.HumAddItems[I].MakeIndex = nMakeIndex) then begin
          HumData.HumAddItems[I].wIndex := 0;
        end;
      end;
    end;

    procedure ClearCopyBagItems(HumData: pTHumData; nIndex, nMakeIndex: Integer);
    var
      I: Integer;
    begin
      for I := Low(HumData.BagItems) to High(HumData.BagItems) do begin
        if (HumData.BagItems[I].wIndex > 0) and (nIndex <> I) and (HumData.BagItems[I].MakeIndex = nMakeIndex) then begin
          HumData.BagItems[I].wIndex := 0;
        end;
      end;
    end;

    procedure ClearCopyStorageItems(HumData: pTHumData; nIndex, nMakeIndex: Integer);
    var
      I: Integer;
    begin
      for I := Low(HumData.StorageItems) to High(HumData.StorageItems) do begin
        if (HumData.StorageItems[I].wIndex > 0) and (nIndex <> I) and (HumData.StorageItems[I].MakeIndex = nMakeIndex) then begin
          HumData.StorageItems[I].wIndex := 0;
        end;
      end;
    end;

    procedure AddStorageCopyItems(sName: string; QuickIDList: TQuickIDList; ItemList: TList);
    var
      I: Integer;
      List: TList;
      StorageRecord: pTBigStorage;
    begin
      List := nil;
      if (QuickIDList.GetList(sName, List) < 0) or (List = nil) then Exit;
      for I := 0 to List.Count - 1 do begin
        StorageRecord := pTBigStorage(List.Items[I]);
        if StorageRecord.UseItems.wIndex > 0 then begin
          ItemList.Add(@(StorageRecord.UseItems));
        end;
      end;
    end;

    procedure AddSellOffCopyItems(sName: string; QuickIDList: TQuickIDList; ItemList: TList);
    var
      I: Integer;
      List: TList;
      SellOffInfo: pTSellOffInfo;
    begin
      List := nil;
      if (QuickIDList.GetList(sName, List) < 0) or (List = nil) then Exit;
      for I := 0 to List.Count - 1 do begin
        SellOffInfo := pTSellOffInfo(List.Items[I]);
        if SellOffInfo.UseItems.wIndex > 0 then begin
          ItemList.Add(@(SellOffInfo.UseItems));
        end;
      end;
    end;

    procedure AddDuelItemCopyItems(sName: string; QuickIDList: TQuickIDList; ItemList: TList);
    var
      I, II: Integer;
      List: TList;
      DuelItem: pTDuelItem;
    begin
      List := nil;
      for I := 0 to QuickIDList.Count - 1 do begin
        List := TList(QuickIDList.Objects[I]);
        for II := 0 to List.Count - 1 do begin
          DuelItem := pTDuelItem(List.Items[II]);
          if not DuelItem.boDelete then begin
            if DuelItem.UseItem.wIndex > 0 then begin
              ItemList.Add(@(DuelItem.UseItem));
            end;
          end;
        end;
      end;

     { if (QuickIDList.GetList(sName, List) < 0) or (List = nil) then Exit;
      for I := 0 to List.Count - 1 do begin
        DuelItem := pTDuelItem(List.Items[I]);
        if DuelItem.UseItem.wIndex > 0 then begin
          ItemList.Add(@(DuelItem.UseItem));
        end;
      end; }
    end;

  var
    I, II, III: Integer;
    HumDataInfo: pTHumDataInfo;
    HumData: pTHumData;
    ItemList: TList;
    UserItem, UserItem01: pTUserItem;
  begin
    m_nPercent := 0;
    m_nCount := QuickList.Count;
    ItemList := TList.Create;

    for I := 0 to QuickList.Count - 1 do begin
      if g_boClose then Break;
      ProcessStatus();
      HumDataInfo := pTHumDataInfo(QuickList.Objects[I]);
      HumData := @HumDataInfo.Data;
      ItemList.Clear;

      for II := Low(HumData.HumItems) to High(HumData.HumItems) do begin
        if HumData.HumItems[II].wIndex > 0 then begin
          ItemList.Add(@(HumData.HumItems[II]));
        end;
      end;
      for II := Low(HumData.HumAddItems) to High(HumData.HumAddItems) do begin
        if HumData.HumAddItems[II].wIndex > 0 then begin
          ItemList.Add(@(HumData.HumAddItems[II]));
        end;
      end;
      for II := Low(HumData.BagItems) to High(HumData.BagItems) do begin
        if HumData.BagItems[II].wIndex > 0 then begin
          ItemList.Add(@(HumData.BagItems[II]));
        end;
      end;
      for II := Low(HumData.StorageItems) to High(HumData.StorageItems) do begin
        if HumData.StorageItems[II].wIndex > 0 then begin
          ItemList.Add(@(HumData.StorageItems[II]));
        end;
      end;

      if m_FileDBA.m_MirCharNameList = QuickList then begin
        if g_boBigStorage then begin
          AddStorageCopyItems(HumDataInfo.Data.sChrName, m_StorageA.m_BigStorageList, ItemList);
        end;
        if g_boSellOff then begin
          AddSellOffCopyItems(HumDataInfo.Data.sChrName, m_SellOffA.m_SellOffList, ItemList);
        end;
        if g_boDuel then begin
          AddDuelItemCopyItems(HumDataInfo.Data.sChrName, m_DuelItemDBA.m_ItemList, ItemList);
        end;
      end else begin
        if g_boBigStorage then begin
          AddStorageCopyItems(HumDataInfo.Data.sChrName, m_StorageB.m_BigStorageList, ItemList);
        end;
        if g_boSellOff then begin
          AddSellOffCopyItems(HumDataInfo.Data.sChrName, m_SellOffB.m_SellOffList, ItemList);
        end;
        if g_boDuel then begin
          AddDuelItemCopyItems(HumDataInfo.Data.sChrName, m_DuelItemDBB.m_ItemList, ItemList);
        end;
      end;

      for II := 0 to ItemList.Count - 1 do begin
        UserItem := pTUserItem(ItemList.Items[II]);
        if UserItem.wIndex > 0 then begin
          for III := II + 1 to ItemList.Count - 1 do begin
            UserItem01 := pTUserItem(ItemList.Items[III]);
            if UserItem.MakeIndex = UserItem01.MakeIndex then UserItem01^.wIndex := 0;
          end;
        end;
      end;

      Application.ProcessMessages;
    end;
    ItemList.Free;
  end;

var
  I, II, III, nItemMakeIdx: Integer;
  HumDataInfo: pTHumDataInfo;
  ChrList: TList;
  StorageRecord: pTBigStorage;
  SellOffInfo: pTSellOffInfo;
  //DuelInfo: pTDuelInfo;
  DuelItem: pTDuelItem;
begin
  if g_boClose then Exit;
  if g_boCheckCopyItems then begin
    ProcessMessage('正在删除复制物品，请稍候...');
    ClearCopyItems(m_FileDBA.m_MirCharNameList);
    ClearCopyItems(m_FileDBB.m_MirCharNameList);
  end;

  ProcessMessage('正在设置物品ID编号，请稍候...');
  if g_boSetItemMakeIndex then begin
    g_nMaxItemMakeIndex := 0;
    g_nMaxItemMakeIndexEx := High(Integer) div 2 - 1;
    SetMirDBItemNumber(m_FileDBA.m_MirCharNameList);
  end;
  SetMirDBItemNumber(m_FileDBB.m_MirCharNameList);

  if g_boBigStorage then begin
    if g_boSetItemMakeIndex then begin
      m_nPercent := 0;
      m_nCount := m_StorageA.m_BigStorageList.Count;
      for I := 0 to m_StorageA.m_BigStorageList.Count - 1 do begin
        if g_boClose then Break;
        ProcessStatus();
        ChrList := TList(m_StorageA.m_BigStorageList.Objects[I]);
        for II := 0 to ChrList.Count - 1 do begin
          StorageRecord := pTBigStorage(ChrList.Items[II]);
          if StorageRecord.UseItems.wIndex > 0 then begin
            if StorageRecord.UseItems.MakeIndex < High(Integer) div 2 then begin
              nItemMakeIdx := GetItemNumber;
              SetItemBindMakeIdx(m_ItemBindIPaddrA, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
              SetItemBindMakeIdx(m_ItemBindAccountA, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
              SetItemBindMakeIdx(m_ItemBindCharNameA, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
              //SetItemBindMakeIdx(m_ItemDblClickListA, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
              SetRememberItemList(m_RememberItemListA, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
              StorageRecord.UseItems.MakeIndex := nItemMakeIdx;
            end else begin
              nItemMakeIdx := GetItemNumberEx;
              SetItemBindMakeIdx(m_ItemBindIPaddrA, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
              SetItemBindMakeIdx(m_ItemBindAccountA, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
              SetItemBindMakeIdx(m_ItemBindCharNameA, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
              //SetItemBindMakeIdx(m_ItemDblClickListA, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
              SetRememberItemList(m_RememberItemListA, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
              StorageRecord.UseItems.MakeIndex := nItemMakeIdx;
            end;
          end;
        end;
      end;
    end;
    m_nPercent := 0;
    m_nCount := m_StorageB.m_BigStorageList.Count;
    for I := 0 to m_StorageB.m_BigStorageList.Count - 1 do begin
      if g_boClose then Break;
      ProcessStatus();
      ChrList := TList(m_StorageB.m_BigStorageList.Objects[I]);
      for II := 0 to ChrList.Count - 1 do begin
        StorageRecord := pTBigStorage(ChrList.Items[II]);
        if StorageRecord.UseItems.wIndex > 0 then begin
          if StorageRecord.UseItems.MakeIndex < High(Integer) div 2 then begin
            nItemMakeIdx := GetItemNumber;
            SetItemBindMakeIdx(m_ItemBindIPaddrB, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindAccountB, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindCharNameB, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
            //SetItemBindMakeIdx(m_ItemDblClickListB, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
            SetRememberItemList(m_RememberItemListB, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
            StorageRecord.UseItems.MakeIndex := nItemMakeIdx;
          end else begin
            nItemMakeIdx := GetItemNumberEx;
            SetItemBindMakeIdx(m_ItemBindIPaddrB, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindAccountB, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindCharNameB, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
            //SetItemBindMakeIdx(m_ItemDblClickListB, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
            SetRememberItemList(m_RememberItemListB, StorageRecord.UseItems.MakeIndex, nItemMakeIdx);
            StorageRecord.UseItems.MakeIndex := nItemMakeIdx;
          end;
        end;
      end;
    end;
  end;

  if g_boSellOff then begin
    if g_boSetItemMakeIndex then begin
      m_nPercent := 0;
      m_nCount := m_SellOffA.m_SellOffList.Count;
      for I := 0 to m_SellOffA.m_SellOffList.Count - 1 do begin
        if g_boClose then Break;
        ProcessStatus();
        ChrList := TList(m_SellOffA.m_SellOffList.Objects[I]);
        for II := 0 to ChrList.Count - 1 do begin
          SellOffInfo := pTSellOffInfo(ChrList.Items[II]);
          if SellOffInfo.UseItems.wIndex > 0 then begin
            if SellOffInfo.UseItems.MakeIndex < High(Integer) div 2 then begin
              nItemMakeIdx := GetItemNumber;
              SetItemBindMakeIdx(m_ItemBindIPaddrA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              SetItemBindMakeIdx(m_ItemBindAccountA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              SetItemBindMakeIdx(m_ItemBindCharNameA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              //SetItemBindMakeIdx(m_ItemDblClickListA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              SetRememberItemList(m_RememberItemListA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              SellOffInfo.UseItems.MakeIndex := nItemMakeIdx;
            end else begin
              nItemMakeIdx := GetItemNumberEx;
              SetItemBindMakeIdx(m_ItemBindIPaddrA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              SetItemBindMakeIdx(m_ItemBindAccountA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              SetItemBindMakeIdx(m_ItemBindCharNameA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              //SetItemBindMakeIdx(m_ItemDblClickListA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              SetRememberItemList(m_RememberItemListA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              SellOffInfo.UseItems.MakeIndex := nItemMakeIdx;
            end;
          end;
        end;
      end;

      m_nPercent := 0;
      m_nCount := m_SellGoldA.m_SellOffList.Count;
      for I := 0 to m_SellGoldA.m_SellOffList.Count - 1 do begin
        if g_boClose then Break;
        ProcessStatus();
        ChrList := TList(m_SellGoldA.m_SellOffList.Objects[I]);
        for II := 0 to ChrList.Count - 1 do begin
          SellOffInfo := pTSellOffInfo(ChrList.Items[II]);
          if SellOffInfo.UseItems.wIndex > 0 then begin
            if SellOffInfo.UseItems.MakeIndex < High(Integer) div 2 then
              SellOffInfo.UseItems.MakeIndex := GetItemNumber
            else SellOffInfo.UseItems.MakeIndex := GetItemNumberEx;
          end;
        end;
        //Application.ProcessMessages;
      end;
    end;

    m_nPercent := 0;
    m_nCount := m_SellOffB.m_SellOffList.Count;
    for I := 0 to m_SellOffB.m_SellOffList.Count - 1 do begin
      if g_boClose then Break;
      ProcessStatus();
      ChrList := TList(m_SellOffB.m_SellOffList.Objects[I]);
      for II := 0 to ChrList.Count - 1 do begin
        SellOffInfo := pTSellOffInfo(ChrList.Items[II]);
        if SellOffInfo.UseItems.wIndex > 0 then begin
          if SellOffInfo.UseItems.MakeIndex < High(Integer) div 2 then begin
            nItemMakeIdx := GetItemNumber;
            SetItemBindMakeIdx(m_ItemBindIPaddrB, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindAccountB, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindCharNameB, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            //SetItemBindMakeIdx(m_ItemDblClickListB, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            SetRememberItemList(m_RememberItemListB, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            SellOffInfo.UseItems.MakeIndex := nItemMakeIdx;
          end else begin
            nItemMakeIdx := GetItemNumberEx;
            SetItemBindMakeIdx(m_ItemBindIPaddrB, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindAccountB, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindCharNameB, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            //SetItemBindMakeIdx(m_ItemDblClickListB, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            SetRememberItemList(m_RememberItemListB, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            SellOffInfo.UseItems.MakeIndex := nItemMakeIdx;
          end;
        end;
      end;
    end;

    m_nPercent := 0;
    m_nCount := m_SellGoldB.m_SellOffList.Count;
    for I := 0 to m_SellGoldB.m_SellOffList.Count - 1 do begin
      if g_boClose then Break;
      ProcessStatus();
      ChrList := TList(m_SellGoldB.m_SellOffList.Objects[I]);
      for II := 0 to ChrList.Count - 1 do begin
        SellOffInfo := pTSellOffInfo(ChrList.Items[II]);
        if SellOffInfo.UseItems.wIndex > 0 then begin
          if SellOffInfo.UseItems.MakeIndex < High(Integer) div 2 then
            SellOffInfo.UseItems.MakeIndex := GetItemNumber
          else SellOffInfo.UseItems.MakeIndex := GetItemNumberEx;
        end;
      end;
      //Application.ProcessMessages;
    end;
  end;

  if g_boDuel then begin
    if g_boSetItemMakeIndex then begin
      m_nPercent := 0;
      m_nCount := m_DuelItemDBA.m_ItemList.Count;
      for I := 0 to m_DuelItemDBA.m_ItemList.Count - 1 do begin
        if g_boClose then Break;
        ProcessStatus();
        ChrList := TList(m_DuelItemDBA.m_ItemList.Objects[I]);
        for II := 0 to ChrList.Count - 1 do begin
          DuelItem := pTDuelItem(ChrList.Items[II]);
          if DuelItem.UseItem.wIndex > 0 then begin
            if DuelItem.UseItem.MakeIndex < High(Integer) div 2 then begin
              nItemMakeIdx := GetItemNumber;
              SetItemBindMakeIdx(m_ItemBindIPaddrA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              SetItemBindMakeIdx(m_ItemBindAccountA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              SetItemBindMakeIdx(m_ItemBindCharNameA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              //SetItemBindMakeIdx(m_ItemDblClickListA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              SetRememberItemList(m_RememberItemListA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              DuelItem.UseItem.MakeIndex := nItemMakeIdx;
            end else begin
              nItemMakeIdx := GetItemNumberEx;
              SetItemBindMakeIdx(m_ItemBindIPaddrA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              SetItemBindMakeIdx(m_ItemBindAccountA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              SetItemBindMakeIdx(m_ItemBindCharNameA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              //SetItemBindMakeIdx(m_ItemDblClickListA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              SetRememberItemList(m_RememberItemListB, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
              DuelItem.UseItem.MakeIndex := nItemMakeIdx;
            end;
          end;
        end;
      end;
    end;

    m_nPercent := 0;
    m_nCount := m_DuelItemDBB.m_ItemList.Count;
    for I := 0 to m_DuelItemDBB.m_ItemList.Count - 1 do begin
      if g_boClose then Break;
      ProcessStatus();
      ChrList := TList(m_DuelItemDBB.m_ItemList.Objects[I]);
      for II := 0 to ChrList.Count - 1 do begin
        DuelItem := pTDuelItem(ChrList.Items[II]);
        if DuelItem.UseItem.wIndex > 0 then begin
          if DuelItem.UseItem.MakeIndex < High(Integer) div 2 then begin
            nItemMakeIdx := GetItemNumber;
            SetItemBindMakeIdx(m_ItemBindIPaddrA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindAccountA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindCharNameA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            //SetItemBindMakeIdx(m_ItemDblClickListA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            SetRememberItemList(m_RememberItemListA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            DuelItem.UseItem.MakeIndex := nItemMakeIdx;
          end else begin
            nItemMakeIdx := GetItemNumberEx;
            SetItemBindMakeIdx(m_ItemBindIPaddrA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindAccountA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            SetItemBindMakeIdx(m_ItemBindCharNameA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            //SetItemBindMakeIdx(m_ItemDblClickListA, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            SetRememberItemList(m_RememberItemListB, SellOffInfo.UseItems.MakeIndex, nItemMakeIdx);
            DuelItem.UseItem.MakeIndex := nItemMakeIdx;
          end;
        end;
      end;
    end;
  end;
end;

function TBlendThread._Copy(sSrc: string; nLen: Integer): string;
begin
  Result := sSrc;
  if Length(sSrc) >= nLen then begin
    if ByteType(sSrc, nLen) = mbTrailByte then begin //汉字的第二个字节
      Result := Copy(sSrc, 1, nLen);
    end else
      if ByteType(sSrc, nLen) = mbLeadByte then begin //汉字的第一个字节
      Result := Copy(sSrc, 1, nLen - 1);
    end else begin
      Result := Copy(sSrc, 1, nLen);
    end;
  end;
end;

procedure TBlendThread.BlendIDDBList();
  function IsHaveRcd(IDDBList: TQuickList; sAccount: string): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to IDDBList.Count - 1 do begin
      if CompareText(IDDBList.Strings[I], sAccount) = 0 then begin
        Result := True;
        Break;
      end;
    end;
  end;

  function GetNewAccount(IDDBList: TQuickList; sAccount: string; var sNewAccount: string): Boolean;
  var
    I, II, III, IIII, IIIII, IIIIII: Integer;
    sOldAccount: string;
  begin
    Result := True;
    sNewAccount := sAccount;
    if IsHaveRcd(IDDBList, sAccount) then begin
      Result := False;

      sOldAccount := _Copy(sAccount, 9);
      for I := 97 to 122 do begin
        sNewAccount := sOldAccount + Chr(I);
        if not IsHaveRcd(IDDBList, sNewAccount) then begin
          Result := True;
          Exit;
        end;
      end;


      sOldAccount := _Copy(sAccount, 8);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          sNewAccount := sOldAccount + Chr(I) + Chr(II);
          if not IsHaveRcd(IDDBList, sNewAccount) then begin
            Result := True;
            Exit;
          end;
        end;
      end;


      sOldAccount := _Copy(sAccount, 7);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            sNewAccount := sOldAccount + Chr(I) + Chr(II) + Chr(III);
            if not IsHaveRcd(IDDBList, sNewAccount) then begin
              Result := True;
              Exit;
            end;
          end;
        end;
      end;


      sOldAccount := _Copy(sAccount, 6);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              sNewAccount := sOldAccount + Chr(I) + Chr(II) + Chr(III) + Chr(IIII);
              if not IsHaveRcd(IDDBList, sNewAccount) then begin
                Result := True;
                Exit;
              end;
            end;
          end;
        end;
      end;


      sOldAccount := _Copy(sAccount, 5);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              for IIIII := 97 to 122 do begin
                sNewAccount := sOldAccount + Chr(I) + Chr(II) + Chr(III) + Chr(IIII) + Chr(IIIII);
                if not IsHaveRcd(IDDBList, sNewAccount) then begin
                  Result := True;
                  Exit;
                end;
              end;
            end;
          end;
        end;
      end;


      sOldAccount := _Copy(sAccount, 4);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              for IIIII := 97 to 122 do begin
                for IIIIII := 97 to 122 do begin
                  sNewAccount := sOldAccount + Chr(I) + Chr(II) + Chr(III) + Chr(IIII) + Chr(IIIII) + Chr(IIIIII);
                  if not IsHaveRcd(IDDBList, sNewAccount) then begin
                    Result := True;
                    Exit;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;

    end;
  end;

var
  I, II: Integer;
  boFound: Boolean;
  sAccount: string;
  sOldAccount: string;
  sNewAccount: string;

  AccountDBRecord: pTAccountDBRecord;
  List: TList;
begin
  if g_boClose then Exit;
  if g_boClearID2 then begin
    ProcessMessage('正删除没有角色的账号，请稍候...');
    m_nPercent := 0;
    m_nCount := m_FileIDDBA.m_IDDBList.Count;
    for I := m_FileIDDBA.m_IDDBList.Count - 1 downto 0 do begin
      if g_boClose then Break;
      ProcessStatus();
      boFound := False;
      for II := 0 to m_FileHumDBA.m_HumDBList.Count - 1 do begin
        if CompareText(m_FileIDDBA.m_IDDBList.Strings[I], m_FileHumDBA.m_HumDBList.Strings[II]) = 0 then begin
          boFound := True;
          Break;
        end;
      end;
      if not boFound then begin
        Dispose(pTAccountDBRecord(m_FileIDDBA.m_IDDBList.Objects[I]));
        m_FileIDDBA.m_IDDBList.Delete(I);
      end;
    end;

    m_nPercent := 0;
    m_nCount := m_FileIDDBB.m_IDDBList.Count;
    for I := m_FileIDDBB.m_IDDBList.Count - 1 downto 0 do begin
      if g_boClose then Break;
      ProcessStatus();
      boFound := False;
      for II := 0 to m_FileHumDBB.m_HumDBList.Count - 1 do begin
        if CompareText(m_FileIDDBB.m_IDDBList.Strings[I], m_FileHumDBB.m_HumDBList.Strings[II]) = 0 then begin
          boFound := True;
          Break;
        end;
      end;
      if not boFound then begin
        Dispose(pTAccountDBRecord(m_FileIDDBB.m_IDDBList.Objects[I]));
        m_FileIDDBB.m_IDDBList.Delete(I);
      end;
    end;

  end;

  ProcessMessage('正在合并ID.DB数据库，请稍候...');
  m_nPercent := 0;
  m_nCount := m_FileIDDBA.m_IDDBList.Count;
  for I := 0 to m_FileIDDBA.m_IDDBList.Count - 1 do begin //搜索m_FileIDDBA自己有没有重复的账号
    for II := I + 1 to m_FileIDDBA.m_IDDBList.Count - 2 do begin
      if CompareText(m_FileIDDBA.m_IDDBList.Strings[I], m_FileIDDBA.m_IDDBList.Strings[II]) = 0 then begin
        sAccount := m_FileIDDBA.m_IDDBList.Strings[II];
        AccountDBRecord := pTAccountDBRecord(m_FileIDDBA.m_IDDBList.Objects[II]);
        sNewAccount := sAccount;
        if GetNewAccount(m_FileIDDBA.m_IDDBList, sAccount, sNewAccount) then begin
          m_FileIDDBA.m_IDDBList.Strings[II] := sNewAccount;
          AccountDBRecord.Header.sAccount := sNewAccount;
          AccountDBRecord.UserEntry.sAccount := sNewAccount;
          _UpdataAccount(sAccount, sNewAccount);
          g_LogIDList.Add(sAccount + '=>' + sNewAccount);
        end;
      end;
    end;
    ProcessStatus();
    Application.ProcessMessages;
  end;

  ProcessMessage('正在合并ID.DB数据库，请稍候...');
  m_nPercent := 0;
  m_nCount := m_FileIDDBB.m_IDDBList.Count;
  for I := 0 to m_FileIDDBB.m_IDDBList.Count - 1 do begin //搜索m_FileIDDBB自己有没有重复的账号
    for II := I + 1 to m_FileIDDBB.m_IDDBList.Count - 2 do begin
      if CompareText(m_FileIDDBB.m_IDDBList.Strings[I], m_FileIDDBB.m_IDDBList.Strings[II]) = 0 then begin
        sAccount := m_FileIDDBB.m_IDDBList.Strings[II];
        AccountDBRecord := pTAccountDBRecord(m_FileIDDBB.m_IDDBList.Objects[II]);
        sNewAccount := sAccount;
        if GetNewAccount(m_FileIDDBB.m_IDDBList, sAccount, sNewAccount) then begin
          m_FileIDDBB.m_IDDBList.Strings[II] := sNewAccount;
          AccountDBRecord.Header.sAccount := sNewAccount;
          AccountDBRecord.UserEntry.sAccount := sNewAccount;
          UpdataAccount(sAccount, sNewAccount);
          g_LogIDList.Add(sAccount + '=>' + sNewAccount);
        end;
      end;
    end;
    ProcessStatus();
    Application.ProcessMessages;
  end;

  ProcessMessage('正在合并ID.DB数据库，请稍候...');
  m_nPercent := 0;
  m_nCount := m_FileIDDBB.m_IDDBList.Count;
  while True do begin
    if m_FileIDDBB.m_IDDBList.Count <= 0 then Break;
    if g_boClose then Break;
    sAccount := m_FileIDDBB.m_IDDBList.Strings[0];
    AccountDBRecord := pTAccountDBRecord(m_FileIDDBB.m_IDDBList.Objects[0]);
    sNewAccount := sAccount;
    if IsHaveRcd(m_FileIDDBA.m_IDDBList, sAccount) then begin
      if GetNewAccount(m_FileIDDBA.m_IDDBList, sAccount, sNewAccount) then begin
        AccountDBRecord.Header.sAccount := sNewAccount;
        AccountDBRecord.UserEntry.sAccount := sNewAccount;
        UpdataAccount(sAccount, sNewAccount);
        g_LogIDList.Add(sAccount + '=>' + sNewAccount);
      end;
    end;
    m_FileIDDBB.m_IDDBList.Delete(0);
    m_FileIDDBA.m_IDDBList.AddObject(sNewAccount, TObject(AccountDBRecord));
    ProcessStatus();
    Application.ProcessMessages;
  end;
  ProcessMessage('正在排序，请稍候...');
  m_FileIDDBA.m_IDDBList.SortString(0, m_FileIDDBA.m_IDDBList.Count - 1);
{
  for I := 0 to m_FileIDDBA.m_IDDBList.Count - 1 do begin
    for II := I + 1 to m_FileIDDBA.m_IDDBList.Count - 2 do begin
      if UpperCase(m_FileIDDBA.m_IDDBList.Strings[I]) = UpperCase(m_FileIDDBA.m_IDDBList.Strings[II]) then begin
        g_TestList.Add(m_FileIDDBA.m_IDDBList.Strings[I]);
      end;
    end;
  end;
  g_TestList.SaveToFile('IDTest.TXT');
}
end;

procedure TBlendThread.BlendHumDBList();
  function IsHaveRcd(HumCharNameList: TQuickList; sCharName: string): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to HumCharNameList.Count - 1 do begin
      if CompareText(HumCharNameList.Strings[I], sCharName) = 0 then begin
        Result := True;
        Break;
      end;
    end;
  end;

  function GetNewCharName(HumCharNameList: TQuickList; sCharName: string; var sNewCharName: string): Boolean;
  var
    I, II, III, IIII, IIIII, IIIIII, IIIIIII, IIIIIIII, IIIIIIIII, IIIIIIIIII: Integer;
    sOldCharName: string;
  begin
    Result := True;
    sNewCharName := sCharName;
    if IsHaveRcd(HumCharNameList, sCharName) then begin
      Result := False;
      sOldCharName := _Copy(sCharName, 13);
      for I := 97 to 122 do begin
        sNewCharName := sOldCharName + Chr(I);
        if not IsHaveRcd(HumCharNameList, sNewCharName) then begin
          Result := True;
          Exit;
        end;
      end;

      sOldCharName := _Copy(sCharName, 12);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          sNewCharName := sOldCharName + Chr(I) + Chr(II);
          if not IsHaveRcd(HumCharNameList, sNewCharName) then begin
            Result := True;
            Exit;
          end;
        end;
      end;

      sOldCharName := _Copy(sCharName, 11);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            sNewCharName := sOldCharName + Chr(I) + Chr(II) + Chr(III);
            if not IsHaveRcd(HumCharNameList, sNewCharName) then begin
              Result := True;
              Exit;
            end;
          end;
        end;
      end;

      sOldCharName := _Copy(sCharName, 10);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              sNewCharName := sOldCharName + Chr(I) + Chr(II) + Chr(III) + Chr(IIII);
              if not IsHaveRcd(HumCharNameList, sNewCharName) then begin
                Result := True;
                Exit;
              end;
            end;
          end;
        end;
      end;

      sOldCharName := _Copy(sCharName, 9);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              for IIIII := 97 to 122 do begin
                sNewCharName := sOldCharName + Chr(I) + Chr(II) + Chr(III) + Chr(IIII) + Chr(IIIII);
                if not IsHaveRcd(HumCharNameList, sNewCharName) then begin
                  Result := True;
                  Exit;
                end;
              end;
            end;
          end;
        end;
      end;

      sOldCharName := _Copy(sCharName, 8);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              for IIIII := 97 to 122 do begin
                for IIIIII := 97 to 122 do begin
                  sNewCharName := sOldCharName + Chr(I) + Chr(II) + Chr(III) + Chr(IIII) + Chr(IIIII) + Chr(IIIIII);
                  if not IsHaveRcd(HumCharNameList, sNewCharName) then begin
                    Result := True;
                    Exit;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;

      sOldCharName := _Copy(sCharName, 7);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              for IIIII := 97 to 122 do begin
                for IIIIII := 97 to 122 do begin
                  for IIIIIII := 97 to 122 do begin
                    sNewCharName := sOldCharName + Chr(I) + Chr(II) + Chr(III) + Chr(IIII) + Chr(IIIII) + Chr(IIIIII) + Chr(IIIIIII);
                    if not IsHaveRcd(HumCharNameList, sNewCharName) then begin
                      Result := True;
                      Exit;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;

      sOldCharName := _Copy(sCharName, 6);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              for IIIII := 97 to 122 do begin
                for IIIIII := 97 to 122 do begin
                  for IIIIIII := 97 to 122 do begin
                    for IIIIIIII := 97 to 122 do begin
                      sNewCharName := sOldCharName + Chr(I) + Chr(II) + Chr(III) + Chr(IIII) + Chr(IIIII) + Chr(IIIIII) + Chr(IIIIIII) + Chr(IIIIIIII);
                      if not IsHaveRcd(HumCharNameList, sNewCharName) then begin
                        Result := True;
                        Exit;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;

      sOldCharName := _Copy(sCharName, 5);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              for IIIII := 97 to 122 do begin
                for IIIIII := 97 to 122 do begin
                  for IIIIIII := 97 to 122 do begin
                    for IIIIIIII := 97 to 122 do begin
                      for IIIIIIIII := 97 to 122 do begin
                        sNewCharName := sOldCharName + Chr(I) + Chr(II) + Chr(III) + Chr(IIII) + Chr(IIIII) + Chr(IIIIII) + Chr(IIIIIII) + Chr(IIIIIIII) + Chr(IIIIIIIII);
                        if not IsHaveRcd(HumCharNameList, sNewCharName) then begin
                          Result := True;
                          Exit;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;

      sOldCharName := _Copy(sCharName, 4);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              for IIIII := 97 to 122 do begin
                for IIIIII := 97 to 122 do begin
                  for IIIIIII := 97 to 122 do begin
                    for IIIIIIII := 97 to 122 do begin
                      for IIIIIIIII := 97 to 122 do begin
                        for IIIIIIIIII := 97 to 122 do begin
                          sNewCharName := sOldCharName + Chr(I) + Chr(II) + Chr(III) +
                            Chr(IIII) + Chr(IIIII) + Chr(IIIIII) + Chr(IIIIIII) + Chr(IIIIIIII) + Chr(IIIIIIIII) + Chr(IIIIIIIIII);
                          if not IsHaveRcd(HumCharNameList, sNewCharName) then begin
                            Result := True;
                            Exit;
                          end;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

var
  I, II, III, nIndex, nIndex1: Integer;
  nPercent, nCount: Integer;
  sCharName: string;
  sOldCharName: string;
  sNewCharName: string;
  HumRecord: pTHumInfo;
  HumanRCD: pTHumDataInfo;

  HumDataInfo: pTHumDataInfo;
  MasterDataInfo: pTHumDataInfo;
  HeroDataInfo: pTHumDataInfo;
  HumCharNameList: TStringList;

  boFind: Boolean;
begin
  if g_boClose then Exit;
  //g_LogHumList.Add('m_FileHumDBA.m_HumCharNameList.Count:' + IntToStr(m_FileHumDBA.m_HumCharNameList.Count));
  //g_LogHumList.Add('m_FileHumDBB.m_HumCharNameList.Count:' + IntToStr(m_FileHumDBB.m_HumCharNameList.Count));

//------------------------------------------------------------------------------
  m_nPercent := 0;
  m_nCount := m_FileHumDBA.m_HumCharNameList.Count;
  ProcessMessage('正在合并Hum.DB数据库，请稍候...');

  for I := 0 to m_FileHumDBA.m_HumCharNameList.Count - 1 do begin
    for II := I + 1 to m_FileHumDBA.m_HumCharNameList.Count - 2 do begin
      if CompareText(m_FileHumDBA.m_HumCharNameList.Strings[I], m_FileHumDBA.m_HumCharNameList.Strings[II]) = 0 then begin
        HumRecord := pTHumInfo(m_FileHumDBA.m_HumCharNameList.Objects[II]);
        sCharName := m_FileHumDBA.m_HumCharNameList.Strings[II];
        sNewCharName := sCharName;
        if GetNewCharName(m_FileHumDBA.m_HumCharNameList, sCharName, sNewCharName) then begin
          m_FileHumDBA.m_HumCharNameList.Strings[II] := sNewCharName;
          _UpdataCharName(sCharName, sNewCharName);
          HumRecord.sChrName := sNewCharName;
          HumRecord.Header.sName := sNewCharName;
          g_LogHumList.Add(sCharName + '=>' + sNewCharName);
        end;
      end;
    end;
    ProcessStatus();
    Application.ProcessMessages;
  end;
//------------------------------------------------------------------------------
  m_nPercent := 0;
  m_nCount := m_FileHumDBB.m_HumCharNameList.Count;
  ProcessMessage('正在合并Hum.DB数据库，请稍候...');
  for I := 0 to m_FileHumDBB.m_HumCharNameList.Count - 1 do begin
    for II := I + 1 to m_FileHumDBB.m_HumCharNameList.Count - 1 do begin
      if CompareText(m_FileHumDBB.m_HumCharNameList.Strings[I], m_FileHumDBB.m_HumCharNameList.Strings[II]) = 0 then begin
        HumRecord := pTHumInfo(m_FileHumDBB.m_HumCharNameList.Objects[II]);
        sCharName := m_FileHumDBB.m_HumCharNameList.Strings[II];
        sNewCharName := sCharName;
        if GetNewCharName(m_FileHumDBB.m_HumCharNameList, sCharName, sNewCharName) then begin
          m_FileHumDBB.m_HumCharNameList.Strings[II] := sNewCharName;
          UpdataCharName(sCharName, sNewCharName);
          HumRecord.sChrName := sNewCharName;
          HumRecord.Header.sName := sNewCharName;
          g_LogHumList.Add(sCharName + '=>' + sNewCharName);
        end;
      end;
    end;
    ProcessStatus();
    Application.ProcessMessages;
  end;

  if g_boClearHum3 then begin
    ProcessMessage('正在删除无数据的角色，请稍候...');
    m_nPercent := 0;
    m_nCount := m_FileHumDBA.m_HumCharNameList.Count;
    for nIndex := m_FileHumDBA.m_HumCharNameList.Count - 1 downto 0 do begin
      if g_boClose then Break;

      for II := 0 to m_FileDBA.m_MirCharNameList.Count - 1 do begin
        if CompareText(m_FileDBA.m_MirCharNameList.Strings[II], m_FileHumDBA.m_HumCharNameList.Strings[nIndex]) = 0 then begin
          boFind := True;
          Break;
        end;
      end;
      //boFind := m_FileDBA.m_MirCharNameList.GetIndex(m_FileHumDBA.m_HumCharNameList.Strings[nIndex]) >= 0;
      if not boFind then begin
        m_FileHumDBA.m_HumDBList.DelRecord(m_FileHumDBA.m_HumCharNameList.Objects[nIndex]);
        Dispose(pTHumInfo(m_FileHumDBA.m_HumCharNameList.Objects[nIndex]));
        m_FileHumDBA.m_HumCharNameList.Delete(nIndex);
      end;
      ProcessStatus();
    end;

    m_nPercent := 0;
    m_nCount := m_FileHumDBB.m_HumCharNameList.Count;
    for nIndex := m_FileHumDBB.m_HumCharNameList.Count - 1 downto 0 do begin
      if g_boClose then Break;
      boFind := False;
      for II := 0 to m_FileDBB.m_MirCharNameList.Count - 1 do begin
        if CompareText(m_FileDBB.m_MirCharNameList.Strings[II], m_FileHumDBB.m_HumCharNameList.Strings[nIndex]) = 0 then begin
          boFind := True;
          Break;
        end;
      end;
      if not boFind then begin
        m_FileHumDBB.m_HumDBList.DelRecord(m_FileHumDBB.m_HumCharNameList.Objects[nIndex]);
        Dispose(pTHumInfo(m_FileHumDBB.m_HumCharNameList.Objects[nIndex]));
        m_FileHumDBB.m_HumCharNameList.Delete(nIndex);
      end;
      ProcessStatus();
    end;
//------------------------------------------------------------------------------
    m_nPercent := 0;
    m_nCount := m_FileDBA.m_MirCharNameList.Count;
    for nIndex := m_FileDBA.m_MirCharNameList.Count - 1 downto 0 do begin
      if g_boClose then Break;
      boFind := False;
      for II := 0 to m_FileHumDBA.m_HumCharNameList.Count - 1 do begin
        if CompareText(m_FileHumDBA.m_HumCharNameList.Strings[II], m_FileDBA.m_MirCharNameList.Strings[nIndex]) = 0 then begin
          boFind := True;
          Break;
        end;
      end;
      if not boFind then begin

        with m_FileDBA do begin
          m_MasterList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
          m_DearList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
          m_HeroList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
          m_HeroNameList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
          m_MirDBList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
        end;

        Dispose(pTHumDataInfo(m_FileDBA.m_MirCharNameList.Objects[nIndex]));
        m_FileDBA.m_MirCharNameList.Delete(nIndex);
      end;
      ProcessStatus();
    end;

//------------------------------------------------------------------------------
    m_nPercent := 0;
    m_nCount := m_FileDBB.m_MirCharNameList.Count;
    for nIndex := m_FileDBB.m_MirCharNameList.Count - 1 downto 0 do begin
      if g_boClose then Break;
      boFind := False;
      for II := 0 to m_FileHumDBB.m_HumCharNameList.Count - 1 do begin
        if CompareText(m_FileHumDBB.m_HumCharNameList.Strings[II], m_FileDBB.m_MirCharNameList.Strings[nIndex]) = 0 then begin
          boFind := True;
          Break;
        end;
      end;
      if not boFind then begin
        with m_FileDBB do begin
          m_MasterList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
          m_DearList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
          m_HeroList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
          m_HeroNameList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
          m_MirDBList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
        end;
        Dispose(pTHumDataInfo(m_FileDBB.m_MirCharNameList.Objects[nIndex]));
        m_FileDBB.m_MirCharNameList.Delete(nIndex);
      end;
      ProcessStatus();
    end;
  end;
  //ProcessMessage('正在删除无数据的角色1，请稍候...');
//------------------------------------------------------------------------------
  for I := m_FileDBA.m_MirCharNameList.Count - 1 downto 0 do begin
    HumDataInfo := pTHumDataInfo(m_FileDBA.m_MirCharNameList.Objects[I]);
    {if Pos('nitian', HumDataInfo.Data.sAccount) > 0 then
      g_LogHumList.Add(Format('FileDBA sAccount:%s Header.boDeleted:%d Header.boIsHero:%d Header.sName:%s  Data.sChrName:%s  Data.sMasterName:%s  Data.sHeroChrName:%s Data.boIsHero:%d Data.boHasHero:%d',
        [HumDataInfo.Data.sAccount, Integer(HumDataInfo.Header.boDeleted), Integer(HumDataInfo.Header.boIsHero), HumDataInfo.Header.sName,
        HumDataInfo.Data.sChrName, HumDataInfo.Data.sMasterName, HumDataInfo.Data.sHeroChrName, Integer(HumDataInfo.Data.boIsHero), Integer(HumDataInfo.Data.boHasHero)]));
    }

    if HumDataInfo.Data.boIsHero then begin
      nIndex := m_FileDBA.m_MirCharNameList.GetIndex(HumDataInfo.Data.sMasterName);
      if nIndex < 0 then begin
        with m_FileDBA do begin
          m_MasterList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          m_DearList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          m_HeroList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          m_HeroNameList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          m_MirDBList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
        end;
        m_FileDBA.m_MirCharNameList.Delete(I);
        Dispose(HumDataInfo);
      end else begin
        MasterDataInfo := pTHumDataInfo(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
        HumDataInfo.Header.sName := HumDataInfo.Data.sChrName;
        HumDataInfo.Header.boIsHero := True;
        HumDataInfo.Data.boIsHero := True;
        HumDataInfo.Data.boHasHero := False;
        HumDataInfo.Data.sAccount := MasterDataInfo.Data.sAccount;
      end;
    end else begin
      if (HumDataInfo.Data.sHeroChrName <> '') then begin
        nIndex := m_FileDBA.m_MirCharNameList.GetIndex(HumDataInfo.Data.sHeroChrName);
        if (nIndex < 0) then begin
          HumDataInfo.Data.sHeroChrName := '';
          HumDataInfo.Data.boHasHero := False;
        end else begin
          HumDataInfo.Data.boHasHero := True;
          HumDataInfo.Header.sName := HumDataInfo.Data.sChrName;
        end;
      end else begin
        HumDataInfo.Data.sHeroChrName := '';
        HumDataInfo.Data.boHasHero := False;
      end;
    end;
  end;

  //m_FileDBA.m_MirCharNameList.SortString(0, m_FileDBA.m_MirCharNameList.Count - 1);
//------------------------------------------------------------------------------
  for I := m_FileDBB.m_MirCharNameList.Count - 1 downto 0 do begin
    HumDataInfo := pTHumDataInfo(m_FileDBB.m_MirCharNameList.Objects[I]);
   { if Pos('nitian', HumDataInfo.Data.sAccount) > 0 then
      g_LogHumList.Add(Format('FileDBB sAccount:%s Header.boDeleted:%d Header.boIsHero:%d Header.sName:%s  Data.sChrName:%s  Data.sMasterName:%s  Data.sHeroChrName:%s Data.boIsHero:%d Data.boHasHero:%d',
        [HumDataInfo.Data.sAccount, Integer(HumDataInfo.Header.boDeleted), Integer(HumDataInfo.Header.boIsHero), HumDataInfo.Header.sName,
        HumDataInfo.Data.sChrName, HumDataInfo.Data.sMasterName, HumDataInfo.Data.sHeroChrName, Integer(HumDataInfo.Data.boIsHero), Integer(HumDataInfo.Data.boHasHero)]));
    }
    if HumDataInfo.Data.boIsHero then begin
      nIndex := m_FileDBB.m_MirCharNameList.GetIndex(HumDataInfo.Data.sMasterName);
      if nIndex < 0 then begin
        with m_FileDBB do begin
          m_MasterList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          m_DearList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          m_HeroList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          m_HeroNameList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          m_MirDBList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
        end;
        m_FileDBB.m_MirCharNameList.Delete(I);
        Dispose(HumDataInfo);
      end else begin
        MasterDataInfo := pTHumDataInfo(m_FileDBB.m_MirCharNameList.Objects[nIndex]);
        HumDataInfo.Header.sName := HumDataInfo.Data.sChrName;
        HumDataInfo.Header.boIsHero := True;
        HumDataInfo.Data.boIsHero := True;
        HumDataInfo.Data.boHasHero := False;
        HumDataInfo.Data.sAccount := MasterDataInfo.Data.sAccount;
      end;
    end else begin
      if (HumDataInfo.Data.sHeroChrName <> '') then begin
        nIndex := m_FileDBB.m_MirCharNameList.GetIndex(HumDataInfo.Data.sHeroChrName);
        if (nIndex < 0) then begin
          HumDataInfo.Data.sHeroChrName := '';
          HumDataInfo.Data.boHasHero := False;
        end else begin
          HumDataInfo.Data.boHasHero := True;
        end;
      end else begin
        HumDataInfo.Data.sHeroChrName := '';
        HumDataInfo.Data.boHasHero := False;
      end;
    end;
  end;
  //m_FileDBB.m_MirCharNameList.SortString(0, m_FileDBB.m_MirCharNameList.Count - 1);


  m_FileDBA.m_MirDBList.SortString(0, m_FileDBA.m_MirDBList.Count - 1);
  m_FileDBA.m_DearList.SortString(0, m_FileDBA.m_DearList.Count - 1);
  m_FileDBA.m_MasterList.SortString(0, m_FileDBA.m_MasterList.Count - 1);
  m_FileDBA.m_HeroList.SortString(0, m_FileDBA.m_HeroList.Count - 1);
  m_FileDBA.m_HeroNameList.SortString(0, m_FileDBA.m_HeroNameList.Count - 1);
  m_FileDBA.m_MirCharNameList.SortString(0, m_FileDBA.m_MirCharNameList.Count - 1);

  m_FileDBB.m_MirDBList.SortString(0, m_FileDBB.m_MirDBList.Count - 1);
  m_FileDBB.m_DearList.SortString(0, m_FileDBB.m_DearList.Count - 1);
  m_FileDBB.m_MasterList.SortString(0, m_FileDBB.m_MasterList.Count - 1);
  m_FileDBB.m_HeroList.SortString(0, m_FileDBB.m_HeroList.Count - 1);
  m_FileDBB.m_HeroNameList.SortString(0, m_FileDBB.m_HeroNameList.Count - 1);
  m_FileDBB.m_MirCharNameList.SortString(0, m_FileDBB.m_MirCharNameList.Count - 1);

//------------------------------------------------------------------------------
  m_nPercent := 0;
  m_nCount := m_FileHumDBB.m_HumCharNameList.Count;
  ProcessMessage('正在合并Hum.DB数据库，请稍候...');
  while True do begin
    if m_FileHumDBB.m_HumCharNameList.Count <= 0 then Break;
    if g_boClose then Break;
    HumRecord := pTHumInfo(m_FileHumDBB.m_HumCharNameList.Objects[0]);
    sCharName := m_FileHumDBB.m_HumCharNameList.Strings[0];
    sNewCharName := sCharName;
    if IsHaveRcd(m_FileHumDBA.m_HumCharNameList, sNewCharName) then begin
      if GetNewCharName(m_FileHumDBA.m_HumCharNameList, sCharName, sNewCharName) then begin
        UpdataCharName(sCharName, sNewCharName);
        HumRecord.sChrName := sNewCharName;
        HumRecord.Header.sName := sNewCharName;
        g_LogHumList.Add(sCharName + '=>' + sNewCharName);
      end;
    end;
    m_FileHumDBA.m_HumCharNameList.AddObject(sNewCharName, TObject(HumRecord));
    m_FileHumDBB.m_HumCharNameList.Delete(0);
    ProcessStatus();
    Application.ProcessMessages;
  end;
  ProcessMessage('正在排序，请稍候...');
  m_FileHumDBA.m_HumCharNameList.SortString(0, m_FileHumDBA.m_HumCharNameList.Count - 1);
end;

function NumberSort_2(List: TStringList; Index1, Index2: Integer): Integer;
var
  Value1, Value2: Integer;
begin
  Result := 0;
  try
    Value1 := StrToInt(List[Index1]);
    Value2 := StrToInt(List[Index2]);
    if Value1 > Value2 then
      Result := 1
    else if Value1 < Value2 then
      Result := -1
    else
      Result := 0;
  except
  end;
end;

procedure TBlendThread.BlendMirDBList();
var
  I, II, nIndex, nIndex1, nCharCount, nHeroCount: Integer;
  ChrList: TList;
  QuickIDList: TQuickIDList;
  CharList: TStringList;
  HeroList: TStringList;
  HumRecord: pTHumInfo;
  HumDataInfo: pTHumDataInfo;

  HeroDataInfo: pTHumDataInfo;
  MasterDataInfo: pTHumDataInfo;

  sChrName: string;
  sHeroName: string;
  sMasterName: string;
  MemoryIniFileA: TMemoryIniFile;
  MemoryIniFileB: TMemoryIniFile;

  StringListA: TStringList;
  StringListB: TStringList;
  boFind: Boolean;
begin
  if g_boClose then Exit;
  UpdataItemNumber();
  ProcessMessage('正在合并Mir.DB数据库，请稍候...');
  m_nPercent := 0;
  m_nCount := m_FileDBB.m_MirCharNameList.Count;
  for I := 0 to m_FileDBB.m_MirCharNameList.Count - 1 do begin
    if g_boClose then Break;
    m_FileDBA.m_MirCharNameList.AddRecord(m_FileDBB.m_MirCharNameList.Strings[I], m_FileDBB.m_MirCharNameList.Objects[I]);
    ProcessStatus();
    Application.ProcessMessages;
  end;

  for I := 0 to m_ItemBindIPaddrB.Count - 1 do begin
    m_ItemBindIPaddrA.Add(m_ItemBindIPaddrB.Items[I]);
  end;
  m_ItemBindIPaddrB.Clear;

  for I := 0 to m_ItemBindAccountB.Count - 1 do begin
    m_ItemBindAccountA.Add(m_ItemBindAccountB.Items[I]);
  end;
  m_ItemBindAccountB.Clear;

  for I := 0 to m_ItemBindCharNameB.Count - 1 do begin
    m_ItemBindCharNameA.Add(m_ItemBindCharNameB.Items[I]);
  end;
  m_ItemBindCharNameB.Clear;

  for I := 0 to m_DuelInfoDBB.m_OwnerList.Count - 1 do begin
    m_DuelInfoDBA.m_OwnerList.AddObject(m_DuelInfoDBB.m_OwnerList.Strings[I], m_DuelInfoDBB.m_OwnerList.Objects[I]);
  end;
  m_DuelInfoDBB.m_OwnerList.Clear;
  m_DuelInfoDBB.m_DuelList.Clear;

  for I := 0 to m_DuelItemDBB.m_ItemList.Count - 1 do begin
    m_DuelItemDBA.m_ItemList.AddObject(m_DuelItemDBB.m_ItemList.Strings[I], m_DuelItemDBB.m_ItemList.Objects[I]);
  end;
  m_DuelItemDBB.m_ItemList.Clear;
  m_DuelItemDBB.m_DuelItemList.Clear;

  m_RememberItemListA.AddStrings(m_RememberItemListB);

 { for I := 0 to m_ItemDblClickListB.Count - 1 do begin
    m_ItemDblClickListA.Add(m_ItemDblClickListB.Items[I]);
  end; }
  m_RememberItemListB.Clear;

  if m_DynamicVarListA.Count = m_DynamicVarListB.Count then begin
    ProcessMessage('正在合并自定义变量，请稍候...');
    m_nPercent := 0;
    m_nCount := m_DynamicVarListB.Count;
    for I := 0 to m_DynamicVarListB.Count - 1 do begin
      if g_boClose then Break;
      MemoryIniFileA := TMemoryIniFile(m_DynamicVarListA.Objects[I]);
      MemoryIniFileB := TMemoryIniFile(m_DynamicVarListB.Objects[I]);
      for II := 0 to MemoryIniFileB.Sections.Count - 1 do begin
        MemoryIniFileA.Write(MemoryIniFileB.Sections[II], TStrings(MemoryIniFileB.Sections.Objects[II]));
      end;
      MemoryIniFileB.Sections.Clear;
      ProcessStatus();
      Application.ProcessMessages;
    end;
  end;


  if m_CharNameListA.Count = m_CharNameListB.Count then begin
    ProcessMessage('正在合并名称列表，请稍候...');
    m_nPercent := 0;
    m_nCount := m_CharNameListB.Count;
    for I := 0 to m_CharNameListB.Count - 1 do begin
      if g_boClose then Break;
      StringListA := TStringList(m_CharNameListA.Objects[I]);
      StringListB := TStringList(m_CharNameListB.Objects[I]);
      StringListA.AddStrings(StringListB);
      StringListB.Clear;
      ProcessStatus();
      Application.ProcessMessages;
    end;
  end;

  ProcessMessage('正在排序，请稍候...');
  m_FileDBB.m_MirCharNameList.Clear;

  m_FileDBA.m_MirCharNameList.SortString(0, m_FileDBA.m_MirCharNameList.Count - 1);

  m_FileDBA.m_HumCharNameList.SortString(0, m_FileDBA.m_HumCharNameList.Count - 1);

  if g_boDeleteLowLevel then begin
    g_LogHumList.Add('');
    ProcessMessage('正在删除多余角色，请稍候...');
    QuickIDList := TQuickIDList.Create;
    CharList := TStringList.Create;
    HeroList := TStringList.Create;
    m_nPercent := 0;
    m_nCount := m_FileHumDBA.m_HumCharNameList.Count;
    for I := 0 to m_FileHumDBA.m_HumCharNameList.Count - 1 do begin
      if g_boClose then Break;
      HumRecord := pTHumInfo(m_FileHumDBA.m_HumCharNameList.Objects[I]);
      QuickIDList.AddRecord(HumRecord.sAccount, HumRecord);
      ProcessStatus();
      Application.ProcessMessages;
    end;
    QuickIDList.SortString(0, QuickIDList.Count - 1);
    //QuickIDList.SaveToFile('QuickIDList.txt');

    m_nPercent := 0;
    m_nCount := QuickIDList.Count;
    for I := 0 to QuickIDList.Count - 1 do begin
      if g_boClose then Break;
      ChrList := TList(QuickIDList.Objects[I]);
      nCharCount := 0;
      nHeroCount := 0;
      CharList.Clear;
      HeroList.Clear;
      for II := 0 to ChrList.Count - 1 do begin
        HumRecord := ChrList.Items[II];
        if (not HumRecord.boDeleted) then begin
          if HumRecord.boIsHero then begin
            Inc(nHeroCount);
            nIndex := m_FileDBA.m_MirCharNameList.GetIndex(HumRecord.sChrName);
            if nIndex >= 0 then begin
              HumDataInfo := pTHumDataInfo(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
              HeroList.AddObject(IntToStr(HumDataInfo.Data.Abil.Level), TObject(nIndex));
            end;
          end else begin
            Inc(nCharCount);
            nIndex := m_FileDBA.m_MirCharNameList.GetIndex(HumRecord.sChrName);
            if nIndex >= 0 then begin
              HumDataInfo := pTHumDataInfo(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
              CharList.AddObject(IntToStr(HumDataInfo.Data.Abil.Level), TObject(nIndex));
            end;
          end;
        end;
      end;

      if nCharCount > 2 then begin
        CharList.CustomSort(NumberSort_2);
        //CharList.SaveToFile(IntToStr(I)+'CharList.txt');
        while CharList.Count > 2 do begin
          nIndex := Integer(CharList.Objects[0]);
          CharList.Delete(0);
          sHeroName := '';
          HumDataInfo := pTHumDataInfo(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
          if HumDataInfo <> nil then begin

            //m_FileDBA.m_MirCharNameList.Objects[nIndex] := nil;
            HumDataInfo.Header.boDeleted := True;
            sChrName := m_FileDBA.m_MirCharNameList.Strings[nIndex];
            g_LogHumList.Add('删除人物: ' + sChrName + #9#9#9 + '账号: ' + HumDataInfo.Data.sAccount);
            sHeroName := HumDataInfo.Data.sHeroChrName;
            //Dispose(HumDataInfo);

            nIndex := m_FileHumDBA.m_HumCharNameList.GetIndex(sChrName);
            if nIndex >= 0 then begin
              HumRecord := pTHumInfo(m_FileHumDBA.m_HumCharNameList.Objects[nIndex]);
              m_FileHumDBA.m_HumDBList.DelRecord(m_FileHumDBA.m_HumCharNameList.Objects[nIndex]);
              m_FileHumDBA.m_HumCharNameList.Delete(nIndex);
              Dispose(HumRecord);
            end;

            if sHeroName <> '' then begin
              nIndex := m_FileDBA.m_MirCharNameList.GetIndex(sHeroName);
              if nIndex >= 0 then begin
                HumDataInfo := pTHumDataInfo(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
                sChrName := m_FileDBA.m_MirCharNameList.Strings[nIndex];
                g_LogHumList.Add('删除人物: ' + sChrName + #9#9#9 + '账号: ' + HumDataInfo.Data.sAccount);
                HumDataInfo.Header.boDeleted := True;
                //m_FileDBA.m_MirCharNameList.Objects[nIndex] := nil;
                //Dispose(HumDataInfo);

                nIndex := m_FileHumDBA.m_HumCharNameList.GetIndex(sChrName);
                if nIndex >= 0 then begin
                  HumRecord := pTHumInfo(m_FileHumDBA.m_HumCharNameList.Objects[nIndex]);
                  m_FileHumDBA.m_HumDBList.DelRecord(m_FileHumDBA.m_HumCharNameList.Objects[nIndex]);
                  m_FileHumDBA.m_HumCharNameList.Delete(nIndex);
                  Dispose(HumRecord);
                end;
              end;
            end;
          end;
        end;
      end;
      if nHeroCount > 2 then begin
        HeroList.CustomSort(NumberSort_2);
        //HeroList.SaveToFile(IntToStr(I)+'HeroList.txt');
        while HeroList.Count > 2 do begin
          nIndex := Integer(HeroList.Objects[0]);
          HeroList.Delete(0);

          HumDataInfo := pTHumDataInfo(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
          if HumDataInfo <> nil then begin
            sChrName := m_FileDBA.m_MirCharNameList.Strings[nIndex];
            g_LogHumList.Add('删除英雄: ' + sChrName + #9#9#9 + '账号: ' + HumDataInfo.Data.sAccount);
           // m_FileDBA.m_MirCharNameList.Objects[nIndex] := nil;
            sMasterName := HumDataInfo.Data.sMasterName;
            HumDataInfo.Header.boDeleted := True;
            //Dispose(HumDataInfo);
            nIndex := m_FileHumDBA.m_HumCharNameList.GetIndex(sChrName);
            if nIndex >= 0 then begin
              HumRecord := pTHumInfo(m_FileHumDBA.m_HumCharNameList.Objects[nIndex]);
              m_FileHumDBA.m_HumDBList.DelRecord(m_FileHumDBA.m_HumCharNameList.Objects[nIndex]);
              m_FileHumDBA.m_HumCharNameList.Delete(nIndex);
              Dispose(HumRecord);
            end;

            if sMasterName <> '' then begin
              nIndex := m_FileDBA.m_MirCharNameList.GetIndex(sMasterName);
              if nIndex >= 0 then begin
                HumDataInfo := pTHumDataInfo(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
                if HumDataInfo.Data.sHeroChrName = sChrName then begin
                  HumDataInfo.Data.sHeroChrName := '';
                  HumDataInfo.Data.boHasHero := False;
                end;
              end;
            end;
          end;
        end;
      end;
      ProcessStatus();
      Application.ProcessMessages;
    end;

    for I := m_FileDBA.m_MirCharNameList.Count - 1 downto 0 do begin
      HumDataInfo := pTHumDataInfo(m_FileDBA.m_MirCharNameList.Objects[I]);
      if HumDataInfo.Header.boDeleted then begin
        with m_FileDBA do begin
          m_MasterList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          m_DearList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          m_HeroList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          m_HeroNameList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          m_MirDBList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
        end;
        m_FileDBA.m_MirCharNameList.Delete(I);
        Dispose(HumDataInfo);
      end;
    end;
    m_FileDBA.m_MirCharNameList.SortString(0, m_FileDBA.m_MirCharNameList.Count - 1);
    QuickIDList.Free;
    CharList.Free;
    HeroList.Free;
//------------------------------------------------------------------------------
    m_nPercent := 0;
    m_nCount := m_FileHumDBA.m_HumCharNameList.Count;
    for nIndex := m_FileHumDBA.m_HumCharNameList.Count - 1 downto 0 do begin
      if g_boClose then Break;

      for II := 0 to m_FileDBA.m_MirCharNameList.Count - 1 do begin
        if CompareText(m_FileDBA.m_MirCharNameList.Strings[II], m_FileHumDBA.m_HumCharNameList.Strings[nIndex]) = 0 then begin
          boFind := True;
          Break;
        end;
      end;

      if not boFind then begin
        m_FileHumDBA.m_HumDBList.DelRecord(m_FileHumDBA.m_HumCharNameList.Objects[nIndex]);
        Dispose(pTHumInfo(m_FileHumDBA.m_HumCharNameList.Objects[nIndex]));
        m_FileHumDBA.m_HumCharNameList.Delete(nIndex);
      end;
      ProcessStatus();
    end;

//------------------------------------------------------------------------------
    m_nPercent := 0;
    m_nCount := m_FileDBA.m_MirCharNameList.Count;
    for nIndex := m_FileDBA.m_MirCharNameList.Count - 1 downto 0 do begin
      if g_boClose then Break;
      boFind := False;
      for II := 0 to m_FileHumDBA.m_HumCharNameList.Count - 1 do begin
        if CompareText(m_FileHumDBA.m_HumCharNameList.Strings[II], m_FileDBA.m_MirCharNameList.Strings[nIndex]) = 0 then begin
          boFind := True;
          Break;
        end;
      end;
      if not boFind then begin
        with m_FileDBA do begin
          m_MasterList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          m_DearList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          m_HeroList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          m_HeroNameList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          m_MirDBList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
        end;
        Dispose(pTHumDataInfo(m_FileDBA.m_MirCharNameList.Objects[nIndex]));
        m_FileDBA.m_MirCharNameList.Delete(nIndex);
      end;
      ProcessStatus();
    end;

//------------------------------------------------------------------------------
    for I := m_FileDBA.m_MirCharNameList.Count - 1 downto 0 do begin
      HumDataInfo := pTHumDataInfo(m_FileDBA.m_MirCharNameList.Objects[I]);
    {if Pos('nitian', HumDataInfo.Data.sAccount) > 0 then
      g_LogHumList.Add(Format('FileDBA sAccount:%s Header.boDeleted:%d Header.boIsHero:%d Header.sName:%s  Data.sChrName:%s  Data.sMasterName:%s  Data.sHeroChrName:%s Data.boIsHero:%d Data.boHasHero:%d',
        [HumDataInfo.Data.sAccount, Integer(HumDataInfo.Header.boDeleted), Integer(HumDataInfo.Header.boIsHero), HumDataInfo.Header.sName,
        HumDataInfo.Data.sChrName, HumDataInfo.Data.sMasterName, HumDataInfo.Data.sHeroChrName, Integer(HumDataInfo.Data.boIsHero), Integer(HumDataInfo.Data.boHasHero)]));
    }

      if HumDataInfo.Data.boIsHero then begin
        nIndex := m_FileDBA.m_MirCharNameList.GetIndex(HumDataInfo.Data.sMasterName);
        if nIndex < 0 then begin
          with m_FileDBA do begin
            m_MasterList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
            m_DearList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
            m_HeroList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
            m_HeroNameList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
            m_MirDBList.DelRecord(m_FileDBA.m_MirCharNameList.Objects[I]);
          end;
          m_FileDBA.m_MirCharNameList.Delete(I);
          Dispose(HumDataInfo);
        end else begin
          MasterDataInfo := pTHumDataInfo(m_FileDBA.m_MirCharNameList.Objects[nIndex]);
          HumDataInfo.Header.sName := HumDataInfo.Data.sChrName;
          HumDataInfo.Header.boIsHero := True;
          HumDataInfo.Data.boIsHero := True;
          HumDataInfo.Data.boHasHero := False;
          HumDataInfo.Data.sAccount := MasterDataInfo.Data.sAccount;
        end;
      end else begin
        if (HumDataInfo.Data.sHeroChrName <> '') then begin
          nIndex := m_FileDBA.m_MirCharNameList.GetIndex(HumDataInfo.Data.sHeroChrName);
          if (nIndex < 0) then begin
            HumDataInfo.Data.sHeroChrName := '';
            HumDataInfo.Data.boHasHero := False;
          end else begin
            HumDataInfo.Data.boHasHero := True;
            HumDataInfo.Header.sName := HumDataInfo.Data.sChrName;
          end;
        end else begin
          HumDataInfo.Data.sHeroChrName := '';
          HumDataInfo.Data.boHasHero := False;
        end;
      end;
    end;
    m_FileDBA.m_MirCharNameList.SortString(0, m_FileDBA.m_MirCharNameList.Count - 1);
//------------------------------------------------------------------------------
  end;
end;

procedure TBlendThread.BlendGuildBaseList();
  function IsHaveRcd(GuildList: TQuickList; sGuildName: string): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to GuildList.Count - 1 do begin
      if CompareText(GuildList.Strings[I], sGuildName) = 0 then begin
        Result := True;
        Break;
      end;
    end;
  end;

  function GetNewGuildName(GuildList: TQuickList; sGuildName: string; var sNewGuildName: string): Boolean;
  var
    I, II, III, IIII, IIIII, IIIIII, IIIIIII, IIIIIIII, IIIIIIIII, IIIIIIIIII: Integer;
    sOldGuildName: string;
  begin
    Result := True;
    sNewGuildName := sGuildName;
    if IsHaveRcd(GuildList, sGuildName) then begin
      Result := False;
      sOldGuildName := _Copy(sGuildName, 13);
      for I := 97 to 122 do begin
        sNewGuildName := sOldGuildName + Chr(I);
        if not IsHaveRcd(GuildList, sNewGuildName) then begin
          Result := True;
          Exit;
        end;
      end;

      sOldGuildName := _Copy(sGuildName, 12);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          sNewGuildName := sOldGuildName + Chr(I) + Chr(II);
          if not IsHaveRcd(GuildList, sNewGuildName) then begin
            Result := True;
            Exit;
          end;
        end;
      end;

      sOldGuildName := _Copy(sGuildName, 11);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            sNewGuildName := sOldGuildName + Chr(I) + Chr(II) + Chr(III);
            if not IsHaveRcd(GuildList, sNewGuildName) then begin
              Result := True;
              Exit;
            end;
          end;
        end;
      end;

      sOldGuildName := _Copy(sGuildName, 10);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              sNewGuildName := sOldGuildName + Chr(I) + Chr(II) + Chr(III) + Chr(IIII);
              if not IsHaveRcd(GuildList, sNewGuildName) then begin
                Result := True;
                Exit;
              end;
            end;
          end;
        end;
      end;

      sOldGuildName := _Copy(sGuildName, 9);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              for IIIII := 97 to 122 do begin
                sNewGuildName := sOldGuildName + Chr(I) + Chr(II) + Chr(III) + Chr(IIII) + Chr(IIIII);
                if not IsHaveRcd(GuildList, sNewGuildName) then begin
                  Result := True;
                  Exit;
                end;
              end;
            end;
          end;
        end;
      end;

      sOldGuildName := _Copy(sGuildName, 8);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              for IIIII := 97 to 122 do begin
                for IIIIII := 97 to 122 do begin
                  sNewGuildName := sOldGuildName + Chr(I) + Chr(II) + Chr(III) + Chr(IIII) + Chr(IIIII) + Chr(IIIIII);
                  if not IsHaveRcd(GuildList, sNewGuildName) then begin
                    Result := True;
                    Exit;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;

      sOldGuildName := _Copy(sGuildName, 7);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              for IIIII := 97 to 122 do begin
                for IIIIII := 97 to 122 do begin
                  for IIIIIII := 97 to 122 do begin
                    sNewGuildName := sOldGuildName + Chr(I) + Chr(II) + Chr(III) + Chr(IIII) + Chr(IIIII) + Chr(IIIIII) + Chr(IIIIIII);
                    if not IsHaveRcd(GuildList, sNewGuildName) then begin
                      Result := True;
                      Exit;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;

      sOldGuildName := _Copy(sGuildName, 6);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              for IIIII := 97 to 122 do begin
                for IIIIII := 97 to 122 do begin
                  for IIIIIII := 97 to 122 do begin
                    for IIIIIIII := 97 to 122 do begin
                      sNewGuildName := sOldGuildName + Chr(I) + Chr(II) + Chr(III) + Chr(IIII) + Chr(IIIII) + Chr(IIIIII) + Chr(IIIIIII) + Chr(IIIIIIII);
                      if not IsHaveRcd(GuildList, sNewGuildName) then begin
                        Result := True;
                        Exit;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;

      sOldGuildName := _Copy(sGuildName, 5);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              for IIIII := 97 to 122 do begin
                for IIIIII := 97 to 122 do begin
                  for IIIIIII := 97 to 122 do begin
                    for IIIIIIII := 97 to 122 do begin
                      for IIIIIIIII := 97 to 122 do begin
                        sNewGuildName := sOldGuildName + Chr(I) + Chr(II) + Chr(III) + Chr(IIII) + Chr(IIIII) + Chr(IIIIII) + Chr(IIIIIII) + Chr(IIIIIIII) + Chr(IIIIIIIII);
                        if not IsHaveRcd(GuildList, sNewGuildName) then begin
                          Result := True;
                          Exit;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;

      sOldGuildName := _Copy(sGuildName, 4);
      for I := 97 to 122 do begin
        for II := 97 to 122 do begin
          for III := 97 to 122 do begin
            for IIII := 97 to 122 do begin
              for IIIII := 97 to 122 do begin
                for IIIIII := 97 to 122 do begin
                  for IIIIIII := 97 to 122 do begin
                    for IIIIIIII := 97 to 122 do begin
                      for IIIIIIIII := 97 to 122 do begin
                        for IIIIIIIIII := 97 to 122 do begin
                          sNewGuildName := sOldGuildName + Chr(I) + Chr(II) + Chr(III) +
                            Chr(IIII) + Chr(IIIII) + Chr(IIIIII) + Chr(IIIIIII) + Chr(IIIIIIII) + Chr(IIIIIIIII) + Chr(IIIIIIIIII);
                          if not IsHaveRcd(GuildList, sNewGuildName) then begin
                            Result := True;
                            Exit;
                          end;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

var
  I, II, III: Integer;
  sGuildName: string;
  sOldGuildName: string;
  sNewGuildName: string;
  Guild: pTGUild;
  GuildRank: pTGuildRank;
  boFound: Boolean;
begin
  if g_boClose then Exit;
  {
  m_nPercent := 0;
  m_nCount := m_GuildBaseA.m_GuildBaseList.Count;
  ProcessMessage('正在合并GuildBase数据库，请稍候...');
  for I := 0 to m_GuildBaseA.m_GuildBaseList.Count - 1 do begin
    for II := I + 1 to m_GuildBaseA.m_GuildBaseList.Count - 2 do begin
      if m_GuildBaseA.m_GuildBaseList.Strings[I] = m_GuildBaseA.m_GuildBaseList.Strings[II] then begin
        sGuildName := m_GuildBaseA.m_GuildBaseList.Strings[II];
        Guild := pTGUild(m_GuildBaseA.m_GuildBaseList.Objects[II]);
        sNewGuildName := sGuildName;
        if GetNewGuildName(m_GuildBaseA.m_GuildBaseList, sGuildName, sNewGuildName) then begin
          Guild.sGuildName := sNewGuildName;
          g_LogGuildList.Add(sGuildName + '=>' + sNewGuildName);
        end;
      end;
    end;
    ProcessStatus();
    Application.ProcessMessages;
  end;

  m_nPercent := 0;
  m_nCount := m_GuildBaseB.m_GuildBaseList.Count;
  ProcessMessage('正在合并GuildBase数据库，请稍候...');
  for I := 0 to m_GuildBaseB.m_GuildBaseList.Count - 1 do begin
    for II := I + 1 to m_GuildBaseB.m_GuildBaseList.Count - 2 do begin
      if m_GuildBaseB.m_GuildBaseList.Strings[I] = m_GuildBaseB.m_GuildBaseList.Strings[II] then begin
        sGuildName := m_GuildBaseB.m_GuildBaseList.Strings[II];
        Guild := pTGUild(m_GuildBaseB.m_GuildBaseList.Objects[II]);
        sNewGuildName := sGuildName;
        if GetNewGuildName(m_GuildBaseB.m_GuildBaseList, sGuildName, sNewGuildName) then begin
          Guild.sGuildName := sNewGuildName;
          g_LogGuildList.Add(sGuildName + '=>' + sNewGuildName);
        end;
      end;
    end;
    ProcessStatus();
    Application.ProcessMessages;
  end;
  }
  m_nPercent := 0;
  m_nCount := m_GuildBaseB.m_GuildBaseList.Count;
  ProcessMessage('正在合并GuildBase数据库，请稍候...');
  while True do begin
    if m_GuildBaseB.m_GuildBaseList.Count <= 0 then Break;
    if g_boClose then Break;
    sGuildName := m_GuildBaseB.m_GuildBaseList.Strings[0];
    Guild := pTGUild(m_GuildBaseB.m_GuildBaseList.Objects[0]);
    sNewGuildName := sGuildName;
    if IsHaveRcd(m_GuildBaseA.m_GuildBaseList, sGuildName) then begin
      if GetNewGuildName(m_GuildBaseA.m_GuildBaseList, sGuildName, sNewGuildName) then begin
        Guild.sGuildName := sNewGuildName;
        g_LogGuildList.Add(sGuildName + '=>' + sNewGuildName);
      end;
    end;
    Guild.sGuildDir := g_sGuildBase1;
    Guild.sGuildNotice := g_sGuildNotice1;
    Guild.sGuildWar := g_sGuildWar1;
    Guild.sGuildAll := g_sGuildAll1;
    Guild.sGuildMember := g_sGuildMember1;
    Guild.sGuildMemberRank := g_sGuildMemberRank1;
    Guild.sGuildChief := g_sGuildChief1;
    m_GuildBaseA.m_GuildBaseList.AddObject(sNewGuildName, TObject(Guild));
    m_GuildBaseB.m_GuildBaseList.Delete(0);
    ProcessStatus();
    Application.ProcessMessages;
  end;

  m_nPercent := 0;
  m_nCount := m_GuildBaseA.m_GuildBaseList.Count;
  for I := 0 to m_GuildBaseA.m_GuildBaseList.Count - 1 do begin //删除不存在的行会成员
    Guild := pTGUild(m_GuildBaseA.m_GuildBaseList.Objects[I]);
    for II := 0 to Guild.RankList.Count - 1 do begin
      GuildRank := pTGuildRank(Guild.RankList.Items[II]);
      for III := GuildRank.MemberList.Count - 1 downto 0 do begin
        if m_FileHumDBA.m_HumCharNameList.GetIndex(GuildRank.MemberList.Strings[III]) < 0 then begin
          GuildRank.MemberList.Delete(III);
        end;
      end;
    end;
    ProcessStatus();
  end;

  ProcessMessage('正在排序，请稍候...');
  m_GuildBaseA.m_GuildBaseList.SortString(0, m_GuildBaseA.m_GuildBaseList.Count - 1);
end;

procedure TBlendThread.BlendBigStorageList();
var
  I: Integer;
begin
  if g_boClose then Exit;
  m_nPercent := 0;
  m_nCount := m_StorageB.m_BigStorageList.Count;
  ProcessMessage('正在合并UserStorage.DB数据库，请稍候...');
  for I := 0 to m_StorageB.m_BigStorageList.Count - 1 do begin
    if g_boClose then Break;
    m_StorageA.m_BigStorageList.AddObject(m_StorageB.m_BigStorageList.Strings[I], m_StorageB.m_BigStorageList.Objects[I]);
    ProcessStatus();
  end;
  ProcessMessage('正在排序，请稍候...');
  m_StorageB.m_BigStorageList.Clear;
  m_StorageA.m_BigStorageList.SortString(0, m_StorageA.m_BigStorageList.Count - 1);
end;

procedure TBlendThread.BlendSellOffSellList();
var
  I: Integer;
begin
  if g_boClose then Exit;
  m_nPercent := 0;
  m_nCount := m_SellOffB.m_SellOffList.Count;
  ProcessMessage('正在合并UserSellOff.Sell数据库，请稍候...');
  for I := 0 to m_SellOffB.m_SellOffList.Count - 1 do begin
    if g_boClose then Break;
    m_SellOffA.m_SellOffList.AddObject(m_SellOffB.m_SellOffList.Strings[I], m_SellOffB.m_SellOffList.Objects[I]);
    ProcessStatus();
  end;
  ProcessMessage('正在排序，请稍候...');
  m_SellOffB.m_SellOffList.Clear;
  m_SellOffA.m_SellOffList.SortString(0, m_SellOffA.m_SellOffList.Count - 1);
end;

procedure TBlendThread.BlendSellOffGoldList();
var
  I: Integer;
begin
  if g_boClose then Exit;
  m_nPercent := 0;
  m_nCount := m_SellGoldB.m_SellOffList.Count;
  ProcessMessage('正在合并UserSellOff.Gold数据库，请稍候...');
  for I := 0 to m_SellGoldB.m_SellOffList.Count - 1 do begin
    if g_boClose then Break;
    m_SellGoldA.m_SellOffList.AddObject(m_SellGoldB.m_SellOffList.Strings[I], m_SellGoldB.m_SellOffList.Objects[I]);
    ProcessStatus();
  end;
  ProcessMessage('正在排序，请稍候...');
  m_SellGoldB.m_SellOffList.Clear;
  m_SellGoldA.m_SellOffList.SortString(0, m_SellGoldA.m_SellOffList.Count - 1);
end;

procedure TBlendThread.SaveIDDBList();
begin
  ProcessMessage('正在创建新的ID.DB数据库，请稍候...');

  m_FileIDDBA.SaveToFile(g_sSaveDir + 'ID.DB');
  g_nIDDBCount := m_FileIDDBA.m_Header.nIDCount;
end;

procedure TBlendThread.SaveHumDBList();
begin
  ProcessMessage('正在创建新的Hum.DB数据库，请稍候...');
  m_FileHumDBA.SaveToFile(g_sSaveDir + 'Hum.DB');
  g_nHumDBCount := m_FileHumDBA.m_Header.nHumCount;
end;

procedure TBlendThread.SaveMirDBList();
begin
  ProcessMessage('正在创建新的Mir.DB数据库，请稍候...');
  m_FileDBA.SaveToFile(g_sSaveDir + 'Mir.DB');
  g_nMirDBCount := m_FileDBA.m_Header.nHumCount;
end;

procedure TBlendThread.SaveGuildBaseList();
begin
  try

    m_GuildBaseA.SaveToFile('');
  except

  end;
end;

procedure TBlendThread.SaveBigStorageList();
begin
  ProcessMessage('正在创建新的UserStorage.DB数据库，请稍候...');
  m_StorageA.SaveToFile(g_sSaveDir + 'UserStorage.DB');
  g_nBigStorageCount := m_StorageA.m_Header;
end;

procedure TBlendThread.SaveSellOffSellList();
begin
  ProcessMessage('正在创建新的UserSellOff.Sell数据库，请稍候...');
  m_SellOffA.SaveToFile(g_sSaveDir + 'UserSellOff.Sell');
  g_nSellOffSellCount := m_SellOffA.m_Header;
end;

procedure TBlendThread.SaveSellOffGoldList();
begin
  ProcessMessage('正在创建新的UserSellOff.Gold数据库，请稍候...');
  m_SellGoldA.SaveToFile(g_sSaveDir + 'UserSellOff.Gold');
  g_nSellOffGoldCount := m_SellGoldA.m_Header;
end;


procedure TBlendThread.SaveDuelInfoList();
begin
  ProcessMessage('正在创建新的Duel.Duel数据库，请稍候...');
  m_DuelInfoDBA.SaveToFile(g_sSaveDir + 'Duel.Duel');
  //g_nSellOffSellCount := m_SellOffA.m_Header;
end;

procedure TBlendThread.SaveDuelItemList();
begin
  ProcessMessage('正在创建新的Duel.Item数据库，请稍候...');
  m_DuelItemDBA.SaveToFile(g_sSaveDir + 'Duel.Item');
  //g_nSellOffGoldCount := m_SellGoldA.m_Header;
end;

procedure ProcessStatus();
begin
  try
    Inc(m_nPercent);
    frmMain.ProgressStatus.Percent := Trunc(m_nPercent / (m_nCount / 100));
  except
  end;
end;

procedure ProcessMessage(sMsg: string);
begin
  frmMain.RzStatusPane.Caption := sMsg;
  g_SysLog.Add(sMsg);
end;

function SelectDirCB(Wnd: HWND; uMsg: UINT; lParam, lpData: lParam): Integer stdcall;
begin
  if (uMsg = BFFM_INITIALIZED) and (lpData <> 0) then
    SendMessage(Wnd, BFFM_SETSELECTION, Integer(True), lpData);
  Result := 0;
end;

function SelectDirectory(const Caption: string; const Root: WideString;
  var Directory: string; Owner: Thandle): Boolean;
var
  WindowList: Pointer;
  BrowseInfo: TBrowseInfo;
  Buffer: PChar;
  RootItemIDList, ItemIDList: PItemIDList;
  ShellMalloc: IMalloc;
  IDesktopFolder: IShellFolder;
  Eaten, Flags: LongWord;
begin
  Result := False;
  if not DirectoryExists(Directory) then
    Directory := '';
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then begin
    Buffer := ShellMalloc.Alloc(MAX_PATH);
    try
      RootItemIDList := nil;
      if Root <> '' then begin
        SHGetDesktopFolder(IDesktopFolder);
        IDesktopFolder.ParseDisplayName(Application.Handle, nil,
          POleStr(Root), Eaten, RootItemIDList, Flags);
      end;
      with BrowseInfo do begin
        hwndOwner := Owner;
        pidlRoot := RootItemIDList;
        pszDisplayName := Buffer;
        lpszTitle := PChar(Caption);
        ulFlags := BIF_RETURNONLYFSDIRS;
        if Directory <> '' then begin
          lpfn := SelectDirCB;
          lParam := Integer(PChar(Directory));
        end;
      end;
      WindowList := DisableTaskWindows(0);
      try
        ItemIDList := ShBrowseForFolder(BrowseInfo);
      finally
        EnableTaskWindows(WindowList);
      end;
      Result := ItemIDList <> nil;
      if Result then begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
        Directory := Buffer;
      end;
    finally
      ShellMalloc.Free(Buffer);
    end;
  end;
end;

procedure TfrmMain.ListBoxDynamicVarAClick(Sender: TObject);
begin
 {
  ListBoxDynamicVarB.ItemIndex := ListBoxDynamicVarA.ItemIndex;
  if ListBoxDynamicVarB.ItemIndex >= 0 then begin
    ButtonDynamicVarDel.Enabled := True;
  end else begin
    ButtonDynamicVarDel.Enabled := False;
  end; }
end;

procedure TfrmMain.ListBoxDynamicVarBClick(Sender: TObject);
begin
{  ListBoxDynamicVarA.ItemIndex := ListBoxDynamicVarB.ItemIndex;
  if ListBoxDynamicVarA.ItemIndex >= 0 then begin
    ButtonDynamicVarDel.Enabled := True;
  end else begin
    ButtonDynamicVarDel.Enabled := False;
  end; }
end;

{function TfrmMain.LoadSkinPlug(PlugName: string): Boolean; //动态加载DLL
begin
  if not FileExists(ExtractFilePath(ParamStr(0)) + PlugName) then begin
    Result := False;
    Exit;
  end;
  Plughandle := LoadLibrary(PChar(ExtractFilePath(ParamStr(0)) + PlugName));
  if Plughandle = 0 then Exit;
  @Init := GetProcAddress(Plughandle, 'Init');
  @UnInit := GetProcAddress(Plughandle, 'UnInit');
  @GetSkin := GetProcAddress(Plughandle, 'GetSkin');
  if (@Init <> nil) and (@UnInit <> nil) and (@GetSkin <> nil) then begin
    Result := True;
  end else Result := False;
end;}

procedure TfrmMain.FormCreate(Sender: TObject);
  procedure LoadConfig();
  var
    Config: TIniFile;
    sFileName: string;
  begin
    Config := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
    g_sSaveDir := Config.ReadString('Setup', 'Save', g_sSaveDir);
    g_sIDDB1 := Config.ReadString('Setup', 'ID1', g_sIDDB1);
    g_sIDDB2 := Config.ReadString('Setup', 'ID2', g_sIDDB2);
    g_sHumDB1 := Config.ReadString('Setup', 'Hum1', g_sHumDB1);
    g_sHumDB2 := Config.ReadString('Setup', 'Hum2', g_sHumDB2);
    g_sMirDB1 := Config.ReadString('Setup', 'Mir1', g_sMirDB1);
    g_sMirDB2 := Config.ReadString('Setup', 'Mir2', g_sMirDB2);
    g_sGuildBase1 := Config.ReadString('Setup', 'GuildBase1', g_sGuildBase1);
    g_sGuildBase2 := Config.ReadString('Setup', 'GuildBase2', g_sGuildBase2);
    g_sBigStorage1 := Config.ReadString('Setup', 'BigStorage1', g_sBigStorage1);
    g_sBigStorage2 := Config.ReadString('Setup', 'BigStorage2', g_sBigStorage2);
    g_sSellOffSell1 := Config.ReadString('Setup', 'SellOffSell1', g_sSellOffSell1);
    g_sSellOffSell2 := Config.ReadString('Setup', 'SellOffSell2', g_sSellOffSell2);
    g_sSellOffGold1 := Config.ReadString('Setup', 'SellOffGold1', g_sSellOffGold1);
    g_sSellOffGold2 := Config.ReadString('Setup', 'SellOffGold2', g_sSellOffGold2);
    g_sSetup1 := Config.ReadString('Setup', '!Setup1', g_sSetup1);
    g_sSetup2 := Config.ReadString('Setup', '!Setup2', g_sSetup2);

    g_sRememberItemList1 := Config.ReadString('Setup', 'RememberItemList1', g_sRememberItemList1);
    g_sItemBindIPaddr1 := Config.ReadString('Setup', 'ItemBindIPaddr1', g_sItemBindIPaddr1);
    g_sItemBindAccount1 := Config.ReadString('Setup', 'ItemBindAccount1', g_sItemBindAccount1);
    g_sItemBindChrName1 := Config.ReadString('Setup', 'ItemBindChrName1', g_sItemBindChrName1);

    g_sRememberItemList2 := Config.ReadString('Setup', 'RememberItemList2', g_sRememberItemList2);
    g_sItemBindIPaddr2 := Config.ReadString('Setup', 'ItemBindIPaddr2', g_sItemBindIPaddr2);
    g_sItemBindAccount2 := Config.ReadString('Setup', 'ItemBindAccount2', g_sItemBindAccount2);
    g_sItemBindChrName2 := Config.ReadString('Setup', 'ItemBindChrName2', g_sItemBindChrName2);

    g_sDuelInfo1 := Config.ReadString('Setup', 'DuelInfo1', g_sDuelInfo1);
    g_sDuelInfo2 := Config.ReadString('Setup', 'DuelInfo2', g_sDuelInfo2);

    g_sDuelItem1 := Config.ReadString('Setup', 'DuelItem1', g_sDuelItem1);
    g_sDuelItem2 := Config.ReadString('Setup', 'DuelItem2', g_sDuelItem2);

    Config.Free;

    sFileName := ExtractFilePath(Application.ExeName) + 'DynamicVarList(主).txt';
    if FileExists(sFileName) then
      g_DynamicVarListA.LoadFromFile(sFileName);

    sFileName := ExtractFilePath(Application.ExeName) + 'DynamicVarList(从).txt';
    if FileExists(sFileName) then
      g_DynamicVarListB.LoadFromFile(sFileName);

    sFileName := ExtractFilePath(Application.ExeName) + 'CharNameList(主).txt';
    if FileExists(sFileName) then
      g_CharNameListA.LoadFromFile(sFileName);

    sFileName := ExtractFilePath(Application.ExeName) + 'CharNameList(从).txt';
    if FileExists(sFileName) then
      g_CharNameListB.LoadFromFile(sFileName);
  end;
var
  Ini: TIniFile;
begin
{$IFDEF HEROVERSION}
  Caption := '[英雄版] ' + Caption;
  RzCheckBoxDuel.Enabled := True;
  RzGroupBox7.Enabled := True;
  RzGroupBox8.Enabled := True;
{$ELSE}
  Caption := '[分身版] ' + Caption;
  g_boDuel := False;
  RzCheckBoxDuel.Checked := False;
  RzCheckBoxDuel.Enabled := False;
  RzGroupBox7.Enabled := False;
  RzGroupBox8.Enabled := False;
{$ENDIF}
  g_LogIDList := TStringList.Create;
  g_LogHumList := TStringList.Create;
  g_LogGuildList := TStringList.Create;
  g_SysLog := TStringList.Create;
  g_TestList := TStringList.Create;
  g_DynamicVarListA := TStringList.Create;
  g_DynamicVarListB := TStringList.Create;
  g_CharNameListA := TStringList.Create;
  g_CharNameListB := TStringList.Create;


  g_boClose := False;
  g_boClearHum1 := False;
  g_boClearHum2 := True;
  g_boClearHum3 := True;
  g_boClearID1 := False;
  g_boClearID2 := True;
  g_nLimitDay1 := 90;
  g_nLimitDay2 := 90;
  g_nLimitLevel1 := 35;
  g_nLimitLevel2 := 35;
  g_LastDate := Date - 90;
  g_boCheckCopyItems := True;
  g_boBigStorage := True;
  g_boSellOff := True;
  g_boHero := True;
  g_boStart := False;
  g_boSetItemMakeIndex := True;
  g_boRepairHeroData := True;
  g_nMaxItemMakeIndex := 0;
  g_nMaxItemMakeIndexEx := High(Integer) div 2 - 1;
  CheckBoxClearNotDataHum.Checked := g_boClearHum3;
  CheckBoxClearHumLevel.Checked := g_boClearHum1;
  CheckBoxClearDeleteHum.Checked := g_boClearHum2;
  CheckBoxClearID1.Checked := g_boClearID1;
  CheckBoxClearID2.Checked := g_boClearID2;
  CheckBoxCheckCopyItems.Checked := g_boCheckCopyItems;
  CheckBoxSetItemMakeIndex.Checked := g_boSetItemMakeIndex;
  CheckBoxBigStorage.Checked := g_boBigStorage;
  CheckBoxSellOff.Checked := g_boSellOff;
  RzCheckBoxItemBind.Checked := g_boItemBind;
  RzCheckBoxItemDblClick.Checked := g_boItemDblClick;
  RzCheckBoxDuel.Checked := g_boDuel;

  NumericEditDay.IntValue := g_nLimitDay1;
  NumericEditDay1.IntValue := g_nLimitDay2;
  NumericEditLevel.IntValue := g_nLimitLevel1;

{$IF TESTMODE = 0}
  ButtonEditSaveDir.Text := '';
  ButtonEditIDDB1.Text := '';
  ButtonEditHumDB1.Text := '';
  ButtonEditMirDB1.Text := '';
  ButtonEditGuildBase1.Text := '';
  ButtonEditBigStorage1.Text := '';
  ButtonEditSellOffSell1.Text := '';
  ButtonEditSellOffGold1.Text := '';
  ButtonEditSetup1.Text := '';
  ButtonEditIDDB2.Text := '';
  ButtonEditHumDB2.Text := '';
  ButtonEditMirDB2.Text := '';
  ButtonEditGuildBase2.Text := '';
  ButtonEditBigStorage2.Text := '';
  ButtonEditSellOffSell2.Text := '';
  ButtonEditSellOffGold2.Text := '';
  ButtonEditSetup2.Text := '';

  EditDuelInfoA.Text := '';
  EditDuelInfoB.Text := '';
  EditDuelItemA.Text := '';
  EditDuelItemB.Text := '';
{$IFEND}
  LoadConfig();
  ButtonEditSaveDir.Text := g_sSaveDir;
  ButtonEditIDDB1.Text := g_sIDDB1;
  ButtonEditHumDB1.Text := g_sHumDB1;
  ButtonEditMirDB1.Text := g_sMirDB1;
  ButtonEditGuildBase1.Text := g_sGuildBase1;

  ButtonEditBigStorage1.Text := g_sBigStorage1;

  ButtonEditSellOffSell1.Text := g_sSellOffSell1;
  ButtonEditSellOffGold1.Text := g_sSellOffGold1;


  ButtonEditSetup1.Text := g_sSetup1;
  ButtonEditIDDB2.Text := g_sIDDB2;
  ButtonEditHumDB2.Text := g_sHumDB2;
  ButtonEditMirDB2.Text := g_sMirDB2;
  ButtonEditGuildBase2.Text := g_sGuildBase2;
  ButtonEditBigStorage2.Text := g_sBigStorage2;
  ButtonEditSellOffSell2.Text := g_sSellOffSell2;
  ButtonEditSellOffGold2.Text := g_sSellOffGold2;

  EditRememberItemListA.Text := g_sRememberItemList1;
  EditRememberItemListB.Text := g_sRememberItemList2;

  EditBindIPaddrA.Text := g_sItemBindIPaddr1;
  EditBindIPaddrB.Text := g_sItemBindIPaddr2;

  EditBindCharNameA.Text := g_sItemBindChrName1;
  EditBindCharNameB.Text := g_sItemBindChrName2;

  EditBindAccountA.Text := g_sItemBindAccount1;
  EditBindAccountB.Text := g_sItemBindAccount2;


  EditDuelInfoA.Text := g_sDuelInfo1;
  EditDuelInfoB.Text := g_sDuelInfo2;
  EditDuelItemA.Text := g_sDuelItem1;
  EditDuelItemB.Text := g_sDuelItem2;
  ButtonEditSetup2.Text := g_sSetup2;

  ListBoxDynamicVarA.Clear;
  ListBoxDynamicVarA.Items.AddStrings(g_DynamicVarListA);

  ListBoxDynamicVarB.Clear;
  ListBoxDynamicVarB.Items.AddStrings(g_DynamicVarListB);

  ListBoxCharNameA.Clear;
  ListBoxCharNameA.Items.AddStrings(g_CharNameListA);

  ListBoxCharNameB.Clear;
  ListBoxCharNameB.Items.AddStrings(g_CharNameListB);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if g_boStart then begin
    CanClose := False;
    Exit;
  end;
  g_boClose := True;
{  if boLoadOK then begin
    UnInit();
    FreeLibrary(Plughandle);
  end;  }
  g_LogIDList.Free;
  g_LogHumList.Free;
  g_LogGuildList.Free;
  g_SysLog.Free;
  g_DynamicVarListA.Free;
  g_DynamicVarListB.Free;

  g_CharNameListA.Free;
  g_CharNameListB.Free;
end;

procedure TfrmMain.BitBtnCLoseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.BitBtnLogClick(Sender: TObject);
begin
  if g_boStart then Exit;
  frmLog := TfrmLog.Create(Owner);
  frmLog.Open;
  frmLog.Free;
end;

procedure TfrmMain.ButtonEditIDDB1ButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'ID.db|*.db';
  if OpenDialog.Execute then begin
    ButtonEditIDDB1.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.ButtonEditHumDB1ButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'Hum.db|*.db';
  if OpenDialog.Execute then begin
    ButtonEditHumDB1.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.ButtonEditMirDB1ButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'Mir.db|*.db';
  if OpenDialog.Execute then begin
    ButtonEditMirDB1.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.ButtonEditIDDB2ButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'ID.db|*.db';
  if OpenDialog.Execute then begin
    ButtonEditIDDB2.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.ButtonEditHumDB2ButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'Hum.db|*.db';
  if OpenDialog.Execute then begin
    ButtonEditHumDB2.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.ButtonEditMirDB2ButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'Mir.db|*.db';
  if OpenDialog.Execute then begin
    ButtonEditMirDB2.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.ButtonEditGuildBase1ButtonClick(Sender: TObject);
var
  sDir: string;
begin
  sDir := ButtonEditGuildBase1.Text;
  if SelectDirectory('选择GuildBase文件夹', '', sDir, Handle) then begin
    ButtonEditGuildBase1.Text := sDir;
  end;
end;

procedure TfrmMain.ButtonEditGuildBase2ButtonClick(Sender: TObject);
var
  sDir: string;
begin
  sDir := ButtonEditGuildBase2.Text;
  if SelectDirectory('选择GuildBase文件夹', '', sDir, Handle) then begin
    ButtonEditGuildBase2.Text := sDir;
  end;
end;

procedure TfrmMain.ButtonDynamicVarAddClick(Sender: TObject);
var
  sDynamicVarFileNameA: string;
  sDynamicVarFileNameB: string;
begin
  sDynamicVarFileNameA := Trim(EditDynamicVarA.Text);
  sDynamicVarFileNameB := Trim(EditDynamicVarB.Text);
  if (sDynamicVarFileNameA <> '') and (sDynamicVarFileNameB <> '') then begin
    g_DynamicVarListA.Add(sDynamicVarFileNameA);
    g_DynamicVarListB.Add(sDynamicVarFileNameB);
    ListBoxDynamicVarA.Clear;
    ListBoxDynamicVarA.Items.AddStrings(g_DynamicVarListA);
    ListBoxDynamicVarB.Clear;
    ListBoxDynamicVarB.Items.AddStrings(g_DynamicVarListB);
  end;
end;

procedure TfrmMain.ButtonDynamicVarDelClick(Sender: TObject);
begin
  if ListBoxDynamicVarA.ItemIndex >= 0 then begin
    g_DynamicVarListA.Delete(ListBoxDynamicVarA.ItemIndex);
    g_DynamicVarListB.Delete(ListBoxDynamicVarA.ItemIndex);
    ListBoxDynamicVarA.Clear;
    ListBoxDynamicVarA.Items.AddStrings(g_DynamicVarListA);
    ListBoxDynamicVarB.Clear;
    ListBoxDynamicVarB.Items.AddStrings(g_DynamicVarListB);
    ButtonDynamicVarDel.Enabled := False;
  end;
end;

procedure TfrmMain.ButtonEditBigStorage1ButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'UserStorage.db|*.db';
  if OpenDialog.Execute then begin
    ButtonEditBigStorage1.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.ButtonEditBigStorage2ButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'UserStorage.db|*.db';
  if OpenDialog.Execute then begin
    ButtonEditBigStorage2.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.ButtonEditSellOffSell1ButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'SellOff.Sell|*.Sell';
  if OpenDialog.Execute then begin
    ButtonEditSellOffSell1.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.ButtonEditSellOffSell2ButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'SellOff.Sell|*.Sell';
  if OpenDialog.Execute then begin
    ButtonEditSellOffSell2.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.ButtonEditSellOffGold1ButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'SellOff.Gold|*.Gold';
  if OpenDialog.Execute then begin
    ButtonEditSellOffGold1.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.ButtonEditSellOffGold2ButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'SellOff.Gold|*.Gold';
  if OpenDialog.Execute then begin
    ButtonEditSellOffGold2.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.ButtonEditSaveDirButtonClick(Sender: TObject);
var
  sDir: string;
begin
  sDir := ButtonEditSaveDir.Text;
  if SelectDirectory('浏览文件夹', '', sDir, Handle) then begin
    ButtonEditSaveDir.Text := sDir;
  end;
end;

procedure TfrmMain.ButtonEditSetup1ButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := '!Setup.txt|*.txt';
  if OpenDialog.Execute then begin
    ButtonEditSetup1.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.ButtonEditSetup2ButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := '!Setup.txt|*.txt';
  if OpenDialog.Execute then begin
    ButtonEditSetup2.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.CheckBoxClearHumLevelClick(Sender: TObject);
begin
  if not g_boStart then begin
    g_boClearHum1 := CheckBoxClearHumLevel.Checked;
  end else begin
    CheckBoxClearHumLevel.Checked := g_boClearHum1;
  end;
end;

procedure TfrmMain.CheckBoxClearDeleteHumClick(Sender: TObject);
begin
  if not g_boStart then begin
    g_boClearHum2 := CheckBoxClearDeleteHum.Checked;
  end else begin
    CheckBoxClearDeleteHum.Checked := g_boClearHum2;
  end;
end;

procedure TfrmMain.CheckBoxClearNotDataHumClick(Sender: TObject);
begin
  if not g_boStart then begin
    g_boClearHum3 := CheckBoxClearNotDataHum.Checked;
  end else begin
    CheckBoxClearNotDataHum.Checked := g_boClearHum3;
  end;
end;

procedure TfrmMain.CheckBoxDeleteLowLevelClick(Sender: TObject);
begin
  if not g_boStart then begin
    g_boDeleteLowLevel := CheckBoxDeleteLowLevel.Checked;
  end else begin
    CheckBoxDeleteLowLevel.Checked := g_boDeleteLowLevel;
  end;
end;

procedure TfrmMain.CheckBoxClearID1Click(Sender: TObject);
begin
  if not g_boStart then begin
    g_boClearID1 := CheckBoxClearID1.Checked;
  end else begin
    CheckBoxClearID1.Checked := g_boClearID1;
  end;
end;

procedure TfrmMain.CheckBoxClearID2Click(Sender: TObject);
begin
  if not g_boStart then begin
    g_boClearID2 := CheckBoxClearID2.Checked;
  end else begin
    CheckBoxClearID2.Checked := g_boClearID2;
  end;
end;

procedure TfrmMain.NumericEditDayChange(Sender: TObject);
begin
  if not g_boStart then begin
    g_nLimitDay1 := NumericEditDay.IntValue;
  end else begin
    NumericEditDay.IntValue := g_nLimitDay1;
  end;
end;

procedure TfrmMain.NumericEditLevelChange(Sender: TObject);
begin
  if not g_boStart then begin
    g_nLimitLevel1 := NumericEditLevel.IntValue;
  end else begin
    NumericEditLevel.IntValue := g_nLimitLevel1;
  end;
end;

procedure TfrmMain.RzCheckBoxDuelClick(Sender: TObject);
begin
  if not g_boStart then begin
    g_boDuel := RzCheckBoxDuel.Checked;
  end else begin
    RzCheckBoxDuel.Checked := g_boDuel;
  end;
  RzGroupBox7.Enabled := g_boDuel;
  RzGroupBox8.Enabled := g_boDuel;
end;

procedure TfrmMain.RzCheckBoxItemBindClick(Sender: TObject);
begin
  if not g_boStart then begin
    g_boItemBind := RzCheckBoxItemBind.Checked;
  end else begin
    RzCheckBoxItemBind.Checked := g_boItemBind;
  end;
  RzGroupBox3.Enabled := g_boItemBind;
  RzGroupBox4.Enabled := g_boItemBind;
end;

procedure TfrmMain.RzCheckBoxItemDblClickClick(Sender: TObject);
begin
  if not g_boStart then begin
    g_boItemDblClick := RzCheckBoxItemDblClick.Checked;
  end else begin
    RzCheckBoxItemDblClick.Checked := g_boItemDblClick;
  end;
  RzGroupBox5.Enabled := g_boItemDblClick;
  RzGroupBox6.Enabled := g_boItemDblClick;
end;

procedure TfrmMain.NumericEditDay1Change(Sender: TObject);
begin
  if not g_boStart then begin
    g_nLimitDay2 := NumericEditDay1.IntValue;
  end else begin
    NumericEditDay1.IntValue := g_nLimitDay2;
  end;
end;

procedure TfrmMain.CheckBoxBigStorageClick(Sender: TObject);
begin
  if not g_boStart then begin
    g_boBigStorage := CheckBoxBigStorage.Checked;
  end else begin
    CheckBoxBigStorage.Checked := g_boBigStorage;
  end;
  ButtonEditBigStorage1.Enabled := g_boBigStorage;
  ButtonEditBigStorage2.Enabled := g_boBigStorage;
end;

procedure TfrmMain.CheckBoxSellOffClick(Sender: TObject);
begin
  if not g_boStart then begin
    g_boSellOff := CheckBoxSellOff.Checked;
  end else begin
    CheckBoxSellOff.Checked := g_boSellOff;
  end;
  ButtonEditSellOffSell1.Enabled := g_boSellOff;
  ButtonEditSellOffSell2.Enabled := g_boSellOff;
  ButtonEditSellOffGold1.Enabled := g_boSellOff;
  ButtonEditSellOffGold2.Enabled := g_boSellOff;
end;

procedure TfrmMain.CheckBoxCheckCopyItemsClick(Sender: TObject);
begin
  if not g_boStart then begin
    g_boCheckCopyItems := CheckBoxCheckCopyItems.Checked;
  end else begin
    CheckBoxCheckCopyItems.Checked := g_boCheckCopyItems;
  end;
end;

procedure TfrmMain.CheckBoxSetItemMakeIndexClick(Sender: TObject);
begin
  if not g_boStart then begin
    g_boSetItemMakeIndex := CheckBoxSetItemMakeIndex.Checked;
  end else begin
    CheckBoxSetItemMakeIndex.Checked := g_boSetItemMakeIndex;
  end;
end;

procedure TBlendThread.LoadIDDBList();
begin
  if g_boClose then Exit;
  if FileExists(g_sIDDB1) then begin
    ProcessMessage('正在读取主库ID.DB中的数据，请稍候...');
    try
      m_FileIDDBA.LoadQuickList();
    except
    end;
  end;

  if FileExists(g_sIDDB2) then begin
    ProcessMessage('正在读取从库ID.DB中的数据，请稍候...');
    try
      m_FileIDDBB.LoadQuickList();
    except
    end;
  end;
end;

procedure TBlendThread.LoadHumDBList();
begin
  if g_boClose then Exit;
  if FileExists(g_sHumDB1) then begin
    ProcessMessage('正在读取主库Hum.DB中的数据，请稍候...');
    try
      m_FileHumDBA.LoadQuickList();
    except

    end;
  end;

  if FileExists(g_sHumDB2) then begin
    ProcessMessage('正在读取从库Hum.DB中的数据，请稍候...');
    try
      m_FileHumDBB.LoadQuickList();
    except

    end;
  end;
end;

procedure TBlendThread.LoadMirDBList();
begin
  if g_boClose then Exit;

  if FileExists(g_sMirDB1) then begin
    ProcessMessage('正在读取主库Mir.DB中的数据，请稍候...');
    try
      m_FileDBA.LoadQuickList();
    except

    end;
  end;

  if FileExists(g_sMirDB2) then begin
    ProcessMessage('正在读取从库Mir.DB中的数据，请稍候...');
    try
      m_FileDBB.LoadQuickList();
    except

    end;
  end;

 {   if g_boCheckCopyItems then begin
      nPercent := 0;
      nCount := StringList.Count;
      RzStatusPane.Caption := '正在删除复制装备，请稍候...';
      for I := 0 to StringList.Count - 1 do begin
        Inc(nPercent);
        ProgressStatus.Percent := Trunc(nPercent / (nCount / 100));
        if g_boClose then Break;
        ChrRecordList := TList(StringList.Objects[I]);
        for II := 0 to ChrRecordList.Count - 1 do begin
          boFound := False;
          HumanRCD := pTHumDataInfo(ChrRecordList.Items[II]);
          for III := High(HumanRCD.Data.HumItems) downto Low(HumanRCD.Data.HumItems) do begin
            UserItem := @HumanRCD.Data.HumItems[III];
            for IIII := III - 1 downto Low(HumanRCD.Data.HumItems) do begin
              UserItem1 := @HumanRCD.Data.HumItems[IIII];
              if UserItem.MakeIndex = UserItem1.MakeIndex then begin
                FillChar(HumanRCD.Data.HumItems[IIII], SizeOf(TUserItem), #0);
              end;
            end;
          end;

          for III := High(HumanRCD.Data.BagItems) downto Low(HumanRCD.Data.BagItems) do begin
            UserItem := @HumanRCD.Data.BagItems[III];
            for IIII := III - 1 downto Low(HumanRCD.Data.BagItems) do begin
              UserItem1 := @HumanRCD.Data.BagItems[IIII];
              if UserItem.MakeIndex = UserItem1.MakeIndex then begin
                FillChar(HumanRCD.Data.BagItems[IIII], SizeOf(TUserItem), #0);
              end;
            end;
          end;

          for III := High(HumanRCD.Data.StorageItems) downto Low(HumanRCD.Data.StorageItems) do begin
            UserItem := @HumanRCD.Data.StorageItems[III];
            for IIII := III - 1 downto Low(HumanRCD.Data.StorageItems) do begin
              UserItem1 := @HumanRCD.Data.StorageItems[IIII];
              if UserItem.MakeIndex = UserItem1.MakeIndex then begin
                FillChar(HumanRCD.Data.StorageItems[IIII], SizeOf(TUserItem), #0);
              end;
            end;
          end;

        end;
      end;
    end;
  end; }
end;

procedure TBlendThread.LoadGuildBaseList();
begin
  try
    m_GuildBaseA.LoadQuickList(1);
  except

  end;
  try
    m_GuildBaseB.LoadQuickList(2);
  except

  end;
end;

procedure TBlendThread.LoadBigStorageList();
begin
  if g_boClose then Exit;
  if FileExists(g_sBigStorage1) then begin
    ProcessMessage('正在读取主库UserStorage.DB中的数据，请稍候...');
    try
      m_StorageA.LoadQuickList();
    except

    end;
  end;

  if FileExists(g_sBigStorage2) then begin
    ProcessMessage('正在读取从库UserStorage.DB中的数据，请稍候...');
    try
      m_StorageB.LoadQuickList();
    except

    end;
  end;
end;

procedure TBlendThread.LoadSellOffSellList();
begin
  if g_boClose then Exit;
  if FileExists(g_sSellOffSell1) then begin
    ProcessMessage('正在读取主库UserSellOff.sell中的数据，请稍候...');
    try
      m_SellOffA.LoadQuickList();
    except

    end;
  end;
  if FileExists(g_sSellOffSell2) then begin
    ProcessMessage('正在读取从库UserSellOff.sell中的数据，请稍候...');
    try
      m_SellOffB.LoadQuickList();
    except

    end;
  end;
end;

procedure TBlendThread.LoadSellOffGoldList();
begin
  if g_boClose then Exit;

  if FileExists(g_sSellOffGold1) then begin
    ProcessMessage('正在读取主库UserSellOff.Gold中的数据，请稍候...');
    try
      m_SellGoldA.LoadQuickList();
    except

    end;
  end;

  if FileExists(g_sSellOffGold2) then begin
    ProcessMessage('正在读取从库UserSellOff.Gold中的数据，请稍候...');
    try
      m_SellGoldB.LoadQuickList();
    except

    end;
  end;
end;






procedure TBlendThread.LoadDuelInfoList();
begin
  if g_boClose then Exit;
  if FileExists(g_sDuelInfo1) then begin
    ProcessMessage('正在读取主库Duel.Duel中的数据，请稍候...');
    try
      m_DuelInfoDBA.LoadQuickList();
    except

    end;
  end;
  if FileExists(g_sDuelInfo2) then begin
    ProcessMessage('正在读取从库Duel.Duel中的数据，请稍候...');
    try
      m_DuelInfoDBB.LoadQuickList();
    except

    end;
  end;
end;

procedure TBlendThread.LoadDuelItemList();
begin
  if g_boClose then Exit;
  if FileExists(g_sDuelItem1) then begin
    ProcessMessage('正在读取主库Duel.Item中的数据，请稍候...');
    try
      m_DuelItemDBA.LoadQuickList();
    except

    end;
  end;
  if FileExists(g_sDuelItem2) then begin
    ProcessMessage('正在读取从库Duel.Item中的数据，请稍候...');
    try
      m_DuelItemDBB.LoadQuickList();
    except

    end;
  end;
end;




procedure TfrmMain.BitBtnStartClick(Sender: TObject);
  function GetDir(Src: string): string;
  var
    sSrc: string;
  begin
    sSrc := Trim(Src);
    Result := sSrc;
    if (sSrc <> '') then begin
      if sSrc[Length(sSrc)] <> '\' then Result := sSrc + '\' else Result := sSrc;
    end;
  end;
  function GetItemNumber(sConfigFileName: string): Integer;
  var
    Config: TIniFile;
  begin
    Config := TIniFile.Create(sConfigFileName);
    Result := Config.ReadInteger('Setup', 'ItemNumber', 0);
    Config.Free;
  end;
  function GetItemNumberEx(sConfigFileName: string): Integer;
  var
    Config: TIniFile;
  begin
    Config := TIniFile.Create(sConfigFileName);
    Result := Config.ReadInteger('Setup', 'ItemNumberEx', 0);
    Config.Free;
  end;
  procedure WriteConfig();
  var
    Config: TIniFile;
  begin
    Config := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
    Config.WriteString('Setup', 'Save', g_sSaveDir);

    Config.WriteString('Setup', 'ID1', g_sIDDB1);
    Config.WriteString('Setup', 'ID2', g_sIDDB2);

    Config.WriteString('Setup', 'Hum1', g_sHumDB1);
    Config.WriteString('Setup', 'Hum2', g_sHumDB2);

    Config.WriteString('Setup', 'Mir1', g_sMirDB1);
    Config.WriteString('Setup', 'Mir2', g_sMirDB2);

    Config.WriteString('Setup', 'GuildBase1', g_sGuildBase1);
    Config.WriteString('Setup', 'GuildBase2', g_sGuildBase2);

    Config.WriteString('Setup', 'BigStorage1', g_sBigStorage1);
    Config.WriteString('Setup', 'BigStorage2', g_sBigStorage2);

    Config.WriteString('Setup', 'SellOffSell1', g_sSellOffSell1);
    Config.WriteString('Setup', 'SellOffSell2', g_sSellOffSell2);

    Config.WriteString('Setup', 'SellOffGold1', g_sSellOffGold1);
    Config.WriteString('Setup', 'SellOffGold2', g_sSellOffGold2);
    Config.WriteString('Setup', '!Setup1', g_sSetup1);
    Config.WriteString('Setup', '!Setup2', g_sSetup2);

    Config.WriteString('Setup', 'RememberItemList1', g_sRememberItemList1);
    Config.WriteString('Setup', 'ItemBindIPaddr1', g_sItemBindIPaddr1);
    Config.WriteString('Setup', 'ItemBindAccount1', g_sItemBindAccount1);
    Config.WriteString('Setup', 'ItemBindChrName1', g_sItemBindChrName1);

    Config.WriteString('Setup', 'RememberItemList2', g_sRememberItemList2);
    Config.WriteString('Setup', 'ItemBindIPaddr2', g_sItemBindIPaddr2);
    Config.WriteString('Setup', 'ItemBindAccount2', g_sItemBindAccount2);
    Config.WriteString('Setup', 'ItemBindChrName2', g_sItemBindChrName2);


    Config.WriteString('Setup', 'DuelInfo1', g_sDuelInfo1);
    Config.WriteString('Setup', 'DuelInfo2', g_sDuelInfo2);

    Config.WriteString('Setup', 'DuelItem1', g_sDuelItem1);
    Config.WriteString('Setup', 'DuelItem2', g_sDuelItem2);

    Config.Free;

    g_DynamicVarListA.SaveToFile(ExtractFilePath(Application.ExeName) + 'DynamicVarList(主).txt');
    g_DynamicVarListB.SaveToFile(ExtractFilePath(Application.ExeName) + 'DynamicVarList(从).txt');

    g_CharNameListA.SaveToFile(ExtractFilePath(Application.ExeName) + 'CharNameList(主).txt');
    g_CharNameListB.SaveToFile(ExtractFilePath(Application.ExeName) + 'CharNameList(从).txt');
  end;
begin
  if g_boStart then begin
    if Application.MessageBox('是否确认取消合并？',
      '确认信息',
      MB_YESNO + MB_ICONQUESTION) <> IDYES then Exit;
    g_boClose := True;
    g_boStart := False;
    //BlendThread.Terminate;
  end else begin
    g_sIDDB1 := Trim(ButtonEditIDDB1.Text);
    g_sHumDB1 := Trim(ButtonEditHumDB1.Text);
    g_sMirDB1 := Trim(ButtonEditMirDB1.Text);
    g_sGuildBase1 := GetDir(ButtonEditGuildBase1.Text);
    g_sBigStorage1 := Trim(ButtonEditBigStorage1.Text);
    g_sSellOffSell1 := Trim(ButtonEditSellOffSell1.Text);
    g_sSellOffGold1 := Trim(ButtonEditSellOffGold1.Text);
    g_sSetup1 := Trim(ButtonEditSetup1.Text);

    g_sIDDB2 := Trim(ButtonEditIDDB2.Text);
    g_sHumDB2 := Trim(ButtonEditHumDB2.Text);
    g_sMirDB2 := Trim(ButtonEditMirDB2.Text);
    g_sGuildBase2 := GetDir(ButtonEditGuildBase2.Text);
    g_sBigStorage2 := Trim(ButtonEditBigStorage2.Text);
    g_sSellOffSell2 := Trim(ButtonEditSellOffSell2.Text);
    g_sSellOffGold2 := Trim(ButtonEditSellOffGold2.Text);
    g_sSetup2 := Trim(ButtonEditSetup2.Text);
    g_sSaveDir := GetDir(ButtonEditSaveDir.Text);


    g_sRememberItemList1 := Trim(EditRememberItemListA.Text);
    g_sItemBindIPaddr1 := Trim(EditBindIPaddrA.Text);
    g_sItemBindAccount1 := Trim(EditBindAccountA.Text);
    g_sItemBindChrName1 := Trim(EditBindCharNameA.Text);

    g_sRememberItemList2 := Trim(EditRememberItemListB.Text);
    g_sItemBindIPaddr2 := Trim(EditBindIPaddrB.Text);
    g_sItemBindAccount2 := Trim(EditBindAccountB.Text);
    g_sItemBindChrName2 := Trim(EditBindCharNameB.Text);

    g_sDuelInfo1 := Trim(EditDuelInfoA.Text);
    g_sDuelInfo2 := Trim(EditDuelInfoB.Text);
    g_sDuelItem1 := Trim(EditDuelItemA.Text);
    g_sDuelItem2 := Trim(EditDuelItemB.Text);

    if not FileExists(g_sIDDB1) then begin
      Application.MessageBox('没有发现主库: ID.DB ！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
    if not FileExists(g_sIDDB2) then begin
      Application.MessageBox('没有发现从库: ID.DB ！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
    if not FileExists(g_sHumDB1) then begin
      Application.MessageBox('没有发现主库: Hum.DB ！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
    if not FileExists(g_sHumDB2) then begin
      Application.MessageBox('没有发现从库: Hum.DB ！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
    if not FileExists(g_sMirDB1) then begin
      Application.MessageBox('没有发现主库: Mir.DB ！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
    if not FileExists(g_sMirDB2) then begin
      Application.MessageBox('没有发现从库: Mir.DB ！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
    if g_sGuildBase1 = '' then begin
      Application.MessageBox('请设置主库: GuildBase目录 ！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
    if g_sGuildBase2 = '' then begin
      Application.MessageBox('请设置从库: GuildBase目录 ！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
    if g_boBigStorage then begin
      if not FileExists(g_sBigStorage1) then begin
        Application.MessageBox('没有发现主库: UserStorage.DB ！！！', '提示信息', MB_ICONQUESTION);
        Exit;
      end;
      if not FileExists(g_sBigStorage2) then begin
        Application.MessageBox('没有发现从库: UserStorage.DB ！！！', '提示信息', MB_ICONQUESTION);
        Exit;
      end;
    end;
    if g_boSellOff then begin
      if not FileExists(g_sSellOffSell1) then begin
        Application.MessageBox('没有发现主库: UserSellOff.sell ！！！', '提示信息', MB_ICONQUESTION);
        Exit;
      end;
      if not FileExists(g_sSellOffSell2) then begin
        Application.MessageBox('没有发现从库: UserSellOff.sell ！！！', '提示信息', MB_ICONQUESTION);
        Exit;
      end;
      if not FileExists(g_sSellOffGold1) then begin
        Application.MessageBox('没有发现主库: UserSellOff.Gold ！！！', '提示信息', MB_ICONQUESTION);
        Exit;
      end;
      if not FileExists(g_sSellOffGold2) then begin
        Application.MessageBox('没有发现从库: UserSellOff.Gold ！！！', '提示信息', MB_ICONQUESTION);
        Exit;
      end;
    end;

    if g_boDuel then begin
      if not FileExists(g_sDuelItem1) then begin
        Application.MessageBox('没有发现主库: Duel.Item ！！！', '提示信息', MB_ICONQUESTION);
        Exit;
      end;
      if not FileExists(g_sDuelItem2) then begin
        Application.MessageBox('没有发现从库: Duel.Item ！！！', '提示信息', MB_ICONQUESTION);
        Exit;
      end;
      if not FileExists(g_sDuelInfo1) then begin
        Application.MessageBox('没有发现主库: Duel.Duel ！！！', '提示信息', MB_ICONQUESTION);
        Exit;
      end;
      if not FileExists(g_sDuelInfo2) then begin
        Application.MessageBox('没有发现从库: Duel.Duel ！！！', '提示信息', MB_ICONQUESTION);
        Exit;
      end;
    end;

    if not FileExists(g_sSetup1) then begin
      Application.MessageBox('没有发现主库: !Setup.txt ！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
    if not FileExists(g_sSetup2) then begin
      Application.MessageBox('没有发现从库: !Setup.txt ！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
    if g_sSaveDir = '' then begin
      Application.MessageBox('请设置数据库保存目录 ！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
    if Application.MessageBox('必须关闭服务后才能进行操作，确认不在服务状态吗？',
      '确认信息',
      MB_YESNO + MB_ICONQUESTION) <> IDYES then Exit;
    if not DirectoryExists(g_sSaveDir) then begin
      CreateDir(g_sSaveDir);
    end;
    {if BlendThread <> nil then begin
      BlendThread.Terminate;
      FreeAndnil(BlendThread);
    end;}
    g_boClose := False;
    g_boStart := True;
    g_nMaxItemMakeIndex := GetItemNumber(g_sSetup1);
    g_nMaxItemMakeIndexEx := GetItemNumberEx(g_sSetup1);
    WriteConfig();
    BlendThread := TBlendThread.Create(False);
  end;
end;

procedure TfrmMain.EditBindAccountAButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'ItemBindAccount.txt|*.txt';
  if OpenDialog.Execute then begin
    EditBindAccountA.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditBindAccountBButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'ItemBindAccount.txt|*.txt';
  if OpenDialog.Execute then begin
    EditBindAccountB.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditBindCharNameAButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'ItemBindChrName.txt|*.txt';
  if OpenDialog.Execute then begin
    EditBindCharNameA.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditBindCharNameBButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'ItemBindChrName.txt|*.txt';
  if OpenDialog.Execute then begin
    EditBindCharNameB.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditBindIPaddrAButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'ItemBindIPaddr.txt|*.txt';
  if OpenDialog.Execute then begin
    EditBindIPaddrA.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditBindIPaddrBButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'ItemBindIPaddr.txt|*.txt';
  if OpenDialog.Execute then begin
    EditBindIPaddrB.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditRememberItemListAButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'RememberItemList.txt|*.txt';
  if OpenDialog.Execute then begin
    EditRememberItemListA.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditRememberItemListBButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'RememberItemList.txt|*.txt';
  if OpenDialog.Execute then begin
    EditRememberItemListB.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditDuelInfoAButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'Duel.Duel|*.Duel';
  if OpenDialog.Execute then begin
    EditDuelInfoA.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditDuelInfoBButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'Duel.Duel|*.Duel';
  if OpenDialog.Execute then begin
    EditDuelInfoB.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditDuelItemAButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'Duel.Item|*.Item';
  if OpenDialog.Execute then begin
    EditDuelItemA.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditDuelItemBButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'Duel.Item|*.Item';
  if OpenDialog.Execute then begin
    EditDuelItemB.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditDynamicVarAButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := '文本文件|*.txt';
  if OpenDialog.Execute then begin
    EditDynamicVarA.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditDynamicVarBButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := '文本文件|*.txt';
  if OpenDialog.Execute then begin
    EditDynamicVarB.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditCharNameAButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := '文本文件|*.txt';
  if OpenDialog.Execute then begin
    EditCharNameA.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.EditCharNameBButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := '文本文件|*.txt';
  if OpenDialog.Execute then begin
    EditCharNameB.Text := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.ButtonCharNameAddClick(Sender: TObject);
var
  sCharNameFileNameA: string;
  sCharNameFileNameB: string;
begin
  sCharNameFileNameA := Trim(EditCharNameA.Text);
  sCharNameFileNameB := Trim(EditCharNameB.Text);
  if (sCharNameFileNameA <> '') and (sCharNameFileNameB <> '') then begin
    g_CharNameListA.Add(sCharNameFileNameA);
    g_CharNameListB.Add(sCharNameFileNameB);
    ListBoxCharNameA.Clear;
    ListBoxCharNameA.Items.AddStrings(g_CharNameListA);
    ListBoxCharNameB.Clear;
    ListBoxCharNameB.Items.AddStrings(g_CharNameListB);
  end;
end;

procedure TfrmMain.ButtonCharNameDelClick(Sender: TObject);
begin
  if ListBoxCharNameA.ItemIndex >= 0 then begin
    g_CharNameListA.Delete(ListBoxCharNameA.ItemIndex);
    g_CharNameListB.Delete(ListBoxCharNameA.ItemIndex);
    ListBoxCharNameA.Clear;
    ListBoxCharNameA.Items.AddStrings(g_CharNameListA);
    ListBoxCharNameB.Clear;
    ListBoxCharNameB.Items.AddStrings(g_CharNameListB);
    ButtonCharNameDel.Enabled := False;
  end;
end;

procedure TfrmMain.ListBoxCharNameAClick(Sender: TObject);
begin
  {ListBoxCharNameB.ItemIndex := ListBoxCharNameA.ItemIndex;
  if ListBoxCharNameB.ItemIndex >= 0 then begin
    ButtonCharNameDel.Enabled := True;
  end else begin
    ButtonCharNameDel.Enabled := False;
  end;}
end;

procedure TfrmMain.ListBoxCharNameBClick(Sender: TObject);
begin
  {ListBoxCharNameA.ItemIndex := ListBoxCharNameB.ItemIndex;
  if ListBoxCharNameA.ItemIndex >= 0 then begin
    ButtonCharNameDel.Enabled := True;
  end else begin
    ButtonCharNameDel.Enabled := False;
  end;}
end;

procedure TfrmMain.ListBoxDynamicVarBMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ListBoxDynamicVarA.ItemIndex := ListBoxDynamicVarB.ItemIndex;
  if ListBoxDynamicVarA.ItemIndex >= 0 then begin
    ButtonDynamicVarDel.Enabled := True;
  end else begin
    ButtonDynamicVarDel.Enabled := False;
  end;
end;

procedure TfrmMain.ListBoxDynamicVarAMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ListBoxDynamicVarB.ItemIndex := ListBoxDynamicVarA.ItemIndex;
  if ListBoxDynamicVarB.ItemIndex >= 0 then begin
    ButtonDynamicVarDel.Enabled := True;
  end else begin
    ButtonDynamicVarDel.Enabled := False;
  end;
end;

procedure TfrmMain.ListBoxCharNameAMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ListBoxCharNameB.ItemIndex := ListBoxCharNameA.ItemIndex;
  if ListBoxCharNameB.ItemIndex >= 0 then begin
    ButtonCharNameDel.Enabled := True;
  end else begin
    ButtonCharNameDel.Enabled := False;
  end;
end;

procedure TfrmMain.ListBoxCharNameBMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ListBoxCharNameA.ItemIndex := ListBoxCharNameB.ItemIndex;
  if ListBoxCharNameA.ItemIndex >= 0 then begin
    ButtonCharNameDel.Enabled := True;
  end else begin
    ButtonCharNameDel.Enabled := False;
  end;
end;

end.

