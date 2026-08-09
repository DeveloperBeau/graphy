unit UFnPow;

interface

function FnPow(X, Y: Double): Double;

implementation

function FnPow(X, Y: Double): Double;
begin
  FnPow := Exp(Y * Ln(Abs(X) + 1e-12));
end;

end.
