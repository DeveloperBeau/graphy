unit UFnSign;

interface

function FnSign(X: Double): Double;

implementation

function FnSign(X: Double): Double;
begin
  if X > 0 then
    FnSign := 1
  else if X < 0 then
    FnSign := -1
  else
    FnSign := 0;
end;

end.
