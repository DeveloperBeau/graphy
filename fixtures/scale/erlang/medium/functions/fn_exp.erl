-module(fn_exp).
-export([apply/1, arity/0, symbol/0]).

apply([X | _]) -> math:exp(X);
apply([]) -> 0.0.

arity() -> 1.

symbol() -> "exp".
