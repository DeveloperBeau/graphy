unit UCoreRegistry;

interface

uses Aes128Runner, Chacha20256Runner, Salsa20256Runner, Blowfish256Runner;

function Catalog: Integer;
function FirstLabel: string;

implementation

function Catalog: Integer;
begin
  Catalog := 4;
end;

function FirstLabel: string;
begin
  FirstLabel := CaseLabel;
end;

end.
