unit URegistry;

interface

uses UFnSqrt, UFnSin, UFnCos, UFnExp, UFnLn, UFnPow;

function Dispatch(const Name: string; X, Y: Double): Double;
function KnownFunction(const Name: string): Boolean;

implementation

function Dispatch(const Name: string; X, Y: Double): Double;
begin
  if Name = 'sqrt' then
    Dispatch := FnSqrt(X)
  else if Name = 'sin' then
    Dispatch := FnSin(X)
  else if Name = 'cos' then
    Dispatch := FnCos(X)
  else if Name = 'exp' then
    Dispatch := FnExp(X)
  else if Name = 'ln' then
    Dispatch := FnLn(X)
  else if Name = 'pow' then
    Dispatch := FnPow(X, Y)
  else
    Dispatch := 0;
end;

function KnownFunction(const Name: string): Boolean;
begin
  KnownFunction := (Name = 'sqrt') or (Name = 'sin') or (Name = 'cos')
    or (Name = 'exp') or (Name = 'ln') or (Name = 'pow');
end;

end.
