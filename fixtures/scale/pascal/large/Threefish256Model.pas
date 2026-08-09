unit Threefish256Model;

interface

const
  KeyBits = 256;
  BlockBits = 256;
  Rounds = 20;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'threefish-256';
end;

end.
