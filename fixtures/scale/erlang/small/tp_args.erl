-module(tp_args).
-export([parse/1, width/1, heading/1]).

parse([]) -> {options, 32, "report"};
parse([W | Rest]) ->
    {options, to_width(W), lists:flatten(lists:join(" ", Rest))}.

width({options, Width, _Heading}) -> Width.

heading({options, _Width, Heading}) -> Heading.

to_width(Text) ->
    case string:to_integer(Text) of
        {error, _} -> 32;
        {N, _} -> N
    end.
