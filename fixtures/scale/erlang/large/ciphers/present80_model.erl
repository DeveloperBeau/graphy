-module(present80_model).
-export([key_bits/0, block_bits/0, name/0, rounds/0]).

key_bits() -> 80.

block_bits() -> 64.

name() -> "present-80".

rounds() -> 9.
