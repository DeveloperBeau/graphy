unit UPrecedence;

interface

function OpLevel(Op: Char): Integer;

implementation

function OpLevel(Op: Char): Integer;
begin
  case Op of
    '+', '-': OpLevel := 1;
    '*', '/': OpLevel := 2;
    '^': OpLevel := 3;
  else
    OpLevel := 0;
  end;
end;

end.
