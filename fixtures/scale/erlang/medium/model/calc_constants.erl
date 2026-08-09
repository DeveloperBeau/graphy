-module(calc_constants).
-export([constant/1]).

constant("pi") -> {ok, math:pi()};
constant("e") -> {ok, math:exp(1)};
constant("tau") -> {ok, 2 * math:pi()};
constant(_) -> none.
