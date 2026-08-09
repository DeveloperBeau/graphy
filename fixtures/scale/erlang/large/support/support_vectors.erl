-module(support_vectors).
-export([sample/2, plaintext/1, key_of/1]).
-import(support_rng, [stream/2]).

sample(Key, N) -> {vector, Key, stream(N, Key + 7)}.

plaintext({vector, _Key, Bytes}) -> Bytes.

key_of({vector, Key, _Bytes}) -> Key.
