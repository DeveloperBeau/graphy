unit Rc5128Model;

interface

const
  KeyBits = 128;
  BlockBits = 64;
  Rounds = 12;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'rc5-128';
end;

end.
