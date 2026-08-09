module CiphBench

include("core/Log.jl")
include("core/Config.jl")
include("core/Args.jl")
include("core/Timer.jl")
include("core/Corpus.jl")
include("core/Store.jl")
include("core/Csv.jl")
include("core/Progress.jl")
include("core/Registry.jl")
include("core/Format.jl")
include("core/Report.jl")
include("core/Summary.jl")
include("ciphers/IndexShift.jl")
include("ciphers/IndexVigenere.jl")
include("ciphers/IndexStream.jl")
include("ciphers/IndexTransposition.jl")
include("ciphers/IndexHash.jl")
include("ciphers/RegisterAll.jl")
include("core/Run.jl")

using .BenchRun
using .BenchReport
using .CipherTables

export run_cli

function run_cli(args::Vector{String})
    command = isempty(args) ? "help" : args[1]
    CipherTables.register_everything()
    command == "run" && return BenchRun.bench_all()
    command == "report" && return BenchReport.report_summary()
    command == "verify" && return BenchRun.verify_all()
    println("usage: ciphbench <run|report|verify>")
end

end
