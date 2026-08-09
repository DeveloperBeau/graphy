unit UFnLcm;

interface

function FnLcm(X, Y: Double): Double;

implementation

function FnLcm(X, Y: Double): Double;
var
  A, B, P, Q, T: LongInt;
begin
  A := Abs(Round(X));
  B := Abs(Round(Y));
  P := A;
  Q := B;
  while Q <> 0 do
  begin
    T := Q;
    Q := P mod Q;
    P := T;
  end;
  if P = 0 then
    FnLcm := 0
  else
    FnLcm := (A div P) * B;
end;

end.
