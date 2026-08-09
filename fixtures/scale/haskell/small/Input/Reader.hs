module Input.Reader (readLines, clean) where

readLines :: String -> [String]
readLines = filter (not . null) . lines

clean :: String -> String
clean = filter (/= '\r')
