-module(tp_writer).
-export([render/3, emit/1]).
-import(tp_box, [draw/3]).
-import(tp_palette, [paint/2]).

render(Palette, Width, Doc) ->
    [paint(Palette, Line) || Line <- draw(rounded, Width, Doc)].

emit(Lines) ->
    lists:foreach(fun(L) -> io:format("~s~n", [L]) end, Lines).
