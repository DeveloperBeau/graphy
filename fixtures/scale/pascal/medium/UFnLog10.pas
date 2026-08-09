unit UFnLog10;

interface

function FnLog10(X: Double): Double;

implementation

function FnLog10(X: Double): Double;
begin
  FnLog10 := Ln(Abs(X) + 1e-12) / Ln(10);
end;

end.
