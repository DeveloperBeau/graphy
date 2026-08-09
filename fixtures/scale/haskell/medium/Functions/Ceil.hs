module Functions.Ceil (apply, arity, symbol) where

import Model.Number (Number)

apply :: [Number] -> Number
apply (x : _) = fromIntegral (ceiling x :: Int)
apply [] = 0

arity :: Int
arity = 1

symbol :: String
symbol = "ceil"
