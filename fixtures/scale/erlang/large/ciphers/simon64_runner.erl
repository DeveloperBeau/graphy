-module(simon64_runner).
-export([run_case/2, label/0]).
-import(simon64_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(simon64_model:name());
        false -> fail(simon64_model:name())
    end.

label() ->
    simon64_model:name() ++ "/" ++ integer_to_list(simon64_model:key_bits()).
