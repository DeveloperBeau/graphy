#!/usr/bin/env julia
# ciphbench - throughput and round-trip checks for toy ciphers.

include("src/CiphBench.jl")

using .CiphBench

function main_cli()
    CiphBench.run_cli(ARGS)
end

main_cli()
