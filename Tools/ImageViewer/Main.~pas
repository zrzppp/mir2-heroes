unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzGroupBar, ExtDlgs, ComCtrls, ExtCtrls, RzSplit, StdCtrls, Mask,
  Grids, RzButton, ImgList, RzStatus, HUtil32, MirShare, SGL, DIB,
  Menus, RzPanel, GameImages;

type
  TfrmMain = class(TForm)
    OpenDialog: TOpenDialog;
    SaveDialog1: TSaveDialog;
    OPD1: TOpenPictureDialog;
    RzSplitter1: TRzSplitter;
    DrawGrid: TDrawGrid;
    StatusBar: TRzStatusBar;
    LargeImages: TImageList;
    SmallImages: TImageList;
    RzToolbar1: TRzToolbar;
    ToolButtonOpenFile: TRzToolButton;
    ToolButtonCreateFile: TRzToolButton;
    ToolButtonAdd: TRzToolButton;
    ToolButtonSaveBMP: TRzToolButton;
    ToolButtonAddMany: TRzToolButton;
    ToolButtonSaveManyBMP: TRzToolButton;
    ToolButtonXY: TRzToolButton;
    ToolButtonDel: TRzToolButton;
    ToolButtonConvertData: TRzToolButton;
    StatusPane1: TRzStatusPane;
    StatusPane2: TRzStatusPane;
    StatusPane3: TRzStatusPane;
    SaveDialog2: TSaveDialog;
    ToolButtonClose: TRzToolButton;
    PopupMenu: TPopupMenu;
    PopupMenu_Transparent: TMenuItem;
    RzPanel: TPanel;
    ScrollBox: TScrollBox;
    Image: TImage;
    StatusPane4: TRzStatusPane;
    procedure ButtonOpenFileButtonClick(Sender: TObject);
    procedure DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure DrawGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ToolButtonOpenFileClick(Sender: TObject);
    procedure ToolButtonAddClick(Sender: TObject);
    procedure ToolButtonDelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ToolButtonAddManyClick(Sender: TObject);
    procedure ToolButtonSaveBMPClick(Sender: TObject);
    procedure ToolButtonCreateFileClick(Sender: TObject);
    procedure ToolButtonSaveManyBMPClick(Sender: TObject);
    procedure ToolButtonXYClick(Sender: TObject);
    procedure ToolButtonConvertDataClick(Sender: TObject);
    procedure ToolButtonCloseClick(Sender: TObject);
    procedure RzSplitter1Resize(Sender: TObject);
    procedure PopupMenu_TransparentClick(Sender: TObject);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OnProgramException(Sender: TObject; E: Exception);
  end;

var
  frmMain: TfrmMain;

  g_nACol, g_nARow, g_nIndex: Integer;
implementation
uses InPutDlgMain, InPutManyDlgMain, DelDlgMain, OutPutDlgMain,
  XYDlgMain, ConvertDlgMain, CompressMain, CreateData;

{$R *.dfm}

procedure TfrmMain.OnProgramException(Sender: TObject; E: Exception);
begin
  g_ErrorList.Add(E.Message);
  //Application.MessageBox(PChar(E.Message), '错误', MB_ICONERROR);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Randomize;
  Application.OnException := OnProgramException;
  g_ErrorList := TStringList.Create;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  if Assigned(CurrImageFile) then
    CurrImageFile.Free;
  if g_ErrorList.Count > 0 then
    g_ErrorList.SaveToFile('ImageViewerLog.txt');
  g_ErrorList.Free;
end;

procedure TfrmMain.ButtonOpenFileButtonClick(Sender: TObject);
var
  ShortName: string;
begin
  {if OpenDialog.Execute and (OpenDialog.FileName <> '') then begin
    FreeAndNil(CurrImageFile);
    ShortName := OpenDialog.FileName;
    CurrImageFile := TDataFile.Create(ShortName);

    DrawGrid.RowCount := CurrImageFile.Count div DrawGrid.ColCount + 1;

   // Showmessage(IntToStr(CurrImageFile.Count));

    DrawGrid.Invalidate;
    Image.Invalidate;
    StatusPane1.Caption := OpenDialog.FileName;
    StatusPane2.Caption := '0/' + IntToStr(CurrImageFile.Count);
    //StatusBar1.Panels[0].Text := OpenDialog1.FileName + ', 图片数量:' + IntTosTr(CurrIdsFile.ImageCount);
    //bChanged := false;
  end; }
