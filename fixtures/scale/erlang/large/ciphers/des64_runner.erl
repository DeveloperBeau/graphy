-module(des64_runner).
-export([run_case/2, label/0]).
-import(des64_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(des64_model:name());
        false -> fail(des64_model:name())
    end.

label() ->
    des64_model:name() ++ "/" ++ integer_to_list(des64_model:key_bits()).
