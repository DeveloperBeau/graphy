-module(rc6128_impl).
-export([encrypt/2, decrypt/2]).
-import(rc6128_model, [key_bits/0, rounds/0]).

encrypt(Key, Bytes) ->
    [(B + Key + rounds() + key_bits()) rem 256 || B <- Bytes].

decrypt(Key, Bytes) ->
    [(B - Key - rounds() - key_bits() + 512) rem 256 || B <- Bytes].
