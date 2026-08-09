module Support.Report (line, summary) where

import Support.Format (padRight)
import Support.Result (TestResult(..))

line :: TestResult -> String
line r = padRight 20 (subject r) ++ if passed r then "PASS" else "FAIL"

summary :: [TestResult] -> String
summary rs = show (length (filter passed rs)) ++ "/" ++ show (length rs) ++ " passed"
