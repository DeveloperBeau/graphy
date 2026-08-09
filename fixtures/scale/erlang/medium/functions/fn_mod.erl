-module(fn_mod).
-export([apply/1, arity/0, symbol/0]).

apply([X, Y | _]) -> erlang:float(erlang:trunc(X) rem erlang:max(1, erlang:trunc(Y)));
apply(_) -> 0.0.

arity() -> 2.

symbol() -> "mod".
