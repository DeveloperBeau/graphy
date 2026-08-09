unit USupportBase64;

interface

function Base64Char(B: Integer): Char;

implementation

const
  Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

function Base64Char(B: Integer): Char;
begin
  Base64Char := Alphabet[B mod 64 + 1];
end;

end.
