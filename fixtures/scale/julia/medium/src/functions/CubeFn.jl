module CubeFn

# Third power.

export calc_cube

function calc_cube(x::Float64)
    isnan(x) && return NaN
    return x * x * x
end

function cube_table(xs::Vector{Float64})
    return [calc_cube(x) for x in xs]
end

end
