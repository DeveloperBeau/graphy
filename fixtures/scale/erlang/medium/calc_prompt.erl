-module(calc_prompt).
-export([banner/0, ps1/1]).

banner() -> "calc - type an expression".

ps1(N) -> "[" ++ integer_to_list(N) ++ "] > ".
