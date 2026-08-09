-module(calc_repl).
-export([step/3, eval_line/2]).
-import(calc_scanner, [scan/1]).
-import(calc_parser, [parse/1]).
-import(calc_evaluator, [eval/2]).
-import(calc_output, [format_number/1]).
-import(calc_history, [record/3]).

eval_line(Env, Line) -> eval(Env, parse(scan(Line))).

step(Env, Line, Hist) ->
    Value = eval_line(Env, Line),
    {format_number(Value), record(Line, Value, Hist)}.
