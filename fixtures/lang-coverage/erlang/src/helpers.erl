-module(helpers).
-export([format_name/1, unrelated_helper/0]).

%% feature: module, export, function clauses

format_name(Name) ->
    "hi, " ++ Name.

unrelated_helper() ->
    7.
