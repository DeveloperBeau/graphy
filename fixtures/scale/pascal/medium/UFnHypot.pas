unit UFnHypot;

interface

function FnHypot(X, Y: Double): Double;

implementation

function FnHypot(X, Y: Double): Double;
begin
  FnHypot := Sqrt(X * X + Y * Y);
end;

end.
