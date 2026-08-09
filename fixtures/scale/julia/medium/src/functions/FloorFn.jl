module FloorFn

# Round toward negative infinity.

export calc_floor

function calc_floor(x::Float64)
    isnan(x) && return NaN
    return floor(x)
end

function floor_table(xs::Vector{Float64})
    return [calc_floor(x) for x in xs]
end

end
