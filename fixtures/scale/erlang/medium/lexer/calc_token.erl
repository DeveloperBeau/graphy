-module(calc_token).
-export([num/1, ident/1, op/1, kind/1]).

num(N) -> {num, N}.

ident(Name) -> {ident, Name}.

op(C) -> {op, C}.

kind({num, _}) -> num;
kind({ident, _}) -> ident;
kind({op, _}) -> op;
kind(T) when is_atom(T) -> T.
