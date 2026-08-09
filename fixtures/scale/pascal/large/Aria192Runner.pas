unit Aria192Runner;

interface

uses Aria192Impl, Aria192Model, USupportResult;

function RunCase(Key: Integer): TTestResult;
function CaseLabel: string;

implementation

function RunCase(Key: Integer): TTestResult;
var
  Data: array[0..7] of Integer;
  I: Integer;
  Ok: Boolean;
begin
  for I := 0 to 7 do
    Data[I] := I * 17 mod 256;
  Encrypt(Key, Data);
  Decrypt(Key, Data);
  Ok := True;
  for I := 0 to 7 do
    if Data[I] <> I * 17 mod 256 then
      Ok := False;
  RunCase := MakeResult(CipherName, Ok);
end;

function CaseLabel: string;
begin
  CaseLabel := CipherName;
end;

end.
