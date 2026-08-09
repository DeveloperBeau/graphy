unit UCharClass;

interface

function IsDigitCh(C: Char): Boolean;
function IsAlphaCh(C: Char): Boolean;
function IsSpaceCh(C: Char): Boolean;

implementation

function IsDigitCh(C: Char): Boolean;
begin
  IsDigitCh := (C >= '0') and (C <= '9');
end;

function IsAlphaCh(C: Char): Boolean;
begin
  IsAlphaCh := ((C >= 'a') and (C <= 'z')) or ((C >= 'A') and (C <= 'Z'));
end;

function IsSpaceCh(C: Char): Boolean;
begin
  IsSpaceCh := (C = ' ') or (C = #9);
end;

end.
