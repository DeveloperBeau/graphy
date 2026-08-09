-module(tp_pad).
-export([pad_to/2, blank/1]).

pad_to(Width, Text) when length(Text) >= Width -> lists:sublist(Text, Width);
pad_to(Width, Text) -> Text ++ lists:duplicate(Width - length(Text), 32).

blank(Width) -> lists:duplicate(Width, 32).
