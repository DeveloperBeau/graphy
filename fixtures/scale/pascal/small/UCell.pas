unit UCell;

interface

type
  TCell = record
    Content: string;
    Pad: Integer;
  end;

function MakeCell(const S: string; Pad: Integer): TCell;
function CellWidth(const C: TCell): Integer;

implementation

function MakeCell(const S: string; Pad: Integer): TCell;
var
  C: TCell;
begin
  C.Content := S;
  C.Pad := Pad;
  MakeCell := C;
end;

function CellWidth(const C: TCell): Integer;
begin
  CellWidth := Length(C.Content) + C.Pad;
end;

end.
