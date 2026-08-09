unit UFnTan;

interface

function FnTan(X: Double): Double;

implementation

function FnTan(X: Double): Double;
begin
  FnTan := Sin(X) / Cos(X);
end;

end.
