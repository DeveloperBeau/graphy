-module(fn_max).
-export([apply/1, arity/0, symbol/0]).

apply([X, Y | _]) -> erlang:max(X, Y);
apply(_) -> 0.0.

arity() -> 2.

symbol() -> "max".
