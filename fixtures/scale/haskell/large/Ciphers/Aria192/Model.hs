module Ciphers.Aria192.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 192

blockBits :: Int
blockBits = 128

name :: String
name = "aria-192"

rounds :: Int
rounds = 16
