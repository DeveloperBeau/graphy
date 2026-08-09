unit UFnGcd;

interface

function FnGcd(X, Y: Double): Double;

implementation

function FnGcd(X, Y: Double): Double;
var
  A, B, T: LongInt;
begin
  A := Abs(Round(X));
  B := Abs(Round(Y));
  while B <> 0 do
  begin
    T := B;
    B := A mod B;
    A := T;
  end;
  FnGcd := A;
end;

end.
