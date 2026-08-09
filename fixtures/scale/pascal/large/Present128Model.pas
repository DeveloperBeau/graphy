unit Present128Model;

interface

const
  KeyBits = 128;
  BlockBits = 64;
  Rounds = 12;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'present-128';
end;

end.
