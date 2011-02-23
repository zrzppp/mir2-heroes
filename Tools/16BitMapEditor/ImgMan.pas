unit ImgMan;

interface

uses
  Windows, Classes, SysUtils, Mmsystem, cimllib, Grobal, IMLUtil,
  cimlLibB, ClUtil, Bmputil, DGC, HUtil32;

const
   DATADIR = '.\Data\';
   MAXMONRACE = 300;
   MAXMONMEMORY = 10 * (1024 * 1000); //1마리당 1M  10마리
   HUMANFRAME  = 224;
   MAGEFFECTFRAME = 24;

type
  TSurfaceImage = record
    px, py: Integer;
    Surface: TDGCSurface;
  end;
  PTSurfaceImage = ^TSurfaceImage;

  TBufSurfaceImage = record
    px, py: Integer;
    Surface: TDGCSurface;
    BufSize: integer;         //사용 버퍼 크기
    UseTime: integer;         //마지막 사용 시간
  end;
  PTBufSurfaceImage = ^TBufSurfaceImage;

  TBufImgInfo = record
    ImageSize: integer;
    LatestTime: integer;
    Surface: TDGCSurface;
  end;
  PTBufImgInfo = ^TBufImgInfo;

  TBufImgMonInfo = record
    ImageSize: integer;
    LatestTime: integer;
    SurfaceList: TList; //몬스터 Surface의 리스트
  end;
  PTBufImgMonInfo = ^TBufImgMonInfo;

  TIndexTable = record
  	  DiskPos: LongInt;
     ImageSize: LongInt;
     ImgHdr: TImgLibImage;
  end;
  PTIndexTable = ^TIndexTable;

  TIndexTableArr = array[0..65535] of TIndexTable;

  TBufImgArr = array[0..MaxListSize div 4] of PTBufImgInfo;
  PTBufImgArr = ^TBufImgArr;

  {-------------------------------------------------------------}

  TScreenImages = class   //항상 메모리에 올려야 하는 이미지들...
  private
    ImgHeader: TImgLibHeader;
  public
	 dScreen: TDGCScreen;
    BodyFile: string;
    HairFile: string;
    WeaponFile: string;
    MagEffectFile: string;
    ScreenFile: string;
    ILBody: TList;
    ILHair: TList;
    ILWeapon: TList;
    ILMagEffect: TList;
    ILScreenImage: TList;
    constructor Create;
    destructor Destroy; override;
    procedure Initialize;
               //sex  0:female  1: male
    function  GetHumBody (dresstype, sex, frameindex: integer): TSurfaceImage;
    function  GetHumHair (hairtype, sex, frameindex: integer): TSurfaceImage;
    function  GetHumWeapon (weapontype, sex, frameindex: integer): TSurfaceImage;
    function  GetMagEffect (magictype, frameindex: integer): TSurfaceImage;
    function  GetScreenImage (index: integer): TDgcSurface;
  end;

  TLoginImages = class     //Load, Free 조정이 가능
  private
    ImgHeader: TImgLibHeader;
  public
	 dScreen: TDGCScreen;
    LoginImageFile: string;
    ILLogin: TList;
    constructor Create;
    destructor Destroy; override;
    procedure Initialize;
    procedure LoadImages;
    procedure FreeImages;
    function GetImage (index: integer): TDgcSurface;
  end;

  TBufferingImages = class    //일정 메모리만큼만
  private
  public
	 dScreen: TDGCScreen;
    FileName: string;
    ImageArr: PTBufImgArr;     //array of PTBufImgInfo
    IndexList: TList;          //인덱스
    ImageCount: integer;       //Image 갯수
    MemorySize: inteter;
    constructor Create;
    destructor Destroy; override;
    procedure Initialize;
    function  GetSurface (index: integer): TDGCSurface;
  end;

  TMonsterImage = class
  private
    ImgHeader: TImgLibHeader;
    procedure LoadMonImages (monfile: string; surlist: TList; var imgsize: integer);
  public
	 dScreen: TDGCScreen;
    MonMemorySize: integer;
    MonArr: array[0..MAXMONRACE-1] of TBufImgMonInfo;   //하나의 파일에 한 몬스터
    constructor Create;
    destructor Destroy; override;
    procedure Initialize;
    function  MonValid (race: integer): Boolean;
    function  LoadMonster (race: integer): TList;
    procedure FreeMonster (race: integer);
  end;


implementation


constructor TScreenImages.Create;
begin
	dScreen := nil;
   BodyFile := '';
   HairFile := '';
   WeaponFile := '';
   MagEffectFile := '';
   ScreenFile := '';

   ILBody := TList.Create;
   ILHair := TList.Create;
   ILWeapon := TList.Create;
   ILMagEffect := TList.Create;
   ILScreenImage := TList.Create;

