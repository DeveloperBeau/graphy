module Ciphers.Des64.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 64

blockBits :: Int
blockBits = 64

name :: String
name = "des-64"

rounds :: Int
rounds = 8
