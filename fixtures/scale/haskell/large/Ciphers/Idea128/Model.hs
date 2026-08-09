module Ciphers.Idea128.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 128

blockBits :: Int
blockBits = 64

name :: String
name = "idea-128"

rounds :: Int
rounds = 12
