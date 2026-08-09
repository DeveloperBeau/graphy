unit Misty1128Model;

interface

const
  KeyBits = 128;
  BlockBits = 64;
  Rounds = 12;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'misty1-128';
end;

end.