end;

destructor TScreenImages.Destroy;
begin
   ILBody.Free;
   ILHair.Free;
   ILWeapon.Free;
   ILMagEffect.Free;
   ILScreenImage.Free;
   inherited Destroy;
end;

procedure TScreenImages.Initialize;
begin
	if dScreen = nil then begin
      ShowMessage ('Initialize Error! TScreenImages.dScreen 설정 안됐음.');
      exit;
   end;
   if (BodyFile = '') or (HairFile = '') or (WeaponFile = '') or (MagEffectFile = '') or
      (ScreenFile = '') then begin
      ShowMessage ('Initialize error. no filename');
      exit;
   end;
   LoadLibrary (BodyFile, ILBody);
   LoadLibrary (HairFile, ILHair);
   LoadLibrary (WeaponFile, ILWeapon);
   LoadLibrary (MagEffectFile, ILMagEffect);
   LoadLibrary (ScreenFile, ILScreenImage);
end;

procedure TScreenImages.LoadLibrary (flname: string; ilist: TList);
var
   fhandle: integer;
   stream: TFileStream;
   i, j: integer;
   ImgHdr: TImgLibImage;
   surfaceimage: PTSurfaceImage;
begin
   stream := TFileStream.Create (flname, fmOpenRead or fmShareDenyNone);
   if stream <> nil then begin
      stream.ReadBuffer (ImgHeader, SizeOf(TImgLibHeader));
      for i:=0 to ImgHeader.ImageCount - 1 do begin
         stream.ReadBuffer(ImgHdr, SizeOf(TImgLibImage) - SizeOf(PByte));
         GetMem (ImgHdr.Bits, WidthBytes(ImgHdr.Width) * ImgHdr.Height);
         stream.ReadBuffer(ImgHdr.Bits^, WidthBytes(ImgHdr.Width) * ImgHdr.Height);

         new (surfaceimage);
         with surfaceimage^ do begin
            Surface := CreateSurface (dScreen, ImgHdr);
            px := GetX(ImgHdr);
            py := GetY(ImgHdr);
         end;
         ilist.Add(surfaceimage);
         Dispose (ImgHdr.Bits);
      end;
      stream.Free;   end;end;

//sex  0:female  1: male
function  TScreenImages.GetHumBody (dresstype, sex, frameindex: integer): TSurfaceImage;
var
   idx: integer;
begin
   Result.Surface := nil;
   idx := HUMANFRAME * dresstype * 2 + sex + frameindex;
   if idx < ILBody.Count then begin
      Result := ILBody[idx];
   end;
end;

function  TScreenImages.GetHumHair (hairtype, sex, frameindex: integer): TSurfaceImage;
var
   idx: integer;
begin
   Result.Surface := nil;
   idx := HUMANFRAME * hairtype * 2 + sex + frameindex;
   if idx < ILHair.Count then begin
      Result := ILHair[idx];
   end;
end;

function  TScreenImages.GetHumWeapon (weapontype, sex, frameindex: integer): TSurfaceImage;
var
   idx: integer;
begin
   Result.Surface := nil;
   idx := HUMANFRAME * weapontype * 2 + sex + frameindex;
   if idx < ILWeapon.Count then begin
      Result := ILWeapon[idx];
   end;
end;

function  TScreenImages.GetMagEffect (magictype, frameindex: integer): TSurfaceImage;
var
   idx: integer;
begin
   Result.Surface := nil;
   idx := MAGEFFECTFRAME * magictype + frameindex;
   if idx < ILMagEffect.Count then begin
      Result := ILMagEffect[idx];
   end;
end;

function  TScreenImages.GetScreenImage (index: integer): TDgcSurface;
begin
   Result := nil;
   if index < ILScreenImage.Count then begin
      Result := ILScreenImage[index].Surface;
   end;
end;

{======================================================================}

constructor TLoginImages.Create;    //Load, Free 조정이 가능
begin
   dScreen := nil;
   LoginImageFile := '';
   ILLogin := TList.Create;
end;

destructor TLoginImages.Destroy;
begin
   ILLogin.Free;
   inherited Destroy;
end;

procedure TLoginImages.Initialize;
begin
   if LoginImageFile = '' then begin
      ShowMessage ('LoginImageFile에 파일이름이 설정되지 않았음.');
      exit;
   end;
   if dScreen = nil then begin
      ShowMessage ('TLoginImages.dScreen의 초기화가 안됐습니다.');
      exit;
   end;
end;

procedure TLoginImages.LoadImages;
var
   fhandle: integer;
   stream: TFileStream;
   i, j: integer;
   ImgHdr: TImgLibImage;
   surface: TDGCSurface;
