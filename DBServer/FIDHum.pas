unit FIDHum;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, DB, DBTables, Grids, Buttons, HumDB, Grobal2;
type
  TFrmIDHum = class(TForm)
    Label3: TLabel;
    EdChrName: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    BtnCreateChr: TSpeedButton;
    BtnEraseChr: TSpeedButton;
    BtnChrNameSearch: TSpeedButton;
    IdGrid: TStringGrid;
    ChrGrid: TStringGrid;
    BtnSelAll: TSpeedButton;
    CbShowDelChr: TCheckBox;
    BtnDeleteChr: TSpeedButton;
    BtnRevival: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    EdUserId: TEdit;
    BtnDeleteChrAllInfo: TSpeedButton;
    BtnChrIndex: TSpeedButton;
    LabelCount: TLabel;
    BtnEditData: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnChrNameSearchClick(Sender: TObject);
    procedure BtnSelAllClick(Sender: TObject);
    procedure BtnEraseChrClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChrGridClick(Sender: TObject);
    procedure ChrGridDblClick(Sender: TObject);
    procedure BtnDeleteChrClick(Sender: TObject);
    procedure BtnRevivalClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);

    procedure BtnCreateChrClick(Sender: TObject);
    procedure BtnDeleteChrAllInfoClick(Sender: TObject);
    procedure BtnChrIndexClick(Sender: TObject);
    procedure RefChrGrid(n08: Integer; HumDBRecord: THumInfo);

    procedure EdChrNameKeyPress(Sender: TObject; var Key: Char);
    procedure EdUserIdKeyPress(Sender: TObject; var Key: Char);
    procedure BtnEditDataClick(Sender: TObject);
  private

  public

  end;

var
  FrmIDHum: TFrmIDHum;

implementation

uses HUtil32, MudUtil, CreateChr, viewrcd, EditRcd, DBShare;

{$R *.DFM}

procedure TFrmIDHum.FormCreate(Sender: TObject);
begin
  IdGrid.Cells[0, 0] := '登录帐号';
  IdGrid.Cells[1, 0] := '密码';
  IdGrid.Cells[2, 0] := '用户名称';
  IdGrid.Cells[3, 0] := 'ResiRegi';
  IdGrid.Cells[4, 0] := 'Tran';
  IdGrid.Cells[5, 0] := 'Secretwd';
  IdGrid.Cells[6, 0] := 'Adress(cont)';
  IdGrid.Cells[7, 0] := '备注';

  ChrGrid.Cells[0, 0] := 'Index';
  ChrGrid.Cells[1, 0] := 'Character';
  ChrGrid.Cells[2, 0] := 'ID';
  ChrGrid.Cells[3, 0] := 'Deleted';
  ChrGrid.Cells[4, 0] := 'Mod Date';
  ChrGrid.Cells[5, 0] := 'Count';
  ChrGrid.Cells[6, 0] := 'Select ID';
  ChrGrid.Cells[7, 0] := 'Hero';
end;

procedure TFrmIDHum.EdUserIdKeyPress(Sender: TObject; var Key: Char);
var
  sAccount: string;
  ChrList: TList;
  I, nIndex: Integer;
  HumDBRecord: THumInfo;
begin
  if Key = #13 then begin
    Key := #0;
    sAccount := EdUserId.Text;
    ChrGrid.RowCount := 1;
    if sAccount <> '' then begin
      try
        if g_HumCharDB.OpenEx then begin
          if g_HumCharDB.FindByAccount(sAccount, ChrList) >= 0 then begin
            for I := 0 to ChrList.Count - 1 do begin
              nIndex := pTQuickID(ChrList.Items[I]).nIndex;
              if nIndex >= 0 then begin
                g_HumCharDB.GetBy(nIndex, @HumDBRecord);
                if CbShowDelChr.Checked then RefChrGrid(nIndex, HumDBRecord)
                else if not HumDBRecord.boDeleted then
                  RefChrGrid(nIndex, HumDBRecord);
              end;
            end;
          end;
        end;
      finally
        g_HumCharDB.Close;
      end;
    end;
  end;
end;

procedure TFrmIDHum.EdChrNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    Key := #0;
    BtnChrNameSearchClick(Sender);
  end;
end;

procedure TFrmIDHum.BtnChrNameSearchClick(Sender: TObject);
var
  s64: string;
  n08, nIndex: Integer;
  HumDBRecord: THumInfo;
begin
  s64 := EdChrName.Text;
  ChrGrid.RowCount := 1;
  try
    if g_HumCharDB.OpenEx then begin
      n08 := g_HumCharDB.Index(s64);
      if n08 >= 0 then begin
        nIndex := g_HumCharDB.Get(n08, @HumDBRecord);
        if nIndex >= 0 then begin
          if CbShowDelChr.Checked then RefChrGrid(nIndex, HumDBRecord)
          else if not HumDBRecord.boDeleted then
            RefChrGrid(nIndex, HumDBRecord);
        end;
      end;
    end;
  finally
    g_HumCharDB.Close;
  end;
