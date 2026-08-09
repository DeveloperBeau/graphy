unit USupportBytes;

interface

procedure FillZero(var Data: array of Integer);
procedure AddAll(K: Integer; var Data: array of Integer);

implementation

procedure FillZero(var Data: array of Integer);
var
  I: Integer;
begin
  for I := Low(Data) to High(Data) do
    Data[I] := 0;
end;

procedure AddAll(K: Integer; var Data: array of Integer);
var
  I: Integer;
begin
  for I := Low(Data) to High(Data) do
    Data[I] := (Data[I] + K) mod 256;
end;

end.
