program CipherBench;

uses UCliArgs, UCoreConfig, UCoreRegistry, UCoreStore, UCoreProgress, USupportReport, USupportResult, Aes128Runner;

var
  Opts: TOptions;
  Cfg: TConfig;
  R: TTestResult;

begin
  Opts := ParseOptions;
  Cfg := DefaultConfig;
  R := RunCase(42);
  SaveResult(Cfg, R);
  ShowProgress(1, Catalog);
  WriteLn(ResultLine(R));
  WriteLn(Summary(1, Catalog));
end.
