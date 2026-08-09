-module(fn_sign).
-export([apply/1, arity/0, symbol/0]).

apply([X | _]) -> case X < 0 of true -> -1.0; false -> 1.0 end;
apply([]) -> 0.0.

arity() -> 1.

symbol() -> "sign".
