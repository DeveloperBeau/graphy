-module(fn_registry).
-export([dispatch/2, names/0, known/1]).

dispatch("sqrt", Args) -> fn_sqrt:apply(Args);
dispatch("sin", Args) -> fn_sin:apply(Args);
dispatch("cos", Args) -> fn_cos:apply(Args);
dispatch("pow", Args) -> fn_pow:apply(Args);
dispatch("abs", Args) -> fn_abs:apply(Args);
dispatch("ln", Args) -> fn_ln:apply(Args);
dispatch(_, _) -> 0.0.

names() ->
    ["sqrt", "cbrt", "abs", "sign", "floor", "ceil", "round", "trunc", "exp", "ln", "log10", "log2", "sin", "cos", "tan", "asin", "acos", "atan", "sinh", "cosh", "tanh", "neg", "pow", "hypot", "gcd", "lcm", "max", "min", "avg", "mod"].

known(Name) -> lists:member(Name, names()).
