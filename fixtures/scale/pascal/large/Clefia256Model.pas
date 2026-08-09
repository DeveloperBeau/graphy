unit Clefia256Model;

interface

const
  KeyBits = 256;
  BlockBits = 128;
  Rounds = 20;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'clefia-256';
end;

end.
