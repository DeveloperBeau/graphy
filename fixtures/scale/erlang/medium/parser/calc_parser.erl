-module(calc_parser).
-export([parse/1]).
-import(calc_ast, [lit/1, var/1, binop/3, call/2]).
-import(calc_precedence, [level/1]).

parse(Tokens) ->
    {Expr, _Rest} = expr(Tokens, 0),
    Expr.

expr(Tokens, MinP) ->
    {Lhs, Rest} = atom_expr(Tokens),
    climb(Lhs, Rest, MinP).

climb(Lhs, [{op, O} | Rest], MinP) ->
    case level(O) >= MinP of
        true ->
            {Rhs, Rest2} = expr(Rest, level(O) + 1),
            climb(binop(O, Lhs, Rhs), Rest2, MinP);
        false ->
            {Lhs, [{op, O} | Rest]}
    end;
climb(Lhs, Tokens, _MinP) -> {Lhs, Tokens}.

atom_expr([{num, N} | Rest]) -> {lit(N), Rest};
atom_expr([{ident, Name}, lparen | Rest]) ->
    {Args, Rest2} = args(Rest, []),
    {call(Name, Args), Rest2};
atom_expr([{ident, Name} | Rest]) -> {var(Name), Rest};
atom_expr(Tokens) -> {lit(0), Tokens}.

args([rparen | Rest], Acc) -> {lists:reverse(Acc), Rest};
args(Tokens, Acc) ->
    {E, Rest} = expr(Tokens, 0),
    case Rest of
        [comma | More] -> args(More, [E | Acc]);
        [rparen | More] -> {lists:reverse([E | Acc]), More};
        _ -> {lists:reverse([E | Acc]), Rest}
    end.
