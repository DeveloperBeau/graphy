module Support.Bytes (Bytes, zeros, addAll, rotate) where

type Bytes = [Int]

zeros :: Int -> Bytes
zeros n = replicate n 0

addAll :: Int -> Bytes -> Bytes
addAll k = map (\b -> mod (b + k) 256)

rotate :: Int -> Bytes -> Bytes
rotate n xs = drop n xs ++ take n xs
