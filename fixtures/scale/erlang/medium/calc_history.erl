-module(calc_history).
-export([record/3, recent/2]).

record(Src, Val, Entries) -> [{entry, Src, Val} | Entries].

recent(N, Entries) -> lists:sublist(Entries, N).
