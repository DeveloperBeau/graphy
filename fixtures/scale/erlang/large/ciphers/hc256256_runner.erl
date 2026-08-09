-module(hc256256_runner).
-export([run_case/2, label/0]).
-import(hc256256_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(hc256256_model:name());
        false -> fail(hc256256_model:name())
    end.

label() ->
    hc256256_model:name() ++ "/" ++ integer_to_list(hc256256_model:key_bits()).
