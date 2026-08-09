module TanFn

# Tangent.

export calc_tan

function calc_tan(x::Float64; degrees::Bool = false)
    v = degrees ? x * pi / 180 : x
    return tan(v)
end

function tan_table(xs::Vector{Float64})
    return [calc_tan(x) for x in xs]
end

end
