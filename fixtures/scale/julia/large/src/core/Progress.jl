module BenchProgress

export progress_start, progress_tick, progress_done

const STATE = Dict{String, Int}("total" => 0, "done" => 0)

function progress_start(total::Int)
    STATE["total"] = total
    STATE["done"] = 0
end

function progress_tick(label::String)
    STATE["done"] += 1
    print(stderr, "\r[", STATE["done"], "/", STATE["total"], "] ", label)
end

function progress_done()
    print(stderr, "\r", " "^60, "\r")
end

end
