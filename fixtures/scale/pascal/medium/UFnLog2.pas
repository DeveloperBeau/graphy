unit UFnLog2;

interface

function FnLog2(X: Double): Double;

implementation

function FnLog2(X: Double): Double;
begin
  FnLog2 := Ln(Abs(X) + 1e-12) / Ln(2);
end;

end.
