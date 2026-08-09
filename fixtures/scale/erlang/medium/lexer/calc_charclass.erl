-module(calc_charclass).
-export([is_digit/1, is_alpha/1, is_space/1]).

is_digit(C) -> C >= $0 andalso C =< $9.

is_alpha(C) -> (C >= $a andalso C =< $z) orelse (C >= $A andalso C =< $Z).

is_space(C) -> C =:= 32 orelse C =:= 9.
