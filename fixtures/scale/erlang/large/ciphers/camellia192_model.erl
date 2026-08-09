-module(camellia192_model).
-export([key_bits/0, block_bits/0, name/0, rounds/0]).

key_bits() -> 192.

block_bits() -> 128.

name() -> "camellia-192".

rounds() -> 16.
