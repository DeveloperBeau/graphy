module Style.Border (Border(..), horizontal, vertical) where

data Border = Ascii | Rounded | Heavy

horizontal :: Border -> Char
horizontal Heavy = '='
horizontal _ = '-'

vertical :: Border -> Char
vertical _ = '|'
