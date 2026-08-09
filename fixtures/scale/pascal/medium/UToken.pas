unit UToken;

interface

type
  TTokenKind = (tkNum, tkIdent, tkOp, tkLParen, tkRParen, tkComma);

  TToken = record
    Kind: TTokenKind;
    Num: Double;
    Text: string;
    Op: Char;
  end;

function MakeToken(Kind: TTokenKind): TToken;

implementation

function MakeToken(Kind: TTokenKind): TToken;
var
  T: TToken;
begin
  T.Kind := Kind;
  T.Num := 0;
  T.Text := '';
  T.Op := ' ';
  MakeToken := T;
end;

end.
