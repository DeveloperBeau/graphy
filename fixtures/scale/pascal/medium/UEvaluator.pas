unit UEvaluator;

interface

uses UAst, UEnvironment, URegistry;

function EvalNode(const A: TAst; const E: TEnv; Node: Integer): Double;
function EvalAst(const A: TAst; const E: TEnv): Double;

implementation

function EvalNode(const A: TAst; const E: TEnv; Node: Integer): Double;
var
  L, R: Double;
begin
  EvalNode := 0;
  if Node = 0 then
    Exit;
  case A.Nodes[Node].Kind of
    nkLit: EvalNode := A.Nodes[Node].Value;
    nkVar: EvalNode := LookupVar(E, A.Nodes[Node].Name);
    nkCall: EvalNode := Dispatch(A.Nodes[Node].Name, EvalNode(A, E, A.Nodes[Node].Right), 0);
    nkBinOp:
      begin
        L := EvalNode(A, E, A.Nodes[Node].Left);
        R := EvalNode(A, E, A.Nodes[Node].Right);
        case A.Nodes[Node].Op of
          '+': EvalNode := L + R;
          '-': EvalNode := L - R;
          '*': EvalNode := L * R;
          '/': if R <> 0 then EvalNode := L / R;
        end;
      end;
  end;
end;

function EvalAst(const A: TAst; const E: TEnv): Double;
begin
  EvalAst := EvalNode(A, E, A.Root);
end;

end.
