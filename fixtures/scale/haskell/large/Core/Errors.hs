module Core.Errors (BenchError(..), describe) where

data BenchError = MissingCipher String | BadVector String

describe :: BenchError -> String
describe (MissingCipher n) = "missing cipher " ++ n
describe (BadVector n) = "bad vector for " ++ n
