-module(grain128_runner).
-export([run_case/2, label/0]).
-import(grain128_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(grain128_model:name());
        false -> fail(grain128_model:name())
    end.

label() ->
    grain128_model:name() ++ "/" ++ integer_to_list(grain128_model:key_bits()).
