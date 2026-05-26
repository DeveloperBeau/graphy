-module(types).
-export([make_state/0, idle/0]).

%% feature: module attribute, export, record

-record(state, {name :: string(), status = idle}).

make_state() ->
    #state{name = "default"}.

idle() ->
    idle.
