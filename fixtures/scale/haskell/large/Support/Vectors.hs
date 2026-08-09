module Support.Vectors (Vector(..), sample) where

import Support.Bytes (Bytes)
import Support.Rng (stream)

data Vector = Vector { key :: Int, plaintext :: Bytes }

sample :: Int -> Int -> Vector
sample keyv n = Vector keyv (stream n (keyv + 7))
