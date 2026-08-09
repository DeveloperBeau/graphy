-module(calc_ast).
-export([lit/1, var/1, binop/3, call/2]).

lit(N) -> {lit, N}.

var(Name) -> {var, Name}.

binop(Op, L, R) -> {binop, Op, L, R}.

call(Fn, Args) -> {call, Fn, Args}.
