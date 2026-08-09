-module(lea192_runner).
-export([run_case/2, label/0]).
-import(lea192_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(lea192_model:name());
        false -> fail(lea192_model:name())
    end.

label() ->
    lea192_model:name() ++ "/" ++ integer_to_list(lea192_model:key_bits()).
