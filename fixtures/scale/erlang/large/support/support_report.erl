-module(support_report).
-export([line/1, summary/1]).
-import(support_format, [pad_right/2]).
-import(support_result, [ok/1, subject/1]).

line(R) ->
    Status = case ok(R) of true -> "PASS"; false -> "FAIL" end,
    pad_right(20, subject(R)) ++ Status.

summary(Results) ->
    Green = length([R || R <- Results, ok(R)]),
    integer_to_list(Green) ++ "/" ++ integer_to_list(length(Results)) ++ " passed".
