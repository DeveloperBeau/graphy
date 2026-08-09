unit UFnMax;

interface

function FnMax(X, Y: Double): Double;

implementation

function FnMax(X, Y: Double): Double;
begin
  if X > Y then
    FnMax := X
  else
    FnMax := Y;
end;

end.
