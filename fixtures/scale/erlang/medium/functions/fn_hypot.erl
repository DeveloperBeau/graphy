-module(fn_hypot).
-export([apply/1, arity/0, symbol/0]).

apply([X, Y | _]) -> math:sqrt(X * X + Y * Y);
apply(_) -> 0.0.

arity() -> 2.

symbol() -> "hypot".