end;

procedure TfrmMain.DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Grid: TDrawGrid;
  Index: Integer;
  InfoPtr: PTDataImageInfo;
  Str: string;
  nX, nY, nWidth, nHeight, nTextHeight: Integer;

  nImageX, nImageY: Integer;
  nImageWidth, nImageHeight: Integer;
begin
  if not Assigned(CurrImageFile) or g_boWalking then Exit;

  Grid := DrawGrid; //Sender as TDrawGrid;
  Index := ARow * Grid.ColCount + ACol;
  try
    if (Index >= 0) and (Index < CurrImageFile.ImageCount) then begin
      if Grid.Canvas.Handle = 0 then Exit;
    //Grid.Canvas.Brush.Style := bsclear;
      nWidth := Rect.Right - Rect.Left;
      nHeight := Rect.Bottom - Rect.Top;

      CurrImageFile.StretchBlt(Index, Grid.Canvas.Handle, Rect.Left, Rect.Top,
        nWidth, nHeight, SRCCOPY);

      nTextHeight := Grid.Canvas.TextHeight('A');
      Grid.Canvas.Brush.Style := bsclear;
      Grid.Canvas.Font.Color := clwhite;
    //str := Format('%.5d, [%dx%d]', [Index, InfoPtr.nWidth, InfoPtr.nHeight]);
      Str := Format('%.5d', [Index]);
      Grid.Canvas.TextOut(Rect.Left - 1, Rect.Bottom - nTextHeight, Str);
      Grid.Canvas.TextOut(Rect.Left + 1, Rect.Bottom - nTextHeight + 1, Str);
      Grid.Canvas.TextOut(Rect.Left, Rect.Bottom - nTextHeight - 1, Str);
      Grid.Canvas.TextOut(Rect.Left, Rect.Bottom - nTextHeight + 1, Str);
      Grid.Canvas.Font.Color := clblack;
      Grid.Canvas.TextOut(Rect.Left, Rect.Bottom - nTextHeight, Str);
    end;
  except
    //Showmessage(IntToStr(Index));
  end;
end;

procedure TfrmMain.DrawGridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  Index: Integer;
  r1, r2: TRect;
  bmp: tbitmap;
  ImgInfo: PTDataImageInfo;
  NewImgInfo: pTNewWilImageData;
  Str: string;
  nWidth, nHeight: Integer;
  nImageX, nImageY: Integer;
  nImageWidth, nImageHeight: Integer;
  Bitmap: TDIB;
begin
  if not Assigned(CurrImageFile) then Exit;

  Index := ARow * DrawGrid.ColCount + ACol;
  g_nACol := ACol;
  g_nARow := ARow;
  g_nIndex := Index;
  if (Index >= 0) and (Index < CurrImageFile.ImageCount) then begin
    Bitmap := CurrImageFile.Get(Index, nImageX, nImageY);
    if Bitmap = nil then Exit;
    nImageWidth := Bitmap.Width;
    nImageHeight := Bitmap.Height;

    CanSelect := True;
    Image.Picture.Bitmap.Handle := 0;
    ScrollBox.HorzScrollBar.Position := 0;
    ScrollBox.VertScrollBar.Position := 0;
    Image.Width := nImageWidth;
    Image.Height := nImageHeight;

    Image.Picture.Bitmap.Width := nImageWidth;
    Image.Picture.Bitmap.Height := nImageHeight;

    if nImageWidth <= ScrollBox.Width then begin
      Image.Left := (ScrollBox.Width - nImageWidth) div 2;
    end else begin
      Image.Left := 0;
    end;
    if nImageHeight <= ScrollBox.Height then begin
      Image.Top := (ScrollBox.Height - nImageHeight) div 2;
    end else begin
      Image.Top := 0;
    end;
    Image.Transparent := PopupMenu_Transparent.Checked;
    Image.Picture.Bitmap.Width := Bitmap.Width;
    Image.Picture.Bitmap.Height := Bitmap.Height;
    Image.Picture.Bitmap.Canvas.Draw(0, 0, Bitmap);

    StatusPane2.Caption := IntToStr(Index + 1) + '/' + IntToStr(CurrImageFile.ImageCount);
    StatusPane3.Caption := Format('序号:%.5d 宽:%d 高:%d 偏移坐标:%d,%d', [Index, nImageWidth, nImageHeight, nImageX, nImageY]);
  end;
