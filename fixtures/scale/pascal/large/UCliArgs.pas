unit UCliArgs;

interface

type
  TOptions = record
    OnlyCipher: string;
    Quick: Boolean;
  end;

function ParseOptions: TOptions;

implementation

function ParseOptions: TOptions;
var
  O: TOptions;
begin
  O.OnlyCipher := '';
  O.Quick := False;
  if ParamCount >= 1 then
    O.OnlyCipher := ParamStr(1);
  ParseOptions := O;
end;

end.
