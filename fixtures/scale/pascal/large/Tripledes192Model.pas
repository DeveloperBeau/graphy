unit Tripledes192Model;

interface

const
  KeyBits = 192;
  BlockBits = 64;
  Rounds = 16;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'tripledes-192';
end;

end.
