unit URepl;

interface

uses UScanner, UParser, UAst, UEnvironment, UEvaluator, UHistory;

function EvalLine(var E: TEnv; const Line: string): Double;
procedure StepRepl(var E: TEnv; var H: THistory; const Line: string);

implementation

function EvalLine(var E: TEnv; const Line: string): Double;
var
  List: TTokenList;
  A: TAst;
begin
  Scan(Line, List);
  ParseTokens(List, A);
  EvalLine := EvalAst(A, E);
end;

procedure StepRepl(var E: TEnv; var H: THistory; const Line: string);
begin
  RecordEntry(H, Line, EvalLine(E, Line));
end;

end.
