-module(support_format).
-export([pad_right/2, pad_left/2, bar/1]).

pad_right(W, S) -> S ++ lists:duplicate(erlang:max(0, W - length(S)), 32).

pad_left(W, S) -> lists:duplicate(erlang:max(0, W - length(S)), 32) ++ S.

bar(N) -> lists:duplicate(N, $#).