end;

function GetImageFileVersion(const FileName: string): TImageType;
var
  Header: TWMImageHeader;
  NewHeader: TNewWilHeader;
  s: Pchar;
  str: string;
  IndexFile: string;
  Stream: TFileStream;
  boG3: Boolean;
  nG3Sign: DWORD;
  mCount: DWORD;
  fBegin: DWORD;
  mfSize: DWORD;
begin
  if Comparetext(ExtractFileExt(FileName), '.Data') = 0 then begin
    Result := t_Fir;
  end else
    if Comparetext(ExtractFileExt(FileName), '.Wis') = 0 then begin
    Result := t_Wis;
  end else
    if Comparetext(ExtractFileExt(FileName), '.Wil') = 0 then begin
    Result := t_Wil;
    IndexFile := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.WIX';
    if FileExists(IndexFile) then begin
      Stream := TFileStream.Create(IndexFile, fmOpenReadWrite or fmShareDenyNone);
      Stream.Seek(20, soBeginning);
      Stream.Read(mCount, SizeOf(mCount));
      Stream.Read(nG3Sign, SizeOf(nG3Sign));

      boG3 := (nG3Sign and $FFFF0000) = $B13A0000;
      mfSize := Stream.Size; //GetFileSize(Stream.Handle, 0);
      if not boG3 then
      begin
        fBegin := 24;
        nG3Sign := $B13AD3FB;
      end
      else fBegin := 28;
      if (mCount >= 0) and ((mCount * 4 + fBegin) <= mfSize) then begin
        Result := t_GT;
      end;
      Stream.Free;
    end;
  end;
end;

procedure TfrmMain.ToolButtonOpenFileClick(Sender: TObject);
var
  ShortName: string;
  ImageType: TImageType;
begin
  if g_boWalking then Exit;
  g_boWalking := True;
  try
    if OpenDialog.Execute and (OpenDialog.FileName <> '') then begin
      FreeAndNil(CurrImageFile);
      ShortName := OpenDialog.FileName;
      ImageType := GetImageFileVersion(ShortName);
      case ImageType of
        t_Wil: CurrImageFile := TWil.Create(ShortName);
        t_Wis: CurrImageFile := TWis.Create(ShortName);
        t_Fir: CurrImageFile := TData.Create(ShortName);
        t_GT: ;
      end;

      CurrImageFile.Initialize;

      case ImageType of
        t_Wil: StatusPane4.Caption := 'Wil ' + IntToStr(CurrImageFile.BitCount);
        t_Wis: StatusPane4.Caption := 'Wis ' + IntToStr(CurrImageFile.BitCount);
        t_Fir: StatusPane4.Caption := 'Data ' + IntToStr(CurrImageFile.BitCount);
        t_GT: ;
      end;
      if CurrImageFile.BitCount >= 16 then
        StatusPane4.Caption := StatusPane4.Caption + '位真彩'
      else
        StatusPane4.Caption := StatusPane4.Caption + '位色';

      if ImageType = t_Fir then
        StatusPane4.Caption := StatusPane4.Caption +' Comp:'+ IntToStr(TData(CurrImageFile).Compression);

      //ToolButtonCreateFile.Enabled := ImageType <> t_Wis;
      ToolButtonAdd.Enabled := ImageType <> t_Wis;
      ToolButtonAddMany.Enabled := ImageType <> t_Wis;
      ToolButtonDel.Enabled := ImageType <> t_Wis;

      DrawGrid.RowCount := CurrImageFile.ImageCount div DrawGrid.ColCount + 1;

      DrawGrid.Invalidate;
      Image.Invalidate;

      StatusPane1.Caption := OpenDialog.FileName;
      StatusPane2.Caption := '0/' + IntToStr(CurrImageFile.ImageCount);
    end;
  except

  end;
  g_boWalking := False;
end;

procedure TfrmMain.ToolButtonAddClick(Sender: TObject);
var
  X, Y, Index: Integer;
  InsertNew: Integer;
  Source, DIB: TDIB;
  P: Pointer;
  Size: Int64;
  InsertSize: Integer;
