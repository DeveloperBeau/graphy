module Model.Value (Value(..), toNumber) where

import Model.Number (Number)

data Value = Num Number | Name String

toNumber :: Value -> Number
toNumber (Num n) = n
toNumber (Name _) = 0
