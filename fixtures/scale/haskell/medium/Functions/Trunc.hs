module Functions.Trunc (apply, arity, symbol) where

import Model.Number (Number)

apply :: [Number] -> Number
apply (x : _) = fromIntegral (truncate x :: Int)
apply [] = 0

arity :: Int
arity = 1

symbol :: String
symbol = "trunc"
