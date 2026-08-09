unit UNumber;

interface

function FromInt(N: Integer): Double;
function IsZero(X: Double): Boolean;

implementation

function FromInt(N: Integer): Double;
begin
  FromInt := N;
end;

function IsZero(X: Double): Boolean;
begin
  IsZero := Abs(X) < 1e-9;
end;

end.
