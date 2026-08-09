-module(calc_grammar).
-export([is_binary_op/1, is_call_start/1]).

is_binary_op({op, _}) -> true;
is_binary_op(_) -> false.

is_call_start({ident, _}) -> true;
is_call_start(_) -> false.
