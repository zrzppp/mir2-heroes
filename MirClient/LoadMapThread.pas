unit LoadMapThread;

interface
uses
  Windows, Classes, SysUtils;
type
  TLoadMapThread = class(TThread)
    m_UserCriticalSection: TRTLCriticalSection;
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    constructor Create(ThreadDone: TNotifyEvent);
    destructor Destroy; override;
  end;
implementation
uses MShare;

constructor TLoadMapThread.Create(ThreadDone: TNotifyEvent);
begin
  //FreeOnTerminate := True;
  inherited Create(True);
  OnTerminate := ThreadDone;
  Resume;
end;

destructor TLoadMapThread.Destroy;
begin
  inherited Destroy;
end;

procedure TLoadMapThread.Execute;
begin
  while not Self.Terminated do begin
    if (g_MySelf = nil) or (g_ConnectionStep <> cnsPlay) then begin
      Sleep(1);
      Continue;
    end;
    Map.LoadAllMap;
    Sleep(1);
  end;
end;

end.

