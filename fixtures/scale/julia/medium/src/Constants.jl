module Constants

export constant_get, constant_names

const TABLE = Dict("pi" => pi, "e" => exp(1.0), "tau" => 2pi)

function constant_get(name::String)
    haskey(TABLE, name) || error("unknown constant $name")
    return TABLE[name]
end

function constant_names()
    return collect(keys(TABLE))
end

end
