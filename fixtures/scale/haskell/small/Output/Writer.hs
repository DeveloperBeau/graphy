module Output.Writer (render, emit) where

import Model.Document (Document)
import Render.Box (draw)
import Style.Border (Border(..))
import Style.Palette (Palette, pick)

render :: Palette -> Int -> Document -> [String]
render pal w doc = map (pick pal) (draw Rounded w doc)

emit :: [String] -> IO ()
emit = mapM_ putStrLn
