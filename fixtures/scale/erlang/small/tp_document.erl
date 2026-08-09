-module(tp_document).
-export([from_lines/2, doc_title/1, rows/1]).
-import(tp_cell, [make/2, content/1]).

from_lines(Title, Lines) ->
    {document, Title, [make(L, 2) || L <- Lines]}.

doc_title({document, Title, _Cells}) -> Title.

rows({document, _Title, Cells}) -> [content(C) || C <- Cells].
