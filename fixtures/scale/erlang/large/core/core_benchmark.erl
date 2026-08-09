-module(core_benchmark).
-export([run/4, elapsed/1]).
-import(support_timer, [measure/2]).
-import(support_result, [ok/1]).

run(Name, Start, End, Results) ->
    {bench, Name, measure(Start, End), length([R || R <- Results, ok(R)])}.

elapsed({bench, _Name, Span, _Green}) -> Span.
