unit UFnAsin;

interface

function FnAsin(X: Double): Double;

implementation

function FnAsin(X: Double): Double;
begin
  FnAsin := ArcTan(X / Sqrt(1 - X * X + 1e-12));
end;

end.
