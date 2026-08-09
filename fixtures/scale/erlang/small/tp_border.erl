-module(tp_border).
-export([horizontal/1, vertical/1]).

horizontal(heavy) -> $=;
horizontal(_Style) -> $-.

vertical(_Style) -> $|.
