module SqrtFn

# Square root.

export calc_sqrt

function calc_sqrt(x::Float64)
    isnan(x) && return NaN
    return sqrt(x)
end

function sqrt_table(xs::Vector{Float64})
    return [calc_sqrt(x) for x in xs]
end

end
