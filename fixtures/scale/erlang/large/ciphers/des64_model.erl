-module(des64_model).
-export([key_bits/0, block_bits/0, name/0, rounds/0]).

key_bits() -> 64.

block_bits() -> 64.

name() -> "des-64".

rounds() -> 8.
