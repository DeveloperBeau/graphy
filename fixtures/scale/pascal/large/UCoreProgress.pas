unit UCoreProgress;

interface

uses USupportFormat;

procedure ShowProgress(Done, Total: Integer);

implementation

procedure ShowProgress(Done, Total: Integer);
var
  Width: Integer;
begin
  if Total < 1 then
    Total := 1;
  Width := Done * 20 div Total;
  WriteLn(BarText(Width), ' ', Done, '/', Total);
end;

end.
