-module(tp_reader).
-export([read_lines/1, clean/1]).

read_lines(Text) ->
    [L || L <- string:split(clean(Text), "~n", all), L =/= ""].

clean(Text) -> [C || C <- Text, C =/= 13].
