-module(calc_env).
-export([empty/0, bind/3, lookup_var/2]).
-import(calc_constants, [constant/1]).

empty() -> [].

bind(K, V, Env) -> [{K, V} | Env].

lookup_var(Env, K) ->
    case lists:keyfind(K, 1, Env) of
        {K, V} -> V;
        false ->
            case constant(K) of
                {ok, V} -> V;
                none -> 0.0
            end
    end.
