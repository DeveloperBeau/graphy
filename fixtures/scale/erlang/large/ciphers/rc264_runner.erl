-module(rc264_runner).
-export([run_case/2, label/0]).
-import(rc264_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(rc264_model:name());
        false -> fail(rc264_model:name())
    end.

label() ->
    rc264_model:name() ++ "/" ++ integer_to_list(rc264_model:key_bits()).
