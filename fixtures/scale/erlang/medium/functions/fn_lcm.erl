-module(fn_lcm).
-export([apply/1, arity/0, symbol/0]).

apply([X, Y | _]) -> erlang:float(lcm_i(erlang:round(X), erlang:round(Y)));
apply(_) -> 0.0.

arity() -> 2.

symbol() -> "lcm".

gcd_i(A, 0) -> A;
gcd_i(A, B) -> gcd_i(B, A rem B).

lcm_i(A, B) ->
    erlang:abs(A * B) div erlang:max(1, gcd_i(erlang:abs(A), erlang:abs(B))).
