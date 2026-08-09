module Support.Timer (Span, measure, millis) where

type Span = Int

measure :: Int -> Int -> Span
measure start end = end - start

millis :: Span -> Double
millis s = fromIntegral s / 1000.0
