-module(idea128_runner).
-export([run_case/2, label/0]).
-import(idea128_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(idea128_model:name());
        false -> fail(idea128_model:name())
    end.

label() ->
    idea128_model:name() ++ "/" ++ integer_to_list(idea128_model:key_bits()).
