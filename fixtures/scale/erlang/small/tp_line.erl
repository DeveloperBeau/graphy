-module(tp_line).
-export([rule/2, framed/3]).
-import(tp_pad, [pad_to/2]).
-import(tp_border, [horizontal/1, vertical/1]).

rule(Style, Width) -> lists:duplicate(Width, horizontal(Style)).

framed(Style, Width, Text) ->
    [vertical(Style)] ++ pad_to(Width, Text) ++ [vertical(Style)].
