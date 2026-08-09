-module(core_progress).
-export([render/2, tick/1]).
-import(support_format, [bar/1, pad_left/2]).

render(Done, Total) ->
    bar(Done * 20 div erlang:max(1, Total)) ++ pad_left(6, integer_to_list(Done)).

tick(N) -> N + 1.
