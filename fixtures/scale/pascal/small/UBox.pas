unit UBox;

interface

uses UCell, UDocument, ULine, UAlign, UBorder;

procedure DrawBox(B: TBorder; W: Integer; const D: TDocument);

implementation

procedure DrawBox(B: TBorder; W: Integer; const D: TDocument);
var
  I: Integer;
begin
  WriteLn(Rule(B, W));
  WriteLn(Framed(B, W, AlignText(alCenter, W, D.Title)));
  WriteLn(Rule(B, W));
  for I := 1 to D.Count do
    WriteLn(Framed(B, W, AlignText(alLeft, W, D.Cells[I].Content)));
  WriteLn(Rule(B, W));
end;

end.
