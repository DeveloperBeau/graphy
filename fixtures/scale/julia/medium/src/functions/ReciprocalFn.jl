module ReciprocalFn

# Multiplicative inverse.

export calc_reciprocal

function calc_reciprocal(x::Float64)
    isnan(x) && return NaN
    return 1 / x
end

function reciprocal_table(xs::Vector{Float64})
    return [calc_reciprocal(x) for x in xs]
end

end
