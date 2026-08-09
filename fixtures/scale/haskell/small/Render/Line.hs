module Render.Line (rule, framed) where

import Render.Pad (padTo)
import Style.Border (Border, horizontal, vertical)

rule :: Border -> Int -> String
rule b w = replicate w (horizontal b)

framed :: Border -> Int -> String -> String
framed b w s = [vertical b] ++ padTo w s ++ [vertical b]
