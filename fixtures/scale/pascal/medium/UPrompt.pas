unit UPrompt;

interface

function Banner: string;
function PromptText(N: Integer): string;

implementation

function Banner: string;
begin
  Banner := 'calc - type an expression';
end;

function PromptText(N: Integer): string;
var
  S: string;
begin
  Str(N, S);
  PromptText := '[' + S + '] > ';
end;

end.
