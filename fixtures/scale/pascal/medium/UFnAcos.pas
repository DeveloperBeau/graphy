unit UFnAcos;

interface

function FnAcos(X: Double): Double;

implementation

function FnAcos(X: Double): Double;
begin
  FnAcos := Pi / 2 - ArcTan(X / Sqrt(1 - X * X + 1e-12));
end;

end.
