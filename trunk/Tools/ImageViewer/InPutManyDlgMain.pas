unit InPutManyDlgMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzRadChk, RzBtnEdt, StdCtrls, Mask, RzEdit, RzLabel,
  RzPanel, ExtCtrls, RzRadGrp, SelectPath, Buttons, ComCtrls, SDK, HUtil32, DIB, GameImages;

type
  TLoadBitmapType = (t_BMP, t_BM, t_PT, t_SM);
  TAddBitmapType = (t_Add, t_Insert, t_Replace);

  TfrmInPutManyDlg = class(TForm)
    GroupBox2: TRzGroupBox;
    EditX: TRzNumericEdit;
    EditY: TRzNumericEdit;
    EditFileDir: TRzButtonEdit;
    GroupBox4: TRzGroupBox;
    RadioButton1: TRzRadioButton;
    RadioButton2: TRzRadioButton;
    EditXY: TRzEdit;
    RadioGroup1: TRadioGroup;
    RadioGroup3: TRadioGroup;
    RzLabel: TLabel;
    RzLabel1: TLabel;
    RzLabel2: TLabel;
    BitBtnOK: TBitBtn;
    BitBtnClose: TBitBtn;
    ProgressBar: TProgressBar;
    procedure BitBtnOKClick(Sender: TObject);
    procedure BitBtnCloseClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure RadioGroup3Click(Sender: TObject);
    procedure EditFileDirButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    procedure LoadBitmap(LoadType: TLoadBitmapType; const FileName: string; var Source: TDIB; var nX, nY: Integer);
    procedure AddBitmap(nIndex, nX, nY: Integer; Source: TDIB; AddType: TAddBitmapType);
  public
    procedure Open(nIndex: Integer);
  end;

var
  frmInPutManyDlg: TfrmInPutManyDlg;

implementation
uses MirShare;
var
  StringList: TSortStringList;
{$R *.dfm}

function GetDIB(const FileName: string): TDIB;
var
  DIB, Source: TDIB;
begin
  if not FileExists(FileName) then begin
    Result := CurrImageFile.FillDIB;
    Exit;
  end;

  Source := TDIB.Create;
  try
    Source.LoadFromFile(FileName);
  except
    Source.Free;
    Result := CurrImageFile.FillDIB;
    Exit;
  end;
  case CurrImageFile.BitCount of
    8: begin
        if (CurrImageFile.BitCount <> Source.BitCount) or (WidthBytes(Source.Width) <> Source.Width) then begin
          DIB := TDIB.Create;
          DIB.SetSize(WidthBytes(Source.Width), Source.Height, 8);
          DIB.ColorTable := MainPalette;
          DIB.UpdatePalette;
          DIB.Canvas.Brush.Color := clblack;
          DIB.Canvas.FillRect(DIB.Canvas.ClipRect);

          DIB.Canvas.Draw(0, 0, Source);
          Source.Assign(DIB);
          DIB.Free;
        end;
      end;
    16: begin
        Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
        Source.BitCount := CurrImageFile.BitCount;
      end;
    24: begin
        Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
        Source.BitCount := CurrImageFile.BitCount;
      end;
    32: begin
        Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
        Source.BitCount := CurrImageFile.BitCount;
      end;
  end;
  Result := Source;
end;

procedure TfrmInPutManyDlg.Open(nIndex: Integer);
begin
  ProgressBar.Position := 0;
  ProgressBar.Max := 100;
  EditX.IntValue := nIndex;
  if Assigned(CurrImageFile) then
    EditY.IntValue := CurrImageFile.ImageCount - 1;
  ShowModal;
end;

procedure TfrmInPutManyDlg.LoadBitmap(LoadType: TLoadBitmapType; const FileName: string; var Source: TDIB; var nX, nY: Integer);
var
  Pt: TPoint;
