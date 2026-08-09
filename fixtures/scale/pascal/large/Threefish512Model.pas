unit Threefish512Model;

interface

const
  KeyBits = 512;
  BlockBits = 256;
  Rounds = 36;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'threefish-512';
end;

end.
