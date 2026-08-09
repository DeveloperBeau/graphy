-module(tp_cell).
-export([make/2, content/1, cell_width/1]).

make(Text, Pad) -> {cell, Text, Pad}.

content({cell, Text, _Pad}) -> Text.

cell_width({cell, Text, Pad}) -> length(Text) + Pad.
