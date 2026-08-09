-module(calc_output).
-export([format_number/1, format_entry/1]).

format_number(N) -> float_to_list(N * 1.0, [{decimals, 3}, compact]).

format_entry({entry, Src, Val}) -> Src ++ " = " ++ format_number(Val).
