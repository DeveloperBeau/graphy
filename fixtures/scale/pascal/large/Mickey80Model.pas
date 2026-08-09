unit Mickey80Model;

interface

const
  KeyBits = 80;
  BlockBits = 0;
  Rounds = 9;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'mickey-80';
end;

end.
