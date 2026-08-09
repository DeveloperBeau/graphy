module BenchArgs

export option_get, option_set

const OPTIONS = Dict{String, Int}("rounds" => 16, "sample_size" => 512)

function option_get(name::String)
    haskey(OPTIONS, name) || error("unknown option $name")
    return OPTIONS[name]
end

function option_set(name::String, value::Int)
    OPTIONS[name] = value
end

end
