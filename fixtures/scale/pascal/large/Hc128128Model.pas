unit Hc128128Model;

interface

const
  KeyBits = 128;
  BlockBits = 0;
  Rounds = 12;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'hc128-128';
end;

end.
