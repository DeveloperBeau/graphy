module AtanFn

# Inverse tangent.

export calc_atan

function calc_atan(x::Float64)
    isnan(x) && return NaN
    return atan(x)
end

function atan_table(xs::Vector{Float64})
    return [calc_atan(x) for x in xs]
end

end
