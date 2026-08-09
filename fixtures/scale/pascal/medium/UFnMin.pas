unit UFnMin;

interface

function FnMin(X, Y: Double): Double;

implementation

function FnMin(X, Y: Double): Double;
begin
  if X < Y then
    FnMin := X
  else
    FnMin := Y;
end;

end.
