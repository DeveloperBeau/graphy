module Core.Progress (render, tick) where

import Support.Format (bar, padLeft)

render :: Int -> Int -> String
render done total = bar (div (done * 20) (max 1 total)) ++ padLeft 6 (show done)

tick :: Int -> Int
tick n = n + 1
