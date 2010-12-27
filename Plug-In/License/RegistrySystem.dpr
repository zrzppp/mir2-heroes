library RegistrySystem;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Forms,
  PlugMain in 'PlugMain.pas',
  Share in 'Share.pas',
  RegistryFrm in 'RegistryFrm.pas' {FrmRegistryDlg},
  EncryptUnit in '..\..\Common\EncryptUnit.pas',
  PlugShare in 'PlugShare.pas';

{$R *.res}
exports
  SystemInitialize index 1 name '',
  GetRegistryInfo index 2 name '',
  GetRegistryKey index 3 name '';
  //Init, UnInit, Config;

procedure MyDLLHandler(Reason: Integer);
begin
  
  case Reason of
    DLL_PROCESS_ATTACH:
      begin //建立文件映射,以实现DLL中的全局变量
        FillChar(R_SystemConfig, SizeOf(TSystemConfig), #0);
        New(R_SystemInitialize);
        New(R_nOwner);
        New(R_nUserNumber);
        New(R_nVersion);
        R_SystemInitialize^ := False;
        R_nOwner^ := Random(888888888);
        R_nUserNumber^ := Random(888888888);
        R_nVersion^ := Random(6666);
        R_nOwner^ := CalcFileCRC(Application.ExeName);
      end;
    DLL_PROCESS_DETACH:
      begin
        Dispose(R_nUserNumber);
        Dispose(R_nVersion);
        Dispose(R_nOwner);
        Dispose(R_SystemInitialize);
        {if Assigned(DLLData) then begin

        end;}
      end;
  end;
end;

begin
  Randomize;
  DLLProc := @MyDLLHandler;
  MyDLLHandler(DLL_PROCESS_ATTACH);
end.

