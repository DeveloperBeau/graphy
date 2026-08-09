unit Simon64Model;

interface

const
  KeyBits = 64;
  BlockBits = 64;
  Rounds = 8;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'simon-64';
end;

end.
