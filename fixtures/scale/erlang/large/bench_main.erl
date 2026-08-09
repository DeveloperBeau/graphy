-module(bench_main).
-export([main/1]).
-import(cli_args, [parse_args/1]).
-import(core_config, [defaults/0]).
-import(core_registry, [catalog/0]).
-import(core_store, [save/2]).
-import(support_report, [summary/1]).
-import(support_result, [pass/1]).

main(Args) ->
    _Opts = parse_args(Args),
    Results = [pass("warmup")],
    Bench = core_benchmark:run("aes-128", 0, 10, Results),
    io:format("~s~n", [core_progress:render(1, length(catalog()))]),
    io:format("~p ciphers registered~n", [length(catalog())]),
    io:format("~s~n", [summary(Results)]),
    save(defaults(), Results),
    Bench.
