-module(calc_memory).
-export([blank/0, remember/3, recall/2]).
-import(calc_env, [empty/0, bind/3, lookup_var/2]).

blank() -> empty().

remember(K, V, Store) -> bind(K, V, Store).

recall(Store, K) -> lookup_var(Store, K).
