#!/usr/bin/env julia
# calc - floating point expression calculator with a function library.

include("src/Calculator.jl")

using .Calculator

function main_cli()
    Calculator.run_calc(ARGS)
end

main_cli()
