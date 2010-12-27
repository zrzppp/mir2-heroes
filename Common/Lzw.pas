unit Lzw;

interface

uses
  Windows, SysUtils, Classes;

const
  NOCODE = -1; // 空编码
  LZWBITS = 8; // 字对处理位
  LZWBUFFER = $FFFF; // 编码处理缓存容量（输入缓存容量。经实践，该值能达到较好的效率）
  LZWMAXBITS = 12; // 最大的编码位（增加该值会增加编码表的内存空间）
  LZWSTACKBUFFERSIZE = $FFFF; // 栈缓存容量（要保证它足够大）
  LZWEXPORTBLOCKSIZE = $FFFF; // 输出缓存容量
  LZWMAXCODES = 1 shl LZWMAXBITS; // 最大编码（4096）
  LZWTABLESIZE = 1 shl (LZWBITS + LZWMAXBITS); // 编码表容量（2MB空间）

type
  TLZWEncode = class(TObject)
  private
    EncodeTable: array[0..LZWTABLESIZE - 1] of Word; // 编码表
    EncodePointer: array[0..LZWMAXCODES - 1] of LongWord; // 经过编码的缓存
    ExportBlock: Pointer; // 存放编码后的数据指针（输出缓存块指针）
    ExportBlockPtr: array of Byte; // 该指针指向 ExportBlock ，用于访问数组
    InitBits: Integer; // 压缩数据的起始位数
    ClearCode: Integer; // 清除码
    EofCode: Integer; // 结束码
    PrefixCode: Integer; // 字头码
    SuffixCode: Integer; // 字尾码
    Encode: Integer; // 压缩编码
    RunBits: Integer; // 当前处理位
    MaxCodeSize: Integer; // 当前处理最大编码
    FBegin: Boolean; // 开始处理标志
    FExportSize: Integer; // 输出数据块大小
    FExportIndex: Integer; // 输出数据块索引
    FExportTotalSize: Integer; // 记录输出缓存块大小
    ShiftBits: Integer; // 用于位处理，作临时位
    ShiftCode: Integer; // 用于位处理，作临时代码
  protected
    procedure ExportData(AData: Integer); virtual; // 输出数据（虚方法）
  public
    function GetExportPointer: Pointer; // 返回输出指针
    function GetExportSize: Integer; // 返回输出大小
    procedure GetBegin; // 置开始编码标志
    procedure GetEnd; // 置结束编码标志
    procedure Execute(Data: array of Byte; DataSize: Integer); virtual; // 执行编码过程（虚方法）
    constructor Create;
    destructor Destroy; override;
  end;

  TLZWUnEncode = class(TObject)
  private
    InitBits: Integer; // 压缩数据的起始位数
    ClearCode: Integer; // 清除码
    EofCode: Integer; // 结束码
    PrefixCode: Integer; // 字头码
    SuffixCode: Integer; // 字尾码
    Encode: Integer; // 压缩编码
    RunBits: Integer; // 当前处理位
    MaxCodeSize: Integer; // 当前处理最大编码
    ExportBlock: Pointer; // 存放编码后的数据指针（输出缓存块指针）
    ExportBlockPtr: array of Byte; // 该指针指向 ExportBlock ，用于访问数组
    StackIndex: Integer; // 栈索引
    StackTable: array[0..LZWSTACKBUFFERSIZE - 1] of Byte; // 栈表
    PrefixTable: array[0..LZWMAXCODES - 1] of Word; // 字头表
    SuffixTable: array[0..LZWMAXCODES - 1] of Byte; // 字尾表
    FExportSize: Integer; // 输出数据块大小
    FExportIndex: Integer; // 输出数据块索引
    FExportTotalSize: Integer; // 记录输出缓存块大小
    ShiftBits: Integer; // 用于位处理，作临时位
    ShiftCode: Integer; // 用于位处理，作临时代码
  protected
    procedure ExportData(AData: Integer); virtual; // 输出数据（虚方法）
  public
    function GetExportPointer: Pointer; // 返回输出指针
    function GetExportSize: Integer; // 返回输出大小
    procedure GetBegin; // 开始解码（分配输出内存空间）
    procedure GetEnd; // 结束解码（释放输出内存空间）
    procedure Execute(Data: array of Byte; DataSize: Integer); virtual; // 执行解码过程（虚方法）
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TLZWEncode }

constructor TLZWEncode.Create;
begin
  InitBits := LZWBITS;
  ClearCode := 1 shl InitBits;
  EofCode := ClearCode + 1;
  Encode := EofCode + 1;
  RunBits := InitBits + 1;
  MaxCodeSize := 1 shl RunBits;
  FBegin := False;
  FExportSize := 0;
  FExportIndex := 0;
  FExportTotalSize := 0;
  ShiftBits := 0;
  ShiftCode := 0;
