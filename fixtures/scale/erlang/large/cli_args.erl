-module(cli_args).
-export([parse_args/1, quick/1]).

parse_args([]) -> {options, none, false};
parse_args([First | Rest]) ->
    {options, First, lists:member("--quick", [First | Rest])}.

quick({options, _Only, Quick}) -> Quick.
