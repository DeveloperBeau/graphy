-module(fn_cos).
-export([apply/1, arity/0, symbol/0]).

apply([X | _]) -> math:cos(X);
apply([]) -> 0.0.

arity() -> 1.

symbol() -> "cos".
