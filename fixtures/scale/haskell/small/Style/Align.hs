module Style.Align (Align(..), apply) where

data Align = LeftA | RightA | CenterA

apply :: Align -> Int -> String -> String
apply LeftA w s = s ++ replicate (max 0 (w - length s)) ' '
apply RightA w s = replicate (max 0 (w - length s)) ' ' ++ s
apply CenterA w s = let g = max 0 (w - length s) in replicate (div g 2) ' ' ++ s
