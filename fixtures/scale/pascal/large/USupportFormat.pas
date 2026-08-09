unit USupportFormat;

interface

function PadRightStr(const S: string; W: Integer): string;
function BarText(N: Integer): string;

implementation

function PadRightStr(const S: string; W: Integer): string;
var
  R: string;
begin
  R := S;
  while Length(R) < W do
    R := R + ' ';
  PadRightStr := R;
end;

function BarText(N: Integer): string;
var
  I: Integer;
  R: string;
begin
  R := '';
  for I := 1 to N do
    R := R + '#';
  BarText := R;
end;

end.
