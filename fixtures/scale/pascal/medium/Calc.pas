program Calc;

uses UEnvironment, UHistory, UPrompt, URepl, UOutput;

var
  Env: TEnv;
  Hist: THistory;

begin
  WriteLn(Banner);
  InitEnv(Env);
  Hist.Count := 0;
  StepRepl(Env, Hist, 'sqrt(16) + 2 * 3');
  StepRepl(Env, Hist, 'sin(1) + cos(1)');
  PrintHistory(Hist);
end.
