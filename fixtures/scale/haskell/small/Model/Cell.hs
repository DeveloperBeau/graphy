module Model.Cell (Cell(..), text, width) where

data Cell = Cell { content :: String, pad :: Int }

text :: Cell -> String
text = content

width :: Cell -> Int
width c = length (content c) + pad c
