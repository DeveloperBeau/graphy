unit UCoreStore;

interface

uses UCoreConfig, USupportResult;

procedure SaveResult(const Cfg: TConfig; const R: TTestResult);
function LoadCount(const Cfg: TConfig): Integer;

implementation

procedure SaveResult(const Cfg: TConfig; const R: TTestResult);
var
  F: Text;
begin
  Assign(F, Cfg.ResultsPath);
  Append(F);
  WriteLn(F, R.Subject);
  Close(F);
end;

function LoadCount(const Cfg: TConfig): Integer;
var
  F: Text;
  Line: string;
  N: Integer;
begin
  N := 0;
  Assign(F, Cfg.ResultsPath);
  Reset(F);
  while not Eof(F) do
  begin
    ReadLn(F, Line);
    N := N + 1;
  end;
  Close(F);
  LoadCount := N;
end;

end.
