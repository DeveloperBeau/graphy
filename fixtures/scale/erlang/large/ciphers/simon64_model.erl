-module(simon64_model).
-export([key_bits/0, block_bits/0, name/0, rounds/0]).

key_bits() -> 64.

block_bits() -> 64.

name() -> "simon-64".

rounds() -> 8.
