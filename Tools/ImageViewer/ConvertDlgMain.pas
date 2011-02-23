unit ConvertDlgMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, RzBtnEdt, RzLabel, RzButton, ExtCtrls,
  RzPanel, RzRadGrp, HUtil32, Buttons, ComCtrls, DIB, GameImages;

type
  TfrmConvertDlg = class(TForm)
    EditFileDir: TRzButtonEdit;
    EditSaveDir: TRzButtonEdit;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    RadioGroup: TRadioGroup;
    RzLabel: TLabel;
    RzLabel1: TLabel;
    BitBtnOK: TBitBtn;
    BitBtnClose: TBitBtn;
    ProgressBar: TProgressBar;
    procedure BitBtnCloseClick(Sender: TObject);
    procedure EditFileDirButtonClick(Sender: TObject);
    procedure EditSaveDirButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtnOKClick(Sender: TObject);
    procedure RadioGroupClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open;
  end;

var
  frmConvertDlg: TfrmConvertDlg;
  CheckBoxCompression: TCheckBox;
implementation
uses MirShare;
{$R *.dfm}

procedure TfrmConvertDlg.Open;
begin
  Caption := '数据转换';
  ProgressBar.Position := 0;
  ShowModal;
end;

procedure TfrmConvertDlg.BitBtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConvertDlg.EditFileDirButtonClick(Sender: TObject);
begin
  with OpenDialog do begin
    case RadioGroup.ItemIndex of
      0, 2: Filter := 'Wil图片资源文件 文件 (*.Wil)|*.Wil';
      1, 4: Filter := 'Wis图片资源文件 文件 (*.Wis)|*.Wis';
      3, 5: Filter := 'Data图片资源文件 文件 (*.Data)|*.Data';
    end;
    if Execute and (FileName <> '') then begin
      EditFileDir.Text := FileName;
      case RadioGroup.ItemIndex of
        0, 5: EditSaveDir.Text := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.Wis';
        1, 3: EditSaveDir.Text := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.Wil';
        2, 4: EditSaveDir.Text := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.Data';
      end;
    end;
  end;
end;

procedure TfrmConvertDlg.EditSaveDirButtonClick(Sender: TObject);
begin
  with SaveDialog do begin
    case RadioGroup.ItemIndex of
      1, 3: Filter := 'Wil图片资源文件 文件 (*.Wil)|*.Wil';
      0, 5: Filter := 'Wis图片资源文件 文件 (*.Wis)|*.Wis';
      2, 4: Filter := 'Data图片资源文件 文件 (*.Data)|*.Data';
    end;
    FileName := ExtractFilePath(EditFileDir.Text) + ExtractFileNameOnly(EditFileDir.Text) + ExtractFileExt(EditFileDir.Text);
    if Execute and (FileName <> '') then begin
      FileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + ExtractFileExt(FileName);
      EditSaveDir.Text := FileName;
    end;
  end;
end;

procedure TfrmConvertDlg.FormCreate(Sender: TObject);
begin
  ModalResult := 0;
end;

procedure TfrmConvertDlg.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := not g_boWalking;
end;

procedure TfrmConvertDlg.BitBtnOKClick(Sender: TObject);
  function GetDIB(Source: TDIB; BitCount: Integer): TDIB;
  var
    DIB: TDIB;
  begin
    case BitCount of
      8: begin
          if Source.BitCount <> BitCount then begin
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
          Source.BitCount := BitCount;
        end;
      24: begin
          Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
          Source.BitCount := BitCount;
        end;
      32: begin
          Source.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
          Source.BitCount := BitCount;
        end;
    end;
    Result := Source;
  end;
var
  I, BitCount, X, Y, nX, nY: Integer;
  sFileName, sDestFile: string;
  NewGameImages: TMirImages;
  GameImages: TMirImages;
  ImageType: TImageType;
  Source, DIB, NewDIB: TDIB;
  SrcP: PByte;
  DesP: PByte;
  RGB: TRGBQuad;
