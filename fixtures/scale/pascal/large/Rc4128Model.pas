unit Rc4128Model;

interface

const
  KeyBits = 128;
  BlockBits = 0;
  Rounds = 12;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'rc4-128';
end;

end.
