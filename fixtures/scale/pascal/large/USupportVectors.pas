unit USupportVectors;

interface

uses USupportRng;

procedure SampleVector(Key: Integer; var Data: array of Integer);

implementation

procedure SampleVector(Key: Integer; var Data: array of Integer);
var
  Seed: LongInt;
begin
  Seed := Key + 7;
  FillStream(Seed, Data);
end;

end.
