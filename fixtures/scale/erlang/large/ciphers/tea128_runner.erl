-module(tea128_runner).
-export([run_case/2, label/0]).
-import(tea128_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(tea128_model:name());
        false -> fail(tea128_model:name())
    end.

label() ->
    tea128_model:name() ++ "/" ++ integer_to_list(tea128_model:key_bits()).
