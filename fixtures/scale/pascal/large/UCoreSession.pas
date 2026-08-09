unit UCoreSession;

interface

uses UCoreConfig, UCoreProgress;

type
  TSession = record
    Done: Integer;
    Config: TConfig;
  end;

function BeginSession: TSession;
procedure StepSession(var S: TSession; Total: Integer);

implementation

function BeginSession: TSession;
var
  S: TSession;
begin
  S.Done := 0;
  S.Config := DefaultConfig;
  BeginSession := S;
end;

procedure StepSession(var S: TSession; Total: Integer);
begin
  S.Done := S.Done + 1;
  ShowProgress(S.Done, Total);
end;

end.
