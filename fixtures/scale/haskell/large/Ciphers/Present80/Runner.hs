module Ciphers.Present80.Runner (runCase, label) where

import Ciphers.Present80.Impl (decrypt, encrypt)
import Ciphers.Present80.Model (keyBits, name)
import Support.Result (TestResult, fail, pass)

runCase :: Int -> [Int] -> TestResult
runCase key pt =
  if decrypt key (encrypt key pt) == pt then pass name else fail name

label :: String
label = name ++ "/" ++ show keyBits
