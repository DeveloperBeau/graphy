-module(fn_tanh).
-export([apply/1, arity/0, symbol/0]).

apply([X | _]) -> math:tanh(X);
apply([]) -> 0.0.

arity() -> 1.

symbol() -> "tanh".
