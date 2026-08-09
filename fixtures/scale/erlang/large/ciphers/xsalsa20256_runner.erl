-module(xsalsa20256_runner).
-export([run_case/2, label/0]).
-import(xsalsa20256_impl, [encrypt/2, decrypt/2]).
-import(support_result, [pass/1, fail/1]).

run_case(Key, Plain) ->
    case decrypt(Key, encrypt(Key, Plain)) =:= Plain of
        true -> pass(xsalsa20256_model:name());
        false -> fail(xsalsa20256_model:name())
    end.

label() ->
    xsalsa20256_model:name() ++ "/" ++ integer_to_list(xsalsa20256_model:key_bits()).