end;

destructor TLZWEncode.Destroy;
begin
  FreeMem(ExportBlock);
  inherited;
end;

procedure TLZWEncode.Execute(Data: array of Byte; DataSize: Integer);
var
  AIndex: Integer;
  ArrayIndex: Integer;
  Vi: Integer;
begin
  AIndex := 0;
  FExportIndex := 0;
  FExportTotalSize := LZWEXPORTBLOCKSIZE;
  { 处理文件首字节，赋值给字头码 }
  if FBegin then
  begin
    FBegin := False;
    ExportData(ClearCode);
    PrefixCode := Data[AIndex];
    Inc(AIndex);
  end;
  { 编码过程 }
  while AIndex < DataSize do
  begin
    { 取出数据，赋值给字尾码 }
    SuffixCode := Data[AIndex];
    Inc(AIndex);
    { 构造地址 }
    ArrayIndex := (PrefixCode shl LZWBITS) + SuffixCode;
    { 无可编码字对的情况 }
    if EncodeTable[ArrayIndex] = 0 then
    begin
      ExportData(PrefixCode); // 输出字头
      { 当前编码等于最大编码值的情况，作初始化工作 }
      if Encode = LZWMAXCODES then
      begin
        ExportData(ClearCode); // 输出清除码
        Encode := EofCode + 1;
        RunBits := InitBits + 1;
        MaxCodeSize := 1 shl RunBits;
        { 只需初始化编码过的内存区 }
        for Vi := Encode to LZWMAXCODES - 1 do
          EncodeTable[EncodePointer[Vi]] := 0;
      end
      else begin
        { 当前编码等于最大处理编码的情况 }
        if Encode = MaxCodeSize then
        begin
          Inc(RunBits); // 当前处理位增加
          MaxCodeSize := 1 shl RunBits; // 相应最大编码增加
        end;
        EncodeTable[ArrayIndex] := Encode; // 加入编码表
        EncodePointer[Encode] := ArrayIndex;
        Inc(Encode);
      end;
      PrefixCode := SuffixCode;
    end
    { 编码可匹配的情况 }
    else begin
      PrefixCode := EncodeTable[ArrayIndex];
    end;
  end;
end;

procedure TLZWEncode.ExportData(AData: Integer);
{ 输出过程 }
  procedure ExportProcedure;
  begin
    while ShiftBits >= LZWBITS do
    begin
      ExportBlockPtr[FExportIndex] := ShiftCode and $00FF;
      Inc(FExportIndex);
      if FExportIndex = FExportTotalSize then
      begin
        { 重新分配内存后首地址可能改变 }
        ReAllocMem(ExportBlock, FExportIndex + LZWEXPORTBLOCKSIZE);
        Pointer(ExportBlockPtr) := ExportBlock;
        Inc(FExportTotalSize, LZWEXPORTBLOCKSIZE);
      end;
      ShiftCode := ShiftCode shr LZWBITS;
      Dec(ShiftBits, LZWBITS);
    end;
  end;
begin
  { 输出位总是大于 LZWBITS 的 }
  ShiftCode := AData shl ShiftBits + ShiftCode;
  Inc(ShiftBits, RunBits);
  ExportProcedure;
end;

function TLZWEncode.GetExportPointer: Pointer;
begin
  Result := ExportBlock;
end;

function TLZWEncode.GetExportSize: Integer;
begin
  FExportSize := FExportIndex;
  Result := FExportSize;
end;

procedure TLZWEncode.GetBegin;
begin
  FBegin := True;
  { 有可能输出缓存大于输入缓存，如果发生，到时再重新分配内存 }
  ExportBlock := AllocMem(LZWEXPORTBLOCKSIZE);
  Pointer(ExportBlockPtr) := ExportBlock;
end;

procedure TLZWEncode.GetEnd;
begin
  ExportData(PrefixCode);
  ExportData(EofCode);
  { 最后的处理是看看有没有没处理的位 }
  while ShiftBits > 0 do
  begin
    ExportBlockPtr[FExportIndex] := ShiftCode and $00FF;
    Inc(FExportIndex);
    if FExportIndex = FExportTotalSize then
    begin
      ReAllocMem(ExportBlock, FExportIndex + LZWEXPORTBLOCKSIZE);
      Pointer(ExportBlockPtr) := ExportBlock;
      Inc(FExportTotalSize, LZWEXPORTBLOCKSIZE);
    end;
    ShiftCode := ShiftCode shr LZWBITS;
    Dec(ShiftBits, LZWBITS);
  end;
