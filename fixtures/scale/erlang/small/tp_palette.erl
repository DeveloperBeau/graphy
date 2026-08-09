-module(tp_palette).
-export([paint/2]).

paint(plain, Text) -> Text;
paint(bright, Text) -> "*" ++ Text ++ "*".
