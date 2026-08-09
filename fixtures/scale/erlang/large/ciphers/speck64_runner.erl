-module(speck64_runner).
-export([run_case/2, label/0]).
-import(speck64_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(speck64_model:name());
        false -> fail(speck64_model:name())
    end.

label() ->
    speck64_model:name() ++ "/" ++ integer_to_list(speck64_model:key_bits()).
