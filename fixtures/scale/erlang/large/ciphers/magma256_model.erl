-module(magma256_model).
-export([key_bits/0, block_bits/0, name/0, rounds/0]).

key_bits() -> 256.

block_bits() -> 64.

name() -> "magma-256".

rounds() -> 20.
