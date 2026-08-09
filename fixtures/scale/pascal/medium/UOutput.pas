unit UOutput;

interface

uses UHistory;

function FormatNumber(X: Double): string;
procedure PrintHistory(const H: THistory);

implementation

function FormatNumber(X: Double): string;
var
  S: string;
begin
  Str(X:0:3, S);
  FormatNumber := S;
end;

procedure PrintHistory(const H: THistory);
var
  I: Integer;
begin
  for I := 1 to H.Count do
    WriteLn(H.Sources[I], ' = ', FormatNumber(H.Results[I]));
end;

end.
