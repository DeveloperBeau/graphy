-module(blowfish128_runner).
-export([run_case/2, label/0]).
-import(blowfish128_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(blowfish128_model:name());
        false -> fail(blowfish128_model:name())
    end.

label() ->
    blowfish128_model:name() ++ "/" ++ integer_to_list(blowfish128_model:key_bits()).
