unit Aes256Model;

interface

const
  KeyBits = 256;
  BlockBits = 128;
  Rounds = 20;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'aes-256';
end;

end.