begin
  if not Assigned(CurrImageFile) then Exit;
  if g_boWalking then Exit;
  g_boWalking := True;
  try
    if OPD1.Execute and (OPD1.FileName <> '') then begin
      Source := TDIB.Create;
      Source.LoadFromFile(OPD1.FileName);
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
      InsertSize := Source.Width * Source.Height * (Source.BitCount div 8);

      if frmInPutDlg.ShowModal = 10 then begin
        if frmInPutDlg.RadioGroup.ItemIndex = 0 then begin
          Index := DrawGrid.Row * DrawGrid.ColCount + DrawGrid.Col;
          if Index < CurrImageFile.ImageCount then begin
            if CurrImageFile.Replace(Index, Source) then begin //替换图片
              Application.MessageBox('图片导入成功 ！！！', '提示信息', MB_ICONQUESTION);
            end else Application.MessageBox('图片导入失败 ！！！', '提示信息', MB_ICONQUESTION);
          end;
        end else
          if frmInPutDlg.RadioGroup.ItemIndex = 1 then begin //插入图片
          Index := DrawGrid.Row * DrawGrid.ColCount + DrawGrid.Col;
          if Index < CurrImageFile.ImageCount then begin
            if CurrImageFile.StartInsert(Index, P, Size) and
              CurrImageFile.Insert(Index, Source, frmInPutDlg.EditX.IntValue, frmInPutDlg.EditY.IntValue)
              and CurrImageFile.StopInsert(Index, 1, InsertSize, P, Size) then begin
              Application.MessageBox('图片导入成功 ！！！', '提示信息', MB_ICONQUESTION);
            end else Application.MessageBox('图片导入失败 ！！！', '提示信息', MB_ICONQUESTION);
          end;
        end else begin //末尾添加图片
          if CurrImageFile.Add(Source, frmInPutDlg.EditX.IntValue, frmInPutDlg.EditY.IntValue) then begin
            DrawGrid.Invalidate;
            Image.Invalidate;
            Application.MessageBox('图片导入成功 ！！！', '提示信息', MB_ICONQUESTION);
          end else Application.MessageBox('图片导入失败 ！！！', '提示信息', MB_ICONQUESTION);
        end;
      end;
      Source.Free;
    end;
  finally
    g_boWalking := False;
  end;
  DrawGrid.RowCount := CurrImageFile.ImageCount div DrawGrid.ColCount + 1;
  DrawGrid.Invalidate;
  Image.Invalidate;
end;

procedure TfrmMain.ToolButtonDelClick(Sender: TObject);
begin
  frmDelDlg.Open(g_nIndex);
  DrawGrid.RowCount := CurrImageFile.ImageCount div DrawGrid.ColCount + 1;
  DrawGrid.Invalidate;
  Image.Invalidate;
end;

procedure TfrmMain.ToolButtonAddManyClick(Sender: TObject);
begin
  frmInPutManyDlg.Open(g_nIndex);
  DrawGrid.RowCount := CurrImageFile.ImageCount div DrawGrid.ColCount + 1;
  DrawGrid.Invalidate;
  Image.Invalidate;
end;

procedure TfrmMain.ToolButtonSaveBMPClick(Sender: TObject);
var
  sFilName: string;
  Index: Integer;
  Bitmap: TDIB;
begin
  if not Assigned(CurrImageFile) then Exit;
  if g_boWalking then Exit;
  g_boWalking := True;
  try
    Index := DrawGrid.Row * DrawGrid.ColCount + DrawGrid.Col;
    if Index < CurrImageFile.ImageCount then begin
      with SaveDialog1 do begin
        FileName := ExtractFilePath(FileName) + Format('%.5d', [Index]) + '.BMP';
        if Execute and (FileName <> '') then begin
          Bitmap := CurrImageFile.Bitmaps[Index];
          if Bitmap <> nil then begin
            try
              Bitmap.SaveToFile(FileName);
              Application.MessageBox('图片导出成功 ！！！', '提示信息', MB_ICONQUESTION);
            except
              Application.MessageBox('图片导出失败 ！！！', '提示信息', MB_ICONQUESTION);
            end;
          end;
        end;
      end;
    end;
  finally
    g_boWalking := False;
  end;
end;

procedure TfrmMain.ToolButtonCreateFileClick(Sender: TObject);
var
  ImageType: TImageType;
  MirImages: TMirImages;
  BitCount: Byte;
