unit UPalette;

interface

type
  TPalette = (pPlain, pBright);

function Decorate(P: TPalette; const S: string): string;

implementation

function Decorate(P: TPalette; const S: string): string;
begin
  if P = pBright then
    Decorate := '*' + S + '*'
  else
    Decorate := S;
end;

end.
