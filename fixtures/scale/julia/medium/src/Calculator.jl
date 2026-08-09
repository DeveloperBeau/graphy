module Calculator

include("Errors.jl")
include("Config.jl")
include("Constants.jl")
include("Tokens.jl")
include("Scanner.jl")
include("Ops.jl")
include("Parser.jl")
include("Eval.jl")
include("History.jl")
include("Memory.jl")
include("Format.jl")
include("Registry.jl")
include("functions/Index.jl")
include("Repl.jl")

using .Eval
using .Format
using .Repl

export run_calc

function print_usage()
    println("usage: calc [-e EXPR] [--repl]")
end

function run_calc(args::Vector{String})
    if length(args) >= 2 && args[1] == "-e"
        println(Format.fmt_result(Eval.eval_expr(args[2])))
    elseif !isempty(args) && args[1] == "--repl"
        Repl.repl_loop()
    else
        print_usage()
    end
end

end
