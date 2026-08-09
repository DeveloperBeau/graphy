unit UError;

interface

type
  TCalcError = (ceNone, ceUnknownSymbol, ceArity);

function ErrorMessage(E: TCalcError): string;

implementation

function ErrorMessage(E: TCalcError): string;
begin
  case E of
    ceUnknownSymbol: ErrorMessage := 'unknown symbol';
    ceArity: ErrorMessage := 'wrong argument count';
  else
    ErrorMessage := 'ok';
  end;
end;

end.
