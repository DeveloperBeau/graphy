-module(misty1128_runner).
-export([run_case/2, label/0]).
-import(misty1128_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(misty1128_model:name());
        false -> fail(misty1128_model:name())
    end.

label() ->
    misty1128_model:name() ++ "/" ++ integer_to_list(misty1128_model:key_bits()).
