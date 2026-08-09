module Io.Output (formatNumber, formatEntry) where

import History.Log (Entry(..))
import Model.Number (Number)

formatNumber :: Number -> String
formatNumber n = show (fromIntegral (round (n * 1000) :: Int) / 1000 :: Double)

formatEntry :: Entry -> String
formatEntry e = source e ++ " = " ++ formatNumber (outcome e)
