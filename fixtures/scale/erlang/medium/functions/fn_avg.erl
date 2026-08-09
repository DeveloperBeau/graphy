-module(fn_avg).
-export([apply/1, arity/0, symbol/0]).

apply([X, Y | _]) -> (X + Y) / 2;
apply(_) -> 0.0.

arity() -> 2.

symbol() -> "avg".