begin
  if g_boWalking then Exit;
  g_boWalking := True;
  try
    if FrmCreateData.ShowModal = 10 then begin
      with SaveDialog2 do begin
        BitCount := 8;
        ImageType := TImageType(FrmCreateData.RadioGroup.ItemIndex);

        case ImageType of
          t_Wil: begin
              Filter := '传奇图片资源文件|*.Wil|*.Wil';
              FileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.Wil';
              case FrmCreateData.RadioGroupBitCount.ItemIndex of
                0: BitCount := 8;
                1: BitCount := 16;
                2: BitCount := 24;
                3: BitCount := 32;
              end;
            end;
          t_Wis: ;
          t_Fir: begin
              BitCount := 16;
              Filter := '传奇图片资源文件|*.Data|*.Data';
              FileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.Data';
            end;
          t_GT: ;
        end;
        if Execute and (FileName <> '') then begin
          MirImages := TMirImages.Create(FileName, ImageType);
          if MirImages.CreateFile(BitCount) then
            Application.MessageBox('创建成功 ！！！', '提示信息', MB_ICONQUESTION)
          else
            Application.MessageBox('创建失败 ！！！', '提示信息', MB_ICONQUESTION);
          MirImages.Free;
        end;
      end;
    end;
  finally
    g_boWalking := False;
  end;
end;

procedure TfrmMain.ToolButtonSaveManyBMPClick(Sender: TObject);
var
  nStart, nStop: Integer;
begin
  nStart := DrawGrid.Row * DrawGrid.ColCount + DrawGrid.Col;
  nStop := CurrImageFile.ImageCount - 1;
  frmOutPutDlg.Open(nStart, nStop);
end;

procedure TfrmMain.ToolButtonXYClick(Sender: TObject);
var
  Index: Integer;
  Pt: TPoint;
begin
  if not Assigned(CurrImageFile) then Exit;
  if g_boWalking then Exit;
  g_boWalking := True;
  try
    Index := DrawGrid.Row * DrawGrid.ColCount + DrawGrid.Col;
    if Index < CurrImageFile.ImageCount then begin
      Pt := CurrImageFile.ImagePoint[Index];
      frmXYDlg.EditX.IntValue := Pt.X;
      frmXYDlg.EditY.IntValue := Pt.Y;
      if frmXYDlg.ShowModal = 10 then begin
        Pt.X := frmXYDlg.EditX.IntValue;
        Pt.Y := frmXYDlg.EditY.IntValue;
        CurrImageFile.ImagePoint[Index] := Pt;
        Application.MessageBox('图片坐标修改成功 ！！！', '提示信息', MB_ICONQUESTION);
      end;
    end;
  finally
    g_boWalking := False;
  end;
end;

procedure TfrmMain.ToolButtonConvertDataClick(Sender: TObject);
{var
  ShortName: string;
  DataFile: TDataFile;
  WMImages: TGameData;
  SglFile: TSglFile;
  SBits, DBits: Pointer;
  lsDIB: TDIB;
  tmpDIB: TDIB;
  I, II, J: Integer;
  pSrc: Pointer;

  NewImageInfo: TNewWilImageInfo;
  WMImageInfo: TWMImageInfo;
  DataImageArray: array of TDataImage;
  DataImage: pTDataImage;
  DataImageList: TList;
  IndexArray: PInteger;
  FileStream: TFileStream;
  DataHeader: TDataHeader;
  Image: PSglImage;
  Frame: PSglFrame;
  nDataLen: Integer;
  nCount: Integer;
  nIndexCount: Integer;
  BM: tbitmap;
  boConvert: Boolean;
  nCompression: Integer;}
