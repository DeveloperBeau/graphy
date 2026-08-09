-module(fn_pow).
-export([apply/1, arity/0, symbol/0]).

apply([X, Y | _]) -> math:pow(X, Y);
apply(_) -> 0.0.

arity() -> 2.

symbol() -> "pow".
