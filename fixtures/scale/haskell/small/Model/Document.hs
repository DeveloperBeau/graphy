module Model.Document (Document(..), fromLines, rows) where

import Model.Cell (Cell(..))

data Document = Document { title :: String, cells :: [Cell] }

fromLines :: String -> [String] -> Document
fromLines t ls = Document t (map (\l -> Cell l 2) ls)

rows :: Document -> [String]
rows d = map content (cells d)
