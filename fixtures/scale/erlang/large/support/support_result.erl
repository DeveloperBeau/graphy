-module(support_result).
-export([pass/1, fail/1, ok/1, subject/1]).

pass(Name) -> {result, Name, true}.

fail(Name) -> {result, Name, false}.

ok({result, _Name, Passed}) -> Passed.

subject({result, Name, _Passed}) -> Name.
