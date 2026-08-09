module Ciphers.Present80.Impl (encrypt, decrypt) where

import Ciphers.Present80.Model (keyBits, rounds)

encrypt :: Int -> [Int] -> [Int]
encrypt key = map (\b -> mod (b + key + rounds + keyBits) 256)

decrypt :: Int -> [Int] -> [Int]
decrypt key = map (\b -> mod (b - key - rounds - keyBits + 512) 256)
