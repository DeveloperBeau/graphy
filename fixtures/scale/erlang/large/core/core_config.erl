-module(core_config).
-export([defaults/0, iterations/1, results_path/1]).

defaults() -> {config, 100, "results.log", true}.

iterations({config, N, _Path, _Verbose}) -> N.

results_path({config, _N, Path, _Verbose}) -> Path.
