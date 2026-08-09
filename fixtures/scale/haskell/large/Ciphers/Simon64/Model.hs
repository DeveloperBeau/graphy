module Ciphers.Simon64.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 64

blockBits :: Int
blockBits = 64

name :: String
name = "simon-64"

rounds :: Int
rounds = 8
