unit Blowfish256Model;

interface

const
  KeyBits = 256;
  BlockBits = 64;
  Rounds = 20;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'blowfish-256';
end;

end.
