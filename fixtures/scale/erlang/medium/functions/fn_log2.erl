-module(fn_log2).
-export([apply/1, arity/0, symbol/0]).

apply([X | _]) -> math:log2(X);
apply([]) -> 0.0.

arity() -> 1.

symbol() -> "log2".
