module Model.Number (Number, fromInt, isZero) where

type Number = Double

fromInt :: Int -> Number
fromInt = fromIntegral

isZero :: Number -> Bool
isZero x = abs x < 1e-9
