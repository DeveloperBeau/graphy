-module(core_registry).
-export([catalog/0, size_of/0]).
-import(aes128_runner, [label/0]).

catalog() ->
    [label(), chacha20256_runner:label(), salsa20256_runner:label(),
     blowfish256_runner:label()].

size_of() -> length(catalog()).
