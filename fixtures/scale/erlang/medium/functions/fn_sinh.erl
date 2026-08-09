-module(fn_sinh).
-export([apply/1, arity/0, symbol/0]).

apply([X | _]) -> math:sinh(X);
apply([]) -> 0.0.

arity() -> 1.

symbol() -> "sinh".