begin
  frmConvertDlg.Open;
 // try
 (* if g_boWalking then Exit;
  g_boWalking := True;
  boConvert := False;
  nCompression := 0;
  if frmConvertDlg.ShowModal = 10 then begin
{$IF GMMODE = 1}
    nCompression := frmConvertDlg.ComboBox.ItemIndex;
{$IFEND}
    if frmConvertDlg.RadioGroup.ItemIndex = 1 then begin
      ShortName := Trim(frmConvertDlg.EditFileDir.Text);
      case GetWilFileVersion(ShortName) of
        -1: begin
            Application.MessageBox('该WIL文件已损坏 ！！！', '提示信息', MB_ICONQUESTION);
            g_boWalking := False;
            Exit;
          end;
        0: WMImages := TMirWILFile_8.Create(ShortName);
        1: WMImages := TMirWILFile_16.Create(ShortName);
        2: WMImages := TMirWILFile_24.Create(ShortName);
        3: WMImages := TMirWILFile_32.Create(ShortName);
        4: WMImages := TMir3WILFile.Create(ShortName);
      end;
      //WMImages := TMirWILFile_8.Create(frmConvertDlg.EditFileDir.Text);
      WMImages.Initialize;
      g_nPercent := 0;
      g_nCount := WMImages.ImageCount;
      ProgressStatus.Percent := 0;
      //Showmessage(IntToStr(g_nCount)+' '+IntToStr(WMImages.m_Header.ColorCount));
      DataImageList := TList.Create;
      if g_nCount < 0 then g_nCount := 1;
      nDataLen := SizeOf(TDataHeader) + WMImages.ImageCount * SizeOf(Integer);
      for I := 0 to WMImages.ImageCount - 1 do begin
        Application.ProcessMessages;
        Inc(g_nPercent);
        ProgressStatus.Percent := Trunc(g_nPercent / (g_nCount / 100));
        try
          lsDIB := TDIB.Create;
          lsDIB.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
          lsDIB.BitCount := 16;
          if WMImages is TMir3WILFile then begin
            if not WMImages.LoadImage(I, lsDIB, @NewImageInfo) then begin
              lsDIB.SetSize(4, 1, 16);
            end;
            WMImageInfo.px := NewImageInfo.Px;
            WMImageInfo.py := NewImageInfo.Py;
          end else begin
            if not WMImages.LoadImage(I, lsDIB, @WMImageInfo) then begin
              lsDIB.SetSize(4, 1, 16);
            end;
          end;
          New(DataImage);
          DataImage.nWidth := lsDIB.Width;
          DataImage.nHeight := lsDIB.Height;
          DataImage.px := WMImageInfo.px;
          DataImage.py := WMImageInfo.py;

          GetMem(DataImage.PBits, lsDIB.Width * 2 * lsDIB.Height);
          DBits := DataImage.PBits;
          DataImage.nSize := Comp(nCompression, lsDIB.PBits, WidthBytes(lsDIB.Width * 2) * lsDIB.Height, DBits);
          DataImageList.Add(DataImage);
        finally
          lsDIB.Free;
        end;
      end;
      ProgressStatus.Percent := 100;

      DataHeader.Title := g_sTitle;
      DataHeader.Size := SizeOf(TDataHeader);
      DataHeader.ImageCount := DataImageList.Count;
      DataHeader.Planes := 0;
      DataHeader.BitCount := 16;
      DataHeader.Compression := nCompression;

      nDataLen := SizeOf(TDataHeader) + DataImageList.Count * SizeOf(Integer);
      GetMem(IndexArray, DataImageList.Count * SizeOf(Integer));
      for I := 0 to DataImageList.Count - 1 do begin
        PInteger(Integer(IndexArray) + SizeOf(Integer) * I)^ := nDataLen;
        Inc(nDataLen, SizeOf(TDataImageInfo) + pTDataImage(DataImageList.Items[I]).nSize);
      end;
      FileStream := TFileStream.Create(frmConvertDlg.EditSaveDir.Text, fmOpenReadWrite or fmShareDenyNone or fmCreate);
          //FileStream.Size := nDataLen;
      FileStream.Write(DataHeader, SizeOf(TDataHeader));
      FileStream.Write(IndexArray^, DataHeader.ImageCount * SizeOf(Integer));
      g_nPercent := 0;
      g_nCount := DataHeader.ImageCount;
      ProgressStatus.Percent := 0;
      if g_nCount < 0 then g_nCount := 1;
      for I := 0 to DataImageList.Count - 1 do begin
        Application.ProcessMessages;
        Inc(g_nPercent);
        ProgressStatus.Percent := Trunc(g_nPercent / (g_nCount / 100));
        FileStream.Write(pTDataImage(DataImageList.Items[I])^, SizeOf(TDataImageInfo));
        FileStream.Write(pTDataImage(DataImageList.Items[I]).PBits^, pTDataImage(DataImageList.Items[I]).nSize);
        FreeMem(pTDataImage(DataImageList.Items[I]).PBits);
        Dispose(pTDataImage(DataImageList.Items[I]));
      end;
      ProgressStatus.Percent := 100;
      DataImageList.Free;
      FreeMem(IndexArray);
      FileStream.Free;
      WMImages.Free;

      boConvert := True;
    end else begin //SGL文件
      SglFile := TSglFile.Create;
      if SglFile.Open(frmConvertDlg.EditFileDir.Text) then begin

        nCount := 0;
        g_nPercent := 0;
        g_nCount := SglFile.ImageCount;
        ProgressStatus.Percent := 0;
          //Pointer(DataImageArray) := AllocMem(10000 * 6 * SizeOf(TDataImage));
          //SetLength(DataImageArray, 10000 * 6);
         // GetMem(IndexArray, 10000 * 6 * SizeOf(Integer));
        if g_nCount < 0 then g_nCount := 1;
        DataImageList := TList.Create;

        g_nCount := SglFile.ImageCount;
        BM := tbitmap.Create;
        for I := 0 to SglFile.ImageCount - 1 do begin
          Application.ProcessMessages;
          Inc(g_nPercent);
          ProgressStatus.Percent := Trunc(g_nPercent / (g_nCount / 100));

          SglFile.ImageIndex := I;

          Image := SglFile.Images[I];

          if (Image <> nil) and (Image.siFrames > 0) and (SglFile.FrameCount > 0) then begin
            for J := 0 to SglFile.FrameCount - 1 do begin
              if (SglFile.Frames[J] <> nil) then begin
                with SglFile.Frames[J]^ do begin
                  if (sfWidth > 0) and (sfHeight > 0) then begin
                    //try
                    BM.Handle := 0;
                    BM.Canvas.Brush.Color := clblack; //clwhite; //clblack; //clblack;
                    BM.PixelFormat := pf16Bit;
                    BM.Width := sfWidth;
                    BM.Height := sfHeight;
                    try
                      //Sleep(10);
                      SglFile.DecodeFrame16(J, BM.ScanLine[0], -((sfWidth * 2 + 3) and $FFFFFFFC));
                    except
                          //break;
                      Continue;
                    end;
                    New(DataImage);
                    DataImage.nWidth := sfWidth;
                    DataImage.nHeight := sfHeight;
                    DataImage.px := sfX;
                    DataImage.py := sfY;

                    lsDIB := TDIB.Create;
                        //lsDIB.Canvas.Brush.Color := clblack;
                    lsDIB.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
                    lsDIB.BitCount := 16;
                    lsDIB.Width := BM.Width;
                    lsDIB.Height := BM.Height;
                    lsDIB.Canvas.Draw(0, 0, BM);
                    lsDIB.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
                    lsDIB.BitCount := 16;

                    tmpDIB := TDIB.Create;
                    tmpDIB.Assign(lsDIB);
                    DBits := lsDIB.PBits;
                    for II := tmpDIB.Height - 1 downto 0 do begin
                      pSrc := Pointer(Integer(tmpDIB.PBits) + II * tmpDIB.Width * 2);
                      Move(pSrc^, DBits^, lsDIB.Width * 2);
                      Inc(Integer(DBits), lsDIB.Width * 2);
                    end;
                    tmpDIB.Free;

                    GetMem(DataImage.PBits, WidthBytes(lsDIB.Width * 2) * lsDIB.Height);
                    DBits := DataImage.PBits;
                    DataImage.nSize := Comp(nCompression, lsDIB.PBits, WidthBytes(lsDIB.Width * 2) * lsDIB.Height, DBits);
                 // PInteger(Integer(IndexArray) + SizeOf(Integer) * nCount)^ := nDataLen;
                    DataImageList.Add(DataImage);
                  //Inc(nDataLen, DataImageArray[nCount].nSize + SizeOf(TDataImageInfo));
                    //finally
                    lsDIB.Free;
                    //end;
                  end;
                end;
              end;
            end;
          end;
        end;
        ProgressStatus.Percent := 100;

        DataHeader.Title := g_sTitle;
        DataHeader.Size := SizeOf(TDataHeader);
        DataHeader.ImageCount := DataImageList.Count;
        DataHeader.Planes := 0;
        DataHeader.BitCount := 16;
        DataHeader.Compression := nCompression;

        nDataLen := SizeOf(TDataHeader) + DataImageList.Count * SizeOf(Integer);
        GetMem(IndexArray, DataImageList.Count * SizeOf(Integer));
        for I := 0 to DataImageList.Count - 1 do begin
          PInteger(Integer(IndexArray) + SizeOf(Integer) * I)^ := nDataLen;
          Inc(nDataLen, SizeOf(TDataImageInfo) + pTDataImage(DataImageList.Items[I]).nSize);
        end;
        FileStream := TFileStream.Create(frmConvertDlg.EditSaveDir.Text, fmOpenReadWrite or fmShareDenyNone or fmCreate);
          //FileStream.Size := nDataLen;
        FileStream.Write(DataHeader, SizeOf(TDataHeader));
        FileStream.Write(IndexArray^, DataHeader.ImageCount * SizeOf(Integer));
        g_nPercent := 0;
        g_nCount := DataHeader.ImageCount;
        ProgressStatus.Percent := 0;
        if g_nCount < 0 then g_nCount := 1;
        for I := 0 to DataImageList.Count - 1 do begin
          Application.ProcessMessages;
          Inc(g_nPercent);
          ProgressStatus.Percent := Trunc(g_nPercent / (g_nCount / 100));
          FileStream.Write(pTDataImage(DataImageList.Items[I])^, SizeOf(TDataImageInfo));
          FileStream.Write(pTDataImage(DataImageList.Items[I]).PBits^, pTDataImage(DataImageList.Items[I]).nSize);
          FreeMem(pTDataImage(DataImageList.Items[I]).PBits);
          Dispose(pTDataImage(DataImageList.Items[I]));
        end;
        ProgressStatus.Percent := 100;
        DataImageList.Free;
        FreeMem(IndexArray);
        FileStream.Free;
        SglFile.Free;
        BM.Free;
        boConvert := True;
      end;
    end;
  end else begin
    g_boWalking := False;
    Exit;
  end;

  if boConvert then Application.MessageBox('转换成功 ！！！', '提示信息', MB_ICONQUESTION)
  else Application.MessageBox('转换失败 ！！！', '提示信息', MB_ICONQUESTION);
  g_boWalking := False;
  *)
 // ShowMessage('I:' + IntToStr(I) + ' J:' + IntToStr(J) + ' Width:' + IntToStr(BM.Width));
