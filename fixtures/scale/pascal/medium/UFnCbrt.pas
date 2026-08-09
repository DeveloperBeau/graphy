unit UFnCbrt;

interface

function FnCbrt(X: Double): Double;

implementation

function FnCbrt(X: Double): Double;
begin
  FnCbrt := Exp(Ln(Abs(X) + 1e-12) / 3);
end;

end.