begin
   stream := TFileStream.Create (LoginImageFile, fmOpenRead or fmShareDenyNone);
   if stream <> nil then begin
      stream.ReadBuffer (ImgHeader, SizeOf(TImgLibHeader));
      for i:=0 to ImgHeader.ImageCount - 1 do begin
         stream.ReadBuffer(ImgHdr, SizeOf(TImgLibImage) - SizeOf(PByte));
         GetMem (ImgHdr.Bits, WidthBytes(ImgHdr.Width) * ImgHdr.Height);
         stream.ReadBuffer(ImgHdr.Bits^, WidthBytes(ImgHdr.Width) * ImgHdr.Height);

         surface := CreateSurface (dScreen, ImgHdr);
         ILLogin.Add(surface);
         Dispose (ImgHdr.Bits);
      end;
      stream.Free;   end;end;

procedure TLoginImages.FreeImages;
var
   i: integer;
begin
   for i:=0 to ILLogin.Count-1 do begin
      TDGCSurface(ILLogin[i]).Free;
   end;
   ILLogin.Clear;
end;

function TLoginImages.GetImage (index: integer): TDgcSurface;
end;
   Result := nil;
   if index < ILLogin.Count then
      Result := ILLogin[i];
end;

{======================================================================}


constructor TBufferingImages.Create;
begin
   dScreen := nil;
   ImageFile := '';
   ImageArr := nil;
   IndexList := TList.Create;
   ImageCount := 0;
   MemorySize := 0;
end;

destructor TBufferingImages.Destroy;
begin
   IndexList.Free;
   inherited Destroy;
end;

procedure TBufferingImages.Initialize;
var
   i, n: integer;
   stream: TFileStream;
   ImgHdr: TImgLibImage;
begin
   if ImageFile <> '' then begin
      stream := TFileStream.Create (ImageFile, fmOpenRead or fmShareDenyNone);
      if stream <> nil then begin
         stream.ReadBuffer (ImgHeader, SizeOf(TImgLibHeader));
         GetMem (ImageArr, sizeof(TBufImgInfo) * ImgHeader.ImageCount);
         ImageCount := ImgHeader.ImageCount;
         //Build Index
         for i:=0 to ImgHeader.ImageCount-1 do begin
            stream.ReadBuffer(ImgHdr, SizeOf(TImgLibImage) - SizeOf(PByte));
            n := stream.Seek (WidthBytes(ImgHdr.Width) * ImgHdr.Height, 1);
            IndexList.Add (pointer(n));
         end;
      end else
         ShowMessage ('File not found.. ' + ImageFile);
   end;
   if MaxMemorySize <= 0 then
      ShowMessage ('Maximum memory size is not setting..');
end;

procedure TBufferingImages.LoadImages (flname: string; findex: integer; var imginfo: TBufImgInfo);
var
   fhandle: integer;
   stream: TFileStream;
   i, j: integer;
   ImgHdr: TImgLibImage;
begin
   stream := TFileStream.Create (flname, fmOpenRead or fmShareDenyNone);
   if stream <> nil then begin
      stream.Seek (findex, 0);
      stream.ReadBuffer(ImgHdr, SizeOf(TImgLibImage) - SizeOf(PByte));
      GetMem (ImgHdr.Bits, WidthBytes(ImgHdr.Width) * ImgHdr.Height);
      stream.ReadBuffer(ImgHdr.Bits^, WidthBytes(ImgHdr.Width) * ImgHdr.Height);

      imginfo.Surface := CreateSurface (dScreen, ImgHdr);
      imginfo.ImageSize := WidthBytes(ImgHdr.Width) * ImgHdr.Height;
      imginfo.LatestTime := GetCurrentTime;
      Dispose (ImgHdr.Bits);
      stream.Free;
   end;end;

function  TBufferingImages.GetSurface (index: integer): TDGCSurface;
var
   findex: integer;
   bimg: PTBufImgInfo;
begin
   Result := nil;
   if not (index in [0..ImageCount-1]) then exit;
   if ImageArr[index] = nil then begin
      if index < IndexList.Count then begin
         findex := Integer(IndexList[index]);
         new (bimg);
         LoadImages (ItemFile, findex, bimg^);
         ImageArr[index] := bimg;
         Result := bimg.Surface;
         MemorySize := MemorySize + bimg.ImageSize;
         if MemorySize > MaxMemorySize then begin
            FreeOldMemorys;
         end;
      end;
   end else begin
      bimg := ImageArr[index];
      bimg.LatestTime := GetCurrentTime;
      Result := bimg.Surface;
   end;
end;

//메모리 해제 규칙
//허용한도를 넘었을때 호출된다.
//3분이상된것 부터 해제 시킨다.
//그래도 모자라면 오래된 순으로..
procedure TBufferingImages.FreeOldMemorys;
var
   i, n, ntime, curtime: integer;
