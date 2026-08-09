module BenchReport

using ..BenchStore
using ..BenchLog

export report_summary

function report_line(row::String)
    return "  " * replace(row, "\",\"" => "  ")
end

function report_summary()
    path = BenchStore.results_path()
    if !isfile(path)
        BenchLog.log_warn("no results at", path)
        return
    end
    println("results from ", path, ":")
    for row in eachline(path)
        println(report_line(row))
    end
end

end
