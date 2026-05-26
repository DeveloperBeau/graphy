module Helpers where

-- feature: import, function, top-level definitions

import Data.Char (toUpper)
import qualified Data.Map as M
import Data.List (intercalate)

formatName :: String -> String
formatName name = "hi, " ++ name

unrelatedHelper :: Int -> Int
unrelatedHelper x = x + 1

capitalize :: String -> String
capitalize [] = []
capitalize (c:cs) = toUpper c : cs

buildMap :: [(String, Int)] -> M.Map String Int
buildMap = M.fromList
