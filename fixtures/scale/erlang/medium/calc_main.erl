-module(calc_main).
-export([main/0]).
-import(calc_env, [empty/0]).
-import(calc_repl, [step/3]).
-import(calc_prompt, [banner/0]).

main() ->
    io:format("~s~n", [banner()]),
    {Shown, _Hist} = step(empty(), "sqrt(16) + 2 * 3", []),
    io:format("result = ~s~n", [Shown]),
    io:format("functions: ~p~n", [length(fn_registry:names())]).
