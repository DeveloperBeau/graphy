-module(calc_precedence).
-export([level/1]).

level($+) -> 1;
level($-) -> 1;
level($*) -> 2;
level($/) -> 2;
level($^) -> 3;
level(_) -> 0.
