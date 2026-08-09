unit Lea192Model;

interface

const
  KeyBits = 192;
  BlockBits = 128;
  Rounds = 16;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'lea-192';
end;

end.
