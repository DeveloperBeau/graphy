-module(fn_atan).
-export([apply/1, arity/0, symbol/0]).

apply([X | _]) -> math:atan(X);
apply([]) -> 0.0.

arity() -> 1.

symbol() -> "atan".
