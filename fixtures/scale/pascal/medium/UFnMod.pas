unit UFnMod;

interface

function FnMod(X, Y: Double): Double;

implementation

function FnMod(X, Y: Double): Double;
begin
  if Y = 0 then
    FnMod := 0
  else
    FnMod := X - Y * Int(X / Y);
end;

end.
