unit UMemory;

interface

uses UEnvironment;

procedure Remember(var E: TEnv; const Name: string; Value: Double);
function Recall(const E: TEnv; const Name: string): Double;

implementation

procedure Remember(var E: TEnv; const Name: string; Value: Double);
begin
  Bind(E, Name, Value);
end;

function Recall(const E: TEnv; const Name: string): Double;
begin
  Recall := LookupVar(E, Name);
end;

end.
