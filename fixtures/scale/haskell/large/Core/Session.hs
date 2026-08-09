module Core.Session (Session(..), begin, step) where

import Core.Config (Config, defaults)
import Core.Progress (tick)

data Session = Session { done :: Int, config :: Config }

begin :: Session
begin = Session 0 defaults

step :: Session -> Session
step s = s { done = tick (done s) }
