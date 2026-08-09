-module(core_session).
-export([begin_session/0, step_session/1, done_count/1]).
-import(core_config, [defaults/0]).
-import(core_progress, [tick/1]).

begin_session() -> {session, 0, defaults()}.

step_session({session, Done, Config}) -> {session, tick(Done), Config}.

done_count({session, Done, _Config}) -> Done.
