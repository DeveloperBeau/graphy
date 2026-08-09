-module(mickey80_runner).
-export([run_case/2, label/0]).
-import(mickey80_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(mickey80_model:name());
        false -> fail(mickey80_model:name())
    end.

label() ->
    mickey80_model:name() ++ "/" ++ integer_to_list(mickey80_model:key_bits()).
