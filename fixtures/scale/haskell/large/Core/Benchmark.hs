module Core.Benchmark (Bench(..), run) where

import Support.Result (TestResult, ok)
import Support.Timer (Span, measure)

data Bench = Bench { benchName :: String, elapsed :: Span, greenCount :: Int }

run :: String -> Int -> Int -> [TestResult] -> Bench
run n start end rs = Bench n (measure start end) (length (filter ok rs))
