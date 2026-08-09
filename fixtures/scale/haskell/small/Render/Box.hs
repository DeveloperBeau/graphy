module Render.Box (draw) where

import Model.Document (Document, rows, title)
import Render.Line (framed, rule)
import Style.Align (Align(..), apply)
import Style.Border (Border)

draw :: Border -> Int -> Document -> [String]
draw b w doc =
  [rule b w, framed b w (apply CenterA w (title doc)), rule b w]
    ++ map (framed b w . apply LeftA w) (rows doc)
    ++ [rule b w]
