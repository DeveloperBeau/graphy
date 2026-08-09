unit UCoreBenchmark;

interface

uses USupportTimer;

type
  TBench = record
    BenchName: string;
    Elapsed: LongInt;
    GreenCount: Integer;
  end;

function RunBench(const Name: string; StartTick, EndTick: LongInt; PassCount: Integer): TBench;

implementation

function RunBench(const Name: string; StartTick, EndTick: LongInt; PassCount: Integer): TBench;
var
  B: TBench;
begin
  B.BenchName := Name;
  B.Elapsed := MeasureSpan(StartTick, EndTick);
  B.GreenCount := PassCount;
  RunBench := B;
end;

end.
