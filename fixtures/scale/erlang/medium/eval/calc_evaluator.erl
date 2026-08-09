-module(calc_evaluator).
-export([eval/2]).
-import(calc_env, [lookup_var/2]).
-import(fn_registry, [dispatch/2]).

eval(_Env, {lit, N}) -> N;
eval(Env, {var, Name}) -> lookup_var(Env, Name);
eval(Env, {call, Fn, Args}) ->
    dispatch(Fn, [eval(Env, A) || A <- Args]);
eval(Env, {binop, Op, L, R}) ->
    apply_op(Op, eval(Env, L), eval(Env, R)).

apply_op($+, A, B) -> A + B;
apply_op($-, A, B) -> A - B;
apply_op($*, A, B) -> A * B;
apply_op($^, A, B) -> math:pow(A, B);
apply_op($/, _A, B) when B == 0 -> 0.0;
apply_op($/, A, B) -> A / B.
