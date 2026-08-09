-module(tp_main).
-export([main/1]).
-import(tp_args, [parse/1, width/1, heading/1]).
-import(tp_writer, [render/3, emit/1]).

main(Args) ->
    Opts = parse(Args),
    Doc = tp_document:from_lines(heading(Opts), ["alpha", "beta", "gamma"]),
    emit(render(bright, width(Opts), Doc)).
