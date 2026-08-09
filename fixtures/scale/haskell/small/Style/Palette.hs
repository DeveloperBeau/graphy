module Style.Palette (Palette(..), pick) where

data Palette = Plain | Bright

pick :: Palette -> String -> String
pick Plain s = s
pick Bright s = "*" ++ s ++ "*"
