unit USupportHex;

interface

function HexEncodeByte(B: Integer): string;

implementation

const
  Digits = '0123456789abcdef';

function HexEncodeByte(B: Integer): string;
begin
  HexEncodeByte := Digits[B div 16 + 1] + Digits[B mod 16 + 1];
end;

end.
