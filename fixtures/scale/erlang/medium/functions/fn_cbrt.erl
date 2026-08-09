-module(fn_cbrt).
-export([apply/1, arity/0, symbol/0]).

apply([X | _]) -> math:pow(X, 1.0 / 3.0);
apply([]) -> 0.0.

arity() -> 1.

symbol() -> "cbrt".
