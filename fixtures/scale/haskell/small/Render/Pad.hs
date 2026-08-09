module Render.Pad (padTo, blank) where

padTo :: Int -> String -> String
padTo w s = take w (s ++ repeat ' ')

blank :: Int -> String
blank w = replicate w ' '
