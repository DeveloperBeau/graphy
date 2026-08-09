-module(support_base64).
-export([encode64/1]).

alphabet() -> "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".

encode64(Bytes) -> [lists:nth((B rem 64) + 1, alphabet()) || B <- Bytes].
