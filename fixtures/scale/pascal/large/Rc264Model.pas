unit Rc264Model;

interface

const
  KeyBits = 64;
  BlockBits = 64;
  Rounds = 8;

function CipherName: string;

implementation

function CipherName: string;
begin
  CipherName := 'rc2-64';
end;

end.
