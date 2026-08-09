module Ciphers.Xsalsa20256.Runner (runCase, label) where

import Ciphers.Xsalsa20256.Impl (decrypt, encrypt)
import Ciphers.Xsalsa20256.Model (keyBits, name)
import Support.Result (TestResult, fail, pass)

runCase :: Int -> [Int] -> TestResult
runCase key pt =
  if decrypt key (encrypt key pt) == pt then pass name else fail name

label :: String
label = name ++ "/" ++ show keyBits
