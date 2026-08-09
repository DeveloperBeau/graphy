-module(xsalsa20256_model).
-export([key_bits/0, block_bits/0, name/0, rounds/0]).

key_bits() -> 256.

block_bits() -> 0.

name() -> "xsalsa20-256".

rounds() -> 20.
