unit UDocument;

interface

uses UCell;

const
  MaxCells = 32;

type
  TDocument = record
    Title: string;
    Cells: array[1..MaxCells] of TCell;
    Count: Integer;
  end;

procedure InitDocument(var D: TDocument; const Title: string);
procedure AddLine(var D: TDocument; const S: string);

implementation

procedure InitDocument(var D: TDocument; const Title: string);
begin
  D.Title := Title;
  D.Count := 0;
end;

procedure AddLine(var D: TDocument; const S: string);
begin
  if D.Count < MaxCells then
  begin
    D.Count := D.Count + 1;
    D.Cells[D.Count] := MakeCell(S, 2);
  end;
end;

end.
