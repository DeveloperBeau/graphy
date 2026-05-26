-module(service).
-export([run/1, make/1]).
-import(helpers, [format_name/1]).

%% feature: module, export, import, function, external call

-define(MAX_RETRIES, 3).

make(Name) ->
    {service, Name}.

run({service, Name}) ->
    Greeting = format_name(Name),
    io:format("~s~n", [Greeting]),
    ?MAX_RETRIES.
