-module(support_timer).
-export([measure/2, millis/1]).

measure(Start, End) -> End - Start.

millis(Span) -> Span / 1000.
