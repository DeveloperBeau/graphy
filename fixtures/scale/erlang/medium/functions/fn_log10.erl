-module(fn_log10).
-export([apply/1, arity/0, symbol/0]).

apply([X | _]) -> math:log10(X);
apply([]) -> 0.0.

arity() -> 1.

symbol() -> "log10".
