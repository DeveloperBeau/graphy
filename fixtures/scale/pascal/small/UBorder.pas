unit UBorder;

interface

type
  TBorder = (bAscii, bRounded, bHeavy);

function HorizontalChar(B: TBorder): Char;
function VerticalChar(B: TBorder): Char;

implementation

function HorizontalChar(B: TBorder): Char;
begin
  if B = bHeavy then
    HorizontalChar := '='
  else
    HorizontalChar := '-';
end;

function VerticalChar(B: TBorder): Char;
begin
  VerticalChar := '|';
end;

end.