begin
  case LoadType of
    t_BMP: begin
        Source := GetDIB(FileName);
        if RadioButton1.Checked then begin
          Pt := GetPoint(FileName);
          nX := Pt.X;
          nY := Pt.Y;
        end;
      end;

    t_BM: begin
        Source := GetDIB(FileName);
      end;

    t_PT: begin
        Source := GetDIB('');
        if RadioButton1.Checked then begin
          Pt := GetPoint(FileName);
          nX := Pt.X;
          nY := Pt.Y;
        end;
      end;

    t_SM: begin
        Source := GetDIB('');
      end;
  end;
end;

procedure TfrmInPutManyDlg.AddBitmap(nIndex, nX, nY: Integer; Source: TDIB; AddType: TAddBitmapType);
begin
 {case AddType of
    t_Add: CurrImageFile.Add(Source, nX, nY);
    t_Insert: CurrImageFile.Insert(nIndex, Source, nX, nY);
    t_Replace: CurrImageFile.Replace(nIndex, Source, nX, nY);
  end;}
end;

procedure TfrmInPutManyDlg.BitBtnOKClick(Sender: TObject);
var
  I: Integer;
  Pt: TPoint;
  sPath: string;
  nX, nY, nIndex: Integer;
  sXY: string;
  sX: string;
  sY: string;
  nBIndex: Integer;
  nEIndex: Integer;
  nCount: Integer;
  boAddOK: Boolean;

  Source: TDIB;
  AddBitmapType: TAddBitmapType;

  P: Pointer;
  Size: Int64;
  InsertIndex: Integer;
  InsertSize: Int64;
  InsertCount: Integer;

  Position: Int64;
  StartIndex, StopIndex: Integer;
