unit UPad;

interface

function Blank(N: Integer): string;
function PadTo(W: Integer; const S: string): string;

implementation

function Blank(N: Integer): string;
var
  I: Integer;
  R: string;
begin
  R := '';
  for I := 1 to N do
    R := R + ' ';
  Blank := R;
end;

function PadTo(W: Integer; const S: string): string;
begin
  if Length(S) >= W then
    PadTo := Copy(S, 1, W)
  else
    PadTo := S + Blank(W - Length(S));
end;

end.
