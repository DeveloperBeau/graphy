module Support.Hex (encode, decode) where

import Support.Bytes (Bytes)

digits :: String
digits = "0123456789abcdef"

encode :: Bytes -> String
encode = concatMap byte
  where byte b = [digits !! div b 16, digits !! mod b 16]

decode :: String -> Bytes
decode (h : l : rest) = (val h * 16 + val l) : decode rest
  where val c = length (takeWhile (/= c) digits)
decode _ = []
