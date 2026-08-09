module Parser.Precedence (level) where

level :: Char -> Int
level '+' = 1
level '-' = 1
level '*' = 2
level '/' = 2
level '^' = 3
level _ = 0
