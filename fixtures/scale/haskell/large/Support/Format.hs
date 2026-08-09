module Support.Format (padRight, padLeft, bar) where

padRight :: Int -> String -> String
padRight w s = s ++ replicate (max 0 (w - length s)) ' '

padLeft :: Int -> String -> String
padLeft w s = replicate (max 0 (w - length s)) ' ' ++ s

bar :: Int -> String
bar n = replicate n '#'
