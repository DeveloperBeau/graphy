-module(calc_scanner).
-export([scan/1]).
-import(calc_charclass, [is_digit/1, is_alpha/1, is_space/1]).
-import(calc_token, [num/1, ident/1, op/1]).

scan([]) -> [];
scan([C | Rest]) ->
    case classify(C) of
        space -> scan(Rest);
        lparen -> [lparen | scan(Rest)];
        rparen -> [rparen | scan(Rest)];
        comma -> [comma | scan(Rest)];
        digit ->
            {Digits, More} = lists:splitwith(fun(D) -> is_digit(D) end, [C | Rest]),
            [num(list_to_integer(Digits)) | scan(More)];
        alpha ->
            {Word, More} = lists:splitwith(fun(A) -> is_alpha(A) end, [C | Rest]),
            [ident(Word) | scan(More)];
        other -> [op(C) | scan(Rest)]
    end.

classify(C) when C =:= 40 -> lparen;
classify(C) when C =:= 41 -> rparen;
classify(C) when C =:= 44 -> comma;
classify(C) ->
    case is_space(C) of
        true -> space;
        false ->
            case is_digit(C) of
                true -> digit;
                false ->
                    case is_alpha(C) of
                        true -> alpha;
                        false -> other
                    end
            end
    end.
