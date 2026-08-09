unit Rc6128Model;

interface

const
  KeyBits = 128;
  BlockBits = 128;
  Rounds = 12;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'rc6-128';
end;

end.
