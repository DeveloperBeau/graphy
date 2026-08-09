-module(support_bytes).
-export([zeros/1, add_all/2, rotate/2]).

zeros(N) -> lists:duplicate(N, 0).

add_all(K, Bytes) -> [(B + K) rem 256 || B <- Bytes].

rotate(N, Bytes) ->
    {Head, Tail} = lists:split(N rem erlang:max(1, length(Bytes)), Bytes),
    Tail ++ Head.
