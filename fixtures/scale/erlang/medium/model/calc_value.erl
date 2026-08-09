-module(calc_value).
-export([number/1, name/1, to_number/1]).

number(N) -> {num_v, N}.

name(Text) -> {name_v, Text}.

to_number({num_v, N}) -> N;
to_number({name_v, _}) -> 0.0.
