unit USupportRng;

interface

function NextByte(var Seed: LongInt): Integer;
procedure FillStream(var Seed: LongInt; var Data: array of Integer);

implementation

function NextByte(var Seed: LongInt): Integer;
begin
  Seed := (Seed * 16807) mod 2147483647;
  NextByte := Seed mod 256;
end;

procedure FillStream(var Seed: LongInt; var Data: array of Integer);
var
  I: Integer;
begin
  for I := Low(Data) to High(Data) do
    Data[I] := NextByte(Seed);
end;

end.
