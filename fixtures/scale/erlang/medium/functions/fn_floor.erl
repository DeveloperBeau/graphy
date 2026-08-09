-module(fn_floor).
-export([apply/1, arity/0, symbol/0]).

apply([X | _]) -> erlang:float(erlang:floor(X));
apply([]) -> 0.0.

arity() -> 1.

symbol() -> "floor".
