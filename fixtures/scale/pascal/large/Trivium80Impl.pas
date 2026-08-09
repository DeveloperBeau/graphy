unit Trivium80Impl;

interface

uses Trivium80Model;

procedure Encrypt(Key: Integer; var Data: array of Integer);
procedure Decrypt(Key: Integer; var Data: array of Integer);

implementation

procedure Encrypt(Key: Integer; var Data: array of Integer);
var
  I: Integer;
begin
  for I := Low(Data) to High(Data) do
    Data[I] := (Data[I] + Key + Rounds + KeyBits) mod 256;
end;

procedure Decrypt(Key: Integer; var Data: array of Integer);
var
  I: Integer;
begin
  for I := Low(Data) to High(Data) do
    Data[I] := (Data[I] - Key - Rounds - KeyBits + 512) mod 256;
end;

end.
