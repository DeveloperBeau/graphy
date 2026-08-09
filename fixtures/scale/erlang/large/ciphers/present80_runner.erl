-module(present80_runner).
-export([run_case/2, label/0]).
-import(present80_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(present80_model:name());
        false -> fail(present80_model:name())
    end.

label() ->
    present80_model:name() ++ "/" ++ integer_to_list(present80_model:key_bits()).
