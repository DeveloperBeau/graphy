unit UFnCosh;

interface

function FnCosh(X: Double): Double;

implementation

function FnCosh(X: Double): Double;
begin
  FnCosh := (Exp(X) + Exp(-X)) / 2;
end;

end.
