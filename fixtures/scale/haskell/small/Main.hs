module Main (main) where

import Input.Args (Options(..), parse)
import Input.Reader (readLines)
import Model.Document (fromLines)
import Output.Writer (emit, render)
import Style.Palette (Palette(..))
import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  let opts = parse args
      body = readLines "alpha\nbeta\ngamma"
      doc = fromLines (heading opts) body
  emit (render Bright (boxWidth opts) doc)
