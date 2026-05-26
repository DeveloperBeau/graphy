module Service where

-- feature: module, import (plain, qualified, selective), function, call

import Types
import Helpers (formatName, unrelatedHelper)
import qualified Data.Map as M
import Data.Maybe (fromMaybe)

maxRetries :: Int
maxRetries = 3

runService :: Service -> IO ()
runService svc = do
  let msg = formatName (serviceName svc)
  putStrLn msg
  let _ = unrelatedHelper maxRetries
  return ()

makeService :: Id -> Name -> Service
makeService i n = Service { serviceId = i, serviceName = n }

lookupState :: M.Map String State -> String -> State
lookupState m k = fromMaybe Idle (M.lookup k m)
