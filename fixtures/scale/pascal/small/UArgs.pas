unit UArgs;

interface

type
  TOptions = record
    BoxWidth: Integer;
    Heading: string;
  end;

function ParseArgs: TOptions;

implementation

function ParseArgs: TOptions;
var
  O: TOptions;
begin
  O.BoxWidth := 32;
  O.Heading := 'report';
  if ParamCount >= 1 then
    O.Heading := ParamStr(1);
  ParseArgs := O;
end;

end.
