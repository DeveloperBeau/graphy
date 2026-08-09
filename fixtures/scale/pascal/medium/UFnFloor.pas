unit UFnFloor;

interface

function FnFloor(X: Double): Double;

implementation

function FnFloor(X: Double): Double;
begin
  FnFloor := Int(X);
end;

end.