begin
  if not Assigned(CurrImageFile) then Exit;
  if g_boWalking then Exit;
  g_boWalking := True;
  BitBtnOK.Enabled := False;
  BitBtnClose.Enabled := False;
  try
    nBIndex := EditX.IntValue;
    nEIndex := EditY.IntValue;

    sXY := Trim(EditXY.Text);
    sPath := EditFileDir.Text;
    if sPath <> '' then sPath := sPath + '\';
    if (sPath[Length(sPath)] <> '\') then sPath := sPath + '\';

    StringList.Clear;
    DoSearchFile(sPath, '.BMP', TStringList(StringList));
    StringList.StringSort(False);

    sXY := GetValidStr3(sXY, sX, [',']);
    sXY := GetValidStr3(sXY, sY, [',']);
    nX := Str_ToInt(sX, 0);
    nY := Str_ToInt(sY, 0);
    AddBitmapType := TAddBitmapType(RadioGroup3.ItemIndex);

    if nBIndex > CurrImageFile.ImageCount - 1 then
      nBIndex := CurrImageFile.ImageCount - 1;

    if nBIndex > nEIndex then
      nBIndex := nEIndex;

    nCount := StringList.Count;
    if AddBitmapType = t_Replace then begin
      nEIndex := _MIN(nBIndex + (StringList.Count - 1), CurrImageFile.ImageCount - 1);

      nCount := _MIN(nEIndex - nBIndex + 1, StringList.Count);
      nCount := _MIN(nCount, CurrImageFile.ImageCount);

      if nBIndex > nEIndex then begin
        nBIndex := nEIndex;
        nCount := 1;
      end;
    end;

    ProgressBar.Position := 0;
    ProgressBar.Max := nCount;

    Position := 0;
    Size := 0;
    InsertSize := 0;
    InsertCount := 0;
    InsertIndex := nBIndex;
    StartIndex := nBIndex;
    StopIndex := nEIndex;

    if StringList.Count > 0 then begin
      if (AddBitmapType = t_Add) or
        ((AddBitmapType = t_Insert) and CurrImageFile.StartInsert(InsertIndex, P, Size)) or
        ((AddBitmapType = t_Replace) and CurrImageFile.StartReplace(StartIndex, StopIndex, Position, P, Size)) then begin
        for I := 0 to nCount - 1 do begin
          if I mod 10 = 0 then
            Application.ProcessMessages;

          ProgressBar.Position := ProgressBar.Position + 1;

          LoadBitmap(TLoadBitmapType(RadioGroup1.ItemIndex), StringList.Strings[I], Source, nX, nY);

          case AddBitmapType of
            t_Add: CurrImageFile.Add(Source, nX, nY);
            t_Insert: begin
                InsertSize := InsertSize + Source.Width * Source.Height * (Source.BitCount div 8);
                CurrImageFile.Insert(nBIndex, Source, nX, nY);
                Inc(nBIndex);
                Inc(InsertCount);
              end;
            t_Replace: begin
                CurrImageFile.Replace(nBIndex, Source, nX, nY);
                Inc(nBIndex);
                Inc(InsertCount);
              end;
          end;
          Source.Free;
        end;
      end;

      if (AddBitmapType = t_Insert) then
        CurrImageFile.StopInsert(InsertIndex, InsertCount, InsertSize, P, Size);
      if (AddBitmapType = t_Replace) then
        CurrImageFile.StopReplace(StartIndex, StopIndex, Position, P, Size);
    end;
  finally
    BitBtnOK.Enabled := True;
    BitBtnClose.Enabled := True;
    g_boWalking := False;
  end;
  Application.MessageBox('图片导入成功 ！！！', '提示信息', MB_ICONQUESTION);
  Close;
end;

procedure TfrmInPutManyDlg.BitBtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmInPutManyDlg.RadioGroup1Click(Sender: TObject);
begin
  case RadioGroup1.ItemIndex of
    0: begin
        EditFileDir.Enabled := True;
        RadioGroup3.Enabled := True;
        GroupBox4.Enabled := True;
        RzLabel.Caption := '图片所在文件夹:';
      end;
    1: begin
        EditFileDir.Enabled := True;
        RadioGroup3.Enabled := True;
        GroupBox4.Enabled := False;
        RzLabel.Caption := '图片所在文件夹:';
      end;
    2: begin
        EditFileDir.Enabled := True;
        GroupBox4.Enabled := True;
        RadioGroup3.ItemIndex := 2;
        RadioGroup3.Enabled := False;
        RzLabel.Caption := '坐标所在文件夹:';
      end;
    3: begin
        EditFileDir.Enabled := False;
        //RadioGroup3.ItemIndex := 0;
        RadioGroup3.Enabled := True;
        GroupBox4.Enabled := False;
        RzLabel.Caption := '图片所在文件夹:';
      end;
  end;
end;

procedure TfrmInPutManyDlg.RadioGroup3Click(Sender: TObject);
begin
  case RadioGroup3.ItemIndex of
    0: begin
        GroupBox2.Enabled := False;
       {EditX.Enabled := True;
       EditY.Enabled := True; }
      end;
    1: begin
        GroupBox2.Enabled := True;
        EditX.Enabled := True;
        EditY.Enabled := False;
      end;
    2: begin
        GroupBox2.Enabled := True;
        EditX.Enabled := True;
        EditY.Enabled := True;
      end;
  end;
end;

procedure TfrmInPutManyDlg.EditFileDirButtonClick(Sender: TObject);
var
  Directory: string;
begin
  if SelectDirectory('浏览文件夹', '', Directory, frmInPutManyDlg.Handle) then begin
    EditFileDir.Text := Directory;
  end;
end;

procedure TfrmInPutManyDlg.FormCreate(Sender: TObject);
begin
  RadioGroup1.ItemIndex := 0;
  RadioGroup3.ItemIndex := 0;
  StringList := TSortStringList.Create;
end;

procedure TfrmInPutManyDlg.FormDestroy(Sender: TObject);
begin
  StringList.Free;
end;

procedure TfrmInPutManyDlg.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := not g_boWalking;
end;

end.

