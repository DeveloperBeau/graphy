-module(fn_neg).
-export([apply/1, arity/0, symbol/0]).

apply([X | _]) -> -X;
apply([]) -> 0.0.

arity() -> 1.

symbol() -> "neg".
