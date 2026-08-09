-module(tp_box).
-export([draw/3]).
-import(tp_line, [rule/2, framed/3]).
-import(tp_align, [align/3]).

draw(Style, Width, Doc) ->
    Title = tp_document:doc_title(Doc),
    Rows = tp_document:rows(Doc),
    [rule(Style, Width),
     framed(Style, Width, align(center, Width, Title)),
     rule(Style, Width)]
    ++ [framed(Style, Width, align(left, Width, R)) || R <- Rows]
    ++ [rule(Style, Width)].
