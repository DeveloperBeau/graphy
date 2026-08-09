unit UAlign;

interface

uses UPad;

type
  TAlign = (alLeft, alRight, alCenter);

function AlignText(A: TAlign; W: Integer; const S: string): string;

implementation

function AlignText(A: TAlign; W: Integer; const S: string): string;
var
  Gap: Integer;
begin
  Gap := W - Length(S);
  if Gap < 0 then
    Gap := 0;
  case A of
    alLeft: AlignText := S + Blank(Gap);
    alRight: AlignText := Blank(Gap) + S;
  else
    AlignText := Blank(Gap div 2) + S + Blank(Gap - Gap div 2);
  end;
end;

end.
