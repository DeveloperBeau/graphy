unit UFnTanh;

interface

function FnTanh(X: Double): Double;

implementation

function FnTanh(X: Double): Double;
begin
  FnTanh := (Exp(2 * X) - 1) / (Exp(2 * X) + 1);
end;

end.
