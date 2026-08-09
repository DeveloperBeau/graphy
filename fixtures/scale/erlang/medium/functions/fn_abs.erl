-module(fn_abs).
-export([apply/1, arity/0, symbol/0]).

apply([X | _]) -> erlang:abs(X);
apply([]) -> 0.0.

arity() -> 1.

symbol() -> "abs".
