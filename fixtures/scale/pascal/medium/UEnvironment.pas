unit UEnvironment;

interface

uses UConstants;

const
  MaxVars = 32;

type
  TEnv = record
    Names: array[1..MaxVars] of string;
    Values: array[1..MaxVars] of Double;
    Count: Integer;
  end;

procedure InitEnv(var E: TEnv);
procedure Bind(var E: TEnv; const Name: string; Value: Double);
function LookupVar(const E: TEnv; const Name: string): Double;

implementation

procedure InitEnv(var E: TEnv);
begin
  E.Count := 0;
end;

procedure Bind(var E: TEnv; const Name: string; Value: Double);
begin
  E.Count := E.Count + 1;
  E.Names[E.Count] := Name;
  E.Values[E.Count] := Value;
end;

function LookupVar(const E: TEnv; const Name: string): Double;
var
  I: Integer;
  C: Double;
begin
  LookupVar := 0;
  if LookupConstant(Name, C) then
    LookupVar := C;
  for I := 1 to E.Count do
    if E.Names[I] = Name then
      LookupVar := E.Values[I];
end;

end.
