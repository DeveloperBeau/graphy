unit Sosemanuk256Model;

interface

const
  KeyBits = 256;
  BlockBits = 0;
  Rounds = 20;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'sosemanuk-256';
end;

end.
