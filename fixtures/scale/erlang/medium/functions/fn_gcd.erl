-module(fn_gcd).
-export([apply/1, arity/0, symbol/0]).

apply([X, Y | _]) -> erlang:float(gcd_i(erlang:abs(erlang:round(X)), erlang:abs(erlang:round(Y))));
apply(_) -> 0.0.

arity() -> 2.

symbol() -> "gcd".

gcd_i(A, 0) -> A;
gcd_i(A, B) -> gcd_i(B, A rem B).
