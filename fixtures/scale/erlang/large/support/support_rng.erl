-module(support_rng).
-export([next/1, stream/2]).

next(Seed) ->
    S = (Seed * 1103515245 + 12345) rem 2147483647,
    {S rem 256, S}.

stream(0, _Seed) -> [];
stream(N, Seed) ->
    {B, S} = next(Seed),
    [B | stream(N - 1, S)].
