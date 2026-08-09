module Ciphers.Aria192.Runner (runCase, label) where

import Ciphers.Aria192.Impl (decrypt, encrypt)
import Ciphers.Aria192.Model (keyBits, name)
import Support.Result (TestResult, fail, pass)

runCase :: Int -> [Int] -> TestResult
runCase key pt =
  if decrypt key (encrypt key pt) == pt then pass name else fail name

label :: String
label = name ++ "/" ++ show keyBits
