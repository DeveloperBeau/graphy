unit UWriter;

interface

uses UDocument, UBox, UBorder, UPalette;

procedure RenderDocument(P: TPalette; W: Integer; const D: TDocument);

implementation

procedure RenderDocument(P: TPalette; W: Integer; const D: TDocument);
begin
  WriteLn(Decorate(P, D.Title));
  DrawBox(bRounded, W, D);
end;

end.