end;

procedure TfrmMain.ToolButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.RzSplitter1Resize(Sender: TObject);
var
  CanSelect: Boolean;
begin
  DrawGridSelectCell(DrawGrid, g_nACol, g_nARow, CanSelect);
end;

procedure TfrmMain.PopupMenu_TransparentClick(Sender: TObject);
begin
  PopupMenu_Transparent.Checked := not PopupMenu_Transparent.Checked;
  RzSplitter1Resize(Self);
end;

procedure TfrmMain.ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  Str: string;
  nX, nY, nWidth, nHeight, nTextHeight: Integer;
begin
{$IF GMMODE <> 1}
  Exit;
{$IFEND}
  Image.Transparent := PopupMenu_Transparent.Checked;
  //CurrImageFile.DrawBitMap(g_nIndex, Image.Picture.Bitmap, nWidth, nHeight);
  if Image.Canvas = nil then Exit;

  nTextHeight := Image.Canvas.TextHeight('A');

  Image.Canvas.Brush.Style := bsclear;
  Image.Canvas.Font.Color := clLime;
    //str := Format('%.5d, [%dx%d]', [Index, InfoPtr.nWidth, InfoPtr.nHeight]);
  Str := Format('X:%d Y:%d', [X, Y]);

  nX := X;
  nY := Y + nTextHeight;

  if Image.Canvas.TextHeight(Str) * 2 + nY > Image.Height then
    nY := Image.Height - Image.Canvas.TextHeight(Str) * 2;

  if Image.Canvas.TextHeight(Str) * 3 + nY < 0 then
    nY := Image.Canvas.TextHeight(Str) * 3;

  if Image.Canvas.TextWidth(Str) + nX > Image.Width then
    nX := Image.Width - Image.Canvas.TextWidth(Str);

  if Image.Canvas.TextWidth(Str) + nX < 0 then
    nX := Image.Canvas.TextWidth(Str);

 { Image.Canvas.TextOut(nX - 1, nY, Str);
  Image.Canvas.TextOut(nX + 1, nY + 1, Str);
  Image.Canvas.TextOut(nX, nY - 1, Str);
  Image.Canvas.TextOut(nX, nY + 1, Str);
  Image.Canvas.Font.Color := clblack; }
  Image.Canvas.TextOut(nX, nY, Str);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not g_boWalking;
end;

end.