end;

procedure TFrmIDHum.BtnSelAllClick(Sender: TObject);
var
  sChrName: string;
  ChrList: TList;
  I, nIndex: Integer;
  HumDBRecord: THumInfo;
begin
  sChrName := EdChrName.Text;
  ChrGrid.RowCount := 1;
  ChrList := TList.Create;
  try
    if g_HumCharDB.OpenEx then begin
      if g_HumCharDB.FindByName(sChrName, ChrList) > 0 then begin
        for I := 0 to ChrList.Count - 1 do begin
          nIndex := Integer(ChrList.Items[I]);
          if g_HumCharDB.GetBy(nIndex, @HumDBRecord) then begin
            if CbShowDelChr.Checked then RefChrGrid(nIndex, HumDBRecord)
            else if not HumDBRecord.boDeleted then
              RefChrGrid(nIndex, HumDBRecord);
          end;
        end;
      end;
    end;
  finally
    g_HumCharDB.Close;
  end;
  ChrList.Free;
end;

procedure TFrmIDHum.BtnEraseChrClick(Sender: TObject);
var
  sChrName: string;
begin
  sChrName := EdChrName.Text;
  if sChrName = '' then Exit;
  if MessageDlg('是否确认删除人物 ' + sChrName + ' ？', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    try
      if g_HumCharDB.Open then begin
        g_HumCharDB.Delete(sChrName);
      end;
    finally
      g_HumCharDB.Close;
    end;
  end;
end;

procedure TFrmIDHum.FormShow(Sender: TObject);
begin
  EdChrName.SetFocus;
end;

procedure TFrmIDHum.ChrGridClick(Sender: TObject);
var
  nRow: Integer;
begin
  nRow := ChrGrid.Row;
  if nRow < 1 then Exit;
  if ChrGrid.RowCount - 1 < nRow then Exit;
  EdChrName.Text := ChrGrid.Cells[1, nRow];
end;

procedure TFrmIDHum.ChrGridDblClick(Sender: TObject);
var
  n8, nC: Integer;
  s10: string;
  ChrRecord: THumDataInfo;
begin
  s10 := '';
  n8 := ChrGrid.Row;
  if (n8 >= 1) and (ChrGrid.RowCount - 1 >= n8) then
    s10 := ChrGrid.Cells[1, n8];
  try
    if g_HumDataDB.OpenEx then begin
      nC := g_HumDataDB.Index(s10);
      if nC >= 0 then begin
        if g_HumDataDB.Get(nC, @ChrRecord) >= 0 then begin
          FrmFDBViewer.n2F8 := nC;
          FrmFDBViewer.s2FC := s10;
          FrmFDBViewer.ChrRecord := ChrRecord;
          FrmFDBViewer.ShowHumData;
          FrmFDBViewer.Left := FrmIDHum.Left - 144;
          FrmFDBViewer.Top := FrmIDHum.Top + 100;
          FrmFDBViewer.Show;
        end;
      end;
    end;
  finally
    g_HumDataDB.Close;
  end;
end;

procedure TFrmIDHum.BtnDeleteChrClick(Sender: TObject);
var
  sChrName: string;
  nIndex: Integer;
  HumRecord: THumInfo;
begin
  sChrName := EdChrName.Text;
  if sChrName = '' then Exit;
  if MessageDlg('是否确认禁用人物 ' + sChrName + ' ？', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    try
      if g_HumCharDB.Open then begin
        nIndex := g_HumCharDB.Index(sChrName);
        g_HumCharDB.Get(nIndex, @HumRecord);
        HumRecord.boDeleted := True;
        HumRecord.dModDate := Now();
        Inc(HumRecord.btCount);
        g_HumCharDB.Update(nIndex, @HumRecord);
      end;
    finally
      g_HumCharDB.Close;
    end;
  end;
end;

procedure TFrmIDHum.BtnRevivalClick(Sender: TObject);
var
  sChrName: string;
  nIndex: Integer;
  HumRecord: THumInfo;
begin
  sChrName := EdChrName.Text;
  if sChrName = '' then Exit;
  if MessageDlg('是否确认启用人物 ' + sChrName + ' ？', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    try
      if g_HumCharDB.Open then begin
        nIndex := g_HumCharDB.Index(sChrName);
        g_HumCharDB.Get(nIndex, @HumRecord);
        HumRecord.boDeleted := False;
        Inc(HumRecord.btCount);
        g_HumCharDB.Update(nIndex, @HumRecord);
      end;
    finally
      g_HumCharDB.Close;
    end;
  end;
end;

procedure TFrmIDHum.SpeedButton1Click(Sender: TObject);
begin
  //FrmFDBExplore.Show;
end;

procedure TFrmIDHum.BtnCreateChrClick(Sender: TObject);
var
  nCheckCode: Integer;
  HumRecord: THumInfo;
begin
  if not FrmCreateChr.IncputChrInfo then Exit;
  nCheckCode := 0;
  try
    if g_HumCharDB.Open then begin
      if g_HumCharDB.ChrCountOfAccount(FrmCreateChr.sUserId) < 2 then begin
        HumRecord.Header.boDeleted := False;
        HumRecord.Header.boIsHero := False;
        HumRecord.Header.sName := FrmCreateChr.sChrName;
        HumRecord.Header.nSelectID := FrmCreateChr.nSelectID;
        HumRecord.boIsHero := False;
        //HumRecord.boSelected := True;
        HumRecord.sChrName := FrmCreateChr.sChrName;
        HumRecord.sAccount := FrmCreateChr.sUserId;
        HumRecord.boDeleted := False;
        HumRecord.btCount := 0;
        if HumRecord.Header.sName <> '' then begin
          if not g_HumCharDB.Add(@HumRecord) then nCheckCode := 2;
        end;
      end else nCheckCode := 3;
    end;
  finally
    g_HumCharDB.Close;
  end;
  if nCheckCode = 0 then ShowMessage('人物创建成功...')
  else ShowMessage('人物创建失败！！！')
end;

procedure TFrmIDHum.BtnDeleteChrAllInfoClick(Sender: TObject);
var
  sChrName: string;
begin
  sChrName := EdChrName.Text;
  if sChrName = '' then Exit;
  if MessageDlg('是否确认删除人物 ' + sChrName + ' 及人物数据？', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    try
      if g_HumCharDB.Open then begin
        g_HumCharDB.Delete(sChrName);
      end;
    finally
      g_HumCharDB.Close;
    end;
    try
      if g_HumDataDB.Open then g_HumDataDB.Delete(sChrName);
    finally
      g_HumDataDB.Close;
    end;
  end;
end;

procedure TFrmIDHum.BtnChrIndexClick(Sender: TObject);
var
  nIndex: Integer;
  HumRecord: THumInfo;
  nRow: Integer;
begin
  nRow := ChrGrid.Row;
  if nRow < 1 then Exit;
  if ChrGrid.RowCount - 1 < nRow then Exit;
  nIndex := Str_ToInt(ChrGrid.Cells[0, nRow], 0);
  if MessageDlg('是否确认禁用记录 ' + IntToStr(nIndex) + ' ？', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    try
      if g_HumCharDB.Open then begin
        if g_HumCharDB.GetBy(nIndex, @HumRecord) then begin
          HumRecord.boDeleted := True;
          HumRecord.dModDate := Now();
          Inc(HumRecord.btCount);
          g_HumCharDB.UpdateBy(nIndex, @HumRecord);
        end;
      end;
    finally
      g_HumCharDB.Close;
    end;
  end;
end;

procedure TFrmIDHum.RefChrGrid(n08: Integer; HumDBRecord: THumInfo);
var
  nRowCount: Integer;
begin
  ChrGrid.RowCount := ChrGrid.RowCount + 1;
  ChrGrid.FixedRows := 1;
  nRowCount := ChrGrid.RowCount - 1;
  ChrGrid.Cells[0, nRowCount] := IntToStr(n08);
  ChrGrid.Cells[1, nRowCount] := HumDBRecord.sChrName;
  ChrGrid.Cells[2, nRowCount] := HumDBRecord.sAccount;
  ChrGrid.Cells[3, nRowCount] := BoolToStr(HumDBRecord.boDeleted);
  if HumDBRecord.boDeleted then
    ChrGrid.Cells[4, nRowCount] := DateTimeToStr(HumDBRecord.dModDate)
  else ChrGrid.Cells[4, nRowCount] := '';

  ChrGrid.Cells[5, nRowCount] := IntToStr(HumDBRecord.btCount);
  ChrGrid.Cells[6, nRowCount] := IntToStr(HumDBRecord.Header.nSelectID);
  ChrGrid.Cells[7, nRowCount] := BoolToStr(HumDBRecord.boIsHero);
  LabelCount.Caption := IntToStr(ChrGrid.RowCount - 1);
end;

procedure TFrmIDHum.BtnEditDataClick(Sender: TObject);
var
  nRow, nIdx: Integer;
  sName: string;
  ChrRecord: THumDataInfo;
begin
  sName := '';
  nRow := ChrGrid.Row;
  if (nRow >= 1) and (ChrGrid.RowCount - 1 >= nRow) then
    sName := ChrGrid.Cells[1, nRow];
  if sName = '' then Exit;
  try
    if g_HumDataDB.OpenEx then begin
      nIdx := g_HumDataDB.Index(sName);
      if nIdx >= 0 then begin
        if g_HumDataDB.Get(nIdx, @ChrRecord) >= 0 then begin
          frmEditRcd.m_nIdx := nIdx;
          frmEditRcd.m_ChrRcd := ChrRecord;
        end;
      end;
    end;
  finally
    g_HumDataDB.Close;
  end;
  frmEditRcd.Left := FrmIDHum.Left + 50;
  frmEditRcd.Top := FrmIDHum.Top + 50;
  frmEditRcd.Open;
end;

end.

