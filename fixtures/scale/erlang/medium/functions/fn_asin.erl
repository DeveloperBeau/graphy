-module(fn_asin).
-export([apply/1, arity/0, symbol/0]).

apply([X | _]) -> math:asin(X);
apply([]) -> 0.0.

arity() -> 1.

symbol() -> "asin".
