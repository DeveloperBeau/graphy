module Core.Store (save, load, append) where

import Core.Config (Config(..))
import Support.Result (TestResult(..))

save :: Config -> [TestResult] -> IO ()
save cfg rs = writeFile (resultsPath cfg) (unlines (map subject rs))

load :: Config -> IO [String]
load cfg = fmap lines (readFile (resultsPath cfg))

append :: Config -> String -> IO ()
append cfg entry = appendFile (resultsPath cfg) (entry ++ "\n")
