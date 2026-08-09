module Ciphers.Xsalsa20256.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 256

blockBits :: Int
blockBits = 0

name :: String
name = "xsalsa20-256"

rounds :: Int
rounds = 20
