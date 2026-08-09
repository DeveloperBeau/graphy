-module(speck64_impl).
-export([encrypt/2, decrypt/2]).
-import(speck64_model, [key_bits/0, rounds/0]).

encrypt(Key, Bytes) ->
    [(B + Key + rounds() + key_bits()) rem 256 || B <- Bytes].

decrypt(Key, Bytes) ->
    [(B - Key - rounds() - key_bits() + 512) rem 256 || B <- Bytes].
