-module(core_store).
-export([save/2, load/1, append_entry/2]).
-import(core_config, [results_path/1]).
-import(support_result, [subject/1]).

save(Config, Results) ->
    Lines = [subject(R) ++ "\n" || R <- Results],
    file:write_file(results_path(Config), Lines).

load(Config) ->
    case file:read_file(results_path(Config)) of
        {ok, Bin} -> string:split(binary_to_list(Bin), "\n", all);
        {error, _} -> []
    end.

append_entry(Config, Entry) ->
    file:write_file(results_path(Config), Entry ++ "\n", [append]).
