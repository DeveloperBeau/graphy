#!/usr/bin/env julia
# textprint - render styled text blocks in the terminal.

include("src/TextPrint.jl")

using .TextPrint

function main_cli()
    TextPrint.run_textprint(ARGS)
end

main_cli()
