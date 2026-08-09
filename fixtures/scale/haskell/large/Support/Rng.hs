module Support.Rng (Seed, next, stream) where

type Seed = Int

next :: Seed -> (Int, Seed)
next s = let s' = mod (s * 1103515245 + 12345) 2147483647 in (mod s' 256, s')

stream :: Int -> Seed -> [Int]
stream 0 _ = []
stream n s = let (b, s') = next s in b : stream (n - 1) s'
