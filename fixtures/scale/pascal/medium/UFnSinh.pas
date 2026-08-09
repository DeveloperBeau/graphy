unit UFnSinh;

interface

function FnSinh(X: Double): Double;

implementation

function FnSinh(X: Double): Double;
begin
  FnSinh := (Exp(X) - Exp(-X)) / 2;
end;

end.
