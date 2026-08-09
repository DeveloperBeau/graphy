module TextPrint

include("Log.jl")
include("Config.jl")
include("Colors.jl")
include("Align.jl")
include("Wrap.jl")
include("Border.jl")
include("Style.jl")
include("Banner.jl")
include("ListCmd.jl")
include("TableCmd.jl")

using .Config
using .Banner
using .ListCmd
using .TableCmd

export run_textprint

function print_usage()
    println("usage: textprint <banner|list|table> [args...]")
end

function run_textprint(args::Vector{String})
    command = isempty(args) ? "help" : args[1]
    rest = length(args) > 1 ? args[2:end] : String[]
    if command == "banner"
        Banner.cmd_banner(join(rest, " "))
    elseif command == "list"
        ListCmd.cmd_list(rest)
    elseif command == "table"
        TableCmd.cmd_table(rest)
    else
        print_usage()
    end
end

end
