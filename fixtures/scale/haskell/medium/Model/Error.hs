module Model.Error (CalcError(..), message) where

data CalcError = UnknownSym String | ArityErr String Int

message :: CalcError -> String
message (UnknownSym n) = "unknown symbol " ++ n
message (ArityErr n k) = n ++ " expects " ++ show k ++ " args"
