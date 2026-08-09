-module(fn_sin).
-export([apply/1, arity/0, symbol/0]).

apply([X | _]) -> math:sin(X);
apply([]) -> 0.0.

arity() -> 1.

symbol() -> "sin".
