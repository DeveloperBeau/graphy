unit UFnSqrt;

interface

function FnSqrt(X: Double): Double;

implementation

function FnSqrt(X: Double): Double;
begin
  FnSqrt := Sqrt(Abs(X));
end;

end.
