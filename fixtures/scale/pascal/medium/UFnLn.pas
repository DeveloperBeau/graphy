unit UFnLn;

interface

function FnLn(X: Double): Double;

implementation

function FnLn(X: Double): Double;
begin
  FnLn := Ln(Abs(X) + 1e-12);
end;

end.
