unit USupportTimer;

interface

function MeasureSpan(StartTick, EndTick: LongInt): LongInt;
function SpanMillis(Span: LongInt): Double;

implementation

function MeasureSpan(StartTick, EndTick: LongInt): LongInt;
begin
  MeasureSpan := EndTick - StartTick;
end;

function SpanMillis(Span: LongInt): Double;
begin
  SpanMillis := Span / 1000.0;
end;

end.
