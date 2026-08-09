module Support.Base64 (encode) where

import Support.Bytes (Bytes)

alphabet :: String
alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

encode :: Bytes -> String
encode = map (\b -> alphabet !! mod b 64)