begin
  if g_boWalking or (RadioGroup.ItemIndex in [0, 5]) then Exit;
  BitBtnOK.Enabled := False;
  BitBtnClose.Enabled := False;
  RadioGroup.Enabled := False;
  EditFileDir.Enabled := False;
  EditSaveDir.Enabled := False;
  g_boWalking := True;
  try
    sFileName := Trim(EditFileDir.Text);
    sDestFile := Trim(EditSaveDir.Text);
    if FileExists(sFileName) then begin
      ProgressBar.Max := 0;
      ProgressBar.Position := 0;
      case RadioGroup.ItemIndex of
        1, 4: GameImages := TWis.Create(sFileName);
        2: GameImages := TWil.Create(sFileName);
        3: GameImages := TData.Create(sFileName);
      end;

      GameImages.Initialize;

      ProgressBar.Max := GameImages.ImageCount;

      case RadioGroup.ItemIndex of
        1: begin
            ImageType := t_Wil;
            BitCount := 8;
          end;
        3: begin
            ImageType := t_Wil;
            BitCount := 16;
          end;
        2, 4: begin
            ImageType := t_Fir;
            BitCount := 16;
          end;
      end;

      NewGameImages := TMirImages.Create(sDestFile, ImageType);
      if NewGameImages.CreateFile(BitCount) then begin
        NewGameImages.Free;

        case RadioGroup.ItemIndex of
          1, 3: NewGameImages := TWil.Create(sDestFile);
          2, 4: NewGameImages := TData.Create(sDestFile);
        end;

        NewGameImages.Initialize;

        for I := 0 to GameImages.ImageCount - 1 do begin
          Application.ProcessMessages;
          ProgressBar.Position := ProgressBar.Position + 1;
          Source := GameImages.Get(I, X, Y);
          Caption := Format('数据转换(%d/%d)', [I + 1, GameImages.ImageCount]);
          if Source <> nil then begin
            DIB := GetDIB(Source, GameImages.BitCount);
            case RadioGroup.ItemIndex of
              1: begin
                  NewGameImages.Add(DIB, X, Y);
                end;
              3: begin
                  NewGameImages.Add(DIB, X, Y);
                end;
              2, 4: begin
                  {if GameImages.BitCount = 8 then begin
                    DIB := TDIB.Create;
                    DIB.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
                    DIB.SetSize(Source.Width, Source.Height, BitCount);
                    for nY := 0 to Source.Height - 1 do begin
                      SrcP := Source.ScanLine[nY];
                      DesP := DIB.ScanLine[nY];
                      //SrcP := Pointer(Integer(Source.PBits) + nY * Source.WidthBytes);
                      //DesP := Pointer(Integer(DIB.PBits) + nY * DIB.WidthBytes);
                      for nX := 0 to Source.Width - 1 do begin
                        RGB := MainPalette[SrcP^];
                        if Integer(RGB) = 0 then begin
                          PWord(DesP)^ := 0;
                        end else begin
                          //PWord(DesP)^ := Word((_Max(RGB.rgbRed and $F8, 8) shl 8) or (_Max(RGB.rgbGreen and $FC, 8) shl 3) or (_Max(RGB.rgbBlue and $F8, 8) shr 3)); //565格式
                          PWord(DesP)^ := Word((RGB.rgbRed and $F8 shl 8) or (RGB.rgbGreen and $FC shl 3) or (RGB.rgbBlue and $F8 shr 3)); //565格式
                        end;
                        Inc(SrcP);
                        Inc(PWord(DesP));
                      end;
                    end;
                    NewDIB := TDIB.Create;
                    NewDIB.Assign(DIB);
                    DIB.Free;
                  end else begin}
                  NewDIB := TDIB.Create;
                  NewDIB.Assign(DIB);
                  NewDIB.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
                  NewDIB.BitCount := BitCount;
                  //end;
                  //Source.SaveToFile(IntToStr(I)+'.BMP');
                  NewGameImages.Add(NewDIB, X, Y);
                  NewDIB.Free;
                end;
              {4: begin
                  Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
                  Source.BitCount := BitCount;
                  NewGameImages.Add(Source, X, Y);
                end;}
            end;
          end;
        end;
        NewGameImages.Free;
      end else NewGameImages.Free;
      GameImages.Free;
    end;
    Application.MessageBox('转换成功 ！！！', '提示信息', MB_ICONQUESTION);
  finally
    g_boWalking := False;
    BitBtnOK.Enabled := True;
    BitBtnClose.Enabled := True;
    RadioGroup.Enabled := True;
    EditFileDir.Enabled := True;
    EditSaveDir.Enabled := True;
  end;
end;

procedure TfrmConvertDlg.RadioGroupClick(Sender: TObject);
begin
  case RadioGroup.ItemIndex of
    0, 5: EditSaveDir.Text := ExtractFilePath(EditSaveDir.Text) + ExtractFileNameOnly(EditSaveDir.Text) + '.Wis';
    1, 3: EditSaveDir.Text := ExtractFilePath(EditSaveDir.Text) + ExtractFileNameOnly(EditSaveDir.Text) + '.Wil';
    2, 4: EditSaveDir.Text := ExtractFilePath(EditSaveDir.Text) + ExtractFileNameOnly(EditSaveDir.Text) + '.Data';
  end;
end;

end.

