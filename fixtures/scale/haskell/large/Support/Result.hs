module Support.Result (TestResult(..), pass, fail, ok) where

data TestResult = TestResult { subject :: String, passed :: Bool }

pass :: String -> TestResult
pass n = TestResult n True

fail :: String -> TestResult
fail n = TestResult n False

ok :: TestResult -> Bool
ok = passed
