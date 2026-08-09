module Ciphers.Clefia192.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 192

blockBits :: Int
blockBits = 128

name :: String
name = "clefia-192"

rounds :: Int
rounds = 16
