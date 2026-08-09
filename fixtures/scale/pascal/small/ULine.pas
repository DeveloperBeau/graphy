unit ULine;

interface

uses UBorder, UPad;

function Rule(B: TBorder; W: Integer): string;
function Framed(B: TBorder; W: Integer; const S: string): string;

implementation

function Rule(B: TBorder; W: Integer): string;
var
  I: Integer;
  R: string;
begin
  R := '';
  for I := 1 to W do
    R := R + HorizontalChar(B);
  Rule := R;
end;

function Framed(B: TBorder; W: Integer; const S: string): string;
begin
  Framed := VerticalChar(B) + PadTo(W, S) + VerticalChar(B);
end;

end.
