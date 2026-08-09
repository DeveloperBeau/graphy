-module(core_errors).
-export([describe/1]).

describe({missing_cipher, Name}) -> "missing cipher " ++ Name;
describe({bad_vector, Name}) -> "bad vector for " ++ Name.
