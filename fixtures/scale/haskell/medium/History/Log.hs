module History.Log (Entry(..), record, recent) where

import Model.Number (Number)

data Entry = Entry { source :: String, outcome :: Number }

record :: String -> Number -> [Entry] -> [Entry]
record src val es = Entry src val : es

recent :: Int -> [Entry] -> [Entry]
recent = take
