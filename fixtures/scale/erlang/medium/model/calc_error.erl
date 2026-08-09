-module(calc_error).
-export([message/1]).

message({unknown, Name}) -> "unknown symbol " ++ Name;
message({arity, Name, K}) -> Name ++ " expects " ++ integer_to_list(K) ++ " args".
