unit UFnCeil;

interface

function FnCeil(X: Double): Double;

implementation

function FnCeil(X: Double): Double;
begin
  if Frac(X) > 0 then
    FnCeil := Int(X) + 1
  else
    FnCeil := Int(X);
end;

end.
