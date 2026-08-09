unit Rabbit128Model;

interface

const
  KeyBits = 128;
  BlockBits = 0;
  Rounds = 12;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'rabbit-128';
end;

end.
