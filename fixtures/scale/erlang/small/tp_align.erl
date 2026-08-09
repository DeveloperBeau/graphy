-module(tp_align).
-export([align/3]).

align(left, Width, Text) -> Text ++ spaces(Width - length(Text));
align(right, Width, Text) -> spaces(Width - length(Text)) ++ Text;
align(center, Width, Text) ->
    Gap = erlang:max(0, Width - length(Text)),
    spaces(Gap div 2) ++ Text ++ spaces(Gap - Gap div 2).

spaces(N) when N =< 0 -> "";
spaces(N) -> lists:duplicate(N, 32).
