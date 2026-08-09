-module(clefia128_model).
-export([key_bits/0, block_bits/0, name/0, rounds/0]).

key_bits() -> 128.

block_bits() -> 128.

name() -> "clefia-128".

rounds() -> 12.
