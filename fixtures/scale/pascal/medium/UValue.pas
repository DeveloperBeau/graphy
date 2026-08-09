unit UValue;

interface

type
  TValueKind = (vkNumber, vkName);

  TValue = record
    Kind: TValueKind;
    Num: Double;
    Name: string;
  end;

function NumberValue(X: Double): TValue;
function ToNumber(const V: TValue): Double;

implementation

function NumberValue(X: Double): TValue;
var
  V: TValue;
begin
  V.Kind := vkNumber;
  V.Num := X;
  V.Name := '';
  NumberValue := V;
end;

function ToNumber(const V: TValue): Double;
begin
  if V.Kind = vkNumber then
    ToNumber := V.Num
  else
    ToNumber := 0;
end;

end.