end;

{ TLZWUnencode }

constructor TLZWUnEncode.Create;
begin
  InitBits := LZWBITS;
  ClearCode := 1 shl InitBits;
  EofCode := ClearCode + 1;
  Encode := EofCode + 1;
  RunBits := InitBits + 1;
  MaxCodeSize := 1 shl RunBits;
  ShiftBits := 0;
  ShiftCode := 0;
  FExportSize := 0;
  FExportIndex := 0;
  FExportTotalSize := 0;
end;

destructor TLZWUnEncode.Destroy;
begin
  inherited;
end;

procedure TLZWUnEncode.Execute(Data: array of Byte; DataSize: Integer);
const
  MaskCode: array[0..LZWMAXBITS] of Word = (
    $0000, $0001, $0003, $0007,
    $000F, $001F, $003F, $007F,
    $00FF, $01FF, $03FF, $07FF,
    $0FFF);
var
  AIndex: Integer;
  CurrentCode, ACode: Integer;
begin
  AIndex := 0;
  FExportIndex := 0;
  FExportTotalSize := LZWSTACKBUFFERSIZE;
  { 解码过程 }
  while AIndex < DataSize do
  begin
    { 取出数据 }
    while (ShiftBits < RunBits) and (AIndex < DataSize) do
    begin
      ShiftCode := Data[AIndex] shl ShiftBits + ShiftCode;
      Inc(AIndex);
      Inc(ShiftBits, LZWBITS);
    end;

    if AIndex >= DataSize then
      Exit;
    CurrentCode := ShiftCode and MaskCode[RunBits];
    ShiftCode := ShiftCode shr RunBits;
    Dec(ShiftBits, RunBits);
    { 遇到结束码则退出 }
    if CurrentCode = EofCode then
      Exit;
    { 遇到清除码则初始化 }
    if CurrentCode = ClearCode then
    begin
      RunBits := InitBits + 1;
      Encode := EofCode + 1;
      MaxCodeSize := 1 shl RunBits;
      PrefixCode := NOCODE;
      SuffixCode := NOCODE;
    end
    else
    begin
      ACode := CurrentCode;
      StackIndex := 0;
      { 当前代码正好与当前编码值相等的情况 }
      if ACode = Encode then
      begin
        StackTable[StackIndex] := SuffixCode;
        Inc(StackIndex);
        ACode := PrefixCode;
      end;
      { 当前代码大于当前编码值的情况，递归取值 }
      while ACode > EofCode do
      begin
        StackTable[StackIndex] := SuffixTable[ACode];
        Inc(StackIndex);
        ACode := PrefixTable[ACode];
      end;
      SuffixCode := ACode;
      { 输出数据 }
      ExportData(ACode);
      while StackIndex > 0 do
      begin
        Dec(StackIndex);
        ExportData(StackTable[StackIndex]);
      end;
      { 加入字典 }
      if (Encode < LZWMAXCODES) and (PrefixCode <> NOCODE) then
      begin
        PrefixTable[Encode] := PrefixCode;
        SuffixTable[Encode] := SuffixCode;
        Inc(Encode);
        if (Encode >= MaxCodeSize) and (RunBits < LZWMAXBITS) then
        begin
          MaxCodeSize := MaxCodeSize shl 1;
          Inc(RunBits);
        end;
      end;
      PrefixCode := CurrentCode;
    end;
  end;
end;

procedure TLZWUnEncode.ExportData(AData: Integer);
begin
  ExportBlockPtr[FExportIndex] := AData;
  Inc(FExportIndex);
  if FExportIndex = FExportTotalSize then
  begin
    ReAllocMem(ExportBlock, FExportIndex + LZWSTACKBUFFERSIZE);
    Pointer(ExportBlockPtr) := ExportBlock;
    Inc(FExportTotalSize, LZWSTACKBUFFERSIZE);
  end;
end;

procedure TLZWUnEncode.GetBegin;
begin
  ExportBlock := AllocMem(LZWSTACKBUFFERSIZE);
  Pointer(ExportBlockPtr) := ExportBlock;
end;

procedure TLZWUnEncode.GetEnd;
begin
  FreeMem(ExportBlock);
end;

function TLZWUnEncode.GetExportPointer: Pointer;
begin
  Result := ExportBlock;
end;

function TLZWUnEncode.GetExportSize: Integer;
begin
  FExportSize := FExportIndex;
  Result := FExportSize;
end;

end.

