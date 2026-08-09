-module(camellia128_runner).
-export([run_case/2, label/0]).
-import(camellia128_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(camellia128_model:name());
        false -> fail(camellia128_model:name())
    end.

label() ->
    camellia128_model:name() ++ "/" ++ integer_to_list(camellia128_model:key_bits()).
