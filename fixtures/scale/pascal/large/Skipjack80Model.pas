unit Skipjack80Model;

interface

const
  KeyBits = 80;
  BlockBits = 64;
  Rounds = 9;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'skipjack-80';
end;

end.
