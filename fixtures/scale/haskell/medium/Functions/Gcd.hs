module Functions.Gcd (apply, arity, symbol) where

import Model.Number (Number)

apply :: [Number] -> Number
apply (x : y : _) = fromIntegral (gcd (round x :: Int) (round y))
apply _ = 0

arity :: Int
arity = 2

symbol :: String
symbol = "gcd"
