unit UConstants;

interface

function LookupConstant(const Name: string; var Value: Double): Boolean;

implementation

function LookupConstant(const Name: string; var Value: Double): Boolean;
begin
  LookupConstant := True;
  if Name = 'pi' then
    Value := Pi
  else if Name = 'e' then
    Value := Exp(1)
  else if Name = 'tau' then
    Value := 2 * Pi
  else
    LookupConstant := False;
end;

end.
