-module(calc_number).
-export([from_int/1, is_zero/1, near/2]).

from_int(N) -> N * 1.0.

is_zero(X) -> erlang:abs(X) < 1.0e-9.

near(A, B) -> erlang:abs(A - B) < 1.0e-6.
