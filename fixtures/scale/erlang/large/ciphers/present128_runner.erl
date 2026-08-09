-module(present128_runner).
-export([run_case/2, label/0]).
-import(present128_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(present128_model:name());
        false -> fail(present128_model:name())
    end.

label() ->
    present128_model:name() ++ "/" ++ integer_to_list(present128_model:key_bits()).
