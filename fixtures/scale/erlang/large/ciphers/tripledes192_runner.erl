-module(tripledes192_runner).
-export([run_case/2, label/0]).
-import(tripledes192_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(tripledes192_model:name());
        false -> fail(tripledes192_model:name())
    end.

label() ->
    tripledes192_model:name() ++ "/" ++ integer_to_list(tripledes192_model:key_bits()).