begin
   n := -1;
   ntime := 0;
   for i:=0 to ImageCount-1 do begin
      curtime := GetCurrentTime;
      if curtime - ImageArr[i].LatestTime > 3 * 60 * 1000 then begin
         MemorySize := MemorySize - PTBufImgInfo(ImageArr[i]).ImageSize;
         ImageArr[i].Surface.Free;
         Dispose (PTBufImgInfo(ImageArr[i]));
         ImageArr[i] := nil;
      end else begin
         if curtime - ImageArr[i].LatestTime > ntime then begin
            ntime := curtime - ImageArr[i].LatestTime
            n := i;
         end;
      end;
      if MemorySize < MaxMemorySize * 9 div 10 then begin
         n := -1;
         break;
      end;
   end;
   if n >= 0 then begin
      MemorySize := MemorySize - PTBufImgInfo(ImageArr[n]).ImageSize;
      ImageArr[n].Surface.Free;
      Dispose (PTBufImgInfo(ImageArr[n]));
      ImageArr[n] := nil;
   end;
end;


{----------------------Monster Images--------------------------}

constructor TMonsterImage.Create;
begin
   dScreen := nil;
   FillChar (MonArr, sizeof(MonArr), #0);
   MonMemorySize := 0;
end;

destructor TMonsterImage.Destroy;
begin
   inherited Destroy;
end;

procedure TMonsterImage.Initialize;
begin
end;

procedure TBufferingImages.LoadMonImages (monfile: string; surlist: TList; var imgsize: integer);
var
   fhandle: integer;
   stream: TFileStream;
   i, j: integer;
   ImgHdr: TImgLibImage;
   surface: TDGCSurface;
begin
   stream := TFileStream.Create (monfile, fmOpenRead or fmShareDenyNone);
   if stream <> nil then begin
      stream.ReadBuffer (ImgHeader, SizeOf(TImgLibHeader));
      imgsize := 0;
      for i:=0 to ImgHeader.ImageCount - 1 do begin
         stream.ReadBuffer(ImgHdr, SizeOf(TImgLibImage) - SizeOf(PByte));
         GetMem (ImgHdr.Bits, WidthBytes(ImgHdr.Width) * ImgHdr.Height);
         stream.ReadBuffer(ImgHdr.Bits^, WidthBytes(ImgHdr.Width) * ImgHdr.Height);

         imgsize := imgsize + WidthBytes(ImgHdr.Width) * ImgHdr.Height;
         surface := CreateSurface (dScreen, ImgHdr);
         surlist.Add(surface);
         Dispose (ImgHdr.Bits);
      end;
      stream.Free;   end;end;

//LoadMonster를 통해서 얻은 SurfaceList의 유효성을 검사해줘야 한다.
function  TMonsterImage.MonValid (race: integer): Boolean;
begin
   Result := FALSE;
   if not (race in [0..MAXMONRACE-1]) then exit;
   if MonArr[race].SurfaceList <> nil then
      Result := TRUE;
end;

//ActorUnit에서 호출, 종족번호를 주고 SurfaceList를 얻어온다.
function  TMonsterImage.LoadMonster (race: integer): TList;
var
   i: integer;
   n, old: integer;
begin
   Result := nil;
   if not (race in [0..MAXMONRACE-1]) then exit;
   if MonArr[race].SurfaceList <> nil then exit; //이미 로딩되었음.
   MonArr[race].SurfaceList := TList.Create;
   LoadMonImages (DATADIR + IntToStr(race) + '.WMD', MonArr[race].SurfaceList, MonArr[race].ImageSize);
   MonArr[race].LatestTime := GetCurrentTime;
   MonMemorySize := MonMemorySize + MonArr[race].ImageSize;
   if MonMemorySize > MAXMONMEMORY then begin //제한 메모리를 초과하였으면
      old := GetCurrentTime;
      n := -1;
      for i:=0 to MAXMONRACE-1 do begin
         if (MonArr[i].LatestTime < old) and (MonArr[i].SurfaceList <> nil) then begin
            n := i;
            old := MonArr[i].LatestTime;
         end;
      end;
      if n >= 0 then begin
         FreeMonster (n);   //가장 오래된 것을 지운다.
      end;
   end;
   Result := MonArr[race].SurfaceList;
end;

procedure TMonsterImage.FreeMonster (race: integer);
var
   i: integer;
   list: TList;
begin
   if MonArr[race].SurfaceList <> nil then begin
      MonMemorySize := MonMemorySize - MonArr[race].ImageSize;
      list := MonArr[race].SurfaceList;
      for i:=0 to list.Count-1 do
         TDGCSurface(list[i]).Free;
      list.Free;
      MonArr[race].SurfaceList := nil;
   end;
end;


end.
