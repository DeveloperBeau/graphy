unit UHistory;

interface

const
  MaxEntries = 50;

type
  THistory = record
    Sources: array[1..MaxEntries] of string;
    Results: array[1..MaxEntries] of Double;
    Count: Integer;
  end;

procedure RecordEntry(var H: THistory; const Src: string; Value: Double);
function RecentCount(const H: THistory; N: Integer): Integer;

implementation

procedure RecordEntry(var H: THistory; const Src: string; Value: Double);
begin
  if H.Count < MaxEntries then
  begin
    H.Count := H.Count + 1;
    H.Sources[H.Count] := Src;
    H.Results[H.Count] := Value;
  end;
end;

function RecentCount(const H: THistory; N: Integer): Integer;
begin
  if H.Count < N then
    RecentCount := H.Count
  else
    RecentCount := N;
end;

end.
