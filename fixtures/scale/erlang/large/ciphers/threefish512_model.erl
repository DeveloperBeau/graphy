-module(threefish512_model).
-export([key_bits/0, block_bits/0, name/0, rounds/0]).

key_bits() -> 512.

block_bits() -> 256.

name() -> "threefish-512".

rounds() -> 36.
