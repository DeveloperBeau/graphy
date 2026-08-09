-module(support_hex).
-export([encode/1, decode/1]).

digit(N) -> lists:nth(N + 1, "0123456789abcdef").

encode(Bytes) ->
    lists:flatten([[digit(B div 16), digit(B rem 16)] || B <- Bytes]).

decode([]) -> [];
decode([H, L | Rest]) -> [value(H) * 16 + value(L) | decode(Rest)];
decode([_]) -> [].

value(C) when C >= $0, C =< $9 -> C - $0;
value(C) when C >= $a, C =< $f -> C - $a + 10.
