module BenchStore

export store_init, store_append, results_path

function results_path()
    path = get(ENV, "CIPHBENCH_RESULTS", "")
    return isempty(path) ? "results.csv" : path
end

function store_init()
    open(results_path(), "w") do io
        nothing
    end
end

function store_append(row::String)
    open(results_path(), "a") do io
        println(io, row)
    end
end

end
